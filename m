Return-Path: <linux-wireless+bounces-14592-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32ACC9B2F5F
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 12:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89FB9B21C5B
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 11:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB30189B8D;
	Mon, 28 Oct 2024 11:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HFSmTlOM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDA11D88BF
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 11:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116525; cv=none; b=f5Hsu1piVBznqcrxHYpLd65yCd4lU6DRuuKmUq5+RDC2SV7+AIobgDgn1Y6gaeWfqNB8FHI2JTaPWYVQfMVOlSx87E/ibVWVX627hKsTQOQ2ROFXHqwY3rApzahiRo2y26ZqMY/MEbIBIKM5V+vqQXT93EYKylSRpHxxp3LZWMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116525; c=relaxed/simple;
	bh=moIRwbJLA5IK/Ss6tr0RUYlb+mNi0dy0vF3XgJdJycM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YE/WraydrHZU3UssGBXUYzjdMggfN/kxlgE/Ku2A3ZsJSOXVcWKqeQGGeqbatK6tpWFXmUPOWqVB/AEhXPHGzTSaYTOs+nnYhqlXJ72Snya7jowPRNxM/Jjb7SrcEjQDAhgcPT56ZqcuCl20iJA8x3syPr/A8ask/jLHG/ORZGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HFSmTlOM; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730116523; x=1761652523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=moIRwbJLA5IK/Ss6tr0RUYlb+mNi0dy0vF3XgJdJycM=;
  b=HFSmTlOM1Ca27hCPEJ9fTwbmsv75hivcvmCOFxH7Lq4PDg+zyiEnYXm9
   /llyIfWbDNuiT6c8aqxyL2A53NSSf/+6WkyiXhvThUAUGAPw3BzVrP9u6
   HBmjoSv1EI/uW83928JO/D3gc99MGof6FAw5fbEiLHwCVx7rJQ7GMYA5r
   UpHQt5azujQruGXkA7VGRD/CSPP12S7oyw2Kf35trJvUBTpKH16wM2oPb
   GbhoedyF/KXTYJIPdE4y25W8ZjzebxihQEXQbR7dF3Wf16GvrF66LLAfQ
   5iHGCq8C9xmD0amIyG2lZ0TZ0MxvNTjYBoTp4qW3tK4mzUQNX2nT8VlZ9
   Q==;
X-CSE-ConnectionGUID: RVWrqDzBQ0WGT364aZWobw==
X-CSE-MsgGUID: RnArxrJwQdGuuKF+1mPFHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29813882"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="29813882"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:23 -0700
X-CSE-ConnectionGUID: wU+nz7XOTOu4rgANPereEg==
X-CSE-MsgGUID: neSrv+kOTAeVOjmJLMJ3ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="112432579"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:20 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 04/15] wifi: iwlwifi: mvm: support new versions of the wowlan APIs
Date: Mon, 28 Oct 2024 13:54:49 +0200
Message-Id: <20241028135215.d2afdf720073.I9901c8c4ad4508135d019efa213b1430acc70746@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028115500.351123-1-miriam.rachel.korenblit@intel.com>
References: <20241028115500.351123-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Add support version 7 of wowlan_config_cmd and version 5 of
iwl_wowlan_info_notif

This version is mainly a cleanup of the previous version.
Two fields were removed as the device already handled this data.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |  69 +++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 121 +++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   2 +-
 .../wireless/intel/iwlwifi/mvm/offloading.c   |   2 +-
 4 files changed, 171 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index ffee7927cf26..c2362bc786b2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -368,7 +368,7 @@ enum iwl_wowlan_flags {
 };
 
 /**
- * struct iwl_wowlan_config_cmd - WoWLAN configuration (versions 5 and 6)
+ * struct iwl_wowlan_config_cmd_v6 - WoWLAN configuration (versions 5 and 6)
  * @wakeup_filter: filter from &enum iwl_wowlan_wakeup_filters
  * @non_qos_seq: non-QoS sequence counter to use next.
  *               Reserved if the struct has version >= 6.
@@ -380,7 +380,7 @@ enum iwl_wowlan_flags {
  * @sta_id: station ID for wowlan.
  * @reserved: reserved
  */
-struct iwl_wowlan_config_cmd {
+struct iwl_wowlan_config_cmd_v6 {
 	__le32 wakeup_filter;
 	__le16 non_qos_seq;
 	__le16 qos_seq[8];
@@ -390,7 +390,27 @@ struct iwl_wowlan_config_cmd {
 	u8 flags;
 	u8 sta_id;
 	u8 reserved;
-} __packed; /* WOWLAN_CONFIG_API_S_VER_5 */
+} __packed; /* WOWLAN_CONFIG_API_S_VER_6 */
+
+/**
+ * struct iwl_wowlan_config_cmd - WoWLAN configuration
+ * @wakeup_filter: filter from &enum iwl_wowlan_wakeup_filters
+ * @wowlan_ba_teardown_tids: bitmap of BA sessions to tear down
+ * @is_11n_connection: indicates HT connection
+ * @offloading_tid: TID reserved for firmware use
+ * @flags: extra flags, see &enum iwl_wowlan_flags
+ * @sta_id: station ID for wowlan.
+ * @reserved: reserved
+ */
+struct iwl_wowlan_config_cmd {
+	__le32 wakeup_filter;
+	u8 wowlan_ba_teardown_tids;
+	u8 is_11n_connection;
+	u8 offloading_tid;
+	u8 flags;
+	u8 sta_id;
+	u8 reserved[3];
+} __packed; /* WOWLAN_CONFIG_API_S_VER_7 */
 
 #define IWL_NUM_RSC	16
 #define WOWLAN_KEY_MAX_SIZE	32
@@ -890,7 +910,7 @@ struct iwl_wowlan_mlo_gtk {
 } __packed; /* WOWLAN_MLO_GTK_KEY_API_S_VER_1 */
 
 /**
- * struct iwl_wowlan_info_notif - WoWLAN information notification
+ * struct iwl_wowlan_info_notif_v4 - WoWLAN information notification
  * @gtk: GTK data
  * @igtk: IGTK data
  * @bigtk: BIGTK data
@@ -910,7 +930,7 @@ struct iwl_wowlan_mlo_gtk {
  * @reserved2: reserved
  * @mlo_gtks: array of GTKs of size num_mlo_link_keys for version >= 4
  */
-struct iwl_wowlan_info_notif {
+struct iwl_wowlan_info_notif_v4 {
 	struct iwl_wowlan_gtk_status_v3 gtk[WOWLAN_GTK_KEYS_NUM];
 	struct iwl_wowlan_igtk_status igtk[WOWLAN_IGTK_KEYS_NUM];
 	struct iwl_wowlan_igtk_status bigtk[WOWLAN_BIGTK_KEYS_NUM];
@@ -929,6 +949,45 @@ struct iwl_wowlan_info_notif {
 	struct iwl_wowlan_mlo_gtk mlo_gtks[];
 } __packed; /* WOWLAN_INFO_NTFY_API_S_VER_3, _VER_4 */
 
+/**
+ * struct iwl_wowlan_info_notif - WoWLAN information notification
+ * @gtk: GTK data
+ * @igtk: IGTK data
+ * @bigtk: BIGTK data
+ * @replay_ctr: GTK rekey replay counter
+ * @pattern_number: number of the matched patterns
+ * @qos_seq_ctr: QoS sequence counters to use next
+ * @wakeup_reasons: wakeup reasons, see &enum iwl_wowlan_wakeup_reason
+ * @num_of_gtk_rekeys: number of GTK rekeys
+ * @transmitted_ndps: number of transmitted neighbor discovery packets
+ * @received_beacons: number of received beacons
+ * @tid_tear_down: bit mask of tids whose BA sessions were closed
+ *	in suspend state
+ * @station_id: station id
+ * @num_mlo_link_keys: number of &struct iwl_wowlan_mlo_gtk structs
+ *	following this notif
+ * @tid_offloaded_tx: tid used by the firmware to transmit data packets
+ *	while in wowlan
+ * @mlo_gtks: array of GTKs of size num_mlo_link_keys
+ */
+struct iwl_wowlan_info_notif {
+	struct iwl_wowlan_gtk_status_v3 gtk[WOWLAN_GTK_KEYS_NUM];
+	struct iwl_wowlan_igtk_status igtk[WOWLAN_IGTK_KEYS_NUM];
+	struct iwl_wowlan_igtk_status bigtk[WOWLAN_BIGTK_KEYS_NUM];
+	__le64 replay_ctr;
+	__le16 pattern_number;
+	__le16 qos_seq_ctr;
+	__le32 wakeup_reasons;
+	__le32 num_of_gtk_rekeys;
+	__le32 transmitted_ndps;
+	__le32 received_beacons;
+	u8 tid_tear_down;
+	u8 station_id;
+	u8 num_mlo_link_keys;
+	u8 tid_offloaded_tx;
+	struct iwl_wowlan_mlo_gtk mlo_gtks[];
+} __packed; /* WOWLAN_INFO_NTFY_API_S_VER_5 */
+
 /**
  * struct iwl_wowlan_wake_pkt_notif - WoWLAN wake packet notification
  * @wake_packet_length: wakeup packet length
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 9f41b9af5269..fae9eabfa56e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -922,7 +922,7 @@ static int iwl_mvm_switch_to_d3(struct iwl_mvm *mvm)
 static int
 iwl_mvm_get_wowlan_config(struct iwl_mvm *mvm,
 			  struct cfg80211_wowlan *wowlan,
-			  struct iwl_wowlan_config_cmd *wowlan_config_cmd,
+			  struct iwl_wowlan_config_cmd_v6 *wowlan_config_cmd,
 			  struct ieee80211_vif *vif, struct iwl_mvm_vif *mvmvif,
 			  struct ieee80211_sta *ap_sta)
 {
@@ -948,7 +948,8 @@ iwl_mvm_get_wowlan_config(struct iwl_mvm *mvm,
 		wowlan_config_cmd->non_qos_seq = cpu_to_le16(ret);
 	}
 
-	iwl_mvm_set_wowlan_qos_seq(mvm_ap_sta, wowlan_config_cmd);
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, WOWLAN_CONFIGURATION, 0) < 7)
+		iwl_mvm_set_wowlan_qos_seq(mvm_ap_sta, wowlan_config_cmd);
 
 	if (wowlan->disconnect)
 		wowlan_config_cmd->wakeup_filter |=
@@ -1122,7 +1123,7 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 static int
 iwl_mvm_wowlan_config(struct iwl_mvm *mvm,
 		      struct cfg80211_wowlan *wowlan,
-		      struct iwl_wowlan_config_cmd *wowlan_config_cmd,
+		      struct iwl_wowlan_config_cmd_v6 *wowlan_config_cmd_v6,
 		      struct ieee80211_vif *vif, struct iwl_mvm_vif *mvmvif,
 		      struct iwl_mvm_vif_link_info *mvm_link,
 		      struct ieee80211_sta *ap_sta)
@@ -1131,7 +1132,7 @@ iwl_mvm_wowlan_config(struct iwl_mvm *mvm,
 	bool unified_image = fw_has_capa(&mvm->fw->ucode_capa,
 					 IWL_UCODE_TLV_CAPA_CNSLDTD_D3_D0_IMG);
 
-	mvm->offload_tid = wowlan_config_cmd->offloading_tid;
+	mvm->offload_tid = wowlan_config_cmd_v6->offloading_tid;
 
 	if (!unified_image) {
 		ret = iwl_mvm_switch_to_d3(mvm);
@@ -1147,9 +1148,26 @@ iwl_mvm_wowlan_config(struct iwl_mvm *mvm,
 	if (ret)
 		return ret;
 
-	ret = iwl_mvm_send_cmd_pdu(mvm, WOWLAN_CONFIGURATION, 0,
-				   sizeof(*wowlan_config_cmd),
-				   wowlan_config_cmd);
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, WOWLAN_CONFIGURATION, 0) > 6) {
+		struct iwl_wowlan_config_cmd wowlan_config_cmd = {
+			.wakeup_filter = wowlan_config_cmd_v6->wakeup_filter,
+			.wowlan_ba_teardown_tids =
+				wowlan_config_cmd_v6->wowlan_ba_teardown_tids,
+			.is_11n_connection =
+				wowlan_config_cmd_v6->is_11n_connection,
+			.offloading_tid = wowlan_config_cmd_v6->offloading_tid,
+			.flags = wowlan_config_cmd_v6->flags,
+			.sta_id = wowlan_config_cmd_v6->sta_id,
+		};
+
+		ret = iwl_mvm_send_cmd_pdu(mvm, WOWLAN_CONFIGURATION, 0,
+					   sizeof(wowlan_config_cmd),
+					   &wowlan_config_cmd);
+	} else {
+		ret = iwl_mvm_send_cmd_pdu(mvm, WOWLAN_CONFIGURATION, 0,
+					   sizeof(*wowlan_config_cmd_v6),
+					   wowlan_config_cmd_v6);
+	}
 	if (ret)
 		return ret;
 
@@ -1302,7 +1320,7 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 
 		mvm->net_detect = true;
 	} else {
-		struct iwl_wowlan_config_cmd wowlan_config_cmd = {
+		struct iwl_wowlan_config_cmd_v6 wowlan_config_cmd = {
 			.offloading_tid = 0,
 		};
 
@@ -1423,6 +1441,7 @@ struct iwl_wowlan_status_data {
 	u16 non_qos_seq_ctr;
 	u16 qos_seq_ctr[8];
 	u8 tid_tear_down;
+	u8 tid_offloaded_tx;
 
 	struct {
 		/* including RX MIC key for TKIP */
@@ -2472,7 +2491,64 @@ static void iwl_mvm_convert_bigtk(struct iwl_wowlan_status_data *status,
 static void iwl_mvm_parse_wowlan_info_notif(struct iwl_mvm *mvm,
 					    struct iwl_wowlan_info_notif *data,
 					    struct iwl_wowlan_status_data *status,
-					    u32 len, bool has_mlo_keys)
+					    u32 len)
+{
+	u32 expected_len = sizeof(*data) +
+		data->num_mlo_link_keys * sizeof(status->mlo_keys[0]);
+
+	if (!data) {
+		IWL_ERR(mvm, "iwl_wowlan_info_notif data is NULL\n");
+		status = NULL;
+		return;
+	}
+
+	if (len < expected_len) {
+		IWL_ERR(mvm, "Invalid WoWLAN info notification!\n");
+		status = NULL;
+		return;
+	}
+
+	if (mvm->fast_resume)
+		return;
+
+	iwl_mvm_convert_key_counters_v5(status, &data->gtk[0].sc);
+	iwl_mvm_convert_gtk_v3(status, data->gtk);
+	iwl_mvm_convert_igtk(status, &data->igtk[0]);
+	iwl_mvm_convert_bigtk(status, data->bigtk);
+	status->replay_ctr = le64_to_cpu(data->replay_ctr);
+	status->pattern_number = le16_to_cpu(data->pattern_number);
+	status->tid_offloaded_tx = data->tid_offloaded_tx;
+	if (IWL_FW_CHECK(mvm,
+			 data->tid_offloaded_tx >=
+			 ARRAY_SIZE(status->qos_seq_ctr),
+			 "tid_offloaded_tx is out of bound %d\n",
+			 data->tid_offloaded_tx))
+		data->tid_offloaded_tx = 0;
+	status->qos_seq_ctr[data->tid_offloaded_tx] =
+		le16_to_cpu(data->qos_seq_ctr);
+	status->wakeup_reasons = le32_to_cpu(data->wakeup_reasons);
+	status->num_of_gtk_rekeys =
+		le32_to_cpu(data->num_of_gtk_rekeys);
+	status->received_beacons = le32_to_cpu(data->received_beacons);
+	status->tid_tear_down = data->tid_tear_down;
+
+	if (data->num_mlo_link_keys) {
+		status->num_mlo_keys = data->num_mlo_link_keys;
+		if (IWL_FW_CHECK(mvm,
+				 status->num_mlo_keys > WOWLAN_MAX_MLO_KEYS,
+				 "Too many mlo keys: %d, max %d\n",
+				 status->num_mlo_keys, WOWLAN_MAX_MLO_KEYS))
+			status->num_mlo_keys = WOWLAN_MAX_MLO_KEYS;
+		memcpy(status->mlo_keys, data->mlo_gtks,
+		       status->num_mlo_keys * sizeof(status->mlo_keys[0]));
+	}
+}
+
+static void
+iwl_mvm_parse_wowlan_info_notif_v4(struct iwl_mvm *mvm,
+				   struct iwl_wowlan_info_notif_v4 *data,
+				   struct iwl_wowlan_status_data *status,
+				   u32 len, bool has_mlo_keys)
 {
 	u32 i;
 	u32 expected_len = sizeof(*data);
@@ -2744,6 +2820,10 @@ static bool iwl_mvm_query_wakeup_reasons(struct iwl_mvm *mvm,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	int link_id = vif->active_links ? __ffs(vif->active_links) : 0;
 	struct iwl_mvm_vif_link_info *mvm_link = mvmvif->link[link_id];
+	int wowlan_info_ver = iwl_fw_lookup_notif_ver(mvm->fw,
+						      PROT_OFFLOAD_GROUP,
+						      WOWLAN_INFO_NOTIFICATION,
+						      IWL_FW_CMD_VER_UNKNOWN);
 
 	if (WARN_ON(!mvm_link))
 		goto out_unlock;
@@ -2758,11 +2838,14 @@ static bool iwl_mvm_query_wakeup_reasons(struct iwl_mvm *mvm,
 	if (!mvm_ap_sta)
 		goto out_unlock;
 
-	for (i = 0; i < IWL_MAX_TID_COUNT; i++) {
-		u16 seq = status->qos_seq_ctr[i];
-		/* firmware stores last-used value, we store next value */
-		seq += 0x10;
-		mvm_ap_sta->tid_data[i].seq_number = seq;
+	/* firmware stores last-used value, we store next value */
+	if (wowlan_info_ver >= 5) {
+		mvm_ap_sta->tid_data[status->tid_offloaded_tx].seq_number =
+			status->qos_seq_ctr[status->tid_offloaded_tx] + 0x10;
+	} else {
+		for (i = 0; i < IWL_MAX_TID_COUNT; i++)
+			mvm_ap_sta->tid_data[i].seq_number =
+				status->qos_seq_ctr[i] + 0x10;
 	}
 
 	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000) {
@@ -3246,13 +3329,19 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 			iwl_mvm_parse_wowlan_info_notif_v2(mvm, notif_v2,
 							   d3_data->status,
 							   len);
+		} else if (wowlan_info_ver < 5) {
+			struct iwl_wowlan_info_notif_v4 *notif =
+				(void *)pkt->data;
+
+			iwl_mvm_parse_wowlan_info_notif_v4(mvm, notif,
+							   d3_data->status, len,
+							   wowlan_info_ver > 3);
 		} else {
 			struct iwl_wowlan_info_notif *notif =
 				(void *)pkt->data;
 
 			iwl_mvm_parse_wowlan_info_notif(mvm, notif,
-							d3_data->status, len,
-							wowlan_info_ver > 3);
+							d3_data->status, len);
 		}
 
 		d3_data->notif_received |= IWL_D3_NOTIF_WOWLAN_INFO;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 9d3072ac8c58..2ad615293c75 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2333,7 +2333,7 @@ static inline int iwl_mvm_fast_resume(struct iwl_mvm *mvm)
 }
 #endif
 void iwl_mvm_set_wowlan_qos_seq(struct iwl_mvm_sta *mvm_ap_sta,
-				struct iwl_wowlan_config_cmd *cmd);
+				struct iwl_wowlan_config_cmd_v6 *cmd);
 int iwl_mvm_send_proto_offload(struct iwl_mvm *mvm,
 			       struct ieee80211_vif *vif,
 			       bool disable_offloading,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/offloading.c b/drivers/net/wireless/intel/iwlwifi/mvm/offloading.c
index 1eb21fe861e5..15d4369678a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/offloading.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/offloading.c
@@ -10,7 +10,7 @@
 #include "mvm.h"
 
 void iwl_mvm_set_wowlan_qos_seq(struct iwl_mvm_sta *mvm_ap_sta,
-				struct iwl_wowlan_config_cmd *cmd)
+				struct iwl_wowlan_config_cmd_v6 *cmd)
 {
 	int i;
 
-- 
2.34.1


