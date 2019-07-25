#include <linux/bpf.h>
#include <linux/in.h>
#include <linux/tcp.h>
#include <linux/udp.h>

#include "bpf_helpers.h"
#include "bpf_endian.h"

// The parsing helper functions from the packet01 lesson have moved here
#include "../common/parsing_helpers.h"

/* Defines xdp_stats_map */
#include "../common/xdp_stats_kern_user.h"
#include "../common/xdp_stats_kern.h"

#include "headers.h"
#include "parser.h"
#include "controller.h"

SEC("syncookie")
int syncookie(struct xdp_md *ctx)
{
	void *data_end = (void *)(long)ctx->data_end;
	void *data = (void *)(long)ctx->data;

	struct tcphdr *tcphdr = NULL;

	struct hdr_cursor nh;
	int nh_type;
	nh.pos = data;

	struct ethhdr *eth;

	nh_type = parse_ethhdr(&nh, data_end, &eth);

	if (nh_type == ETH_P_IP) {
		nh_type = parse_iphdr(&nh, data_end, NULL);
		if (nh_type == IPPROTO_TCP)
			goto parse_tcp;
	}
	goto out;
parse_tcp:
	parse_tcphdr(&nh, data_end, &tcphdr);
	goto out;
out:
	return XDP_PASS;
}


char _license[] SEC("license") = "GPL";
