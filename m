Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CBC65BF1F
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jan 2023 12:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjACLjP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Jan 2023 06:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237508AbjACLiy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Jan 2023 06:38:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BB7BEE
        for <linux-wireless@vger.kernel.org>; Tue,  3 Jan 2023 03:38:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 243F561290
        for <linux-wireless@vger.kernel.org>; Tue,  3 Jan 2023 11:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A9EC433D2;
        Tue,  3 Jan 2023 11:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672745930;
        bh=9d+ZA9+UUUJ7cVDHm3Lvj5TBD1ROiI4HuptlEBA5qGU=;
        h=From:To:Cc:Subject:Date:From;
        b=BzZg/Xz2o5rhf0z3/BwaPtcAIhWC5ZHY/a0hq9QXQ7d2Rezlhg+Ecn901XCHr8zk4
         vyfaH+0h0T6j13hmxvVw6/AweKVrbVuWEInOnC14fuz8+lTaxgA+somw9j9xdjZnDj
         cFviAFKDWctAW1LEqe0muZZt0yiKXM+zpgr690scSe387lZAOoxSIcpTP1EHJLxfZl
         mGzqThuNRxntQ4JQYNwRDY3d4GYdqmjFTbc9Z5htaFNr84aMnbZ9DwRaX5HttpDLes
         Uzp7jST8o/A6l+UZR0tzfK8GwRAKxgAOTzkdgj2VMJliAkS4zHyEK6CJ+5a621E16O
         yxI1AoN/gk6kg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7915: fix memory leak in mt7915_mmio_wed_init_rx_buf
Date:   Tue,  3 Jan 2023 12:38:39 +0100
Message-Id: <dc3c84f0ea8f9c7716fbd2619e69ac47cf277704.1672745677.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.0
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

Free mt76_txwi_cache pointer in mt7915_mmio_wed_init_rx_buf routine in
case of failure.

Fixes: 4f831d18d12d ("wifi: mt76: mt7915: enable WED RX support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
This patch is based of the following patch:
https://lore.kernel.org/linux-wireless/3a5bef05c0e70f1e13ff4b9cc3d6a62fca8dc810.1672574310.git.lorenzo@kernel.org/
---
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 757c2e25c25f..c0e7b30dfd48 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -628,9 +628,14 @@ static u32 mt7915_mmio_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
 		int token;
 		void *ptr;
 
+		if (!t)
+			goto unmap;
+
 		page = __dev_alloc_page(GFP_KERNEL);
-		if (!page)
+		if (!page) {
+			mt76_put_rxwi(&dev->mt76, t);
 			goto unmap;
+		}
 
 		ptr = page_address(page);
 		phy_addr = dma_map_single(dev->mt76.dma_dev, ptr,
@@ -638,6 +643,7 @@ static u32 mt7915_mmio_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
 					  DMA_TO_DEVICE);
 		if (unlikely(dma_mapping_error(dev->mt76.dev, phy_addr))) {
 			__free_page(page);
+			mt76_put_rxwi(&dev->mt76, t);
 			goto unmap;
 		}
 
@@ -647,6 +653,7 @@ static u32 mt7915_mmio_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
 			dma_unmap_single(dev->mt76.dma_dev, phy_addr,
 					 wed->wlan.rx_size, DMA_TO_DEVICE);
 			__free_page(page);
+			mt76_put_rxwi(&dev->mt76, t);
 			goto unmap;
 		}
 
-- 
2.39.0

