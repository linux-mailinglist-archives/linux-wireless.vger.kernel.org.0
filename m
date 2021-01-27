Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45318305194
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jan 2021 05:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238550AbhA0E7Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Jan 2021 23:59:24 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:52801 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238288AbhA0ELP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Jan 2021 23:11:15 -0500
X-UUID: 21ca6b9cdc7d48328250d14f7d2baa33-20210127
X-UUID: 21ca6b9cdc7d48328250d14f7d2baa33-20210127
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 376623221; Wed, 27 Jan 2021 12:10:22 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 27 Jan 2021 12:10:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Jan 2021 12:10:19 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Zhiqiang Yang <zhiqiang.yang@mediatek.com>
Subject: [PATCH] mt76: mt7915: only set PCIE_RECOGNITION_ID when using the second hif
Date:   Wed, 27 Jan 2021 12:10:18 +0800
Message-ID: <121208af32ad8850fe04feb6707f3fe2304d8353.1611720332.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

To avoid connection issue on mt7622.

Signed-off-by: Zhiqiang Yang <zhiqiang.yang@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
index 64ffffdc93c9..2cb7a6ff0ffd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -183,6 +183,8 @@ static void mt7915_pci_init_hif2(struct mt7915_dev *dev)
 		return;
 
 	dev->hif2 = hif;
+	dev->hif_idx = ++hif_idx;
+	mt76_wr(dev, MT_PCIE_RECOG_ID, dev->hif_idx | MT_PCIE_RECOG_ID_SEM);
 
 	if (devm_request_irq(dev->mt76.dev, hif->irq, mt7915_irq_handler,
 			     IRQF_SHARED, KBUILD_MODNAME "-hif", dev)) {
@@ -280,9 +282,6 @@ static int mt7915_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto error;
 
-	dev->hif_idx = ++hif_idx;
-	mt76_wr(dev, MT_PCIE_RECOG_ID, dev->hif_idx | MT_PCIE_RECOG_ID_SEM);
-
 	mt7915_pci_init_hif2(dev);
 
 	ret = mt7915_register_device(dev);
-- 
2.18.0

