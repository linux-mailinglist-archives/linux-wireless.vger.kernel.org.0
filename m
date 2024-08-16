Return-Path: <linux-wireless+bounces-11537-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F74F954633
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 11:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89BF51C22D68
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 09:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C6117622D;
	Fri, 16 Aug 2024 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="l10yip0c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A00E171E40
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801828; cv=none; b=VmAs52EOZI7o69BaDpWdOSZCnYcnxlEVkeYrgl83FdVRja87QTT9TZ7ivy5S+yg+AyCvpEuI9GVqXE9ehTwa1u/6enTz7pZv8cNgC8Qddo6XpKWsKp4zXYHEoex1nOxaeyTSYA6GNS3pOBKwIJGgqkSWCZXm8Q6ZFYxBoOz2auw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801828; c=relaxed/simple;
	bh=5vbEUQ0e6wU9yVJrBMhSgNjD50zYhsruKdfpe73Q7jA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aduZEgF22U+94NPkm1RzrBHiCuTdjm2QLpHZeNDMlxl0YCTF4aQIwTtOBHesv/qING0alV7SgT8TgKVHXFlxj/tuZDSJJMfeJGM6kVjWRy1zYx+W6TkAipBJshEdM/MOFg8tC8gDTgTSBypsKLRz4PUauJwGbfZwA8Pu8b301uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=l10yip0c; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: eee221525bb411ef8593d301e5c8a9c0-20240816
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=24jn+2XjF5n77zOBbC+cxREac59bDjesd7lQidAAOVI=;
	b=l10yip0cehYerwrvZ44LdvIAoJCOG7twyFa1/iUimXvULgvH6vHIVtZ3rEBBd4u7cqone3Yo7r16y/Y6V/Ko/KkVgIW5eK8qUU7NlxLzSOTBJFESc2X92HInP0nHsZFum7pD9RiSC3CqfxuHvTpEaYTKDmUqbHfV5XGVAO2UNFw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:2e8f6d2a-3aae-4a00-bd4f-6540beb48349,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:20ad403f-6019-4002-9080-12f7f4711092,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: eee221525bb411ef8593d301e5c8a9c0-20240816
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 110793387; Fri, 16 Aug 2024 17:50:13 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Aug 2024 02:50:15 -0700
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
Subject: [PATCH 07/12] wifi: mt76: mt7996: set correct beamformee SS capability
Date: Fri, 16 Aug 2024 17:46:30 +0800
Message-ID: <20240816094635.2391-6-shayne.chen@mediatek.com>
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
X-MTK: N

From: Howard Hsu <howard-yh.hsu@mediatek.com>

According to IEEE P802.11be/D6.0 Table 9-417n, beamformee SS field stands
for the maximum number of spatial streams that the STA can receive in an
EHT sounding NDP minus 1, and the minimum value of this field is 3.

This value indicates the decoding capability of a beamformee, which is
independent of current antenna settings. Correct the value for mt7996
and mt7992 chipsets based on their HW capability.

Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/init.c  | 23 ++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 7e7e42b54c2e..5e96973226bb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -942,8 +942,12 @@ void mt7996_set_stream_vht_txbf_caps(struct mt7996_phy *phy)
 	cap = &phy->mt76->sband_5g.sband.vht_cap.cap;
 
 	*cap |= IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
-		IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE |
-		FIELD_PREP(IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK, sts - 1);
+		IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE;
+
+	if (is_mt7996(phy->mt76->dev))
+		*cap |= FIELD_PREP(IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK, 3);
+	else
+		*cap |= FIELD_PREP(IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK, 4);
 
 	*cap &= ~(IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK |
 		  IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE |
@@ -988,9 +992,15 @@ mt7996_set_stream_he_txbf_caps(struct mt7996_phy *phy,
 	    IEEE80211_HE_PHY_CAP2_UL_MU_PARTIAL_MU_MIMO;
 	elem->phy_cap_info[2] |= c;
 
-	c = IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE |
-	    IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_4 |
-	    IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_4;
+	c = IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE;
+
+	if (is_mt7996(phy->mt76->dev))
+		c |= IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_4 |
+		     IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_4;
+	else
+		c |= IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_5 |
+		     IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_5;
+
 	elem->phy_cap_info[4] |= c;
 
 	/* do not support NG16 due to spec D4.0 changes subcarrier idx */
@@ -1187,7 +1197,8 @@ mt7996_init_eht_caps(struct mt7996_phy *phy, enum nl80211_band band,
 		IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMER |
 		IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMEE;
 
-	val = max_t(u8, sts - 1, 3);
+	/* Set the maximum capability regardless of the antenna configuration. */
+	val = is_mt7992(phy->mt76->dev) ? 4 : 3;
 	eht_cap_elem->phy_cap_info[0] |=
 		u8_encode_bits(u8_get_bits(val, BIT(0)),
 			       IEEE80211_EHT_PHY_CAP0_BEAMFORMEE_SS_80MHZ_MASK);
-- 
2.39.2


