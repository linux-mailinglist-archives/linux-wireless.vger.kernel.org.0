Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8577A4E7B71
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Mar 2022 01:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbiCYVMT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 17:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbiCYVMR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 17:12:17 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB3A1FE55D
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 14:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Ocz9INSRRxyO45DVcCGrta8kUKQqY2wTq00b22fkyz4=; b=ubs1LDpyqOpe1pke0tVw0xlRQB
        Nd2yUIEB3HS9I2xNbWFTw1G0I3YddfYV+TfOxy7Wjp7S7h5mDwQXpNI6fXa6xL+R/DMcx5Be4hSpj
        mgxO9VPEV4UxrY37kaew/l7hCjNfDXWJUvU3XsgrlOF/66xprzAgFR0o9Sv/RV5mI3rc=;
Received: from p200300daa70ef200dc11dea3d730df97.dip0.t-ipconnect.de ([2003:da:a70e:f200:dc11:dea3:d730:df97] helo=Maecks.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nXrCi-0001fW-4K
        for linux-wireless@vger.kernel.org; Fri, 25 Mar 2022 22:10:40 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 5/8] mt76: dma: reduce lock contention in mt76_dma_tx_cleanup
Date:   Fri, 25 Mar 2022 22:10:28 +0100
Message-Id: <20220325211031.24171-5-nbd@nbd.name>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325211031.24171-1-nbd@nbd.name>
References: <20220325211031.24171-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Instead of taking q->lock for every single cleaned up frame, batch up to
16 cleaned up frames before taking it.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 26 +++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 09dc37bbf112..07065816262f 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -233,7 +233,9 @@ static void
 mt76_dma_tx_cleanup(struct mt76_dev *dev, struct mt76_queue *q, bool flush)
 {
 	struct mt76_queue_entry entry;
+	int done = 0;
 	int last;
+	int tail;
 
 	if (!q || !q->ndesc)
 		return;
@@ -244,21 +246,39 @@ mt76_dma_tx_cleanup(struct mt76_dev *dev, struct mt76_queue *q, bool flush)
 	else
 		last = readl(&q->regs->dma_idx);
 
-	while (q->queued > 0 && q->tail != last) {
+	tail = q->tail;
+	while (q->queued - done > 0 && tail != last) {
 		mt76_dma_tx_cleanup_idx(dev, q, q->tail, &entry);
-		mt76_queue_tx_complete(dev, q, &entry);
+		if (entry.skb)
+			dev->drv->tx_complete_skb(dev, &entry);
+		tail = (tail + 1) % q->ndesc;
+		done++;
 
 		if (entry.txwi) {
 			if (!(dev->drv->drv_flags & MT_DRV_TXWI_NO_FREE))
 				mt76_put_txwi(dev, entry.txwi);
 		}
 
-		if (!flush && q->tail == last)
+		if (!flush && tail == last)
 			last = readl(&q->regs->dma_idx);
 
+		if (done > 16) {
+			spin_lock_bh(&q->lock);
+			q->queued -= done;
+			q->tail = tail;
+			spin_unlock_bh(&q->lock);
+			done = 0;
+		}
 	}
 	spin_unlock_bh(&q->cleanup_lock);
 
+	if (done) {
+		spin_lock_bh(&q->lock);
+		q->queued -= done;
+		q->tail = tail;
+		spin_unlock_bh(&q->lock);
+	}
+
 	if (flush) {
 		spin_lock_bh(&q->lock);
 		mt76_dma_sync_idx(dev, q);
-- 
2.35.1

