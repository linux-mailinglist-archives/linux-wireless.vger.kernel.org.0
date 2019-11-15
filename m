Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2F27FE0D2
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 16:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfKOPF5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 10:05:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:59204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727406AbfKOPF5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 10:05:57 -0500
Received: from localhost.localdomain.com (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF64420674;
        Fri, 15 Nov 2019 15:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573830356;
        bh=/Sh5Z4U89H6O811BxFoKb26ULZhwlB/3CNdQqzXE27Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w6BqiIegfImT5pFcDYjO3aRiqcBUTHQyOREi3e16npVUgottVU+XV5HA/VdiV036t
         begHAfNAcUmewdE0kLPVKKVwgF1gYLOeuu5r10Cte+PwwdargZV2zw+rCCzT0/ch2e
         P0tLCTJgzbutAGX9YikVN9M317EtZ4g5b+d3qc1E=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH 2/3] mt76: move coverage_class and slottime in mt76_dev
Date:   Fri, 15 Nov 2019 17:05:25 +0200
Message-Id: <b9f6f1ff8428ba9b76244ff99b22d9949b6fabf7.1573828743.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1573828743.git.lorenzo@kernel.org>
References: <cover.1573828743.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move coverage_class and slottime fields from driver specific data
structure to mt76_dev since they are used by all drivers

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h          |  3 +++
 drivers/net/wireless/mediatek/mt76/mt7603/init.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c    |  6 +++---
 drivers/net/wireless/mediatek/mt76/mt7603/main.c   |  6 +++---
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h |  3 ---
 drivers/net/wireless/mediatek/mt76/mt76x02.h       |  3 ---
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c  | 10 +++++-----
 7 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 4116ad7928da..07a1b808a142 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -507,6 +507,9 @@ struct mt76_dev {
 	u8 antenna_mask;
 	u16 chainmask;
 
+	s16 coverage_class;
+	u8 slottime;
+
 	struct tasklet_struct pre_tbtt_tasklet;
 	int beacon_int;
 	u8 beacon_mask;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 0696dbf28c5b..26eaf03baa08 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -539,7 +539,7 @@ int mt7603_register_device(struct mt7603_dev *dev)
 	if (mt76_rr(dev, MT_EFUSE_BASE + 0x64) & BIT(4))
 		dev->mt76.antenna_mask = 1;
 
-	dev->slottime = 9;
+	dev->mt76.slottime = 9;
 
 	ret = mt7603_init_hardware(dev);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 812d081ad943..2c7c69106a20 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -47,7 +47,7 @@ void mt7603_mac_set_timing(struct mt7603_dev *dev)
 		  FIELD_PREP(MT_TIMEOUT_VAL_CCA, 48);
 	u32 ofdm = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, 60) |
 		   FIELD_PREP(MT_TIMEOUT_VAL_CCA, 24);
-	int offset = 3 * dev->coverage_class;
+	int offset = 3 * dev->mt76.coverage_class;
 	u32 reg_offset = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, offset) |
 			 FIELD_PREP(MT_TIMEOUT_VAL_CCA, offset);
 	int sifs;
@@ -68,9 +68,9 @@ void mt7603_mac_set_timing(struct mt7603_dev *dev)
 		FIELD_PREP(MT_IFS_EIFS, 360) |
 		FIELD_PREP(MT_IFS_RIFS, 2) |
 		FIELD_PREP(MT_IFS_SIFS, sifs) |
-		FIELD_PREP(MT_IFS_SLOT, dev->slottime));
+		FIELD_PREP(MT_IFS_SLOT, dev->mt76.slottime));
 
-	if (dev->slottime < 20)
+	if (dev->mt76.slottime < 20)
 		val = MT7603_CFEND_RATE_DEFAULT;
 	else
 		val = MT7603_CFEND_RATE_11B;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 6a6bc37b898f..031526bb23a7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -295,8 +295,8 @@ mt7603_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (changed & BSS_CHANGED_ERP_SLOT) {
 		int slottime = info->use_short_slot ? 9 : 20;
 
-		if (slottime != dev->slottime) {
-			dev->slottime = slottime;
+		if (slottime != dev->mt76.slottime) {
+			dev->mt76.slottime = slottime;
 			mt7603_mac_set_timing(dev);
 		}
 	}
@@ -635,7 +635,7 @@ mt7603_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
 {
 	struct mt7603_dev *dev = hw->priv;
 
-	dev->coverage_class = coverage_class;
+	dev->mt76.coverage_class = coverage_class;
 	mt7603_mac_set_timing(dev);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index ab54b0612e98..930a1bcab0ef 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -118,9 +118,6 @@ struct mt7603_dev {
 	__le32 rx_ampdu_ts;
 	u8 rssi_offset[3];
 
-	u8 slottime;
-	s16 coverage_class;
-
 	s8 tx_power_limit;
 
 	ktime_t ed_time;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index cdc1cbd1d392..d24c44725b1c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -110,9 +110,6 @@ struct mt76x02_dev {
 
 	bool no_2ghz;
 
-	s16 coverage_class;
-	u8 slottime;
-
 	struct mt76x02_dfs_pattern_detector dfs_pd;
 
 	/* edcca monitor */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index c0500d8f9a67..74c6552a9874 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -185,7 +185,7 @@ void mt76x02_init_device(struct mt76x02_dev *dev)
 
 	dev->mt76.global_wcid.idx = 255;
 	dev->mt76.global_wcid.hw_key_idx = -1;
-	dev->slottime = 9;
+	dev->mt76.slottime = 9;
 
 	if (is_mt76x2(dev)) {
 		dev->mt76.sband_2g.sband.ht_cap.cap |=
@@ -522,10 +522,10 @@ EXPORT_SYMBOL_GPL(mt76x02_conf_tx);
 
 void mt76x02_set_tx_ackto(struct mt76x02_dev *dev)
 {
-	u8 ackto, sifs, slottime = dev->slottime;
+	u8 ackto, sifs, slottime = dev->mt76.slottime;
 
 	/* As defined by IEEE 802.11-2007 17.3.8.6 */
-	slottime += 3 * dev->coverage_class;
+	slottime += 3 * dev->mt76.coverage_class;
 	mt76_rmw_field(dev, MT_BKOFF_SLOT_CFG,
 		       MT_BKOFF_SLOT_CFG_SLOTTIME, slottime);
 
@@ -544,7 +544,7 @@ void mt76x02_set_coverage_class(struct ieee80211_hw *hw,
 	struct mt76x02_dev *dev = hw->priv;
 
 	mutex_lock(&dev->mt76.mutex);
-	dev->coverage_class = coverage_class;
+	dev->mt76.coverage_class = coverage_class;
 	mt76x02_set_tx_ackto(dev);
 	mutex_unlock(&dev->mt76.mutex);
 }
@@ -656,7 +656,7 @@ void mt76x02_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_ERP_SLOT) {
 		int slottime = info->use_short_slot ? 9 : 20;
 
-		dev->slottime = slottime;
+		dev->mt76.slottime = slottime;
 		mt76x02_set_tx_ackto(dev);
 	}
 
-- 
2.21.0

