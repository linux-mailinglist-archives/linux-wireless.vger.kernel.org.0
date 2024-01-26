Return-Path: <linux-wireless+bounces-2539-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF3383D71B
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 11:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81F4B1C20C6C
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 10:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68506311F;
	Fri, 26 Jan 2024 09:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Gqkz10s+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED19C633FD
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260208; cv=none; b=l1A4AGz4vmPbZD6psJ/bkiBVZDzf4REtU+4Znwg0NHueWP8mnvieBWAoTX0D98E2jXaK2HQF4E14IapsCEMpTfLHLLB3E7ZJ+l8mhL8fWFaR/3PW7pRUemrZDP9ACvMW3iAFKHcIAnXgrGce+K5coyrCvY90CHe2hhM76fgBHJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260208; c=relaxed/simple;
	bh=S1E86e9R/FG8ivTm60MAPno1ouTEm7Qe1nU0O2dRoSs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q/G58Ua92xQokLBr2kprh6JkRjmCY+2NtgIvXmUrYIu4Fm0FJT+EcZW/TT4ERsABbEC+gsPYHlQCou6gHuuzm8e1TDqfa6yXQ0HRrfWHEgJc20hGtxU0jPACxg7q96ZYUHohpAy8CSgdoMfZYvTbed8y8owniIBZve6UQkPB7Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Gqkz10s+; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a9931d74bc2a11eea2298b7352fd921d-20240126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=epN7KJjCMnYrcOaasseqP03+HRXsNVjKd4ndmSsQ1BM=;
	b=Gqkz10s+Uv38jJy+FfDMuwqmfb5gYYDUnmpgUIihIYFCYKdgXYmXtMAoQL1w6a1JEklv34m3ZlJe5sl9iWYwsi+HniAu00KOqeH4kwcAZOO/vdIzHiBJAYbqHwAEo2HQoIIMitvKt99eqTkm/Y2c3alnsmtBTOHaFuD22eZroGk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:68f75bf8-d61a-460f-b080-aa15ee712380,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6e16cf4,CLOUDID:1b414983-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a9931d74bc2a11eea2298b7352fd921d-20240126
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 395730437; Fri, 26 Jan 2024 17:09:51 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 26 Jan 2024 17:09:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 26 Jan 2024 17:09:49 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Benjamin Lin
	<benjamin-jw.lin@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2 04/12] wifi: mt76: mt7996: fix incorrect interpretation of EHT MCS caps
Date: Fri, 26 Jan 2024 17:09:15 +0800
Message-ID: <20240126090923.6357-4-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240126090923.6357-1-shayne.chen@mediatek.com>
References: <20240126090923.6357-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-1.739900-8.000000
X-TMASE-MatchedRID: nZiOSCXx2v0zTh1BHqxnVY3NgkEqAN0Rsf4f4CxxueRz/u+TcH1U7P9T
	oIqmlx19ThbvLLI8RvOWLz7gHk2taUHQ/pYAwhs6R/j040fRFpJ9LQinZ4QefPcjNeVeWlqY+gt
	Hj7OwNO3Y+r35MKhZcLtq+wOZHYbSBzOYxaP1nyFhNr/gqmm8vOLUFJq/ej6iXI/zOPA1FeTMdT
	ys6h3FMES8yNWlgnTLN7lgFJuCeT3roWeZQy0/P3ZrUbEZipAEiWT09mQz7szw9kH8zAy44SIdu
	k5Jkjd37ndUHUMmXu5+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-1.739900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 593BC6402B06AF40E581A4655D040D11F37BC173E5CFCB661EFFDC2E9FAD6D562000:8
X-MTK: N

From: Benjamin Lin <benjamin-jw.lin@mediatek.com>

The EHT MCS map subfield of 20 MHz-Only is not present in the EHT
capability of AP, so STA does not need to parse the subfield.
Moreover, AP should parse the subfield only if STA is 20 MHz-Only, which
can be confirmed by checking supported channel width in HE capability.

Fixes: 92aa2da9fa49 ("wifi: mt76: mt7996: enable EHT support in firmware")
Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 3c729b563edc..02d858fdc9fe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1240,6 +1240,9 @@ mt7996_mcu_sta_he_6g_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 static void
 mt7996_mcu_sta_eht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 {
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct ieee80211_vif *vif = container_of((void *)msta->vif,
+						 struct ieee80211_vif, drv_priv);
 	struct ieee80211_eht_mcs_nss_supp *mcs_map;
 	struct ieee80211_eht_cap_elem_fixed *elem;
 	struct sta_rec_eht *eht;
@@ -1259,8 +1262,17 @@ mt7996_mcu_sta_eht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 	eht->phy_cap = cpu_to_le64(*(u64 *)elem->phy_cap_info);
 	eht->phy_cap_ext = cpu_to_le64(elem->phy_cap_info[8]);
 
-	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_20)
-		memcpy(eht->mcs_map_bw20, &mcs_map->only_20mhz, sizeof(eht->mcs_map_bw20));
+	if (vif->type != NL80211_IFTYPE_STATION &&
+	    (sta->deflink.he_cap.he_cap_elem.phy_cap_info[0] &
+	     (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
+	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
+	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
+	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)) == 0) {
+		memcpy(eht->mcs_map_bw20, &mcs_map->only_20mhz,
+		       sizeof(eht->mcs_map_bw20));
+		return;
+	}
+
 	memcpy(eht->mcs_map_bw80, &mcs_map->bw._80, sizeof(eht->mcs_map_bw80));
 	memcpy(eht->mcs_map_bw160, &mcs_map->bw._160, sizeof(eht->mcs_map_bw160));
 	memcpy(eht->mcs_map_bw320, &mcs_map->bw._320, sizeof(eht->mcs_map_bw320));
-- 
2.39.2


