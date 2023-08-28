Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F2378AFA2
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjH1MGX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjH1MFy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:54 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7E511A
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=nXDnGfndAe9XUqr79dgB77fsXGAwin6wC26Q8j+YIgc=;
        t=1693224351; x=1694433951; b=Fs/Is/8tXCeVxDHOxFHe7miZjWpX40gDMDD1m++yJsuNj5N
        UOWx4or2SuQIiBktcklLnnVTPBUPhMr2aN4Ybh3TQ6DyOP7t1vOfmPEaOMtqRFw8JpVlYTf4metdO
        fZbYGf5+St80woqXrMsmNxxxHntYEJgz7LY8C1w34GwZqYDJ1qV+ybLB9xwzS1mVyPWOtoqjDOk/k
        R6ZHkdri2CFFPyG22pmM4F6nxo9ODM9+t2TWuoYp2IH38G2/GYAPbJCOc6KKyFgGkzFG3LKH2UqQR
        B8/Mu3pISkjKx+s7pr6LdsUOTpzl9icxr5tZV7oJ+hBl9ol5hVXHR7ywNJ/rmDvg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qab09-00Gjgt-1v;
        Mon, 28 Aug 2023 14:05:49 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 38/40] wifi: mac80211: reduce iflist_mtx
Date:   Mon, 28 Aug 2023 14:00:06 +0200
Message-ID: <20230828135928.7b2ace1dc931.Ic75f095387d82b8fb6ea68c576e2744b4c425a7c@changeid>
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

We now hold the wiphy mutex everywhere that we use or
needed the iflist_mtx, so we don't need this mutex any
more in mac80211. However, drivers may also iterate,
and in some cases (e.g. mt76) do so from high-priority
contexts. Thus, keep the mutex around but remove its
usage in mac80211 apart from those driver-visible parts
that are still needed.

Most of this change was done automatically with spatch,
with the parts that are still needed as described above
reverted manually.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c        |  8 ++++----
 net/mac80211/ibss.c       |  4 ++--
 net/mac80211/iface.c      | 28 ++++++++++++----------------
 net/mac80211/mlme.c       | 10 ++--------
 net/mac80211/offchannel.c |  8 ++++----
 net/mac80211/scan.c       | 12 +++++-------
 net/mac80211/util.c       |  1 -
 7 files changed, 29 insertions(+), 42 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 9e5c75c03dde..bb73e7de38ff 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2980,6 +2980,8 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
 	bool update_txp_type = false;
 	bool has_monitor = false;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	if (wdev) {
 		sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 
@@ -3027,7 +3029,6 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
 		break;
 	}
 
-	mutex_lock(&local->iflist_mtx);
 	list_for_each_entry(sdata, &local->interfaces, list) {
 		if (sdata->vif.type == NL80211_IFTYPE_MONITOR) {
 			has_monitor = true;
@@ -3043,7 +3044,6 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
 			continue;
 		ieee80211_recalc_txpower(sdata, update_txp_type);
 	}
-	mutex_unlock(&local->iflist_mtx);
 
 	if (has_monitor) {
 		sdata = wiphy_dereference(local->hw.wiphy,
@@ -4633,6 +4633,8 @@ static void
 ieee80211_color_change_bss_config_notify(struct ieee80211_sub_if_data *sdata,
 					 u8 color, int enable, u64 changed)
 {
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
 	sdata->vif.bss_conf.he_bss_color.color = color;
 	sdata->vif.bss_conf.he_bss_color.enabled = enable;
 	changed |= BSS_CHANGED_HE_BSS_COLOR;
@@ -4642,7 +4644,6 @@ ieee80211_color_change_bss_config_notify(struct ieee80211_sub_if_data *sdata,
 	if (!sdata->vif.bss_conf.nontransmitted && sdata->vif.mbssid_tx_vif) {
 		struct ieee80211_sub_if_data *child;
 
-		mutex_lock(&sdata->local->iflist_mtx);
 		list_for_each_entry(child, &sdata->local->interfaces, list) {
 			if (child != sdata && child->vif.mbssid_tx_vif == &sdata->vif) {
 				child->vif.bss_conf.he_bss_color.color = color;
@@ -4652,7 +4653,6 @@ ieee80211_color_change_bss_config_notify(struct ieee80211_sub_if_data *sdata,
 								  BSS_CHANGED_HE_BSS_COLOR);
 			}
 		}
-		mutex_unlock(&sdata->local->iflist_mtx);
 	}
 }
 
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 3c6370377234..b95098c13153 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -1738,7 +1738,8 @@ void ieee80211_ibss_notify_scan_completed(struct ieee80211_local *local)
 {
 	struct ieee80211_sub_if_data *sdata;
 
-	mutex_lock(&local->iflist_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	list_for_each_entry(sdata, &local->interfaces, list) {
 		if (!ieee80211_sdata_running(sdata))
 			continue;
@@ -1746,7 +1747,6 @@ void ieee80211_ibss_notify_scan_completed(struct ieee80211_local *local)
 			continue;
 		sdata->u.ibss.last_scan_completed = jiffies;
 	}
-	mutex_unlock(&local->iflist_mtx);
 }
 
 int ieee80211_ibss_join(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 9724a3d4545b..f7f58c3e8349 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -33,14 +33,13 @@
  * The interface list in each struct ieee80211_local is protected
  * three-fold:
  *
- * (1) modifications may only be done under the RTNL
- * (2) modifications and readers are protected against each other by
- *     the iflist_mtx.
- * (3) modifications are done in an RCU manner so atomic readers
+ * (1) modifications may only be done under the RTNL *and* wiphy mutex
+ *     *and* iflist_mtx
+ * (2) modifications are done in an RCU manner so atomic readers
  *     can traverse the list in RCU-safe blocks.
  *
  * As a consequence, reads (traversals) of the list can be protected
- * by either the RTNL, the iflist_mtx or RCU.
+ * by either the RTNL, the wiphy mutex, the iflist_mtx or RCU.
  */
 
 static void ieee80211_iface_work(struct wiphy *wiphy, struct wiphy_work *work);
@@ -160,6 +159,8 @@ static int ieee80211_verify_mac(struct ieee80211_sub_if_data *sdata, u8 *addr,
 	u8 *m;
 	int ret = 0;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	if (is_zero_ether_addr(local->hw.wiphy->addr_mask))
 		return 0;
 
@@ -176,7 +177,6 @@ static int ieee80211_verify_mac(struct ieee80211_sub_if_data *sdata, u8 *addr,
 	if (!check_dup)
 		return ret;
 
-	mutex_lock(&local->iflist_mtx);
 	list_for_each_entry(iter, &local->interfaces, list) {
 		if (iter == sdata)
 			continue;
@@ -195,7 +195,6 @@ static int ieee80211_verify_mac(struct ieee80211_sub_if_data *sdata, u8 *addr,
 			break;
 		}
 	}
-	mutex_unlock(&local->iflist_mtx);
 
 	return ret;
 }
@@ -1049,7 +1048,7 @@ void ieee80211_recalc_offload(struct ieee80211_local *local)
 	if (!ieee80211_hw_check(&local->hw, SUPPORTS_TX_ENCAP_OFFLOAD))
 		return;
 
-	mutex_lock(&local->iflist_mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	list_for_each_entry(sdata, &local->interfaces, list) {
 		if (!ieee80211_sdata_running(sdata))
@@ -1057,8 +1056,6 @@ void ieee80211_recalc_offload(struct ieee80211_local *local)
 
 		ieee80211_recalc_sdata_offload(sdata);
 	}
-
-	mutex_unlock(&local->iflist_mtx);
 }
 
 void ieee80211_adjust_monitor_flags(struct ieee80211_sub_if_data *sdata,
@@ -1917,6 +1914,8 @@ static void ieee80211_assign_perm_addr(struct ieee80211_local *local,
 	u8 tmp_addr[ETH_ALEN];
 	int i;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	/* default ... something at least */
 	memcpy(perm_addr, local->hw.wiphy->perm_addr, ETH_ALEN);
 
@@ -1924,8 +1923,6 @@ static void ieee80211_assign_perm_addr(struct ieee80211_local *local,
 	    local->hw.wiphy->n_addresses <= 1)
 		return;
 
-	mutex_lock(&local->iflist_mtx);
-
 	switch (type) {
 	case NL80211_IFTYPE_MONITOR:
 		/* doesn't matter */
@@ -1949,7 +1946,7 @@ static void ieee80211_assign_perm_addr(struct ieee80211_local *local,
 				if (!ieee80211_sdata_running(sdata))
 					continue;
 				memcpy(perm_addr, sdata->vif.addr, ETH_ALEN);
-				goto out_unlock;
+				return;
 			}
 		}
 		fallthrough;
@@ -2035,9 +2032,6 @@ static void ieee80211_assign_perm_addr(struct ieee80211_local *local,
 
 		break;
 	}
-
- out_unlock:
-	mutex_unlock(&local->iflist_mtx);
 }
 
 int ieee80211_if_add(struct ieee80211_local *local, const char *name,
@@ -2051,6 +2045,7 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 	int ret, i;
 
 	ASSERT_RTNL();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (type == NL80211_IFTYPE_P2P_DEVICE || type == NL80211_IFTYPE_NAN) {
 		struct wireless_dev *wdev;
@@ -2217,6 +2212,7 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 void ieee80211_if_remove(struct ieee80211_sub_if_data *sdata)
 {
 	ASSERT_RTNL();
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	mutex_lock(&sdata->local->iflist_mtx);
 	list_del_rcu(&sdata->list);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 43bf2f409000..195e7202d51d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2799,6 +2799,8 @@ static void ieee80211_set_associated(struct ieee80211_sub_if_data *sdata,
 	u64 vif_changed = BSS_CHANGED_ASSOC;
 	unsigned int link_id;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	sdata->u.mgd.associated = true;
 
 	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
@@ -2860,9 +2862,7 @@ static void ieee80211_set_associated(struct ieee80211_sub_if_data *sdata,
 						 vif_changed | changed[0]);
 	}
 
-	mutex_lock(&local->iflist_mtx);
 	ieee80211_recalc_ps(local);
-	mutex_unlock(&local->iflist_mtx);
 
 	/* leave this here to not change ordering in non-MLO cases */
 	if (!ieee80211_vif_is_mld(&sdata->vif))
@@ -3069,9 +3069,7 @@ static void ieee80211_reset_ap_probe(struct ieee80211_sub_if_data *sdata)
 
 	__ieee80211_stop_poll(sdata);
 
-	mutex_lock(&local->iflist_mtx);
 	ieee80211_recalc_ps(local);
-	mutex_unlock(&local->iflist_mtx);
 
 	if (ieee80211_hw_check(&sdata->local->hw, CONNECTION_MONITOR))
 		return;
@@ -3267,9 +3265,7 @@ static void ieee80211_mgd_probe_ap(struct ieee80211_sub_if_data *sdata,
 	if (already)
 		goto out;
 
-	mutex_lock(&sdata->local->iflist_mtx);
 	ieee80211_recalc_ps(sdata->local);
-	mutex_unlock(&sdata->local->iflist_mtx);
 
 	ifmgd->probe_send_count = 0;
 	ieee80211_mgd_probe_ap_send(sdata);
@@ -6094,9 +6090,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 		changed |= BSS_CHANGED_BEACON_INFO;
 		link->u.mgd.have_beacon = true;
 
-		mutex_lock(&local->iflist_mtx);
 		ieee80211_recalc_ps(local);
-		mutex_unlock(&local->iflist_mtx);
 
 		ieee80211_recalc_ps_vif(sdata);
 	}
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index 0e7e7561d0eb..8325fbb1645e 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -84,6 +84,8 @@ void ieee80211_offchannel_stop_vifs(struct ieee80211_local *local)
 {
 	struct ieee80211_sub_if_data *sdata;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	if (WARN_ON(local->use_chanctx))
 		return;
 
@@ -101,7 +103,6 @@ void ieee80211_offchannel_stop_vifs(struct ieee80211_local *local)
 					false);
 	ieee80211_flush_queues(local, NULL, false);
 
-	mutex_lock(&local->iflist_mtx);
 	list_for_each_entry(sdata, &local->interfaces, list) {
 		if (!ieee80211_sdata_running(sdata))
 			continue;
@@ -127,17 +128,17 @@ void ieee80211_offchannel_stop_vifs(struct ieee80211_local *local)
 		    sdata->u.mgd.associated)
 			ieee80211_offchannel_ps_enable(sdata);
 	}
-	mutex_unlock(&local->iflist_mtx);
 }
 
 void ieee80211_offchannel_return(struct ieee80211_local *local)
 {
 	struct ieee80211_sub_if_data *sdata;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	if (WARN_ON(local->use_chanctx))
 		return;
 
-	mutex_lock(&local->iflist_mtx);
 	list_for_each_entry(sdata, &local->interfaces, list) {
 		if (sdata->vif.type == NL80211_IFTYPE_P2P_DEVICE)
 			continue;
@@ -161,7 +162,6 @@ void ieee80211_offchannel_return(struct ieee80211_local *local)
 				BSS_CHANGED_BEACON_ENABLED);
 		}
 	}
-	mutex_unlock(&local->iflist_mtx);
 
 	ieee80211_wake_queues_by_reason(&local->hw, IEEE80211_MAX_QUEUE_MAP,
 					IEEE80211_QUEUE_STOP_REASON_OFFCHANNEL,
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 0ea86a418eda..58d525e41f6b 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -555,20 +555,18 @@ static bool __ieee80211_can_leave_ch(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_sub_if_data *sdata_iter;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	if (!ieee80211_is_radar_required(local))
 		return true;
 
 	if (!regulatory_pre_cac_allowed(local->hw.wiphy))
 		return false;
 
-	mutex_lock(&local->iflist_mtx);
 	list_for_each_entry(sdata_iter, &local->interfaces, list) {
-		if (sdata_iter->wdev.cac_started) {
-			mutex_unlock(&local->iflist_mtx);
+		if (sdata_iter->wdev.cac_started)
 			return false;
-		}
 	}
-	mutex_unlock(&local->iflist_mtx);
 
 	return true;
 }
@@ -860,12 +858,13 @@ static void ieee80211_scan_state_decision(struct ieee80211_local *local,
 	enum mac80211_scan_state next_scan_state;
 	struct cfg80211_scan_request *scan_req;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	/*
 	 * check if at least one STA interface is associated,
 	 * check if at least one STA interface has pending tx frames
 	 * and grab the lowest used beacon interval
 	 */
-	mutex_lock(&local->iflist_mtx);
 	list_for_each_entry(sdata, &local->interfaces, list) {
 		if (!ieee80211_sdata_running(sdata))
 			continue;
@@ -881,7 +880,6 @@ static void ieee80211_scan_state_decision(struct ieee80211_local *local,
 			}
 		}
 	}
-	mutex_unlock(&local->iflist_mtx);
 
 	scan_req = rcu_dereference_protected(local->scan_req,
 					     lockdep_is_held(&local->hw.wiphy->mtx));
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 0873c7d60a4d..7833043b0a4e 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -4322,7 +4322,6 @@ void ieee80211_dfs_cac_cancel(struct ieee80211_local *local)
 	struct ieee80211_sub_if_data *sdata;
 	struct cfg80211_chan_def chandef;
 
-	/* for interface list, to avoid linking iflist_mtx and chanctx_mtx */
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	list_for_each_entry(sdata, &local->interfaces, list) {
-- 
2.41.0

