Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376996CB8E4
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 10:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjC1IAQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 04:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjC1IAO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 04:00:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C2F40CA
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 01:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990410; x=1711526410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=96FXuO1hf7OJXyLvj2Ngznf7znCOalVDc/tMh7TI75A=;
  b=J4uDi3BEZxikQuXGEkQjPy9fSRpafrRkV/lYs0sNjVpLVfIB3P3vwnXn
   K/IjdgYa5uJno/szYrOHGWTQPREd9hd8TMn9V/2J3/LpE253+ZwG/Wpn6
   LGX1+bOeywpF5ogqnjXjFAkGXAkw7a65sf/Jvgr/Wkntu78zu5mJVb+QO
   1nJs1zuOqruMLWtRB+kyJCOs4RDRZrqw4nZJ2IXhUR1KDf4hEQm+f/Ucf
   BWR498CkZEBZEnsFkws9uJQ0JgKUeI48/B6qN8Fsi2Q215G/k4lsGY3OJ
   neGFEM9zfRcVCr1SWz64pOwMkrpFIqpPqmwWwsUOpAdgi4Q7z9JPOloFR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958123"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958123"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045140"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045140"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:44 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/31] wifi: iwlwifi: mvm: add all missing ops to iwl_mvm_mld_ops
Date:   Tue, 28 Mar 2023 10:58:50 +0300
Message-Id: <20230328104948.a2f724342522.I5d1d6a8f5f14e6275da56ea704c3c0063fee5226@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230328075911.2370108-1-gregory.greenman@intel.com>
References: <20230328075911.2370108-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Add all the callbacks that are not changing with the
new MLD API and register to mac80211 with the new ops.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 200 ++++++++----------
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 114 +++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 135 ++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   4 +-
 4 files changed, 334 insertions(+), 119 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 631d1becc6ab..e922cc45c390 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -258,8 +258,7 @@ static const struct wiphy_iftype_ext_capab add_iftypes_ext_capa[] = {
 	},
 };
 
-static int
-iwl_mvm_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
+int iwl_mvm_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	*tx_ant = iwl_mvm_get_valid_tx_ant(mvm);
@@ -703,9 +702,8 @@ static void iwl_mvm_tx_skb(struct iwl_mvm *mvm, struct sk_buff *skb,
 	ieee80211_free_txskb(mvm->hw, skb);
 }
 
-static void iwl_mvm_mac_tx(struct ieee80211_hw *hw,
-			   struct ieee80211_tx_control *control,
-			   struct sk_buff *skb)
+void iwl_mvm_mac_tx(struct ieee80211_hw *hw,
+		    struct ieee80211_tx_control *control, struct sk_buff *skb)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct ieee80211_sta *sta = control->sta;
@@ -801,8 +799,8 @@ void iwl_mvm_mac_itxq_xmit(struct ieee80211_hw *hw, struct ieee80211_txq *txq)
 	rcu_read_unlock();
 }
 
-static void iwl_mvm_mac_wake_tx_queue(struct ieee80211_hw *hw,
-				      struct ieee80211_txq *txq)
+void iwl_mvm_mac_wake_tx_queue(struct ieee80211_hw *hw,
+			       struct ieee80211_txq *txq)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_txq *mvmtxq = iwl_mvm_txq_from_mac80211(txq);
@@ -897,9 +895,9 @@ iwl_mvm_ampdu_check_trigger(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	}
 }
 
-static int iwl_mvm_mac_ampdu_action(struct ieee80211_hw *hw,
-				    struct ieee80211_vif *vif,
-				    struct ieee80211_ampdu_params *params)
+int iwl_mvm_mac_ampdu_action(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif,
+			     struct ieee80211_ampdu_params *params)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	int ret;
@@ -1095,7 +1093,7 @@ int __iwl_mvm_mac_start(struct iwl_mvm *mvm)
 	return ret;
 }
 
-static int iwl_mvm_mac_start(struct ieee80211_hw *hw)
+int iwl_mvm_mac_start(struct ieee80211_hw *hw)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	int ret;
@@ -1164,9 +1162,8 @@ static void iwl_mvm_restart_complete(struct iwl_mvm *mvm)
 	mutex_unlock(&mvm->mutex);
 }
 
-static void
-iwl_mvm_mac_reconfig_complete(struct ieee80211_hw *hw,
-			      enum ieee80211_reconfig_type reconfig_type)
+void iwl_mvm_mac_reconfig_complete(struct ieee80211_hw *hw,
+				   enum ieee80211_reconfig_type reconfig_type)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
@@ -1228,7 +1225,7 @@ void __iwl_mvm_mac_stop(struct iwl_mvm *mvm)
 	}
 }
 
-static void iwl_mvm_mac_stop(struct ieee80211_hw *hw)
+void iwl_mvm_mac_stop(struct ieee80211_hw *hw)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
@@ -1366,8 +1363,8 @@ int iwl_mvm_post_channel_switch(struct ieee80211_hw *hw,
 	return ret;
 }
 
-static void iwl_mvm_abort_channel_switch(struct ieee80211_hw *hw,
-					 struct ieee80211_vif *vif)
+void iwl_mvm_abort_channel_switch(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
@@ -1731,11 +1728,6 @@ static void iwl_mvm_mac_remove_interface(struct ieee80211_hw *hw,
 	mutex_unlock(&mvm->mutex);
 }
 
-static int iwl_mvm_mac_config(struct ieee80211_hw *hw, u32 changed)
-{
-	return 0;
-}
-
 struct iwl_mvm_mc_iter_data {
 	struct iwl_mvm *mvm;
 	int port_id;
@@ -1807,8 +1799,8 @@ static void iwl_mvm_recalc_multicast(struct iwl_mvm *mvm)
 		IWL_ERR(mvm, "Failed to synchronize multicast groups update\n");
 }
 
-static u64 iwl_mvm_prepare_multicast(struct ieee80211_hw *hw,
-				     struct netdev_hw_addr_list *mc_list)
+u64 iwl_mvm_prepare_multicast(struct ieee80211_hw *hw,
+			      struct netdev_hw_addr_list *mc_list)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mcast_filter_cmd *cmd;
@@ -1844,10 +1836,9 @@ static u64 iwl_mvm_prepare_multicast(struct ieee80211_hw *hw,
 	return (u64)(unsigned long)cmd;
 }
 
-static void iwl_mvm_configure_filter(struct ieee80211_hw *hw,
-				     unsigned int changed_flags,
-				     unsigned int *total_flags,
-				     u64 multicast)
+void iwl_mvm_configure_filter(struct ieee80211_hw *hw,
+			      unsigned int changed_flags,
+			      unsigned int *total_flags, u64 multicast)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mcast_filter_cmd *cmd = (void *)(unsigned long)multicast;
@@ -3038,9 +3029,8 @@ iwl_mvm_bss_info_changed_common(struct ieee80211_hw *hw,
 	mutex_unlock(&mvm->mutex);
 }
 
-static int iwl_mvm_mac_hw_scan(struct ieee80211_hw *hw,
-			       struct ieee80211_vif *vif,
-			       struct ieee80211_scan_request *hw_req)
+int iwl_mvm_mac_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			struct ieee80211_scan_request *hw_req)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	int ret;
@@ -3056,8 +3046,8 @@ static int iwl_mvm_mac_hw_scan(struct ieee80211_hw *hw,
 	return ret;
 }
 
-static void iwl_mvm_mac_cancel_hw_scan(struct ieee80211_hw *hw,
-				       struct ieee80211_vif *vif)
+void iwl_mvm_mac_cancel_hw_scan(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
@@ -3076,7 +3066,7 @@ static void iwl_mvm_mac_cancel_hw_scan(struct ieee80211_hw *hw,
 	mutex_unlock(&mvm->mutex);
 }
 
-static void
+void
 iwl_mvm_mac_allow_buffered_frames(struct ieee80211_hw *hw,
 				  struct ieee80211_sta *sta, u16 tids,
 				  int num_frames,
@@ -3091,7 +3081,7 @@ iwl_mvm_mac_allow_buffered_frames(struct ieee80211_hw *hw,
 					  tids, more_data, false);
 }
 
-static void
+void
 iwl_mvm_mac_release_buffered_frames(struct ieee80211_hw *hw,
 				    struct ieee80211_sta *sta, u16 tids,
 				    int num_frames,
@@ -3165,10 +3155,8 @@ static void __iwl_mvm_mac_sta_notify(struct ieee80211_hw *hw,
 	spin_unlock_bh(&mvmsta->lock);
 }
 
-static void iwl_mvm_mac_sta_notify(struct ieee80211_hw *hw,
-				   struct ieee80211_vif *vif,
-				   enum sta_notify_cmd cmd,
-				   struct ieee80211_sta *sta)
+void iwl_mvm_mac_sta_notify(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			    enum sta_notify_cmd cmd, struct ieee80211_sta *sta)
 {
 	__iwl_mvm_mac_sta_notify(hw, cmd, sta);
 }
@@ -3226,9 +3214,9 @@ void iwl_mvm_sta_pm_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 	rcu_read_unlock();
 }
 
-static void iwl_mvm_sta_pre_rcu_remove(struct ieee80211_hw *hw,
-				       struct ieee80211_vif *vif,
-				       struct ieee80211_sta *sta)
+void iwl_mvm_sta_pre_rcu_remove(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				struct ieee80211_sta *sta)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
@@ -3710,7 +3698,7 @@ int iwl_mvm_mac_sta_state_common(struct ieee80211_hw *hw,
 	return ret;
 }
 
-static int iwl_mvm_mac_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+int iwl_mvm_mac_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
@@ -3719,9 +3707,8 @@ static int iwl_mvm_mac_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
 	return 0;
 }
 
-static void iwl_mvm_sta_rc_update(struct ieee80211_hw *hw,
-				  struct ieee80211_vif *vif,
-				  struct ieee80211_sta *sta, u32 changed)
+void iwl_mvm_sta_rc_update(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta, u32 changed)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
@@ -3763,9 +3750,9 @@ static int iwl_mvm_mac_conf_tx(struct ieee80211_hw *hw,
 	return 0;
 }
 
-static void iwl_mvm_mac_mgd_prepare_tx(struct ieee80211_hw *hw,
-				       struct ieee80211_vif *vif,
-				       struct ieee80211_prep_tx_info *info)
+void iwl_mvm_mac_mgd_prepare_tx(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				struct ieee80211_prep_tx_info *info)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
@@ -3774,9 +3761,9 @@ static void iwl_mvm_mac_mgd_prepare_tx(struct ieee80211_hw *hw,
 	mutex_unlock(&mvm->mutex);
 }
 
-static void iwl_mvm_mac_mgd_complete_tx(struct ieee80211_hw *hw,
-					struct ieee80211_vif *vif,
-					struct ieee80211_prep_tx_info *info)
+void iwl_mvm_mac_mgd_complete_tx(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_prep_tx_info *info)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
@@ -3789,10 +3776,10 @@ static void iwl_mvm_mac_mgd_complete_tx(struct ieee80211_hw *hw,
 	mutex_unlock(&mvm->mutex);
 }
 
-static int iwl_mvm_mac_sched_scan_start(struct ieee80211_hw *hw,
-					struct ieee80211_vif *vif,
-					struct cfg80211_sched_scan_request *req,
-					struct ieee80211_scan_ies *ies)
+int iwl_mvm_mac_sched_scan_start(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 struct cfg80211_sched_scan_request *req,
+				 struct ieee80211_scan_ies *ies)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
@@ -3812,8 +3799,8 @@ static int iwl_mvm_mac_sched_scan_start(struct ieee80211_hw *hw,
 	return ret;
 }
 
-static int iwl_mvm_mac_sched_scan_stop(struct ieee80211_hw *hw,
-				       struct ieee80211_vif *vif)
+int iwl_mvm_mac_sched_scan_stop(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	int ret;
@@ -4069,11 +4056,9 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 	return ret;
 }
 
-static int iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
-			       enum set_key_cmd cmd,
-			       struct ieee80211_vif *vif,
-			       struct ieee80211_sta *sta,
-			       struct ieee80211_key_conf *key)
+int iwl_mvm_mac_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
+			struct ieee80211_vif *vif, struct ieee80211_sta *sta,
+			struct ieee80211_key_conf *key)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	int ret;
@@ -4085,11 +4070,11 @@ static int iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 	return ret;
 }
 
-static void iwl_mvm_mac_update_tkip_key(struct ieee80211_hw *hw,
-					struct ieee80211_vif *vif,
-					struct ieee80211_key_conf *keyconf,
-					struct ieee80211_sta *sta,
-					u32 iv32, u16 *phase1key)
+void iwl_mvm_mac_update_tkip_key(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_key_conf *keyconf,
+				 struct ieee80211_sta *sta,
+				 u32 iv32, u16 *phase1key)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
@@ -4519,8 +4504,8 @@ static int __iwl_mvm_add_chanctx(struct iwl_mvm *mvm,
 	return ret;
 }
 
-static int iwl_mvm_add_chanctx(struct ieee80211_hw *hw,
-			       struct ieee80211_chanctx_conf *ctx)
+int iwl_mvm_add_chanctx(struct ieee80211_hw *hw,
+			struct ieee80211_chanctx_conf *ctx)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	int ret;
@@ -4543,8 +4528,8 @@ static void __iwl_mvm_remove_chanctx(struct iwl_mvm *mvm,
 	iwl_mvm_phy_ctxt_unref(mvm, phy_ctxt);
 }
 
-static void iwl_mvm_remove_chanctx(struct ieee80211_hw *hw,
-				   struct ieee80211_chanctx_conf *ctx)
+void iwl_mvm_remove_chanctx(struct ieee80211_hw *hw,
+			    struct ieee80211_chanctx_conf *ctx)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
@@ -4553,9 +4538,8 @@ static void iwl_mvm_remove_chanctx(struct ieee80211_hw *hw,
 	mutex_unlock(&mvm->mutex);
 }
 
-static void iwl_mvm_change_chanctx(struct ieee80211_hw *hw,
-				   struct ieee80211_chanctx_conf *ctx,
-				   u32 changed)
+void iwl_mvm_change_chanctx(struct ieee80211_hw *hw,
+			    struct ieee80211_chanctx_conf *ctx, u32 changed)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	u16 *phy_ctxt_id = (u16 *)ctx->drv_priv;
@@ -4963,16 +4947,15 @@ static int iwl_mvm_switch_vif_chanctx(struct ieee80211_hw *hw,
 	return iwl_mvm_switch_vif_chanctx_common(hw, vifs, n_vifs, mode, &ops);
 }
 
-static int iwl_mvm_tx_last_beacon(struct ieee80211_hw *hw)
+int iwl_mvm_tx_last_beacon(struct ieee80211_hw *hw)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
 	return mvm->ibss_manager;
 }
 
-static int iwl_mvm_set_tim(struct ieee80211_hw *hw,
-			   struct ieee80211_sta *sta,
-			   bool set)
+int iwl_mvm_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
+		    bool set)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
@@ -5038,9 +5021,9 @@ static int __iwl_mvm_mac_testmode_cmd(struct iwl_mvm *mvm,
 	return -EOPNOTSUPP;
 }
 
-static int iwl_mvm_mac_testmode_cmd(struct ieee80211_hw *hw,
-				    struct ieee80211_vif *vif,
-				    void *data, int len)
+int iwl_mvm_mac_testmode_cmd(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif,
+			     void *data, int len)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	int err;
@@ -5053,9 +5036,8 @@ static int iwl_mvm_mac_testmode_cmd(struct ieee80211_hw *hw,
 }
 #endif
 
-static void iwl_mvm_channel_switch(struct ieee80211_hw *hw,
-				   struct ieee80211_vif *vif,
-				   struct ieee80211_channel_switch *chsw)
+void iwl_mvm_channel_switch(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			    struct ieee80211_channel_switch *chsw)
 {
 	/* By implementing this operation, we prevent mac80211 from
 	 * starting its own channel switch timer, so that we can call
@@ -5130,9 +5112,9 @@ static int iwl_mvm_old_pre_chan_sw_sta(struct iwl_mvm *mvm,
 }
 
 #define IWL_MAX_CSA_BLOCK_TX 1500
-static int iwl_mvm_pre_channel_switch(struct ieee80211_hw *hw,
-				      struct ieee80211_vif *vif,
-				      struct ieee80211_channel_switch *chsw)
+int iwl_mvm_pre_channel_switch(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *vif,
+			       struct ieee80211_channel_switch *chsw)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct ieee80211_vif *csa_vif;
@@ -5245,9 +5227,9 @@ static int iwl_mvm_pre_channel_switch(struct ieee80211_hw *hw,
 	return ret;
 }
 
-static void iwl_mvm_channel_switch_rx_beacon(struct ieee80211_hw *hw,
-					     struct ieee80211_vif *vif,
-					     struct ieee80211_channel_switch *chsw)
+void iwl_mvm_channel_switch_rx_beacon(struct ieee80211_hw *hw,
+				      struct ieee80211_vif *vif,
+				      struct ieee80211_channel_switch *chsw)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
@@ -5332,8 +5314,8 @@ static void iwl_mvm_flush_no_vif(struct iwl_mvm *mvm, u32 queues, bool drop)
 	mutex_unlock(&mvm->mutex);
 }
 
-static void iwl_mvm_mac_flush(struct ieee80211_hw *hw,
-			      struct ieee80211_vif *vif, u32 queues, bool drop)
+void iwl_mvm_mac_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		       u32 queues, bool drop)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif;
@@ -5390,8 +5372,8 @@ static void iwl_mvm_mac_flush(struct ieee80211_hw *hw,
 		iwl_trans_wait_tx_queues_empty(mvm->trans, msk);
 }
 
-static int iwl_mvm_mac_get_survey(struct ieee80211_hw *hw, int idx,
-				  struct survey_info *survey)
+int iwl_mvm_mac_get_survey(struct ieee80211_hw *hw, int idx,
+			   struct survey_info *survey)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	int ret;
@@ -5575,10 +5557,10 @@ static void iwl_mvm_set_sta_rate(u32 rate_n_flags, struct rate_info *rinfo)
 	}
 }
 
-static void iwl_mvm_mac_sta_statistics(struct ieee80211_hw *hw,
-				       struct ieee80211_vif *vif,
-				       struct ieee80211_sta *sta,
-				       struct station_info *sinfo)
+void iwl_mvm_mac_sta_statistics(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				struct ieee80211_sta *sta,
+				struct station_info *sinfo)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
@@ -5719,9 +5701,9 @@ static void iwl_mvm_event_bar_rx_callback(struct iwl_mvm *mvm,
 				event->u.ba.ssn);
 }
 
-static void iwl_mvm_mac_event_callback(struct ieee80211_hw *hw,
-				       struct ieee80211_vif *vif,
-				       const struct ieee80211_event *event)
+void iwl_mvm_mac_event_callback(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				const struct ieee80211_event *event)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
@@ -5803,7 +5785,7 @@ void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
 	}
 }
 
-static void iwl_mvm_sync_rx_queues(struct ieee80211_hw *hw)
+void iwl_mvm_sync_rx_queues(struct ieee80211_hw *hw)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
@@ -5812,7 +5794,7 @@ static void iwl_mvm_sync_rx_queues(struct ieee80211_hw *hw)
 	mutex_unlock(&mvm->mutex);
 }
 
-static int
+int
 iwl_mvm_mac_get_ftm_responder_stats(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
 				    struct cfg80211_ftm_responder_stats *stats)
@@ -5841,9 +5823,8 @@ iwl_mvm_mac_get_ftm_responder_stats(struct ieee80211_hw *hw,
 	return 0;
 }
 
-static int iwl_mvm_start_pmsr(struct ieee80211_hw *hw,
-			      struct ieee80211_vif *vif,
-			      struct cfg80211_pmsr_request *request)
+int iwl_mvm_start_pmsr(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		       struct cfg80211_pmsr_request *request)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	int ret;
@@ -5855,9 +5836,8 @@ static int iwl_mvm_start_pmsr(struct ieee80211_hw *hw,
 	return ret;
 }
 
-static void iwl_mvm_abort_pmsr(struct ieee80211_hw *hw,
-			       struct ieee80211_vif *vif,
-			       struct cfg80211_pmsr_request *request)
+void iwl_mvm_abort_pmsr(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			struct cfg80211_pmsr_request *request)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 818aed050b73..5f54e57de8e6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -244,7 +244,8 @@ static void iwl_mvm_mld_unassign_vif_chanctx(struct ieee80211_hw *hw,
 }
 
 static int iwl_mvm_mld_start_ap_ibss(struct ieee80211_hw *hw,
-				     struct ieee80211_vif *vif)
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_bss_conf *link_conf)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
@@ -319,8 +320,22 @@ static int iwl_mvm_mld_start_ap_ibss(struct ieee80211_hw *hw,
 	return ret;
 }
 
+static int iwl_mvm_mld_start_ap(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				struct ieee80211_bss_conf *link_conf)
+{
+	return iwl_mvm_mld_start_ap_ibss(hw, vif, link_conf);
+}
+
+static int iwl_mvm_mld_start_ibss(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif)
+{
+	return iwl_mvm_mld_start_ap_ibss(hw, vif, &vif->bss_conf);
+}
+
 static void iwl_mvm_mld_stop_ap_ibss(struct ieee80211_hw *hw,
-				     struct ieee80211_vif *vif)
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_bss_conf *link_conf)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
@@ -348,6 +363,19 @@ static void iwl_mvm_mld_stop_ap_ibss(struct ieee80211_hw *hw,
 	mutex_unlock(&mvm->mutex);
 }
 
+static void iwl_mvm_mld_stop_ap(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				struct ieee80211_bss_conf *link_conf)
+{
+	iwl_mvm_mld_stop_ap_ibss(hw, vif, link_conf);
+}
+
+static void iwl_mvm_mld_stop_ibss(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif)
+{
+	iwl_mvm_mld_stop_ap_ibss(hw, vif, &vif->bss_conf);
+}
+
 static int iwl_mvm_mld_mac_sta_state(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif,
 				     struct ieee80211_sta *sta,
@@ -630,18 +658,90 @@ static int iwl_mvm_mld_roc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return iwl_mvm_roc_common(hw, vif, channel, duration, type, &ops);
 }
 const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
+	.tx = iwl_mvm_mac_tx,
+	.wake_tx_queue = iwl_mvm_mac_wake_tx_queue,
+	.ampdu_action = iwl_mvm_mac_ampdu_action,
+	.get_antenna = iwl_mvm_op_get_antenna,
+	.start = iwl_mvm_mac_start,
+	.reconfig_complete = iwl_mvm_mac_reconfig_complete,
+	.stop = iwl_mvm_mac_stop,
 	.add_interface = iwl_mvm_mld_mac_add_interface,
 	.remove_interface = iwl_mvm_mld_mac_remove_interface,
+	.config = iwl_mvm_mac_config,
+	.prepare_multicast = iwl_mvm_prepare_multicast,
+	.configure_filter = iwl_mvm_configure_filter,
 	.config_iface_filter = iwl_mvm_mld_config_iface_filter,
+	.bss_info_changed = iwl_mvm_mld_bss_info_changed,
+	.hw_scan = iwl_mvm_mac_hw_scan,
+	.cancel_hw_scan = iwl_mvm_mac_cancel_hw_scan,
+	.sta_pre_rcu_remove = iwl_mvm_sta_pre_rcu_remove,
+	.sta_state = iwl_mvm_mld_mac_sta_state,
+	.sta_notify = iwl_mvm_mac_sta_notify,
+	.allow_buffered_frames = iwl_mvm_mac_allow_buffered_frames,
+	.release_buffered_frames = iwl_mvm_mac_release_buffered_frames,
+	.set_rts_threshold = iwl_mvm_mac_set_rts_threshold,
+	.sta_rc_update = iwl_mvm_sta_rc_update,
+	.conf_tx = iwl_mvm_mld_mac_conf_tx,
+	.mgd_prepare_tx = iwl_mvm_mac_mgd_prepare_tx,
+	.mgd_complete_tx = iwl_mvm_mac_mgd_complete_tx,
+	.mgd_protect_tdls_discover = iwl_mvm_mac_mgd_protect_tdls_discover,
+	.flush = iwl_mvm_mac_flush,
+	.sched_scan_start = iwl_mvm_mac_sched_scan_start,
+	.sched_scan_stop = iwl_mvm_mac_sched_scan_stop,
+	.set_key = iwl_mvm_mac_set_key,
+	.update_tkip_key = iwl_mvm_mac_update_tkip_key,
 	.remain_on_channel = iwl_mvm_mld_roc,
 	.cancel_remain_on_channel = iwl_mvm_cancel_roc,
+	.add_chanctx = iwl_mvm_add_chanctx,
+	.remove_chanctx = iwl_mvm_remove_chanctx,
+	.change_chanctx = iwl_mvm_change_chanctx,
 	.assign_vif_chanctx = iwl_mvm_mld_assign_vif_chanctx,
 	.unassign_vif_chanctx = iwl_mvm_mld_unassign_vif_chanctx,
 	.switch_vif_chanctx = iwl_mvm_mld_switch_vif_chanctx,
-	.join_ibss = iwl_mvm_mld_start_ap_ibss,
-	.leave_ibss = iwl_mvm_mld_stop_ap_ibss,
+
+	.start_ap = iwl_mvm_mld_start_ap,
+	.stop_ap = iwl_mvm_mld_stop_ap,
+	.join_ibss = iwl_mvm_mld_start_ibss,
+	.leave_ibss = iwl_mvm_mld_stop_ibss,
+
+	.tx_last_beacon = iwl_mvm_tx_last_beacon,
+
+	.set_tim = iwl_mvm_set_tim,
+
+	.channel_switch = iwl_mvm_channel_switch,
+	.pre_channel_switch = iwl_mvm_pre_channel_switch,
 	.post_channel_switch = iwl_mvm_post_channel_switch,
-	.sta_state = iwl_mvm_mld_mac_sta_state,
-	.conf_tx = iwl_mvm_mld_mac_conf_tx,
-	.bss_info_changed = iwl_mvm_mld_bss_info_changed,
+	.abort_channel_switch = iwl_mvm_abort_channel_switch,
+	.channel_switch_rx_beacon = iwl_mvm_channel_switch_rx_beacon,
+
+	.tdls_channel_switch = iwl_mvm_tdls_channel_switch,
+	.tdls_cancel_channel_switch = iwl_mvm_tdls_cancel_channel_switch,
+	.tdls_recv_channel_switch = iwl_mvm_tdls_recv_channel_switch,
+
+	.event_callback = iwl_mvm_mac_event_callback,
+
+	.sync_rx_queues = iwl_mvm_sync_rx_queues,
+
+	CFG80211_TESTMODE_CMD(iwl_mvm_mac_testmode_cmd)
+
+#ifdef CONFIG_PM_SLEEP
+	/* look at d3.c */
+	.suspend = iwl_mvm_suspend,
+	.resume = iwl_mvm_resume,
+	.set_wakeup = iwl_mvm_set_wakeup,
+	.set_rekey_data = iwl_mvm_set_rekey_data,
+#if IS_ENABLED(CONFIG_IPV6)
+	.ipv6_addr_change = iwl_mvm_ipv6_addr_change,
+#endif
+	.set_default_unicast_key = iwl_mvm_set_default_unicast_key,
+#endif
+	.get_survey = iwl_mvm_mac_get_survey,
+	.sta_statistics = iwl_mvm_mac_sta_statistics,
+	.get_ftm_responder_stats = iwl_mvm_mac_get_ftm_responder_stats,
+	.start_pmsr = iwl_mvm_start_pmsr,
+	.abort_pmsr = iwl_mvm_abort_pmsr,
+
+#ifdef CONFIG_IWLWIFI_DEBUGFS
+	.sta_add_debugfs = iwl_mvm_sta_add_debugfs,
+#endif
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index bf1de6405cd6..6f4ed5d1efb9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1384,6 +1384,28 @@ static inline bool iwl_mvm_has_new_rx_api(struct iwl_mvm *mvm)
 			   IWL_UCODE_TLV_CAPA_MULTI_QUEUE_RX_SUPPORT);
 }
 
+static inline bool iwl_mvm_has_mld_api(const struct iwl_fw *fw)
+{
+	return (iwl_fw_lookup_cmd_ver(fw, LINK_CONFIG_CMD,
+				      IWL_FW_CMD_VER_UNKNOWN) !=
+				IWL_FW_CMD_VER_UNKNOWN) &&
+		(iwl_fw_lookup_cmd_ver(fw, MAC_CONFIG_CMD,
+				       IWL_FW_CMD_VER_UNKNOWN) !=
+				IWL_FW_CMD_VER_UNKNOWN) &&
+		(iwl_fw_lookup_cmd_ver(fw, STA_CONFIG_CMD,
+				       IWL_FW_CMD_VER_UNKNOWN) !=
+				IWL_FW_CMD_VER_UNKNOWN) &&
+		(iwl_fw_lookup_cmd_ver(fw, AUX_STA_CMD,
+				       IWL_FW_CMD_VER_UNKNOWN) !=
+				IWL_FW_CMD_VER_UNKNOWN) &&
+		(iwl_fw_lookup_cmd_ver(fw, STA_REMOVE_CMD,
+				       IWL_FW_CMD_VER_UNKNOWN) !=
+				IWL_FW_CMD_VER_UNKNOWN) &&
+		(iwl_fw_lookup_cmd_ver(fw, STA_DISABLE_TX_CMD,
+				       IWL_FW_CMD_VER_UNKNOWN) !=
+				IWL_FW_CMD_VER_UNKNOWN);
+}
+
 static inline bool iwl_mvm_has_new_tx_api(struct iwl_mvm *mvm)
 {
 	/* TODO - replace with TLV once defined */
@@ -2462,4 +2484,117 @@ void iwl_mvm_send_roaming_forbidden_event(struct iwl_mvm *mvm,
 					  struct ieee80211_vif *vif,
 					  bool forbidden);
 bool iwl_mvm_is_vendor_in_approved_list(void);
+
+/* Callbacks for ieee80211_ops */
+void iwl_mvm_mac_tx(struct ieee80211_hw *hw,
+		    struct ieee80211_tx_control *control, struct sk_buff *skb);
+void iwl_mvm_mac_wake_tx_queue(struct ieee80211_hw *hw,
+			       struct ieee80211_txq *txq);
+
+int iwl_mvm_mac_ampdu_action(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif,
+			     struct ieee80211_ampdu_params *params);
+int iwl_mvm_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant);
+int iwl_mvm_mac_start(struct ieee80211_hw *hw);
+void iwl_mvm_mac_reconfig_complete(struct ieee80211_hw *hw,
+				   enum ieee80211_reconfig_type reconfig_type);
+void iwl_mvm_mac_stop(struct ieee80211_hw *hw);
+static inline int iwl_mvm_mac_config(struct ieee80211_hw *hw, u32 changed)
+{
+	return 0;
+}
+
+u64 iwl_mvm_prepare_multicast(struct ieee80211_hw *hw,
+			      struct netdev_hw_addr_list *mc_list);
+
+void iwl_mvm_configure_filter(struct ieee80211_hw *hw,
+			      unsigned int changed_flags,
+			      unsigned int *total_flags, u64 multicast);
+int iwl_mvm_mac_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			struct ieee80211_scan_request *hw_req);
+void iwl_mvm_mac_cancel_hw_scan(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif);
+void iwl_mvm_sta_pre_rcu_remove(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				struct ieee80211_sta *sta);
+void iwl_mvm_mac_sta_notify(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			    enum sta_notify_cmd cmd,
+			    struct ieee80211_sta *sta);
+void
+iwl_mvm_mac_allow_buffered_frames(struct ieee80211_hw *hw,
+				  struct ieee80211_sta *sta, u16 tids,
+				  int num_frames,
+				  enum ieee80211_frame_release_type reason,
+				  bool more_data);
+void
+iwl_mvm_mac_release_buffered_frames(struct ieee80211_hw *hw,
+				    struct ieee80211_sta *sta, u16 tids,
+				    int num_frames,
+				    enum ieee80211_frame_release_type reason,
+				    bool more_data);
+int iwl_mvm_mac_set_rts_threshold(struct ieee80211_hw *hw, u32 value);
+void iwl_mvm_sta_rc_update(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta, u32 changed);
+void iwl_mvm_mac_mgd_prepare_tx(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				struct ieee80211_prep_tx_info *info);
+void iwl_mvm_mac_mgd_complete_tx(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_prep_tx_info *info);
+void iwl_mvm_mac_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		       u32 queues, bool drop);
+int iwl_mvm_mac_sched_scan_start(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 struct cfg80211_sched_scan_request *req,
+				 struct ieee80211_scan_ies *ies);
+int iwl_mvm_mac_sched_scan_stop(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif);
+int iwl_mvm_mac_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
+			struct ieee80211_vif *vif, struct ieee80211_sta *sta,
+			struct ieee80211_key_conf *key);
+void iwl_mvm_mac_update_tkip_key(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_key_conf *keyconf,
+				 struct ieee80211_sta *sta,
+				 u32 iv32, u16 *phase1key);
+int iwl_mvm_add_chanctx(struct ieee80211_hw *hw,
+			struct ieee80211_chanctx_conf *ctx);
+void iwl_mvm_remove_chanctx(struct ieee80211_hw *hw,
+			    struct ieee80211_chanctx_conf *ctx);
+void iwl_mvm_change_chanctx(struct ieee80211_hw *hw,
+			    struct ieee80211_chanctx_conf *ctx, u32 changed);
+int iwl_mvm_tx_last_beacon(struct ieee80211_hw *hw);
+int iwl_mvm_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
+		    bool set);
+void iwl_mvm_channel_switch(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			    struct ieee80211_channel_switch *chsw);
+int iwl_mvm_pre_channel_switch(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *vif,
+			       struct ieee80211_channel_switch *chsw);
+void iwl_mvm_abort_channel_switch(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif);
+void iwl_mvm_channel_switch_rx_beacon(struct ieee80211_hw *hw,
+				      struct ieee80211_vif *vif,
+				      struct ieee80211_channel_switch *chsw);
+void iwl_mvm_mac_event_callback(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				const struct ieee80211_event *event);
+void iwl_mvm_sync_rx_queues(struct ieee80211_hw *hw);
+int iwl_mvm_mac_testmode_cmd(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif,
+			     void *data, int len);
+int iwl_mvm_mac_get_survey(struct ieee80211_hw *hw, int idx,
+			   struct survey_info *survey);
+void iwl_mvm_mac_sta_statistics(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				struct ieee80211_sta *sta,
+				struct station_info *sinfo);
+int
+iwl_mvm_mac_get_ftm_responder_stats(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    struct cfg80211_ftm_responder_stats *stats);
+int iwl_mvm_start_pmsr(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		       struct cfg80211_pmsr_request *request);
+void iwl_mvm_abort_pmsr(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			struct cfg80211_pmsr_request *request);
 #endif /* __IWL_MVM_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 5c8784ddfa66..b355b9ebad0a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1116,6 +1116,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	 ********************************/
 	hw = ieee80211_alloc_hw(sizeof(struct iwl_op_mode) +
 				sizeof(struct iwl_mvm),
+				iwl_mvm_has_mld_api(fw) ? &iwl_mvm_mld_hw_ops :
 				&iwl_mvm_hw_ops);
 	if (!hw)
 		return NULL;
@@ -1295,8 +1296,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	mvm->sta_remove_requires_queue_remove =
 		trans_cfg.queue_alloc_cmd_ver > 0;
 
-	/* Until we register with the MLD ops - we don't use the MLD API */
-	mvm->mld_api_is_used = false;
+	mvm->mld_api_is_used = iwl_mvm_has_mld_api(mvm->fw);
 
 	/* Configure transport layer */
 	iwl_trans_configure(mvm->trans, &trans_cfg);
-- 
2.38.1

