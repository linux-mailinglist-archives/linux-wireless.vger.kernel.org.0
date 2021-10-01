Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A3C41EA24
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 11:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353246AbhJAJzv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Oct 2021 05:55:51 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34224 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1353173AbhJAJzt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Oct 2021 05:55:49 -0400
X-UUID: c6edd676cdb54b04a7a62bc86693de9b-20211001
X-UUID: c6edd676cdb54b04a7a62bc86693de9b-20211001
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 359507207; Fri, 01 Oct 2021 17:54:02 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 1 Oct 2021 17:54:01 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 1 Oct
 2021 17:54:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 1 Oct 2021 17:54:00 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v5 3/8] mt76: mt7915: improve starec readability of txbf
Date:   Fri, 1 Oct 2021 17:53:50 +0800
Message-ID: <20211001095355.10598-3-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211001095355.10598-1-shayne.chen@mediatek.com>
References: <20211001095355.10598-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

1. Drop unnecessary MT_EBF/MT_IBF enum.
2. Rename fields 'nc'/'nr' to 'ncol'/'nrow'.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 81 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   | 13 +--
 2 files changed, 45 insertions(+), 49 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index a6ecdf4ce4c3..6c1f1674feb5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1810,7 +1810,6 @@ mt7915_is_ebf_supported(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 static void
 mt7915_mcu_sta_sounding_rate(struct sta_rec_bf *bf)
 {
-	bf->bf_cap = MT_EBF;
 	bf->sounding_phy = MT_PHY_TYPE_OFDM;
 	bf->ndp_rate = 0;				/* mcs0 */
 	bf->ndpa_rate = MT7915_CFEND_RATE_DEFAULT;	/* ofdm 24m */
@@ -1825,7 +1824,6 @@ mt7915_mcu_sta_bfer_ht(struct ieee80211_sta *sta, struct mt7915_phy *phy,
 	u8 n = 0;
 
 	bf->tx_mode = MT_PHY_TYPE_HT;
-	bf->bf_cap = MT_IBF;
 
 	if ((mcs->tx_params & IEEE80211_HT_MCS_TX_RX_DIFF) &&
 	    (mcs->tx_params & IEEE80211_HT_MCS_TX_DEFINED))
@@ -1838,8 +1836,8 @@ mt7915_mcu_sta_bfer_ht(struct ieee80211_sta *sta, struct mt7915_phy *phy,
 	else if (mcs->rx_mask[1])
 		n = 1;
 
-	bf->nr = hweight8(phy->mt76->chainmask) - 1;
-	bf->nc = min_t(u8, bf->nr, n);
+	bf->nrow = hweight8(phy->mt76->chainmask) - 1;
+	bf->ncol = min_t(u8, bf->nrow, n);
 	bf->ibf_ncol = n;
 }
 
@@ -1856,23 +1854,23 @@ mt7915_mcu_sta_bfer_vht(struct ieee80211_sta *sta, struct mt7915_phy *phy,
 	bf->tx_mode = MT_PHY_TYPE_VHT;
 
 	if (explicit) {
-		u8 bfee_nr, bfer_nr;
+		u8 sts, snd_dim;
 
 		mt7915_mcu_sta_sounding_rate(bf);
-		bfee_nr = FIELD_GET(IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK,
-				    pc->cap);
-		bfer_nr = FIELD_GET(IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK,
+
+		sts = FIELD_GET(IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK,
+				pc->cap);
+		snd_dim = FIELD_GET(IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK,
 				    vc->cap);
-		bf->nr = min_t(u8, min_t(u8, bfer_nr, bfee_nr), tx_ant);
-		bf->nc = min_t(u8, nss_mcs, bf->nr);
-		bf->ibf_ncol = bf->nc;
+		bf->nrow = min_t(u8, min_t(u8, snd_dim, sts), tx_ant);
+		bf->ncol = min_t(u8, nss_mcs, bf->nrow);
+		bf->ibf_ncol = bf->ncol;
 
 		if (sta->bandwidth == IEEE80211_STA_RX_BW_160)
-			bf->nr = 1;
+			bf->nrow = 1;
 	} else {
-		bf->bf_cap = MT_IBF;
-		bf->nr = tx_ant;
-		bf->nc = min_t(u8, nss_mcs, bf->nr);
+		bf->nrow = tx_ant;
+		bf->ncol = min_t(u8, nss_mcs, bf->nrow);
 		bf->ibf_ncol = nss_mcs;
 
 		if (sta->bandwidth == IEEE80211_STA_RX_BW_160)
@@ -1890,21 +1888,23 @@ mt7915_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 	const struct ieee80211_he_cap_elem *ve = &vc->he_cap_elem;
 	u16 mcs_map = le16_to_cpu(pc->he_mcs_nss_supp.rx_mcs_80);
 	u8 nss_mcs = mt7915_mcu_get_sta_nss(mcs_map);
-	u8 bfee_nr, bfer_nr;
+	u8 snd_dim, sts;
 
 	bf->tx_mode = MT_PHY_TYPE_HE_SU;
+
 	mt7915_mcu_sta_sounding_rate(bf);
+
 	bf->trigger_su = HE_PHY(CAP6_TRIG_SU_BEAMFORMING_FB,
 				pe->phy_cap_info[6]);
 	bf->trigger_mu = HE_PHY(CAP6_TRIG_MU_BEAMFORMING_PARTIAL_BW_FB,
 				pe->phy_cap_info[6]);
-	bfer_nr = HE_PHY(CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK,
+	snd_dim = HE_PHY(CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK,
 			 ve->phy_cap_info[5]);
-	bfee_nr = HE_PHY(CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_MASK,
-			 pe->phy_cap_info[4]);
-	bf->nr = min_t(u8, bfer_nr, bfee_nr);
-	bf->nc = min_t(u8, nss_mcs, bf->nr);
-	bf->ibf_ncol = bf->nc;
+	sts = HE_PHY(CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_MASK,
+		     pe->phy_cap_info[4]);
+	bf->nrow = min_t(u8, snd_dim, sts);
+	bf->ncol = min_t(u8, nss_mcs, bf->nrow);
+	bf->ibf_ncol = bf->ncol;
 
 	if (sta->bandwidth != IEEE80211_STA_RX_BW_160)
 		return;
@@ -1915,7 +1915,7 @@ mt7915_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 		mcs_map = le16_to_cpu(pc->he_mcs_nss_supp.rx_mcs_160);
 		nss_mcs = mt7915_mcu_get_sta_nss(mcs_map);
 
-		bf->nc_bw160 = nss_mcs;
+		bf->ncol_bw160 = nss_mcs;
 	}
 
 	if (pe->phy_cap_info[0] &
@@ -1923,18 +1923,18 @@ mt7915_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 		mcs_map = le16_to_cpu(pc->he_mcs_nss_supp.rx_mcs_80p80);
 		nss_mcs = mt7915_mcu_get_sta_nss(mcs_map);
 
-		if (bf->nc_bw160)
-			bf->nc_bw160 = min_t(u8, bf->nc_bw160, nss_mcs);
+		if (bf->ncol_bw160)
+			bf->ncol_bw160 = min_t(u8, bf->ncol_bw160, nss_mcs);
 		else
-			bf->nc_bw160 = nss_mcs;
+			bf->ncol_bw160 = nss_mcs;
 	}
 
-	bfer_nr = HE_PHY(CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_MASK,
+	snd_dim = HE_PHY(CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_MASK,
 			 ve->phy_cap_info[5]);
-	bfee_nr = HE_PHY(CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_MASK,
-			 pe->phy_cap_info[4]);
+	sts = HE_PHY(CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_MASK,
+		     pe->phy_cap_info[4]);
 
-	bf->nr_bw160 = min_t(int, bfer_nr, bfee_nr);
+	bf->nrow_bw160 = min_t(int, snd_dim, sts);
 }
 
 static void
@@ -1975,19 +1975,20 @@ mt7915_mcu_sta_bfer_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 	else
 		return;
 
+	bf->bf_cap = ebf ? ebf : dev->ibf << 1;
 	bf->bw = sta->bandwidth;
 	bf->ibf_dbw = sta->bandwidth;
 	bf->ibf_nrow = tx_ant;
 
-	if (!ebf && sta->bandwidth <= IEEE80211_STA_RX_BW_40 && !bf->nc)
+	if (!ebf && sta->bandwidth <= IEEE80211_STA_RX_BW_40 && !bf->ncol)
 		bf->ibf_timeout = 0x48;
 	else
 		bf->ibf_timeout = 0x18;
 
-	if (ebf && bf->nr != tx_ant)
-		bf->mem_20m = matrix[tx_ant][bf->nc];
+	if (ebf && bf->nrow != tx_ant)
+		bf->mem_20m = matrix[tx_ant][bf->ncol];
 	else
-		bf->mem_20m = matrix[bf->nr][bf->nc];
+		bf->mem_20m = matrix[bf->nrow][bf->ncol];
 
 	switch (sta->bandwidth) {
 	case IEEE80211_STA_RX_BW_160:
@@ -2013,7 +2014,7 @@ mt7915_mcu_sta_bfee_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 	int tx_ant = hweight8(phy->mt76->chainmask) - 1;
 	struct sta_rec_bfee *bfee;
 	struct tlv *tlv;
-	u8 nr = 0;
+	u8 nrow = 0;
 
 	if (!mt7915_is_ebf_supported(phy, vif, sta, true))
 		return;
@@ -2024,17 +2025,17 @@ mt7915_mcu_sta_bfee_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 	if (sta->he_cap.has_he) {
 		struct ieee80211_he_cap_elem *pe = &sta->he_cap.he_cap_elem;
 
-		nr = HE_PHY(CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK,
-			    pe->phy_cap_info[5]);
+		nrow = HE_PHY(CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK,
+			      pe->phy_cap_info[5]);
 	} else if (sta->vht_cap.vht_supported) {
 		struct ieee80211_sta_vht_cap *pc = &sta->vht_cap;
 
-		nr = FIELD_GET(IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK,
-			       pc->cap);
+		nrow = FIELD_GET(IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK,
+				 pc->cap);
 	}
 
 	/* reply with identity matrix to avoid 2x2 BF negative gain */
-	bfee->fb_identity_matrix = !!(nr == 1 && tx_ant == 2);
+	bfee->fb_identity_matrix = (nrow == 1 && tx_ant == 2);
 }
 
 static int
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 374d44f71522..9cda7c3b47a7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -972,8 +972,8 @@ struct sta_rec_bf {
 	u8 ndp_rate;
 	u8 rept_poll_rate;
 	u8 tx_mode;		/* 0: legacy, 1: OFDM, 2: HT, 4: VHT ... */
-	u8 nc;
-	u8 nr;
+	u8 ncol;
+	u8 nrow;
 	u8 bw;			/* 0: 20M, 1: 40M, 2: 80M, 3: 160M */
 
 	u8 mem_total;
@@ -993,8 +993,8 @@ struct sta_rec_bf {
 	u8 ibf_dbw;
 	u8 ibf_ncol;
 	u8 ibf_nrow;
-	u8 nr_bw160;
-	u8 nc_bw160;
+	u8 nrow_bw160;
+	u8 ncol_bw160;
 	u8 ru_start_idx;
 	u8 ru_end_idx;
 
@@ -1085,11 +1085,6 @@ enum {
 	THERMAL_PROTECT_STATE_ACT,
 };
 
-enum {
-	MT_EBF = BIT(0),	/* explicit beamforming */
-	MT_IBF = BIT(1)		/* implicit beamforming */
-};
-
 enum {
 	MT_BF_SOUNDING_ON = 1,
 	MT_BF_TYPE_UPDATE = 20,
-- 
2.25.1

