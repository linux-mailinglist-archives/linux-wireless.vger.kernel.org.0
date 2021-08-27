Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D769B3F9D3D
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Aug 2021 19:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhH0RHg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Aug 2021 13:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhH0RHf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Aug 2021 13:07:35 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC63BC061757
        for <linux-wireless@vger.kernel.org>; Fri, 27 Aug 2021 10:06:46 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id u15so4297354plg.13
        for <linux-wireless@vger.kernel.org>; Fri, 27 Aug 2021 10:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monroe-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mNFw7xoNmzK6n+hoew3r+jmAx5ozOzvIkhn9LjQvX+U=;
        b=go6ybA/RROR1WvT6aJrLOSMZpBnNm1UtgOxxqdgS6r6CUnDf5OTaLfSao660V2yDdP
         tqfOt9N7TFggaVqTGE+8TlVwpAnkvnKZ8mYzjrUqE6dJtvvpxoJBsLus6Wc6w792pg/h
         St4rOzt3RKU9ZZVySjPxX7NChqZ72Yb0nQO/w5b017ijb6sqk/LQpz/awu5odL4bmZKo
         mnz/fF+n6pRXC8gJqizPDRz3fCDExUKDODAHSPwYTziNq//OEM5hroYT7Dk3/V61SYU6
         g2+iE5ysQCPwwQyELFSfCMLETu1HYtqvNXqfOML/cEi027opHeagsr3hfP9khHzvd+MX
         VTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mNFw7xoNmzK6n+hoew3r+jmAx5ozOzvIkhn9LjQvX+U=;
        b=p7CYWKaVzc1YqOVYporZNOeWcdZvIjRTrTYC6kAfw0DdvNSJT/DS8R12DEiDP6Ug7l
         eef4MXAKg2SbfmNEXvxgchBWi3VRW5FQnOL/C/7g8LcOiYkhXcgs690lKTuH2Kh4RtYK
         /mpyQAullO7qJgIZdDMjMlRvjzRvRApAZ6kwZ7idQqA8us9FQ4k6UGFouH1lIq998g/3
         /8v6v/PVt4xTjjcCTDsPMYjw1P/e9XzpW5SFIPeYpqPkhc/xjRpoyVnx3uckKgeQ6zrF
         e5WfaM8heWjuU5wYzNRMMP444/vdgHeQVUK4WlZkP7g2Uuwpx8eKmT+g8hV8MaUKE8oD
         weOw==
X-Gm-Message-State: AOAM532cZ/bLQla2eOI/WxinaFvD4tYSlZdy/+Xdc5Ay4J2Jbcm4EJ7D
        9y0zV8SjyPi0BF4+6vX7bWbc8g==
X-Google-Smtp-Source: ABdhPJym4dbKHsj8jDZ8SlEdw3TVmEuvZeGu/MZVsczAqbPDCZdHsJgcWGg/Rar+GMIdfj/FW2z9mw==
X-Received: by 2002:a17:90a:e511:: with SMTP id t17mr11740185pjy.172.1630084006146;
        Fri, 27 Aug 2021 10:06:46 -0700 (PDT)
Received: from bfg9000.smartrg.link (wsip-98-173-202-84.sb.sd.cox.net. [98.173.202.84])
        by smtp.googlemail.com with ESMTPSA id s32sm6546670pfw.84.2021.08.27.10.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 10:06:45 -0700 (PDT)
From:   Chad Monroe <chad@monroe.io>
To:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chad Monroe <chad@monroe.io>,
        Ben Greear <greearb@candelatech.com>
Subject: [PATCH 2/2] mt76: mt7615: fix radar detector logic
Date:   Fri, 27 Aug 2021 10:06:32 -0700
Message-Id: <4a4bb98aa6dd1c7f4671d11a901fb8cf35f49308.1630081048.git.chad@monroe.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <54c9a89210608d2a9b9adf37a8c2a743275e5723.1630081048.git.chad@monroe.io>
References: <54c9a89210608d2a9b9adf37a8c2a743275e5723.1630081048.git.chad@monroe.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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
Signed-off-by: Chad Monroe <chad@monroe.io>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  12 ++-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 102 ++++++++++++------
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  25 ++++-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   6 +-
 4 files changed, 104 insertions(+), 41 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 05235a60d413..23dde13c2703 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -333,6 +333,7 @@ mt7615_regd_notifier(struct wiphy *wiphy,
 	struct mt76_phy *mphy = hw->priv;
 	struct mt7615_phy *phy = mphy->priv;
 	struct cfg80211_chan_def *chandef = &mphy->chandef;
+	int ret;
 
 	memcpy(dev->mt76.alpha2, request->alpha2, sizeof(dev->mt76.alpha2));
 	dev->mt76.region = request->dfs_region;
@@ -342,14 +343,18 @@ mt7615_regd_notifier(struct wiphy *wiphy,
 
 	mt7615_mutex_acquire(dev);
 
-	if (chandef->chan->flags & IEEE80211_CHAN_RADAR)
-		mt7615_dfs_init_radar_detector(phy);
-
 	if (mt7615_firmware_offload(phy->dev)) {
 		mt76_connac_mcu_set_channel_domain(mphy);
 		mt76_connac_mcu_set_rate_txpower(mphy);
 	}
 
+	if (chandef->chan->flags & IEEE80211_CHAN_RADAR) {
+		ret = mt7615_dfs_init_radar_detector(phy);
+		if (ret < 0)
+			dev_err(dev->mt76.dev, "init-wifi: dfs-init-radar-detector failed: %d",
+				ret);
+	}
+
 	mt7615_mutex_release(dev);
 }
 
@@ -550,7 +555,6 @@ void mt7615_init_device(struct mt7615_dev *dev)
 	dev->pm.stats.last_wake_event = jiffies;
 	dev->pm.stats.last_doze_event = jiffies;
 	mt7615_cap_dbdc_disable(dev);
-	dev->phy.dfs_state = -1;
 
 #ifdef CONFIG_NL80211_TESTMODE
 	dev->mt76.test_ops = &mt7615_testmode_ops;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 78b55e872da0..571fa73baa76 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -2101,14 +2101,29 @@ void mt7615_tx_token_put(struct mt7615_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt7615_tx_token_put);
 
-static void mt7615_dfs_stop_radar_detector(struct mt7615_phy *phy)
+int mt7615_dfs_stop_radar_detector(struct mt7615_phy *phy, bool ext_phy)
 {
 	struct mt7615_dev *dev = phy->dev;
+	int err;
+
+	dev_dbg(dev->mt76.dev, "dfs-stop-radar-detector, rdd-state: 0x%x",
+		phy->rdd_state);
+
+	err = mt7615_mcu_rdd_cmd(dev, RDD_NORMAL_START, ext_phy,
+				 MT_RX_SEL0, 0);
+	if (err < 0) {
+		dev_err(dev->mt76.dev, "mcu-rdd-cmd RDD_NORMAL_START failed: %d",
+			err);
+		/* I think best to carry on, even if we have an error here. */
+	}
 
 	if (phy->rdd_state & BIT(0))
 		mt7615_mcu_rdd_cmd(dev, RDD_STOP, 0, MT_RX_SEL0, 0);
 	if (phy->rdd_state & BIT(1))
 		mt7615_mcu_rdd_cmd(dev, RDD_STOP, 1, MT_RX_SEL0, 0);
+	phy->rdd_state = 0;
+
+	return err;
 }
 
 static int mt7615_dfs_start_rdd(struct mt7615_dev *dev, int chain)
@@ -2116,11 +2131,14 @@ static int mt7615_dfs_start_rdd(struct mt7615_dev *dev, int chain)
 	int err;
 
 	err = mt7615_mcu_rdd_cmd(dev, RDD_START, chain, MT_RX_SEL0, 0);
+
+	dev_dbg(dev->mt76.dev, "dfs-start-rdd, RDD_START rv: %d", err);
 	if (err < 0)
 		return err;
 
-	return mt7615_mcu_rdd_cmd(dev, RDD_DET_MODE, chain,
-				  MT_RX_SEL0, 1);
+	err = mt7615_mcu_rdd_cmd(dev, RDD_DET_MODE, chain, MT_RX_SEL0, 1);
+	dev_dbg(dev->mt76.dev, "dfs-start-rdd, RDD_DET_MODE rv: %d", err);
+	return err;
 }
 
 static int mt7615_dfs_start_radar_detector(struct mt7615_phy *phy)
@@ -2227,48 +2245,70 @@ int mt7615_dfs_init_radar_detector(struct mt7615_phy *phy)
 	if (is_mt7663(&dev->mt76))
 		return 0;
 
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
+
+	ieee80211_iterate_active_interfaces(phy->mt76->hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7615_vif_counts, &counts);
+
+	if (!(counts.ap + counts.adhoc + counts.mesh)) {
+		/* No beaconning interfaces, do not start CAC */
+		dev_dbg(dev->mt76.dev,
+			"dfs-init-radar, no AP/Mesh/Adhoc vifs active, stop radar.");
+		goto stop;
+	}
 
-	if (phy->dfs_state == chandef->chan->dfs_state)
+	/* At this point, we need radar detection, see if we have started
+	 * it already.
+	 */
+	if (phy->rdd_state) {
+		if (chandef->chan->dfs_state == NL80211_DFS_AVAILABLE) {
+			/* CAC is already complete. */
+			dev_dbg(dev->mt76.dev,
+				"init-radar, RADAR started and DFS state is AVAILABLE, call RDD_CAC_END");
+			return mt7615_mcu_rdd_cmd(dev, RDD_CAC_END, ext_phy,
+						  MT_RX_SEL0, 0);
+		}
+		dev_dbg(dev->mt76.dev,
+			"init-radar, rdd_state indicates RADAR already started,"
+			" DFS state: %d not YET available, rdd_state: 0x%x",
+			chandef->chan->dfs_state, phy->rdd_state);
 		return 0;
+	}
 
 	err = mt7615_dfs_init_radar_specs(phy);
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
-			ieee80211_iterate_active_interfaces(phy->mt76->hw,
-				IEEE80211_IFACE_ITER_RESUME_ALL,
-				mt7615_vif_counts, &counts);
-			if (counts.ap + counts.adhoc + counts.mesh)
-				mt7615_dfs_start_radar_detector(phy);
-			return 0;
-		}
-		return mt7615_mcu_rdd_cmd(dev, RDD_CAC_END, ext_phy,
-					  MT_RX_SEL0, 0);
-	}
+	err = mt7615_dfs_start_radar_detector(phy);
+	dev_dbg(dev->mt76.dev, "dfs-start-radar-detector rv: %d", err);
+	return err;
 
 stop:
-	err = mt7615_mcu_rdd_cmd(dev, RDD_NORMAL_START, ext_phy, MT_RX_SEL0, 0);
-	if (err < 0)
-		return err;
-
-	mt7615_dfs_stop_radar_detector(phy);
-	return 0;
+	return mt7615_dfs_stop_radar_detector(phy, ext_phy);
 }
 
 int mt7615_mac_set_beacon_filter(struct mt7615_phy *phy,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 7154acf3eb9b..484c8803726f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -291,6 +291,8 @@ static void mt7615_init_dfs_state(struct mt7615_phy *phy)
 	struct mt76_phy *mphy = phy->mt76;
 	struct ieee80211_hw *hw = mphy->hw;
 	struct cfg80211_chan_def *chandef = &hw->conf.chandef;
+	struct mt7615_dev *dev = phy->dev;
+	bool ext_phy = phy != &dev->phy;
 
 	if (hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
 		return;
@@ -298,11 +300,23 @@ static void mt7615_init_dfs_state(struct mt7615_phy *phy)
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
+		mt7615_dfs_stop_radar_detector(phy, ext_phy);
+	}
+	phy->dfs_center_freq = chandef->chan->center_freq;
+	phy->dfs_ch_width = chandef->width;
 }
 
 int mt7615_set_channel(struct mt7615_phy *phy)
@@ -336,8 +350,11 @@ int mt7615_set_channel(struct mt7615_phy *phy)
 
 	mt7615_mac_set_timing(phy);
 	ret = mt7615_dfs_init_radar_detector(phy);
-	if (ret)
+	if (ret < 0) {
+		dev_err(dev->mt76.dev, "set-channel: dfs-init-radar-detector failed: %d",
+			ret);
 		goto out;
+	}
 
 	mt7615_mac_cca_stats_reset(phy);
 	ret = mt7615_mcu_set_sku_en(phy, true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 58a98b5c0cbc..6a3209439492 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -164,8 +164,9 @@ struct mt7615_phy {
 	u8 slottime;
 
 	u8 chfreq;
-	u8 rdd_state;
-	int dfs_state;
+	u8 rdd_state; /* radar detection started bitfield */
+	enum nl80211_chan_width dfs_ch_width;
+	u32 dfs_center_freq;
 
 	u32 rx_ampdu_ts;
 	u32 ampdu_ref;
@@ -540,6 +541,7 @@ int mt7615_mcu_set_sku_en(struct mt7615_phy *phy, bool enable);
 int mt7615_mcu_apply_rx_dcoc(struct mt7615_phy *phy);
 int mt7615_mcu_apply_tx_dpd(struct mt7615_phy *phy);
 int mt7615_dfs_init_radar_detector(struct mt7615_phy *phy);
+int mt7615_dfs_stop_radar_detector(struct mt7615_phy *phy, bool ext_phy);
 
 int mt7615_mcu_set_roc(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		       struct ieee80211_channel *chan, int duration);
-- 
2.20.1

