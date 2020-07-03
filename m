Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2656021360D
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2020 10:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgGCIQ2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jul 2020 04:16:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbgGCIQY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jul 2020 04:16:24 -0400
Received: from lore-desk.lan (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4F2920826;
        Fri,  3 Jul 2020 08:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593764184;
        bh=hLT7f5l4k+j2H6LNUi5+8UK20QT540jTjLjGrGNC3z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=swZoH92dnVswH/PiZFYTlCQHDp5mugF3m79jrJjWRB6Um21JDP6FHE3ndrsKfY3MO
         PGJDg+Km2UIVgRjsACNLYqs3HJOt7az9/OkwX3j89EU72xOc3LhwWyFi8YCOqel+Oi
         ltoAgMCX274FgKxZ9/N8CuW7PhabRG9tmtk20F3w=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 02/22] mt76: move mt76 worqueue in common code
Date:   Fri,  3 Jul 2020 10:15:41 +0200
Message-Id: <72055b8e6d15beb87d045acad234edb2cf24c6ad.1593763584.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593763584.git.lorenzo@kernel.org>
References: <cover.1593763584.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt76 worqueue from usb to common code in order to be reused adding
low-power support for mt7663 chipset

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 13 +++++++++++-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  4 ++--
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/usb.c   |  6 ++----
 .../net/wireless/mediatek/mt76/mt76x0/usb.c   |  6 ++----
 .../net/wireless/mediatek/mt76/mt76x2/usb.c   |  7 ++-----
 drivers/net/wireless/mediatek/mt76/usb.c      | 20 ++++---------------
 8 files changed, 26 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 10e6dbb64996..6aa3efa8f55e 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -437,6 +437,12 @@ mt76_alloc_device(struct device *pdev, unsigned int size,
 
 	tasklet_init(&dev->tx_tasklet, mt76_tx_tasklet, (unsigned long)dev);
 
+	dev->wq = alloc_ordered_workqueue("mt76", 0);
+	if (!dev->wq) {
+		ieee80211_free_hw(hw);
+		return NULL;
+	}
+
 	return dev;
 }
 EXPORT_SYMBOL_GPL(mt76_alloc_device);
@@ -490,7 +496,12 @@ EXPORT_SYMBOL_GPL(mt76_unregister_device);
 
 void mt76_free_device(struct mt76_dev *dev)
 {
-	mt76_tx_free(dev);
+	if (dev->wq) {
+		destroy_workqueue(dev->wq);
+		dev->wq = NULL;
+	}
+	if (mt76_is_mmio(dev))
+		mt76_tx_free(dev);
 	ieee80211_free_hw(dev->hw);
 }
 EXPORT_SYMBOL_GPL(mt76_free_device);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 0dc43e474976..f7be1d5f71a0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -424,7 +424,6 @@ struct mt76_usb {
 	u16 data_len;
 
 	struct tasklet_struct rx_tasklet;
-	struct workqueue_struct *wq;
 	struct work_struct stat_work;
 
 	u8 out_ep[__MT_EP_OUT_MAX];
@@ -623,6 +622,8 @@ struct mt76_dev {
 	struct mt76_testmode_data test;
 #endif
 
+	struct workqueue_struct *wq;
+
 	union {
 		struct mt76_mmio mmio;
 		struct mt76_usb usb;
@@ -1027,7 +1028,6 @@ int mt76u_vendor_request(struct mt76_dev *dev, u8 req,
 			 void *buf, size_t len);
 void mt76u_single_wr(struct mt76_dev *dev, const u8 req,
 		     const u16 offset, const u32 val);
-void mt76u_deinit(struct mt76_dev *dev);
 int mt76u_init(struct mt76_dev *dev, struct usb_interface *intf,
 	       bool ext);
 int mt76u_alloc_mcu_queue(struct mt76_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 9d74a6550cf0..c1a802366172 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -927,7 +927,7 @@ mt7615_mac_queue_rate_update(struct mt7615_phy *phy, struct mt7615_sta *sta,
 	mt7615_mac_update_rate_desc(phy, sta, probe_rate, rates,
 				    &wd->rate);
 	list_add_tail(&wd->node, &dev->wd_head);
-	queue_work(dev->mt76.usb.wq, &dev->wtbl_work);
+	queue_work(dev->mt76.wq, &dev->wtbl_work);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 3abb33ddab7d..3bcbd13c26d7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -319,7 +319,7 @@ mt7615_queue_key_update(struct mt7615_dev *dev, enum set_key_cmd cmd,
 	wd->key.cmd = cmd;
 
 	list_add_tail(&wd->node, &dev->wd_head);
-	queue_work(dev->mt76.usb.wq, &dev->wtbl_work);
+	queue_work(dev->mt76.wq, &dev->wtbl_work);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index 0ba28d37c414..f70a7d9d65e2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -349,11 +349,10 @@ static int mt7663u_probe(struct usb_interface *usb_intf,
 error_freeq:
 	mt76u_queues_deinit(&dev->mt76);
 error:
-	mt76u_deinit(&dev->mt76);
 	usb_set_intfdata(usb_intf, NULL);
 	usb_put_dev(interface_to_usbdev(usb_intf));
 
-	ieee80211_free_hw(mdev->hw);
+	mt76_free_device(&dev->mt76);
 
 	return ret;
 }
@@ -371,8 +370,7 @@ static void mt7663u_disconnect(struct usb_interface *usb_intf)
 	usb_set_intfdata(usb_intf, NULL);
 	usb_put_dev(interface_to_usbdev(usb_intf));
 
-	mt76u_deinit(&dev->mt76);
-	ieee80211_free_hw(dev->mt76.hw);
+	mt76_free_device(&dev->mt76);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index 5535b9c0632f..ce6b286a8152 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -277,9 +277,8 @@ static int mt76x0u_probe(struct usb_interface *usb_intf,
 err:
 	usb_set_intfdata(usb_intf, NULL);
 	usb_put_dev(interface_to_usbdev(usb_intf));
-	mt76u_deinit(&dev->mt76);
+	mt76_free_device(&dev->mt76);
 
-	ieee80211_free_hw(mdev->hw);
 	return ret;
 }
 
@@ -297,8 +296,7 @@ static void mt76x0_disconnect(struct usb_interface *usb_intf)
 	usb_set_intfdata(usb_intf, NULL);
 	usb_put_dev(interface_to_usbdev(usb_intf));
 
-	mt76u_deinit(&dev->mt76);
-	ieee80211_free_hw(dev->mt76.hw);
+	mt76_free_device(&dev->mt76);
 }
 
 static int __maybe_unused mt76x0_suspend(struct usb_interface *usb_intf,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index b27acf1bbc03..4e003c7b62cf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -75,8 +75,7 @@ static int mt76x2u_probe(struct usb_interface *intf,
 	return 0;
 
 err:
-	ieee80211_free_hw(mt76_hw(dev));
-	mt76u_deinit(&dev->mt76);
+	mt76_free_device(&dev->mt76);
 	usb_set_intfdata(intf, NULL);
 	usb_put_dev(udev);
 
@@ -92,9 +91,7 @@ static void mt76x2u_disconnect(struct usb_interface *intf)
 	set_bit(MT76_REMOVED, &dev->mphy.state);
 	ieee80211_unregister_hw(hw);
 	mt76x2u_cleanup(dev);
-	mt76u_deinit(&dev->mt76);
-
-	ieee80211_free_hw(hw);
+	mt76_free_device(&dev->mt76);
 	usb_set_intfdata(intf, NULL);
 	usb_put_dev(udev);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 0ff3096f7455..84e2fd0a4fc1 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -842,7 +842,7 @@ static void mt76u_tx_tasklet(unsigned long data)
 
 		if (dev->drv->tx_status_data &&
 		    !test_and_set_bit(MT76_READING_STATS, &dev->phy.state))
-			queue_work(dev->usb.wq, &dev->usb.stat_work);
+			queue_work(dev->wq, &dev->usb.stat_work);
 		if (wake)
 			ieee80211_wake_queue(dev->hw, i);
 	}
@@ -868,7 +868,7 @@ static void mt76u_tx_status_data(struct work_struct *work)
 	}
 
 	if (count && test_bit(MT76_STATE_RUNNING, &dev->phy.state))
-		queue_work(usb->wq, &usb->stat_work);
+		queue_work(dev->wq, &usb->stat_work);
 	else
 		clear_bit(MT76_READING_STATS, &dev->phy.state);
 }
@@ -1132,15 +1132,6 @@ static const struct mt76_queue_ops usb_queue_ops = {
 	.kick = mt76u_tx_kick,
 };
 
-void mt76u_deinit(struct mt76_dev *dev)
-{
-	if (dev->usb.wq) {
-		destroy_workqueue(dev->usb.wq);
-		dev->usb.wq = NULL;
-	}
-}
-EXPORT_SYMBOL_GPL(mt76u_deinit);
-
 int mt76u_init(struct mt76_dev *dev,
 	       struct usb_interface *intf, bool ext)
 {
@@ -1163,10 +1154,6 @@ int mt76u_init(struct mt76_dev *dev,
 	tasklet_init(&dev->tx_tasklet, mt76u_tx_tasklet, (unsigned long)dev);
 	INIT_WORK(&usb->stat_work, mt76u_tx_status_data);
 
-	usb->wq = alloc_workqueue("mt76u", WQ_UNBOUND, 0);
-	if (!usb->wq)
-		return -ENOMEM;
-
 	usb->data_len = usb_maxpacket(udev, usb_sndctrlpipe(udev, 0), 1);
 	if (usb->data_len < 32)
 		usb->data_len = 32;
@@ -1190,7 +1177,8 @@ int mt76u_init(struct mt76_dev *dev,
 	return 0;
 
 error:
-	mt76u_deinit(dev);
+	destroy_workqueue(dev->wq);
+
 	return err;
 }
 EXPORT_SYMBOL_GPL(mt76u_init);
-- 
2.26.2

