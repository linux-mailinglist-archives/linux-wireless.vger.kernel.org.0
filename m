Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4B22937BB
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Oct 2020 11:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392618AbgJTJNW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Oct 2020 05:13:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391087AbgJTJNV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Oct 2020 05:13:21 -0400
Received: from lore-desk.redhat.com (unknown [151.66.125.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E757222C8;
        Tue, 20 Oct 2020 09:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603185201;
        bh=xcw1RJ5pbXz4mfkLF2PUODlN1LBg40B51B3zQsdsirE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R99vANLKQO0iLMLe0KuynIg+IG7xh4/tBkTkO3YSmV/QC4v3QFg4jv49BQT8bsEK4
         QQy0Oejh0NO7Ow6sF0wH/T39WFlYWmz6Wh9gxK93e+VFrqZt5HZosKusgY7NkkR+Vn
         tQlkSM10MKDY8m/r1mMFP1/iKX4vlAVhAcZFfx5k=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH 1/2] mt76: mt76u: rely on woker APIs for rx work
Date:   Tue, 20 Oct 2020 11:13:10 +0200
Message-Id: <dea19ecfc5e81a44dade841ed8f0193706fc2cab.1603184783.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603184783.git.lorenzo@kernel.org>
References: <cover.1603184783.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to improve parallelism, convert rx path in mt76-usb module to
mt76 workers APIs

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/usb.c   |  9 ++--
 .../net/wireless/mediatek/mt76/mt76x0/usb.c   |  1 +
 .../net/wireless/mediatek/mt76/mt76x2/usb.c   |  1 +
 drivers/net/wireless/mediatek/mt76/usb.c      | 48 ++++++++++++-------
 5 files changed, 39 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 64683eff76fa..7b78244057b8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -430,7 +430,7 @@ struct mt76_usb {
 	u8 *data;
 	u16 data_len;
 
-	struct tasklet_struct rx_tasklet;
+	struct mt76_worker rx_worker;
 	struct work_struct stat_work;
 
 	u8 out_ep[__MT_EP_OUT_MAX];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index f0ad83af9e00..a60cfa345521 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -126,21 +126,20 @@ static int mt7663u_probe(struct usb_interface *usb_intf,
 alloc_queues:
 	ret = mt76u_alloc_mcu_queue(&dev->mt76);
 	if (ret)
-		goto error_free_q;
+		goto error;
 
 	ret = mt76u_alloc_queues(&dev->mt76);
 	if (ret)
-		goto error_free_q;
+		goto error;
 
 	ret = mt7663_usb_sdio_register_device(dev);
 	if (ret)
-		goto error_free_q;
+		goto error;
 
 	return 0;
 
-error_free_q:
-	mt76u_queues_deinit(&dev->mt76);
 error:
+	mt76u_queues_deinit(&dev->mt76);
 	usb_set_intfdata(usb_intf, NULL);
 	usb_put_dev(interface_to_usbdev(usb_intf));
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index ce6b286a8152..b12cb17cb43d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -277,6 +277,7 @@ static int mt76x0u_probe(struct usb_interface *usb_intf,
 err:
 	usb_set_intfdata(usb_intf, NULL);
 	usb_put_dev(interface_to_usbdev(usb_intf));
+	mt76u_queues_deinit(&dev->mt76);
 	mt76_free_device(&dev->mt76);
 
 	return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index 4e003c7b62cf..2575369e44e2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -75,6 +75,7 @@ static int mt76x2u_probe(struct usb_interface *intf,
 	return 0;
 
 err:
+	mt76u_queues_deinit(&dev->mt76);
 	mt76_free_device(&dev->mt76);
 	usb_set_intfdata(intf, NULL);
 	usb_put_dev(udev);
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 911fb61dfab4..63f55abede71 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -627,7 +627,7 @@ static void mt76u_complete_rx(struct urb *urb)
 
 	q->head = (q->head + 1) % q->ndesc;
 	q->queued++;
-	tasklet_schedule(&dev->usb.rx_tasklet);
+	mt76_worker_schedule(&dev->usb.rx_worker);
 out:
 	spin_unlock_irqrestore(&q->lock, flags);
 }
@@ -665,13 +665,17 @@ mt76u_process_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 		}
 		mt76u_submit_rx_buf(dev, qid, urb);
 	}
-	if (qid == MT_RXQ_MAIN)
+	if (qid == MT_RXQ_MAIN) {
+		local_bh_disable();
 		mt76_rx_poll_complete(dev, MT_RXQ_MAIN, NULL);
+		local_bh_enable();
+	}
 }
 
-static void mt76u_rx_tasklet(struct tasklet_struct *t)
+static void mt76u_rx_worker(struct mt76_worker *w)
 {
-	struct mt76_dev *dev = from_tasklet(dev, t, usb.rx_tasklet);
+	struct mt76_usb *usb = container_of(w, struct mt76_usb, rx_worker);
+	struct mt76_dev *dev = container_of(usb, struct mt76_dev, usb);
 	int i;
 
 	rcu_read_lock();
@@ -737,8 +741,13 @@ mt76u_free_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 	struct page *page;
 	int i;
 
-	for (i = 0; i < q->ndesc; i++)
+	for (i = 0; i < q->ndesc; i++) {
+		if (!q->entry[i].urb)
+			continue;
+
 		mt76u_urb_free(q->entry[i].urb);
+		q->entry[i].urb = NULL;
+	}
 
 	if (!q->rx_page.va)
 		return;
@@ -752,6 +761,8 @@ static void mt76u_free_rx(struct mt76_dev *dev)
 {
 	int i;
 
+	mt76_worker_teardown(&dev->usb.rx_worker);
+
 	mt76_for_each_q_rx(dev, i)
 		mt76u_free_rx_queue(dev, &dev->q_rx[i]);
 }
@@ -760,6 +771,8 @@ void mt76u_stop_rx(struct mt76_dev *dev)
 {
 	int i;
 
+	mt76_worker_disable(&dev->usb.rx_worker);
+
 	mt76_for_each_q_rx(dev, i) {
 		struct mt76_queue *q = &dev->q_rx[i];
 		int j;
@@ -767,8 +780,6 @@ void mt76u_stop_rx(struct mt76_dev *dev)
 		for (j = 0; j < q->ndesc; j++)
 			usb_poison_urb(q->entry[j].urb);
 	}
-
-	tasklet_kill(&dev->usb.rx_tasklet);
 }
 EXPORT_SYMBOL_GPL(mt76u_stop_rx);
 
@@ -788,6 +799,8 @@ int mt76u_resume_rx(struct mt76_dev *dev)
 			return err;
 	}
 
+	mt76_worker_enable(&dev->usb.rx_worker);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mt76u_resume_rx);
@@ -1011,8 +1024,10 @@ static void mt76u_free_tx(struct mt76_dev *dev)
 		if (!q)
 			continue;
 
-		for (j = 0; j < q->ndesc; j++)
+		for (j = 0; j < q->ndesc; j++) {
 			usb_free_urb(q->entry[j].urb);
+			q->entry[j].urb = NULL;
+		}
 	}
 }
 
@@ -1102,7 +1117,7 @@ int mt76u_init(struct mt76_dev *dev,
 	};
 	struct usb_device *udev = interface_to_usbdev(intf);
 	struct mt76_usb *usb = &dev->usb;
-	int err = -ENOMEM;
+	int err;
 
 	mt76u_ops.rr = ext ? mt76u_rr_ext : mt76u_rr;
 	mt76u_ops.wr = ext ? mt76u_wr_ext : mt76u_wr;
@@ -1110,7 +1125,6 @@ int mt76u_init(struct mt76_dev *dev,
 	mt76u_ops.write_copy = ext ? mt76u_copy_ext : mt76u_copy;
 
 	dev->tx_worker.fn = mt76u_tx_worker;
-	tasklet_setup(&usb->rx_tasklet, mt76u_rx_tasklet);
 	INIT_WORK(&usb->stat_work, mt76u_tx_status_data);
 
 	usb->data_len = usb_maxpacket(udev, usb_sndctrlpipe(udev, 0), 1);
@@ -1119,7 +1133,7 @@ int mt76u_init(struct mt76_dev *dev,
 
 	usb->data = devm_kmalloc(dev->dev, usb->data_len, GFP_KERNEL);
 	if (!usb->data)
-		goto error;
+		return -ENOMEM;
 
 	mutex_init(&usb->usb_ctrl_mtx);
 	dev->bus = &mt76u_ops;
@@ -1131,14 +1145,16 @@ int mt76u_init(struct mt76_dev *dev,
 
 	err = mt76u_set_endpoints(intf, usb);
 	if (err < 0)
-		goto error;
+		return err;
 
-	return 0;
+	err = mt76_worker_setup(dev->hw, &usb->rx_worker, mt76u_rx_worker,
+				"usb-rx");
+	if (err)
+		return err;
 
-error:
-	destroy_workqueue(dev->wq);
+	sched_set_fifo_low(usb->rx_worker.task);
 
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(mt76u_init);
 
-- 
2.26.2

