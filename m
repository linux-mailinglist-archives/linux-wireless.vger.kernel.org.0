Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91DFD3A337B
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jun 2021 20:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFJSpw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Jun 2021 14:45:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:47399 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229935AbhFJSpw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Jun 2021 14:45:52 -0400
X-UUID: 5ab89752a2a24d6f9f6092f5cd5338d7-20210611
X-UUID: 5ab89752a2a24d6f9f6092f5cd5338d7-20210611
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1966894381; Fri, 11 Jun 2021 02:43:52 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 11 Jun 2021 02:43:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Jun 2021 02:43:51 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/4] mt76: mt7622: use devm_platform_ioremap_resource()
Date:   Fri, 11 Jun 2021 02:43:44 +0800
Message-ID: <245a3745aea487793e40fbf82172c5367649bab3.1623347029.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Simplify probing code.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/soc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/soc.c b/drivers/net/wireless/mediatek/mt76/mt7615/soc.c
index be9a69fe1b38..ac2c27aa7701 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/soc.c
@@ -31,7 +31,6 @@ int mt7622_wmac_init(struct mt7615_dev *dev)
 
 static int mt7622_wmac_probe(struct platform_device *pdev)
 {
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	void __iomem *mem_base;
 	int irq;
 
@@ -39,7 +38,7 @@ static int mt7622_wmac_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	mem_base = devm_ioremap_resource(&pdev->dev, res);
+	mem_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mem_base))
 		return PTR_ERR(mem_base);
 
-- 
2.18.0

