Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0736E459BF6
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Nov 2021 06:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbhKWF4i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Nov 2021 00:56:38 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:35906 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229690AbhKWF4i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Nov 2021 00:56:38 -0500
X-UUID: f725d6f0232b4958b9ee4a1f0b3bae15-20211123
X-UUID: f725d6f0232b4958b9ee4a1f0b3bae15-20211123
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 928026484; Tue, 23 Nov 2021 13:53:27 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 23 Nov 2021 13:53:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 23 Nov 2021 13:53:26 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH] mt76: mt7615: fix unused tx antenna mask in testmode
Date:   Tue, 23 Nov 2021 13:53:00 +0800
Message-ID: <20211123055300.27903-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The mask variable is assigned but not used after testmode disabled:
if (!en)
	mask = phy->mt76->chainmask;

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7615/testmode.c  | 21 +++++++++----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
index 59d9926..f374d89 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
@@ -185,36 +185,35 @@ mt7615_tm_set_tx_antenna(struct mt7615_phy *phy, bool en)
 	for (i = 0; i < 4; i++) {
 		mt76_rmw_field(dev, MT_WF_PHY_RFINTF3_0(i),
 			       MT_WF_PHY_RFINTF3_0_ANT,
-			       (td->tx_antenna_mask & BIT(i)) ? 0 : 0xa);
-
+			       (mask & BIT(i)) ? 0 : 0xa);
 	}
 
 	/* 2.4 GHz band */
 	mt76_rmw_field(dev, MT_ANT_SWITCH_CON(3), MT_ANT_SWITCH_CON_MODE(0),
-		       (td->tx_antenna_mask & BIT(0)) ? 0x8 : 0x1b);
+		       (mask & BIT(0)) ? 0x8 : 0x1b);
 	mt76_rmw_field(dev, MT_ANT_SWITCH_CON(4), MT_ANT_SWITCH_CON_MODE(2),
-		       (td->tx_antenna_mask & BIT(1)) ? 0xe : 0x1b);
+		       (mask & BIT(1)) ? 0xe : 0x1b);
 	mt76_rmw_field(dev, MT_ANT_SWITCH_CON(6), MT_ANT_SWITCH_CON_MODE1(0),
-		       (td->tx_antenna_mask & BIT(2)) ? 0x0 : 0xf);
+		       (mask & BIT(2)) ? 0x0 : 0xf);
 	mt76_rmw_field(dev, MT_ANT_SWITCH_CON(7), MT_ANT_SWITCH_CON_MODE1(2),
-		       (td->tx_antenna_mask & BIT(3)) ? 0x6 : 0xf);
+		       (mask & BIT(3)) ? 0x6 : 0xf);
 
 	/* 5 GHz band */
 	mt76_rmw_field(dev, MT_ANT_SWITCH_CON(4), MT_ANT_SWITCH_CON_MODE(1),
-		       (td->tx_antenna_mask & BIT(0)) ? 0xd : 0x1b);
+		       (mask & BIT(0)) ? 0xd : 0x1b);
 	mt76_rmw_field(dev, MT_ANT_SWITCH_CON(2), MT_ANT_SWITCH_CON_MODE(3),
-		       (td->tx_antenna_mask & BIT(1)) ? 0x13 : 0x1b);
+		       (mask & BIT(1)) ? 0x13 : 0x1b);
 	mt76_rmw_field(dev, MT_ANT_SWITCH_CON(7), MT_ANT_SWITCH_CON_MODE1(1),
-		       (td->tx_antenna_mask & BIT(2)) ? 0x5 : 0xf);
+		       (mask & BIT(2)) ? 0x5 : 0xf);
 	mt76_rmw_field(dev, MT_ANT_SWITCH_CON(8), MT_ANT_SWITCH_CON_MODE1(3),
-		       (td->tx_antenna_mask & BIT(3)) ? 0xb : 0xf);
+		       (mask & BIT(3)) ? 0xb : 0xf);
 
 	for (i = 0; i < 4; i++) {
 		u32 val;
 
 		val = mt7615_rf_rr(dev, i, 0x48);
 		val &= ~(0x3ff << 20);
-		if (td->tx_antenna_mask & BIT(i))
+		if (mask & BIT(i))
 			val |= 3 << 20;
 		else
 			val |= (2 << 28) | (2 << 26) | (8 << 20);
-- 
2.25.1

