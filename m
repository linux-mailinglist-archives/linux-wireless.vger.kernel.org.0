Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26FC4A8553
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Feb 2022 14:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350806AbiBCNgG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Feb 2022 08:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243587AbiBCNgE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Feb 2022 08:36:04 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124B4C06173B
        for <linux-wireless@vger.kernel.org>; Thu,  3 Feb 2022 05:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vYNVpJgHcqM/LDdXKHHVn+MBDNU+BYfUo3ztNlzTUwE=; b=TaD1GRcRIubkElsSS1f3IomYME
        R38TOinJU2Uj3b0gpLxNsmwRNXSm+x8f+lswl4aqSx4i7/m3baDcvPurZzVOZnVs7IaNn/F3xFfjE
        ti478ZECknZYszWzBx9ZuvnSek6+vOCNPLBU97e0x6o/dB2pFOG+COtspi4vSLKpKjvs=;
Received: from p200300daa71e0b007cedb37d167c1481.dip0.t-ipconnect.de ([2003:da:a71e:b00:7ced:b37d:167c:1481] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nFcHK-0001Et-Bi
        for linux-wireless@vger.kernel.org; Thu, 03 Feb 2022 14:36:02 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/5] mt76: mt7915: fix/rewrite the dfs state handling logic
Date:   Thu,  3 Feb 2022 14:35:58 +0100
Message-Id: <20220203133600.92211-3-nbd@nbd.name>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220203133600.92211-1-nbd@nbd.name>
References: <20220203133600.92211-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Client mode on DFS channels was broken, because the old code was activating
the DFS detector on radar channels while leaving it in CAC state.
This was caused by making the decision based on the channel radar flag,
instead of hw->conf.radar_enabled.
In order to properly deal with the various corner cases, rip out the state
handling code and replace it with something that's much easier to reason
about.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 28 ++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     |  9 ++++
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  7 +--
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 51 +++++++++++--------
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 21 --------
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  2 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  1 -
 7 files changed, 69 insertions(+), 50 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 148e126b9215..a4bb281a74e6 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -823,6 +823,10 @@ void mt76_set_channel(struct mt76_phy *phy)
 	wait_event_timeout(dev->tx_wait, !mt76_has_tx_pending(phy), timeout);
 	mt76_update_survey(phy);
 
+	if (phy->chandef.chan->center_freq != chandef->chan->center_freq ||
+	    phy->chandef.width != chandef->width)
+		phy->dfs_state = MT_DFS_STATE_UNKNOWN;
+
 	phy->chandef = *chandef;
 	phy->chan_state = mt76_channel_state(phy, chandef->chan);
 
@@ -1604,3 +1608,27 @@ void mt76_ethtool_worker(struct mt76_ethtool_worker_info *wi,
 	wi->worker_stat_count = ei - wi->initial_stat_idx;
 }
 EXPORT_SYMBOL_GPL(mt76_ethtool_worker);
+
+enum mt76_dfs_state mt76_phy_dfs_state(struct mt76_phy *phy)
+{
+	struct ieee80211_hw *hw = phy->hw;
+	struct mt76_dev *dev = phy->dev;
+
+	if (dev->region == NL80211_DFS_UNSET ||
+	    test_bit(MT76_SCANNING, &phy->state))
+		return MT_DFS_STATE_DISABLED;
+
+	if (!hw->conf.radar_enabled) {
+		if ((hw->conf.flags & IEEE80211_CONF_MONITOR) &&
+		    (phy->chandef.chan->flags & IEEE80211_CHAN_RADAR))
+			return MT_DFS_STATE_ACTIVE;
+
+		return MT_DFS_STATE_DISABLED;
+	}
+
+	if (phy->chandef.chan->dfs_state != NL80211_DFS_AVAILABLE)
+		return MT_DFS_STATE_CAC;
+
+	return MT_DFS_STATE_ACTIVE;
+}
+EXPORT_SYMBOL_GPL(mt76_phy_dfs_state);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 43abf0679876..8d5c484eee58 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -105,6 +105,13 @@ enum mt76_cipher_type {
 	MT_CIPHER_GCMP_256,
 };
 
+enum mt76_dfs_state {
+	MT_DFS_STATE_UNKNOWN,
+	MT_DFS_STATE_DISABLED,
+	MT_DFS_STATE_CAC,
+	MT_DFS_STATE_ACTIVE,
+};
+
 struct mt76_queue_buf {
 	dma_addr_t addr;
 	u16 len;
@@ -639,6 +646,7 @@ struct mt76_phy {
 	struct ieee80211_channel *main_chan;
 
 	struct mt76_channel_state *chan_state;
+	enum mt76_dfs_state dfs_state;
 	ktime_t survey_time;
 
 	struct mt76_hw_cap cap;
@@ -1184,6 +1192,7 @@ void mt76_sw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		  const u8 *mac);
 void mt76_sw_scan_complete(struct ieee80211_hw *hw,
 			   struct ieee80211_vif *vif);
+enum mt76_dfs_state mt76_phy_dfs_state(struct mt76_phy *phy);
 int mt76_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		      void *data, int len);
 int mt76_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index e908d56a9e21..705f362b8f7b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -288,7 +288,6 @@ mt7915_regd_notifier(struct wiphy *wiphy,
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt76_phy *mphy = hw->priv;
 	struct mt7915_phy *phy = mphy->priv;
-	struct cfg80211_chan_def *chandef = &mphy->chandef;
 
 	memcpy(dev->mt76.alpha2, request->alpha2, sizeof(dev->mt76.alpha2));
 	dev->mt76.region = request->dfs_region;
@@ -299,9 +298,7 @@ mt7915_regd_notifier(struct wiphy *wiphy,
 	mt7915_init_txpower(dev, &mphy->sband_2g.sband);
 	mt7915_init_txpower(dev, &mphy->sband_5g.sband);
 
-	if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR))
-		return;
-
+	mphy->dfs_state = MT_DFS_STATE_UNKNOWN;
 	mt7915_dfs_init_radar_detector(phy);
 }
 
@@ -976,8 +973,6 @@ int mt7915_register_device(struct mt7915_dev *dev)
 
 	mt7915_init_wiphy(hw);
 
-	dev->phy.dfs_state = -1;
-
 #ifdef CONFIG_NL80211_TESTMODE
 	dev->mt76.test_ops = &mt7915_testmode_ops;
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 88bc4cf0dd79..59f0334ef8d2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -2439,41 +2439,48 @@ mt7915_dfs_init_radar_specs(struct mt7915_phy *phy)
 
 int mt7915_dfs_init_radar_detector(struct mt7915_phy *phy)
 {
-	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
 	struct mt7915_dev *dev = phy->dev;
 	bool ext_phy = phy != &dev->phy;
+	enum mt76_dfs_state dfs_state, prev_state;
 	int err;
 
-	if (dev->mt76.region == NL80211_DFS_UNSET) {
-		phy->dfs_state = -1;
-		if (phy->rdd_state)
-			goto stop;
+	prev_state = phy->mt76->dfs_state;
+	dfs_state = mt76_phy_dfs_state(phy->mt76);
 
+	if (prev_state == dfs_state)
 		return 0;
-	}
 
-	if (test_bit(MT76_SCANNING, &phy->mt76->state))
-		return 0;
-
-	if (phy->dfs_state == chandef->chan->dfs_state)
-		return 0;
+	if (prev_state == MT_DFS_STATE_UNKNOWN)
+		mt7915_dfs_stop_radar_detector(phy);
 
-	err = mt7915_dfs_init_radar_specs(phy);
-	if (err < 0) {
-		phy->dfs_state = -1;
+	if (dfs_state == MT_DFS_STATE_DISABLED)
 		goto stop;
-	}
 
-	phy->dfs_state = chandef->chan->dfs_state;
+	if (prev_state <= MT_DFS_STATE_DISABLED) {
+		err = mt7915_dfs_init_radar_specs(phy);
+		if (err < 0)
+			return err;
+
+		err = mt7915_dfs_start_radar_detector(phy);
+		if (err < 0)
+			return err;
 
-	if (chandef->chan->flags & IEEE80211_CHAN_RADAR) {
-		if (chandef->chan->dfs_state != NL80211_DFS_AVAILABLE)
-			return mt7915_dfs_start_radar_detector(phy);
+		phy->mt76->dfs_state = MT_DFS_STATE_CAC;
+	}
+
+	if (dfs_state == MT_DFS_STATE_CAC)
+		return 0;
 
-		return mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_CAC_END,
-					       ext_phy, MT_RX_SEL0, 0);
+	err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_CAC_END,
+				      ext_phy, MT_RX_SEL0, 0);
+	if (err < 0) {
+		phy->mt76->dfs_state = MT_DFS_STATE_UNKNOWN;
+		return err;
 	}
 
+	phy->mt76->dfs_state = MT_DFS_STATE_ACTIVE;
+	return 0;
+
 stop:
 	err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_NORMAL_START, ext_phy,
 				      MT_RX_SEL0, 0);
@@ -2481,6 +2488,8 @@ int mt7915_dfs_init_radar_detector(struct mt7915_phy *phy)
 		return err;
 
 	mt7915_dfs_stop_radar_detector(phy);
+	phy->mt76->dfs_state = MT_DFS_STATE_DISABLED;
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 989298ffffbc..dee7fc011cdf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -302,26 +302,6 @@ static void mt7915_remove_interface(struct ieee80211_hw *hw,
 	mt76_packet_id_flush(&dev->mt76, &msta->wcid);
 }
 
-static void mt7915_init_dfs_state(struct mt7915_phy *phy)
-{
-	struct mt76_phy *mphy = phy->mt76;
-	struct ieee80211_hw *hw = mphy->hw;
-	struct cfg80211_chan_def *chandef = &hw->conf.chandef;
-
-	if (hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
-		return;
-
-	if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR) &&
-	    !(mphy->chandef.chan->flags & IEEE80211_CHAN_RADAR))
-		return;
-
-	if (mphy->chandef.chan->center_freq == chandef->chan->center_freq &&
-	    mphy->chandef.width == chandef->width)
-		return;
-
-	phy->dfs_state = -1;
-}
-
 int mt7915_set_channel(struct mt7915_phy *phy)
 {
 	struct mt7915_dev *dev = phy->dev;
@@ -332,7 +312,6 @@ int mt7915_set_channel(struct mt7915_phy *phy)
 	mutex_lock(&dev->mt76.mutex);
 	set_bit(MT76_RESET, &phy->mt76->state);
 
-	mt7915_init_dfs_state(phy);
 	mt76_set_channel(phy->mt76);
 
 	if (dev->flash_mode) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index e8c68e47b613..462c7da93b60 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2786,7 +2786,7 @@ int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)
 
 	if (phy->mt76->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
 		req.switch_reason = CH_SWITCH_SCAN_BYPASS_DPD;
-	else if ((chandef->chan->flags & IEEE80211_CHAN_RADAR) &&
+	else if (phy->mt76->hw->conf.radar_enabled &&
 		 chandef->chan->dfs_state != NL80211_DFS_AVAILABLE)
 		req.switch_reason = CH_SWITCH_DFS;
 	else
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index bc3a3dcdb3a0..96653d64d161 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -230,7 +230,6 @@ struct mt7915_phy {
 	u8 slottime;
 
 	u8 rdd_state;
-	int dfs_state;
 
 	u32 rx_ampdu_ts;
 	u32 ampdu_ref;
-- 
2.32.0 (Apple Git-132)

