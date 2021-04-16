Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685E8361B95
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Apr 2021 10:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240357AbhDPI2Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Apr 2021 04:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238160AbhDPI2Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Apr 2021 04:28:16 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF96C06175F
        for <linux-wireless@vger.kernel.org>; Fri, 16 Apr 2021 01:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=B7/QaMrJZOc/fdKJ8xnKuAxgrCVSKwk0zWsxgYPRp28=; b=HOw2mEkYiYucFCiaQzANvrxRWj
        qj2gbq6GtN2GZ5xLE4RVSCmO6pyuSWJ6c31uRXIuKYgEeZrem6J8DAs77rpjJeWijk6fA/W2PraMx
        md6liEPgf57GCQn9fLOItxk01xC6GGxBUZeT7cdmhd2U0fMDoG1oQuj9HM+BirdybrTA=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lXJpM-0003tx-OL
        for linux-wireless@vger.kernel.org; Fri, 16 Apr 2021 10:27:48 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/3] mt76: mt7615: fix hardware error recovery for mt7663
Date:   Fri, 16 Apr 2021 10:27:44 +0200
Message-Id: <20210416082746.21825-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

MT7663 uses different bits for communicating reset commands/status between MCU
and host. Also add an extra initial reset command.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7615/dma.c   | 17 +++++++++++---
 .../net/wireless/mediatek/mt76/mt7615/mmio.c  | 23 +++++++++++++------
 .../wireless/mediatek/mt76/mt7615/pci_init.c  |  6 +++++
 .../wireless/mediatek/mt76/mt7615/pci_mac.c   |  7 +++++-
 .../net/wireless/mediatek/mt76/mt7615/regs.h  | 11 +++++++++
 5 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index 0ec1c526f583..642b4eab0d8b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -187,14 +187,19 @@ void mt7615_dma_start(struct mt7615_dev *dev)
 	if (is_mt7622(&dev->mt76))
 		mt7622_dma_sched_init(dev);
 
-	if (is_mt7663(&dev->mt76))
+	if (is_mt7663(&dev->mt76)) {
 		mt7663_dma_sched_init(dev);
+
+		mt76_wr(dev, MT_MCU2HOST_INT_ENABLE, MT7663_MCU_CMD_ERROR_MASK);
+	}
+
 }
 
 int mt7615_dma_init(struct mt7615_dev *dev)
 {
 	int rx_ring_size = MT7615_RX_RING_SIZE;
 	int rx_buf_size = MT_RX_BUF_SIZE;
+	u32 mask;
 	int ret;
 
 	/* Increase buffer size to receive large VHT MPDUs */
@@ -269,8 +274,14 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 		  MT_WPDMA_GLO_CFG_RX_DMA_BUSY, 0, 1000);
 
 	/* enable interrupts for TX/RX rings */
-	mt7615_irq_enable(dev, MT_INT_RX_DONE_ALL | mt7615_tx_mcu_int_mask(dev) |
-			       MT_INT_MCU_CMD);
+
+	mask = MT_INT_RX_DONE_ALL | mt7615_tx_mcu_int_mask(dev);
+	if (is_mt7663(&dev->mt76))
+	    mask |= MT7663_INT_MCU_CMD;
+	else
+	    mask |= MT_INT_MCU_CMD;
+
+	mt7615_irq_enable(dev, mask);
 
 	mt7615_dma_start(dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
index eaa22752e7cd..be93e7ad1279 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
@@ -105,6 +105,7 @@ static void mt7615_irq_tasklet(struct tasklet_struct *t)
 {
 	struct mt7615_dev *dev = from_tasklet(dev, t, irq_tasklet);
 	u32 intr, mask = 0, tx_mcu_mask = mt7615_tx_mcu_int_mask(dev);
+	u32 mcu_int;
 
 	mt76_wr(dev, MT_INT_MASK_CSR, 0);
 
@@ -128,15 +129,23 @@ static void mt7615_irq_tasklet(struct tasklet_struct *t)
 	if (intr & MT_INT_RX_DONE(1))
 		napi_schedule(&dev->mt76.napi[1]);
 
-	if (intr & MT_INT_MCU_CMD) {
-		u32 val = mt76_rr(dev, MT_MCU_CMD);
+	if (!(intr & (MT_INT_MCU_CMD | MT7663_INT_MCU_CMD)))
+		return;
 
-		if (val & MT_MCU_CMD_ERROR_MASK) {
-			dev->reset_state = val;
-			ieee80211_queue_work(mt76_hw(dev), &dev->reset_work);
-			wake_up(&dev->reset_wait);
-		}
+	if (is_mt7663(&dev->mt76)) {
+		mcu_int = mt76_rr(dev, MT_MCU2HOST_INT_STATUS);
+		mcu_int &= MT7663_MCU_CMD_ERROR_MASK;
+	} else {
+		mcu_int = mt76_rr(dev, MT_MCU_CMD);
+		mcu_int &= MT_MCU_CMD_ERROR_MASK;
 	}
+
+	if (!mcu_int)
+		return;
+
+	dev->reset_state = mcu_int;
+	ieee80211_queue_work(mt76_hw(dev), &dev->reset_work);
+	wake_up(&dev->reset_wait);
 }
 
 static u32 __mt7615_reg_addr(struct mt7615_dev *dev, u32 addr)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
index a03484e34bb4..49540b00519d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
@@ -47,6 +47,12 @@ static int mt7615_init_hardware(struct mt7615_dev *dev)
 	if (ret < 0)
 		return ret;
 
+	if (is_mt7663(&dev->mt76)) {
+		/* Reset RGU */
+		mt76_clear(dev, MT_MCU_CIRQ_IRQ_SEL(4), BIT(1));
+		mt76_set(dev, MT_MCU_CIRQ_IRQ_SEL(4), BIT(1));
+	}
+
 	ret = mt7615_dma_init(dev);
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index 8cd79e849045..d20962cdecc8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -210,7 +210,12 @@ EXPORT_SYMBOL_GPL(mt7615_dma_reset);
 static void
 mt7615_hif_int_event_trigger(struct mt7615_dev *dev, u8 event)
 {
-	mt76_wr(dev, MT_MCU_INT_EVENT, event);
+	u32 reg = MT_MCU_INT_EVENT;
+
+	if (is_mt7663(&dev->mt76))
+		reg = MT7663_MCU_INT_EVENT;
+
+	mt76_wr(dev, reg, event);
 
 	mt7622_trigger_hif_int(dev, true);
 	mt7622_trigger_hif_int(dev, false);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 190a02670795..63c081bb04d0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -61,6 +61,11 @@ enum mt7615_reg_base {
 #define MT_MCU_PCIE_REMAP_2_BASE	GENMASK(31, 19)
 #define MT_PCIE_REMAP_BASE_2		((dev)->reg_map[MT_PCIE_REMAP_BASE2])
 
+#define MT_MCU_CIRQ_BASE		0xc0000
+#define MT_MCU_CIRQ(ofs)		(MT_MCU_CIRQ_BASE + (ofs))
+
+#define MT_MCU_CIRQ_IRQ_SEL(n)		MT_MCU_CIRQ((n) << 2)
+
 #define MT_HIF(ofs)			((dev)->reg_map[MT_HIF_BASE] + (ofs))
 #define MT_HIF_RST			MT_HIF(0x100)
 #define MT_HIF_LOGIC_RST_N		BIT(4)
@@ -88,6 +93,10 @@ enum mt7615_reg_base {
 #define MT_CFG_LPCR_HOST_FW_OWN		BIT(0)
 #define MT_CFG_LPCR_HOST_DRV_OWN	BIT(1)
 
+#define MT_MCU2HOST_INT_STATUS		MT_HIF(0x1f0)
+#define MT_MCU2HOST_INT_ENABLE		MT_HIF(0x1f4)
+
+#define MT7663_MCU_INT_EVENT		MT_HIF(0x108)
 #define MT_MCU_INT_EVENT		MT_HIF(0x1f8)
 #define MT_MCU_INT_EVENT_PDMA_STOPPED	BIT(0)
 #define MT_MCU_INT_EVENT_PDMA_INIT	BIT(1)
@@ -102,6 +111,7 @@ enum mt7615_reg_base {
 #define MT_INT_RX_DONE_ALL		GENMASK(1, 0)
 #define MT_INT_TX_DONE_ALL		GENMASK(19, 4)
 #define MT_INT_TX_DONE(_n)		BIT((_n) + 4)
+#define MT7663_INT_MCU_CMD		BIT(29)
 #define MT_INT_MCU_CMD			BIT(30)
 
 #define MT_WPDMA_GLO_CFG		MT_HIF(0x208)
@@ -138,6 +148,7 @@ enum mt7615_reg_base {
 #define MT_MCU_CMD_PDMA_ERROR		BIT(27)
 #define MT_MCU_CMD_PCIE_ERROR		BIT(28)
 #define MT_MCU_CMD_ERROR_MASK		(GENMASK(5, 1) | GENMASK(28, 24))
+#define MT7663_MCU_CMD_ERROR_MASK	GENMASK(5, 2)
 
 #define MT_TX_RING_BASE			MT_HIF(0x300)
 #define MT_RX_RING_BASE			MT_HIF(0x400)
-- 
2.30.1

