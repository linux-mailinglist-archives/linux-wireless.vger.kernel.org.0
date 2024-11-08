Return-Path: <linux-wireless+bounces-15146-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB499C1D79
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 14:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95EA1F237B2
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 13:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33931E5721;
	Fri,  8 Nov 2024 13:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="B575EoUZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76241E572A
	for <linux-wireless@vger.kernel.org>; Fri,  8 Nov 2024 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731070830; cv=none; b=lA2IPCXT7AofZ3X4YWoIzSAqwhXNB+PMxTYwu0ETyv4m5txKAJjIEm7OoOa0/m3HJuEPbIPitLi27vrOzWvJP/HVj8O12lly0oew+KlzTLeO3KbzqaKTHJ6B407kHMd3wHkl4o9tQd3L4F5vKE0drRfmLwofagWxkw4narMCRmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731070830; c=relaxed/simple;
	bh=cojPX+J2S03alCotistUQoi1c+sfin7bOYR1AjhkyZE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fgIDQTaCo/M4TgMN/mlUAJsPlDQIshC1y55SfT+KQJHxTpDbWcW8HlCT5Cukr4c3BCN5VdllC+A24FJOgV3dfYa7cvPZM7dmmYMcuaJUI9VNEnrKj+9WxXv1tpOr/yJwFPdXaPC2n9/CTwCzdz4d1ppMCHHsZYKFOlroVLS5SO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=B575EoUZ; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6a175e429dd111efbd192953cf12861f-20241108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=CuHDA2MV+hxzyPXQmomjbbSPnFoUK+qEfMGB6jwT/28=;
	b=B575EoUZtVNyyJp3aE4MHn2Q8Pl36TWzveuvrbg5T1YGY5dgWQEIfiKTE07f+ouYOhVjcqafSHrvDC/mci1Vl68mFzh0LHEEY8u7QIkpN29/t/Hzf95YXJJbDLDiH1VVsJsvDmHfVwx7wj6TdGLN62H91VWjVPIkK/eOtM7bifs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:d15e5150-c670-4125-83d5-55caba1b1c5a,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:b0fcdc3,CLOUDID:e9f8bdca-91e6-4060-9516-6ba489b4e2dc,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6a175e429dd111efbd192953cf12861f-20241108
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <quan.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1507265911; Fri, 08 Nov 2024 21:00:22 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 8 Nov 2024 05:00:21 -0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 8 Nov 2024 21:00:20 +0800
From: Quan Zhou <quan.zhou@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <Deren.Wu@mediatek.com>,
	Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
	Leon Yen <Leon.Yen@mediatek.com>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>, Allan Wang <allan.wang@mediatek.com>, KM Lin
	<km.lin@mediatek.com>, Posh Sun <posh.sun@mediatek.com>, Shengxi Xu
	<shengxi.xu@mediatek.com>, Eric-SY Chang <Eric-SY.Chang@mediatek.com>, CH Yeh
	<ch.yeh@mediatek.com>, Robin Chiu <robin.chiu@mediatek.com>, linux-wireless
	<linux-wireless@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Quan Zhou <quan.zhou@mediatek.com>,
	Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921: fix interference with kernel scheduler
Date: Fri, 8 Nov 2024 20:59:40 +0800
Message-ID: <57c68a7ce1dd9022fa5e06af2c53d6313f30ec83.1731069062.git.quan.zhou@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

In dma init or reset scene, need alloc buffer for all
rx ring unit, this is a time-consuming process. In fact,
a spinlock is not needed in these scenarios, add a new
API mt76_dma_rx_fill_buf which does not use a spinlock to
resolve this interference issue.

Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
Reviewed-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 5f46d6daeaa7..844af16ee551 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -631,7 +631,8 @@ mt76_dma_tx_queue_skb(struct mt76_phy *phy, struct mt76_queue *q,
 	return ret;
 }
 
-int mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q,
+static int
+mt76_dma_rx_fill_buf(struct mt76_dev *dev, struct mt76_queue *q,
 		     bool allow_direct)
 {
 	int len = SKB_WITH_OVERHEAD(q->buf_size);
@@ -640,8 +641,6 @@ int mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q,
 	if (!q->ndesc)
 		return 0;
 
-	spin_lock_bh(&q->lock);
-
 	while (q->queued < q->ndesc - 1) {
 		struct mt76_queue_buf qbuf = {};
 		enum dma_data_direction dir;
@@ -674,6 +673,19 @@ int mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q,
 	if (frames || mt76_queue_is_wed_rx(q))
 		mt76_dma_kick_queue(dev, q);
 
+	return frames;
+}
+
+int mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q,
+		     bool allow_direct)
+{
+	int frames;
+
+	if (!q->ndesc)
+		return 0;
+
+	spin_lock_bh(&q->lock);
+	frames = mt76_dma_rx_fill_buf(dev, q, allow_direct);
 	spin_unlock_bh(&q->lock);
 
 	return frames;
@@ -796,7 +808,7 @@ mt76_dma_rx_reset(struct mt76_dev *dev, enum mt76_rxq_id qid)
 		return;
 
 	mt76_dma_sync_idx(dev, q);
-	mt76_dma_rx_fill(dev, q, false);
+	mt76_dma_rx_fill_buf(dev, q, false);
 }
 
 static void
@@ -969,7 +981,7 @@ mt76_dma_init(struct mt76_dev *dev,
 
 	mt76_for_each_q_rx(dev, i) {
 		netif_napi_add(dev->napi_dev, &dev->napi[i], poll);
-		mt76_dma_rx_fill(dev, &dev->q_rx[i], false);
+		mt76_dma_rx_fill_buf(dev, &dev->q_rx[i], false);
 		napi_enable(&dev->napi[i]);
 	}
 
-- 
2.46.0


