Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAAC1127B49
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 13:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfLTMvh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 07:51:37 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:54060 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727341AbfLTMvh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 07:51:37 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1iiHkj-0007lx-MP; Fri, 20 Dec 2019 14:51:34 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 20 Dec 2019 14:51:17 +0200
Message-Id: <20191220125124.1315679-5-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220125124.1315679-1-luca@coelho.fi>
References: <20191220125124.1315679-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 04/11] iwlwifi: mvm: add support for location range request version 8
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

The new API requires the driver to set the frame format
(legacy, HT, VHT etc.) to be used for the measurement.

The new API also supports 11az and secured measurement, but
these are not supported by the driver for now.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/location.h  | 104 +++++++-
 .../intel/iwlwifi/mvm/ftm-initiator.c         | 238 ++++++++++++++----
 2 files changed, 289 insertions(+), 53 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
index 7a0fe5adefa5..a51fda4c9588 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
@@ -403,7 +403,7 @@ enum iwl_initiator_ap_flags {
 };
 
 /**
- * struct iwl_tof_range_req_ap_entry - AP configuration parameters
+ * struct iwl_tof_range_req_ap_entry_v3 - AP configuration parameters
  * @initiator_ap_flags: see &enum iwl_initiator_ap_flags.
  * @channel_num: AP Channel number
  * @bandwidth: AP bandwidth. One of iwl_tof_bandwidth.
@@ -420,7 +420,7 @@ enum iwl_initiator_ap_flags {
  * @reserved: For alignment and future use
  * @tsf_delta: not in use
  */
-struct iwl_tof_range_req_ap_entry {
+struct iwl_tof_range_req_ap_entry_v3 {
 	__le32 initiator_ap_flags;
 	u8 channel_num;
 	u8 bandwidth;
@@ -434,6 +434,72 @@ struct iwl_tof_range_req_ap_entry {
 	__le32 tsf_delta;
 } __packed; /* LOCATION_RANGE_REQ_AP_ENTRY_CMD_API_S_VER_3 */
 
+/**
+ * enum iwl_location_frame_format - location frame formats
+ * @IWL_LOCATION_FRAME_FORMAT_LEGACY: legacy
+ * @IWL_LOCATION_FRAME_FORMAT_HT: HT
+ * @IWL_LOCATION_FRAME_FORMAT_VHT: VHT
+ * @IWL_LOCATION_FRAME_FORMAT_HE: HE
+ */
+enum iwl_location_frame_format {
+	IWL_LOCATION_FRAME_FORMAT_LEGACY,
+	IWL_LOCATION_FRAME_FORMAT_HT,
+	IWL_LOCATION_FRAME_FORMAT_VHT,
+	IWL_LOCATION_FRAME_FORMAT_HE,
+};
+
+/**
+ * enum iwl_location_bw - location bandwidth selection
+ * @IWL_LOCATION_BW_20MHZ: 20MHz
+ * @IWL_LOCATION_BW_40MHZ: 40MHz
+ * @IWL_LOCATION_BW_80MHZ: 80MHz
+ */
+enum iwl_location_bw {
+	IWL_LOCATION_BW_20MHZ,
+	IWL_LOCATION_BW_40MHZ,
+	IWL_LOCATION_BW_80MHZ,
+};
+
+#define HLTK_11AZ_LEN	32
+#define TK_11AZ_LEN	32
+
+#define LOCATION_BW_POS	4
+
+/**
+ * struct iwl_tof_range_req_ap_entry - AP configuration parameters
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
+ * @reserved: For alignment and future use
+ * @hltk: HLTK to be used for secured 11az measurement
+ * @tk: TK to be used for secured 11az measurement
+ */
+struct iwl_tof_range_req_ap_entry {
+	__le32 initiator_ap_flags;
+	u8 channel_num;
+	u8 format_bw;
+	u8 ctrl_ch_position;
+	u8 ftmr_max_retries;
+	u8 bssid[ETH_ALEN];
+	__le16 burst_period;
+	u8 samples_per_burst;
+	u8 num_of_bursts;
+	__le16 reserved;
+	u8 hltk[HLTK_11AZ_LEN];
+	u8 tk[TK_11AZ_LEN];
+} __packed; /* LOCATION_RANGE_REQ_AP_ENTRY_CMD_API_S_VER_4 */
+
 /**
  * enum iwl_tof_response_mode
  * @IWL_MVM_TOF_RESPONSE_ASAP: report each AP measurement separately as soon as
@@ -535,6 +601,38 @@ struct iwl_tof_range_req_cmd_v5 {
 } __packed;
 /* LOCATION_RANGE_REQ_CMD_API_S_VER_5 */
 
+/**
+ * struct iwl_tof_range_req_cmd_v7 - start measurement cmd
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
+ * @common_calib: The common calib value to inject to this measurement calc
+ * @specific_calib: The specific calib value to inject to this measurement calc
+ * @ap: per-AP request data, see &struct iwl_tof_range_req_ap_entry_v2.
+ */
+struct iwl_tof_range_req_cmd_v7 {
+	__le32 initiator_flags;
+	u8 request_id;
+	u8 num_of_ap;
+	u8 range_req_bssid[ETH_ALEN];
+	u8 macaddr_mask[ETH_ALEN];
+	u8 macaddr_template[ETH_ALEN];
+	__le32 req_timeout_ms;
+	__le32 tsf_mac_id;
+	__le16 common_calib;
+	__le16 specific_calib;
+	struct iwl_tof_range_req_ap_entry_v3 ap[IWL_MVM_TOF_MAX_APS];
+} __packed; /* LOCATION_RANGE_REQ_CMD_API_S_VER_7 */
+
 /**
  * struct iwl_tof_range_req_cmd - start measurement cmd
  * @initiator_flags: see flags @ iwl_tof_initiator_flags
@@ -565,7 +663,7 @@ struct iwl_tof_range_req_cmd {
 	__le16 common_calib;
 	__le16 specific_calib;
 	struct iwl_tof_range_req_ap_entry ap[IWL_MVM_TOF_MAX_APS];
-} __packed; /* LOCATION_RANGE_REQ_CMD_API_S_VER_7 */
+} __packed; /* LOCATION_RANGE_REQ_CMD_API_S_VER_8 */
 
 /*
  * enum iwl_tof_range_request_status - status of the sent request
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 9f4b117db9d7..237d35ef7e76 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -208,10 +208,11 @@ static void iwl_mvm_ftm_cmd(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	cmd->tsf_mac_id = cpu_to_le32(0xff);
 }
 
-static int iwl_mvm_ftm_target_chandef(struct iwl_mvm *mvm,
-				      struct cfg80211_pmsr_request_peer *peer,
-				      u8 *channel, u8 *bandwidth,
-				      u8 *ctrl_ch_position)
+static int
+iwl_mvm_ftm_target_chandef_v1(struct iwl_mvm *mvm,
+			      struct cfg80211_pmsr_request_peer *peer,
+			      u8 *channel, u8 *bandwidth,
+			      u8 *ctrl_ch_position)
 {
 	u32 freq = peer->chandef.chan->center_freq;
 
@@ -242,6 +243,45 @@ static int iwl_mvm_ftm_target_chandef(struct iwl_mvm *mvm,
 	return 0;
 }
 
+static int
+iwl_mvm_ftm_target_chandef_v2(struct iwl_mvm *mvm,
+			      struct cfg80211_pmsr_request_peer *peer,
+			      u8 *channel, u8 *format_bw,
+			      u8 *ctrl_ch_position)
+{
+	u32 freq = peer->chandef.chan->center_freq;
+
+	*channel = ieee80211_frequency_to_channel(freq);
+
+	switch (peer->chandef.width) {
+	case NL80211_CHAN_WIDTH_20_NOHT:
+		*format_bw = IWL_LOCATION_FRAME_FORMAT_LEGACY;
+		*format_bw |= IWL_LOCATION_BW_20MHZ << LOCATION_BW_POS;
+		break;
+	case NL80211_CHAN_WIDTH_20:
+		*format_bw = IWL_LOCATION_FRAME_FORMAT_HT;
+		*format_bw |= IWL_LOCATION_BW_20MHZ << LOCATION_BW_POS;
+		break;
+	case NL80211_CHAN_WIDTH_40:
+		*format_bw = IWL_LOCATION_FRAME_FORMAT_HT;
+		*format_bw |= IWL_LOCATION_BW_40MHZ << LOCATION_BW_POS;
+		break;
+	case NL80211_CHAN_WIDTH_80:
+		*format_bw = IWL_LOCATION_FRAME_FORMAT_VHT;
+		*format_bw |= IWL_LOCATION_BW_80MHZ << LOCATION_BW_POS;
+		break;
+	default:
+		IWL_ERR(mvm, "Unsupported BW in FTM request (%d)\n",
+			peer->chandef.width);
+		return -EINVAL;
+	}
+
+	*ctrl_ch_position = (peer->chandef.width > NL80211_CHAN_WIDTH_20) ?
+		iwl_mvm_get_ctrl_pos(&peer->chandef) : 0;
+
+	return 0;
+}
+
 static int
 iwl_mvm_ftm_put_target_v2(struct iwl_mvm *mvm,
 			  struct cfg80211_pmsr_request_peer *peer,
@@ -249,9 +289,9 @@ iwl_mvm_ftm_put_target_v2(struct iwl_mvm *mvm,
 {
 	int ret;
 
-	ret = iwl_mvm_ftm_target_chandef(mvm, peer, &target->channel_num,
-					 &target->bandwidth,
-					 &target->ctrl_ch_position);
+	ret = iwl_mvm_ftm_target_chandef_v1(mvm, peer, &target->channel_num,
+					    &target->bandwidth,
+					    &target->ctrl_ch_position);
 	if (ret)
 		return ret;
 
@@ -278,18 +318,11 @@ iwl_mvm_ftm_put_target_v2(struct iwl_mvm *mvm,
 #define FTM_PUT_FLAG(flag)	(target->initiator_ap_flags |= \
 				 cpu_to_le32(IWL_INITIATOR_AP_FLAGS_##flag))
 
-static int iwl_mvm_ftm_put_target(struct iwl_mvm *mvm,
-				  struct cfg80211_pmsr_request_peer *peer,
-				  struct iwl_tof_range_req_ap_entry *target)
+static void
+iwl_mvm_ftm_put_target_common(struct iwl_mvm *mvm,
+			      struct cfg80211_pmsr_request_peer *peer,
+			      struct iwl_tof_range_req_ap_entry *target)
 {
-	int ret;
-
-	ret = iwl_mvm_ftm_target_chandef(mvm, peer, &target->channel_num,
-					 &target->bandwidth,
-					 &target->ctrl_ch_position);
-	if (ret)
-		return ret;
-
 	memcpy(target->bssid, peer->addr, ETH_ALEN);
 	target->burst_period =
 		cpu_to_le16(peer->ftm.burst_period);
@@ -315,59 +348,164 @@ static int iwl_mvm_ftm_put_target(struct iwl_mvm *mvm,
 	else if (IWL_MVM_FTM_INITIATOR_ALGO == IWL_TOF_ALGO_TYPE_FFT)
 		FTM_PUT_FLAG(ALGO_FFT);
 
+static int
+iwl_mvm_ftm_put_target_v3(struct iwl_mvm *mvm,
+			  struct cfg80211_pmsr_request_peer *peer,
+			  struct iwl_tof_range_req_ap_entry_v3 *target)
+{
+	int ret;
+
+	ret = iwl_mvm_ftm_target_chandef_v1(mvm, peer, &target->channel_num,
+					    &target->bandwidth,
+					    &target->ctrl_ch_position);
+	if (ret)
+		return ret;
+
+	/*
+	 * Versions 3 and 4 has some common fields, so
+	 * iwl_mvm_ftm_put_target_common() can be used for version 7 too.
+	 */
+	iwl_mvm_ftm_put_target_common(mvm, peer, (void *)target);
+
 	return 0;
 }
 
-int iwl_mvm_ftm_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-		      struct cfg80211_pmsr_request *req)
+static int iwl_mvm_ftm_put_target_v4(struct iwl_mvm *mvm,
+				     struct cfg80211_pmsr_request_peer *peer,
+				     struct iwl_tof_range_req_ap_entry *target)
+{
+	int ret;
+
+	ret = iwl_mvm_ftm_target_chandef_v2(mvm, peer, &target->channel_num,
+					    &target->format_bw,
+					    &target->ctrl_ch_position);
+	if (ret)
+		return ret;
+
+	iwl_mvm_ftm_put_target_common(mvm, peer, target);
+
+	return 0;
+}
+
+static int iwl_mvm_ftm_send_cmd(struct iwl_mvm *mvm, struct iwl_host_cmd *hcmd)
+{
+	u32 status;
+	int err = iwl_mvm_send_cmd_status(mvm, hcmd, &status);
+
+	if (!err && status) {
+		IWL_ERR(mvm, "FTM range request command failure, status: %u\n",
+			status);
+		err = iwl_ftm_range_request_status_to_err(status);
+	}
+
+	return err;
+}
+
+static int iwl_mvm_ftm_start_v5(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+				struct cfg80211_pmsr_request *req)
 {
 	struct iwl_tof_range_req_cmd_v5 cmd_v5;
-	struct iwl_tof_range_req_cmd cmd;
-	bool new_api = fw_has_api(&mvm->fw->ucode_capa,
-				  IWL_UCODE_TLV_API_FTM_NEW_RANGE_REQ);
-	u8 num_of_ap;
 	struct iwl_host_cmd hcmd = {
 		.id = iwl_cmd_id(TOF_RANGE_REQ_CMD, LOCATION_GROUP, 0),
 		.dataflags[0] = IWL_HCMD_DFL_DUP,
+		.data[0] = &cmd_v5,
+		.len[0] = sizeof(cmd_v5),
 	};
-	u32 status = 0;
-	int err, i;
+	u8 i;
+	int err;
 
-	lockdep_assert_held(&mvm->mutex);
+	iwl_mvm_ftm_cmd_v5(mvm, vif, &cmd_v5, req);
 
-	if (mvm->ftm_initiator.req)
-		return -EBUSY;
+	for (i = 0; i < cmd_v5.num_of_ap; i++) {
+		struct cfg80211_pmsr_request_peer *peer = &req->peers[i];
 
-	if (new_api) {
-		iwl_mvm_ftm_cmd(mvm, vif, &cmd, req);
-		hcmd.data[0] = &cmd;
-		hcmd.len[0] = sizeof(cmd);
-		num_of_ap = cmd.num_of_ap;
-	} else {
-		iwl_mvm_ftm_cmd_v5(mvm, vif, &cmd_v5, req);
-		hcmd.data[0] = &cmd_v5;
-		hcmd.len[0] = sizeof(cmd_v5);
-		num_of_ap = cmd_v5.num_of_ap;
+		err = iwl_mvm_ftm_put_target_v2(mvm, peer, &cmd_v5.ap[i]);
+		if (err)
+			return err;
 	}
 
-	for (i = 0; i < num_of_ap; i++) {
+	return iwl_mvm_ftm_send_cmd(mvm, &hcmd);
+}
+
+static int iwl_mvm_ftm_start_v7(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+				struct cfg80211_pmsr_request *req)
+{
+	struct iwl_tof_range_req_cmd_v7 cmd_v7;
+	struct iwl_host_cmd hcmd = {
+		.id = iwl_cmd_id(TOF_RANGE_REQ_CMD, LOCATION_GROUP, 0),
+		.dataflags[0] = IWL_HCMD_DFL_DUP,
+		.data[0] = &cmd_v7,
+		.len[0] = sizeof(cmd_v7),
+	};
+	u8 i;
+	int err;
+
+	/*
+	 * Versions 7 and 8 has the same structure except from the responders
+	 * list, so iwl_mvm_ftm_cmd() can be used for version 7 too.
+	 */
+	iwl_mvm_ftm_cmd(mvm, vif, (void *)&cmd_v7, req);
+
+	for (i = 0; i < cmd_v7.num_of_ap; i++) {
 		struct cfg80211_pmsr_request_peer *peer = &req->peers[i];
 
-		if (new_api)
-			err = iwl_mvm_ftm_put_target(mvm, peer, &cmd.ap[i]);
-		else
-			err = iwl_mvm_ftm_put_target_v2(mvm, peer,
-							&cmd_v5.ap[i]);
+		err = iwl_mvm_ftm_put_target_v3(mvm, peer, &cmd_v7.ap[i]);
+		if (err)
+			return err;
+	}
+
+	return iwl_mvm_ftm_send_cmd(mvm, &hcmd);
+}
 
+static int iwl_mvm_ftm_start_v8(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+				struct cfg80211_pmsr_request *req)
+{
+	struct iwl_tof_range_req_cmd cmd;
+	struct iwl_host_cmd hcmd = {
+		.id = iwl_cmd_id(TOF_RANGE_REQ_CMD, LOCATION_GROUP, 0),
+		.dataflags[0] = IWL_HCMD_DFL_DUP,
+		.data[0] = &cmd,
+		.len[0] = sizeof(cmd),
+	};
+	u8 i;
+	int err;
+
+	iwl_mvm_ftm_cmd(mvm, vif, &cmd, req);
+
+	for (i = 0; i < cmd.num_of_ap; i++) {
+		struct cfg80211_pmsr_request_peer *peer = &req->peers[i];
+
+		err = iwl_mvm_ftm_put_target_v4(mvm, peer, &cmd.ap[i]);
 		if (err)
 			return err;
 	}
 
-	err = iwl_mvm_send_cmd_status(mvm, &hcmd, &status);
-	if (!err && status) {
-		IWL_ERR(mvm, "FTM range request command failure, status: %u\n",
-			status);
-		err = iwl_ftm_range_request_status_to_err(status);
+	return iwl_mvm_ftm_send_cmd(mvm, &hcmd);
+}
+
+int iwl_mvm_ftm_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+		      struct cfg80211_pmsr_request *req)
+{
+	bool new_api = fw_has_api(&mvm->fw->ucode_capa,
+				  IWL_UCODE_TLV_API_FTM_NEW_RANGE_REQ);
+	int err;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	if (mvm->ftm_initiator.req)
+		return -EBUSY;
+
+	if (new_api) {
+		u8 cmd_ver = iwl_mvm_lookup_cmd_ver(mvm->fw, LOCATION_GROUP,
+						    TOF_RANGE_REQ_CMD);
+
+		if (cmd_ver == 8)
+			err = iwl_mvm_ftm_start_v8(mvm, vif, req);
+		else
+			err = iwl_mvm_ftm_start_v7(mvm, vif, req);
+
+	} else {
+		err = iwl_mvm_ftm_start_v5(mvm, vif, req);
 	}
 
 	if (!err) {
-- 
2.24.0

