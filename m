Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7687A27AAA7
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 11:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgI1JXm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 05:23:42 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52806 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726566AbgI1JXm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 05:23:42 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kMpNc-002KgD-FU; Mon, 28 Sep 2020 12:23:33 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 28 Sep 2020 12:23:20 +0300
Message-Id: <iwlwifi.20200928121852.6f9ed4140e8c.I046e0d9f6dfaafda9794e5eb2ee1f02fcad2851a@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928092321.649185-1-luca@coelho.fi>
References: <20200928092321.649185-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.4
Subject: [PATCH 11/12] iwlwifi: mvm: add support for range request command ver 11
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

Version 11 of the range request command adds support for setting
the PN for secure ranging. For now, this is not yet supported.

The same functions that are used for version 9 and 10 are also
used for version 11 as the common part is the same.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/location.h  | 186 +++++++++++++++++-
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  66 +++++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   7 +
 4 files changed, 234 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
index 1df2e497fabf..cdf52b35d92c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
@@ -552,15 +552,19 @@ struct iwl_tof_range_req_ap_entry_v4 {
  * @IWL_LOCATION_CIPHER_CCMP_128: CCMP 128
  * @IWL_LOCATION_CIPHER_GCMP_128: GCMP 128
  * @IWL_LOCATION_CIPHER_GCMP_256: GCMP 256
+ * @IWL_LOCATION_CIPHER_INVALID: security is not used.
+ * @IWL_LOCATION_CIPHER_MAX: maximum value for this enum.
  */
 enum iwl_location_cipher {
 	IWL_LOCATION_CIPHER_CCMP_128,
 	IWL_LOCATION_CIPHER_GCMP_128,
 	IWL_LOCATION_CIPHER_GCMP_256,
+	IWL_LOCATION_CIPHER_INVALID,
+	IWL_LOCATION_CIPHER_MAX,
 };
 
 /**
- * struct iwl_tof_range_req_ap_entry - AP configuration parameters
+ * struct iwl_tof_range_req_ap_entry_v6 - AP configuration parameters
  * @initiator_ap_flags: see &enum iwl_initiator_ap_flags.
  * @channel_num: AP Channel number
  * @format_bw: bits 0 - 3: &enum iwl_location_frame_format.
@@ -588,7 +592,7 @@ enum iwl_location_cipher {
  * @beacon_interval: beacon interval of the AP in TUs. Only required if
  *	&IWL_INITIATOR_AP_FLAGS_TB is set.
  */
-struct iwl_tof_range_req_ap_entry {
+struct iwl_tof_range_req_ap_entry_v6 {
 	__le32 initiator_ap_flags;
 	u8 channel_num;
 	u8 format_bw;
@@ -606,6 +610,61 @@ struct iwl_tof_range_req_ap_entry {
 	__le16 beacon_interval;
 } __packed; /* LOCATION_RANGE_REQ_AP_ENTRY_CMD_API_S_VER_6 */
 
+/**
+ * struct iwl_tof_range_req_ap_entry_v7 - AP configuration parameters
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
+ */
+struct iwl_tof_range_req_ap_entry_v7 {
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
+} __packed; /* LOCATION_RANGE_REQ_AP_ENTRY_CMD_API_S_VER_7 */
+
 /**
  * enum iwl_tof_response_mode
  * @IWL_MVM_TOF_RESPONSE_ASAP: report each AP measurement separately as soon as
@@ -772,7 +831,7 @@ struct iwl_tof_range_req_cmd_v8 {
 } __packed; /* LOCATION_RANGE_REQ_CMD_API_S_VER_8 */
 
 /**
- * struct iwl_tof_range_req_cmd - start measurement cmd
+ * struct iwl_tof_range_req_cmd_v9 - start measurement cmd
  * @initiator_flags: see flags @ iwl_tof_initiator_flags
  * @request_id: A Token incremented per request. The same Token will be
  *		sent back in the range response
@@ -787,7 +846,7 @@ struct iwl_tof_range_req_cmd_v8 {
  *	TSF of this mac id. 0xff to disable TSF reporting.
  * @ap: per-AP request data, see &struct iwl_tof_range_req_ap_entry_v2.
  */
-struct iwl_tof_range_req_cmd {
+struct iwl_tof_range_req_cmd_v9 {
 	__le32 initiator_flags;
 	u8 request_id;
 	u8 num_of_ap;
@@ -796,9 +855,37 @@ struct iwl_tof_range_req_cmd {
 	u8 macaddr_template[ETH_ALEN];
 	__le32 req_timeout_ms;
 	__le32 tsf_mac_id;
-	struct iwl_tof_range_req_ap_entry ap[IWL_MVM_TOF_MAX_APS];
+	struct iwl_tof_range_req_ap_entry_v6 ap[IWL_MVM_TOF_MAX_APS];
 } __packed; /* LOCATION_RANGE_REQ_CMD_API_S_VER_9 */
 
+/**
+ * struct iwl_tof_range_req_cmd_v11 - start measurement cmd
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
+struct iwl_tof_range_req_cmd_v11 {
+	__le32 initiator_flags;
+	u8 request_id;
+	u8 num_of_ap;
+	u8 range_req_bssid[ETH_ALEN];
+	u8 macaddr_mask[ETH_ALEN];
+	u8 macaddr_template[ETH_ALEN];
+	__le32 req_timeout_ms;
+	__le32 tsf_mac_id;
+	struct iwl_tof_range_req_ap_entry_v7 ap[IWL_MVM_TOF_MAX_APS];
+} __packed; /* LOCATION_RANGE_REQ_CMD_API_S_VER_11 */
+
 /*
  * enum iwl_tof_range_request_status - status of the sent request
  * @IWL_TOF_RANGE_REQUEST_STATUS_SUCCESSFUL - FW successfully received the
@@ -960,7 +1047,7 @@ struct iwl_tof_range_rsp_ap_entry_ntfy_v4 {
 } __packed; /* LOCATION_RANGE_RSP_AP_ETRY_NTFY_API_S_VER_4 */
 
 /**
- * struct iwl_tof_range_rsp_ap_entry_ntfy - AP parameters (response)
+ * struct iwl_tof_range_rsp_ap_entry_ntfy_v5 - AP parameters (response)
  * @bssid: BSSID of the AP
  * @measure_status: current APs measurement status, one of
  *	&enum iwl_tof_entry_status.
@@ -992,7 +1079,7 @@ struct iwl_tof_range_rsp_ap_entry_ntfy_v4 {
  * @rttConfidence: a value between 0 - 31 that represents the rtt accuracy.
  * @reserved: for alignment
  */
-struct iwl_tof_range_rsp_ap_entry_ntfy {
+struct iwl_tof_range_rsp_ap_entry_ntfy_v5 {
 	u8 bssid[ETH_ALEN];
 	u8 measure_status;
 	u8 measure_bw;
@@ -1016,6 +1103,69 @@ struct iwl_tof_range_rsp_ap_entry_ntfy {
 	u8 reserved[3];
 } __packed; /* LOCATION_RANGE_RSP_AP_ETRY_NTFY_API_S_VER_5 */
 
+/**
+ * struct iwl_tof_range_rsp_ap_entry_ntfy_v6 - AP parameters (response)
+ * @bssid: BSSID of the AP
+ * @measure_status: current APs measurement status, one of
+ *	&enum iwl_tof_entry_status.
+ * @measure_bw: Current AP Bandwidth: 0  20MHz, 1  40MHz, 2  80MHz
+ * @rtt: The Round Trip Time that took for the last measurement for
+ *	current AP [pSec]
+ * @rtt_variance: The Variance of the RTT values measured for current AP
+ * @rtt_spread: The Difference between the maximum and the minimum RTT
+ *	values measured for current AP in the current session [pSec]
+ * @rssi: RSSI as uploaded in the Channel Estimation notification
+ * @rssi_spread: The Difference between the maximum and the minimum RSSI values
+ *	measured for current AP in the current session
+ * @last_burst: 1 if no more FTM sessions are scheduled for this responder
+ * @refusal_period: refusal period in case of
+ *	@IWL_TOF_ENTRY_RESPONDER_CANNOT_COLABORATE [sec]
+ * @timestamp: The GP2 Clock [usec] where Channel Estimation notification was
+ *	uploaded by the LMAC
+ * @start_tsf: measurement start time in TSF of the mac specified in the range
+ *	request
+ * @rx_rate_n_flags: rate and flags of the last FTM frame received from this
+ *	responder
+ * @tx_rate_n_flags: rate and flags of the last ack sent to this responder
+ * @t2t3_initiator: as calculated from the algo in the initiator
+ * @t1t4_responder: as calculated from the algo in the responder
+ * @common_calib: Calib val that was used in for this AP measurement
+ * @specific_calib: val that was used in for this AP measurement
+ * @papd_calib_output: The result of the tof papd calibration that was injected
+ *	into the algorithm.
+ * @rttConfidence: a value between 0 - 31 that represents the rtt accuracy.
+ * @reserved: for alignment
+ * @rx_pn: the last PN used for this responder Rx in case PMF is configured in
+ *	LE byte order.
+ * @tx_pn: the last PN used for this responder Tx in case PMF is configured in
+ *	LE byte order.
+ */
+struct iwl_tof_range_rsp_ap_entry_ntfy_v6 {
+	u8 bssid[ETH_ALEN];
+	u8 measure_status;
+	u8 measure_bw;
+	__le32 rtt;
+	__le32 rtt_variance;
+	__le32 rtt_spread;
+	s8 rssi;
+	u8 rssi_spread;
+	u8 last_burst;
+	u8 refusal_period;
+	__le32 timestamp;
+	__le32 start_tsf;
+	__le32 rx_rate_n_flags;
+	__le32 tx_rate_n_flags;
+	__le32 t2t3_initiator;
+	__le32 t1t4_responder;
+	__le16 common_calib;
+	__le16 specific_calib;
+	__le32 papd_calib_output;
+	u8 rttConfidence;
+	u8 reserved[3];
+	u8 rx_pn[IEEE80211_CCMP_PN_LEN];
+	u8 tx_pn[IEEE80211_CCMP_PN_LEN];
+} __packed; /* LOCATION_RANGE_RSP_AP_ETRY_NTFY_API_S_VER_6 */
+
 /**
  * enum iwl_tof_response_status - tof response status
  *
@@ -1066,21 +1216,37 @@ struct iwl_tof_range_rsp_ntfy_v6 {
 } __packed; /* LOCATION_RANGE_RSP_NTFY_API_S_VER_6 */
 
 /**
- * struct iwl_tof_range_rsp_ntfy - ranging response notification
+ * struct iwl_tof_range_rsp_ntfy_v7 - ranging response notification
  * @request_id: A Token ID of the corresponding Range request
  * @num_of_aps: Number of APs results
  * @last_report: 1 if no more FTM sessions are scheduled, 0 otherwise.
  * @reserved: reserved
  * @ap: per-AP data
  */
-struct iwl_tof_range_rsp_ntfy {
+struct iwl_tof_range_rsp_ntfy_v7 {
 	u8 request_id;
 	u8 num_of_aps;
 	u8 last_report;
 	u8 reserved;
-	struct iwl_tof_range_rsp_ap_entry_ntfy ap[IWL_MVM_TOF_MAX_APS];
+	struct iwl_tof_range_rsp_ap_entry_ntfy_v5 ap[IWL_MVM_TOF_MAX_APS];
 } __packed; /* LOCATION_RANGE_RSP_NTFY_API_S_VER_7 */
 
+/**
+ * struct iwl_tof_range_rsp_ntfy_v8 - ranging response notification
+ * @request_id: A Token ID of the corresponding Range request
+ * @num_of_aps: Number of APs results
+ * @last_report: 1 if no more FTM sessions are scheduled, 0 otherwise.
+ * @reserved: reserved
+ * @ap: per-AP data
+ */
+struct iwl_tof_range_rsp_ntfy_v8 {
+	u8 request_id;
+	u8 num_of_aps;
+	u8 last_report;
+	u8 reserved;
+	struct iwl_tof_range_rsp_ap_entry_ntfy_v6 ap[IWL_MVM_TOF_MAX_APS];
+} __packed; /* LOCATION_RANGE_RSP_NTFY_API_S_VER_8 */
+
 #define IWL_MVM_TOF_MCSI_BUF_SIZE  (245)
 /**
  * struct iwl_tof_mcsi_notif - used for debug
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 3792a5f51201..7efc6cb2d610 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -166,7 +166,7 @@ static void iwl_mvm_ftm_cmd_v5(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 static void iwl_mvm_ftm_cmd_common(struct iwl_mvm *mvm,
 				   struct ieee80211_vif *vif,
-				   struct iwl_tof_range_req_cmd *cmd,
+				   struct iwl_tof_range_req_cmd_v9 *cmd,
 				   struct cfg80211_pmsr_request *req)
 {
 	int i;
@@ -335,7 +335,7 @@ iwl_mvm_ftm_put_target_v2(struct iwl_mvm *mvm,
 static void
 iwl_mvm_ftm_put_target_common(struct iwl_mvm *mvm,
 			      struct cfg80211_pmsr_request_peer *peer,
-			      struct iwl_tof_range_req_ap_entry *target)
+			      struct iwl_tof_range_req_ap_entry_v6 *target)
 {
 	memcpy(target->bssid, peer->addr, ETH_ALEN);
 	target->burst_period =
@@ -411,7 +411,7 @@ iwl_mvm_ftm_put_target_v4(struct iwl_mvm *mvm,
 static int
 iwl_mvm_ftm_put_target(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		       struct cfg80211_pmsr_request_peer *peer,
-		       struct iwl_tof_range_req_ap_entry *target)
+		       struct iwl_tof_range_req_ap_entry_v6 *target)
 {
 	int ret;
 
@@ -421,7 +421,7 @@ iwl_mvm_ftm_put_target(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (ret)
 		return ret;
 
-	iwl_mvm_ftm_put_target_common(mvm, peer, (void *)target);
+	iwl_mvm_ftm_put_target_common(mvm, peer, target);
 
 	if (vif->bss_conf.assoc &&
 	    !memcmp(peer->addr, vif->bss_conf.bssid, ETH_ALEN)) {
@@ -539,7 +539,7 @@ static int iwl_mvm_ftm_start_v8(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 static int iwl_mvm_ftm_start_v9(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 				struct cfg80211_pmsr_request *req)
 {
-	struct iwl_tof_range_req_cmd cmd;
+	struct iwl_tof_range_req_cmd_v9 cmd;
 	struct iwl_host_cmd hcmd = {
 		.id = iwl_cmd_id(TOF_RANGE_REQ_CMD, LOCATION_GROUP, 0),
 		.dataflags[0] = IWL_HCMD_DFL_DUP,
@@ -553,7 +553,7 @@ static int iwl_mvm_ftm_start_v9(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	for (i = 0; i < cmd.num_of_ap; i++) {
 		struct cfg80211_pmsr_request_peer *peer = &req->peers[i];
-		struct iwl_tof_range_req_ap_entry *target = &cmd.ap[i];
+		struct iwl_tof_range_req_ap_entry_v6 *target = &cmd.ap[i];
 
 		err = iwl_mvm_ftm_put_target(mvm, vif, peer, target);
 		if (err)
@@ -563,6 +563,34 @@ static int iwl_mvm_ftm_start_v9(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	return iwl_mvm_ftm_send_cmd(mvm, &hcmd);
 }
 
+static int iwl_mvm_ftm_start_v11(struct iwl_mvm *mvm,
+				 struct ieee80211_vif *vif,
+				 struct cfg80211_pmsr_request *req)
+{
+	struct iwl_tof_range_req_cmd_v11 cmd;
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
+		struct iwl_tof_range_req_ap_entry_v7 *target = &cmd.ap[i];
+
+		err = iwl_mvm_ftm_put_target(mvm, vif, peer, (void *)target);
+		if (err)
+			return err;
+	}
+
+	return iwl_mvm_ftm_send_cmd(mvm, &hcmd);
+}
+
 int iwl_mvm_ftm_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		      struct cfg80211_pmsr_request *req)
 {
@@ -581,6 +609,9 @@ int iwl_mvm_ftm_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 						   IWL_FW_CMD_VER_UNKNOWN);
 
 		switch (cmd_ver) {
+		case 11:
+			err = iwl_mvm_ftm_start_v11(mvm, vif, req);
+			break;
 		case 9:
 		case 10:
 			err = iwl_mvm_ftm_start_v9(mvm, vif, req);
@@ -721,7 +752,8 @@ void iwl_mvm_ftm_range_resp(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	struct iwl_tof_range_rsp_ntfy_v5 *fw_resp_v5 = (void *)pkt->data;
 	struct iwl_tof_range_rsp_ntfy_v6 *fw_resp_v6 = (void *)pkt->data;
-	struct iwl_tof_range_rsp_ntfy *fw_resp = (void *)pkt->data;
+	struct iwl_tof_range_rsp_ntfy_v7 *fw_resp_v7 = (void *)pkt->data;
+	struct iwl_tof_range_rsp_ntfy_v8 *fw_resp_v8 = (void *)pkt->data;
 	int i;
 	bool new_api = fw_has_api(&mvm->fw->ucode_capa,
 				  IWL_UCODE_TLV_API_FTM_NEW_RANGE_REQ);
@@ -734,12 +766,12 @@ void iwl_mvm_ftm_range_resp(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 	}
 
 	if (new_api) {
-		if (iwl_mvm_ftm_range_resp_valid(mvm, fw_resp->request_id,
-						 fw_resp->num_of_aps))
+		if (iwl_mvm_ftm_range_resp_valid(mvm, fw_resp_v8->request_id,
+						 fw_resp_v8->num_of_aps))
 			return;
 
-		num_of_aps = fw_resp->num_of_aps;
-		last_in_batch = fw_resp->last_report;
+		num_of_aps = fw_resp_v8->num_of_aps;
+		last_in_batch = fw_resp_v8->last_report;
 	} else {
 		if (iwl_mvm_ftm_range_resp_valid(mvm, fw_resp_v5->request_id,
 						 fw_resp_v5->num_of_aps))
@@ -755,17 +787,19 @@ void iwl_mvm_ftm_range_resp(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 
 	for (i = 0; i < num_of_aps && i < IWL_MVM_TOF_MAX_APS; i++) {
 		struct cfg80211_pmsr_result result = {};
-		struct iwl_tof_range_rsp_ap_entry_ntfy *fw_ap;
+		struct iwl_tof_range_rsp_ap_entry_ntfy_v6 *fw_ap;
 		int peer_idx;
 
 		if (new_api) {
-			if (fw_has_api(&mvm->fw->ucode_capa,
-				       IWL_UCODE_TLV_API_FTM_RTT_ACCURACY))
-				fw_ap = &fw_resp->ap[i];
+			if (mvm->cmd_ver.range_resp == 8)
+				fw_ap = &fw_resp_v8->ap[i];
+			else if (fw_has_api(&mvm->fw->ucode_capa,
+					    IWL_UCODE_TLV_API_FTM_RTT_ACCURACY))
+				fw_ap = (void *)&fw_resp_v7->ap[i];
 			else
 				fw_ap = (void *)&fw_resp_v6->ap[i];
 
-			result.final = fw_resp->ap[i].last_burst;
+			result.final = fw_ap->last_burst;
 			result.ap_tsf = le32_to_cpu(fw_ap->start_tsf);
 			result.ap_tsf_valid = 1;
 		} else {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index b74978878a8d..c57d45090715 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1113,6 +1113,7 @@ struct iwl_mvm {
 
 	struct {
 		u8 d0i3_resp;
+		u8 range_resp;
 	} cmd_ver;
 
 	struct ieee80211_vif *nan_vif;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 5a6f0fe2fb90..c59ce3966807 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -725,6 +725,13 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	if (WARN_ON_ONCE(mvm->cmd_ver.d0i3_resp > 1))
 		goto out_free;
 
+	mvm->cmd_ver.range_resp =
+		iwl_fw_lookup_notif_ver(mvm->fw, LOCATION_GROUP,
+					TOF_RANGE_RESPONSE_NOTIF, 5);
+	/* we only support up to version 8 */
+	if (WARN_ON_ONCE(mvm->cmd_ver.range_resp > 8))
+		goto out_free;
+
 	/*
 	 * Populate the state variables that the transport layer needs
 	 * to know about.
-- 
2.28.0

