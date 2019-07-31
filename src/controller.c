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

static inline void handle_syn() {}
static inline void handle_ack() {}

static inline __u32 compute_cookie(struct headers_t *hdr) {
	__u32 auth = 0;
	auth = hdr->tcp->src_port << 16;
	auth |= hdr->tcp->dst_port;
	auth ^= hdr->ipv4->src_addr;
	auth ^= hdr->ipv4->dst_addr;
	return auth;
}

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
		handle_syn();
	// or has the communication already started?
	else if ( (hdr->tcp->ack == 1) &&
			((hdr->tcp->ack_no - 1) == cookie))
		handle_ack();
	return XDP_PASS;
}
