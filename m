Return-Path: <linux-wireless+bounces-13217-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF3A986B48
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 05:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5391E283826
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 03:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09A915539A;
	Thu, 26 Sep 2024 03:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YcFHXCmx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C5413C3F2
	for <linux-wireless@vger.kernel.org>; Thu, 26 Sep 2024 03:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727321194; cv=none; b=gvsg3v1dw8tsUZdnB53asnxhM/vyNlO9ud054zckg3m+j/I/Rd6FIbN2bx2gzoRpN7DNxHoKY0AXHw4RZL8J/tb7/mS3LaVTUkHfeqy++SRMZ9P8L86zXLobWjwj3R2cmw9RE/DDJyFDwkIVrZ0jaCp9407f6TnARWrQgndCgVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727321194; c=relaxed/simple;
	bh=8emayu8nNIgaYyuGPb3MGRU6duVSRPYcE2Hl4snSkbE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b84hd0FD0g3Nyr85/+DSbAgq48Ytwhmjba3arJZ0qUNb4PPkj6FzSF6tV9tJEv0CQ9qhLd46aYWf0dbAvBQq/8XOvIOki6YWivYhAf/wx3PodkCWIxvawrou6YyeWUtZOhnHnB5vfVhrSnz/DW9v2QV8QoQv201WO79Gej5McKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YcFHXCmx; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1b8789007bb711ef8b96093e013ec31c-20240926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=eqGshFT5iI8Rk+fOPScnbzH5Ek6qRUOHtrN6DP1SjRI=;
	b=YcFHXCmxBNqTgIWdyhHbC4VTPs6X6zWHKhA3jTQQ3ZOmF9ZPdCZy71nvP5Fg0x3bp3mtFBd1xfWA281Ue3X61UISz/NlS2iSqvGv4A72RxiibWmJhbyUVIEsJ8UWqEWpyNgp4M+BM563TaWccSmIasOeW3HjM75rUvLgrmWOjX0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:e7f95c49-3007-46ae-b96f-299b2d349d18,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6dc6a47,CLOUDID:553cc8d0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 1b8789007bb711ef8b96093e013ec31c-20240926
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1460526643; Thu, 26 Sep 2024 11:26:24 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 26 Sep 2024 11:26:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 26 Sep 2024 11:26:22 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Daniel Golle <daniel@makrotopia.org>,
	StanleyYP Wang <StanleyYP.Wang@mediatek.com>, Shayne Chen
	<shayne.chen@mediatek.com>
Subject: [PATCH 3/3] wifi: mt76: mt7996: set correct background radar capability
Date: Thu, 26 Sep 2024 11:24:40 +0800
Message-ID: <20240926032440.15978-3-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240926032440.15978-1-shayne.chen@mediatek.com>
References: <20240926032440.15978-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--10.116100-8.000000
X-TMASE-MatchedRID: 1K2u6wLO8jxzDgxKJu7ruq8Gc8+Dx8axMZm0+sEE9mv/mpvOG+QCxGb6
	PphVtfZg7s3FANKtoAXOzH/JrlZNlcxznKow5+zWDko+EYiDQxHt/okBLaEo+C8zQZ2rR/OpekW
	kqRyavwA0RbGKWWKZ/ytyYiRIXYR5kfRhdidsajMURSScn+QSXt0H8LFZNFG73Yq8RVaZivWfoO
	av9/8yfIAmy5FzUCe5Vx5l5w4sRKZTieVsOVPxtik7tuAJpoIR
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.116100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: F91A5A24B90A6B49EFCBEFE254C9857A1297136349B04441A0DB4C4747C6FB0E2000:8
X-MTK: N

From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>

Some of the variants do not support background radar, so add a helper
to report background radar capability.

Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/init.c  |  7 ++++---
 .../wireless/mediatek/mt76/mt7996/mt7996.h    | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index bf70799b4bc4..f6a010b61a8a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -390,9 +390,10 @@ mt7996_init_wiphy(struct ieee80211_hw *hw, struct mtk_wed_device *wed)
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CAN_REPLACE_PTK0);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_MU_MIMO_AIR_SNIFFER);
 
-	if (!mdev->dev->of_node ||
-	    !of_property_read_bool(mdev->dev->of_node,
-				   "mediatek,disable-radar-background"))
+	if (mt7996_has_background_radar(phy->dev) &&
+	    (!mdev->dev->of_node ||
+	     !of_property_read_bool(mdev->dev->of_node,
+				    "mediatek,disable-radar-background")))
 		wiphy_ext_feature_set(wiphy,
 				      NL80211_EXT_FEATURE_RADAR_BACKGROUND);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 3f3278f43c79..9aec97dd81d9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -447,6 +447,25 @@ mt7996_band_valid(struct mt7996_dev *dev, u8 band)
 	return band <= MT_BAND2;
 }
 
+static inline bool
+mt7996_has_background_radar(struct mt7996_dev *dev)
+{
+	switch (mt76_chip(&dev->mt76)) {
+	case 0x7990:
+		if (dev->var.type == MT7996_VAR_TYPE_233)
+			return false;
+		break;
+	case 0x7992:
+		if (dev->var.type == MT7992_VAR_TYPE_23)
+			return false;
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
 extern const struct ieee80211_ops mt7996_ops;
 extern struct pci_driver mt7996_pci_driver;
 extern struct pci_driver mt7996_hif_driver;
-- 
2.39.2


