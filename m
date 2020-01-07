Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB7A13283F
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2020 14:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgAGN7v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jan 2020 08:59:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:37380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbgAGN7v (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jan 2020 08:59:51 -0500
Received: from new-host-3.redhat.com (net-2-42-61-77.cust.vodafonedsl.it [2.42.61.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBDA02087F;
        Tue,  7 Jan 2020 13:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578405590;
        bh=KrOxa2l64iWq/UyD6/WgsNSXGy4ROnUknfQWhSnFD8Y=;
        h=From:To:Cc:Subject:Date:From;
        b=tfKXdVmnwvkLiKpifisP1+QgZ/1/abQ3jDolDeCUGbizlLCAaX7F2Pi671E2jH+18
         K2Sprvc137Xy8cwsdIg3TyEhyrUMEl9Chb/vSygvOr6bV7t7k1pqgzmNrj9onge14Z
         oPVC0zwt3a0a9D3ksm+53LzraSObpscnGcS28Hxg=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: move WIPHY_FLAG_HAS_CHANNEL_SWITCH in mt76_phy_init
Date:   Tue,  7 Jan 2020 14:59:34 +0100
Message-Id: <2976d83f00a3b03909ff2814c2161801d729c456.1578405489.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move WIPHY_FLAG_HAS_CHANNEL_SWITCH in mt76-core module since now all
drivers support Channel Switch Announcement

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c     | 1 +
 drivers/net/wireless/mediatek/mt76/mt7603/init.c  | 1 -
 drivers/net/wireless/mediatek/mt76/mt7615/init.c  | 1 -
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c | 1 -
 4 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index f462a72b043c..9947e627318b 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -279,6 +279,7 @@ mt76_phy_init(struct mt76_dev *dev, struct ieee80211_hw *hw)
 	SET_IEEE80211_PERM_ADDR(hw, dev->macaddr);
 
 	wiphy->features |= NL80211_FEATURE_ACTIVE_MONITOR;
+	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
 
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_AIRTIME_FAIRNESS);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 32fdb81b2bb0..182ce5a86f65 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -564,7 +564,6 @@ int mt7603_register_device(struct mt7603_dev *dev)
 		dev->mt76.led_cdev.blink_set = mt7603_led_set_blink;
 	}
 
-	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
 	wiphy->reg_notifier = mt7603_regd_notifier;
 
 	ret = mt76_register_device(&dev->mt76, true, mt7603_rates,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 403e8051dc7b..e626842988e8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -341,7 +341,6 @@ mt7615_init_wiphy(struct ieee80211_hw *hw)
 	wiphy->iface_combinations = if_comb;
 	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
 	wiphy->reg_notifier = mt7615_regd_notifier;
-	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
 
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 28d8d447fc76..48da4f3a17db 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -175,7 +175,6 @@ void mt76x02_init_device(struct mt76x02_dev *dev)
 		}
 	}
 
-	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
 
 	hw->sta_data_size = sizeof(struct mt76x02_sta);
-- 
2.21.1

