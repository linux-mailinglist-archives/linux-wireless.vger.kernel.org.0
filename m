Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E9F7409DB
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 09:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjF1Hwe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 03:52:34 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:38864 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229956AbjF1Hw1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 03:52:27 -0400
X-UUID: 6abd853e158211ee9cb5633481061a41-20230628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=uyeAQJ41FpCQyk0mJ3iq0Q12Uras7GS2UAAYoa1Bqs8=;
        b=F0KMtTD18tgiOOfvkdmjAdJ5C9vOVITZMVrFHBMlgVgF15ZRIecXuHpv0LJDdpbIjjYZRBvXwc+TPbCrWn1+oE19Yc7fPUdZFWiI5IDO6u6JV90CsO/a4U53nyJkL1mFAWqFnRTq2dvUJOnYugndxBlRewc3epZEf4sKrajS+H8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:26f86d35-0d50-43b0-8673-0c43660e5c43,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.27,REQID:26f86d35-0d50-43b0-8673-0c43660e5c43,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:01c9525,CLOUDID:8fd05eda-b4fa-43c8-9c3e-0d3fabd03ec0,B
        ulkID:230628150719B13PDA4Q,BulkQuantity:0,Recheck:0,SF:29|28|17|19|48|38,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,
        TF_CID_SPAM_SDM
X-UUID: 6abd853e158211ee9cb5633481061a41-20230628
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 219939915; Wed, 28 Jun 2023 15:07:17 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Jun 2023 15:07:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Jun 2023 15:07:16 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 16/16] wifi: mt76: mt792x: introduce mt792x_irq_map
Date:   Wed, 28 Jun 2023 15:06:02 +0800
Message-ID: <0143f930926da8bd29ac801284441666c5fe3197.1687919628.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1687919628.git.deren.wu@mediatek.com>
References: <cover.1687919628.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

mt792x_irq_map will be use to share the irq code shared between mt7921
and mt7925

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/dma.c   |  9 ++--
 .../net/wireless/mediatek/mt76/mt7921/pci.c   | 53 ++++++++++++-------
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   |  8 +--
 .../net/wireless/mediatek/mt76/mt7921/regs.h  | 17 ------
 drivers/net/wireless/mediatek/mt76/mt792x.h   | 14 +++++
 .../net/wireless/mediatek/mt76/mt792x_regs.h  | 19 +++++++
 6 files changed, 77 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index 9dcda35cdf73..1ac66526eb02 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -19,7 +19,8 @@ static int mt7921_poll_tx(struct napi_struct *napi, int budget)
 
 	mt76_connac_tx_cleanup(&dev->mt76);
 	if (napi_complete(napi))
-		mt76_connac_irq_enable(&dev->mt76, MT_INT_TX_DONE_ALL);
+		mt76_connac_irq_enable(&dev->mt76,
+				       dev->irq_map->tx.all_complete_mask);
 	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
 
 	return 0;
@@ -72,8 +73,8 @@ static int mt7921_dma_enable(struct mt792x_dev *dev)
 
 	/* enable interrupts for TX/RX rings */
 	mt76_connac_irq_enable(&dev->mt76,
-			       MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
-			       MT_INT_MCU_CMD);
+			       dev->irq_map->tx.all_complete_mask |
+			       MT_INT_RX_DONE_ALL | MT_INT_MCU_CMD);
 	mt76_set(dev, MT_MCU2HOST_SW_INT_ENA, MT_MCU_CMD_WAKE_RX_PCIE);
 
 	return 0;
@@ -139,7 +140,7 @@ int mt7921_wpdma_reinit_cond(struct mt792x_dev *dev)
 	/* check if the wpdma must be reinitialized */
 	if (mt792x_dma_need_reinit(dev)) {
 		/* disable interrutpts */
-		mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
+		mt76_wr(dev, dev->irq_map->host_irq_enable, 0);
 		mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
 
 		err = mt7921_wpdma_reset(dev, false);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 58f6f5a76498..606a7e41a240 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -31,19 +31,22 @@ MODULE_PARM_DESC(disable_aspm, "disable PCI ASPM support");
 static void
 mt7921_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q)
 {
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	const struct mt792x_irq_map *irq_map = dev->irq_map;
+
 	if (q == MT_RXQ_MAIN)
-		mt76_connac_irq_enable(mdev, MT_INT_RX_DONE_DATA);
+		mt76_connac_irq_enable(mdev, irq_map->rx.data_complete_mask);
 	else if (q == MT_RXQ_MCU_WA)
-		mt76_connac_irq_enable(mdev, MT_INT_RX_DONE_WM2);
+		mt76_connac_irq_enable(mdev, irq_map->rx.wm2_complete_mask);
 	else
-		mt76_connac_irq_enable(mdev, MT_INT_RX_DONE_WM);
+		mt76_connac_irq_enable(mdev, irq_map->rx.wm_complete_mask);
 }
 
 static irqreturn_t mt7921_irq_handler(int irq, void *dev_instance)
 {
 	struct mt792x_dev *dev = dev_instance;
 
-	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
+	mt76_wr(dev, dev->irq_map->host_irq_enable, 0);
 
 	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
 		return IRQ_NONE;
@@ -56,9 +59,10 @@ static irqreturn_t mt7921_irq_handler(int irq, void *dev_instance)
 static void mt7921_irq_tasklet(unsigned long data)
 {
 	struct mt792x_dev *dev = (struct mt792x_dev *)data;
+	const struct mt792x_irq_map *irq_map = dev->irq_map;
 	u32 intr, mask = 0;
 
-	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
+	mt76_wr(dev, irq_map->host_irq_enable, 0);
 
 	intr = mt76_rr(dev, MT_WFDMA0_HOST_INT_STA);
 	intr &= dev->mt76.mmio.irqmask;
@@ -67,8 +71,8 @@ static void mt7921_irq_tasklet(unsigned long data)
 	trace_dev_irq(&dev->mt76, intr, dev->mt76.mmio.irqmask);
 
 	mask |= intr & MT_INT_RX_DONE_ALL;
-	if (intr & MT_INT_TX_DONE_MCU)
-		mask |= MT_INT_TX_DONE_MCU;
+	if (intr & irq_map->tx.mcu_complete_mask)
+		mask |= irq_map->tx.mcu_complete_mask;
 
 	if (intr & MT_INT_MCU_CMD) {
 		u32 intr_sw;
@@ -77,23 +81,23 @@ static void mt7921_irq_tasklet(unsigned long data)
 		/* ack MCU2HOST_SW_INT_STA */
 		mt76_wr(dev, MT_MCU_CMD, intr_sw);
 		if (intr_sw & MT_MCU_CMD_WAKE_RX_PCIE) {
-			mask |= MT_INT_RX_DONE_DATA;
-			intr |= MT_INT_RX_DONE_DATA;
+			mask |= irq_map->rx.data_complete_mask;
+			intr |= irq_map->rx.data_complete_mask;
 		}
 	}
 
-	mt76_set_irq_mask(&dev->mt76, MT_WFDMA0_HOST_INT_ENA, mask, 0);
+	mt76_set_irq_mask(&dev->mt76, irq_map->host_irq_enable, mask, 0);
 
-	if (intr & MT_INT_TX_DONE_ALL)
+	if (intr & irq_map->tx.all_complete_mask)
 		napi_schedule(&dev->mt76.tx_napi);
 
-	if (intr & MT_INT_RX_DONE_WM)
+	if (intr & irq_map->rx.wm_complete_mask)
 		napi_schedule(&dev->mt76.napi[MT_RXQ_MCU]);
 
-	if (intr & MT_INT_RX_DONE_WM2)
+	if (intr & irq_map->rx.wm2_complete_mask)
 		napi_schedule(&dev->mt76.napi[MT_RXQ_MCU_WA]);
 
-	if (intr & MT_INT_RX_DONE_DATA)
+	if (intr & irq_map->rx.data_complete_mask)
 		napi_schedule(&dev->mt76.napi[MT_RXQ_MAIN]);
 }
 
@@ -254,6 +258,18 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 		.drv_own = mt7921e_mcu_drv_pmctrl,
 		.fw_own = mt7921e_mcu_fw_pmctrl,
 	};
+	static const struct mt792x_irq_map irq_map = {
+		.host_irq_enable = MT_WFDMA0_HOST_INT_ENA,
+		.tx = {
+			.all_complete_mask = MT_INT_TX_DONE_ALL,
+			.mcu_complete_mask = MT_INT_TX_DONE_MCU,
+		},
+		.rx = {
+			.data_complete_mask = MT_INT_RX_DONE_DATA,
+			.wm_complete_mask = MT_INT_RX_DONE_WM,
+			.wm2_complete_mask = MT_INT_RX_DONE_WM2,
+		},
+	};
 	struct ieee80211_ops *ops;
 	struct mt76_bus_ops *bus_ops;
 	struct mt792x_dev *dev;
@@ -306,6 +322,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	dev = container_of(mdev, struct mt792x_dev, mt76);
 	dev->fw_features = features;
 	dev->hif_ops = &mt7921_pcie_ops;
+	dev->irq_map = &irq_map;
 	mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
 	tasklet_init(&mdev->irq_tasklet, mt7921_irq_tasklet, (unsigned long)dev);
 
@@ -341,7 +358,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_free_dev;
 
-	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
+	mt76_wr(dev, irq_map.host_irq_enable, 0);
 
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
 
@@ -424,7 +441,7 @@ static int mt7921_pci_suspend(struct device *device)
 		   MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
 
 	/* disable interrupt */
-	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
+	mt76_wr(dev, dev->irq_map->host_irq_enable, 0);
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
 	synchronize_irq(pdev->irq);
 	tasklet_kill(&mdev->irq_tasklet);
@@ -472,8 +489,8 @@ static int mt7921_pci_resume(struct device *device)
 	/* enable interrupt */
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
 	mt76_connac_irq_enable(&dev->mt76,
-			       MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
-			       MT_INT_MCU_CMD);
+			       dev->irq_map->tx.all_complete_mask |
+			       MT_INT_RX_DONE_ALL | MT_INT_MCU_CMD);
 	mt76_set(dev, MT_MCU2HOST_SW_INT_ENA, MT_MCU_CMD_WAKE_RX_PCIE);
 
 	/* put dma enabled */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index 7323388327f4..1f508244d615 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -61,7 +61,7 @@ int mt7921e_mac_reset(struct mt792x_dev *dev)
 
 	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
 
-	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
+	mt76_wr(dev, dev->irq_map->host_irq_enable, 0);
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
 
 	set_bit(MT76_RESET, &dev->mphy.state);
@@ -92,9 +92,9 @@ int mt7921e_mac_reset(struct mt792x_dev *dev)
 	dev->fw_assert = false;
 	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
 
-	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA,
-		MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
-		MT_INT_MCU_CMD);
+	mt76_wr(dev, dev->irq_map->host_irq_enable,
+		dev->irq_map->tx.all_complete_mask |
+		MT_INT_RX_DONE_ALL | MT_INT_MCU_CMD);
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
 
 	err = mt7921e_driver_own(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
index 083d655f82e5..43427a3a48af 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
@@ -29,18 +29,6 @@
 #define MT_MDP_TO_WM			1
 
 #define MT_WFDMA0_HOST_INT_ENA		MT_WFDMA0(0x204)
-#define HOST_RX_DONE_INT_ENA0		BIT(0)
-#define HOST_RX_DONE_INT_ENA1		BIT(1)
-#define HOST_RX_DONE_INT_ENA2		BIT(2)
-#define HOST_RX_DONE_INT_ENA3		BIT(3)
-#define HOST_TX_DONE_INT_ENA0		BIT(4)
-#define HOST_TX_DONE_INT_ENA1		BIT(5)
-#define HOST_TX_DONE_INT_ENA2		BIT(6)
-#define HOST_TX_DONE_INT_ENA3		BIT(7)
-#define HOST_TX_DONE_INT_ENA4		BIT(8)
-#define HOST_TX_DONE_INT_ENA5		BIT(9)
-#define HOST_TX_DONE_INT_ENA6		BIT(10)
-#define HOST_TX_DONE_INT_ENA7		BIT(11)
 #define HOST_TX_DONE_INT_ENA8		BIT(12)
 #define HOST_TX_DONE_INT_ENA9		BIT(13)
 #define HOST_TX_DONE_INT_ENA10		BIT(14)
@@ -48,14 +36,10 @@
 #define HOST_TX_DONE_INT_ENA12		BIT(16)
 #define HOST_TX_DONE_INT_ENA13		BIT(17)
 #define HOST_TX_DONE_INT_ENA14		BIT(18)
-#define HOST_RX_COHERENT_EN		BIT(20)
-#define HOST_TX_COHERENT_EN		BIT(21)
 #define HOST_RX_DONE_INT_ENA4		BIT(22)
 #define HOST_RX_DONE_INT_ENA5		BIT(23)
 #define HOST_TX_DONE_INT_ENA16		BIT(26)
 #define HOST_TX_DONE_INT_ENA17		BIT(27)
-#define MCU2HOST_SW_INT_ENA		BIT(29)
-#define HOST_TX_DONE_INT_ENA18		BIT(30)
 
 /* WFDMA interrupt */
 #define MT_INT_RX_DONE_DATA		HOST_RX_DONE_INT_ENA2
@@ -67,7 +51,6 @@
 #define MT_INT_TX_DONE_MCU_WM		HOST_TX_DONE_INT_ENA17
 #define MT_INT_TX_DONE_FWDL		HOST_TX_DONE_INT_ENA16
 #define MT_INT_TX_DONE_BAND0		HOST_TX_DONE_INT_ENA0
-#define MT_INT_MCU_CMD			MCU2HOST_SW_INT_ENA
 
 #define MT_INT_TX_DONE_MCU		(MT_INT_TX_DONE_MCU_WM |	\
 					 MT_INT_TX_DONE_FWDL)
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index f13779d19983..6fd1f542da17 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -114,6 +114,19 @@ struct mt792x_phy {
 	bool roc_grant;
 };
 
+struct mt792x_irq_map {
+	u32 host_irq_enable;
+	struct {
+		u32 all_complete_mask;
+		u32 mcu_complete_mask;
+	} tx;
+	struct {
+		u32 data_complete_mask;
+		u32 wm_complete_mask;
+		u32 wm2_complete_mask;
+	} rx;
+};
+
 struct mt792x_hif_ops {
 	int (*init_reset)(struct mt792x_dev *dev);
 	int (*reset)(struct mt792x_dev *dev);
@@ -145,6 +158,7 @@ struct mt792x_dev {
 	struct mt76_connac_pm pm;
 	struct mt76_connac_coredump coredump;
 	const struct mt792x_hif_ops *hif_ops;
+	const struct mt792x_irq_map *irq_map;
 
 	struct work_struct ipv6_ns_work;
 	/* IPv6 addresses for WoWLAN */
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
index 9c6308ef4cb3..a99af23e4b56 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
@@ -301,6 +301,25 @@
 #define MT_WFDMA0_GLO_CFG_OMIT_TX_INFO	BIT(28)
 #define MT_WFDMA0_GLO_CFG_CLK_GAT_DIS	BIT(30)
 
+#define HOST_RX_DONE_INT_ENA0		BIT(0)
+#define HOST_RX_DONE_INT_ENA1		BIT(1)
+#define HOST_RX_DONE_INT_ENA2		BIT(2)
+#define HOST_RX_DONE_INT_ENA3		BIT(3)
+#define HOST_TX_DONE_INT_ENA0		BIT(4)
+#define HOST_TX_DONE_INT_ENA1		BIT(5)
+#define HOST_TX_DONE_INT_ENA2		BIT(6)
+#define HOST_TX_DONE_INT_ENA3		BIT(7)
+#define HOST_TX_DONE_INT_ENA4		BIT(8)
+#define HOST_TX_DONE_INT_ENA5		BIT(9)
+#define HOST_TX_DONE_INT_ENA6		BIT(10)
+#define HOST_TX_DONE_INT_ENA7		BIT(11)
+#define HOST_RX_COHERENT_EN		BIT(20)
+#define HOST_TX_COHERENT_EN		BIT(21)
+#define MCU2HOST_SW_INT_ENA		BIT(29)
+#define HOST_TX_DONE_INT_ENA18		BIT(30)
+
+#define MT_INT_MCU_CMD			MCU2HOST_SW_INT_ENA
+
 #define MT_WFDMA0_RST_DTX_PTR		MT_WFDMA0(0x20c)
 #define MT_WFDMA0_RST_DRX_PTR		MT_WFDMA0(0x280)
 #define MT_WFDMA0_GLO_CFG_EXT0		MT_WFDMA0(0x2b0)
-- 
2.18.0

