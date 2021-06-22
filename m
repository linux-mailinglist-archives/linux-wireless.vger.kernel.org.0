Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3920D3B0B84
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 19:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhFVRiD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Jun 2021 13:38:03 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:56575 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230338AbhFVRiD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Jun 2021 13:38:03 -0400
X-UUID: a8251cd280074773a468bceb8f2488f4-20210623
X-UUID: a8251cd280074773a468bceb8f2488f4-20210623
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1545669604; Wed, 23 Jun 2021 01:35:42 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Jun 2021 01:35:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Jun 2021 01:35:41 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: mt7915: report HE MU radiotap
Date:   Wed, 23 Jun 2021 01:35:39 +0800
Message-ID: <5817c4efc0d8cfee10d5090f170f641458db282b.1624344033.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Report HE MU/BF radiotap.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 66 +++++++++++++++----
 .../net/wireless/mediatek/mt76/mt7915/mac.h   |  8 +++
 2 files changed, 63 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 2462704094b0..47f042313341 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -228,12 +228,54 @@ mt7915_mac_decode_he_radiotap_ru(struct mt76_rx_status *status,
 				      IEEE80211_RADIOTAP_HE_DATA2_RU_OFFSET);
 }
 
+static void
+mt7915_mac_decode_he_mu_radiotap(struct sk_buff *skb,
+				 struct mt76_rx_status *status,
+				 __le32 *rxv)
+{
+	static const struct ieee80211_radiotap_he_mu mu_known = {
+		.flags1 = HE_BITS(MU_FLAGS1_SIG_B_MCS_KNOWN) |
+			  HE_BITS(MU_FLAGS1_SIG_B_DCM_KNOWN) |
+			  HE_BITS(MU_FLAGS1_CH1_RU_KNOWN) |
+			  HE_BITS(MU_FLAGS1_SIG_B_SYMS_USERS_KNOWN),
+		.flags2 = HE_BITS(MU_FLAGS2_BW_FROM_SIG_A_BW_KNOWN),
+	};
+	struct ieee80211_radiotap_he_mu *he_mu = NULL;
+
+	he_mu = skb_push(skb, sizeof(mu_known));
+	memcpy(he_mu, &mu_known, sizeof(mu_known));
+
+#define MU_PREP(f, v)	le16_encode_bits(v, IEEE80211_RADIOTAP_HE_MU_##f)
+
+	he_mu->flags1 |= MU_PREP(FLAGS1_SIG_B_MCS, status->rate_idx);
+	if (status->he_dcm)
+		he_mu->flags1 |= MU_PREP(FLAGS1_SIG_B_DCM, status->he_dcm);
+
+	he_mu->flags2 |= MU_PREP(FLAGS2_BW_FROM_SIG_A_BW, status->bw) |
+			 MU_PREP(FLAGS2_SIG_B_SYMS_USERS,
+				 le32_get_bits(rxv[2], MT_CRXV_HE_NUM_USER));
+
+	he_mu->ru_ch1[0] = FIELD_GET(MT_CRXV_HE_RU0, cpu_to_le32(rxv[3]));
+
+	if (status->bw >= RATE_INFO_BW_40) {
+		he_mu->flags1 |= HE_BITS(MU_FLAGS1_CH2_RU_KNOWN);
+		he_mu->ru_ch2[0] =
+			FIELD_GET(MT_CRXV_HE_RU1, cpu_to_le32(rxv[3]));
+	}
+
+	if (status->bw >= RATE_INFO_BW_80) {
+		he_mu->ru_ch1[1] =
+			FIELD_GET(MT_CRXV_HE_RU2, cpu_to_le32(rxv[3]));
+		he_mu->ru_ch2[1] =
+			FIELD_GET(MT_CRXV_HE_RU3, cpu_to_le32(rxv[3]));
+	}
+}
+
 static void
 mt7915_mac_decode_he_radiotap(struct sk_buff *skb,
 			      struct mt76_rx_status *status,
 			      __le32 *rxv, u32 phy)
 {
-	/* TODO: struct ieee80211_radiotap_he_mu */
 	static const struct ieee80211_radiotap_he known = {
 		.data1 = HE_BITS(DATA1_DATA_MCS_KNOWN) |
 			 HE_BITS(DATA1_DATA_DCM_KNOWN) |
@@ -241,6 +283,7 @@ mt7915_mac_decode_he_radiotap(struct sk_buff *skb,
 			 HE_BITS(DATA1_CODING_KNOWN) |
 			 HE_BITS(DATA1_LDPC_XSYMSEG_KNOWN) |
 			 HE_BITS(DATA1_DOPPLER_KNOWN) |
+			 HE_BITS(DATA1_SPTL_REUSE_KNOWN) |
 			 HE_BITS(DATA1_BSS_COLOR_KNOWN),
 		.data2 = HE_BITS(DATA2_GI_KNOWN) |
 			 HE_BITS(DATA2_TXBF_KNOWN) |
@@ -255,9 +298,12 @@ mt7915_mac_decode_he_radiotap(struct sk_buff *skb,
 
 	he->data3 = HE_PREP(DATA3_BSS_COLOR, BSS_COLOR, rxv[14]) |
 		    HE_PREP(DATA3_LDPC_XSYMSEG, LDPC_EXT_SYM, rxv[2]);
+	he->data4 = HE_PREP(DATA4_SU_MU_SPTL_REUSE, SR_MASK, rxv[11]);
 	he->data5 = HE_PREP(DATA5_PE_DISAMBIG, PE_DISAMBIG, rxv[2]) |
 		    le16_encode_bits(ltf_size,
 				     IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE);
+	if (cpu_to_le32(rxv[0]) & MT_PRXV_TXBF)
+		he->data5 |= HE_BITS(DATA5_TXBF);
 	he->data6 = HE_PREP(DATA6_TXOP, TXOP_DUR, rxv[14]) |
 		    HE_PREP(DATA6_DOPPLER, DOPPLER, rxv[14]);
 
@@ -265,12 +311,10 @@ mt7915_mac_decode_he_radiotap(struct sk_buff *skb,
 	case MT_PHY_TYPE_HE_SU:
 		he->data1 |= HE_BITS(DATA1_FORMAT_SU) |
 			     HE_BITS(DATA1_UL_DL_KNOWN) |
-			     HE_BITS(DATA1_BEAM_CHANGE_KNOWN) |
-			     HE_BITS(DATA1_SPTL_REUSE_KNOWN);
+			     HE_BITS(DATA1_BEAM_CHANGE_KNOWN);
 
 		he->data3 |= HE_PREP(DATA3_BEAM_CHANGE, BEAM_CHNG, rxv[14]) |
 			     HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
-		he->data4 |= HE_PREP(DATA4_SU_MU_SPTL_REUSE, SR_MASK, rxv[11]);
 		break;
 	case MT_PHY_TYPE_HE_EXT_SU:
 		he->data1 |= HE_BITS(DATA1_FORMAT_EXT_SU) |
@@ -280,23 +324,20 @@ mt7915_mac_decode_he_radiotap(struct sk_buff *skb,
 		break;
 	case MT_PHY_TYPE_HE_MU:
 		he->data1 |= HE_BITS(DATA1_FORMAT_MU) |
-			     HE_BITS(DATA1_UL_DL_KNOWN) |
-			     HE_BITS(DATA1_SPTL_REUSE_KNOWN);
+			     HE_BITS(DATA1_UL_DL_KNOWN);
 
 		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
-		he->data4 |= HE_PREP(DATA4_SU_MU_SPTL_REUSE, SR_MASK, rxv[11]);
+		he->data4 |= HE_PREP(DATA4_MU_STA_ID, MU_AID, rxv[7]);
 
 		mt7915_mac_decode_he_radiotap_ru(status, he, rxv);
 		break;
 	case MT_PHY_TYPE_HE_TB:
 		he->data1 |= HE_BITS(DATA1_FORMAT_TRIG) |
-			     HE_BITS(DATA1_SPTL_REUSE_KNOWN) |
 			     HE_BITS(DATA1_SPTL_REUSE2_KNOWN) |
 			     HE_BITS(DATA1_SPTL_REUSE3_KNOWN) |
 			     HE_BITS(DATA1_SPTL_REUSE4_KNOWN);
 
-		he->data4 |= HE_PREP(DATA4_TB_SPTL_REUSE1, SR_MASK, rxv[11]) |
-			     HE_PREP(DATA4_TB_SPTL_REUSE2, SR1_MASK, rxv[11]) |
+		he->data4 |= HE_PREP(DATA4_TB_SPTL_REUSE2, SR1_MASK, rxv[11]) |
 			     HE_PREP(DATA4_TB_SPTL_REUSE3, SR2_MASK, rxv[11]) |
 			     HE_PREP(DATA4_TB_SPTL_REUSE4, SR3_MASK, rxv[11]);
 
@@ -610,8 +651,11 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 		status->flag |= RX_FLAG_8023;
 	}
 
-	if (rxv && status->flag & RX_FLAG_RADIOTAP_HE)
+	if (rxv && status->flag & RX_FLAG_RADIOTAP_HE) {
 		mt7915_mac_decode_he_radiotap(skb, status, rxv, mode);
+		if (status->flag & RX_FLAG_RADIOTAP_HE_MU)
+			mt7915_mac_decode_he_mu_radiotap(skb, status, rxv);
+	}
 
 	if (!status->wcid || !ieee80211_is_data_qos(fc))
 		return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index eb1885f4bd8e..ccce994dc07a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -117,6 +117,7 @@ enum rx_pkt_type {
 #define MT_PRXV_TX_DCM			BIT(4)
 #define MT_PRXV_TX_ER_SU_106T		BIT(5)
 #define MT_PRXV_NSTS			GENMASK(9, 7)
+#define MT_PRXV_TXBF			BIT(10)
 #define MT_PRXV_HT_AD_CODE		BIT(11)
 #define MT_PRXV_HE_RU_ALLOC_L		GENMASK(31, 28)
 #define MT_PRXV_HE_RU_ALLOC_H		GENMASK(3, 0)
@@ -133,7 +134,14 @@ enum rx_pkt_type {
 #define MT_CRXV_HE_LTF_SIZE		GENMASK(18, 17)
 #define MT_CRXV_HE_LDPC_EXT_SYM		BIT(20)
 #define MT_CRXV_HE_PE_DISAMBIG		BIT(23)
+#define MT_CRXV_HE_NUM_USER		GENMASK(30, 24)
 #define MT_CRXV_HE_UPLINK		BIT(31)
+#define MT_CRXV_HE_RU0			GENMASK(7, 0)
+#define MT_CRXV_HE_RU1			GENMASK(15, 8)
+#define MT_CRXV_HE_RU2			GENMASK(23, 16)
+#define MT_CRXV_HE_RU3			GENMASK(31, 24)
+
+#define MT_CRXV_HE_MU_AID		GENMASK(30, 20)
 
 #define MT_CRXV_HE_SR_MASK		GENMASK(11, 8)
 #define MT_CRXV_HE_SR1_MASK		GENMASK(16, 12)
-- 
2.18.0

