Return-Path: <linux-wireless+bounces-7183-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 395A98BBF71
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 08:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CA441C20C74
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 06:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B411FC4;
	Sun,  5 May 2024 06:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DAQ1bVyb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1724B3FD4
	for <linux-wireless@vger.kernel.org>; Sun,  5 May 2024 06:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714890028; cv=none; b=Bpt6QeqBDtxCzkMzh/M8fBJ27qXmpBpP7UDeYZXQ6hb6Xf1rtjDx/BXKCyEIY6mPNQ7zyoyoALjDswARyx3Xcc7GB12pkh6iVZsKsH7CcUNd8q/gdCRLEQ8mEiJnmTky/1xA1elOqIeapKKsUTgA8CwKb9zkhOnLJKiwHeh+N70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714890028; c=relaxed/simple;
	bh=3TNFJrvG+8++CKCEXaguoE8KyyOS0KjuTAnpGhzwjnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S/gFCl2Op8oMK0WVvyNfHnHM1qq75c9ZeUilyHicbCC6Dfs60an59nSu1pQM8MC8Vq7PXUFCirjvR1LXcwOFAyMa4PpR/5gmBD+MCtVGsjmv6nMUBpOPQeEacmcgRqzQX/ahl7P0cm40uY+0eUMpmUQPrx/5C+Bzv9zW1wxCrOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DAQ1bVyb; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714890026; x=1746426026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3TNFJrvG+8++CKCEXaguoE8KyyOS0KjuTAnpGhzwjnQ=;
  b=DAQ1bVybIhlX8Qc6N1iVDgTKvKKHkH/3kA2N2eeoPqfCDgYoszBIIdxc
   HnoX/BkhXZvqlTnL7bF0wTMa1DrYZmBT7Mupta7SUQvYTVpynYJb22KOv
   bf8MMJvDreIoYrdc+ojo1+fEbfzAq/wqcUL+KPAuPUaIF4P0xSsVhdLsQ
   t93i1YGraJsSITFKvuQDgEhjVKFwSmfYMxaFINBSWIcZl/2MViAQjNzJJ
   A17KxE6z0xyB4v3CpZaPIkuAHw8LJ1xwmdeRwkVvu+71xPZjpYfy8HI1R
   wmv3jtv4poQ1osEy8r50PTcPbGXOT3OTL8omMfy+hmd8tW5DBTWEJTNTn
   Q==;
X-CSE-ConnectionGUID: p0XUEeZCRkC7F068EXbQbg==
X-CSE-MsgGUID: gNtkjlwNR+q+fP3Gg/HRow==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="14461811"
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="14461811"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:22 -0700
X-CSE-ConnectionGUID: hn8W32EdTlGqYJ7mncO7oQ==
X-CSE-MsgGUID: 7G8mecuCTMCnLnUyTa9N5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="27903604"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:22 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 06/15] wifi: iwlwifi: mvm: Activate EMLSR based on traffic volume
Date: Sun,  5 May 2024 09:19:50 +0300
Message-Id: <20240505091420.9480f99ac8fc.If9eb946e929a39e10fe5f4638bc8bc3f8976edf1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240505061959.825245-1-miriam.rachel.korenblit@intel.com>
References: <20240505061959.825245-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Adjust EMLSR activation to account for traffic levels. By
tracking the number of RX/TX MPDUs, EMLSR will be activated only when
traffic volume meets the required threshold.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/constants.h    |  2 +
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 21 +++++
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 34 ++++++++
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |  5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  4 +
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   | 50 +++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 19 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 86 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  | 24 ++++++
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  7 +-
 10 files changed, 244 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index 965fbad05531..3cbeaddf4358 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -15,6 +15,7 @@
 #define IWL_MVM_BT_COEX_ENABLE_ESR_THRESH	63
 #define IWL_MVM_BT_COEX_WIFI_LOSS_THRESH	0
 #define IWL_MVM_TRIGGER_LINK_SEL_TIME_SEC	30
+#define IWL_MVM_TPT_COUNT_WINDOW_SEC		5
 
 #define IWL_MVM_DEFAULT_PS_TX_DATA_TIMEOUT	(100 * USEC_PER_MSEC)
 #define IWL_MVM_DEFAULT_PS_RX_DATA_TIMEOUT	(100 * USEC_PER_MSEC)
@@ -135,4 +136,5 @@
 #define IWL_MVM_HIGH_RSSI_THRESH_160MHZ		-58
 #define IWL_MVM_LOW_RSSI_THRESH_160MHZ		-61
 
+#define IWL_MVM_ENTER_ESR_TPT_THRESH		400
 #endif /* __MVM_CONSTANTS_H */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index c8477afe3fc6..4c94f753c951 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1639,6 +1639,18 @@ static void iwl_mvm_mlo_int_scan_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 	mutex_unlock(&mvmvif->mvm->mutex);
 }
 
+static void iwl_mvm_unblock_esr_tpt(struct wiphy *wiphy, struct wiphy_work *wk)
+{
+	struct iwl_mvm_vif *mvmvif =
+		container_of(wk, struct iwl_mvm_vif, unblock_esr_tpt_wk);
+	struct iwl_mvm *mvm = mvmvif->mvm;
+	struct ieee80211_vif *vif = iwl_mvm_get_bss_vif(mvm);
+
+	mutex_lock(&mvm->mutex);
+	iwl_mvm_unblock_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_TPT);
+	mutex_unlock(&mvm->mutex);
+}
+
 void iwl_mvm_mac_init_mvmvif(struct iwl_mvm *mvm, struct iwl_mvm_vif *mvmvif)
 {
 	lockdep_assert_held(&mvm->mutex);
@@ -1654,6 +1666,9 @@ void iwl_mvm_mac_init_mvmvif(struct iwl_mvm *mvm, struct iwl_mvm_vif *mvmvif)
 
 	wiphy_delayed_work_init(&mvmvif->mlo_int_scan_wk,
 				iwl_mvm_mlo_int_scan_wk);
+
+	wiphy_work_init(&mvmvif->unblock_esr_tpt_wk,
+			iwl_mvm_unblock_esr_tpt);
 }
 
 static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
@@ -1803,6 +1818,8 @@ void iwl_mvm_prepare_mac_removal(struct iwl_mvm *mvm,
 	wiphy_delayed_work_cancel(mvm->hw->wiphy,
 				  &mvmvif->mlo_int_scan_wk);
 
+	wiphy_work_cancel(mvm->hw->wiphy, &mvmvif->unblock_esr_tpt_wk);
+
 	cancel_delayed_work_sync(&mvmvif->csa_work);
 }
 
@@ -3930,6 +3947,8 @@ iwl_mvm_sta_state_assoc_to_authorized(struct iwl_mvm *mvm,
 		memset(&mvmvif->last_esr_exit, 0,
 		       sizeof(mvmvif->last_esr_exit));
 
+		iwl_mvm_block_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_TPT, 0);
+
 		/* when client is authorized (AP station marked as such),
 		 * try to enable the best link(s).
 		 */
@@ -3990,6 +4009,8 @@ iwl_mvm_sta_state_authorized_to_assoc(struct iwl_mvm *mvm,
 		wiphy_delayed_work_cancel(mvm->hw->wiphy,
 					  &mvmvif->mlo_int_scan_wk);
 
+		wiphy_work_cancel(mvm->hw->wiphy, &mvmvif->unblock_esr_tpt_wk);
+
 		/* No need for the periodic statistics anymore */
 		if (ieee80211_vif_is_mld(vif) && mvmvif->esr_active)
 			iwl_mvm_request_periodic_system_statistics(mvm, false);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 5609b0321647..305f194ae7b2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -207,6 +207,30 @@ static unsigned int iwl_mvm_mld_count_active_links(struct iwl_mvm_vif *mvmvif)
 	return n_active;
 }
 
+static void iwl_mvm_restart_mpdu_count(struct iwl_mvm *mvm,
+				       struct iwl_mvm_vif *mvmvif)
+{
+	struct ieee80211_sta *ap_sta = mvmvif->ap_sta;
+	struct iwl_mvm_sta *mvmsta;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	if (!ap_sta)
+		return;
+
+	mvmsta = iwl_mvm_sta_from_mac80211(ap_sta);
+	if (!mvmsta->mpdu_counters)
+		return;
+
+	for (int q = 0; q < mvm->trans->num_rx_queues; q++) {
+		spin_lock_bh(&mvmsta->mpdu_counters[q].lock);
+		memset(mvmsta->mpdu_counters[q].per_link, 0,
+		       sizeof(mvmsta->mpdu_counters[q].per_link));
+		mvmsta->mpdu_counters[q].window_start = jiffies;
+		spin_unlock_bh(&mvmsta->mpdu_counters[q].lock);
+	}
+}
+
 static int iwl_mvm_esr_mode_active(struct iwl_mvm *mvm,
 				   struct ieee80211_vif *vif)
 {
@@ -243,6 +267,13 @@ static int iwl_mvm_esr_mode_active(struct iwl_mvm *mvm,
 	/* Needed for tracking RSSI */
 	iwl_mvm_request_periodic_system_statistics(mvm, true);
 
+	/*
+	 * Restart the MPDU counters and the counting window, so when the
+	 * statistics arrive (which is where we look at the counters) we
+	 * will be at the end of the window.
+	 */
+	iwl_mvm_restart_mpdu_count(mvm, mvmvif);
+
 	return ret;
 }
 
@@ -412,6 +443,9 @@ static int iwl_mvm_esr_mode_inactive(struct iwl_mvm *mvm,
 
 	iwl_mvm_request_periodic_system_statistics(mvm, false);
 
+	/* Start a new counting window */
+	iwl_mvm_restart_mpdu_count(mvm, mvmvif);
+
 	return ret;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 8b59535e7edf..b7a461dba41e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2022-2023 Intel Corporation
+ * Copyright (C) 2022-2024 Intel Corporation
  */
 #include "mvm.h"
 #include "time-sync.h"
@@ -723,7 +723,6 @@ int iwl_mvm_mld_add_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			iwl_mvm_mld_set_ap_sta_id(sta, mvm_vif->link[link_id],
 						  mvm_link_sta);
 	}
-
 	return 0;
 
 err:
@@ -849,6 +848,8 @@ int iwl_mvm_mld_rm_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		iwl_mvm_mld_free_sta_link(mvm, mvm_sta, mvm_link_sta,
 					  link_id, stay_in_fw);
 	}
+	kfree(mvm_sta->mpdu_counters);
+	mvm_sta->mpdu_counters = NULL;
 
 	return ret;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index c0e0600c4d99..7f1a4ac56397 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -356,6 +356,7 @@ struct iwl_mvm_vif_link_info {
  * @IWL_MVM_ESR_BLOCKED_PREVENTION: Prevent EMLSR to avoid entering and exiting
  *	in a loop.
  * @IWL_MVM_ESR_BLOCKED_WOWLAN: WOWLAN is preventing the enablement of EMLSR
+ * @IWL_MVM_ESR_BLOCKED_TPT: block EMLSR when there is not enough traffic
  * @IWL_MVM_ESR_EXIT_MISSED_BEACON: exited EMLSR due to missed beacons
  * @IWL_MVM_ESR_EXIT_LOW_RSSI: link is deactivated/not allowed for EMLSR
  *	due to low RSSI.
@@ -365,6 +366,7 @@ struct iwl_mvm_vif_link_info {
 enum iwl_mvm_esr_state {
 	IWL_MVM_ESR_BLOCKED_PREVENTION	= 0x1,
 	IWL_MVM_ESR_BLOCKED_WOWLAN	= 0x2,
+	IWL_MVM_ESR_BLOCKED_TPT		= 0x4,
 	IWL_MVM_ESR_EXIT_MISSED_BEACON	= 0x10000,
 	IWL_MVM_ESR_EXIT_LOW_RSSI	= 0x20000,
 	IWL_MVM_ESR_EXIT_COEX		= 0x40000,
@@ -430,6 +432,7 @@ struct iwl_mvm_esr_exit {
  *	&IWL_MVM_ESR_PREVENT_REASONS.
  * @prevent_esr_done_wk: work that should be done when esr prevention ends.
  * @mlo_int_scan_wk: work for the internal MLO scan.
+ * @unblock_esr_tpt_wk: work for unblocking EMLSR when tpt is high enough.
  */
 struct iwl_mvm_vif {
 	struct iwl_mvm *mvm;
@@ -527,6 +530,7 @@ struct iwl_mvm_vif {
 	u8 exit_same_reason_count;
 	struct wiphy_delayed_work prevent_esr_done_wk;
 	struct wiphy_delayed_work mlo_int_scan_wk;
+	struct wiphy_work unblock_esr_tpt_wk;
 
 	struct iwl_mvm_vif_link_info deflink;
 	struct iwl_mvm_vif_link_info *link[IEEE80211_MLD_MAX_NUM_LINKS];
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 68ec6b8203df..36083905457b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -951,6 +951,54 @@ iwl_mvm_stat_iterator_all_links(struct iwl_mvm *mvm,
 	}
 }
 
+static void iwl_mvm_update_esr_mode_tpt(struct iwl_mvm *mvm)
+{
+	struct ieee80211_vif *bss_vif = iwl_mvm_get_bss_vif(mvm);
+	struct iwl_mvm_vif *mvmvif;
+	struct iwl_mvm_sta *mvmsta;
+	unsigned long total_tx = 0, total_rx = 0;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	if (!bss_vif)
+		return;
+
+	mvmvif = iwl_mvm_vif_from_mac80211(bss_vif);
+
+	if (!mvmvif->esr_active || !mvmvif->ap_sta)
+		return;
+
+	mvmsta = iwl_mvm_sta_from_mac80211(mvmvif->ap_sta);
+	/* We only count for the AP sta in a MLO connection */
+	if (!mvmsta->mpdu_counters)
+		return;
+
+	/* Sum up RX and TX MPDUs from the different queues/links */
+	for (int q = 0; q < mvm->trans->num_rx_queues; q++) {
+		spin_lock_bh(&mvmsta->mpdu_counters[q].lock);
+
+		/* The link IDs that doesn't exist will contain 0 */
+		for (int link = 0; link < IWL_MVM_FW_MAX_LINK_ID; link++) {
+			total_tx += mvmsta->mpdu_counters[q].per_link[link].tx;
+			total_rx += mvmsta->mpdu_counters[q].per_link[link].rx;
+		}
+		/*
+		 * In EMLSR we have statistics every 5 seconds, so we can reset
+		 * the counters upon every statistics notification.
+		 */
+		memset(mvmsta->mpdu_counters[q].per_link, 0,
+		       sizeof(mvmsta->mpdu_counters[q].per_link));
+
+		spin_unlock_bh(&mvmsta->mpdu_counters[q].lock);
+	}
+
+	/* If we don't have enough MPDUs - exit EMLSR */
+	if (total_tx < IWL_MVM_ENTER_ESR_TPT_THRESH &&
+	    total_rx < IWL_MVM_ENTER_ESR_TPT_THRESH)
+		iwl_mvm_block_esr(mvm, bss_vif, IWL_MVM_ESR_BLOCKED_TPT,
+				  iwl_mvm_get_primary_link(bss_vif));
+}
+
 void iwl_mvm_handle_rx_system_oper_stats(struct iwl_mvm *mvm,
 					 struct iwl_rx_cmd_buffer *rxb)
 {
@@ -978,6 +1026,8 @@ void iwl_mvm_handle_rx_system_oper_stats(struct iwl_mvm *mvm,
 	ieee80211_iterate_stations_atomic(mvm->hw, iwl_mvm_stats_energy_iter,
 					  average_energy);
 	iwl_mvm_handle_per_phy_stats(mvm, stats->per_phy);
+
+	iwl_mvm_update_esr_mode_tpt(mvm);
 }
 
 void iwl_mvm_handle_rx_system_oper_part1_stats(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index dc074fcf41a0..d78af2928152 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -2035,6 +2035,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	struct ieee80211_link_sta *link_sta = NULL;
 	struct sk_buff *skb;
 	u8 crypt_len = 0;
+	u8 sta_id = le32_get_bits(desc->status, IWL_RX_MPDU_STATUS_STA_ID);
 	size_t desc_size;
 	struct iwl_mvm_rx_phy_data phy_data = {};
 	u32 format;
@@ -2183,13 +2184,11 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	rcu_read_lock();
 
 	if (desc->status & cpu_to_le32(IWL_RX_MPDU_STATUS_SRC_STA_FOUND)) {
-		u8 id = le32_get_bits(desc->status, IWL_RX_MPDU_STATUS_STA_ID);
-
-		if (!WARN_ON_ONCE(id >= mvm->fw->ucode_capa.num_stations)) {
-			sta = rcu_dereference(mvm->fw_id_to_mac_id[id]);
+		if (!WARN_ON_ONCE(sta_id >= mvm->fw->ucode_capa.num_stations)) {
+			sta = rcu_dereference(mvm->fw_id_to_mac_id[sta_id]);
 			if (IS_ERR(sta))
 				sta = NULL;
-			link_sta = rcu_dereference(mvm->fw_id_to_link_sta[id]);
+			link_sta = rcu_dereference(mvm->fw_id_to_link_sta[sta_id]);
 
 			if (sta && sta->valid_links && link_sta) {
 				rx_status->link_valid = 1;
@@ -2310,6 +2309,16 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 
 			iwl_mvm_agg_rx_received(mvm, reorder_data, baid);
 		}
+
+		if (ieee80211_is_data(hdr->frame_control)) {
+			u8 sub_frame_idx = desc->amsdu_info &
+				IWL_RX_MPDU_AMSDU_SUBFRAME_IDX_MASK;
+
+			/* 0 means not an A-MSDU, and 1 means a new A-MSDU */
+			if (!sub_frame_idx || sub_frame_idx == 1)
+				iwl_mvm_count_mpdu(mvmsta, sta_id, 1, false,
+						   queue);
+		}
 	}
 
 	/* management stuff on default queue */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 491c449fd431..20d4968d692a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1847,6 +1847,18 @@ int iwl_mvm_sta_init(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	iwl_mvm_toggle_tx_ant(mvm, &mvm_sta->tx_ant);
 
+	/* MPDUs are counted only when EMLSR is possible */
+	if (vif->type == NL80211_IFTYPE_STATION && !vif->p2p &&
+	    !sta->tdls && ieee80211_vif_is_mld(vif)) {
+		mvm_sta->mpdu_counters =
+			kcalloc(mvm->trans->num_rx_queues,
+				sizeof(*mvm_sta->mpdu_counters),
+				GFP_KERNEL);
+		if (mvm_sta->mpdu_counters)
+			for (int q = 0; q < mvm->trans->num_rx_queues; q++)
+				spin_lock_init(&mvm_sta->mpdu_counters[q].lock);
+	}
+
 	return 0;
 }
 
@@ -4392,3 +4404,77 @@ void iwl_mvm_cancel_channel_switch(struct iwl_mvm *mvm,
 	if (ret)
 		IWL_ERR(mvm, "Failed to cancel the channel switch\n");
 }
+
+static int iwl_mvm_fw_sta_id_to_fw_link_id(struct iwl_mvm_vif *mvmvif,
+					   u8 fw_sta_id)
+{
+	struct ieee80211_link_sta *link_sta =
+		rcu_dereference(mvmvif->mvm->fw_id_to_link_sta[fw_sta_id]);
+	struct iwl_mvm_vif_link_info *link;
+
+	if (WARN_ON_ONCE(!link_sta))
+		return -EINVAL;
+
+	link = mvmvif->link[link_sta->link_id];
+
+	if (WARN_ON_ONCE(!link))
+		return -EINVAL;
+
+	return link->fw_link_id;
+}
+
+#define IWL_MVM_TPT_COUNT_WINDOW (IWL_MVM_TPT_COUNT_WINDOW_SEC * HZ)
+
+void iwl_mvm_count_mpdu(struct iwl_mvm_sta *mvm_sta, u8 fw_sta_id, u32 count,
+			bool tx, int queue)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(mvm_sta->vif);
+	struct iwl_mvm_tpt_counter *queue_counter;
+	struct iwl_mvm_mpdu_counter *link_counter;
+	u32 total_mpdus = 0;
+	int fw_link_id;
+
+	/* Count only for a BSS sta, and only when EMLSR is possible */
+	if (!mvm_sta->mpdu_counters)
+		return;
+
+	/* Map sta id to link id */
+	fw_link_id = iwl_mvm_fw_sta_id_to_fw_link_id(mvmvif, fw_sta_id);
+	if (fw_link_id < 0)
+		return;
+
+	queue_counter = &mvm_sta->mpdu_counters[queue];
+	link_counter = &queue_counter->per_link[fw_link_id];
+
+	spin_lock_bh(&queue_counter->lock);
+
+	if (tx)
+		link_counter->tx += count;
+	else
+		link_counter->rx += count;
+
+	/*
+	 * When not in EMLSR, the window and the decision to enter EMLSR are
+	 * handled during counting, when in EMLSR - in the statistics flow
+	 */
+	if (mvmvif->esr_active)
+		goto out;
+
+	if (time_is_before_jiffies(queue_counter->window_start +
+					IWL_MVM_TPT_COUNT_WINDOW)) {
+		memset(queue_counter->per_link, 0,
+		       sizeof(queue_counter->per_link));
+		queue_counter->window_start = jiffies;
+	}
+
+	for (int i = 0; i < IWL_MVM_FW_MAX_LINK_ID; i++)
+		total_mpdus += tx ? queue_counter->per_link[i].tx :
+				    queue_counter->per_link[i].rx;
+
+	if (total_mpdus > IWL_MVM_ENTER_ESR_TPT_THRESH)
+		wiphy_work_queue(mvmvif->mvm->hw->wiphy,
+				 &mvmvif->unblock_esr_tpt_wk);
+
+out:
+	spin_unlock_bh(&queue_counter->lock);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index b3450569864e..264f1f9394b6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -347,6 +347,24 @@ struct iwl_mvm_link_sta {
 	u8 avg_energy;
 };
 
+struct iwl_mvm_mpdu_counter {
+	u32 tx;
+	u32 rx;
+};
+
+/**
+ * struct iwl_mvm_tpt_counter - per-queue MPDU counter
+ *
+ * @lock: Needed to protect the counters when modified from statistics.
+ * @per_link: per-link counters.
+ * @window_start: timestamp of the counting-window start
+ */
+struct iwl_mvm_tpt_counter {
+	spinlock_t lock;
+	struct iwl_mvm_mpdu_counter per_link[IWL_MVM_FW_MAX_LINK_ID];
+	unsigned long window_start;
+} ____cacheline_aligned_in_smp;
+
 /**
  * struct iwl_mvm_sta - representation of a station in the driver
  * @vif: the interface the station belongs to
@@ -394,6 +412,7 @@ struct iwl_mvm_link_sta {
  * @link: per link sta entries. For non-MLO only link[0] holds data. For MLO,
  *	link[0] points to deflink and link[link_id] is allocated when new link
  *	sta is added.
+ * @mpdu_counters: RX/TX MPDUs counters for each queue.
  *
  * When mac80211 creates a station it reserves some space (hw->sta_data_size)
  * in the structure for use by driver. This structure is placed in that
@@ -433,6 +452,8 @@ struct iwl_mvm_sta {
 
 	struct iwl_mvm_link_sta deflink;
 	struct iwl_mvm_link_sta __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
+
+	struct iwl_mvm_tpt_counter *mpdu_counters;
 };
 
 u16 iwl_mvm_tid_queued(struct iwl_mvm *mvm, struct iwl_mvm_tid_data *tid_data);
@@ -514,6 +535,9 @@ void iwl_mvm_update_tkip_key(struct iwl_mvm *mvm,
 void iwl_mvm_rx_eosp_notif(struct iwl_mvm *mvm,
 			   struct iwl_rx_cmd_buffer *rxb);
 
+void iwl_mvm_count_mpdu(struct iwl_mvm_sta *mvm_sta, u8 fw_sta_id, u32 count,
+			bool tx, int queue);
+
 /* AMPDU */
 int iwl_mvm_sta_rx_agg(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		       int tid, u16 ssn, bool start, u16 buf_size, u16 timeout);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 782ddc8c296b..1d695ece93e9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1870,6 +1870,7 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 				IWL_DEBUG_TX_REPLY(mvm,
 						   "Next reclaimed packet:%d\n",
 						   next_reclaimed);
+				iwl_mvm_count_mpdu(mvmsta, sta_id, 1, true, 0);
 			} else {
 				IWL_DEBUG_TX_REPLY(mvm,
 						   "NDP - don't update next_reclaimed\n");
@@ -2247,9 +2248,13 @@ void iwl_mvm_rx_ba_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 					   le32_to_cpu(ba_res->tx_rate), false);
 		}
 
-		if (mvmsta)
+		if (mvmsta) {
 			iwl_mvm_tx_airtime(mvm, mvmsta,
 					   le32_to_cpu(ba_res->wireless_time));
+
+			iwl_mvm_count_mpdu(mvmsta, sta_id,
+					   le16_to_cpu(ba_res->txed), true, 0);
+		}
 		rcu_read_unlock();
 		return;
 	}
-- 
2.34.1


