Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F1F622055
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Nov 2022 00:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiKHXaD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 18:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKHXaB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 18:30:01 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72811D678
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 15:29:54 -0800 (PST)
X-UUID: 4eb7d846f8b84bd48fae40bdac33f54d-20221109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=6ucZf4pwP7m0anh+9GOUZcIcP5stJ6/e+bu+Jc7CdKc=;
        b=YKkSvM+ZzapNldryVvcrYhiofDV3MoekaIj1d7sBNYjN2yeihz59Xjnbrav4ORXPoTiQFOOsbT5/LA/NMGAo29hJ4t/iNx32rmo83JNFY+7U2oq4o7A5PYkoJfaYZpizXbwS2NhrXRv/QbZauLg9CD9pukLBUSrhFbW/DDh1ZRE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:fcc946ec-c5a7-40a3-97fc-0993cc3430c4,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.12,REQID:fcc946ec-c5a7-40a3-97fc-0993cc3430c4,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:62cd327,CLOUDID:652f11f4-a19e-4b45-8bfe-6a73c93611e9,B
        ulkID:2211090302142BZOUAOF,BulkQuantity:7,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:41,QS:nil,BEC:nil,COL:0
X-UUID: 4eb7d846f8b84bd48fae40bdac33f54d-20221109
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 179784108; Wed, 09 Nov 2022 07:29:48 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 9 Nov 2022 07:29:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 9 Nov 2022 07:29:47 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Bo Jiao <bo.jiao@mediatek.com>,
        "Ryder Lee" <ryder.lee@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH v2 1/4] wifi: mt76: mt7915: rework mt7915_dma_reset()
Date:   Wed, 9 Nov 2022 07:29:41 +0800
Message-ID: <26aefa69d1002616412c4b00bf2e779f71ca3289.1667949443.git.ryder.lee@mediatek.com>
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

From: Bo Jiao <bo.jiao@mediatek.com>

Reuse mt7915_dma_disable() to reduce duplicated code.
This is a preliminary patch to enable full system reset.

Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/dma.c   | 110 ++++++++++++++----
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  69 +----------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   1 +
 3 files changed, 91 insertions(+), 89 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index e4fa240834d8..5b27093f618b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -50,23 +50,37 @@ static void mt7915_dma_config(struct mt7915_dev *dev)
 #define TXQ_CONFIG(q, wfdma, int, id)	Q_CONFIG(__TXQ(q), (wfdma), (int), (id))
 
 	if (is_mt7915(&dev->mt76)) {
-		RXQ_CONFIG(MT_RXQ_MAIN, WFDMA0, MT_INT_RX_DONE_BAND0, MT7915_RXQ_BAND0);
-		RXQ_CONFIG(MT_RXQ_MCU, WFDMA1, MT_INT_RX_DONE_WM, MT7915_RXQ_MCU_WM);
-		RXQ_CONFIG(MT_RXQ_MCU_WA, WFDMA1, MT_INT_RX_DONE_WA, MT7915_RXQ_MCU_WA);
-		RXQ_CONFIG(MT_RXQ_BAND1, WFDMA0, MT_INT_RX_DONE_BAND1, MT7915_RXQ_BAND1);
-		RXQ_CONFIG(MT_RXQ_BAND1_WA, WFDMA1, MT_INT_RX_DONE_WA_EXT, MT7915_RXQ_MCU_WA_EXT);
-		RXQ_CONFIG(MT_RXQ_MAIN_WA, WFDMA1, MT_INT_RX_DONE_WA_MAIN, MT7915_RXQ_MCU_WA);
+		RXQ_CONFIG(MT_RXQ_MAIN, WFDMA0, MT_INT_RX_DONE_BAND0,
+			   MT7915_RXQ_BAND0);
+		RXQ_CONFIG(MT_RXQ_MCU, WFDMA1, MT_INT_RX_DONE_WM,
+			   MT7915_RXQ_MCU_WM);
+		RXQ_CONFIG(MT_RXQ_MCU_WA, WFDMA1, MT_INT_RX_DONE_WA,
+			   MT7915_RXQ_MCU_WA);
+		RXQ_CONFIG(MT_RXQ_BAND1, WFDMA0, MT_INT_RX_DONE_BAND1,
+			   MT7915_RXQ_BAND1);
+		RXQ_CONFIG(MT_RXQ_BAND1_WA, WFDMA1, MT_INT_RX_DONE_WA_EXT,
+			   MT7915_RXQ_MCU_WA_EXT);
+		RXQ_CONFIG(MT_RXQ_MAIN_WA, WFDMA1, MT_INT_RX_DONE_WA_MAIN,
+			   MT7915_RXQ_MCU_WA);
 		TXQ_CONFIG(0, WFDMA1, MT_INT_TX_DONE_BAND0, MT7915_TXQ_BAND0);
 		TXQ_CONFIG(1, WFDMA1, MT_INT_TX_DONE_BAND1, MT7915_TXQ_BAND1);
-		MCUQ_CONFIG(MT_MCUQ_WM, WFDMA1, MT_INT_TX_DONE_MCU_WM, MT7915_TXQ_MCU_WM);
-		MCUQ_CONFIG(MT_MCUQ_WA, WFDMA1, MT_INT_TX_DONE_MCU_WA, MT7915_TXQ_MCU_WA);
-		MCUQ_CONFIG(MT_MCUQ_FWDL, WFDMA1, MT_INT_TX_DONE_FWDL, MT7915_TXQ_FWDL);
+		MCUQ_CONFIG(MT_MCUQ_WM, WFDMA1, MT_INT_TX_DONE_MCU_WM,
+			    MT7915_TXQ_MCU_WM);
+		MCUQ_CONFIG(MT_MCUQ_WA, WFDMA1, MT_INT_TX_DONE_MCU_WA,
+			    MT7915_TXQ_MCU_WA);
+		MCUQ_CONFIG(MT_MCUQ_FWDL, WFDMA1, MT_INT_TX_DONE_FWDL,
+			    MT7915_TXQ_FWDL);
 	} else {
-		RXQ_CONFIG(MT_RXQ_MCU, WFDMA0, MT_INT_RX_DONE_WM, MT7916_RXQ_MCU_WM);
-		RXQ_CONFIG(MT_RXQ_BAND1_WA, WFDMA0, MT_INT_RX_DONE_WA_EXT_MT7916, MT7916_RXQ_MCU_WA_EXT);
-		MCUQ_CONFIG(MT_MCUQ_WM, WFDMA0, MT_INT_TX_DONE_MCU_WM, MT7915_TXQ_MCU_WM);
-		MCUQ_CONFIG(MT_MCUQ_WA, WFDMA0, MT_INT_TX_DONE_MCU_WA_MT7916, MT7915_TXQ_MCU_WA);
-		MCUQ_CONFIG(MT_MCUQ_FWDL, WFDMA0, MT_INT_TX_DONE_FWDL, MT7915_TXQ_FWDL);
+		RXQ_CONFIG(MT_RXQ_MCU, WFDMA0, MT_INT_RX_DONE_WM,
+			   MT7916_RXQ_MCU_WM);
+		RXQ_CONFIG(MT_RXQ_BAND1_WA, WFDMA0, MT_INT_RX_DONE_WA_EXT_MT7916,
+			   MT7916_RXQ_MCU_WA_EXT);
+		MCUQ_CONFIG(MT_MCUQ_WM, WFDMA0, MT_INT_TX_DONE_MCU_WM,
+			    MT7915_TXQ_MCU_WM);
+		MCUQ_CONFIG(MT_MCUQ_WA, WFDMA0, MT_INT_TX_DONE_MCU_WA_MT7916,
+			    MT7915_TXQ_MCU_WA);
+		MCUQ_CONFIG(MT_MCUQ_FWDL, WFDMA0, MT_INT_TX_DONE_FWDL,
+			    MT7915_TXQ_FWDL);
 
 		if (is_mt7916(&dev->mt76) && mtk_wed_device_active(&dev->mt76.mmio.wed)) {
 			RXQ_CONFIG(MT_RXQ_MAIN, WFDMA0, MT_INT_WED_RX_DONE_BAND0_MT7916,
@@ -77,16 +91,23 @@ static void mt7915_dma_config(struct mt7915_dev *dev)
 				   MT7916_RXQ_BAND1);
 			RXQ_CONFIG(MT_RXQ_MAIN_WA, WFDMA0, MT_INT_WED_RX_DONE_WA_MAIN_MT7916,
 				   MT7916_RXQ_MCU_WA_MAIN);
-			TXQ_CONFIG(0, WFDMA0, MT_INT_WED_TX_DONE_BAND0, MT7915_TXQ_BAND0);
-			TXQ_CONFIG(1, WFDMA0, MT_INT_WED_TX_DONE_BAND1, MT7915_TXQ_BAND1);
+			TXQ_CONFIG(0, WFDMA0, MT_INT_WED_TX_DONE_BAND0,
+				   MT7915_TXQ_BAND0);
+			TXQ_CONFIG(1, WFDMA0, MT_INT_WED_TX_DONE_BAND1,
+				   MT7915_TXQ_BAND1);
 		} else {
-			RXQ_CONFIG(MT_RXQ_MAIN, WFDMA0, MT_INT_RX_DONE_BAND0_MT7916, MT7916_RXQ_BAND0);
-			RXQ_CONFIG(MT_RXQ_MCU_WA, WFDMA0, MT_INT_RX_DONE_WA, MT7916_RXQ_MCU_WA);
-			RXQ_CONFIG(MT_RXQ_BAND1, WFDMA0, MT_INT_RX_DONE_BAND1_MT7916, MT7916_RXQ_BAND1);
+			RXQ_CONFIG(MT_RXQ_MAIN, WFDMA0, MT_INT_RX_DONE_BAND0_MT7916,
+				   MT7916_RXQ_BAND0);
+			RXQ_CONFIG(MT_RXQ_MCU_WA, WFDMA0, MT_INT_RX_DONE_WA,
+				   MT7916_RXQ_MCU_WA);
+			RXQ_CONFIG(MT_RXQ_BAND1, WFDMA0, MT_INT_RX_DONE_BAND1_MT7916,
+				   MT7916_RXQ_BAND1);
 			RXQ_CONFIG(MT_RXQ_MAIN_WA, WFDMA0, MT_INT_RX_DONE_WA_MAIN_MT7916,
 				   MT7916_RXQ_MCU_WA_MAIN);
-			TXQ_CONFIG(0, WFDMA0, MT_INT_TX_DONE_BAND0, MT7915_TXQ_BAND0);
-			TXQ_CONFIG(1, WFDMA0, MT_INT_TX_DONE_BAND1, MT7915_TXQ_BAND1);
+			TXQ_CONFIG(0, WFDMA0, MT_INT_TX_DONE_BAND0,
+				   MT7915_TXQ_BAND0);
+			TXQ_CONFIG(1, WFDMA0, MT_INT_TX_DONE_BAND1,
+				   MT7915_TXQ_BAND1);
 		}
 	}
 }
@@ -514,6 +535,53 @@ int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2)
 	return 0;
 }
 
+int mt7915_dma_reset(struct mt7915_dev *dev, bool force)
+{
+	struct mt76_phy *mphy_ext = dev->mt76.phys[MT_BAND1];
+	int i;
+
+	/* clean up hw queues */
+	for (i = 0; i < ARRAY_SIZE(dev->mt76.phy.q_tx); i++) {
+		mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[i], true);
+		if (mphy_ext)
+			mt76_queue_tx_cleanup(dev, mphy_ext->q_tx[i], true);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(dev->mt76.q_mcu); i++)
+		mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[i], true);
+
+	mt76_for_each_q_rx(&dev->mt76, i)
+		mt76_queue_rx_cleanup(dev, &dev->mt76.q_rx[i]);
+
+	/* reset wfsys */
+	if (force)
+		mt7915_wfsys_reset(dev);
+
+	mt7915_dma_disable(dev, force);
+
+	/* reset hw queues */
+	for (i = 0; i < __MT_TXQ_MAX; i++) {
+		mt76_queue_reset(dev, dev->mphy.q_tx[i]);
+		if (mphy_ext)
+			mt76_queue_reset(dev, mphy_ext->q_tx[i]);
+	}
+
+	for (i = 0; i < __MT_MCUQ_MAX; i++)
+		mt76_queue_reset(dev, dev->mt76.q_mcu[i]);
+
+	mt76_for_each_q_rx(&dev->mt76, i)
+			mt76_queue_reset(dev, &dev->mt76.q_rx[i]);
+
+	mt76_tx_status_check(&dev->mt76, true);
+
+	mt7915_dma_enable(dev);
+
+	mt76_for_each_q_rx(&dev->mt76, i)
+		mt76_queue_rx_reset(dev, i);
+
+	return 0;
+}
+
 void mt7915_dma_cleanup(struct mt7915_dev *dev)
 {
 	mt7915_dma_disable(dev, true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 324f0f58572b..3b1259f14de6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1306,73 +1306,6 @@ mt7915_update_beacons(struct mt7915_dev *dev)
 		mt7915_update_vif_beacon, mphy_ext->hw);
 }
 
-static void
-mt7915_dma_reset(struct mt7915_dev *dev)
-{
-	struct mt76_phy *mphy_ext = dev->mt76.phys[MT_BAND1];
-	u32 hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
-	int i;
-
-	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
-		   MT_WFDMA0_GLO_CFG_TX_DMA_EN |
-		   MT_WFDMA0_GLO_CFG_RX_DMA_EN);
-
-	if (is_mt7915(&dev->mt76))
-		mt76_clear(dev, MT_WFDMA1_GLO_CFG,
-			   MT_WFDMA1_GLO_CFG_TX_DMA_EN |
-			   MT_WFDMA1_GLO_CFG_RX_DMA_EN);
-	if (dev->hif2) {
-		mt76_clear(dev, MT_WFDMA0_GLO_CFG + hif1_ofs,
-			   MT_WFDMA0_GLO_CFG_TX_DMA_EN |
-			   MT_WFDMA0_GLO_CFG_RX_DMA_EN);
-
-		if (is_mt7915(&dev->mt76))
-			mt76_clear(dev, MT_WFDMA1_GLO_CFG + hif1_ofs,
-				   MT_WFDMA1_GLO_CFG_TX_DMA_EN |
-				   MT_WFDMA1_GLO_CFG_RX_DMA_EN);
-	}
-
-	usleep_range(1000, 2000);
-
-	for (i = 0; i < __MT_TXQ_MAX; i++) {
-		mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[i], true);
-		if (mphy_ext)
-			mt76_queue_tx_cleanup(dev, mphy_ext->q_tx[i], true);
-	}
-
-	for (i = 0; i < __MT_MCUQ_MAX; i++)
-		mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[i], true);
-
-	mt76_for_each_q_rx(&dev->mt76, i)
-		mt76_queue_rx_reset(dev, i);
-
-	mt76_tx_status_check(&dev->mt76, true);
-
-	/* re-init prefetch settings after reset */
-	mt7915_dma_prefetch(dev);
-
-	mt76_set(dev, MT_WFDMA0_GLO_CFG,
-		 MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
-	if (is_mt7915(&dev->mt76))
-		mt76_set(dev, MT_WFDMA1_GLO_CFG,
-			 MT_WFDMA1_GLO_CFG_TX_DMA_EN |
-			 MT_WFDMA1_GLO_CFG_RX_DMA_EN |
-			 MT_WFDMA1_GLO_CFG_OMIT_TX_INFO |
-			 MT_WFDMA1_GLO_CFG_OMIT_RX_INFO);
-	if (dev->hif2) {
-		mt76_set(dev, MT_WFDMA0_GLO_CFG + hif1_ofs,
-			 MT_WFDMA0_GLO_CFG_TX_DMA_EN |
-			 MT_WFDMA0_GLO_CFG_RX_DMA_EN);
-
-		if (is_mt7915(&dev->mt76))
-			mt76_set(dev, MT_WFDMA1_GLO_CFG + hif1_ofs,
-				 MT_WFDMA1_GLO_CFG_TX_DMA_EN |
-				 MT_WFDMA1_GLO_CFG_RX_DMA_EN |
-				 MT_WFDMA1_GLO_CFG_OMIT_TX_INFO |
-				 MT_WFDMA1_GLO_CFG_OMIT_RX_INFO);
-	}
-}
-
 void mt7915_tx_token_put(struct mt7915_dev *dev)
 {
 	struct mt76_txwi_cache *txwi;
@@ -1424,7 +1357,7 @@ void mt7915_mac_reset_work(struct work_struct *work)
 	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_DMA_STOPPED);
 
 	if (mt7915_wait_reset_state(dev, MT_MCU_CMD_RESET_DONE)) {
-		mt7915_dma_reset(dev);
+		mt7915_dma_reset(dev, false);
 
 		mt7915_tx_token_put(dev);
 		idr_init(&dev->mt76.token);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index fe6a6d3b0a32..5af26e60e902 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -443,6 +443,7 @@ s8 mt7915_eeprom_get_power_delta(struct mt7915_dev *dev, int band);
 int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2);
 void mt7915_dma_prefetch(struct mt7915_dev *dev);
 void mt7915_dma_cleanup(struct mt7915_dev *dev);
+int mt7915_dma_reset(struct mt7915_dev *dev, bool force);
 int mt7915_mcu_init(struct mt7915_dev *dev);
 int mt7915_mcu_twt_agrt_update(struct mt7915_dev *dev,
 			       struct mt7915_vif *mvif,
-- 
2.36.1

