Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B942438FDB4
	for <lists+linux-wireless@lfdr.de>; Tue, 25 May 2021 11:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbhEYJYZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 May 2021 05:24:25 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:45158 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232504AbhEYJYY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 May 2021 05:24:24 -0400
X-UUID: df90bbf044104379a39f9e811da3080c-20210525
X-UUID: df90bbf044104379a39f9e811da3080c-20210525
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 27936580; Tue, 25 May 2021 17:22:52 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 25 May 2021 17:22:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 May 2021 17:22:29 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2] mt76: mt7615: add .offset_tsf callback
Date:   Tue, 25 May 2021 17:22:24 +0800
Message-ID: <b9527ceb21b93ad948ebfed07867e75f8168e065.1621933933.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It's much more accurate than .get_tsf + .set_tsf and switch to use
mt76_rmw to operate tsf registers.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
change since v2: fix mutex
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 32 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |  2 ++
 .../wireless/mediatek/mt76/mt7615/usb_sdio.c  |  2 +-
 4 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 71af122a0b38..2ac7d0b0eff4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1125,7 +1125,7 @@ void mt7615_mac_set_rates(struct mt7615_phy *phy, struct mt7615_sta *sta,
 	idx = idx > HW_BSSID_MAX ? HW_BSSID_0 : idx;
 	addr = idx > 1 ? MT_LPON_TCR2(idx): MT_LPON_TCR0(idx);
 
-	mt76_set(dev, addr, MT_LPON_TCR_MODE); /* TSF read */
+	mt76_rmw(dev, addr, MT_LPON_TCR_MODE, MT_LPON_TCR_READ); /* TSF read */
 	sta->rate_set_tsf = mt76_rr(dev, MT_LPON_UTTR0) & ~BIT(0);
 	sta->rate_set_tsf |= rd.rateset;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index e36c52290985..2164f736dd72 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -891,7 +891,8 @@ mt7615_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 
 	mt7615_mutex_acquire(dev);
 
-	mt76_set(dev, reg, MT_LPON_TCR_MODE); /* TSF read */
+	/* TSF read */
+	mt76_rmw(dev, reg, MT_LPON_TCR_MODE, MT_LPON_TCR_READ);
 	tsf.t32[0] = mt76_rr(dev, MT_LPON_UTTR0);
 	tsf.t32[1] = mt76_rr(dev, MT_LPON_UTTR1);
 
@@ -921,7 +922,33 @@ mt7615_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mt76_wr(dev, MT_LPON_UTTR0, tsf.t32[0]);
 	mt76_wr(dev, MT_LPON_UTTR1, tsf.t32[1]);
 	/* TSF software overwrite */
-	mt76_set(dev, reg, MT_LPON_TCR_WRITE);
+	mt76_rmw(dev, reg, MT_LPON_TCR_MODE, MT_LPON_TCR_WRITE);
+
+	mt7615_mutex_release(dev);
+}
+
+static void
+mt7615_offset_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		  s64 timestamp)
+{
+	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
+	union {
+		u64 t64;
+		u32 t32[2];
+	} tsf = { .t64 = timestamp, };
+	u16 idx = mvif->mt76.omac_idx;
+	u32 reg;
+
+	idx = idx > HW_BSSID_MAX ? HW_BSSID_0 : idx;
+	reg = idx > 1 ? MT_LPON_TCR2(idx): MT_LPON_TCR0(idx);
+
+	mt7615_mutex_acquire(dev);
+
+	mt76_wr(dev, MT_LPON_UTTR0, tsf.t32[0]);
+	mt76_wr(dev, MT_LPON_UTTR1, tsf.t32[1]);
+	/* TSF software adjust*/
+	mt76_rmw(dev, reg, MT_LPON_TCR_MODE, MT_LPON_TCR_ADJUST);
 
 	mt7615_mutex_release(dev);
 }
@@ -1308,6 +1335,7 @@ const struct ieee80211_ops mt7615_ops = {
 	.get_stats = mt7615_get_stats,
 	.get_tsf = mt7615_get_tsf,
 	.set_tsf = mt7615_set_tsf,
+	.offset_tsf = mt7615_offset_tsf,
 	.get_survey = mt76_get_survey,
 	.get_antenna = mt76_get_antenna,
 	.set_antenna = mt7615_set_antenna,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 63c081bb04d0..6712ad9faeaa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -463,7 +463,9 @@ enum mt7615_reg_base {
 #define MT_LPON_TCR0(_n)		MT_LPON(0x010 + ((_n) * 4))
 #define MT_LPON_TCR2(_n)		MT_LPON(0x0f8 + ((_n) - 2) * 4)
 #define MT_LPON_TCR_MODE		GENMASK(1, 0)
+#define MT_LPON_TCR_READ		GENMASK(1, 0)
 #define MT_LPON_TCR_WRITE		BIT(0)
+#define MT_LPON_TCR_ADJUST		BIT(1)
 
 #define MT_LPON_UTTR0			MT_LPON(0x018)
 #define MT_LPON_UTTR1			MT_LPON(0x01c)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
index 75a05f8dd7e7..996d48cca18a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
@@ -123,7 +123,7 @@ static int mt7663_usb_sdio_set_rates(struct mt7615_dev *dev,
 	idx = idx > HW_BSSID_MAX ? HW_BSSID_0 : idx;
 	addr = idx > 1 ? MT_LPON_TCR2(idx): MT_LPON_TCR0(idx);
 
-	mt76_set(dev, addr, MT_LPON_TCR_MODE); /* TSF read */
+	mt76_rmw(dev, addr, MT_LPON_TCR_MODE, MT_LPON_TCR_READ); /* TSF read */
 	val = mt76_rr(dev, MT_LPON_UTTR0);
 	sta->rate_set_tsf = (val & ~BIT(0)) | rate->rateset;
 
-- 
2.18.0

