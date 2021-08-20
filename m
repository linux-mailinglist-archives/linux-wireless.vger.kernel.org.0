Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488203F31F1
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Aug 2021 19:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhHTREY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 13:04:24 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.49]:45264 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231512AbhHTREY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 13:04:24 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.122])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 1B9841C0078
        for <linux-wireless@vger.kernel.org>; Fri, 20 Aug 2021 17:03:45 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E488E4007A
        for <linux-wireless@vger.kernel.org>; Fri, 20 Aug 2021 17:03:44 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 35B4513C2B1;
        Fri, 20 Aug 2021 10:03:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 35B4513C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1629479024;
        bh=un5SimXF7cGWe2BUzH9zbvZ4ClYykO5SEst0WA72khA=;
        h=From:To:Cc:Subject:Date:From;
        b=Lsux8YSi7g5MVML0e+jr3tA9QnPs8REfMqLpRjhQKCMHVtfqfL7Q8F79sXPnSOMcc
         r73PyykChMldRv6etRBUj6oOT3drfvhiWBmUF5Kk5a6J/uPwb+MRspIsLtCetCo3Zh
         8NEOLHjbMehYdqC1bFeNit9+A8cNKMD39lOg1DyE=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] mt76: mt7915: fix radar detector logic.
Date:   Fri, 20 Aug 2021 10:03:37 -0700
Message-Id: <20210820170337.22292-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1629479025-5zJnI--xE4TD
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Before this patch, if AP went from ch 100 to ch 36, the radar detector
logic in the firmware was not being disabled.  This made the AP appear
to be up, but no beacons were seen on air until module reload or
reboot.

To reproduce this, I change hostapd.conf and restart hostapd.  Others
on openwrt used their UI to make changes and problem was seen, but
stil others changed channels in some other way and/or had some other
difference and could *not* reproduce it.  So, something perhaps a
bit subtle.

To fix the problem, stop depending on comparing dfs_state, store last
freq/bandwidth to detect changes in that, and streamline code that
checks to enable/disable radar detection.  And add in error checking
and dev_dbg logic so one can see what is actually happening if need
to debug this again.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

This is on top of the patch that checks if there are any AP vifs
before enabling CAC.

 .../net/wireless/mediatek/mt76/mt7915/init.c  |   7 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 100 ++++++++++++------
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  23 +++-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   6 +-
 4 files changed, 98 insertions(+), 38 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index f46ea989a348..543bb1e947e3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -205,6 +205,7 @@ mt7915_regd_notifier(struct wiphy *wiphy,
 	struct mt76_phy *mphy = hw->priv;
 	struct mt7915_phy *phy = mphy->priv;
 	struct cfg80211_chan_def *chandef = &mphy->chandef;
+	int ret;
 
 	memcpy(dev->mt76.alpha2, request->alpha2, sizeof(dev->mt76.alpha2));
 	dev->mt76.region = request->dfs_region;
@@ -215,7 +216,10 @@ mt7915_regd_notifier(struct wiphy *wiphy,
 	if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR))
 		return;
 
-	mt7915_dfs_init_radar_detector(phy);
+	ret = mt7915_dfs_init_radar_detector(phy);
+	if (ret < 0)
+		dev_err(dev->mt76.dev, "init-wifi: dfs-init-radar-detector failed: %d",
+			ret);
 }
 
 static void
@@ -832,7 +836,6 @@ int mt7915_register_device(struct mt7915_dev *dev)
 
 	dev->mphy.hw->wiphy->available_antennas_rx = dev->mphy.chainmask;
 	dev->mphy.hw->wiphy->available_antennas_tx = dev->mphy.chainmask;
-	dev->phy.dfs_state = -1;
 
 #ifdef CONFIG_NL80211_TESTMODE
 	dev->mt76.test_ops = &mt7915_testmode_ops;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 9ef8f763bdc5..ca4ba80f73b2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -2404,14 +2404,29 @@ void mt7915_mac_work(struct work_struct *work)
 				     MT7915_WATCHDOG_TIME);
 }
 
-static void mt7915_dfs_stop_radar_detector(struct mt7915_phy *phy)
+int mt7915_dfs_stop_radar_detector(struct mt7915_phy *phy, bool ext_phy)
 {
 	struct mt7915_dev *dev = phy->dev;
+	int err;
+
+	dev_dbg(dev->mt76.dev, "dfs-stop-radar-detector, rdd-state: 0x%x",
+		phy->rdd_state);
+
+	err = mt7915_mcu_rdd_cmd(dev, RDD_NORMAL_START, ext_phy,
+				 MT_RX_SEL0, 0);
+	if (err < 0) {
+		dev_err(dev->mt76.dev, "mcu-rdd-cmd RDD_NORMAL_START failed: %d",
+			err);
+		/* I think best to carry on, even if we have an error here. */
+	}
 
 	if (phy->rdd_state & BIT(0))
 		mt7915_mcu_rdd_cmd(dev, RDD_STOP, 0, MT_RX_SEL0, 0);
 	if (phy->rdd_state & BIT(1))
 		mt7915_mcu_rdd_cmd(dev, RDD_STOP, 1, MT_RX_SEL0, 0);
+	phy->rdd_state = 0;
+
+	return err;
 }
 
 static int mt7915_dfs_start_rdd(struct mt7915_dev *dev, int chain)
@@ -2419,10 +2434,14 @@ static int mt7915_dfs_start_rdd(struct mt7915_dev *dev, int chain)
 	int err;
 
 	err = mt7915_mcu_rdd_cmd(dev, RDD_START, chain, MT_RX_SEL0, 0);
+
+	dev_dbg(dev->mt76.dev, "dfs-start-rdd, RDD_START rv: %d", err);
 	if (err < 0)
 		return err;
 
-	return mt7915_mcu_rdd_cmd(dev, RDD_DET_MODE, chain, MT_RX_SEL0, 1);
+	err = mt7915_mcu_rdd_cmd(dev, RDD_DET_MODE, chain, MT_RX_SEL0, 1);
+	dev_dbg(dev->mt76.dev, "dfs-start-rdd, RDD_DET_MODE rv: %d", err);
+	return err;
 }
 
 static int mt7915_dfs_start_radar_detector(struct mt7915_phy *phy)
@@ -2519,47 +2538,66 @@ int mt7915_dfs_init_radar_detector(struct mt7915_phy *phy)
 	int err;
 	struct mt7915_vif_counts counts = {0};
 
-	if (dev->mt76.region == NL80211_DFS_UNSET) {
-		phy->dfs_state = -1;
-		if (phy->rdd_state)
-			goto stop;
+	dev_dbg(dev->mt76.dev,
+		"dfs-init-radar-detector, region: %d freq: %d chandef dfs-state: %d",
+		dev->mt76.region, chandef->chan->center_freq,
+		chandef->chan->dfs_state);
 
+	if (test_bit(MT76_SCANNING, &phy->mt76->state)) {
+		dev_dbg(dev->mt76.dev, "init-radar, was scanning, no change.\n");
 		return 0;
 	}
 
-	if (test_bit(MT76_SCANNING, &phy->mt76->state))
-		return 0;
+	if (dev->mt76.region == NL80211_DFS_UNSET) {
+		dev_dbg(dev->mt76.dev,
+			"dfs-init-radar, region is UNSET, disable radar.");
+		goto stop;
+	}
+
+	if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR)) {
+		dev_dbg(dev->mt76.dev,
+			"dfs-init-radar, chandef does not want radar.");
+		goto stop;
+	}
 
-	if (phy->dfs_state == chandef->chan->dfs_state)
+	ieee80211_iterate_active_interfaces(dev->mt76.hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7915_vif_counts, &counts);
+	if (!counts.ap) {
+		/* No AP interfaces, do not start CAC */
+		dev_dbg(dev->mt76.dev,
+			"dfs-init-radar, no AP vifs active, stop radar.");
+		goto stop;
+	}
+
+	/* At this point, we need radar detection, see if we have started
+	 * it already.
+	 */
+	if (phy->rdd_state) {
+		if (chandef->chan->dfs_state == NL80211_DFS_AVAILABLE) {
+			/* CAC is already complete. */
+			dev_dbg(dev->mt76.dev,
+				"init-radar, RADAR started and DFS state is AVAILABLE, call RDD_CAC_END");
+			return mt7915_mcu_rdd_cmd(dev, RDD_CAC_END, ext_phy,
+						  MT_RX_SEL0, 0);
+		}
+		dev_dbg(dev->mt76.dev,
+			"init-radar, rdd_state indicates RADAR already started, DFS state: %d not YET available, rdd_state: 0x%x",
+			chandef->chan->dfs_state, phy->rdd_state);
 		return 0;
+	}
 
 	err = mt7915_dfs_init_radar_specs(phy);
 	if (err < 0) {
-		phy->dfs_state = -1;
+		dev_err(dev->mt76.dev, "dfs-init-radar-specs failed: %d",
+			err);
 		goto stop;
 	}
 
-	phy->dfs_state = chandef->chan->dfs_state;
-
-	if (chandef->chan->flags & IEEE80211_CHAN_RADAR) {
-		if (chandef->chan->dfs_state != NL80211_DFS_AVAILABLE) {
-			ieee80211_iterate_active_interfaces(dev->mt76.hw,
-				IEEE80211_IFACE_ITER_RESUME_ALL,
-				mt7915_vif_counts, &counts);
-			if (counts.ap)
-				mt7915_dfs_start_radar_detector(phy);
-			return 0;
-		}
-		return mt7915_mcu_rdd_cmd(dev, RDD_CAC_END, ext_phy,
-					  MT_RX_SEL0, 0);
-	}
+	err = mt7915_dfs_start_radar_detector(phy);
+	dev_dbg(dev->mt76.dev, "dfs-start-radar-detector rv: %d", err);
+	return err;
 
 stop:
-	err = mt7915_mcu_rdd_cmd(dev, RDD_NORMAL_START, ext_phy,
-				 MT_RX_SEL0, 0);
-	if (err < 0)
-		return err;
-
-	mt7915_dfs_stop_radar_detector(phy);
-	return 0;
+	return mt7915_dfs_stop_radar_detector(phy, ext_phy);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index f3df5ea066a2..6bffddb63461 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -298,6 +298,8 @@ static void mt7915_init_dfs_state(struct mt7915_phy *phy)
 	struct mt76_phy *mphy = phy->mt76;
 	struct ieee80211_hw *hw = mphy->hw;
 	struct cfg80211_chan_def *chandef = &hw->conf.chandef;
+	struct mt7915_dev *dev = phy->dev;
+	bool ext_phy = phy != &dev->phy;
 
 	if (hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
 		return;
@@ -305,11 +307,23 @@ static void mt7915_init_dfs_state(struct mt7915_phy *phy)
 	if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR))
 		return;
 
-	if (mphy->chandef.chan->center_freq == chandef->chan->center_freq &&
-	    mphy->chandef.width == chandef->width)
+	if (phy->dfs_center_freq == chandef->chan->center_freq &&
+	    phy->dfs_ch_width == chandef->width)
 		return;
 
-	phy->dfs_state = -1;
+	/* We are being moved to a new frequency/bw, still on DFS.  Stop
+	 * any existing DFS, then will start it again in the
+	 * init-radar-detector logic.
+	 */
+	if (phy->rdd_state) {
+		dev_dbg(dev->mt76.dev,
+			"init-dfs-state, channel changed, old: %d:%d  new: %d:%d, stopping radar.",
+			phy->dfs_center_freq, phy->dfs_ch_width,
+			chandef->chan->center_freq, chandef->width);
+		mt7915_dfs_stop_radar_detector(phy, ext_phy);
+	}
+	phy->dfs_center_freq = chandef->chan->center_freq;
+	phy->dfs_ch_width = chandef->width;
 }
 
 int mt7915_set_channel(struct mt7915_phy *phy)
@@ -337,6 +351,9 @@ int mt7915_set_channel(struct mt7915_phy *phy)
 
 	mt7915_mac_set_timing(phy);
 	ret = mt7915_dfs_init_radar_detector(phy);
+	if (ret < 0)
+		dev_err(dev->mt76.dev, "set-channel: dfs-init-radar-detector failed: %d",
+			ret);
 	mt7915_mac_cca_stats_reset(phy);
 
 	mt7915_mac_reset_counters(phy);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index f46816cefa3f..a9f55748cf1e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -284,8 +284,9 @@ struct mt7915_phy {
 	s16 coverage_class;
 	u8 slottime;
 
-	u8 rdd_state;
-	int dfs_state;
+	u8 rdd_state; /* radar detection started bitfield */
+	enum nl80211_chan_width dfs_ch_width;
+	u32 dfs_center_freq;
 
 	u32 rx_ampdu_ts;
 	u32 ampdu_ref;
@@ -574,6 +575,7 @@ int mt7915_dfs_init_radar_detector(struct mt7915_phy *phy);
 void mt7915_set_stream_he_caps(struct mt7915_phy *phy);
 void mt7915_set_stream_vht_txbf_caps(struct mt7915_phy *phy);
 void mt7915_update_channel(struct mt76_phy *mphy);
+int mt7915_dfs_stop_radar_detector(struct mt7915_phy *phy, bool ext_phy);
 int mt7915_init_debugfs(struct mt7915_dev *dev);
 #ifdef CONFIG_MAC80211_DEBUGFS
 void mt7915_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-- 
2.20.1

