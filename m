Return-Path: <linux-wireless+bounces-26738-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 775F4B396E0
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 10:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882541C23BD4
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 08:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85412D9EC5;
	Thu, 28 Aug 2025 08:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EIxHetny"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FCB2C2368
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 08:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369619; cv=none; b=omqIhV09WFwgzN2jG8FrNTR/mEtfKTQvfuG7dMZaP13r+tlvdw3nJ9INA0jQpkhtovgnNcdXyNL3iHWkgUDTNVheSh9+mX9l0CcAR9OuJd/gYlzHRzm3bWx+M1Ok6EG6q2SxRzdCMdQ8xiBlbcPCtaHtjV3FuSmn1itYsazU+NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369619; c=relaxed/simple;
	bh=bbrrxxjtsI4BugP1lPqwDMGcyzNAqUyDwB7LxZAi7nI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W2XUuSb33sSSysrvX5pOWL0OR4I6RTyvfUdB8t2P7p9jDchJaoTqJP0L2vr+ilIo5od16kLK7rEsW/8GrbuqKRwtNQ9kX9kPR8TLPKVRmECP3EZUv1hZcg45e+6p6ACBDKa527mdM84+GzrJ9/4gXMBZdwB26MpKyVHnDKmqCw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EIxHetny; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756369618; x=1787905618;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=bbrrxxjtsI4BugP1lPqwDMGcyzNAqUyDwB7LxZAi7nI=;
  b=EIxHetnyvHHmomPZJJ4asBbRwhYFmt5KcBKsVwqaiMOlDoW5lSfkHzki
   gYEqUnndCj6UMke+AmI+QoxROP27IztruyIP6pwk+j87TUvDMydN8/E7+
   rqTbpei5tsQwH1bK0Ne4f+/8WbCbP+NZ2yRykhNljYh3NHUz3fwYT4t4Z
   8sFMNLnsMkjrKskYJtY17LIN7idxiJlH9w4g0HkQ4zwrK5cxv3GfMXv3n
   DzO1/JG77OV8cOHQ8D+BcrRIaotJ5kB2+Cbt1mVz8KJRaZXrndzDIWjBb
   AUOa0YRJify/oEVUtBO612NQbT30BcKE844mX3B8YuIqlv4AseyL5SifH
   w==;
X-CSE-ConnectionGUID: alTomhyLRG6EZEvwB8GFSA==
X-CSE-MsgGUID: sLW6zZ6NQMiLDkz9RAWFVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="70003360"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="70003360"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:44 -0700
X-CSE-ConnectionGUID: GCzzxpr7SH6aznGRWM7X7A==
X-CSE-MsgGUID: pz4ebaJWSJaisqGwAuvj7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170224511"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:44 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: mld: support TLC command version 5
Date: Thu, 28 Aug 2025 11:25:56 +0300
Message-Id: <20250828111032.032a450cc279.Iecf6570c9fe11d8fbdc0718341ac92506b02d78c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828082601.537908-1-miriam.rachel.korenblit@intel.com>
References: <20250828082601.537908-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

A new version of the TLC command was added in order to support the new
MCSs intoduced in UHR, and an indication of ELR support.

To support the new MCSs, the new version will have MCS bitmaps
(ht_rates) of 32 bit and not 16 bit, as in the old version.

Change the code to populate the new version of the command,
and if the FW requires the old version, copy the content of the new version
structure to the old version structure.

Note that this doesn't actually set the new MCSs, this will come later.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    | 35 +++++++++
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c  | 75 ++++++++++++++-----
 2 files changed, 91 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
index 3222cbcbe1ab..9c464e7aba10 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
@@ -24,6 +24,8 @@
  *					    for BPSK (MCS 0) with 2 spatial
  *					    streams
  * @IWL_TLC_MNG_CFG_FLAGS_EHT_EXTRA_LTF_MSK: enable support for EHT extra LTF
+ * @IWL_TLC_MNG_CFG_FLAGS_UHR_ELR_1_5_MBPS_MSK: support ELR 1.5 Mbps
+ * @IWL_TLC_MNG_CFG_FLAGS_UHR_ELR_3_MBPS_MSK: support ELR 3 Mbps
  */
 enum iwl_tlc_mng_cfg_flags {
 	IWL_TLC_MNG_CFG_FLAGS_STBC_MSK			= BIT(0),
@@ -32,6 +34,8 @@ enum iwl_tlc_mng_cfg_flags {
 	IWL_TLC_MNG_CFG_FLAGS_HE_DCM_NSS_1_MSK		= BIT(3),
 	IWL_TLC_MNG_CFG_FLAGS_HE_DCM_NSS_2_MSK		= BIT(4),
 	IWL_TLC_MNG_CFG_FLAGS_EHT_EXTRA_LTF_MSK		= BIT(6),
+	IWL_TLC_MNG_CFG_FLAGS_UHR_ELR_1_5_MBPS_MSK	= BIT(7),
+	IWL_TLC_MNG_CFG_FLAGS_UHR_ELR_3_MBPS_MSK	= BIT(8),
 };
 
 /**
@@ -200,6 +204,37 @@ struct iwl_tlc_config_cmd_v4 {
 	__le16 max_tx_op;
 } __packed; /* TLC_MNG_CONFIG_CMD_API_S_VER_4 */
 
+/**
+ * struct iwl_tlc_config_cmd - TLC configuration
+ * @sta_id: station id
+ * @reserved1: reserved
+ * @max_ch_width: max supported channel width from &enum iwl_tlc_mng_cfg_cw
+ * @mode: &enum iwl_tlc_mng_cfg_mode
+ * @chains: bitmask of &enum iwl_tlc_mng_cfg_chains
+ * @sgi_ch_width_supp: bitmap of SGI support per channel width
+ *		       use BIT(&enum iwl_tlc_mng_cfg_cw)
+ * @flags: bitmask of &enum iwl_tlc_mng_cfg_flags
+ * @non_ht_rates: bitmap of supported legacy rates
+ * @ht_rates: bitmap of &enum iwl_tlc_mng_ht_rates, per <nss, channel-width>
+ *	      pair (0 - 80mhz width and below, 1 - 160mhz, 2 - 320mhz).
+ * @max_mpdu_len: max MPDU length, in bytes
+ * @max_tx_op: max TXOP in uSecs for all AC (BK, BE, VO, VI),
+ *	       set zero for no limit.
+ */
+struct iwl_tlc_config_cmd {
+	u8 sta_id;
+	u8 reserved1[3];
+	u8 max_ch_width;
+	u8 mode;
+	u8 chains;
+	u8 sgi_ch_width_supp;
+	__le16 flags;
+	__le16 non_ht_rates;
+	__le32 ht_rates[IWL_TLC_NSS_MAX][IWL_TLC_MCS_PER_BW_NUM_V4];
+	__le16 max_mpdu_len;
+	__le16 max_tx_op;
+} __packed; /* TLC_MNG_CONFIG_CMD_API_S_VER_5 */
+
 /**
  * enum iwl_tlc_update_flags - updated fields
  * @IWL_TLC_NOTIF_FLAG_RATE: last initial rate update
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tlc.c b/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
index a9ca92c0455e..0e172281b0c8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
@@ -157,9 +157,9 @@ iwl_mld_get_highest_fw_mcs(const struct ieee80211_sta_vht_cap *vht_cap,
 static void
 iwl_mld_fill_vht_rates(const struct ieee80211_link_sta *link_sta,
 		       const struct ieee80211_sta_vht_cap *vht_cap,
-		       struct iwl_tlc_config_cmd_v4 *cmd)
+		       struct iwl_tlc_config_cmd *cmd)
 {
-	u16 supp;
+	u32 supp;
 	int i, highest_mcs;
 	u8 max_nss = link_sta->rx_nss;
 	struct ieee80211_vht_cap ieee_vht_cap = {
@@ -182,7 +182,7 @@ iwl_mld_fill_vht_rates(const struct ieee80211_link_sta *link_sta,
 		if (link_sta->bandwidth == IEEE80211_STA_RX_BW_20)
 			supp &= ~BIT(IWL_TLC_MNG_HT_RATE_MCS9);
 
-		cmd->ht_rates[i][IWL_TLC_MCS_PER_BW_80] = cpu_to_le16(supp);
+		cmd->ht_rates[i][IWL_TLC_MCS_PER_BW_80] = cpu_to_le32(supp);
 		/* Check if VHT extended NSS indicates that the bandwidth/NSS
 		 * configuration is supported - only for MCS 0 since we already
 		 * decoded the MCS bits anyway ourselves.
@@ -196,7 +196,7 @@ iwl_mld_fill_vht_rates(const struct ieee80211_link_sta *link_sta,
 	}
 }
 
-static u16 iwl_mld_he_mac80211_mcs_to_fw_mcs(u16 mcs)
+static u32 iwl_mld_he_mac80211_mcs_to_fw_mcs(u16 mcs)
 {
 	switch (mcs) {
 	case IEEE80211_HE_MCS_SUPPORT_0_7:
@@ -216,7 +216,7 @@ static u16 iwl_mld_he_mac80211_mcs_to_fw_mcs(u16 mcs)
 static void
 iwl_mld_fill_he_rates(const struct ieee80211_link_sta *link_sta,
 		      const struct ieee80211_sta_he_cap *own_he_cap,
-		      struct iwl_tlc_config_cmd_v4 *cmd)
+		      struct iwl_tlc_config_cmd *cmd)
 {
 	const struct ieee80211_sta_he_cap *he_cap = &link_sta->he_cap;
 	u16 mcs_160 = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_160);
@@ -245,7 +245,7 @@ iwl_mld_fill_he_rates(const struct ieee80211_link_sta *link_sta,
 		if (_mcs_80 > _tx_mcs_80)
 			_mcs_80 = _tx_mcs_80;
 		cmd->ht_rates[i][IWL_TLC_MCS_PER_BW_80] =
-			cpu_to_le16(iwl_mld_he_mac80211_mcs_to_fw_mcs(_mcs_80));
+			cpu_to_le32(iwl_mld_he_mac80211_mcs_to_fw_mcs(_mcs_80));
 
 		/* If one side doesn't support - mark both as not supporting */
 		if (_mcs_160 == IEEE80211_HE_MCS_NOT_SUPPORTED ||
@@ -256,19 +256,19 @@ iwl_mld_fill_he_rates(const struct ieee80211_link_sta *link_sta,
 		if (_mcs_160 > _tx_mcs_160)
 			_mcs_160 = _tx_mcs_160;
 		cmd->ht_rates[i][IWL_TLC_MCS_PER_BW_160] =
-			cpu_to_le16(iwl_mld_he_mac80211_mcs_to_fw_mcs(_mcs_160));
+			cpu_to_le32(iwl_mld_he_mac80211_mcs_to_fw_mcs(_mcs_160));
 	}
 }
 
-static void iwl_mld_set_eht_mcs(__le16 ht_rates[][3],
+static void iwl_mld_set_eht_mcs(__le32 ht_rates[][3],
 				enum IWL_TLC_MCS_PER_BW bw,
-				u8 max_nss, u16 mcs_msk)
+				u8 max_nss, u32 mcs_msk)
 {
 	if (max_nss >= 2)
-		ht_rates[IWL_TLC_NSS_2][bw] |= cpu_to_le16(mcs_msk);
+		ht_rates[IWL_TLC_NSS_2][bw] |= cpu_to_le32(mcs_msk);
 
 	if (max_nss >= 1)
-		ht_rates[IWL_TLC_NSS_1][bw] |= cpu_to_le16(mcs_msk);
+		ht_rates[IWL_TLC_NSS_1][bw] |= cpu_to_le32(mcs_msk);
 }
 
 static const
@@ -307,7 +307,7 @@ iwl_mld_fill_eht_rates(struct ieee80211_vif *vif,
 		       const struct ieee80211_link_sta *link_sta,
 		       const struct ieee80211_sta_he_cap *own_he_cap,
 		       const struct ieee80211_sta_eht_cap *own_eht_cap,
-		       struct iwl_tlc_config_cmd_v4 *cmd)
+		       struct iwl_tlc_config_cmd *cmd)
 {
 	/* peer RX mcs capa */
 	const struct ieee80211_eht_mcs_nss_supp *eht_rx_mcs =
@@ -405,7 +405,7 @@ iwl_mld_fill_supp_rates(struct iwl_mld *mld, struct ieee80211_vif *vif,
 			struct ieee80211_supported_band *sband,
 			const struct ieee80211_sta_he_cap *own_he_cap,
 			const struct ieee80211_sta_eht_cap *own_eht_cap,
-			struct iwl_tlc_config_cmd_v4 *cmd)
+			struct iwl_tlc_config_cmd *cmd)
 {
 	int i;
 	u16 non_ht_rates = 0;
@@ -435,7 +435,7 @@ iwl_mld_fill_supp_rates(struct iwl_mld *mld, struct ieee80211_vif *vif,
 	} else if (ht_cap->ht_supported) {
 		cmd->mode = IWL_TLC_MNG_MODE_HT;
 		cmd->ht_rates[IWL_TLC_NSS_1][IWL_TLC_MCS_PER_BW_80] =
-			cpu_to_le16(ht_cap->mcs.rx_mask[0]);
+			cpu_to_le32(ht_cap->mcs.rx_mask[0]);
 
 		/* the station support only a single receive chain */
 		if (link_sta->smps_mode == IEEE80211_SMPS_STATIC)
@@ -443,10 +443,30 @@ iwl_mld_fill_supp_rates(struct iwl_mld *mld, struct ieee80211_vif *vif,
 				0;
 		else
 			cmd->ht_rates[IWL_TLC_NSS_2][IWL_TLC_MCS_PER_BW_80] =
-				cpu_to_le16(ht_cap->mcs.rx_mask[1]);
+				cpu_to_le32(ht_cap->mcs.rx_mask[1]);
 	}
 }
 
+static void iwl_mld_convert_tlc_cmd_to_v4(struct iwl_tlc_config_cmd *cmd,
+					  struct iwl_tlc_config_cmd_v4 *cmd_v4)
+{
+	/* Copy everything until ht_rates */
+	memcpy(cmd_v4, cmd, offsetof(struct iwl_tlc_config_cmd, ht_rates));
+
+	/* Convert ht_rates from __le32 to __le16 */
+	BUILD_BUG_ON(ARRAY_SIZE(cmd_v4->ht_rates) != ARRAY_SIZE(cmd->ht_rates));
+	BUILD_BUG_ON(ARRAY_SIZE(cmd_v4->ht_rates[0]) != ARRAY_SIZE(cmd->ht_rates[0]));
+
+	for (int nss = 0; nss < ARRAY_SIZE(cmd->ht_rates); nss++)
+		for (int bw = 0; bw < ARRAY_SIZE(cmd->ht_rates[nss]); bw++)
+			cmd_v4->ht_rates[nss][bw] =
+				cpu_to_le16(le32_to_cpu(cmd->ht_rates[nss][bw]));
+
+	/* Copy the rest */
+	cmd_v4->max_mpdu_len = cmd->max_mpdu_len;
+	cmd_v4->max_tx_op = cmd->max_tx_op;
+}
+
 static void iwl_mld_send_tlc_cmd(struct iwl_mld *mld,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_link_sta *link_sta,
@@ -458,7 +478,7 @@ static void iwl_mld_send_tlc_cmd(struct iwl_mld *mld,
 		ieee80211_get_he_iftype_cap_vif(sband, vif);
 	const struct ieee80211_sta_eht_cap *own_eht_cap =
 		ieee80211_get_eht_iftype_cap_vif(sband, vif);
-	struct iwl_tlc_config_cmd_v4 cmd = {
+	struct iwl_tlc_config_cmd cmd = {
 		/* For AP mode, use 20 MHz until the STA is authorized */
 		.max_ch_width = mld_sta->sta_state > IEEE80211_STA_ASSOC ?
 			iwl_mld_fw_bw_from_sta_bw(link_sta) :
@@ -470,6 +490,11 @@ static void iwl_mld_send_tlc_cmd(struct iwl_mld *mld,
 		.max_mpdu_len = cpu_to_le16(link_sta->agg.max_amsdu_len),
 	};
 	int fw_sta_id = iwl_mld_fw_sta_id_from_link_sta(mld, link_sta);
+	u32 cmd_id = WIDE_ID(DATA_PATH_GROUP, TLC_MNG_CONFIG_CMD);
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mld->fw, cmd_id, 0);
+	struct iwl_tlc_config_cmd_v4 cmd_v4;
+	void *cmd_ptr;
+	u8 cmd_size;
 	int ret;
 
 	if (fw_sta_id < 0)
@@ -481,14 +506,26 @@ static void iwl_mld_send_tlc_cmd(struct iwl_mld *mld,
 				own_he_cap, own_eht_cap,
 				&cmd);
 
+	if (cmd_ver == 5) {
+		cmd_ptr = &cmd;
+		cmd_size = sizeof(cmd);
+	} else if (cmd_ver == 4) {
+		iwl_mld_convert_tlc_cmd_to_v4(&cmd, &cmd_v4);
+		cmd_ptr = &cmd_v4;
+		cmd_size = sizeof(cmd_v4);
+	} else {
+		IWL_ERR(mld, "Unsupported TLC config cmd version %d\n",
+			cmd_ver);
+		return;
+	}
+
 	IWL_DEBUG_RATE(mld,
 		       "TLC CONFIG CMD, sta_id=%d, max_ch_width=%d, mode=%d\n",
 		       cmd.sta_id, cmd.max_ch_width, cmd.mode);
 
 	/* Send async since this can be called within a RCU-read section */
-	ret = iwl_mld_send_cmd_with_flags_pdu(mld, WIDE_ID(DATA_PATH_GROUP,
-							   TLC_MNG_CONFIG_CMD),
-					      CMD_ASYNC, &cmd);
+	ret = iwl_mld_send_cmd_with_flags_pdu(mld, cmd_id, CMD_ASYNC, cmd_ptr,
+					      cmd_size);
 	if (ret)
 		IWL_ERR(mld, "Failed to send TLC cmd (%d)\n", ret);
 }
-- 
2.34.1


