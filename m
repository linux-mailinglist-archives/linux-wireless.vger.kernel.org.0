Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAEE43C625
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Oct 2021 11:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241170AbhJ0JMN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Oct 2021 05:12:13 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:58978 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241176AbhJ0JML (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Oct 2021 05:12:11 -0400
X-UUID: 6d5f807cf05f4a7f918ff24aef9f1d66-20211027
X-UUID: 6d5f807cf05f4a7f918ff24aef9f1d66-20211027
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 87384918; Wed, 27 Oct 2021 17:09:40 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 27 Oct 2021 17:09:39 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Oct
 2021 16:40:32 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 27 Oct 2021 16:40:32 +0800
From:   Bo Jiao <bo.jiao@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH 01/11] mt76: mt7915: add mt7915_mmio_probe() as a common probing function
Date:   Wed, 27 Oct 2021 16:40:09 +0800
Message-ID: <3d79a76ac217820d8ad20e6b6d5039cf6148c74a.1635323366.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1635323366.git.Bo.Jiao@mediatek.com>
References: <cover.1635323366.git.Bo.Jiao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

Add mt7915_mmio_probe() which will be used for the upcoming devices.
This is an intermediate patch to add mt7916 support.

Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  | 232 ++++++++++++++++-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   7 +-
 .../net/wireless/mediatek/mt76/mt7915/pci.c   | 233 ++----------------
 3 files changed, 255 insertions(+), 217 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 1f6ba30..2f8b72b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -1,7 +1,14 @@
 // SPDX-License-Identifier: ISC
 /* Copyright (C) 2020 MediaTek Inc. */
 
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pci.h>
+
 #include "mt7915.h"
+#include "mac.h"
+#include "../trace.h"
 
 static u32 mt7915_reg_map_l1(struct mt7915_dev *dev, u32 addr)
 {
@@ -125,7 +132,9 @@ static u32 mt7915_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32 val)
 	return dev->bus_ops->rmw(mdev, addr, mask, val);
 }
 
-int mt7915_mmio_init(struct mt76_dev *mdev, void __iomem *mem_base, int irq)
+static int mt7915_mmio_init(struct mt76_dev *mdev,
+			    void __iomem *mem_base,
+			    u32 device_id)
 {
 	struct mt76_bus_ops *bus_ops;
 	struct mt7915_dev *dev;
@@ -148,7 +157,228 @@ int mt7915_mmio_init(struct mt76_dev *mdev, void __iomem *mem_base, int irq)
 		    (mt76_rr(dev, MT_HW_REV) & 0xff);
 	dev_dbg(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
 
+	return 0;
+}
+
+void mt7915_dual_hif_set_irq_mask(struct mt7915_dev *dev,
+				  bool write_reg,
+				  u32 clear, u32 set)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mdev->mmio.irq_lock, flags);
+
+	mdev->mmio.irqmask &= ~clear;
+	mdev->mmio.irqmask |= set;
+
+	if (write_reg) {
+		mt76_wr(dev, MT_INT_MASK_CSR, mdev->mmio.irqmask);
+		mt76_wr(dev, MT_INT1_MASK_CSR, mdev->mmio.irqmask);
+	}
+
+	spin_unlock_irqrestore(&mdev->mmio.irq_lock, flags);
+}
+
+static void mt7915_rx_poll_complete(struct mt76_dev *mdev,
+				    enum mt76_rxq_id q)
+{
+	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
+	static const u32 rx_irq_mask[] = {
+		[MT_RXQ_MAIN] = MT_INT_RX_DONE_DATA0,
+		[MT_RXQ_EXT] = MT_INT_RX_DONE_DATA1,
+		[MT_RXQ_MCU] = MT_INT_RX_DONE_WM,
+		[MT_RXQ_MCU_WA] = MT_INT_RX_DONE_WA,
+		[MT_RXQ_EXT_WA] = MT_INT_RX_DONE_WA_EXT,
+	};
+
+	mt7915_irq_enable(dev, rx_irq_mask[q]);
+}
+
+/* TODO: support 2/4/6/8 MSI-X vectors */
+static void mt7915_irq_tasklet(struct tasklet_struct *t)
+{
+	struct mt7915_dev *dev = from_tasklet(dev, t, irq_tasklet);
+	u32 intr, intr1, mask;
+
 	mt76_wr(dev, MT_INT_MASK_CSR, 0);
+	if (dev->hif2)
+		mt76_wr(dev, MT_INT1_MASK_CSR, 0);
+
+	intr = mt76_rr(dev, MT_INT_SOURCE_CSR);
+	intr &= dev->mt76.mmio.irqmask;
+	mt76_wr(dev, MT_INT_SOURCE_CSR, intr);
+
+	if (dev->hif2) {
+		intr1 = mt76_rr(dev, MT_INT1_SOURCE_CSR);
+		intr1 &= dev->mt76.mmio.irqmask;
+		mt76_wr(dev, MT_INT1_SOURCE_CSR, intr1);
+
+		intr |= intr1;
+	}
+
+	trace_dev_irq(&dev->mt76, intr, dev->mt76.mmio.irqmask);
+
+	mask = intr & MT_INT_RX_DONE_ALL;
+	if (intr & MT_INT_TX_DONE_MCU)
+		mask |= MT_INT_TX_DONE_MCU;
+
+	mt7915_irq_disable(dev, mask);
+
+	if (intr & MT_INT_TX_DONE_MCU)
+		napi_schedule(&dev->mt76.tx_napi);
+
+	if (intr & MT_INT_RX_DONE_DATA0)
+		napi_schedule(&dev->mt76.napi[MT_RXQ_MAIN]);
+
+	if (intr & MT_INT_RX_DONE_DATA1)
+		napi_schedule(&dev->mt76.napi[MT_RXQ_EXT]);
+
+	if (intr & MT_INT_RX_DONE_WM)
+		napi_schedule(&dev->mt76.napi[MT_RXQ_MCU]);
+
+	if (intr & MT_INT_RX_DONE_WA)
+		napi_schedule(&dev->mt76.napi[MT_RXQ_MCU_WA]);
+
+	if (intr & MT_INT_RX_DONE_WA_EXT)
+		napi_schedule(&dev->mt76.napi[MT_RXQ_EXT_WA]);
+
+	if (intr & MT_INT_MCU_CMD) {
+		u32 val = mt76_rr(dev, MT_MCU_CMD);
+
+		mt76_wr(dev, MT_MCU_CMD, val);
+		if (val & MT_MCU_CMD_ERROR_MASK) {
+			dev->reset_state = val;
+			ieee80211_queue_work(mt76_hw(dev), &dev->reset_work);
+			wake_up(&dev->reset_wait);
+		}
+	}
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
+
+	return IRQ_HANDLED;
+}
+
+int mt7915_mmio_probe(struct device *pdev,
+		      void __iomem *mem_base,
+		      u32 device_id,
+		      int irq, struct mt7915_hif *hif2)
+{
+	static const struct mt76_driver_ops drv_ops = {
+		/* txwi_size = txd size + txp size */
+		.txwi_size = MT_TXD_SIZE + sizeof(struct mt7915_txp),
+		.drv_flags = MT_DRV_TXWI_NO_FREE | MT_DRV_HW_MGMT_TXQ,
+		.survey_flags = SURVEY_INFO_TIME_TX |
+				SURVEY_INFO_TIME_RX |
+				SURVEY_INFO_TIME_BSS_RX,
+		.token_size = MT7915_TOKEN_SIZE,
+		.tx_prepare_skb = mt7915_tx_prepare_skb,
+		.tx_complete_skb = mt7915_tx_complete_skb,
+		.rx_skb = mt7915_queue_rx_skb,
+		.rx_poll_complete = mt7915_rx_poll_complete,
+		.sta_ps = mt7915_sta_ps,
+		.sta_add = mt7915_mac_sta_add,
+		.sta_remove = mt7915_mac_sta_remove,
+		.update_survey = mt7915_update_channel,
+	};
+	struct ieee80211_ops *ops;
+	struct mt7915_dev *dev;
+	struct mt76_dev *mdev;
+	int ret;
+
+	ops = devm_kmemdup(pdev, &mt7915_ops, sizeof(mt7915_ops), GFP_KERNEL);
+	if (!ops)
+		return -ENOMEM;
+
+	mdev = mt76_alloc_device(pdev, sizeof(*dev), ops, &drv_ops);
+	if (!mdev)
+		return -ENOMEM;
+
+	dev = container_of(mdev, struct mt7915_dev, mt76);
+
+	ret = mt7915_mmio_init(mdev, mem_base, device_id);
+	if (ret)
+		goto error;
+
+	tasklet_setup(&dev->irq_tasklet, mt7915_irq_tasklet);
+
+	mt76_wr(dev, MT_INT_MASK_CSR, 0);
+	/* master switch of PCIe tnterrupt enable */
+	if (dev_is_pci(pdev))
+		mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
+
+	ret = devm_request_irq(mdev->dev, irq, mt7915_irq_handler,
+			       IRQF_SHARED, KBUILD_MODNAME, dev);
+	if (ret)
+		goto error;
+
+	if (hif2) {
+		dev->hif2 = hif2;
+
+		mt76_wr(dev, MT_INT1_MASK_CSR, 0);
+		/* master switch of PCIe tnterrupt enable */
+		if (dev_is_pci(pdev))
+			mt76_wr(dev, MT_PCIE1_MAC_INT_ENABLE, 0xff);
+
+		ret = devm_request_irq(mdev->dev, dev->hif2->irq,
+				       mt7915_irq_handler, IRQF_SHARED,
+				       KBUILD_MODNAME "-hif", dev);
+		if (ret) {
+			put_device(dev->hif2->dev);
+			goto free_irq;
+		}
+	}
+
+	ret = mt7915_register_device(dev);
+	if (ret)
+		goto free_hif2_irq;
 
 	return 0;
+
+free_hif2_irq:
+	if (dev->hif2)
+		devm_free_irq(mdev->dev, dev->hif2->irq, dev);
+free_irq:
+	devm_free_irq(mdev->dev, irq, dev);
+error:
+	mt76_free_device(&dev->mt76);
+
+	return ret;
 }
+
+static int __init mt7915_init(void)
+{
+	int ret;
+
+	ret = pci_register_driver(&mt7915_hif_driver);
+	if (ret)
+		return ret;
+
+	ret = pci_register_driver(&mt7915_pci_driver);
+	if (ret)
+		pci_unregister_driver(&mt7915_hif_driver);
+
+	return ret;
+}
+
+static void __exit mt7915_exit(void)
+{
+	pci_unregister_driver(&mt7915_pci_driver);
+	pci_unregister_driver(&mt7915_hif_driver);
+}
+
+module_init(mt7915_init);
+module_exit(mt7915_exit);
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index c6c846d..05a28c2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -369,7 +369,13 @@ static inline u8 mt7915_lmac_mapping(struct mt7915_dev *dev, u8 ac)
 
 extern const struct ieee80211_ops mt7915_ops;
 extern const struct mt76_testmode_ops mt7915_testmode_ops;
+extern struct pci_driver mt7915_pci_driver;
+extern struct pci_driver mt7915_hif_driver;
 
+int mt7915_mmio_probe(struct device *pdev,
+		      void __iomem *mem_base,
+		      u32 device_id,
+		      int irq, struct mt7915_hif *hif2);
 u32 mt7915_reg_map(struct mt7915_dev *dev, u32 addr);
 u64 __mt7915_get_tsf(struct ieee80211_hw *hw, struct mt7915_vif *mvif);
 int mt7915_register_device(struct mt7915_dev *dev);
@@ -503,7 +509,6 @@ void mt7915_mac_work(struct work_struct *work);
 void mt7915_mac_reset_work(struct work_struct *work);
 void mt7915_mac_sta_rc_work(struct work_struct *work);
 void mt7915_mac_update_stats(struct mt7915_phy *phy);
-int mt7915_mmio_init(struct mt76_dev *mdev, void __iomem *mem_base, int irq);
 void mt7915_mac_twt_teardown_flow(struct mt7915_dev *dev,
 				  struct mt7915_sta *msta,
 				  u8 flowid);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
index 0af4cdb..2aba79a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -26,27 +26,7 @@ static const struct pci_device_id mt7915_hif_device_table[] = {
 	{ },
 };
 
-void mt7915_dual_hif_set_irq_mask(struct mt7915_dev *dev, bool write_reg,
-				  u32 clear, u32 set)
-{
-	struct mt76_dev *mdev = &dev->mt76;
-	unsigned long flags;
-
-	spin_lock_irqsave(&mdev->mmio.irq_lock, flags);
-
-	mdev->mmio.irqmask &= ~clear;
-	mdev->mmio.irqmask |= set;
-
-	if (write_reg) {
-		mt76_wr(dev, MT_INT_MASK_CSR, mdev->mmio.irqmask);
-		mt76_wr(dev, MT_INT1_MASK_CSR, mdev->mmio.irqmask);
-	}
-
-	spin_unlock_irqrestore(&mdev->mmio.irq_lock, flags);
-}
-
-static struct mt7915_hif *
-mt7915_pci_get_hif2(struct mt7915_dev *dev)
+static struct mt7915_hif *mt7915_pci_get_hif2(u32 idx)
 {
 	struct mt7915_hif *hif;
 	u32 val;
@@ -56,7 +36,7 @@ mt7915_pci_get_hif2(struct mt7915_dev *dev)
 	list_for_each_entry(hif, &hif_list, list) {
 		val = readl(hif->regs + MT_PCIE_RECOG_ID);
 		val &= MT_PCIE_RECOG_ID_MASK;
-		if (val != dev->hif_idx)
+		if (val != idx)
 			continue;
 
 		get_device(hif->dev);
@@ -78,123 +58,16 @@ static void mt7915_put_hif2(struct mt7915_hif *hif)
 	put_device(hif->dev);
 }
 
-static void
-mt7915_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q)
-{
-	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
-	static const u32 rx_irq_mask[] = {
-		[MT_RXQ_MAIN] = MT_INT_RX_DONE_DATA0,
-		[MT_RXQ_EXT] = MT_INT_RX_DONE_DATA1,
-		[MT_RXQ_MCU] = MT_INT_RX_DONE_WM,
-		[MT_RXQ_MCU_WA] = MT_INT_RX_DONE_WA,
-		[MT_RXQ_EXT_WA] = MT_INT_RX_DONE_WA_EXT,
-	};
-
-	mt7915_irq_enable(dev, rx_irq_mask[q]);
-}
-
-/* TODO: support 2/4/6/8 MSI-X vectors */
-static void mt7915_irq_tasklet(struct tasklet_struct *t)
-{
-	struct mt7915_dev *dev = from_tasklet(dev, t, irq_tasklet);
-	u32 intr, intr1, mask;
-
-	mt76_wr(dev, MT_INT_MASK_CSR, 0);
-	if (dev->hif2)
-		mt76_wr(dev, MT_INT1_MASK_CSR, 0);
-
-	intr = mt76_rr(dev, MT_INT_SOURCE_CSR);
-	intr &= dev->mt76.mmio.irqmask;
-	mt76_wr(dev, MT_INT_SOURCE_CSR, intr);
-
-	if (dev->hif2) {
-		intr1 = mt76_rr(dev, MT_INT1_SOURCE_CSR);
-		intr1 &= dev->mt76.mmio.irqmask;
-		mt76_wr(dev, MT_INT1_SOURCE_CSR, intr1);
-
-		intr |= intr1;
-	}
-
-	trace_dev_irq(&dev->mt76, intr, dev->mt76.mmio.irqmask);
-
-	mask = intr & MT_INT_RX_DONE_ALL;
-	if (intr & MT_INT_TX_DONE_MCU)
-		mask |= MT_INT_TX_DONE_MCU;
-
-	mt7915_irq_disable(dev, mask);
-
-	if (intr & MT_INT_TX_DONE_MCU)
-		napi_schedule(&dev->mt76.tx_napi);
-
-	if (intr & MT_INT_RX_DONE_DATA0)
-		napi_schedule(&dev->mt76.napi[MT_RXQ_MAIN]);
-
-	if (intr & MT_INT_RX_DONE_DATA1)
-		napi_schedule(&dev->mt76.napi[MT_RXQ_EXT]);
-
-	if (intr & MT_INT_RX_DONE_WM)
-		napi_schedule(&dev->mt76.napi[MT_RXQ_MCU]);
-
-	if (intr & MT_INT_RX_DONE_WA)
-		napi_schedule(&dev->mt76.napi[MT_RXQ_MCU_WA]);
-
-	if (intr & MT_INT_RX_DONE_WA_EXT)
-		napi_schedule(&dev->mt76.napi[MT_RXQ_EXT_WA]);
-
-	if (intr & MT_INT_MCU_CMD) {
-		u32 val = mt76_rr(dev, MT_MCU_CMD);
-
-		mt76_wr(dev, MT_MCU_CMD, val);
-		if (val & MT_MCU_CMD_ERROR_MASK) {
-			dev->reset_state = val;
-			ieee80211_queue_work(mt76_hw(dev), &dev->reset_work);
-			wake_up(&dev->reset_wait);
-		}
-	}
-}
-
-static irqreturn_t mt7915_irq_handler(int irq, void *dev_instance)
-{
-	struct mt7915_dev *dev = dev_instance;
-
-	mt76_wr(dev, MT_INT_MASK_CSR, 0);
-	if (dev->hif2)
-		mt76_wr(dev, MT_INT1_MASK_CSR, 0);
-
-	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
-		return IRQ_NONE;
-
-	tasklet_schedule(&dev->irq_tasklet);
-
-	return IRQ_HANDLED;
-}
-
-static void mt7915_pci_init_hif2(struct mt7915_dev *dev)
+static struct mt7915_hif *mt7915_pci_init_hif2(struct pci_dev *pdev)
 {
-	struct mt7915_hif *hif;
-
-	dev->hif_idx = ++hif_idx;
+	hif_idx++;
 	if (!pci_get_device(PCI_VENDOR_ID_MEDIATEK, 0x7916, NULL))
-		return;
-
-	mt76_wr(dev, MT_PCIE_RECOG_ID, dev->hif_idx | MT_PCIE_RECOG_ID_SEM);
-
-	hif = mt7915_pci_get_hif2(dev);
-	if (!hif)
-		return;
+		return NULL;
 
-	dev->hif2 = hif;
+	writel(hif_idx | MT_PCIE_RECOG_ID_SEM,
+	       pcim_iomap_table(pdev)[0] + MT_PCIE_RECOG_ID);
 
-	mt76_wr(dev, MT_INT1_MASK_CSR, 0);
-
-	if (devm_request_irq(dev->mt76.dev, hif->irq, mt7915_irq_handler,
-			     IRQF_SHARED, KBUILD_MODNAME "-hif", dev)) {
-		mt7915_put_hif2(hif);
-		hif = NULL;
-	}
-
-	/* master switch of PCIe tnterrupt enable */
-	mt76_wr(dev, MT_PCIE1_MAC_INT_ENABLE, 0xff);
+	return mt7915_pci_get_hif2(hif_idx);
 }
 
 static int mt7915_pci_hif2_probe(struct pci_dev *pdev)
@@ -219,25 +92,8 @@ static int mt7915_pci_hif2_probe(struct pci_dev *pdev)
 static int mt7915_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
-	static const struct mt76_driver_ops drv_ops = {
-		/* txwi_size = txd size + txp size */
-		.txwi_size = MT_TXD_SIZE + sizeof(struct mt7915_txp),
-		.drv_flags = MT_DRV_TXWI_NO_FREE | MT_DRV_HW_MGMT_TXQ,
-		.survey_flags = SURVEY_INFO_TIME_TX |
-				SURVEY_INFO_TIME_RX |
-				SURVEY_INFO_TIME_BSS_RX,
-		.token_size = MT7915_TOKEN_SIZE,
-		.tx_prepare_skb = mt7915_tx_prepare_skb,
-		.tx_complete_skb = mt7915_tx_complete_skb,
-		.rx_skb = mt7915_queue_rx_skb,
-		.rx_poll_complete = mt7915_rx_poll_complete,
-		.sta_ps = mt7915_sta_ps,
-		.sta_add = mt7915_mac_sta_add,
-		.sta_remove = mt7915_mac_sta_remove,
-		.update_survey = mt7915_update_channel,
-	};
-	struct mt7915_dev *dev;
-	struct mt76_dev *mdev;
+	struct mt7915_hif *hif2;
+
 	int ret;
 
 	ret = pcim_enable_device(pdev);
@@ -259,46 +115,18 @@ static int mt7915_pci_probe(struct pci_dev *pdev,
 	if (id->device == 0x7916)
 		return mt7915_pci_hif2_probe(pdev);
 
-	mdev = mt76_alloc_device(&pdev->dev, sizeof(*dev), &mt7915_ops,
-				 &drv_ops);
-	if (!mdev)
-		return -ENOMEM;
-
-	dev = container_of(mdev, struct mt7915_dev, mt76);
-
 	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
 	if (ret < 0)
-		goto free;
-
-	ret = mt7915_mmio_init(mdev, pcim_iomap_table(pdev)[0], pdev->irq);
-	if (ret)
-		goto error;
-
-	tasklet_setup(&dev->irq_tasklet, mt7915_irq_tasklet);
-
-	mt76_wr(dev, MT_INT_MASK_CSR, 0);
-
-	/* master switch of PCIe tnterrupt enable */
-	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
+		return ret;
 
-	ret = devm_request_irq(mdev->dev, pdev->irq, mt7915_irq_handler,
-			       IRQF_SHARED, KBUILD_MODNAME, dev);
-	if (ret)
-		goto error;
+	hif2 = mt7915_pci_init_hif2(pdev);
 
-	mt7915_pci_init_hif2(dev);
+	ret = mt7915_mmio_probe(&pdev->dev, pcim_iomap_table(pdev)[0],
+				id->device, pdev->irq, hif2);
+	if (!ret)
+		return 0;
 
-	ret = mt7915_register_device(dev);
-	if (ret)
-		goto free_irq;
-
-	return 0;
-free_irq:
-	devm_free_irq(mdev->dev, pdev->irq, dev);
-error:
 	pci_free_irq_vectors(pdev);
-free:
-	mt76_free_device(&dev->mt76);
 
 	return ret;
 }
@@ -321,47 +149,22 @@ static void mt7915_pci_remove(struct pci_dev *pdev)
 	mt7915_unregister_device(dev);
 }
 
-static struct pci_driver mt7915_hif_driver = {
+struct pci_driver mt7915_hif_driver = {
 	.name		= KBUILD_MODNAME "_hif",
 	.id_table	= mt7915_hif_device_table,
 	.probe		= mt7915_pci_probe,
 	.remove		= mt7915_hif_remove,
 };
 
-static struct pci_driver mt7915_pci_driver = {
+struct pci_driver mt7915_pci_driver = {
 	.name		= KBUILD_MODNAME,
 	.id_table	= mt7915_pci_device_table,
 	.probe		= mt7915_pci_probe,
 	.remove		= mt7915_pci_remove,
 };
 
-static int __init mt7915_init(void)
-{
-	int ret;
-
-	ret = pci_register_driver(&mt7915_hif_driver);
-	if (ret)
-		return ret;
-
-	ret = pci_register_driver(&mt7915_pci_driver);
-	if (ret)
-		pci_unregister_driver(&mt7915_hif_driver);
-
-	return ret;
-}
-
-static void __exit mt7915_exit(void)
-{
-    pci_unregister_driver(&mt7915_pci_driver);
-    pci_unregister_driver(&mt7915_hif_driver);
-}
-
-module_init(mt7915_init);
-module_exit(mt7915_exit);
-
 MODULE_DEVICE_TABLE(pci, mt7915_pci_device_table);
 MODULE_DEVICE_TABLE(pci, mt7915_hif_device_table);
 MODULE_FIRMWARE(MT7915_FIRMWARE_WA);
 MODULE_FIRMWARE(MT7915_FIRMWARE_WM);
 MODULE_FIRMWARE(MT7915_ROM_PATCH);
-MODULE_LICENSE("Dual BSD/GPL");
-- 
2.18.0

