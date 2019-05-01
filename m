Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50196108C2
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 16:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfEAOGc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 10:06:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfEAOGb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 10:06:31 -0400
Received: from localhost.localdomain (unknown [151.66.22.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B4FB21743;
        Wed,  1 May 2019 14:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556719590;
        bh=YaixU8dB/mnDiuJ+ngfAeF9wmO27MDdGQ+9sQej3xqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sCRiOQ537ae3gRknJNL9LmQj/GZL3OkNNQZITHGWhqyk0knXtGj28UnY32bPv8LRs
         KH5r6Cp1NuIae2XQJ/Ua/IS37fAxo1q1P9ir+vEIus7pn2WFKmIPYq28/ahqaE/VRU
         PTacxiIQ5fvIdIpPjMxMso1RqVa4+NCB5CiAKifU=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 1/4] mt76: move tx_napi in mt76_dev
Date:   Wed,  1 May 2019 16:06:20 +0200
Message-Id: <284811c334edea1ec795d485b76cea928e0914d2.1556718795.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556718795.git.lorenzo@kernel.org>
References: <cover.1556718795.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move tx_napi in mt76_dev data structure in order to implement
concurrency between tx scheduling and tx cleanup in mt7603 and mt7615
drivers

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 drivers/net/wireless/mediatek/mt76/mt76x02.h  |  1 -
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c | 19 ++++++++++---------
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 8ecbf81a906f..fc4169c83e76 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -452,6 +452,7 @@ struct mt76_dev {
 	int tx_dma_idx[4];
 
 	struct tasklet_struct tx_tasklet;
+	struct napi_struct tx_napi;
 	struct delayed_work mac_work;
 
 	wait_queue_head_t tx_wait;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index 687bd14b2d77..f7fd53a1738a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -90,7 +90,6 @@ struct mt76x02_dev {
 
 	struct sk_buff *rx_head;
 
-	struct napi_struct tx_napi;
 	struct delayed_work cal_work;
 	struct delayed_work wdt_work;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 7b7163bc3b62..617934565818 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -166,7 +166,8 @@ static void mt76x02_tx_tasklet(unsigned long data)
 
 static int mt76x02_poll_tx(struct napi_struct *napi, int budget)
 {
-	struct mt76x02_dev *dev = container_of(napi, struct mt76x02_dev, tx_napi);
+	struct mt76x02_dev *dev = container_of(napi, struct mt76x02_dev,
+					       mt76.tx_napi);
 	int i;
 
 	mt76x02_mac_poll_tx_status(dev, false);
@@ -245,9 +246,9 @@ int mt76x02_dma_init(struct mt76x02_dev *dev)
 	if (ret)
 		return ret;
 
-	netif_tx_napi_add(&dev->mt76.napi_dev, &dev->tx_napi, mt76x02_poll_tx,
-			  NAPI_POLL_WEIGHT);
-	napi_enable(&dev->tx_napi);
+	netif_tx_napi_add(&dev->mt76.napi_dev, &dev->mt76.tx_napi,
+			  mt76x02_poll_tx, NAPI_POLL_WEIGHT);
+	napi_enable(&dev->mt76.tx_napi);
 
 	return 0;
 }
@@ -303,7 +304,7 @@ irqreturn_t mt76x02_irq_handler(int irq, void *dev_instance)
 
 	if (intr & (MT_INT_TX_STAT | MT_INT_TX_DONE_ALL)) {
 		mt76x02_irq_disable(dev, MT_INT_TX_DONE_ALL);
-		napi_schedule(&dev->tx_napi);
+		napi_schedule(&dev->mt76.tx_napi);
 	}
 
 	if (intr & MT_INT_GPTIMER) {
@@ -334,7 +335,7 @@ static void mt76x02_dma_enable(struct mt76x02_dev *dev)
 void mt76x02_dma_cleanup(struct mt76x02_dev *dev)
 {
 	tasklet_kill(&dev->mt76.tx_tasklet);
-	netif_napi_del(&dev->tx_napi);
+	netif_napi_del(&dev->mt76.tx_napi);
 	mt76_dma_cleanup(&dev->mt76);
 }
 EXPORT_SYMBOL_GPL(mt76x02_dma_cleanup);
@@ -454,7 +455,7 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 
 	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 	tasklet_disable(&dev->mt76.tx_tasklet);
-	napi_disable(&dev->tx_napi);
+	napi_disable(&dev->mt76.tx_napi);
 
 	for (i = 0; i < ARRAY_SIZE(dev->mt76.napi); i++)
 		napi_disable(&dev->mt76.napi[i]);
@@ -508,8 +509,8 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 	clear_bit(MT76_RESET, &dev->mt76.state);
 
 	tasklet_enable(&dev->mt76.tx_tasklet);
-	napi_enable(&dev->tx_napi);
-	napi_schedule(&dev->tx_napi);
+	napi_enable(&dev->mt76.tx_napi);
+	napi_schedule(&dev->mt76.tx_napi);
 
 	tasklet_enable(&dev->mt76.pre_tbtt_tasklet);
 
-- 
2.20.1

