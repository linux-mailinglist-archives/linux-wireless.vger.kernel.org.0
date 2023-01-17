Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417B166DF84
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jan 2023 14:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjAQNyE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Jan 2023 08:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjAQNxj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Jan 2023 08:53:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E617D125B1
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 05:53:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1CBDB8163A
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 13:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D6EC433D2;
        Tue, 17 Jan 2023 13:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673963616;
        bh=nk+Re60RYHcCBiN7iaGHXgD9hFEjuZ/uY5jRwFwkFHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eqipFMRzcY9D3plcGsg6521Adlwl9oaNgujWuUvyaCHV4NYUU+8LjzSe7oNAKFKOs
         GAodNN+VLbDTUsW6ngPvPLG+rmczoDBPXFLbrlLZAYz8oVHH3B0/RrZYY384htuUYs
         ibmhW7ZOPoO9pVxS1fWBF/Ss71q43UtgkU1KitKdW2UtC3Y+SVRI+suZIJPrfWaRW/
         xSukEU7h1inis3Z5lpq98xR02zeRg3QNKPTmDyU09b5CfIquznoXGzwyNl/cABKQYX
         0id9Ll3h/pzWMrPchDsfIRWXRzO56p1nchWuM3K0tsLGVezrnNbGFyrZr5ta66aRax
         o4tym+HDjrXUw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH v2 1/4] wifi: mt76: mt7915: fix memory leak in mt7915_mmio_wed_init_rx_buf
Date:   Tue, 17 Jan 2023 14:53:14 +0100
Message-Id: <b68224ce9d47722fd46c14479c14d40df9cdc633.1673963374.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1673963374.git.lorenzo@kernel.org>
References: <cover.1673963374.git.lorenzo@kernel.org>
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
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index b96348002815..20efbf47110b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -637,9 +637,14 @@ static u32 mt7915_mmio_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
 		int token;
 		void *ptr;
 
+		if (!t)
+			goto unmap;
+
 		page = __dev_alloc_pages(GFP_KERNEL, get_order(length));
-		if (!page)
+		if (!page) {
+			mt76_put_rxwi(&dev->mt76, t);
 			goto unmap;
+		}
 
 		ptr = page_address(page);
 		phy_addr = dma_map_single(dev->mt76.dma_dev, ptr,
@@ -647,6 +652,7 @@ static u32 mt7915_mmio_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
 					  DMA_TO_DEVICE);
 		if (unlikely(dma_mapping_error(dev->mt76.dev, phy_addr))) {
 			__free_pages(page, get_order(length));
+			mt76_put_rxwi(&dev->mt76, t);
 			goto unmap;
 		}
 
@@ -656,6 +662,7 @@ static u32 mt7915_mmio_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
 			dma_unmap_single(dev->mt76.dma_dev, phy_addr,
 					 wed->wlan.rx_size, DMA_TO_DEVICE);
 			__free_pages(page, get_order(length));
+			mt76_put_rxwi(&dev->mt76, t);
 			goto unmap;
 		}
 
-- 
2.39.0

