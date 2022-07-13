Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0354E573337
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbiGMJpi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiGMJpO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:14 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A91B62A0
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=e8B5lTcnpKvgMgPsGnNyFAM+Ps9roakTzso0GC6LoOg=;
        t=1657705510; x=1658915110; b=yX9pjHydYs3VBnwP3orf1prmfKQZGcXu9g5g9sCN2VZy+Er
        ISk6OmnxBeqiNw3dEsGvnit/hIqSF/tjYO5X6mcJ2cbRvO+CispyQ02mu/T3HwQtB50XAl4CwmkWZ
        kxROpEUmsQNopMrTAitUFj60D3FN8N+V1xWMLxH0BoEO9CP4Kpm5Qoys8sTcqD5ICzOXVLUKSVSQU
        9egyRG859dBcOOAhQ+PLAR8xT07I7EODz7D9dOwsYK4cMeqniuqCmmis6/1qrbXrJL6q6mWzAR5ht
        LpnLW4W3oirOI/CoaOl8CP/Il1iexk8vFL3XlDWrLFXP6mHcvIqYNPJl7oTZ2T1Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvc-00EgvB-JB;
        Wed, 13 Jul 2022 11:45:08 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/76] wifi: mac80211: RCU-ify link/link_conf pointers
Date:   Wed, 13 Jul 2022 11:44:00 +0200
Message-Id: <20220713114425.3f8f07983a72.I523121e854345cfb66260ca4a7410f93168c6ee3@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
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

Since links can be added and removed dynamically, we need to
somehow protect the sdata->link[] and vif->link_conf[] array
pointers from disappearing when accessing them without locks.
RCU-ify the pointers to achieve this, which requires quite a
bit of rework.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c |  14 ++-
 include/net/mac80211.h                |   6 +-
 net/mac80211/cfg.c                    | 169 +++++++++++++++++---------
 net/mac80211/chan.c                   | 123 ++++++++++---------
 net/mac80211/debugfs_netdev.c         |   2 +-
 net/mac80211/driver-ops.h             |  10 +-
 net/mac80211/ht.c                     |  24 +++-
 net/mac80211/ibss.c                   |   8 +-
 net/mac80211/ieee80211_i.h            |  21 ++--
 net/mac80211/iface.c                  |  36 +++---
 net/mac80211/main.c                   |   9 +-
 net/mac80211/mesh.c                   |   7 +-
 net/mac80211/mlme.c                   |  30 +++--
 net/mac80211/ocb.c                    |   4 +-
 net/mac80211/offchannel.c             |  15 ++-
 net/mac80211/rx.c                     |   8 +-
 net/mac80211/sta_info.c               |   3 +-
 net/mac80211/tdls.c                   |   3 +-
 net/mac80211/trace.h                  |  19 +--
 net/mac80211/tx.c                     |  88 +++++++-------
 net/mac80211/util.c                   |  34 +++---
 net/mac80211/vht.c                    |  62 +++++++---
 22 files changed, 420 insertions(+), 275 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 7be846d4d63e..8cc813f66010 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1477,9 +1477,10 @@ static void mac80211_hwsim_tx_iter(void *_data, u8 *addr,
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(vif->link_conf); i++) {
-		struct ieee80211_bss_conf *conf = vif->link_conf[i];
+		struct ieee80211_bss_conf *conf;
 		struct ieee80211_chanctx_conf *chanctx;
 
+		conf = rcu_dereference(vif->link_conf[i]);
 		if (!conf)
 			continue;
 
@@ -1917,7 +1918,7 @@ static void mac80211_hwsim_beacon_tx(void *arg, u8 *mac,
 {
 	struct mac80211_hwsim_link_data *link_data = arg;
 	u32 link_id = link_data->link_id;
-	struct ieee80211_bss_conf *link_conf = vif->link_conf[link_id];
+	struct ieee80211_bss_conf *link_conf;
 	struct mac80211_hwsim_data *data =
 		container_of(link_data, struct mac80211_hwsim_data,
 			     link_data[link_id]);
@@ -1931,6 +1932,10 @@ static void mac80211_hwsim_beacon_tx(void *arg, u8 *mac,
 
 	hwsim_check_magic(vif);
 
+	link_conf = rcu_dereference(vif->link_conf[link_id]);
+	if (!link_conf)
+		return;
+
 	if (vif->type != NL80211_IFTYPE_AP &&
 	    vif->type != NL80211_IFTYPE_MESH_POINT &&
 	    vif->type != NL80211_IFTYPE_ADHOC &&
@@ -2155,12 +2160,11 @@ static void mac80211_hwsim_vif_info_changed(struct ieee80211_hw *hw,
 
 static void mac80211_hwsim_link_info_changed(struct ieee80211_hw *hw,
 					     struct ieee80211_vif *vif,
-					     u32 link_id,
-					     u64 changed)
+					     struct ieee80211_bss_conf *info,
+					     u32 link_id, u64 changed)
 {
 	struct hwsim_vif_priv *vp = (void *)vif->drv_priv;
 	struct mac80211_hwsim_data *data = hw->priv;
-	struct ieee80211_bss_conf *info = vif->link_conf[link_id];
 	struct mac80211_hwsim_link_data *link_data = &data->link_data[link_id];
 
 	hwsim_check_magic(vif);
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 256b9215e17b..e6c77e12f94a 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1789,7 +1789,7 @@ struct ieee80211_vif {
 	enum nl80211_iftype type;
 	struct ieee80211_vif_cfg cfg;
 	struct ieee80211_bss_conf bss_conf;
-	struct ieee80211_bss_conf *link_conf[IEEE80211_MLD_MAX_NUM_LINKS];
+	struct ieee80211_bss_conf __rcu *link_conf[IEEE80211_MLD_MAX_NUM_LINKS];
 	u16 valid_links;
 	u8 addr[ETH_ALEN] __aligned(2);
 	bool p2p;
@@ -4082,7 +4082,9 @@ struct ieee80211_ops {
 				u64 changed);
 	void (*link_info_changed)(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif,
-				  unsigned int link_id, u64 changed);
+				  struct ieee80211_bss_conf *info,
+				  unsigned int link_id,
+				  u64 changed);
 
 	int (*start_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			unsigned int link_id);
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 777c133c3f0b..058163b97c9a 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -39,7 +39,7 @@ static void ieee80211_set_mu_mimo_follow(struct ieee80211_sub_if_data *sdata,
 		memcpy(sdata->vif.bss_conf.mu_group.position,
 		       params->vht_mumimo_groups + WLAN_MEMBERSHIP_LEN,
 		       WLAN_USER_POSITION_LEN);
-		ieee80211_link_info_change_notify(sdata, 0,
+		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
 						  BSS_CHANGED_MU_GROUPS);
 		/* don't care about endianness - just check for 0 */
 		memcpy(&membership, params->vht_mumimo_groups,
@@ -841,8 +841,8 @@ static int ieee80211_set_monitor_channel(struct wiphy *wiphy,
 		sdata = wiphy_dereference(local->hw.wiphy,
 					  local->monitor_sdata);
 		if (sdata) {
-			ieee80211_link_release_channel(sdata->link[0]);
-			ret = ieee80211_link_use_channel(sdata->link[0],
+			ieee80211_link_release_channel(&sdata->deflink);
+			ret = ieee80211_link_use_channel(&sdata->deflink,
 							 chandef,
 							 IEEE80211_CHANCTX_EXCLUSIVE);
 		}
@@ -1008,6 +1008,7 @@ ieee80211_copy_mbssid_beacon(u8 *pos, struct cfg80211_mbssid_elems *dst,
 }
 
 static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
+				   struct ieee80211_link_data *link,
 				   struct cfg80211_beacon_data *params,
 				   const struct ieee80211_csa_settings *csa,
 				   const struct ieee80211_color_change_settings *cca)
@@ -1017,9 +1018,7 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	int new_head_len, new_tail_len;
 	int size, err;
 	u32 changed = BSS_CHANGED_BEACON;
-	struct ieee80211_link_data *link = sdata->link[params->link_id];
-	struct ieee80211_bss_conf *link_conf =
-		sdata->vif.link_conf[params->link_id];
+	struct ieee80211_bss_conf *link_conf = link->conf;
 
 	old = sdata_dereference(link->u.ap.beacon, sdata);
 
@@ -1153,8 +1152,14 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	int i, err;
 	int prev_beacon_int;
 	unsigned int link_id = params->beacon.link_id;
-	struct ieee80211_link_data *link = sdata->link[link_id];
-	struct ieee80211_bss_conf *link_conf = sdata->vif.link_conf[link_id];
+	struct ieee80211_link_data *link;
+	struct ieee80211_bss_conf *link_conf;
+
+	link = sdata_dereference(sdata->link[link_id], sdata);
+	if (!link)
+		return -ENOLINK;
+
+	link_conf = link->conf;
 
 	old = sdata_dereference(link->u.ap.beacon, sdata);
 	if (old)
@@ -1264,7 +1269,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	if (ieee80211_hw_check(&local->hw, HAS_RATE_CONTROL))
 		link_conf->beacon_tx_rate = params->beacon_rate;
 
-	err = ieee80211_assign_beacon(sdata, &params->beacon, NULL, NULL);
+	err = ieee80211_assign_beacon(sdata, link, &params->beacon, NULL, NULL);
 	if (err < 0)
 		goto error;
 	changed |= err;
@@ -1300,7 +1305,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 
 	ieee80211_recalc_dtim(local, sdata);
 	ieee80211_vif_cfg_change_notify(sdata, BSS_CHANGED_SSID);
-	ieee80211_link_info_change_notify(sdata, link_id, changed);
+	ieee80211_link_info_change_notify(sdata, link, changed);
 
 	netif_carrier_on(dev);
 	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list)
@@ -1320,25 +1325,30 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 				   struct cfg80211_beacon_data *params)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_link_data *link;
 	struct beacon_data *old;
 	int err;
-	struct ieee80211_bss_conf *link_conf =
-		sdata->vif.link_conf[params->link_id];
+	struct ieee80211_bss_conf *link_conf;
 
 	sdata_assert_lock(sdata);
 
+	link = sdata_dereference(sdata->link[params->link_id], sdata);
+	if (!link)
+		return -ENOLINK;
+
+	link_conf = link->conf;
+
 	/* don't allow changing the beacon while a countdown is in place - offset
 	 * of channel switch counter may change
 	 */
 	if (link_conf->csa_active || link_conf->color_change_active)
 		return -EBUSY;
 
-	old = sdata_dereference(sdata->link[params->link_id]->u.ap.beacon,
-				sdata);
+	old = sdata_dereference(link->u.ap.beacon, sdata);
 	if (!old)
 		return -ENOENT;
 
-	err = ieee80211_assign_beacon(sdata, params, NULL, NULL);
+	err = ieee80211_assign_beacon(sdata, link, params, NULL, NULL);
 	if (err < 0)
 		return err;
 
@@ -1348,7 +1358,7 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 		err |= BSS_CHANGED_HE_BSS_COLOR;
 	}
 
-	ieee80211_link_info_change_notify(sdata, params->link_id, err);
+	ieee80211_link_info_change_notify(sdata, link, err);
 	return 0;
 }
 
@@ -1373,8 +1383,9 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	struct fils_discovery_data *old_fils_discovery;
 	struct unsol_bcast_probe_resp_data *old_unsol_bcast_probe_resp;
 	struct cfg80211_chan_def chandef;
-	struct ieee80211_link_data *link = sdata->link[link_id];
-	struct ieee80211_bss_conf *link_conf = sdata->vif.link_conf[link_id];
+	struct ieee80211_link_data *link =
+		sdata_dereference(sdata->link[link_id], sdata);
+	struct ieee80211_bss_conf *link_conf = link->conf;
 
 	sdata_assert_lock(sdata);
 
@@ -1431,7 +1442,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	sdata->beacon_rate_set = false;
 	sdata->vif.cfg.ssid_len = 0;
 	clear_bit(SDATA_STATE_OFFCHANNEL_BEACON_STOPPED, &sdata->state);
-	ieee80211_link_info_change_notify(sdata, link_id,
+	ieee80211_link_info_change_notify(sdata, link,
 					  BSS_CHANGED_BEACON_ENABLED);
 
 	if (sdata->wdev.cac_started) {
@@ -1589,14 +1600,16 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	u32 link_id = params->link_id < 0 ? 0 : params->link_id;
+	struct ieee80211_link_data *link =
+		sdata_dereference(sdata->link[link_id], sdata);
 	struct link_sta_info *link_sta =
 		rcu_dereference_protected(sta->link[link_id],
 					  lockdep_is_held(&local->sta_mtx));
 
-	if (WARN_ON(!link_sta))
+	if (WARN_ON(!link || !link_sta))
 		return -EINVAL;
 
-	sband = ieee80211_get_link_sband(sdata, link_id);
+	sband = ieee80211_get_link_sband(link);
 	if (!sband)
 		return -EINVAL;
 
@@ -1616,7 +1629,7 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 
 	if (params->supported_rates &&
 	    params->supported_rates_len) {
-		ieee80211_parse_bitrates(&sdata->vif.link_conf[link_id]->chandef,
+		ieee80211_parse_bitrates(&link->conf->chandef,
 					 sband, params->supported_rates,
 					 params->supported_rates_len,
 					 &link_sta->pub->supp_rates[sband->band]);
@@ -1667,9 +1680,14 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	u32 link_id = params->link_sta_params.link_id < 0 ?
 		      0 : params->link_sta_params.link_id;
+	struct ieee80211_link_data *link;
 	u32 mask, set;
 
-	sband = ieee80211_get_link_sband(sdata, link_id);
+	link = sdata_dereference(sdata->link[link_id], sdata);
+	if (!link)
+		return -ENOLINK;
+
+	sband = ieee80211_get_link_sband(link);
 	if (!sband)
 		return -EINVAL;
 
@@ -1987,7 +2005,14 @@ static int ieee80211_change_station(struct wiphy *wiphy,
 		}
 	}
 
-	err = sta_apply_parameters(local, sta, params);
+	/* we use sta_info_get_bss() so this might be different */
+	if (sdata != sta->sdata) {
+		mutex_lock_nested(&sta->sdata->wdev.mtx, 1);
+		err = sta_apply_parameters(local, sta, params);
+		mutex_unlock(&sta->sdata->wdev.mtx);
+	} else {
+		err = sta_apply_parameters(local, sta, params);
+	}
 	if (err)
 		goto out_err;
 
@@ -2374,7 +2399,8 @@ static int ieee80211_update_mesh_config(struct wiphy *wiphy,
 	if (_chg_mesh_attr(NL80211_MESHCONF_HT_OPMODE, mask)) {
 		conf->ht_opmode = nconf->ht_opmode;
 		sdata->vif.bss_conf.ht_operation_mode = nconf->ht_opmode;
-		ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_HT);
+		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+						  BSS_CHANGED_HT);
 	}
 	if (_chg_mesh_attr(NL80211_MESHCONF_HWMP_PATH_TO_ROOT_TIMEOUT, mask))
 		conf->dot11MeshHWMPactivePathToRootTimeout =
@@ -2426,7 +2452,7 @@ static int ieee80211_join_mesh(struct wiphy *wiphy, struct net_device *dev,
 	sdata->deflink.needed_rx_chains = sdata->local->rx_chains;
 
 	mutex_lock(&sdata->local->mtx);
-	err = ieee80211_link_use_channel(sdata->link[0], &setup->chandef,
+	err = ieee80211_link_use_channel(&sdata->deflink, &setup->chandef,
 					 IEEE80211_CHANCTX_SHARED);
 	mutex_unlock(&sdata->local->mtx);
 	if (err)
@@ -2441,7 +2467,7 @@ static int ieee80211_leave_mesh(struct wiphy *wiphy, struct net_device *dev)
 
 	ieee80211_stop_mesh(sdata);
 	mutex_lock(&sdata->local->mtx);
-	ieee80211_link_release_channel(sdata->link[0]);
+	ieee80211_link_release_channel(&sdata->deflink);
 	kfree(sdata->u.mesh.ie);
 	mutex_unlock(&sdata->local->mtx);
 
@@ -2529,7 +2555,7 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
 		changed |= BSS_CHANGED_P2P_PS;
 	}
 
-	ieee80211_link_info_change_notify(sdata, 0, changed);
+	ieee80211_link_info_change_notify(sdata, &sdata->deflink, changed);
 
 	return 0;
 }
@@ -2570,7 +2596,8 @@ static int ieee80211_set_txq_params(struct wiphy *wiphy,
 		return -EINVAL;
 	}
 
-	ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_QOS);
+	ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+					  BSS_CHANGED_QOS);
 
 	return 0;
 }
@@ -2719,7 +2746,8 @@ static int ieee80211_set_mcast_rate(struct wiphy *wiphy, struct net_device *dev,
 	memcpy(sdata->vif.bss_conf.mcast_rate, rate,
 	       sizeof(int) * NUM_NL80211_BANDS);
 
-	ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_MCAST_RATE);
+	ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+					  BSS_CHANGED_MCAST_RATE);
 
 	return 0;
 }
@@ -2934,7 +2962,7 @@ static int ieee80211_testmode_dump(struct wiphy *wiphy,
 #endif
 
 int __ieee80211_request_smps_mgd(struct ieee80211_sub_if_data *sdata,
-				 unsigned int link_id,
+				 struct ieee80211_link_data *link,
 				 enum ieee80211_smps_mode smps_mode)
 {
 	const u8 *ap;
@@ -2948,8 +2976,8 @@ int __ieee80211_request_smps_mgd(struct ieee80211_sub_if_data *sdata,
 	if (WARN_ON_ONCE(sdata->vif.type != NL80211_IFTYPE_STATION))
 		return -EINVAL;
 
-	old_req = sdata->link[link_id]->u.mgd.req_smps;
-	sdata->link[link_id]->u.mgd.req_smps = smps_mode;
+	old_req = link->u.mgd.req_smps;
+	link->u.mgd.req_smps = smps_mode;
 
 	if (old_req == smps_mode &&
 	    smps_mode != IEEE80211_SMPS_AUTOMATIC)
@@ -2961,10 +2989,10 @@ int __ieee80211_request_smps_mgd(struct ieee80211_sub_if_data *sdata,
 	 * the new value until we associate.
 	 */
 	if (!sdata->u.mgd.associated ||
-	    sdata->vif.link_conf[link_id]->chandef.width == NL80211_CHAN_WIDTH_20_NOHT)
+	    link->conf->chandef.width == NL80211_CHAN_WIDTH_20_NOHT)
 		return 0;
 
-	ap = sdata->link[link_id]->u.mgd.bssid;
+	ap = link->u.mgd.bssid;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(sta, &sdata->local->sta_list, list) {
@@ -2988,7 +3016,7 @@ int __ieee80211_request_smps_mgd(struct ieee80211_sub_if_data *sdata,
 	err = ieee80211_send_smps_action(sdata, smps_mode,
 					 ap, ap);
 	if (err)
-		sdata->link[link_id]->u.mgd.req_smps = old_req;
+		link->u.mgd.req_smps = old_req;
 	else if (smps_mode != IEEE80211_SMPS_OFF && tdls_peer_found)
 		ieee80211_teardown_tdls_peers(sdata);
 
@@ -3018,10 +3046,14 @@ static int ieee80211_set_power_mgmt(struct wiphy *wiphy, struct net_device *dev,
 	/* no change, but if automatic follow powersave */
 	sdata_lock(sdata);
 	for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++) {
-		if (!sdata->link[link_id])
+		struct ieee80211_link_data *link;
+
+		link = sdata_dereference(sdata->link[link_id], sdata);
+
+		if (!link)
 			continue;
-		__ieee80211_request_smps_mgd(sdata, link_id,
-					     sdata->link[link_id]->u.mgd.req_smps);
+		__ieee80211_request_smps_mgd(sdata, link,
+					     link->u.mgd.req_smps);
 	}
 	sdata_unlock(sdata);
 
@@ -3060,7 +3092,8 @@ static int ieee80211_set_cqm_rssi_config(struct wiphy *wiphy,
 	/* tell the driver upon association, unless already associated */
 	if (sdata->u.mgd.associated &&
 	    sdata->vif.driver_flags & IEEE80211_VIF_SUPPORTS_CQM_RSSI)
-		ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_CQM);
+		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+						  BSS_CHANGED_CQM);
 
 	return 0;
 }
@@ -3085,7 +3118,8 @@ static int ieee80211_set_cqm_rssi_range_config(struct wiphy *wiphy,
 	/* tell the driver upon association, unless already associated */
 	if (sdata->u.mgd.associated &&
 	    sdata->vif.driver_flags & IEEE80211_VIF_SUPPORTS_CQM_RSSI)
-		ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_CQM);
+		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+						  BSS_CHANGED_CQM);
 
 	return 0;
 }
@@ -3177,7 +3211,7 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 	sdata->deflink.smps_mode = IEEE80211_SMPS_OFF;
 	sdata->deflink.needed_rx_chains = local->rx_chains;
 
-	err = ieee80211_link_use_channel(sdata->link[0], chandef,
+	err = ieee80211_link_use_channel(&sdata->deflink, chandef,
 					 IEEE80211_CHANCTX_SHARED);
 	if (err)
 		goto out_unlock;
@@ -3206,7 +3240,7 @@ static void ieee80211_end_cac(struct wiphy *wiphy,
 		cancel_delayed_work(&sdata->deflink.dfs_cac_timer_work);
 
 		if (sdata->wdev.cac_started) {
-			ieee80211_link_release_channel(sdata->link[0]);
+			ieee80211_link_release_channel(&sdata->deflink);
 			sdata->wdev.cac_started = false;
 		}
 	}
@@ -3353,7 +3387,7 @@ static int ieee80211_set_after_csa_beacon(struct ieee80211_sub_if_data *sdata,
 		if (!sdata->deflink.u.ap.next_beacon)
 			return -EINVAL;
 
-		err = ieee80211_assign_beacon(sdata,
+		err = ieee80211_assign_beacon(sdata, &sdata->deflink,
 					      sdata->deflink.u.ap.next_beacon,
 					      NULL, NULL);
 		ieee80211_free_next_beacon(&sdata->deflink);
@@ -3410,7 +3444,7 @@ static int __ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
 		if (sdata->deflink.reserved_ready)
 			return 0;
 
-		return ieee80211_link_use_reserved_context(sdata->link[0]);
+		return ieee80211_link_use_reserved_context(&sdata->deflink);
 	}
 
 	if (!cfg80211_chandef_identical(&sdata->vif.bss_conf.chandef,
@@ -3423,7 +3457,7 @@ static int __ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
 	if (err)
 		return err;
 
-	ieee80211_link_info_change_notify(sdata, 0, changed);
+	ieee80211_link_info_change_notify(sdata, &sdata->deflink, changed);
 
 	if (sdata->deflink.csa_block_tx) {
 		ieee80211_wake_vif_queues(local, sdata,
@@ -3522,7 +3556,9 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 		csa.n_counter_offsets_presp = params->n_counter_offsets_presp;
 		csa.count = params->count;
 
-		err = ieee80211_assign_beacon(sdata, &params->beacon_csa, &csa, NULL);
+		err = ieee80211_assign_beacon(sdata, &sdata->deflink,
+					      &params->beacon_csa, &csa,
+					      NULL);
 		if (err < 0) {
 			ieee80211_free_next_beacon(&sdata->deflink);
 			return err;
@@ -3675,7 +3711,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	if (err)
 		goto out;
 
-	err = ieee80211_link_reserve_chanctx(sdata->link[0], &params->chandef,
+	err = ieee80211_link_reserve_chanctx(&sdata->deflink, &params->chandef,
 					     chanctx->mode,
 					     params->radar_required);
 	if (err)
@@ -3684,7 +3720,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	/* if reservation is invalid then this will fail */
 	err = ieee80211_check_combinations(sdata, NULL, chanctx->mode, 0);
 	if (err) {
-		ieee80211_link_unreserve_chanctx(sdata->link[0]);
+		ieee80211_link_unreserve_chanctx(&sdata->deflink);
 		goto out;
 	}
 
@@ -3694,7 +3730,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 
 	err = ieee80211_set_csa_beacon(sdata, params, &changed);
 	if (err) {
-		ieee80211_link_unreserve_chanctx(sdata->link[0]);
+		ieee80211_link_unreserve_chanctx(&sdata->deflink);
 		goto out;
 	}
 
@@ -3711,7 +3747,8 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 					  params->count, params->block_tx);
 
 	if (changed) {
-		ieee80211_link_info_change_notify(sdata, 0, changed);
+		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+						  changed);
 		drv_channel_switch_beacon(sdata, &params->chandef);
 	} else {
 		/* if the beacon didn't change, we can finalize immediately */
@@ -3950,12 +3987,19 @@ static int ieee80211_cfg_get_channel(struct wiphy *wiphy,
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 	struct ieee80211_local *local = wiphy_priv(wiphy);
 	struct ieee80211_chanctx_conf *chanctx_conf;
+	struct ieee80211_link_data *link;
 	int ret = -ENODATA;
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.link_conf[link_id]->chanctx_conf);
+	link = rcu_dereference(sdata->link[link_id]);
+	if (!link) {
+		ret = -ENOLINK;
+		goto out;
+	}
+
+	chanctx_conf = rcu_dereference(link->conf->chanctx_conf);
 	if (chanctx_conf) {
-		*chandef = sdata->vif.link_conf[link_id]->chandef;
+		*chandef = link->conf->chandef;
 		ret = 0;
 	} else if (local->open_count > 0 &&
 		   local->open_count == local->monitors &&
@@ -3966,6 +4010,7 @@ static int ieee80211_cfg_get_channel(struct wiphy *wiphy,
 			*chandef = local->_oper_chandef;
 		ret = 0;
 	}
+out:
 	rcu_read_unlock();
 
 	return ret;
@@ -4009,13 +4054,15 @@ static int ieee80211_set_ap_chanwidth(struct wiphy *wiphy,
 				      struct cfg80211_chan_def *chandef)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_link_data *link;
 	int ret;
 	u32 changed = 0;
 
-	ret = ieee80211_link_change_bandwidth(sdata->link[link_id], chandef,
-					      &changed);
+	link = sdata_dereference(sdata->link[link_id], sdata);
+
+	ret = ieee80211_link_change_bandwidth(link, chandef, &changed);
 	if (ret == 0)
-		ieee80211_link_info_change_notify(sdata, link_id, changed);
+		ieee80211_link_info_change_notify(sdata, link, changed);
 
 	return ret;
 }
@@ -4358,7 +4405,7 @@ ieee80211_set_after_color_change_beacon(struct ieee80211_sub_if_data *sdata,
 		if (!sdata->deflink.u.ap.next_beacon)
 			return -EINVAL;
 
-		ret = ieee80211_assign_beacon(sdata,
+		ret = ieee80211_assign_beacon(sdata, &sdata->deflink,
 					      sdata->deflink.u.ap.next_beacon,
 					      NULL, NULL);
 		ieee80211_free_next_beacon(&sdata->deflink);
@@ -4401,7 +4448,8 @@ ieee80211_set_color_change_beacon(struct ieee80211_sub_if_data *sdata,
 			params->counter_offset_presp;
 		color_change.count = params->count;
 
-		err = ieee80211_assign_beacon(sdata, &params->beacon_color_change,
+		err = ieee80211_assign_beacon(sdata, &sdata->deflink,
+					      &params->beacon_color_change,
 					      NULL, &color_change);
 		if (err < 0) {
 			ieee80211_free_next_beacon(&sdata->deflink);
@@ -4424,7 +4472,7 @@ ieee80211_color_change_bss_config_notify(struct ieee80211_sub_if_data *sdata,
 	sdata->vif.bss_conf.he_bss_color.enabled = enable;
 	changed |= BSS_CHANGED_HE_BSS_COLOR;
 
-	ieee80211_link_info_change_notify(sdata, 0, changed);
+	ieee80211_link_info_change_notify(sdata, &sdata->deflink, changed);
 
 	if (!sdata->vif.bss_conf.nontransmitted && sdata->vif.mbssid_tx_vif) {
 		struct ieee80211_sub_if_data *child;
@@ -4434,7 +4482,8 @@ ieee80211_color_change_bss_config_notify(struct ieee80211_sub_if_data *sdata,
 			if (child != sdata && child->vif.mbssid_tx_vif == &sdata->vif) {
 				child->vif.bss_conf.he_bss_color.color = color;
 				child->vif.bss_conf.he_bss_color.enabled = enable;
-				ieee80211_link_info_change_notify(child, 0,
+				ieee80211_link_info_change_notify(child,
+								  &child->deflink,
 								  BSS_CHANGED_HE_BSS_COLOR);
 			}
 		}
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 6853b563fb6c..8d384956fde5 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -67,14 +67,12 @@ static bool ieee80211_can_create_new_chanctx(struct ieee80211_local *local)
 }
 
 static struct ieee80211_chanctx *
-ieee80211_vif_get_chanctx(struct ieee80211_sub_if_data *sdata,
-			  unsigned int link_id)
+ieee80211_link_get_chanctx(struct ieee80211_link_data *link)
 {
-	struct ieee80211_bss_conf *link_conf = sdata->vif.link_conf[link_id];
-	struct ieee80211_local *local __maybe_unused = sdata->local;
+	struct ieee80211_local *local __maybe_unused = link->sdata->local;
 	struct ieee80211_chanctx_conf *conf;
 
-	conf = rcu_dereference_protected(link_conf->chanctx_conf,
+	conf = rcu_dereference_protected(link->conf->chanctx_conf,
 					 lockdep_is_held(&local->chanctx_mtx));
 	if (!conf)
 		return NULL;
@@ -82,12 +80,6 @@ ieee80211_vif_get_chanctx(struct ieee80211_sub_if_data *sdata,
 	return container_of(conf, struct ieee80211_chanctx, conf);
 }
 
-static struct ieee80211_chanctx *
-ieee80211_link_get_chanctx(struct ieee80211_link_data *link)
-{
-	return ieee80211_vif_get_chanctx(link->sdata, link->link_id);
-}
-
 static const struct cfg80211_chan_def *
 ieee80211_chanctx_reserved_chandef(struct ieee80211_local *local,
 				   struct ieee80211_chanctx *ctx,
@@ -122,8 +114,7 @@ ieee80211_chanctx_non_reserved_chandef(struct ieee80211_local *local,
 
 	list_for_each_entry(link, &ctx->assigned_links,
 			    assigned_chanctx_list) {
-		struct ieee80211_bss_conf *link_conf =
-			link->sdata->vif.link_conf[link->link_id];
+		struct ieee80211_bss_conf *link_conf = link->conf;
 
 		if (link->reserved_chanctx)
 			continue;
@@ -254,7 +245,6 @@ ieee80211_get_max_required_bw(struct ieee80211_sub_if_data *sdata,
 	enum nl80211_chan_width max_bw = NL80211_CHAN_WIDTH_20_NOHT;
 	struct sta_info *sta;
 
-	rcu_read_lock();
 	list_for_each_entry_rcu(sta, &sdata->local->sta_list, list) {
 		if (sdata != sta->sdata &&
 		    !(sta->sdata->bss && sta->sdata->bss == sdata->bss))
@@ -262,7 +252,6 @@ ieee80211_get_max_required_bw(struct ieee80211_sub_if_data *sdata,
 
 		max_bw = max(max_bw, ieee80211_get_sta_bw(sta, link_id));
 	}
-	rcu_read_unlock();
 
 	return max_bw;
 }
@@ -275,10 +264,11 @@ ieee80211_get_chanctx_vif_max_required_bw(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_vif *vif = &sdata->vif;
 	int link_id;
 
+	rcu_read_lock();
 	for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++) {
 		enum nl80211_chan_width width = NL80211_CHAN_WIDTH_20_NOHT;
 		struct ieee80211_bss_conf *link_conf =
-			sdata->vif.link_conf[link_id];
+			rcu_dereference(sdata->vif.link_conf[link_id]);
 
 		if (!link_conf)
 			continue;
@@ -319,6 +309,7 @@ ieee80211_get_chanctx_vif_max_required_bw(struct ieee80211_sub_if_data *sdata,
 
 		max_bw = max(max_bw, width);
 	}
+	rcu_read_unlock();
 
 	return max_bw;
 }
@@ -345,7 +336,7 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
 	/* use the configured bandwidth in case of monitor interface */
 	sdata = rcu_dereference(local->monitor_sdata);
 	if (sdata &&
-	    rcu_access_pointer(sdata->vif.link_conf[0]->chanctx_conf) == conf)
+	    rcu_access_pointer(sdata->vif.bss_conf.chanctx_conf) == conf)
 		max_bw = max(max_bw, conf->def.width);
 
 	rcu_read_unlock();
@@ -419,7 +410,7 @@ static void ieee80211_chan_bw_change(struct ieee80211_local *local,
 
 		for (link_id = 0; link_id < ARRAY_SIZE(sta->sdata->link); link_id++) {
 			struct ieee80211_bss_conf *link_conf =
-				sdata->vif.link_conf[link_id];
+				rcu_dereference(sdata->vif.link_conf[link_id]);
 			struct link_sta_info *link_sta;
 
 			if (!link_conf)
@@ -572,8 +563,11 @@ bool ieee80211_is_radar_required(struct ieee80211_local *local)
 		unsigned int link_id;
 
 		for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++) {
-			if (sdata->link[link_id] &&
-			    sdata->link[link_id]->radar_required) {
+			struct ieee80211_link_data *link;
+
+			link = rcu_dereference(sdata->link[link_id]);
+
+			if (link && link->radar_required) {
 				rcu_read_unlock();
 				return true;
 			}
@@ -602,15 +596,15 @@ ieee80211_chanctx_radar_required(struct ieee80211_local *local,
 		if (!ieee80211_sdata_running(sdata))
 			continue;
 		for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++) {
-			struct ieee80211_bss_conf *link_conf =
-				sdata->vif.link_conf[link_id];
+			struct ieee80211_link_data *link;
 
-			if (!link_conf)
+			link = rcu_dereference(sdata->link[link_id]);
+			if (!link)
 				continue;
 
-			if (rcu_access_pointer(link_conf->chanctx_conf) != conf)
+			if (rcu_access_pointer(link->conf->chanctx_conf) != conf)
 				continue;
-			if (!sdata->link[link_id]->radar_required)
+			if (!link->radar_required)
 				continue;
 			required = true;
 			break;
@@ -774,7 +768,7 @@ void ieee80211_recalc_chanctx_chantype(struct ieee80211_local *local,
 
 		for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++) {
 			struct ieee80211_bss_conf *link_conf =
-				sdata->vif.link_conf[link_id];
+				rcu_dereference(sdata->vif.link_conf[link_id]);
 
 			if (!link_conf)
 				continue;
@@ -850,7 +844,7 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 	if (WARN_ON(sdata->vif.type == NL80211_IFTYPE_NAN))
 		return -ENOTSUPP;
 
-	conf = rcu_dereference_protected(sdata->vif.link_conf[link_id]->chanctx_conf,
+	conf = rcu_dereference_protected(link->conf->chanctx_conf,
 					 lockdep_is_held(&local->chanctx_mtx));
 
 	if (conf) {
@@ -872,7 +866,7 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 	}
 
 out:
-	rcu_assign_pointer(sdata->vif.link_conf[link_id]->chanctx_conf, conf);
+	rcu_assign_pointer(link->conf->chanctx_conf, conf);
 
 	sdata->vif.cfg.idle = !conf;
 
@@ -931,14 +925,14 @@ void ieee80211_recalc_smps_chanctx(struct ieee80211_local *local,
 		}
 
 		for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++) {
-			struct ieee80211_link_data *link = sdata->link[link_id];
-			struct ieee80211_bss_conf *link_conf =
-				sdata->vif.link_conf[link_id];
+			struct ieee80211_link_data *link;
 
-			if (!link_conf)
+			link = rcu_dereference(sdata->link[link_id]);
+
+			if (!link)
 				continue;
 
-			if (rcu_access_pointer(link_conf->chanctx_conf) != &chanctx->conf)
+			if (rcu_access_pointer(link->conf->chanctx_conf) != &chanctx->conf)
 				continue;
 
 			switch (link->smps_mode) {
@@ -968,7 +962,7 @@ void ieee80211_recalc_smps_chanctx(struct ieee80211_local *local,
 	/* Disable SMPS for the monitor interface */
 	sdata = rcu_dereference(local->monitor_sdata);
 	if (sdata &&
-	    rcu_access_pointer(sdata->vif.link_conf[0]->chanctx_conf) == &chanctx->conf)
+	    rcu_access_pointer(sdata->vif.bss_conf.chanctx_conf) == &chanctx->conf)
 		rx_chains_dynamic = rx_chains_static = local->rx_chains;
 
 	rcu_read_unlock();
@@ -998,7 +992,7 @@ __ieee80211_link_copy_chanctx_to_vlans(struct ieee80211_link_data *link,
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	unsigned int link_id = link->link_id;
-	struct ieee80211_bss_conf *link_conf = sdata->vif.link_conf[link_id];
+	struct ieee80211_bss_conf *link_conf = link->conf;
 	struct ieee80211_local *local __maybe_unused = sdata->local;
 	struct ieee80211_sub_if_data *vlan;
 	struct ieee80211_chanctx_conf *conf;
@@ -1021,9 +1015,17 @@ __ieee80211_link_copy_chanctx_to_vlans(struct ieee80211_link_data *link,
 	if (clear)
 		conf = NULL;
 
-	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list)
-		rcu_assign_pointer(vlan->vif.link_conf[link_id]->chanctx_conf,
-				   conf);
+	rcu_read_lock();
+	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list) {
+		struct ieee80211_bss_conf *vlan_conf;
+
+		vlan_conf = rcu_dereference(vlan->vif.link_conf[link_id]);
+		if (WARN_ON(!vlan_conf))
+			continue;
+
+		rcu_assign_pointer(vlan_conf->chanctx_conf, conf);
+	}
+	rcu_read_unlock();
 }
 
 void ieee80211_link_copy_chanctx_to_vlans(struct ieee80211_link_data *link,
@@ -1210,21 +1212,29 @@ ieee80211_link_update_chandef(struct ieee80211_link_data *link,
 	unsigned int link_id = link->link_id;
 	struct ieee80211_sub_if_data *vlan;
 
-	sdata->vif.link_conf[link_id]->chandef = *chandef;
+	link->conf->chandef = *chandef;
 
 	if (sdata->vif.type != NL80211_IFTYPE_AP)
 		return;
 
-	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list)
-		vlan->vif.link_conf[link_id]->chandef = *chandef;
+	rcu_read_lock();
+	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list) {
+		struct ieee80211_bss_conf *vlan_conf;
+
+		vlan_conf = rcu_dereference(vlan->vif.link_conf[link_id]);
+		if (WARN_ON(!vlan_conf))
+			continue;
+
+		vlan_conf->chandef = *chandef;
+	}
+	rcu_read_unlock();
 }
 
 static int
 ieee80211_link_use_reserved_reassign(struct ieee80211_link_data *link)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
-	unsigned int link_id = link->link_id;
-	struct ieee80211_bss_conf *link_conf = sdata->vif.link_conf[link_id];
+	struct ieee80211_bss_conf *link_conf = link->conf;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_vif_chanctx_switch vif_chsw[1] = {};
 	struct ieee80211_chanctx *old_ctx, *new_ctx;
@@ -1296,7 +1306,7 @@ ieee80211_link_use_reserved_reassign(struct ieee80211_link_data *link)
 	ieee80211_recalc_radar_chanctx(local, new_ctx);
 
 	if (changed)
-		ieee80211_link_info_change_notify(sdata, link_id, changed);
+		ieee80211_link_info_change_notify(sdata, link, changed);
 
 out:
 	ieee80211_link_chanctx_reservation_complete(link);
@@ -1307,13 +1317,12 @@ static int
 ieee80211_link_use_reserved_assign(struct ieee80211_link_data *link)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
-	unsigned int link_id = link->link_id;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx *old_ctx, *new_ctx;
 	const struct cfg80211_chan_def *chandef;
 	int err;
 
-	old_ctx = ieee80211_vif_get_chanctx(sdata, link_id);
+	old_ctx = ieee80211_link_get_chanctx(link);
 	new_ctx = link->reserved_chanctx;
 
 	if (WARN_ON(!link->reserved_ready))
@@ -1625,8 +1634,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		list_for_each_entry(link, &ctx->reserved_links,
 				    reserved_chanctx_list) {
 			struct ieee80211_sub_if_data *sdata = link->sdata;
-			struct ieee80211_bss_conf *link_conf =
-				sdata->vif.link_conf[link->link_id];
+			struct ieee80211_bss_conf *link_conf = link->conf;
 			u32 changed = 0;
 
 			if (!ieee80211_link_has_in_place_reservation(link))
@@ -1649,7 +1657,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 			ieee80211_link_update_chandef(link, &link->reserved_chandef);
 			if (changed)
 				ieee80211_link_info_change_notify(sdata,
-								  link->link_id,
+								  link,
 								  changed);
 
 			ieee80211_recalc_txpower(sdata, false);
@@ -1746,8 +1754,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 static void __ieee80211_link_release_channel(struct ieee80211_link_data *link)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
-	unsigned int link_id = link->link_id;
-	struct ieee80211_bss_conf *link_conf = sdata->vif.link_conf[link_id];
+	struct ieee80211_bss_conf *link_conf = link->conf;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx_conf *conf;
 	struct ieee80211_chanctx *ctx;
@@ -1786,7 +1793,6 @@ int ieee80211_link_use_channel(struct ieee80211_link_data *link,
 			       enum ieee80211_chanctx_mode mode)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
-	unsigned int link_id = link->link_id;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx *ctx;
 	u8 radar_detect_width = 0;
@@ -1806,7 +1812,7 @@ int ieee80211_link_use_channel(struct ieee80211_link_data *link,
 	if (ret > 0)
 		radar_detect_width = BIT(chandef->width);
 
-	sdata->link[link_id]->radar_required = ret;
+	link->radar_required = ret;
 
 	ret = ieee80211_check_combinations(sdata, chandef, mode,
 					   radar_detect_width);
@@ -1910,8 +1916,7 @@ int ieee80211_link_change_bandwidth(struct ieee80211_link_data *link,
 				    u32 *changed)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
-	unsigned int link_id = link->link_id;
-	struct ieee80211_bss_conf *link_conf = sdata->vif.link_conf[link_id];
+	struct ieee80211_bss_conf *link_conf = link->conf;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx_conf *conf;
 	struct ieee80211_chanctx *ctx;
@@ -1997,7 +2002,8 @@ void ieee80211_link_vlan_copy_chanctx(struct ieee80211_link_data *link)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	unsigned int link_id = link->link_id;
-	struct ieee80211_bss_conf *link_conf = sdata->vif.link_conf[link_id];
+	struct ieee80211_bss_conf *link_conf = link->conf;
+	struct ieee80211_bss_conf *ap_conf;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_sub_if_data *ap;
 	struct ieee80211_chanctx_conf *conf;
@@ -2009,9 +2015,12 @@ void ieee80211_link_vlan_copy_chanctx(struct ieee80211_link_data *link)
 
 	mutex_lock(&local->chanctx_mtx);
 
-	conf = rcu_dereference_protected(ap->vif.link_conf[link_id]->chanctx_conf,
+	rcu_read_lock();
+	ap_conf = rcu_dereference(ap->vif.link_conf[link_id]);
+	conf = rcu_dereference_protected(ap_conf->chanctx_conf,
 					 lockdep_is_held(&local->chanctx_mtx));
 	rcu_assign_pointer(link_conf->chanctx_conf, conf);
+	rcu_read_unlock();
 	mutex_unlock(&local->chanctx_mtx);
 }
 
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index ead917501d6c..1e5b041a5cea 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -256,7 +256,7 @@ static int ieee80211_set_smps(struct ieee80211_sub_if_data *sdata,
 		return -EOPNOTSUPP;
 
 	sdata_lock(sdata);
-	err = __ieee80211_request_smps_mgd(sdata, 0, smps_mode);
+	err = __ieee80211_request_smps_mgd(sdata, &sdata->deflink, smps_mode);
 	sdata_unlock(sdata);
 
 	return err;
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index db38c8cc9d8f..ee3ac1a01bb0 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -167,6 +167,7 @@ static inline void drv_vif_cfg_changed(struct ieee80211_local *local,
 
 static inline void drv_link_info_changed(struct ieee80211_local *local,
 					 struct ieee80211_sub_if_data *sdata,
+					 struct ieee80211_bss_conf *info,
 					 int link_id, u64 changed)
 {
 	might_sleep();
@@ -189,13 +190,13 @@ static inline void drv_link_info_changed(struct ieee80211_local *local,
 	if (!check_sdata_in_driver(sdata))
 		return;
 
-	trace_drv_link_info_changed(local, sdata, link_id, changed);
+	trace_drv_link_info_changed(local, sdata, info, link_id, changed);
 	if (local->ops->link_info_changed)
 		local->ops->link_info_changed(&local->hw, &sdata->vif,
-					      link_id, changed);
+					      info, link_id, changed);
 	else if (local->ops->bss_info_changed)
 		local->ops->bss_info_changed(&local->hw, &sdata->vif,
-					     &sdata->vif.bss_conf, changed);
+					     info, changed);
 	trace_drv_return_void(local);
 }
 
@@ -995,8 +996,7 @@ static inline int drv_start_ap(struct ieee80211_local *local,
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
 
-	trace_drv_start_ap(local, sdata, sdata->vif.link_conf[link_id],
-			   link_id);
+	trace_drv_start_ap(local, sdata, link_id);
 	if (local->ops->start_ap)
 		ret = local->ops->start_ap(&local->hw, &sdata->vif, link_id);
 	trace_drv_return_int(local, ret);
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 2eb3a409b70f..ea7ce87b7ec4 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -140,12 +140,14 @@ bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
 				       const struct ieee80211_ht_cap *ht_cap_ie,
 				       struct link_sta_info *link_sta)
 {
+	struct ieee80211_bss_conf *link_conf;
 	struct sta_info *sta = link_sta->sta;
 	struct ieee80211_sta_ht_cap ht_cap, own_cap;
 	u8 ampdu_info, tx_mcs_set_cap;
 	int i, max_tx_streams;
 	bool changed;
 	enum ieee80211_sta_rx_bandwidth bw;
+	enum nl80211_chan_width width;
 
 	memset(&ht_cap, 0, sizeof(ht_cap));
 
@@ -248,7 +250,14 @@ bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
 
 	memcpy(&link_sta->pub->ht_cap, &ht_cap, sizeof(ht_cap));
 
-	switch (sdata->vif.link_conf[link_sta->link_id]->chandef.width) {
+	rcu_read_lock();
+	link_conf = rcu_dereference(sdata->vif.link_conf[link_sta->link_id]);
+	if (WARN_ON(!link_conf))
+		width = NL80211_CHAN_WIDTH_20_NOHT;
+	else
+		width = link_conf->chandef.width;
+
+	switch (width) {
 	default:
 		WARN_ON_ONCE(1);
 		fallthrough;
@@ -264,6 +273,7 @@ bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
 				IEEE80211_STA_RX_BW_40 : IEEE80211_STA_RX_BW_20;
 		break;
 	}
+	rcu_read_unlock();
 
 	link_sta->pub->bandwidth = bw;
 
@@ -547,7 +557,7 @@ void ieee80211_request_smps_mgd_work(struct work_struct *work)
 			     u.mgd.request_smps_work);
 
 	sdata_lock(link->sdata);
-	__ieee80211_request_smps_mgd(link->sdata, link->link_id,
+	__ieee80211_request_smps_mgd(link->sdata, link,
 				     link->u.mgd.driver_smps_mode);
 	sdata_unlock(link->sdata);
 }
@@ -556,19 +566,23 @@ void ieee80211_request_smps(struct ieee80211_vif *vif, unsigned int link_id,
 			    enum ieee80211_smps_mode smps_mode)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
-	struct ieee80211_link_data *link = sdata->link[link_id];
+	struct ieee80211_link_data *link;
 
 	if (WARN_ON_ONCE(vif->type != NL80211_IFTYPE_STATION))
 		return;
 
+	rcu_read_lock();
+	link = rcu_dereference(sdata->link[link_id]);
 	if (WARN_ON(!link))
-		return;
+		goto out;
 
 	if (link->u.mgd.driver_smps_mode == smps_mode)
-		return;
+		goto out;
 
 	link->u.mgd.driver_smps_mode = smps_mode;
 	ieee80211_queue_work(&sdata->local->hw, &link->u.mgd.request_smps_work);
+out:
+	rcu_read_unlock();
 }
 /* this might change ... don't want non-open drivers using it */
 EXPORT_SYMBOL_GPL(ieee80211_request_smps);
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index d30a82f1620b..393c7595bfa4 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -300,7 +300,7 @@ static void __ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 	radar_required = err;
 
 	mutex_lock(&local->mtx);
-	if (ieee80211_link_use_channel(sdata->link[0], &chandef,
+	if (ieee80211_link_use_channel(&sdata->deflink, &chandef,
 				       ifibss->fixed_channel ?
 					IEEE80211_CHANCTX_SHARED :
 					IEEE80211_CHANCTX_EXCLUSIVE)) {
@@ -370,7 +370,7 @@ static void __ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 		RCU_INIT_POINTER(ifibss->presp, NULL);
 		kfree_rcu(presp, rcu_head);
 		mutex_lock(&local->mtx);
-		ieee80211_link_release_channel(sdata->link[0]);
+		ieee80211_link_release_channel(&sdata->deflink);
 		mutex_unlock(&local->mtx);
 		sdata_info(sdata, "Failed to join IBSS, driver failure: %d\n",
 			   err);
@@ -722,7 +722,7 @@ static void ieee80211_ibss_disconnect(struct ieee80211_sub_if_data *sdata)
 						BSS_CHANGED_IBSS);
 	drv_leave_ibss(local, sdata);
 	mutex_lock(&local->mtx);
-	ieee80211_link_release_channel(sdata->link[0]);
+	ieee80211_link_release_channel(&sdata->deflink);
 	mutex_unlock(&local->mtx);
 }
 
@@ -1848,7 +1848,7 @@ int ieee80211_ibss_join(struct ieee80211_sub_if_data *sdata,
 		| IEEE80211_HT_PARAM_RIFS_MODE;
 
 	changed |= BSS_CHANGED_HT | BSS_CHANGED_MCAST_RATE;
-	ieee80211_link_info_change_notify(sdata, 0, changed);
+	ieee80211_link_info_change_notify(sdata, &sdata->deflink, changed);
 
 	sdata->deflink.smps_mode = IEEE80211_SMPS_OFF;
 	sdata->deflink.needed_rx_chains = local->rx_chains;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index a0023ad7ca1c..aa1e438ee61e 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -961,6 +961,8 @@ struct ieee80211_link_data {
 		struct ieee80211_link_data_managed mgd;
 		struct ieee80211_link_data_ap ap;
 	} u;
+
+	struct ieee80211_bss_conf *conf;
 };
 
 struct ieee80211_sub_if_data {
@@ -1045,7 +1047,7 @@ struct ieee80211_sub_if_data {
 	} u;
 
 	struct ieee80211_link_data deflink;
-	struct ieee80211_link_data *link[IEEE80211_MLD_MAX_NUM_LINKS];
+	struct ieee80211_link_data __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
 
 #ifdef CONFIG_MAC80211_DEBUGFS
 	struct {
@@ -1544,16 +1546,14 @@ ieee80211_get_sband(struct ieee80211_sub_if_data *sdata)
 }
 
 static inline struct ieee80211_supported_band *
-ieee80211_get_link_sband(struct ieee80211_sub_if_data *sdata, u32 link_id)
+ieee80211_get_link_sband(struct ieee80211_link_data *link)
 {
-	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_local *local = link->sdata->local;
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	enum nl80211_band band;
 
 	rcu_read_lock();
-	chanctx_conf =
-		rcu_dereference(sdata->vif.link_conf[link_id]->chanctx_conf);
-
+	chanctx_conf = rcu_dereference(link->conf->chanctx_conf);
 	if (!chanctx_conf) {
 		rcu_read_unlock();
 		return NULL;
@@ -1721,7 +1721,8 @@ void ieee80211_bss_info_change_notify(struct ieee80211_sub_if_data *sdata,
 void ieee80211_vif_cfg_change_notify(struct ieee80211_sub_if_data *sdata,
 				     u64 changed);
 void ieee80211_link_info_change_notify(struct ieee80211_sub_if_data *sdata,
-				       int link_id, u64 changed);
+				       struct ieee80211_link_data *link,
+				       u64 changed);
 void ieee80211_configure_filter(struct ieee80211_local *local);
 u32 ieee80211_reset_erp_info(struct ieee80211_sub_if_data *sdata);
 
@@ -2002,7 +2003,7 @@ ieee80211_chan_width_to_rx_bw(enum nl80211_chan_width width);
 enum nl80211_chan_width
 ieee80211_sta_cap_chan_bw(struct link_sta_info *link_sta);
 void ieee80211_process_mu_groups(struct ieee80211_sub_if_data *sdata,
-				 unsigned int link_id,
+				 struct ieee80211_link_data *link,
 				 struct ieee80211_mgmt *mgmt);
 u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 				  struct link_sta_info *sta,
@@ -2277,10 +2278,10 @@ u32 ieee80211_sta_get_rates(struct ieee80211_sub_if_data *sdata,
 			    struct ieee802_11_elems *elems,
 			    enum nl80211_band band, u32 *basic_rates);
 int __ieee80211_request_smps_mgd(struct ieee80211_sub_if_data *sdata,
-				 unsigned int link_id,
+				 struct ieee80211_link_data *link,
 				 enum ieee80211_smps_mode smps_mode);
 void ieee80211_recalc_smps(struct ieee80211_sub_if_data *sdata,
-			   unsigned int link_id);
+			   struct ieee80211_link_data *link);
 void ieee80211_recalc_min_chandef(struct ieee80211_sub_if_data *sdata);
 
 size_t ieee80211_ie_split_vendor(const u8 *ies, size_t ielen, size_t offset);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 56dd831fe45f..12789a62366c 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -80,7 +80,7 @@ void ieee80211_recalc_txpower(struct ieee80211_sub_if_data *sdata,
 {
 	if (__ieee80211_recalc_txpower(sdata) ||
 	    (update_bss && ieee80211_sdata_running(sdata)))
-		ieee80211_link_info_change_notify(sdata, 0,
+		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
 						  BSS_CHANGED_TXPOWER);
 }
 
@@ -478,7 +478,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 		chandef = sdata->vif.bss_conf.chandef;
 		WARN_ON(local->suspended);
 		mutex_lock(&local->mtx);
-		ieee80211_link_release_channel(sdata->link[0]);
+		ieee80211_link_release_channel(&sdata->deflink);
 		mutex_unlock(&local->mtx);
 		cfg80211_cac_event(sdata->dev, &chandef,
 				   NL80211_RADAR_CAC_ABORTED,
@@ -1029,11 +1029,12 @@ static void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 	if (link_id < 0)
 		link_id = 0;
 
-	sdata->vif.link_conf[link_id] = link_conf;
-	sdata->link[link_id] = link;
+	rcu_assign_pointer(sdata->vif.link_conf[link_id], link_conf);
+	rcu_assign_pointer(sdata->link[link_id], link);
 
 	link->sdata = sdata;
 	link->link_id = link_id;
+	link->conf = link_conf;
 
 	INIT_WORK(&link->csa_finalize_work,
 		  ieee80211_csa_finalize_work);
@@ -1126,7 +1127,7 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 	mutex_unlock(&local->iflist_mtx);
 
 	mutex_lock(&local->mtx);
-	ret = ieee80211_link_use_channel(sdata->link[0], &local->monitor_chandef,
+	ret = ieee80211_link_use_channel(&sdata->deflink, &local->monitor_chandef,
 					 IEEE80211_CHANCTX_EXCLUSIVE);
 	mutex_unlock(&local->mtx);
 	if (ret) {
@@ -1171,7 +1172,7 @@ void ieee80211_del_virtual_monitor(struct ieee80211_local *local)
 	synchronize_net();
 
 	mutex_lock(&local->mtx);
-	ieee80211_link_release_channel(sdata->link[0]);
+	ieee80211_link_release_channel(&sdata->deflink);
 	mutex_unlock(&local->mtx);
 
 	drv_remove_interface(local, sdata);
@@ -1277,7 +1278,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	case NL80211_IFTYPE_AP_VLAN:
 		/* no need to tell driver, but set carrier and chanctx */
 		if (sdata->bss->active) {
-			ieee80211_link_vlan_copy_chanctx(sdata->link[0]);
+			ieee80211_link_vlan_copy_chanctx(&sdata->deflink);
 			netif_carrier_on(dev);
 			ieee80211_set_vif_encap_ops(sdata);
 		} else {
@@ -1349,7 +1350,8 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		if (sdata->vif.type != NL80211_IFTYPE_P2P_DEVICE &&
 		    sdata->vif.type != NL80211_IFTYPE_NAN)
 			changed |= ieee80211_reset_erp_info(sdata);
-		ieee80211_link_info_change_notify(sdata, 0, changed);
+		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+						  changed);
 
 		switch (sdata->vif.type) {
 		case NL80211_IFTYPE_STATION:
@@ -1533,7 +1535,8 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
 			break;
 		}
 		case WLAN_VHT_ACTION_GROUPID_MGMT:
-			ieee80211_process_mu_groups(sdata, 0, mgmt);
+			ieee80211_process_mu_groups(sdata, &sdata->deflink,
+						    mgmt);
 			break;
 		default:
 			WARN_ON(1);
@@ -1687,7 +1690,7 @@ static void ieee80211_recalc_smps_work(struct work_struct *work)
 	struct ieee80211_sub_if_data *sdata =
 		container_of(work, struct ieee80211_sub_if_data, recalc_smps);
 
-	ieee80211_recalc_smps(sdata, 0);
+	ieee80211_recalc_smps(sdata, &sdata->deflink);
 }
 
 /*
@@ -2362,6 +2365,7 @@ int ieee80211_vif_set_links(struct ieee80211_sub_if_data *sdata,
 	struct {
 		struct ieee80211_link_data data;
 		struct ieee80211_bss_conf conf;
+		struct rcu_head rcu_head;
 	} *links[IEEE80211_MLD_MAX_NUM_LINKS] = {}, *link;
 	struct ieee80211_bss_conf *old[IEEE80211_MLD_MAX_NUM_LINKS];
 	struct ieee80211_link_data *old_data[IEEE80211_MLD_MAX_NUM_LINKS];
@@ -2392,15 +2396,15 @@ int ieee80211_vif_set_links(struct ieee80211_sub_if_data *sdata,
 	/* link them into data structures */
 	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
 		WARN_ON(!use_deflink &&
-			sdata->link[link_id] == &sdata->deflink);
+			rcu_access_pointer(sdata->link[link_id]) == &sdata->deflink);
 
 		link = links[link_id];
 		ieee80211_link_init(sdata, link_id, &link->data, &link->conf);
 	}
 
 	for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
-		sdata->link[link_id] = NULL;
-		sdata->vif.link_conf[link_id] = NULL;
+		RCU_INIT_POINTER(sdata->link[link_id], NULL);
+		RCU_INIT_POINTER(sdata->vif.link_conf[link_id], NULL);
 	}
 
 	sdata->vif.valid_links = new_links;
@@ -2424,20 +2428,20 @@ int ieee80211_vif_set_links(struct ieee80211_sub_if_data *sdata,
 	/* now use this to free the old links */
 	memset(links, 0, sizeof(links));
 	for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
-		if (sdata->link[link_id] == &sdata->deflink)
+		if (rcu_access_pointer(sdata->link[link_id]) == &sdata->deflink)
 			continue;
 		/*
 		 * we must have allocated the data through this path so
 		 * we know we can free both at the same time
 		 */
-		links[link_id] = container_of(sdata->link[link_id],
+		links[link_id] = container_of(rcu_access_pointer(sdata->link[link_id]),
 					      typeof(*links[link_id]),
 					      data);
 	}
 
 free:
 	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++)
-		kfree(links[link_id]);
+		kfree_rcu(links[link_id], rcu_head);
 	if (use_deflink)
 		ieee80211_link_init(sdata, -1, &sdata->deflink,
 				    &sdata->vif.bss_conf);
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index c34f06039dda..191f4d35ef60 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -246,9 +246,11 @@ void ieee80211_bss_info_change_notify(struct ieee80211_sub_if_data *sdata,
 		u64 ch = changed & ~BSS_CHANGED_VIF_CFG_FLAGS;
 
 		/* FIXME: should be for each link */
-		trace_drv_link_info_changed(local, sdata, 0, changed);
+		trace_drv_link_info_changed(local, sdata, &sdata->vif.bss_conf,
+					    0, changed);
 		if (local->ops->link_info_changed)
 			local->ops->link_info_changed(&local->hw, &sdata->vif,
+						      &sdata->vif.bss_conf,
 						      0, ch);
 	}
 
@@ -272,7 +274,8 @@ void ieee80211_vif_cfg_change_notify(struct ieee80211_sub_if_data *sdata,
 }
 
 void ieee80211_link_info_change_notify(struct ieee80211_sub_if_data *sdata,
-				       int link_id, u64 changed)
+				       struct ieee80211_link_data *link,
+				       u64 changed)
 {
 	struct ieee80211_local *local = sdata->local;
 
@@ -284,7 +287,7 @@ void ieee80211_link_info_change_notify(struct ieee80211_sub_if_data *sdata,
 	if (!check_sdata_in_driver(sdata))
 		return;
 
-	drv_link_info_changed(local, sdata, link_id, changed);
+	drv_link_info_changed(local, sdata, link->conf, link->link_id, changed);
 }
 
 u32 ieee80211_reset_erp_info(struct ieee80211_sub_if_data *sdata)
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 6160211a7eee..ba4e0921fa5d 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1056,7 +1056,7 @@ int ieee80211_start_mesh(struct ieee80211_sub_if_data *sdata)
 	}
 
 	ieee80211_recalc_dtim(local, sdata);
-	ieee80211_link_info_change_notify(sdata, 0, changed);
+	ieee80211_link_info_change_notify(sdata, &sdata->deflink, changed);
 
 	netif_carrier_on(sdata->dev);
 	return 0;
@@ -1080,7 +1080,8 @@ void ieee80211_stop_mesh(struct ieee80211_sub_if_data *sdata)
 	sdata->vif.bss_conf.enable_beacon = false;
 	sdata->beacon_rate_set = false;
 	clear_bit(SDATA_STATE_OFFCHANNEL_BEACON_STOPPED, &sdata->state);
-	ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_BEACON_ENABLED);
+	ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+					  BSS_CHANGED_BEACON_ENABLED);
 
 	/* remove beacon */
 	bcn = sdata_dereference(ifmsh->beacon, sdata);
@@ -1578,7 +1579,7 @@ static void mesh_bss_info_changed(struct ieee80211_sub_if_data *sdata)
 		if (ieee80211_mesh_rebuild_beacon(sdata))
 			return;
 
-	ieee80211_link_info_change_notify(sdata, 0, changed);
+	ieee80211_link_info_change_notify(sdata, &sdata->deflink, changed);
 }
 
 void ieee80211_mesh_work(struct ieee80211_sub_if_data *sdata)
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 8980dfef1ff1..28bb7609cd4c 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1867,7 +1867,8 @@ void ieee80211_recalc_ps_vif(struct ieee80211_sub_if_data *sdata)
 
 	if (sdata->vif.bss_conf.ps != ps_allowed) {
 		sdata->vif.bss_conf.ps = ps_allowed;
-		ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_PS);
+		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+						  BSS_CHANGED_PS);
 	}
 }
 
@@ -2063,7 +2064,8 @@ __ieee80211_sta_handle_tspec_ac_params(struct ieee80211_sub_if_data *sdata)
 void ieee80211_sta_handle_tspec_ac_params(struct ieee80211_sub_if_data *sdata)
 {
 	if (__ieee80211_sta_handle_tspec_ac_params(sdata))
-		ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_QOS);
+		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+						  BSS_CHANGED_QOS);
 }
 
 static void ieee80211_sta_handle_tspec_ac_params_wk(struct work_struct *work)
@@ -2369,7 +2371,7 @@ static void ieee80211_set_associated(struct ieee80211_sub_if_data *sdata,
 	ieee80211_recalc_ps(local);
 	mutex_unlock(&local->iflist_mtx);
 
-	ieee80211_recalc_smps(sdata, 0);
+	ieee80211_recalc_smps(sdata, &sdata->deflink);
 	ieee80211_recalc_ps_vif(sdata);
 
 	netif_carrier_on(sdata->dev);
@@ -2952,7 +2954,8 @@ static void ieee80211_destroy_auth_data(struct ieee80211_sub_if_data *sdata,
 		sta_info_destroy_addr(sdata, auth_data->bss->bssid);
 
 		eth_zero_addr(sdata->deflink.u.mgd.bssid);
-		ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_BSSID);
+		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+						  BSS_CHANGED_BSSID);
 		sdata->u.mgd.flags = 0;
 		mutex_lock(&sdata->local->mtx);
 		ieee80211_link_release_channel(&sdata->deflink);
@@ -2981,7 +2984,8 @@ static void ieee80211_destroy_assoc_data(struct ieee80211_sub_if_data *sdata,
 		sta_info_destroy_addr(sdata, assoc_data->bss->bssid);
 
 		eth_zero_addr(sdata->deflink.u.mgd.bssid);
-		ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_BSSID);
+		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+						  BSS_CHANGED_BSSID);
 		sdata->u.mgd.flags = 0;
 		sdata->vif.bss_conf.mu_mimo_owner = false;
 
@@ -4423,7 +4427,8 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 					       elems->pwr_constr_elem,
 					       elems->cisco_dtpc_elem);
 
-	ieee80211_link_info_change_notify(sdata, 0, changed);
+	ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+					  changed);
 free:
 	kfree(elems);
 }
@@ -5733,9 +5738,10 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 		 * tell driver about BSSID, basic rates and timing
 		 * this was set up above, before setting the channel
 		 */
-		ieee80211_link_info_change_notify(sdata, 0,
-			BSS_CHANGED_BSSID | BSS_CHANGED_BASIC_RATES |
-			BSS_CHANGED_BEACON_INT);
+		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+						  BSS_CHANGED_BSSID |
+						  BSS_CHANGED_BASIC_RATES |
+						  BSS_CHANGED_BEACON_INT);
 
 		if (assoc)
 			sta_info_pre_move_state(new_sta, IEEE80211_STA_AUTH);
@@ -5901,7 +5907,8 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 
  err_clear:
 	eth_zero_addr(sdata->deflink.u.mgd.bssid);
-	ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_BSSID);
+	ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+					  BSS_CHANGED_BSSID);
 	ifmgd->auth_data = NULL;
 	mutex_lock(&sdata->local->mtx);
 	ieee80211_link_release_channel(&sdata->deflink);
@@ -6248,7 +6255,8 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	return 0;
  err_clear:
 	eth_zero_addr(sdata->deflink.u.mgd.bssid);
-	ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_BSSID);
+	ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+					  BSS_CHANGED_BSSID);
 	ifmgd->assoc_data = NULL;
  err_free:
 	kfree(assoc_data);
diff --git a/net/mac80211/ocb.c b/net/mac80211/ocb.c
index 0fd29d9c496c..2ca2164a3098 100644
--- a/net/mac80211/ocb.c
+++ b/net/mac80211/ocb.c
@@ -186,7 +186,7 @@ int ieee80211_ocb_join(struct ieee80211_sub_if_data *sdata,
 	sdata->deflink.needed_rx_chains = sdata->local->rx_chains;
 
 	mutex_lock(&sdata->local->mtx);
-	err = ieee80211_link_use_channel(sdata->link[0], &setup->chandef,
+	err = ieee80211_link_use_channel(&sdata->deflink, &setup->chandef,
 					 IEEE80211_CHANCTX_SHARED);
 	mutex_unlock(&sdata->local->mtx);
 	if (err)
@@ -229,7 +229,7 @@ int ieee80211_ocb_leave(struct ieee80211_sub_if_data *sdata)
 	ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_OCB);
 
 	mutex_lock(&sdata->local->mtx);
-	ieee80211_link_release_channel(sdata->link[0]);
+	ieee80211_link_release_channel(&sdata->deflink);
 	mutex_unlock(&sdata->local->mtx);
 
 	skb_queue_purge(&sdata->skb_queue);
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index aff5d3c39902..be79ae68754e 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -119,7 +119,8 @@ void ieee80211_offchannel_stop_vifs(struct ieee80211_local *local)
 				&sdata->state);
 			sdata->vif.bss_conf.enable_beacon = false;
 			ieee80211_link_info_change_notify(
-				sdata, 0, BSS_CHANGED_BEACON_ENABLED);
+				sdata, &sdata->deflink,
+				BSS_CHANGED_BEACON_ENABLED);
 		}
 
 		if (sdata->vif.type == NL80211_IFTYPE_STATION &&
@@ -156,7 +157,8 @@ void ieee80211_offchannel_return(struct ieee80211_local *local)
 				       &sdata->state)) {
 			sdata->vif.bss_conf.enable_beacon = true;
 			ieee80211_link_info_change_notify(
-				sdata, 0, BSS_CHANGED_BEACON_ENABLED);
+				sdata, &sdata->deflink,
+				BSS_CHANGED_BEACON_ENABLED);
 		}
 	}
 	mutex_unlock(&local->iflist_mtx);
@@ -848,14 +850,17 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 		rcu_read_lock();
 		/* Check all the links first */
 		for (i = 0; i < ARRAY_SIZE(sdata->vif.link_conf); i++) {
-			if (!sdata->vif.link_conf[i])
+			struct ieee80211_bss_conf *conf;
+
+			conf = rcu_dereference(sdata->vif.link_conf[i]);
+			if (!conf)
 				continue;
 
-			chanctx_conf = rcu_dereference(sdata->vif.link_conf[i]->chanctx_conf);
+			chanctx_conf = rcu_dereference(conf->chanctx_conf);
 			if (!chanctx_conf)
 				continue;
 
-			if (ether_addr_equal(sdata->vif.link_conf[i]->addr, mgmt->sa))
+			if (ether_addr_equal(conf->addr, mgmt->sa))
 				break;
 
 			chanctx_conf = NULL;
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 2aa593294a29..9f7ce1377604 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4155,9 +4155,13 @@ static bool ieee80211_is_our_addr(struct ieee80211_sub_if_data *sdata,
 		return false;
 
 	for (link_id = 0; link_id < ARRAY_SIZE(sdata->vif.link_conf); link_id++) {
-		if (!sdata->vif.link_conf[link_id])
+		struct ieee80211_bss_conf *conf;
+
+		conf = rcu_dereference(sdata->vif.link_conf[link_id]);
+
+		if (!conf)
 			continue;
-		if (ether_addr_equal(sdata->vif.link_conf[link_id]->addr, addr)) {
+		if (ether_addr_equal(conf->addr, addr)) {
 			if (out_link_id)
 				*out_link_id = link_id;
 			return true;
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index a4fa0ce7bd92..20aad688c9c9 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -731,7 +731,8 @@ ieee80211_recalc_p2p_go_ps_allowed(struct ieee80211_sub_if_data *sdata)
 
 	if (allow_p2p_go_ps != sdata->vif.bss_conf.allow_p2p_go_ps) {
 		sdata->vif.bss_conf.allow_p2p_go_ps = allow_p2p_go_ps;
-		ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_P2P_PS);
+		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+						  BSS_CHANGED_P2P_PS);
 	}
 }
 
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index c531fa17f426..71883ffd7061 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -1336,7 +1336,8 @@ iee80211_tdls_recalc_ht_protection(struct ieee80211_sub_if_data *sdata,
 		return;
 
 	sdata->vif.bss_conf.ht_operation_mode = opmode;
-	ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_HT);
+	ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+					  BSS_CHANGED_HT);
 }
 
 int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index f96e7cdca4c2..6aa06fba5b50 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -446,9 +446,10 @@ TRACE_EVENT(drv_vif_cfg_changed,
 TRACE_EVENT(drv_link_info_changed,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
+		 struct ieee80211_bss_conf *link_conf,
 		 int link_id, u64 changed),
 
-	TP_ARGS(local, sdata, link_id, changed),
+	TP_ARGS(local, sdata, link_conf, link_id, changed),
 
 	TP_STRUCT__entry(
 		LOCAL_ENTRY
@@ -481,8 +482,6 @@ TRACE_EVENT(drv_link_info_changed,
 	),
 
 	TP_fast_assign(
-		struct ieee80211_bss_conf *link_conf = sdata->vif.link_conf[link_id];
-
 		LOCAL_ASSIGN;
 		VIF_ASSIGN;
 		__entry->changed = changed;
@@ -1752,10 +1751,9 @@ DEFINE_EVENT(local_sdata_chanctx, drv_unassign_vif_chanctx,
 TRACE_EVENT(drv_start_ap,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
-		 struct ieee80211_bss_conf *info,
 		 unsigned int link_id),
 
-	TP_ARGS(local, sdata, info, link_id),
+	TP_ARGS(local, sdata, link_id),
 
 	TP_STRUCT__entry(
 		LOCAL_ENTRY
@@ -1768,15 +1766,20 @@ TRACE_EVENT(drv_start_ap,
 	),
 
 	TP_fast_assign(
+		struct ieee80211_bss_conf *info =
+			sdata_dereference(sdata->vif.link_conf[link_id], sdata);
+
 		LOCAL_ASSIGN;
 		VIF_ASSIGN;
 		__entry->link_id = link_id;
-		__entry->dtimper = info->dtim_period;
-		__entry->bcnint = info->beacon_int;
+		if (info) {
+			__entry->dtimper = info->dtim_period;
+			__entry->bcnint = info->beacon_int;
+			__entry->hidden_ssid = info->hidden_ssid;
+		}
 		memcpy(__get_dynamic_array(ssid),
 		       sdata->vif.cfg.ssid,
 		       sdata->vif.cfg.ssid_len);
-		__entry->hidden_ssid = info->hidden_ssid;
 	),
 
 	TP_printk(
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index b2430cf8332b..a077399ed065 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4608,13 +4608,14 @@ void ieee80211_tx_pending(struct tasklet_struct *t)
 /* functions for drivers to get certain frames */
 
 static void __ieee80211_beacon_add_tim(struct ieee80211_sub_if_data *sdata,
+				       struct ieee80211_link_data *link,
 				       struct ps_data *ps, struct sk_buff *skb,
-				       bool is_template, unsigned int link_id)
+				       bool is_template)
 {
 	u8 *pos, *tim;
 	int aid0 = 0;
 	int i, have_bits = 0, n1, n2;
-	struct ieee80211_bss_conf *link_conf = sdata->vif.link_conf[link_id];
+	struct ieee80211_bss_conf *link_conf = link->conf;
 
 	/* Generate bitmap for TIM only if there are any STAs in power save
 	 * mode. */
@@ -4674,8 +4675,9 @@ static void __ieee80211_beacon_add_tim(struct ieee80211_sub_if_data *sdata,
 }
 
 static int ieee80211_beacon_add_tim(struct ieee80211_sub_if_data *sdata,
+				    struct ieee80211_link_data *link,
 				    struct ps_data *ps, struct sk_buff *skb,
-				    bool is_template, unsigned int link_id)
+				    bool is_template)
 {
 	struct ieee80211_local *local = sdata->local;
 
@@ -4687,12 +4689,10 @@ static int ieee80211_beacon_add_tim(struct ieee80211_sub_if_data *sdata,
 	 * of the tim bitmap in mac80211 and the driver.
 	 */
 	if (local->tim_in_locked_section) {
-		__ieee80211_beacon_add_tim(sdata, ps, skb, is_template,
-					   link_id);
+		__ieee80211_beacon_add_tim(sdata, link, ps, skb, is_template);
 	} else {
 		spin_lock_bh(&local->tim_lock);
-		__ieee80211_beacon_add_tim(sdata, ps, skb, is_template,
-					   link_id);
+		__ieee80211_beacon_add_tim(sdata, link, ps, skb, is_template);
 		spin_unlock_bh(&local->tim_lock);
 	}
 
@@ -4701,7 +4701,7 @@ static int ieee80211_beacon_add_tim(struct ieee80211_sub_if_data *sdata,
 
 static void ieee80211_set_beacon_cntdwn(struct ieee80211_sub_if_data *sdata,
 					struct beacon_data *beacon,
-					unsigned int link_id)
+					struct ieee80211_link_data *link)
 {
 	u8 *beacon_data, count, max_count = 1;
 	struct probe_resp *resp;
@@ -4726,20 +4726,17 @@ static void ieee80211_set_beacon_cntdwn(struct ieee80211_sub_if_data *sdata,
 		return;
 	}
 
-	rcu_read_lock();
-	resp = rcu_dereference(sdata->link[link_id]->u.ap.probe_resp);
+	resp = rcu_dereference(link->u.ap.probe_resp);
 
 	bcn_offsets = beacon->cntdwn_counter_offsets;
 	count = beacon->cntdwn_current_counter;
-	if (sdata->vif.link_conf[link_id]->csa_active)
+	if (link->conf->csa_active)
 		max_count = IEEE80211_MAX_CNTDWN_COUNTERS_NUM;
 
 	for (i = 0; i < max_count; ++i) {
 		if (bcn_offsets[i]) {
-			if (WARN_ON_ONCE(bcn_offsets[i] >= beacon_data_len)) {
-				rcu_read_unlock();
+			if (WARN_ON_ONCE(bcn_offsets[i] >= beacon_data_len))
 				return;
-			}
 			beacon_data[bcn_offsets[i]] = count;
 		}
 
@@ -4749,7 +4746,6 @@ static void ieee80211_set_beacon_cntdwn(struct ieee80211_sub_if_data *sdata,
 			resp->data[resp_offsets[i]] = count;
 		}
 	}
-	rcu_read_unlock();
 }
 
 static u8 __ieee80211_beacon_update_cntdwn(struct beacon_data *beacon)
@@ -4873,14 +4869,14 @@ EXPORT_SYMBOL(ieee80211_beacon_cntdwn_is_complete);
 static int ieee80211_beacon_protect(struct sk_buff *skb,
 				    struct ieee80211_local *local,
 				    struct ieee80211_sub_if_data *sdata,
-				    unsigned int link_id)
+				    struct ieee80211_link_data *link)
 {
 	ieee80211_tx_result res;
 	struct ieee80211_tx_data tx;
 	struct sk_buff *check_skb;
 
 	memset(&tx, 0, sizeof(tx));
-	tx.key = rcu_dereference(sdata->link[link_id]->default_beacon_key);
+	tx.key = rcu_dereference(link->default_beacon_key);
 	if (!tx.key)
 		return 0;
 	tx.local = local;
@@ -4900,12 +4896,12 @@ static int ieee80211_beacon_protect(struct sk_buff *skb,
 static void
 ieee80211_beacon_get_finish(struct ieee80211_hw *hw,
 			    struct ieee80211_vif *vif,
+			    struct ieee80211_link_data *link,
 			    struct ieee80211_mutable_offsets *offs,
 			    struct beacon_data *beacon,
 			    struct sk_buff *skb,
 			    struct ieee80211_chanctx_conf *chanctx_conf,
-			    u16 csa_off_base,
-			    unsigned int link_id)
+			    u16 csa_off_base)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
@@ -4936,7 +4932,7 @@ ieee80211_beacon_get_finish(struct ieee80211_hw *hw,
 	memset(&txrc, 0, sizeof(txrc));
 	txrc.hw = hw;
 	txrc.sband = local->hw.wiphy->bands[band];
-	txrc.bss_conf = sdata->vif.link_conf[link_id];
+	txrc.bss_conf = link->conf;
 	txrc.skb = skb;
 	txrc.reported_rate.idx = -1;
 	if (sdata->beacon_rate_set && sdata->beacon_rateidx_mask[band])
@@ -4968,11 +4964,11 @@ ieee80211_beacon_add_mbssid(struct sk_buff *skb, struct beacon_data *beacon)
 static struct sk_buff *
 ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 			struct ieee80211_vif *vif,
+			struct ieee80211_link_data *link,
 			struct ieee80211_mutable_offsets *offs,
 			bool is_template,
 			struct beacon_data *beacon,
-			struct ieee80211_chanctx_conf *chanctx_conf,
-			unsigned int link_id)
+			struct ieee80211_chanctx_conf *chanctx_conf)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
@@ -4985,7 +4981,7 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 		if (!is_template)
 			ieee80211_beacon_update_cntdwn(vif);
 
-		ieee80211_set_beacon_cntdwn(sdata, beacon, link_id);
+		ieee80211_set_beacon_cntdwn(sdata, beacon, link);
 	}
 
 	/* headroom, head length,
@@ -5001,7 +4997,7 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 	skb_reserve(skb, local->tx_headroom);
 	skb_put_data(skb, beacon->head, beacon->head_len);
 
-	ieee80211_beacon_add_tim(sdata, &ap->ps, skb, is_template, link_id);
+	ieee80211_beacon_add_tim(sdata, link, &ap->ps, skb, is_template);
 
 	if (offs) {
 		offs->tim_offset = beacon->head_len;
@@ -5020,11 +5016,11 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 	if (beacon->tail)
 		skb_put_data(skb, beacon->tail, beacon->tail_len);
 
-	if (ieee80211_beacon_protect(skb, local, sdata, link_id) < 0)
+	if (ieee80211_beacon_protect(skb, local, sdata, link) < 0)
 		return NULL;
 
-	ieee80211_beacon_get_finish(hw, vif, offs, beacon, skb, chanctx_conf,
-				    csa_off_base, link_id);
+	ieee80211_beacon_get_finish(hw, vif, link, offs, beacon, skb,
+				    chanctx_conf, csa_off_base);
 	return skb;
 }
 
@@ -5040,12 +5036,16 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 	struct sk_buff *skb = NULL;
 	struct ieee80211_sub_if_data *sdata = NULL;
 	struct ieee80211_chanctx_conf *chanctx_conf;
+	struct ieee80211_link_data *link;
 
 	rcu_read_lock();
 
 	sdata = vif_to_sdata(vif);
+	link = rcu_dereference(sdata->link[link_id]);
+	if (!link)
+		goto out;
 	chanctx_conf =
-		rcu_dereference(sdata->vif.link_conf[link_id]->chanctx_conf);
+		rcu_dereference(link->conf->chanctx_conf);
 
 	if (!ieee80211_sdata_running(sdata) || !chanctx_conf)
 		goto out;
@@ -5054,12 +5054,12 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 		memset(offs, 0, sizeof(*offs));
 
 	if (sdata->vif.type == NL80211_IFTYPE_AP) {
-		beacon = rcu_dereference(sdata->link[link_id]->u.ap.beacon);
+		beacon = rcu_dereference(link->u.ap.beacon);
 		if (!beacon)
 			goto out;
 
-		skb = ieee80211_beacon_get_ap(hw, vif, offs, is_template,
-					      beacon, chanctx_conf, link_id);
+		skb = ieee80211_beacon_get_ap(hw, vif, link, offs, is_template,
+					      beacon, chanctx_conf);
 	} else if (sdata->vif.type == NL80211_IFTYPE_ADHOC) {
 		struct ieee80211_if_ibss *ifibss = &sdata->u.ibss;
 		struct ieee80211_hdr *hdr;
@@ -5072,7 +5072,7 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 			if (!is_template)
 				__ieee80211_beacon_update_cntdwn(beacon);
 
-			ieee80211_set_beacon_cntdwn(sdata, beacon, link_id);
+			ieee80211_set_beacon_cntdwn(sdata, beacon, link);
 		}
 
 		skb = dev_alloc_skb(local->tx_headroom + beacon->head_len +
@@ -5086,8 +5086,8 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 		hdr->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
 						 IEEE80211_STYPE_BEACON);
 
-		ieee80211_beacon_get_finish(hw, vif, offs, beacon, skb,
-					    chanctx_conf, 0, link_id);
+		ieee80211_beacon_get_finish(hw, vif, link, offs, beacon, skb,
+					    chanctx_conf, 0);
 	} else if (ieee80211_vif_is_mesh(&sdata->vif)) {
 		struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
 
@@ -5104,7 +5104,7 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 				 */
 				__ieee80211_beacon_update_cntdwn(beacon);
 
-			ieee80211_set_beacon_cntdwn(sdata, beacon, link_id);
+			ieee80211_set_beacon_cntdwn(sdata, beacon, link);
 		}
 
 		if (ifmsh->sync_ops)
@@ -5119,8 +5119,8 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 			goto out;
 		skb_reserve(skb, local->tx_headroom);
 		skb_put_data(skb, beacon->head, beacon->head_len);
-		ieee80211_beacon_add_tim(sdata, &ifmsh->ps, skb, is_template,
-					 link_id);
+		ieee80211_beacon_add_tim(sdata, link, &ifmsh->ps, skb,
+					 is_template);
 
 		if (offs) {
 			offs->tim_offset = beacon->head_len;
@@ -5128,8 +5128,8 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 		}
 
 		skb_put_data(skb, beacon->tail, beacon->tail_len);
-		ieee80211_beacon_get_finish(hw, vif, offs, beacon, skb,
-					    chanctx_conf, 0, link_id);
+		ieee80211_beacon_get_finish(hw, vif, link, offs, beacon, skb,
+					    chanctx_conf, 0);
 	} else {
 		WARN_ON(1);
 		goto out;
@@ -5626,11 +5626,17 @@ void __ieee80211_tx_skb_tid_band(struct ieee80211_sub_if_data *sdata,
 		link = IEEE80211_LINK_UNSPECIFIED;
 	} else {
 		/* otherwise must be addressed from a link */
+		rcu_read_lock();
 		for (link = 0; link < ARRAY_SIZE(sdata->vif.link_conf); link++) {
-			if (memcmp(sdata->vif.link_conf[link]->addr,
-				   hdr->addr2, ETH_ALEN) == 0)
+			struct ieee80211_bss_conf *link_conf;
+
+			link_conf = rcu_dereference(sdata->vif.link_conf[link]);
+			if (!link_conf)
+				continue;
+			if (memcmp(link_conf->addr, hdr->addr2, ETH_ALEN) == 0)
 				break;
 		}
+		rcu_read_unlock();
 
 		if (WARN_ON_ONCE(link == ARRAY_SIZE(sdata->vif.link_conf)))
 			link = ffs(sdata->vif.valid_links) - 1;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 7b39e464fb1e..24b5e5d10d66 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1699,7 +1699,8 @@ void ieee80211_set_wmm_default(struct ieee80211_sub_if_data *sdata,
 	    sdata->vif.type != NL80211_IFTYPE_NAN) {
 		sdata->vif.bss_conf.qos = enable_qos;
 		if (bss_notify)
-			ieee80211_link_info_change_notify(sdata, 0,
+			ieee80211_link_info_change_notify(sdata,
+							  &sdata->deflink,
 							  BSS_CHANGED_QOS);
 	}
 }
@@ -2256,7 +2257,7 @@ static void ieee80211_handle_reconfig_failure(struct ieee80211_local *local)
 
 static void ieee80211_assign_chanctx(struct ieee80211_local *local,
 				     struct ieee80211_sub_if_data *sdata,
-				     unsigned int link_id)
+				     struct ieee80211_link_data *link)
 {
 	struct ieee80211_chanctx_conf *conf;
 	struct ieee80211_chanctx *ctx;
@@ -2265,11 +2266,11 @@ static void ieee80211_assign_chanctx(struct ieee80211_local *local,
 		return;
 
 	mutex_lock(&local->chanctx_mtx);
-	conf = rcu_dereference_protected(sdata->vif.link_conf[link_id]->chanctx_conf,
+	conf = rcu_dereference_protected(link->conf->chanctx_conf,
 					 lockdep_is_held(&local->chanctx_mtx));
 	if (conf) {
 		ctx = container_of(conf, struct ieee80211_chanctx, conf);
-		drv_assign_vif_chanctx(local, sdata, link_id, ctx);
+		drv_assign_vif_chanctx(local, sdata, link->link_id, ctx);
 	}
 	mutex_unlock(&local->chanctx_mtx);
 }
@@ -2475,7 +2476,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		sdata = wiphy_dereference(local->hw.wiphy,
 					  local->monitor_sdata);
 		if (sdata && ieee80211_sdata_running(sdata))
-			ieee80211_assign_chanctx(local, sdata, 0);
+			ieee80211_assign_chanctx(local, sdata, &sdata->deflink);
 	}
 
 	/* reconfigure hardware */
@@ -2485,16 +2486,23 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 
 	/* Finally also reconfigure all the BSS information */
 	list_for_each_entry(sdata, &local->interfaces, list) {
-		unsigned int link;
+		unsigned int link_id;
 		u32 changed;
 
 		if (!ieee80211_sdata_running(sdata))
 			continue;
 
-		for (link = 0; link < ARRAY_SIZE(sdata->vif.link_conf); link++) {
-			if (sdata->vif.link_conf[link])
+		sdata_lock(sdata);
+		for (link_id = 0;
+		     link_id < ARRAY_SIZE(sdata->vif.link_conf);
+		     link_id++) {
+			struct ieee80211_link_data *link;
+
+			link = sdata_dereference(sdata->link[link_id], sdata);
+			if (link)
 				ieee80211_assign_chanctx(local, sdata, link);
 		}
+		sdata_unlock(sdata);
 
 		switch (sdata->vif.type) {
 		case NL80211_IFTYPE_AP_VLAN:
@@ -2804,7 +2812,7 @@ void ieee80211_resume_disconnect(struct ieee80211_vif *vif)
 EXPORT_SYMBOL_GPL(ieee80211_resume_disconnect);
 
 void ieee80211_recalc_smps(struct ieee80211_sub_if_data *sdata,
-			   unsigned int link_id)
+			   struct ieee80211_link_data *link)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx_conf *chanctx_conf;
@@ -2812,7 +2820,7 @@ void ieee80211_recalc_smps(struct ieee80211_sub_if_data *sdata,
 
 	mutex_lock(&local->chanctx_mtx);
 
-	chanctx_conf = rcu_dereference_protected(sdata->vif.link_conf[link_id]->chanctx_conf,
+	chanctx_conf = rcu_dereference_protected(link->conf->chanctx_conf,
 						 lockdep_is_held(&local->chanctx_mtx));
 
 	/*
@@ -4006,7 +4014,7 @@ void ieee80211_dfs_cac_cancel(struct ieee80211_local *local)
 
 		if (sdata->wdev.cac_started) {
 			chandef = sdata->vif.bss_conf.chandef;
-			ieee80211_link_release_channel(sdata->link[0]);
+			ieee80211_link_release_channel(&sdata->deflink);
 			cfg80211_cac_event(sdata->dev,
 					   &chandef,
 					   NL80211_RADAR_CAC_ABORTED,
@@ -4452,13 +4460,11 @@ static u8 ieee80211_chanctx_radar_detect(struct ieee80211_local *local,
 		!list_empty(&ctx->assigned_links));
 
 	list_for_each_entry(link, &ctx->assigned_links, assigned_chanctx_list) {
-		struct ieee80211_sub_if_data *sdata = link->sdata;
-
 		if (!link->radar_required)
 			continue;
 
 		radar_detect |=
-			BIT(sdata->vif.link_conf[link->link_id]->chandef.width);
+			BIT(link->conf->chandef.width);
 	}
 
 	return radar_detect;
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index fa14627b499a..c804890dc623 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -341,39 +341,50 @@ ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta)
 {
 	unsigned int link_id = link_sta->link_id;
 	struct ieee80211_sub_if_data *sdata = link_sta->sta->sdata;
-	struct ieee80211_bss_conf *link_conf = sdata->vif.link_conf[link_id];
 	struct ieee80211_sta_vht_cap *vht_cap = &link_sta->pub->vht_cap;
 	struct ieee80211_sta_he_cap *he_cap = &link_sta->pub->he_cap;
 	struct ieee80211_sta_eht_cap *eht_cap = &link_sta->pub->eht_cap;
 	u32 cap_width;
 
 	if (he_cap->has_he) {
+		struct ieee80211_bss_conf *link_conf;
+		enum ieee80211_sta_rx_bandwidth ret;
 		u8 info;
 
+		rcu_read_lock();
+		link_conf = rcu_dereference(sdata->vif.link_conf[link_id]);
+
 		if (eht_cap->has_eht &&
 		    link_conf->chandef.chan->band == NL80211_BAND_6GHZ) {
 			info = eht_cap->eht_cap_elem.phy_cap_info[0];
 
-			if (info & IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ)
-				return IEEE80211_STA_RX_BW_320;
+			if (info & IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ) {
+				ret = IEEE80211_STA_RX_BW_320;
+				goto out;
+			}
 		}
 
 		info = he_cap->he_cap_elem.phy_cap_info[0];
 
 		if (link_conf->chandef.chan->band == NL80211_BAND_2GHZ) {
 			if (info & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G)
-				return IEEE80211_STA_RX_BW_40;
+				ret = IEEE80211_STA_RX_BW_40;
 			else
-				return IEEE80211_STA_RX_BW_20;
+				ret = IEEE80211_STA_RX_BW_20;
+			goto out;
 		}
 
 		if (info & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G ||
 		    info & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
-			return IEEE80211_STA_RX_BW_160;
+			ret = IEEE80211_STA_RX_BW_160;
 		else if (info & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G)
-			return IEEE80211_STA_RX_BW_80;
+			ret = IEEE80211_STA_RX_BW_80;
+		else
+			ret = IEEE80211_STA_RX_BW_20;
+out:
+		rcu_read_unlock();
 
-		return IEEE80211_STA_RX_BW_20;
+		return ret;
 	}
 
 	if (!vht_cap->vht_supported)
@@ -481,11 +492,18 @@ enum ieee80211_sta_rx_bandwidth
 ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta)
 {
 	struct sta_info *sta = link_sta->sta;
-	struct ieee80211_bss_conf *link_conf =
-		sta->sdata->vif.link_conf[link_sta->link_id];
-	enum nl80211_chan_width bss_width = link_conf->chandef.width;
+	struct ieee80211_bss_conf *link_conf;
+	enum nl80211_chan_width bss_width;
 	enum ieee80211_sta_rx_bandwidth bw;
 
+	rcu_read_lock();
+	link_conf = rcu_dereference(sta->sdata->vif.link_conf[link_sta->link_id]);
+	if (WARN_ON(!link_conf))
+		bss_width = NL80211_CHAN_WIDTH_20_NOHT;
+	else
+		bss_width = link_conf->chandef.width;
+	rcu_read_unlock();
+
 	bw = ieee80211_sta_cap_rx_bw(link_sta);
 	bw = min(bw, link_sta->cur_max_bandwidth);
 
@@ -659,10 +677,10 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 }
 
 void ieee80211_process_mu_groups(struct ieee80211_sub_if_data *sdata,
-				 unsigned int link_id,
+				 struct ieee80211_link_data *link,
 				 struct ieee80211_mgmt *mgmt)
 {
-	struct ieee80211_bss_conf *link_conf = sdata->vif.link_conf[link_id];
+	struct ieee80211_bss_conf *link_conf = link->conf;
 
 	if (!link_conf->mu_mimo_owner)
 		return;
@@ -680,19 +698,25 @@ void ieee80211_process_mu_groups(struct ieee80211_sub_if_data *sdata,
 	       mgmt->u.action.u.vht_group_notif.position,
 	       WLAN_USER_POSITION_LEN);
 
-	ieee80211_link_info_change_notify(sdata, link_id, BSS_CHANGED_MU_GROUPS);
+	ieee80211_link_info_change_notify(sdata, link,
+					  BSS_CHANGED_MU_GROUPS);
 }
 
 void ieee80211_update_mu_groups(struct ieee80211_vif *vif, unsigned int link_id,
 				const u8 *membership, const u8 *position)
 {
-	struct ieee80211_bss_conf *link_conf = vif->link_conf[link_id];
+	struct ieee80211_bss_conf *link_conf;
 
-	if (WARN_ON_ONCE(!link_conf->mu_mimo_owner))
-		return;
+	rcu_read_lock();
+	link_conf = rcu_dereference(vif->link_conf[link_id]);
 
-	memcpy(link_conf->mu_group.membership, membership, WLAN_MEMBERSHIP_LEN);
-	memcpy(link_conf->mu_group.position, position, WLAN_USER_POSITION_LEN);
+	if (!WARN_ON_ONCE(!link_conf || !link_conf->mu_mimo_owner)) {
+		memcpy(link_conf->mu_group.membership, membership,
+		       WLAN_MEMBERSHIP_LEN);
+		memcpy(link_conf->mu_group.position, position,
+		       WLAN_USER_POSITION_LEN);
+	}
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(ieee80211_update_mu_groups);
 
-- 
2.36.1

