Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B93669500
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jan 2023 12:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241378AbjAMLKC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Jan 2023 06:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241264AbjAMLJX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Jan 2023 06:09:23 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F0D7A234
        for <linux-wireless@vger.kernel.org>; Fri, 13 Jan 2023 02:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=R9TLngDLbogCdvFiCuC6HiBlaUZd4cmETAgHFgK9oRE=; b=DpFsQzjUsZQrVeH4CaTXZzlCcG
        7kuPKMFq0DFGaqi64Xo3M6+p7NWKU0GQ8nde3Ik5k4IPSsisJAW9x9ve/i5CrnnJ6c+DkIw49669G
        j1qTISOSq1629osPcvhgaMamuwuMbO7ChlzC659+ivoqZ4cXPJsukyc7qp4wQaHtf9+w=;
Received: from [37.59.164.104] (helo=localhost.localdomain)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pGHm2-00GQpV-FQ; Fri, 13 Jan 2023 11:59:02 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH wireless 1/3] wifi: mt76: dma: do not increment queue head if mt76_dma_add_buf fails
Date:   Fri, 13 Jan 2023 11:58:46 +0100
Message-Id: <20230113105848.34642-1-nbd@nbd.name>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Do not increment queue head if mt76_dma_add_buf fails for Wireless
Ethernet Dispatcher rx queues.

Fixes: cd372b8c99c5 ("wifi: mt76: add WED RX support to mt76_dma_{add,get}_buf")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
(cherry picked from commit fe13dad8992be0b26c1be390bcd111acf9892c17)
---
 drivers/net/wireless/mediatek/mt76/dma.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index f795548562f5..c058a02e9ba5 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -212,14 +212,14 @@ mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_queue *q,
 {
 	struct mt76_queue_entry *entry;
 	struct mt76_desc *desc;
-	u32 ctrl;
 	int i, idx = -1;
+	u32 ctrl, next;
 
 	for (i = 0; i < nbufs; i += 2, buf += 2) {
 		u32 buf0 = buf[0].addr, buf1 = 0;
 
 		idx = q->head;
-		q->head = (q->head + 1) % q->ndesc;
+		next = (q->head + 1) % q->ndesc;
 
 		desc = &q->desc[idx];
 		entry = &q->entry[idx];
@@ -239,8 +239,8 @@ mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_queue *q,
 			       MT_DMA_CTL_TO_HOST;
 		} else {
 			if (txwi) {
-				q->entry[q->head].txwi = DMA_DUMMY_DATA;
-				q->entry[q->head].skip_buf0 = true;
+				q->entry[next].txwi = DMA_DUMMY_DATA;
+				q->entry[next].skip_buf0 = true;
 			}
 
 			if (buf[0].skip_unmap)
@@ -271,6 +271,7 @@ mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_queue *q,
 		WRITE_ONCE(desc->info, cpu_to_le32(info));
 		WRITE_ONCE(desc->ctrl, cpu_to_le32(ctrl));
 
+		q->head = next;
 		q->queued++;
 	}
 
-- 
2.39.0

