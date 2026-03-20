Return-Path: <linux-wireless+bounces-33566-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iM+RL0MCvWkO5gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33566-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:16:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1C22D70DD
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F93D30FC9B8
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 08:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B779F37B3FE;
	Fri, 20 Mar 2026 08:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FNM8k2Ti"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075D8379ECE
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 08:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994180; cv=none; b=OVxbJkb3abXJDd5ee7FS+YK6x8FVhiEPvSnsdXGNsTK/civdOshj/wVlDkF/zDY+ItaHn2T+lO7GQueriFeDUvVbCPXU+b2ojohXS/BiuvKysEMuHRG/O1WAFc+GLE54m6J/N9kBTV/8qYU60fBjMDsCl7elXfpSXxBmP4Q7sF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994180; c=relaxed/simple;
	bh=S6F+NDyl3DJSxJ0na+IMJCXDspiVPqCqL86ooabtASA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pVxqMWPrTNkmRNzB24KGKoVYG0F42ZqE5ojkkCe8f+LRTL+PHGKp2bgvg0R9xeFiU6VyB8flKcwPGJyq5W/cIgKFurteCbCiS+/sPsaBrm1ZytXGiw/FLMeeHqfFbCOfc7ydrpCEPl452tI2lzkgV5w+xCzCn2NxKUrNsWVa8oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FNM8k2Ti; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773994179; x=1805530179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S6F+NDyl3DJSxJ0na+IMJCXDspiVPqCqL86ooabtASA=;
  b=FNM8k2TiEmTgjEgoCdh1JyEZEtQyMEjN6AvaNv+x4oS7arZPoBK552Ap
   LF7lwDm9uSOMxxP0HmoMXPeDYURHW6yJpxnwSfaJ0CUdJ4aPBrHtnKx5C
   /Zi5j6QEEXXoXObQjG4IMK9GBAnEDuXDA825EuoAZ7hdXYzwqfMX74fLk
   rY8Oe1WDYKmsEdTzMmuj4sicyz9Y6+hnjnVfzqL1TuABXgzUuXAhu0cQ2
   8G7ZxOerKfDmERz2aeKXXLydb8sjaUmjJEy8Fd/gAlgI85lWUIPPY2uuH
   hFNIYQFPmbxa4Nqh5lGBfgAURejL96xZkyyHTFk5mGpyFT+wbrtDaTjIh
   w==;
X-CSE-ConnectionGUID: +lGm1RrySuu36JF/BGSl9w==
X-CSE-MsgGUID: sI/SsnnxRhiU4ie7ftlLDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86154118"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86154118"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:09:37 -0700
X-CSE-ConnectionGUID: 7xnc1VbZQeGc6Ou3kC8iHg==
X-CSE-MsgGUID: 8NTlcS3QSHSXd4qqrC6AmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227692570"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:09:37 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: add support for additional channels in NVM_GET_INFO
Date: Fri, 20 Mar 2026 10:09:08 +0200
Message-Id: <20260320100746.f23108856bc7.I0e93cda753558aa4d9e3efcdd52cbc2eb9302c4a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320080918.2567780-1-miriam.rachel.korenblit@intel.com>
References: <20260320080918.2567780-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33566-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BD1C22D70DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We need to expect more channels on devices that support UNII-9.
Since iwl_ext_nvm_channels and iwl_uhb_nvm_channels are just a prefix
of iwl_unii9_nvm_channels just use iwl_unii9_nvm_channels and modify the
number of channels if the device does not support UNII-9 channels.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/rf-pe.c    |  1 +
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   | 37 +++++++++--
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  2 +
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 64 ++++++++++++-------
 4 files changed, 76 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c
index c02478b73057..06c615f4d3e8 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c
@@ -17,6 +17,7 @@
 	.non_shared_ant = ANT_B,					\
 	.vht_mu_mimo_supported = true,					\
 	.uhb_supported = true,						\
+	.unii9_supported = true,					\
 	.eht_supported = true,						\
 	.uhr_supported = true,						\
 	.num_rbds = IWL_NUM_RBDS_EHT,					\
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index 25c860a05b0e..0172c0747a47 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -204,7 +204,8 @@ struct iwl_nvm_get_info_phy {
 } __packed; /* REGULATORY_NVM_GET_INFO_PHY_SKU_SECTION_S_VER_1 */
 
 #define IWL_NUM_CHANNELS_V1	51
-#define IWL_NUM_CHANNELS	110
+#define IWL_NUM_CHANNELS_V2	110
+#define IWL_NUM_CHANNELS_V3	115
 
 /**
  * struct iwl_nvm_get_info_regulatory_v1 - regulatory information
@@ -219,15 +220,15 @@ struct iwl_nvm_get_info_regulatory_v1 {
 } __packed; /* REGULATORY_NVM_GET_INFO_REGULATORY_S_VER_1 */
 
 /**
- * struct iwl_nvm_get_info_regulatory - regulatory information
+ * struct iwl_nvm_get_info_regulatory_v2 - regulatory information
  * @lar_enabled: is LAR enabled
  * @n_channels: number of valid channels in the array
  * @channel_profile: regulatory data of this channel
  */
-struct iwl_nvm_get_info_regulatory {
+struct iwl_nvm_get_info_regulatory_v2 {
 	__le32 lar_enabled;
 	__le32 n_channels;
-	__le32 channel_profile[IWL_NUM_CHANNELS];
+	__le32 channel_profile[IWL_NUM_CHANNELS_V2];
 } __packed; /* REGULATORY_NVM_GET_INFO_REGULATORY_S_VER_2 */
 
 /**
@@ -244,6 +245,32 @@ struct iwl_nvm_get_info_rsp_v3 {
 	struct iwl_nvm_get_info_regulatory_v1 regulatory;
 } __packed; /* REGULATORY_NVM_GET_INFO_RSP_API_S_VER_3 */
 
+/**
+ * struct iwl_nvm_get_info_rsp_v4 - response to get NVM data
+ * @general: general NVM data
+ * @mac_sku: data relating to MAC sku
+ * @phy_sku: data relating to PHY sku
+ * @regulatory: regulatory data
+ */
+struct iwl_nvm_get_info_rsp_v4 {
+	struct iwl_nvm_get_info_general general;
+	struct iwl_nvm_get_info_sku mac_sku;
+	struct iwl_nvm_get_info_phy phy_sku;
+	struct iwl_nvm_get_info_regulatory_v2 regulatory;
+} __packed; /* REGULATORY_NVM_GET_INFO_RSP_API_S_VER_4 */
+
+/**
+ * struct iwl_nvm_get_info_regulatory - regulatory information
+ * @lar_enabled: is LAR enabled
+ * @n_channels: number of valid channels in the array
+ * @channel_profile: regulatory data of this channel
+ */
+struct iwl_nvm_get_info_regulatory {
+	__le32 lar_enabled;
+	__le32 n_channels;
+	__le32 channel_profile[IWL_NUM_CHANNELS_V3];
+} __packed; /* REGULATORY_NVM_GET_INFO_REGULATORY_S_VER_3 */
+
 /**
  * struct iwl_nvm_get_info_rsp - response to get NVM data
  * @general: general NVM data
@@ -256,7 +283,7 @@ struct iwl_nvm_get_info_rsp {
 	struct iwl_nvm_get_info_sku mac_sku;
 	struct iwl_nvm_get_info_phy phy_sku;
 	struct iwl_nvm_get_info_regulatory regulatory;
-} __packed; /* REGULATORY_NVM_GET_INFO_RSP_API_S_VER_4 */
+} __packed; /* REGULATORY_NVM_GET_INFO_RSP_API_S_VER_5 */
 
 /**
  * struct iwl_nvm_access_complete_cmd - NVM_ACCESS commands are completed
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index da6d3686e7dd..8d7ddb6e8b53 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -415,6 +415,7 @@ struct iwl_mac_cfg {
  * @vht_mu_mimo_supported: VHT MU-MIMO support
  * @nvm_type: see &enum iwl_nvm_type
  * @uhb_supported: ultra high band channels supported
+ * @unii9_supported: UNII-9 channels supported
  * @eht_supported: EHT supported
  * @uhr_supported: UHR supported
  * @num_rbds: number of receive buffer descriptors to use
@@ -450,6 +451,7 @@ struct iwl_rf_cfg {
 	    lp_xtal_workaround:1,
 	    vht_mu_mimo_supported:1,
 	    uhb_supported:1,
+	    unii9_supported:1,
 	    eht_supported:1,
 	    uhr_supported:1;
 	u8 valid_tx_ant;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index b24ac3cec412..e8f7d258b622 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -84,16 +84,7 @@ static const u16 iwl_nvm_channels[] = {
 	149, 153, 157, 161, 165
 };
 
-static const u16 iwl_ext_nvm_channels[] = {
-	/* 2.4 GHz */
-	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
-	/* 5 GHz */
-	36, 40, 44, 48, 52, 56, 60, 64, 68, 72, 76, 80, 84, 88, 92,
-	96, 100, 104, 108, 112, 116, 120, 124, 128, 132, 136, 140, 144,
-	149, 153, 157, 161, 165, 169, 173, 177, 181
-};
-
-static const u16 iwl_uhb_nvm_channels[] = {
+static const u16 iwl_unii9_nvm_channels[] = {
 	/* 2.4 GHz */
 	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
 	/* 5 GHz */
@@ -104,12 +95,16 @@ static const u16 iwl_uhb_nvm_channels[] = {
 	1, 5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61, 65, 69,
 	73, 77, 81, 85, 89, 93, 97, 101, 105, 109, 113, 117, 121, 125, 129,
 	133, 137, 141, 145, 149, 153, 157, 161, 165, 169, 173, 177, 181, 185,
-	189, 193, 197, 201, 205, 209, 213, 217, 221, 225, 229, 233
+	189, 193, 197, 201, 205, 209, 213, 217, 221, 225, 229, 233,
+
+	/* UNII-9 */
+	237, 241, 245, 249, 253
 };
 
 #define IWL_NVM_NUM_CHANNELS		ARRAY_SIZE(iwl_nvm_channels)
-#define IWL_NVM_NUM_CHANNELS_EXT	ARRAY_SIZE(iwl_ext_nvm_channels)
-#define IWL_NVM_NUM_CHANNELS_UHB	ARRAY_SIZE(iwl_uhb_nvm_channels)
+#define IWL_NVM_NUM_CHANNELS_EXT	51
+#define IWL_NVM_NUM_CHANNELS_UHB	110
+#define IWL_NVM_NUM_CHANNELS_UNII9	ARRAY_SIZE(iwl_unii9_nvm_channels)
 #define NUM_2GHZ_CHANNELS		14
 #define NUM_5GHZ_CHANNELS		37
 #define FIRST_2GHZ_HT_MINUS		5
@@ -350,12 +345,15 @@ static int iwl_init_channel_map(struct iwl_trans *trans,
 	int num_of_ch;
 	const u16 *nvm_chan;
 
-	if (cfg->uhb_supported) {
+	if (cfg->unii9_supported) {
+		num_of_ch = IWL_NVM_NUM_CHANNELS_UNII9;
+		nvm_chan = iwl_unii9_nvm_channels;
+	} else if (cfg->uhb_supported) {
 		num_of_ch = IWL_NVM_NUM_CHANNELS_UHB;
-		nvm_chan = iwl_uhb_nvm_channels;
+		nvm_chan = iwl_unii9_nvm_channels;
 	} else if (cfg->nvm_type == IWL_NVM_EXT) {
 		num_of_ch = IWL_NVM_NUM_CHANNELS_EXT;
-		nvm_chan = iwl_ext_nvm_channels;
+		nvm_chan = iwl_unii9_nvm_channels;
 	} else {
 		num_of_ch = IWL_NVM_NUM_CHANNELS;
 		nvm_chan = iwl_nvm_channels;
@@ -1401,7 +1399,9 @@ iwl_parse_mei_nvm_data(struct iwl_trans *trans, const struct iwl_rf_cfg *cfg,
 	u8 rx_chains = fw->valid_rx_ant;
 	u8 tx_chains = fw->valid_rx_ant;
 
-	if (cfg->uhb_supported)
+	if (cfg->unii9_supported)
+		data = kzalloc_flex(*data, channels, IWL_NVM_NUM_CHANNELS_UNII9);
+	else if (cfg->uhb_supported)
 		data = kzalloc_flex(*data, channels, IWL_NVM_NUM_CHANNELS_UHB);
 	else
 		data = kzalloc_flex(*data, channels, IWL_NVM_NUM_CHANNELS_EXT);
@@ -1466,7 +1466,9 @@ iwl_parse_nvm_data(struct iwl_trans *trans, const struct iwl_rf_cfg *cfg,
 	u16 lar_config;
 	const __le16 *ch_section;
 
-	if (cfg->uhb_supported)
+	if (cfg->unii9_supported)
+		data = kzalloc_flex(*data, channels, IWL_NVM_NUM_CHANNELS_UNII9);
+	else if (cfg->uhb_supported)
 		data = kzalloc_flex(*data, channels, IWL_NVM_NUM_CHANNELS_UHB);
 	else if (cfg->nvm_type != IWL_NVM_EXT)
 		data = kzalloc_flex(*data, channels, IWL_NVM_NUM_CHANNELS);
@@ -1687,12 +1689,15 @@ iwl_parse_nvm_mcc_info(struct iwl_trans *trans,
 	int max_num_ch;
 	struct iwl_reg_capa reg_capa;
 
-	if (cfg->uhb_supported) {
+	if (cfg->unii9_supported) {
+		max_num_ch = IWL_NVM_NUM_CHANNELS_UNII9;
+		nvm_chan = iwl_unii9_nvm_channels;
+	} else if (cfg->uhb_supported) {
 		max_num_ch = IWL_NVM_NUM_CHANNELS_UHB;
-		nvm_chan = iwl_uhb_nvm_channels;
+		nvm_chan = iwl_unii9_nvm_channels;
 	} else if (cfg->nvm_type == IWL_NVM_EXT) {
 		max_num_ch = IWL_NVM_NUM_CHANNELS_EXT;
-		nvm_chan = iwl_ext_nvm_channels;
+		nvm_chan = iwl_unii9_nvm_channels;
 	} else {
 		max_num_ch = IWL_NVM_NUM_CHANNELS;
 		nvm_chan = iwl_nvm_channels;
@@ -2041,13 +2046,26 @@ struct iwl_nvm_data *iwl_get_nvm(struct iwl_trans *trans,
 	struct iwl_nvm_get_info_rsp_v3 *rsp_v3;
 	bool v4 = fw_has_api(&fw->ucode_capa,
 			     IWL_UCODE_TLV_API_REGULATORY_NVM_INFO);
-	size_t rsp_size = v4 ? sizeof(*rsp) : sizeof(*rsp_v3);
+	size_t rsp_size;
 	void *channel_profile;
 
 	ret = iwl_trans_send_cmd(trans, &hcmd);
 	if (ret)
 		return ERR_PTR(ret);
 
+	switch (iwl_fw_lookup_notif_ver(fw, REGULATORY_AND_NVM_GROUP,
+					NVM_GET_INFO, 0)) {
+	case 5:
+		rsp_size = sizeof(struct iwl_nvm_get_info_rsp);
+		break;
+	case 4:
+		rsp_size = sizeof(struct iwl_nvm_get_info_rsp_v4);
+		break;
+	default:
+		rsp_size = sizeof(struct iwl_nvm_get_info_rsp_v3);
+		break;
+	}
+
 	if (WARN(iwl_rx_packet_payload_len(hcmd.resp_pkt) != rsp_size,
 		 "Invalid payload len in NVM response from FW %d",
 		 iwl_rx_packet_payload_len(hcmd.resp_pkt))) {
@@ -2061,7 +2079,7 @@ struct iwl_nvm_data *iwl_get_nvm(struct iwl_trans *trans,
 	if (empty_otp)
 		IWL_INFO(trans, "OTP is empty\n");
 
-	nvm = kzalloc_flex(*nvm, channels, IWL_NUM_CHANNELS);
+	nvm = kzalloc_flex(*nvm, channels, IWL_NUM_CHANNELS_V3);
 	if (!nvm) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.34.1


