Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3045B967A
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Sep 2022 10:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiIOIgS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Sep 2022 04:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiIOIgB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Sep 2022 04:36:01 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18157120AC
        for <linux-wireless@vger.kernel.org>; Thu, 15 Sep 2022 01:35:59 -0700 (PDT)
X-UUID: 5711d01616a8482ca185d34d26772383-20220915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=8wsvf7XzdAL464C0rzEkWk+2PA7kypLI5OvW/jQeWU4=;
        b=tKSeICnehbv/LbB3MVO33w+u2dn4Pwl2TmhfLfBj1195hbU2Y/ySRYI5dM7KzOkbryCMTOLmfpAw2QF+LDLTlUtgQ0BwQfORFs+G/b18XzH7c6vQnKBB1aN20pr9z+DqsVdBLAUljLxS72rYTZ8A73O7KV+b/ZQ+LaBQZxp9szA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:093327f9-44d6-43cc-9d0f-3402bffa0616,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:39a5ff1,CLOUDID:8f1680f6-6e85-48d9-afd8-0504bbfe04cb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 5711d01616a8482ca185d34d26772383-20220915
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 49282675; Thu, 15 Sep 2022 16:35:56 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 15 Sep 2022 16:35:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 15 Sep 2022 16:35:54 +0800
From:   Deren Wu <Deren.Wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7663s: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Thu, 15 Sep 2022 16:35:52 +0800
Message-ID: <0f463aaa811122387b068bac045c51a4959ef6ef.1663229534.git.deren.wu@mediatek.com>
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

Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
index 49ab3a1f3b9b..401d457b7946 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -180,7 +180,6 @@ static void mt7663s_remove(struct sdio_func *func)
 	mt76_free_device(&dev->mt76);
 }
 
-#ifdef CONFIG_PM
 static int mt7663s_suspend(struct device *dev)
 {
 	struct sdio_func *func = dev_to_sdio_func(dev);
@@ -235,28 +234,20 @@ static int mt7663s_resume(struct device *dev)
 	return err;
 }
 
-static const struct dev_pm_ops mt7663s_pm_ops = {
-	.suspend = mt7663s_suspend,
-	.resume = mt7663s_resume,
-};
-#endif
-
 MODULE_DEVICE_TABLE(sdio, mt7663s_table);
 MODULE_FIRMWARE(MT7663_OFFLOAD_FIRMWARE_N9);
 MODULE_FIRMWARE(MT7663_OFFLOAD_ROM_PATCH);
 MODULE_FIRMWARE(MT7663_FIRMWARE_N9);
 MODULE_FIRMWARE(MT7663_ROM_PATCH);
 
+static DEFINE_SIMPLE_DEV_PM_OPS(mt7663s_pm_ops, mt7663s_suspend, mt7663s_resume);
+
 static struct sdio_driver mt7663s_driver = {
 	.name		= KBUILD_MODNAME,
 	.probe		= mt7663s_probe,
 	.remove		= mt7663s_remove,
 	.id_table	= mt7663s_table,
-#ifdef CONFIG_PM
-	.drv = {
-		.pm = &mt7663s_pm_ops,
-	}
-#endif
+	.drv.pm		= pm_sleep_ptr(&mt7663s_pm_ops),
 };
 module_sdio_driver(mt7663s_driver);
 
-- 
2.18.0

