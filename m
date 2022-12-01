Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4B563EE0B
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Dec 2022 11:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiLAKjZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Dec 2022 05:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiLAKjX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Dec 2022 05:39:23 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54DCDF81
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 02:39:17 -0800 (PST)
X-UUID: 4c6f9439fc914f8c9da433d9dab645a7-20221201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=teGRJgvfH/U8wtkf9vgUtG+mrCTWmY4r8TQDwB18MFo=;
        b=gx9CNyDgbNQ0YQTpYYhFf5PQ5HRIp9ut5N1xHNMRKQLwhNKpfrNdo7FsYTXJrnFWEphJSiZS9MrOIzYuXG8DifZDjLiCRf3t7rBzrBc1MjZruMVAoAYazodAvmX7pJFLZk5IF8//66bcwoZ8Eevr0XvPtNejfK+tndrwGJDv2d4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:9031e03f-2276-4814-b93f-5140ac214123,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:3c0c6230-2938-482e-aafd-98d66723b8a9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 4c6f9439fc914f8c9da433d9dab645a7-20221201
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1697980329; Thu, 01 Dec 2022 18:39:11 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 1 Dec 2022 18:39:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 1 Dec 2022 18:39:10 +0800
From:   Deren Wu <deren.wu@mediatek.com>
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
Subject: [PATCH v3] wifi: mt76: mt7921e: add pci .shutdown() support
Date:   Thu, 1 Dec 2022 18:38:42 +0800
Message-ID: <f9126324d6d047dbc39a88f98a33bfcc888596bd.1669890885.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Leon Yen <Leon.Yen@mediatek.com>

Some combinations of hosts cannnot detect mt7921e after reboot. The
interoperability issue is caused by the status mismatch between host
and chip fw. In such cases, the driver should stop chip activities
and reset chip to default state before reboot.

Suggested-by: angelogioacchino.delregno@collabora.com
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Leon Yen <Leon.Yen@mediatek.com>
---
v3:
  - use pci .shutdown() instead of reboot notification
  - add suggested by Angelo
v2: add reboot notification block in mt76
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 28342ec940f0..cb72ded37256 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -507,6 +507,21 @@ static int mt7921_pci_resume(struct device *device)
 	return err;
 }
 
+static void mt7921_pci_shutdown(struct pci_dev *pdev)
+{
+	struct mt76_dev *mdev = pci_get_drvdata(pdev);
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt76_connac_pm *pm = &dev->pm;
+
+	cancel_delayed_work_sync(&pm->ps_work);
+	cancel_work_sync(&pm->wake_work);
+
+	/* chip cleanup before reboot */
+	mt7921_mcu_drv_pmctrl(dev);
+	mt7921_dma_cleanup(dev);
+	mt7921_wfsys_reset(dev);
+}
+
 static DEFINE_SIMPLE_DEV_PM_OPS(mt7921_pm_ops, mt7921_pci_suspend, mt7921_pci_resume);
 
 static struct pci_driver mt7921_pci_driver = {
@@ -514,6 +529,7 @@ static struct pci_driver mt7921_pci_driver = {
 	.id_table	= mt7921_pci_device_table,
 	.probe		= mt7921_pci_probe,
 	.remove		= mt7921_pci_remove,
+	.shutdown	= mt7921_pci_shutdown,
 	.driver.pm	= pm_sleep_ptr(&mt7921_pm_ops),
 };
 
-- 
2.18.0

