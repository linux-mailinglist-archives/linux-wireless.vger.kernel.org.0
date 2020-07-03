Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF4D213616
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2020 10:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgGCIQg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jul 2020 04:16:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726749AbgGCIQf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jul 2020 04:16:35 -0400
Received: from lore-desk.lan (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8A1B206A1;
        Fri,  3 Jul 2020 08:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593764195;
        bh=NwFHdarlsNaJlUi/KIKifaoAqMuSWtyiUxMzZHRiKjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gW+0/2PSvQbR20djFS+kbKIHM7VJxzJhU+wDvo+SdTsy/esJhRkhraN+2QfCbwXnE
         5T4NGom4ARQipgBJmUv8oisYKgQb7a85uzUWTVuAb02eOFlBI++48GCfXxf/MhnCSy
         Mr9yOPZBHBr9LKmG/GVzxjHXDyMBkmS9eu7q3F1k=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 08/22] mt76: mt7615: wake device in mt7615_update_channel before access regmap
Date:   Fri,  3 Jul 2020 10:15:47 +0200
Message-Id: <818fc3c210f149cb44dcd608f4ac2582398dcfee.1593763584.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593763584.git.lorenzo@kernel.org>
References: <cover.1593763584.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt7615_update_survey utility routine in order to compute
survey stats without waking up the device since it runs holding mt76 lock.
Run mt7615_pm_wake directly in mt7615_update_channel since it can run
with mt76.mutex held if called by mac80211

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c |  4 +--
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 30 +++++++++++++++++--
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 6aa3efa8f55e..f340af40f8f4 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -560,8 +560,7 @@ mt76_channel_state(struct mt76_phy *phy, struct ieee80211_channel *c)
 	return &msband->chan[idx];
 }
 
-static void
-mt76_update_survey_active_time(struct mt76_phy *phy, ktime_t time)
+void mt76_update_survey_active_time(struct mt76_phy *phy, ktime_t time)
 {
 	struct mt76_channel_state *state = phy->chan_state;
 
@@ -569,6 +568,7 @@ mt76_update_survey_active_time(struct mt76_phy *phy, ktime_t time)
 						  phy->survey_time));
 	phy->survey_time = time;
 }
+EXPORT_SYMBOL_GPL(mt76_update_survey_active_time);
 
 void mt76_update_survey(struct mt76_dev *dev)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 265ee55d22f1..c6e44283bd5f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -893,6 +893,7 @@ void mt76_release_buffered_frames(struct ieee80211_hw *hw,
 bool mt76_has_tx_pending(struct mt76_phy *phy);
 void mt76_set_channel(struct mt76_phy *phy);
 void mt76_update_survey(struct mt76_dev *dev);
+void mt76_update_survey_active_time(struct mt76_phy *phy, ktime_t time);
 int mt76_get_survey(struct ieee80211_hw *hw, int idx,
 		    struct survey_info *survey);
 void mt76_set_stream_caps(struct mt76_phy *phy, bool vht);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 2411fa66efa3..f62e7de81bd5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1747,9 +1747,9 @@ mt7615_phy_update_channel(struct mt76_phy *mphy, int idx)
 	state->noise = -(phy->noise >> 4);
 }
 
-void mt7615_update_channel(struct mt76_dev *mdev)
+static void __mt7615_update_channel(struct mt7615_dev *dev)
 {
-	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+	struct mt76_dev *mdev = &dev->mt76;
 
 	mt7615_phy_update_channel(&mdev->phy, 0);
 	if (mdev->phy2)
@@ -1758,8 +1758,32 @@ void mt7615_update_channel(struct mt76_dev *mdev)
 	/* reset obss airtime */
 	mt76_set(dev, MT_WF_RMAC_MIB_TIME0, MT_WF_RMAC_MIB_RXTIME_CLR);
 }
+
+void mt7615_update_channel(struct mt76_dev *mdev)
+{
+	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+
+	if (mt7615_pm_wake(dev))
+		return;
+
+	__mt7615_update_channel(dev);
+	mt7615_pm_power_save_sched(dev);
+}
 EXPORT_SYMBOL_GPL(mt7615_update_channel);
 
+static void mt7615_update_survey(struct mt7615_dev *dev)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+	ktime_t cur_time;
+
+	__mt7615_update_channel(dev);
+	cur_time = ktime_get_boottime();
+
+	mt76_update_survey_active_time(&mdev->phy, cur_time);
+	if (mdev->phy2)
+		mt76_update_survey_active_time(mdev->phy2, cur_time);
+}
+
 static void
 mt7615_mac_update_mib_stats(struct mt7615_phy *phy)
 {
@@ -1888,7 +1912,7 @@ void mt7615_mac_work(struct work_struct *work)
 
 	mt7615_mutex_acquire(phy->dev);
 
-	mt76_update_survey(mdev);
+	mt7615_update_survey(phy->dev);
 	if (++phy->mac_work_count == 5) {
 		phy->mac_work_count = 0;
 
-- 
2.26.2

