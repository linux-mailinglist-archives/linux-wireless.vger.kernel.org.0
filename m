Return-Path: <linux-wireless+bounces-20948-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0919FA75707
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Mar 2025 16:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E8116F045
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Mar 2025 15:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9C51DDC0F;
	Sat, 29 Mar 2025 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sdZtdLJ7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA201DB361
	for <linux-wireless@vger.kernel.org>; Sat, 29 Mar 2025 15:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743263269; cv=none; b=AcFi1wJ8nvRcKmLaJumNAIlqY/kMWz2mg/AszcftJe4d22LFLVDPmvFTMqMCnhS7Dhczq4N4w9i7QRM67ynWBHD13IQsDgVybibHIuiXUMb/Y9G9d5xEqjuicWdaIYqTs4eL3988J3poarWmRgLPLJBUqvv/xYqpidRINskxUbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743263269; c=relaxed/simple;
	bh=JD4SNqF1XMsPjpjAEyHHjEJIIutMiH+IETzwiYRE5II=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ma8hHITqnFsZedOIdNHCSY9pQl+x91ExtqoeUQ4SGNEr+SV4JwJY/oVzHKdLykPHSN/OEvqPVaNBgMfTxZI7gRYReiXr/dSEIuHBvmEOMgVsceOWCN51D/vp0+2qa3P9/d/cK3bVzmW1svq/AynBodXyA1ViA+ZfddQG34XyXvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sdZtdLJ7; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 24e2b0b20cb511f0aae1fd9735fae912-20250329
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=YFpaDEvPRQNzjQjvK8ikbTAXr7TyNVroPSc2lStu5KA=;
	b=sdZtdLJ7jDmICFdsUgfnauY/h/41pewXeyCTqAxILNPrtJYlNM4xkSCJKCwHtdZwj31fG2aPQO6Fdg/AjoI8J21NJZKXDZBqp/vfIRJASCVTf8f4+9lTMTDDlWcf5tKTWV8nsB/DbhLF8VvY1+qoC4bUCuzvj8mKaY+gKCmfYuc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:7c5e35b8-1a8b-4e9a-a188-e1fd51e8d15f,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:0ef645f,CLOUDID:e8f9b64a-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 24e2b0b20cb511f0aae1fd9735fae912-20250329
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 221619586; Sat, 29 Mar 2025 23:47:39 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Sat, 29 Mar 2025 23:47:38 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Sat, 29 Mar 2025 23:47:38 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Peter Chiu
	<chui-hao.chiu@mediatek.com>, Howard Hsu <howard-yh.hsu@mediatek.com>, Shayne
 Chen <shayne.chen@mediatek.com>
Subject: [PATCH mt76-next v2 07/10] wifi: mt76: mt7996: adjust HW capabilities for mt7990
Date: Sat, 29 Mar 2025 23:47:27 +0800
Message-ID: <20250329154731.2113551-8-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250329154731.2113551-1-shayne.chen@mediatek.com>
References: <20250329154731.2113551-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Peter Chiu <chui-hao.chiu@mediatek.com>

This is a preliminary patch to support mt7990 chipset.

Co-developed-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   | 9 ++++++---
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 4 ++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index a4c2986fcffd..9a8b10c50f72 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -440,6 +440,9 @@ mt7996_init_wiphy(struct ieee80211_hw *hw, struct mtk_wed_device *wed)
 	hw->queues = 4;
 	hw->max_rx_aggregation_subframes = max_subframes;
 	hw->max_tx_aggregation_subframes = max_subframes;
+	if (is_mt7990(mdev) && dev->has_eht)
+		hw->max_tx_aggregation_subframes = 512;
+
 	hw->netdev_features = NETIF_F_RXCSUM;
 	if (mtk_wed_device_active(wed))
 		hw->netdev_features |= NETIF_F_HW_TC;
@@ -1064,10 +1067,10 @@ void mt7996_set_stream_vht_txbf_caps(struct mt7996_phy *phy)
 	*cap |= IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
 		IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE;
 
-	if (is_mt7996(phy->mt76->dev))
-		*cap |= FIELD_PREP(IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK, 3);
-	else
+	if (is_mt7992(phy->mt76->dev))
 		*cap |= FIELD_PREP(IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK, 4);
+	else
+		*cap |= FIELD_PREP(IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK, 3);
 
 	*cap &= ~(IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK |
 		  IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 2dd33f303a06..92b01ed82e7e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -14,7 +14,7 @@
 #define MT7996_MAX_RADIOS		3
 #define MT7996_MAX_INTERFACES		19	/* per-band */
 #define MT7996_MAX_WMM_SETS		4
-#define MT7996_WTBL_BMC_SIZE		(is_mt7992(&dev->mt76) ? 32 : 64)
+#define MT7996_WTBL_BMC_SIZE		(is_mt7996(&dev->mt76) ? 64 : 32)
 #define MT7996_WTBL_RESERVED		(mt7996_wtbl_size(dev) - 1)
 #define MT7996_WTBL_STA			(MT7996_WTBL_RESERVED - \
 					 mt7996_max_interface_num(dev))
@@ -482,7 +482,7 @@ mt7996_phy3(struct mt7996_dev *dev)
 static inline bool
 mt7996_band_valid(struct mt7996_dev *dev, u8 band)
 {
-	if (is_mt7992(&dev->mt76))
+	if (!is_mt7996(&dev->mt76))
 		return band <= MT_BAND1;
 
 	return band <= MT_BAND2;
-- 
2.39.2


