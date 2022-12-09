Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A017E6484A7
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Dec 2022 16:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiLIPIE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Dec 2022 10:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiLIPHh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Dec 2022 10:07:37 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF98DF1
        for <linux-wireless@vger.kernel.org>; Fri,  9 Dec 2022 07:07:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 717AECE296E
        for <linux-wireless@vger.kernel.org>; Fri,  9 Dec 2022 15:07:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F777C433D2;
        Fri,  9 Dec 2022 15:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670598451;
        bh=Go1iCvpGf5EArbvavY1vUavUR6cKJOkJP1aZ66MvMZ8=;
        h=From:To:Cc:Subject:Date:From;
        b=fgHmmVZFOIDneTxBNyp2V34U15VnDnLpKJoe3fdTlQiLT51umemHcq58VQpLb4RpM
         42P/kVB4fklEpBSF+Bvu21Sa1lruE9SRJbDXeBe33xbMXVhmrtYdtqXzMjRI+J7gLP
         tQx6k1rkMGbrAfnFBMcCNHSKH1P+62p1m0kBRNpxhDG9rq+W2Q2aOEd5DmckMRdbRs
         uKr4VIuxWP5/HbGo7UBh3KrmWVusll5vbrWNsTIp1jKR6laS6YgXiXTTVl/crNmDYU
         AdcR2sZVVbxmKLmHxxP2uNySpw2uzPMuUF6h26eBmNNGQcpOUJ4Yi8EWeAwUoWnRyn
         Ug8CFRoDRNfYw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7915: get rid of wed rx_buf_ring page_frag_cache
Date:   Fri,  9 Dec 2022 16:07:22 +0100
Message-Id: <93c012b0ec130f28e71f31f2361d8131be6ca05a.1670598097.git.lorenzo@kernel.org>
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

Since wed rx_buf_ring page_frag_cache is no longer used in a hot path,
remove it and rely on page allocation APIs in
mt7915_mmio_wed_init_rx_buf() and mt7915_mmio_wed_release_rx_buf()

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  | 25 ++++++++-----------
 include/linux/soc/mediatek/mtk_wed.h          |  1 -
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 8388e2a65853..7ae5277922f3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -594,10 +594,13 @@ static void mt7915_mmio_wed_offload_disable(struct mtk_wed_device *wed)
 static void mt7915_mmio_wed_release_rx_buf(struct mtk_wed_device *wed)
 {
 	struct mt7915_dev *dev;
-	struct page *page;
+	u32 length;
 	int i;
 
 	dev = container_of(wed, struct mt7915_dev, mt76.mmio.wed);
+	length = SKB_DATA_ALIGN(NET_SKB_PAD + wed->wlan.rx_size +
+				sizeof(struct skb_shared_info));
+
 	for (i = 0; i < dev->mt76.rx_token_size; i++) {
 		struct mt76_txwi_cache *t;
 
@@ -607,18 +610,11 @@ static void mt7915_mmio_wed_release_rx_buf(struct mtk_wed_device *wed)
 
 		dma_unmap_single(dev->mt76.dma_dev, t->dma_addr,
 				 wed->wlan.rx_size, DMA_FROM_DEVICE);
-		skb_free_frag(t->ptr);
+		__free_pages(virt_to_page(t->ptr), get_order(length));
 		t->ptr = NULL;
 
 		mt76_put_rxwi(&dev->mt76, t);
 	}
-
-	if (!wed->rx_buf_ring.rx_page.va)
-		return;
-
-	page = virt_to_page(wed->rx_buf_ring.rx_page.va);
-	__page_frag_cache_drain(page, wed->rx_buf_ring.rx_page.pagecnt_bias);
-	memset(&wed->rx_buf_ring.rx_page, 0, sizeof(wed->rx_buf_ring.rx_page));
 }
 
 static u32 mt7915_mmio_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
@@ -635,19 +631,20 @@ static u32 mt7915_mmio_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
 	for (i = 0; i < size; i++) {
 		struct mt76_txwi_cache *t = mt76_get_rxwi(&dev->mt76);
 		dma_addr_t phy_addr;
+		struct page *page;
 		int token;
 		void *ptr;
 
-		ptr = page_frag_alloc(&wed->rx_buf_ring.rx_page, length,
-				      GFP_KERNEL);
-		if (!ptr)
+		page = __dev_alloc_pages(GFP_KERNEL, get_order(length));
+		if (!page)
 			goto unmap;
 
+		ptr = page_address(page);
 		phy_addr = dma_map_single(dev->mt76.dma_dev, ptr,
 					  wed->wlan.rx_size,
 					  DMA_TO_DEVICE);
 		if (unlikely(dma_mapping_error(dev->mt76.dev, phy_addr))) {
-			skb_free_frag(ptr);
+			__free_pages(page, get_order(length));
 			goto unmap;
 		}
 
@@ -656,7 +653,7 @@ static u32 mt7915_mmio_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
 		if (token < 0) {
 			dma_unmap_single(dev->mt76.dma_dev, phy_addr,
 					 wed->wlan.rx_size, DMA_TO_DEVICE);
-			skb_free_frag(ptr);
+			__free_pages(page, get_order(length));
 			goto unmap;
 		}
 
diff --git a/include/linux/soc/mediatek/mtk_wed.h b/include/linux/soc/mediatek/mtk_wed.h
index 8294978f4bca..98469ff88dad 100644
--- a/include/linux/soc/mediatek/mtk_wed.h
+++ b/include/linux/soc/mediatek/mtk_wed.h
@@ -100,7 +100,6 @@ struct mtk_wed_device {
 
 	struct {
 		int size;
-		struct page_frag_cache rx_page;
 		struct mtk_rxbm_desc *desc;
 		dma_addr_t desc_phys;
 	} rx_buf_ring;
-- 
2.38.1

