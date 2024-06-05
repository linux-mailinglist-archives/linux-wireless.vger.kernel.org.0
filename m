Return-Path: <linux-wireless+bounces-8555-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3A68FCA2F
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 13:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4650E285C0F
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 11:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D3D194148;
	Wed,  5 Jun 2024 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ede5oywp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9530A194146
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717586248; cv=none; b=YugEVT3ekg0+XxtAcFVN6SukOB3Brv7da4KvO3qIfWxDc1PoVgAjqsnghXTa9l1sg/1WgKVl/k10sNOR0N2sQ0lbWsEgklG12F7X7whCNsIQ/VvNND1hUyGfVmm8IcyxskYpYG7MHzKLq6HR1BTLOws9zBoeo8Ppq3ceMq3bBW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717586248; c=relaxed/simple;
	bh=RCxzwzuwhHd7E8i9CyjDWU6Jnw7HvOOTO0x3KJX52W8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pTMZWkJlX+BiL3o50DgFoAB/SceV8f0KizXXiiTqEvw/007DV7K/s1ZzBYBfnhZTrzCYU0QSn/itstinmzxlJLn05deTR0KnlTRjhKupV5Aw4NBqBlQEtgkNyFF6Y/xiVgONEAa2V/BMFl5X4ekx3nH4fKu7MC2RryZSmS8Ayug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ede5oywp; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717586247; x=1749122247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RCxzwzuwhHd7E8i9CyjDWU6Jnw7HvOOTO0x3KJX52W8=;
  b=ede5oywpL7xFw3qwUVvc2BaR6EfjG/Bt0lPoDkXrHUTfwFA9d6xTssYt
   HKpJAu4++DTJ2lp27WBitdytbBu5KygTEORptrE3GIWZdZKvjRAeeUKMk
   a+u8+XwNk80Vn9Wmnm96SIEs1ALIAgxZlcRVTO2EOPlB0/aTvFrCRs0Qa
   ZkXA94S8PV7QBgCDLwyDgkjBzOsq36WK2PuAblnJbqnikQQblufPfyfDw
   +Z/kBpbHruDFkT7EVWoUwpc7cUvqR3x0hHiHreYie59exdhTJu9mrI5EP
   dhOnYZJHkLU3ewvuBpymLDHRK6EgvGIQU0WGlD8zfSQSNPCc368ALwXyc
   w==;
X-CSE-ConnectionGUID: MF/tfbxlQICjpH7JJLMYAQ==
X-CSE-MsgGUID: KAJCUVSmS0iMNAkzz+i/Uw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="36718063"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="36718063"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:07:53 -0700
X-CSE-ConnectionGUID: Z8Z4Xo/2QO2tsIRAbU+r9Q==
X-CSE-MsgGUID: WVSCY+DQTVaVKP0OasYtoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="37433798"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:07:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Shaul Triebitz <shaul.triebitz@intel.com>
Subject: [PATCH 4/5] wifi: iwlwifi: mvm: use ROC for P2P device activities
Date: Wed,  5 Jun 2024 14:07:39 +0300
Message-Id: <20240605140556.8c90e457abbd.I8e340759ecb299e05b1809f3d8060429c6cbbd01@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605110740.2046411-1-miriam.rachel.korenblit@intel.com>
References: <20240605110740.2046411-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Shaul Triebitz <shaul.triebitz@intel.com>

This is the first step towards removing the P2P Device MAC.
Use ROC (which uses the AUX MAC) for P2P Device
discoveribility and action frames.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../intel/iwlwifi/fw/api/time-event.h         |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |   1 +
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  39 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  17 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   2 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   | 177 ++++++++++++------
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  38 ++--
 7 files changed, 196 insertions(+), 82 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h b/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
index 2e15be71c957..f4b827b58bd3 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2020, 2022-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2020, 2022-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -340,11 +340,13 @@ struct iwl_hs20_roc_res {
  * @ROC_ACTIVITY_HOTSPOT: ROC for hs20 activity
  * @ROC_ACTIVITY_P2P_DISC: ROC for p2p discoverability activity
  * @ROC_ACTIVITY_P2P_TXRX: ROC for p2p action frames activity
+ * @ROC_ACTIVITY_P2P_NEG: ROC for p2p negotiation (used also for TX)
  */
 enum iwl_roc_activity {
 	ROC_ACTIVITY_HOTSPOT,
 	ROC_ACTIVITY_P2P_DISC,
 	ROC_ACTIVITY_P2P_TXRX,
+	ROC_ACTIVITY_P2P_NEG,
 	ROC_NUM_ACTIVITIES
 }; /* ROC_ACTIVITY_API_E_VER_1 */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index f6baf7135efd..ce85a1eec931 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -296,6 +296,7 @@ int iwl_mvm_mac_ctxt_init(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 
 	INIT_LIST_HEAD(&mvmvif->time_event_data.list);
 	mvmvif->time_event_data.id = TE_MAX;
+	mvmvif->roc_activity = ROC_NUM_ACTIVITIES;
 
 	mvmvif->deflink.bcast_sta.sta_id = IWL_MVM_INVALID_STA;
 	mvmvif->deflink.mcast_sta.sta_id = IWL_MVM_INVALID_STA;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index d2b97e30d9eb..dac4b10b8c45 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -821,7 +821,7 @@ void iwl_mvm_mac_tx(struct ieee80211_hw *hw,
 	}
 
 	if (offchannel &&
-	    !test_bit(IWL_MVM_STATUS_ROC_RUNNING, &mvm->status) &&
+	    !test_bit(IWL_MVM_STATUS_ROC_P2P_RUNNING, &mvm->status) &&
 	    !test_bit(IWL_MVM_STATUS_ROC_AUX_RUNNING, &mvm->status))
 		goto drop;
 
@@ -1102,6 +1102,8 @@ static void iwl_mvm_cleanup_iterator(void *data, u8 *mac,
 	iwl_mvm_te_clear_data(mvm, &mvmvif->time_event_data);
 	spin_unlock_bh(&mvm->time_event_lock);
 
+	mvmvif->roc_activity = ROC_NUM_ACTIVITIES;
+
 	mvmvif->bf_enabled = false;
 	mvmvif->ba_enabled = false;
 	mvmvif->ap_sta = NULL;
@@ -4734,6 +4736,37 @@ static int iwl_mvm_roc_station(struct iwl_mvm *mvm,
 	return ret;
 }
 
+static int iwl_mvm_roc_p2p(struct iwl_mvm *mvm,
+			   struct ieee80211_channel *channel,
+			   struct ieee80211_vif *vif,
+			   int duration,
+			   enum ieee80211_roc_type type)
+{
+	enum iwl_roc_activity activity;
+	int ret;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	switch (type) {
+	case IEEE80211_ROC_TYPE_NORMAL:
+		activity = ROC_ACTIVITY_P2P_DISC;
+		break;
+	case IEEE80211_ROC_TYPE_MGMT_TX:
+		activity = ROC_ACTIVITY_P2P_NEG;
+		break;
+	default:
+		WARN_ONCE(1, "Got an invalid P2P ROC type\n");
+		return -EINVAL;
+	}
+
+	ret = iwl_mvm_mld_add_aux_sta(mvm,
+				      iwl_mvm_get_lmac_id(mvm, channel->band));
+	if (ret)
+		return ret;
+
+	return iwl_mvm_roc_add_cmd(mvm, channel, vif, duration, activity);
+}
+
 static int iwl_mvm_p2p_find_phy_ctxt(struct iwl_mvm *mvm,
 				     struct ieee80211_vif *vif,
 				     struct ieee80211_channel *channel)
@@ -4826,6 +4859,10 @@ int iwl_mvm_roc_common(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		return -EINVAL;
 	}
 
+	if (iwl_mvm_has_p2p_over_aux(mvm)) {
+		ret = iwl_mvm_roc_p2p(mvm, channel, vif, duration, type);
+		return ret;
+	}
 
 	ret = iwl_mvm_p2p_find_phy_ctxt(mvm, vif, channel);
 	if (ret)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index cb227dca4f87..351710a53f05 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -453,6 +453,8 @@ struct iwl_mvm_esr_exit {
  * @prevent_esr_done_wk: work that should be done when esr prevention ends.
  * @mlo_int_scan_wk: work for the internal MLO scan.
  * @unblock_esr_tpt_wk: work for unblocking EMLSR when tpt is high enough.
+ * @roc_activity: currently running ROC activity for this vif (or
+ *	ROC_NUM_ACTIVITIES if no activity is running).
  */
 struct iwl_mvm_vif {
 	struct iwl_mvm *mvm;
@@ -530,6 +532,7 @@ struct iwl_mvm_vif {
 
 	struct iwl_mvm_time_event_data time_event_data;
 	struct iwl_mvm_time_event_data hs_time_event_data;
+	enum iwl_roc_activity roc_activity;
 
 	/* TCP Checksum Offload */
 	netdev_features_t features;
@@ -1345,7 +1348,8 @@ DEFINE_GUARD(mvm, struct iwl_mvm *, mutex_lock(&_T->mutex), mutex_unlock(&_T->mu
  * enum iwl_mvm_status - MVM status bits
  * @IWL_MVM_STATUS_HW_RFKILL: HW RF-kill is asserted
  * @IWL_MVM_STATUS_HW_CTKILL: CT-kill is active
- * @IWL_MVM_STATUS_ROC_RUNNING: remain-on-channel is running
+ * @IWL_MVM_STATUS_ROC_P2P_RUNNING: remain-on-channel on P2P is running (when
+ *	P2P is not over AUX)
  * @IWL_MVM_STATUS_HW_RESTART_REQUESTED: HW restart was requested
  * @IWL_MVM_STATUS_IN_HW_RESTART: HW restart is active
  * @IWL_MVM_STATUS_ROC_AUX_RUNNING: AUX remain-on-channel is running
@@ -1359,7 +1363,7 @@ DEFINE_GUARD(mvm, struct iwl_mvm *, mutex_lock(&_T->mutex), mutex_unlock(&_T->mu
 enum iwl_mvm_status {
 	IWL_MVM_STATUS_HW_RFKILL,
 	IWL_MVM_STATUS_HW_CTKILL,
-	IWL_MVM_STATUS_ROC_RUNNING,
+	IWL_MVM_STATUS_ROC_P2P_RUNNING,
 	IWL_MVM_STATUS_HW_RESTART_REQUESTED,
 	IWL_MVM_STATUS_IN_HW_RESTART,
 	IWL_MVM_STATUS_ROC_AUX_RUNNING,
@@ -2772,6 +2776,13 @@ static inline void iwl_mvm_mei_set_sw_rfkill_state(struct iwl_mvm *mvm)
 					 sw_rfkill);
 }
 
+static inline bool iwl_mvm_has_p2p_over_aux(struct iwl_mvm *mvm)
+{
+	u32 cmd_id = WIDE_ID(MAC_CONF_GROUP, ROC_CMD);
+
+	return iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id, 0) >= 4;
+}
+
 static inline bool iwl_mvm_mei_filter_scan(struct iwl_mvm *mvm,
 					   struct sk_buff *skb)
 {
@@ -2937,7 +2948,7 @@ void iwl_mvm_roc_duration_and_delay(struct ieee80211_vif *vif,
 int iwl_mvm_roc_add_cmd(struct iwl_mvm *mvm,
 			struct ieee80211_channel *channel,
 			struct ieee80211_vif *vif,
-			int duration, u32 activity);
+			int duration, enum iwl_roc_activity activity);
 
 /* EMLSR */
 bool iwl_mvm_vif_has_esr_cap(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 85178fe1b7ea..f8a4fefede8d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -471,7 +471,7 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 		       iwl_mvm_time_sync_msmt_confirm_event, RX_HANDLER_SYNC,
 		       struct iwl_time_msmt_cfm_notify),
 	RX_HANDLER_GRP(MAC_CONF_GROUP, ROC_NOTIF,
-		       iwl_mvm_rx_roc_notif, RX_HANDLER_SYNC,
+		       iwl_mvm_rx_roc_notif, RX_HANDLER_ASYNC_LOCKED,
 		       struct iwl_roc_notif),
 	RX_HANDLER_GRP(SCAN_GROUP, CHANNEL_SURVEY_NOTIF,
 		       iwl_mvm_rx_channel_survey_notif, RX_HANDLER_ASYNC_LOCKED,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index c0322349bfcd..396ce0f1f311 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -53,7 +53,7 @@ static void iwl_mvm_cleanup_roc(struct iwl_mvm *mvm)
 	lockdep_assert_held(&mvm->mutex);
 
 	/*
-	 * Clear the ROC_RUNNING status bit.
+	 * Clear the ROC_P2P_RUNNING status bit.
 	 * This will cause the TX path to drop offchannel transmissions.
 	 * That would also be done by mac80211, but it is racy, in particular
 	 * in the case that the time event actually completed in the firmware.
@@ -63,7 +63,7 @@ static void iwl_mvm_cleanup_roc(struct iwl_mvm *mvm)
 	 * won't get stuck on the queue and be transmitted in the next
 	 * time event.
 	 */
-	if (test_and_clear_bit(IWL_MVM_STATUS_ROC_RUNNING, &mvm->status)) {
+	if (test_and_clear_bit(IWL_MVM_STATUS_ROC_P2P_RUNNING, &mvm->status)) {
 		struct iwl_mvm_vif *mvmvif;
 
 		synchronize_net();
@@ -100,7 +100,14 @@ static void iwl_mvm_cleanup_roc(struct iwl_mvm *mvm)
 		}
 	}
 
-	/* Do the same for AUX ROC */
+	/*
+	 * P2P AUX ROC and HS2.0 ROC do not run simultaneously.
+	 * Clear the ROC_AUX_RUNNING status bit.
+	 * This will cause the TX path to drop offchannel transmissions.
+	 * That would also be done by mac80211, but it is racy, in particular
+	 * in the case that the time event actually completed in the firmware
+	 * (which is handled in iwl_mvm_te_handle_notif).
+	 */
 	if (test_and_clear_bit(IWL_MVM_STATUS_ROC_AUX_RUNNING, &mvm->status)) {
 		synchronize_net();
 
@@ -379,7 +386,7 @@ static void iwl_mvm_te_handle_notif(struct iwl_mvm *mvm,
 		te_data->end_jiffies = TU_TO_EXP_TIME(te_data->duration);
 
 		if (te_data->vif->type == NL80211_IFTYPE_P2P_DEVICE) {
-			set_bit(IWL_MVM_STATUS_ROC_RUNNING, &mvm->status);
+			set_bit(IWL_MVM_STATUS_ROC_P2P_RUNNING, &mvm->status);
 			ieee80211_ready_on_channel(mvm->hw);
 		} else if (te_data->id == TE_CHANNEL_SWITCH_PERIOD) {
 			iwl_mvm_te_handle_notify_csa(mvm, te_data, notif);
@@ -389,14 +396,51 @@ static void iwl_mvm_te_handle_notif(struct iwl_mvm *mvm,
 	}
 }
 
+struct iwl_mvm_rx_roc_iterator_data {
+	u32 activity;
+	bool end_activity;
+	bool found;
+};
+
+static void iwl_mvm_rx_roc_iterator(void *_data, u8 *mac,
+				    struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_rx_roc_iterator_data *data = _data;
+
+	if (mvmvif->roc_activity == data->activity) {
+		data->found = true;
+		if (data->end_activity)
+			mvmvif->roc_activity = ROC_NUM_ACTIVITIES;
+	}
+}
+
 void iwl_mvm_rx_roc_notif(struct iwl_mvm *mvm,
 			  struct iwl_rx_cmd_buffer *rxb)
 {
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	struct iwl_roc_notif *notif = (void *)pkt->data;
+	u32 activity = le32_to_cpu(notif->activity);
+	bool started = le32_to_cpu(notif->success) &&
+		le32_to_cpu(notif->started);
+	struct iwl_mvm_rx_roc_iterator_data data = {
+		.activity = activity,
+		.end_activity = !started,
+	};
+
+	/* Clear vif roc_activity if done (set to ROC_NUM_ACTIVITIES) */
+	ieee80211_iterate_active_interfaces_atomic(mvm->hw,
+						   IEEE80211_IFACE_ITER_NORMAL,
+						   iwl_mvm_rx_roc_iterator,
+						   &data);
+	/*
+	 * It is possible that the ROC was canceled
+	 * but the notification was already fired.
+	 */
+	if (!data.found)
+		return;
 
-	if (le32_to_cpu(notif->success) && le32_to_cpu(notif->started) &&
-	    le32_to_cpu(notif->activity) == ROC_ACTIVITY_HOTSPOT) {
+	if (started) {
 		set_bit(IWL_MVM_STATUS_ROC_AUX_RUNNING, &mvm->status);
 		ieee80211_ready_on_channel(mvm->hw);
 	} else {
@@ -725,6 +769,21 @@ static void iwl_mvm_cancel_session_protection(struct iwl_mvm *mvm,
 			"Couldn't send the SESSION_PROTECTION_CMD: %d\n", ret);
 }
 
+static void iwl_mvm_roc_rm_cmd(struct iwl_mvm *mvm, u32 activity)
+{
+	struct iwl_roc_req roc_cmd = {
+		.action = cpu_to_le32(FW_CTXT_ACTION_REMOVE),
+		.activity = cpu_to_le32(activity),
+	};
+	int ret;
+
+	lockdep_assert_held(&mvm->mutex);
+	ret = iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(MAC_CONF_GROUP, ROC_CMD), 0,
+				   sizeof(roc_cmd), &roc_cmd);
+	if (ret)
+		IWL_ERR(mvm, "Couldn't send the ROC_CMD: %d\n", ret);
+}
+
 static bool __iwl_mvm_remove_time_event(struct iwl_mvm *mvm,
 					struct iwl_mvm_time_event_data *te_data,
 					u32 *uid)
@@ -734,6 +793,9 @@ static bool __iwl_mvm_remove_time_event(struct iwl_mvm *mvm,
 	struct iwl_mvm_vif *mvmvif;
 	enum nl80211_iftype iftype;
 	s8 link_id;
+	bool p2p_aux = iwl_mvm_has_p2p_over_aux(mvm);
+	u8 roc_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
+					   WIDE_ID(MAC_CONF_GROUP, ROC_CMD), 0);
 
 	if (!vif)
 		return false;
@@ -758,14 +820,22 @@ static bool __iwl_mvm_remove_time_event(struct iwl_mvm *mvm,
 	iwl_mvm_te_clear_data(mvm, te_data);
 	spin_unlock_bh(&mvm->time_event_lock);
 
-	/* When session protection is used, the te_data->id field
-	 * is reused to save session protection's configuration.
-	 * For AUX ROC, HOT_SPOT_CMD is used and the te_data->id field is set
-	 * to HOT_SPOT_CMD.
-	 */
-	if (fw_has_capa(&mvm->fw->ucode_capa,
-			IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD) &&
-	    id != HOT_SPOT_CMD) {
+	if ((p2p_aux && iftype == NL80211_IFTYPE_P2P_DEVICE) ||
+	    (roc_ver >= 3 && mvmvif->roc_activity == ROC_ACTIVITY_HOTSPOT)) {
+		if (mvmvif->roc_activity < ROC_NUM_ACTIVITIES) {
+			iwl_mvm_roc_rm_cmd(mvm, mvmvif->roc_activity);
+			mvmvif->roc_activity = ROC_NUM_ACTIVITIES;
+			iwl_mvm_roc_finished(mvm);
+		}
+		return false;
+	} else if (fw_has_capa(&mvm->fw->ucode_capa,
+			       IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD) &&
+		   id != HOT_SPOT_CMD) {
+		/* When session protection is used, the te_data->id field
+		 * is reused to save session protection's configuration.
+		 * For AUX ROC, HOT_SPOT_CMD is used and the te_data->id
+		 * field is set to HOT_SPOT_CMD.
+		 */
 		if (mvmvif && id < SESSION_PROTECT_CONF_MAX_ID) {
 			/* Session protection is still ongoing. Cancel it */
 			iwl_mvm_cancel_session_protection(mvm, vif, id,
@@ -966,7 +1036,7 @@ void iwl_mvm_rx_session_protect_notif(struct iwl_mvm *mvm,
 		if (WARN_ON(mvmvif->time_event_data.id !=
 				le32_to_cpu(notif->conf_id)))
 			goto out_unlock;
-		set_bit(IWL_MVM_STATUS_ROC_RUNNING, &mvm->status);
+		set_bit(IWL_MVM_STATUS_ROC_P2P_RUNNING, &mvm->status);
 		ieee80211_ready_on_channel(mvm->hw); /* Start TE */
 	}
 
@@ -1015,7 +1085,7 @@ void iwl_mvm_roc_duration_and_delay(struct ieee80211_vif *vif,
 int iwl_mvm_roc_add_cmd(struct iwl_mvm *mvm,
 			struct ieee80211_channel *channel,
 			struct ieee80211_vif *vif,
-			int duration, u32 activity)
+			int duration, enum iwl_roc_activity activity)
 {
 	int res;
 	u32 duration_tu, delay;
@@ -1024,9 +1094,13 @@ int iwl_mvm_roc_add_cmd(struct iwl_mvm *mvm,
 		.activity = cpu_to_le32(activity),
 		.sta_id = cpu_to_le32(mvm->aux_sta.sta_id),
 	};
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
 	lockdep_assert_held(&mvm->mutex);
 
+	if (WARN_ON(mvmvif->roc_activity != ROC_NUM_ACTIVITIES))
+		return -EBUSY;
+
 	/* Set the channel info data */
 	iwl_mvm_set_chan_info(mvm, &roc_req.channel_info,
 			      channel->hw_value,
@@ -1042,14 +1116,16 @@ int iwl_mvm_roc_add_cmd(struct iwl_mvm *mvm,
 		     "\t(requested = %ums, max_delay = %ums)\n",
 		     duration, delay);
 	IWL_DEBUG_TE(mvm,
-		     "Requesting to remain on channel %u for %utu\n",
-		     channel->hw_value, duration_tu);
+		     "Requesting to remain on channel %u for %utu. activity %u\n",
+		     channel->hw_value, duration_tu, activity);
 
 	/* Set the node address */
 	memcpy(roc_req.node_addr, vif->addr, ETH_ALEN);
 
 	res = iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(MAC_CONF_GROUP, ROC_CMD),
 				   0, sizeof(roc_req), &roc_req);
+	if (!res)
+		mvmvif->roc_activity = activity;
 
 	return res;
 }
@@ -1192,62 +1268,40 @@ void iwl_mvm_cleanup_roc_te(struct iwl_mvm *mvm)
 		__iwl_mvm_remove_time_event(mvm, te_data, &uid);
 }
 
-static void iwl_mvm_roc_rm_cmd(struct iwl_mvm *mvm, u32 activity)
-{
-	int ret;
-	struct iwl_roc_req roc_cmd = {
-		.action = cpu_to_le32(FW_CTXT_ACTION_REMOVE),
-		.activity = cpu_to_le32(activity),
-	};
-
-	lockdep_assert_held(&mvm->mutex);
-	ret = iwl_mvm_send_cmd_pdu(mvm,
-				   WIDE_ID(MAC_CONF_GROUP, ROC_CMD),
-				   0, sizeof(roc_cmd), &roc_cmd);
-	WARN_ON(ret);
-}
-
-static void iwl_mvm_roc_station_remove(struct iwl_mvm *mvm,
-				       struct iwl_mvm_vif *mvmvif)
-{
-	u32 cmd_id = WIDE_ID(MAC_CONF_GROUP, ROC_CMD);
-	u8 fw_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id,
-					  IWL_FW_CMD_VER_UNKNOWN);
-
-	if (fw_ver == IWL_FW_CMD_VER_UNKNOWN)
-		iwl_mvm_remove_aux_roc_te(mvm, mvmvif,
-					  &mvmvif->hs_time_event_data);
-	else if (fw_ver == 3)
-		iwl_mvm_roc_rm_cmd(mvm, ROC_ACTIVITY_HOTSPOT);
-	else
-		IWL_ERR(mvm, "ROC command version %d mismatch!\n", fw_ver);
-}
-
 void iwl_mvm_stop_roc(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
-	struct iwl_mvm_vif *mvmvif;
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_time_event_data *te_data;
+	bool p2p_aux = iwl_mvm_has_p2p_over_aux(mvm);
+	u8 roc_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
+					   WIDE_ID(MAC_CONF_GROUP, ROC_CMD), 0);
+	int iftype = vif->type;
 
 	mutex_lock(&mvm->mutex);
 
-	if (fw_has_capa(&mvm->fw->ucode_capa,
-			IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD)) {
-		mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	if (p2p_aux || (roc_ver >= 3 && iftype != NL80211_IFTYPE_P2P_DEVICE)) {
+		if (mvmvif->roc_activity < ROC_NUM_ACTIVITIES) {
+			iwl_mvm_roc_rm_cmd(mvm, mvmvif->roc_activity);
+			mvmvif->roc_activity = ROC_NUM_ACTIVITIES;
+		}
+		goto cleanup_roc;
+	} else if (fw_has_capa(&mvm->fw->ucode_capa,
+			       IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD)) {
 		te_data = &mvmvif->time_event_data;
 
-		if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
+		if (iftype == NL80211_IFTYPE_P2P_DEVICE) {
 			if (te_data->id >= SESSION_PROTECT_CONF_MAX_ID) {
 				IWL_DEBUG_TE(mvm,
 					     "No remain on channel event\n");
 				mutex_unlock(&mvm->mutex);
 				return;
 			}
-
 			iwl_mvm_cancel_session_protection(mvm, vif,
 							  te_data->id,
 							  te_data->link_id);
 		} else {
-			iwl_mvm_roc_station_remove(mvm, mvmvif);
+			iwl_mvm_remove_aux_roc_te(mvm, mvmvif,
+						  &mvmvif->hs_time_event_data);
 		}
 		goto cleanup_roc;
 	}
@@ -1260,8 +1314,8 @@ void iwl_mvm_stop_roc(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	}
 
 	mvmvif = iwl_mvm_vif_from_mac80211(te_data->vif);
-
-	if (te_data->vif->type == NL80211_IFTYPE_P2P_DEVICE)
+	iftype = te_data->vif->type;
+	if (iftype == NL80211_IFTYPE_P2P_DEVICE)
 		iwl_mvm_remove_time_event(mvm, mvmvif, te_data);
 	else
 		iwl_mvm_remove_aux_roc_te(mvm, mvmvif, te_data);
@@ -1272,9 +1326,10 @@ void iwl_mvm_stop_roc(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	 * (so the status bit isn't set) set it here so iwl_mvm_cleanup_roc will
 	 * cleanup things properly
 	 */
-	set_bit(vif->type == NL80211_IFTYPE_P2P_DEVICE ?
-		IWL_MVM_STATUS_ROC_RUNNING : IWL_MVM_STATUS_ROC_AUX_RUNNING,
-		&mvm->status);
+	if (p2p_aux || iftype != NL80211_IFTYPE_P2P_DEVICE)
+		set_bit(IWL_MVM_STATUS_ROC_AUX_RUNNING, &mvm->status);
+	else
+		set_bit(IWL_MVM_STATUS_ROC_P2P_RUNNING, &mvm->status);
 
 	/* Mutex is released inside this function */
 	iwl_mvm_cleanup_roc(mvm);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 599550f311de..7ff5ea5e7aca 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -802,10 +802,30 @@ int iwl_mvm_tx_skb_non_sta(struct iwl_mvm *mvm, struct sk_buff *skb)
 	if (info.control.vif) {
 		struct iwl_mvm_vif *mvmvif =
 			iwl_mvm_vif_from_mac80211(info.control.vif);
+		bool p2p_aux = iwl_mvm_has_p2p_over_aux(mvm);
 
-		if (info.control.vif->type == NL80211_IFTYPE_P2P_DEVICE ||
-		    info.control.vif->type == NL80211_IFTYPE_AP ||
-		    info.control.vif->type == NL80211_IFTYPE_ADHOC) {
+		if ((info.control.vif->type == NL80211_IFTYPE_P2P_DEVICE &&
+		     p2p_aux) ||
+		    (info.control.vif->type == NL80211_IFTYPE_STATION &&
+		     offchannel)) {
+			/*
+			 * IWL_MVM_OFFCHANNEL_QUEUE is used for ROC packets
+			 * that can be used in 2 different types of vifs, P2P
+			 * Device and STATION.
+			 * P2P Device uses the offchannel queue.
+			 * STATION (HS2.0) uses the auxiliary context of the FW,
+			 * and hence needs to be sent on the aux queue.
+			 * If P2P_DEV_OVER_AUX is supported (p2p_aux = true)
+			 * also P2P Device uses the aux queue.
+			 */
+			sta_id = mvm->aux_sta.sta_id;
+			queue = mvm->aux_queue;
+			if (WARN_ON(queue == IWL_MVM_INVALID_QUEUE))
+				return -1;
+		} else if (info.control.vif->type ==
+			   NL80211_IFTYPE_P2P_DEVICE ||
+			   info.control.vif->type == NL80211_IFTYPE_AP ||
+			   info.control.vif->type == NL80211_IFTYPE_ADHOC) {
 			u32 link_id = u32_get_bits(info.control.flags,
 						   IEEE80211_TX_CTRL_MLO_LINK);
 			struct iwl_mvm_vif_link_info *link;
@@ -831,18 +851,6 @@ int iwl_mvm_tx_skb_non_sta(struct iwl_mvm *mvm, struct sk_buff *skb)
 		} else if (info.control.vif->type == NL80211_IFTYPE_MONITOR) {
 			queue = mvm->snif_queue;
 			sta_id = mvm->snif_sta.sta_id;
-		} else if (info.control.vif->type == NL80211_IFTYPE_STATION &&
-			   offchannel) {
-			/*
-			 * IWL_MVM_OFFCHANNEL_QUEUE is used for ROC packets
-			 * that can be used in 2 different types of vifs, P2P &
-			 * STATION.
-			 * P2P uses the offchannel queue.
-			 * STATION (HS2.0) uses the auxiliary context of the FW,
-			 * and hence needs to be sent on the aux queue.
-			 */
-			sta_id = mvm->aux_sta.sta_id;
-			queue = mvm->aux_queue;
 		}
 	}
 
-- 
2.34.1


