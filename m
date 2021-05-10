Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D19E379252
	for <lists+linux-wireless@lfdr.de>; Mon, 10 May 2021 17:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbhEJPRJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 May 2021 11:17:09 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:56330 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233876AbhEJPQJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 May 2021 11:16:09 -0400
X-UUID: f26825eed5384c7f9c2de49528c790da-20210510
X-UUID: f26825eed5384c7f9c2de49528c790da-20210510
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1665037848; Mon, 10 May 2021 23:14:59 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 10 May 2021 23:14:58 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 May 2021 23:14:58 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <jemele@google.com>, <yenlinlai@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/9] mt76: mt7921: fix mt7921_wfsys_reset sequence
Date:   Mon, 10 May 2021 23:14:49 +0800
Message-ID: <1620659697-12048-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

WiFi subsytem reset should control MT_WFSYS_SW_RST_B and then poll the
same register until the bit WFSYS_SW_INIT_DONE bit is set.

Fixes: 0c1ce9884607 ("mt76: mt7921: add wifi reset support")
Reviewed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index 71e664ee7652..bd9143dc865f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -313,9 +313,9 @@ static int mt7921_dma_reset(struct mt7921_dev *dev, bool force)
 
 int mt7921_wfsys_reset(struct mt7921_dev *dev)
 {
-	mt76_set(dev, 0x70002600, BIT(0));
-	msleep(200);
-	mt76_clear(dev, 0x70002600, BIT(0));
+	mt76_clear(dev, MT_WFSYS_SW_RST_B, WFSYS_SW_RST_B);
+	msleep(50);
+	mt76_set(dev, MT_WFSYS_SW_RST_B, WFSYS_SW_RST_B);
 
 	if (!__mt76_poll_msec(&dev->mt76, MT_WFSYS_SW_RST_B,
 			      WFSYS_SW_INIT_DONE, WFSYS_SW_INIT_DONE, 500))
-- 
2.25.1

