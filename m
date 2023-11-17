Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FD87EF6D1
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Nov 2023 18:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346084AbjKQRNc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Nov 2023 12:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjKQRNb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Nov 2023 12:13:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDA6D57
        for <linux-wireless@vger.kernel.org>; Fri, 17 Nov 2023 09:13:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52591C433CA;
        Fri, 17 Nov 2023 17:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700241207;
        bh=M6QsI4EDsGZinr08NgiH7lTbt7WW8PQx9BFSmAqiBjw=;
        h=From:To:Cc:Subject:Date:From;
        b=sa1IJ5q73TEXkMpxuMt0pyJWeTkISWWP1WENonV+9Oyb/TzBtzWgqHhP0Ti/KWnk/
         2UXfWymWa2qxM/TuImtvrF0isf/4Mov3P+FjpsNWnEwMh3nBx+drNKbhVMrJY9bGH+
         6mhN2wCD6FQQIZvucD2EfI0XnQe3QTvHzzOpoge+28sEXq0d+RAZPWGW2cCvvg6qG4
         88clrDwcf8rL8GuhcF80IFmDzDZInKGwaJaPtaBZUvHuPV9vEs4OXJvGQeRkWgXUS8
         g5qQDZncLm/BJ3OBAYVdASPgtMXic7ykcqyKOGz+QkMzdExBfZVelfgBdSbZK6F2dM
         dDE2GeBBNS6qw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sujuan.chen@mediatek.com, rex.lu@mediatek.com
Subject: [PATCH] wifi: mt76: mt7996: set DMA mask to 36 bits for boards with more than 4GB of RAM
Date:   Fri, 17 Nov 2023 18:13:19 +0100
Message-ID: <824ce0abeb17e499918495665cc3795fa2988c0b.1700241103.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sujuan Chen <sujuan.chen@mediatek.com>

Introduce the capability to run mt7996 driver on boards with more than
4GB of memory.

Co-developed-by: Rex Lu <rex.lu@mediatek.com>
Signed-off-by: Rex Lu <rex.lu@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c              | 6 +++++-
 drivers/net/wireless/mediatek/mt76/dma.h              | 2 ++
 drivers/net/wireless/mediatek/mt76/mmio.c             | 5 +++--
 drivers/net/wireless/mediatek/mt76/mt76.h             | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c       | 6 ++++--
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c       | 6 +++++-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c      | 9 ---------
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c       | 6 +++++-
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h      | 5 +++--
 10 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index d0067b8dbbc8..75a970f9df8f 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -232,8 +232,8 @@ mt76_dma_add_rx_buf(struct mt76_dev *dev, struct mt76_queue *q,
 	struct mt76_queue_entry *entry = &q->entry[q->head];
 	struct mt76_txwi_cache *txwi = NULL;
 	struct mt76_desc *desc;
-	u32 buf1 = 0, ctrl;
 	int idx = q->head;
+	u32 buf1, ctrl;
 	int rx_token;
 
 	if (mt76_queue_is_wed_rro_ind(q)) {
@@ -246,6 +246,7 @@ mt76_dma_add_rx_buf(struct mt76_dev *dev, struct mt76_queue *q,
 
 	desc = &q->desc[q->head];
 	ctrl = FIELD_PREP(MT_DMA_CTL_SD_LEN0, buf[0].len);
+	buf1 = FIELD_PREP(MT_DMA_CTL_SDP0_H, buf->addr >> 32);
 
 	if (mt76_queue_is_wed_rx(q)) {
 		txwi = mt76_get_rxwi(dev);
@@ -312,11 +313,14 @@ mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_queue *q,
 		entry->dma_len[0] = buf[0].len;
 
 		ctrl = FIELD_PREP(MT_DMA_CTL_SD_LEN0, buf[0].len);
+		info |= FIELD_PREP(MT_DMA_CTL_SDP0_H, buf[0].addr >> 32);
 		if (i < nbufs - 1) {
 			entry->dma_addr[1] = buf[1].addr;
 			entry->dma_len[1] = buf[1].len;
 			buf1 = buf[1].addr;
 			ctrl |= FIELD_PREP(MT_DMA_CTL_SD_LEN1, buf[1].len);
+			info |= FIELD_PREP(MT_DMA_CTL_SDP1_H,
+					   buf[1].addr >> 32);
 			if (buf[1].skip_unmap)
 				entry->skip_buf1 = true;
 		}
diff --git a/drivers/net/wireless/mediatek/mt76/dma.h b/drivers/net/wireless/mediatek/mt76/dma.h
index c60dfb817227..c479cc6388ef 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.h
+++ b/drivers/net/wireless/mediatek/mt76/dma.h
@@ -19,6 +19,8 @@
 #define MT_DMA_CTL_TO_HOST_A		BIT(12)
 #define MT_DMA_CTL_DROP			BIT(14)
 #define MT_DMA_CTL_TOKEN		GENMASK(31, 16)
+#define MT_DMA_CTL_SDP1_H		GENMASK(19, 16)
+#define MT_DMA_CTL_SDP0_H		GENMASK(3, 0)
 #define MT_DMA_CTL_WO_DROP		BIT(8)
 
 #define MT_DMA_PPE_CPU_REASON		GENMASK(15, 11)
diff --git a/drivers/net/wireless/mediatek/mt76/mmio.c b/drivers/net/wireless/mediatek/mt76/mmio.c
index 4a006409a373..260a7a566bfd 100644
--- a/drivers/net/wireless/mediatek/mt76/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mmio.c
@@ -142,8 +142,9 @@ u32 mt76_mmio_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
 			goto unmap;
 		}
 
-		desc->token |= cpu_to_le32(FIELD_PREP(MT_DMA_CTL_TOKEN,
-						      token));
+		token = FIELD_PREP(MT_DMA_CTL_TOKEN, token) |
+			FIELD_PREP(MT_DMA_CTL_SDP0_H, addr >> 32);
+		desc->token |= cpu_to_le32(token);
 		desc++;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index f88192c402e3..87b1461e2da1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -183,7 +183,7 @@ struct mt76_queue_entry {
 		struct urb *urb;
 		int buf_sz;
 	};
-	u32 dma_addr[2];
+	dma_addr_t dma_addr[2];
 	u16 dma_len[2];
 	u16 wcid;
 	bool skip_buf0:1;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
index 2250252b2047..ec3e75ee6d41 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
@@ -259,6 +259,9 @@ enum tx_mgnt_type {
 
 #define MT_TXD9_WLAN_IDX		GENMASK(23, 8)
 
+#define MT_TXP_BUF_LEN			GENMASK(11, 0)
+#define MT_TXP_DMA_ADDR_H		GENMASK(15, 12)
+
 #define MT_TX_RATE_STBC			BIT(14)
 #define MT_TX_RATE_NSS			GENMASK(13, 10)
 #define MT_TX_RATE_MODE			GENMASK(9, 6)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
index 8bc08d993085..f64ce30aa42c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
@@ -203,7 +203,8 @@ void mt7996_dma_start(struct mt7996_dev *dev, bool reset, bool wed_reset)
 		if (mtk_wed_device_active(wed) && mtk_wed_get_rx_capa(wed))
 			mt76_set(dev, MT_WFDMA0_GLO_CFG,
 				 MT_WFDMA0_GLO_CFG_TX_DMA_EN |
-				 MT_WFDMA0_GLO_CFG_OMIT_TX_INFO);
+				 MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+				 MT_WFDMA0_GLO_CFG_EXT_EN);
 		else
 			mt76_set(dev, MT_WFDMA0_GLO_CFG,
 				 MT_WFDMA0_GLO_CFG_TX_DMA_EN |
@@ -216,7 +217,8 @@ void mt7996_dma_start(struct mt7996_dev *dev, bool reset, bool wed_reset)
 				 MT_WFDMA0_GLO_CFG_TX_DMA_EN |
 				 MT_WFDMA0_GLO_CFG_RX_DMA_EN |
 				 MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
-				 MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
+				 MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2 |
+				 MT_WFDMA0_GLO_CFG_EXT_EN);
 	}
 
 	/* enable interrupts for TX/RX rings */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 7e896af29404..cc2c347a49df 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -994,8 +994,12 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 
 	txp = (struct mt76_connac_txp_common *)(txwi + MT_TXD_SIZE);
 	for (i = 0; i < nbuf; i++) {
+		u16 len = FIELD_PREP(MT_TXP_BUF_LEN, tx_info->buf[i + 1].len) |
+			  FIELD_PREP(MT_TXP_DMA_ADDR_H,
+				     tx_info->buf[i + 1].addr >> 32);
+
 		txp->fw.buf[i] = cpu_to_le32(tx_info->buf[i + 1].addr);
-		txp->fw.len[i] = cpu_to_le16(tx_info->buf[i + 1].len);
+		txp->fw.len[i] = cpu_to_le16(len);
 	}
 	txp->fw.nbuf = nbuf;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index 739d7f53d347..837f95b4f93c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -235,7 +235,6 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
 	struct pci_dev *pci_dev = pdev_ptr;
 	u32 hif1_ofs = 0;
-	int ret;
 
 	if (!wed_enable)
 		return 0;
@@ -355,14 +354,6 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 	*irq = wed->irq;
 	dev->mt76.dma_dev = wed->dev;
 
-	ret = dma_set_mask(wed->dev, DMA_BIT_MASK(32));
-	if (ret)
-		return ret;
-
-	ret = dma_set_coherent_mask(wed->dev, DMA_BIT_MASK(32));
-	if (ret)
-		return ret;
-
 	return 1;
 #else
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
index 93ecc9a8dde0..0296e2fde0c1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
@@ -107,7 +107,11 @@ static int mt7996_pci_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
-	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
+	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(36));
+	if (ret)
+		return ret;
+
+	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
index e9edba830aff..e3455fd9bdbf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -375,9 +375,10 @@ enum base_rev {
 #define MT_WFDMA0_GLO_CFG			MT_WFDMA0(0x208)
 #define MT_WFDMA0_GLO_CFG_TX_DMA_EN		BIT(0)
 #define MT_WFDMA0_GLO_CFG_RX_DMA_EN		BIT(2)
-#define MT_WFDMA0_GLO_CFG_OMIT_TX_INFO		BIT(28)
-#define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO		BIT(27)
 #define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2	BIT(21)
+#define MT_WFDMA0_GLO_CFG_EXT_EN		BIT(26)
+#define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO		BIT(27)
+#define MT_WFDMA0_GLO_CFG_OMIT_TX_INFO		BIT(28)
 
 #define WF_WFDMA0_GLO_CFG_EXT0			MT_WFDMA0(0x2b0)
 #define WF_WFDMA0_GLO_CFG_EXT0_RX_WB_RXD	BIT(18)
-- 
2.42.0

