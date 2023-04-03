Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196AC6D421E
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 12:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjDCKeS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 06:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjDCKeQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 06:34:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9645DF74E
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 03:34:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06351B81106
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 10:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76139C433A0;
        Mon,  3 Apr 2023 10:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680518049;
        bh=clBHEoeWWAPKygnfEu9d6J4HGYrhjOD9FsJy5iZ0k5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uT1d1Nqk/0s01V5vMitMwbWueZoakgq9oxLSYOu7tS5fgTZ2Ut8hsq74OGltsr0xg
         9INFX4M4LqT9pAeCJLEuJv+7wmh1G81c8OGOFiGvb5fOdkw9y36k7sxgR9eelNXGns
         +HHUvzGuAR9rO//aBVulwjzbtIuZ+VBvT5nQJDKaOUke4ElIgs5KBISXQrObzDvNaF
         MjWKvf818b7frbaxXiIR+gAQBdDqvT+ginx/2NAFIzCm9azmVRkm7J47mPUSbNN06x
         QALoch6+608kmvc/ftRIjgnbqFTJXUBIHMg8VFTlJBl/9KmE4UeLSHRklIelrklKq/
         8oJI5r1RAq7Zw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/6] wifi: mt76: move irq_tasklet in mt76_dev struct
Date:   Mon,  3 Apr 2023 12:33:55 +0200
Message-Id: <c1f8592298645110606ca644721aeb402046a5ff.1680517676.git.lorenzo@kernel.org>
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

irq_tasklet struct is used by most of the drivers (e.g. mt7915, mt7921,
mt7615, mt7663 and mt7996) so move it in common code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h            | 1 +
 drivers/net/wireless/mediatek/mt76/mt7615/mmio.c     | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h   | 4 +---
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/init.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c     | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h   | 3 +--
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h   | 3 +--
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c      | 8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7996/init.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c     | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h   | 3 +--
 15 files changed, 24 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 183b0fc5a2d4..8b4635e99128 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -778,6 +778,7 @@ struct mt76_dev {
 	spinlock_t rx_lock;
 	struct napi_struct napi[__MT_RXQ_MAX];
 	struct sk_buff_head rx_skb[__MT_RXQ_MAX];
+	struct tasklet_struct irq_tasklet;
 
 	struct list_head txwi_cache;
 	struct list_head rxwi_cache;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
index 83173efb56dc..e703400aa551 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
@@ -80,14 +80,14 @@ static irqreturn_t mt7615_irq_handler(int irq, void *dev_instance)
 	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
 		return IRQ_NONE;
 
-	tasklet_schedule(&dev->irq_tasklet);
+	tasklet_schedule(&dev->mt76.irq_tasklet);
 
 	return IRQ_HANDLED;
 }
 
 static void mt7615_irq_tasklet(struct tasklet_struct *t)
 {
-	struct mt7615_dev *dev = from_tasklet(dev, t, irq_tasklet);
+	struct mt7615_dev *dev = from_tasklet(dev, t, mt76.irq_tasklet);
 	u32 intr, mask = 0, tx_mcu_mask = mt7615_tx_mcu_int_mask(dev);
 	u32 mcu_int;
 
@@ -202,7 +202,7 @@ int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base,
 
 	dev = container_of(mdev, struct mt7615_dev, mt76);
 	mt76_mmio_init(&dev->mt76, mem_base);
-	tasklet_setup(&dev->irq_tasklet, mt7615_irq_tasklet);
+	tasklet_setup(&mdev->irq_tasklet, mt7615_irq_tasklet);
 
 	dev->reg_map = map;
 	dev->ops = ops;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 43591b4c1d9a..fbf73f8fda1b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -245,8 +245,6 @@ struct mt7615_dev {
 	};
 
 	const struct mt76_bus_ops *bus_ops;
-	struct tasklet_struct irq_tasklet;
-
 	struct mt7615_phy phy;
 	u64 omac_mask;
 
@@ -416,7 +414,7 @@ static inline void mt7615_irq_enable(struct mt7615_dev *dev, u32 mask)
 {
 	mt76_set_irq_mask(&dev->mt76, 0, 0, mask);
 
-	tasklet_schedule(&dev->irq_tasklet);
+	tasklet_schedule(&dev->mt76.irq_tasklet);
 }
 
 static inline bool mt7615_firmware_offload(struct mt7615_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index b808248943ea..9f43e673518b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -94,7 +94,7 @@ static int mt7615_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 	mt76_for_each_q_rx(mdev, i) {
 		napi_disable(&mdev->napi[i]);
 	}
-	tasklet_kill(&dev->irq_tasklet);
+	tasklet_kill(&mdev->irq_tasklet);
 
 	mt7615_dma_reset(dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
index 0680e002b981..f607eee3fb47 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
@@ -122,7 +122,7 @@ void mt7615_unregister_device(struct mt7615_dev *dev)
 
 	mt7615_tx_token_put(dev);
 	mt7615_dma_cleanup(dev);
-	tasklet_disable(&dev->irq_tasklet);
+	tasklet_disable(&dev->mt76.irq_tasklet);
 
 	mt76_free_device(&dev->mt76);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 71ccefd39cb2..0d52c30ff8fd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -1180,7 +1180,7 @@ static void mt7915_stop_hardware(struct mt7915_dev *dev)
 	mt7915_mcu_exit(dev);
 	mt7915_tx_token_put(dev);
 	mt7915_dma_cleanup(dev);
-	tasklet_disable(&dev->irq_tasklet);
+	tasklet_disable(&dev->mt76.irq_tasklet);
 
 	if (is_mt7986(&dev->mt76))
 		mt7986_wmac_disable(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 97ca55d283fb..3c156c1d589b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1627,7 +1627,7 @@ void mt7915_mac_reset_work(struct work_struct *work)
 	}
 	local_bh_enable();
 
-	tasklet_schedule(&dev->irq_tasklet);
+	tasklet_schedule(&dev->mt76.irq_tasklet);
 
 	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_RESET_DONE);
 	mt7915_wait_reset_state(dev, MT_MCU_CMD_NORMAL_STATE);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 6f0c0e2ae045..49f0410384c0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -916,7 +916,7 @@ static void mt7915_rx_poll_complete(struct mt76_dev *mdev,
 /* TODO: support 2/4/6/8 MSI-X vectors */
 static void mt7915_irq_tasklet(struct tasklet_struct *t)
 {
-	struct mt7915_dev *dev = from_tasklet(dev, t, irq_tasklet);
+	struct mt7915_dev *dev = from_tasklet(dev, t, mt76.irq_tasklet);
 	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
 	u32 intr, intr1, mask;
 
@@ -1000,7 +1000,7 @@ irqreturn_t mt7915_irq_handler(int irq, void *dev_instance)
 	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
 		return IRQ_NONE;
 
-	tasklet_schedule(&dev->irq_tasklet);
+	tasklet_schedule(&dev->mt76.irq_tasklet);
 
 	return IRQ_HANDLED;
 }
@@ -1041,7 +1041,7 @@ struct mt7915_dev *mt7915_mmio_probe(struct device *pdev,
 	if (ret)
 		goto error;
 
-	tasklet_setup(&dev->irq_tasklet, mt7915_irq_tasklet);
+	tasklet_setup(&mdev->irq_tasklet, mt7915_irq_tasklet);
 
 	return dev;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 3cbfb9b6a305..6e089d57971f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -308,7 +308,6 @@ struct mt7915_dev {
 	u32 wfdma_mask;
 
 	const struct mt76_bus_ops *bus_ops;
-	struct tasklet_struct irq_tasklet;
 	struct mt7915_phy phy;
 
 	/* monitor rx chain configured channel */
@@ -581,7 +580,7 @@ static inline void mt7915_irq_enable(struct mt7915_dev *dev, u32 mask)
 	else
 		mt76_set_irq_mask(&dev->mt76, 0, 0, mask);
 
-	tasklet_schedule(&dev->irq_tasklet);
+	tasklet_schedule(&dev->mt76.irq_tasklet);
 }
 
 static inline void mt7915_irq_disable(struct mt7915_dev *dev, u32 mask)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 1af70dac723b..88ca2290cb20 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -287,7 +287,6 @@ struct mt7921_dev {
 
 	const struct mt76_bus_ops *bus_ops;
 	struct mt7921_phy phy;
-	struct tasklet_struct irq_tasklet;
 
 	struct work_struct reset_work;
 	bool hw_full_reset:1;
@@ -395,7 +394,7 @@ static inline void mt7921_irq_enable(struct mt7921_dev *dev, u32 mask)
 {
 	mt76_set_irq_mask(&dev->mt76, 0, 0, mask);
 
-	tasklet_schedule(&dev->irq_tasklet);
+	tasklet_schedule(&dev->mt76.irq_tasklet);
 }
 
 static inline u32
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 1a8a54a46dcc..654b03818a74 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -50,7 +50,7 @@ static irqreturn_t mt7921_irq_handler(int irq, void *dev_instance)
 	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
 		return IRQ_NONE;
 
-	tasklet_schedule(&dev->irq_tasklet);
+	tasklet_schedule(&dev->mt76.irq_tasklet);
 
 	return IRQ_HANDLED;
 }
@@ -122,7 +122,7 @@ static void mt7921e_unregister_device(struct mt7921_dev *dev)
 	mt7921_wfsys_reset(dev);
 	skb_queue_purge(&dev->mt76.mcu.res_q);
 
-	tasklet_disable(&dev->irq_tasklet);
+	tasklet_disable(&dev->mt76.irq_tasklet);
 }
 
 static u32 __mt7921_reg_addr(struct mt7921_dev *dev, u32 addr)
@@ -318,7 +318,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	dev->fw_features = features;
 	dev->hif_ops = &mt7921_pcie_ops;
 	mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
-	tasklet_init(&dev->irq_tasklet, mt7921_irq_tasklet, (unsigned long)dev);
+	tasklet_init(&mdev->irq_tasklet, mt7921_irq_tasklet, (unsigned long)dev);
 
 	dev->phy.dev = dev;
 	dev->phy.mt76 = &dev->mt76.phy;
@@ -430,7 +430,7 @@ static int mt7921_pci_suspend(struct device *device)
 	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
 	synchronize_irq(pdev->irq);
-	tasklet_kill(&dev->irq_tasklet);
+	tasklet_kill(&mdev->irq_tasklet);
 
 	err = mt7921_mcu_fw_pmctrl(dev);
 	if (err)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 946da93eed32..98bfd94bb632 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -897,7 +897,7 @@ void mt7996_unregister_device(struct mt7996_dev *dev)
 	mt7996_mcu_exit(dev);
 	mt7996_tx_token_put(dev);
 	mt7996_dma_cleanup(dev);
-	tasklet_disable(&dev->irq_tasklet);
+	tasklet_disable(&dev->mt76.irq_tasklet);
 
 	mt76_free_device(&dev->mt76);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 3c3506c7c87a..46b76485947c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1881,7 +1881,7 @@ void mt7996_mac_reset_work(struct work_struct *work)
 	}
 	local_bh_enable();
 
-	tasklet_schedule(&dev->irq_tasklet);
+	tasklet_schedule(&dev->mt76.irq_tasklet);
 
 	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_RESET_DONE);
 	mt7996_wait_reset_state(dev, MT_MCU_CMD_NORMAL_STATE);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index 902370a2a639..65fa1260e80b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -251,7 +251,7 @@ static void mt7996_rx_poll_complete(struct mt76_dev *mdev,
 /* TODO: support 2/4/6/8 MSI-X vectors */
 static void mt7996_irq_tasklet(struct tasklet_struct *t)
 {
-	struct mt7996_dev *dev = from_tasklet(dev, t, irq_tasklet);
+	struct mt7996_dev *dev = from_tasklet(dev, t, mt76.irq_tasklet);
 	u32 i, intr, mask, intr1;
 
 	mt76_wr(dev, MT_INT_MASK_CSR, 0);
@@ -308,7 +308,7 @@ irqreturn_t mt7996_irq_handler(int irq, void *dev_instance)
 	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
 		return IRQ_NONE;
 
-	tasklet_schedule(&dev->irq_tasklet);
+	tasklet_schedule(&dev->mt76.irq_tasklet);
 
 	return IRQ_HANDLED;
 }
@@ -349,7 +349,7 @@ struct mt7996_dev *mt7996_mmio_probe(struct device *pdev,
 	if (ret)
 		goto error;
 
-	tasklet_setup(&dev->irq_tasklet, mt7996_irq_tasklet);
+	tasklet_setup(&mdev->irq_tasklet, mt7996_irq_tasklet);
 
 	mt76_wr(dev, MT_INT_MASK_CSR, 0);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 018dfd2b36b0..ddcf27692732 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -238,7 +238,6 @@ struct mt7996_dev {
 	u32 q_wfdma_mask;
 
 	const struct mt76_bus_ops *bus_ops;
-	struct tasklet_struct irq_tasklet;
 	struct mt7996_phy phy;
 
 	/* monitor rx chain configured channel */
@@ -468,7 +467,7 @@ static inline void mt7996_irq_enable(struct mt7996_dev *dev, u32 mask)
 	else
 		mt76_set_irq_mask(&dev->mt76, 0, 0, mask);
 
-	tasklet_schedule(&dev->irq_tasklet);
+	tasklet_schedule(&dev->mt76.irq_tasklet);
 }
 
 static inline void mt7996_irq_disable(struct mt7996_dev *dev, u32 mask)
-- 
2.39.2

