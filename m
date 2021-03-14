Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C8333A7AB
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Mar 2021 20:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbhCNTkz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 Mar 2021 15:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbhCNTkk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 Mar 2021 15:40:40 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B0DC061574
        for <linux-wireless@vger.kernel.org>; Sun, 14 Mar 2021 12:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0tEkhtKXTBfS4nBFdmHQ9qct736WB5pYRB9d7A9tax8=; b=IOHWdl3ceItPKzi91e/tFNP5Ps
        6m4x07wDJJmnQQTFaC2kzAEWVW/31Cn6oxwaQ8ypQG5HbSQqZJJ6ILCwz0eLU2gGsyRuj8B2SIg7P
        /fAXhjMMboRHU7PDqaTda4VoY35LSglAgLhgv3H96hu+OKAScBZAnFZSQNyQnDw6TWoY=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lLWbL-0001N9-K3
        for linux-wireless@vger.kernel.org; Sun, 14 Mar 2021 20:40:35 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: use threaded NAPI
Date:   Sun, 14 Mar 2021 20:40:23 +0100
Message-Id: <20210314194023.2412-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With threaded NAPI, the rx handler function is no longer bound to the CPU that
fired the interrupt, which significantly helps to spread the workload over
multiple CPUs, especially when multiple devices are using threaded NAPI at the
same time.
Exclude the tx handler from threaded NAPI by using a separate dummy netdev.
The work is small and short-lived enough that it makes more sense to run it in
softirq instead of creating a dedicated thread

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c          | 6 ++++--
 drivers/net/wireless/mediatek/mt76/mt76.h         | 1 +
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c   | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c   | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c   | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c   | 2 +-
 7 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 2f27c43ad76d..6273b2cfce4f 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -602,7 +602,6 @@ mt76_dma_rx_poll(struct napi_struct *napi, int budget)
 	dev = container_of(napi->dev, struct mt76_dev, napi_dev);
 	qid = napi - dev->napi;
 
-	local_bh_disable();
 	rcu_read_lock();
 
 	do {
@@ -612,7 +611,6 @@ mt76_dma_rx_poll(struct napi_struct *napi, int budget)
 	} while (cur && done < budget);
 
 	rcu_read_unlock();
-	local_bh_enable();
 
 	if (done < budget && napi_complete(napi))
 		dev->drv->rx_poll_complete(dev, qid);
@@ -626,6 +624,10 @@ mt76_dma_init(struct mt76_dev *dev)
 	int i;
 
 	init_dummy_netdev(&dev->napi_dev);
+	init_dummy_netdev(&dev->tx_napi_dev);
+	snprintf(dev->napi_dev.name, sizeof(dev->napi_dev.name), "%s",
+		 wiphy_name(dev->hw->wiphy));
+	dev->napi_dev.threaded = 1;
 
 	mt76_for_each_q_rx(dev, i) {
 		netif_napi_add(&dev->napi_dev, &dev->napi[i], mt76_dma_rx_poll,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 5d3438d86d2a..47d07fa4eca5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -631,6 +631,7 @@ struct mt76_dev {
 	struct mt76_mcu mcu;
 
 	struct net_device napi_dev;
+	struct net_device tx_napi_dev;
 	spinlock_t rx_lock;
 	struct napi_struct napi[__MT_RXQ_MAX];
 	struct sk_buff_head rx_skb[__MT_RXQ_MAX];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index 0086f18cb79a..2b6244116842 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -223,7 +223,7 @@ int mt7603_dma_init(struct mt7603_dev *dev)
 	if (ret)
 		return ret;
 
-	netif_tx_napi_add(&dev->mt76.napi_dev, &dev->mt76.tx_napi,
+	netif_tx_napi_add(&dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
 			  mt7603_poll_tx, NAPI_POLL_WEIGHT);
 	napi_enable(&dev->mt76.tx_napi);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index 25e3069cf2b1..2e3120eb2da9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -245,7 +245,7 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 	if (ret < 0)
 		return ret;
 
-	netif_tx_napi_add(&dev->mt76.napi_dev, &dev->mt76.tx_napi,
+	netif_tx_napi_add(&dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
 			  mt7615_poll_tx, NAPI_POLL_WEIGHT);
 	napi_enable(&dev->mt76.tx_napi);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index e7a46ac97f51..fc12824ab74e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -230,7 +230,7 @@ int mt76x02_dma_init(struct mt76x02_dev *dev)
 	if (ret)
 		return ret;
 
-	netif_tx_napi_add(&dev->mt76.napi_dev, &dev->mt76.tx_napi,
+	netif_tx_napi_add(&dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
 			  mt76x02_poll_tx, NAPI_POLL_WEIGHT);
 	napi_enable(&dev->mt76.tx_napi);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index bf51304a770b..3c961bf55e97 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -325,7 +325,7 @@ int mt7915_dma_init(struct mt7915_dev *dev)
 	if (ret < 0)
 		return ret;
 
-	netif_tx_napi_add(&dev->mt76.napi_dev, &dev->mt76.tx_napi,
+	netif_tx_napi_add(&dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
 			  mt7915_poll_tx, NAPI_POLL_WEIGHT);
 	napi_enable(&dev->mt76.tx_napi);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index cd9665610284..60de29a921a8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -299,7 +299,7 @@ int mt7921_dma_init(struct mt7921_dev *dev)
 	if (ret < 0)
 		return ret;
 
-	netif_tx_napi_add(&dev->mt76.napi_dev, &dev->mt76.tx_napi,
+	netif_tx_napi_add(&dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
 			  mt7921_poll_tx, NAPI_POLL_WEIGHT);
 	napi_enable(&dev->mt76.tx_napi);
 
-- 
2.30.1

