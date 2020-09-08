Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FD92621D3
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 23:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgIHVSV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 17:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730170AbgIHVSG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 17:18:06 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E42C061798
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 14:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=CfEUROjDHSlEoQjQfI1PGM5bN7a4FgvYzEki3lddMqA=; b=ZKdwv5e0A5mPk62bHKoF4GwVxD
        Pd336LHUsEe+ND7vDR7GhrDOaxHRLJKapE+l7VhWfHD4f6Gord08MpOffYDbeIbScN+sbFTSku9P1
        AH0grdqLEG5FJMxUFz81bhfR+QwQ2lxCfdmWNAV/ekLCaFXhb+iA/FhfzZOG/GWAZvEI=;
Received: from p4ff13fcb.dip0.t-ipconnect.de ([79.241.63.203] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kFl03-0002Cx-W1
        for linux-wireless@vger.kernel.org; Tue, 08 Sep 2020 23:18:00 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 10/11] mt76: move txwi handling code to dma.c, since it is mmio specific
Date:   Tue,  8 Sep 2020 23:17:55 +0200
Message-Id: <20200908211756.15998-10-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908211756.15998-1-nbd@nbd.name>
References: <20200908211756.15998-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This way we can make some functions static

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c      | 72 +++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mac80211.c |  2 -
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 -
 drivers/net/wireless/mediatek/mt76/tx.c       | 69 ------------------
 4 files changed, 72 insertions(+), 73 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 38cc40c99ba1..214fc95b8a33 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -7,6 +7,76 @@
 #include "mt76.h"
 #include "dma.h"
 
+static struct mt76_txwi_cache *
+mt76_alloc_txwi(struct mt76_dev *dev)
+{
+	struct mt76_txwi_cache *t;
+	dma_addr_t addr;
+	u8 *txwi;
+	int size;
+
+	size = L1_CACHE_ALIGN(dev->drv->txwi_size + sizeof(*t));
+	txwi = devm_kzalloc(dev->dev, size, GFP_ATOMIC);
+	if (!txwi)
+		return NULL;
+
+	addr = dma_map_single(dev->dev, txwi, dev->drv->txwi_size,
+			      DMA_TO_DEVICE);
+	t = (struct mt76_txwi_cache *)(txwi + dev->drv->txwi_size);
+	t->dma_addr = addr;
+
+	return t;
+}
+
+static struct mt76_txwi_cache *
+__mt76_get_txwi(struct mt76_dev *dev)
+{
+	struct mt76_txwi_cache *t = NULL;
+
+	spin_lock(&dev->lock);
+	if (!list_empty(&dev->txwi_cache)) {
+		t = list_first_entry(&dev->txwi_cache, struct mt76_txwi_cache,
+				     list);
+		list_del(&t->list);
+	}
+	spin_unlock(&dev->lock);
+
+	return t;
+}
+
+static struct mt76_txwi_cache *
+mt76_get_txwi(struct mt76_dev *dev)
+{
+	struct mt76_txwi_cache *t = __mt76_get_txwi(dev);
+
+	if (t)
+		return t;
+
+	return mt76_alloc_txwi(dev);
+}
+
+void
+mt76_put_txwi(struct mt76_dev *dev, struct mt76_txwi_cache *t)
+{
+	if (!t)
+		return;
+
+	spin_lock(&dev->lock);
+	list_add(&t->list, &dev->txwi_cache);
+	spin_unlock(&dev->lock);
+}
+EXPORT_SYMBOL_GPL(mt76_put_txwi);
+
+static void
+mt76_free_pending_txwi(struct mt76_dev *dev)
+{
+	struct mt76_txwi_cache *t;
+
+	while ((t = __mt76_get_txwi(dev)) != NULL)
+		dma_unmap_single(dev->dev, t->dma_addr, dev->drv->txwi_size,
+				 DMA_TO_DEVICE);
+}
+
 static int
 mt76_dma_alloc_queue(struct mt76_dev *dev, struct mt76_queue *q,
 		     int idx, int n_desc, int bufsize,
@@ -598,5 +668,7 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
 		netif_napi_del(&dev->napi[i]);
 		mt76_dma_rx_cleanup(dev, &dev->q_rx[i]);
 	}
+
+	mt76_free_pending_txwi(dev);
 }
 EXPORT_SYMBOL_GPL(mt76_dma_cleanup);
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index c5946ebadc8a..3a6d15b73c06 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -515,8 +515,6 @@ void mt76_free_device(struct mt76_dev *dev)
 		destroy_workqueue(dev->wq);
 		dev->wq = NULL;
 	}
-	if (mt76_is_mmio(dev))
-		mt76_tx_free(dev);
 	ieee80211_free_hw(dev->hw);
 }
 EXPORT_SYMBOL_GPL(mt76_free_device);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 9dbb7dd65d23..9b191089defa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1005,8 +1005,6 @@ mt76_tx_status_get_hw(struct mt76_dev *dev, struct sk_buff *skb)
 	return hw;
 }
 
-void mt76_tx_free(struct mt76_dev *dev);
-struct mt76_txwi_cache *mt76_get_txwi(struct mt76_dev *dev);
 void mt76_put_txwi(struct mt76_dev *dev, struct mt76_txwi_cache *t);
 void mt76_rx_complete(struct mt76_dev *dev, struct sk_buff_head *frames,
 		      struct napi_struct *napi);
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 5914312d8944..007444385797 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -5,75 +5,6 @@
 
 #include "mt76.h"
 
-static struct mt76_txwi_cache *
-mt76_alloc_txwi(struct mt76_dev *dev)
-{
-	struct mt76_txwi_cache *t;
-	dma_addr_t addr;
-	u8 *txwi;
-	int size;
-
-	size = L1_CACHE_ALIGN(dev->drv->txwi_size + sizeof(*t));
-	txwi = devm_kzalloc(dev->dev, size, GFP_ATOMIC);
-	if (!txwi)
-		return NULL;
-
-	addr = dma_map_single(dev->dev, txwi, dev->drv->txwi_size,
-			      DMA_TO_DEVICE);
-	t = (struct mt76_txwi_cache *)(txwi + dev->drv->txwi_size);
-	t->dma_addr = addr;
-
-	return t;
-}
-
-static struct mt76_txwi_cache *
-__mt76_get_txwi(struct mt76_dev *dev)
-{
-	struct mt76_txwi_cache *t = NULL;
-
-	spin_lock_bh(&dev->lock);
-	if (!list_empty(&dev->txwi_cache)) {
-		t = list_first_entry(&dev->txwi_cache, struct mt76_txwi_cache,
-				     list);
-		list_del(&t->list);
-	}
-	spin_unlock_bh(&dev->lock);
-
-	return t;
-}
-
-struct mt76_txwi_cache *
-mt76_get_txwi(struct mt76_dev *dev)
-{
-	struct mt76_txwi_cache *t = __mt76_get_txwi(dev);
-
-	if (t)
-		return t;
-
-	return mt76_alloc_txwi(dev);
-}
-
-void
-mt76_put_txwi(struct mt76_dev *dev, struct mt76_txwi_cache *t)
-{
-	if (!t)
-		return;
-
-	spin_lock_bh(&dev->lock);
-	list_add(&t->list, &dev->txwi_cache);
-	spin_unlock_bh(&dev->lock);
-}
-EXPORT_SYMBOL_GPL(mt76_put_txwi);
-
-void mt76_tx_free(struct mt76_dev *dev)
-{
-	struct mt76_txwi_cache *t;
-
-	while ((t = __mt76_get_txwi(dev)) != NULL)
-		dma_unmap_single(dev->dev, t->dma_addr, dev->drv->txwi_size,
-				 DMA_TO_DEVICE);
-}
-
 static int
 mt76_txq_get_qid(struct ieee80211_txq *txq)
 {
-- 
2.28.0

