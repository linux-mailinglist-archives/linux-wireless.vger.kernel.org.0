Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64036AAF62
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Mar 2023 13:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjCEMRL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Mar 2023 07:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCEMRK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Mar 2023 07:17:10 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF65413506
        for <linux-wireless@vger.kernel.org>; Sun,  5 Mar 2023 04:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678018627; x=1709554627;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J8meIuCyRS9hPk1xCyobPefmqJE0BNXEyMVGMg9zEXs=;
  b=OH5QtzGfrakQrMkQWzuvXFMkSuzUwFQ7Z6BF3hjaf00kkFi9fSgi+56L
   LCVNEfHNQVT/RMC3sC7JOC8589lcFgbDNrpPyhRbZg8QsJF4uHBsARJSE
   iZXvoPykYIz6Qgd5lpIiX3ij28klslHwXN+qv6hmMaZe7rRZ+SwecwUMX
   7qSRItLrcSAtn+4rVna1CrfwIno0jOem7+YFn3qjVtMSIhE+PInJUCImi
   8d9sBpekxpA+kIdKyyzwebFbMa78QNfiSt9z1Mxh1QRYGbseDb0qlCuA4
   HgNRuerIdZ+K1GWDWOEP0le4wkau33OWcd1b6Vp2SMmis31LEGM58BqK6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="400193185"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="400193185"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="708355057"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="708355057"
Received: from hsaid-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.80.12])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:05 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/21] wifi: iwlwifi: mvm: add EHT radiotap info based on rate_n_flags
Date:   Sun,  5 Mar 2023 14:16:20 +0200
Message-Id: <20230305124407.b1c7d49ad35e.Ie2412ac6f88700aa3767ff95ffb52a806b13b7ce@changeid>
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

rate_n_flags is always present in the data so at least give all of
the information we can extract from rate_n_flags

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    |  24 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 133 ++++++++++++++++++
 2 files changed, 150 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
index ddacd5b45aea..1d372a09ebb4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
@@ -449,11 +449,16 @@ enum {
  *	1			2xLTF+0.8us
  *	2			2xLTF+1.6us
  *	3			4xLTF+3.2us
- * HE TRIG:
+ * HE-EHT TRIG:
  *	0			1xLTF+1.6us
  *	1			2xLTF+1.6us
  *	2			4xLTF+3.2us
  *	3			(does not occur)
+ * EHT MU:
+ *	0			2xLTF+0.8us
+ *	1			2xLTF+1.6us
+ *	2			4xLTF+0.8us
+ *	3			4xLTF+3.2us
  */
 #define RATE_MCS_HE_GI_LTF_POS		20
 #define RATE_MCS_HE_GI_LTF_MSK_V1		(3 << RATE_MCS_HE_GI_LTF_POS)
@@ -546,12 +551,17 @@ enum {
 /*
  * Bits 13-11: (0) 20MHz, (1) 40MHz, (2) 80MHz, (3) 160MHz, (4) 320MHz
  */
-#define RATE_MCS_CHAN_WIDTH_MSK			(0x7 << RATE_MCS_CHAN_WIDTH_POS)
-#define RATE_MCS_CHAN_WIDTH_20			(0 << RATE_MCS_CHAN_WIDTH_POS)
-#define RATE_MCS_CHAN_WIDTH_40			(1 << RATE_MCS_CHAN_WIDTH_POS)
-#define RATE_MCS_CHAN_WIDTH_80			(2 << RATE_MCS_CHAN_WIDTH_POS)
-#define RATE_MCS_CHAN_WIDTH_160			(3 << RATE_MCS_CHAN_WIDTH_POS)
-#define RATE_MCS_CHAN_WIDTH_320			(4 << RATE_MCS_CHAN_WIDTH_POS)
+#define RATE_MCS_CHAN_WIDTH_MSK		(0x7 << RATE_MCS_CHAN_WIDTH_POS)
+#define RATE_MCS_CHAN_WIDTH_20_VAL	0
+#define RATE_MCS_CHAN_WIDTH_20		(RATE_MCS_CHAN_WIDTH_20_VAL << RATE_MCS_CHAN_WIDTH_POS)
+#define RATE_MCS_CHAN_WIDTH_40_VAL	1
+#define RATE_MCS_CHAN_WIDTH_40		(RATE_MCS_CHAN_WIDTH_40_VAL << RATE_MCS_CHAN_WIDTH_POS)
+#define RATE_MCS_CHAN_WIDTH_80_VAL	2
+#define RATE_MCS_CHAN_WIDTH_80		(RATE_MCS_CHAN_WIDTH_80_VAL << RATE_MCS_CHAN_WIDTH_POS)
+#define RATE_MCS_CHAN_WIDTH_160_VAL	3
+#define RATE_MCS_CHAN_WIDTH_160		(RATE_MCS_CHAN_WIDTH_160_VAL << RATE_MCS_CHAN_WIDTH_POS)
+#define RATE_MCS_CHAN_WIDTH_320_VAL	4
+#define RATE_MCS_CHAN_WIDTH_320		(RATE_MCS_CHAN_WIDTH_320_VAL << RATE_MCS_CHAN_WIDTH_POS)
 
 /* Bit 15-14: Antenna selection:
  * Bit 14: Ant A active
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 48c79f665be8..57ca34341c05 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1455,6 +1455,135 @@ static void iwl_mvm_decode_he_phy_data(struct iwl_mvm *mvm,
 	}
 }
 
+static void iwl_mvm_rx_eht(struct iwl_mvm *mvm, struct sk_buff *skb,
+			   struct iwl_mvm_rx_phy_data *phy_data,
+			   int queue)
+{
+	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
+
+	struct ieee80211_radiotap_eht *eht;
+	struct ieee80211_radiotap_eht_usig *usig;
+
+	u32 rate_n_flags = phy_data->rate_n_flags;
+	u32 he_type = rate_n_flags & RATE_MCS_HE_TYPE_MSK;
+	/* EHT and HE have the same valus for LTF */
+	u8 ltf = IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE_UNKNOWN;
+	u16 phy_info = phy_data->phy_info;
+	u32 bw;
+
+	/* u32 for 1 user_info */
+	eht = iwl_mvm_radiotap_put_tlv(skb, IEEE80211_RADIOTAP_EHT,
+				       sizeof(*eht) + sizeof(u32));
+
+	usig = iwl_mvm_radiotap_put_tlv(skb, IEEE80211_RADIOTAP_EHT_USIG,
+					sizeof(*usig));
+	rx_status->flag |= RX_FLAG_RADIOTAP_TLV_AT_END;
+	usig->common |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_KNOWN);
+
+	/* specific handling for 320MHz */
+	bw = FIELD_GET(RATE_MCS_CHAN_WIDTH_MSK, rate_n_flags);
+	if (bw == RATE_MCS_CHAN_WIDTH_320_VAL)
+		bw += FIELD_GET(IWL_RX_PHY_DATA0_EHT_BW320_SLOT,
+				le32_to_cpu(phy_data->d0));
+
+	usig->common |= cpu_to_le32
+		(FIELD_PREP(IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW, bw));
+
+	/* report the AMPDU-EOF bit on single frames */
+	if (!queue && !(phy_info & IWL_RX_MPDU_PHY_AMPDU)) {
+		rx_status->flag |= RX_FLAG_AMPDU_DETAILS;
+		rx_status->flag |= RX_FLAG_AMPDU_EOF_BIT_KNOWN;
+		if (phy_data->d0 & cpu_to_le32(IWL_RX_PHY_DATA0_EHT_DELIM_EOF))
+			rx_status->flag |= RX_FLAG_AMPDU_EOF_BIT;
+	}
+
+	/* update aggregation data for monitor sake on default queue */
+	if (!queue && (phy_info & IWL_RX_MPDU_PHY_TSF_OVERLOAD) &&
+	    (phy_info & IWL_RX_MPDU_PHY_AMPDU)) {
+		bool toggle_bit = phy_info & IWL_RX_MPDU_PHY_AMPDU_TOGGLE;
+
+		/* toggle is switched whenever new aggregation starts */
+		if (toggle_bit != mvm->ampdu_toggle) {
+			rx_status->flag |= RX_FLAG_AMPDU_EOF_BIT_KNOWN;
+			if (phy_data->d0 & cpu_to_le32(IWL_RX_PHY_DATA0_EHT_DELIM_EOF))
+				rx_status->flag |= RX_FLAG_AMPDU_EOF_BIT;
+		}
+	}
+
+	/* TODO: fill usig info (phy_info & IWL_RX_MPDU_PHY_TSF_OVERLOAD) */
+
+#define CHECK_TYPE(F)							\
+	BUILD_BUG_ON(IEEE80211_RADIOTAP_HE_DATA1_FORMAT_ ## F !=	\
+		     (RATE_MCS_HE_TYPE_ ## F >> RATE_MCS_HE_TYPE_POS))
+
+	CHECK_TYPE(SU);
+	CHECK_TYPE(EXT_SU);
+	CHECK_TYPE(MU);
+	CHECK_TYPE(TRIG);
+
+	switch (FIELD_GET(RATE_MCS_HE_GI_LTF_MSK, rate_n_flags)) {
+	case 0:
+		if (he_type == RATE_MCS_HE_TYPE_TRIG) {
+			rx_status->eht.gi = NL80211_RATE_INFO_EHT_GI_1_6;
+			ltf = IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE_1X;
+		} else {
+			rx_status->eht.gi = NL80211_RATE_INFO_EHT_GI_0_8;
+			ltf = IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE_2X;
+		}
+		break;
+	case 1:
+		rx_status->eht.gi = NL80211_RATE_INFO_EHT_GI_1_6;
+		ltf = IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE_2X;
+		break;
+	case 2:
+		ltf = IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE_4X;
+		if (he_type == RATE_MCS_HE_TYPE_TRIG)
+			rx_status->eht.gi = NL80211_RATE_INFO_EHT_GI_3_2;
+		else
+			rx_status->eht.gi = NL80211_RATE_INFO_EHT_GI_0_8;
+		break;
+	case 3:
+		if (he_type != RATE_MCS_HE_TYPE_TRIG) {
+			ltf = IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE_4X;
+			rx_status->eht.gi = NL80211_RATE_INFO_EHT_GI_3_2;
+		}
+		break;
+	default:
+		/* nothing here */
+		break;
+	}
+
+	if (ltf != IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE_UNKNOWN) {
+		eht->known |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_KNOWN_GI);
+		eht->data[0] |= cpu_to_le32
+			(FIELD_PREP(IEEE80211_RADIOTAP_EHT_DATA0_LTF,
+				    ltf) |
+			 FIELD_PREP(IEEE80211_RADIOTAP_EHT_DATA0_GI,
+				    rx_status->eht.gi));
+	}
+
+	eht->user_info[0] |= cpu_to_le32
+		(IEEE80211_RADIOTAP_EHT_USER_INFO_MCS_KNOWN |
+		 IEEE80211_RADIOTAP_EHT_USER_INFO_CODING_KNOWN |
+		 IEEE80211_RADIOTAP_EHT_USER_INFO_NSS_KNOWN_O |
+		 IEEE80211_RADIOTAP_EHT_USER_INFO_BEAMFORMING_KNOWN_O |
+		 IEEE80211_RADIOTAP_EHT_USER_INFO_DATA_FOR_USER);
+
+	if (rate_n_flags & RATE_MCS_BF_MSK)
+		eht->user_info[0] |=
+			cpu_to_le32(IEEE80211_RADIOTAP_EHT_USER_INFO_BEAMFORMING_O);
+
+	if (rate_n_flags & RATE_MCS_LDPC_MSK)
+		eht->user_info[0] |=
+			cpu_to_le32(IEEE80211_RADIOTAP_EHT_USER_INFO_CODING);
+
+	eht->user_info[0] |= cpu_to_le32
+		(FIELD_PREP(IEEE80211_RADIOTAP_EHT_USER_INFO_MCS,
+			    FIELD_GET(RATE_VHT_MCS_RATE_CODE_MSK, rate_n_flags)) |
+		 FIELD_PREP(IEEE80211_RADIOTAP_EHT_USER_INFO_NSS_O,
+			    FIELD_GET(RATE_MCS_NSS_MSK, rate_n_flags)));
+}
+
 static void iwl_mvm_rx_he(struct iwl_mvm *mvm, struct sk_buff *skb,
 			  struct iwl_mvm_rx_phy_data *phy_data,
 			  int queue)
@@ -1702,6 +1831,10 @@ static void iwl_mvm_rx_fill_status(struct iwl_mvm *mvm,
 	iwl_mvm_get_signal_strength(mvm, rx_status, rate_n_flags,
 				    phy_data->energy_a, phy_data->energy_b);
 
+	/* using TLV format and must be after all fixed len fields */
+	if (format == RATE_MCS_EHT_MSK)
+		iwl_mvm_rx_eht(mvm, skb, phy_data, queue);
+
 	if (unlikely(mvm->monitor_on))
 		iwl_mvm_add_rtap_sniffer_config(mvm, skb);
 
-- 
2.38.1

