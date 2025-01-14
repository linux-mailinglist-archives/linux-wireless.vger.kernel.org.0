Return-Path: <linux-wireless+bounces-17480-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB24BA103BA
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 11:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2306166BCA
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 10:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5726028EC94;
	Tue, 14 Jan 2025 10:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pwWYRjFq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460DF246339
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736849513; cv=none; b=i/rK5NE7HmE9pkoXcNCZ2TI/2bQtUVwb1rI8Lv9K3w6VM/VMYyS/aR4+kPW7810IiJqr2WS1Hqh8stG9uqAEH22KZ2cuCsrxVo4W6j5elzJC+FU4wrpNlWPTh9/HVI1V1b0bCt5KnnsCQMKc0cnY0J5AKH1XDopX73vyt43CPCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736849513; c=relaxed/simple;
	bh=0razGN8IN1vXcnszPksT6Ad5rRNLWa7eUDGJWaCMgxY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmVDEfD21CPDPrro0OvyJsQfl1GUuGa8Efz3y1p92M6XRxe2J7BGrw0ysJVD4nQyc8rOBiU4mSxBAy8nmsIa3YTa+mU5q3uwI3Au2QvrqaULsctlMnAOi3/1FCw3ETI7qSHJrDk3W6E6qFlS5mrvx6FCm0u9TIHXS4uz5izet90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pwWYRjFq; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f30105a6d25f11ef99858b75a2457dd9-20250114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=WAV1XbuhLVFiYt5pt/SjrZXpqawzctvjLfpn7BESLGQ=;
	b=pwWYRjFq5tQRf5A9lggiO49t5/yEHvZ0uwrbG1yngDJRCOHXThUNfi/9zvXd7rTgmBn2QZoTnIdQKRXkE82teMH+sN+8MSFz+1d12WwSsZ+tN41BM5YNFF8k4mRIVpdB/9b08jTHh3hInNbNnUULKqKY+ReURKe5rLc5QWPzNmM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:1a52f1a8-1e23-4573-a403-173bdd7a779f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:c3d9de0e-078a-483b-8929-714244d25c49,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f30105a6d25f11ef99858b75a2457dd9-20250114
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 772880856; Tue, 14 Jan 2025 18:11:41 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 14 Jan 2025 18:11:39 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Tue, 14 Jan 2025 18:11:39 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Howard Hsu
	<howard-yh.hsu@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 5/9] wifi: mt76: connac: adjust phy capabilities based on band constraints
Date: Tue, 14 Jan 2025 18:10:22 +0800
Message-ID: <20250114101026.3587702-5-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250114101026.3587702-1-shayne.chen@mediatek.com>
References: <20250114101026.3587702-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Howard Hsu <howard-yh.hsu@mediatek.com>

Adjust HE and EHT phy capabilities based on the band constraints.
For 2g band, we shall not enable the capabilities above 40MHz.

Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  2 +-
 .../wireless/mediatek/mt76/mt76_connac_mac.c  |  7 ++-
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7996/init.c  | 47 +++++++++++++------
 6 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index f7766a9815fe..455979476d11 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -405,7 +405,7 @@ mt76_connac_mutex_release(struct mt76_dev *dev, struct mt76_connac_pm *pm)
 	mutex_unlock(&dev->mutex);
 }
 
-void mt76_connac_gen_ppe_thresh(u8 *he_ppet, int nss);
+void mt76_connac_gen_ppe_thresh(u8 *he_ppet, int nss, enum nl80211_band band);
 int mt76_connac_init_tx_queues(struct mt76_phy *phy, int idx, int n_desc,
 			       int ring_base, void *wed, u32 flags);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 6d30f4fc3526..e9ac8a7317a1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -9,10 +9,13 @@
 #define HE_PREP(f, m, v)	le16_encode_bits(le32_get_bits(v, MT_CRXV_HE_##m),\
 						 IEEE80211_RADIOTAP_HE_##f)
 
-void mt76_connac_gen_ppe_thresh(u8 *he_ppet, int nss)
+void mt76_connac_gen_ppe_thresh(u8 *he_ppet, int nss, enum nl80211_band band)
 {
 	static const u8 ppet16_ppet8_ru3_ru0[] = { 0x1c, 0xc7, 0x71 };
-	u8 i, ppet_bits, ppet_size, ru_bit_mask = 0x7; /* HE80 */
+	u8 i, ppet_bits, ppet_size, ru_bit_mask = 0xf;
+
+	if (band == NL80211_BAND_2GHZ)
+		ru_bit_mask = 0x3;
 
 	he_ppet[0] = FIELD_PREP(IEEE80211_PPE_THRES_NSS_MASK, nss - 1) |
 		     FIELD_PREP(IEEE80211_PPE_THRES_RU_INDEX_BITMASK_MASK,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index c530435b19b5..bee4beabc4eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -1126,7 +1126,7 @@ mt7915_init_he_caps(struct mt7915_phy *phy, enum nl80211_band band,
 		memset(he_cap->ppe_thres, 0, sizeof(he_cap->ppe_thres));
 		if (he_cap_elem->phy_cap_info[6] &
 		    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
-			mt76_connac_gen_ppe_thresh(he_cap->ppe_thres, nss);
+			mt76_connac_gen_ppe_thresh(he_cap->ppe_thres, nss, band);
 		} else {
 			he_cap_elem->phy_cap_info[9] |=
 				u8_encode_bits(IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index fccefda3bdb5..13e58c328aff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -147,7 +147,7 @@ mt7921_init_he_caps(struct mt792x_phy *phy, enum nl80211_band band,
 		memset(he_cap->ppe_thres, 0, sizeof(he_cap->ppe_thres));
 		if (he_cap_elem->phy_cap_info[6] &
 		    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
-			mt76_connac_gen_ppe_thresh(he_cap->ppe_thres, nss);
+			mt76_connac_gen_ppe_thresh(he_cap->ppe_thres, nss, band);
 		} else {
 			he_cap_elem->phy_cap_info[9] |=
 				u8_encode_bits(IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 7b93e8fb28ef..328e3e0e2986 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -130,7 +130,7 @@ mt7925_init_he_caps(struct mt792x_phy *phy, enum nl80211_band band,
 
 	if (he_cap_elem->phy_cap_info[6] &
 	    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
-		mt76_connac_gen_ppe_thresh(he_cap->ppe_thres, nss);
+		mt76_connac_gen_ppe_thresh(he_cap->ppe_thres, nss, band);
 	} else {
 		he_cap_elem->phy_cap_info[9] |=
 			u8_encode_bits(IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index f93f6e30c784..9e699c0d296d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -1083,10 +1083,12 @@ void mt7996_set_stream_vht_txbf_caps(struct mt7996_phy *phy)
 
 static void
 mt7996_set_stream_he_txbf_caps(struct mt7996_phy *phy,
-			       struct ieee80211_sta_he_cap *he_cap, int vif)
+			       struct ieee80211_sta_he_cap *he_cap, int vif,
+			       enum nl80211_band band)
 {
 	struct ieee80211_he_cap_elem *elem = &he_cap->he_cap_elem;
 	int sts = hweight16(phy->mt76->chainmask);
+	bool non_2g = band != NL80211_BAND_2GHZ;
 	u8 c;
 
 #ifdef CONFIG_MAC80211_MESH
@@ -1116,10 +1118,10 @@ mt7996_set_stream_he_txbf_caps(struct mt7996_phy *phy,
 
 	if (is_mt7996(phy->mt76->dev))
 		c |= IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_4 |
-		     IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_4;
+		     (IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_4 * non_2g);
 	else
 		c |= IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_5 |
-		     IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_5;
+		     (IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_5 * non_2g);
 
 	elem->phy_cap_info[4] |= c;
 
@@ -1145,8 +1147,9 @@ mt7996_set_stream_he_txbf_caps(struct mt7996_phy *phy,
 
 	c = FIELD_PREP(IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK,
 		       sts - 1) |
-	    FIELD_PREP(IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_MASK,
-		       sts - 1);
+	    (FIELD_PREP(IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_MASK,
+			sts - 1) * non_2g);
+
 	elem->phy_cap_info[5] |= c;
 
 	if (vif != NL80211_IFTYPE_AP)
@@ -1158,8 +1161,10 @@ mt7996_set_stream_he_txbf_caps(struct mt7996_phy *phy,
 	    IEEE80211_HE_PHY_CAP6_TRIG_MU_BEAMFORMING_PARTIAL_BW_FB;
 	elem->phy_cap_info[6] |= c;
 
-	c = IEEE80211_HE_PHY_CAP7_STBC_TX_ABOVE_80MHZ |
-	    IEEE80211_HE_PHY_CAP7_STBC_RX_ABOVE_80MHZ;
+	c = 0;
+	if (non_2g)
+		c |= IEEE80211_HE_PHY_CAP7_STBC_TX_ABOVE_80MHZ |
+		     IEEE80211_HE_PHY_CAP7_STBC_RX_ABOVE_80MHZ;
 	elem->phy_cap_info[7] |= c;
 }
 
@@ -1265,12 +1270,12 @@ mt7996_init_he_caps(struct mt7996_phy *phy, enum nl80211_band band,
 	he_mcs->rx_mcs_160 = cpu_to_le16(mcs_map);
 	he_mcs->tx_mcs_160 = cpu_to_le16(mcs_map);
 
-	mt7996_set_stream_he_txbf_caps(phy, he_cap, iftype);
+	mt7996_set_stream_he_txbf_caps(phy, he_cap, iftype, band);
 
 	memset(he_cap->ppe_thres, 0, sizeof(he_cap->ppe_thres));
 	if (he_cap_elem->phy_cap_info[6] &
 	    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
-		mt76_connac_gen_ppe_thresh(he_cap->ppe_thres, nss);
+		mt76_connac_gen_ppe_thresh(he_cap->ppe_thres, nss, band);
 	} else {
 		he_cap_elem->phy_cap_info[9] |=
 			u8_encode_bits(IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US,
@@ -1329,13 +1334,20 @@ mt7996_init_eht_caps(struct mt7996_phy *phy, enum nl80211_band band,
 
 	eht_cap_elem->phy_cap_info[1] =
 		u8_encode_bits(u8_get_bits(val, GENMASK(2, 1)),
-			       IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_80MHZ_MASK) |
-		u8_encode_bits(val,
-			       IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_160MHZ_MASK);
+			       IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_80MHZ_MASK);
 
 	eht_cap_elem->phy_cap_info[2] =
-		u8_encode_bits(sts - 1, IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_80MHZ_MASK) |
-		u8_encode_bits(sts - 1, IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_160MHZ_MASK);
+		u8_encode_bits(sts - 1, IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_80MHZ_MASK);
+
+	if (band != NL80211_BAND_2GHZ) {
+		eht_cap_elem->phy_cap_info[1] |=
+			u8_encode_bits(val,
+				       IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_160MHZ_MASK);
+
+		eht_cap_elem->phy_cap_info[2] |=
+			u8_encode_bits(sts - 1,
+				       IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_160MHZ_MASK);
+	}
 
 	if (band == NL80211_BAND_6GHZ) {
 		eht_cap_elem->phy_cap_info[0] |=
@@ -1396,8 +1408,13 @@ mt7996_init_eht_caps(struct mt7996_phy *phy, enum nl80211_band band,
 
 	eht_cap_elem->phy_cap_info[7] =
 		IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_80MHZ |
+		IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_80MHZ;
+
+	if (band == NL80211_BAND_2GHZ)
+		return;
+
+	eht_cap_elem->phy_cap_info[7] |=
 		IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_160MHZ |
-		IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_80MHZ |
 		IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_160MHZ;
 
 	if (band != NL80211_BAND_6GHZ)
-- 
2.39.2


