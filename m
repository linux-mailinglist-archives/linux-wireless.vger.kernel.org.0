Return-Path: <linux-wireless+bounces-4536-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5682C877AEB
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 07:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D63AB1F21510
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 06:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEEE1118B;
	Mon, 11 Mar 2024 06:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCiXRrdE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E599B10A22
	for <linux-wireless@vger.kernel.org>; Mon, 11 Mar 2024 06:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710138517; cv=none; b=WQL4hWkhK12tPA3Los76pHqOj7rS+WosPmHVJW2d+WQwNeG/dM0Zg77arIVg1ZkWFu3BfLLY7ApR+P1cxwjUYggSru52eeluLs2YPQapmzqFzHm/WGfQax45XPjMJRoOHlzHf2cgAnPTddfvz7uu6BmP2xlYWhxqcmVaLv8xKgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710138517; c=relaxed/simple;
	bh=eFjO2BKmrm70gznfVmffZ9M+VGdZeRf8dgCnaKY9aAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FQe8/vmB5TJZaOGVZKLix7U/pVeZuYbfp7T5T4uBqznTlEhdhCVbtO77Hu7EiC/TapfVhZUfPR0NflqcDiW35L+7XXUSh3BKNcNl1KdU9dh/muV4dItVgeM4EshStpxsfc1CDq8rYZMgGpsSdcnCWep2XascfjJH8+I4ewY9nao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GCiXRrdE; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710138515; x=1741674515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eFjO2BKmrm70gznfVmffZ9M+VGdZeRf8dgCnaKY9aAE=;
  b=GCiXRrdEWmVCVBEFjK9g3oIRk+7Si+hxZUGwKqqVZnJO7Wpldjh5cuJu
   7DHfPDTjGKEolRUQQp+oE9U74hPflGiQqAXf3NyiwnjiGh+WnmNjlG9Ku
   1sK7mIEta9HeAm6B05gD/KWX7odS8ZL24f0iVn2KhY/lM+CQqBqqFlXAA
   GtuvxsNo0hpUgoV6cYf1EJq56SO2UQZMBqgRrMTKUgUVypFk+7Fgjjudy
   MTw+8mP7rBLdC4g/CmZAqc06EAaj8dMvRl0yQYl3uGH+xIbp8NtUyLX2x
   7wta1QWuJtoxntJisaCN0aR8gL/FOnZjEj/F9fUhNjoyoh1FZXuMFWoBU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="30226741"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="30226741"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="15657624"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:33 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 04/15] wifi: iwlwifi: mvm: Move beacon filtering to be per link
Date: Mon, 11 Mar 2024 08:28:04 +0200
Message-Id: <20240311081938.47bdecc68e73.Icc0eaebb35d119f8c538c068fbc8f874aac194c3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311062815.4099838-1-miriam.rachel.korenblit@intel.com>
References: <20240311062815.4099838-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

As the FW statistics are per link context and not per MAC context.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c | 21 ++++----
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 23 ++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 17 +++----
 .../net/wireless/intel/iwlwifi/mvm/power.c    | 16 +++----
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   | 48 +++++++++++--------
 6 files changed, 70 insertions(+), 57 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
index 535edb51d1c0..acbd46747b7b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
@@ -219,15 +219,13 @@ struct iwl_bt_iterator_data {
 
 static inline
 void iwl_mvm_bt_coex_enable_rssi_event(struct iwl_mvm *mvm,
-				       struct ieee80211_vif *vif,
+				       struct iwl_mvm_vif_link_info *link_info,
 				       bool enable, int rssi)
 {
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-
-	mvmvif->bf_data.last_bt_coex_event = rssi;
-	mvmvif->bf_data.bt_coex_max_thold =
+	link_info->bf_data.last_bt_coex_event = rssi;
+	link_info->bf_data.bt_coex_max_thold =
 		enable ? -IWL_MVM_BT_COEX_EN_RED_TXP_THRESH : 0;
-	mvmvif->bf_data.bt_coex_min_thold =
+	link_info->bf_data.bt_coex_min_thold =
 		enable ? -IWL_MVM_BT_COEX_DIS_RED_TXP_THRESH : 0;
 }
 
@@ -412,8 +410,8 @@ static void iwl_mvm_bt_notif_per_link(struct iwl_mvm *mvm,
 					    smps_mode, link_id);
 			iwl_mvm_bt_coex_reduced_txp(mvm, link_info->ap_sta_id,
 						    false);
-			/* FIXME: should this be per link? */
-			iwl_mvm_bt_coex_enable_rssi_event(mvm, vif, false, 0);
+			iwl_mvm_bt_coex_enable_rssi_event(mvm, link_info, false,
+							  0);
 		}
 		return;
 	}
@@ -508,13 +506,12 @@ static void iwl_mvm_bt_notif_per_link(struct iwl_mvm *mvm,
 	    le32_to_cpu(mvm->last_bt_notif.bt_activity_grading) == BT_OFF ||
 	    !vif->cfg.assoc) {
 		iwl_mvm_bt_coex_reduced_txp(mvm, link_info->ap_sta_id, false);
-		/* FIXME: should this be per link? */
-		iwl_mvm_bt_coex_enable_rssi_event(mvm, vif, false, 0);
+		iwl_mvm_bt_coex_enable_rssi_event(mvm, link_info, false, 0);
 		return;
 	}
 
 	/* try to get the avg rssi from fw */
-	ave_rssi = mvmvif->bf_data.ave_beacon_signal;
+	ave_rssi = link_info->bf_data.ave_beacon_signal;
 
 	/* if the RSSI isn't valid, fake it is very low */
 	if (!ave_rssi)
@@ -530,7 +527,7 @@ static void iwl_mvm_bt_notif_per_link(struct iwl_mvm *mvm,
 	}
 
 	/* Begin to monitor the RSSI: it may influence the reduced Tx power */
-	iwl_mvm_bt_coex_enable_rssi_event(mvm, vif, true, ave_rssi);
+	iwl_mvm_bt_coex_enable_rssi_event(mvm, link_info, true, ave_rssi);
 }
 
 /* must be called under rcu_read_lock */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
index 51b01f7528be..ea5488721977 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
@@ -407,7 +407,7 @@ static ssize_t iwl_dbgfs_bf_params_read(struct file *file,
 	};
 
 	iwl_mvm_beacon_filter_debugfs_parameters(vif, &cmd);
-	if (mvmvif->bf_data.bf_enabled)
+	if (mvmvif->bf_enabled)
 		cmd.bf_enable_beacon_filter = cpu_to_le32(1);
 	else
 		cmd.bf_enable_beacon_filter = 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 1935630d3def..f51e8e83b0a9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1097,7 +1097,8 @@ static void iwl_mvm_cleanup_iterator(void *data, u8 *mac,
 	iwl_mvm_te_clear_data(mvm, &mvmvif->time_event_data);
 	spin_unlock_bh(&mvm->time_event_lock);
 
-	memset(&mvmvif->bf_data, 0, sizeof(mvmvif->bf_data));
+	mvmvif->bf_enabled = false;
+	mvmvif->ba_enabled = false;
 	mvmvif->ap_sta = NULL;
 
 	for_each_mvm_vif_valid_link(mvmvif, link_id) {
@@ -1106,6 +1107,8 @@ static void iwl_mvm_cleanup_iterator(void *data, u8 *mac,
 		mvmvif->link[link_id]->phy_ctxt = NULL;
 		mvmvif->link[link_id]->active = 0;
 		mvmvif->link[link_id]->igtk = NULL;
+		memset(&mvmvif->link[link_id]->bf_data, 0,
+		       sizeof(mvmvif->link[link_id]->bf_data));
 	}
 
 	probe_data = rcu_dereference_protected(mvmvif->deflink.probe_resp_data,
@@ -2538,6 +2541,7 @@ void iwl_mvm_bss_info_changed_station_assoc(struct iwl_mvm *mvm,
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	int ret;
+	int link_id;
 
 	/* The firmware tracks the MU-MIMO group on its own.
 	 * However, on HW restart we should restore this data.
@@ -2553,7 +2557,8 @@ void iwl_mvm_bss_info_changed_station_assoc(struct iwl_mvm *mvm,
 	iwl_mvm_recalc_multicast(mvm);
 
 	/* reset rssi values */
-	mvmvif->bf_data.ave_beacon_signal = 0;
+	for_each_mvm_vif_valid_link(mvmvif, link_id)
+		mvmvif->link[link_id]->bf_data.ave_beacon_signal = 0;
 
 	iwl_mvm_bt_coex_vif_change(mvm);
 	iwl_mvm_update_smps_on_active_links(mvm, vif, IWL_MVM_SMPS_REQ_TT,
@@ -2594,10 +2599,14 @@ iwl_mvm_bss_info_changed_station_common(struct iwl_mvm *mvm,
 	}
 
 	if (changes & BSS_CHANGED_CQM) {
-		IWL_DEBUG_MAC80211(mvm, "cqm info_changed\n");
-		/* reset cqm events tracking */
-		mvmvif->bf_data.last_cqm_event = 0;
-		if (mvmvif->bf_data.bf_enabled) {
+		struct iwl_mvm_vif_link_info *link_info =
+			mvmvif->link[link_conf->link_id];
+
+		IWL_DEBUG_MAC80211(mvm, "CQM info_changed\n");
+		if (link_info)
+			link_info->bf_data.last_cqm_event = 0;
+
+		if (mvmvif->bf_enabled) {
 			/* FIXME: need to update per link when FW API will
 			 * support it
 			 */
@@ -5391,7 +5400,7 @@ static int iwl_mvm_old_pre_chan_sw_sta(struct iwl_mvm *mvm,
 	if (chsw->block_tx)
 		iwl_mvm_csa_client_absent(mvm, vif);
 
-	if (mvmvif->bf_data.bf_enabled) {
+	if (mvmvif->bf_enabled) {
 		int ret = iwl_mvm_disable_beacon_filter(mvm, vif);
 
 		if (ret)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 63c802712596..b23fc84e3620 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -255,18 +255,14 @@ enum iwl_mvm_low_latency_cause {
 };
 
 /**
-* struct iwl_mvm_vif_bf_data - beacon filtering related data
-* @bf_enabled: indicates if beacon filtering is enabled
-* @ba_enabled: indicated if beacon abort is enabled
+* struct iwl_mvm_link_bf_data - beacon filtering related data
 * @ave_beacon_signal: average beacon signal
 * @last_cqm_event: rssi of the last cqm event
 * @bt_coex_min_thold: minimum threshold for BT coex
 * @bt_coex_max_thold: maximum threshold for BT coex
 * @last_bt_coex_event: rssi of the last BT coex event
 */
-struct iwl_mvm_vif_bf_data {
-	bool bf_enabled;
-	bool ba_enabled;
+struct iwl_mvm_link_bf_data {
 	int ave_beacon_signal;
 	int last_cqm_event;
 	int bt_coex_min_thold;
@@ -309,6 +305,7 @@ struct iwl_probe_resp_data {
  * @listen_lmac: indicates this link is allocated to the listen LMAC
  * @mcast_sta: multicast station
  * @phy_ctxt: phy context allocated to this link, if any
+ * @bf_data: beacon filtering data
  */
 struct iwl_mvm_vif_link_info {
 	u8 bssid[ETH_ALEN];
@@ -344,6 +341,8 @@ struct iwl_mvm_vif_link_info {
 	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
 
 	u16 mgmt_queue;
+
+	struct iwl_mvm_link_bf_data bf_data;
 };
 
 /**
@@ -373,8 +372,9 @@ struct iwl_mvm_vif_link_info {
  * @csa_bcn_pending: indicates that we are waiting for a beacon on a new channel
  * @features: hw features active for this vif
  * @ap_beacon_time: AP beacon time for synchronisation (on older FW)
+ * @bf_enabled: indicates if beacon filtering is enabled
+ * @ba_enabled: indicated if beacon abort is enabled
  * @bcn_prot: beacon protection data (keys; FIXME: needs to be per link)
- * @bf_data: beacon filtering data
  * @deflink: default link data for use in non-MLO
  * @link: link data for each link in MLO
  * @esr_active: indicates eSR mode is active
@@ -401,7 +401,8 @@ struct iwl_mvm_vif {
 	bool ps_disabled;
 
 	u32 ap_beacon_time;
-	struct iwl_mvm_vif_bf_data bf_data;
+	bool bf_enabled;
+	bool ba_enabled;
 
 #ifdef CONFIG_PM
 	/* WoWLAN GTK rekey data */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/power.c b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
index 41e68aa6bec8..568f53c56199 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
@@ -79,7 +79,7 @@ void iwl_mvm_beacon_filter_set_cqm_params(struct iwl_mvm *mvm,
 		cmd->bf_roaming_state =
 			cpu_to_le32(-vif->bss_conf.cqm_rssi_thold);
 	}
-	cmd->ba_enable_beacon_abort = cpu_to_le32(mvmvif->bf_data.ba_enabled);
+	cmd->ba_enable_beacon_abort = cpu_to_le32(mvmvif->ba_enabled);
 }
 
 static void iwl_mvm_power_log(struct iwl_mvm *mvm,
@@ -826,7 +826,7 @@ static int _iwl_mvm_enable_beacon_filter(struct iwl_mvm *mvm,
 	ret = iwl_mvm_beacon_filter_send_cmd(mvm, cmd);
 
 	if (!ret)
-		mvmvif->bf_data.bf_enabled = true;
+		mvmvif->bf_enabled = true;
 
 	return ret;
 }
@@ -855,7 +855,7 @@ static int _iwl_mvm_disable_beacon_filter(struct iwl_mvm *mvm,
 	ret = iwl_mvm_beacon_filter_send_cmd(mvm, &cmd);
 
 	if (!ret)
-		mvmvif->bf_data.bf_enabled = false;
+		mvmvif->bf_enabled = false;
 
 	return ret;
 }
@@ -903,16 +903,16 @@ static int iwl_mvm_power_set_ba(struct iwl_mvm *mvm,
 		.bf_enable_beacon_filter = cpu_to_le32(1),
 	};
 
-	if (!mvmvif->bf_data.bf_enabled)
+	if (!mvmvif->bf_enabled)
 		return 0;
 
 	if (test_bit(IWL_MVM_STATUS_IN_D3, &mvm->status))
 		cmd.ba_escape_timer = cpu_to_le32(IWL_BA_ESCAPE_TIMER_D3);
 
-	mvmvif->bf_data.ba_enabled = !(!mvmvif->pm_enabled ||
-				       mvm->ps_disabled ||
-				       !vif->cfg.ps ||
-				       iwl_mvm_vif_low_latency(mvmvif));
+	mvmvif->ba_enabled = !(!mvmvif->pm_enabled ||
+			       mvm->ps_disabled ||
+			       !vif->cfg.ps ||
+			       iwl_mvm_vif_low_latency(mvmvif));
 
 	return _iwl_mvm_enable_beacon_filter(mvm, vif, &cmd);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index b1add7942c5b..f8f57e191c59 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -556,12 +556,15 @@ struct iwl_mvm_stat_data_all_macs {
 	struct iwl_stats_ntfy_per_mac *per_mac;
 };
 
-static void iwl_mvm_update_vif_sig(struct ieee80211_vif *vif, int sig)
+static void iwl_mvm_update_vif_sig(struct ieee80211_vif *vif, int sig,
+				   struct iwl_mvm_vif_link_info *link_info)
 {
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mvm *mvm = mvmvif->mvm;
-	int thold = vif->bss_conf.cqm_rssi_thold;
-	int hyst = vif->bss_conf.cqm_rssi_hyst;
+	struct iwl_mvm *mvm = iwl_mvm_vif_from_mac80211(vif)->mvm;
+	struct ieee80211_bss_conf *bss_conf =
+		iwl_mvm_rcu_fw_link_id_to_link_conf(mvm, link_info->fw_link_id,
+						    false);
+	int thold = bss_conf->cqm_rssi_thold;
+	int hyst = bss_conf->cqm_rssi_hyst;
 	int last_event;
 
 	if (sig == 0) {
@@ -569,23 +572,23 @@ static void iwl_mvm_update_vif_sig(struct ieee80211_vif *vif, int sig)
 		return;
 	}
 
-	mvmvif->bf_data.ave_beacon_signal = sig;
+	link_info->bf_data.ave_beacon_signal = sig;
 
 	/* BT Coex */
-	if (mvmvif->bf_data.bt_coex_min_thold !=
-	    mvmvif->bf_data.bt_coex_max_thold) {
-		last_event = mvmvif->bf_data.last_bt_coex_event;
-		if (sig > mvmvif->bf_data.bt_coex_max_thold &&
-		    (last_event <= mvmvif->bf_data.bt_coex_min_thold ||
+	if (link_info->bf_data.bt_coex_min_thold !=
+	    link_info->bf_data.bt_coex_max_thold) {
+		last_event = link_info->bf_data.last_bt_coex_event;
+		if (sig > link_info->bf_data.bt_coex_max_thold &&
+		    (last_event <= link_info->bf_data.bt_coex_min_thold ||
 		     last_event == 0)) {
-			mvmvif->bf_data.last_bt_coex_event = sig;
+			link_info->bf_data.last_bt_coex_event = sig;
 			IWL_DEBUG_RX(mvm, "cqm_iterator bt coex high %d\n",
 				     sig);
 			iwl_mvm_bt_rssi_event(mvm, vif, RSSI_EVENT_HIGH);
-		} else if (sig < mvmvif->bf_data.bt_coex_min_thold &&
-			   (last_event >= mvmvif->bf_data.bt_coex_max_thold ||
+		} else if (sig < link_info->bf_data.bt_coex_min_thold &&
+			   (last_event >= link_info->bf_data.bt_coex_max_thold ||
 			    last_event == 0)) {
-			mvmvif->bf_data.last_bt_coex_event = sig;
+			link_info->bf_data.last_bt_coex_event = sig;
 			IWL_DEBUG_RX(mvm, "cqm_iterator bt coex low %d\n",
 				     sig);
 			iwl_mvm_bt_rssi_event(mvm, vif, RSSI_EVENT_LOW);
@@ -596,10 +599,10 @@ static void iwl_mvm_update_vif_sig(struct ieee80211_vif *vif, int sig)
 		return;
 
 	/* CQM Notification */
-	last_event = mvmvif->bf_data.last_cqm_event;
+	last_event = link_info->bf_data.last_cqm_event;
 	if (thold && sig < thold && (last_event == 0 ||
 				     sig < last_event - hyst)) {
-		mvmvif->bf_data.last_cqm_event = sig;
+		link_info->bf_data.last_cqm_event = sig;
 		IWL_DEBUG_RX(mvm, "cqm_iterator cqm low %d\n",
 			     sig);
 		ieee80211_cqm_rssi_notify(
@@ -609,7 +612,7 @@ static void iwl_mvm_update_vif_sig(struct ieee80211_vif *vif, int sig)
 			GFP_KERNEL);
 	} else if (sig > thold &&
 		   (last_event == 0 || sig > last_event + hyst)) {
-		mvmvif->bf_data.last_cqm_event = sig;
+		link_info->bf_data.last_cqm_event = sig;
 		IWL_DEBUG_RX(mvm, "cqm_iterator cqm high %d\n",
 			     sig);
 		ieee80211_cqm_rssi_notify(
@@ -651,7 +654,8 @@ static void iwl_mvm_stat_iterator(void *_data, u8 *mac,
 		mvmvif->deflink.beacon_stats.accu_num_beacons +=
 			mvmvif->deflink.beacon_stats.num_beacons;
 
-	iwl_mvm_update_vif_sig(vif, sig);
+	/* This is used in pre-MLO API so use deflink */
+	iwl_mvm_update_vif_sig(vif, sig, &mvmvif->deflink);
 }
 
 static void iwl_mvm_stat_iterator_all_macs(void *_data, u8 *mac,
@@ -684,7 +688,9 @@ static void iwl_mvm_stat_iterator_all_macs(void *_data, u8 *mac,
 			mvmvif->deflink.beacon_stats.num_beacons;
 
 	sig = -le32_to_cpu(mac_stats->beacon_filter_average_energy);
-	iwl_mvm_update_vif_sig(vif, sig);
+
+	/* This is used in pre-MLO API so use deflink */
+	iwl_mvm_update_vif_sig(vif, sig, &mvmvif->deflink);
 }
 
 static inline void
@@ -900,7 +906,7 @@ iwl_mvm_stat_iterator_all_links(struct iwl_mvm *mvm,
 				mvmvif->link[link_id]->beacon_stats.num_beacons;
 
 		sig = -le32_to_cpu(link_stats->beacon_filter_average_energy);
-		iwl_mvm_update_vif_sig(bss_conf->vif, sig);
+		iwl_mvm_update_vif_sig(bss_conf->vif, sig, link_info);
 
 		if (WARN_ONCE(mvmvif->id >= MAC_INDEX_AUX,
 			      "invalid mvmvif id: %d", mvmvif->id))
-- 
2.34.1


