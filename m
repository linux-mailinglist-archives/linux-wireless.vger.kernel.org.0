Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572AE3F8F22
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 21:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243558AbhHZTsm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 15:48:42 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33412 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S243446AbhHZTsl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 15:48:41 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mJLLq-002XB4-Ax; Thu, 26 Aug 2021 22:47:52 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 26 Aug 2021 22:47:37 +0300
Message-Id: <iwlwifi.20210826224715.9dcd5210b7e5.I76f6977cde852de0f251344e279ad85076eef8d6@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210826194748.826360-1-luca@coelho.fi>
References: <20210826194748.826360-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH v2 01/12] iwlwifi: mvm: add support for range request command version 13
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

This version adds the following configuration options:
1. Set the BSS color for NDP ranging
2. Set the minimum and maximum time between measurements for
   non trigger based NDP ranging.
3. Terminate the session in case the responder requests LMR feedback.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/location.h  | 119 +++++++++++++++++-
 .../wireless/intel/iwlwifi/mvm/constants.h    |   5 +-
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  85 +++++++++++--
 3 files changed, 194 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
index 0e38eb1cd75d..0a8681d9687c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2020 Intel Corporation
+ * Copyright (C) 2018-2021 Intel Corporation
  */
 #ifndef __iwl_fw_api_location_h__
 #define __iwl_fw_api_location_h__
@@ -489,6 +489,10 @@ struct iwl_tof_range_req_ap_entry_v2 {
  *      instead of fw internal values.
  * @IWL_INITIATOR_AP_FLAGS_PMF: request to protect the negotiation and LMR
  *      frames with protected management frames.
+ * @IWL_INITIATOR_AP_FLAGS_TERMINATE_ON_LMR_FEEDBACK: terminate the session if
+ *	the responder asked for LMR feedback although the initiator did not set
+ *	the LMR feedback bit in the FTM request. If not set, the initiator will
+ *	continue with the session and will provide the LMR feedback.
  */
 enum iwl_initiator_ap_flags {
 	IWL_INITIATOR_AP_FLAGS_ASAP = BIT(1),
@@ -504,6 +508,7 @@ enum iwl_initiator_ap_flags {
 	IWL_INITIATOR_AP_FLAGS_LMR_FEEDBACK = BIT(12),
 	IWL_INITIATOR_AP_FLAGS_USE_CALIB = BIT(13),
 	IWL_INITIATOR_AP_FLAGS_PMF = BIT(14),
+	IWL_INITIATOR_AP_FLAGS_TERMINATE_ON_LMR_FEEDBACK = BIT(15),
 };
 
 /**
@@ -794,6 +799,90 @@ struct iwl_tof_range_req_ap_entry_v8 {
 	u8 i2r_max_total_ltf;
 } __packed; /* LOCATION_RANGE_REQ_AP_ENTRY_CMD_API_S_VER_8 */
 
+/**
+ * struct iwl_tof_range_req_ap_entry_v9 - AP configuration parameters
+ * @initiator_ap_flags: see &enum iwl_initiator_ap_flags.
+ * @channel_num: AP Channel number
+ * @format_bw: bits 0 - 3: &enum iwl_location_frame_format.
+ *             bits 4 - 7: &enum iwl_location_bw.
+ * @ctrl_ch_position: Coding of the control channel position relative to the
+ *	center frequency, see iwl_mvm_get_ctrl_pos().
+ * @ftmr_max_retries: Max number of retries to send the FTMR in case of no
+ *	reply from the AP.
+ * @bssid: AP's BSSID
+ * @burst_period: For EDCA based ranging: Recommended value to be sent to the
+ *	AP. Measurement periodicity In units of 100ms. ignored if
+ *	num_of_bursts_exp = 0.
+ *	For non trigger based NDP ranging, the maximum time between
+ *	measurements in units of milliseconds.
+ * @samples_per_burst: the number of FTMs pairs in single Burst (1-31);
+ * @num_of_bursts: Recommended value to be sent to the AP. 2s Exponent of
+ *	the number of measurement iterations (min 2^0 = 1, max 2^14)
+ * @sta_id: the station id of the AP. Only relevant when associated to the AP,
+ *	otherwise should be set to &IWL_MVM_INVALID_STA.
+ * @cipher: pairwise cipher suite for secured measurement.
+ *          &enum iwl_location_cipher.
+ * @hltk: HLTK to be used for secured 11az measurement
+ * @tk: TK to be used for secured 11az measurement
+ * @calib: An array of calibration values per FTM rx bandwidth.
+ *         If &IWL_INITIATOR_AP_FLAGS_USE_CALIB is set, the fw will use the
+ *         calibration value that corresponds to the rx bandwidth of the FTM
+ *         frame.
+ * @beacon_interval: beacon interval of the AP in TUs. Only required if
+ *	&IWL_INITIATOR_AP_FLAGS_TB is set.
+ * @bss_color: the BSS color of the responder. Only valid if
+ *	&IWL_INITIATOR_AP_FLAGS_TB or &IWL_INITIATOR_AP_FLAGS_NON_TB is set.
+ * @rx_pn: the next expected PN for protected management frames Rx. LE byte
+ *	order. Only valid if &IWL_INITIATOR_AP_FLAGS_SECURED is set and sta_id
+ *	is set to &IWL_MVM_INVALID_STA.
+ * @tx_pn: the next PN to use for protected management frames Tx. LE byte
+ *	order. Only valid if &IWL_INITIATOR_AP_FLAGS_SECURED is set and sta_id
+ *	is set to &IWL_MVM_INVALID_STA.
+ * @r2i_ndp_params: parameters for R2I NDP ranging negotiation.
+ *      bits 0 - 2: max LTF repetitions
+ *      bits 3 - 5: max number of spatial streams
+ *      bits 6 - 7: reserved
+ * @i2r_ndp_params: parameters for I2R NDP ranging negotiation.
+ *      bits 0 - 2: max LTF repetitions
+ *      bits 3 - 5: max number of spatial streams (supported values are < 2)
+ *      bits 6 - 7: reserved
+ * @r2i_max_total_ltf: R2I Max Total LTFs for NDP ranging negotiation.
+ *      One of &enum ieee80211_range_params_max_total_ltf.
+ * @i2r_max_total_ltf: I2R Max Total LTFs for NDP ranging negotiation.
+ *      One of &enum ieee80211_range_params_max_total_ltf.
+ * @bss_color: the BSS color of the responder. Only valid if
+ *	&IWL_INITIATOR_AP_FLAGS_NON_TB or &IWL_INITIATOR_AP_FLAGS_TB is set.
+ * @band: 0 for 5.2 GHz, 1 for 2.4 GHz, 2 for 6GHz
+ * @min_time_between_msr: For non trigger based NDP ranging, the minimum time
+ *	between measurements in units of milliseconds
+ */
+struct iwl_tof_range_req_ap_entry_v9 {
+	__le32 initiator_ap_flags;
+	u8 channel_num;
+	u8 format_bw;
+	u8 ctrl_ch_position;
+	u8 ftmr_max_retries;
+	u8 bssid[ETH_ALEN];
+	__le16 burst_period;
+	u8 samples_per_burst;
+	u8 num_of_bursts;
+	u8 sta_id;
+	u8 cipher;
+	u8 hltk[HLTK_11AZ_LEN];
+	u8 tk[TK_11AZ_LEN];
+	__le16 calib[IWL_TOF_BW_NUM];
+	u16 beacon_interval;
+	u8 rx_pn[IEEE80211_CCMP_PN_LEN];
+	u8 tx_pn[IEEE80211_CCMP_PN_LEN];
+	u8 r2i_ndp_params;
+	u8 i2r_ndp_params;
+	u8 r2i_max_total_ltf;
+	u8 i2r_max_total_ltf;
+	u8 bss_color;
+	u8 band;
+	__le16 min_time_between_msr;
+} __packed; /* LOCATION_RANGE_REQ_AP_ENTRY_CMD_API_S_VER_9 */
+
 /**
  * enum iwl_tof_response_mode
  * @IWL_MVM_TOF_RESPONSE_ASAP: report each AP measurement separately as soon as
@@ -1043,6 +1132,34 @@ struct iwl_tof_range_req_cmd_v12 {
 	struct iwl_tof_range_req_ap_entry_v8 ap[IWL_MVM_TOF_MAX_APS];
 } __packed; /* LOCATION_RANGE_REQ_CMD_API_S_VER_12 */
 
+/**
+ * struct iwl_tof_range_req_cmd_v13 - start measurement cmd
+ * @initiator_flags: see flags @ iwl_tof_initiator_flags
+ * @request_id: A Token incremented per request. The same Token will be
+ *		sent back in the range response
+ * @num_of_ap: Number of APs to measure (error if > IWL_MVM_TOF_MAX_APS)
+ * @range_req_bssid: ranging request BSSID
+ * @macaddr_mask: Bits set to 0 shall be copied from the MAC address template.
+ *		  Bits set to 1 shall be randomized by the UMAC
+ * @macaddr_template: MAC address template to use for non-randomized bits
+ * @req_timeout_ms: Requested timeout of the response in units of milliseconds.
+ *	This is the session time for completing the measurement.
+ * @tsf_mac_id: report the measurement start time for each ap in terms of the
+ *	TSF of this mac id. 0xff to disable TSF reporting.
+ * @ap: per-AP request data, see &struct iwl_tof_range_req_ap_entry_v9.
+ */
+struct iwl_tof_range_req_cmd_v13 {
+	__le32 initiator_flags;
+	u8 request_id;
+	u8 num_of_ap;
+	u8 range_req_bssid[ETH_ALEN];
+	u8 macaddr_mask[ETH_ALEN];
+	u8 macaddr_template[ETH_ALEN];
+	__le32 req_timeout_ms;
+	__le32 tsf_mac_id;
+	struct iwl_tof_range_req_ap_entry_v9 ap[IWL_MVM_TOF_MAX_APS];
+} __packed; /* LOCATION_RANGE_REQ_CMD_API_S_VER_13 */
+
 /*
  * enum iwl_tof_range_request_status - status of the sent request
  * @IWL_TOF_RANGE_REQUEST_STATUS_SUCCESSFUL - FW successfully received the
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index 1343f25f1090..9d0d01f27d92 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
- * Copyright (C) 2013-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2013-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2015 Intel Deutschland GmbH
  */
 #ifndef __MVM_CONSTANTS_H
@@ -93,6 +93,7 @@
 #define IWL_MVM_ENABLE_EBS			1
 #define IWL_MVM_FTM_INITIATOR_ALGO		IWL_TOF_ALGO_TYPE_MAX_LIKE
 #define IWL_MVM_FTM_INITIATOR_DYNACK		true
+#define IWL_MVM_FTM_LMR_FEEDBACK_TERMINATE	false
 #define IWL_MVM_FTM_R2I_MAX_REP			7
 #define IWL_MVM_FTM_I2R_MAX_REP			7
 #define IWL_MVM_FTM_R2I_MAX_STS			1
@@ -102,6 +103,8 @@
 #define IWL_MVM_FTM_INITIATOR_SECURE_LTF	false
 #define IWL_MVM_FTM_RESP_NDP_SUPPORT		true
 #define IWL_MVM_FTM_RESP_LMR_FEEDBACK_SUPPORT	true
+#define IWL_MVM_FTM_NON_TB_MIN_TIME_BETWEEN_MSR	5
+#define IWL_MVM_FTM_NON_TB_MAX_TIME_BETWEEN_MSR	1000
 #define IWL_MVM_D3_DEBUG			false
 #define IWL_MVM_USE_TWT				true
 #define IWL_MVM_AMPDU_CONSEC_DROPS_DELBA	10
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 59cef0d89a6d..03e5bf5cb909 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -754,6 +754,33 @@ iwl_mvm_ftm_set_ndp_params(struct iwl_mvm *mvm,
 	target->i2r_max_total_ltf = IWL_MVM_FTM_I2R_MAX_TOTAL_LTF;
 }
 
+static int
+iwl_mvm_ftm_put_target_v8(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			  struct cfg80211_pmsr_request_peer *peer,
+			  struct iwl_tof_range_req_ap_entry_v8 *target)
+{
+	u32 flags;
+	int ret = iwl_mvm_ftm_put_target_v7(mvm, vif, peer, (void *)target);
+
+	if (ret)
+		return ret;
+
+	iwl_mvm_ftm_set_ndp_params(mvm, target);
+
+	/*
+	 * If secure LTF is turned off, replace the flag with PMF only
+	 */
+	flags = le32_to_cpu(target->initiator_ap_flags);
+	if ((flags & IWL_INITIATOR_AP_FLAGS_SECURED) &&
+	    !IWL_MVM_FTM_INITIATOR_SECURE_LTF) {
+		flags &= ~IWL_INITIATOR_AP_FLAGS_SECURED;
+		flags |= IWL_INITIATOR_AP_FLAGS_PMF;
+		target->initiator_ap_flags = cpu_to_le32(flags);
+	}
+
+	return 0;
+}
+
 static int iwl_mvm_ftm_start_v12(struct iwl_mvm *mvm,
 				 struct ieee80211_vif *vif,
 				 struct cfg80211_pmsr_request *req)
@@ -773,24 +800,53 @@ static int iwl_mvm_ftm_start_v12(struct iwl_mvm *mvm,
 	for (i = 0; i < cmd.num_of_ap; i++) {
 		struct cfg80211_pmsr_request_peer *peer = &req->peers[i];
 		struct iwl_tof_range_req_ap_entry_v8 *target = &cmd.ap[i];
-		u32 flags;
 
-		err = iwl_mvm_ftm_put_target_v7(mvm, vif, peer, (void *)target);
+		err = iwl_mvm_ftm_put_target_v8(mvm, vif, peer, target);
 		if (err)
 			return err;
+	}
 
-		iwl_mvm_ftm_set_ndp_params(mvm, target);
-
-		/*
-		 * If secure LTF is turned off, replace the flag with PMF only
-		 */
-		flags = le32_to_cpu(target->initiator_ap_flags);
-		if ((flags & IWL_INITIATOR_AP_FLAGS_SECURED) &&
-		    !IWL_MVM_FTM_INITIATOR_SECURE_LTF) {
-			flags &= ~IWL_INITIATOR_AP_FLAGS_SECURED;
-			flags |= IWL_INITIATOR_AP_FLAGS_PMF;
-			target->initiator_ap_flags = cpu_to_le32(flags);
+	return iwl_mvm_ftm_send_cmd(mvm, &hcmd);
+}
+
+static int iwl_mvm_ftm_start_v13(struct iwl_mvm *mvm,
+				 struct ieee80211_vif *vif,
+				 struct cfg80211_pmsr_request *req)
+{
+	struct iwl_tof_range_req_cmd_v13 cmd;
+	struct iwl_host_cmd hcmd = {
+		.id = iwl_cmd_id(TOF_RANGE_REQ_CMD, LOCATION_GROUP, 0),
+		.dataflags[0] = IWL_HCMD_DFL_DUP,
+		.data[0] = &cmd,
+		.len[0] = sizeof(cmd),
+	};
+	u8 i;
+	int err;
+
+	iwl_mvm_ftm_cmd_common(mvm, vif, (void *)&cmd, req);
+
+	for (i = 0; i < cmd.num_of_ap; i++) {
+		struct cfg80211_pmsr_request_peer *peer = &req->peers[i];
+		struct iwl_tof_range_req_ap_entry_v9 *target = &cmd.ap[i];
+
+		err = iwl_mvm_ftm_put_target_v8(mvm, vif, peer, (void *)target);
+		if (err)
+			return err;
+
+		if (peer->ftm.trigger_based || peer->ftm.non_trigger_based)
+			target->bss_color = peer->ftm.bss_color;
+
+		if (peer->ftm.non_trigger_based) {
+			target->min_time_between_msr =
+				cpu_to_le16(IWL_MVM_FTM_NON_TB_MIN_TIME_BETWEEN_MSR);
+			target->burst_period =
+				cpu_to_le16(IWL_MVM_FTM_NON_TB_MAX_TIME_BETWEEN_MSR);
+		} else {
+			target->min_time_between_msr = cpu_to_le16(0);
 		}
+
+		target->band =
+			iwl_mvm_phy_band_from_nl80211(peer->chandef.chan->band);
 	}
 
 	return iwl_mvm_ftm_send_cmd(mvm, &hcmd);
@@ -814,6 +870,9 @@ int iwl_mvm_ftm_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 						   IWL_FW_CMD_VER_UNKNOWN);
 
 		switch (cmd_ver) {
+		case 13:
+			err = iwl_mvm_ftm_start_v13(mvm, vif, req);
+			break;
 		case 12:
 			err = iwl_mvm_ftm_start_v12(mvm, vif, req);
 			break;
-- 
2.33.0

