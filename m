Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45D034E90B
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Mar 2021 15:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbhC3NZu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Mar 2021 09:25:50 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43650 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231910AbhC3NZS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Mar 2021 09:25:18 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lREMn-0007fg-8V; Tue, 30 Mar 2021 16:25:11 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 30 Mar 2021 16:24:59 +0300
Message-Id: <iwlwifi.20210330162204.2c30c376c5cf.I01460f7277594ee7c98a8e1fe5447c59e70bf073@changeid>
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
Subject: [PATCH 11/12] iwlwifi: mvm: support range request command version 12
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

Version 12 adds configuration of NDP ranging parameters:
- max number of LTF repetitions
- max number of spatial streams
- max total LTFs

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/location.h  | 106 +++++++++++++++++-
 .../wireless/intel/iwlwifi/mvm/constants.h    |   7 ++
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  76 ++++++++++++-
 3 files changed, 186 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
index ceeef8749765..16af37f124ee 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
@@ -422,10 +422,12 @@ struct iwl_tof_range_req_ap_entry_v2 {
  *	driver.
  * @IWL_INITIATOR_AP_FLAGS_NON_TB: Use non trigger based flow
  * @IWL_INITIATOR_AP_FLAGS_TB: Use trigger based flow
- * @IWL_INITIATOR_AP_FLAGS_SECURED: request secured measurement
+ * @IWL_INITIATOR_AP_FLAGS_SECURED: request secure LTF measurement
  * @IWL_INITIATOR_AP_FLAGS_LMR_FEEDBACK: Send LMR feedback
  * @IWL_INITIATOR_AP_FLAGS_USE_CALIB: Use calibration values from the request
  *      instead of fw internal values.
+ * @IWL_INITIATOR_AP_FLAGS_PMF: request to protect the negotiation and LMR
+ *      frames with protected management frames.
  */
 enum iwl_initiator_ap_flags {
 	IWL_INITIATOR_AP_FLAGS_ASAP = BIT(1),
@@ -440,6 +442,7 @@ enum iwl_initiator_ap_flags {
 	IWL_INITIATOR_AP_FLAGS_SECURED = BIT(11),
 	IWL_INITIATOR_AP_FLAGS_LMR_FEEDBACK = BIT(12),
 	IWL_INITIATOR_AP_FLAGS_USE_CALIB = BIT(13),
+	IWL_INITIATOR_AP_FLAGS_PMF = BIT(14),
 };
 
 /**
@@ -657,6 +660,79 @@ struct iwl_tof_range_req_ap_entry_v7 {
 	u8 tx_pn[IEEE80211_CCMP_PN_LEN];
 } __packed; /* LOCATION_RANGE_REQ_AP_ENTRY_CMD_API_S_VER_7 */
 
+#define IWL_LOCATION_MAX_STS_POS	3
+
+/**
+ * struct iwl_tof_range_req_ap_entry_v8 - AP configuration parameters
+ * @initiator_ap_flags: see &enum iwl_initiator_ap_flags.
+ * @channel_num: AP Channel number
+ * @format_bw: bits 0 - 3: &enum iwl_location_frame_format.
+ *             bits 4 - 7: &enum iwl_location_bw.
+ * @ctrl_ch_position: Coding of the control channel position relative to the
+ *	center frequency, see iwl_mvm_get_ctrl_pos().
+ * @ftmr_max_retries: Max number of retries to send the FTMR in case of no
+ *	reply from the AP.
+ * @bssid: AP's BSSID
+ * @burst_period: Recommended value to be sent to the AP. Measurement
+ *	periodicity In units of 100ms. ignored if num_of_bursts_exp = 0
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
+ */
+struct iwl_tof_range_req_ap_entry_v8 {
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
+	__le16 beacon_interval;
+	u8 rx_pn[IEEE80211_CCMP_PN_LEN];
+	u8 tx_pn[IEEE80211_CCMP_PN_LEN];
+	u8 r2i_ndp_params;
+	u8 i2r_ndp_params;
+	u8 r2i_max_total_ltf;
+	u8 i2r_max_total_ltf;
+} __packed; /* LOCATION_RANGE_REQ_AP_ENTRY_CMD_API_S_VER_8 */
+
 /**
  * enum iwl_tof_response_mode
  * @IWL_MVM_TOF_RESPONSE_ASAP: report each AP measurement separately as soon as
@@ -878,6 +954,34 @@ struct iwl_tof_range_req_cmd_v11 {
 	struct iwl_tof_range_req_ap_entry_v7 ap[IWL_MVM_TOF_MAX_APS];
 } __packed; /* LOCATION_RANGE_REQ_CMD_API_S_VER_11 */
 
+/**
+ * struct iwl_tof_range_req_cmd_v12 - start measurement cmd
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
+ * @ap: per-AP request data, see &struct iwl_tof_range_req_ap_entry_v2.
+ */
+struct iwl_tof_range_req_cmd_v12 {
+	__le32 initiator_flags;
+	u8 request_id;
+	u8 num_of_ap;
+	u8 range_req_bssid[ETH_ALEN];
+	u8 macaddr_mask[ETH_ALEN];
+	u8 macaddr_template[ETH_ALEN];
+	__le32 req_timeout_ms;
+	__le32 tsf_mac_id;
+	struct iwl_tof_range_req_ap_entry_v8 ap[IWL_MVM_TOF_MAX_APS];
+} __packed; /* LOCATION_RANGE_REQ_CMD_API_S_VER_12 */
+
 /*
  * enum iwl_tof_range_request_status - status of the sent request
  * @IWL_TOF_RANGE_REQUEST_STATUS_SUCCESSFUL - FW successfully received the
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index 617b41ee5801..2622debbb877 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -93,6 +93,13 @@
 #define IWL_MVM_ENABLE_EBS			1
 #define IWL_MVM_FTM_INITIATOR_ALGO		IWL_TOF_ALGO_TYPE_MAX_LIKE
 #define IWL_MVM_FTM_INITIATOR_DYNACK		true
+#define IWL_MVM_FTM_R2I_MAX_REP			7
+#define IWL_MVM_FTM_I2R_MAX_REP			7
+#define IWL_MVM_FTM_R2I_MAX_STS			1
+#define IWL_MVM_FTM_I2R_MAX_STS			1
+#define IWL_MVM_FTM_R2I_MAX_TOTAL_LTF		3
+#define IWL_MVM_FTM_I2R_MAX_TOTAL_LTF		3
+#define IWL_MVM_FTM_INITIATOR_SECURE_LTF	false
 #define IWL_MVM_D3_DEBUG			false
 #define IWL_MVM_USE_TWT				true
 #define IWL_MVM_AMPDU_CONSEC_DROPS_DELBA	10
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index a4fd0bf9ba19..24ca2934bea0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -684,6 +684,19 @@ iwl_mvm_ftm_set_secured_ranging(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	}
 }
 
+static int
+iwl_mvm_ftm_put_target_v7(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			  struct cfg80211_pmsr_request_peer *peer,
+			  struct iwl_tof_range_req_ap_entry_v7 *target)
+{
+	int err = iwl_mvm_ftm_put_target(mvm, vif, peer, (void *)target);
+	if (err)
+		return err;
+
+	iwl_mvm_ftm_set_secured_ranging(mvm, vif, target);
+	return err;
+}
+
 static int iwl_mvm_ftm_start_v11(struct iwl_mvm *mvm,
 				 struct ieee80211_vif *vif,
 				 struct cfg80211_pmsr_request *req)
@@ -704,11 +717,67 @@ static int iwl_mvm_ftm_start_v11(struct iwl_mvm *mvm,
 		struct cfg80211_pmsr_request_peer *peer = &req->peers[i];
 		struct iwl_tof_range_req_ap_entry_v7 *target = &cmd.ap[i];
 
-		err = iwl_mvm_ftm_put_target(mvm, vif, peer, (void *)target);
+		err = iwl_mvm_ftm_put_target_v7(mvm, vif, peer, target);
 		if (err)
 			return err;
+	}
 
-		iwl_mvm_ftm_set_secured_ranging(mvm, vif, target);
+	return iwl_mvm_ftm_send_cmd(mvm, &hcmd);
+}
+
+static void
+iwl_mvm_ftm_set_ndp_params(struct iwl_mvm *mvm,
+			   struct iwl_tof_range_req_ap_entry_v8 *target)
+{
+	/* Only 2 STS are supported on Tx */
+	u32 i2r_max_sts = IWL_MVM_FTM_I2R_MAX_STS > 1 ? 1 :
+		IWL_MVM_FTM_I2R_MAX_STS;
+
+	target->r2i_ndp_params = IWL_MVM_FTM_R2I_MAX_REP |
+		(IWL_MVM_FTM_R2I_MAX_STS << IWL_LOCATION_MAX_STS_POS);
+	target->i2r_ndp_params = IWL_MVM_FTM_I2R_MAX_REP |
+		(i2r_max_sts << IWL_LOCATION_MAX_STS_POS);
+	target->r2i_max_total_ltf = IWL_MVM_FTM_R2I_MAX_TOTAL_LTF;
+	target->i2r_max_total_ltf = IWL_MVM_FTM_I2R_MAX_TOTAL_LTF;
+}
+
+static int iwl_mvm_ftm_start_v12(struct iwl_mvm *mvm,
+				 struct ieee80211_vif *vif,
+				 struct cfg80211_pmsr_request *req)
+{
+	struct iwl_tof_range_req_cmd_v12 cmd;
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
+		struct iwl_tof_range_req_ap_entry_v8 *target = &cmd.ap[i];
+		u32 flags;
+
+		err = iwl_mvm_ftm_put_target_v7(mvm, vif, peer, (void *)target);
+		if (err)
+			return err;
+
+		iwl_mvm_ftm_set_ndp_params(mvm, target);
+
+		/*
+		 * If secure LTF is turned off, replace the flag with PMF only
+		 */
+		flags = le32_to_cpu(target->initiator_ap_flags);
+		if ((flags & IWL_INITIATOR_AP_FLAGS_SECURED) &&
+		    !IWL_MVM_FTM_INITIATOR_SECURE_LTF) {
+			flags &= ~IWL_INITIATOR_AP_FLAGS_SECURED;
+			flags |= IWL_INITIATOR_AP_FLAGS_PMF;
+			target->initiator_ap_flags = cpu_to_le32(flags);
+		}
 	}
 
 	return iwl_mvm_ftm_send_cmd(mvm, &hcmd);
@@ -732,6 +801,9 @@ int iwl_mvm_ftm_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 						   IWL_FW_CMD_VER_UNKNOWN);
 
 		switch (cmd_ver) {
+		case 12:
+			err = iwl_mvm_ftm_start_v12(mvm, vif, req);
+			break;
 		case 11:
 			err = iwl_mvm_ftm_start_v11(mvm, vif, req);
 			break;
-- 
2.31.0

