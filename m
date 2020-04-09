Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6B81A39AA
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2020 20:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgDISOH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Apr 2020 14:14:07 -0400
Received: from nbd.name ([46.4.11.11]:59826 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgDISOH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Apr 2020 14:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=B6jjiQyha5+H0c3ksayL63R5nLu7BQOaOuj7V+auOXI=; b=RHDnKIfffPN2gX6bvJETQjdD0R
        BtiMZXPsQuxtQEXw+hwqLH/lohuLbhztENzqQN+VqT4rtYHj2uoGdwGUlrmQcMvIqg/oyMChYhjBO
        IqdvyGmP8hp29uXuMZ4Nc6D6Qxdt3EXsVExGAARwc/8P3Wf4VdlL2kP5O7ycQrzAFs8I=;
Received: from p54ae91d1.dip0.t-ipconnect.de ([84.174.145.209] helo=maeck.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jMbgg-00007z-QG; Thu, 09 Apr 2020 20:14:02 +0200
Received: by maeck.lan (Postfix, from userid 501)
        id 3FC11829C694; Thu,  9 Apr 2020 20:14:02 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     Soul Huang <Soul.Huang@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v2] mt76: mt7615: rework IRQ handling to prepare for MSI support
Date:   Thu,  9 Apr 2020 20:14:01 +0200
Message-Id: <20200409181401.12070-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With MSI interrupts, IRQs must not be enabled from within the IRQ handler,
because that can lead to lost events.
Defer IRQ processing to a tasklet, which is also responsible for enabling
IRQs (to avoid race conditions against the handler)

Co-developed-by: Soul Huang <Soul.Huang@mediatek.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v2: fix potential irq storm on init

 drivers/net/wireless/mediatek/mt76/mmio.c     |  3 +-
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  2 ++
 .../net/wireless/mediatek/mt76/mt7615/mmio.c  | 29 ++++++++++++++-----
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  9 +++---
 4 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mmio.c b/drivers/net/wireless/mediatek/mt76/mmio.c
index 7ead6620bb8b..26353b6bce97 100644
--- a/drivers/net/wireless/mediatek/mt76/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mmio.c
@@ -73,7 +73,8 @@ void mt76_set_irq_mask(struct mt76_dev *dev, u32 addr,
 	spin_lock_irqsave(&dev->mmio.irq_lock, flags);
 	dev->mmio.irqmask &= ~clear;
 	dev->mmio.irqmask |= set;
-	mt76_mmio_wr(dev, addr, dev->mmio.irqmask);
+	if (addr)
+		mt76_mmio_wr(dev, addr, dev->mmio.irqmask);
 	spin_unlock_irqrestore(&dev->mmio.irq_lock, flags);
 }
 EXPORT_SYMBOL_GPL(mt76_set_irq_mask);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 96b7c6284833..cb626a2d9197 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -561,5 +561,7 @@ void mt7615_unregister_device(struct mt7615_dev *dev)
 	spin_unlock_bh(&dev->token_lock);
 	idr_destroy(&dev->token);
 
+	tasklet_disable(&dev->irq_tasklet);
+
 	mt76_free_device(&dev->mt76);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
index 3849bb6b49d0..e9f9cda6bb59 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
@@ -80,30 +80,42 @@ mt7615_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q)
 static irqreturn_t mt7615_irq_handler(int irq, void *dev_instance)
 {
 	struct mt7615_dev *dev = dev_instance;
-	u32 intr;
 
-	intr = mt76_rr(dev, MT_INT_SOURCE_CSR);
-	mt76_wr(dev, MT_INT_SOURCE_CSR, intr);
+	mt76_wr(dev, MT_INT_MASK_CSR, 0);
 
 	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
 		return IRQ_NONE;
 
-	trace_dev_irq(&dev->mt76, intr, dev->mt76.mmio.irqmask);
+	tasklet_schedule(&dev->irq_tasklet);
+
+	return IRQ_HANDLED;
+}
+
+static void mt7615_irq_tasklet(unsigned long data)
+{
+	struct mt7615_dev *dev = (struct mt7615_dev *)data;
+	u32 intr, mask = 0;
+
+	mt76_wr(dev, MT_INT_MASK_CSR, 0);
 
+	intr = mt76_rr(dev, MT_INT_SOURCE_CSR);
+	mt76_wr(dev, MT_INT_SOURCE_CSR, intr);
+
+	trace_dev_irq(&dev->mt76, intr, dev->mt76.mmio.irqmask);
 	intr &= dev->mt76.mmio.irqmask;
 
 	if (intr & MT_INT_TX_DONE_ALL) {
-		mt7615_irq_disable(dev, MT_INT_TX_DONE_ALL);
+		mask |= MT_INT_TX_DONE_ALL;
 		napi_schedule(&dev->mt76.tx_napi);
 	}
 
 	if (intr & MT_INT_RX_DONE(0)) {
-		mt7615_irq_disable(dev, MT_INT_RX_DONE(0));
+		mask |= MT_INT_RX_DONE(0);
 		napi_schedule(&dev->mt76.napi[0]);
 	}
 
 	if (intr & MT_INT_RX_DONE(1)) {
-		mt7615_irq_disable(dev, MT_INT_RX_DONE(1));
+		mask |= MT_INT_RX_DONE(1);
 		napi_schedule(&dev->mt76.napi[1]);
 	}
 
@@ -117,7 +129,7 @@ static irqreturn_t mt7615_irq_handler(int irq, void *dev_instance)
 		}
 	}
 
-	return IRQ_HANDLED;
+	mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, mask, 0);
 }
 
 int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base,
@@ -154,6 +166,7 @@ int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base,
 
 	dev = container_of(mdev, struct mt7615_dev, mt76);
 	mt76_mmio_init(&dev->mt76, mem_base);
+	tasklet_init(&dev->irq_tasklet, mt7615_irq_tasklet, (unsigned long)dev);
 
 	dev->reg_map = map;
 	dev->ops = ops;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 4f0d29e5e595..10a98d38f77e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -229,6 +229,8 @@ struct mt7615_dev {
 		struct mt76_phy mphy;
 	};
 
+	struct tasklet_struct irq_tasklet;
+
 	struct mt7615_phy phy;
 	u32 vif_mask;
 	u32 omac_mask;
@@ -404,12 +406,9 @@ static inline bool is_mt7663(struct mt76_dev *dev)
 
 static inline void mt7615_irq_enable(struct mt7615_dev *dev, u32 mask)
 {
-	mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, 0, mask);
-}
+	mt76_set_irq_mask(&dev->mt76, 0, 0, mask);
 
-static inline void mt7615_irq_disable(struct mt7615_dev *dev, u32 mask)
-{
-	mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, mask, 0);
+	tasklet_schedule(&dev->irq_tasklet);
 }
 
 static inline bool mt7615_firmware_offload(struct mt7615_dev *dev)
-- 
2.24.0

