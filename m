Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED4EE76A1
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2019 17:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403772AbfJ1QiY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Oct 2019 12:38:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733084AbfJ1QiY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Oct 2019 12:38:24 -0400
Received: from localhost.localdomain.com (unknown [176.229.194.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 850F920717;
        Mon, 28 Oct 2019 16:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572280702;
        bh=Yz7KYZbCOe6uI59yda9EgTcgedQO2L0GoO8bwxpW27Q=;
        h=From:To:Cc:Subject:Date:From;
        b=oNfNcpw4lJn+ifoY4NzqC9MiDxzpNDlzk6fhPy0YoQqcMik2fn0BkNS0Z+eY+nu/A
         zmJ+udU37osHjbHxPQ4vTslvZQPMxvDWEd3VsQ8icqrbr01kbi4c2gPE2ggxKnZze1
         wbRWV+VsuO+DokLXm92pKQ/3yxal+Otwe3IsH4+Y=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sgruszka@redhat.com
Subject: [PATCH] mt76: mt76u: rely on a dedicated stats workqueue
Date:   Mon, 28 Oct 2019 17:38:05 +0100
Message-Id: <22f6f2caa55b11f4ccf3ee9adca339e5dcd51232.1572280127.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

rate controller and throughput are very sensitive to tx status timing.
In order to improve performances when the system is heavily loaded,
substitute stat_work delayed_work with a regular work_struct and create
a mt76u dedicated workqueue for tx status reporting

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  4 ++-
 .../net/wireless/mediatek/mt76/mt76x0/usb.c   |  2 ++
 .../net/wireless/mediatek/mt76/mt76x2/usb.c   |  2 ++
 drivers/net/wireless/mediatek/mt76/usb.c      | 27 ++++++++++++-------
 4 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index ccbc05d8e96d..5644df793450 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -390,7 +390,8 @@ struct mt76_usb {
 	};
 
 	struct tasklet_struct rx_tasklet;
-	struct delayed_work stat_work;
+	struct workqueue_struct *stat_wq;
+	struct work_struct stat_work;
 
 	u8 out_ep[__MT_EP_OUT_MAX];
 	u8 in_ep[__MT_EP_IN_MAX];
@@ -825,6 +826,7 @@ int mt76u_vendor_request(struct mt76_dev *dev, u8 req,
 void mt76u_single_wr(struct mt76_dev *dev, const u8 req,
 		     const u16 offset, const u32 val);
 int mt76u_init(struct mt76_dev *dev, struct usb_interface *intf);
+void mt76u_deinit(struct mt76_dev *dev);
 int mt76u_alloc_queues(struct mt76_dev *dev);
 void mt76u_stop_tx(struct mt76_dev *dev);
 void mt76u_stop_rx(struct mt76_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index b9fd41433106..a8ab8df075c3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -273,6 +273,7 @@ static int mt76x0u_probe(struct usb_interface *usb_intf,
 err:
 	usb_set_intfdata(usb_intf, NULL);
 	usb_put_dev(interface_to_usbdev(usb_intf));
+	mt76u_deinit(&dev->mt76);
 
 	ieee80211_free_hw(mdev->hw);
 	return ret;
@@ -292,6 +293,7 @@ static void mt76x0_disconnect(struct usb_interface *usb_intf)
 	usb_set_intfdata(usb_intf, NULL);
 	usb_put_dev(interface_to_usbdev(usb_intf));
 
+	mt76u_deinit(&dev->mt76);
 	ieee80211_free_hw(dev->mt76.hw);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index 48b9017813b5..b64ad816cc25 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -73,6 +73,7 @@ static int mt76x2u_probe(struct usb_interface *intf,
 
 err:
 	ieee80211_free_hw(mt76_hw(dev));
+	mt76u_deinit(&dev->mt76);
 	usb_set_intfdata(intf, NULL);
 	usb_put_dev(udev);
 
@@ -88,6 +89,7 @@ static void mt76x2u_disconnect(struct usb_interface *intf)
 	set_bit(MT76_REMOVED, &dev->mt76.state);
 	ieee80211_unregister_hw(hw);
 	mt76x2u_cleanup(dev);
+	mt76u_deinit(&dev->mt76);
 
 	ieee80211_free_hw(hw);
 	usb_set_intfdata(intf, NULL);
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index be19038ea7dd..d6d47081e281 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -697,10 +697,7 @@ static void mt76u_tx_tasklet(unsigned long data)
 		mt76_txq_schedule(dev, i);
 
 		if (!test_and_set_bit(MT76_READING_STATS, &dev->state))
-			ieee80211_queue_delayed_work(dev->hw,
-						     &dev->usb.stat_work,
-						     msecs_to_jiffies(10));
-
+			queue_work(dev->usb.stat_wq, &dev->usb.stat_work);
 		if (wake)
 			ieee80211_wake_queue(dev->hw, i);
 	}
@@ -713,7 +710,7 @@ static void mt76u_tx_status_data(struct work_struct *work)
 	u8 update = 1;
 	u16 count = 0;
 
-	usb = container_of(work, struct mt76_usb, stat_work.work);
+	usb = container_of(work, struct mt76_usb, stat_work);
 	dev = container_of(usb, struct mt76_dev, usb);
 
 	while (true) {
@@ -726,8 +723,7 @@ static void mt76u_tx_status_data(struct work_struct *work)
 	}
 
 	if (count && test_bit(MT76_STATE_RUNNING, &dev->state))
-		ieee80211_queue_delayed_work(dev->hw, &usb->stat_work,
-					     msecs_to_jiffies(10));
+		queue_work(usb->stat_wq, &usb->stat_work);
 	else
 		clear_bit(MT76_READING_STATS, &dev->state);
 }
@@ -908,7 +904,7 @@ void mt76u_stop_tx(struct mt76_dev *dev)
 		}
 	}
 
-	cancel_delayed_work_sync(&dev->usb.stat_work);
+	cancel_work_sync(&dev->usb.stat_work);
 	clear_bit(MT76_READING_STATS, &dev->state);
 
 	mt76_tx_status_check(dev, NULL, true);
@@ -959,9 +955,13 @@ int mt76u_init(struct mt76_dev *dev,
 
 	tasklet_init(&usb->rx_tasklet, mt76u_rx_tasklet, (unsigned long)dev);
 	tasklet_init(&dev->tx_tasklet, mt76u_tx_tasklet, (unsigned long)dev);
-	INIT_DELAYED_WORK(&usb->stat_work, mt76u_tx_status_data);
+	INIT_WORK(&usb->stat_work, mt76u_tx_status_data);
 	skb_queue_head_init(&dev->rx_skb[MT_RXQ_MAIN]);
 
+	usb->stat_wq = alloc_workqueue("mt76u", WQ_UNBOUND, 0);
+	if (!usb->stat_wq)
+		return -ENOMEM;
+
 	mutex_init(&usb->mcu.mutex);
 
 	mutex_init(&usb->usb_ctrl_mtx);
@@ -976,5 +976,14 @@ int mt76u_init(struct mt76_dev *dev,
 }
 EXPORT_SYMBOL_GPL(mt76u_init);
 
+void mt76u_deinit(struct mt76_dev *dev)
+{
+	if (dev->usb.stat_wq) {
+		destroy_workqueue(dev->usb.stat_wq);
+		dev->usb.stat_wq = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(mt76u_deinit);
+
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>");
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.21.0

