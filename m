Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3466F692E8F
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Feb 2023 07:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjBKGOQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Feb 2023 01:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKGOP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Feb 2023 01:14:15 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2803635B8
        for <linux-wireless@vger.kernel.org>; Fri, 10 Feb 2023 22:14:05 -0800 (PST)
X-UUID: 4669c4baa9d311eda06fc9ecc4dadd91-20230211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=6UqsLLax6Dcnb/KEB84XQVctgBYv1fuTZX05cSHxEGc=;
        b=HomXrpnl7RF7E6Sa6rnpyYS7L2WEqBnDdWeoqbYOPq7t/MwhzjCe0+zjcd/c0YIzaHvP/fAlKtnnM7eBPaHJSy9l8SmKE3X+G+M2as9qsH5/vZasI+iuEJVqLDtHmElKBfCIMp628z5QdgOA7KhouM8ydgXPePoPfjgUb5kNtHc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:45e8a290-2231-4279-8ff9-23438b06c04d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:5e0bf656-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 4669c4baa9d311eda06fc9ecc4dadd91-20230211
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 943413341; Sat, 11 Feb 2023 14:14:00 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 11 Feb 2023 14:13:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Sat, 11 Feb 2023 14:13:58 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        MeiChia Chiu <meichia.chiu@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7996: fix radiotap bitfield
Date:   Sat, 11 Feb 2023 14:13:58 +0800
Message-ID: <79c72b8b101f561bae2350b7945cb41bef86aa83.1676095591.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Update radiotap bitfield.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 54 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7996/mac.h   | 41 +++++++-------
 2 files changed, 47 insertions(+), 48 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index c9a9f0e31771..3c3506c7c87a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -260,12 +260,9 @@ mt7996_mac_decode_he_radiotap_ru(struct mt76_rx_status *status,
 				 struct ieee80211_radiotap_he *he,
 				 __le32 *rxv)
 {
-	u32 ru_h, ru_l;
-	u8 ru, offs = 0;
+	u32 ru, offs = 0;
 
-	ru_l = le32_get_bits(rxv[0], MT_PRXV_HE_RU_ALLOC_L);
-	ru_h = le32_get_bits(rxv[1], MT_PRXV_HE_RU_ALLOC_H);
-	ru = (u8)(ru_l | ru_h << 4);
+	ru = le32_get_bits(rxv[0], MT_PRXV_HE_RU_ALLOC);
 
 	status->bw = RATE_INFO_BW_HE_RU;
 
@@ -330,18 +327,23 @@ mt7996_mac_decode_he_mu_radiotap(struct sk_buff *skb, __le32 *rxv)
 
 	he_mu->flags2 |= MU_PREP(FLAGS2_BW_FROM_SIG_A_BW, status->bw) |
 			 MU_PREP(FLAGS2_SIG_B_SYMS_USERS,
-				 le32_get_bits(rxv[2], MT_CRXV_HE_NUM_USER));
+				 le32_get_bits(rxv[4], MT_CRXV_HE_NUM_USER));
 
-	he_mu->ru_ch1[0] = le32_get_bits(rxv[3], MT_CRXV_HE_RU0);
+	he_mu->ru_ch1[0] = le32_get_bits(rxv[16], MT_CRXV_HE_RU0) & 0xff;
 
 	if (status->bw >= RATE_INFO_BW_40) {
 		he_mu->flags1 |= HE_BITS(MU_FLAGS1_CH2_RU_KNOWN);
-		he_mu->ru_ch2[0] = le32_get_bits(rxv[3], MT_CRXV_HE_RU1);
+		he_mu->ru_ch2[0] = le32_get_bits(rxv[16], MT_CRXV_HE_RU1) & 0xff;
 	}
 
 	if (status->bw >= RATE_INFO_BW_80) {
-		he_mu->ru_ch1[1] = le32_get_bits(rxv[3], MT_CRXV_HE_RU2);
-		he_mu->ru_ch2[1] = le32_get_bits(rxv[3], MT_CRXV_HE_RU3);
+		u32 ru_h, ru_l;
+
+		he_mu->ru_ch1[1] = le32_get_bits(rxv[16], MT_CRXV_HE_RU2) & 0xff;
+
+		ru_l = le32_get_bits(rxv[16], MT_CRXV_HE_RU3_L);
+		ru_h = le32_get_bits(rxv[17], MT_CRXV_HE_RU3_H) & 0x7;
+		he_mu->ru_ch2[1] = (u8)(ru_l | ru_h << 4);
 	}
 }
 
@@ -364,23 +366,23 @@ mt7996_mac_decode_he_radiotap(struct sk_buff *skb, __le32 *rxv, u8 mode)
 			 HE_BITS(DATA2_TXOP_KNOWN),
 	};
 	struct ieee80211_radiotap_he *he = NULL;
-	u32 ltf_size = le32_get_bits(rxv[2], MT_CRXV_HE_LTF_SIZE) + 1;
+	u32 ltf_size = le32_get_bits(rxv[4], MT_CRXV_HE_LTF_SIZE) + 1;
 
 	status->flag |= RX_FLAG_RADIOTAP_HE;
 
 	he = skb_push(skb, sizeof(known));
 	memcpy(he, &known, sizeof(known));
 
-	he->data3 = HE_PREP(DATA3_BSS_COLOR, BSS_COLOR, rxv[14]) |
-		    HE_PREP(DATA3_LDPC_XSYMSEG, LDPC_EXT_SYM, rxv[2]);
-	he->data4 = HE_PREP(DATA4_SU_MU_SPTL_REUSE, SR_MASK, rxv[11]);
-	he->data5 = HE_PREP(DATA5_PE_DISAMBIG, PE_DISAMBIG, rxv[2]) |
+	he->data3 = HE_PREP(DATA3_BSS_COLOR, BSS_COLOR, rxv[9]) |
+		    HE_PREP(DATA3_LDPC_XSYMSEG, LDPC_EXT_SYM, rxv[4]);
+	he->data4 = HE_PREP(DATA4_SU_MU_SPTL_REUSE, SR_MASK, rxv[13]);
+	he->data5 = HE_PREP(DATA5_PE_DISAMBIG, PE_DISAMBIG, rxv[5]) |
 		    le16_encode_bits(ltf_size,
 				     IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE);
 	if (le32_to_cpu(rxv[0]) & MT_PRXV_TXBF)
 		he->data5 |= HE_BITS(DATA5_TXBF);
-	he->data6 = HE_PREP(DATA6_TXOP, TXOP_DUR, rxv[14]) |
-		    HE_PREP(DATA6_DOPPLER, DOPPLER, rxv[14]);
+	he->data6 = HE_PREP(DATA6_TXOP, TXOP_DUR, rxv[9]) |
+		    HE_PREP(DATA6_DOPPLER, DOPPLER, rxv[9]);
 
 	switch (mode) {
 	case MT_PHY_TYPE_HE_SU:
@@ -389,22 +391,22 @@ mt7996_mac_decode_he_radiotap(struct sk_buff *skb, __le32 *rxv, u8 mode)
 			     HE_BITS(DATA1_BEAM_CHANGE_KNOWN) |
 			     HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
 
-		he->data3 |= HE_PREP(DATA3_BEAM_CHANGE, BEAM_CHNG, rxv[14]) |
-			     HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
+		he->data3 |= HE_PREP(DATA3_BEAM_CHANGE, BEAM_CHNG, rxv[8]) |
+			     HE_PREP(DATA3_UL_DL, UPLINK, rxv[5]);
 		break;
 	case MT_PHY_TYPE_HE_EXT_SU:
 		he->data1 |= HE_BITS(DATA1_FORMAT_EXT_SU) |
 			     HE_BITS(DATA1_UL_DL_KNOWN) |
 			     HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
 
-		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
+		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[5]);
 		break;
 	case MT_PHY_TYPE_HE_MU:
 		he->data1 |= HE_BITS(DATA1_FORMAT_MU) |
 			     HE_BITS(DATA1_UL_DL_KNOWN);
 
-		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
-		he->data4 |= HE_PREP(DATA4_MU_STA_ID, MU_AID, rxv[7]);
+		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[5]);
+		he->data4 |= HE_PREP(DATA4_MU_STA_ID, MU_AID, rxv[8]);
 
 		mt7996_mac_decode_he_radiotap_ru(status, he, rxv);
 		mt7996_mac_decode_he_mu_radiotap(skb, rxv);
@@ -415,10 +417,10 @@ mt7996_mac_decode_he_radiotap(struct sk_buff *skb, __le32 *rxv, u8 mode)
 			     HE_BITS(DATA1_SPTL_REUSE3_KNOWN) |
 			     HE_BITS(DATA1_SPTL_REUSE4_KNOWN);
 
-		he->data4 |= HE_PREP(DATA4_TB_SPTL_REUSE1, SR_MASK, rxv[11]) |
-			     HE_PREP(DATA4_TB_SPTL_REUSE2, SR1_MASK, rxv[11]) |
-			     HE_PREP(DATA4_TB_SPTL_REUSE3, SR2_MASK, rxv[11]) |
-			     HE_PREP(DATA4_TB_SPTL_REUSE4, SR3_MASK, rxv[11]);
+		he->data4 |= HE_PREP(DATA4_TB_SPTL_REUSE1, SR_MASK, rxv[13]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE2, SR1_MASK, rxv[13]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE3, SR2_MASK, rxv[13]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE4, SR3_MASK, rxv[13]);
 
 		mt7996_mac_decode_he_radiotap_ru(status, he, rxv);
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.h b/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
index 27184cbac619..2cc218f735d8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
@@ -102,8 +102,7 @@ enum rx_pkt_type {
 #define MT_PRXV_NSTS			GENMASK(10, 7)
 #define MT_PRXV_TXBF			BIT(11)
 #define MT_PRXV_HT_AD_CODE		BIT(12)
-#define MT_PRXV_HE_RU_ALLOC_L		GENMASK(31, 28)
-#define MT_PRXV_HE_RU_ALLOC_H		GENMASK(3, 0)
+#define MT_PRXV_HE_RU_ALLOC		GENMASK(30, 22)
 #define MT_PRXV_RCPI3			GENMASK(31, 24)
 #define MT_PRXV_RCPI2			GENMASK(23, 16)
 #define MT_PRXV_RCPI1			GENMASK(15, 8)
@@ -113,34 +112,32 @@ enum rx_pkt_type {
 #define MT_PRXV_TX_MODE			GENMASK(14, 11)
 #define MT_PRXV_FRAME_MODE		GENMASK(2, 0)
 #define MT_PRXV_DCM			BIT(5)
-#define MT_PRXV_NUM_RX			BIT(8, 6)
 
 /* C-RXV */
-#define MT_CRXV_HT_STBC			GENMASK(1, 0)
-#define MT_CRXV_TX_MODE			GENMASK(7, 4)
-#define MT_CRXV_FRAME_MODE		GENMASK(10, 8)
-#define MT_CRXV_HT_SHORT_GI		GENMASK(14, 13)
-#define MT_CRXV_HE_LTF_SIZE		GENMASK(18, 17)
-#define MT_CRXV_HE_LDPC_EXT_SYM		BIT(20)
-#define MT_CRXV_HE_PE_DISAMBIG		BIT(23)
-#define MT_CRXV_HE_NUM_USER		GENMASK(30, 24)
-#define MT_CRXV_HE_UPLINK		BIT(31)
-#define MT_CRXV_HE_RU0			GENMASK(7, 0)
-#define MT_CRXV_HE_RU1			GENMASK(15, 8)
-#define MT_CRXV_HE_RU2			GENMASK(23, 16)
-#define MT_CRXV_HE_RU3			GENMASK(31, 24)
-
-#define MT_CRXV_HE_MU_AID		GENMASK(30, 20)
+#define MT_CRXV_HE_NUM_USER		GENMASK(26, 20)
+#define MT_CRXV_HE_LTF_SIZE		GENMASK(28, 27)
+#define MT_CRXV_HE_LDPC_EXT_SYM		BIT(30)
+
+#define MT_CRXV_HE_PE_DISAMBIG		BIT(1)
+#define MT_CRXV_HE_UPLINK		BIT(2)
+
+#define MT_CRXV_HE_MU_AID		GENMASK(27, 17)
+#define MT_CRXV_HE_BEAM_CHNG		BIT(29)
+
+#define MT_CRXV_HE_DOPPLER		BIT(0)
+#define MT_CRXV_HE_BSS_COLOR		GENMASK(15, 10)
+#define MT_CRXV_HE_TXOP_DUR		GENMASK(19, 17)
 
 #define MT_CRXV_HE_SR_MASK		GENMASK(11, 8)
 #define MT_CRXV_HE_SR1_MASK		GENMASK(16, 12)
 #define MT_CRXV_HE_SR2_MASK             GENMASK(20, 17)
 #define MT_CRXV_HE_SR3_MASK             GENMASK(24, 21)
 
-#define MT_CRXV_HE_BSS_COLOR		GENMASK(5, 0)
-#define MT_CRXV_HE_TXOP_DUR		GENMASK(12, 6)
-#define MT_CRXV_HE_BEAM_CHNG		BIT(13)
-#define MT_CRXV_HE_DOPPLER		BIT(16)
+#define MT_CRXV_HE_RU0			GENMASK(8, 0)
+#define MT_CRXV_HE_RU1			GENMASK(17, 9)
+#define MT_CRXV_HE_RU2			GENMASK(26, 18)
+#define MT_CRXV_HE_RU3_L		GENMASK(31, 27)
+#define MT_CRXV_HE_RU3_H		GENMASK(3, 0)
 
 enum tx_header_format {
 	MT_HDR_FORMAT_802_3,
-- 
2.18.0

