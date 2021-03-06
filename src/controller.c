// Compute a connection: Store the ip src / dst and the tcp port src / dst
// TODO: check if a copy is made when calling this function or if the compiler is able to
// reuse the structure
static inline struct connection_t compute_connection(struct headers_t *hdr) {
	struct connection_t connection = {
		.src_addr = hdr->ipv4->src_addr,
		.dst_addr = hdr->ipv4->dst_addr,
		.src_port = hdr->tcp->src_port,
		.dst_port = hdr->tcp->dst_port,
	};
	return connection;
}

// Should be called upon the reception of a syn paquet.
// Return the paquet on the same interface as a syn ack paquet.
static inline int handle_syn(struct headers_t *hdr, __u32 cookie) {
	// =========== MAC ============
	// swap src / dst addr
	__u8 tmp_addr[6];
	__builtin_memcpy(&tmp_addr, &hdr->ether->src_addr, sizeof(tmp_addr));
	__builtin_memcpy(&hdr->ether->dst_addr, &hdr->ether->src_addr, sizeof(tmp_addr));
	__builtin_memcpy(&tmp_addr, &hdr->ether->dst_addr, sizeof(tmp_addr));

	// =========== IP ============
	// swap src / dst addr
	__u32 ipaddr = hdr->ipv4->src_addr;
	hdr->ipv4->src_addr = hdr->ipv4->dst_addr;
	hdr->ipv4->dst_addr = ipaddr;

	// =========== TCP ============
	// increment seqNo and move it to ackNo
	hdr->tcp->ack_no = hdr->tcp->seq_no + 1;
	// store the cookie into our seqNo
	hdr->tcp->seq_no = cookie;
	// set the tcp flags to SYN-ACK
	hdr->tcp->ack = 1;

	// swap src / dst port
	__u32 tcpport = hdr->tcp->src_port;
	hdr->tcp->src_port = hdr->tcp->dst_port;
	hdr->tcp->dst_port = tcpport;

	// =========== PHY ============
	// send the packet back to the source
	return XDP_TX;
}


// Should be called upon the reception of a ack paquet.
// Save the connection in the bpf table and send back the paquet on the same
// interface as a ack paquet
static inline int handle_ack(struct headers_t *hdr, struct connection_t *connection) {
	// save the connection
	// here we don't have any use of the value associated to the key
	// all we want is to have an entry into the map
	bpf_map_update_elem(&connections_table, &connection, &insert, BPF_ANY);

	// =========== MAC ============
	// swap src / dst addr
	__u8 tmp_addr[6];
	__builtin_memcpy(&tmp_addr, &hdr->ether->src_addr, sizeof(tmp_addr));
	__builtin_memcpy(&hdr->ether->dst_addr, &hdr->ether->src_addr, sizeof(tmp_addr));
	__builtin_memcpy(&tmp_addr, &hdr->ether->dst_addr, sizeof(tmp_addr));

	// =========== IP ============
	// swap src / dst addr
	__u32 ipaddr = hdr->ipv4->src_addr;
	hdr->ipv4->src_addr = hdr->ipv4->dst_addr;
	hdr->ipv4->dst_addr = ipaddr;

	// swap seqNo et ackNo
	__u32 seq_no = hdr->tcp->seq_no;
	hdr->tcp->seq_no = hdr->tcp->ack_no;
	hdr->tcp->ack_no = seq_no + 1;

	// return ack
	hdr->tcp->ack = 1; // useless
	hdr->tcp->syn = 0;

	// swap src / dst port
	__u16 tcpport = hdr->tcp->src_port;
	hdr->tcp->src_port = hdr->tcp->dst_port;
	hdr->tcp->dst_port = tcpport;

	// =========== PHY ============
	// send the packet back to the source
	return XDP_TX;
}

// Compute a cookie for the current connection. Currently we don't save
// any tcp option in the cookie and it is easy to bruteforce
static inline __u32 compute_cookie(struct headers_t *hdr) {
	__u32 auth = 0;
	auth = hdr->tcp->src_port << 16;
	auth |= hdr->tcp->dst_port;
	auth ^= hdr->ipv4->src_addr;
	auth ^= hdr->ipv4->dst_addr;
	return auth;
}

// This fuction control what should happens when a new packet is received
// It check if the connection is already validated. And if not it check the
// tcp flags and call accordingly the `handle_syn` or `handle_ack` function
static inline int controller(struct headers_t *hdr)
{
	struct connection_t connection = compute_connection(hdr);
	char *res = bpf_map_lookup_elem(&connections_table, &connection);
	if (res) // this connection already exist
		return XDP_PASS;

	__u32 cookie = compute_cookie(hdr);

	// you won't steal my cookie!
	// if SYN-ACK or any other flags, drop
	if ((hdr->tcp->syn == 1 && hdr->tcp->ack == 1) ||
			hdr->tcp->res == 1 || hdr->tcp->cwr == 1 ||
			hdr->tcp->ece == 1 || hdr->tcp->urg == 1 ||
			hdr->tcp->psh == 1 || hdr->tcp->rst == 1 ||
			hdr->tcp->fin == 1)
		return XDP_DROP;
	// we should get a syn
	else if (hdr->tcp->syn == 1)
		return handle_syn(hdr, cookie);
	// or has the communication already started?
	else if ( (hdr->tcp->ack == 1) &&
			((hdr->tcp->ack_no - 1) == cookie))
		return handle_ack(hdr, &connection);
	else // should never happens
		return XDP_DROP;
}
