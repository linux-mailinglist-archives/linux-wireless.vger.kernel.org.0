Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972B847B86C
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Dec 2021 03:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhLUCk5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 21:40:57 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:45504 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231833AbhLUCk4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 21:40:56 -0500
X-UUID: ce6cbfe5366f4689a35296cec46a932e-20211221
X-UUID: ce6cbfe5366f4689a35296cec46a932e-20211221
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1972157130; Tue, 21 Dec 2021 10:40:50 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 21 Dec 2021 10:40:49 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 21 Dec
 2021 10:40:46 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 21 Dec 2021 10:40:46 +0800
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
Subject: [PATCH] mt76: mt7915: fix kernel build warning
Date:   Tue, 21 Dec 2021 10:40:41 +0800
Message-ID: <ac714fe3ce1f74bec7adb971f6145a05aa0554eb.1640054337.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

remove the unused variable 'legacy' and 'v1'.

Fixes: d2cf90e432b3 ("mt76: mt7915: update rx rate reporting for mt7916")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index e16df04..ee4535a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -468,14 +468,12 @@ mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
 			struct ieee80211_supported_band *sband,
 			__le32 *rxv)
 {
-	u32 v0, v1, v2;
-	u16 legacy;
+	u32 v0, v2;
 	u8 flags, stbc, gi, bw, dcm, mode, nss;
 	int i, idx;
 	bool cck = false;
 
 	v0 = le32_to_cpu(rxv[0]);
-	v1 = le32_to_cpu(rxv[1]);
 	v2 = le32_to_cpu(rxv[2]);
 
 	idx = i = FIELD_GET(MT_PRXV_TX_RATE, v0);
@@ -501,7 +499,6 @@ mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
 		fallthrough;
 	case MT_PHY_TYPE_OFDM:
 		i = mt76_get_rate(&dev->mt76, sband, i, cck);
-		legacy = sband->bitrates[i].bitrate;
 		break;
 	case MT_PHY_TYPE_HT_GF:
 	case MT_PHY_TYPE_HT:
-- 
2.18.0

