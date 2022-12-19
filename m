Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FE6650737
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Dec 2022 05:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiLSEsW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Dec 2022 23:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLSEsT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Dec 2022 23:48:19 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB48DA1A5
        for <linux-wireless@vger.kernel.org>; Sun, 18 Dec 2022 20:48:11 -0800 (PST)
X-UUID: e1baa71bb333437b9c51a713a60d3c2d-20221219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=xGTZi6VmOFcWr4cuW00ZdwUqVgHtzUi+7zZ9/GhuAWY=;
        b=d9NVy6TC417SlhIWWbgd4RA9Kbyhtp1TOCE5PIqjF8yKOd/DCFzb3OUOV9BWBel08ACcbIT3WsUMKqiFPAuw/M07+KFVPRLDvge5FBw0FPCjx0ZxuSOylBQZdtfQyvzycLRH/OKmbgUqD3qPOpP56OpdSMCqJ1MxzhSLCAaNYnM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:a9f72236-872f-4029-ab8c-9e5312e8ee45,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:32ddb889-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e1baa71bb333437b9c51a713a60d3c2d-20221219
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1039234005; Mon, 19 Dec 2022 12:48:09 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 19 Dec 2022 12:48:08 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 19 Dec 2022 12:48:07 +0800
From:   Bo Jiao <bo.jiao@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH v2] wifi: mt76: fix potential memory leakage
Date:   Mon, 19 Dec 2022 12:48:04 +0800
Message-ID: <0a218783098a6b1b90ff120c7182acee93dc8feb.1671423784.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

fix potential memory leakage, recycle rxwi when mt76_dma_add_buf() call fail.

Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
---
v2:
- recycle rxwi when page_frag_alloc() and dma_map_single() fail.
---
 drivers/net/wireless/mediatek/mt76/dma.c | 27 ++++++++++++++----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index fc24b35..76ad47d 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -580,24 +580,29 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q)
 
 		buf = page_frag_alloc(&q->rx_page, q->buf_size, GFP_ATOMIC);
 		if (!buf)
-			break;
+			goto out;
 
 		addr = dma_map_single(dev->dma_dev, buf, len, DMA_FROM_DEVICE);
-		if (unlikely(dma_mapping_error(dev->dma_dev, addr))) {
-			skb_free_frag(buf);
-			break;
-		}
+		if (unlikely(dma_mapping_error(dev->dma_dev, addr)))
+			goto free;
 
 		qbuf.addr = addr + offset;
 		qbuf.len = len - offset;
 		qbuf.skip_unmap = false;
-		if (mt76_dma_add_buf(dev, q, &qbuf, 1, 0, buf, t) < 0) {
-			dma_unmap_single(dev->dma_dev, addr, len,
-					 DMA_FROM_DEVICE);
-			skb_free_frag(buf);
-			break;
-		}
+		if (mt76_dma_add_buf(dev, q, &qbuf, 1, 0, buf, t) < 0)
+			goto umap;
+
 		frames++;
+		continue;
+
+umap:
+		dma_unmap_single(dev->dma_dev, addr, len,
+				 DMA_FROM_DEVICE);
+free:
+		skb_free_frag(buf);
+out:
+		mt76_put_rxwi(dev, t);
+		break;
 	}
 
 	if (frames)
-- 
2.18.0

