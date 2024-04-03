Return-Path: <linux-wireless+bounces-5805-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D859896D62
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 12:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 812331C20DC5
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 10:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD15C1420BE;
	Wed,  3 Apr 2024 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="DJki8wbR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330711411FC
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 10:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141736; cv=none; b=YsSEYf/+hh8MZiSdHi6Hxi8E5hikC8QIPbJ76Z6m/nij23U0kCvZGgzz8K97B0cPRGNTyLe0NCUtL3yN8MOz1rW/pr/DQgNemmM/+EsdSgsygELXBOsMuMYtppYx3KvqM/3Bbh+OmJZXy1qPLUjgb5uMv0OUDXqEi5HLTpGqA08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141736; c=relaxed/simple;
	bh=UsSrFL6xLvqFv6az03RMgE5au1Ml15TmGotmSMP/s5k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhysRY7CZgqW5gNTHtAPypIq5d9ibwEnX2MfqovwuOINeMGlsEmFlFzPy1UaIW+kz6ehmt3bolaP95pgYt0+fE5LnGd3ZFFfmeMBgf9u5mQ4aQrrgDo0TDymHumA5ux3JWoU/uq5E1VpiE6oLXxkMSZcvVJzW/E5AAkz59bhqUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=DJki8wbR; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=txF3djAhmMR/5dOvonR1NYxkClFgRJsb4tNXvSC+eeA=; b=DJki8wbRvVwm+GCGH1GVc1nNY4
	IsFGsEzLzZpOjxW8w192N/+PSqNiA+oDKVqQUPEQyWJ4aS4TiISEfkfwMOG5qYfflDaq1cH9BtlSj
	XnNJVJ1FlxiIqU0bvmnOc2oQdCikGAkCByqX3Gh/SErLzvxKdecCMoMXaROfV0nTJ9Zs=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rrxt3-00CgfA-5k
	for linux-wireless@vger.kernel.org; Wed, 03 Apr 2024 12:30:33 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 03/13] wifi: mt76: fix tx packet loss when scanning on DBDC
Date: Wed,  3 Apr 2024 12:30:22 +0200
Message-ID: <20240403103032.54823-3-nbd@nbd.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403103032.54823-1-nbd@nbd.name>
References: <20240403103032.54823-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When queueing packets, only the MT76_RESET flag of the primary PHY
is checked. If the primary PHY is scanning or changing channels, this can
lead to packet loss for tx on the second PHY.
Fix this by passing the phy to the .tx_queue_skb op and using it to check
the correct flag.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c      | 5 +++--
 drivers/net/wireless/mediatek/mt76/mt76.h     | 4 ++--
 drivers/net/wireless/mediatek/mt76/sdio.c     | 3 ++-
 drivers/net/wireless/mediatek/mt76/testmode.c | 2 +-
 drivers/net/wireless/mediatek/mt76/tx.c       | 2 +-
 drivers/net/wireless/mediatek/mt76/usb.c      | 3 ++-
 6 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 72a7bd5a8576..f4f88c444e21 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -532,7 +532,7 @@ mt76_dma_tx_queue_skb_raw(struct mt76_dev *dev, struct mt76_queue *q,
 }
 
 static int
-mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
+mt76_dma_tx_queue_skb(struct mt76_phy *phy, struct mt76_queue *q,
 		      enum mt76_txq_id qid, struct sk_buff *skb,
 		      struct mt76_wcid *wcid, struct ieee80211_sta *sta)
 {
@@ -542,6 +542,7 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 	struct mt76_tx_info tx_info = {
 		.skb = skb,
 	};
+	struct mt76_dev *dev = phy->dev;
 	struct ieee80211_hw *hw;
 	int len, n = 0, ret = -ENOMEM;
 	struct mt76_txwi_cache *t;
@@ -549,7 +550,7 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 	dma_addr_t addr;
 	u8 *txwi;
 
-	if (test_bit(MT76_RESET, &dev->phy.state))
+	if (test_bit(MT76_RESET, &phy->state))
 		goto free_skb;
 
 	t = mt76_get_txwi(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index a91f6ddacbd9..11b9f22ca7f3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -256,7 +256,7 @@ struct mt76_queue_ops {
 		     int idx, int n_desc, int bufsize,
 		     u32 ring_base);
 
-	int (*tx_queue_skb)(struct mt76_dev *dev, struct mt76_queue *q,
+	int (*tx_queue_skb)(struct mt76_phy *phy, struct mt76_queue *q,
 			    enum mt76_txq_id qid, struct sk_buff *skb,
 			    struct mt76_wcid *wcid, struct ieee80211_sta *sta);
 
@@ -1127,7 +1127,7 @@ static inline int mt76_wed_dma_setup(struct mt76_dev *dev, struct mt76_queue *q,
 #define mt76_init_queues(dev, ...)		(dev)->mt76.queue_ops->init(&((dev)->mt76), __VA_ARGS__)
 #define mt76_queue_alloc(dev, ...)	(dev)->mt76.queue_ops->alloc(&((dev)->mt76), __VA_ARGS__)
 #define mt76_tx_queue_skb_raw(dev, ...)	(dev)->mt76.queue_ops->tx_queue_skb_raw(&((dev)->mt76), __VA_ARGS__)
-#define mt76_tx_queue_skb(dev, ...)	(dev)->mt76.queue_ops->tx_queue_skb(&((dev)->mt76), __VA_ARGS__)
+#define mt76_tx_queue_skb(dev, ...)	(dev)->mt76.queue_ops->tx_queue_skb(&((dev)->mphy), __VA_ARGS__)
 #define mt76_queue_rx_reset(dev, ...)	(dev)->mt76.queue_ops->rx_reset(&((dev)->mt76), __VA_ARGS__)
 #define mt76_queue_tx_cleanup(dev, ...)	(dev)->mt76.queue_ops->tx_cleanup(&((dev)->mt76), __VA_ARGS__)
 #define mt76_queue_rx_cleanup(dev, ...)	(dev)->mt76.queue_ops->rx_cleanup(&((dev)->mt76), __VA_ARGS__)
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 3e88798df017..593246b55518 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -514,13 +514,14 @@ static void mt76s_tx_status_data(struct mt76_worker *worker)
 }
 
 static int
-mt76s_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
+mt76s_tx_queue_skb(struct mt76_phy *phy, struct mt76_queue *q,
 		   enum mt76_txq_id qid, struct sk_buff *skb,
 		   struct mt76_wcid *wcid, struct ieee80211_sta *sta)
 {
 	struct mt76_tx_info tx_info = {
 		.skb = skb,
 	};
+	struct mt76_dev *dev = phy->dev;
 	int err, len = skb->len;
 	u16 idx = q->head;
 
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/wireless/mediatek/mt76/testmode.c
index 4644dace9bb3..ca4feccf38ca 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/testmode.c
@@ -53,7 +53,7 @@ void mt76_testmode_tx_pending(struct mt76_phy *phy)
 	       q->queued < q->ndesc / 2) {
 		int ret;
 
-		ret = dev->queue_ops->tx_queue_skb(dev, q, qid, skb_get(skb),
+		ret = dev->queue_ops->tx_queue_skb(phy, q, qid, skb_get(skb),
 						   wcid, NULL);
 		if (ret < 0)
 			break;
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 1809b03292c3..5cf6edee4d13 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -308,7 +308,7 @@ __mt76_tx_queue_skb(struct mt76_phy *phy, int qid, struct sk_buff *skb,
 	int idx;
 
 	non_aql = !info->tx_time_est;
-	idx = dev->queue_ops->tx_queue_skb(dev, q, qid, skb, wcid, sta);
+	idx = dev->queue_ops->tx_queue_skb(phy, q, qid, skb, wcid, sta);
 	if (idx < 0 || !sta)
 		return idx;
 
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 342c3aea549d..58ff06823389 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -850,13 +850,14 @@ mt76u_tx_setup_buffers(struct mt76_dev *dev, struct sk_buff *skb,
 }
 
 static int
-mt76u_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
+mt76u_tx_queue_skb(struct mt76_phy *phy, struct mt76_queue *q,
 		   enum mt76_txq_id qid, struct sk_buff *skb,
 		   struct mt76_wcid *wcid, struct ieee80211_sta *sta)
 {
 	struct mt76_tx_info tx_info = {
 		.skb = skb,
 	};
+	struct mt76_dev *dev = phy->dev;
 	u16 idx = q->head;
 	int err;
 
-- 
2.43.0


