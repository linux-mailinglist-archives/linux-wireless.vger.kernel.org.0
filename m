Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D534A2AF27B
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 14:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgKKNsM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Nov 2020 08:48:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:36116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbgKKNsA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 08:48:00 -0500
Received: from lore-desk.redhat.com (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F1842074B;
        Wed, 11 Nov 2020 13:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605102478;
        bh=fwTrUy2td3SWGt0UJPa1+CG7Q5iMSyZqtFuJOF91LU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ShquKIPhJwMR7Xf2lKxcwxMk/O8zayco2SVlXJ+n1SyMXsMZ2gFvjs3bemWcdmsN8
         HIpMe21gF/ONIi+5pKjfTxkKRrXa8OlXfb11kEUY8WdKUjxZuHLvdKePqzWS0R541m
         L7R45tbYhLHb4cutSkIID+V+sle9HfGa0cM/6Y60=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH v2 08/10] mt76: rely on mt76_queue in tx_queue_skb_raw signature
Date:   Wed, 11 Nov 2020 14:47:30 +0100
Message-Id: <65391364e64988c099ff5832eafecfbb088a81d4.1605102251.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605102251.git.lorenzo@kernel.org>
References: <cover.1605102251.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to move data queues in mt76_phy and properly
support dbdc

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c             | 3 +--
 drivers/net/wireless/mediatek/mt76/mt76.h            | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c     | 8 +++++---
 drivers/net/wireless/mediatek/mt76/mt7603/mcu.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c  | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/sdio.c            | 3 +--
 10 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 730f01935cfe..6aa6bac36331 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -313,10 +313,9 @@ mt76_dma_dequeue(struct mt76_dev *dev, struct mt76_queue *q, bool flush,
 }
 
 static int
-mt76_dma_tx_queue_skb_raw(struct mt76_dev *dev, enum mt76_txq_id qid,
+mt76_dma_tx_queue_skb_raw(struct mt76_dev *dev, struct mt76_queue *q,
 			  struct sk_buff *skb, u32 tx_info)
 {
-	struct mt76_queue *q = dev->q_tx[qid];
 	struct mt76_queue_buf buf;
 	dma_addr_t addr;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 3e6b8a647450..053c8ea6d38f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -175,7 +175,7 @@ struct mt76_queue_ops {
 			    struct sk_buff *skb, struct mt76_wcid *wcid,
 			    struct ieee80211_sta *sta);
 
-	int (*tx_queue_skb_raw)(struct mt76_dev *dev, enum mt76_txq_id qid,
+	int (*tx_queue_skb_raw)(struct mt76_dev *dev, struct mt76_queue *q,
 				struct sk_buff *skb, u32 tx_info);
 
 	void *(*dequeue)(struct mt76_dev *dev, struct mt76_queue *q, bool flush,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index c9226dceb510..64b259123001 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -380,9 +380,11 @@ mt7603_ps_tx_list(struct mt7603_dev *dev, struct sk_buff_head *list)
 {
 	struct sk_buff *skb;
 
-	while ((skb = __skb_dequeue(list)) != NULL)
-		mt76_tx_queue_skb_raw(dev, skb_get_queue_mapping(skb),
-				      skb, 0);
+	while ((skb = __skb_dequeue(list)) != NULL) {
+		int qid = skb_get_queue_mapping(skb);
+
+		mt76_tx_queue_skb_raw(dev, dev->mt76.q_tx[qid], skb, 0);
+	}
 }
 
 void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
index 9e6c8e1b7ea5..d275aa6e003c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
@@ -73,7 +73,7 @@ mt7603_mcu_skb_send_msg(struct mt76_dev *mdev, struct sk_buff *skb,
 	if (wait_seq)
 		*wait_seq = seq;
 
-	return mt76_tx_queue_skb_raw(dev, MT_TXQ_MCU, skb, 0);
+	return mt76_tx_queue_skb_raw(dev, mdev->q_tx[MT_TXQ_MCU], skb, 0);
 }
 
 static int
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index a35ff054b5f1..ffe36e5ee98d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -187,7 +187,7 @@ mt7615_reset_test_set(void *data, u64 val)
 	skb_put(skb, 1);
 
 	mt7615_mutex_acquire(dev);
-	mt76_tx_queue_skb_raw(dev, 0, skb, 0);
+	mt76_tx_queue_skb_raw(dev, dev->mt76.q_tx[0], skb, 0);
 	mt7615_mutex_release(dev);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 8525236d7d35..4733b3804881 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -239,7 +239,7 @@ mt7615_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	else
 		qid = MT_TXQ_FWDL;
 
-	return mt76_tx_queue_skb_raw(dev, qid, skb, 0);
+	return mt76_tx_queue_skb_raw(dev, dev->mt76.q_tx[qid], skb, 0);
 }
 
 u32 mt7615_rf_rr(struct mt7615_dev *dev, u32 wf, u32 reg)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
index e4995c64089d..a6f28b80feba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
@@ -42,7 +42,7 @@ mt7663s_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	int ret;
 
 	mt7615_mcu_fill_msg(dev, skb, cmd, seq);
-	ret = mt76_tx_queue_skb_raw(dev, MT_TXQ_MCU, skb, 0);
+	ret = mt76_tx_queue_skb_raw(dev, mdev->q_tx[MT_TXQ_MCU], skb, 0);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
index 3b2184254ae9..3846e5be62c0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
@@ -61,7 +61,7 @@ int mt76x02_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 		  FIELD_PREP(MT_MCU_MSG_PORT, CPU_TX_PORT) |
 		  FIELD_PREP(MT_MCU_MSG_LEN, skb->len);
 
-	ret = mt76_tx_queue_skb_raw(dev, MT_TXQ_MCU, skb, tx_info);
+	ret = mt76_tx_queue_skb_raw(dev, mdev->q_tx[MT_TXQ_MCU], skb, tx_info);
 	if (ret)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index b135ad972e88..6b41ecdc4b4a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -326,7 +326,7 @@ mt7915_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	if (wait_seq)
 		*wait_seq = seq;
 
-	return mt76_tx_queue_skb_raw(dev, txq, skb, 0);
+	return mt76_tx_queue_skb_raw(dev, mdev->q_tx[txq], skb, 0);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index b1bc459a721d..fce133736273 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -266,10 +266,9 @@ mt76s_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 }
 
 static int
-mt76s_tx_queue_skb_raw(struct mt76_dev *dev, enum mt76_txq_id qid,
+mt76s_tx_queue_skb_raw(struct mt76_dev *dev, struct mt76_queue *q,
 		       struct sk_buff *skb, u32 tx_info)
 {
-	struct mt76_queue *q = dev->q_tx[qid];
 	int ret = -ENOSPC, len = skb->len, pad;
 
 	if (q->queued == q->ndesc)
-- 
2.26.2

