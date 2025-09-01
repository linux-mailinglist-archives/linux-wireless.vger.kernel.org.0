Return-Path: <linux-wireless+bounces-26902-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2104B3F02B
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 22:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45EEC1A87C26
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 20:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4469D274B39;
	Mon,  1 Sep 2025 20:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaENrfn9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2461DDA0E
	for <linux-wireless@vger.kernel.org>; Mon,  1 Sep 2025 20:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756760313; cv=none; b=G0JHZpXWQx6ojjCGrCvSIeyCLlJPc0HZrofwyoycirS/7sjNkL8R450K9bptTEuxrcnZXPWAUcWOvtoOtA1uUReS+gDJ20S3GSlQQDy33xIfJ8aQ2cUnQEFz9hdoOJjqzKg8h6rehvEqhUzxnJVe5DJXLG7R3AH/Xoj9Gv+nCJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756760313; c=relaxed/simple;
	bh=/kBqUbAKFKte7sNG+j7FcLbo7s74p2vGEkUuicqUCtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MLipz357wu2lUEHCDfjAvkh7QlTB/eN5HUhAZ/4VtDBlD3yOskGxGOC99uwcsx7yGIsQHZd627D1DisDxWlATX0JuZzHwy8IgMHUZgXMaicuYst/MZF030EzNhIX1ZZJhaiykozZ2cbOtVrNMnD3jFQDps2NAyp14s/Dkb2yloc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaENrfn9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A05C4CEF0;
	Mon,  1 Sep 2025 20:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756760312;
	bh=/kBqUbAKFKte7sNG+j7FcLbo7s74p2vGEkUuicqUCtU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qaENrfn9RRl5o1sCi9SXILV4QZhvHZZSwTfZw2j4IP56dV9WyBRzf+HyQcZKrtuQc
	 Doal+j8OlYwA5heaseptWibSaNkOwJmXe0N6sKOqI54djm0/kwFc4ji/ZYb2zFLcgJ
	 7Qdv9MuB3bTnpzDjRTAboJsu5VYIyb1irde/lDmFFlwcdcCXSv8nU+fa4DHreXeE2d
	 xo2PYI3z5JX5bCeJ68SVdnGAb8U/+Cr3d8ecrUuIXeZE94nKq16D6oL1wIND3MBYl0
	 73x8d8nwyGqzAKdo5+wk6DyTWZFwTXO6mTWlPI1FG+ObXn6pRaz2ZIMagm+rT3Acwv
	 omr5j0s3XMnYg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 01 Sep 2025 22:58:00 +0200
Subject: [PATCH mt76 v2 04/14] wifi: mt76: mt7996: Initial DMA
 configuration for MT7992 WED support
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-mt7996-rro-rework-v2-4-1f95086b51d1@kernel.org>
References: <20250901-mt7996-rro-rework-v2-0-1f95086b51d1@kernel.org>
In-Reply-To: <20250901-mt7996-rro-rework-v2-0-1f95086b51d1@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Rex Lu <rex.lu@mediatek.com>, 
 Benjamin Lin <benjamin-jw.lin@mediatek.com>
X-Mailer: b4 0.14.2

From: Rex Lu <rex.lu@mediatek.com>

Manage differences in DMA and RX queues configuration for MT7992 and
MT7996.
This is a preliminary patch to enable WED support for MT7992 Kite
chipset supported by MT7996 driver.

Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Co-developed-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Signed-off-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Signed-off-by: Rex Lu <rex.lu@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c           |   4 +
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    | 169 ++++++++++++++++-----
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |   8 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h   |   8 +-
 5 files changed, 148 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 68b1dd1dbbe0e2b4850e02ee70253b5e248c69bf..f882b4e10858a233a5422ede80d79c21965136e9 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -967,6 +967,10 @@ mt76_dma_init(struct mt76_dev *dev,
 	init_completion(&dev->mmio.wed_reset_complete);
 
 	mt76_for_each_q_rx(dev, i) {
+		if (mtk_wed_device_active(&dev->mmio.wed) &&
+		    mt76_queue_is_wed_rro(&dev->q_rx[i]))
+			continue;
+
 		netif_napi_add(dev->napi_dev, &dev->napi[i], poll);
 		mt76_dma_rx_fill_buf(dev, &dev->q_rx[i], false);
 		napi_enable(&dev->napi[i]);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
index c77e619070d34ddbf281a5d90c6c96cbd1bb2283..b3665bb0a433ae4cdbf02fa647d644961509d7aa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
@@ -89,30 +89,60 @@ static void mt7996_dma_config(struct mt7996_dev *dev)
 			   MT7996_RXQ_RRO_BAND0);
 		RXQ_CONFIG(MT_RXQ_MSDU_PAGE_BAND0, WFDMA0, MT_INT_RX_DONE_MSDU_PG_BAND0,
 			   MT7996_RXQ_MSDU_PG_BAND0);
-		RXQ_CONFIG(MT_RXQ_TXFREE_BAND0, WFDMA0, MT_INT_RX_TXFREE_MAIN,
-			   MT7996_RXQ_TXFREE0);
-		/* band1 */
-		RXQ_CONFIG(MT_RXQ_MSDU_PAGE_BAND1, WFDMA0, MT_INT_RX_DONE_MSDU_PG_BAND1,
-			   MT7996_RXQ_MSDU_PG_BAND1);
-		/* band2 */
-		RXQ_CONFIG(MT_RXQ_RRO_BAND2, WFDMA0, MT_INT_RX_DONE_RRO_BAND2,
-			   MT7996_RXQ_RRO_BAND2);
-		RXQ_CONFIG(MT_RXQ_MSDU_PAGE_BAND2, WFDMA0, MT_INT_RX_DONE_MSDU_PG_BAND2,
-			   MT7996_RXQ_MSDU_PG_BAND2);
-		RXQ_CONFIG(MT_RXQ_TXFREE_BAND2, WFDMA0, MT_INT_RX_TXFREE_TRI,
-			   MT7996_RXQ_TXFREE2);
+		if (is_mt7996(&dev->mt76)) {
+			RXQ_CONFIG(MT_RXQ_TXFREE_BAND0, WFDMA0,
+				   MT_INT_RX_TXFREE_MAIN, MT7996_RXQ_TXFREE0);
+			/* band1 */
+			RXQ_CONFIG(MT_RXQ_MSDU_PAGE_BAND1, WFDMA0,
+				   MT_INT_RX_DONE_MSDU_PG_BAND1,
+				   MT7996_RXQ_MSDU_PG_BAND1);
+			/* band2 */
+			RXQ_CONFIG(MT_RXQ_RRO_BAND2, WFDMA0,
+				   MT_INT_RX_DONE_RRO_BAND2,
+				   MT7996_RXQ_RRO_BAND2);
+			RXQ_CONFIG(MT_RXQ_MSDU_PAGE_BAND2, WFDMA0,
+				   MT_INT_RX_DONE_MSDU_PG_BAND2,
+				   MT7996_RXQ_MSDU_PG_BAND2);
+			RXQ_CONFIG(MT_RXQ_TXFREE_BAND2, WFDMA0,
+				   MT_INT_RX_TXFREE_TRI, MT7996_RXQ_TXFREE2);
+		} else {
+			RXQ_CONFIG(MT_RXQ_RRO_BAND1, WFDMA0,
+				   MT_INT_RX_DONE_RRO_BAND1,
+				   MT7996_RXQ_RRO_BAND1);
+		}
 
 		RXQ_CONFIG(MT_RXQ_RRO_IND, WFDMA0, MT_INT_RX_DONE_RRO_IND,
 			   MT7996_RXQ_RRO_IND);
 	}
 
 	/* data tx queue */
-	TXQ_CONFIG(0, WFDMA0, MT_INT_TX_DONE_BAND0, MT7996_TXQ_BAND0);
 	if (is_mt7996(&dev->mt76)) {
-		TXQ_CONFIG(1, WFDMA0, MT_INT_TX_DONE_BAND1, MT7996_TXQ_BAND1);
-		TXQ_CONFIG(2, WFDMA0, MT_INT_TX_DONE_BAND2, MT7996_TXQ_BAND2);
+		TXQ_CONFIG(0, WFDMA0, MT_INT_TX_DONE_BAND0, MT7996_TXQ_BAND0);
+		if (dev->hif2) {
+			/* default bn1:ring19 bn2:ring21 */
+			TXQ_CONFIG(1, WFDMA0, MT_INT_TX_DONE_BAND1,
+				   MT7996_TXQ_BAND1);
+			TXQ_CONFIG(2, WFDMA0, MT_INT_TX_DONE_BAND2,
+				   MT7996_TXQ_BAND2);
+		} else {
+			/* single pcie bn0/1:ring18 bn2:ring19 */
+			TXQ_CONFIG(2, WFDMA0, MT_INT_TX_DONE_BAND1,
+				   MT7996_TXQ_BAND1);
+		}
 	} else {
-		TXQ_CONFIG(1, WFDMA0, MT_INT_TX_DONE_BAND1, MT7996_TXQ_BAND1);
+		if (dev->hif2) {
+			/*  bn0:ring18 bn1:ring21 */
+			TXQ_CONFIG(0, WFDMA0, MT_INT_TX_DONE_BAND0,
+				   MT7996_TXQ_BAND0);
+			TXQ_CONFIG(1, WFDMA0, MT_INT_TX_DONE_BAND2,
+				   MT7996_TXQ_BAND2);
+		} else {
+			/* single pcie bn0:ring18 bn1:ring19 */
+			TXQ_CONFIG(0, WFDMA0, MT_INT_TX_DONE_BAND0,
+				   MT7996_TXQ_BAND0);
+			TXQ_CONFIG(1, WFDMA0, MT_INT_TX_DONE_BAND1,
+				   MT7996_TXQ_BAND1);
+		}
 	}
 
 	/* mcu tx queue */
@@ -288,8 +318,11 @@ void mt7996_dma_start(struct mt7996_dev *dev, bool reset, bool wed_reset)
 	if (mt7996_band_valid(dev, MT_BAND0))
 		irq_mask |= MT_INT_BAND0_RX_DONE;
 
-	if (mt7996_band_valid(dev, MT_BAND1))
+	if (mt7996_band_valid(dev, MT_BAND1)) {
 		irq_mask |= MT_INT_BAND1_RX_DONE;
+		if (is_mt7992(&dev->mt76) && dev->hif2)
+			irq_mask |= MT_INT_RX_TXFREE_BAND1_EXT;
+	}
 
 	if (mt7996_band_valid(dev, MT_BAND2))
 		irq_mask |= MT_INT_BAND2_RX_DONE;
@@ -378,8 +411,19 @@ static void mt7996_dma_enable(struct mt7996_dev *dev, bool reset)
 			 WF_WFDMA0_GLO_CFG_EXT1_TX_FCTRL_MODE);
 
 		mt76_set(dev, MT_WFDMA_HOST_CONFIG,
-			 MT_WFDMA_HOST_CONFIG_PDMA_BAND |
-			 MT_WFDMA_HOST_CONFIG_BAND2_PCIE1);
+			 MT_WFDMA_HOST_CONFIG_PDMA_BAND);
+
+		mt76_clear(dev, MT_WFDMA_HOST_CONFIG,
+			   MT_WFDMA_HOST_CONFIG_BAND0_PCIE1 |
+			   MT_WFDMA_HOST_CONFIG_BAND1_PCIE1 |
+			   MT_WFDMA_HOST_CONFIG_BAND2_PCIE1);
+
+		if (is_mt7996(&dev->mt76))
+			mt76_set(dev, MT_WFDMA_HOST_CONFIG,
+				 MT_WFDMA_HOST_CONFIG_BAND2_PCIE1);
+		else
+			mt76_set(dev, MT_WFDMA_HOST_CONFIG,
+				 MT_WFDMA_HOST_CONFIG_BAND1_PCIE1);
 
 		/* AXI read outstanding number */
 		mt76_rmw(dev, MT_WFDMA_AXI_R2A_CTRL,
@@ -397,12 +441,18 @@ static void mt7996_dma_enable(struct mt7996_dev *dev, bool reset)
 		 * so, redirect pcie0 rx ring3 interrupt to pcie1
 		 */
 		if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
-		    dev->has_rro)
+		    dev->has_rro) {
+			u32 intr = is_mt7996(&dev->mt76) ?
+				   MT_WFDMA0_RX_INT_SEL_RING6 :
+				   MT_WFDMA0_RX_INT_SEL_RING9 |
+				   MT_WFDMA0_RX_INT_SEL_RING5;
+
 			mt76_set(dev, MT_WFDMA0_RX_INT_PCIE_SEL + hif1_ofs,
-				 MT_WFDMA0_RX_INT_SEL_RING6);
-		else
+				 intr);
+		} else {
 			mt76_set(dev, MT_WFDMA0_RX_INT_PCIE_SEL,
 				 MT_WFDMA0_RX_INT_SEL_RING3);
+		}
 	}
 
 	mt7996_dma_start(dev, reset, true);
@@ -437,7 +487,7 @@ int mt7996_dma_rro_init(struct mt7996_dev *dev)
 	if (ret)
 		return ret;
 
-	if (mt7996_band_valid(dev, MT_BAND1)) {
+	if (mt7996_band_valid(dev, MT_BAND1) && is_mt7996(&dev->mt76)) {
 		/* rx msdu page queue for band1 */
 		mdev->q_rx[MT_RXQ_MSDU_PAGE_BAND1].flags =
 			MT_WED_RRO_Q_MSDU_PG(1) | MT_QFLAG_WED_RRO_EN;
@@ -560,7 +610,9 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 		return ret;
 
 	/* tx free notify event from WA for band0 */
-	if (mtk_wed_device_active(wed) && !dev->has_rro) {
+	if (mtk_wed_device_active(wed) &&
+	    ((is_mt7996(&dev->mt76) && !dev->has_rro) ||
+	     (is_mt7992(&dev->mt76)))) {
 		dev->mt76.q_rx[MT_RXQ_MAIN_WA].flags = MT_WED_Q_TXFREE;
 		dev->mt76.q_rx[MT_RXQ_MAIN_WA].wed = wed;
 	}
@@ -630,6 +682,11 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 	} else if (mt7996_band_valid(dev, MT_BAND1)) {
 		/* rx data queue for mt7992 band1 */
 		rx_base = MT_RXQ_RING_BASE(MT_RXQ_BAND1) + hif1_ofs;
+		if (mtk_wed_device_active(wed) && mtk_wed_get_rx_capa(wed)) {
+			dev->mt76.q_rx[MT_RXQ_BAND1].flags = MT_WED_Q_RX(1);
+			dev->mt76.q_rx[MT_RXQ_BAND1].wed = wed;
+		}
+
 		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_BAND1],
 				       MT_RXQ_ID(MT_RXQ_BAND1),
 				       MT7996_RX_RING_SIZE,
@@ -641,6 +698,12 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 		/* tx free notify event from WA for mt7992 band1 */
 		if (mt7996_has_wa(dev)) {
 			rx_base = MT_RXQ_RING_BASE(MT_RXQ_BAND1_WA) + hif1_ofs;
+			if (mtk_wed_device_active(wed_hif2)) {
+				dev->mt76.q_rx[MT_RXQ_BAND1_WA].flags =
+					MT_WED_Q_TXFREE;
+				dev->mt76.q_rx[MT_RXQ_BAND1_WA].wed = wed_hif2;
+			}
+
 			ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_BAND1_WA],
 					       MT_RXQ_ID(MT_RXQ_BAND1_WA),
 					       MT7996_RX_MCU_RING_SIZE,
@@ -665,17 +728,32 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 		if (ret)
 			return ret;
 
-		/* tx free notify event from WA for band0 */
-		dev->mt76.q_rx[MT_RXQ_TXFREE_BAND0].flags = MT_WED_Q_TXFREE;
-		dev->mt76.q_rx[MT_RXQ_TXFREE_BAND0].wed = wed;
+		if (is_mt7992(&dev->mt76)) {
+			dev->mt76.q_rx[MT_RXQ_RRO_BAND1].flags =
+				MT_WED_RRO_Q_DATA(1) | MT_QFLAG_WED_RRO_EN;
+			dev->mt76.q_rx[MT_RXQ_RRO_BAND1].wed = wed;
+			ret = mt76_queue_alloc(dev,
+					       &dev->mt76.q_rx[MT_RXQ_RRO_BAND1],
+					       MT_RXQ_ID(MT_RXQ_RRO_BAND1),
+					       MT7996_RX_RING_SIZE,
+					       MT7996_RX_BUF_SIZE,
+					       MT_RXQ_RING_BASE(MT_RXQ_RRO_BAND1) + hif1_ofs);
+			if (ret)
+				return ret;
+		} else {
+			/* tx free notify event from WA for band0 */
+			dev->mt76.q_rx[MT_RXQ_TXFREE_BAND0].flags = MT_WED_Q_TXFREE;
+			dev->mt76.q_rx[MT_RXQ_TXFREE_BAND0].wed = wed;
 
-		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_TXFREE_BAND0],
-				       MT_RXQ_ID(MT_RXQ_TXFREE_BAND0),
-				       MT7996_RX_MCU_RING_SIZE,
-				       MT7996_RX_BUF_SIZE,
-				       MT_RXQ_RING_BASE(MT_RXQ_TXFREE_BAND0));
-		if (ret)
-			return ret;
+			ret = mt76_queue_alloc(dev,
+					       &dev->mt76.q_rx[MT_RXQ_TXFREE_BAND0],
+					       MT_RXQ_ID(MT_RXQ_TXFREE_BAND0),
+					       MT7996_RX_MCU_RING_SIZE,
+					       MT7996_RX_BUF_SIZE,
+					       MT_RXQ_RING_BASE(MT_RXQ_TXFREE_BAND0));
+			if (ret)
+				return ret;
+		}
 
 		if (mt7996_band_valid(dev, MT_BAND2)) {
 			/* rx rro data queue for band2 */
@@ -778,18 +856,29 @@ void mt7996_dma_reset(struct mt7996_dev *dev, bool force)
 		mt76_queue_reset(dev, dev->mt76.q_mcu[i], true);
 
 	mt76_for_each_q_rx(&dev->mt76, i) {
-		if (mtk_wed_device_active(&dev->mt76.mmio.wed))
-			if (mt76_queue_is_wed_rro(&dev->mt76.q_rx[i]) ||
-			    mt76_queue_is_wed_tx_free(&dev->mt76.q_rx[i]))
-				continue;
+		struct mt76_queue *q = &dev->mt76.q_rx[i];
 
-		mt76_queue_reset(dev, &dev->mt76.q_rx[i], true);
+		if (mtk_wed_device_active(&dev->mt76.mmio.wed)) {
+			if (mt76_queue_is_wed_rro(q) ||
+			    mt76_queue_is_wed_tx_free(q)) {
+				if (force && mt76_queue_is_wed_rro_data(q))
+					mt76_queue_reset(dev, q, false);
+				continue;
+			}
+		}
+		mt76_queue_reset(dev, q, true);
 	}
 
 	mt76_tx_status_check(&dev->mt76, true);
 
-	mt76_for_each_q_rx(&dev->mt76, i)
+	mt76_for_each_q_rx(&dev->mt76, i) {
+		if (mtk_wed_device_active(&dev->mt76.mmio.wed) && force &&
+		    (mt76_queue_is_wed_rro_ind(&dev->mt76.q_rx[i]) ||
+		     mt76_queue_is_wed_rro_msdu_pg(&dev->mt76.q_rx[i])))
+			continue;
+
 		mt76_queue_rx_reset(dev, i);
+	}
 
 	mt7996_dma_enable(dev, !force);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index fb2428a9b877899a0a6fb879aba84e1f6e7840f2..a8b4ef433c2bfdbbf79ae7f6aa54f33a5d5254ff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -690,12 +690,18 @@ static void mt7996_irq_tasklet(struct tasklet_struct *t)
 					       dev->mt76.mmio.irqmask);
 		if (intr1 & MT_INT_RX_TXFREE_EXT)
 			napi_schedule(&dev->mt76.napi[MT_RXQ_TXFREE_BAND2]);
+
+		if (intr1 & MT_INT_RX_DONE_BAND2_EXT)
+			napi_schedule(&dev->mt76.napi[MT_RXQ_BAND2]);
+
+		if (intr1 & MT_INT_RX_TXFREE_BAND1_EXT)
+			napi_schedule(&dev->mt76.napi[MT_RXQ_BAND1_WA]);
 	}
 
 	if (mtk_wed_device_active(wed)) {
 		mtk_wed_device_irq_set_mask(wed, 0);
 		intr = mtk_wed_device_irq_get(wed, dev->mt76.mmio.irqmask);
-		intr |= (intr1 & ~MT_INT_RX_TXFREE_EXT);
+		intr |= (intr1 & ~MT_INT_TX_RX_DONE_EXT);
 	} else {
 		mt76_wr(dev, MT_INT_MASK_CSR, 0);
 		if (dev->hif2)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 97b84710667ffdb5b6188a72d6f8475f7eb9a128..c210dfd5e37a91ded70e09f51bca52406d7b9d53 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -178,7 +178,7 @@ enum mt7996_rxq_id {
 	MT7996_RXQ_BAND1 = 5, /* for mt7992 */
 	MT7996_RXQ_BAND2 = 5,
 	MT7996_RXQ_RRO_BAND0 = 8,
-	MT7996_RXQ_RRO_BAND1 = 8,/* unused */
+	MT7996_RXQ_RRO_BAND1 = 9,
 	MT7996_RXQ_RRO_BAND2 = 6,
 	MT7996_RXQ_MSDU_PG_BAND0 = 10,
 	MT7996_RXQ_MSDU_PG_BAND1 = 11,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
index e942c0058731cd00bc592e506189820122f2a429..4b8bc008ab3143dcf44cd40b17b9f09778cfd464 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -412,7 +412,9 @@ enum offs_rev {
 
 #define MT_WFDMA0_RX_INT_PCIE_SEL		MT_WFDMA0(0x154)
 #define MT_WFDMA0_RX_INT_SEL_RING3		BIT(3)
+#define MT_WFDMA0_RX_INT_SEL_RING5		BIT(5)
 #define MT_WFDMA0_RX_INT_SEL_RING6		BIT(6)
+#define MT_WFDMA0_RX_INT_SEL_RING9		BIT(9)
 
 #define MT_WFDMA0_MCU_HOST_INT_ENA		MT_WFDMA0(0x1f4)
 
@@ -451,6 +453,8 @@ enum offs_rev {
 
 #define MT_WFDMA_HOST_CONFIG			MT_WFDMA_EXT_CSR(0x30)
 #define MT_WFDMA_HOST_CONFIG_PDMA_BAND		BIT(0)
+#define MT_WFDMA_HOST_CONFIG_BAND0_PCIE1	BIT(20)
+#define MT_WFDMA_HOST_CONFIG_BAND1_PCIE1	BIT(21)
 #define MT_WFDMA_HOST_CONFIG_BAND2_PCIE1	BIT(22)
 
 #define MT_WFDMA_EXT_CSR_HIF_MISC		MT_WFDMA_EXT_CSR(0x44)
@@ -514,7 +518,9 @@ enum offs_rev {
 #define MT_INT_RX_DONE_WA_EXT			BIT(3) /* for mt7992 */
 #define MT_INT_RX_DONE_WA_TRI			BIT(3)
 #define MT_INT_RX_TXFREE_MAIN			BIT(17)
+#define MT_INT_RX_TXFREE_BAND1			BIT(15)
 #define MT_INT_RX_TXFREE_TRI			BIT(15)
+#define MT_INT_RX_TXFREE_BAND1_EXT		BIT(19) /* for mt7992 two PCIE*/
 #define MT_INT_RX_TXFREE_BAND0_MT7990		BIT(14)
 #define MT_INT_RX_TXFREE_BAND1_MT7990		BIT(15)
 #define MT_INT_RX_DONE_BAND2_EXT		BIT(23)
@@ -522,7 +528,7 @@ enum offs_rev {
 #define MT_INT_MCU_CMD				BIT(29)
 
 #define MT_INT_RX_DONE_RRO_BAND0		BIT(16)
-#define MT_INT_RX_DONE_RRO_BAND1		BIT(16)
+#define MT_INT_RX_DONE_RRO_BAND1		BIT(17)
 #define MT_INT_RX_DONE_RRO_BAND2		BIT(14)
 #define MT_INT_RX_DONE_RRO_IND			BIT(11)
 #define MT_INT_RX_DONE_MSDU_PG_BAND0		BIT(18)

-- 
2.50.1


