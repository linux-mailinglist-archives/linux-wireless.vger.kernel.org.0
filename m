Return-Path: <linux-wireless+bounces-22973-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC84AB7C5A
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 05:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9200A4A2AD5
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 03:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897951A2396;
	Thu, 15 May 2025 03:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oQ6Uh/+J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CE826ACC
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 03:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747280384; cv=none; b=EtpBWuvEfm5yxeDROPhC9xzKFXTaCa9tt//2kNSIfiacF/qpa7t+5k96SQFlOE4LbdWowuYH7gJsI5UOFij0DayREk2zd5l1IuPD/WuAFWp+2dQphiM4p4V5mX6lf757xqqtLFhElOXyWjj/rh5IcT3fkYIN+bZF5pnhKq7CA1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747280384; c=relaxed/simple;
	bh=pEFTXP6InYRygXeqlAt39QVjLkRTxEZvU9Ehoj7t63Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sCndmu3W4foFjUsA4zh6Fkqg66N3vmFsP81r3TvPAacrqcRpv9LTL3xXQz52MdaEneqi+ZhaBsHCWilqxJB78F1l6iMdbiwPCViOWfj2OgXkA9N2+SMcHZQfA+NfOmfK87EmEz/hsTzIoWZ5rcwja9mNboNXMY9W/n6fHQcuyJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=oQ6Uh/+J; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 38e4e712313e11f0813e4fe1310efc19-20250515
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7E0yGV9fq1bLHyrmBJkJI+P3GpWKwf3pIXly3srXsq4=;
	b=oQ6Uh/+Jk1QqxjmWM62Cnh38ztMijfFQyBtRc9f/bH/3pBTvCvVAQjcloc8KvOL5JMWOm2kTMinoRxuHgmqFIp7tjtKZVpUsZECX5VchoF3w/gDzSaczDxIjDELbA1yVlv+KP8fEZep1fVH6/fLIaEtiiB0DDBzd60HR11haq14=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:d964e6eb-d7a7-4682-9dab-050b4707ac94,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:cb0d01c0-eade-4d5b-9f81-31d7b5452436,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 38e4e712313e11f0813e4fe1310efc19-20250515
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 983383167; Thu, 15 May 2025 11:39:36 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 15 May 2025 11:32:39 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 15 May 2025 11:32:39 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Peter Chiu
	<chui-hao.chiu@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH mt76-next 5/9] wifi: mt76: mt7996: fix invalid NSS setting when TX path differs from NSS
Date: Thu, 15 May 2025 11:29:48 +0800
Message-ID: <20250515032952.1653494-5-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250515032952.1653494-1-shayne.chen@mediatek.com>
References: <20250515032952.1653494-1-shayne.chen@mediatek.com>
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

The maximum TX path and NSS may differ on a band. For example, one variant
of the MT7992 has 5 TX paths and 4 NSS on the 5 GHz band. To address this,
add orig_antenna_mask to record the maximum NSS and prevent setting an
invalid NSS in mt7996_set_antenna().

Fixes: 69d54ce7491d ("wifi: mt76: mt7996: switch to single multi-radio wiphy")
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c | 1 +
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
index 7bfd19ed9594..87c6192b6384 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
@@ -310,6 +310,7 @@ int mt7996_eeprom_parse_hw_cap(struct mt7996_dev *dev, struct mt7996_phy *phy)
 		phy->has_aux_rx = true;
 
 	mphy->antenna_mask = BIT(nss) - 1;
+	phy->orig_antenna_mask = mphy->antenna_mask;
 	mphy->chainmask = (BIT(path) - 1) << dev->chainshift[band_idx];
 	phy->orig_chainmask = mphy->chainmask;
 	dev->chainmask |= mphy->chainmask;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 91c64e3a0860..85c5d76c0c2c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1518,7 +1518,8 @@ mt7996_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 		u8 shift = dev->chainshift[band_idx];
 
 		phy->mt76->chainmask = tx_ant & phy->orig_chainmask;
-		phy->mt76->antenna_mask = phy->mt76->chainmask >> shift;
+		phy->mt76->antenna_mask = (phy->mt76->chainmask >> shift) &
+					  phy->orig_antenna_mask;
 
 		mt76_set_stream_caps(phy->mt76, true);
 		mt7996_set_stream_vht_txbf_caps(phy);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 7c334e319547..c75189a02316 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -312,6 +312,7 @@ struct mt7996_phy {
 	struct mt76_channel_state state_ts;
 
 	u16 orig_chainmask;
+	u16 orig_antenna_mask;
 
 	bool has_aux_rx;
 	bool counter_reset;
-- 
2.39.2


