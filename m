Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2469AAB7
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2019 10:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393117AbfHWIwe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Aug 2019 04:52:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393109AbfHWIwe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Aug 2019 04:52:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 86A8A2BFD2;
        Fri, 23 Aug 2019 08:52:33 +0000 (UTC)
Received: from localhost (unknown [10.43.2.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3DCE95D6D0;
        Fri, 23 Aug 2019 08:52:30 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: [PATCH 3/3] mt76: mt76x0: remove unneeded return value on set channel
Date:   Fri, 23 Aug 2019 10:52:17 +0200
Message-Id: <1566550337-6287-4-git-send-email-sgruszka@redhat.com>
In-Reply-To: <1566550337-6287-1-git-send-email-sgruszka@redhat.com>
References: <1566550337-6287-1-git-send-email-sgruszka@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 23 Aug 2019 08:52:33 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We allways return 0 from mt76x0_phy_set_channel(), no need to pass
return value upward.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 drivers/net/wireless/mediatek/mt76/mt76x0/main.c   | 13 ++++---------
 drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c    |  8 +++-----
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
index 562249eb918c..8a3bb924bef4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
@@ -8,18 +8,16 @@
 #include <linux/etherdevice.h>
 #include "mt76x0.h"
 
-static int
+static void
 mt76x0_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
 {
-	int ret;
-
 	cancel_delayed_work_sync(&dev->cal_work);
 	mt76x02_pre_tbtt_enable(dev, false);
 	if (mt76_is_mmio(dev))
 		tasklet_disable(&dev->dfs_pd.dfs_tasklet);
 
 	mt76_set_channel(&dev->mt76);
-	ret = mt76x0_phy_set_channel(dev, chandef);
+	mt76x0_phy_set_channel(dev, chandef);
 
 	/* channel cycle counters read-and-clear */
 	mt76_rr(dev, MT_CH_IDLE);
@@ -32,20 +30,17 @@
 		tasklet_enable(&dev->dfs_pd.dfs_tasklet);
 	}
 	mt76x02_pre_tbtt_enable(dev, true);
-
-	return ret;
 }
 
 int mt76x0_config(struct ieee80211_hw *hw, u32 changed)
 {
 	struct mt76x02_dev *dev = hw->priv;
-	int ret = 0;
 
 	mutex_lock(&dev->mt76.mutex);
 
 	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
 		ieee80211_stop_queues(hw);
-		ret = mt76x0_set_channel(dev, &hw->conf.chandef);
+		mt76x0_set_channel(dev, &hw->conf.chandef);
 		ieee80211_wake_queues(hw);
 	}
 
@@ -67,6 +62,6 @@ int mt76x0_config(struct ieee80211_hw *hw, u32 changed)
 
 	mutex_unlock(&dev->mt76.mutex);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(mt76x0_config);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h b/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h
index caa87f0c3cb8..26517e062bdb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h
@@ -54,8 +54,8 @@ static inline bool is_mt7630(struct mt76x02_dev *dev)
 /* PHY */
 void mt76x0_phy_init(struct mt76x02_dev *dev);
 int mt76x0_phy_wait_bbp_ready(struct mt76x02_dev *dev);
-int mt76x0_phy_set_channel(struct mt76x02_dev *dev,
-			   struct cfg80211_chan_def *chandef);
+void mt76x0_phy_set_channel(struct mt76x02_dev *dev,
+			    struct cfg80211_chan_def *chandef);
 void mt76x0_phy_set_txpower(struct mt76x02_dev *dev);
 void mt76x0_phy_calibrate(struct mt76x02_dev *dev, bool power_on);
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
index 1d00aa5da95b..711a352dfd5c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
@@ -909,8 +909,8 @@ void mt76x0_phy_calibrate(struct mt76x02_dev *dev, bool power_on)
 }
 EXPORT_SYMBOL_GPL(mt76x0_phy_calibrate);
 
-int mt76x0_phy_set_channel(struct mt76x02_dev *dev,
-			   struct cfg80211_chan_def *chandef)
+void mt76x0_phy_set_channel(struct mt76x02_dev *dev,
+			    struct cfg80211_chan_def *chandef)
 {
 	u32 ext_cca_chan[4] = {
 		[0] = FIELD_PREP(MT_EXT_CCA_CFG_CCA0, 0) |
@@ -1004,7 +1004,7 @@ int mt76x0_phy_set_channel(struct mt76x02_dev *dev,
 	/* enable vco */
 	mt76x0_rf_set(dev, MT_RF(0, 4), BIT(7));
 	if (scan)
-		return 0;
+		return;
 
 	mt76x02_init_agc_gain(dev);
 	mt76x0_phy_calibrate(dev, false);
@@ -1012,8 +1012,6 @@ int mt76x0_phy_set_channel(struct mt76x02_dev *dev,
 
 	ieee80211_queue_delayed_work(dev->mt76.hw, &dev->cal_work,
 				     MT_CALIBRATE_INTERVAL);
-
-	return 0;
 }
 
 static void mt76x0_phy_temp_sensor(struct mt76x02_dev *dev)
-- 
1.9.3

