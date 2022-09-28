Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EF55ED8BE
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 11:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbiI1JUM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 05:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiI1JUL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 05:20:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059EB57227
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 02:20:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9190EB8201F
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 09:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED09C433D6;
        Wed, 28 Sep 2022 09:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664356807;
        bh=6nAVtch/fUK9oJxaKzMCbA2vfyqNHgNl734xhiFpDik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DF98xUxwMTlHrPvorGi4Brp2X5qmuWr5S/9UufjsNwYCSRpHccGc99lSmeUwJqFiU
         qgM6oh132fxy7R0JEvODIVuPoySiPlajhwDegdWuY2lDU/W9/7r0SRmRpfwCKHxws2
         Wo4aAyF1gl36jYUs/yialTWwrJqCEG/avoe28LR8Z9cZSv5A/J1iZTcA+vvnpkGB/i
         Ye+GmfPS45rZxhHqe+t0VR0+lOwRNsxtaf8cOC1gr0n1CJ6qHlm17tjK5bw5nC+Udf
         rts9Koyu0tdz0W50fLQl9y8MoS3LrUrDtoV60ggaGogB9758fk6Uh+secNG8jYM4Td
         SVX7aUTnqwXaw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, Bo.Jiao@mediatek.com,
        sujuan.chen@mediatek.com, ryder.Lee@mediatek.com,
        evelyn.tsai@mediatek.com, daniel@makrotopia.org,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH 3/3] wifi: mt76: mt7915: enable wed for mt7986-wmac chipset
Date:   Wed, 28 Sep 2022 11:19:43 +0200
Message-Id: <16f64da96af38765a7ee54c575c1ac0f47825ca6.1664356281.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1664356281.git.lorenzo@kernel.org>
References: <cover.1664356281.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable WED tx support for mt7986-wmac chipset available on mt7986 board.

Tested-by: Daniel Golle <daniel@makrotopia.org>
Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7915/dma.c   | 74 ++++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  | 67 ++++++++++++-----
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  4 +-
 .../net/wireless/mediatek/mt76/mt7915/pci.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/regs.h  | 17 +++--
 .../net/wireless/mediatek/mt76/mt7915/soc.c   | 21 ++++--
 8 files changed, 134 insertions(+), 55 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 90a89cf493a9..e4fa240834d8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -11,7 +11,11 @@ mt7915_init_tx_queues(struct mt7915_phy *phy, int idx, int n_desc, int ring_base
 	struct mt7915_dev *dev = phy->dev;
 
 	if (mtk_wed_device_active(&phy->dev->mt76.mmio.wed)) {
-		ring_base = MT_WED_TX_RING_BASE;
+		if (is_mt7986(&dev->mt76))
+			ring_base += MT_TXQ_ID(0) * MT_RING_SIZE;
+		else
+			ring_base = MT_WED_TX_RING_BASE;
+
 		idx -= MT_TXQ_ID(0);
 	}
 
@@ -58,17 +62,32 @@ static void mt7915_dma_config(struct mt7915_dev *dev)
 		MCUQ_CONFIG(MT_MCUQ_WA, WFDMA1, MT_INT_TX_DONE_MCU_WA, MT7915_TXQ_MCU_WA);
 		MCUQ_CONFIG(MT_MCUQ_FWDL, WFDMA1, MT_INT_TX_DONE_FWDL, MT7915_TXQ_FWDL);
 	} else {
-		RXQ_CONFIG(MT_RXQ_MAIN, WFDMA0, MT_INT_RX_DONE_BAND0_MT7916, MT7916_RXQ_BAND0);
 		RXQ_CONFIG(MT_RXQ_MCU, WFDMA0, MT_INT_RX_DONE_WM, MT7916_RXQ_MCU_WM);
-		RXQ_CONFIG(MT_RXQ_MCU_WA, WFDMA0, MT_INT_RX_DONE_WA, MT7916_RXQ_MCU_WA);
-		RXQ_CONFIG(MT_RXQ_BAND1, WFDMA0, MT_INT_RX_DONE_BAND1_MT7916, MT7916_RXQ_BAND1);
 		RXQ_CONFIG(MT_RXQ_BAND1_WA, WFDMA0, MT_INT_RX_DONE_WA_EXT_MT7916, MT7916_RXQ_MCU_WA_EXT);
-		RXQ_CONFIG(MT_RXQ_MAIN_WA, WFDMA0, MT_INT_RX_DONE_WA_MAIN_MT7916, MT7916_RXQ_MCU_WA_MAIN);
-		TXQ_CONFIG(0, WFDMA0, MT_INT_TX_DONE_BAND0, MT7915_TXQ_BAND0);
-		TXQ_CONFIG(1, WFDMA0, MT_INT_TX_DONE_BAND1, MT7915_TXQ_BAND1);
 		MCUQ_CONFIG(MT_MCUQ_WM, WFDMA0, MT_INT_TX_DONE_MCU_WM, MT7915_TXQ_MCU_WM);
 		MCUQ_CONFIG(MT_MCUQ_WA, WFDMA0, MT_INT_TX_DONE_MCU_WA_MT7916, MT7915_TXQ_MCU_WA);
 		MCUQ_CONFIG(MT_MCUQ_FWDL, WFDMA0, MT_INT_TX_DONE_FWDL, MT7915_TXQ_FWDL);
+
+		if (is_mt7916(&dev->mt76) && mtk_wed_device_active(&dev->mt76.mmio.wed)) {
+			RXQ_CONFIG(MT_RXQ_MAIN, WFDMA0, MT_INT_WED_RX_DONE_BAND0_MT7916,
+				   MT7916_RXQ_BAND0);
+			RXQ_CONFIG(MT_RXQ_MCU_WA, WFDMA0, MT_INT_WED_RX_DONE_WA_MT7916,
+				   MT7916_RXQ_MCU_WA);
+			RXQ_CONFIG(MT_RXQ_BAND1, WFDMA0, MT_INT_WED_RX_DONE_BAND1_MT7916,
+				   MT7916_RXQ_BAND1);
+			RXQ_CONFIG(MT_RXQ_MAIN_WA, WFDMA0, MT_INT_WED_RX_DONE_WA_MAIN_MT7916,
+				   MT7916_RXQ_MCU_WA_MAIN);
+			TXQ_CONFIG(0, WFDMA0, MT_INT_WED_TX_DONE_BAND0, MT7915_TXQ_BAND0);
+			TXQ_CONFIG(1, WFDMA0, MT_INT_WED_TX_DONE_BAND1, MT7915_TXQ_BAND1);
+		} else {
+			RXQ_CONFIG(MT_RXQ_MAIN, WFDMA0, MT_INT_RX_DONE_BAND0_MT7916, MT7916_RXQ_BAND0);
+			RXQ_CONFIG(MT_RXQ_MCU_WA, WFDMA0, MT_INT_RX_DONE_WA, MT7916_RXQ_MCU_WA);
+			RXQ_CONFIG(MT_RXQ_BAND1, WFDMA0, MT_INT_RX_DONE_BAND1_MT7916, MT7916_RXQ_BAND1);
+			RXQ_CONFIG(MT_RXQ_MAIN_WA, WFDMA0, MT_INT_RX_DONE_WA_MAIN_MT7916,
+				   MT7916_RXQ_MCU_WA_MAIN);
+			TXQ_CONFIG(0, WFDMA0, MT_INT_TX_DONE_BAND0, MT7915_TXQ_BAND0);
+			TXQ_CONFIG(1, WFDMA0, MT_INT_TX_DONE_BAND1, MT7915_TXQ_BAND1);
+		}
 	}
 }
 
@@ -323,7 +342,8 @@ static int mt7915_dma_enable(struct mt7915_dev *dev)
 		u32 wed_irq_mask = irq_mask;
 
 		wed_irq_mask |= MT_INT_TX_DONE_BAND0 | MT_INT_TX_DONE_BAND1;
-		mt76_wr(dev, MT_INT_WED_MASK_CSR, wed_irq_mask);
+		if (!is_mt7986(&dev->mt76))
+			mt76_wr(dev, MT_INT_WED_MASK_CSR, wed_irq_mask);
 		mt76_wr(dev, MT_INT_MASK_CSR, wed_irq_mask);
 		mtk_wed_device_start(&dev->mt76.mmio.wed, wed_irq_mask);
 	}
@@ -349,13 +369,18 @@ int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2)
 
 	mt7915_dma_disable(dev, true);
 
-	if (mtk_wed_device_active(&dev->mt76.mmio.wed)) {
-		mt76_set(dev, MT_WFDMA_HOST_CONFIG, MT_WFDMA_HOST_CONFIG_WED);
-
-		mt76_wr(dev, MT_WFDMA_WED_RING_CONTROL,
-			FIELD_PREP(MT_WFDMA_WED_RING_CONTROL_TX0, 18) |
-			FIELD_PREP(MT_WFDMA_WED_RING_CONTROL_TX1, 19) |
-			FIELD_PREP(MT_WFDMA_WED_RING_CONTROL_RX1, 1));
+	if (mtk_wed_device_active(&mdev->mmio.wed)) {
+		if (!is_mt7986(mdev)) {
+			u8 wed_control_rx1 = is_mt7915(mdev) ? 1 : 2;
+
+			mt76_set(dev, MT_WFDMA_HOST_CONFIG,
+				 MT_WFDMA_HOST_CONFIG_WED);
+			mt76_wr(dev, MT_WFDMA_WED_RING_CONTROL,
+				FIELD_PREP(MT_WFDMA_WED_RING_CONTROL_TX0, 18) |
+				FIELD_PREP(MT_WFDMA_WED_RING_CONTROL_TX1, 19) |
+				FIELD_PREP(MT_WFDMA_WED_RING_CONTROL_RX1,
+					   wed_control_rx1));
+		}
 	} else {
 		mt76_clear(dev, MT_WFDMA_HOST_CONFIG, MT_WFDMA_HOST_CONFIG_WED);
 	}
@@ -411,7 +436,7 @@ int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2)
 		return ret;
 
 	/* event from WA */
-	if (mtk_wed_device_active(&dev->mt76.mmio.wed)) {
+	if (mtk_wed_device_active(&mdev->mmio.wed) && is_mt7915(mdev)) {
 		wa_rx_base = MT_WED_RX_RING_BASE;
 		wa_rx_idx = MT7915_RXQ_MCU_WA;
 		dev->mt76.q_rx[MT_RXQ_MCU_WA].flags = MT_WED_Q_TXFREE;
@@ -438,11 +463,20 @@ int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2)
 
 	/* tx free notify event from WA for band0 */
 	if (!is_mt7915(mdev)) {
+		wa_rx_base = MT_RXQ_RING_BASE(MT_RXQ_MAIN_WA);
+		wa_rx_idx = MT_RXQ_ID(MT_RXQ_MAIN_WA);
+
+		if (mtk_wed_device_active(&mdev->mmio.wed)) {
+			mdev->q_rx[MT_RXQ_MAIN_WA].flags = MT_WED_Q_TXFREE;
+			if (is_mt7916(mdev)) {
+				wa_rx_base =  MT_WED_RX_RING_BASE;
+				wa_rx_idx = MT7915_RXQ_MCU_WA;
+			}
+		}
+
 		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN_WA],
-				       MT_RXQ_ID(MT_RXQ_MAIN_WA),
-				       MT7915_RX_MCU_RING_SIZE,
-				       MT_RX_BUF_SIZE,
-				       MT_RXQ_RING_BASE(MT_RXQ_MAIN_WA));
+				       wa_rx_idx, MT7915_RX_MCU_RING_SIZE,
+				       MT_RX_BUF_SIZE, wa_rx_base);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 89b519cfd14c..7972760aec83 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1431,7 +1431,7 @@ mt7915_net_fill_forward_path(struct ieee80211_hw *hw,
 	path->dev = ctx->dev;
 	path->mtk_wdma.wdma_idx = wed->wdma_idx;
 	path->mtk_wdma.bss = mvif->mt76.idx;
-	path->mtk_wdma.wcid = msta->wcid.idx;
+	path->mtk_wdma.wcid = is_mt7915(&dev->mt76) ? msta->wcid.idx : 0x3ff;
 	path->mtk_wdma.queue = phy != &dev->phy;
 
 	ctx->dev = NULL;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 8d297e4aa7d4..d56b6d6e99bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2274,7 +2274,7 @@ int mt7915_mcu_init(struct mt7915_dev *dev)
 	if (ret)
 		return ret;
 
-	if (mtk_wed_device_active(&dev->mt76.mmio.wed))
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed) && is_mt7915(&dev->mt76))
 		mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(CAPABILITY), 0, 0, 0);
 
 	ret = mt7915_mcu_set_mwds(dev, 1);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 5676d62933ad..2ffb509cad5c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -27,6 +27,8 @@ static const u32 mt7915_reg[] = {
 	[INFRA_MCU_ADDR_END]	= 0x7c3fffff,
 	[FW_EXCEPTION_ADDR]	= 0x219848,
 	[SWDEF_BASE_ADDR]	= 0x41f200,
+	[TXQ_WED_RING_BASE]	= 0xd7300,
+	[RXQ_WED_RING_BASE]	= 0xd7410,
 };
 
 static const u32 mt7916_reg[] = {
@@ -43,6 +45,8 @@ static const u32 mt7916_reg[] = {
 	[INFRA_MCU_ADDR_END]	= 0x7c085fff,
 	[FW_EXCEPTION_ADDR]	= 0x022050bc,
 	[SWDEF_BASE_ADDR]	= 0x411400,
+	[TXQ_WED_RING_BASE]	= 0xd7300,
+	[RXQ_WED_RING_BASE]	= 0xd7410,
 };
 
 static const u32 mt7986_reg[] = {
@@ -59,6 +63,8 @@ static const u32 mt7986_reg[] = {
 	[INFRA_MCU_ADDR_END]	= 0x7c085fff,
 	[FW_EXCEPTION_ADDR]	= 0x02204ffc,
 	[SWDEF_BASE_ADDR]	= 0x411400,
+	[TXQ_WED_RING_BASE]	= 0x24420,
+	[RXQ_WED_RING_BASE]	= 0x24520,
 };
 
 static const u32 mt7915_offs[] = {
@@ -528,8 +534,8 @@ static void mt7915_mmio_wed_offload_disable(struct mtk_wed_device *wed)
 }
 #endif
 
-int mt7915_mmio_wed_init(struct mt7915_dev *dev, struct pci_dev *pdev,
-			 int *irq)
+int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
+			 bool pci, int *irq)
 {
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
 	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
@@ -538,27 +544,46 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, struct pci_dev *pdev,
 	if (!wed_enable)
 		return 0;
 
-	wed->wlan.pci_dev = pdev;
-	wed->wlan.wpdma_phys = pci_resource_start(pdev, 0) +
-			       MT_WFDMA_EXT_CSR_BASE;
-	wed->wlan.wpdma_int = pci_resource_start(pdev, 0) +
-			      MT_INT_WED_SOURCE_CSR;
-	wed->wlan.wpdma_mask = pci_resource_start(pdev, 0) +
-			       MT_INT_WED_MASK_CSR;
-	wed->wlan.wpdma_tx = pci_resource_start(pdev, 0) +
-			     MT_TXQ_WED_RING_BASE;
-	wed->wlan.wpdma_txfree = pci_resource_start(pdev, 0) +
-				 MT_RXQ_WED_RING_BASE;
+	if (pci) {
+		struct pci_dev *pci_dev = pdev_ptr;
+
+		wed->wlan.pci_dev = pci_dev;
+		wed->wlan.bus_type = MTK_WED_BUS_PCIE;
+		wed->wlan.wpdma_int = pci_resource_start(pci_dev, 0) +
+				      MT_INT_WED_SOURCE_CSR;
+		wed->wlan.wpdma_mask = pci_resource_start(pci_dev, 0) +
+				       MT_INT_WED_MASK_CSR;
+		wed->wlan.wpdma_phys = pci_resource_start(pci_dev, 0) +
+				       MT_WFDMA_EXT_CSR_BASE;
+		wed->wlan.wpdma_tx = pci_resource_start(pci_dev, 0) +
+				     MT_TXQ_WED_RING_BASE;
+		wed->wlan.wpdma_txfree = pci_resource_start(pci_dev, 0) +
+					 MT_RXQ_WED_RING_BASE;
+	} else {
+		struct platform_device *plat_dev = pdev_ptr;
+		struct resource *res;
+
+		res = platform_get_resource(plat_dev, IORESOURCE_MEM, 0);
+		if (!res)
+			return -ENOMEM;
+
+		wed->wlan.platform_dev = plat_dev;
+		wed->wlan.bus_type = MTK_WED_BUS_AXI;
+		wed->wlan.wpdma_int = res->start + MT_INT_SOURCE_CSR;
+		wed->wlan.wpdma_mask = res->start + MT_INT_MASK_CSR;
+		wed->wlan.wpdma_tx = res->start + MT_TXQ_WED_RING_BASE;
+		wed->wlan.wpdma_txfree = res->start + MT_RXQ_WED_RING_BASE;
+	}
 	wed->wlan.nbuf = 4096;
-	wed->wlan.tx_tbit[0] = MT_WED_TX_DONE_BAND0;
-	wed->wlan.tx_tbit[1] = MT_WED_TX_DONE_BAND1;
-	wed->wlan.txfree_tbit = MT_WED_TX_FREE_DONE;
+	wed->wlan.tx_tbit[0] = is_mt7915(&dev->mt76) ? 4 : 30;
+	wed->wlan.tx_tbit[1] = is_mt7915(&dev->mt76) ? 5 : 31;
+	wed->wlan.txfree_tbit = is_mt7915(&dev->mt76) ? 1 : 2;
 	wed->wlan.token_start = MT7915_TOKEN_SIZE - wed->wlan.nbuf;
 	wed->wlan.init_buf = mt7915_wed_init_buf;
 	wed->wlan.offload_enable = mt7915_mmio_wed_offload_enable;
 	wed->wlan.offload_disable = mt7915_mmio_wed_offload_disable;
 
-	if (mtk_wed_device_attach(wed) != 0)
+	if (mtk_wed_device_attach(wed))
 		return 0;
 
 	*irq = wed->irq;
@@ -638,7 +663,11 @@ void mt7915_dual_hif_set_irq_mask(struct mt7915_dev *dev,
 	mdev->mmio.irqmask |= set;
 
 	if (write_reg) {
-		mt76_wr(dev, MT_INT_MASK_CSR, mdev->mmio.irqmask);
+		if (mtk_wed_device_active(&mdev->mmio.wed))
+			mtk_wed_device_irq_set_mask(&mdev->mmio.wed,
+						    mdev->mmio.irqmask);
+		else
+			mt76_wr(dev, MT_INT_MASK_CSR, mdev->mmio.irqmask);
 		mt76_wr(dev, MT_INT1_MASK_CSR, mdev->mmio.irqmask);
 	}
 
@@ -662,6 +691,8 @@ static void mt7915_irq_tasklet(struct tasklet_struct *t)
 
 	if (mtk_wed_device_active(wed)) {
 		mtk_wed_device_irq_set_mask(wed, 0);
+		if (dev->hif2)
+			mt76_wr(dev, MT_INT1_MASK_CSR, 0);
 		intr = mtk_wed_device_irq_get(wed, dev->mt76.mmio.irqmask);
 	} else {
 		mt76_wr(dev, MT_INT_MASK_CSR, 0);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 93999d633b75..a1bf1d7e7734 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -590,7 +590,7 @@ bool mt7915_debugfs_rx_log(struct mt7915_dev *dev, const void *data, int len);
 void mt7915_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			    struct ieee80211_sta *sta, struct dentry *dir);
 #endif
-int mt7915_mmio_wed_init(struct mt7915_dev *dev, struct pci_dev *pdev,
-			 int *irq);
+int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
+			 bool pci, int *irq);
 
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
index d73b78bba3e5..743f01f6eae9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -129,7 +129,7 @@ static int mt7915_pci_probe(struct pci_dev *pdev,
 	mt7915_wfsys_reset(dev);
 	hif2 = mt7915_pci_init_hif2(pdev);
 
-	ret = mt7915_mmio_wed_init(dev, pdev, &irq);
+	ret = mt7915_mmio_wed_init(dev, pdev, true, &irq);
 	if (ret < 0)
 		goto free_wed_or_irq_vector;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index d9642c5817e9..5180dd931835 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -26,6 +26,8 @@ enum reg_rev {
 	INFRA_MCU_ADDR_END,
 	FW_EXCEPTION_ADDR,
 	SWDEF_BASE_ADDR,
+	TXQ_WED_RING_BASE,
+	RXQ_WED_RING_BASE,
 	__MT_REG_MAX,
 };
 
@@ -643,12 +645,8 @@ enum offs_rev {
 #define MT_TXQ_EXT_CTRL(q)		(MT_Q_BASE(__TXQ(q)) + 0x600 +	\
 					 MT_TXQ_ID(q)* 0x4)
 
-#define MT_TXQ_WED_RING_BASE		0xd7300
-#define MT_RXQ_WED_RING_BASE		0xd7410
-
-#define MT_WED_TX_DONE_BAND0		4
-#define MT_WED_TX_DONE_BAND1		5
-#define MT_WED_TX_FREE_DONE		1
+#define MT_TXQ_WED_RING_BASE		__REG(TXQ_WED_RING_BASE)
+#define MT_RXQ_WED_RING_BASE		__REG(RXQ_WED_RING_BASE)
 
 #define MT_INT_SOURCE_CSR		__REG(INT_SOURCE_CSR)
 #define MT_INT_MASK_CSR			__REG(INT_MASK_CSR)
@@ -668,6 +666,11 @@ enum offs_rev {
 #define MT_INT_RX_DONE_WA_MAIN_MT7916	BIT(2)
 #define MT_INT_RX_DONE_WA_EXT_MT7916	BIT(3)
 
+#define MT_INT_WED_RX_DONE_BAND0_MT7916		BIT(18)
+#define MT_INT_WED_RX_DONE_BAND1_MT7916		BIT(19)
+#define MT_INT_WED_RX_DONE_WA_MAIN_MT7916	BIT(1)
+#define MT_INT_WED_RX_DONE_WA_MT7916		BIT(17)
+
 #define MT_INT_RX(q)			(dev->q_int_mask[__RXQ(q)])
 #define MT_INT_TX_MCU(q)		(dev->q_int_mask[(q)])
 
@@ -691,6 +694,8 @@ enum offs_rev {
 #define MT_INT_TX_DONE_BAND0		BIT(30)
 #define MT_INT_TX_DONE_BAND1		BIT(31)
 #define MT_INT_TX_DONE_MCU_WA_MT7916	BIT(25)
+#define MT_INT_WED_TX_DONE_BAND0	BIT(4)
+#define MT_INT_WED_TX_DONE_BAND1	BIT(5)
 
 #define MT_INT_TX_DONE_MCU		(MT_INT_TX_MCU(MT_MCUQ_WA) |	\
 					 MT_INT_TX_MCU(MT_MCUQ_WM) |	\
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
index c74afa746251..c06c56a0270d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
@@ -1172,10 +1172,6 @@ static int mt7986_wmac_probe(struct platform_device *pdev)
 
 	chip_id = (uintptr_t)of_device_get_match_data(&pdev->dev);
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
 	mem_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mem_base)) {
 		dev_err(&pdev->dev, "Failed to get memory resource\n");
@@ -1187,6 +1183,18 @@ static int mt7986_wmac_probe(struct platform_device *pdev)
 		return PTR_ERR(dev);
 
 	mdev = &dev->mt76;
+	ret = mt7915_mmio_wed_init(dev, pdev, false, &irq);
+	if (ret < 0)
+		goto free_device;
+
+	if (!ret) {
+		irq = platform_get_irq(pdev, 0);
+		if (irq < 0) {
+			ret = irq;
+			goto free_device;
+		}
+	}
+
 	ret = devm_request_irq(mdev->dev, irq, mt7915_irq_handler,
 			       IRQF_SHARED, KBUILD_MODNAME, dev);
 	if (ret)
@@ -1206,9 +1214,10 @@ static int mt7986_wmac_probe(struct platform_device *pdev)
 
 free_irq:
 	devm_free_irq(mdev->dev, irq, dev);
-
 free_device:
-	mt76_free_device(&dev->mt76);
+	if (mtk_wed_device_active(&mdev->mmio.wed))
+		mtk_wed_device_detach(&mdev->mmio.wed);
+	mt76_free_device(mdev);
 
 	return ret;
 }
-- 
2.37.3

