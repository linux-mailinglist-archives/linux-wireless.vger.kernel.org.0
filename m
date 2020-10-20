Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFDB2937BC
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Oct 2020 11:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392623AbgJTJNY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Oct 2020 05:13:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392615AbgJTJNY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Oct 2020 05:13:24 -0400
Received: from lore-desk.redhat.com (unknown [151.66.125.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7591B2237B;
        Tue, 20 Oct 2020 09:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603185203;
        bh=LeQ9xVf9Pqhqee+tMsFU2dA9UvEhJsfyp1E5fbTI7LI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w2L1xWjjIZQTlMcvSOChv0UOwpoA41IhAdBlx1EfY2GiOjKHs94Z13zxz8noKmgr9
         1/a904C0vFeiU4yLwcAYaCY5PinLZlDBvSpciyYzVdaQ8Q+n6QQ6OT70SOHgSZ2cRp
         3spIcG3GLd/xK3fO/KylKuKiiIXkV16PQLGqtxho=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH 2/2] mt76: mt76u: use dedicated thread for status work
Date:   Tue, 20 Oct 2020 11:13:11 +0200
Message-Id: <0b680be5bc6d09f354a17cf6a8b43d05374cc795.1603184783.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603184783.git.lorenzo@kernel.org>
References: <cover.1603184783.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Split tx and status path in mt76-usb module relying on mt76 workers APIs

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h |  2 ++
 drivers/net/wireless/mediatek/mt76/usb.c  | 20 +++++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 7b78244057b8..cd60b47619f1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -430,7 +430,9 @@ struct mt76_usb {
 	u8 *data;
 	u16 data_len;
 
+	struct mt76_worker status_worker;
 	struct mt76_worker rx_worker;
+
 	struct work_struct stat_work;
 
 	u8 out_ep[__MT_EP_OUT_MAX];
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 63f55abede71..7396bdae6db0 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -805,9 +805,10 @@ int mt76u_resume_rx(struct mt76_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt76u_resume_rx);
 
-static void mt76u_tx_worker(struct mt76_worker *w)
+static void mt76u_status_worker(struct mt76_worker *w)
 {
-	struct mt76_dev *dev = container_of(w, struct mt76_dev, tx_worker);
+	struct mt76_usb *usb = container_of(w, struct mt76_usb, status_worker);
+	struct mt76_dev *dev = container_of(usb, struct mt76_dev, usb);
 	struct mt76_queue_entry entry;
 	struct mt76_queue *q;
 	bool wake;
@@ -833,7 +834,7 @@ static void mt76u_tx_worker(struct mt76_worker *w)
 		if (!q->queued)
 			wake_up(&dev->tx_wait);
 
-		mt76_txq_schedule(&dev->phy, i);
+		mt76_worker_schedule(&dev->tx_worker);
 
 		if (dev->drv->tx_status_data &&
 		    !test_and_set_bit(MT76_READING_STATS, &dev->phy.state))
@@ -877,7 +878,7 @@ static void mt76u_complete_tx(struct urb *urb)
 		dev_err(dev->dev, "tx urb failed: %d\n", urb->status);
 	e->done = true;
 
-	mt76_worker_schedule(&dev->tx_worker);
+	mt76_worker_schedule(&dev->usb.status_worker);
 }
 
 static int
@@ -1016,6 +1017,8 @@ static void mt76u_free_tx(struct mt76_dev *dev)
 {
 	int i;
 
+	mt76_worker_teardown(&dev->usb.status_worker);
+
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
 		struct mt76_queue *q;
 		int j;
@@ -1036,6 +1039,7 @@ void mt76u_stop_tx(struct mt76_dev *dev)
 	int ret;
 
 	mt76_worker_disable(&dev->tx_worker);
+	mt76_worker_disable(&dev->usb.status_worker);
 
 	ret = wait_event_timeout(dev->tx_wait, !mt76_has_tx_pending(&dev->phy),
 				 HZ / 5);
@@ -1074,6 +1078,7 @@ void mt76u_stop_tx(struct mt76_dev *dev)
 	clear_bit(MT76_READING_STATS, &dev->phy.state);
 
 	mt76_worker_enable(&dev->tx_worker);
+	mt76_worker_enable(&dev->usb.status_worker);
 
 	mt76_tx_status_check(dev, NULL, true);
 }
@@ -1124,7 +1129,6 @@ int mt76u_init(struct mt76_dev *dev,
 	mt76u_ops.rmw = ext ? mt76u_rmw_ext : mt76u_rmw;
 	mt76u_ops.write_copy = ext ? mt76u_copy_ext : mt76u_copy;
 
-	dev->tx_worker.fn = mt76u_tx_worker;
 	INIT_WORK(&usb->stat_work, mt76u_tx_status_data);
 
 	usb->data_len = usb_maxpacket(udev, usb_sndctrlpipe(udev, 0), 1);
@@ -1152,7 +1156,13 @@ int mt76u_init(struct mt76_dev *dev,
 	if (err)
 		return err;
 
+	err = mt76_worker_setup(dev->hw, &usb->status_worker,
+				mt76u_status_worker, "usb-status");
+	if (err)
+		return err;
+
 	sched_set_fifo_low(usb->rx_worker.task);
+	sched_set_fifo_low(usb->status_worker.task);
 
 	return 0;
 }
-- 
2.26.2

