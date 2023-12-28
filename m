Return-Path: <linux-wireless+bounces-1302-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3690E81F638
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Dec 2023 10:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5A01F225B5
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Dec 2023 09:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6685E748E;
	Thu, 28 Dec 2023 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FqhuLZ98"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8416FBE
	for <linux-wireless@vger.kernel.org>; Thu, 28 Dec 2023 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 95af6a14a56011eea2298b7352fd921d-20231228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ixki3DqzAq4cmzEmI1gi4aPq+TJbnvD0XOxbDCZxy9M=;
	b=FqhuLZ98J3P7OaLBei41NcWbOO3DPdLk+BpklEPAXlVRg5z/JTvZ819HuXlCOXKzbhQrecgBTwSfsGjIkQUUgT+XOk8McfNoXGfEKWVm0cBbknLsJOs7b8UB2ProgTF8ps/X2nfSo4nmDTVmZbUeCbecH5S9TkWEZpGwMCh3pnE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:85b0a4ff-bd24-496e-90ee-41f660243dd1,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:5d391d7,CLOUDID:a27ca98d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 95af6a14a56011eea2298b7352fd921d-20231228
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 502072708; Thu, 28 Dec 2023 17:07:54 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 28 Dec 2023 17:07:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 28 Dec 2023 17:07:52 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Eric-SY.Chang@mediatek.com>, <km.lin@mediatek.com>,
	<robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
	<Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH 10/10] wifi: mt76: mt7925: update PCIe DMA settings
Date: Thu, 28 Dec 2023 17:07:49 +0800
Message-ID: <20231228090749.15191-11-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231228090749.15191-1-mingyen.hsieh@mediatek.com>
References: <20231228090749.15191-1-mingyen.hsieh@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Deren Wu <deren.wu@mediatek.com>

Fix the wrong WFDMA settings to improve TX performance.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt792x_dma.c  | 13 ++++++++++---
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h |  5 +++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
index 488326ce5ed4..8fa36b59e738 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
@@ -123,14 +123,13 @@ static void mt792x_dma_prefetch(struct mt792x_dev *dev)
 
 int mt792x_dma_enable(struct mt792x_dev *dev)
 {
-	if (is_mt7925(&dev->mt76))
-		mt76_rmw(dev, MT_UWFDMA0_GLO_CFG_EXT1, BIT(28), BIT(28));
-
 	/* configure perfetch settings */
 	mt792x_dma_prefetch(dev);
 
 	/* reset dma idx */
 	mt76_wr(dev, MT_WFDMA0_RST_DTX_PTR, ~0);
+	if (is_mt7925(&dev->mt76))
+		mt76_wr(dev, MT_WFDMA0_RST_DRX_PTR, ~0);
 
 	/* configure delay interrupt */
 	mt76_wr(dev, MT_WFDMA0_PRI_DLY_INT_CFG0, 0);
@@ -140,12 +139,20 @@ int mt792x_dma_enable(struct mt792x_dev *dev)
 		 MT_WFDMA0_GLO_CFG_FIFO_LITTLE_ENDIAN |
 		 MT_WFDMA0_GLO_CFG_CLK_GAT_DIS |
 		 MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+		 FIELD_PREP(MT_WFDMA0_GLO_CFG_DMA_SIZE, 3) |
+		 MT_WFDMA0_GLO_CFG_FIFO_DIS_CHECK |
+		 MT_WFDMA0_GLO_CFG_RX_WB_DDONE |
 		 MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN |
 		 MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
 
 	mt76_set(dev, MT_WFDMA0_GLO_CFG,
 		 MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
 
+	if (is_mt7925(&dev->mt76)) {
+		mt76_rmw(dev, MT_UWFDMA0_GLO_CFG_EXT1, BIT(28), BIT(28));
+		mt76_set(dev, MT_WFDMA0_INT_RX_PRI, 0x0F00);
+		mt76_set(dev, MT_WFDMA0_INT_TX_PRI, 0x7F00);
+	}
 	mt76_set(dev, MT_WFDMA_DUMMY_CR, MT_WFDMA_NEED_REINIT);
 
 	/* enable interrupts for TX/RX rings */
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
index d7f9b24cd665..458cfd0260b1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
@@ -292,9 +292,12 @@
 #define MT_WFDMA0_GLO_CFG_TX_DMA_BUSY	BIT(1)
 #define MT_WFDMA0_GLO_CFG_RX_DMA_EN	BIT(2)
 #define MT_WFDMA0_GLO_CFG_RX_DMA_BUSY	BIT(3)
+#define MT_WFDMA0_GLO_CFG_DMA_SIZE	GENMASK(5, 4)
 #define MT_WFDMA0_GLO_CFG_TX_WB_DDONE	BIT(6)
 #define MT_WFDMA0_GLO_CFG_FW_DWLD_BYPASS_DMASHDL BIT(9)
+#define MT_WFDMA0_GLO_CFG_FIFO_DIS_CHECK	BIT(11)
 #define MT_WFDMA0_GLO_CFG_FIFO_LITTLE_ENDIAN	BIT(12)
+#define MT_WFDMA0_GLO_CFG_RX_WB_DDONE	BIT(13)
 #define MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN BIT(15)
 #define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2	BIT(21)
 #define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO	BIT(27)
@@ -322,6 +325,8 @@
 
 #define MT_WFDMA0_RST_DTX_PTR		MT_WFDMA0(0x20c)
 #define MT_WFDMA0_RST_DRX_PTR		MT_WFDMA0(0x280)
+#define MT_WFDMA0_INT_RX_PRI		MT_WFDMA0(0x298)
+#define MT_WFDMA0_INT_TX_PRI		MT_WFDMA0(0x29c)
 #define MT_WFDMA0_GLO_CFG_EXT0		MT_WFDMA0(0x2b0)
 #define MT_WFDMA0_CSR_TX_DMASHDL_ENABLE	BIT(6)
 #define MT_WFDMA0_PRI_DLY_INT_CFG0	MT_WFDMA0(0x2f0)
-- 
2.18.0


