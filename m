Return-Path: <linux-wireless+bounces-17474-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB3EA103B4
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 11:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7397918897AA
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 10:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086EF24334A;
	Tue, 14 Jan 2025 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bWQMHJoo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D391ADC60
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 10:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736849510; cv=none; b=fuMEIGKy30Ukx1FHDwsn8vnkAdQYkX+CMNWXrDZ1s1TFbxld1ncroi5ErpUAue7DmRQDQRvR19ycC+KEybdnOjUZvFMmFI5TkPkrvyr3IIEZrcwm2t/T7Ak8a0QTihFIuDl9WI9C20RZ6YGb6oN9TkRap52zHaw1xCfMtRjMHl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736849510; c=relaxed/simple;
	bh=amhmXXgxg5Ph1EkbvOTQZy8bNIkDM6LuC5n/8Ju4m2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bb+PcwZvaDc6QZslRq4loN0lkJR3rgtYQ1qaSkDzueHJcnBTUcJ94FdaW/miImpPgZTwbhk4FJ65fKKlTEZfXdm72WYzpZMhWkmI26+AmBPqS+Ky0iWR0bnln3eOSIfm180KJ2ukGhNfALCYNAOEQRqrFcyGiQZA+WA4L/U/nxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bWQMHJoo; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f2b29ddad25f11ef99858b75a2457dd9-20250114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7GIBSX8mPVc3uIDlvbGyJBUXZ0+UFMsL7GaRiLYOtBQ=;
	b=bWQMHJoo/g1jN1ndC6eg5EFNzHG4DKPcjD27jENStSK8zh1wS/txlKlO8VPtKh06s2V/zxgwzZ4/AaS+C24kIgAn5PGkMg2SdEgI3jG8XMxAXSULVHegTSGwiNZ6vwUrBUg4GZFPQw3WzoeGIjOtdBVYW5o0+tp7AS85p66EiN8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:7f7cf264-7cd9-4e7b-93ca-cc3aa6783767,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:79d4dc37-e11c-4c1a-89f7-e7a032832c40,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f2b29ddad25f11ef99858b75a2457dd9-20250114
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 5721070; Tue, 14 Jan 2025 18:11:40 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
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
Subject: [PATCH 2/9] wifi: mt76: mt7996: fix the capability of reception of EHT MU PPDU
Date: Tue, 14 Jan 2025 18:10:19 +0800
Message-ID: <20250114101026.3587702-2-shayne.chen@mediatek.com>
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

This commit includes two changes. First, enable "EHT MU PPDU With 4x
EHT-LTF And 0.8us GI" in EHT Phy capabilities element since hardware
can support. Second, fix the value of "Maximum number of supported
EHT LTFs" in the same element, where the previous setting of 3 in
Bit 3-4 was incorrect.

Fixes: 348533eb968d ("wifi: mt76: mt7996: add EHT capability init")
Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 0946755dcf60..5ce0226a3900 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -1355,21 +1355,20 @@ mt7996_init_eht_caps(struct mt7996_phy *phy, enum nl80211_band band,
 		IEEE80211_EHT_PHY_CAP3_CODEBOOK_7_5_MU_FDBK;
 
 	eht_cap_elem->phy_cap_info[4] =
+		IEEE80211_EHT_PHY_CAP4_EHT_MU_PPDU_4_EHT_LTF_08_GI |
 		u8_encode_bits(min_t(int, sts - 1, 2),
 			       IEEE80211_EHT_PHY_CAP4_MAX_NC_MASK);
 
 	eht_cap_elem->phy_cap_info[5] =
 		u8_encode_bits(IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_16US,
 			       IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_MASK) |
-		u8_encode_bits(u8_get_bits(0x11, GENMASK(1, 0)),
+		u8_encode_bits(u8_get_bits(1, GENMASK(1, 0)),
 			       IEEE80211_EHT_PHY_CAP5_MAX_NUM_SUPP_EHT_LTF_MASK);
 
 	val = width == NL80211_CHAN_WIDTH_320 ? 0xf :
 	      width == NL80211_CHAN_WIDTH_160 ? 0x7 :
 	      width == NL80211_CHAN_WIDTH_80 ? 0x3 : 0x1;
 	eht_cap_elem->phy_cap_info[6] =
-		u8_encode_bits(u8_get_bits(0x11, GENMASK(4, 2)),
-			       IEEE80211_EHT_PHY_CAP6_MAX_NUM_SUPP_EHT_LTF_MASK) |
 		u8_encode_bits(val, IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_MASK);
 
 	val = u8_encode_bits(nss, IEEE80211_EHT_MCS_NSS_RX) |
-- 
2.39.2


