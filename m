Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B237F37640B
	for <lists+linux-wireless@lfdr.de>; Fri,  7 May 2021 12:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhEGKq7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 May 2021 06:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhEGKq6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 May 2021 06:46:58 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53805C061574
        for <linux-wireless@vger.kernel.org>; Fri,  7 May 2021 03:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8TKt9qNCe5iAzVcbZV7KGiZURxRjjbyq8YVe62ovupE=; b=dGGzfqQmj3LdIo0GZNmEC5hNpY
        eVmGPaWX9vMFJTEU8QqU+5sCV8lRuy9xaCQ66uKQ+lScBeaZdQSE38RvzVGiWXal3CbaEcKIIBoc0
        OdP4VH6dkCQohCIlYTUNfL7ZTEHFpR1LXm2W54OumzjPqUR/n5gB0febvew0nvEdzF/o=;
Received: from p4ff13bc6.dip0.t-ipconnect.de ([79.241.59.198] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lexzZ-00068e-Ve
        for linux-wireless@vger.kernel.org; Fri, 07 May 2021 12:45:58 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] mt76: mt7915: add MSI support
Date:   Fri,  7 May 2021 12:45:55 +0200
Message-Id: <20210507104556.20997-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move IRQ processing to a tasklet, similar to MT7615/MT7663

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  1 +
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  7 +++-
 .../net/wireless/mediatek/mt76/mt7915/pci.c   | 39 ++++++++++++++++---
 3 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 822f3aa6bb8b..a8fd822cc46e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -752,6 +752,7 @@ void mt7915_unregister_device(struct mt7915_dev *dev)
 	mt7915_mcu_exit(dev);
 	mt7915_tx_token_put(dev);
 	mt7915_dma_cleanup(dev);
+	tasklet_disable(&dev->irq_tasklet);
 
 	mt76_free_device(&dev->mt76);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 4ea8972d4e2f..7a3c172afc98 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -169,6 +169,7 @@ struct mt7915_dev {
 	struct mt7915_hif *hif2;
 
 	const struct mt76_bus_ops *bus_ops;
+	struct tasklet_struct irq_tasklet;
 	struct mt7915_phy phy;
 
 	u16 chainmask;
@@ -374,9 +375,11 @@ void mt7915_dual_hif_set_irq_mask(struct mt7915_dev *dev, bool write_reg,
 static inline void mt7915_irq_enable(struct mt7915_dev *dev, u32 mask)
 {
 	if (dev->hif2)
-		mt7915_dual_hif_set_irq_mask(dev, true, 0, mask);
+		mt7915_dual_hif_set_irq_mask(dev, false, 0, mask);
 	else
-		mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, 0, mask);
+		mt76_set_irq_mask(&dev->mt76, 0, 0, mask);
+
+	tasklet_schedule(&dev->irq_tasklet);
 }
 
 static inline void mt7915_irq_disable(struct mt7915_dev *dev, u32 mask)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
index 643f171884cf..0bba0efc5bc0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -94,11 +94,15 @@ mt7915_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q)
 }
 
 /* TODO: support 2/4/6/8 MSI-X vectors */
-static irqreturn_t mt7915_irq_handler(int irq, void *dev_instance)
+static void mt7915_irq_tasklet(struct tasklet_struct *t)
 {
-	struct mt7915_dev *dev = dev_instance;
+	struct mt7915_dev *dev = from_tasklet(dev, t, irq_tasklet);
 	u32 intr, intr1, mask;
 
+	mt76_wr(dev, MT_INT_MASK_CSR, 0);
+	if (dev->hif2)
+		mt76_wr(dev, MT_INT1_MASK_CSR, 0);
+
 	intr = mt76_rr(dev, MT_INT_SOURCE_CSR);
 	intr &= dev->mt76.mmio.irqmask;
 	mt76_wr(dev, MT_INT_SOURCE_CSR, intr);
@@ -111,9 +115,6 @@ static irqreturn_t mt7915_irq_handler(int irq, void *dev_instance)
 		intr |= intr1;
 	}
 
-	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
-		return IRQ_NONE;
-
 	trace_dev_irq(&dev->mt76, intr, dev->mt76.mmio.irqmask);
 
 	mask = intr & MT_INT_RX_DONE_ALL;
@@ -150,6 +151,20 @@ static irqreturn_t mt7915_irq_handler(int irq, void *dev_instance)
 			wake_up(&dev->reset_wait);
 		}
 	}
+}
+
+static irqreturn_t mt7915_irq_handler(int irq, void *dev_instance)
+{
+	struct mt7915_dev *dev = dev_instance;
+
+	mt76_wr(dev, MT_INT_MASK_CSR, 0);
+	if (dev->hif2)
+		mt76_wr(dev, MT_INT1_MASK_CSR, 0);
+
+	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
+		return IRQ_NONE;
+
+	tasklet_schedule(&dev->irq_tasklet);
 
 	return IRQ_HANDLED;
 }
@@ -248,12 +263,20 @@ static int mt7915_pci_probe(struct pci_dev *pdev,
 	if (!mdev)
 		return -ENOMEM;
 
+	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (ret < 0)
+		goto free;
+
 	dev = container_of(mdev, struct mt7915_dev, mt76);
 
 	ret = mt7915_mmio_init(mdev, pcim_iomap_table(pdev)[0], pdev->irq);
 	if (ret)
 		goto error;
 
+	tasklet_setup(&dev->irq_tasklet, mt7915_irq_tasklet);
+
+	mt76_wr(dev, MT_INT_MASK_CSR, 0);
+
 	/* master switch of PCIe tnterrupt enable */
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
 
@@ -266,10 +289,14 @@ static int mt7915_pci_probe(struct pci_dev *pdev,
 
 	ret = mt7915_register_device(dev);
 	if (ret)
-		goto error;
+		goto free_irq;
 
 	return 0;
+free_irq:
+	devm_free_irq(mdev->dev, pdev->irq, dev);
 error:
+	pci_free_irq_vectors(pdev);
+free:
 	mt76_free_device(&dev->mt76);
 
 	return ret;
-- 
2.30.1

