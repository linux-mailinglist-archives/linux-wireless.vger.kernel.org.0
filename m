Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2727326C23
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Feb 2021 08:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhB0HlP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 Feb 2021 02:41:15 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58991 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229835AbhB0HlO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 Feb 2021 02:41:14 -0500
X-UUID: ffe19a9dd6f1403b847c633712059e09-20210227
X-UUID: ffe19a9dd6f1403b847c633712059e09-20210227
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2118187591; Sat, 27 Feb 2021 15:40:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 27 Feb 2021 15:40:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 27 Feb 2021 15:40:25 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 5/5] mt76: mt7915: fix PHY mode for DBDC
Date:   Sat, 27 Feb 2021 15:39:46 +0800
Message-ID: <131cd1018ac752d4250a8e6abb8b841707275424.1614411256.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <d6f2573790582538e8ba82f87a4c35329692ee32.1614411256.git.ryder.lee@mediatek.com>
References: <d6f2573790582538e8ba82f87a4c35329692ee32.1614411256.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C580781EF9BD32FA0D43A1F34BA3C0A4545597197217040140EA547A0C68B3492000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix PHY mode configuration for DBDC.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 40 +++++++++----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 4abe32357edc..e0c03b7f278d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -147,9 +147,10 @@ mt7915_get_he_phy_cap(struct mt7915_phy *phy, struct ieee80211_vif *vif)
 }
 
 static u8
-mt7915_get_phy_mode(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-		    enum nl80211_band band, struct ieee80211_sta *sta)
+mt7915_get_phy_mode(struct mt76_phy *mphy, struct ieee80211_vif *vif,
+		    struct ieee80211_sta *sta)
 {
+	enum nl80211_band band = mphy->chandef.chan->band;
 	struct ieee80211_sta_ht_cap *ht_cap;
 	struct ieee80211_sta_vht_cap *vht_cap;
 	const struct ieee80211_sta_he_cap *he_cap;
@@ -161,12 +162,8 @@ mt7915_get_phy_mode(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		he_cap = &sta->he_cap;
 	} else {
 		struct ieee80211_supported_band *sband;
-		struct mt7915_phy *phy;
-		struct mt7915_vif *mvif;
 
-		mvif = (struct mt7915_vif *)vif->drv_priv;
-		phy = mvif->band_idx ? mt7915_ext_phy(dev) : &dev->phy;
-		sband = phy->mt76->hw->wiphy->bands[band];
+		sband = mphy->hw->wiphy->bands[band];
 
 		ht_cap = &sband->ht_cap;
 		vht_cap = &sband->vht_cap;
@@ -676,8 +673,6 @@ mt7915_mcu_bss_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 			 struct mt7915_phy *phy, bool enable)
 {
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
-	enum nl80211_band band = chandef->chan->band;
 	struct bss_info_basic *bss;
 	u16 wlan_idx = mvif->sta.wcid.idx;
 	u32 type = NETWORK_INFRA;
@@ -727,7 +722,7 @@ mt7915_mcu_bss_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 		memcpy(bss->bssid, vif->bss_conf.bssid, ETH_ALEN);
 		bss->bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int);
 		bss->dtim_period = vif->bss_conf.dtim_period;
-		bss->phy_mode = mt7915_get_phy_mode(phy->dev, vif, band, NULL);
+		bss->phy_mode = mt7915_get_phy_mode(phy->mt76, vif, NULL);
 	} else {
 		memcpy(bss->bssid, phy->mt76->macaddr, ETH_ALEN);
 	}
@@ -2069,25 +2064,30 @@ mt7915_mcu_add_txbf(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 
 static void
 mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
-			     struct ieee80211_vif *vif,
-			     struct ieee80211_sta *sta)
+			     struct ieee80211_vif *vif, struct ieee80211_sta *sta)
 {
-	struct cfg80211_chan_def *chandef = &dev->mphy.chandef;
+	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	struct mt76_phy *mphy = &dev->mphy;
+	enum nl80211_band band;
 	struct sta_rec_ra *ra;
 	struct tlv *tlv;
-	enum nl80211_band band = chandef->chan->band;
-	u32 supp_rate = sta->supp_rates[band];
-	int n_rates = hweight32(supp_rate);
-	u32 cap = sta->wme ? STA_CAP_WMM : 0;
+	u32 supp_rate, n_rates, cap = sta->wme ? STA_CAP_WMM : 0;
 	u8 i, nss = sta->rx_nss, mcs = 0;
 
 	tlv = mt7915_mcu_add_tlv(skb, STA_REC_RA, sizeof(*ra));
-
 	ra = (struct sta_rec_ra *)tlv;
+
+	if (msta->wcid.ext_phy && dev->mt76.phy2)
+		mphy = dev->mt76.phy2;
+
+	band = mphy->chandef.chan->band;
+	supp_rate = sta->supp_rates[band];
+	n_rates = hweight32(supp_rate);
+
 	ra->valid = true;
 	ra->auto_rate = true;
-	ra->phy_mode = mt7915_get_phy_mode(dev, vif, band, sta);
-	ra->channel = chandef->chan->hw_value;
+	ra->phy_mode = mt7915_get_phy_mode(mphy, vif, sta);
+	ra->channel = mphy->chandef.chan->hw_value;
 	ra->bw = sta->bandwidth;
 	ra->rate_len = n_rates;
 	ra->phy.bw = sta->bandwidth;
-- 
2.18.0

