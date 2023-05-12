Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60ED26FFFC2
	for <lists+linux-wireless@lfdr.de>; Fri, 12 May 2023 06:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239910AbjELEwQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 May 2023 00:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239869AbjELEwK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 May 2023 00:52:10 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA093C2F
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 21:51:49 -0700 (PDT)
X-UUID: b1420ce0f08011edb20a276fd37b9834-20230512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ui/eBXsB+N6cxv/KxcmJhZD7+NMLHebwpbuHKUv6i7o=;
        b=BLnoPz6roOhjdOQ44txyF2LbodhOnvxk3J88dTBN92NgMy4SIOI2j40OEQNwHhS27zrPhy1pZjmzKZbZQpBIqhHwGRHZquP4x3ME4pQdnLwvbCPS0zUmDdt4wmlZWIW3FVJ08C0iZefTjzfLeXrC+/OmjF/SxXwEozjhL0nkShM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:1cb5275c-aae9-425a-8f0f-d188b4c2f98f,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:178d4d4,CLOUDID:e6c9936b-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: b1420ce0f08011edb20a276fd37b9834-20230512
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 49706873; Fri, 12 May 2023 12:51:43 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 May 2023 12:51:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 May 2023 12:51:42 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/2] wifi: mt76: mt7996: disable WFDMA Tx/Rx during SER recovery
Date:   Fri, 12 May 2023 12:51:41 +0800
Message-ID: <1016fc2da0293d99a23ef9ac7de6dbab0453e955.1683853041.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <42804786054a8b724e47cb143cb669ec6b492c1c.1683853041.git.ryder.lee@mediatek.com>
References: <42804786054a8b724e47cb143cb669ec6b492c1c.1683853041.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

Stop WFDMA transaction to avoid potential unexpected issue while doing
system recovery.

Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/dma.c   | 81 +++++++++++--------
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |  9 ++-
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  1 +
 3 files changed, 55 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
index 534143465d9b..99b00a135711 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
@@ -128,11 +128,55 @@ static void mt7996_dma_disable(struct mt7996_dev *dev, bool reset)
 	}
 }
 
-static int mt7996_dma_enable(struct mt7996_dev *dev)
+void mt7996_dma_start(struct mt7996_dev *dev, bool reset)
 {
 	u32 hif1_ofs = 0;
 	u32 irq_mask;
 
+	if (dev->hif2)
+		hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
+
+	/* enable WFDMA Tx/Rx */
+	if (!reset) {
+		mt76_set(dev, MT_WFDMA0_GLO_CFG,
+			 MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+			 MT_WFDMA0_GLO_CFG_RX_DMA_EN |
+			 MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+			 MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
+
+		if (dev->hif2)
+			mt76_set(dev, MT_WFDMA0_GLO_CFG + hif1_ofs,
+				 MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+				 MT_WFDMA0_GLO_CFG_RX_DMA_EN |
+				 MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+				 MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
+	}
+
+	/* enable interrupts for TX/RX rings */
+	irq_mask = MT_INT_MCU_CMD;
+	if (reset)
+		goto done;
+
+	irq_mask = MT_INT_RX_DONE_MCU | MT_INT_TX_DONE_MCU;
+
+	if (!dev->mphy.band_idx)
+		irq_mask |= MT_INT_BAND0_RX_DONE;
+
+	if (dev->dbdc_support)
+		irq_mask |= MT_INT_BAND1_RX_DONE;
+
+	if (dev->tbtc_support)
+		irq_mask |= MT_INT_BAND2_RX_DONE;
+
+done:
+	mt7996_irq_enable(dev, irq_mask);
+	mt7996_irq_disable(dev, 0);
+}
+
+static void mt7996_dma_enable(struct mt7996_dev *dev, bool reset)
+{
+	u32 hif1_ofs = 0;
+
 	if (dev->hif2)
 		hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
 
@@ -170,13 +214,6 @@ static int mt7996_dma_enable(struct mt7996_dev *dev)
 	mt76_poll(dev, MT_WFDMA_EXT_CSR_HIF_MISC,
 		  MT_WFDMA_EXT_CSR_HIF_MISC_BUSY, 0, 1000);
 
-	/* set WFDMA Tx/Rx */
-	mt76_set(dev, MT_WFDMA0_GLO_CFG,
-		 MT_WFDMA0_GLO_CFG_TX_DMA_EN |
-		 MT_WFDMA0_GLO_CFG_RX_DMA_EN |
-		 MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
-		 MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
-
 	/* GLO_CFG_EXT0 */
 	mt76_set(dev, WF_WFDMA0_GLO_CFG_EXT0,
 		 WF_WFDMA0_GLO_CFG_EXT0_RX_WB_RXD |
@@ -187,12 +224,6 @@ static int mt7996_dma_enable(struct mt7996_dev *dev)
 		 WF_WFDMA0_GLO_CFG_EXT1_TX_FCTRL_MODE);
 
 	if (dev->hif2) {
-		mt76_set(dev, MT_WFDMA0_GLO_CFG + hif1_ofs,
-			 MT_WFDMA0_GLO_CFG_TX_DMA_EN |
-			 MT_WFDMA0_GLO_CFG_RX_DMA_EN |
-			 MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
-			 MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
-
 		/* GLO_CFG_EXT0 */
 		mt76_set(dev, WF_WFDMA0_GLO_CFG_EXT0 + hif1_ofs,
 			 WF_WFDMA0_GLO_CFG_EXT0_RX_WB_RXD |
@@ -216,23 +247,7 @@ static int mt7996_dma_enable(struct mt7996_dev *dev)
 		/* TODO: redirect rx ring6 interrupt to pcie0 for wed function */
 	}
 
-	/* enable interrupts for TX/RX rings */
-	irq_mask = MT_INT_RX_DONE_MCU |
-		   MT_INT_TX_DONE_MCU |
-		   MT_INT_MCU_CMD;
-
-	if (!dev->mphy.band_idx)
-		irq_mask |= MT_INT_BAND0_RX_DONE;
-
-	if (dev->dbdc_support)
-		irq_mask |= MT_INT_BAND1_RX_DONE;
-
-	if (dev->tbtc_support)
-		irq_mask |= MT_INT_BAND2_RX_DONE;
-
-	mt7996_irq_enable(dev, irq_mask);
-
-	return 0;
+	mt7996_dma_start(dev, reset);
 }
 
 int mt7996_dma_init(struct mt7996_dev *dev)
@@ -347,7 +362,7 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 			  mt7996_poll_tx);
 	napi_enable(&dev->mt76.tx_napi);
 
-	mt7996_dma_enable(dev);
+	mt7996_dma_enable(dev, false);
 
 	return 0;
 }
@@ -413,7 +428,7 @@ void mt7996_dma_reset(struct mt7996_dev *dev, bool force)
 	mt76_for_each_q_rx(&dev->mt76, i)
 		mt76_queue_rx_reset(dev, i);
 
-	mt7996_dma_enable(dev);
+	mt7996_dma_enable(dev, !force);
 }
 
 void mt7996_dma_cleanup(struct mt7996_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 130eb7b4fd91..45080f3f82e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2041,6 +2041,12 @@ void mt7996_mac_reset_work(struct work_struct *work)
 		mt7996_wait_reset_state(dev, MT_MCU_CMD_RECOVERY_DONE);
 	}
 
+	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_RESET_DONE);
+	mt7996_wait_reset_state(dev, MT_MCU_CMD_NORMAL_STATE);
+
+	/* enable DMA Tx/Tx and interrupt */
+	mt7996_dma_start(dev, false);
+
 	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
 	clear_bit(MT76_RESET, &dev->mphy.state);
 	if (phy2)
@@ -2057,9 +2063,6 @@ void mt7996_mac_reset_work(struct work_struct *work)
 
 	tasklet_schedule(&dev->mt76.irq_tasklet);
 
-	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_RESET_DONE);
-	mt7996_wait_reset_state(dev, MT_MCU_CMD_NORMAL_STATE);
-
 	mt76_worker_enable(&dev->mt76.tx_worker);
 
 	local_bh_disable();
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 4d7dcb95a620..ad39c2d73a01 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -405,6 +405,7 @@ int mt7996_dma_init(struct mt7996_dev *dev);
 void mt7996_dma_reset(struct mt7996_dev *dev, bool force);
 void mt7996_dma_prefetch(struct mt7996_dev *dev);
 void mt7996_dma_cleanup(struct mt7996_dev *dev);
+void mt7996_dma_start(struct mt7996_dev *dev, bool reset);
 void mt7996_init_txpower(struct mt7996_dev *dev,
 			 struct ieee80211_supported_band *sband);
 int mt7996_txbf_init(struct mt7996_dev *dev);
-- 
2.18.0

