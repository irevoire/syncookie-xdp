#ifndef _PARSER_H_
#define _PARSER_H_

#include "headers.h"

static __always_inline int parse_ether(struct hdr_cursor *nh,
                                         void *data_end,
					 struct ethernet_t **etherhdr)
{
	struct ethernet_t *ptr = nh->pos;

	if (ptr + 1 > data_end)
		return -1;

	nh->pos = ptr + 1;

	if (etherhdr != NULL)
		*etherhdr = ptr;

	return ptr->ether_type;
}

static __always_inline int parse_ipv4(struct hdr_cursor *nh,
                                         void *data_end,
					 struct ipv4_t **iphdr)
{
	struct ipv4_t *ptr = nh->pos;

	if (ptr + 1 > data_end)
		return -1;

	nh->pos = ptr + 1;

	if (iphdr != NULL)
		*iphdr = ptr;

	return ptr->protocol;
}

static __always_inline int parse_tcphdr(struct hdr_cursor *nh,
                                         void *data_end,
					 struct tcp_t **tcphdr)
{
	struct tcp_t *tcph = nh->pos;

	if (tcph + 1 > data_end)
		return -1;

	nh->pos = tcph + 1;

	if (tcphdr != NULL)
		*tcphdr = tcph;

	return 0; // no next header
}

#endif /* _PARSER_H_*/
