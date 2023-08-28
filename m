Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D4278A992
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 12:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjH1KEx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 06:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjH1KEZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 06:04:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AABCC6
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 03:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693217062; x=1724753062;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Pfymy3kVW/hnn5x24Hdh8+KgDbUb9MKYSVYaRSAnhAU=;
  b=Wc+4USKWu52bYbsVaZ8WI81RivAn5sBnsnZoCn54+eNU6I7L/rL1/4e+
   MZ1DQItuaGI8WdsNksygB9AEJ0PZ+T/g/kvjvwtse77L2XtLn3++B7lM3
   BoFEQ9zXeSirpvTf0iYb5tA9tvoD8u4jQ+m/gTCAGBvqzZlORPUx84yjR
   B3izK+lXYxsRD48F43hnYLkO2rOMRyMQXAvdd6fgGdUKM1ooswOaCsyGF
   w2cy05h3Bn9uFhnC1ovxKOBpXackl5M9gh6+4CunXrrE5RqORDkfVE5zg
   +HNiQv14YpQHmbM+i5NIorXrGCtOTiQ556bcGxKjBXAp+HXrA2OEocf9+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="406055339"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="406055339"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 03:04:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="738193511"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="738193511"
Received: from obesso-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.9])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 03:04:19 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 01/15] wifi: mac80211: add support for mld in ieee80211_chswitch_done
Date:   Mon, 28 Aug 2023 13:04:10 +0300
Message-Id: <20230828130311.3d3eacc88436.Ic2d14e2285aa1646216a56806cfd4a8d0054437c@changeid>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This allows to finalize the CSA per link.
In case the switch didn't work, tear down the MLD connection.
Also pass the ieee80211_bss_conf to post_channel_switch to let the
driver know which link completed the switch.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlegacy/4965-mac.c    |  2 +-
 drivers/net/wireless/intel/iwlegacy/common.c  |  2 +-
 .../net/wireless/intel/iwlwifi/dvm/mac80211.c |  6 ++--
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 10 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  2 +-
 drivers/net/wireless/ti/wlcore/event.c        |  2 +-
 drivers/net/wireless/ti/wlcore/main.c         |  6 ++--
 include/net/mac80211.h                        |  8 +++--
 net/mac80211/cfg.c                            | 35 ++++++++++---------
 net/mac80211/driver-ops.h                     |  6 ++--
 net/mac80211/mlme.c                           | 27 +++++++++-----
 net/mac80211/trace.h                          | 11 +++---
 14 files changed, 73 insertions(+), 49 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index 0a4aa3c678c1..69276266ce6f 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -6122,7 +6122,7 @@ il4965_mac_channel_switch(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (il->ops->set_channel_switch(il, ch_switch)) {
 		clear_bit(S_CHANNEL_SWITCH_PENDING, &il->status);
 		il->switch_channel = 0;
-		ieee80211_chswitch_done(il->vif, false);
+		ieee80211_chswitch_done(il->vif, false, 0);
 	}
 
 out:
diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
index 96002121bb8b..054fef680aba 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -4090,7 +4090,7 @@ il_chswitch_done(struct il_priv *il, bool is_success)
 		return;
 
 	if (test_and_clear_bit(S_CHANNEL_SWITCH_PENDING, &il->status))
-		ieee80211_chswitch_done(il->vif, is_success);
+		ieee80211_chswitch_done(il->vif, is_success, 0);
 }
 EXPORT_SYMBOL(il_chswitch_done);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
index b1939ff275b5..5f3d5b15f727 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2003 - 2014 Intel Corporation. All rights reserved.
- * Copyright (C) 2018 - 2019, 2022 Intel Corporation
+ * Copyright(C) 2018 - 2019, 2022 - 2023 Intel Corporation
  *
  * Portions of this file are derived from the ipw3945 project, as well
  * as portions of the ieee80211 subsystem header files.
@@ -1001,7 +1001,7 @@ static void iwlagn_mac_channel_switch(struct ieee80211_hw *hw,
 	if (priv->lib->set_channel_switch(priv, ch_switch)) {
 		clear_bit(STATUS_CHANNEL_SWITCH_PENDING, &priv->status);
 		priv->switch_channel = 0;
-		ieee80211_chswitch_done(ctx->vif, false);
+		ieee80211_chswitch_done(ctx->vif, false, 0);
 	}
 
 out:
@@ -1024,7 +1024,7 @@ void iwl_chswitch_done(struct iwl_priv *priv, bool is_success)
 		return;
 
 	if (ctx->vif)
-		ieee80211_chswitch_done(ctx->vif, is_success);
+		ieee80211_chswitch_done(ctx->vif, is_success, 0);
 }
 
 static void iwlagn_configure_filter(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 7369a45f7f2b..b28d998c65c5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1839,7 +1839,7 @@ void iwl_mvm_channel_switch_start_notif(struct iwl_mvm *mvm,
 
 		iwl_mvm_csa_client_absent(mvm, vif);
 		cancel_delayed_work(&mvmvif->csa_work);
-		ieee80211_chswitch_done(vif, true);
+		ieee80211_chswitch_done(vif, true, 0);
 		break;
 	default:
 		/* should never happen */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 5918c1f2b10c..921f72dcddac 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1370,7 +1370,8 @@ int iwl_mvm_set_tx_power(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 }
 
 int iwl_mvm_post_channel_switch(struct ieee80211_hw *hw,
-				struct ieee80211_vif *vif)
+				struct ieee80211_vif *vif,
+				struct ieee80211_bss_conf *link_conf)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
@@ -1452,7 +1453,8 @@ void iwl_mvm_abort_channel_switch(struct ieee80211_hw *hw,
 	mvmvif->csa_failed = true;
 	mutex_unlock(&mvm->mutex);
 
-	iwl_mvm_post_channel_switch(hw, vif);
+	/* If we're here, we can't support MLD */
+	iwl_mvm_post_channel_switch(hw, vif, &vif->bss_conf);
 }
 
 void iwl_mvm_channel_switch_disconnect_wk(struct work_struct *wk)
@@ -1464,7 +1466,7 @@ void iwl_mvm_channel_switch_disconnect_wk(struct work_struct *wk)
 	vif = container_of((void *)mvmvif, struct ieee80211_vif, drv_priv);
 
 	/* Trigger disconnect (should clear the CSA state) */
-	ieee80211_chswitch_done(vif, false);
+	ieee80211_chswitch_done(vif, false, 0);
 }
 
 static u8
@@ -5535,7 +5537,7 @@ void iwl_mvm_channel_switch_rx_beacon(struct ieee80211_hw *hw,
 		if (mvmvif->csa_misbehave) {
 			/* Second time, give up on this AP*/
 			iwl_mvm_abort_channel_switch(hw, vif);
-			ieee80211_chswitch_done(vif, false);
+			ieee80211_chswitch_done(vif, false, 0);
 			mvmvif->csa_misbehave = false;
 			return;
 		}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index b18c91c5dd5d..dda13f4351c3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2427,7 +2427,8 @@ static inline u8 iwl_mvm_phy_band_from_nl80211(enum nl80211_band band)
 /* Channel Switch */
 void iwl_mvm_channel_switch_disconnect_wk(struct work_struct *wk);
 int iwl_mvm_post_channel_switch(struct ieee80211_hw *hw,
-				struct ieee80211_vif *vif);
+				struct ieee80211_vif *vif,
+				struct ieee80211_bss_conf *link);
 
 /* Channel Context */
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 5f0e7144a951..e1f6cea649c3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -223,7 +223,7 @@ iwl_mvm_te_handle_notify_csa(struct iwl_mvm *mvm,
 		}
 		iwl_mvm_csa_client_absent(mvm, te_data->vif);
 		cancel_delayed_work(&mvmvif->csa_work);
-		ieee80211_chswitch_done(te_data->vif, true);
+		ieee80211_chswitch_done(te_data->vif, true, 0);
 		break;
 	default:
 		/* should never happen */
diff --git a/drivers/net/wireless/ti/wlcore/event.c b/drivers/net/wireless/ti/wlcore/event.c
index 46ab69eab26a..1e082d039b82 100644
--- a/drivers/net/wireless/ti/wlcore/event.c
+++ b/drivers/net/wireless/ti/wlcore/event.c
@@ -229,7 +229,7 @@ void wlcore_event_channel_switch(struct wl1271 *wl,
 		vif = wl12xx_wlvif_to_vif(wlvif);
 
 		if (wlvif->bss_type == BSS_TYPE_STA_BSS) {
-			ieee80211_chswitch_done(vif, success);
+			ieee80211_chswitch_done(vif, success, 0);
 			cancel_delayed_work(&wlvif->channel_switch_work);
 		} else {
 			set_bit(WLVIF_FLAG_BEACON_DISABLED, &wlvif->flags);
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index bf21611872a3..b7e68d2721c1 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -2043,7 +2043,7 @@ static void wlcore_channel_switch_work(struct work_struct *work)
 		goto out;
 
 	vif = wl12xx_wlvif_to_vif(wlvif);
-	ieee80211_chswitch_done(vif, false);
+	ieee80211_chswitch_done(vif, false, 0);
 
 	ret = pm_runtime_resume_and_get(wl->dev);
 	if (ret < 0)
@@ -3030,7 +3030,7 @@ static int wlcore_unset_assoc(struct wl1271 *wl, struct wl12xx_vif *wlvif)
 		struct ieee80211_vif *vif = wl12xx_wlvif_to_vif(wlvif);
 
 		wl12xx_cmd_stop_channel_switch(wl, wlvif);
-		ieee80211_chswitch_done(vif, false);
+		ieee80211_chswitch_done(vif, false, 0);
 		cancel_delayed_work(&wlvif->channel_switch_work);
 	}
 
@@ -5451,7 +5451,7 @@ static void wl12xx_op_channel_switch(struct ieee80211_hw *hw,
 
 	if (unlikely(wl->state == WLCORE_STATE_OFF)) {
 		if (test_bit(WLVIF_FLAG_STA_ASSOCIATED, &wlvif->flags))
-			ieee80211_chswitch_done(vif, false);
+			ieee80211_chswitch_done(vif, false, 0);
 		goto out;
 	} else if (unlikely(wl->state != WLCORE_STATE_ON)) {
 		goto out;
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 7c707358d15c..67f54825110f 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4544,7 +4544,8 @@ struct ieee80211_ops {
 				  struct ieee80211_channel_switch *ch_switch);
 
 	int (*post_channel_switch)(struct ieee80211_hw *hw,
-				   struct ieee80211_vif *vif);
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_bss_conf *link_conf);
 	void (*abort_channel_switch)(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif);
 	void (*channel_switch_rx_beacon)(struct ieee80211_hw *hw,
@@ -6542,11 +6543,14 @@ void ieee80211_radar_detected(struct ieee80211_hw *hw);
  * ieee80211_chswitch_done - Complete channel switch process
  * @vif: &struct ieee80211_vif pointer from the add_interface callback.
  * @success: make the channel switch successful or not
+ * @link_id: the link_id on which the switch was done. Ignored if success is
+ *	false.
  *
  * Complete the channel switch post-process: set the new operational channel
  * and wake up the suspended queues.
  */
-void ieee80211_chswitch_done(struct ieee80211_vif *vif, bool success);
+void ieee80211_chswitch_done(struct ieee80211_vif *vif, bool success,
+			     unsigned int link_id);
 
 /**
  * ieee80211_channel_switch_disconnect - disconnect due to channel switch error
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 45e7a5d9c7d9..ae5017edd09f 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3638,8 +3638,9 @@ static int ieee80211_set_after_csa_beacon(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
-static int __ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
+static int __ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 {
+	struct ieee80211_sub_if_data *sdata = link_data->sdata;
 	struct ieee80211_local *local = sdata->local;
 	u64 changed = 0;
 	int err;
@@ -3655,20 +3656,20 @@ static int __ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
 	 * completed successfully
 	 */
 
-	if (sdata->deflink.reserved_chanctx) {
+	if (link_data->reserved_chanctx) {
 		/*
 		 * with multi-vif csa driver may call ieee80211_csa_finish()
 		 * many times while waiting for other interfaces to use their
 		 * reservations
 		 */
-		if (sdata->deflink.reserved_ready)
+		if (link_data->reserved_ready)
 			return 0;
 
 		return ieee80211_link_use_reserved_context(&sdata->deflink);
 	}
 
 	if (!cfg80211_chandef_identical(&sdata->vif.bss_conf.chandef,
-					&sdata->deflink.csa_chandef))
+					&link_data->csa_chandef))
 		return -EINVAL;
 
 	sdata->vif.bss_conf.csa_active = false;
@@ -3685,25 +3686,27 @@ static int __ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
 
 	ieee80211_link_info_change_notify(sdata, &sdata->deflink, changed);
 
-	if (sdata->deflink.csa_block_tx) {
+	if (link_data->csa_block_tx) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->deflink.csa_block_tx = false;
+		link_data->csa_block_tx = false;
 	}
 
-	err = drv_post_channel_switch(sdata);
+	err = drv_post_channel_switch(link_data);
 	if (err)
 		return err;
 
-	cfg80211_ch_switch_notify(sdata->dev, &sdata->deflink.csa_chandef, 0,
+	cfg80211_ch_switch_notify(sdata->dev, &link_data->csa_chandef, 0,
 				  sdata->vif.bss_conf.eht_puncturing);
 
 	return 0;
 }
 
-static void ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
+static void ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 {
-	if (__ieee80211_csa_finalize(sdata)) {
+	struct ieee80211_sub_if_data *sdata = link_data->sdata;
+
+	if (__ieee80211_csa_finalize(link_data)) {
 		sdata_info(sdata, "failed to finalize CSA, disconnecting\n");
 		cfg80211_stop_iface(sdata->local->hw.wiphy, &sdata->wdev,
 				    GFP_KERNEL);
@@ -3712,9 +3715,9 @@ static void ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
 
 void ieee80211_csa_finalize_work(struct work_struct *work)
 {
-	struct ieee80211_sub_if_data *sdata =
-		container_of(work, struct ieee80211_sub_if_data,
-			     deflink.csa_finalize_work);
+	struct ieee80211_link_data *link =
+		container_of(work, struct ieee80211_link_data, csa_finalize_work);
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 
 	sdata_lock(sdata);
@@ -3722,13 +3725,13 @@ void ieee80211_csa_finalize_work(struct work_struct *work)
 	mutex_lock(&local->chanctx_mtx);
 
 	/* AP might have been stopped while waiting for the lock. */
-	if (!sdata->vif.bss_conf.csa_active)
+	if (!link->conf->csa_active)
 		goto unlock;
 
 	if (!ieee80211_sdata_running(sdata))
 		goto unlock;
 
-	ieee80211_csa_finalize(sdata);
+	ieee80211_csa_finalize(link);
 
 unlock:
 	mutex_unlock(&local->chanctx_mtx);
@@ -3978,7 +3981,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 		drv_channel_switch_beacon(sdata, &params->chandef);
 	} else {
 		/* if the beacon didn't change, we can finalize immediately */
-		ieee80211_csa_finalize(sdata);
+		ieee80211_csa_finalize(&sdata->deflink);
 	}
 
 out:
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index c4505593ba7a..a41dd60ae4b4 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1072,8 +1072,9 @@ drv_pre_channel_switch(struct ieee80211_sub_if_data *sdata,
 }
 
 static inline int
-drv_post_channel_switch(struct ieee80211_sub_if_data *sdata)
+drv_post_channel_switch(struct ieee80211_link_data *link)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 	int ret = 0;
 
@@ -1082,7 +1083,8 @@ drv_post_channel_switch(struct ieee80211_sub_if_data *sdata)
 
 	trace_drv_post_channel_switch(local, sdata);
 	if (local->ops->post_channel_switch)
-		ret = local->ops->post_channel_switch(&local->hw, &sdata->vif);
+		ret = local->ops->post_channel_switch(&local->hw, &sdata->vif,
+						      link->conf);
 	trace_drv_return_int(local, ret);
 	return ret;
 }
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f93eb38ae0b8..9dc6b5dbb66b 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1773,7 +1773,7 @@ static void ieee80211_chswitch_post_beacon(struct ieee80211_link_data *link)
 	 */
 	link->u.mgd.beacon_crc_valid = false;
 
-	ret = drv_post_channel_switch(sdata);
+	ret = drv_post_channel_switch(link);
 	if (ret) {
 		sdata_info(sdata,
 			   "driver post channel switch failed, disconnecting\n");
@@ -1785,25 +1785,34 @@ static void ieee80211_chswitch_post_beacon(struct ieee80211_link_data *link)
 	cfg80211_ch_switch_notify(sdata->dev, &link->reserved_chandef, 0, 0);
 }
 
-void ieee80211_chswitch_done(struct ieee80211_vif *vif, bool success)
+void ieee80211_chswitch_done(struct ieee80211_vif *vif, bool success,
+			     unsigned int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
-	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 
-	if (WARN_ON(ieee80211_vif_is_mld(&sdata->vif)))
-		success = false;
+	trace_api_chswitch_done(sdata, success, link_id);
+
+	rcu_read_lock();
 
-	trace_api_chswitch_done(sdata, success);
 	if (!success) {
 		sdata_info(sdata,
 			   "driver channel switch failed, disconnecting\n");
 		wiphy_work_queue(sdata->local->hw.wiphy,
-				 &ifmgd->csa_connection_drop_work);
+				 &sdata->u.mgd.csa_connection_drop_work);
 	} else {
+		struct ieee80211_link_data *link =
+			rcu_dereference(sdata->link[link_id]);
+
+		if (WARN_ON(!link)) {
+			rcu_read_unlock();
+			return;
+		}
+
 		wiphy_delayed_work_queue(sdata->local->hw.wiphy,
-					 &sdata->deflink.u.mgd.chswitch_work,
-					 0);
+					 &link->u.mgd.chswitch_work, 0);
 	}
+
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(ieee80211_chswitch_done);
 
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index b8c53b4a710b..032718d5b298 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -2839,23 +2839,26 @@ TRACE_EVENT(api_sta_block_awake,
 );
 
 TRACE_EVENT(api_chswitch_done,
-	TP_PROTO(struct ieee80211_sub_if_data *sdata, bool success),
+	TP_PROTO(struct ieee80211_sub_if_data *sdata, bool success,
+		 unsigned int link_id),
 
-	TP_ARGS(sdata, success),
+	TP_ARGS(sdata, success, link_id),
 
 	TP_STRUCT__entry(
 		VIF_ENTRY
 		__field(bool, success)
+		__field(unsigned int, link_id)
 	),
 
 	TP_fast_assign(
 		VIF_ASSIGN;
 		__entry->success = success;
+		__entry->link_id = link_id;
 	),
 
 	TP_printk(
-		VIF_PR_FMT " success=%d",
-		VIF_PR_ARG, __entry->success
+		VIF_PR_FMT " success=%d link_id=%d",
+		VIF_PR_ARG, __entry->success, __entry->link_id
 	)
 );
 
-- 
2.38.1

