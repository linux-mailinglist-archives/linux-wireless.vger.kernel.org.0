Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15D261572EF
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2020 11:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgBJKg7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Feb 2020 05:36:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:43894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgBJKg6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Feb 2020 05:36:58 -0500
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ED792070A;
        Mon, 10 Feb 2020 10:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581331018;
        bh=sZHYWkOp+HpJrdiA6bwXedKA/ws+5LJQFWQCJzF7EMw=;
        h=From:To:Cc:Subject:Date:From;
        b=1VywAghDCJm4m9uw3laytK91HzjsEx7Y1jmEBHB7im8eLsx7Mbe5VvQyOekIJBu4Y
         DYiYEJJiirixnCXa8l1nJhjw7w7ThlxQmfdKXJLe9sF5wb1RLn2v7UK8mI9FCa03hZ
         QO0iU7gjYaMM0gKxzCw1umB7V3Mc8bYZSD9FEuGU=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt76u: rename stat_wq in wq
Date:   Mon, 10 Feb 2020 11:36:48 +0100
Message-Id: <edb15e7a2dceb97a0db87839109ad633ee29f6d6.1581330917.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rename usb stat_wq in wq in order to be reused not just for gathering hw
tx statistics

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h |  2 +-
 drivers/net/wireless/mediatek/mt76/usb.c  | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 8a4445778ec7..1235432aeedf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -408,7 +408,7 @@ struct mt76_usb {
 	u16 data_len;
 
 	struct tasklet_struct rx_tasklet;
-	struct workqueue_struct *stat_wq;
+	struct workqueue_struct *wq;
 	struct work_struct stat_work;
 
 	u8 out_ep[__MT_EP_OUT_MAX];
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 90b55ffacf68..36ba81d63f12 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -852,7 +852,7 @@ static void mt76u_tx_tasklet(unsigned long data)
 
 		if (dev->drv->tx_status_data &&
 		    !test_and_set_bit(MT76_READING_STATS, &dev->phy.state))
-			queue_work(dev->usb.stat_wq, &dev->usb.stat_work);
+			queue_work(dev->usb.wq, &dev->usb.stat_work);
 		if (wake)
 			ieee80211_wake_queue(dev->hw, i);
 	}
@@ -878,7 +878,7 @@ static void mt76u_tx_status_data(struct work_struct *work)
 	}
 
 	if (count && test_bit(MT76_STATE_RUNNING, &dev->phy.state))
-		queue_work(usb->stat_wq, &usb->stat_work);
+		queue_work(usb->wq, &usb->stat_work);
 	else
 		clear_bit(MT76_READING_STATS, &dev->phy.state);
 }
@@ -1132,9 +1132,9 @@ static const struct mt76_queue_ops usb_queue_ops = {
 
 void mt76u_deinit(struct mt76_dev *dev)
 {
-	if (dev->usb.stat_wq) {
-		destroy_workqueue(dev->usb.stat_wq);
-		dev->usb.stat_wq = NULL;
+	if (dev->usb.wq) {
+		destroy_workqueue(dev->usb.wq);
+		dev->usb.wq = NULL;
 	}
 }
 EXPORT_SYMBOL_GPL(mt76u_deinit);
@@ -1160,8 +1160,8 @@ int mt76u_init(struct mt76_dev *dev,
 	tasklet_init(&dev->tx_tasklet, mt76u_tx_tasklet, (unsigned long)dev);
 	INIT_WORK(&usb->stat_work, mt76u_tx_status_data);
 
-	usb->stat_wq = alloc_workqueue("mt76u", WQ_UNBOUND, 0);
-	if (!usb->stat_wq)
+	usb->wq = alloc_workqueue("mt76u", WQ_UNBOUND, 0);
+	if (!usb->wq)
 		return -ENOMEM;
 
 	usb->data_len = usb_maxpacket(udev, usb_sndctrlpipe(udev, 0), 1);
-- 
2.24.1

