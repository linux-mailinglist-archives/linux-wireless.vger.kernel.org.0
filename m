Return-Path: <linux-wireless+bounces-22967-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA8EAB7C50
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 05:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10AE98C09E6
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 03:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8F229291C;
	Thu, 15 May 2025 03:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GNAVBstC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6A214A4DF
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 03:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747279969; cv=none; b=IDqyozHOxDj8jqLjAa8o/ZdvU5NwY8b9vCljPo8blXhy2GOOb90crii/3eDAlgmnSWS26tI1Uku89zC0FicL91/aZJHqnf1xISZfYSJknGumJ75DupXtTv6snxUxDho6sUN+gyzijYVYyNXW+icoCMHXM0sLil4Yrh04K5wC7Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747279969; c=relaxed/simple;
	bh=gGuHHVgm91rpcysBZxhA1aM2O4ETdMXyZD9ns9PELo8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BUNiTgESarl2KExeF9IcFa/jD7elFwUFzHkjzYNmrw5MkKAlnmLkLkkx2YzX9LDvOUco/BS2YYuncOfsujfnuzrciCVd/LJZc5qym1/e2DmZiDz34ZTUnI0TeCiC+bZ8jC0WX5w4An0pRgepTfDujQhYu20QnC71Oeel1VI5Qm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=GNAVBstC; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 420063ea313d11f082f7f7ac98dee637-20250515
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=4CUpM0c/mkxzAKeJ5147M+qVj330e23zN+SJgeyqeu4=;
	b=GNAVBstCSkNwIjNWK/sc6ozdNetVnk/iiVOM2teRzZDuUANTjSYjepUu6fqlMIIpnSyhIYocs2MHfhdx+2nfBpHl7gno1bhQfndBgp+LJOhAK3div7SGIsXr4VSqPWJHP1BG2cFZ77H+dAUlcfcJk3laRZ+90cJV3ezCsVHam8Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:072332db-0394-4a6e-8801-eedf45cc62d4,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:0ef645f,CLOUDID:10acbe97-7410-4084-8094-24619d975b02,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 420063ea313d11f082f7f7ac98dee637-20250515
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 262851899; Thu, 15 May 2025 11:32:41 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
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
	<linux-mediatek@lists.infradead.org>, Shayne Chen <shayne.chen@mediatek.com>,
	StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Subject: [PATCH mt76-next 9/9] wifi: mt76: support power delta calculation for 5 TX paths
Date: Thu, 15 May 2025 11:29:52 +0800
Message-ID: <20250515032952.1653494-9-shayne.chen@mediatek.com>
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

One variant of MT7992 has 5 TX paths, so extend the power delta function
to support it. Also, rename nss_delta to path_delta since the value is
based on the number of TX paths rather tha the number of spatial streams.
(path delta [0.5 dBm] = 10 * log(path number) [dBm] * 2)

Co-developed-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c    | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt76.h        | 8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c  | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 2 +-
 7 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index e9605dc22291..45c8db939d55 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1705,7 +1705,7 @@ s8 mt76_get_power_bound(struct mt76_phy *phy, s8 txpower)
 	int n_chains = hweight16(phy->chainmask);
 
 	txpower = mt76_get_sar_power(phy, phy->chandef.chan, txpower * 2);
-	txpower -= mt76_tx_power_nss_delta(n_chains);
+	txpower -= mt76_tx_power_path_delta(n_chains);
 
 	return txpower;
 }
@@ -1721,7 +1721,7 @@ int mt76_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		return -EINVAL;
 
 	n_chains = hweight16(phy->chainmask);
-	delta = mt76_tx_power_nss_delta(n_chains);
+	delta = mt76_tx_power_path_delta(n_chains);
 	*dbm = DIV_ROUND_UP(phy->txpower_cur + delta, 2);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index d7cd467b812f..7707c51b974e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1386,12 +1386,12 @@ static inline bool mt76_is_skb_pktid(u8 pktid)
 	return pktid >= MT_PACKET_ID_FIRST;
 }
 
-static inline u8 mt76_tx_power_nss_delta(u8 nss)
+static inline u8 mt76_tx_power_path_delta(u8 path)
 {
-	static const u8 nss_delta[4] = { 0, 6, 9, 12 };
-	u8 idx = nss - 1;
+	static const u8 path_delta[5] = { 0, 6, 9, 12, 14 };
+	u8 idx = path - 1;
 
-	return (idx < ARRAY_SIZE(nss_delta)) ? nss_delta[idx] : 0;
+	return (idx < ARRAY_SIZE(path_delta)) ? path_delta[idx] : 0;
 }
 
 static inline bool mt76_testmode_enabled(struct mt76_phy *phy)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 66ba3be27343..aae80005a3c1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -273,7 +273,7 @@ void mt7615_init_txpower(struct mt7615_dev *dev,
 			 struct ieee80211_supported_band *sband)
 {
 	int i, n_chains = hweight8(dev->mphy.antenna_mask), target_chains;
-	int delta_idx, delta = mt76_tx_power_nss_delta(n_chains);
+	int delta_idx, delta = mt76_tx_power_path_delta(n_chains);
 	u8 *eep = (u8 *)dev->mt76.eeprom.data;
 	enum nl80211_band band = sband->band;
 	struct mt76_power_limits limits;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index b8fcd4eb3fbb..4064e193d4de 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2067,7 +2067,7 @@ static void mt7615_mcu_set_txpower_sku(struct mt7615_phy *phy, u8 *sku)
 	};
 
 	tx_power = mt76_get_sar_power(mphy, mphy->chandef.chan, tx_power);
-	tx_power -= mt76_tx_power_nss_delta(n_chains);
+	tx_power -= mt76_tx_power_path_delta(n_chains);
 	tx_power = mt76_get_rate_power_limits(mphy, mphy->chandef.chan,
 					      &limits, tx_power);
 	mphy->txpower_cur = tx_power;
@@ -2084,8 +2084,8 @@ static void mt7615_mcu_set_txpower_sku(struct mt7615_phy *phy, u8 *sku)
 		int delta = 0;
 
 		if (i < n_chains - 1)
-			delta = mt76_tx_power_nss_delta(n_chains) -
-				mt76_tx_power_nss_delta(i + 1);
+			delta = mt76_tx_power_path_delta(n_chains) -
+				mt76_tx_power_path_delta(i + 1);
 		sku[MT_SKU_1SS_DELTA + i] = delta;
 	}
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index be9527dd0269..3e30ca5155d2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -285,7 +285,7 @@ static void __mt7915_init_txpower(struct mt7915_phy *phy,
 {
 	struct mt7915_dev *dev = phy->dev;
 	int i, n_chains = hweight16(phy->mt76->chainmask);
-	int nss_delta = mt76_tx_power_nss_delta(n_chains);
+	int path_delta = mt76_tx_power_path_delta(n_chains);
 	int pwr_delta = mt7915_eeprom_get_power_delta(dev, sband->band);
 	struct mt76_power_limits limits;
 
@@ -305,7 +305,7 @@ static void __mt7915_init_txpower(struct mt7915_phy *phy,
 		target_power = mt76_get_rate_power_limits(phy->mt76, chan,
 							  &limits,
 							  target_power);
-		target_power += nss_delta;
+		target_power += path_delta;
 		target_power = DIV_ROUND_UP(target_power, 2);
 		chan->max_power = min_t(int, chan->max_reg_power,
 					target_power);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 213c7bcd4ade..a9599c286328 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -317,8 +317,8 @@ static void __mt7996_init_txpower(struct mt7996_phy *phy,
 				  struct ieee80211_supported_band *sband)
 {
 	struct mt7996_dev *dev = phy->dev;
-	int i, nss = hweight16(phy->mt76->chainmask);
-	int nss_delta = mt76_tx_power_nss_delta(nss);
+	int i, n_chains = hweight16(phy->mt76->chainmask);
+	int path_delta = mt76_tx_power_path_delta(n_chains);
 	int pwr_delta = mt7996_eeprom_get_power_delta(dev, sband->band);
 	struct mt76_power_limits limits;
 
@@ -330,7 +330,7 @@ static void __mt7996_init_txpower(struct mt7996_phy *phy,
 		target_power = mt76_get_rate_power_limits(phy->mt76, chan,
 							  &limits,
 							  target_power);
-		target_power += nss_delta;
+		target_power += path_delta;
 		target_power = DIV_ROUND_UP(target_power, 2);
 		chan->max_power = min_t(int, chan->max_reg_power,
 					target_power);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 85c5d76c0c2c..970c1f890d56 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -684,7 +684,7 @@ mt7996_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	}
 
 	n_chains = hweight16(phy->mt76->chainmask);
-	delta = mt76_tx_power_nss_delta(n_chains);
+	delta = mt76_tx_power_path_delta(n_chains);
 	*dbm = DIV_ROUND_UP(phy->mt76->txpower_cur + delta, 2);
 
 	return 0;
-- 
2.39.2


