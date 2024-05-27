Return-Path: <linux-wireless+bounces-8125-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 108E38D0838
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 18:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3787B30473
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDBE167DAF;
	Mon, 27 May 2024 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gFl395fV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC2A167296
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826002; cv=none; b=Ji/AiMHo4xXRoHrve/vPCoGrR6ZBRoZNfEBTkgSGa0k8iesIbq8LrPCWboZIPS/pwnTUK4CHlav3BjY4tls7eF43a1Nt3RRvya0AjpFCRnyMXJfQORF6O/y5L7qW4naSaM7W4BtYYhqpXbPvjiTTLy4ZDR7IpMFNv4XNwAU+e30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826002; c=relaxed/simple;
	bh=WL1DrIQoBUh6de9N0Vu8vh48wnvTvfbiLfiD/I+JmQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YQelCjZNpCVGpd5LbF2vlQCFY73WbGhfGtlA6fNFSEa+gie5qVW3vwdW41KVe7/pzWMwIn2jq8qVO+ziPxNGOogMtZldYyzjL0SP8Zsn5Dnqe5pN9MNomsaUbbkKf3jx2QK8vCjySIFf+mYh0arvXOxhP20mBMwOpNA0XgFY+qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gFl395fV; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716826001; x=1748362001;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WL1DrIQoBUh6de9N0Vu8vh48wnvTvfbiLfiD/I+JmQM=;
  b=gFl395fVLShOKkJNPjzWwSyi20HTrn2XcAA03QdnkUn41BksSs9ccR1k
   pNU3ODDMPR3i8Tes40BA+j8zQNHwLl2376uhq2Z0RJiWDDLbMi0/K1B7O
   j0nqOLLaG1UTD+jgHJiuMq/DdwyADgNayiINu0oUym/k331mEvUy+ehMb
   vLtD5EttVklDRdeQzUF9vHV64wskGgoYeNMMYmT5lVtbucj32hfITP+h0
   xVveaBQEWRRqIb71lutO9MAKdLej4AO6bZOQz6RAkRk5kRmaBdHJi8Pj8
   J0NC9nKFCL5yrAspdsOppE5nJyJZ6dfC13CVBj3KHV5ZqeKJ5LNcFxAC3
   w==;
X-CSE-ConnectionGUID: 8hiRJdgsSrGnza+J+9M5ug==
X-CSE-MsgGUID: VMXom1ozRVyQTn1z/xxI2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13002095"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="13002095"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:41 -0700
X-CSE-ConnectionGUID: RfxGdjuLSDmJ28zPLJ1xmQ==
X-CSE-MsgGUID: IluU42qjSmaDWRokWK6FrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="35407109"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:39 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH 11/20] wifi: iwlwifi: mvm: add support for version 14 of the range request command
Date: Mon, 27 May 2024 19:06:06 +0300
Message-Id: <20240527190228.8f36ccb1cc74.I9b76461634f308e75dc3cd016d0b0bce812c6e9d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
References: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

This version adds a testing option to send an incorrect SAC in the
first NDPA.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/location.h  | 105 ++++++++++++++++++
 .../wireless/intel/iwlwifi/mvm/constants.h    |   1 +
 .../intel/iwlwifi/mvm/ftm-initiator.c         | 102 +++++++++++++++++
 3 files changed, 208 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
index 25530a29317e..c20bb289a623 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2024 Intel Corporation
  */
 #ifndef __iwl_fw_api_location_h__
 #define __iwl_fw_api_location_h__
@@ -561,6 +562,8 @@ struct iwl_tof_range_req_ap_entry_v2 {
  *	the responder asked for LMR feedback although the initiator did not set
  *	the LMR feedback bit in the FTM request. If not set, the initiator will
  *	continue with the session and will provide the LMR feedback.
+ * @IWL_INITIATOR_AP_FLAGS_TEST_INCORRECT_SAC: send an incorrect SAC in the
+ *	first NDP exchange. This is used for testing.
  */
 enum iwl_initiator_ap_flags {
 	IWL_INITIATOR_AP_FLAGS_ASAP = BIT(1),
@@ -577,6 +580,7 @@ enum iwl_initiator_ap_flags {
 	IWL_INITIATOR_AP_FLAGS_USE_CALIB = BIT(13),
 	IWL_INITIATOR_AP_FLAGS_PMF = BIT(14),
 	IWL_INITIATOR_AP_FLAGS_TERMINATE_ON_LMR_FEEDBACK = BIT(15),
+	IWL_INITIATOR_AP_FLAGS_TEST_INCORRECT_SAC = BIT(16),
 };
 
 /**
@@ -797,6 +801,7 @@ struct iwl_tof_range_req_ap_entry_v7 {
 } __packed; /* LOCATION_RANGE_REQ_AP_ENTRY_CMD_API_S_VER_7 */
 
 #define IWL_LOCATION_MAX_STS_POS	3
+#define IWL_LOCATION_TOTAL_LTF_POS	6
 
 /**
  * struct iwl_tof_range_req_ap_entry_v8 - AP configuration parameters
@@ -953,6 +958,78 @@ struct iwl_tof_range_req_ap_entry_v9 {
 	__le16 min_time_between_msr;
 } __packed; /* LOCATION_RANGE_REQ_AP_ENTRY_CMD_API_S_VER_9 */
 
+/**
+ * struct iwl_tof_range_req_ap_entry_v10 - AP configuration parameters
+ * @initiator_ap_flags: see &enum iwl_initiator_ap_flags.
+ * @band: 0 for 5.2 GHz, 1 for 2.4 GHz, 2 for 6GHz
+ * @channel_num: AP Channel number
+ * @format_bw: bits 0 - 3: &enum iwl_location_frame_format.
+ *             bits 4 - 7: &enum iwl_location_bw.
+ * @ctrl_ch_position: Coding of the control channel position relative to the
+ *	center frequency, see iwl_mvm_get_ctrl_pos().
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
+ * @rx_pn: the next expected PN for protected management frames Rx. LE byte
+ *	order. Only valid if &IWL_INITIATOR_AP_FLAGS_SECURED is set and sta_id
+ *	is set to &IWL_MVM_INVALID_STA.
+ * @tx_pn: the next PN to use for protected management frames Tx. LE byte
+ *	order. Only valid if &IWL_INITIATOR_AP_FLAGS_SECURED is set and sta_id
+ *	is set to &IWL_MVM_INVALID_STA.
+ * @r2i_ndp_params: parameters for R2I NDP ranging negotiation.
+ *      bits 0 - 2: max LTF repetitions
+ *      bits 3 - 5: max number of spatial streams
+ *      bits 6 - 7: max total LTFs. One of
+ *		&enum ieee80211_range_params_max_total_ltf.
+ * @i2r_ndp_params: parameters for I2R NDP ranging negotiation.
+ *      bits 0 - 2: max LTF repetitions
+ *      bits 3 - 5: max number of spatial streams (supported values are < 2)
+ *      bits 6 - 7: max total LTFs. One of
+ *		&enum ieee80211_range_params_max_total_ltf.
+ * @min_time_between_msr: For non trigger based NDP ranging, the minimum time
+ *	between measurements in units of milliseconds
+ */
+struct iwl_tof_range_req_ap_entry_v10 {
+	__le32 initiator_ap_flags;
+	u8 band;
+	u8 channel_num;
+	u8 format_bw;
+	u8 ctrl_ch_position;
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
+	__le16 min_time_between_msr;
+} __packed; /* LOCATION_RANGE_REQ_AP_ENTRY_CMD_API_S_VER_9 */
+
 /**
  * enum iwl_tof_response_mode
  * @IWL_MVM_TOF_RESPONSE_ASAP: report each AP measurement separately as soon as
@@ -1230,6 +1307,34 @@ struct iwl_tof_range_req_cmd_v13 {
 	struct iwl_tof_range_req_ap_entry_v9 ap[IWL_MVM_TOF_MAX_APS];
 } __packed; /* LOCATION_RANGE_REQ_CMD_API_S_VER_13 */
 
+/**
+ * struct iwl_tof_range_req_cmd_v14 - start measurement cmd
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
+ * @ap: per-AP request data, see &struct iwl_tof_range_req_ap_entry_v10.
+ */
+struct iwl_tof_range_req_cmd_v14 {
+	__le32 initiator_flags;
+	u8 request_id;
+	u8 num_of_ap;
+	u8 range_req_bssid[ETH_ALEN];
+	u8 macaddr_mask[ETH_ALEN];
+	u8 macaddr_template[ETH_ALEN];
+	__le32 req_timeout_ms;
+	__le32 tsf_mac_id;
+	struct iwl_tof_range_req_ap_entry_v10 ap[IWL_MVM_TOF_MAX_APS];
+} __packed; /* LOCATION_RANGE_REQ_CMD_API_S_VER_13 */
+
 /*
  * enum iwl_tof_range_request_status - status of the sent request
  * @IWL_TOF_RANGE_REQUEST_STATUS_SUCCESSFUL - FW successfully received the
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index d840653cc907..1abe9e9fd46b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -100,6 +100,7 @@
 #define IWL_MVM_FTM_INITIATOR_ALGO		IWL_TOF_ALGO_TYPE_MAX_LIKE
 #define IWL_MVM_FTM_INITIATOR_DYNACK		true
 #define IWL_MVM_FTM_LMR_FEEDBACK_TERMINATE	false
+#define IWL_MVM_FTM_TEST_INCORRECT_SAC	        false
 #define IWL_MVM_FTM_R2I_MAX_REP			7
 #define IWL_MVM_FTM_I2R_MAX_REP			7
 #define IWL_MVM_FTM_R2I_MAX_STS			1
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index f5bf99f7fc2e..00d447e40cc6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -950,6 +950,105 @@ static int iwl_mvm_ftm_start_v13(struct iwl_mvm *mvm,
 	return iwl_mvm_ftm_send_cmd(mvm, &hcmd);
 }
 
+static int
+iwl_mvm_ftm_put_target_v10(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			   struct cfg80211_pmsr_request_peer *peer,
+			   struct iwl_tof_range_req_ap_entry_v10 *target)
+{
+	u32 i2r_max_sts, flags;
+	int ret;
+
+	ret = iwl_mvm_ftm_target_chandef_v2(mvm, peer, &target->channel_num,
+					    &target->format_bw,
+					    &target->ctrl_ch_position);
+	if (ret)
+		return ret;
+
+	memcpy(target->bssid, peer->addr, ETH_ALEN);
+	target->burst_period =
+		cpu_to_le16(peer->ftm.burst_period);
+	target->samples_per_burst = peer->ftm.ftms_per_burst;
+	target->num_of_bursts = peer->ftm.num_bursts_exp;
+	iwl_mvm_ftm_set_target_flags(mvm, peer, &target->initiator_ap_flags);
+	iwl_mvm_ftm_set_sta(mvm, vif, peer, &target->sta_id,
+			    &target->initiator_ap_flags);
+	iwl_mvm_ftm_set_secured_ranging(mvm, vif, target->bssid,
+					&target->cipher, target->hltk,
+					target->tk, target->rx_pn,
+					target->tx_pn,
+					&target->initiator_ap_flags);
+
+	i2r_max_sts = IWL_MVM_FTM_I2R_MAX_STS > 1 ? 1 :
+		IWL_MVM_FTM_I2R_MAX_STS;
+
+	target->r2i_ndp_params = IWL_MVM_FTM_R2I_MAX_REP |
+		(IWL_MVM_FTM_R2I_MAX_STS << IWL_LOCATION_MAX_STS_POS) |
+		(IWL_MVM_FTM_R2I_MAX_TOTAL_LTF << IWL_LOCATION_TOTAL_LTF_POS);
+	target->i2r_ndp_params = IWL_MVM_FTM_I2R_MAX_REP |
+		(i2r_max_sts << IWL_LOCATION_MAX_STS_POS) |
+		(IWL_MVM_FTM_I2R_MAX_TOTAL_LTF << IWL_LOCATION_TOTAL_LTF_POS);
+
+	if (peer->ftm.non_trigger_based) {
+		target->min_time_between_msr =
+			cpu_to_le16(IWL_MVM_FTM_NON_TB_MIN_TIME_BETWEEN_MSR);
+		target->burst_period =
+			cpu_to_le16(IWL_MVM_FTM_NON_TB_MAX_TIME_BETWEEN_MSR);
+	} else {
+		target->min_time_between_msr = cpu_to_le16(0);
+	}
+
+	target->band =
+		iwl_mvm_phy_band_from_nl80211(peer->chandef.chan->band);
+
+	/*
+	 * TODO: Beacon interval is currently unknown, so use the common value
+	 * of 100 TUs.
+	 */
+	target->beacon_interval = cpu_to_le16(100);
+
+	/*
+	 * If secure LTF is turned off, replace the flag with PMF only
+	 */
+	flags = le32_to_cpu(target->initiator_ap_flags);
+	if (flags & IWL_INITIATOR_AP_FLAGS_SECURED) {
+		if (!IWL_MVM_FTM_INITIATOR_SECURE_LTF)
+			flags &= ~IWL_INITIATOR_AP_FLAGS_SECURED;
+
+		flags |= IWL_INITIATOR_AP_FLAGS_PMF;
+		target->initiator_ap_flags = cpu_to_le32(flags);
+	}
+
+	return 0;
+}
+
+static int iwl_mvm_ftm_start_v14(struct iwl_mvm *mvm,
+				 struct ieee80211_vif *vif,
+				 struct cfg80211_pmsr_request *req)
+{
+	struct iwl_tof_range_req_cmd_v14 cmd;
+	struct iwl_host_cmd hcmd = {
+		.id = WIDE_ID(LOCATION_GROUP, TOF_RANGE_REQ_CMD),
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
+		struct iwl_tof_range_req_ap_entry_v10 *target = &cmd.ap[i];
+
+		err = iwl_mvm_ftm_put_target_v10(mvm, vif, peer, target);
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
@@ -968,6 +1067,9 @@ int iwl_mvm_ftm_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 						   IWL_FW_CMD_VER_UNKNOWN);
 
 		switch (cmd_ver) {
+		case 14:
+			err = iwl_mvm_ftm_start_v14(mvm, vif, req);
+			break;
 		case 13:
 			err = iwl_mvm_ftm_start_v13(mvm, vif, req);
 			break;
-- 
2.34.1


