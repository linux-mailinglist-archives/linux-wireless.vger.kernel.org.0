Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78FF010DE1A
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Nov 2019 16:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfK3PbD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Nov 2019 10:31:03 -0500
Received: from nbd.name ([46.4.11.11]:56040 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbfK3Pat (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Nov 2019 10:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=COE44juzF6vbvNzqNW/KM5qW1IA2aV2jOXTK0tMi4l8=; b=Zc+3RwbCZ/+s4v0Opjx4SS4DuR
        X79fyjsP5vJ/phiGY4aXzbF8f5DmC1fEAHJQ24zR2Ni07RJbJ0A+yu8tTT9CaymTPUTk6WjvE7F/m
        rccFLrs6bDt9q9kYvlbhzOpcnrdiUhrmgktTPgEAGK+AFYthCXu+TYgm7jsgRe9NCwnU=;
Received: from p5b2067e3.dip0.t-ipconnect.de ([91.32.103.227] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ib4hr-0006he-7N
        for linux-wireless@vger.kernel.org; Sat, 30 Nov 2019 16:30:47 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 09456721EBDF; Sat, 30 Nov 2019 16:30:45 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 01/29] mt76: move initialization of some struct members to mt76_alloc_device
Date:   Sat, 30 Nov 2019 16:30:17 +0100
Message-Id: <20191130153045.28105-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Reduces duplication and prepares for further rework

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c      | 1 -
 drivers/net/wireless/mediatek/mt76/mac80211.c | 8 ++++++--
 drivers/net/wireless/mediatek/mt76/usb.c      | 1 -
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 6173c80189ba..eed387b10d48 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -555,7 +555,6 @@ mt76_dma_init(struct mt76_dev *dev)
 		netif_napi_add(&dev->napi_dev, &dev->napi[i], mt76_dma_rx_poll,
 			       64);
 		mt76_dma_rx_fill(dev, &dev->q_rx[i]);
-		skb_queue_head_init(&dev->rx_skb[i]);
 		napi_enable(&dev->napi[i]);
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index b9f2a401041a..17e67267f71c 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -275,6 +275,7 @@ mt76_alloc_device(struct device *pdev, unsigned int size,
 {
 	struct ieee80211_hw *hw;
 	struct mt76_dev *dev;
+	int i;
 
 	hw = ieee80211_alloc_hw(size, ops);
 	if (!hw)
@@ -292,6 +293,11 @@ mt76_alloc_device(struct device *pdev, unsigned int size,
 	init_waitqueue_head(&dev->tx_wait);
 	skb_queue_head_init(&dev->status_list);
 
+	INIT_LIST_HEAD(&dev->txwi_cache);
+
+	for (i = 0; i < ARRAY_SIZE(dev->q_rx); i++)
+		skb_queue_head_init(&dev->rx_skb[i]);
+
 	tasklet_init(&dev->tx_tasklet, mt76_tx_tasklet, (unsigned long)dev);
 
 	return dev;
@@ -307,8 +313,6 @@ int mt76_register_device(struct mt76_dev *dev, bool vht,
 
 	dev_set_drvdata(dev->dev, dev);
 
-	INIT_LIST_HEAD(&dev->txwi_cache);
-
 	SET_IEEE80211_DEV(hw, dev->dev);
 	SET_IEEE80211_PERM_ADDR(hw, dev->macaddr);
 
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index d6d47081e281..3b9849b59571 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -956,7 +956,6 @@ int mt76u_init(struct mt76_dev *dev,
 	tasklet_init(&usb->rx_tasklet, mt76u_rx_tasklet, (unsigned long)dev);
 	tasklet_init(&dev->tx_tasklet, mt76u_tx_tasklet, (unsigned long)dev);
 	INIT_WORK(&usb->stat_work, mt76u_tx_status_data);
-	skb_queue_head_init(&dev->rx_skb[MT_RXQ_MAIN]);
 
 	usb->stat_wq = alloc_workqueue("mt76u", WQ_UNBOUND, 0);
 	if (!usb->stat_wq)
-- 
2.24.0

