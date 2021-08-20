Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D8F3F2A7D
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Aug 2021 13:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237182AbhHTLED (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 07:04:03 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:57522 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239217AbhHTLED (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 07:04:03 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mH2J0-002IL4-F4; Fri, 20 Aug 2021 14:03:24 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 20 Aug 2021 14:03:08 +0300
Message-Id: <iwlwifi.20210820140104.b7e1bf6359b6.Ice4112c1910cf94babd1c2d492a3a3de9f7ee6cb@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210820110318.260751-1-luca@coelho.fi>
References: <20210820110318.260751-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 02/12] iwlwifi: mvm: add support for resonder config command version 9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

This version adds the following configuration options:
1. Enable/disable setting the session id in the FTM frame
2. Set the BSS color for the responder
3. Set the minimum and maximum time between measurements for
   non trigger based NDP ranging.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/location.h  | 70 +++++++++++++++++--
 .../intel/iwlwifi/mvm/ftm-responder.c         | 27 +++++--
 2 files changed, 88 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
index 0a8681d9687c..6bbb8b8c91cd 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
@@ -151,6 +151,10 @@ enum iwl_tof_mcsi_enable {
  *	is valid
  * @IWL_TOF_RESPONDER_CMD_VALID_NDP_PARAMS: NDP parameters are valid
  * @IWL_TOF_RESPONDER_CMD_VALID_LMR_FEEDBACK: LMR feedback support is valid
+ * @IWL_TOF_RESPONDER_CMD_VALID_SESSION_ID: session id flag is valid
+ * @IWL_TOF_RESPONDER_CMD_VALID_BSS_COLOR: the bss_color field is valid
+ * @IWL_TOF_RESPONDER_CMD_VALID_MIN_MAX_TIME_BETWEEN_MSR: the
+ *	min_time_between_msr and max_time_between_msr fields are valid
  */
 enum iwl_tof_responder_cmd_valid_field {
 	IWL_TOF_RESPONDER_CMD_VALID_CHAN_INFO = BIT(0),
@@ -169,6 +173,9 @@ enum iwl_tof_responder_cmd_valid_field {
 	IWL_TOF_RESPONDER_CMD_VALID_NDP_SUPPORT = BIT(22),
 	IWL_TOF_RESPONDER_CMD_VALID_NDP_PARAMS = BIT(23),
 	IWL_TOF_RESPONDER_CMD_VALID_LMR_FEEDBACK = BIT(24),
+	IWL_TOF_RESPONDER_CMD_VALID_SESSION_ID = BIT(25),
+	IWL_TOF_RESPONDER_CMD_VALID_BSS_COLOR = BIT(26),
+	IWL_TOF_RESPONDER_CMD_VALID_MIN_MAX_TIME_BETWEEN_MSR = BIT(27),
 };
 
 /**
@@ -186,6 +193,8 @@ enum iwl_tof_responder_cmd_valid_field {
  * @IWL_TOF_RESPONDER_FLAGS_NDP_SUPPORT: support NDP ranging
  * @IWL_TOF_RESPONDER_FLAGS_LMR_FEEDBACK: request for LMR feedback if the
  *	initiator supports it
+ * @IWL_TOF_RESPONDER_FLAGS_SESSION_ID: send the session id in the initial FTM
+ *	frame.
  */
 enum iwl_tof_responder_cfg_flags {
 	IWL_TOF_RESPONDER_FLAGS_NON_ASAP_SUPPORT = BIT(0),
@@ -200,6 +209,7 @@ enum iwl_tof_responder_cfg_flags {
 	IWL_TOF_RESPONDER_FLAGS_FTM_TX_ANT = RATE_MCS_ANT_ABC_MSK,
 	IWL_TOF_RESPONDER_FLAGS_NDP_SUPPORT = BIT(24),
 	IWL_TOF_RESPONDER_FLAGS_LMR_FEEDBACK = BIT(25),
+	IWL_TOF_RESPONDER_FLAGS_SESSION_ID = BIT(27),
 };
 
 /**
@@ -297,13 +307,13 @@ struct iwl_tof_responder_config_cmd_v7 {
  * @r2i_ndp_params: parameters for R2I NDP.
  *	bits 0 - 2: max number of LTF repetitions
  *	bits 3 - 5: max number of spatial streams (supported values are < 2)
- *	bits 6 - 7: max number of total LTFs
- *		    (&enum ieee80211_range_params_max_total_ltf)
+ *	bits 6 - 7: max number of total LTFs see
+ *	&enum ieee80211_range_params_max_total_ltf
  * @i2r_ndp_params: parameters for I2R NDP.
  *	bits 0 - 2: max number of LTF repetitions
  *	bits 3 - 5: max number of spatial streams
- *	bits 6 - 7: max number of total LTFs
- *		    (&enum ieee80211_range_params_max_total_ltf)
+ *	bits 6 - 7: max number of total LTFs see
+ *	&enum ieee80211_range_params_max_total_ltf
  */
 struct iwl_tof_responder_config_cmd_v8 {
 	__le32 cmd_valid_fields;
@@ -322,6 +332,58 @@ struct iwl_tof_responder_config_cmd_v8 {
 	u8 i2r_ndp_params;
 } __packed; /* TOF_RESPONDER_CONFIG_CMD_API_S_VER_8 */
 
+/**
+ * struct iwl_tof_responder_config_cmd_v9 - ToF AP mode (for debug)
+ * @cmd_valid_fields: &iwl_tof_responder_cmd_valid_field
+ * @responder_cfg_flags: &iwl_tof_responder_cfg_flags
+ * @format_bw: bits 0 - 3: &enum iwl_location_frame_format.
+ *             bits 4 - 7: &enum iwl_location_bw.
+ * @bss_color: current AP bss_color
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
+ *	bits 6 - 7: max number of total LTFs see
+ *	&enum ieee80211_range_params_max_total_ltf
+ * @i2r_ndp_params: parameters for I2R NDP.
+ *	bits 0 - 2: max number of LTF repetitions
+ *	bits 3 - 5: max number of spatial streams
+ *	bits 6 - 7: max number of total LTFs see
+ *	&enum ieee80211_range_params_max_total_ltf
+ * @min_time_between_msr: for non trigger based NDP ranging, minimum time
+ *	between measurements in milliseconds.
+ * @max_time_between_msr: for non trigger based NDP ranging, maximum time
+ *	between measurements in milliseconds.
+ */
+struct iwl_tof_responder_config_cmd_v9 {
+	__le32 cmd_valid_fields;
+	__le32 responder_cfg_flags;
+	u8 format_bw;
+	u8 bss_color;
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
+	__le16 min_time_between_msr;
+	__le16 max_time_between_msr;
+} __packed; /* TOF_RESPONDER_CONFIG_CMD_API_S_VER_8 */
+
 #define IWL_LCI_CIVIC_IE_MAX_SIZE	400
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
index 5a249ea97eb2..eba5433c2626 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2020 Intel Corporation
+ * Copyright (C) 2018-2021 Intel Corporation
  */
 #include <net/cfg80211.h>
 #include <linux/etherdevice.h>
@@ -77,7 +77,7 @@ static int iwl_mvm_ftm_responder_set_bw_v2(struct cfg80211_chan_def *chandef,
 
 static void
 iwl_mvm_ftm_responder_set_ndp(struct iwl_mvm *mvm,
-			      struct iwl_tof_responder_config_cmd_v8 *cmd)
+			      struct iwl_tof_responder_config_cmd_v9 *cmd)
 {
 	/* Up to 2 R2I STS are allowed on the responder */
 	u32 r2i_max_sts = IWL_MVM_FTM_R2I_MAX_STS < 2 ?
@@ -104,7 +104,7 @@ iwl_mvm_ftm_responder_cmd(struct iwl_mvm *mvm,
 	 * field interpretation is different), so the same struct can be use
 	 * for all cases.
 	 */
-	struct iwl_tof_responder_config_cmd_v8 cmd = {
+	struct iwl_tof_responder_config_cmd_v9 cmd = {
 		.channel_num = chandef->chan->hw_value,
 		.cmd_valid_fields =
 			cpu_to_le32(IWL_TOF_RESPONDER_CMD_VALID_CHAN_INFO |
@@ -115,10 +115,27 @@ iwl_mvm_ftm_responder_cmd(struct iwl_mvm *mvm,
 	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, LOCATION_GROUP,
 					   TOF_RESPONDER_CONFIG_CMD, 6);
 	int err;
+	int cmd_size;
 
 	lockdep_assert_held(&mvm->mutex);
 
-if (cmd_ver == 8)
+	/* Use a default of bss_color=1 for now */
+	if (cmd_ver == 9) {
+		cmd.cmd_valid_fields |=
+			cpu_to_le32(IWL_TOF_RESPONDER_CMD_VALID_BSS_COLOR |
+				    IWL_TOF_RESPONDER_CMD_VALID_MIN_MAX_TIME_BETWEEN_MSR);
+		cmd.bss_color = 1;
+		cmd.min_time_between_msr =
+			cpu_to_le16(IWL_MVM_FTM_NON_TB_MIN_TIME_BETWEEN_MSR);
+		cmd.max_time_between_msr =
+			cpu_to_le16(IWL_MVM_FTM_NON_TB_MAX_TIME_BETWEEN_MSR);
+		cmd_size = sizeof(struct iwl_tof_responder_config_cmd_v9);
+	} else {
+		/* All versions up to version 8 have the same size */
+		cmd_size = sizeof(struct iwl_tof_responder_config_cmd_v8);
+	}
+
+	if (cmd_ver >= 8)
 		iwl_mvm_ftm_responder_set_ndp(mvm, &cmd);
 
 	if (cmd_ver >= 7)
@@ -137,7 +154,7 @@ if (cmd_ver == 8)
 
 	return iwl_mvm_send_cmd_pdu(mvm, iwl_cmd_id(TOF_RESPONDER_CONFIG_CMD,
 						    LOCATION_GROUP, 0),
-				    0, sizeof(cmd), &cmd);
+				    0, cmd_size, &cmd);
 }
 
 static int
-- 
2.33.0

