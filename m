Return-Path: <linux-wireless+bounces-33182-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJjlHZ6us2kvZwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33182-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 07:28:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 569F927E1C1
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 07:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22F3431C16C0
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 06:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010C1342CB6;
	Fri, 13 Mar 2026 06:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QW20RXfW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8310B328B58
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 06:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773383000; cv=none; b=jjvV5BWv9t0Ia0F4zP1KjlCqWyfZITdQh7n1fnw/SnNI20ByoTNbpH+JBMDihAsVeW40hsClkGgvzxvvLVW+hEPkiNxGm2WtbWsNX+Be936eprYYEu7WLk9RSHCYWiZEv4F/wGj2lWn2QxI8BmoXgzgAYj6G4vUpTo18Zx2lCdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773383000; c=relaxed/simple;
	bh=YLZrGaPQfnwP/DXJ8WofdBzDVK93zD9oklA2A/X/wec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RGpOtRoW3bQbegfIIc5RL80nLHO37UDqoDbfdGQ+YhQT84r5B0mTn2cO0tUbrB5WCa/v82u17giODzsI38ihMXJZYA/uj/O7dm28C42az0l58LYUru28inwq3ZzvUMZA5tbrhGHy0G/nQmZmy22kBX2Bhtw+5gcVYnqZtYIcHb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QW20RXfW; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1ca73f821ea511f1a02d4725871ece0b-20260313
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ToG08eSiKjJV3VqptVXImyuqNUPfUBbEss8R/TV/gYI=;
	b=QW20RXfWO4Y3C9IGyboYw/Dx1TofqiBjJZx1gVDYiY3ahW9ovWBO69YKtIrC7KIl5TNYhcwuXcjJAxp3Nj+Fl2Xvyk0AWsqFw7kTjCAjKq7ERMhNqVXFBeRRng4yXJHY1/S5WU1yIP9RyT88HVF2yGHzUoJkPTFshf8w2UQE3k0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:d2243cbb-18b8-4748-b038-fbb749746220,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:a462c093-f8ef-4ca8-bea0-143568f9ca1d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:5,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1ca73f821ea511f1a02d4725871ece0b-20260313
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 334160692; Fri, 13 Mar 2026 14:23:12 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 13 Mar 2026 14:23:11 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 13 Mar 2026 14:23:11 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: linux-wireless <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
	Evelyn Tsai <evelyn.tsai@mediatek.com>, Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, Shayne Chen
	<shayne.chen@mediatek.com>
Subject: [PATCH wireless-next 2/2] wifi: mt76: mt7996: fix capability of EHT-MCS 15 in MRU
Date: Fri, 13 Mar 2026 14:21:50 +0800
Message-ID: <20260313062150.3165433-2-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260313062150.3165433-1-shayne.chen@mediatek.com>
References: <20260313062150.3165433-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-33182-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shayne.chen@mediatek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[mediatek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mediatek.com:dkim,mediatek.com:email,mediatek.com:mid]
X-Rspamd-Queue-Id: 569F927E1C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

According to the definition in IEEE Std 802.11be-2024, Table 9-417r:
- If 80 MHz is not supported, bit 1-3 are set to 0.
- If 160 MHz is not supported, bit 2-3 are set to 0.
- If 320 MHz is not supported, bit 3 is set to 0.

Fixes: 348533eb968d ("wifi: mt76: mt7996: add EHT capability init")
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 00a8286bd136..a08bc07a7f93 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -1492,7 +1492,6 @@ mt7996_init_eht_caps(struct mt7996_phy *phy, enum nl80211_band band,
 	struct ieee80211_sta_eht_cap *eht_cap = &data->eht_cap;
 	struct ieee80211_eht_cap_elem_fixed *eht_cap_elem = &eht_cap->eht_cap_elem;
 	struct ieee80211_eht_mcs_nss_supp *eht_nss = &eht_cap->eht_mcs_nss_supp;
-	enum nl80211_chan_width width = phy->mt76->chandef.width;
 	int nss = hweight8(phy->mt76->antenna_mask);
 	int sts = hweight16(phy->mt76->chainmask);
 	u8 val;
@@ -1568,11 +1567,16 @@ mt7996_init_eht_caps(struct mt7996_phy *phy, enum nl80211_band band,
 		u8_encode_bits(u8_get_bits(1, GENMASK(1, 0)),
 			       IEEE80211_EHT_PHY_CAP5_MAX_NUM_SUPP_EHT_LTF_MASK);
 
-	val = width == NL80211_CHAN_WIDTH_320 ? 0xf :
-	      width == NL80211_CHAN_WIDTH_160 ? 0x7 :
-	      width == NL80211_CHAN_WIDTH_80 ? 0x3 : 0x1;
-	eht_cap_elem->phy_cap_info[6] =
-		u8_encode_bits(val, IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_MASK);
+	eht_cap_elem->phy_cap_info[6] = IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_MASK;
+	if (band != NL80211_BAND_6GHZ) {
+		eht_cap_elem->phy_cap_info[6] &=
+			~IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_320MHZ;
+
+		if (band != NL80211_BAND_5GHZ)
+			eht_cap_elem->phy_cap_info[6] &=
+				~(IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_160MHZ |
+				  IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_80MHZ);
+	}
 
 	val = u8_encode_bits(nss, IEEE80211_EHT_MCS_NSS_RX) |
 	      u8_encode_bits(nss, IEEE80211_EHT_MCS_NSS_TX);
-- 
2.51.0


