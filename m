Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD14325195
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Feb 2021 15:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhBYOh7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Feb 2021 09:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhBYOh5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Feb 2021 09:37:57 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E08C061574
        for <linux-wireless@vger.kernel.org>; Thu, 25 Feb 2021 06:37:16 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lFHlS-008T67-2N; Thu, 25 Feb 2021 15:37:14 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org, Bob Copeland <me@bobcopeland.com>
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wmediumd: fix use-after-free in client removal
Date:   Thu, 25 Feb 2021 15:37:08 +0100
Message-Id: <20210225143708.419462-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If a client dies while we're waiting for an ACK from it, then
wmediumd_api_handler() will call wmediumd_remove_client() and
free the client, even while we're still waiting for it to
respond in wmediumd_wait_for_client_ack(). This leads then to
wmediumd_wait_for_client_ack() using the data after it was
already freed, and we also get stuck.

Fix this by deferring the free to the outermost loop, instead
just setting wait_for_ack=false whenever we find that we have
to free a client.

All client iterations (that can call back into the loop) then
must use _safe() in order to not use the 'next' pointer after
the client was removed (and the pointer poisoned).
---
 wmediumd/wmediumd.c | 22 +++++++++++++++++-----
 wmediumd/wmediumd.h |  2 +-
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/wmediumd/wmediumd.c b/wmediumd/wmediumd.c
index 5304931fbf74..3b4aed35c981 100644
--- a/wmediumd/wmediumd.c
+++ b/wmediumd/wmediumd.c
@@ -279,7 +279,7 @@ static void wmediumd_notify_frame_start(struct usfstl_job *job)
 {
 	struct frame *frame = container_of(job, struct frame, start_job);
 	struct wmediumd *ctx = job->data;
-	struct client *client;
+	struct client *client, *tmp;
 	struct {
 		struct wmediumd_message_header hdr;
 		struct wmediumd_tx_start start;
@@ -292,7 +292,7 @@ static void wmediumd_notify_frame_start(struct usfstl_job *job)
 	if (ctx->ctrl)
 		usfstl_sched_ctrl_sync_to(ctx->ctrl);
 
-	list_for_each_entry(client, &ctx->clients, list) {
+	list_for_each_entry_safe(client, tmp, &ctx->clients, list) {
 		if (!(client->flags & WMEDIUMD_CTL_NOTIFY_TX_START))
 			continue;
 
@@ -583,11 +583,12 @@ static void wmediumd_remove_client(struct wmediumd *ctx, struct client *client)
 
 	if (!list_empty(&client->list))
 		list_del(&client->list);
+	list_add(&client->list, &ctx->clients_to_free);
 
 	if (client->flags & WMEDIUMD_CTL_NOTIFY_TX_START)
 		ctx->need_start_notify--;
 
-	free(client);
+	client->wait_for_ack = false;
 }
 
 /*
@@ -638,7 +639,7 @@ static void send_cloned_frame_msg(struct wmediumd *ctx, struct client *src,
 				  int rate_idx, int signal, int freq,
 				  uint64_t cookie)
 {
-	struct client *client;
+	struct client *client, *tmp;
 	struct nl_msg *msg, *cmsg = NULL;
 
 	msg = nlmsg_alloc();
@@ -670,7 +671,7 @@ static void send_cloned_frame_msg(struct wmediumd *ctx, struct client *src,
 	if (ctx->ctrl)
 		usfstl_sched_ctrl_sync_to(ctx->ctrl);
 
-	list_for_each_entry(client, &ctx->clients, list) {
+	list_for_each_entry_safe(client, tmp, &ctx->clients, list) {
 		if (client->flags & WMEDIUMD_CTL_RX_ALL_FRAMES) {
 			if (src == client && !cmsg) {
 				struct nlmsghdr *nlh = nlmsg_hdr(msg);
@@ -1356,6 +1357,7 @@ int main(int argc, char *argv[])
 
 	INIT_LIST_HEAD(&ctx.stations);
 	INIT_LIST_HEAD(&ctx.clients);
+	INIT_LIST_HEAD(&ctx.clients_to_free);
 
 	if (load_config(&ctx, config_file, per_file))
 		return EXIT_FAILURE;
@@ -1415,6 +1417,16 @@ int main(int argc, char *argv[])
 			if (usfstl_sched_next_pending(&scheduler, NULL))
 				usfstl_sched_next(&scheduler);
 		}
+
+		while (!list_empty(&ctx.clients_to_free)) {
+			struct client *client;
+
+			client = list_first_entry(&ctx.clients_to_free,
+						  struct client, list);
+
+			list_del(&client->list);
+			free(client);
+		}
 	}
 
 	free(ctx.sock);
diff --git a/wmediumd/wmediumd.h b/wmediumd/wmediumd.h
index 8619e28cbe9a..4b7ca6628ce9 100644
--- a/wmediumd/wmediumd.h
+++ b/wmediumd/wmediumd.h
@@ -196,7 +196,7 @@ struct wmediumd {
 
 	struct usfstl_sched_ctrl *ctrl;
 
-	struct list_head clients;
+	struct list_head clients, clients_to_free;
 	struct client nl_client;
 
 	int num_stas;
-- 
2.26.2

