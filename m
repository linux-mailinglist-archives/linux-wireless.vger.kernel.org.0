Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3173DFF3E
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 12:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbhHDKOb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 06:14:31 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:46744 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236909AbhHDKO3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 06:14:29 -0400
X-UUID: 96e7c9387dc44afe8cb0d92d5c75b2e0-20210804
X-UUID: 96e7c9387dc44afe8cb0d92d5c75b2e0-20210804
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 156633199; Wed, 04 Aug 2021 18:14:07 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 4 Aug 2021 18:14:01 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 4 Aug 2021 18:14:00 +0800
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
        Stella Chang <Stella.Chang@mediatek.com>, <jemele@google.com>,
        <yenlinlai@google.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] mt76: mt7921: enable VO tx aggregation
Date:   Wed, 4 Aug 2021 18:11:53 +0800
Message-ID: <0747f9249b2d7902f9cb514861342a9940d49e0d.1628071231.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

From: YN Chen <YN.Chen@mediatek.com>

Avoid throughput drop in VO streaming, enable TX BA by default.

Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: YN Chen <YN.Chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 296e0f7a1d14..1be1e07ae786 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -913,8 +913,6 @@ mt7921_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
 		return;
 
 	tid = FIELD_GET(MT_TXD1_TID, le32_to_cpu(txwi[1]));
-	if (tid >= 6) /* skip VO queue */
-		return;
 
 	val = le32_to_cpu(txwi[2]);
 	fc = FIELD_GET(MT_TXD2_FRAME_TYPE, val) << 2 |
-- 
2.25.1

