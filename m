Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675593FE057
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Sep 2021 18:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344187AbhIAQvM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Sep 2021 12:51:12 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:59894 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1344186AbhIAQvK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Sep 2021 12:51:10 -0400
X-UUID: e708a893186f4f1caf4996cf4477f337-20210902
X-UUID: e708a893186f4f1caf4996cf4477f337-20210902
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 217353837; Thu, 02 Sep 2021 00:50:01 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 2 Sep 2021 00:50:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Sep 2021 00:50:00 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 3/5] mt76: mt7915: improve starec readability of txbf
Date:   Thu, 2 Sep 2021 00:49:46 +0800
Message-ID: <20210901164948.28149-3-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210901164948.28149-1-shayne.chen@mediatek.com>
References: <20210901164948.28149-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

1. Drop unnecessary MT_EBF/MT_IBF enum.
2. Rename fields 'nc'/'nr' to 'ncol'/'nrow'.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 81 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   | 13 +--
 2 files changed, 45 insertions(+), 49 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index acb76872f04c..ca3523101f3a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1792,7 +1792,6 @@ mt7915_is_ebf_supported(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 static void
 mt7915_mcu_sta_sounding_rate(struct sta_rec_bf *bf)
 {
-	bf->bf_cap = MT_EBF;
 	bf->sounding_phy = MT_PHY_TYPE_OFDM;
 	bf->ndp_rate = 0;				/* mcs0 */
 	bf->ndpa_rate = MT7915_CFEND_RATE_DEFAULT;	/* ofdm 24m */
@@ -1807,7 +1806,6 @@ mt7915_mcu_sta_bfer_ht(struct ieee80211_sta *sta, struct mt7915_phy *phy,
 	u8 n = 0;
 
 	bf->tx_mode = MT_PHY_TYPE_HT;
-	bf->bf_cap = MT_IBF;
 
 	if (mcs->tx_params & IEEE80211_HT_MCS_TX_RX_DIFF &&
 	    (mcs->tx_params & IEEE80211_HT_MCS_TX_DEFINED))
@@ -1820,8 +1818,8 @@ mt7915_mcu_sta_bfer_ht(struct ieee80211_sta *sta, struct mt7915_phy *phy,
 	else if (mcs->rx_mask[1])
 		n = 1;
 
-	bf->nr = hweight8(phy->mt76->chainmask) - 1;
-	bf->nc = min_t(u8, bf->nr, n);
+	bf->nrow = hweight8(phy->mt76->chainmask) - 1;
+	bf->ncol = min_t(u8, bf->nrow, n);
 	bf->ibf_ncol = n;
 }
 
@@ -1838,23 +1836,23 @@ mt7915_mcu_sta_bfer_vht(struct ieee80211_sta *sta, struct mt7915_phy *phy,
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
@@ -1872,21 +1870,23 @@ mt7915_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
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
@@ -1897,7 +1897,7 @@ mt7915_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 		mcs_map = le16_to_cpu(pc->he_mcs_nss_supp.rx_mcs_160);
 		nss_mcs = mt7915_mcu_get_sta_nss(mcs_map);
 
-		bf->nc_bw160 = nss_mcs;
+		bf->ncol_bw160 = nss_mcs;
 	}
 
 	if (pe->phy_cap_info[0] &
@@ -1905,18 +1905,18 @@ mt7915_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
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
@@ -1957,19 +1957,20 @@ mt7915_mcu_sta_bfer_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
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
@@ -1995,7 +1996,7 @@ mt7915_mcu_sta_bfee_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 	int tx_ant = hweight8(phy->mt76->chainmask) - 1;
 	struct sta_rec_bfee *bfee;
 	struct tlv *tlv;
-	u8 nr = 0;
+	u8 nrow = 0;
 
 	if (!mt7915_is_ebf_supported(phy, vif, sta, true))
 		return;
@@ -2006,17 +2007,17 @@ mt7915_mcu_sta_bfee_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
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
index 158c8e68c59e..d604a39f8413 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -967,8 +967,8 @@ struct sta_rec_bf {
 	u8 ndp_rate;
 	u8 rept_poll_rate;
 	u8 tx_mode;		/* 0: legacy, 1: OFDM, 2: HT, 4: VHT ... */
-	u8 nc;
-	u8 nr;
+	u8 ncol;
+	u8 nrow;
 	u8 bw;			/* 0: 20M, 1: 40M, 2: 80M, 3: 160M */
 
 	u8 mem_total;
@@ -988,8 +988,8 @@ struct sta_rec_bf {
 	u8 ibf_dbw;
 	u8 ibf_ncol;
 	u8 ibf_nrow;
-	u8 nr_bw160;
-	u8 nc_bw160;
+	u8 nrow_bw160;
+	u8 ncol_bw160;
 	u8 ru_start_idx;
 	u8 ru_end_idx;
 
@@ -1080,11 +1080,6 @@ enum {
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

