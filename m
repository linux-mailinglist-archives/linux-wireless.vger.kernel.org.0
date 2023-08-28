Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5EF78AF8C
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjH1MFu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjH1MFZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:25 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C69124
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=kZXwM9Jf/Jx/XmTNuV7zO9wLe4Nhr6MraqTX9Ys7j2Y=;
        t=1693224322; x=1694433922; b=DznAmmlfT8uNy1WZeovTLTRJrDjzLtBxHNzuPA/CgEPn2cX
        skrj0p//I/b6PikgSzvZGXxZ/DhrdM397EzWhggGBYdR7Z4VBLx2/cRpzQ2hyG76X3gXXbsIPPvwj
        m0Z/aESdnRcS5JGuOWQMkLLMboa1F0RFyVVcFntG1G/ZaUAJpQa5vQV6CCMhM8nXj3v7RI1XIrb0C
        NpmGbxRMjs1fXKZBpyut1OJUuEJ6MLTEolvNbOeoFUgoWnItYGjle/sbDuNm8s5C2L7DGWemYMY7r
        Ub5CjZv5dWAJBzBkvcOHiueKVhuwkMoor4VH+9F2rEgxKENq+Txu/Y/KjbquMVKA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qaazg-00Gjgt-0i;
        Mon, 28 Aug 2023 14:05:20 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 04/40] wifi: cfg80211: check RTNL when iterating devices
Date:   Mon, 28 Aug 2023 13:59:32 +0200
Message-ID: <20230828135927.df9e0fe62801.Idaef4373097bc80a95c4f639813b06aca0920a3c@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828115927.116700-41-johannes@sipsolutions.net>
References: <20230828115927.116700-41-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Add a new "for_each_rdev()" macro and check that we
hold the RTNL when calling it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/chan.c    |  2 +-
 net/wireless/core.c    |  6 +++---
 net/wireless/core.h    | 10 ++++++++++
 net/wireless/nl80211.c |  6 +++---
 net/wireless/reg.c     | 18 +++++++++---------
 net/wireless/sme.c     |  2 +-
 6 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 0b7e81db383d..3c691ae904d1 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -823,7 +823,7 @@ bool cfg80211_any_wiphy_oper_chan(struct wiphy *wiphy,
 	if (!(chan->flags & IEEE80211_CHAN_RADAR))
 		return false;
 
-	list_for_each_entry(rdev, &cfg80211_rdev_list, list) {
+	for_each_rdev(rdev) {
 		if (!reg_dfs_domain_same(wiphy, &rdev->wiphy))
 			continue;
 
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 25bc2e50a061..fdb9d736a2e8 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -60,7 +60,7 @@ struct cfg80211_registered_device *cfg80211_rdev_by_wiphy_idx(int wiphy_idx)
 
 	ASSERT_RTNL();
 
-	list_for_each_entry(rdev, &cfg80211_rdev_list, list) {
+	for_each_rdev(rdev) {
 		if (rdev->wiphy_idx == wiphy_idx) {
 			result = rdev;
 			break;
@@ -116,7 +116,7 @@ static int cfg80211_dev_check_name(struct cfg80211_registered_device *rdev,
 	}
 
 	/* Ensure another device does not already have this name. */
-	list_for_each_entry(rdev2, &cfg80211_rdev_list, list)
+	for_each_rdev(rdev2)
 		if (strcmp(newname, wiphy_name(&rdev2->wiphy)) == 0)
 			return -EINVAL;
 
@@ -1601,7 +1601,7 @@ static void __net_exit cfg80211_pernet_exit(struct net *net)
 	struct cfg80211_registered_device *rdev;
 
 	rtnl_lock();
-	list_for_each_entry(rdev, &cfg80211_rdev_list, list) {
+	for_each_rdev(rdev) {
 		if (net_eq(wiphy_net(&rdev->wiphy), net))
 			WARN_ON(cfg80211_switch_netns(rdev, &init_net));
 	}
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 507d184b8b40..d4976550e7f6 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -160,6 +160,16 @@ extern struct workqueue_struct *cfg80211_wq;
 extern struct list_head cfg80211_rdev_list;
 extern int cfg80211_rdev_list_generation;
 
+/* This is constructed like this so it can be used in if/else */
+static inline int for_each_rdev_check_rtnl(void)
+{
+	ASSERT_RTNL();
+	return 0;
+}
+#define for_each_rdev(rdev)						\
+	if (for_each_rdev_check_rtnl()) {} else				\
+		list_for_each_entry(rdev, &cfg80211_rdev_list, list)
+
 struct cfg80211_internal_bss {
 	struct list_head list;
 	struct list_head hidden_list;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index de47838aca4f..f4298104a2f4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -106,7 +106,7 @@ __cfg80211_wdev_from_attrs(struct cfg80211_registered_device *rdev,
 
 	ASSERT_RTNL();
 
-	list_for_each_entry(rdev, &cfg80211_rdev_list, list) {
+	for_each_rdev(rdev) {
 		struct wireless_dev *wdev;
 
 		if (wiphy_net(&rdev->wiphy) != netns)
@@ -3075,7 +3075,7 @@ static int nl80211_dump_wiphy(struct sk_buff *skb, struct netlink_callback *cb)
 		cb->args[0] = (long)state;
 	}
 
-	list_for_each_entry(rdev, &cfg80211_rdev_list, list) {
+	for_each_rdev(rdev) {
 		if (!net_eq(wiphy_net(&rdev->wiphy), sock_net(skb->sk)))
 			continue;
 		if (++idx <= state->start)
@@ -3985,7 +3985,7 @@ static int nl80211_dump_interface(struct sk_buff *skb, struct netlink_callback *
 		filter_wiphy = cb->args[2] - 1;
 	}
 
-	list_for_each_entry(rdev, &cfg80211_rdev_list, list) {
+	for_each_rdev(rdev) {
 		if (!net_eq(wiphy_net(&rdev->wiphy), sock_net(skb->sk)))
 			continue;
 		if (wp_idx < wp_start) {
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 0317cf9da307..f861d1d82b18 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2461,7 +2461,7 @@ static void reg_check_chans_work(struct work_struct *work)
 	pr_debug("Verifying active interfaces after reg change\n");
 	rtnl_lock();
 
-	list_for_each_entry(rdev, &cfg80211_rdev_list, list)
+	for_each_rdev(rdev)
 		reg_leave_invalid_chans(&rdev->wiphy);
 
 	rtnl_unlock();
@@ -2515,7 +2515,7 @@ static void update_all_wiphy_regulatory(enum nl80211_reg_initiator initiator)
 
 	ASSERT_RTNL();
 
-	list_for_each_entry(rdev, &cfg80211_rdev_list, list) {
+	for_each_rdev(rdev) {
 		wiphy = &rdev->wiphy;
 		wiphy_update_regulatory(wiphy, initiator);
 	}
@@ -2991,7 +2991,7 @@ static void wiphy_all_share_dfs_chan_state(struct wiphy *wiphy)
 
 	ASSERT_RTNL();
 
-	list_for_each_entry(rdev, &cfg80211_rdev_list, list) {
+	for_each_rdev(rdev) {
 		if (wiphy == &rdev->wiphy)
 			continue;
 		wiphy_share_dfs_chan_state(wiphy, &rdev->wiphy);
@@ -3057,7 +3057,7 @@ static void notify_self_managed_wiphys(struct regulatory_request *request)
 	struct cfg80211_registered_device *rdev;
 	struct wiphy *wiphy;
 
-	list_for_each_entry(rdev, &cfg80211_rdev_list, list) {
+	for_each_rdev(rdev) {
 		wiphy = &rdev->wiphy;
 		if (wiphy->regulatory_flags & REGULATORY_WIPHY_SELF_MANAGED &&
 		    request->initiator == NL80211_REGDOM_SET_BY_USER)
@@ -3122,7 +3122,7 @@ static void reg_process_pending_beacon_hints(void)
 		list_del_init(&pending_beacon->list);
 
 		/* Applies the beacon hint to current wiphys */
-		list_for_each_entry(rdev, &cfg80211_rdev_list, list)
+		for_each_rdev(rdev)
 			wiphy_update_new_beacon(&rdev->wiphy, pending_beacon);
 
 		/* Remembers the beacon hint for new wiphys or reg changes */
@@ -3177,7 +3177,7 @@ static void reg_process_self_managed_hints(void)
 
 	ASSERT_RTNL();
 
-	list_for_each_entry(rdev, &cfg80211_rdev_list, list) {
+	for_each_rdev(rdev) {
 		wiphy_lock(&rdev->wiphy);
 		reg_process_self_managed_hint(&rdev->wiphy);
 		wiphy_unlock(&rdev->wiphy);
@@ -3517,7 +3517,7 @@ static void restore_regulatory_settings(bool reset_user, bool cached)
 	world_alpha2[0] = cfg80211_world_regdom->alpha2[0];
 	world_alpha2[1] = cfg80211_world_regdom->alpha2[1];
 
-	list_for_each_entry(rdev, &cfg80211_rdev_list, list) {
+	for_each_rdev(rdev) {
 		if (rdev->wiphy.regulatory_flags & REGULATORY_WIPHY_SELF_MANAGED)
 			continue;
 		if (rdev->wiphy.regulatory_flags & REGULATORY_CUSTOM_REG)
@@ -3574,7 +3574,7 @@ static bool is_wiphy_all_set_reg_flag(enum ieee80211_regulatory_flags flag)
 	struct cfg80211_registered_device *rdev;
 	struct wireless_dev *wdev;
 
-	list_for_each_entry(rdev, &cfg80211_rdev_list, list) {
+	for_each_rdev(rdev) {
 		list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
 			wdev_lock(wdev);
 			if (!(wdev->wiphy->regulatory_flags & flag)) {
@@ -4244,7 +4244,7 @@ void regulatory_propagate_dfs_state(struct wiphy *wiphy,
 	if (WARN_ON(!cfg80211_chandef_valid(chandef)))
 		return;
 
-	list_for_each_entry(rdev, &cfg80211_rdev_list, list) {
+	for_each_rdev(rdev) {
 		if (wiphy == &rdev->wiphy)
 			continue;
 
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 9bba233b5a6e..53ba46f85ceb 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -702,7 +702,7 @@ static bool cfg80211_is_all_idle(void)
 	 * need not issue a disconnect hint and reset any info such
 	 * as chan dfs state, etc.
 	 */
-	list_for_each_entry(rdev, &cfg80211_rdev_list, list) {
+	for_each_rdev(rdev) {
 		list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
 			wdev_lock(wdev);
 			if (wdev->conn || wdev->connected ||
-- 
2.41.0

