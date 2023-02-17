Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047A169B1FC
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Feb 2023 18:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjBQRr0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Feb 2023 12:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBQRrY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Feb 2023 12:47:24 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7FB711AA
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 09:47:17 -0800 (PST)
X-UUID: 19b71a36aeeb11ed945fc101203acc17-20230218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=t3cpxqotyAEehJ0s6sntPEcUnE2ZT+PWNwypBZXT4eQ=;
        b=Ef5Re59P+RGmDrxWF6Du/46f3g9l5BiyIqjKm+yP4/jMZluH1BL512dlLmj2qdjNnj5TqgKBOSHeHf8iws1jBHiFfbP2KjwVl1hYzF8Kfp7e8HQqL9u8zaTQxjHAGkiVQPo/X4AJDIY8qT0jElCqmdpJ8flAKy3NUTK0wK3fFJY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:5077ee81-edd4-47e8-9fce-89c0476f972b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:188cea25-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 19b71a36aeeb11ed945fc101203acc17-20230218
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 105077351; Sat, 18 Feb 2023 01:47:09 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 18 Feb 2023 01:47:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Sat, 18 Feb 2023 01:47:07 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2] wifi: mt76: mt7996: fix radiotap bitfield
Date:   Sat, 18 Feb 2023 01:46:54 +0800
Message-ID: <c5289bc85b268fca577420fae74cc4f06b544798.1676623066.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The 11be generation's radiotap bitfields were wrongly copy-and-pasted
from 11ax driver, so fix them accordingly.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
change since v2 - revise commit message.
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

