Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947CF3E3314
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Aug 2021 06:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhHGEJP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Aug 2021 00:09:15 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:59160 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229631AbhHGEJO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Aug 2021 00:09:14 -0400
X-UUID: 0bcd7fafcbfc4b55a4f8b61042c0e795-20210807
X-UUID: 0bcd7fafcbfc4b55a4f8b61042c0e795-20210807
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 984609346; Sat, 07 Aug 2021 12:08:54 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 7 Aug 2021 12:08:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 7 Aug 2021 12:08:53 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2] mt76: mt7915: introduce mt7915_mcu_beacon_check_caps()
Date:   Sat, 7 Aug 2021 12:08:51 +0800
Message-ID: <05d2df887a583a1ab694f2364520c275bfea9e38.1628306758.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <77372f644903053e09d671325c0cd44cf75e14ac.1628306758.git.ryder.lee@mediatek.com>
References: <77372f644903053e09d671325c0cd44cf75e14ac.1628306758.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Strictly check beacon IEs which could be changed by user configuraion,
so driver should determinate capability in practice by comparing IEs
and hardware capability before association.

Co-developed-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
v2 - clean up codes.
---
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   1 +
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 150 ++++++++++++++----
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  13 ++
 3 files changed, 130 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index fc2110dc4a75..20b47ac33083 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -251,6 +251,7 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	vif->offload_flags |= IEEE80211_OFFLOAD_ENCAP_4ADDR;
 
 	mt7915_init_bitrate_mask(vif);
+	memset(&mvif->cap, 1, sizeof(struct mt7915_vif_cap));
 
 out:
 	mutex_unlock(&dev->mt76.mutex);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 59731c1831ea..030d6fba59e9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1488,8 +1488,10 @@ mt7915_mcu_sta_uapsd_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
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
@@ -1499,7 +1501,14 @@ mt7915_mcu_sta_muru_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 
 	muru = (struct sta_rec_muru *)tlv;
 	muru->cfg.ofdma_dl_en = true;
-	muru->cfg.mimo_dl_en = true;
+
+	/* A non-AP HE station must support MU beamformee */
+	if (vif->type == NL80211_IFTYPE_STATION && vif->bss_conf.he_support)
+		muru->cfg.mimo_dl_en = true;
+	else
+		muru->cfg.mimo_dl_en = mvif->cap.he_mu_ebfer ||
+				       mvif->cap.vht_mu_ebfer ||
+				       mvif->cap.vht_mu_ebfee;
 
 	muru->ofdma_dl.punc_pream_rx =
 		HE_PHY(CAP1_PREAMBLE_PUNC_RX_MASK, elem->phy_cap_info[1]);
@@ -1620,9 +1629,11 @@ mt7915_mcu_wtbl_smps_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
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
 
@@ -1631,7 +1642,8 @@ mt7915_mcu_wtbl_ht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 		tlv = mt7915_mcu_add_nested_tlv(skb, WTBL_HT, sizeof(*ht),
 						wtbl_tlv, sta_wtbl);
 		ht = (struct wtbl_ht *)tlv;
-		ht->ldpc = !!(sta->ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING);
+		ht->ldpc = mvif->cap.ht_ldpc &&
+			   (sta->ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING);
 		ht->af = sta->ht_cap.ampdu_factor;
 		ht->mm = sta->ht_cap.ampdu_density;
 		ht->ht = true;
@@ -1645,7 +1657,8 @@ mt7915_mcu_wtbl_ht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 		tlv = mt7915_mcu_add_nested_tlv(skb, WTBL_VHT, sizeof(*vht),
 						wtbl_tlv, sta_wtbl);
 		vht = (struct wtbl_vht *)tlv;
-		vht->ldpc = !!(sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC);
+		vht->ldpc = mvif->cap.vht_ldpc &&
+			    (sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC);
 		vht->vht = true;
 
 		af = FIELD_GET(IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK,
@@ -1968,7 +1981,7 @@ mt7915_mcu_add_txbf(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	struct mt7915_phy *phy;
 	struct sk_buff *skb;
 	int r, len;
-	bool ebfee = 0, ebf = 0;
+	bool ebfee = false, ebfer = false;
 
 	if (vif->type != NL80211_IFTYPE_STATION &&
 	    vif->type != NL80211_IFTYPE_AP)
@@ -1977,42 +1990,32 @@ mt7915_mcu_add_txbf(struct mt7915_dev *dev, struct ieee80211_vif *vif,
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
@@ -2096,7 +2099,8 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 			cap |= STA_CAP_TX_STBC;
 		if (sta->ht_cap.cap & IEEE80211_HT_CAP_RX_STBC)
 			cap |= STA_CAP_RX_STBC;
-		if (sta->ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING)
+		if (mvif->cap.ht_ldpc &&
+		    (sta->ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING))
 			cap |= STA_CAP_LDPC;
 
 		mt7915_mcu_set_sta_ht_mcs(sta, ra->ht_mcs, mcs_mask);
@@ -2121,7 +2125,8 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 			cap |= STA_CAP_VHT_TX_STBC;
 		if (sta->vht_cap.cap & IEEE80211_VHT_CAP_RXSTBC_1)
 			cap |= STA_CAP_VHT_RX_STBC;
-		if (sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC)
+		if (mvif->cap.vht_ldpc &&
+		    (sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC))
 			cap |= STA_CAP_VHT_LDPC;
 
 		mt7915_mcu_set_sta_vht_mcs(sta, ra->supp_vht_mcs, mcs_mask);
@@ -2226,7 +2231,7 @@ mt7915_mcu_add_mu(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	/* wait until TxBF and MU ready to update stare vht */
 
 	/* starec muru */
-	mt7915_mcu_sta_muru_tlv(skb, sta);
+	mt7915_mcu_sta_muru_tlv(skb, sta, vif);
 	/* starec vht */
 	mt7915_mcu_sta_vht_tlv(skb, sta);
 
@@ -2285,7 +2290,7 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		mt7915_mcu_wtbl_generic_tlv(skb, vif, sta, sta_wtbl, wtbl_hdr);
 		mt7915_mcu_wtbl_hdr_trans_tlv(skb, vif, sta, sta_wtbl, wtbl_hdr);
 		if (sta)
-			mt7915_mcu_wtbl_ht_tlv(skb, sta, sta_wtbl, wtbl_hdr);
+			mt7915_mcu_wtbl_ht_tlv(skb, vif, sta, sta_wtbl, wtbl_hdr);
 	}
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
@@ -2426,6 +2431,81 @@ mt7915_mcu_beacon_cont(struct mt7915_dev *dev, struct sk_buff *rskb,
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
+	len = skb->len - (mgmt->u.beacon.variable - skb->data);
+
+	ie = cfg80211_find_ie(WLAN_EID_HT_CAPABILITY, mgmt->u.beacon.variable,
+			      len);
+	if (ie && ie[1] >= sizeof(*ht)) {
+		ht = (void *)(ie + 2);
+		bc = le32_to_cpu(ht->cap_info);
+
+		vc->ht_ldpc = !!(bc & IEEE80211_HT_CAP_LDPC_CODING);
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
+		vc->vht_ldpc = !!(bc & IEEE80211_VHT_CAP_RXLDPC);
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
@@ -2466,6 +2546,8 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw,
 		info->hw_queue |= MT_TX_HW_QUEUE_EXT_PHY;
 	}
 
+	mt7915_mcu_beacon_check_caps(phy, vif, skb);
+
 	/* TODO: subtag - bss color count & 11v MBSSID */
 	mt7915_mcu_beacon_csa(rskb, skb, bcn, &offs);
 	mt7915_mcu_beacon_cont(dev, rskb, skb, bcn, &offs);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index cc74dd2c2c72..1f5065ed6a59 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -83,12 +83,25 @@ struct mt7915_sta {
 	struct mt7915_sta_key_conf bip;
 };
 
+struct mt7915_vif_cap {
+	bool ht_ldpc:1;
+	bool vht_ldpc:1;
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
2.29.2

