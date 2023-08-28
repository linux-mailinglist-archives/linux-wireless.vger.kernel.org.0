Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BC078AFA6
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjH1MG2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbjH1MF4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:56 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F91126
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ctWzxvxE6vl+NWiA237yLTwpTxvhaFmRvr+XBAmfiZk=;
        t=1693224350; x=1694433950; b=Z1CoXrcE82r+fIcyCwizZ+ES67gVSQ+EykbCpA5m2gzQ6BG
        y5hOn/BxZxOcRd51BznTuAFjT3CuAMV1YBLV8A/mZKt+mMpWKGyYLu5jEVQag+JhSnKAVjO5z0Rz3
        ztLHNw/DXtuYhXR2iNb+DpSs6eurlfUQbSbBS85oieRsRmroju1BkcdygSYzHIEy8yW9EQ194CLMx
        BKB8wUGY+sgvdWY7JS8lTOKNNKoGny/4HDQXujgYia93oORXCNdH4zIuPdPXXw2utY4TpLO6t6DNv
        FqrfNMFim0socFYHVFKbl0ahMJ4TAgxRg7KFrdwpBxwQ4AFV94Ga6+xEETi2i29Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qab08-00Gjgt-2X;
        Mon, 28 Aug 2023 14:05:49 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 37/40] wifi: mac80211: remove local->mtx
Date:   Mon, 28 Aug 2023 14:00:05 +0200
Message-ID: <20230828135928.b1c6efffe9ad.I4aec875e25abc9ef0b5ad1e70b5747fd483fbd3c@changeid>
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
needed the local->mtx, so we don't need this mutex any
more. Remove it.

Most of this change was done automatically with spatch.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c         |  72 +++++++++----------------
 net/mac80211/chan.c        |  23 ++------
 net/mac80211/ibss.c        |  10 ++--
 net/mac80211/ieee80211_i.h |   3 --
 net/mac80211/iface.c       |  32 +++--------
 net/mac80211/link.c        |   2 -
 net/mac80211/main.c        |   3 --
 net/mac80211/mlme.c        |  65 ++++++++--------------
 net/mac80211/ocb.c         |   8 +--
 net/mac80211/offchannel.c  |  48 +++++++----------
 net/mac80211/scan.c        | 107 ++++++++++++++-----------------------
 net/mac80211/tdls.c        |  12 ++---
 net/mac80211/tx.c          |   8 ++-
 net/mac80211/util.c        |  11 ++--
 14 files changed, 135 insertions(+), 269 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index a90a6f8475de..9e5c75c03dde 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -887,6 +887,8 @@ static int ieee80211_set_monitor_channel(struct wiphy *wiphy,
 	struct ieee80211_sub_if_data *sdata;
 	int ret = 0;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	if (cfg80211_chandef_identical(&local->monitor_chandef, chandef))
 		return 0;
 
@@ -895,21 +897,17 @@ static int ieee80211_set_monitor_channel(struct wiphy *wiphy,
 					  local->monitor_sdata);
 		if (sdata) {
 			sdata_lock(sdata);
-			mutex_lock(&local->mtx);
 			ieee80211_link_release_channel(&sdata->deflink);
 			ret = ieee80211_link_use_channel(&sdata->deflink,
 							 chandef,
 							 IEEE80211_CHANCTX_EXCLUSIVE);
-			mutex_unlock(&local->mtx);
 			sdata_unlock(sdata);
 		}
 	} else {
-		mutex_lock(&local->mtx);
 		if (local->open_count == local->monitors) {
 			local->_oper_chandef = *chandef;
 			ieee80211_hw_config(local, 0);
 		}
-		mutex_unlock(&local->mtx);
 	}
 
 	if (ret == 0)
@@ -1252,6 +1250,8 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	struct ieee80211_link_data *link;
 	struct ieee80211_bss_conf *link_conf;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	link = sdata_dereference(sdata->link[link_id], sdata);
 	if (!link)
 		return -ENOLINK;
@@ -1361,12 +1361,10 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 			return err;
 	}
 
-	mutex_lock(&local->mtx);
 	err = ieee80211_link_use_channel(link, &params->chandef,
 					 IEEE80211_CHANCTX_SHARED);
 	if (!err)
 		ieee80211_link_copy_chanctx_to_vlans(link, false);
-	mutex_unlock(&local->mtx);
 	if (err) {
 		link_conf->beacon_int = prev_beacon_int;
 		return err;
@@ -1477,9 +1475,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	return 0;
 
 error:
-	mutex_lock(&local->mtx);
 	ieee80211_link_release_channel(link);
-	mutex_unlock(&local->mtx);
 
 	return err;
 }
@@ -1554,6 +1550,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	struct ieee80211_bss_conf *link_conf = link->conf;
 
 	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	old_beacon = sdata_dereference(link->u.ap.beacon, sdata);
 	if (!old_beacon)
@@ -1567,7 +1564,6 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 				  sdata);
 
 	/* abort any running channel switch or color change */
-	mutex_lock(&local->mtx);
 	link_conf->csa_active = false;
 	link_conf->color_change_active = false;
 	if (link->csa_block_tx) {
@@ -1576,8 +1572,6 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 		link->csa_block_tx = false;
 	}
 
-	mutex_unlock(&local->mtx);
-
 	ieee80211_free_next_beacon(link);
 
 	/* turn off carrier for this interface and dependent VLANs */
@@ -1632,10 +1626,8 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	local->total_ps_buffered -= skb_queue_len(&sdata->u.ap.ps.bc_buf);
 	ieee80211_purge_tx_queue(&local->hw, &sdata->u.ap.ps.bc_buf);
 
-	mutex_lock(&local->mtx);
 	ieee80211_link_copy_chanctx_to_vlans(link, true);
 	ieee80211_link_release_channel(link);
-	mutex_unlock(&local->mtx);
 
 	return 0;
 }
@@ -2601,6 +2593,8 @@ static int ieee80211_join_mesh(struct wiphy *wiphy, struct net_device *dev,
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
 	int err;
 
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
 	memcpy(&ifmsh->mshcfg, conf, sizeof(struct mesh_config));
 	err = copy_mesh_setup(ifmsh, setup);
 	if (err)
@@ -2612,10 +2606,8 @@ static int ieee80211_join_mesh(struct wiphy *wiphy, struct net_device *dev,
 	sdata->deflink.smps_mode = IEEE80211_SMPS_OFF;
 	sdata->deflink.needed_rx_chains = sdata->local->rx_chains;
 
-	mutex_lock(&sdata->local->mtx);
 	err = ieee80211_link_use_channel(&sdata->deflink, &setup->chandef,
 					 IEEE80211_CHANCTX_SHARED);
-	mutex_unlock(&sdata->local->mtx);
 	if (err)
 		return err;
 
@@ -2626,11 +2618,11 @@ static int ieee80211_leave_mesh(struct wiphy *wiphy, struct net_device *dev)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
 	ieee80211_stop_mesh(sdata);
-	mutex_lock(&sdata->local->mtx);
 	ieee80211_link_release_channel(&sdata->deflink);
 	kfree(sdata->u.mesh.ie);
-	mutex_unlock(&sdata->local->mtx);
 
 	return 0;
 }
@@ -3373,7 +3365,8 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 	struct ieee80211_local *local = sdata->local;
 	int err;
 
-	mutex_lock(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	if (!list_empty(&local->roc_list) || local->scanning) {
 		err = -EBUSY;
 		goto out_unlock;
@@ -3392,7 +3385,6 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 				 msecs_to_jiffies(cac_time_ms));
 
  out_unlock:
-	mutex_unlock(&local->mtx);
 	return err;
 }
 
@@ -3402,7 +3394,8 @@ static void ieee80211_end_cac(struct wiphy *wiphy,
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
 
-	mutex_lock(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	list_for_each_entry(sdata, &local->interfaces, list) {
 		/* it might be waiting for the local->mtx, but then
 		 * by the time it gets it, sdata->wdev.cac_started
@@ -3416,7 +3409,6 @@ static void ieee80211_end_cac(struct wiphy *wiphy,
 			sdata->wdev.cac_started = false;
 		}
 	}
-	mutex_unlock(&local->mtx);
 }
 
 static struct cfg80211_beacon_data *
@@ -3615,7 +3607,6 @@ static int __ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
 	int err;
 
 	sdata_assert_lock(sdata);
-	lockdep_assert_held(&local->mtx);
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	/*
@@ -3688,7 +3679,6 @@ void ieee80211_csa_finalize_work(struct wiphy *wiphy, struct wiphy_work *work)
 	struct ieee80211_local *local = sdata->local;
 
 	sdata_lock(sdata);
-	mutex_lock(&local->mtx);
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	/* AP might have been stopped while waiting for the lock. */
@@ -3701,7 +3691,6 @@ void ieee80211_csa_finalize_work(struct wiphy *wiphy, struct wiphy_work *work)
 	ieee80211_csa_finalize(sdata);
 
 unlock:
-	mutex_unlock(&local->mtx);
 	sdata_unlock(sdata);
 }
 
@@ -3859,7 +3848,6 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	int err;
 
 	sdata_assert_lock(sdata);
-	lockdep_assert_held(&local->mtx);
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!list_empty(&local->roc_list) || local->scanning)
@@ -3959,18 +3947,15 @@ int ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
-	int err;
 
-	mutex_lock(&local->mtx);
-	err = __ieee80211_channel_switch(wiphy, dev, params);
-	mutex_unlock(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
-	return err;
+	return __ieee80211_channel_switch(wiphy, dev, params);
 }
 
 u64 ieee80211_mgmt_tx_cookie(struct ieee80211_local *local)
 {
-	lockdep_assert_held(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	local->roc_cookie_counter++;
 
@@ -4099,7 +4084,7 @@ static int ieee80211_probe_client(struct wiphy *wiphy, struct net_device *dev,
 	int ret;
 
 	/* the lock is needed to assign the cookie later */
-	mutex_lock(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	rcu_read_lock();
 	sta = sta_info_get_bss(sdata, peer);
@@ -4170,7 +4155,6 @@ static int ieee80211_probe_client(struct wiphy *wiphy, struct net_device *dev,
 	ret = 0;
 unlock:
 	rcu_read_unlock();
-	mutex_unlock(&local->mtx);
 
 	return ret;
 }
@@ -4679,7 +4663,7 @@ static int ieee80211_color_change_finalize(struct ieee80211_sub_if_data *sdata)
 	int err;
 
 	sdata_assert_lock(sdata);
-	lockdep_assert_held(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	sdata->vif.bss_conf.color_change_active = false;
 
@@ -4706,7 +4690,7 @@ void ieee80211_color_change_finalize_work(struct wiphy *wiphy,
 	struct ieee80211_local *local = sdata->local;
 
 	sdata_lock(sdata);
-	mutex_lock(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	/* AP might have been stopped while waiting for the lock. */
 	if (!sdata->vif.bss_conf.color_change_active)
@@ -4718,7 +4702,6 @@ void ieee80211_color_change_finalize_work(struct wiphy *wiphy,
 	ieee80211_color_change_finalize(sdata);
 
 unlock:
-	mutex_unlock(&local->mtx);
 	sdata_unlock(sdata);
 }
 
@@ -4777,12 +4760,11 @@ ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
 	int err;
 
 	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (sdata->vif.bss_conf.nontransmitted)
 		return -EINVAL;
 
-	mutex_lock(&local->mtx);
-
 	/* don't allow another color change if one is already active or if csa
 	 * is active
 	 */
@@ -4807,7 +4789,6 @@ ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
 		ieee80211_color_change_finalize(sdata);
 
 out:
-	mutex_unlock(&local->mtx);
 
 	return err;
 }
@@ -4829,16 +4810,13 @@ static int ieee80211_add_intf_link(struct wiphy *wiphy,
 				   unsigned int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
-	int res;
+
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (wdev->use_4addr)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&sdata->local->mtx);
-	res = ieee80211_vif_set_links(sdata, wdev->valid_links, 0);
-	mutex_unlock(&sdata->local->mtx);
-
-	return res;
+	return ieee80211_vif_set_links(sdata, wdev->valid_links, 0);
 }
 
 static void ieee80211_del_intf_link(struct wiphy *wiphy,
@@ -4847,9 +4825,9 @@ static void ieee80211_del_intf_link(struct wiphy *wiphy,
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 
-	mutex_lock(&sdata->local->mtx);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
 	ieee80211_vif_set_links(sdata, wdev->valid_links, 0);
-	mutex_unlock(&sdata->local->mtx);
 }
 
 static int sta_add_link_station(struct ieee80211_local *local,
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 31720c654b83..1d928f29ad6f 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -573,7 +573,7 @@ bool ieee80211_is_radar_required(struct ieee80211_local *local)
 {
 	struct ieee80211_sub_if_data *sdata;
 
-	lockdep_assert_held(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
@@ -604,7 +604,6 @@ ieee80211_chanctx_radar_required(struct ieee80211_local *local,
 	bool required = false;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
-	lockdep_assert_held(&local->mtx);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
@@ -666,7 +665,6 @@ static int ieee80211_add_chanctx(struct ieee80211_local *local,
 	u32 changed;
 	int err;
 
-	lockdep_assert_held(&local->mtx);
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!local->use_chanctx)
@@ -699,7 +697,6 @@ ieee80211_new_chanctx(struct ieee80211_local *local,
 	struct ieee80211_chanctx *ctx;
 	int err;
 
-	lockdep_assert_held(&local->mtx);
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	ctx = ieee80211_alloc_chanctx(local, chandef, mode);
@@ -835,8 +832,6 @@ static void ieee80211_recalc_radar_chanctx(struct ieee80211_local *local,
 	bool radar_enabled;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
-	/* for ieee80211_is_radar_required */
-	lockdep_assert_held(&local->mtx);
 
 	radar_enabled = ieee80211_chanctx_radar_required(local, chanctx);
 
@@ -1024,7 +1019,7 @@ __ieee80211_link_copy_chanctx_to_vlans(struct ieee80211_link_data *link,
 	if (WARN_ON(sdata->vif.type != NL80211_IFTYPE_AP))
 		return;
 
-	lockdep_assert_held(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	/* Check that conf exists, even when clearing this function
 	 * must be called with the AP's channel context still there
@@ -1264,7 +1259,6 @@ ieee80211_link_use_reserved_reassign(struct ieee80211_link_data *link)
 	u64 changed = 0;
 	int err;
 
-	lockdep_assert_held(&local->mtx);
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	new_ctx = link->reserved_chanctx;
@@ -1414,7 +1408,6 @@ static int ieee80211_chsw_switch_hwconf(struct ieee80211_local *local,
 {
 	const struct cfg80211_chan_def *chandef;
 
-	lockdep_assert_held(&local->mtx);
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	chandef = ieee80211_chanctx_reserved_chandef(local, new_ctx, NULL);
@@ -1436,7 +1429,6 @@ static int ieee80211_chsw_switch_vifs(struct ieee80211_local *local,
 	struct ieee80211_chanctx *ctx, *old_ctx;
 	int i, err;
 
-	lockdep_assert_held(&local->mtx);
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	vif_chsw = kcalloc(n_vifs, sizeof(vif_chsw[0]), GFP_KERNEL);
@@ -1481,7 +1473,6 @@ static int ieee80211_chsw_switch_ctxs(struct ieee80211_local *local)
 	struct ieee80211_chanctx *ctx;
 	int err;
 
-	lockdep_assert_held(&local->mtx);
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	list_for_each_entry(ctx, &local->chanctx_list, list) {
@@ -1522,7 +1513,6 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 	int err, n_assigned, n_reserved, n_ready;
 	int n_ctx = 0, n_vifs_switch = 0, n_vifs_assign = 0, n_vifs_ctxless = 0;
 
-	lockdep_assert_held(&local->mtx);
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	/*
@@ -1820,7 +1810,7 @@ int ieee80211_link_use_channel(struct ieee80211_link_data *link,
 	u8 radar_detect_width = 0;
 	int ret;
 
-	lockdep_assert_held(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (sdata->vif.active_links &&
 	    !(sdata->vif.active_links & BIT(link->link_id))) {
@@ -1828,8 +1818,6 @@ int ieee80211_link_use_channel(struct ieee80211_link_data *link,
 		return 0;
 	}
 
-	lockdep_assert_wiphy(local->hw.wiphy);
-
 	ret = cfg80211_chandef_dfs_required(local->hw.wiphy,
 					    chandef,
 					    sdata->wdev.iftype);
@@ -1882,7 +1870,6 @@ int ieee80211_link_use_reserved_context(struct ieee80211_link_data *link)
 	struct ieee80211_chanctx *old_ctx;
 	int err;
 
-	lockdep_assert_held(&local->mtx);
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	new_ctx = link->reserved_chanctx;
@@ -2002,10 +1989,8 @@ void ieee80211_link_release_channel(struct ieee80211_link_data *link)
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
-	if (rcu_access_pointer(link->conf->chanctx_conf)) {
-		lockdep_assert_held(&sdata->local->mtx);
+	if (rcu_access_pointer(link->conf->chanctx_conf))
 		__ieee80211_link_release_channel(link);
-	}
 }
 
 void ieee80211_link_vlan_copy_chanctx(struct ieee80211_link_data *link)
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index bbda2764fa02..3c6370377234 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -236,6 +236,7 @@ static void __ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 	int err;
 
 	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	/* Reset own TSF to allow time synchronization work. */
 	drv_reset_tsf(local, sdata);
@@ -299,17 +300,14 @@ static void __ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 
 	radar_required = err;
 
-	mutex_lock(&local->mtx);
 	if (ieee80211_link_use_channel(&sdata->deflink, &chandef,
 				       ifibss->fixed_channel ?
 					IEEE80211_CHANCTX_SHARED :
 					IEEE80211_CHANCTX_EXCLUSIVE)) {
 		sdata_info(sdata, "Failed to join IBSS, no channel context\n");
-		mutex_unlock(&local->mtx);
 		return;
 	}
 	sdata->deflink.radar_required = radar_required;
-	mutex_unlock(&local->mtx);
 
 	memcpy(ifibss->bssid, bssid, ETH_ALEN);
 
@@ -367,9 +365,7 @@ static void __ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 		sdata->vif.cfg.ssid_len = 0;
 		RCU_INIT_POINTER(ifibss->presp, NULL);
 		kfree_rcu(presp, rcu_head);
-		mutex_lock(&local->mtx);
 		ieee80211_link_release_channel(&sdata->deflink);
-		mutex_unlock(&local->mtx);
 		sdata_info(sdata, "Failed to join IBSS, driver failure: %d\n",
 			   err);
 		return;
@@ -680,6 +676,8 @@ static void ieee80211_ibss_disconnect(struct ieee80211_sub_if_data *sdata)
 	struct beacon_data *presp;
 	struct sta_info *sta;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	if (!is_zero_ether_addr(ifibss->bssid)) {
 		cbss = cfg80211_get_bss(local->hw.wiphy, ifibss->chandef.chan,
 					ifibss->bssid, ifibss->ssid,
@@ -726,9 +724,7 @@ static void ieee80211_ibss_disconnect(struct ieee80211_sub_if_data *sdata)
 	ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_BEACON_ENABLED |
 						BSS_CHANGED_IBSS);
 	drv_leave_ibss(local, sdata);
-	mutex_lock(&local->mtx);
 	ieee80211_link_release_channel(&sdata->deflink);
-	mutex_unlock(&local->mtx);
 }
 
 static void ieee80211_csa_connection_drop_work(struct wiphy *wiphy,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 7a8f950644ff..2d2a4445714e 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1466,9 +1466,6 @@ struct ieee80211_local {
 	struct list_head mon_list; /* only that are IFF_UP && !cooked */
 	struct mutex iflist_mtx;
 
-	/* mutex for scan and work locking */
-	struct mutex mtx;
-
 	/* Scanning and BSS list */
 	unsigned long scanning;
 	struct cfg80211_ssid scan_ssid;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 97733520d6b3..9724a3d4545b 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -110,7 +110,7 @@ static u32 __ieee80211_recalc_idle(struct ieee80211_local *local,
 	bool working, scanning, active;
 	unsigned int led_trig_start = 0, led_trig_stop = 0;
 
-	lockdep_assert_held(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	active = force_active ||
 		 !list_empty(&local->chanctx_list) ||
@@ -207,6 +207,8 @@ static int ieee80211_can_powered_addr_change(struct ieee80211_sub_if_data *sdata
 	struct ieee80211_sub_if_data *scan_sdata;
 	int ret = 0;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	/* To be the most flexible here we want to only limit changing the
 	 * address if the specific interface is doing offchannel work or
 	 * scanning.
@@ -214,8 +216,6 @@ static int ieee80211_can_powered_addr_change(struct ieee80211_sub_if_data *sdata
 	if (netif_carrier_ok(sdata->dev))
 		return -EBUSY;
 
-	mutex_lock(&local->mtx);
-
 	/* First check no ROC work is happening on this iface */
 	list_for_each_entry(roc, &local->roc_list, list) {
 		if (roc->sdata != sdata)
@@ -230,7 +230,7 @@ static int ieee80211_can_powered_addr_change(struct ieee80211_sub_if_data *sdata
 	/* And if this iface is scanning */
 	if (local->scanning) {
 		scan_sdata = rcu_dereference_protected(local->scan_sdata,
-						       lockdep_is_held(&local->mtx));
+						       lockdep_is_held(&local->hw.wiphy->mtx));
 		if (sdata == scan_sdata)
 			ret = -EBUSY;
 	}
@@ -247,7 +247,6 @@ static int ieee80211_can_powered_addr_change(struct ieee80211_sub_if_data *sdata
 	}
 
 unlock:
-	mutex_unlock(&local->mtx);
 	return ret;
 }
 
@@ -464,6 +463,8 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	bool cancel_scan;
 	struct cfg80211_nan_func *func;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
 	synchronize_rcu(); /* flush _ieee80211_wake_txqs() */
 
@@ -534,7 +535,6 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	     "destroying interface with valid links 0x%04x\n",
 	     sdata->vif.valid_links);
 
-	mutex_lock(&local->mtx);
 	sdata->vif.bss_conf.csa_active = false;
 	if (sdata->vif.type == NL80211_IFTYPE_STATION)
 		sdata->deflink.u.mgd.csa_waiting_bcn = false;
@@ -543,7 +543,6 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
 		sdata->deflink.csa_block_tx = false;
 	}
-	mutex_unlock(&local->mtx);
 	sdata_unlock(sdata);
 
 	wiphy_work_cancel(local->hw.wiphy, &sdata->deflink.csa_finalize_work);
@@ -555,9 +554,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	if (sdata->wdev.cac_started) {
 		chandef = sdata->vif.bss_conf.chandef;
 		WARN_ON(local->suspended);
-		mutex_lock(&local->mtx);
 		ieee80211_link_release_channel(&sdata->deflink);
-		mutex_unlock(&local->mtx);
 		cfg80211_cac_event(sdata->dev, &chandef,
 				   NL80211_RADAR_CAC_ABORTED,
 				   GFP_KERNEL);
@@ -585,9 +582,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP_VLAN:
-		mutex_lock(&local->mtx);
 		list_del(&sdata->u.vlan.list);
-		mutex_unlock(&local->mtx);
 		RCU_INIT_POINTER(sdata->vif.bss_conf.chanctx_conf, NULL);
 		/* see comment in the default case below */
 		ieee80211_free_keys(sdata, true);
@@ -685,9 +680,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 		if (local->monitors == 0)
 			ieee80211_del_virtual_monitor(local);
 
-		mutex_lock(&local->mtx);
 		ieee80211_recalc_idle(local);
-		mutex_unlock(&local->mtx);
 
 		if (!(sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE))
 			break;
@@ -1169,10 +1162,8 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 	mutex_unlock(&local->iflist_mtx);
 
 	sdata_lock(sdata);
-	mutex_lock(&local->mtx);
 	ret = ieee80211_link_use_channel(&sdata->deflink, &local->monitor_chandef,
 					 IEEE80211_CHANCTX_EXCLUSIVE);
-	mutex_unlock(&local->mtx);
 	sdata_unlock(sdata);
 	if (ret) {
 		mutex_lock(&local->iflist_mtx);
@@ -1217,9 +1208,7 @@ void ieee80211_del_virtual_monitor(struct ieee80211_local *local)
 	synchronize_net();
 
 	sdata_lock(sdata);
-	mutex_lock(&local->mtx);
 	ieee80211_link_release_channel(&sdata->deflink);
-	mutex_unlock(&local->mtx);
 	sdata_unlock(sdata);
 
 	drv_remove_interface(local, sdata);
@@ -1251,9 +1240,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		if (!sdata->bss)
 			return -ENOLINK;
 
-		mutex_lock(&local->mtx);
 		list_add(&sdata->u.vlan.list, &sdata->bss->vlans);
-		mutex_unlock(&local->mtx);
 
 		master = container_of(sdata->bss,
 				      struct ieee80211_sub_if_data, u.ap);
@@ -1362,9 +1349,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		ieee80211_adjust_monitor_flags(sdata, 1);
 		ieee80211_configure_filter(local);
 		ieee80211_recalc_offload(local);
-		mutex_lock(&local->mtx);
 		ieee80211_recalc_idle(local);
-		mutex_unlock(&local->mtx);
 
 		netif_carrier_on(dev);
 		break;
@@ -1469,11 +1454,8 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		drv_stop(local);
  err_del_bss:
 	sdata->bss = NULL;
-	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
-		mutex_lock(&local->mtx);
+	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		list_del(&sdata->u.vlan.list);
-		mutex_unlock(&local->mtx);
-	}
 	/* might already be clear but that doesn't matter */
 	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
 	return res;
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 226c852fd5ee..80571dcc57f5 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -457,7 +457,6 @@ int __ieee80211_set_active_links(struct ieee80211_vif *vif, u16 active_links)
 	sdata_assert_lock(sdata);
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	mutex_lock(&local->mtx);
 	old_active = sdata->vif.active_links;
 	if (old_active & active_links) {
 		/*
@@ -473,7 +472,6 @@ int __ieee80211_set_active_links(struct ieee80211_vif *vif, u16 active_links)
 		/* otherwise switch directly */
 		ret = _ieee80211_set_active_links(sdata, active_links);
 	}
-	mutex_unlock(&local->mtx);
 
 	return ret;
 }
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 0f38b5df53b3..411e44239bb9 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -804,8 +804,6 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 	__hw_addr_init(&local->mc_list);
 
 	mutex_init(&local->iflist_mtx);
-	mutex_init(&local->mtx);
-
 	spin_lock_init(&local->filter_lock);
 	spin_lock_init(&local->rx_path_lock);
 	spin_lock_init(&local->queue_stop_reason_lock);
@@ -1539,7 +1537,6 @@ void ieee80211_free_hw(struct ieee80211_hw *hw)
 	enum nl80211_band band;
 
 	mutex_destroy(&local->iflist_mtx);
-	mutex_destroy(&local->mtx);
 
 	if (local->wiphy_ciphers_allocated) {
 		kfree(local->hw.wiphy->cipher_suites);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 605407e4b67f..43bf2f409000 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1690,7 +1690,6 @@ static void ieee80211_chswitch_work(struct wiphy *wiphy,
 		return;
 
 	sdata_lock(sdata);
-	mutex_lock(&local->mtx);
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!ifmgd->associated)
@@ -1743,7 +1742,6 @@ static void ieee80211_chswitch_work(struct wiphy *wiphy,
 	ieee80211_sta_reset_conn_monitor(sdata);
 
 out:
-	mutex_unlock(&local->mtx);
 	sdata_unlock(sdata);
 }
 
@@ -1817,8 +1815,6 @@ ieee80211_sta_abort_chanswitch(struct ieee80211_link_data *link)
 	if (!local->ops->abort_channel_switch)
 		return;
 
-	mutex_lock(&local->mtx);
-
 	ieee80211_link_unreserve_chanctx(link);
 
 	if (link->csa_block_tx)
@@ -1828,8 +1824,6 @@ ieee80211_sta_abort_chanswitch(struct ieee80211_link_data *link)
 	link->csa_block_tx = false;
 	link->conf->csa_active = false;
 
-	mutex_unlock(&local->mtx);
-
 	drv_abort_channel_switch(sdata);
 }
 
@@ -1875,7 +1869,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	}
 
 	if (res < 0)
-		goto lock_and_drop_connection;
+		goto drop_connection;
 
 	if (beacon && link->conf->csa_active &&
 	    !link->u.mgd.csa_waiting_bcn) {
@@ -1897,7 +1891,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 			   csa_ie.chandef.chan->center_freq,
 			   csa_ie.chandef.width, csa_ie.chandef.center_freq1,
 			   csa_ie.chandef.center_freq2);
-		goto lock_and_drop_connection;
+		goto drop_connection;
 	}
 
 	if (!cfg80211_chandef_usable(local->hw.wiphy, &csa_ie.chandef,
@@ -1912,7 +1906,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 			   csa_ie.chandef.width, csa_ie.chandef.center_freq1,
 			   csa_ie.chandef.freq1_offset,
 			   csa_ie.chandef.center_freq2);
-		goto lock_and_drop_connection;
+		goto drop_connection;
 	}
 
 	if (cfg80211_chandef_identical(&csa_ie.chandef,
@@ -1935,7 +1929,6 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	 */
 	ieee80211_teardown_tdls_peers(sdata);
 
-	mutex_lock(&local->mtx);
 	conf = rcu_dereference_protected(link->conf->chanctx_conf,
 					 lockdep_is_held(&local->hw.wiphy->mtx));
 	if (!conf) {
@@ -1977,7 +1970,6 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	if (link->csa_block_tx)
 		ieee80211_stop_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-	mutex_unlock(&local->mtx);
 
 	cfg80211_ch_switch_started_notify(sdata->dev, &csa_ie.chandef,
 					  link->link_id, csa_ie.count,
@@ -1996,8 +1988,6 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 				 &link->u.mgd.chswitch_work,
 				 timeout);
 	return;
- lock_and_drop_connection:
-	mutex_lock(&local->mtx);
  drop_connection:
 	/*
 	 * This is just so that the disconnect flow will know that
@@ -2011,7 +2001,6 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 
 	wiphy_work_queue(sdata->local->hw.wiphy,
 			 &ifmgd->csa_connection_drop_work);
-	mutex_unlock(&local->mtx);
 }
 
 static bool
@@ -2408,14 +2397,14 @@ void ieee80211_dfs_cac_timer_work(struct wiphy *wiphy, struct wiphy_work *work)
 	struct cfg80211_chan_def chandef = link->conf->chandef;
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 
-	mutex_lock(&sdata->local->mtx);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
 	if (sdata->wdev.cac_started) {
 		ieee80211_link_release_channel(link);
 		cfg80211_cac_event(sdata->dev, &chandef,
 				   NL80211_RADAR_CAC_FINISHED,
 				   GFP_KERNEL);
 	}
-	mutex_unlock(&sdata->local->mtx);
 }
 
 static bool
@@ -2682,7 +2671,7 @@ ieee80211_sta_wmm_params(struct ieee80211_local *local,
 
 static void __ieee80211_stop_poll(struct ieee80211_sub_if_data *sdata)
 {
-	lockdep_assert_held(&sdata->local->mtx);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	sdata->u.mgd.flags &= ~IEEE80211_STA_CONNECTION_POLL;
 	ieee80211_run_deferred_scan(sdata->local);
@@ -2690,9 +2679,9 @@ static void __ieee80211_stop_poll(struct ieee80211_sub_if_data *sdata)
 
 static void ieee80211_stop_poll(struct ieee80211_sub_if_data *sdata)
 {
-	mutex_lock(&sdata->local->mtx);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
 	__ieee80211_stop_poll(sdata);
-	mutex_unlock(&sdata->local->mtx);
 }
 
 static u64 ieee80211_handle_bss_capability(struct ieee80211_link_data *link,
@@ -2896,6 +2885,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	};
 
 	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (WARN_ON_ONCE(tx && !frame_buf))
 		return;
@@ -3036,7 +3026,6 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 
 	ifmgd->flags = 0;
 	sdata->deflink.u.mgd.conn_flags = 0;
-	mutex_lock(&local->mtx);
 
 	for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++) {
 		struct ieee80211_link_data *link;
@@ -3055,7 +3044,6 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
 		sdata->deflink.csa_block_tx = false;
 	}
-	mutex_unlock(&local->mtx);
 
 	/* existing TX TSPEC sessions no longer exist */
 	memset(ifmgd->tx_tspec, 0, sizeof(ifmgd->tx_tspec));
@@ -3074,9 +3062,10 @@ static void ieee80211_reset_ap_probe(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_local *local = sdata->local;
 
-	mutex_lock(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	if (!(ifmgd->flags & IEEE80211_STA_CONNECTION_POLL))
-		goto out;
+		return;
 
 	__ieee80211_stop_poll(sdata);
 
@@ -3085,7 +3074,7 @@ static void ieee80211_reset_ap_probe(struct ieee80211_sub_if_data *sdata)
 	mutex_unlock(&local->iflist_mtx);
 
 	if (ieee80211_hw_check(&sdata->local->hw, CONNECTION_MONITOR))
-		goto out;
+		return;
 
 	/*
 	 * We've received a probe response, but are not sure whether
@@ -3097,8 +3086,6 @@ static void ieee80211_reset_ap_probe(struct ieee80211_sub_if_data *sdata)
 	mod_timer(&ifmgd->conn_mon_timer,
 		  round_jiffies_up(jiffies +
 				   IEEE80211_CONNECTION_IDLE_TIME));
-out:
-	mutex_unlock(&local->mtx);
 }
 
 static void ieee80211_sta_tx_wmm_ac_notify(struct ieee80211_sub_if_data *sdata,
@@ -3230,6 +3217,8 @@ static void ieee80211_mgd_probe_ap(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	bool already = false;
 
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
 	if (WARN_ON_ONCE(ieee80211_vif_is_mld(&sdata->vif)))
 		return;
 
@@ -3241,16 +3230,12 @@ static void ieee80211_mgd_probe_ap(struct ieee80211_sub_if_data *sdata,
 	if (!ifmgd->associated)
 		goto out;
 
-	mutex_lock(&sdata->local->mtx);
-
 	if (sdata->local->tmp_channel || sdata->local->scanning) {
-		mutex_unlock(&sdata->local->mtx);
 		goto out;
 	}
 
 	if (sdata->local->suspending) {
 		/* reschedule after resume */
-		mutex_unlock(&sdata->local->mtx);
 		ieee80211_reset_ap_probe(sdata);
 		goto out;
 	}
@@ -3279,8 +3264,6 @@ static void ieee80211_mgd_probe_ap(struct ieee80211_sub_if_data *sdata,
 
 	ifmgd->flags |= IEEE80211_STA_CONNECTION_POLL;
 
-	mutex_unlock(&sdata->local->mtx);
-
 	if (already)
 		goto out;
 
@@ -3363,6 +3346,8 @@ static void ___ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
 	bool tx;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	if (!ifmgd->associated)
 		return;
 
@@ -3398,7 +3383,6 @@ static void ___ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 					WLAN_REASON_DEAUTH_LEAVING :
 					WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
 			       tx, frame_buf);
-	mutex_lock(&local->mtx);
 	/* the other links will be destroyed */
 	sdata->vif.bss_conf.csa_active = false;
 	sdata->deflink.u.mgd.csa_waiting_bcn = false;
@@ -3407,7 +3391,6 @@ static void ___ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
 		sdata->deflink.csa_block_tx = false;
 	}
-	mutex_unlock(&local->mtx);
 
 	ieee80211_report_disconnect(sdata, frame_buf, sizeof(frame_buf), tx,
 				    WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
@@ -3504,6 +3487,7 @@ static void ieee80211_destroy_auth_data(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_mgd_auth_data *auth_data = sdata->u.mgd.auth_data;
 
 	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (!assoc) {
 		/*
@@ -3521,10 +3505,8 @@ static void ieee80211_destroy_auth_data(struct ieee80211_sub_if_data *sdata,
 						  BSS_CHANGED_BSSID);
 		sdata->u.mgd.flags = 0;
 
-		mutex_lock(&sdata->local->mtx);
 		ieee80211_link_release_channel(&sdata->deflink);
 		ieee80211_vif_set_links(sdata, 0, 0);
-		mutex_unlock(&sdata->local->mtx);
 	}
 
 	cfg80211_put_bss(sdata->local->hw.wiphy, auth_data->bss);
@@ -3545,6 +3527,7 @@ static void ieee80211_destroy_assoc_data(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_mgd_assoc_data *assoc_data = sdata->u.mgd.assoc_data;
 
 	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (status != ASSOC_SUCCESS) {
 		/*
@@ -3580,10 +3563,8 @@ static void ieee80211_destroy_assoc_data(struct ieee80211_sub_if_data *sdata,
 			cfg80211_assoc_failure(sdata->dev, &data);
 		}
 
-		mutex_lock(&sdata->local->mtx);
 		ieee80211_link_release_channel(&sdata->deflink);
 		ieee80211_vif_set_links(sdata, 0, 0);
-		mutex_unlock(&sdata->local->mtx);
 	}
 
 	kfree(assoc_data);
@@ -4817,6 +4798,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	u32 i;
 	bool have_80mhz;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	rcu_read_lock();
 
 	ies = rcu_dereference(cbss->ies);
@@ -5018,7 +5001,6 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	/* will change later if needed */
 	link->smps_mode = IEEE80211_SMPS_OFF;
 
-	mutex_lock(&local->mtx);
 	/*
 	 * If this fails (possibly due to channel context sharing
 	 * on incompatible channels, e.g. 80+80 and 160 sharing the
@@ -5039,7 +5021,6 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 						 IEEE80211_CHANCTX_SHARED);
 	}
  out:
-	mutex_unlock(&local->mtx);
 	return ret;
 }
 
@@ -7083,6 +7064,8 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	int err;
 	bool cont_auth;
 
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
 	/* prepare auth data structure */
 
 	switch (req->auth_type) {
@@ -7227,9 +7210,7 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 		eth_zero_addr(sdata->deflink.u.mgd.bssid);
 		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
 						  BSS_CHANGED_BSSID);
-		mutex_lock(&sdata->local->mtx);
 		ieee80211_link_release_channel(&sdata->deflink);
-		mutex_unlock(&sdata->local->mtx);
 	}
 	ifmgd->auth_data = NULL;
 	kfree(auth_data);
diff --git a/net/mac80211/ocb.c b/net/mac80211/ocb.c
index b44896e14522..7661e96454b2 100644
--- a/net/mac80211/ocb.c
+++ b/net/mac80211/ocb.c
@@ -178,6 +178,8 @@ int ieee80211_ocb_join(struct ieee80211_sub_if_data *sdata,
 	u64 changed = BSS_CHANGED_OCB | BSS_CHANGED_BSSID;
 	int err;
 
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
 	if (ifocb->joined == true)
 		return -EINVAL;
 
@@ -185,10 +187,8 @@ int ieee80211_ocb_join(struct ieee80211_sub_if_data *sdata,
 	sdata->deflink.smps_mode = IEEE80211_SMPS_OFF;
 	sdata->deflink.needed_rx_chains = sdata->local->rx_chains;
 
-	mutex_lock(&sdata->local->mtx);
 	err = ieee80211_link_use_channel(&sdata->deflink, &setup->chandef,
 					 IEEE80211_CHANCTX_SHARED);
-	mutex_unlock(&sdata->local->mtx);
 	if (err)
 		return err;
 
@@ -209,6 +209,8 @@ int ieee80211_ocb_leave(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_local *local = sdata->local;
 	struct sta_info *sta;
 
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
 	ifocb->joined = false;
 	sta_info_flush(sdata);
 
@@ -228,9 +230,7 @@ int ieee80211_ocb_leave(struct ieee80211_sub_if_data *sdata)
 	clear_bit(SDATA_STATE_OFFCHANNEL, &sdata->state);
 	ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_OCB);
 
-	mutex_lock(&sdata->local->mtx);
 	ieee80211_link_release_channel(&sdata->deflink);
-	mutex_unlock(&sdata->local->mtx);
 
 	skb_queue_purge(&sdata->skb_queue);
 
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index df68d9838f87..0e7e7561d0eb 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -197,7 +197,7 @@ static unsigned long ieee80211_end_finished_rocs(struct ieee80211_local *local,
 	struct ieee80211_roc_work *roc, *tmp;
 	long remaining_dur_min = LONG_MAX;
 
-	lockdep_assert_held(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	list_for_each_entry_safe(roc, tmp, &local->roc_list, list) {
 		long remaining;
@@ -264,7 +264,7 @@ static void ieee80211_hw_roc_start(struct wiphy *wiphy, struct wiphy_work *work)
 		container_of(work, struct ieee80211_local, hw_roc_start);
 	struct ieee80211_roc_work *roc;
 
-	mutex_lock(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	list_for_each_entry(roc, &local->roc_list, list) {
 		if (!roc->started)
@@ -273,8 +273,6 @@ static void ieee80211_hw_roc_start(struct wiphy *wiphy, struct wiphy_work *work)
 		roc->hw_begun = true;
 		ieee80211_handle_roc_started(roc, local->hw_roc_start_time);
 	}
-
-	mutex_unlock(&local->mtx);
 }
 
 void ieee80211_ready_on_channel(struct ieee80211_hw *hw)
@@ -295,7 +293,7 @@ static void _ieee80211_start_next_roc(struct ieee80211_local *local)
 	enum ieee80211_roc_type type;
 	u32 min_dur, max_dur;
 
-	lockdep_assert_held(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (WARN_ON(list_empty(&local->roc_list)))
 		return;
@@ -386,7 +384,7 @@ void ieee80211_start_next_roc(struct ieee80211_local *local)
 {
 	struct ieee80211_roc_work *roc;
 
-	lockdep_assert_held(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (list_empty(&local->roc_list)) {
 		ieee80211_run_deferred_scan(local);
@@ -417,7 +415,7 @@ static void __ieee80211_roc_work(struct ieee80211_local *local)
 	struct ieee80211_roc_work *roc;
 	bool on_channel;
 
-	lockdep_assert_held(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (WARN_ON(local->ops->remain_on_channel))
 		return;
@@ -456,9 +454,9 @@ static void ieee80211_roc_work(struct wiphy *wiphy, struct wiphy_work *work)
 	struct ieee80211_local *local =
 		container_of(work, struct ieee80211_local, roc_work.work);
 
-	mutex_lock(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	__ieee80211_roc_work(local);
-	mutex_unlock(&local->mtx);
 }
 
 static void ieee80211_hw_roc_done(struct wiphy *wiphy, struct wiphy_work *work)
@@ -466,14 +464,12 @@ static void ieee80211_hw_roc_done(struct wiphy *wiphy, struct wiphy_work *work)
 	struct ieee80211_local *local =
 		container_of(work, struct ieee80211_local, hw_roc_done);
 
-	mutex_lock(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	ieee80211_end_finished_rocs(local, jiffies);
 
 	/* if there's another roc, start it now */
 	ieee80211_start_next_roc(local);
-
-	mutex_unlock(&local->mtx);
 }
 
 void ieee80211_remain_on_channel_expired(struct ieee80211_hw *hw)
@@ -537,7 +533,7 @@ static int ieee80211_start_roc_work(struct ieee80211_local *local,
 	bool queued = false, combine_started = true;
 	int ret;
 
-	lockdep_assert_held(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (channel->freq_offset)
 		/* this may work, but is untested */
@@ -675,15 +671,12 @@ int ieee80211_remain_on_channel(struct wiphy *wiphy, struct wireless_dev *wdev,
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 	struct ieee80211_local *local = sdata->local;
-	int ret;
 
-	mutex_lock(&local->mtx);
-	ret = ieee80211_start_roc_work(local, sdata, chan,
-				       duration, cookie, NULL,
-				       IEEE80211_ROC_TYPE_NORMAL);
-	mutex_unlock(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
-	return ret;
+	return ieee80211_start_roc_work(local, sdata, chan,
+					duration, cookie, NULL,
+					IEEE80211_ROC_TYPE_NORMAL);
 }
 
 static int ieee80211_cancel_roc(struct ieee80211_local *local,
@@ -692,12 +685,13 @@ static int ieee80211_cancel_roc(struct ieee80211_local *local,
 	struct ieee80211_roc_work *roc, *tmp, *found = NULL;
 	int ret;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	if (!cookie)
 		return -ENOENT;
 
 	wiphy_work_flush(local->hw.wiphy, &local->hw_roc_start);
 
-	mutex_lock(&local->mtx);
 	list_for_each_entry_safe(roc, tmp, &local->roc_list, list) {
 		if (!mgmt_tx && roc->cookie != cookie)
 			continue;
@@ -709,7 +703,6 @@ static int ieee80211_cancel_roc(struct ieee80211_local *local,
 	}
 
 	if (!found) {
-		mutex_unlock(&local->mtx);
 		return -ENOENT;
 	}
 
@@ -721,7 +714,6 @@ static int ieee80211_cancel_roc(struct ieee80211_local *local,
 	if (local->ops->remain_on_channel) {
 		ret = drv_cancel_remain_on_channel(local, roc->sdata);
 		if (WARN_ON_ONCE(ret)) {
-			mutex_unlock(&local->mtx);
 			return ret;
 		}
 
@@ -749,7 +741,6 @@ static int ieee80211_cancel_roc(struct ieee80211_local *local,
 	}
 
  out_unlock:
-	mutex_unlock(&local->mtx);
 
 	return 0;
 }
@@ -778,6 +769,8 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	int ret;
 	u8 *data;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	if (params->dont_wait_for_ack)
 		flags = IEEE80211_TX_CTL_NO_ACK;
 	else
@@ -855,8 +848,6 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	if (need_offchan && !params->chan)
 		return -EINVAL;
 
-	mutex_lock(&local->mtx);
-
 	/* Check if the operating channel is the requested channel */
 	if (!params->chan && mlo_sta) {
 		need_offchan = false;
@@ -980,7 +971,6 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	if (ret)
 		ieee80211_free_txskb(&local->hw, skb);
  out_unlock:
-	mutex_unlock(&local->mtx);
 	return ret;
 }
 
@@ -1006,7 +996,8 @@ void ieee80211_roc_purge(struct ieee80211_local *local,
 	struct ieee80211_roc_work *roc, *tmp;
 	bool work_to_do = false;
 
-	mutex_lock(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	list_for_each_entry_safe(roc, tmp, &local->roc_list, list) {
 		if (sdata && roc->sdata != sdata)
 			continue;
@@ -1026,5 +1017,4 @@ void ieee80211_roc_purge(struct ieee80211_local *local,
 	}
 	if (work_to_do)
 		__ieee80211_roc_work(local);
-	mutex_unlock(&local->mtx);
 }
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 68ec2124c3db..0ea86a418eda 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -344,7 +344,7 @@ static bool ieee80211_prep_hw_scan(struct ieee80211_sub_if_data *sdata)
 	u32 flags = 0;
 
 	req = rcu_dereference_protected(local->scan_req,
-					lockdep_is_held(&local->mtx));
+					lockdep_is_held(&local->hw.wiphy->mtx));
 
 	if (test_bit(SCAN_HW_CANCELLED, &local->scanning))
 		return false;
@@ -409,7 +409,7 @@ static void __ieee80211_scan_completed(struct ieee80211_hw *hw, bool aborted)
 	struct ieee80211_sub_if_data *scan_sdata;
 	struct ieee80211_sub_if_data *sdata;
 
-	lockdep_assert_held(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	/*
 	 * It's ok to abort a not-yet-running scan (that
@@ -424,7 +424,7 @@ static void __ieee80211_scan_completed(struct ieee80211_hw *hw, bool aborted)
 		return;
 
 	scan_sdata = rcu_dereference_protected(local->scan_sdata,
-					       lockdep_is_held(&local->mtx));
+					       lockdep_is_held(&local->hw.wiphy->mtx));
 
 	if (hw_scan && !aborted &&
 	    !ieee80211_hw_check(&local->hw, SINGLE_SCAN_ON_ALL_BANDS) &&
@@ -433,7 +433,7 @@ static void __ieee80211_scan_completed(struct ieee80211_hw *hw, bool aborted)
 
 		rc = drv_hw_scan(local,
 			rcu_dereference_protected(local->scan_sdata,
-						  lockdep_is_held(&local->mtx)),
+						  lockdep_is_held(&local->hw.wiphy->mtx)),
 			local->hw_scan_req);
 
 		if (rc == 0)
@@ -450,7 +450,7 @@ static void __ieee80211_scan_completed(struct ieee80211_hw *hw, bool aborted)
 	local->hw_scan_req = NULL;
 
 	scan_req = rcu_dereference_protected(local->scan_req,
-					     lockdep_is_held(&local->mtx));
+					     lockdep_is_held(&local->hw.wiphy->mtx));
 
 	RCU_INIT_POINTER(local->scan_req, NULL);
 	RCU_INIT_POINTER(local->scan_sdata, NULL);
@@ -591,7 +591,7 @@ static bool ieee80211_can_scan(struct ieee80211_local *local,
 
 void ieee80211_run_deferred_scan(struct ieee80211_local *local)
 {
-	lockdep_assert_held(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!local->scan_req || local->scanning)
 		return;
@@ -599,7 +599,7 @@ void ieee80211_run_deferred_scan(struct ieee80211_local *local)
 	if (!ieee80211_can_scan(local,
 				rcu_dereference_protected(
 					local->scan_sdata,
-					lockdep_is_held(&local->mtx))))
+					lockdep_is_held(&local->hw.wiphy->mtx))))
 		return;
 
 	wiphy_delayed_work_queue(local->hw.wiphy, &local->scan_work,
@@ -644,7 +644,7 @@ static void ieee80211_scan_state_send_probe(struct ieee80211_local *local,
 	u32 flags = 0, tx_flags;
 
 	scan_req = rcu_dereference_protected(local->scan_req,
-					     lockdep_is_held(&local->mtx));
+					     lockdep_is_held(&local->hw.wiphy->mtx));
 
 	tx_flags = IEEE80211_TX_INTFL_OFFCHAN_TX_OK;
 	if (scan_req->no_cck)
@@ -655,7 +655,7 @@ static void ieee80211_scan_state_send_probe(struct ieee80211_local *local,
 		flags |= IEEE80211_PROBE_FLAG_RANDOM_SN;
 
 	sdata = rcu_dereference_protected(local->scan_sdata,
-					  lockdep_is_held(&local->mtx));
+					  lockdep_is_held(&local->hw.wiphy->mtx));
 
 	for (i = 0; i < scan_req->n_ssids; i++)
 		ieee80211_send_scan_probe_req(
@@ -680,7 +680,7 @@ static int __ieee80211_start_scan(struct ieee80211_sub_if_data *sdata,
 	bool hw_scan = local->ops->hw_scan;
 	int rc;
 
-	lockdep_assert_held(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (local->scan_req)
 		return -EBUSY;
@@ -884,7 +884,7 @@ static void ieee80211_scan_state_decision(struct ieee80211_local *local,
 	mutex_unlock(&local->iflist_mtx);
 
 	scan_req = rcu_dereference_protected(local->scan_req,
-					     lockdep_is_held(&local->mtx));
+					     lockdep_is_held(&local->hw.wiphy->mtx));
 
 	next_chan = scan_req->channels[local->scan_channel_idx];
 
@@ -925,7 +925,7 @@ static void ieee80211_scan_state_set_channel(struct ieee80211_local *local,
 	struct cfg80211_scan_request *scan_req;
 
 	scan_req = rcu_dereference_protected(local->scan_req,
-					     lockdep_is_held(&local->mtx));
+					     lockdep_is_held(&local->hw.wiphy->mtx));
 
 	skip = 0;
 	chan = scan_req->channels[local->scan_channel_idx];
@@ -1051,7 +1051,7 @@ void ieee80211_scan_work(struct wiphy *wiphy, struct wiphy_work *work)
 	unsigned long next_delay = 0;
 	bool aborted;
 
-	mutex_lock(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!ieee80211_can_run_worker(local)) {
 		aborted = true;
@@ -1059,9 +1059,9 @@ void ieee80211_scan_work(struct wiphy *wiphy, struct wiphy_work *work)
 	}
 
 	sdata = rcu_dereference_protected(local->scan_sdata,
-					  lockdep_is_held(&local->mtx));
+					  lockdep_is_held(&local->hw.wiphy->mtx));
 	scan_req = rcu_dereference_protected(local->scan_req,
-					     lockdep_is_held(&local->mtx));
+					     lockdep_is_held(&local->hw.wiphy->mtx));
 
 	/* When scanning on-channel, the first-callback means completed. */
 	if (test_bit(SCAN_ONCHANNEL_SCANNING, &local->scanning)) {
@@ -1075,7 +1075,7 @@ void ieee80211_scan_work(struct wiphy *wiphy, struct wiphy_work *work)
 	}
 
 	if (!sdata || !scan_req)
-		goto out;
+		return;
 
 	if (!local->scanning) {
 		int rc;
@@ -1084,13 +1084,12 @@ void ieee80211_scan_work(struct wiphy *wiphy, struct wiphy_work *work)
 		RCU_INIT_POINTER(local->scan_sdata, NULL);
 
 		rc = __ieee80211_start_scan(sdata, scan_req);
-		if (rc) {
-			/* need to complete scan in cfg80211 */
-			rcu_assign_pointer(local->scan_req, scan_req);
-			aborted = true;
-			goto out_complete;
-		} else
-			goto out;
+		if (!rc)
+			return;
+		/* need to complete scan in cfg80211 */
+		rcu_assign_pointer(local->scan_req, scan_req);
+		aborted = true;
+		goto out_complete;
 	}
 
 	clear_bit(SCAN_BEACON_WAIT, &local->scanning);
@@ -1138,24 +1137,18 @@ void ieee80211_scan_work(struct wiphy *wiphy, struct wiphy_work *work)
 
 	wiphy_delayed_work_queue(local->hw.wiphy, &local->scan_work,
 				 next_delay);
-	goto out;
+	return;
 
 out_complete:
 	__ieee80211_scan_completed(&local->hw, aborted);
-out:
-	mutex_unlock(&local->mtx);
 }
 
 int ieee80211_request_scan(struct ieee80211_sub_if_data *sdata,
 			   struct cfg80211_scan_request *req)
 {
-	int res;
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
-	mutex_lock(&sdata->local->mtx);
-	res = __ieee80211_start_scan(sdata, req);
-	mutex_unlock(&sdata->local->mtx);
-
-	return res;
+	return __ieee80211_start_scan(sdata, req);
 }
 
 int ieee80211_request_ibss_scan(struct ieee80211_sub_if_data *sdata,
@@ -1168,7 +1161,7 @@ int ieee80211_request_ibss_scan(struct ieee80211_sub_if_data *sdata,
 	int ret = -EBUSY, i, n_ch = 0;
 	enum nl80211_band band;
 
-	mutex_lock(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	/* busy scanning */
 	if (local->scan_req)
@@ -1225,7 +1218,6 @@ int ieee80211_request_ibss_scan(struct ieee80211_sub_if_data *sdata,
 
 	ret = __ieee80211_start_scan(sdata, sdata->local->int_scan_req);
  unlock:
-	mutex_unlock(&local->mtx);
 	return ret;
 }
 
@@ -1252,9 +1244,8 @@ void ieee80211_scan_cancel(struct ieee80211_local *local)
 	 * after the scan was completed/aborted.
 	 */
 
-	mutex_lock(&local->mtx);
 	if (!local->scan_req)
-		goto out;
+		return;
 
 	/*
 	 * We have a scan running and the driver already reported completion,
@@ -1264,7 +1255,7 @@ void ieee80211_scan_cancel(struct ieee80211_local *local)
 	if (test_bit(SCAN_HW_SCANNING, &local->scanning) &&
 	    test_bit(SCAN_COMPLETED, &local->scanning)) {
 		set_bit(SCAN_HW_CANCELLED, &local->scanning);
-		goto out;
+		return;
 	}
 
 	if (test_bit(SCAN_HW_SCANNING, &local->scanning)) {
@@ -1276,16 +1267,14 @@ void ieee80211_scan_cancel(struct ieee80211_local *local)
 		if (local->ops->cancel_hw_scan)
 			drv_cancel_hw_scan(local,
 				rcu_dereference_protected(local->scan_sdata,
-						lockdep_is_held(&local->mtx)));
-		goto out;
+						lockdep_is_held(&local->hw.wiphy->mtx)));
+		return;
 	}
 
 	wiphy_delayed_work_cancel(local->hw.wiphy, &local->scan_work);
 	/* and clean up */
 	memset(&local->scan_info, 0, sizeof(local->scan_info));
 	__ieee80211_scan_completed(&local->hw, true);
-out:
-	mutex_unlock(&local->mtx);
 }
 
 int __ieee80211_request_sched_scan_start(struct ieee80211_sub_if_data *sdata,
@@ -1300,10 +1289,10 @@ int __ieee80211_request_sched_scan_start(struct ieee80211_sub_if_data *sdata,
 	u8 *ie;
 	u32 flags = 0;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	iebufsz = local->scan_ies_len + req->ie_len;
 
-	lockdep_assert_held(&local->mtx);
-
 	if (!local->ops->sched_scan_start)
 		return -ENOTSUPP;
 
@@ -1353,19 +1342,13 @@ int ieee80211_request_sched_scan_start(struct ieee80211_sub_if_data *sdata,
 				       struct cfg80211_sched_scan_request *req)
 {
 	struct ieee80211_local *local = sdata->local;
-	int ret;
 
-	mutex_lock(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (rcu_access_pointer(local->sched_scan_sdata)) {
-		mutex_unlock(&local->mtx);
+	if (rcu_access_pointer(local->sched_scan_sdata))
 		return -EBUSY;
-	}
 
-	ret = __ieee80211_request_sched_scan_start(sdata, req);
-
-	mutex_unlock(&local->mtx);
-	return ret;
+	return __ieee80211_request_sched_scan_start(sdata, req);
 }
 
 int ieee80211_request_sched_scan_stop(struct ieee80211_local *local)
@@ -1373,25 +1356,21 @@ int ieee80211_request_sched_scan_stop(struct ieee80211_local *local)
 	struct ieee80211_sub_if_data *sched_scan_sdata;
 	int ret = -ENOENT;
 
-	mutex_lock(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (!local->ops->sched_scan_stop) {
-		ret = -ENOTSUPP;
-		goto out;
-	}
+	if (!local->ops->sched_scan_stop)
+		return -ENOTSUPP;
 
 	/* We don't want to restart sched scan anymore. */
 	RCU_INIT_POINTER(local->sched_scan_req, NULL);
 
 	sched_scan_sdata = rcu_dereference_protected(local->sched_scan_sdata,
-						lockdep_is_held(&local->mtx));
+						lockdep_is_held(&local->hw.wiphy->mtx));
 	if (sched_scan_sdata) {
 		ret = drv_sched_scan_stop(local, sched_scan_sdata);
 		if (!ret)
 			RCU_INIT_POINTER(local->sched_scan_sdata, NULL);
 	}
-out:
-	mutex_unlock(&local->mtx);
 
 	return ret;
 }
@@ -1408,20 +1387,16 @@ EXPORT_SYMBOL(ieee80211_sched_scan_results);
 
 void ieee80211_sched_scan_end(struct ieee80211_local *local)
 {
-	mutex_lock(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (!rcu_access_pointer(local->sched_scan_sdata)) {
-		mutex_unlock(&local->mtx);
+	if (!rcu_access_pointer(local->sched_scan_sdata))
 		return;
-	}
 
 	RCU_INIT_POINTER(local->sched_scan_sdata, NULL);
 
 	/* If sched scan was aborted by the driver. */
 	RCU_INIT_POINTER(local->sched_scan_req, NULL);
 
-	mutex_unlock(&local->mtx);
-
 	cfg80211_sched_scan_stopped_locked(local->hw.wiphy, 0);
 }
 
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index d6d3123f4e3a..9bcb0c2bba7d 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -30,13 +30,13 @@ void ieee80211_tdls_peer_del_work(struct wiphy *wiphy, struct wiphy_work *wk)
 			     u.mgd.tdls_peer_del_work.work);
 	local = sdata->local;
 
-	mutex_lock(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	if (!is_zero_ether_addr(sdata->u.mgd.tdls_peer)) {
 		tdls_dbg(sdata, "TDLS del peer %pM\n", sdata->u.mgd.tdls_peer);
 		sta_info_destroy_addr(sdata, sdata->u.mgd.tdls_peer);
 		eth_zero_addr(sdata->u.mgd.tdls_peer);
 	}
-	mutex_unlock(&local->mtx);
 }
 
 static void ieee80211_tdls_add_ext_capab(struct ieee80211_link_data *link,
@@ -1180,7 +1180,7 @@ ieee80211_tdls_mgmt_setup(struct wiphy *wiphy, struct net_device *dev,
 		return -ENOTSUPP;
 	}
 
-	mutex_lock(&local->mtx);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	/* we don't support concurrent TDLS peer setups */
 	if (!is_zero_ether_addr(sdata->u.mgd.tdls_peer) &&
@@ -1208,7 +1208,6 @@ ieee80211_tdls_mgmt_setup(struct wiphy *wiphy, struct net_device *dev,
 
 	ieee80211_flush_queues(local, sdata, false);
 	memcpy(sdata->u.mgd.tdls_peer, peer, ETH_ALEN);
-	mutex_unlock(&local->mtx);
 
 	/* we cannot take the mutex while preparing the setup packet */
 	ret = ieee80211_tdls_prep_mgmt_packet(wiphy, dev, peer,
@@ -1218,9 +1217,7 @@ ieee80211_tdls_mgmt_setup(struct wiphy *wiphy, struct net_device *dev,
 					      extra_ies, extra_ies_len, 0,
 					      NULL);
 	if (ret < 0) {
-		mutex_lock(&local->mtx);
 		eth_zero_addr(sdata->u.mgd.tdls_peer);
-		mutex_unlock(&local->mtx);
 		return ret;
 	}
 
@@ -1230,7 +1227,6 @@ ieee80211_tdls_mgmt_setup(struct wiphy *wiphy, struct net_device *dev,
 	return 0;
 
 out_unlock:
-	mutex_unlock(&local->mtx);
 	return ret;
 }
 
@@ -1470,7 +1466,6 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 	 * ieee80211_bss_info_change_notify()
 	 */
 	sdata_lock(sdata);
-	mutex_lock(&local->mtx);
 	tdls_dbg(sdata, "TDLS oper %d peer %pM\n", oper, peer);
 
 	switch (oper) {
@@ -1532,7 +1527,6 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 		wiphy_work_queue(sdata->local->hw.wiphy,
 				 &sdata->deflink.u.mgd.request_smps_work);
 
-	mutex_unlock(&local->mtx);
 	sdata_unlock(sdata);
 	return ret;
 }
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 1ff7d2368c32..d30b9f204d1b 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -6109,6 +6109,9 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 	u32 flags = 0;
 	int err;
 
+	/* mutex lock is only needed for incrementing the cookie counter */
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	/* Only accept CONTROL_PORT_PROTOCOL configured in CONNECT/ASSOCIATE
 	 * or Pre-Authentication
 	 */
@@ -6199,15 +6202,10 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 	rcu_read_unlock();
 
 start_xmit:
-	/* mutex lock is only needed for incrementing the cookie counter */
-	mutex_lock(&local->mtx);
-
 	local_bh_disable();
 	__ieee80211_subif_start_xmit(skb, skb->dev, flags, ctrl_flags, cookie);
 	local_bh_enable();
 
-	mutex_unlock(&local->mtx);
-
 	return 0;
 }
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index dce8c2043096..0873c7d60a4d 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2861,11 +2861,10 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		ieee80211_reenable_keys(sdata);
 
 	/* Reconfigure sched scan if it was interrupted by FW restart */
-	mutex_lock(&local->mtx);
 	sched_scan_sdata = rcu_dereference_protected(local->sched_scan_sdata,
-						lockdep_is_held(&local->mtx));
+						lockdep_is_held(&local->hw.wiphy->mtx));
 	sched_scan_req = rcu_dereference_protected(local->sched_scan_req,
-						lockdep_is_held(&local->mtx));
+						lockdep_is_held(&local->hw.wiphy->mtx));
 	if (sched_scan_sdata && sched_scan_req)
 		/*
 		 * Sched scan stopped, but we don't want to report it. Instead,
@@ -2881,7 +2880,6 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 			RCU_INIT_POINTER(local->sched_scan_req, NULL);
 			sched_scan_stopped = true;
 		}
-	mutex_unlock(&local->mtx);
 
 	if (sched_scan_stopped)
 		cfg80211_sched_scan_stopped_locked(local->hw.wiphy, 0);
@@ -2923,9 +2921,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		barrier();
 
 		/* Restart deferred ROCs */
-		mutex_lock(&local->mtx);
 		ieee80211_start_next_roc(local);
-		mutex_unlock(&local->mtx);
 
 		/* Requeue all works */
 		list_for_each_entry(sdata, &local->interfaces, list)
@@ -4329,7 +4325,6 @@ void ieee80211_dfs_cac_cancel(struct ieee80211_local *local)
 	/* for interface list, to avoid linking iflist_mtx and chanctx_mtx */
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	mutex_lock(&local->mtx);
 	list_for_each_entry(sdata, &local->interfaces, list) {
 		/* it might be waiting for the local->mtx, but then
 		 * by the time it gets it, sdata->wdev.cac_started
@@ -4347,7 +4342,6 @@ void ieee80211_dfs_cac_cancel(struct ieee80211_local *local)
 					   GFP_KERNEL);
 		}
 	}
-	mutex_unlock(&local->mtx);
 }
 
 void ieee80211_dfs_radar_detected_work(struct wiphy *wiphy,
@@ -4360,6 +4354,7 @@ void ieee80211_dfs_radar_detected_work(struct wiphy *wiphy,
 	int num_chanctx = 0;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
+
 	list_for_each_entry(ctx, &local->chanctx_list, list) {
 		if (ctx->replace_state == IEEE80211_CHANCTX_REPLACES_OTHER)
 			continue;
-- 
2.41.0

