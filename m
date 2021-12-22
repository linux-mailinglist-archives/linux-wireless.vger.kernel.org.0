Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9AB47D1AF
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Dec 2021 13:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244876AbhLVM3K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Dec 2021 07:29:10 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:34284 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S244860AbhLVM3K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Dec 2021 07:29:10 -0500
X-UUID: 21c0e82648b1463e97e184a1734a3a62-20211222
X-UUID: 21c0e82648b1463e97e184a1734a3a62-20211222
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 813653017; Wed, 22 Dec 2021 20:29:05 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 22 Dec 2021 20:29:04 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Dec
 2021 20:29:04 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 22 Dec 2021 20:29:03 +0800
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
Subject: [PATCH] mt76: mt7915: fix code defect
Date:   Wed, 22 Dec 2021 20:29:00 +0800
Message-ID: <5806e90f8e0cf9eba7f5432082a4c0f1e9e15636.1640173851.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

fix code defect, variable 'val' is used without initialization
in mt7915_wfsys_reset().

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 13 +++++--------
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c | 14 ++++++--------
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 7557429..b4ff3d1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -541,11 +541,12 @@ static void mt7915_init_work(struct work_struct *work)
 
 static void mt7915_wfsys_reset(struct mt7915_dev *dev)
 {
-	u32 val;
-
 #define MT_MCU_DUMMY_RANDOM	GENMASK(15, 0)
 #define MT_MCU_DUMMY_DEFAULT	GENMASK(31, 16)
+
 	if (is_mt7915(&dev->mt76)) {
+		u32 val = MT_TOP_PWR_KEY | MT_TOP_PWR_SW_PWR_ON | MT_TOP_PWR_PWR_ON;
+
 		mt76_wr(dev, MT_MCU_WFDMA0_DUMMY_CR, MT_MCU_DUMMY_RANDOM);
 
 		/* change to software control */
@@ -578,14 +579,10 @@ static void mt7915_wfsys_reset(struct mt7915_dev *dev)
 
 		msleep(100);
 	} else {
-		val = mt76_rr(dev, MT_WF_SUBSYS_RST);
-
-		val |= 0x1;
-		mt76_wr(dev, MT_WF_SUBSYS_RST, val);
+		mt76_set(dev, MT_WF_SUBSYS_RST, 0x1);
 		msleep(20);
 
-		val &= ~0x1;
-		mt76_wr(dev, MT_WF_SUBSYS_RST, val);
+		mt76_clear(dev, MT_WF_SUBSYS_RST, 0x1);
 		msleep(20);
 	}
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 6500095..a6dd33f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -271,7 +271,7 @@ static u32 mt7915_reg_map_l1(struct mt7915_dev *dev, u32 addr)
 
 	dev->bus_ops->rmw(&dev->mt76, l1_remap,
 			  MT_HIF_REMAP_L1_MASK,
-		FIELD_PREP(MT_HIF_REMAP_L1_MASK, base));
+			  FIELD_PREP(MT_HIF_REMAP_L1_MASK, base));
 	/* use read to push write */
 	dev->bus_ops->rr(&dev->mt76, l1_remap);
 
@@ -575,17 +575,15 @@ int mt7915_mmio_probe(struct device *pdev,
 	if (ret)
 		goto error;
 
-	if (hif2) {
+	if (hif2 && dev_is_pci(pdev)) {
 		dev->hif2 = hif2;
 
 		mt76_wr(dev, MT_INT1_MASK_CSR, 0);
 		/* master switch of PCIe tnterrupt enable */
-		if (dev_is_pci(pdev)) {
-			if (is_mt7915(mdev))
-				mt76_wr(dev, MT_PCIE1_MAC_INT_ENABLE, 0xff);
-			else
-				mt76_wr(dev, MT_PCIE1_MAC_INT_ENABLE_MT7916, 0xff);
-		}
+		if (is_mt7915(mdev))
+			mt76_wr(dev, MT_PCIE1_MAC_INT_ENABLE, 0xff);
+		else
+			mt76_wr(dev, MT_PCIE1_MAC_INT_ENABLE_MT7916, 0xff);
 
 		ret = devm_request_irq(mdev->dev, dev->hif2->irq,
 				       mt7915_irq_handler, IRQF_SHARED,
-- 
2.18.0

