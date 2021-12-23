Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03DEE47E13A
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Dec 2021 11:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347649AbhLWKTM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Dec 2021 05:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhLWKTM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Dec 2021 05:19:12 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B86C061401
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 02:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=sLIes4ZsUB0nHm6CTACxTMz75YdlrNNlLueBOC0f/Gk=; b=Jvb8HDknYYPMjuV2E0/guEEICq
        FV7O2wPvu8Zy4Ga3Lj5UQhxSGkZ7b/WsmdlcIGX1wdYaDn/BbXAQkiMyNsG7+6LalM3IRwpS2Z/Ki
        5FmplOPXVyoKfzzxyGQHq+R7UMOkqx/ZasFp4yHzp2e1T0kBy9lObWXCcFQB3VYiBbCU=;
Received: from p54ae97a7.dip0.t-ipconnect.de ([84.174.151.167] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1n0LBm-0007aJ-GN
        for linux-wireless@vger.kernel.org; Thu, 23 Dec 2021 11:19:10 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7915: move pci specific code back to pci.c
Date:   Thu, 23 Dec 2021 11:19:08 +0100
Message-Id: <20211223101908.10988-1-nbd@nbd.name>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This avoids the need to check for the device type in mmio.c and makes the code
cleaner

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  | 52 +++-------------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  7 +--
 .../net/wireless/mediatek/mt76/mt7915/pci.c   | 60 +++++++++++++++++--
 3 files changed, 64 insertions(+), 55 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index a6dd33f7576f..f1568f9059d8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -505,7 +505,7 @@ static void mt7915_irq_tasklet(struct tasklet_struct *t)
 	}
 }
 
-static irqreturn_t mt7915_irq_handler(int irq, void *dev_instance)
+irqreturn_t mt7915_irq_handler(int irq, void *dev_instance)
 {
 	struct mt7915_dev *dev = dev_instance;
 
@@ -521,10 +521,8 @@ static irqreturn_t mt7915_irq_handler(int irq, void *dev_instance)
 	return IRQ_HANDLED;
 }
 
-int mt7915_mmio_probe(struct device *pdev,
-		      void __iomem *mem_base,
-		      u32 device_id,
-		      int irq, struct mt7915_hif *hif2)
+struct mt7915_dev *mt7915_mmio_probe(struct device *pdev,
+				     void __iomem *mem_base, u32 device_id)
 {
 	static const struct mt76_driver_ops drv_ops = {
 		/* txwi_size = txd size + txp size */
@@ -551,11 +549,11 @@ int mt7915_mmio_probe(struct device *pdev,
 
 	ops = devm_kmemdup(pdev, &mt7915_ops, sizeof(mt7915_ops), GFP_KERNEL);
 	if (!ops)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	mdev = mt76_alloc_device(pdev, sizeof(*dev), ops, &drv_ops);
 	if (!mdev)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	dev = container_of(mdev, struct mt7915_dev, mt76);
 
@@ -566,49 +564,13 @@ int mt7915_mmio_probe(struct device *pdev,
 	tasklet_setup(&dev->irq_tasklet, mt7915_irq_tasklet);
 
 	mt76_wr(dev, MT_INT_MASK_CSR, 0);
-	/* master switch of PCIe tnterrupt enable */
-	if (dev_is_pci(pdev))
-		mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
-
-	ret = devm_request_irq(mdev->dev, irq, mt7915_irq_handler,
-			       IRQF_SHARED, KBUILD_MODNAME, dev);
-	if (ret)
-		goto error;
 
-	if (hif2 && dev_is_pci(pdev)) {
-		dev->hif2 = hif2;
+	return dev;
 
-		mt76_wr(dev, MT_INT1_MASK_CSR, 0);
-		/* master switch of PCIe tnterrupt enable */
-		if (is_mt7915(mdev))
-			mt76_wr(dev, MT_PCIE1_MAC_INT_ENABLE, 0xff);
-		else
-			mt76_wr(dev, MT_PCIE1_MAC_INT_ENABLE_MT7916, 0xff);
-
-		ret = devm_request_irq(mdev->dev, dev->hif2->irq,
-				       mt7915_irq_handler, IRQF_SHARED,
-				       KBUILD_MODNAME "-hif", dev);
-		if (ret) {
-			put_device(dev->hif2->dev);
-			goto free_irq;
-		}
-	}
-
-	ret = mt7915_register_device(dev);
-	if (ret)
-		goto free_hif2_irq;
-
-	return 0;
-
-free_hif2_irq:
-	if (dev->hif2)
-		devm_free_irq(mdev->dev, dev->hif2->irq, dev);
-free_irq:
-	devm_free_irq(mdev->dev, irq, dev);
 error:
 	mt76_free_device(&dev->mt76);
 
-	return ret;
+	return ERR_PTR(ret);
 }
 
 static int __init mt7915_init(void)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 11615d9324b2..fe1c7a41ca79 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -380,10 +380,9 @@ extern const struct mt76_testmode_ops mt7915_testmode_ops;
 extern struct pci_driver mt7915_pci_driver;
 extern struct pci_driver mt7915_hif_driver;
 
-int mt7915_mmio_probe(struct device *pdev,
-		      void __iomem *mem_base,
-		      u32 device_id,
-		      int irq, struct mt7915_hif *hif2);
+struct mt7915_dev *mt7915_mmio_probe(struct device *pdev,
+				     void __iomem *mem_base, u32 device_id);
+irqreturn_t mt7915_irq_handler(int irq, void *dev_instance);
 u64 __mt7915_get_tsf(struct ieee80211_hw *hw, struct mt7915_vif *mvif);
 int mt7915_register_device(struct mt7915_dev *dev);
 void mt7915_unregister_device(struct mt7915_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
index 92f4b5849cd8..6f819c41a4c4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -95,7 +95,10 @@ static int mt7915_pci_hif2_probe(struct pci_dev *pdev)
 static int mt7915_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
+	struct mt7915_dev *dev;
+	struct mt76_dev *mdev;
 	struct mt7915_hif *hif2;
+	int irq;
 	int ret;
 
 	ret = pcim_enable_device(pdev);
@@ -117,18 +120,63 @@ static int mt7915_pci_probe(struct pci_dev *pdev,
 	if (id->device == 0x7916 || id->device == 0x790a)
 		return mt7915_pci_hif2_probe(pdev);
 
+	dev = mt7915_mmio_probe(&pdev->dev, pcim_iomap_table(pdev)[0],
+				id->device);
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	mdev = &dev->mt76;
+	hif2 = mt7915_pci_init_hif2(pdev);
+
 	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
 	if (ret < 0)
-		return ret;
+		goto free_device;
 
-	hif2 = mt7915_pci_init_hif2(pdev);
+	irq = pdev->irq;
+	ret = devm_request_irq(mdev->dev, irq, mt7915_irq_handler,
+			       IRQF_SHARED, KBUILD_MODNAME, dev);
+	if (ret)
+		goto free_irq_vector;
+
+	mt76_wr(dev, MT_INT_MASK_CSR, 0);
 
-	ret = mt7915_mmio_probe(&pdev->dev, pcim_iomap_table(pdev)[0],
-				id->device, pdev->irq, hif2);
-	if (!ret)
-		return 0;
+	/* master switch of PCIe tnterrupt enable */
+	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
+
+	if (hif2) {
+		dev->hif2 = hif2;
+
+		mt76_wr(dev, MT_INT1_MASK_CSR, 0);
+		/* master switch of PCIe tnterrupt enable */
+		if (is_mt7915(mdev))
+			mt76_wr(dev, MT_PCIE1_MAC_INT_ENABLE, 0xff);
+		else
+			mt76_wr(dev, MT_PCIE1_MAC_INT_ENABLE_MT7916, 0xff);
+
+		ret = devm_request_irq(mdev->dev, dev->hif2->irq,
+				       mt7915_irq_handler, IRQF_SHARED,
+				       KBUILD_MODNAME "-hif", dev);
+		if (ret)
+			goto free_hif2;
+	}
+
+	ret = mt7915_register_device(dev);
+	if (ret)
+		goto free_hif2_irq;
+
+	return 0;
 
+free_hif2_irq:
+	if (dev->hif2)
+		devm_free_irq(mdev->dev, dev->hif2->irq, dev);
+free_hif2:
+	if (dev->hif2)
+		put_device(dev->hif2->dev);
+	devm_free_irq(mdev->dev, irq, dev);
+free_irq_vector:
 	pci_free_irq_vectors(pdev);
+free_device:
+	mt76_free_device(&dev->mt76);
 
 	return ret;
 }
-- 
2.34.1

