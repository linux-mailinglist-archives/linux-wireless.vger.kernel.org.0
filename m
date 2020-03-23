Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE96718F880
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 16:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgCWPZu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 11:25:50 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:49292 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbgCWPZt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 11:25:49 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jGOxX-002WVN-RR; Mon, 23 Mar 2020 16:25:47 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     me@bobcopeland.com, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/7] wmediumd: fix use-after-free
Date:   Mon, 23 Mar 2020 16:25:38 +0100
Message-Id: <20200323162245.3c73cce10e60.I075866ca98e0f5633baef99efdcb8276962c198b@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200323152542.68696-1-johannes@sipsolutions.net>
References: <20200323152542.68696-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When a client (vhost-user) disconnects when there's a frame from
it on the queue, we have a use-after-free on actually sending it.
Avoid this by clearing all the stations->client pointers that go
away, and removing frames where the source goes away.

Also, while at it, remove the unused frame->dest pointer.

Fixes: 5b4cebfbf6d9 ("wmediumd: add vhost-user support")
---
 wmediumd/wmediumd.c | 35 ++++++++++++++++++++++++++++++++---
 wmediumd/wmediumd.h |  2 +-
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/wmediumd/wmediumd.c b/wmediumd/wmediumd.c
index e7374d9b9639..39797e58f277 100644
--- a/wmediumd/wmediumd.c
+++ b/wmediumd/wmediumd.c
@@ -368,7 +368,6 @@ static void queue_frame(struct wmediumd *ctx, struct station *station,
 	target += send_time;
 
 	frame->duration = send_time;
-	frame->dest = deststa ? deststa->client : NULL;
 	frame->src = station->client;
 	frame->job.start = target;
 	frame->job.callback = wmediumd_deliver_frame;
@@ -399,6 +398,37 @@ static void wmediumd_send_to_client(struct wmediumd *ctx,
 	}
 }
 
+static void wmediumd_remove_client(struct wmediumd *ctx, struct client *client)
+{
+	struct frame *frame, *tmp;
+	struct wqueue *queue;
+	struct station *station;
+	int ac;
+
+	list_for_each_entry(station, &ctx->stations, list) {
+		if (station->client == client)
+			station->client = NULL;
+	}
+
+	list_for_each_entry(station, &ctx->stations, list) {
+		for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
+			queue = &station->queues[ac];
+			list_for_each_entry_safe(frame, tmp, &queue->frames,
+						 list) {
+				if (frame->src == client) {
+					list_del(&frame->list);
+					usfstl_sched_del_job(&frame->job);
+					free(frame);
+				}
+			}
+		}
+	}
+
+	if (!list_empty(&client->list))
+		list_del(&client->list);
+	free(client);
+}
+
 /*
  * Report transmit status to the kernel.
  */
@@ -719,8 +749,7 @@ static void wmediumd_vu_disconnected(struct usfstl_vhost_user_dev *dev)
 	struct client *client = dev->data;
 
 	dev->data = NULL;
-	list_del(&client->list);
-	free(client);
+	wmediumd_remove_client(dev->server->data, client);
 }
 
 static const struct usfstl_vhost_user_ops wmediumd_vu_ops = {
diff --git a/wmediumd/wmediumd.h b/wmediumd/wmediumd.h
index d4ce3a1df15d..06b356516a15 100644
--- a/wmediumd/wmediumd.h
+++ b/wmediumd/wmediumd.h
@@ -210,7 +210,7 @@ struct hwsim_tx_rate {
 struct frame {
 	struct list_head list;		/* frame queue list */
 	struct usfstl_job job;
-	struct client *src, *dest;
+	struct client *src;
 	bool acked;
 	u64 cookie;
 	u32 freq;
-- 
2.25.1

