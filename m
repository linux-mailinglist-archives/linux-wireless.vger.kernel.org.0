Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EA441B2BC
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 17:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241426AbhI1PQh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 11:16:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241317AbhI1PQf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 11:16:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E971A6120D;
        Tue, 28 Sep 2021 15:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632842096;
        bh=GhyEBoyPsopDHZPCNam8IPaqZxPJbSzDmlCSgCWRPgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lz8NEZU63vLHEOVNFeNsBRnY/o4IjHvABKlPiH0dAkWW9kBFAcv2zFamNupoZsdCk
         U43BAFj4MlIgALS2N1oCelKBq2V98lqcLFxau1gUdLEofQ4ABeqUQDpfmMi9ptEA6n
         9x/WVZfppxcsIzBXVc5X9xr23pGiix+Fk9gDfMWgJ76mXfd9vlczfhAd/8Xlc+9Vid
         oje/B+xD1umPPI4ksu5g78KLhVl2QDiuCsypDhVPxYRhwEcJdLF0xvJOFuNKDFCPmr
         lrXuq1RBtTxOf8NZAPajp5518QvlfQjmnOt6bCMtxz7vsUscHAAusFEo46wMq/LcaG
         soaukvybRkLBw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com, john@phrozen.org
Subject: [RFC 4/7] mt76: mt7915: introduce mt7915_set_offchan_chain routine
Date:   Tue, 28 Sep 2021 17:14:35 +0200
Message-Id: <a45939bb6dbc5acdfc1d50b3e3266bbf82838ce8.1632841652.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632841652.git.lorenzo@kernel.org>
References: <cover.1632841652.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt7915_dfs_set_rdd_monitor and mt7915_mcu_set_offchan_ctrl
routines to configure rx dfs dedicated chain.
This is a preliminary patch to add zero-wait dfs support performing CAC
detection on rdd2.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  2 +
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 35 +++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 32 ++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 52 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   | 24 +++++++++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  8 +++
 6 files changed, 153 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 8c42a1668013..ba4d644fe846 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -296,6 +296,8 @@ mt7915_regd_notifier(struct wiphy *wiphy,
 	mt7915_init_txpower(dev, &mphy->sband_2g.sband);
 	mt7915_init_txpower(dev, &mphy->sband_5g.sband);
 
+	mt7915_dfs_set_rdd_monitor(phy, dev->mt76.region != NL80211_DFS_UNSET);
+
 	if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR))
 		return;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 899d2e228c1f..a2f94bedf9a1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -2316,3 +2316,38 @@ void mt7915_mac_twt_teardown_flow(struct mt7915_dev *dev,
 	dev->twt.table_mask &= ~BIT(flow->table_id);
 	dev->twt.n_agrt--;
 }
+
+int mt7915_dfs_set_rdd_monitor(struct mt7915_phy *phy, bool enable)
+{
+	struct mt7915_dev *dev = phy->dev;
+	int err, region;
+
+	if (!enable || dev->mt76.region == NL80211_DFS_UNSET) {
+		err = mt7915_mcu_rdd_cmd(dev, RDD_STOP, MT_RX_SEL2, 0, 0);
+		if (err)
+			return err;
+
+		return mt7915_mcu_set_offchan_ctrl(phy,
+						   CH_SWITCH_BACKGROUND_SCAN_STOP);
+	}
+
+	err = mt7915_mcu_set_offchan_ctrl(phy,
+					  CH_SWITCH_BACKGROUND_SCAN_START);
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
+	return mt7915_mcu_rdd_cmd(dev, RDD_START, MT_RX_SEL2, 0, region);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index ce1c68cf061a..406517bfbfc2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1085,6 +1085,37 @@ mt7915_twt_teardown_request(struct ieee80211_hw *hw,
 	mutex_unlock(&dev->mt76.mutex);
 }
 
+static int
+mt7915_set_offchan_chain(struct ieee80211_hw *hw,
+			 struct cfg80211_chan_def *chandef)
+{
+	struct mt7915_phy *phy = mt7915_hw_phy(hw);
+	struct cfg80211_chan_def *off_chandef;
+	struct mt7915_dev *dev = phy->dev;
+	bool running;
+
+	off_chandef = &dev->offchan_chain.chandef;
+	if (cfg80211_chandef_identical(chandef, off_chandef))
+		return 0;
+
+	if (cfg80211_chandef_identical(&phy->mt76->chandef, off_chandef))
+		return 0;
+
+	running = off_chandef->chan &&
+		  !!(off_chandef->chan->flags & IEEE80211_CHAN_RADAR);
+	*off_chandef = *chandef;
+
+	if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR) || running) {
+		int ret;
+
+		ret = mt7915_dfs_set_rdd_monitor(phy, false);
+		if (ret || !running)
+			return ret;
+	}
+
+	return mt7915_dfs_set_rdd_monitor(phy, true);
+}
+
 const struct ieee80211_ops mt7915_ops = {
 	.tx = mt7915_tx,
 	.start = mt7915_start,
@@ -1127,4 +1158,5 @@ const struct ieee80211_ops mt7915_ops = {
 #ifdef CONFIG_MAC80211_DEBUGFS
 	.sta_add_debugfs = mt7915_sta_add_debugfs,
 #endif
+	.set_offchan_chain = mt7915_set_offchan_chain,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index df3a9dc1ca35..6249be262825 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3204,6 +3204,58 @@ int mt7915_mcu_set_radar_th(struct mt7915_dev *dev, int index,
 				 sizeof(req), true);
 }
 
+int mt7915_mcu_set_offchan_ctrl(struct mt7915_phy *phy, int cmd)
+{
+	struct mt7915_dev *dev = phy->dev;
+	struct mt76_phy *mphy = phy->mt76;
+	struct ieee80211_channel *chan = mphy->chandef.chan;
+	struct cfg80211_chan_def *off_chandef = &dev->offchan_chain.chandef;
+	struct ieee80211_channel *off_chan = off_chandef->chan;
+	int offchan_freq = off_chandef->center_freq1;
+	int freq = mphy->chandef.center_freq1;
+	struct mt7915_mcu_offchan_ctrl req = {
+		.monitor_scan_type = 2, /* simple rx */
+	};
+
+	if (!off_chan)
+		return -EINVAL;
+
+	switch (cmd) {
+	case CH_SWITCH_BACKGROUND_SCAN_START: {
+		req.chan = chan->hw_value;
+		req.central_chan = ieee80211_frequency_to_channel(freq);
+		req.bw = mt7915_mcu_chan_bw(&mphy->chandef);
+		req.monitor_chan = off_chan->hw_value;
+		req.monitor_central_chan =
+			ieee80211_frequency_to_channel(offchan_freq);
+		req.monitor_bw = mt7915_mcu_chan_bw(off_chandef);
+		req.band_idx = phy != &dev->phy;
+		req.scan_mode = 1;
+		break;
+	}
+	case CH_SWITCH_BACKGROUND_SCAN_RUNNING:
+		req.monitor_chan = off_chan->hw_value;
+		req.monitor_central_chan =
+			ieee80211_frequency_to_channel(offchan_freq);
+		req.band_idx = phy != &dev->phy;
+		req.scan_mode = 2;
+		break;
+	case CH_SWITCH_BACKGROUND_SCAN_STOP:
+		req.chan = chan->hw_value;
+		req.central_chan = ieee80211_frequency_to_channel(freq);
+		req.bw = mt7915_mcu_chan_bw(&mphy->chandef);
+		req.tx_stream = hweight8(mphy->antenna_mask);
+		req.rx_stream = mphy->antenna_mask;
+		break;
+	default:
+		return -EINVAL;
+	}
+	req.band = off_chan->band == NL80211_BAND_5GHZ;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(OFFCH_SCAN_CTRL),
+				 &req, sizeof(req), false);
+}
+
 int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)
 {
 	struct mt7915_dev *dev = phy->dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 0bd66c5136e9..8e0b219de8bc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -152,6 +152,29 @@ struct mt7915_mcu_rdd_report {
 	} hw_pulse[32];
 } __packed;
 
+struct mt7915_mcu_offchan_ctrl  {
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
@@ -279,6 +302,7 @@ enum {
 	MCU_EXT_CMD_SCS_CTRL = 0x82,
 	MCU_EXT_CMD_TWT_AGRT_UPDATE = 0x94,
 	MCU_EXT_CMD_FW_DBG_CTRL = 0x95,
+	MCU_EXT_CMD_OFFCH_SCAN_CTRL = 0x9a,
 	MCU_EXT_CMD_SET_RDD_TH = 0x9d,
 	MCU_EXT_CMD_MURU_CTRL = 0x9f,
 	MCU_EXT_CMD_SET_SPR = 0xa8,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 0cd09767455a..65017a4347b9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -191,6 +191,11 @@ struct mt7915_dev {
 	struct tasklet_struct irq_tasklet;
 	struct mt7915_phy phy;
 
+	/* monitor rx chain configured channel */
+	struct {
+		struct cfg80211_chan_def chandef;
+	} offchan_chain;
+
 	u16 chainmask;
 	u32 hif_idx;
 
@@ -251,6 +256,7 @@ enum {
 enum {
 	MT_RX_SEL0,
 	MT_RX_SEL1,
+	MT_RX_SEL2, /* monitor chain */
 };
 
 enum mt7915_rdd_cmd {
@@ -389,6 +395,7 @@ int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta, struct rate_info *rate);
 int mt7915_mcu_rdd_cmd(struct mt7915_dev *dev, enum mt7915_rdd_cmd cmd,
 		       u8 index, u8 rx_sel, u8 val);
+int mt7915_mcu_set_offchan_ctrl(struct mt7915_phy *phy, int cmd);
 int mt7915_mcu_fw_log_2_host(struct mt7915_dev *dev, u8 ctrl);
 int mt7915_mcu_fw_dbg_ctrl(struct mt7915_dev *dev, u32 module, u8 level);
 void mt7915_mcu_rx_event(struct mt7915_dev *dev, struct sk_buff *skb);
@@ -455,6 +462,7 @@ void mt7915_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps);
 void mt7915_stats_work(struct work_struct *work);
 int mt76_dfs_start_rdd(struct mt7915_dev *dev, bool force);
 int mt7915_dfs_init_radar_detector(struct mt7915_phy *phy);
+int mt7915_dfs_set_rdd_monitor(struct mt7915_phy *phy, bool enable);
 void mt7915_set_stream_he_caps(struct mt7915_phy *phy);
 void mt7915_set_stream_vht_txbf_caps(struct mt7915_phy *phy);
 void mt7915_update_channel(struct mt76_phy *mphy);
-- 
2.31.1

