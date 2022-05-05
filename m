Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9D151BE40
	for <lists+linux-wireless@lfdr.de>; Thu,  5 May 2022 13:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358341AbiEELmA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 07:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358100AbiEELlv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 07:41:51 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363014EF49
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 04:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=rtxPhpU+bMqsJ45E71PSj8ZuRYXipqHmHrgApLgb4lI=; b=pbunzW3AJ1XLSWnR8vdY0tLyJ2
        PKTkniap/4rxT3aTOCZCvaWm1IwIGVnnefJOmGC1NR7d3VviY5TrrxfSdhzLjuwYiqDhwc7O8njek
        xyRZOv5cxHq+A0Bo9c4NRQ8UeD7NVOPDj3XBKjWRVDIJ0f2FpLIuYYivzMTBqzEmkh5c=;
Received: from p200300daa70ef200412f484bca3869cd.dip0.t-ipconnect.de ([2003:da:a70e:f200:412f:484b:ca38:69cd] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nmZo9-0007Ts-5x
        for linux-wireless@vger.kernel.org; Thu, 05 May 2022 13:38:09 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/4] mt76: dma: add wrapper macro for accessing queue registers
Date:   Thu,  5 May 2022 13:37:26 +0200
Message-Id: <20220505113729.50380-1-nbd@nbd.name>
X-Mailer: git-send-email 2.35.1
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

Preparation for adding indirection used for Wireless Ethernet Dispatch support

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 09dc37bbf112..03d5beb1afdd 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -7,6 +7,10 @@
 #include "mt76.h"
 #include "dma.h"
 
+#define Q_READ(_dev, _q, _field)		readl(&(_q)->regs->_field)
+#define Q_WRITE(_dev, _q, _field, _val)		writel(_val, &(_q)->regs->_field)
+
+
 static struct mt76_txwi_cache *
 mt76_alloc_txwi(struct mt76_dev *dev)
 {
@@ -84,9 +88,9 @@ mt76_free_pending_txwi(struct mt76_dev *dev)
 static void
 mt76_dma_sync_idx(struct mt76_dev *dev, struct mt76_queue *q)
 {
-	writel(q->desc_dma, &q->regs->desc_base);
-	writel(q->ndesc, &q->regs->ring_size);
-	q->head = readl(&q->regs->dma_idx);
+	Q_WRITE(dev, q, desc_base, q->desc_dma);
+	Q_WRITE(dev, q, ring_size, q->ndesc);
+	q->head = Q_READ(dev, q, dma_idx);
 	q->tail = q->head;
 }
 
@@ -102,8 +106,8 @@ mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q)
 	for (i = 0; i < q->ndesc; i++)
 		q->desc[i].ctrl = cpu_to_le32(MT_DMA_CTL_DMA_DONE);
 
-	writel(0, &q->regs->cpu_idx);
-	writel(0, &q->regs->dma_idx);
+	Q_WRITE(dev, q, cpu_idx, 0);
+	Q_WRITE(dev, q, dma_idx, 0);
 	mt76_dma_sync_idx(dev, q);
 }
 
@@ -226,7 +230,7 @@ static void
 mt76_dma_kick_queue(struct mt76_dev *dev, struct mt76_queue *q)
 {
 	wmb();
-	writel(q->head, &q->regs->cpu_idx);
+	Q_WRITE(dev, q, cpu_idx, q->head);
 }
 
 static void
@@ -242,7 +246,7 @@ mt76_dma_tx_cleanup(struct mt76_dev *dev, struct mt76_queue *q, bool flush)
 	if (flush)
 		last = -1;
 	else
-		last = readl(&q->regs->dma_idx);
+		last = Q_READ(dev, q, dma_idx);
 
 	while (q->queued > 0 && q->tail != last) {
 		mt76_dma_tx_cleanup_idx(dev, q, q->tail, &entry);
@@ -254,8 +258,7 @@ mt76_dma_tx_cleanup(struct mt76_dev *dev, struct mt76_queue *q, bool flush)
 		}
 
 		if (!flush && q->tail == last)
-			last = readl(&q->regs->dma_idx);
-
+			last = Q_READ(dev, q, dma_idx);
 	}
 	spin_unlock_bh(&q->cleanup_lock);
 
-- 
2.35.1

