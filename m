Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2E29DD7B5
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Oct 2019 11:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfJSJjT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Oct 2019 05:39:19 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50446 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726426AbfJSJjS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Oct 2019 05:39:18 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iLlCd-0002fy-Dw; Sat, 19 Oct 2019 12:39:16 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 19 Oct 2019 12:38:59 +0300
Message-Id: <20191019123747.a420bc9d5330.I5f287f4e918c1137d7d79d855f9faefb9110b667@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191019093902.29823-1-luca@coelho.fi>
References: <20191019093902.29823-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 09/12] iwlwifi: scan: adapt the code to use api ver 11
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tova Mussai <tova.mussai@intel.com>

FW scan api ver 11 adds support for some new features,
in this version the fw did also some cleanup in the api,
which causes the driver not to be able to use the
current scan req struct.

Therefore, in this patch the driver has new version for the scan command
code

Signed-off-by: Tova Mussai <tova.mussai@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  | 157 ++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |  18 ++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   9 +
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 202 +++++++++++++++++-
 4 files changed, 380 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index 39c64850cb6f..0a3a529a09d1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -70,6 +70,9 @@
 /* Max number of IEs for direct SSID scans in a command */
 #define PROBE_OPTION_MAX		20
 
+#define SCAN_SHORT_SSID_MAX_SIZE        8
+#define SCAN_BSSID_MAX_SIZE             16
+
 /**
  * struct iwl_ssid_ie - directed scan network information element
  *
@@ -278,6 +281,9 @@ enum iwl_scan_channel_flags {
 	IWL_SCAN_CHANNEL_FLAG_EBS_ACCURATE	= BIT(1),
 	IWL_SCAN_CHANNEL_FLAG_CACHE_ADD		= BIT(2),
 	IWL_SCAN_CHANNEL_FLAG_EBS_FRAG		= BIT(3),
+	IWL_SCAN_CHANNEL_FLAG_FORCE_EBS         = BIT(4),
+	IWL_SCAN_CHANNEL_FLAG_ENABLE_CHAN_ORDER = BIT(5),
+	IWL_SCAN_CHANNEL_FLAG_6G_PSC_NO_FILTER  = BIT(6),
 };
 
 /* struct iwl_scan_channel_opt - CHANNEL_OPTIMIZATION_API_S
@@ -619,6 +625,40 @@ enum iwl_umac_scan_general_flags2 {
 	IWL_UMAC_SCAN_GEN_FLAGS2_ALLOW_CHNL_REORDER	= BIT(1),
 };
 
+/**
+ * enum iwl_umac_scan_general_flags_v22 - UMAC scan general flags ver 2
+ * @IWL_UMAC_SCAN_GEN_FLAGS_V2_PERIODIC: periodic or scheduled
+ * @IWL_UMAC_SCAN_GEN_FLAGS_V2_PASS_ALL: pass all probe responses and beacons
+ *                                       during scan iterations
+ * @IWL_UMAC_SCAN_GEN_FLAGS_V2_NTFY_ITER_COMPLETE: send complete notification
+ *      on every iteration instead of only once after the last iteration
+ * @IWL_UMAC_SCAN_GEN_FLAGS_V2_FRAGMENTED_LMAC1: fragmented scan LMAC1
+ * @IWL_UMAC_SCAN_GEN_FLAGS_V2_FRAGMENTED_LMAC2: fragmented scan LMAC2
+ * @IWL_UMAC_SCAN_GEN_FLAGS_V2_MATCH: does this scan check for profile matching
+ * @IWL_UMAC_SCAN_GEN_FLAGS_V2_USE_ALL_RX_CHAINS: use all valid chains for RX
+ * @IWL_UMAC_SCAN_GEN_FLAGS_V2_ADAPTIVE_DWELL: works with adaptive dwell
+ *                                             for active channel
+ * @IWL_UMAC_SCAN_GEN_FLAGS_V2_PREEMPTIVE: can be preempted by other requests
+ * @IWL_UMAC_SCAN_GEN_FLAGS_V2_NTF_START: send notification of scan start
+ * @IWL_UMAC_SCAN_GEN_FLAGS_V2_MULTI_SSID: matching on multiple SSIDs
+ * @IWL_UMAC_SCAN_GEN_FLAGS_V2_FORCE_PASSIVE: all the channels scanned
+ *                                           as passive
+ */
+enum iwl_umac_scan_general_flags_v2 {
+	IWL_UMAC_SCAN_GEN_FLAGS_V2_PERIODIC             = BIT(0),
+	IWL_UMAC_SCAN_GEN_FLAGS_V2_PASS_ALL             = BIT(1),
+	IWL_UMAC_SCAN_GEN_FLAGS_V2_NTFY_ITER_COMPLETE   = BIT(2),
+	IWL_UMAC_SCAN_GEN_FLAGS_V2_FRAGMENTED_LMAC1     = BIT(3),
+	IWL_UMAC_SCAN_GEN_FLAGS_V2_FRAGMENTED_LMAC2     = BIT(4),
+	IWL_UMAC_SCAN_GEN_FLAGS_V2_MATCH                = BIT(5),
+	IWL_UMAC_SCAN_GEN_FLAGS_V2_USE_ALL_RX_CHAINS    = BIT(6),
+	IWL_UMAC_SCAN_GEN_FLAGS_V2_ADAPTIVE_DWELL       = BIT(7),
+	IWL_UMAC_SCAN_GEN_FLAGS_V2_PREEMPTIVE           = BIT(8),
+	IWL_UMAC_SCAN_GEN_FLAGS_V2_NTF_START            = BIT(9),
+	IWL_UMAC_SCAN_GEN_FLAGS_V2_MULTI_SSID           = BIT(10),
+	IWL_UMAC_SCAN_GEN_FLAGS_V2_FORCE_PASSIVE        = BIT(11),
+};
+
 /**
  * struct iwl_scan_channel_cfg_umac
  * @flags:		bitmap - 0-19:	directed scan to i'th ssid.
@@ -812,6 +852,123 @@ struct iwl_scan_req_umac {
 #define IWL_SCAN_REQ_UMAC_SIZE_V6 44
 #define IWL_SCAN_REQ_UMAC_SIZE_V1 36
 
+/**
+ * struct iwl_scan_probe_params
+ * @preq: scan probe request params
+ * @ssid_num: number of valid SSIDs in direct scan array
+ * @short_ssid_num: number of valid short SSIDs in short ssid array
+ * @bssid_num: number of valid bssid in bssids array
+ * @reserved: reserved
+ * @direct_scan: list of ssids
+ * @short_ssid: array of short ssids
+ * @bssid_array: array of bssids
+*/
+struct iwl_scan_probe_params {
+	struct iwl_scan_probe_req preq;
+	u8 ssid_num;
+	u8 short_ssid_num;
+	u8 bssid_num;
+	u8 reserved;
+	struct iwl_ssid_ie direct_scan[PROBE_OPTION_MAX];
+	__le32 short_ssid[SCAN_SHORT_SSID_MAX_SIZE];
+	u8 bssid_array[ETH_ALEN][SCAN_BSSID_MAX_SIZE];
+} __packed;
+
+#define SCAN_MAX_NUM_CHANS_V3 67
+
+/**
+ * struct iwl_scan_channel_params
+ * @flags: channel flags &enum iwl_scan_channel_flags
+ * @count: num of channels in scan request
+ * @reserved: for future use and alignment
+ * @channel_config: array of explicit channel configurations
+ *                  for 2.4Ghz and 5.2Ghz bands
+ */
+struct iwl_scan_channel_params {
+	u8 flags;
+	u8 count;
+	__le16 reserved;
+	struct iwl_scan_channel_cfg_umac channel_config[SCAN_MAX_NUM_CHANS_V3];
+} __packed;
+
+ /**
+  * struct iwl_scan_general_params
+  * @flags: &enum iwl_umac_scan_flags
+  * @reserved: reserved for future
+  * @scan_start_mac_id: report the scan start TSF time according to this mac TSF
+  * @active_dwell: dwell time for active scan per LMAC
+  * @adwell_default_2g: adaptive dwell default number of APs
+  *                        for 2.4GHz channel
+  * @ddwell_default_5g: adaptive dwell default number of APs
+  *                        for 5GHz channels
+  * @adwell_default_social_chn: adaptive dwell default number of
+  *                             APs per social channel
+  * @reserved1: reserved for future
+  * @adwell_max_budget: the maximal number of TUs that adaptive dwell
+  *                     can add to the total scan time
+  * @max_out_of_time: max out of serving channel time, per LMAC
+  * @suspend_time: max suspend time, per LMAC
+  * @scan_priority: priority of the request
+  * @passive_dwell: continues dwell time for passive channel
+  *                 (without adaptive dwell)
+  * @num_of_fragments: number of fragments needed for full fragmented
+  *                    scan coverage.
+  * */
+struct iwl_scan_general_params {
+	__le16 flags;
+	u8 reserved;
+	u8 scan_start_mac_id;
+	u8 active_dwell[SCAN_TWO_LMACS];
+	u8 adwell_default_2g;
+	u8 adwell_default_5g;
+	u8 adwell_default_social_chn;
+	u8 reserved1;
+	__le16 adwell_max_budget;
+	__le32 max_out_of_time[SCAN_TWO_LMACS];
+	__le32 suspend_time[SCAN_TWO_LMACS];
+	__le32 scan_priority;
+	u8 passive_dwell[SCAN_TWO_LMACS];
+	u8 num_of_fragments[SCAN_TWO_LMACS];
+} __packed;
+
+/**
+  * struct iwl_scan_periodic_parms
+  * @schedule: can scheduling parameter
+  * @delay: initial delay of the periodic scan in seconds
+  * @reserved: reserved for future
+  * */
+struct iwl_scan_periodic_parms {
+	struct iwl_scan_umac_schedule schedule[IWL_MAX_SCHED_SCAN_PLANS];
+	__le16 delay;
+	__le16 reserved;
+} __packed;
+
+/**
+  * struct iwl_scan_req_params
+  * @general_params: &struct iwl_scan_general_params
+  * @channel_params: &struct iwl_scan_channel_params
+  * @periodic_params: &struct iwl_scan_periodic_parms
+  * @probe_params: &struct iwl_scan_probe_params
+  * */
+struct iwl_scan_req_params {
+	struct iwl_scan_general_params general_params;
+	struct iwl_scan_channel_params channel_params;
+	struct iwl_scan_periodic_parms periodic_params;
+	struct iwl_scan_probe_params probe_params;
+} __packed;
+
+/**
+ * struct iwl_scan_req_umac_v2
+ * @uid: scan id, &enum iwl_umac_scan_uid_offsets
+ * @ooc_priority: out of channel priority - &enum iwl_scan_priority
+ * @scan_params: scan parameters
+ */
+struct iwl_scan_umac_req_v2 {
+	__le32 uid;
+	__le32 ooc_priority;
+	struct iwl_scan_req_params scan_params;
+} __packed;
+
 /**
  * struct iwl_umac_scan_abort
  * @uid: scan id, &enum iwl_umac_scan_uid_offsets
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.h b/drivers/net/wireless/intel/iwlwifi/fw/img.h
index dbeab093171e..994880a83652 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.h
@@ -313,4 +313,22 @@ iwl_get_ucode_image(const struct iwl_fw *fw, enum iwl_ucode_type ucode_type)
 	return &fw->img[ucode_type];
 }
 
+static inline u8 iwl_mvm_lookup_cmd_ver(const struct iwl_fw *fw, u8 grp, u8 cmd)
+{
+	const struct iwl_fw_cmd_version *entry;
+	unsigned int i;
+
+	if (!fw->ucode_capa.cmd_versions ||
+	    !fw->ucode_capa.n_cmd_versions)
+		return IWL_FW_CMD_VER_UNKNOWN;
+
+	entry = fw->ucode_capa.cmd_versions;
+	for (i = 0; i < fw->ucode_capa.n_cmd_versions; i++, entry++) {
+		if (entry->group == grp && entry->cmd == cmd)
+			return entry->cmd_ver;
+	}
+
+	return IWL_FW_CMD_VER_UNKNOWN;
+}
+
 #endif  /* __iwl_fw_img_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index a25712cce4ab..261175f6aee8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1415,6 +1415,15 @@ static inline bool iwl_mvm_is_band_in_rx_supported(struct iwl_mvm *mvm)
 			   IWL_UCODE_TLV_API_BAND_IN_RX_DATA);
 }
 
+static inline bool iwl_mvm_is_scan_ext_band_supported(struct iwl_mvm *mvm)
+{
+	u8 cmd_ver = iwl_mvm_lookup_cmd_ver(mvm->fw, IWL_ALWAYS_LONG_GROUP,
+					    SCAN_REQ_UMAC);
+	if (cmd_ver == IWL_FW_CMD_VER_UNKNOWN)
+		return false;
+	return (cmd_ver >= 11);
+}
+
 static inline bool iwl_mvm_has_new_rx_stats_api(struct iwl_mvm *mvm)
 {
 	return fw_has_api(&mvm->fw->ucode_capa,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 7ea395681c94..543fc9ce5e25 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -539,6 +539,7 @@ static void iwl_scan_build_ssids(struct iwl_mvm_scan_params *params,
 {
 	int i, j;
 	int index;
+	u32 tmp_bitmap = 0;
 
 	/*
 	 * copy SSIDs from match list.
@@ -558,7 +559,6 @@ static void iwl_scan_build_ssids(struct iwl_mvm_scan_params *params,
 	}
 
 	/* add SSIDs from scan SSID list */
-	*ssid_bitmap = 0;
 	for (j = params->n_ssids - 1;
 	     j >= 0 && i < PROBE_OPTION_MAX;
 	     i++, j--) {
@@ -570,11 +570,13 @@ static void iwl_scan_build_ssids(struct iwl_mvm_scan_params *params,
 			ssids[i].len = params->ssids[j].ssid_len;
 			memcpy(ssids[i].ssid, params->ssids[j].ssid,
 			       ssids[i].len);
-			*ssid_bitmap |= BIT(i);
+			tmp_bitmap |= BIT(i);
 		} else {
-			*ssid_bitmap |= BIT(index);
+			tmp_bitmap |= BIT(index);
 		}
 	}
+	if (ssid_bitmap)
+		*ssid_bitmap = tmp_bitmap;
 }
 
 static int
@@ -1381,16 +1383,76 @@ static void iwl_mvm_scan_umac_dwell(struct iwl_mvm *mvm,
 		cmd->ooc_priority = cpu_to_le32(IWL_SCAN_PRIORITY_EXT_2);
 }
 
+static void iwl_mvm_scan_umac_dwell_v2(struct iwl_mvm *mvm,
+				       struct iwl_scan_umac_req_v2 *cmd,
+				       struct iwl_mvm_scan_params *params)
+{
+	struct iwl_mvm_scan_timing_params *timing, *hb_timing;
+	u8 active_dwell, passive_dwell;
+
+	timing = &scan_timing[params->type];
+	active_dwell = params->measurement_dwell ?
+		params->measurement_dwell : IWL_SCAN_DWELL_ACTIVE;
+	passive_dwell = params->measurement_dwell ?
+		params->measurement_dwell : IWL_SCAN_DWELL_PASSIVE;
+
+	cmd->scan_params.general_params.adwell_default_social_chn =
+		IWL_SCAN_ADWELL_DEFAULT_N_APS_SOCIAL;
+	cmd->scan_params.general_params.adwell_default_2g =
+		IWL_SCAN_ADWELL_DEFAULT_LB_N_APS;
+	cmd->scan_params.general_params.adwell_default_5g =
+			IWL_SCAN_ADWELL_DEFAULT_HB_N_APS;
+
+	/* if custom max budget was configured with debugfs */
+	if (IWL_MVM_ADWELL_MAX_BUDGET)
+		cmd->scan_params.general_params.adwell_max_budget =
+			cpu_to_le16(IWL_MVM_ADWELL_MAX_BUDGET);
+	else if (params->ssids && params->ssids[0].ssid_len)
+		cmd->scan_params.general_params.adwell_max_budget =
+			cpu_to_le16(IWL_SCAN_ADWELL_MAX_BUDGET_DIRECTED_SCAN);
+	else
+		cmd->scan_params.general_params.adwell_max_budget =
+			cpu_to_le16(IWL_SCAN_ADWELL_MAX_BUDGET_FULL_SCAN);
+
+	cmd->scan_params.general_params.scan_priority =
+		cpu_to_le32(IWL_SCAN_PRIORITY_EXT_6);
+	cmd->scan_params.general_params.max_out_of_time[SCAN_LB_LMAC_IDX] =
+		cpu_to_le32(timing->max_out_time);
+	cmd->scan_params.general_params.suspend_time[SCAN_LB_LMAC_IDX] =
+		cpu_to_le32(timing->suspend_time);
+
+	hb_timing = &scan_timing[params->hb_type];
+
+	cmd->scan_params.general_params.max_out_of_time[SCAN_HB_LMAC_IDX] =
+		cpu_to_le32(hb_timing->max_out_time);
+	cmd->scan_params.general_params.suspend_time[SCAN_HB_LMAC_IDX] =
+		cpu_to_le32(hb_timing->suspend_time);
+
+	cmd->scan_params.general_params.active_dwell[SCAN_LB_LMAC_IDX] =
+		active_dwell;
+	cmd->scan_params.general_params.passive_dwell[SCAN_LB_LMAC_IDX] =
+		passive_dwell;
+	cmd->scan_params.general_params.active_dwell[SCAN_HB_LMAC_IDX] =
+		active_dwell;
+	cmd->scan_params.general_params.passive_dwell[SCAN_HB_LMAC_IDX] =
+		passive_dwell;
+
+	if (iwl_mvm_is_regular_scan(params))
+		cmd->ooc_priority = cpu_to_le32(IWL_SCAN_PRIORITY_EXT_6);
+	else
+		cmd->ooc_priority = cpu_to_le32(IWL_SCAN_PRIORITY_EXT_2);
+}
+
 static void
 iwl_mvm_umac_scan_cfg_channels(struct iwl_mvm *mvm,
 			       struct ieee80211_channel **channels,
-			       int n_channels, u32 ssid_bitmap,
+			       int n_channels, u32 flags,
 			       struct iwl_scan_channel_cfg_umac *channel_cfg)
 {
 	int i;
 
 	for (i = 0; i < n_channels; i++) {
-		channel_cfg[i].flags = cpu_to_le32(ssid_bitmap);
+		channel_cfg[i].flags = cpu_to_le32(flags);
 		channel_cfg[i].v1.channel_num = channels[i]->hw_value;
 		if (iwl_mvm_is_scan_ext_chan_supported(mvm)) {
 			enum nl80211_band band = channels[i]->band;
@@ -1406,6 +1468,64 @@ iwl_mvm_umac_scan_cfg_channels(struct iwl_mvm *mvm,
 	}
 }
 
+static u8 iwl_mvm_scan_umac_chan_flags_v2(struct iwl_mvm *mvm,
+					  struct iwl_mvm_scan_params *params,
+					  struct ieee80211_vif *vif)
+{
+	u8 flags = 0;
+
+	flags |= IWL_SCAN_CHANNEL_FLAG_ENABLE_CHAN_ORDER;
+
+	if (iwl_mvm_scan_use_ebs(mvm, vif))
+		flags |= IWL_SCAN_CHANNEL_FLAG_EBS |
+			IWL_SCAN_CHANNEL_FLAG_EBS_ACCURATE |
+			IWL_SCAN_CHANNEL_FLAG_CACHE_ADD;
+
+	/* set fragmented ebs for fragmented scan on HB channels */
+	if (iwl_mvm_is_scan_fragmented(params->hb_type))
+		flags |= IWL_SCAN_CHANNEL_FLAG_EBS_FRAG;
+
+	return flags;
+}
+
+static u16 iwl_mvm_scan_umac_flags_v2(struct iwl_mvm *mvm,
+				      struct iwl_mvm_scan_params *params,
+				      struct ieee80211_vif *vif,
+				      int type)
+{
+	u16 flags = 0;
+
+	if (params->n_ssids == 0)
+		flags |= IWL_UMAC_SCAN_GEN_FLAGS_V2_FORCE_PASSIVE;
+
+	if (iwl_mvm_is_scan_fragmented(params->type))
+		flags |= IWL_UMAC_SCAN_GEN_FLAGS_V2_FRAGMENTED_LMAC1;
+
+	if (iwl_mvm_is_scan_fragmented(params->hb_type))
+		flags |= IWL_UMAC_SCAN_GEN_FLAGS_V2_FRAGMENTED_LMAC2;
+
+	if (params->pass_all)
+		flags |= IWL_UMAC_SCAN_GEN_FLAGS_V2_PASS_ALL;
+	else
+		flags |= IWL_UMAC_SCAN_GEN_FLAGS_V2_MATCH;
+
+	if (!iwl_mvm_is_regular_scan(params))
+		flags |= IWL_UMAC_SCAN_GEN_FLAGS_V2_PERIODIC;
+
+	if (params->measurement_dwell ||
+	    mvm->sched_scan_pass_all == SCHED_SCAN_PASS_ALL_ENABLED)
+		flags |= IWL_UMAC_SCAN_GEN_FLAGS_V2_NTFY_ITER_COMPLETE;
+
+	if (IWL_MVM_ADWELL_ENABLE &&
+	    vif->type != NL80211_IFTYPE_P2P_DEVICE)
+		flags |= IWL_UMAC_SCAN_GEN_FLAGS_V2_ADAPTIVE_DWELL;
+
+	if (type == IWL_MVM_SCAN_SCHED || type == IWL_MVM_SCAN_NETDETECT)
+		flags |= IWL_UMAC_SCAN_GEN_FLAGS_V2_PREEMPTIVE;
+
+	return flags;
+}
+
 static u16 iwl_mvm_scan_umac_flags(struct iwl_mvm *mvm,
 				   struct iwl_mvm_scan_params *params,
 				   struct ieee80211_vif *vif)
@@ -1610,6 +1730,71 @@ static int iwl_mvm_scan_umac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	return 0;
 }
 
+static int iwl_mvm_scan_umac_v2(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+				struct iwl_mvm_scan_params *params,
+				int type)
+{
+	struct iwl_scan_umac_req_v2 *cmd = mvm->scan_cmd;
+	int uid, ret = 0;
+	u8 channel_flags = 0;
+	u16 gen_flags;
+	struct iwl_scan_req_params *scan_params;
+	struct iwl_scan_periodic_parms *periodic_params;
+	struct iwl_scan_channel_params *channel_params;
+
+	struct iwl_mvm_vif *scan_vif = iwl_mvm_vif_from_mac80211(vif);
+
+	scan_params = &cmd->scan_params;
+	periodic_params = &scan_params->periodic_params;
+	channel_params = &scan_params->channel_params;
+	lockdep_assert_held(&mvm->mutex);
+
+	uid = iwl_mvm_scan_uid_by_status(mvm, 0);
+	if (uid < 0)
+		return uid;
+
+	memset(cmd, 0, ksize(cmd));
+
+	iwl_mvm_scan_umac_dwell_v2(mvm, cmd, params);
+
+	mvm->scan_uid_status[uid] = type;
+
+	cmd->uid = cpu_to_le32(uid);
+
+	gen_flags = iwl_mvm_scan_umac_flags_v2(mvm, params, vif, type);
+	scan_params->general_params.flags = cpu_to_le16(gen_flags);
+
+	if (gen_flags & IWL_UMAC_SCAN_GEN_FLAGS_V2_FRAGMENTED_LMAC1)
+		scan_params->general_params.num_of_fragments[SCAN_LB_LMAC_IDX] =
+			IWL_SCAN_NUM_OF_FRAGS;
+	if (gen_flags & IWL_UMAC_SCAN_GEN_FLAGS_V2_FRAGMENTED_LMAC2)
+		scan_params->general_params.num_of_fragments[SCAN_HB_LMAC_IDX] =
+			IWL_SCAN_NUM_OF_FRAGS;
+
+	scan_params->general_params.scan_start_mac_id = scan_vif->id;
+
+	channel_flags = iwl_mvm_scan_umac_chan_flags_v2(mvm, params, vif);
+	channel_params->flags = channel_flags;
+
+	channel_params->count = params->n_channels;
+
+	 ret = iwl_mvm_fill_scan_sched_params(params,
+					      periodic_params->schedule,
+					      &periodic_params->delay);
+	if (ret)
+		return ret;
+
+	scan_params->probe_params.preq = params->preq;
+	scan_params->probe_params.ssid_num = params->n_ssids;
+	iwl_scan_build_ssids(params, scan_params->probe_params.direct_scan,
+			     NULL);
+
+	iwl_mvm_umac_scan_cfg_channels(mvm, params->channels,
+				       params->n_channels, 0,
+				       channel_params->channel_config);
+	return 0;
+}
+
 static int iwl_mvm_num_scans(struct iwl_mvm *mvm)
 {
 	return hweight32(mvm->scan_status & IWL_MVM_SCAN_MASK);
@@ -1720,7 +1905,9 @@ static int iwl_mvm_build_scan_cmd(struct iwl_mvm *mvm,
 {
 	if (fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_UMAC_SCAN)) {
 		hcmd->id = iwl_cmd_id(SCAN_REQ_UMAC, IWL_ALWAYS_LONG_GROUP, 0);
-		return  iwl_mvm_scan_umac(mvm, vif, params, type);
+		if (iwl_mvm_is_scan_ext_band_supported(mvm))
+			return iwl_mvm_scan_umac_v2(mvm, vif, params, type);
+		return iwl_mvm_scan_umac(mvm, vif, params, type);
 	}
 	hcmd->id = SCAN_OFFLOAD_REQUEST_CMD;
 	return  iwl_mvm_scan_lmac(mvm, vif, params);
@@ -2038,6 +2225,9 @@ int iwl_mvm_scan_size(struct iwl_mvm *mvm)
 	int base_size = IWL_SCAN_REQ_UMAC_SIZE_V1;
 	int tail_size;
 
+	if (iwl_mvm_is_scan_ext_band_supported(mvm))
+		return sizeof(struct iwl_scan_umac_req_v2);
+
 	if (iwl_mvm_is_adaptive_dwell_v2_supported(mvm))
 		base_size = IWL_SCAN_REQ_UMAC_SIZE_V8;
 	else if (iwl_mvm_is_adaptive_dwell_supported(mvm))
-- 
2.23.0

