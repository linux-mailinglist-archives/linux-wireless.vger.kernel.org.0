Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0736AAF6F
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Mar 2023 13:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjCEMRx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Mar 2023 07:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjCEMRw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Mar 2023 07:17:52 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BB112840
        for <linux-wireless@vger.kernel.org>; Sun,  5 Mar 2023 04:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678018663; x=1709554663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wce8sTva/esIiwAm+b5BgtJSOamPCIFjTyhR/w1h2k4=;
  b=YUiRGnlaRjMwkATsxhJQiF0GllVAZWHos6wbgFWO5vv0udAuPRSn1Gud
   8BmqfkgcIjHRBfoORV8lf8NtlDsZthBI2G1cfZEdkxqRNFUC3g1U5z7X7
   QF4Bi9qY0XCtXeUelrFVospJ8KfZm0wbrqGxsgGlqFbefQY2mdiY6dV7D
   Dnm50CweJmBeMx8AM7V4hxpa0LPdv+YRSjAgfi1A328YF8BEGU9w5B45J
   6D6Y6dJOdsfWsKT93rXJFSKbDcN0iiZtJjsg89Y+rV7KEZMFRH4l8j3ET
   xrRmwvH/Vz7CWTVqqFYAxm1j2Q7HCZZemNW1ELTPCc30h75hgbgj6T1Ge
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="400193291"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="400193291"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="708355221"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="708355221"
Received: from hsaid-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.80.12])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:39 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 19/21] wifi: iwlwifi: mvm: add EHT - RU allocation to radiotap TLV
Date:   Sun,  5 Mar 2023 14:16:33 +0200
Message-Id: <20230305124407.b16acaa4bad1.I53afa03058dbd2cd8afbaf5e82596c8ed501a476@changeid>
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

FW new API added the info missing for update RU allocation,
so use the new API to update radiotap information.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    | 15 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 90 ++++++++++++++++++-
 2 files changed, 95 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index 97e946e70279..fdd8b01f09e4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -414,7 +414,7 @@ enum iwl_rx_phy_eht_data2 {
 	/* OFDM_RX_VECTOR_COMMON_RU_ALLOC_0_OUT */
 	IWL_RX_PHY_DATA2_EHT_MU_EXT_RU_ALLOC_A1	= 0x000001ff,
 	IWL_RX_PHY_DATA2_EHT_MU_EXT_RU_ALLOC_A2	= 0x0003fe00,
-	IWL_RX_PHY_DATA2_EHT_MU_EXT_RU_ALLOC_A3	= 0x01fc0000,
+	IWL_RX_PHY_DATA2_EHT_MU_EXT_RU_ALLOC_B1	= 0x07fc0000,
 
 	/* info type: EHT-TB-EXT */
 	IWL_RX_PHY_DATA2_EHT_TB_EXT_TRIG_SIGA1	= 0xffffffff,
@@ -424,19 +424,18 @@ enum iwl_rx_phy_eht_data2 {
 enum iwl_rx_phy_eht_data3 {
 	/* info type: EHT-MU-EXT */
 	/* OFDM_RX_VECTOR_COMMON_RU_ALLOC_1_OUT */
-	IWL_RX_PHY_DATA3_EHT_MU_EXT_RU_ALLOC_B1	= 0x000001ff,
-	IWL_RX_PHY_DATA3_EHT_MU_EXT_RU_ALLOC_B2	= 0x0003fe00,
-	IWL_RX_PHY_DATA3_EHT_MU_EXT_RU_ALLOC_B3	= 0x01fc0000,
+	IWL_RX_PHY_DATA3_EHT_MU_EXT_RU_ALLOC_B2	= 0x000001ff,
+	IWL_RX_PHY_DATA3_EHT_MU_EXT_RU_ALLOC_C1	= 0x0003fe00,
+	IWL_RX_PHY_DATA3_EHT_MU_EXT_RU_ALLOC_C2	= 0x07fc0000,
 };
 
 /* goes into Metadata DW 4 */
 enum iwl_rx_phy_eht_data4 {
 	/* info type: EHT-MU-EXT */
 	/* OFDM_RX_VECTOR_COMMON_RU_ALLOC_2_OUT */
-	IWL_RX_PHY_DATA4_EHT_MU_EXT_RU_ALLOC_C1	= 0x000001ff,
-	IWL_RX_PHY_DATA4_EHT_MU_EXT_RU_ALLOC_C2	= 0x0003fe00,
-	IWL_RX_PHY_DATA4_EHT_MU_EXT_RU_ALLOC_C3	= 0x01fc0000,
-	IWL_RX_PHY_DATA4_EHT_MU_EXT_SIGB_MCS	= 0x18000000,
+	IWL_RX_PHY_DATA4_EHT_MU_EXT_RU_ALLOC_D1	= 0x000001ff,
+	IWL_RX_PHY_DATA4_EHT_MU_EXT_RU_ALLOC_D2	= 0x0003fe00,
+	IWL_RX_PHY_DATA4_EHT_MU_EXT_SIGB_MCS	= 0x000c0000,
 };
 
 /* goes into Metadata DW 16 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index d866fa534be5..a54548f1e940 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1467,17 +1467,54 @@ static void iwl_mvm_decode_he_phy_data(struct iwl_mvm *mvm,
 	(_usig)->value |= LE32_DEC_ENC(in_value, dec_bits, _enc_bits); \
 } while (0)
 
+#define __IWL_MVM_ENC_EHT_RU(rt_data, rt_ru, fw_data, fw_ru) \
+	eht->data[(rt_data)] |= \
+		(cpu_to_le32 \
+		 (IEEE80211_RADIOTAP_EHT_DATA ## rt_data ## _RU_ALLOC_CC_ ## rt_ru ## _KNOWN) | \
+		 LE32_DEC_ENC(data ## fw_data, \
+			      IWL_RX_PHY_DATA ## fw_data ## _EHT_MU_EXT_RU_ALLOC_ ## fw_ru, \
+			      IEEE80211_RADIOTAP_EHT_DATA ## rt_data ## _RU_ALLOC_CC_ ## rt_ru))
+
+#define _IWL_MVM_ENC_EHT_RU(rt_data, rt_ru, fw_data, fw_ru)	\
+	__IWL_MVM_ENC_EHT_RU(rt_data, rt_ru, fw_data, fw_ru)
+
+#define IEEE80211_RADIOTAP_RU_DATA_1_1_1	1
+#define IEEE80211_RADIOTAP_RU_DATA_2_1_1	2
+#define IEEE80211_RADIOTAP_RU_DATA_1_1_2	2
+#define IEEE80211_RADIOTAP_RU_DATA_2_1_2	2
+#define IEEE80211_RADIOTAP_RU_DATA_1_2_1	3
+#define IEEE80211_RADIOTAP_RU_DATA_2_2_1	3
+#define IEEE80211_RADIOTAP_RU_DATA_1_2_2	3
+#define IEEE80211_RADIOTAP_RU_DATA_2_2_2	4
+
+#define IWL_RX_RU_DATA_A1			2
+#define IWL_RX_RU_DATA_A2			2
+#define IWL_RX_RU_DATA_B1			2
+#define IWL_RX_RU_DATA_B2			3
+#define IWL_RX_RU_DATA_C1			3
+#define IWL_RX_RU_DATA_C2			3
+#define IWL_RX_RU_DATA_D1			4
+#define IWL_RX_RU_DATA_D2			4
+
+#define IWL_MVM_ENC_EHT_RU(rt_ru, fw_ru)				\
+	_IWL_MVM_ENC_EHT_RU(IEEE80211_RADIOTAP_RU_DATA_ ## rt_ru,	\
+			    rt_ru,					\
+			    IWL_RX_RU_DATA_ ## fw_ru,			\
+			    fw_ru)
+
 static void iwl_mvm_decode_eht_ext_mu(struct iwl_mvm *mvm,
 				      struct iwl_mvm_rx_phy_data *phy_data,
 				      struct ieee80211_rx_status *rx_status,
 				      struct ieee80211_radiotap_eht *eht,
 				      struct ieee80211_radiotap_eht_usig *usig)
 {
-	__le32 data1 = phy_data->d1;
-
 	if (phy_data->with_data) {
+		__le32 data1 = phy_data->d1;
+		__le32 data2 = phy_data->d2;
+		__le32 data3 = phy_data->d3;
 		__le32 data4 = phy_data->eht_d4;
 		__le32 data5 = phy_data->d5;
+		u32 phy_bw = phy_data->rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK;
 
 		IWL_MVM_ENC_USIG_VALUE_MASK(usig, data5,
 					    IWL_RX_PHY_DATA5_EHT_TYPE_AND_COMP,
@@ -1492,6 +1529,55 @@ static void iwl_mvm_decode_eht_ext_mu(struct iwl_mvm *mvm,
 			(usig, data1, IWL_RX_PHY_DATA1_EHT_MU_NUM_SIG_SYM_USIGA2,
 			 IEEE80211_RADIOTAP_EHT_USIG2_MU_B11_B15_EHT_SIG_SYMBOLS);
 
+		eht->user_info[0] |=
+			cpu_to_le32(IEEE80211_RADIOTAP_EHT_USER_INFO_STA_ID_KNOWN) |
+			LE32_DEC_ENC(data5, IWL_RX_PHY_DATA5_EHT_MU_STA_ID_USR,
+				     IEEE80211_RADIOTAP_EHT_USER_INFO_STA_ID);
+
+		eht->known |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_KNOWN_NR_NON_OFDMA_USERS_M);
+		eht->data[7] |= LE32_DEC_ENC
+			(data5, IWL_RX_PHY_DATA5_EHT_MU_NUM_USR_NON_OFDMA,
+			 IEEE80211_RADIOTAP_EHT_DATA7_NUM_OF_NON_OFDMA_USERS);
+
+		/*
+		 * Hardware labels the content channels/RU allocation values
+		 * as follows:
+		 *           Content Channel 1		Content Channel 2
+		 *   20 MHz: A1
+		 *   40 MHz: A1				B1
+		 *   80 MHz: A1 C1			B1 D1
+		 *  160 MHz: A1 C1 A2 C2		B1 D1 B2 D2
+		 *  320 MHz: A1 C1 A2 C2 A3 C3 A4 C4	B1 D1 B2 D2 B3 D3 B4 D4
+		 *
+		 * However firmware can only give us A1-D2, so the higher
+		 * frequencies are missing.
+		 */
+
+		switch (phy_bw) {
+		case RATE_MCS_CHAN_WIDTH_320:
+			/* additional values are missing in RX metadata */
+		case RATE_MCS_CHAN_WIDTH_160:
+			/* content channel 1 */
+			IWL_MVM_ENC_EHT_RU(1_2_1, A2);
+			IWL_MVM_ENC_EHT_RU(1_2_2, C2);
+			/* content channel 2 */
+			IWL_MVM_ENC_EHT_RU(2_2_1, B2);
+			IWL_MVM_ENC_EHT_RU(2_2_2, D2);
+			fallthrough;
+		case RATE_MCS_CHAN_WIDTH_80:
+			/* content channel 1 */
+			IWL_MVM_ENC_EHT_RU(1_1_2, C1);
+			/* content channel 2 */
+			IWL_MVM_ENC_EHT_RU(2_1_2, D1);
+			fallthrough;
+		case RATE_MCS_CHAN_WIDTH_40:
+			/* content channel 2 */
+			IWL_MVM_ENC_EHT_RU(2_1_1, B1);
+			fallthrough;
+		case RATE_MCS_CHAN_WIDTH_20:
+			IWL_MVM_ENC_EHT_RU(1_1_1, A1);
+			break;
+		}
 	} else {
 		__le32 usig_a1 = phy_data->rx_vec[0];
 		__le32 usig_a2 = phy_data->rx_vec[1];
-- 
2.38.1

