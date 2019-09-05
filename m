Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFB8AAA3F1
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 15:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388200AbfIENMv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 09:12:51 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:40906 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730839AbfIENMv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 09:12:51 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i5rZA-0005yI-4t; Thu, 05 Sep 2019 16:12:48 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  5 Sep 2019 16:12:25 +0300
Message-Id: <20190905131241.23487-3-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190905131241.23487-1-luca@coelho.fi>
References: <20190905131241.23487-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 02/18] iwlwifi: scan: add support for new scan request command version
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ayala Beker <ayala.beker@intel.com>

Scan API was changed to support 6Ghz channels as well.
Support the new version.

Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  | 55 ++++++++++--
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  6 ++
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 86 +++++++++++++------
 4 files changed, 116 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index c4960f045415..39c64850cb6f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -93,6 +93,8 @@ struct iwl_ssid_ie {
 #define IWL_SCAN_SHORT_BLACKLIST_LEN	16
 #define IWL_SCAN_MAX_PROFILES		11
 #define SCAN_OFFLOAD_PROBE_REQ_SIZE	512
+#define SCAN_NUM_BAND_PROBE_DATA_V_1	2
+#define SCAN_NUM_BAND_PROBE_DATA_V_2	3
 
 /* Default watchdog (in MS) for scheduled scan iteration */
 #define IWL_SCHED_SCAN_WATCHDOG cpu_to_le16(15000)
@@ -251,9 +253,22 @@ struct iwl_scan_probe_segment {
  * @common_data: last (and common) part of the probe
  * @buf: raw data block
  */
+struct iwl_scan_probe_req_v1 {
+	struct iwl_scan_probe_segment mac_header;
+	struct iwl_scan_probe_segment band_data[SCAN_NUM_BAND_PROBE_DATA_V_1];
+	struct iwl_scan_probe_segment common_data;
+	u8 buf[SCAN_OFFLOAD_PROBE_REQ_SIZE];
+} __packed;
+
+/* iwl_scan_probe_req - PROBE_REQUEST_FRAME_API_S_VER_v2
+ * @mac_header: first (and common) part of the probe
+ * @band_data: band specific data
+ * @common_data: last (and common) part of the probe
+ * @buf: raw data block
+ */
 struct iwl_scan_probe_req {
 	struct iwl_scan_probe_segment mac_header;
-	struct iwl_scan_probe_segment band_data[2];
+	struct iwl_scan_probe_segment band_data[SCAN_NUM_BAND_PROBE_DATA_V_2];
 	struct iwl_scan_probe_segment common_data;
 	u8 buf[SCAN_OFFLOAD_PROBE_REQ_SIZE];
 } __packed;
@@ -608,15 +623,29 @@ enum iwl_umac_scan_general_flags2 {
  * struct iwl_scan_channel_cfg_umac
  * @flags:		bitmap - 0-19:	directed scan to i'th ssid.
  * @channel_num:	channel number 1-13 etc.
+ * @band:		band of channel: 0 for 2GHz, 1 for 5GHz
  * @iter_count:		repetition count for the channel.
  * @iter_interval:	interval between two scan iterations on one channel.
  */
-struct iwl_scan_channel_cfg_umac {
+struct  iwl_scan_channel_cfg_umac {
 	__le32 flags;
-	u8 channel_num;
-	u8 iter_count;
-	__le16 iter_interval;
-} __packed; /* SCAN_CHANNEL_CFG_S_VER2 */
+	/* Both versions are of the same size, so use a union without adjusting
+	 * the command size later
+	 */
+	union {
+		struct {
+			u8 channel_num;
+			u8 iter_count;
+			__le16 iter_interval;
+		} v1;  /* SCAN_CHANNEL_CFG_S_VER1 */
+		struct {
+			u8 channel_num;
+			u8 band;
+			u8 iter_count;
+			u8 iter_interval;
+		 } v2; /* SCAN_CHANNEL_CFG_S_VER2 */
+	};
+} __packed;
 
 /**
  * struct iwl_scan_umac_schedule
@@ -630,6 +659,16 @@ struct iwl_scan_umac_schedule {
 	u8 reserved;
 } __packed; /* SCAN_SCHED_PARAM_API_S_VER_1 */
 
+struct iwl_scan_req_umac_tail_v1 {
+	/* SCAN_PERIODIC_PARAMS_API_S_VER_1 */
+	struct iwl_scan_umac_schedule schedule[IWL_MAX_SCHED_SCAN_PLANS];
+	__le16 delay;
+	__le16 reserved;
+	/* SCAN_PROBE_PARAMS_API_S_VER_1 */
+	struct iwl_scan_probe_req_v1 preq;
+	struct iwl_ssid_ie direct_scan[PROBE_OPTION_MAX];
+} __packed;
+
 /**
  * struct iwl_scan_req_umac_tail - the rest of the UMAC scan request command
  *      parameters following channels configuration array.
@@ -639,12 +678,12 @@ struct iwl_scan_umac_schedule {
  * @preq: probe request with IEs blocks
  * @direct_scan: list of SSIDs for directed active scan
  */
-struct iwl_scan_req_umac_tail {
+struct iwl_scan_req_umac_tail_v2 {
 	/* SCAN_PERIODIC_PARAMS_API_S_VER_1 */
 	struct iwl_scan_umac_schedule schedule[IWL_MAX_SCHED_SCAN_PLANS];
 	__le16 delay;
 	__le16 reserved;
-	/* SCAN_PROBE_PARAMS_API_S_VER_1 */
+	/* SCAN_PROBE_PARAMS_API_S_VER_2 */
 	struct iwl_scan_probe_req preq;
 	struct iwl_ssid_ie direct_scan[PROBE_OPTION_MAX];
 } __packed;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 418064ced337..3d567240ef11 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -323,6 +323,7 @@ enum iwl_ucode_tlv_api {
 	IWL_UCODE_TLV_API_FTM_RTT_ACCURACY      = (__force iwl_ucode_tlv_api_t)54,
 	IWL_UCODE_TLV_API_SAR_TABLE_VER         = (__force iwl_ucode_tlv_api_t)55,
 	IWL_UCODE_TLV_API_ADWELL_HB_DEF_N_AP	= (__force iwl_ucode_tlv_api_t)57,
+	IWL_UCODE_TLV_API_SCAN_EXT_CHAN_VER	= (__force iwl_ucode_tlv_api_t)58,
 
 	NUM_IWL_UCODE_TLV_API
 #ifdef __CHECKER__
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index ed52e2ea97d9..2aa9bfc5e113 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1387,6 +1387,12 @@ static inline bool iwl_mvm_cdb_scan_api(struct iwl_mvm *mvm)
 	return mvm->trans->cfg->device_family >= IWL_DEVICE_FAMILY_22000;
 }
 
+static inline bool iwl_mvm_is_scan_ext_chan_supported(struct iwl_mvm *mvm)
+{
+	return fw_has_api(&mvm->fw->ucode_capa,
+			  IWL_UCODE_TLV_API_SCAN_EXT_CHAN_VER);
+}
+
 static inline bool iwl_mvm_has_new_rx_stats_api(struct iwl_mvm *mvm)
 {
 	return fw_has_api(&mvm->fw->ucode_capa,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 2652e6ce4089..85e33310804e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -77,7 +77,10 @@
 #define IWL_SCAN_DWELL_FRAGMENTED	44
 #define IWL_SCAN_DWELL_EXTENDED		90
 #define IWL_SCAN_NUM_OF_FRAGS		3
+#define IWL_SCAN_LAST_2_4_CHN		14
 
+#define IWL_SCAN_BAND_5_2		0
+#define IWL_SCAN_BAND_2_4		1
 
 /* adaptive dwell max budget time [TU] for full scan */
 #define IWL_SCAN_ADWELL_MAX_BUDGET_FULL_SCAN 300
@@ -956,11 +959,24 @@ static int iwl_mvm_scan_lmac_flags(struct iwl_mvm *mvm,
 	return flags;
 }
 
+static void
+iwl_mvm_scan_set_legacy_probe_req(struct iwl_scan_probe_req_v1 *p_req,
+				  struct iwl_scan_probe_req src_p_req)
+{
+	int i;
+
+	p_req->mac_header = src_p_req.mac_header;
+	for (i = 0; i < SCAN_NUM_BAND_PROBE_DATA_V_1; i++)
+		p_req->band_data[i] = src_p_req.band_data[i];
+	p_req->common_data = src_p_req.common_data;
+	memcpy(p_req->buf, src_p_req.buf, SCAN_OFFLOAD_PROBE_REQ_SIZE);
+}
+
 static int iwl_mvm_scan_lmac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			     struct iwl_mvm_scan_params *params)
 {
 	struct iwl_scan_req_lmac *cmd = mvm->scan_cmd;
-	struct iwl_scan_probe_req *preq =
+	struct iwl_scan_probe_req_v1 *preq =
 		(void *)(cmd->data + sizeof(struct iwl_scan_channel_cfg_lmac) *
 			 mvm->fw->ucode_capa.n_scan_channels);
 	u32 ssid_bitmap = 0;
@@ -1030,7 +1046,7 @@ static int iwl_mvm_scan_lmac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	iwl_mvm_lmac_scan_cfg_channels(mvm, params->channels,
 				       params->n_channels, ssid_bitmap, cmd);
 
-	*preq = params->preq;
+	iwl_mvm_scan_set_legacy_probe_req(preq, params->preq);
 
 	return 0;
 }
@@ -1384,9 +1400,17 @@ iwl_mvm_umac_scan_cfg_channels(struct iwl_mvm *mvm,
 
 	for (i = 0; i < n_channels; i++) {
 		channel_cfg[i].flags = cpu_to_le32(ssid_bitmap);
-		channel_cfg[i].channel_num = channels[i]->hw_value;
-		channel_cfg[i].iter_count = 1;
-		channel_cfg[i].iter_interval = 0;
+		channel_cfg[i].v1.channel_num = channels[i]->hw_value;
+		if (iwl_mvm_is_scan_ext_chan_supported(mvm)) {
+			channel_cfg[i].v2.band =
+				channels[i]->hw_value <= IWL_SCAN_LAST_2_4_CHN ?
+					IWL_SCAN_BAND_2_4 : IWL_SCAN_BAND_5_2;
+			channel_cfg[i].v2.iter_count = 1;
+			channel_cfg[i].v2.iter_interval = 0;
+		} else {
+			channel_cfg[i].v1.iter_count = 1;
+			channel_cfg[i].v1.iter_interval = 0;
+		}
 	}
 }
 
@@ -1476,9 +1500,12 @@ static int iwl_mvm_scan_umac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	struct iwl_scan_req_umac *cmd = mvm->scan_cmd;
 	struct iwl_scan_umac_chan_param *chan_param;
 	void *cmd_data = iwl_mvm_get_scan_req_umac_data(mvm);
-	struct iwl_scan_req_umac_tail *sec_part = cmd_data +
-		sizeof(struct iwl_scan_channel_cfg_umac) *
-			mvm->fw->ucode_capa.n_scan_channels;
+	void *sec_part = cmd_data + sizeof(struct iwl_scan_channel_cfg_umac) *
+		mvm->fw->ucode_capa.n_scan_channels;
+	struct iwl_scan_req_umac_tail_v2 *tail_v2 =
+		(struct iwl_scan_req_umac_tail_v2 *)sec_part;
+	struct iwl_scan_req_umac_tail_v1 *tail_v1;
+	struct iwl_ssid_ie *direct_scan;
 	int uid, i;
 	u32 ssid_bitmap = 0;
 	u8 channel_flags = 0;
@@ -1540,18 +1567,12 @@ static int iwl_mvm_scan_umac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	chan_param->flags = channel_flags;
 	chan_param->count = params->n_channels;
 
-	iwl_scan_build_ssids(params, sec_part->direct_scan, &ssid_bitmap);
-
-	iwl_mvm_umac_scan_cfg_channels(mvm, params->channels,
-				       params->n_channels, ssid_bitmap,
-				       cmd_data);
-
 	for (i = 0; i < params->n_scan_plans; i++) {
 		struct cfg80211_sched_scan_plan *scan_plan =
 			&params->scan_plans[i];
 
-		sec_part->schedule[i].iter_count = scan_plan->iterations;
-		sec_part->schedule[i].interval =
+		tail_v2->schedule[i].iter_count = scan_plan->iterations;
+		tail_v2->schedule[i].interval =
 			cpu_to_le16(scan_plan->interval);
 	}
 
@@ -1561,12 +1582,23 @@ static int iwl_mvm_scan_umac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	 * For example, when regular scan is requested the driver sets one scan
 	 * plan with one iteration.
 	 */
-	if (!sec_part->schedule[i - 1].iter_count)
-		sec_part->schedule[i - 1].iter_count = 0xff;
+	if (!tail_v2->schedule[i - 1].iter_count)
+		tail_v2->schedule[i - 1].iter_count = 0xff;
 
-	sec_part->delay = cpu_to_le16(params->delay);
-	sec_part->preq = params->preq;
+	tail_v2->delay = cpu_to_le16(params->delay);
 
+	if (iwl_mvm_is_scan_ext_chan_supported(mvm)) {
+		tail_v2->preq = params->preq;
+		direct_scan = tail_v2->direct_scan;
+	} else {
+		tail_v1 = (struct iwl_scan_req_umac_tail_v1 *)sec_part;
+		iwl_mvm_scan_set_legacy_probe_req(&tail_v1->preq, params->preq);
+		direct_scan = tail_v1->direct_scan;
+	}
+	iwl_scan_build_ssids(params, direct_scan, &ssid_bitmap);
+	iwl_mvm_umac_scan_cfg_channels(mvm, params->channels,
+				       params->n_channels, ssid_bitmap,
+				       cmd_data);
 	return 0;
 }
 
@@ -1996,6 +2028,7 @@ static int iwl_mvm_scan_stop_wait(struct iwl_mvm *mvm, int type)
 int iwl_mvm_scan_size(struct iwl_mvm *mvm)
 {
 	int base_size = IWL_SCAN_REQ_UMAC_SIZE_V1;
+	int tail_size;
 
 	if (iwl_mvm_is_adaptive_dwell_v2_supported(mvm))
 		base_size = IWL_SCAN_REQ_UMAC_SIZE_V8;
@@ -2004,16 +2037,21 @@ int iwl_mvm_scan_size(struct iwl_mvm *mvm)
 	else if (iwl_mvm_cdb_scan_api(mvm))
 		base_size = IWL_SCAN_REQ_UMAC_SIZE_V6;
 
-	if (fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_UMAC_SCAN))
+	if (fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_UMAC_SCAN)) {
+		if (iwl_mvm_is_scan_ext_chan_supported(mvm))
+			tail_size = sizeof(struct iwl_scan_req_umac_tail_v2);
+		else
+			tail_size = sizeof(struct iwl_scan_req_umac_tail_v1);
+
 		return base_size +
 			sizeof(struct iwl_scan_channel_cfg_umac) *
 				mvm->fw->ucode_capa.n_scan_channels +
-			sizeof(struct iwl_scan_req_umac_tail);
-
+			tail_size;
+	}
 	return sizeof(struct iwl_scan_req_lmac) +
 		sizeof(struct iwl_scan_channel_cfg_lmac) *
 		mvm->fw->ucode_capa.n_scan_channels +
-		sizeof(struct iwl_scan_probe_req);
+		sizeof(struct iwl_scan_probe_req_v1);
 }
 
 /*
-- 
2.23.0.rc1

