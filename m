Return-Path: <linux-wireless+bounces-29745-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8C6CBCA97
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 07:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 081B830334CA
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 06:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D6D30BF70;
	Mon, 15 Dec 2025 06:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="J+IVMas2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926FD30C348
	for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 06:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765780691; cv=none; b=TX863WXbkAmYjD7IYx5ZQCO/GqZTvpNN38DY/2rqrSGzrId2Gp1yYD4NsQXKwDT0d4ETmPVgtYY5+ptAozXiXfgZ3PeLIs+RnhLs6PGEDmpunf+EPx1BEv5CZPploQWQTKRVIXvwnhkbIp8fh/rD+t/bpWYvpG5+8fsCyYSHkEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765780691; c=relaxed/simple;
	bh=bumaKXlWqPb+TnXBhTAqciy9UukhUK6pownfLx4Q5pE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+SIed+vigbg4wWSgNhFhx6cONEpWImhOvYqvHd3wqA3AMrvGQ/ud1XvgjXhbbARDv7fOb9TfFsPUPuHvRMVdK7ND5LJlsZlzguISA+EBtS9b5jTWIz0G1lVrxK/WdUX3KpAIOUenetFocbaTiF6AI+pg1Vhw4RR64nuPgcpzDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=J+IVMas2; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 99d4d34ed98011f0b33aeb1e7f16c2b6-20251215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=T5SgYK0+rW24UTe1Vrv4M6KH0lbs8UAljb0cZks467Q=;
	b=J+IVMas2cQV4EHhF0s78+5jyk7ZkaBHIbO4hku9ArMbPE73pEtiB7j0nWSdEnCt5YYyYg/Uj+knx/Taq15Zhy+gxKj98LulAxh1vaoPsJZfOQWp6ogE7GDu1dyo7+jLTaewWE+8pAS2yUqzqjBDAxc0yJYalDUtDPArLTwq2g3A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:220b4f9d-b5e7-436e-ad09-f0f615252e8a,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:b87ac602-1fa9-44eb-b231-4afc61466396,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 99d4d34ed98011f0b33aeb1e7f16c2b6-20251215
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1616486807; Mon, 15 Dec 2025 14:38:00 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 14:37:59 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 15 Dec 2025 14:37:59 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, StanleyYP Wang
	<StanleyYP.Wang@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH mt76 v2 2/7] wifi: mt76: mt7996: fix the behavior of radar detection
Date: Mon, 15 Dec 2025 14:37:23 +0800
Message-ID: <20251215063728.3013365-2-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251215063728.3013365-1-shayne.chen@mediatek.com>
References: <20251215063728.3013365-1-shayne.chen@mediatek.com>
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

RDD_DET_MODE is a firmware command intended for testing and does not
pause TX after radar detection, so remove it from the normal flow;
instead, use the MAC_ENABLE_CTRL firmware command to resume TX after
the radar-triggered channel switch completes.

Fixes: 1529e335f93d ("wifi: mt76: mt7996: rework radar HWRDD idx")
Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
---
v2:
  - check return value before setting rdd_tx_paused to false
---
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |  8 +--
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 20 ++++++++
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 49 ++++++++++++++++---
 .../net/wireless/mediatek/mt76/mt7996/mcu.h   |  1 +
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  2 +
 5 files changed, 68 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 2560e2f46e89..ce85d8f1bde6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2973,7 +2973,7 @@ static void mt7996_dfs_stop_radar_detector(struct mt7996_phy *phy)
 
 static int mt7996_dfs_start_rdd(struct mt7996_dev *dev, int rdd_idx)
 {
-	int err, region;
+	int region;
 
 	switch (dev->mt76.region) {
 	case NL80211_DFS_ETSI:
@@ -2988,11 +2988,7 @@ static int mt7996_dfs_start_rdd(struct mt7996_dev *dev, int rdd_idx)
 		break;
 	}
 
-	err = mt7996_mcu_rdd_cmd(dev, RDD_START, rdd_idx, region);
-	if (err < 0)
-		return err;
-
-	return mt7996_mcu_rdd_cmd(dev, RDD_DET_MODE, rdd_idx, 1);
+	return mt7996_mcu_rdd_cmd(dev, RDD_START, rdd_idx, region);
 }
 
 static int mt7996_dfs_start_radar_detector(struct mt7996_phy *phy)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 9b4bfb071292..18c6cdaae20b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -79,6 +79,7 @@ static void mt7996_stop_phy(struct mt7996_phy *phy)
 
 	mutex_lock(&dev->mt76.mutex);
 
+	mt7996_mcu_rdd_resume_tx(phy);
 	mt7996_mcu_set_radio_en(phy, false);
 
 	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
@@ -954,6 +955,24 @@ mt7996_channel_switch_beacon(struct ieee80211_hw *hw,
 	mutex_unlock(&dev->mt76.mutex);
 }
 
+static int
+mt7996_post_channel_switch(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			   struct ieee80211_bss_conf *link_conf)
+{
+	struct cfg80211_chan_def *chandef = &link_conf->chanreq.oper;
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_phy *phy = mt7996_band_phy(dev, chandef->chan->band);
+	int ret;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	ret = mt7996_mcu_rdd_resume_tx(phy);
+
+	mutex_unlock(&dev->mt76.mutex);
+
+	return ret;
+}
+
 static int
 mt7996_mac_sta_init_link(struct mt7996_dev *dev,
 			 struct ieee80211_bss_conf *link_conf,
@@ -2327,6 +2346,7 @@ const struct ieee80211_ops mt7996_ops = {
 	.release_buffered_frames = mt76_release_buffered_frames,
 	.get_txpower = mt7996_get_txpower,
 	.channel_switch_beacon = mt7996_channel_switch_beacon,
+	.post_channel_switch = mt7996_post_channel_switch,
 	.get_stats = mt7996_get_stats,
 	.get_et_sset_count = mt7996_get_et_sset_count,
 	.get_et_stats = mt7996_get_et_stats,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 7be03bbf34d4..81d09d0e924f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -520,24 +520,32 @@ mt7996_mcu_rx_radar_detected(struct mt7996_dev *dev, struct sk_buff *skb)
 		break;
 	case MT_RDD_IDX_BACKGROUND:
 		if (!dev->rdd2_phy)
-			return;
+			goto err;
 		mphy = dev->rdd2_phy->mt76;
 		break;
 	default:
-		dev_err(dev->mt76.dev, "Unknown RDD idx %d\n", r->rdd_idx);
-		return;
+		goto err;
 	}
 
 	if (!mphy)
-		return;
+		goto err;
 
-	if (r->rdd_idx == MT_RDD_IDX_BACKGROUND)
+	if (r->rdd_idx == MT_RDD_IDX_BACKGROUND) {
 		cfg80211_background_radar_event(mphy->hw->wiphy,
 						&dev->rdd2_chandef,
 						GFP_ATOMIC);
-	else
+	} else {
+		struct mt7996_phy *phy = mphy->priv;
+
+		phy->rdd_tx_paused = true;
 		ieee80211_radar_detected(mphy->hw, NULL);
+	}
 	dev->hw_pattern++;
+
+	return;
+
+err:
+	dev_err(dev->mt76.dev, "Invalid RDD idx %d\n", r->rdd_idx);
 }
 
 static void
@@ -4610,6 +4618,35 @@ int mt7996_mcu_set_radio_en(struct mt7996_phy *phy, bool enable)
 				 &req, sizeof(req), true);
 }
 
+int mt7996_mcu_rdd_resume_tx(struct mt7996_phy *phy)
+{
+	struct {
+		u8 band_idx;
+		u8 _rsv[3];
+
+		__le16 tag;
+		__le16 len;
+		u8 mac_enable;
+		u8 _rsv2[3];
+	} __packed req = {
+		.band_idx = phy->mt76->band_idx,
+		.tag = cpu_to_le16(UNI_BAND_CONFIG_MAC_ENABLE_CTRL),
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.mac_enable = 2,
+	};
+	int ret;
+
+	if (!phy->rdd_tx_paused)
+		return 0;
+
+	ret = mt76_mcu_send_msg(&phy->dev->mt76, MCU_WM_UNI_CMD(BAND_CONFIG),
+				&req, sizeof(req), true);
+	if (!ret)
+		phy->rdd_tx_paused = false;
+
+	return ret;
+}
+
 int mt7996_mcu_rdd_cmd(struct mt7996_dev *dev, int cmd, u8 rdd_idx, u8 val)
 {
 	struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index fc8b09e76f01..5b3597ca79be 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -835,6 +835,7 @@ enum {
 enum {
 	UNI_BAND_CONFIG_RADIO_ENABLE,
 	UNI_BAND_CONFIG_RTS_THRESHOLD = 0x08,
+	UNI_BAND_CONFIG_MAC_ENABLE_CTRL = 0x0c,
 };
 
 enum {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 7a884311800e..d31864f973cc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -377,6 +377,7 @@ struct mt7996_phy {
 
 	bool has_aux_rx;
 	bool counter_reset;
+	bool rdd_tx_paused;
 };
 
 struct mt7996_dev {
@@ -726,6 +727,7 @@ int mt7996_mcu_get_temperature(struct mt7996_phy *phy);
 int mt7996_mcu_set_thermal_throttling(struct mt7996_phy *phy, u8 state);
 int mt7996_mcu_set_thermal_protect(struct mt7996_phy *phy, bool enable);
 int mt7996_mcu_set_txpower_sku(struct mt7996_phy *phy);
+int mt7996_mcu_rdd_resume_tx(struct mt7996_phy *phy);
 int mt7996_mcu_rdd_cmd(struct mt7996_dev *dev, int cmd, u8 rdd_idx, u8 val);
 int mt7996_mcu_rdd_background_enable(struct mt7996_phy *phy,
 				     struct cfg80211_chan_def *chandef);
-- 
2.51.0


