Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D694E8C18
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2019 16:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390121AbfJ2Pr3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Oct 2019 11:47:29 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53234 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390030AbfJ2Pr2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Oct 2019 11:47:28 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iPTiO-0002sp-Ea; Tue, 29 Oct 2019 17:47:27 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 29 Oct 2019 17:47:20 +0200
Message-Id: <20191029154720.26477-1-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.4 v2] iwlwifi: fw api: support new  API for scan config cmd
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ayala Beker <ayala.beker@intel.com>

The API was reduced to include only knowledge currently needed by the
FW scan logic, the rest is legacy.  Support the new, reduced version.

Using the old API with newer firmwares (starting from
iwlwifi-*-50.ucode, which implements and requires the new API version)
causes an assertion failure similar to this one:

[    2.854505] iwlwifi 0000:00:14.3: 0x20000038 | BAD_COMMAND

Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---

In v2:

  * Expand the commit message to explain what the problem is.


.../net/wireless/intel/iwlwifi/fw/api/scan.h  | 22 +++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  3 ++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  6 +++
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 40 +++++++++++++++----
 4 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index 39c64850cb6f..c0750ced5ac2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -520,7 +520,7 @@ struct iwl_scan_dwell {
 } __packed;
 
 /**
- * struct iwl_scan_config
+ * struct iwl_scan_config_v1
  * @flags:			enum scan_config_flags
  * @tx_chains:			valid_tx antenna - ANT_* definitions
  * @rx_chains:			valid_rx antenna - ANT_* definitions
@@ -552,7 +552,7 @@ struct iwl_scan_config_v1 {
 #define SCAN_LB_LMAC_IDX 0
 #define SCAN_HB_LMAC_IDX 1
 
-struct iwl_scan_config {
+struct iwl_scan_config_v2 {
 	__le32 flags;
 	__le32 tx_chains;
 	__le32 rx_chains;
@@ -564,6 +564,24 @@ struct iwl_scan_config {
 	u8 bcast_sta_id;
 	u8 channel_flags;
 	u8 channel_array[];
+} __packed; /* SCAN_CONFIG_DB_CMD_API_S_2 */
+
+/**
+ * struct iwl_scan_config
+ * @enable_cam_mode: whether to enable CAM mode.
+ * @enable_promiscouos_mode: whether to enable promiscouos mode
+ * @bcast_sta_id: the index of the station in the fw
+ * @reserved: reserved
+ * @tx_chains: valid_tx antenna - ANT_* definitions
+ * @rx_chains: valid_rx antenna - ANT_* definitions
+ */
+struct iwl_scan_config {
+	u8 enable_cam_mode;
+	u8 enable_promiscouos_mode;
+	u8 bcast_sta_id;
+	u8 reserved;
+	__le32 tx_chains;
+	__le32 rx_chains;
 } __packed; /* SCAN_CONFIG_DB_CMD_API_S_3 */
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 423cc0cf8e78..0d5bc4ce5c07 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -288,6 +288,8 @@ typedef unsigned int __bitwise iwl_ucode_tlv_api_t;
  *	STA_CONTEXT_DOT11AX_API_S
  * @IWL_UCODE_TLV_CAPA_SAR_TABLE_VER: This ucode supports different sar
  *	version tables.
+ * @IWL_UCODE_TLV_API_REDUCED_SCAN_CONFIG: This ucode supports v3 of
+ *  SCAN_CONFIG_DB_CMD_API_S.
  *
  * @NUM_IWL_UCODE_TLV_API: number of bits used
  */
@@ -321,6 +323,7 @@ enum iwl_ucode_tlv_api {
 	IWL_UCODE_TLV_API_WOWLAN_TCP_SYN_WAKE	= (__force iwl_ucode_tlv_api_t)53,
 	IWL_UCODE_TLV_API_FTM_RTT_ACCURACY      = (__force iwl_ucode_tlv_api_t)54,
 	IWL_UCODE_TLV_API_SAR_TABLE_VER         = (__force iwl_ucode_tlv_api_t)55,
+	IWL_UCODE_TLV_API_REDUCED_SCAN_CONFIG   = (__force iwl_ucode_tlv_api_t)56,
 	IWL_UCODE_TLV_API_ADWELL_HB_DEF_N_AP	= (__force iwl_ucode_tlv_api_t)57,
 	IWL_UCODE_TLV_API_SCAN_EXT_CHAN_VER	= (__force iwl_ucode_tlv_api_t)58,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 843d00bf2bd5..5ca50f39a023 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1405,6 +1405,12 @@ static inline bool iwl_mvm_is_scan_ext_chan_supported(struct iwl_mvm *mvm)
 			  IWL_UCODE_TLV_API_SCAN_EXT_CHAN_VER);
 }
 
+static inline bool iwl_mvm_is_reduced_config_scan_supported(struct iwl_mvm *mvm)
+{
+	return fw_has_api(&mvm->fw->ucode_capa,
+			  IWL_UCODE_TLV_API_REDUCED_SCAN_CONFIG);
+}
+
 static inline bool iwl_mvm_has_new_rx_stats_api(struct iwl_mvm *mvm)
 {
 	return fw_has_api(&mvm->fw->ucode_capa,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index f6b3045badbd..fcafa22ec6ce 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1137,11 +1137,11 @@ static void iwl_mvm_fill_scan_config_v1(struct iwl_mvm *mvm, void *config,
 	iwl_mvm_fill_channels(mvm, cfg->channel_array, max_channels);
 }
 
-static void iwl_mvm_fill_scan_config(struct iwl_mvm *mvm, void *config,
-				     u32 flags, u8 channel_flags,
-				     u32 max_channels)
+static void iwl_mvm_fill_scan_config_v2(struct iwl_mvm *mvm, void *config,
+					u32 flags, u8 channel_flags,
+					u32 max_channels)
 {
-	struct iwl_scan_config *cfg = config;
+	struct iwl_scan_config_v2 *cfg = config;
 
 	cfg->flags = cpu_to_le32(flags);
 	cfg->tx_chains = cpu_to_le32(iwl_mvm_get_valid_tx_ant(mvm));
@@ -1185,7 +1185,7 @@ static void iwl_mvm_fill_scan_config(struct iwl_mvm *mvm, void *config,
 	iwl_mvm_fill_channels(mvm, cfg->channel_array, max_channels);
 }
 
-int iwl_mvm_config_scan(struct iwl_mvm *mvm)
+static int iwl_mvm_legacy_config_scan(struct iwl_mvm *mvm)
 {
 	void *cfg;
 	int ret, cmd_size;
@@ -1217,7 +1217,7 @@ int iwl_mvm_config_scan(struct iwl_mvm *mvm)
 	}
 
 	if (iwl_mvm_cdb_scan_api(mvm))
-		cmd_size = sizeof(struct iwl_scan_config);
+		cmd_size = sizeof(struct iwl_scan_config_v2);
 	else
 		cmd_size = sizeof(struct iwl_scan_config_v1);
 	cmd_size += num_channels;
@@ -1254,8 +1254,8 @@ int iwl_mvm_config_scan(struct iwl_mvm *mvm)
 			flags |= (iwl_mvm_is_scan_fragmented(hb_type)) ?
 				 SCAN_CONFIG_FLAG_SET_LMAC2_FRAGMENTED :
 				 SCAN_CONFIG_FLAG_CLEAR_LMAC2_FRAGMENTED;
-		iwl_mvm_fill_scan_config(mvm, cfg, flags, channel_flags,
-					 num_channels);
+		iwl_mvm_fill_scan_config_v2(mvm, cfg, flags, channel_flags,
+					    num_channels);
 	} else {
 		iwl_mvm_fill_scan_config_v1(mvm, cfg, flags, channel_flags,
 					    num_channels);
@@ -1277,6 +1277,30 @@ int iwl_mvm_config_scan(struct iwl_mvm *mvm)
 	return ret;
 }
 
+int iwl_mvm_config_scan(struct iwl_mvm *mvm)
+{
+	struct iwl_scan_config cfg;
+	struct iwl_host_cmd cmd = {
+		.id = iwl_cmd_id(SCAN_CFG_CMD, IWL_ALWAYS_LONG_GROUP, 0),
+		.len[0] = sizeof(cfg),
+		.data[0] = &cfg,
+		.dataflags[0] = IWL_HCMD_DFL_NOCOPY,
+	};
+
+	if (!iwl_mvm_is_reduced_config_scan_supported(mvm))
+		return iwl_mvm_legacy_config_scan(mvm);
+
+	memset(&cfg, 0, sizeof(cfg));
+
+	cfg.bcast_sta_id = mvm->aux_sta.sta_id;
+	cfg.tx_chains = cpu_to_le32(iwl_mvm_get_valid_tx_ant(mvm));
+	cfg.rx_chains = cpu_to_le32(iwl_mvm_scan_rx_ant(mvm));
+
+	IWL_DEBUG_SCAN(mvm, "Sending UMAC scan config\n");
+
+	return iwl_mvm_send_cmd(mvm, &cmd);
+}
+
 static int iwl_mvm_scan_uid_by_status(struct iwl_mvm *mvm, int status)
 {
 	int i;
-- 
2.23.0

