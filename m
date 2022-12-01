Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17BF63E86C
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Dec 2022 04:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiLADpC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Nov 2022 22:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiLADpA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Nov 2022 22:45:00 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C189076D
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 19:44:54 -0800 (PST)
X-UUID: f6bbbf0a042a494fb3a4d9bef2ea75f4-20221201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Fj8sUEYOvj7Gtp+FNQamJeOLEIUi4ZI+ELpMrzymf1Q=;
        b=PyHpezJQu4E/4rzKGjnvctw65ju9m8ntDqLnPuXnQiwSnf88M9mBuYDQK51tXc0fwYZUbfuTHnCyQXWbhA+SR9nGN4gl99d/ARGKHjZM9W00IP8gC2l/2SDeoPgvQGOWomsYbHdMfi04McCNJ/MKY4lQVDWUtosQMUKDSLRI3SE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:808329f0-841d-45a9-a42a-5f50be7e2131,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.14,REQID:808329f0-841d-45a9-a42a-5f50be7e2131,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:dcaaed0,CLOUDID:e9aa376c-41fe-47b6-8eb4-ec192dedaf7d,B
        ulkID:221201114448Y3GE2TQB,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: f6bbbf0a042a494fb3a4d9bef2ea75f4-20221201
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 738101267; Thu, 01 Dec 2022 11:44:47 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 1 Dec 2022 11:44:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 1 Dec 2022 11:44:46 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/5] wifi: mt76: mt7915: rely on band_idx of mt76_phy
Date:   Thu, 1 Dec 2022 11:44:41 +0800
Message-ID: <0ddb72ddf4051213de4eb9431d6edfa6ec19da73.1669861862.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <d1c11adff6b57c9104bb16df19f62700e2505473.1669861862.git.ryder.lee@mediatek.com>
References: <d1c11adff6b57c9104bb16df19f62700e2505473.1669861862.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The commit dc44c45c8cd0 added band_idx into mt76_phy, so switching to
rely on that.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  14 +-
 .../net/wireless/mediatek/mt76/mt7915/dma.c   |  12 +-
 .../wireless/mediatek/mt76/mt7915/eeprom.c    |  14 +-
 .../net/wireless/mediatek/mt76/mt7915/init.c  |   6 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 150 +++++++++---------
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  46 +++---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  48 +++---
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |   8 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   1 -
 .../wireless/mediatek/mt76/mt7915/testmode.c  |  49 +++---
 10 files changed, 183 insertions(+), 165 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index fef0ec83185b..4f1d5fe58eab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -51,7 +51,7 @@ mt7915_sys_recovery_set(struct file *file, const char __user *user_buf,
 {
 	struct mt7915_phy *phy = file->private_data;
 	struct mt7915_dev *dev = phy->dev;
-	bool band = phy->band_idx;
+	bool band = phy->mt76->band_idx;
 	char buf[16];
 	int ret = 0;
 	u16 val;
@@ -692,15 +692,16 @@ mt7915_ampdu_stat_read_phy(struct mt7915_phy *phy,
 	struct mt7915_dev *dev = phy->dev;
 	bool ext_phy = phy != &dev->phy;
 	int bound[15], range[4], i;
+	u8 band = phy->mt76->band_idx;
 
 	/* Tx ampdu stat */
 	for (i = 0; i < ARRAY_SIZE(range); i++)
-		range[i] = mt76_rr(dev, MT_MIB_ARNG(phy->band_idx, i));
+		range[i] = mt76_rr(dev, MT_MIB_ARNG(band, i));
 
 	for (i = 0; i < ARRAY_SIZE(bound); i++)
 		bound[i] = MT_MIB_ARNCR_RANGE(range[i / 4], i % 4) + 1;
 
-	seq_printf(file, "\nPhy %d, Phy band %d\n", ext_phy, phy->band_idx);
+	seq_printf(file, "\nPhy %d, Phy band %d\n", ext_phy, band);
 
 	seq_printf(file, "Length: %8d | ", bound[0]);
 	for (i = 0; i < ARRAY_SIZE(bound) - 1; i++)
@@ -969,6 +970,7 @@ mt7915_rate_txpower_show(struct seq_file *file, void *data)
 	struct mt7915_phy *phy = file->private;
 	struct mt7915_dev *dev = phy->dev;
 	s8 txpower[MT7915_SKU_RATE_NUM], *buf;
+	u8 band = phy->mt76->band_idx;
 	u32 reg;
 	int i, ret;
 
@@ -989,8 +991,8 @@ mt7915_rate_txpower_show(struct seq_file *file, void *data)
 		buf += mt7915_sku_group_len[i];
 	}
 
-	reg = is_mt7915(&dev->mt76) ? MT_WF_PHY_TPC_CTRL_STAT(phy->band_idx) :
-	      MT_WF_PHY_TPC_CTRL_STAT_MT7916(phy->band_idx);
+	reg = is_mt7915(&dev->mt76) ? MT_WF_PHY_TPC_CTRL_STAT(band) :
+	      MT_WF_PHY_TPC_CTRL_STAT_MT7916(band);
 
 	seq_printf(file, "\nBaseband transmit power %ld\n",
 		   mt76_get_field(dev, reg, MT_WF_PHY_TPC_POWER));
@@ -1091,7 +1093,7 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
 				    mt7915_twt_stats);
 	debugfs_create_file("rf_regval", 0600, dir, dev, &fops_rf_regval);
 
-	if (!dev->dbdc_support || phy->band_idx) {
+	if (!dev->dbdc_support || phy->mt76->band_idx) {
 		debugfs_create_u32("dfs_hw_pattern", 0400, dir,
 				   &dev->hw_pattern);
 		debugfs_create_file("radar_trigger", 0200, dir, dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index ae5be28fdd9d..e3fa064918bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -353,10 +353,10 @@ static int mt7915_dma_enable(struct mt7915_dev *dev)
 		   MT_INT_TX_DONE_MCU |
 		   MT_INT_MCU_CMD;
 
-	if (!dev->phy.band_idx)
+	if (!dev->phy.mt76->band_idx)
 		irq_mask |= MT_INT_BAND0_RX_DONE;
 
-	if (dev->dbdc_support || dev->phy.band_idx)
+	if (dev->dbdc_support || dev->phy.mt76->band_idx)
 		irq_mask |= MT_INT_BAND1_RX_DONE;
 
 	if (mtk_wed_device_active(&dev->mt76.mmio.wed)) {
@@ -418,7 +418,7 @@ int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2)
 
 	/* init tx queue */
 	ret = mt7915_init_tx_queues(&dev->phy,
-				    MT_TXQ_ID(dev->phy.band_idx),
+				    MT_TXQ_ID(dev->phy.mt76->band_idx),
 				    MT7915_TX_RING_SIZE,
 				    MT_TXQ_RING_BASE(0));
 	if (ret)
@@ -426,7 +426,7 @@ int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2)
 
 	if (phy2) {
 		ret = mt7915_init_tx_queues(phy2,
-					    MT_TXQ_ID(phy2->band_idx),
+					    MT_TXQ_ID(phy2->mt76->band_idx),
 					    MT7915_TX_RING_SIZE,
 					    MT_TXQ_RING_BASE(1));
 		if (ret)
@@ -482,7 +482,7 @@ int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2)
 		return ret;
 
 	/* rx data queue for band0 */
-	if (!dev->phy.band_idx) {
+	if (!dev->phy.mt76->band_idx) {
 		if (mtk_wed_device_active(&mdev->mmio.wed) &&
 		    mtk_wed_get_rx_capa(&mdev->mmio.wed)) {
 			dev->mt76.q_rx[MT_RXQ_MAIN].flags =
@@ -519,7 +519,7 @@ int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2)
 			return ret;
 	}
 
-	if (dev->dbdc_support || dev->phy.band_idx) {
+	if (dev->dbdc_support || dev->phy.mt76->band_idx) {
 		if (mtk_wed_device_active(&mdev->mmio.wed) &&
 		    mtk_wed_get_rx_capa(&mdev->mmio.wed)) {
 			dev->mt76.q_rx[MT_RXQ_BAND1].flags =
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 0bce0ce51be0..59069fb86414 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -131,9 +131,10 @@ static void mt7915_eeprom_parse_band_config(struct mt7915_phy *phy)
 {
 	struct mt7915_dev *dev = phy->dev;
 	u8 *eeprom = dev->mt76.eeprom.data;
+	u8 band = phy->mt76->band_idx;
 	u32 val;
 
-	val = eeprom[MT_EE_WIFI_CONF + phy->band_idx];
+	val = eeprom[MT_EE_WIFI_CONF + band];
 	val = FIELD_GET(MT_EE_WIFI_CONF0_BAND_SEL, val);
 
 	if (!is_mt7915(&dev->mt76)) {
@@ -153,7 +154,7 @@ static void mt7915_eeprom_parse_band_config(struct mt7915_phy *phy)
 			return;
 		}
 	} else if (val == MT_EE_BAND_SEL_DEFAULT && dev->dbdc_support) {
-		val = phy->band_idx ? MT_EE_BAND_SEL_5GHZ : MT_EE_BAND_SEL_2GHZ;
+		val = band ? MT_EE_BAND_SEL_5GHZ : MT_EE_BAND_SEL_2GHZ;
 	}
 
 	switch (val) {
@@ -175,6 +176,7 @@ void mt7915_eeprom_parse_hw_cap(struct mt7915_dev *dev,
 {
 	u8 path, nss, nss_max = 4, *eeprom = dev->mt76.eeprom.data;
 	struct mt76_phy *mphy = phy->mt76;
+	u8 band = phy->mt76->band_idx;
 
 	mt7915_eeprom_parse_band_config(phy);
 
@@ -184,7 +186,7 @@ void mt7915_eeprom_parse_hw_cap(struct mt7915_dev *dev,
 				 eeprom[MT_EE_WIFI_CONF]);
 	} else {
 		path = FIELD_GET(MT_EE_WIFI_CONF0_TX_PATH,
-				 eeprom[MT_EE_WIFI_CONF + phy->band_idx]);
+				 eeprom[MT_EE_WIFI_CONF + band]);
 	}
 
 	if (!path || path > 4)
@@ -197,12 +199,12 @@ void mt7915_eeprom_parse_hw_cap(struct mt7915_dev *dev,
 			path = min_t(u8, path, 2);
 			nss = FIELD_GET(MT_EE_WIFI_CONF3_TX_PATH_B0,
 					eeprom[MT_EE_WIFI_CONF + 3]);
-			if (phy->band_idx)
+			if (band)
 				nss = FIELD_GET(MT_EE_WIFI_CONF3_TX_PATH_B1,
 						eeprom[MT_EE_WIFI_CONF + 3]);
 		} else {
 			nss = FIELD_GET(MT_EE_WIFI_CONF_STREAM_NUM,
-					eeprom[MT_EE_WIFI_CONF + 2 + phy->band_idx]);
+					eeprom[MT_EE_WIFI_CONF + 2 + band]);
 		}
 
 		if (!is_mt7986(&dev->mt76))
@@ -214,7 +216,7 @@ void mt7915_eeprom_parse_hw_cap(struct mt7915_dev *dev,
 	nss = min_t(u8, min_t(u8, nss_max, nss), path);
 
 	mphy->chainmask = BIT(path) - 1;
-	if (phy->band_idx)
+	if (band)
 		mphy->chainmask <<= dev->chainshift;
 	mphy->antenna_mask = BIT(nss) - 1;
 	dev->chainmask |= mphy->chainmask;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 79bd7bf93f33..c810c31fbd6e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -540,7 +540,7 @@ mt7915_alloc_ext_phy(struct mt7915_dev *dev)
 	phy->mt76 = mphy;
 
 	/* Bind main phy to band0 and ext_phy to band1 for dbdc case */
-	phy->band_idx = 1;
+	phy->mt76->band_idx = 1;
 
 	return phy;
 }
@@ -660,7 +660,7 @@ static bool mt7915_band_config(struct mt7915_dev *dev)
 {
 	bool ret = true;
 
-	dev->phy.band_idx = 0;
+	dev->phy.mt76->band_idx = 0;
 
 	if (is_mt7986(&dev->mt76)) {
 		u32 sku = mt7915_check_adie(dev, true);
@@ -671,7 +671,7 @@ static bool mt7915_band_config(struct mt7915_dev *dev)
 		 * dbdc is disabled.
 		 */
 		if (sku == MT7975_ONE_ADIE || sku == MT7976_ONE_ADIE) {
-			dev->phy.band_idx = 1;
+			dev->phy.mt76->band_idx = 1;
 			ret = false;
 		}
 	} else {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index eac3008225b0..f0d5a3603902 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -302,7 +302,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb,
 
 	memset(status, 0, sizeof(*status));
 
-	if ((rxd1 & MT_RXD1_NORMAL_BAND_IDX) && !phy->band_idx) {
+	if ((rxd1 & MT_RXD1_NORMAL_BAND_IDX) && !phy->mt76->band_idx) {
 		mphy = dev->mt76.phys[MT_BAND1];
 		if (!mphy)
 			return -EINVAL;
@@ -575,7 +575,7 @@ mt7915_mac_fill_rx_vector(struct mt7915_dev *dev, struct sk_buff *skb)
 	int i;
 
 	band_idx = le32_get_bits(rxv_hdr[1], MT_RXV_HDR_BAND_IDX);
-	if (band_idx && !phy->band_idx) {
+	if (band_idx && !phy->mt76->band_idx) {
 		phy = mt7915_ext_phy(dev);
 		if (!phy)
 			goto out;
@@ -1175,7 +1175,7 @@ void mt7915_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 void mt7915_mac_cca_stats_reset(struct mt7915_phy *phy)
 {
 	struct mt7915_dev *dev = phy->dev;
-	u32 reg = MT_WF_PHY_RX_CTRL1(phy->band_idx);
+	u32 reg = MT_WF_PHY_RX_CTRL1(phy->mt76->band_idx);
 
 	mt76_clear(dev, reg, MT_WF_PHY_RX_CTRL1_STSCNT_EN);
 	mt76_set(dev, reg, BIT(11) | BIT(9));
@@ -1187,15 +1187,15 @@ void mt7915_mac_reset_counters(struct mt7915_phy *phy)
 	int i;
 
 	for (i = 0; i < 4; i++) {
-		mt76_rr(dev, MT_TX_AGG_CNT(phy->band_idx, i));
-		mt76_rr(dev, MT_TX_AGG_CNT2(phy->band_idx, i));
+		mt76_rr(dev, MT_TX_AGG_CNT(phy->mt76->band_idx, i));
+		mt76_rr(dev, MT_TX_AGG_CNT2(phy->mt76->band_idx, i));
 	}
 
 	phy->mt76->survey_time = ktime_get_boottime();
 	memset(phy->mt76->aggr_stats, 0, sizeof(phy->mt76->aggr_stats));
 
 	/* reset airtime counters */
-	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0(phy->band_idx),
+	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0(phy->mt76->band_idx),
 		 MT_WF_RMAC_MIB_RXTIME_CLR);
 
 	mt7915_mcu_get_chan_mib_info(phy, true);
@@ -1211,6 +1211,7 @@ void mt7915_mac_set_timing(struct mt7915_phy *phy)
 		  FIELD_PREP(MT_TIMEOUT_VAL_CCA, 48);
 	u32 ofdm = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, 60) |
 		   FIELD_PREP(MT_TIMEOUT_VAL_CCA, 28);
+	u8 band = phy->mt76->band_idx;
 	int eifs_ofdm = 360, sifs = 10, offset;
 	bool a_band = !(phy->mt76->chandef.chan->band == NL80211_BAND_2GHZ);
 
@@ -1221,7 +1222,7 @@ void mt7915_mac_set_timing(struct mt7915_phy *phy)
 		coverage_class = max_t(s16, dev->phy.coverage_class,
 				       ext_phy->coverage_class);
 
-	mt76_set(dev, MT_ARB_SCR(phy->band_idx),
+	mt76_set(dev, MT_ARB_SCR(band),
 		 MT_ARB_SCR_TX_DISABLE | MT_ARB_SCR_RX_DISABLE);
 	udelay(1);
 
@@ -1231,7 +1232,7 @@ void mt7915_mac_set_timing(struct mt7915_phy *phy)
 
 	if (!is_mt7915(&dev->mt76)) {
 		if (!a_band) {
-			mt76_wr(dev, MT_TMAC_ICR1(phy->band_idx),
+			mt76_wr(dev, MT_TMAC_ICR1(band),
 				FIELD_PREP(MT_IFS_EIFS_CCK, 314));
 			eifs_ofdm = 78;
 		} else {
@@ -1241,9 +1242,9 @@ void mt7915_mac_set_timing(struct mt7915_phy *phy)
 		sifs = 16;
 	}
 
-	mt76_wr(dev, MT_TMAC_CDTR(phy->band_idx), cck + reg_offset);
-	mt76_wr(dev, MT_TMAC_ODTR(phy->band_idx), ofdm + reg_offset);
-	mt76_wr(dev, MT_TMAC_ICR0(phy->band_idx),
+	mt76_wr(dev, MT_TMAC_CDTR(band), cck + reg_offset);
+	mt76_wr(dev, MT_TMAC_ODTR(band), ofdm + reg_offset);
+	mt76_wr(dev, MT_TMAC_ICR0(band),
 		FIELD_PREP(MT_IFS_EIFS_OFDM, eifs_ofdm) |
 		FIELD_PREP(MT_IFS_RIFS, 2) |
 		FIELD_PREP(MT_IFS_SIFS, sifs) |
@@ -1254,8 +1255,8 @@ void mt7915_mac_set_timing(struct mt7915_phy *phy)
 	else
 		val = MT7915_CFEND_RATE_11B;
 
-	mt76_rmw_field(dev, MT_AGG_ACR0(phy->band_idx), MT_AGG_ACR_CFEND_RATE, val);
-	mt76_clear(dev, MT_ARB_SCR(phy->band_idx),
+	mt76_rmw_field(dev, MT_AGG_ACR0(band), MT_AGG_ACR_CFEND_RATE, val);
+	mt76_clear(dev, MT_ARB_SCR(band),
 		   MT_ARB_SCR_TX_DISABLE | MT_ARB_SCR_RX_DISABLE);
 }
 
@@ -1308,7 +1309,7 @@ void mt7915_update_channel(struct mt76_phy *mphy)
 
 	mt7915_mcu_get_chan_mib_info(phy, false);
 
-	nf = mt7915_phy_get_nf(phy, phy->band_idx);
+	nf = mt7915_phy_get_nf(phy, phy->mt76->band_idx);
 	if (!phy->noise)
 		phy->noise = nf << 4;
 	else if (nf)
@@ -1751,127 +1752,128 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 	struct mt7915_dev *dev = phy->dev;
 	struct mib_stats *mib = &phy->mib;
 	int i, aggr0 = 0, aggr1, cnt;
+	u8 band = phy->mt76->band_idx;
 	u32 val;
 
-	cnt = mt76_rr(dev, MT_MIB_SDR3(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_SDR3(band));
 	mib->fcs_err_cnt += is_mt7915(&dev->mt76) ?
 		FIELD_GET(MT_MIB_SDR3_FCS_ERR_MASK, cnt) :
 		FIELD_GET(MT_MIB_SDR3_FCS_ERR_MASK_MT7916, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR4(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_SDR4(band));
 	mib->rx_fifo_full_cnt += FIELD_GET(MT_MIB_SDR4_RX_FIFO_FULL_MASK, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR5(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_SDR5(band));
 	mib->rx_mpdu_cnt += cnt;
 
-	cnt = mt76_rr(dev, MT_MIB_SDR6(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_SDR6(band));
 	mib->channel_idle_cnt += FIELD_GET(MT_MIB_SDR6_CHANNEL_IDL_CNT_MASK, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR7(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_SDR7(band));
 	mib->rx_vector_mismatch_cnt +=
 		FIELD_GET(MT_MIB_SDR7_RX_VECTOR_MISMATCH_CNT_MASK, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR8(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_SDR8(band));
 	mib->rx_delimiter_fail_cnt +=
 		FIELD_GET(MT_MIB_SDR8_RX_DELIMITER_FAIL_CNT_MASK, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR10(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_SDR10(band));
 	mib->rx_mrdy_cnt += is_mt7915(&dev->mt76) ?
 		FIELD_GET(MT_MIB_SDR10_MRDY_COUNT_MASK, cnt) :
 		FIELD_GET(MT_MIB_SDR10_MRDY_COUNT_MASK_MT7916, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR11(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_SDR11(band));
 	mib->rx_len_mismatch_cnt +=
 		FIELD_GET(MT_MIB_SDR11_RX_LEN_MISMATCH_CNT_MASK, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR12(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_SDR12(band));
 	mib->tx_ampdu_cnt += cnt;
 
-	cnt = mt76_rr(dev, MT_MIB_SDR13(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_SDR13(band));
 	mib->tx_stop_q_empty_cnt +=
 		FIELD_GET(MT_MIB_SDR13_TX_STOP_Q_EMPTY_CNT_MASK, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR14(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_SDR14(band));
 	mib->tx_mpdu_attempts_cnt += is_mt7915(&dev->mt76) ?
 		FIELD_GET(MT_MIB_SDR14_TX_MPDU_ATTEMPTS_CNT_MASK, cnt) :
 		FIELD_GET(MT_MIB_SDR14_TX_MPDU_ATTEMPTS_CNT_MASK_MT7916, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR15(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_SDR15(band));
 	mib->tx_mpdu_success_cnt += is_mt7915(&dev->mt76) ?
 		FIELD_GET(MT_MIB_SDR15_TX_MPDU_SUCCESS_CNT_MASK, cnt) :
 		FIELD_GET(MT_MIB_SDR15_TX_MPDU_SUCCESS_CNT_MASK_MT7916, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR16(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_SDR16(band));
 	mib->primary_cca_busy_time +=
 		FIELD_GET(MT_MIB_SDR16_PRIMARY_CCA_BUSY_TIME_MASK, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR17(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_SDR17(band));
 	mib->secondary_cca_busy_time +=
 		FIELD_GET(MT_MIB_SDR17_SECONDARY_CCA_BUSY_TIME_MASK, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR18(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_SDR18(band));
 	mib->primary_energy_detect_time +=
 		FIELD_GET(MT_MIB_SDR18_PRIMARY_ENERGY_DETECT_TIME_MASK, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR19(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_SDR19(band));
 	mib->cck_mdrdy_time += FIELD_GET(MT_MIB_SDR19_CCK_MDRDY_TIME_MASK, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR20(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_SDR20(band));
 	mib->ofdm_mdrdy_time +=
 		FIELD_GET(MT_MIB_SDR20_OFDM_VHT_MDRDY_TIME_MASK, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR21(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_SDR21(band));
 	mib->green_mdrdy_time +=
 		FIELD_GET(MT_MIB_SDR21_GREEN_MDRDY_TIME_MASK, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR22(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_SDR22(band));
 	mib->rx_ampdu_cnt += cnt;
 
-	cnt = mt76_rr(dev, MT_MIB_SDR23(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_SDR23(band));
 	mib->rx_ampdu_bytes_cnt += cnt;
 
-	cnt = mt76_rr(dev, MT_MIB_SDR24(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_SDR24(band));
 	mib->rx_ampdu_valid_subframe_cnt += is_mt7915(&dev->mt76) ?
 		FIELD_GET(MT_MIB_SDR24_RX_AMPDU_SF_CNT_MASK, cnt) :
 		FIELD_GET(MT_MIB_SDR24_RX_AMPDU_SF_CNT_MASK_MT7916, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR25(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_SDR25(band));
 	mib->rx_ampdu_valid_subframe_bytes_cnt += cnt;
 
-	cnt = mt76_rr(dev, MT_MIB_SDR27(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_SDR27(band));
 	mib->tx_rwp_fail_cnt +=
 		FIELD_GET(MT_MIB_SDR27_TX_RWP_FAIL_CNT_MASK, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR28(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_SDR28(band));
 	mib->tx_rwp_need_cnt +=
 		FIELD_GET(MT_MIB_SDR28_TX_RWP_NEED_CNT_MASK, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR29(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_SDR29(band));
 	mib->rx_pfdrop_cnt += is_mt7915(&dev->mt76) ?
 		FIELD_GET(MT_MIB_SDR29_RX_PFDROP_CNT_MASK, cnt) :
 		FIELD_GET(MT_MIB_SDR29_RX_PFDROP_CNT_MASK_MT7916, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDRVEC(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_SDRVEC(band));
 	mib->rx_vec_queue_overflow_drop_cnt += is_mt7915(&dev->mt76) ?
 		FIELD_GET(MT_MIB_SDR30_RX_VEC_QUEUE_OVERFLOW_DROP_CNT_MASK, cnt) :
 		FIELD_GET(MT_MIB_SDR30_RX_VEC_QUEUE_OVERFLOW_DROP_CNT_MASK_MT7916, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR31(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_SDR31(band));
 	mib->rx_ba_cnt += cnt;
 
-	cnt = mt76_rr(dev, MT_MIB_SDRMUBF(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_SDRMUBF(band));
 	mib->tx_bf_cnt += FIELD_GET(MT_MIB_MU_BF_TX_CNT, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_DR8(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_DR8(band));
 	mib->tx_mu_mpdu_cnt += cnt;
 
-	cnt = mt76_rr(dev, MT_MIB_DR9(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_DR9(band));
 	mib->tx_mu_acked_mpdu_cnt += cnt;
 
-	cnt = mt76_rr(dev, MT_MIB_DR11(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_DR11(band));
 	mib->tx_su_acked_mpdu_cnt += cnt;
 
-	cnt = mt76_rr(dev, MT_ETBF_PAR_RPT0(phy->band_idx));
+	cnt = mt76_rr(dev, MT_ETBF_PAR_RPT0(band));
 	mib->tx_bf_rx_fb_bw = FIELD_GET(MT_ETBF_PAR_RPT0_FB_BW, cnt);
 	mib->tx_bf_rx_fb_nc_cnt += FIELD_GET(MT_ETBF_PAR_RPT0_FB_NC, cnt);
 	mib->tx_bf_rx_fb_nr_cnt += FIELD_GET(MT_ETBF_PAR_RPT0_FB_NR, cnt);
@@ -1884,41 +1886,41 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 
 	if (is_mt7915(&dev->mt76)) {
 		for (i = 0, aggr1 = aggr0 + 8; i < 4; i++) {
-			val = mt76_rr(dev, MT_MIB_MB_SDR1(phy->band_idx, (i << 4)));
+			val = mt76_rr(dev, MT_MIB_MB_SDR1(band, (i << 4)));
 			mib->ba_miss_cnt +=
 				FIELD_GET(MT_MIB_BA_MISS_COUNT_MASK, val);
 			mib->ack_fail_cnt +=
 				FIELD_GET(MT_MIB_ACK_FAIL_COUNT_MASK, val);
 
-			val = mt76_rr(dev, MT_MIB_MB_SDR0(phy->band_idx, (i << 4)));
+			val = mt76_rr(dev, MT_MIB_MB_SDR0(band, (i << 4)));
 			mib->rts_cnt += FIELD_GET(MT_MIB_RTS_COUNT_MASK, val);
 			mib->rts_retries_cnt +=
 				FIELD_GET(MT_MIB_RTS_RETRIES_COUNT_MASK, val);
 
-			val = mt76_rr(dev, MT_TX_AGG_CNT(phy->band_idx, i));
+			val = mt76_rr(dev, MT_TX_AGG_CNT(band, i));
 			phy->mt76->aggr_stats[aggr0++] += val & 0xffff;
 			phy->mt76->aggr_stats[aggr0++] += val >> 16;
 
-			val = mt76_rr(dev, MT_TX_AGG_CNT2(phy->band_idx, i));
+			val = mt76_rr(dev, MT_TX_AGG_CNT2(band, i));
 			phy->mt76->aggr_stats[aggr1++] += val & 0xffff;
 			phy->mt76->aggr_stats[aggr1++] += val >> 16;
 		}
 
-		cnt = mt76_rr(dev, MT_MIB_SDR32(phy->band_idx));
+		cnt = mt76_rr(dev, MT_MIB_SDR32(band));
 		mib->tx_pkt_ebf_cnt += FIELD_GET(MT_MIB_SDR32_TX_PKT_EBF_CNT, cnt);
 
-		cnt = mt76_rr(dev, MT_MIB_SDR33(phy->band_idx));
+		cnt = mt76_rr(dev, MT_MIB_SDR33(band));
 		mib->tx_pkt_ibf_cnt += FIELD_GET(MT_MIB_SDR33_TX_PKT_IBF_CNT, cnt);
 
-		cnt = mt76_rr(dev, MT_ETBF_TX_APP_CNT(phy->band_idx));
+		cnt = mt76_rr(dev, MT_ETBF_TX_APP_CNT(band));
 		mib->tx_bf_ibf_ppdu_cnt += FIELD_GET(MT_ETBF_TX_IBF_CNT, cnt);
 		mib->tx_bf_ebf_ppdu_cnt += FIELD_GET(MT_ETBF_TX_EBF_CNT, cnt);
 
-		cnt = mt76_rr(dev, MT_ETBF_TX_NDP_BFRP(phy->band_idx));
+		cnt = mt76_rr(dev, MT_ETBF_TX_NDP_BFRP(band));
 		mib->tx_bf_fb_cpl_cnt += FIELD_GET(MT_ETBF_TX_FB_CPL, cnt);
 		mib->tx_bf_fb_trig_cnt += FIELD_GET(MT_ETBF_TX_FB_TRI, cnt);
 
-		cnt = mt76_rr(dev, MT_ETBF_RX_FB_CNT(phy->band_idx));
+		cnt = mt76_rr(dev, MT_ETBF_RX_FB_CNT(band));
 		mib->tx_bf_rx_fb_all_cnt += FIELD_GET(MT_ETBF_RX_FB_ALL, cnt);
 		mib->tx_bf_rx_fb_he_cnt += FIELD_GET(MT_ETBF_RX_FB_HE, cnt);
 		mib->tx_bf_rx_fb_vht_cnt += FIELD_GET(MT_ETBF_RX_FB_VHT, cnt);
@@ -1926,51 +1928,51 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 	} else {
 		for (i = 0; i < 2; i++) {
 			/* rts count */
-			val = mt76_rr(dev, MT_MIB_MB_SDR0(phy->band_idx, (i << 2)));
+			val = mt76_rr(dev, MT_MIB_MB_SDR0(band, (i << 2)));
 			mib->rts_cnt += FIELD_GET(GENMASK(15, 0), val);
 			mib->rts_cnt += FIELD_GET(GENMASK(31, 16), val);
 
 			/* rts retry count */
-			val = mt76_rr(dev, MT_MIB_MB_SDR1(phy->band_idx, (i << 2)));
+			val = mt76_rr(dev, MT_MIB_MB_SDR1(band, (i << 2)));
 			mib->rts_retries_cnt += FIELD_GET(GENMASK(15, 0), val);
 			mib->rts_retries_cnt += FIELD_GET(GENMASK(31, 16), val);
 
 			/* ba miss count */
-			val = mt76_rr(dev, MT_MIB_MB_SDR2(phy->band_idx, (i << 2)));
+			val = mt76_rr(dev, MT_MIB_MB_SDR2(band, (i << 2)));
 			mib->ba_miss_cnt += FIELD_GET(GENMASK(15, 0), val);
 			mib->ba_miss_cnt += FIELD_GET(GENMASK(31, 16), val);
 
 			/* ack fail count */
-			val = mt76_rr(dev, MT_MIB_MB_BFTF(phy->band_idx, (i << 2)));
+			val = mt76_rr(dev, MT_MIB_MB_BFTF(band, (i << 2)));
 			mib->ack_fail_cnt += FIELD_GET(GENMASK(15, 0), val);
 			mib->ack_fail_cnt += FIELD_GET(GENMASK(31, 16), val);
 		}
 
 		for (i = 0; i < 8; i++) {
-			val = mt76_rr(dev, MT_TX_AGG_CNT(phy->band_idx, i));
+			val = mt76_rr(dev, MT_TX_AGG_CNT(band, i));
 			phy->mt76->aggr_stats[aggr0++] += FIELD_GET(GENMASK(15, 0), val);
 			phy->mt76->aggr_stats[aggr0++] += FIELD_GET(GENMASK(31, 16), val);
 		}
 
-		cnt = mt76_rr(dev, MT_MIB_SDR32(phy->band_idx));
+		cnt = mt76_rr(dev, MT_MIB_SDR32(band));
 		mib->tx_pkt_ibf_cnt += FIELD_GET(MT_MIB_SDR32_TX_PKT_IBF_CNT, cnt);
 		mib->tx_bf_ibf_ppdu_cnt += FIELD_GET(MT_MIB_SDR32_TX_PKT_IBF_CNT, cnt);
 		mib->tx_pkt_ebf_cnt += FIELD_GET(MT_MIB_SDR32_TX_PKT_EBF_CNT, cnt);
 		mib->tx_bf_ebf_ppdu_cnt += FIELD_GET(MT_MIB_SDR32_TX_PKT_EBF_CNT, cnt);
 
-		cnt = mt76_rr(dev, MT_MIB_BFCR7(phy->band_idx));
+		cnt = mt76_rr(dev, MT_MIB_BFCR7(band));
 		mib->tx_bf_fb_cpl_cnt += FIELD_GET(MT_MIB_BFCR7_BFEE_TX_FB_CPL, cnt);
 
-		cnt = mt76_rr(dev, MT_MIB_BFCR2(phy->band_idx));
+		cnt = mt76_rr(dev, MT_MIB_BFCR2(band));
 		mib->tx_bf_fb_trig_cnt += FIELD_GET(MT_MIB_BFCR2_BFEE_TX_FB_TRIG, cnt);
 
-		cnt = mt76_rr(dev, MT_MIB_BFCR0(phy->band_idx));
+		cnt = mt76_rr(dev, MT_MIB_BFCR0(band));
 		mib->tx_bf_rx_fb_vht_cnt += FIELD_GET(MT_MIB_BFCR0_RX_FB_VHT, cnt);
 		mib->tx_bf_rx_fb_all_cnt += FIELD_GET(MT_MIB_BFCR0_RX_FB_VHT, cnt);
 		mib->tx_bf_rx_fb_ht_cnt += FIELD_GET(MT_MIB_BFCR0_RX_FB_HT, cnt);
 		mib->tx_bf_rx_fb_all_cnt += FIELD_GET(MT_MIB_BFCR0_RX_FB_HT, cnt);
 
-		cnt = mt76_rr(dev, MT_MIB_BFCR1(phy->band_idx));
+		cnt = mt76_rr(dev, MT_MIB_BFCR1(band));
 		mib->tx_bf_rx_fb_he_cnt += FIELD_GET(MT_MIB_BFCR1_RX_FB_HE, cnt);
 		mib->tx_bf_rx_fb_all_cnt += FIELD_GET(MT_MIB_BFCR1_RX_FB_HE, cnt);
 	}
@@ -1988,7 +1990,7 @@ static void mt7915_mac_severe_check(struct mt7915_phy *phy)
 	 * stopping Rx, so check status periodically to see if TRB hardware
 	 * requires minimal recovery.
 	 */
-	trb = mt76_rr(dev, MT_TRB_RXPSR0(phy->band_idx));
+	trb = mt76_rr(dev, MT_TRB_RXPSR0(phy->mt76->band_idx));
 
 	if ((FIELD_GET(MT_TRB_RXPSR0_RX_RMAC_PTR, trb) !=
 	     FIELD_GET(MT_TRB_RXPSR0_RX_WTBL_PTR, trb)) &&
@@ -1996,7 +1998,7 @@ static void mt7915_mac_severe_check(struct mt7915_phy *phy)
 	     FIELD_GET(MT_TRB_RXPSR0_RX_WTBL_PTR, phy->trb_ts)) &&
 	    trb == phy->trb_ts)
 		mt7915_mcu_set_ser(dev, SER_RECOVER, SER_SET_RECOVER_L3_RX_ABORT,
-				   phy->band_idx);
+				   phy->mt76->band_idx);
 
 	phy->trb_ts = trb;
 }
@@ -2116,16 +2118,16 @@ static int mt7915_dfs_start_radar_detector(struct mt7915_phy *phy)
 	int err;
 
 	/* start CAC */
-	err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_CAC_START, phy->band_idx,
-				      MT_RX_SEL0, 0);
+	err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_CAC_START,
+				      phy->mt76->band_idx, MT_RX_SEL0, 0);
 	if (err < 0)
 		return err;
 
-	err = mt7915_dfs_start_rdd(dev, phy->band_idx);
+	err = mt7915_dfs_start_rdd(dev, phy->mt76->band_idx);
 	if (err < 0)
 		return err;
 
-	phy->rdd_state |= BIT(phy->band_idx);
+	phy->rdd_state |= BIT(phy->mt76->band_idx);
 
 	if (!is_mt7915(&dev->mt76))
 		return 0;
@@ -2210,7 +2212,7 @@ int mt7915_dfs_init_radar_detector(struct mt7915_phy *phy)
 		return 0;
 
 	err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_CAC_END,
-				      phy->band_idx, MT_RX_SEL0, 0);
+				      phy->mt76->band_idx, MT_RX_SEL0, 0);
 	if (err < 0) {
 		phy->mt76->dfs_state = MT_DFS_STATE_UNKNOWN;
 		return err;
@@ -2221,13 +2223,13 @@ int mt7915_dfs_init_radar_detector(struct mt7915_phy *phy)
 
 stop:
 	err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_NORMAL_START,
-				      phy->band_idx, MT_RX_SEL0, 0);
+				      phy->mt76->band_idx, MT_RX_SEL0, 0);
 	if (err < 0)
 		return err;
 
 	if (is_mt7915(&dev->mt76)) {
 		err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_SET_WF_ANT,
-					      phy->band_idx, 0,
+					      phy->mt76->band_idx, 0,
 					      dev->dbdc_support ? 2 : 0);
 		if (err < 0)
 			return err;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index c40b6098f19a..0511d6a505b0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -30,31 +30,35 @@ int mt7915_run(struct ieee80211_hw *hw)
 	running = mt7915_dev_running(dev);
 
 	if (!running) {
-		ret = mt76_connac_mcu_set_pm(&dev->mt76, dev->phy.band_idx, 0);
+		ret = mt76_connac_mcu_set_pm(&dev->mt76,
+					     dev->phy.mt76->band_idx, 0);
 		if (ret)
 			goto out;
 
-		ret = mt7915_mcu_set_mac(dev, dev->phy.band_idx, true, true);
+		ret = mt7915_mcu_set_mac(dev, dev->phy.mt76->band_idx,
+					 true, true);
 		if (ret)
 			goto out;
 
-		mt7915_mac_enable_nf(dev, dev->phy.band_idx);
+		mt7915_mac_enable_nf(dev, dev->phy.mt76->band_idx);
 	}
 
 	if (phy != &dev->phy) {
-		ret = mt76_connac_mcu_set_pm(&dev->mt76, phy->band_idx, 0);
+		ret = mt76_connac_mcu_set_pm(&dev->mt76,
+					     phy->mt76->band_idx, 0);
 		if (ret)
 			goto out;
 
-		ret = mt7915_mcu_set_mac(dev, phy->band_idx, true, true);
+		ret = mt7915_mcu_set_mac(dev, phy->mt76->band_idx,
+					 true, true);
 		if (ret)
 			goto out;
 
-		mt7915_mac_enable_nf(dev, phy->band_idx);
+		mt7915_mac_enable_nf(dev, phy->mt76->band_idx);
 	}
 
 	ret = mt76_connac_mcu_set_rts_thresh(&dev->mt76, 0x92b,
-					     phy->band_idx);
+					     phy->mt76->band_idx);
 	if (ret)
 		goto out;
 
@@ -107,13 +111,13 @@ static void mt7915_stop(struct ieee80211_hw *hw)
 	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 
 	if (phy != &dev->phy) {
-		mt76_connac_mcu_set_pm(&dev->mt76, phy->band_idx, 1);
-		mt7915_mcu_set_mac(dev, phy->band_idx, false, false);
+		mt76_connac_mcu_set_pm(&dev->mt76, phy->mt76->band_idx, 1);
+		mt7915_mcu_set_mac(dev, phy->mt76->band_idx, false, false);
 	}
 
 	if (!mt7915_dev_running(dev)) {
-		mt76_connac_mcu_set_pm(&dev->mt76, dev->phy.band_idx, 1);
-		mt7915_mcu_set_mac(dev, dev->phy.band_idx, false, false);
+		mt76_connac_mcu_set_pm(&dev->mt76, dev->phy.mt76->band_idx, 1);
+		mt7915_mcu_set_mac(dev, dev->phy.mt76->band_idx, false, false);
 	}
 
 	mutex_unlock(&dev->mt76.mutex);
@@ -217,7 +221,7 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	}
 	mvif->mt76.omac_idx = idx;
 	mvif->phy = phy;
-	mvif->mt76.band_idx = phy->band_idx;
+	mvif->mt76.band_idx = phy->mt76->band_idx;
 
 	mvif->mt76.wmm_idx = vif->type != NL80211_IFTYPE_AP;
 	if (ext_phy)
@@ -467,7 +471,7 @@ static int mt7915_config(struct ieee80211_hw *hw, u32 changed)
 
 	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
 		bool enabled = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
-		bool band = phy->band_idx;
+		bool band = phy->mt76->band_idx;
 
 		if (!enabled)
 			phy->rxfilter |= MT_WF_RFCR_DROP_OTHER_UC;
@@ -506,7 +510,7 @@ static void mt7915_configure_filter(struct ieee80211_hw *hw,
 {
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
-	bool band = phy->band_idx;
+	bool band = phy->mt76->band_idx;
 	u32 ctl_flags = MT_WF_RFCR1_DROP_ACK |
 			MT_WF_RFCR1_DROP_BF_POLL |
 			MT_WF_RFCR1_DROP_BA |
@@ -743,7 +747,8 @@ static int mt7915_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
 	int ret;
 
 	mutex_lock(&dev->mt76.mutex);
-	ret = mt76_connac_mcu_set_rts_thresh(&dev->mt76, val, phy->band_idx);
+	ret = mt76_connac_mcu_set_rts_thresh(&dev->mt76, val,
+					     phy->mt76->band_idx);
 	mutex_unlock(&dev->mt76.mutex);
 
 	return ret;
@@ -846,7 +851,7 @@ u64 __mt7915_get_tsf(struct ieee80211_hw *hw, struct mt7915_vif *mvif)
 {
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
-	bool band = phy->band_idx;
+	bool band = phy->mt76->band_idx;
 	union {
 		u64 t64;
 		u32 t32[2];
@@ -891,7 +896,7 @@ mt7915_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
-	bool band = phy->band_idx;
+	bool band = phy->mt76->band_idx;
 	union {
 		u64 t64;
 		u32 t32[2];
@@ -922,7 +927,7 @@ mt7915_offset_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
-	bool band = phy->band_idx;
+	bool band = phy->mt76->band_idx;
 	union {
 		u64 t64;
 		u32 t32[2];
@@ -965,6 +970,7 @@ mt7915_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
 	int max_nss = hweight8(hw->wiphy->available_antennas_tx);
 	u8 chainshift = dev->chainshift;
+	u8 band = phy->mt76->band_idx;
 
 	if (!tx_ant || tx_ant != rx_ant || ffs(tx_ant) > max_nss)
 		return -EINVAL;
@@ -974,10 +980,10 @@ mt7915_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 	phy->mt76->antenna_mask = tx_ant;
 
 	/* handle a variant of mt7916 which has 3T3R but nss2 on 5 GHz band */
-	if (is_mt7916(&dev->mt76) && phy->band_idx && hweight8(tx_ant) == max_nss)
+	if (is_mt7916(&dev->mt76) && band && hweight8(tx_ant) == max_nss)
 		phy->mt76->chainmask = (dev->chainmask >> chainshift) << chainshift;
 	else
-		phy->mt76->chainmask = tx_ant << (chainshift * phy->band_idx);
+		phy->mt76->chainmask = tx_ant << (chainshift * band);
 
 	mt76_set_stream_caps(phy->mt76, true);
 	mt7915_set_stream_vht_txbf_caps(phy);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 718e52744994..634ebc95f78f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -232,7 +232,8 @@ mt7915_mcu_rx_csa_notify(struct mt7915_dev *dev, struct sk_buff *skb)
 
 	c = (struct mt7915_mcu_csa_notify *)skb->data;
 
-	if ((c->band_idx && !dev->phy.band_idx) && dev->mt76.phys[MT_BAND1])
+	if ((c->band_idx && !dev->phy.mt76->band_idx) &&
+	     dev->mt76.phys[MT_BAND1])
 		mphy = dev->mt76.phys[MT_BAND1];
 
 	ieee80211_iterate_active_interfaces_atomic(mphy->hw,
@@ -251,7 +252,8 @@ mt7915_mcu_rx_thermal_notify(struct mt7915_dev *dev, struct sk_buff *skb)
 	if (t->ctrl.ctrl_id != THERMAL_PROTECT_ENABLE)
 		return;
 
-	if ((t->ctrl.band_idx && !dev->phy.band_idx) && dev->mt76.phys[MT_BAND1])
+	if ((t->ctrl.band_idx && !dev->phy.mt76->band_idx) &&
+	     dev->mt76.phys[MT_BAND1])
 		mphy = dev->mt76.phys[MT_BAND1];
 
 	phy = (struct mt7915_phy *)mphy->priv;
@@ -266,7 +268,8 @@ mt7915_mcu_rx_radar_detected(struct mt7915_dev *dev, struct sk_buff *skb)
 
 	r = (struct mt7915_mcu_rdd_report *)skb->data;
 
-	if ((r->band_idx && !dev->phy.band_idx) && dev->mt76.phys[MT_BAND1])
+	if ((r->band_idx && !dev->phy.mt76->band_idx) &&
+	     dev->mt76.phys[MT_BAND1])
 		mphy = dev->mt76.phys[MT_BAND1];
 
 	if (r->band_idx == MT_RX_SEL2)
@@ -323,7 +326,7 @@ mt7915_mcu_rx_bcc_notify(struct mt7915_dev *dev, struct sk_buff *skb)
 
 	b = (struct mt7915_mcu_bcc_notify *)skb->data;
 
-	if ((b->band_idx && !dev->phy.band_idx) && dev->mt76.phys[MT_BAND1])
+	if ((b->band_idx && !dev->phy.mt76->band_idx) && dev->mt76.phys[MT_BAND1])
 		mphy = dev->mt76.phys[MT_BAND1];
 
 	ieee80211_iterate_active_interfaces_atomic(mphy->hw,
@@ -599,7 +602,7 @@ mt7915_mcu_muar_config(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 		.mode = !!mask || enable,
 		.entry_count = 1,
 		.write = 1,
-		.band = phy->band_idx,
+		.band = phy->mt76->band_idx,
 		.index = idx * 2 + bssid,
 	};
 
@@ -2192,7 +2195,7 @@ int mt7915_mcu_muru_debug_get(struct mt7915_phy *phy, void *ms)
 		u8 band_idx;
 	} req = {
 		.cmd = cpu_to_le32(MURU_GET_TXC_TX_STATS),
-		.band_idx = phy->band_idx,
+		.band_idx = phy->mt76->band_idx,
 	};
 
 	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_CMD(MURU_CTRL),
@@ -2585,7 +2588,7 @@ mt7915_mcu_background_chain_ctrl(struct mt7915_phy *phy,
 		req.monitor_central_chan =
 			ieee80211_frequency_to_channel(chandef->center_freq1);
 		req.monitor_bw = mt76_connac_chan_bw(chandef);
-		req.band_idx = phy->band_idx;
+		req.band_idx = phy->mt76->band_idx;
 		req.scan_mode = 1;
 		break;
 	}
@@ -2593,7 +2596,7 @@ mt7915_mcu_background_chain_ctrl(struct mt7915_phy *phy,
 		req.monitor_chan = chandef->chan->hw_value;
 		req.monitor_central_chan =
 			ieee80211_frequency_to_channel(chandef->center_freq1);
-		req.band_idx = phy->band_idx;
+		req.band_idx = phy->mt76->band_idx;
 		req.scan_mode = 2;
 		break;
 	case CH_SWITCH_BACKGROUND_SCAN_STOP:
@@ -2660,6 +2663,7 @@ int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)
 	struct mt7915_dev *dev = phy->dev;
 	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
 	int freq1 = chandef->center_freq1;
+	u8 band = phy->mt76->band_idx;
 	struct {
 		u8 control_ch;
 		u8 center_ch;
@@ -2682,8 +2686,8 @@ int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)
 		.center_ch = ieee80211_frequency_to_channel(freq1),
 		.bw = mt76_connac_chan_bw(chandef),
 		.tx_path_num = hweight16(phy->mt76->chainmask),
-		.rx_path = phy->mt76->chainmask >> (dev->chainshift * phy->band_idx),
-		.band_idx = phy->band_idx,
+		.rx_path = phy->mt76->chainmask >> (dev->chainshift * band),
+		.band_idx = band,
 		.channel_band = ch_band[chandef->chan->band],
 	};
 
@@ -2997,7 +3001,7 @@ int mt7915_mcu_get_chan_mib_info(struct mt7915_phy *phy, bool chan_switch)
 	}
 
 	for (i = 0; i < 5; i++) {
-		req[i].band = cpu_to_le32(phy->band_idx);
+		req[i].band = cpu_to_le32(phy->mt76->band_idx);
 		req[i].offs = cpu_to_le32(offs[i + start]);
 
 		if (!is_mt7915(&dev->mt76) && i == 3)
@@ -3046,7 +3050,7 @@ int mt7915_mcu_get_temperature(struct mt7915_phy *phy)
 		u8 rsv[5];
 	} req = {
 		.ctrl_id = THERMAL_SENSOR_TEMP_QUERY,
-		.band_idx = phy->band_idx,
+		.band_idx = phy->mt76->band_idx,
 	};
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(THERMAL_CTRL), &req,
@@ -3065,7 +3069,7 @@ int mt7915_mcu_set_thermal_throttling(struct mt7915_phy *phy, u8 state)
 		u8 rsv[2];
 	} __packed req = {
 		.ctrl = {
-			.band_idx = phy->band_idx,
+			.band_idx = phy->mt76->band_idx,
 		},
 	};
 	int level;
@@ -3115,7 +3119,7 @@ int mt7915_mcu_set_txpower_frame_min(struct mt7915_phy *phy, s8 txpower)
 		s8 txpower_min;
 	} __packed req = {
 		.format_id = TX_POWER_LIMIT_FRAME_MIN,
-		.band_idx = phy->band_idx,
+		.band_idx = phy->mt76->band_idx,
 		.txpower_min = txpower * 2, /* 0.5db */
 	};
 
@@ -3140,7 +3144,7 @@ int mt7915_mcu_set_txpower_frame(struct mt7915_phy *phy,
 		s8 txpower_offs[48];
 	} __packed req = {
 		.format_id = TX_POWER_LIMIT_FRAME,
-		.band_idx = phy->band_idx,
+		.band_idx = phy->mt76->band_idx,
 		.txpower_max = DIV_ROUND_UP(mphy->txpower_cur, 2),
 		.wcid = cpu_to_le16(msta->wcid.idx),
 	};
@@ -3199,7 +3203,7 @@ int mt7915_mcu_set_txpower_sku(struct mt7915_phy *phy)
 		s8 val[MT7915_SKU_RATE_NUM];
 	} __packed req = {
 		.format_id = TX_POWER_LIMIT_TABLE,
-		.band_idx = phy->band_idx,
+		.band_idx = phy->mt76->band_idx,
 	};
 	struct mt76_power_limits limits_array;
 	s8 *la = (s8 *)&limits_array;
@@ -3250,7 +3254,7 @@ int mt7915_mcu_get_txpower_sku(struct mt7915_phy *phy, s8 *txpower, int len)
 	} __packed req = {
 		.format_id = TX_POWER_LIMIT_INFO,
 		.category = RATE_POWER_INFO,
-		.band_idx = phy->band_idx,
+		.band_idx = phy->mt76->band_idx,
 	};
 	s8 txpower_sku[MT7915_SKU_RATE_NUM][2];
 	struct sk_buff *skb;
@@ -3303,7 +3307,7 @@ int mt7915_mcu_set_sku_en(struct mt7915_phy *phy, bool enable)
 		u8 rsv;
 	} __packed req = {
 		.format_id = TX_POWER_LIMIT_ENABLE,
-		.band_idx = phy->band_idx,
+		.band_idx = phy->mt76->band_idx,
 		.sku_enable = enable,
 	};
 
@@ -3385,7 +3389,7 @@ mt7915_mcu_enable_obss_spr(struct mt7915_phy *phy, u8 action, u8 val)
 	struct mt7915_mcu_sr_ctrl req = {
 		.action = action,
 		.argnum = 1,
-		.band_idx = phy->band_idx,
+		.band_idx = phy->mt76->band_idx,
 		.val = cpu_to_le32(val),
 	};
 
@@ -3416,7 +3420,7 @@ mt7915_mcu_set_obss_spr_pd(struct mt7915_phy *phy,
 		.ctrl = {
 			.action = SPR_SET_PARAM,
 			.argnum = 9,
-			.band_idx = phy->band_idx,
+			.band_idx = phy->mt76->band_idx,
 		},
 	};
 	int ret;
@@ -3465,7 +3469,7 @@ mt7915_mcu_set_obss_spr_siga(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 		.ctrl = {
 			.action = SPR_SET_SIGA,
 			.argnum = 1,
-			.band_idx = phy->band_idx,
+			.band_idx = phy->mt76->band_idx,
 		},
 		.siga = {
 			.omac = omac > HW_BSSID_MAX ? omac - 12 : omac,
@@ -3504,7 +3508,7 @@ mt7915_mcu_set_obss_spr_bitmap(struct mt7915_phy *phy,
 		.ctrl = {
 			.action = SPR_SET_SRG_BITMAP,
 			.argnum = 4,
-			.band_idx = phy->band_idx,
+			.band_idx = phy->mt76->band_idx,
 		},
 	};
 	u32 bitmap;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 3b4ede3b85ea..5a4141682f04 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -558,11 +558,11 @@ static int mt7915_mmio_wed_offload_enable(struct mtk_wed_device *wed)
 		return -EAGAIN;
 
 	phy = &dev->phy;
-	mt76_set(dev, MT_AGG_ACR4(phy->band_idx), MT_AGG_ACR_PPDU_TXS2H);
+	mt76_set(dev, MT_AGG_ACR4(phy->mt76->band_idx), MT_AGG_ACR_PPDU_TXS2H);
 
 	phy = dev->mt76.phys[MT_BAND1] ? dev->mt76.phys[MT_BAND1]->priv : NULL;
 	if (phy)
-		mt76_set(dev, MT_AGG_ACR4(phy->band_idx),
+		mt76_set(dev, MT_AGG_ACR4(phy->mt76->band_idx),
 			 MT_AGG_ACR_PPDU_TXS2H);
 
 	return 0;
@@ -583,11 +583,11 @@ static void mt7915_mmio_wed_offload_disable(struct mtk_wed_device *wed)
 	 * MT_AGG_ACR_PPDU_TXS2H (PPDU format) even though ACR bit is set.
 	 */
 	phy = &dev->phy;
-	mt76_clear(dev, MT_AGG_ACR4(phy->band_idx), MT_AGG_ACR_PPDU_TXS2H);
+	mt76_clear(dev, MT_AGG_ACR4(phy->mt76->band_idx), MT_AGG_ACR_PPDU_TXS2H);
 
 	phy = dev->mt76.phys[MT_BAND1] ? dev->mt76.phys[MT_BAND1]->priv : NULL;
 	if (phy)
-		mt76_clear(dev, MT_AGG_ACR4(phy->band_idx),
+		mt76_clear(dev, MT_AGG_ACR4(phy->mt76->band_idx),
 			   MT_AGG_ACR_PPDU_TXS2H);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 42f213430758..6351feba6bdf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -258,7 +258,6 @@ struct mt7915_phy {
 
 	u32 rxfilter;
 	u64 omac_mask;
-	u8 band_idx;
 
 	u16 noise;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index 7ace05e0b63b..0d76ae31b376 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -51,7 +51,7 @@ mt7915_tm_set_tx_power(struct mt7915_phy *phy)
 		u8 rsv[3];
 	} __packed req = {
 		.format_id = 0xf,
-		.band_idx = phy->band_idx,
+		.band_idx = phy->mt76->band_idx,
 		.center_chan = ieee80211_frequency_to_channel(freq),
 	};
 	u8 *tx_power = NULL;
@@ -77,7 +77,7 @@ mt7915_tm_set_freq_offset(struct mt7915_phy *phy, bool en, u32 val)
 	struct mt7915_tm_cmd req = {
 		.testmode_en = en,
 		.param_idx = MCU_ATE_SET_FREQ_OFFSET,
-		.param.freq.band = phy->band_idx,
+		.param.freq.band = phy->mt76->band_idx,
 		.param.freq.freq_offset = cpu_to_le32(val),
 	};
 
@@ -111,7 +111,7 @@ mt7915_tm_set_trx(struct mt7915_phy *phy, int type, bool en)
 		.param_idx = MCU_ATE_SET_TRX,
 		.param.trx.type = type,
 		.param.trx.enable = en,
-		.param.trx.band = phy->band_idx,
+		.param.trx.band = phy->mt76->band_idx,
 	};
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(ATE_CTRL), &req,
@@ -126,7 +126,7 @@ mt7915_tm_clean_hwq(struct mt7915_phy *phy, u8 wcid)
 		.testmode_en = 1,
 		.param_idx = MCU_ATE_CLEAN_TXQUEUE,
 		.param.clean.wcid = wcid,
-		.param.clean.band = phy->band_idx,
+		.param.clean.band = phy->mt76->band_idx,
 	};
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(ATE_CTRL), &req,
@@ -144,7 +144,7 @@ mt7915_tm_set_slot_time(struct mt7915_phy *phy, u8 slot_time, u8 sifs)
 		.param.slot.sifs = sifs,
 		.param.slot.rifs = 2,
 		.param.slot.eifs = cpu_to_le16(60),
-		.param.slot.band = phy->band_idx,
+		.param.slot.band = phy->mt76->band_idx,
 	};
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(ATE_CTRL), &req,
@@ -198,6 +198,7 @@ mt7915_tm_set_ipg_params(struct mt7915_phy *phy, u32 ipg, u8 mode)
 	u8 sig_ext = (mode == MT76_TM_TX_MODE_CCK) ? 0 : 6;
 	u8 slot_time = 9, sifs = TM_DEFAULT_SIFS;
 	u8 aifsn = TM_MIN_AIFSN;
+	u8 band = phy->mt76->band_idx;
 	u32 i2t_time, tr2t_time, txv_time;
 	u16 cw = 0;
 
@@ -232,14 +233,14 @@ mt7915_tm_set_ipg_params(struct mt7915_phy *phy, u32 ipg, u8 mode)
 			sifs = min_t(u32, ipg, TM_MAX_SIFS);
 	}
 done:
-	txv_time = mt76_get_field(dev, MT_TMAC_ATCR(phy->band_idx),
+	txv_time = mt76_get_field(dev, MT_TMAC_ATCR(band),
 				  MT_TMAC_ATCR_TXV_TOUT);
 	txv_time *= 50;	/* normal clock time */
 
 	i2t_time = (slot_time * 1000 - txv_time - BBP_PROC_TIME) / 50;
 	tr2t_time = (sifs * 1000 - txv_time - BBP_PROC_TIME) / 50;
 
-	mt76_set(dev, MT_TMAC_TRCR0(phy->band_idx),
+	mt76_set(dev, MT_TMAC_TRCR0(band),
 		 FIELD_PREP(MT_TMAC_TRCR0_TR2T_CHK, tr2t_time) |
 		 FIELD_PREP(MT_TMAC_TRCR0_I2T_CHK, i2t_time));
 
@@ -336,6 +337,7 @@ mt7915_tm_reg_backup_restore(struct mt7915_phy *phy)
 	int n_regs = ARRAY_SIZE(reg_backup_list);
 	struct mt7915_dev *dev = phy->dev;
 	u32 *b = phy->test.reg_backup;
+	u8 band = phy->mt76->band_idx;
 	int i;
 
 	REG_BAND_IDX(reg_backup_list[0], AGG_PCR0, 0);
@@ -358,7 +360,7 @@ mt7915_tm_reg_backup_restore(struct mt7915_phy *phy)
 
 	if (phy->mt76->test.state == MT76_TM_STATE_OFF) {
 		for (i = 0; i < n_regs; i++)
-			mt76_wr(dev, reg_backup_list[i].band[phy->band_idx], b[i]);
+			mt76_wr(dev, reg_backup_list[i].band[band], b[i]);
 		return;
 	}
 
@@ -369,33 +371,33 @@ mt7915_tm_reg_backup_restore(struct mt7915_phy *phy)
 
 		phy->test.reg_backup = b;
 		for (i = 0; i < n_regs; i++)
-			b[i] = mt76_rr(dev, reg_backup_list[i].band[phy->band_idx]);
+			b[i] = mt76_rr(dev, reg_backup_list[i].band[band]);
 	}
 
-	mt76_clear(dev, MT_AGG_PCR0(phy->band_idx, 0), MT_AGG_PCR0_MM_PROT |
+	mt76_clear(dev, MT_AGG_PCR0(band, 0), MT_AGG_PCR0_MM_PROT |
 		   MT_AGG_PCR0_GF_PROT | MT_AGG_PCR0_ERP_PROT |
 		   MT_AGG_PCR0_VHT_PROT | MT_AGG_PCR0_BW20_PROT |
 		   MT_AGG_PCR0_BW40_PROT | MT_AGG_PCR0_BW80_PROT);
-	mt76_set(dev, MT_AGG_PCR0(phy->band_idx, 0), MT_AGG_PCR0_PTA_WIN_DIS);
+	mt76_set(dev, MT_AGG_PCR0(band, 0), MT_AGG_PCR0_PTA_WIN_DIS);
 
-	mt76_wr(dev, MT_AGG_PCR0(phy->band_idx, 1), MT_AGG_PCR1_RTS0_NUM_THRES |
+	mt76_wr(dev, MT_AGG_PCR0(band, 1), MT_AGG_PCR1_RTS0_NUM_THRES |
 		MT_AGG_PCR1_RTS0_LEN_THRES);
 
-	mt76_clear(dev, MT_AGG_MRCR(phy->band_idx), MT_AGG_MRCR_BAR_CNT_LIMIT |
+	mt76_clear(dev, MT_AGG_MRCR(band), MT_AGG_MRCR_BAR_CNT_LIMIT |
 		   MT_AGG_MRCR_LAST_RTS_CTS_RN | MT_AGG_MRCR_RTS_FAIL_LIMIT |
 		   MT_AGG_MRCR_TXCMD_RTS_FAIL_LIMIT);
 
-	mt76_rmw(dev, MT_AGG_MRCR(phy->band_idx), MT_AGG_MRCR_RTS_FAIL_LIMIT |
+	mt76_rmw(dev, MT_AGG_MRCR(band), MT_AGG_MRCR_RTS_FAIL_LIMIT |
 		 MT_AGG_MRCR_TXCMD_RTS_FAIL_LIMIT,
 		 FIELD_PREP(MT_AGG_MRCR_RTS_FAIL_LIMIT, 1) |
 		 FIELD_PREP(MT_AGG_MRCR_TXCMD_RTS_FAIL_LIMIT, 1));
 
-	mt76_wr(dev, MT_TMAC_TFCR0(phy->band_idx), 0);
-	mt76_clear(dev, MT_TMAC_TCR0(phy->band_idx), MT_TMAC_TCR0_TBTT_STOP_CTRL);
+	mt76_wr(dev, MT_TMAC_TFCR0(band), 0);
+	mt76_clear(dev, MT_TMAC_TCR0(band), MT_TMAC_TCR0_TBTT_STOP_CTRL);
 
 	/* config rx filter for testmode rx */
-	mt76_wr(dev, MT_WF_RFCR(phy->band_idx), 0xcf70a);
-	mt76_wr(dev, MT_WF_RFCR1(phy->band_idx), 0);
+	mt76_wr(dev, MT_WF_RFCR(band), 0xcf70a);
+	mt76_wr(dev, MT_WF_RFCR1(band), 0);
 }
 
 static void
@@ -488,7 +490,7 @@ mt7915_tm_set_rx_frames(struct mt7915_phy *phy, bool en)
 		mt7915_tm_update_channel(phy);
 
 		/* read-clear */
-		mt76_rr(dev, MT_MIB_SDR3(phy->band_idx));
+		mt76_rr(dev, MT_MIB_SDR3(phy->mt76->band_idx));
 		mt7915_tm_set_trx(phy, TM_MAC_RX_RXV, en);
 	}
 }
@@ -515,6 +517,7 @@ mt7915_tm_set_tx_cont(struct mt7915_phy *phy, bool en)
 	struct mt76_testmode_data *td = &phy->mt76->test;
 	u32 func_idx = en ? TX_CONT_START : TX_CONT_STOP;
 	u8 rate_idx = td->tx_rate_idx, mode;
+	u8 band = phy->mt76->band_idx;
 	u16 rateval;
 	struct mt7915_tm_rf_test req = {
 		.action = 1,
@@ -526,7 +529,7 @@ mt7915_tm_set_tx_cont(struct mt7915_phy *phy, bool en)
 	tx_cont->control_ch = chandef->chan->hw_value;
 	tx_cont->center_ch = freq1;
 	tx_cont->tx_ant = td->tx_antenna_mask;
-	tx_cont->band = phy->band_idx;
+	tx_cont->band = band;
 
 	switch (chandef->width) {
 	case NL80211_CHAN_WIDTH_40:
@@ -558,7 +561,7 @@ mt7915_tm_set_tx_cont(struct mt7915_phy *phy, bool en)
 	}
 
 	if (!en) {
-		req.op.rf.param.func_data = cpu_to_le32(phy->band_idx);
+		req.op.rf.param.func_data = cpu_to_le32(band);
 		goto out;
 	}
 
@@ -767,11 +770,11 @@ mt7915_tm_dump_stats(struct mt76_phy *mphy, struct sk_buff *msg)
 
 	nla_nest_end(msg, rx);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR3(phy->band_idx));
+	cnt = mt76_rr(dev, MT_MIB_SDR3(phy->mt76->band_idx));
 	fcs_err = is_mt7915(&dev->mt76) ? FIELD_GET(MT_MIB_SDR3_FCS_ERR_MASK, cnt) :
 		FIELD_GET(MT_MIB_SDR3_FCS_ERR_MASK_MT7916, cnt);
 
-	q = phy->band_idx ? MT_RXQ_BAND1 : MT_RXQ_MAIN;
+	q = phy->mt76->band_idx ? MT_RXQ_BAND1 : MT_RXQ_MAIN;
 	mphy->test.rx_stats.packets[q] += fcs_err;
 	mphy->test.rx_stats.fcs_error[q] += fcs_err;
 
-- 
2.18.0

