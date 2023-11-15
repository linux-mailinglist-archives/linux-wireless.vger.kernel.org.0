Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9888A7EC346
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Nov 2023 14:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343863AbjKONIW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Nov 2023 08:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343723AbjKONIV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Nov 2023 08:08:21 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94FDCE
        for <linux-wireless@vger.kernel.org>; Wed, 15 Nov 2023 05:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=99AeEgO4YKKkqs5GbnXnOD1UmJxYdENFAMY89H21CxQ=; t=1700053697; x=1701263297; 
        b=wST83kiUVPoBotj4FhlbC0uCXFT7Azu8EhFF9yxrpUe+9a6XML87TB3xa7XuMolxADuUk9oNtbM
        DuQCWBObbDReEo3MGuHhrt61gxnwGcieGstrAxAkEvVw66VM/xFvf65FTPs78JOL1RcoEaoHmzmkl
        s7KNYZSJxT8mjrG5y08cw0IwQ8UKzSIgeaZbDPa8g98T52HipY5n7E/b61a+oC1Y9hL18CFGMZMC8
        ohwX9bBKnZ4fZoxCEBucOW2ZEob3N6OYME6zni+UqlUjCoU758Y6x0RGBmRUgfREnGJOlk9oCjo1z
        z8R/BK4k+RwgUwIFP2kNeQ6fcjrn/AX6ckdg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r3Fch-00000009BMD-3bnK;
        Wed, 15 Nov 2023 14:08:04 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH] wifi: cfg80211: hold wiphy mutex for send_interface
Date:   Wed, 15 Nov 2023 13:06:16 +0100
Message-ID: <20231115130615.b1ccadaf9e13.Ic207e2f99f806e9120278f92fdebc2822842c301@changeid>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Given all the locking rework in mac80211, we pretty much
need to get into the driver with the wiphy mutex held in
all callbacks. This is already mostly the case, but as
Johan reported, in the get_txpower it may not be true.

Lock the wiphy mutex around nl80211_send_iface(), then
is also around callers of nl80211_notify_iface(). This
is easy to do, fixes the problem, and aligns the locking
between various calls to it in different parts of the
code of cfg80211.

Fixes: 0e8185ce1dde ("wifi: mac80211: check wiphy mutex in ops")
Reported-by: Johan Hovold <johan@kernel.org>
Closes: https://lore.kernel.org/r/ZVOXX6qg4vXEx8dX@hovoldconsulting.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/core.c    | 4 ++--
 net/wireless/nl80211.c | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 758c9a2a12c0..1786ebc5e5cd 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -191,13 +191,13 @@ int cfg80211_switch_netns(struct cfg80211_registered_device *rdev,
 		return err;
 	}
 
+	wiphy_lock(&rdev->wiphy);
 	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
 		if (!wdev->netdev)
 			continue;
 		nl80211_notify_iface(rdev, wdev, NL80211_CMD_DEL_INTERFACE);
 	}
 
-	wiphy_lock(&rdev->wiphy);
 	nl80211_notify_wiphy(rdev, NL80211_CMD_DEL_WIPHY);
 
 	wiphy_net_set(&rdev->wiphy, net);
@@ -206,13 +206,13 @@ int cfg80211_switch_netns(struct cfg80211_registered_device *rdev,
 	WARN_ON(err);
 
 	nl80211_notify_wiphy(rdev, NL80211_CMD_NEW_WIPHY);
-	wiphy_unlock(&rdev->wiphy);
 
 	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
 		if (!wdev->netdev)
 			continue;
 		nl80211_notify_iface(rdev, wdev, NL80211_CMD_NEW_INTERFACE);
 	}
+	wiphy_unlock(&rdev->wiphy);
 
 	return 0;
 }
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 569234bc2be6..358ca88b5292 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3822,6 +3822,8 @@ static int nl80211_send_iface(struct sk_buff *msg, u32 portid, u32 seq, int flag
 	struct net_device *dev = wdev->netdev;
 	void *hdr;
 
+	lockdep_assert_wiphy(&rdev->wiphy);
+
 	WARN_ON(cmd != NL80211_CMD_NEW_INTERFACE &&
 		cmd != NL80211_CMD_DEL_INTERFACE &&
 		cmd != NL80211_CMD_SET_INTERFACE);
@@ -3989,6 +3991,7 @@ static int nl80211_dump_interface(struct sk_buff *skb, struct netlink_callback *
 
 		if_idx = 0;
 
+		wiphy_lock(&rdev->wiphy);
 		list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
 			if (if_idx < if_start) {
 				if_idx++;
@@ -3998,10 +4001,12 @@ static int nl80211_dump_interface(struct sk_buff *skb, struct netlink_callback *
 					       cb->nlh->nlmsg_seq, NLM_F_MULTI,
 					       rdev, wdev,
 					       NL80211_CMD_NEW_INTERFACE) < 0) {
+				wiphy_unlock(&rdev->wiphy);
 				goto out;
 			}
 			if_idx++;
 		}
+		wiphy_unlock(&rdev->wiphy);
 
 		wp_idx++;
 	}
-- 
2.41.0

