Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314B34046D5
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Sep 2021 10:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhIIIQd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Sep 2021 04:16:33 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:44748 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230210AbhIIIQc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Sep 2021 04:16:32 -0400
X-UUID: faf9f6f825c3499dbdeaccc2a32b89c8-20210909
X-UUID: faf9f6f825c3499dbdeaccc2a32b89c8-20210909
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 706186348; Thu, 09 Sep 2021 16:15:19 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 9 Sep 2021 16:15:18 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 9 Sep 2021 16:15:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 9 Sep 2021 16:15:18 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v4 1/8] mt76: mt7915: introduce mt7915_mcu_beacon_check_caps()
Date:   Thu, 9 Sep 2021 16:15:05 +0800
Message-ID: <20210909081512.5037-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

Beacon elements might be changed by hostapd configuraion, so driver
should compare both IEs and PHY capabilities to get the least common
denominator before association.

Co-developed-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
v2: modify condition for mimo_dl_en
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 163 +++++++++++++-----
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  12 ++
 2 files changed, 136 insertions(+), 39 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 39cba8210242..955afe9f2958 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1317,9 +1317,11 @@ mt7915_mcu_sta_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 }
 
 static void
-mt7915_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
+mt7915_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
+		      struct ieee80211_vif *vif)
 {
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
 	struct ieee80211_he_cap_elem *elem = &he_cap->he_cap_elem;
 	enum nl80211_band band = msta->vif->phy->mt76->chandef.chan->band;
@@ -1352,8 +1354,8 @@ mt7915_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 	     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_5G))
 		cap |= STA_REC_HE_CAP_BW20_RU242_SUPPORT;
 
-	if (elem->phy_cap_info[1] &
-	    IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD)
+	if (mvif->cap.ldpc && (elem->phy_cap_info[1] &
+			       IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD))
 		cap |= STA_REC_HE_CAP_LDPC;
 
 	if (elem->phy_cap_info[1] &
@@ -1488,8 +1490,10 @@ mt7915_mcu_sta_uapsd_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 }
 
 static void
-mt7915_mcu_sta_muru_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
+mt7915_mcu_sta_muru_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
+			struct ieee80211_vif *vif)
 {
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
 	struct ieee80211_he_cap_elem *elem = &he_cap->he_cap_elem;
 	struct sta_rec_muru *muru;
@@ -1499,7 +1503,13 @@ mt7915_mcu_sta_muru_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 
 	muru = (struct sta_rec_muru *)tlv;
 	muru->cfg.ofdma_dl_en = true;
-	muru->cfg.mimo_dl_en = true;
+
+	/* A non-AP HE station must support MU beamformee */
+	muru->cfg.mimo_dl_en = (vif->type == NL80211_IFTYPE_STATION &&
+				vif->bss_conf.he_support) ||
+			       mvif->cap.he_mu_ebfer ||
+			       mvif->cap.vht_mu_ebfer ||
+			       mvif->cap.vht_mu_ebfee;
 
 	muru->ofdma_dl.punc_pream_rx =
 		HE_PHY(CAP1_PREAMBLE_PUNC_RX_MASK, elem->phy_cap_info[1]);
@@ -1598,7 +1608,7 @@ mt7915_mcu_sta_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 
 	/* starec he */
 	if (sta->he_cap.has_he)
-		mt7915_mcu_sta_he_tlv(skb, sta);
+		mt7915_mcu_sta_he_tlv(skb, sta, vif);
 
 	/* starec uapsd */
 	mt7915_mcu_sta_uapsd_tlv(skb, sta, vif);
@@ -1620,9 +1630,11 @@ mt7915_mcu_wtbl_smps_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 }
 
 static void
-mt7915_mcu_wtbl_ht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
-		       void *sta_wtbl, void *wtbl_tlv)
+mt7915_mcu_wtbl_ht_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta, void *sta_wtbl,
+		       void *wtbl_tlv)
 {
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct wtbl_ht *ht = NULL;
 	struct tlv *tlv;
 
@@ -1631,7 +1643,8 @@ mt7915_mcu_wtbl_ht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 		tlv = mt7915_mcu_add_nested_tlv(skb, WTBL_HT, sizeof(*ht),
 						wtbl_tlv, sta_wtbl);
 		ht = (struct wtbl_ht *)tlv;
-		ht->ldpc = !!(sta->ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING);
+		ht->ldpc = mvif->cap.ldpc &&
+			   (sta->ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING);
 		ht->af = sta->ht_cap.ampdu_factor;
 		ht->mm = sta->ht_cap.ampdu_density;
 		ht->ht = true;
@@ -1645,7 +1658,8 @@ mt7915_mcu_wtbl_ht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 		tlv = mt7915_mcu_add_nested_tlv(skb, WTBL_VHT, sizeof(*vht),
 						wtbl_tlv, sta_wtbl);
 		vht = (struct wtbl_vht *)tlv;
-		vht->ldpc = !!(sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC);
+		vht->ldpc = mvif->cap.ldpc &&
+			    (sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC);
 		vht->vht = true;
 
 		af = FIELD_GET(IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK,
@@ -1968,7 +1982,7 @@ mt7915_mcu_add_txbf(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	struct mt7915_phy *phy;
 	struct sk_buff *skb;
 	int r, len;
-	bool ebfee = 0, ebf = 0;
+	bool ebfee = false, ebfer = false;
 
 	if (vif->type != NL80211_IFTYPE_STATION &&
 	    vif->type != NL80211_IFTYPE_AP)
@@ -1977,42 +1991,32 @@ mt7915_mcu_add_txbf(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	phy = mvif->band_idx ? mt7915_ext_phy(dev) : &dev->phy;
 
 	if (sta->he_cap.has_he) {
-		struct ieee80211_he_cap_elem *pe;
-		const struct ieee80211_he_cap_elem *ve;
-		const struct ieee80211_sta_he_cap *vc;
-
-		pe = &sta->he_cap.he_cap_elem;
-		vc = mt7915_get_he_phy_cap(phy, vif);
-		ve = &vc->he_cap_elem;
-
-		ebfee = !!(HE_PHY(CAP3_SU_BEAMFORMER, pe->phy_cap_info[3]) &&
-			   HE_PHY(CAP4_SU_BEAMFORMEE, ve->phy_cap_info[4]));
-		ebf = !!(HE_PHY(CAP3_SU_BEAMFORMER, ve->phy_cap_info[3]) &&
-			 HE_PHY(CAP4_SU_BEAMFORMEE, pe->phy_cap_info[4]));
-	} else if (sta->vht_cap.vht_supported) {
-		struct ieee80211_sta_vht_cap *pc;
-		struct ieee80211_sta_vht_cap *vc;
+		struct ieee80211_he_cap_elem *pe = &sta->he_cap.he_cap_elem;
 
-		pc = &sta->vht_cap;
-		vc = &phy->mt76->sband_5g.sband.vht_cap;
+		ebfee = mvif->cap.he_su_ebfee &&
+			HE_PHY(CAP3_SU_BEAMFORMER, pe->phy_cap_info[3]);
+		ebfer = mvif->cap.he_su_ebfer &&
+			HE_PHY(CAP4_SU_BEAMFORMEE, pe->phy_cap_info[4]);
+	} else if (sta->vht_cap.vht_supported) {
+		u32 cap = sta->vht_cap.cap;
 
-		ebfee = !!((pc->cap & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE) &&
-			   (vc->cap & IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE));
-		ebf = !!((vc->cap & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE) &&
-			 (pc->cap & IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE));
+		ebfee = mvif->cap.vht_su_ebfee &&
+			(cap & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE);
+		ebfer = mvif->cap.vht_su_ebfer &&
+			(cap & IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE);
 	}
 
 	/* must keep each tag independent */
 
 	/* starec bf */
-	if (ebf || dev->ibf) {
+	if (ebfer || dev->ibf) {
 		len = sizeof(struct sta_req_hdr) + sizeof(struct sta_rec_bf);
 
 		skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta, len);
 		if (IS_ERR(skb))
 			return PTR_ERR(skb);
 
-		mt7915_mcu_sta_bfer_tlv(skb, sta, vif, phy, enable, ebf);
+		mt7915_mcu_sta_bfer_tlv(skb, sta, vif, phy, enable, ebfer);
 
 		r = mt76_mcu_skb_send_msg(&dev->mt76, skb,
 					  MCU_EXT_CMD(STA_REC_UPDATE), true);
@@ -2217,7 +2221,8 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 			cap |= STA_CAP_TX_STBC;
 		if (sta->ht_cap.cap & IEEE80211_HT_CAP_RX_STBC)
 			cap |= STA_CAP_RX_STBC;
-		if (sta->ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING)
+		if (mvif->cap.ldpc &&
+		    (sta->ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING))
 			cap |= STA_CAP_LDPC;
 
 		mt7915_mcu_set_sta_ht_mcs(sta, ra->ht_mcs,
@@ -2242,7 +2247,8 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 			cap |= STA_CAP_VHT_TX_STBC;
 		if (sta->vht_cap.cap & IEEE80211_VHT_CAP_RXSTBC_1)
 			cap |= STA_CAP_VHT_RX_STBC;
-		if (sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC)
+		if (mvif->cap.ldpc &&
+		    (sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC))
 			cap |= STA_CAP_VHT_LDPC;
 
 		mt7915_mcu_set_sta_vht_mcs(sta, ra->supp_vht_mcs,
@@ -2276,7 +2282,7 @@ int mt7915_mcu_add_rate_ctrl(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	 * update sta_rec_he here as well.
 	 */
 	if (sta->he_cap.has_he && changed)
-		mt7915_mcu_sta_he_tlv(skb, sta);
+		mt7915_mcu_sta_he_tlv(skb, sta, vif);
 
 	/* sta_rec_ra accommodates BW, NSS and only MCS range format
 	 * i.e 0-{7,8,9} for VHT.
@@ -2346,7 +2352,7 @@ mt7915_mcu_add_mu(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	/* wait until TxBF and MU ready to update stare vht */
 
 	/* starec muru */
-	mt7915_mcu_sta_muru_tlv(skb, sta);
+	mt7915_mcu_sta_muru_tlv(skb, sta, vif);
 	/* starec vht */
 	mt7915_mcu_sta_vht_tlv(skb, sta);
 
@@ -2405,7 +2411,7 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		mt7915_mcu_wtbl_generic_tlv(skb, vif, sta, sta_wtbl, wtbl_hdr);
 		mt7915_mcu_wtbl_hdr_trans_tlv(skb, vif, sta, sta_wtbl, wtbl_hdr);
 		if (sta)
-			mt7915_mcu_wtbl_ht_tlv(skb, sta, sta_wtbl, wtbl_hdr);
+			mt7915_mcu_wtbl_ht_tlv(skb, vif, sta, sta_wtbl, wtbl_hdr);
 	}
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
@@ -2499,6 +2505,83 @@ mt7915_mcu_beacon_cont(struct mt7915_dev *dev, struct sk_buff *rskb,
 	memcpy(buf + MT_TXD_SIZE, skb->data, skb->len);
 }
 
+static void
+mt7915_mcu_beacon_check_caps(struct mt7915_phy *phy, struct ieee80211_vif *vif,
+			     struct sk_buff *skb)
+{
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	struct mt7915_vif_cap *vc = &mvif->cap;
+	const struct ieee80211_he_cap_elem *he;
+	const struct ieee80211_vht_cap *vht;
+	const struct ieee80211_ht_cap *ht;
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+	const u8 *ie;
+	u32 len, bc;
+
+	/* Check missing configuration options to allow AP mode in mac80211
+	 * to remain in sync with hostapd settings, and get a subset of
+	 * beacon and hardware capabilities.
+	 */
+	if (WARN_ON_ONCE(skb->len <= (mgmt->u.beacon.variable - skb->data)))
+		return;
+
+	memset(vc, 0, sizeof(*vc));
+
+	len = skb->len - (mgmt->u.beacon.variable - skb->data);
+
+	ie = cfg80211_find_ie(WLAN_EID_HT_CAPABILITY, mgmt->u.beacon.variable,
+			      len);
+	if (ie && ie[1] >= sizeof(*ht)) {
+		ht = (void *)(ie + 2);
+		bc = le32_to_cpu(ht->cap_info);
+
+		vc->ldpc |= !!(bc & IEEE80211_HT_CAP_LDPC_CODING);
+	}
+
+	ie = cfg80211_find_ie(WLAN_EID_VHT_CAPABILITY, mgmt->u.beacon.variable,
+			      len);
+	if (ie && ie[1] >= sizeof(*vht)) {
+		u32 pc = phy->mt76->sband_5g.sband.vht_cap.cap;
+
+		vht = (void *)(ie + 2);
+		bc = le32_to_cpu(vht->vht_cap_info);
+
+		vc->ldpc |= !!(bc & IEEE80211_VHT_CAP_RXLDPC);
+		vc->vht_su_ebfer =
+			(bc & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE) &&
+			(pc & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE);
+		vc->vht_su_ebfee =
+			(bc & IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE) &&
+			(pc & IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE);
+		vc->vht_mu_ebfer =
+			(bc & IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE) &&
+			(pc & IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE);
+		vc->vht_mu_ebfee =
+			(bc & IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE) &&
+			(pc & IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE);
+	}
+
+	ie = cfg80211_find_ext_ie(WLAN_EID_EXT_HE_CAPABILITY,
+				  mgmt->u.beacon.variable, len);
+	if (ie && ie[1] >= sizeof(*he) + 1) {
+		const struct ieee80211_sta_he_cap *pc =
+			mt7915_get_he_phy_cap(phy, vif);
+		const struct ieee80211_he_cap_elem *pe = &pc->he_cap_elem;
+
+		he = (void *)(ie + 3);
+
+		vc->he_su_ebfer =
+			HE_PHY(CAP3_SU_BEAMFORMER, he->phy_cap_info[3]) &&
+			HE_PHY(CAP3_SU_BEAMFORMER, pe->phy_cap_info[3]);
+		vc->he_su_ebfee =
+			HE_PHY(CAP4_SU_BEAMFORMEE, he->phy_cap_info[4]) &&
+			HE_PHY(CAP4_SU_BEAMFORMEE, pe->phy_cap_info[4]);
+		vc->he_mu_ebfer =
+			HE_PHY(CAP4_MU_BEAMFORMER, he->phy_cap_info[4]) &&
+			HE_PHY(CAP4_MU_BEAMFORMER, pe->phy_cap_info[4]);
+	}
+}
+
 int mt7915_mcu_add_beacon(struct ieee80211_hw *hw,
 			  struct ieee80211_vif *vif, bool en)
 {
@@ -2539,6 +2622,8 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw,
 		info->hw_queue |= MT_TX_HW_QUEUE_EXT_PHY;
 	}
 
+	mt7915_mcu_beacon_check_caps(phy, vif, skb);
+
 	/* TODO: subtag - bss color count & 11v MBSSID */
 	mt7915_mcu_beacon_csa(rskb, skb, bcn, &offs);
 	mt7915_mcu_beacon_cont(dev, rskb, skb, bcn, &offs);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index ab8fc27646e0..d68e345765e8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -83,12 +83,24 @@ struct mt7915_sta {
 	struct mt7915_sta_key_conf bip;
 };
 
+struct mt7915_vif_cap {
+	bool ldpc:1;
+	bool vht_su_ebfer:1;
+	bool vht_su_ebfee:1;
+	bool vht_mu_ebfer:1;
+	bool vht_mu_ebfee:1;
+	bool he_su_ebfer:1;
+	bool he_su_ebfee:1;
+	bool he_mu_ebfer:1;
+};
+
 struct mt7915_vif {
 	u16 idx;
 	u8 omac_idx;
 	u8 band_idx;
 	u8 wmm_idx;
 
+	struct mt7915_vif_cap cap;
 	struct mt7915_sta sta;
 	struct mt7915_phy *phy;
 
-- 
2.25.1

