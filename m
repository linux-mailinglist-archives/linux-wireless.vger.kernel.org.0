Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24906209F41
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2020 15:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404934AbgFYNIz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jun 2020 09:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404923AbgFYNIz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jun 2020 09:08:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB169C08C5DB
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2020 06:08:54 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1joRca-00BrnC-Tb; Thu, 25 Jun 2020 15:08:53 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     me@bcopeland.com
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/9] wmediumd: properly wait for control socket ACK
Date:   Thu, 25 Jun 2020 15:08:37 +0200
Message-Id: <20200625150754.57939c4eed52.Iebbeb7ba51a6f3c3ada3091d7a2da0ebc7da803f@changeid>
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

When the control socket is used in conjunction with a time
controller, then it may happen that we have

wmediumd               app                  time controller
  ------ message ------>
  (wait for ack)
                         ----- request runtime --->
  <-------------- update scheduler ----------------
                                              (wait for ack)

and deadlock here, because the update scheduler message
isn't processed by wmediumd.

Fix this by properly deferring to the mainloop when waiting
for an ACK message on the control socket.

---
 wmediumd/wmediumd.c | 23 +++++++++++++++++++++--
 wmediumd/wmediumd.h |  1 +
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/wmediumd/wmediumd.c b/wmediumd/wmediumd.c
index d756dc4be5b9..8a9d97b6a427 100644
--- a/wmediumd/wmediumd.c
+++ b/wmediumd/wmediumd.c
@@ -26,6 +26,7 @@
 #include <netlink/genl/genl.h>
 #include <netlink/genl/ctrl.h>
 #include <netlink/genl/family.h>
+#include <assert.h>
 #include <stdint.h>
 #include <getopt.h>
 #include <signal.h>
@@ -264,6 +265,15 @@ static struct station *get_station_by_used_addr(struct wmediumd *ctx, u8 *addr)
 	return NULL;
 }
 
+static void wmediumd_wait_for_client_ack(struct wmediumd *ctx,
+					 struct client *client)
+{
+	client->wait_for_ack = true;
+
+	while (client->wait_for_ack)
+		usfstl_loop_wait_and_handle();
+}
+
 static void queue_frame(struct wmediumd *ctx, struct station *station,
 			struct frame *frame)
 {
@@ -430,8 +440,7 @@ static void wmediumd_send_to_client(struct wmediumd *ctx,
 		hdr.data_len = len;
 		write(client->loop.fd, &hdr, sizeof(hdr));
 		write(client->loop.fd, (void *)nlmsg_hdr(msg), len);
-		/* read the ACK back */
-		read(client->loop.fd, &hdr, sizeof(hdr));
+		wmediumd_wait_for_client_ack(ctx, client);
 		break;
 	}
 }
@@ -871,6 +880,14 @@ static void wmediumd_api_handler(struct usfstl_loop_entry *entry)
 	if (len != hdr.data_len)
 		goto disconnect;
 
+	if (client->wait_for_ack) {
+		assert(hdr.type == WMEDIUMD_MSG_ACK);
+		assert(hdr.data_len == 0);
+		client->wait_for_ack = false;
+		/* don't send a response to a response, of course */
+		return;
+	}
+
 	switch (hdr.type) {
 	case WMEDIUMD_MSG_REGISTER:
 		if (!list_empty(&client->list)) {
@@ -900,6 +917,8 @@ static void wmediumd_api_handler(struct usfstl_loop_entry *entry)
 
 		nlmsg_free(nlmsg);
 		break;
+	case WMEDIUMD_MSG_ACK:
+		abort();
 	default:
 		response = WMEDIUMD_MSG_INVALID;
 		break;
diff --git a/wmediumd/wmediumd.h b/wmediumd/wmediumd.h
index e201788b9b52..fb7b47a43574 100644
--- a/wmediumd/wmediumd.h
+++ b/wmediumd/wmediumd.h
@@ -183,6 +183,7 @@ struct client {
 
 	/* for API socket */
 	struct usfstl_loop_entry loop;
+	bool wait_for_ack;
 };
 
 struct wmediumd {
-- 
2.26.2

