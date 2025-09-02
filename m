Return-Path: <linux-wireless+bounces-26951-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9FDB40DC7
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 21:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93E34547C89
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 19:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269CC2DC354;
	Tue,  2 Sep 2025 19:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuCEWh7K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B7F20C038
	for <linux-wireless@vger.kernel.org>; Tue,  2 Sep 2025 19:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756840719; cv=none; b=GfqBRb3hhnvgDq4O6ul+pFDq6EfNMh6Z5WWicBWd07loMpO0rx0SxhdyTZavB8MShadJGaBbdROx9shiwLEUefBp3NFZ56YqacIlEYz+7jGHMZWPTWXCnByZhQhQGn82Lz1Twd27EYT+2BxNsyw34Y8PQdEpG7bxoIcoxWHv55w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756840719; c=relaxed/simple;
	bh=znKJ9nC54lsSWItEe6JUCBFCQm719fqJmv5yai3fHu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PTZWDi25oaP3ekUhyG+vXtP3KpreABhpIF7E+mI5OoxXjUox3E9HdkA0voqCXrFnQnoi0EP28+3S4UlMTvfZuchD+0Erm2n4vdMsE7peQ8yKMWfiIpvHFwnPvUGqHFmmrmX7PlbE8stbLPn1aqJF6eA6sJBLtVr5Ou+I8vo7ZbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuCEWh7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823BCC4CEED;
	Tue,  2 Sep 2025 19:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756840718;
	bh=znKJ9nC54lsSWItEe6JUCBFCQm719fqJmv5yai3fHu8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BuCEWh7K+uWf4/IuSQvzoVzMBmFMjspRxEWaEwqOsNN4o5Dml9U/HOPpKbojYGJLa
	 roqRbds8WXDuhF77yzZcUmIrfOQhDc+JaxQ7UoRx48Sy6f95JjvNgdep8w70J37v2L
	 QKAlpm9QmY3Ev72b5YrQEpw8aK6cdVAe6+9N9azyn2bXtJw+ht2EfjXQP5iCU3DQKj
	 JdvwhpMdr/nU1eRuur121NHJEKNIkV0tnchH7fcWrFaqC1jBufs1kVn6z+IHQJ0T7M
	 ShyEGfBvb/lWG1hnYtGS/Pk1kBGfETKkS3eFVJT8sR2TRS58chPWZsCOVLWvH7m/HY
	 FEGY149+b/oVg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 02 Sep 2025 21:18:02 +0200
Subject: [PATCH mt76 v3 12/15] wifi: mt76: Add rx_queue_init callback
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-mt7996-rro-rework-v3-12-8f813890959e@kernel.org>
References: <20250902-mt7996-rro-rework-v3-0-8f813890959e@kernel.org>
In-Reply-To: <20250902-mt7996-rro-rework-v3-0-8f813890959e@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Rex Lu <rex.lu@mediatek.com>
X-Mailer: b4 0.14.2

Introduce rx_queue_init DMA callback. This is a preliminary patch to
configure RRO RX queues and decouple RRO logic from WED support.

Co-developed-by: Rex Lu <rex.lu@mediatek.com>
Signed-off-by: Rex Lu <rex.lu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c  | 14 +++++++++++---
 drivers/net/wireless/mediatek/mt76/mt76.h |  4 ++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index b8bb8cdfb69bd6aa8102bff474d8a25a881fb29d..081a3f5d387864ad596fec93542797038eed26f1 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -937,6 +937,15 @@ int mt76_dma_rx_poll(struct napi_struct *napi, int budget)
 }
 EXPORT_SYMBOL_GPL(mt76_dma_rx_poll);
 
+static void
+mt76_dma_rx_queue_init(struct mt76_dev *dev, enum mt76_rxq_id qid,
+		       int (*poll)(struct napi_struct *napi, int budget))
+{
+	netif_napi_add(dev->napi_dev, &dev->napi[qid], poll);
+	mt76_dma_rx_fill_buf(dev, &dev->q_rx[qid], false);
+	napi_enable(&dev->napi[qid]);
+}
+
 static int
 mt76_dma_init(struct mt76_dev *dev,
 	      int (*poll)(struct napi_struct *napi, int budget))
@@ -973,9 +982,7 @@ mt76_dma_init(struct mt76_dev *dev,
 		    mt76_queue_is_wed_rro(&dev->q_rx[i]))
 			continue;
 
-		netif_napi_add(dev->napi_dev, &dev->napi[i], poll);
-		mt76_dma_rx_fill_buf(dev, &dev->q_rx[i], false);
-		napi_enable(&dev->napi[i]);
+		mt76_dma_rx_queue_init(dev, i, poll);
 	}
 
 	return 0;
@@ -988,6 +995,7 @@ static const struct mt76_queue_ops mt76_dma_ops = {
 	.tx_queue_skb_raw = mt76_dma_tx_queue_skb_raw,
 	.tx_queue_skb = mt76_dma_tx_queue_skb,
 	.tx_cleanup = mt76_dma_tx_cleanup,
+	.rx_queue_init = mt76_dma_rx_queue_init,
 	.rx_cleanup = mt76_dma_rx_cleanup,
 	.rx_reset = mt76_dma_rx_reset,
 	.kick = mt76_dma_kick_queue,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 60a3f13ac99125f66f3af406a2a37c25b257a762..8dcf593a0151310648043b5ac7528570c61aea0b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -286,6 +286,9 @@ struct mt76_queue_ops {
 	void (*tx_cleanup)(struct mt76_dev *dev, struct mt76_queue *q,
 			   bool flush);
 
+	void (*rx_queue_init)(struct mt76_dev *dev, enum mt76_rxq_id qid,
+			      int (*poll)(struct napi_struct *napi, int budget));
+
 	void (*rx_cleanup)(struct mt76_dev *dev, struct mt76_queue *q);
 
 	void (*kick)(struct mt76_dev *dev, struct mt76_queue *q);
@@ -1221,6 +1224,7 @@ static inline int mt76_wed_dma_setup(struct mt76_dev *dev, struct mt76_queue *q,
 #define mt76_tx_queue_skb(dev, ...)	(dev)->mt76.queue_ops->tx_queue_skb(&((dev)->mphy), __VA_ARGS__)
 #define mt76_queue_rx_reset(dev, ...)	(dev)->mt76.queue_ops->rx_reset(&((dev)->mt76), __VA_ARGS__)
 #define mt76_queue_tx_cleanup(dev, ...)	(dev)->mt76.queue_ops->tx_cleanup(&((dev)->mt76), __VA_ARGS__)
+#define mt76_queue_rx_init(dev, ...)	(dev)->mt76.queue_ops->rx_queue_init(&((dev)->mt76), __VA_ARGS__)
 #define mt76_queue_rx_cleanup(dev, ...)	(dev)->mt76.queue_ops->rx_cleanup(&((dev)->mt76), __VA_ARGS__)
 #define mt76_queue_kick(dev, ...)	(dev)->mt76.queue_ops->kick(&((dev)->mt76), __VA_ARGS__)
 #define mt76_queue_reset(dev, ...)	(dev)->mt76.queue_ops->reset_q(&((dev)->mt76), __VA_ARGS__)

-- 
2.50.1


