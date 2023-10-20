Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7BE7D0D2D
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Oct 2023 12:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376855AbjJTKby (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Oct 2023 06:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376881AbjJTKbx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Oct 2023 06:31:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4976BD46
        for <linux-wireless@vger.kernel.org>; Fri, 20 Oct 2023 03:31:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FB6C433C9;
        Fri, 20 Oct 2023 10:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697797910;
        bh=YdZwi7PiVHPeDTOb8qJp4IGfc6Ab3P3P06xqpebgMOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PeQkqlkrKwhwOuMrgCDVdmzEk+/EMUkWdzasJzPNwzOLhONHsD9j0cg8Ok+8aTif8
         VwOytIPt52bPYtiif3eSVk2M0ZKEV0C9GFUAx1/SsatBdciHWBkyzdlnyI9W7UYqpX
         wpkhsl0iz02v7lK48mTGU9hs+gXKgciY4AFpuiLUtLrV/49qzQTYVVBOIsBhQlikJK
         zR45lGIKYQ3aZfFoCtzG6ZtvQSdZIdYxt7/NJ69bbcFnAXutjkPfUtSMQUdOXBwDbq
         iewNOmRoD49nxi4BFlKSNpudzUzb0EXTVyEBGUpjz66WL6WEP3k1Hz0xMJaEba9kL/
         OpnQSwS9REJig==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        shayne.chen@mediatek.com, Bo.Jiao@mediatek.com,
        sujuan.chen@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH v3 08/13] wifi: mt76: dma: introduce __mt76_dma_queue_reset utility routine
Date:   Fri, 20 Oct 2023 12:30:55 +0200
Message-ID: <df768b5e76729d8043eb3c04f5030726062698e6.1697797423.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697797422.git.lorenzo@kernel.org>
References: <cover.1697797422.git.lorenzo@kernel.org>
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

