Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFBD225792A
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 14:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgHaM0Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 08:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgHaM0K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 08:26:10 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD59DC061575
        for <linux-wireless@vger.kernel.org>; Mon, 31 Aug 2020 05:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=GtQX9gqQjNle0qBU4KJ7v/C8BCvdIGpnG43BHeIgBTs=; b=jGE6ae9N0fLOMkr4AnFjwaHy3m
        mUK0kbJoNGkQr6DzCYiFWgd2mceJHGPIyGXLuk5UJ4fw1Pm6DzhfrTIfSxmuBnRQBxfHmqydGdLVt
        cUE607w8ikABbSrmEsVH/Gj3NvGNWSyz9oOQi3oIKLxUuZg1yB7AQuNfzMLMKZOiIaU8=;
Received: from p4ff13fcb.dip0.t-ipconnect.de ([79.241.63.203] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kCiss-0000Ok-A3
        for linux-wireless@vger.kernel.org; Mon, 31 Aug 2020 14:26:02 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 5/9] mt76: remove swq from struct mt76_sw_queue
Date:   Mon, 31 Aug 2020 14:25:54 +0200
Message-Id: <20200831122558.1388-5-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200831122558.1388-1-nbd@nbd.name>
References: <20200831122558.1388-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since txq selection was moved to mac80211, it is no longer used

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76.h         | 1 -
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c   | 1 -
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c   | 2 --
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c | 1 -
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c   | 2 --
 drivers/net/wireless/mediatek/mt76/sdio.c         | 2 --
 drivers/net/wireless/mediatek/mt76/usb.c          | 2 --
 7 files changed, 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 6f4ced53284c..6cb69e87e8a7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -140,7 +140,6 @@ struct mt76_queue {
 struct mt76_sw_queue {
 	struct mt76_queue *q;
 
-	struct list_head swq;
 	int swq_queued;
 };
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index a08b85281170..fd54062f0517 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -19,7 +19,6 @@ mt7603_init_tx_queue(struct mt7603_dev *dev, struct mt76_sw_queue *q,
 	if (err < 0)
 		return err;
 
-	INIT_LIST_HEAD(&q->swq);
 	q->q = hwq;
 
 	mt7603_irq_enable(dev, MT_INT_TX_DONE(idx));
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index abb83d4e7712..5f0469b56a1a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -26,7 +26,6 @@ mt7615_init_tx_queue(struct mt7615_dev *dev, struct mt76_sw_queue *q,
 	if (err < 0)
 		return err;
 
-	INIT_LIST_HEAD(&q->swq);
 	q->q = hwq;
 
 	return 0;
@@ -84,7 +83,6 @@ mt7615_init_tx_queues(struct mt7615_dev *dev)
 
 	for (i = 1; i < MT_TXQ_MCU; i++) {
 		q = &dev->mt76.q_tx[i];
-		INIT_LIST_HEAD(&q->swq);
 		q->q = dev->mt76.q_tx[0].q;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index cfa3430110d8..a0a48c2160a9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -118,7 +118,6 @@ mt76x02_init_tx_queue(struct mt76x02_dev *dev, struct mt76_sw_queue *q,
 	if (err < 0)
 		return err;
 
-	INIT_LIST_HEAD(&q->swq);
 	q->q = hwq;
 
 	mt76x02_irq_enable(dev, MT_INT_TX_DONE(idx));
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 477d125ec5df..0904b94c90ff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -23,7 +23,6 @@ mt7915_init_tx_queues(struct mt7915_dev *dev, int n_desc)
 
 	for (i = 0; i < MT_TXQ_MCU; i++) {
 		q = &dev->mt76.q_tx[i];
-		INIT_LIST_HEAD(&q->swq);
 		q->q = hwq;
 	}
 
@@ -45,7 +44,6 @@ mt7915_init_mcu_queue(struct mt7915_dev *dev, struct mt76_sw_queue *q,
 	if (err < 0)
 		return err;
 
-	INIT_LIST_HEAD(&q->swq);
 	q->q = hwq;
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 326d9c59e8b5..e41037ac0867 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -42,8 +42,6 @@ static int mt76s_alloc_tx(struct mt76_dev *dev)
 	int i;
 
 	for (i = 0; i < MT_TXQ_MCU_WA; i++) {
-		INIT_LIST_HEAD(&dev->q_tx[i].swq);
-
 		q = devm_kzalloc(dev->dev, sizeof(*q), GFP_KERNEL);
 		if (!q)
 			return -ENOMEM;
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 730d17393c3f..14b93a0ef534 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -972,8 +972,6 @@ static int mt76u_alloc_tx(struct mt76_dev *dev)
 	int i, j, err;
 
 	for (i = 0; i <= MT_TXQ_PSD; i++) {
-		INIT_LIST_HEAD(&dev->q_tx[i].swq);
-
 		if (i >= IEEE80211_NUM_ACS) {
 			dev->q_tx[i].q = dev->q_tx[0].q;
 			continue;
-- 
2.28.0

