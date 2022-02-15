Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFBD4B64E1
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Feb 2022 08:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbiBOH7m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Feb 2022 02:59:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiBOH7l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Feb 2022 02:59:41 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B27C13D30
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 23:59:28 -0800 (PST)
X-UUID: 8ae727c3003546eea07df65e8020476c-20220215
X-UUID: 8ae727c3003546eea07df65e8020476c-20220215
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 347430706; Tue, 15 Feb 2022 15:59:16 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Feb 2022 15:59:14 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Feb
 2022 15:59:11 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 15 Feb 2022 15:59:10 +0800
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
Subject: [PATCH] mt76: mt7915: fix warning: variable 'temp' set but not used
Date:   Tue, 15 Feb 2022 15:59:08 +0800
Message-ID: <ffe6426240bbac484c31fb1489a994ca7bfda4fb.1644911758.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

fix warning: variable 'temp' set but not used,
please fold this into previous commit

Fixes: 91eeaef2523f ("mt76: mt7915: add support for MT7986")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h | 3 ---
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c    | 2 +-
 3 files changed, 3 insertions(+), 6 deletions(-)

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
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
index fb72ab4..4394a51 100644
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
-- 
2.18.0

