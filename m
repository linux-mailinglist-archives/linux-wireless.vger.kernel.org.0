Return-Path: <linux-wireless+bounces-11145-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC4394C5A6
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 22:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB731C2161C
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 20:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF956158DA3;
	Thu,  8 Aug 2024 20:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TljDum6h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C04A15B98F
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 20:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148597; cv=none; b=H4sxGkFM8MWRdmwZklH6z/DSv2pUEEvXNfVFhn1GMBKGpCMbGxQgNz+pLMkZaDYddDIAnREkxDOc3Tggbx40dVuUAS3suunu5w5N8+M/qkMTzd2220TJMrQ7sy/be4yN77x/vwsy0/p0eWjzNaPINdWrxiC2HK8iitz94WE/aR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148597; c=relaxed/simple;
	bh=IoolkF+bgVcJIZkKBbsM0KUgMBjkeNcF7FpINWH/X84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sv31iKmOiDaFnToSm+8ihh1FIogxMHh37jPjNPRyuRBlSiAFvXAfKmrd7qxnrb0S47QvLb1TI0v/S+rIxV+UavS5QZFmUwRR7fy5GWmWVgZPG6JoUQYpny+UzhvstDix4nshNFpbf0RrMJANOjZuW/rPagcGu+pRoucU84RJztA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TljDum6h; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723148596; x=1754684596;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IoolkF+bgVcJIZkKBbsM0KUgMBjkeNcF7FpINWH/X84=;
  b=TljDum6hxqFhfyeogXMaIdVBzVrJ5l0kLJ4TPT3agvyOejU4mc5xkgLI
   3zuCtq1vY3DG6V1M0bjMB403Ish9fLeUCu6mgD+Eokd/o1hok4o3Mc74a
   o0AueogYUMS3CrpgONI698PX8dMtcHOw4FJd33D5OOzQTTjYl1CvSHpuV
   DV9UgAPinDM4u5aYVt/i2WUU95VK+1/EqWKVsaPopkrecoLBDkmTPIIcu
   6Lb74IR4qXsFPglAyyuRDKjTn4PYhtwtbdDuXpkuH4ly8kR/hWwqGgxgb
   7CRSodJTN3p7vCa8vpTkGcNs0bK2HF3UpYly75qBx0lwfexTCbo7/whfy
   Q==;
X-CSE-ConnectionGUID: V3hN1/3bQXyZWAFu/GiIpg==
X-CSE-MsgGUID: 6944QZgZRxqeZLu8lsHfEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="38808858"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="38808858"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:23:16 -0700
X-CSE-ConnectionGUID: jlAQ08QaT5qZJZef4t2kDw==
X-CSE-MsgGUID: NSwKkNwPSMy3c2AOU7IZmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57305330"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:23:14 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 10/13] wifi: iwlwifi: mvm: cleanup iwl_mvm_get_wd_timeout
Date: Thu,  8 Aug 2024 23:22:46 +0300
Message-Id: <20240808232017.7a6944bc2e38.I532b4b5487c6be9203ff4db9742d7cc5b148d502@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808202249.4004087-1-miriam.rachel.korenblit@intel.com>
References: <20240808202249.4004087-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This used to extract the timeout from the debug TLV
(FW_DBG_TRIGGER_TXQ_TIMERS), which is not in use.
Cleanup iwl_mvm_get_wd_timeout to not consider the debug TLV.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 16 ++---
 .../net/wireless/intel/iwlwifi/mvm/utils.c    | 60 ++++---------------
 4 files changed, 22 insertions(+), 61 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index d5a204e52076..071de9372843 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -216,7 +216,7 @@ int iwl_mvm_mld_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	static const u8 _baddr[] = {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF};
 	const u8 *baddr = _baddr;
 	unsigned int wdg_timeout =
-		iwl_mvm_get_wd_timeout(mvm, vif, false, false);
+		iwl_mvm_get_wd_timeout(mvm, vif);
 	u16 *queue;
 
 	lockdep_assert_held(&mvm->mutex);
@@ -254,7 +254,7 @@ int iwl_mvm_mld_add_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	struct iwl_mvm_int_sta *msta = &mvm_link->mcast_sta;
 	static const u8 _maddr[] = {0x03, 0x00, 0x00, 0x00, 0x00, 0x00};
 	const u8 *maddr = _maddr;
-	unsigned int timeout = iwl_mvm_get_wd_timeout(mvm, vif, false, false);
+	unsigned int timeout = iwl_mvm_get_wd_timeout(mvm, vif);
 
 	lockdep_assert_held(&mvm->mutex);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 65b66f01bef9..68464f892e85 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2587,8 +2587,7 @@ u8 iwl_mvm_tcm_load_percentage(u32 airtime, u32 elapsed);
 
 void iwl_mvm_nic_restart(struct iwl_mvm *mvm, bool fw_error);
 unsigned int iwl_mvm_get_wd_timeout(struct iwl_mvm *mvm,
-				    struct ieee80211_vif *vif,
-				    bool tdls, bool cmd_q);
+				    struct ieee80211_vif *vif);
 void iwl_mvm_connection_loss(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			     const char *errmsg);
 void iwl_mvm_event_frame_timeout_callback(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index cf4d6425f634..74bbeebe69d5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -900,7 +900,7 @@ static int iwl_mvm_sta_alloc_queue_tvqm(struct iwl_mvm *mvm,
 	struct iwl_mvm_txq *mvmtxq =
 		iwl_mvm_txq_from_tid(sta, tid);
 	unsigned int wdg_timeout =
-		iwl_mvm_get_wd_timeout(mvm, mvmsta->vif, false, false);
+		iwl_mvm_get_wd_timeout(mvm, mvmsta->vif);
 	int queue = -1;
 
 	lockdep_assert_held(&mvm->mutex);
@@ -1080,7 +1080,7 @@ static void iwl_mvm_unshare_queue(struct iwl_mvm *mvm, int queue)
 		return;
 
 	mvmsta = iwl_mvm_sta_from_mac80211(sta);
-	wdg_timeout = iwl_mvm_get_wd_timeout(mvm, mvmsta->vif, false, false);
+	wdg_timeout = iwl_mvm_get_wd_timeout(mvm, mvmsta->vif);
 
 	ssn = IEEE80211_SEQ_TO_SN(mvmsta->tid_data[tid].seq_number);
 
@@ -1330,7 +1330,7 @@ static int iwl_mvm_sta_alloc_queue(struct iwl_mvm *mvm,
 		.frame_limit = IWL_FRAME_LIMIT,
 	};
 	unsigned int wdg_timeout =
-		iwl_mvm_get_wd_timeout(mvm, mvmsta->vif, false, false);
+		iwl_mvm_get_wd_timeout(mvm, mvmsta->vif);
 	int queue = -1;
 	u16 queue_tmp;
 	unsigned long disable_agg_tids = 0;
@@ -1622,7 +1622,7 @@ void iwl_mvm_realloc_queues_after_restart(struct iwl_mvm *mvm,
 {
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
 	unsigned int wdg =
-		iwl_mvm_get_wd_timeout(mvm, mvm_sta->vif, false, false);
+		iwl_mvm_get_wd_timeout(mvm, mvm_sta->vif);
 	int i;
 	struct iwl_trans_txq_scd_cfg cfg = {
 		.sta_id = mvm_sta->deflink.sta_id,
@@ -2359,7 +2359,7 @@ int iwl_mvm_send_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	int queue;
 	int ret;
 	unsigned int wdg_timeout =
-		iwl_mvm_get_wd_timeout(mvm, vif, false, false);
+		iwl_mvm_get_wd_timeout(mvm, vif);
 	struct iwl_trans_txq_scd_cfg cfg = {
 		.fifo = IWL_MVM_TX_FIFO_VO,
 		.sta_id = mvmvif->deflink.bcast_sta.sta_id,
@@ -2568,7 +2568,7 @@ int iwl_mvm_add_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 		.aggregate = false,
 		.frame_limit = IWL_FRAME_LIMIT,
 	};
-	unsigned int timeout = iwl_mvm_get_wd_timeout(mvm, vif, false, false);
+	unsigned int timeout = iwl_mvm_get_wd_timeout(mvm, vif);
 	int ret;
 
 	lockdep_assert_held(&mvm->mutex);
@@ -3207,7 +3207,7 @@ int iwl_mvm_sta_tx_agg_oper(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 	struct iwl_mvm_tid_data *tid_data = &mvmsta->tid_data[tid];
 	unsigned int wdg_timeout =
-		iwl_mvm_get_wd_timeout(mvm, vif, sta->tdls, false);
+		iwl_mvm_get_wd_timeout(mvm, vif);
 	int queue, ret;
 	bool alloc_queue = true;
 	enum iwl_mvm_queue_status queue_status;
@@ -4326,7 +4326,7 @@ int iwl_mvm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	u16 queue;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	unsigned int wdg_timeout =
-		iwl_mvm_get_wd_timeout(mvm, vif, false, false);
+		iwl_mvm_get_wd_timeout(mvm, vif);
 	bool mld = iwl_mvm_has_mld_api(mvm->fw);
 	u32 type = mld ? STATION_TYPE_PEER : IWL_STA_LINK;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index edcc6e2cb76a..1d1364d03f02 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -747,58 +747,20 @@ bool iwl_mvm_is_vif_assoc(struct iwl_mvm *mvm)
 }
 
 unsigned int iwl_mvm_get_wd_timeout(struct iwl_mvm *mvm,
-				    struct ieee80211_vif *vif,
-				    bool tdls, bool cmd_q)
+				    struct ieee80211_vif *vif)
 {
-	struct iwl_fw_dbg_trigger_tlv *trigger;
-	struct iwl_fw_dbg_trigger_txq_timer *txq_timer;
-	unsigned int default_timeout = cmd_q ?
-		IWL_DEF_WD_TIMEOUT :
+	unsigned int default_timeout =
 		mvm->trans->trans_cfg->base_params->wd_timeout;
 
-	if (!iwl_fw_dbg_trigger_enabled(mvm->fw, FW_DBG_TRIGGER_TXQ_TIMERS)) {
-		/*
-		 * We can't know when the station is asleep or awake, so we
-		 * must disable the queue hang detection.
-		 */
-		if (fw_has_capa(&mvm->fw->ucode_capa,
-				IWL_UCODE_TLV_CAPA_STA_PM_NOTIF) &&
-		    vif && vif->type == NL80211_IFTYPE_AP)
-			return IWL_WATCHDOG_DISABLED;
-		return default_timeout;
-	}
-
-	trigger = iwl_fw_dbg_get_trigger(mvm->fw, FW_DBG_TRIGGER_TXQ_TIMERS);
-	txq_timer = (void *)trigger->data;
-
-	if (tdls)
-		return le32_to_cpu(txq_timer->tdls);
-
-	if (cmd_q)
-		return le32_to_cpu(txq_timer->command_queue);
-
-	if (WARN_ON(!vif))
-		return default_timeout;
-
-	switch (ieee80211_vif_type_p2p(vif)) {
-	case NL80211_IFTYPE_ADHOC:
-		return le32_to_cpu(txq_timer->ibss);
-	case NL80211_IFTYPE_STATION:
-		return le32_to_cpu(txq_timer->bss);
-	case NL80211_IFTYPE_AP:
-		return le32_to_cpu(txq_timer->softap);
-	case NL80211_IFTYPE_P2P_CLIENT:
-		return le32_to_cpu(txq_timer->p2p_client);
-	case NL80211_IFTYPE_P2P_GO:
-		return le32_to_cpu(txq_timer->p2p_go);
-	case NL80211_IFTYPE_P2P_DEVICE:
-		return le32_to_cpu(txq_timer->p2p_device);
-	case NL80211_IFTYPE_MONITOR:
-		return default_timeout;
-	default:
-		WARN_ON(1);
-		return mvm->trans->trans_cfg->base_params->wd_timeout;
-	}
+	/*
+	 * We can't know when the station is asleep or awake, so we
+	 * must disable the queue hang detection.
+	 */
+	if (fw_has_capa(&mvm->fw->ucode_capa,
+			IWL_UCODE_TLV_CAPA_STA_PM_NOTIF) &&
+	    vif->type == NL80211_IFTYPE_AP)
+		return IWL_WATCHDOG_DISABLED;
+	return default_timeout;
 }
 
 void iwl_mvm_connection_loss(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-- 
2.34.1


