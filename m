Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0C6646D9E
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Dec 2022 11:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiLHKy1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Dec 2022 05:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiLHKxv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Dec 2022 05:53:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551AC5BD50
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 02:46:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0953BB82362
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 10:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F34C433D7;
        Thu,  8 Dec 2022 10:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670496405;
        bh=xi7WKKuTdh82x+2QsaCymr287/7I1FxDxzZHYMC72Mk=;
        h=From:To:Cc:Subject:Date:From;
        b=gwSjmMtACoj1YckcagVqmtfiHomn5cRAuUTFh5TJeVwg5z3tKe6IYMbri+2Sbgjes
         7vI6hJ2d/H1c0aBxWfckc3v4+IhXPs9zTjpRVgqlgD4voPnLm+bqLW5DQ3kFRl1WwP
         wPEV6u21r5dZH/L10Z1I12Q46UmNz/at82k6kvVx9HCVnBOGOm2NdZ2z6TSa4lTknp
         eqwg10mlVd2op9DIgxU3PfkWwHJouv0reb/7a0mW+mgWUDQvlEQL38E5ngAeZvREYv
         BjQEGWrjYfjzlq2nc45SuKRRMvFQnES0Pw7UsRJnH9eNbx7nD2g009iRy2Uze3fg+g
         sc1p7GBsrkx9g==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH v2] wifi: mt76: take into possible mt76_rx_token_consume failures
Date:   Thu,  8 Dec 2022 11:46:40 +0100
Message-Id: <a47ae789552e84aacf34a585e50ce06aea5076fd.1670496287.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Take into account possible error conditions of mt76_rx_token_consume
routine in mt7915_mmio_wed_init_rx_buf() and mt76_dma_add_buf()

Fixes: cd372b8c99c5 ("wifi: mt76: add WED RX support to mt76_dma_{add,get}_buf")
Fixes: 4f831d18d12d ("wifi: mt76: mt7915: enable WED RX support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- protect t configuration in mt76_rx_token_consume
---
 drivers/net/wireless/mediatek/mt76/dma.c         | 10 +++++++++-
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c |  7 +++++++
 drivers/net/wireless/mediatek/mt76/tx.c          |  7 ++++---
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index e017d7529c2a..e1527a5a0b4d 100644
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
2.38.1

