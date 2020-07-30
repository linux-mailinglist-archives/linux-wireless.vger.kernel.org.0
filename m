Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EB22333F8
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 16:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbgG3OKC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 10:10:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbgG3OKB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 10:10:01 -0400
Received: from lore-desk.redhat.com (unknown [151.48.137.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3070208A9;
        Thu, 30 Jul 2020 14:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596118200;
        bh=lOsOWZ27Jw3DC1n865K2xRIBOdJLkPsizKOfoAbM6cI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=piwls/7FdNHAJ/L70ZkR2SaNlYHpQVm7m1LXyeGvBTHFLE9UVv5s0G1E6x0oR1nzg
         OG3IwRBxI+S52IASOy3M1BbdNxh8P06upGcYA6RyiNfhcJnL0SCSKxoYrGqyNjO6kI
         N5kbPLSTrY38C1YEYTWhhUvqDZnL1jIRA30uUxiY=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH 2/4] mt76: mt7663s: move rx processing in txrx wq
Date:   Thu, 30 Jul 2020 16:09:49 +0200
Message-Id: <3952dcf0afcd74064a65810b4c8e6a5369ebd110.1596115358.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1596115358.git.lorenzo@kernel.org>
References: <cover.1596115358.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move rx processing to mt76s_txrx_wq in order to minimize the interval when
the sdio bus is locked during rx

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  1 +
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  |  1 +
 .../wireless/mediatek/mt76/mt7615/sdio_txrx.c | 82 ++++++++++++-------
 drivers/net/wireless/mediatek/mt76/sdio.c     |  1 +
 5 files changed, 57 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 4570770e9b1d..6079f44287ea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -452,6 +452,7 @@ struct mt76_sdio {
 
 	struct workqueue_struct *txrx_wq;
 	struct work_struct tx_work;
+	struct work_struct rx_work;
 
 	unsigned long state;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 18b0b7b614ef..4892a3d6d6c3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -679,6 +679,7 @@ int mt7663s_mcu_init(struct mt7615_dev *dev);
 int mt7663s_driver_own(struct mt7615_dev *dev);
 int mt7663s_firmware_own(struct mt7615_dev *dev);
 void mt7663s_tx_work(struct work_struct *work);
+void mt7663s_rx_work(struct work_struct *work);
 void mt7663s_sdio_irq(struct sdio_func *func);
 
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
index 3ab033e0f440..0cc3f0aca70b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -369,6 +369,7 @@ static int mt7663s_probe(struct sdio_func *func,
 		goto err_free;
 
 	INIT_WORK(&mdev->sdio.tx_work, mt7663s_tx_work);
+	INIT_WORK(&mdev->sdio.rx_work, mt7663s_rx_work);
 
 	ret = mt7663s_hw_init(dev, func);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
index 9340d1570a78..c214960504bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
@@ -19,9 +19,9 @@
 #include "sdio.h"
 #include "mac.h"
 
-static void mt7663s_refill_sched_quota(struct mt7615_dev *dev, u32 *data)
+static void mt7663s_refill_sched_quota(struct mt76_dev *dev, u32 *data)
 {
-	struct mt76_sdio *sdio = &dev->mt76.sdio;
+	struct mt76_sdio *sdio = &dev->sdio;
 
 	mutex_lock(&sdio->sched.lock);
 	sdio->sched.pse_data_quota += FIELD_GET(TXQ_CNT_L, data[0]) + /* BK */
@@ -61,11 +61,11 @@ static struct sk_buff *mt7663s_build_rx_skb(void *data, int data_len,
 	return skb;
 }
 
-static int mt7663s_rx_run_queue(struct mt7615_dev *dev, enum mt76_rxq_id qid,
+static int mt7663s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
 				struct mt76s_intr *intr)
 {
-	struct mt76_queue *q = &dev->mt76.q_rx[qid];
-	struct mt76_sdio *sdio = &dev->mt76.sdio;
+	struct mt76_queue *q = &dev->q_rx[qid];
+	struct mt76_sdio *sdio = &dev->sdio;
 	int len = 0, err, i, order;
 	struct page *page;
 	u8 *buf;
@@ -86,9 +86,12 @@ static int mt7663s_rx_run_queue(struct mt7615_dev *dev, enum mt76_rxq_id qid,
 
 	buf = page_address(page);
 
+	sdio_claim_host(sdio->func);
 	err = sdio_readsb(sdio->func, buf, MCR_WRDR(qid), len);
+	sdio_release_host(sdio->func);
+
 	if (err < 0) {
-		dev_err(dev->mt76.dev, "sdio read data failed:%d\n", err);
+		dev_err(dev->dev, "sdio read data failed:%d\n", err);
 		__free_pages(page, order);
 		return err;
 	}
@@ -113,7 +116,7 @@ static int mt7663s_rx_run_queue(struct mt7615_dev *dev, enum mt76_rxq_id qid,
 	q->queued += i;
 	spin_unlock_bh(&q->lock);
 
-	return err;
+	return i;
 }
 
 static int mt7663s_tx_update_sched(struct mt76_dev *dev,
@@ -212,39 +215,60 @@ void mt7663s_tx_work(struct work_struct *work)
 	wake_up_process(sdio->kthread);
 }
 
-void mt7663s_sdio_irq(struct sdio_func *func)
+void mt7663s_rx_work(struct work_struct *work)
 {
-	struct mt7615_dev *dev = sdio_get_drvdata(func);
-	struct mt76_sdio *sdio = &dev->mt76.sdio;
+	struct mt76_sdio *sdio = container_of(work, struct mt76_sdio, rx_work);
+	struct mt76_dev *dev = container_of(sdio, struct mt76_dev, sdio);
 	struct mt76s_intr intr;
+	int nframes = 0, ret;
 
 	/* disable interrupt */
-	sdio_writel(func, WHLPCR_INT_EN_CLR, MCR_WHLPCR, 0);
+	sdio_claim_host(sdio->func);
+	sdio_writel(sdio->func, WHLPCR_INT_EN_CLR, MCR_WHLPCR, 0);
+	sdio_readsb(sdio->func, &intr, MCR_WHISR, sizeof(struct mt76s_intr));
+	sdio_release_host(sdio->func);
 
-	do {
-		sdio_readsb(func, &intr, MCR_WHISR, sizeof(struct mt76s_intr));
-		trace_dev_irq(&dev->mt76, intr.isr, 0);
+	trace_dev_irq(dev, intr.isr, 0);
 
-		if (!test_bit(MT76_STATE_INITIALIZED, &dev->mt76.phy.state))
-			goto out;
-
-		if (intr.isr & WHIER_RX0_DONE_INT_EN) {
-			mt7663s_rx_run_queue(dev, 0, &intr);
+	if (intr.isr & WHIER_RX0_DONE_INT_EN) {
+		ret = mt7663s_rx_run_queue(dev, 0, &intr);
+		if (ret > 0) {
 			wake_up_process(sdio->kthread);
+			nframes += ret;
 		}
+	}
 
-		if (intr.isr & WHIER_RX1_DONE_INT_EN) {
-			mt7663s_rx_run_queue(dev, 1, &intr);
+	if (intr.isr & WHIER_RX1_DONE_INT_EN) {
+		ret = mt7663s_rx_run_queue(dev, 1, &intr);
+		if (ret > 0) {
 			wake_up_process(sdio->kthread);
+			nframes += ret;
 		}
+	}
+
+	if (intr.isr & WHIER_TX_DONE_INT_EN) {
+		mt7663s_refill_sched_quota(dev, intr.tx.wtqcr);
+		queue_work(sdio->txrx_wq, &sdio->tx_work);
+	}
+
+	if (nframes) {
+		queue_work(sdio->txrx_wq, &sdio->rx_work);
+		return;
+	}
 
-		if (intr.isr & WHIER_TX_DONE_INT_EN) {
-			mt7663s_refill_sched_quota(dev, intr.tx.wtqcr);
-			queue_work(sdio->txrx_wq, &sdio->tx_work);
-			wake_up_process(sdio->kthread);
-		}
-	} while (intr.isr);
-out:
 	/* enable interrupt */
-	sdio_writel(func, WHLPCR_INT_EN_SET, MCR_WHLPCR, 0);
+	sdio_claim_host(sdio->func);
+	sdio_writel(sdio->func, WHLPCR_INT_EN_SET, MCR_WHLPCR, 0);
+	sdio_release_host(sdio->func);
+}
+
+void mt7663s_sdio_irq(struct sdio_func *func)
+{
+	struct mt7615_dev *dev = sdio_get_drvdata(func);
+	struct mt76_sdio *sdio = &dev->mt76.sdio;
+
+	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mt76.phy.state))
+		return;
+
+	queue_work(sdio->txrx_wq, &sdio->rx_work);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 4a233e0e9d25..e9fa0ca8f9cd 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -69,6 +69,7 @@ void mt76s_stop_txrx(struct mt76_dev *dev)
 	struct mt76_sdio *sdio = &dev->sdio;
 
 	cancel_work_sync(&sdio->tx_work);
+	cancel_work_sync(&sdio->rx_work);
 	cancel_work_sync(&sdio->stat_work);
 	clear_bit(MT76_READING_STATS, &dev->phy.state);
 
-- 
2.26.2

