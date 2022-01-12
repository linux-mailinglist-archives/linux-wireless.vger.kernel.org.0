Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DDC48C5B1
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jan 2022 15:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241463AbiALOOz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 09:14:55 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34160 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353993AbiALOOe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 09:14:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D89AB81EFA
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jan 2022 14:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89E4C36AE5;
        Wed, 12 Jan 2022 14:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641996871;
        bh=c12oc5lqeokbzrPew1P2RCZqiDsNJ3Am2x7sm1FtvgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tKG47hPdVoCydBOVVW+GUXy4tdvRntPOs67ONTray13eF7+1Isw5cTDhk6/MNTKWg
         NNdOSYj6hBQqChSrQLzLzTxQQ/Pec5T2iRebAsBSOV5/q2ptDqKh/5WU/uX+v5TrS2
         mtmbUpVv7EL0wDVDknAiojWZln6DxccPV6xxD+YGWGoyC06pQ29c/87XpT8nlFc/Fa
         kF7DiDQPz3VeuQ0mEFUdod3scBEvHEnUIlRvEVzYOisMSqxAWVXILhIqA5EymKCHy4
         XCDcAv0cspk5sGQyIXZxZiLHYaV2kUkI6p788ZSDHgl/edPYTSXQMBF6cpGEwxgcEN
         KQBxS6Y4hjTpA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        owen.peng@mediatek.com
Subject: [PATCH 1/6] mt76: mt7915: introduce mt7915_set_radar_background routine
Date:   Wed, 12 Jan 2022 15:13:48 +0100
Message-Id: <2528a8958879b0ee1b45106aeedee3e83188c435.1641996493.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1641996493.git.lorenzo@kernel.org>
References: <cover.1641996493.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt7915_mcu_rdd_background_enable and
mt7915_mcu_background_chain_ctrl routines to configure rx dfs dedicated chain.
This is a preliminary patch to add zero-wait dfs support performing CAC
detection on rdd2.

Tested-by: Owen Peng <owen.peng@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  3 +
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 50 ++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 93 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   | 23 +++++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  7 ++
 6 files changed, 177 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 1ebe02f55267..7b9d82dd3f9d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -977,6 +977,7 @@ enum {
 	MCU_EXT_CMD_SCS_CTRL = 0x82,
 	MCU_EXT_CMD_TWT_AGRT_UPDATE = 0x94,
 	MCU_EXT_CMD_FW_DBG_CTRL = 0x95,
+	MCU_EXT_CMD_OFFCH_SCAN_CTRL = 0x9a,
 	MCU_EXT_CMD_SET_RDD_TH = 0x9d,
 	MCU_EXT_CMD_MURU_CTRL = 0x9f,
 	MCU_EXT_CMD_SET_SPR = 0xa8,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 9613192b66c4..5c1643963506 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -293,6 +293,9 @@ mt7915_regd_notifier(struct wiphy *wiphy,
 	memcpy(dev->mt76.alpha2, request->alpha2, sizeof(dev->mt76.alpha2));
 	dev->mt76.region = request->dfs_region;
 
+	if (dev->mt76.region == NL80211_DFS_UNSET)
+		mt7915_mcu_rdd_background_enable(phy, NULL);
+
 	mt7915_init_txpower(dev, &mphy->sband_2g.sband);
 	mt7915_init_txpower(dev, &mphy->sband_5g.sband);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index b45b75f98c4d..3620aa873417 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1353,6 +1353,55 @@ mt7915_twt_teardown_request(struct ieee80211_hw *hw,
 	mutex_unlock(&dev->mt76.mutex);
 }
 
+static int
+mt7915_set_radar_background(struct ieee80211_hw *hw,
+			    struct cfg80211_chan_def *chandef)
+{
+	struct mt7915_phy *phy = mt7915_hw_phy(hw);
+	struct mt7915_dev *dev = phy->dev;
+	int ret = -EINVAL;
+	bool running;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if (dev->mt76.region == NL80211_DFS_UNSET)
+		goto out;
+
+	if (dev->rdd2_phy && dev->rdd2_phy != phy) {
+		/* rdd2 is already locked */
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/* rdd2 already configured on a radar channel */
+	running = dev->rdd2_phy &&
+		  cfg80211_chandef_valid(&dev->rdd2_chandef) &&
+		  !!(dev->rdd2_chandef.chan->flags & IEEE80211_CHAN_RADAR);
+
+	if (!chandef || running ||
+	    !(chandef->chan->flags & IEEE80211_CHAN_RADAR)) {
+		ret = mt7915_mcu_rdd_background_enable(phy, NULL);
+		if (ret)
+			goto out;
+
+		if (!running)
+			goto update_phy;
+	}
+
+	ret = mt7915_mcu_rdd_background_enable(phy, chandef);
+	if (ret)
+		goto out;
+
+update_phy:
+	dev->rdd2_phy = chandef ? phy : NULL;
+	if (chandef)
+		dev->rdd2_chandef = *chandef;
+out:
+	mutex_unlock(&dev->mt76.mutex);
+
+	return ret;
+}
+
 const struct ieee80211_ops mt7915_ops = {
 	.tx = mt7915_tx,
 	.start = mt7915_start,
@@ -1399,4 +1448,5 @@ const struct ieee80211_ops mt7915_ops = {
 #ifdef CONFIG_MAC80211_DEBUGFS
 	.sta_add_debugfs = mt7915_sta_add_debugfs,
 #endif
+	.set_radar_background = mt7915_set_radar_background,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 66f8daf3168c..dddefeebc7dd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2629,6 +2629,99 @@ int mt7915_mcu_set_radar_th(struct mt7915_dev *dev, int index,
 				 sizeof(req), true);
 }
 
+static int
+mt7915_mcu_background_chain_ctrl(struct mt7915_phy *phy,
+				 struct cfg80211_chan_def *chandef,
+				 int cmd)
+{
+	struct mt7915_dev *dev = phy->dev;
+	struct mt76_phy *mphy = phy->mt76;
+	struct ieee80211_channel *chan = mphy->chandef.chan;
+	int freq = mphy->chandef.center_freq1;
+	struct mt7915_mcu_background_chain_ctrl req = {
+		.monitor_scan_type = 2, /* simple rx */
+	};
+
+	if (!chandef && cmd != CH_SWITCH_BACKGROUND_SCAN_STOP)
+		return -EINVAL;
+
+	if (!cfg80211_chandef_valid(&mphy->chandef))
+		return -EINVAL;
+
+	switch (cmd) {
+	case CH_SWITCH_BACKGROUND_SCAN_START: {
+		req.chan = chan->hw_value;
+		req.central_chan = ieee80211_frequency_to_channel(freq);
+		req.bw = mt76_connac_chan_bw(&mphy->chandef);
+		req.monitor_chan = chandef->chan->hw_value;
+		req.monitor_central_chan =
+			ieee80211_frequency_to_channel(chandef->center_freq1);
+		req.monitor_bw = mt76_connac_chan_bw(chandef);
+		req.band_idx = phy != &dev->phy;
+		req.scan_mode = 1;
+		break;
+	}
+	case CH_SWITCH_BACKGROUND_SCAN_RUNNING:
+		req.monitor_chan = chandef->chan->hw_value;
+		req.monitor_central_chan =
+			ieee80211_frequency_to_channel(chandef->center_freq1);
+		req.band_idx = phy != &dev->phy;
+		req.scan_mode = 2;
+		break;
+	case CH_SWITCH_BACKGROUND_SCAN_STOP:
+		req.chan = chan->hw_value;
+		req.central_chan = ieee80211_frequency_to_channel(freq);
+		req.bw = mt76_connac_chan_bw(&mphy->chandef);
+		req.tx_stream = hweight8(mphy->antenna_mask);
+		req.rx_stream = mphy->antenna_mask;
+		break;
+	default:
+		return -EINVAL;
+	}
+	req.band = chandef ? chandef->chan->band == NL80211_BAND_5GHZ : 1;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(OFFCH_SCAN_CTRL),
+				 &req, sizeof(req), false);
+}
+
+int mt7915_mcu_rdd_background_enable(struct mt7915_phy *phy,
+				     struct cfg80211_chan_def *chandef)
+{
+	struct mt7915_dev *dev = phy->dev;
+	int err, region;
+
+	if (!chandef) { /* disable offchain */
+		err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_STOP, MT_RX_SEL2,
+					      0, 0);
+		if (err)
+			return err;
+
+		return mt7915_mcu_background_chain_ctrl(phy, NULL,
+				CH_SWITCH_BACKGROUND_SCAN_STOP);
+	}
+
+	err = mt7915_mcu_background_chain_ctrl(phy, chandef,
+					       CH_SWITCH_BACKGROUND_SCAN_START);
+	if (err)
+		return err;
+
+	switch (dev->mt76.region) {
+	case NL80211_DFS_ETSI:
+		region = 0;
+		break;
+	case NL80211_DFS_JP:
+		region = 2;
+		break;
+	case NL80211_DFS_FCC:
+	default:
+		region = 1;
+		break;
+	}
+
+	return mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_START, MT_RX_SEL2,
+				       0, region);
+}
+
 int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)
 {
 	struct mt7915_dev *dev = phy->dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index aa05c6ceebb9..9417f7bc807a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -131,6 +131,29 @@ struct mt7915_mcu_rdd_report {
 	} hw_pulse[32];
 } __packed;
 
+struct mt7915_mcu_background_chain_ctrl {
+	u8 chan;		/* primary channel */
+	u8 central_chan;	/* central channel */
+	u8 bw;
+	u8 tx_stream;
+	u8 rx_stream;
+
+	u8 monitor_chan;	/* monitor channel */
+	u8 monitor_central_chan;/* monitor central channel */
+	u8 monitor_bw;
+	u8 monitor_tx_stream;
+	u8 monitor_rx_stream;
+
+	u8 scan_mode;		/* 0: ScanStop
+				 * 1: ScanStart
+				 * 2: ScanRunning
+				 */
+	u8 band_idx;		/* DBDC */
+	u8 monitor_scan_type;
+	u8 band;		/* 0: 2.4GHz, 1: 5GHz */
+	u8 rsv[2];
+} __packed;
+
 struct mt7915_mcu_eeprom {
 	u8 buffer_mode;
 	u8 format;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index cd7ee716f147..f5c22b86e1a9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -269,6 +269,10 @@ struct mt7915_dev {
 	struct tasklet_struct irq_tasklet;
 	struct mt7915_phy phy;
 
+	/* monitor rx chain configured channel */
+	struct cfg80211_chan_def rdd2_chandef;
+	struct mt7915_phy *rdd2_phy;
+
 	u16 chainmask;
 	u32 hif_idx;
 
@@ -328,6 +332,7 @@ enum {
 enum {
 	MT_RX_SEL0,
 	MT_RX_SEL1,
+	MT_RX_SEL2, /* monitor chain */
 };
 
 enum mt7915_rdd_cmd {
@@ -461,6 +466,8 @@ int mt7915_mcu_get_temperature(struct mt7915_phy *phy);
 int mt7915_mcu_set_thermal_throttling(struct mt7915_phy *phy, u8 state);
 int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta, struct rate_info *rate);
+int mt7915_mcu_rdd_background_enable(struct mt7915_phy *phy,
+				     struct cfg80211_chan_def *chandef);
 int mt7915_mcu_wa_cmd(struct mt7915_dev *dev, int cmd, u32 a1, u32 a2, u32 a3);
 int mt7915_mcu_fw_log_2_host(struct mt7915_dev *dev, u8 type, u8 ctrl);
 int mt7915_mcu_fw_dbg_ctrl(struct mt7915_dev *dev, u32 module, u8 level);
-- 
2.34.1

