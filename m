Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE12E2403B1
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Aug 2020 10:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgHJI6i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Aug 2020 04:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgHJI6h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Aug 2020 04:58:37 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27931C061788
        for <linux-wireless@vger.kernel.org>; Mon, 10 Aug 2020 01:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=4pEvYWwLa73W3R5cKkm1KnTTLjtQ4dieDxtz0y8G8oA=; b=Is7f0DONT5by1wJlcnqFtlDzaC
        iFsARMQBDz+i9YQHROca2vQitiSLM0T1EirwaJRdPXjuTyrlnqGAmbkkVfcm0r3hHwQCfXhBzI/AL
        hlPeh31HyKfGWE2atpzjGw2ZFP+Pe6R4llisGsjKbIV4fo326jC/9pedBewcg1ETvt2Q=;
Received: from p54ae996c.dip0.t-ipconnect.de ([84.174.153.108] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k53dZ-0003XJ-SM
        for linux-wireless@vger.kernel.org; Mon, 10 Aug 2020 10:58:33 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/6] mt76: set interrupt mask register to 0 before requesting irq
Date:   Mon, 10 Aug 2020 10:58:27 +0200
Message-Id: <20200810085832.65662-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Avoids spurious interrupts in case the hardware was running already

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7603/pci.c  | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7603/soc.c  | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7615/mmio.c | 2 ++
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c  | 2 ++
 drivers/net/wireless/mediatek/mt76/mt76x2/pci.c  | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c  | 2 ++
 6 files changed, 12 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/pci.c b/drivers/net/wireless/mediatek/mt76/mt7603/pci.c
index 2f2f337e2201..a5845da3547a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/pci.c
@@ -44,6 +44,8 @@ mt76pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		    (mt76_rr(dev, MT_HW_REV) & 0xff);
 	dev_info(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
 
+	mt76_wr(dev, MT_INT_MASK_CSR, 0);
+
 	ret = devm_request_irq(mdev->dev, pdev->irq, mt7603_irq_handler,
 			       IRQF_SHARED, KBUILD_MODNAME, dev);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/soc.c b/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
index de170765e938..ba927033bbe8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
@@ -35,6 +35,8 @@ mt76_wmac_probe(struct platform_device *pdev)
 		    (mt76_rr(dev, MT_HW_REV) & 0xff);
 	dev_info(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
 
+	mt76_wr(dev, MT_INT_MASK_CSR, 0);
+
 	ret = devm_request_irq(mdev->dev, irq, mt7603_irq_handler,
 			       IRQF_SHARED, KBUILD_MODNAME, dev);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
index 133f93a6ed1b..a0526f06262b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
@@ -227,6 +227,8 @@ int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base,
 	bus_ops->rmw = mt7615_rmw;
 	dev->mt76.bus = bus_ops;
 
+	mt76_wr(dev, MT_INT_MASK_CSR, 0);
+
 	ret = devm_request_irq(mdev->dev, irq, mt7615_irq_handler,
 			       IRQF_SHARED, KBUILD_MODNAME, dev);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
index f7ec3400e368..5e567483b372 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
@@ -180,6 +180,8 @@ mt76x0e_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	mdev->rev = mt76_rr(dev, MT_ASIC_VERSION);
 	dev_info(mdev->dev, "ASIC revision: %08x\n", mdev->rev);
 
+	mt76_wr(dev, MT_INT_MASK_CSR, 0);
+
 	ret = devm_request_irq(mdev->dev, pdev->irq, mt76x02_irq_handler,
 			       IRQF_SHARED, KBUILD_MODNAME, dev);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
index 6dfb0df8ec8a..377cf9c02a6f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
@@ -63,6 +63,8 @@ mt76x2e_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	mdev->rev = mt76_rr(dev, MT_ASIC_VERSION);
 	dev_info(mdev->dev, "ASIC revision: %08x\n", mdev->rev);
 
+	mt76_wr(dev, MT_INT_MASK_CSR, 0);
+
 	ret = devm_request_irq(mdev->dev, pdev->irq, mt76x02_irq_handler,
 			       IRQF_SHARED, KBUILD_MODNAME, dev);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
index 05dd19258f54..59034d480543 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -124,6 +124,8 @@ static int mt7915_pci_probe(struct pci_dev *pdev,
 		    (mt7915_l1_rr(dev, MT_HW_REV) & 0xff);
 	dev_dbg(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
 
+	mt76_wr(dev, MT_INT_MASK_CSR, 0);
+
 	/* master switch of PCIe tnterrupt enable */
 	mt7915_l1_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
 
-- 
2.28.0

