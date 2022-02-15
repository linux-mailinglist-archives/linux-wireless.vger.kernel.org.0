Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1624B66FD
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Feb 2022 10:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbiBOJIc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Feb 2022 04:08:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbiBOJIa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Feb 2022 04:08:30 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B544013DCA
        for <linux-wireless@vger.kernel.org>; Tue, 15 Feb 2022 01:08:20 -0800 (PST)
X-UUID: 6f0e7ae0277f4b48bc3ed7f59007ace1-20220215
X-UUID: 6f0e7ae0277f4b48bc3ed7f59007ace1-20220215
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1896501588; Tue, 15 Feb 2022 17:08:16 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 15 Feb 2022 17:08:15 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Feb
 2022 17:08:14 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 15 Feb 2022 17:08:13 +0800
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
Subject: [PATCH] mt76: mt7915: fix compiler warning
Date:   Tue, 15 Feb 2022 17:08:12 +0800
Message-ID: <4b7ba947d90fc12bba5da59cd448372e89438b82.1644915710.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
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

fix warning: variable 'temp' set but not used and
cast from pointer to integer of different size

Fixes: 91eeaef2523f ("mt76: mt7915: add support for MT7986")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
---
 - please fold this into previous commit.
---
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
index fb72ab4..decf288 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
@@ -125,7 +125,7 @@ mt7986_wmac_adie_efuse_read(struct mt7915_dev *dev, u8 adie,
 		return ret;
 
 	ret = read_poll_timeout(mt76_wmac_spi_read, temp,
-				!FIELD_GET(MT_ADIE_EFUSE_KICK_MASK, val),
+				!temp && !FIELD_GET(MT_ADIE_EFUSE_KICK_MASK, val),
 				USEC_PER_MSEC, 50 * USEC_PER_MSEC, false,
 				dev, adie, MT_ADIE_EFUSE2_CTRL, &val);
 	if (ret)
@@ -1126,9 +1126,9 @@ static int mt7986_wmac_probe(struct platform_device *pdev)
 	struct mt7915_dev *dev;
 	struct mt76_dev *mdev;
 	int irq, ret;
-	u64 chip_id;
+	u32 chip_id;
 
-	chip_id = (u64)of_device_get_match_data(&pdev->dev);
+	chip_id = (uintptr_t)of_device_get_match_data(&pdev->dev);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-- 
2.18.0

