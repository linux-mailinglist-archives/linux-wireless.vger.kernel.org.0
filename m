Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F2D77E2BD
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 15:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245539AbjHPNiX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 09:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245595AbjHPNiK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 09:38:10 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B02B9
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 06:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=kWIo1I2Ep1aOIdQRXWqSDH7m7APiWOq3kBZUNeBNZLU=;
        t=1692193088; x=1693402688; b=JePyKHPPEkxPO7oR1LHmkcVjnSVcRqHFMsgw0rgh2kKoXjj
        NMOgwoxzMPQjThDmtGqy4l/aGcjmYy60zbC7dS7TilJD8MMh/gkxa1mK7KHE0mupZYRE75/zklvpS
        8IQJWZx97FXT7aUy6axRcYZrAVLE97t96xnHO6LSIqpKA6q5HCnCHWAhAB8f3rlWorOGXp398JsWm
        Jfe4JUaOVJgaNIhOjGkIPrqogfZEuQZUJHm+RhREepwFOBb3hY5Np5fjgsqCp2Vga1PC7XaROLayr
        U8bkDQlk0hKiUienYhCvYbeb04eNPbWFsGR1KaO6lvKU1KLTcfOe+KSqFwgYSm+w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qWGis-00AyJT-1G;
        Wed, 16 Aug 2023 15:38:06 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Max Schulze <max.schulze@online.de>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH v4 6.1] wifi: cfg80211: fix cqm_config access race
Date:   Wed, 16 Aug 2023 15:38:04 +0200
Message-ID: <20230816153803.b53dd297eacc.I1a1bb102329fc88e4712eaf394cba3025ada0dc7@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <ac96309a-8d8d-4435-36e6-6d152eb31876@online.de>
References: <ac96309a-8d8d-4435-36e6-6d152eb31876@online.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
the pointer, but that requires pulling the updates out into
an asynchronous worker so they can sleep and call back into
the driver.

Since we need to change the free anyway, also change it to
go back to the old settings if changing the settings fails.

Reported-by: Max Schulze <max.schulze@online.de>
Closes: https://lore.kernel.org/r/ac96309a-8d8d-4435-36e6-6d152eb31876@online.de
Fixes: 4a4b8169501b ("cfg80211: Accept multiple RSSI thresholds for CQM")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2: change approach to use async worker
v3: fix kfree in error path
v4: NULL out value on config removal
---
 include/net/cfg80211.h |  3 +-
 net/wireless/core.c    | 14 +++----
 net/wireless/core.h    |  6 ++-
 net/wireless/nl80211.c | 86 ++++++++++++++++++++++++++++--------------
 4 files changed, 71 insertions(+), 38 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index e09ff87146c1..0970eb47cb55 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5787,7 +5787,8 @@ struct wireless_dev {
 	} wext;
 #endif
 
-	struct cfg80211_cqm_config *cqm_config;
+	struct work_struct cqm_rssi_work;
+	struct cfg80211_cqm_config __rcu *cqm_config;
 
 	struct list_head pmsr_list;
 	spinlock_t pmsr_lock;
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 609b79fe4a74..a86e3819dfd6 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1114,16 +1114,11 @@ void wiphy_rfkill_set_hw_state_reason(struct wiphy *wiphy, bool blocked,
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
@@ -1166,7 +1161,10 @@ static void _cfg80211_unregister_wdev(struct wireless_dev *wdev,
 	if (wdev->netdev)
 		flush_work(&wdev->disconnect_wk);
 
-	cfg80211_cqm_config_free(wdev);
+	cancel_work_sync(&wdev->cqm_rssi_work);
+	/* deleted from the list, so can't be found from nl80211 any more */
+	cqm_config = rcu_access_pointer(wdev->cqm_config);
+	kfree_rcu(cqm_config, rcu_head);
 
 	/*
 	 * Ensure that all events have been processed and
@@ -1318,6 +1316,8 @@ void cfg80211_init_wdev(struct wireless_dev *wdev)
 	wdev->wext.connect.auth_type = NL80211_AUTHTYPE_AUTOMATIC;
 #endif
 
+	INIT_WORK(&wdev->cqm_rssi_work, cfg80211_cqm_rssi_notify_work);
+
 	if (wdev->wiphy->flags & WIPHY_FLAG_PS_ON_BY_DEFAULT)
 		wdev->ps = true;
 	else
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 775e16cb99ed..bd63419fa8f8 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -287,12 +287,16 @@ struct cfg80211_beacon_registration {
 };
 
 struct cfg80211_cqm_config {
+	struct rcu_head rcu_head;
 	u32 rssi_hyst;
 	s32 last_rssi_event_value;
+	enum nl80211_cqm_rssi_threshold_event last_rssi_event_type;
 	int n_rssi_thresholds;
 	s32 rssi_thresholds[];
 };
 
+void cfg80211_cqm_rssi_notify_work(struct work_struct *work);
+
 void cfg80211_destroy_ifaces(struct cfg80211_registered_device *rdev);
 
 /* free object */
@@ -556,8 +560,6 @@ cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 #define CFG80211_DEV_WARN_ON(cond)	({bool __r = (cond); __r; })
 #endif
 
-void cfg80211_cqm_config_free(struct wireless_dev *wdev);
-
 void cfg80211_release_pmsr(struct wireless_dev *wdev, u32 portid);
 void cfg80211_pmsr_wdev_down(struct wireless_dev *wdev);
 void cfg80211_pmsr_free_wk(struct work_struct *work);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 087c0c442e23..65f6c4304ad2 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -12561,7 +12561,8 @@ static int nl80211_set_cqm_txe(struct genl_info *info,
 }
 
 static int cfg80211_cqm_rssi_update(struct cfg80211_registered_device *rdev,
-				    struct net_device *dev)
+				    struct net_device *dev,
+				    struct cfg80211_cqm_config *cqm_config)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	s32 last, low, high;
@@ -12570,7 +12571,7 @@ static int cfg80211_cqm_rssi_update(struct cfg80211_registered_device *rdev,
 	int err;
 
 	/* RSSI reporting disabled? */
-	if (!wdev->cqm_config)
+	if (!cqm_config)
 		return rdev_set_cqm_rssi_range_config(rdev, dev, 0, 0);
 
 	/*
@@ -12579,7 +12580,7 @@ static int cfg80211_cqm_rssi_update(struct cfg80211_registered_device *rdev,
 	 * connection is established and enough beacons received to calculate
 	 * the average.
 	 */
-	if (!wdev->cqm_config->last_rssi_event_value &&
+	if (!cqm_config->last_rssi_event_value &&
 	    wdev->links[0].client.current_bss &&
 	    rdev->ops->get_station) {
 		struct station_info sinfo = {};
@@ -12593,30 +12594,30 @@ static int cfg80211_cqm_rssi_update(struct cfg80211_registered_device *rdev,
 
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
@@ -12629,6 +12630,7 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
 				u32 hysteresis)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct cfg80211_cqm_config *cqm_config = NULL, *old;
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	int i, err;
@@ -12646,10 +12648,6 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
 	    wdev->iftype != NL80211_IFTYPE_P2P_CLIENT)
 		return -EOPNOTSUPP;
 
-	wdev_lock(wdev);
-	cfg80211_cqm_config_free(wdev);
-	wdev_unlock(wdev);
-
 	if (n_thresholds <= 1 && rdev->ops->set_cqm_rssi_config) {
 		if (n_thresholds == 0 || thresholds[0] == 0) /* Disabling */
 			return rdev_set_cqm_rssi_config(rdev, dev, 0, 0);
@@ -12666,9 +12664,9 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
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
@@ -12683,10 +12681,18 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
 		       flex_array_size(cqm_config, rssi_thresholds,
 				       n_thresholds));
 
-		wdev->cqm_config = cqm_config;
+		rcu_assign_pointer(wdev->cqm_config, cqm_config);
+	} else {
+		RCU_INIT_POINTER(wdev->cqm_config, NULL);
 	}
 
-	err = cfg80211_cqm_rssi_update(rdev, dev);
+	err = cfg80211_cqm_rssi_update(rdev, dev, cqm_config);
+	if (err) {
+		rcu_assign_pointer(wdev->cqm_config, old);
+		kfree_rcu(cqm_config, rcu_head);
+	} else {
+		kfree_rcu(old, rcu_head);
+	}
 
 unlock:
 	wdev_unlock(wdev);
@@ -18715,9 +18721,8 @@ void cfg80211_cqm_rssi_notify(struct net_device *dev,
 			      enum nl80211_cqm_rssi_threshold_event rssi_event,
 			      s32 rssi_level, gfp_t gfp)
 {
-	struct sk_buff *msg;
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
-	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
+	struct cfg80211_cqm_config *cqm_config;
 
 	trace_cfg80211_cqm_rssi_notify(dev, rssi_event, rssi_level);
 
@@ -18725,16 +18730,42 @@ void cfg80211_cqm_rssi_notify(struct net_device *dev,
 		    rssi_event != NL80211_CQM_RSSI_THRESHOLD_EVENT_HIGH))
 		return;
 
-	if (wdev->cqm_config) {
-		wdev->cqm_config->last_rssi_event_value = rssi_level;
+	rcu_read_lock();
+	cqm_config = rcu_dereference(wdev->cqm_config);
+	if (cqm_config) {
+		cqm_config->last_rssi_event_value = rssi_level;
+		cqm_config->last_rssi_event_type = rssi_event;
+		schedule_work(&wdev->cqm_rssi_work);
+	}
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL(cfg80211_cqm_rssi_notify);
 
-		cfg80211_cqm_rssi_update(rdev, dev);
+void cfg80211_cqm_rssi_notify_work(struct work_struct *work)
+{
+	struct wireless_dev *wdev = container_of(work, struct wireless_dev,
+						 cqm_rssi_work);
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
+	enum nl80211_cqm_rssi_threshold_event rssi_event;
+	struct cfg80211_cqm_config *cqm_config;
+	struct sk_buff *msg;
+	s32 rssi_level;
 
-		if (rssi_level == 0)
-			rssi_level = wdev->cqm_config->last_rssi_event_value;
+	wdev_lock(wdev);
+	cqm_config = rcu_dereference_protected(wdev->cqm_config,
+					       lockdep_is_held(&wdev->mtx));
+	if (!wdev->cqm_config) {
+		wdev_unlock(wdev);
+		return;
 	}
 
-	msg = cfg80211_prepare_cqm(dev, NULL, gfp);
+	cfg80211_cqm_rssi_update(rdev, wdev->netdev, cqm_config);
+
+	rssi_level = cqm_config->last_rssi_event_value;
+	rssi_event = cqm_config->last_rssi_event_type;
+	wdev_unlock(wdev);
+
+	msg = cfg80211_prepare_cqm(wdev->netdev, NULL, GFP_KERNEL);
 	if (!msg)
 		return;
 
@@ -18746,14 +18777,13 @@ void cfg80211_cqm_rssi_notify(struct net_device *dev,
 				      rssi_level))
 		goto nla_put_failure;
 
-	cfg80211_send_cqm(msg, gfp);
+	cfg80211_send_cqm(msg, GFP_KERNEL);
 
 	return;
 
  nla_put_failure:
 	nlmsg_free(msg);
 }
-EXPORT_SYMBOL(cfg80211_cqm_rssi_notify);
 
 void cfg80211_cqm_txe_notify(struct net_device *dev,
 			     const u8 *peer, u32 num_packets,
-- 
2.41.0

