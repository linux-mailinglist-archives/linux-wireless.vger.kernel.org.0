Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98A52041B2
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 22:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgFVUNl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 16:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbgFVUNk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 16:13:40 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AAEC061798
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2020 13:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3ZVb/PONgbjIQ8v0i3OsfNDLNOm9xY61ofLH965Z5Yg=; b=sReTeOaPn85Y8gVLTmn0bd06R/
        VWtWICbYTHlvT03m1y05fOTAL6+reOXBSaHg2AUtM1peEAlYHqWr10dwy/4MVqK+RoxzihG2GCFjI
        xDaIy98nMnP7dAfFuTSeVrIKVFFjB2tuHZ4wT/cq864uc2tXCEr8+nSGUe7TzuDvWigw=;
Received: from p54ae948c.dip0.t-ipconnect.de ([84.174.148.140] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jnSoz-0000qE-RJ
        for linux-wireless@vger.kernel.org; Mon, 22 Jun 2020 22:13:37 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/7] mt76: mt7615: add support for accessing mapped registers via bus ops
Date:   Mon, 22 Jun 2020 22:13:22 +0200
Message-Id: <20200622201327.94414-2-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200622201327.94414-1-nbd@nbd.name>
References: <20200622201327.94414-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Makes it possible to read/write them via debugfs, similar to mt7603

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7615/mmio.c  | 46 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  1 +
 2 files changed, 47 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
index 2e99845b9c96..07ad64e4a77a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
@@ -140,6 +140,38 @@ static void mt7615_irq_tasklet(unsigned long data)
 	mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, mask, 0);
 }
 
+static u32 __mt7615_reg_addr(struct mt7615_dev *dev, u32 addr)
+{
+	if (addr < 0x100000)
+		return addr;
+
+	return mt7615_reg_map(dev, addr);
+}
+
+static u32 mt7615_rr(struct mt76_dev *mdev, u32 offset)
+{
+	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+	u32 addr = __mt7615_reg_addr(dev, offset);
+
+	return dev->bus_ops->rr(mdev, addr);
+}
+
+static void mt7615_wr(struct mt76_dev *mdev, u32 offset, u32 val)
+{
+	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+	u32 addr = __mt7615_reg_addr(dev, offset);
+
+	dev->bus_ops->wr(mdev, addr, val);
+}
+
+static u32 mt7615_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32 val)
+{
+	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+	u32 addr = __mt7615_reg_addr(dev, offset);
+
+	return dev->bus_ops->rmw(mdev, addr, mask, val);
+}
+
 int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base,
 		      int irq, const u32 *map)
 {
@@ -159,6 +191,7 @@ int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base,
 		.sta_remove = mt7615_mac_sta_remove,
 		.update_survey = mt7615_update_channel,
 	};
+	struct mt76_bus_ops *bus_ops;
 	struct ieee80211_ops *ops;
 	struct mt7615_dev *dev;
 	struct mt76_dev *mdev;
@@ -182,6 +215,19 @@ int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base,
 		    (mt76_rr(dev, MT_HW_REV) & 0xff);
 	dev_dbg(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
 
+	dev->bus_ops = dev->mt76.bus;
+	bus_ops = devm_kmemdup(dev->mt76.dev, dev->bus_ops, sizeof(*bus_ops),
+			       GFP_KERNEL);
+	if (!bus_ops) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	bus_ops->rr = mt7615_rr;
+	bus_ops->wr = mt7615_wr;
+	bus_ops->rmw = mt7615_rmw;
+	dev->mt76.bus = bus_ops;
+
 	ret = devm_request_irq(mdev->dev, irq, mt7615_irq_handler,
 			       IRQF_SHARED, KBUILD_MODNAME, dev);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 913dac5c3006..78cc2a2c31f7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -240,6 +240,7 @@ struct mt7615_dev {
 		struct mt76_phy mphy;
 	};
 
+	const struct mt76_bus_ops *bus_ops;
 	struct tasklet_struct irq_tasklet;
 
 	struct mt7615_phy phy;
-- 
2.24.0

