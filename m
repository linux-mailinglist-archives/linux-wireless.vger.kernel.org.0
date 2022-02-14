Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330014B5633
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 17:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356404AbiBNQac (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 11:30:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356380AbiBNQaX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 11:30:23 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1337860D86
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 08:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=NR5xY+PZv85IeXlGZwiTnVsDD7basSd3uui4Jrw1hW4=;
        t=1644856215; x=1646065815; b=B+sGN6WdzD7+ttaM5C4iQ9Dcz2fnPdjLv12Rhq1faqLnn2s
        zdBZtntw5SCechEEmgiHuXLSJ0k/ZbiM0PyVrBA6FYfwqN7Bgd8sdZNgABJAgqlTWWYKCsRvg/C5G
        AyaLQGD2FZIGRsQ0lo1k3XthXdCA/pswjQ/VDFVTprSWCbhxOdKFrmvEo/wT0xAoE2DrnXDboCiy1
        Pg3Y68A7LkyyHXhfuXBGIqPbNATXmlUWiBQxoTqsEBbswyQaTkkaB2ANH7ifFZExhJL6UcvAqyHwa
        ByZ+0V24giUlkP3M8zej/moiHkHqWirPOY9FCI8wzzEatAGmOp7sTKRjykwSNlDg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nJeEv-0011mw-9w;
        Mon, 14 Feb 2022 17:30:13 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v3 19/19] mac80211_hwsim: Advertise support for EHT capabilities
Date:   Mon, 14 Feb 2022 17:30:06 +0100
Message-Id: <20220214173004.1b710f8e04ce.I11d6911dafc01deb8ceb7828e363e8554701790a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214173004.9fd154d2c3c2.Ia0cd152357a373149bab017d479ab7d5ded289c0@changeid>
References: <20220214173004.9fd154d2c3c2.Ia0cd152357a373149bab017d479ab7d5ded289c0@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

Add EHT capabilities to bands.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 246 ++++++++++++++++++++++++--
 1 file changed, 234 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index fdf781548e3f..b23c6deaa486 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2008, Jouni Malinen <j@w1.fi>
  * Copyright (c) 2011, Javier Lopez <jlopex@gmail.com>
  * Copyright (c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2020 Intel Corporation
+ * Copyright (C) 2018 - 2022 Intel Corporation
  */
 
 /*
@@ -2940,7 +2940,7 @@ static void hwsim_mcast_new_radio(int id, struct genl_info *info,
 	nlmsg_free(mcast_skb);
 }
 
-static const struct ieee80211_sband_iftype_data he_capa_2ghz[] = {
+static const struct ieee80211_sband_iftype_data sband_capa_2ghz[] = {
 	{
 		.types_mask = BIT(NL80211_IFTYPE_STATION) |
 			      BIT(NL80211_IFTYPE_AP),
@@ -2986,6 +2986,66 @@ static const struct ieee80211_sband_iftype_data he_capa_2ghz[] = {
 				.tx_mcs_80p80 = cpu_to_le16(0xffff),
 			},
 		},
+		.eht_cap = {
+			.has_eht = true,
+			.eht_cap_elem = {
+				.mac_cap_info[0] =
+					IEEE80211_EHT_MAC_CAP0_NSEP_PRIO_ACCESS |
+					IEEE80211_EHT_MAC_CAP0_OM_CONTROL |
+					IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE1,
+				.phy_cap_info[0] =
+					IEEE80211_EHT_PHY_CAP0_242_TONE_RU_GT20MHZ |
+					IEEE80211_EHT_PHY_CAP0_NDP_4_EHT_LFT_32_GI |
+					IEEE80211_EHT_PHY_CAP0_PARTIAL_BW_UL_MU_MIMO |
+					IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMER |
+					IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMEE,
+				.phy_cap_info[3] =
+					IEEE80211_EHT_PHY_CAP3_NG_16_SU_FEEDBACK |
+					IEEE80211_EHT_PHY_CAP3_NG_16_MU_FEEDBACK |
+					IEEE80211_EHT_PHY_CAP3_CODEBOOK_4_2_SU_FDBK |
+					IEEE80211_EHT_PHY_CAP3_CODEBOOK_7_5_MU_FDBK |
+					IEEE80211_EHT_PHY_CAP3_TRIG_SU_BF_FDBK |
+					IEEE80211_EHT_PHY_CAP3_TRIG_MU_BF_PART_BW_FDBK |
+					IEEE80211_EHT_PHY_CAP3_TRIG_CQI_FDBK,
+				.phy_cap_info[4] =
+					IEEE80211_EHT_PHY_CAP4_PART_BW_DL_MU_MIMO |
+					IEEE80211_EHT_PHY_CAP4_PSR_SR_SUPP |
+					IEEE80211_EHT_PHY_CAP4_POWER_BOOST_FACT_SUPP |
+					IEEE80211_EHT_PHY_CAP4_EHT_MU_PPDU_4_EHT_LTF_08_GI |
+					IEEE80211_EHT_PHY_CAP4_MAX_NC_MASK,
+				.phy_cap_info[5] =
+					IEEE80211_EHT_PHY_CAP5_NON_TRIG_CQI_FEEDBACK |
+					IEEE80211_EHT_PHY_CAP5_TX_LESS_242_TONE_RU_SUPP |
+					IEEE80211_EHT_PHY_CAP5_RX_LESS_242_TONE_RU_SUPP |
+					IEEE80211_EHT_PHY_CAP5_PPE_THRESHOLD_PRESENT |
+					IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_MASK |
+					IEEE80211_EHT_PHY_CAP5_MAX_NUM_SUPP_EHT_LTF_MASK,
+				.phy_cap_info[6] =
+					IEEE80211_EHT_PHY_CAP6_MAX_NUM_SUPP_EHT_LTF_MASK |
+					IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_MASK,
+				.phy_cap_info[7] =
+					IEEE80211_EHT_PHY_CAP7_20MHZ_STA_RX_NDP_WIDER_BW,
+			},
+
+			/* For all MCS and bandwidth, set 8 NSS for both Tx and
+			 * Rx
+			 */
+			.eht_mcs_nss_supp = {
+				/*
+				 * Since B0, B1, B2 and B3 are not set in
+				 * the supported channel width set field in the
+				 * HE PHY capabilities information field the
+				 * device is a 20MHz only device on 2.4GHz band.
+				 */
+				.only_20mhz = {
+					.rx_tx_mcs7_max_nss = 0x88,
+					.rx_tx_mcs9_max_nss = 0x88,
+					.rx_tx_mcs11_max_nss = 0x88,
+					.rx_tx_mcs13_max_nss = 0x88,
+				},
+			},
+			/* PPE threshold information is not supported */
+		},
 	},
 #ifdef CONFIG_MAC80211_MESH
 	{
@@ -3028,7 +3088,7 @@ static const struct ieee80211_sband_iftype_data he_capa_2ghz[] = {
 #endif
 };
 
-static const struct ieee80211_sband_iftype_data he_capa_5ghz[] = {
+static const struct ieee80211_sband_iftype_data sband_capa_5ghz[] = {
 	{
 		/* TODO: should we support other types, e.g., P2P?*/
 		.types_mask = BIT(NL80211_IFTYPE_STATION) |
@@ -3079,6 +3139,81 @@ static const struct ieee80211_sband_iftype_data he_capa_5ghz[] = {
 				.tx_mcs_80p80 = cpu_to_le16(0xfffa),
 			},
 		},
+		.eht_cap = {
+			.has_eht = true,
+			.eht_cap_elem = {
+				.mac_cap_info[0] =
+					IEEE80211_EHT_MAC_CAP0_NSEP_PRIO_ACCESS |
+					IEEE80211_EHT_MAC_CAP0_OM_CONTROL |
+					IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE1,
+				.phy_cap_info[0] =
+					IEEE80211_EHT_PHY_CAP0_242_TONE_RU_GT20MHZ |
+					IEEE80211_EHT_PHY_CAP0_NDP_4_EHT_LFT_32_GI |
+					IEEE80211_EHT_PHY_CAP0_PARTIAL_BW_UL_MU_MIMO |
+					IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMER |
+					IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMEE |
+					IEEE80211_EHT_PHY_CAP0_BEAMFORMEE_SS_80MHZ_MASK,
+				.phy_cap_info[1] =
+					IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_80MHZ_MASK |
+					IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_160MHZ_MASK,
+				.phy_cap_info[2] =
+					IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_80MHZ_MASK |
+					IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_160MHZ_MASK,
+				.phy_cap_info[3] =
+					IEEE80211_EHT_PHY_CAP3_NG_16_SU_FEEDBACK |
+					IEEE80211_EHT_PHY_CAP3_NG_16_MU_FEEDBACK |
+					IEEE80211_EHT_PHY_CAP3_CODEBOOK_4_2_SU_FDBK |
+					IEEE80211_EHT_PHY_CAP3_CODEBOOK_7_5_MU_FDBK |
+					IEEE80211_EHT_PHY_CAP3_TRIG_SU_BF_FDBK |
+					IEEE80211_EHT_PHY_CAP3_TRIG_MU_BF_PART_BW_FDBK |
+					IEEE80211_EHT_PHY_CAP3_TRIG_CQI_FDBK,
+				.phy_cap_info[4] =
+					IEEE80211_EHT_PHY_CAP4_PART_BW_DL_MU_MIMO |
+					IEEE80211_EHT_PHY_CAP4_PSR_SR_SUPP |
+					IEEE80211_EHT_PHY_CAP4_POWER_BOOST_FACT_SUPP |
+					IEEE80211_EHT_PHY_CAP4_EHT_MU_PPDU_4_EHT_LTF_08_GI |
+					IEEE80211_EHT_PHY_CAP4_MAX_NC_MASK,
+				.phy_cap_info[5] =
+					IEEE80211_EHT_PHY_CAP5_NON_TRIG_CQI_FEEDBACK |
+					IEEE80211_EHT_PHY_CAP5_TX_LESS_242_TONE_RU_SUPP |
+					IEEE80211_EHT_PHY_CAP5_RX_LESS_242_TONE_RU_SUPP |
+					IEEE80211_EHT_PHY_CAP5_PPE_THRESHOLD_PRESENT |
+					IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_MASK |
+					IEEE80211_EHT_PHY_CAP5_MAX_NUM_SUPP_EHT_LTF_MASK,
+				.phy_cap_info[6] =
+					IEEE80211_EHT_PHY_CAP6_MAX_NUM_SUPP_EHT_LTF_MASK |
+					IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_MASK,
+				.phy_cap_info[7] =
+					IEEE80211_EHT_PHY_CAP7_20MHZ_STA_RX_NDP_WIDER_BW |
+					IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_80MHZ |
+					IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_160MHZ |
+					IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_80MHZ |
+					IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_160MHZ,
+			},
+
+			/* For all MCS and bandwidth, set 8 NSS for both Tx and
+			 * Rx
+			 */
+			.eht_mcs_nss_supp = {
+				/*
+				 * As B1 and B2 are set in the supported
+				 * channel width set field in the HE PHY
+				 * capabilities information field include all
+				 * the following MCS/NSS.
+				 */
+				.bw._80 = {
+					.rx_tx_mcs9_max_nss = 0x88,
+					.rx_tx_mcs11_max_nss = 0x88,
+					.rx_tx_mcs13_max_nss = 0x88,
+				},
+				.bw._160 = {
+					.rx_tx_mcs9_max_nss = 0x88,
+					.rx_tx_mcs11_max_nss = 0x88,
+					.rx_tx_mcs13_max_nss = 0x88,
+				},
+			},
+			/* PPE threshold information is not supported */
+		},
 	},
 #ifdef CONFIG_MAC80211_MESH
 	{
@@ -3126,7 +3261,7 @@ static const struct ieee80211_sband_iftype_data he_capa_5ghz[] = {
 #endif
 };
 
-static const struct ieee80211_sband_iftype_data he_capa_6ghz[] = {
+static const struct ieee80211_sband_iftype_data sband_capa_6ghz[] = {
 	{
 		/* TODO: should we support other types, e.g., P2P?*/
 		.types_mask = BIT(NL80211_IFTYPE_STATION) |
@@ -3186,6 +3321,93 @@ static const struct ieee80211_sband_iftype_data he_capa_6ghz[] = {
 				.tx_mcs_80p80 = cpu_to_le16(0xfffa),
 			},
 		},
+		.eht_cap = {
+			.has_eht = true,
+			.eht_cap_elem = {
+				.mac_cap_info[0] =
+					IEEE80211_EHT_MAC_CAP0_NSEP_PRIO_ACCESS |
+					IEEE80211_EHT_MAC_CAP0_OM_CONTROL |
+					IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE1,
+				.phy_cap_info[0] =
+					IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ |
+					IEEE80211_EHT_PHY_CAP0_242_TONE_RU_GT20MHZ |
+					IEEE80211_EHT_PHY_CAP0_NDP_4_EHT_LFT_32_GI |
+					IEEE80211_EHT_PHY_CAP0_PARTIAL_BW_UL_MU_MIMO |
+					IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMER |
+					IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMEE |
+					IEEE80211_EHT_PHY_CAP0_BEAMFORMEE_SS_80MHZ_MASK,
+				.phy_cap_info[1] =
+					IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_80MHZ_MASK |
+					IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_160MHZ_MASK |
+					IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_320MHZ_MASK,
+				.phy_cap_info[2] =
+					IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_80MHZ_MASK |
+					IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_160MHZ_MASK |
+					IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_320MHZ_MASK,
+				.phy_cap_info[3] =
+					IEEE80211_EHT_PHY_CAP3_NG_16_SU_FEEDBACK |
+					IEEE80211_EHT_PHY_CAP3_NG_16_MU_FEEDBACK |
+					IEEE80211_EHT_PHY_CAP3_CODEBOOK_4_2_SU_FDBK |
+					IEEE80211_EHT_PHY_CAP3_CODEBOOK_7_5_MU_FDBK |
+					IEEE80211_EHT_PHY_CAP3_TRIG_SU_BF_FDBK |
+					IEEE80211_EHT_PHY_CAP3_TRIG_MU_BF_PART_BW_FDBK |
+					IEEE80211_EHT_PHY_CAP3_TRIG_CQI_FDBK,
+				.phy_cap_info[4] =
+					IEEE80211_EHT_PHY_CAP4_PART_BW_DL_MU_MIMO |
+					IEEE80211_EHT_PHY_CAP4_PSR_SR_SUPP |
+					IEEE80211_EHT_PHY_CAP4_POWER_BOOST_FACT_SUPP |
+					IEEE80211_EHT_PHY_CAP4_EHT_MU_PPDU_4_EHT_LTF_08_GI |
+					IEEE80211_EHT_PHY_CAP4_MAX_NC_MASK,
+				.phy_cap_info[5] =
+					IEEE80211_EHT_PHY_CAP5_NON_TRIG_CQI_FEEDBACK |
+					IEEE80211_EHT_PHY_CAP5_TX_LESS_242_TONE_RU_SUPP |
+					IEEE80211_EHT_PHY_CAP5_RX_LESS_242_TONE_RU_SUPP |
+					IEEE80211_EHT_PHY_CAP5_PPE_THRESHOLD_PRESENT |
+					IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_MASK |
+					IEEE80211_EHT_PHY_CAP5_MAX_NUM_SUPP_EHT_LTF_MASK,
+				.phy_cap_info[6] =
+					IEEE80211_EHT_PHY_CAP6_MAX_NUM_SUPP_EHT_LTF_MASK |
+					IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_MASK |
+					IEEE80211_EHT_PHY_CAP6_EHT_DUP_6GHZ_SUPP,
+				.phy_cap_info[7] =
+					IEEE80211_EHT_PHY_CAP7_20MHZ_STA_RX_NDP_WIDER_BW |
+					IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_80MHZ |
+					IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_160MHZ |
+					IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_320MHZ |
+					IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_80MHZ |
+					IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_160MHZ |
+					IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_320MHZ,
+			},
+
+			/* For all MCS and bandwidth, set 8 NSS for both Tx and
+			 * Rx
+			 */
+			.eht_mcs_nss_supp = {
+				/*
+				 * As B1 and B2 are set in the supported
+				 * channel width set field in the HE PHY
+				 * capabilities information field and 320MHz in
+				 * 6GHz is supported include all the following
+				 * MCS/NSS.
+				 */
+				.bw._80 = {
+					.rx_tx_mcs9_max_nss = 0x88,
+					.rx_tx_mcs11_max_nss = 0x88,
+					.rx_tx_mcs13_max_nss = 0x88,
+				},
+				.bw._160 = {
+					.rx_tx_mcs9_max_nss = 0x88,
+					.rx_tx_mcs11_max_nss = 0x88,
+					.rx_tx_mcs13_max_nss = 0x88,
+				},
+				.bw._320 = {
+					.rx_tx_mcs9_max_nss = 0x88,
+					.rx_tx_mcs11_max_nss = 0x88,
+					.rx_tx_mcs13_max_nss = 0x88,
+				},
+			},
+			/* PPE threshold information is not supported */
+		},
 	},
 #ifdef CONFIG_MAC80211_MESH
 	{
@@ -3242,22 +3464,22 @@ static const struct ieee80211_sband_iftype_data he_capa_6ghz[] = {
 #endif
 };
 
-static void mac80211_hwsim_he_capab(struct ieee80211_supported_band *sband)
+static void mac80211_hwsim_sband_capab(struct ieee80211_supported_band *sband)
 {
 	u16 n_iftype_data;
 
 	if (sband->band == NL80211_BAND_2GHZ) {
-		n_iftype_data = ARRAY_SIZE(he_capa_2ghz);
+		n_iftype_data = ARRAY_SIZE(sband_capa_2ghz);
 		sband->iftype_data =
-			(struct ieee80211_sband_iftype_data *)he_capa_2ghz;
+			(struct ieee80211_sband_iftype_data *)sband_capa_2ghz;
 	} else if (sband->band == NL80211_BAND_5GHZ) {
-		n_iftype_data = ARRAY_SIZE(he_capa_5ghz);
+		n_iftype_data = ARRAY_SIZE(sband_capa_5ghz);
 		sband->iftype_data =
-			(struct ieee80211_sband_iftype_data *)he_capa_5ghz;
+			(struct ieee80211_sband_iftype_data *)sband_capa_5ghz;
 	} else if (sband->band == NL80211_BAND_6GHZ) {
-		n_iftype_data = ARRAY_SIZE(he_capa_6ghz);
+		n_iftype_data = ARRAY_SIZE(sband_capa_6ghz);
 		sband->iftype_data =
-			(struct ieee80211_sband_iftype_data *)he_capa_6ghz;
+			(struct ieee80211_sband_iftype_data *)sband_capa_6ghz;
 	} else {
 		return;
 	}
@@ -3582,7 +3804,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 			sband->ht_cap.mcs.tx_params = IEEE80211_HT_MCS_TX_DEFINED;
 		}
 
-		mac80211_hwsim_he_capab(sband);
+		mac80211_hwsim_sband_capab(sband);
 
 		hw->wiphy->bands[band] = sband;
 	}
-- 
2.34.1

