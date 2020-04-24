Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8FE1B7A82
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 17:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgDXPsh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 11:48:37 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:57910 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728693AbgDXPsf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 11:48:35 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jS0Z5-000OY2-PW; Fri, 24 Apr 2020 18:48:32 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 24 Apr 2020 18:48:12 +0300
Message-Id: <iwlwifi.20200424182644.5ce74a87009c.I9079332b21eef490bbdbf8d7d66e35d7d0c7882b@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424154818.2657602-1-luca@coelho.fi>
References: <20200424154818.2657602-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 06/12] iwlwifi: mvm: add support for range request command version 9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

This version adds support for per responder calibrations.
Currently the driver will use a single value for all responders
and bandwidths.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/location.h  | 110 ++++++++++++++++--
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  67 ++++++++---
 2 files changed, 155 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
index 0214e553d5ae..7ffad19d80fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
@@ -6,8 +6,7 @@
  * GPL LICENSE SUMMARY
  *
  * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 Intel Corporation
- * Copyright (C) 2019 Intel Corporation
+ * Copyright (C) 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -28,8 +27,7 @@
  * BSD LICENSE
  *
  * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 Intel Corporation
- * Copyright (C) 2019 Intel Corporation
+ * Copyright (C) 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -147,6 +145,7 @@ struct iwl_tof_config_cmd {
  * @IWL_TOF_BW_40: 40 MHz
  * @IWL_TOF_BW_80: 80 MHz
  * @IWL_TOF_BW_160: 160 MHz
+ * @IWL_TOF_BW_NUM: number of tof bandwidths
  */
 enum iwl_tof_bandwidth {
 	IWL_TOF_BW_20_LEGACY,
@@ -154,6 +153,7 @@ enum iwl_tof_bandwidth {
 	IWL_TOF_BW_40,
 	IWL_TOF_BW_80,
 	IWL_TOF_BW_160,
+	IWL_TOF_BW_NUM,
 }; /* LOCAT_BW_TYPE_E */
 
 /*
@@ -430,6 +430,9 @@ struct iwl_tof_range_req_ap_entry_v2 {
  * @IWL_INITIATOR_AP_FLAGS_NON_TB: Use non trigger based flow
  * @IWL_INITIATOR_AP_FLAGS_TB: Use trigger based flow
  * @IWL_INITIATOR_AP_FLAGS_SECURED: request secured measurement
+ * @IWL_INITIATOR_AP_FLAGS_LMR_FEEDBACK: Send LMR feedback
+ * @IWL_INITIATOR_AP_FLAGS_USE_CALIB: Use calibration values from the request
+ *      instead of fw internal values.
  */
 enum iwl_initiator_ap_flags {
 	IWL_INITIATOR_AP_FLAGS_ASAP = BIT(1),
@@ -442,6 +445,8 @@ enum iwl_initiator_ap_flags {
 	IWL_INITIATOR_AP_FLAGS_NON_TB = BIT(9),
 	IWL_INITIATOR_AP_FLAGS_TB = BIT(10),
 	IWL_INITIATOR_AP_FLAGS_SECURED = BIT(11),
+	IWL_INITIATOR_AP_FLAGS_LMR_FEEDBACK = BIT(12),
+	IWL_INITIATOR_AP_FLAGS_USE_CALIB = BIT(13),
 };
 
 /**
@@ -508,7 +513,7 @@ enum iwl_location_bw {
 #define LOCATION_BW_POS	4
 
 /**
- * struct iwl_tof_range_req_ap_entry - AP configuration parameters
+ * struct iwl_tof_range_req_ap_entry_v4 - AP configuration parameters
  * @initiator_ap_flags: see &enum iwl_initiator_ap_flags.
  * @channel_num: AP Channel number
  * @format_bw: bits 0 - 3: &enum iwl_location_frame_format.
@@ -527,7 +532,7 @@ enum iwl_location_bw {
  * @hltk: HLTK to be used for secured 11az measurement
  * @tk: TK to be used for secured 11az measurement
  */
-struct iwl_tof_range_req_ap_entry {
+struct iwl_tof_range_req_ap_entry_v4 {
 	__le32 initiator_ap_flags;
 	u8 channel_num;
 	u8 format_bw;
@@ -542,6 +547,65 @@ struct iwl_tof_range_req_ap_entry {
 	u8 tk[TK_11AZ_LEN];
 } __packed; /* LOCATION_RANGE_REQ_AP_ENTRY_CMD_API_S_VER_4 */
 
+/**
+ * enum iwl_location_cipher - location cipher selection
+ * @IWL_LOCATION_CIPHER_CCMP_128: CCMP 128
+ * @IWL_LOCATION_CIPHER_CCMP_256: CCMP 256
+ * @IWL_LOCATION_CIPHER_GCMP_128: GCMP 128
+ * @IWL_LOCATION_CIPHER_GCMP_256: GCMP 256
+ */
+enum iwl_location_cipher {
+	IWL_LOCATION_CIPHER_CCMP_128,
+	IWL_LOCATION_CIPHER_CCMP_256,
+	IWL_LOCATION_CIPHER_GCMP_128,
+	IWL_LOCATION_CIPHER_GCMP_256,
+};
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
+ * @cipher: pairwise cipher suite for secured measurement.
+ *          &enum iwl_location_cipher.
+ * @hltk: HLTK to be used for secured 11az measurement
+ * @tk: TK to be used for secured 11az measurement
+ * @calib: An array of calibration values per FTM rx bandwidth.
+ *         If &IWL_INITIATOR_AP_FLAGS_USE_CALIB is set, the fw will use the
+ *         calibration value that corresponds to the rx bandwidth of the FTM
+ *         frame.
+ * @reserved2: For alignment and future use.
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
+	u8 reserved;
+	u8 cipher;
+	u8 hltk[HLTK_11AZ_LEN];
+	u8 tk[TK_11AZ_LEN];
+	__le16 calib[IWL_TOF_BW_NUM];
+	__le16 reserved2;
+} __packed; /* LOCATION_RANGE_REQ_AP_ENTRY_CMD_API_S_VER_5 */
+
 /**
  * enum iwl_tof_response_mode
  * @IWL_MVM_TOF_RESPONSE_ASAP: report each AP measurement separately as soon as
@@ -676,7 +740,7 @@ struct iwl_tof_range_req_cmd_v7 {
 } __packed; /* LOCATION_RANGE_REQ_CMD_API_S_VER_7 */
 
 /**
- * struct iwl_tof_range_req_cmd - start measurement cmd
+ * struct iwl_tof_range_req_cmd_v8 - start measurement cmd
  * @initiator_flags: see flags @ iwl_tof_initiator_flags
  * @request_id: A Token incremented per request. The same Token will be
  *		sent back in the range response
@@ -693,7 +757,7 @@ struct iwl_tof_range_req_cmd_v7 {
  * @specific_calib: The specific calib value to inject to this measurement calc
  * @ap: per-AP request data, see &struct iwl_tof_range_req_ap_entry_v2.
  */
-struct iwl_tof_range_req_cmd {
+struct iwl_tof_range_req_cmd_v8 {
 	__le32 initiator_flags;
 	u8 request_id;
 	u8 num_of_ap;
@@ -704,9 +768,37 @@ struct iwl_tof_range_req_cmd {
 	__le32 tsf_mac_id;
 	__le16 common_calib;
 	__le16 specific_calib;
-	struct iwl_tof_range_req_ap_entry ap[IWL_MVM_TOF_MAX_APS];
+	struct iwl_tof_range_req_ap_entry_v4 ap[IWL_MVM_TOF_MAX_APS];
 } __packed; /* LOCATION_RANGE_REQ_CMD_API_S_VER_8 */
 
+/**
+ * struct iwl_tof_range_req_cmd - start measurement cmd
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
+struct iwl_tof_range_req_cmd {
+	__le32 initiator_flags;
+	u8 request_id;
+	u8 num_of_ap;
+	u8 range_req_bssid[ETH_ALEN];
+	u8 macaddr_mask[ETH_ALEN];
+	u8 macaddr_template[ETH_ALEN];
+	__le32 req_timeout_ms;
+	__le32 tsf_mac_id;
+	struct iwl_tof_range_req_ap_entry ap[IWL_MVM_TOF_MAX_APS];
+} __packed; /* LOCATION_RANGE_REQ_CMD_API_S_VER_9 */
+
 /*
  * enum iwl_tof_range_request_status - status of the sent request
  * @IWL_TOF_RANGE_REQUEST_STATUS_SUCCESSFUL - FW successfully received the
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index cdb87139100d..aaa7dd1788b1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -164,9 +164,10 @@ static void iwl_mvm_ftm_cmd_v5(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		eth_broadcast_addr(cmd->range_req_bssid);
 }
 
-static void iwl_mvm_ftm_cmd(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			    struct iwl_tof_range_req_cmd *cmd,
-			    struct cfg80211_pmsr_request *req)
+static void iwl_mvm_ftm_cmd_common(struct iwl_mvm *mvm,
+				   struct ieee80211_vif *vif,
+				   struct iwl_tof_range_req_cmd *cmd,
+				   struct cfg80211_pmsr_request *req)
 {
 	int i;
 
@@ -210,6 +211,13 @@ static void iwl_mvm_ftm_cmd(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	cmd->tsf_mac_id = cpu_to_le32(0xff);
 }
 
+static void iwl_mvm_ftm_cmd_v8(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			       struct iwl_tof_range_req_cmd_v8 *cmd,
+			       struct cfg80211_pmsr_request *req)
+{
+	iwl_mvm_ftm_cmd_common(mvm, vif, (void *)cmd, req);
+}
+
 static int
 iwl_mvm_ftm_target_chandef_v1(struct iwl_mvm *mvm,
 			      struct cfg80211_pmsr_request_peer *peer,
@@ -382,9 +390,10 @@ iwl_mvm_ftm_put_target_v3(struct iwl_mvm *mvm,
 	return 0;
 }
 
-static int iwl_mvm_ftm_put_target_v4(struct iwl_mvm *mvm,
-				     struct cfg80211_pmsr_request_peer *peer,
-				     struct iwl_tof_range_req_ap_entry *target)
+static int
+iwl_mvm_ftm_put_target(struct iwl_mvm *mvm,
+		       struct cfg80211_pmsr_request_peer *peer,
+		       struct iwl_tof_range_req_ap_entry_v4 *target)
 {
 	int ret;
 
@@ -394,7 +403,7 @@ static int iwl_mvm_ftm_put_target_v4(struct iwl_mvm *mvm,
 	if (ret)
 		return ret;
 
-	iwl_mvm_ftm_put_target_common(mvm, peer, target);
+	iwl_mvm_ftm_put_target_common(mvm, peer, (void *)target);
 
 	return 0;
 }
@@ -456,7 +465,7 @@ static int iwl_mvm_ftm_start_v7(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	 * Versions 7 and 8 has the same structure except from the responders
 	 * list, so iwl_mvm_ftm_cmd() can be used for version 7 too.
 	 */
-	iwl_mvm_ftm_cmd(mvm, vif, (void *)&cmd_v7, req);
+	iwl_mvm_ftm_cmd_v8(mvm, vif, (void *)&cmd_v7, req);
 
 	for (i = 0; i < cmd_v7.num_of_ap; i++) {
 		struct cfg80211_pmsr_request_peer *peer = &req->peers[i];
@@ -471,6 +480,32 @@ static int iwl_mvm_ftm_start_v7(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 static int iwl_mvm_ftm_start_v8(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 				struct cfg80211_pmsr_request *req)
+{
+	struct iwl_tof_range_req_cmd_v8 cmd;
+	struct iwl_host_cmd hcmd = {
+		.id = iwl_cmd_id(TOF_RANGE_REQ_CMD, LOCATION_GROUP, 0),
+		.dataflags[0] = IWL_HCMD_DFL_DUP,
+		.data[0] = &cmd,
+		.len[0] = sizeof(cmd),
+	};
+	u8 i;
+	int err;
+
+	iwl_mvm_ftm_cmd_v8(mvm, vif, (void *)&cmd, req);
+
+	for (i = 0; i < cmd.num_of_ap; i++) {
+		struct cfg80211_pmsr_request_peer *peer = &req->peers[i];
+
+		err = iwl_mvm_ftm_put_target(mvm, peer, &cmd.ap[i]);
+		if (err)
+			return err;
+	}
+
+	return iwl_mvm_ftm_send_cmd(mvm, &hcmd);
+}
+
+static int iwl_mvm_ftm_start_v9(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+				struct cfg80211_pmsr_request *req)
 {
 	struct iwl_tof_range_req_cmd cmd;
 	struct iwl_host_cmd hcmd = {
@@ -482,12 +517,12 @@ static int iwl_mvm_ftm_start_v8(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	u8 i;
 	int err;
 
-	iwl_mvm_ftm_cmd(mvm, vif, &cmd, req);
+	iwl_mvm_ftm_cmd_common(mvm, vif, &cmd, req);
 
 	for (i = 0; i < cmd.num_of_ap; i++) {
 		struct cfg80211_pmsr_request_peer *peer = &req->peers[i];
 
-		err = iwl_mvm_ftm_put_target_v4(mvm, peer, &cmd.ap[i]);
+		err = iwl_mvm_ftm_put_target(mvm, peer, (void *)&cmd.ap[i]);
 		if (err)
 			return err;
 	}
@@ -511,11 +546,17 @@ int iwl_mvm_ftm_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, LOCATION_GROUP,
 						   TOF_RANGE_REQ_CMD);
 
-		if (cmd_ver == 8)
+		switch (cmd_ver) {
+		case 9:
+			err = iwl_mvm_ftm_start_v9(mvm, vif, req);
+			break;
+		case 8:
 			err = iwl_mvm_ftm_start_v8(mvm, vif, req);
-		else
+			break;
+		default:
 			err = iwl_mvm_ftm_start_v7(mvm, vif, req);
-
+			break;
+		}
 	} else {
 		err = iwl_mvm_ftm_start_v5(mvm, vif, req);
 	}
-- 
2.26.2

