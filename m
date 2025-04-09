Return-Path: <linux-wireless+bounces-21321-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCBDA82736
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 16:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F22019E87C7
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 14:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3CF266574;
	Wed,  9 Apr 2025 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eccOxClY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50639265637
	for <linux-wireless@vger.kernel.org>; Wed,  9 Apr 2025 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207732; cv=none; b=imuj8bBtD6lkhicA9EQGQ2LhpnrkJg3QAgKA/X3ZdfC5GPPB/jssuClNwAkH1RZ1bMgdhg+EdVGvai94YZCi80rLLbJjMZ/d4+xYKv/wrRmB1YixANdjux6jPF67cc5xClhwmReBuod9KgvXtlrhhjWarXS8jtqv5Lr3/6V7ZsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207732; c=relaxed/simple;
	bh=yT2lFs2ki0TWOxyhgU1SD/U63IhnNd1sDm/3AG+n4Gs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0pyLRw4A7bNtAYUoV29j+2wi7rlWg9ntv8PCCW/h41GZeIzJKPcSx/udKJp18Bz5DZhOWyErWgJUtYbmaHzob9gidvr49AkUoxMjAs0QVa+/4xT7YgA2E0X3EFXuVDF3VFtYpe5yPG8C6i42S3Xzi605w+eSHh34Ofz23F36ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=eccOxClY; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 21e468de154c11f0aae1fd9735fae912-20250409
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ytFrkvDpcP4xQTMB1eVxg87Ye+B3MkxSXKI+n0q6wIE=;
	b=eccOxClYmXiw+93YTfgUBmEXeNrid3nfb0y0ram7/RrrQCB//CBz4LdY9mTgTrfyD9nfbpR46jMsUpYfotIj+4ILvjU/R/jC5jxywHVIdfNXh3w55k6DAQsuicVf6fSQU8k8KmSZi3k0TWSvtx8fH+UTaIcbUOq+XU+VV3bqCZQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:b61f5976-0e9a-4445-9292-8ea09e8c7150,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:0ef645f,CLOUDID:f957e0a5-c619-47e3-a41b-90eedbf5b947,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 21e468de154c11f0aae1fd9735fae912-20250409
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 903039545; Wed, 09 Apr 2025 22:08:37 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 9 Apr 2025 22:08:37 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 9 Apr 2025 22:08:37 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, StanleyYP Wang
	<StanleyYP.Wang@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH mt76-next v3 09/10] wifi: mt76: mt7996: rework background radar check for mt7990
Date: Wed, 9 Apr 2025 22:07:49 +0800
Message-ID: <20250409140750.724437-10-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250409140750.724437-1-shayne.chen@mediatek.com>
References: <20250409140750.724437-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>

The MT7990 comes in 2T2R and 3T3R variants, with only the 2T2R supporting
background radar.

Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7996/eeprom.c    | 27 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/init.c  |  2 +-
 .../wireless/mediatek/mt76/mt7996/mt7996.h    | 20 +-------------
 3 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
index 6f3eb053ef02..7bfd19ed9594 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
@@ -376,3 +376,30 @@ s8 mt7996_eeprom_get_power_delta(struct mt7996_dev *dev, int band)
 
 	return val & MT_EE_RATE_DELTA_SIGN ? delta : -delta;
 }
+
+bool mt7996_eeprom_has_background_radar(struct mt7996_dev *dev)
+{
+	switch (mt76_chip(&dev->mt76)) {
+	case MT7996_DEVICE_ID:
+		if (dev->var.type == MT7996_VAR_TYPE_233)
+			return false;
+		break;
+	case MT7992_DEVICE_ID:
+		if (dev->var.type == MT7992_VAR_TYPE_23)
+			return false;
+		break;
+	case MT7990_DEVICE_ID: {
+		u8 path, rx_path, nss, *eeprom = dev->mt76.eeprom.data;
+
+		mt7996_eeprom_parse_stream(eeprom, MT_BAND1, &path, &rx_path, &nss);
+		/* Disable background radar capability in 3T3R */
+		if (path == 3 || rx_path == 3)
+			return false;
+		break;
+		}
+	default:
+		return false;
+	}
+
+	return true;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 9a8b10c50f72..e26451add9a3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -475,7 +475,7 @@ mt7996_init_wiphy(struct ieee80211_hw *hw, struct mtk_wed_device *wed)
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CAN_REPLACE_PTK0);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_MU_MIMO_AIR_SNIFFER);
 
-	if (mt7996_has_background_radar(dev) &&
+	if (mt7996_eeprom_has_background_radar(dev) &&
 	    (!mdev->dev->of_node ||
 	     !of_property_read_bool(mdev->dev->of_node,
 				    "mediatek,disable-radar-background")))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 92b01ed82e7e..a45cd3ff61a0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -488,25 +488,6 @@ mt7996_band_valid(struct mt7996_dev *dev, u8 band)
 	return band <= MT_BAND2;
 }
 
-static inline bool
-mt7996_has_background_radar(struct mt7996_dev *dev)
-{
-	switch (mt76_chip(&dev->mt76)) {
-	case MT7996_DEVICE_ID:
-		if (dev->var.type == MT7996_VAR_TYPE_233)
-			return false;
-		break;
-	case MT7992_DEVICE_ID:
-		if (dev->var.type == MT7992_VAR_TYPE_23)
-			return false;
-		break;
-	default:
-		return false;
-	}
-
-	return true;
-}
-
 static inline struct mt7996_phy *
 mt7996_band_phy(struct mt7996_dev *dev, enum nl80211_band band)
 {
@@ -570,6 +551,7 @@ int mt7996_eeprom_parse_hw_cap(struct mt7996_dev *dev, struct mt7996_phy *phy);
 int mt7996_eeprom_get_target_power(struct mt7996_dev *dev,
 				   struct ieee80211_channel *chan);
 s8 mt7996_eeprom_get_power_delta(struct mt7996_dev *dev, int band);
+bool mt7996_eeprom_has_background_radar(struct mt7996_dev *dev);
 int mt7996_dma_init(struct mt7996_dev *dev);
 void mt7996_dma_reset(struct mt7996_dev *dev, bool force);
 void mt7996_dma_prefetch(struct mt7996_dev *dev);
-- 
2.39.2


