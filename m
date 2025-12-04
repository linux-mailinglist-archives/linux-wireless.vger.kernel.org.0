Return-Path: <linux-wireless+bounces-29499-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C3ECA2C39
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Dec 2025 09:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 47A0F3007A1A
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Dec 2025 08:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F3E308F05;
	Thu,  4 Dec 2025 08:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2Xc0uSJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFD02D321B
	for <linux-wireless@vger.kernel.org>; Thu,  4 Dec 2025 08:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764835912; cv=none; b=iNI4p9P3o2/FgxVryxjjsdZo1AAkJS/K3uveCU6kqgJjxIyNITPYd34R0ukKnhqaGkw9DJhqOUkEFBQiPGHapI9KmgrauU7TXDDmUdP27YwU4uW1953Zcf+E+7Gbqbe4LJZhyMK8q/CuFAxhFIxK7NB6g+GgGWO6fug4NpWYm3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764835912; c=relaxed/simple;
	bh=YzO75XGX+dsh8f+KPHo6hQWAdZH3CE7KGu1havw+P9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S0yTzQ/evcWSI/qAn+/LLR0C3ObSFyWHWICcDiSQenCdesj76jFLmllX1RRmPcV+ZKnrY60D1WQkkL8SOLDQGeZGfZvkizCbBbZfwQINAAV+zX/yLPN+RPE4ZAZYh6AkT4zPJq2/jQnDRznBRvM5/avaKJkE2Gu+/LLqO67sXhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2Xc0uSJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D1CC4CEFB;
	Thu,  4 Dec 2025 08:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764835912;
	bh=YzO75XGX+dsh8f+KPHo6hQWAdZH3CE7KGu1havw+P9U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e2Xc0uSJKb4tlkdqb8k6haZEH/+5nhHxPGYP2Ytse7jKgDMHmYqwnhe7ScY7PIh3C
	 E+zerYSiAqXjuOFaVie7vECwFZIE050d9kCy2Ow+CIk6MSEbmsiS8Qq/uatjwgZMLv
	 uAY7TrL13vHBAFtJF0vWFs1zZtYmzy+cwICSQtGPNhvpZAXjYW3c83geqOLw0gI9Vb
	 7SwCuEcdjDZhKGCoEXyGBBBHIpPbIhDIieaZdpHZGu2zae2Ic4TlHi7mij1f511X1B
	 leaBfbWwD4jMIohj75JSa3Jin5VQ9rluWxZAse/cQbId3FVTEuX+el8rQPUvVE35XG
	 Jq1HRNau8z4DA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 04 Dec 2025 09:10:53 +0100
Subject: [PATCH mt76 11/11] wifi: mt76: mt7996: Integrate MT7996 dma
 configuration for NPU
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-mt76-npu-eagle-offload-v1-11-7819c52c0893@kernel.org>
References: <20251204-mt76-npu-eagle-offload-v1-0-7819c52c0893@kernel.org>
In-Reply-To: <20251204-mt76-npu-eagle-offload-v1-0-7819c52c0893@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Hui Ma <hui.ma@airoha.com>
X-Mailer: b4 0.14.2

Add NPU integration in MT7996 dma codebase for MT7996 chipset.
This is a preliminary patch to enable NPU offload for MT7996
(7990-Eagle) chipset.

Tested-by: Hui Ma <hui.ma@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c | 132 +++++++++++++++---------
 1 file changed, 86 insertions(+), 46 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
index 274b273df1ee941e83db2bf2f9771cbdd4da8b6f..07212d93bc62df69720963f5ba04090bc82003fc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
@@ -128,15 +128,27 @@ static void mt7996_dma_config(struct mt7996_dev *dev)
 
 	/* data tx queue */
 	if (is_mt7996(&dev->mt76)) {
-		TXQ_CONFIG(0, WFDMA0, MT_INT_TX_DONE_BAND0, MT7996_TXQ_BAND0);
 		if (dev->hif2) {
-			/* default bn1:ring19 bn2:ring21 */
-			TXQ_CONFIG(1, WFDMA0, MT_INT_TX_DONE_BAND1,
-				   MT7996_TXQ_BAND1);
-			TXQ_CONFIG(2, WFDMA0, MT_INT_TX_DONE_BAND2,
-				   MT7996_TXQ_BAND2);
+			if (mt76_npu_device_active(&dev->mt76)) {
+				TXQ_CONFIG(0, WFDMA0, MT_INT_TX_DONE_BAND2,
+					   MT7996_TXQ_BAND2);
+				TXQ_CONFIG(1, WFDMA0, MT_INT_TX_DONE_BAND0,
+					   MT7996_TXQ_BAND0);
+				TXQ_CONFIG(2, WFDMA0, MT_INT_TX_DONE_BAND1,
+					   MT7996_TXQ_BAND1);
+			} else {
+				/* default bn1:ring19 bn2:ring21 */
+				TXQ_CONFIG(0, WFDMA0, MT_INT_TX_DONE_BAND0,
+					   MT7996_TXQ_BAND0);
+				TXQ_CONFIG(1, WFDMA0, MT_INT_TX_DONE_BAND1,
+					   MT7996_TXQ_BAND1);
+				TXQ_CONFIG(2, WFDMA0, MT_INT_TX_DONE_BAND2,
+					   MT7996_TXQ_BAND2);
+			}
 		} else {
 			/* single pcie bn0/1:ring18 bn2:ring19 */
+			TXQ_CONFIG(0, WFDMA0, MT_INT_TX_DONE_BAND0,
+				   MT7996_TXQ_BAND0);
 			TXQ_CONFIG(2, WFDMA0, MT_INT_TX_DONE_BAND1,
 				   MT7996_TXQ_BAND1);
 		}
@@ -350,6 +362,9 @@ void mt7996_dma_start(struct mt7996_dev *dev, bool reset, bool wed_reset)
 	if (!mt7996_has_wa(dev) || mt76_npu_device_active(&dev->mt76))
 		irq_mask &= ~(MT_INT_RX(MT_RXQ_MAIN_WA) |
 			      MT_INT_RX(MT_RXQ_BAND1_WA));
+	if (is_mt7996(&dev->mt76) && mt76_npu_device_active(&dev->mt76))
+		irq_mask &= ~(MT_INT_RX(MT_RXQ_TXFREE_BAND0) |
+			      MT_INT_RX(MT_RXQ_MSDU_PAGE_BAND2));
 	irq_mask = reset ? MT_INT_MCU_CMD : irq_mask;
 
 	mt7996_irq_enable(dev, irq_mask);
@@ -430,39 +445,48 @@ static void mt7996_dma_enable(struct mt7996_dev *dev, bool reset)
 			   MT_WFDMA_HOST_CONFIG_BAND1_PCIE1 |
 			   MT_WFDMA_HOST_CONFIG_BAND2_PCIE1);
 
-		if (is_mt7996(&dev->mt76))
-			mt76_set(dev, MT_WFDMA_HOST_CONFIG,
-				 MT_WFDMA_HOST_CONFIG_BAND2_PCIE1);
-		else
+		if (is_mt7996(&dev->mt76)) {
+			if (mt76_npu_device_active(&dev->mt76))
+				mt76_set(dev, MT_WFDMA_HOST_CONFIG,
+					 MT_WFDMA_HOST_CONFIG_BAND0_PCIE1);
+			else
+				mt76_set(dev, MT_WFDMA_HOST_CONFIG,
+					 MT_WFDMA_HOST_CONFIG_BAND2_PCIE1);
+		} else {
 			mt76_set(dev, MT_WFDMA_HOST_CONFIG,
 				 MT_WFDMA_HOST_CONFIG_BAND1_PCIE1);
+		}
 
 		/* AXI read outstanding number */
 		mt76_rmw(dev, MT_WFDMA_AXI_R2A_CTRL,
 			 MT_WFDMA_AXI_R2A_CTRL_OUTSTAND_MASK, 0x14);
 
-		if (dev->hif2->speed < PCIE_SPEED_5_0GT ||
-		    (dev->hif2->speed == PCIE_SPEED_5_0GT &&
-		     dev->hif2->width < PCIE_LNK_X2)) {
-			mt76_rmw(dev, WF_WFDMA0_GLO_CFG_EXT0 + hif1_ofs,
-				 WF_WFDMA0_GLO_CFG_EXT0_OUTSTAND_MASK,
-				 FIELD_PREP(WF_WFDMA0_GLO_CFG_EXT0_OUTSTAND_MASK,
-					    0x1));
-			mt76_rmw(dev, MT_WFDMA_AXI_R2A_CTRL2,
-				 MT_WFDMA_AXI_R2A_CTRL2_OUTSTAND_MASK,
-				 FIELD_PREP(MT_WFDMA_AXI_R2A_CTRL2_OUTSTAND_MASK,
-					    0x1));
-		} else if (dev->hif2->speed < PCIE_SPEED_8_0GT ||
-			   (dev->hif2->speed == PCIE_SPEED_8_0GT &&
-			    dev->hif2->width < PCIE_LNK_X2)) {
-			mt76_rmw(dev, WF_WFDMA0_GLO_CFG_EXT0 + hif1_ofs,
-				 WF_WFDMA0_GLO_CFG_EXT0_OUTSTAND_MASK,
-				 FIELD_PREP(WF_WFDMA0_GLO_CFG_EXT0_OUTSTAND_MASK,
-					    0x2));
-			mt76_rmw(dev, MT_WFDMA_AXI_R2A_CTRL2,
-				 MT_WFDMA_AXI_R2A_CTRL2_OUTSTAND_MASK,
-				 FIELD_PREP(MT_WFDMA_AXI_R2A_CTRL2_OUTSTAND_MASK,
-					    0x2));
+		if (!is_mt7996(&dev->mt76) ||
+		    !mt76_npu_device_active(&dev->mt76)) {
+			if (dev->hif2->speed < PCIE_SPEED_5_0GT ||
+			    (dev->hif2->speed == PCIE_SPEED_5_0GT &&
+			     dev->hif2->width < PCIE_LNK_X2)) {
+				mt76_rmw(dev,
+					 WF_WFDMA0_GLO_CFG_EXT0 + hif1_ofs,
+					 WF_WFDMA0_GLO_CFG_EXT0_OUTSTAND_MASK,
+					 FIELD_PREP(WF_WFDMA0_GLO_CFG_EXT0_OUTSTAND_MASK,
+						    0x1));
+				mt76_rmw(dev, MT_WFDMA_AXI_R2A_CTRL2,
+					 MT_WFDMA_AXI_R2A_CTRL2_OUTSTAND_MASK,
+					 FIELD_PREP(MT_WFDMA_AXI_R2A_CTRL2_OUTSTAND_MASK,
+						    0x1));
+			} else if (dev->hif2->speed < PCIE_SPEED_8_0GT ||
+				   (dev->hif2->speed == PCIE_SPEED_8_0GT &&
+				    dev->hif2->width < PCIE_LNK_X2)) {
+				mt76_rmw(dev, WF_WFDMA0_GLO_CFG_EXT0 + hif1_ofs,
+					 WF_WFDMA0_GLO_CFG_EXT0_OUTSTAND_MASK,
+					 FIELD_PREP(WF_WFDMA0_GLO_CFG_EXT0_OUTSTAND_MASK,
+						    0x2));
+				mt76_rmw(dev, MT_WFDMA_AXI_R2A_CTRL2,
+					 MT_WFDMA_AXI_R2A_CTRL2_OUTSTAND_MASK,
+					 FIELD_PREP(MT_WFDMA_AXI_R2A_CTRL2_OUTSTAND_MASK,
+						    0x2));
+			}
 		}
 
 		/* WFDMA rx threshold */
@@ -497,7 +521,7 @@ static void mt7996_dma_enable(struct mt7996_dev *dev, bool reset)
 int mt7996_dma_rro_init(struct mt7996_dev *dev)
 {
 	struct mt76_dev *mdev = &dev->mt76;
-	u32 irq_mask;
+	u32 irq_mask, size;
 	int ret;
 
 	if (dev->mt76.hwrro_mode == MT76_HWRRO_V3_1) {
@@ -545,10 +569,12 @@ int mt7996_dma_rro_init(struct mt7996_dev *dev)
 	if (mtk_wed_device_active(&mdev->mmio.wed) &&
 	    mtk_wed_get_rx_capa(&mdev->mmio.wed))
 		mdev->q_rx[MT_RXQ_MSDU_PAGE_BAND0].wed = &mdev->mmio.wed;
+
+	size = is_mt7996(mdev) && mt76_npu_device_active(mdev)
+	       ? MT7996_NPU_RX_RING_SIZE / 4 : MT7996_RX_RING_SIZE;
 	ret = mt76_queue_alloc(dev, &mdev->q_rx[MT_RXQ_MSDU_PAGE_BAND0],
 			       MT_RXQ_ID(MT_RXQ_MSDU_PAGE_BAND0),
-			       MT7996_RX_RING_SIZE,
-			       MT7996_RX_MSDU_PAGE_SIZE,
+			       size, MT7996_RX_MSDU_PAGE_SIZE,
 			       MT_RXQ_RING_BASE(MT_RXQ_MSDU_PAGE_BAND0));
 	if (ret)
 		return ret;
@@ -560,10 +586,12 @@ int mt7996_dma_rro_init(struct mt7996_dev *dev)
 		if (mtk_wed_device_active(&mdev->mmio.wed) &&
 		    mtk_wed_get_rx_capa(&mdev->mmio.wed))
 			mdev->q_rx[MT_RXQ_MSDU_PAGE_BAND1].wed = &mdev->mmio.wed;
+
+		size = is_mt7996(mdev) && mt76_npu_device_active(mdev)
+		       ? MT7996_NPU_RX_RING_SIZE / 2 : MT7996_RX_RING_SIZE;
 		ret = mt76_queue_alloc(dev, &mdev->q_rx[MT_RXQ_MSDU_PAGE_BAND1],
 				       MT_RXQ_ID(MT_RXQ_MSDU_PAGE_BAND1),
-				       MT7996_RX_RING_SIZE,
-				       MT7996_RX_MSDU_PAGE_SIZE,
+				       size, MT7996_RX_MSDU_PAGE_SIZE,
 				       MT_RXQ_RING_BASE(MT_RXQ_MSDU_PAGE_BAND1));
 		if (ret)
 			return ret;
@@ -576,10 +604,12 @@ int mt7996_dma_rro_init(struct mt7996_dev *dev)
 		if (mtk_wed_device_active(&mdev->mmio.wed) &&
 		    mtk_wed_get_rx_capa(&mdev->mmio.wed))
 			mdev->q_rx[MT_RXQ_MSDU_PAGE_BAND2].wed = &mdev->mmio.wed;
+
+		size = is_mt7996(mdev) && mt76_npu_device_active(mdev)
+		       ? MT7996_NPU_RX_RING_SIZE : MT7996_RX_RING_SIZE;
 		ret = mt76_queue_alloc(dev, &mdev->q_rx[MT_RXQ_MSDU_PAGE_BAND2],
 				       MT_RXQ_ID(MT_RXQ_MSDU_PAGE_BAND2),
-				       MT7996_RX_RING_SIZE,
-				       MT7996_RX_MSDU_PAGE_SIZE,
+				       size, MT7996_RX_MSDU_PAGE_SIZE,
 				       MT_RXQ_RING_BASE(MT_RXQ_MSDU_PAGE_BAND2));
 		if (ret)
 			return ret;
@@ -642,11 +672,16 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 	mt7996_dma_disable(dev, true);
 
 	/* init tx queue */
-	ret = mt7996_init_tx_queues(&dev->phy,
-				    MT_TXQ_ID(dev->mphy.band_idx),
-				    MT7996_TX_RING_SIZE,
-				    MT_TXQ_RING_BASE(0),
-				    wed);
+	if (is_mt7996(&dev->mt76) && mt76_npu_device_active(&dev->mt76))
+		ret = mt7996_init_tx_queues(&dev->phy, MT_TXQ_ID(0),
+					    MT7996_NPU_TX_RING_SIZE,
+					    MT_TXQ_RING_BASE(0) + hif1_ofs,
+					    NULL);
+	else
+		ret = mt7996_init_tx_queues(&dev->phy,
+					    MT_TXQ_ID(dev->mphy.band_idx),
+					    MT7996_TX_RING_SIZE,
+					    MT_TXQ_RING_BASE(0), wed);
 	if (ret)
 		return ret;
 
@@ -859,16 +894,21 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 		}
 
 		if (mt7996_band_valid(dev, MT_BAND2)) {
+			u32 size;
+
 			/* rx rro data queue for band2 */
 			dev->mt76.q_rx[MT_RXQ_RRO_BAND2].flags =
 				MT_WED_RRO_Q_DATA(1) | MT_QFLAG_WED_RRO_EN;
 			if (mtk_wed_device_active(wed) &&
 			    mtk_wed_get_rx_capa(wed))
 				dev->mt76.q_rx[MT_RXQ_RRO_BAND2].wed = wed;
+
+			size = is_mt7996(&dev->mt76) &&
+			       mt76_npu_device_active(&dev->mt76)
+			       ? MT7996_NPU_RX_RING_SIZE : MT7996_RX_RING_SIZE;
 			ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_RRO_BAND2],
 					       MT_RXQ_ID(MT_RXQ_RRO_BAND2),
-					       MT7996_RX_RING_SIZE,
-					       MT7996_RX_BUF_SIZE,
+					       size, MT7996_RX_BUF_SIZE,
 					       MT_RXQ_RING_BASE(MT_RXQ_RRO_BAND2) + hif1_ofs);
 			if (ret)
 				return ret;

-- 
2.52.0


