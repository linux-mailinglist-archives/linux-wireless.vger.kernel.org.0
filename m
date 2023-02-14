Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7FD6956D0
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Feb 2023 03:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBNCul (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 21:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBNCul (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 21:50:41 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9BE17162
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 18:50:39 -0800 (PST)
X-UUID: 5aafd040ac1211ed945fc101203acc17-20230214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Ovp4/zOIbtS53WT1CDsM1YZZ1uV3etCD/jrV5/I33Ks=;
        b=MQVNEPYX0BXPQ6LtS0dNdn/U28dsZmevHqejJbK7AtWoia3dgcfdWmvMY4gppYtGPdkT6hXaFSEjst7hgrg9ac0SW+on1Z5Q7z6fpiyMJI7CDrc5IvRS+pE/ejq1o6vY0enJCMck3ntfaO8trx5P/V3Lc6neWtMRTwEkJCQ/pO4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:a4cb986b-b5df-4e5f-bf49-57aedc9ed18e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.19,REQID:a4cb986b-b5df-4e5f-bf49-57aedc9ed18e,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:885ddb2,CLOUDID:45423157-dd49-462e-a4be-2143a3ddc739,B
        ulkID:230214105035GCB5ZSWE,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 5aafd040ac1211ed945fc101203acc17-20230214
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1216531654; Tue, 14 Feb 2023 10:50:34 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 14 Feb 2023 10:50:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 14 Feb 2023 10:50:33 +0800
From:   Deren Wu <deren.wu@mediatek.com>
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
Subject: [PATCH v2] wifi: mt76: mt7921: fix PCI DMA hang after reboot
Date:   Tue, 14 Feb 2023 10:49:57 +0800
Message-ID: <9f4a25c54dc68c941fbbd864e56e1b78868a5a9a.1676342819.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

mt7921 just stop some workers and clean up chip status before reboot.
In stress test, there are working activities still running at the period
of .shutdown callback and that would cause some hosts cannot recover
DMA after reboot. To avoid the floating state in reboot, we use
mt7921_pci_remove() to fully deinit all resources.

Fixes: f23a0cea8bd6 ("wifi: mt76: mt7921e: add pci .shutdown() support")
Signed-off-by: Deren Wu <deren.wu@mediatek.com>

---
v2: add Fixes tag
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index cb72ded37256..1a8a54a46dcc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -509,17 +509,7 @@ static int mt7921_pci_resume(struct device *device)
 
 static void mt7921_pci_shutdown(struct pci_dev *pdev)
 {
-	struct mt76_dev *mdev = pci_get_drvdata(pdev);
-	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
-	struct mt76_connac_pm *pm = &dev->pm;
-
-	cancel_delayed_work_sync(&pm->ps_work);
-	cancel_work_sync(&pm->wake_work);
-
-	/* chip cleanup before reboot */
-	mt7921_mcu_drv_pmctrl(dev);
-	mt7921_dma_cleanup(dev);
-	mt7921_wfsys_reset(dev);
+	mt7921_pci_remove(pdev);
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(mt7921_pm_ops, mt7921_pci_suspend, mt7921_pci_resume);
-- 
2.18.0

