Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB7669EEC0
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Feb 2023 07:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjBVG15 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Feb 2023 01:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBVG14 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Feb 2023 01:27:56 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686357AA8
        for <linux-wireless@vger.kernel.org>; Tue, 21 Feb 2023 22:27:54 -0800 (PST)
X-UUID: 065c851ab27a11eda06fc9ecc4dadd91-20230222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=NSMT0lcm6EAxxPcbyBTH5y2LsNF1ot+Tk8/CJS2AGO0=;
        b=XP9WfvZKdb/U8PFceFHBml6410lkajJv4fSyPe8zU9KeJE+ceS/KAutwuAmXb8LUBsgorQ/T00G75VArUCl437sKw/Iw8TkO9mouZtGQPO0FuGqWegAyqap4QRbXxWXc/2Qi9fc+zoP3Sn/UrL9geg6nCbOvR5pHjULPxj/HYY0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:2d9aa0ae-153f-4b32-9424-d0af941e4a15,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:25b5999,CLOUDID:10da5426-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 065c851ab27a11eda06fc9ecc4dadd91-20230222
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <sujuan.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1848919654; Wed, 22 Feb 2023 14:27:48 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 22 Feb 2023 14:27:46 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 22 Feb 2023 14:27:46 +0800
From:   Sujuan Chen <sujuan.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Bo Jiao <bo.jiao@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Sujuan Chen <sujuan.chen@mediatek.com>
Subject: [PATCH] wifi: mt76: drop the incorrect scatter and gather frame
Date:   Wed, 22 Feb 2023 14:27:29 +0800
Message-ID: <acfc12f7f6a83151a1f3150febeff807fa8df45e.1677042139.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Peter Chiu <chui-hao.chiu@mediatek.com>

The scatter and gather frame may be incorrect because WED and WO may
send frames to host driver interleaved.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 6 ++++--
 drivers/net/wireless/mediatek/mt76/dma.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index da281cd1d36f..738d7e1569bf 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -402,8 +402,8 @@ mt76_dma_get_buf(struct mt76_dev *dev, struct mt76_queue *q, int idx,
 		*info = le32_to_cpu(desc->info);
 
 	if (mt76_queue_is_wed_rx(q)) {
-		u32 token = FIELD_GET(MT_DMA_CTL_TOKEN,
-				      le32_to_cpu(desc->buf1));
+		u32 buf1 = le32_to_cpu(desc->buf1);
+		u32 token = FIELD_GET(MT_DMA_CTL_TOKEN, buf1);
 		struct mt76_txwi_cache *t = mt76_rx_token_release(dev, token);
 
 		if (!t)
@@ -424,6 +424,8 @@ mt76_dma_get_buf(struct mt76_dev *dev, struct mt76_queue *q, int idx,
 
 			*drop = !!(ctrl & (MT_DMA_CTL_TO_HOST_A |
 					   MT_DMA_CTL_DROP));
+
+			*drop |= !!(buf1 & MT_DMA_CTL_WO_DROP);
 		}
 	} else {
 		buf = e->buf;
diff --git a/drivers/net/wireless/mediatek/mt76/dma.h b/drivers/net/wireless/mediatek/mt76/dma.h
index 4b9bc7f462b8..1b090d78cd05 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.h
+++ b/drivers/net/wireless/mediatek/mt76/dma.h
@@ -19,6 +19,7 @@
 #define MT_DMA_CTL_TO_HOST_A		BIT(12)
 #define MT_DMA_CTL_DROP			BIT(14)
 #define MT_DMA_CTL_TOKEN		GENMASK(31, 16)
+#define MT_DMA_CTL_WO_DROP		BIT(8)
 
 #define MT_DMA_PPE_CPU_REASON		GENMASK(15, 11)
 #define MT_DMA_PPE_ENTRY		GENMASK(30, 16)
-- 
2.39.0

