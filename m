Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890643AAD11
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 09:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhFQHLN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 03:11:13 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:47906 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230152AbhFQHLK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 03:11:10 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1ltm95-001XeC-OY; Thu, 17 Jun 2021 10:09:01 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 17 Jun 2021 10:08:47 +0300
Message-Id: <iwlwifi.20210617100544.e8d0b02ec86b.Ia6ef8cc0480d38af25e6ac45fad9fb15bdfcbc2c@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617070852.496985-1-luca@coelho.fi>
References: <20210617070852.496985-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 07/12] iwlwifi: correct HE capabilities
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The (default) HE capabilities for our devices weren't handled
correctly, adjust them to match the correct capabilities of
the devices.

Since the device regulatory will not allow 160 MHz on 5 GHz,
don't advertise this capability by default; do it only if an
NVM file is being loaded that might change the regulatory
parameters.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 114 ++++++++++--------
 1 file changed, 66 insertions(+), 48 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 81a101d6a190..46f92b58f009 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -550,8 +550,7 @@ static const struct ieee80211_sband_iftype_data iwl_he_capa[] = {
 				.mac_cap_info[2] =
 					IEEE80211_HE_MAC_CAP2_32BIT_BA_BITMAP,
 				.mac_cap_info[3] =
-					IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
-					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_2,
+					IEEE80211_HE_MAC_CAP3_OMI_CONTROL,
 				.mac_cap_info[4] =
 					IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU |
 					IEEE80211_HE_MAC_CAP4_MULTI_TID_AGG_TX_QOS_B39,
@@ -580,25 +579,20 @@ static const struct ieee80211_sband_iftype_data iwl_he_capa[] = {
 					IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE |
 					IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_8 |
 					IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_8,
-				.phy_cap_info[5] =
-					IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_2 |
-					IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_2,
 				.phy_cap_info[6] =
 					IEEE80211_HE_PHY_CAP6_TRIG_SU_BEAMFORMING_FB |
 					IEEE80211_HE_PHY_CAP6_TRIG_MU_BEAMFORMING_PARTIAL_BW_FB |
 					IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT,
 				.phy_cap_info[7] =
 					IEEE80211_HE_PHY_CAP7_POWER_BOOST_FACTOR_SUPP |
-					IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI |
-					IEEE80211_HE_PHY_CAP7_MAX_NC_1,
+					IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI,
 				.phy_cap_info[8] =
 					IEEE80211_HE_PHY_CAP8_HE_ER_SU_PPDU_4XLTF_AND_08_US_GI |
 					IEEE80211_HE_PHY_CAP8_20MHZ_IN_40MHZ_HE_PPDU_IN_2G |
 					IEEE80211_HE_PHY_CAP8_20MHZ_IN_160MHZ_HE_PPDU |
 					IEEE80211_HE_PHY_CAP8_80MHZ_IN_160MHZ_HE_PPDU |
-					IEEE80211_HE_PHY_CAP8_DCM_MAX_RU_2x996,
+					IEEE80211_HE_PHY_CAP8_DCM_MAX_RU_242,
 				.phy_cap_info[9] =
-					IEEE80211_HE_PHY_CAP9_NON_TRIGGERED_CQI_FEEDBACK |
 					IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_COMP_SIGB |
 					IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_NON_COMP_SIGB |
 					IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_RESERVED,
@@ -633,19 +627,11 @@ static const struct ieee80211_sband_iftype_data iwl_he_capa[] = {
 				.mac_cap_info[1] =
 					IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_16US |
 					IEEE80211_HE_MAC_CAP1_MULTI_TID_AGG_RX_QOS_8,
-				.mac_cap_info[2] =
-					IEEE80211_HE_MAC_CAP2_BSR,
 				.mac_cap_info[3] =
-					IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
-					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_2,
-				.mac_cap_info[4] =
-					IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU,
-				.mac_cap_info[5] =
-					IEEE80211_HE_MAC_CAP5_UL_2x996_TONE_RU,
+					IEEE80211_HE_MAC_CAP3_OMI_CONTROL,
 				.phy_cap_info[0] =
 					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
-					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
-					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G,
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G,
 				.phy_cap_info[1] =
 					IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD,
 				.phy_cap_info[2] =
@@ -655,27 +641,14 @@ static const struct ieee80211_sband_iftype_data iwl_he_capa[] = {
 					IEEE80211_HE_PHY_CAP3_DCM_MAX_TX_NSS_1 |
 					IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_NO_DCM |
 					IEEE80211_HE_PHY_CAP3_DCM_MAX_RX_NSS_1,
-				.phy_cap_info[4] =
-					IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE |
-					IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_8 |
-					IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_8,
-				.phy_cap_info[5] =
-					IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_2 |
-					IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_2,
 				.phy_cap_info[6] =
 					IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT,
 				.phy_cap_info[7] =
-					IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI |
-					IEEE80211_HE_PHY_CAP7_MAX_NC_1,
+					IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI,
 				.phy_cap_info[8] =
 					IEEE80211_HE_PHY_CAP8_HE_ER_SU_PPDU_4XLTF_AND_08_US_GI |
-					IEEE80211_HE_PHY_CAP8_20MHZ_IN_40MHZ_HE_PPDU_IN_2G |
-					IEEE80211_HE_PHY_CAP8_20MHZ_IN_160MHZ_HE_PPDU |
-					IEEE80211_HE_PHY_CAP8_80MHZ_IN_160MHZ_HE_PPDU |
-					IEEE80211_HE_PHY_CAP8_DCM_MAX_RU_2x996,
+					IEEE80211_HE_PHY_CAP8_DCM_MAX_RU_242,
 				.phy_cap_info[9] =
-					IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_COMP_SIGB |
-					IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_NON_COMP_SIGB |
 					IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_RESERVED,
 			},
 			/*
@@ -746,12 +719,66 @@ static void iwl_init_he_6ghz_capa(struct iwl_trans *trans,
 		iftype_data[i].he_6ghz_capa.capa = cpu_to_le16(he_6ghz_capa);
 }
 
+static void
+iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
+			 struct ieee80211_supported_band *sband,
+			 struct ieee80211_sband_iftype_data *iftype_data,
+			 u8 tx_chains, u8 rx_chains)
+{
+	bool is_ap = iftype_data->types_mask & BIT(NL80211_IFTYPE_AP);
+
+	/* Advertise an A-MPDU exponent extension based on
+	 * operating band
+	 */
+	if (sband->band != NL80211_BAND_2GHZ)
+		iftype_data->he_cap.he_cap_elem.mac_cap_info[3] |=
+			IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_1;
+	else
+		iftype_data->he_cap.he_cap_elem.mac_cap_info[3] |=
+			IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_3;
+
+	if (is_ap && iwlwifi_mod_params.nvm_file)
+		iftype_data->he_cap.he_cap_elem.phy_cap_info[0] |=
+			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+
+	if ((tx_chains & rx_chains) == ANT_AB) {
+		iftype_data->he_cap.he_cap_elem.phy_cap_info[5] |=
+			IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_2 |
+			IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_2;
+		if (!is_ap)
+			iftype_data->he_cap.he_cap_elem.phy_cap_info[7] |=
+				IEEE80211_HE_PHY_CAP7_MAX_NC_2;
+	} else if (!is_ap) {
+		/* If not 2x2, we need to indicate 1x1 in the
+		 * Midamble RX Max NSTS - but not for AP mode
+		 */
+		iftype_data->he_cap.he_cap_elem.phy_cap_info[1] &=
+			~IEEE80211_HE_PHY_CAP1_MIDAMBLE_RX_TX_MAX_NSTS;
+		iftype_data->he_cap.he_cap_elem.phy_cap_info[2] &=
+			~IEEE80211_HE_PHY_CAP2_MIDAMBLE_RX_TX_MAX_NSTS;
+		iftype_data->he_cap.he_cap_elem.phy_cap_info[7] |=
+			IEEE80211_HE_PHY_CAP7_MAX_NC_1;
+	}
+
+	switch (CSR_HW_RFID_TYPE(trans->hw_rf_id)) {
+	case IWL_CFG_RF_TYPE_GF:
+	case IWL_CFG_RF_TYPE_MR:
+		iftype_data->he_cap.he_cap_elem.phy_cap_info[9] |=
+			IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU;
+		if (!is_ap)
+			iftype_data->he_cap.he_cap_elem.phy_cap_info[9] |=
+				IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU;
+		break;
+	}
+}
+
 static void iwl_init_he_hw_capab(struct iwl_trans *trans,
 				 struct iwl_nvm_data *data,
 				 struct ieee80211_supported_band *sband,
 				 u8 tx_chains, u8 rx_chains)
 {
 	struct ieee80211_sband_iftype_data *iftype_data;
+	int i;
 
 	/* should only initialize once */
 	if (WARN_ON(sband->iftype_data))
@@ -778,19 +805,10 @@ static void iwl_init_he_hw_capab(struct iwl_trans *trans,
 	sband->iftype_data = iftype_data;
 	sband->n_iftype_data = ARRAY_SIZE(iwl_he_capa);
 
-	/* If not 2x2, we need to indicate 1x1 in the Midamble RX Max NSTS */
-	if ((tx_chains & rx_chains) != ANT_AB) {
-		int i;
-
-		for (i = 0; i < sband->n_iftype_data; i++) {
-			iftype_data[i].he_cap.he_cap_elem.phy_cap_info[1] &=
-				~IEEE80211_HE_PHY_CAP1_MIDAMBLE_RX_TX_MAX_NSTS;
-			iftype_data[i].he_cap.he_cap_elem.phy_cap_info[2] &=
-				~IEEE80211_HE_PHY_CAP2_MIDAMBLE_RX_TX_MAX_NSTS;
-			iftype_data[i].he_cap.he_cap_elem.phy_cap_info[7] &=
-				~IEEE80211_HE_PHY_CAP7_MAX_NC_MASK;
-		}
-	}
+	for (i = 0; i < sband->n_iftype_data; i++)
+		iwl_nvm_fixup_sband_iftd(trans, sband, &iftype_data[i],
+					 tx_chains, rx_chains);
+
 	iwl_init_he_6ghz_capa(trans, data, sband, tx_chains, rx_chains);
 }
 
-- 
2.32.0

