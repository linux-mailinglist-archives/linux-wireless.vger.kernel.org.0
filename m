Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BED8A837EB
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2019 19:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733290AbfHFRb6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Aug 2019 13:31:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729161AbfHFRb6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Aug 2019 13:31:58 -0400
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10C612075B;
        Tue,  6 Aug 2019 17:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565112717;
        bh=RFl7BwbGSelHZuQOwMHkogVA4T5PxeiR4dsG1OCaaKk=;
        h=From:To:Cc:Subject:Date:From;
        b=kQfy9pMT8zO5CANKZ6g0fAcdmpN8IigVs2OAhDE+nPZOfY9moJCtbK9+Q4f2Ghds+
         7hn5yW+mBQmV1LUfcw9cKdQnRzyy498P/3LbgnOOiaSrHxNGx0nFyiGvvHJ9KgNXFw
         MUDjFyA6OlfWNE0O4xk9gdO+NFvpOnvh2bM0VXxc=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH] mt76: move mt76_tx_tasklet in mt76 module
Date:   Tue,  6 Aug 2019 19:31:42 +0200
Message-Id: <527fdc4e453cbc1408500625c0080d9c59d9e1dd.1565112514.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt76{15,03}_tx_tasklet in mt76 module since it is shared between
mt7615 and mt7603 drivers

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h       |  1 +
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c | 11 ++---------
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c |  9 +--------
 drivers/net/wireless/mediatek/mt76/tx.c         |  8 ++++++++
 4 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index c755b5ad5e2a..dd9fbb1f79a9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -722,6 +722,7 @@ void mt76_stop_tx_queues(struct mt76_dev *dev, struct ieee80211_sta *sta,
 			 bool send_bar);
 void mt76_txq_schedule(struct mt76_dev *dev, enum mt76_txq_id qid);
 void mt76_txq_schedule_all(struct mt76_dev *dev);
+void mt76_tx_tasklet(unsigned long data);
 void mt76_release_buffered_frames(struct ieee80211_hw *hw,
 				  struct ieee80211_sta *sta,
 				  u16 tids, int nframes,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index 58dc511f93c5..d13cf1ca1671 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -135,14 +135,6 @@ mt7603_init_rx_queue(struct mt7603_dev *dev, struct mt76_queue *q,
 	return 0;
 }
 
-static void
-mt7603_tx_tasklet(unsigned long data)
-{
-	struct mt7603_dev *dev = (struct mt7603_dev *)data;
-
-	mt76_txq_schedule_all(&dev->mt76);
-}
-
 static int mt7603_poll_tx(struct napi_struct *napi, int budget)
 {
 	struct mt7603_dev *dev;
@@ -181,7 +173,8 @@ int mt7603_dma_init(struct mt7603_dev *dev)
 	init_waitqueue_head(&dev->mt76.mmio.mcu.wait);
 	skb_queue_head_init(&dev->mt76.mmio.mcu.res_q);
 
-	tasklet_init(&dev->mt76.tx_tasklet, mt7603_tx_tasklet, (unsigned long)dev);
+	tasklet_init(&dev->mt76.tx_tasklet, mt76_tx_tasklet,
+		     (unsigned long)dev);
 
 	mt76_clear(dev, MT_WPDMA_GLO_CFG,
 		   MT_WPDMA_GLO_CFG_TX_DMA_EN |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index 3fe24d92d4fa..2321128b2a69 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -90,13 +90,6 @@ void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 	}
 }
 
-static void mt7615_tx_tasklet(unsigned long data)
-{
-	struct mt7615_dev *dev = (struct mt7615_dev *)data;
-
-	mt76_txq_schedule_all(&dev->mt76);
-}
-
 static int mt7615_poll_tx(struct napi_struct *napi, int budget)
 {
 	static const u8 queue_map[] = {
@@ -128,7 +121,7 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 
 	mt76_dma_attach(&dev->mt76);
 
-	tasklet_init(&dev->mt76.tx_tasklet, mt7615_tx_tasklet,
+	tasklet_init(&dev->mt76.tx_tasklet, mt76_tx_tasklet,
 		     (unsigned long)dev);
 
 	mt76_wr(dev, MT_WPDMA_GLO_CFG,
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 5397827668b9..05ec1f4665e3 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -568,6 +568,14 @@ void mt76_txq_schedule_all(struct mt76_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt76_txq_schedule_all);
 
+void mt76_tx_tasklet(unsigned long data)
+{
+	struct mt76_dev *dev = (struct mt76_dev *)data;
+
+	mt76_txq_schedule_all(dev);
+}
+EXPORT_SYMBOL_GPL(mt76_tx_tasklet);
+
 void mt76_stop_tx_queues(struct mt76_dev *dev, struct ieee80211_sta *sta,
 			 bool send_bar)
 {
-- 
2.21.0

