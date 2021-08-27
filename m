Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7E03F9512
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Aug 2021 09:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244441AbhH0H0q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Aug 2021 03:26:46 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:41828 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S244307AbhH0H0o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Aug 2021 03:26:44 -0400
X-UUID: 4a4e095ec80340c19b7208d101e7bf8b-20210827
X-UUID: 4a4e095ec80340c19b7208d101e7bf8b-20210827
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 977623185; Fri, 27 Aug 2021 15:25:51 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 27 Aug 2021 15:25:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 27 Aug 2021 15:25:49 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: mt7915: fix 'nrates' is uninitialized when used here
Date:   Fri, 27 Aug 2021 15:25:38 +0800
Message-ID: <6bacb2514f00d8483d24f60e232718923f16890c.1630048924.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:2105:3: warning:
variable 'nrates' is uninitialized when used here [-Wuninitialized]

Fixes: 48469214f50c ("mt76: mt7915: rework .set_bitrate_mask() to support more options")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 8141a42b2d0b..4e6d9e20cc00 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2092,7 +2092,7 @@ mt7915_mcu_add_rate_ctrl_fixed(struct mt7915_dev *dev,
 	struct cfg80211_bitrate_mask *mask = &mvif->bitrate_mask;
 	enum nl80211_band band = chandef->chan->band;
 	struct sta_phy phy = {};
-	int ret, nrates;
+	int ret, nrates = 0;
 
 #define __sta_phy_bitrate_mask_check(_mcs, _gi, _he)				\
 	do {									\
-- 
2.29.2

