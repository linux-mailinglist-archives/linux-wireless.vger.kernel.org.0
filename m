Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5261218F593
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 14:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgCWNTm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 09:19:42 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43408 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728461AbgCWNTl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 09:19:41 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jGMzR-00023f-Oi; Mon, 23 Mar 2020 15:19:38 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 23 Mar 2020 15:19:16 +0200
Message-Id: <iwlwifi.20200323151304.a4f4c675fc1a.I3b461108abf2306c3d054099112f2c3afce1cc92@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200323131925.208376-1-luca@coelho.fi>
References: <20200323131925.208376-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.4
Subject: [PATCH 05/14] iwlwifi: scan: support scan req cmd ver 14
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Modify adaptive dwell number of APs override API
Instead of using channel to index mapping, add the adaptive dwell
override parameters as part of the configuration per channel in the scan
request command.

Support 2 different override values and use them as follows:
1. 10 APs for friendly GO channels in p2p scan.
2. 2 APs for social channels in p2p scan.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  |  52 ++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 129 +++++++++++++++++-
 2 files changed, 173 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index 1b2b5fa56e19..2e70e4e752e1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -702,13 +702,16 @@ struct  iwl_scan_channel_cfg_umac {
 			u8 channel_num;
 			u8 iter_count;
 			__le16 iter_interval;
-		} v1;  /* SCAN_CHANNEL_CFG_S_VER1 */
+		} v1;  /* SCAN_CHANNEL_CONFIG_API_S_VER_1 */
 		struct {
 			u8 channel_num;
 			u8 band;
 			u8 iter_count;
 			u8 iter_interval;
-		 } v2; /* SCAN_CHANNEL_CFG_S_VER2 */
+		 } v2; /* SCAN_CHANNEL_CONFIG_API_S_VER_2
+			* SCAN_CHANNEL_CONFIG_API_S_VER_3
+			* SCAN_CHANNEL_CONFIG_API_S_VER_4
+			*/
 	};
 } __packed;
 
@@ -943,6 +946,25 @@ struct iwl_scan_channel_params_v4 {
 	u8 adwell_ch_override_bitmap[16];
 } __packed; /* SCAN_CHANNEL_PARAMS_API_S_VER_4 also
 	       SCAN_CHANNEL_PARAMS_API_S_VER_5 */
+
+/**
+ * struct iwl_scan_channel_params_v6
+ * @flags: channel flags &enum iwl_scan_channel_flags
+ * @count: num of channels in scan request
+ * @n_aps_override: override the number of APs the FW uses to calculate dwell
+ *	time when adaptive dwell is used.
+ *	Channel k will use n_aps_override[i] when BIT(20 + i) is set in
+ *	channel_config[k].flags
+ * @channel_config: array of explicit channel configurations
+ *                  for 2.4Ghz and 5.2Ghz bands
+ */
+struct iwl_scan_channel_params_v6 {
+	u8 flags;
+	u8 count;
+	u8 n_aps_override[2];
+	struct iwl_scan_channel_cfg_umac channel_config[SCAN_MAX_NUM_CHANS_V3];
+} __packed; /* SCAN_CHANNEL_PARAMS_API_S_VER_6 */
+
 /**
  * struct iwl_scan_general_params_v10
  * @flags: &enum iwl_umac_scan_flags
@@ -1023,6 +1045,20 @@ struct iwl_scan_req_params_v13 {
 	struct iwl_scan_probe_params_v4 probe_params;
 } __packed; /* SCAN_REQUEST_PARAMS_API_S_VER_13 */
 
+/**
+ * struct iwl_scan_req_params_v14
+ * @general_params: &struct iwl_scan_general_params_v10
+ * @channel_params: &struct iwl_scan_channel_params_v6
+ * @periodic_params: &struct iwl_scan_periodic_parms_v1
+ * @probe_params: &struct iwl_scan_probe_params_v4
+ */
+struct iwl_scan_req_params_v14 {
+	struct iwl_scan_general_params_v10 general_params;
+	struct iwl_scan_channel_params_v6 channel_params;
+	struct iwl_scan_periodic_parms_v1 periodic_params;
+	struct iwl_scan_probe_params_v4 probe_params;
+} __packed; /* SCAN_REQUEST_PARAMS_API_S_VER_14 */
+
 /**
  * struct iwl_scan_req_umac_v12
  * @uid: scan id, &enum iwl_umac_scan_uid_offsets
@@ -1047,6 +1083,18 @@ struct iwl_scan_req_umac_v13 {
 	struct iwl_scan_req_params_v13 scan_params;
 } __packed; /* SCAN_REQUEST_CMD_UMAC_API_S_VER_13 */
 
+/**
+ * struct iwl_scan_req_umac_v14
+ * @uid: scan id, &enum iwl_umac_scan_uid_offsets
+ * @ooc_priority: out of channel priority - &enum iwl_scan_priority
+ * @scan_params: scan parameters
+ */
+struct iwl_scan_req_umac_v14 {
+	__le32 uid;
+	__le32 ooc_priority;
+	struct iwl_scan_req_params_v14 scan_params;
+} __packed; /* SCAN_REQUEST_CMD_UMAC_API_S_VER_14 */
+
 /**
  * struct iwl_umac_scan_abort
  * @uid: scan id, &enum iwl_umac_scan_uid_offsets
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 3b263c81bcae..1fa74086a4f7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -91,8 +91,14 @@
 #define IWL_SCAN_ADWELL_DEFAULT_N_APS_SOCIAL 10
 /* number of scan channels */
 #define IWL_SCAN_NUM_CHANNELS 112
-/* adaptive dwell default number of APs override */
-#define IWL_SCAN_ADWELL_DEFAULT_N_APS_OVERRIDE 10
+/* adaptive dwell number of APs override mask for p2p friendly GO */
+#define IWL_SCAN_ADWELL_N_APS_GO_FRIENDLY_BIT BIT(20)
+/* adaptive dwell number of APs override mask for social channels */
+#define IWL_SCAN_ADWELL_N_APS_SOCIAL_CHS_BIT BIT(21)
+/* adaptive dwell number of APs override for p2p friendly GO channels */
+#define IWL_SCAN_ADWELL_N_APS_GO_FRIENDLY 10
+/* adaptive dwell number of APs override for social channels */
+#define IWL_SCAN_ADWELL_N_APS_SOCIAL_CHS 2
 
 struct iwl_mvm_scan_timing_params {
 	u32 suspend_time;
@@ -1529,14 +1535,19 @@ static int iwl_mvm_scan_ch_and_band_to_idx(u8 channel_id, u8 band)
 	return -EINVAL;
 }
 
+static const u8 p2p_go_friendly_chs[] = {
+	36, 40, 44, 48, 149, 153, 157, 161, 165,
+};
+
+static const u8 social_chs[] = {
+	1, 6, 11
+};
+
 static void iwl_mvm_scan_ch_add_n_aps_override(enum nl80211_iftype vif_type,
 					       u8 ch_id, u8 band, u8 *ch_bitmap,
 					       size_t bitmap_n_entries)
 {
 	int i;
-	static const u8 p2p_go_friendly_chs[] = {
-		36, 40, 44, 48, 149, 153, 157, 161, 165,
-	};
 
 	if (vif_type != NL80211_IFTYPE_P2P_DEVICE)
 		return;
@@ -1561,6 +1572,35 @@ static void iwl_mvm_scan_ch_add_n_aps_override(enum nl80211_iftype vif_type,
 	}
 }
 
+static u32 iwl_mvm_scan_ch_n_aps_flag(enum nl80211_iftype vif_type, u8 ch_id)
+{
+	int i;
+	u32 flags = 0;
+
+	if (vif_type != NL80211_IFTYPE_P2P_DEVICE)
+		goto out;
+
+	for (i = 0; i < ARRAY_SIZE(p2p_go_friendly_chs); i++) {
+		if (p2p_go_friendly_chs[i] == ch_id) {
+			flags |= IWL_SCAN_ADWELL_N_APS_GO_FRIENDLY_BIT;
+			break;
+		}
+	}
+
+	if (flags)
+		goto out;
+
+	for (i = 0; i < ARRAY_SIZE(social_chs); i++) {
+		if (social_chs[i] == ch_id) {
+			flags |= IWL_SCAN_ADWELL_N_APS_SOCIAL_CHS_BIT;
+			break;
+		}
+	}
+
+out:
+	return flags;
+}
+
 static void
 iwl_mvm_umac_scan_cfg_channels(struct iwl_mvm *mvm,
 			       struct ieee80211_channel **channels,
@@ -1615,6 +1655,30 @@ iwl_mvm_umac_scan_cfg_channels_v4(struct iwl_mvm *mvm,
 	}
 }
 
+static void
+iwl_mvm_umac_scan_cfg_channels_v6(struct iwl_mvm *mvm,
+				  struct ieee80211_channel **channels,
+				  struct iwl_scan_channel_params_v6 *cp,
+				  int n_channels, u32 flags,
+				  enum nl80211_iftype vif_type)
+{
+	int i;
+
+	for (i = 0; i < n_channels; i++) {
+		enum nl80211_band band = channels[i]->band;
+		struct iwl_scan_channel_cfg_umac *cfg = &cp->channel_config[i];
+		u32 n_aps_flag =
+			iwl_mvm_scan_ch_n_aps_flag(vif_type,
+						   cfg->v2.channel_num);
+
+		cfg->flags = cpu_to_le32(flags | n_aps_flag);
+		cfg->v2.channel_num = channels[i]->hw_value;
+		cfg->v2.band = iwl_mvm_phy_band_from_nl80211(band);
+		cfg->v2.iter_count = 1;
+		cfg->v2.iter_interval = 0;
+	}
+}
+
 static u8 iwl_mvm_scan_umac_chan_flags_v2(struct iwl_mvm *mvm,
 					  struct iwl_mvm_scan_params *params,
 					  struct ieee80211_vif *vif)
@@ -1915,7 +1979,7 @@ iwl_mvm_scan_umac_fill_ch_p_v4(struct iwl_mvm *mvm,
 {
 	cp->flags = iwl_mvm_scan_umac_chan_flags_v2(mvm, params, vif);
 	cp->count = params->n_channels;
-	cp->num_of_aps_override = IWL_SCAN_ADWELL_DEFAULT_N_APS_OVERRIDE;
+	cp->num_of_aps_override = IWL_SCAN_ADWELL_N_APS_GO_FRIENDLY;
 
 	iwl_mvm_umac_scan_cfg_channels_v4(mvm, params->channels, cp,
 					  params->n_channels,
@@ -1923,6 +1987,23 @@ iwl_mvm_scan_umac_fill_ch_p_v4(struct iwl_mvm *mvm,
 					  vif->type);
 }
 
+static void
+iwl_mvm_scan_umac_fill_ch_p_v6(struct iwl_mvm *mvm,
+			       struct iwl_mvm_scan_params *params,
+			       struct ieee80211_vif *vif,
+			       struct iwl_scan_channel_params_v6 *cp,
+			       u32 channel_cfg_flags)
+{
+	cp->flags = iwl_mvm_scan_umac_chan_flags_v2(mvm, params, vif);
+	cp->count = params->n_channels;
+	cp->n_aps_override[0] = IWL_SCAN_ADWELL_N_APS_GO_FRIENDLY;
+	cp->n_aps_override[1] = IWL_SCAN_ADWELL_N_APS_SOCIAL_CHS;
+
+	iwl_mvm_umac_scan_cfg_channels_v6(mvm, params->channels, cp,
+					  params->n_channels,
+					  channel_cfg_flags,
+					  vif->type);
+}
 
 static int iwl_mvm_scan_umac_v12(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 				 struct iwl_mvm_scan_params *params, int type,
@@ -1990,6 +2071,40 @@ static int iwl_mvm_scan_umac_v13(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	return 0;
 }
 
+static int iwl_mvm_scan_umac_v14(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+				 struct iwl_mvm_scan_params *params, int type,
+				 int uid)
+{
+	struct iwl_scan_req_umac_v14 *cmd = mvm->scan_cmd;
+	struct iwl_scan_req_params_v14 *scan_p = &cmd->scan_params;
+	int ret;
+	u16 gen_flags;
+	u32 bitmap_ssid = 0;
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
+	iwl_mvm_scan_umac_fill_probe_p_v4(params, &scan_p->probe_params,
+					  &bitmap_ssid);
+	iwl_mvm_scan_umac_fill_ch_p_v6(mvm, params, vif,
+				       &scan_p->channel_params, bitmap_ssid);
+
+	return 0;
+}
+
 static int iwl_mvm_num_scans(struct iwl_mvm *mvm)
 {
 	return hweight32(mvm->scan_status & IWL_MVM_SCAN_MASK);
@@ -2105,6 +2220,7 @@ struct iwl_scan_umac_handler {
 
 static const struct iwl_scan_umac_handler iwl_scan_umac_handlers[] = {
 	/* set the newest version first to shorten the list traverse time */
+	IWL_SCAN_UMAC_HANDLER(14),
 	IWL_SCAN_UMAC_HANDLER(13),
 	IWL_SCAN_UMAC_HANDLER(12),
 };
@@ -2463,6 +2579,7 @@ static int iwl_mvm_scan_stop_wait(struct iwl_mvm *mvm, int type)
 static int iwl_scan_req_umac_get_size(u8 scan_ver)
 {
 	switch (scan_ver) {
+		IWL_SCAN_REQ_UMAC_HANDLE_SIZE(14);
 		IWL_SCAN_REQ_UMAC_HANDLE_SIZE(13);
 		IWL_SCAN_REQ_UMAC_HANDLE_SIZE(12);
 	}
-- 
2.25.1

