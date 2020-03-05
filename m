Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C04917A84E
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2020 15:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgCEO5P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Mar 2020 09:57:15 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:35788 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgCEO5O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Mar 2020 09:57:14 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j9rvy-001JyE-Qq; Thu, 05 Mar 2020 15:57:10 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Bob Copeland <me@bobcopeland.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4/4] wmediumd: add vhost-user support
Date:   Thu,  5 Mar 2020 15:56:55 +0100
Message-Id: <20200305155407.69f291a965c4.I7daa3df133d43910c3ecd5cd67667c3176ee0f6f@changeid>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305145655.67427-1-johannes@sipsolutions.net>
References: <20200305145655.67427-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Add support for listening on a vhost-user socket, which can
then be used e.g. together with user-mode-linux or qemu/kvm
and hwsim running inside a virtual machine.

It also supports a combination of local (netlink) and vhost-
user, just because we can :-)

---
 wmediumd/config.c   |   4 +-
 wmediumd/wmediumd.c | 201 +++++++++++++++++++++++++++++++++-----------
 wmediumd/wmediumd.h |  23 +++++
 3 files changed, 177 insertions(+), 51 deletions(-)

diff --git a/wmediumd/config.c b/wmediumd/config.c
index 971493780568..c9a6f5ca9ca0 100644
--- a/wmediumd/config.c
+++ b/wmediumd/config.c
@@ -438,7 +438,7 @@ int load_config(struct wmediumd *ctx, const char *file, const char *per_file)
 	w_logf(ctx, LOG_NOTICE, "#_if = %d\n", count_ids);
 
 	/* Fill the mac_addr */
-	ctx->sta_array = malloc(sizeof(struct station *) * count_ids);
+	ctx->sta_array = calloc(count_ids, sizeof(struct station *));
 	if (!ctx->sta_array) {
 		w_flogf(ctx, LOG_ERR, stderr, "Out of memory(sta_array)!\n");
 		return -ENOMEM;
@@ -448,7 +448,7 @@ int load_config(struct wmediumd *ctx, const char *file, const char *per_file)
 		const char *str =  config_setting_get_string_elem(ids, i);
 		string_to_mac_address(str, addr);
 
-		station = malloc(sizeof(*station));
+		station = calloc(1, sizeof(*station));
 		if (!station) {
 			w_flogf(ctx, LOG_ERR, stderr, "Out of memory!\n");
 			return -ENOMEM;
diff --git a/wmediumd/wmediumd.c b/wmediumd/wmediumd.c
index 70979fca09d4..8fb0ed49bbb1 100644
--- a/wmediumd/wmediumd.c
+++ b/wmediumd/wmediumd.c
@@ -38,6 +38,7 @@
 #include <usfstl/loop.h>
 #include <usfstl/sched.h>
 #include <usfstl/schedctrl.h>
+#include <usfstl/vhost.h>
 
 #include "wmediumd.h"
 #include "ieee80211.h"
@@ -47,6 +48,12 @@ USFSTL_SCHEDULER(scheduler);
 
 static void wmediumd_deliver_frame(struct usfstl_job *job);
 
+enum {
+	HWSIM_VQ_TX,
+	HWSIM_VQ_RX,
+	HWSIM_NUM_VQS,
+};
+
 static inline int div_round(int a, int b)
 {
 	return (a + b - 1) / b;
@@ -361,6 +368,8 @@ void queue_frame(struct wmediumd *ctx, struct station *station,
 	target += send_time;
 
 	frame->duration = send_time;
+	frame->dest = deststa ? deststa->client : NULL;
+	frame->src = station->client;
 	frame->job.start = target;
 	frame->job.callback = wmediumd_deliver_frame;
 	frame->job.data = ctx;
@@ -369,26 +378,44 @@ void queue_frame(struct wmediumd *ctx, struct station *station,
 	list_add_tail(&frame->list, &queue->frames);
 }
 
+static void wmediumd_send_to_client(struct wmediumd *ctx,
+				    struct client *client,
+				    struct nl_msg *msg)
+{
+	size_t len;
+	int ret;
+
+	switch (client->type) {
+	case CLIENT_NETLINK:
+		ret = nl_send_auto_complete(ctx->sock, msg);
+		if (ret < 0)
+			w_logf(ctx, LOG_ERR, "%s: nl_send_auto failed\n", __func__);
+		break;
+	case CLIENT_VHOST_USER:
+		len = nlmsg_total_size(nlmsg_datalen(nlmsg_hdr(msg)));
+		usfstl_vhost_user_dev_notify(client->dev, HWSIM_VQ_RX,
+					     (void *)nlmsg_hdr(msg), len);
+		break;
+	}
+}
+
 /*
  * Report transmit status to the kernel.
  */
-static int send_tx_info_frame_nl(struct wmediumd *ctx, struct frame *frame)
+static void send_tx_info_frame_nl(struct wmediumd *ctx, struct frame *frame)
 {
-	struct nl_sock *sock = ctx->sock;
 	struct nl_msg *msg;
-	int ret;
 
 	msg = nlmsg_alloc();
 	if (!msg) {
 		w_logf(ctx, LOG_ERR, "Error allocating new message MSG!\n");
-		return -1;
+		return;
 	}
 
 	if (genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, ctx->family_id,
 			0, NLM_F_REQUEST, HWSIM_CMD_TX_INFO_FRAME,
 			VERSION_NR) == NULL) {
 		w_logf(ctx, LOG_ERR, "%s: genlmsg_put failed\n", __func__);
-		ret = -1;
 		goto out;
 	}
 
@@ -401,45 +428,34 @@ static int send_tx_info_frame_nl(struct wmediumd *ctx, struct frame *frame)
 		    frame->tx_rates) ||
 	    nla_put_u64(msg, HWSIM_ATTR_COOKIE, frame->cookie)) {
 		w_logf(ctx, LOG_ERR, "%s: Failed to fill a payload\n", __func__);
-		ret = -1;
 		goto out;
 	}
 
-	ret = nl_send_auto_complete(sock, msg);
-	if (ret < 0) {
-		w_logf(ctx, LOG_ERR, "%s: nl_send_auto failed\n", __func__);
-		ret = -1;
-		goto out;
-	}
-	ret = 0;
+	wmediumd_send_to_client(ctx, frame->src, msg);
 
 out:
 	nlmsg_free(msg);
-	return ret;
 }
 
 /*
  * Send a data frame to the kernel for reception at a specific radio.
  */
-int send_cloned_frame_msg(struct wmediumd *ctx, struct station *dst,
-			  u8 *data, int data_len, int rate_idx, int signal,
-			  int freq)
+static void send_cloned_frame_msg(struct wmediumd *ctx, struct station *dst,
+				  u8 *data, int data_len, int rate_idx,
+				  int signal, int freq)
 {
 	struct nl_msg *msg;
-	struct nl_sock *sock = ctx->sock;
-	int ret;
 
 	msg = nlmsg_alloc();
 	if (!msg) {
 		w_logf(ctx, LOG_ERR, "Error allocating new message MSG!\n");
-		return -1;
+		return;
 	}
 
 	if (genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, ctx->family_id,
 			0, NLM_F_REQUEST, HWSIM_CMD_FRAME,
 			VERSION_NR) == NULL) {
 		w_logf(ctx, LOG_ERR, "%s: genlmsg_put failed\n", __func__);
-		ret = -1;
 		goto out;
 	}
 
@@ -450,24 +466,23 @@ int send_cloned_frame_msg(struct wmediumd *ctx, struct station *dst,
 	    nla_put_u32(msg, HWSIM_ATTR_FREQ, freq) ||
 	    nla_put_u32(msg, HWSIM_ATTR_SIGNAL, -50)) {
 		w_logf(ctx, LOG_ERR, "%s: Failed to fill a payload\n", __func__);
-		ret = -1;
 		goto out;
 	}
 
 	w_logf(ctx, LOG_DEBUG, "cloned msg dest " MAC_FMT " (radio: " MAC_FMT ") len %d\n",
 		   MAC_ARGS(dst->addr), MAC_ARGS(dst->hwaddr), data_len);
 
-	ret = nl_send_auto_complete(sock, msg);
-	if (ret < 0) {
-		w_logf(ctx, LOG_ERR, "%s: nl_send_auto failed\n", __func__);
-		ret = -1;
-		goto out;
+	if (dst->client) {
+		wmediumd_send_to_client(ctx, dst->client, msg);
+	} else {
+		struct client *client;
+
+		list_for_each_entry(client, &ctx->clients, list)
+			wmediumd_send_to_client(ctx, client, msg);
 	}
-	ret = 0;
 
 out:
 	nlmsg_free(msg);
-	return ret;
 }
 
 void wmediumd_deliver_frame(struct usfstl_job *job)
@@ -587,9 +602,10 @@ int nl_err_cb(struct sockaddr_nl *nla, struct nlmsgerr *nlerr, void *arg)
  * Handle events from the kernel.  Process CMD_FRAME events and queue them
  * for later delivery with the scheduler.
  */
-static int process_messages_cb(struct nl_msg *msg, void *arg)
+static void _process_messages(struct nl_msg *msg,
+			      struct wmediumd *ctx,
+			      struct client *client)
 {
-	struct wmediumd *ctx = arg;
 	struct nlattr *attrs[HWSIM_ATTR_MAX+1];
 	/* netlink header */
 	struct nlmsghdr *nlh = nlmsg_hdr(msg);
@@ -627,18 +643,20 @@ static int process_messages_cb(struct nl_msg *msg, void *arg)
 			src = hdr->addr2;
 
 			if (data_len < 6 + 6 + 4)
-				goto out;
+				return;
 
 			sender = get_station_by_addr(ctx, src);
 			if (!sender) {
 				w_flogf(ctx, LOG_ERR, stderr, "Unable to find sender station " MAC_FMT "\n", MAC_ARGS(src));
-				goto out;
+				return;
 			}
 			memcpy(sender->hwaddr, hwaddr, ETH_ALEN);
+			if (!sender->client)
+				sender->client = client;
 
 			frame = calloc(1, sizeof(*frame) + data_len);
 			if (!frame)
-				goto out;
+				return;
 
 			memcpy(frame->data, data, data_len);
 			frame->data_len = data_len;
@@ -653,10 +671,64 @@ static int process_messages_cb(struct nl_msg *msg, void *arg)
 			queue_frame(ctx, sender, frame);
 		}
 	}
-out:
+}
+
+static int process_messages_cb(struct nl_msg *msg, void *arg)
+{
+	struct wmediumd *ctx = arg;
+
+	_process_messages(msg, ctx, &ctx->nl_client);
 	return 0;
 }
 
+static void wmediumd_vu_connected(struct usfstl_vhost_user_dev *dev)
+{
+	struct wmediumd *ctx = dev->server->data;
+	struct client *client;
+
+	client = calloc(1, sizeof(*client));
+	dev->data = client;
+	client->type = CLIENT_VHOST_USER;
+	client->dev = dev;
+	list_add(&client->list, &ctx->clients);
+}
+
+static void wmediumd_vu_handle(struct usfstl_vhost_user_dev *dev,
+			       struct usfstl_vhost_user_buf *buf,
+			       unsigned int vring)
+{
+	struct nl_msg *nlmsg;
+	char data[4096];
+	size_t len;
+
+	len = iov_read(data, sizeof(data), buf->out_sg, buf->n_out_sg);
+
+	if (!nlmsg_ok((const struct nlmsghdr *)data, len))
+		return;
+	nlmsg = nlmsg_convert((struct nlmsghdr *)data);
+	if (!nlmsg)
+		return;
+
+	_process_messages(nlmsg, dev->server->data, dev->data);
+
+	nlmsg_free(nlmsg);
+}
+
+static void wmediumd_vu_disconnected(struct usfstl_vhost_user_dev *dev)
+{
+	struct client *client = dev->data;
+
+	dev->data = NULL;
+	list_del(&client->list);
+	free(client);
+}
+
+static const struct usfstl_vhost_user_ops wmediumd_vu_ops = {
+	.connected = wmediumd_vu_connected,
+	.handle = wmediumd_vu_handle,
+	.disconnected = wmediumd_vu_disconnected,
+};
+
 /*
  * Register with the kernel to start receiving new frames.
  */
@@ -760,6 +832,8 @@ void print_help(int exval)
 	printf("  -c FILE         set input config file\n");
 	printf("  -x FILE         set input PER file\n");
 	printf("  -t socket       set the time control socket\n");
+	printf("  -u socket       expose vhost-user socket, don't use netlink\n");
+	printf("  -n              force netlink use even with vhost-user\n");
 
 	exit(exval);
 }
@@ -772,6 +846,15 @@ int main(int argc, char *argv[])
 	char *per_file = NULL;
 	const char *time_socket = NULL;
 	struct usfstl_sched_ctrl ctrl = {};
+	struct usfstl_vhost_user_server vusrv = {
+		.ops = &wmediumd_vu_ops,
+		.max_queues = HWSIM_NUM_VQS,
+		.input_queues = 1 << HWSIM_VQ_TX,
+		.protocol_features =
+			1ULL << VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS,
+		.data = &ctx,
+	};
+	bool use_netlink, force_netlink = false;
 
 	setvbuf(stdout, NULL, _IOLBF, BUFSIZ);
 
@@ -784,7 +867,7 @@ int main(int argc, char *argv[])
 	unsigned long int parse_log_lvl;
 	char* parse_end_token;
 
-	while ((opt = getopt(argc, argv, "hVc:l:x:t:")) != -1) {
+	while ((opt = getopt(argc, argv, "hVc:l:x:t:u:n")) != -1) {
 		switch (opt) {
 		case 'h':
 			print_help(EXIT_SUCCESS);
@@ -819,6 +902,12 @@ int main(int argc, char *argv[])
 		case 't':
 			time_socket = optarg;
 			break;
+		case 'u':
+			vusrv.socket = optarg;
+			break;
+		case 'n':
+			force_netlink = true;
+			break;
 		case '?':
 			printf("wmediumd: Error - No such option: "
 			       "`%c'\n\n", optopt);
@@ -839,11 +928,15 @@ int main(int argc, char *argv[])
 	w_logf(&ctx, LOG_NOTICE, "Input configuration file: %s\n", config_file);
 
 	INIT_LIST_HEAD(&ctx.stations);
+	INIT_LIST_HEAD(&ctx.clients);
+
 	if (load_config(&ctx, config_file, per_file))
 		return EXIT_FAILURE;
 
+	use_netlink = force_netlink || !vusrv.socket;
+
 	/* init netlink */
-	if (init_netlink(&ctx) < 0)
+	if (use_netlink && init_netlink(&ctx) < 0)
 		return EXIT_FAILURE;
 
 	if (ctx.intf) {
@@ -854,22 +947,32 @@ int main(int argc, char *argv[])
 		usfstl_sched_add_job(&scheduler, &ctx.intf_job);
 	}
 
-	if (time_socket)
+	if (time_socket) {
 		usfstl_sched_ctrl_start(&ctrl, time_socket,
-					1000 /* nsec per usec */,
-					(uint64_t)-1 /* no ID */,
-					&scheduler);
-	else
+				      1000 /* nsec per usec */,
+				      (uint64_t)-1 /* no ID */,
+				      &scheduler);
+		vusrv.scheduler = &scheduler;
+		vusrv.ctrl = &ctrl;
+	} else {
 		usfstl_sched_wallclock_init(&scheduler, 1000);
+	}
+
+	if (vusrv.socket)
+		usfstl_vhost_user_server_start(&vusrv);
+
+	if (use_netlink) {
+		ctx.nl_client.type = CLIENT_NETLINK;
+		list_add(&ctx.nl_client.list, &ctx.clients);
 
-	ctx.nl_loop.handler = sock_event_cb;
-	ctx.nl_loop.data = &ctx;
-	ctx.nl_loop.fd = nl_socket_get_fd(ctx.sock);
-	usfstl_loop_register(&ctx.nl_loop);
+		ctx.nl_loop.handler = sock_event_cb;
+		ctx.nl_loop.data = &ctx;
+		ctx.nl_loop.fd = nl_socket_get_fd(ctx.sock);
+		usfstl_loop_register(&ctx.nl_loop);
 
-	/* register for new frames */
-	if (send_register_msg(&ctx) == 0) {
-		w_logf(&ctx, LOG_NOTICE, "REGISTER SENT!\n");
+		/* register for new frames */
+		if (send_register_msg(&ctx) == 0)
+			w_logf(&ctx, LOG_NOTICE, "REGISTER SENT!\n");
 	}
 
 	while (1) {
diff --git a/wmediumd/wmediumd.h b/wmediumd/wmediumd.h
index 077c17163afc..d4ce3a1df15d 100644
--- a/wmediumd/wmediumd.h
+++ b/wmediumd/wmediumd.h
@@ -144,6 +144,25 @@ struct station {
 	int tx_power;			/* transmission power [dBm] */
 	struct wqueue queues[IEEE80211_NUM_ACS];
 	struct list_head list;
+	struct client *client;
+};
+
+enum client_type {
+	CLIENT_NETLINK,
+	CLIENT_VHOST_USER,
+};
+
+struct client {
+	struct list_head list;
+	enum client_type type;
+
+	/*
+	 * There's no additional data for the netlink client, we
+	 * just have it as such for the link from struct station.
+	 */
+
+	/* for vhost-user */
+	struct usfstl_vhost_user_dev *dev;
 };
 
 struct wmediumd {
@@ -152,6 +171,9 @@ struct wmediumd {
 	struct nl_sock *sock;
 	struct usfstl_loop_entry nl_loop;
 
+	struct list_head clients;
+	struct client nl_client;
+
 	int num_stas;
 	struct list_head stations;
 	struct station **sta_array;
@@ -188,6 +210,7 @@ struct hwsim_tx_rate {
 struct frame {
 	struct list_head list;		/* frame queue list */
 	struct usfstl_job job;
+	struct client *src, *dest;
 	bool acked;
 	u64 cookie;
 	u32 freq;
-- 
2.24.1

