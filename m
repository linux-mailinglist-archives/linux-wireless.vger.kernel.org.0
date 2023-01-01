Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8281465A9D5
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Jan 2023 12:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjAALsH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Jan 2023 06:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjAALsG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Jan 2023 06:48:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01D7DBB
        for <linux-wireless@vger.kernel.org>; Sun,  1 Jan 2023 03:48:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F882B8090B
        for <linux-wireless@vger.kernel.org>; Sun,  1 Jan 2023 11:48:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083C8C433EF;
        Sun,  1 Jan 2023 11:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672573683;
        bh=S0G26lHJ4nEHRIi/wZH0TX+M2XSCEowV/qoarZHzo8I=;
        h=From:To:Cc:Subject:Date:From;
        b=sQ3yTD5OhGpbIozsNkDQzA99l7IX/PW9fTYeqc/mAByMfEMGHtXEQ1916HQeTW05l
         Xi8j3oR0fEfEHQ9EUAUJycxql9WEkYz7Upv19ijqXPwATbwPS2AX9hJSZkj21i0MHh
         NW9Q65JN13cMYrduMVPui3MsyrSr1+/3MwabSWDn2Xl/N63oAMdjaupBd5sRHU5KhD
         JqB3A/TonIxL1rUO7+U7/HD0nDSzbneiG53bwCGVmCefhPqLKiATwcLbMk/vTUIgg3
         mmoFhxm1WouxiOO+0xinAEWqI5a2zoD70yn3yBz9HjShmgekrYukY3n8LwcqZ4Rw5l
         QEQWrYQuJzTeg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: dma: free rx_head in mt76_dma_rx_cleanup
Date:   Sun,  1 Jan 2023 12:47:57 +0100
Message-Id: <61199675f83238b44b670888bb1949ed36fef3b6.1672573630.git.lorenzo@kernel.org>
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

Free rx_head skb in mt76_dma_rx_cleanup routine in order to avoid
possible memory leak at module unload.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index f1368a6aed15..f1cb45c44a72 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -723,6 +723,7 @@ mt76_dma_rx_cleanup(struct mt76_dev *dev, struct mt76_queue *q)
 		return;
 
 	spin_lock_bh(&q->lock);
+
 	do {
 		buf = mt76_dma_dequeue(dev, q, true, NULL, NULL, &more, NULL);
 		if (!buf)
@@ -730,6 +731,12 @@ mt76_dma_rx_cleanup(struct mt76_dev *dev, struct mt76_queue *q)
 
 		skb_free_frag(buf);
 	} while (1);
+
+	if (q->rx_head) {
+		dev_kfree_skb(q->rx_head);
+		q->rx_head = NULL;
+	}
+
 	spin_unlock_bh(&q->lock);
 
 	if (!q->rx_page.va)
@@ -755,12 +762,6 @@ mt76_dma_rx_reset(struct mt76_dev *dev, enum mt76_rxq_id qid)
 	mt76_dma_rx_cleanup(dev, q);
 	mt76_dma_sync_idx(dev, q);
 	mt76_dma_rx_fill(dev, q);
-
-	if (!q->rx_head)
-		return;
-
-	dev_kfree_skb(q->rx_head);
-	q->rx_head = NULL;
 }
 
 static void
-- 
2.38.1

