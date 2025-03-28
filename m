Return-Path: <linux-wireless+bounces-20919-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B35FA743A9
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 06:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEB6C7A7A65
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 05:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10B5211712;
	Fri, 28 Mar 2025 05:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UY9QN4Ac"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C0F21147A
	for <linux-wireless@vger.kernel.org>; Fri, 28 Mar 2025 05:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743141248; cv=none; b=RdwSqx6jDWSVGDvcmQ+/+tk3yATsd3FSqJWqokbEOGQkz7vzsqPaPGQyddAt6MbyV9TTKApuE1LeqMWYTj6YFHZNTu+zLjcMqVB9+wBQ78DcNR3kHOhZyiCJOlspQuaxmp+enRclYs1jpqqqFETksYhVnTT4eDMCODUtlfOwWVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743141248; c=relaxed/simple;
	bh=8RaYkJuKN+RBZ/q25z4k2TWXIVIJ6XUeVsrJJB2v4+4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DqTCNu0xOBmQtDeCyjzD8ZQwqXJEpFhTaYvJFthUatbKNeI29xGmafUOMOGGjB2blSM133G0p7eZcycegIEMvL9nROHthDLsXvfy4DzkWuGVip+AQoga6LS4nm3cnxIxg3KlKga6y/kMKQ0fBHXrD0ZZcw7FozQZsw60pziqeuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=UY9QN4Ac; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0ab87cd40b9911f08eb9c36241bbb6fb-20250328
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=uaWNLvaYbJxey0yjI0NWUzxO7aZy+Lo4fDC8zAzMSyY=;
	b=UY9QN4AcEpr+G/tJD/mnkNpLa785WnSzFuTWqL7ymG99ABGuKt78sweS4dMfu5qOWrn22dwjd1hZHU3ezASrnysi995NxH2BCSnKDVn2J+rYBodRqMJmurl0mjkgFR0zg1JYLl6M4o0FxwcbD3oLlOOIeC+yuIDSHO12w586CN4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:db8dac59-d5a8-42c3-85a9-033bd934fab7,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:0ef645f,CLOUDID:ca64ab4a-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0ab87cd40b9911f08eb9c36241bbb6fb-20250328
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 484176463; Fri, 28 Mar 2025 13:53:58 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 28 Mar 2025 13:53:57 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 28 Mar 2025 13:53:57 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Peter Chiu
	<chui-hao.chiu@mediatek.com>, StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 04/10] wifi: mt76: mt7996: rework DMA configuration for mt7990
Date: Fri, 28 Mar 2025 13:50:52 +0800
Message-ID: <20250328055058.1648755-5-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250328055058.1648755-1-shayne.chen@mediatek.com>
References: <20250328055058.1648755-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Peter Chiu <chui-hao.chiu@mediatek.com>

Modify DMA ring setting for mt7990.
This is a preliminary patch to support mt7990 chipset.

Co-developed-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/dma.c   | 192 ++++++++++++------
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |   2 +
 .../net/wireless/mediatek/mt76/mt7996/regs.h  |   4 +-
 3 files changed, 135 insertions(+), 63 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
index 69a7d9b2e38b..fe8cc1d3f738 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
@@ -55,20 +55,32 @@ static void mt7996_dma_config(struct mt7996_dev *dev)
 
 	/* rx queue */
 	RXQ_CONFIG(MT_RXQ_MCU, WFDMA0, MT_INT_RX_DONE_WM, MT7996_RXQ_MCU_WM);
+	/* for mt7990, RX ring 1 is for SDO instead */
 	RXQ_CONFIG(MT_RXQ_MCU_WA, WFDMA0, MT_INT_RX_DONE_WA, MT7996_RXQ_MCU_WA);
-
-	/* mt7996: band0 and band1, mt7992: band0 */
 	RXQ_CONFIG(MT_RXQ_MAIN, WFDMA0, MT_INT_RX_DONE_BAND0, MT7996_RXQ_BAND0);
-	RXQ_CONFIG(MT_RXQ_MAIN_WA, WFDMA0, MT_INT_RX_DONE_WA_MAIN, MT7996_RXQ_MCU_WA_MAIN);
+	if (mt7996_has_wa(dev))
+		RXQ_CONFIG(MT_RXQ_MAIN_WA, WFDMA0, MT_INT_RX_DONE_WA_MAIN,
+			   MT7996_RXQ_MCU_WA_MAIN);
 
-	if (is_mt7996(&dev->mt76)) {
+	switch (mt76_chip(&dev->mt76)) {
+	case MT7992_DEVICE_ID:
+		RXQ_CONFIG(MT_RXQ_BAND1_WA, WFDMA0, MT_INT_RX_DONE_WA_EXT, MT7996_RXQ_MCU_WA_EXT);
+		RXQ_CONFIG(MT_RXQ_BAND1, WFDMA0, MT_INT_RX_DONE_BAND1, MT7996_RXQ_BAND1);
+		break;
+	case MT7990_DEVICE_ID:
+		RXQ_CONFIG(MT_RXQ_BAND1, WFDMA0, MT_INT_RX_DONE_BAND1, MT7996_RXQ_BAND1);
+		RXQ_CONFIG(MT_RXQ_TXFREE_BAND0, WFDMA0,
+			   MT_INT_RX_TXFREE_BAND0_MT7990, MT7990_RXQ_TXFREE0);
+		if (dev->hif2)
+			RXQ_CONFIG(MT_RXQ_TXFREE_BAND1, WFDMA0,
+				   MT_INT_RX_TXFREE_BAND1_MT7990, MT7990_RXQ_TXFREE1);
+		break;
+	case MT7996_DEVICE_ID:
+	default:
 		/* mt7996 band2 */
-		RXQ_CONFIG(MT_RXQ_BAND2, WFDMA0, MT_INT_RX_DONE_BAND2, MT7996_RXQ_BAND2);
 		RXQ_CONFIG(MT_RXQ_BAND2_WA, WFDMA0, MT_INT_RX_DONE_WA_TRI, MT7996_RXQ_MCU_WA_TRI);
-	} else {
-		/* mt7992 band1 */
-		RXQ_CONFIG(MT_RXQ_BAND1, WFDMA0, MT_INT_RX_DONE_BAND1, MT7996_RXQ_BAND1);
-		RXQ_CONFIG(MT_RXQ_BAND1_WA, WFDMA0, MT_INT_RX_DONE_WA_EXT, MT7996_RXQ_MCU_WA_EXT);
+		RXQ_CONFIG(MT_RXQ_BAND2, WFDMA0, MT_INT_RX_DONE_BAND2, MT7996_RXQ_BAND2);
+		break;
 	}
 
 	if (dev->has_rro) {
@@ -104,9 +116,11 @@ static void mt7996_dma_config(struct mt7996_dev *dev)
 	}
 
 	/* mcu tx queue */
-	MCUQ_CONFIG(MT_MCUQ_WM, WFDMA0, MT_INT_TX_DONE_MCU_WM, MT7996_TXQ_MCU_WM);
-	MCUQ_CONFIG(MT_MCUQ_WA, WFDMA0, MT_INT_TX_DONE_MCU_WA, MT7996_TXQ_MCU_WA);
 	MCUQ_CONFIG(MT_MCUQ_FWDL, WFDMA0, MT_INT_TX_DONE_FWDL, MT7996_TXQ_FWDL);
+	MCUQ_CONFIG(MT_MCUQ_WM, WFDMA0, MT_INT_TX_DONE_MCU_WM, MT7996_TXQ_MCU_WM);
+	if (mt7996_has_wa(dev))
+		MCUQ_CONFIG(MT_MCUQ_WA, WFDMA0, MT_INT_TX_DONE_MCU_WA,
+			    MT7996_TXQ_MCU_WA);
 }
 
 static u32 __mt7996_dma_prefetch_base(u16 *base, u8 depth)
@@ -121,43 +135,62 @@ static u32 __mt7996_dma_prefetch_base(u16 *base, u8 depth)
 static void __mt7996_dma_prefetch(struct mt7996_dev *dev, u32 ofs)
 {
 	u16 base = 0;
-	u8 queue;
+	u8 queue, val;
 
 #define PREFETCH(_depth)	(__mt7996_dma_prefetch_base(&base, (_depth)))
 	/* prefetch SRAM wrapping boundary for tx/rx ring. */
-	mt76_wr(dev, MT_MCUQ_EXT_CTRL(MT_MCUQ_FWDL) + ofs, PREFETCH(0x2));
-	mt76_wr(dev, MT_MCUQ_EXT_CTRL(MT_MCUQ_WM) + ofs, PREFETCH(0x2));
+	/* Tx Command Rings */
+	val = is_mt7996(&dev->mt76) ? 2 : 4;
+	mt76_wr(dev, MT_MCUQ_EXT_CTRL(MT_MCUQ_FWDL) + ofs, PREFETCH(val));
+	mt76_wr(dev, MT_MCUQ_EXT_CTRL(MT_MCUQ_WM) + ofs, PREFETCH(val));
+	if (mt7996_has_wa(dev))
+		mt76_wr(dev, MT_MCUQ_EXT_CTRL(MT_MCUQ_WA) + ofs, PREFETCH(val));
+
+	/* Tx Data Rings */
 	mt76_wr(dev, MT_TXQ_EXT_CTRL(0) + ofs, PREFETCH(0x8));
-	mt76_wr(dev, MT_TXQ_EXT_CTRL(1) + ofs, PREFETCH(0x8));
-	mt76_wr(dev, MT_MCUQ_EXT_CTRL(MT_MCUQ_WA) + ofs, PREFETCH(0x2));
-	mt76_wr(dev, MT_TXQ_EXT_CTRL(2) + ofs, PREFETCH(0x8));
-	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MCU) + ofs, PREFETCH(0x2));
-	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MCU_WA) + ofs, PREFETCH(0x2));
-	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MAIN_WA) + ofs, PREFETCH(0x2));
-
-	queue = is_mt7996(&dev->mt76) ? MT_RXQ_BAND2_WA : MT_RXQ_BAND1_WA;
-	mt76_wr(dev, MT_RXQ_BAND1_CTRL(queue) + ofs, PREFETCH(0x2));
-
-	mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MAIN) + ofs, PREFETCH(0x10));
+	if (!is_mt7996(&dev->mt76) || dev->hif2)
+		mt76_wr(dev, MT_TXQ_EXT_CTRL(1) + ofs, PREFETCH(0x8));
+	if (is_mt7996(&dev->mt76))
+		mt76_wr(dev, MT_TXQ_EXT_CTRL(2) + ofs, PREFETCH(0x8));
+
+	/* Rx Event Rings */
+	mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_MCU) + ofs, PREFETCH(val));
+	mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_MCU_WA) + ofs, PREFETCH(val));
+
+	/* Rx TxFreeDone From WA Rings */
+	if (mt7996_has_wa(dev)) {
+		mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_MAIN_WA) + ofs, PREFETCH(val));
+		queue = is_mt7996(&dev->mt76) ? MT_RXQ_BAND2_WA : MT_RXQ_BAND1_WA;
+		mt76_wr(dev, MT_RXQ_EXT_CTRL(queue) + ofs, PREFETCH(val));
+	}
 
+	/* Rx TxFreeDone From MAC Rings */
+	val = is_mt7996(&dev->mt76) ? 4 : 8;
+	if (is_mt7990(&dev->mt76) || (is_mt7996(&dev->mt76) && dev->has_rro))
+		mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_TXFREE_BAND0) + ofs, PREFETCH(val));
+	if (is_mt7990(&dev->mt76) && dev->hif2)
+		mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_TXFREE_BAND1) + ofs, PREFETCH(val));
+	else if (is_mt7996(&dev->mt76) && dev->has_rro)
+		mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_TXFREE_BAND2) + ofs, PREFETCH(val));
+
+	/* Rx Data Rings */
+	mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_MAIN) + ofs, PREFETCH(0x10));
 	queue = is_mt7996(&dev->mt76) ? MT_RXQ_BAND2 : MT_RXQ_BAND1;
-	mt76_wr(dev, MT_RXQ_BAND1_CTRL(queue) + ofs, PREFETCH(0x10));
+	mt76_wr(dev, MT_RXQ_EXT_CTRL(queue) + ofs, PREFETCH(0x10));
 
+	/* Rx RRO Rings */
 	if (dev->has_rro) {
-		mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_RRO_BAND0) + ofs,
-			PREFETCH(0x10));
-		mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_RRO_BAND2) + ofs,
-			PREFETCH(0x10));
-		mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MSDU_PAGE_BAND0) + ofs,
-			PREFETCH(0x4));
-		mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MSDU_PAGE_BAND1) + ofs,
-			PREFETCH(0x4));
-		mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_MSDU_PAGE_BAND2) + ofs,
-			PREFETCH(0x4));
-		mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_TXFREE_BAND0) + ofs,
-			PREFETCH(0x4));
-		mt76_wr(dev, MT_RXQ_BAND1_CTRL(MT_RXQ_TXFREE_BAND2) + ofs,
-			PREFETCH(0x4));
+		mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_RRO_BAND0) + ofs, PREFETCH(0x10));
+		queue = is_mt7996(&dev->mt76) ? MT_RXQ_RRO_BAND2 : MT_RXQ_RRO_BAND1;
+		mt76_wr(dev, MT_RXQ_EXT_CTRL(queue) + ofs, PREFETCH(0x10));
+
+		mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_MSDU_PAGE_BAND0) + ofs, PREFETCH(val));
+		if (is_mt7996(&dev->mt76)) {
+			mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_MSDU_PAGE_BAND1) + ofs,
+				PREFETCH(val));
+			mt76_wr(dev, MT_RXQ_EXT_CTRL(MT_RXQ_MSDU_PAGE_BAND2) + ofs,
+				PREFETCH(val));
+		}
 	}
 #undef PREFETCH
 
@@ -269,6 +302,9 @@ void mt7996_dma_start(struct mt7996_dev *dev, bool reset, bool wed_reset)
 		mtk_wed_device_start(wed, wed_irq_mask);
 	}
 
+	if (!mt7996_has_wa(dev))
+		irq_mask &= ~(MT_INT_RX(MT_RXQ_MAIN_WA) |
+			      MT_INT_RX(MT_RXQ_BAND1_WA));
 	irq_mask = reset ? MT_INT_MCU_CMD : irq_mask;
 
 	mt7996_irq_enable(dev, irq_mask);
@@ -474,12 +510,14 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 		return ret;
 
 	/* command to WA */
-	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_WA,
-				  MT_MCUQ_ID(MT_MCUQ_WA),
-				  MT7996_TX_MCU_RING_SIZE,
-				  MT_MCUQ_RING_BASE(MT_MCUQ_WA));
-	if (ret)
-		return ret;
+	if (mt7996_has_wa(dev)) {
+		ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_WA,
+					  MT_MCUQ_ID(MT_MCUQ_WA),
+					  MT7996_TX_MCU_RING_SIZE,
+					  MT_MCUQ_RING_BASE(MT_MCUQ_WA));
+		if (ret)
+			return ret;
+	}
 
 	/* firmware download */
 	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_FWDL,
@@ -498,7 +536,7 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 	if (ret)
 		return ret;
 
-	/* event from WA */
+	/* event from WA, or SDO event for mt7990 */
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU_WA],
 			       MT_RXQ_ID(MT_RXQ_MCU_WA),
 			       MT7996_RX_MCU_RING_SIZE_WA,
@@ -527,13 +565,41 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 		dev->mt76.q_rx[MT_RXQ_MAIN_WA].wed = wed;
 	}
 
-	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN_WA],
-			       MT_RXQ_ID(MT_RXQ_MAIN_WA),
-			       MT7996_RX_MCU_RING_SIZE,
-			       MT_RX_BUF_SIZE,
-			       MT_RXQ_RING_BASE(MT_RXQ_MAIN_WA));
-	if (ret)
-		return ret;
+	if (mt7996_has_wa(dev)) {
+		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN_WA],
+				       MT_RXQ_ID(MT_RXQ_MAIN_WA),
+				       MT7996_RX_MCU_RING_SIZE,
+				       MT_RX_BUF_SIZE,
+				       MT_RXQ_RING_BASE(MT_RXQ_MAIN_WA));
+		if (ret)
+			return ret;
+	} else {
+		if (mtk_wed_device_active(wed)) {
+			dev->mt76.q_rx[MT_RXQ_TXFREE_BAND0].flags = MT_WED_Q_TXFREE;
+			dev->mt76.q_rx[MT_RXQ_TXFREE_BAND0].wed = wed;
+		}
+		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_TXFREE_BAND0],
+				       MT_RXQ_ID(MT_RXQ_TXFREE_BAND0),
+				       MT7996_RX_MCU_RING_SIZE,
+				       MT7996_RX_BUF_SIZE,
+				       MT_RXQ_RING_BASE(MT_RXQ_TXFREE_BAND0));
+		if (ret)
+			return ret;
+	}
+
+	if (!mt7996_has_wa(dev) && dev->hif2) {
+		if (mtk_wed_device_active(wed)) {
+			dev->mt76.q_rx[MT_RXQ_TXFREE_BAND1].flags = MT_WED_Q_TXFREE;
+			dev->mt76.q_rx[MT_RXQ_TXFREE_BAND1].wed = wed;
+		}
+		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_TXFREE_BAND1],
+				       MT_RXQ_ID(MT_RXQ_TXFREE_BAND1),
+				       MT7996_RX_MCU_RING_SIZE,
+				       MT7996_RX_BUF_SIZE,
+				       MT_RXQ_RING_BASE(MT_RXQ_TXFREE_BAND1));
+		if (ret)
+			return ret;
+	}
 
 	if (mt7996_band_valid(dev, MT_BAND2)) {
 		/* rx data queue for mt7996 band2 */
@@ -573,14 +639,16 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 			return ret;
 
 		/* tx free notify event from WA for mt7992 band1 */
-		rx_base = MT_RXQ_RING_BASE(MT_RXQ_BAND1_WA) + hif1_ofs;
-		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_BAND1_WA],
-				       MT_RXQ_ID(MT_RXQ_BAND1_WA),
-				       MT7996_RX_MCU_RING_SIZE,
-				       MT_RX_BUF_SIZE,
-				       rx_base);
-		if (ret)
-			return ret;
+		if (mt7996_has_wa(dev)) {
+			rx_base = MT_RXQ_RING_BASE(MT_RXQ_BAND1_WA) + hif1_ofs;
+			ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_BAND1_WA],
+					       MT_RXQ_ID(MT_RXQ_BAND1_WA),
+					       MT7996_RX_MCU_RING_SIZE,
+					       MT_RX_BUF_SIZE,
+					       rx_base);
+			if (ret)
+				return ret;
+		}
 	}
 
 	if (mtk_wed_device_active(wed) && mtk_wed_get_rx_capa(wed) &&
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index c03747ed6c70..148271fcd88f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -177,6 +177,8 @@ enum mt7996_rxq_id {
 	MT7996_RXQ_TXFREE1 = 9,
 	MT7996_RXQ_TXFREE2 = 7,
 	MT7996_RXQ_RRO_IND = 0,
+	MT7990_RXQ_TXFREE0 = 6,
+	MT7990_RXQ_TXFREE1 = 7,
 };
 
 struct mt7996_twt_flow {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
index 1876a968c92d..1981b6250f45 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -483,7 +483,7 @@ enum offs_rev {
 
 #define MT_MCUQ_EXT_CTRL(q)			(MT_Q_BASE(q) +	0x600 +	\
 						 MT_MCUQ_ID(q) * 0x4)
-#define MT_RXQ_BAND1_CTRL(q)			(MT_Q_BASE(__RXQ(q)) + 0x680 +	\
+#define MT_RXQ_EXT_CTRL(q)			(MT_Q_BASE(__RXQ(q)) + 0x680 +	\
 						 MT_RXQ_ID(q) * 0x4)
 #define MT_TXQ_EXT_CTRL(q)			(MT_Q_BASE(__TXQ(q)) + 0x600 +	\
 						 MT_TXQ_ID(q) * 0x4)
@@ -504,6 +504,8 @@ enum offs_rev {
 #define MT_INT_RX_DONE_WA_TRI			BIT(3)
 #define MT_INT_RX_TXFREE_MAIN			BIT(17)
 #define MT_INT_RX_TXFREE_TRI			BIT(15)
+#define MT_INT_RX_TXFREE_BAND0_MT7990		BIT(14)
+#define MT_INT_RX_TXFREE_BAND1_MT7990		BIT(15)
 #define MT_INT_RX_DONE_BAND2_EXT		BIT(23)
 #define MT_INT_RX_TXFREE_EXT			BIT(26)
 #define MT_INT_MCU_CMD				BIT(29)
-- 
2.39.2


