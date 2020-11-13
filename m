Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76AF2B18CD
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 11:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgKMKLr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Nov 2020 05:11:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:55568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbgKMKLr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Nov 2020 05:11:47 -0500
Received: from lore-desk.redhat.com (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5317206FB;
        Fri, 13 Nov 2020 10:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605262306;
        bh=yRLHaqUJW/pRjV6OJjNL1Lbggjb8poxck0rdo8Rin8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h3uBgm09R1SYKRIRBsPvvpm5njCYv9zjoCn25Rn7uOO9CzNKuRFbfHxDDop+ScafO
         QK30pEFHiFM74bQ2DrLzTtD2zImDEXvFZYJfruMr2AJBTx+fjXwIx25335Obnk3QN0
         95ETvB6NbARjL5eiVMwxfHASCOrY4BN3S+T8lULc=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, shayne.chen@mediatek.com
Subject: [PATCH v2 3/3] mt76: mt7915: get rid of dbdc debugfs knob
Date:   Fri, 13 Nov 2020 11:11:32 +0100
Message-Id: <eb1fad4445a84626fb26153be0e1fc5a413c52f4.1605261982.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605261982.git.lorenzo@kernel.org>
References: <cover.1605261982.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt7915 automatically detects dbdc feature so drop debugfs knob.
Move if_comb, mt7915_rates, if_limits structs and mt7915_regd_notifier(),
mt7915_init_wiphy() routines at the begging of init.c in order to make
mt7915_register_ext_phy routine static

Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  27 --
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 324 +++++++++---------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   2 -
 3 files changed, 162 insertions(+), 191 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 39fa0745b852..7d810fbf2862 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -47,32 +47,6 @@ mt7915_radar_trigger(void *data, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_radar_trigger, NULL,
 			 mt7915_radar_trigger, "%lld\n");
 
-static int
-mt7915_dbdc_set(void *data, u64 val)
-{
-	struct mt7915_dev *dev = data;
-
-	if (val)
-		mt7915_register_ext_phy(dev);
-	else
-		mt7915_unregister_ext_phy(dev);
-
-	return 0;
-}
-
-static int
-mt7915_dbdc_get(void *data, u64 *val)
-{
-	struct mt7915_dev *dev = data;
-
-	*val = !!mt7915_ext_phy(dev);
-
-	return 0;
-}
-
-DEFINE_DEBUGFS_ATTRIBUTE(fops_dbdc, mt7915_dbdc_get,
-			 mt7915_dbdc_set, "%lld\n");
-
 static int
 mt7915_fw_debug_set(void *data, u64 val)
 {
@@ -380,7 +354,6 @@ int mt7915_init_debugfs(struct mt7915_dev *dev)
 	debugfs_create_devm_seqfile(dev->mt76.dev, "acq", dir,
 				    mt7915_queues_acq);
 	debugfs_create_file("tx_stats", 0400, dir, dev, &fops_tx_stats);
-	debugfs_create_file("dbdc", 0600, dir, dev, &fops_dbdc);
 	debugfs_create_file("fw_debug", 0600, dir, dev, &fops_fw_debug);
 	debugfs_create_u32("dfs_hw_pattern", 0400, dir, &dev->hw_pattern);
 	/* test knobs */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 95183dcd405a..ff29a8090739 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -6,6 +6,113 @@
 #include "mac.h"
 #include "eeprom.h"
 
+#define CCK_RATE(_idx, _rate) {						\
+	.bitrate = _rate,						\
+	.flags = IEEE80211_RATE_SHORT_PREAMBLE,				\
+	.hw_value = (MT_PHY_TYPE_CCK << 8) | (_idx),			\
+	.hw_value_short = (MT_PHY_TYPE_CCK << 8) | (4 + (_idx)),	\
+}
+
+#define OFDM_RATE(_idx, _rate) {					\
+	.bitrate = _rate,						\
+	.hw_value = (MT_PHY_TYPE_OFDM << 8) | (_idx),			\
+	.hw_value_short = (MT_PHY_TYPE_OFDM << 8) | (_idx),		\
+}
+
+static struct ieee80211_rate mt7915_rates[] = {
+	CCK_RATE(0, 10),
+	CCK_RATE(1, 20),
+	CCK_RATE(2, 55),
+	CCK_RATE(3, 110),
+	OFDM_RATE(11, 60),
+	OFDM_RATE(15, 90),
+	OFDM_RATE(10, 120),
+	OFDM_RATE(14, 180),
+	OFDM_RATE(9,  240),
+	OFDM_RATE(13, 360),
+	OFDM_RATE(8,  480),
+	OFDM_RATE(12, 540),
+};
+
+static const struct ieee80211_iface_limit if_limits[] = {
+	{
+		.max = 1,
+		.types = BIT(NL80211_IFTYPE_ADHOC)
+	}, {
+		.max = 16,
+		.types = BIT(NL80211_IFTYPE_AP) |
+#ifdef CONFIG_MAC80211_MESH
+			 BIT(NL80211_IFTYPE_MESH_POINT)
+#endif
+	}, {
+		.max = MT7915_MAX_INTERFACES,
+		.types = BIT(NL80211_IFTYPE_STATION)
+	}
+};
+
+static const struct ieee80211_iface_combination if_comb[] = {
+	{
+		.limits = if_limits,
+		.n_limits = ARRAY_SIZE(if_limits),
+		.max_interfaces = MT7915_MAX_INTERFACES,
+		.num_different_channels = 1,
+		.beacon_int_infra_match = true,
+		.radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
+				       BIT(NL80211_CHAN_WIDTH_20) |
+				       BIT(NL80211_CHAN_WIDTH_40) |
+				       BIT(NL80211_CHAN_WIDTH_80) |
+				       BIT(NL80211_CHAN_WIDTH_160) |
+				       BIT(NL80211_CHAN_WIDTH_80P80),
+	}
+};
+
+static void
+mt7915_regd_notifier(struct wiphy *wiphy,
+		     struct regulatory_request *request)
+{
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct mt7915_dev *dev = mt7915_hw_dev(hw);
+	struct mt76_phy *mphy = hw->priv;
+	struct mt7915_phy *phy = mphy->priv;
+	struct cfg80211_chan_def *chandef = &mphy->chandef;
+
+	dev->mt76.region = request->dfs_region;
+
+	if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR))
+		return;
+
+	mt7915_dfs_init_radar_detector(phy);
+}
+
+static void
+mt7915_init_wiphy(struct ieee80211_hw *hw)
+{
+	struct mt7915_phy *phy = mt7915_hw_phy(hw);
+	struct wiphy *wiphy = hw->wiphy;
+
+	hw->queues = 4;
+	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF;
+	hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF;
+
+	phy->slottime = 9;
+
+	hw->sta_data_size = sizeof(struct mt7915_sta);
+	hw->vif_data_size = sizeof(struct mt7915_vif);
+
+	wiphy->iface_combinations = if_comb;
+	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
+	wiphy->reg_notifier = mt7915_regd_notifier;
+	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
+
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
+
+	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
+	ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
+	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
+
+	hw->max_tx_fragments = 4;
+}
+
 static void
 mt7915_mac_init_band(struct mt7915_dev *dev, u8 band)
 {
@@ -109,6 +216,60 @@ static void mt7915_init_txpower(struct mt7915_dev *dev)
 	mt7915_eeprom_init_sku(dev);
 }
 
+static int mt7915_register_ext_phy(struct mt7915_dev *dev)
+{
+	struct mt7915_phy *phy = mt7915_ext_phy(dev);
+	struct mt76_phy *mphy;
+	int ret;
+
+	if (!dev->dbdc_support)
+		return 0;
+
+	if (phy)
+		return 0;
+
+	mphy = mt76_alloc_phy(&dev->mt76, sizeof(*phy), &mt7915_ops);
+	if (!mphy)
+		return -ENOMEM;
+
+	phy = mphy->priv;
+	phy->dev = dev;
+	phy->mt76 = mphy;
+	phy->chainmask = dev->chainmask & ~dev->phy.chainmask;
+	mphy->antenna_mask = BIT(hweight8(phy->chainmask)) - 1;
+	mt7915_init_wiphy(mphy->hw);
+
+	INIT_LIST_HEAD(&phy->stats_list);
+	INIT_DELAYED_WORK(&phy->mac_work, mt7915_mac_work);
+
+	mt7915_eeprom_parse_band_config(phy);
+	mt7915_set_stream_vht_txbf_caps(phy);
+	mt7915_set_stream_he_caps(phy);
+
+	memcpy(mphy->macaddr, dev->mt76.eeprom.data + MT_EE_MAC_ADDR2,
+	       ETH_ALEN);
+	mt76_eeprom_override(mphy);
+
+	/* The second interface does not get any packets unless it has a vif */
+	ieee80211_hw_set(mphy->hw, WANT_MONITOR_VIF);
+
+	ret = mt7915_init_tx_queues(phy, MT7915_TXQ_BAND1,
+				    MT7915_TX_RING_SIZE);
+	if (ret)
+		goto error;
+
+	ret = mt76_register_phy(mphy, true, mt7915_rates,
+				ARRAY_SIZE(mt7915_rates));
+	if (ret)
+		goto error;
+
+	return 0;
+
+error:
+	ieee80211_free_hw(mphy->hw);
+	return ret;
+}
+
 static void mt7915_init_work(struct work_struct *work)
 {
 	struct mt7915_dev *dev = container_of(work, struct mt7915_dev,
@@ -166,113 +327,6 @@ static int mt7915_init_hardware(struct mt7915_dev *dev)
 	return 0;
 }
 
-#define CCK_RATE(_idx, _rate) {						\
-	.bitrate = _rate,						\
-	.flags = IEEE80211_RATE_SHORT_PREAMBLE,				\
-	.hw_value = (MT_PHY_TYPE_CCK << 8) | (_idx),			\
-	.hw_value_short = (MT_PHY_TYPE_CCK << 8) | (4 + (_idx)),	\
-}
-
-#define OFDM_RATE(_idx, _rate) {					\
-	.bitrate = _rate,						\
-	.hw_value = (MT_PHY_TYPE_OFDM << 8) | (_idx),			\
-	.hw_value_short = (MT_PHY_TYPE_OFDM << 8) | (_idx),		\
-}
-
-static struct ieee80211_rate mt7915_rates[] = {
-	CCK_RATE(0, 10),
-	CCK_RATE(1, 20),
-	CCK_RATE(2, 55),
-	CCK_RATE(3, 110),
-	OFDM_RATE(11, 60),
-	OFDM_RATE(15, 90),
-	OFDM_RATE(10, 120),
-	OFDM_RATE(14, 180),
-	OFDM_RATE(9,  240),
-	OFDM_RATE(13, 360),
-	OFDM_RATE(8,  480),
-	OFDM_RATE(12, 540),
-};
-
-static const struct ieee80211_iface_limit if_limits[] = {
-	{
-		.max = 1,
-		.types = BIT(NL80211_IFTYPE_ADHOC)
-	}, {
-		.max = 16,
-		.types = BIT(NL80211_IFTYPE_AP) |
-#ifdef CONFIG_MAC80211_MESH
-			 BIT(NL80211_IFTYPE_MESH_POINT)
-#endif
-	}, {
-		.max = MT7915_MAX_INTERFACES,
-		.types = BIT(NL80211_IFTYPE_STATION)
-	}
-};
-
-static const struct ieee80211_iface_combination if_comb[] = {
-	{
-		.limits = if_limits,
-		.n_limits = ARRAY_SIZE(if_limits),
-		.max_interfaces = MT7915_MAX_INTERFACES,
-		.num_different_channels = 1,
-		.beacon_int_infra_match = true,
-		.radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
-				       BIT(NL80211_CHAN_WIDTH_20) |
-				       BIT(NL80211_CHAN_WIDTH_40) |
-				       BIT(NL80211_CHAN_WIDTH_80) |
-				       BIT(NL80211_CHAN_WIDTH_160) |
-				       BIT(NL80211_CHAN_WIDTH_80P80),
-	}
-};
-
-static void
-mt7915_regd_notifier(struct wiphy *wiphy,
-		     struct regulatory_request *request)
-{
-	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
-	struct mt7915_dev *dev = mt7915_hw_dev(hw);
-	struct mt76_phy *mphy = hw->priv;
-	struct mt7915_phy *phy = mphy->priv;
-	struct cfg80211_chan_def *chandef = &mphy->chandef;
-
-	dev->mt76.region = request->dfs_region;
-
-	if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR))
-		return;
-
-	mt7915_dfs_init_radar_detector(phy);
-}
-
-static void
-mt7915_init_wiphy(struct ieee80211_hw *hw)
-{
-	struct mt7915_phy *phy = mt7915_hw_phy(hw);
-	struct wiphy *wiphy = hw->wiphy;
-
-	hw->queues = 4;
-	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF;
-	hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF;
-
-	phy->slottime = 9;
-
-	hw->sta_data_size = sizeof(struct mt7915_sta);
-	hw->vif_data_size = sizeof(struct mt7915_vif);
-
-	wiphy->iface_combinations = if_comb;
-	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
-	wiphy->reg_notifier = mt7915_regd_notifier;
-	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
-
-	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
-
-	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
-	ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
-	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
-
-	hw->max_tx_fragments = 4;
-}
-
 void mt7915_set_stream_vht_txbf_caps(struct mt7915_phy *phy)
 {
 	int nss = hweight8(phy->chainmask);
@@ -546,61 +600,7 @@ void mt7915_set_stream_he_caps(struct mt7915_phy *phy)
 	}
 }
 
-int mt7915_register_ext_phy(struct mt7915_dev *dev)
-{
-	struct mt7915_phy *phy = mt7915_ext_phy(dev);
-	struct mt76_phy *mphy;
-	int ret;
-
-	if (!dev->dbdc_support)
-		return 0;
-
-	if (phy)
-		return 0;
-
-	mphy = mt76_alloc_phy(&dev->mt76, sizeof(*phy), &mt7915_ops);
-	if (!mphy)
-		return -ENOMEM;
-
-	phy = mphy->priv;
-	phy->dev = dev;
-	phy->mt76 = mphy;
-	phy->chainmask = dev->chainmask & ~dev->phy.chainmask;
-	mphy->antenna_mask = BIT(hweight8(phy->chainmask)) - 1;
-	mt7915_init_wiphy(mphy->hw);
-
-	INIT_LIST_HEAD(&phy->stats_list);
-	INIT_DELAYED_WORK(&phy->mac_work, mt7915_mac_work);
-
-	mt7915_eeprom_parse_band_config(phy);
-	mt7915_set_stream_vht_txbf_caps(phy);
-	mt7915_set_stream_he_caps(phy);
-
-	memcpy(mphy->macaddr, dev->mt76.eeprom.data + MT_EE_MAC_ADDR2,
-	       ETH_ALEN);
-	mt76_eeprom_override(mphy);
-
-	/* The second interface does not get any packets unless it has a vif */
-	ieee80211_hw_set(mphy->hw, WANT_MONITOR_VIF);
-
-	ret = mt7915_init_tx_queues(phy, MT7915_TXQ_BAND1,
-				    MT7915_TX_RING_SIZE);
-	if (ret)
-		goto error;
-
-	ret = mt76_register_phy(mphy, true, mt7915_rates,
-				ARRAY_SIZE(mt7915_rates));
-	if (ret)
-		goto error;
-
-	return 0;
-
-error:
-	ieee80211_free_hw(mphy->hw);
-	return ret;
-}
-
-void mt7915_unregister_ext_phy(struct mt7915_dev *dev)
+static void mt7915_unregister_ext_phy(struct mt7915_dev *dev)
 {
 	struct mt7915_phy *phy = mt7915_ext_phy(dev);
 	struct mt76_phy *mphy = dev->mt76.phy2;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index f29b9c029328..30e53a0f01fb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -276,8 +276,6 @@ u32 mt7915_reg_map(struct mt7915_dev *dev, u32 addr);
 
 int mt7915_register_device(struct mt7915_dev *dev);
 void mt7915_unregister_device(struct mt7915_dev *dev);
-int mt7915_register_ext_phy(struct mt7915_dev *dev);
-void mt7915_unregister_ext_phy(struct mt7915_dev *dev);
 int mt7915_eeprom_init(struct mt7915_dev *dev);
 void mt7915_eeprom_parse_band_config(struct mt7915_phy *phy);
 int mt7915_eeprom_get_target_power(struct mt7915_dev *dev,
-- 
2.26.2

