Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8426E6AAF67
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Mar 2023 13:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjCEMR1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Mar 2023 07:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjCEMR0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Mar 2023 07:17:26 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0A112F39
        for <linux-wireless@vger.kernel.org>; Sun,  5 Mar 2023 04:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678018640; x=1709554640;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eCDdiw6U3+LOFJcAHLAFpt3mnzrgGtGPsdz7FEWjlFI=;
  b=PUmNgZf+t+p73VMXPyN1gUQ5pCvGazvd8yVP8frpe4c2zOOTbB9AbIW+
   pnYBEsl2NvGhbBOIjvagH/eAMqv/b0oSo2KC0IWFz0RzWk5MaNSeg7545
   sN10rqgb7+zsTEbyG+KDj5wrWXTy2Ms8prob/4q2tGaMrp1EuKhp8Z7qW
   aVVOJRdoKaXF+QE63MAbWWSYpYh31vtOTdSjkQ3ziFOFO+aIPP9aL7JSR
   2/6Iss6YzCrKb6cvozBoNoxXgeG34hWuQC3gAeUDaiohoEB/7D6Gfwk3i
   KbkAnLf6rG8ca4IHBGay11VZXd4h12D2EDyJQeBE9URwXQ3xXEWUohg3f
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="400193226"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="400193226"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="708355113"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="708355113"
Received: from hsaid-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.80.12])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:18 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/21] wifi: iwlwifi: mvm: parse FW frame metadata for EHT sniffer mode
Date:   Sun,  5 Mar 2023 14:16:25 +0200
Message-Id: <20230305124407.557d3870753b.I4e9fa4d21900a187753529d46956ba2a7ee75fda@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230305121635.301451-1-gregory.greenman@intel.com>
References: <20230305121635.301451-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

In EHT sniffer mode DW4 is all used for sniffer data (unlike we have in
HE mode), so move the full DW4 into a union, and we extract the new data5
used for parsing USIG info and set all to radiotap TLVs with the
extracted data.

Also parse OFDM_RX_VECTOR_USIG_A1_OUT and OFDM_RX_VECTOR_USIG_A2_OUT for
rx_no_data notification.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |  66 +++++--
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 168 +++++++++++++++++-
 2 files changed, 211 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index 0f190266fffd..97e946e70279 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -674,22 +674,31 @@ struct iwl_rx_mpdu_desc {
 	 * @mac_phy_idx: MAC/PHY index
 	 */
 	u8 mac_phy_idx;
-	/* DW4 - carries csum data only when rpa_en == 1 */
-	/**
-	 * @raw_csum: raw checksum (alledgedly unreliable)
-	 */
-	__le16 raw_csum;
-
+	/* DW4 */
 	union {
+		struct {
+			/* carries csum data only when rpa_en == 1 */
+			/**
+			 * @raw_csum: raw checksum (alledgedly unreliable)
+			 */
+			__le16 raw_csum;
+
+			union {
+				/**
+				 * @l3l4_flags: &enum iwl_rx_l3l4_flags
+				 */
+				__le16 l3l4_flags;
+
+				/**
+				 * @phy_data4: depends on info type, see phy_data1
+				 */
+				__le16 phy_data4;
+			};
+		};
 		/**
-		 * @l3l4_flags: &enum iwl_rx_l3l4_flags
-		 */
-		__le16 l3l4_flags;
-
-		/**
-		 * @phy_data4: depends on info type, see phy_data1
+		 * @phy_eht_data4: depends on info type, see phy_data1
 		 */
-		__le16 phy_data4;
+		__le32 phy_eht_data4;
 	};
 	/* DW5 */
 	/**
@@ -744,6 +753,35 @@ struct iwl_rx_mpdu_desc {
 #define RX_NO_DATA_RX_VEC0_VHT_NSTS_MSK	0x38000000
 #define RX_NO_DATA_RX_VEC2_EHT_NSTS_MSK	0x00f00000
 
+/* content of OFDM_RX_VECTOR_USIG_A1_OUT */
+enum iwl_rx_usig_a1 {
+	IWL_RX_USIG_A1_ENHANCED_WIFI_VER_ID	= 0x00000007,
+	IWL_RX_USIG_A1_BANDWIDTH		= 0x00000038,
+	IWL_RX_USIG_A1_UL_FLAG			= 0x00000040,
+	IWL_RX_USIG_A1_BSS_COLOR		= 0x00001f80,
+	IWL_RX_USIG_A1_TXOP_DURATION		= 0x000fe000,
+	IWL_RX_USIG_A1_DISREGARD		= 0x01f00000,
+	IWL_RX_USIG_A1_VALIDATE			= 0x02000000,
+	IWL_RX_USIG_A1_EHT_BW320_SLOT		= 0x04000000,
+	IWL_RX_USIG_A1_EHT_TYPE			= 0x18000000,
+	IWL_RX_USIG_A1_RDY			= 0x80000000,
+};
+
+/* content of OFDM_RX_VECTOR_USIG_A2_EHT_OUT */
+enum iwl_rx_usig_a2_eht {
+	IWL_RX_USIG_A2_EHT_PPDU_TYPE		= 0x00000003,
+	IWL_RX_USIG_A2_EHT_USIG2_VALIDATE_B2	= 0x00000004,
+	IWL_RX_USIG_A2_EHT_PUNC_CHANNEL		= 0x000000f8,
+	IWL_RX_USIG_A2_EHT_USIG2_VALIDATE_B8	= 0x00000100,
+	IWL_RX_USIG_A2_EHT_SIG_MCS		= 0x00000600,
+	IWL_RX_USIG_A2_EHT_SIG_SYM_NUM		= 0x0000f800,
+	IWL_RX_USIG_A2_EHT_TRIG_SPATIAL_REUSE_1 = 0x000f0000,
+	IWL_RX_USIG_A2_EHT_TRIG_SPATIAL_REUSE_2 = 0x00f00000,
+	IWL_RX_USIG_A2_EHT_TRIG_USIG2_DISREGARD	= 0x1f000000,
+	IWL_RX_USIG_A2_EHT_CRC_OK		= 0x40000000,
+	IWL_RX_USIG_A2_EHT_RDY			= 0x80000000,
+};
+
 /**
  * struct iwl_rx_no_data - RX no data descriptor
  * @info: 7:0 frame type, 15:8 RX error type
@@ -781,7 +819,7 @@ struct iwl_rx_no_data {
  * @rx_vec: DW-12:9 raw RX vectors from DSP according to modulation type.
  *	for VHT: OFDM_RX_VECTOR_SIGA1_OUT, OFDM_RX_VECTOR_SIGA2_OUT
  *	for HE: OFDM_RX_VECTOR_HE_SIGA1_OUT, OFDM_RX_VECTOR_HE_SIGA2_OUT
- *	for EHT: OFDM_RX_VECTOR_USIG_A1_OUT, OFDM_RX_VECTOR_USIG_A2_OUT,
+ *	for EHT: OFDM_RX_VECTOR_USIG_A1_OUT, OFDM_RX_VECTOR_USIG_A2_EHT_OUT,
  *	OFDM_RX_VECTOR_EHT_OUT, OFDM_RX_VECTOR_EHT_USER_FIELD_OUT
  */
 struct iwl_rx_no_data_ver_3 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index e5e066f04bf9..c8b4d751f5f0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1176,8 +1176,10 @@ static void iwl_mvm_flip_address(u8 *addr)
 
 struct iwl_mvm_rx_phy_data {
 	enum iwl_rx_phy_info_type info_type;
-	__le32 d0, d1, d2, d3;
+	__le32 d0, d1, d2, d3, eht_d4, d5;
 	__le16 d4;
+	bool with_data;
+	__le32 rx_vec[4];
 
 	u32 rate_n_flags;
 	u32 gp2_on_air_rise;
@@ -1458,6 +1460,119 @@ static void iwl_mvm_decode_he_phy_data(struct iwl_mvm *mvm,
 #define LE32_DEC_ENC(value, dec_bits, enc_bits) \
 	le32_encode_bits(le32_get_bits(value, dec_bits), enc_bits)
 
+#define IWL_MVM_ENC_USIG_VALUE_MASK(usig, in_value, dec_bits, enc_bits) do { \
+	typeof(enc_bits) _enc_bits = enc_bits; \
+	typeof(usig) _usig = usig; \
+	(_usig)->mask |= cpu_to_le32(_enc_bits); \
+	(_usig)->value |= LE32_DEC_ENC(in_value, dec_bits, _enc_bits); \
+} while (0)
+
+static void iwl_mvm_decode_eht_ext_mu(struct iwl_mvm *mvm,
+				      struct iwl_mvm_rx_phy_data *phy_data,
+				      struct ieee80211_rx_status *rx_status,
+				      struct ieee80211_radiotap_eht *eht,
+				      struct ieee80211_radiotap_eht_usig *usig)
+{
+	__le32 data1 = phy_data->d1;
+
+	if (phy_data->with_data) {
+		__le32 data4 = phy_data->eht_d4;
+		__le32 data5 = phy_data->d5;
+
+		IWL_MVM_ENC_USIG_VALUE_MASK(usig, data5,
+					    IWL_RX_PHY_DATA5_EHT_TYPE_AND_COMP,
+					    IEEE80211_RADIOTAP_EHT_USIG2_MU_B0_B1_PPDU_TYPE);
+		IWL_MVM_ENC_USIG_VALUE_MASK(usig, data5,
+					    IWL_RX_PHY_DATA5_EHT_MU_PUNC_CH_CODE,
+					    IEEE80211_RADIOTAP_EHT_USIG2_MU_B3_B7_PUNCTURED_INFO);
+		IWL_MVM_ENC_USIG_VALUE_MASK(usig, data4,
+					    IWL_RX_PHY_DATA4_EHT_MU_EXT_SIGB_MCS,
+					    IEEE80211_RADIOTAP_EHT_USIG2_MU_B9_B10_SIG_MCS);
+		IWL_MVM_ENC_USIG_VALUE_MASK
+			(usig, data1, IWL_RX_PHY_DATA1_EHT_MU_NUM_SIG_SYM_USIGA2,
+			 IEEE80211_RADIOTAP_EHT_USIG2_MU_B11_B15_EHT_SIG_SYMBOLS);
+
+	} else {
+		__le32 usig_a1 = phy_data->rx_vec[0];
+		__le32 usig_a2 = phy_data->rx_vec[1];
+
+		IWL_MVM_ENC_USIG_VALUE_MASK(usig, usig_a1,
+					    IWL_RX_USIG_A1_DISREGARD,
+					    IEEE80211_RADIOTAP_EHT_USIG1_MU_B20_B24_DISREGARD);
+		IWL_MVM_ENC_USIG_VALUE_MASK(usig, usig_a1,
+					    IWL_RX_USIG_A1_VALIDATE,
+					    IEEE80211_RADIOTAP_EHT_USIG1_MU_B25_VALIDATE);
+		IWL_MVM_ENC_USIG_VALUE_MASK(usig, usig_a2,
+					    IWL_RX_USIG_A2_EHT_PPDU_TYPE,
+					    IEEE80211_RADIOTAP_EHT_USIG2_MU_B0_B1_PPDU_TYPE);
+		IWL_MVM_ENC_USIG_VALUE_MASK(usig, usig_a2,
+					    IWL_RX_USIG_A2_EHT_USIG2_VALIDATE_B2,
+					    IEEE80211_RADIOTAP_EHT_USIG2_MU_B2_VALIDATE);
+		IWL_MVM_ENC_USIG_VALUE_MASK(usig, usig_a2,
+					    IWL_RX_USIG_A2_EHT_PUNC_CHANNEL,
+					    IEEE80211_RADIOTAP_EHT_USIG2_MU_B3_B7_PUNCTURED_INFO);
+		IWL_MVM_ENC_USIG_VALUE_MASK(usig, usig_a2,
+					    IWL_RX_USIG_A2_EHT_USIG2_VALIDATE_B8,
+					    IEEE80211_RADIOTAP_EHT_USIG2_MU_B8_VALIDATE);
+		IWL_MVM_ENC_USIG_VALUE_MASK(usig, usig_a2,
+					    IWL_RX_USIG_A2_EHT_SIG_MCS,
+					    IEEE80211_RADIOTAP_EHT_USIG2_MU_B9_B10_SIG_MCS);
+		IWL_MVM_ENC_USIG_VALUE_MASK
+			(usig, usig_a2, IWL_RX_USIG_A2_EHT_SIG_SYM_NUM,
+			 IEEE80211_RADIOTAP_EHT_USIG2_MU_B11_B15_EHT_SIG_SYMBOLS);
+		IWL_MVM_ENC_USIG_VALUE_MASK(usig, usig_a2,
+					    IWL_RX_USIG_A2_EHT_CRC_OK,
+					    IEEE80211_RADIOTAP_EHT_USIG2_MU_B16_B19_CRC);
+	}
+}
+
+static void iwl_mvm_decode_eht_ext_tb(struct iwl_mvm *mvm,
+				      struct iwl_mvm_rx_phy_data *phy_data,
+				      struct ieee80211_rx_status *rx_status,
+				      struct ieee80211_radiotap_eht *eht,
+				      struct ieee80211_radiotap_eht_usig *usig)
+{
+	if (phy_data->with_data) {
+		__le32 data5 = phy_data->d5;
+
+		IWL_MVM_ENC_USIG_VALUE_MASK(usig, data5,
+					    IWL_RX_PHY_DATA5_EHT_TYPE_AND_COMP,
+					    IEEE80211_RADIOTAP_EHT_USIG2_TB_B0_B1_PPDU_TYPE);
+		IWL_MVM_ENC_USIG_VALUE_MASK(usig, data5,
+					    IWL_RX_PHY_DATA5_EHT_TB_SPATIAL_REUSE1,
+					    IEEE80211_RADIOTAP_EHT_USIG2_TB_B3_B6_SPATIAL_REUSE_1);
+
+		IWL_MVM_ENC_USIG_VALUE_MASK(usig, data5,
+					    IWL_RX_PHY_DATA5_EHT_TB_SPATIAL_REUSE2,
+					    IEEE80211_RADIOTAP_EHT_USIG2_TB_B7_B10_SPATIAL_REUSE_2);
+	} else {
+		__le32 usig_a1 = phy_data->rx_vec[0];
+		__le32 usig_a2 = phy_data->rx_vec[1];
+
+		IWL_MVM_ENC_USIG_VALUE_MASK(usig, usig_a1,
+					    IWL_RX_USIG_A1_DISREGARD,
+					    IEEE80211_RADIOTAP_EHT_USIG1_TB_B20_B25_DISREGARD);
+		IWL_MVM_ENC_USIG_VALUE_MASK(usig, usig_a2,
+					    IWL_RX_USIG_A2_EHT_PPDU_TYPE,
+					    IEEE80211_RADIOTAP_EHT_USIG2_TB_B0_B1_PPDU_TYPE);
+		IWL_MVM_ENC_USIG_VALUE_MASK(usig, usig_a2,
+					    IWL_RX_USIG_A2_EHT_USIG2_VALIDATE_B2,
+					    IEEE80211_RADIOTAP_EHT_USIG2_TB_B2_VALIDATE);
+		IWL_MVM_ENC_USIG_VALUE_MASK(usig, usig_a2,
+					    IWL_RX_USIG_A2_EHT_TRIG_SPATIAL_REUSE_1,
+					    IEEE80211_RADIOTAP_EHT_USIG2_TB_B3_B6_SPATIAL_REUSE_1);
+		IWL_MVM_ENC_USIG_VALUE_MASK(usig, usig_a2,
+					    IWL_RX_USIG_A2_EHT_TRIG_SPATIAL_REUSE_2,
+					    IEEE80211_RADIOTAP_EHT_USIG2_TB_B7_B10_SPATIAL_REUSE_2);
+		IWL_MVM_ENC_USIG_VALUE_MASK(usig, usig_a2,
+					    IWL_RX_USIG_A2_EHT_TRIG_USIG2_DISREGARD,
+					    IEEE80211_RADIOTAP_EHT_USIG2_TB_B11_B15_DISREGARD);
+		IWL_MVM_ENC_USIG_VALUE_MASK(usig, usig_a2,
+					    IWL_RX_USIG_A2_EHT_CRC_OK,
+					    IEEE80211_RADIOTAP_EHT_USIG2_TB_B16_B19_CRC);
+	}
+}
+
 static void iwl_mvm_decode_eht_ru(struct iwl_mvm *mvm,
 				  struct ieee80211_rx_status *rx_status,
 				  struct ieee80211_radiotap_eht *eht)
@@ -1536,6 +1651,7 @@ static void iwl_mvm_decode_eht_phy_data(struct iwl_mvm *mvm,
 {
 	__le32 data0 = phy_data->d0;
 	__le32 data1 = phy_data->d1;
+	__le32 usig_a1 = phy_data->rx_vec[0];
 	u8 info_type = phy_data->info_type;
 
 	/* Not in EHT range */
@@ -1546,12 +1662,21 @@ static void iwl_mvm_decode_eht_phy_data(struct iwl_mvm *mvm,
 	usig->common |= cpu_to_le32
 		(IEEE80211_RADIOTAP_EHT_USIG_COMMON_UL_DL_KNOWN |
 		 IEEE80211_RADIOTAP_EHT_USIG_COMMON_BSS_COLOR_KNOWN);
-	usig->common |= LE32_DEC_ENC(data0,
-				     IWL_RX_PHY_DATA0_EHT_UPLINK,
-				     IEEE80211_RADIOTAP_EHT_USIG_COMMON_UL_DL);
-	usig->common |= LE32_DEC_ENC(data0,
-				     IWL_RX_PHY_DATA0_EHT_BSS_COLOR_MASK,
-				     IEEE80211_RADIOTAP_EHT_USIG_COMMON_BSS_COLOR_KNOWN);
+	if (phy_data->with_data) {
+		usig->common |= LE32_DEC_ENC(data0,
+					     IWL_RX_PHY_DATA0_EHT_UPLINK,
+					     IEEE80211_RADIOTAP_EHT_USIG_COMMON_UL_DL);
+		usig->common |= LE32_DEC_ENC(data0,
+					     IWL_RX_PHY_DATA0_EHT_BSS_COLOR_MASK,
+					     IEEE80211_RADIOTAP_EHT_USIG_COMMON_BSS_COLOR);
+	} else {
+		usig->common |= LE32_DEC_ENC(usig_a1,
+					     IWL_RX_USIG_A1_UL_FLAG,
+					     IEEE80211_RADIOTAP_EHT_USIG_COMMON_UL_DL);
+		usig->common |= LE32_DEC_ENC(usig_a1,
+					     IWL_RX_USIG_A1_BSS_COLOR,
+					     IEEE80211_RADIOTAP_EHT_USIG_COMMON_BSS_COLOR);
+	}
 
 	eht->known |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_KNOWN_SPATIAL_REUSE);
 	eht->data[0] |= LE32_DEC_ENC(data0,
@@ -1570,8 +1695,13 @@ static void iwl_mvm_decode_eht_phy_data(struct iwl_mvm *mvm,
 	iwl_mvm_decode_eht_ru(mvm, rx_status, eht);
 
 	usig->common |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_USIG_COMMON_TXOP_KNOWN);
-	usig->common |= LE32_DEC_ENC(data0, IWL_RX_PHY_DATA0_EHT_TXOP_DUR_MASK,
-				     IEEE80211_RADIOTAP_EHT_USIG_COMMON_TXOP);
+	if (phy_data->with_data)
+		usig->common |= LE32_DEC_ENC(data0, IWL_RX_PHY_DATA0_EHT_TXOP_DUR_MASK,
+					     IEEE80211_RADIOTAP_EHT_USIG_COMMON_TXOP);
+	else
+		usig->common |= LE32_DEC_ENC(usig_a1, IWL_RX_USIG_A1_TXOP_DURATION,
+					     IEEE80211_RADIOTAP_EHT_USIG_COMMON_TXOP);
+
 	eht->known |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_KNOWN_LDPC_EXTRA_SYM_OM);
 	eht->data[0] |= LE32_DEC_ENC(data0, IWL_RX_PHY_DATA0_EHT_LDPC_EXT_SYM,
 				     IEEE80211_RADIOTAP_EHT_DATA0_LDPC_EXTRA_SYM_OM);
@@ -1592,6 +1722,21 @@ static void iwl_mvm_decode_eht_phy_data(struct iwl_mvm *mvm,
 	usig->common |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_USIG_COMMON_PHY_VER_KNOWN);
 	usig->common |= LE32_DEC_ENC(data0, IWL_RX_PHY_DATA0_EHT_PHY_VER,
 				     IEEE80211_RADIOTAP_EHT_USIG_COMMON_PHY_VER);
+
+	/* TODO: what about TB - IWL_RX_PHY_DATA1_EHT_TB_PILOT_TYPE,
+				 IWL_RX_PHY_DATA1_EHT_TB_LOW_SS */
+
+	eht->known |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_KNOWN_EHT_LTF);
+	eht->data[0] |= LE32_DEC_ENC(data1, IWL_RX_PHY_DATA1_EHT_SIG_LTF_NUM,
+				     IEEE80211_RADIOTAP_EHT_DATA0_EHT_LTF);
+
+	if (info_type == IWL_RX_PHY_INFO_TYPE_EHT_TB_EXT ||
+	    info_type == IWL_RX_PHY_INFO_TYPE_EHT_TB)
+		iwl_mvm_decode_eht_ext_tb(mvm, phy_data, rx_status, eht, usig);
+
+	if (info_type == IWL_RX_PHY_INFO_TYPE_EHT_MU_EXT ||
+	    info_type == IWL_RX_PHY_INFO_TYPE_EHT_MU)
+		iwl_mvm_decode_eht_ext_mu(mvm, phy_data, rx_status, eht, usig);
 }
 
 static void iwl_mvm_rx_eht(struct iwl_mvm *mvm, struct sk_buff *skb,
@@ -2074,6 +2219,8 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		phy_data.d1 = desc->v3.phy_data1;
 		phy_data.d2 = desc->v3.phy_data2;
 		phy_data.d3 = desc->v3.phy_data3;
+		phy_data.eht_d4 = desc->phy_eht_data4;
+		phy_data.d5 = desc->v3.phy_data5;
 	} else {
 		phy_data.rate_n_flags = le32_to_cpu(desc->v1.rate_n_flags);
 		phy_data.channel = desc->v1.channel;
@@ -2103,6 +2250,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		return;
 	}
 
+	phy_data.with_data = true;
 	phy_data.phy_info = le16_to_cpu(desc->phy_info);
 	phy_data.d4 = desc->phy_data4;
 
@@ -2365,6 +2513,7 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 	phy_data.energy_a = u32_get_bits(rssi, RX_NO_DATA_CHAIN_A_MSK);
 	phy_data.energy_b = u32_get_bits(rssi, RX_NO_DATA_CHAIN_B_MSK);
 	phy_data.channel = u32_get_bits(rssi, RX_NO_DATA_CHANNEL_MSK);
+	phy_data.with_data = false;
 
 	if (iwl_fw_lookup_notif_ver(mvm->fw, DATA_PATH_GROUP,
 				    RX_NO_DATA_NOTIF, 0) < 2) {
@@ -2383,6 +2532,7 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 		    sizeof(struct iwl_rx_no_data_ver_3)))
 		/* invalid len for ver 3 */
 			return;
+		memcpy(phy_data.rx_vec, desc->rx_vec, sizeof(phy_data.rx_vec));
 	} else {
 		if (format == RATE_MCS_EHT_MSK)
 			/* no support for EHT before version 3 API */
-- 
2.38.1

