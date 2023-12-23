Return-Path: <linux-wireless+bounces-1258-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E2581D20C
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Dec 2023 05:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F12A1C22822
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Dec 2023 04:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B051373;
	Sat, 23 Dec 2023 04:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lGByIyXs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FCD1113
	for <linux-wireless@vger.kernel.org>; Sat, 23 Dec 2023 04:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c6389af6a14711eea5db2bebc7c28f94-20231223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=T4y2M/bxn/FUb1H1/6pqnuKBUyHHVpd9Ga7hLziROJI=;
	b=lGByIyXsfZjyhHA+NddFov4NJvk1gMAOJRcYwv+DJAJ6jWLi86AHM7vhShpgFFCt/y4oS5JZMx2lZ38JRJTVKVUUqW+DgQxD2oJoKiyWWYW0J1MsWYTMKLnQg9wm0fkXCf/pavK6S5TXlP9If2ZhOdlJDKq6qwcKPl4ePgaPeO8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:0c1007da-d9b8-4f8c-97e7-4606fbf5382b,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:56f47b8d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c6389af6a14711eea5db2bebc7c28f94-20231223
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <deren.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1157339588; Sat, 23 Dec 2023 12:00:13 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 23 Dec 2023 12:00:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 23 Dec 2023 12:00:12 +0800
From: Deren Wu <deren.wu@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC: Sean Wang <sean.wang@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>, linux-wireless
	<linux-wireless@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 3/3] wifi: mt76: mt792xu: enable dmashdl support
Date: Sat, 23 Dec 2023 11:43:08 +0800
Message-ID: <28d84bfc81e90be921c28fbda7e79e33b2b515d0.1703301666.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <3eb3a860ccdf465b77ae63d6ddcf6a584d1729ce.1703301666.git.deren.wu@mediatek.com>
References: <3eb3a860ccdf465b77ae63d6ddcf6a584d1729ce.1703301666.git.deren.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

dmashdl(DMA scheduler) was disable and may cause packets corruption
without propoer resource handling. Enable this to control resources
between usb-bus/pse/hardware-ac-queue.

Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt792x_usb.c   | 74 +++++++++----------
 1 file changed, 36 insertions(+), 38 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
index 2dd283caed36..fbf49da16b92 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
@@ -121,44 +121,25 @@ static void mt792xu_uhw_wr(struct mt76_dev *dev, u32 addr, u32 val)
 
 static void mt792xu_dma_prefetch(struct mt792x_dev *dev)
 {
-	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL(0),
-		 MT_WPDMA0_MAX_CNT_MASK, 4);
-	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL(0),
-		 MT_WPDMA0_BASE_PTR_MASK, 0x80);
-
-	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL(1),
-		 MT_WPDMA0_MAX_CNT_MASK, 4);
-	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL(1),
-		 MT_WPDMA0_BASE_PTR_MASK, 0xc0);
-
-	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL(2),
-		 MT_WPDMA0_MAX_CNT_MASK, 4);
-	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL(2),
-		 MT_WPDMA0_BASE_PTR_MASK, 0x100);
-
-	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL(3),
-		 MT_WPDMA0_MAX_CNT_MASK, 4);
-	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL(3),
-		 MT_WPDMA0_BASE_PTR_MASK, 0x140);
-
-	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL(4),
-		 MT_WPDMA0_MAX_CNT_MASK, 4);
-	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL(4),
-		 MT_WPDMA0_BASE_PTR_MASK, 0x180);
-
-	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL(16),
-		 MT_WPDMA0_MAX_CNT_MASK, 4);
-	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL(16),
-		 MT_WPDMA0_BASE_PTR_MASK, 0x280);
-
-	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL(17),
-		 MT_WPDMA0_MAX_CNT_MASK, 4);
-	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL(17),
-		 MT_WPDMA0_BASE_PTR_MASK,  0x2c0);
+#define DMA_PREFETCH_CONF(_idx_, _cnt_, _base_) \
+	mt76_rmw(dev, MT_UWFDMA0_TX_RING_EXT_CTRL((_idx_)), \
+		 MT_WPDMA0_MAX_CNT_MASK | MT_WPDMA0_BASE_PTR_MASK, \
+		 FIELD_PREP(MT_WPDMA0_MAX_CNT_MASK, (_cnt_)) | \
+		 FIELD_PREP(MT_WPDMA0_BASE_PTR_MASK, (_base_)))
+
+	DMA_PREFETCH_CONF(0, 4, 0x080);
+	DMA_PREFETCH_CONF(1, 4, 0x0c0);
+	DMA_PREFETCH_CONF(2, 4, 0x100);
+	DMA_PREFETCH_CONF(3, 4, 0x140);
+	DMA_PREFETCH_CONF(4, 4, 0x180);
+	DMA_PREFETCH_CONF(16, 4, 0x280);
+	DMA_PREFETCH_CONF(17, 4, 0x2c0);
 }
 
 static void mt792xu_wfdma_init(struct mt792x_dev *dev)
 {
+	int i;
+
 	mt792xu_dma_prefetch(dev);
 
 	mt76_clear(dev, MT_UWFDMA0_GLO_CFG, MT_WFDMA0_GLO_CFG_OMIT_RX_INFO);
@@ -169,10 +150,27 @@ static void mt792xu_wfdma_init(struct mt792x_dev *dev)
 		 MT_WFDMA0_GLO_CFG_TX_DMA_EN |
 		 MT_WFDMA0_GLO_CFG_RX_DMA_EN);
 
-	/* disable dmashdl */
-	mt76_clear(dev, MT_UWFDMA0_GLO_CFG_EXT0,
-		   MT_WFDMA0_CSR_TX_DMASHDL_ENABLE);
-	mt76_set(dev, MT_DMASHDL_SW_CONTROL, MT_DMASHDL_DMASHDL_BYPASS);
+	mt76_rmw(dev, MT_DMASHDL_REFILL, MT_DMASHDL_REFILL_MASK, 0xffe00000);
+	mt76_clear(dev, MT_DMASHDL_PAGE, MT_DMASHDL_GROUP_SEQ_ORDER);
+	mt76_rmw(dev, MT_DMASHDL_PKT_MAX_SIZE,
+		 MT_DMASHDL_PKT_MAX_SIZE_PLE | MT_DMASHDL_PKT_MAX_SIZE_PSE,
+		 FIELD_PREP(MT_DMASHDL_PKT_MAX_SIZE_PLE, 1) |
+		 FIELD_PREP(MT_DMASHDL_PKT_MAX_SIZE_PSE, 0));
+	for (i = 0; i < 5; i++)
+		mt76_wr(dev, MT_DMASHDL_GROUP_QUOTA(i),
+			FIELD_PREP(MT_DMASHDL_GROUP_QUOTA_MIN, 0x3) |
+			FIELD_PREP(MT_DMASHDL_GROUP_QUOTA_MAX, 0xfff));
+	for (i = 5; i < 16; i++)
+		mt76_wr(dev, MT_DMASHDL_GROUP_QUOTA(i),
+			FIELD_PREP(MT_DMASHDL_GROUP_QUOTA_MIN, 0x0) |
+			FIELD_PREP(MT_DMASHDL_GROUP_QUOTA_MAX, 0x0));
+	mt76_wr(dev, MT_DMASHDL_Q_MAP(0), 0x32013201);
+	mt76_wr(dev, MT_DMASHDL_Q_MAP(1), 0x32013201);
+	mt76_wr(dev, MT_DMASHDL_Q_MAP(2), 0x55555444);
+	mt76_wr(dev, MT_DMASHDL_Q_MAP(3), 0x55555444);
+
+	mt76_wr(dev, MT_DMASHDL_SCHED_SET(0), 0x76540132);
+	mt76_wr(dev, MT_DMASHDL_SCHED_SET(1), 0xFEDCBA98);
 
 	mt76_set(dev, MT_WFDMA_DUMMY_CR, MT_WFDMA_NEED_REINIT);
 }
-- 
2.18.0


