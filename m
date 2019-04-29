Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBD1E89F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 19:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfD2RRQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 13:17:16 -0400
Received: from nbd.name ([46.4.11.11]:37840 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728808AbfD2RRQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 13:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=A47yQWj5+ccSzjAwq/Na2ycCl8AouUQh4da/uFcYN0E=; b=f3e8IaUVgP7YDpPh+IAl6qc1vC
        i9EDquMZANp5Z0qaw9o98FJDR2B1k/DhFaD001y2cVvalwOH71E1WrsW5Mfvn6GAR9dRVSOvXJymb
        dDMfZw33Bn4o2VRfc4G7bQmFesKxer4hW2Zti5OCTc03ZLmkqWWwxe2twOyg6a1mQ+XI=;
Received: from p4ff135f1.dip0.t-ipconnect.de ([79.241.53.241] helo=maeck-2.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1hL9ty-0001E0-7r
        for linux-wireless@vger.kernel.org; Mon, 29 Apr 2019 19:17:14 +0200
Received: by maeck-2.local (Postfix, from userid 501)
        id 350215A4824F; Mon, 29 Apr 2019 19:17:12 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/4] mt76: mt76x02: remove irqsave/restore in locking for tx status fifo
Date:   Mon, 29 Apr 2019 19:17:10 +0200
Message-Id: <20190429171712.52983-2-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190429171712.52983-1-nbd@nbd.name>
References: <20190429171712.52983-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use a separate lock and spin_trylock to avoid disabling interrupts.
Should improve performance and latency

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76x02.h      | 1 +
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c  | 7 ++++---
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c | 1 +
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index cd37f44580ba..9f103c2506db 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -86,6 +86,7 @@ struct mt76x02_dev {
 
 	u8 txdone_seq;
 	DECLARE_KFIFO_PTR(txstatus_fifo, struct mt76x02_tx_status);
+	spinlock_t txstatus_fifo_lock;
 
 	struct sk_buff *rx_head;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 28851060aa0f..c1f041e1a279 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -739,7 +739,6 @@ int mt76x02_mac_process_rx(struct mt76x02_dev *dev, struct sk_buff *skb,
 void mt76x02_mac_poll_tx_status(struct mt76x02_dev *dev, bool irq)
 {
 	struct mt76x02_tx_status stat = {};
-	unsigned long flags;
 	u8 update = 1;
 	bool ret;
 
@@ -749,9 +748,11 @@ void mt76x02_mac_poll_tx_status(struct mt76x02_dev *dev, bool irq)
 	trace_mac_txstat_poll(dev);
 
 	while (!irq || !kfifo_is_full(&dev->txstatus_fifo)) {
-		spin_lock_irqsave(&dev->mt76.mmio.irq_lock, flags);
+		if (!spin_trylock(&dev->txstatus_fifo_lock))
+			break;
+
 		ret = mt76x02_mac_load_tx_status(dev, &stat);
-		spin_unlock_irqrestore(&dev->mt76.mmio.irq_lock, flags);
+		spin_unlock(&dev->txstatus_fifo_lock);
 
 		if (!ret)
 			break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 87e14af7a93b..5bc1b901f897 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -201,6 +201,7 @@ int mt76x02_dma_init(struct mt76x02_dev *dev)
 	tasklet_init(&dev->pre_tbtt_tasklet, mt76x02_pre_tbtt_tasklet,
 		     (unsigned long)dev);
 
+	spin_lock_init(&dev->txstatus_fifo_lock);
 	kfifo_init(&dev->txstatus_fifo, status_fifo, fifo_size);
 
 	mt76_dma_attach(&dev->mt76);
-- 
2.17.0

