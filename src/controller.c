struct connection_t {
	__u32 src_addr;
	__u32 dst_addr;
	__u16 src_port;
	__u16 dst_port;
};

// TODO: check if a copy is made when calling this function or if the compiler is able to
// reuse the structure
static inline struct connection_t compute_connection(struct ipv4_t *ip, struct tcp_t *tcp) {
	struct connection_t connection = {
		.src_addr = ip->src_addr,
		.dst_addr = ip->dst_addr,
		.src_port = tcp->src_port,
		.dst_port = tcp->dst_port,
	};
	return connection;
}

static inline void handle_syn() {}
static inline void handle_ack() {}

static inline __u32 compute_cookie(struct ipv4_t *ip, struct tcp_t *tcp) {
		__u32 auth = 0;
		auth = tcp->src_port << 16;
		auth |= tcp->dst_port;
		auth ^= ip->src_addr;
		auth ^= ip->dst_addr;
		return auth;
}

inline int controller(struct ipv4_t *ip, struct tcp_t *tcp)
{
	struct connection_t connection = compute_connection(ip, tcp);
	// TODO here we should check if we already got this connection
	__u32 cookie = compute_cookie(ip, tcp);

	// you won't steal my cookie!
	// if SYN-ACK or any other flags, drop
	if ((tcp->syn == 1 && tcp->ack == 1) ||
			tcp->res == 1 || tcp->cwr == 1 ||
			tcp->ece == 1 || tcp->urg == 1 ||
			tcp->psh == 1 || tcp->rst == 1 ||
			tcp->fin == 1)
		return XDP_DROP;
	// we should get a syn
	else if (tcp->syn == 1)
		handle_syn();
	// or has the communication already started?
	else if ( (tcp->ack == 1) &&
			((tcp->ack_no - 1) == cookie))
		handle_ack();
	return XDP_PASS;
}
