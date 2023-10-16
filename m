Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6B87CA398
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Oct 2023 11:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjJPJKS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Oct 2023 05:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbjJPJKQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Oct 2023 05:10:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115C6E8
        for <linux-wireless@vger.kernel.org>; Mon, 16 Oct 2023 02:10:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFD0C433C8;
        Mon, 16 Oct 2023 09:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697447414;
        bh=YdZwi7PiVHPeDTOb8qJp4IGfc6Ab3P3P06xqpebgMOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pAwkM7phcVLwa5w4DekhnR/7+SIxvjsHBQ3LUyf8lNDcLfWqUwAbiZ29ZwY1HRP1B
         kKwB+1sHraVl2+Q2CON2G8j2aWh6HE966sheMi4rncUR+kVMwXB79J3m6GtqTivLNz
         p8WziFvuzHC4qvAqnMKp7IEzrWFr4kU1UdbyygjuxQXs7sXK2Dqr7nxl5onr2u85s9
         Aft9KsOr9XVW0CnJhadHWmJD7w6PUZHwe4T8VZPdlJmhGTxB3oN9nkEQ3fOdg4VkIZ
         jH+k2pDgqRWDzUTfA+Yrpq8PHOT6yuPjv3jhbacLq8is31K5XAWVRR/XvWdzVR2UHj
         fIzE4Qpi3fcjw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        shayne.chen@mediatek.com, Bo.Jiao@mediatek.com,
        sujuan.chen@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH v2 08/12] wifi: mt76: dma: introduce __mt76_dma_queue_reset utility routine
Date:   Mon, 16 Oct 2023 11:03:41 +0200
Message-ID: <766391291f1b3f58635eb041d2a0139aaf57588b.1697445996.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697445995.git.lorenzo@kernel.org>
References: <cover.1697445995.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to introduce WED support for mt7996

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 64027572a5e6..7b622e966f58 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -195,7 +195,8 @@ mt76_dma_sync_idx(struct mt76_dev *dev, struct mt76_queue *q)
 }
 
 static void
-mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q)
+__mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q,
+		       bool reset_idx)
 {
 	int i;
 
@@ -206,11 +207,19 @@ mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q)
 	for (i = 0; i < q->ndesc; i++)
 		q->desc[i].ctrl = cpu_to_le32(MT_DMA_CTL_DMA_DONE);
 
-	Q_WRITE(q, cpu_idx, 0);
-	Q_WRITE(q, dma_idx, 0);
+	if (reset_idx) {
+		Q_WRITE(q, cpu_idx, 0);
+		Q_WRITE(q, dma_idx, 0);
+	}
 	mt76_dma_sync_idx(dev, q);
 }
 
+static void
+mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q)
+{
+	__mt76_dma_queue_reset(dev, q, true);
+}
+
 static int
 mt76_dma_add_rx_buf(struct mt76_dev *dev, struct mt76_queue *q,
 		    struct mt76_queue_buf *buf, void *data)
-- 
2.41.0

