Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011F538FD13
	for <lists+linux-wireless@lfdr.de>; Tue, 25 May 2021 10:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhEYIqt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 May 2021 04:46:49 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38471 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230108AbhEYIqs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 May 2021 04:46:48 -0400
X-UUID: 0215012bb09d418fa5b42e62e1c6f38d-20210525
X-UUID: 0215012bb09d418fa5b42e62e1c6f38d-20210525
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1972369058; Tue, 25 May 2021 16:45:18 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 25 May 2021 16:45:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 May 2021 16:45:16 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/2] mt76: mt7915: add .offset_tsf callback
Date:   Tue, 25 May 2021 16:45:14 +0800
Message-ID: <324aa6af6a191a1f929fd3054148b001acd0bd13.1621931743.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It's much more accurate than .get_tsf + .set_tsf, and switch to use
mt76_rmw to operate tsf registers.

Tested-by: Xing Song <xing.song@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 33 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  2 ++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 64f9ebe4424a..2485f65766e7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -816,7 +816,8 @@ mt7915_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 
 	n = mvif->omac_idx > HW_BSSID_MAX ? HW_BSSID_0 : mvif->omac_idx;
 	/* TSF software read */
-	mt76_set(dev, MT_LPON_TCR(band, n), MT_LPON_TCR_SW_MODE);
+	mt76_rmw(dev, MT_LPON_TCR(band, n), MT_LPON_TCR_SW_MODE,
+		 MT_LPON_TCR_SW_READ);
 	tsf.t32[0] = mt76_rr(dev, MT_LPON_UTTR0(band));
 	tsf.t32[1] = mt76_rr(dev, MT_LPON_UTTR1(band));
 
@@ -845,7 +846,34 @@ mt7915_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mt76_wr(dev, MT_LPON_UTTR0(band), tsf.t32[0]);
 	mt76_wr(dev, MT_LPON_UTTR1(band), tsf.t32[1]);
 	/* TSF software overwrite */
-	mt76_set(dev, MT_LPON_TCR(band, n), MT_LPON_TCR_SW_WRITE);
+	mt76_rmw(dev, MT_LPON_TCR(band, n), MT_LPON_TCR_SW_MODE,
+		 MT_LPON_TCR_SW_WRITE);
+
+	mutex_unlock(&dev->mt76.mutex);
+}
+
+static void
+mt7915_offset_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		  s64 timestamp)
+{
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	struct mt7915_dev *dev = mt7915_hw_dev(hw);
+	struct mt7915_phy *phy = mt7915_hw_phy(hw);
+	bool band = phy != &dev->phy;
+	union {
+		u64 t64;
+		u32 t32[2];
+	} tsf = { .t64 = timestamp, };
+	u16 n;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	n = mvif->omac_idx > HW_BSSID_MAX ? HW_BSSID_0 : mvif->omac_idx;
+	mt76_wr(dev, MT_LPON_UTTR0(band), tsf.t32[0]);
+	mt76_wr(dev, MT_LPON_UTTR1(band), tsf.t32[1]);
+	/* TSF software adjust*/
+	mt76_rmw(dev, MT_LPON_TCR(band, n), MT_LPON_TCR_SW_MODE,
+		 MT_LPON_TCR_SW_ADJUST);
 
 	mutex_unlock(&dev->mt76.mutex);
 }
@@ -1036,6 +1064,7 @@ const struct ieee80211_ops mt7915_ops = {
 	.get_stats = mt7915_get_stats,
 	.get_tsf = mt7915_get_tsf,
 	.set_tsf = mt7915_set_tsf,
+	.offset_tsf = mt7915_offset_tsf,
 	.get_survey = mt76_get_survey,
 	.get_antenna = mt76_get_antenna,
 	.set_antenna = mt7915_set_antenna,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index efe0f2904c66..e36b30d84f07 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -124,6 +124,8 @@
 #define MT_LPON_TCR(_band, n)		MT_WF_LPON(_band, 0x0a8 + (n) * 4)
 #define MT_LPON_TCR_SW_MODE		GENMASK(1, 0)
 #define MT_LPON_TCR_SW_WRITE		BIT(0)
+#define MT_LPON_TCR_SW_ADJUST		BIT(1)
+#define MT_LPON_TCR_SW_READ		GENMASK(1, 0)
 
 /* MIB: band 0(0x24800), band 1(0xa4800) */
 #define MT_WF_MIB_BASE(_band)		((_band) ? 0xa4800 : 0x24800)
-- 
2.18.0

