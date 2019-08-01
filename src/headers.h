#ifndef _HEADERS_H_
#define _HEADERS_H_

#define NULL ((void *) 0)

struct connection_t {
	__u32 src_addr;
	__u32 dst_addr;
	__u16 src_port;
	__u16 dst_port;
};

/* Header cursor to keep track of current parsing position */
struct hdr_cursor {
        void *pos;
};

// In this file we declare all the base structure we will need in order to
// make our syncookie
// All the structures must be packed to ensure there is no padding

struct __attribute__((__packed__)) ethernet_t {
	__u8 dst_addr[6]; // 6 bytes
	__u8 src_addr[6]; // 6 bytes
	__u16 ether_type; // 2 bytes
};

struct __attribute__((__packed__)) ipv4_t {
	unsigned version : 4;
	unsigned ihl: 4;
	unsigned dscp: 6;
	unsigned ecn: 2;
	unsigned total_len: 16;
	unsigned identification: 16;
	unsigned flags: 3;
	unsigned frag_offset: 13;
	unsigned ttl: 8;
	unsigned protocol: 8;
	unsigned hdr_checksum: 16;
	unsigned src_addr: 32;
	unsigned dst_addr: 32;
};

struct __attribute__((__packed__)) tcp_t {
	unsigned src_port: 16;
	unsigned dst_port: 16;
	unsigned seq_no: 32;
	unsigned ack_no: 32; // will carry the cookie
	unsigned data_offset: 4;
	unsigned res: 4;
	unsigned cwr: 1;
	unsigned ece: 1;
	unsigned urg: 1;
	unsigned ack: 1;
	unsigned psh: 1;
	unsigned rst: 1;
	unsigned syn: 1;
	unsigned fin: 1;
	unsigned window: 16;
	unsigned checksum: 16;
	unsigned urgent_ptr: 16;
};

struct headers_t {
	struct ethernet_t *ether;
	struct ipv4_t *ipv4;
	struct tcp_t *tcp;
};

#endif /* _HEADERS_H_ */
