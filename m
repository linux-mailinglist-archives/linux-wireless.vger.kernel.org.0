Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFBE209F37
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2020 15:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404958AbgFYNI6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jun 2020 09:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404923AbgFYNI4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jun 2020 09:08:56 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D6BC08C5DC
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2020 06:08:55 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1joRcc-00BrnC-6e; Thu, 25 Jun 2020 15:08:54 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     me@bcopeland.com
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6/9] wmediumd: fix RX message with cookie
Date:   Thu, 25 Jun 2020 15:08:41 +0200
Message-Id: <20200625150754.f1b8860bb95b.Ifb8f79b3edacce8832697ca796861aad92b2ce7b@changeid>
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

The cookie message needs to be built properly, fix the code to
do this, otherwise a client with WMEDIUMD_CTL_RX_ALL_FRAMES
doesn't know its own messages. The code was just completely
broken in all kinds of ways.

---
 wmediumd/wmediumd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/wmediumd/wmediumd.c b/wmediumd/wmediumd.c
index aa169e1602be..afc4f16d9ae9 100644
--- a/wmediumd/wmediumd.c
+++ b/wmediumd/wmediumd.c
@@ -606,11 +606,12 @@ static void send_cloned_frame_msg(struct wmediumd *ctx, struct client *src,
 
 	list_for_each_entry(client, &ctx->clients, list) {
 		if (client->flags & WMEDIUMD_CTL_RX_ALL_FRAMES) {
-			if (!cmsg) {
-				cmsg = nlmsg_convert(nlmsg_hdr(msg));
-				if (!cmsg)
-					continue;
-				nla_put_u64(msg, HWSIM_ATTR_COOKIE, cookie);
+			if (src == client && !cmsg) {
+				struct nlmsghdr *nlh = nlmsg_hdr(msg);
+
+				cmsg = nlmsg_inherit(nlh);
+				nlmsg_append(cmsg, nlmsg_data(nlh), nlmsg_datalen(nlh), 0);
+				assert(nla_put_u64(cmsg, HWSIM_ATTR_COOKIE, cookie) == 0);
 			}
 			wmediumd_send_to_client(ctx, client,
 						src == client ? cmsg : msg);
-- 
2.26.2

