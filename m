Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9383A6D421F
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 12:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjDCKeV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 06:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjDCKeU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 06:34:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD10193F9
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 03:34:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 493C1618A8
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 10:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5613AC433EF;
        Mon,  3 Apr 2023 10:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680518053;
        bh=C9wLPIrJutO0q4Cw+Qqf1FFDxqIEgXR0Bav8OU0FTT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QwWOByuqywHJTxiKndQb5OQJbMLEI8kpC8qVkOp04DCi8fRIJdTy/WICUVPKrUPJ/
         npbOtiE1uvwgETcyNsJjGt6vGYQw+0yS0fDX+J90YIqIJ4I9nP4e9lmdMqRNM1UA+s
         r0VSTdhDoT/WnEcL6HXmGgqihzvfL5ESK0QvSHys5DKKAgi8kIjMDkBHj38MNvZs6E
         ck3HACz+Kj8rUmSu8fvly/2DtcwryrHTmdOVnNsaBL4Ua76QxQARhZXbQu0Q1bxGXE
         zMuzzSBVdfbQm7BLmcoSnjFlCQ3fStG6uhXHmXMTPKA4isY2Us/MtsSs4tWmwPyf1p
         iJAr/gq1tXKFw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/6] wifi: mt76: add mt76_connac_irq_enable utility routine
Date:   Mon,  3 Apr 2023 12:33:56 +0200
Message-Id: <83353b0604fb5db2d977d5cfa97709ad5fae238a.1680517676.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680517676.git.lorenzo@kernel.org>
References: <cover.1680517676.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Most of connac based drivers (mt7921, mt7615, mt7663) share the same
code to enable interrupts. Move it in mt76_connac module.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c    |  5 +++--
 drivers/net/wireless/mediatek/mt76/mt7615/mmio.c   |  4 +---
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h |  7 -------
 drivers/net/wireless/mediatek/mt76/mt76_connac.h   |  6 ++++++
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c    |  8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h |  7 -------
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    | 13 ++++++-------
 7 files changed, 20 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index f1914431ff7f..0ce01ccc5dce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -76,7 +76,8 @@ static int mt7615_poll_tx(struct napi_struct *napi, int budget)
 
 	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WM], false);
 	if (napi_complete(napi))
-		mt7615_irq_enable(dev, mt7615_tx_mcu_int_mask(dev));
+		mt76_connac_irq_enable(&dev->mt76,
+				       mt7615_tx_mcu_int_mask(dev));
 
 	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
 
@@ -297,7 +298,7 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 	else
 	    mask |= MT_INT_MCU_CMD;
 
-	mt7615_irq_enable(dev, mask);
+	mt76_connac_irq_enable(&dev->mt76, mask);
 
 	mt7615_dma_start(dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
index e703400aa551..cb10878dac7e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
@@ -66,9 +66,7 @@ const u32 mt7663e_reg_map[] = {
 static void
 mt7615_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q)
 {
-	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
-
-	mt7615_irq_enable(dev, MT_INT_RX_DONE(q));
+	mt76_connac_irq_enable(mdev, MT_INT_RX_DONE(q));
 }
 
 static irqreturn_t mt7615_irq_handler(int irq, void *dev_instance)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index fbf73f8fda1b..ff910a80a6b4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -410,13 +410,6 @@ void mt7615_mcu_rx_event(struct mt7615_dev *dev, struct sk_buff *skb);
 int mt7615_mcu_rdd_send_pattern(struct mt7615_dev *dev);
 int mt7615_mcu_fw_log_2_host(struct mt7615_dev *dev, u8 ctrl);
 
-static inline void mt7615_irq_enable(struct mt7615_dev *dev, u32 mask)
-{
-	mt76_set_irq_mask(&dev->mt76, 0, 0, mask);
-
-	tasklet_schedule(&dev->mt76.irq_tasklet);
-}
-
 static inline bool mt7615_firmware_offload(struct mt7615_dev *dev)
 {
 	return dev->fw_ver > MT7615_FIRMWARE_V2;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index b339c50bff20..84974dfe1953 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -279,6 +279,12 @@ static inline u8 mt76_connac_spe_idx(u8 antenna_mask)
 	return ant_to_spe[antenna_mask];
 }
 
+static inline void mt76_connac_irq_enable(struct mt76_dev *dev, u32 mask)
+{
+	mt76_set_irq_mask(dev, 0, 0, mask);
+	tasklet_schedule(&dev->irq_tasklet);
+}
+
 int mt76_connac_pm_wake(struct mt76_phy *phy, struct mt76_connac_pm *pm);
 void mt76_connac_power_save_sched(struct mt76_phy *phy,
 				  struct mt76_connac_pm *pm);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index d1f10f6d9adc..7b33881a4b54 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -19,7 +19,7 @@ static int mt7921_poll_tx(struct napi_struct *napi, int budget)
 
 	mt76_connac_tx_cleanup(&dev->mt76);
 	if (napi_complete(napi))
-		mt7921_irq_enable(dev, MT_INT_TX_DONE_ALL);
+		mt76_connac_irq_enable(&dev->mt76, MT_INT_TX_DONE_ALL);
 	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
 
 	return 0;
@@ -123,9 +123,9 @@ static int mt7921_dma_enable(struct mt7921_dev *dev)
 	mt76_set(dev, MT_WFDMA_DUMMY_CR, MT_WFDMA_NEED_REINIT);
 
 	/* enable interrupts for TX/RX rings */
-	mt7921_irq_enable(dev,
-			  MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
-			  MT_INT_MCU_CMD);
+	mt76_connac_irq_enable(&dev->mt76,
+			       MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
+			       MT_INT_MCU_CMD);
 	mt76_set(dev, MT_MCU2HOST_SW_INT_ENA, MT_MCU_CMD_WAKE_RX_PCIE);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 88ca2290cb20..31f356d95090 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -390,13 +390,6 @@ void mt7921_mcu_rx_event(struct mt7921_dev *dev, struct sk_buff *skb);
 int mt7921_mcu_set_rxfilter(struct mt7921_dev *dev, u32 fif,
 			    u8 bit_op, u32 bit_map);
 
-static inline void mt7921_irq_enable(struct mt7921_dev *dev, u32 mask)
-{
-	mt76_set_irq_mask(&dev->mt76, 0, 0, mask);
-
-	tasklet_schedule(&dev->mt76.irq_tasklet);
-}
-
 static inline u32
 mt7921_reg_map_l1(struct mt7921_dev *dev, u32 addr)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 654b03818a74..b7d19b57a877 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -31,14 +31,12 @@ MODULE_PARM_DESC(disable_aspm, "disable PCI ASPM support");
 static void
 mt7921_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q)
 {
-	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
-
 	if (q == MT_RXQ_MAIN)
-		mt7921_irq_enable(dev, MT_INT_RX_DONE_DATA);
+		mt76_connac_irq_enable(mdev, MT_INT_RX_DONE_DATA);
 	else if (q == MT_RXQ_MCU_WA)
-		mt7921_irq_enable(dev, MT_INT_RX_DONE_WM2);
+		mt76_connac_irq_enable(mdev, MT_INT_RX_DONE_WM2);
 	else
-		mt7921_irq_enable(dev, MT_INT_RX_DONE_WM);
+		mt76_connac_irq_enable(mdev, MT_INT_RX_DONE_WM);
 }
 
 static irqreturn_t mt7921_irq_handler(int irq, void *dev_instance)
@@ -474,8 +472,9 @@ static int mt7921_pci_resume(struct device *device)
 
 	/* enable interrupt */
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
-	mt7921_irq_enable(dev, MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
-			  MT_INT_MCU_CMD);
+	mt76_connac_irq_enable(&dev->mt76,
+			       MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
+			       MT_INT_MCU_CMD);
 	mt76_set(dev, MT_MCU2HOST_SW_INT_ENA, MT_MCU_CMD_WAKE_RX_PCIE);
 
 	/* put dma enabled */
-- 
2.39.2

