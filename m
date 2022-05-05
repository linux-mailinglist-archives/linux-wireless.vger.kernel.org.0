Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A634551BE39
	for <lists+linux-wireless@lfdr.de>; Thu,  5 May 2022 13:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358132AbiEELlw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 07:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358050AbiEELlv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 07:41:51 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353D835849
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 04:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=7a/5ztKicANfz0NmNFd1n6hvFL0Ir1pQgHefu892jMw=; b=RdeOJyAmI4Vi9q6TYx9L7p/jRG
        MI5lCMehYkVcqFS4+tEvMSzx1rPgg2nc6n9ZwM6SCIFZaxk9S1slkXj0YP6iZJjY0nk7hPlIwoTl9
        2jVWX5n5+DdnKy7JSVAHLkhX4dfubkf1bqCp45wA/yHYUXLU5r4v5HsgG28wfdeqjKpE=;
Received: from p200300daa70ef200412f484bca3869cd.dip0.t-ipconnect.de ([2003:da:a70e:f200:412f:484b:ca38:69cd] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nmZo9-0007Ts-CW
        for linux-wireless@vger.kernel.org; Thu, 05 May 2022 13:38:09 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/4] mt76: add support for overriding the device used for DMA mapping
Date:   Thu,  5 May 2022 13:37:27 +0200
Message-Id: <20220505113729.50380-2-nbd@nbd.name>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505113729.50380-1-nbd@nbd.name>
References: <20220505113729.50380-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

WED support requires using non-coherent DMA, whereas the PCI device might
be configured for coherent DMA.
The WED driver will take care of changing the PCI HIF coherent IO setting
on attach.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c      | 34 +++++++++----------
 drivers/net/wireless/mediatek/mt76/mac80211.c |  1 +
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 03d5beb1afdd..83787fc01e4e 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -24,7 +24,7 @@ mt76_alloc_txwi(struct mt76_dev *dev)
 	if (!txwi)
 		return NULL;
 
-	addr = dma_map_single(dev->dev, txwi, dev->drv->txwi_size,
+	addr = dma_map_single(dev->dma_dev, txwi, dev->drv->txwi_size,
 			      DMA_TO_DEVICE);
 	t = (struct mt76_txwi_cache *)(txwi + dev->drv->txwi_size);
 	t->dma_addr = addr;
@@ -78,7 +78,7 @@ mt76_free_pending_txwi(struct mt76_dev *dev)
 
 	local_bh_disable();
 	while ((t = __mt76_get_txwi(dev)) != NULL) {
-		dma_unmap_single(dev->dev, t->dma_addr, dev->drv->txwi_size,
+		dma_unmap_single(dev->dma_dev, t->dma_addr, dev->drv->txwi_size,
 				 DMA_TO_DEVICE);
 		kfree(mt76_get_txwi_ptr(dev, t));
 	}
@@ -127,7 +127,7 @@ mt76_dma_alloc_queue(struct mt76_dev *dev, struct mt76_queue *q,
 	q->hw_idx = idx;
 
 	size = q->ndesc * sizeof(struct mt76_desc);
-	q->desc = dmam_alloc_coherent(dev->dev, size, &q->desc_dma, GFP_KERNEL);
+	q->desc = dmam_alloc_coherent(dev->dma_dev, size, &q->desc_dma, GFP_KERNEL);
 	if (!q->desc)
 		return -ENOMEM;
 
@@ -209,11 +209,11 @@ mt76_dma_tx_cleanup_idx(struct mt76_dev *dev, struct mt76_queue *q, int idx,
 	struct mt76_queue_entry *e = &q->entry[idx];
 
 	if (!e->skip_buf0)
-		dma_unmap_single(dev->dev, e->dma_addr[0], e->dma_len[0],
+		dma_unmap_single(dev->dma_dev, e->dma_addr[0], e->dma_len[0],
 				 DMA_TO_DEVICE);
 
 	if (!e->skip_buf1)
-		dma_unmap_single(dev->dev, e->dma_addr[1], e->dma_len[1],
+		dma_unmap_single(dev->dma_dev, e->dma_addr[1], e->dma_len[1],
 				 DMA_TO_DEVICE);
 
 	if (e->txwi == DMA_DUMMY_DATA)
@@ -293,7 +293,7 @@ mt76_dma_get_buf(struct mt76_dev *dev, struct mt76_queue *q, int idx,
 	if (info)
 		*info = le32_to_cpu(desc->info);
 
-	dma_unmap_single(dev->dev, buf_addr, buf_len, DMA_FROM_DEVICE);
+	dma_unmap_single(dev->dma_dev, buf_addr, buf_len, DMA_FROM_DEVICE);
 	e->buf = NULL;
 
 	return buf;
@@ -330,9 +330,9 @@ mt76_dma_tx_queue_skb_raw(struct mt76_dev *dev, struct mt76_queue *q,
 	if (q->queued + 1 >= q->ndesc - 1)
 		goto error;
 
-	addr = dma_map_single(dev->dev, skb->data, skb->len,
+	addr = dma_map_single(dev->dma_dev, skb->data, skb->len,
 			      DMA_TO_DEVICE);
-	if (unlikely(dma_mapping_error(dev->dev, addr)))
+	if (unlikely(dma_mapping_error(dev->dma_dev, addr)))
 		goto error;
 
 	buf.addr = addr;
@@ -379,8 +379,8 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 		mt76_insert_hdr_pad(skb);
 
 	len = skb_headlen(skb);
-	addr = dma_map_single(dev->dev, skb->data, len, DMA_TO_DEVICE);
-	if (unlikely(dma_mapping_error(dev->dev, addr)))
+	addr = dma_map_single(dev->dma_dev, skb->data, len, DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(dev->dma_dev, addr)))
 		goto free;
 
 	tx_info.buf[n].addr = t->dma_addr;
@@ -392,9 +392,9 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 		if (n == ARRAY_SIZE(tx_info.buf))
 			goto unmap;
 
-		addr = dma_map_single(dev->dev, iter->data, iter->len,
+		addr = dma_map_single(dev->dma_dev, iter->data, iter->len,
 				      DMA_TO_DEVICE);
-		if (unlikely(dma_mapping_error(dev->dev, addr)))
+		if (unlikely(dma_mapping_error(dev->dma_dev, addr)))
 			goto unmap;
 
 		tx_info.buf[n].addr = addr;
@@ -407,10 +407,10 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 		goto unmap;
 	}
 
-	dma_sync_single_for_cpu(dev->dev, t->dma_addr, dev->drv->txwi_size,
+	dma_sync_single_for_cpu(dev->dma_dev, t->dma_addr, dev->drv->txwi_size,
 				DMA_TO_DEVICE);
 	ret = dev->drv->tx_prepare_skb(dev, txwi, q->qid, wcid, sta, &tx_info);
-	dma_sync_single_for_device(dev->dev, t->dma_addr, dev->drv->txwi_size,
+	dma_sync_single_for_device(dev->dma_dev, t->dma_addr, dev->drv->txwi_size,
 				   DMA_TO_DEVICE);
 	if (ret < 0)
 		goto unmap;
@@ -420,7 +420,7 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 
 unmap:
 	for (n--; n > 0; n--)
-		dma_unmap_single(dev->dev, tx_info.buf[n].addr,
+		dma_unmap_single(dev->dma_dev, tx_info.buf[n].addr,
 				 tx_info.buf[n].len, DMA_TO_DEVICE);
 
 free:
@@ -465,8 +465,8 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q)
 		if (!buf)
 			break;
 
-		addr = dma_map_single(dev->dev, buf, len, DMA_FROM_DEVICE);
-		if (unlikely(dma_mapping_error(dev->dev, addr))) {
+		addr = dma_map_single(dev->dma_dev, buf, len, DMA_FROM_DEVICE);
+		if (unlikely(dma_mapping_error(dev->dma_dev, addr))) {
 			skb_free_frag(buf);
 			break;
 		}
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 8a2fedbb1451..41e59f34f02a 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -545,6 +545,7 @@ mt76_alloc_device(struct device *pdev, unsigned int size,
 	dev->hw = hw;
 	dev->dev = pdev;
 	dev->drv = drv_ops;
+	dev->dma_dev = pdev;
 
 	phy = &dev->phy;
 	phy->dev = dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 62131010a0bb..9a2fc77243bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -698,6 +698,7 @@ struct mt76_dev {
 	const struct mt76_driver_ops *drv;
 	const struct mt76_mcu_ops *mcu_ops;
 	struct device *dev;
+	struct device *dma_dev;
 
 	struct mt76_mcu mcu;
 
-- 
2.35.1

