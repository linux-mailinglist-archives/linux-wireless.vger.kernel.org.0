Return-Path: <linux-wireless+bounces-11539-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 041D1954635
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 11:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FCA21F226DE
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 09:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F4C176251;
	Fri, 16 Aug 2024 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UannrS8m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E75E171E49
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801828; cv=none; b=VhC0M4XN2TPOq7tzB9opl0GYXNvedGd+PjrHiiNnD3AgyhGEBEGcxq5ZsoVWO3trDst0NpSm5zgg5dRCzoSXltIhSzCfktWomc0FkosOOdw5FnxLBoFpgG+elVYbkQ6cXzV9NX0GGtKEYDljcoKGrxvCepy86Z7IC5adxTc0CmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801828; c=relaxed/simple;
	bh=r5Vqb3ec8Sm1BzgDzJEgZoiiZIzhuKJ7PwfjlSuRsew=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HyxMEGebT/ttu9VBOf2U609CAnwTRPi1cVqpQfEYyjLep7r/Cr4cVYzYyZAsswzl0Mwwn9CYgrIYjLAUD6E2ldfpwkcEBavJW0XBRe9GpQlylwYE5ZUy82MDZanHw9BDQVFQBvTYUQjW9QfKnrHPW7Bsx7bTnuKXp+7k7Ion9V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=UannrS8m; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ef7471ec5bb411ef8593d301e5c8a9c0-20240816
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ptRPaWl1szcKHuHfagd2krGpBPW8GYQu7WsNVr49tGU=;
	b=UannrS8masHA3SqvD1uYKBBVX9MogQkJtjicthAGnlvOzA3Y4ZzI9Dbh0eDpnaf0nLCBoGafaz7HEn1/NPCKtWTMJRMwSSkKWBGS48K5AiUbIsgbE9SrfW4hqPDz1TWmPQAgdAginGLS81GCdThztMsY0qyn3ucJ4pHdEb4I3IY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:03d75b50-f933-4ee5-a175-af1bd190e68d,IP:0,U
	RL:0,TC:0,Content:55,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:55
X-CID-META: VersionHash:6dc6a47,CLOUDID:6360b1fe-77bb-433c-b174-ffb8012693b0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:801|102,TC:nil,Content:4|8,EDM:-3,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ef7471ec5bb411ef8593d301e5c8a9c0-20240816
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 998693602; Fri, 16 Aug 2024 17:50:14 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Aug 2024 17:50:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 16 Aug 2024 17:50:15 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Howard Hsu
	<howard-yh.hsu@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 06/12] wifi: mt76: mt7996: fix HE and EHT beamforming capabilities
Date: Fri, 16 Aug 2024 17:46:29 +0800
Message-ID: <20240816094635.2391-5-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240816094635.2391-1-shayne.chen@mediatek.com>
References: <20240816094635.2391-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.682400-8.000000
X-TMASE-MatchedRID: ptJ0KTv/UXDPvAv72Y9dJfmF8IFnUmgvMZm0+sEE9mup+RClYacCxuLg
	gUiYkYyHa/XjyNax2z/bHihwcxI1hDI0UzRdrW2o4RtSDjG+z7CuiRuR9mCaupFghxqVuczoRtt
	YY7T3bpME1SjWqrnJaAaxDKyiq5EE9X41s3bshlbil2r2x2PwtX0tCKdnhB589yM15V5aWpj6C0
	ePs7A07fhmFHnZFzVqX/q4nAaH3d9FtN+OtStsdivB5Acdtotx5afv4NZF1Ed1aXxxoCpt4SWqf
	Vt6gRAMK6qLPEKJ3H8ZZTTAb7IQTdV9NPlsHF6RSZrfNhP3sgUBh9AgBSEFrJm+YJspVvj2xkvr
	HlT8euJ0YHKn7N1oOA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.682400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	F7DE47DD94AE57FBFADD57BFA68EF01070F16F67C46BD5D2956621662FB6C6082000:8
X-MTK: N

From: Howard Hsu <howard-yh.hsu@mediatek.com>

Fix HE and EHT beamforming capabilities for different bands and
interface types.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Fixes: 348533eb968d ("wifi: mt76: mt7996: add EHT capability init")
Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/init.c  | 65 ++++++++++++-------
 1 file changed, 43 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 4d6157e49b16..7e7e42b54c2e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -1012,8 +1012,6 @@ mt7996_set_stream_he_txbf_caps(struct mt7996_phy *phy,
 		return;
 
 	elem->phy_cap_info[3] |= IEEE80211_HE_PHY_CAP3_SU_BEAMFORMER;
-	if (vif == NL80211_IFTYPE_AP)
-		elem->phy_cap_info[4] |= IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER;
 
 	c = FIELD_PREP(IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK,
 		       sts - 1) |
@@ -1021,6 +1019,11 @@ mt7996_set_stream_he_txbf_caps(struct mt7996_phy *phy,
 		       sts - 1);
 	elem->phy_cap_info[5] |= c;
 
+	if (vif != NL80211_IFTYPE_AP)
+		return;
+
+	elem->phy_cap_info[4] |= IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER;
+
 	c = IEEE80211_HE_PHY_CAP6_TRIG_SU_BEAMFORMING_FB |
 	    IEEE80211_HE_PHY_CAP6_TRIG_MU_BEAMFORMING_PARTIAL_BW_FB;
 	elem->phy_cap_info[6] |= c;
@@ -1180,7 +1183,6 @@ mt7996_init_eht_caps(struct mt7996_phy *phy, enum nl80211_band band,
 		IEEE80211_EHT_MAC_CAP0_OM_CONTROL;
 
 	eht_cap_elem->phy_cap_info[0] =
-		IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ |
 		IEEE80211_EHT_PHY_CAP0_NDP_4_EHT_LFT_32_GI |
 		IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMER |
 		IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMEE;
@@ -1194,30 +1196,36 @@ mt7996_init_eht_caps(struct mt7996_phy *phy, enum nl80211_band band,
 		u8_encode_bits(u8_get_bits(val, GENMASK(2, 1)),
 			       IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_80MHZ_MASK) |
 		u8_encode_bits(val,
-			       IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_160MHZ_MASK) |
-		u8_encode_bits(val,
-			       IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_320MHZ_MASK);
+			       IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_160MHZ_MASK);
 
 	eht_cap_elem->phy_cap_info[2] =
 		u8_encode_bits(sts - 1, IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_80MHZ_MASK) |
-		u8_encode_bits(sts - 1, IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_160MHZ_MASK) |
-		u8_encode_bits(sts - 1, IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_320MHZ_MASK);
+		u8_encode_bits(sts - 1, IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_160MHZ_MASK);
+
+	if (band == NL80211_BAND_6GHZ) {
+		eht_cap_elem->phy_cap_info[0] |=
+			IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
+
+		eht_cap_elem->phy_cap_info[1] |=
+			u8_encode_bits(val,
+				       IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_320MHZ_MASK);
+
+		eht_cap_elem->phy_cap_info[2] |=
+			u8_encode_bits(sts - 1,
+				       IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_320MHZ_MASK);
+	}
 
 	eht_cap_elem->phy_cap_info[3] =
 		IEEE80211_EHT_PHY_CAP3_NG_16_SU_FEEDBACK |
 		IEEE80211_EHT_PHY_CAP3_NG_16_MU_FEEDBACK |
 		IEEE80211_EHT_PHY_CAP3_CODEBOOK_4_2_SU_FDBK |
-		IEEE80211_EHT_PHY_CAP3_CODEBOOK_7_5_MU_FDBK |
-		IEEE80211_EHT_PHY_CAP3_TRIG_SU_BF_FDBK |
-		IEEE80211_EHT_PHY_CAP3_TRIG_MU_BF_PART_BW_FDBK |
-		IEEE80211_EHT_PHY_CAP3_TRIG_CQI_FDBK;
+		IEEE80211_EHT_PHY_CAP3_CODEBOOK_7_5_MU_FDBK;
 
 	eht_cap_elem->phy_cap_info[4] =
 		u8_encode_bits(min_t(int, sts - 1, 2),
 			       IEEE80211_EHT_PHY_CAP4_MAX_NC_MASK);
 
 	eht_cap_elem->phy_cap_info[5] =
-		IEEE80211_EHT_PHY_CAP5_NON_TRIG_CQI_FEEDBACK |
 		u8_encode_bits(IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_16US,
 			       IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_MASK) |
 		u8_encode_bits(u8_get_bits(0x11, GENMASK(1, 0)),
@@ -1231,14 +1239,6 @@ mt7996_init_eht_caps(struct mt7996_phy *phy, enum nl80211_band band,
 			       IEEE80211_EHT_PHY_CAP6_MAX_NUM_SUPP_EHT_LTF_MASK) |
 		u8_encode_bits(val, IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_MASK);
 
-	eht_cap_elem->phy_cap_info[7] =
-		IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_80MHZ |
-		IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_160MHZ |
-		IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_320MHZ |
-		IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_80MHZ |
-		IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_160MHZ |
-		IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_320MHZ;
-
 	val = u8_encode_bits(nss, IEEE80211_EHT_MCS_NSS_RX) |
 	      u8_encode_bits(nss, IEEE80211_EHT_MCS_NSS_TX);
 #define SET_EHT_MAX_NSS(_bw, _val) do {				\
@@ -1249,8 +1249,29 @@ mt7996_init_eht_caps(struct mt7996_phy *phy, enum nl80211_band band,
 
 	SET_EHT_MAX_NSS(80, val);
 	SET_EHT_MAX_NSS(160, val);
-	SET_EHT_MAX_NSS(320, val);
+	if (band == NL80211_BAND_6GHZ)
+		SET_EHT_MAX_NSS(320, val);
 #undef SET_EHT_MAX_NSS
+
+	if (iftype != NL80211_IFTYPE_AP)
+		return;
+
+	eht_cap_elem->phy_cap_info[3] |=
+		IEEE80211_EHT_PHY_CAP3_TRIG_SU_BF_FDBK |
+		IEEE80211_EHT_PHY_CAP3_TRIG_MU_BF_PART_BW_FDBK;
+
+	eht_cap_elem->phy_cap_info[7] =
+		IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_80MHZ |
+		IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_160MHZ |
+		IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_80MHZ |
+		IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_160MHZ;
+
+	if (band != NL80211_BAND_6GHZ)
+		return;
+
+	eht_cap_elem->phy_cap_info[7] |=
+		IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_320MHZ |
+		IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_320MHZ;
 }
 
 static void
-- 
2.39.2


