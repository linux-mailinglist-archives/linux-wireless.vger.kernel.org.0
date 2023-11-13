Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFCC7E96E6
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 08:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbjKMHHc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 02:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjKMHHa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 02:07:30 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF6310E6
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 23:07:26 -0800 (PST)
X-UUID: 4afdedaa81f311eea33bb35ae8d461a2-20231113
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=zpIx9nyFJbafGNFM9ybQpRVA/Ugkhmd0AAgZ9Z/rpmM=;
        b=cZQKl95RpaPCwjXhzYvyeShj0M44Zh+RIT+yCykms03urkwJiC2vgHvtda9Ic28ZM9Mh2KMItVgnD4AV6bPQADXAyFVdvGqHWyuzdaV9c4Ol8hxjjhl4OdA4XPHv9GO+NkCmN19ZLXRF3Jhd/7RH+qytAbIXJdTW1xeHNJxZ6M4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:9ba84223-a6d6-4824-a8d1-696549c4e601,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:364b77b,CLOUDID:2fd45295-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 4afdedaa81f311eea33bb35ae8d461a2-20231113
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1575480591; Mon, 13 Nov 2023 15:07:23 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 13 Nov 2023 15:07:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 13 Nov 2023 15:07:22 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Benjamin Lin <benjamin-jw.lin@mediatek.com>,
        StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 3/8] wifi: mt76: mt7996: add DMA support for mt7992
Date:   Mon, 13 Nov 2023 15:06:14 +0800
Message-ID: <20231113070619.19964-4-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231113070619.19964-1-shayne.chen@mediatek.com>
References: <20231113070619.19964-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--10.213100-8.000000
X-TMASE-MatchedRID: WbOLpgv9C7YfOjKSU0pCEXvfC66LYKVUgDRlwc+wR6f/mpvOG+QCxGb6
        PphVtfZg7s3FANKtoAW9cOdjc/43lWr4uS6vfh2tpvwZ9GmdwDNu95mt47DzNtb1HR1TV5h0Qdg
        MnSk9rKd+JePVTWN39ykSkP3eOoQbTZWdcxHMgGOEvh9qhv4BKIfsPVs/8Vw6p+cg3PT8JVxNAV
        8zRS9/jC4zuE4e+wS6gDLqnrRlXrZ8nn9tnqel2MprJP8FBOIaZK61YQ+0NA57wzcZbqLReK0Sw
        mAxJBJFDk09MEwOkgZDCWCgjZxLqQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.213100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 0A129C4282955FE2BFF4F6BA742E7A4F580429FC66A8F1DB88CF44C6204A5CB52000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Lin <benjamin-jw.lin@mediatek.com>

Add DMA TX/RX queues and RRO init flow for mt7992 chipsets.
This is a preliminary patch for mt7992 chipsets support.

Co-developed-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/dma.c   | 58 +++++++++++++++----
 .../net/wireless/mediatek/mt76/mt7996/init.c  |  9 ++-
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  7 ++-
 .../net/wireless/mediatek/mt76/mt7996/regs.h  |  4 +-
 4 files changed, 61 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
index e88096f442d3..c68fec628db5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
@@ -57,13 +57,19 @@ static void mt7996_dma_config(struct mt7996_dev *dev)
 	RXQ_CONFIG(MT_RXQ_MCU, WFDMA0, MT_INT_RX_DONE_WM, MT7996_RXQ_MCU_WM);
 	RXQ_CONFIG(MT_RXQ_MCU_WA, WFDMA0, MT_INT_RX_DONE_WA, MT7996_RXQ_MCU_WA);
 
-	/* band0/band1 */
+	/* mt7996: band0 and band1, mt7992: band0 */
 	RXQ_CONFIG(MT_RXQ_MAIN, WFDMA0, MT_INT_RX_DONE_BAND0, MT7996_RXQ_BAND0);
 	RXQ_CONFIG(MT_RXQ_MAIN_WA, WFDMA0, MT_INT_RX_DONE_WA_MAIN, MT7996_RXQ_MCU_WA_MAIN);
 
-	/* band2 */
-	RXQ_CONFIG(MT_RXQ_BAND2, WFDMA0, MT_INT_RX_DONE_BAND2, MT7996_RXQ_BAND2);
-	RXQ_CONFIG(MT_RXQ_BAND2_WA, WFDMA0, MT_INT_RX_DONE_WA_TRI, MT7996_RXQ_MCU_WA_TRI);
+	if (is_mt7996(&dev->mt76)) {
+		/* mt7996 band2 */
+		RXQ_CONFIG(MT_RXQ_BAND2, WFDMA0, MT_INT_RX_DONE_BAND2, MT7996_RXQ_BAND2);
+		RXQ_CONFIG(MT_RXQ_BAND2_WA, WFDMA0, MT_INT_RX_DONE_WA_TRI, MT7996_RXQ_MCU_WA_TRI);
+	} else {
+		/* mt7992 band1 */
+		RXQ_CONFIG(MT_RXQ_BAND1, WFDMA0, MT_INT_RX_DONE_BAND1, MT7996_RXQ_BAND1);
+		RXQ_CONFIG(MT_RXQ_BAND1_WA, WFDMA0, MT_INT_RX_DONE_WA_EXT, MT7996_RXQ_MCU_WA_EXT);
+	}
 
 	if (dev->has_rro) {
 		/* band0 */
@@ -90,8 +96,12 @@ static void mt7996_dma_config(struct mt7996_dev *dev)
 
 	/* data tx queue */
 	TXQ_CONFIG(0, WFDMA0, MT_INT_TX_DONE_BAND0, MT7996_TXQ_BAND0);
-	TXQ_CONFIG(1, WFDMA0, MT_INT_TX_DONE_BAND1, MT7996_TXQ_BAND1);
-	TXQ_CONFIG(2, WFDMA0, MT_INT_TX_DONE_BAND2, MT7996_TXQ_BAND2);
+	if (is_mt7996(&dev->mt76)) {
+		TXQ_CONFIG(1, WFDMA0, MT_INT_TX_DONE_BAND1, MT7996_TXQ_BAND1);
+		TXQ_CONFIG(2, WFDMA0, MT_INT_TX_DONE_BAND2, MT7996_TXQ_BAND2);
+	} else {
+		TXQ_CONFIG(1, WFDMA0, MT_INT_TX_DONE_BAND1, MT7996_TXQ_BAND1);
+	}
 
 	/* mcu tx queue */
 	MCUQ_CONFIG(MT_MCUQ_WM, WFDMA0, MT_INT_TX_DONE_MCU_WM, MT7996_TXQ_MCU_WM);
@@ -111,6 +121,7 @@ static u32 __mt7996_dma_prefetch_base(u16 *base, u8 depth)
 static void __mt7996_dma_prefetch(struct mt7996_dev *dev, u32 ofs)
 {
 	u16 base = 0;
+	u8 queue;
 
 #define PREFETCH(_depth)	(__mt7996_dma_prefetch_base(&base, (_depth)))
 	/* prefetch SRAM wrapping boundary for tx/rx ring. */
@@ -123,9 +134,14 @@ static void __mt7996_dma_prefetch(struct mt7996_dev *dev, u32 ofs)
 	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MCU) + ofs, PREFETCH(0x2));
 	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MCU_WA) + ofs, PREFETCH(0x2));
 	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MAIN_WA) + ofs, PREFETCH(0x2));
-	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_BAND2_WA) + ofs, PREFETCH(0x2));
+
+	queue = is_mt7996(&dev->mt76) ? MT_RXQ_BAND2_WA : MT_RXQ_BAND1_WA;
+	mt76_wr(dev, MT_RXQ_BAND1_CTRL(queue) + ofs, PREFETCH(0x2));
+
 	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MAIN) + ofs, PREFETCH(0x10));
-	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_BAND2) + ofs, PREFETCH(0x10));
+
+	queue = is_mt7996(&dev->mt76) ? MT_RXQ_BAND2 : MT_RXQ_BAND1;
+	mt76_wr(dev, MT_RXQ_BAND1_CTRL(queue) + ofs, PREFETCH(0x10));
 
 	if (dev->has_rro) {
 		mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_RRO_BAND0) + ofs,
@@ -488,7 +504,7 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 	if (ret)
 		return ret;
 
-	/* rx data queue for band0 and band1 */
+	/* rx data queue for band0 and mt7996 band1 */
 	if (mtk_wed_device_active(wed) && mtk_wed_get_rx_capa(wed)) {
 		dev->mt76.q_rx[MT_RXQ_MAIN].flags = MT_WED_Q_RX(0);
 		dev->mt76.q_rx[MT_RXQ_MAIN].wed = wed;
@@ -517,7 +533,7 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 		return ret;
 
 	if (mt7996_band_valid(dev, MT_BAND2)) {
-		/* rx data queue for band2 */
+		/* rx data queue for mt7996 band2 */
 		rx_base = MT_RXQ_RING_BASE(MT_RXQ_BAND2) + hif1_ofs;
 		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_BAND2],
 				       MT_RXQ_ID(MT_RXQ_BAND2),
@@ -527,7 +543,7 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 		if (ret)
 			return ret;
 
-		/* tx free notify event from WA for band2
+		/* tx free notify event from WA for mt7996 band2
 		 * use pcie0's rx ring3, but, redirect pcie0 rx ring3 interrupt to pcie1
 		 */
 		if (mtk_wed_device_active(wed_hif2) && !dev->has_rro) {
@@ -542,6 +558,26 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 				       MT_RXQ_RING_BASE(MT_RXQ_BAND2_WA));
 		if (ret)
 			return ret;
+	} else if (mt7996_band_valid(dev, MT_BAND1)) {
+		/* rx data queue for mt7992 band1 */
+		rx_base = MT_RXQ_RING_BASE(MT_RXQ_BAND1) + hif1_ofs;
+		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_BAND1],
+				       MT_RXQ_ID(MT_RXQ_BAND1),
+				       MT7996_RX_RING_SIZE,
+				       MT_RX_BUF_SIZE,
+				       rx_base);
+		if (ret)
+			return ret;
+
+		/* tx free notify event from WA for mt7992 band1 */
+		rx_base = MT_RXQ_RING_BASE(MT_RXQ_BAND1_WA) + hif1_ofs;
+		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_BAND1_WA],
+				       MT_RXQ_ID(MT_RXQ_BAND1_WA),
+				       MT7996_RX_MCU_RING_SIZE,
+				       MT_RX_BUF_SIZE,
+				       rx_base);
+		if (ret)
+			return ret;
 	}
 
 	if (mtk_wed_device_active(wed) && mtk_wed_get_rx_capa(wed) &&
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 2a7c367afae1..0cf0d1fe420a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -513,7 +513,12 @@ void mt7996_mac_init(struct mt7996_dev *dev)
 	mt76_rmw_field(dev, MT_DMA_TCRF1(2), MT_DMA_TCRF1_QIDX, 0);
 
 	/* rro module init */
-	mt7996_mcu_set_rro(dev, UNI_RRO_SET_PLATFORM_TYPE, 2);
+	if (is_mt7996(&dev->mt76))
+		mt7996_mcu_set_rro(dev, UNI_RRO_SET_PLATFORM_TYPE, 2);
+	else
+		mt7996_mcu_set_rro(dev, UNI_RRO_SET_PLATFORM_TYPE,
+				   dev->hif2 ? 7 : 0);
+
 	if (dev->has_rro) {
 		u16 timeout;
 
@@ -570,7 +575,7 @@ static int mt7996_register_phy(struct mt7996_dev *dev, struct mt7996_phy *phy,
 	if (phy)
 		return 0;
 
-	if (band == MT_BAND2 && dev->hif2) {
+	if (is_mt7996(&dev->mt76) && band == MT_BAND2 && dev->hif2) {
 		hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
 		wed = &dev->mt76.mmio.wed_hif2;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 1a36ef50f6e1..87822663870f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -104,10 +104,10 @@ enum mt7996_rxq_id {
 	MT7996_RXQ_MCU_WM = 0,
 	MT7996_RXQ_MCU_WA,
 	MT7996_RXQ_MCU_WA_MAIN = 2,
-	MT7996_RXQ_MCU_WA_EXT = 2,/* unused */
+	MT7996_RXQ_MCU_WA_EXT = 3, /* for mt7992 */
 	MT7996_RXQ_MCU_WA_TRI = 3,
 	MT7996_RXQ_BAND0 = 4,
-	MT7996_RXQ_BAND1 = 4,/* unused */
+	MT7996_RXQ_BAND1 = 5, /* for mt7992 */
 	MT7996_RXQ_BAND2 = 5,
 	MT7996_RXQ_RRO_BAND0 = 8,
 	MT7996_RXQ_RRO_BAND1 = 8,/* unused */
@@ -399,6 +399,9 @@ mt7996_phy3(struct mt7996_dev *dev)
 static inline bool
 mt7996_band_valid(struct mt7996_dev *dev, u8 band)
 {
+	if (is_mt7992(&dev->mt76))
+		return band <= MT_BAND1;
+
 	/* tri-band support */
 	if (band <= MT_BAND2 &&
 	    mt76_get_field(dev, MT_PAD_GPIO, MT_PAD_GPIO_ADIE_COMB) <= 1)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
index aee577d90ddb..6623a6ba12d6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -461,12 +461,12 @@ enum base_rev {
 #define MT_INT1_MASK_CSR			MT_WFDMA0_PCIE1(0x204)
 
 #define MT_INT_RX_DONE_BAND0			BIT(12)
-#define MT_INT_RX_DONE_BAND1			BIT(12)
+#define MT_INT_RX_DONE_BAND1			BIT(13) /* for mt7992 */
 #define MT_INT_RX_DONE_BAND2			BIT(13)
 #define MT_INT_RX_DONE_WM			BIT(0)
 #define MT_INT_RX_DONE_WA			BIT(1)
 #define MT_INT_RX_DONE_WA_MAIN			BIT(2)
-#define MT_INT_RX_DONE_WA_EXT			BIT(2)
+#define MT_INT_RX_DONE_WA_EXT			BIT(3) /* for mt7992 */
 #define MT_INT_RX_DONE_WA_TRI			BIT(3)
 #define MT_INT_RX_TXFREE_MAIN			BIT(17)
 #define MT_INT_RX_TXFREE_TRI			BIT(15)
-- 
2.39.2

