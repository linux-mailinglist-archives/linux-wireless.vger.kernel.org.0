Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697AD322731
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Feb 2021 09:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbhBWIoD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Feb 2021 03:44:03 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:39880 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231152AbhBWIoB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Feb 2021 03:44:01 -0500
X-UUID: 42ecd92eb13c406f98656b5735e9e7fc-20210223
X-UUID: 42ecd92eb13c406f98656b5735e9e7fc-20210223
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 744885294; Tue, 23 Feb 2021 16:43:16 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 23 Feb 2021 16:43:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 23 Feb 2021 16:43:15 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/2] mt76: mt7615: fix TSF configuration
Date:   Tue, 23 Feb 2021 16:43:11 +0800
Message-ID: <61d40a20375f888c122ee0e186168fc2db863fc3.1614058187.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The index of TSF counters should follow HWBSSID.

Fixes: cd795267612d ("mt76: mt7615: support 16 interfaces")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c  |  6 +++++-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 16 ++++++++++++++--
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h |  7 ++++---
 .../net/wireless/mediatek/mt76/mt7615/usb_sdio.c |  6 +++++-
 4 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index f2dd56674acb..df2dc77a323a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1005,6 +1005,7 @@ void mt7615_mac_set_rates(struct mt7615_phy *phy, struct mt7615_sta *sta,
 	struct mt7615_dev *dev = phy->dev;
 	struct mt7615_rate_desc rd;
 	u32 w5, w27, addr;
+	u16 idx = sta->vif->mt76.omac_idx;
 
 	if (!mt76_is_mmio(&dev->mt76)) {
 		mt7615_mac_queue_rate_update(phy, sta, probe_rate, rates);
@@ -1056,7 +1057,10 @@ void mt7615_mac_set_rates(struct mt7615_phy *phy, struct mt7615_sta *sta,
 
 	mt76_wr(dev, addr + 27 * 4, w27);
 
-	mt76_set(dev, MT_LPON_T0CR, MT_LPON_T0CR_MODE); /* TSF read */
+	idx = idx > HW_BSSID_MAX ? HW_BSSID_0 : idx;
+	addr = idx > 1 ? MT_LPON_TCR2(idx): MT_LPON_TCR0(idx);
+
+	mt76_set(dev, addr, MT_LPON_TCR_MODE); /* TSF read */
 	sta->rate_set_tsf = mt76_rr(dev, MT_LPON_UTTR0) & ~BIT(0);
 	sta->rate_set_tsf |= rd.rateset;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 1cf40f85eb55..68accb37ea28 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -818,15 +818,21 @@ mt7615_get_stats(struct ieee80211_hw *hw,
 static u64
 mt7615_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 {
+	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	union {
 		u64 t64;
 		u32 t32[2];
 	} tsf;
+	u16 idx = mvif->mt76.omac_idx;
+	u32 reg;
+
+	idx = idx > HW_BSSID_MAX ? HW_BSSID_0 : idx;
+	reg = idx > 1 ? MT_LPON_TCR2(idx): MT_LPON_TCR0(idx);
 
 	mt7615_mutex_acquire(dev);
 
-	mt76_set(dev, MT_LPON_T0CR, MT_LPON_T0CR_MODE); /* TSF read */
+	mt76_set(dev, reg, MT_LPON_TCR_MODE); /* TSF read */
 	tsf.t32[0] = mt76_rr(dev, MT_LPON_UTTR0);
 	tsf.t32[1] = mt76_rr(dev, MT_LPON_UTTR1);
 
@@ -839,18 +845,24 @@ static void
 mt7615_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	       u64 timestamp)
 {
+	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	union {
 		u64 t64;
 		u32 t32[2];
 	} tsf = { .t64 = timestamp, };
+	u16 idx = mvif->mt76.omac_idx;
+	u32 reg;
+
+	idx = idx > HW_BSSID_MAX ? HW_BSSID_0 : idx;
+	reg = idx > 1 ? MT_LPON_TCR2(idx): MT_LPON_TCR0(idx);
 
 	mt7615_mutex_acquire(dev);
 
 	mt76_wr(dev, MT_LPON_UTTR0, tsf.t32[0]);
 	mt76_wr(dev, MT_LPON_UTTR1, tsf.t32[1]);
 	/* TSF software overwrite */
-	mt76_set(dev, MT_LPON_T0CR, MT_LPON_T0CR_WRITE);
+	mt76_set(dev, reg, MT_LPON_TCR_WRITE);
 
 	mt7615_mutex_release(dev);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 1fd7f183629e..190a02670795 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -449,9 +449,10 @@ enum mt7615_reg_base {
 
 #define MT_LPON(_n)			((dev)->reg_map[MT_LPON_BASE] + (_n))
 
-#define MT_LPON_T0CR			MT_LPON(0x010)
-#define MT_LPON_T0CR_MODE		GENMASK(1, 0)
-#define MT_LPON_T0CR_WRITE		BIT(0)
+#define MT_LPON_TCR0(_n)		MT_LPON(0x010 + ((_n) * 4))
+#define MT_LPON_TCR2(_n)		MT_LPON(0x0f8 + ((_n) - 2) * 4)
+#define MT_LPON_TCR_MODE		GENMASK(1, 0)
+#define MT_LPON_TCR_WRITE		BIT(0)
 
 #define MT_LPON_UTTR0			MT_LPON(0x018)
 #define MT_LPON_UTTR1			MT_LPON(0x01c)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
index 203256862dfd..4a370b9f7a17 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
@@ -67,6 +67,7 @@ static int mt7663_usb_sdio_set_rates(struct mt7615_dev *dev,
 	struct mt7615_rate_desc *rate = &wrd->rate;
 	struct mt7615_sta *sta = wrd->sta;
 	u32 w5, w27, addr, val;
+	u16 idx = sta->vif->mt76.omac_idx;
 
 	lockdep_assert_held(&dev->mt76.mutex);
 
@@ -118,7 +119,10 @@ static int mt7663_usb_sdio_set_rates(struct mt7615_dev *dev,
 
 	sta->rate_probe = sta->rateset[rate->rateset].probe_rate.idx != -1;
 
-	mt76_set(dev, MT_LPON_T0CR, MT_LPON_T0CR_MODE); /* TSF read */
+	idx = idx > HW_BSSID_MAX ? HW_BSSID_0 : idx;
+	addr = idx > 1 ? MT_LPON_TCR2(idx): MT_LPON_TCR0(idx);
+
+	mt76_set(dev, addr, MT_LPON_TCR_MODE); /* TSF read */
 	val = mt76_rr(dev, MT_LPON_UTTR0);
 	sta->rate_set_tsf = (val & ~BIT(0)) | rate->rateset;
 
-- 
2.18.0

