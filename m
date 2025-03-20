Return-Path: <linux-wireless+bounces-20587-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 328D2A69DFE
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 03:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE963A41EC
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 02:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866BC1BD9E3;
	Thu, 20 Mar 2025 01:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DsrAbZfk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64DB70807
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 01:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742435966; cv=none; b=jNNQlgxRAfRtXl8Q0J7iDpykjyLX2xsSNJCb1Ti2rlPcWFbyszoQ+6LVkyvCxe+01b6/vcJ1jziBQ2FX6/O8lX9tIl+OfoN/mWdd/2vGl7u08vfh8r1ZoEJIeiFuLPVV5EeGJXPWhBebeTwkBb5Ptv4qjP3Az1+UkfkTZ7WQzCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742435966; c=relaxed/simple;
	bh=8lLaHUJO9dn54XtL/odgKxkTQxyC8lkRM1RdCTfeQPk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KZXvg+m7AOs+fJOMjFRGQJiwyDjAP3/RfS6M2+ah/MqvJW40qpqAq/74EAN/P7qTkZcKZZzsxyOVSDwYQqAG6OqOx/QqWEvgH0KMKo1wuBhqCCPMllxD3hWpdPPG0gC1izgFSyivQTUKxIXqa9pNjCmNIJT1cT0/N36S+VKu++w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DsrAbZfk; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f07de860052e11f0aae1fd9735fae912-20250320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=d4M9TrzF3z+Kwm0/V6cKZKy99RwFdGVz2mKxi2tNmyM=;
	b=DsrAbZfkZDgsZwvbykNC0ApHPp2YH7Y0ueuRVTM9bBZZCPdJdAaMEfZVXHL8UxUWowzpMykL8HffO/M9vv78NZjwF8AfYGYnQBCzHGAyVGnoc92Ub6xMs3WNlCC7IivpHki1WN73faPLVKCdaxe3najWGyTn2HdORq+Wogy8byw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:c953ab17-8691-49bc-aa38-32f50cda9ff6,IP:0,UR
	L:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-30
X-CID-META: VersionHash:0ef645f,CLOUDID:75a6988c-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:2,IP:nil
	,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f07de860052e11f0aae1fd9735fae912-20250320
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <stanleyyp.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 876861974; Thu, 20 Mar 2025 09:59:20 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 20 Mar 2025 09:59:19 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 20 Mar 2025 09:59:19 +0800
From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Ryder Lee
	<ryder.Lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, StanleyYP Wang
	<StanleyYP.Wang@mediatek.com>
Subject: [PATCH 2/3] wifi: mt76: mt7915: rework radar HWRDD idx
Date: Thu, 20 Mar 2025 09:59:18 +0800
Message-ID: <20250320015918.3948643-1-StanleyYP.Wang@mediatek.com>
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

The definition of MT_RX_SEL (for rdd_rx_sel) is mixed with the
definition of HWRDD idx.
For example, MT_RX_SEL2 is for background HWRDD idx, not an option
of rdd_rx_sel.
Therefore, add mt7915_get_rdd_idx as a helper function to get the
HWRDD idx for each variants.

Additionally, remove some parts of the code inherited from the legacy
chips.
For instance,
1. rdd_state is used for single-band-dual-HWRDD chips (for 80+80),
especially the 76xx series.
2. rdd_rx_sel is also used for single-band-dual-HWRDD chips
rx_sel = 0 => RDD0 for WF0, RDD1 for WF2
rx_sel = 1 => RDD0 for WF1, RDD1 for WF3

Chip Variants                  | 5G rdd idx(=bandidx)| Background rdd idx
-------------------------------|---------------------|-------------------
MT7915A                        | 0                   | 2
MT7915D                        | 1                   | 2
MT7916 2G + 5G (2T2R+1R)       | 1                   | 2
MT7916 2G + 5G (3T3R)          | 1                   | N/A
MT7981 2G + 5G                 | 1                   | N/A
MT7986 2G + 5G (one adie DBDC) | 1                   | N/A
MT7986 5G (one adie)           | 1 (bandidx=MT_BAND1)| N/A
MT7986 2G + 5G (dual adie)     | 1                   | N/A

Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 23 +++++--
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 60 +++++++------------
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 40 +++++++++----
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  2 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    | 22 +++++--
 5 files changed, 87 insertions(+), 60 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 0384e9f519fb..b287b7d9394e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -211,13 +211,28 @@ static const struct file_operations mt7915_sys_recovery_ops = {
 static int
 mt7915_radar_trigger(void *data, u64 val)
 {
-	struct mt7915_dev *dev = data;
+#define RADAR_MAIN_CHAIN	1
+#define RADAR_BACKGROUND	2
+	struct mt7915_phy *phy = data;
+	struct mt7915_dev *dev = phy->dev;
+	int rdd_idx;
+
+	if (!val || val > RADAR_BACKGROUND)
+		return -EINVAL;
 
-	if (val > MT_RX_SEL2)
+	if (val == RADAR_BACKGROUND && !dev->rdd2_phy) {
+		dev_err(dev->mt76.dev, "Background radar is not enabled\n");
 		return -EINVAL;
+	}
+
+	rdd_idx = mt7915_get_rdd_idx(phy, val == RADAR_BACKGROUND);
+	if (rdd_idx < 0) {
+		dev_err(dev->mt76.dev, "No RDD found\n");
+		return -EINVAL;
+	}
 
 	return mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_RADAR_EMULATE,
-				       val, 0, 0);
+				       rdd_idx, 0, 0);
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(fops_radar_trigger, NULL,
@@ -1247,7 +1262,7 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
 	if (!dev->dbdc_support || phy->mt76->band_idx) {
 		debugfs_create_u32("dfs_hw_pattern", 0400, dir,
 				   &dev->hw_pattern);
-		debugfs_create_file("radar_trigger", 0200, dir, dev,
+		debugfs_create_file("radar_trigger", 0200, dir, phy,
 				    &fops_radar_trigger);
 		debugfs_create_devm_seqfile(dev->mt76.dev, "rdd_monitor", dir,
 					    mt7915_rdd_monitor);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 2ba6eb3038ce..9400e4af2a04 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -2035,16 +2035,15 @@ void mt7915_mac_work(struct work_struct *work)
 static void mt7915_dfs_stop_radar_detector(struct mt7915_phy *phy)
 {
 	struct mt7915_dev *dev = phy->dev;
+	int rdd_idx = mt7915_get_rdd_idx(phy, false);
 
-	if (phy->rdd_state & BIT(0))
-		mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_STOP, 0,
-					MT_RX_SEL0, 0);
-	if (phy->rdd_state & BIT(1))
-		mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_STOP, 1,
-					MT_RX_SEL0, 0);
+	if (rdd_idx < 0)
+		return;
+
+	mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_STOP, rdd_idx, 0, 0);
 }
 
-static int mt7915_dfs_start_rdd(struct mt7915_dev *dev, int chain)
+static int mt7915_dfs_start_rdd(struct mt7915_dev *dev, int rdd_idx)
 {
 	int err, region;
 
@@ -2061,52 +2060,38 @@ static int mt7915_dfs_start_rdd(struct mt7915_dev *dev, int chain)
 		break;
 	}
 
-	err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_START, chain,
-				      MT_RX_SEL0, region);
+	err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_START, rdd_idx, 0, region);
 	if (err < 0)
 		return err;
 
 	if (is_mt7915(&dev->mt76)) {
-		err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_SET_WF_ANT, chain,
+		err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_SET_WF_ANT, rdd_idx,
 					      0, dev->dbdc_support ? 2 : 0);
 		if (err < 0)
 			return err;
 	}
 
-	return mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_DET_MODE, chain,
-				       MT_RX_SEL0, 1);
+	return mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_DET_MODE, rdd_idx, 0, 1);
 }
 
 static int mt7915_dfs_start_radar_detector(struct mt7915_phy *phy)
 {
-	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
 	struct mt7915_dev *dev = phy->dev;
-	int err;
+	int err, rdd_idx;
+
+	rdd_idx = mt7915_get_rdd_idx(phy, false);
+	if (rdd_idx < 0)
+		return -EINVAL;
 
 	/* start CAC */
-	err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_CAC_START,
-				      phy->mt76->band_idx, MT_RX_SEL0, 0);
+	err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_CAC_START, rdd_idx, 0, 0);
 	if (err < 0)
 		return err;
 
-	err = mt7915_dfs_start_rdd(dev, phy->mt76->band_idx);
+	err = mt7915_dfs_start_rdd(dev, rdd_idx);
 	if (err < 0)
 		return err;
 
-	phy->rdd_state |= BIT(phy->mt76->band_idx);
-
-	if (!is_mt7915(&dev->mt76))
-		return 0;
-
-	if (chandef->width == NL80211_CHAN_WIDTH_160 ||
-	    chandef->width == NL80211_CHAN_WIDTH_80P80) {
-		err = mt7915_dfs_start_rdd(dev, 1);
-		if (err < 0)
-			return err;
-
-		phy->rdd_state |= BIT(1);
-	}
-
 	return 0;
 }
 
@@ -2148,12 +2133,12 @@ int mt7915_dfs_init_radar_detector(struct mt7915_phy *phy)
 {
 	struct mt7915_dev *dev = phy->dev;
 	enum mt76_dfs_state dfs_state, prev_state;
-	int err;
+	int err, rdd_idx = mt7915_get_rdd_idx(phy, false);
 
 	prev_state = phy->mt76->dfs_state;
 	dfs_state = mt76_phy_dfs_state(phy->mt76);
 
-	if (prev_state == dfs_state)
+	if (prev_state == dfs_state || rdd_idx < 0)
 		return 0;
 
 	if (prev_state == MT_DFS_STATE_UNKNOWN)
@@ -2177,8 +2162,7 @@ int mt7915_dfs_init_radar_detector(struct mt7915_phy *phy)
 	if (dfs_state == MT_DFS_STATE_CAC)
 		return 0;
 
-	err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_CAC_END,
-				      phy->mt76->band_idx, MT_RX_SEL0, 0);
+	err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_CAC_END, rdd_idx, 0, 0);
 	if (err < 0) {
 		phy->mt76->dfs_state = MT_DFS_STATE_UNKNOWN;
 		return err;
@@ -2188,15 +2172,13 @@ int mt7915_dfs_init_radar_detector(struct mt7915_phy *phy)
 	return 0;
 
 stop:
-	err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_NORMAL_START,
-				      phy->mt76->band_idx, MT_RX_SEL0, 0);
+	err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_NORMAL_START, rdd_idx, 0, 0);
 	if (err < 0)
 		return err;
 
 	if (is_mt7915(&dev->mt76)) {
 		err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_SET_WF_ANT,
-					      phy->mt76->band_idx, 0,
-					      dev->dbdc_support ? 2 : 0);
+					      rdd_idx, 0, dev->dbdc_support ? 2 : 0);
 		if (err < 0)
 			return err;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index c9a4c35001dd..427542777abc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -303,17 +303,35 @@ mt7915_mcu_rx_radar_detected(struct mt7915_dev *dev, struct sk_buff *skb)
 {
 	struct mt76_phy *mphy = &dev->mt76.phy;
 	struct mt7915_mcu_rdd_report *r;
+	u32 sku;
 
 	r = (struct mt7915_mcu_rdd_report *)skb->data;
 
-	if (r->band_idx > MT_RX_SEL2)
+	switch (r->rdd_idx) {
+	case MT_RDD_IDX_BAND0:
+		break;
+	case MT_RDD_IDX_BAND1:
+		sku = mt7915_check_adie(dev, true);
+		/* the main phy is bound to band 1 for this sku */
+		if (is_mt7986(&dev->mt76) &&
+		    (sku == MT7975_ONE_ADIE || sku == MT7976_ONE_ADIE))
+			break;
+		mphy = dev->mt76.phys[MT_BAND1];
+		break;
+	case MT_RDD_IDX_BACKGROUND:
+		if (!dev->rdd2_phy)
+			return;
+		mphy = dev->rdd2_phy->mt76;
+		break;
+	default:
+		dev_err(dev->mt76.dev, "Unknown RDD idx %d\n", r->rdd_idx);
 		return;
+	}
 
-	if ((r->band_idx && !dev->phy.mt76->band_idx) &&
-	    dev->mt76.phys[MT_BAND1])
-		mphy = dev->mt76.phys[MT_BAND1];
+	if (!mphy)
+		return;
 
-	if (r->band_idx == MT_RX_SEL2)
+	if (r->rdd_idx == MT_RDD_IDX_BACKGROUND)
 		cfg80211_background_radar_event(mphy->hw->wiphy,
 						&dev->rdd2_chandef,
 						GFP_ATOMIC);
@@ -2697,11 +2715,14 @@ int mt7915_mcu_rdd_background_enable(struct mt7915_phy *phy,
 				     struct cfg80211_chan_def *chandef)
 {
 	struct mt7915_dev *dev = phy->dev;
-	int err, region;
+	int err, region, rdd_idx;
+
+	rdd_idx = mt7915_get_rdd_idx(phy, true);
+	if (rdd_idx < 0)
+		return -EINVAL;
 
 	if (!chandef) { /* disable offchain */
-		err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_STOP, MT_RX_SEL2,
-					      0, 0);
+		err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_STOP, rdd_idx, 0, 0);
 		if (err)
 			return err;
 
@@ -2727,8 +2748,7 @@ int mt7915_mcu_rdd_background_enable(struct mt7915_phy *phy,
 		break;
 	}
 
-	return mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_START, MT_RX_SEL2,
-				       0, region);
+	return mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_START, rdd_idx, 0, region);
 }
 
 int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 092ed504a8f2..086ad89ecd91 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -57,7 +57,7 @@ struct mt7915_mcu_bcc_notify {
 struct mt7915_mcu_rdd_report {
 	struct mt76_connac2_mcu_rxd_hdr rxd;
 
-	u8 band_idx;
+	u8 rdd_idx;
 	u8 long_detected;
 	u8 constant_prf_detected;
 	u8 staggered_prf_detected;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 66bb94192297..2e94347c46d6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -215,8 +215,6 @@ struct mt7915_phy {
 	s16 coverage_class;
 	u8 slottime;
 
-	u8 rdd_state;
-
 	u32 trb_ts;
 
 	u32 rx_ampdu_ts;
@@ -331,10 +329,10 @@ enum {
 	__MT_WFDMA_MAX,
 };
 
-enum {
-	MT_RX_SEL0,
-	MT_RX_SEL1,
-	MT_RX_SEL2, /* monitor chain */
+enum rdd_idx {
+	MT_RDD_IDX_BAND0,	/* RDD idx for band idx 0 (single-band) */
+	MT_RDD_IDX_BAND1,	/* RDD idx for band idx 1 */
+	MT_RDD_IDX_BACKGROUND,	/* RDD idx for background chain */
 };
 
 enum mt7915_rdd_cmd {
@@ -354,6 +352,18 @@ enum mt7915_rdd_cmd {
 	RDD_IRQ_OFF,
 };
 
+static inline int
+mt7915_get_rdd_idx(struct mt7915_phy *phy, bool is_background)
+{
+	if (!phy->mt76->cap.has_5ghz)
+		return -1;
+
+	if (is_background)
+		return MT_RDD_IDX_BACKGROUND;
+
+	return phy->mt76->band_idx;
+}
+
 static inline struct mt7915_phy *
 mt7915_hw_phy(struct ieee80211_hw *hw)
 {
-- 
2.45.2


