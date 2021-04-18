Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87D13636CC
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 18:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbhDRQqu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 12:46:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232244AbhDRQqt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 12:46:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33F636101E;
        Sun, 18 Apr 2021 16:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618764381;
        bh=8j9daaZcdcyMeM2RuAEOtcGEB3oidV4RfPEbvh+83Ls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XUniaRM4Jpu49MWaNCKRAIvG47FEYLT9jC21fSQQ/RE546X2da7ERiZRegOLG1dtk
         KC/6jDsw533HCwlQcoQNPoD6anuYuIwpGNR2ZtVx8qZI8ICNA7ZHCjnuu8DcGtx4r5
         pRteXR7B1msowXXGUHf1t6DCq9B2Eq0UR3jRtk4M9CF6sleLshFIizo29qG9vw0Eua
         o22ITKFI9XGlpTl4KtTgG+JGKWvW2jiuQ/rp9qXj8FeC18UKP9kE0mt/Z6TiOhmX5i
         b+00Pa3QgMTG3DkJyyGUOBkR72yx6PmHhHBFVX0DUwFkU7i5IE7sev4sAjJXgWSjmk
         tb19ZNM8LYtvw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 19/19] mt76: mt7921: enable sw interrupts
Date:   Sun, 18 Apr 2021 18:45:45 +0200
Message-Id: <5893f370bb33bf8adf7e41afe0f2da51a8366418.1618763001.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618763000.git.lorenzo@kernel.org>
References: <cover.1618763000.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable sw interrupts in order to wake the device from deep sleep
receiving packets

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c |  1 +
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c |  1 +
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 13 +++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/regs.h    | 17 ++++++++++-------
 4 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index c26979614113..7ada8339b74f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -351,6 +351,7 @@ int mt7921_dma_init(struct mt7921_dev *dev)
 	/* enable interrupts for TX/RX rings */
 	mt7921_irq_enable(dev, MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
 			  MT_INT_MCU_CMD);
+	mt76_set(dev, MT_MCU2HOST_SW_INT_ENA, MT_MCU_CMD_WAKE_RX_PCIE);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 7b5323181fac..8770e0d93f45 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1276,6 +1276,7 @@ mt7921_dma_reset(struct mt7921_dev *dev)
 	mt7921_irq_enable(dev,
 			  MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
 			  MT_INT_MCU_CMD);
+	mt76_set(dev, MT_MCU2HOST_SW_INT_ENA, MT_MCU_CMD_WAKE_RX_PCIE);
 }
 
 void mt7921_tx_token_put(struct mt7921_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 40e2086d075c..d5da98d36f63 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -61,6 +61,18 @@ static void mt7921_irq_tasklet(unsigned long data)
 	if (intr & MT_INT_TX_DONE_MCU)
 		mask |= MT_INT_TX_DONE_MCU;
 
+	if (intr & MT_INT_MCU_CMD) {
+		u32 intr_sw;
+
+		intr_sw = mt76_rr(dev, MT_MCU_CMD);
+		/* ack MCU2HOST_SW_INT_STA */
+		mt76_wr(dev, MT_MCU_CMD, intr_sw);
+		if (intr_sw & MT_MCU_CMD_WAKE_RX_PCIE) {
+			mask |= MT_INT_RX_DONE_DATA;
+			intr |= MT_INT_RX_DONE_DATA;
+		}
+	}
+
 	mt76_set_irq_mask(&dev->mt76, MT_WFDMA0_HOST_INT_ENA, mask, 0);
 
 	if (intr & MT_INT_TX_DONE_ALL)
@@ -253,6 +265,7 @@ static int mt7921_pci_resume(struct pci_dev *pdev)
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
 	mt7921_irq_enable(dev, MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
 			  MT_INT_MCU_CMD);
+	mt76_set(dev, MT_MCU2HOST_SW_INT_ENA, MT_MCU_CMD_WAKE_RX_PCIE);
 
 	/* put dma enabled */
 	mt76_set(dev, MT_WFDMA0_GLO_CFG,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
index 76ecfea21dce..b6944c867a57 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
@@ -251,13 +251,16 @@
 #define MT_WFDMA0_BUSY_ENA_TX_FIFO1	BIT(1)
 #define MT_WFDMA0_BUSY_ENA_RX_FIFO	BIT(2)
 
-#define MT_MCU_CMD                     MT_WFDMA0(0x1f0)
-#define MT_MCU_CMD_STOP_DMA_FW_RELOAD  BIT(1)
-#define MT_MCU_CMD_STOP_DMA            BIT(2)
-#define MT_MCU_CMD_RESET_DONE          BIT(3)
-#define MT_MCU_CMD_RECOVERY_DONE       BIT(4)
-#define MT_MCU_CMD_NORMAL_STATE	       BIT(5)
-#define MT_MCU_CMD_ERROR_MASK          GENMASK(5, 1)
+#define MT_MCU_CMD			MT_WFDMA0(0x1f0)
+#define MT_MCU_CMD_WAKE_RX_PCIE		BIT(0)
+#define MT_MCU_CMD_STOP_DMA_FW_RELOAD	BIT(1)
+#define MT_MCU_CMD_STOP_DMA		BIT(2)
+#define MT_MCU_CMD_RESET_DONE		BIT(3)
+#define MT_MCU_CMD_RECOVERY_DONE	BIT(4)
+#define MT_MCU_CMD_NORMAL_STATE		BIT(5)
+#define MT_MCU_CMD_ERROR_MASK		GENMASK(5, 1)
+
+#define MT_MCU2HOST_SW_INT_ENA		MT_WFDMA0(0x1f4)
 
 #define MT_WFDMA0_HOST_INT_STA		MT_WFDMA0(0x200)
 #define HOST_RX_DONE_INT_STS0		BIT(0)	/* Rx mcu */
-- 
2.30.2

