Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768B25B967B
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Sep 2022 10:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiIOIgs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Sep 2022 04:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiIOIgZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Sep 2022 04:36:25 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E220897EC2
        for <linux-wireless@vger.kernel.org>; Thu, 15 Sep 2022 01:36:21 -0700 (PDT)
X-UUID: 75e26220255441eb869e4e3b94076ddc-20220915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=HkUAny1cuMgRvcA8UKJ+awhAgM2NFuESRyFNqyD49QY=;
        b=UmwQa+bGw2aW5EF1hH+b2fPakU+xSY8WNcd2G/IwcCGLM6uqgzz850oBCaSrNDh67BRxFr5ySFytG1CxYOoH1xWDcQpY1W1VCy9iQ6bJ7ONFNiRGhuOkXBPhNUsolNwiqxDWxhvIXFmCCY73FP+lKu3jydfD/iLvK1JLIQ+PPts=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:46ef459d-0a86-49fb-aca0-e15c350a1144,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:39a5ff1,CLOUDID:931b80f6-6e85-48d9-afd8-0504bbfe04cb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 75e26220255441eb869e4e3b94076ddc-20220915
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1562618244; Thu, 15 Sep 2022 16:36:15 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 15 Sep 2022 16:36:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 15 Sep 2022 16:36:14 +0800
From:   Deren Wu <Deren.Wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        "Eric-SY Chang" <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        "Ryder Lee" <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921s: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Thu, 15 Sep 2022 16:36:04 +0800
Message-ID: <e5478408c98e51e6903892cf128acdc103a09535.1663229480.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

Use the new DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros to
handle the .suspend/.resume callbacks. The new macros allow suspend
and resume functions to be automatically dropped without any #ifdef
guards.

Tested-by: YN Chen <YN.Chen@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index 487acd6e2be8..545577eff8ae 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -194,7 +194,6 @@ static void mt7921s_remove(struct sdio_func *func)
 	mt7921s_unregister_device(dev);
 }
 
-#ifdef CONFIG_PM
 static int mt7921s_suspend(struct device *__dev)
 {
 	struct sdio_func *func = dev_to_sdio_func(__dev);
@@ -296,26 +295,18 @@ static int mt7921s_resume(struct device *__dev)
 	return err;
 }
 
-static const struct dev_pm_ops mt7921s_pm_ops = {
-	.suspend = mt7921s_suspend,
-	.resume = mt7921s_resume,
-};
-#endif
-
 MODULE_DEVICE_TABLE(sdio, mt7921s_table);
 MODULE_FIRMWARE(MT7921_FIRMWARE_WM);
 MODULE_FIRMWARE(MT7921_ROM_PATCH);
 
+static DEFINE_SIMPLE_DEV_PM_OPS(mt7921s_pm_ops, mt7921s_suspend, mt7921s_resume);
+
 static struct sdio_driver mt7921s_driver = {
 	.name		= KBUILD_MODNAME,
 	.probe		= mt7921s_probe,
 	.remove		= mt7921s_remove,
 	.id_table	= mt7921s_table,
-#ifdef CONFIG_PM
-	.drv = {
-		.pm = &mt7921s_pm_ops,
-	}
-#endif
+	.drv.pm		= pm_sleep_ptr(&mt7921s_pm_ops),
 };
 module_sdio_driver(mt7921s_driver);
 MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
-- 
2.18.0

