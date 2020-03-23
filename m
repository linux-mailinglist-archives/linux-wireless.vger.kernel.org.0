Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6265018F886
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 16:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgCWPZx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 11:25:53 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:49296 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbgCWPZu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 11:25:50 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jGOxX-002WVN-7L; Mon, 23 Mar 2020 16:25:47 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     me@bobcopeland.com, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/7] wmediumd: mark various functions static
Date:   Mon, 23 Mar 2020 16:25:36 +0100
Message-Id: <20200323162245.11535025ec4d.I98f5142f6c3cfc5ddf1f31f446072b112b6f1bd5@changeid>
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

There are a number of functions that can be static
but aren't, mark them as such.

---
 wmediumd/wmediumd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/wmediumd/wmediumd.c b/wmediumd/wmediumd.c
index 8fb0ed49bbb1..5e89e83ca72b 100644
--- a/wmediumd/wmediumd.c
+++ b/wmediumd/wmediumd.c
@@ -220,7 +220,7 @@ static int get_signal_offset_by_interference(struct wmediumd *ctx, int src_idx,
 	return (int)(milliwatt_to_dBm(intf_power) + 0.5);
 }
 
-bool is_multicast_ether_addr(const u8 *addr)
+static bool is_multicast_ether_addr(const u8 *addr)
 {
 	return 0x01 & addr[0];
 }
@@ -236,8 +236,8 @@ static struct station *get_station_by_addr(struct wmediumd *ctx, u8 *addr)
 	return NULL;
 }
 
-void queue_frame(struct wmediumd *ctx, struct station *station,
-		 struct frame *frame)
+static void queue_frame(struct wmediumd *ctx, struct station *station,
+			struct frame *frame)
 {
 	struct ieee80211_hdr *hdr = (void *)frame->data;
 	u8 *dest = hdr->addr1;
@@ -485,7 +485,7 @@ out:
 	nlmsg_free(msg);
 }
 
-void wmediumd_deliver_frame(struct usfstl_job *job)
+static void wmediumd_deliver_frame(struct usfstl_job *job)
 {
 	struct wmediumd *ctx = job->data;
 	struct frame *frame = container_of(job, struct frame, job);
@@ -566,7 +566,7 @@ void wmediumd_deliver_frame(struct usfstl_job *job)
 	free(frame);
 }
 
-void wmediumd_intf_update(struct usfstl_job *job)
+static void wmediumd_intf_update(struct usfstl_job *job)
 {
 	struct wmediumd *ctx = job->data;
 	int i, j;
@@ -732,7 +732,7 @@ static const struct usfstl_vhost_user_ops wmediumd_vu_ops = {
 /*
  * Register with the kernel to start receiving new frames.
  */
-int send_register_msg(struct wmediumd *ctx)
+static int send_register_msg(struct wmediumd *ctx)
 {
 	struct nl_sock *sock = ctx->sock;
 	struct nl_msg *msg;
@@ -815,7 +815,7 @@ static int init_netlink(struct wmediumd *ctx)
 /*
  *	Print the CLI help
  */
-void print_help(int exval)
+static void print_help(int exval)
 {
 	printf("wmediumd v%s - a wireless medium simulator\n", VERSION_STR);
 	printf("wmediumd [-h] [-V] [-l LOG_LVL] [-x FILE] -c FILE \n\n");
-- 
2.25.1

