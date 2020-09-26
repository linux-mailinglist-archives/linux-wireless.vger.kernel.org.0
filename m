Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C77279A4D
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Sep 2020 17:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbgIZPHH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Sep 2020 11:07:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729527AbgIZPHG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Sep 2020 11:07:06 -0400
Received: from localhost.localdomain (unknown [151.66.98.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F27062184D;
        Sat, 26 Sep 2020 15:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601132825;
        bh=PST2CSG6OuX8NF85bb5jg8MAh/zFi9LLeymYi/EKT5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c81qzyyWuchi1ug4Zg3Tv/GczNoIbPYA7KfQ6TAXekKRijtWfgA0ZFiSWrIZS0Cie
         vbGsyLrENO4vWBD4CERn6Z9IdGH2qi8vEK/XwC4k50Lbz9ySauah1YOgt1a3TMc1bx
         zYlJJqhHCxqwI0XYhotavPhaXEojqj7M0P/Wpc+A=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 4/4] mt76: sdio: convert {status/net}_work to mt76_worker
Date:   Sat, 26 Sep 2020 17:06:25 +0200
Message-Id: <ab20edb09b16e0a2e202e668893acc475dc0749d.1601132347.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601132347.git.lorenzo@kernel.org>
References: <cover.1601132347.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to improve driver throughput, convert status_work and net_work
to mt76 worker APIs.
Remove txrx_wq sdio workqueue since it is no longer used

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |   8 +-
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  |  27 ++--
 .../wireless/mediatek/mt76/mt7615/sdio_txrx.c |   6 +-
 drivers/net/wireless/mediatek/mt76/sdio.c     | 124 +++++++++---------
 4 files changed, 87 insertions(+), 78 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index e47696e5d3f0..6bb162a2cdd3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -445,11 +445,10 @@ struct mt76_usb {
 
 #define MT76S_XMIT_BUF_SZ	(16 * PAGE_SIZE)
 struct mt76_sdio {
-	struct workqueue_struct *txrx_wq;
-
 	struct mt76_worker txrx_worker;
-	struct work_struct status_work;
-	struct work_struct net_work;
+	struct mt76_worker status_worker;
+	struct mt76_worker net_worker;
+
 	struct work_struct stat_work;
 
 	u8 *xmit_buf[MT_TXQ_MCU_WA];
@@ -1059,7 +1058,6 @@ void mt76u_queues_deinit(struct mt76_dev *dev);
 int mt76s_init(struct mt76_dev *dev, struct sdio_func *func,
 	       const struct mt76_bus_ops *bus_ops);
 int mt76s_alloc_queues(struct mt76_dev *dev);
-void mt76s_stop_txrx(struct mt76_dev *dev);
 void mt76s_deinit(struct mt76_dev *dev);
 
 struct sk_buff *
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
index 6f8adba2a78b..a3718c501eb8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -366,11 +366,11 @@ static int mt7663s_probe(struct sdio_func *func,
 
 	ret = mt76s_init(mdev, func, &mt7663s_ops);
 	if (ret < 0)
-		goto err_free;
+		goto error;
 
 	ret = mt7663s_hw_init(dev, func);
 	if (ret)
-		goto err_deinit;
+		goto error;
 
 	mdev->rev = (mt76_rr(dev, MT_HW_CHIPID) << 16) |
 		    (mt76_rr(dev, MT_HW_REV) & 0xff);
@@ -381,7 +381,7 @@ static int mt7663s_probe(struct sdio_func *func,
 					    GFP_KERNEL);
 	if (!mdev->sdio.intr_data) {
 		ret = -ENOMEM;
-		goto err_deinit;
+		goto error;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(mdev->sdio.xmit_buf); i++) {
@@ -390,30 +390,29 @@ static int mt7663s_probe(struct sdio_func *func,
 						      GFP_KERNEL);
 		if (!mdev->sdio.xmit_buf[i]) {
 			ret = -ENOMEM;
-			goto err_deinit;
+			goto error;
 		}
 	}
 
 	ret = mt76s_alloc_queues(&dev->mt76);
 	if (ret)
-		goto err_deinit;
+		goto error;
 
 	ret = mt76_worker_setup(mt76_hw(dev), &mdev->sdio.txrx_worker,
 				mt7663s_txrx_worker, "sdio-txrx");
 	if (ret)
-		goto err_deinit;
+		goto error;
 
 	sched_set_fifo_low(mdev->sdio.txrx_worker.task);
 
 	ret = mt7663_usb_sdio_register_device(dev);
 	if (ret)
-		goto err_deinit;
+		goto error;
 
 	return 0;
 
-err_deinit:
+error:
 	mt76s_deinit(&dev->mt76);
-err_free:
 	mt76_free_device(&dev->mt76);
 
 	return ret;
@@ -454,7 +453,13 @@ static int mt7663s_suspend(struct device *dev)
 		return err;
 
 	mt76_worker_disable(&mdev->mt76.sdio.txrx_worker);
-	mt76s_stop_txrx(&mdev->mt76);
+	mt76_worker_disable(&mdev->mt76.sdio.status_worker);
+	mt76_worker_disable(&mdev->mt76.sdio.net_worker);
+
+	cancel_work_sync(&mdev->mt76.sdio.stat_work);
+	clear_bit(MT76_READING_STATS, &mdev->mphy.state);
+
+	mt76_tx_status_check(&mdev->mt76, NULL, true);
 
 	return 0;
 }
@@ -466,6 +471,8 @@ static int mt7663s_resume(struct device *dev)
 	int err;
 
 	mt76_worker_enable(&mdev->mt76.sdio.txrx_worker);
+	mt76_worker_enable(&mdev->mt76.sdio.status_worker);
+	mt76_worker_enable(&mdev->mt76.sdio.net_worker);
 
 	err = mt7615_mcu_set_drv_ctrl(mdev);
 	if (err)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
index d8f9148fe777..a4969380c860 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
@@ -150,7 +150,7 @@ static int mt7663s_rx_handler(struct mt76_dev *dev)
 	if (intr->isr & WHIER_RX0_DONE_INT_EN) {
 		ret = mt7663s_rx_run_queue(dev, 0, intr);
 		if (ret > 0) {
-			queue_work(sdio->txrx_wq, &sdio->net_work);
+			mt76_worker_schedule(&sdio->net_worker);
 			nframes += ret;
 		}
 	}
@@ -158,7 +158,7 @@ static int mt7663s_rx_handler(struct mt76_dev *dev)
 	if (intr->isr & WHIER_RX1_DONE_INT_EN) {
 		ret = mt7663s_rx_run_queue(dev, 1, intr);
 		if (ret > 0) {
-			queue_work(sdio->txrx_wq, &sdio->net_work);
+			mt76_worker_schedule(&sdio->net_worker);
 			nframes += ret;
 		}
 	}
@@ -269,7 +269,7 @@ static int mt7663s_tx_run_queue(struct mt76_dev *dev, enum mt76_txq_id qid)
 	}
 	mt7663s_tx_update_quota(sdio, qid, pse_sz, ple_sz);
 
-	queue_work(sdio->txrx_wq, &sdio->status_work);
+	mt76_worker_schedule(&sdio->status_worker);
 
 	return nframes;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 37e05ec40e1d..41e832b11199 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -62,19 +62,6 @@ static int mt76s_alloc_tx(struct mt76_dev *dev)
 	return 0;
 }
 
-void mt76s_stop_txrx(struct mt76_dev *dev)
-{
-	struct mt76_sdio *sdio = &dev->sdio;
-
-	cancel_work_sync(&sdio->status_work);
-	cancel_work_sync(&sdio->net_work);
-	cancel_work_sync(&sdio->stat_work);
-	clear_bit(MT76_READING_STATS, &dev->phy.state);
-
-	mt76_tx_status_check(dev, NULL, true);
-}
-EXPORT_SYMBOL_GPL(mt76s_stop_txrx);
-
 int mt76s_alloc_queues(struct mt76_dev *dev)
 {
 	int err;
@@ -129,10 +116,32 @@ mt76s_process_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 	return nframes;
 }
 
-static void mt76s_process_tx_queue(struct mt76_dev *dev, enum mt76_txq_id qid)
+static void mt76s_net_worker(struct mt76_worker *w)
+{
+	struct mt76_sdio *sdio = container_of(w, struct mt76_sdio,
+					      net_worker);
+	struct mt76_dev *dev = container_of(sdio, struct mt76_dev, sdio);
+	int i, nframes;
+
+	do {
+		nframes = 0;
+
+		local_bh_disable();
+		rcu_read_lock();
+
+		mt76_for_each_q_rx(dev, i)
+			nframes += mt76s_process_rx_queue(dev, &dev->q_rx[i]);
+
+		rcu_read_unlock();
+		local_bh_enable();
+	} while (nframes > 0);
+}
+
+static int mt76s_process_tx_queue(struct mt76_dev *dev, enum mt76_txq_id qid)
 {
 	struct mt76_queue *q = dev->q_tx[qid];
 	struct mt76_queue_entry entry;
+	int nframes = 0;
 	bool wake;
 
 	while (q->queued > 0) {
@@ -148,6 +157,7 @@ static void mt76s_process_tx_queue(struct mt76_dev *dev, enum mt76_txq_id qid)
 		}
 
 		mt76_queue_tx_complete(dev, q, &entry);
+		nframes++;
 	}
 
 	wake = q->stopped && q->queued < q->ndesc - 8;
@@ -158,12 +168,32 @@ static void mt76s_process_tx_queue(struct mt76_dev *dev, enum mt76_txq_id qid)
 		wake_up(&dev->tx_wait);
 
 	if (qid == MT_TXQ_MCU)
-		return;
+		goto out;
 
 	mt76_txq_schedule(&dev->phy, qid);
 
 	if (wake)
 		ieee80211_wake_queue(dev->hw, qid);
+out:
+	return nframes;
+}
+
+static void mt76s_status_worker(struct mt76_worker *w)
+{
+	struct mt76_sdio *sdio = container_of(w, struct mt76_sdio,
+					      status_worker);
+	struct mt76_dev *dev = container_of(sdio, struct mt76_dev, sdio);
+	int i, nframes;
+
+	do {
+		nframes = 0;
+		for (i = 0; i < MT_TXQ_MCU_WA; i++)
+			nframes += mt76s_process_tx_queue(dev, i);
+
+		if (dev->drv->tx_status_data &&
+		    !test_and_set_bit(MT76_READING_STATS, &dev->phy.state))
+			queue_work(dev->wq, &dev->sdio.stat_work);
+	} while (nframes > 0);
 }
 
 static void mt76s_tx_status_data(struct work_struct *work)
@@ -264,51 +294,19 @@ static const struct mt76_queue_ops sdio_queue_ops = {
 	.tx_queue_skb_raw = mt76s_tx_queue_skb_raw,
 };
 
-static void mt76s_tx_work(struct work_struct *work)
-{
-	struct mt76_sdio *sdio = container_of(work, struct mt76_sdio,
-					      status_work);
-	struct mt76_dev *dev = container_of(sdio, struct mt76_dev, sdio);
-	int i;
-
-	for (i = 0; i < MT_TXQ_MCU_WA; i++)
-		mt76s_process_tx_queue(dev, i);
-
-	if (dev->drv->tx_status_data &&
-	    !test_and_set_bit(MT76_READING_STATS, &dev->phy.state))
-		queue_work(dev->wq, &dev->sdio.stat_work);
-}
-
-static void mt76s_rx_work(struct work_struct *work)
-{
-	struct mt76_sdio *sdio = container_of(work, struct mt76_sdio,
-					      net_work);
-	struct mt76_dev *dev = container_of(sdio, struct mt76_dev, sdio);
-	int i;
-
-	/* rx processing */
-	local_bh_disable();
-	rcu_read_lock();
-
-	mt76_for_each_q_rx(dev, i)
-		mt76s_process_rx_queue(dev, &dev->q_rx[i]);
-
-	rcu_read_unlock();
-	local_bh_enable();
-}
-
 void mt76s_deinit(struct mt76_dev *dev)
 {
 	struct mt76_sdio *sdio = &dev->sdio;
 	int i;
 
 	mt76_worker_teardown(&sdio->txrx_worker);
+	mt76_worker_teardown(&sdio->status_worker);
+	mt76_worker_teardown(&sdio->net_worker);
 
-	mt76s_stop_txrx(dev);
-	if (sdio->txrx_wq) {
-		destroy_workqueue(sdio->txrx_wq);
-		sdio->txrx_wq = NULL;
-	}
+	cancel_work_sync(&sdio->stat_work);
+	clear_bit(MT76_READING_STATS, &dev->phy.state);
+
+	mt76_tx_status_check(dev, NULL, true);
 
 	sdio_claim_host(sdio->func);
 	sdio_release_irq(sdio->func);
@@ -335,16 +333,22 @@ int mt76s_init(struct mt76_dev *dev, struct sdio_func *func,
 	       const struct mt76_bus_ops *bus_ops)
 {
 	struct mt76_sdio *sdio = &dev->sdio;
+	int err;
 
-	sdio->txrx_wq = alloc_workqueue("mt76s_txrx_wq",
-					WQ_UNBOUND | WQ_HIGHPRI,
-					WQ_UNBOUND_MAX_ACTIVE);
-	if (!sdio->txrx_wq)
-		return -ENOMEM;
+	err = mt76_worker_setup(dev->hw, &sdio->status_worker,
+				mt76s_status_worker, "sdio-status");
+	if (err)
+		return err;
+
+	err = mt76_worker_setup(dev->hw, &sdio->net_worker, mt76s_net_worker,
+				"sdio-net");
+	if (err)
+		return err;
+
+	sched_set_fifo_low(sdio->status_worker.task);
+	sched_set_fifo_low(sdio->net_worker.task);
 
 	INIT_WORK(&sdio->stat_work, mt76s_tx_status_data);
-	INIT_WORK(&sdio->status_work, mt76s_tx_work);
-	INIT_WORK(&sdio->net_work, mt76s_rx_work);
 
 	mutex_init(&sdio->sched.lock);
 	dev->queue_ops = &sdio_queue_ops;
-- 
2.26.2

