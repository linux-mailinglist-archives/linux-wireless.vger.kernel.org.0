Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70CA4DE609
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Mar 2022 05:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242156AbiCSEz3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Mar 2022 00:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242147AbiCSEz1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Mar 2022 00:55:27 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62D4E8873
        for <linux-wireless@vger.kernel.org>; Fri, 18 Mar 2022 21:54:00 -0700 (PDT)
X-UUID: 2599395107394b3d8fc505f242832db9-20220319
X-UUID: 2599395107394b3d8fc505f242832db9-20220319
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1450832026; Sat, 19 Mar 2022 12:53:52 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sat, 19 Mar 2022 12:53:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 19 Mar 2022 12:53:51 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: mt7915: always call mt7915_wfsys_reset() during init
Date:   Sat, 19 Mar 2022 12:53:50 +0800
Message-ID: <884cf46908e7f723f8b52ec5bb38ae17142a794c.1647665580.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Soft reboot might not clear certain condition, so always call
mt7915_wfsys_reset() during init.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index fd16d777f2e4..666ea7b0d3e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -651,10 +651,7 @@ static int mt7915_init_hardware(struct mt7915_dev *dev)
 
 	dev->dbdc_support = mt7915_band_config(dev);
 
-	/* If MCU was already running, it is likely in a bad state */
-	if (mt76_get_field(dev, MT_TOP_MISC, MT_TOP_MISC_FW_STATE) >
-	    FW_STATE_FW_DOWNLOAD)
-		mt7915_wfsys_reset(dev);
+	mt7915_wfsys_reset(dev);
 
 	ret = mt7915_dma_init(dev);
 	if (ret)
@@ -663,14 +660,8 @@ static int mt7915_init_hardware(struct mt7915_dev *dev)
 	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
 
 	ret = mt7915_mcu_init(dev);
-	if (ret) {
-		/* Reset and try again */
-		mt7915_wfsys_reset(dev);
-
-		ret = mt7915_mcu_init(dev);
-		if (ret)
-			return ret;
-	}
+	if (ret)
+		return ret;
 
 	ret = mt7915_eeprom_init(dev);
 	if (ret < 0)
-- 
2.29.2

