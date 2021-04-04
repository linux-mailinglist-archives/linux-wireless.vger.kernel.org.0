Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10623537DD
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Apr 2021 13:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhDDLhL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Apr 2021 07:37:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230435AbhDDLhK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Apr 2021 07:37:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4624D61386;
        Sun,  4 Apr 2021 11:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617536226;
        bh=oVK8wSHdW1TalBk7gcvkKj0NQmVPxBgJ0v+ho/i0ie0=;
        h=From:To:Cc:Subject:Date:From;
        b=r37sYybTq1KUX1TXZDobG3k9jtYSC09ENYCj7TkE3K9BXu3FeRsZvQRFO80TQh/SF
         Tv8HDwk89L4RiMIJONuvQBB8tBdumasJuiF1UZWxC3zVfBcVAGOL0YtzFekbtgNfGj
         w3jVwsUjhbzD6rqt+vumBFMrZG/TeQFXjojfNEBdoM3sVmvYE2Tpo/keyUsgkglruf
         brMwOLLX7/C1OF4gAB3FlyO93LlDiCQKegwmH1SrOdPoyc578K8hJR/ROuRpfxtf8U
         MlXWqteo+Y2//OhFV90M1e/OcOeyZN8D2kHji56X8SIpuk38TK2tmqGeW+zpYLzjbb
         ZcaOIR9LH5FKg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7921: introduce MT_WFDMA_DUMMY_CR definition
Date:   Sun,  4 Apr 2021 13:36:57 +0200
Message-Id: <5ddfd1ea6169b5c96f23bee50196c013269aface.1617536164.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce MT_WFDMA_DUMMY_CR definition and remove magic numbers

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c  | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c  | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/regs.h | 6 ++++++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index 60de29a921a8..992faf82ad09 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -323,7 +323,7 @@ int mt7921_dma_init(struct mt7921_dev *dev)
 	mt76_set(dev, MT_WFDMA0_GLO_CFG,
 		 MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
 
-	mt76_set(dev, 0x54000120, BIT(1));
+	mt76_set(dev, MT_WFDMA_DUMMY_CR, MT_WFDMA_NEED_REINIT);
 
 	/* enable interrupts for TX/RX rings */
 	mt7921_irq_enable(dev, MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index c4a9ac7da5f4..858273470a7c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1272,7 +1272,7 @@ mt7921_dma_reset(struct mt7921_dev *dev)
 	mt76_set(dev, MT_WFDMA0_GLO_CFG,
 		 MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
 
-	mt76_set(dev, 0x54000120, BIT(1));
+	mt76_set(dev, MT_WFDMA_DUMMY_CR, MT_WFDMA_NEED_REINIT);
 
 	/* enable interrupts for TX/RX rings */
 	mt7921_irq_enable(dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
index 13097ef94e02..391cbefe0f82 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
@@ -391,6 +391,12 @@
 #define MT_TOP_MISC			MT_TOP(0xf0)
 #define MT_TOP_MISC_FW_STATE		GENMASK(2, 0)
 
+#define MT_MCU_WPDMA0_BASE		0x54000000
+#define MT_MCU_WPDMA0(ofs)		(MT_MCU_WPDMA0_BASE + (ofs))
+
+#define MT_WFDMA_DUMMY_CR		MT_MCU_WPDMA0(0x120)
+#define MT_WFDMA_NEED_REINIT		BIT(1)
+
 #define MT_HW_BOUND			0x70010020
 #define MT_HW_CHIPID			0x70010200
 #define MT_HW_REV			0x70010204
-- 
2.30.2

