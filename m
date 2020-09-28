Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59DB127AAA9
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 11:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgI1JXr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 05:23:47 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52816 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726681AbgI1JXr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 05:23:47 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kMpNd-002KgD-Ij; Mon, 28 Sep 2020 12:23:34 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 28 Sep 2020 12:23:21 +0300
Message-Id: <iwlwifi.20200928121852.f54be85420dd.I39b498fbbbc2f6eed6ce1f77b0f59f7a72fab343@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928092321.649185-1-luca@coelho.fi>
References: <20200928092321.649185-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 12/12] iwlwifi: mvm: add support for responder dynamic config command version 3
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

Version 3 of the dynamic config command adds support for configuring
the HLTK for secure ranging with a station.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/location.h  |  45 +++++++-
 .../intel/iwlwifi/mvm/ftm-responder.c         | 104 +++++++++++++++++-
 2 files changed, 141 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
index cdf52b35d92c..465a8e3974e8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
@@ -321,12 +321,54 @@ struct iwl_tof_responder_config_cmd {
  *	data (if exists) follows, and then 0-padding again to complete a
  *	4-multiple long buffer.
  */
-struct iwl_tof_responder_dyn_config_cmd {
+struct iwl_tof_responder_dyn_config_cmd_v2 {
 	__le32 lci_len;
 	__le32 civic_len;
 	u8 lci_civic[];
 } __packed; /* TOF_RESPONDER_DYN_CONFIG_CMD_API_S_VER_2 */
 
+#define IWL_LCI_MAX_SIZE	160
+#define IWL_CIVIC_MAX_SIZE	160
+#define HLTK_11AZ_LEN	32
+
+/**
+ * enum iwl_responder_dyn_cfg_valid_flags - valid flags for dyn_config_cmd
+ * @IWL_RESPONDER_DYN_CFG_VALID_LCI: LCI data is valid
+ * @IWL_RESPONDER_DYN_CFG_VALID_CIVIC: Civic data is valid
+ * @IWL_RESPONDER_DYN_CFG_VALID_PASN_STA: the pasn_addr, HLTK and cipher fields
+ *	are valid.
+ */
+enum iwl_responder_dyn_cfg_valid_flags {
+	IWL_RESPONDER_DYN_CFG_VALID_LCI = BIT(0),
+	IWL_RESPONDER_DYN_CFG_VALID_CIVIC = BIT(1),
+	IWL_RESPONDER_DYN_CFG_VALID_PASN_STA = BIT(2),
+};
+
+/**
+ * struct iwl_tof_responder_dyn_config_cmd - Dynamic responder settings
+ * @cipher: The negotiated cipher. see &enum iwl_location_cipher.
+ * @valid_flags: flags indicating which fields in the command are valid. see
+ *	&enum iwl_responder_dyn_cfg_valid_flags.
+ * @lci_len: length of the LCI data in bytes
+ * @civic_len: length of the Civic data in bytes
+ * @lci_buf: the LCI buffer
+ * @civic_buf: the Civic buffer
+ * @hltk_buf: HLTK for secure LTF bits generation for the specified station
+ * @addr: mac address of the station for which to use the HLTK
+ * @reserved: for alignment
+ */
+struct iwl_tof_responder_dyn_config_cmd {
+	u8 cipher;
+	u8 valid_flags;
+	u8 lci_len;
+	u8 civic_len;
+	u8 lci_buf[IWL_LCI_MAX_SIZE];
+	u8 civic_buf[IWL_LCI_MAX_SIZE];
+	u8 hltk_buf[HLTK_11AZ_LEN];
+	u8 addr[ETH_ALEN];
+	u8 reserved[2];
+} __packed; /* TOF_RESPONDER_DYN_CONFIG_CMD_API_S_VER_3 */
+
 /**
  * struct iwl_tof_range_req_ext_cmd - extended range req for WLS
  * @tsf_timer_offset_msec: the recommended time offset (mSec) from the AP's TSF
@@ -507,7 +549,6 @@ enum iwl_location_bw {
 	IWL_LOCATION_BW_80MHZ,
 };
 
-#define HLTK_11AZ_LEN	32
 #define TK_11AZ_LEN	32
 
 #define LOCATION_BW_POS	4
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
index 160f3f934ace..e24e5bc7b40c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
@@ -68,6 +68,12 @@ struct iwl_mvm_pasn_sta {
 	u8 addr[ETH_ALEN];
 };
 
+struct iwl_mvm_pasn_hltk_data {
+	u8 *addr;
+	u8 cipher;
+	u8 *hltk;
+};
+
 static int iwl_mvm_ftm_responder_set_bw_v1(struct cfg80211_chan_def *chandef,
 					   u8 *bw, u8 *ctrl_ch_position)
 {
@@ -143,8 +149,7 @@ iwl_mvm_ftm_responder_cmd(struct iwl_mvm *mvm,
 		.sta_id = mvmvif->bcast_sta.sta_id,
 	};
 	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, LOCATION_GROUP,
-					   TOF_RESPONDER_CONFIG_CMD,
-					   IWL_FW_CMD_VER_UNKNOWN);
+					   TOF_RESPONDER_CONFIG_CMD, 6);
 	int err;
 
 	lockdep_assert_held(&mvm->mutex);
@@ -169,11 +174,11 @@ iwl_mvm_ftm_responder_cmd(struct iwl_mvm *mvm,
 }
 
 static int
-iwl_mvm_ftm_responder_dyn_cfg_cmd(struct iwl_mvm *mvm,
-				  struct ieee80211_vif *vif,
-				  struct ieee80211_ftm_responder_params *params)
+iwl_mvm_ftm_responder_dyn_cfg_v2(struct iwl_mvm *mvm,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_ftm_responder_params *params)
 {
-	struct iwl_tof_responder_dyn_config_cmd cmd = {
+	struct iwl_tof_responder_dyn_config_cmd_v2 cmd = {
 		.lci_len = cpu_to_le32(params->lci_len + 2),
 		.civic_len = cpu_to_le32(params->civicloc_len + 2),
 	};
@@ -214,6 +219,93 @@ iwl_mvm_ftm_responder_dyn_cfg_cmd(struct iwl_mvm *mvm,
 	return iwl_mvm_send_cmd(mvm, &hcmd);
 }
 
+static int
+iwl_mvm_ftm_responder_dyn_cfg_v3(struct iwl_mvm *mvm,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_ftm_responder_params *params,
+				 struct iwl_mvm_pasn_hltk_data *hltk_data)
+{
+	struct iwl_tof_responder_dyn_config_cmd cmd;
+	struct iwl_host_cmd hcmd = {
+		.id = iwl_cmd_id(TOF_RESPONDER_DYN_CONFIG_CMD,
+				 LOCATION_GROUP, 0),
+		.data[0] = &cmd,
+		.len[0] = sizeof(cmd),
+		/* may not be able to DMA from stack */
+		.dataflags[0] = IWL_HCMD_DFL_DUP,
+	};
+
+	lockdep_assert_held(&mvm->mutex);
+
+	cmd.valid_flags = 0;
+
+	if (params) {
+		if (params->lci_len + 2 > sizeof(cmd.lci_buf) ||
+		    params->civicloc_len + 2 > sizeof(cmd.civic_buf)) {
+			IWL_ERR(mvm,
+				"LCI/civic data too big (lci=%zd, civic=%zd)\n",
+				params->lci_len, params->civicloc_len);
+			return -ENOBUFS;
+		}
+
+		cmd.lci_buf[0] = WLAN_EID_MEASURE_REPORT;
+		cmd.lci_buf[1] = params->lci_len;
+		memcpy(cmd.lci_buf + 2, params->lci, params->lci_len);
+		cmd.lci_len = params->lci_len + 2;
+
+		cmd.civic_buf[0] = WLAN_EID_MEASURE_REPORT;
+		cmd.civic_buf[1] = params->civicloc_len;
+		memcpy(cmd.civic_buf + 2, params->civicloc,
+		       params->civicloc_len);
+		cmd.civic_len = params->civicloc_len + 2;
+
+		cmd.valid_flags |= IWL_RESPONDER_DYN_CFG_VALID_LCI |
+			IWL_RESPONDER_DYN_CFG_VALID_CIVIC;
+	}
+
+	if (hltk_data) {
+		if (hltk_data->cipher > IWL_LOCATION_CIPHER_GCMP_256) {
+			IWL_ERR(mvm, "invalid cipher: %u\n",
+				hltk_data->cipher);
+			return -EINVAL;
+		}
+
+		cmd.cipher = hltk_data->cipher;
+		memcpy(cmd.addr, hltk_data->addr, sizeof(cmd.addr));
+		memcpy(cmd.hltk_buf, hltk_data->hltk, sizeof(cmd.hltk_buf));
+		cmd.valid_flags |= IWL_RESPONDER_DYN_CFG_VALID_PASN_STA;
+	}
+
+	return iwl_mvm_send_cmd(mvm, &hcmd);
+}
+
+static int
+iwl_mvm_ftm_responder_dyn_cfg_cmd(struct iwl_mvm *mvm,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_ftm_responder_params *params)
+{
+	int ret;
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, LOCATION_GROUP,
+					   TOF_RESPONDER_DYN_CONFIG_CMD, 2);
+
+	switch (cmd_ver) {
+	case 2:
+		ret = iwl_mvm_ftm_responder_dyn_cfg_v2(mvm, vif,
+						       params);
+		break;
+	case 3:
+		ret = iwl_mvm_ftm_responder_dyn_cfg_v3(mvm, vif,
+						       params, NULL);
+		break;
+	default:
+		IWL_ERR(mvm, "Unsupported DYN_CONFIG_CMD version %u\n",
+			cmd_ver);
+		ret = -ENOTSUPP;
+	}
+
+	return ret;
+}
+
 int iwl_mvm_ftm_respoder_add_pasn_sta(struct iwl_mvm *mvm,
 				      struct ieee80211_vif *vif,
 				      u8 *addr, u32 cipher, u8 *tk, u32 tk_len,
-- 
2.28.0

