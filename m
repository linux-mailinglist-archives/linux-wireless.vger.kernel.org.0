Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB18152EADC
	for <lists+linux-wireless@lfdr.de>; Fri, 20 May 2022 13:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348547AbiETLc6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 May 2022 07:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348546AbiETLc4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 May 2022 07:32:56 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780FC580FD
        for <linux-wireless@vger.kernel.org>; Fri, 20 May 2022 04:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=oR437Dl/rx7+X3X7WnnsERsKete6yaEOBVBS8/asx5M=;
        t=1653046368; x=1654255968; b=QJKoAtiOnrRsG0Tc2uyv3BjYsTgtoM84xra0rY1yPJueEW+
        z1WSh2FlxaD7J3Aw2BuCu7F3qHSVtSZeX1czsP77NsS2oqb/ibhxTI+I+tL2osm/t6zYXE57DApK8
        p/W7nsf3zVwTFiBTvMJi349QxZZptEpcg/Bt0al4gxCc75TzB+C1zlkC4SooLUOXINzWgmGjzAfYj
        IsBRGlU7yFhYmijtE8ZOGwkrF3goaftEdRW0k9ShdXQbcIBAGKWL6xfR8bhAOeo2uYOrZp2Zujj5a
        TEr6RPqhTQ3CZCMtGMVzx9YV0ZTLqqax4HmKVLy/T32fbLTWCugnP6tolmxY29fQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ns0sA-00HJjx-1D;
        Fri, 20 May 2022 13:32:46 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4/4] mac80211: reorg some iface data structs for MLD
Date:   Fri, 20 May 2022 13:32:42 +0200
Message-Id: <20220520132938.418110601b17.I0d793aafc2c08cac45fbe634122165cc907114d6@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220520113242.129546-1-johannes@sipsolutions.net>
References: <20220520113242.129546-1-johannes@sipsolutions.net>
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

Start reorganizing interface related data structures toward
MLD. The most complex part here is for the keys, since we
have to split the various kinds of GTKs off to the link but
still need to use (for WEP) the other keys as a fallback
even for multicast frames.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/agg-rx.c         |   2 +-
 net/mac80211/agg-tx.c         |   2 +-
 net/mac80211/cfg.c            | 165 ++++++++++--------
 net/mac80211/chan.c           |  95 +++++------
 net/mac80211/debugfs_key.c    |   8 +-
 net/mac80211/debugfs_netdev.c |  12 +-
 net/mac80211/ethtool.c        |   2 +-
 net/mac80211/ht.c             |  13 +-
 net/mac80211/ibss.c           |  10 +-
 net/mac80211/ieee80211_i.h    | 173 ++++++++++---------
 net/mac80211/iface.c          |  44 ++---
 net/mac80211/key.c            |  38 +++--
 net/mac80211/mlme.c           | 310 +++++++++++++++++-----------------
 net/mac80211/ocb.c            |   4 +-
 net/mac80211/offchannel.c     |   6 +-
 net/mac80211/rx.c             |  25 +--
 net/mac80211/sta_info.c       |   5 +-
 net/mac80211/status.c         |   2 +-
 net/mac80211/tdls.c           |  12 +-
 net/mac80211/tx.c             |  61 +++----
 net/mac80211/util.c           |  22 ++-
 net/mac80211/wme.c            |   2 +-
 22 files changed, 533 insertions(+), 480 deletions(-)

diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index bfab39320004..a09240c87f22 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -242,7 +242,7 @@ static void ieee80211_send_addba_resp(struct sta_info *sta, u8 *da, u16 tid,
 	    sdata->vif.type == NL80211_IFTYPE_MESH_POINT)
 		memcpy(mgmt->bssid, sdata->vif.addr, ETH_ALEN);
 	else if (sdata->vif.type == NL80211_IFTYPE_STATION)
-		memcpy(mgmt->bssid, sdata->u.mgd.bssid, ETH_ALEN);
+		memcpy(mgmt->bssid, sdata->deflink.u.mgd.bssid, ETH_ALEN);
 	else if (sdata->vif.type == NL80211_IFTYPE_ADHOC)
 		memcpy(mgmt->bssid, sdata->u.ibss.bssid, ETH_ALEN);
 
diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 91878ed5ec46..b13f4b7b740d 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -82,7 +82,7 @@ static void ieee80211_send_addba_request(struct ieee80211_sub_if_data *sdata,
 	    sdata->vif.type == NL80211_IFTYPE_MESH_POINT)
 		memcpy(mgmt->bssid, sdata->vif.addr, ETH_ALEN);
 	else if (sdata->vif.type == NL80211_IFTYPE_STATION)
-		memcpy(mgmt->bssid, sdata->u.mgd.bssid, ETH_ALEN);
+		memcpy(mgmt->bssid, sdata->deflink.u.mgd.bssid, ETH_ALEN);
 	else if (sdata->vif.type == NL80211_IFTYPE_ADHOC)
 		memcpy(mgmt->bssid, sdata->u.ibss.bssid, ETH_ALEN);
 
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 1b23403602fc..040a766b8c19 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -205,7 +205,7 @@ static int ieee80211_change_iface(struct wiphy *wiphy,
 			return 0;
 
 		mutex_lock(&local->sta_mtx);
-		sta = sta_info_get(sdata, ifmgd->bssid);
+		sta = sta_info_get(sdata, sdata->deflink.u.mgd.bssid);
 		if (sta)
 			drv_sta_set_4addr(local, sdata, &sta->sta,
 					  params->use_4addr);
@@ -538,6 +538,7 @@ ieee80211_lookup_key(struct ieee80211_sub_if_data *sdata,
 		     u8 key_idx, bool pairwise, const u8 *mac_addr)
 {
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_key *key;
 	struct sta_info *sta;
 
 	if (mac_addr) {
@@ -559,6 +560,14 @@ ieee80211_lookup_key(struct ieee80211_sub_if_data *sdata,
 		return NULL;
 	}
 
+	if (pairwise && key_idx < NUM_DEFAULT_KEYS)
+		return rcu_dereference_check_key_mtx(local,
+						     sdata->keys[key_idx]);
+
+	key = rcu_dereference_check_key_mtx(local, sdata->deflink.gtk[key_idx]);
+	if (key)
+		return key;
+
 	if (key_idx < NUM_DEFAULT_KEYS)
 		return rcu_dereference_check_key_mtx(local,
 						     sdata->keys[key_idx]);
@@ -861,7 +870,7 @@ ieee80211_set_probe_resp(struct ieee80211_sub_if_data *sdata,
 	if (!resp || !resp_len)
 		return 1;
 
-	old = sdata_dereference(sdata->u.ap.probe_resp, sdata);
+	old = sdata_dereference(sdata->deflink.u.ap.probe_resp, sdata);
 
 	new = kzalloc(sizeof(struct probe_resp) + resp_len, GFP_KERNEL);
 	if (!new)
@@ -877,7 +886,7 @@ ieee80211_set_probe_resp(struct ieee80211_sub_if_data *sdata,
 	else if (cca)
 		new->cntdwn_counter_offsets[0] = cca->counter_offset_presp;
 
-	rcu_assign_pointer(sdata->u.ap.probe_resp, new);
+	rcu_assign_pointer(sdata->deflink.u.ap.probe_resp, new);
 	if (old)
 		kfree_rcu(old, rcu_head);
 
@@ -897,13 +906,13 @@ static int ieee80211_set_fils_discovery(struct ieee80211_sub_if_data *sdata,
 	fd->min_interval = params->min_interval;
 	fd->max_interval = params->max_interval;
 
-	old = sdata_dereference(sdata->u.ap.fils_discovery, sdata);
+	old = sdata_dereference(sdata->deflink.u.ap.fils_discovery, sdata);
 	new = kzalloc(sizeof(*new) + params->tmpl_len, GFP_KERNEL);
 	if (!new)
 		return -ENOMEM;
 	new->len = params->tmpl_len;
 	memcpy(new->data, params->tmpl, params->tmpl_len);
-	rcu_assign_pointer(sdata->u.ap.fils_discovery, new);
+	rcu_assign_pointer(sdata->deflink.u.ap.fils_discovery, new);
 
 	if (old)
 		kfree_rcu(old, rcu_head);
@@ -920,13 +929,14 @@ ieee80211_set_unsol_bcast_probe_resp(struct ieee80211_sub_if_data *sdata,
 	if (!params->tmpl || !params->tmpl_len)
 		return -EINVAL;
 
-	old = sdata_dereference(sdata->u.ap.unsol_bcast_probe_resp, sdata);
+	old = sdata_dereference(sdata->deflink.u.ap.unsol_bcast_probe_resp,
+				sdata);
 	new = kzalloc(sizeof(*new) + params->tmpl_len, GFP_KERNEL);
 	if (!new)
 		return -ENOMEM;
 	new->len = params->tmpl_len;
 	memcpy(new->data, params->tmpl, params->tmpl_len);
-	rcu_assign_pointer(sdata->u.ap.unsol_bcast_probe_resp, new);
+	rcu_assign_pointer(sdata->deflink.u.ap.unsol_bcast_probe_resp, new);
 
 	if (old)
 		kfree_rcu(old, rcu_head);
@@ -1007,8 +1017,7 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	int size, err;
 	u32 changed = BSS_CHANGED_BEACON;
 
-	old = sdata_dereference(sdata->u.ap.beacon, sdata);
-
+	old = sdata_dereference(sdata->deflink.u.ap.beacon, sdata);
 
 	/* Need to have a beacon head if we don't have one yet */
 	if (!params->head && !old)
@@ -1114,7 +1123,8 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 		changed |= BSS_CHANGED_FTM_RESPONDER;
 	}
 
-	rcu_assign_pointer(sdata->u.ap.beacon, new);
+	rcu_assign_pointer(sdata->deflink.u.ap.beacon, new);
+	sdata->u.ap.active = true;
 
 	if (old)
 		kfree_rcu(old, rcu_head);
@@ -1139,16 +1149,16 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	int i, err;
 	int prev_beacon_int;
 
-	old = sdata_dereference(sdata->u.ap.beacon, sdata);
+	old = sdata_dereference(sdata->deflink.u.ap.beacon, sdata);
 	if (old)
 		return -EALREADY;
 
 	if (params->smps_mode != NL80211_SMPS_OFF)
 		return -ENOTSUPP;
 
-	sdata->smps_mode = IEEE80211_SMPS_OFF;
+	sdata->deflink.smps_mode = IEEE80211_SMPS_OFF;
 
-	sdata->needed_rx_chains = sdata->local->rx_chains;
+	sdata->deflink.needed_rx_chains = sdata->local->rx_chains;
 
 	prev_beacon_int = sdata->vif.bss_conf.beacon_int;
 	sdata->vif.bss_conf.beacon_int = params->beacon_interval;
@@ -1269,11 +1279,12 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 
 	err = drv_start_ap(sdata->local, sdata);
 	if (err) {
-		old = sdata_dereference(sdata->u.ap.beacon, sdata);
+		old = sdata_dereference(sdata->deflink.u.ap.beacon, sdata);
 
 		if (old)
 			kfree_rcu(old, rcu_head);
-		RCU_INIT_POINTER(sdata->u.ap.beacon, NULL);
+		RCU_INIT_POINTER(sdata->deflink.u.ap.beacon, NULL);
+		sdata->u.ap.active = false;
 		goto error;
 	}
 
@@ -1311,7 +1322,7 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 	if (sdata->vif.bss_conf.csa_active || sdata->vif.bss_conf.color_change_active)
 		return -EBUSY;
 
-	old = sdata_dereference(sdata->u.ap.beacon, sdata);
+	old = sdata_dereference(sdata->deflink.u.ap.beacon, sdata);
 	if (!old)
 		return -ENOENT;
 
@@ -1332,12 +1343,12 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 
 static void ieee80211_free_next_beacon(struct ieee80211_sub_if_data *sdata)
 {
-	if (!sdata->u.ap.next_beacon)
+	if (!sdata->deflink.u.ap.next_beacon)
 		return;
 
-	kfree(sdata->u.ap.next_beacon->mbssid_ies);
-	kfree(sdata->u.ap.next_beacon);
-	sdata->u.ap.next_beacon = NULL;
+	kfree(sdata->deflink.u.ap.next_beacon->mbssid_ies);
+	kfree(sdata->deflink.u.ap.next_beacon);
+	sdata->deflink.u.ap.next_beacon = NULL;
 }
 
 static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
@@ -1354,23 +1365,24 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 
 	sdata_assert_lock(sdata);
 
-	old_beacon = sdata_dereference(sdata->u.ap.beacon, sdata);
+	old_beacon = sdata_dereference(sdata->deflink.u.ap.beacon, sdata);
 	if (!old_beacon)
 		return -ENOENT;
-	old_probe_resp = sdata_dereference(sdata->u.ap.probe_resp, sdata);
-	old_fils_discovery = sdata_dereference(sdata->u.ap.fils_discovery,
+	old_probe_resp = sdata_dereference(sdata->deflink.u.ap.probe_resp,
+					   sdata);
+	old_fils_discovery = sdata_dereference(sdata->deflink.u.ap.fils_discovery,
 					       sdata);
 	old_unsol_bcast_probe_resp =
-		sdata_dereference(sdata->u.ap.unsol_bcast_probe_resp,
+		sdata_dereference(sdata->deflink.u.ap.unsol_bcast_probe_resp,
 				  sdata);
 
 	/* abort any running channel switch */
 	mutex_lock(&local->mtx);
 	sdata->vif.bss_conf.csa_active = false;
-	if (sdata->csa_block_tx) {
+	if (sdata->deflink.csa_block_tx) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_block_tx = false;
+		sdata->deflink.csa_block_tx = false;
 	}
 
 	mutex_unlock(&local->mtx);
@@ -1383,10 +1395,11 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	netif_carrier_off(dev);
 
 	/* remove beacon and probe response */
-	RCU_INIT_POINTER(sdata->u.ap.beacon, NULL);
-	RCU_INIT_POINTER(sdata->u.ap.probe_resp, NULL);
-	RCU_INIT_POINTER(sdata->u.ap.fils_discovery, NULL);
-	RCU_INIT_POINTER(sdata->u.ap.unsol_bcast_probe_resp, NULL);
+	sdata->u.ap.active = false;
+	RCU_INIT_POINTER(sdata->deflink.u.ap.beacon, NULL);
+	RCU_INIT_POINTER(sdata->deflink.u.ap.probe_resp, NULL);
+	RCU_INIT_POINTER(sdata->deflink.u.ap.fils_discovery, NULL);
+	RCU_INIT_POINTER(sdata->deflink.u.ap.unsol_bcast_probe_resp, NULL);
 	kfree_rcu(old_beacon, rcu_head);
 	if (old_probe_resp)
 		kfree_rcu(old_probe_resp, rcu_head);
@@ -1409,7 +1422,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 
 	if (sdata->wdev.cac_started) {
 		chandef = sdata->vif.bss_conf.chandef;
-		cancel_delayed_work_sync(&sdata->dfs_cac_timer_work);
+		cancel_delayed_work_sync(&sdata->deflink.dfs_cac_timer_work);
 		cfg80211_cac_event(sdata->dev, &chandef,
 				   NL80211_RADAR_CAC_ABORTED,
 				   GFP_KERNEL);
@@ -2386,8 +2399,8 @@ static int ieee80211_join_mesh(struct wiphy *wiphy, struct net_device *dev,
 	sdata->control_port_over_nl80211 = setup->control_port_over_nl80211;
 
 	/* can mesh use other SMPS modes? */
-	sdata->smps_mode = IEEE80211_SMPS_OFF;
-	sdata->needed_rx_chains = sdata->local->rx_chains;
+	sdata->deflink.smps_mode = IEEE80211_SMPS_OFF;
+	sdata->deflink.needed_rx_chains = sdata->local->rx_chains;
 
 	mutex_lock(&sdata->local->mtx);
 	err = ieee80211_vif_use_channel(sdata, &setup->chandef,
@@ -2421,7 +2434,7 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
 	struct ieee80211_supported_band *sband;
 	u32 changed = 0;
 
-	if (!sdata_dereference(sdata->u.ap.beacon, sdata))
+	if (!sdata_dereference(sdata->deflink.u.ap.beacon, sdata))
 		return -ENOENT;
 
 	sband = ieee80211_get_sband(sdata);
@@ -2586,7 +2599,7 @@ static int ieee80211_scan(struct wiphy *wiphy,
 		 * the  frames sent while scanning on other channel will be
 		 * lost)
 		 */
-		if (sdata->u.ap.beacon &&
+		if (sdata->deflink.u.ap.beacon &&
 		    (!(wiphy->features & NL80211_FEATURE_AP_SCAN) ||
 		     !(req->flags & NL80211_SCAN_FLAG_AP)))
 			return -EOPNOTSUPP;
@@ -2767,14 +2780,15 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
 
 		switch (type) {
 		case NL80211_TX_POWER_AUTOMATIC:
-			sdata->user_power_level = IEEE80211_UNSET_POWER_LEVEL;
+			sdata->deflink.user_power_level =
+				IEEE80211_UNSET_POWER_LEVEL;
 			txp_type = NL80211_TX_POWER_LIMITED;
 			break;
 		case NL80211_TX_POWER_LIMITED:
 		case NL80211_TX_POWER_FIXED:
 			if (mbm < 0 || (mbm % 100))
 				return -EOPNOTSUPP;
-			sdata->user_power_level = MBM_TO_DBM(mbm);
+			sdata->deflink.user_power_level = MBM_TO_DBM(mbm);
 			break;
 		}
 
@@ -2807,7 +2821,7 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
 			has_monitor = true;
 			continue;
 		}
-		sdata->user_power_level = local->user_power_level;
+		sdata->deflink.user_power_level = local->user_power_level;
 		if (txp_type != sdata->vif.bss_conf.txpower_type)
 			update_txp_type = true;
 		sdata->vif.bss_conf.txpower_type = txp_type;
@@ -2823,7 +2837,7 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
 		sdata = wiphy_dereference(local->hw.wiphy,
 					  local->monitor_sdata);
 		if (sdata) {
-			sdata->user_power_level = local->user_power_level;
+			sdata->deflink.user_power_level = local->user_power_level;
 			if (txp_type != sdata->vif.bss_conf.txpower_type)
 				update_txp_type = true;
 			sdata->vif.bss_conf.txpower_type = txp_type;
@@ -2910,8 +2924,8 @@ int __ieee80211_request_smps_mgd(struct ieee80211_sub_if_data *sdata,
 	if (WARN_ON_ONCE(sdata->vif.type != NL80211_IFTYPE_STATION))
 		return -EINVAL;
 
-	old_req = sdata->u.mgd.req_smps;
-	sdata->u.mgd.req_smps = smps_mode;
+	old_req = sdata->deflink.u.mgd.req_smps;
+	sdata->deflink.u.mgd.req_smps = smps_mode;
 
 	if (old_req == smps_mode &&
 	    smps_mode != IEEE80211_SMPS_AUTOMATIC)
@@ -2926,7 +2940,7 @@ int __ieee80211_request_smps_mgd(struct ieee80211_sub_if_data *sdata,
 	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT)
 		return 0;
 
-	ap = sdata->u.mgd.bssid;
+	ap = sdata->deflink.u.mgd.bssid;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(sta, &sdata->local->sta_list, list) {
@@ -2950,7 +2964,7 @@ int __ieee80211_request_smps_mgd(struct ieee80211_sub_if_data *sdata,
 	err = ieee80211_send_smps_action(sdata, smps_mode,
 					 ap, ap);
 	if (err)
-		sdata->u.mgd.req_smps = old_req;
+		sdata->deflink.u.mgd.req_smps = old_req;
 	else if (smps_mode != IEEE80211_SMPS_OFF && tdls_peer_found)
 		ieee80211_teardown_tdls_peers(sdata);
 
@@ -2978,7 +2992,7 @@ static int ieee80211_set_power_mgmt(struct wiphy *wiphy, struct net_device *dev,
 
 	/* no change, but if automatic follow powersave */
 	sdata_lock(sdata);
-	__ieee80211_request_smps_mgd(sdata, sdata->u.mgd.req_smps);
+	__ieee80211_request_smps_mgd(sdata, sdata->deflink.u.mgd.req_smps);
 	sdata_unlock(sdata);
 
 	if (ieee80211_hw_check(&local->hw, SUPPORTS_DYNAMIC_PS))
@@ -3011,7 +3025,7 @@ static int ieee80211_set_cqm_rssi_config(struct wiphy *wiphy,
 	bss_conf->cqm_rssi_hyst = rssi_hyst;
 	bss_conf->cqm_rssi_low = 0;
 	bss_conf->cqm_rssi_high = 0;
-	sdata->u.mgd.last_cqm_event_signal = 0;
+	sdata->deflink.u.mgd.last_cqm_event_signal = 0;
 
 	/* tell the driver upon association, unless already associated */
 	if (sdata->u.mgd.associated &&
@@ -3036,7 +3050,7 @@ static int ieee80211_set_cqm_rssi_range_config(struct wiphy *wiphy,
 	bss_conf->cqm_rssi_high = rssi_high;
 	bss_conf->cqm_rssi_thold = 0;
 	bss_conf->cqm_rssi_hyst = 0;
-	sdata->u.mgd.last_cqm_event_signal = 0;
+	sdata->deflink.u.mgd.last_cqm_event_signal = 0;
 
 	/* tell the driver upon association, unless already associated */
 	if (sdata->u.mgd.associated &&
@@ -3130,8 +3144,8 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 	}
 
 	/* whatever, but channel contexts should not complain about that one */
-	sdata->smps_mode = IEEE80211_SMPS_OFF;
-	sdata->needed_rx_chains = local->rx_chains;
+	sdata->deflink.smps_mode = IEEE80211_SMPS_OFF;
+	sdata->deflink.needed_rx_chains = local->rx_chains;
 
 	err = ieee80211_vif_use_channel(sdata, chandef,
 					IEEE80211_CHANCTX_SHARED);
@@ -3139,7 +3153,7 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 		goto out_unlock;
 
 	ieee80211_queue_delayed_work(&sdata->local->hw,
-				     &sdata->dfs_cac_timer_work,
+				     &sdata->deflink.dfs_cac_timer_work,
 				     msecs_to_jiffies(cac_time_ms));
 
  out_unlock:
@@ -3159,7 +3173,7 @@ static void ieee80211_end_cac(struct wiphy *wiphy,
 		 * by the time it gets it, sdata->wdev.cac_started
 		 * will no longer be true
 		 */
-		cancel_delayed_work(&sdata->dfs_cac_timer_work);
+		cancel_delayed_work(&sdata->deflink.dfs_cac_timer_work);
 
 		if (sdata->wdev.cac_started) {
 			ieee80211_vif_release_channel(sdata);
@@ -3278,10 +3292,10 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif)
 				continue;
 
 			ieee80211_queue_work(&iter->local->hw,
-					     &iter->csa_finalize_work);
+					     &iter->deflink.csa_finalize_work);
 		}
 	}
-	ieee80211_queue_work(&local->hw, &sdata->csa_finalize_work);
+	ieee80211_queue_work(&local->hw, &sdata->deflink.csa_finalize_work);
 
 	rcu_read_unlock();
 }
@@ -3293,7 +3307,7 @@ void ieee80211_channel_switch_disconnect(struct ieee80211_vif *vif, bool block_t
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_local *local = sdata->local;
 
-	sdata->csa_block_tx = block_tx;
+	sdata->deflink.csa_block_tx = block_tx;
 	sdata_info(sdata, "channel switch failed, disconnecting\n");
 	ieee80211_queue_work(&local->hw, &ifmgd->csa_connection_drop_work);
 }
@@ -3306,10 +3320,11 @@ static int ieee80211_set_after_csa_beacon(struct ieee80211_sub_if_data *sdata,
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP:
-		if (!sdata->u.ap.next_beacon)
+		if (!sdata->deflink.u.ap.next_beacon)
 			return -EINVAL;
 
-		err = ieee80211_assign_beacon(sdata, sdata->u.ap.next_beacon,
+		err = ieee80211_assign_beacon(sdata,
+					      sdata->deflink.u.ap.next_beacon,
 					      NULL, NULL);
 		ieee80211_free_next_beacon(sdata);
 
@@ -3356,20 +3371,20 @@ static int __ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
 	 * completed successfully
 	 */
 
-	if (sdata->reserved_chanctx) {
+	if (sdata->deflink.reserved_chanctx) {
 		/*
 		 * with multi-vif csa driver may call ieee80211_csa_finish()
 		 * many times while waiting for other interfaces to use their
 		 * reservations
 		 */
-		if (sdata->reserved_ready)
+		if (sdata->deflink.reserved_ready)
 			return 0;
 
 		return ieee80211_vif_use_reserved_context(sdata);
 	}
 
 	if (!cfg80211_chandef_identical(&sdata->vif.bss_conf.chandef,
-					&sdata->csa_chandef))
+					&sdata->deflink.csa_chandef))
 		return -EINVAL;
 
 	sdata->vif.bss_conf.csa_active = false;
@@ -3380,17 +3395,17 @@ static int __ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
 
 	ieee80211_bss_info_change_notify(sdata, changed);
 
-	if (sdata->csa_block_tx) {
+	if (sdata->deflink.csa_block_tx) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_block_tx = false;
+		sdata->deflink.csa_block_tx = false;
 	}
 
 	err = drv_post_channel_switch(sdata);
 	if (err)
 		return err;
 
-	cfg80211_ch_switch_notify(sdata->dev, &sdata->csa_chandef, 0);
+	cfg80211_ch_switch_notify(sdata->dev, &sdata->deflink.csa_chandef, 0);
 
 	return 0;
 }
@@ -3408,7 +3423,7 @@ void ieee80211_csa_finalize_work(struct work_struct *work)
 {
 	struct ieee80211_sub_if_data *sdata =
 		container_of(work, struct ieee80211_sub_if_data,
-			     csa_finalize_work);
+			     deflink.csa_finalize_work);
 	struct ieee80211_local *local = sdata->local;
 
 	sdata_lock(sdata);
@@ -3439,9 +3454,9 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP:
-		sdata->u.ap.next_beacon =
+		sdata->deflink.u.ap.next_beacon =
 			cfg80211_beacon_dup(&params->beacon_after);
-		if (!sdata->u.ap.next_beacon)
+		if (!sdata->deflink.u.ap.next_beacon)
 			return -ENOMEM;
 
 		/*
@@ -3653,15 +3668,16 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 		goto out;
 	}
 
-	sdata->csa_chandef = params->chandef;
-	sdata->csa_block_tx = params->block_tx;
+	sdata->deflink.csa_chandef = params->chandef;
+	sdata->deflink.csa_block_tx = params->block_tx;
 	sdata->vif.bss_conf.csa_active = true;
 
-	if (sdata->csa_block_tx)
+	if (sdata->deflink.csa_block_tx)
 		ieee80211_stop_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
 
-	cfg80211_ch_switch_started_notify(sdata->dev, &sdata->csa_chandef,
+	cfg80211_ch_switch_started_notify(sdata->dev,
+					  &sdata->deflink.csa_chandef,
 					  params->count, params->block_tx);
 
 	if (changed) {
@@ -4308,10 +4324,11 @@ ieee80211_set_after_color_change_beacon(struct ieee80211_sub_if_data *sdata,
 	case NL80211_IFTYPE_AP: {
 		int ret;
 
-		if (!sdata->u.ap.next_beacon)
+		if (!sdata->deflink.u.ap.next_beacon)
 			return -EINVAL;
 
-		ret = ieee80211_assign_beacon(sdata, sdata->u.ap.next_beacon,
+		ret = ieee80211_assign_beacon(sdata,
+					      sdata->deflink.u.ap.next_beacon,
 					      NULL, NULL);
 		ieee80211_free_next_beacon(sdata);
 
@@ -4339,9 +4356,9 @@ ieee80211_set_color_change_beacon(struct ieee80211_sub_if_data *sdata,
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP:
-		sdata->u.ap.next_beacon =
+		sdata->deflink.u.ap.next_beacon =
 			cfg80211_beacon_dup(&params->beacon_next);
-		if (!sdata->u.ap.next_beacon)
+		if (!sdata->deflink.u.ap.next_beacon)
 			return -ENOMEM;
 
 		if (params->count <= 1)
@@ -4423,7 +4440,7 @@ void ieee80211_color_change_finalize_work(struct work_struct *work)
 {
 	struct ieee80211_sub_if_data *sdata =
 		container_of(work, struct ieee80211_sub_if_data,
-			     color_change_finalize_work);
+			     deflink.color_change_finalize_work);
 	struct ieee80211_local *local = sdata->local;
 
 	sdata_lock(sdata);
@@ -4448,7 +4465,7 @@ void ieee80211_color_change_finish(struct ieee80211_vif *vif)
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
 
 	ieee80211_queue_work(&sdata->local->hw,
-			     &sdata->color_change_finalize_work);
+			     &sdata->deflink.color_change_finalize_work);
 }
 EXPORT_SYMBOL_GPL(ieee80211_color_change_finish);
 
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 8bcdddaf066d..9c189fe8c940 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -92,9 +92,9 @@ ieee80211_chanctx_reserved_chandef(struct ieee80211_local *local,
 	list_for_each_entry(sdata, &ctx->reserved_vifs,
 			    reserved_chanctx_list) {
 		if (!compat)
-			compat = &sdata->reserved_chandef;
+			compat = &sdata->deflink.reserved_chandef;
 
-		compat = cfg80211_chandef_compatible(&sdata->reserved_chandef,
+		compat = cfg80211_chandef_compatible(&sdata->deflink.reserved_chandef,
 						     compat);
 		if (!compat)
 			break;
@@ -114,7 +114,7 @@ ieee80211_chanctx_non_reserved_chandef(struct ieee80211_local *local,
 
 	list_for_each_entry(sdata, &ctx->assigned_vifs,
 			    assigned_chanctx_list) {
-		if (sdata->reserved_chanctx != NULL)
+		if (sdata->deflink.reserved_chanctx != NULL)
 			continue;
 
 		if (!compat)
@@ -508,7 +508,7 @@ bool ieee80211_is_radar_required(struct ieee80211_local *local)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
-		if (sdata->radar_required) {
+		if (sdata->deflink.radar_required) {
 			rcu_read_unlock();
 			return true;
 		}
@@ -535,7 +535,7 @@ ieee80211_chanctx_radar_required(struct ieee80211_local *local,
 			continue;
 		if (rcu_access_pointer(sdata->vif.bss_conf.chanctx_conf) != conf)
 			continue;
-		if (!sdata->radar_required)
+		if (!sdata->deflink.radar_required)
 			continue;
 
 		required = true;
@@ -848,18 +848,18 @@ void ieee80211_recalc_smps_chanctx(struct ieee80211_local *local,
 			WARN_ON_ONCE(1);
 		}
 
-		switch (sdata->smps_mode) {
+		switch (sdata->deflink.smps_mode) {
 		default:
 			WARN_ONCE(1, "Invalid SMPS mode %d\n",
-				  sdata->smps_mode);
+				  sdata->deflink.smps_mode);
 			fallthrough;
 		case IEEE80211_SMPS_OFF:
-			needed_static = sdata->needed_rx_chains;
-			needed_dynamic = sdata->needed_rx_chains;
+			needed_static = sdata->deflink.needed_rx_chains;
+			needed_dynamic = sdata->deflink.needed_rx_chains;
 			break;
 		case IEEE80211_SMPS_DYNAMIC:
 			needed_static = 1;
-			needed_dynamic = sdata->needed_rx_chains;
+			needed_dynamic = sdata->deflink.needed_rx_chains;
 			break;
 		case IEEE80211_SMPS_STATIC:
 			needed_static = 1;
@@ -942,7 +942,7 @@ void ieee80211_vif_copy_chanctx_to_vlans(struct ieee80211_sub_if_data *sdata,
 
 int ieee80211_vif_unreserve_chanctx(struct ieee80211_sub_if_data *sdata)
 {
-	struct ieee80211_chanctx *ctx = sdata->reserved_chanctx;
+	struct ieee80211_chanctx *ctx = sdata->deflink.reserved_chanctx;
 
 	lockdep_assert_held(&sdata->local->chanctx_mtx);
 
@@ -950,7 +950,7 @@ int ieee80211_vif_unreserve_chanctx(struct ieee80211_sub_if_data *sdata)
 		return -EINVAL;
 
 	list_del(&sdata->reserved_chanctx_list);
-	sdata->reserved_chanctx = NULL;
+	sdata->deflink.reserved_chanctx = NULL;
 
 	if (ieee80211_chanctx_refcount(sdata->local, ctx) == 0) {
 		if (ctx->replace_state == IEEE80211_CHANCTX_REPLACES_OTHER) {
@@ -1063,10 +1063,10 @@ int ieee80211_vif_reserve_chanctx(struct ieee80211_sub_if_data *sdata,
 	}
 
 	list_add(&sdata->reserved_chanctx_list, &new_ctx->reserved_vifs);
-	sdata->reserved_chanctx = new_ctx;
-	sdata->reserved_chandef = *chandef;
-	sdata->reserved_radar_required = radar_required;
-	sdata->reserved_ready = false;
+	sdata->deflink.reserved_chanctx = new_ctx;
+	sdata->deflink.reserved_chandef = *chandef;
+	sdata->deflink.reserved_radar_required = radar_required;
+	sdata->deflink.reserved_ready = false;
 
 	return 0;
 }
@@ -1080,7 +1080,7 @@ ieee80211_vif_chanctx_reservation_complete(struct ieee80211_sub_if_data *sdata)
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_OCB:
 		ieee80211_queue_work(&sdata->local->hw,
-				     &sdata->csa_finalize_work);
+				     &sdata->deflink.csa_finalize_work);
 		break;
 	case NL80211_IFTYPE_STATION:
 		ieee80211_queue_work(&sdata->local->hw,
@@ -1128,10 +1128,10 @@ ieee80211_vif_use_reserved_reassign(struct ieee80211_sub_if_data *sdata)
 	lockdep_assert_held(&local->mtx);
 	lockdep_assert_held(&local->chanctx_mtx);
 
-	new_ctx = sdata->reserved_chanctx;
+	new_ctx = sdata->deflink.reserved_chanctx;
 	old_ctx = ieee80211_vif_get_chanctx(sdata);
 
-	if (WARN_ON(!sdata->reserved_ready))
+	if (WARN_ON(!sdata->deflink.reserved_ready))
 		return -EBUSY;
 
 	if (WARN_ON(!new_ctx))
@@ -1145,14 +1145,14 @@ ieee80211_vif_use_reserved_reassign(struct ieee80211_sub_if_data *sdata)
 		return -EINVAL;
 
 	chandef = ieee80211_chanctx_non_reserved_chandef(local, new_ctx,
-				&sdata->reserved_chandef);
+				&sdata->deflink.reserved_chandef);
 	if (WARN_ON(!chandef))
 		return -EINVAL;
 
-	if (sdata->vif.bss_conf.chandef.width != sdata->reserved_chandef.width)
+	if (sdata->vif.bss_conf.chandef.width != sdata->deflink.reserved_chandef.width)
 		changed = BSS_CHANGED_BANDWIDTH;
 
-	ieee80211_vif_update_chandef(sdata, &sdata->reserved_chandef);
+	ieee80211_vif_update_chandef(sdata, &sdata->deflink.reserved_chandef);
 
 	ieee80211_change_chanctx(local, new_ctx, old_ctx, chandef);
 
@@ -1161,7 +1161,7 @@ ieee80211_vif_use_reserved_reassign(struct ieee80211_sub_if_data *sdata)
 	vif_chsw[0].new_ctx = &new_ctx->conf;
 
 	list_del(&sdata->reserved_chanctx_list);
-	sdata->reserved_chanctx = NULL;
+	sdata->deflink.reserved_chanctx = NULL;
 
 	err = drv_switch_vif_chanctx(local, vif_chsw, 1,
 				     CHANCTX_SWMODE_REASSIGN_VIF);
@@ -1204,9 +1204,9 @@ ieee80211_vif_use_reserved_assign(struct ieee80211_sub_if_data *sdata)
 	int err;
 
 	old_ctx = ieee80211_vif_get_chanctx(sdata);
-	new_ctx = sdata->reserved_chanctx;
+	new_ctx = sdata->deflink.reserved_chanctx;
 
-	if (WARN_ON(!sdata->reserved_ready))
+	if (WARN_ON(!sdata->deflink.reserved_ready))
 		return -EINVAL;
 
 	if (WARN_ON(old_ctx))
@@ -1220,14 +1220,14 @@ ieee80211_vif_use_reserved_assign(struct ieee80211_sub_if_data *sdata)
 		return -EINVAL;
 
 	chandef = ieee80211_chanctx_non_reserved_chandef(local, new_ctx,
-				&sdata->reserved_chandef);
+				&sdata->deflink.reserved_chandef);
 	if (WARN_ON(!chandef))
 		return -EINVAL;
 
 	ieee80211_change_chanctx(local, new_ctx, new_ctx, chandef);
 
 	list_del(&sdata->reserved_chanctx_list);
-	sdata->reserved_chanctx = NULL;
+	sdata->deflink.reserved_chanctx = NULL;
 
 	err = ieee80211_assign_vif_chanctx(sdata, new_ctx);
 	if (err) {
@@ -1249,7 +1249,7 @@ ieee80211_vif_has_in_place_reservation(struct ieee80211_sub_if_data *sdata)
 
 	lockdep_assert_held(&sdata->local->chanctx_mtx);
 
-	new_ctx = sdata->reserved_chanctx;
+	new_ctx = sdata->deflink.reserved_chanctx;
 	old_ctx = ieee80211_vif_get_chanctx(sdata);
 
 	if (!old_ctx)
@@ -1421,9 +1421,9 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		list_for_each_entry(sdata, &ctx->replace_ctx->assigned_vifs,
 				    assigned_chanctx_list) {
 			n_assigned++;
-			if (sdata->reserved_chanctx) {
+			if (sdata->deflink.reserved_chanctx) {
 				n_reserved++;
-				if (sdata->reserved_ready)
+				if (sdata->deflink.reserved_ready)
 					n_ready++;
 			}
 		}
@@ -1443,7 +1443,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		list_for_each_entry(sdata, &ctx->reserved_vifs,
 				    reserved_chanctx_list) {
 			if (ieee80211_vif_has_in_place_reservation(sdata) &&
-			    !sdata->reserved_ready)
+			    !sdata->deflink.reserved_ready)
 				return -EAGAIN;
 
 			old_ctx = ieee80211_vif_get_chanctx(sdata);
@@ -1457,7 +1457,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 				n_vifs_ctxless++;
 			}
 
-			if (sdata->reserved_radar_required)
+			if (sdata->deflink.reserved_radar_required)
 				ctx->conf.radar_enabled = true;
 		}
 	}
@@ -1524,13 +1524,14 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 
 			ieee80211_check_fast_xmit_iface(sdata);
 
-			sdata->radar_required = sdata->reserved_radar_required;
+			sdata->deflink.radar_required = sdata->deflink.reserved_radar_required;
 
 			if (sdata->vif.bss_conf.chandef.width !=
-			    sdata->reserved_chandef.width)
+			    sdata->deflink.reserved_chandef.width)
 				changed = BSS_CHANGED_BANDWIDTH;
 
-			ieee80211_vif_update_chandef(sdata, &sdata->reserved_chandef);
+			ieee80211_vif_update_chandef(sdata,
+						     &sdata->deflink.reserved_chandef);
 			if (changed)
 				ieee80211_bss_info_change_notify(sdata,
 								 changed);
@@ -1551,7 +1552,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 			list_del(&sdata->reserved_chanctx_list);
 			list_move(&sdata->assigned_chanctx_list,
 				  &ctx->assigned_vifs);
-			sdata->reserved_chanctx = NULL;
+			sdata->deflink.reserved_chanctx = NULL;
 
 			ieee80211_vif_chanctx_reservation_complete(sdata);
 		}
@@ -1569,10 +1570,10 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 					sdata)))
 				continue;
 
-			if (WARN_ON(sdata->reserved_chanctx != ctx))
+			if (WARN_ON(sdata->deflink.reserved_chanctx != ctx))
 				continue;
 
-			if (!sdata->reserved_ready)
+			if (!sdata->deflink.reserved_ready)
 				continue;
 
 			if (ieee80211_vif_get_chanctx(sdata))
@@ -1642,11 +1643,11 @@ static void __ieee80211_vif_release_channel(struct ieee80211_sub_if_data *sdata)
 
 	ctx = container_of(conf, struct ieee80211_chanctx, conf);
 
-	if (sdata->reserved_chanctx) {
-		if (sdata->reserved_chanctx->replace_state ==
+	if (sdata->deflink.reserved_chanctx) {
+		if (sdata->deflink.reserved_chanctx->replace_state ==
 		    IEEE80211_CHANCTX_REPLACES_OTHER &&
 		    ieee80211_chanctx_num_reserved(local,
-						   sdata->reserved_chanctx) > 1)
+						   sdata->deflink.reserved_chanctx) > 1)
 			use_reserved_switch = true;
 
 		ieee80211_vif_unreserve_chanctx(sdata);
@@ -1656,7 +1657,7 @@ static void __ieee80211_vif_release_channel(struct ieee80211_sub_if_data *sdata)
 	if (ieee80211_chanctx_refcount(local, ctx) == 0)
 		ieee80211_free_chanctx(local, ctx);
 
-	sdata->radar_required = false;
+	sdata->deflink.radar_required = false;
 
 	/* Unreserving may ready an in-place reservation. */
 	if (use_reserved_switch)
@@ -1686,7 +1687,7 @@ int ieee80211_vif_use_channel(struct ieee80211_sub_if_data *sdata,
 	if (ret > 0)
 		radar_detect_width = BIT(chandef->width);
 
-	sdata->radar_required = ret;
+	sdata->deflink.radar_required = ret;
 
 	ret = ieee80211_check_combinations(sdata, chandef, mode,
 					   radar_detect_width);
@@ -1717,7 +1718,7 @@ int ieee80211_vif_use_channel(struct ieee80211_sub_if_data *sdata,
 	ieee80211_recalc_radar_chanctx(local, ctx);
  out:
 	if (ret)
-		sdata->radar_required = false;
+		sdata->deflink.radar_required = false;
 
 	mutex_unlock(&local->chanctx_mtx);
 	return ret;
@@ -1733,7 +1734,7 @@ int ieee80211_vif_use_reserved_context(struct ieee80211_sub_if_data *sdata)
 	lockdep_assert_held(&local->mtx);
 	lockdep_assert_held(&local->chanctx_mtx);
 
-	new_ctx = sdata->reserved_chanctx;
+	new_ctx = sdata->deflink.reserved_chanctx;
 	old_ctx = ieee80211_vif_get_chanctx(sdata);
 
 	if (WARN_ON(!new_ctx))
@@ -1743,10 +1744,10 @@ int ieee80211_vif_use_reserved_context(struct ieee80211_sub_if_data *sdata)
 		    IEEE80211_CHANCTX_WILL_BE_REPLACED))
 		return -EINVAL;
 
-	if (WARN_ON(sdata->reserved_ready))
+	if (WARN_ON(sdata->deflink.reserved_ready))
 		return -EINVAL;
 
-	sdata->reserved_ready = true;
+	sdata->deflink.reserved_ready = true;
 
 	if (new_ctx->replace_state == IEEE80211_CHANCTX_REPLACE_NONE) {
 		if (old_ctx)
diff --git a/net/mac80211/debugfs_key.c b/net/mac80211/debugfs_key.c
index edc7792e1361..6f117648f5e0 100644
--- a/net/mac80211/debugfs_key.c
+++ b/net/mac80211/debugfs_key.c
@@ -395,9 +395,9 @@ void ieee80211_debugfs_key_update_default(struct ieee80211_sub_if_data *sdata)
 	debugfs_remove(sdata->debugfs.default_multicast_key);
 	sdata->debugfs.default_multicast_key = NULL;
 
-	if (sdata->default_multicast_key) {
+	if (sdata->deflink.default_multicast_key) {
 		key = key_mtx_dereference(sdata->local,
-					  sdata->default_multicast_key);
+					  sdata->deflink.default_multicast_key);
 		sprintf(buf, "../keys/%d", key->debugfs.cnt);
 		sdata->debugfs.default_multicast_key =
 			debugfs_create_symlink("default_multicast_key",
@@ -414,7 +414,7 @@ void ieee80211_debugfs_key_add_mgmt_default(struct ieee80211_sub_if_data *sdata)
 		return;
 
 	key = key_mtx_dereference(sdata->local,
-				  sdata->default_mgmt_key);
+				  sdata->deflink.default_mgmt_key);
 	if (key) {
 		sprintf(buf, "../keys/%d", key->debugfs.cnt);
 		sdata->debugfs.default_mgmt_key =
@@ -443,7 +443,7 @@ ieee80211_debugfs_key_add_beacon_default(struct ieee80211_sub_if_data *sdata)
 		return;
 
 	key = key_mtx_dereference(sdata->local,
-				  sdata->default_beacon_key);
+				  sdata->deflink.default_beacon_key);
 	if (key) {
 		sprintf(buf, "../keys/%d", key->debugfs.cnt);
 		sdata->debugfs.default_beacon_key =
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index dd71cb7b3f75..72989d209f63 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -208,8 +208,8 @@ IEEE80211_IF_FILE_R(rc_rateidx_vht_mcs_mask_5ghz);
 IEEE80211_IF_FILE(flags, flags, HEX);
 IEEE80211_IF_FILE(state, state, LHEX);
 IEEE80211_IF_FILE(txpower, vif.bss_conf.txpower, DEC);
-IEEE80211_IF_FILE(ap_power_level, ap_power_level, DEC);
-IEEE80211_IF_FILE(user_power_level, user_power_level, DEC);
+IEEE80211_IF_FILE(ap_power_level, deflink.ap_power_level, DEC);
+IEEE80211_IF_FILE(user_power_level, deflink.user_power_level, DEC);
 
 static ssize_t
 ieee80211_if_fmt_hw_queues(const struct ieee80211_sub_if_data *sdata,
@@ -232,7 +232,7 @@ ieee80211_if_fmt_hw_queues(const struct ieee80211_sub_if_data *sdata,
 IEEE80211_IF_FILE_R(hw_queues);
 
 /* STA attributes */
-IEEE80211_IF_FILE(bssid, u.mgd.bssid, MAC);
+IEEE80211_IF_FILE(bssid, deflink.u.mgd.bssid, MAC);
 IEEE80211_IF_FILE(aid, vif.cfg.aid, DEC);
 IEEE80211_IF_FILE(beacon_timeout, u.mgd.beacon_timeout, JIFFIES_TO_MS);
 
@@ -274,8 +274,8 @@ static ssize_t ieee80211_if_fmt_smps(const struct ieee80211_sub_if_data *sdata,
 {
 	if (sdata->vif.type == NL80211_IFTYPE_STATION)
 		return snprintf(buf, buflen, "request: %s\nused: %s\n",
-				smps_modes[sdata->u.mgd.req_smps],
-				smps_modes[sdata->smps_mode]);
+				smps_modes[sdata->deflink.u.mgd.req_smps],
+				smps_modes[sdata->deflink.smps_mode]);
 	return -EINVAL;
 }
 
@@ -337,7 +337,7 @@ static ssize_t ieee80211_if_parse_tkip_mic_test(
 			dev_kfree_skb(skb);
 			return -ENOTCONN;
 		}
-		memcpy(hdr->addr1, sdata->u.mgd.bssid, ETH_ALEN);
+		memcpy(hdr->addr1, sdata->deflink.u.mgd.bssid, ETH_ALEN);
 		memcpy(hdr->addr2, sdata->vif.addr, ETH_ALEN);
 		memcpy(hdr->addr3, addr, ETH_ALEN);
 		sdata_unlock(sdata);
diff --git a/net/mac80211/ethtool.c b/net/mac80211/ethtool.c
index e7a41db9e659..4b237abd4f74 100644
--- a/net/mac80211/ethtool.c
+++ b/net/mac80211/ethtool.c
@@ -105,7 +105,7 @@ static void ieee80211_get_stats(struct net_device *dev,
 	mutex_lock(&local->sta_mtx);
 
 	if (sdata->vif.type == NL80211_IFTYPE_STATION) {
-		sta = sta_info_get_bss(sdata, sdata->u.mgd.bssid);
+		sta = sta_info_get_bss(sdata, sdata->deflink.u.mgd.bssid);
 
 		if (!(sta && !WARN_ON(sta->sdata->dev != dev)))
 			goto do_survey;
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 171bd16b13f3..705deacebe04 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -433,7 +433,7 @@ void ieee80211_send_delba(struct ieee80211_sub_if_data *sdata,
 	    sdata->vif.type == NL80211_IFTYPE_MESH_POINT)
 		memcpy(mgmt->bssid, sdata->vif.addr, ETH_ALEN);
 	else if (sdata->vif.type == NL80211_IFTYPE_STATION)
-		memcpy(mgmt->bssid, sdata->u.mgd.bssid, ETH_ALEN);
+		memcpy(mgmt->bssid, sdata->deflink.u.mgd.bssid, ETH_ALEN);
 	else if (sdata->vif.type == NL80211_IFTYPE_ADHOC)
 		memcpy(mgmt->bssid, sdata->u.ibss.bssid, ETH_ALEN);
 
@@ -543,10 +543,11 @@ void ieee80211_request_smps_mgd_work(struct work_struct *work)
 {
 	struct ieee80211_sub_if_data *sdata =
 		container_of(work, struct ieee80211_sub_if_data,
-			     u.mgd.request_smps_work);
+			     deflink.u.mgd.request_smps_work);
 
 	sdata_lock(sdata);
-	__ieee80211_request_smps_mgd(sdata, sdata->u.mgd.driver_smps_mode);
+	__ieee80211_request_smps_mgd(sdata,
+				     sdata->deflink.u.mgd.driver_smps_mode);
 	sdata_unlock(sdata);
 }
 
@@ -558,12 +559,12 @@ void ieee80211_request_smps(struct ieee80211_vif *vif,
 	if (WARN_ON_ONCE(vif->type != NL80211_IFTYPE_STATION))
 		return;
 
-	if (sdata->u.mgd.driver_smps_mode == smps_mode)
+	if (sdata->deflink.u.mgd.driver_smps_mode == smps_mode)
 		return;
 
-	sdata->u.mgd.driver_smps_mode = smps_mode;
+	sdata->deflink.u.mgd.driver_smps_mode = smps_mode;
 	ieee80211_queue_work(&sdata->local->hw,
-			     &sdata->u.mgd.request_smps_work);
+			     &sdata->deflink.u.mgd.request_smps_work);
 }
 /* this might change ... don't want non-open drivers using it */
 EXPORT_SYMBOL_GPL(ieee80211_request_smps);
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 056da2ff65f4..a81af745892a 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -309,7 +309,7 @@ static void __ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 		mutex_unlock(&local->mtx);
 		return;
 	}
-	sdata->radar_required = radar_required;
+	sdata->deflink.radar_required = radar_required;
 	mutex_unlock(&local->mtx);
 
 	memcpy(ifibss->bssid, bssid, ETH_ALEN);
@@ -544,12 +544,12 @@ int ieee80211_ibss_finish_csa(struct ieee80211_sub_if_data *sdata)
 					IEEE80211_PRIVACY(ifibss->privacy));
 		/* XXX: should not really modify cfg80211 data */
 		if (cbss) {
-			cbss->channel = sdata->csa_chandef.chan;
+			cbss->channel = sdata->deflink.csa_chandef.chan;
 			cfg80211_put_bss(sdata->local->hw.wiphy, cbss);
 		}
 	}
 
-	ifibss->chandef = sdata->csa_chandef;
+	ifibss->chandef = sdata->deflink.csa_chandef;
 
 	/* generate the beacon */
 	return ieee80211_ibss_csa_beacon(sdata, NULL);
@@ -1853,8 +1853,8 @@ int ieee80211_ibss_join(struct ieee80211_sub_if_data *sdata,
 	changed |= BSS_CHANGED_HT | BSS_CHANGED_MCAST_RATE;
 	ieee80211_bss_info_change_notify(sdata, changed);
 
-	sdata->smps_mode = IEEE80211_SMPS_OFF;
-	sdata->needed_rx_chains = local->rx_chains;
+	sdata->deflink.smps_mode = IEEE80211_SMPS_OFF;
+	sdata->deflink.needed_rx_chains = local->rx_chains;
 	sdata->control_port_over_nl80211 = params->control_port_over_nl80211;
 
 	ieee80211_queue_work(&local->hw, &sdata->work);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 5a1347727b4a..f0a8bb444033 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -293,19 +293,13 @@ struct ps_data {
 };
 
 struct ieee80211_if_ap {
-	struct beacon_data __rcu *beacon;
-	struct probe_resp __rcu *probe_resp;
-	struct fils_discovery_data __rcu *fils_discovery;
-	struct unsol_bcast_probe_resp_data __rcu *unsol_bcast_probe_resp;
-
-	/* to be used after channel switch. */
-	struct cfg80211_beacon_data *next_beacon;
 	struct list_head vlans; /* write-protected with RTNL and local->mtx */
 
 	struct ps_data ps;
 	atomic_t num_mcast_sta; /* number of stations receiving multicast */
 
 	bool multicast_to_unicast;
+	bool active;
 };
 
 struct ieee80211_if_vlan {
@@ -456,29 +450,14 @@ struct ieee80211_if_managed {
 	   reconnect:1,
 	   associated:1;
 
-	struct cfg80211_bss *assoc_bss;
 	struct ieee80211_mgd_auth_data *auth_data;
 	struct ieee80211_mgd_assoc_data *assoc_data;
 
-	u8 bssid[ETH_ALEN] __aligned(2);
-
 	bool powersave; /* powersave requested for this iface */
 	bool broken_ap; /* AP is broken -- turn off powersave */
-	bool have_beacon;
-	u8 dtim_period;
-	enum ieee80211_smps_mode req_smps, /* requested smps mode */
-				 driver_smps_mode; /* smps mode request */
-
-	struct work_struct request_smps_work;
 
 	unsigned int flags;
 
-	bool csa_waiting_bcn;
-	bool csa_ignored_same_chan;
-
-	bool beacon_crc_valid;
-	u32 beacon_crc;
-
 	bool status_acked;
 	bool status_received;
 	__le16 status_fc;
@@ -503,39 +482,14 @@ struct ieee80211_if_managed {
 	 */
 	unsigned int uapsd_max_sp_len;
 
-	int wmm_last_param_set;
-	int mu_edca_last_param_set;
-
 	u8 use_4addr;
 
-	s16 p2p_noa_index;
-
-	struct ewma_beacon_signal ave_beacon_signal;
-
-	/*
-	 * Number of Beacon frames used in ave_beacon_signal. This can be used
-	 * to avoid generating less reliable cqm events that would be based
-	 * only on couple of received frames.
-	 */
-	unsigned int count_beacon_signal;
-
-	/* Number of times beacon loss was invoked. */
-	unsigned int beacon_loss_count;
-
-	/*
-	 * Last Beacon frame signal strength average (ave_beacon_signal / 16)
-	 * that triggered a cqm event. 0 indicates that no event has been
-	 * generated for the current association.
-	 */
-	int last_cqm_event_signal;
-
 	/*
 	 * State variables for keeping track of RSSI of the AP currently
 	 * connected to and informing driver when RSSI has gone
 	 * below/above a certain threshold.
 	 */
 	int rssi_min_thold, rssi_max_thold;
-	int last_ave_beacon_signal;
 
 	struct ieee80211_ht_cap ht_capa; /* configured ht-cap over-rides */
 	struct ieee80211_ht_cap ht_capa_mask; /* Valid parts of ht_capa */
@@ -901,6 +855,97 @@ struct ieee80211_if_nan {
 	struct idr function_inst_ids;
 };
 
+struct ieee80211_link_data_managed {
+	u8 bssid[ETH_ALEN] __aligned(2);
+
+	u8 dtim_period;
+	enum ieee80211_smps_mode req_smps, /* requested smps mode */
+				 driver_smps_mode; /* smps mode request */
+
+	s16 p2p_noa_index;
+
+	bool have_beacon;
+
+	bool csa_waiting_bcn;
+	bool csa_ignored_same_chan;
+
+	struct work_struct request_smps_work;
+	bool beacon_crc_valid;
+	u32 beacon_crc;
+	struct ewma_beacon_signal ave_beacon_signal;
+	int last_ave_beacon_signal;
+
+	/*
+	 * Number of Beacon frames used in ave_beacon_signal. This can be used
+	 * to avoid generating less reliable cqm events that would be based
+	 * only on couple of received frames.
+	 */
+	unsigned int count_beacon_signal;
+
+	/* Number of times beacon loss was invoked. */
+	unsigned int beacon_loss_count;
+
+	/*
+	 * Last Beacon frame signal strength average (ave_beacon_signal / 16)
+	 * that triggered a cqm event. 0 indicates that no event has been
+	 * generated for the current association.
+	 */
+	int last_cqm_event_signal;
+
+	int wmm_last_param_set;
+	int mu_edca_last_param_set;
+
+	struct cfg80211_bss *bss;
+};
+
+struct ieee80211_link_data_ap {
+	struct beacon_data __rcu *beacon;
+	struct probe_resp __rcu *probe_resp;
+	struct fils_discovery_data __rcu *fils_discovery;
+	struct unsol_bcast_probe_resp_data __rcu *unsol_bcast_probe_resp;
+
+	/* to be used after channel switch. */
+	struct cfg80211_beacon_data *next_beacon;
+};
+
+struct ieee80211_link_data {
+	/* multicast keys only */
+	struct ieee80211_key __rcu *gtk[NUM_DEFAULT_KEYS +
+					NUM_DEFAULT_MGMT_KEYS +
+					NUM_DEFAULT_BEACON_KEYS];
+	struct ieee80211_key __rcu *default_multicast_key;
+	struct ieee80211_key __rcu *default_mgmt_key;
+	struct ieee80211_key __rcu *default_beacon_key;
+
+	struct airtime_info airtime[IEEE80211_NUM_ACS];
+
+	struct work_struct csa_finalize_work;
+	bool csa_block_tx; /* write-protected by sdata_lock and local->mtx */
+	struct cfg80211_chan_def csa_chandef;
+
+	struct work_struct color_change_finalize_work;
+
+	/* context reservation -- protected with chanctx_mtx */
+	struct ieee80211_chanctx *reserved_chanctx;
+	struct cfg80211_chan_def reserved_chandef;
+	bool reserved_radar_required;
+	bool reserved_ready;
+
+	u8 needed_rx_chains;
+	enum ieee80211_smps_mode smps_mode;
+
+	int user_power_level; /* in dBm */
+	int ap_power_level; /* in dBm */
+
+	bool radar_required;
+	struct delayed_work dfs_cac_timer_work;
+
+	union {
+		struct ieee80211_link_data_managed mgd;
+		struct ieee80211_link_data_ap ap;
+	} u;
+};
+
 struct ieee80211_sub_if_data {
 	struct list_head list;
 
@@ -931,13 +976,8 @@ struct ieee80211_sub_if_data {
 	/* bit field of ACM bits (BIT(802.1D tag)) */
 	u8 wmm_acm;
 
-	struct ieee80211_key __rcu *keys[NUM_DEFAULT_KEYS +
-					 NUM_DEFAULT_MGMT_KEYS +
-					 NUM_DEFAULT_BEACON_KEYS];
+	struct ieee80211_key __rcu *keys[NUM_DEFAULT_KEYS];
 	struct ieee80211_key __rcu *default_unicast_key;
-	struct ieee80211_key __rcu *default_multicast_key;
-	struct ieee80211_key __rcu *default_mgmt_key;
-	struct ieee80211_key __rcu *default_beacon_key;
 
 	u16 sequence_number;
 	__be16 control_port_protocol;
@@ -949,23 +989,9 @@ struct ieee80211_sub_if_data {
 	struct ieee80211_tx_queue_params tx_conf[IEEE80211_NUM_ACS];
 	struct mac80211_qos_map __rcu *qos_map;
 
-	struct airtime_info airtime[IEEE80211_NUM_ACS];
-
-	struct work_struct csa_finalize_work;
-	bool csa_block_tx; /* write-protected by sdata_lock and local->mtx */
-	struct cfg80211_chan_def csa_chandef;
-
-	struct work_struct color_change_finalize_work;
-
 	struct list_head assigned_chanctx_list; /* protected by chanctx_mtx */
 	struct list_head reserved_chanctx_list; /* protected by chanctx_mtx */
 
-	/* context reservation -- protected with chanctx_mtx */
-	struct ieee80211_chanctx *reserved_chanctx;
-	struct cfg80211_chan_def reserved_chandef;
-	bool reserved_radar_required;
-	bool reserved_ready;
-
 	/* used to reconfigure hardware SM PS */
 	struct work_struct recalc_smps;
 
@@ -973,15 +999,6 @@ struct ieee80211_sub_if_data {
 	struct sk_buff_head skb_queue;
 	struct sk_buff_head status_queue;
 
-	u8 needed_rx_chains;
-	enum ieee80211_smps_mode smps_mode;
-
-	int user_power_level; /* in dBm */
-	int ap_power_level; /* in dBm */
-
-	bool radar_required;
-	struct delayed_work dfs_cac_timer_work;
-
 	/*
 	 * AP this belongs to: self in AP mode and
 	 * corresponding AP in VLAN mode, NULL for
@@ -1013,6 +1030,8 @@ struct ieee80211_sub_if_data {
 		struct ieee80211_if_nan nan;
 	} u;
 
+	struct ieee80211_link_data deflink;
+
 #ifdef CONFIG_MAC80211_DEBUGFS
 	struct {
 		struct dentry *subdir_stations;
@@ -1670,7 +1689,7 @@ static inline struct airtime_info *to_airtime_info(struct ieee80211_txq *txq)
 	}
 
 	sdata = vif_to_sdata(txq->vif);
-	return &sdata->airtime[txq->ac];
+	return &sdata->deflink.airtime[txq->ac];
 }
 
 /* To avoid divisions in the fast path, we keep pre-computed reciprocals for
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 9e0e71ca8068..6475b13eed04 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -60,11 +60,11 @@ bool __ieee80211_recalc_txpower(struct ieee80211_sub_if_data *sdata)
 	power = ieee80211_chandef_max_power(&chanctx_conf->def);
 	rcu_read_unlock();
 
-	if (sdata->user_power_level != IEEE80211_UNSET_POWER_LEVEL)
-		power = min(power, sdata->user_power_level);
+	if (sdata->deflink.user_power_level != IEEE80211_UNSET_POWER_LEVEL)
+		power = min(power, sdata->deflink.user_power_level);
 
-	if (sdata->ap_power_level != IEEE80211_UNSET_POWER_LEVEL)
-		power = min(power, sdata->ap_power_level);
+	if (sdata->deflink.ap_power_level != IEEE80211_UNSET_POWER_LEVEL)
+		power = min(power, sdata->deflink.ap_power_level);
 
 	if (power != sdata->vif.bss_conf.txpower) {
 		sdata->vif.bss_conf.txpower = power;
@@ -452,19 +452,19 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	mutex_lock(&local->mtx);
 	sdata->vif.bss_conf.csa_active = false;
 	if (sdata->vif.type == NL80211_IFTYPE_STATION)
-		sdata->u.mgd.csa_waiting_bcn = false;
-	if (sdata->csa_block_tx) {
+		sdata->deflink.u.mgd.csa_waiting_bcn = false;
+	if (sdata->deflink.csa_block_tx) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_block_tx = false;
+		sdata->deflink.csa_block_tx = false;
 	}
 	mutex_unlock(&local->mtx);
 	sdata_unlock(sdata);
 
-	cancel_work_sync(&sdata->csa_finalize_work);
-	cancel_work_sync(&sdata->color_change_finalize_work);
+	cancel_work_sync(&sdata->deflink.csa_finalize_work);
+	cancel_work_sync(&sdata->deflink.color_change_finalize_work);
 
-	cancel_delayed_work_sync(&sdata->dfs_cac_timer_work);
+	cancel_delayed_work_sync(&sdata->deflink.dfs_cac_timer_work);
 
 	if (sdata->wdev.cac_started) {
 		chandef = sdata->vif.bss_conf.chandef;
@@ -831,7 +831,7 @@ static int ieee80211_netdev_fill_forward_path(struct net_device_path_ctx *ctx,
 			}
 		}
 
-		sta = sta_info_get(sdata, sdata->u.mgd.bssid);
+		sta = sta_info_get(sdata, sdata->deflink.u.mgd.bssid);
 		break;
 	default:
 		goto out;
@@ -1208,7 +1208,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP_VLAN:
 		/* no need to tell driver, but set carrier and chanctx */
-		if (rtnl_dereference(sdata->bss->beacon)) {
+		if (sdata->bss->active) {
 			ieee80211_vif_vlan_copy_chanctx(sdata);
 			netif_carrier_on(dev);
 			ieee80211_set_vif_encap_ops(sdata);
@@ -1630,8 +1630,9 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 	static const u8 bssid_wildcard[ETH_ALEN] = {0xff, 0xff, 0xff,
 						    0xff, 0xff, 0xff};
 
-	/* clear type-dependent union */
+	/* clear type-dependent unions */
 	memset(&sdata->u, 0, sizeof(sdata->u));
+	memset(&sdata->deflink.u, 0, sizeof(sdata->deflink.u));
 
 	/* and set some type-dependent values */
 	sdata->vif.type = type;
@@ -1657,8 +1658,10 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 	skb_queue_head_init(&sdata->status_queue);
 	INIT_WORK(&sdata->work, ieee80211_iface_work);
 	INIT_WORK(&sdata->recalc_smps, ieee80211_recalc_smps_work);
-	INIT_WORK(&sdata->csa_finalize_work, ieee80211_csa_finalize_work);
-	INIT_WORK(&sdata->color_change_finalize_work, ieee80211_color_change_finalize_work);
+	INIT_WORK(&sdata->deflink.csa_finalize_work,
+		  ieee80211_csa_finalize_work);
+	INIT_WORK(&sdata->deflink.color_change_finalize_work,
+		  ieee80211_color_change_finalize_work);
 	INIT_LIST_HEAD(&sdata->assigned_chanctx_list);
 	INIT_LIST_HEAD(&sdata->reserved_chanctx_list);
 
@@ -1679,7 +1682,7 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 		sdata->vif.p2p = true;
 		fallthrough;
 	case NL80211_IFTYPE_STATION:
-		sdata->vif.bss_conf.bssid = sdata->u.mgd.bssid;
+		sdata->vif.bss_conf.bssid = sdata->deflink.u.mgd.bssid;
 		ieee80211_sta_setup_sdata(sdata);
 		break;
 	case NL80211_IFTYPE_OCB:
@@ -2076,7 +2079,7 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 
 	INIT_LIST_HEAD(&sdata->key_list);
 
-	INIT_DELAYED_WORK(&sdata->dfs_cac_timer_work,
+	INIT_DELAYED_WORK(&sdata->deflink.dfs_cac_timer_work,
 			  ieee80211_dfs_cac_timer_work);
 	INIT_DELAYED_WORK(&sdata->dec_tailroom_needed_wk,
 			  ieee80211_delayed_tailroom_dec);
@@ -2106,12 +2109,13 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 	}
 
 	for (i = 0; i < IEEE80211_NUM_ACS; i++)
-		init_airtime_info(&sdata->airtime[i], &local->airtime[i]);
+		init_airtime_info(&sdata->deflink.airtime[i],
+				  &local->airtime[i]);
 
 	ieee80211_set_default_queues(sdata);
 
-	sdata->ap_power_level = IEEE80211_UNSET_POWER_LEVEL;
-	sdata->user_power_level = local->user_power_level;
+	sdata->deflink.ap_power_level = IEEE80211_UNSET_POWER_LEVEL;
+	sdata->deflink.user_power_level = local->user_power_level;
 
 	/* setup type-dependent data */
 	ieee80211_setup_sdata(sdata, type);
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 81dda0ca4d9f..d09980cbc8be 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -351,8 +351,11 @@ static void __ieee80211_set_default_key(struct ieee80211_sub_if_data *sdata,
 
 	assert_key_lock(sdata->local);
 
-	if (idx >= 0 && idx < NUM_DEFAULT_KEYS)
+	if (idx >= 0 && idx < NUM_DEFAULT_KEYS) {
 		key = key_mtx_dereference(sdata->local, sdata->keys[idx]);
+		if (!key)
+			key = key_mtx_dereference(sdata->local, sdata->deflink.gtk[idx]);
+	}
 
 	if (uni) {
 		rcu_assign_pointer(sdata->default_unicast_key, key);
@@ -362,7 +365,7 @@ static void __ieee80211_set_default_key(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (multi)
-		rcu_assign_pointer(sdata->default_multicast_key, key);
+		rcu_assign_pointer(sdata->deflink.default_multicast_key, key);
 
 	ieee80211_debugfs_key_update_default(sdata);
 }
@@ -384,9 +387,10 @@ __ieee80211_set_default_mgmt_key(struct ieee80211_sub_if_data *sdata, int idx)
 
 	if (idx >= NUM_DEFAULT_KEYS &&
 	    idx < NUM_DEFAULT_KEYS + NUM_DEFAULT_MGMT_KEYS)
-		key = key_mtx_dereference(sdata->local, sdata->keys[idx]);
+		key = key_mtx_dereference(sdata->local,
+					  sdata->deflink.gtk[idx]);
 
-	rcu_assign_pointer(sdata->default_mgmt_key, key);
+	rcu_assign_pointer(sdata->deflink.default_mgmt_key, key);
 
 	ieee80211_debugfs_key_update_default(sdata);
 }
@@ -409,9 +413,10 @@ __ieee80211_set_default_beacon_key(struct ieee80211_sub_if_data *sdata, int idx)
 	if (idx >= NUM_DEFAULT_KEYS + NUM_DEFAULT_MGMT_KEYS &&
 	    idx < NUM_DEFAULT_KEYS + NUM_DEFAULT_MGMT_KEYS +
 	    NUM_DEFAULT_BEACON_KEYS)
-		key = key_mtx_dereference(sdata->local, sdata->keys[idx]);
+		key = key_mtx_dereference(sdata->local,
+					  sdata->deflink.gtk[idx]);
 
-	rcu_assign_pointer(sdata->default_beacon_key, key);
+	rcu_assign_pointer(sdata->deflink.default_beacon_key, key);
 
 	ieee80211_debugfs_key_update_default(sdata);
 }
@@ -501,13 +506,13 @@ static int ieee80211_key_replace(struct ieee80211_sub_if_data *sdata,
 						sdata->default_unicast_key);
 		defmultikey = old &&
 			old == key_mtx_dereference(sdata->local,
-						sdata->default_multicast_key);
+						sdata->deflink.default_multicast_key);
 		defmgmtkey = old &&
 			old == key_mtx_dereference(sdata->local,
-						sdata->default_mgmt_key);
+						sdata->deflink.default_mgmt_key);
 		defbeaconkey = old &&
 			old == key_mtx_dereference(sdata->local,
-						   sdata->default_beacon_key);
+						   sdata->deflink.default_beacon_key);
 
 		if (defunikey && !new)
 			__ieee80211_set_default_key(sdata, -1, true, false);
@@ -518,7 +523,11 @@ static int ieee80211_key_replace(struct ieee80211_sub_if_data *sdata,
 		if (defbeaconkey && !new)
 			__ieee80211_set_default_beacon_key(sdata, -1);
 
-		rcu_assign_pointer(sdata->keys[idx], new);
+		if (is_wep || pairwise)
+			rcu_assign_pointer(sdata->keys[idx], new);
+		else
+			rcu_assign_pointer(sdata->deflink.gtk[idx], new);
+
 		if (defunikey && new)
 			__ieee80211_set_default_key(sdata, new->conf.keyidx,
 						    true, false);
@@ -795,7 +804,7 @@ int ieee80211_key_link(struct ieee80211_key *key,
 		       struct sta_info *sta)
 {
 	static atomic_t key_color = ATOMIC_INIT(0);
-	struct ieee80211_key *old_key;
+	struct ieee80211_key *old_key = NULL;
 	int idx = key->conf.keyidx;
 	bool pairwise = key->conf.flags & IEEE80211_KEY_FLAG_PAIRWISE;
 	/*
@@ -824,7 +833,12 @@ int ieee80211_key_link(struct ieee80211_key *key,
 		old_key = key_mtx_dereference(sdata->local,
 					      sta->deflink.gtk[idx]);
 	} else {
-		old_key = key_mtx_dereference(sdata->local, sdata->keys[idx]);
+		if (idx < NUM_DEFAULT_KEYS)
+			old_key = key_mtx_dereference(sdata->local,
+						      sdata->keys[idx]);
+		if (!old_key)
+			old_key = key_mtx_dereference(sdata->local,
+						      sdata->deflink.gtk[idx]);
 	}
 
 	/* Non-pairwise keys must also not switch the cipher on rekey */
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 4a792e88568d..fd1b97e1e990 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -459,7 +459,7 @@ static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 	sdata_info(sdata,
 		   "AP %pM changed bandwidth, new config is %d.%03d MHz, "
 		   "width %d (%d.%03d/%d MHz)\n",
-		   ifmgd->bssid, chandef.chan->center_freq,
+		   sdata->deflink.u.mgd.bssid, chandef.chan->center_freq,
 		   chandef.chan->freq_offset, chandef.width,
 		   chandef.center_freq1, chandef.freq1_offset,
 		   chandef.center_freq2);
@@ -475,7 +475,7 @@ static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 	    !cfg80211_chandef_valid(&chandef)) {
 		sdata_info(sdata,
 			   "AP %pM changed caps/bw in a way we can't support (0x%x/0x%x) - disconnect\n",
-			   ifmgd->bssid, flags, ifmgd->flags);
+			   sdata->deflink.u.mgd.bssid, flags, ifmgd->flags);
 		return -EINVAL;
 	}
 
@@ -484,7 +484,7 @@ static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 	if (ret) {
 		sdata_info(sdata,
 			   "AP %pM changed bandwidth to incompatible one - disconnect\n",
-			   ifmgd->bssid);
+			   sdata->deflink.u.mgd.bssid);
 		return ret;
 	}
 
@@ -997,7 +997,7 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	if (sband->band != NL80211_BAND_6GHZ &&
 	    !(ifmgd->flags & IEEE80211_STA_DISABLE_HT))
 		ieee80211_add_ht_ie(sdata, skb, assoc_data->ap_ht_param,
-				    sband, chan, sdata->smps_mode);
+				    sband, chan, sdata->deflink.smps_mode);
 
 	/* if present, add any custom IEs that go before VHT */
 	if (assoc_data->ie_len) {
@@ -1201,9 +1201,9 @@ void ieee80211_send_4addr_nullfunc(struct ieee80211_local *local,
 	fc = cpu_to_le16(IEEE80211_FTYPE_DATA | IEEE80211_STYPE_NULLFUNC |
 			 IEEE80211_FCTL_FROMDS | IEEE80211_FCTL_TODS);
 	nullfunc->frame_control = fc;
-	memcpy(nullfunc->addr1, sdata->u.mgd.bssid, ETH_ALEN);
+	memcpy(nullfunc->addr1, sdata->deflink.u.mgd.bssid, ETH_ALEN);
 	memcpy(nullfunc->addr2, sdata->vif.addr, ETH_ALEN);
-	memcpy(nullfunc->addr3, sdata->u.mgd.bssid, ETH_ALEN);
+	memcpy(nullfunc->addr3, sdata->deflink.u.mgd.bssid, ETH_ALEN);
 	memcpy(nullfunc->addr4, sdata->vif.addr, ETH_ALEN);
 
 	IEEE80211_SKB_CB(skb)->flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT;
@@ -1239,13 +1239,13 @@ static void ieee80211_chswitch_work(struct work_struct *work)
 	 * completed successfully
 	 */
 
-	if (sdata->reserved_chanctx) {
+	if (sdata->deflink.reserved_chanctx) {
 		/*
 		 * with multi-vif csa driver may call ieee80211_csa_finish()
 		 * many times while waiting for other interfaces to use their
 		 * reservations
 		 */
-		if (sdata->reserved_ready)
+		if (sdata->deflink.reserved_ready)
 			goto out;
 
 		ret = ieee80211_vif_use_reserved_context(sdata);
@@ -1262,7 +1262,7 @@ static void ieee80211_chswitch_work(struct work_struct *work)
 	}
 
 	if (!cfg80211_chandef_identical(&sdata->vif.bss_conf.chandef,
-					&sdata->csa_chandef)) {
+					&sdata->deflink.csa_chandef)) {
 		sdata_info(sdata,
 			   "failed to finalize channel switch, disconnecting\n");
 		ieee80211_queue_work(&sdata->local->hw,
@@ -1270,7 +1270,7 @@ static void ieee80211_chswitch_work(struct work_struct *work)
 		goto out;
 	}
 
-	ifmgd->csa_waiting_bcn = true;
+	sdata->deflink.u.mgd.csa_waiting_bcn = true;
 
 	ieee80211_sta_reset_beacon_monitor(sdata);
 	ieee80211_sta_reset_conn_monitor(sdata);
@@ -1291,19 +1291,19 @@ static void ieee80211_chswitch_post_beacon(struct ieee80211_sub_if_data *sdata)
 
 	WARN_ON(!sdata->vif.bss_conf.csa_active);
 
-	if (sdata->csa_block_tx) {
+	if (sdata->deflink.csa_block_tx) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_block_tx = false;
+		sdata->deflink.csa_block_tx = false;
 	}
 
 	sdata->vif.bss_conf.csa_active = false;
-	ifmgd->csa_waiting_bcn = false;
+	sdata->deflink.u.mgd.csa_waiting_bcn = false;
 	/*
 	 * If the CSA IE is still present on the beacon after the switch,
 	 * we need to consider it as a new CSA (possibly to self).
 	 */
-	ifmgd->beacon_crc_valid = false;
+	sdata->deflink.u.mgd.beacon_crc_valid = false;
 
 	ret = drv_post_channel_switch(sdata);
 	if (ret) {
@@ -1314,7 +1314,8 @@ static void ieee80211_chswitch_post_beacon(struct ieee80211_sub_if_data *sdata)
 		return;
 	}
 
-	cfg80211_ch_switch_notify(sdata->dev, &sdata->reserved_chandef, 0);
+	cfg80211_ch_switch_notify(sdata->dev, &sdata->deflink.reserved_chandef,
+				  0);
 }
 
 void ieee80211_chswitch_done(struct ieee80211_vif *vif, bool success)
@@ -1356,11 +1357,11 @@ ieee80211_sta_abort_chanswitch(struct ieee80211_sub_if_data *sdata)
 	ieee80211_vif_unreserve_chanctx(sdata);
 	mutex_unlock(&local->chanctx_mtx);
 
-	if (sdata->csa_block_tx)
+	if (sdata->deflink.csa_block_tx)
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
 
-	sdata->csa_block_tx = false;
+	sdata->deflink.csa_block_tx = false;
 	sdata->vif.bss_conf.csa_active = false;
 
 	mutex_unlock(&local->mtx);
@@ -1376,7 +1377,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
-	struct cfg80211_bss *cbss = ifmgd->assoc_bss;
+	struct cfg80211_bss *cbss = sdata->deflink.u.mgd.bss;
 	struct ieee80211_chanctx_conf *conf;
 	struct ieee80211_chanctx *chanctx;
 	enum nl80211_band current_band;
@@ -1398,7 +1399,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	res = ieee80211_parse_ch_switch_ie(sdata, elems, current_band,
 					   bss->vht_cap_info,
 					   ifmgd->flags,
-					   ifmgd->bssid, &csa_ie);
+					   sdata->deflink.u.mgd.bssid, &csa_ie);
 
 	if (!res) {
 		ch_switch.timestamp = timestamp;
@@ -1412,7 +1413,8 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	if (res < 0)
 		goto lock_and_drop_connection;
 
-	if (beacon && sdata->vif.bss_conf.csa_active && !ifmgd->csa_waiting_bcn) {
+	if (beacon && sdata->vif.bss_conf.csa_active &&
+	    !sdata->deflink.u.mgd.csa_waiting_bcn) {
 		if (res)
 			ieee80211_sta_abort_chanswitch(sdata);
 		else
@@ -1427,7 +1429,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	    csa_ie.chandef.chan->band) {
 		sdata_info(sdata,
 			   "AP %pM switches to different band (%d MHz, width:%d, CF1/2: %d/%d MHz), disconnecting\n",
-			   ifmgd->bssid,
+			   sdata->deflink.u.mgd.bssid,
 			   csa_ie.chandef.chan->center_freq,
 			   csa_ie.chandef.width, csa_ie.chandef.center_freq1,
 			   csa_ie.chandef.center_freq2);
@@ -1440,7 +1442,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 			   "AP %pM switches to unsupported channel "
 			   "(%d.%03d MHz, width:%d, CF1/2: %d.%03d/%d MHz), "
 			   "disconnecting\n",
-			   ifmgd->bssid,
+			   sdata->deflink.u.mgd.bssid,
 			   csa_ie.chandef.chan->center_freq,
 			   csa_ie.chandef.chan->freq_offset,
 			   csa_ie.chandef.width, csa_ie.chandef.center_freq1,
@@ -1452,12 +1454,12 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	if (cfg80211_chandef_identical(&csa_ie.chandef,
 				       &sdata->vif.bss_conf.chandef) &&
 	    (!csa_ie.mode || !beacon)) {
-		if (ifmgd->csa_ignored_same_chan)
+		if (sdata->deflink.u.mgd.csa_ignored_same_chan)
 			return;
 		sdata_info(sdata,
 			   "AP %pM tries to chanswitch to same channel, ignore\n",
-			   ifmgd->bssid);
-		ifmgd->csa_ignored_same_chan = true;
+			   sdata->deflink.u.mgd.bssid);
+		sdata->deflink.u.mgd.csa_ignored_same_chan = true;
 		return;
 	}
 
@@ -1505,12 +1507,12 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	mutex_unlock(&local->chanctx_mtx);
 
 	sdata->vif.bss_conf.csa_active = true;
-	sdata->csa_chandef = csa_ie.chandef;
-	sdata->csa_block_tx = csa_ie.mode;
-	ifmgd->csa_ignored_same_chan = false;
-	ifmgd->beacon_crc_valid = false;
+	sdata->deflink.csa_chandef = csa_ie.chandef;
+	sdata->deflink.csa_block_tx = csa_ie.mode;
+	sdata->deflink.u.mgd.csa_ignored_same_chan = false;
+	sdata->deflink.u.mgd.beacon_crc_valid = false;
 
-	if (sdata->csa_block_tx)
+	if (sdata->deflink.csa_block_tx)
 		ieee80211_stop_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
 	mutex_unlock(&local->mtx);
@@ -1544,7 +1546,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	 * reset when the disconnection worker runs.
 	 */
 	sdata->vif.bss_conf.csa_active = true;
-	sdata->csa_block_tx = csa_ie.mode;
+	sdata->deflink.csa_block_tx = csa_ie.mode;
 
 	ieee80211_queue_work(&local->hw, &ifmgd->csa_connection_drop_work);
 	mutex_unlock(&local->chanctx_mtx);
@@ -1679,25 +1681,25 @@ static u32 ieee80211_handle_pwr_constr(struct ieee80211_sub_if_data *sdata,
 	    (!has_cisco_pwr || pwr_level_80211h <= pwr_level_cisco)) {
 		new_ap_level = pwr_level_80211h;
 
-		if (sdata->ap_power_level == new_ap_level)
+		if (sdata->deflink.ap_power_level == new_ap_level)
 			return 0;
 
 		sdata_dbg(sdata,
 			  "Limiting TX power to %d (%d - %d) dBm as advertised by %pM\n",
 			  pwr_level_80211h, chan_pwr, pwr_reduction_80211h,
-			  sdata->u.mgd.bssid);
+			  sdata->deflink.u.mgd.bssid);
 	} else {  /* has_cisco_pwr is always true here. */
 		new_ap_level = pwr_level_cisco;
 
-		if (sdata->ap_power_level == new_ap_level)
+		if (sdata->deflink.ap_power_level == new_ap_level)
 			return 0;
 
 		sdata_dbg(sdata,
 			  "Limiting TX power to %d dBm as advertised by %pM\n",
-			  pwr_level_cisco, sdata->u.mgd.bssid);
+			  pwr_level_cisco, sdata->deflink.u.mgd.bssid);
 	}
 
-	sdata->ap_power_level = new_ap_level;
+	sdata->deflink.ap_power_level = new_ap_level;
 	if (__ieee80211_recalc_txpower(sdata))
 		return BSS_CHANGED_TXPOWER;
 	return 0;
@@ -1765,11 +1767,11 @@ static bool ieee80211_powersave_allowed(struct ieee80211_sub_if_data *sdata)
 	if (mgd->flags & IEEE80211_STA_CONNECTION_POLL)
 		return false;
 
-	if (!mgd->have_beacon)
+	if (!sdata->deflink.u.mgd.have_beacon)
 		return false;
 
 	rcu_read_lock();
-	sta = sta_info_get(sdata, mgd->bssid);
+	sta = sta_info_get(sdata, sdata->deflink.u.mgd.bssid);
 	if (sta)
 		authorized = test_sta_flag(sta, WLAN_STA_AUTHORIZED);
 	rcu_read_unlock();
@@ -1807,7 +1809,7 @@ void ieee80211_recalc_ps(struct ieee80211_local *local)
 	}
 
 	if (count == 1 && ieee80211_powersave_allowed(found)) {
-		u8 dtimper = found->u.mgd.dtim_period;
+		u8 dtimper = found->deflink.u.mgd.dtim_period;
 
 		timeout = local->dynamic_ps_forced_timeout;
 		if (timeout < 0)
@@ -1935,7 +1937,7 @@ void ieee80211_dfs_cac_timer_work(struct work_struct *work)
 	struct delayed_work *delayed_work = to_delayed_work(work);
 	struct ieee80211_sub_if_data *sdata =
 		container_of(delayed_work, struct ieee80211_sub_if_data,
-			     dfs_cac_timer_work);
+			     deflink.dfs_cac_timer_work);
 	struct cfg80211_chan_def chandef = sdata->vif.bss_conf.chandef;
 
 	mutex_lock(&sdata->local->mtx);
@@ -2076,11 +2078,11 @@ ieee80211_sta_wmm_params(struct ieee80211_local *local,
 	 * the driver about it.
 	 */
 	mu_edca_count = mu_edca ? mu_edca->mu_qos_info & 0x0f : -1;
-	if (count == ifmgd->wmm_last_param_set &&
-	    mu_edca_count == ifmgd->mu_edca_last_param_set)
+	if (count == sdata->deflink.u.mgd.wmm_last_param_set &&
+	    mu_edca_count == sdata->deflink.u.mgd.mu_edca_last_param_set)
 		return false;
-	ifmgd->wmm_last_param_set = count;
-	ifmgd->mu_edca_last_param_set = mu_edca_count;
+	sdata->deflink.u.mgd.wmm_last_param_set = count;
+	sdata->deflink.u.mgd.mu_edca_last_param_set = mu_edca_count;
 
 	pos = wmm_param + 8;
 	left = wmm_param_len - 8;
@@ -2268,8 +2270,8 @@ static void ieee80211_set_associated(struct ieee80211_sub_if_data *sdata,
 		beacon_loss_count * bss_conf->beacon_int));
 
 	sdata->u.mgd.associated = true;
-	sdata->u.mgd.assoc_bss = cbss;
-	memcpy(sdata->u.mgd.bssid, cbss->bssid, ETH_ALEN);
+	sdata->deflink.u.mgd.bss = cbss;
+	memcpy(sdata->deflink.u.mgd.bssid, cbss->bssid, ETH_ALEN);
 
 	ieee80211_check_rate_mask(sdata);
 
@@ -2290,7 +2292,7 @@ static void ieee80211_set_associated(struct ieee80211_sub_if_data *sdata,
 					(u8 *) &bss_conf->p2p_noa_attr,
 					sizeof(bss_conf->p2p_noa_attr));
 			if (ret >= 2) {
-				sdata->u.mgd.p2p_noa_index =
+				sdata->deflink.u.mgd.p2p_noa_index =
 					bss_conf->p2p_noa_attr.index;
 				bss_info_changed |= BSS_CHANGED_P2P_PS;
 			}
@@ -2303,14 +2305,14 @@ static void ieee80211_set_associated(struct ieee80211_sub_if_data *sdata,
 
 	ieee80211_led_assoc(local, 1);
 
-	if (sdata->u.mgd.have_beacon) {
+	if (sdata->deflink.u.mgd.have_beacon) {
 		/*
 		 * If the AP is buggy we may get here with no DTIM period
 		 * known, so assume it's 1 which is the only safe assumption
 		 * in that case, although if the TIM IE is broken powersave
 		 * probably just won't work at all.
 		 */
-		bss_conf->dtim_period = sdata->u.mgd.dtim_period ?: 1;
+		bss_conf->dtim_period = sdata->deflink.u.mgd.dtim_period ?: 1;
 		bss_conf->beacon_rate = bss->beacon_rate;
 		bss_info_changed |= BSS_CHANGED_BEACON_INFO;
 	} else {
@@ -2364,7 +2366,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	ieee80211_stop_poll(sdata);
 
 	ifmgd->associated = false;
-	ifmgd->assoc_bss = NULL;
+	sdata->deflink.u.mgd.bss = NULL;
 	netif_carrier_off(sdata->dev);
 
 	/*
@@ -2402,12 +2404,12 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 		 * driver requested so.
 		 */
 		if (ieee80211_hw_check(&local->hw, DEAUTH_NEED_MGD_TX_PREP) &&
-		    !ifmgd->have_beacon) {
+		    !sdata->deflink.u.mgd.have_beacon) {
 			drv_mgd_prepare_tx(sdata->local, sdata, &info);
 		}
 
-		ieee80211_send_deauth_disassoc(sdata, ifmgd->bssid,
-					       ifmgd->bssid, stype, reason,
+		ieee80211_send_deauth_disassoc(sdata, sdata->deflink.u.mgd.bssid,
+					       sdata->deflink.u.mgd.bssid, stype, reason,
 					       tx, frame_buf);
 	}
 
@@ -2418,7 +2420,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	drv_mgd_complete_tx(sdata->local, sdata, &info);
 
 	/* clear bssid only after building the needed mgmt frames */
-	eth_zero_addr(ifmgd->bssid);
+	eth_zero_addr(sdata->deflink.u.mgd.bssid);
 
 	sdata->vif.cfg.ssid_len = 0;
 
@@ -2432,7 +2434,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	changed |= BSS_CHANGED_ASSOC;
 	sdata->vif.cfg.assoc = false;
 
-	ifmgd->p2p_noa_index = -1;
+	sdata->deflink.u.mgd.p2p_noa_index = -1;
 	memset(&sdata->vif.bss_conf.p2p_noa_attr, 0,
 	       sizeof(sdata->vif.bss_conf.p2p_noa_attr));
 
@@ -2450,7 +2452,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	changed |= BSS_CHANGED_MU_GROUPS;
 	sdata->vif.bss_conf.mu_mimo_owner = false;
 
-	sdata->ap_power_level = IEEE80211_UNSET_POWER_LEVEL;
+	sdata->deflink.ap_power_level = IEEE80211_UNSET_POWER_LEVEL;
 
 	del_timer_sync(&local->dynamic_ps_timer);
 	cancel_work_sync(&local->dynamic_ps_enable_work);
@@ -2477,19 +2479,19 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	sdata->vif.bss_conf.dtim_period = 0;
 	sdata->vif.bss_conf.beacon_rate = NULL;
 
-	ifmgd->have_beacon = false;
+	sdata->deflink.u.mgd.have_beacon = false;
 
 	ifmgd->flags = 0;
 	mutex_lock(&local->mtx);
 	ieee80211_vif_release_channel(sdata);
 
 	sdata->vif.bss_conf.csa_active = false;
-	ifmgd->csa_waiting_bcn = false;
-	ifmgd->csa_ignored_same_chan = false;
-	if (sdata->csa_block_tx) {
+	sdata->deflink.u.mgd.csa_waiting_bcn = false;
+	sdata->deflink.u.mgd.csa_ignored_same_chan = false;
+	if (sdata->deflink.csa_block_tx) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_block_tx = false;
+		sdata->deflink.csa_block_tx = false;
 	}
 	mutex_unlock(&local->mtx);
 
@@ -2609,7 +2611,7 @@ static void ieee80211_mlme_send_probe_req(struct ieee80211_sub_if_data *sdata,
 static void ieee80211_mgd_probe_ap_send(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
-	u8 *dst = ifmgd->bssid;
+	u8 *dst = sdata->deflink.u.mgd.bssid;
 	u8 unicast_limit = max(1, max_probe_tries - 3);
 	struct sta_info *sta;
 
@@ -2645,7 +2647,7 @@ static void ieee80211_mgd_probe_ap_send(struct ieee80211_sub_if_data *sdata)
 		ieee80211_mlme_send_probe_req(sdata, sdata->vif.addr, dst,
 					      sdata->vif.cfg.ssid,
 					      sdata->vif.cfg.ssid_len,
-					      ifmgd->assoc_bss->channel);
+					      sdata->deflink.u.mgd.bss->channel);
 	}
 
 	ifmgd->probe_timeout = jiffies + msecs_to_jiffies(probe_wait_ms);
@@ -2735,7 +2737,7 @@ struct sk_buff *ieee80211_ap_probereq_get(struct ieee80211_hw *hw,
 	sdata_assert_lock(sdata);
 
 	if (ifmgd->associated)
-		cbss = ifmgd->assoc_bss;
+		cbss = sdata->deflink.u.mgd.bss;
 	else if (ifmgd->auth_data)
 		cbss = ifmgd->auth_data->bss;
 	else if (ifmgd->assoc_data)
@@ -2793,14 +2795,14 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 		return;
 	}
 
-	tx = !sdata->csa_block_tx;
+	tx = !sdata->deflink.csa_block_tx;
 
 	if (!ifmgd->driver_disconnect) {
 		/*
 		 * AP is probably out of range (or not reachable for another
 		 * reason) so remove the bss struct for that AP.
 		 */
-		cfg80211_unlink_bss(local->hw.wiphy, ifmgd->assoc_bss);
+		cfg80211_unlink_bss(local->hw.wiphy, sdata->deflink.u.mgd.bss);
 	}
 
 	ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
@@ -2810,11 +2812,11 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 			       tx, frame_buf);
 	mutex_lock(&local->mtx);
 	sdata->vif.bss_conf.csa_active = false;
-	ifmgd->csa_waiting_bcn = false;
-	if (sdata->csa_block_tx) {
+	sdata->deflink.u.mgd.csa_waiting_bcn = false;
+	if (sdata->deflink.csa_block_tx) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_block_tx = false;
+		sdata->deflink.csa_block_tx = false;
 	}
 	mutex_unlock(&local->mtx);
 
@@ -2834,17 +2836,17 @@ static void ieee80211_beacon_connection_loss_work(struct work_struct *work)
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 
 	if (ifmgd->associated)
-		ifmgd->beacon_loss_count++;
+		sdata->deflink.u.mgd.beacon_loss_count++;
 
 	if (ifmgd->connection_loss) {
 		sdata_info(sdata, "Connection to AP %pM lost\n",
-			   ifmgd->bssid);
+			   sdata->deflink.u.mgd.bssid);
 		__ieee80211_disconnect(sdata);
 		ifmgd->connection_loss = false;
 	} else if (ifmgd->driver_disconnect) {
 		sdata_info(sdata,
 			   "Driver requested disconnection from AP %pM\n",
-			   ifmgd->bssid);
+			   sdata->deflink.u.mgd.bssid);
 		__ieee80211_disconnect(sdata);
 		ifmgd->driver_disconnect = false;
 	} else {
@@ -2917,7 +2919,7 @@ static void ieee80211_destroy_auth_data(struct ieee80211_sub_if_data *sdata,
 		del_timer_sync(&sdata->u.mgd.timer);
 		sta_info_destroy_addr(sdata, auth_data->bss->bssid);
 
-		eth_zero_addr(sdata->u.mgd.bssid);
+		eth_zero_addr(sdata->deflink.u.mgd.bssid);
 		ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_BSSID);
 		sdata->u.mgd.flags = 0;
 		mutex_lock(&sdata->local->mtx);
@@ -2946,7 +2948,7 @@ static void ieee80211_destroy_assoc_data(struct ieee80211_sub_if_data *sdata,
 		del_timer_sync(&sdata->u.mgd.timer);
 		sta_info_destroy_addr(sdata, assoc_data->bss->bssid);
 
-		eth_zero_addr(sdata->u.mgd.bssid);
+		eth_zero_addr(sdata->deflink.u.mgd.bssid);
 		ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_BSSID);
 		sdata->u.mgd.flags = 0;
 		sdata->vif.bss_conf.mu_mimo_owner = false;
@@ -3210,8 +3212,8 @@ static void ieee80211_rx_mgmt_deauth(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (ifmgd->associated &&
-	    ether_addr_equal(mgmt->bssid, ifmgd->bssid)) {
-		const u8 *bssid = ifmgd->bssid;
+	    ether_addr_equal(mgmt->bssid, sdata->deflink.u.mgd.bssid)) {
+		const u8 *bssid = sdata->deflink.u.mgd.bssid;
 
 		sdata_info(sdata, "deauthenticated from %pM (Reason: %u=%s)\n",
 			   bssid, reason_code,
@@ -3253,7 +3255,7 @@ static void ieee80211_rx_mgmt_disassoc(struct ieee80211_sub_if_data *sdata,
 		return;
 
 	if (!ifmgd->associated ||
-	    !ether_addr_equal(mgmt->bssid, ifmgd->bssid))
+	    !ether_addr_equal(mgmt->bssid, sdata->deflink.u.mgd.bssid))
 		return;
 
 	reason_code = le16_to_cpu(mgmt->u.disassoc.reason_code);
@@ -3714,8 +3716,8 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	 * that effect because the AP values is an unsigned
 	 * 4-bit value.
 	 */
-	ifmgd->wmm_last_param_set = -1;
-	ifmgd->mu_edca_last_param_set = -1;
+	sdata->deflink.u.mgd.wmm_last_param_set = -1;
+	sdata->deflink.u.mgd.mu_edca_last_param_set = -1;
 
 	if (ifmgd->flags & IEEE80211_STA_DISABLE_WMM) {
 		ieee80211_set_wmm_default(sdata, false, false);
@@ -3963,7 +3965,7 @@ static void ieee80211_rx_mgmt_probe_resp(struct ieee80211_sub_if_data *sdata,
 	ieee80211_rx_bss_info(sdata, mgmt, len, rx_status);
 
 	if (ifmgd->associated &&
-	    ether_addr_equal(mgmt->bssid, ifmgd->bssid))
+	    ether_addr_equal(mgmt->bssid, sdata->deflink.u.mgd.bssid))
 		ieee80211_reset_ap_probe(sdata);
 }
 
@@ -4001,20 +4003,21 @@ static void ieee80211_handle_beacon_sig(struct ieee80211_sub_if_data *sdata,
 
 	if (ifmgd->flags & IEEE80211_STA_RESET_SIGNAL_AVE) {
 		ifmgd->flags &= ~IEEE80211_STA_RESET_SIGNAL_AVE;
-		ewma_beacon_signal_init(&ifmgd->ave_beacon_signal);
-		ifmgd->last_cqm_event_signal = 0;
-		ifmgd->count_beacon_signal = 1;
-		ifmgd->last_ave_beacon_signal = 0;
+		ewma_beacon_signal_init(&sdata->deflink.u.mgd.ave_beacon_signal);
+		sdata->deflink.u.mgd.last_cqm_event_signal = 0;
+		sdata->deflink.u.mgd.count_beacon_signal = 1;
+		sdata->deflink.u.mgd.last_ave_beacon_signal = 0;
 	} else {
-		ifmgd->count_beacon_signal++;
+		sdata->deflink.u.mgd.count_beacon_signal++;
 	}
 
-	ewma_beacon_signal_add(&ifmgd->ave_beacon_signal, -rx_status->signal);
+	ewma_beacon_signal_add(&sdata->deflink.u.mgd.ave_beacon_signal,
+			       -rx_status->signal);
 
 	if (ifmgd->rssi_min_thold != ifmgd->rssi_max_thold &&
-	    ifmgd->count_beacon_signal >= IEEE80211_SIGNAL_AVE_MIN_COUNT) {
-		int sig = -ewma_beacon_signal_read(&ifmgd->ave_beacon_signal);
-		int last_sig = ifmgd->last_ave_beacon_signal;
+	    sdata->deflink.u.mgd.count_beacon_signal >= IEEE80211_SIGNAL_AVE_MIN_COUNT) {
+		int sig = -ewma_beacon_signal_read(&sdata->deflink.u.mgd.ave_beacon_signal);
+		int last_sig = sdata->deflink.u.mgd.last_ave_beacon_signal;
 		struct ieee80211_event event = {
 			.type = RSSI_EVENT,
 		};
@@ -4025,36 +4028,36 @@ static void ieee80211_handle_beacon_sig(struct ieee80211_sub_if_data *sdata,
 		 */
 		if (sig > ifmgd->rssi_max_thold &&
 		    (last_sig <= ifmgd->rssi_min_thold || last_sig == 0)) {
-			ifmgd->last_ave_beacon_signal = sig;
+			sdata->deflink.u.mgd.last_ave_beacon_signal = sig;
 			event.u.rssi.data = RSSI_EVENT_HIGH;
 			drv_event_callback(local, sdata, &event);
 		} else if (sig < ifmgd->rssi_min_thold &&
 			   (last_sig >= ifmgd->rssi_max_thold ||
 			   last_sig == 0)) {
-			ifmgd->last_ave_beacon_signal = sig;
+			sdata->deflink.u.mgd.last_ave_beacon_signal = sig;
 			event.u.rssi.data = RSSI_EVENT_LOW;
 			drv_event_callback(local, sdata, &event);
 		}
 	}
 
 	if (bss_conf->cqm_rssi_thold &&
-	    ifmgd->count_beacon_signal >= IEEE80211_SIGNAL_AVE_MIN_COUNT &&
+	    sdata->deflink.u.mgd.count_beacon_signal >= IEEE80211_SIGNAL_AVE_MIN_COUNT &&
 	    !(sdata->vif.driver_flags & IEEE80211_VIF_SUPPORTS_CQM_RSSI)) {
-		int sig = -ewma_beacon_signal_read(&ifmgd->ave_beacon_signal);
-		int last_event = ifmgd->last_cqm_event_signal;
+		int sig = -ewma_beacon_signal_read(&sdata->deflink.u.mgd.ave_beacon_signal);
+		int last_event = sdata->deflink.u.mgd.last_cqm_event_signal;
 		int thold = bss_conf->cqm_rssi_thold;
 		int hyst = bss_conf->cqm_rssi_hyst;
 
 		if (sig < thold &&
 		    (last_event == 0 || sig < last_event - hyst)) {
-			ifmgd->last_cqm_event_signal = sig;
+			sdata->deflink.u.mgd.last_cqm_event_signal = sig;
 			ieee80211_cqm_rssi_notify(
 				&sdata->vif,
 				NL80211_CQM_RSSI_THRESHOLD_EVENT_LOW,
 				sig, GFP_KERNEL);
 		} else if (sig > thold &&
 			   (last_event == 0 || sig > last_event + hyst)) {
-			ifmgd->last_cqm_event_signal = sig;
+			sdata->deflink.u.mgd.last_cqm_event_signal = sig;
 			ieee80211_cqm_rssi_notify(
 				&sdata->vif,
 				NL80211_CQM_RSSI_THRESHOLD_EVENT_HIGH,
@@ -4063,22 +4066,22 @@ static void ieee80211_handle_beacon_sig(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (bss_conf->cqm_rssi_low &&
-	    ifmgd->count_beacon_signal >= IEEE80211_SIGNAL_AVE_MIN_COUNT) {
-		int sig = -ewma_beacon_signal_read(&ifmgd->ave_beacon_signal);
-		int last_event = ifmgd->last_cqm_event_signal;
+	    sdata->deflink.u.mgd.count_beacon_signal >= IEEE80211_SIGNAL_AVE_MIN_COUNT) {
+		int sig = -ewma_beacon_signal_read(&sdata->deflink.u.mgd.ave_beacon_signal);
+		int last_event = sdata->deflink.u.mgd.last_cqm_event_signal;
 		int low = bss_conf->cqm_rssi_low;
 		int high = bss_conf->cqm_rssi_high;
 
 		if (sig < low &&
 		    (last_event == 0 || last_event >= low)) {
-			ifmgd->last_cqm_event_signal = sig;
+			sdata->deflink.u.mgd.last_cqm_event_signal = sig;
 			ieee80211_cqm_rssi_notify(
 				&sdata->vif,
 				NL80211_CQM_RSSI_THRESHOLD_EVENT_LOW,
 				sig, GFP_KERNEL);
 		} else if (sig > high &&
 			   (last_event == 0 || last_event <= high)) {
-			ifmgd->last_cqm_event_signal = sig;
+			sdata->deflink.u.mgd.last_cqm_event_signal = sig;
 			ieee80211_cqm_rssi_notify(
 				&sdata->vif,
 				NL80211_CQM_RSSI_THRESHOLD_EVENT_HIGH,
@@ -4161,8 +4164,8 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 		ieee80211_rx_bss_info(sdata, mgmt, len, rx_status);
 
 		if (elems->dtim_period)
-			ifmgd->dtim_period = elems->dtim_period;
-		ifmgd->have_beacon = true;
+			sdata->deflink.u.mgd.dtim_period = elems->dtim_period;
+		sdata->deflink.u.mgd.have_beacon = true;
 		ifmgd->assoc_data->need_beacon = false;
 		if (ieee80211_hw_check(&local->hw, TIMING_BEACON_ONLY)) {
 			sdata->vif.bss_conf.sync_tsf =
@@ -4193,9 +4196,9 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (!ifmgd->associated ||
-	    !ieee80211_rx_our_beacon(bssid, ifmgd->assoc_bss))
+	    !ieee80211_rx_our_beacon(bssid, sdata->deflink.u.mgd.bss))
 		return;
-	bssid = ifmgd->bssid;
+	bssid = sdata->deflink.u.mgd.bssid;
 
 	if (!(rx_status->flag & RX_FLAG_NO_SIGNAL_VAL))
 		ieee80211_handle_beacon_sig(sdata, ifmgd, bss_conf,
@@ -4261,27 +4264,27 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 					    IEEE80211_P2P_ATTR_ABSENCE_NOTICE,
 					    (u8 *) &noa, sizeof(noa));
 		if (ret >= 2) {
-			if (sdata->u.mgd.p2p_noa_index != noa.index) {
+			if (sdata->deflink.u.mgd.p2p_noa_index != noa.index) {
 				/* valid noa_attr and index changed */
-				sdata->u.mgd.p2p_noa_index = noa.index;
+				sdata->deflink.u.mgd.p2p_noa_index = noa.index;
 				memcpy(&bss_conf->p2p_noa_attr, &noa, sizeof(noa));
 				changed |= BSS_CHANGED_P2P_PS;
 				/*
 				 * make sure we update all information, the CRC
 				 * mechanism doesn't look at P2P attributes.
 				 */
-				ifmgd->beacon_crc_valid = false;
+				sdata->deflink.u.mgd.beacon_crc_valid = false;
 			}
-		} else if (sdata->u.mgd.p2p_noa_index != -1) {
+		} else if (sdata->deflink.u.mgd.p2p_noa_index != -1) {
 			/* noa_attr not found and we had valid noa_attr before */
-			sdata->u.mgd.p2p_noa_index = -1;
+			sdata->deflink.u.mgd.p2p_noa_index = -1;
 			memset(&bss_conf->p2p_noa_attr, 0, sizeof(bss_conf->p2p_noa_attr));
 			changed |= BSS_CHANGED_P2P_PS;
-			ifmgd->beacon_crc_valid = false;
+			sdata->deflink.u.mgd.beacon_crc_valid = false;
 		}
 	}
 
-	if (ifmgd->csa_waiting_bcn)
+	if (sdata->deflink.u.mgd.csa_waiting_bcn)
 		ieee80211_chswitch_post_beacon(sdata);
 
 	/*
@@ -4301,11 +4304,11 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 		sdata->vif.bss_conf.sync_dtim_count = elems->dtim_count;
 	}
 
-	if ((ncrc == ifmgd->beacon_crc && ifmgd->beacon_crc_valid) ||
+	if ((ncrc == sdata->deflink.u.mgd.beacon_crc && sdata->deflink.u.mgd.beacon_crc_valid) ||
 	    ieee80211_is_s1g_short_beacon(mgmt->frame_control))
 		goto free;
-	ifmgd->beacon_crc = ncrc;
-	ifmgd->beacon_crc_valid = true;
+	sdata->deflink.u.mgd.beacon_crc = ncrc;
+	sdata->deflink.u.mgd.beacon_crc_valid = true;
 
 	ieee80211_rx_bss_info(sdata, mgmt, len, rx_status);
 
@@ -4323,12 +4326,12 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 	 * If we haven't had a beacon before, tell the driver about the
 	 * DTIM period (and beacon timing if desired) now.
 	 */
-	if (!ifmgd->have_beacon) {
+	if (!sdata->deflink.u.mgd.have_beacon) {
 		/* a few bogus AP send dtim_period = 0 or no TIM IE */
 		bss_conf->dtim_period = elems->dtim_period ?: 1;
 
 		changed |= BSS_CHANGED_BEACON_INFO;
-		ifmgd->have_beacon = true;
+		sdata->deflink.u.mgd.have_beacon = true;
 
 		mutex_lock(&local->iflist_mtx);
 		ieee80211_recalc_ps(local);
@@ -4724,7 +4727,8 @@ void ieee80211_sta_work(struct ieee80211_sub_if_data *sdata)
 
 	if (ifmgd->assoc_data && ifmgd->assoc_data->timeout_started &&
 	    time_after(jiffies, ifmgd->assoc_data->timeout)) {
-		if ((ifmgd->assoc_data->need_beacon && !ifmgd->have_beacon) ||
+		if ((ifmgd->assoc_data->need_beacon &&
+		     !sdata->deflink.u.mgd.have_beacon) ||
 		    ieee80211_do_assoc(sdata)) {
 			struct cfg80211_bss *bss = ifmgd->assoc_data->bss;
 			struct ieee80211_event event = {
@@ -4742,7 +4746,7 @@ void ieee80211_sta_work(struct ieee80211_sub_if_data *sdata)
 
 	if (ifmgd->flags & IEEE80211_STA_CONNECTION_POLL &&
 	    ifmgd->associated) {
-		u8 *bssid = ifmgd->bssid;
+		u8 *bssid = sdata->deflink.u.mgd.bssid;
 		int max_tries;
 
 		if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS))
@@ -4803,9 +4807,9 @@ static void ieee80211_sta_bcn_mon_timer(struct timer_list *t)
 {
 	struct ieee80211_sub_if_data *sdata =
 		from_timer(sdata, t, u.mgd.bcn_mon_timer);
-	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 
-	if (sdata->vif.bss_conf.csa_active && !ifmgd->csa_waiting_bcn)
+	if (sdata->vif.bss_conf.csa_active &&
+	    !sdata->deflink.u.mgd.csa_waiting_bcn)
 		return;
 
 	if (sdata->vif.driver_flags & IEEE80211_VIF_BEACON_FILTER)
@@ -4825,10 +4829,11 @@ static void ieee80211_sta_conn_mon_timer(struct timer_list *t)
 	struct sta_info *sta;
 	unsigned long timeout;
 
-	if (sdata->vif.bss_conf.csa_active && !ifmgd->csa_waiting_bcn)
+	if (sdata->vif.bss_conf.csa_active &&
+	    !sdata->deflink.u.mgd.csa_waiting_bcn)
 		return;
 
-	sta = sta_info_get(sdata, ifmgd->bssid);
+	sta = sta_info_get(sdata, sdata->deflink.u.mgd.bssid);
 	if (!sta)
 		return;
 
@@ -4924,7 +4929,7 @@ void ieee80211_mgd_quiesce(struct ieee80211_sub_if_data *sdata)
 			.bssid = bssid,
 		};
 
-		memcpy(bssid, ifmgd->bssid, ETH_ALEN);
+		memcpy(bssid, sdata->deflink.u.mgd.bssid, ETH_ALEN);
 		ieee80211_mgd_deauth(sdata, &req);
 	}
 
@@ -4977,7 +4982,8 @@ void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 		  ieee80211_beacon_connection_loss_work);
 	INIT_WORK(&ifmgd->csa_connection_drop_work,
 		  ieee80211_csa_connection_drop_work);
-	INIT_WORK(&ifmgd->request_smps_work, ieee80211_request_smps_mgd_work);
+	INIT_WORK(&sdata->deflink.u.mgd.request_smps_work,
+		  ieee80211_request_smps_mgd_work);
 	INIT_DELAYED_WORK(&ifmgd->tdls_peer_del_work,
 			  ieee80211_tdls_peer_del_work);
 	timer_setup(&ifmgd->timer, ieee80211_sta_timer, 0);
@@ -4991,12 +4997,12 @@ void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 	ifmgd->powersave = sdata->wdev.ps;
 	ifmgd->uapsd_queues = sdata->local->hw.uapsd_queues;
 	ifmgd->uapsd_max_sp_len = sdata->local->hw.uapsd_max_sp_len;
-	ifmgd->p2p_noa_index = -1;
+	sdata->deflink.u.mgd.p2p_noa_index = -1;
 
 	if (sdata->local->hw.wiphy->features & NL80211_FEATURE_DYNAMIC_SMPS)
-		ifmgd->req_smps = IEEE80211_SMPS_AUTOMATIC;
+		sdata->deflink.u.mgd.req_smps = IEEE80211_SMPS_AUTOMATIC;
 	else
-		ifmgd->req_smps = IEEE80211_SMPS_OFF;
+		sdata->deflink.u.mgd.req_smps = IEEE80211_SMPS_OFF;
 
 	/* Setup TDLS data */
 	spin_lock_init(&ifmgd->teardown_lock);
@@ -5469,8 +5475,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 						     s1g_oper,
 						     &chandef, false);
 
-	sdata->needed_rx_chains = min(ieee80211_max_rx_chains(sdata, cbss),
-				      local->rx_chains);
+	sdata->deflink.needed_rx_chains =
+		min(ieee80211_max_rx_chains(sdata, cbss), local->rx_chains);
 
 	rcu_read_unlock();
 	/* the element data was RCU protected so no longer valid anyway */
@@ -5483,7 +5489,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	}
 
 	/* will change later if needed */
-	sdata->smps_mode = IEEE80211_SMPS_OFF;
+	sdata->deflink.smps_mode = IEEE80211_SMPS_OFF;
 
 	mutex_lock(&local->mtx);
 	/*
@@ -5647,7 +5653,7 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 			sdata->flags &= ~IEEE80211_SDATA_OPERATING_GMODE;
 
 skip_rates:
-		memcpy(ifmgd->bssid, cbss->bssid, ETH_ALEN);
+		memcpy(sdata->deflink.u.mgd.bssid, cbss->bssid, ETH_ALEN);
 
 		/* set timing information */
 		sdata->vif.bss_conf.beacon_int = cbss->beacon_interval;
@@ -5707,7 +5713,7 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 			return err;
 		}
 	} else
-		WARN_ON_ONCE(!ether_addr_equal(ifmgd->bssid, cbss->bssid));
+		WARN_ON_ONCE(!ether_addr_equal(sdata->deflink.u.mgd.bssid, cbss->bssid));
 
 	/* Cancel scan to ensure that nothing interferes with connection */
 	if (local->scanning)
@@ -5830,7 +5836,7 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 
 		sdata_info(sdata,
 			   "disconnect from AP %pM for new auth to %pM\n",
-			   ifmgd->bssid, req->bss->bssid);
+			   sdata->deflink.u.mgd.bssid, req->bss->bssid);
 		ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
 				       WLAN_REASON_UNSPECIFIED,
 				       false, frame_buf);
@@ -5858,7 +5864,7 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	return 0;
 
  err_clear:
-	eth_zero_addr(ifmgd->bssid);
+	eth_zero_addr(sdata->deflink.u.mgd.bssid);
 	ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_BSSID);
 	ifmgd->auth_data = NULL;
 	mutex_lock(&sdata->local->mtx);
@@ -5906,7 +5912,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 
 		sdata_info(sdata,
 			   "disconnect from AP %pM for new assoc to %pM\n",
-			   ifmgd->bssid, req->bss->bssid);
+			   sdata->deflink.u.mgd.bssid, req->bss->bssid);
 		ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
 				       WLAN_REASON_UNSPECIFIED,
 				       false, frame_buf);
@@ -5931,13 +5937,14 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		bool match;
 
 		/* keep sta info, bssid if matching */
-		match = ether_addr_equal(ifmgd->bssid, req->bss->bssid);
+		match = ether_addr_equal(sdata->deflink.u.mgd.bssid,
+					 req->bss->bssid);
 		ieee80211_destroy_auth_data(sdata, match);
 	}
 
 	/* prepare assoc data */
 
-	ifmgd->beacon_crc_valid = false;
+	sdata->deflink.u.mgd.beacon_crc_valid = false;
 
 	assoc_data->wmm = bss->wmm_used &&
 			  (local->hw.queues >= IEEE80211_NUM_ACS);
@@ -6075,8 +6082,8 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	/* kick off associate process */
 
 	ifmgd->assoc_data = assoc_data;
-	ifmgd->dtim_period = 0;
-	ifmgd->have_beacon = false;
+	sdata->deflink.u.mgd.dtim_period = 0;
+	sdata->deflink.u.mgd.have_beacon = false;
 
 	/* override HT/VHT configuration only if the AP and we support it */
 	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HT)) {
@@ -6125,13 +6132,13 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	if (err)
 		goto err_clear;
 
-	if (ifmgd->req_smps == IEEE80211_SMPS_AUTOMATIC) {
+	if (sdata->deflink.u.mgd.req_smps == IEEE80211_SMPS_AUTOMATIC) {
 		if (ifmgd->powersave)
-			sdata->smps_mode = IEEE80211_SMPS_DYNAMIC;
+			sdata->deflink.smps_mode = IEEE80211_SMPS_DYNAMIC;
 		else
-			sdata->smps_mode = IEEE80211_SMPS_OFF;
+			sdata->deflink.smps_mode = IEEE80211_SMPS_OFF;
 	} else {
-		sdata->smps_mode = ifmgd->req_smps;
+		sdata->deflink.smps_mode = sdata->deflink.u.mgd.req_smps;
 	}
 
 	rcu_read_lock();
@@ -6144,7 +6151,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		 * should this be more if we miss one?
 		 */
 		sdata_info(sdata, "waiting for beacon from %pM\n",
-			   ifmgd->bssid);
+			   sdata->deflink.u.mgd.bssid);
 		assoc_data->timeout = TU_TO_EXP_TIME(req->bss->beacon_interval);
 		assoc_data->timeout_started = true;
 		assoc_data->need_beacon = true;
@@ -6153,9 +6160,9 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		u8 dtim_count = 0;
 
 		ieee80211_get_dtim(beacon_ies, &dtim_count,
-				   &ifmgd->dtim_period);
+				   &sdata->deflink.u.mgd.dtim_period);
 
-		ifmgd->have_beacon = true;
+		sdata->deflink.u.mgd.have_beacon = true;
 		assoc_data->timeout = jiffies;
 		assoc_data->timeout_started = true;
 
@@ -6204,7 +6211,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 
 	return 0;
  err_clear:
-	eth_zero_addr(ifmgd->bssid);
+	eth_zero_addr(sdata->deflink.u.mgd.bssid);
 	ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_BSSID);
 	ifmgd->assoc_data = NULL;
  err_free:
@@ -6262,7 +6269,7 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (ifmgd->associated &&
-	    ether_addr_equal(ifmgd->bssid, req->bssid)) {
+	    ether_addr_equal(sdata->deflink.u.mgd.bssid, req->bssid)) {
 		sdata_info(sdata,
 			   "deauthenticating from %pM by local choice (Reason: %u=%s)\n",
 			   req->bssid, req->reason_code,
@@ -6283,7 +6290,6 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 int ieee80211_mgd_disassoc(struct ieee80211_sub_if_data *sdata,
 			   struct cfg80211_disassoc_request *req)
 {
-	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	u8 bssid[ETH_ALEN];
 	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
 
@@ -6293,7 +6299,7 @@ int ieee80211_mgd_disassoc(struct ieee80211_sub_if_data *sdata,
 	 * to cfg80211 while that's in a locked section already
 	 * trying to tell us that the user wants to disconnect.
 	 */
-	if (ifmgd->assoc_bss != req->bss)
+	if (sdata->deflink.u.mgd.bss != req->bss)
 		return -ENOLINK;
 
 	sdata_info(sdata,
@@ -6322,7 +6328,7 @@ void ieee80211_mgd_stop(struct ieee80211_sub_if_data *sdata)
 	 */
 	cancel_work_sync(&ifmgd->monitor_work);
 	cancel_work_sync(&ifmgd->beacon_connection_loss_work);
-	cancel_work_sync(&ifmgd->request_smps_work);
+	cancel_work_sync(&sdata->deflink.u.mgd.request_smps_work);
 	cancel_work_sync(&ifmgd->csa_connection_drop_work);
 	cancel_work_sync(&ifmgd->chswitch_work);
 	cancel_delayed_work_sync(&ifmgd->tdls_peer_del_work);
diff --git a/net/mac80211/ocb.c b/net/mac80211/ocb.c
index de8f5dd0fbaf..dc99ae5e6bf0 100644
--- a/net/mac80211/ocb.c
+++ b/net/mac80211/ocb.c
@@ -181,8 +181,8 @@ int ieee80211_ocb_join(struct ieee80211_sub_if_data *sdata,
 		return -EINVAL;
 
 	sdata->flags |= IEEE80211_SDATA_OPERATING_GMODE;
-	sdata->smps_mode = IEEE80211_SMPS_OFF;
-	sdata->needed_rx_chains = sdata->local->rx_chains;
+	sdata->deflink.smps_mode = IEEE80211_SMPS_OFF;
+	sdata->deflink.needed_rx_chains = sdata->local->rx_chains;
 
 	mutex_lock(&sdata->local->mtx);
 	err = ieee80211_vif_use_channel(sdata, &setup->chandef,
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index 5e20e19e7679..09e9243e2a02 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -800,7 +800,7 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	case NL80211_IFTYPE_P2P_GO:
 		if (sdata->vif.type != NL80211_IFTYPE_ADHOC &&
 		    !ieee80211_vif_is_mesh(&sdata->vif) &&
-		    !rcu_access_pointer(sdata->bss->beacon))
+		    !sdata->bss->active)
 			need_offchan = true;
 		if (!ieee80211_is_action(mgmt->frame_control) ||
 		    mgmt->u.action.category == WLAN_CATEGORY_PUBLIC ||
@@ -819,7 +819,7 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 		if (!sdata->u.mgd.associated ||
 		    (params->offchan && params->wait &&
 		     local->ops->remain_on_channel &&
-		     memcmp(sdata->u.mgd.bssid,
+		     memcmp(sdata->deflink.u.mgd.bssid,
 			    mgmt->bssid, ETH_ALEN)))
 			need_offchan = true;
 		sdata_unlock(sdata);
@@ -887,7 +887,7 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 		rcu_read_lock();
 
 		if (sdata->vif.type == NL80211_IFTYPE_AP)
-			beacon = rcu_dereference(sdata->u.ap.beacon);
+			beacon = rcu_dereference(sdata->deflink.u.ap.beacon);
 		else if (sdata->vif.type == NL80211_IFTYPE_ADHOC)
 			beacon = rcu_dereference(sdata->u.ibss.presp);
 		else if (ieee80211_vif_is_mesh(&sdata->vif))
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 9a179a18aafc..21e7424f261a 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1872,11 +1872,11 @@ ieee80211_rx_get_bigtk(struct ieee80211_rx_data *rx, int idx)
 	if (rx->sta)
 		key = rcu_dereference(rx->sta->deflink.gtk[idx]);
 	if (!key)
-		key = rcu_dereference(sdata->keys[idx]);
+		key = rcu_dereference(sdata->deflink.gtk[idx]);
 	if (!key && rx->sta)
 		key = rcu_dereference(rx->sta->deflink.gtk[idx2]);
 	if (!key)
-		key = rcu_dereference(sdata->keys[idx2]);
+		key = rcu_dereference(sdata->deflink.gtk[idx2]);
 
 	return key;
 }
@@ -1990,7 +1990,7 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 			rx->key = rcu_dereference(rx->sta->deflink.gtk[mmie_keyidx]);
 		}
 		if (!rx->key)
-			rx->key = rcu_dereference(rx->sdata->keys[mmie_keyidx]);
+			rx->key = rcu_dereference(rx->sdata->deflink.gtk[mmie_keyidx]);
 	} else if (!ieee80211_has_protected(fc)) {
 		/*
 		 * The frame was not protected, so skip decryption. However, we
@@ -2006,7 +2006,7 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 			key = ieee80211_rx_get_bigtk(rx, -1);
 		} else if (ieee80211_is_mgmt(fc) &&
 			   is_multicast_ether_addr(hdr->addr1)) {
-			key = rcu_dereference(rx->sdata->default_mgmt_key);
+			key = rcu_dereference(rx->sdata->deflink.default_mgmt_key);
 		} else {
 			if (rx->sta) {
 				for (i = 0; i < NUM_DEFAULT_KEYS; i++) {
@@ -2017,7 +2017,7 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 			}
 			if (!key) {
 				for (i = 0; i < NUM_DEFAULT_KEYS; i++) {
-					key = rcu_dereference(sdata->keys[i]);
+					key = rcu_dereference(sdata->deflink.gtk[i]);
 					if (key)
 						break;
 				}
@@ -2051,7 +2051,10 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 
 		/* if not found, try default key */
 		if (!rx->key) {
-			rx->key = rcu_dereference(rx->sdata->keys[keyidx]);
+			if (is_multicast_ether_addr(hdr->addr1))
+				rx->key = rcu_dereference(rx->sdata->deflink.gtk[keyidx]);
+			if (!rx->key)
+				rx->key = rcu_dereference(rx->sdata->keys[keyidx]);
 
 			/*
 			 * RSNA-protected unicast frames should always be
@@ -3121,8 +3124,8 @@ static void ieee80211_process_sa_query_req(struct ieee80211_sub_if_data *sdata,
 		return;
 	}
 
-	if (!ether_addr_equal(mgmt->sa, sdata->u.mgd.bssid) ||
-	    !ether_addr_equal(mgmt->bssid, sdata->u.mgd.bssid)) {
+	if (!ether_addr_equal(mgmt->sa, sdata->deflink.u.mgd.bssid) ||
+	    !ether_addr_equal(mgmt->bssid, sdata->deflink.u.mgd.bssid)) {
 		/* Not from the current AP or not associated yet. */
 		return;
 	}
@@ -3140,7 +3143,7 @@ static void ieee80211_process_sa_query_req(struct ieee80211_sub_if_data *sdata,
 	resp = skb_put_zero(skb, 24);
 	memcpy(resp->da, mgmt->sa, ETH_ALEN);
 	memcpy(resp->sa, sdata->vif.addr, ETH_ALEN);
-	memcpy(resp->bssid, sdata->u.mgd.bssid, ETH_ALEN);
+	memcpy(resp->bssid, sdata->deflink.u.mgd.bssid, ETH_ALEN);
 	resp->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
 					  IEEE80211_STYPE_ACTION);
 	skb_put(skb, 1 + sizeof(resp->u.action.u.sa_query));
@@ -3423,7 +3426,7 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 			break;
 		if (!rx->sta)
 			break;
-		if (!ether_addr_equal(mgmt->bssid, sdata->u.mgd.bssid))
+		if (!ether_addr_equal(mgmt->bssid, sdata->deflink.u.mgd.bssid))
 			break;
 		if (mgmt->u.action.u.ext_chan_switch.action_code !=
 				WLAN_PUB_ACTION_EXT_CHANSW_ANN)
@@ -3524,7 +3527,7 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 				break;
 
 			if (sdata->vif.type == NL80211_IFTYPE_STATION)
-				bssid = sdata->u.mgd.bssid;
+				bssid = sdata->deflink.u.mgd.bssid;
 			else if (sdata->vif.type == NL80211_IFTYPE_ADHOC)
 				bssid = sdata->u.ibss.bssid;
 			else if (sdata->vif.type == NL80211_IFTYPE_MESH_POINT)
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 7eeb6919d2b7..115efa830673 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2312,7 +2312,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	 * (or just modify the value entirely, of course)
 	 */
 	if (sdata->vif.type == NL80211_IFTYPE_STATION)
-		sinfo->rx_beacon = sdata->u.mgd.count_beacon_signal;
+		sinfo->rx_beacon = sdata->deflink.u.mgd.count_beacon_signal;
 
 	drv_sta_statistics(local, sdata, &sta->sta, sinfo);
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_INACTIVE_TIME) |
@@ -2323,7 +2323,8 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 			 BIT_ULL(NL80211_STA_INFO_RX_DROP_MISC);
 
 	if (sdata->vif.type == NL80211_IFTYPE_STATION) {
-		sinfo->beacon_loss_count = sdata->u.mgd.beacon_loss_count;
+		sinfo->beacon_loss_count =
+			sdata->deflink.u.mgd.beacon_loss_count;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_LOSS);
 	}
 
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index e69272139437..d9cad6ad7a65 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -223,7 +223,7 @@ static void ieee80211_frame_acked(struct sta_info *sta, struct sk_buff *skb)
 			 * only be the AP. And the only other place updating
 			 * this variable in managed mode is before association.
 			 */
-			sdata->smps_mode = smps_mode;
+			sdata->deflink.smps_mode = smps_mode;
 			ieee80211_queue_work(&local->hw, &sdata->recalc_smps);
 		} else if (sdata->vif.type == NL80211_IFTYPE_AP ||
 			   sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index dc3f149ce18f..d67842bded76 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -218,7 +218,7 @@ static void ieee80211_tdls_add_link_ie(struct ieee80211_sub_if_data *sdata,
 	lnkid->ie_type = WLAN_EID_LINK_ID;
 	lnkid->ie_len = sizeof(struct ieee80211_tdls_lnkie) - 2;
 
-	memcpy(lnkid->bssid, sdata->u.mgd.bssid, ETH_ALEN);
+	memcpy(lnkid->bssid, sdata->deflink.u.mgd.bssid, ETH_ALEN);
 	memcpy(lnkid->init_sta, init_addr, ETH_ALEN);
 	memcpy(lnkid->resp_sta, rsp_addr, ETH_ALEN);
 }
@@ -545,7 +545,6 @@ ieee80211_tdls_add_setup_cfm_ies(struct ieee80211_sub_if_data *sdata,
 				 size_t extra_ies_len)
 {
 	struct ieee80211_local *local = sdata->local;
-	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	size_t offset = 0, noffset;
 	struct sta_info *sta, *ap_sta;
 	struct ieee80211_supported_band *sband;
@@ -558,7 +557,7 @@ ieee80211_tdls_add_setup_cfm_ies(struct ieee80211_sub_if_data *sdata,
 	mutex_lock(&local->sta_mtx);
 
 	sta = sta_info_get(sdata, peer);
-	ap_sta = sta_info_get(sdata, ifmgd->bssid);
+	ap_sta = sta_info_get(sdata, sdata->deflink.u.mgd.bssid);
 	if (WARN_ON_ONCE(!sta || !ap_sta)) {
 		mutex_unlock(&local->sta_mtx);
 		return;
@@ -833,7 +832,7 @@ ieee80211_prep_tdls_direct(struct wiphy *wiphy, struct net_device *dev,
 	mgmt = skb_put_zero(skb, 24);
 	memcpy(mgmt->da, peer, ETH_ALEN);
 	memcpy(mgmt->sa, sdata->vif.addr, ETH_ALEN);
-	memcpy(mgmt->bssid, sdata->u.mgd.bssid, ETH_ALEN);
+	memcpy(mgmt->bssid, sdata->deflink.u.mgd.bssid, ETH_ALEN);
 
 	mgmt->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
 					  IEEE80211_STYPE_ACTION);
@@ -1072,7 +1071,8 @@ ieee80211_tdls_mgmt_setup(struct wiphy *wiphy, struct net_device *dev,
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
-	enum ieee80211_smps_mode smps_mode = sdata->u.mgd.driver_smps_mode;
+	enum ieee80211_smps_mode smps_mode =
+		sdata->deflink.u.mgd.driver_smps_mode;
 	int ret;
 
 	/* don't support setup with forced SMPS mode that's not off */
@@ -1431,7 +1431,7 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 
 	if (ret == 0)
 		ieee80211_queue_work(&sdata->local->hw,
-				     &sdata->u.mgd.request_smps_work);
+				     &sdata->deflink.u.mgd.request_smps_work);
 
 	mutex_unlock(&local->mtx);
 	sdata_unlock(sdata);
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index a4270e9ec10e..8530363b2666 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -593,15 +593,15 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
 	    (key = rcu_dereference(tx->sta->ptk[tx->sta->ptk_idx])))
 		tx->key = key;
 	else if (ieee80211_is_group_privacy_action(tx->skb) &&
-		(key = rcu_dereference(tx->sdata->default_multicast_key)))
+		(key = rcu_dereference(tx->sdata->deflink.default_multicast_key)))
 		tx->key = key;
 	else if (ieee80211_is_mgmt(hdr->frame_control) &&
 		 is_multicast_ether_addr(hdr->addr1) &&
 		 ieee80211_is_robust_mgmt_frame(tx->skb) &&
-		 (key = rcu_dereference(tx->sdata->default_mgmt_key)))
+		 (key = rcu_dereference(tx->sdata->deflink.default_mgmt_key)))
 		tx->key = key;
 	else if (is_multicast_ether_addr(hdr->addr1) &&
-		 (key = rcu_dereference(tx->sdata->default_multicast_key)))
+		 (key = rcu_dereference(tx->sdata->deflink.default_multicast_key)))
 		tx->key = key;
 	else if (!is_multicast_ether_addr(hdr->addr1) &&
 		 (key = rcu_dereference(tx->sdata->default_unicast_key)))
@@ -2477,7 +2477,7 @@ int ieee80211_lookup_ra_sta(struct ieee80211_sub_if_data *sdata,
 
 		}
 
-		sta = sta_info_get(sdata, sdata->u.mgd.bssid);
+		sta = sta_info_get(sdata, sdata->deflink.u.mgd.bssid);
 		if (!sta)
 			return -ENOLINK;
 		break;
@@ -2712,14 +2712,14 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 			/* DA SA BSSID */
 			memcpy(hdr.addr1, skb->data, ETH_ALEN);
 			memcpy(hdr.addr2, skb->data + ETH_ALEN, ETH_ALEN);
-			memcpy(hdr.addr3, sdata->u.mgd.bssid, ETH_ALEN);
+			memcpy(hdr.addr3, sdata->deflink.u.mgd.bssid, ETH_ALEN);
 			hdrlen = 24;
 		}  else if (sdata->u.mgd.use_4addr &&
 			    cpu_to_be16(ethertype) != sdata->control_port_protocol) {
 			fc |= cpu_to_le16(IEEE80211_FCTL_FROMDS |
 					  IEEE80211_FCTL_TODS);
 			/* RA TA DA SA */
-			memcpy(hdr.addr1, sdata->u.mgd.bssid, ETH_ALEN);
+			memcpy(hdr.addr1, sdata->deflink.u.mgd.bssid, ETH_ALEN);
 			memcpy(hdr.addr2, sdata->vif.addr, ETH_ALEN);
 			memcpy(hdr.addr3, skb->data, ETH_ALEN);
 			memcpy(hdr.addr4, skb->data + ETH_ALEN, ETH_ALEN);
@@ -2727,7 +2727,7 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 		} else {
 			fc |= cpu_to_le16(IEEE80211_FCTL_TODS);
 			/* BSSID SA DA */
-			memcpy(hdr.addr1, sdata->u.mgd.bssid, ETH_ALEN);
+			memcpy(hdr.addr1, sdata->deflink.u.mgd.bssid, ETH_ALEN);
 			memcpy(hdr.addr2, skb->data + ETH_ALEN, ETH_ALEN);
 			memcpy(hdr.addr3, skb->data, ETH_ALEN);
 			hdrlen = 24;
@@ -3004,7 +3004,7 @@ void ieee80211_check_fast_xmit(struct sta_info *sta)
 			/* DA SA BSSID */
 			build.da_offs = offsetof(struct ieee80211_hdr, addr1);
 			build.sa_offs = offsetof(struct ieee80211_hdr, addr2);
-			memcpy(hdr->addr3, sdata->u.mgd.bssid, ETH_ALEN);
+			memcpy(hdr->addr3, sdata->deflink.u.mgd.bssid, ETH_ALEN);
 			build.hdr_len = 24;
 			break;
 		}
@@ -3014,7 +3014,7 @@ void ieee80211_check_fast_xmit(struct sta_info *sta)
 			fc |= cpu_to_le16(IEEE80211_FCTL_FROMDS |
 					  IEEE80211_FCTL_TODS);
 			/* RA TA DA SA */
-			memcpy(hdr->addr1, sdata->u.mgd.bssid, ETH_ALEN);
+			memcpy(hdr->addr1, sdata->deflink.u.mgd.bssid, ETH_ALEN);
 			memcpy(hdr->addr2, sdata->vif.addr, ETH_ALEN);
 			build.da_offs = offsetof(struct ieee80211_hdr, addr3);
 			build.sa_offs = offsetof(struct ieee80211_hdr, addr4);
@@ -3023,7 +3023,7 @@ void ieee80211_check_fast_xmit(struct sta_info *sta)
 		}
 		fc |= cpu_to_le16(IEEE80211_FCTL_TODS);
 		/* BSSID SA DA */
-		memcpy(hdr->addr1, sdata->u.mgd.bssid, ETH_ALEN);
+		memcpy(hdr->addr1, sdata->deflink.u.mgd.bssid, ETH_ALEN);
 		build.da_offs = offsetof(struct ieee80211_hdr, addr3);
 		build.sa_offs = offsetof(struct ieee80211_hdr, addr2);
 		build.hdr_len = 24;
@@ -3250,7 +3250,7 @@ static bool ieee80211_amsdu_prepare_head(struct ieee80211_sub_if_data *sdata,
 	 */
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_STATION:
-		bssid = sdata->u.mgd.bssid;
+		bssid = sdata->deflink.u.mgd.bssid;
 		break;
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_AP_VLAN:
@@ -4804,7 +4804,7 @@ static void ieee80211_set_beacon_cntdwn(struct ieee80211_sub_if_data *sdata,
 	}
 
 	rcu_read_lock();
-	resp = rcu_dereference(sdata->u.ap.probe_resp);
+	resp = rcu_dereference(sdata->deflink.u.ap.probe_resp);
 
 	bcn_offsets = beacon->cntdwn_counter_offsets;
 	count = beacon->cntdwn_current_counter;
@@ -4848,7 +4848,7 @@ u8 ieee80211_beacon_update_cntdwn(struct ieee80211_vif *vif)
 	rcu_read_lock();
 
 	if (sdata->vif.type == NL80211_IFTYPE_AP)
-		beacon = rcu_dereference(sdata->u.ap.beacon);
+		beacon = rcu_dereference(sdata->deflink.u.ap.beacon);
 	else if (sdata->vif.type == NL80211_IFTYPE_ADHOC)
 		beacon = rcu_dereference(sdata->u.ibss.presp);
 	else if (ieee80211_vif_is_mesh(&sdata->vif))
@@ -4873,7 +4873,7 @@ void ieee80211_beacon_set_cntdwn(struct ieee80211_vif *vif, u8 counter)
 	rcu_read_lock();
 
 	if (sdata->vif.type == NL80211_IFTYPE_AP)
-		beacon = rcu_dereference(sdata->u.ap.beacon);
+		beacon = rcu_dereference(sdata->deflink.u.ap.beacon);
 	else if (sdata->vif.type == NL80211_IFTYPE_ADHOC)
 		beacon = rcu_dereference(sdata->u.ibss.presp);
 	else if (ieee80211_vif_is_mesh(&sdata->vif))
@@ -4903,9 +4903,7 @@ bool ieee80211_beacon_cntdwn_is_complete(struct ieee80211_vif *vif)
 
 	rcu_read_lock();
 	if (vif->type == NL80211_IFTYPE_AP) {
-		struct ieee80211_if_ap *ap = &sdata->u.ap;
-
-		beacon = rcu_dereference(ap->beacon);
+		beacon = rcu_dereference(sdata->deflink.u.ap.beacon);
 		if (WARN_ON(!beacon || !beacon->tail))
 			goto out;
 		beacon_data = beacon->tail;
@@ -4958,7 +4956,7 @@ static int ieee80211_beacon_protect(struct sk_buff *skb,
 	struct sk_buff *check_skb;
 
 	memset(&tx, 0, sizeof(tx));
-	tx.key = rcu_dereference(sdata->default_beacon_key);
+	tx.key = rcu_dereference(sdata->deflink.default_beacon_key);
 	if (!tx.key)
 		return 0;
 	tx.local = local;
@@ -5128,9 +5126,7 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 		memset(offs, 0, sizeof(*offs));
 
 	if (sdata->vif.type == NL80211_IFTYPE_AP) {
-		struct ieee80211_if_ap *ap = &sdata->u.ap;
-
-		beacon = rcu_dereference(ap->beacon);
+		beacon = rcu_dereference(sdata->deflink.u.ap.beacon);
 		if (!beacon)
 			goto out;
 
@@ -5268,7 +5264,6 @@ EXPORT_SYMBOL(ieee80211_beacon_get_tim);
 struct sk_buff *ieee80211_proberesp_get(struct ieee80211_hw *hw,
 					struct ieee80211_vif *vif)
 {
-	struct ieee80211_if_ap *ap = NULL;
 	struct sk_buff *skb = NULL;
 	struct probe_resp *presp = NULL;
 	struct ieee80211_hdr *hdr;
@@ -5278,9 +5273,7 @@ struct sk_buff *ieee80211_proberesp_get(struct ieee80211_hw *hw,
 		return NULL;
 
 	rcu_read_lock();
-
-	ap = &sdata->u.ap;
-	presp = rcu_dereference(ap->probe_resp);
+	presp = rcu_dereference(sdata->deflink.u.ap.probe_resp);
 	if (!presp)
 		goto out;
 
@@ -5310,7 +5303,7 @@ struct sk_buff *ieee80211_get_fils_discovery_tmpl(struct ieee80211_hw *hw,
 		return NULL;
 
 	rcu_read_lock();
-	tmpl = rcu_dereference(sdata->u.ap.fils_discovery);
+	tmpl = rcu_dereference(sdata->deflink.u.ap.fils_discovery);
 	if (!tmpl) {
 		rcu_read_unlock();
 		return NULL;
@@ -5339,7 +5332,7 @@ ieee80211_get_unsol_bcast_probe_resp_tmpl(struct ieee80211_hw *hw,
 		return NULL;
 
 	rcu_read_lock();
-	tmpl = rcu_dereference(sdata->u.ap.unsol_bcast_probe_resp);
+	tmpl = rcu_dereference(sdata->deflink.u.ap.unsol_bcast_probe_resp);
 	if (!tmpl) {
 		rcu_read_unlock();
 		return NULL;
@@ -5360,7 +5353,6 @@ struct sk_buff *ieee80211_pspoll_get(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif)
 {
 	struct ieee80211_sub_if_data *sdata;
-	struct ieee80211_if_managed *ifmgd;
 	struct ieee80211_pspoll *pspoll;
 	struct ieee80211_local *local;
 	struct sk_buff *skb;
@@ -5369,7 +5361,6 @@ struct sk_buff *ieee80211_pspoll_get(struct ieee80211_hw *hw,
 		return NULL;
 
 	sdata = vif_to_sdata(vif);
-	ifmgd = &sdata->u.mgd;
 	local = sdata->local;
 
 	skb = dev_alloc_skb(local->hw.extra_tx_headroom + sizeof(*pspoll));
@@ -5386,7 +5377,7 @@ struct sk_buff *ieee80211_pspoll_get(struct ieee80211_hw *hw,
 	/* aid in PS-Poll has its two MSBs each set to 1 */
 	pspoll->aid |= cpu_to_le16(1 << 15 | 1 << 14);
 
-	memcpy(pspoll->bssid, ifmgd->bssid, ETH_ALEN);
+	memcpy(pspoll->bssid, sdata->deflink.u.mgd.bssid, ETH_ALEN);
 	memcpy(pspoll->ta, vif->addr, ETH_ALEN);
 
 	return skb;
@@ -5399,7 +5390,6 @@ struct sk_buff *ieee80211_nullfunc_get(struct ieee80211_hw *hw,
 {
 	struct ieee80211_hdr_3addr *nullfunc;
 	struct ieee80211_sub_if_data *sdata;
-	struct ieee80211_if_managed *ifmgd;
 	struct ieee80211_local *local;
 	struct sk_buff *skb;
 	bool qos = false;
@@ -5408,14 +5398,13 @@ struct sk_buff *ieee80211_nullfunc_get(struct ieee80211_hw *hw,
 		return NULL;
 
 	sdata = vif_to_sdata(vif);
-	ifmgd = &sdata->u.mgd;
 	local = sdata->local;
 
 	if (qos_ok) {
 		struct sta_info *sta;
 
 		rcu_read_lock();
-		sta = sta_info_get(sdata, ifmgd->bssid);
+		sta = sta_info_get(sdata, sdata->deflink.u.mgd.bssid);
 		qos = sta && sta->sta.wme;
 		rcu_read_unlock();
 	}
@@ -5444,9 +5433,9 @@ struct sk_buff *ieee80211_nullfunc_get(struct ieee80211_hw *hw,
 		skb_put_data(skb, &qoshdr, sizeof(qoshdr));
 	}
 
-	memcpy(nullfunc->addr1, ifmgd->bssid, ETH_ALEN);
+	memcpy(nullfunc->addr1, sdata->deflink.u.mgd.bssid, ETH_ALEN);
 	memcpy(nullfunc->addr2, vif->addr, ETH_ALEN);
-	memcpy(nullfunc->addr3, ifmgd->bssid, ETH_ALEN);
+	memcpy(nullfunc->addr3, sdata->deflink.u.mgd.bssid, ETH_ALEN);
 
 	return skb;
 }
@@ -5543,7 +5532,7 @@ ieee80211_get_buffered_bc(struct ieee80211_hw *hw,
 
 	if (sdata->vif.type == NL80211_IFTYPE_AP) {
 		struct beacon_data *beacon =
-				rcu_dereference(sdata->u.ap.beacon);
+				rcu_dereference(sdata->deflink.u.ap.beacon);
 
 		if (!beacon || !beacon->head)
 			goto out;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index dccc757baab2..9cbc09e6d84e 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2533,7 +2533,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 				   BSS_CHANGED_PS;
 
 			/* Re-send beacon info report to the driver */
-			if (sdata->u.mgd.have_beacon)
+			if (sdata->deflink.u.mgd.have_beacon)
 				changed |= BSS_CHANGED_BEACON_INFO;
 
 			if (sdata->vif.bss_conf.max_idle_period ||
@@ -2562,7 +2562,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 			if (sdata->vif.type == NL80211_IFTYPE_AP) {
 				changed |= BSS_CHANGED_AP_PROBE_RESP;
 
-				if (rcu_access_pointer(sdata->u.ap.beacon))
+				if (rcu_access_pointer(sdata->deflink.u.ap.beacon))
 					drv_start_ap(local, sdata);
 			}
 			fallthrough;
@@ -3041,7 +3041,7 @@ void ieee80211_ie_build_he_6ghz_cap(struct ieee80211_sub_if_data *sdata,
 	cap = le16_to_cpu(iftd->he_6ghz_capa.capa);
 	cap &= ~IEEE80211_HE_6GHZ_CAP_SM_PS;
 
-	switch (sdata->smps_mode) {
+	switch (sdata->deflink.smps_mode) {
 	case IEEE80211_SMPS_AUTOMATIC:
 	case IEEE80211_SMPS_NUM_MODES:
 		WARN_ON(1);
@@ -3775,13 +3775,11 @@ int ieee80211_add_ext_srates_ie(struct ieee80211_sub_if_data *sdata,
 int ieee80211_ave_rssi(struct ieee80211_vif *vif)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
-	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 
-	if (WARN_ON_ONCE(sdata->vif.type != NL80211_IFTYPE_STATION)) {
-		/* non-managed type inferfaces */
+	if (WARN_ON_ONCE(sdata->vif.type != NL80211_IFTYPE_STATION))
 		return 0;
-	}
-	return -ewma_beacon_signal_read(&ifmgd->ave_beacon_signal);
+
+	return -ewma_beacon_signal_read(&sdata->deflink.u.mgd.ave_beacon_signal);
 }
 EXPORT_SYMBOL_GPL(ieee80211_ave_rssi);
 
@@ -3973,7 +3971,7 @@ void ieee80211_dfs_cac_cancel(struct ieee80211_local *local)
 		 * by the time it gets it, sdata->wdev.cac_started
 		 * will no longer be true
 		 */
-		cancel_delayed_work(&sdata->dfs_cac_timer_work);
+		cancel_delayed_work(&sdata->deflink.dfs_cac_timer_work);
 
 		if (sdata->wdev.cac_started) {
 			chandef = sdata->vif.bss_conf.chandef;
@@ -4412,8 +4410,8 @@ static u8 ieee80211_chanctx_radar_detect(struct ieee80211_local *local,
 		return 0;
 
 	list_for_each_entry(sdata, &ctx->reserved_vifs, reserved_chanctx_list)
-		if (sdata->reserved_radar_required)
-			radar_detect |= BIT(sdata->reserved_chandef.width);
+		if (sdata->deflink.reserved_radar_required)
+			radar_detect |= BIT(sdata->deflink.reserved_chandef.width);
 
 	/*
 	 * An in-place reservation context should not have any assigned vifs
@@ -4423,7 +4421,7 @@ static u8 ieee80211_chanctx_radar_detect(struct ieee80211_local *local,
 		!list_empty(&ctx->assigned_vifs));
 
 	list_for_each_entry(sdata, &ctx->assigned_vifs, assigned_chanctx_list)
-		if (sdata->radar_required)
+		if (sdata->deflink.radar_required)
 			radar_detect |= BIT(sdata->vif.bss_conf.chandef.width);
 
 	return radar_detect;
diff --git a/net/mac80211/wme.c b/net/mac80211/wme.c
index 62c6733e0792..f4c9c9498e91 100644
--- a/net/mac80211/wme.c
+++ b/net/mac80211/wme.c
@@ -210,7 +210,7 @@ u16 ieee80211_select_queue(struct ieee80211_sub_if_data *sdata,
 		if (sta)
 			break;
 
-		ra = sdata->u.mgd.bssid;
+		ra = sdata->deflink.u.mgd.bssid;
 		break;
 	case NL80211_IFTYPE_ADHOC:
 		ra = skb->data;
-- 
2.36.1

