Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E93064637C
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 22:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiLGVuH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 16:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiLGVtu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 16:49:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359FF84DFC
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 13:49:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5BF461BA9
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 21:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67A7C433D6;
        Wed,  7 Dec 2022 21:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670449785;
        bh=JPyR7kJE0F9V4gJHkVVxoF2SCZqNKMoTORT5ZAfIvjA=;
        h=From:To:Cc:Subject:Date:From;
        b=bw6BFnLHV19ceU9vPPziu/Oi8y84RGW+IR6iJ1I0QuT+KZi4KvHrMXx8GGt8EZUaJ
         W9K9fZVFdowOXx6fTyMqKJ2N44S9uY7TGeG6ZVryoGgW2AZiAoTOzQq5ghkX5uObKD
         WsmP0Y7NVSpRYiDwqlaqrwARH2xcBdnJ16s9ef/VwPyYfkFJmPs1MSb35KDpAyZpGB
         0yjRuTYRMWytfbLU5OkWXsYQsoSCJgM1yemB2Qh86ywLs5IP/OchrKlBhmr2h/Xxin
         lhq98qMeZZX2VzTxiQl3cDPLW1ztIDPzIxagyZ5o5SHrmNuGICi949fkWVrbIvnWHh
         g1jzAk/PDToeQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: dma: do not increment queue head if mt76_dma_add_buf fails
Date:   Wed,  7 Dec 2022 22:49:31 +0100
Message-Id: <f310ce138445668315571e94ee92b932ed685194.1670448547.git.lorenzo@kernel.org>
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

Do not increment queue head if mt76_dma_add_buf fails for Wireless
Ethernet Dispatcher rx queues.

Fixes: cd372b8c99c5 ("wifi: mt76: add WED RX support to mt76_dma_{add,get}_buf")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 8dca8d2447b7..e017d7529c2a 100644
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
2.38.1

