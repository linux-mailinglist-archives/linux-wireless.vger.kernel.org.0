Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C853262747C
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Nov 2022 03:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbiKNCSB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Nov 2022 21:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbiKNCSA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Nov 2022 21:18:00 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0173F033
        for <linux-wireless@vger.kernel.org>; Sun, 13 Nov 2022 18:17:54 -0800 (PST)
X-UUID: 7d62136af4f64c3d88f7cbefd9f594fd-20221114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=aRqmoYXBgTeHqrM+K2EJUB3BrOYPaN+00XY1lOs9Q/8=;
        b=YlZDvKaZgNTsjdHUVEFKcHUvmzNsz+hI+S/NgtBNETc+Uo8lE/bOBCiM1utOzjgBvdPUi1GmQVPTnVkBpqeyuJmESwM7LCp5eZmyQHTOXe/WSUnRZBL69AMKqP0L0haDWydz40p1Hweyf+maTw1og9mxzRn4TzHzTY4VIWzDWt4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:8cc06956-0c3e-49aa-bb0d-0cb2113029b8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d12e911,CLOUDID:a8ad715d-100c-4555-952b-a62c895efded,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 7d62136af4f64c3d88f7cbefd9f594fd-20221114
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 371584420; Mon, 14 Nov 2022 10:17:49 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 14 Nov 2022 10:17:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 14 Nov 2022 10:17:48 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7915: fix uninitialized irq_mask
Date:   Mon, 14 Nov 2022 10:17:47 +0800
Message-ID: <230b8d9575f905bc168155de5acd40dbd37d901e.1668391668.git.ryder.lee@mediatek.com>
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

It should use dev->mt76.mmio.irqmask instead.

Fixes: 337acff38223 ("wifi: mt76: mt7915: enable full system reset support")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
@Felix, could you please help to fold this patch?
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index e7b1618cd3a6..117ddb00348c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1354,7 +1354,6 @@ mt7915_mac_restart(struct mt7915_dev *dev)
 	struct mt76_phy *ext_phy;
 	struct mt76_dev *mdev = &dev->mt76;
 	int i, ret;
-	u32 irq_mask;
 
 	ext_phy = dev->mt76.phys[MT_BAND1];
 	phy2 = ext_phy ? ext_phy->priv : NULL;
@@ -1412,7 +1411,7 @@ mt7915_mac_restart(struct mt7915_dev *dev)
 	mt76_wr(dev, MT_INT_SOURCE_CSR, ~0);
 
 	if (dev->hif2) {
-		mt76_wr(dev, MT_INT1_MASK_CSR, irq_mask);
+		mt76_wr(dev, MT_INT1_MASK_CSR, dev->mt76.mmio.irqmask);
 		mt76_wr(dev, MT_INT1_SOURCE_CSR, ~0);
 	}
 	if (dev_is_pci(mdev->dev)) {
-- 
2.36.1

