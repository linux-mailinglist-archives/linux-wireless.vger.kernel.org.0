Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8DF669501
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jan 2023 12:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241200AbjAMLKF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Jan 2023 06:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241266AbjAMLJX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Jan 2023 06:09:23 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82CD7A39F
        for <linux-wireless@vger.kernel.org>; Fri, 13 Jan 2023 02:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=fJZJ7YkyOHW1illv8P3xo4zfjl0JMd6YMw3h/IN2w90=; b=DXF9UKjrXoTyYzuIJ+fi2kSywx
        h9f4NEjbE+qYEDq1ygkBnhs8j3KWVmy5jrVqlQbWFMACMkTfmjGqxFs6fYqsIdYKsIe8P3/a4mJxk
        tY7PChbsdsYT+sFDPa1MRF5BpXmrrRipZH9uzZp+bGZrAkSKcQbGdLFEuBwCtLNJWDnk=;
Received: from [37.59.164.104] (helo=localhost.localdomain)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pGHm2-00GQpV-Q8; Fri, 13 Jan 2023 11:59:02 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH wireless 2/3] wifi: mt76: handle possible mt76_rx_token_consume failures
Date:   Fri, 13 Jan 2023 11:58:47 +0100
Message-Id: <20230113105848.34642-2-nbd@nbd.name>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113105848.34642-1-nbd@nbd.name>
References: <20230113105848.34642-1-nbd@nbd.name>
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

Take into account possible error conditions of mt76_rx_token_consume
routine in mt7915_mmio_wed_init_rx_buf() and mt76_dma_add_buf()

Fixes: cd372b8c99c5 ("wifi: mt76: add WED RX support to mt76_dma_{add,get}_buf")
Fixes: 4f831d18d12d ("wifi: mt76: mt7915: enable WED RX support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
(cherry picked from commit 96f134dc19645be4994e89a2f68fa89309becbee)
---
 drivers/net/wireless/mediatek/mt76/dma.c         | 10 +++++++++-
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c |  7 +++++++
 drivers/net/wireless/mediatek/mt76/tx.c          |  7 ++++---
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index c058a02e9ba5..61a8ab9e1db5 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -234,6 +234,9 @@ mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_queue *q,
 
 			rx_token = mt76_rx_token_consume(dev, (void *)skb, t,
 							 buf[0].addr);
+			if (rx_token < 0)
+				return -ENOMEM;
+
 			buf1 |= FIELD_PREP(MT_DMA_CTL_TOKEN, rx_token);
 			ctrl = FIELD_PREP(MT_DMA_CTL_SD_LEN0, buf[0].len) |
 			       MT_DMA_CTL_TO_HOST;
@@ -602,7 +605,12 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q)
 		qbuf.addr = addr + offset;
 		qbuf.len = len - offset;
 		qbuf.skip_unmap = false;
-		mt76_dma_add_buf(dev, q, &qbuf, 1, 0, buf, t);
+		if (mt76_dma_add_buf(dev, q, &qbuf, 1, 0, buf, t) < 0) {
+			dma_unmap_single(dev->dma_dev, addr, len,
+					 DMA_FROM_DEVICE);
+			skb_free_frag(buf);
+			break;
+		}
 		frames++;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 0a95c3da241b..8388e2a65853 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -653,6 +653,13 @@ static u32 mt7915_mmio_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
 
 		desc->buf0 = cpu_to_le32(phy_addr);
 		token = mt76_rx_token_consume(&dev->mt76, ptr, t, phy_addr);
+		if (token < 0) {
+			dma_unmap_single(dev->mt76.dma_dev, phy_addr,
+					 wed->wlan.rx_size, DMA_TO_DEVICE);
+			skb_free_frag(ptr);
+			goto unmap;
+		}
+
 		desc->token |= cpu_to_le32(FIELD_PREP(MT_DMA_CTL_TOKEN,
 						      token));
 		desc++;
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 24568b98ed9d..1f309d05380a 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -764,11 +764,12 @@ int mt76_rx_token_consume(struct mt76_dev *dev, void *ptr,
 	spin_lock_bh(&dev->rx_token_lock);
 	token = idr_alloc(&dev->rx_token, t, 0, dev->rx_token_size,
 			  GFP_ATOMIC);
+	if (token >= 0) {
+		t->ptr = ptr;
+		t->dma_addr = phys;
+	}
 	spin_unlock_bh(&dev->rx_token_lock);
 
-	t->ptr = ptr;
-	t->dma_addr = phys;
-
 	return token;
 }
 EXPORT_SYMBOL_GPL(mt76_rx_token_consume);
-- 
2.39.0

