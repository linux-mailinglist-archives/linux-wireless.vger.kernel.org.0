Return-Path: <linux-wireless+bounces-7540-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 527E88C3678
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 14:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82E91F2205B
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 12:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B732208A9;
	Sun, 12 May 2024 12:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ma6aExWL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3621129414
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 12:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715516726; cv=none; b=k18tgdi8bkYnVzCfwVcs0B2ImP2z3chAqaXdU3XRVdXB439fmMf0p+rmOCjjZ2zmS424oRQ2nxpfrbRZKBUF/KBigWrM4ww87rvDQby3AMQ3JuNuzrW7gyB3wGp62YY4BZlt9mIDoXwQv+phiIr5KPv7YrywN3xusOjD8WIQH/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715516726; c=relaxed/simple;
	bh=kOsxh5o6L5bC+Hv3pn27eZoAPGJ/WqzZdIxQlLBGbXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S87cauF9OUs9+1lqxZwCPxHFJH+cLRU79gSo3748whk1wHRHl23urb2cMq5nVertipFmcXd0QA8+Y1wpQh8ThBdmXx1YRRB7cFtr1oaeEUyrtsMzKVcEuA8PbuPMf1ZY9nIQFTpQaWk/b2Ok5SR0DNaLceK5HSWgg2ohbvE7wqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ma6aExWL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715516723; x=1747052723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kOsxh5o6L5bC+Hv3pn27eZoAPGJ/WqzZdIxQlLBGbXI=;
  b=Ma6aExWL42ZE7xHogtGTzYSj+FBiOLb1a/yA0c0dR5YOSI/Wwi2ymRn0
   LbSQBROphLwGlb6aa941Yox5t5y7mxGEyh8v6UFvTvlJOpn8G/tjlHsfo
   8ZvZxFzzg/2IqKNd5AHvUzGO+IvyvkHGFP4XItkc5x0KBSx2j3DgmOBjV
   a+NPElCa8jznegiF/6kILSdcwDUf7nzsNiYCYuewMr9csfcccg+t2S96M
   JmyynnC4JeHOrZxUpOTnhr58myoPmbtsu7UJkj79xjtgI5fG1PtloE7la
   TazrPOB7nNAA+CYITqXzP7pdR+4CsjeADcu1qbSQnl1xeAIheHk328aTh
   w==;
X-CSE-ConnectionGUID: LdPucAYQR9eRy+FDBSHf9g==
X-CSE-MsgGUID: xjStBQj9QIC+HjPQnPpKTQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11397197"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11397197"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:25:22 -0700
X-CSE-ConnectionGUID: 4PuZVbAMTze/+7lqKO08xQ==
X-CSE-MsgGUID: U3ece7deRY2vXXbmOzKraw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34761314"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:25:21 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 05/14] wifi: iwlwifi: mvm: add mvm-specific guard
Date: Sun, 12 May 2024 15:24:58 +0300
Message-Id: <20240512152312.7391425b3af2.I1b109f56753dd3f35602dd2c5cf6e1e35aee313d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512122507.3812527-1-miriam.rachel.korenblit@intel.com>
References: <20240512122507.3812527-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Add and use an mvm-specific guard for the mvm mutex.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 225 ++++++------------
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  88 +++----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  14 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c |  34 +--
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |  60 ++---
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |   7 +-
 7 files changed, 136 insertions(+), 295 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index de9f0b446545..4267b8ed6790 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1295,7 +1295,7 @@ static void iwl_mvm_restart_complete(struct iwl_mvm *mvm)
 {
 	int ret;
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 
 	clear_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status);
 
@@ -1311,8 +1311,6 @@ static void iwl_mvm_restart_complete(struct iwl_mvm *mvm)
 	 * of packets the FW sent out, so we must reconnect.
 	 */
 	iwl_mvm_teardown_tdls_peers(mvm);
-
-	mutex_unlock(&mvm->mutex);
 }
 
 void iwl_mvm_mac_reconfig_complete(struct ieee80211_hw *hw,
@@ -1658,9 +1656,8 @@ static void iwl_mvm_prevent_esr_done_wk(struct wiphy *wiphy,
 	struct iwl_mvm *mvm = mvmvif->mvm;
 	struct ieee80211_vif *vif = iwl_mvm_get_bss_vif(mvm);
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 	iwl_mvm_unblock_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_PREVENTION);
-	mutex_unlock(&mvm->mutex);
 }
 
 static void iwl_mvm_mlo_int_scan_wk(struct wiphy *wiphy, struct wiphy_work *wk)
@@ -1670,11 +1667,8 @@ static void iwl_mvm_mlo_int_scan_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 	struct ieee80211_vif *vif =
 		container_of((void *)mvmvif, struct ieee80211_vif, drv_priv);
 
-	mutex_lock(&mvmvif->mvm->mutex);
-
+	guard(mvm)(mvmvif->mvm);
 	iwl_mvm_int_mlo_scan(mvmvif->mvm, vif);
-
-	mutex_unlock(&mvmvif->mvm->mutex);
 }
 
 static void iwl_mvm_unblock_esr_tpt(struct wiphy *wiphy, struct wiphy_work *wk)
@@ -1684,9 +1678,8 @@ static void iwl_mvm_unblock_esr_tpt(struct wiphy *wiphy, struct wiphy_work *wk)
 	struct iwl_mvm *mvm = mvmvif->mvm;
 	struct ieee80211_vif *vif = iwl_mvm_get_bss_vif(mvm);
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 	iwl_mvm_unblock_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_TPT);
-	mutex_unlock(&mvm->mutex);
 }
 
 void iwl_mvm_mac_init_mvmvif(struct iwl_mvm *mvm, struct iwl_mvm_vif *mvmvif)
@@ -2076,7 +2069,7 @@ void iwl_mvm_configure_filter(struct ieee80211_hw *hw,
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mcast_filter_cmd *cmd = (void *)(unsigned long)multicast;
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 
 	/* replace previous configuration */
 	kfree(mvm->mcast_filter_cmd);
@@ -2093,7 +2086,6 @@ void iwl_mvm_configure_filter(struct ieee80211_hw *hw,
 
 	iwl_mvm_recalc_multicast(mvm);
 out:
-	mutex_unlock(&mvm->mutex);
 	*total_flags = 0;
 }
 
@@ -2113,9 +2105,8 @@ static void iwl_mvm_config_iface_filter(struct ieee80211_hw *hw,
 	    !vif->p2p)
 		return;
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 	iwl_mvm_mac_ctxt_changed(mvm, vif, false, NULL);
-	mutex_unlock(&mvm->mutex);
 }
 
 int iwl_mvm_update_mu_groups(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
@@ -3160,7 +3151,7 @@ static void iwl_mvm_stop_ap_ibss(struct ieee80211_hw *hw,
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 
 	iwl_mvm_stop_ap_ibss_common(mvm, vif);
 
@@ -3190,8 +3181,6 @@ static void iwl_mvm_stop_ap_ibss(struct ieee80211_hw *hw,
 	iwl_mvm_power_update_mac(mvm);
 
 	iwl_mvm_mac_ctxt_remove(mvm, vif);
-
-	mutex_unlock(&mvm->mutex);
 }
 
 static void iwl_mvm_stop_ap(struct ieee80211_hw *hw,
@@ -3246,7 +3235,7 @@ static void iwl_mvm_bss_info_changed(struct ieee80211_hw *hw,
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 
 	if (changes & BSS_CHANGED_IDLE && !vif->cfg.idle)
 		iwl_mvm_scan_stop(mvm, IWL_MVM_SCAN_SCHED, true);
@@ -3273,25 +3262,19 @@ static void iwl_mvm_bss_info_changed(struct ieee80211_hw *hw,
 				bss_conf->txpower);
 		iwl_mvm_set_tx_power(mvm, vif, bss_conf->txpower);
 	}
-
-	mutex_unlock(&mvm->mutex);
 }
 
 int iwl_mvm_mac_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			struct ieee80211_scan_request *hw_req)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-	int ret;
 
 	if (hw_req->req.n_channels == 0 ||
 	    hw_req->req.n_channels > mvm->fw->ucode_capa.n_scan_channels)
 		return -EINVAL;
 
-	mutex_lock(&mvm->mutex);
-	ret = iwl_mvm_reg_scan_start(mvm, vif, &hw_req->req, &hw_req->ies);
-	mutex_unlock(&mvm->mutex);
-
-	return ret;
+	guard(mvm)(mvm);
+	return iwl_mvm_reg_scan_start(mvm, vif, &hw_req->req, &hw_req->ies);
 }
 
 void iwl_mvm_mac_cancel_hw_scan(struct ieee80211_hw *hw,
@@ -3299,7 +3282,7 @@ void iwl_mvm_mac_cancel_hw_scan(struct ieee80211_hw *hw,
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 
 	/* Due to a race condition, it's possible that mac80211 asks
 	 * us to stop a hw_scan when it's already stopped.  This can
@@ -3310,8 +3293,6 @@ void iwl_mvm_mac_cancel_hw_scan(struct ieee80211_hw *hw,
 	*/
 	if (mvm->scan_status & IWL_MVM_SCAN_REGULAR)
 		iwl_mvm_scan_stop(mvm, IWL_MVM_SCAN_REGULAR, true);
-
-	mutex_unlock(&mvm->mutex);
 }
 
 void
@@ -3480,7 +3461,7 @@ void iwl_mvm_sta_pre_rcu_remove(struct ieee80211_hw *hw,
 	 * Since there's mvm->mutex here, no need to have RCU lock for
 	 * mvm_sta->link access.
 	 */
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 	for (link_id = 0; link_id < ARRAY_SIZE(mvm_sta->link); link_id++) {
 		struct iwl_mvm_link_sta *link_sta;
 		u32 sta_id;
@@ -3497,7 +3478,6 @@ void iwl_mvm_sta_pre_rcu_remove(struct ieee80211_hw *hw,
 			RCU_INIT_POINTER(mvm->fw_id_to_link_sta[sta_id], NULL);
 		}
 	}
-	mutex_unlock(&mvm->mutex);
 }
 
 static void iwl_mvm_check_uapsd(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
@@ -4244,12 +4224,8 @@ static int iwl_mvm_mac_conf_tx(struct ieee80211_hw *hw,
 	 * The exception is P2P_DEVICE interface which needs immediate update.
 	 */
 	if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
-		int ret;
-
-		mutex_lock(&mvm->mutex);
-		ret = iwl_mvm_mac_ctxt_changed(mvm, vif, false, NULL);
-		mutex_unlock(&mvm->mutex);
-		return ret;
+		guard(mvm)(mvm);
+		return iwl_mvm_mac_ctxt_changed(mvm, vif, false, NULL);
 	}
 	return 0;
 }
@@ -4260,9 +4236,8 @@ void iwl_mvm_mac_mgd_prepare_tx(struct ieee80211_hw *hw,
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 	iwl_mvm_protect_assoc(mvm, vif, info->duration, info->link_id);
-	mutex_unlock(&mvm->mutex);
 }
 
 void iwl_mvm_mac_mgd_complete_tx(struct ieee80211_hw *hw,
@@ -4275,9 +4250,8 @@ void iwl_mvm_mac_mgd_complete_tx(struct ieee80211_hw *hw,
 	if (info->success)
 		return;
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 	iwl_mvm_stop_session_protection(mvm, vif);
-	mutex_unlock(&mvm->mutex);
 }
 
 int iwl_mvm_mac_sched_scan_start(struct ieee80211_hw *hw,
@@ -4287,20 +4261,12 @@ int iwl_mvm_mac_sched_scan_start(struct ieee80211_hw *hw,
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
-	int ret;
-
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 
-	if (!vif->cfg.idle) {
-		ret = -EBUSY;
-		goto out;
-	}
-
-	ret = iwl_mvm_sched_scan_start(mvm, vif, req, ies, IWL_MVM_SCAN_SCHED);
+	if (!vif->cfg.idle)
+		return -EBUSY;
 
-out:
-	mutex_unlock(&mvm->mutex);
-	return ret;
+	return iwl_mvm_sched_scan_start(mvm, vif, req, ies, IWL_MVM_SCAN_SCHED);
 }
 
 int iwl_mvm_mac_sched_scan_stop(struct ieee80211_hw *hw,
@@ -4578,13 +4544,9 @@ int iwl_mvm_mac_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			struct ieee80211_key_conf *key)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-	int ret;
 
-	mutex_lock(&mvm->mutex);
-	ret = __iwl_mvm_mac_set_key(hw, cmd, vif, sta, key);
-	mutex_unlock(&mvm->mutex);
-
-	return ret;
+	guard(mvm)(mvm);
+	return __iwl_mvm_mac_set_key(hw, cmd, vif, sta, key);
 }
 
 void iwl_mvm_mac_update_tkip_key(struct ieee80211_hw *hw,
@@ -4875,7 +4837,7 @@ int iwl_mvm_roc_common(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (ret)
 		return ret;
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_STATION:
@@ -4885,30 +4847,25 @@ int iwl_mvm_roc_common(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		ret = ops->add_aux_sta_for_hs20(mvm, lmac_id);
 		if (!ret)
 			ret = iwl_mvm_roc_station(mvm, channel, vif, duration);
-		goto out_unlock;
+		return ret;
 	case NL80211_IFTYPE_P2P_DEVICE:
 		/* handle below */
 		break;
 	default:
 		IWL_ERR(mvm, "ROC: Invalid vif type=%u\n", vif->type);
-		ret = -EINVAL;
-		goto out_unlock;
+		return -EINVAL;
 	}
 
 
 	ret = iwl_mvm_p2p_find_phy_ctxt(mvm, vif, channel);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	ret = ops->link(mvm, vif);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
-	ret = iwl_mvm_start_p2p_roc(mvm, vif, duration, type);
-out_unlock:
-	mutex_unlock(&mvm->mutex);
-	IWL_DEBUG_MAC80211(mvm, "leave\n");
-	return ret;
+	return iwl_mvm_start_p2p_roc(mvm, vif, duration, type);
 }
 
 int iwl_mvm_cancel_roc(struct ieee80211_hw *hw,
@@ -4989,13 +4946,9 @@ int iwl_mvm_add_chanctx(struct ieee80211_hw *hw,
 			struct ieee80211_chanctx_conf *ctx)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-	int ret;
 
-	mutex_lock(&mvm->mutex);
-	ret = __iwl_mvm_add_chanctx(mvm, ctx);
-	mutex_unlock(&mvm->mutex);
-
-	return ret;
+	guard(mvm)(mvm);
+	return __iwl_mvm_add_chanctx(mvm, ctx);
 }
 
 static void __iwl_mvm_remove_chanctx(struct iwl_mvm *mvm,
@@ -5014,9 +4967,8 @@ void iwl_mvm_remove_chanctx(struct ieee80211_hw *hw,
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 	__iwl_mvm_remove_chanctx(mvm, ctx);
-	mutex_unlock(&mvm->mutex);
 }
 
 void iwl_mvm_change_chanctx(struct ieee80211_hw *hw,
@@ -5036,26 +4988,23 @@ void iwl_mvm_change_chanctx(struct ieee80211_hw *hw,
 		      phy_ctxt->ref, changed))
 		return;
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 
 	/* we are only changing the min_width, may be a noop */
 	if (changed == IEEE80211_CHANCTX_CHANGE_MIN_WIDTH) {
 		if (phy_ctxt->width == def->width)
-			goto out_unlock;
+			return;
 
 		/* we are just toggling between 20_NOHT and 20 */
 		if (phy_ctxt->width <= NL80211_CHAN_WIDTH_20 &&
 		    def->width <= NL80211_CHAN_WIDTH_20)
-			goto out_unlock;
+			return;
 	}
 
 	iwl_mvm_bt_coex_vif_change(mvm);
 	iwl_mvm_phy_ctxt_changed(mvm, phy_ctxt, def, &ctx->ap,
 				 ctx->rx_chains_static,
 				 ctx->rx_chains_dynamic);
-
-out_unlock:
-	mutex_unlock(&mvm->mutex);
 }
 
 /*
@@ -5194,13 +5143,9 @@ static int iwl_mvm_assign_vif_chanctx(struct ieee80211_hw *hw,
 				      struct ieee80211_chanctx_conf *ctx)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-	int ret;
 
-	mutex_lock(&mvm->mutex);
-	ret = __iwl_mvm_assign_vif_chanctx(mvm, vif, link_conf, ctx, false);
-	mutex_unlock(&mvm->mutex);
-
-	return ret;
+	guard(mvm)(mvm);
+	return __iwl_mvm_assign_vif_chanctx(mvm, vif, link_conf, ctx, false);
 }
 
 /*
@@ -5288,9 +5233,8 @@ static void iwl_mvm_unassign_vif_chanctx(struct ieee80211_hw *hw,
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 	__iwl_mvm_unassign_vif_chanctx(mvm, vif, link_conf, ctx, false);
-	mutex_unlock(&mvm->mutex);
 }
 
 static int
@@ -5300,7 +5244,7 @@ iwl_mvm_switch_vif_chanctx_swap(struct iwl_mvm *mvm,
 {
 	int ret;
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 	ops->__unassign_vif_chanctx(mvm, vifs[0].vif, vifs[0].link_conf,
 				    vifs[0].old_ctx, true);
 	__iwl_mvm_remove_chanctx(mvm, vifs[0].old_ctx);
@@ -5323,7 +5267,7 @@ iwl_mvm_switch_vif_chanctx_swap(struct iwl_mvm *mvm,
 	if (iwl_mvm_phy_ctx_count(mvm) > 1)
 		iwl_mvm_teardown_tdls_peers(mvm);
 
-	goto out;
+	return 0;
 
 out_remove:
 	__iwl_mvm_remove_chanctx(mvm, vifs[0].new_ctx);
@@ -5340,15 +5284,11 @@ iwl_mvm_switch_vif_chanctx_swap(struct iwl_mvm *mvm,
 		goto out_restart;
 	}
 
-	goto out;
+	return ret;
 
 out_restart:
 	/* things keep failing, better restart the hw */
 	iwl_mvm_nic_restart(mvm, false);
-
-out:
-	mutex_unlock(&mvm->mutex);
-
 	return ret;
 }
 
@@ -5359,7 +5299,7 @@ iwl_mvm_switch_vif_chanctx_reassign(struct iwl_mvm *mvm,
 {
 	int ret;
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 	ops->__unassign_vif_chanctx(mvm, vifs[0].vif, vifs[0].link_conf,
 				    vifs[0].old_ctx, true);
 
@@ -5371,7 +5311,7 @@ iwl_mvm_switch_vif_chanctx_reassign(struct iwl_mvm *mvm,
 		goto out_reassign;
 	}
 
-	goto out;
+	return 0;
 
 out_reassign:
 	if (ops->__assign_vif_chanctx(mvm, vifs[0].vif, vifs[0].link_conf,
@@ -5380,15 +5320,11 @@ iwl_mvm_switch_vif_chanctx_reassign(struct iwl_mvm *mvm,
 		goto out_restart;
 	}
 
-	goto out;
+	return ret;
 
 out_restart:
 	/* things keep failing, better restart the hw */
 	iwl_mvm_nic_restart(mvm, false);
-
-out:
-	mutex_unlock(&mvm->mutex);
-
 	return ret;
 }
 
@@ -5515,13 +5451,9 @@ int iwl_mvm_mac_testmode_cmd(struct ieee80211_hw *hw,
 			     void *data, int len)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-	int err;
 
-	mutex_lock(&mvm->mutex);
-	err = __iwl_mvm_mac_testmode_cmd(mvm, vif, data, len);
-	mutex_unlock(&mvm->mutex);
-
-	return err;
+	guard(mvm)(mvm);
+	return __iwl_mvm_mac_testmode_cmd(mvm, vif, data, len);
 }
 #endif
 
@@ -5738,13 +5670,9 @@ static int iwl_mvm_mac_pre_channel_switch(struct ieee80211_hw *hw,
 					  struct ieee80211_channel_switch *chsw)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-	int ret;
 
-	mutex_lock(&mvm->mutex);
-	ret = iwl_mvm_pre_channel_switch(mvm, vif, chsw);
-	mutex_unlock(&mvm->mutex);
-
-	return ret;
+	guard(mvm)(mvm);
+	return iwl_mvm_pre_channel_switch(mvm, vif, chsw);
 }
 
 void iwl_mvm_channel_switch_rx_beacon(struct ieee80211_hw *hw,
@@ -5796,16 +5724,14 @@ void iwl_mvm_channel_switch_rx_beacon(struct ieee80211_hw *hw,
 	}
 	mvmvif->csa_count = chsw->count;
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 	if (mvmvif->csa_failed)
-		goto out_unlock;
+		return;
 
 	WARN_ON(iwl_mvm_send_cmd_pdu(mvm,
 				     WIDE_ID(MAC_CONF_GROUP,
 					     CHANNEL_SWITCH_TIME_EVENT_CMD),
 				     0, sizeof(cmd), &cmd));
-out_unlock:
-	mutex_unlock(&mvm->mutex);
 }
 
 static void iwl_mvm_flush_no_vif(struct iwl_mvm *mvm, u32 queues, bool drop)
@@ -5814,17 +5740,16 @@ static void iwl_mvm_flush_no_vif(struct iwl_mvm *mvm, u32 queues, bool drop)
 
 	if (!iwl_mvm_has_new_tx_api(mvm)) {
 		if (drop) {
-			mutex_lock(&mvm->mutex);
+			guard(mvm)(mvm);
 			iwl_mvm_flush_tx_path(mvm,
 				iwl_mvm_flushable_queues(mvm) & queues);
-			mutex_unlock(&mvm->mutex);
 		} else {
 			iwl_trans_wait_tx_queues_empty(mvm->trans, queues);
 		}
 		return;
 	}
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++) {
 		struct ieee80211_sta *sta;
 
@@ -5839,7 +5764,6 @@ static void iwl_mvm_flush_no_vif(struct iwl_mvm *mvm, u32 queues, bool drop)
 			iwl_mvm_wait_sta_queues_empty(mvm,
 					iwl_mvm_sta_from_mac80211(sta));
 	}
-	mutex_unlock(&mvm->mutex);
 }
 
 void iwl_mvm_mac_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
@@ -5922,7 +5846,7 @@ void iwl_mvm_mac_flush_sta(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct ieee80211_link_sta *link_sta;
 	int link_id;
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 	for_each_sta_active_link(vif, sta, link_sta, link_id) {
 		mvm_link_sta = rcu_dereference_protected(mvmsta->link[link_id],
 							 lockdep_is_held(&mvm->mutex));
@@ -5933,7 +5857,6 @@ void iwl_mvm_mac_flush_sta(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 				      mvmsta->tfd_queue_msk))
 			IWL_ERR(mvm, "flush request fail\n");
 	}
-	mutex_unlock(&mvm->mutex);
 }
 
 static int iwl_mvm_mac_get_acs_survey(struct iwl_mvm *mvm, int idx,
@@ -5999,7 +5922,6 @@ int iwl_mvm_mac_get_survey(struct ieee80211_hw *hw, int idx,
 			   struct survey_info *survey)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-	int ret = 0;
 	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
 					   WIDE_ID(SYSTEM_GROUP,
 						   SYSTEM_STATISTICS_CMD),
@@ -6019,12 +5941,13 @@ int iwl_mvm_mac_get_survey(struct ieee80211_hw *hw, int idx,
 	if (idx > 0)
 		return iwl_mvm_mac_get_acs_survey(mvm, idx - 1, survey);
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 
 	if (iwl_mvm_firmware_running(mvm)) {
-		ret = iwl_mvm_request_statistics(mvm, false);
+		int ret = iwl_mvm_request_statistics(mvm, false);
+
 		if (ret)
-			goto out;
+			return ret;
 	}
 
 	survey->filled = SURVEY_INFO_TIME_RX |
@@ -6040,7 +5963,7 @@ int iwl_mvm_mac_get_survey(struct ieee80211_hw *hw, int idx,
 
 	/* the new fw api doesn't support the following fields */
 	if (cmd_ver != IWL_FW_CMD_VER_UNKNOWN)
-		goto out;
+		return 0;
 
 	survey->filled |= SURVEY_INFO_TIME |
 			  SURVEY_INFO_TIME_SCAN;
@@ -6052,9 +5975,7 @@ int iwl_mvm_mac_get_survey(struct ieee80211_hw *hw, int idx,
 			    mvm->radio_stats.on_time_scan;
 	do_div(survey->time_scan, USEC_PER_MSEC);
 
- out:
-	mutex_unlock(&mvm->mutex);
-	return ret;
+	return 0;
 }
 
 static void iwl_mvm_set_sta_rate(u32 rate_n_flags, struct rate_info *rinfo)
@@ -6221,13 +6142,13 @@ void iwl_mvm_mac_sta_statistics(struct ieee80211_hw *hw,
 	if (!vif->cfg.assoc)
 		return;
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 
 	if (mvmvif->deflink.ap_sta_id != mvmsta->deflink.sta_id)
-		goto unlock;
+		return;
 
 	if (iwl_mvm_request_statistics(mvm, false))
-		goto unlock;
+		return;
 
 	sinfo->rx_beacon = 0;
 	for_each_mvm_vif_valid_link(mvmvif, i)
@@ -6241,8 +6162,6 @@ void iwl_mvm_mac_sta_statistics(struct ieee80211_hw *hw,
 			mvmvif->deflink.beacon_stats.avg_signal;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_SIGNAL_AVG);
 	}
- unlock:
-	mutex_unlock(&mvm->mutex);
 }
 
 static void iwl_mvm_event_mlme_callback_ini(struct iwl_mvm *mvm,
@@ -6430,9 +6349,8 @@ void iwl_mvm_sync_rx_queues(struct ieee80211_hw *hw)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 	iwl_mvm_sync_rx_queues_internal(mvm, IWL_MVM_RXQ_EMPTY, true, NULL, 0);
-	mutex_unlock(&mvm->mutex);
 }
 
 int
@@ -6468,13 +6386,9 @@ int iwl_mvm_start_pmsr(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		       struct cfg80211_pmsr_request *request)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-	int ret;
 
-	mutex_lock(&mvm->mutex);
-	ret = iwl_mvm_ftm_start(mvm, vif, request);
-	mutex_unlock(&mvm->mutex);
-
-	return ret;
+	guard(mvm)(mvm);
+	return iwl_mvm_ftm_start(mvm, vif, request);
 }
 
 void iwl_mvm_abort_pmsr(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
@@ -6482,9 +6396,8 @@ void iwl_mvm_abort_pmsr(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 	iwl_mvm_ftm_abort(mvm, request);
-	mutex_unlock(&mvm->mutex);
 }
 
 static bool iwl_mvm_can_hw_csum(struct sk_buff *skb)
@@ -6519,7 +6432,6 @@ int iwl_mvm_set_hw_timestamp(struct ieee80211_hw *hw,
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	u32 protocols = 0;
-	int ret;
 
 	/* HW timestamping is only supported for a specific station */
 	if (!hwts->macaddr)
@@ -6529,11 +6441,8 @@ int iwl_mvm_set_hw_timestamp(struct ieee80211_hw *hw,
 		protocols =
 			IWL_TIME_SYNC_PROTOCOL_TM | IWL_TIME_SYNC_PROTOCOL_FTM;
 
-	mutex_lock(&mvm->mutex);
-	ret = iwl_mvm_time_sync_config(mvm, hwts->macaddr, protocols);
-	mutex_unlock(&mvm->mutex);
-
-	return ret;
+	guard(mvm)(mvm);
+	return iwl_mvm_time_sync_config(mvm, hwts->macaddr, protocols);
 }
 
 const struct ieee80211_ops iwl_mvm_hw_ops = {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 0a3b7284eedd..f69f7df40a6d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -12,7 +12,7 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 	int ret;
 	int i;
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 
 	iwl_mvm_mac_init_mvmvif(mvm, mvmvif);
 
@@ -32,7 +32,7 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 	/* Allocate resources for the MAC context, and add it to the fw  */
 	ret = iwl_mvm_mac_ctxt_init(mvm, vif);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	rcu_assign_pointer(mvm->vif_id_to_mac[mvmvif->id], vif);
 
@@ -46,7 +46,7 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 
 	ret = iwl_mvm_mld_mac_ctxt_add(mvm, vif);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	/* beacon filtering */
 	ret = iwl_mvm_disable_beacon_filter(mvm, vif);
@@ -97,7 +97,7 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 	if (vif->p2p || iwl_fw_lookup_cmd_ver(mvm->fw, PHY_CONTEXT_CMD, 1) < 5)
 		vif->driver_flags |= IEEE80211_VIF_IGNORE_OFDMA_WIDER_BW;
 
-	goto out_unlock;
+	return 0;
 
  out_free_bf:
 	if (mvm->bf_allowed_vif == mvmvif) {
@@ -108,9 +108,6 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
  out_remove_mac:
 	mvmvif->link[0] = NULL;
 	iwl_mvm_mld_mac_ctxt_remove(mvm, vif);
- out_unlock:
-	mutex_unlock(&mvm->mutex);
-
 	return ret;
 }
 
@@ -127,7 +124,7 @@ static void iwl_mvm_mld_mac_remove_interface(struct ieee80211_hw *hw,
 	      vif->type == NL80211_IFTYPE_ADHOC))
 		iwl_mvm_tcm_rm_vif(mvm, vif);
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 
 	if (vif == mvm->csme_vif) {
 		iwl_mei_set_netdev(NULL);
@@ -190,8 +187,6 @@ static void iwl_mvm_mld_mac_remove_interface(struct ieee80211_hw *hw,
 		mvm->monitor_on = false;
 		__clear_bit(IEEE80211_HW_RX_INCLUDES_FCS, mvm->hw->flags);
 	}
-
-	mutex_unlock(&mvm->mutex);
 }
 
 static unsigned int iwl_mvm_mld_count_active_links(struct iwl_mvm_vif *mvmvif)
@@ -389,10 +384,11 @@ static int iwl_mvm_mld_assign_vif_chanctx(struct ieee80211_hw *hw,
 					  struct ieee80211_chanctx_conf *ctx)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-	int ret;
 
 	/* update EMLSR mode */
 	if (ieee80211_vif_type_p2p(vif) != NL80211_IFTYPE_STATION) {
+		int ret;
+
 		ret = iwl_mvm_esr_non_bss_link(mvm, vif, link_conf->link_id,
 					       true);
 		/*
@@ -403,11 +399,8 @@ static int iwl_mvm_mld_assign_vif_chanctx(struct ieee80211_hw *hw,
 			return ret;
 	}
 
-	mutex_lock(&mvm->mutex);
-	ret = __iwl_mvm_mld_assign_vif_chanctx(mvm, vif, link_conf, ctx, false);
-	mutex_unlock(&mvm->mutex);
-
-	return ret;
+	guard(mvm)(mvm);
+	return __iwl_mvm_mld_assign_vif_chanctx(mvm, vif, link_conf, ctx, false);
 }
 
 static int iwl_mvm_esr_mode_inactive(struct iwl_mvm *mvm,
@@ -586,7 +579,7 @@ static int iwl_mvm_mld_start_ap_ibss(struct ieee80211_hw *hw,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	int ret;
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 
 	if (vif->type == NL80211_IFTYPE_AP)
 		iwl_mvm_send_ap_tx_power_constraint_cmd(mvm, vif, link_conf);
@@ -594,7 +587,7 @@ static int iwl_mvm_mld_start_ap_ibss(struct ieee80211_hw *hw,
 	/* Send the beacon template */
 	ret = iwl_mvm_mac_ctxt_beacon_changed(mvm, vif, link_conf);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	/* the link should be already activated when assigning chan context */
 	ret = iwl_mvm_link_changed(mvm, vif, link_conf,
@@ -602,11 +595,11 @@ static int iwl_mvm_mld_start_ap_ibss(struct ieee80211_hw *hw,
 				   ~LINK_CONTEXT_MODIFY_ACTIVE,
 				   true);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	ret = iwl_mvm_mld_add_mcast_sta(mvm, vif, link_conf);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	/* Send the bcast station. At this stage the TBTT and DTIM time
 	 * events are added and applied to the scheduler
@@ -630,7 +623,7 @@ static int iwl_mvm_mld_start_ap_ibss(struct ieee80211_hw *hw,
 
 	iwl_mvm_ftm_restart_responder(mvm, vif, link_conf);
 
-	goto out_unlock;
+	return 0;
 
 out_failed:
 	iwl_mvm_power_update_mac(mvm);
@@ -638,8 +631,6 @@ static int iwl_mvm_mld_start_ap_ibss(struct ieee80211_hw *hw,
 	iwl_mvm_mld_rm_bcast_sta(mvm, vif, link_conf);
 out_rm_mcast:
 	iwl_mvm_mld_rm_mcast_sta(mvm, vif, link_conf);
-out_unlock:
-	mutex_unlock(&mvm->mutex);
 	return ret;
 }
 
@@ -662,7 +653,7 @@ static void iwl_mvm_mld_stop_ap_ibss(struct ieee80211_hw *hw,
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 
 	iwl_mvm_stop_ap_ibss_common(mvm, vif);
 
@@ -676,7 +667,6 @@ static void iwl_mvm_mld_stop_ap_ibss(struct ieee80211_hw *hw,
 	iwl_mvm_mld_rm_mcast_sta(mvm, vif, link_conf);
 
 	iwl_mvm_power_update_mac(mvm);
-	mutex_unlock(&mvm->mutex);
 }
 
 static void iwl_mvm_mld_stop_ap(struct ieee80211_hw *hw,
@@ -979,7 +969,7 @@ static void iwl_mvm_mld_link_info_changed(struct ieee80211_hw *hw,
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_STATION:
@@ -1005,8 +995,6 @@ static void iwl_mvm_mld_link_info_changed(struct ieee80211_hw *hw,
 				link_conf->txpower);
 		iwl_mvm_set_tx_power(mvm, vif, link_conf->txpower);
 	}
-
-	mutex_unlock(&mvm->mutex);
 }
 
 static void iwl_mvm_mld_vif_cfg_changed(struct ieee80211_hw *hw,
@@ -1015,15 +1003,13 @@ static void iwl_mvm_mld_vif_cfg_changed(struct ieee80211_hw *hw,
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 
 	if (changes & BSS_CHANGED_IDLE && !vif->cfg.idle)
 		iwl_mvm_scan_stop(mvm, IWL_MVM_SCAN_SCHED, true);
 
 	if (vif->type == NL80211_IFTYPE_STATION)
 		iwl_mvm_mld_vif_cfg_changed_station(mvm, vif, changes);
-
-	mutex_unlock(&mvm->mutex);
 }
 
 static int
@@ -1056,9 +1042,8 @@ static void iwl_mvm_mld_config_iface_filter(struct ieee80211_hw *hw,
 	    !vif->p2p)
 		return;
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 	iwl_mvm_mld_mac_ctxt_changed(mvm, vif, false);
-	mutex_unlock(&mvm->mutex);
 }
 
 static int
@@ -1080,14 +1065,10 @@ iwl_mvm_mld_mac_conf_tx(struct ieee80211_hw *hw,
 	 * The exception is P2P_DEVICE interface which needs immediate update.
 	 */
 	if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
-		int ret;
-
-		mutex_lock(&mvm->mutex);
-		ret = iwl_mvm_link_changed(mvm, vif, &vif->bss_conf,
-					   LINK_CONTEXT_MODIFY_QOS_PARAMS,
-					   true);
-		mutex_unlock(&mvm->mutex);
-		return ret;
+		guard(mvm)(mvm);
+		return iwl_mvm_link_changed(mvm, vif, &vif->bss_conf,
+					    LINK_CONTEXT_MODIFY_QOS_PARAMS,
+					    true);
 	}
 	return 0;
 }
@@ -1232,13 +1213,9 @@ iwl_mvm_mld_change_sta_links(struct ieee80211_hw *hw,
 			     u16 old_links, u16 new_links)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-	int ret;
-
-	mutex_lock(&mvm->mutex);
-	ret = iwl_mvm_mld_update_sta_links(mvm, vif, sta, old_links, new_links);
-	mutex_unlock(&mvm->mutex);
 
-	return ret;
+	guard(mvm)(mvm);
+	return iwl_mvm_mld_update_sta_links(mvm, vif, sta, old_links, new_links);
 }
 
 bool iwl_mvm_vif_has_esr_cap(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
@@ -1266,26 +1243,19 @@ static bool iwl_mvm_mld_can_activate_links(struct ieee80211_hw *hw,
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	int n_links = hweight16(desired_links);
-	bool ret = true;
 
 	if (n_links <= 1)
 		return true;
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 
 	/* Check if HW supports the wanted number of links */
-	if (n_links > iwl_mvm_max_active_links(mvm, vif)) {
-		ret = false;
-		goto unlock;
-	}
+	if (n_links > iwl_mvm_max_active_links(mvm, vif))
+		return false;
 
 	/* If it is an eSR device, check that we can enter eSR */
-	ret = iwl_mvm_is_esr_supported(mvm->fwrt.trans) &&
-	      iwl_mvm_vif_has_esr_cap(mvm, vif);
-
-unlock:
-	mutex_unlock(&mvm->mutex);
-	return ret;
+	return iwl_mvm_is_esr_supported(mvm->fwrt.trans) &&
+	       iwl_mvm_vif_has_esr_cap(mvm, vif);
 }
 
 static enum ieee80211_neg_ttlm_res
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index d732780aae5f..dd4599ca1f45 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -9,6 +9,7 @@
 
 #include <linux/list.h>
 #include <linux/spinlock.h>
+#include <linux/cleanup.h>
 #include <linux/leds.h>
 #include <linux/in6.h>
 
@@ -1332,6 +1333,8 @@ struct iwl_mvm {
 #define IWL_MAC80211_GET_MVM(_hw)			\
 	IWL_OP_MODE_GET_MVM((struct iwl_op_mode *)((_hw)->priv))
 
+DEFINE_GUARD(mvm, struct iwl_mvm *, mutex_lock(&_T->mutex), mutex_unlock(&_T->mutex))
+
 /**
  * enum iwl_mvm_status - MVM status bits
  * @IWL_MVM_STATUS_HW_RFKILL: HW RF-kill is asserted
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index c3cd5ab11aec..160bb619ba9b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -765,20 +765,18 @@ static void iwl_mvm_tx_unblock_dwork(struct work_struct *work)
 	struct ieee80211_vif *tx_blocked_vif;
 	struct iwl_mvm_vif *mvmvif;
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 
 	tx_blocked_vif =
 		rcu_dereference_protected(mvm->csa_tx_blocked_vif,
 					  lockdep_is_held(&mvm->mutex));
 
 	if (!tx_blocked_vif)
-		goto unlock;
+		return;
 
 	mvmvif = iwl_mvm_vif_from_mac80211(tx_blocked_vif);
 	iwl_mvm_modify_all_sta_disable_tx(mvm, mvmvif, false);
 	RCU_INIT_POINTER(mvm->csa_tx_blocked_vif, NULL);
-unlock:
-	mutex_unlock(&mvm->mutex);
 }
 
 static void iwl_mvm_fwrt_dump_start(void *ctx)
@@ -798,13 +796,9 @@ static void iwl_mvm_fwrt_dump_end(void *ctx)
 static int iwl_mvm_fwrt_send_hcmd(void *ctx, struct iwl_host_cmd *host_cmd)
 {
 	struct iwl_mvm *mvm = (struct iwl_mvm *)ctx;
-	int ret;
 
-	mutex_lock(&mvm->mutex);
-	ret = iwl_mvm_send_cmd(mvm, host_cmd);
-	mutex_unlock(&mvm->mutex);
-
-	return ret;
+	guard(mvm)(mvm);
+	return iwl_mvm_send_cmd(mvm, host_cmd);
 }
 
 static bool iwl_mvm_d3_debug_enable(void *ctx)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
index e7d5f4ebeb25..3d25ff5cd7e8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2014 Intel Mobile Communications GmbH
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2020, 2022-2023 Intel Corporation
+ * Copyright (C) 2018-2020, 2022-2024 Intel Corporation
  */
 #include <linux/etherdevice.h>
 #include "mvm.h"
@@ -151,7 +151,7 @@ void iwl_mvm_mac_mgd_protect_tdls_discover(struct ieee80211_hw *hw,
 	u32 duration = 2 * vif->bss_conf.dtim_period * vif->bss_conf.beacon_int;
 
 	/* Protect the session to hear the TDLS setup response on the channel */
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 	if (fw_has_capa(&mvm->fw->ucode_capa,
 			IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD))
 		iwl_mvm_schedule_session_protection(mvm, vif, duration,
@@ -159,7 +159,6 @@ void iwl_mvm_mac_mgd_protect_tdls_discover(struct ieee80211_hw *hw,
 	else
 		iwl_mvm_protect_session(mvm, vif, duration,
 					duration, 100, true);
-	mutex_unlock(&mvm->mutex);
 }
 
 static const char *
@@ -460,21 +459,21 @@ void iwl_mvm_tdls_ch_switch_work(struct work_struct *work)
 	int ret;
 
 	mvm = container_of(work, struct iwl_mvm, tdls_cs.dwork.work);
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 
 	/* called after an active channel switch has finished or timed-out */
 	iwl_mvm_tdls_update_cs_state(mvm, IWL_MVM_TDLS_SW_IDLE);
 
 	/* station might be gone, in that case do nothing */
 	if (mvm->tdls_cs.peer.sta_id == IWL_MVM_INVALID_STA)
-		goto out;
+		return;
 
 	sta = rcu_dereference_protected(
 				mvm->fw_id_to_mac_id[mvm->tdls_cs.peer.sta_id],
 				lockdep_is_held(&mvm->mutex));
 	/* the station may not be here, but if it is, it must be a TDLS peer */
 	if (!sta || IS_ERR(sta) || WARN_ON(!sta->tdls))
-		goto out;
+		return;
 
 	mvmsta = iwl_mvm_sta_from_mac80211(sta);
 	vif = mvmsta->vif;
@@ -493,8 +492,6 @@ void iwl_mvm_tdls_ch_switch_work(struct work_struct *work)
 	/* retry after a DTIM if we failed sending now */
 	delay = TU_TO_MS(vif->bss_conf.dtim_period * vif->bss_conf.beacon_int);
 	schedule_delayed_work(&mvm->tdls_cs.dwork, msecs_to_jiffies(delay));
-out:
-	mutex_unlock(&mvm->mutex);
 }
 
 int
@@ -509,7 +506,7 @@ iwl_mvm_tdls_channel_switch(struct ieee80211_hw *hw,
 	unsigned int delay;
 	int ret;
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 
 	IWL_DEBUG_TDLS(mvm, "TDLS channel switch with %pM ch %d width %d\n",
 		       sta->addr, chandef->chan->center_freq, chandef->width);
@@ -519,8 +516,7 @@ iwl_mvm_tdls_channel_switch(struct ieee80211_hw *hw,
 		IWL_DEBUG_TDLS(mvm,
 			       "Existing peer. Can't start switch with %pM\n",
 			       sta->addr);
-		ret = -EBUSY;
-		goto out;
+		return -EBUSY;
 	}
 
 	ret = iwl_mvm_tdls_config_channel_switch(mvm, vif,
@@ -529,17 +525,15 @@ iwl_mvm_tdls_channel_switch(struct ieee80211_hw *hw,
 						 oper_class, chandef, 0, 0, 0,
 						 tmpl_skb, ch_sw_tm_ie);
 	if (ret)
-		goto out;
+		return ret;
 
 	/*
 	 * Mark the peer as "in tdls switch" for this vif. We only allow a
 	 * single such peer per vif.
 	 */
 	mvm->tdls_cs.peer.skb = skb_copy(tmpl_skb, GFP_KERNEL);
-	if (!mvm->tdls_cs.peer.skb) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!mvm->tdls_cs.peer.skb)
+		return -ENOMEM;
 
 	mvmsta = iwl_mvm_sta_from_mac80211(sta);
 	mvm->tdls_cs.peer.sta_id = mvmsta->deflink.sta_id;
@@ -556,10 +550,7 @@ iwl_mvm_tdls_channel_switch(struct ieee80211_hw *hw,
 			     vif->bss_conf.beacon_int);
 	mod_delayed_work(system_wq, &mvm->tdls_cs.dwork,
 			 msecs_to_jiffies(delay));
-
-out:
-	mutex_unlock(&mvm->mutex);
-	return ret;
+	return 0;
 }
 
 void iwl_mvm_tdls_cancel_channel_switch(struct ieee80211_hw *hw,
@@ -626,7 +617,7 @@ iwl_mvm_tdls_recv_channel_switch(struct ieee80211_hw *hw,
 		params->action_code == WLAN_TDLS_CHANNEL_SWITCH_REQUEST ?
 		"REQ" : "RESP";
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 
 	IWL_DEBUG_TDLS(mvm,
 		       "Received TDLS ch switch action %s from %pM status %d\n",
@@ -670,5 +661,4 @@ iwl_mvm_tdls_recv_channel_switch(struct ieee80211_hw *hw,
 		1024 / 1000;
 	mod_delayed_work(system_wq, &mvm->tdls_cs.dwork,
 			 msecs_to_jiffies(delay));
-	mutex_unlock(&mvm->mutex);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index 61a4638d1be2..45b431ffbc97 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2019-2022 Intel Corporation
+ * Copyright (C) 2012-2014, 2019-2022, 2024 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2016 Intel Deutschland GmbH
  */
@@ -618,48 +618,35 @@ static int iwl_mvm_tzone_get_temp(struct thermal_zone_device *device,
 	int ret;
 	int temp;
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 
 	if (!iwl_mvm_firmware_running(mvm) ||
-	    mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
-		ret = -ENODATA;
-		goto out;
-	}
+	    mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR)
+		return -ENODATA;
 
 	ret = iwl_mvm_get_temp(mvm, &temp);
 	if (ret)
-		goto out;
+		return ret;
 
 	*temperature = temp * 1000;
-
-out:
-	mutex_unlock(&mvm->mutex);
-	return ret;
+	return 0;
 }
 
 static int iwl_mvm_tzone_set_trip_temp(struct thermal_zone_device *device,
 				       int trip, int temp)
 {
 	struct iwl_mvm *mvm = thermal_zone_device_priv(device);
-	int ret;
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 
 	if (!iwl_mvm_firmware_running(mvm) ||
-	    mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
-		ret = -EIO;
-		goto out;
-	}
+	    mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR)
+		return -EIO;
 
-	if ((temp / 1000) > S16_MAX) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if ((temp / 1000) > S16_MAX)
+		return -EINVAL;
 
-	ret = iwl_mvm_send_temp_report_ths_cmd(mvm);
-out:
-	mutex_unlock(&mvm->mutex);
-	return ret;
+	return iwl_mvm_send_temp_report_ths_cmd(mvm);
 }
 
 static  struct thermal_zone_device_ops tzone_ops = {
@@ -733,27 +720,18 @@ static int iwl_mvm_tcool_set_cur_state(struct thermal_cooling_device *cdev,
 				       unsigned long new_state)
 {
 	struct iwl_mvm *mvm = (struct iwl_mvm *)(cdev->devdata);
-	int ret;
 
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 
 	if (!iwl_mvm_firmware_running(mvm) ||
-	    mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
-		ret = -EIO;
-		goto unlock;
-	}
+	    mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR)
+		return -EIO;
 
-	if (new_state >= ARRAY_SIZE(iwl_mvm_cdev_budgets)) {
-		ret = -EINVAL;
-		goto unlock;
-	}
-
-	ret = iwl_mvm_ctdp_command(mvm, CTDP_CMD_OPERATION_START,
-				   new_state);
+	if (new_state >= ARRAY_SIZE(iwl_mvm_cdev_budgets))
+		return -EINVAL;
 
-unlock:
-	mutex_unlock(&mvm->mutex);
-	return ret;
+	return iwl_mvm_ctdp_command(mvm, CTDP_CMD_OPERATION_START,
+				    new_state);
 }
 
 static const struct thermal_cooling_device_ops tcooling_ops = {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 47283a358ffd..0e5fa8374103 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -892,7 +892,7 @@ static void iwl_mvm_tcm_iter(void *_data, u8 *mac, struct ieee80211_vif *vif)
 
 static void iwl_mvm_tcm_results(struct iwl_mvm *mvm)
 {
-	mutex_lock(&mvm->mutex);
+	guard(mvm)(mvm);
 
 	ieee80211_iterate_active_interfaces(
 		mvm->hw, IEEE80211_IFACE_ITER_NORMAL,
@@ -900,8 +900,6 @@ static void iwl_mvm_tcm_results(struct iwl_mvm *mvm)
 
 	if (fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_UMAC_SCAN))
 		iwl_mvm_config_scan(mvm);
-
-	mutex_unlock(&mvm->mutex);
 }
 
 static void iwl_mvm_tcm_uapsd_nonagg_detected_wk(struct work_struct *wk)
@@ -1130,10 +1128,9 @@ void iwl_mvm_recalc_tcm(struct iwl_mvm *mvm)
 	spin_unlock(&mvm->tcm.lock);
 
 	if (handle_uapsd && iwl_mvm_has_new_rx_api(mvm)) {
-		mutex_lock(&mvm->mutex);
+		guard(mvm)(mvm);
 		if (iwl_mvm_request_statistics(mvm, true))
 			handle_uapsd = false;
-		mutex_unlock(&mvm->mutex);
 	}
 
 	spin_lock(&mvm->tcm.lock);
-- 
2.34.1


