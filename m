Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430E9539E8F
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jun 2022 09:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350341AbiFAHk1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jun 2022 03:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350320AbiFAHkI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jun 2022 03:40:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DBA986E3
        for <linux-wireless@vger.kernel.org>; Wed,  1 Jun 2022 00:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ycBPIzznUCVKl5/pv++ixs/UL6ntiVbB1hnFRkT/kPg=;
        t=1654069205; x=1655278805; b=Jqg53qzrV0QjZyIduCTzhVLPEMzYHXiLvBMUWdQEov9aAIh
        ZmjGnK+xL58SHu0TY6Emn0IwmpmhP83zI0agoIS0BSVEvkTbYG7cy5OPM6KD9M2jslFHb263n0q55
        jbKQkUjiWP2AH31hV9dHUJCsTPCXsiKsedojw5PHZM0ntFYlAbTSOM+5wHmSevz0T0ihL9tjCeK/p
        SqAIFr1mau8N0B2YPA27Eg9qcB03OPts9XpDWApBAMVbJKaA9+BlA1mar/I3P8oVi+ot/y08lM7ct
        PSgOGwVtTrQpgvQiK43lDCOvhgnOW2l+Qxi67AW6hmaWEWAIUS6O6UEoLMXQqiuA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nwIxW-00AJPK-9f;
        Wed, 01 Jun 2022 09:40:02 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 04/15] mac80211: make channel context code MLO-aware
Date:   Wed,  1 Jun 2022 09:39:47 +0200
Message-Id: <20220601093922.fb3f0f434c72.Icea7e695b0626177e27ab73bc8799202d623cebf@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220601073958.8345-1-johannes@sipsolutions.net>
References: <20220601073958.8345-1-johannes@sipsolutions.net>
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

Make the channel context code MLO aware, along with some
functions that it uses, so that the chan.c file is now
MLD-clean and no longer uses deflink/bss_conf/etc.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ath/ath10k/mac.c         |   2 +
 drivers/net/wireless/ath/ath11k/mac.c         |   2 +
 drivers/net/wireless/ath/ath9k/main.c         |   2 +
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   2 +
 drivers/net/wireless/mac80211_hwsim.c         |   2 +
 drivers/net/wireless/silabs/wfx/sta.c         |   2 +
 drivers/net/wireless/silabs/wfx/sta.h         |   2 +
 drivers/net/wireless/ti/wlcore/main.c         |   2 +
 include/net/mac80211.h                        |   4 +
 net/mac80211/cfg.c                            |  52 +-
 net/mac80211/chan.c                           | 642 +++++++++++-------
 net/mac80211/debug.h                          |  14 +
 net/mac80211/driver-ops.h                     |   8 +-
 net/mac80211/eht.c                            |   4 +-
 net/mac80211/he.c                             |   6 +-
 net/mac80211/ibss.c                           |   8 +-
 net/mac80211/ieee80211_i.h                    |  51 +-
 net/mac80211/iface.c                          |  15 +-
 net/mac80211/mesh_plink.c                     |   4 +-
 net/mac80211/mlme.c                           |  28 +-
 net/mac80211/ocb.c                            |   6 +-
 net/mac80211/rate.c                           |   8 +-
 net/mac80211/rate.h                           |   7 +-
 net/mac80211/rx.c                             |   8 +-
 net/mac80211/tdls.c                           |   4 +-
 net/mac80211/trace.h                          |  17 +-
 net/mac80211/util.c                           |  39 +-
 net/mac80211/vht.c                            |  36 +-
 28 files changed, 586 insertions(+), 391 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index bc0135868792..b9155e7b910a 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -8885,6 +8885,7 @@ ath10k_mac_op_change_chanctx(struct ieee80211_hw *hw,
 static int
 ath10k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
+				 unsigned int link_id,
 				 struct ieee80211_chanctx_conf *ctx)
 {
 	struct ath10k *ar = hw->priv;
@@ -8964,6 +8965,7 @@ ath10k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 static void
 ath10k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif,
+				   unsigned int link_id,
 				   struct ieee80211_chanctx_conf *ctx)
 {
 	struct ath10k *ar = hw->priv;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index be102357317b..42c4584b4df1 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7071,6 +7071,7 @@ static int ath11k_start_vdev_delay(struct ieee80211_hw *hw,
 static int
 ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
+				 unsigned int link_id,
 				 struct ieee80211_chanctx_conf *ctx)
 {
 	struct ath11k *ar = hw->priv;
@@ -7160,6 +7161,7 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 static void
 ath11k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif,
+				   unsigned int link_id,
 				   struct ieee80211_chanctx_conf *ctx)
 {
 	struct ath11k *ar = hw->priv;
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index 729f8ee9644d..c3d5d9795424 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -2596,6 +2596,7 @@ static void ath9k_change_chanctx(struct ieee80211_hw *hw,
 
 static int ath9k_assign_vif_chanctx(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
+				    unsigned int link_id,
 				    struct ieee80211_chanctx_conf *conf)
 {
 	struct ath_softc *sc = hw->priv;
@@ -2627,6 +2628,7 @@ static int ath9k_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 static void ath9k_unassign_vif_chanctx(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif,
+				       unsigned int link_id,
 				       struct ieee80211_chanctx_conf *conf)
 {
 	struct ath_softc *sc = hw->priv;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 586208506275..5d3cedc146be 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4235,6 +4235,7 @@ static int __iwl_mvm_assign_vif_chanctx(struct iwl_mvm *mvm,
 }
 static int iwl_mvm_assign_vif_chanctx(struct ieee80211_hw *hw,
 				      struct ieee80211_vif *vif,
+				      unsigned int link_id,
 				      struct ieee80211_chanctx_conf *ctx)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
@@ -4308,6 +4309,7 @@ static void __iwl_mvm_unassign_vif_chanctx(struct iwl_mvm *mvm,
 
 static void iwl_mvm_unassign_vif_chanctx(struct ieee80211_hw *hw,
 					 struct ieee80211_vif *vif,
+					 unsigned int link_id,
 					 struct ieee80211_chanctx_conf *ctx)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 1bd96b504956..0918f9dfec00 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2723,6 +2723,7 @@ static void mac80211_hwsim_change_chanctx(struct ieee80211_hw *hw,
 
 static int mac80211_hwsim_assign_vif_chanctx(struct ieee80211_hw *hw,
 					     struct ieee80211_vif *vif,
+					     unsigned int link_id,
 					     struct ieee80211_chanctx_conf *ctx)
 {
 	hwsim_check_magic(vif);
@@ -2733,6 +2734,7 @@ static int mac80211_hwsim_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 static void mac80211_hwsim_unassign_vif_chanctx(struct ieee80211_hw *hw,
 						struct ieee80211_vif *vif,
+						unsigned int link_id,
 						struct ieee80211_chanctx_conf *ctx)
 {
 	hwsim_check_magic(vif);
diff --git a/drivers/net/wireless/silabs/wfx/sta.c b/drivers/net/wireless/silabs/wfx/sta.c
index 6fb4ba1282c9..c47b9150097d 100644
--- a/drivers/net/wireless/silabs/wfx/sta.c
+++ b/drivers/net/wireless/silabs/wfx/sta.c
@@ -680,6 +680,7 @@ void wfx_change_chanctx(struct ieee80211_hw *hw, struct ieee80211_chanctx_conf *
 }
 
 int wfx_assign_vif_chanctx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			   unsigned int link_id,
 			   struct ieee80211_chanctx_conf *conf)
 {
 	struct wfx_vif *wvif = (struct wfx_vif *)vif->drv_priv;
@@ -692,6 +693,7 @@ int wfx_assign_vif_chanctx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 }
 
 void wfx_unassign_vif_chanctx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			      unsigned int link_id,
 			      struct ieee80211_chanctx_conf *conf)
 {
 	struct wfx_vif *wvif = (struct wfx_vif *)vif->drv_priv;
diff --git a/drivers/net/wireless/silabs/wfx/sta.h b/drivers/net/wireless/silabs/wfx/sta.h
index d9c6bd632b20..3109d257fe94 100644
--- a/drivers/net/wireless/silabs/wfx/sta.h
+++ b/drivers/net/wireless/silabs/wfx/sta.h
@@ -48,8 +48,10 @@ int wfx_add_chanctx(struct ieee80211_hw *hw, struct ieee80211_chanctx_conf *conf
 void wfx_remove_chanctx(struct ieee80211_hw *hw, struct ieee80211_chanctx_conf *conf);
 void wfx_change_chanctx(struct ieee80211_hw *hw, struct ieee80211_chanctx_conf *conf, u32 changed);
 int wfx_assign_vif_chanctx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			   unsigned int link_id,
 			   struct ieee80211_chanctx_conf *conf);
 void wfx_unassign_vif_chanctx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			      unsigned int link_id,
 			      struct ieee80211_chanctx_conf *conf);
 
 /* Hardware API Callbacks */
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index d365bdce2a10..b476f244a20e 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -4701,6 +4701,7 @@ static void wlcore_op_change_chanctx(struct ieee80211_hw *hw,
 
 static int wlcore_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 					struct ieee80211_vif *vif,
+					unsigned int link_id,
 					struct ieee80211_chanctx_conf *ctx)
 {
 	struct wl1271 *wl = hw->priv;
@@ -4751,6 +4752,7 @@ static int wlcore_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 static void wlcore_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 					   struct ieee80211_vif *vif,
+					   unsigned int link_id,
 					   struct ieee80211_chanctx_conf *ctx)
 {
 	struct wl1271 *wl = hw->priv;
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index e4868bccb446..4b3d19d88954 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -261,11 +261,13 @@ enum ieee80211_chanctx_switch_mode {
  * done.
  *
  * @vif: the vif that should be switched from old_ctx to new_ctx
+ * @link_id: the link ID that's switching
  * @old_ctx: the old context to which the vif was assigned
  * @new_ctx: the new context to which the vif must be assigned
  */
 struct ieee80211_vif_chanctx_switch {
 	struct ieee80211_vif *vif;
+	unsigned int link_id;
 	struct ieee80211_chanctx_conf *old_ctx;
 	struct ieee80211_chanctx_conf *new_ctx;
 };
@@ -4262,9 +4264,11 @@ struct ieee80211_ops {
 			       u32 changed);
 	int (*assign_vif_chanctx)(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif,
+				  unsigned int link_id,
 				  struct ieee80211_chanctx_conf *ctx);
 	void (*unassign_vif_chanctx)(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif,
+				     unsigned int link_id,
 				     struct ieee80211_chanctx_conf *ctx);
 	int (*switch_vif_chanctx)(struct ieee80211_hw *hw,
 				  struct ieee80211_vif_chanctx_switch *vifs,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b9a03548c89a..e76565cb6292 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -844,9 +844,10 @@ static int ieee80211_set_monitor_channel(struct wiphy *wiphy,
 		sdata = wiphy_dereference(local->hw.wiphy,
 					  local->monitor_sdata);
 		if (sdata) {
-			ieee80211_vif_release_channel(sdata);
-			ret = ieee80211_vif_use_channel(sdata, chandef,
-					IEEE80211_CHANCTX_EXCLUSIVE);
+			ieee80211_link_release_channel(sdata->link[0]);
+			ret = ieee80211_link_use_channel(sdata->link[0],
+							 chandef,
+							 IEEE80211_CHANCTX_EXCLUSIVE);
 		}
 	} else if (local->open_count == local->monitors) {
 		local->_oper_chandef = *chandef;
@@ -1187,10 +1188,12 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	mutex_lock(&local->mtx);
-	err = ieee80211_vif_use_channel(sdata, &params->chandef,
-					IEEE80211_CHANCTX_SHARED);
+	err = ieee80211_link_use_channel(sdata->link[params->beacon.link_id],
+					 &params->chandef,
+					 IEEE80211_CHANCTX_SHARED);
 	if (!err)
-		ieee80211_vif_copy_chanctx_to_vlans(sdata, false);
+		ieee80211_link_copy_chanctx_to_vlans(sdata->link[params->beacon.link_id],
+						     false);
 	mutex_unlock(&local->mtx);
 	if (err) {
 		sdata->vif.bss_conf.beacon_int = prev_beacon_int;
@@ -1300,7 +1303,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 
 error:
 	mutex_lock(&local->mtx);
-	ieee80211_vif_release_channel(sdata);
+	ieee80211_link_release_channel(sdata->link[params->beacon.link_id]);
 	mutex_unlock(&local->mtx);
 
 	return err;
@@ -1437,8 +1440,8 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	ieee80211_purge_tx_queue(&local->hw, &sdata->u.ap.ps.bc_buf);
 
 	mutex_lock(&local->mtx);
-	ieee80211_vif_copy_chanctx_to_vlans(sdata, true);
-	ieee80211_vif_release_channel(sdata);
+	ieee80211_link_copy_chanctx_to_vlans(sdata->link[link_id], true);
+	ieee80211_link_release_channel(sdata->link[link_id]);
 	mutex_unlock(&local->mtx);
 
 	return 0;
@@ -2405,8 +2408,8 @@ static int ieee80211_join_mesh(struct wiphy *wiphy, struct net_device *dev,
 	sdata->deflink.needed_rx_chains = sdata->local->rx_chains;
 
 	mutex_lock(&sdata->local->mtx);
-	err = ieee80211_vif_use_channel(sdata, &setup->chandef,
-					IEEE80211_CHANCTX_SHARED);
+	err = ieee80211_link_use_channel(sdata->link[0], &setup->chandef,
+					 IEEE80211_CHANCTX_SHARED);
 	mutex_unlock(&sdata->local->mtx);
 	if (err)
 		return err;
@@ -2420,7 +2423,7 @@ static int ieee80211_leave_mesh(struct wiphy *wiphy, struct net_device *dev)
 
 	ieee80211_stop_mesh(sdata);
 	mutex_lock(&sdata->local->mtx);
-	ieee80211_vif_release_channel(sdata);
+	ieee80211_link_release_channel(sdata->link[0]);
 	kfree(sdata->u.mesh.ie);
 	mutex_unlock(&sdata->local->mtx);
 
@@ -3149,8 +3152,8 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 	sdata->deflink.smps_mode = IEEE80211_SMPS_OFF;
 	sdata->deflink.needed_rx_chains = local->rx_chains;
 
-	err = ieee80211_vif_use_channel(sdata, chandef,
-					IEEE80211_CHANCTX_SHARED);
+	err = ieee80211_link_use_channel(sdata->link[0], chandef,
+					 IEEE80211_CHANCTX_SHARED);
 	if (err)
 		goto out_unlock;
 
@@ -3178,7 +3181,7 @@ static void ieee80211_end_cac(struct wiphy *wiphy,
 		cancel_delayed_work(&sdata->deflink.dfs_cac_timer_work);
 
 		if (sdata->wdev.cac_started) {
-			ieee80211_vif_release_channel(sdata);
+			ieee80211_link_release_channel(sdata->link[0]);
 			sdata->wdev.cac_started = false;
 		}
 	}
@@ -3382,7 +3385,7 @@ static int __ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
 		if (sdata->deflink.reserved_ready)
 			return 0;
 
-		return ieee80211_vif_use_reserved_context(sdata);
+		return ieee80211_link_use_reserved_context(sdata->link[0]);
 	}
 
 	if (!cfg80211_chandef_identical(&sdata->vif.bss_conf.chandef,
@@ -3647,16 +3650,16 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	if (err)
 		goto out;
 
-	err = ieee80211_vif_reserve_chanctx(sdata, &params->chandef,
-					    chanctx->mode,
-					    params->radar_required);
+	err = ieee80211_link_reserve_chanctx(sdata->link[0], &params->chandef,
+					     chanctx->mode,
+					     params->radar_required);
 	if (err)
 		goto out;
 
 	/* if reservation is invalid then this will fail */
 	err = ieee80211_check_combinations(sdata, NULL, chanctx->mode, 0);
 	if (err) {
-		ieee80211_vif_unreserve_chanctx(sdata);
+		ieee80211_link_unreserve_chanctx(sdata->link[0]);
 		goto out;
 	}
 
@@ -3666,7 +3669,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 
 	err = ieee80211_set_csa_beacon(sdata, params, &changed);
 	if (err) {
-		ieee80211_vif_unreserve_chanctx(sdata);
+		ieee80211_link_unreserve_chanctx(sdata->link[0]);
 		goto out;
 	}
 
@@ -3925,9 +3928,9 @@ static int ieee80211_cfg_get_channel(struct wiphy *wiphy,
 	int ret = -ENODATA;
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
+	chanctx_conf = rcu_dereference(sdata->vif.link_conf[link_id]->chanctx_conf);
 	if (chanctx_conf) {
-		*chandef = sdata->vif.bss_conf.chandef;
+		*chandef = sdata->vif.link_conf[link_id]->chandef;
 		ret = 0;
 	} else if (local->open_count > 0 &&
 		   local->open_count == local->monitors &&
@@ -3984,7 +3987,8 @@ static int ieee80211_set_ap_chanwidth(struct wiphy *wiphy,
 	int ret;
 	u32 changed = 0;
 
-	ret = ieee80211_vif_change_bandwidth(sdata, chandef, &changed);
+	ret = ieee80211_link_change_bandwidth(sdata->link[link_id], chandef,
+					      &changed);
 	if (ret == 0)
 		ieee80211_link_info_change_notify(sdata, link_id, changed);
 
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 5d8b49f20198..4f25660d0eeb 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -15,12 +15,12 @@
 static int ieee80211_chanctx_num_assigned(struct ieee80211_local *local,
 					  struct ieee80211_chanctx *ctx)
 {
-	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_link_data *link;
 	int num = 0;
 
 	lockdep_assert_held(&local->chanctx_mtx);
 
-	list_for_each_entry(sdata, &ctx->assigned_vifs, assigned_chanctx_list)
+	list_for_each_entry(link, &ctx->assigned_links, assigned_chanctx_list)
 		num++;
 
 	return num;
@@ -29,12 +29,12 @@ static int ieee80211_chanctx_num_assigned(struct ieee80211_local *local,
 static int ieee80211_chanctx_num_reserved(struct ieee80211_local *local,
 					  struct ieee80211_chanctx *ctx)
 {
-	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_link_data *link;
 	int num = 0;
 
 	lockdep_assert_held(&local->chanctx_mtx);
 
-	list_for_each_entry(sdata, &ctx->reserved_vifs, reserved_chanctx_list)
+	list_for_each_entry(link, &ctx->reserved_links, reserved_chanctx_list)
 		num++;
 
 	return num;
@@ -67,12 +67,14 @@ static bool ieee80211_can_create_new_chanctx(struct ieee80211_local *local)
 }
 
 static struct ieee80211_chanctx *
-ieee80211_vif_get_chanctx(struct ieee80211_sub_if_data *sdata)
+ieee80211_vif_get_chanctx(struct ieee80211_sub_if_data *sdata,
+			  unsigned int link_id)
 {
+	struct ieee80211_bss_conf *link_conf = sdata->vif.link_conf[link_id];
 	struct ieee80211_local *local __maybe_unused = sdata->local;
 	struct ieee80211_chanctx_conf *conf;
 
-	conf = rcu_dereference_protected(sdata->vif.bss_conf.chanctx_conf,
+	conf = rcu_dereference_protected(link_conf->chanctx_conf,
 					 lockdep_is_held(&local->chanctx_mtx));
 	if (!conf)
 		return NULL;
@@ -80,21 +82,27 @@ ieee80211_vif_get_chanctx(struct ieee80211_sub_if_data *sdata)
 	return container_of(conf, struct ieee80211_chanctx, conf);
 }
 
+static struct ieee80211_chanctx *
+ieee80211_link_get_chanctx(struct ieee80211_link_data *link)
+{
+	return ieee80211_vif_get_chanctx(link->sdata, link->link_id);
+}
+
 static const struct cfg80211_chan_def *
 ieee80211_chanctx_reserved_chandef(struct ieee80211_local *local,
 				   struct ieee80211_chanctx *ctx,
 				   const struct cfg80211_chan_def *compat)
 {
-	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_link_data *link;
 
 	lockdep_assert_held(&local->chanctx_mtx);
 
-	list_for_each_entry(sdata, &ctx->reserved_vifs,
+	list_for_each_entry(link, &ctx->reserved_links,
 			    reserved_chanctx_list) {
 		if (!compat)
-			compat = &sdata->deflink.reserved_chandef;
+			compat = &link->reserved_chandef;
 
-		compat = cfg80211_chandef_compatible(&sdata->deflink.reserved_chandef,
+		compat = cfg80211_chandef_compatible(&link->reserved_chandef,
 						     compat);
 		if (!compat)
 			break;
@@ -108,20 +116,23 @@ ieee80211_chanctx_non_reserved_chandef(struct ieee80211_local *local,
 				       struct ieee80211_chanctx *ctx,
 				       const struct cfg80211_chan_def *compat)
 {
-	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_link_data *link;
 
 	lockdep_assert_held(&local->chanctx_mtx);
 
-	list_for_each_entry(sdata, &ctx->assigned_vifs,
+	list_for_each_entry(link, &ctx->assigned_links,
 			    assigned_chanctx_list) {
-		if (sdata->deflink.reserved_chanctx != NULL)
+		struct ieee80211_bss_conf *link_conf =
+			link->sdata->vif.link_conf[link->link_id];
+
+		if (link->reserved_chanctx)
 			continue;
 
 		if (!compat)
-			compat = &sdata->vif.bss_conf.chandef;
+			compat = &link_conf->chandef;
 
 		compat = cfg80211_chandef_compatible(
-				&sdata->vif.bss_conf.chandef, compat);
+				&link_conf->chandef, compat);
 		if (!compat)
 			break;
 	}
@@ -157,7 +168,7 @@ ieee80211_chanctx_can_reserve_chandef(struct ieee80211_local *local,
 	if (ieee80211_chanctx_combined_chandef(local, ctx, def))
 		return true;
 
-	if (!list_empty(&ctx->reserved_vifs) &&
+	if (!list_empty(&ctx->reserved_links) &&
 	    ieee80211_chanctx_reserved_chandef(local, ctx, def))
 		return true;
 
@@ -193,13 +204,19 @@ ieee80211_find_reservation_chanctx(struct ieee80211_local *local,
 	return NULL;
 }
 
-static enum nl80211_chan_width ieee80211_get_sta_bw(struct sta_info *sta)
+static enum nl80211_chan_width ieee80211_get_sta_bw(struct sta_info *sta,
+						    unsigned int link_id)
 {
-	enum ieee80211_sta_rx_bandwidth width = ieee80211_sta_cap_rx_bw(sta);
+	enum ieee80211_sta_rx_bandwidth width =
+		ieee80211_sta_cap_rx_bw(sta, link_id);
+
+	/* no effect if this STA has no presence on this link */
+	if (!sta->sta.link[link_id])
+		return NL80211_CHAN_WIDTH_20_NOHT;
 
 	switch (width) {
 	case IEEE80211_STA_RX_BW_20:
-		if (sta->sta.deflink.ht_cap.ht_supported)
+		if (sta->sta.link[link_id]->ht_cap.ht_supported)
 			return NL80211_CHAN_WIDTH_20;
 		else
 			return NL80211_CHAN_WIDTH_20_NOHT;
@@ -227,7 +244,8 @@ static enum nl80211_chan_width ieee80211_get_sta_bw(struct sta_info *sta)
 }
 
 static enum nl80211_chan_width
-ieee80211_get_max_required_bw(struct ieee80211_sub_if_data *sdata)
+ieee80211_get_max_required_bw(struct ieee80211_sub_if_data *sdata,
+			      unsigned int link_id)
 {
 	enum nl80211_chan_width max_bw = NL80211_CHAN_WIDTH_20_NOHT;
 	struct sta_info *sta;
@@ -238,7 +256,7 @@ ieee80211_get_max_required_bw(struct ieee80211_sub_if_data *sdata)
 		    !(sta->sdata->bss && sta->sdata->bss == sdata->bss))
 			continue;
 
-		max_bw = max(max_bw, ieee80211_get_sta_bw(sta));
+		max_bw = max(max_bw, ieee80211_get_sta_bw(sta, link_id));
 	}
 	rcu_read_unlock();
 
@@ -246,27 +264,28 @@ ieee80211_get_max_required_bw(struct ieee80211_sub_if_data *sdata)
 }
 
 static enum nl80211_chan_width
-ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
-				      struct ieee80211_chanctx_conf *conf)
+ieee80211_get_chanctx_vif_max_required_bw(struct ieee80211_sub_if_data *sdata,
+					  struct ieee80211_chanctx_conf *conf)
 {
-	struct ieee80211_sub_if_data *sdata;
 	enum nl80211_chan_width max_bw = NL80211_CHAN_WIDTH_20_NOHT;
+	struct ieee80211_vif *vif = &sdata->vif;
+	int link_id;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
-		struct ieee80211_vif *vif = &sdata->vif;
+	for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++) {
 		enum nl80211_chan_width width = NL80211_CHAN_WIDTH_20_NOHT;
+		struct ieee80211_bss_conf *link_conf =
+			sdata->vif.link_conf[link_id];
 
-		if (!ieee80211_sdata_running(sdata))
+		if (!link_conf)
 			continue;
 
-		if (rcu_access_pointer(sdata->vif.bss_conf.chanctx_conf) != conf)
+		if (rcu_access_pointer(link_conf->chanctx_conf) != conf)
 			continue;
 
 		switch (vif->type) {
 		case NL80211_IFTYPE_AP:
 		case NL80211_IFTYPE_AP_VLAN:
-			width = ieee80211_get_max_required_bw(sdata);
+			width = ieee80211_get_max_required_bw(sdata, link_id);
 			break;
 		case NL80211_IFTYPE_STATION:
 			/*
@@ -274,8 +293,8 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
 			 * point, so take the width from the chandef, but
 			 * account also for TDLS peers
 			 */
-			width = max(vif->bss_conf.chandef.width,
-				    ieee80211_get_max_required_bw(sdata));
+			width = max(link_conf->chandef.width,
+				    ieee80211_get_max_required_bw(sdata, link_id));
 			break;
 		case NL80211_IFTYPE_P2P_DEVICE:
 		case NL80211_IFTYPE_NAN:
@@ -283,7 +302,7 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
 		case NL80211_IFTYPE_ADHOC:
 		case NL80211_IFTYPE_MESH_POINT:
 		case NL80211_IFTYPE_OCB:
-			width = vif->bss_conf.chandef.width;
+			width = link_conf->chandef.width;
 			break;
 		case NL80211_IFTYPE_WDS:
 		case NL80211_IFTYPE_UNSPECIFIED:
@@ -293,12 +312,36 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
 		case NL80211_IFTYPE_P2P_GO:
 			WARN_ON_ONCE(1);
 		}
+
+		max_bw = max(max_bw, width);
+	}
+
+	return max_bw;
+}
+
+static enum nl80211_chan_width
+ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
+				      struct ieee80211_chanctx_conf *conf)
+{
+	struct ieee80211_sub_if_data *sdata;
+	enum nl80211_chan_width max_bw = NL80211_CHAN_WIDTH_20_NOHT;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
+		enum nl80211_chan_width width;
+
+		if (!ieee80211_sdata_running(sdata))
+			continue;
+
+		width = ieee80211_get_chanctx_vif_max_required_bw(sdata, conf);
+
 		max_bw = max(max_bw, width);
 	}
 
 	/* use the configured bandwidth in case of monitor interface */
 	sdata = rcu_dereference(local->monitor_sdata);
-	if (sdata && rcu_access_pointer(sdata->vif.bss_conf.chanctx_conf) == conf)
+	if (sdata &&
+	    rcu_access_pointer(sdata->vif.link_conf[0]->chanctx_conf) == conf)
 		max_bw = max(max_bw, conf->def.width);
 
 	rcu_read_unlock();
@@ -350,7 +393,7 @@ static u32 _ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 }
 
 /* calling this function is assuming that station vif is updated to
- * lates changes by calling ieee80211_vif_update_chandef
+ * lates changes by calling ieee80211_link_update_chandef
  */
 static void ieee80211_chan_bw_change(struct ieee80211_local *local,
 				     struct ieee80211_chanctx *ctx,
@@ -363,29 +406,38 @@ static void ieee80211_chan_bw_change(struct ieee80211_local *local,
 	rcu_read_lock();
 	list_for_each_entry_rcu(sta, &local->sta_list,
 				list) {
+		struct ieee80211_sub_if_data *sdata = sta->sdata;
 		enum ieee80211_sta_rx_bandwidth new_sta_bw;
+		unsigned int link_id;
 
 		if (!ieee80211_sdata_running(sta->sdata))
 			continue;
 
-		if (rcu_access_pointer(sta->sdata->vif.bss_conf.chanctx_conf) !=
-		    &ctx->conf)
-			continue;
+		for (link_id = 0; link_id < ARRAY_SIZE(sta->sdata->link); link_id++) {
+			struct ieee80211_bss_conf *link_conf =
+				sdata->vif.link_conf[link_id];
+
+			if (!link_conf)
+				continue;
 
-		new_sta_bw = ieee80211_sta_cur_vht_bw(sta);
+			if (rcu_access_pointer(link_conf->chanctx_conf) != &ctx->conf)
+				continue;
 
-		/* nothing change */
-		if (new_sta_bw == sta->sta.deflink.bandwidth)
-			continue;
+			new_sta_bw = ieee80211_sta_cur_vht_bw(sta, link_id);
 
-		/* vif changed to narrow BW and narrow BW for station wasn't
-		 * requested or vise versa */
-		if ((new_sta_bw < sta->sta.deflink.bandwidth) == !narrowed)
-			continue;
+			/* nothing change */
+			if (new_sta_bw == sta->sta.link[link_id]->bandwidth)
+				continue;
+
+			/* vif changed to narrow BW and narrow BW for station wasn't
+			 * requested or vise versa */
+			if ((new_sta_bw < sta->sta.link[link_id]->bandwidth) == !narrowed)
+				continue;
 
-		sta->sta.deflink.bandwidth = new_sta_bw;
-		rate_control_rate_update(local, sband, sta,
-					 IEEE80211_RC_BW_CHANGED);
+			sta->sta.link[link_id]->bandwidth = new_sta_bw;
+			rate_control_rate_update(local, sband, sta, link_id,
+						 IEEE80211_RC_BW_CHANGED);
+		}
 	}
 	rcu_read_unlock();
 }
@@ -508,9 +560,14 @@ bool ieee80211_is_radar_required(struct ieee80211_local *local)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
-		if (sdata->deflink.radar_required) {
-			rcu_read_unlock();
-			return true;
+		unsigned int link_id;
+
+		for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++) {
+			if (sdata->link[link_id] &&
+			    sdata->link[link_id]->radar_required) {
+				rcu_read_unlock();
+				return true;
+			}
 		}
 	}
 	rcu_read_unlock();
@@ -531,15 +588,27 @@ ieee80211_chanctx_radar_required(struct ieee80211_local *local,
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
+		unsigned int link_id;
+
 		if (!ieee80211_sdata_running(sdata))
 			continue;
-		if (rcu_access_pointer(sdata->vif.bss_conf.chanctx_conf) != conf)
-			continue;
-		if (!sdata->deflink.radar_required)
-			continue;
+		for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++) {
+			struct ieee80211_bss_conf *link_conf =
+				sdata->vif.link_conf[link_id];
 
-		required = true;
-		break;
+			if (!link_conf)
+				continue;
+
+			if (rcu_access_pointer(link_conf->chanctx_conf) != conf)
+				continue;
+			if (!sdata->link[link_id]->radar_required)
+				continue;
+			required = true;
+			break;
+		}
+
+		if (required)
+			break;
 	}
 	rcu_read_unlock();
 
@@ -559,8 +628,8 @@ ieee80211_alloc_chanctx(struct ieee80211_local *local,
 	if (!ctx)
 		return NULL;
 
-	INIT_LIST_HEAD(&ctx->assigned_vifs);
-	INIT_LIST_HEAD(&ctx->reserved_vifs);
+	INIT_LIST_HEAD(&ctx->assigned_links);
+	INIT_LIST_HEAD(&ctx->reserved_links);
 	ctx->conf.def = *chandef;
 	ctx->conf.rx_chains_static = 1;
 	ctx->conf.rx_chains_dynamic = 1;
@@ -686,21 +755,32 @@ void ieee80211_recalc_chanctx_chantype(struct ieee80211_local *local,
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
+		int link_id;
 
 		if (!ieee80211_sdata_running(sdata))
 			continue;
-		if (rcu_access_pointer(sdata->vif.bss_conf.chanctx_conf) != conf)
-			continue;
+
 		if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 			continue;
 
-		if (!compat)
-			compat = &sdata->vif.bss_conf.chandef;
+		for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++) {
+			struct ieee80211_bss_conf *link_conf =
+				sdata->vif.link_conf[link_id];
 
-		compat = cfg80211_chandef_compatible(
-				&sdata->vif.bss_conf.chandef, compat);
-		if (WARN_ON_ONCE(!compat))
-			break;
+			if (!link_conf)
+				continue;
+
+			if (rcu_access_pointer(link_conf->chanctx_conf) != conf)
+				continue;
+
+			if (!compat)
+				compat = &link_conf->chandef;
+
+			compat = cfg80211_chandef_compatible(&link_conf->chandef,
+							     compat);
+			if (WARN_ON_ONCE(!compat))
+				break;
+		}
 	}
 
 	/* TDLS peers can sometimes affect the chandef width */
@@ -748,9 +828,11 @@ static void ieee80211_recalc_radar_chanctx(struct ieee80211_local *local,
 	drv_change_chanctx(local, chanctx, IEEE80211_CHANCTX_CHANGE_RADAR);
 }
 
-static int ieee80211_assign_vif_chanctx(struct ieee80211_sub_if_data *sdata,
-					struct ieee80211_chanctx *new_ctx)
+static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
+					 struct ieee80211_chanctx *new_ctx)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
+	unsigned int link_id = link->link_id;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx_conf *conf;
 	struct ieee80211_chanctx *curr_ctx = NULL;
@@ -759,29 +841,29 @@ static int ieee80211_assign_vif_chanctx(struct ieee80211_sub_if_data *sdata,
 	if (WARN_ON(sdata->vif.type == NL80211_IFTYPE_NAN))
 		return -ENOTSUPP;
 
-	conf = rcu_dereference_protected(sdata->vif.bss_conf.chanctx_conf,
+	conf = rcu_dereference_protected(sdata->vif.link_conf[link_id]->chanctx_conf,
 					 lockdep_is_held(&local->chanctx_mtx));
 
 	if (conf) {
 		curr_ctx = container_of(conf, struct ieee80211_chanctx, conf);
 
-		drv_unassign_vif_chanctx(local, sdata, curr_ctx);
+		drv_unassign_vif_chanctx(local, sdata, link_id, curr_ctx);
 		conf = NULL;
-		list_del(&sdata->assigned_chanctx_list);
+		list_del(&link->assigned_chanctx_list);
 	}
 
 	if (new_ctx) {
-		ret = drv_assign_vif_chanctx(local, sdata, new_ctx);
+		ret = drv_assign_vif_chanctx(local, sdata, link_id, new_ctx);
 		if (ret)
 			goto out;
 
 		conf = &new_ctx->conf;
-		list_add(&sdata->assigned_chanctx_list,
-			 &new_ctx->assigned_vifs);
+		list_add(&link->assigned_chanctx_list,
+			 &new_ctx->assigned_links);
 	}
 
 out:
-	rcu_assign_pointer(sdata->vif.bss_conf.chanctx_conf, conf);
+	rcu_assign_pointer(sdata->vif.link_conf[link_id]->chanctx_conf, conf);
 
 	sdata->vif.cfg.idle = !conf;
 
@@ -820,60 +902,64 @@ void ieee80211_recalc_smps_chanctx(struct ieee80211_local *local,
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
 		u8 needed_static, needed_dynamic;
+		unsigned int link_id;
 
 		if (!ieee80211_sdata_running(sdata))
 			continue;
 
-		if (rcu_access_pointer(sdata->vif.bss_conf.chanctx_conf) !=
-						&chanctx->conf)
-			continue;
-
 		switch (sdata->vif.type) {
-		case NL80211_IFTYPE_P2P_DEVICE:
-		case NL80211_IFTYPE_NAN:
-			continue;
 		case NL80211_IFTYPE_STATION:
 			if (!sdata->u.mgd.associated)
 				continue;
 			break;
-		case NL80211_IFTYPE_AP_VLAN:
-			continue;
 		case NL80211_IFTYPE_AP:
 		case NL80211_IFTYPE_ADHOC:
 		case NL80211_IFTYPE_MESH_POINT:
 		case NL80211_IFTYPE_OCB:
 			break;
 		default:
-			WARN_ON_ONCE(1);
+			continue;
 		}
 
-		switch (sdata->deflink.smps_mode) {
-		default:
-			WARN_ONCE(1, "Invalid SMPS mode %d\n",
-				  sdata->deflink.smps_mode);
-			fallthrough;
-		case IEEE80211_SMPS_OFF:
-			needed_static = sdata->deflink.needed_rx_chains;
-			needed_dynamic = sdata->deflink.needed_rx_chains;
-			break;
-		case IEEE80211_SMPS_DYNAMIC:
-			needed_static = 1;
-			needed_dynamic = sdata->deflink.needed_rx_chains;
-			break;
-		case IEEE80211_SMPS_STATIC:
-			needed_static = 1;
-			needed_dynamic = 1;
-			break;
-		}
+		for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++) {
+			struct ieee80211_link_data *link = sdata->link[link_id];
+			struct ieee80211_bss_conf *link_conf =
+				sdata->vif.link_conf[link_id];
+
+			if (!link_conf)
+				continue;
+
+			if (rcu_access_pointer(link_conf->chanctx_conf) != &chanctx->conf)
+				continue;
+
+			switch (link->smps_mode) {
+			default:
+				WARN_ONCE(1, "Invalid SMPS mode %d\n",
+					  link->smps_mode);
+				fallthrough;
+			case IEEE80211_SMPS_OFF:
+				needed_static = link->needed_rx_chains;
+				needed_dynamic = link->needed_rx_chains;
+				break;
+			case IEEE80211_SMPS_DYNAMIC:
+				needed_static = 1;
+				needed_dynamic = link->needed_rx_chains;
+				break;
+			case IEEE80211_SMPS_STATIC:
+				needed_static = 1;
+				needed_dynamic = 1;
+				break;
+			}
 
-		rx_chains_static = max(rx_chains_static, needed_static);
-		rx_chains_dynamic = max(rx_chains_dynamic, needed_dynamic);
+			rx_chains_static = max(rx_chains_static, needed_static);
+			rx_chains_dynamic = max(rx_chains_dynamic, needed_dynamic);
+		}
 	}
 
 	/* Disable SMPS for the monitor interface */
 	sdata = rcu_dereference(local->monitor_sdata);
 	if (sdata &&
-	    rcu_access_pointer(sdata->vif.bss_conf.chanctx_conf) == &chanctx->conf)
+	    rcu_access_pointer(sdata->vif.link_conf[0]->chanctx_conf) == &chanctx->conf)
 		rx_chains_dynamic = rx_chains_static = local->rx_chains;
 
 	rcu_read_unlock();
@@ -898,9 +984,12 @@ void ieee80211_recalc_smps_chanctx(struct ieee80211_local *local,
 }
 
 static void
-__ieee80211_vif_copy_chanctx_to_vlans(struct ieee80211_sub_if_data *sdata,
-				      bool clear)
+__ieee80211_link_copy_chanctx_to_vlans(struct ieee80211_link_data *link,
+				       bool clear)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
+	unsigned int link_id = link->link_id;
+	struct ieee80211_bss_conf *link_conf = sdata->vif.link_conf[link_id];
 	struct ieee80211_local *local __maybe_unused = sdata->local;
 	struct ieee80211_sub_if_data *vlan;
 	struct ieee80211_chanctx_conf *conf;
@@ -916,7 +1005,7 @@ __ieee80211_vif_copy_chanctx_to_vlans(struct ieee80211_sub_if_data *sdata,
 	 * channel context pointer for a while, possibly pointing
 	 * to a channel context that has already been freed.
 	 */
-	conf = rcu_dereference_protected(sdata->vif.bss_conf.chanctx_conf,
+	conf = rcu_dereference_protected(link_conf->chanctx_conf,
 					 lockdep_is_held(&local->chanctx_mtx));
 	WARN_ON(!conf);
 
@@ -924,32 +1013,34 @@ __ieee80211_vif_copy_chanctx_to_vlans(struct ieee80211_sub_if_data *sdata,
 		conf = NULL;
 
 	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list)
-		rcu_assign_pointer(vlan->vif.bss_conf.chanctx_conf, conf);
+		rcu_assign_pointer(vlan->vif.link_conf[link_id]->chanctx_conf,
+				   conf);
 }
 
-void ieee80211_vif_copy_chanctx_to_vlans(struct ieee80211_sub_if_data *sdata,
-					 bool clear)
+void ieee80211_link_copy_chanctx_to_vlans(struct ieee80211_link_data *link,
+					  bool clear)
 {
-	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_local *local = link->sdata->local;
 
 	mutex_lock(&local->chanctx_mtx);
 
-	__ieee80211_vif_copy_chanctx_to_vlans(sdata, clear);
+	__ieee80211_link_copy_chanctx_to_vlans(link, clear);
 
 	mutex_unlock(&local->chanctx_mtx);
 }
 
-int ieee80211_vif_unreserve_chanctx(struct ieee80211_sub_if_data *sdata)
+int ieee80211_link_unreserve_chanctx(struct ieee80211_link_data *link)
 {
-	struct ieee80211_chanctx *ctx = sdata->deflink.reserved_chanctx;
+	struct ieee80211_sub_if_data *sdata = link->sdata;
+	struct ieee80211_chanctx *ctx = link->reserved_chanctx;
 
 	lockdep_assert_held(&sdata->local->chanctx_mtx);
 
 	if (WARN_ON(!ctx))
 		return -EINVAL;
 
-	list_del(&sdata->reserved_chanctx_list);
-	sdata->deflink.reserved_chanctx = NULL;
+	list_del(&link->reserved_chanctx_list);
+	link->reserved_chanctx = NULL;
 
 	if (ieee80211_chanctx_refcount(sdata->local, ctx) == 0) {
 		if (ctx->replace_state == IEEE80211_CHANCTX_REPLACES_OTHER) {
@@ -974,17 +1065,18 @@ int ieee80211_vif_unreserve_chanctx(struct ieee80211_sub_if_data *sdata)
 	return 0;
 }
 
-int ieee80211_vif_reserve_chanctx(struct ieee80211_sub_if_data *sdata,
-				  const struct cfg80211_chan_def *chandef,
-				  enum ieee80211_chanctx_mode mode,
-				  bool radar_required)
+int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
+				   const struct cfg80211_chan_def *chandef,
+				   enum ieee80211_chanctx_mode mode,
+				   bool radar_required)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx *new_ctx, *curr_ctx, *ctx;
 
 	lockdep_assert_held(&local->chanctx_mtx);
 
-	curr_ctx = ieee80211_vif_get_chanctx(sdata);
+	curr_ctx = ieee80211_link_get_chanctx(link);
 	if (curr_ctx && local->use_chanctx && !local->ops->switch_vif_chanctx)
 		return -ENOTSUPP;
 
@@ -998,11 +1090,11 @@ int ieee80211_vif_reserve_chanctx(struct ieee80211_sub_if_data *sdata,
 			if (!curr_ctx ||
 			    (curr_ctx->replace_state ==
 			     IEEE80211_CHANCTX_WILL_BE_REPLACED) ||
-			    !list_empty(&curr_ctx->reserved_vifs)) {
+			    !list_empty(&curr_ctx->reserved_links)) {
 				/*
-				 * Another vif already requested this context
+				 * Another link already requested this context
 				 * for a reservation. Find another one hoping
-				 * all vifs assigned to it will also switch
+				 * all links assigned to it will also switch
 				 * soon enough.
 				 *
 				 * TODO: This needs a little more work as some
@@ -1011,13 +1103,13 @@ int ieee80211_vif_reserve_chanctx(struct ieee80211_sub_if_data *sdata,
 				 * provided some channel context juggling was
 				 * performed.
 				 *
-				 * Consider ctx1..3, vif1..6, each ctx has 2
-				 * vifs. vif1 and vif2 from ctx1 request new
+				 * Consider ctx1..3, link1..6, each ctx has 2
+				 * links. link1 and link2 from ctx1 request new
 				 * different chandefs starting 2 in-place
 				 * reserations with ctx4 and ctx5 replacing
-				 * ctx1 and ctx2 respectively. Next vif5 and
-				 * vif6 from ctx3 reserve ctx4. If vif3 and
-				 * vif4 remain on ctx2 as they are then this
+				 * ctx1 and ctx2 respectively. Next link5 and
+				 * link6 from ctx3 reserve ctx4. If link3 and
+				 * link4 remain on ctx2 as they are then this
 				 * fails unless `replace_ctx` from ctx5 is
 				 * replaced with ctx3.
 				 */
@@ -1027,7 +1119,7 @@ int ieee80211_vif_reserve_chanctx(struct ieee80211_sub_if_data *sdata,
 					    IEEE80211_CHANCTX_REPLACE_NONE)
 						continue;
 
-					if (!list_empty(&ctx->reserved_vifs))
+					if (!list_empty(&ctx->reserved_links))
 						continue;
 
 					curr_ctx = ctx;
@@ -1042,7 +1134,7 @@ int ieee80211_vif_reserve_chanctx(struct ieee80211_sub_if_data *sdata,
 			if (!curr_ctx ||
 			    (curr_ctx->replace_state ==
 			     IEEE80211_CHANCTX_WILL_BE_REPLACED) ||
-			    !list_empty(&curr_ctx->reserved_vifs))
+			    !list_empty(&curr_ctx->reserved_links))
 				return -EBUSY;
 
 			new_ctx = ieee80211_alloc_chanctx(local, chandef, mode);
@@ -1061,25 +1153,27 @@ int ieee80211_vif_reserve_chanctx(struct ieee80211_sub_if_data *sdata,
 		}
 	}
 
-	list_add(&sdata->reserved_chanctx_list, &new_ctx->reserved_vifs);
-	sdata->deflink.reserved_chanctx = new_ctx;
-	sdata->deflink.reserved_chandef = *chandef;
-	sdata->deflink.reserved_radar_required = radar_required;
-	sdata->deflink.reserved_ready = false;
+	list_add(&link->reserved_chanctx_list, &new_ctx->reserved_links);
+	link->reserved_chanctx = new_ctx;
+	link->reserved_chandef = *chandef;
+	link->reserved_radar_required = radar_required;
+	link->reserved_ready = false;
 
 	return 0;
 }
 
 static void
-ieee80211_vif_chanctx_reservation_complete(struct ieee80211_sub_if_data *sdata)
+ieee80211_link_chanctx_reservation_complete(struct ieee80211_link_data *link)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
+
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_ADHOC:
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_OCB:
 		ieee80211_queue_work(&sdata->local->hw,
-				     &sdata->deflink.csa_finalize_work);
+				     &link->csa_finalize_work);
 		break;
 	case NL80211_IFTYPE_STATION:
 		ieee80211_queue_work(&sdata->local->hw,
@@ -1100,23 +1194,28 @@ ieee80211_vif_chanctx_reservation_complete(struct ieee80211_sub_if_data *sdata)
 }
 
 static void
-ieee80211_vif_update_chandef(struct ieee80211_sub_if_data *sdata,
-			     const struct cfg80211_chan_def *chandef)
+ieee80211_link_update_chandef(struct ieee80211_link_data *link,
+			      const struct cfg80211_chan_def *chandef)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
+	unsigned int link_id = link->link_id;
 	struct ieee80211_sub_if_data *vlan;
 
-	sdata->vif.bss_conf.chandef = *chandef;
+	sdata->vif.link_conf[link_id]->chandef = *chandef;
 
 	if (sdata->vif.type != NL80211_IFTYPE_AP)
 		return;
 
 	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list)
-		vlan->vif.bss_conf.chandef = *chandef;
+		vlan->vif.link_conf[link_id]->chandef = *chandef;
 }
 
 static int
-ieee80211_vif_use_reserved_reassign(struct ieee80211_sub_if_data *sdata)
+ieee80211_link_use_reserved_reassign(struct ieee80211_link_data *link)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
+	unsigned int link_id = link->link_id;
+	struct ieee80211_bss_conf *link_conf = sdata->vif.link_conf[link_id];
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_vif_chanctx_switch vif_chsw[1] = {};
 	struct ieee80211_chanctx *old_ctx, *new_ctx;
@@ -1127,10 +1226,10 @@ ieee80211_vif_use_reserved_reassign(struct ieee80211_sub_if_data *sdata)
 	lockdep_assert_held(&local->mtx);
 	lockdep_assert_held(&local->chanctx_mtx);
 
-	new_ctx = sdata->deflink.reserved_chanctx;
-	old_ctx = ieee80211_vif_get_chanctx(sdata);
+	new_ctx = link->reserved_chanctx;
+	old_ctx = ieee80211_link_get_chanctx(link);
 
-	if (WARN_ON(!sdata->deflink.reserved_ready))
+	if (WARN_ON(!link->reserved_ready))
 		return -EBUSY;
 
 	if (WARN_ON(!new_ctx))
@@ -1144,23 +1243,24 @@ ieee80211_vif_use_reserved_reassign(struct ieee80211_sub_if_data *sdata)
 		return -EINVAL;
 
 	chandef = ieee80211_chanctx_non_reserved_chandef(local, new_ctx,
-				&sdata->deflink.reserved_chandef);
+				&link->reserved_chandef);
 	if (WARN_ON(!chandef))
 		return -EINVAL;
 
-	if (sdata->vif.bss_conf.chandef.width != sdata->deflink.reserved_chandef.width)
+	if (link_conf->chandef.width != link->reserved_chandef.width)
 		changed = BSS_CHANGED_BANDWIDTH;
 
-	ieee80211_vif_update_chandef(sdata, &sdata->deflink.reserved_chandef);
+	ieee80211_link_update_chandef(link, &link->reserved_chandef);
 
 	ieee80211_change_chanctx(local, new_ctx, old_ctx, chandef);
 
 	vif_chsw[0].vif = &sdata->vif;
 	vif_chsw[0].old_ctx = &old_ctx->conf;
 	vif_chsw[0].new_ctx = &new_ctx->conf;
+	vif_chsw[0].link_id = link->link_id;
 
-	list_del(&sdata->reserved_chanctx_list);
-	sdata->deflink.reserved_chanctx = NULL;
+	list_del(&link->reserved_chanctx_list);
+	link->reserved_chanctx = NULL;
 
 	err = drv_switch_vif_chanctx(local, vif_chsw, 1,
 				     CHANCTX_SWMODE_REASSIGN_VIF);
@@ -1171,11 +1271,11 @@ ieee80211_vif_use_reserved_reassign(struct ieee80211_sub_if_data *sdata)
 		goto out;
 	}
 
-	list_move(&sdata->assigned_chanctx_list, &new_ctx->assigned_vifs);
-	rcu_assign_pointer(sdata->vif.bss_conf.chanctx_conf, &new_ctx->conf);
+	list_move(&link->assigned_chanctx_list, &new_ctx->assigned_links);
+	rcu_assign_pointer(link_conf->chanctx_conf, &new_ctx->conf);
 
 	if (sdata->vif.type == NL80211_IFTYPE_AP)
-		__ieee80211_vif_copy_chanctx_to_vlans(sdata, false);
+		__ieee80211_link_copy_chanctx_to_vlans(link, false);
 
 	ieee80211_check_fast_xmit_iface(sdata);
 
@@ -1187,25 +1287,27 @@ ieee80211_vif_use_reserved_reassign(struct ieee80211_sub_if_data *sdata)
 	ieee80211_recalc_radar_chanctx(local, new_ctx);
 
 	if (changed)
-		ieee80211_link_info_change_notify(sdata, 0, changed);
+		ieee80211_link_info_change_notify(sdata, link_id, changed);
 
 out:
-	ieee80211_vif_chanctx_reservation_complete(sdata);
+	ieee80211_link_chanctx_reservation_complete(link);
 	return err;
 }
 
 static int
-ieee80211_vif_use_reserved_assign(struct ieee80211_sub_if_data *sdata)
+ieee80211_link_use_reserved_assign(struct ieee80211_link_data *link)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
+	unsigned int link_id = link->link_id;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx *old_ctx, *new_ctx;
 	const struct cfg80211_chan_def *chandef;
 	int err;
 
-	old_ctx = ieee80211_vif_get_chanctx(sdata);
-	new_ctx = sdata->deflink.reserved_chanctx;
+	old_ctx = ieee80211_vif_get_chanctx(sdata, link_id);
+	new_ctx = link->reserved_chanctx;
 
-	if (WARN_ON(!sdata->deflink.reserved_ready))
+	if (WARN_ON(!link->reserved_ready))
 		return -EINVAL;
 
 	if (WARN_ON(old_ctx))
@@ -1219,16 +1321,16 @@ ieee80211_vif_use_reserved_assign(struct ieee80211_sub_if_data *sdata)
 		return -EINVAL;
 
 	chandef = ieee80211_chanctx_non_reserved_chandef(local, new_ctx,
-				&sdata->deflink.reserved_chandef);
+				&link->reserved_chandef);
 	if (WARN_ON(!chandef))
 		return -EINVAL;
 
 	ieee80211_change_chanctx(local, new_ctx, new_ctx, chandef);
 
-	list_del(&sdata->reserved_chanctx_list);
-	sdata->deflink.reserved_chanctx = NULL;
+	list_del(&link->reserved_chanctx_list);
+	link->reserved_chanctx = NULL;
 
-	err = ieee80211_assign_vif_chanctx(sdata, new_ctx);
+	err = ieee80211_assign_link_chanctx(link, new_ctx);
 	if (err) {
 		if (ieee80211_chanctx_refcount(local, new_ctx) == 0)
 			ieee80211_free_chanctx(local, new_ctx);
@@ -1237,19 +1339,20 @@ ieee80211_vif_use_reserved_assign(struct ieee80211_sub_if_data *sdata)
 	}
 
 out:
-	ieee80211_vif_chanctx_reservation_complete(sdata);
+	ieee80211_link_chanctx_reservation_complete(link);
 	return err;
 }
 
 static bool
-ieee80211_vif_has_in_place_reservation(struct ieee80211_sub_if_data *sdata)
+ieee80211_link_has_in_place_reservation(struct ieee80211_link_data *link)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_chanctx *old_ctx, *new_ctx;
 
 	lockdep_assert_held(&sdata->local->chanctx_mtx);
 
-	new_ctx = sdata->deflink.reserved_chanctx;
-	old_ctx = ieee80211_vif_get_chanctx(sdata);
+	new_ctx = link->reserved_chanctx;
+	old_ctx = ieee80211_link_get_chanctx(link);
 
 	if (!old_ctx)
 		return false;
@@ -1289,7 +1392,7 @@ static int ieee80211_chsw_switch_vifs(struct ieee80211_local *local,
 				      int n_vifs)
 {
 	struct ieee80211_vif_chanctx_switch *vif_chsw;
-	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_link_data *link;
 	struct ieee80211_chanctx *ctx, *old_ctx;
 	int i, err;
 
@@ -1310,16 +1413,16 @@ static int ieee80211_chsw_switch_vifs(struct ieee80211_local *local,
 			goto out;
 		}
 
-		list_for_each_entry(sdata, &ctx->reserved_vifs,
+		list_for_each_entry(link, &ctx->reserved_links,
 				    reserved_chanctx_list) {
-			if (!ieee80211_vif_has_in_place_reservation(
-					sdata))
+			if (!ieee80211_link_has_in_place_reservation(link))
 				continue;
 
-			old_ctx = ieee80211_vif_get_chanctx(sdata);
-			vif_chsw[i].vif = &sdata->vif;
+			old_ctx = ieee80211_link_get_chanctx(link);
+			vif_chsw[i].vif = &link->sdata->vif;
 			vif_chsw[i].old_ctx = &old_ctx->conf;
 			vif_chsw[i].new_ctx = &ctx->conf;
+			vif_chsw[i].link_id = link->link_id;
 
 			i++;
 		}
@@ -1345,7 +1448,7 @@ static int ieee80211_chsw_switch_ctxs(struct ieee80211_local *local)
 		if (ctx->replace_state != IEEE80211_CHANCTX_REPLACES_OTHER)
 			continue;
 
-		if (!list_empty(&ctx->replace_ctx->assigned_vifs))
+		if (!list_empty(&ctx->replace_ctx->assigned_links))
 			continue;
 
 		ieee80211_del_chanctx(local, ctx->replace_ctx);
@@ -1362,7 +1465,7 @@ static int ieee80211_chsw_switch_ctxs(struct ieee80211_local *local)
 		if (ctx->replace_state != IEEE80211_CHANCTX_REPLACES_OTHER)
 			continue;
 
-		if (!list_empty(&ctx->replace_ctx->assigned_vifs))
+		if (!list_empty(&ctx->replace_ctx->assigned_links))
 			continue;
 
 		ieee80211_del_chanctx(local, ctx);
@@ -1374,7 +1477,6 @@ static int ieee80211_chsw_switch_ctxs(struct ieee80211_local *local)
 
 static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 {
-	struct ieee80211_sub_if_data *sdata, *sdata_tmp;
 	struct ieee80211_chanctx *ctx, *ctx_tmp, *old_ctx;
 	struct ieee80211_chanctx *new_ctx = NULL;
 	int err, n_assigned, n_reserved, n_ready;
@@ -1400,6 +1502,8 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 	 */
 
 	list_for_each_entry(ctx, &local->chanctx_list, list) {
+		struct ieee80211_link_data *link;
+
 		if (ctx->replace_state != IEEE80211_CHANCTX_REPLACES_OTHER)
 			continue;
 
@@ -1417,12 +1521,12 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		n_reserved = 0;
 		n_ready = 0;
 
-		list_for_each_entry(sdata, &ctx->replace_ctx->assigned_vifs,
+		list_for_each_entry(link, &ctx->replace_ctx->assigned_links,
 				    assigned_chanctx_list) {
 			n_assigned++;
-			if (sdata->deflink.reserved_chanctx) {
+			if (link->reserved_chanctx) {
 				n_reserved++;
-				if (sdata->deflink.reserved_ready)
+				if (link->reserved_ready)
 					n_ready++;
 			}
 		}
@@ -1439,13 +1543,13 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		}
 
 		ctx->conf.radar_enabled = false;
-		list_for_each_entry(sdata, &ctx->reserved_vifs,
+		list_for_each_entry(link, &ctx->reserved_links,
 				    reserved_chanctx_list) {
-			if (ieee80211_vif_has_in_place_reservation(sdata) &&
-			    !sdata->deflink.reserved_ready)
+			if (ieee80211_link_has_in_place_reservation(link) &&
+			    !link->reserved_ready)
 				return -EAGAIN;
 
-			old_ctx = ieee80211_vif_get_chanctx(sdata);
+			old_ctx = ieee80211_link_get_chanctx(link);
 			if (old_ctx) {
 				if (old_ctx->replace_state ==
 				    IEEE80211_CHANCTX_WILL_BE_REPLACED)
@@ -1456,7 +1560,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 				n_vifs_ctxless++;
 			}
 
-			if (sdata->deflink.reserved_radar_required)
+			if (link->reserved_radar_required)
 				ctx->conf.radar_enabled = true;
 		}
 	}
@@ -1499,6 +1603,8 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 	 * context(s).
 	 */
 	list_for_each_entry(ctx, &local->chanctx_list, list) {
+		struct ieee80211_link_data *link, *link_tmp;
+
 		if (ctx->replace_state != IEEE80211_CHANCTX_REPLACES_OTHER)
 			continue;
 
@@ -1507,32 +1613,34 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 			goto err;
 		}
 
-		list_for_each_entry(sdata, &ctx->reserved_vifs,
+		list_for_each_entry(link, &ctx->reserved_links,
 				    reserved_chanctx_list) {
+			struct ieee80211_sub_if_data *sdata = link->sdata;
+			struct ieee80211_bss_conf *link_conf =
+				sdata->vif.link_conf[link->link_id];
 			u32 changed = 0;
 
-			if (!ieee80211_vif_has_in_place_reservation(sdata))
+			if (!ieee80211_link_has_in_place_reservation(link))
 				continue;
 
-			rcu_assign_pointer(sdata->vif.bss_conf.chanctx_conf,
+			rcu_assign_pointer(link_conf->chanctx_conf,
 					   &ctx->conf);
 
 			if (sdata->vif.type == NL80211_IFTYPE_AP)
-				__ieee80211_vif_copy_chanctx_to_vlans(sdata,
-								      false);
+				__ieee80211_link_copy_chanctx_to_vlans(link,
+								       false);
 
 			ieee80211_check_fast_xmit_iface(sdata);
 
-			sdata->deflink.radar_required = sdata->deflink.reserved_radar_required;
+			link->radar_required = link->reserved_radar_required;
 
-			if (sdata->vif.bss_conf.chandef.width !=
-			    sdata->deflink.reserved_chandef.width)
+			if (link_conf->chandef.width != link->reserved_chandef.width)
 				changed = BSS_CHANGED_BANDWIDTH;
 
-			ieee80211_vif_update_chandef(sdata,
-						     &sdata->deflink.reserved_chandef);
+			ieee80211_link_update_chandef(link, &link->reserved_chandef);
 			if (changed)
-				ieee80211_link_info_change_notify(sdata, 0,
+				ieee80211_link_info_change_notify(sdata,
+								  link->link_id,
 								  changed);
 
 			ieee80211_recalc_txpower(sdata, false);
@@ -1543,17 +1651,17 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		ieee80211_recalc_radar_chanctx(local, ctx);
 		ieee80211_recalc_chanctx_min_def(local, ctx);
 
-		list_for_each_entry_safe(sdata, sdata_tmp, &ctx->reserved_vifs,
+		list_for_each_entry_safe(link, link_tmp, &ctx->reserved_links,
 					 reserved_chanctx_list) {
-			if (ieee80211_vif_get_chanctx(sdata) != ctx)
+			if (ieee80211_link_get_chanctx(link) != ctx)
 				continue;
 
-			list_del(&sdata->reserved_chanctx_list);
-			list_move(&sdata->assigned_chanctx_list,
-				  &ctx->assigned_vifs);
-			sdata->deflink.reserved_chanctx = NULL;
+			list_del(&link->reserved_chanctx_list);
+			list_move(&link->assigned_chanctx_list,
+				  &ctx->assigned_links);
+			link->reserved_chanctx = NULL;
 
-			ieee80211_vif_chanctx_reservation_complete(sdata);
+			ieee80211_link_chanctx_reservation_complete(link);
 		}
 
 		/*
@@ -1563,31 +1671,29 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		 * reservation for originally requested interface has already
 		 * succeeded at this point.
 		 */
-		list_for_each_entry_safe(sdata, sdata_tmp, &ctx->reserved_vifs,
+		list_for_each_entry_safe(link, link_tmp, &ctx->reserved_links,
 					 reserved_chanctx_list) {
-			if (WARN_ON(ieee80211_vif_has_in_place_reservation(
-					sdata)))
+			if (WARN_ON(ieee80211_link_has_in_place_reservation(link)))
 				continue;
 
-			if (WARN_ON(sdata->deflink.reserved_chanctx != ctx))
+			if (WARN_ON(link->reserved_chanctx != ctx))
 				continue;
 
-			if (!sdata->deflink.reserved_ready)
+			if (!link->reserved_ready)
 				continue;
 
-			if (ieee80211_vif_get_chanctx(sdata))
-				err = ieee80211_vif_use_reserved_reassign(
-						sdata);
+			if (ieee80211_link_get_chanctx(link))
+				err = ieee80211_link_use_reserved_reassign(link);
 			else
-				err = ieee80211_vif_use_reserved_assign(sdata);
+				err = ieee80211_link_use_reserved_assign(link);
 
 			if (err) {
-				sdata_info(sdata,
-					   "failed to finalize (re-)assign reservation (err=%d)\n",
-					   err);
-				ieee80211_vif_unreserve_chanctx(sdata);
+				link_info(link,
+					  "failed to finalize (re-)assign reservation (err=%d)\n",
+					  err);
+				ieee80211_link_unreserve_chanctx(link);
 				cfg80211_stop_iface(local->hw.wiphy,
-						    &sdata->wdev,
+						    &link->sdata->wdev,
 						    GFP_KERNEL);
 			}
 		}
@@ -1613,21 +1719,26 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 
 err:
 	list_for_each_entry(ctx, &local->chanctx_list, list) {
+		struct ieee80211_link_data *link, *link_tmp;
+
 		if (ctx->replace_state != IEEE80211_CHANCTX_REPLACES_OTHER)
 			continue;
 
-		list_for_each_entry_safe(sdata, sdata_tmp, &ctx->reserved_vifs,
+		list_for_each_entry_safe(link, link_tmp, &ctx->reserved_links,
 					 reserved_chanctx_list) {
-			ieee80211_vif_unreserve_chanctx(sdata);
-			ieee80211_vif_chanctx_reservation_complete(sdata);
+			ieee80211_link_unreserve_chanctx(link);
+			ieee80211_link_chanctx_reservation_complete(link);
 		}
 	}
 
 	return err;
 }
 
-static void __ieee80211_vif_release_channel(struct ieee80211_sub_if_data *sdata)
+static void __ieee80211_link_release_channel(struct ieee80211_link_data *link)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
+	unsigned int link_id = link->link_id;
+	struct ieee80211_bss_conf *link_conf = sdata->vif.link_conf[link_id];
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx_conf *conf;
 	struct ieee80211_chanctx *ctx;
@@ -1635,38 +1746,38 @@ static void __ieee80211_vif_release_channel(struct ieee80211_sub_if_data *sdata)
 
 	lockdep_assert_held(&local->chanctx_mtx);
 
-	conf = rcu_dereference_protected(sdata->vif.bss_conf.chanctx_conf,
+	conf = rcu_dereference_protected(link_conf->chanctx_conf,
 					 lockdep_is_held(&local->chanctx_mtx));
 	if (!conf)
 		return;
 
 	ctx = container_of(conf, struct ieee80211_chanctx, conf);
 
-	if (sdata->deflink.reserved_chanctx) {
-		if (sdata->deflink.reserved_chanctx->replace_state ==
-		    IEEE80211_CHANCTX_REPLACES_OTHER &&
-		    ieee80211_chanctx_num_reserved(local,
-						   sdata->deflink.reserved_chanctx) > 1)
+	if (link->reserved_chanctx) {
+		if (link->reserved_chanctx->replace_state == IEEE80211_CHANCTX_REPLACES_OTHER &&
+		    ieee80211_chanctx_num_reserved(local, link->reserved_chanctx) > 1)
 			use_reserved_switch = true;
 
-		ieee80211_vif_unreserve_chanctx(sdata);
+		ieee80211_link_unreserve_chanctx(link);
 	}
 
-	ieee80211_assign_vif_chanctx(sdata, NULL);
+	ieee80211_assign_link_chanctx(link, NULL);
 	if (ieee80211_chanctx_refcount(local, ctx) == 0)
 		ieee80211_free_chanctx(local, ctx);
 
-	sdata->deflink.radar_required = false;
+	link->radar_required = false;
 
 	/* Unreserving may ready an in-place reservation. */
 	if (use_reserved_switch)
 		ieee80211_vif_use_reserved_switch(local);
 }
 
-int ieee80211_vif_use_channel(struct ieee80211_sub_if_data *sdata,
-			      const struct cfg80211_chan_def *chandef,
-			      enum ieee80211_chanctx_mode mode)
+int ieee80211_link_use_channel(struct ieee80211_link_data *link,
+			       const struct cfg80211_chan_def *chandef,
+			       enum ieee80211_chanctx_mode mode)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
+	unsigned int link_id = link->link_id;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx *ctx;
 	u8 radar_detect_width = 0;
@@ -1686,14 +1797,14 @@ int ieee80211_vif_use_channel(struct ieee80211_sub_if_data *sdata,
 	if (ret > 0)
 		radar_detect_width = BIT(chandef->width);
 
-	sdata->deflink.radar_required = ret;
+	sdata->link[link_id]->radar_required = ret;
 
 	ret = ieee80211_check_combinations(sdata, chandef, mode,
 					   radar_detect_width);
 	if (ret < 0)
 		goto out;
 
-	__ieee80211_vif_release_channel(sdata);
+	__ieee80211_link_release_channel(link);
 
 	ctx = ieee80211_find_chanctx(local, chandef, mode);
 	if (!ctx)
@@ -1703,9 +1814,9 @@ int ieee80211_vif_use_channel(struct ieee80211_sub_if_data *sdata,
 		goto out;
 	}
 
-	ieee80211_vif_update_chandef(sdata, chandef);
+	ieee80211_link_update_chandef(link, chandef);
 
-	ret = ieee80211_assign_vif_chanctx(sdata, ctx);
+	ret = ieee80211_assign_link_chanctx(link, ctx);
 	if (ret) {
 		/* if assign fails refcount stays the same */
 		if (ieee80211_chanctx_refcount(local, ctx) == 0)
@@ -1717,14 +1828,15 @@ int ieee80211_vif_use_channel(struct ieee80211_sub_if_data *sdata,
 	ieee80211_recalc_radar_chanctx(local, ctx);
  out:
 	if (ret)
-		sdata->deflink.radar_required = false;
+		link->radar_required = false;
 
 	mutex_unlock(&local->chanctx_mtx);
 	return ret;
 }
 
-int ieee80211_vif_use_reserved_context(struct ieee80211_sub_if_data *sdata)
+int ieee80211_link_use_reserved_context(struct ieee80211_link_data *link)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx *new_ctx;
 	struct ieee80211_chanctx *old_ctx;
@@ -1733,8 +1845,8 @@ int ieee80211_vif_use_reserved_context(struct ieee80211_sub_if_data *sdata)
 	lockdep_assert_held(&local->mtx);
 	lockdep_assert_held(&local->chanctx_mtx);
 
-	new_ctx = sdata->deflink.reserved_chanctx;
-	old_ctx = ieee80211_vif_get_chanctx(sdata);
+	new_ctx = link->reserved_chanctx;
+	old_ctx = ieee80211_link_get_chanctx(link);
 
 	if (WARN_ON(!new_ctx))
 		return -EINVAL;
@@ -1743,16 +1855,16 @@ int ieee80211_vif_use_reserved_context(struct ieee80211_sub_if_data *sdata)
 		    IEEE80211_CHANCTX_WILL_BE_REPLACED))
 		return -EINVAL;
 
-	if (WARN_ON(sdata->deflink.reserved_ready))
+	if (WARN_ON(link->reserved_ready))
 		return -EINVAL;
 
-	sdata->deflink.reserved_ready = true;
+	link->reserved_ready = true;
 
 	if (new_ctx->replace_state == IEEE80211_CHANCTX_REPLACE_NONE) {
 		if (old_ctx)
-			return ieee80211_vif_use_reserved_reassign(sdata);
+			return ieee80211_link_use_reserved_reassign(link);
 
-		return ieee80211_vif_use_reserved_assign(sdata);
+		return ieee80211_link_use_reserved_assign(link);
 	}
 
 	/*
@@ -1784,10 +1896,13 @@ int ieee80211_vif_use_reserved_context(struct ieee80211_sub_if_data *sdata)
 	return 0;
 }
 
-int ieee80211_vif_change_bandwidth(struct ieee80211_sub_if_data *sdata,
-				   const struct cfg80211_chan_def *chandef,
-				   u32 *changed)
+int ieee80211_link_change_bandwidth(struct ieee80211_link_data *link,
+				    const struct cfg80211_chan_def *chandef,
+				    u32 *changed)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
+	unsigned int link_id = link->link_id;
+	struct ieee80211_bss_conf *link_conf = sdata->vif.link_conf[link_id];
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx_conf *conf;
 	struct ieee80211_chanctx *ctx;
@@ -1799,18 +1914,18 @@ int ieee80211_vif_change_bandwidth(struct ieee80211_sub_if_data *sdata,
 		return -EINVAL;
 
 	mutex_lock(&local->chanctx_mtx);
-	if (cfg80211_chandef_identical(chandef, &sdata->vif.bss_conf.chandef)) {
+	if (cfg80211_chandef_identical(chandef, &link_conf->chandef)) {
 		ret = 0;
 		goto out;
 	}
 
 	if (chandef->width == NL80211_CHAN_WIDTH_20_NOHT ||
-	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT) {
+	    link_conf->chandef.width == NL80211_CHAN_WIDTH_20_NOHT) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	conf = rcu_dereference_protected(sdata->vif.bss_conf.chanctx_conf,
+	conf = rcu_dereference_protected(link_conf->chanctx_conf,
 					 lockdep_is_held(&local->chanctx_mtx));
 	if (!conf) {
 		ret = -EINVAL;
@@ -1845,7 +1960,7 @@ int ieee80211_vif_change_bandwidth(struct ieee80211_sub_if_data *sdata,
 		break;
 	}
 
-	ieee80211_vif_update_chandef(sdata, chandef);
+	ieee80211_link_update_chandef(link, chandef);
 
 	ieee80211_recalc_chanctx_chantype(local, ctx);
 
@@ -1856,19 +1971,24 @@ int ieee80211_vif_change_bandwidth(struct ieee80211_sub_if_data *sdata,
 	return ret;
 }
 
-void ieee80211_vif_release_channel(struct ieee80211_sub_if_data *sdata)
+void ieee80211_link_release_channel(struct ieee80211_link_data *link)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
+
 	WARN_ON(sdata->dev && netif_carrier_ok(sdata->dev));
 
 	lockdep_assert_held(&sdata->local->mtx);
 
 	mutex_lock(&sdata->local->chanctx_mtx);
-	__ieee80211_vif_release_channel(sdata);
+	__ieee80211_link_release_channel(link);
 	mutex_unlock(&sdata->local->chanctx_mtx);
 }
 
-void ieee80211_vif_vlan_copy_chanctx(struct ieee80211_sub_if_data *sdata)
+void ieee80211_link_vlan_copy_chanctx(struct ieee80211_link_data *link)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
+	unsigned int link_id = link->link_id;
+	struct ieee80211_bss_conf *link_conf = sdata->vif.link_conf[link_id];
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_sub_if_data *ap;
 	struct ieee80211_chanctx_conf *conf;
@@ -1880,9 +2000,9 @@ void ieee80211_vif_vlan_copy_chanctx(struct ieee80211_sub_if_data *sdata)
 
 	mutex_lock(&local->chanctx_mtx);
 
-	conf = rcu_dereference_protected(ap->vif.bss_conf.chanctx_conf,
+	conf = rcu_dereference_protected(ap->vif.link_conf[link_id]->chanctx_conf,
 					 lockdep_is_held(&local->chanctx_mtx));
-	rcu_assign_pointer(sdata->vif.bss_conf.chanctx_conf, conf);
+	rcu_assign_pointer(link_conf->chanctx_conf, conf);
 	mutex_unlock(&local->chanctx_mtx);
 }
 
diff --git a/net/mac80211/debug.h b/net/mac80211/debug.h
index d90a8f9cc3fd..3302e8da0314 100644
--- a/net/mac80211/debug.h
+++ b/net/mac80211/debug.h
@@ -1,4 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Portions
+ * Copyright (C) 2022 Intel Corporation
+ */
 #ifndef __MAC80211_DEBUG_H
 #define __MAC80211_DEBUG_H
 #include <net/cfg80211.h>
@@ -130,6 +134,16 @@ do {									\
 #define sdata_dbg(sdata, fmt, ...)					\
 	_sdata_dbg(1, sdata, fmt, ##__VA_ARGS__)
 
+#define link_info(link, fmt, ...)					\
+	_sdata_info((link)->sdata, "[link %d] " fmt, (link)->link_id,	\
+		    ##__VA_ARGS__)
+#define link_err(link, fmt, ...)					\
+	_sdata_err((link)->sdata, "[link %d] " fmt, (link)->link_id,	\
+		   ##__VA_ARGS__)
+#define link_dbg(link, fmt, ...)					\
+	_sdata_dbg(1, (link)->sdata, "[link %d] " fmt, (link)->link_id,	\
+		   ##__VA_ARGS__)
+
 #define ht_dbg(sdata, fmt, ...)						\
 	_sdata_dbg(MAC80211_HT_DEBUG,					\
 		   sdata, fmt, ##__VA_ARGS__)
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 15ab8d00815b..9238283a8237 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -938,6 +938,7 @@ static inline void drv_change_chanctx(struct ieee80211_local *local,
 
 static inline int drv_assign_vif_chanctx(struct ieee80211_local *local,
 					 struct ieee80211_sub_if_data *sdata,
+					 unsigned int link_id,
 					 struct ieee80211_chanctx *ctx)
 {
 	int ret = 0;
@@ -945,11 +946,12 @@ static inline int drv_assign_vif_chanctx(struct ieee80211_local *local,
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
 
-	trace_drv_assign_vif_chanctx(local, sdata, ctx);
+	trace_drv_assign_vif_chanctx(local, sdata, link_id, ctx);
 	if (local->ops->assign_vif_chanctx) {
 		WARN_ON_ONCE(!ctx->driver_present);
 		ret = local->ops->assign_vif_chanctx(&local->hw,
 						     &sdata->vif,
+						     link_id,
 						     &ctx->conf);
 	}
 	trace_drv_return_int(local, ret);
@@ -959,6 +961,7 @@ static inline int drv_assign_vif_chanctx(struct ieee80211_local *local,
 
 static inline void drv_unassign_vif_chanctx(struct ieee80211_local *local,
 					    struct ieee80211_sub_if_data *sdata,
+					    unsigned int link_id,
 					    struct ieee80211_chanctx *ctx)
 {
 	might_sleep();
@@ -966,11 +969,12 @@ static inline void drv_unassign_vif_chanctx(struct ieee80211_local *local,
 	if (!check_sdata_in_driver(sdata))
 		return;
 
-	trace_drv_unassign_vif_chanctx(local, sdata, ctx);
+	trace_drv_unassign_vif_chanctx(local, sdata, link_id, ctx);
 	if (local->ops->unassign_vif_chanctx) {
 		WARN_ON_ONCE(!ctx->driver_present);
 		local->ops->unassign_vif_chanctx(&local->hw,
 						 &sdata->vif,
+						 link_id,
 						 &ctx->conf);
 	}
 	trace_drv_return_void(local);
diff --git a/net/mac80211/eht.c b/net/mac80211/eht.c
index 96c9486bf2fe..2d9c6e845ce4 100644
--- a/net/mac80211/eht.c
+++ b/net/mac80211/eht.c
@@ -71,6 +71,6 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 
 	eht_cap->has_eht = true;
 
-	sta->deflink.cur_max_bandwidth = ieee80211_sta_cap_rx_bw(sta);
-	sta->sta.deflink.bandwidth = ieee80211_sta_cur_vht_bw(sta);
+	sta->deflink.cur_max_bandwidth = ieee80211_sta_cap_rx_bw(sta, 0);
+	sta->sta.deflink.bandwidth = ieee80211_sta_cur_vht_bw(sta, 0);
 }
diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index 1a61f7552edd..20448dda8c4d 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -3,7 +3,7 @@
  * HE handling
  *
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright(c) 2019 - 2020 Intel Corporation
+ * Copyright(c) 2019 - 2022 Intel Corporation
  */
 
 #include "ieee80211_i.h"
@@ -153,8 +153,8 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 
 	he_cap->has_he = true;
 
-	sta->deflink.cur_max_bandwidth = ieee80211_sta_cap_rx_bw(sta);
-	sta->sta.deflink.bandwidth = ieee80211_sta_cur_vht_bw(sta);
+	sta->deflink.cur_max_bandwidth = ieee80211_sta_cap_rx_bw(sta, 0);
+	sta->sta.deflink.bandwidth = ieee80211_sta_cur_vht_bw(sta, 0);
 
 	if (sband->band == NL80211_BAND_6GHZ && he_6ghz_capa)
 		ieee80211_update_from_he_6ghz_capa(he_6ghz_capa, sta);
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 3b68e9f4345b..2ca75f2d3023 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -301,8 +301,8 @@ static void __ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 	radar_required = err;
 
 	mutex_lock(&local->mtx);
-	if (ieee80211_vif_use_channel(sdata, &chandef,
-				      ifibss->fixed_channel ?
+	if (ieee80211_link_use_channel(sdata->link[0], &chandef,
+				       ifibss->fixed_channel ?
 					IEEE80211_CHANCTX_SHARED :
 					IEEE80211_CHANCTX_EXCLUSIVE)) {
 		sdata_info(sdata, "Failed to join IBSS, no channel context\n");
@@ -371,7 +371,7 @@ static void __ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 		RCU_INIT_POINTER(ifibss->presp, NULL);
 		kfree_rcu(presp, rcu_head);
 		mutex_lock(&local->mtx);
-		ieee80211_vif_release_channel(sdata);
+		ieee80211_link_release_channel(sdata->link[0]);
 		mutex_unlock(&local->mtx);
 		sdata_info(sdata, "Failed to join IBSS, driver failure: %d\n",
 			   err);
@@ -725,7 +725,7 @@ static void ieee80211_ibss_disconnect(struct ieee80211_sub_if_data *sdata)
 						BSS_CHANGED_IBSS);
 	drv_leave_ibss(local, sdata);
 	mutex_lock(&local->mtx);
-	ieee80211_vif_release_channel(sdata);
+	ieee80211_link_release_channel(sdata->link[0]);
 	mutex_unlock(&local->mtx);
 }
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 397b111f006d..92ed1e3c2980 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -787,8 +787,8 @@ struct ieee80211_chanctx {
 	struct list_head list;
 	struct rcu_head rcu_head;
 
-	struct list_head assigned_vifs;
-	struct list_head reserved_vifs;
+	struct list_head assigned_links;
+	struct list_head reserved_links;
 
 	enum ieee80211_chanctx_replace_state replace_state;
 	struct ieee80211_chanctx *replace_ctx;
@@ -909,6 +909,12 @@ struct ieee80211_link_data_ap {
 };
 
 struct ieee80211_link_data {
+	struct ieee80211_sub_if_data *sdata;
+	unsigned int link_id;
+
+	struct list_head assigned_chanctx_list; /* protected by chanctx_mtx */
+	struct list_head reserved_chanctx_list; /* protected by chanctx_mtx */
+
 	/* multicast keys only */
 	struct ieee80211_key __rcu *gtk[NUM_DEFAULT_KEYS +
 					NUM_DEFAULT_MGMT_KEYS +
@@ -989,9 +995,6 @@ struct ieee80211_sub_if_data {
 	struct ieee80211_tx_queue_params tx_conf[IEEE80211_NUM_ACS];
 	struct mac80211_qos_map __rcu *qos_map;
 
-	struct list_head assigned_chanctx_list; /* protected by chanctx_mtx */
-	struct list_head reserved_chanctx_list; /* protected by chanctx_mtx */
-
 	/* used to reconfigure hardware SM PS */
 	struct work_struct recalc_smps;
 
@@ -2119,8 +2122,10 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 				    struct ieee80211_supported_band *sband,
 				    const struct ieee80211_vht_cap *vht_cap_ie,
 				    struct sta_info *sta);
-enum ieee80211_sta_rx_bandwidth ieee80211_sta_cap_rx_bw(struct sta_info *sta);
-enum ieee80211_sta_rx_bandwidth ieee80211_sta_cur_vht_bw(struct sta_info *sta);
+enum ieee80211_sta_rx_bandwidth ieee80211_sta_cap_rx_bw(struct sta_info *sta,
+							unsigned int link_id);
+enum ieee80211_sta_rx_bandwidth ieee80211_sta_cur_vht_bw(struct sta_info *sta,
+							 unsigned int link_id);
 void ieee80211_sta_set_rx_nss(struct sta_info *sta);
 enum ieee80211_sta_rx_bandwidth
 ieee80211_chan_width_to_rx_bw(enum nl80211_chan_width width);
@@ -2470,26 +2475,26 @@ bool ieee80211_chandef_s1g_oper(const struct ieee80211_s1g_oper_ie *oper,
 u32 ieee80211_chandef_downgrade(struct cfg80211_chan_def *c);
 
 int __must_check
-ieee80211_vif_use_channel(struct ieee80211_sub_if_data *sdata,
-			  const struct cfg80211_chan_def *chandef,
-			  enum ieee80211_chanctx_mode mode);
+ieee80211_link_use_channel(struct ieee80211_link_data *link,
+			   const struct cfg80211_chan_def *chandef,
+			   enum ieee80211_chanctx_mode mode);
 int __must_check
-ieee80211_vif_reserve_chanctx(struct ieee80211_sub_if_data *sdata,
-			      const struct cfg80211_chan_def *chandef,
-			      enum ieee80211_chanctx_mode mode,
-			      bool radar_required);
+ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
+			       const struct cfg80211_chan_def *chandef,
+			       enum ieee80211_chanctx_mode mode,
+			       bool radar_required);
 int __must_check
-ieee80211_vif_use_reserved_context(struct ieee80211_sub_if_data *sdata);
-int ieee80211_vif_unreserve_chanctx(struct ieee80211_sub_if_data *sdata);
+ieee80211_link_use_reserved_context(struct ieee80211_link_data *link);
+int ieee80211_link_unreserve_chanctx(struct ieee80211_link_data *link);
 
 int __must_check
-ieee80211_vif_change_bandwidth(struct ieee80211_sub_if_data *sdata,
-			       const struct cfg80211_chan_def *chandef,
-			       u32 *changed);
-void ieee80211_vif_release_channel(struct ieee80211_sub_if_data *sdata);
-void ieee80211_vif_vlan_copy_chanctx(struct ieee80211_sub_if_data *sdata);
-void ieee80211_vif_copy_chanctx_to_vlans(struct ieee80211_sub_if_data *sdata,
-					 bool clear);
+ieee80211_link_change_bandwidth(struct ieee80211_link_data *link,
+				const struct cfg80211_chan_def *chandef,
+				u32 *changed);
+void ieee80211_link_release_channel(struct ieee80211_link_data *link);
+void ieee80211_link_vlan_copy_chanctx(struct ieee80211_link_data *link);
+void ieee80211_link_copy_chanctx_to_vlans(struct ieee80211_link_data *link,
+					  bool clear);
 int ieee80211_chanctx_refcount(struct ieee80211_local *local,
 			       struct ieee80211_chanctx *ctx);
 
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 04ee525394e9..1764068a18d1 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -471,7 +471,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 		chandef = sdata->vif.bss_conf.chandef;
 		WARN_ON(local->suspended);
 		mutex_lock(&local->mtx);
-		ieee80211_vif_release_channel(sdata);
+		ieee80211_link_release_channel(sdata->link[0]);
 		mutex_unlock(&local->mtx);
 		cfg80211_cac_event(sdata->dev, &chandef,
 				   NL80211_RADAR_CAC_ABORTED,
@@ -1027,6 +1027,7 @@ static void ieee80211_sdata_init(struct ieee80211_local *local,
 	 */
 	sdata->vif.link_conf[0] = &sdata->vif.bss_conf;
 	sdata->link[0] = &sdata->deflink;
+	sdata->deflink.sdata = sdata;
 }
 
 int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
@@ -1077,8 +1078,8 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 	mutex_unlock(&local->iflist_mtx);
 
 	mutex_lock(&local->mtx);
-	ret = ieee80211_vif_use_channel(sdata, &local->monitor_chandef,
-					IEEE80211_CHANCTX_EXCLUSIVE);
+	ret = ieee80211_link_use_channel(sdata->link[0], &local->monitor_chandef,
+					 IEEE80211_CHANCTX_EXCLUSIVE);
 	mutex_unlock(&local->mtx);
 	if (ret) {
 		mutex_lock(&local->iflist_mtx);
@@ -1122,7 +1123,7 @@ void ieee80211_del_virtual_monitor(struct ieee80211_local *local)
 	synchronize_net();
 
 	mutex_lock(&local->mtx);
-	ieee80211_vif_release_channel(sdata);
+	ieee80211_link_release_channel(sdata->link[0]);
 	mutex_unlock(&local->mtx);
 
 	drv_remove_interface(local, sdata);
@@ -1228,7 +1229,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	case NL80211_IFTYPE_AP_VLAN:
 		/* no need to tell driver, but set carrier and chanctx */
 		if (sdata->bss->active) {
-			ieee80211_vif_vlan_copy_chanctx(sdata);
+			ieee80211_link_vlan_copy_chanctx(sdata->link[0]);
 			netif_carrier_on(dev);
 			ieee80211_set_vif_encap_ops(sdata);
 		} else {
@@ -1681,8 +1682,8 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 		  ieee80211_csa_finalize_work);
 	INIT_WORK(&sdata->deflink.color_change_finalize_work,
 		  ieee80211_color_change_finalize_work);
-	INIT_LIST_HEAD(&sdata->assigned_chanctx_list);
-	INIT_LIST_HEAD(&sdata->reserved_chanctx_list);
+	INIT_LIST_HEAD(&sdata->deflink.assigned_chanctx_list);
+	INIT_LIST_HEAD(&sdata->deflink.reserved_chanctx_list);
 
 	switch (type) {
 	case NL80211_IFTYPE_P2P_GO:
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index 42ba7424589e..a6cb1db50f1d 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2008, 2009 open80211s Ltd.
- * Copyright (C) 2019, 2021 Intel Corporation
+ * Copyright (C) 2019, 2021-2022 Intel Corporation
  * Author:     Luis Carlos Cobo <luisca@cozybit.com>
  */
 #include <linux/gfp.h>
@@ -464,7 +464,7 @@ static void mesh_sta_info_init(struct ieee80211_sub_if_data *sdata,
 	if (!test_sta_flag(sta, WLAN_STA_RATE_CONTROL))
 		rate_control_rate_init(sta);
 	else
-		rate_control_rate_update(local, sband, sta, changed);
+		rate_control_rate_update(local, sband, sta, 0, changed);
 out:
 	spin_unlock_bh(&sta->mesh->plink_lock);
 }
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e172bdfe9b0a..ca9e0d83e2a4 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -479,7 +479,7 @@ static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 		return -EINVAL;
 	}
 
-	ret = ieee80211_vif_change_bandwidth(sdata, &chandef, changed);
+	ret = ieee80211_link_change_bandwidth(&sdata->deflink, &chandef, changed);
 
 	if (ret) {
 		sdata_info(sdata,
@@ -1248,7 +1248,7 @@ static void ieee80211_chswitch_work(struct work_struct *work)
 		if (sdata->deflink.reserved_ready)
 			goto out;
 
-		ret = ieee80211_vif_use_reserved_context(sdata);
+		ret = ieee80211_link_use_reserved_context(&sdata->deflink);
 		if (ret) {
 			sdata_info(sdata,
 				   "failed to use reserved channel context, disconnecting (err=%d)\n",
@@ -1354,7 +1354,7 @@ ieee80211_sta_abort_chanswitch(struct ieee80211_sub_if_data *sdata)
 	mutex_lock(&local->mtx);
 
 	mutex_lock(&local->chanctx_mtx);
-	ieee80211_vif_unreserve_chanctx(sdata);
+	ieee80211_link_unreserve_chanctx(&sdata->deflink);
 	mutex_unlock(&local->chanctx_mtx);
 
 	if (sdata->deflink.csa_block_tx)
@@ -1496,8 +1496,8 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 		goto drop_connection;
 	}
 
-	res = ieee80211_vif_reserve_chanctx(sdata, &csa_ie.chandef,
-					    chanctx->mode, false);
+	res = ieee80211_link_reserve_chanctx(&sdata->deflink, &csa_ie.chandef,
+					     chanctx->mode, false);
 	if (res) {
 		sdata_info(sdata,
 			   "failed to reserve channel context for channel switch, disconnecting (err=%d)\n",
@@ -1942,7 +1942,7 @@ void ieee80211_dfs_cac_timer_work(struct work_struct *work)
 
 	mutex_lock(&sdata->local->mtx);
 	if (sdata->wdev.cac_started) {
-		ieee80211_vif_release_channel(sdata);
+		ieee80211_link_release_channel(&sdata->deflink);
 		cfg80211_cac_event(sdata->dev, &chandef,
 				   NL80211_RADAR_CAC_FINISHED,
 				   GFP_KERNEL);
@@ -2483,7 +2483,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 
 	ifmgd->flags = 0;
 	mutex_lock(&local->mtx);
-	ieee80211_vif_release_channel(sdata);
+	ieee80211_link_release_channel(&sdata->deflink);
 
 	sdata->vif.bss_conf.csa_active = false;
 	sdata->deflink.u.mgd.csa_waiting_bcn = false;
@@ -2923,7 +2923,7 @@ static void ieee80211_destroy_auth_data(struct ieee80211_sub_if_data *sdata,
 		ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_BSSID);
 		sdata->u.mgd.flags = 0;
 		mutex_lock(&sdata->local->mtx);
-		ieee80211_vif_release_channel(sdata);
+		ieee80211_link_release_channel(&sdata->deflink);
 		mutex_unlock(&sdata->local->mtx);
 	}
 
@@ -2954,7 +2954,7 @@ static void ieee80211_destroy_assoc_data(struct ieee80211_sub_if_data *sdata,
 		sdata->vif.bss_conf.mu_mimo_owner = false;
 
 		mutex_lock(&sdata->local->mtx);
-		ieee80211_vif_release_channel(sdata);
+		ieee80211_link_release_channel(&sdata->deflink);
 		mutex_unlock(&sdata->local->mtx);
 
 		if (abandon)
@@ -5497,8 +5497,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	 * on incompatible channels, e.g. 80+80 and 160 sharing the
 	 * same control channel) try to use a smaller bandwidth.
 	 */
-	ret = ieee80211_vif_use_channel(sdata, &chandef,
-					IEEE80211_CHANCTX_SHARED);
+	ret = ieee80211_link_use_channel(&sdata->deflink, &chandef,
+					 IEEE80211_CHANCTX_SHARED);
 
 	/* don't downgrade for 5 and 10 MHz channels, though. */
 	if (chandef.width == NL80211_CHAN_WIDTH_5 ||
@@ -5507,8 +5507,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 
 	while (ret && chandef.width != NL80211_CHAN_WIDTH_20_NOHT) {
 		ifmgd->flags |= ieee80211_chandef_downgrade(&chandef);
-		ret = ieee80211_vif_use_channel(sdata, &chandef,
-						IEEE80211_CHANCTX_SHARED);
+		ret = ieee80211_link_use_channel(&sdata->deflink, &chandef,
+						 IEEE80211_CHANCTX_SHARED);
 	}
  out:
 	mutex_unlock(&local->mtx);
@@ -5868,7 +5868,7 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_BSSID);
 	ifmgd->auth_data = NULL;
 	mutex_lock(&sdata->local->mtx);
-	ieee80211_vif_release_channel(sdata);
+	ieee80211_link_release_channel(&sdata->deflink);
 	mutex_unlock(&sdata->local->mtx);
 	kfree(auth_data);
 	return err;
diff --git a/net/mac80211/ocb.c b/net/mac80211/ocb.c
index ab2658ad73ce..468c741a9aeb 100644
--- a/net/mac80211/ocb.c
+++ b/net/mac80211/ocb.c
@@ -186,8 +186,8 @@ int ieee80211_ocb_join(struct ieee80211_sub_if_data *sdata,
 	sdata->deflink.needed_rx_chains = sdata->local->rx_chains;
 
 	mutex_lock(&sdata->local->mtx);
-	err = ieee80211_vif_use_channel(sdata, &setup->chandef,
-					IEEE80211_CHANCTX_SHARED);
+	err = ieee80211_link_use_channel(sdata->link[0], &setup->chandef,
+					 IEEE80211_CHANCTX_SHARED);
 	mutex_unlock(&sdata->local->mtx);
 	if (err)
 		return err;
@@ -229,7 +229,7 @@ int ieee80211_ocb_leave(struct ieee80211_sub_if_data *sdata)
 	ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_OCB);
 
 	mutex_lock(&sdata->local->mtx);
-	ieee80211_vif_release_channel(sdata);
+	ieee80211_link_release_channel(sdata->link[0]);
 	mutex_unlock(&sdata->local->mtx);
 
 	skb_queue_purge(&sdata->skb_queue);
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index f22381127948..b268088585eb 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -90,14 +90,17 @@ void rate_control_tx_status(struct ieee80211_local *local,
 }
 
 void rate_control_rate_update(struct ieee80211_local *local,
-				    struct ieee80211_supported_band *sband,
-				    struct sta_info *sta, u32 changed)
+			      struct ieee80211_supported_band *sband,
+			      struct sta_info *sta, unsigned int link_id,
+			      u32 changed)
 {
 	struct rate_control_ref *ref = local->rate_ctrl;
 	struct ieee80211_sta *ista = &sta->sta;
 	void *priv_sta = sta->rate_ctrl_priv;
 	struct ieee80211_chanctx_conf *chanctx_conf;
 
+	WARN_ON(link_id != 0);
+
 	if (ref && ref->ops->rate_update) {
 		rcu_read_lock();
 
@@ -113,6 +116,7 @@ void rate_control_rate_update(struct ieee80211_local *local,
 		spin_unlock_bh(&sta->rate_ctrl_lock);
 		rcu_read_unlock();
 	}
+
 	drv_sta_rc_update(local, sta->sdata, &sta->sta, changed);
 }
 
diff --git a/net/mac80211/rate.h b/net/mac80211/rate.h
index 79b44d3db171..fbc8bdb54c43 100644
--- a/net/mac80211/rate.h
+++ b/net/mac80211/rate.h
@@ -3,6 +3,7 @@
  * Copyright 2002-2005, Instant802 Networks, Inc.
  * Copyright 2005, Devicescape Software, Inc.
  * Copyright (c) 2006 Jiri Benc <jbenc@suse.cz>
+ * Copyright (C) 2022 Intel Corporation
  */
 
 #ifndef IEEE80211_RATE_H
@@ -31,8 +32,10 @@ void rate_control_tx_status(struct ieee80211_local *local,
 
 void rate_control_rate_init(struct sta_info *sta);
 void rate_control_rate_update(struct ieee80211_local *local,
-				    struct ieee80211_supported_band *sband,
-				    struct sta_info *sta, u32 changed);
+			      struct ieee80211_supported_band *sband,
+			      struct sta_info *sta,
+			      unsigned int link_id,
+			      u32 changed);
 
 static inline void *rate_control_alloc_sta(struct rate_control_ref *ref,
 					   struct sta_info *sta, gfp_t gfp)
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 21e7424f261a..1774d0f9feaa 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3369,7 +3369,7 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 
 			sband = rx->local->hw.wiphy->bands[status->band];
 
-			rate_control_rate_update(local, sband, rx->sta,
+			rate_control_rate_update(local, sband, rx->sta, 0,
 						 IEEE80211_RC_SMPS_CHANGED);
 			cfg80211_sta_opmode_change_notify(sdata->dev,
 							  rx->sta->addr,
@@ -3391,11 +3391,11 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 			if (chanwidth == IEEE80211_HT_CHANWIDTH_20MHZ)
 				max_bw = IEEE80211_STA_RX_BW_20;
 			else
-				max_bw = ieee80211_sta_cap_rx_bw(rx->sta);
+				max_bw = ieee80211_sta_cap_rx_bw(rx->sta, 0);
 
 			/* set cur_max_bandwidth and recalc sta bw */
 			rx->sta->deflink.cur_max_bandwidth = max_bw;
-			new_bw = ieee80211_sta_cur_vht_bw(rx->sta);
+			new_bw = ieee80211_sta_cur_vht_bw(rx->sta, 0);
 
 			if (rx->sta->sta.deflink.bandwidth == new_bw)
 				goto handled;
@@ -3406,7 +3406,7 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 				ieee80211_sta_rx_bw_to_chan_width(rx->sta);
 			sta_opmode.changed = STA_OPMODE_MAX_BW_CHANGED;
 
-			rate_control_rate_update(local, sband, rx->sta,
+			rate_control_rate_update(local, sband, rx->sta, 0,
 						 IEEE80211_RC_BW_CHANGED);
 			cfg80211_sta_opmode_change_notify(sdata->dev,
 							  rx->sta->addr,
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 11a3b950b490..86a13ef31ef1 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -1268,10 +1268,10 @@ static void iee80211_tdls_recalc_chanctx(struct ieee80211_sub_if_data *sdata,
 			enum ieee80211_sta_rx_bandwidth bw;
 
 			bw = ieee80211_chan_width_to_rx_bw(conf->def.width);
-			bw = min(bw, ieee80211_sta_cap_rx_bw(sta));
+			bw = min(bw, ieee80211_sta_cap_rx_bw(sta, 0));
 			if (bw != sta->sta.deflink.bandwidth) {
 				sta->sta.deflink.bandwidth = bw;
-				rate_control_rate_update(local, sband, sta,
+				rate_control_rate_update(local, sband, sta, 0,
 							 IEEE80211_RC_BW_CHANGED);
 				/*
 				 * if a TDLS peer BW was updated, we need to
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 7284f0bf8a99..5c941fe4d70a 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -1625,6 +1625,7 @@ struct trace_chandef_entry {
 
 struct trace_switch_entry {
 	struct trace_vif_entry vif;
+	unsigned int link_id;
 	struct trace_chandef_entry old_chandef;
 	struct trace_chandef_entry new_chandef;
 } __packed;
@@ -1664,6 +1665,7 @@ TRACE_EVENT(drv_switch_vif_chanctx,
 
 				SWITCH_ENTRY_ASSIGN(vif.vif_type, vif->type);
 				SWITCH_ENTRY_ASSIGN(vif.p2p, vif->p2p);
+				SWITCH_ENTRY_ASSIGN(link_id, link_id);
 				strncpy(local_vifs[i].vif.vif_name,
 					sdata->name,
 					sizeof(local_vifs[i].vif.vif_name));
@@ -1704,40 +1706,45 @@ TRACE_EVENT(drv_switch_vif_chanctx,
 DECLARE_EVENT_CLASS(local_sdata_chanctx,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
+		 unsigned int link_id,
 		 struct ieee80211_chanctx *ctx),
 
-	TP_ARGS(local, sdata, ctx),
+	TP_ARGS(local, sdata, link_id, ctx),
 
 	TP_STRUCT__entry(
 		LOCAL_ENTRY
 		VIF_ENTRY
 		CHANCTX_ENTRY
+		__field(unsigned int, link_id)
 	),
 
 	TP_fast_assign(
 		LOCAL_ASSIGN;
 		VIF_ASSIGN;
 		CHANCTX_ASSIGN;
+		__entry->link_id = link_id;
 	),
 
 	TP_printk(
-		LOCAL_PR_FMT VIF_PR_FMT CHANCTX_PR_FMT,
-		LOCAL_PR_ARG, VIF_PR_ARG, CHANCTX_PR_ARG
+		LOCAL_PR_FMT VIF_PR_FMT " link_id:%d" CHANCTX_PR_FMT,
+		LOCAL_PR_ARG, VIF_PR_ARG, __entry->link_id, CHANCTX_PR_ARG
 	)
 );
 
 DEFINE_EVENT(local_sdata_chanctx, drv_assign_vif_chanctx,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
+		 unsigned int link_id,
 		 struct ieee80211_chanctx *ctx),
-	TP_ARGS(local, sdata, ctx)
+	TP_ARGS(local, sdata, link_id, ctx)
 );
 
 DEFINE_EVENT(local_sdata_chanctx, drv_unassign_vif_chanctx,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
+		 unsigned int link_id,
 		 struct ieee80211_chanctx *ctx),
-	TP_ARGS(local, sdata, ctx)
+	TP_ARGS(local, sdata, link_id, ctx)
 );
 
 TRACE_EVENT(drv_start_ap,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 2a279dc3e457..4ec96170a679 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2255,7 +2255,8 @@ static void ieee80211_handle_reconfig_failure(struct ieee80211_local *local)
 }
 
 static void ieee80211_assign_chanctx(struct ieee80211_local *local,
-				     struct ieee80211_sub_if_data *sdata)
+				     struct ieee80211_sub_if_data *sdata,
+				     unsigned int link_id)
 {
 	struct ieee80211_chanctx_conf *conf;
 	struct ieee80211_chanctx *ctx;
@@ -2264,11 +2265,11 @@ static void ieee80211_assign_chanctx(struct ieee80211_local *local,
 		return;
 
 	mutex_lock(&local->chanctx_mtx);
-	conf = rcu_dereference_protected(sdata->vif.bss_conf.chanctx_conf,
+	conf = rcu_dereference_protected(sdata->vif.link_conf[link_id]->chanctx_conf,
 					 lockdep_is_held(&local->chanctx_mtx));
 	if (conf) {
 		ctx = container_of(conf, struct ieee80211_chanctx, conf);
-		drv_assign_vif_chanctx(local, sdata, ctx);
+		drv_assign_vif_chanctx(local, sdata, link_id, ctx);
 	}
 	mutex_unlock(&local->chanctx_mtx);
 }
@@ -2474,7 +2475,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		sdata = wiphy_dereference(local->hw.wiphy,
 					  local->monitor_sdata);
 		if (sdata && ieee80211_sdata_running(sdata))
-			ieee80211_assign_chanctx(local, sdata);
+			ieee80211_assign_chanctx(local, sdata, 0);
 	}
 
 	/* reconfigure hardware */
@@ -2484,12 +2485,16 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 
 	/* Finally also reconfigure all the BSS information */
 	list_for_each_entry(sdata, &local->interfaces, list) {
+		unsigned int link;
 		u32 changed;
 
 		if (!ieee80211_sdata_running(sdata))
 			continue;
 
-		ieee80211_assign_chanctx(local, sdata);
+		for (link = 0; link < ARRAY_SIZE(sdata->vif.link_conf); link++) {
+			if (sdata->vif.link_conf[link])
+				ieee80211_assign_chanctx(local, sdata, link);
+		}
 
 		switch (sdata->vif.type) {
 		case NL80211_IFTYPE_AP_VLAN:
@@ -3975,7 +3980,7 @@ void ieee80211_dfs_cac_cancel(struct ieee80211_local *local)
 
 		if (sdata->wdev.cac_started) {
 			chandef = sdata->vif.bss_conf.chandef;
-			ieee80211_vif_release_channel(sdata);
+			ieee80211_link_release_channel(sdata->link[0]);
 			cfg80211_cac_event(sdata->dev,
 					   &chandef,
 					   NL80211_RADAR_CAC_ABORTED,
@@ -4401,7 +4406,7 @@ void ieee80211_recalc_dtim(struct ieee80211_local *local,
 static u8 ieee80211_chanctx_radar_detect(struct ieee80211_local *local,
 					 struct ieee80211_chanctx *ctx)
 {
-	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_link_data *link;
 	u8 radar_detect = 0;
 
 	lockdep_assert_held(&local->chanctx_mtx);
@@ -4409,20 +4414,26 @@ static u8 ieee80211_chanctx_radar_detect(struct ieee80211_local *local,
 	if (WARN_ON(ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED))
 		return 0;
 
-	list_for_each_entry(sdata, &ctx->reserved_vifs, reserved_chanctx_list)
-		if (sdata->deflink.reserved_radar_required)
-			radar_detect |= BIT(sdata->deflink.reserved_chandef.width);
+	list_for_each_entry(link, &ctx->reserved_links, reserved_chanctx_list)
+		if (link->reserved_radar_required)
+			radar_detect |= BIT(link->reserved_chandef.width);
 
 	/*
 	 * An in-place reservation context should not have any assigned vifs
 	 * until it replaces the other context.
 	 */
 	WARN_ON(ctx->replace_state == IEEE80211_CHANCTX_REPLACES_OTHER &&
-		!list_empty(&ctx->assigned_vifs));
+		!list_empty(&ctx->assigned_links));
+
+	list_for_each_entry(link, &ctx->assigned_links, assigned_chanctx_list) {
+		struct ieee80211_sub_if_data *sdata = link->sdata;
 
-	list_for_each_entry(sdata, &ctx->assigned_vifs, assigned_chanctx_list)
-		if (sdata->deflink.radar_required)
-			radar_detect |= BIT(sdata->vif.bss_conf.chandef.width);
+		if (!link->radar_required)
+			continue;
+
+		radar_detect |=
+			BIT(sdata->vif.link_conf[link->link_id]->chandef.width);
+	}
 
 	return radar_detect;
 }
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index 7daca8352deb..27d260be9123 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -313,7 +313,7 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 			sta->deflink.cur_max_bandwidth = IEEE80211_STA_RX_BW_160;
 	}
 
-	sta->sta.deflink.bandwidth = ieee80211_sta_cur_vht_bw(sta);
+	sta->sta.deflink.bandwidth = ieee80211_sta_cur_vht_bw(sta, 0);
 
 	switch (vht_cap->cap & IEEE80211_VHT_CAP_MAX_MPDU_MASK) {
 	case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454:
@@ -330,19 +330,21 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 }
 
 /* FIXME: move this to some better location - parses HE/EHT now */
-enum ieee80211_sta_rx_bandwidth ieee80211_sta_cap_rx_bw(struct sta_info *sta)
+enum ieee80211_sta_rx_bandwidth ieee80211_sta_cap_rx_bw(struct sta_info *sta,
+							unsigned int link_id)
 {
-	struct ieee80211_sta_vht_cap *vht_cap = &sta->sta.deflink.vht_cap;
-	struct ieee80211_sta_he_cap *he_cap = &sta->sta.deflink.he_cap;
-	struct ieee80211_sta_eht_cap *eht_cap = &sta->sta.deflink.eht_cap;
+	struct ieee80211_bss_conf *link_conf = sta->sdata->vif.link_conf[link_id];
+	struct ieee80211_link_sta *link_sta = sta->sta.link[link_id];
+	struct ieee80211_sta_vht_cap *vht_cap = &link_sta->vht_cap;
+	struct ieee80211_sta_he_cap *he_cap = &link_sta->he_cap;
+	struct ieee80211_sta_eht_cap *eht_cap = &link_sta->eht_cap;
 	u32 cap_width;
 
 	if (he_cap->has_he) {
 		u8 info;
 
 		if (eht_cap->has_eht &&
-		    sta->sdata->vif.bss_conf.chandef.chan->band ==
-		    NL80211_BAND_6GHZ) {
+		    link_conf->chandef.chan->band == NL80211_BAND_6GHZ) {
 			info = eht_cap->eht_cap_elem.phy_cap_info[0];
 
 			if (info & IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ)
@@ -351,8 +353,7 @@ enum ieee80211_sta_rx_bandwidth ieee80211_sta_cap_rx_bw(struct sta_info *sta)
 
 		info = he_cap->he_cap_elem.phy_cap_info[0];
 
-		if (sta->sdata->vif.bss_conf.chandef.chan->band ==
-				NL80211_BAND_2GHZ) {
+		if (link_conf->chandef.chan->band == NL80211_BAND_2GHZ) {
 			if (info & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G)
 				return IEEE80211_STA_RX_BW_40;
 			else
@@ -369,7 +370,7 @@ enum ieee80211_sta_rx_bandwidth ieee80211_sta_cap_rx_bw(struct sta_info *sta)
 	}
 
 	if (!vht_cap->vht_supported)
-		return sta->sta.deflink.ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 ?
+		return link_sta->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 ?
 				IEEE80211_STA_RX_BW_40 :
 				IEEE80211_STA_RX_BW_20;
 
@@ -466,14 +467,15 @@ ieee80211_chan_width_to_rx_bw(enum nl80211_chan_width width)
 }
 
 /* FIXME: rename/move - this deals with everything not just VHT */
-enum ieee80211_sta_rx_bandwidth ieee80211_sta_cur_vht_bw(struct sta_info *sta)
+enum ieee80211_sta_rx_bandwidth ieee80211_sta_cur_vht_bw(struct sta_info *sta,
+							 unsigned int link_id)
 {
-	struct ieee80211_sub_if_data *sdata = sta->sdata;
+	struct ieee80211_bss_conf *link_conf = sta->sdata->vif.link_conf[link_id];
+	enum nl80211_chan_width bss_width = link_conf->chandef.width;
 	enum ieee80211_sta_rx_bandwidth bw;
-	enum nl80211_chan_width bss_width = sdata->vif.bss_conf.chandef.width;
 
-	bw = ieee80211_sta_cap_rx_bw(sta);
-	bw = min(bw, sta->deflink.cur_max_bandwidth);
+	bw = ieee80211_sta_cap_rx_bw(sta, link_id);
+	bw = min(bw, sta->link[link_id]->cur_max_bandwidth);
 
 	/* Don't consider AP's bandwidth for TDLS peers, section 11.23.1 of
 	 * IEEE80211-2016 specification makes higher bandwidth operation
@@ -629,7 +631,7 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 		break;
 	}
 
-	new_bw = ieee80211_sta_cur_vht_bw(sta);
+	new_bw = ieee80211_sta_cur_vht_bw(sta, 0);
 	if (new_bw != sta->sta.deflink.bandwidth) {
 		sta->sta.deflink.bandwidth = new_bw;
 		sta_opmode.bw = ieee80211_sta_rx_bw_to_chan_width(sta);
@@ -692,7 +694,7 @@ void ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 
 	if (changed > 0) {
 		ieee80211_recalc_min_chandef(sdata);
-		rate_control_rate_update(local, sband, sta, changed);
+		rate_control_rate_update(local, sband, sta, 0, changed);
 	}
 }
 
-- 
2.36.1

