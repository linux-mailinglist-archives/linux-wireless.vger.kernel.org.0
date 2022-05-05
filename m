Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF5451B87C
	for <lists+linux-wireless@lfdr.de>; Thu,  5 May 2022 09:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245714AbiEEHMf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 03:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245636AbiEEHMc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 03:12:32 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FD44754D
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 00:08:49 -0700 (PDT)
X-UUID: bc23d14ec1d1481d9462009e5fbb4fb3-20220505
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:48f283f7-b254-4a73-afba-edc94321d5ef,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:75
X-CID-INFO: VERSION:1.1.4,REQID:48f283f7-b254-4a73-afba-edc94321d5ef,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:75
X-CID-META: VersionHash:faefae9,CLOUDID:ab59a6b2-56b5-4c9e-8d83-0070b288eb6a,C
        OID:d79bb41e6a2f,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: bc23d14ec1d1481d9462009e5fbb4fb3-20220505
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2017893067; Thu, 05 May 2022 15:08:44 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 5 May 2022 15:08:43 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 5 May 2022 15:08:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 5 May 2022 15:08:43 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>
Subject: [PATCH 3/3] mt76: mt7915: move MT_INT_MASK_CSR to init.c
Date:   Thu, 5 May 2022 15:08:36 +0800
Message-ID: <7bfbc431f07401f73f51566ce347fca01cbaa98b.1651722608.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <40f31a4550ff357468798a5950a62ceec396cbeb.1651722608.git.ryder.lee@mediatek.com>
References: <40f31a4550ff357468798a5950a62ceec396cbeb.1651722608.git.ryder.lee@mediatek.com>
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

To avoid redundant MT_INT_MASK_CSR settings.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 1 +
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c | 2 --
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c  | 2 --
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c  | 1 -
 4 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index aa93aeab5634..db6904448063 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -649,6 +649,7 @@ mt7915_init_hardware(struct mt7915_dev *dev, struct mt7915_phy *phy2)
 {
 	int ret, idx;
 
+	mt76_wr(dev, MT_INT_MASK_CSR, 0);
 	mt76_wr(dev, MT_INT_SOURCE_CSR, ~0);
 
 	INIT_WORK(&dev->init_work, mt7915_init_work);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 229d40826c9b..3c55d4cebbf2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -668,8 +668,6 @@ struct mt7915_dev *mt7915_mmio_probe(struct device *pdev,
 
 	tasklet_setup(&dev->irq_tasklet, mt7915_irq_tasklet);
 
-	mt76_wr(dev, MT_INT_MASK_CSR, 0);
-
 	return dev;
 
 error:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
index 6f819c41a4c4..a9d4b3fced53 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -138,8 +138,6 @@ static int mt7915_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto free_irq_vector;
 
-	mt76_wr(dev, MT_INT_MASK_CSR, 0);
-
 	/* master switch of PCIe tnterrupt enable */
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
index 04e62d569599..b91f5485f97a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
@@ -1168,7 +1168,6 @@ static int mt7986_wmac_probe(struct platform_device *pdev)
 		goto free_irq;
 
 	mt7915_wfsys_reset(dev);
-	mt76_wr(dev, MT_INT_MASK_CSR, 0);
 
 	ret = mt7915_register_device(dev);
 	if (ret)
-- 
2.29.2

