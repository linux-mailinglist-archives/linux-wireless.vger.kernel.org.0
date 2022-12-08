Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80697646EB9
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Dec 2022 12:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiLHLg1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Dec 2022 06:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiLHLg0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Dec 2022 06:36:26 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C7466C92
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 03:36:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 49606CE23CA
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 11:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6F3C433D6;
        Thu,  8 Dec 2022 11:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670499382;
        bh=NjWZRN0O23pDe1xY0JHljd7m2GmBKAosXf9S+WU0Xj0=;
        h=From:To:Cc:Subject:Date:From;
        b=CloaXQXZ7qXN4HaPT+HTSSPHvYd5jdwcbcKEPpUrVhEBE1a81gnvhNw4ClPUfwFNn
         cYwb0muPxTpwZIASWZ+FlBbLHXZ7fiqk2z5GM3+roVqCm3Tdl/VeyOuV+mn4XlaSGw
         ULU+9Z6R/dMVnpsnfZoYUfHBkv/+b/lvvBl1I86BzWbLwnlkCaxy28RbP0yV9qMq9h
         L5GbOWvpQlLmBD9BC30DiXi4W1EfiwHGK9RIi/A/Ok7XnKxNmzoeCjATXoM/3dVE6D
         RCJM2KSvcofhKtWF2qNXSDlExWpnOjlazr0c6xqjMb5rSX/ptPgRl9EuY7rXeTCDWg
         8lMZonmwfGTow==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: dma: rely on queue page_frag_cache for wed rx queues
Date:   Thu,  8 Dec 2022 12:36:10 +0100
Message-Id: <3ede6a1ea93cf81f458e6821306cc1db288fa89b.1670499296.git.lorenzo@kernel.org>
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

Since mt76_dma_rx_fill() acquires mt76_queue spinlock, rely on mt76_queue
page_frag_cache in mt76_dma_rx_fill() instead of wed rx_buf_ring
page_frag_cache. Get rid of mt76_dma_rx_get_frag_cache since it is no
longer used.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index e1527a5a0b4d..fc24b353acfc 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -554,23 +554,9 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 	return ret;
 }
 
-static struct page_frag_cache *
-mt76_dma_rx_get_frag_cache(struct mt76_dev *dev, struct mt76_queue *q)
-{
-	struct page_frag_cache *rx_page = &q->rx_page;
-
-#ifdef CONFIG_NET_MEDIATEK_SOC_WED
-	if ((q->flags & MT_QFLAG_WED) &&
-	    FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_RX)
-		rx_page = &dev->mmio.wed.rx_buf_ring.rx_page;
-#endif
-	return rx_page;
-}
-
 static int
 mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q)
 {
-	struct page_frag_cache *rx_page = mt76_dma_rx_get_frag_cache(dev, q);
 	int len = SKB_WITH_OVERHEAD(q->buf_size);
 	int frames = 0, offset = q->buf_offset;
 	dma_addr_t addr;
@@ -592,7 +578,7 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q)
 				break;
 		}
 
-		buf = page_frag_alloc(rx_page, q->buf_size, GFP_ATOMIC);
+		buf = page_frag_alloc(&q->rx_page, q->buf_size, GFP_ATOMIC);
 		if (!buf)
 			break;
 
-- 
2.38.1

