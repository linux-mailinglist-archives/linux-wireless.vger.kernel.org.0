Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438122333FC
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 16:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbgG3OKG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 10:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729484AbgG3OKF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 10:10:05 -0400
Received: from lore-desk.redhat.com (unknown [151.48.137.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A803A20842;
        Thu, 30 Jul 2020 14:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596118204;
        bh=cCwoYxzkKwxTtrfhgsNMyCtFYj9+kQx0he8bMN/HdWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YhfdzgADhNLgKGTxAhjc0/pU4IF9rRvNYdOdWkq1UKTlVL9hLDNwTF/uGvBxpOkec
         JBxmSv7O1j4JaP/Nt9hcfFvaEj/b9by6MWTjOmIbpwlpXYD1aOAr3n1UOnoM6ah5IU
         pf7hmFz8Co3YpSPpydUWwt87q+yPxzHvdQ5HGRTQ=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH 4/4] mt76: mt76s: move tx/rx processing in 2 separate works
Date:   Thu, 30 Jul 2020 16:09:51 +0200
Message-Id: <c6894395be923467a66aa1146dfe34103e2dd912.1596115358.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1596115358.git.lorenzo@kernel.org>
References: <cover.1596115358.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to maximize parallelism, split status work in tx status work
and rx net work

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     | 11 +++--
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  |  4 +-
 .../wireless/mediatek/mt76/mt7615/sdio_txrx.c | 20 +++++-----
 drivers/net/wireless/mediatek/mt76/sdio.c     | 40 ++++++++++++-------
 4 files changed, 46 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 17f424d78c2c..d44a35463197 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -448,9 +448,14 @@ struct mt76_usb {
 
 struct mt76_sdio {
 	struct workqueue_struct *txrx_wq;
-	struct work_struct tx_work;
-	struct work_struct rx_work;
-	struct work_struct work;
+	struct {
+		struct work_struct xmit_work;
+		struct work_struct status_work;
+	} tx;
+	struct {
+		struct work_struct recv_work;
+		struct work_struct net_work;
+	} rx;
 
 	struct work_struct stat_work;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
index 0cc3f0aca70b..ddf62dc05c00 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -368,8 +368,8 @@ static int mt7663s_probe(struct sdio_func *func,
 	if (ret < 0)
 		goto err_free;
 
-	INIT_WORK(&mdev->sdio.tx_work, mt7663s_tx_work);
-	INIT_WORK(&mdev->sdio.rx_work, mt7663s_rx_work);
+	INIT_WORK(&mdev->sdio.tx.xmit_work, mt7663s_tx_work);
+	INIT_WORK(&mdev->sdio.rx.recv_work, mt7663s_rx_work);
 
 	ret = mt7663s_hw_init(dev, func);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
index 8872b145df64..c945b4e0320d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
@@ -196,7 +196,8 @@ static int mt7663s_tx_run_queue(struct mt76_dev *dev, struct mt76_queue *q)
 
 void mt7663s_tx_work(struct work_struct *work)
 {
-	struct mt76_sdio *sdio = container_of(work, struct mt76_sdio, tx_work);
+	struct mt76_sdio *sdio = container_of(work, struct mt76_sdio,
+					      tx.xmit_work);
 	struct mt76_dev *dev = container_of(sdio, struct mt76_dev, sdio);
 	int i, nframes = 0;
 
@@ -210,14 +211,15 @@ void mt7663s_tx_work(struct work_struct *work)
 		nframes += ret;
 	}
 	if (nframes)
-		queue_work(sdio->txrx_wq, &sdio->tx_work);
+		queue_work(sdio->txrx_wq, &sdio->tx.xmit_work);
 
-	queue_work(sdio->txrx_wq, &sdio->work);
+	queue_work(sdio->txrx_wq, &sdio->tx.status_work);
 }
 
 void mt7663s_rx_work(struct work_struct *work)
 {
-	struct mt76_sdio *sdio = container_of(work, struct mt76_sdio, rx_work);
+	struct mt76_sdio *sdio = container_of(work, struct mt76_sdio,
+					      rx.recv_work);
 	struct mt76_dev *dev = container_of(sdio, struct mt76_dev, sdio);
 	struct mt76s_intr intr;
 	int nframes = 0, ret;
@@ -233,7 +235,7 @@ void mt7663s_rx_work(struct work_struct *work)
 	if (intr.isr & WHIER_RX0_DONE_INT_EN) {
 		ret = mt7663s_rx_run_queue(dev, 0, &intr);
 		if (ret > 0) {
-			queue_work(sdio->txrx_wq, &sdio->work);
+			queue_work(sdio->txrx_wq, &sdio->rx.net_work);
 			nframes += ret;
 		}
 	}
@@ -241,18 +243,18 @@ void mt7663s_rx_work(struct work_struct *work)
 	if (intr.isr & WHIER_RX1_DONE_INT_EN) {
 		ret = mt7663s_rx_run_queue(dev, 1, &intr);
 		if (ret > 0) {
-			queue_work(sdio->txrx_wq, &sdio->work);
+			queue_work(sdio->txrx_wq, &sdio->rx.net_work);
 			nframes += ret;
 		}
 	}
 
 	if (intr.isr & WHIER_TX_DONE_INT_EN) {
 		mt7663s_refill_sched_quota(dev, intr.tx.wtqcr);
-		queue_work(sdio->txrx_wq, &sdio->tx_work);
+		queue_work(sdio->txrx_wq, &sdio->tx.xmit_work);
 	}
 
 	if (nframes) {
-		queue_work(sdio->txrx_wq, &sdio->rx_work);
+		queue_work(sdio->txrx_wq, &sdio->rx.recv_work);
 		return;
 	}
 
@@ -270,5 +272,5 @@ void mt7663s_sdio_irq(struct sdio_func *func)
 	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mt76.phy.state))
 		return;
 
-	queue_work(sdio->txrx_wq, &sdio->rx_work);
+	queue_work(sdio->txrx_wq, &sdio->rx.recv_work);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 5432b388ceab..40fd752d1234 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -68,9 +68,10 @@ void mt76s_stop_txrx(struct mt76_dev *dev)
 {
 	struct mt76_sdio *sdio = &dev->sdio;
 
-	cancel_work_sync(&sdio->tx_work);
-	cancel_work_sync(&sdio->rx_work);
-	cancel_work_sync(&sdio->work);
+	cancel_work_sync(&sdio->tx.xmit_work);
+	cancel_work_sync(&sdio->tx.status_work);
+	cancel_work_sync(&sdio->rx.recv_work);
+	cancel_work_sync(&sdio->rx.net_work);
 	cancel_work_sync(&sdio->stat_work);
 	clear_bit(MT76_READING_STATS, &dev->phy.state);
 
@@ -274,7 +275,7 @@ static void mt76s_tx_kick(struct mt76_dev *dev, struct mt76_queue *q)
 {
 	struct mt76_sdio *sdio = &dev->sdio;
 
-	queue_work(sdio->txrx_wq, &sdio->tx_work);
+	queue_work(sdio->txrx_wq, &sdio->tx.xmit_work);
 }
 
 static const struct mt76_queue_ops sdio_queue_ops = {
@@ -283,9 +284,25 @@ static const struct mt76_queue_ops sdio_queue_ops = {
 	.tx_queue_skb_raw = mt76s_tx_queue_skb_raw,
 };
 
-static void mt76s_txrx_work(struct work_struct *work)
+static void mt76s_tx_work(struct work_struct *work)
 {
-	struct mt76_sdio *sdio = container_of(work, struct mt76_sdio, work);
+	struct mt76_sdio *sdio = container_of(work, struct mt76_sdio,
+					      tx.status_work);
+	struct mt76_dev *dev = container_of(sdio, struct mt76_dev, sdio);
+	int i;
+
+	for (i = 0; i < MT_TXQ_MCU_WA; i++)
+		mt76s_process_tx_queue(dev, i);
+
+	if (dev->drv->tx_status_data &&
+	    !test_and_set_bit(MT76_READING_STATS, &dev->phy.state))
+		queue_work(dev->wq, &dev->sdio.stat_work);
+}
+
+static void mt76s_rx_work(struct work_struct *work)
+{
+	struct mt76_sdio *sdio = container_of(work, struct mt76_sdio,
+					      rx.net_work);
 	struct mt76_dev *dev = container_of(sdio, struct mt76_dev, sdio);
 	int i;
 
@@ -298,14 +315,6 @@ static void mt76s_txrx_work(struct work_struct *work)
 
 	rcu_read_unlock();
 	local_bh_enable();
-
-	/* tx processing */
-	for (i = 0; i < MT_TXQ_MCU_WA; i++)
-		mt76s_process_tx_queue(dev, i);
-
-	if (dev->drv->tx_status_data &&
-	    !test_and_set_bit(MT76_READING_STATS, &dev->phy.state))
-		queue_work(dev->wq, &dev->sdio.stat_work);
 }
 
 void mt76s_deinit(struct mt76_dev *dev)
@@ -352,7 +361,8 @@ int mt76s_init(struct mt76_dev *dev, struct sdio_func *func,
 		return -ENOMEM;
 
 	INIT_WORK(&sdio->stat_work, mt76s_tx_status_data);
-	INIT_WORK(&sdio->work, mt76s_txrx_work);
+	INIT_WORK(&sdio->tx.status_work, mt76s_tx_work);
+	INIT_WORK(&sdio->rx.net_work, mt76s_rx_work);
 
 	mutex_init(&sdio->sched.lock);
 	dev->queue_ops = &sdio_queue_ops;
-- 
2.26.2

