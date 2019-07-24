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

	return 0; // no next header
}

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

	return 0; // no next header
}

#endif /* _PARSER_H_*/
