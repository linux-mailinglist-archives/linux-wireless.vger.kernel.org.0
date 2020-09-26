Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279E2279A4B
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Sep 2020 17:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbgIZPHD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Sep 2020 11:07:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729510AbgIZPHD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Sep 2020 11:07:03 -0400
Received: from localhost.localdomain (unknown [151.66.98.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D8412184D;
        Sat, 26 Sep 2020 15:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601132822;
        bh=iYGKTY5SXpEb5xniCe3b2ZAzCFOv4PNzH302wFjldM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ox8ecVSkXOKUXbVRnV5R0l0DY59Nc26hV8UK1Jv4YyDLL3/OcdaOEa782kzXP3X4n
         33iSswQqDRWJOBYJ0f3CqWGt+u54N4GfTpGRvafJMazhVMvbY2UlFT39gbdlrUoZeZ
         JVCi1m7N1u3CYYm7U/EouVfU5pk41Hdq9/OrsEJE=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 2/4] mt76: mt7663s: convert txrx_work to mt76_worker
Date:   Sat, 26 Sep 2020 17:06:23 +0200
Message-Id: <0cbaf58638ec4bfa0fe5e0baae30fcb594f158b6.1601132347.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601132347.git.lorenzo@kernel.org>
References: <cover.1601132347.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to improve driver throughput, convert txrx_work to mt76 worker
threads APIs.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 +-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  | 19 +++++++--
 .../wireless/mediatek/mt76/mt7615/sdio_txrx.c | 41 +++++++++----------
 drivers/net/wireless/mediatek/mt76/sdio.c     |  5 ++-
 5 files changed, 41 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 243cb89c0a92..e47696e5d3f0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -447,7 +447,7 @@ struct mt76_usb {
 struct mt76_sdio {
 	struct workqueue_struct *txrx_wq;
 
-	struct work_struct txrx_work;
+	struct mt76_worker txrx_worker;
 	struct work_struct status_work;
 	struct work_struct net_work;
 	struct work_struct stat_work;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 11b4caa5cb69..716956b58c13 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -681,7 +681,7 @@ int mt7663u_mcu_init(struct mt7615_dev *dev);
 /* sdio */
 u32 mt7663s_read_pcr(struct mt7615_dev *dev);
 int mt7663s_mcu_init(struct mt7615_dev *dev);
-void mt7663s_txrx_work(struct work_struct *work);
+void mt7663s_txrx_worker(struct mt76_worker *w);
 void mt7663s_rx_work(struct work_struct *work);
 void mt7663s_sdio_irq(struct sdio_func *func);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
index ad7e422ea52e..6f8adba2a78b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -368,8 +368,6 @@ static int mt7663s_probe(struct sdio_func *func,
 	if (ret < 0)
 		goto err_free;
 
-	INIT_WORK(&mdev->sdio.txrx_work, mt7663s_txrx_work);
-
 	ret = mt7663s_hw_init(dev, func);
 	if (ret)
 		goto err_deinit;
@@ -400,6 +398,13 @@ static int mt7663s_probe(struct sdio_func *func,
 	if (ret)
 		goto err_deinit;
 
+	ret = mt76_worker_setup(mt76_hw(dev), &mdev->sdio.txrx_worker,
+				mt7663s_txrx_worker, "sdio-txrx");
+	if (ret)
+		goto err_deinit;
+
+	sched_set_fifo_low(mdev->sdio.txrx_worker.task);
+
 	ret = mt7663_usb_sdio_register_device(dev);
 	if (ret)
 		goto err_deinit;
@@ -431,6 +436,7 @@ static int mt7663s_suspend(struct device *dev)
 {
 	struct sdio_func *func = dev_to_sdio_func(dev);
 	struct mt7615_dev *mdev = sdio_get_drvdata(func);
+	int err;
 
 	if (!test_bit(MT76_STATE_SUSPEND, &mdev->mphy.state) &&
 	    mt7615_firmware_offload(mdev)) {
@@ -443,9 +449,14 @@ static int mt7663s_suspend(struct device *dev)
 
 	sdio_set_host_pm_flags(func, MMC_PM_KEEP_POWER);
 
+	err = mt7615_mcu_set_fw_ctrl(mdev);
+	if (err)
+		return err;
+
+	mt76_worker_disable(&mdev->mt76.sdio.txrx_worker);
 	mt76s_stop_txrx(&mdev->mt76);
 
-	return mt7615_mcu_set_fw_ctrl(mdev);
+	return 0;
 }
 
 static int mt7663s_resume(struct device *dev)
@@ -454,6 +465,8 @@ static int mt7663s_resume(struct device *dev)
 	struct mt7615_dev *mdev = sdio_get_drvdata(func);
 	int err;
 
+	mt76_worker_enable(&mdev->mt76.sdio.txrx_worker);
+
 	err = mt7615_mcu_set_drv_ctrl(mdev);
 	if (err)
 		return err;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
index 1194df0405ed..10ed211d7d11 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
@@ -286,34 +286,33 @@ static int mt7663s_tx_run_queue(struct mt76_dev *dev, enum mt76_txq_id qid)
 	}
 	mt7663s_tx_update_quota(sdio, qid, pse_sz, ple_sz);
 
+	queue_work(sdio->txrx_wq, &sdio->status_work);
+
 	return nframes;
 }
 
-void mt7663s_txrx_work(struct work_struct *work)
+void mt7663s_txrx_worker(struct mt76_worker *w)
 {
-	struct mt76_sdio *sdio = container_of(work, struct mt76_sdio,
-					      txrx_work);
+	struct mt76_sdio *sdio = container_of(w, struct mt76_sdio,
+					      txrx_worker);
 	struct mt76_dev *dev = container_of(sdio, struct mt76_dev, sdio);
-	int i, nframes = 0;
-
-	/* tx */
-	for (i = 0; i < MT_TXQ_MCU_WA; i++) {
-		int ret;
-
-		ret = mt7663s_tx_run_queue(dev, i);
-		if (ret < 0)
-			break;
+	int i, nframes, ret;
 
-		nframes += ret;
-	}
-
-	/* rx */
-	nframes += mt7663s_rx_handler(dev);
+	do {
+		nframes = 0;
 
-	if (nframes)
-		queue_work(sdio->txrx_wq, &sdio->txrx_work);
+		/* tx */
+		for (i = 0; i < MT_TXQ_MCU_WA; i++) {
+			ret = mt7663s_tx_run_queue(dev, i);
+			if (ret > 0)
+				nframes += ret;
+		}
 
-	queue_work(sdio->txrx_wq, &sdio->status_work);
+		/* rx */
+		ret = mt7663s_rx_handler(dev);
+		if (ret > 0)
+			nframes += ret;
+	} while (nframes > 0);
 }
 
 void mt7663s_sdio_irq(struct sdio_func *func)
@@ -324,5 +323,5 @@ void mt7663s_sdio_irq(struct sdio_func *func)
 	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mt76.phy.state))
 		return;
 
-	queue_work(sdio->txrx_wq, &sdio->txrx_work);
+	mt76_worker_schedule(&sdio->txrx_worker);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 6eb75ffa9e0f..37e05ec40e1d 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -66,7 +66,6 @@ void mt76s_stop_txrx(struct mt76_dev *dev)
 {
 	struct mt76_sdio *sdio = &dev->sdio;
 
-	cancel_work_sync(&sdio->txrx_work);
 	cancel_work_sync(&sdio->status_work);
 	cancel_work_sync(&sdio->net_work);
 	cancel_work_sync(&sdio->stat_work);
@@ -256,7 +255,7 @@ static void mt76s_tx_kick(struct mt76_dev *dev, struct mt76_queue *q)
 {
 	struct mt76_sdio *sdio = &dev->sdio;
 
-	queue_work(sdio->txrx_wq, &sdio->txrx_work);
+	mt76_worker_schedule(&sdio->txrx_worker);
 }
 
 static const struct mt76_queue_ops sdio_queue_ops = {
@@ -303,6 +302,8 @@ void mt76s_deinit(struct mt76_dev *dev)
 	struct mt76_sdio *sdio = &dev->sdio;
 	int i;
 
+	mt76_worker_teardown(&sdio->txrx_worker);
+
 	mt76s_stop_txrx(dev);
 	if (sdio->txrx_wq) {
 		destroy_workqueue(sdio->txrx_wq);
-- 
2.26.2

