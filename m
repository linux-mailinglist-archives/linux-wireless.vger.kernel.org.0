Return-Path: <linux-wireless+bounces-12116-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB5B961FD7
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 08:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1CEE285E3B
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 06:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D4013210D;
	Wed, 28 Aug 2024 06:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="EZ+LSL8j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B3812CD8B
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 06:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724826871; cv=none; b=po+93+Irqn0p8XbH25CO2JNp/nJjhgyLUKpDW1nK9ljAtmW10rbQLB8e0nKkltNEdH1QkwKb++UNdstoQrjuQslz+3CWLmK0J7+TgF9fjVtzg6+z5pHc8ou5Iu5XGxoXicuJX2RWTkjtGfljiOh1uvQAIWG3xqdOfMfDPC7bpVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724826871; c=relaxed/simple;
	bh=72xtYgovk7R7FQYyY+MsfU3A+PfXl97cS+UoO+j3kTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNCDBR8WFJyxEMHT9mH93OeUMc/obx2WB0ht9mmsGQ3wioMYCSUrc1YARGbkNLJWNcp9FDHUX4VTv8TvlrwRdH/N3wFvN/MvGiKsPihccwdcpLqmQZ60+lCSohxMNJ2MmjXtmyhHps9IMsbuMMG5CJsV2qVv4SEG8T/uLeC1pL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=EZ+LSL8j; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BYN76nu8Lp31xJzGZFOnHbMElVIo74s8RR4lKreMA2c=; b=EZ+LSL8j1znOBQrRBQeP/KMzIF
	fzwL9WQPezLH3jFNmwT0wjMmPmjPfGqiV02AGzUajb8REtEFFrrRgXIUjaSBftqU2n1gpisdGmjda
	3BPnd+PtqbHc6Gf5vwgjlK3eSsbisA8TCAmT7CyQ/16ezJ927Ph7r3Evf7Tl1Z+xTZtc=;
Received: from p200300da77101f6b09599fc404fed4ac.dip0.t-ipconnect.de ([2003:da:7710:1f6b:959:9fc4:4fe:d4ac] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sjCG7-004uCr-1n;
	Wed, 28 Aug 2024 08:34:23 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH v3 05/24] wifi: mt76: partially move channel change code to core
Date: Wed, 28 Aug 2024 08:34:22 +0200
Message-ID: <20240828063422.44813-1-nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827093011.18621-5-nbd@nbd.name>
References: <20240827093011.18621-5-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows the core code to change the channel. Code deduplication and
preparation for adding scanning code to the core.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v3:
- fix mt76x0 locking issue

 drivers/net/wireless/mediatek/mt76/mac80211.c | 37 ++++++++++++++++---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  6 ++-
 .../wireless/mediatek/mt76/mt7603/beacon.c    |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/init.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7603/main.c  | 27 ++++----------
 .../wireless/mediatek/mt76/mt7603/mt7603.h    |  1 +
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 27 ++++----------
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/mmio.c  |  1 +
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  |  1 +
 .../wireless/mediatek/mt76/mt7615/testmode.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/usb.c   |  1 +
 .../net/wireless/mediatek/mt76/mt76x0/main.c  | 21 +++++------
 .../wireless/mediatek/mt76/mt76x0/mt76x0.h    |  1 +
 .../net/wireless/mediatek/mt76/mt76x0/pci.c   |  1 +
 .../net/wireless/mediatek/mt76/mt76x0/usb.c   |  1 +
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c |  2 +-
 .../wireless/mediatek/mt76/mt76x02_usb_core.c |  5 +--
 .../wireless/mediatek/mt76/mt76x2/mt76x2.h    |  2 +
 .../net/wireless/mediatek/mt76/mt76x2/pci.c   |  1 +
 .../wireless/mediatek/mt76/mt76x2/pci_main.c  | 25 ++++---------
 .../net/wireless/mediatek/mt76/mt76x2/usb.c   |  1 +
 .../wireless/mediatek/mt76/mt76x2/usb_main.c  | 25 +++----------
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 19 ++--------
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |  1 +
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 +-
 .../wireless/mediatek/mt76/mt7915/testmode.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 23 ++++--------
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  2 +-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 +
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  1 +
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7921/usb.c   |  1 +
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 23 ++----------
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7996/mmio.c  |  1 +
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  2 +-
 39 files changed, 116 insertions(+), 162 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 8733906fcb21..a24186c9a913 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -929,13 +929,19 @@ void mt76_update_survey(struct mt76_phy *phy)
 }
 EXPORT_SYMBOL_GPL(mt76_update_survey);
 
-void mt76_set_channel(struct mt76_phy *phy)
+int mt76_set_channel(struct mt76_phy *phy, struct cfg80211_chan_def *chandef,
+		     bool offchannel)
 {
 	struct mt76_dev *dev = phy->dev;
-	struct ieee80211_hw *hw = phy->hw;
-	struct cfg80211_chan_def *chandef = &hw->conf.chandef;
-	bool offchannel = hw->conf.flags & IEEE80211_CONF_OFFCHANNEL;
 	int timeout = HZ / 5;
+	int ret;
+
+	cancel_delayed_work_sync(&phy->mac_work);
+
+	mutex_lock(&dev->mutex);
+	set_bit(MT76_RESET, &phy->state);
+
+	ieee80211_stop_queues(phy->hw);
 
 	wait_event_timeout(dev->tx_wait, !mt76_has_tx_pending(phy), timeout);
 	mt76_update_survey(phy);
@@ -946,14 +952,35 @@ void mt76_set_channel(struct mt76_phy *phy)
 
 	phy->chandef = *chandef;
 	phy->chan_state = mt76_channel_state(phy, chandef->chan);
+	phy->offchannel = offchannel;
 
 	if (!offchannel)
 		phy->main_chan = chandef->chan;
 
 	if (chandef->chan != phy->main_chan)
 		memset(phy->chan_state, 0, sizeof(*phy->chan_state));
+
+	ret = dev->drv->set_channel(phy);
+
+	clear_bit(MT76_RESET, &phy->state);
+	ieee80211_wake_queues(phy->hw);
+
+	mt76_worker_schedule(&dev->tx_worker);
+
+	mutex_unlock(&dev->mutex);
+
+	return ret;
 }
-EXPORT_SYMBOL_GPL(mt76_set_channel);
+
+int mt76_update_channel(struct mt76_phy *phy)
+{
+	struct ieee80211_hw *hw = phy->hw;
+	struct cfg80211_chan_def *chandef = &hw->conf.chandef;
+	bool offchannel = hw->conf.flags & IEEE80211_CONF_OFFCHANNEL;
+
+	return mt76_set_channel(phy, chandef, offchannel);
+}
+EXPORT_SYMBOL_GPL(mt76_update_channel);
 
 int mt76_get_survey(struct ieee80211_hw *hw, int idx,
 		    struct survey_info *survey)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 4a58a78d5ed2..6c054f43e7ce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -487,6 +487,7 @@ struct mt76_driver_ops {
 	u8 mcs_rates;
 
 	void (*update_survey)(struct mt76_phy *phy);
+	int (*set_channel)(struct mt76_phy *phy);
 
 	int (*tx_prepare_skb)(struct mt76_dev *dev, void *txwi_ptr,
 			      enum mt76_txq_id qid, struct mt76_wcid *wcid,
@@ -768,6 +769,7 @@ struct mt76_phy {
 
 	struct cfg80211_chan_def chandef;
 	struct ieee80211_channel *main_chan;
+	bool offchannel;
 
 	struct mt76_channel_state *chan_state;
 	enum mt76_dfs_state dfs_state;
@@ -1370,7 +1372,7 @@ void mt76_release_buffered_frames(struct ieee80211_hw *hw,
 				  enum ieee80211_frame_release_type reason,
 				  bool more_data);
 bool mt76_has_tx_pending(struct mt76_phy *phy);
-void mt76_set_channel(struct mt76_phy *phy);
+int mt76_update_channel(struct mt76_phy *phy);
 void mt76_update_survey(struct mt76_phy *phy);
 void mt76_update_survey_active_time(struct mt76_phy *phy, ktime_t time);
 int mt76_get_survey(struct ieee80211_hw *hw, int idx,
@@ -1484,6 +1486,8 @@ void mt76_rx_aggr_reorder(struct sk_buff *skb, struct sk_buff_head *frames);
 void mt76_testmode_tx_pending(struct mt76_phy *phy);
 void mt76_queue_tx_complete(struct mt76_dev *dev, struct mt76_queue *q,
 			    struct mt76_queue_entry *e);
+int mt76_set_channel(struct mt76_phy *phy, struct cfg80211_chan_def *chandef,
+		     bool offchannel);
 
 /* usb */
 static inline bool mt76u_urb_error(struct urb *urb)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
index c223f7c19e6d..6457ee06bb5a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
@@ -107,7 +107,7 @@ void mt7603_pre_tbtt_tasklet(struct tasklet_struct *t)
 	struct sk_buff *skb;
 	int i, nframes;
 
-	if (mt76_hw(dev)->conf.flags & IEEE80211_CONF_OFFCHANNEL)
+	if (dev->mphy.offchannel)
 		return;
 
 	data.dev = dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index f84c9a06af75..1528a8be7762 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -18,6 +18,7 @@ const struct mt76_driver_ops mt7603_drv_ops = {
 	.sta_assoc = mt7603_sta_assoc,
 	.sta_remove = mt7603_sta_remove,
 	.update_survey = mt7603_update_channel,
+	.set_channel = mt7603_set_channel,
 };
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index f35fa643c0da..3d3a4cc2bab1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -133,30 +133,24 @@ void mt7603_init_edcca(struct mt7603_dev *dev)
 	mt7603_edcca_set_strict(dev, false);
 }
 
-static int
-mt7603_set_channel(struct ieee80211_hw *hw, struct cfg80211_chan_def *def)
+int mt7603_set_channel(struct mt76_phy *mphy)
 {
-	struct mt7603_dev *dev = hw->priv;
+	struct mt7603_dev *dev = container_of(mphy->dev, struct mt7603_dev, mt76);
+	struct cfg80211_chan_def *def = &mphy->chandef;
+
 	u8 *rssi_data = (u8 *)dev->mt76.eeprom.data;
 	int idx, ret;
 	u8 bw = MT_BW_20;
 	bool failed = false;
 
-	ieee80211_stop_queues(hw);
-	cancel_delayed_work_sync(&dev->mphy.mac_work);
 	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 
-	mutex_lock(&dev->mt76.mutex);
-	set_bit(MT76_RESET, &dev->mphy.state);
-
 	mt7603_beacon_set_timer(dev, -1, 0);
-	mt76_set_channel(&dev->mphy);
 	mt7603_mac_stop(dev);
 
 	if (def->width == NL80211_CHAN_WIDTH_40)
 		bw = MT_BW_40;
 
-	dev->mphy.chandef = *def;
 	mt76_rmw_field(dev, MT_AGG_BWCR, MT_AGG_BWCR_BW, bw);
 	ret = mt7603_mcu_set_channel(dev);
 	if (ret) {
@@ -180,10 +174,6 @@ mt7603_set_channel(struct ieee80211_hw *hw, struct cfg80211_chan_def *def)
 	mt7603_mac_set_timing(dev);
 	mt7603_mac_start(dev);
 
-	clear_bit(MT76_RESET, &dev->mphy.state);
-
-	mt76_txq_schedule_all(&dev->mphy);
-
 	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mphy.mac_work,
 				     msecs_to_jiffies(MT7603_WATCHDOG_TIME));
 
@@ -199,17 +189,14 @@ mt7603_set_channel(struct ieee80211_hw *hw, struct cfg80211_chan_def *def)
 	mt7603_init_edcca(dev);
 
 out:
-	if (!(mt76_hw(dev)->conf.flags & IEEE80211_CONF_OFFCHANNEL))
+	if (!mphy->offchannel)
 		mt7603_beacon_set_timer(dev, -1, dev->mt76.beacon_int);
-	mutex_unlock(&dev->mt76.mutex);
 
 	tasklet_enable(&dev->mt76.pre_tbtt_tasklet);
 
 	if (failed)
 		mt7603_mac_work(&dev->mphy.mac_work.work);
 
-	ieee80211_wake_queues(hw);
-
 	return ret;
 }
 
@@ -227,7 +214,7 @@ static int mt7603_set_sar_specs(struct ieee80211_hw *hw,
 	if (err)
 		return err;
 
-	return mt7603_set_channel(hw, &mphy->chandef);
+	return mt76_update_channel(mphy);
 }
 
 static int
@@ -238,7 +225,7 @@ mt7603_config(struct ieee80211_hw *hw, u32 changed)
 
 	if (changed & (IEEE80211_CONF_CHANGE_CHANNEL |
 		       IEEE80211_CONF_CHANGE_POWER))
-		ret = mt7603_set_channel(hw, &hw->conf.chandef);
+		ret = mt76_update_channel(&dev->mphy);
 
 	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
 		mutex_lock(&dev->mt76.mutex);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index 9e58df7042ad..dbdfe596f29e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -213,6 +213,7 @@ void mt7603_mac_sta_poll(struct mt7603_dev *dev);
 
 void mt7603_pse_client_reset(struct mt7603_dev *dev);
 
+int mt7603_set_channel(struct mt76_phy *mphy);
 int mt7603_mcu_set_channel(struct mt7603_dev *dev);
 int mt7603_mcu_set_eeprom(struct mt7603_dev *dev);
 void mt7603_mcu_exit(struct mt7603_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 50e262c1622f..376975388007 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -282,19 +282,14 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 	mt76_wcid_cleanup(&dev->mt76, &mvif->sta.wcid);
 }
 
-int mt7615_set_channel(struct mt7615_phy *phy)
+int mt7615_set_channel(struct mt76_phy *mphy)
 {
+	struct mt7615_phy *phy = mphy->priv;
 	struct mt7615_dev *dev = phy->dev;
 	bool ext_phy = phy != &dev->phy;
 	int ret;
 
-	cancel_delayed_work_sync(&phy->mt76->mac_work);
-
-	mt7615_mutex_acquire(dev);
-
-	set_bit(MT76_RESET, &phy->mt76->state);
-
-	mt76_set_channel(phy->mt76);
+	mt76_connac_pm_wake(mphy, &dev->pm);
 
 	if (is_mt7615(&dev->mt76) && dev->flash_eeprom) {
 		ret = mt7615_mcu_apply_rx_dcoc(phy);
@@ -325,11 +320,8 @@ int mt7615_set_channel(struct mt7615_phy *phy)
 	phy->chfreq = mt76_rr(dev, MT_CHFREQ(ext_phy));
 
 out:
-	clear_bit(MT76_RESET, &phy->mt76->state);
+	mt76_connac_power_save_sched(mphy, &dev->pm);
 
-	mt7615_mutex_release(dev);
-
-	mt76_worker_schedule(&dev->mt76.tx_worker);
 	if (!mt76_testmode_enabled(phy->mt76)) {
 		unsigned long timeout = mt7615_get_macwork_timeout(dev);
 
@@ -339,6 +331,7 @@ int mt7615_set_channel(struct mt7615_phy *phy)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(mt7615_set_channel);
 
 static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			  struct ieee80211_vif *vif, struct ieee80211_sta *sta,
@@ -425,11 +418,7 @@ static int mt7615_set_sar_specs(struct ieee80211_hw *hw,
 	if (mt7615_firmware_offload(phy->dev))
 		return mt76_connac_mcu_set_rate_txpower(phy->mt76);
 
-	ieee80211_stop_queues(hw);
-	err = mt7615_set_channel(phy);
-	ieee80211_wake_queues(hw);
-
-	return err;
+	return mt76_update_channel(phy->mt76);
 }
 
 static int mt7615_config(struct ieee80211_hw *hw, u32 changed)
@@ -448,9 +437,7 @@ static int mt7615_config(struct ieee80211_hw *hw, u32 changed)
 			mt7615_mutex_release(dev);
 		}
 #endif
-		ieee80211_stop_queues(hw);
-		ret = mt7615_set_channel(phy);
-		ieee80211_wake_queues(hw);
+		ret = mt76_update_channel(phy->mt76);
 	}
 
 	mt7615_mutex_acquire(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index d50d967828be..3b57d967190a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2151,7 +2151,7 @@ int mt7615_mcu_set_chan_info(struct mt7615_phy *phy, int cmd)
 	if (cmd == MCU_EXT_CMD(SET_RX_PATH) ||
 	    phy->mt76->hw->conf.flags & IEEE80211_CONF_MONITOR)
 		req.switch_reason = CH_SWITCH_NORMAL;
-	else if (phy->mt76->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
+	else if (phy->mt76->offchannel)
 		req.switch_reason = CH_SWITCH_SCAN_BYPASS_DPD;
 	else if (!cfg80211_reg_can_beacon(phy->mt76->hw->wiphy, chandef,
 					  NL80211_IFTYPE_AP))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
index 87a956ea3ad7..dbb2c82407df 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
@@ -182,6 +182,7 @@ int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base,
 		.sta_add = mt7615_mac_sta_add,
 		.sta_remove = mt7615_mac_sta_remove,
 		.update_survey = mt7615_update_channel,
+		.set_channel = mt7615_set_channel,
 	};
 	struct mt76_bus_ops *bus_ops;
 	struct ieee80211_ops *ops;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index a20322aae967..68f4a7727a26 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -457,7 +457,7 @@ void mt7615_roc_work(struct work_struct *work);
 void mt7615_roc_timer(struct timer_list *timer);
 void mt7615_init_txpower(struct mt7615_dev *dev,
 			 struct ieee80211_supported_band *sband);
-int mt7615_set_channel(struct mt7615_phy *phy);
+int mt7615_set_channel(struct mt76_phy *mphy);
 void mt7615_init_work(struct mt7615_dev *dev);
 
 int mt7615_mcu_restart(struct mt76_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
index 9692890ba51b..aebfc4576aa4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -87,6 +87,7 @@ static int mt7663s_probe(struct sdio_func *func,
 		.sta_add = mt7615_mac_sta_add,
 		.sta_remove = mt7615_mac_sta_remove,
 		.update_survey = mt7615_update_channel,
+		.set_channel = mt7615_set_channel,
 	};
 	static const struct mt76_bus_ops mt7663s_ops = {
 		.rr = mt76s_rr,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
index a3d1cfa729ed..03f5af84424b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
@@ -141,7 +141,7 @@ mt7615_tm_init(struct mt7615_phy *phy)
 	mt7615_mcu_set_sku_en(phy, phy->mt76->test.state == MT76_TM_STATE_OFF);
 
 	mutex_unlock(&dev->mt76.mutex);
-	mt7615_set_channel(phy);
+	mt76_update_channel(phy->mt76);
 	mt7615_ops.configure_filter(phy->mt76->hw, 0, &total_flags, 0);
 	mutex_lock(&dev->mt76.mutex);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index 9335ca0776fe..5020af52c68c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -123,6 +123,7 @@ static int mt7663u_probe(struct usb_interface *usb_intf,
 		.sta_add = mt7615_mac_sta_add,
 		.sta_remove = mt7615_mac_sta_remove,
 		.update_survey = mt7615_update_channel,
+		.set_channel = mt7615_set_channel,
 	};
 	static struct mt76_bus_ops bus_ops = {
 		.rr = mt7663u_rr,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
index 07380cce8755..4aa2dcedc874 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
@@ -8,16 +8,15 @@
 #include <linux/etherdevice.h>
 #include "mt76x0.h"
 
-static void
-mt76x0_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
+int mt76x0_set_channel(struct mt76_phy *mphy)
 {
-	cancel_delayed_work_sync(&dev->cal_work);
+	struct mt76x02_dev *dev = container_of(mphy->dev, struct mt76x02_dev, mt76);
+
 	mt76x02_pre_tbtt_enable(dev, false);
 	if (mt76_is_mmio(&dev->mt76))
 		tasklet_disable(&dev->dfs_pd.dfs_tasklet);
 
-	mt76_set_channel(&dev->mphy);
-	mt76x0_phy_set_channel(dev, chandef);
+	mt76x0_phy_set_channel(dev, &mphy->chandef);
 
 	mt76x02_mac_cc_reset(dev);
 	mt76x02_edcca_init(dev);
@@ -28,8 +27,9 @@ mt76x0_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
 	}
 	mt76x02_pre_tbtt_enable(dev, true);
 
-	mt76_txq_schedule_all(&dev->mphy);
+	return 0;
 }
+EXPORT_SYMBOL_GPL(mt76x0_set_channel);
 
 int mt76x0_set_sar_specs(struct ieee80211_hw *hw,
 			 const struct cfg80211_sar_specs *sar)
@@ -61,13 +61,10 @@ int mt76x0_config(struct ieee80211_hw *hw, u32 changed)
 {
 	struct mt76x02_dev *dev = hw->priv;
 
-	mutex_lock(&dev->mt76.mutex);
+	if (changed & IEEE80211_CONF_CHANGE_CHANNEL)
+		mt76_update_channel(&dev->mphy);
 
-	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
-		ieee80211_stop_queues(hw);
-		mt76x0_set_channel(dev, &hw->conf.chandef);
-		ieee80211_wake_queues(hw);
-	}
+	mutex_lock(&dev->mt76.mutex);
 
 	if (changed & IEEE80211_CONF_CHANGE_POWER) {
 		struct mt76_phy *mphy = &dev->mphy;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h b/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h
index 99dcb8feb9f7..50f755344968 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h
@@ -49,6 +49,7 @@ void mt76x0_chip_onoff(struct mt76x02_dev *dev, bool enable, bool reset);
 void mt76x0_mac_stop(struct mt76x02_dev *dev);
 
 int mt76x0_config(struct ieee80211_hw *hw, u32 changed);
+int mt76x0_set_channel(struct mt76_phy *mphy);
 int mt76x0_set_sar_specs(struct ieee80211_hw *hw,
 			 const struct cfg80211_sar_specs *sar);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
index 2ecee7c5c80d..1eb955f3ca13 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
@@ -159,6 +159,7 @@ mt76x0e_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			     MT_DRV_SW_RX_AIRTIME,
 		.survey_flags = SURVEY_INFO_TIME_TX,
 		.update_survey = mt76x02_update_channel,
+		.set_channel = mt76x0_set_channel,
 		.tx_prepare_skb = mt76x02_tx_prepare_skb,
 		.tx_complete_skb = mt76x02_tx_complete_skb,
 		.rx_skb = mt76x02_queue_rx_skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index 390f502e97f0..b031c500b741 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -217,6 +217,7 @@ static int mt76x0u_probe(struct usb_interface *usb_intf,
 		.drv_flags = MT_DRV_SW_RX_AIRTIME,
 		.survey_flags = SURVEY_INFO_TIME_TX,
 		.update_survey = mt76x02_update_channel,
+		.set_channel = mt76x0_set_channel,
 		.tx_prepare_skb = mt76x02u_tx_prepare_skb,
 		.tx_complete_skb = mt76x02u_tx_complete_skb,
 		.tx_status_data = mt76x02_tx_status_data,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 35b7ebc2c9c6..4a49a3036a46 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -22,7 +22,7 @@ static void mt76x02_pre_tbtt_tasklet(struct tasklet_struct *t)
 	struct sk_buff *skb;
 	int i;
 
-	if (mt76_hw(dev)->conf.flags & IEEE80211_CONF_OFFCHANNEL)
+	if (dev->mphy.offchannel)
 		return;
 
 	__skb_queue_head_init(&data.q);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index 29b9a15f8dbe..0e1ede9314d8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -188,10 +188,7 @@ static void mt76x02u_pre_tbtt_work(struct work_struct *work)
 	struct sk_buff *skb;
 	int nbeacons;
 
-	if (!dev->mt76.beacon_mask)
-		return;
-
-	if (mt76_hw(dev)->conf.flags & IEEE80211_CONF_OFFCHANNEL)
+	if (!dev->mt76.beacon_mask || dev->mphy.offchannel)
 		return;
 
 	__skb_queue_head_init(&data.q);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h b/drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h
index be1217329a77..f051721bb00e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h
@@ -47,6 +47,8 @@ void mt76x2_phy_power_on(struct mt76x02_dev *dev);
 void mt76x2_stop_hardware(struct mt76x02_dev *dev);
 int mt76x2_eeprom_init(struct mt76x02_dev *dev);
 int mt76x2_apply_calibration_data(struct mt76x02_dev *dev, int channel);
+int mt76x2e_set_channel(struct mt76_phy *phy);
+int mt76x2u_set_channel(struct mt76_phy *phy);
 
 void mt76x2_phy_set_antenna(struct mt76x02_dev *dev);
 int mt76x2_phy_start(struct mt76x02_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
index 30959746e924..67c9d1caa0bd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
@@ -25,6 +25,7 @@ mt76x2e_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			     MT_DRV_SW_RX_AIRTIME,
 		.survey_flags = SURVEY_INFO_TIME_TX,
 		.update_survey = mt76x02_update_channel,
+		.set_channel = mt76x2e_set_channel,
 		.tx_prepare_skb = mt76x02_tx_prepare_skb,
 		.tx_complete_skb = mt76x02_tx_complete_skb,
 		.rx_skb = mt76x02_queue_rx_skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
index 6accea551319..eb70130d2711 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
@@ -32,33 +32,25 @@ mt76x2_stop(struct ieee80211_hw *hw, bool suspend)
 	mt76x2_stop_hardware(dev);
 }
 
-static void
-mt76x2_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
+int mt76x2e_set_channel(struct mt76_phy *phy)
 {
-	cancel_delayed_work_sync(&dev->cal_work);
+	struct mt76x02_dev *dev = container_of(phy->dev, struct mt76x02_dev, mt76);
+
 	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 	tasklet_disable(&dev->dfs_pd.dfs_tasklet);
 
-	mutex_lock(&dev->mt76.mutex);
-	set_bit(MT76_RESET, &dev->mphy.state);
-
-	mt76_set_channel(&dev->mphy);
-
 	mt76x2_mac_stop(dev, true);
-	mt76x2_phy_set_channel(dev, chandef);
+	mt76x2_phy_set_channel(dev, &phy->chandef);
 
 	mt76x02_mac_cc_reset(dev);
 	mt76x02_dfs_init_params(dev);
 
 	mt76x2_mac_resume(dev);
 
-	clear_bit(MT76_RESET, &dev->mphy.state);
-	mutex_unlock(&dev->mt76.mutex);
-
 	tasklet_enable(&dev->dfs_pd.dfs_tasklet);
 	tasklet_enable(&dev->mt76.pre_tbtt_tasklet);
 
-	mt76_txq_schedule_all(&dev->mphy);
+	return 0;
 }
 
 static int
@@ -95,11 +87,8 @@ mt76x2_config(struct ieee80211_hw *hw, u32 changed)
 
 	mutex_unlock(&dev->mt76.mutex);
 
-	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
-		ieee80211_stop_queues(hw);
-		mt76x2_set_channel(dev, &hw->conf.chandef);
-		ieee80211_wake_queues(hw);
-	}
+	if (changed & IEEE80211_CONF_CHANGE_CHANNEL)
+		mt76_update_channel(&dev->mphy);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index e92bb871f231..e832ad53e239 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -32,6 +32,7 @@ static int mt76x2u_probe(struct usb_interface *intf,
 		.drv_flags = MT_DRV_SW_RX_AIRTIME,
 		.survey_flags = SURVEY_INFO_TIME_TX,
 		.update_survey = mt76x02_update_channel,
+		.set_channel = mt76x2u_set_channel,
 		.tx_prepare_skb = mt76x02u_tx_prepare_skb,
 		.tx_complete_skb = mt76x02u_tx_complete_skb,
 		.tx_status_data = mt76x02_tx_status_data,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
index ba0241c36672..83e7061b10e2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
@@ -31,32 +31,20 @@ static void mt76x2u_stop(struct ieee80211_hw *hw, bool suspend)
 	mt76x2u_stop_hw(dev);
 }
 
-static int
-mt76x2u_set_channel(struct mt76x02_dev *dev,
-		    struct cfg80211_chan_def *chandef)
+int mt76x2u_set_channel(struct mt76_phy *mphy)
 {
+	struct mt76x02_dev *dev = container_of(mphy->dev, struct mt76x02_dev, mt76);
 	int err;
 
-	cancel_delayed_work_sync(&dev->cal_work);
 	mt76x02_pre_tbtt_enable(dev, false);
-
-	mutex_lock(&dev->mt76.mutex);
-	set_bit(MT76_RESET, &dev->mphy.state);
-
-	mt76_set_channel(&dev->mphy);
-
 	mt76x2_mac_stop(dev, false);
 
-	err = mt76x2u_phy_set_channel(dev, chandef);
+	err = mt76x2u_phy_set_channel(dev, &mphy->chandef);
 
 	mt76x02_mac_cc_reset(dev);
 	mt76x2_mac_resume(dev);
 
-	clear_bit(MT76_RESET, &dev->mphy.state);
-	mutex_unlock(&dev->mt76.mutex);
-
 	mt76x02_pre_tbtt_enable(dev, true);
-	mt76_txq_schedule_all(&dev->mphy);
 
 	return err;
 }
@@ -93,11 +81,8 @@ mt76x2u_config(struct ieee80211_hw *hw, u32 changed)
 
 	mutex_unlock(&dev->mt76.mutex);
 
-	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
-		ieee80211_stop_queues(hw);
-		err = mt76x2u_set_channel(dev, &hw->conf.chandef);
-		ieee80211_wake_queues(hw);
-	}
+	if (changed & IEEE80211_CONF_CHANGE_CHANNEL)
+		mt76_update_channel(&dev->mphy);
 
 	return err;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 049223df9beb..87a7b1589af2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -317,18 +317,12 @@ static void mt7915_remove_interface(struct ieee80211_hw *hw,
 	mt76_wcid_cleanup(&dev->mt76, &msta->wcid);
 }
 
-int mt7915_set_channel(struct mt7915_phy *phy)
+int mt7915_set_channel(struct mt76_phy *mphy)
 {
+	struct mt7915_phy *phy = mphy->priv;
 	struct mt7915_dev *dev = phy->dev;
 	int ret;
 
-	cancel_delayed_work_sync(&phy->mt76->mac_work);
-
-	mutex_lock(&dev->mt76.mutex);
-	set_bit(MT76_RESET, &phy->mt76->state);
-
-	mt76_set_channel(phy->mt76);
-
 	if (dev->cal) {
 		ret = mt7915_mcu_apply_tx_dpd(phy);
 		if (ret)
@@ -347,11 +341,6 @@ int mt7915_set_channel(struct mt7915_phy *phy)
 	phy->noise = 0;
 
 out:
-	clear_bit(MT76_RESET, &phy->mt76->state);
-	mutex_unlock(&dev->mt76.mutex);
-
-	mt76_txq_schedule_all(phy->mt76);
-
 	if (!mt76_testmode_enabled(phy->mt76))
 		ieee80211_queue_delayed_work(phy->mt76->hw,
 					     &phy->mt76->mac_work,
@@ -464,11 +453,9 @@ static int mt7915_config(struct ieee80211_hw *hw, u32 changed)
 			mutex_unlock(&dev->mt76.mutex);
 		}
 #endif
-		ieee80211_stop_queues(hw);
-		ret = mt7915_set_channel(phy);
+		ret = mt76_update_channel(phy->mt76);
 		if (ret)
 			return ret;
-		ieee80211_wake_queues(hw);
 	}
 
 	if (changed & (IEEE80211_CONF_CHANGE_POWER |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 2185cd24e2e1..b2cad75eafb9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2747,7 +2747,7 @@ int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)
 
 	if (phy->mt76->hw->conf.flags & IEEE80211_CONF_MONITOR)
 		req.switch_reason = CH_SWITCH_NORMAL;
-	else if (phy->mt76->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL ||
+	else if (phy->mt76->offchannel ||
 		 phy->mt76->hw->conf.flags & IEEE80211_CONF_IDLE)
 		req.switch_reason = CH_SWITCH_SCAN_BYPASS_DPD;
 	else if (!cfg80211_reg_can_beacon(phy->mt76->hw->wiphy, chandef,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index d6ecd698cdcd..ec7cf57521d9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -929,6 +929,7 @@ struct mt7915_dev *mt7915_mmio_probe(struct device *pdev,
 		.sta_add = mt7915_mac_sta_add,
 		.sta_remove = mt7915_mac_sta_remove,
 		.update_survey = mt7915_update_channel,
+		.set_channel = mt7915_set_channel,
 	};
 	struct mt7915_dev *dev;
 	struct mt76_dev *mdev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index a30d08eb0656..712471c2a8e9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -463,7 +463,7 @@ int mt7915_mcu_add_rate_ctrl(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 			     struct ieee80211_sta *sta, bool changed);
 int mt7915_mcu_add_smps(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta);
-int mt7915_set_channel(struct mt7915_phy *phy);
+int mt7915_set_channel(struct mt76_phy *mphy);
 int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd);
 int mt7915_mcu_set_tx(struct mt7915_dev *dev, struct ieee80211_vif *vif);
 int mt7915_mcu_update_edca(struct mt7915_dev *dev, void *req);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index 0d76ae31b376..1ed8e77eb549 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -425,7 +425,7 @@ static void
 mt7915_tm_update_channel(struct mt7915_phy *phy)
 {
 	mutex_unlock(&phy->dev->mt76.mutex);
-	mt7915_set_channel(phy);
+	mt76_update_channel(phy->mt76);
 	mutex_lock(&phy->dev->mt76.mutex);
 
 	mt7915_mcu_set_chan_info(phy, MCU_EXT_CMD(SET_RX_PATH));
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 2e6268cb06c0..8084d385053f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -454,37 +454,30 @@ static int mt7921_cancel_remain_on_channel(struct ieee80211_hw *hw,
 	return mt7921_abort_roc(phy, mvif);
 }
 
-static int mt7921_set_channel(struct mt792x_phy *phy)
+int mt7921_set_channel(struct mt76_phy *mphy)
 {
+	struct mt792x_phy *phy = mphy->priv;
 	struct mt792x_dev *dev = phy->dev;
 	int ret;
 
-	cancel_delayed_work_sync(&phy->mt76->mac_work);
-
-	mt792x_mutex_acquire(dev);
-	set_bit(MT76_RESET, &phy->mt76->state);
-
-	mt76_set_channel(phy->mt76);
-
+	mt76_connac_pm_wake(mphy, &dev->pm);
 	ret = mt7921_mcu_set_chan_info(phy, MCU_EXT_CMD(CHANNEL_SWITCH));
 	if (ret)
 		goto out;
 
 	mt792x_mac_set_timeing(phy);
-
 	mt792x_mac_reset_counters(phy);
 	phy->noise = 0;
 
 out:
-	clear_bit(MT76_RESET, &phy->mt76->state);
-	mt792x_mutex_release(dev);
+	mt76_connac_power_save_sched(mphy, &dev->pm);
 
-	mt76_worker_schedule(&dev->mt76.tx_worker);
-	ieee80211_queue_delayed_work(phy->mt76->hw, &phy->mt76->mac_work,
+	ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
 				     MT792x_WATCHDOG_TIME);
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(mt7921_set_channel);
 
 static int mt7921_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			  struct ieee80211_vif *vif, struct ieee80211_sta *sta,
@@ -619,11 +612,9 @@ static int mt7921_config(struct ieee80211_hw *hw, u32 changed)
 	int ret = 0;
 
 	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
-		ieee80211_stop_queues(hw);
-		ret = mt7921_set_channel(phy);
+		ret = mt76_update_channel(phy->mt76);
 		if (ret)
 			return ret;
-		ieee80211_wake_queues(hw);
 	}
 
 	mt792x_mutex_acquire(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 394fcd799345..02c1de8620a7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -890,7 +890,7 @@ int mt7921_mcu_set_chan_info(struct mt792x_phy *phy, int cmd)
 	if (cmd == MCU_EXT_CMD(SET_RX_PATH) ||
 	    dev->mt76.hw->conf.flags & IEEE80211_CONF_MONITOR)
 		req.switch_reason = CH_SWITCH_NORMAL;
-	else if (dev->mt76.hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
+	else if (phy->mt76->offchannel)
 		req.switch_reason = CH_SWITCH_SCAN_BYPASS_DPD;
 	else if (!cfg80211_reg_can_beacon(dev->mt76.hw->wiphy, chandef,
 					  NL80211_IFTYPE_AP))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 6c5392c5d207..0b4f4c8d8858 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -186,6 +186,7 @@ int __mt7921_start(struct mt792x_phy *phy);
 int mt7921_register_device(struct mt792x_dev *dev);
 void mt7921_unregister_device(struct mt792x_dev *dev);
 int mt7921_run_firmware(struct mt792x_dev *dev);
+int mt7921_set_channel(struct mt76_phy *mphy);
 int mt7921_mcu_set_bss_pm(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 			  bool enable);
 int mt7921_mcu_sta_update(struct mt792x_dev *dev, struct ieee80211_sta *sta,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index a7430216a80d..bb8cfff78dc5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -247,6 +247,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 		.sta_assoc = mt7921_mac_sta_assoc,
 		.sta_remove = mt7921_mac_sta_remove,
 		.update_survey = mt792x_update_channel,
+		.set_channel = mt7921_set_channel,
 	};
 	static const struct mt792x_hif_ops mt7921_pcie_ops = {
 		.init_reset = mt7921e_init_reset,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index 004d942ee11a..2ef502d0ce9a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -103,6 +103,7 @@ static int mt7921s_probe(struct sdio_func *func,
 		.sta_assoc = mt7921_mac_sta_assoc,
 		.sta_remove = mt7921_mac_sta_remove,
 		.update_survey = mt792x_update_channel,
+		.set_channel = mt7921_set_channel,
 	};
 	static const struct mt76_bus_ops mt7921s_ops = {
 		.rr = mt76s_rr,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index 8b7c03c47598..3b5e52db4a13 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -154,6 +154,7 @@ static int mt7921u_probe(struct usb_interface *usb_intf,
 		.sta_assoc = mt7921_mac_sta_assoc,
 		.sta_remove = mt7921_mac_sta_remove,
 		.update_survey = mt792x_update_channel,
+		.set_channel = mt7921_set_channel,
 	};
 	static const struct mt792x_hif_ops hif_ops = {
 		.mcu_init = mt7921u_mcu_init,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index d43bd5c2432e..39f071ece35e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -291,18 +291,11 @@ static void mt7996_remove_interface(struct ieee80211_hw *hw,
 	mt76_wcid_cleanup(&dev->mt76, &msta->wcid);
 }
 
-int mt7996_set_channel(struct mt7996_phy *phy)
+int mt7996_set_channel(struct mt76_phy *mphy)
 {
-	struct mt7996_dev *dev = phy->dev;
+	struct mt7996_phy *phy = mphy->priv;
 	int ret;
 
-	cancel_delayed_work_sync(&phy->mt76->mac_work);
-
-	mutex_lock(&dev->mt76.mutex);
-	set_bit(MT76_RESET, &phy->mt76->state);
-
-	mt76_set_channel(phy->mt76);
-
 	ret = mt7996_mcu_set_chan_info(phy, UNI_CHANNEL_SWITCH);
 	if (ret)
 		goto out;
@@ -318,13 +311,7 @@ int mt7996_set_channel(struct mt7996_phy *phy)
 	phy->noise = 0;
 
 out:
-	clear_bit(MT76_RESET, &phy->mt76->state);
-	mutex_unlock(&dev->mt76.mutex);
-
-	mt76_txq_schedule_all(phy->mt76);
-
-	ieee80211_queue_delayed_work(phy->mt76->hw,
-				     &phy->mt76->mac_work,
+	ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
 				     MT7996_WATCHDOG_TIME);
 
 	return ret;
@@ -415,11 +402,9 @@ static int mt7996_config(struct ieee80211_hw *hw, u32 changed)
 	int ret;
 
 	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
-		ieee80211_stop_queues(hw);
-		ret = mt7996_set_channel(phy);
+		ret = mt76_update_channel(phy->mt76);
 		if (ret)
 			return ret;
-		ieee80211_wake_queues(hw);
 	}
 
 	if (changed & (IEEE80211_CONF_CHANGE_POWER |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 8855095fef10..a1a0df43e1cd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -3463,7 +3463,7 @@ int mt7996_mcu_set_chan_info(struct mt7996_phy *phy, u16 tag)
 
 	if (phy->mt76->hw->conf.flags & IEEE80211_CONF_MONITOR)
 		req.switch_reason = CH_SWITCH_NORMAL;
-	else if (phy->mt76->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL ||
+	else if (phy->mt76->offchannel ||
 		 phy->mt76->hw->conf.flags & IEEE80211_CONF_IDLE)
 		req.switch_reason = CH_SWITCH_SCAN_BYPASS_DPD;
 	else if (!cfg80211_reg_can_beacon(phy->mt76->hw->wiphy, chandef,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index 928a9663b49e..40e45fb2b626 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -620,6 +620,7 @@ struct mt7996_dev *mt7996_mmio_probe(struct device *pdev,
 		.sta_add = mt7996_mac_sta_add,
 		.sta_remove = mt7996_mac_sta_remove,
 		.update_survey = mt7996_update_channel,
+		.set_channel = mt7996_set_channel,
 	};
 	struct mt7996_dev *dev;
 	struct mt76_dev *mdev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 177cfff31120..ab8c9070630b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -468,7 +468,7 @@ int mt7996_mcu_add_obss_spr(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 			    struct ieee80211_he_obss_pd *he_obss_pd);
 int mt7996_mcu_add_rate_ctrl(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 			     struct ieee80211_sta *sta, bool changed);
-int mt7996_set_channel(struct mt7996_phy *phy);
+int mt7996_set_channel(struct mt76_phy *mphy);
 int mt7996_mcu_set_chan_info(struct mt7996_phy *phy, u16 tag);
 int mt7996_mcu_set_tx(struct mt7996_dev *dev, struct ieee80211_vif *vif);
 int mt7996_mcu_set_fixed_rate_ctrl(struct mt7996_dev *dev,
-- 
2.46.0


