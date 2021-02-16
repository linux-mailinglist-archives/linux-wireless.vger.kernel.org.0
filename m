Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD37531CB6D
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Feb 2021 14:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhBPNwL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Feb 2021 08:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhBPNwH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Feb 2021 08:52:07 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7B8C061574
        for <linux-wireless@vger.kernel.org>; Tue, 16 Feb 2021 05:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=zM845YxmSMbum+vquotu5cgvnKD2fFxvJWzmKwwOrDs=; b=rh7JviUjQjQhQDg7LRPW0Gq9+L
        HGGJF+A3da7CbHhNztaEfjhBJo2Bv+eMDp8MSxdq9W2eNCBwn3s3LkR1ZI+7e6zET7ERObvgceQXB
        +EjqzEYIcTzxsgIY6Wfl2/hOoh7OLZ91Td9FlBkxJ7EmdEnBqEwLFSJanacVEvv/QPaM=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lC0l9-0004IS-DN; Tue, 16 Feb 2021 14:51:23 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org
Subject: [PATCH 5.12 1/2] mt76: fix tx skb error handling in mt76_dma_tx_queue_skb
Date:   Tue, 16 Feb 2021 14:51:18 +0100
Message-Id: <20210216135119.23809-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When running out of room in the tx queue after calling drv->tx_prepare_skb,
the buffer list will already have been modified on MT7615 and newer drivers.
This can leak a DMA mapping and will show up as swiotlb allocation failures
on x86.

Fix this by moving the queue length check further up. This is less accurate,
since it can overestimate the needed room in the queue on MT7615 and newer,
but the difference is small enough to not matter in practice.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 19098b852d0a..abdc8d364361 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -345,7 +345,6 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 	};
 	struct ieee80211_hw *hw;
 	int len, n = 0, ret = -ENOMEM;
-	struct mt76_queue_entry e;
 	struct mt76_txwi_cache *t;
 	struct sk_buff *iter;
 	dma_addr_t addr;
@@ -387,6 +386,11 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 	}
 	tx_info.nbuf = n;
 
+	if (q->queued + (tx_info.nbuf + 1) / 2 >= q->ndesc - 1) {
+		ret = -ENOMEM;
+		goto unmap;
+	}
+
 	dma_sync_single_for_cpu(dev->dev, t->dma_addr, dev->drv->txwi_size,
 				DMA_TO_DEVICE);
 	ret = dev->drv->tx_prepare_skb(dev, txwi, q->qid, wcid, sta, &tx_info);
@@ -395,11 +399,6 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 	if (ret < 0)
 		goto unmap;
 
-	if (q->queued + (tx_info.nbuf + 1) / 2 >= q->ndesc - 1) {
-		ret = -ENOMEM;
-		goto unmap;
-	}
-
 	return mt76_dma_add_buf(dev, q, tx_info.buf, tx_info.nbuf,
 				tx_info.info, tx_info.skb, t);
 
@@ -419,9 +418,7 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 	}
 #endif
 
-	e.skb = tx_info.skb;
-	e.txwi = t;
-	dev->drv->tx_complete_skb(dev, &e);
+	dev_kfree_skb(tx_info.skb);
 	mt76_put_txwi(dev, t);
 	return ret;
 }
-- 
2.28.0

