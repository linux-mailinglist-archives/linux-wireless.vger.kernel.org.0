Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657E764637F
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 22:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiLGVvc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 16:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLGVvb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 16:51:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB9270621
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 13:51:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3772B8212F
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 21:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1313FC433C1;
        Wed,  7 Dec 2022 21:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670449888;
        bh=dlHdYWGJsjUg75ZQBRpJqWnMzmWyqFhHCpWNbxWmtJc=;
        h=From:To:Cc:Subject:Date:From;
        b=q45SI8yBlEI9W5IiNFUOb0tFRpni4Xk3TrT7lPMrLRlYqwugbCh+DCjsx+9nxMyip
         z39I3jH13xDmYsH6wchrPVbjkkBS94/wLEQIwqtM1UWej8uLsrTweHv2ZbnhUQKV1N
         puk/GjCdH2uew5gDrxP5e8NymtKjMHPsBfpiydIynbeF2yG8PzjO/6nn+9/MWeG5P0
         ZEqRlS3Vkxlknrxqb9oHQ0b8N8ehIFA5ZUemxkZ46vxOqVo1ODCaQoSfeqJ9Zh3TmJ
         8snDPdvMkjjaq+J/PK+ShUKpbsT8tRpz6JikEpTF6dCVxTE7q5vfK3TvzVV4AdSLTM
         QEYpZqrjJ/o3w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: take into possible mt76_rx_token_consume failures
Date:   Wed,  7 Dec 2022 22:51:18 +0100
Message-Id: <22857067961409cc4873a7c8b7aa6f18e3dbb324.1670449810.git.lorenzo@kernel.org>
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
 drivers/net/wireless/mediatek/mt76/dma.c         | 10 +++++++++-
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c |  7 +++++++
 drivers/net/wireless/mediatek/mt76/tx.c          |  6 ++++--
 3 files changed, 20 insertions(+), 3 deletions(-)

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
index 24568b98ed9d..363d861a1d3e 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -766,8 +766,10 @@ int mt76_rx_token_consume(struct mt76_dev *dev, void *ptr,
 			  GFP_ATOMIC);
 	spin_unlock_bh(&dev->rx_token_lock);
 
-	t->ptr = ptr;
-	t->dma_addr = phys;
+	if (token >= 0) {
+		t->ptr = ptr;
+		t->dma_addr = phys;
+	}
 
 	return token;
 }
-- 
2.38.1

