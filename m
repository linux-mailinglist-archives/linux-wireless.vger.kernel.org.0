Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E74B510DE10
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Nov 2019 16:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfK3Pay (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Nov 2019 10:30:54 -0500
Received: from nbd.name ([46.4.11.11]:56046 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbfK3Pat (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Nov 2019 10:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2atdoFOAgNObEsQW1cowgXlt6Qm5hosRNfGb+WFrSq0=; b=i46iGwiRTWJcrnh39KEIQBCzcK
        Ia6HItNAWHRugOEDJrSKkwH9ycn2hAv4Dn9Yg4/BvOH5EkWLYOgtmktWhs9YNHZTH9L3YacU/OD7S
        TgN8qmwhUxxUHOFXM7BnEiN83aSBGYK0ROL7sXdUl361hSSKBE6+SfmzWaV/xS3DalJo=;
Received: from p5b2067e3.dip0.t-ipconnect.de ([91.32.103.227] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ib4hr-0006hf-5H
        for linux-wireless@vger.kernel.org; Sat, 30 Nov 2019 16:30:47 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 09A5C721EBE0; Sat, 30 Nov 2019 16:30:45 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 12/29] mt76: move txpower and antenna mask to struct mt76_phy
Date:   Sat, 30 Nov 2019 16:30:28 +0100
Message-Id: <20191130153045.28105-12-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130153045.28105-1-nbd@nbd.name>
References: <20191130153045.28105-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Adds multiple wiphy support to mt76_get_txpower

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 19 ++++++++++---------
 drivers/net/wireless/mediatek/mt76/mt76.h     |  6 +++---
 .../net/wireless/mediatek/mt76/mt7603/init.c  | 10 +++++-----
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/mcu.c   |  6 +++---
 .../wireless/mediatek/mt76/mt7615/eeprom.c    |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  4 ++--
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  6 +++---
 .../net/wireless/mediatek/mt76/mt76x0/phy.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  4 ++--
 .../wireless/mediatek/mt76/mt76x2/pci_main.c  |  2 +-
 .../wireless/mediatek/mt76/mt76x2/pci_phy.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt76x2/phy.c   |  2 +-
 14 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 40a181c941c7..123321a0bc15 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -121,7 +121,7 @@ static void mt76_init_stream_cap(struct mt76_dev *dev,
 				 bool vht)
 {
 	struct ieee80211_sta_ht_cap *ht_cap = &sband->ht_cap;
-	int i, nstream = hweight8(dev->antenna_mask);
+	int i, nstream = hweight8(dev->phy.antenna_mask);
 	struct ieee80211_sta_vht_cap *vht_cap;
 	u16 mcs_map = 0;
 
@@ -326,8 +326,8 @@ int mt76_register_device(struct mt76_dev *dev, bool vht,
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_AIRTIME_FAIRNESS);
 
-	wiphy->available_antennas_tx = dev->antenna_mask;
-	wiphy->available_antennas_rx = dev->antenna_mask;
+	wiphy->available_antennas_tx = dev->phy.antenna_mask;
+	wiphy->available_antennas_rx = dev->phy.antenna_mask;
 
 	hw->txq_data_size = sizeof(struct mt76_txq);
 	hw->max_tx_fragments = 16;
@@ -940,10 +940,10 @@ EXPORT_SYMBOL_GPL(mt76_sta_state);
 int mt76_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		     int *dbm)
 {
-	struct mt76_dev *dev = hw->priv;
-	int n_chains = hweight8(dev->antenna_mask);
+	struct mt76_phy *phy = hw->priv;
+	int n_chains = hweight8(phy->antenna_mask);
 
-	*dbm = DIV_ROUND_UP(dev->txpower_cur, 2);
+	*dbm = DIV_ROUND_UP(phy->txpower_cur, 2);
 
 	/* convert from per-chain power to combined
 	 * output power
@@ -1078,11 +1078,12 @@ EXPORT_SYMBOL_GPL(mt76_sw_scan_complete);
 
 int mt76_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
 {
-	struct mt76_dev *dev = hw->priv;
+	struct mt76_phy *phy = hw->priv;
+	struct mt76_dev *dev = phy->dev;
 
 	mutex_lock(&dev->mutex);
-	*tx_ant = dev->antenna_mask;
-	*rx_ant = dev->antenna_mask;
+	*tx_ant = phy->antenna_mask;
+	*rx_ant = phy->antenna_mask;
 	mutex_unlock(&dev->mutex);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index f870acbd6b87..97baa92242fa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -468,6 +468,9 @@ struct mt76_phy {
 
 	struct mt76_sband sband_2g;
 	struct mt76_sband sband_5g;
+
+	int txpower_cur;
+	u8 antenna_mask;
 };
 
 struct mt76_dev {
@@ -523,8 +526,6 @@ struct mt76_dev {
 
 	u32 aggr_stats[32];
 
-	u8 antenna_mask;
-
 	struct tasklet_struct pre_tbtt_tasklet;
 	int beacon_int;
 	u8 beacon_mask;
@@ -534,7 +535,6 @@ struct mt76_dev {
 	struct mt76_hw_cap cap;
 
 	struct mt76_rate_power rate_power;
-	int txpower_cur;
 
 	enum nl80211_dfs_regions region;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 2ca07dd4db4b..af346d479258 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -113,7 +113,7 @@ mt7603_dma_sched_init(struct mt7603_dev *dev)
 static void
 mt7603_phy_init(struct mt7603_dev *dev)
 {
-	int rx_chains = dev->mt76.antenna_mask;
+	int rx_chains = dev->mphy.antenna_mask;
 	int tx_chains = hweight8(rx_chains) - 1;
 
 	mt76_rmw(dev, MT_WF_RMAC_RMCR,
@@ -493,12 +493,12 @@ mt7603_init_txpower(struct mt7603_dev *dev,
 	target_power += max_offset;
 
 	dev->tx_power_limit = target_power;
-	dev->mt76.txpower_cur = target_power;
+	dev->mphy.txpower_cur = target_power;
 
 	target_power = DIV_ROUND_UP(target_power, 2);
 
 	/* add 3 dBm for 2SS devices (combined output) */
-	if (dev->mt76.antenna_mask & BIT(1))
+	if (dev->mphy.antenna_mask & BIT(1))
 		target_power += 3;
 
 	for (i = 0; i < sband->n_channels; i++) {
@@ -535,9 +535,9 @@ int mt7603_register_device(struct mt7603_dev *dev)
 		     (unsigned long)dev);
 
 	/* Check for 7688, which only has 1SS */
-	dev->mt76.antenna_mask = 3;
+	dev->mphy.antenna_mask = 3;
 	if (mt76_rr(dev, MT_EFUSE_BASE + 0x64) & BIT(4))
-		dev->mt76.antenna_mask = 1;
+		dev->mphy.antenna_mask = 1;
 
 	dev->slottime = 9;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 8a41bf118ed8..8cf6c430ef67 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -609,7 +609,7 @@ mt7603_mac_fill_rx(struct mt7603_dev *dev, struct sk_buff *skb)
 
 		status->rate_idx = i;
 
-		status->chains = dev->mt76.antenna_mask;
+		status->chains = dev->mphy.antenna_mask;
 		status->chain_signal[0] = FIELD_GET(MT_RXV4_IB_RSSI0, rxdg3) +
 					  dev->rssi_offset[0];
 		status->chain_signal[1] = FIELD_GET(MT_RXV4_IB_RSSI1, rxdg3) +
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
index 96197205fb82..bec58f567010 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
@@ -432,7 +432,7 @@ int mt7603_mcu_set_channel(struct mt7603_dev *dev)
 {
 	struct cfg80211_chan_def *chandef = &dev->mphy.chandef;
 	struct ieee80211_hw *hw = mt76_hw(dev);
-	int n_chains = hweight8(dev->mt76.antenna_mask);
+	int n_chains = hweight8(dev->mphy.antenna_mask);
 	struct {
 		u8 control_chan;
 		u8 center_chan;
@@ -461,11 +461,11 @@ int mt7603_mcu_set_channel(struct mt7603_dev *dev)
 	}
 
 	tx_power = hw->conf.power_level * 2;
-	if (dev->mt76.antenna_mask == 3)
+	if (dev->mphy.antenna_mask == 3)
 		tx_power -= 6;
 	tx_power = min(tx_power, dev->tx_power_limit);
 
-	dev->mt76.txpower_cur = tx_power;
+	dev->mphy.txpower_cur = tx_power;
 
 	for (i = 0; i < ARRAY_SIZE(req.txpower); i++)
 		req.txpower[i] = tx_power;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index 6bf8388410ef..7e540f0ec94d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -125,7 +125,7 @@ static void mt7615_eeprom_parse_hw_cap(struct mt7615_dev *dev)
 		tx_mask = max_nss;
 
 	dev->chainmask = tx_mask << 8 | rx_mask;
-	dev->mt76.antenna_mask = BIT(tx_mask) - 1;
+	dev->mphy.antenna_mask = BIT(tx_mask) - 1;
 }
 
 int mt7615_eeprom_get_power_index(struct mt7615_dev *dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index e071cafe80e4..f4dc756bad4b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -203,7 +203,7 @@ static void
 mt7615_init_txpower(struct mt7615_dev *dev,
 		    struct ieee80211_supported_band *sband)
 {
-	int i, n_chains = hweight8(dev->mt76.antenna_mask), target_chains;
+	int i, n_chains = hweight8(dev->mphy.antenna_mask), target_chains;
 	u8 *eep = (u8 *)dev->mt76.eeprom.data;
 	enum nl80211_band band = sband->band;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 727af49ca666..581cbf52482c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -218,14 +218,14 @@ int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 
 		status->enc_flags |= RX_ENC_FLAG_STBC_MASK * stbc;
 
-		status->chains = dev->mt76.antenna_mask;
+		status->chains = dev->mphy.antenna_mask;
 		status->chain_signal[0] = to_rssi(MT_RXV4_RCPI0, rxdg3);
 		status->chain_signal[1] = to_rssi(MT_RXV4_RCPI1, rxdg3);
 		status->chain_signal[2] = to_rssi(MT_RXV4_RCPI2, rxdg3);
 		status->chain_signal[3] = to_rssi(MT_RXV4_RCPI3, rxdg3);
 		status->signal = status->chain_signal[0];
 
-		for (i = 1; i < hweight8(dev->mt76.antenna_mask); i++) {
+		for (i = 1; i < hweight8(dev->mphy.antenna_mask); i++) {
 			if (!(status->chains & BIT(i)))
 				continue;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 3c5922d17e44..04804c87463a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1158,7 +1158,7 @@ int mt7615_mcu_set_bcn(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 
 int mt7615_mcu_set_tx_power(struct mt7615_dev *dev)
 {
-	int i, ret, n_chains = hweight8(dev->mt76.antenna_mask);
+	int i, ret, n_chains = hweight8(dev->mphy.antenna_mask);
 	struct cfg80211_chan_def *chandef = &dev->mphy.chandef;
 	int freq = chandef->center_freq1, len, target_chains;
 	u8 *req, *data, *eep = (u8 *)dev->mt76.eeprom.data;
@@ -1200,7 +1200,7 @@ int mt7615_mcu_set_tx_power(struct mt7615_dev *dev)
 		break;
 	}
 	tx_power = max_t(s8, tx_power, 0);
-	dev->mt76.txpower_cur = tx_power;
+	dev->mphy.txpower_cur = tx_power;
 
 	target_chains = mt7615_ext_pa_enabled(dev, band) ? 1 : n_chains;
 	for (i = 0; i < target_chains; i++) {
@@ -1300,7 +1300,7 @@ int mt7615_mcu_set_channel(struct mt7615_dev *dev)
 		.control_chan = chandef->chan->hw_value,
 		.center_chan = ieee80211_frequency_to_channel(freq1),
 		.tx_streams = (dev->chainmask >> 8) & 0xf,
-		.rx_streams_mask = dev->mt76.antenna_mask,
+		.rx_streams_mask = dev->mphy.antenna_mask,
 		.center_chan2 = ieee80211_frequency_to_channel(freq2),
 	};
 	int ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
index 0a10d1ee7553..cc28ad03155d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
@@ -849,7 +849,7 @@ void mt76x0_phy_set_txpower(struct mt76x02_dev *dev)
 
 	mt76x02_add_rate_power_offset(t, info);
 	mt76x02_limit_rate_power(t, dev->txpower_conf);
-	dev->mt76.txpower_cur = mt76x02_get_max_rate_power(t);
+	dev->mphy.txpower_cur = mt76x02_get_max_rate_power(t);
 	mt76x02_add_rate_power_offset(t, -info);
 
 	dev->target_power = info;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 846cd75e3e2d..e5685d9534e4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -193,10 +193,10 @@ void mt76x02_init_device(struct mt76x02_dev *dev)
 		dev->mphy.sband_5g.sband.ht_cap.cap |=
 				IEEE80211_HT_CAP_LDPC_CODING;
 		dev->chainmask = 0x202;
-		dev->mt76.antenna_mask = 3;
+		dev->mphy.antenna_mask = 3;
 	} else {
 		dev->chainmask = 0x101;
-		dev->mt76.antenna_mask = 1;
+		dev->mphy.antenna_mask = 1;
 	}
 }
 EXPORT_SYMBOL_GPL(mt76x02_init_device);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
index 3f82b9cec89e..dd336f54b8ee 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
@@ -125,7 +125,7 @@ static int mt76x2_set_antenna(struct ieee80211_hw *hw, u32 tx_ant,
 	mutex_lock(&dev->mt76.mutex);
 
 	dev->chainmask = (tx_ant == 3) ? 0x202 : 0x101;
-	dev->mt76.antenna_mask = tx_ant;
+	dev->mphy.antenna_mask = tx_ant;
 
 	mt76_set_stream_caps(&dev->mt76, true);
 	mt76x2_phy_set_antenna(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c
index e996b736a690..8831337df23e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c
@@ -74,7 +74,7 @@ void mt76x2_phy_set_antenna(struct mt76x02_dev *dev)
 
 	val = mt76_rr(dev, MT_BBP(AGC, 0));
 	val &= ~(BIT(4) | BIT(1));
-	switch (dev->mt76.antenna_mask) {
+	switch (dev->mphy.antenna_mask) {
 	case 1:
 		/* disable mac DAC control */
 		mt76_clear(dev, MT_BBP(IBI, 9), BIT(11));
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c b/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c
index 58f28e4e3952..91ab25c7d5ba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c
@@ -153,7 +153,7 @@ void mt76x2_phy_set_txpower(struct mt76x02_dev *dev)
 	mt76x2_get_rate_power(dev, &t, chan);
 	mt76x02_add_rate_power_offset(&t, txp.target_power + delta);
 	mt76x02_limit_rate_power(&t, dev->txpower_conf);
-	dev->mt76.txpower_cur = mt76x02_get_max_rate_power(&t);
+	dev->mphy.txpower_cur = mt76x02_get_max_rate_power(&t);
 
 	base_power = mt76x2_get_min_rate_power(&t);
 	delta = base_power - txp.target_power;
-- 
2.24.0

