Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1135B3636C0
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 18:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhDRQqc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 12:46:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232095AbhDRQqc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 12:46:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 003C561359;
        Sun, 18 Apr 2021 16:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618764363;
        bh=66hlXLarDesDxkZA7wSHszoVWGrSkqeypnELQBfKPwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j2x3SUjaGWzw//eiGQb+S5Z6GktdDyNgoZXSLq6fpFy8K9RLXsUbRZrDP1bwqETaU
         LRHhWdbXXxmAOd1dLugE5dMMyvBlWtlCLNr2H12q8CQ/Hn1oD3uNcJeeKy5pB5ETNE
         +uZrQ2mbX1GSuHDuYE3ote1up83USqqtnKatdZGHzZyPatVtgdKP1MxS3qkcTHEqa5
         LZzpdox4gk88oN1vPTpmz6+kz//BG7CsSH2cCCe919oiZ62mGm06NrR+4CXZ8m4UtJ
         hwqux8OkUr9gRFnWSC19br1LZpf8Ne8HV2xGuPARSqQegkKN5rbWXmVc+D3fjrO2s9
         WDDnDoFomGljw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 06/19] mt76: dma: add the capability to define a custom rx napi poll routine
Date:   Sun, 18 Apr 2021 18:45:32 +0200
Message-Id: <eb65be7b80c7c868ce2a0060911eba798de9fb79.1618763001.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618763000.git.lorenzo@kernel.org>
References: <cover.1618763000.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add the capability to define a custom rx napi callback for each driver.
This is a preliminary patch to properly support runtime-pm on rx side

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c          | 10 +++++-----
 drivers/net/wireless/mediatek/mt76/dma.h          |  1 +
 drivers/net/wireless/mediatek/mt76/mt76.h         |  5 +++--
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c   |  2 +-
 8 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 6ea58aecca41..72b1cc0ecfda 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -602,8 +602,7 @@ mt76_dma_rx_process(struct mt76_dev *dev, struct mt76_queue *q, int budget)
 	return done;
 }
 
-static int
-mt76_dma_rx_poll(struct napi_struct *napi, int budget)
+int mt76_dma_rx_poll(struct napi_struct *napi, int budget)
 {
 	struct mt76_dev *dev;
 	int qid, done = 0, cur;
@@ -626,9 +625,11 @@ mt76_dma_rx_poll(struct napi_struct *napi, int budget)
 
 	return done;
 }
+EXPORT_SYMBOL_GPL(mt76_dma_rx_poll);
 
 static int
-mt76_dma_init(struct mt76_dev *dev)
+mt76_dma_init(struct mt76_dev *dev,
+	      int (*poll)(struct napi_struct *napi, int budget))
 {
 	int i;
 
@@ -639,8 +640,7 @@ mt76_dma_init(struct mt76_dev *dev)
 	dev->napi_dev.threaded = 1;
 
 	mt76_for_each_q_rx(dev, i) {
-		netif_napi_add(&dev->napi_dev, &dev->napi[i], mt76_dma_rx_poll,
-			       64);
+		netif_napi_add(&dev->napi_dev, &dev->napi[i], poll, 64);
 		mt76_dma_rx_fill(dev, &dev->q_rx[i]);
 		napi_enable(&dev->napi[i]);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/dma.h b/drivers/net/wireless/mediatek/mt76/dma.h
index e7c27697ef04..fdf786f975ea 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.h
+++ b/drivers/net/wireless/mediatek/mt76/dma.h
@@ -45,6 +45,7 @@ enum mt76_mcu_evt_type {
 	EVT_EVENT_DFS_DETECT_RSP,
 };
 
+int mt76_dma_rx_poll(struct napi_struct *napi, int budget);
 void mt76_dma_attach(struct mt76_dev *dev);
 void mt76_dma_cleanup(struct mt76_dev *dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 0660b708156d..49f3e5985422 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -170,7 +170,8 @@ struct mt76_mcu_ops {
 };
 
 struct mt76_queue_ops {
-	int (*init)(struct mt76_dev *dev);
+	int (*init)(struct mt76_dev *dev,
+		    int (*poll)(struct napi_struct *napi, int budget));
 
 	int (*alloc)(struct mt76_dev *dev, struct mt76_queue *q,
 		     int idx, int n_desc, int bufsize,
@@ -802,7 +803,7 @@ static inline u16 mt76_rev(struct mt76_dev *dev)
 #define mt76xx_chip(dev) mt76_chip(&((dev)->mt76))
 #define mt76xx_rev(dev) mt76_rev(&((dev)->mt76))
 
-#define mt76_init_queues(dev)		(dev)->mt76.queue_ops->init(&((dev)->mt76))
+#define mt76_init_queues(dev, ...)		(dev)->mt76.queue_ops->init(&((dev)->mt76), __VA_ARGS__)
 #define mt76_queue_alloc(dev, ...)	(dev)->mt76.queue_ops->alloc(&((dev)->mt76), __VA_ARGS__)
 #define mt76_tx_queue_skb_raw(dev, ...)	(dev)->mt76.queue_ops->tx_queue_skb_raw(&((dev)->mt76), __VA_ARGS__)
 #define mt76_tx_queue_skb(dev, ...)	(dev)->mt76.queue_ops->tx_queue_skb(&((dev)->mt76), __VA_ARGS__)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index 2b6244116842..415ea17b9be6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -219,7 +219,7 @@ int mt7603_dma_init(struct mt7603_dev *dev)
 		return ret;
 
 	mt76_wr(dev, MT_DELAY_INT_CFG, 0);
-	ret = mt76_init_queues(dev);
+	ret = mt76_init_queues(dev, mt76_dma_rx_poll);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index 642b4eab0d8b..d658555f5965 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -261,7 +261,7 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 
 	mt76_wr(dev, MT_DELAY_INT_CFG, 0);
 
-	ret = mt76_init_queues(dev);
+	ret = mt76_init_queues(dev, mt76_dma_rx_poll);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index ce1e9ad23fec..b50084bbe83d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -226,7 +226,7 @@ int mt76x02_dma_init(struct mt76x02_dev *dev)
 	if (ret)
 		return ret;
 
-	ret = mt76_init_queues(dev);
+	ret = mt76_init_queues(dev, mt76_dma_rx_poll);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 9fe09870f8f0..11d0b760abd7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -213,7 +213,7 @@ int mt7915_dma_init(struct mt7915_dev *dev)
 			return ret;
 	}
 
-	ret = mt76_init_queues(dev);
+	ret = mt76_init_queues(dev, mt76_dma_rx_poll);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index 992faf82ad09..b056ac15f09a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -295,7 +295,7 @@ int mt7921_dma_init(struct mt7921_dev *dev)
 	if (ret)
 		return ret;
 
-	ret = mt76_init_queues(dev);
+	ret = mt76_init_queues(dev, mt76_dma_rx_poll);
 	if (ret < 0)
 		return ret;
 
-- 
2.30.2

