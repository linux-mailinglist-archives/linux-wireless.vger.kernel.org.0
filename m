Return-Path: <linux-wireless+bounces-25195-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBACEB0095A
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 18:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22BD3AAB5E
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 16:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9D02F004D;
	Thu, 10 Jul 2025 16:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5OBDaG6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8402F005B
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166523; cv=none; b=XzOt2GvcJlx1e48g37I25RvjtQQRyKOmukFMGYlKPR1zktdaJ9o2g/e2S5IKSGOsJUjeHdT0r/UmV0oQl2zZgwgNpLL5+feKN0YMCS/Nbm/wUH8XRhIhIez+jeQlwG5VDj+ZavulrmGhPbhCyTi5AbP8GfTTkT7agbMtpyy34Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166523; c=relaxed/simple;
	bh=hyntf3PudfD806anOq87YH9+IxaMm7kp2vdtC2gUmfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F5vpb0wgR71T9Sw9scfgoIDegDjtl4XWl8qiu5synoVgVnms3IwEqXYfRel6QWymItwB3ASxSaaMBgg5eSlwZBlrI45VwLEPcxGXlTPEjYRTsmI9MO+EbRyWskGLeAC3Qr40I4gQZsE80k/02IKMl+XDng39EshllrmqwFlBUHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F5OBDaG6; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752166521; x=1783702521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hyntf3PudfD806anOq87YH9+IxaMm7kp2vdtC2gUmfU=;
  b=F5OBDaG6DGVcHANNRxJOMN6UZbMBnaDChQzvrbyk3bIXJkV+pHm1SWwH
   NdgDLURq+5HWY1gBs0zi0Oq4PlkCuWUhlwl1tBXma40y24WZH3DGB2oX+
   vO6YUf5jvfD3/xpJrCzAlyoR6rohS2vuF7QpXnubUQZ0lLFdNtcCiXPvE
   p9AzLSeHOI9P+ajXDZsmyuZPyKBQuY2iuO9RcVN2e07S9KJUnCXZad4Im
   GJ4tblzXVxmYefjmpFi4apMsQYbmZHOdD/3oL1Q9H3P8xahbD22NqNTEi
   a6k6g6Km0VWKZcxm183Sdqp6BDRDHvhwb2TSYig6irpItsc21PAs7CxzY
   g==;
X-CSE-ConnectionGUID: PZwRHL3fTLSgMTN3MFxTYg==
X-CSE-MsgGUID: Z6HvDEmeTY2HvLdT1IJODw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54610014"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="54610014"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:55:20 -0700
X-CSE-ConnectionGUID: O1oWYm7+QRm3J4s/lGGKmA==
X-CSE-MsgGUID: ++RzM6PpS3Scswffxp10Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="156277063"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:55:19 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 09/15] wifi: iwlwifi: fix HE/EHT capabilities
Date: Thu, 10 Jul 2025 19:54:42 +0300
Message-Id: <20250710195219.69b9dac7d906.I7885499bc80453d5a84285ec927f5e89f9adfb21@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710165448.2553296-1-miriam.rachel.korenblit@intel.com>
References: <20250710165448.2553296-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The default capabilities were set to much more than the hardware
currently is intended to support, and then masked off for only
the GL MAC type. However, this was due to some miscommunication
and is incorrect, it should've been masked off for all current
and planned MACs/RFs. Instead of doing this removing and adding
of capabilities, simply list the ones that currently apply to
all devices. If this changes for a new device type we can change
the code, but at least the driver won't erroneously advertise
some capabilities that aren't actually implemented in hardware.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 78 ++++---------------
 1 file changed, 15 insertions(+), 63 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 1e4162f1bb44..4424443d2328 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -663,6 +663,8 @@ static const struct ieee80211_sband_iftype_data iwl_he_eht_capa[] = {
 				.phy_cap_info[9] =
 					IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_COMP_SIGB |
 					IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_NON_COMP_SIGB |
+					IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU |
+					IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU |
 					(IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_RESERVED <<
 					IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_POS),
 				.phy_cap_info[10] =
@@ -691,44 +693,26 @@ static const struct ieee80211_sband_iftype_data iwl_he_eht_capa[] = {
 			.has_eht = true,
 			.eht_cap_elem = {
 				.mac_cap_info[0] =
-					IEEE80211_EHT_MAC_CAP0_EPCS_PRIO_ACCESS |
-					IEEE80211_EHT_MAC_CAP0_OM_CONTROL |
-					IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE1 |
-					IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE2 |
-					IEEE80211_EHT_MAC_CAP0_SCS_TRAFFIC_DESC,
-				.mac_cap_info[1] =
-					IEEE80211_EHT_MAC_CAP1_UNSOL_EPCS_PRIO_ACCESS,
+					IEEE80211_EHT_MAC_CAP0_OM_CONTROL,
 				.phy_cap_info[0] =
 					IEEE80211_EHT_PHY_CAP0_242_TONE_RU_GT20MHZ |
 					IEEE80211_EHT_PHY_CAP0_NDP_4_EHT_LFT_32_GI |
-					IEEE80211_EHT_PHY_CAP0_PARTIAL_BW_UL_MU_MIMO |
 					IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMEE |
 					IEEE80211_EHT_PHY_CAP0_BEAMFORMEE_SS_80MHZ_MASK,
 				.phy_cap_info[1] =
 					IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_80MHZ_MASK  |
 					IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_160MHZ_MASK,
 				.phy_cap_info[3] =
-					IEEE80211_EHT_PHY_CAP3_NG_16_SU_FEEDBACK |
-					IEEE80211_EHT_PHY_CAP3_NG_16_MU_FEEDBACK |
-					IEEE80211_EHT_PHY_CAP3_CODEBOOK_4_2_SU_FDBK |
-					IEEE80211_EHT_PHY_CAP3_CODEBOOK_7_5_MU_FDBK |
-					IEEE80211_EHT_PHY_CAP3_TRIG_SU_BF_FDBK |
-					IEEE80211_EHT_PHY_CAP3_TRIG_MU_BF_PART_BW_FDBK |
-					IEEE80211_EHT_PHY_CAP3_TRIG_CQI_FDBK,
+					IEEE80211_EHT_PHY_CAP3_TRIG_SU_BF_FDBK,
 
 				.phy_cap_info[4] =
-					IEEE80211_EHT_PHY_CAP4_PART_BW_DL_MU_MIMO |
-					IEEE80211_EHT_PHY_CAP4_POWER_BOOST_FACT_SUPP |
 					IEEE80211_EHT_PHY_CAP4_EHT_MU_PPDU_4_EHT_LTF_08_GI,
 				.phy_cap_info[5] =
 					FIELD_PREP_CONST(IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_MASK,
 							 IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_16US) |
-					IEEE80211_EHT_PHY_CAP5_NON_TRIG_CQI_FEEDBACK |
 					IEEE80211_EHT_PHY_CAP5_TX_LESS_242_TONE_RU_SUPP |
-					IEEE80211_EHT_PHY_CAP5_RX_LESS_242_TONE_RU_SUPP,
-				.phy_cap_info[6] =
-					IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_MASK |
-					IEEE80211_EHT_PHY_CAP6_EHT_DUP_6GHZ_SUPP,
+					IEEE80211_EHT_PHY_CAP5_RX_LESS_242_TONE_RU_SUPP |
+					IEEE80211_EHT_PHY_CAP5_SUPP_EXTRA_EHT_LTF,
 				.phy_cap_info[8] =
 					IEEE80211_EHT_PHY_CAP8_RX_1024QAM_WIDER_BW_DL_OFDMA |
 					IEEE80211_EHT_PHY_CAP8_RX_4096QAM_WIDER_BW_DL_OFDMA,
@@ -796,6 +780,7 @@ static const struct ieee80211_sband_iftype_data iwl_he_eht_capa[] = {
 					IEEE80211_HE_PHY_CAP8_HE_ER_SU_PPDU_4XLTF_AND_08_US_GI |
 					IEEE80211_HE_PHY_CAP8_DCM_MAX_RU_242,
 				.phy_cap_info[9] =
+					IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU |
 					IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_RESERVED
 					<< IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_POS,
 			},
@@ -822,9 +807,7 @@ static const struct ieee80211_sband_iftype_data iwl_he_eht_capa[] = {
 			.has_eht = true,
 			.eht_cap_elem = {
 				.mac_cap_info[0] =
-					IEEE80211_EHT_MAC_CAP0_OM_CONTROL |
-					IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE1 |
-					IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE2,
+					IEEE80211_EHT_MAC_CAP0_OM_CONTROL,
 				.phy_cap_info[0] =
 					IEEE80211_EHT_PHY_CAP0_242_TONE_RU_GT20MHZ |
 					IEEE80211_EHT_PHY_CAP0_NDP_4_EHT_LFT_32_GI,
@@ -1039,48 +1022,17 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 			cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
 	}
 
+	/* prior RFs don't have HE, HR RF doesn't have this, later have it */
+	if (CSR_HW_RFID_TYPE(trans->info.hw_rf_id) == IWL_CFG_RF_TYPE_HR1 ||
+	    CSR_HW_RFID_TYPE(trans->info.hw_rf_id) == IWL_CFG_RF_TYPE_HR2)
+		iftype_data->he_cap.he_cap_elem.phy_cap_info[9] &=
+			~(IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU |
+			  IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU);
+
 	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210 && !is_ap)
 		iftype_data->he_cap.he_cap_elem.phy_cap_info[2] |=
 			IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO;
 
-	switch (CSR_HW_RFID_TYPE(trans->info.hw_rf_id)) {
-	case IWL_CFG_RF_TYPE_GF:
-	case IWL_CFG_RF_TYPE_FM:
-	case IWL_CFG_RF_TYPE_WH:
-	case IWL_CFG_RF_TYPE_PE:
-		iftype_data->he_cap.he_cap_elem.phy_cap_info[9] |=
-			IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU;
-		if (!is_ap)
-			iftype_data->he_cap.he_cap_elem.phy_cap_info[9] |=
-				IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU;
-		break;
-	}
-
-	if (CSR_HW_REV_TYPE(trans->info.hw_rev) == IWL_CFG_MAC_TYPE_GL &&
-	    iftype_data->eht_cap.has_eht) {
-		iftype_data->eht_cap.eht_cap_elem.mac_cap_info[0] &=
-			~(IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE1 |
-			  IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE2);
-		iftype_data->eht_cap.eht_cap_elem.phy_cap_info[3] &=
-			~(IEEE80211_EHT_PHY_CAP0_PARTIAL_BW_UL_MU_MIMO |
-			  IEEE80211_EHT_PHY_CAP3_NG_16_SU_FEEDBACK |
-			  IEEE80211_EHT_PHY_CAP3_NG_16_MU_FEEDBACK |
-			  IEEE80211_EHT_PHY_CAP3_CODEBOOK_4_2_SU_FDBK |
-			  IEEE80211_EHT_PHY_CAP3_CODEBOOK_7_5_MU_FDBK |
-			  IEEE80211_EHT_PHY_CAP3_TRIG_MU_BF_PART_BW_FDBK |
-			  IEEE80211_EHT_PHY_CAP3_TRIG_CQI_FDBK);
-		iftype_data->eht_cap.eht_cap_elem.phy_cap_info[4] &=
-			~(IEEE80211_EHT_PHY_CAP4_PART_BW_DL_MU_MIMO |
-			  IEEE80211_EHT_PHY_CAP4_POWER_BOOST_FACT_SUPP);
-		iftype_data->eht_cap.eht_cap_elem.phy_cap_info[5] &=
-			~IEEE80211_EHT_PHY_CAP5_NON_TRIG_CQI_FEEDBACK;
-		iftype_data->eht_cap.eht_cap_elem.phy_cap_info[6] &=
-			~(IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_MASK |
-			  IEEE80211_EHT_PHY_CAP6_EHT_DUP_6GHZ_SUPP);
-		iftype_data->eht_cap.eht_cap_elem.phy_cap_info[5] |=
-			IEEE80211_EHT_PHY_CAP5_SUPP_EXTRA_EHT_LTF;
-	}
-
 	if (fw_has_capa(&fw->ucode_capa, IWL_UCODE_TLV_CAPA_BROADCAST_TWT))
 		iftype_data->he_cap.he_cap_elem.mac_cap_info[2] |=
 			IEEE80211_HE_MAC_CAP2_BCAST_TWT;
-- 
2.34.1


