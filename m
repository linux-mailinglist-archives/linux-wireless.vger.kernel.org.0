Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADB62333FB
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 16:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbgG3OKE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 10:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbgG3OKD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 10:10:03 -0400
Received: from lore-desk.redhat.com (unknown [151.48.137.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C38AB2074B;
        Thu, 30 Jul 2020 14:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596118202;
        bh=6jGOG/jdCRWMTGeEcPIP4lkoOmahuJYpCi39KFq1cms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HR/d0hDTzMjIfbksxtrtLzcgdN+BYIfC/2NPCkpYKToVQ1x/uTmZkPDjYGNEQYO0a
         ErDe2AtD9+dFKS4yUnq5Hg+uOwM2zIfAMn8tCs8gs9LDn92aCt0I3KzeqBeYxcZPMv
         17Jd4KeOic7OQYuEgHnfwhDX9woUpv8qkArDRxoo=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH 3/4] mt76: mt76s: move status processing in txrx wq
Date:   Thu, 30 Jul 2020 16:09:50 +0200
Message-Id: <2e909d4651da44b1632d081084873e12af9883e0.1596115358.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1596115358.git.lorenzo@kernel.org>
References: <cover.1596115358.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As it has been done for tx and rx processing, move tx/rx status
processing into mt76s_txrx_wq workqueue

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  6 +--
 .../wireless/mediatek/mt76/mt7615/sdio_txrx.c |  6 +--
 drivers/net/wireless/mediatek/mt76/sdio.c     | 54 +++++++------------
 3 files changed, 25 insertions(+), 41 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 6079f44287ea..17f424d78c2c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -447,12 +447,12 @@ struct mt76_usb {
 };
 
 struct mt76_sdio {
-	struct task_struct *kthread;
-	struct work_struct stat_work;
-
 	struct workqueue_struct *txrx_wq;
 	struct work_struct tx_work;
 	struct work_struct rx_work;
+	struct work_struct work;
+
+	struct work_struct stat_work;
 
 	unsigned long state;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
index c214960504bf..8872b145df64 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
@@ -212,7 +212,7 @@ void mt7663s_tx_work(struct work_struct *work)
 	if (nframes)
 		queue_work(sdio->txrx_wq, &sdio->tx_work);
 
-	wake_up_process(sdio->kthread);
+	queue_work(sdio->txrx_wq, &sdio->work);
 }
 
 void mt7663s_rx_work(struct work_struct *work)
@@ -233,7 +233,7 @@ void mt7663s_rx_work(struct work_struct *work)
 	if (intr.isr & WHIER_RX0_DONE_INT_EN) {
 		ret = mt7663s_rx_run_queue(dev, 0, &intr);
 		if (ret > 0) {
-			wake_up_process(sdio->kthread);
+			queue_work(sdio->txrx_wq, &sdio->work);
 			nframes += ret;
 		}
 	}
@@ -241,7 +241,7 @@ void mt7663s_rx_work(struct work_struct *work)
 	if (intr.isr & WHIER_RX1_DONE_INT_EN) {
 		ret = mt7663s_rx_run_queue(dev, 1, &intr);
 		if (ret > 0) {
-			wake_up_process(sdio->kthread);
+			queue_work(sdio->txrx_wq, &sdio->work);
 			nframes += ret;
 		}
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index e9fa0ca8f9cd..5432b388ceab 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -70,6 +70,7 @@ void mt76s_stop_txrx(struct mt76_dev *dev)
 
 	cancel_work_sync(&sdio->tx_work);
 	cancel_work_sync(&sdio->rx_work);
+	cancel_work_sync(&sdio->work);
 	cancel_work_sync(&sdio->stat_work);
 	clear_bit(MT76_READING_STATS, &dev->phy.state);
 
@@ -282,41 +283,29 @@ static const struct mt76_queue_ops sdio_queue_ops = {
 	.tx_queue_skb_raw = mt76s_tx_queue_skb_raw,
 };
 
-static int mt76s_kthread_run(void *data)
+static void mt76s_txrx_work(struct work_struct *work)
 {
-	struct mt76_dev *dev = data;
-	struct mt76_phy *mphy = &dev->phy;
-
-	while (!kthread_should_stop()) {
-		int i, nframes = 0;
-
-		cond_resched();
-
-		/* rx processing */
-		local_bh_disable();
-		rcu_read_lock();
-
-		mt76_for_each_q_rx(dev, i)
-			nframes += mt76s_process_rx_queue(dev, &dev->q_rx[i]);
+	struct mt76_sdio *sdio = container_of(work, struct mt76_sdio, work);
+	struct mt76_dev *dev = container_of(sdio, struct mt76_dev, sdio);
+	int i;
 
-		rcu_read_unlock();
-		local_bh_enable();
+	/* rx processing */
+	local_bh_disable();
+	rcu_read_lock();
 
-		/* tx processing */
-		for (i = 0; i < MT_TXQ_MCU_WA; i++)
-			nframes += mt76s_process_tx_queue(dev, i);
+	mt76_for_each_q_rx(dev, i)
+		mt76s_process_rx_queue(dev, &dev->q_rx[i]);
 
-		if (dev->drv->tx_status_data &&
-		    !test_and_set_bit(MT76_READING_STATS, &mphy->state))
-			queue_work(dev->wq, &dev->sdio.stat_work);
+	rcu_read_unlock();
+	local_bh_enable();
 
-		if (!nframes || !test_bit(MT76_STATE_RUNNING, &mphy->state)) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule();
-		}
-	}
+	/* tx processing */
+	for (i = 0; i < MT_TXQ_MCU_WA; i++)
+		mt76s_process_tx_queue(dev, i);
 
-	return 0;
+	if (dev->drv->tx_status_data &&
+	    !test_and_set_bit(MT76_READING_STATS, &dev->phy.state))
+		queue_work(dev->wq, &dev->sdio.stat_work);
 }
 
 void mt76s_deinit(struct mt76_dev *dev)
@@ -324,9 +313,7 @@ void mt76s_deinit(struct mt76_dev *dev)
 	struct mt76_sdio *sdio = &dev->sdio;
 	int i;
 
-	kthread_stop(sdio->kthread);
 	mt76s_stop_txrx(dev);
-
 	if (sdio->txrx_wq) {
 		destroy_workqueue(sdio->txrx_wq);
 		sdio->txrx_wq = NULL;
@@ -364,11 +351,8 @@ int mt76s_init(struct mt76_dev *dev, struct sdio_func *func,
 	if (!sdio->txrx_wq)
 		return -ENOMEM;
 
-	sdio->kthread = kthread_create(mt76s_kthread_run, dev, "mt76s");
-	if (IS_ERR(sdio->kthread))
-		return PTR_ERR(sdio->kthread);
-
 	INIT_WORK(&sdio->stat_work, mt76s_tx_status_data);
+	INIT_WORK(&sdio->work, mt76s_txrx_work);
 
 	mutex_init(&sdio->sched.lock);
 	dev->queue_ops = &sdio_queue_ops;
-- 
2.26.2

