Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F26845902E
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 15:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239609AbhKVO3j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 09:29:39 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:53344 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239590AbhKVO3i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 09:29:38 -0500
X-UUID: 2cc25f1400b54978bc2185443012158d-20211122
X-UUID: 2cc25f1400b54978bc2185443012158d-20211122
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 109960779; Mon, 22 Nov 2021 22:26:26 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 22 Nov 2021 22:26:25 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 22 Nov
 2021 22:26:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 22 Nov 2021 22:26:24 +0800
From:   Deren Wu <Deren.Wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        "Eric-SY Chang" <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Shayne Chen" <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] mt76: mt7921: fix timestamp check in tx_status
Date:   Mon, 22 Nov 2021 22:25:44 +0800
Message-ID: <934b51921e22ca6f8983d7cbd9feb5248f804303.1637590567.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

Should keep SKBs only if timeout timestamp is still after jiffies.
Otherwise, report tx status and drop it direclty.

Fixes: bd1e3e7b693c ("mt76: introduce packet_id idr")
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 11719ef034d8..6b8c9dc80542 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -173,7 +173,7 @@ mt76_tx_status_skb_get(struct mt76_dev *dev, struct mt76_wcid *wcid, int pktid,
 			if (!(cb->flags & MT_TX_CB_DMA_DONE))
 				continue;
 
-			if (!time_is_after_jiffies(cb->jiffies +
+			if (time_is_after_jiffies(cb->jiffies +
 						   MT_TX_STATUS_SKB_TIMEOUT))
 				continue;
 		}
-- 
2.18.0

