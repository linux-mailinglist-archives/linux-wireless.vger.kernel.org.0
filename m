Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A139B67D892
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jan 2023 23:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbjAZWgu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Jan 2023 17:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbjAZWgk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Jan 2023 17:36:40 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8CC1814C
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jan 2023 14:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674772597; x=1706308597;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r3uBJmsKcMaAtwIb3HKTv5BFq6EqtA+EnNULatbL6Yo=;
  b=PMzRBPsrYfMc58y4EyGRW/gMG7rTvYcEI8WIFnCokqeY+mZgcHL0+f0k
   k+ivYvCydNkAUTOtwHCqP8tF6Tt7L1YozmmfKWKGas2d77wFujoadm5P9
   8VffEDf+kPuYDxewQ9rM78XBtCivve2fzxXaDUseKuswtCLEFYV+oFWKA
   iyz4U7geEjPx5Hr5VCGjeSFlngkvso1e8i/CKU+BnpJSRaBz8TZDZmtD8
   F7ZVQG2jUS1Js/3wIHwBsYcA5cXbw0oc1us34hhMGrJ4BDLxXGbpjumKm
   4k2eaYqX+c6D/QwTojdQDTJXeycUzXpFpGCqj4ytycIBfkIiWc4o7mjhS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="329098676"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="329098676"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:29:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="612986269"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="612986269"
Received: from razgilad-mobl7.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.211.193])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:29:17 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/12] wifi: iwlwifi: mvm: add sniffer meta data APIs
Date:   Fri, 27 Jan 2023 00:28:16 +0200
Message-Id: <20230127002430.6729c0be66aa.I95ad94d5e137ec80010facd8ee57cd40461a0721@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230126222821.305122-1-gregory.greenman@intel.com>
References: <20230126222821.305122-1-gregory.greenman@intel.com>
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

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

We add TSF overwrite for EHT MU/TB high and low, and add definitions
for EHT Data 5 meta data.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    | 119 ++++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |   4 +
 2 files changed, 112 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index ffa9f3409a9b..1c4e84932058 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -273,7 +273,7 @@ enum iwl_rx_mpdu_mac_info {
 };
 
 /* TSF overload low dword */
-enum iwl_rx_phy_data0 {
+enum iwl_rx_phy_he_data0 {
 	/* info type: HE any */
 	IWL_RX_PHY_DATA0_HE_BEAM_CHNG				= 0x00000001,
 	IWL_RX_PHY_DATA0_HE_UPLINK				= 0x00000002,
@@ -289,6 +289,25 @@ enum iwl_rx_phy_data0 {
 	IWL_RX_PHY_DATA0_HE_DELIM_EOF				= 0x80000000,
 };
 
+/* TSF overload low dword */
+enum iwl_rx_phy_eht_data0 {
+	/* info type: EHT any */
+	/* 1 bits reserved */
+	IWL_RX_PHY_DATA0_EHT_UPLINK				= BIT(1),
+	IWL_RX_PHY_DATA0_EHT_BSS_COLOR_MASK			= 0x000000fc,
+	IWL_RX_PHY_DATA0_ETH_SPATIAL_REUSE_MASK			= 0x00000f00,
+	IWL_RX_PHY_DATA0_EHT_PS160				= BIT(12),
+	IWL_RX_PHY_DATA0_EHT_TXOP_DUR_MASK			= 0x000fe000,
+	IWL_RX_PHY_DATA0_EHT_LDPC_EXT_SYM			= BIT(20),
+	IWL_RX_PHY_DATA0_EHT_PRE_FEC_PAD_MASK			= 0x00600000,
+	IWL_RX_PHY_DATA0_EHT_PE_DISAMBIG			= BIT(23),
+	IWL_RX_PHY_DATA0_EHT_BW320_SLOT				= BIT(24),
+	IWL_RX_PHY_DATA0_EHT_SIGA_CRC_OK			= BIT(25),
+	IWL_RX_PHY_DATA0_EHT_PHY_VER				= 0x1c000000,
+	/* 2 bits reserved */
+	IWL_RX_PHY_DATA0_EHT_DELIM_EOF				= BIT(31),
+};
+
 enum iwl_rx_phy_info_type {
 	IWL_RX_PHY_INFO_TYPE_NONE				= 0,
 	IWL_RX_PHY_INFO_TYPE_CCK				= 1,
@@ -301,19 +320,26 @@ enum iwl_rx_phy_info_type {
 	IWL_RX_PHY_INFO_TYPE_HE_TB				= 8,
 	IWL_RX_PHY_INFO_TYPE_HE_MU_EXT				= 9,
 	IWL_RX_PHY_INFO_TYPE_HE_TB_EXT				= 10,
+	IWL_RX_PHY_INFO_TYPE_EHT_MU				= 11,
+	IWL_RX_PHY_INFO_TYPE_EHT_TB				= 12,
+	IWL_RX_PHY_INFO_TYPE_EHT_MU_EXT				= 13,
+	IWL_RX_PHY_INFO_TYPE_EHT_TB_EXT				= 14,
 };
 
 /* TSF overload high dword */
-enum iwl_rx_phy_data1 {
+enum iwl_rx_phy_common_data1 {
 	/*
 	 * check this first - if TSF overload is set,
 	 * see &enum iwl_rx_phy_info_type
 	 */
 	IWL_RX_PHY_DATA1_INFO_TYPE_MASK				= 0xf0000000,
 
-	/* info type: HT/VHT/HE any */
+	/* info type: HT/VHT/HE/EHT any */
 	IWL_RX_PHY_DATA1_LSIG_LEN_MASK				= 0x0fff0000,
+};
 
+/* TSF overload high dword For HE rates*/
+enum iwl_rx_phy_he_data1 {
 	/* info type: HE MU/MU-EXT */
 	IWL_RX_PHY_DATA1_HE_MU_SIGB_COMPRESSION			= 0x00000001,
 	IWL_RX_PHY_DATA1_HE_MU_SIBG_SYM_OR_USER_NUM_MASK	= 0x0000001e,
@@ -329,8 +355,23 @@ enum iwl_rx_phy_data1 {
 	IWL_RX_PHY_DATA1_HE_TB_LOW_SS_MASK			= 0x0000000e,
 };
 
+/* TSF overload high dword For EHT-MU/TB rates*/
+enum iwl_rx_phy_eht_data1 {
+	/* info type: EHT-MU */
+	IWL_RX_PHY_DATA1_EHT_MU_NUM_SIG_SYM_USIGA2	= 0x0000001f,
+	/* info type: EHT-TB */
+	IWL_RX_PHY_DATA1_EHT_TB_PILOT_TYPE		= BIT(0),
+	IWL_RX_PHY_DATA1_EHT_TB_LOW_SS			= 0x0000001e,
+
+	/* info type: EHT any */
+	/* number of EHT-LTF symbols 0 - 1 EHT-LTF, 1 - 2 EHT-LTFs, 2 - 4 EHT-LTFs,
+	 * 3 - 6 EHT-LTFs, 4 - 8 EHT-LTFs */
+	IWL_RX_PHY_DATA1_EHT_SIG_LTF_NUM		= 0x000000e0,
+	IWL_RX_PHY_DATA1_EHT_RU_ALLOC			= 0x0000ff00,
+};
+
 /* goes into Metadata DW 7 */
-enum iwl_rx_phy_data2 {
+enum iwl_rx_phy_he_data2 {
 	/* info type: HE MU-EXT */
 	/* the a1/a2/... is what the PHY/firmware calls the values */
 	IWL_RX_PHY_DATA2_HE_MU_EXT_CH1_RU0		= 0x000000ff, /* a1 */
@@ -346,7 +387,7 @@ enum iwl_rx_phy_data2 {
 };
 
 /* goes into Metadata DW 8 */
-enum iwl_rx_phy_data3 {
+enum iwl_rx_phy_he_data3 {
 	/* info type: HE MU-EXT */
 	IWL_RX_PHY_DATA3_HE_MU_EXT_CH1_RU1		= 0x000000ff, /* c1 */
 	IWL_RX_PHY_DATA3_HE_MU_EXT_CH1_RU3		= 0x0000ff00, /* c2 */
@@ -355,7 +396,7 @@ enum iwl_rx_phy_data3 {
 };
 
 /* goes into Metadata DW 4 high 16 bits */
-enum iwl_rx_phy_data4 {
+enum iwl_rx_phy_he_he_data4 {
 	/* info type: HE MU-EXT */
 	IWL_RX_PHY_DATA4_HE_MU_EXT_CH1_CTR_RU			= 0x0001,
 	IWL_RX_PHY_DATA4_HE_MU_EXT_CH2_CTR_RU			= 0x0002,
@@ -366,6 +407,51 @@ enum iwl_rx_phy_data4 {
 	IWL_RX_PHY_DATA4_HE_MU_EXT_PREAMBLE_PUNC_TYPE_MASK	= 0x0600,
 };
 
+/* goes into Metadata DW 7 */
+enum iwl_rx_phy_eht_data2 {
+	/* info type: EHT-MU-EXT */
+	/* OFDM_RX_VECTOR_COMMON_RU_ALLOC_0_OUT */
+	IWL_RX_PHY_DATA2_EHT_MU_EXT_RU_ALLOC_A1	= 0x000001ff,
+	IWL_RX_PHY_DATA2_EHT_MU_EXT_RU_ALLOC_A2	= 0x0003fe00,
+	IWL_RX_PHY_DATA2_EHT_MU_EXT_RU_ALLOC_A3	= 0x01fc0000,
+
+	/* info type: EHT-TB-EXT */
+	IWL_RX_PHY_DATA2_EHT_TB_EXT_TRIG_SIGA1	= 0xffffffff,
+};
+
+/* goes into Metadata DW 8 */
+enum iwl_rx_phy_eht_data3 {
+	/* info type: EHT-MU-EXT */
+	/* OFDM_RX_VECTOR_COMMON_RU_ALLOC_1_OUT */
+	IWL_RX_PHY_DATA3_EHT_MU_EXT_RU_ALLOC_B1	= 0x000001ff,
+	IWL_RX_PHY_DATA3_EHT_MU_EXT_RU_ALLOC_B2	= 0x0003fe00,
+	IWL_RX_PHY_DATA3_EHT_MU_EXT_RU_ALLOC_B3	= 0x01fc0000,
+};
+
+/* goes into Metadata DW 4 */
+enum iwl_rx_phy_eht_data4 {
+	/* info type: EHT-MU-EXT */
+	/* OFDM_RX_VECTOR_COMMON_RU_ALLOC_2_OUT */
+	IWL_RX_PHY_DATA4_EHT_MU_EXT_RU_ALLOC_C1	= 0x000001ff,
+	IWL_RX_PHY_DATA4_EHT_MU_EXT_RU_ALLOC_C2	= 0x0003fe00,
+	IWL_RX_PHY_DATA4_EHT_MU_EXT_RU_ALLOC_C3	= 0x01fc0000,
+	IWL_RX_PHY_DATA4_EHT_MU_EXT_SIGB_MCS	= 0x18000000,
+};
+
+/* goes into Metadata DW 16 */
+enum iwl_rx_phy_data5 {
+	/* info type: EHT any */
+	IWL_RX_PHY_DATA5_EHT_TYPE_AND_COMP		= 0x00000003,
+	/* info type: EHT-TB */
+	IWL_RX_PHY_DATA5_EHT_TB_SPATIAL_REUSE1		= 0x0000003c,
+	IWL_RX_PHY_DATA5_EHT_TB_SPATIAL_REUSE2		= 0x000003c0,
+	/* info type: EHT-MU */
+	IWL_RX_PHY_DATA5_EHT_MU_PUNC_CH_CODE		= 0x0000007c,
+	IWL_RX_PHY_DATA5_EHT_MU_STA_ID_USR		= 0x0003ff80,
+	IWL_RX_PHY_DATA5_EHT_MU_NUM_USR_NON_OFDMA	= 0x001c0000,
+	IWL_RX_PHY_DATA5_EHT_MU_SPATIAL_CONF_USR_FIELD	= 0x0fe00000,
+};
+
 /**
  * struct iwl_rx_mpdu_desc_v1 - RX MPDU descriptor
  */
@@ -440,7 +526,9 @@ struct iwl_rx_mpdu_desc_v1 {
 			/**
 			 * @phy_data1: valid only if
 			 * %IWL_RX_MPDU_PHY_TSF_OVERLOAD is set,
-			 * see &enum iwl_rx_phy_data1.
+			 * see &enum iwl_rx_phy_common_data1 or
+			 *     &enum iwl_rx_phy_he_data1 or
+			 *     &enum iwl_rx_phy_eht_data1.
 			 */
 			__le32 phy_data1;
 		};
@@ -540,11 +628,18 @@ struct iwl_rx_mpdu_desc_v3 {
 			__le32 phy_data1;
 		};
 	};
-	/* DW16 & DW17 */
+	/* DW16 */
+	/**
+	 * @phy_data5: valid only if
+	 * %IWL_RX_MPDU_PHY_TSF_OVERLOAD is set,
+	 * see &enum iwl_rx_phy_data5.
+	 */
+	__le32 phy_data5;
+	/* DW17 */
 	/**
 	 * @reserved: reserved
 	 */
-	__le32 reserved[2];
+	__le32 reserved[1];
 } __packed; /* RX_MPDU_RES_START_API_S_VER_3,
 	       RX_MPDU_RES_START_API_S_VER_5 */
 
@@ -639,6 +734,7 @@ struct iwl_rx_mpdu_desc {
 #define RX_NO_DATA_INFO_ERR_UNSUPPORTED_RATE	2
 #define RX_NO_DATA_INFO_ERR_NO_DELIM		3
 #define RX_NO_DATA_INFO_ERR_BAD_MAC_HDR	4
+#define RX_NO_DATA_INFO_LOW_ENERGY		5
 
 #define RX_NO_DATA_FRAME_TIME_POS	0
 #define RX_NO_DATA_FRAME_TIME_MSK	(0xfffff << RX_NO_DATA_FRAME_TIME_POS)
@@ -655,7 +751,8 @@ struct iwl_rx_mpdu_desc {
  * @on_air_rise_time: GP2 during on air rise
  * @fr_time: frame time
  * @rate: rate/mcs of frame
- * @phy_info: &enum iwl_rx_phy_data0 and &enum iwl_rx_phy_info_type
+ * @phy_info: &enum iwl_rx_phy_he_data0 or &enum iwl_rx_phy_eht_data0
+ *	      based on &enum iwl_rx_phy_info_type
  * @rx_vec: DW-12:9 raw RX vectors from DSP according to modulation type.
  *	for VHT: OFDM_RX_VECTOR_SIGA1_OUT, OFDM_RX_VECTOR_SIGA2_OUT
  *	for HE: OFDM_RX_VECTOR_HE_SIGA1_OUT, OFDM_RX_VECTOR_HE_SIGA2_OUT
@@ -679,7 +776,7 @@ struct iwl_rx_no_data {
  * @on_air_rise_time: GP2 during on air rise
  * @fr_time: frame time
  * @rate: rate/mcs of frame
- * @phy_info: &enum iwl_rx_phy_data0 and &enum iwl_rx_phy_info_type
+ * @phy_info: &enum iwl_rx_phy_eht_data0 and &enum iwl_rx_phy_info_type
  * @rx_vec: DW-12:9 raw RX vectors from DSP according to modulation type.
  *	for VHT: OFDM_RX_VECTOR_SIGA1_OUT, OFDM_RX_VECTOR_SIGA2_OUT
  *	for HE: OFDM_RX_VECTOR_HE_SIGA1_OUT, OFDM_RX_VECTOR_HE_SIGA2_OUT
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 6048f5e2f8a7..83e2be64b33f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1347,6 +1347,10 @@ static void iwl_mvm_decode_he_phy_data(struct iwl_mvm *mvm,
 	case IWL_RX_PHY_INFO_TYPE_HT:
 	case IWL_RX_PHY_INFO_TYPE_VHT_SU:
 	case IWL_RX_PHY_INFO_TYPE_VHT_MU:
+	case IWL_RX_PHY_INFO_TYPE_EHT_MU:
+	case IWL_RX_PHY_INFO_TYPE_EHT_TB:
+	case IWL_RX_PHY_INFO_TYPE_EHT_MU_EXT:
+	case IWL_RX_PHY_INFO_TYPE_EHT_TB_EXT:
 		return;
 	case IWL_RX_PHY_INFO_TYPE_HE_TB_EXT:
 		he->data1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE_KNOWN |
-- 
2.38.1

