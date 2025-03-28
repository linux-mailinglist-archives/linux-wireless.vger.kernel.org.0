Return-Path: <linux-wireless+bounces-20922-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3258CA743AA
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 06:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CAAA1892720
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 05:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135BF1DE2BA;
	Fri, 28 Mar 2025 05:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KtuU6AHK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EC32116FB
	for <linux-wireless@vger.kernel.org>; Fri, 28 Mar 2025 05:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743141250; cv=none; b=ZXyk5XqeywwQAhBTGdXan1CM4nGOKREZZlV34eFQoTcQ+ZcZvb+0m05HDohTOcZdGpbznurZalozB+rlv9eFLZR56SgreukHxh9vu2EyPSZE1ILZQwxeKFLX/yxyjwpySsc/0jZsWe7tm1eOZaVWuL/eS9r5uOFh/ckbLqVxTog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743141250; c=relaxed/simple;
	bh=SCvmFYqAfRIB4zT0ljNpDFXGuOoqmR4RAisXye157HQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9GDKnHI904rGsdVwnyjE/U1fd5qSBfZxmrJGetiRF81HyQ5Lvg64qvxm8IDA/pZFJHIBNaQeuDHrD8OCyJ5VbSngOqg3EwIgGo+d8BKZnVCCzGDfZmKk74F58fL2+H5e5NNRaVBwjisgRXNOka9N8yfVAAxs8L44FdulsrnWe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=KtuU6AHK; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0b2ecd6c0b9911f0aae1fd9735fae912-20250328
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=DcpZ0NAZA8cTF+XSio1AuvxxcEEqepGgX0shaqdGr8E=;
	b=KtuU6AHKXDG91MLE4/TvJV32/qyjbI6F8A0R1sl8OZCGLPVfOH1X/n62vutSqpWd2EPErijgvKCzZGwuYp/Znht3RslU4NDxjauFiTD1fQGzqNez9SICKT186cFWzHlbBjLHwnGDk/rx5yqqqmfWBKYvWglYo2RQyEPGwoYvG7U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:d2886ef8-08a3-41af-99fb-3bd07779c20c,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:0ef645f,CLOUDID:059c67a5-c619-47e3-a41b-90eedbf5b947,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0b2ecd6c0b9911f0aae1fd9735fae912-20250328
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1805222645; Fri, 28 Mar 2025 13:53:59 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 28 Mar 2025 13:53:58 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 28 Mar 2025 13:53:58 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, StanleyYP Wang
	<StanleyYP.Wang@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 09/10] wifi: mt76: mt7996: rework background radar check for mt7990
Date: Fri, 28 Mar 2025 13:50:57 +0800
Message-ID: <20250328055058.1648755-10-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250328055058.1648755-1-shayne.chen@mediatek.com>
References: <20250328055058.1648755-1-shayne.chen@mediatek.com>
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

The mt7990 comes in 2T2R+1R and 3T3R variants on 5 GHz band, with only
the former supporting background radar.

Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7996/eeprom.c    | 27 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/init.c  |  2 +-
 .../wireless/mediatek/mt76/mt7996/mt7996.h    | 20 +-------------
 3 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
index 6f3eb053ef02..ca67a2c4b6a7 100644
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
+	}
+	default:
+		return false;
+	}
+
+	return true;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 9192fbdbc7da..3bbf6041c96d 100644
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


