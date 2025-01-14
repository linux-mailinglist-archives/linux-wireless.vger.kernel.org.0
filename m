Return-Path: <linux-wireless+bounces-17481-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 665E2A103BB
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 11:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749FE160963
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 10:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC303DABE1;
	Tue, 14 Jan 2025 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="izbDv2hv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3301C1ADC60
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736849514; cv=none; b=GEw4oj6vIfiDb1+F27JsS9u8eBHgwnzz66vEICee2P/kTACrrF/7I9nIxvcONfoUDJ/li5g8KYxZ9YvyA0E3t4wzHWjiicaIMrZt9PIwld5eJtdpZKpYLaL4kYGdaFJ1iaN3UuhtgoF97A2u8oxLxHuHmW2XqL9wuDg7iazJ0bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736849514; c=relaxed/simple;
	bh=h/3Ew93JXZUg3gVV8C9FbOArKSLtDBUCf56cR9HN48I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HcDhi5zvYh57VNDB/zTEKCWAk1rccLN8wIkB0fJ13azq8Ij2sNPjH7zb/XhjibX2JhKoECuIlkF999xg7YD8M9UaPvc3eEjSt7tM3zrCerrbKLuNZotvHK0W2GboEShMDKD2Qk9U1yIL/cvj6Yj+zgMdBOlfd9lDiQSE212l2Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=izbDv2hv; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f3277894d25f11ef99858b75a2457dd9-20250114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qczM0H8UraUSIlLCqeBb4acolWXilcVYonuHlqAkn3s=;
	b=izbDv2hvIFpxd7tsMs1LID151ivmasC3hYDUjLPat/vjtUtWDoOMOELWv24k2ChQ4CG0VLxYimG0+XKxj0pGBbPKKf5EpI0y2Rz0zE3DqGkCOYt7CPeEJBs6u0OV77WMFvp+RnsuJciLvEH0BZlgDX1lNXT4t7sGcIdMo/kv8KU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:743a8935-0c0c-404d-b3ee-6b0a55919c99,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:c2d9de0e-078a-483b-8929-714244d25c49,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f3277894d25f11ef99858b75a2457dd9-20250114
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 479692792; Tue, 14 Jan 2025 18:11:41 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 14 Jan 2025 18:11:40 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Tue, 14 Jan 2025 18:11:40 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Howard Hsu
	<howard-yh.hsu@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 9/9] wifi: mt76: mt7996: add implicit beamforming support for mt7992
Date: Tue, 14 Jan 2025 18:10:26 +0800
Message-ID: <20250114101026.3587702-9-shayne.chen@mediatek.com>
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

The configuration of mt7992 iBF has some differences to mt7996, rework
related code to make it work.
Also, most of our chipsets support iBF only on HT and VHT mode, except
mt7992 variant that has 5T on 5GHz band also supports iBF on HE and EHT
mode.

Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 77 ++++++++++++-------
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  6 ++
 2 files changed, 55 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index dcca8b931237..e4569d032221 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1460,17 +1460,21 @@ mt7996_is_ebf_supported(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 }
 
 static void
-mt7996_mcu_sta_sounding_rate(struct sta_rec_bf *bf)
+mt7996_mcu_sta_sounding_rate(struct sta_rec_bf *bf, struct mt7996_phy *phy)
 {
 	bf->sounding_phy = MT_PHY_TYPE_OFDM;
 	bf->ndp_rate = 0;				/* mcs0 */
-	bf->ndpa_rate = MT7996_CFEND_RATE_DEFAULT;	/* ofdm 24m */
+	if (is_mt7996(phy->mt76->dev))
+		bf->ndpa_rate = MT7996_CFEND_RATE_DEFAULT;	/* ofdm 24m */
+	else
+		bf->ndpa_rate = MT7992_CFEND_RATE_DEFAULT;	/* ofdm 6m */
+
 	bf->rept_poll_rate = MT7996_CFEND_RATE_DEFAULT;	/* ofdm 24m */
 }
 
 static void
 mt7996_mcu_sta_bfer_ht(struct ieee80211_sta *sta, struct mt7996_phy *phy,
-		       struct sta_rec_bf *bf)
+		       struct sta_rec_bf *bf, bool explicit)
 {
 	struct ieee80211_mcs_info *mcs = &sta->deflink.ht_cap.mcs;
 	u8 n = 0;
@@ -1490,7 +1494,8 @@ mt7996_mcu_sta_bfer_ht(struct ieee80211_sta *sta, struct mt7996_phy *phy,
 
 	bf->nrow = hweight8(phy->mt76->antenna_mask) - 1;
 	bf->ncol = min_t(u8, bf->nrow, n);
-	bf->ibf_ncol = n;
+	bf->ibf_ncol = explicit ? min_t(u8, MT7996_IBF_MAX_NC, bf->ncol) :
+				  min_t(u8, MT7996_IBF_MAX_NC, n);
 }
 
 static void
@@ -1508,7 +1513,7 @@ mt7996_mcu_sta_bfer_vht(struct ieee80211_sta *sta, struct mt7996_phy *phy,
 	if (explicit) {
 		u8 sts, snd_dim;
 
-		mt7996_mcu_sta_sounding_rate(bf);
+		mt7996_mcu_sta_sounding_rate(bf, phy);
 
 		sts = FIELD_GET(IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK,
 				pc->cap);
@@ -1516,14 +1521,14 @@ mt7996_mcu_sta_bfer_vht(struct ieee80211_sta *sta, struct mt7996_phy *phy,
 				    vc->cap);
 		bf->nrow = min_t(u8, min_t(u8, snd_dim, sts), tx_ant);
 		bf->ncol = min_t(u8, nss_mcs, bf->nrow);
-		bf->ibf_ncol = bf->ncol;
+		bf->ibf_ncol = min_t(u8, MT7996_IBF_MAX_NC, bf->ncol);
 
 		if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_160)
 			bf->nrow = 1;
 	} else {
 		bf->nrow = tx_ant;
 		bf->ncol = min_t(u8, nss_mcs, bf->nrow);
-		bf->ibf_ncol = nss_mcs;
+		bf->ibf_ncol = min_t(u8, MT7996_IBF_MAX_NC, nss_mcs);
 
 		if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_160)
 			bf->ibf_nrow = 1;
@@ -1532,7 +1537,8 @@ mt7996_mcu_sta_bfer_vht(struct ieee80211_sta *sta, struct mt7996_phy *phy,
 
 static void
 mt7996_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
-		       struct mt7996_phy *phy, struct sta_rec_bf *bf)
+		       struct mt7996_phy *phy, struct sta_rec_bf *bf,
+		       bool explicit)
 {
 	struct ieee80211_sta_he_cap *pc = &sta->deflink.he_cap;
 	struct ieee80211_he_cap_elem *pe = &pc->he_cap_elem;
@@ -1548,7 +1554,7 @@ mt7996_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 
 	bf->tx_mode = MT_PHY_TYPE_HE_SU;
 
-	mt7996_mcu_sta_sounding_rate(bf);
+	mt7996_mcu_sta_sounding_rate(bf, phy);
 
 	bf->trigger_su = HE_PHY(CAP6_TRIG_SU_BEAMFORMING_FB,
 				pe->phy_cap_info[6]);
@@ -1560,7 +1566,8 @@ mt7996_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 		     pe->phy_cap_info[4]);
 	bf->nrow = min_t(u8, snd_dim, sts);
 	bf->ncol = min_t(u8, nss_mcs, bf->nrow);
-	bf->ibf_ncol = bf->ncol;
+	bf->ibf_ncol = explicit ? min_t(u8, MT7996_IBF_MAX_NC, bf->ncol) :
+				  min_t(u8, MT7996_IBF_MAX_NC, nss_mcs);
 
 	if (sta->deflink.bandwidth != IEEE80211_STA_RX_BW_160)
 		return;
@@ -1595,7 +1602,8 @@ mt7996_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 
 static void
 mt7996_mcu_sta_bfer_eht(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
-			struct mt7996_phy *phy, struct sta_rec_bf *bf)
+			struct mt7996_phy *phy, struct sta_rec_bf *bf,
+			bool explicit)
 {
 	struct ieee80211_sta_eht_cap *pc = &sta->deflink.eht_cap;
 	struct ieee80211_eht_cap_elem_fixed *pe = &pc->eht_cap_elem;
@@ -1609,7 +1617,7 @@ mt7996_mcu_sta_bfer_eht(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 
 	bf->tx_mode = MT_PHY_TYPE_EHT_MU;
 
-	mt7996_mcu_sta_sounding_rate(bf);
+	mt7996_mcu_sta_sounding_rate(bf, phy);
 
 	bf->trigger_su = EHT_PHY(CAP3_TRIG_SU_BF_FDBK, pe->phy_cap_info[3]);
 	bf->trigger_mu = EHT_PHY(CAP3_TRIG_MU_BF_PART_BW_FDBK, pe->phy_cap_info[3]);
@@ -1618,7 +1626,8 @@ mt7996_mcu_sta_bfer_eht(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 	      (EHT_PHY(CAP1_BEAMFORMEE_SS_80MHZ_MASK, pe->phy_cap_info[1]) << 1);
 	bf->nrow = min_t(u8, snd_dim, sts);
 	bf->ncol = min_t(u8, nss_mcs, bf->nrow);
-	bf->ibf_ncol = bf->ncol;
+	bf->ibf_ncol = explicit ? min_t(u8, MT7996_IBF_MAX_NC, bf->ncol) :
+				  min_t(u8, MT7996_IBF_MAX_NC, nss_mcs);
 
 	if (sta->deflink.bandwidth < IEEE80211_STA_RX_BW_160)
 		return;
@@ -1653,12 +1662,15 @@ static void
 mt7996_mcu_sta_bfer_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 			struct ieee80211_vif *vif, struct ieee80211_sta *sta)
 {
+#define EBF_MODE	BIT(0)
+#define IBF_MODE	BIT(1)
+#define BF_MAT_ORDER	4
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_phy *phy = mvif->deflink.phy;
 	int tx_ant = hweight16(phy->mt76->chainmask) - 1;
 	struct sta_rec_bf *bf;
 	struct tlv *tlv;
-	static const u8 matrix[4][4] = {
+	static const u8 matrix[BF_MAT_ORDER][BF_MAT_ORDER] = {
 		{0, 0, 0, 0},
 		{1, 1, 0, 0},	/* 2x1, 2x2, 2x3, 2x4 */
 		{2, 4, 4, 0},	/* 3x1, 3x2, 3x3, 3x4 */
@@ -1676,35 +1688,44 @@ mt7996_mcu_sta_bfer_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_BF, sizeof(*bf));
 	bf = (struct sta_rec_bf *)tlv;
 
-	/* he/eht: eBF only, in accordance with spec
+	/* he/eht: eBF only, except mt7992 that has 5T on 5GHz also supports iBF
 	 * vht: support eBF and iBF
 	 * ht: iBF only, since mac80211 lacks of eBF support
 	 */
-	if (sta->deflink.eht_cap.has_eht && ebf)
-		mt7996_mcu_sta_bfer_eht(sta, vif, phy, bf);
-	else if (sta->deflink.he_cap.has_he && ebf)
-		mt7996_mcu_sta_bfer_he(sta, vif, phy, bf);
+	if (sta->deflink.eht_cap.has_eht)
+		mt7996_mcu_sta_bfer_eht(sta, vif, phy, bf, ebf);
+	else if (sta->deflink.he_cap.has_he)
+		mt7996_mcu_sta_bfer_he(sta, vif, phy, bf, ebf);
 	else if (sta->deflink.vht_cap.vht_supported)
 		mt7996_mcu_sta_bfer_vht(sta, phy, bf, ebf);
 	else if (sta->deflink.ht_cap.ht_supported)
-		mt7996_mcu_sta_bfer_ht(sta, phy, bf);
+		mt7996_mcu_sta_bfer_ht(sta, phy, bf, ebf);
 	else
 		return;
 
-	bf->bf_cap = ebf ? ebf : dev->ibf << 1;
+	bf->bf_cap = ebf ? EBF_MODE : (dev->ibf ? IBF_MODE : 0);
+	if (is_mt7992(&dev->mt76) && tx_ant == 4)
+		bf->bf_cap |= IBF_MODE;
 	bf->bw = sta->deflink.bandwidth;
 	bf->ibf_dbw = sta->deflink.bandwidth;
 	bf->ibf_nrow = tx_ant;
 
-	if (!ebf && sta->deflink.bandwidth <= IEEE80211_STA_RX_BW_40 && !bf->ncol)
-		bf->ibf_timeout = 0x48;
+	if (sta->deflink.eht_cap.has_eht || sta->deflink.he_cap.has_he)
+		bf->ibf_timeout = is_mt7996(&dev->mt76) ? MT7996_IBF_TIMEOUT :
+							  MT7992_IBF_TIMEOUT;
+	else if (!ebf && sta->deflink.bandwidth <= IEEE80211_STA_RX_BW_40 && !bf->ncol)
+		bf->ibf_timeout = MT7996_IBF_TIMEOUT_LEGACY;
 	else
-		bf->ibf_timeout = 0x18;
+		bf->ibf_timeout = MT7996_IBF_TIMEOUT;
 
-	if (ebf && bf->nrow != tx_ant)
-		bf->mem_20m = matrix[tx_ant][bf->ncol];
-	else
-		bf->mem_20m = matrix[bf->nrow][bf->ncol];
+	if (bf->ncol < BF_MAT_ORDER) {
+		if (ebf)
+			bf->mem_20m = tx_ant < BF_MAT_ORDER ?
+				      matrix[tx_ant][bf->ncol] : 0;
+		else
+			bf->mem_20m = bf->nrow < BF_MAT_ORDER ?
+				      matrix[bf->nrow][bf->ncol] : 0;
+	}
 
 	switch (sta->deflink.bandwidth) {
 	case IEEE80211_STA_RX_BW_160:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 1cfcac51a338..29fabb9b04ae 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -68,6 +68,12 @@
 
 #define MT7996_CFEND_RATE_DEFAULT	0x49	/* OFDM 24M */
 #define MT7996_CFEND_RATE_11B		0x03	/* 11B LP, 11M */
+#define MT7996_IBF_MAX_NC		2
+#define MT7996_IBF_TIMEOUT		0x18
+#define MT7996_IBF_TIMEOUT_LEGACY	0x48
+
+#define MT7992_CFEND_RATE_DEFAULT	0x4b	/* OFDM 6M */
+#define MT7992_IBF_TIMEOUT		0xff
 
 #define MT7996_SKU_RATE_NUM		417
 #define MT7996_SKU_PATH_NUM		494
-- 
2.39.2


