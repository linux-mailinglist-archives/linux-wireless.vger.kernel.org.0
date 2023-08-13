Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2559E77A67D
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Aug 2023 15:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjHMNSh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Aug 2023 09:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHMNSg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Aug 2023 09:18:36 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE171710
        for <linux-wireless@vger.kernel.org>; Sun, 13 Aug 2023 06:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=d5JxrpP3T4gcioEHFfxL6P5ePFJmovjPjvz8UnyKSlo=;
        t=1691932718; x=1693142318; b=Enh3hi4zTNnbs9ZQrSgAjJclgagwmWOX8ZkzavviPmsQKYJ
        x+lZrmEdyGMqI+Zshe61lBPeyDinLy5ymB9Ijwu0AGkFnUrHrbfkOS/kbJfZpKo3iak7iZxCoIWsd
        wAtYQyGShHEr1XRKB9k7FlXC/0UzJ0CM08vxqERauZ9EPOyuukqUihalbrFUP42S4oEoS6se/cPGs
        gOXTl8dkTuk0R75hF4LVAxeJ8XxZQ1qtWrTDS3rmgYUYsUDPY0nYqgW3wW7P/M6Fzx32gTf1uLAGi
        myQ02HC/OtIQyB/j9A5sHA+BRx3e1KMJB4bYSOV5ORfIBX+TQ8V3sN2OuJY9frBQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qVAzK-004tIE-2H;
        Sun, 13 Aug 2023 15:18:34 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH] wifi: cfg80211: fix cqm_config access race
Date:   Sun, 13 Aug 2023 15:18:29 +0200
Message-ID: <20230813151828.ef56f5624c62.I1a1bb102329fc88e4712eaf394cba3025ada0dc7@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <ac96309a-8d8d-4435-36e6-6d152eb31876@online.de>
References: <ac96309a-8d8d-4435-36e6-6d152eb31876@online.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Max Schulze reports crashes with brcmfmac. The reason seems
to be a race between userspace removing the CQM config and
the driver calling cfg80211_cqm_rssi_notify(), where if the
data is freed while cfg80211_cqm_rssi_notify() runs it will
crash since it assumes wdev->cqm_config is set. This can't
be fixed with a simple non-NULL check since there's nothing
we can do for locking easily, so use RCU instead to protect
the pointer.

Since we need to change the free anyway, also change it to
go back to the old settings if changing the settings fails.

Fixes: 4a4b8169501b ("cfg80211: Accept multiple RSSI thresholds for CQM")
Closes: https://lore.kernel.org/r/ac96309a-8d8d-4435-36e6-6d152eb31876@online.de
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h |  2 +-
 net/wireless/core.c    | 11 ++++-----
 net/wireless/core.h    |  3 +--
 net/wireless/nl80211.c | 52 ++++++++++++++++++++++++------------------
 4 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d6fa7c8767ad..8de6e5c8c85e 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6014,7 +6014,7 @@ struct wireless_dev {
 	} wext;
 #endif
 
-	struct cfg80211_cqm_config *cqm_config;
+	struct cfg80211_cqm_config __rcu *cqm_config;
 
 	struct list_head pmsr_list;
 	spinlock_t pmsr_lock;
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 25bc2e50a061..598da9451f0e 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1181,16 +1181,11 @@ void wiphy_rfkill_set_hw_state_reason(struct wiphy *wiphy, bool blocked,
 }
 EXPORT_SYMBOL(wiphy_rfkill_set_hw_state_reason);
 
-void cfg80211_cqm_config_free(struct wireless_dev *wdev)
-{
-	kfree(wdev->cqm_config);
-	wdev->cqm_config = NULL;
-}
-
 static void _cfg80211_unregister_wdev(struct wireless_dev *wdev,
 				      bool unregister_netdev)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
+	struct cfg80211_cqm_config *cqm_config;
 	unsigned int link_id;
 
 	ASSERT_RTNL();
@@ -1227,7 +1222,9 @@ static void _cfg80211_unregister_wdev(struct wireless_dev *wdev,
 	kfree_sensitive(wdev->wext.keys);
 	wdev->wext.keys = NULL;
 #endif
-	cfg80211_cqm_config_free(wdev);
+	/* deleted from the list, so can't be found from nl80211 any more */
+	cqm_config = rcu_access_pointer(wdev->cqm_config);
+	kfree_rcu(cqm_config, rcu_head);
 
 	/*
 	 * Ensure that all events have been processed and
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 8a807b609ef7..62a91aa694a7 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -295,6 +295,7 @@ struct cfg80211_beacon_registration {
 };
 
 struct cfg80211_cqm_config {
+	struct rcu_head rcu_head;
 	u32 rssi_hyst;
 	s32 last_rssi_event_value;
 	int n_rssi_thresholds;
@@ -566,8 +567,6 @@ cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 #define CFG80211_DEV_WARN_ON(cond)	({bool __r = (cond); __r; })
 #endif
 
-void cfg80211_cqm_config_free(struct wireless_dev *wdev);
-
 void cfg80211_release_pmsr(struct wireless_dev *wdev, u32 portid);
 void cfg80211_pmsr_wdev_down(struct wireless_dev *wdev);
 void cfg80211_pmsr_free_wk(struct work_struct *work);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 8bcf8e293308..4f79c3543aed 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -12796,7 +12796,8 @@ static int nl80211_set_cqm_txe(struct genl_info *info,
 }
 
 static int cfg80211_cqm_rssi_update(struct cfg80211_registered_device *rdev,
-				    struct net_device *dev)
+				    struct net_device *dev,
+				    struct cfg80211_cqm_config *cqm_config)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	s32 last, low, high;
@@ -12805,7 +12806,7 @@ static int cfg80211_cqm_rssi_update(struct cfg80211_registered_device *rdev,
 	int err;
 
 	/* RSSI reporting disabled? */
-	if (!wdev->cqm_config)
+	if (!cqm_config)
 		return rdev_set_cqm_rssi_range_config(rdev, dev, 0, 0);
 
 	/*
@@ -12814,7 +12815,7 @@ static int cfg80211_cqm_rssi_update(struct cfg80211_registered_device *rdev,
 	 * connection is established and enough beacons received to calculate
 	 * the average.
 	 */
-	if (!wdev->cqm_config->last_rssi_event_value &&
+	if (!cqm_config->last_rssi_event_value &&
 	    wdev->links[0].client.current_bss &&
 	    rdev->ops->get_station) {
 		struct station_info sinfo = {};
@@ -12828,30 +12829,30 @@ static int cfg80211_cqm_rssi_update(struct cfg80211_registered_device *rdev,
 
 		cfg80211_sinfo_release_content(&sinfo);
 		if (sinfo.filled & BIT_ULL(NL80211_STA_INFO_BEACON_SIGNAL_AVG))
-			wdev->cqm_config->last_rssi_event_value =
+			cqm_config->last_rssi_event_value =
 				(s8) sinfo.rx_beacon_signal_avg;
 	}
 
-	last = wdev->cqm_config->last_rssi_event_value;
-	hyst = wdev->cqm_config->rssi_hyst;
-	n = wdev->cqm_config->n_rssi_thresholds;
+	last = cqm_config->last_rssi_event_value;
+	hyst = cqm_config->rssi_hyst;
+	n = cqm_config->n_rssi_thresholds;
 
 	for (i = 0; i < n; i++) {
 		i = array_index_nospec(i, n);
-		if (last < wdev->cqm_config->rssi_thresholds[i])
+		if (last < cqm_config->rssi_thresholds[i])
 			break;
 	}
 
 	low_index = i - 1;
 	if (low_index >= 0) {
 		low_index = array_index_nospec(low_index, n);
-		low = wdev->cqm_config->rssi_thresholds[low_index] - hyst;
+		low = cqm_config->rssi_thresholds[low_index] - hyst;
 	} else {
 		low = S32_MIN;
 	}
 	if (i < n) {
 		i = array_index_nospec(i, n);
-		high = wdev->cqm_config->rssi_thresholds[i] + hyst - 1;
+		high = cqm_config->rssi_thresholds[i] + hyst - 1;
 	} else {
 		high = S32_MAX;
 	}
@@ -12864,6 +12865,7 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
 				u32 hysteresis)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct cfg80211_cqm_config *cqm_config = NULL, *old;
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	int i, err;
@@ -12881,10 +12883,6 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
 	    wdev->iftype != NL80211_IFTYPE_P2P_CLIENT)
 		return -EOPNOTSUPP;
 
-	wdev_lock(wdev);
-	cfg80211_cqm_config_free(wdev);
-	wdev_unlock(wdev);
-
 	if (n_thresholds <= 1 && rdev->ops->set_cqm_rssi_config) {
 		if (n_thresholds == 0 || thresholds[0] == 0) /* Disabling */
 			return rdev_set_cqm_rssi_config(rdev, dev, 0, 0);
@@ -12901,9 +12899,9 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
 		n_thresholds = 0;
 
 	wdev_lock(wdev);
+	old = rcu_dereference_protected(wdev->cqm_config,
+					lockdep_is_held(&wdev->mtx));
 	if (n_thresholds) {
-		struct cfg80211_cqm_config *cqm_config;
-
 		cqm_config = kzalloc(struct_size(cqm_config, rssi_thresholds,
 						 n_thresholds),
 				     GFP_KERNEL);
@@ -12918,10 +12916,16 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
 		       flex_array_size(cqm_config, rssi_thresholds,
 				       n_thresholds));
 
-		wdev->cqm_config = cqm_config;
+		rcu_assign_pointer(wdev->cqm_config, cqm_config);
 	}
 
-	err = cfg80211_cqm_rssi_update(rdev, dev);
+	err = cfg80211_cqm_rssi_update(rdev, dev, cqm_config);
+	if (err) {
+		rcu_assign_pointer(wdev->cqm_config, old);
+		kfree(cqm_config);
+	} else {
+		kfree_rcu(old, rcu_head);
+	}
 
 unlock:
 	wdev_unlock(wdev);
@@ -19076,6 +19080,7 @@ void cfg80211_cqm_rssi_notify(struct net_device *dev,
 	struct sk_buff *msg;
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
+	struct cfg80211_cqm_config *cqm_config;
 
 	trace_cfg80211_cqm_rssi_notify(dev, rssi_event, rssi_level);
 
@@ -19083,14 +19088,17 @@ void cfg80211_cqm_rssi_notify(struct net_device *dev,
 		    rssi_event != NL80211_CQM_RSSI_THRESHOLD_EVENT_HIGH))
 		return;
 
-	if (wdev->cqm_config) {
-		wdev->cqm_config->last_rssi_event_value = rssi_level;
+	rcu_read_lock();
+	cqm_config = rcu_dereference(wdev->cqm_config);
+	if (cqm_config) {
+		cqm_config->last_rssi_event_value = rssi_level;
 
-		cfg80211_cqm_rssi_update(rdev, dev);
+		cfg80211_cqm_rssi_update(rdev, dev, cqm_config);
 
 		if (rssi_level == 0)
-			rssi_level = wdev->cqm_config->last_rssi_event_value;
+			rssi_level = cqm_config->last_rssi_event_value;
 	}
+	rcu_read_unlock();
 
 	msg = cfg80211_prepare_cqm(dev, NULL, gfp);
 	if (!msg)
-- 
2.41.0

