Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02062354B40
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Apr 2021 05:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239201AbhDFDew (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Apr 2021 23:34:52 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:44117 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239413AbhDFDew (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Apr 2021 23:34:52 -0400
X-UUID: 015b88d4585944238697adfe50eb64a8-20210406
X-UUID: 015b88d4585944238697adfe50eb64a8-20210406
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1044638343; Tue, 06 Apr 2021 11:34:42 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 6 Apr 2021 11:34:41 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 6 Apr 2021 11:34:41 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 5/6] mt76: mt7921: fix MT_PCIE_MAC_INT_ENABLE access
Date:   Tue, 6 Apr 2021 11:34:38 +0800
Message-ID: <93c38f60a5257aba24f460042df2537b459d8ab3.1617679693.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <4c5666ad0683e467f11ca4a4abb5be335be25696.1617679693.git.objelf@gmail.com>
References: <4c5666ad0683e467f11ca4a4abb5be335be25696.1617679693.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Use mt76_wr to directly access MT_PCIE_MAC_INT_ENABLE because we used the
remapped address 0x10000 as the base to operate PCIe interrupt.

Fixes: 215bb6737bef ("mt76: mt7921: add wifi reset support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 94f178e28e20..3bbd8bc0315f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1321,7 +1321,7 @@ mt7921_mac_reset(struct mt7921_dev *dev)
 	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
 
 	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
-	mt7921_l1_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
+	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
 
 	set_bit(MT76_MCU_RESET, &dev->mphy.state);
 	wake_up(&dev->mt76.mcu.wait);
@@ -1364,7 +1364,7 @@ mt7921_mac_reset(struct mt7921_dev *dev)
 	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
 
 	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
-	mt7921_l1_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
+	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
 	mt7921_irq_enable(dev,
 			  MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
 			  MT_INT_MCU_CMD);
-- 
2.25.1

