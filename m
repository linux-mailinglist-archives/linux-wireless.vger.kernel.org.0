Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346B749E379
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jan 2022 14:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241825AbiA0NdA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jan 2022 08:33:00 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:52994 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241952AbiA0Nce (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jan 2022 08:32:34 -0500
X-UUID: 7a27baa13c7d444f81263719fbb8e84d-20220127
X-UUID: 7a27baa13c7d444f81263719fbb8e84d-20220127
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <meichia.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1472596911; Thu, 27 Jan 2022 21:32:30 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 27 Jan 2022 21:32:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 27 Jan 2022 21:32:28 +0800
From:   MeiChia Chiu <MeiChia.Chiu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        MeiChia Chiu <meichia.chiu@mediatek.com>
Subject: [PATCH] mt76: mt7915: fix the nss setting in bitrates
Date:   Thu, 27 Jan 2022 21:32:26 +0800
Message-ID: <20220127133226.14299-1-MeiChia.Chiu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: MeiChia Chiu <meichia.chiu@mediatek.com>

without this change, the fixed MCS only supports 1 Nss.

Fixes: 70fd1333cd32f ("mt76: mt7915: rework .set_bitrate_mask() to support more options")
Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: MeiChia Chiu <meichia.chiu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 66f8daf3168c..69c5ac10e114 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1420,9 +1420,12 @@ mt7915_mcu_add_rate_ctrl_fixed(struct mt7915_dev *dev,
 			phy.sgi |= gi << (i << (_he));				\
 			phy.he_ltf |= mask->control[band].he_ltf << (i << (_he));\
 		}								\
-		for (i = 0; i < ARRAY_SIZE(mask->control[band]._mcs); i++) 	\
-			nrates += hweight16(mask->control[band]._mcs[i]);  	\
-		phy.mcs = ffs(mask->control[band]._mcs[0]) - 1;			\
+		for (i = 0; i < ARRAY_SIZE(mask->control[band]._mcs); i++) {	\
+			if (!mask->control[band]._mcs[i])			\
+				continue;					\
+			nrates += hweight16(mask->control[band]._mcs[i]);	\
+			phy.mcs = ffs(mask->control[band]._mcs[i]) - 1;		\
+		}								\
 	} while (0)
 
 	if (sta->he_cap.has_he) {
-- 
2.29.2

