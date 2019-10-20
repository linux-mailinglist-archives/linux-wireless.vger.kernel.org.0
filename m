Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0CC9DDD5F
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Oct 2019 10:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfJTIz7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Oct 2019 04:55:59 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50778 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725893AbfJTIz6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Oct 2019 04:55:58 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iM70F-0003LY-UI; Sun, 20 Oct 2019 11:55:56 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 20 Oct 2019 11:55:37 +0300
Message-Id: <20191020115138.7b0b15c6e809.Idc3c9d5d9b4bd2d1738bf8836c27f569b4649a05@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191020085545.16407-1-luca@coelho.fi>
References: <20191020085545.16407-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 04/12] iwlwifi: scan: support scan req cmd ver 12
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Implement scan request command version 12.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  |  48 +++++
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 180 ++++++++++++++++++
 2 files changed, 228 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index bcd183bbae91..59461b229156 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -894,6 +894,28 @@ struct iwl_scan_channel_params_v3 {
 	struct iwl_scan_channel_cfg_umac channel_config[SCAN_MAX_NUM_CHANS_V3];
 } __packed; /* SCAN_CHANNEL_PARAMS_API_S_VER_3 */
 
+/**
+ * struct iwl_scan_channel_params_v4
+ * @flags: channel flags &enum iwl_scan_channel_flags
+ * @count: num of channels in scan request
+ * @num_of_aps_override: override the number of APs the FW uses to calculate
+ *	dwell time when adaptive dwell is used
+ * @reserved: for future use and alignment
+ * @channel_config: array of explicit channel configurations
+ *                  for 2.4Ghz and 5.2Ghz bands
+ * @adwell_ch_override_bitmap: when using adaptive dwell, override the number
+ *	of APs value with &num_of_aps_override for the channel.
+ *	To cast channel to index, use &iwl_mvm_scan_ch_and_band_to_idx
+ */
+struct iwl_scan_channel_params_v4 {
+	u8 flags;
+	u8 count;
+	u8 num_of_aps_override;
+	u8 reserved;
+	struct iwl_scan_channel_cfg_umac channel_config[SCAN_MAX_NUM_CHANS_V3];
+	u8 adwell_ch_override_bitmap[16];
+} __packed; /* SCAN_CHANNEL_PARAMS_API_S_VER_4 */
+
 /**
  * struct iwl_scan_general_params_v10
  * @flags: &enum iwl_umac_scan_flags
@@ -960,6 +982,20 @@ struct iwl_scan_req_params_v11 {
 	struct iwl_scan_probe_params_v3 probe_params;
 } __packed; /* SCAN_REQUEST_PARAMS_API_S_VER_11 */
 
+/**
+ * struct iwl_scan_req_params_v12
+ * @general_params: &struct iwl_scan_general_params_v10
+ * @channel_params: &struct iwl_scan_channel_params_v4
+ * @periodic_params: &struct iwl_scan_periodic_parms_v1
+ * @probe_params: &struct iwl_scan_probe_params_v3
+ */
+struct iwl_scan_req_params_v12 {
+	struct iwl_scan_general_params_v10 general_params;
+	struct iwl_scan_channel_params_v4 channel_params;
+	struct iwl_scan_periodic_parms_v1 periodic_params;
+	struct iwl_scan_probe_params_v3 probe_params;
+} __packed; /* SCAN_REQUEST_PARAMS_API_S_VER_12 */
+
 /**
  * struct iwl_scan_req_umac_v11
  * @uid: scan id, &enum iwl_umac_scan_uid_offsets
@@ -972,6 +1008,18 @@ struct iwl_scan_req_umac_v11 {
 	struct iwl_scan_req_params_v11 scan_params;
 } __packed; /* SCAN_REQUEST_CMD_UMAC_API_S_VER_11 */
 
+/**
+ * struct iwl_scan_req_umac_v12
+ * @uid: scan id, &enum iwl_umac_scan_uid_offsets
+ * @ooc_priority: out of channel priority - &enum iwl_scan_priority
+ * @scan_params: scan parameters
+ */
+struct iwl_scan_req_umac_v12 {
+	__le32 uid;
+	__le32 ooc_priority;
+	struct iwl_scan_req_params_v12 scan_params;
+} __packed; /* SCAN_REQUEST_CMD_UMAC_API_S_VER_12 */
+
 /**
  * struct iwl_umac_scan_abort
  * @uid: scan id, &enum iwl_umac_scan_uid_offsets
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 5522e871479e..adfaa5d01206 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -89,6 +89,10 @@
 #define IWL_SCAN_ADWELL_DEFAULT_LB_N_APS 2
 /* adaptive dwell default APs number in social channels (1, 6, 11) */
 #define IWL_SCAN_ADWELL_DEFAULT_N_APS_SOCIAL 10
+/* number of scan channels */
+#define IWL_SCAN_NUM_CHANNELS 112
+/* adaptive dwell default number of APs override */
+#define IWL_SCAN_ADWELL_DEFAULT_N_APS_OVERRIDE 10
 
 struct iwl_mvm_scan_timing_params {
 	u32 suspend_time;
@@ -1435,6 +1439,104 @@ iwl_mvm_scan_umac_dwell_v10(struct iwl_mvm *mvm,
 	general_params->passive_dwell[SCAN_HB_LMAC_IDX] = passive_dwell;
 }
 
+struct iwl_mvm_scan_channel_segment {
+	u8 start_idx;
+	u8 end_idx;
+	u8 first_channel_id;
+	u8 last_channel_id;
+	u8 channel_spacing_shift;
+	u8 band;
+};
+
+static const struct iwl_mvm_scan_channel_segment scan_channel_segments[] = {
+	{
+		.start_idx = 0,
+		.end_idx = 13,
+		.first_channel_id = 1,
+		.last_channel_id = 14,
+		.channel_spacing_shift = 0,
+		.band = PHY_BAND_24
+	},
+	{
+		.start_idx = 14,
+		.end_idx = 41,
+		.first_channel_id = 36,
+		.last_channel_id = 144,
+		.channel_spacing_shift = 2,
+		.band = PHY_BAND_5
+	},
+	{
+		.start_idx = 42,
+		.end_idx = 50,
+		.first_channel_id = 149,
+		.last_channel_id = 181,
+		.channel_spacing_shift = 2,
+		.band = PHY_BAND_5
+	},
+};
+
+static int iwl_mvm_scan_ch_and_band_to_idx(u8 channel_id, u8 band)
+{
+	int i, index;
+
+	if (!channel_id)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(scan_channel_segments); i++) {
+		const struct iwl_mvm_scan_channel_segment *ch_segment =
+			&scan_channel_segments[i];
+		u32 ch_offset;
+
+		if (ch_segment->band != band ||
+		    ch_segment->first_channel_id > channel_id ||
+		    ch_segment->last_channel_id < channel_id)
+			continue;
+
+		ch_offset = (channel_id - ch_segment->first_channel_id) >>
+			ch_segment->channel_spacing_shift;
+
+		index = scan_channel_segments[i].start_idx + ch_offset;
+		if (index < IWL_SCAN_NUM_CHANNELS)
+			return index;
+
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static void iwl_mvm_scan_ch_add_n_aps_override(enum nl80211_iftype vif_type,
+					       u8 ch_id, u8 band, u8 *ch_bitmap,
+					       size_t bitmap_n_entries)
+{
+	int i;
+	static const u8 p2p_go_friendly_chs[] = {
+		36, 40, 44, 48, 149, 153, 157, 161, 165,
+	};
+
+	if (vif_type != NL80211_IFTYPE_P2P_DEVICE)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(p2p_go_friendly_chs); i++) {
+		if (p2p_go_friendly_chs[i] == ch_id) {
+			int ch_idx, bitmap_idx;
+
+			ch_idx = iwl_mvm_scan_ch_and_band_to_idx(ch_id, band);
+			if (ch_idx < 0)
+				return;
+
+			bitmap_idx = ch_idx / 8;
+			if (bitmap_idx >= bitmap_n_entries)
+				return;
+
+			ch_idx = ch_idx % 8;
+			ch_bitmap[bitmap_idx] |= BIT(ch_idx);
+
+			return;
+		}
+	}
+}
+
 static void
 iwl_mvm_umac_scan_cfg_channels(struct iwl_mvm *mvm,
 			       struct ieee80211_channel **channels,
@@ -1460,6 +1562,35 @@ iwl_mvm_umac_scan_cfg_channels(struct iwl_mvm *mvm,
 	}
 }
 
+static void
+iwl_mvm_umac_scan_cfg_channels_v4(struct iwl_mvm *mvm,
+				  struct ieee80211_channel **channels,
+				  struct iwl_scan_channel_params_v4 *cp,
+				  int n_channels, u32 flags,
+				  enum nl80211_iftype vif_type)
+{
+	u8 *bitmap = cp->adwell_ch_override_bitmap;
+	size_t bitmap_n_entries = ARRAY_SIZE(cp->adwell_ch_override_bitmap);
+	int i;
+
+	for (i = 0; i < n_channels; i++) {
+		enum nl80211_band band = channels[i]->band;
+		struct iwl_scan_channel_cfg_umac *cfg =
+			&cp->channel_config[i];
+
+		cfg->flags = cpu_to_le32(flags);
+		cfg->v2.channel_num = channels[i]->hw_value;
+		cfg->v2.band = iwl_mvm_phy_band_from_nl80211(band);
+		cfg->v2.iter_count = 1;
+		cfg->v2.iter_interval = 0;
+
+		iwl_mvm_scan_ch_add_n_aps_override(vif_type,
+						   cfg->v2.channel_num,
+						   cfg->v2.band, bitmap,
+						   bitmap_n_entries);
+	}
+}
+
 static u8 iwl_mvm_scan_umac_chan_flags_v2(struct iwl_mvm *mvm,
 					  struct iwl_mvm_scan_params *params,
 					  struct ieee80211_vif *vif)
@@ -1758,6 +1889,20 @@ iwl_mvm_scan_umac_fill_ch_p_v3(struct iwl_mvm *mvm,
 				       cp->channel_config);
 }
 
+static void
+iwl_mvm_scan_umac_fill_ch_p_v4(struct iwl_mvm *mvm,
+			       struct iwl_mvm_scan_params *params,
+			       struct ieee80211_vif *vif,
+			       struct iwl_scan_channel_params_v4 *cp)
+{
+	cp->flags = iwl_mvm_scan_umac_chan_flags_v2(mvm, params, vif);
+	cp->count = params->n_channels;
+	cp->num_of_aps_override = IWL_SCAN_ADWELL_DEFAULT_N_APS_OVERRIDE;
+
+	iwl_mvm_umac_scan_cfg_channels_v4(mvm, params->channels, cp,
+					  params->n_channels, 0, vif->type);
+}
+
 static int iwl_mvm_scan_umac_v11(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 				 struct iwl_mvm_scan_params *params, int type,
 				 int uid)
@@ -1790,6 +1935,38 @@ static int iwl_mvm_scan_umac_v11(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	return 0;
 }
 
+static int iwl_mvm_scan_umac_v12(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+				 struct iwl_mvm_scan_params *params, int type,
+				 int uid)
+{
+	struct iwl_scan_req_umac_v12 *cmd = mvm->scan_cmd;
+	struct iwl_scan_req_params_v12 *scan_p = &cmd->scan_params;
+	int ret;
+	u16 gen_flags;
+
+	mvm->scan_uid_status[uid] = type;
+
+	cmd->ooc_priority = cpu_to_le32(iwl_mvm_scan_umac_ooc_priority(params));
+	cmd->uid = cpu_to_le32(uid);
+
+	gen_flags = iwl_mvm_scan_umac_flags_v2(mvm, params, vif, type);
+	iwl_mvm_scan_umac_fill_general_p_v10(mvm, params, vif,
+					     &scan_p->general_params,
+					     gen_flags);
+
+	 ret = iwl_mvm_fill_scan_sched_params(params,
+					      scan_p->periodic_params.schedule,
+					      &scan_p->periodic_params.delay);
+	if (ret)
+		return ret;
+
+	iwl_mvm_scan_umac_fill_probe_p_v3(params, &scan_p->probe_params);
+	iwl_mvm_scan_umac_fill_ch_p_v4(mvm, params, vif,
+				       &scan_p->channel_params);
+
+	return 0;
+}
+
 static int iwl_mvm_num_scans(struct iwl_mvm *mvm)
 {
 	return hweight32(mvm->scan_status & IWL_MVM_SCAN_MASK);
@@ -1904,6 +2081,8 @@ struct iwl_scan_umac_handler {
 }
 
 static const struct iwl_scan_umac_handler iwl_scan_umac_handlers[] = {
+	/* set the newest version first to shorten the list traverse time */
+	IWL_SCAN_UMAC_HANDLER(12),
 	IWL_SCAN_UMAC_HANDLER(11),
 };
 
@@ -2261,6 +2440,7 @@ static int iwl_mvm_scan_stop_wait(struct iwl_mvm *mvm, int type)
 static int iwl_scan_req_umac_get_size(u8 scan_ver)
 {
 	switch (scan_ver) {
+		IWL_SCAN_REQ_UMAC_HANDLE_SIZE(12);
 		IWL_SCAN_REQ_UMAC_HANDLE_SIZE(11);
 	};
 
-- 
2.23.0

