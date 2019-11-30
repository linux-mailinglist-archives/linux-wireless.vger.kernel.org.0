Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6499B10DE1C
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Nov 2019 16:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfK3PbE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Nov 2019 10:31:04 -0500
Received: from nbd.name ([46.4.11.11]:56052 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727179AbfK3Pat (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Nov 2019 10:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=O/pIiu4tuh2j6obbQneagdkj+WfTuhzzsnKJGBsBGN0=; b=kqFqgCSmwQ964fcW3NNKF7Y7j3
        HxPC1VGWy6XTA4YSpYHDQyjyntXCS78HWMaRboIbv8khBYyokNBqKzj522NZfyJLeTVf/a2efpfwG
        VoBVj+QyK6VSEfINviDiWUgZd58PPBZLvwFk5zVF53guxtaYTNGMa/doC1IN2mMm2p4k=;
Received: from p5b2067e3.dip0.t-ipconnect.de ([91.32.103.227] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ib4hr-0006hi-AS
        for linux-wireless@vger.kernel.org; Sat, 30 Nov 2019 16:30:47 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 08CAB721EBDE; Sat, 30 Nov 2019 16:30:45 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 07/29] mt76: move channel state to struct mt76_phy
Date:   Sat, 30 Nov 2019 16:30:23 +0100
Message-Id: <20191130153045.28105-7-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130153045.28105-1-nbd@nbd.name>
References: <20191130153045.28105-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support for an extra wiphy in mt76_set_channel and mt76_get_survey
This is preparation for supporting multiple wiphys per device to support the
concurrent dual-band feature of MT7615D

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 71 +++++++++++--------
 drivers/net/wireless/mediatek/mt76/mt76.h     | 19 ++---
 .../net/wireless/mediatek/mt76/mt7603/init.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/mac.c   | 16 ++---
 .../net/wireless/mediatek/mt76/mt7603/main.c  |  8 +--
 .../net/wireless/mediatek/mt76/mt7603/mcu.c   |  6 +-
 .../net/wireless/mediatek/mt76/mt7615/init.c  | 12 ++--
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 24 +++----
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  6 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  6 +-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  4 +-
 .../wireless/mediatek/mt76/mt76x0/eeprom.c    |  4 +-
 .../net/wireless/mediatek/mt76/mt76x0/init.c  |  6 +-
 .../net/wireless/mediatek/mt76/mt76x0/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x0/phy.c   | 16 ++---
 .../net/wireless/mediatek/mt76/mt76x02_dfs.c  | 12 ++--
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  | 18 ++---
 .../net/wireless/mediatek/mt76/mt76x02_phy.h  |  4 +-
 .../net/wireless/mediatek/mt76/mt76x02_txrx.c |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  4 +-
 .../wireless/mediatek/mt76/mt76x2/eeprom.c    |  4 +-
 .../wireless/mediatek/mt76/mt76x2/eeprom.h    |  2 +-
 .../wireless/mediatek/mt76/mt76x2/mt76x2.h    |  2 +-
 .../wireless/mediatek/mt76/mt76x2/pci_init.c  |  4 +-
 .../wireless/mediatek/mt76/mt76x2/pci_main.c  |  2 +-
 .../wireless/mediatek/mt76/mt76x2/pci_phy.c   |  4 +-
 .../net/wireless/mediatek/mt76/mt76x2/phy.c   | 20 +++---
 .../wireless/mediatek/mt76/mt76x2/usb_init.c  |  4 +-
 .../wireless/mediatek/mt76/mt76x2/usb_main.c  |  2 +-
 .../wireless/mediatek/mt76/mt76x2/usb_phy.c   |  4 +-
 30 files changed, 153 insertions(+), 137 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 8cd378666c6e..ca408bddd491 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -156,9 +156,9 @@ static void mt76_init_stream_cap(struct mt76_dev *dev,
 void mt76_set_stream_caps(struct mt76_dev *dev, bool vht)
 {
 	if (dev->cap.has_2ghz)
-		mt76_init_stream_cap(dev, &dev->sband_2g.sband, false);
+		mt76_init_stream_cap(dev, &dev->phy.sband_2g.sband, false);
 	if (dev->cap.has_5ghz)
-		mt76_init_stream_cap(dev, &dev->sband_5g.sband, vht);
+		mt76_init_stream_cap(dev, &dev->phy.sband_5g.sband, vht);
 }
 EXPORT_SYMBOL_GPL(mt76_set_stream_caps);
 
@@ -187,8 +187,8 @@ mt76_init_sband(struct mt76_dev *dev, struct mt76_sband *msband,
 	sband->n_channels = n_chan;
 	sband->bitrates = rates;
 	sband->n_bitrates = n_rates;
-	dev->chandef.chan = &sband->channels[0];
-	dev->chan_state = &msband->chan[0];
+	dev->phy.chandef.chan = &sband->channels[0];
+	dev->phy.chan_state = &msband->chan[0];
 
 	ht_cap = &sband->ht_cap;
 	ht_cap->ht_supported = true;
@@ -223,9 +223,9 @@ static int
 mt76_init_sband_2g(struct mt76_dev *dev, struct ieee80211_rate *rates,
 		   int n_rates)
 {
-	dev->hw->wiphy->bands[NL80211_BAND_2GHZ] = &dev->sband_2g.sband;
+	dev->hw->wiphy->bands[NL80211_BAND_2GHZ] = &dev->phy.sband_2g.sband;
 
-	return mt76_init_sband(dev, &dev->sband_2g,
+	return mt76_init_sband(dev, &dev->phy.sband_2g,
 			       mt76_channels_2ghz,
 			       ARRAY_SIZE(mt76_channels_2ghz),
 			       rates, n_rates, false);
@@ -235,9 +235,9 @@ static int
 mt76_init_sband_5g(struct mt76_dev *dev, struct ieee80211_rate *rates,
 		   int n_rates, bool vht)
 {
-	dev->hw->wiphy->bands[NL80211_BAND_5GHZ] = &dev->sband_5g.sband;
+	dev->hw->wiphy->bands[NL80211_BAND_5GHZ] = &dev->phy.sband_5g.sband;
 
-	return mt76_init_sband(dev, &dev->sband_5g,
+	return mt76_init_sband(dev, &dev->phy.sband_5g,
 			       mt76_channels_5ghz,
 			       ARRAY_SIZE(mt76_channels_5ghz),
 			       rates, n_rates, vht);
@@ -427,23 +427,32 @@ bool mt76_has_tx_pending(struct mt76_dev *dev)
 EXPORT_SYMBOL_GPL(mt76_has_tx_pending);
 
 static struct mt76_channel_state *
-mt76_channel_state(struct mt76_dev *dev, struct ieee80211_channel *c)
+mt76_channel_state(struct mt76_phy *phy, struct ieee80211_channel *c)
 {
 	struct mt76_sband *msband;
 	int idx;
 
 	if (c->band == NL80211_BAND_2GHZ)
-		msband = &dev->sband_2g;
+		msband = &phy->sband_2g;
 	else
-		msband = &dev->sband_5g;
+		msband = &phy->sband_5g;
 
 	idx = c - &msband->sband.channels[0];
 	return &msband->chan[idx];
 }
 
+static void
+mt76_update_survey_active_time(struct mt76_phy *phy, ktime_t time)
+{
+	struct mt76_channel_state *state = phy->chan_state;
+
+	state->cc_active += ktime_to_us(ktime_sub(time,
+						  phy->survey_time));
+	phy->survey_time = time;
+}
+
 void mt76_update_survey(struct mt76_dev *dev)
 {
-	struct mt76_channel_state *state = dev->chan_state;
 	ktime_t cur_time;
 
 	if (!test_bit(MT76_STATE_RUNNING, &dev->state))
@@ -453,11 +462,13 @@ void mt76_update_survey(struct mt76_dev *dev)
 		dev->drv->update_survey(dev);
 
 	cur_time = ktime_get_boottime();
-	state->cc_active += ktime_to_us(ktime_sub(cur_time,
-						  dev->survey_time));
-	dev->survey_time = cur_time;
+	mt76_update_survey_active_time(&dev->phy, cur_time);
+	if (dev->phy2)
+		mt76_update_survey_active_time(dev->phy2, cur_time);
 
 	if (dev->drv->drv_flags & MT_DRV_SW_RX_AIRTIME) {
+		struct mt76_channel_state *state = dev->phy.chan_state;
+
 		spin_lock_bh(&dev->cc_lock);
 		state->cc_bss_rx += dev->cur_cc_bss_rx;
 		dev->cur_cc_bss_rx = 0;
@@ -466,9 +477,10 @@ void mt76_update_survey(struct mt76_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt76_update_survey);
 
-void mt76_set_channel(struct mt76_dev *dev)
+void mt76_set_channel(struct mt76_phy *phy)
 {
-	struct ieee80211_hw *hw = dev->hw;
+	struct mt76_dev *dev = phy->dev;
+	struct ieee80211_hw *hw = phy->hw;
 	struct cfg80211_chan_def *chandef = &hw->conf.chandef;
 	bool offchannel = hw->conf.flags & IEEE80211_CONF_OFFCHANNEL;
 	int timeout = HZ / 5;
@@ -476,21 +488,22 @@ void mt76_set_channel(struct mt76_dev *dev)
 	wait_event_timeout(dev->tx_wait, !mt76_has_tx_pending(dev), timeout);
 	mt76_update_survey(dev);
 
-	dev->chandef = *chandef;
-	dev->chan_state = mt76_channel_state(dev, chandef->chan);
+	phy->chandef = *chandef;
+	phy->chan_state = mt76_channel_state(phy, chandef->chan);
 
 	if (!offchannel)
-		dev->main_chan = chandef->chan;
+		phy->main_chan = chandef->chan;
 
-	if (chandef->chan != dev->main_chan)
-		memset(dev->chan_state, 0, sizeof(*dev->chan_state));
+	if (chandef->chan != phy->main_chan)
+		memset(phy->chan_state, 0, sizeof(*phy->chan_state));
 }
 EXPORT_SYMBOL_GPL(mt76_set_channel);
 
 int mt76_get_survey(struct ieee80211_hw *hw, int idx,
 		    struct survey_info *survey)
 {
-	struct mt76_dev *dev = hw->priv;
+	struct mt76_phy *phy = hw->priv;
+	struct mt76_dev *dev = phy->dev;
 	struct mt76_sband *sband;
 	struct ieee80211_channel *chan;
 	struct mt76_channel_state *state;
@@ -500,10 +513,10 @@ int mt76_get_survey(struct ieee80211_hw *hw, int idx,
 	if (idx == 0 && dev->drv->update_survey)
 		mt76_update_survey(dev);
 
-	sband = &dev->sband_2g;
+	sband = &phy->sband_2g;
 	if (idx >= sband->sband.n_channels) {
 		idx -= sband->sband.n_channels;
-		sband = &dev->sband_5g;
+		sband = &phy->sband_5g;
 	}
 
 	if (idx >= sband->sband.n_channels) {
@@ -512,13 +525,13 @@ int mt76_get_survey(struct ieee80211_hw *hw, int idx,
 	}
 
 	chan = &sband->sband.channels[idx];
-	state = mt76_channel_state(dev, chan);
+	state = mt76_channel_state(phy, chan);
 
 	memset(survey, 0, sizeof(*survey));
 	survey->channel = chan;
 	survey->filled = SURVEY_INFO_TIME | SURVEY_INFO_TIME_BUSY;
 	survey->filled |= dev->drv->survey_flags;
-	if (chan == dev->main_chan) {
+	if (chan == phy->main_chan) {
 		survey->filled |= SURVEY_INFO_IN_USE;
 
 		if (dev->drv->drv_flags & MT_DRV_SW_RX_AIRTIME)
@@ -1026,11 +1039,11 @@ int mt76_get_rate(struct mt76_dev *dev,
 	int i, offset = 0, len = sband->n_bitrates;
 
 	if (cck) {
-		if (sband == &dev->sband_5g.sband)
+		if (sband == &dev->phy.sband_5g.sband)
 			return 0;
 
 		idx &= ~BIT(2); /* short preamble */
-	} else if (sband == &dev->sband_2g.sband) {
+	} else if (sband == &dev->phy.sband_2g.sband) {
 		offset = 4;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 8be709e1c8c3..547d9a29afa7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -22,6 +22,7 @@
 #define MT_SKB_HEAD_LEN     128
 
 struct mt76_dev;
+struct mt76_phy;
 struct mt76_wcid;
 
 struct mt76_reg_pair {
@@ -456,6 +457,15 @@ struct mt76_rx_status {
 struct mt76_phy {
 	struct ieee80211_hw *hw;
 	struct mt76_dev *dev;
+
+	struct cfg80211_chan_def chandef;
+	struct ieee80211_channel *main_chan;
+
+	struct mt76_channel_state *chan_state;
+	ktime_t survey_time;
+
+	struct mt76_sband sband_2g;
+	struct mt76_sband sband_5g;
 };
 
 struct mt76_dev {
@@ -464,10 +474,7 @@ struct mt76_dev {
 	struct mt76_phy *phy2;
 
 	struct ieee80211_hw *hw;
-	struct cfg80211_chan_def chandef;
-	struct ieee80211_channel *main_chan;
 
-	struct mt76_channel_state *chan_state;
 	spinlock_t lock;
 	spinlock_t cc_lock;
 
@@ -522,8 +529,6 @@ struct mt76_dev {
 	int beacon_int;
 	u8 beacon_mask;
 
-	struct mt76_sband sband_2g;
-	struct mt76_sband sband_5g;
 	struct debugfs_blob_wrapper eeprom;
 	struct debugfs_blob_wrapper otp;
 	struct mt76_hw_cap cap;
@@ -543,8 +548,6 @@ struct mt76_dev {
 
 	u8 csa_complete;
 
-	ktime_t survey_time;
-
 	u32 rxfilter;
 
 	union {
@@ -750,7 +753,7 @@ void mt76_release_buffered_frames(struct ieee80211_hw *hw,
 				  enum ieee80211_frame_release_type reason,
 				  bool more_data);
 bool mt76_has_tx_pending(struct mt76_dev *dev);
-void mt76_set_channel(struct mt76_dev *dev);
+void mt76_set_channel(struct mt76_phy *phy);
 void mt76_update_survey(struct mt76_dev *dev);
 int mt76_get_survey(struct ieee80211_hw *hw, int idx,
 		    struct survey_info *survey);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 0696dbf28c5b..4fb0cf8e4f75 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -573,7 +573,7 @@ int mt7603_register_device(struct mt7603_dev *dev)
 		return ret;
 
 	mt7603_init_debugfs(dev);
-	mt7603_init_txpower(dev, &dev->mt76.sband_2g.sband);
+	mt7603_init_txpower(dev, &dev->mphy.sband_2g.sband);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 31611195251b..8aefadd6278e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -53,7 +53,7 @@ void mt7603_mac_set_timing(struct mt7603_dev *dev)
 	int sifs;
 	u32 val;
 
-	if (dev->mt76.chandef.chan->band == NL80211_BAND_5GHZ)
+	if (dev->mphy.chandef.chan->band == NL80211_BAND_5GHZ)
 		sifs = 16;
 	else
 		sifs = 10;
@@ -456,7 +456,7 @@ void mt7603_mac_sta_poll(struct mt7603_dev *dev)
 		return;
 
 	spin_lock_bh(&dev->mt76.cc_lock);
-	dev->mt76.chan_state->cc_tx += total_airtime;
+	dev->mphy.chan_state->cc_tx += total_airtime;
 	spin_unlock_bh(&dev->mt76.cc_lock);
 }
 
@@ -502,7 +502,7 @@ mt7603_mac_fill_rx(struct mt7603_dev *dev, struct sk_buff *skb)
 	memset(status, 0, sizeof(*status));
 
 	i = FIELD_GET(MT_RXD1_NORMAL_CH_FREQ, rxd1);
-	sband = (i & 1) ? &dev->mt76.sband_5g.sband : &dev->mt76.sband_2g.sband;
+	sband = (i & 1) ? &dev->mphy.sband_5g.sband : &dev->mphy.sband_2g.sband;
 	i >>= 1;
 
 	idx = FIELD_GET(MT_RXD2_NORMAL_WLAN_IDX, rxd2);
@@ -668,7 +668,7 @@ mt7603_mac_tx_rate_val(struct mt7603_dev *dev,
 			*bw = 1;
 	} else {
 		const struct ieee80211_rate *r;
-		int band = dev->mt76.chandef.chan->band;
+		int band = dev->mphy.chandef.chan->band;
 		u16 val;
 
 		nss = 1;
@@ -1156,10 +1156,10 @@ mt7603_fill_txs(struct mt7603_dev *dev, struct mt7603_sta *sta,
 		cck = true;
 		/* fall through */
 	case MT_PHY_TYPE_OFDM:
-		if (dev->mt76.chandef.chan->band == NL80211_BAND_5GHZ)
-			sband = &dev->mt76.sband_5g.sband;
+		if (dev->mphy.chandef.chan->band == NL80211_BAND_5GHZ)
+			sband = &dev->mphy.sband_5g.sband;
 		else
-			sband = &dev->mt76.sband_2g.sband;
+			sband = &dev->mphy.sband_2g.sband;
 		final_rate &= GENMASK(5, 0);
 		final_rate = mt76_get_rate(&dev->mt76, sband, final_rate,
 					   cck);
@@ -1574,7 +1574,7 @@ void mt7603_update_channel(struct mt76_dev *mdev)
 	struct mt7603_dev *dev = container_of(mdev, struct mt7603_dev, mt76);
 	struct mt76_channel_state *state;
 
-	state = mdev->chan_state;
+	state = mdev->phy.chan_state;
 	state->cc_busy += mt76_rr(dev, MT_MIB_STAT_CCA);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index b10bf9da3798..2df06487f7fd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -15,7 +15,7 @@ mt7603_start(struct ieee80211_hw *hw)
 
 	mt7603_mac_reset_counters(dev);
 	mt7603_mac_start(dev);
-	dev->mt76.survey_time = ktime_get_boottime();
+	dev->mphy.survey_time = ktime_get_boottime();
 	set_bit(MT76_STATE_RUNNING, &dev->mt76.state);
 	mt7603_mac_work(&dev->mt76.mac_work.work);
 
@@ -146,13 +146,13 @@ mt7603_set_channel(struct mt7603_dev *dev, struct cfg80211_chan_def *def)
 	set_bit(MT76_RESET, &dev->mt76.state);
 
 	mt7603_beacon_set_timer(dev, -1, 0);
-	mt76_set_channel(&dev->mt76);
+	mt76_set_channel(&dev->mphy);
 	mt7603_mac_stop(dev);
 
 	if (def->width == NL80211_CHAN_WIDTH_40)
 		bw = MT_BW_40;
 
-	dev->mt76.chandef = *def;
+	dev->mphy.chandef = *def;
 	mt76_rmw_field(dev, MT_AGG_BWCR, MT_AGG_BWCR_BW, bw);
 	ret = mt7603_mcu_set_channel(dev);
 	if (ret) {
@@ -190,7 +190,7 @@ mt7603_set_channel(struct mt7603_dev *dev, struct cfg80211_chan_def *def)
 	mt76_rr(dev, MT_MIB_STAT_PSCCA);
 	mt7603_cca_stats_reset(dev);
 
-	dev->mt76.survey_time = ktime_get_boottime();
+	dev->mphy.survey_time = ktime_get_boottime();
 
 	mt7603_init_edcca(dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
index 02b2bd60d04d..96197205fb82 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
@@ -397,7 +397,7 @@ static int mt7603_mcu_set_tx_power(struct mt7603_dev *dev)
 		u8 temp_comp_power[17];
 		u8 reserved;
 	} req = {
-		.center_channel = dev->mt76.chandef.chan->hw_value,
+		.center_channel = dev->mphy.chandef.chan->hw_value,
 #define EEP_VAL(n) ((u8 *)dev->mt76.eeprom.data)[n]
 		.tssi = EEP_VAL(MT_EE_NIC_CONF_1 + 1),
 		.temp_comp = EEP_VAL(MT_EE_NIC_CONF_1),
@@ -430,7 +430,7 @@ static int mt7603_mcu_set_tx_power(struct mt7603_dev *dev)
 
 int mt7603_mcu_set_channel(struct mt7603_dev *dev)
 {
-	struct cfg80211_chan_def *chandef = &dev->mt76.chandef;
+	struct cfg80211_chan_def *chandef = &dev->mphy.chandef;
 	struct ieee80211_hw *hw = mt76_hw(dev);
 	int n_chains = hweight8(dev->mt76.antenna_mask);
 	struct {
@@ -452,7 +452,7 @@ int mt7603_mcu_set_channel(struct mt7603_dev *dev)
 	s8 tx_power;
 	int i, ret;
 
-	if (dev->mt76.chandef.width == NL80211_CHAN_WIDTH_40) {
+	if (dev->mphy.chandef.width == NL80211_CHAN_WIDTH_40) {
 		req.bw = MT_BW_40;
 		if (chandef->center_freq1 > chandef->chan->center_freq)
 			req.center_chan += 2;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 553bd4d988f7..5b12cb4d2765 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -247,7 +247,7 @@ mt7615_regd_notifier(struct wiphy *wiphy,
 {
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct mt7615_dev *dev = hw->priv;
-	struct cfg80211_chan_def *chandef = &dev->mt76.chandef;
+	struct cfg80211_chan_def *chandef = &dev->mphy.chandef;
 
 	if (request->dfs_region == dev->mt76.region)
 		return;
@@ -296,9 +296,9 @@ int mt7615_register_device(struct mt7615_dev *dev)
 
 	ieee80211_hw_set(hw, TX_STATUS_NO_AMPDU_LEN);
 
-	dev->mt76.sband_2g.sband.ht_cap.cap |= IEEE80211_HT_CAP_LDPC_CODING;
-	dev->mt76.sband_5g.sband.ht_cap.cap |= IEEE80211_HT_CAP_LDPC_CODING;
-	dev->mt76.sband_5g.sband.vht_cap.cap |=
+	dev->mphy.sband_2g.sband.ht_cap.cap |= IEEE80211_HT_CAP_LDPC_CODING;
+	dev->mphy.sband_5g.sband.ht_cap.cap |= IEEE80211_HT_CAP_LDPC_CODING;
+	dev->mphy.sband_5g.sband.vht_cap.cap |=
 			IEEE80211_VHT_CAP_SHORT_GI_160 |
 			IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454 |
 			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK |
@@ -310,8 +310,8 @@ int mt7615_register_device(struct mt7615_dev *dev)
 	if (ret)
 		return ret;
 
-	mt7615_init_txpower(dev, &dev->mt76.sband_2g.sband);
-	mt7615_init_txpower(dev, &dev->mt76.sband_5g.sband);
+	mt7615_init_txpower(dev, &dev->mphy.sband_2g.sband);
+	mt7615_init_txpower(dev, &dev->mphy.sband_5g.sband);
 
 	hw->max_tx_fragments = MT_TXP_MAX_BUF_NUM;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index c77adc5d2552..83a219d21d3a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -92,12 +92,12 @@ int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 	}
 
 	/* TODO: properly support DBDC */
-	status->freq = dev->mt76.chandef.chan->center_freq;
-	status->band = dev->mt76.chandef.chan->band;
+	status->freq = dev->mphy.chandef.chan->center_freq;
+	status->band = dev->mphy.chandef.chan->band;
 	if (status->band == NL80211_BAND_5GHZ)
-		sband = &dev->mt76.sband_5g.sband;
+		sband = &dev->mphy.sband_5g.sband;
 	else
-		sband = &dev->mt76.sband_2g.sband;
+		sband = &dev->mphy.sband_2g.sband;
 
 	if (rxd2 & MT_RXD2_NORMAL_FCS_ERR)
 		status->flag |= RX_FLAG_FAILED_FCS_CRC;
@@ -319,7 +319,7 @@ mt7615_mac_tx_rate_val(struct mt7615_dev *dev,
 			*bw = 1;
 	} else {
 		const struct ieee80211_rate *r;
-		int band = dev->mt76.chandef.chan->band;
+		int band = dev->mphy.chandef.chan->band;
 		u16 val;
 
 		nss = 1;
@@ -1059,10 +1059,10 @@ static bool mt7615_fill_txs(struct mt7615_dev *dev, struct mt7615_sta *sta,
 		cck = true;
 		/* fall through */
 	case MT_PHY_TYPE_OFDM:
-		if (dev->mt76.chandef.chan->band == NL80211_BAND_5GHZ)
-			sband = &dev->mt76.sband_5g.sband;
+		if (dev->mphy.chandef.chan->band == NL80211_BAND_5GHZ)
+			sband = &dev->mphy.sband_5g.sband;
 		else
-			sband = &dev->mt76.sband_2g.sband;
+			sband = &dev->mphy.sband_2g.sband;
 		final_rate &= MT_TX_RATE_IDX;
 		final_rate = mt76_get_rate(&dev->mt76, sband, final_rate,
 					   cck);
@@ -1383,7 +1383,7 @@ void mt7615_update_channel(struct mt76_dev *mdev)
 	obss_time = mt76_get_field(dev, MT_WF_RMAC_MIB_TIME5,
 				   MT_MIB_OBSSTIME_MASK);
 
-	state = mdev->chan_state;
+	state = mdev->phy.chan_state;
 	state->cc_busy += busy_time;
 	state->cc_tx += tx_time;
 	state->cc_rx += rx_time + obss_time;
@@ -1423,7 +1423,7 @@ void mt7615_mac_work(struct work_struct *work)
 
 int mt7615_dfs_stop_radar_detector(struct mt7615_dev *dev)
 {
-	struct cfg80211_chan_def *chandef = &dev->mt76.chandef;
+	struct cfg80211_chan_def *chandef = &dev->mphy.chandef;
 	int err;
 
 	err = mt7615_mcu_rdd_cmd(dev, RDD_STOP, MT_HW_RDD0,
@@ -1452,7 +1452,7 @@ static int mt7615_dfs_start_rdd(struct mt7615_dev *dev, int chain)
 
 int mt7615_dfs_start_radar_detector(struct mt7615_dev *dev)
 {
-	struct cfg80211_chan_def *chandef = &dev->mt76.chandef;
+	struct cfg80211_chan_def *chandef = &dev->mphy.chandef;
 	int err;
 
 	/* start CAC */
@@ -1479,7 +1479,7 @@ int mt7615_dfs_start_radar_detector(struct mt7615_dev *dev)
 
 int mt7615_dfs_init_radar_detector(struct mt7615_dev *dev)
 {
-	struct cfg80211_chan_def *chandef = &dev->mt76.chandef;
+	struct cfg80211_chan_def *chandef = &dev->mphy.chandef;
 	int err;
 
 	if (dev->mt76.region == NL80211_DFS_UNSET)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index c55609c06fc4..0f9fd859b597 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -18,7 +18,7 @@ static int mt7615_start(struct ieee80211_hw *hw)
 
 	mt7615_mac_reset_counters(dev);
 
-	dev->mt76.survey_time = ktime_get_boottime();
+	dev->mphy.survey_time = ktime_get_boottime();
 	set_bit(MT76_STATE_RUNNING, &dev->mt76.state);
 	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mt76.mac_work,
 				     MT7615_WATCHDOG_TIME);
@@ -155,7 +155,7 @@ static int mt7615_set_channel(struct mt7615_dev *dev)
 
 	mt7615_dfs_check_channel(dev);
 
-	mt76_set_channel(&dev->mt76);
+	mt76_set_channel(&dev->mphy);
 
 	ret = mt7615_mcu_set_channel(dev);
 	if (ret)
@@ -163,7 +163,7 @@ static int mt7615_set_channel(struct mt7615_dev *dev)
 
 	ret = mt7615_dfs_init_radar_detector(dev);
 	mt7615_mac_cca_stats_reset(dev);
-	dev->mt76.survey_time = ktime_get_boottime();
+	dev->mphy.survey_time = ktime_get_boottime();
 
 	mt7615_mac_reset_counters(dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index f229c9ce9f65..e6773d3bacfd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1159,7 +1159,7 @@ int mt7615_mcu_set_bcn(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 int mt7615_mcu_set_tx_power(struct mt7615_dev *dev)
 {
 	int i, ret, n_chains = hweight8(dev->mt76.antenna_mask);
-	struct cfg80211_chan_def *chandef = &dev->mt76.chandef;
+	struct cfg80211_chan_def *chandef = &dev->mphy.chandef;
 	int freq = chandef->center_freq1, len, target_chains;
 	u8 *req, *data, *eep = (u8 *)dev->mt76.eeprom.data;
 	enum nl80211_band band = chandef->chan->band;
@@ -1276,7 +1276,7 @@ int mt7615_mcu_rdd_send_pattern(struct mt7615_dev *dev)
 
 int mt7615_mcu_set_channel(struct mt7615_dev *dev)
 {
-	struct cfg80211_chan_def *chandef = &dev->mt76.chandef;
+	struct cfg80211_chan_def *chandef = &dev->mphy.chandef;
 	int freq1 = chandef->center_freq1, freq2 = chandef->center_freq2;
 	struct {
 		u8 control_chan;
@@ -1313,7 +1313,7 @@ int mt7615_mcu_set_channel(struct mt7615_dev *dev)
 	else
 		req.switch_reason = CH_SWITCH_NORMAL;
 
-	switch (dev->mt76.chandef.width) {
+	switch (dev->mphy.chandef.width) {
 	case NL80211_CHAN_WIDTH_40:
 		req.bw = CMD_CBW_40MHZ;
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 85d865e832ad..828df9b4a53e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -221,8 +221,8 @@ static inline bool is_mt7622(struct mt76_dev *dev)
 
 static inline void mt7615_dfs_check_channel(struct mt7615_dev *dev)
 {
-	enum nl80211_chan_width width = dev->mt76.chandef.width;
-	u32 freq = dev->mt76.chandef.chan->center_freq;
+	enum nl80211_chan_width width = dev->mphy.chandef.width;
+	u32 freq = dev->mphy.chandef.chan->center_freq;
 	struct ieee80211_hw *hw = mt76_hw(dev);
 
 	if (hw->conf.chandef.chan->center_freq != freq ||
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
index a03e2d01fba7..04a90223a9b9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
@@ -109,7 +109,7 @@ static void mt76x0_set_freq_offset(struct mt76x02_dev *dev)
 
 void mt76x0_read_rx_gain(struct mt76x02_dev *dev)
 {
-	struct ieee80211_channel *chan = dev->mt76.chandef.chan;
+	struct ieee80211_channel *chan = dev->mphy.chandef.chan;
 	struct mt76x02_rx_freq_cal *caldata = &dev->cal.rx;
 	s8 val, lna_5g[3], lna_2g;
 	u16 rssi_offset;
@@ -129,7 +129,7 @@ void mt76x0_read_rx_gain(struct mt76x02_dev *dev)
 
 static s8 mt76x0_get_delta(struct mt76x02_dev *dev)
 {
-	struct cfg80211_chan_def *chandef = &dev->mt76.chandef;
+	struct cfg80211_chan_def *chandef = &dev->mphy.chandef;
 	u8 val;
 
 	if (chandef->width == NL80211_CHAN_WIDTH_80) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/init.c b/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
index 388b54cded1b..57f8d56737eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
@@ -264,12 +264,12 @@ int mt76x0_register_device(struct mt76x02_dev *dev)
 
 	if (dev->mt76.cap.has_5ghz) {
 		/* overwrite unsupported features */
-		mt76x0_vht_cap_mask(&dev->mt76.sband_5g.sband);
-		mt76x0_init_txpower(dev, &dev->mt76.sband_5g.sband);
+		mt76x0_vht_cap_mask(&dev->mphy.sband_5g.sband);
+		mt76x0_init_txpower(dev, &dev->mphy.sband_5g.sband);
 	}
 
 	if (dev->mt76.cap.has_2ghz)
-		mt76x0_init_txpower(dev, &dev->mt76.sband_2g.sband);
+		mt76x0_init_txpower(dev, &dev->mphy.sband_2g.sband);
 
 	mt76x02_init_debugfs(dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
index bae99aa4d863..c2383bb48cfd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
@@ -16,7 +16,7 @@ mt76x0_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
 	if (mt76_is_mmio(&dev->mt76))
 		tasklet_disable(&dev->dfs_pd.dfs_tasklet);
 
-	mt76_set_channel(&dev->mt76);
+	mt76_set_channel(&dev->mphy);
 	mt76x0_phy_set_channel(dev, chandef);
 
 	mt76x02_mac_cc_reset(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
index 2ecd45f8af90..2502faa296fd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
@@ -502,7 +502,7 @@ mt76x0_phy_bbp_set_bw(struct mt76x02_dev *dev, enum nl80211_chan_width width)
 
 static void mt76x0_phy_tssi_dc_calibrate(struct mt76x02_dev *dev)
 {
-	struct ieee80211_channel *chan = dev->mt76.chandef.chan;
+	struct ieee80211_channel *chan = dev->mphy.chandef.chan;
 	u32 val;
 
 	if (chan->band == NL80211_BAND_5GHZ)
@@ -543,7 +543,7 @@ static int
 mt76x0_phy_tssi_adc_calibrate(struct mt76x02_dev *dev, s16 *ltssi,
 			      u8 *info)
 {
-	struct ieee80211_channel *chan = dev->mt76.chandef.chan;
+	struct ieee80211_channel *chan = dev->mphy.chandef.chan;
 	u32 val;
 
 	val = (chan->band == NL80211_BAND_5GHZ) ? 0x80055 : 0x80050;
@@ -696,7 +696,7 @@ mt76x0_phy_get_delta_power(struct mt76x02_dev *dev, u8 tx_mode,
 			   s8 target_power, s8 target_pa_power,
 			   s16 ltssi)
 {
-	struct ieee80211_channel *chan = dev->mt76.chandef.chan;
+	struct ieee80211_channel *chan = dev->mphy.chandef.chan;
 	int tssi_target = target_power << 12, tssi_slope;
 	int tssi_offset, tssi_db, ret;
 	u32 data;
@@ -844,8 +844,8 @@ void mt76x0_phy_set_txpower(struct mt76x02_dev *dev)
 	struct mt76_rate_power *t = &dev->mt76.rate_power;
 	s8 info;
 
-	mt76x0_get_tx_power_per_rate(dev, dev->mt76.chandef.chan, t);
-	mt76x0_get_power_info(dev, dev->mt76.chandef.chan, &info);
+	mt76x0_get_tx_power_per_rate(dev, dev->mphy.chandef.chan, t);
+	mt76x0_get_power_info(dev, dev->mphy.chandef.chan, &info);
 
 	mt76x02_add_rate_power_offset(t, info);
 	mt76x02_limit_rate_power(t, dev->mt76.txpower_conf);
@@ -858,7 +858,7 @@ void mt76x0_phy_set_txpower(struct mt76x02_dev *dev)
 
 void mt76x0_phy_calibrate(struct mt76x02_dev *dev, bool power_on)
 {
-	struct ieee80211_channel *chan = dev->mt76.chandef.chan;
+	struct ieee80211_channel *chan = dev->mphy.chandef.chan;
 	int is_5ghz = (chan->band == NL80211_BAND_5GHZ) ? 1 : 0;
 	u32 val, tx_alc, reg_val;
 
@@ -1037,7 +1037,7 @@ static void mt76x0_phy_temp_sensor(struct mt76x02_dev *dev)
 
 	if (abs(val - dev->cal.temp_vco) > 20) {
 		mt76x02_mcu_calibrate(dev, MCU_CAL_VCO,
-				      dev->mt76.chandef.chan->hw_value);
+				      dev->mphy.chandef.chan->hw_value);
 		dev->cal.temp_vco = val;
 	}
 	if (abs(val - dev->cal.temp) > 30) {
@@ -1057,7 +1057,7 @@ static void mt76x0_phy_set_gain_val(struct mt76x02_dev *dev)
 
 	mt76_rmw_field(dev, MT_BBP(AGC, 8), MT_BBP_AGC_GAIN, gain);
 
-	if ((dev->mt76.chandef.chan->flags & IEEE80211_CHAN_RADAR) &&
+	if ((dev->mphy.chandef.chan->flags & IEEE80211_CHAN_RADAR) &&
 	    !is_mt7630(dev))
 		mt76x02_phy_dfs_adjust_agc(dev);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c b/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c
index 5dec33ed8527..f6cb2b6490a9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c
@@ -307,8 +307,8 @@ static bool mt76x02_dfs_check_hw_pulse(struct mt76x02_dev *dev,
 		       pulse->period <= 100100);
 		break;
 	case NL80211_DFS_JP:
-		if (dev->mt76.chandef.chan->center_freq >= 5250 &&
-		    dev->mt76.chandef.chan->center_freq <= 5350) {
+		if (dev->mphy.chandef.chan->center_freq >= 5250 &&
+		    dev->mphy.chandef.chan->center_freq <= 5350) {
 			/* JPW53 */
 			if (pulse->w1 <= 130)
 				ret = (pulse->period >= 28360 &&
@@ -702,7 +702,7 @@ static void mt76x02_dfs_set_bbp_params(struct mt76x02_dev *dev)
 	u8 i, shift;
 	u32 data;
 
-	switch (dev->mt76.chandef.width) {
+	switch (dev->mphy.chandef.width) {
 	case NL80211_CHAN_WIDTH_40:
 		shift = MT_DFS_NUM_ENGINES;
 		break;
@@ -722,8 +722,8 @@ static void mt76x02_dfs_set_bbp_params(struct mt76x02_dev *dev)
 		radar_specs = &etsi_radar_specs[shift];
 		break;
 	case NL80211_DFS_JP:
-		if (dev->mt76.chandef.chan->center_freq >= 5250 &&
-		    dev->mt76.chandef.chan->center_freq <= 5350)
+		if (dev->mphy.chandef.chan->center_freq >= 5250 &&
+		    dev->mphy.chandef.chan->center_freq <= 5350)
 			radar_specs = &jp_w53_radar_specs[shift];
 		else
 			radar_specs = &jp_w56_radar_specs[shift];
@@ -822,7 +822,7 @@ EXPORT_SYMBOL_GPL(mt76x02_phy_dfs_adjust_agc);
 
 void mt76x02_dfs_init_params(struct mt76x02_dev *dev)
 {
-	struct cfg80211_chan_def *chandef = &dev->mt76.chandef;
+	struct cfg80211_chan_def *chandef = &dev->mphy.chandef;
 
 	if ((chandef->chan->flags & IEEE80211_CHAN_RADAR) &&
 	    dev->mt76.region != NL80211_DFS_UNSET) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 4460548f346a..965c93b6009b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -200,7 +200,7 @@ mt76x02_mac_tx_rate_val(struct mt76x02_dev *dev,
 			bw = 1;
 	} else {
 		const struct ieee80211_rate *r;
-		int band = dev->mt76.chandef.chan->band;
+		int band = dev->mphy.chandef.chan->band;
 		u16 val;
 
 		r = &dev->mt76.hw->wiphy->bands[band]->bitrates[rate->idx];
@@ -487,17 +487,17 @@ mt76x02_mac_fill_tx_status(struct mt76x02_dev *dev, struct mt76x02_sta *msta,
 		first_rate |= st->pktid & MT_PKTID_RATE;
 
 		mt76x02_mac_process_tx_rate(&rate[0], first_rate,
-					    dev->mt76.chandef.chan->band);
+					    dev->mphy.chandef.chan->band);
 	} else if (rate[0].idx < 0) {
 		if (!msta)
 			return;
 
 		mt76x02_mac_process_tx_rate(&rate[0], msta->wcid.tx_info,
-					    dev->mt76.chandef.chan->band);
+					    dev->mphy.chandef.chan->band);
 	}
 
 	mt76x02_mac_process_tx_rate(&last_rate, st->rate,
-				    dev->mt76.chandef.chan->band);
+				    dev->mphy.chandef.chan->band);
 
 	for (i = 0; i < ARRAY_SIZE(info->status.rates); i++) {
 		retry--;
@@ -853,8 +853,8 @@ int mt76x02_mac_process_rx(struct mt76x02_dev *dev, struct sk_buff *skb,
 		signal = max_t(s8, signal, status->chain_signal[1]);
 	}
 	status->signal = signal;
-	status->freq = dev->mt76.chandef.chan->center_freq;
-	status->band = dev->mt76.chandef.chan->band;
+	status->freq = dev->mphy.chandef.chan->center_freq;
+	status->band = dev->mphy.chandef.chan->band;
 
 	status->tid = FIELD_GET(MT_RXWI_TID, tid_sn);
 	status->seqno = FIELD_GET(MT_RXWI_SN, tid_sn);
@@ -1018,7 +1018,7 @@ void mt76x02_update_channel(struct mt76_dev *mdev)
 	struct mt76x02_dev *dev = container_of(mdev, struct mt76x02_dev, mt76);
 	struct mt76_channel_state *state;
 
-	state = mdev->chan_state;
+	state = mdev->phy.chan_state;
 	state->cc_busy += mt76_rr(dev, MT_CH_BUSY);
 
 	spin_lock_bh(&dev->mt76.cc_lock);
@@ -1074,7 +1074,7 @@ void mt76x02_edcca_init(struct mt76x02_dev *dev)
 	dev->ed_silent = 0;
 
 	if (dev->ed_monitor) {
-		struct ieee80211_channel *chan = dev->mt76.chandef.chan;
+		struct ieee80211_channel *chan = dev->mphy.chandef.chan;
 		u8 ed_th = chan->band == NL80211_BAND_5GHZ ? 0x0e : 0x20;
 
 		mt76_clear(dev, MT_TX_LINK_CFG, MT_TX_CFACK_EN);
@@ -1184,7 +1184,7 @@ void mt76x02_mac_work(struct work_struct *work)
 
 void mt76x02_mac_cc_reset(struct mt76x02_dev *dev)
 {
-	dev->mt76.survey_time = ktime_get_boottime();
+	dev->mphy.survey_time = ktime_get_boottime();
 
 	mt76_wr(dev, MT_CH_TIME_CFG,
 		MT_CH_TIME_CFG_TIMER_EN |
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_phy.h b/drivers/net/wireless/mediatek/mt76/mt76x02_phy.h
index fc2e41006a0d..1def25bf735a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_phy.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_phy.h
@@ -11,7 +11,7 @@
 static inline int
 mt76x02_get_rssi_gain_thresh(struct mt76x02_dev *dev)
 {
-	switch (dev->mt76.chandef.width) {
+	switch (dev->mphy.chandef.width) {
 	case NL80211_CHAN_WIDTH_80:
 		return -62;
 	case NL80211_CHAN_WIDTH_40:
@@ -24,7 +24,7 @@ mt76x02_get_rssi_gain_thresh(struct mt76x02_dev *dev)
 static inline int
 mt76x02_get_low_rssi_gain_thresh(struct mt76x02_dev *dev)
 {
-	switch (dev->mt76.chandef.width) {
+	switch (dev->mphy.chandef.width) {
 	case NL80211_CHAN_WIDTH_80:
 		return -76;
 	case NL80211_CHAN_WIDTH_40:
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c b/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
index 05dd531a9e1a..10466545405a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
@@ -74,7 +74,7 @@ s8 mt76x02_tx_get_max_txpwr_adj(struct mt76x02_dev *dev,
 	} else if (rate->flags & IEEE80211_TX_RC_MCS) {
 		max_txpwr = dev->mt76.rate_power.ht[rate->idx & 0xf];
 	} else {
-		enum nl80211_band band = dev->mt76.chandef.chan->band;
+		enum nl80211_band band = dev->mphy.chandef.chan->band;
 
 		if (band == NL80211_BAND_2GHZ) {
 			const struct ieee80211_rate *r;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 0960fc56b672..837ba7f01f31 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -188,9 +188,9 @@ void mt76x02_init_device(struct mt76x02_dev *dev)
 	dev->slottime = 9;
 
 	if (is_mt76x2(dev)) {
-		dev->mt76.sband_2g.sband.ht_cap.cap |=
+		dev->mphy.sband_2g.sband.ht_cap.cap |=
 				IEEE80211_HT_CAP_LDPC_CODING;
-		dev->mt76.sband_5g.sband.ht_cap.cap |=
+		dev->mphy.sband_5g.sband.ht_cap.cap |=
 				IEEE80211_HT_CAP_LDPC_CODING;
 		dev->mt76.chainmask = 0x202;
 		dev->mt76.antenna_mask = 3;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
index 9f91556c7f38..4a748a6f0ce2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
@@ -248,7 +248,7 @@ mt76x2_get_5g_rx_gain(struct mt76x02_dev *dev, u8 channel)
 
 void mt76x2_read_rx_gain(struct mt76x02_dev *dev)
 {
-	struct ieee80211_channel *chan = dev->mt76.chandef.chan;
+	struct ieee80211_channel *chan = dev->mphy.chandef.chan;
 	int channel = chan->hw_value;
 	s8 lna_5g[3], lna_2g;
 	u8 lna;
@@ -455,7 +455,7 @@ EXPORT_SYMBOL_GPL(mt76x2_get_power_info);
 
 int mt76x2_get_temp_comp(struct mt76x02_dev *dev, struct mt76x2_temp_comp *t)
 {
-	enum nl80211_band band = dev->mt76.chandef.chan->band;
+	enum nl80211_band band = dev->mphy.chandef.chan->band;
 	u16 val, slope;
 	u8 bounds;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.h
index 4dcf6518cb0d..3755632e6494 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.h
@@ -53,7 +53,7 @@ mt76x2_has_ext_lna(struct mt76x02_dev *dev)
 {
 	u32 val = mt76x02_eeprom_get(dev, MT_EE_NIC_CONF_1);
 
-	if (dev->mt76.chandef.chan->band == NL80211_BAND_2GHZ)
+	if (dev->mphy.chandef.chan->band == NL80211_BAND_2GHZ)
 		return val & MT_EE_NIC_CONF_1_LNA_EXT_2G;
 	else
 		return val & MT_EE_NIC_CONF_1_LNA_EXT_5G;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h b/drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h
index 41680c420cda..eca95b7f64d2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h
@@ -30,7 +30,7 @@ static inline bool is_mt7612(struct mt76x02_dev *dev)
 
 static inline bool mt76x2_channel_silent(struct mt76x02_dev *dev)
 {
-	struct ieee80211_channel *chan = dev->mt76.chandef.chan;
+	struct ieee80211_channel *chan = dev->mphy.chandef.chan;
 
 	return ((chan->flags & IEEE80211_CHAN_RADAR) &&
 		chan->dfs_state != NL80211_DFS_AVAILABLE);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
index 33fcec9179b2..bae05a088b5e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
@@ -289,8 +289,8 @@ int mt76x2_register_device(struct mt76x02_dev *dev)
 		goto fail;
 
 	mt76x02_init_debugfs(dev);
-	mt76x2_init_txpower(dev, &dev->mt76.sband_2g.sband);
-	mt76x2_init_txpower(dev, &dev->mt76.sband_5g.sband);
+	mt76x2_init_txpower(dev, &dev->mphy.sband_2g.sband);
+	mt76x2_init_txpower(dev, &dev->mphy.sband_5g.sband);
 
 	return 0;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
index 7845e56cb23b..8c639cbc99ed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
@@ -47,7 +47,7 @@ mt76x2_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
 	mutex_lock(&dev->mt76.mutex);
 	set_bit(MT76_RESET, &dev->mt76.state);
 
-	mt76_set_channel(&dev->mt76);
+	mt76_set_channel(&dev->mphy);
 
 	mt76x2_mac_stop(dev, true);
 	ret = mt76x2_phy_set_channel(dev, chandef);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c
index 23f35bf8d47b..83d00bf74218 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c
@@ -12,7 +12,7 @@
 static bool
 mt76x2_phy_tssi_init_cal(struct mt76x02_dev *dev)
 {
-	struct ieee80211_channel *chan = dev->mt76.chandef.chan;
+	struct ieee80211_channel *chan = dev->mphy.chandef.chan;
 	u32 flag = 0;
 
 	if (!mt76x2_tssi_enabled(dev))
@@ -35,7 +35,7 @@ mt76x2_phy_tssi_init_cal(struct mt76x02_dev *dev)
 static void
 mt76x2_phy_channel_calibrate(struct mt76x02_dev *dev, bool mac_stopped)
 {
-	struct ieee80211_channel *chan = dev->mt76.chandef.chan;
+	struct ieee80211_channel *chan = dev->mphy.chandef.chan;
 	bool is_5ghz = chan->band == NL80211_BAND_5GHZ;
 
 	if (dev->cal.channel_cal_done)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c b/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c
index edbab4fa7f6e..6d457c0dd699 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c
@@ -136,8 +136,8 @@ mt76x2_get_min_rate_power(struct mt76_rate_power *r)
 
 void mt76x2_phy_set_txpower(struct mt76x02_dev *dev)
 {
-	enum nl80211_chan_width width = dev->mt76.chandef.width;
-	struct ieee80211_channel *chan = dev->mt76.chandef.chan;
+	enum nl80211_chan_width width = dev->mphy.chandef.width;
+	struct ieee80211_channel *chan = dev->mphy.chandef.chan;
 	struct mt76x2_tx_power_info txp;
 	int txp_0, txp_1, delta = 0;
 	struct mt76_rate_power t = {};
@@ -202,7 +202,7 @@ EXPORT_SYMBOL_GPL(mt76x2_configure_tx_delay);
 
 void mt76x2_phy_tssi_compensate(struct mt76x02_dev *dev)
 {
-	struct ieee80211_channel *chan = dev->mt76.chandef.chan;
+	struct ieee80211_channel *chan = dev->mphy.chandef.chan;
 	struct mt76x2_tx_power_info txp;
 	struct mt76x2_tssi_comp t = {};
 
@@ -252,12 +252,12 @@ mt76x2_phy_set_gain_val(struct mt76x02_dev *dev)
 
 	val = 0x1836 << 16;
 	if (!mt76x2_has_ext_lna(dev) &&
-	    dev->mt76.chandef.width >= NL80211_CHAN_WIDTH_40)
+	    dev->mphy.chandef.width >= NL80211_CHAN_WIDTH_40)
 		val = 0x1e42 << 16;
 
 	if (mt76x2_has_ext_lna(dev) &&
-	    dev->mt76.chandef.chan->band == NL80211_BAND_2GHZ &&
-	    dev->mt76.chandef.width < NL80211_CHAN_WIDTH_40)
+	    dev->mphy.chandef.chan->band == NL80211_BAND_2GHZ &&
+	    dev->mphy.chandef.width < NL80211_CHAN_WIDTH_40)
 		val = 0x0f36 << 16;
 
 	val |= 0xf8;
@@ -267,7 +267,7 @@ mt76x2_phy_set_gain_val(struct mt76x02_dev *dev)
 	mt76_wr(dev, MT_BBP(AGC, 9),
 		val | FIELD_PREP(MT_BBP_AGC_GAIN, gain_val[1]));
 
-	if (dev->mt76.chandef.chan->flags & IEEE80211_CHAN_RADAR)
+	if (dev->mphy.chandef.chan->flags & IEEE80211_CHAN_RADAR)
 		mt76x02_phy_dfs_adjust_agc(dev);
 }
 
@@ -297,7 +297,7 @@ void mt76x2_phy_update_channel_gain(struct mt76x02_dev *dev)
 		return;
 	}
 
-	if (dev->mt76.chandef.width == NL80211_CHAN_WIDTH_80) {
+	if (dev->mphy.chandef.width == NL80211_CHAN_WIDTH_80) {
 		mt76_wr(dev, MT_BBP(RXO, 14), 0x00560211);
 		val = mt76_rr(dev, MT_BBP(AGC, 26)) & ~0xf;
 		if (low_gain == 2)
@@ -315,11 +315,11 @@ void mt76x2_phy_update_channel_gain(struct mt76x02_dev *dev)
 		low_gain_delta = 14;
 
 	agc_37 = 0x2121262c;
-	if (dev->mt76.chandef.chan->band == NL80211_BAND_2GHZ)
+	if (dev->mphy.chandef.chan->band == NL80211_BAND_2GHZ)
 		agc_35 = 0x11111516;
 	else if (low_gain == 2)
 		agc_35 = agc_37 = 0x08080808;
-	else if (dev->mt76.chandef.width == NL80211_CHAN_WIDTH_80)
+	else if (dev->mphy.chandef.width == NL80211_CHAN_WIDTH_80)
 		agc_35 = 0x10101014;
 	else
 		agc_35 = 0x11111116;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
index 2910068f4e79..89b04da23db9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
@@ -221,8 +221,8 @@ int mt76x2u_register_device(struct mt76x02_dev *dev)
 	set_bit(MT76_STATE_INITIALIZED, &dev->mt76.state);
 
 	mt76x02_init_debugfs(dev);
-	mt76x2_init_txpower(dev, &dev->mt76.sband_2g.sband);
-	mt76x2_init_txpower(dev, &dev->mt76.sband_5g.sband);
+	mt76x2_init_txpower(dev, &dev->mphy.sband_2g.sband);
+	mt76x2_init_txpower(dev, &dev->mphy.sband_5g.sband);
 
 	return 0;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
index 8a04a7bf25c0..24f2caf7bb66 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
@@ -43,7 +43,7 @@ mt76x2u_set_channel(struct mt76x02_dev *dev,
 	mutex_lock(&dev->mt76.mutex);
 	set_bit(MT76_RESET, &dev->mt76.state);
 
-	mt76_set_channel(&dev->mt76);
+	mt76_set_channel(&dev->mphy);
 
 	mt76x2_mac_stop(dev, false);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c
index b1381f9df992..d4d9b40ba8d9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c
@@ -10,7 +10,7 @@
 static void
 mt76x2u_phy_channel_calibrate(struct mt76x02_dev *dev, bool mac_stopped)
 {
-	struct ieee80211_channel *chan = dev->mt76.chandef.chan;
+	struct ieee80211_channel *chan = dev->mphy.chandef.chan;
 	bool is_5ghz = chan->band == NL80211_BAND_5GHZ;
 
 	if (dev->cal.channel_cal_done)
@@ -185,7 +185,7 @@ int mt76x2u_phy_set_channel(struct mt76x02_dev *dev,
 			struct ieee80211_channel *chan;
 			u32 flag = 0;
 
-			chan = dev->mt76.chandef.chan;
+			chan = dev->mphy.chandef.chan;
 			if (chan->band == NL80211_BAND_5GHZ)
 				flag |= BIT(0);
 			if (mt76x02_ext_pa_enabled(dev, chan->band))
-- 
2.24.0

