Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4314E8A0
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 19:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbfD2RRR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 13:17:17 -0400
Received: from nbd.name ([46.4.11.11]:37844 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728845AbfD2RRQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 13:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=58jg9b3JFE6vsinzVI9WY30JCwnLez3VBIx3Q0ED2ng=; b=dmKOLXggjAhSdt+O4X2AwkJxTH
        FhUa3SH774iPhtX/8Mnnyv8ESw4is7RdjT3lx72fMY1RlXlMzlZY6M4hHKdvDbIS59xOvYXMH0wCd
        +vr0wp/wYrs48kUJGjqXCLhl4fLYMYWKM/KmhTYPlNpL2V9FmjS6S/57uqemm9BOXaMY=;
Received: from p4ff135f1.dip0.t-ipconnect.de ([79.241.53.241] helo=maeck-2.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1hL9ty-0001Dz-7A
        for linux-wireless@vger.kernel.org; Mon, 29 Apr 2019 19:17:14 +0200
Received: by maeck-2.local (Postfix, from userid 501)
        id 39EB45A48251; Mon, 29 Apr 2019 19:17:12 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/4] mt76: mt76x02: use napi polling for tx cleanup
Date:   Mon, 29 Apr 2019 19:17:09 +0200
Message-Id: <20190429171712.52983-1-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This allows tx scheduling and tx cleanup to run concurrently

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76x02.h  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c | 49 ++++++++++++++-----
 2 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index dfd3a4f1a624..cd37f44580ba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -89,7 +89,7 @@ struct mt76x02_dev {
 
 	struct sk_buff *rx_head;
 
-	struct tasklet_struct tx_tasklet;
+	struct napi_struct tx_napi;
 	struct tasklet_struct pre_tbtt_tasklet;
 	struct delayed_work cal_work;
 	struct delayed_work wdt_work;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 644706ab2893..87e14af7a93b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -154,18 +154,32 @@ static void mt76x02_process_tx_status_fifo(struct mt76x02_dev *dev)
 static void mt76x02_tx_tasklet(unsigned long data)
 {
 	struct mt76x02_dev *dev = (struct mt76x02_dev *)data;
-	int i;
 
+	mt76x02_mac_poll_tx_status(dev, false);
 	mt76x02_process_tx_status_fifo(dev);
 
+	mt76_txq_schedule_all(&dev->mt76);
+}
+
+int mt76x02_poll_tx(struct napi_struct *napi, int budget)
+{
+	struct mt76x02_dev *dev = container_of(napi, struct mt76x02_dev, tx_napi);
+	int i;
+
+	mt76x02_mac_poll_tx_status(dev, false);
+
 	for (i = MT_TXQ_MCU; i >= 0; i--)
 		mt76_queue_tx_cleanup(dev, i, false);
 
-	mt76x02_mac_poll_tx_status(dev, false);
+	if (napi_complete_done(napi, 0))
+		mt76x02_irq_enable(dev, MT_INT_TX_DONE_ALL);
 
-	mt76_txq_schedule_all(&dev->mt76);
+	for (i = MT_TXQ_MCU; i >= 0; i--)
+		mt76_queue_tx_cleanup(dev, i, false);
 
-	mt76x02_irq_enable(dev, MT_INT_TX_DONE_ALL);
+	tasklet_schedule(&dev->mt76.tx_tasklet);
+
+	return 0;
 }
 
 int mt76x02_dma_init(struct mt76x02_dev *dev)
@@ -223,7 +237,15 @@ int mt76x02_dma_init(struct mt76x02_dev *dev)
 	if (ret)
 		return ret;
 
-	return mt76_init_queues(dev);
+	ret = mt76_init_queues(dev);
+	if (ret)
+		return ret;
+
+	netif_tx_napi_add(&dev->mt76.napi_dev, &dev->tx_napi, mt76x02_poll_tx,
+			  NAPI_POLL_WEIGHT);
+	napi_enable(&dev->tx_napi);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(mt76x02_dma_init);
 
@@ -251,11 +273,6 @@ irqreturn_t mt76x02_irq_handler(int irq, void *dev_instance)
 
 	intr &= dev->mt76.mmio.irqmask;
 
-	if (intr & MT_INT_TX_DONE_ALL) {
-		mt76x02_irq_disable(dev, MT_INT_TX_DONE_ALL);
-		tasklet_schedule(&dev->mt76.tx_tasklet);
-	}
-
 	if (intr & MT_INT_RX_DONE(0)) {
 		mt76x02_irq_disable(dev, MT_INT_RX_DONE(0));
 		napi_schedule(&dev->mt76.napi[0]);
@@ -277,9 +294,12 @@ irqreturn_t mt76x02_irq_handler(int irq, void *dev_instance)
 			mt76_queue_kick(dev, dev->mt76.q_tx[MT_TXQ_PSD].q);
 	}
 
-	if (intr & MT_INT_TX_STAT) {
+	if (intr & MT_INT_TX_STAT)
 		mt76x02_mac_poll_tx_status(dev, true);
-		tasklet_schedule(&dev->mt76.tx_tasklet);
+
+	if (intr & (MT_INT_TX_STAT | MT_INT_TX_DONE_ALL)) {
+		mt76x02_irq_disable(dev, MT_INT_TX_DONE_ALL);
+		napi_schedule(&dev->tx_napi);
 	}
 
 	if (intr & MT_INT_GPTIMER) {
@@ -310,6 +330,7 @@ static void mt76x02_dma_enable(struct mt76x02_dev *dev)
 void mt76x02_dma_cleanup(struct mt76x02_dev *dev)
 {
 	tasklet_kill(&dev->mt76.tx_tasklet);
+	netif_napi_del(&dev->tx_napi);
 	mt76_dma_cleanup(&dev->mt76);
 }
 EXPORT_SYMBOL_GPL(mt76x02_dma_cleanup);
@@ -429,6 +450,7 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 
 	tasklet_disable(&dev->pre_tbtt_tasklet);
 	tasklet_disable(&dev->mt76.tx_tasklet);
+	napi_disable(&dev->tx_napi);
 
 	for (i = 0; i < ARRAY_SIZE(dev->mt76.napi); i++)
 		napi_disable(&dev->mt76.napi[i]);
@@ -482,7 +504,8 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 	clear_bit(MT76_RESET, &dev->mt76.state);
 
 	tasklet_enable(&dev->mt76.tx_tasklet);
-	tasklet_schedule(&dev->mt76.tx_tasklet);
+	napi_enable(&dev->tx_napi);
+	napi_schedule(&dev->tx_napi);
 
 	tasklet_enable(&dev->pre_tbtt_tasklet);
 
-- 
2.17.0

