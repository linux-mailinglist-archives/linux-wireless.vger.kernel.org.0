Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C612333F7
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 16:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbgG3OKA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 10:10:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbgG3OJ7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 10:09:59 -0400
Received: from lore-desk.redhat.com (unknown [151.48.137.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2E4420842;
        Thu, 30 Jul 2020 14:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596118198;
        bh=Jvy7R2+W4yzCzOC9owIBC3DZTav3nQBBvQ27uk/HWNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sTmxJ/PEcTlMky8jnoB7y3z9hseJ4pDOBlNB9FMoHlzIJcVBA5Y1MBnFbkaGZmzAd
         rWcPt6HWe62lLuWtwo0uelSNUMpaSdrZta97XYESyIlq5onbigVikiAslVehuWnE7t
         VqtdzK3MHzg+Kja4ajV0GcolYXBaTvGvTttJFo80=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH 1/4] mt76: mt76s: move tx processing in a dedicated wq
Date:   Thu, 30 Jul 2020 16:09:48 +0200
Message-Id: <8116493da15164a352562ccf0bdbc2a6386d3806.1596115358.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1596115358.git.lorenzo@kernel.org>
References: <cover.1596115358.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt76s_txrx_wq workqueue and move tx processing from kthread to
a dedicated work. This is preliminary patch to improve mt7663s throughput

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  4 +-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  |  9 +--
 .../wireless/mediatek/mt76/mt7615/sdio_txrx.c | 56 +++++++------------
 drivers/net/wireless/mediatek/mt76/sdio.c     | 16 +++++-
 5 files changed, 39 insertions(+), 48 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 4482eeb91a64..4570770e9b1d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -447,10 +447,12 @@ struct mt76_usb {
 };
 
 struct mt76_sdio {
-	struct task_struct *tx_kthread;
 	struct task_struct *kthread;
 	struct work_struct stat_work;
 
+	struct workqueue_struct *txrx_wq;
+	struct work_struct tx_work;
+
 	unsigned long state;
 
 	struct sdio_func *func;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index e93f87af3d2a..18b0b7b614ef 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -678,7 +678,7 @@ u32 mt7663s_read_pcr(struct mt7615_dev *dev);
 int mt7663s_mcu_init(struct mt7615_dev *dev);
 int mt7663s_driver_own(struct mt7615_dev *dev);
 int mt7663s_firmware_own(struct mt7615_dev *dev);
-int mt7663s_kthread_run(void *data);
+void mt7663s_tx_work(struct work_struct *work);
 void mt7663s_sdio_irq(struct sdio_func *func);
 
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
index dabce51117b0..3ab033e0f440 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -364,18 +364,15 @@ static int mt7663s_probe(struct sdio_func *func,
 	dev->ops = ops;
 	sdio_set_drvdata(func, dev);
 
-	mdev->sdio.tx_kthread = kthread_create(mt7663s_kthread_run, dev,
-					       "mt7663s_tx");
-	if (IS_ERR(mdev->sdio.tx_kthread))
-		return PTR_ERR(mdev->sdio.tx_kthread);
-
 	ret = mt76s_init(mdev, func, &mt7663s_ops);
 	if (ret < 0)
 		goto err_free;
 
+	INIT_WORK(&mdev->sdio.tx_work, mt7663s_tx_work);
+
 	ret = mt7663s_hw_init(dev, func);
 	if (ret)
-		goto err_free;
+		goto err_deinit;
 
 	mdev->rev = (mt76_rr(dev, MT_HW_CHIPID) << 16) |
 		    (mt76_rr(dev, MT_HW_REV) & 0xff);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
index 443a4ecdad3a..9340d1570a78 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
@@ -116,12 +116,12 @@ static int mt7663s_rx_run_queue(struct mt7615_dev *dev, enum mt76_rxq_id qid,
 	return err;
 }
 
-static int mt7663s_tx_update_sched(struct mt7615_dev *dev,
+static int mt7663s_tx_update_sched(struct mt76_dev *dev,
 				   struct mt76_queue_entry *e,
 				   bool mcu)
 {
-	struct mt76_sdio *sdio = &dev->mt76.sdio;
-	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt76_sdio *sdio = &dev->sdio;
+	struct mt76_phy *mphy = &dev->phy;
 	struct ieee80211_hdr *hdr;
 	int size, ret = -EBUSY;
 
@@ -157,10 +157,10 @@ static int mt7663s_tx_update_sched(struct mt7615_dev *dev,
 	return ret;
 }
 
-static int mt7663s_tx_run_queue(struct mt7615_dev *dev, struct mt76_queue *q)
+static int mt7663s_tx_run_queue(struct mt76_dev *dev, struct mt76_queue *q)
 {
-	bool mcu = q == dev->mt76.q_tx[MT_TXQ_MCU].q;
-	struct mt76_sdio *sdio = &dev->mt76.sdio;
+	bool mcu = q == dev->q_tx[MT_TXQ_MCU].q;
+	struct mt76_sdio *sdio = &dev->sdio;
 	int nframes = 0;
 
 	while (q->first != q->tail) {
@@ -174,9 +174,12 @@ static int mt7663s_tx_run_queue(struct mt7615_dev *dev, struct mt76_queue *q)
 			len = roundup(len, sdio->func->cur_blksize);
 
 		/* TODO: skb_walk_frags and then write to SDIO port */
+		sdio_claim_host(sdio->func);
 		err = sdio_writesb(sdio->func, MCR_WTDR1, e->skb->data, len);
+		sdio_release_host(sdio->func);
+
 		if (err) {
-			dev_err(dev->mt76.dev, "sdio write failed: %d\n", err);
+			dev_err(dev->dev, "sdio write failed: %d\n", err);
 			return -EIO;
 		}
 
@@ -188,46 +191,25 @@ static int mt7663s_tx_run_queue(struct mt7615_dev *dev, struct mt76_queue *q)
 	return nframes;
 }
 
-static int mt7663s_tx_run_queues(struct mt7615_dev *dev)
+void mt7663s_tx_work(struct work_struct *work)
 {
+	struct mt76_sdio *sdio = container_of(work, struct mt76_sdio, tx_work);
+	struct mt76_dev *dev = container_of(sdio, struct mt76_dev, sdio);
 	int i, nframes = 0;
 
 	for (i = 0; i < MT_TXQ_MCU_WA; i++) {
 		int ret;
 
-		ret = mt7663s_tx_run_queue(dev, dev->mt76.q_tx[i].q);
+		ret = mt7663s_tx_run_queue(dev, dev->q_tx[i].q);
 		if (ret < 0)
-			return ret;
+			break;
 
 		nframes += ret;
 	}
+	if (nframes)
+		queue_work(sdio->txrx_wq, &sdio->tx_work);
 
-	return nframes;
-}
-
-int mt7663s_kthread_run(void *data)
-{
-	struct mt7615_dev *dev = data;
-	struct mt76_phy *mphy = &dev->mt76.phy;
-
-	while (!kthread_should_stop()) {
-		int ret;
-
-		cond_resched();
-
-		sdio_claim_host(dev->mt76.sdio.func);
-		ret = mt7663s_tx_run_queues(dev);
-		sdio_release_host(dev->mt76.sdio.func);
-
-		if (ret <= 0 || !test_bit(MT76_STATE_RUNNING, &mphy->state)) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule();
-		} else {
-			wake_up_process(dev->mt76.sdio.kthread);
-		}
-	}
-
-	return 0;
+	wake_up_process(sdio->kthread);
 }
 
 void mt7663s_sdio_irq(struct sdio_func *func)
@@ -258,7 +240,7 @@ void mt7663s_sdio_irq(struct sdio_func *func)
 
 		if (intr.isr & WHIER_TX_DONE_INT_EN) {
 			mt7663s_refill_sched_quota(dev, intr.tx.wtqcr);
-			mt7663s_tx_run_queues(dev);
+			queue_work(sdio->txrx_wq, &sdio->tx_work);
 			wake_up_process(sdio->kthread);
 		}
 	} while (intr.isr);
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 5d8353026aaf..4a233e0e9d25 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -68,6 +68,7 @@ void mt76s_stop_txrx(struct mt76_dev *dev)
 {
 	struct mt76_sdio *sdio = &dev->sdio;
 
+	cancel_work_sync(&sdio->tx_work);
 	cancel_work_sync(&sdio->stat_work);
 	clear_bit(MT76_READING_STATS, &dev->phy.state);
 
@@ -179,7 +180,6 @@ static int mt76s_process_tx_queue(struct mt76_dev *dev, enum mt76_txq_id qid)
 	if (wake)
 		ieee80211_wake_queue(dev->hw, qid);
 
-	wake_up_process(dev->sdio.tx_kthread);
 out:
 	return n_dequeued;
 }
@@ -272,7 +272,7 @@ static void mt76s_tx_kick(struct mt76_dev *dev, struct mt76_queue *q)
 {
 	struct mt76_sdio *sdio = &dev->sdio;
 
-	wake_up_process(sdio->tx_kthread);
+	queue_work(sdio->txrx_wq, &sdio->tx_work);
 }
 
 static const struct mt76_queue_ops sdio_queue_ops = {
@@ -324,9 +324,13 @@ void mt76s_deinit(struct mt76_dev *dev)
 	int i;
 
 	kthread_stop(sdio->kthread);
-	kthread_stop(sdio->tx_kthread);
 	mt76s_stop_txrx(dev);
 
+	if (sdio->txrx_wq) {
+		destroy_workqueue(sdio->txrx_wq);
+		sdio->txrx_wq = NULL;
+	}
+
 	sdio_claim_host(sdio->func);
 	sdio_release_irq(sdio->func);
 	sdio_release_host(sdio->func);
@@ -353,6 +357,12 @@ int mt76s_init(struct mt76_dev *dev, struct sdio_func *func,
 {
 	struct mt76_sdio *sdio = &dev->sdio;
 
+	sdio->txrx_wq = alloc_workqueue("mt76s_txrx_wq",
+					WQ_UNBOUND | WQ_HIGHPRI,
+					WQ_UNBOUND_MAX_ACTIVE);
+	if (!sdio->txrx_wq)
+		return -ENOMEM;
+
 	sdio->kthread = kthread_create(mt76s_kthread_run, dev, "mt76s");
 	if (IS_ERR(sdio->kthread))
 		return PTR_ERR(sdio->kthread);
-- 
2.26.2

