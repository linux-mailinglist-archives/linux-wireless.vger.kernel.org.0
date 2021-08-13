Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662C03EB9FE
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Aug 2021 18:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbhHMQXI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Aug 2021 12:23:08 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:35098 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234602AbhHMQXF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Aug 2021 12:23:05 -0400
X-UUID: 377ad004ffee4e7e803f7f203478a9b4-20210814
X-UUID: 377ad004ffee4e7e803f7f203478a9b4-20210814
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 749336315; Sat, 14 Aug 2021 00:22:36 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 14 Aug 2021 00:22:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 14 Aug 2021 00:22:34 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v3 2/3] mt76: mt7915: rework .set_bitrate_mask() to support more options
Date:   Sat, 14 Aug 2021 00:22:31 +0800
Message-ID: <9c1ce62c3e80f394cee26d04cbd05c2ab341814e.1628871454.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <1c3fc7ff6d5ab129a58160cd878787d9fbeba9c2.1628871454.git.ryder.lee@mediatek.com>
References: <1c3fc7ff6d5ab129a58160cd878787d9fbeba9c2.1628871454.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With this patch, driver can support single rate, (HE)GI and HE_LTF
configuration through .set_bitrate_mask().

Tested-by: MeiChia Chiu <meichia.chiu@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
v3: fix a macro naming error
v2: fix an enum warning
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  32 ++--
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 148 +++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  16 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   5 +
 5 files changed, 175 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 5349736eac73..0ed86cbf722b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -101,7 +101,7 @@ bool mt7915_mac_wtbl_update(struct mt7915_dev *dev, int idx, u32 mask)
 			 0, 5000);
 }
 
-static u32 mt7915_mac_wtbl_lmac_addr(struct mt7915_dev *dev, u16 wcid, u8 dw)
+u32 mt7915_mac_wtbl_lmac_addr(struct mt7915_dev *dev, u16 wcid, u8 dw)
 {
 	mt76_wr(dev, MT_WTBLON_TOP_WDUCR,
 		FIELD_PREP(MT_WTBLON_TOP_WDUCR_GROUP, (wcid >> 7)));
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 20b47ac33083..9f9ad3a75122 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -172,6 +172,9 @@ static void mt7915_init_bitrate_mask(struct ieee80211_vif *vif)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(mvif->bitrate_mask.control); i++) {
+		mvif->bitrate_mask.control[i].gi = NL80211_TXRATE_DEFAULT_GI;
+		mvif->bitrate_mask.control[i].he_gi = GENMASK(7, 0);
+		mvif->bitrate_mask.control[i].he_ltf = GENMASK(7, 0);
 		mvif->bitrate_mask.control[i].legacy = GENMASK(31, 0);
 		memset(mvif->bitrate_mask.control[i].ht_mcs, GENMASK(7, 0),
 		       sizeof(mvif->bitrate_mask.control[i].ht_mcs));
@@ -952,7 +955,6 @@ static void mt7915_sta_rc_work(void *data, struct ieee80211_sta *sta)
 {
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
 	struct mt7915_dev *dev = msta->vif->phy->dev;
-	struct ieee80211_hw *hw = msta->vif->phy->mt76->hw;
 	u32 *changed = data;
 
 	spin_lock_bh(&dev->sta_poll_lock);
@@ -960,8 +962,6 @@ static void mt7915_sta_rc_work(void *data, struct ieee80211_sta *sta)
 	if (list_empty(&msta->rc_list))
 		list_add_tail(&msta->rc_list, &dev->sta_rc_list);
 	spin_unlock_bh(&dev->sta_poll_lock);
-
-	ieee80211_queue_work(hw, &dev->rc_work);
 }
 
 static void mt7915_sta_rc_update(struct ieee80211_hw *hw,
@@ -969,7 +969,11 @@ static void mt7915_sta_rc_update(struct ieee80211_hw *hw,
 				 struct ieee80211_sta *sta,
 				 u32 changed)
 {
+	struct mt7915_phy *phy = mt7915_hw_phy(hw);
+	struct mt7915_dev *dev = phy->dev;
+
 	mt7915_sta_rc_work(&changed, sta);
+	ieee80211_queue_work(hw, &dev->rc_work);
 }
 
 static int
@@ -977,22 +981,22 @@ mt7915_set_bitrate_mask(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			const struct cfg80211_bitrate_mask *mask)
 {
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	enum nl80211_band band = mvif->phy->mt76->chandef.chan->band;
-	u32 changed;
-
-	if (mask->control[band].gi == NL80211_TXRATE_FORCE_LGI)
-		return -EINVAL;
+	struct mt7915_phy *phy = mt7915_hw_phy(hw);
+	struct mt7915_dev *dev = phy->dev;
+	u32 changed = IEEE80211_RC_SUPP_RATES_CHANGED;
 
-	changed = IEEE80211_RC_SUPP_RATES_CHANGED;
 	mvif->bitrate_mask = *mask;
 
-	/* Update firmware rate control to add a boundary on top of table
-	 * to limit the rate selection for each peer, so when set bitrates
-	 * vht-mcs-5 1:9, which actually means nss = 1 mcs = 0~9. This only
-	 * applies to data frames as for the other mgmt, mcast, bcast still
-	 * use legacy rates as it is.
+	/* if multiple rates across different preambles are given we can
+	 * reconfigure this info with all peers using sta_rec command with
+	 * the below exception cases.
+	 * - single rate : if a rate is passed along with different preambles,
+	 * we select the highest one as fixed rate. i.e VHT MCS for VHT peers.
+	 * - multiple rates: if it's not in range format i.e 0-{7,8,9} for VHT
+	 * then multiple MCS setting (MCS 4,5,6) is not supported.
 	 */
 	ieee80211_iterate_stations_atomic(hw, mt7915_sta_rc_work, &changed);
+	ieee80211_queue_work(hw, &dev->rc_work);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 028ee5bb0532..25086f8f76c1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2042,6 +2042,128 @@ mt7915_mcu_add_txbf(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	return 0;
 }
 
+int mt7915_mcu_set_fixed_rate_ctrl(struct mt7915_dev *dev,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_sta *sta,
+				   void *data, u32 field)
+{
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	struct sta_phy *phy = data;
+	struct sta_rec_ra_fixed *ra;
+	struct sk_buff *skb;
+	struct tlv *tlv;
+	int len = sizeof(struct sta_req_hdr) + sizeof(*ra);
+
+	skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta, len);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	tlv = mt7915_mcu_add_tlv(skb, STA_REC_RA_UPDATE, sizeof(*ra));
+	ra = (struct sta_rec_ra_fixed *)tlv;
+
+	switch (field) {
+	case RATE_PARAM_AUTO:
+		break;
+	case RATE_PARAM_FIXED_MCS:
+	case RATE_PARAM_FIXED_GI:
+	case RATE_PARAM_FIXED_HE_LTF:
+		ra->phy = *phy;
+		break;
+	default:
+		break;
+	}
+	ra->field = cpu_to_le32(field);
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_EXT_CMD(STA_REC_UPDATE), true);
+}
+
+static int
+mt7915_mcu_add_rate_ctrl_fixed(struct mt7915_dev *dev,
+			       struct ieee80211_vif *vif,
+			       struct ieee80211_sta *sta)
+{
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	struct cfg80211_chan_def *chandef = &mvif->phy->mt76->chandef;
+	struct cfg80211_bitrate_mask *mask = &mvif->bitrate_mask;
+	enum nl80211_band band = chandef->chan->band;
+	struct sta_phy phy = {};
+	int ret, nrates;
+
+#define __sta_phy_bitrate_mask_check(_mcs, _gi, _he)				\
+	do {									\
+		u8 i, gi = mask->control[band]._gi;				\
+		gi = (_he) ? gi : gi == NL80211_TXRATE_FORCE_SGI;		\
+		for (i = 0; i <= sta->bandwidth; i++) {				\
+			phy.sgi |= gi << (i << (_he));				\
+			phy.he_ltf |= mask->control[band].he_ltf << (i << (_he));\
+		}								\
+		for (i = 0; i < ARRAY_SIZE(mask->control[band]._mcs); i++) 	\
+			nrates += hweight16(mask->control[band]._mcs[i]);  	\
+		phy.mcs = ffs(mask->control[band]._mcs[0]) - 1;			\
+	} while (0)
+
+	if (sta->he_cap.has_he) {
+		__sta_phy_bitrate_mask_check(he_mcs, he_gi, 1);
+	} else if (sta->vht_cap.vht_supported) {
+		__sta_phy_bitrate_mask_check(vht_mcs, gi, 0);
+	} else if (sta->ht_cap.ht_supported) {
+		__sta_phy_bitrate_mask_check(ht_mcs, gi, 0);
+	} else {
+		nrates = hweight32(mask->control[band].legacy);
+		phy.mcs = ffs(mask->control[band].legacy) - 1;
+	}
+#undef __sta_phy_bitrate_mask_check
+
+	/* fall back to auto rate control */
+	if (mask->control[band].gi == NL80211_TXRATE_DEFAULT_GI &&
+	    mask->control[band].he_gi == GENMASK(7, 0) &&
+	    mask->control[band].he_ltf == GENMASK(7, 0) &&
+	    nrates != 1)
+		return 0;
+
+	/* fixed single rate */
+	if (nrates == 1) {
+		ret = mt7915_mcu_set_fixed_rate_ctrl(dev, vif, sta, &phy,
+						     RATE_PARAM_FIXED_MCS);
+		if (ret)
+			return ret;
+	}
+
+	/* fixed GI */
+	if (mask->control[band].gi != NL80211_TXRATE_DEFAULT_GI ||
+	    mask->control[band].he_gi != GENMASK(7, 0)) {
+		struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+		u32 addr;
+
+		/* firmware updates only TXCMD but doesn't take WTBL into
+		 * account, so driver should update here to reflect the
+		 * actual txrate hardware sends out.
+		 */
+		addr = mt7915_mac_wtbl_lmac_addr(dev, msta->wcid.idx, 7);
+		if (sta->he_cap.has_he)
+			mt76_rmw_field(dev, addr, GENMASK(31, 24), phy.sgi);
+		else
+			mt76_rmw_field(dev, addr, GENMASK(15, 12), phy.sgi);
+
+		ret = mt7915_mcu_set_fixed_rate_ctrl(dev, vif, sta, &phy,
+						     RATE_PARAM_FIXED_GI);
+		if (ret)
+			return ret;
+	}
+
+	/* fixed HE_LTF */
+	if (mask->control[band].he_ltf != GENMASK(7, 0)) {
+		ret = mt7915_mcu_set_fixed_rate_ctrl(dev, vif, sta, &phy,
+						     RATE_PARAM_FIXED_HE_LTF);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static void
 mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 			     struct ieee80211_vif *vif, struct ieee80211_sta *sta)
@@ -2084,8 +2206,6 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 	}
 
 	if (sta->ht_cap.ht_supported) {
-		const u8 *mcs_mask = mask->control[band].ht_mcs;
-
 		ra->supp_mode |= MODE_HT;
 		ra->af = sta->ht_cap.ampdu_factor;
 		ra->ht_gf = !!(sta->ht_cap.cap & IEEE80211_HT_CAP_GRN_FLD);
@@ -2103,12 +2223,12 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 		    (sta->ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING))
 			cap |= STA_CAP_LDPC;
 
-		mt7915_mcu_set_sta_ht_mcs(sta, ra->ht_mcs, mcs_mask);
+		mt7915_mcu_set_sta_ht_mcs(sta, ra->ht_mcs,
+					  mask->control[band].ht_mcs);
 		ra->supp_ht_mcs = *(__le32 *)ra->ht_mcs;
 	}
 
 	if (sta->vht_cap.vht_supported) {
-		const u16 *mcs_mask = mask->control[band].vht_mcs;
 		u8 af;
 
 		ra->supp_mode |= MODE_VHT;
@@ -2129,7 +2249,8 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 		    (sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC))
 			cap |= STA_CAP_VHT_LDPC;
 
-		mt7915_mcu_set_sta_vht_mcs(sta, ra->supp_vht_mcs, mcs_mask);
+		mt7915_mcu_set_sta_vht_mcs(sta, ra->supp_vht_mcs,
+					   mask->control[band].vht_mcs);
 	}
 
 	if (sta->he_cap.has_he) {
@@ -2146,7 +2267,7 @@ int mt7915_mcu_add_rate_ctrl(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
 	struct sk_buff *skb;
-	int len;
+	int ret, len;
 
 	len = sizeof(struct sta_req_hdr) + sizeof(struct sta_rec_ra) +
 	      sizeof(struct sta_rec_he);
@@ -2161,10 +2282,21 @@ int mt7915_mcu_add_rate_ctrl(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	if (sta->he_cap.has_he && changed)
 		mt7915_mcu_sta_he_tlv(skb, sta);
 
+	/* sta_rec_ra accommodates BW, NSS and only MCS range format
+	 * i.e 0-{7,8,9} for VHT.
+	 */
 	mt7915_mcu_sta_rate_ctrl_tlv(skb, dev, vif, sta);
 
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_EXT_CMD(STA_REC_UPDATE), true);
+	ret = mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				    MCU_EXT_CMD(STA_REC_UPDATE), true);
+	if (ret)
+		return ret;
+
+	/* sta_rec_ra_fixed accommodates single rate, (HE)GI and HE_LTE,
+	 * and updates as peer fixed rate parameters, which overrides
+	 * sta_rec_ra and firmware rate control algorithm.
+	 */
+	return mt7915_mcu_add_rate_ctrl_fixed(dev, vif, sta);
 }
 
 static int
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 2b47cdf0fd17..64f06d4445fe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -871,7 +871,7 @@ struct sta_rec_sec {
 	struct sec_key key[2];
 } __packed;
 
-struct ra_phy {
+struct sta_phy {
 	u8 type;
 	u8 flag;
 	u8 stbc;
@@ -915,7 +915,7 @@ struct sta_rec_ra {
 
 	__le32 sta_cap;
 
-	struct ra_phy phy;
+	struct sta_phy phy;
 } __packed;
 
 struct sta_rec_ra_fixed {
@@ -928,7 +928,7 @@ struct sta_rec_ra_fixed {
 	u8 op_vht_rx_nss;
 	u8 op_vht_rx_nss_type;
 
-	struct ra_phy phy;
+	struct sta_phy phy;
 
 	u8 spe_en;
 	u8 short_preamble;
@@ -936,8 +936,14 @@ struct sta_rec_ra_fixed {
 	u8 mmps_mode;
 } __packed;
 
-#define RATE_PARAM_FIXED		3
-#define RATE_PARAM_AUTO			20
+enum {
+	RATE_PARAM_FIXED = 3,
+	RATE_PARAM_FIXED_HE_LTF = 7,
+	RATE_PARAM_FIXED_MCS,
+	RATE_PARAM_FIXED_GI = 11,
+	RATE_PARAM_AUTO = 20,
+};
+
 #define RATE_CFG_MCS			GENMASK(3, 0)
 #define RATE_CFG_NSS			GENMASK(7, 4)
 #define RATE_CFG_GI			GENMASK(11, 8)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index f842452af897..477a8621550a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -333,6 +333,10 @@ int mt7915_mcu_set_tx(struct mt7915_dev *dev, struct ieee80211_vif *vif);
 int mt7915_mcu_update_edca(struct mt7915_dev *dev, void *req);
 int mt7915_mcu_set_fixed_rate(struct mt7915_dev *dev,
 			      struct ieee80211_sta *sta, u32 rate);
+int mt7915_mcu_set_fixed_rate_ctrl(struct mt7915_dev *dev,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_sta *sta,
+				   void *data, u32 field);
 int mt7915_mcu_set_eeprom(struct mt7915_dev *dev);
 int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset);
 int mt7915_mcu_set_mac(struct mt7915_dev *dev, int band, bool enable,
@@ -392,6 +396,7 @@ static inline void mt7915_irq_disable(struct mt7915_dev *dev, u32 mask)
 		mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, mask, 0);
 }
 
+u32 mt7915_mac_wtbl_lmac_addr(struct mt7915_dev *dev, u16 wcid, u8 dw);
 bool mt7915_mac_wtbl_update(struct mt7915_dev *dev, int idx, u32 mask);
 void mt7915_mac_reset_counters(struct mt7915_phy *phy);
 void mt7915_mac_cca_stats_reset(struct mt7915_phy *phy);
-- 
2.29.2

