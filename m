Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6447D4F004
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2019 22:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfFUUbi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Jun 2019 16:31:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfFUUbi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Jun 2019 16:31:38 -0400
Received: from localhost.localdomain (unknown [151.66.61.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1430A2084E;
        Fri, 21 Jun 2019 20:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561149097;
        bh=z94vrFBcpPSifmkHDGP7VDF1zhRerZqttstdv7wwKFQ=;
        h=From:To:Cc:Subject:Date:From;
        b=PkiAgWntYlCjv3E+MWq+X2WbdW/nVPucjqAzy4pycc/+oT0q73H7W0D51SeqcTAVC
         ZRJkcoyFJ4t9Sr6Kisx0kRmPRuNBrDLGCWC5J9edHGUt1YPpzy5bCvUiJ2+L+kDB3z
         AkSbJ3Q7OpHIT0nK8wDtlJzxKZykdDBqlBR0T6WE=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: move nl80211_dfs_regions in mt76_dev data structure
Date:   Fri, 21 Jun 2019 22:31:28 +0200
Message-Id: <2af31635c9e669812d495d9471b7ebd9d871d5a7.1561148802.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move dfs region field in mt76_dev data structure since it is
used by all drivers. This is a preliminary patch to add DFS support to
mt7615 driver

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h        |  2 ++
 .../net/wireless/mediatek/mt76/mt7603/debugfs.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/init.c |  4 ++--
 .../net/wireless/mediatek/mt76/mt7603/mt7603.h   |  2 --
 .../net/wireless/mediatek/mt76/mt76x02_debugfs.c |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c | 16 ++++++++--------
 drivers/net/wireless/mediatek/mt76/mt76x02_dfs.h |  2 --
 7 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 9110a895604a..2c107817610c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -486,6 +486,8 @@ struct mt76_dev {
 	int txpower_conf;
 	int txpower_cur;
 
+	enum nl80211_dfs_regions region;
+
 	u32 debugfs_reg;
 
 	struct led_classdev led_cdev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
index 9c0bea489e1f..a1bc3103cbe9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
@@ -49,7 +49,7 @@ mt7603_edcca_set(void *data, u64 val)
 
 	dev->ed_monitor_enabled = !!val;
 	dev->ed_monitor = dev->ed_monitor_enabled &&
-			  dev->region == NL80211_DFS_ETSI;
+			  dev->mt76.region == NL80211_DFS_ETSI;
 	mt7603_init_edcca(dev);
 
 	mutex_unlock(&dev->mt76.mutex);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index bce51997ff3b..75e3da452585 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -437,9 +437,9 @@ mt7603_regd_notifier(struct wiphy *wiphy,
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct mt7603_dev *dev = hw->priv;
 
-	dev->region = request->dfs_region;
+	dev->mt76.region = request->dfs_region;
 	dev->ed_monitor = dev->ed_monitor_enabled &&
-			  dev->region == NL80211_DFS_ETSI;
+			  dev->mt76.region == NL80211_DFS_ETSI;
 }
 
 static int
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index 944dc9a11a15..eb5c4880342b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -118,8 +118,6 @@ struct mt7603_dev {
 
 	u8 mcu_running;
 
-	enum nl80211_dfs_regions region;
-
 	u8 ed_monitor_enabled;
 	u8 ed_monitor;
 	s8 ed_trigger;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c b/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
index ffdba5ffc22d..1b1e424ccbb2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
@@ -120,7 +120,7 @@ static int
 mt76_edcca_set(void *data, u64 val)
 {
 	struct mt76x02_dev *dev = data;
-	enum nl80211_dfs_regions region = dev->dfs_pd.region;
+	enum nl80211_dfs_regions region = dev->mt76.region;
 
 	mutex_lock(&dev->mt76.mutex);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c b/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c
index 84b845647881..50e9b310e496 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c
@@ -283,7 +283,7 @@ static bool mt76x02_dfs_check_hw_pulse(struct mt76x02_dev *dev,
 	if (!pulse->period || !pulse->w1)
 		return false;
 
-	switch (dev->dfs_pd.region) {
+	switch (dev->mt76.region) {
 	case NL80211_DFS_FCC:
 		if (pulse->engine > 3)
 			break;
@@ -457,7 +457,7 @@ static int mt76x02_dfs_create_sequence(struct mt76x02_dev *dev,
 		with_sum = event->width + cur_event->width;
 
 		sw_params = &dfs_pd->sw_dpd_params;
-		switch (dev->dfs_pd.region) {
+		switch (dev->mt76.region) {
 		case NL80211_DFS_FCC:
 		case NL80211_DFS_JP:
 			if (with_sum < 600)
@@ -685,7 +685,7 @@ static void mt76x02_dfs_init_sw_detector(struct mt76x02_dev *dev)
 {
 	struct mt76x02_dfs_pattern_detector *dfs_pd = &dev->dfs_pd;
 
-	switch (dev->dfs_pd.region) {
+	switch (dev->mt76.region) {
 	case NL80211_DFS_FCC:
 		dfs_pd->sw_dpd_params.max_pri = MT_DFS_FCC_MAX_PRI;
 		dfs_pd->sw_dpd_params.min_pri = MT_DFS_FCC_MIN_PRI;
@@ -725,7 +725,7 @@ static void mt76x02_dfs_set_bbp_params(struct mt76x02_dev *dev)
 		break;
 	}
 
-	switch (dev->dfs_pd.region) {
+	switch (dev->mt76.region) {
 	case NL80211_DFS_FCC:
 		radar_specs = &fcc_radar_specs[shift];
 		break;
@@ -836,7 +836,7 @@ void mt76x02_dfs_init_params(struct mt76x02_dev *dev)
 	struct cfg80211_chan_def *chandef = &dev->mt76.chandef;
 
 	if ((chandef->chan->flags & IEEE80211_CHAN_RADAR) &&
-	    dev->dfs_pd.region != NL80211_DFS_UNSET) {
+	    dev->mt76.region != NL80211_DFS_UNSET) {
 		mt76x02_dfs_init_sw_detector(dev);
 		mt76x02_dfs_set_bbp_params(dev);
 		/* enable debug mode */
@@ -869,7 +869,7 @@ void mt76x02_dfs_init_detector(struct mt76x02_dev *dev)
 
 	INIT_LIST_HEAD(&dfs_pd->sequences);
 	INIT_LIST_HEAD(&dfs_pd->seq_pool);
-	dfs_pd->region = NL80211_DFS_UNSET;
+	dev->mt76.region = NL80211_DFS_UNSET;
 	dfs_pd->last_sw_check = jiffies;
 	tasklet_init(&dfs_pd->dfs_tasklet, mt76x02_dfs_tasklet,
 		     (unsigned long)dev);
@@ -882,14 +882,14 @@ mt76x02_dfs_set_domain(struct mt76x02_dev *dev,
 	struct mt76x02_dfs_pattern_detector *dfs_pd = &dev->dfs_pd;
 
 	mutex_lock(&dev->mt76.mutex);
-	if (dfs_pd->region != region) {
+	if (dev->mt76.region != region) {
 		tasklet_disable(&dfs_pd->dfs_tasklet);
 
 		dev->ed_monitor = dev->ed_monitor_enabled &&
 				  region == NL80211_DFS_ETSI;
 		mt76x02_edcca_init(dev);
 
-		dfs_pd->region = region;
+		dev->mt76.region = region;
 		mt76x02_dfs_init_params(dev);
 		tasklet_enable(&dfs_pd->dfs_tasklet);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.h b/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.h
index 70b394e17340..0408613b45a4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.h
@@ -118,8 +118,6 @@ struct mt76x02_dfs_seq_stats {
 };
 
 struct mt76x02_dfs_pattern_detector {
-	enum nl80211_dfs_regions region;
-
 	u8 chirp_pulse_cnt;
 	u32 chirp_pulse_ts;
 
-- 
2.21.0

