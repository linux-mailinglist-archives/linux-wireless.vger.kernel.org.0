Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106CB279A4A
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Sep 2020 17:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbgIZPHA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Sep 2020 11:07:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729510AbgIZPHA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Sep 2020 11:07:00 -0400
Received: from localhost.localdomain (unknown [151.66.98.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEB36208FE;
        Sat, 26 Sep 2020 15:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601132819;
        bh=nOaU9Jt2Nkt7nJVpfxaBPPzWZ1Cb1X8w2n5EUtnofcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XnPQQwuCoY8EXmTbrjhUWWYm+BbFBMVD1JBAiIskeyF99k5lpazklqXHRVJzsaqUP
         wwj4TQNxZaSls+y2eiYx9n5AXZiM7+NHAlibGEzU9w9Nq2elJNU0d5AlRJlR58ev8H
         ym6O5mVTpMn2fEx4YqyJoyhzjV6UAJGIbEBvsr8I=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 1/4] mt76: mt7663s: move tx/rx processing in the same txrx workqueue
Date:   Sat, 26 Sep 2020 17:06:22 +0200
Message-Id: <a7d114f5f5d90a5669c56e7ac6011b345afa9938.1601132347.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601132347.git.lorenzo@kernel.org>
References: <cover.1601132347.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt7663 tx and rx processing in the same workqueue in order to
reduce jitter that can hit tcp performances. This is a preliminary patch
to switch to mt76 workers APIs

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  11 +-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   2 +-
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  |   3 +-
 .../wireless/mediatek/mt76/mt7615/sdio_txrx.c | 106 +++++++++---------
 drivers/net/wireless/mediatek/mt76/sdio.c     |  17 ++-
 5 files changed, 66 insertions(+), 73 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index a5be66de1cff..243cb89c0a92 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -446,15 +446,10 @@ struct mt76_usb {
 #define MT76S_XMIT_BUF_SZ	(16 * PAGE_SIZE)
 struct mt76_sdio {
 	struct workqueue_struct *txrx_wq;
-	struct {
-		struct work_struct xmit_work;
-		struct work_struct status_work;
-	} tx;
-	struct {
-		struct work_struct recv_work;
-		struct work_struct net_work;
-	} rx;
 
+	struct work_struct txrx_work;
+	struct work_struct status_work;
+	struct work_struct net_work;
 	struct work_struct stat_work;
 
 	u8 *xmit_buf[MT_TXQ_MCU_WA];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 6a9f9187f76a..11b4caa5cb69 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -681,7 +681,7 @@ int mt7663u_mcu_init(struct mt7615_dev *dev);
 /* sdio */
 u32 mt7663s_read_pcr(struct mt7615_dev *dev);
 int mt7663s_mcu_init(struct mt7615_dev *dev);
-void mt7663s_tx_work(struct work_struct *work);
+void mt7663s_txrx_work(struct work_struct *work);
 void mt7663s_rx_work(struct work_struct *work);
 void mt7663s_sdio_irq(struct sdio_func *func);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
index 874c929d8552..ad7e422ea52e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -368,8 +368,7 @@ static int mt7663s_probe(struct sdio_func *func,
 	if (ret < 0)
 		goto err_free;
 
-	INIT_WORK(&mdev->sdio.tx.xmit_work, mt7663s_tx_work);
-	INIT_WORK(&mdev->sdio.rx.recv_work, mt7663s_rx_work);
+	INIT_WORK(&mdev->sdio.txrx_work, mt7663s_txrx_work);
 
 	ret = mt7663s_hw_init(dev, func);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
index 2486cda3243b..1194df0405ed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
@@ -138,6 +138,50 @@ static int mt7663s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
 	return i;
 }
 
+static int mt7663s_rx_handler(struct mt76_dev *dev)
+{
+	struct mt76_sdio *sdio = &dev->sdio;
+	struct mt76s_intr *intr = sdio->intr_data;
+	int nframes = 0, ret;
+
+	/* disable interrupt */
+	sdio_claim_host(sdio->func);
+	sdio_writel(sdio->func, WHLPCR_INT_EN_CLR, MCR_WHLPCR, NULL);
+	ret = sdio_readsb(sdio->func, intr, MCR_WHISR, sizeof(*intr));
+	sdio_release_host(sdio->func);
+
+	if (ret < 0)
+		goto out;
+
+	trace_dev_irq(dev, intr->isr, 0);
+
+	if (intr->isr & WHIER_RX0_DONE_INT_EN) {
+		ret = mt7663s_rx_run_queue(dev, 0, intr);
+		if (ret > 0) {
+			queue_work(sdio->txrx_wq, &sdio->net_work);
+			nframes += ret;
+		}
+	}
+
+	if (intr->isr & WHIER_RX1_DONE_INT_EN) {
+		ret = mt7663s_rx_run_queue(dev, 1, intr);
+		if (ret > 0) {
+			queue_work(sdio->txrx_wq, &sdio->net_work);
+			nframes += ret;
+		}
+	}
+
+	nframes += !!mt7663s_refill_sched_quota(dev, intr->tx.wtqcr);
+
+out:
+	/* enable interrupt */
+	sdio_claim_host(sdio->func);
+	sdio_writel(sdio->func, WHLPCR_INT_EN_SET, MCR_WHLPCR, NULL);
+	sdio_release_host(sdio->func);
+
+	return nframes;
+}
+
 static int mt7663s_tx_pick_quota(struct mt76_sdio *sdio, enum mt76_txq_id qid,
 				 int buf_sz, int *pse_size, int *ple_size)
 {
@@ -245,13 +289,14 @@ static int mt7663s_tx_run_queue(struct mt76_dev *dev, enum mt76_txq_id qid)
 	return nframes;
 }
 
-void mt7663s_tx_work(struct work_struct *work)
+void mt7663s_txrx_work(struct work_struct *work)
 {
 	struct mt76_sdio *sdio = container_of(work, struct mt76_sdio,
-					      tx.xmit_work);
+					      txrx_work);
 	struct mt76_dev *dev = container_of(sdio, struct mt76_dev, sdio);
 	int i, nframes = 0;
 
+	/* tx */
 	for (i = 0; i < MT_TXQ_MCU_WA; i++) {
 		int ret;
 
@@ -261,59 +306,14 @@ void mt7663s_tx_work(struct work_struct *work)
 
 		nframes += ret;
 	}
-	if (nframes)
-		queue_work(sdio->txrx_wq, &sdio->tx.xmit_work);
-
-	queue_work(sdio->txrx_wq, &sdio->tx.status_work);
-}
-
-void mt7663s_rx_work(struct work_struct *work)
-{
-	struct mt76_sdio *sdio = container_of(work, struct mt76_sdio,
-					      rx.recv_work);
-	struct mt76_dev *dev = container_of(sdio, struct mt76_dev, sdio);
-	struct mt76s_intr *intr = sdio->intr_data;
-	int nframes = 0, ret;
-
-	/* disable interrupt */
-	sdio_claim_host(sdio->func);
-	sdio_writel(sdio->func, WHLPCR_INT_EN_CLR, MCR_WHLPCR, NULL);
-	ret = sdio_readsb(sdio->func, intr, MCR_WHISR, sizeof(*intr));
-	sdio_release_host(sdio->func);
-
-	if (ret < 0)
-		goto out;
-
-	trace_dev_irq(dev, intr->isr, 0);
-
-	if (intr->isr & WHIER_RX0_DONE_INT_EN) {
-		ret = mt7663s_rx_run_queue(dev, 0, intr);
-		if (ret > 0) {
-			queue_work(sdio->txrx_wq, &sdio->rx.net_work);
-			nframes += ret;
-		}
-	}
 
-	if (intr->isr & WHIER_RX1_DONE_INT_EN) {
-		ret = mt7663s_rx_run_queue(dev, 1, intr);
-		if (ret > 0) {
-			queue_work(sdio->txrx_wq, &sdio->rx.net_work);
-			nframes += ret;
-		}
-	}
+	/* rx */
+	nframes += mt7663s_rx_handler(dev);
 
-	if (mt7663s_refill_sched_quota(dev, intr->tx.wtqcr))
-		queue_work(sdio->txrx_wq, &sdio->tx.xmit_work);
+	if (nframes)
+		queue_work(sdio->txrx_wq, &sdio->txrx_work);
 
-	if (nframes) {
-		queue_work(sdio->txrx_wq, &sdio->rx.recv_work);
-		return;
-	}
-out:
-	/* enable interrupt */
-	sdio_claim_host(sdio->func);
-	sdio_writel(sdio->func, WHLPCR_INT_EN_SET, MCR_WHLPCR, NULL);
-	sdio_release_host(sdio->func);
+	queue_work(sdio->txrx_wq, &sdio->status_work);
 }
 
 void mt7663s_sdio_irq(struct sdio_func *func)
@@ -324,5 +324,5 @@ void mt7663s_sdio_irq(struct sdio_func *func)
 	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mt76.phy.state))
 		return;
 
-	queue_work(sdio->txrx_wq, &sdio->rx.recv_work);
+	queue_work(sdio->txrx_wq, &sdio->txrx_work);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 9a4d95a2a707..6eb75ffa9e0f 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -66,10 +66,9 @@ void mt76s_stop_txrx(struct mt76_dev *dev)
 {
 	struct mt76_sdio *sdio = &dev->sdio;
 
-	cancel_work_sync(&sdio->tx.xmit_work);
-	cancel_work_sync(&sdio->tx.status_work);
-	cancel_work_sync(&sdio->rx.recv_work);
-	cancel_work_sync(&sdio->rx.net_work);
+	cancel_work_sync(&sdio->txrx_work);
+	cancel_work_sync(&sdio->status_work);
+	cancel_work_sync(&sdio->net_work);
 	cancel_work_sync(&sdio->stat_work);
 	clear_bit(MT76_READING_STATS, &dev->phy.state);
 
@@ -257,7 +256,7 @@ static void mt76s_tx_kick(struct mt76_dev *dev, struct mt76_queue *q)
 {
 	struct mt76_sdio *sdio = &dev->sdio;
 
-	queue_work(sdio->txrx_wq, &sdio->tx.xmit_work);
+	queue_work(sdio->txrx_wq, &sdio->txrx_work);
 }
 
 static const struct mt76_queue_ops sdio_queue_ops = {
@@ -269,7 +268,7 @@ static const struct mt76_queue_ops sdio_queue_ops = {
 static void mt76s_tx_work(struct work_struct *work)
 {
 	struct mt76_sdio *sdio = container_of(work, struct mt76_sdio,
-					      tx.status_work);
+					      status_work);
 	struct mt76_dev *dev = container_of(sdio, struct mt76_dev, sdio);
 	int i;
 
@@ -284,7 +283,7 @@ static void mt76s_tx_work(struct work_struct *work)
 static void mt76s_rx_work(struct work_struct *work)
 {
 	struct mt76_sdio *sdio = container_of(work, struct mt76_sdio,
-					      rx.net_work);
+					      net_work);
 	struct mt76_dev *dev = container_of(sdio, struct mt76_dev, sdio);
 	int i;
 
@@ -343,8 +342,8 @@ int mt76s_init(struct mt76_dev *dev, struct sdio_func *func,
 		return -ENOMEM;
 
 	INIT_WORK(&sdio->stat_work, mt76s_tx_status_data);
-	INIT_WORK(&sdio->tx.status_work, mt76s_tx_work);
-	INIT_WORK(&sdio->rx.net_work, mt76s_rx_work);
+	INIT_WORK(&sdio->status_work, mt76s_tx_work);
+	INIT_WORK(&sdio->net_work, mt76s_rx_work);
 
 	mutex_init(&sdio->sched.lock);
 	dev->queue_ops = &sdio_queue_ops;
-- 
2.26.2

