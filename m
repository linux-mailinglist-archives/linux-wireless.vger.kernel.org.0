Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8921105A1
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2019 21:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfLCUCE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Dec 2019 15:02:04 -0500
Received: from nbd.name ([46.4.11.11]:55766 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbfLCUCE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Dec 2019 15:02:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3l/fxcXqfVWxcuXOMK7PKpPTjHW20rUe/lgBMMW5SEc=; b=HUYtaH08XD/SA5AjZlDIwilUQb
        ro/Hfy1wFfATIhxK0Kms/gVXoMq2vWKsG7dBaHK2oxnUisI0v1AMXguA2GhNERZgaj7hojdfirk9x
        +5km4hZw3rP4aeAA0GWr8ecvAh77eTLkZn9XaQQsHg3Lfys6kY0kkAUrHfkLckyMgYAQ=;
Received: from p5b2067e3.dip0.t-ipconnect.de ([91.32.103.227] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1icEN0-0005a0-Gp
        for linux-wireless@vger.kernel.org; Tue, 03 Dec 2019 21:02:02 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 720517291C18; Tue,  3 Dec 2019 21:02:01 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH v2 15/29] mt76: add function for allocating an extra wiphy
Date:   Tue,  3 Dec 2019 21:02:01 +0100
Message-Id: <20191203200201.29095-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130153045.28105-15-nbd@nbd.name>
References: <20191130153045.28105-15-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Unlike the core phy, this will have extra allocated memory for a driver
private struct.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v2: fix crash, don't rely on sband->band being initialized

 drivers/net/wireless/mediatek/mt76/mac80211.c | 179 +++++++++++++-----
 drivers/net/wireless/mediatek/mt76/mt76.h     |   5 +
 2 files changed, 135 insertions(+), 49 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 123321a0bc15..b4d9d9ac4f36 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -187,8 +187,6 @@ mt76_init_sband(struct mt76_dev *dev, struct mt76_sband *msband,
 	sband->n_channels = n_chan;
 	sband->bitrates = rates;
 	sband->n_bitrates = n_rates;
-	dev->phy.chandef.chan = &sband->channels[0];
-	dev->phy.chan_state = &msband->chan[0];
 
 	ht_cap = &sband->ht_cap;
 	ht_cap->ht_supported = true;
@@ -244,9 +242,10 @@ mt76_init_sband_5g(struct mt76_dev *dev, struct ieee80211_rate *rates,
 }
 
 static void
-mt76_check_sband(struct mt76_dev *dev, int band)
+mt76_check_sband(struct mt76_phy *phy, struct mt76_sband *msband,
+		 enum nl80211_band band)
 {
-	struct ieee80211_supported_band *sband = dev->hw->wiphy->bands[band];
+	struct ieee80211_supported_band *sband = &msband->sband;
 	bool found = false;
 	int i;
 
@@ -261,12 +260,132 @@ mt76_check_sband(struct mt76_dev *dev, int band)
 		break;
 	}
 
-	if (found)
+	if (found) {
+		phy->chandef.chan = &sband->channels[0];
+		phy->chan_state = &msband->chan[0];
 		return;
+	}
 
 	sband->n_channels = 0;
-	dev->hw->wiphy->bands[band] = NULL;
+	phy->hw->wiphy->bands[band] = NULL;
+}
+
+static void
+mt76_phy_init(struct mt76_dev *dev, struct ieee80211_hw *hw)
+{
+	struct wiphy *wiphy = hw->wiphy;
+
+	SET_IEEE80211_DEV(hw, dev->dev);
+	SET_IEEE80211_PERM_ADDR(hw, dev->macaddr);
+
+	wiphy->features |= NL80211_FEATURE_ACTIVE_MONITOR;
+
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_AIRTIME_FAIRNESS);
+
+	wiphy->available_antennas_tx = dev->phy.antenna_mask;
+	wiphy->available_antennas_rx = dev->phy.antenna_mask;
+
+	hw->txq_data_size = sizeof(struct mt76_txq);
+	hw->max_tx_fragments = 16;
+
+	ieee80211_hw_set(hw, SIGNAL_DBM);
+	ieee80211_hw_set(hw, PS_NULLFUNC_STACK);
+	ieee80211_hw_set(hw, HOST_BROADCAST_PS_BUFFERING);
+	ieee80211_hw_set(hw, AMPDU_AGGREGATION);
+	ieee80211_hw_set(hw, SUPPORTS_RC_TABLE);
+	ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
+	ieee80211_hw_set(hw, SUPPORTS_CLONED_SKBS);
+	ieee80211_hw_set(hw, SUPPORTS_AMSDU_IN_AMPDU);
+	ieee80211_hw_set(hw, TX_AMSDU);
+	ieee80211_hw_set(hw, TX_FRAG_LIST);
+	ieee80211_hw_set(hw, MFP_CAPABLE);
+	ieee80211_hw_set(hw, AP_LINK_PS);
+	ieee80211_hw_set(hw, REPORTS_TX_ACK_STATUS);
+	ieee80211_hw_set(hw, NEEDS_UNIQUE_STA_ADDR);
+
+	wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
+	wiphy->interface_modes =
+		BIT(NL80211_IFTYPE_STATION) |
+		BIT(NL80211_IFTYPE_AP) |
+#ifdef CONFIG_MAC80211_MESH
+		BIT(NL80211_IFTYPE_MESH_POINT) |
+#endif
+		BIT(NL80211_IFTYPE_ADHOC);
+}
+
+struct mt76_phy *
+mt76_alloc_phy(struct mt76_dev *dev, unsigned int size,
+	       const struct ieee80211_ops *ops)
+{
+	struct ieee80211_hw *hw;
+	struct mt76_phy *phy;
+	unsigned int phy_size, chan_size;
+	unsigned int size_2g, size_5g;
+	void *priv;
+
+	phy_size = ALIGN(sizeof(*phy), 8);
+	chan_size = sizeof(dev->phy.sband_2g.chan[0]);
+	size_2g = ALIGN(ARRAY_SIZE(mt76_channels_2ghz) * chan_size, 8);
+	size_5g = ALIGN(ARRAY_SIZE(mt76_channels_5ghz) * chan_size, 8);
+
+	size += phy_size + size_2g + size_5g;
+	hw = ieee80211_alloc_hw(size, ops);
+	if (!hw)
+		return NULL;
+
+	phy = hw->priv;
+	phy->dev = dev;
+	phy->hw = hw;
+
+	mt76_phy_init(dev, hw);
+
+	priv = hw->priv + phy_size;
+
+	phy->sband_2g = dev->phy.sband_2g;
+	phy->sband_2g.chan = priv;
+	priv += size_2g;
+
+	phy->sband_5g = dev->phy.sband_5g;
+	phy->sband_5g.chan = priv;
+	priv += size_5g;
+
+	phy->priv = priv;
+
+	hw->wiphy->bands[NL80211_BAND_2GHZ] = &phy->sband_2g.sband;
+	hw->wiphy->bands[NL80211_BAND_5GHZ] = &phy->sband_5g.sband;
+
+	mt76_check_sband(phy, &phy->sband_2g, NL80211_BAND_2GHZ);
+	mt76_check_sband(phy, &phy->sband_5g, NL80211_BAND_5GHZ);
+
+	return phy;
+}
+EXPORT_SYMBOL_GPL(mt76_alloc_phy);
+
+int
+mt76_register_phy(struct mt76_phy *phy)
+{
+	int ret;
+
+	ret = ieee80211_register_hw(phy->hw);
+	if (ret)
+		return ret;
+
+	phy->dev->phy2 = phy;
+	return 0;
 }
+EXPORT_SYMBOL_GPL(mt76_register_phy);
+
+void
+mt76_unregister_phy(struct mt76_phy *phy)
+{
+	struct mt76_dev *dev = phy->dev;
+
+	dev->phy2 = NULL;
+	mt76_tx_status_check(dev, NULL, true);
+	ieee80211_unregister_hw(phy->hw);
+}
+EXPORT_SYMBOL_GPL(mt76_unregister_phy);
 
 struct mt76_dev *
 mt76_alloc_device(struct device *pdev, unsigned int size,
@@ -313,49 +432,11 @@ int mt76_register_device(struct mt76_dev *dev, bool vht,
 			 struct ieee80211_rate *rates, int n_rates)
 {
 	struct ieee80211_hw *hw = dev->hw;
-	struct wiphy *wiphy = hw->wiphy;
+	struct mt76_phy *phy = &dev->phy;
 	int ret;
 
 	dev_set_drvdata(dev->dev, dev);
-
-	SET_IEEE80211_DEV(hw, dev->dev);
-	SET_IEEE80211_PERM_ADDR(hw, dev->macaddr);
-
-	wiphy->features |= NL80211_FEATURE_ACTIVE_MONITOR;
-
-	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
-	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_AIRTIME_FAIRNESS);
-
-	wiphy->available_antennas_tx = dev->phy.antenna_mask;
-	wiphy->available_antennas_rx = dev->phy.antenna_mask;
-
-	hw->txq_data_size = sizeof(struct mt76_txq);
-	hw->max_tx_fragments = 16;
-
-	ieee80211_hw_set(hw, SIGNAL_DBM);
-	ieee80211_hw_set(hw, PS_NULLFUNC_STACK);
-	ieee80211_hw_set(hw, HOST_BROADCAST_PS_BUFFERING);
-	ieee80211_hw_set(hw, AMPDU_AGGREGATION);
-	ieee80211_hw_set(hw, SUPPORTS_RC_TABLE);
-	ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
-	ieee80211_hw_set(hw, SUPPORTS_CLONED_SKBS);
-	ieee80211_hw_set(hw, SUPPORTS_AMSDU_IN_AMPDU);
-	ieee80211_hw_set(hw, TX_AMSDU);
-	ieee80211_hw_set(hw, TX_FRAG_LIST);
-	ieee80211_hw_set(hw, MFP_CAPABLE);
-	ieee80211_hw_set(hw, AP_LINK_PS);
-	ieee80211_hw_set(hw, REPORTS_TX_ACK_STATUS);
-	ieee80211_hw_set(hw, NEEDS_UNIQUE_STA_ADDR);
-	ieee80211_hw_set(hw, SUPPORTS_REORDERING_BUFFER);
-
-	wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
-	wiphy->interface_modes =
-		BIT(NL80211_IFTYPE_STATION) |
-		BIT(NL80211_IFTYPE_AP) |
-#ifdef CONFIG_MAC80211_MESH
-		BIT(NL80211_IFTYPE_MESH_POINT) |
-#endif
-		BIT(NL80211_IFTYPE_ADHOC);
+	mt76_phy_init(dev, hw);
 
 	if (dev->cap.has_2ghz) {
 		ret = mt76_init_sband_2g(dev, rates, n_rates);
@@ -369,9 +450,9 @@ int mt76_register_device(struct mt76_dev *dev, bool vht,
 			return ret;
 	}
 
-	wiphy_read_of_freq_limits(dev->hw->wiphy);
-	mt76_check_sband(dev, NL80211_BAND_2GHZ);
-	mt76_check_sband(dev, NL80211_BAND_5GHZ);
+	wiphy_read_of_freq_limits(hw->wiphy);
+	mt76_check_sband(&dev->phy, &phy->sband_2g, NL80211_BAND_2GHZ);
+	mt76_check_sband(&dev->phy, &phy->sband_5g, NL80211_BAND_5GHZ);
 
 	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
 		ret = mt76_led_init(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 4402361ac67d..e237ed72979b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -651,6 +651,11 @@ int mt76_register_device(struct mt76_dev *dev, bool vht,
 			 struct ieee80211_rate *rates, int n_rates);
 void mt76_unregister_device(struct mt76_dev *dev);
 void mt76_free_device(struct mt76_dev *dev);
+void mt76_unregister_phy(struct mt76_phy *phy);
+
+struct mt76_phy *mt76_alloc_phy(struct mt76_dev *dev, unsigned int size,
+				const struct ieee80211_ops *ops);
+int mt76_register_phy(struct mt76_phy *phy);
 
 struct dentry *mt76_register_debugfs(struct mt76_dev *dev);
 int mt76_queues_read(struct seq_file *s, void *data);
-- 
2.24.0

