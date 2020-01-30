Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7C0C14DD14
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2020 15:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgA3Or3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jan 2020 09:47:29 -0500
Received: from nbd.name ([46.4.11.11]:57478 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbgA3Or1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jan 2020 09:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=xkKa0kRvPQ8o8soox2oyqizwFLdMResvND7w0q+iL0Q=; b=GreJlHy+cq77Xm83Y35xWwaMRP
        6j3xUVR9ADtrkF1Pk0s7LrwuBiJOrUQYd/p+ei9fnYYBKnj6/EISlsaEKQOvWlqG0nk2TfFJ8nIjF
        gOKn+lJljqqTzLsqtS8MxByvD1p61neMN53VfAvEM+OdtxIxSAwV0za0injjwz8jHdoc=;
Received: from [178.162.209.135] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ixB6L-0001Vo-KF
        for linux-wireless@vger.kernel.org; Thu, 30 Jan 2020 15:47:25 +0100
Received: by maeck.local (Postfix, from userid 501)
        id EF9C67AE4697; Thu, 30 Jan 2020 15:47:18 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 03/15] mt76: mt7615: move mmio related code from pci.c to mmio.c
Date:   Thu, 30 Jan 2020 15:47:06 +0100
Message-Id: <20200130144718.14298-3-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200130144718.14298-1-nbd@nbd.name>
References: <20200130144718.14298-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Will be shared with MT7622 SoC support

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../wireless/mediatek/mt76/mt7615/Makefile    |   2 +-
 .../net/wireless/mediatek/mt76/mt7615/mmio.c  | 105 ++++++++++++++++++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   1 +
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |  97 +---------------
 4 files changed, 108 insertions(+), 97 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/mmio.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Makefile b/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
index dcd6b0e7ce84..a93d147edf44 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
@@ -4,5 +4,5 @@ obj-$(CONFIG_MT7615E) += mt7615e.o
 
 CFLAGS_trace.o := -I$(src)
 
-mt7615e-y := pci.o init.o dma.o eeprom.o main.o mcu.o mac.o \
+mt7615e-y := pci.o init.o dma.o eeprom.o main.o mcu.o mac.o mmio.o \
 	     debugfs.o trace.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
new file mode 100644
index 000000000000..4575bfda81c0
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
@@ -0,0 +1,105 @@
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include "mt7615.h"
+#include "mac.h"
+#include "../trace.h"
+
+u32 mt7615_reg_map(struct mt7615_dev *dev, u32 addr)
+{
+	u32 base = addr & MT_MCU_PCIE_REMAP_2_BASE;
+	u32 offset = addr & MT_MCU_PCIE_REMAP_2_OFFSET;
+
+	mt76_wr(dev, MT_MCU_PCIE_REMAP_2, base);
+
+	return MT_PCIE_REMAP_BASE_2 + offset;
+}
+
+static void
+mt7615_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q)
+{
+	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+
+	mt7615_irq_enable(dev, MT_INT_RX_DONE(q));
+}
+
+static irqreturn_t mt7615_irq_handler(int irq, void *dev_instance)
+{
+	struct mt7615_dev *dev = dev_instance;
+	u32 intr;
+
+	intr = mt76_rr(dev, MT_INT_SOURCE_CSR);
+	mt76_wr(dev, MT_INT_SOURCE_CSR, intr);
+
+	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
+		return IRQ_NONE;
+
+	trace_dev_irq(&dev->mt76, intr, dev->mt76.mmio.irqmask);
+
+	intr &= dev->mt76.mmio.irqmask;
+
+	if (intr & MT_INT_TX_DONE_ALL) {
+		mt7615_irq_disable(dev, MT_INT_TX_DONE_ALL);
+		napi_schedule(&dev->mt76.tx_napi);
+	}
+
+	if (intr & MT_INT_RX_DONE(0)) {
+		mt7615_irq_disable(dev, MT_INT_RX_DONE(0));
+		napi_schedule(&dev->mt76.napi[0]);
+	}
+
+	if (intr & MT_INT_RX_DONE(1)) {
+		mt7615_irq_disable(dev, MT_INT_RX_DONE(1));
+		napi_schedule(&dev->mt76.napi[1]);
+	}
+
+	return IRQ_HANDLED;
+}
+
+int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base, int irq)
+{
+	static const struct mt76_driver_ops drv_ops = {
+		/* txwi_size = txd size + txp size */
+		.txwi_size = MT_TXD_SIZE + sizeof(struct mt7615_txp),
+		.drv_flags = MT_DRV_TXWI_NO_FREE,
+		.survey_flags = SURVEY_INFO_TIME_TX |
+				SURVEY_INFO_TIME_RX |
+				SURVEY_INFO_TIME_BSS_RX,
+		.tx_prepare_skb = mt7615_tx_prepare_skb,
+		.tx_complete_skb = mt7615_tx_complete_skb,
+		.rx_skb = mt7615_queue_rx_skb,
+		.rx_poll_complete = mt7615_rx_poll_complete,
+		.sta_ps = mt7615_sta_ps,
+		.sta_add = mt7615_mac_sta_add,
+		.sta_remove = mt7615_mac_sta_remove,
+		.update_survey = mt7615_update_channel,
+	};
+	struct mt7615_dev *dev;
+	struct mt76_dev *mdev;
+	int ret;
+
+	mdev = mt76_alloc_device(pdev, sizeof(*dev), &mt7615_ops, &drv_ops);
+	if (!mdev)
+		return -ENOMEM;
+
+	dev = container_of(mdev, struct mt7615_dev, mt76);
+	mt76_mmio_init(&dev->mt76, mem_base);
+
+	mdev->rev = (mt76_rr(dev, MT_HW_CHIPID) << 16) |
+		    (mt76_rr(dev, MT_HW_REV) & 0xff);
+	dev_dbg(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
+
+	ret = devm_request_irq(mdev->dev, irq, mt7615_irq_handler,
+			       IRQF_SHARED, KBUILD_MODNAME, dev);
+	if (ret)
+		goto error;
+
+	ret = mt7615_register_device(dev);
+	if (ret)
+		goto error;
+
+	return 0;
+error:
+	ieee80211_free_hw(mt76_hw(dev));
+	return ret;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 900e48592afa..5348bd28001c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -231,6 +231,7 @@ mt7615_ext_phy(struct mt7615_dev *dev)
 extern const struct ieee80211_ops mt7615_ops;
 extern struct pci_driver mt7615_pci_driver;
 
+int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base, int irq);
 u32 mt7615_reg_map(struct mt7615_dev *dev, u32 addr);
 
 int mt7615_register_device(struct mt7615_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index 828f11087b08..caaad936a34a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -10,86 +10,15 @@
 #include <linux/pci.h>
 
 #include "mt7615.h"
-#include "mac.h"
-#include "../trace.h"
 
 static const struct pci_device_id mt7615_pci_device_table[] = {
 	{ PCI_DEVICE(0x14c3, 0x7615) },
 	{ },
 };
 
-u32 mt7615_reg_map(struct mt7615_dev *dev, u32 addr)
-{
-	u32 base = addr & MT_MCU_PCIE_REMAP_2_BASE;
-	u32 offset = addr & MT_MCU_PCIE_REMAP_2_OFFSET;
-
-	mt76_wr(dev, MT_MCU_PCIE_REMAP_2, base);
-
-	return MT_PCIE_REMAP_BASE_2 + offset;
-}
-
-static void
-mt7615_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q)
-{
-	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
-
-	mt7615_irq_enable(dev, MT_INT_RX_DONE(q));
-}
-
-static irqreturn_t mt7615_irq_handler(int irq, void *dev_instance)
-{
-	struct mt7615_dev *dev = dev_instance;
-	u32 intr;
-
-	intr = mt76_rr(dev, MT_INT_SOURCE_CSR);
-	mt76_wr(dev, MT_INT_SOURCE_CSR, intr);
-
-	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
-		return IRQ_NONE;
-
-	trace_dev_irq(&dev->mt76, intr, dev->mt76.mmio.irqmask);
-
-	intr &= dev->mt76.mmio.irqmask;
-
-	if (intr & MT_INT_TX_DONE_ALL) {
-		mt7615_irq_disable(dev, MT_INT_TX_DONE_ALL);
-		napi_schedule(&dev->mt76.tx_napi);
-	}
-
-	if (intr & MT_INT_RX_DONE(0)) {
-		mt7615_irq_disable(dev, MT_INT_RX_DONE(0));
-		napi_schedule(&dev->mt76.napi[0]);
-	}
-
-	if (intr & MT_INT_RX_DONE(1)) {
-		mt7615_irq_disable(dev, MT_INT_RX_DONE(1));
-		napi_schedule(&dev->mt76.napi[1]);
-	}
-
-	return IRQ_HANDLED;
-}
-
 static int mt7615_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
-	static const struct mt76_driver_ops drv_ops = {
-		/* txwi_size = txd size + txp size */
-		.txwi_size = MT_TXD_SIZE + sizeof(struct mt7615_txp),
-		.drv_flags = MT_DRV_TXWI_NO_FREE,
-		.survey_flags = SURVEY_INFO_TIME_TX |
-				SURVEY_INFO_TIME_RX |
-				SURVEY_INFO_TIME_BSS_RX,
-		.tx_prepare_skb = mt7615_tx_prepare_skb,
-		.tx_complete_skb = mt7615_tx_complete_skb,
-		.rx_skb = mt7615_queue_rx_skb,
-		.rx_poll_complete = mt7615_rx_poll_complete,
-		.sta_ps = mt7615_sta_ps,
-		.sta_add = mt7615_mac_sta_add,
-		.sta_remove = mt7615_mac_sta_remove,
-		.update_survey = mt7615_update_channel,
-	};
-	struct mt7615_dev *dev;
-	struct mt76_dev *mdev;
 	int ret;
 
 	ret = pcim_enable_device(pdev);
@@ -106,31 +35,7 @@ static int mt7615_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
-	mdev = mt76_alloc_device(&pdev->dev, sizeof(*dev), &mt7615_ops,
-				 &drv_ops);
-	if (!mdev)
-		return -ENOMEM;
-
-	dev = container_of(mdev, struct mt7615_dev, mt76);
-	mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
-
-	mdev->rev = (mt76_rr(dev, MT_HW_CHIPID) << 16) |
-		    (mt76_rr(dev, MT_HW_REV) & 0xff);
-	dev_dbg(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
-
-	ret = devm_request_irq(mdev->dev, pdev->irq, mt7615_irq_handler,
-			       IRQF_SHARED, KBUILD_MODNAME, dev);
-	if (ret)
-		goto error;
-
-	ret = mt7615_register_device(dev);
-	if (ret)
-		goto error;
-
-	return 0;
-error:
-	ieee80211_free_hw(mt76_hw(dev));
-	return ret;
+	return mt7615_mmio_probe(&pdev->dev, pcim_iomap_table(pdev)[0], pdev->irq);
 }
 
 static void mt7615_pci_remove(struct pci_dev *pdev)
-- 
2.24.0

