Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE313013FA
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Jan 2021 09:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbhAWIhP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Jan 2021 03:37:15 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:50200 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726858AbhAWIg4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Jan 2021 03:36:56 -0500
X-UUID: 16470b1fa4b84d15a1288fa4bcfde7e3-20210123
X-UUID: 16470b1fa4b84d15a1288fa4bcfde7e3-20210123
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1094132052; Sat, 23 Jan 2021 16:35:18 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 23 Jan 2021 16:35:16 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 23 Jan 2021 16:35:16 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH -next v7 14/22] mt76: mt7921: rely on mt76_connac_mcu common library
Date:   Sat, 23 Jan 2021 16:35:05 +0800
Message-ID: <1ef9002273635b3b5a44dfaef49ce6768429788b.1611389300.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1611389300.git.objelf@gmail.com>
References: <cover.1611389300.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Rely on mt76_connac_mcu common library and remove duplicated code

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |    5 +
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  336 ++++-
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |   21 +
 .../net/wireless/mediatek/mt76/mt7921/Kconfig |    2 +-
 .../net/wireless/mediatek/mt76/mt7921/init.c  |    3 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   34 +-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 1246 +----------------
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   |  538 +------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   36 +-
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |    1 +
 10 files changed, 411 insertions(+), 1811 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 15a7b0a06053..ff244d4758ab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -59,6 +59,11 @@ struct mt76_connac_pm {
 
 extern const struct wiphy_wowlan_support mt76_connac_wowlan_support;
 
+static inline bool is_mt7921(struct mt76_dev *dev)
+{
+	return mt76_chip(dev) == 0x7961;
+}
+
 int mt76_connac_pm_wake(struct mt76_phy *phy, struct mt76_connac_pm *pm);
 void mt76_connac_power_save_sched(struct mt76_phy *phy,
 				  struct mt76_connac_pm *pm);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index ee5ebd7259a7..40c10510b32a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -60,9 +60,15 @@ int mt76_connac_mcu_init_download(struct mt76_dev *dev, u32 addr, u32 len,
 		.len = cpu_to_le32(len),
 		.mode = cpu_to_le32(mode),
 	};
+	int cmd;
 
-	return mt76_mcu_send_msg(dev, MCU_CMD_TARGET_ADDRESS_LEN_REQ, &req,
-				 sizeof(req), true);
+	if (is_mt7921(dev) &&
+	    (req.addr == cpu_to_le32(MCU_PATCH_ADDRESS) || addr == 0x900000))
+		cmd = MCU_CMD_PATCH_START_REQ;
+	else
+		cmd = MCU_CMD_TARGET_ADDRESS_LEN_REQ;
+
+	return mt76_mcu_send_msg(dev, cmd, &req, sizeof(req), true);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_init_download);
 
@@ -251,11 +257,12 @@ mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif *mvif,
 	struct sta_req_hdr hdr = {
 		.bss_idx = mvif->idx,
 		.muar_idx = wcid ? mvif->omac_idx : 0,
-		.wlan_idx_lo = wcid ? wcid->idx : 0,
 		.is_tlv_append = 1,
 	};
 	struct sk_buff *skb;
 
+	mt76_connac_mcu_get_wlan_idx(dev, wcid, &hdr.wlan_idx_lo,
+				     &hdr.wlan_idx_hi);
 	skb = mt76_mcu_msg_alloc(dev, NULL, MT76_CONNAC_STA_UPDATE_MAX_SIZE);
 	if (!skb)
 		return ERR_PTR(-ENOMEM);
@@ -272,11 +279,12 @@ mt76_connac_mcu_alloc_wtbl_req(struct mt76_dev *dev, struct mt76_wcid *wcid,
 {
 	struct tlv *sta_hdr = sta_wtbl;
 	struct wtbl_req_hdr hdr = {
-		.wlan_idx_lo = wcid ? wcid->idx : 0,
 		.operation = cmd,
 	};
 	struct sk_buff *nskb = *skb;
 
+	mt76_connac_mcu_get_wlan_idx(dev, wcid, &hdr.wlan_idx_lo,
+				     &hdr.wlan_idx_hi);
 	if (!nskb) {
 		nskb = mt76_mcu_msg_alloc(dev, NULL,
 					  MT76_CONNAC_WTBL_UPDATE_BA_SIZE);
@@ -411,7 +419,13 @@ void mt76_connac_mcu_wtbl_generic_tlv(struct mt76_dev *dev,
 		generic->muar_idx = mvif->omac_idx;
 		generic->qos = sta->wme;
 	} else {
-		eth_broadcast_addr(generic->peer_addr);
+		if (is_mt7921(dev) &&
+		    vif->type == NL80211_IFTYPE_STATION)
+			memcpy(generic->peer_addr, vif->bss_conf.bssid,
+			       ETH_ALEN);
+		else
+			eth_broadcast_addr(generic->peer_addr);
+
 		generic->muar_idx = 0xe;
 	}
 
@@ -423,6 +437,9 @@ void mt76_connac_mcu_wtbl_generic_tlv(struct mt76_dev *dev,
 	rx->rca2 = 1;
 	rx->rv = 1;
 
+	if (is_mt7921(dev))
+		return;
+
 	tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_SPE, sizeof(*spe),
 					     wtbl_tlv, sta_wtbl);
 	spe = (struct wtbl_spe *)tlv;
@@ -430,10 +447,222 @@ void mt76_connac_mcu_wtbl_generic_tlv(struct mt76_dev *dev,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_wtbl_generic_tlv);
 
+static void
+mt76_connac_mcu_sta_amsdu_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
+			      struct ieee80211_vif *vif)
+{
+	struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
+	struct sta_rec_amsdu *amsdu;
+	struct tlv *tlv;
+
+	if (vif->type != NL80211_IFTYPE_AP &&
+	    vif->type != NL80211_IFTYPE_STATION)
+		return;
+
+	if (!sta->max_amsdu_len)
+		return;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HW_AMSDU, sizeof(*amsdu));
+	amsdu = (struct sta_rec_amsdu *)tlv;
+	amsdu->max_amsdu_num = 8;
+	amsdu->amsdu_en = true;
+	amsdu->max_mpdu_size = sta->max_amsdu_len >=
+			       IEEE80211_MAX_MPDU_LEN_VHT_7991;
+
+	wcid->amsdu = true;
+}
+
+#define HE_PHY(p, c)	u8_get_bits(c, IEEE80211_HE_PHY_##p)
+#define HE_MAC(m, c)	u8_get_bits(c, IEEE80211_HE_MAC_##m)
+static void
+mt76_connac_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
+{
+	struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
+	struct ieee80211_he_cap_elem *elem = &he_cap->he_cap_elem;
+	struct sta_rec_he *he;
+	struct tlv *tlv;
+	u32 cap = 0;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HE, sizeof(*he));
+
+	he = (struct sta_rec_he *)tlv;
+
+	if (elem->mac_cap_info[0] & IEEE80211_HE_MAC_CAP0_HTC_HE)
+		cap |= STA_REC_HE_CAP_HTC;
+
+	if (elem->mac_cap_info[2] & IEEE80211_HE_MAC_CAP2_BSR)
+		cap |= STA_REC_HE_CAP_BSR;
+
+	if (elem->mac_cap_info[3] & IEEE80211_HE_MAC_CAP3_OMI_CONTROL)
+		cap |= STA_REC_HE_CAP_OM;
+
+	if (elem->mac_cap_info[4] & IEEE80211_HE_MAC_CAP4_AMDSU_IN_AMPDU)
+		cap |= STA_REC_HE_CAP_AMSDU_IN_AMPDU;
+
+	if (elem->mac_cap_info[4] & IEEE80211_HE_MAC_CAP4_BQR)
+		cap |= STA_REC_HE_CAP_BQR;
+
+	if (elem->phy_cap_info[0] &
+	    (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_2G |
+	     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_5G))
+		cap |= STA_REC_HE_CAP_BW20_RU242_SUPPORT;
+
+	if (elem->phy_cap_info[1] &
+	    IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD)
+		cap |= STA_REC_HE_CAP_LDPC;
+
+	if (elem->phy_cap_info[1] &
+	    IEEE80211_HE_PHY_CAP1_HE_LTF_AND_GI_FOR_HE_PPDUS_0_8US)
+		cap |= STA_REC_HE_CAP_SU_PPDU_1LTF_8US_GI;
+
+	if (elem->phy_cap_info[2] &
+	    IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US)
+		cap |= STA_REC_HE_CAP_NDP_4LTF_3DOT2MS_GI;
+
+	if (elem->phy_cap_info[2] &
+	    IEEE80211_HE_PHY_CAP2_STBC_TX_UNDER_80MHZ)
+		cap |= STA_REC_HE_CAP_LE_EQ_80M_TX_STBC;
+
+	if (elem->phy_cap_info[2] &
+	    IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ)
+		cap |= STA_REC_HE_CAP_LE_EQ_80M_RX_STBC;
+
+	if (elem->phy_cap_info[6] &
+	    IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE)
+		cap |= STA_REC_HE_CAP_PARTIAL_BW_EXT_RANGE;
+
+	if (elem->phy_cap_info[7] &
+	    IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI)
+		cap |= STA_REC_HE_CAP_SU_MU_PPDU_4LTF_8US_GI;
+
+	if (elem->phy_cap_info[7] &
+	    IEEE80211_HE_PHY_CAP7_STBC_TX_ABOVE_80MHZ)
+		cap |= STA_REC_HE_CAP_GT_80M_TX_STBC;
+
+	if (elem->phy_cap_info[7] &
+	    IEEE80211_HE_PHY_CAP7_STBC_RX_ABOVE_80MHZ)
+		cap |= STA_REC_HE_CAP_GT_80M_RX_STBC;
+
+	if (elem->phy_cap_info[8] &
+	    IEEE80211_HE_PHY_CAP8_HE_ER_SU_PPDU_4XLTF_AND_08_US_GI)
+		cap |= STA_REC_HE_CAP_ER_SU_PPDU_4LTF_8US_GI;
+
+	if (elem->phy_cap_info[8] &
+	    IEEE80211_HE_PHY_CAP8_HE_ER_SU_1XLTF_AND_08_US_GI)
+		cap |= STA_REC_HE_CAP_ER_SU_PPDU_1LTF_8US_GI;
+
+	if (elem->phy_cap_info[9] &
+	    IEEE80211_HE_PHY_CAP9_NON_TRIGGERED_CQI_FEEDBACK)
+		cap |= STA_REC_HE_CAP_TRIG_CQI_FK;
+
+	if (elem->phy_cap_info[9] &
+	    IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU)
+		cap |= STA_REC_HE_CAP_TX_1024QAM_UNDER_RU242;
+
+	if (elem->phy_cap_info[9] &
+	    IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU)
+		cap |= STA_REC_HE_CAP_RX_1024QAM_UNDER_RU242;
+
+	he->he_cap = cpu_to_le32(cap);
+
+	switch (sta->bandwidth) {
+	case IEEE80211_STA_RX_BW_160:
+		if (elem->phy_cap_info[0] &
+		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
+			he->max_nss_mcs[CMD_HE_MCS_BW8080] =
+				he_cap->he_mcs_nss_supp.rx_mcs_80p80;
+
+		he->max_nss_mcs[CMD_HE_MCS_BW160] =
+				he_cap->he_mcs_nss_supp.rx_mcs_160;
+		fallthrough;
+	default:
+		he->max_nss_mcs[CMD_HE_MCS_BW80] =
+				he_cap->he_mcs_nss_supp.rx_mcs_80;
+		break;
+	}
+
+	he->t_frame_dur =
+		HE_MAC(CAP1_TF_MAC_PAD_DUR_MASK, elem->mac_cap_info[1]);
+	he->max_ampdu_exp =
+		HE_MAC(CAP3_MAX_AMPDU_LEN_EXP_MASK, elem->mac_cap_info[3]);
+
+	he->bw_set =
+		HE_PHY(CAP0_CHANNEL_WIDTH_SET_MASK, elem->phy_cap_info[0]);
+	he->device_class =
+		HE_PHY(CAP1_DEVICE_CLASS_A, elem->phy_cap_info[1]);
+	he->punc_pream_rx =
+		HE_PHY(CAP1_PREAMBLE_PUNC_RX_MASK, elem->phy_cap_info[1]);
+
+	he->dcm_tx_mode =
+		HE_PHY(CAP3_DCM_MAX_CONST_TX_MASK, elem->phy_cap_info[3]);
+	he->dcm_tx_max_nss =
+		HE_PHY(CAP3_DCM_MAX_TX_NSS_2, elem->phy_cap_info[3]);
+	he->dcm_rx_mode =
+		HE_PHY(CAP3_DCM_MAX_CONST_RX_MASK, elem->phy_cap_info[3]);
+	he->dcm_rx_max_nss =
+		HE_PHY(CAP3_DCM_MAX_RX_NSS_2, elem->phy_cap_info[3]);
+	he->dcm_rx_max_nss =
+		HE_PHY(CAP8_DCM_MAX_RU_MASK, elem->phy_cap_info[8]);
+
+	he->pkt_ext = 2;
+}
+
+static u8
+mt76_connac_get_phy_mode_v2(struct mt76_phy *mphy, struct ieee80211_vif *vif,
+			    enum nl80211_band band, struct ieee80211_sta *sta)
+{
+	struct ieee80211_sta_ht_cap *ht_cap;
+	struct ieee80211_sta_vht_cap *vht_cap;
+	const struct ieee80211_sta_he_cap *he_cap;
+	u8 mode = 0;
+
+	if (sta) {
+		ht_cap = &sta->ht_cap;
+		vht_cap = &sta->vht_cap;
+		he_cap = &sta->he_cap;
+	} else {
+		struct ieee80211_supported_band *sband;
+
+		sband = mphy->hw->wiphy->bands[band];
+		ht_cap = &sband->ht_cap;
+		vht_cap = &sband->vht_cap;
+		he_cap = ieee80211_get_he_iftype_cap(sband, vif->type);
+	}
+
+	if (band == NL80211_BAND_2GHZ) {
+		mode |= PHY_TYPE_BIT_HR_DSSS | PHY_TYPE_BIT_ERP;
+
+		if (ht_cap->ht_supported)
+			mode |= PHY_TYPE_BIT_HT;
+
+		if (he_cap->has_he)
+			mode |= PHY_TYPE_BIT_HE;
+	} else if (band == NL80211_BAND_5GHZ) {
+		mode |= PHY_TYPE_BIT_OFDM;
+
+		if (ht_cap->ht_supported)
+			mode |= PHY_TYPE_BIT_HT;
+
+		if (vht_cap->vht_supported)
+			mode |= PHY_TYPE_BIT_VHT;
+
+		if (he_cap->has_he)
+			mode |= PHY_TYPE_BIT_HE;
+	}
+
+	return mode;
+}
+
 void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
 			     struct ieee80211_sta *sta,
 			     struct ieee80211_vif *vif)
 {
+	struct cfg80211_chan_def *chandef = &mphy->chandef;
+	enum nl80211_band band = chandef->chan->band;
+	struct mt76_dev *dev = mphy->dev;
+	struct sta_rec_ra_info *ra_info;
+	struct sta_rec_state *state;
+	struct sta_rec_phy *phy;
 	struct tlv *tlv;
 
 	/* starec ht */
@@ -448,9 +677,10 @@ void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
 	/* starec vht */
 	if (sta->vht_cap.vht_supported) {
 		struct sta_rec_vht *vht;
+		int len;
 
-		tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_VHT,
-					      sizeof(*vht) - 4);
+		len = is_mt7921(dev) ? sizeof(*vht) : sizeof(*vht) - 4;
+		tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_VHT, len);
 		vht = (struct sta_rec_vht *)tlv;
 		vht->vht_cap = cpu_to_le32(sta->vht_cap.cap);
 		vht->vht_rx_mcs_map = sta->vht_cap.vht_mcs.rx_mcs_map;
@@ -459,6 +689,39 @@ void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
 
 	/* starec uapsd */
 	mt76_connac_mcu_sta_uapsd(skb, vif, sta);
+
+	if (!is_mt7921(dev))
+		return;
+
+	if (sta->ht_cap.ht_supported)
+		mt76_connac_mcu_sta_amsdu_tlv(skb, sta, vif);
+
+	/* starec he */
+	if (sta->he_cap.has_he)
+		mt76_connac_mcu_sta_he_tlv(skb, sta);
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_PHY, sizeof(*phy));
+	phy = (struct sta_rec_phy *)tlv;
+	phy->phy_type = mt76_connac_get_phy_mode_v2(mphy, vif, band, sta);
+	phy->basic_rate = cpu_to_le16((u16)vif->bss_conf.basic_rates);
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_RA, sizeof(*ra_info));
+	ra_info = (struct sta_rec_ra_info *)tlv;
+	ra_info->legacy = cpu_to_le16((u16)sta->supp_rates[band]);
+
+	if (sta->ht_cap.ht_supported)
+		memcpy(ra_info->rx_mcs_bitmask, sta->ht_cap.mcs.rx_mask,
+		       HT_MCS_MASK_NUM);
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_STATE, sizeof(*state));
+	state = (struct sta_rec_state *)tlv;
+	state->state = 2;
+
+	if (sta->vht_cap.vht_supported) {
+		state->vht_opmode = sta->bandwidth;
+		state->vht_opmode |= (sta->rx_nss - 1) <<
+			IEEE80211_OPMODE_NOTIF_RX_NSS_SHIFT;
+	}
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_tlv);
 
@@ -514,7 +777,7 @@ void mt76_connac_mcu_wtbl_ht_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 
 	mt76_connac_mcu_wtbl_smps_tlv(skb, sta, sta_wtbl, wtbl_tlv);
 
-	if (sta->ht_cap.ht_supported) {
+	if (!is_mt7921(dev) && sta->ht_cap.ht_supported) {
 		/* sgi */
 		u32 msk = MT_WTBL_W5_SHORT_GI_20 | MT_WTBL_W5_SHORT_GI_40 |
 			  MT_WTBL_W5_SHORT_GI_80 | MT_WTBL_W5_SHORT_GI_160;
@@ -609,6 +872,9 @@ void mt76_connac_mcu_wtbl_ba_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 		ba->rst_ba_sb = 1;
 	}
 
+	if (is_mt7921(dev))
+		return;
+
 	if (enable && tx) {
 		u8 ba_range[] = { 4, 8, 12, 24, 36, 48, 54, 64 };
 		int i;
@@ -774,6 +1040,57 @@ int mt76_connac_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_ba);
 
+static u8
+mt76_connac_get_phy_mode(struct mt76_phy *phy, struct ieee80211_vif *vif,
+			 enum nl80211_band band,
+			 struct ieee80211_sta *sta)
+{
+	struct mt76_dev *dev = phy->dev;
+	const struct ieee80211_sta_he_cap *he_cap;
+	struct ieee80211_sta_vht_cap *vht_cap;
+	struct ieee80211_sta_ht_cap *ht_cap;
+	u8 mode = 0;
+
+	if (!is_mt7921(dev))
+		return 0x38;
+
+	if (sta) {
+		ht_cap = &sta->ht_cap;
+		vht_cap = &sta->vht_cap;
+		he_cap = &sta->he_cap;
+	} else {
+		struct ieee80211_supported_band *sband;
+
+		sband = phy->hw->wiphy->bands[band];
+		ht_cap = &sband->ht_cap;
+		vht_cap = &sband->vht_cap;
+		he_cap = ieee80211_get_he_iftype_cap(sband, vif->type);
+	}
+
+	if (band == NL80211_BAND_2GHZ) {
+		mode |= PHY_MODE_B | PHY_MODE_G;
+
+		if (ht_cap->ht_supported)
+			mode |= PHY_MODE_GN;
+
+		if (he_cap->has_he)
+			mode |= PHY_MODE_AX_24G;
+	} else if (band == NL80211_BAND_5GHZ) {
+		mode |= PHY_MODE_A;
+
+		if (ht_cap->ht_supported)
+			mode |= PHY_MODE_AN;
+
+		if (vht_cap->vht_supported)
+			mode |= PHY_MODE_AC;
+
+		if (he_cap->has_he)
+			mode |= PHY_MODE_AX_5G;
+	}
+
+	return mode;
+}
+
 static const struct ieee80211_sta_he_cap *
 mt76_connac_get_he_phy_cap(struct mt76_phy *phy, struct ieee80211_vif *vif)
 {
@@ -818,6 +1135,7 @@ int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
 	struct cfg80211_chan_def *chandef = &phy->chandef;
 	int freq1 = chandef->center_freq1, freq2 = chandef->center_freq2;
+	enum nl80211_band band = chandef->chan->band;
 	struct mt76_dev *mdev = phy->dev;
 	struct {
 		struct {
@@ -839,7 +1157,7 @@ int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 			.band_idx = mvif->band_idx,
 			.wmm_idx = mvif->wmm_idx,
 			.active = true, /* keep bss deactivated */
-			.phymode = 0x38,
+			.phymode = mt76_connac_get_phy_mode(phy, vif, band, NULL),
 		},
 		.qos = {
 			.tag = cpu_to_le16(UNI_BSS_INFO_QBSS),
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 0825ed674d15..60aac6f2d16c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -561,6 +561,8 @@ enum {
 	MCU_CMD_SCHED_SCAN_REQ = MCU_CE_PREFIX | 0x62,
 	MCU_CMD_REG_WRITE = MCU_CE_PREFIX | 0xc0,
 	MCU_CMD_REG_READ = MCU_CE_PREFIX | MCU_QUERY_MASK | 0xc0,
+	MCU_CMD_FWLOG_2_HOST = MCU_CE_PREFIX | 0xc5,
+	MCU_CMD_GET_WTBL = MCU_CE_PREFIX | 0xcd,
 };
 
 enum {
@@ -575,6 +577,8 @@ enum {
 	UNI_BSS_INFO_BCN_CONTENT = 7,
 	UNI_BSS_INFO_QBSS = 15,
 	UNI_BSS_INFO_UAPSD = 19,
+	UNI_BSS_INFO_PS = 21,
+	UNI_BSS_INFO_BCNFT = 22,
 };
 
 enum {
@@ -871,6 +875,23 @@ struct mt76_connac_suspend_tlv {
 	u8 pad[5];
 } __packed;
 
+#define to_wcid_lo(id)		FIELD_GET(GENMASK(7, 0), (u16)id)
+#define to_wcid_hi(id)		FIELD_GET(GENMASK(9, 8), (u16)id)
+
+static inline void
+mt76_connac_mcu_get_wlan_idx(struct mt76_dev *dev, struct mt76_wcid *wcid,
+			     u8 *wlan_idx_lo, u8 *wlan_idx_hi)
+{
+	*wlan_idx_hi = 0;
+
+	if (is_mt7921(dev)) {
+		*wlan_idx_lo = wcid ? to_wcid_lo(wcid->idx) : 0;
+		*wlan_idx_hi = wcid ? to_wcid_hi(wcid->idx) : 0;
+	} else {
+		*wlan_idx_lo = wcid ? wcid->idx : 0;
+	}
+}
+
 struct sk_buff *
 mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif *mvif,
 			      struct mt76_wcid *wcid);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
index 24932d2e8dee..92db70d11c36 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: ISC
 config MT7921E
 	tristate "MediaTek MT7921E (PCIe) support"
-	select MT76_CORE
+	select MT76_CONNAC_LIB
 	depends on MAC80211
 	depends on PCI
 	help
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index ca293fbc682e..4ee7453800c1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -4,6 +4,7 @@
 #include <linux/etherdevice.h>
 #include "mt7921.h"
 #include "mac.h"
+#include "mcu.h"
 #include "eeprom.h"
 
 #define CCK_RATE(_idx, _rate) {						\
@@ -139,7 +140,7 @@ static void mt7921_mac_init(struct mt7921_dev *dev)
 	for (i = 0; i < 2; i++)
 		mt7921_mac_init_band(dev, i);
 
-	mt7921_mcu_set_rts_thresh(&dev->phy, 0x92b);
+	mt76_connac_mcu_set_rts_thresh(&dev->mt76, 0x92b, 0);
 }
 
 static void mt7921_init_work(struct work_struct *work)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 995bbdd603e4..d1927ddf5e58 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -176,8 +176,9 @@ static int mt7921_start(struct ieee80211_hw *hw)
 
 	mutex_lock(&dev->mt76.mutex);
 
-	mt7921_mcu_set_mac(dev, 0, true, false);
-	mt7921_mcu_set_channel_domain(phy);
+	mt76_connac_mcu_set_mac_enable(&dev->mt76, 0, true, false);
+	mt76_connac_mcu_set_channel_domain(phy->mt76);
+
 	mt7921_mcu_set_chan_info(phy, MCU_EXT_CMD_SET_RX_PATH);
 	mt7921_mac_reset_counters(phy);
 	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
@@ -199,7 +200,7 @@ static void mt7921_stop(struct ieee80211_hw *hw)
 
 	mutex_lock(&dev->mt76.mutex);
 	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
-	mt7921_mcu_set_mac(dev, 0, false, false);
+	mt76_connac_mcu_set_mac_enable(&dev->mt76, 0, false, false);
 	mutex_unlock(&dev->mt76.mutex);
 }
 
@@ -285,7 +286,8 @@ static int mt7921_add_interface(struct ieee80211_hw *hw,
 	mvif->mt76.band_idx = 0;
 	mvif->mt76.wmm_idx = mvif->mt76.idx % MT7921_MAX_WMM_SETS;
 
-	ret = mt7921_mcu_uni_add_dev(dev, vif, true);
+	ret = mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.wcid,
+					  true);
 	if (ret)
 		goto out;
 
@@ -333,7 +335,7 @@ static void mt7921_remove_interface(struct ieee80211_hw *hw,
 	if (vif == phy->monitor_vif)
 		phy->monitor_vif = NULL;
 
-	mt7921_mcu_uni_add_dev(dev, vif, false);
+	mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.wcid, false);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
@@ -589,11 +591,14 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	msta->stats.jiffies = jiffies;
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
-		mt7921_mcu_uni_add_bss(&dev->phy, vif, true);
+		mt76_connac_mcu_uni_add_bss(&dev->mphy, vif, &mvif->sta.wcid,
+					    true);
+
 	mt7921_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
-	ret = mt7921_mcu_uni_add_sta(dev, vif, sta, true);
+	ret = mt76_connac_mcu_add_sta_cmd(&dev->mphy, vif, sta, &msta->wcid,
+					  true, MCU_UNI_CMD_STA_REC_UPDATE);
 	if (ret)
 		return ret;
 
@@ -606,11 +611,17 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
 	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
 
-	mt7921_mcu_uni_add_sta(dev, vif, sta, false);
+	mt76_connac_mcu_add_sta_cmd(&dev->mphy, vif, sta, &msta->wcid, false,
+				    MCU_UNI_CMD_STA_REC_UPDATE);
 	mt7921_mac_wtbl_update(dev, msta->wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
-	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
-		mt7921_mcu_uni_add_bss(&dev->phy, vif, false);
+
+	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
+		struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+
+		mt76_connac_mcu_uni_add_bss(&dev->mphy, vif, &mvif->sta.wcid,
+					    false);
+	}
 
 	spin_lock_bh(&dev->sta_poll_lock);
 	if (!list_empty(&msta->poll_list))
@@ -650,10 +661,9 @@ static void mt7921_tx(struct ieee80211_hw *hw,
 static int mt7921_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
 {
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
-	struct mt7921_phy *phy = mt7921_hw_phy(hw);
 
 	mutex_lock(&dev->mt76.mutex);
-	mt7921_mcu_set_rts_thresh(phy, val);
+	mt76_connac_mcu_set_rts_thresh(&dev->mt76, val, 0);
 	mutex_unlock(&dev->mt76.mutex);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 77055ff812eb..a6a2ee6d5c56 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -63,8 +63,6 @@ struct mt7921_fw_region {
 	u8 reserved1[15];
 } __packed;
 
-#define MCU_PATCH_ADDRESS		0x200000
-
 #define MT_STA_BFER			BIT(0)
 #define MT_STA_BFEE			BIT(1)
 
@@ -89,9 +87,6 @@ struct mt7921_fw_region {
 #define to_wcid_lo(id)			FIELD_GET(GENMASK(7, 0), (u16)id)
 #define to_wcid_hi(id)			FIELD_GET(GENMASK(9, 8), (u16)id)
 
-#define HE_PHY(p, c)			u8_get_bits(c, IEEE80211_HE_PHY_##p)
-#define HE_MAC(m, c)			u8_get_bits(c, IEEE80211_HE_MAC_##m)
-
 static enum mt7921_cipher_type
 mt7921_mcu_get_cipher(int cipher)
 {
@@ -138,112 +133,6 @@ static u8 mt7921_mcu_chan_bw(struct cfg80211_chan_def *chandef)
 	return width_to_bw[chandef->width];
 }
 
-static const struct ieee80211_sta_he_cap *
-mt7921_get_he_phy_cap(struct mt7921_phy *phy, struct ieee80211_vif *vif)
-{
-	struct ieee80211_supported_band *sband;
-	enum nl80211_band band;
-
-	band = phy->mt76->chandef.chan->band;
-	sband = phy->mt76->hw->wiphy->bands[band];
-
-	return ieee80211_get_he_iftype_cap(sband, vif->type);
-}
-
-static u8
-mt7921_get_phy_mode(struct mt7921_dev *dev, struct ieee80211_vif *vif,
-		    enum nl80211_band band, struct ieee80211_sta *sta)
-{
-	struct ieee80211_sta_ht_cap *ht_cap;
-	struct ieee80211_sta_vht_cap *vht_cap;
-	const struct ieee80211_sta_he_cap *he_cap;
-	u8 mode = 0;
-
-	if (sta) {
-		ht_cap = &sta->ht_cap;
-		vht_cap = &sta->vht_cap;
-		he_cap = &sta->he_cap;
-	} else {
-		struct ieee80211_supported_band *sband;
-		struct mt7921_phy *phy = &dev->phy;
-
-		sband = phy->mt76->hw->wiphy->bands[band];
-		ht_cap = &sband->ht_cap;
-		vht_cap = &sband->vht_cap;
-		he_cap = ieee80211_get_he_iftype_cap(sband, vif->type);
-	}
-
-	if (band == NL80211_BAND_2GHZ) {
-		mode |= PHY_MODE_B | PHY_MODE_G;
-
-		if (ht_cap->ht_supported)
-			mode |= PHY_MODE_GN;
-
-		if (he_cap->has_he)
-			mode |= PHY_MODE_AX_24G;
-	} else if (band == NL80211_BAND_5GHZ) {
-		mode |= PHY_MODE_A;
-
-		if (ht_cap->ht_supported)
-			mode |= PHY_MODE_AN;
-
-		if (vht_cap->vht_supported)
-			mode |= PHY_MODE_AC;
-
-		if (he_cap->has_he)
-			mode |= PHY_MODE_AX_5G;
-	}
-
-	return mode;
-}
-
-static u8
-mt7921_get_phy_mode_v2(struct mt7921_dev *dev, struct ieee80211_vif *vif,
-		       enum nl80211_band band, struct ieee80211_sta *sta)
-{
-	struct ieee80211_sta_ht_cap *ht_cap;
-	struct ieee80211_sta_vht_cap *vht_cap;
-	const struct ieee80211_sta_he_cap *he_cap;
-	u8 mode = 0;
-
-	if (sta) {
-		ht_cap = &sta->ht_cap;
-		vht_cap = &sta->vht_cap;
-		he_cap = &sta->he_cap;
-	} else {
-		struct ieee80211_supported_band *sband;
-		struct mt7921_phy *phy = &dev->phy;
-
-		sband = phy->mt76->hw->wiphy->bands[band];
-		ht_cap = &sband->ht_cap;
-		vht_cap = &sband->vht_cap;
-		he_cap = ieee80211_get_he_iftype_cap(sband, vif->type);
-	}
-
-	if (band == NL80211_BAND_2GHZ) {
-		mode |= PHY_TYPE_BIT_HR_DSSS | PHY_TYPE_BIT_ERP;
-
-		if (ht_cap->ht_supported)
-			mode |= PHY_TYPE_BIT_HT;
-
-		if (he_cap->has_he)
-			mode |= PHY_TYPE_BIT_HE;
-	} else if (band == NL80211_BAND_5GHZ) {
-		mode |= PHY_TYPE_BIT_OFDM;
-
-		if (ht_cap->ht_supported)
-			mode |= PHY_TYPE_BIT_HT;
-
-		if (vht_cap->vht_supported)
-			mode |= PHY_TYPE_BIT_VHT;
-
-		if (he_cap->has_he)
-			mode |= PHY_TYPE_BIT_HE;
-	}
-
-	return mode;
-}
-
 static int
 mt7921_mcu_parse_eeprom(struct mt76_dev *dev, struct sk_buff *skb)
 {
@@ -284,7 +173,7 @@ mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 		skb_pull(skb, sizeof(*rxd) - 4);
 		ret = *skb->data;
 		break;
-	case MCU_EXT_CMD_THERMAL_CTRL:
+	case MCU_EXT_CMD_GET_TEMP:
 		skb_pull(skb, sizeof(*rxd) + 4);
 		ret = le32_to_cpu(*(__le32 *)skb->data);
 		break;
@@ -543,30 +432,15 @@ mt7921_mcu_scan_event(struct mt7921_dev *dev, struct sk_buff *skb)
 				     MT7921_HW_SCAN_TIMEOUT);
 }
 
-static void
-mt7921_mcu_beacon_loss_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
-{
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
-	struct mt7921_beacon_loss_event *event = priv;
-
-	if (mvif->mt76.idx != event->bss_idx)
-		return;
-
-	if (!(vif->driver_flags & IEEE80211_VIF_BEACON_FILTER))
-		return;
-
-	ieee80211_beacon_loss(vif);
-}
-
 static void
 mt7921_mcu_beacon_loss_event(struct mt7921_dev *dev, struct sk_buff *skb)
 {
-	struct mt7921_beacon_loss_event *event;
+	struct mt76_connac_beacon_loss_event *event;
 	struct mt76_phy *mphy;
 	u8 band_idx = 0; /* DBDC support */
 
 	skb_pull(skb, sizeof(struct mt7921_mcu_rxd));
-	event = (struct mt7921_beacon_loss_event *)skb->data;
+	event = (struct mt76_connac_beacon_loss_event *)skb->data;
 	if (band_idx && dev->mt76.phy2)
 		mphy = dev->mt76.phy2;
 	else
@@ -574,17 +448,17 @@ mt7921_mcu_beacon_loss_event(struct mt7921_dev *dev, struct sk_buff *skb)
 
 	ieee80211_iterate_active_interfaces_atomic(mphy->hw,
 					IEEE80211_IFACE_ITER_RESUME_ALL,
-					mt7921_mcu_beacon_loss_iter, event);
+					mt76_connac_mcu_beacon_loss_iter, event);
 }
 
 static void
 mt7921_mcu_bss_event(struct mt7921_dev *dev, struct sk_buff *skb)
 {
 	struct mt76_phy *mphy = &dev->mt76.phy;
-	struct mt7921_mcu_bss_event *event;
+	struct mt76_connac_mcu_bss_event *event;
 
-	event = (struct mt7921_mcu_bss_event *)(skb->data +
-						sizeof(struct mt7921_mcu_rxd));
+	skb_pull(skb, sizeof(struct mt7921_mcu_rxd));
+	event = (struct mt76_connac_mcu_bss_event *)skb->data;
 	if (event->is_absent)
 		ieee80211_stop_queues(mphy->hw);
 	else
@@ -666,113 +540,6 @@ void mt7921_mcu_rx_event(struct mt7921_dev *dev, struct sk_buff *skb)
 		mt76_mcu_rx_event(&dev->mt76, skb);
 }
 
-static struct sk_buff *
-mt7921_mcu_alloc_sta_req(struct mt7921_dev *dev, struct mt7921_vif *mvif,
-			 struct mt7921_sta *msta, int len)
-{
-	struct sta_req_hdr hdr = {
-		.bss_idx = mvif->mt76.idx,
-		.wlan_idx_lo = msta ? to_wcid_lo(msta->wcid.idx) : 0,
-		.wlan_idx_hi = msta ? to_wcid_hi(msta->wcid.idx) : 0,
-		.muar_idx = msta ? mvif->mt76.omac_idx : 0,
-		.is_tlv_append = 1,
-	};
-	struct sk_buff *skb;
-
-	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, len);
-	if (!skb)
-		return ERR_PTR(-ENOMEM);
-
-	skb_put_data(skb, &hdr, sizeof(hdr));
-
-	return skb;
-}
-
-static struct wtbl_req_hdr *
-mt7921_mcu_alloc_wtbl_req(struct mt7921_dev *dev, struct mt7921_sta *msta,
-			  int cmd, void *sta_wtbl, struct sk_buff **skb)
-{
-	struct tlv *sta_hdr = sta_wtbl;
-	struct wtbl_req_hdr hdr = {
-		.wlan_idx_lo = to_wcid_lo(msta->wcid.idx),
-		.wlan_idx_hi = to_wcid_hi(msta->wcid.idx),
-		.operation = cmd,
-	};
-	struct sk_buff *nskb = *skb;
-
-	if (!nskb) {
-		nskb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
-					  MT7921_WTBL_UPDATE_BA_SIZE);
-		if (!nskb)
-			return ERR_PTR(-ENOMEM);
-
-		*skb = nskb;
-	}
-
-	if (sta_hdr)
-		sta_hdr->len = cpu_to_le16(sizeof(hdr));
-
-	return skb_put_data(nskb, &hdr, sizeof(hdr));
-}
-
-static struct tlv *
-mt7921_mcu_add_nested_tlv(struct sk_buff *skb, int tag, int len,
-			  void *sta_ntlv, void *sta_wtbl)
-{
-	struct sta_ntlv_hdr *ntlv_hdr = sta_ntlv;
-	struct tlv *sta_hdr = sta_wtbl;
-	struct tlv *ptlv, tlv = {
-		.tag = cpu_to_le16(tag),
-		.len = cpu_to_le16(len),
-	};
-	u16 ntlv;
-
-	ptlv = skb_put(skb, len);
-	memcpy(ptlv, &tlv, sizeof(tlv));
-
-	ntlv = le16_to_cpu(ntlv_hdr->tlv_num);
-	ntlv_hdr->tlv_num = cpu_to_le16(ntlv + 1);
-
-	if (sta_hdr) {
-		u16 size = le16_to_cpu(sta_hdr->len);
-
-		sta_hdr->len = cpu_to_le16(size + len);
-	}
-
-	return ptlv;
-}
-
-static struct tlv *
-mt7921_mcu_add_tlv(struct sk_buff *skb, int tag, int len)
-{
-	return mt7921_mcu_add_nested_tlv(skb, tag, len, skb->data, NULL);
-}
-
-static void
-mt7921_mcu_uni_bss_he_tlv(struct tlv *tlv, struct ieee80211_vif *vif,
-			  struct mt7921_phy *phy)
-{
-#define DEFAULT_HE_PE_DURATION		4
-#define DEFAULT_HE_DURATION_RTS_THRES	1023
-	const struct ieee80211_sta_he_cap *cap;
-	struct bss_info_uni_he *he;
-
-	cap = mt7921_get_he_phy_cap(phy, vif);
-
-	he = (struct bss_info_uni_he *)tlv;
-	he->he_pe_duration = vif->bss_conf.htc_trig_based_pkt_ext;
-	if (!he->he_pe_duration)
-		he->he_pe_duration = DEFAULT_HE_PE_DURATION;
-
-	he->he_rts_thres = cpu_to_le16(vif->bss_conf.frame_time_rts_th);
-	if (!he->he_rts_thres)
-		he->he_rts_thres = cpu_to_le16(DEFAULT_HE_DURATION_RTS_THRES);
-
-	he->max_nss_mcs[CMD_HE_MCS_BW80] = cap->he_mcs_nss_supp.tx_mcs_80;
-	he->max_nss_mcs[CMD_HE_MCS_BW160] = cap->he_mcs_nss_supp.tx_mcs_160;
-	he->max_nss_mcs[CMD_HE_MCS_BW8080] = cap->he_mcs_nss_supp.tx_mcs_80p80;
-}
-
 /** starec & wtbl **/
 static int
 mt7921_mcu_sta_key_tlv(struct mt7921_sta *msta, struct sk_buff *skb,
@@ -783,7 +550,7 @@ mt7921_mcu_sta_key_tlv(struct mt7921_sta *msta, struct sk_buff *skb,
 	struct tlv *tlv;
 	u32 len = sizeof(*sec);
 
-	tlv = mt7921_mcu_add_tlv(skb, STA_REC_KEY_V2, sizeof(*sec));
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_KEY_V2, sizeof(*sec));
 
 	sec = (struct sta_rec_sec *)tlv;
 	sec->add = cmd;
@@ -848,10 +615,10 @@ int mt7921_mcu_add_key(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 {
 	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
 	struct sk_buff *skb;
-	int len = sizeof(struct sta_req_hdr) + sizeof(struct sta_rec_sec);
 	int ret;
 
-	skb = mt7921_mcu_alloc_sta_req(dev, mvif, msta, len);
+	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
+					    &msta->wcid);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -863,540 +630,27 @@ int mt7921_mcu_add_key(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 				     MCU_UNI_CMD_STA_REC_UPDATE, true);
 }
 
-static void
-mt7921_mcu_sta_ba_tlv(struct sk_buff *skb,
-		      struct ieee80211_ampdu_params *params,
-		      bool enable, bool tx)
-{
-	struct sta_rec_ba *ba;
-	struct tlv *tlv;
-
-	tlv = mt7921_mcu_add_tlv(skb, STA_REC_BA, sizeof(*ba));
-
-	ba = (struct sta_rec_ba *)tlv;
-	ba->ba_type = tx ? MT_BA_TYPE_ORIGINATOR : MT_BA_TYPE_RECIPIENT,
-	ba->winsize = cpu_to_le16(params->buf_size);
-	ba->ssn = cpu_to_le16(params->ssn);
-	ba->ba_en = enable << params->tid;
-	ba->amsdu = params->amsdu;
-	ba->tid = params->tid;
-}
-
-static void
-mt7921_mcu_wtbl_ba_tlv(struct sk_buff *skb,
-		       struct ieee80211_ampdu_params *params,
-		       bool enable, bool tx, void *sta_wtbl,
-		       void *wtbl_tlv)
-{
-	struct wtbl_ba *ba;
-	struct tlv *tlv;
-
-	tlv = mt7921_mcu_add_nested_tlv(skb, WTBL_BA, sizeof(*ba),
-					wtbl_tlv, sta_wtbl);
-
-	ba = (struct wtbl_ba *)tlv;
-	ba->tid = params->tid;
-
-	if (tx) {
-		ba->ba_type = MT_BA_TYPE_ORIGINATOR;
-		ba->sn = enable ? cpu_to_le16(params->ssn) : 0;
-		ba->ba_en = enable;
-	} else {
-		memcpy(ba->peer_addr, params->sta->addr, ETH_ALEN);
-		ba->ba_type = MT_BA_TYPE_RECIPIENT;
-		ba->rst_ba_tid = params->tid;
-		ba->rst_ba_sel = RST_BA_MAC_TID_MATCH;
-		ba->rst_ba_sb = 1;
-	}
-
-	if (enable && tx)
-		ba->ba_winsize = cpu_to_le16(params->buf_size);
-}
-
-static int
-mt7921_mcu_sta_ba(struct mt7921_dev *dev,
-		  struct ieee80211_ampdu_params *params,
-		  bool enable, bool tx, int cmd)
+int mt7921_mcu_uni_tx_ba(struct mt7921_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool enable)
 {
 	struct mt7921_sta *msta = (struct mt7921_sta *)params->sta->drv_priv;
-	struct mt7921_vif *mvif = msta->vif;
-	struct wtbl_req_hdr *wtbl_hdr;
-	struct tlv *sta_wtbl;
-	struct sk_buff *skb;
-	int ret;
 
-	if (enable && tx && !params->amsdu)
+	if (enable && !params->amsdu)
 		msta->wcid.amsdu = false;
 
-	skb = mt7921_mcu_alloc_sta_req(dev, mvif, msta,
-				       MT7921_STA_UPDATE_MAX_SIZE);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	sta_wtbl = mt7921_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
-
-	wtbl_hdr = mt7921_mcu_alloc_wtbl_req(dev, msta, WTBL_SET, sta_wtbl,
-					     &skb);
-	mt7921_mcu_wtbl_ba_tlv(skb, params, enable, tx, sta_wtbl, wtbl_hdr);
-
-	ret = mt76_mcu_skb_send_msg(&dev->mt76, skb, cmd, true);
-	if (ret)
-		return ret;
-
-	skb = mt7921_mcu_alloc_sta_req(dev, mvif, msta,
-				       MT7921_STA_UPDATE_MAX_SIZE);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	mt7921_mcu_sta_ba_tlv(skb, params, enable, tx);
-
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb, cmd, true);
-}
-
-int mt7921_mcu_uni_tx_ba(struct mt7921_dev *dev,
-			 struct ieee80211_ampdu_params *params,
-			 bool enable)
-{
-	return mt7921_mcu_sta_ba(dev, params, enable, true, MCU_UNI_CMD_STA_REC_UPDATE);
+	return mt76_connac_mcu_sta_ba(&dev->mt76, &msta->vif->mt76, params,
+				      enable, true);
 }
 
 int mt7921_mcu_uni_rx_ba(struct mt7921_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable)
 {
-	return mt7921_mcu_sta_ba(dev, params, enable, false, MCU_UNI_CMD_STA_REC_UPDATE);
-}
-
-static void
-mt7921_mcu_wtbl_generic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
-			    struct ieee80211_sta *sta, void *sta_wtbl,
-			    void *wtbl_tlv)
-{
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
-	struct wtbl_generic *generic;
-	struct wtbl_rx *rx;
-	struct tlv *tlv;
-
-	tlv = mt7921_mcu_add_nested_tlv(skb, WTBL_GENERIC, sizeof(*generic),
-					wtbl_tlv, sta_wtbl);
-
-	generic = (struct wtbl_generic *)tlv;
-
-	if (sta) {
-		if (vif->type == NL80211_IFTYPE_STATION)
-			generic->partial_aid = cpu_to_le16(vif->bss_conf.aid);
-		else
-			generic->partial_aid = cpu_to_le16(sta->aid);
-		memcpy(generic->peer_addr, sta->addr, ETH_ALEN);
-		generic->muar_idx = mvif->mt76.omac_idx;
-		generic->qos = sta->wme;
-	} else {
-		/* use BSSID in station mode */
-		if (vif->type == NL80211_IFTYPE_STATION)
-			memcpy(generic->peer_addr, vif->bss_conf.bssid,
-			       ETH_ALEN);
-		else
-			eth_broadcast_addr(generic->peer_addr);
-
-		generic->muar_idx = 0xe;
-	}
-
-	tlv = mt7921_mcu_add_nested_tlv(skb, WTBL_RX, sizeof(*rx),
-					wtbl_tlv, sta_wtbl);
-
-	rx = (struct wtbl_rx *)tlv;
-	rx->rca1 = sta ? vif->type != NL80211_IFTYPE_AP : 1;
-	rx->rca2 = 1;
-	rx->rv = 1;
-}
-
-static void
-mt7921_mcu_sta_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
-			 struct ieee80211_sta *sta, bool enable)
-{
-#define EXTRA_INFO_VER          BIT(0)
-#define EXTRA_INFO_NEW          BIT(1)
-	struct sta_rec_basic *basic;
-	struct tlv *tlv;
-	int conn_type;
-
-	tlv = mt7921_mcu_add_tlv(skb, STA_REC_BASIC, sizeof(*basic));
-
-	basic = (struct sta_rec_basic *)tlv;
-	basic->extra_info = cpu_to_le16(EXTRA_INFO_VER);
-
-	if (enable) {
-		basic->extra_info |= cpu_to_le16(EXTRA_INFO_NEW);
-		basic->conn_state = CONN_STATE_PORT_SECURE;
-	} else {
-		basic->conn_state = CONN_STATE_DISCONNECT;
-	}
-
-	if (!sta) {
-		basic->conn_type = cpu_to_le32(CONNECTION_INFRA_BC);
-		eth_broadcast_addr(basic->peer_addr);
-		return;
-	}
-
-	switch (vif->type) {
-	case NL80211_IFTYPE_MESH_POINT:
-	case NL80211_IFTYPE_AP:
-		if (vif->p2p)
-			conn_type = CONNECTION_P2P_GC;
-		else
-			conn_type = CONNECTION_INFRA_STA;
-		basic->conn_type = cpu_to_le32(conn_type);
-		basic->aid = cpu_to_le16(sta->aid);
-		break;
-	case NL80211_IFTYPE_STATION:
-		if (vif->p2p)
-			conn_type = CONNECTION_P2P_GO;
-		else
-			conn_type = CONNECTION_INFRA_AP;
-		basic->conn_type = cpu_to_le32(conn_type);
-		basic->aid = cpu_to_le16(vif->bss_conf.aid);
-		break;
-	case NL80211_IFTYPE_ADHOC:
-		basic->conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
-		basic->aid = cpu_to_le16(sta->aid);
-		break;
-	default:
-		WARN_ON(1);
-		break;
-	}
-
-	memcpy(basic->peer_addr, sta->addr, ETH_ALEN);
-	basic->qos = sta->wme;
-}
-
-static void
-mt7921_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
-{
-	struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
-	struct ieee80211_he_cap_elem *elem = &he_cap->he_cap_elem;
-	struct sta_rec_he *he;
-	struct tlv *tlv;
-	u32 cap = 0;
-
-	tlv = mt7921_mcu_add_tlv(skb, STA_REC_HE, sizeof(*he));
-
-	he = (struct sta_rec_he *)tlv;
-
-	if (elem->mac_cap_info[0] & IEEE80211_HE_MAC_CAP0_HTC_HE)
-		cap |= STA_REC_HE_CAP_HTC;
-
-	if (elem->mac_cap_info[2] & IEEE80211_HE_MAC_CAP2_BSR)
-		cap |= STA_REC_HE_CAP_BSR;
-
-	if (elem->mac_cap_info[3] & IEEE80211_HE_MAC_CAP3_OMI_CONTROL)
-		cap |= STA_REC_HE_CAP_OM;
-
-	if (elem->mac_cap_info[4] & IEEE80211_HE_MAC_CAP4_AMDSU_IN_AMPDU)
-		cap |= STA_REC_HE_CAP_AMSDU_IN_AMPDU;
-
-	if (elem->mac_cap_info[4] & IEEE80211_HE_MAC_CAP4_BQR)
-		cap |= STA_REC_HE_CAP_BQR;
-
-	if (elem->phy_cap_info[0] &
-	    (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_2G |
-	     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_5G))
-		cap |= STA_REC_HE_CAP_BW20_RU242_SUPPORT;
-
-	if (elem->phy_cap_info[1] &
-	    IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD)
-		cap |= STA_REC_HE_CAP_LDPC;
-
-	if (elem->phy_cap_info[1] &
-	    IEEE80211_HE_PHY_CAP1_HE_LTF_AND_GI_FOR_HE_PPDUS_0_8US)
-		cap |= STA_REC_HE_CAP_SU_PPDU_1LTF_8US_GI;
-
-	if (elem->phy_cap_info[2] &
-	    IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US)
-		cap |= STA_REC_HE_CAP_NDP_4LTF_3DOT2MS_GI;
-
-	if (elem->phy_cap_info[2] &
-	    IEEE80211_HE_PHY_CAP2_STBC_TX_UNDER_80MHZ)
-		cap |= STA_REC_HE_CAP_LE_EQ_80M_TX_STBC;
-
-	if (elem->phy_cap_info[2] &
-	    IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ)
-		cap |= STA_REC_HE_CAP_LE_EQ_80M_RX_STBC;
-
-	if (elem->phy_cap_info[6] &
-	    IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE)
-		cap |= STA_REC_HE_CAP_PARTIAL_BW_EXT_RANGE;
-
-	if (elem->phy_cap_info[7] &
-	    IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI)
-		cap |= STA_REC_HE_CAP_SU_MU_PPDU_4LTF_8US_GI;
-
-	if (elem->phy_cap_info[7] &
-	    IEEE80211_HE_PHY_CAP7_STBC_TX_ABOVE_80MHZ)
-		cap |= STA_REC_HE_CAP_GT_80M_TX_STBC;
-
-	if (elem->phy_cap_info[7] &
-	    IEEE80211_HE_PHY_CAP7_STBC_RX_ABOVE_80MHZ)
-		cap |= STA_REC_HE_CAP_GT_80M_RX_STBC;
-
-	if (elem->phy_cap_info[8] &
-	    IEEE80211_HE_PHY_CAP8_HE_ER_SU_PPDU_4XLTF_AND_08_US_GI)
-		cap |= STA_REC_HE_CAP_ER_SU_PPDU_4LTF_8US_GI;
-
-	if (elem->phy_cap_info[8] &
-	    IEEE80211_HE_PHY_CAP8_HE_ER_SU_1XLTF_AND_08_US_GI)
-		cap |= STA_REC_HE_CAP_ER_SU_PPDU_1LTF_8US_GI;
-
-	if (elem->phy_cap_info[9] &
-	    IEEE80211_HE_PHY_CAP9_NON_TRIGGERED_CQI_FEEDBACK)
-		cap |= STA_REC_HE_CAP_TRIG_CQI_FK;
-
-	if (elem->phy_cap_info[9] &
-	    IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU)
-		cap |= STA_REC_HE_CAP_TX_1024QAM_UNDER_RU242;
-
-	if (elem->phy_cap_info[9] &
-	    IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU)
-		cap |= STA_REC_HE_CAP_RX_1024QAM_UNDER_RU242;
-
-	he->he_cap = cpu_to_le32(cap);
-
-	switch (sta->bandwidth) {
-	case IEEE80211_STA_RX_BW_160:
-		if (elem->phy_cap_info[0] &
-		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
-			he->max_nss_mcs[CMD_HE_MCS_BW8080] =
-				he_cap->he_mcs_nss_supp.rx_mcs_80p80;
-
-		he->max_nss_mcs[CMD_HE_MCS_BW160] =
-				he_cap->he_mcs_nss_supp.rx_mcs_160;
-		fallthrough;
-	default:
-		he->max_nss_mcs[CMD_HE_MCS_BW80] =
-				he_cap->he_mcs_nss_supp.rx_mcs_80;
-		break;
-	}
-
-	he->t_frame_dur =
-		HE_MAC(CAP1_TF_MAC_PAD_DUR_MASK, elem->mac_cap_info[1]);
-	he->max_ampdu_exp =
-		HE_MAC(CAP3_MAX_AMPDU_LEN_EXP_MASK, elem->mac_cap_info[3]);
-
-	he->bw_set =
-		HE_PHY(CAP0_CHANNEL_WIDTH_SET_MASK, elem->phy_cap_info[0]);
-	he->device_class =
-		HE_PHY(CAP1_DEVICE_CLASS_A, elem->phy_cap_info[1]);
-	he->punc_pream_rx =
-		HE_PHY(CAP1_PREAMBLE_PUNC_RX_MASK, elem->phy_cap_info[1]);
-
-	he->dcm_tx_mode =
-		HE_PHY(CAP3_DCM_MAX_CONST_TX_MASK, elem->phy_cap_info[3]);
-	he->dcm_tx_max_nss =
-		HE_PHY(CAP3_DCM_MAX_TX_NSS_2, elem->phy_cap_info[3]);
-	he->dcm_rx_mode =
-		HE_PHY(CAP3_DCM_MAX_CONST_RX_MASK, elem->phy_cap_info[3]);
-	he->dcm_rx_max_nss =
-		HE_PHY(CAP3_DCM_MAX_RX_NSS_2, elem->phy_cap_info[3]);
-	he->dcm_rx_max_nss =
-		HE_PHY(CAP8_DCM_MAX_RU_MASK, elem->phy_cap_info[8]);
-
-	he->pkt_ext = 2;
-}
-
-static void
-mt7921_mcu_sta_uapsd_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
-			 struct ieee80211_vif *vif)
-{
-	struct sta_rec_uapsd *uapsd;
-	struct tlv *tlv;
-
-	if (vif->type != NL80211_IFTYPE_AP || !sta->wme)
-		return;
-
-	tlv = mt7921_mcu_add_tlv(skb, STA_REC_APPS, sizeof(*uapsd));
-	uapsd = (struct sta_rec_uapsd *)tlv;
-
-	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_VO) {
-		uapsd->dac_map |= BIT(3);
-		uapsd->tac_map |= BIT(3);
-	}
-	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_VI) {
-		uapsd->dac_map |= BIT(2);
-		uapsd->tac_map |= BIT(2);
-	}
-	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_BE) {
-		uapsd->dac_map |= BIT(1);
-		uapsd->tac_map |= BIT(1);
-	}
-	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_BK) {
-		uapsd->dac_map |= BIT(0);
-		uapsd->tac_map |= BIT(0);
-	}
-	uapsd->max_sp = sta->max_sp;
-}
-
-static void
-mt7921_mcu_sta_amsdu_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
-{
-	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
-	struct sta_rec_amsdu *amsdu;
-	struct tlv *tlv;
-
-	if (!sta->max_amsdu_len)
-		return;
-
-	tlv = mt7921_mcu_add_tlv(skb, STA_REC_HW_AMSDU, sizeof(*amsdu));
-	amsdu = (struct sta_rec_amsdu *)tlv;
-	amsdu->max_amsdu_num = 8;
-	amsdu->amsdu_en = true;
-	amsdu->max_mpdu_size = sta->max_amsdu_len >=
-			       IEEE80211_MAX_MPDU_LEN_VHT_7991;
-	msta->wcid.amsdu = true;
-}
-
-static bool
-mt7921_hw_amsdu_supported(struct ieee80211_vif *vif)
-{
-	switch (vif->type) {
-	case NL80211_IFTYPE_AP:
-	case NL80211_IFTYPE_STATION:
-		return true;
-	default:
-		return false;
-	}
-}
-
-static void
-mt7921_mcu_sta_tlv(struct mt7921_dev *dev, struct sk_buff *skb,
-		   struct ieee80211_sta *sta, struct ieee80211_vif *vif)
-{
-	struct tlv *tlv;
-	struct sta_rec_state *state;
-	struct sta_rec_phy *phy;
-	struct sta_rec_ra_info *ra_info;
-	struct cfg80211_chan_def *chandef = &dev->mphy.chandef;
-	enum nl80211_band band = chandef->chan->band;
-
-	/* starec ht */
-	if (sta->ht_cap.ht_supported) {
-		struct sta_rec_ht *ht;
-
-		tlv = mt7921_mcu_add_tlv(skb, STA_REC_HT, sizeof(*ht));
-		ht = (struct sta_rec_ht *)tlv;
-		ht->ht_cap = cpu_to_le16(sta->ht_cap.cap);
-
-		if (mt7921_hw_amsdu_supported(vif))
-			mt7921_mcu_sta_amsdu_tlv(skb, sta);
-	}
-
-	/* starec vht */
-	if (sta->vht_cap.vht_supported) {
-		struct sta_rec_vht *vht;
-
-		tlv = mt7921_mcu_add_tlv(skb, STA_REC_VHT, sizeof(*vht));
-		vht = (struct sta_rec_vht *)tlv;
-		vht->vht_cap = cpu_to_le32(sta->vht_cap.cap);
-		vht->vht_rx_mcs_map = sta->vht_cap.vht_mcs.rx_mcs_map;
-		vht->vht_tx_mcs_map = sta->vht_cap.vht_mcs.tx_mcs_map;
-	}
-
-	/* starec he */
-	if (sta->he_cap.has_he)
-		mt7921_mcu_sta_he_tlv(skb, sta);
-
-	/* starec uapsd */
-	mt7921_mcu_sta_uapsd_tlv(skb, sta, vif);
-
-	tlv = mt7921_mcu_add_tlv(skb, STA_REC_PHY, sizeof(*phy));
-	phy = (struct sta_rec_phy *)tlv;
-	phy->phy_type = mt7921_get_phy_mode_v2(dev, vif, band, sta);
-	phy->basic_rate = cpu_to_le16((u16)vif->bss_conf.basic_rates);
-
-	tlv = mt7921_mcu_add_tlv(skb, STA_REC_RA, sizeof(*ra_info));
-	ra_info = (struct sta_rec_ra_info *)tlv;
-	ra_info->legacy = cpu_to_le16((u16)sta->supp_rates[band]);
-
-	if (sta->ht_cap.ht_supported) {
-		memcpy(ra_info->rx_mcs_bitmask, sta->ht_cap.mcs.rx_mask,
-		       HT_MCS_MASK_NUM);
-	}
-
-	tlv = mt7921_mcu_add_tlv(skb, STA_REC_STATE, sizeof(*state));
-	state = (struct sta_rec_state *)tlv;
-	state->state = 2;
-
-	if (sta->vht_cap.vht_supported) {
-		state->vht_opmode = sta->bandwidth;
-		state->vht_opmode |= (sta->rx_nss - 1) <<
-			IEEE80211_OPMODE_NOTIF_RX_NSS_SHIFT;
-	}
-}
-
-static void
-mt7921_mcu_wtbl_smps_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
-			 void *sta_wtbl, void *wtbl_tlv)
-{
-	struct wtbl_smps *smps;
-	struct tlv *tlv;
-
-	tlv = mt7921_mcu_add_nested_tlv(skb, WTBL_SMPS, sizeof(*smps),
-					wtbl_tlv, sta_wtbl);
-	smps = (struct wtbl_smps *)tlv;
-
-	if (sta->smps_mode == IEEE80211_SMPS_DYNAMIC)
-		smps->smps = true;
-}
-
-static void
-mt7921_mcu_wtbl_ht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
-		       void *sta_wtbl, void *wtbl_tlv)
-{
-	struct wtbl_ht *ht = NULL;
-	struct tlv *tlv;
-
-	/* wtbl ht */
-	if (sta->ht_cap.ht_supported) {
-		tlv = mt7921_mcu_add_nested_tlv(skb, WTBL_HT, sizeof(*ht),
-						wtbl_tlv, sta_wtbl);
-		ht = (struct wtbl_ht *)tlv;
-		ht->ldpc = !!(sta->ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING);
-		ht->af = sta->ht_cap.ampdu_factor;
-		ht->mm = sta->ht_cap.ampdu_density;
-		ht->ht = true;
-	}
-
-	/* wtbl vht */
-	if (sta->vht_cap.vht_supported) {
-		struct wtbl_vht *vht;
-		u8 af;
-
-		tlv = mt7921_mcu_add_nested_tlv(skb, WTBL_VHT, sizeof(*vht),
-						wtbl_tlv, sta_wtbl);
-		vht = (struct wtbl_vht *)tlv;
-		vht->ldpc = !!(sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC);
-		vht->vht = true;
-
-		af = FIELD_GET(IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK,
-			       sta->vht_cap.cap);
-		if (ht)
-			ht->af = max_t(u8, ht->af, af);
-	}
-
-	mt7921_mcu_wtbl_smps_tlv(skb, sta, sta_wtbl, wtbl_tlv);
-}
-
-static int mt7921_mcu_start_firmware(struct mt7921_dev *dev, u32 addr,
-				     u32 option)
-{
-	struct {
-		__le32 option;
-		__le32 addr;
-	} req = {
-		.option = cpu_to_le32(option),
-		.addr = cpu_to_le32(addr),
-	};
+	struct mt7921_sta *msta = (struct mt7921_sta *)params->sta->drv_priv;
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_FW_START_REQ, &req,
-				 sizeof(req), true);
+	return mt76_connac_mcu_sta_ba(&dev->mt76, &msta->vif->mt76, params,
+				      enable, false);
 }
 
 static int mt7921_mcu_restart(struct mt76_dev *dev)
@@ -1412,31 +666,6 @@ static int mt7921_mcu_restart(struct mt76_dev *dev)
 				 sizeof(req), false);
 }
 
-static int mt7921_mcu_patch_sem_ctrl(struct mt7921_dev *dev, bool get)
-{
-	struct {
-		__le32 op;
-	} req = {
-		.op = cpu_to_le32(get ? PATCH_SEM_GET : PATCH_SEM_RELEASE),
-	};
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_PATCH_SEM_CONTROL, &req,
-				 sizeof(req), true);
-}
-
-static int mt7921_mcu_start_patch(struct mt7921_dev *dev)
-{
-	struct {
-		u8 check_crc;
-		u8 reserved[3];
-	} req = {
-		.check_crc = 0,
-	};
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_PATCH_FINISH_REQ, &req,
-				 sizeof(req), true);
-}
-
 static int mt7921_driver_own(struct mt7921_dev *dev)
 {
 	u32 reg = mt7921_reg_map_l1(dev, MT_TOP_LPCR_HOST_BAND0);
@@ -1451,35 +680,13 @@ static int mt7921_driver_own(struct mt7921_dev *dev)
 	return 0;
 }
 
-static int mt7921_mcu_init_download(struct mt7921_dev *dev, u32 addr,
-				    u32 len, u32 mode)
-{
-	struct {
-		__le32 addr;
-		__le32 len;
-		__le32 mode;
-	} req = {
-		.addr = cpu_to_le32(addr),
-		.len = cpu_to_le32(len),
-		.mode = cpu_to_le32(mode),
-	};
-	int attr;
-
-	if (req.addr == cpu_to_le32(MCU_PATCH_ADDRESS) || addr == 0x900000)
-		attr = MCU_CMD_PATCH_START_REQ;
-	else
-		attr = MCU_CMD_TARGET_ADDRESS_LEN_REQ;
-
-	return mt76_mcu_send_msg(&dev->mt76, attr, &req, sizeof(req), true);
-}
-
 static int mt7921_load_patch(struct mt7921_dev *dev)
 {
 	const struct mt7921_patch_hdr *hdr;
 	const struct firmware *fw = NULL;
 	int i, ret, sem;
 
-	sem = mt7921_mcu_patch_sem_ctrl(dev, 1);
+	sem = mt76_connac_mcu_patch_sem_ctrl(&dev->mt76, true);
 	switch (sem) {
 	case PATCH_IS_DL:
 		return 0;
@@ -1522,8 +729,8 @@ static int mt7921_load_patch(struct mt7921_dev *dev)
 		len = be32_to_cpu(sec->info.len);
 		dl = fw->data + be32_to_cpu(sec->offs);
 
-		ret = mt7921_mcu_init_download(dev, addr, len,
-					       DL_MODE_NEED_RSP);
+		ret = mt76_connac_mcu_init_download(&dev->mt76, addr, len,
+						    DL_MODE_NEED_RSP);
 		if (ret) {
 			dev_err(dev->mt76.dev, "Download request failed\n");
 			goto out;
@@ -1537,12 +744,12 @@ static int mt7921_load_patch(struct mt7921_dev *dev)
 		}
 	}
 
-	ret = mt7921_mcu_start_patch(dev);
+	ret = mt76_connac_mcu_start_patch(&dev->mt76);
 	if (ret)
 		dev_err(dev->mt76.dev, "Failed to start patch\n");
 
 out:
-	sem = mt7921_mcu_patch_sem_ctrl(dev, 0);
+	sem = mt76_connac_mcu_patch_sem_ctrl(&dev->mt76, false);
 	switch (sem) {
 	case PATCH_REL_SEM_SUCCESS:
 		break;
@@ -1594,7 +801,8 @@ mt7921_mcu_send_ram_firmware(struct mt7921_dev *dev,
 		if (region->feature_set & FW_FEATURE_OVERRIDE_ADDR)
 			override = addr;
 
-		err = mt7921_mcu_init_download(dev, addr, len, mode);
+		err = mt76_connac_mcu_init_download(&dev->mt76, addr, len,
+						    mode);
 		if (err) {
 			dev_err(dev->mt76.dev, "Download request failed\n");
 			return err;
@@ -1616,7 +824,7 @@ mt7921_mcu_send_ram_firmware(struct mt7921_dev *dev,
 	if (is_wa)
 		option |= FW_START_WORKING_PDA_CR4;
 
-	return mt7921_mcu_start_firmware(dev, override, option);
+	return mt76_connac_mcu_start_firmware(&dev->mt76, override, option);
 }
 
 static int mt7921_load_ram(struct mt7921_dev *dev)
@@ -1758,42 +966,6 @@ void mt7921_mcu_exit(struct mt7921_dev *dev)
 	skb_queue_purge(&dev->mt76.mcu.res_q);
 }
 
-int mt7921_mcu_set_mac(struct mt7921_dev *dev, int band,
-		       bool enable, bool hdr_trans)
-{
-	struct {
-		u8 enable;
-		u8 band;
-		u8 rsv[2];
-	} __packed req_mac = {
-		.enable = enable,
-		.band = band,
-	};
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_MAC_INIT_CTRL,
-				 &req_mac, sizeof(req_mac), true);
-}
-
-int mt7921_mcu_set_rts_thresh(struct mt7921_phy *phy, u32 val)
-{
-	struct mt7921_dev *dev = phy->dev;
-	struct {
-		u8 prot_idx;
-		u8 band;
-		u8 rsv[2];
-		__le32 len_thresh;
-		__le32 pkt_thresh;
-	} __packed req = {
-		.prot_idx = 1,
-		.band = phy != &dev->phy,
-		.len_thresh = cpu_to_le32(val),
-		.pkt_thresh = cpu_to_le32(0x2),
-	};
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_PROTECT_CTRL, &req,
-				 sizeof(req), true);
-}
-
 int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif)
 {
 #define WMM_AIFS_SET		BIT(0)
@@ -1938,370 +1110,6 @@ int mt7921_mcu_get_eeprom(struct mt7921_dev *dev, u32 offset)
 	return 0;
 }
 
-int
-mt7921_mcu_uni_add_dev(struct mt7921_dev *dev,
-		       struct ieee80211_vif *vif, bool enable)
-{
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
-	u8 omac_idx = mvif->mt76.omac_idx;
-	struct {
-		struct {
-			u8 omac_idx;
-			u8 band_idx;
-			__le16 pad;
-		} __packed hdr;
-		struct req_tlv {
-			__le16 tag;
-			__le16 len;
-			u8 active;
-			u8 pad;
-			u8 omac_addr[ETH_ALEN];
-		} __packed tlv;
-	} dev_req = {
-		.hdr = {
-			.omac_idx = omac_idx,
-			.band_idx = mvif->mt76.band_idx,
-		},
-		.tlv = {
-			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
-			.len = cpu_to_le16(sizeof(struct req_tlv)),
-			.active = enable,
-		},
-	};
-	struct {
-		struct {
-			u8 bss_idx;
-			u8 pad[3];
-		} __packed hdr;
-		struct mt7921_bss_basic_tlv basic;
-	} basic_req = {
-		.hdr = {
-			.bss_idx = mvif->mt76.idx,
-		},
-		.basic = {
-			.tag = cpu_to_le16(UNI_BSS_INFO_BASIC),
-			.len = cpu_to_le16(sizeof(struct mt7921_bss_basic_tlv)),
-			.omac_idx = omac_idx,
-			.band_idx = mvif->mt76.band_idx,
-			.wmm_idx = mvif->mt76.wmm_idx,
-			.active = enable,
-			.bmc_tx_wlan_idx = cpu_to_le16(mvif->sta.wcid.idx),
-			.sta_idx = cpu_to_le16(mvif->sta.wcid.idx),
-			.conn_state = 1,
-		},
-	};
-	int err, idx, cmd, len;
-	void *data;
-
-	switch (vif->type) {
-	case NL80211_IFTYPE_MESH_POINT:
-	case NL80211_IFTYPE_AP:
-		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_AP);
-		break;
-	case NL80211_IFTYPE_STATION:
-		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_STA);
-		break;
-	case NL80211_IFTYPE_ADHOC:
-		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
-		break;
-	default:
-		WARN_ON(1);
-		break;
-	}
-
-	idx = omac_idx > EXT_BSSID_START ? HW_BSSID_0 : omac_idx;
-	basic_req.basic.hw_bss_idx = idx;
-
-	memcpy(dev_req.tlv.omac_addr, vif->addr, ETH_ALEN);
-
-	cmd = enable ? MCU_UNI_CMD_DEV_INFO_UPDATE : MCU_UNI_CMD_BSS_INFO_UPDATE;
-	data = enable ? (void *)&dev_req : (void *)&basic_req;
-	len = enable ? sizeof(dev_req) : sizeof(basic_req);
-
-	err = mt76_mcu_send_msg(&dev->mt76, cmd, data, len, true);
-	if (err < 0)
-		return err;
-
-	cmd = enable ? MCU_UNI_CMD_BSS_INFO_UPDATE : MCU_UNI_CMD_DEV_INFO_UPDATE;
-	data = enable ? (void *)&basic_req : (void *)&dev_req;
-	len = enable ? sizeof(basic_req) : sizeof(dev_req);
-
-	return mt76_mcu_send_msg(&dev->mt76, cmd, data, len, true);
-}
-
-int
-mt7921_mcu_uni_add_bss(struct mt7921_phy *phy, struct ieee80211_vif *vif,
-		       bool enable)
-{
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
-	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
-	int freq1 = chandef->center_freq1, freq2 = chandef->center_freq2;
-	struct mt7921_dev *dev = phy->dev;
-	enum nl80211_band band = chandef->chan->band;
-	u8 omac_idx = mvif->mt76.omac_idx;
-	struct {
-		struct {
-			u8 bss_idx;
-			u8 pad[3];
-		} __packed hdr;
-		struct mt7921_bss_basic_tlv basic;
-		struct mt7921_bss_qos_tlv qos;
-	} basic_req = {
-		.hdr = {
-			.bss_idx = mvif->mt76.idx,
-		},
-		.basic = {
-			.tag = cpu_to_le16(UNI_BSS_INFO_BASIC),
-			.len = cpu_to_le16(sizeof(struct mt7921_bss_basic_tlv)),
-			.bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int),
-			.dtim_period = vif->bss_conf.dtim_period,
-			.omac_idx = omac_idx,
-			.band_idx = mvif->mt76.band_idx,
-			.wmm_idx = mvif->mt76.wmm_idx,
-			.active = true, /* keep bss deactivated */
-			.phymode = mt7921_get_phy_mode(phy->dev, vif, band, NULL),
-		},
-		.qos = {
-			.tag = cpu_to_le16(UNI_BSS_INFO_QBSS),
-			.len = cpu_to_le16(sizeof(struct mt7921_bss_qos_tlv)),
-			.qos = vif->bss_conf.qos,
-		},
-	};
-
-	struct {
-		struct {
-			u8 bss_idx;
-			u8 pad[3];
-		} __packed hdr;
-		struct bss_info_uni_he he;
-	} he_req = {
-		.hdr = {
-			.bss_idx = mvif->mt76.idx,
-		},
-		.he = {
-			.tag = cpu_to_le16(UNI_BSS_INFO_HE_BASIC),
-			.len = cpu_to_le16(sizeof(struct bss_info_uni_he)),
-		},
-	};
-
-	struct {
-		struct {
-			u8 bss_idx;
-			u8 pad[3];
-		} __packed hdr;
-		struct rlm_tlv {
-			__le16 tag;
-			__le16 len;
-			u8 control_channel;
-			u8 center_chan;
-			u8 center_chan2;
-			u8 bw;
-			u8 tx_streams;
-			u8 rx_streams;
-			u8 short_st;
-			u8 ht_op_info;
-			u8 sco;
-			u8 pad[3];
-		} __packed rlm;
-	} __packed rlm_req = {
-		.hdr = {
-			.bss_idx = mvif->mt76.idx,
-		},
-		.rlm = {
-			.tag = cpu_to_le16(UNI_BSS_INFO_RLM),
-			.len = cpu_to_le16(sizeof(struct rlm_tlv)),
-			.control_channel = chandef->chan->hw_value,
-			.center_chan = ieee80211_frequency_to_channel(freq1),
-			.center_chan2 = ieee80211_frequency_to_channel(freq2),
-			.tx_streams = hweight8(phy->mt76->antenna_mask),
-			.rx_streams = phy->mt76->chainmask,
-			.short_st = true,
-		},
-	};
-	int err, conn_type;
-	u8 idx;
-
-	idx = omac_idx > EXT_BSSID_START ? HW_BSSID_0 : omac_idx;
-	basic_req.basic.hw_bss_idx = idx;
-
-	switch (vif->type) {
-	case NL80211_IFTYPE_MESH_POINT:
-	case NL80211_IFTYPE_AP:
-		if (vif->p2p)
-			conn_type = CONNECTION_P2P_GO;
-		else
-			conn_type = CONNECTION_INFRA_AP;
-		basic_req.basic.conn_type = cpu_to_le32(conn_type);
-		break;
-	case NL80211_IFTYPE_STATION:
-		if (vif->p2p)
-			conn_type = CONNECTION_P2P_GC;
-		else
-			conn_type = CONNECTION_INFRA_STA;
-		basic_req.basic.conn_type = cpu_to_le32(conn_type);
-		break;
-	case NL80211_IFTYPE_ADHOC:
-		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
-		break;
-	default:
-		WARN_ON(1);
-		break;
-	}
-
-	memcpy(basic_req.basic.bssid, vif->bss_conf.bssid, ETH_ALEN);
-	basic_req.basic.bmc_tx_wlan_idx = cpu_to_le16(mvif->sta.wcid.idx);
-	basic_req.basic.sta_idx = cpu_to_le16(mvif->sta.wcid.idx);
-	basic_req.basic.conn_state = !enable;
-
-	err = mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_BSS_INFO_UPDATE,
-				&basic_req, sizeof(basic_req), true);
-	if (err < 0)
-		return err;
-
-	if (vif->bss_conf.he_support) {
-		mt7921_mcu_uni_bss_he_tlv((struct tlv *)&he_req.he, vif, phy);
-
-		err = mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_BSS_INFO_UPDATE,
-					&he_req, sizeof(he_req), true);
-		if (err < 0)
-			return err;
-	}
-
-	switch (chandef->width) {
-	case NL80211_CHAN_WIDTH_40:
-		rlm_req.rlm.bw = CMD_CBW_40MHZ;
-		break;
-	case NL80211_CHAN_WIDTH_80:
-		rlm_req.rlm.bw = CMD_CBW_80MHZ;
-		break;
-	case NL80211_CHAN_WIDTH_80P80:
-		rlm_req.rlm.bw = CMD_CBW_8080MHZ;
-		break;
-	case NL80211_CHAN_WIDTH_160:
-		rlm_req.rlm.bw = CMD_CBW_160MHZ;
-		break;
-	case NL80211_CHAN_WIDTH_5:
-		rlm_req.rlm.bw = CMD_CBW_5MHZ;
-		break;
-	case NL80211_CHAN_WIDTH_10:
-		rlm_req.rlm.bw = CMD_CBW_10MHZ;
-		break;
-	case NL80211_CHAN_WIDTH_20_NOHT:
-	case NL80211_CHAN_WIDTH_20:
-	default:
-		rlm_req.rlm.bw = CMD_CBW_20MHZ;
-		break;
-	}
-
-	if (rlm_req.rlm.control_channel < rlm_req.rlm.center_chan)
-		rlm_req.rlm.sco = 1; /* SCA */
-	else if (rlm_req.rlm.control_channel > rlm_req.rlm.center_chan)
-		rlm_req.rlm.sco = 3; /* SCB */
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_BSS_INFO_UPDATE,
-				 &rlm_req, sizeof(rlm_req), true);
-}
-
-static int
-mt7921_mcu_add_sta_cmd(struct mt7921_dev *dev, struct ieee80211_vif *vif,
-		       struct ieee80211_sta *sta, bool enable, int cmd)
-{
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
-	struct wtbl_req_hdr *wtbl_hdr;
-	struct mt7921_sta *msta;
-	struct tlv *sta_wtbl;
-	struct sk_buff *skb;
-
-	msta = sta ? (struct mt7921_sta *)sta->drv_priv : &mvif->sta;
-
-	skb = mt7921_mcu_alloc_sta_req(dev, mvif, msta,
-				       MT7921_STA_UPDATE_MAX_SIZE);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	mt7921_mcu_sta_basic_tlv(skb, vif, sta, enable);
-	if (enable && sta)
-		mt7921_mcu_sta_tlv(dev, skb, sta, vif);
-
-	sta_wtbl = mt7921_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
-
-	wtbl_hdr = mt7921_mcu_alloc_wtbl_req(dev, msta, WTBL_RESET_AND_SET,
-					     sta_wtbl, &skb);
-	if (enable) {
-		mt7921_mcu_wtbl_generic_tlv(skb, vif, sta, sta_wtbl, wtbl_hdr);
-		if (sta)
-			mt7921_mcu_wtbl_ht_tlv(skb, sta, sta_wtbl, wtbl_hdr);
-	}
-
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb, cmd, true);
-}
-
-int
-mt7921_mcu_uni_add_sta(struct mt7921_dev *dev, struct ieee80211_vif *vif,
-		       struct ieee80211_sta *sta, bool enable)
-{
-	return mt7921_mcu_add_sta_cmd(dev, vif, sta, enable,
-				      MCU_UNI_CMD_STA_REC_UPDATE);
-}
-
-int mt7921_mcu_set_channel_domain(struct mt7921_phy *phy)
-{
-	struct mt76_phy *mphy = phy->mt76;
-	struct mt7921_dev *dev = phy->dev;
-	struct mt7921_mcu_channel_domain {
-		__le32 country_code; /* regulatory_request.alpha2 */
-		u8 bw_2g; /* BW_20_40M		0
-			   * BW_20M		1
-			   * BW_20_40_80M	2
-			   * BW_20_40_80_160M	3
-			   * BW_20_40_80_8080M	4
-			   */
-		u8 bw_5g;
-		__le16 pad;
-		u8 n_2ch;
-		u8 n_5ch;
-		__le16 pad2;
-	} __packed hdr = {
-		.bw_2g = 0,
-		.bw_5g = 3,
-		.n_2ch = mphy->sband_2g.sband.n_channels,
-		.n_5ch = mphy->sband_5g.sband.n_channels,
-	};
-	struct mt7921_mcu_chan {
-		__le16 hw_value;
-		__le16 pad;
-		__le32 flags;
-	} __packed;
-	int i, n_channels = hdr.n_2ch + hdr.n_5ch;
-	int len = sizeof(hdr) + n_channels * sizeof(struct mt7921_mcu_chan);
-	struct sk_buff *skb;
-
-	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, len);
-	if (!skb)
-		return -ENOMEM;
-
-	skb_put_data(skb, &hdr, sizeof(hdr));
-
-	for (i = 0; i < n_channels; i++) {
-		struct ieee80211_channel *chan;
-		struct mt7921_mcu_chan channel;
-
-		if (i < hdr.n_2ch)
-			chan = &mphy->sband_2g.sband.channels[i];
-		else
-			chan = &mphy->sband_5g.sband.channels[i - hdr.n_2ch];
-
-		channel.hw_value = cpu_to_le16(chan->hw_value);
-		channel.flags = cpu_to_le32(chan->flags);
-		channel.pad = 0;
-
-		skb_put_data(skb, &channel, sizeof(channel));
-	}
-
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_CMD_SET_CHAN_DOMAIN,
-				     false);
-}
-
 #define MT7921_SCAN_CHANNEL_TIME	60
 int mt7921_mcu_hw_scan(struct mt7921_phy *phy, struct ieee80211_vif *vif,
 		       struct ieee80211_scan_request *scan_req)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
index 6b3877959bd3..081c9abc9386 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -4,6 +4,8 @@
 #ifndef __MT7921_MCU_H
 #define __MT7921_MCU_H
 
+#include "../mt76_connac_mcu.h"
+
 struct mt7921_mcu_txd {
 	__le32 txd[8];
 
@@ -134,60 +136,12 @@ enum {
 	MCU_S2D_H2CN
 };
 
-#define MCU_FW_PREFIX		BIT(31)
-#define MCU_UNI_PREFIX		BIT(30)
-#define MCU_CE_PREFIX		BIT(29)
-#define MCU_QUERY_PREFIX	BIT(28)
-#define MCU_CMD_MASK		~(MCU_FW_PREFIX | MCU_UNI_PREFIX |	\
-				  MCU_CE_PREFIX | MCU_QUERY_PREFIX)
-
-#define MCU_QUERY_MASK		BIT(16)
-
-enum {
-	MCU_CMD_TARGET_ADDRESS_LEN_REQ = MCU_FW_PREFIX | 0x01,
-	MCU_CMD_FW_START_REQ = MCU_FW_PREFIX | 0x02,
-	MCU_CMD_NIC_POWER_CTRL = MCU_FW_PREFIX | 0x4,
-	MCU_CMD_PATCH_START_REQ = MCU_FW_PREFIX | 0x05,
-	MCU_CMD_PATCH_FINISH_REQ = MCU_FW_PREFIX | 0x07,
-	MCU_CMD_PATCH_SEM_CONTROL = MCU_FW_PREFIX | 0x10,
-	MCU_CMD_EXT_CID = 0xED,
-	MCU_CMD_FW_SCATTER = MCU_FW_PREFIX | 0xEE,
-};
-
-enum {
-	MCU_EXT_CMD_EFUSE_ACCESS = 0x01,
-	MCU_EXT_CMD_CHANNEL_SWITCH = 0x08,
-	MCU_EXT_CMD_EFUSE_BUFFER_MODE = 0x21,
-	MCU_EXT_CMD_EDCA_UPDATE = 0x27,
-	MCU_EXT_CMD_THERMAL_CTRL = 0x2c,
-	MCU_EXT_CMD_WTBL_UPDATE = 0x32,
-	MCU_EXT_CMD_PROTECT_CTRL = 0x3e,
-	MCU_EXT_CMD_MAC_INIT_CTRL = 0x46,
-	MCU_EXT_CMD_RX_HDR_TRANS = 0x47,
-	MCU_EXT_CMD_SET_RX_PATH = 0x4e,
-};
-
-enum {
-	MCU_UNI_CMD_DEV_INFO_UPDATE = MCU_UNI_PREFIX | 0x01,
-	MCU_UNI_CMD_BSS_INFO_UPDATE = MCU_UNI_PREFIX | 0x02,
-	MCU_UNI_CMD_STA_REC_UPDATE = MCU_UNI_PREFIX | 0x03,
-	MCU_UNI_CMD_SUSPEND = MCU_UNI_PREFIX | 0x05,
-	MCU_UNI_CMD_OFFLOAD = MCU_UNI_PREFIX | 0x06,
-	MCU_UNI_CMD_HIF_CTRL = MCU_UNI_PREFIX | 0x07,
-};
-
 struct mt7921_mcu_uni_event {
 	u8 cid;
 	u8 pad[3];
 	__le32 status; /* 0: success, others: fail */
 } __packed;
 
-enum {
-	WOW_USB = 1,
-	WOW_PCIE = 2,
-	WOW_GPIO = 3,
-};
-
 struct mt7921_wow_ctrl_tlv {
 	__le16 tag;
 	__le16 len;
@@ -281,58 +235,6 @@ struct mt7921_arpns_tlv {
 	u8 pad[1];
 } __packed;
 
-/* offload mcu commands */
-enum {
-	MCU_CMD_START_HW_SCAN = MCU_CE_PREFIX | 0x03,
-	MCU_CMD_SET_CHAN_DOMAIN = MCU_CE_PREFIX | 0x0f,
-	MCU_CMD_SET_BSS_CONNECTED = MCU_CE_PREFIX | 0x16,
-	MCU_CMD_SET_BSS_ABORT = MCU_CE_PREFIX | 0x17,
-	MCU_CMD_CANCEL_HW_SCAN = MCU_CE_PREFIX | 0x1b,
-	MCU_CMD_SCHED_SCAN_ENABLE = MCU_CE_PREFIX | 0x61,
-	MCU_CMD_SCHED_SCAN_REQ = MCU_CE_PREFIX | 0x62,
-	MCU_CMD_REG_WRITE = MCU_CE_PREFIX | 0xc0,
-	MCU_CMD_REG_READ = MCU_CE_PREFIX | MCU_QUERY_MASK | 0xc0,
-	MCU_CMD_FWLOG_2_HOST = MCU_CE_PREFIX | 0xc5,
-	MCU_CMD_GET_WTBL = MCU_CE_PREFIX | 0xcd,
-};
-
-#define MCU_CMD_ACK		BIT(0)
-#define MCU_CMD_UNI		BIT(1)
-#define MCU_CMD_QUERY		BIT(2)
-
-#define MCU_CMD_UNI_EXT_ACK	(MCU_CMD_ACK | MCU_CMD_UNI | MCU_CMD_QUERY)
-
-enum {
-	UNI_BSS_INFO_BASIC = 0,
-	UNI_BSS_INFO_RLM = 2,
-	UNI_BSS_INFO_HE_BASIC = 5,
-	UNI_BSS_INFO_BCN_CONTENT = 7,
-	UNI_BSS_INFO_QBSS = 15,
-	UNI_BSS_INFO_UAPSD = 19,
-	UNI_BSS_INFO_PS = 21,
-	UNI_BSS_INFO_BCNFT = 22,
-};
-
-enum {
-	UNI_SUSPEND_MODE_SETTING,
-	UNI_SUSPEND_WOW_CTRL,
-	UNI_SUSPEND_WOW_GPIO_PARAM,
-	UNI_SUSPEND_WOW_WAKEUP_PORT,
-	UNI_SUSPEND_WOW_PATTERN,
-};
-
-enum {
-	UNI_OFFLOAD_OFFLOAD_ARP,
-	UNI_OFFLOAD_OFFLOAD_ND,
-	UNI_OFFLOAD_OFFLOAD_GTK_REKEY,
-	UNI_OFFLOAD_OFFLOAD_BMC_RPY_DETECT,
-};
-
-enum {
-	PATCH_SEM_RELEASE,
-	PATCH_SEM_GET
-};
-
 enum {
 	PATCH_NOT_DL_SEM_FAIL,
 	PATCH_IS_DL,
@@ -386,273 +288,6 @@ enum {
 #define CONNECTION_WDS			(STA_TYPE_WDS | NETWORK_WDS)
 #define CONNECTION_INFRA_BC		(STA_TYPE_BC | NETWORK_INFRA)
 
-#define CONN_STATE_DISCONNECT		0
-#define CONN_STATE_CONNECT		1
-#define CONN_STATE_PORT_SECURE		2
-
-enum {
-	DEV_INFO_ACTIVE,
-	DEV_INFO_MAX_NUM
-};
-
-enum {
-	CMD_CBW_20MHZ = IEEE80211_STA_RX_BW_20,
-	CMD_CBW_40MHZ = IEEE80211_STA_RX_BW_40,
-	CMD_CBW_80MHZ = IEEE80211_STA_RX_BW_80,
-	CMD_CBW_160MHZ = IEEE80211_STA_RX_BW_160,
-	CMD_CBW_10MHZ,
-	CMD_CBW_5MHZ,
-	CMD_CBW_8080MHZ,
-
-	CMD_HE_MCS_BW80 = 0,
-	CMD_HE_MCS_BW160,
-	CMD_HE_MCS_BW8080,
-	CMD_HE_MCS_BW_NUM
-};
-
-struct tlv {
-	__le16 tag;
-	__le16 len;
-} __packed;
-
-struct bss_info_uni_he {
-	__le16 tag;
-	__le16 len;
-	__le16 he_rts_thres;
-	u8 he_pe_duration;
-	u8 su_disable;
-	__le16 max_nss_mcs[CMD_HE_MCS_BW_NUM];
-	u8 rsv[2];
-} __packed;
-
-enum {
-	WTBL_RESET_AND_SET = 1,
-	WTBL_SET,
-	WTBL_QUERY,
-	WTBL_RESET_ALL
-};
-
-struct wtbl_req_hdr {
-	u8 wlan_idx_lo;
-	u8 operation;
-	__le16 tlv_num;
-	u8 wlan_idx_hi;
-	u8 rsv[3];
-} __packed;
-
-struct wtbl_generic {
-	__le16 tag;
-	__le16 len;
-	u8 peer_addr[ETH_ALEN];
-	u8 muar_idx;
-	u8 skip_tx;
-	u8 cf_ack;
-	u8 qos;
-	u8 mesh;
-	u8 adm;
-	__le16 partial_aid;
-	u8 baf_en;
-	u8 aad_om;
-} __packed;
-
-struct wtbl_rx {
-	__le16 tag;
-	__le16 len;
-	u8 rcid;
-	u8 rca1;
-	u8 rca2;
-	u8 rv;
-	u8 rsv[4];
-} __packed;
-
-struct wtbl_ht {
-	__le16 tag;
-	__le16 len;
-	u8 ht;
-	u8 ldpc;
-	u8 af;
-	u8 mm;
-	u8 rsv[4];
-} __packed;
-
-struct wtbl_vht {
-	__le16 tag;
-	__le16 len;
-	u8 ldpc;
-	u8 dyn_bw;
-	u8 vht;
-	u8 txop_ps;
-	u8 rsv[4];
-} __packed;
-
-struct wtbl_hdr_trans {
-	__le16 tag;
-	__le16 len;
-	u8 to_ds;
-	u8 from_ds;
-	u8 no_rx_trans;
-	u8 _rsv;
-};
-
-enum {
-	MT_BA_TYPE_INVALID,
-	MT_BA_TYPE_ORIGINATOR,
-	MT_BA_TYPE_RECIPIENT
-};
-
-enum {
-	RST_BA_MAC_TID_MATCH,
-	RST_BA_MAC_MATCH,
-	RST_BA_NO_MATCH
-};
-
-struct wtbl_ba {
-	__le16 tag;
-	__le16 len;
-	/* common */
-	u8 tid;
-	u8 ba_type;
-	u8 rsv0[2];
-	/* originator only */
-	__le16 sn;
-	u8 ba_en;
-	u8 ba_winsize_idx;
-	__le16 ba_winsize;
-	/* recipient only */
-	u8 peer_addr[ETH_ALEN];
-	u8 rst_ba_tid;
-	u8 rst_ba_sel;
-	u8 rst_ba_sb;
-	u8 band_idx;
-	u8 rsv1[4];
-} __packed;
-
-struct wtbl_smps {
-	__le16 tag;
-	__le16 len;
-	u8 smps;
-	u8 rsv[3];
-} __packed;
-
-enum {
-	WTBL_GENERIC,
-	WTBL_RX,
-	WTBL_HT,
-	WTBL_VHT,
-	WTBL_PEER_PS,		/* not used */
-	WTBL_TX_PS,
-	WTBL_HDR_TRANS,
-	WTBL_SEC_KEY,
-	WTBL_BA,
-	WTBL_RDG,		/* obsoleted */
-	WTBL_PROTECT,		/* not used */
-	WTBL_CLEAR,		/* not used */
-	WTBL_BF,
-	WTBL_SMPS,
-	WTBL_RAW_DATA,		/* debug only */
-	WTBL_PN,
-	WTBL_SPE,
-	WTBL_MAX_NUM
-};
-
-struct sta_ntlv_hdr {
-	u8 rsv[2];
-	__le16 tlv_num;
-} __packed;
-
-struct sta_req_hdr {
-	u8 bss_idx;
-	u8 wlan_idx_lo;
-	__le16 tlv_num;
-	u8 is_tlv_append;
-	u8 muar_idx;
-	u8 wlan_idx_hi;
-	u8 rsv;
-} __packed;
-
-struct sta_rec_basic {
-	__le16 tag;
-	__le16 len;
-	__le32 conn_type;
-	u8 conn_state;
-	u8 qos;
-	__le16 aid;
-	u8 peer_addr[ETH_ALEN];
-	__le16 extra_info;
-} __packed;
-
-struct sta_rec_ht {
-	__le16 tag;
-	__le16 len;
-	__le16 ht_cap;
-	u16 rsv;
-} __packed;
-
-struct sta_rec_vht {
-	__le16 tag;
-	__le16 len;
-	__le32 vht_cap;
-	__le16 vht_rx_mcs_map;
-	__le16 vht_tx_mcs_map;
-	u8 rts_bw_sig;
-	u8 rsv[3];
-} __packed;
-
-struct sta_rec_uapsd {
-	__le16 tag;
-	__le16 len;
-	u8 dac_map;
-	u8 tac_map;
-	u8 max_sp;
-	u8 rsv0;
-	__le16 listen_interval;
-	u8 rsv1[2];
-} __packed;
-
-struct sta_rec_he {
-	__le16 tag;
-	__le16 len;
-
-	__le32 he_cap;
-
-	u8 t_frame_dur;
-	u8 max_ampdu_exp;
-	u8 bw_set;
-	u8 device_class;
-	u8 dcm_tx_mode;
-	u8 dcm_tx_max_nss;
-	u8 dcm_rx_mode;
-	u8 dcm_rx_max_nss;
-	u8 dcm_max_ru;
-	u8 punc_pream_rx;
-	u8 pkt_ext;
-	u8 rsv1;
-
-	__le16 max_nss_mcs[CMD_HE_MCS_BW_NUM];
-
-	u8 rsv2[2];
-} __packed;
-
-struct sta_rec_ba {
-	__le16 tag;
-	__le16 len;
-	u8 tid;
-	u8 ba_type;
-	u8 amsdu;
-	u8 ba_en;
-	__le16 ssn;
-	__le16 winsize;
-} __packed;
-
-struct sta_rec_amsdu {
-	__le16 tag;
-	__le16 len;
-	u8 max_amsdu_num;
-	u8 max_mpdu_size;
-	u8 amsdu_en;
-	u8 rsv;
-} __packed;
-
 struct sec_key {
 	u8 cipher_id;
 	u8 cipher_len;
@@ -671,62 +306,6 @@ struct sta_rec_sec {
 	struct sec_key key[2];
 } __packed;
 
-struct sta_rec_state {
-	__le16 tag;
-	__le16 len;
-	__le32 flags;
-	u8 state;
-	u8 vht_opmode;
-	u8 action;
-	u8 rsv[1];
-} __packed;
-
-#define HT_MCS_MASK_NUM 10
-
-struct sta_rec_ra_info {
-	__le16 tag;
-	__le16 len;
-	__le16 legacy;
-	u8 rx_mcs_bitmask[HT_MCS_MASK_NUM];
-} __packed;
-
-struct sta_rec_phy {
-	__le16 tag;
-	__le16 len;
-	__le16 basic_rate;
-	u8 phy_type;
-	u8 ampdu;
-	u8 rts_policy;
-	u8 rcpi;
-	u8 rsv[2];
-} __packed;
-
-enum {
-	STA_REC_BASIC,
-	STA_REC_RA,
-	STA_REC_RA_CMM_INFO,
-	STA_REC_RA_UPDATE,
-	STA_REC_BF,
-	STA_REC_AMSDU,
-	STA_REC_BA,
-	STA_REC_STATE,
-	STA_REC_TX_PROC,	/* for hdr trans and CSO in CR4 */
-	STA_REC_HT,
-	STA_REC_VHT,
-	STA_REC_APPS,
-	STA_REC_KEY,
-	STA_REC_WTBL,
-	STA_REC_HE,
-	STA_REC_HW_AMSDU,
-	STA_REC_WTBL_AADOM,
-	STA_REC_KEY_V2,
-	STA_REC_MURU,
-	STA_REC_MUEDCA,
-	STA_REC_BFEE,
-	STA_REC_PHY = 0x15,
-	STA_REC_MAX_NUM
-};
-
 enum mt7921_cipher_type {
 	MT_CIPHER_NONE,
 	MT_CIPHER_WEP40,
@@ -787,22 +366,6 @@ enum {
 #define MT7921_WTBL_UPDATE_BA_SIZE	(sizeof(struct wtbl_req_hdr) +	\
 					 sizeof(struct wtbl_ba))
 
-#define PHY_MODE_A			BIT(0)
-#define PHY_MODE_B			BIT(1)
-#define PHY_MODE_G			BIT(2)
-#define PHY_MODE_GN			BIT(3)
-#define PHY_MODE_AN			BIT(4)
-#define PHY_MODE_AC			BIT(5)
-#define PHY_MODE_AX_24G			BIT(6)
-#define PHY_MODE_AX_5G			BIT(7)
-#define PHY_MODE_AX_6G			BIT(8)
-
-#define MODE_CCK			BIT(0)
-#define MODE_OFDM			BIT(1)
-#define MODE_HT				BIT(2)
-#define MODE_VHT			BIT(3)
-#define MODE_HE				BIT(4)
-
 #define STA_CAP_WMM			BIT(0)
 #define STA_CAP_SGI_20			BIT(4)
 #define STA_CAP_SGI_40			BIT(5)
@@ -818,77 +381,11 @@ enum {
 #define STA_CAP_VHT			BIT(27)
 #define STA_CAP_HE			BIT(28)
 
-/* HE MAC */
-#define STA_REC_HE_CAP_HTC			BIT(0)
-#define STA_REC_HE_CAP_BQR			BIT(1)
-#define STA_REC_HE_CAP_BSR			BIT(2)
-#define STA_REC_HE_CAP_OM			BIT(3)
-#define STA_REC_HE_CAP_AMSDU_IN_AMPDU		BIT(4)
-/* HE PHY */
-#define STA_REC_HE_CAP_DUAL_BAND		BIT(5)
-#define STA_REC_HE_CAP_LDPC			BIT(6)
-#define STA_REC_HE_CAP_TRIG_CQI_FK		BIT(7)
-#define STA_REC_HE_CAP_PARTIAL_BW_EXT_RANGE	BIT(8)
-/* STBC */
-#define STA_REC_HE_CAP_LE_EQ_80M_TX_STBC	BIT(9)
-#define STA_REC_HE_CAP_LE_EQ_80M_RX_STBC	BIT(10)
-#define STA_REC_HE_CAP_GT_80M_TX_STBC		BIT(11)
-#define STA_REC_HE_CAP_GT_80M_RX_STBC		BIT(12)
-/* GI */
-#define STA_REC_HE_CAP_SU_PPDU_1LTF_8US_GI	BIT(13)
-#define STA_REC_HE_CAP_SU_MU_PPDU_4LTF_8US_GI	BIT(14)
-#define STA_REC_HE_CAP_ER_SU_PPDU_1LTF_8US_GI	BIT(15)
-#define STA_REC_HE_CAP_ER_SU_PPDU_4LTF_8US_GI	BIT(16)
-#define STA_REC_HE_CAP_NDP_4LTF_3DOT2MS_GI	BIT(17)
-/* 242 TONE */
-#define STA_REC_HE_CAP_BW20_RU242_SUPPORT	BIT(18)
-#define STA_REC_HE_CAP_TX_1024QAM_UNDER_RU242	BIT(19)
-#define STA_REC_HE_CAP_RX_1024QAM_UNDER_RU242	BIT(20)
-
 struct mt7921_mcu_reg_event {
 	__le32 reg;
 	__le32 val;
 } __packed;
 
-struct mt7921_bss_basic_tlv {
-	__le16 tag;
-	__le16 len;
-	u8 active;
-	u8 omac_idx;
-	u8 hw_bss_idx;
-	u8 band_idx;
-	__le32 conn_type;
-	u8 conn_state;
-	u8 wmm_idx;
-	u8 bssid[ETH_ALEN];
-	__le16 bmc_tx_wlan_idx;
-	__le16 bcn_interval;
-	u8 dtim_period;
-	u8 phymode; /* bit(0): A
-		     * bit(1): B
-		     * bit(2): G
-		     * bit(3): GN
-		     * bit(4): AN
-		     * bit(5): AC
-		     */
-	__le16 sta_idx;
-	u8 nonht_basic_phy;
-	u8 pad[3];
-} __packed;
-
-struct mt7921_bss_qos_tlv {
-	__le16 tag;
-	__le16 len;
-	u8 qos;
-	u8 pad[3];
-} __packed;
-
-struct mt7921_beacon_loss_event {
-	u8 bss_idx;
-	u8 reason;
-	u8 pad[2];
-} __packed;
-
 struct mt7921_mcu_scan_ssid {
 	__le32 ssid_len;
 	u8 ssid[IEEE80211_MAX_SSID_LEN];
@@ -1005,37 +502,6 @@ struct mt7921_sched_scan_req {
 	u8 pad2[64];
 } __packed;
 
-struct mt7921_mcu_bss_event {
-	u8 bss_idx;
-	u8 is_absent;
-	u8 free_quota;
-	u8 pad;
-} __packed;
-
-enum {
-	PHY_TYPE_HR_DSSS_INDEX = 0,
-	PHY_TYPE_ERP_INDEX,
-	PHY_TYPE_ERP_P2P_INDEX,
-	PHY_TYPE_OFDM_INDEX,
-	PHY_TYPE_HT_INDEX,
-	PHY_TYPE_VHT_INDEX,
-	PHY_TYPE_HE_INDEX,
-	PHY_TYPE_INDEX_NUM
-};
-
-#define PHY_TYPE_BIT_HR_DSSS    BIT(PHY_TYPE_HR_DSSS_INDEX)
-#define PHY_TYPE_BIT_ERP        BIT(PHY_TYPE_ERP_INDEX)
-#define PHY_TYPE_BIT_OFDM       BIT(PHY_TYPE_OFDM_INDEX)
-#define PHY_TYPE_BIT_HT         BIT(PHY_TYPE_HT_INDEX)
-#define PHY_TYPE_BIT_VHT        BIT(PHY_TYPE_VHT_INDEX)
-#define PHY_TYPE_BIT_HE         BIT(PHY_TYPE_HE_INDEX)
-
-#define MT_WTBL_RATE_TX_MODE	GENMASK(9, 6)
-#define MT_WTBL_RATE_MCS	GENMASK(5, 0)
-#define MT_WTBL_RATE_NSS	GENMASK(12, 10)
-#define MT_WTBL_RATE_HE_GI	GENMASK(7, 4)
-#define MT_WTBL_RATE_GI		GENMASK(3, 0)
-
 struct mt7921_mcu_tx_config {
 	u8 peer_addr[ETH_ALEN];
 	u8 sw;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index a6d5a000d9cc..96f205ffbbd1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -166,20 +166,6 @@ struct mt7921_dev {
 	u8 fw_debug;
 };
 
-enum {
-	HW_BSSID_0 = 0x0,
-	HW_BSSID_1,
-	HW_BSSID_2,
-	HW_BSSID_3,
-	HW_BSSID_MAX = HW_BSSID_3,
-	EXT_BSSID_START = 0x10,
-	EXT_BSSID_1,
-	EXT_BSSID_15 = 0x1f,
-	EXT_BSSID_MAX = EXT_BSSID_15,
-	REPEATER_BSSID_START = 0x20,
-	REPEATER_BSSID_MAX = 0x3f,
-};
-
 enum {
 	MT_LMAC_AC00,
 	MT_LMAC_AC01,
@@ -239,18 +225,12 @@ int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd);
 int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif);
 int mt7921_mcu_set_eeprom(struct mt7921_dev *dev);
 int mt7921_mcu_get_eeprom(struct mt7921_dev *dev, u32 offset);
-int mt7921_mcu_set_mac(struct mt7921_dev *dev, int band, bool enable,
-		       bool hdr_trans);
-int mt7921_mcu_set_rts_thresh(struct mt7921_phy *phy, u32 val);
+int mt7921_mcu_get_rx_rate(struct mt7921_phy *phy, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta, struct rate_info *rate);
 int mt7921_mcu_fw_log_2_host(struct mt7921_dev *dev, u8 ctrl);
 void mt7921_mcu_rx_event(struct mt7921_dev *dev, struct sk_buff *skb);
 void mt7921_mcu_exit(struct mt7921_dev *dev);
 
-static inline bool is_mt7921(struct mt76_dev *dev)
-{
-	return mt76_chip(dev) == 0x7961;
-}
-
 static inline void mt7921_irq_enable(struct mt7921_dev *dev, u32 mask)
 {
 	mt76_set_irq_mask(&dev->mt76, 0, 0, mask);
@@ -326,16 +306,7 @@ void mt7921_txp_skb_unmap(struct mt76_dev *dev,
 void mt7921_set_stream_he_caps(struct mt7921_phy *phy);
 void mt7921_update_channel(struct mt76_dev *mdev);
 int mt7921_init_debugfs(struct mt7921_dev *dev);
-int
-mt7921_mcu_uni_add_dev(struct mt7921_dev *dev,
-		       struct ieee80211_vif *vif, bool enable);
-int
-mt7921_mcu_uni_add_bss(struct mt7921_phy *phy, struct ieee80211_vif *vif,
-		       bool enable);
-
-int
-mt7921_mcu_uni_add_sta(struct mt7921_dev *dev, struct ieee80211_vif *vif,
-		       struct ieee80211_sta *sta, bool enable);
+
 int mt7921_mcu_uni_tx_ba(struct mt7921_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable);
@@ -343,7 +314,6 @@ int mt7921_mcu_uni_rx_ba(struct mt7921_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable);
 void mt7921_scan_work(struct work_struct *work);
-int mt7921_mcu_set_channel_domain(struct mt7921_phy *phy);
 int mt7921_mcu_hw_scan(struct mt7921_phy *phy, struct ieee80211_vif *vif,
 		       struct ieee80211_scan_request *scan_req);
 int mt7921_mcu_sched_scan_req(struct mt7921_phy *phy,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 202cde1b6289..613648a391a2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -9,6 +9,7 @@
 
 #include "mt7921.h"
 #include "mac.h"
+#include "mcu.h"
 #include "../trace.h"
 
 static const struct pci_device_id mt7921_pci_device_table[] = {
-- 
2.25.1

