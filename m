Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 219B4103771
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 11:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfKTK1A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 05:27:00 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:58514 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728148AbfKTK07 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 05:26:59 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iXNCK-0001kS-VU; Wed, 20 Nov 2019 12:26:57 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 20 Nov 2019 12:26:40 +0200
Message-Id: <20191120102650.514376-3-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120102650.514376-1-luca@coelho.fi>
References: <20191120102650.514376-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 02/12] iwlwifi: scan: support scan req FW API ver 13
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tova Mussai <tova.mussai@intel.com>

1. Modify channel config flags to be used for legacy bands channels
   as well, to indicate SSIDs elements from ssidIEsArray.
2. Add new general flag.
3. Remove ssidNum from probe params.

Signed-off-by: Tova Mussai <tova.mussai@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  | 56 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 54 +++++++++++++++++-
 2 files changed, 104 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index 71883ca6a596..408798f351c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -664,6 +664,9 @@ enum iwl_umac_scan_general_flags2 {
  * @IWL_UMAC_SCAN_GEN_FLAGS_V2_MULTI_SSID: matching on multiple SSIDs
  * @IWL_UMAC_SCAN_GEN_FLAGS_V2_FORCE_PASSIVE: all the channels scanned
  *                                           as passive
+ * @IWL_UMAC_SCAN_GEN_FLAGS_V2_TRIGGER_UHB_SCAN: at the end of 2.4GHz and
+ *		5.2Ghz bands scan, trigger scan on 6GHz band to discover
+ *		the reported collocated APs
  */
 enum iwl_umac_scan_general_flags_v2 {
 	IWL_UMAC_SCAN_GEN_FLAGS_V2_PERIODIC             = BIT(0),
@@ -678,6 +681,7 @@ enum iwl_umac_scan_general_flags_v2 {
 	IWL_UMAC_SCAN_GEN_FLAGS_V2_NTF_START            = BIT(9),
 	IWL_UMAC_SCAN_GEN_FLAGS_V2_MULTI_SSID           = BIT(10),
 	IWL_UMAC_SCAN_GEN_FLAGS_V2_FORCE_PASSIVE        = BIT(11),
+	IWL_UMAC_SCAN_GEN_FLAGS_V2_TRIGGER_UHB_SCAN     = BIT(12),
 };
 
 /**
@@ -893,7 +897,27 @@ struct iwl_scan_probe_params_v3 {
 	struct iwl_ssid_ie direct_scan[PROBE_OPTION_MAX];
 	__le32 short_ssid[SCAN_SHORT_SSID_MAX_SIZE];
 	u8 bssid_array[ETH_ALEN][SCAN_BSSID_MAX_SIZE];
-} __packed;
+} __packed; /* SCAN_PROBE_PARAMS_API_S_VER_3 */
+
+/**
+ * struct iwl_scan_probe_params_v4
+ * @preq: scan probe request params
+ * @short_ssid_num: number of valid short SSIDs in short ssid array
+ * @bssid_num: number of valid bssid in bssids array
+ * @reserved: reserved
+ * @direct_scan: list of ssids
+ * @short_ssid: array of short ssids
+ * @bssid_array: array of bssids
+ */
+struct iwl_scan_probe_params_v4 {
+	struct iwl_scan_probe_req preq;
+	u8 short_ssid_num;
+	u8 bssid_num;
+	__le16 reserved;
+	struct iwl_ssid_ie direct_scan[PROBE_OPTION_MAX];
+	__le32 short_ssid[SCAN_SHORT_SSID_MAX_SIZE];
+	u8 bssid_array[ETH_ALEN][SCAN_BSSID_MAX_SIZE];
+} __packed; /* SCAN_PROBE_PARAMS_API_S_VER_4 */
 
 #define SCAN_MAX_NUM_CHANS_V3 67
 
@@ -932,8 +956,8 @@ struct iwl_scan_channel_params_v4 {
 	u8 reserved;
 	struct iwl_scan_channel_cfg_umac channel_config[SCAN_MAX_NUM_CHANS_V3];
 	u8 adwell_ch_override_bitmap[16];
-} __packed; /* SCAN_CHANNEL_PARAMS_API_S_VER_4 */
-
+} __packed; /* SCAN_CHANNEL_PARAMS_API_S_VER_4 also
+	       SCAN_CHANNEL_PARAMS_API_S_VER_5 */
 /**
  * struct iwl_scan_general_params_v10
  * @flags: &enum iwl_umac_scan_flags
@@ -1014,6 +1038,20 @@ struct iwl_scan_req_params_v12 {
 	struct iwl_scan_probe_params_v3 probe_params;
 } __packed; /* SCAN_REQUEST_PARAMS_API_S_VER_12 */
 
+/**
+ * struct iwl_scan_req_params_v13
+ * @general_params: &struct iwl_scan_general_params_v10
+ * @channel_params: &struct iwl_scan_channel_params_v4
+ * @periodic_params: &struct iwl_scan_periodic_parms_v1
+ * @probe_params: &struct iwl_scan_probe_params_v4
+ */
+struct iwl_scan_req_params_v13 {
+	struct iwl_scan_general_params_v10 general_params;
+	struct iwl_scan_channel_params_v4 channel_params;
+	struct iwl_scan_periodic_parms_v1 periodic_params;
+	struct iwl_scan_probe_params_v4 probe_params;
+} __packed; /* SCAN_REQUEST_PARAMS_API_S_VER_13 */
+
 /**
  * struct iwl_scan_req_umac_v11
  * @uid: scan id, &enum iwl_umac_scan_uid_offsets
@@ -1038,6 +1076,18 @@ struct iwl_scan_req_umac_v12 {
 	struct iwl_scan_req_params_v12 scan_params;
 } __packed; /* SCAN_REQUEST_CMD_UMAC_API_S_VER_12 */
 
+/**
+ * struct iwl_scan_req_umac_v13
+ * @uid: scan id, &enum iwl_umac_scan_uid_offsets
+ * @ooc_priority: out of channel priority - &enum iwl_scan_priority
+ * @scan_params: scan parameters
+ */
+struct iwl_scan_req_umac_v13 {
+	__le32 uid;
+	__le32 ooc_priority;
+	struct iwl_scan_req_params_v13 scan_params;
+} __packed; /* SCAN_REQUEST_CMD_UMAC_API_S_VER_13 */
+
 /**
  * struct iwl_umac_scan_abort
  * @uid: scan id, &enum iwl_umac_scan_uid_offsets
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 60edba558c99..a046ac9fa852 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1897,6 +1897,15 @@ iwl_mvm_scan_umac_fill_probe_p_v3(struct iwl_mvm_scan_params *params,
 	iwl_scan_build_ssids(params, pp->direct_scan, NULL);
 }
 
+static void
+iwl_mvm_scan_umac_fill_probe_p_v4(struct iwl_mvm_scan_params *params,
+				  struct iwl_scan_probe_params_v4 *pp,
+				  u32 *bitmap_ssid)
+{
+	pp->preq = params->preq;
+	iwl_scan_build_ssids(params, pp->direct_scan, bitmap_ssid);
+}
+
 static void
 iwl_mvm_scan_umac_fill_ch_p_v3(struct iwl_mvm *mvm,
 			       struct iwl_mvm_scan_params *params,
@@ -1915,14 +1924,17 @@ static void
 iwl_mvm_scan_umac_fill_ch_p_v4(struct iwl_mvm *mvm,
 			       struct iwl_mvm_scan_params *params,
 			       struct ieee80211_vif *vif,
-			       struct iwl_scan_channel_params_v4 *cp)
+			       struct iwl_scan_channel_params_v4 *cp,
+			       u32 channel_cfg_flags)
 {
 	cp->flags = iwl_mvm_scan_umac_chan_flags_v2(mvm, params, vif);
 	cp->count = params->n_channels;
 	cp->num_of_aps_override = IWL_SCAN_ADWELL_DEFAULT_N_APS_OVERRIDE;
 
 	iwl_mvm_umac_scan_cfg_channels_v4(mvm, params->channels, cp,
-					  params->n_channels, 0, vif->type);
+					  params->n_channels,
+					  channel_cfg_flags,
+					  vif->type);
 }
 
 static int iwl_mvm_scan_umac_v11(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
@@ -1984,7 +1996,41 @@ static int iwl_mvm_scan_umac_v12(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	iwl_mvm_scan_umac_fill_probe_p_v3(params, &scan_p->probe_params);
 	iwl_mvm_scan_umac_fill_ch_p_v4(mvm, params, vif,
-				       &scan_p->channel_params);
+				       &scan_p->channel_params, 0);
+
+	return 0;
+}
+
+static int iwl_mvm_scan_umac_v13(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+				 struct iwl_mvm_scan_params *params, int type,
+				 int uid)
+{
+	struct iwl_scan_req_umac_v13 *cmd = mvm->scan_cmd;
+	struct iwl_scan_req_params_v13 *scan_p = &cmd->scan_params;
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
+	iwl_mvm_scan_umac_fill_ch_p_v4(mvm, params, vif,
+				       &scan_p->channel_params, bitmap_ssid);
 
 	return 0;
 }
@@ -2104,6 +2150,7 @@ struct iwl_scan_umac_handler {
 
 static const struct iwl_scan_umac_handler iwl_scan_umac_handlers[] = {
 	/* set the newest version first to shorten the list traverse time */
+	IWL_SCAN_UMAC_HANDLER(13),
 	IWL_SCAN_UMAC_HANDLER(12),
 	IWL_SCAN_UMAC_HANDLER(11),
 };
@@ -2462,6 +2509,7 @@ static int iwl_mvm_scan_stop_wait(struct iwl_mvm *mvm, int type)
 static int iwl_scan_req_umac_get_size(u8 scan_ver)
 {
 	switch (scan_ver) {
+		IWL_SCAN_REQ_UMAC_HANDLE_SIZE(13);
 		IWL_SCAN_REQ_UMAC_HANDLE_SIZE(12);
 		IWL_SCAN_REQ_UMAC_HANDLE_SIZE(11);
 	}
-- 
2.24.0

