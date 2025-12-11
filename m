Return-Path: <linux-wireless+bounces-29669-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DD4CB5EAC
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 13:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1772830046D8
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 12:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077D130FF3B;
	Thu, 11 Dec 2025 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kNoHsIH9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5240430FF29
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765456948; cv=none; b=dVyq5kQ5MYczIvMLcrCjPrW31d2SKhXqjM8i9EO/VabBTxXPUSRE6pUjeMyZbFBlaM+ZZSxaLNtTMkkjtq5AX1dxDQyuVgcNfbJ9ylai2voTWvtD0kqLssWzk7Bo7ivvwUkaajudNRpjkYiuP4q+04tugRDXIMJDe1UnqXPA06g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765456948; c=relaxed/simple;
	bh=ReU7YFp537JELze+/elGUNa+2sGwh+M0CDckI1fFyw8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HpEkGGN0BkqNhhgXAvHpi3zdQm9KpxXqlNURcq5ok+XcAtcy1Zqs2RgNpPRGZiMkna0F/hwIgSDgEZnj98qMiR1Kc9W0lu9wTRbVQDbqgrPBMyC7yowHElqqSR8gSf0SZQImE93BqXHOFGyoga9uJX7x/ITqqi1JoC23WYWhCsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kNoHsIH9; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d2c0241ed68e11f0b2bf0b349165d6e0-20251211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=14DMg1kOjoT2+p+GSeAQfJCaf8eSkoQFbW5DEdKFmfs=;
	b=kNoHsIH9ayGfulCP8s1EldUcm+6QqLmcAurdAWeWDT0J8HoT1hZTkNW4d8Ssp0Oam45IBUGFJ+froL78TgU72qIlQA3J6BOetjdQGhHo3DI1s9pfmztxyP63Zbjc02cCE0Be5x5nZotmj8BHzru8320aFiFGyuCgOidJ6UeS/10=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:080aa799-80cf-4650-9cae-5753d4844143,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:da8b15aa-6421-45b1-b8b8-e73e3dc9a90f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d2c0241ed68e11f0b2bf0b349165d6e0-20251211
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <leon.yen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1248448559; Thu, 11 Dec 2025 20:42:15 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 11 Dec 2025 20:42:14 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Thu, 11 Dec 2025 20:42:14 +0800
From: Leon Yen <leon.yen@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<deren.wu@mediatek.com>, <sean.wang@mediatek.com>,
	<mingyen.hsieh@mediatek.com>, <michael.lo@mediatek.com>,
	<allan.wang@mediatek.com>, <quan.zhou@mediatek.com>,
	<sarick.jiang@mediatek.com>, <ryder.lee@mediatek.com>,
	<shayne.chen@mediatek.com>, <leon.yen@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7925: Fix incorrect MLO mode in firmware control
Date: Thu, 11 Dec 2025 20:38:36 +0800
Message-ID: <20251211123836.4169436-1-leon.yen@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The selection of MLO mode should depend on the capabilities of the STA
rather than those of the peer AP to avoid compatibility issues with
certain APs, such as Xiaomi BE5000 WiFi7 router.

Fixes: 69acd6d910b0c ("wifi: mt76: mt7925: add mt7925_change_vif_links")
Signed-off-by: Leon Yen <leon.yen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index cf0fdea45cf7..279ace8ab883 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1330,6 +1330,8 @@ int mt7925_mcu_set_mlo_roc(struct mt792x_bss_conf *mconf, u16 sel_links,
 			.roc[1].len = cpu_to_le16(sizeof(struct roc_acquire_tlv))
 	};
 
+	struct wiphy *wiphy = mvif->phy->mt76->hw->wiphy;
+
 	if (!mconf || hweight16(vif->valid_links) < 2 ||
 	    hweight16(sel_links) != 2)
 		return -EPERM;
@@ -1352,7 +1354,8 @@ int mt7925_mcu_set_mlo_roc(struct mt792x_bss_conf *mconf, u16 sel_links,
 		is_AG_band |= links[i].chan->band == NL80211_BAND_2GHZ;
 	}
 
-	if (vif->cfg.eml_cap & IEEE80211_EML_CAP_EMLSR_SUPP)
+	if (!(wiphy->iftype_ext_capab[0].mld_capa_and_ops &
+		IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS))
 		type = is_AG_band ? MT7925_ROC_REQ_MLSR_AG :
 				    MT7925_ROC_REQ_MLSR_AA;
 	else
-- 
2.45.2


