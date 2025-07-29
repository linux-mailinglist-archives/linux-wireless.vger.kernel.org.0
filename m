Return-Path: <linux-wireless+bounces-26040-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD578B14A6E
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Jul 2025 10:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11D531887017
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Jul 2025 08:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E69678F34;
	Tue, 29 Jul 2025 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="C8iio1i5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4F3283121
	for <linux-wireless@vger.kernel.org>; Tue, 29 Jul 2025 08:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753778986; cv=none; b=pMDb6ObCzxaDWnlT6yUU3RAJ8P+nZvY/ZVNPLvGUHbWiMuZ2/FTohsU9BlrmU3emGfEVEpxuhxgTkfNFF/2b0cfpbkRgY2JZ78rv7Dl/gkfIgoi/3ZJKBjAcsvqn56YshwpOlStTs0d6YXq/1Utp8FCL2Eurv9OHUad5lgGHFhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753778986; c=relaxed/simple;
	bh=ITdH2sFZS20UTmy7e69V0OA+feZjS6jkzaAC5DDDRVg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pims7lgsAzgDgA0Axo8qEVg55mHdq7atFxWFwnas+J1+CUKrgWAveQKNPKJ+SzLmfLsAcvJnwUbUTPgRDFSDrbRLmW/T07JABcG73q3/n67cjNl4LONKU17dfYt71mGfzvJTHWF1tukbwJqxF6AZkKjWENezRYeLVKsoPVIWwOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=C8iio1i5; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f55daf646c5811f08b7dc59d57013e23-20250729
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=2Y5w5r6aryaXhlJ7UqlVhhct1/3KeD8bUu52PUC3sHI=;
	b=C8iio1i5iCZJahVyZQb8OtltZa4jCpzqp6PJ9BWVYen6NrP0EljmtirFa/tBzYP83s+MNPmce2AH/D/m5ZDGnwt3EqLOcD/DOURAB2DmCH2tW7ZS6JGObtwiVQeiuSwKM+ofJKZnndEuGIF2kWJ/lOFD97AIqAbhIRbPdWQ+GFU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:e4ebdd44-e45d-4d81-a905-fc8ea5705e8b,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:97c75c50-93b9-417a-b51d-915a29f1620f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|15|50,EDM:-3,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f55daf646c5811f08b7dc59d57013e23-20250729
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 158823384; Tue, 29 Jul 2025 16:49:37 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 29 Jul 2025 16:49:35 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 29 Jul 2025 16:49:35 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7925: add MBSSID support
Date: Tue, 29 Jul 2025 16:49:32 +0800
Message-ID: <20250729084932.264155-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Enable MBSSID support for MT7925 by setting the
appropriate capability to the firmware.

Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 23 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt792x_core.c  |  7 +++++-
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index d79efc8aa919..eed8d5ffaab0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -244,6 +244,7 @@ int mt7925_init_mlo_caps(struct mt792x_phy *phy)
 {
 	struct wiphy *wiphy = phy->mt76->hw->wiphy;
 	static const u8 ext_capa_sta[] = {
+		[2] = WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT,
 		[7] = WLAN_EXT_CAPA8_OPMODE_NOTIF,
 	};
 	static struct wiphy_iftype_ext_capab ext_capab[] = {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 4fe67ef62cd7..7c7b6f066d53 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2879,6 +2879,25 @@ mt7925_mcu_bss_qos_tlv(struct sk_buff *skb, struct ieee80211_bss_conf *link_conf
 	qos->qos = link_conf->qos;
 }
 
+static void
+mt7925_mcu_bss_mbssid_tlv(struct sk_buff *skb, struct ieee80211_bss_conf *link_conf,
+			  bool enable)
+{
+	struct bss_info_uni_mbssid *mbssid;
+	struct tlv *tlv;
+
+	if (!enable && !link_conf->bssid_indicator)
+		return;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_11V_MBSSID,
+				      sizeof(*mbssid));
+
+	mbssid = (struct bss_info_uni_mbssid *)tlv;
+	mbssid->max_indicator = link_conf->bssid_indicator;
+	mbssid->mbss_idx = link_conf->bssid_index;
+	mbssid->tx_bss_omac_idx = 0;
+}
+
 static void
 mt7925_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_bss_conf *link_conf,
 		      struct mt792x_phy *phy)
@@ -3045,8 +3064,10 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 		mt7925_mcu_bss_color_tlv(skb, link_conf, enable);
 	}
 
-	if (enable)
+	if (enable) {
 		mt7925_mcu_bss_rlm_tlv(skb, phy->mt76, link_conf, ctx);
+		mt7925_mcu_bss_mbssid_tlv(skb, link_conf, enable);
+	}
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_UNI_CMD(BSS_INFO_UPDATE), true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 81ab7b20aa64..eb4099021fcb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -697,8 +697,13 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, SUPPORTS_VHT_EXT_NSS_BW);
 	ieee80211_hw_set(hw, CONNECTION_MONITOR);
 	ieee80211_hw_set(hw, NO_VIRTUAL_MONITOR);
-	if (is_mt7921(&dev->mt76))
+
+	if (is_mt7921(&dev->mt76)) {
 		ieee80211_hw_set(hw, CHANCTX_STA_CSA);
+	} else {
+		ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
+		ieee80211_hw_set(hw, SUPPORTS_ONLY_HE_MULTI_BSSID);
+	}
 
 	if (dev->pm.enable)
 		ieee80211_hw_set(hw, CONNECTION_MONITOR);
-- 
2.34.1


