#include <linux/bpf.h>
// #include <linux/if_packet.h>
#include <linux/if_ether.h>
#include <linux/in.h>
#include <linux/tcp.h>
#include <linux/udp.h>

#include "bpf_helpers.h"
#include "bpf_endian.h"

/* Defines xdp_stats_map */
#include "../common/xdp_stats_kern_user.h"
#include "../common/xdp_stats_kern.h"

#include "headers.h"
#include "parser.h"

// tries are the best data structure to store a lot of ip adderess
struct bpf_map_def SEC("maps") connections_table = {
	.type        = BPF_MAP_TYPE_LPM_TRIE,
	.key_size    = sizeof(struct connection_t),
	.value_size  = sizeof(char),
	.max_entries = 1000, // fix this number
};

#include "controller.c" // I have no idea on how the linkage works here so I include the .c

SEC("syncookie")
int syncookie(struct xdp_md *ctx)
{
	void *data_end = (void *)(long)ctx->data_end;
	void *data = (void *)(long)ctx->data;

	struct ethernet_t *eth = NULL;
	struct ipv4_t *ip = NULL;
	struct tcp_t *tcp = NULL;

	struct hdr_cursor nh;
	int nh_type;
	nh.pos = data;

	nh_type = parse_ether(&nh, data_end, &eth);

	if (nh_type == ETH_P_IP) {
		nh_type = parse_ipv4(&nh, data_end, NULL);
		if (nh_type == IPPROTO_TCP)
			goto parse_tcp;
	}
	goto out;
parse_tcp:
	parse_tcphdr(&nh, data_end, &tcp);
	controller(ip, tcp);
	goto out;
out:
	return XDP_PASS;
}


char _license[] SEC("license") = "GPL";
