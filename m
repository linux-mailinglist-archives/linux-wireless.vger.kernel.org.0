Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30D1626A4F
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Nov 2022 16:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbiKLPlW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Nov 2022 10:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbiKLPlT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Nov 2022 10:41:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A001AF1D
        for <linux-wireless@vger.kernel.org>; Sat, 12 Nov 2022 07:41:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1649DB80835
        for <linux-wireless@vger.kernel.org>; Sat, 12 Nov 2022 15:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F78C433C1;
        Sat, 12 Nov 2022 15:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668267675;
        bh=JhYIpYjIjRyUHzK6O583UXEHVCKldM7Wmugn14/vtF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CItGD8wpuSEBWpYTqNRc8fCibuf2v0LtqW9z7ScedG7bLssbSd1OeKqPeNz8JDkM1
         sUw1t1Qskvv+PCO/VJocouxPsFzWsxuYsb9ofRNquflKYiu5JDvpG/mE2wIex2DJ0t
         gJ4L3boLdd0b/+LGMoViEeu5ACcKFpFczUhe80H96byGOI0qjgJF0uU1dDUmbMp5X0
         aJpejlFz+uakEqoT9TX4CScycnfbtSvicQdibosg0UG5Rz9UoEPefmz9mFo9/EWi3y
         NIagBpD21R6Op0P83mLBkj6VDmKwb84RXZJKfmpRixfFSaRQxSljw3AxCw66X+Vu8t
         OKjVwj0TC3nWA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Bo.Jiao@mediatek.com, sujuan.chen@mediatek.com,
        ryder.Lee@mediatek.com, evelyn.tsai@mediatek.com
Subject: [PATCH 3/8] wifi: mt76: add WED RX support to mt76_dma_rx_fill
Date:   Sat, 12 Nov 2022 16:40:36 +0100
Message-Id: <85669a3636966b2584355730bfbd11b79945876c.1668267241.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1668267241.git.lorenzo@kernel.org>
References: <cover.1668267241.git.lorenzo@kernel.org>
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

Introduce the capability to refill WED RX buffers in mt76_dma_rx_fill
utility routine.

Tested-by: Daniel Golle <daniel@makrotopia.org>
Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 33 +++++++++++++++++++-----
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 4239adde4cca..cb6e3b358aca 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -550,14 +550,26 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 	return ret;
 }
 
+static struct page_frag_cache *
+mt76_dma_rx_get_frag_cache(struct mt76_dev *dev, struct mt76_queue *q)
+{
+	struct page_frag_cache *rx_page = &q->rx_page;
+
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+	if ((q->flags & MT_QFLAG_WED) &&
+	    FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_RX)
+		rx_page = &dev->mmio.wed.rx_buf_ring.rx_page;
+#endif
+	return rx_page;
+}
+
 static int
 mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q)
 {
-	dma_addr_t addr;
-	void *buf;
-	int frames = 0;
+	struct page_frag_cache *rx_page = mt76_dma_rx_get_frag_cache(dev, q);
 	int len = SKB_WITH_OVERHEAD(q->buf_size);
-	int offset = q->buf_offset;
+	int frames = 0, offset = q->buf_offset;
+	dma_addr_t addr;
 
 	if (!q->ndesc)
 		return 0;
@@ -565,9 +577,18 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q)
 	spin_lock_bh(&q->lock);
 
 	while (q->queued < q->ndesc - 1) {
+		struct mt76_txwi_cache *t = NULL;
 		struct mt76_queue_buf qbuf;
+		void *buf = NULL;
+
+		if ((q->flags & MT_QFLAG_WED) &&
+		    FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_RX) {
+			t = mt76_get_rxwi(dev);
+			if (!t)
+				break;
+		}
 
-		buf = page_frag_alloc(&q->rx_page, q->buf_size, GFP_ATOMIC);
+		buf = page_frag_alloc(rx_page, q->buf_size, GFP_ATOMIC);
 		if (!buf)
 			break;
 
@@ -580,7 +601,7 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q)
 		qbuf.addr = addr + offset;
 		qbuf.len = len - offset;
 		qbuf.skip_unmap = false;
-		mt76_dma_add_buf(dev, q, &qbuf, 1, 0, buf, NULL);
+		mt76_dma_add_buf(dev, q, &qbuf, 1, 0, buf, t);
 		frames++;
 	}
 
-- 
2.38.1

