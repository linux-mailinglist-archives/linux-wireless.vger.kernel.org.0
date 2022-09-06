Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BC95AEC32
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 16:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238465AbiIFOKx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 10:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241280AbiIFOJV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 10:09:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0A67F10A
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 06:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662471991; x=1694007991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iLXyuL7AdCBwAh8iyyXHea0uwWiE2gay49lCti7pe4o=;
  b=AfNaJ8DHu7NKp5EtvpnfCnLDUWcDaRYecmOykeUNL2qFt5sJqYMt+li4
   6mk5/4Ti8zvK/swe+gCpPlGJBOokfZ3AUajjBl18udPZGALrgVoS6z0UD
   1CEH/ANTN6yU0s8S29fND7uAVq5rfff7KhPG8U+Pl8FgPIhKPD06FwPpU
   fL2sa+C3haMtk8gkNDLTkSTxpTY9kJFVgU1cRwpQPwvYMb0Xi/ZnRSzRH
   zRlJfzL9lxffhAGkx9+0+BeHCwHVXK/ySSAm2FQkEy312cQigJaSp20o1
   dM96eaztSyHTTX5wtlVsbYoEKYzUJtir03XDaQUU24wVeTTtGVCEEd0bq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="276989064"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="276989064"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:44:55 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="942459942"
Received: from ygueta-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.82.178])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:44:53 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/15] wifi: iwlwifi: mvm: Add handling for scan offload match info notification
Date:   Tue,  6 Sep 2022 16:42:16 +0300
Message-Id: <20220906161827.bbc5602d0b6f.I1329c231f82e7bf18f7dba0ccbd9f2d4080cbfc1@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220906134219.365090-1-gregory.greenman@intel.com>
References: <20220906134219.365090-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

To support FW versions that send the scan match information as
an asynchronous notification.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/commands.h  |   5 +-
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  |  20 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 192 +++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   8 +
 4 files changed, 166 insertions(+), 59 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index c78d2f1c722c..0b052c2e563a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2020 Intel Corporation
+ * Copyright (C) 2018-2022 Intel Corporation
  */
 #ifndef __iwl_fw_api_commands_h__
 #define __iwl_fw_api_commands_h__
@@ -20,6 +20,8 @@
  *	&enum iwl_phy_ops_subcmd_ids
  * @DATA_PATH_GROUP: data path group, uses command IDs from
  *	&enum iwl_data_path_subcmd_ids
+ * @SCAN_GROUP: scan group, uses command IDs from
+ *	&enum iwl_scan_subcmd_ids
  * @NAN_GROUP: NAN group, uses command IDs from &enum iwl_nan_subcmd_ids
  * @LOCATION_GROUP: location group, uses command IDs from
  *	&enum iwl_location_subcmd_ids
@@ -36,6 +38,7 @@ enum iwl_mvm_command_groups {
 	MAC_CONF_GROUP = 0x3,
 	PHY_OPS_GROUP = 0x4,
 	DATA_PATH_GROUP = 0x5,
+	SCAN_GROUP = 0x6,
 	NAN_GROUP = 0x7,
 	LOCATION_GROUP = 0x8,
 	PROT_OFFLOAD_GROUP = 0xb,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index 5543d9cb74c8..7ba0e3409199 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -9,6 +9,16 @@
 
 /* Scan Commands, Responses, Notifications */
 
+/**
+ * enum iwl_scan_subcmd_ids - scan commands
+ */
+enum iwl_scan_subcmd_ids {
+	/**
+	 * @OFFLOAD_MATCH_INFO_NOTIF: &struct iwl_scan_offload_match_info
+	 */
+	OFFLOAD_MATCH_INFO_NOTIF = 0xFC,
+};
+
 /* Max number of IEs for direct SSID scans in a command */
 #define PROBE_OPTION_MAX		20
 
@@ -1188,7 +1198,7 @@ struct iwl_scan_offload_profile_match {
 } __packed; /* SCAN_OFFLOAD_PROFILE_MATCH_RESULTS_S_VER_2 */
 
 /**
- * struct iwl_scan_offload_profiles_query - match results query response
+ * struct iwl_scan_offload_match_info - match results information
  * @matched_profiles: bitmap of matched profiles, referencing the
  *	matches passed in the scan offload request
  * @last_scan_age: age of the last offloaded scan
@@ -1200,7 +1210,7 @@ struct iwl_scan_offload_profile_match {
  * @reserved: reserved
  * @matches: array of match information, one for each match
  */
-struct iwl_scan_offload_profiles_query {
+struct iwl_scan_offload_match_info {
 	__le32 matched_profiles;
 	__le32 last_scan_age;
 	__le32 n_scans_done;
@@ -1210,7 +1220,9 @@ struct iwl_scan_offload_profiles_query {
 	u8 self_recovery;
 	__le16 reserved;
 	struct iwl_scan_offload_profile_match matches[];
-} __packed; /* SCAN_OFFLOAD_PROFILES_QUERY_RSP_S_VER_3 */
+} __packed; /* SCAN_OFFLOAD_PROFILES_QUERY_RSP_S_VER_3 and
+	     * SCAN_OFFLOAD_MATCH_INFO_NOTIFICATION_S_VER_1
+	     */
 
 /**
  * struct iwl_umac_scan_iter_complete_notif - notifies end of scanning iteration
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 90871f3603de..8c38e96ae608 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2258,16 +2258,16 @@ static bool iwl_mvm_query_wakeup_reasons(struct iwl_mvm *mvm,
 #define ND_QUERY_BUF_LEN (sizeof(struct iwl_scan_offload_profile_match) * \
 			  IWL_SCAN_MAX_PROFILES)
 
-struct iwl_mvm_nd_query_results {
+struct iwl_mvm_nd_results {
 	u32 matched_profiles;
 	u8 matches[ND_QUERY_BUF_LEN];
 };
 
 static int
 iwl_mvm_netdetect_query_results(struct iwl_mvm *mvm,
-				struct iwl_mvm_nd_query_results *results)
+				struct iwl_mvm_nd_results *results)
 {
-	struct iwl_scan_offload_profiles_query *query;
+	struct iwl_scan_offload_match_info *query;
 	struct iwl_host_cmd cmd = {
 		.id = SCAN_OFFLOAD_PROFILES_QUERY_CMD,
 		.flags = CMD_WANT_SKB,
@@ -2284,7 +2284,7 @@ iwl_mvm_netdetect_query_results(struct iwl_mvm *mvm,
 
 	if (fw_has_api(&mvm->fw->ucode_capa,
 		       IWL_UCODE_TLV_API_SCAN_OFFLOAD_CHANS)) {
-		query_len = sizeof(struct iwl_scan_offload_profiles_query);
+		query_len = sizeof(struct iwl_scan_offload_match_info);
 		matches_len = sizeof(struct iwl_scan_offload_profile_match) *
 			max_profiles;
 	} else {
@@ -2315,7 +2315,7 @@ iwl_mvm_netdetect_query_results(struct iwl_mvm *mvm,
 }
 
 static int iwl_mvm_query_num_match_chans(struct iwl_mvm *mvm,
-					 struct iwl_mvm_nd_query_results *query,
+					 struct iwl_mvm_nd_results *results,
 					 int idx)
 {
 	int n_chans = 0, i;
@@ -2323,13 +2323,13 @@ static int iwl_mvm_query_num_match_chans(struct iwl_mvm *mvm,
 	if (fw_has_api(&mvm->fw->ucode_capa,
 		       IWL_UCODE_TLV_API_SCAN_OFFLOAD_CHANS)) {
 		struct iwl_scan_offload_profile_match *matches =
-			(struct iwl_scan_offload_profile_match *)query->matches;
+			(void *)results->matches;
 
 		for (i = 0; i < SCAN_OFFLOAD_MATCHING_CHANNELS_LEN; i++)
 			n_chans += hweight8(matches[idx].matching_channels[i]);
 	} else {
 		struct iwl_scan_offload_profile_match_v1 *matches =
-			(struct iwl_scan_offload_profile_match_v1 *)query->matches;
+			(void *)results->matches;
 
 		for (i = 0; i < SCAN_OFFLOAD_MATCHING_CHANNELS_LEN_V1; i++)
 			n_chans += hweight8(matches[idx].matching_channels[i]);
@@ -2339,7 +2339,7 @@ static int iwl_mvm_query_num_match_chans(struct iwl_mvm *mvm,
 }
 
 static void iwl_mvm_query_set_freqs(struct iwl_mvm *mvm,
-				    struct iwl_mvm_nd_query_results *query,
+				    struct iwl_mvm_nd_results *results,
 				    struct cfg80211_wowlan_nd_match *match,
 				    int idx)
 {
@@ -2348,7 +2348,7 @@ static void iwl_mvm_query_set_freqs(struct iwl_mvm *mvm,
 	if (fw_has_api(&mvm->fw->ucode_capa,
 		       IWL_UCODE_TLV_API_SCAN_OFFLOAD_CHANS)) {
 		struct iwl_scan_offload_profile_match *matches =
-			(struct iwl_scan_offload_profile_match *)query->matches;
+			 (void *)results->matches;
 
 		for (i = 0; i < SCAN_OFFLOAD_MATCHING_CHANNELS_LEN * 8; i++)
 			if (matches[idx].matching_channels[i / 8] & (BIT(i % 8)))
@@ -2356,7 +2356,7 @@ static void iwl_mvm_query_set_freqs(struct iwl_mvm *mvm,
 					mvm->nd_channels[i]->center_freq;
 	} else {
 		struct iwl_scan_offload_profile_match_v1 *matches =
-			(struct iwl_scan_offload_profile_match_v1 *)query->matches;
+			 (void *)results->matches;
 
 		for (i = 0; i < SCAN_OFFLOAD_MATCHING_CHANNELS_LEN_V1 * 8; i++)
 			if (matches[idx].matching_channels[i / 8] & (BIT(i % 8)))
@@ -2365,24 +2365,50 @@ static void iwl_mvm_query_set_freqs(struct iwl_mvm *mvm,
 	}
 }
 
+/**
+ * enum iwl_d3_notif - d3 notifications
+ * @IWL_D3_NOTIF_WOWLAN_INFO: WOWLAN_INFO_NOTIF was received
+ * @IWL_D3_NOTIF_WOWLAN_WAKE_PKT: WOWLAN_WAKE_PKT_NOTIF was received
+ * @IWL_D3_NOTIF_PROT_OFFLOAD: PROT_OFFLOAD_NOTIF was received
+ * @IWL_D3_ND_MATCH_INFO: OFFLOAD_MATCH_INFO_NOTIF was received
+ * @IWL_D3_NOTIF_D3_END_NOTIF: D3_END_NOTIF was received
+ */
+enum iwl_d3_notif {
+	IWL_D3_NOTIF_WOWLAN_INFO =	BIT(0),
+	IWL_D3_NOTIF_WOWLAN_WAKE_PKT =	BIT(1),
+	IWL_D3_NOTIF_PROT_OFFLOAD =	BIT(2),
+	IWL_D3_ND_MATCH_INFO      =     BIT(3),
+	IWL_D3_NOTIF_D3_END_NOTIF =	BIT(4)
+};
+
+/* manage d3 resume data */
+struct iwl_d3_data {
+	struct iwl_wowlan_status_data *status;
+	bool test;
+	u32 d3_end_flags;
+	u32 notif_expected;	/* bitmap - see &enum iwl_d3_notif */
+	u32 notif_received;	/* bitmap - see &enum iwl_d3_notif */
+	struct iwl_mvm_nd_results *nd_results;
+	bool nd_results_valid;
+};
+
 static void iwl_mvm_query_netdetect_reasons(struct iwl_mvm *mvm,
 					    struct ieee80211_vif *vif,
-					    struct iwl_wowlan_status_data *status)
+					    struct iwl_d3_data *d3_data)
 {
 	struct cfg80211_wowlan_nd_info *net_detect = NULL;
 	struct cfg80211_wowlan_wakeup wakeup = {
 		.pattern_idx = -1,
 	};
 	struct cfg80211_wowlan_wakeup *wakeup_report = &wakeup;
-	struct iwl_mvm_nd_query_results query;
 	unsigned long matched_profiles;
 	u32 reasons = 0;
 	int i, n_matches, ret;
 
-	if (WARN_ON(!status))
-		return;
+	if (WARN_ON(!d3_data || !d3_data->status))
+		goto out;
 
-	reasons = status->wakeup_reasons;
+	reasons = d3_data->status->wakeup_reasons;
 
 	if (reasons & IWL_WOWLAN_WAKEUP_BY_RFKILL_DEASSERTED)
 		wakeup.rfkill_release = true;
@@ -2390,13 +2416,22 @@ static void iwl_mvm_query_netdetect_reasons(struct iwl_mvm *mvm,
 	if (reasons != IWL_WOWLAN_WAKEUP_BY_NON_WIRELESS)
 		goto out;
 
-	ret = iwl_mvm_netdetect_query_results(mvm, &query);
-	if (ret || !query.matched_profiles) {
+	if (!iwl_fw_lookup_notif_ver(mvm->fw, PROT_OFFLOAD_GROUP,
+				     WOWLAN_INFO_NOTIFICATION, 0)) {
+		IWL_INFO(mvm, "Query FW for ND results\n");
+		ret = iwl_mvm_netdetect_query_results(mvm, d3_data->nd_results);
+
+	} else {
+		IWL_INFO(mvm, "Notification based ND results\n");
+		ret = d3_data->nd_results_valid ? 0 : -1;
+	}
+
+	if (ret || !d3_data->nd_results->matched_profiles) {
 		wakeup_report = NULL;
 		goto out;
 	}
 
-	matched_profiles = query.matched_profiles;
+	matched_profiles = d3_data->nd_results->matched_profiles;
 	if (mvm->n_nd_match_sets) {
 		n_matches = hweight_long(matched_profiles);
 	} else {
@@ -2413,7 +2448,9 @@ static void iwl_mvm_query_netdetect_reasons(struct iwl_mvm *mvm,
 		struct cfg80211_wowlan_nd_match *match;
 		int idx, n_channels = 0;
 
-		n_channels = iwl_mvm_query_num_match_chans(mvm, &query, i);
+		n_channels = iwl_mvm_query_num_match_chans(mvm,
+							   d3_data->nd_results,
+							   i);
 
 		match = kzalloc(struct_size(match, channels, n_channels),
 				GFP_KERNEL);
@@ -2433,7 +2470,7 @@ static void iwl_mvm_query_netdetect_reasons(struct iwl_mvm *mvm,
 		if (mvm->n_nd_channels < n_channels)
 			continue;
 
-		iwl_mvm_query_set_freqs(mvm, &query, match, i);
+		iwl_mvm_query_set_freqs(mvm, d3_data->nd_results, match, i);
 	}
 
 out_report_nd:
@@ -2513,38 +2550,15 @@ static bool iwl_mvm_check_rt_status(struct iwl_mvm *mvm,
 	return false;
 }
 
-/**
- * enum iwl_d3_notif - d3 notifications
- * @IWL_D3_NOTIF_WOWLAN_INFO: WOWLAN_INFO_NOTIF was received
- * @IWL_D3_NOTIF_WOWLAN_WAKE_PKT: WOWLAN_WAKE_PKT_NOTIF was received
- * @IWL_D3_NOTIF_PROT_OFFLOAD: PROT_OFFLOAD_NOTIF was received
- * @IWL_D3_NOTIF_D3_END_NOTIF: D3_END_NOTIF was received
- */
-enum iwl_d3_notif {
-	IWL_D3_NOTIF_WOWLAN_INFO =	BIT(0),
-	IWL_D3_NOTIF_WOWLAN_WAKE_PKT =	BIT(1),
-	IWL_D3_NOTIF_PROT_OFFLOAD =	BIT(2),
-	IWL_D3_NOTIF_D3_END_NOTIF =	BIT(3)
-};
-
-/* manage d3 resume data */
-struct iwl_d3_data {
-	struct iwl_wowlan_status_data *status;
-	bool test;
-	u32 d3_end_flags;
-	u32 notif_expected;	/* bitmap - see &enum iwl_d3_notif */
-	u32 notif_received;	/* bitmap - see &enum iwl_d3_notif */
-};
-
 /*
  * This function assumes:
  *	1. The mutex is already held.
  *	2. The callee functions unlock the mutex.
  */
-static void iwl_mvm_choose_query_wakeup_reasons(struct iwl_mvm *mvm,
-						struct ieee80211_vif *vif,
-						struct iwl_d3_data *d3_data,
-						bool test)
+static void
+iwl_mvm_choose_query_wakeup_reasons(struct iwl_mvm *mvm,
+				    struct ieee80211_vif *vif,
+				    struct iwl_d3_data *d3_data)
 {
 	lockdep_assert_held(&mvm->mutex);
 
@@ -2557,7 +2571,7 @@ static void iwl_mvm_choose_query_wakeup_reasons(struct iwl_mvm *mvm,
 	}
 
 	if (mvm->net_detect) {
-		iwl_mvm_query_netdetect_reasons(mvm, vif, d3_data->status);
+		iwl_mvm_query_netdetect_reasons(mvm, vif, d3_data);
 	} else {
 		bool keep = iwl_mvm_query_wakeup_reasons(mvm, vif,
 							 d3_data->status);
@@ -2567,7 +2581,7 @@ static void iwl_mvm_choose_query_wakeup_reasons(struct iwl_mvm *mvm,
 			mvm->keep_vif = vif;
 #endif
 
-		if (!test)
+		if (!d3_data->test)
 			ieee80211_iterate_active_interfaces_mtx(mvm->hw,
 								IEEE80211_IFACE_ITER_NORMAL,
 								iwl_mvm_d3_disconnect_iter,
@@ -2624,6 +2638,55 @@ static int iwl_mvm_wowlan_store_wake_pkt(struct iwl_mvm *mvm,
 	return 0;
 }
 
+static void iwl_mvm_nd_match_info_handler(struct iwl_mvm *mvm,
+					  struct iwl_d3_data *d3_data,
+					  struct iwl_scan_offload_match_info *notif,
+					  u32 len)
+{
+	struct iwl_wowlan_status_data *status = d3_data->status;
+	struct ieee80211_vif *vif = iwl_mvm_get_bss_vif(mvm);
+	struct iwl_mvm_nd_results *results = d3_data->nd_results;
+	size_t i, matches_len = sizeof(struct iwl_scan_offload_profile_match) *
+		iwl_umac_scan_get_max_profiles(mvm->fw);
+
+	if (IS_ERR_OR_NULL(vif))
+		return;
+
+	if (len < sizeof(struct iwl_scan_offload_match_info)) {
+		IWL_ERR(mvm, "Invalid scan match info notification\n");
+		return;
+	}
+
+	if (!mvm->net_detect) {
+		IWL_ERR(mvm, "Unexpected scan match info notification\n");
+		return;
+	}
+
+	if (!status || status->wakeup_reasons != IWL_WOWLAN_WAKEUP_BY_NON_WIRELESS) {
+		IWL_ERR(mvm,
+			"Ignore scan match info notification: no reason\n");
+		return;
+	}
+
+#ifdef CONFIG_IWLWIFI_DEBUGFS
+	mvm->last_netdetect_scans = le32_to_cpu(notif->n_scans_done);
+#endif
+
+	results->matched_profiles = le32_to_cpu(notif->matched_profiles);
+	IWL_INFO(mvm, "number of matched profiles=%u\n",
+		 results->matched_profiles);
+
+	if (results->matched_profiles) {
+		memcpy(results->matches, notif->matches, matches_len);
+		d3_data->nd_results_valid = TRUE;
+	}
+
+	/* no scan should be active at this point */
+	mvm->scan_status = 0;
+	for (i = 0; i < mvm->max_scans; i++)
+		mvm->scan_uid_status[i] = 0;
+}
+
 static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 				  struct iwl_rx_packet *pkt, void *data)
 {
@@ -2675,6 +2738,24 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 
 		break;
 	}
+	case WIDE_ID(SCAN_GROUP, OFFLOAD_MATCH_INFO_NOTIF): {
+		struct iwl_scan_offload_match_info *notif = (void *)pkt->data;
+
+		if (d3_data->notif_received & IWL_D3_ND_MATCH_INFO) {
+			IWL_ERR(mvm,
+				"Got additional netdetect match info\n");
+			break;
+		}
+
+		d3_data->notif_received |= IWL_D3_ND_MATCH_INFO;
+
+		/* explicitly set this in the 'expected' as well */
+		d3_data->notif_expected |= IWL_D3_ND_MATCH_INFO;
+
+		len = iwl_rx_packet_payload_len(pkt);
+		iwl_mvm_nd_match_info_handler(mvm, d3_data, notif, len);
+		break;
+	}
 	case WIDE_ID(PROT_OFFLOAD_GROUP, D3_END_NOTIFICATION): {
 		struct iwl_mvm_d3_end_notif *notif = (void *)pkt->data;
 
@@ -2694,12 +2775,12 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 
 static int iwl_mvm_d3_notif_wait(struct iwl_mvm *mvm,
 				 struct iwl_d3_data *d3_data,
-				 enum iwl_d3_status *d3_status,
-				 bool test)
+				 enum iwl_d3_status *d3_status)
 {
 	static const u16 d3_resume_notif[] = {
 		WIDE_ID(PROT_OFFLOAD_GROUP, WOWLAN_INFO_NOTIFICATION),
 		WIDE_ID(PROT_OFFLOAD_GROUP, WOWLAN_WAKE_PKT_NOTIFICATION),
+		WIDE_ID(SCAN_GROUP, OFFLOAD_MATCH_INFO_NOTIF),
 		WIDE_ID(PROT_OFFLOAD_GROUP, D3_END_NOTIFICATION)
 	};
 	struct iwl_notification_wait wait_d3_notif;
@@ -2709,7 +2790,7 @@ static int iwl_mvm_d3_notif_wait(struct iwl_mvm *mvm,
 				   d3_resume_notif, ARRAY_SIZE(d3_resume_notif),
 				   iwl_mvm_wait_d3_notif, d3_data);
 
-	ret = iwl_trans_d3_resume(mvm->trans, d3_status, test, false);
+	ret = iwl_trans_d3_resume(mvm->trans, d3_status, d3_data->test, false);
 	if (ret) {
 		iwl_remove_notification(&mvm->notif_wait, &wait_d3_notif);
 		return ret;
@@ -2740,11 +2821,14 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 	struct ieee80211_vif *vif = NULL;
 	int ret = 1;
 	enum iwl_d3_status d3_status;
+	struct iwl_mvm_nd_results results = {};
 	struct iwl_d3_data d3_data = {
 		.test = test,
 		.notif_expected =
 			IWL_D3_NOTIF_WOWLAN_INFO |
 			IWL_D3_NOTIF_D3_END_NOTIF,
+		.nd_results_valid = false,
+		.nd_results = &results,
 	};
 	bool unified_image = fw_has_capa(&mvm->fw->ucode_capa,
 					 IWL_UCODE_TLV_CAPA_CNSLDTD_D3_D0_IMG);
@@ -2782,7 +2866,7 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 			goto err;
 		}
 
-		ret = iwl_mvm_d3_notif_wait(mvm, &d3_data, &d3_status, test);
+		ret = iwl_mvm_d3_notif_wait(mvm, &d3_data, &d3_status);
 	} else {
 		ret = iwl_trans_d3_resume(mvm->trans, &d3_status, test,
 					  !unified_image);
@@ -2842,7 +2926,7 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 	}
 
 query_wakeup_reasons:
-	iwl_mvm_choose_query_wakeup_reasons(mvm, vif, &d3_data, d3_data.test);
+	iwl_mvm_choose_query_wakeup_reasons(mvm, vif, &d3_data);
 	/* has unlocked the mutex, so skip that */
 	goto out;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 3eb59b958801..429963cd8ee1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -554,6 +554,13 @@ static const struct iwl_hcmd_names iwl_mvm_data_path_names[] = {
 	HCMD_NAME(RX_QUEUES_NOTIFICATION),
 };
 
+/* Please keep this array *SORTED* by hex value.
+ * Access is done through binary search
+ */
+static const struct iwl_hcmd_names iwl_mvm_scan_names[] = {
+	HCMD_NAME(OFFLOAD_MATCH_INFO_NOTIF),
+};
+
 /* Please keep this array *SORTED* by hex value.
  * Access is done through binary search
  */
@@ -596,6 +603,7 @@ static const struct iwl_hcmd_arr iwl_mvm_groups[] = {
 	[MAC_CONF_GROUP] = HCMD_ARR(iwl_mvm_mac_conf_names),
 	[PHY_OPS_GROUP] = HCMD_ARR(iwl_mvm_phy_names),
 	[DATA_PATH_GROUP] = HCMD_ARR(iwl_mvm_data_path_names),
+	[SCAN_GROUP] = HCMD_ARR(iwl_mvm_scan_names),
 	[LOCATION_GROUP] = HCMD_ARR(iwl_mvm_location_names),
 	[PROT_OFFLOAD_GROUP] = HCMD_ARR(iwl_mvm_prot_offload_names),
 	[REGULATORY_AND_NVM_GROUP] =
-- 
2.35.3

