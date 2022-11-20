Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB528631551
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Nov 2022 18:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiKTRB2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Nov 2022 12:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiKTRB1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Nov 2022 12:01:27 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C2226579
        for <linux-wireless@vger.kernel.org>; Sun, 20 Nov 2022 09:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668963686; x=1700499686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PuBk7kBPvCuFLHBBNmtyooColypwDFVGlWOr1Drd+BY=;
  b=ORpbFpBrVQXjgjJqQSGdy/0756KpLRluIAVvbjC7HOb5eZaZOklGyWyy
   bQNVYEZEN1cB8/OgcseybPeEzKqzrXG/z3Mb8bRzGedrtSMBqW/n2WkEu
   E77SvuCJGVqV6bMusVIRYmTof3GV/ZaW5XYSu0ceHGnDrfTJiarJmg3YP
   qb8Xg7bbIe3mnuhtp+dtdj2HkMlHdVq6XCV8inxtdvcJKmfqT77f3Nvc/
   EFSUnkJDcWBHZ8NU8ZIApXHumABshfjI6o5GBA6fU0y3/va02XF7MpQ4S
   7aQY4o4+2ehFaPJfd1+T4PbaEkIX78jRxrOvQbQoIIbrIQGLtyDH2/+1S
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="315234827"
X-IronPort-AV: E=Sophos;i="5.96,179,1665471600"; 
   d="scan'208";a="315234827"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 09:01:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="765719419"
X-IronPort-AV: E=Sophos;i="5.96,179,1665471600"; 
   d="scan'208";a="765719419"
Received: from dwiener-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.87.2])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 09:01:24 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 1/9] wifi: iwlwifi: mvm: Advertise EHT capabilities
Date:   Sun, 20 Nov 2022 19:00:31 +0200
Message-Id: <20221120185147.73b38ef7c70a.I214005645f3da21d8f2458a70355deeca04a19e8@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221120170039.1788067-1-gregory.greenman@intel.com>
References: <20221120170039.1788067-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

Add support for advertising EHT capabilities is supported by
device SKU and not disabled by module parameters.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   3 +
 .../wireless/intel/iwlwifi/iwl-eeprom-parse.h |   3 +-
 .../wireless/intel/iwlwifi/iwl-modparams.h    |   1 +
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 178 ++++++++++++++++--
 4 files changed, 167 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index a2203f661321..ab7065c93826 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1971,3 +1971,6 @@ MODULE_PARM_DESC(remove_when_gone,
 module_param_named(disable_11ax, iwlwifi_mod_params.disable_11ax, bool,
 		   S_IRUGO);
 MODULE_PARM_DESC(disable_11ax, "Disable HE capabilities (default: false)");
+
+module_param_named(disable_11be, iwlwifi_mod_params.disable_11be, bool, 0444);
+MODULE_PARM_DESC(disable_11be, "Disable EHT capabilities (default: false)");
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h
index 0efffb6eeb1e..baa643386018 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018 Intel Corporation
+ * Copyright (C) 2005-2014, 2018, 2020-2022 Intel Corporation
  * Copyright (C) 2015 Intel Mobile Communications GmbH
  */
 #ifndef __iwl_eeprom_parse_h__
@@ -31,6 +31,7 @@ struct iwl_nvm_data {
 	bool sku_cap_amt_enable;
 	bool sku_cap_ipan_enable;
 	bool sku_cap_mimo_disabled;
+	bool sku_cap_11be_enable;
 
 	u16 radio_cfg_type;
 	u8 radio_cfg_step;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h b/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
index d0b4d02bdab9..1cf26ab4f488 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
@@ -62,6 +62,7 @@ enum iwl_uapsd_disable {
  * @disable_11ac: disable VHT capabilities, default = false.
  * @remove_when_gone: remove an inaccessible device from the PCIe bus.
  * @enable_ini: enable new FW debug infratructure (INI TLVs)
+ * @disable_11be: disable EHT capabilities, default = false.
  */
 struct iwl_mod_params {
 	int swcrypto;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 9040da3dcce3..2b43fff4d3f9 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -546,7 +546,7 @@ static const u8 iwl_vendor_caps[] = {
 	0x00
 };
 
-static const struct ieee80211_sband_iftype_data iwl_he_capa[] = {
+static const struct ieee80211_sband_iftype_data iwl_he_eht_capa[] = {
 	{
 		.types_mask = BIT(NL80211_IFTYPE_STATION),
 		.he_cap = {
@@ -631,6 +631,78 @@ static const struct ieee80211_sband_iftype_data iwl_he_capa[] = {
 			 */
 			.ppe_thres = {0x61, 0x1c, 0xc7, 0x71},
 		},
+		.eht_cap = {
+			.has_eht = true,
+			.eht_cap_elem = {
+				.mac_cap_info[0] =
+					IEEE80211_EHT_MAC_CAP0_EPCS_PRIO_ACCESS |
+					IEEE80211_EHT_MAC_CAP0_OM_CONTROL |
+					IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE1 |
+					IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE2,
+				.phy_cap_info[0] =
+					IEEE80211_EHT_PHY_CAP0_242_TONE_RU_GT20MHZ |
+					IEEE80211_EHT_PHY_CAP0_NDP_4_EHT_LFT_32_GI |
+					IEEE80211_EHT_PHY_CAP0_PARTIAL_BW_UL_MU_MIMO |
+					IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMEE |
+					IEEE80211_EHT_PHY_CAP0_BEAMFORMEE_SS_80MHZ_MASK,
+				.phy_cap_info[1] =
+					IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_80MHZ_MASK  |
+					IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_160MHZ_MASK |
+					IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_320MHZ_MASK,
+				.phy_cap_info[3] =
+					IEEE80211_EHT_PHY_CAP3_NG_16_SU_FEEDBACK |
+					IEEE80211_EHT_PHY_CAP3_NG_16_MU_FEEDBACK |
+					IEEE80211_EHT_PHY_CAP3_CODEBOOK_4_2_SU_FDBK |
+					IEEE80211_EHT_PHY_CAP3_CODEBOOK_7_5_MU_FDBK |
+					IEEE80211_EHT_PHY_CAP3_TRIG_SU_BF_FDBK |
+					IEEE80211_EHT_PHY_CAP3_TRIG_MU_BF_PART_BW_FDBK |
+					IEEE80211_EHT_PHY_CAP3_TRIG_CQI_FDBK,
+
+				.phy_cap_info[4] =
+					IEEE80211_EHT_PHY_CAP4_PART_BW_DL_MU_MIMO |
+					IEEE80211_EHT_PHY_CAP4_POWER_BOOST_FACT_SUPP |
+					IEEE80211_EHT_PHY_CAP4_EHT_MU_PPDU_4_EHT_LTF_08_GI,
+				.phy_cap_info[5] =
+					IEEE80211_EHT_PHY_CAP5_NON_TRIG_CQI_FEEDBACK |
+					IEEE80211_EHT_PHY_CAP5_TX_LESS_242_TONE_RU_SUPP |
+					IEEE80211_EHT_PHY_CAP5_RX_LESS_242_TONE_RU_SUPP |
+					IEEE80211_EHT_PHY_CAP5_PPE_THRESHOLD_PRESENT,
+				.phy_cap_info[6] =
+					IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_MASK |
+					IEEE80211_EHT_PHY_CAP6_EHT_DUP_6GHZ_SUPP,
+				.phy_cap_info[8] =
+					IEEE80211_EHT_PHY_CAP8_RX_1024QAM_WIDER_BW_DL_OFDMA |
+					IEEE80211_EHT_PHY_CAP8_RX_4096QAM_WIDER_BW_DL_OFDMA,
+			},
+
+			/* For all MCS and bandwidth, set 2 NSS for both Tx and
+			 * Rx - note we don't set the only_20mhz, but due to this
+			 * being a union, it gets set correctly anyway.
+			 */
+			.eht_mcs_nss_supp = {
+				.bw._80 = {
+					.rx_tx_mcs9_max_nss = 0x22,
+					.rx_tx_mcs11_max_nss = 0x22,
+					.rx_tx_mcs13_max_nss = 0x22,
+				},
+				.bw._160 = {
+					.rx_tx_mcs9_max_nss = 0x22,
+					.rx_tx_mcs11_max_nss = 0x22,
+					.rx_tx_mcs13_max_nss = 0x22,
+				},
+				.bw._320 = {
+					.rx_tx_mcs9_max_nss = 0x22,
+					.rx_tx_mcs11_max_nss = 0x22,
+					.rx_tx_mcs13_max_nss = 0x22,
+				},
+			},
+
+			/*
+			 * PPE thresholds for NSS = 2, and RU index bitmap set
+			 * to 0xc.
+			 */
+			.eht_ppe_thres = {0xc1, 0x0e, 0xe0 }
+		},
 	},
 	{
 		.types_mask = BIT(NL80211_IFTYPE_AP),
@@ -687,6 +759,49 @@ static const struct ieee80211_sband_iftype_data iwl_he_capa[] = {
 			 */
 			.ppe_thres = {0x61, 0x1c, 0xc7, 0x71},
 		},
+		.eht_cap = {
+			.has_eht = true,
+			.eht_cap_elem = {
+				.mac_cap_info[0] =
+					IEEE80211_EHT_MAC_CAP0_EPCS_PRIO_ACCESS |
+					IEEE80211_EHT_MAC_CAP0_OM_CONTROL |
+					IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE1 |
+					IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE2,
+				.phy_cap_info[0] =
+					IEEE80211_EHT_PHY_CAP0_242_TONE_RU_GT20MHZ |
+					IEEE80211_EHT_PHY_CAP0_NDP_4_EHT_LFT_32_GI,
+				.phy_cap_info[5] =
+					IEEE80211_EHT_PHY_CAP5_PPE_THRESHOLD_PRESENT,
+			},
+
+			/* For all MCS and bandwidth, set 2 NSS for both Tx and
+			 * Rx - note we don't set the only_20mhz, but due to this
+			 * being a union, it gets set correctly anyway.
+			 */
+			.eht_mcs_nss_supp = {
+				.bw._80 = {
+					.rx_tx_mcs9_max_nss = 0x22,
+					.rx_tx_mcs11_max_nss = 0x22,
+					.rx_tx_mcs13_max_nss = 0x22,
+				},
+				.bw._160 = {
+					.rx_tx_mcs9_max_nss = 0x22,
+					.rx_tx_mcs11_max_nss = 0x22,
+					.rx_tx_mcs13_max_nss = 0x22,
+				},
+				.bw._320 = {
+					.rx_tx_mcs9_max_nss = 0x22,
+					.rx_tx_mcs11_max_nss = 0x22,
+					.rx_tx_mcs13_max_nss = 0x22,
+				},
+			},
+
+			/*
+			 * PPE thresholds for NSS = 2, and RU index bitmap set
+			 * to 0xc.
+			 */
+			.eht_ppe_thres = {0xc1, 0x0e, 0xe0 }
+		},
 	},
 };
 
@@ -738,6 +853,7 @@ static void iwl_init_he_6ghz_capa(struct iwl_trans *trans,
 
 static void
 iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
+			 struct iwl_nvm_data *data,
 			 struct ieee80211_supported_band *sband,
 			 struct ieee80211_sband_iftype_data *iftype_data,
 			 u8 tx_chains, u8 rx_chains,
@@ -745,6 +861,9 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 {
 	bool is_ap = iftype_data->types_mask & BIT(NL80211_IFTYPE_AP);
 
+	if (!data->sku_cap_11be_enable || iwlwifi_mod_params.disable_11be)
+		iftype_data->eht_cap.has_eht = false;
+
 	/* Advertise an A-MPDU exponent extension based on
 	 * operating band
 	 */
@@ -765,19 +884,44 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 		iftype_data->he_cap.he_cap_elem.phy_cap_info[5] |=
 			IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_2 |
 			IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_2;
-		if (!is_ap)
+		if (!is_ap) {
 			iftype_data->he_cap.he_cap_elem.phy_cap_info[7] |=
 				IEEE80211_HE_PHY_CAP7_MAX_NC_2;
-	} else if (!is_ap) {
-		/* If not 2x2, we need to indicate 1x1 in the
-		 * Midamble RX Max NSTS - but not for AP mode
-		 */
-		iftype_data->he_cap.he_cap_elem.phy_cap_info[1] &=
-			~IEEE80211_HE_PHY_CAP1_MIDAMBLE_RX_TX_MAX_NSTS;
-		iftype_data->he_cap.he_cap_elem.phy_cap_info[2] &=
-			~IEEE80211_HE_PHY_CAP2_MIDAMBLE_RX_TX_MAX_NSTS;
-		iftype_data->he_cap.he_cap_elem.phy_cap_info[7] |=
-			IEEE80211_HE_PHY_CAP7_MAX_NC_1;
+
+			if (iftype_data->eht_cap.has_eht) {
+				/*
+				 * Set the number of sounding dimensions for each
+				 * bandwidth to 1 to indicate the maximal supported
+				 * value of TXVECTOR parameter NUM_STS of 2
+				 */
+				iftype_data->eht_cap.eht_cap_elem.phy_cap_info[2] |= 0x49;
+
+				/*
+				 * Set the MAX NC to 1 to indicate sounding feedback of
+				 * 2 supported by the beamfomee.
+				 */
+				iftype_data->eht_cap.eht_cap_elem.phy_cap_info[4] |= 0x10;
+			}
+		}
+	} else {
+		if (iftype_data->eht_cap.has_eht) {
+			struct ieee80211_eht_mcs_nss_supp *mcs_nss =
+				&iftype_data->eht_cap.eht_mcs_nss_supp;
+
+			memset(mcs_nss, 0x11, sizeof(*mcs_nss));
+		}
+
+		if (!is_ap) {
+			/* If not 2x2, we need to indicate 1x1 in the
+			 * Midamble RX Max NSTS - but not for AP mode
+			 */
+			iftype_data->he_cap.he_cap_elem.phy_cap_info[1] &=
+				~IEEE80211_HE_PHY_CAP1_MIDAMBLE_RX_TX_MAX_NSTS;
+			iftype_data->he_cap.he_cap_elem.phy_cap_info[2] &=
+				~IEEE80211_HE_PHY_CAP2_MIDAMBLE_RX_TX_MAX_NSTS;
+			iftype_data->he_cap.he_cap_elem.phy_cap_info[7] |=
+				IEEE80211_HE_PHY_CAP7_MAX_NC_1;
+		}
 	}
 
 	switch (CSR_HW_RFID_TYPE(trans->hw_rf_id)) {
@@ -816,8 +960,8 @@ static void iwl_init_he_hw_capab(struct iwl_trans *trans,
 	if (WARN_ON(sband->iftype_data))
 		return;
 
-	BUILD_BUG_ON(sizeof(data->iftd.low) != sizeof(iwl_he_capa));
-	BUILD_BUG_ON(sizeof(data->iftd.high) != sizeof(iwl_he_capa));
+	BUILD_BUG_ON(sizeof(data->iftd.low) != sizeof(iwl_he_eht_capa));
+	BUILD_BUG_ON(sizeof(data->iftd.high) != sizeof(iwl_he_eht_capa));
 
 	switch (sband->band) {
 	case NL80211_BAND_2GHZ:
@@ -832,13 +976,13 @@ static void iwl_init_he_hw_capab(struct iwl_trans *trans,
 		return;
 	}
 
-	memcpy(iftype_data, iwl_he_capa, sizeof(iwl_he_capa));
+	memcpy(iftype_data, iwl_he_eht_capa, sizeof(iwl_he_eht_capa));
 
 	sband->iftype_data = iftype_data;
-	sband->n_iftype_data = ARRAY_SIZE(iwl_he_capa);
+	sband->n_iftype_data = ARRAY_SIZE(iwl_he_eht_capa);
 
 	for (i = 0; i < sband->n_iftype_data; i++)
-		iwl_nvm_fixup_sband_iftd(trans, sband, &iftype_data[i],
+		iwl_nvm_fixup_sband_iftd(trans, data, sband, &iftype_data[i],
 					 tx_chains, rx_chains, fw);
 
 	iwl_init_he_6ghz_capa(trans, data, sband, tx_chains, rx_chains);
-- 
2.35.3

