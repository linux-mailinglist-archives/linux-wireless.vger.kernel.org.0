Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D83114DE4B
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2020 17:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgA3QBX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jan 2020 11:01:23 -0500
Received: from nbd.name ([46.4.11.11]:33374 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727158AbgA3QBX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jan 2020 11:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=N7MIZTCFLaTcJo/0KB0m7js6SLpw5ohFGSZYg+5GnFk=; b=oxuHlntQE83s37+BqLjCYDQHuM
        flMpFvMZkjXCPDM6Pvb2ALDqb1778A+7x8mfSnmu6noceOoJqumBSAQle3CSH5quzweW7Sr7dQj/p
        XZVd1Q7kL4XVspdfy5nrVFnkPm66VhGHrJ9IzC8E2WCPQmnK7cZyaIWkEhu8L+4GwpZY=;
Received: from [178.162.209.135] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ixCFt-0006qR-U8
        for linux-wireless@vger.kernel.org; Thu, 30 Jan 2020 17:01:22 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 4EDCA7AE5A01; Thu, 30 Jan 2020 17:01:21 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] mt76: mt7615: fix and rework tx power handling
Date:   Thu, 30 Jan 2020 17:01:20 +0100
Message-Id: <20200130160121.14714-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Setting the tx power by manipulating EEPROM may in some cases not be enough,
since it only covers the base target power and not per-rate offsets.
In other cases, it could limit tx power of rates too much, possibly reducing
throughput or range.
Use firmware support for applying per-rate limit and power offsets for
different values of Nss.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7615/main.c  |   7 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 112 +++++++-----------
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  57 +++++++++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   2 +-
 4 files changed, 103 insertions(+), 75 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index b8e57bf7814b..699471745b8b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -241,6 +241,7 @@ static int mt7615_set_channel(struct mt7615_phy *phy)
 	mt7615_mac_set_timing(phy);
 	ret = mt7615_dfs_init_radar_detector(phy);
 	mt7615_mac_cca_stats_reset(phy);
+	mt7615_mcu_set_sku_en(phy, true);
 
 	mt7615_mac_reset_counters(dev);
 	phy->noise = 0;
@@ -313,7 +314,8 @@ static int mt7615_config(struct ieee80211_hw *hw, u32 changed)
 	bool band = phy != &dev->phy;
 	int ret = 0;
 
-	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
+	if (changed & (IEEE80211_CONF_CHANGE_CHANNEL |
+		       IEEE80211_CONF_CHANGE_POWER)) {
 		ieee80211_stop_queues(hw);
 		ret = mt7615_set_channel(phy);
 		ieee80211_wake_queues(hw);
@@ -321,9 +323,6 @@ static int mt7615_config(struct ieee80211_hw *hw, u32 changed)
 
 	mutex_lock(&dev->mt76.mutex);
 
-	if (changed & IEEE80211_CONF_CHANGE_POWER)
-		ret = mt7615_mcu_set_tx_power(phy);
-
 	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
 		if (!(hw->conf.flags & IEEE80211_CONF_MONITOR))
 			phy->rxfilter |= MT_WF_RFCR_DROP_OTHER_UC;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index d8bdd88d9fe9..e43d480ed1ae 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1333,75 +1333,6 @@ int mt7615_mcu_set_bcn(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 				   &req, sizeof(req), true);
 }
 
-int mt7615_mcu_set_tx_power(struct mt7615_phy *phy)
-{
-	struct mt7615_dev *dev = phy->dev;
-	struct mt76_phy *mphy = phy->mt76;
-	int i, ret, n_chains = hweight8(mphy->antenna_mask);
-	struct cfg80211_chan_def *chandef = &mphy->chandef;
-	int freq = chandef->center_freq1, len, target_chains;
-	u8 *req, *data, *eep = (u8 *)dev->mt76.eeprom.data;
-	enum nl80211_band band = chandef->chan->band;
-	struct ieee80211_hw *hw = mphy->hw;
-	struct {
-		u8 center_chan;
-		u8 dbdc_idx;
-		u8 band;
-		u8 rsv;
-	} __packed req_hdr = {
-		.center_chan = ieee80211_frequency_to_channel(freq),
-		.band = band,
-		.dbdc_idx = phy != &dev->phy,
-	};
-	s8 tx_power;
-
-	len = sizeof(req_hdr) + MT7615_EE_MAX - MT_EE_NIC_CONF_0;
-	req = kzalloc(len, GFP_KERNEL);
-	if (!req)
-		return -ENOMEM;
-
-	memcpy(req, &req_hdr, sizeof(req_hdr));
-	data = req + sizeof(req_hdr);
-	memcpy(data, eep + MT_EE_NIC_CONF_0,
-	       MT7615_EE_MAX - MT_EE_NIC_CONF_0);
-
-	tx_power = hw->conf.power_level * 2;
-	switch (n_chains) {
-	case 4:
-		tx_power -= 12;
-		break;
-	case 3:
-		tx_power -= 8;
-		break;
-	case 2:
-		tx_power -= 6;
-		break;
-	default:
-		break;
-	}
-	tx_power = max_t(s8, tx_power, 0);
-	mphy->txpower_cur = tx_power;
-
-	target_chains = mt7615_ext_pa_enabled(dev, band) ? 1 : n_chains;
-	for (i = 0; i < target_chains; i++) {
-		int index = -MT_EE_NIC_CONF_0;
-
-		ret = mt7615_eeprom_get_power_index(dev, chandef->chan, i);
-		if (ret < 0)
-			goto out;
-
-		index += ret;
-		data[index] = min_t(u8, data[index], tx_power);
-	}
-
-	ret = __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_TX_POWER_CTRL,
-				  req, len, true);
-out:
-	kfree(req);
-
-	return ret;
-}
-
 int mt7615_mcu_rdd_cmd(struct mt7615_dev *dev,
 		       enum mt7615_rdd_cmd cmd, u8 index,
 		       u8 rx_sel, u8 val)
@@ -1502,6 +1433,28 @@ int mt7615_mcu_rdd_send_pattern(struct mt7615_dev *dev)
 				   &req, sizeof(req), false);
 }
 
+static void mt7615_mcu_set_txpower_sku(struct mt7615_phy *phy, u8 *sku)
+{
+	static const u8 nss_delta[4] = { 0, 6, 8, 12 };
+	struct mt76_phy *mphy = phy->mt76;
+	struct ieee80211_hw *hw = mphy->hw;
+	int n_chains = hweight8(mphy->antenna_mask);
+	int tx_power;
+	int i;
+
+	tx_power = hw->conf.power_level * 2 - nss_delta[n_chains - 1];
+	for (i = 0; i < MT_SKU_1SS_DELTA; i++)
+		sku[i] = tx_power;
+
+	for (i = 0; i < 4; i++) {
+		int delta = 0;
+
+		if (i < n_chains - 1)
+			delta = nss_delta[n_chains - 1] - nss_delta[i];
+		sku[MT_SKU_1SS_DELTA + i] = delta;
+	}
+}
+
 int mt7615_mcu_set_chan_info(struct mt7615_phy *phy, int cmd)
 {
 	struct mt7615_dev *dev = phy->dev;
@@ -1568,7 +1521,8 @@ int mt7615_mcu_set_chan_info(struct mt7615_phy *phy, int cmd)
 		req.bw = CMD_CBW_20MHZ;
 		break;
 	}
-	memset(req.txpower_sku, 0x3f, 49);
+
+	mt7615_mcu_set_txpower_sku(phy, req.txpower_sku);
 
 	return __mt76_mcu_send_msg(&dev->mt76, cmd, &req, sizeof(req), true);
 }
@@ -1837,3 +1791,21 @@ int mt7615_mcu_get_temperature(struct mt7615_dev *dev, int index)
 	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_GET_TEMP, &req,
 				   sizeof(req), true);
 }
+
+int mt7615_mcu_set_sku_en(struct mt7615_phy *phy, bool enable)
+{
+	struct mt7615_dev *dev = phy->dev;
+	struct {
+		u8 format_id;
+		u8 sku_enable;
+		u8 band_idx;
+		u8 rsv;
+	} req = {
+		.format_id = 0,
+		.band_idx = phy != &dev->phy,
+		.sku_enable = enable,
+	};
+
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_TX_POWER_FEATURE_CTRL, &req,
+				   sizeof(req), true);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index b47d12a4c608..640b00b8aa32 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -45,6 +45,62 @@ enum {
 	MCU_EXT_EVENT_CSA_NOTIFY = 0x4f,
 };
 
+enum {
+    MT_SKU_CCK_1_2 = 0,
+    MT_SKU_CCK_55_11,
+    MT_SKU_OFDM_6_9,
+    MT_SKU_OFDM_12_18,
+    MT_SKU_OFDM_24_36,
+    MT_SKU_OFDM_48,
+    MT_SKU_OFDM_54,
+    MT_SKU_HT20_0_8,
+    MT_SKU_HT20_32,
+    MT_SKU_HT20_1_2_9_10,
+    MT_SKU_HT20_3_4_11_12,
+    MT_SKU_HT20_5_13,
+    MT_SKU_HT20_6_14,
+    MT_SKU_HT20_7_15,
+    MT_SKU_HT40_0_8,
+    MT_SKU_HT40_32,
+    MT_SKU_HT40_1_2_9_10,
+    MT_SKU_HT40_3_4_11_12,
+    MT_SKU_HT40_5_13,
+    MT_SKU_HT40_6_14,
+    MT_SKU_HT40_7_15,
+    MT_SKU_VHT20_0,
+    MT_SKU_VHT20_1_2,
+    MT_SKU_VHT20_3_4,
+    MT_SKU_VHT20_5_6,
+    MT_SKU_VHT20_7,
+    MT_SKU_VHT20_8,
+    MT_SKU_VHT20_9,
+    MT_SKU_VHT40_0,
+    MT_SKU_VHT40_1_2,
+    MT_SKU_VHT40_3_4,
+    MT_SKU_VHT40_5_6,
+    MT_SKU_VHT40_7,
+    MT_SKU_VHT40_8,
+    MT_SKU_VHT40_9,
+    MT_SKU_VHT80_0,
+    MT_SKU_VHT80_1_2,
+    MT_SKU_VHT80_3_4,
+    MT_SKU_VHT80_5_6,
+    MT_SKU_VHT80_7,
+    MT_SKU_VHT80_8,
+    MT_SKU_VHT80_9,
+    MT_SKU_VHT160_0,
+    MT_SKU_VHT160_1_2,
+    MT_SKU_VHT160_3_4,
+    MT_SKU_VHT160_5_6,
+    MT_SKU_VHT160_7,
+    MT_SKU_VHT160_8,
+    MT_SKU_VHT160_9,
+    MT_SKU_1SS_DELTA,
+    MT_SKU_2SS_DELTA,
+    MT_SKU_3SS_DELTA,
+    MT_SKU_4SS_DELTA,
+};
+
 struct mt7615_mcu_rxd {
 	__le32 rxd[4];
 
@@ -152,6 +208,7 @@ enum {
 	MCU_EXT_CMD_MAC_INIT_CTRL = 0x46,
 	MCU_EXT_CMD_BCN_OFFLOAD = 0x49,
 	MCU_EXT_CMD_SET_RX_PATH = 0x4e,
+	MCU_EXT_CMD_TX_POWER_FEATURE_CTRL = 0x58,
 	MCU_EXT_CMD_SET_RDD_TH = 0x7c,
 	MCU_EXT_CMD_SET_RDD_PATTERN = 0x7d,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 9eb5cfcfe704..b43a09894487 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -357,7 +357,6 @@ int mt7615_mcu_set_mac_enable(struct mt7615_dev *dev, int band, bool enable);
 int mt7615_mcu_set_rts_thresh(struct mt7615_phy *phy, u32 val);
 int mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int band, int enter);
 int mt7615_mcu_get_temperature(struct mt7615_dev *dev, int index);
-int mt7615_mcu_set_tx_power(struct mt7615_phy *phy);
 void mt7615_mcu_exit(struct mt7615_dev *dev);
 
 int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
@@ -383,6 +382,7 @@ int mt7615_mcu_set_pulse_th(struct mt7615_dev *dev,
 			    const struct mt7615_dfs_pulse *pulse);
 int mt7615_mcu_set_radar_th(struct mt7615_dev *dev, int index,
 			    const struct mt7615_dfs_pattern *pattern);
+int mt7615_mcu_set_sku_en(struct mt7615_phy *phy, bool enable);
 int mt7615_dfs_init_radar_detector(struct mt7615_phy *phy);
 
 int mt7615_init_debugfs(struct mt7615_dev *dev);
-- 
2.24.0

