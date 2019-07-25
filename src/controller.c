static inline __u32 compute_connection(struct ipv4_t *ip, struct tcp_t *tcp) {
	connection = ip.srcAddr;
	connection <<= 32;
	connection |= ip.dstAddr;
	connection <<= 16;
	connection |= tcp.srcPort;
	connection <<= 16;
	connection |= tcp.dstPort;
}

void controller(struct ipv4_t *ip, struct tcp_t *tcp)
{
	lala
	__u32 connection = compute_connection(ip, tcp);
	// TODO here we should check if we already got this connection
	compute_cookie(ip, tcp);

	// you won't steal my cookie!
	// if SYN-ACK or any other flags, drop
	if (tcp.syn == 1 && tcp.ack == 1 ||
			tcp.res == 1 || tcp.cwr == 1 ||
			tcp.ece == 1 || tcp.urg == 1 ||
			tcp.psh == 1 || tcp.rst == 1 ||
			tcp.fin == 1)
		return XDP_DROP;
	// we should get a syn
	else if (tcp.syn == 1)
		handle_syn();
	// or has the communication already started?
	else if ( (tcp.ack == 1) &&
			((tcp.ackNo - 1) == meta.cookie))
		handle_ack();
	return XDP_PASS;
}
