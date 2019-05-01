Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C65A6108C3
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 16:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfEAOGe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 10:06:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbfEAOGd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 10:06:33 -0400
Received: from localhost.localdomain (unknown [151.66.22.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DC4B21670;
        Wed,  1 May 2019 14:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556719592;
        bh=ft9DkSlagNAv8BGOranG2XP9EUHY3mVrpunxf05NZVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OB4F3a0fBat3Zi7uAnh91C7EI0M/Zz0ql+4ANgKSTLRR2HVE6RaWFq46KXD/ynhD+
         YM4AsyNrzHEZajIAH/mP0AdJUu0CD7BFvn40W4Q6ukf867e5WVM/1OBzKjr/5Bt6y2
         2/eTWS54JzdSrWRh2qg0sY3vUJQ30xuxTiE2QHVE=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 2/4] mt76: mt7603: use napi polling for tx cleanup
Date:   Wed,  1 May 2019 16:06:21 +0200
Message-Id: <6fed513016d9afbec9f14bfbd6afe1c756cb0952.1556718795.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556718795.git.lorenzo@kernel.org>
References: <cover.1556718795.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This allows tx scheduling and tx cleanup to run concurrently

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7603/core.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/dma.c   | 30 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  4 ++-
 3 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/core.c b/drivers/net/wireless/mediatek/mt76/mt7603/core.c
index 37e5644b45ef..e7ee58e3379c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/core.c
@@ -35,7 +35,7 @@ irqreturn_t mt7603_irq_handler(int irq, void *dev_instance)
 
 	if (intr & MT_INT_TX_DONE_ALL) {
 		mt7603_irq_disable(dev, MT_INT_TX_DONE_ALL);
-		tasklet_schedule(&dev->mt76.tx_tasklet);
+		napi_schedule(&dev->mt76.tx_napi);
 	}
 
 	if (intr & MT_INT_RX_DONE(0)) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index 27e2d9f90553..54314f6803c5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -139,15 +139,30 @@ static void
 mt7603_tx_tasklet(unsigned long data)
 {
 	struct mt7603_dev *dev = (struct mt7603_dev *)data;
+
+	mt76_txq_schedule_all(&dev->mt76);
+}
+
+static int mt7603_poll_tx(struct napi_struct *napi, int budget)
+{
+	struct mt7603_dev *dev;
 	int i;
 
+	dev = container_of(napi, struct mt7603_dev, mt76.tx_napi);
 	dev->tx_dma_check = 0;
+
 	for (i = MT_TXQ_MCU; i >= 0; i--)
 		mt76_queue_tx_cleanup(dev, i, false);
 
-	mt76_txq_schedule_all(&dev->mt76);
+	if (napi_complete_done(napi, 0))
+		mt7603_irq_enable(dev, MT_INT_TX_DONE_ALL);
 
-	mt7603_irq_enable(dev, MT_INT_TX_DONE_ALL);
+	for (i = MT_TXQ_MCU; i >= 0; i--)
+		mt76_queue_tx_cleanup(dev, i, false);
+
+	tasklet_schedule(&dev->mt76.tx_tasklet);
+
+	return 0;
 }
 
 int mt7603_dma_init(struct mt7603_dev *dev)
@@ -216,7 +231,15 @@ int mt7603_dma_init(struct mt7603_dev *dev)
 		return ret;
 
 	mt76_wr(dev, MT_DELAY_INT_CFG, 0);
-	return mt76_init_queues(dev);
+	ret = mt76_init_queues(dev);
+	if (ret)
+		return ret;
+
+	netif_tx_napi_add(&dev->mt76.napi_dev, &dev->mt76.tx_napi,
+			  mt7603_poll_tx, NAPI_POLL_WEIGHT);
+	napi_enable(&dev->mt76.tx_napi);
+
+	return 0;
 }
 
 void mt7603_dma_cleanup(struct mt7603_dev *dev)
@@ -227,5 +250,6 @@ void mt7603_dma_cleanup(struct mt7603_dev *dev)
 		   MT_WPDMA_GLO_CFG_TX_WRITEBACK_DONE);
 
 	tasklet_kill(&dev->mt76.tx_tasklet);
+	netif_napi_del(&dev->mt76.tx_napi);
 	mt76_dma_cleanup(&dev->mt76);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 6d506e34c3ee..0ccba5926b68 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1282,6 +1282,7 @@ static void mt7603_mac_watchdog_reset(struct mt7603_dev *dev)
 	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 	napi_disable(&dev->mt76.napi[0]);
 	napi_disable(&dev->mt76.napi[1]);
+	napi_disable(&dev->mt76.tx_napi);
 
 	mutex_lock(&dev->mt76.mutex);
 
@@ -1326,7 +1327,8 @@ static void mt7603_mac_watchdog_reset(struct mt7603_dev *dev)
 	mutex_unlock(&dev->mt76.mutex);
 
 	tasklet_enable(&dev->mt76.tx_tasklet);
-	tasklet_schedule(&dev->mt76.tx_tasklet);
+	napi_enable(&dev->mt76.tx_napi);
+	napi_schedule(&dev->mt76.tx_napi);
 
 	tasklet_enable(&dev->mt76.pre_tbtt_tasklet);
 	mt7603_beacon_set_timer(dev, -1, beacon_int);
-- 
2.20.1

