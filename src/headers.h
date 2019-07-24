#ifndef _HEADERS_H_
#define _HEADERS_H_

// In this file we declare all the base structure we will need in order to
// make our syncookie
// All the structures must be packed to ensure there is no padding

struct __attribute__((__packed__)) ethernet_t {
	unsigned dstAddr : 9;   // 6 bytes
	unsigned srcAddr : 9;   // 6 bytes
	unsigned etherType : 16; // 2
};

struct __attribute__((__packed__)) ipv4_t {
	unsigned version : 4;
	unsigned ihl: 4;
	unsigned dscp: 6;
	unsigned ecn: 2;
	unsigned totalLen: 16;
	unsigned identification: 16;
	unsigned flags: 3;
	unsigned fragOffset: 13;
	unsigned ttl: 8;
	unsigned protocol: 8;
	unsigned hdrChecksum: 16;
	unsigned srcAddr: 32;
	unsigned dstAddr: 32;
};

struct __attribute__((__packed__)) tcp_t {
	unsigned srcPort: 16;
	unsigned dstPort: 16;
	unsigned seqNo: 32;
	unsigned ackNo: 32; // will carry the cookie
	unsigned dataOffset: 4;
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
	unsigned urgentPtr: 16;
};

#endif /* _HEADERS_H_ */
