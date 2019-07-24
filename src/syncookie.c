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

static __always_inline int parse_tcphdr(struct hdr_cursor *nh,
                                         void *data_end,
					 struct tcphdr **tcphdr)
{
	struct tcphdr *tcph = nh->pos;

	if (tcph + 1 > data_end)
		return -1;

	nh->pos = tcph + 1;
	tcph->dest = bpf_htons(bpf_ntohs(tcph->dest) - 1);

	if (tcphdr != NULL)
		*tcphdr = tcph;

	return 0; // no next header
}

static __always_inline int parse_udphdr(struct hdr_cursor *nh,
                                         void *data_end,
					 struct udphdr **udphdr)
{
	struct udphdr *udph = nh->pos;

	if (udph + 1 > data_end)
		return -1;

	nh->pos = udph + 1;
	udph->dest = bpf_htons(bpf_ntohs(udph->dest) - 1);

	if (udphdr != NULL)
		*udphdr = udph;

	return 0; // no next header
}

SEC("syncookie")
int syncookie(struct xdp_md *ctx)
{
	void *data_end = (void *)(long)ctx->data_end;
	void *data = (void *)(long)ctx->data;

	struct tcphdr *tcphdr = NULL;
	struct udphdr *udphdr = NULL;

	struct hdr_cursor nh;
	int nh_type;
        nh.pos = data;

	struct ethhdr *eth;

	nh_type = parse_ethhdr(&nh, data_end, &eth);

        if (nh_type == ETH_P_IPV6) {
                nh_type = parse_ip6hdr(&nh, data_end, NULL);
		switch (nh_type) {
			case IPPROTO_TCP: goto parse_tcp;
			case IPPROTO_UDP: goto parse_udp;
			default: goto out;
		}
        } else if (nh_type == ETH_P_IP) {
                nh_type = parse_iphdr(&nh, data_end, NULL);
		switch (nh_type) {
			case IPPROTO_TCP: goto parse_tcp;
			case IPPROTO_UDP: goto parse_udp;
			default: goto out;
		}
        }
parse_tcp:
	parse_tcphdr(&nh, data_end, &tcphdr);
	goto out;
parse_udp:
	parse_udphdr(&nh, data_end, &udphdr);

out:
	return XDP_PASS;
}


char _license[] SEC("license") = "GPL";
