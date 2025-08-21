Return-Path: <linux-wireless+bounces-26522-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE032B2FA35
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 15:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C08B1CE8087
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 13:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E99B32A3D5;
	Thu, 21 Aug 2025 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asMK0ikP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE861326D7B
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 13:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782231; cv=none; b=S5+9fSgJKYo3DVhppApsKR0FXRBnq25sOz3cKv/AGT8J7OJg38c9kk+pA3vn+xSt/g32ny2iV6XyM+6lAN5f2/MHpnxezyF4O4aCkWkCfFBKNyaXHFmosb6Lk5MILQ4lCR4/XDwu2eGlFe5M8WTvKjLnatXJ1yyux6CR72nA/6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782231; c=relaxed/simple;
	bh=uHSdiZsBxriCZx9IRWlq3PzyMkjzqCtAyPCjrsM8WIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qbqHj7D/+yDeVM//L0ZUKifG1ucKFkpkVyBZvEysiLc/Yxf/YPXcIx6DmsyzNm+MDEhVTDw+pBQ5i+rGj19k6cRKyz/fQsmExp+fuCPZ8l63v5KuS6Fwgav0pQXL+ubsA7pgF5d64E7DgWsg3DvR0lerDOdBIT6j83FV6oSoz4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asMK0ikP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E51DC113CF;
	Thu, 21 Aug 2025 13:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755782230;
	bh=uHSdiZsBxriCZx9IRWlq3PzyMkjzqCtAyPCjrsM8WIQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=asMK0ikPSFzA+tF6rrit/FnJEJQfRRshDNsc5y2INhWokyb4efsCDG4DRIVSoanp2
	 FMZ7eqU0U156AVJdoi2pAxABAtAnxRyRslx9Mlo6mHUSFUHDtRfxWPwdytcLgsghMj
	 xHWiuZ6jQ2deNKoiy7/fPjMW0xBbx4O0oQPzsNP//+GtNI5wxygwgGjx+cDh6eZ56j
	 wfeHdic81+1NyrSfmQGBbt3FdkfhScoK3G+Xix+ZxZFZN17ZHBmWtaGBBNbi3Rwb8V
	 vtBq83WO0DJPXu+creOmUfOcziBdIiWQIBgmrOvaeSurJ6QBZUnJi1lx9YUEfSPWCL
	 Pt8Kqv9t2AYQA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 21 Aug 2025 15:15:03 +0200
Subject: [PATCH mt76 11/14] wifi: mt76: Add rx_queue_init callback
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-mt7996-rro-rework-v1-11-6c8477ad969f@kernel.org>
References: <20250821-mt7996-rro-rework-v1-0-6c8477ad969f@kernel.org>
In-Reply-To: <20250821-mt7996-rro-rework-v1-0-6c8477ad969f@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Rex Lu <rex.lu@mediatek.com>
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
index 2db56d4be36a23e1689adf78dc887f9f5304e73c..78e05e6bd481a0cda1189af20f58e84bcbd25ff4 100644
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


