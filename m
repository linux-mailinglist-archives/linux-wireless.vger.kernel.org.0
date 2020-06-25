Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037E2209F3B
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2020 15:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404893AbgFYNI5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jun 2020 09:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404926AbgFYNIz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jun 2020 09:08:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05001C08C5DD
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2020 06:08:55 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1joRcb-00BrnC-8C; Thu, 25 Jun 2020 15:08:53 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     me@bcopeland.com
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/9] wmediumd: sync with external scheduler on API socket
Date:   Thu, 25 Jun 2020 15:08:38 +0200
Message-Id: <20200625150754.c7dd5cb194aa.Icb95242975e6e6952a14e5ae1337245496489a6b@changeid>
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

If there's a non-control message on the API socket, sync time
from the external scheduler to update the internal time and
handle updates correctly.

Also synchronize time to the external scheduler when we send
anything to the API socket, in case we were free-running for
a while.

---
 wmediumd/wmediumd.c | 9 +++++++++
 wmediumd/wmediumd.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/wmediumd/wmediumd.c b/wmediumd/wmediumd.c
index 8a9d97b6a427..0f45c75be9c9 100644
--- a/wmediumd/wmediumd.c
+++ b/wmediumd/wmediumd.c
@@ -508,6 +508,8 @@ static void send_tx_info_frame_nl(struct wmediumd *ctx, struct frame *frame)
 		goto out;
 	}
 
+	if (ctx->ctrl)
+		usfstl_sched_ctrl_sync_to(ctx->ctrl);
 	wmediumd_send_to_client(ctx, frame->src, msg);
 
 out:
@@ -549,6 +551,9 @@ static void send_cloned_frame_msg(struct wmediumd *ctx, struct station *dst,
 	w_logf(ctx, LOG_DEBUG, "cloned msg dest " MAC_FMT " (radio: " MAC_FMT ") len %d\n",
 		   MAC_ARGS(dst->addr), MAC_ARGS(dst->hwaddr), data_len);
 
+	if (ctx->ctrl)
+		usfstl_sched_ctrl_sync_to(ctx->ctrl);
+
 	if (dst->client) {
 		wmediumd_send_to_client(ctx, dst->client, msg);
 	} else {
@@ -904,6 +909,9 @@ static void wmediumd_api_handler(struct usfstl_loop_entry *entry)
 		list_del_init(&client->list);
 		break;
 	case WMEDIUMD_MSG_NETLINK:
+		if (ctx->ctrl)
+			usfstl_sched_ctrl_sync_from(ctx->ctrl);
+
 		if (!nlmsg_ok((const struct nlmsghdr *)data, len)) {
 			response = WMEDIUMD_MSG_INVALID;
 			break;
@@ -1180,6 +1188,7 @@ int main(int argc, char *argv[])
 				      &scheduler);
 		vusrv.scheduler = &scheduler;
 		vusrv.ctrl = &ctrl;
+		ctx.ctrl = &ctrl;
 	} else {
 		usfstl_sched_wallclock_init(&scheduler, 1000);
 	}
diff --git a/wmediumd/wmediumd.h b/wmediumd/wmediumd.h
index fb7b47a43574..2360da75cdb2 100644
--- a/wmediumd/wmediumd.h
+++ b/wmediumd/wmediumd.h
@@ -192,6 +192,8 @@ struct wmediumd {
 	struct nl_sock *sock;
 	struct usfstl_loop_entry nl_loop;
 
+	struct usfstl_sched_ctrl *ctrl;
+
 	struct list_head clients;
 	struct client nl_client;
 
-- 
2.26.2

