Return-Path: <linux-wireless+bounces-29314-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0DCC83453
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 04:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCCF83AEF57
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 03:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A60B289E06;
	Tue, 25 Nov 2025 03:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="udsj7GHx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B81D27D77D
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 03:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764042455; cv=none; b=nwxtHrw9Js3J/3nQdlosJC2BTWYnTuOQ7+O45dOStY/Prwjt2nMNALsO2t5iPkVrnw9CTKEyX2uixYsZq9QhG7YDYRpd78KjclahqUJOK/nDBRVskBT7zlYfIAAN1l+fPfzlmkp17klwbV28X5IhF5YQqi+8kKwYw5GfbaXsUrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764042455; c=relaxed/simple;
	bh=LCCTeZ0HYKGwsP4Ptpf4VHm/gsbCx4AZhQqmUIdDf0I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pYkc0FjS5gjSaaUZJhTVyFJfZGcxcyW9uIJH4HYf9dwlEWZW8dJChMohEbG7w5aLPvcfxHTF3cWJtT4vf9Dk29U9JynFS37IbuN3KaIXEuFWrpPiXLO6SFyu1PFQ6j8J07wMLi4VoqQc0NK/7LUeM2A+T/D9Ob9emyBaUEnv+Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=udsj7GHx; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 74e72c82c9b111f08ac0a938fc7cd336-20251125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=S14FgoBDQrftYs+PhqprfZVLFD1dRiFBQ0vXnY3TjyM=;
	b=udsj7GHxafW9PnPnNk5OZqmcBqS+BpMo6zYChUhLmGyal0yNlN7qMkuApnPQiZGzoeC5dEP4KPqSuNTTw9I3auh2/E611N64i4vLsPlEJpm6ZAQJ98bBPu3I1ifdJ3MPswsxorJmOlVyAkfv4m2P7FqobWz+O10mDjX9vwPNLIg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:7774ccf8-ba41-4157-a127-35685b7e9d8d,IP:0,UR
	L:0,TC:0,Content:-5,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:7f470383-b6af-4b29-9981-6bf838f9504d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:1,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 74e72c82c9b111f08ac0a938fc7cd336-20251125
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 208979438; Tue, 25 Nov 2025 11:47:25 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 25 Nov 2025 11:47:24 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Tue, 25 Nov 2025 11:47:24 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, StanleyYP Wang
	<StanleyYP.Wang@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH mt76 5/7] wifi: mt76: mt7996: offload radar threshold initialization
Date: Tue, 25 Nov 2025 11:46:37 +0800
Message-ID: <20251125034639.1416214-5-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251125034639.1416214-1-shayne.chen@mediatek.com>
References: <20251125034639.1416214-1-shayne.chen@mediatek.com>
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

Since some radar specifications maintained by the driver are incorrect
and are now also maintained by the firmware, offload the initialization
procedure to the firmware.
This fixes issues for radar detection rate testings.

Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 77 -------------------
 .../net/wireless/mediatek/mt76/mt7996/mac.h   |  5 --
 2 files changed, 82 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index ce85d8f1bde6..98abaa51cf00 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -13,45 +13,6 @@
 
 #define to_rssi(field, rcpi)	((FIELD_GET(field, rcpi) - 220) / 2)
 
-static const struct mt7996_dfs_radar_spec etsi_radar_specs = {
-	.pulse_th = { 110, -10, -80, 40, 5200, 128, 5200 },
-	.radar_pattern = {
-		[5] =  { 1, 0,  6, 32, 28, 0,  990, 5010, 17, 1, 1 },
-		[6] =  { 1, 0,  9, 32, 28, 0,  615, 5010, 27, 1, 1 },
-		[7] =  { 1, 0, 15, 32, 28, 0,  240,  445, 27, 1, 1 },
-		[8] =  { 1, 0, 12, 32, 28, 0,  240,  510, 42, 1, 1 },
-		[9] =  { 1, 1,  0,  0,  0, 0, 2490, 3343, 14, 0, 0, 12, 32, 28, { }, 126 },
-		[10] = { 1, 1,  0,  0,  0, 0, 2490, 3343, 14, 0, 0, 15, 32, 24, { }, 126 },
-		[11] = { 1, 1,  0,  0,  0, 0,  823, 2510, 14, 0, 0, 18, 32, 28, { },  54 },
-		[12] = { 1, 1,  0,  0,  0, 0,  823, 2510, 14, 0, 0, 27, 32, 24, { },  54 },
-	},
-};
-
-static const struct mt7996_dfs_radar_spec fcc_radar_specs = {
-	.pulse_th = { 110, -10, -80, 40, 5200, 128, 5200 },
-	.radar_pattern = {
-		[0] = { 1, 0,  8,  32, 28, 0, 508, 3076, 13, 1,  1 },
-		[1] = { 1, 0, 12,  32, 28, 0, 140,  240, 17, 1,  1 },
-		[2] = { 1, 0,  8,  32, 28, 0, 190,  510, 22, 1,  1 },
-		[3] = { 1, 0,  6,  32, 28, 0, 190,  510, 32, 1,  1 },
-		[4] = { 1, 0,  9, 255, 28, 0, 323,  343, 13, 1, 32 },
-	},
-};
-
-static const struct mt7996_dfs_radar_spec jp_radar_specs = {
-	.pulse_th = { 110, -10, -80, 40, 5200, 128, 5200 },
-	.radar_pattern = {
-		[0] =  { 1, 0,  8,  32, 28, 0,  508, 3076,  13, 1,  1 },
-		[1] =  { 1, 0, 12,  32, 28, 0,  140,  240,  17, 1,  1 },
-		[2] =  { 1, 0,  8,  32, 28, 0,  190,  510,  22, 1,  1 },
-		[3] =  { 1, 0,  6,  32, 28, 0,  190,  510,  32, 1,  1 },
-		[4] =  { 1, 0,  9, 255, 28, 0,  323,  343,  13, 1, 32 },
-		[13] = { 1, 0,  7,  32, 28, 0, 3836, 3856,  14, 1,  1 },
-		[14] = { 1, 0,  6,  32, 28, 0,  615, 5010, 110, 1,  1 },
-		[15] = { 1, 1,  0,   0,  0, 0,   15, 5010, 110, 0,  0, 12, 32, 28 },
-	},
-};
-
 static struct mt76_wcid *mt7996_rx_get_wcid(struct mt7996_dev *dev,
 					    u16 idx, u8 band_idx)
 {
@@ -3010,40 +2971,6 @@ static int mt7996_dfs_start_radar_detector(struct mt7996_phy *phy)
 	return err;
 }
 
-static int
-mt7996_dfs_init_radar_specs(struct mt7996_phy *phy)
-{
-	const struct mt7996_dfs_radar_spec *radar_specs;
-	struct mt7996_dev *dev = phy->dev;
-	int err, i;
-
-	switch (dev->mt76.region) {
-	case NL80211_DFS_FCC:
-		radar_specs = &fcc_radar_specs;
-		err = mt7996_mcu_set_fcc5_lpn(dev, 8);
-		if (err < 0)
-			return err;
-		break;
-	case NL80211_DFS_ETSI:
-		radar_specs = &etsi_radar_specs;
-		break;
-	case NL80211_DFS_JP:
-		radar_specs = &jp_radar_specs;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	for (i = 0; i < ARRAY_SIZE(radar_specs->radar_pattern); i++) {
-		err = mt7996_mcu_set_radar_th(dev, i,
-					      &radar_specs->radar_pattern[i]);
-		if (err < 0)
-			return err;
-	}
-
-	return mt7996_mcu_set_pulse_th(dev, &radar_specs->pulse_th);
-}
-
 int mt7996_dfs_init_radar_detector(struct mt7996_phy *phy)
 {
 	struct mt7996_dev *dev = phy->dev;
@@ -3063,10 +2990,6 @@ int mt7996_dfs_init_radar_detector(struct mt7996_phy *phy)
 		goto stop;
 
 	if (prev_state <= MT_DFS_STATE_DISABLED) {
-		err = mt7996_dfs_init_radar_specs(phy);
-		if (err < 0)
-			return err;
-
 		err = mt7996_dfs_start_radar_detector(phy);
 		if (err < 0)
 			return err;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.h b/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
index 4eca37b013fc..70ee30f32f88 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
@@ -37,9 +37,4 @@ struct mt7996_dfs_pattern {
 	u32 min_stgpr_diff;
 } __packed;
 
-struct mt7996_dfs_radar_spec {
-	struct mt7996_dfs_pulse pulse_th;
-	struct mt7996_dfs_pattern radar_pattern[16];
-};
-
 #endif
-- 
2.51.0


