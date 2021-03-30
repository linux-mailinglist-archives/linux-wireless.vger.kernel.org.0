Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB3434E908
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Mar 2021 15:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhC3NZu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Mar 2021 09:25:50 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43646 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232125AbhC3NZP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Mar 2021 09:25:15 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lREMo-0007fg-EE; Tue, 30 Mar 2021 16:25:12 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 30 Mar 2021 16:25:00 +0300
Message-Id: <iwlwifi.20210330162204.ce9570d755d3.Ic81cb8da9aecbbc9edff468cb4ffbb741418cc73@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210330132500.468321-1-luca@coelho.fi>
References: <20210330132500.468321-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 12/12] iwlwifi: mvm: responder: support responder config command version 8
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

Version 8 add NDP ranging parameters configuration, as well as
enable/disable NDP ranging and LMR feedback.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/location.h  | 67 ++++++++++++++++++-
 .../wireless/intel/iwlwifi/mvm/constants.h    |  2 +
 .../intel/iwlwifi/mvm/ftm-responder.c         | 27 +++++++-
 3 files changed, 90 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
index 16af37f124ee..0e38eb1cd75d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
@@ -147,6 +147,10 @@ enum iwl_tof_mcsi_enable {
  * @IWL_TOF_RESPONDER_CMD_VALID_RETRY_ON_ALGO_FAIL: retry on algorithm failure
  *	is valid
  * @IWL_TOF_RESPONDER_CMD_VALID_STA_ID: station ID is valid
+ * @IWL_TOF_RESPONDER_CMD_VALID_NDP_SUPPORT: enable/disable NDP ranging support
+ *	is valid
+ * @IWL_TOF_RESPONDER_CMD_VALID_NDP_PARAMS: NDP parameters are valid
+ * @IWL_TOF_RESPONDER_CMD_VALID_LMR_FEEDBACK: LMR feedback support is valid
  */
 enum iwl_tof_responder_cmd_valid_field {
 	IWL_TOF_RESPONDER_CMD_VALID_CHAN_INFO = BIT(0),
@@ -162,6 +166,9 @@ enum iwl_tof_responder_cmd_valid_field {
 	IWL_TOF_RESPONDER_CMD_VALID_FAST_ALGO_SUPPORT = BIT(10),
 	IWL_TOF_RESPONDER_CMD_VALID_RETRY_ON_ALGO_FAIL = BIT(11),
 	IWL_TOF_RESPONDER_CMD_VALID_STA_ID = BIT(12),
+	IWL_TOF_RESPONDER_CMD_VALID_NDP_SUPPORT = BIT(22),
+	IWL_TOF_RESPONDER_CMD_VALID_NDP_PARAMS = BIT(23),
+	IWL_TOF_RESPONDER_CMD_VALID_LMR_FEEDBACK = BIT(24),
 };
 
 /**
@@ -176,6 +183,9 @@ enum iwl_tof_responder_cmd_valid_field {
  * @IWL_TOF_RESPONDER_FLAGS_FAST_ALGO_SUPPORT: fast algorithm support
  * @IWL_TOF_RESPONDER_FLAGS_RETRY_ON_ALGO_FAIL: retry on algorithm fail
  * @IWL_TOF_RESPONDER_FLAGS_FTM_TX_ANT: TX antenna mask
+ * @IWL_TOF_RESPONDER_FLAGS_NDP_SUPPORT: support NDP ranging
+ * @IWL_TOF_RESPONDER_FLAGS_LMR_FEEDBACK: request for LMR feedback if the
+ *	initiator supports it
  */
 enum iwl_tof_responder_cfg_flags {
 	IWL_TOF_RESPONDER_FLAGS_NON_ASAP_SUPPORT = BIT(0),
@@ -188,6 +198,8 @@ enum iwl_tof_responder_cfg_flags {
 	IWL_TOF_RESPONDER_FLAGS_FAST_ALGO_SUPPORT = BIT(9),
 	IWL_TOF_RESPONDER_FLAGS_RETRY_ON_ALGO_FAIL = BIT(10),
 	IWL_TOF_RESPONDER_FLAGS_FTM_TX_ANT = RATE_MCS_ANT_ABC_MSK,
+	IWL_TOF_RESPONDER_FLAGS_NDP_SUPPORT = BIT(24),
+	IWL_TOF_RESPONDER_FLAGS_LMR_FEEDBACK = BIT(25),
 };
 
 /**
@@ -226,7 +238,7 @@ struct iwl_tof_responder_config_cmd_v6 {
 } __packed; /* TOF_RESPONDER_CONFIG_CMD_API_S_VER_6 */
 
 /**
- * struct iwl_tof_responder_config_cmd - ToF AP mode (for debug)
+ * struct iwl_tof_responder_config_cmd_v7 - ToF AP mode (for debug)
  * @cmd_valid_fields: &iwl_tof_responder_cmd_valid_field
  * @responder_cfg_flags: &iwl_tof_responder_cfg_flags
  * @format_bw: bits 0 - 3: &enum iwl_location_frame_format.
@@ -245,7 +257,7 @@ struct iwl_tof_responder_config_cmd_v6 {
  * @bssid: Current AP BSSID
  * @reserved2: reserved
  */
-struct iwl_tof_responder_config_cmd {
+struct iwl_tof_responder_config_cmd_v7 {
 	__le32 cmd_valid_fields;
 	__le32 responder_cfg_flags;
 	u8 format_bw;
@@ -259,7 +271,56 @@ struct iwl_tof_responder_config_cmd {
 	__le16 specific_calib;
 	u8 bssid[ETH_ALEN];
 	__le16 reserved2;
-} __packed; /* TOF_RESPONDER_CONFIG_CMD_API_S_VER_6 */
+} __packed; /* TOF_RESPONDER_CONFIG_CMD_API_S_VER_7 */
+
+#define IWL_RESPONDER_STS_POS	3
+#define IWL_RESPONDER_TOTAL_LTF_POS	6
+
+/**
+ * struct iwl_tof_responder_config_cmd_v8 - ToF AP mode (for debug)
+ * @cmd_valid_fields: &iwl_tof_responder_cmd_valid_field
+ * @responder_cfg_flags: &iwl_tof_responder_cfg_flags
+ * @format_bw: bits 0 - 3: &enum iwl_location_frame_format.
+ *             bits 4 - 7: &enum iwl_location_bw.
+ * @rate: current AP rate
+ * @channel_num: current AP Channel
+ * @ctrl_ch_position: coding of the control channel position relative to
+ *	the center frequency, see iwl_mvm_get_ctrl_pos()
+ * @sta_id: index of the AP STA when in AP mode
+ * @reserved1: reserved
+ * @toa_offset: Artificial addition [pSec] for the ToA - to be used for debug
+ *	purposes, simulating station movement by adding various values
+ *	to this field
+ * @common_calib: XVT: common calibration value
+ * @specific_calib: XVT: specific calibration value
+ * @bssid: Current AP BSSID
+ * @r2i_ndp_params: parameters for R2I NDP.
+ *	bits 0 - 2: max number of LTF repetitions
+ *	bits 3 - 5: max number of spatial streams (supported values are < 2)
+ *	bits 6 - 7: max number of total LTFs
+ *		    (&enum ieee80211_range_params_max_total_ltf)
+ * @i2r_ndp_params: parameters for I2R NDP.
+ *	bits 0 - 2: max number of LTF repetitions
+ *	bits 3 - 5: max number of spatial streams
+ *	bits 6 - 7: max number of total LTFs
+ *		    (&enum ieee80211_range_params_max_total_ltf)
+ */
+struct iwl_tof_responder_config_cmd_v8 {
+	__le32 cmd_valid_fields;
+	__le32 responder_cfg_flags;
+	u8 format_bw;
+	u8 rate;
+	u8 channel_num;
+	u8 ctrl_ch_position;
+	u8 sta_id;
+	u8 reserved1;
+	__le16 toa_offset;
+	__le16 common_calib;
+	__le16 specific_calib;
+	u8 bssid[ETH_ALEN];
+	u8 r2i_ndp_params;
+	u8 i2r_ndp_params;
+} __packed; /* TOF_RESPONDER_CONFIG_CMD_API_S_VER_8 */
 
 #define IWL_LCI_CIVIC_IE_MAX_SIZE	400
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index 2622debbb877..45634302801f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -100,6 +100,8 @@
 #define IWL_MVM_FTM_R2I_MAX_TOTAL_LTF		3
 #define IWL_MVM_FTM_I2R_MAX_TOTAL_LTF		3
 #define IWL_MVM_FTM_INITIATOR_SECURE_LTF	false
+#define IWL_MVM_FTM_RESP_NDP_SUPPORT		true
+#define IWL_MVM_FTM_RESP_LMR_FEEDBACK_SUPPORT	true
 #define IWL_MVM_D3_DEBUG			false
 #define IWL_MVM_USE_TWT				true
 #define IWL_MVM_AMPDU_CONSEC_DROPS_DELBA	10
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
index 996f45c19f10..5a249ea97eb2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
@@ -75,6 +75,24 @@ static int iwl_mvm_ftm_responder_set_bw_v2(struct cfg80211_chan_def *chandef,
 	return 0;
 }
 
+static void
+iwl_mvm_ftm_responder_set_ndp(struct iwl_mvm *mvm,
+			      struct iwl_tof_responder_config_cmd_v8 *cmd)
+{
+	/* Up to 2 R2I STS are allowed on the responder */
+	u32 r2i_max_sts = IWL_MVM_FTM_R2I_MAX_STS < 2 ?
+		IWL_MVM_FTM_R2I_MAX_STS : 1;
+
+	cmd->r2i_ndp_params = IWL_MVM_FTM_R2I_MAX_REP |
+		(r2i_max_sts << IWL_RESPONDER_STS_POS) |
+		(IWL_MVM_FTM_R2I_MAX_TOTAL_LTF << IWL_RESPONDER_TOTAL_LTF_POS);
+	cmd->i2r_ndp_params = IWL_MVM_FTM_I2R_MAX_REP |
+		(IWL_MVM_FTM_I2R_MAX_STS << IWL_RESPONDER_STS_POS) |
+		(IWL_MVM_FTM_I2R_MAX_TOTAL_LTF << IWL_RESPONDER_TOTAL_LTF_POS);
+	cmd->cmd_valid_fields |=
+		cpu_to_le32(IWL_TOF_RESPONDER_CMD_VALID_NDP_PARAMS);
+}
+
 static int
 iwl_mvm_ftm_responder_cmd(struct iwl_mvm *mvm,
 			  struct ieee80211_vif *vif,
@@ -82,11 +100,11 @@ iwl_mvm_ftm_responder_cmd(struct iwl_mvm *mvm,
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	/*
-	 * The command structure is the same for versions 6 and 7, (only the
+	 * The command structure is the same for versions 6, 7 and 8 (only the
 	 * field interpretation is different), so the same struct can be use
 	 * for all cases.
 	 */
-	struct iwl_tof_responder_config_cmd cmd = {
+	struct iwl_tof_responder_config_cmd_v8 cmd = {
 		.channel_num = chandef->chan->hw_value,
 		.cmd_valid_fields =
 			cpu_to_le32(IWL_TOF_RESPONDER_CMD_VALID_CHAN_INFO |
@@ -100,7 +118,10 @@ iwl_mvm_ftm_responder_cmd(struct iwl_mvm *mvm,
 
 	lockdep_assert_held(&mvm->mutex);
 
-	if (cmd_ver == 7)
+if (cmd_ver == 8)
+		iwl_mvm_ftm_responder_set_ndp(mvm, &cmd);
+
+	if (cmd_ver >= 7)
 		err = iwl_mvm_ftm_responder_set_bw_v2(chandef, &cmd.format_bw,
 						      &cmd.ctrl_ch_position);
 	else
-- 
2.31.0

