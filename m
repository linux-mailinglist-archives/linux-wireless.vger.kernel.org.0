Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD53A36B6CA
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Apr 2021 18:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbhDZQaT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Apr 2021 12:30:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37963 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233934AbhDZQaS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Apr 2021 12:30:18 -0400
X-UUID: 29b5ef8ca32c4a7685bab4b227585b43-20210427
X-UUID: 29b5ef8ca32c4a7685bab4b227585b43-20210427
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 616502870; Tue, 27 Apr 2021 00:29:34 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 27 Apr 2021 00:29:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 27 Apr 2021 00:29:32 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/2] mt76: mt7915: cleanup mt7915_mcu_sta_rate_ctrl_tlv()
Date:   Tue, 27 Apr 2021 00:29:28 +0800
Message-ID: <22e4a169831b6b54661b6eb4ef4f3a4a18dceb19.1619453772.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A59D6560AB4527EB7EB7E8A8F15E5BA29B3DA0A8F6B9F8E5B2339CB75BA24CD02000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove obsoleted codes. This is the preparation for .set_bitrate_mask().

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 76 +++++--------------
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  2 +-
 2 files changed, 22 insertions(+), 56 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index e4f5f72fff29..ed36eaf047b4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -147,10 +147,10 @@ mt7915_get_he_phy_cap(struct mt7915_phy *phy, struct ieee80211_vif *vif)
 }
 
 static u8
-mt7915_get_phy_mode(struct mt76_phy *mphy, struct ieee80211_vif *vif,
-		    struct ieee80211_sta *sta)
+mt7915_get_phy_mode(struct ieee80211_vif *vif, struct ieee80211_sta *sta)
 {
-	enum nl80211_band band = mphy->chandef.chan->band;
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	enum nl80211_band band = mvif->phy->mt76->chandef.chan->band;
 	struct ieee80211_sta_ht_cap *ht_cap;
 	struct ieee80211_sta_vht_cap *vht_cap;
 	const struct ieee80211_sta_he_cap *he_cap;
@@ -163,7 +163,7 @@ mt7915_get_phy_mode(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	} else {
 		struct ieee80211_supported_band *sband;
 
-		sband = mphy->hw->wiphy->bands[band];
+		sband = mvif->phy->mt76->hw->wiphy->bands[band];
 
 		ht_cap = &sband->ht_cap;
 		vht_cap = &sband->vht_cap;
@@ -754,7 +754,7 @@ mt7915_mcu_bss_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 		memcpy(bss->bssid, vif->bss_conf.bssid, ETH_ALEN);
 		bss->bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int);
 		bss->dtim_period = vif->bss_conf.dtim_period;
-		bss->phy_mode = mt7915_get_phy_mode(phy->mt76, vif, NULL);
+		bss->phy_mode = mt7915_get_phy_mode(vif, NULL);
 	} else {
 		memcpy(bss->bssid, phy->mt76->macaddr, ETH_ALEN);
 	}
@@ -2100,47 +2100,39 @@ static void
 mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 			     struct ieee80211_vif *vif, struct ieee80211_sta *sta)
 {
-	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
-	struct mt76_phy *mphy = &dev->mphy;
-	enum nl80211_band band;
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	struct cfg80211_chan_def *chandef = &mvif->phy->mt76->chandef;
+	enum nl80211_band band = chandef->chan->band;
 	struct sta_rec_ra *ra;
 	struct tlv *tlv;
-	u32 supp_rate, n_rates, cap = sta->wme ? STA_CAP_WMM : 0;
-	u8 i, nss = sta->rx_nss, mcs = 0;
+	u32 supp_rate = sta->supp_rates[band];
+	u32 cap = sta->wme ? STA_CAP_WMM : 0;
+	u8 i, nss = sta->rx_nss;
 
 	tlv = mt7915_mcu_add_tlv(skb, STA_REC_RA, sizeof(*ra));
 	ra = (struct sta_rec_ra *)tlv;
 
-	if (msta->wcid.ext_phy && dev->mt76.phy2)
-		mphy = dev->mt76.phy2;
-
-	band = mphy->chandef.chan->band;
-	supp_rate = sta->supp_rates[band];
-	n_rates = hweight32(supp_rate);
-
 	ra->valid = true;
 	ra->auto_rate = true;
-	ra->phy_mode = mt7915_get_phy_mode(mphy, vif, sta);
-	ra->channel = mphy->chandef.chan->hw_value;
+	ra->phy_mode = mt7915_get_phy_mode(vif, sta);
+	ra->channel = chandef->chan->hw_value;
 	ra->bw = sta->bandwidth;
-	ra->rate_len = n_rates;
-	ra->phy.bw = sta->bandwidth;
+	ra->phy.bw = mt7915_mcu_chan_bw(chandef);
+
+	if (supp_rate) {
+		ra->rate_len = hweight32(supp_rate);
 
-	if (n_rates) {
 		if (band == NL80211_BAND_2GHZ) {
 			ra->supp_mode = MODE_CCK;
 			ra->supp_cck_rate = supp_rate & GENMASK(3, 0);
-			ra->phy.type = MT_PHY_TYPE_CCK;
 
-			if (n_rates > 4) {
+			if (ra->rate_len > 4) {
 				ra->supp_mode |= MODE_OFDM;
 				ra->supp_ofdm_rate = supp_rate >> 4;
-				ra->phy.type = MT_PHY_TYPE_OFDM;
 			}
 		} else {
 			ra->supp_mode = MODE_OFDM;
 			ra->supp_ofdm_rate = supp_rate;
-			ra->phy.type = MT_PHY_TYPE_OFDM;
 		}
 	}
 
@@ -2150,7 +2142,6 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 
 		ra->supp_ht_mcs = *(__le32 *)ra->ht_mcs;
 		ra->supp_mode |= MODE_HT;
-		mcs = hweight32(le32_to_cpu(ra->supp_ht_mcs)) - 1;
 		ra->af = sta->ht_cap.ampdu_factor;
 		ra->ht_gf = !!(sta->ht_cap.cap & IEEE80211_HT_CAP_GRN_FLD);
 
@@ -2170,7 +2161,7 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 	if (sta->vht_cap.vht_supported) {
 		u16 mcs_map = le16_to_cpu(sta->vht_cap.vht_mcs.rx_mcs_map);
 		u16 vht_mcs;
-		u8 af, mcs_prev;
+		u8 af;
 
 		af = FIELD_GET(IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK,
 			       sta->vht_cap.cap);
@@ -2189,7 +2180,7 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 			cap |= STA_CAP_VHT_LDPC;
 
 		ra->supp_mode |= MODE_VHT;
-		for (mcs = 0, i = 0; i < nss; i++, mcs_map >>= 2) {
+		for (i = 0; i < nss; i++, mcs_map >>= 2) {
 			switch (mcs_map & 0x3) {
 			case IEEE80211_VHT_MCS_SUPPORT_0_9:
 				vht_mcs = GENMASK(9, 0);
@@ -2206,10 +2197,6 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 
 			ra->supp_vht_mcs[i] = cpu_to_le16(vht_mcs);
 
-			mcs_prev = hweight16(vht_mcs) - 1;
-			if (mcs_prev > mcs)
-				mcs = mcs_prev;
-
 			/* only support 2ss on 160MHz */
 			if (i > 1 && (ra->bw == CMD_CBW_160MHZ ||
 				      ra->bw == CMD_CBW_8080MHZ))
@@ -2222,28 +2209,7 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 		cap |= STA_CAP_HE;
 	}
 
-	ra->sta_status = cpu_to_le32(cap);
-
-	switch (BIT(fls(ra->supp_mode) - 1)) {
-	case MODE_VHT:
-		ra->phy.type = MT_PHY_TYPE_VHT;
-		ra->phy.mcs = mcs;
-		ra->phy.nss = nss;
-		ra->phy.stbc = !!(sta->vht_cap.cap & IEEE80211_VHT_CAP_TXSTBC);
-		ra->phy.ldpc = !!(sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC);
-		ra->phy.sgi =
-			!!(sta->vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_80);
-		break;
-	case MODE_HT:
-		ra->phy.type = MT_PHY_TYPE_HT;
-		ra->phy.mcs = mcs;
-		ra->phy.ldpc = sta->ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING;
-		ra->phy.stbc = !!(sta->ht_cap.cap & IEEE80211_HT_CAP_TX_STBC);
-		ra->phy.sgi = !!(sta->ht_cap.cap & IEEE80211_HT_CAP_SGI_20);
-		break;
-	default:
-		break;
-	}
+	ra->sta_cap = cpu_to_le32(cap);
 }
 
 int mt7915_mcu_add_rate_ctrl(struct mt7915_dev *dev, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 453e34754c86..7e3432384633 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -943,7 +943,7 @@ struct sta_rec_ra {
 	u8 op_vht_rx_nss;
 	u8 op_vht_rx_nss_type;
 
-	__le32 sta_status;
+	__le32 sta_cap;
 
 	struct ra_phy phy;
 } __packed;
-- 
2.18.0

