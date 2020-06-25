Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90704209F42
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2020 15:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404967AbgFYNJL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jun 2020 09:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404938AbgFYNIz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jun 2020 09:08:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B27C08C5C1
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2020 06:08:55 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1joRcb-00BrnC-Sg; Thu, 25 Jun 2020 15:08:54 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     me@bcopeland.com
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5/9] wmediumd: add a control message to the API socket
Date:   Thu, 25 Jun 2020 15:08:40 +0200
Message-Id: <20200625150754.3fedd2006214.Icb9b997529c82a8b4339fb63f8c798c9b1d9dc4f@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200625130844.22893-1-johannes@sipsolutions.net>
References: <20200625130844.22893-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Add a control message indicating two things:
 * TX start should be notified
 * all RX frames should be sent over

If all RX frames are reported, then we include the
HWSIM_ATTR_COOKIE attribute when reflecting the frame
back to the sender client, so it can identify this
(and which frame it was, if needed.)

---
 wmediumd/api.h      |  36 ++++++++++++++++
 wmediumd/wmediumd.c | 103 ++++++++++++++++++++++++++++++++++++++------
 wmediumd/wmediumd.h |   5 +++
 3 files changed, 130 insertions(+), 14 deletions(-)

diff --git a/wmediumd/api.h b/wmediumd/api.h
index 6ecaa7bd94b9..24e9548defdb 100644
--- a/wmediumd/api.h
+++ b/wmediumd/api.h
@@ -5,6 +5,7 @@
  */
 #ifndef _WMEDIUMD_API_H
 #define _WMEDIUMD_API_H
+#include <stdint.h>
 
 enum wmediumd_message {
 	/* invalid message */
@@ -26,6 +27,15 @@ enum wmediumd_message {
 	 * netlink format, to avoid having a special format
 	 */
 	WMEDIUMD_MSG_NETLINK,
+
+	/* control message, see struct wmediumd_message_control */
+	WMEDIUMD_MSG_SET_CONTROL,
+
+	/*
+	 * Indicates TX start if WMEDIUMD_RX_CTL_NOTIFY_TX_START is set,
+	 * with struct wmediumd_tx_start as the payload.
+	 */
+	WMEDIUMD_MSG_TX_START,
 };
 
 struct wmediumd_message_header {
@@ -38,4 +48,30 @@ struct wmediumd_message_header {
 	uint8_t data[];
 };
 
+enum wmediumd_control_flags {
+	WMEDIUMD_CTL_NOTIFY_TX_START		= 1 << 0,
+	WMEDIUMD_CTL_RX_ALL_FRAMES		= 1 << 1,
+};
+
+struct wmediumd_message_control {
+	uint32_t flags;
+
+	/*
+	 * For compatibility, wmediumd is meant to understand shorter
+	 * (and ignore unknown parts of longer) control messages than
+	 * what's sent to it, so always take care to have defaults as
+	 * zero since that's what it assumes.
+	 */
+};
+
+struct wmediumd_tx_start {
+	/*
+	 * The cookie is set only when telling the sender, otherwise
+	 * it's set to 0.
+	 */
+	uint64_t cookie;
+	uint32_t freq;
+	uint32_t reserved[3];
+};
+
 #endif /* _WMEDIUMD_API_H */
diff --git a/wmediumd/wmediumd.c b/wmediumd/wmediumd.c
index d7ffd8396d8a..aa169e1602be 100644
--- a/wmediumd/wmediumd.c
+++ b/wmediumd/wmediumd.c
@@ -274,6 +274,41 @@ static void wmediumd_wait_for_client_ack(struct wmediumd *ctx,
 		usfstl_loop_wait_and_handle();
 }
 
+static void wmediumd_notify_frame_start(struct usfstl_job *job)
+{
+	struct frame *frame = container_of(job, struct frame, start_job);
+	struct wmediumd *ctx = job->data;
+	struct client *client;
+	struct {
+		struct wmediumd_message_header hdr;
+		struct wmediumd_tx_start start;
+	} __attribute__((packed)) msg = {
+		.hdr.type = WMEDIUMD_MSG_TX_START,
+		.hdr.data_len = sizeof(msg.start),
+		.start.freq = frame->freq,
+	};
+
+	if (ctx->ctrl)
+		usfstl_sched_ctrl_sync_to(ctx->ctrl);
+
+	list_for_each_entry(client, &ctx->clients, list) {
+		if (!(client->flags & WMEDIUMD_CTL_NOTIFY_TX_START))
+			continue;
+
+		if (client == frame->src)
+			msg.start.cookie = frame->cookie;
+		else
+			msg.start.cookie = 0;
+
+		/* must be API socket since flags cannot otherwise be set */
+		assert(client->type == CLIENT_API_SOCK);
+
+		write(client->loop.fd, &msg, sizeof(msg));
+
+		wmediumd_wait_for_client_ack(ctx, client);
+	}
+}
+
 static void queue_frame(struct wmediumd *ctx, struct station *station,
 			struct frame *frame)
 {
@@ -407,6 +442,15 @@ static void queue_frame(struct wmediumd *ctx, struct station *station,
 
 	frame->duration = send_time;
 	frame->src = station->client;
+
+	if (ctx->need_start_notify) {
+		frame->start_job.start = target - send_time;
+		frame->start_job.callback = wmediumd_notify_frame_start;
+		frame->start_job.data = ctx;
+		frame->start_job.name = "frame-start";
+		usfstl_sched_add_job(&scheduler, &frame->start_job);
+	}
+
 	frame->job.start = target;
 	frame->job.callback = wmediumd_deliver_frame;
 	frame->job.data = ctx;
@@ -473,6 +517,10 @@ static void wmediumd_remove_client(struct wmediumd *ctx, struct client *client)
 
 	if (!list_empty(&client->list))
 		list_del(&client->list);
+
+	if (client->flags & WMEDIUMD_CTL_NOTIFY_TX_START)
+		ctx->need_start_notify--;
+
 	free(client);
 }
 
@@ -519,11 +567,13 @@ out:
 /*
  * Send a data frame to the kernel for reception at a specific radio.
  */
-static void send_cloned_frame_msg(struct wmediumd *ctx, struct station *dst,
-				  u8 *data, int data_len, int rate_idx,
-				  int signal, int freq)
+static void send_cloned_frame_msg(struct wmediumd *ctx, struct client *src,
+				  struct station *dst, u8 *data, int data_len,
+				  int rate_idx, int signal, int freq,
+				  uint64_t cookie)
 {
-	struct nl_msg *msg;
+	struct client *client;
+	struct nl_msg *msg, *cmsg = NULL;
 
 	msg = nlmsg_alloc();
 	if (!msg) {
@@ -554,17 +604,25 @@ static void send_cloned_frame_msg(struct wmediumd *ctx, struct station *dst,
 	if (ctx->ctrl)
 		usfstl_sched_ctrl_sync_to(ctx->ctrl);
 
-	if (dst->client) {
-		wmediumd_send_to_client(ctx, dst->client, msg);
-	} else {
-		struct client *client;
-
-		list_for_each_entry(client, &ctx->clients, list)
+	list_for_each_entry(client, &ctx->clients, list) {
+		if (client->flags & WMEDIUMD_CTL_RX_ALL_FRAMES) {
+			if (!cmsg) {
+				cmsg = nlmsg_convert(nlmsg_hdr(msg));
+				if (!cmsg)
+					continue;
+				nla_put_u64(msg, HWSIM_ATTR_COOKIE, cookie);
+			}
+			wmediumd_send_to_client(ctx, client,
+						src == client ? cmsg : msg);
+		} else if (!dst->client || dst->client == client) {
 			wmediumd_send_to_client(ctx, client, msg);
+		}
 	}
 
 out:
 	nlmsg_free(msg);
+	if (cmsg)
+		nlmsg_free(cmsg);
 }
 
 static void wmediumd_deliver_frame(struct usfstl_job *job)
@@ -620,11 +678,13 @@ static void wmediumd_deliver_frame(struct usfstl_job *job)
 					continue;
 				}
 
-				send_cloned_frame_msg(ctx, station,
+				send_cloned_frame_msg(ctx, frame->sender->client,
+						      station,
 						      frame->data,
 						      frame->data_len,
 						      1, signal,
-						      frame->freq);
+						      frame->freq,
+						      frame->cookie);
 
 			} else if (station_has_addr(station, dest)) {
 				if (set_interference_duration(ctx,
@@ -632,11 +692,13 @@ static void wmediumd_deliver_frame(struct usfstl_job *job)
 					frame->signal))
 					continue;
 
-				send_cloned_frame_msg(ctx, station,
+				send_cloned_frame_msg(ctx, frame->sender->client,
+						      station,
 						      frame->data,
 						      frame->data_len,
 						      1, frame->signal,
-						      frame->freq);
+						      frame->freq,
+						      frame->cookie);
 			}
 		}
 	} else
@@ -865,6 +927,7 @@ static void wmediumd_api_handler(struct usfstl_loop_entry *entry)
 	struct wmediumd *ctx = entry->data;
 	struct wmediumd_message_header hdr;
 	enum wmediumd_message response = WMEDIUMD_MSG_ACK;
+	struct wmediumd_message_control control = {};
 	struct nl_msg *nlmsg;
 	unsigned char *data;
 	ssize_t len;
@@ -925,6 +988,18 @@ static void wmediumd_api_handler(struct usfstl_loop_entry *entry)
 
 		nlmsg_free(nlmsg);
 		break;
+	case WMEDIUMD_MSG_SET_CONTROL:
+		/* copy what we get and understand, leave the rest zeroed */
+		memcpy(&control, data,
+		       min(sizeof(control), hdr.data_len));
+
+		if (client->flags & WMEDIUMD_CTL_NOTIFY_TX_START)
+			ctx->need_start_notify--;
+		if (control.flags & WMEDIUMD_CTL_NOTIFY_TX_START)
+			ctx->need_start_notify++;
+
+		client->flags = control.flags;
+		break;
 	case WMEDIUMD_MSG_ACK:
 		abort();
 	default:
diff --git a/wmediumd/wmediumd.h b/wmediumd/wmediumd.h
index 2360da75cdb2..6319bb70c8f6 100644
--- a/wmediumd/wmediumd.h
+++ b/wmediumd/wmediumd.h
@@ -184,6 +184,8 @@ struct client {
 	/* for API socket */
 	struct usfstl_loop_entry loop;
 	bool wait_for_ack;
+
+	u32 flags;
 };
 
 struct wmediumd {
@@ -223,6 +225,8 @@ struct wmediumd {
 	int (*get_fading_signal)(struct wmediumd *);
 
 	u8 log_lvl;
+
+	u32 need_start_notify;
 };
 
 struct hwsim_tx_rate {
@@ -233,6 +237,7 @@ struct hwsim_tx_rate {
 struct frame {
 	struct list_head list;		/* frame queue list */
 	struct usfstl_job job;
+	struct usfstl_job start_job;
 	struct client *src;
 	bool acked;
 	u64 cookie;
-- 
2.26.2

