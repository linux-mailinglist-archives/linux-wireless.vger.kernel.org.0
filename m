Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE404B6706
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Feb 2022 10:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbiBOJJB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Feb 2022 04:09:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbiBOJI7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Feb 2022 04:08:59 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1774213DD6
        for <linux-wireless@vger.kernel.org>; Tue, 15 Feb 2022 01:08:48 -0800 (PST)
X-UUID: 88e1180a3c9a4defa8412ccc23e2ed5a-20220215
X-UUID: 88e1180a3c9a4defa8412ccc23e2ed5a-20220215
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 808143531; Tue, 15 Feb 2022 17:08:47 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 15 Feb 2022 17:08:45 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Feb
 2022 17:08:29 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 15 Feb 2022 17:08:29 +0800
From:   Bo Jiao <bo.jiao@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH] mt76: mt7915: fix logic error and remove the unused member of mt7915_dev
Date:   Tue, 15 Feb 2022 17:08:27 +0800
Message-ID: <73401df842523a426c9c223217a4273cace2ab4b.1644915711.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <4b7ba947d90fc12bba5da59cd448372e89438b82.1644915710.git.Bo.Jiao@mediatek.com>
References: <4b7ba947d90fc12bba5da59cd448372e89438b82.1644915710.git.Bo.Jiao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

fix logic error and remove the unused member 'adie' of mt7915_dev.

Fixes: 91eeaef2523f ("mt76: mt7915: add support for MT7986")
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
---
 - please fold this into previous commit.
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 6a4fb4c..6b3749b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -589,10 +589,10 @@ static void mt7915_wfsys_reset(struct mt7915_dev *dev)
 
 		msleep(100);
 	} else if (is_mt7986(&dev->mt76)) {
-		mt7986_wmac_enable(dev);
+		mt7986_wmac_disable(dev);
 		msleep(20);
 
-		mt7986_wmac_disable(dev);
+		mt7986_wmac_enable(dev);
 		msleep(20);
 	} else {
 		mt76_set(dev, MT_WF_SUBSYS_RST, 0x1);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 3ffee35..6db0db1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -322,9 +322,6 @@ struct mt7915_dev {
 	struct reset_control *rstc;
 	void __iomem *dcm;
 	void __iomem *sku;
-
-	/* adie is inaccessible after wfsys poweron */
-	u32 adie;
 };
 
 enum {
-- 
2.18.0

