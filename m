Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3C943C626
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Oct 2021 11:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241184AbhJ0JMN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Oct 2021 05:12:13 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:53704 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241180AbhJ0JML (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Oct 2021 05:12:11 -0400
X-UUID: 74a4a6c78b984404bbb708c8a905db60-20211027
X-UUID: 74a4a6c78b984404bbb708c8a905db60-20211027
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2128870852; Wed, 27 Oct 2021 17:09:44 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 27 Oct 2021 17:09:43 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Oct
 2021 16:40:38 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 27 Oct 2021 16:40:38 +0800
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
Subject: [PATCH 11/11] mt76: mt7915: add device id for mt7916
Date:   Wed, 27 Oct 2021 16:40:19 +0800
Message-ID: <65c8adaa746d711a5aa8d7ec01689001a1bd91fe.1635323366.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1635323366.git.Bo.Jiao@mediatek.com>
References: <cover.1635323366.git.Bo.Jiao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

Add pci_device_id to enable mt7916. Note that MT_HW_CHIPID is no
longer used for further chips, so drop it accordingly.

Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c  | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 4c06ddf..7191790 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -534,7 +534,7 @@ static int mt7915_mmio_init(struct mt76_dev *mdev,
 	bus_ops->rmw = mt7915_rmw;
 	dev->mt76.bus = bus_ops;
 
-	mdev->rev = (mt76_rr(dev, MT_HW_CHIPID) << 16) |
+	mdev->rev = (device_id << 16) |
 		    (mt76_rr(dev, MT_HW_REV) & 0xff);
 	dev_dbg(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
index 3134b46..8d1a811 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -18,11 +18,13 @@ static u32 hif_idx;
 
 static const struct pci_device_id mt7915_pci_device_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7915) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7906) },
 	{ },
 };
 
 static const struct pci_device_id mt7915_hif_device_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7916) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x790a) },
 	{ },
 };
 
@@ -61,7 +63,8 @@ static void mt7915_put_hif2(struct mt7915_hif *hif)
 static struct mt7915_hif *mt7915_pci_init_hif2(struct pci_dev *pdev)
 {
 	hif_idx++;
-	if (!pci_get_device(PCI_VENDOR_ID_MEDIATEK, 0x7916, NULL))
+	if (!pci_get_device(PCI_VENDOR_ID_MEDIATEK, 0x7916, NULL) &&
+	    !pci_get_device(PCI_VENDOR_ID_MEDIATEK, 0x790a, NULL))
 		return NULL;
 
 	writel(hif_idx | MT_PCIE_RECOG_ID_SEM,
@@ -112,7 +115,7 @@ static int mt7915_pci_probe(struct pci_dev *pdev,
 
 	mt76_pci_disable_aspm(pdev);
 
-	if (id->device == 0x7916)
+	if (id->device == 0x7916 || id->device == 0x790a)
 		return mt7915_pci_hif2_probe(pdev);
 
 	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
-- 
2.18.0

