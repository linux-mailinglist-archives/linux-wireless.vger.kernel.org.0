Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF54936BBFD
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Apr 2021 01:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhDZXPV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Apr 2021 19:15:21 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:34335 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232295AbhDZXPU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Apr 2021 19:15:20 -0400
X-UUID: 1e4db6f227634cd28364c89f609e35a0-20210427
X-UUID: 1e4db6f227634cd28364c89f609e35a0-20210427
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 205369428; Tue, 27 Apr 2021 07:14:36 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 27 Apr 2021 07:14:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 27 Apr 2021 07:14:29 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 2/2] mt76: mt7915: add .set_bitrate_mask() callback
Date:   Tue, 27 Apr 2021 07:14:27 +0800
Message-ID: <48e6ce961a5f786951d622cec2a599df8d184150.1619473996.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <03a1bc7eaea3e5818ca8268f72077a10f85a8bc9.1619473996.git.ryder.lee@mediatek.com>
References: <03a1bc7eaea3e5818ca8268f72077a10f85a8bc9.1619473996.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 744BCABB0860ADCA6952C34E3AC0A68CFFC4FF66256BAED07D7151B59AD2271D2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add runtime configuration for bitrate mask. This update firmware rate
control to add a boundary on top of table to limit the rate selection
for each peer, so when user set bitrates vht-mcs-5 1:9, which actually
means nss = 1 mcs = 0~9. This only applies to data frames as for other
mgmt, mcast, bcast still use legacy rates as it is.

Note that driver does not support GI configuration.

Example:
iw dev wlan0 set bitrates vht-mcs-5 1:9 he-mcs-5 2:7
iw dev wlan0 set bitrates legacy-5 6 he-mcs-5 2:0-11

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
changes since v2 - add more comments to describe how it works.
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |   4 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  64 +++++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 185 ++++++++++++++----
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   3 +
 4 files changed, 213 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 6a4b57509751..67ab268e1aad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1775,8 +1775,10 @@ void mt7915_mac_sta_rc_work(struct work_struct *work)
 
 		if (changed & (IEEE80211_RC_SUPP_RATES_CHANGED |
 			       IEEE80211_RC_NSS_CHANGED |
-			       IEEE80211_RC_BW_CHANGED))
+			       IEEE80211_RC_BW_CHANGED)) {
+			mt7915_mcu_add_he(dev, vif, sta);
 			mt7915_mcu_add_rate_ctrl(dev, vif, sta);
+		}
 
 		if (changed & IEEE80211_RC_SMPS_CHANGED)
 			mt7915_mcu_add_smps(dev, vif, sta);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index e5bd687546b6..64f9ebe4424a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -172,6 +172,22 @@ static int get_omac_idx(enum nl80211_iftype type, u64 mask)
 	return -1;
 }
 
+static void mt7915_init_bitrate_mask(struct ieee80211_vif *vif)
+{
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mvif->bitrate_mask.control); i++) {
+		mvif->bitrate_mask.control[i].legacy = GENMASK(31, 0);
+		memset(mvif->bitrate_mask.control[i].ht_mcs, GENMASK(7, 0),
+		       sizeof(mvif->bitrate_mask.control[i].ht_mcs));
+		memset(mvif->bitrate_mask.control[i].vht_mcs, GENMASK(15, 0),
+		       sizeof(mvif->bitrate_mask.control[i].vht_mcs));
+		memset(mvif->bitrate_mask.control[i].he_mcs, GENMASK(15, 0),
+		       sizeof(mvif->bitrate_mask.control[i].he_mcs));
+	}
+}
+
 static int mt7915_add_interface(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif)
 {
@@ -241,6 +257,8 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 		vif->offload_flags = 0;
 	vif->offload_flags |= IEEE80211_OFFLOAD_ENCAP_4ADDR;
 
+	mt7915_init_bitrate_mask(vif);
+
 out:
 	mutex_unlock(&dev->mt76.mutex);
 
@@ -911,17 +929,15 @@ static void mt7915_sta_statistics(struct ieee80211_hw *hw,
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 }
 
-static void
-mt7915_sta_rc_update(struct ieee80211_hw *hw,
-		     struct ieee80211_vif *vif,
-		     struct ieee80211_sta *sta,
-		     u32 changed)
+static void mt7915_sta_rc_work(void *data, struct ieee80211_sta *sta)
 {
-	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	struct mt7915_dev *dev = msta->vif->phy->dev;
+	struct ieee80211_hw *hw = msta->vif->phy->mt76->hw;
+	u32 *changed = data;
 
 	spin_lock_bh(&dev->sta_poll_lock);
-	msta->stats.changed |= changed;
+	msta->stats.changed |= *changed;
 	if (list_empty(&msta->rc_list))
 		list_add_tail(&msta->rc_list, &dev->sta_rc_list);
 	spin_unlock_bh(&dev->sta_poll_lock);
@@ -929,6 +945,39 @@ mt7915_sta_rc_update(struct ieee80211_hw *hw,
 	ieee80211_queue_work(hw, &dev->rc_work);
 }
 
+static void mt7915_sta_rc_update(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_sta *sta,
+				 u32 changed)
+{
+	mt7915_sta_rc_work(&changed, sta);
+}
+
+static int
+mt7915_set_bitrate_mask(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			const struct cfg80211_bitrate_mask *mask)
+{
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	enum nl80211_band band = mvif->phy->mt76->chandef.chan->band;
+	u32 changed;
+
+	if (mask->control[band].gi == NL80211_TXRATE_FORCE_LGI)
+		return -EINVAL;
+
+	changed = IEEE80211_RC_SUPP_RATES_CHANGED;
+	mvif->bitrate_mask = *mask;
+
+	/* Update firmware rate control to add a boundary on top of table
+	 * to limit the rate selection for each peer, so when set bitrates
+	 * vht-mcs-5 1:9, which actually means nss = 1 mcs = 0~9. This only
+	 * applies to data frames as for the other mgmt, mcast, bcast still
+	 * use legacy rates as it is.
+	 */
+	ieee80211_iterate_stations_atomic(hw, mt7915_sta_rc_work, &changed);
+
+	return 0;
+}
+
 static void mt7915_sta_set_4addr(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_sta *sta,
@@ -990,6 +1039,7 @@ const struct ieee80211_ops mt7915_ops = {
 	.get_survey = mt76_get_survey,
 	.get_antenna = mt76_get_antenna,
 	.set_antenna = mt7915_set_antenna,
+	.set_bitrate_mask = mt7915_set_bitrate_mask,
 	.set_coverage_class = mt7915_set_coverage_class,
 	.sta_statistics = mt7915_sta_statistics,
 	.sta_set_4addr = mt7915_sta_set_4addr,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 90bca50be099..9cf62e143e30 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -209,6 +209,112 @@ mt7915_mcu_get_sta_nss(u16 mcs_map)
 	return nss - 1;
 }
 
+static void
+mt7915_mcu_set_sta_he_mcs(struct ieee80211_sta *sta, __le16 *he_mcs,
+			  const u16 *mask)
+{
+	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	struct cfg80211_chan_def *chandef = &msta->vif->phy->mt76->chandef;
+	int nss, max_nss = sta->rx_nss > 3 ? 4 : sta->rx_nss;
+	u16 mcs_map;
+
+	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_80P80:
+		mcs_map = le16_to_cpu(sta->he_cap.he_mcs_nss_supp.rx_mcs_80p80);
+		break;
+	case NL80211_CHAN_WIDTH_160:
+		mcs_map = le16_to_cpu(sta->he_cap.he_mcs_nss_supp.rx_mcs_160);
+		break;
+	default:
+		mcs_map = le16_to_cpu(sta->he_cap.he_mcs_nss_supp.rx_mcs_80);
+		break;
+	}
+
+	for (nss = 0; nss < max_nss; nss++) {
+		int mcs;
+
+		switch ((mcs_map >> (2 * nss)) & 0x3) {
+		case IEEE80211_HE_MCS_SUPPORT_0_11:
+			mcs = GENMASK(11, 0);
+			break;
+		case IEEE80211_HE_MCS_SUPPORT_0_9:
+			mcs = GENMASK(9, 0);
+			break;
+		case IEEE80211_HE_MCS_SUPPORT_0_7:
+			mcs = GENMASK(7, 0);
+			break;
+		default:
+			mcs = 0;
+		}
+
+		mcs = mcs ? fls(mcs & mask[nss]) - 1 : -1;
+
+		switch (mcs) {
+		case 0 ... 7:
+			mcs = IEEE80211_HE_MCS_SUPPORT_0_7;
+			break;
+		case 8 ... 9:
+			mcs = IEEE80211_HE_MCS_SUPPORT_0_9;
+			break;
+		case 10 ... 11:
+			mcs = IEEE80211_HE_MCS_SUPPORT_0_11;
+			break;
+		default:
+			mcs = IEEE80211_HE_MCS_NOT_SUPPORTED;
+			break;
+		}
+		mcs_map &= ~(0x3 << (nss * 2));
+		mcs_map |= mcs << (nss * 2);
+
+		/* only support 2ss on 160MHz */
+		if (nss > 1 && (sta->bandwidth == IEEE80211_STA_RX_BW_160))
+			break;
+	}
+
+	*he_mcs = cpu_to_le16(mcs_map);
+}
+
+static void
+mt7915_mcu_set_sta_vht_mcs(struct ieee80211_sta *sta, __le16 *vht_mcs,
+			   const u16 *mask)
+{
+	u16 mcs_map = le16_to_cpu(sta->vht_cap.vht_mcs.rx_mcs_map);
+	int nss, max_nss = sta->rx_nss > 3 ? 4 : sta->rx_nss;
+	u16 mcs;
+
+	for (nss = 0; nss < max_nss; nss++, mcs_map >>= 2) {
+		switch (mcs_map & 0x3) {
+		case IEEE80211_VHT_MCS_SUPPORT_0_9:
+			mcs = GENMASK(9, 0);
+			break;
+		case IEEE80211_VHT_MCS_SUPPORT_0_8:
+			mcs = GENMASK(8, 0);
+			break;
+		case IEEE80211_VHT_MCS_SUPPORT_0_7:
+			mcs = GENMASK(7, 0);
+			break;
+		default:
+			mcs = 0;
+		}
+
+		vht_mcs[nss] = cpu_to_le16(mcs & mask[nss]);
+
+		/* only support 2ss on 160MHz */
+		if (nss > 1 && (sta->bandwidth == IEEE80211_STA_RX_BW_160))
+			break;
+	}
+}
+
+static void
+mt7915_mcu_set_sta_ht_mcs(struct ieee80211_sta *sta, u8 *ht_mcs,
+			  const u8 *mask)
+{
+	int nss, max_nss = sta->rx_nss > 3 ? 4 : sta->rx_nss;
+
+	for (nss = 0; nss < max_nss; nss++)
+		ht_mcs[nss] = sta->ht_cap.mcs.rx_mask[nss] & mask[nss];
+}
+
 static int
 mt7915_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			  struct sk_buff *skb, int seq)
@@ -1357,8 +1463,11 @@ mt7915_mcu_sta_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 static void
 mt7915_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 {
+	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
 	struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
 	struct ieee80211_he_cap_elem *elem = &he_cap->he_cap_elem;
+	enum nl80211_band band = msta->vif->phy->mt76->chandef.chan->band;
+	const u16 *mcs_mask = msta->vif->bitrate_mask.control[band].he_mcs;
 	struct sta_rec_he *he;
 	struct tlv *tlv;
 	u32 cap = 0;
@@ -1449,15 +1558,18 @@ mt7915_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 	case IEEE80211_STA_RX_BW_160:
 		if (elem->phy_cap_info[0] &
 		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
-			he->max_nss_mcs[CMD_HE_MCS_BW8080] =
-				he_cap->he_mcs_nss_supp.rx_mcs_80p80;
+			mt7915_mcu_set_sta_he_mcs(sta,
+						  &he->max_nss_mcs[CMD_HE_MCS_BW8080],
+						  mcs_mask);
 
-		he->max_nss_mcs[CMD_HE_MCS_BW160] =
-				he_cap->he_mcs_nss_supp.rx_mcs_160;
+		mt7915_mcu_set_sta_he_mcs(sta,
+					  &he->max_nss_mcs[CMD_HE_MCS_BW160],
+					  mcs_mask);
 		fallthrough;
 	default:
-		he->max_nss_mcs[CMD_HE_MCS_BW80] =
-				he_cap->he_mcs_nss_supp.rx_mcs_80;
+		mt7915_mcu_set_sta_he_mcs(sta,
+					  &he->max_nss_mcs[CMD_HE_MCS_BW80],
+					  mcs_mask);
 		break;
 	}
 
@@ -2102,12 +2214,12 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 {
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct cfg80211_chan_def *chandef = &mvif->phy->mt76->chandef;
+	struct cfg80211_bitrate_mask *mask = &mvif->bitrate_mask;
 	enum nl80211_band band = chandef->chan->band;
 	struct sta_rec_ra *ra;
 	struct tlv *tlv;
 	u32 supp_rate = sta->supp_rates[band];
 	u32 cap = sta->wme ? STA_CAP_WMM : 0;
-	u8 i, nss = sta->rx_nss;
 
 	tlv = mt7915_mcu_add_tlv(skb, STA_REC_RA, sizeof(*ra));
 	ra = (struct sta_rec_ra *)tlv;
@@ -2120,6 +2232,7 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 	ra->phy.bw = sta->bandwidth;
 
 	if (supp_rate) {
+		supp_rate &= mask->control[band].legacy;
 		ra->rate_len = hweight32(supp_rate);
 
 		if (band == NL80211_BAND_2GHZ) {
@@ -2137,10 +2250,8 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 	}
 
 	if (sta->ht_cap.ht_supported) {
-		for (i = 0; i < nss; i++)
-			ra->ht_mcs[i] = sta->ht_cap.mcs.rx_mask[i];
+		const u8 *mcs_mask = mask->control[band].ht_mcs;
 
-		ra->supp_ht_mcs = *(__le32 *)ra->ht_mcs;
 		ra->supp_mode |= MODE_HT;
 		ra->af = sta->ht_cap.ampdu_factor;
 		ra->ht_gf = !!(sta->ht_cap.cap & IEEE80211_HT_CAP_GRN_FLD);
@@ -2156,13 +2267,16 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 			cap |= STA_CAP_RX_STBC;
 		if (sta->ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING)
 			cap |= STA_CAP_LDPC;
+
+		mt7915_mcu_set_sta_ht_mcs(sta, ra->ht_mcs, mcs_mask);
+		ra->supp_ht_mcs = *(__le32 *)ra->ht_mcs;
 	}
 
 	if (sta->vht_cap.vht_supported) {
-		u16 mcs_map = le16_to_cpu(sta->vht_cap.vht_mcs.rx_mcs_map);
-		u16 vht_mcs;
+		const u16 *mcs_mask = mask->control[band].vht_mcs;
 		u8 af;
 
+		ra->supp_mode |= MODE_VHT;
 		af = FIELD_GET(IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK,
 			       sta->vht_cap.cap);
 		ra->af = max_t(u8, ra->af, af);
@@ -2179,29 +2293,7 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 		if (sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC)
 			cap |= STA_CAP_VHT_LDPC;
 
-		ra->supp_mode |= MODE_VHT;
-		for (i = 0; i < nss; i++, mcs_map >>= 2) {
-			switch (mcs_map & 0x3) {
-			case IEEE80211_VHT_MCS_SUPPORT_0_9:
-				vht_mcs = GENMASK(9, 0);
-				break;
-			case IEEE80211_VHT_MCS_SUPPORT_0_8:
-				vht_mcs = GENMASK(8, 0);
-				break;
-			case IEEE80211_VHT_MCS_SUPPORT_0_7:
-				vht_mcs = GENMASK(7, 0);
-				break;
-			default:
-				vht_mcs = 0;
-			}
-
-			ra->supp_vht_mcs[i] = cpu_to_le16(vht_mcs);
-
-			/* only support 2ss on 160MHz */
-			if (i > 1 && (ra->bw == CMD_CBW_160MHZ ||
-				      ra->bw == CMD_CBW_8080MHZ))
-				break;
-		}
+		mt7915_mcu_set_sta_vht_mcs(sta, ra->supp_vht_mcs, mcs_mask);
 	}
 
 	if (sta->he_cap.has_he) {
@@ -2230,6 +2322,29 @@ int mt7915_mcu_add_rate_ctrl(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 				     MCU_EXT_CMD(STA_REC_UPDATE), true);
 }
 
+int mt7915_mcu_add_he(struct mt7915_dev *dev, struct ieee80211_vif *vif,
+		      struct ieee80211_sta *sta)
+{
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	struct sk_buff *skb;
+	int len;
+
+	if (!sta->he_cap.has_he)
+		return 0;
+
+	len = sizeof(struct sta_req_hdr) + sizeof(struct sta_rec_he);
+
+	skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta, len);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	mt7915_mcu_sta_he_tlv(skb, sta);
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_EXT_CMD(STA_REC_UPDATE), true);
+}
+
 int mt7915_mcu_add_sta_adv(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta, bool enable)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 43e3d977cdb2..7eca123f657a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -103,6 +103,7 @@ struct mt7915_vif {
 	struct mt7915_phy *phy;
 
 	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
+	struct cfg80211_bitrate_mask bitrate_mask;
 };
 
 struct mib_stats {
@@ -332,6 +333,8 @@ int mt7915_mcu_add_obss_spr(struct mt7915_dev *dev, struct ieee80211_vif *vif,
                             bool enable);
 int mt7915_mcu_add_rate_ctrl(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 			     struct ieee80211_sta *sta);
+int mt7915_mcu_add_he(struct mt7915_dev *dev, struct ieee80211_vif *vif,
+		      struct ieee80211_sta *sta);
 int mt7915_mcu_add_smps(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta);
 int mt7915_set_channel(struct mt7915_phy *phy);
-- 
2.18.0

