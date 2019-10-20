Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12CF7DDD5E
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Oct 2019 10:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfJTIz5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Oct 2019 04:55:57 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50772 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726115AbfJTIz5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Oct 2019 04:55:57 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iM70E-0003LY-QX; Sun, 20 Oct 2019 11:55:55 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 20 Oct 2019 11:55:36 +0300
Message-Id: <20191020085545.16407-4-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191020085545.16407-1-luca@coelho.fi>
References: <20191020085545.16407-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 03/12] iwlwifi: scan: make new scan req versioning flow
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Implement a new versioning handling flow supported from version 11
onwards.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  | 113 ++++----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   9 -
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 248 +++++++++++-------
 3 files changed, 208 insertions(+), 162 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index 0a3a529a09d1..bcd183bbae91 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -626,7 +626,10 @@ enum iwl_umac_scan_general_flags2 {
 };
 
 /**
- * enum iwl_umac_scan_general_flags_v22 - UMAC scan general flags ver 2
+ * enum iwl_umac_scan_general_flags_v2 - UMAC scan general flags version 2
+ *
+ * The FW flags were reordered and hence the driver introduce version 2
+ *
  * @IWL_UMAC_SCAN_GEN_FLAGS_V2_PERIODIC: periodic or scheduled
  * @IWL_UMAC_SCAN_GEN_FLAGS_V2_PASS_ALL: pass all probe responses and beacons
  *                                       during scan iterations
@@ -853,7 +856,7 @@ struct iwl_scan_req_umac {
 #define IWL_SCAN_REQ_UMAC_SIZE_V1 36
 
 /**
- * struct iwl_scan_probe_params
+ * struct iwl_scan_probe_params_v3
  * @preq: scan probe request params
  * @ssid_num: number of valid SSIDs in direct scan array
  * @short_ssid_num: number of valid short SSIDs in short ssid array
@@ -862,8 +865,8 @@ struct iwl_scan_req_umac {
  * @direct_scan: list of ssids
  * @short_ssid: array of short ssids
  * @bssid_array: array of bssids
-*/
-struct iwl_scan_probe_params {
+ */
+struct iwl_scan_probe_params_v3 {
 	struct iwl_scan_probe_req preq;
 	u8 ssid_num;
 	u8 short_ssid_num;
@@ -877,44 +880,44 @@ struct iwl_scan_probe_params {
 #define SCAN_MAX_NUM_CHANS_V3 67
 
 /**
- * struct iwl_scan_channel_params
+ * struct iwl_scan_channel_params_v3
  * @flags: channel flags &enum iwl_scan_channel_flags
  * @count: num of channels in scan request
  * @reserved: for future use and alignment
  * @channel_config: array of explicit channel configurations
  *                  for 2.4Ghz and 5.2Ghz bands
  */
-struct iwl_scan_channel_params {
+struct iwl_scan_channel_params_v3 {
 	u8 flags;
 	u8 count;
 	__le16 reserved;
 	struct iwl_scan_channel_cfg_umac channel_config[SCAN_MAX_NUM_CHANS_V3];
-} __packed;
+} __packed; /* SCAN_CHANNEL_PARAMS_API_S_VER_3 */
 
- /**
-  * struct iwl_scan_general_params
-  * @flags: &enum iwl_umac_scan_flags
-  * @reserved: reserved for future
-  * @scan_start_mac_id: report the scan start TSF time according to this mac TSF
-  * @active_dwell: dwell time for active scan per LMAC
-  * @adwell_default_2g: adaptive dwell default number of APs
-  *                        for 2.4GHz channel
-  * @ddwell_default_5g: adaptive dwell default number of APs
-  *                        for 5GHz channels
-  * @adwell_default_social_chn: adaptive dwell default number of
-  *                             APs per social channel
-  * @reserved1: reserved for future
-  * @adwell_max_budget: the maximal number of TUs that adaptive dwell
-  *                     can add to the total scan time
-  * @max_out_of_time: max out of serving channel time, per LMAC
-  * @suspend_time: max suspend time, per LMAC
-  * @scan_priority: priority of the request
-  * @passive_dwell: continues dwell time for passive channel
-  *                 (without adaptive dwell)
-  * @num_of_fragments: number of fragments needed for full fragmented
-  *                    scan coverage.
-  * */
-struct iwl_scan_general_params {
+/**
+ * struct iwl_scan_general_params_v10
+ * @flags: &enum iwl_umac_scan_flags
+ * @reserved: reserved for future
+ * @scan_start_mac_id: report the scan start TSF time according to this mac TSF
+ * @active_dwell: dwell time for active scan per LMAC
+ * @adwell_default_2g: adaptive dwell default number of APs
+ *                        for 2.4GHz channel
+ * @adwell_default_5g: adaptive dwell default number of APs
+ *                        for 5GHz channels
+ * @adwell_default_social_chn: adaptive dwell default number of
+ *                             APs per social channel
+ * @reserved1: reserved for future
+ * @adwell_max_budget: the maximal number of TUs that adaptive dwell
+ *                     can add to the total scan time
+ * @max_out_of_time: max out of serving channel time, per LMAC
+ * @suspend_time: max suspend time, per LMAC
+ * @scan_priority: priority of the request
+ * @passive_dwell: continues dwell time for passive channel
+ *                 (without adaptive dwell)
+ * @num_of_fragments: number of fragments needed for full fragmented
+ *                    scan coverage.
+ */
+struct iwl_scan_general_params_v10 {
 	__le16 flags;
 	u8 reserved;
 	u8 scan_start_mac_id;
@@ -929,45 +932,45 @@ struct iwl_scan_general_params {
 	__le32 scan_priority;
 	u8 passive_dwell[SCAN_TWO_LMACS];
 	u8 num_of_fragments[SCAN_TWO_LMACS];
-} __packed;
+} __packed; /* SCAN_GENERAL_PARAMS_API_S_VER_10 */
 
 /**
-  * struct iwl_scan_periodic_parms
-  * @schedule: can scheduling parameter
-  * @delay: initial delay of the periodic scan in seconds
-  * @reserved: reserved for future
-  * */
-struct iwl_scan_periodic_parms {
+ * struct iwl_scan_periodic_parms_v1
+ * @schedule: can scheduling parameter
+ * @delay: initial delay of the periodic scan in seconds
+ * @reserved: reserved for future
+ */
+struct iwl_scan_periodic_parms_v1 {
 	struct iwl_scan_umac_schedule schedule[IWL_MAX_SCHED_SCAN_PLANS];
 	__le16 delay;
 	__le16 reserved;
-} __packed;
+} __packed; /* SCAN_PERIODIC_PARAMS_API_S_VER_1 */
 
 /**
-  * struct iwl_scan_req_params
-  * @general_params: &struct iwl_scan_general_params
-  * @channel_params: &struct iwl_scan_channel_params
-  * @periodic_params: &struct iwl_scan_periodic_parms
-  * @probe_params: &struct iwl_scan_probe_params
-  * */
-struct iwl_scan_req_params {
-	struct iwl_scan_general_params general_params;
-	struct iwl_scan_channel_params channel_params;
-	struct iwl_scan_periodic_parms periodic_params;
-	struct iwl_scan_probe_params probe_params;
-} __packed;
+ * struct iwl_scan_req_params_v11
+ * @general_params: &struct iwl_scan_general_params_v10
+ * @channel_params: &struct iwl_scan_channel_params_v3
+ * @periodic_params: &struct iwl_scan_periodic_parms_v1
+ * @probe_params: &struct iwl_scan_probe_params_v3
+ */
+struct iwl_scan_req_params_v11 {
+	struct iwl_scan_general_params_v10 general_params;
+	struct iwl_scan_channel_params_v3 channel_params;
+	struct iwl_scan_periodic_parms_v1 periodic_params;
+	struct iwl_scan_probe_params_v3 probe_params;
+} __packed; /* SCAN_REQUEST_PARAMS_API_S_VER_11 */
 
 /**
- * struct iwl_scan_req_umac_v2
+ * struct iwl_scan_req_umac_v11
  * @uid: scan id, &enum iwl_umac_scan_uid_offsets
  * @ooc_priority: out of channel priority - &enum iwl_scan_priority
  * @scan_params: scan parameters
  */
-struct iwl_scan_umac_req_v2 {
+struct iwl_scan_req_umac_v11 {
 	__le32 uid;
 	__le32 ooc_priority;
-	struct iwl_scan_req_params scan_params;
-} __packed;
+	struct iwl_scan_req_params_v11 scan_params;
+} __packed; /* SCAN_REQUEST_CMD_UMAC_API_S_VER_11 */
 
 /**
  * struct iwl_umac_scan_abort
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 261175f6aee8..a25712cce4ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1415,15 +1415,6 @@ static inline bool iwl_mvm_is_band_in_rx_supported(struct iwl_mvm *mvm)
 			   IWL_UCODE_TLV_API_BAND_IN_RX_DATA);
 }
 
-static inline bool iwl_mvm_is_scan_ext_band_supported(struct iwl_mvm *mvm)
-{
-	u8 cmd_ver = iwl_mvm_lookup_cmd_ver(mvm->fw, IWL_ALWAYS_LONG_GROUP,
-					    SCAN_REQ_UMAC);
-	if (cmd_ver == IWL_FW_CMD_VER_UNKNOWN)
-		return false;
-	return (cmd_ver >= 11);
-}
-
 static inline bool iwl_mvm_has_new_rx_stats_api(struct iwl_mvm *mvm)
 {
 	return fw_has_api(&mvm->fw->ucode_capa,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 543fc9ce5e25..5522e871479e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -974,10 +974,6 @@ static int iwl_mvm_scan_lmac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	int i;
 	u8 band;
 
-	lockdep_assert_held(&mvm->mutex);
-
-	memset(cmd, 0, ksize(cmd));
-
 	if (WARN_ON(params->n_scan_plans > IWL_MAX_SCHED_SCAN_PLANS))
 		return -EINVAL;
 
@@ -1383,9 +1379,17 @@ static void iwl_mvm_scan_umac_dwell(struct iwl_mvm *mvm,
 		cmd->ooc_priority = cpu_to_le32(IWL_SCAN_PRIORITY_EXT_2);
 }
 
-static void iwl_mvm_scan_umac_dwell_v2(struct iwl_mvm *mvm,
-				       struct iwl_scan_umac_req_v2 *cmd,
-				       struct iwl_mvm_scan_params *params)
+static u32 iwl_mvm_scan_umac_ooc_priority(struct iwl_mvm_scan_params *params)
+{
+	return iwl_mvm_is_regular_scan(params) ?
+		IWL_SCAN_PRIORITY_EXT_6 :
+		IWL_SCAN_PRIORITY_EXT_2;
+}
+
+static void
+iwl_mvm_scan_umac_dwell_v10(struct iwl_mvm *mvm,
+			    struct iwl_scan_general_params_v10 *general_params,
+			    struct iwl_mvm_scan_params *params)
 {
 	struct iwl_mvm_scan_timing_params *timing, *hb_timing;
 	u8 active_dwell, passive_dwell;
@@ -1396,51 +1400,39 @@ static void iwl_mvm_scan_umac_dwell_v2(struct iwl_mvm *mvm,
 	passive_dwell = params->measurement_dwell ?
 		params->measurement_dwell : IWL_SCAN_DWELL_PASSIVE;
 
-	cmd->scan_params.general_params.adwell_default_social_chn =
+	general_params->adwell_default_social_chn =
 		IWL_SCAN_ADWELL_DEFAULT_N_APS_SOCIAL;
-	cmd->scan_params.general_params.adwell_default_2g =
-		IWL_SCAN_ADWELL_DEFAULT_LB_N_APS;
-	cmd->scan_params.general_params.adwell_default_5g =
-			IWL_SCAN_ADWELL_DEFAULT_HB_N_APS;
+	general_params->adwell_default_2g = IWL_SCAN_ADWELL_DEFAULT_LB_N_APS;
+	general_params->adwell_default_5g = IWL_SCAN_ADWELL_DEFAULT_HB_N_APS;
 
 	/* if custom max budget was configured with debugfs */
 	if (IWL_MVM_ADWELL_MAX_BUDGET)
-		cmd->scan_params.general_params.adwell_max_budget =
+		general_params->adwell_max_budget =
 			cpu_to_le16(IWL_MVM_ADWELL_MAX_BUDGET);
 	else if (params->ssids && params->ssids[0].ssid_len)
-		cmd->scan_params.general_params.adwell_max_budget =
+		general_params->adwell_max_budget =
 			cpu_to_le16(IWL_SCAN_ADWELL_MAX_BUDGET_DIRECTED_SCAN);
 	else
-		cmd->scan_params.general_params.adwell_max_budget =
+		general_params->adwell_max_budget =
 			cpu_to_le16(IWL_SCAN_ADWELL_MAX_BUDGET_FULL_SCAN);
 
-	cmd->scan_params.general_params.scan_priority =
-		cpu_to_le32(IWL_SCAN_PRIORITY_EXT_6);
-	cmd->scan_params.general_params.max_out_of_time[SCAN_LB_LMAC_IDX] =
+	general_params->scan_priority = cpu_to_le32(IWL_SCAN_PRIORITY_EXT_6);
+	general_params->max_out_of_time[SCAN_LB_LMAC_IDX] =
 		cpu_to_le32(timing->max_out_time);
-	cmd->scan_params.general_params.suspend_time[SCAN_LB_LMAC_IDX] =
+	general_params->suspend_time[SCAN_LB_LMAC_IDX] =
 		cpu_to_le32(timing->suspend_time);
 
 	hb_timing = &scan_timing[params->hb_type];
 
-	cmd->scan_params.general_params.max_out_of_time[SCAN_HB_LMAC_IDX] =
+	general_params->max_out_of_time[SCAN_HB_LMAC_IDX] =
 		cpu_to_le32(hb_timing->max_out_time);
-	cmd->scan_params.general_params.suspend_time[SCAN_HB_LMAC_IDX] =
+	general_params->suspend_time[SCAN_HB_LMAC_IDX] =
 		cpu_to_le32(hb_timing->suspend_time);
 
-	cmd->scan_params.general_params.active_dwell[SCAN_LB_LMAC_IDX] =
-		active_dwell;
-	cmd->scan_params.general_params.passive_dwell[SCAN_LB_LMAC_IDX] =
-		passive_dwell;
-	cmd->scan_params.general_params.active_dwell[SCAN_HB_LMAC_IDX] =
-		active_dwell;
-	cmd->scan_params.general_params.passive_dwell[SCAN_HB_LMAC_IDX] =
-		passive_dwell;
-
-	if (iwl_mvm_is_regular_scan(params))
-		cmd->ooc_priority = cpu_to_le32(IWL_SCAN_PRIORITY_EXT_6);
-	else
-		cmd->ooc_priority = cpu_to_le32(IWL_SCAN_PRIORITY_EXT_2);
+	general_params->active_dwell[SCAN_LB_LMAC_IDX] = active_dwell;
+	general_params->passive_dwell[SCAN_LB_LMAC_IDX] = passive_dwell;
+	general_params->active_dwell[SCAN_HB_LMAC_IDX] = active_dwell;
+	general_params->passive_dwell[SCAN_HB_LMAC_IDX] = passive_dwell;
 }
 
 static void
@@ -1640,7 +1632,7 @@ iwl_mvm_fill_scan_sched_params(struct iwl_mvm_scan_params *params,
 
 static int iwl_mvm_scan_umac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			     struct iwl_mvm_scan_params *params,
-			     int type)
+			     int type, int uid)
 {
 	struct iwl_scan_req_umac *cmd = mvm->scan_cmd;
 	struct iwl_scan_umac_chan_param *chan_param;
@@ -1651,7 +1643,7 @@ static int iwl_mvm_scan_umac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		(struct iwl_scan_req_umac_tail_v2 *)sec_part;
 	struct iwl_scan_req_umac_tail_v1 *tail_v1;
 	struct iwl_ssid_ie *direct_scan;
-	int uid, ret = 0;
+	int ret = 0;
 	u32 ssid_bitmap = 0;
 	u8 channel_flags = 0;
 	u16 gen_flags;
@@ -1659,14 +1651,6 @@ static int iwl_mvm_scan_umac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	chan_param = iwl_mvm_get_scan_req_umac_channel(mvm);
 
-	lockdep_assert_held(&mvm->mutex);
-
-	uid = iwl_mvm_scan_uid_by_status(mvm, 0);
-	if (uid < 0)
-		return uid;
-
-	memset(cmd, 0, ksize(cmd));
-
 	iwl_mvm_scan_umac_dwell(mvm, cmd, params);
 
 	mvm->scan_uid_status[uid] = type;
@@ -1730,68 +1714,79 @@ static int iwl_mvm_scan_umac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	return 0;
 }
 
-static int iwl_mvm_scan_umac_v2(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-				struct iwl_mvm_scan_params *params,
-				int type)
+static void
+iwl_mvm_scan_umac_fill_general_p_v10(struct iwl_mvm *mvm,
+				     struct iwl_mvm_scan_params *params,
+				     struct ieee80211_vif *vif,
+				     struct iwl_scan_general_params_v10 *gp,
+				     u16 gen_flags)
 {
-	struct iwl_scan_umac_req_v2 *cmd = mvm->scan_cmd;
-	int uid, ret = 0;
-	u8 channel_flags = 0;
-	u16 gen_flags;
-	struct iwl_scan_req_params *scan_params;
-	struct iwl_scan_periodic_parms *periodic_params;
-	struct iwl_scan_channel_params *channel_params;
-
 	struct iwl_mvm_vif *scan_vif = iwl_mvm_vif_from_mac80211(vif);
 
-	scan_params = &cmd->scan_params;
-	periodic_params = &scan_params->periodic_params;
-	channel_params = &scan_params->channel_params;
-	lockdep_assert_held(&mvm->mutex);
+	iwl_mvm_scan_umac_dwell_v10(mvm, gp, params);
 
-	uid = iwl_mvm_scan_uid_by_status(mvm, 0);
-	if (uid < 0)
-		return uid;
+	gp->flags = cpu_to_le16(gen_flags);
 
-	memset(cmd, 0, ksize(cmd));
+	if (gen_flags & IWL_UMAC_SCAN_GEN_FLAGS_V2_FRAGMENTED_LMAC1)
+		gp->num_of_fragments[SCAN_LB_LMAC_IDX] = IWL_SCAN_NUM_OF_FRAGS;
+	if (gen_flags & IWL_UMAC_SCAN_GEN_FLAGS_V2_FRAGMENTED_LMAC2)
+		gp->num_of_fragments[SCAN_HB_LMAC_IDX] = IWL_SCAN_NUM_OF_FRAGS;
 
-	iwl_mvm_scan_umac_dwell_v2(mvm, cmd, params);
+	gp->scan_start_mac_id = scan_vif->id;
+}
 
-	mvm->scan_uid_status[uid] = type;
+static void
+iwl_mvm_scan_umac_fill_probe_p_v3(struct iwl_mvm_scan_params *params,
+				  struct iwl_scan_probe_params_v3 *pp)
+{
+	pp->preq = params->preq;
+	pp->ssid_num = params->n_ssids;
+	iwl_scan_build_ssids(params, pp->direct_scan, NULL);
+}
 
-	cmd->uid = cpu_to_le32(uid);
+static void
+iwl_mvm_scan_umac_fill_ch_p_v3(struct iwl_mvm *mvm,
+			       struct iwl_mvm_scan_params *params,
+			       struct ieee80211_vif *vif,
+			       struct iwl_scan_channel_params_v3 *cp)
+{
+	cp->flags = iwl_mvm_scan_umac_chan_flags_v2(mvm, params, vif);
+	cp->count = params->n_channels;
 
-	gen_flags = iwl_mvm_scan_umac_flags_v2(mvm, params, vif, type);
-	scan_params->general_params.flags = cpu_to_le16(gen_flags);
+	iwl_mvm_umac_scan_cfg_channels(mvm, params->channels,
+				       params->n_channels, 0,
+				       cp->channel_config);
+}
 
-	if (gen_flags & IWL_UMAC_SCAN_GEN_FLAGS_V2_FRAGMENTED_LMAC1)
-		scan_params->general_params.num_of_fragments[SCAN_LB_LMAC_IDX] =
-			IWL_SCAN_NUM_OF_FRAGS;
-	if (gen_flags & IWL_UMAC_SCAN_GEN_FLAGS_V2_FRAGMENTED_LMAC2)
-		scan_params->general_params.num_of_fragments[SCAN_HB_LMAC_IDX] =
-			IWL_SCAN_NUM_OF_FRAGS;
+static int iwl_mvm_scan_umac_v11(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+				 struct iwl_mvm_scan_params *params, int type,
+				 int uid)
+{
+	struct iwl_scan_req_umac_v11 *cmd = mvm->scan_cmd;
+	struct iwl_scan_req_params_v11 *scan_p = &cmd->scan_params;
+	int ret;
+	u16 gen_flags;
 
-	scan_params->general_params.scan_start_mac_id = scan_vif->id;
+	mvm->scan_uid_status[uid] = type;
 
-	channel_flags = iwl_mvm_scan_umac_chan_flags_v2(mvm, params, vif);
-	channel_params->flags = channel_flags;
+	cmd->ooc_priority = cpu_to_le32(iwl_mvm_scan_umac_ooc_priority(params));
+	cmd->uid = cpu_to_le32(uid);
 
-	channel_params->count = params->n_channels;
+	gen_flags = iwl_mvm_scan_umac_flags_v2(mvm, params, vif, type);
+	iwl_mvm_scan_umac_fill_general_p_v10(mvm, params, vif,
+					     &scan_p->general_params,
+					     gen_flags);
 
 	 ret = iwl_mvm_fill_scan_sched_params(params,
-					      periodic_params->schedule,
-					      &periodic_params->delay);
+					      scan_p->periodic_params.schedule,
+					      &scan_p->periodic_params.delay);
 	if (ret)
 		return ret;
 
-	scan_params->probe_params.preq = params->preq;
-	scan_params->probe_params.ssid_num = params->n_ssids;
-	iwl_scan_build_ssids(params, scan_params->probe_params.direct_scan,
-			     NULL);
+	iwl_mvm_scan_umac_fill_probe_p_v3(params, &scan_p->probe_params);
+	iwl_mvm_scan_umac_fill_ch_p_v3(mvm, params, vif,
+				       &scan_p->channel_params);
 
-	iwl_mvm_umac_scan_cfg_channels(mvm, params->channels,
-				       params->n_channels, 0,
-				       channel_params->channel_config);
 	return 0;
 }
 
@@ -1897,20 +1892,59 @@ static void iwl_mvm_fill_scan_type(struct iwl_mvm *mvm,
 	}
 }
 
+struct iwl_scan_umac_handler {
+	u8 version;
+	int (*handler)(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+		       struct iwl_mvm_scan_params *params, int type, int uid);
+};
+
+#define IWL_SCAN_UMAC_HANDLER(_ver) {		\
+	.version = _ver,			\
+	.handler = iwl_mvm_scan_umac_v##_ver,	\
+}
+
+static const struct iwl_scan_umac_handler iwl_scan_umac_handlers[] = {
+	IWL_SCAN_UMAC_HANDLER(11),
+};
+
 static int iwl_mvm_build_scan_cmd(struct iwl_mvm *mvm,
 				  struct ieee80211_vif *vif,
 				  struct iwl_host_cmd *hcmd,
 				  struct iwl_mvm_scan_params *params,
 				  int type)
 {
-	if (fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_UMAC_SCAN)) {
-		hcmd->id = iwl_cmd_id(SCAN_REQ_UMAC, IWL_ALWAYS_LONG_GROUP, 0);
-		if (iwl_mvm_is_scan_ext_band_supported(mvm))
-			return iwl_mvm_scan_umac_v2(mvm, vif, params, type);
-		return iwl_mvm_scan_umac(mvm, vif, params, type);
+	int uid, i;
+	u8 scan_ver;
+
+	lockdep_assert_held(&mvm->mutex);
+	memset(mvm->scan_cmd, 0, ksize(mvm->scan_cmd));
+
+	if (!fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_UMAC_SCAN)) {
+		hcmd->id = SCAN_OFFLOAD_REQUEST_CMD;
+
+		return iwl_mvm_scan_lmac(mvm, vif, params);
+	}
+
+	uid = iwl_mvm_scan_uid_by_status(mvm, 0);
+	if (uid < 0)
+		return uid;
+
+	hcmd->id = iwl_cmd_id(SCAN_REQ_UMAC, IWL_ALWAYS_LONG_GROUP, 0);
+
+	scan_ver = iwl_mvm_lookup_cmd_ver(mvm->fw, IWL_ALWAYS_LONG_GROUP,
+					  SCAN_REQ_UMAC);
+
+	for (i = 0; i < ARRAY_SIZE(iwl_scan_umac_handlers); i++) {
+		const struct iwl_scan_umac_handler *ver_handler =
+			&iwl_scan_umac_handlers[i];
+
+		if (ver_handler->version != scan_ver)
+			continue;
+
+		return ver_handler->handler(mvm, vif, params, type, uid);
 	}
-	hcmd->id = SCAN_OFFLOAD_REQUEST_CMD;
-	return  iwl_mvm_scan_lmac(mvm, vif, params);
+
+	return iwl_mvm_scan_umac(mvm, vif, params, type, uid);
 }
 
 int iwl_mvm_reg_scan_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
@@ -2220,13 +2254,29 @@ static int iwl_mvm_scan_stop_wait(struct iwl_mvm *mvm, int type)
 				     1 * HZ);
 }
 
+#define IWL_SCAN_REQ_UMAC_HANDLE_SIZE(_ver) {				\
+	case (_ver): return sizeof(struct iwl_scan_req_umac_v##_ver);	\
+}
+
+static int iwl_scan_req_umac_get_size(u8 scan_ver)
+{
+	switch (scan_ver) {
+		IWL_SCAN_REQ_UMAC_HANDLE_SIZE(11);
+	};
+
+	return 0;
+}
+
 int iwl_mvm_scan_size(struct iwl_mvm *mvm)
 {
-	int base_size = IWL_SCAN_REQ_UMAC_SIZE_V1;
-	int tail_size;
+	int base_size, tail_size;
+	u8 scan_ver = iwl_mvm_lookup_cmd_ver(mvm->fw, IWL_ALWAYS_LONG_GROUP,
+					     SCAN_REQ_UMAC);
+
+	base_size = iwl_scan_req_umac_get_size(scan_ver);
+	if (base_size)
+		return base_size;
 
-	if (iwl_mvm_is_scan_ext_band_supported(mvm))
-		return sizeof(struct iwl_scan_umac_req_v2);
 
 	if (iwl_mvm_is_adaptive_dwell_v2_supported(mvm))
 		base_size = IWL_SCAN_REQ_UMAC_SIZE_V8;
@@ -2234,6 +2284,8 @@ int iwl_mvm_scan_size(struct iwl_mvm *mvm)
 		base_size = IWL_SCAN_REQ_UMAC_SIZE_V7;
 	else if (iwl_mvm_cdb_scan_api(mvm))
 		base_size = IWL_SCAN_REQ_UMAC_SIZE_V6;
+	else
+		base_size = IWL_SCAN_REQ_UMAC_SIZE_V1;
 
 	if (fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_UMAC_SCAN)) {
 		if (iwl_mvm_is_scan_ext_chan_supported(mvm))
-- 
2.23.0

