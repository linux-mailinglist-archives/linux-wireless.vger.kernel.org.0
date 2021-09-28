Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5879A41B2BF
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 17:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241487AbhI1PQs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 11:16:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241450AbhI1PQm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 11:16:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3730A61246;
        Tue, 28 Sep 2021 15:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632842102;
        bh=SJzLo98iVbB0CN9NrgCHSzfgMy9EloUv461315F4AiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gBeXp1lVHGRoJfPbnmjPhg2OtKBvkISwKIxnsf6Vgeg6wMbVzU7Ucnxezy/kwkZXF
         C+swZz+ABuR/6qC/+UEas5X2ATaLPxC77v6xmDN+KPBUAJEXllr4u4U69AczKDyLZO
         pA1UZqF/YZ1+vvNEr+4cMCFQHWKDCWbCYRpMZMxONXvxCTib+4eXGQ+BZihy6e8zuj
         rJZyJ+GN+l4TlLQCIHQv7DaZ8dXuyyAKn2++bSSqLkj/B705PcHiiOh06AK6zfW0uJ
         FzZ73kf8cex6S1/Cw1ulNmVx01mKUeD2yrG/1tX3Zu28Fq1x6a/WhmDBFl2fY7EFbv
         gXvQug9YK92DA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com, john@phrozen.org
Subject: [RFC 7/7] mt76: mt7915: add cac support for offchannel chain
Date:   Tue, 28 Sep 2021 17:14:38 +0200
Message-Id: <1645ce5e1b844675929b74a5671a9bbd8b6d9dfb.1632841652.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632841652.git.lorenzo@kernel.org>
References: <cover.1632841652.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce cac management for dedicated offchannel chain.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  2 ++
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 24 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 15 ++++++++++--
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 ++
 5 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index ba4d644fe846..a3630953d7c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -907,6 +907,8 @@ int mt7915_register_device(struct mt7915_dev *dev)
 	dev->mt76.phy.priv = &dev->phy;
 	INIT_WORK(&dev->rc_work, mt7915_mac_sta_rc_work);
 	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt7915_mac_work);
+	INIT_DELAYED_WORK(&dev->offchan_chain.cac_work,
+			  mt7915_offchan_cac_work);
 	INIT_LIST_HEAD(&dev->sta_rc_list);
 	INIT_LIST_HEAD(&dev->sta_poll_list);
 	INIT_LIST_HEAD(&dev->twt_list);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index a2f94bedf9a1..5d588fe1056d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -2320,9 +2320,13 @@ void mt7915_mac_twt_teardown_flow(struct mt7915_dev *dev,
 int mt7915_dfs_set_rdd_monitor(struct mt7915_phy *phy, bool enable)
 {
 	struct mt7915_dev *dev = phy->dev;
+	struct ieee80211_channel *chan = dev->offchan_chain.chandef.chan;
+	struct delayed_work *cac_work = &dev->offchan_chain.cac_work;
 	int err, region;
 
 	if (!enable || dev->mt76.region == NL80211_DFS_UNSET) {
+		cancel_delayed_work_sync(cac_work);
+
 		err = mt7915_mcu_rdd_cmd(dev, RDD_STOP, MT_RX_SEL2, 0, 0);
 		if (err)
 			return err;
@@ -2349,5 +2353,23 @@ int mt7915_dfs_set_rdd_monitor(struct mt7915_phy *phy, bool enable)
 		break;
 	}
 
-	return mt7915_mcu_rdd_cmd(dev, RDD_START, MT_RX_SEL2, 0, region);
+	err = mt7915_mcu_rdd_cmd(dev, RDD_START, MT_RX_SEL2, 0, region);
+	if (err)
+		return err;
+
+	ieee80211_queue_delayed_work(mt76_hw(dev), cac_work,
+				     msecs_to_jiffies(chan->dfs_cac_ms));
+
+	return 0;
+}
+
+void mt7915_offchan_cac_work(struct work_struct *work)
+{
+	struct mt7915_dev *dev;
+
+	dev = (struct mt7915_dev *)container_of(work, struct mt7915_dev,
+						offchan_chain.cac_work.work);
+	cfg80211_cac_offchan_event(dev->mphy.hw->wiphy,
+				   &dev->offchan_chain.chandef,
+				   NL80211_RADAR_CAC_FINISHED, GFP_KERNEL);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 406517bfbfc2..9020aa7bf359 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -98,6 +98,7 @@ static void mt7915_stop(struct ieee80211_hw *hw)
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
 
 	cancel_delayed_work_sync(&phy->mt76->mac_work);
+	cancel_delayed_work_sync(&dev->offchan_chain.cac_work);
 
 	mutex_lock(&dev->mt76.mutex);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 6249be262825..d24eade6667b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -481,10 +481,21 @@ mt7915_mcu_rx_radar_detected(struct mt7915_dev *dev, struct sk_buff *skb)
 
 	r = (struct mt7915_mcu_rdd_report *)skb->data;
 
-	if (r->band_idx && dev->mt76.phy2)
+	if (r->band_idx == MT_RX_SEL1 && dev->mt76.phy2)
 		mphy = dev->mt76.phy2;
 
-	ieee80211_radar_detected(mphy->hw);
+	if (r->band_idx == MT_RX_SEL2) {
+		cancel_delayed_work_sync(&dev->offchan_chain.cac_work);
+		cfg80211_cac_offchan_event(dev->mphy.hw->wiphy,
+					   &dev->offchan_chain.chandef,
+					   NL80211_RADAR_CAC_ABORTED,
+					   GFP_KERNEL);
+		cfg80211_radar_event(mphy->hw->wiphy,
+				     &dev->offchan_chain.chandef,
+				     GFP_KERNEL);
+	} else {
+		ieee80211_radar_detected(mphy->hw);
+	}
 	dev->hw_pattern++;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 65017a4347b9..6576eb34d211 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -194,6 +194,7 @@ struct mt7915_dev {
 	/* monitor rx chain configured channel */
 	struct {
 		struct cfg80211_chan_def chandef;
+		struct delayed_work cac_work;
 	} offchan_chain;
 
 	u16 chainmask;
@@ -463,6 +464,7 @@ void mt7915_stats_work(struct work_struct *work);
 int mt76_dfs_start_rdd(struct mt7915_dev *dev, bool force);
 int mt7915_dfs_init_radar_detector(struct mt7915_phy *phy);
 int mt7915_dfs_set_rdd_monitor(struct mt7915_phy *phy, bool enable);
+void mt7915_offchan_cac_work(struct work_struct *work);
 void mt7915_set_stream_he_caps(struct mt7915_phy *phy);
 void mt7915_set_stream_vht_txbf_caps(struct mt7915_phy *phy);
 void mt7915_update_channel(struct mt76_phy *mphy);
-- 
2.31.1

