Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D4C33493E
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Mar 2021 21:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhCJU7H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Mar 2021 15:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbhCJU6t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Mar 2021 15:58:49 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CBEC061574
        for <linux-wireless@vger.kernel.org>; Wed, 10 Mar 2021 12:58:49 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lK5ul-00EUn1-T3; Wed, 10 Mar 2021 21:58:43 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Sid Hayn <sidhayn@gmail.com>
Subject: [PATCH] nl80211: fix locking for wireless device netns change
Date:   Wed, 10 Mar 2021 21:58:40 +0100
Message-Id: <20210310215839.eadf7c43781b.I5fc6cf6676f800ab8008e03bbea9c3349b02d804@changeid>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We have all the network interfaces marked as netns-local
since the only reasonable thing to do right now is to set
a whole device, including all netdevs, into a different
network namespace. For this reason, we also have our own
way of changing the network namespace.

Unfortunately, the RTNL locking changes broke this, and
it now results in many RTNL assertions. The trivial fix
for those (just hold RTNL for the changes) however leads
to deadlocks in the cfg80211 netdev notifier.

Since we only need the wiphy, and that's still protected
by the RTNL, add a new NL80211_FLAG_NO_WIPHY_MTX flag to
the nl80211 ops and use it to _not_ take the wiphy mutex
but only the RTNL. This way, the notifier does all the
work necessary during unregistration/registration of the
netdevs from the old and in the new namespace.

Reported-by: Sid Hayn <sidhayn@gmail.com>
Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 521d36bb0803..ae6097fff133 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -14789,6 +14789,7 @@ static int nl80211_set_tid_config(struct sk_buff *skb,
 #define NL80211_FLAG_NEED_WDEV_UP	(NL80211_FLAG_NEED_WDEV |\
 					 NL80211_FLAG_CHECK_NETDEV_UP)
 #define NL80211_FLAG_CLEAR_SKB		0x20
+#define NL80211_FLAG_NO_WIPHY_MTX	0x40
 
 static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 			    struct genl_info *info)
@@ -14840,7 +14841,7 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 		info->user_ptr[0] = rdev;
 	}
 
-	if (rdev) {
+	if (rdev && !(ops->internal_flags & NL80211_FLAG_NO_WIPHY_MTX)) {
 		wiphy_lock(&rdev->wiphy);
 		/* we keep the mutex locked until post_doit */
 		__release(&rdev->wiphy.mtx);
@@ -14865,7 +14866,8 @@ static void nl80211_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
 		}
 	}
 
-	if (info->user_ptr[0]) {
+	if (info->user_ptr[0] &&
+	    !(ops->internal_flags & NL80211_FLAG_NO_WIPHY_MTX)) {
 		struct cfg80211_registered_device *rdev = info->user_ptr[0];
 
 		/* we kept the mutex locked since pre_doit */
@@ -15329,7 +15331,9 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_wiphy_netns,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WIPHY,
+		.internal_flags = NL80211_FLAG_NEED_WIPHY |
+				  NL80211_FLAG_NEED_RTNL |
+				  NL80211_FLAG_NO_WIPHY_MTX,
 	},
 	{
 		.cmd = NL80211_CMD_GET_SURVEY,
-- 
2.29.2

