Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C7738C0D1
	for <lists+linux-wireless@lfdr.de>; Fri, 21 May 2021 09:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbhEUHhK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 May 2021 03:37:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230050AbhEUHhJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 May 2021 03:37:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1455F6108B;
        Fri, 21 May 2021 07:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621582547;
        bh=eUTXSfMxk/1MRd8rgmzRuvKFMHZbK8jWVODnXZ8P0Jo=;
        h=From:To:Cc:Subject:Date:From;
        b=gjc0KwYAZzRQjl6P+BdrM2rf1P8oSwor4EPZVsdUk07yqkSi5crdQ9VNSlEwm7j9+
         VLEiC7ZGvLnQh0eBAio7NOGuh9ndlVxR0HGJueYN2xgOimq9pLTXjYbEssL9QmI5R4
         9FHh9gyNa7gnt1xjX6UlNkVwHMAHV2Rh06R4j7OF2uJTk6v0VfwdATFInnEPiRrZ4a
         W3vCWyLtuK9vhZdI5ssNOvDWS/N2BuV7CUC+SP4oWhbPKpSd/ItuJR9Ua4YklsSpkc
         LAx0BedMzhpc7S+4izArV1/oPPmaXd8hxtOP5LP4eIf6SBEEnimtvT3yAAA0RXCu8f
         mflxmdbST78aw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com, ryder.lee@mediatek.com
Subject: [PATCH] mt76: move interface_modes configuration in hw specific code
Date:   Fri, 21 May 2021 09:35:41 +0200
Message-Id: <2b1f297ab8fd61241d86ff18f9c1ca634289c3f2.1621582373.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move wiphy interface_modes configuration in hw specific code since some
drivers (e.g. mt7921) do not support all operating modes (mt7921 supports
sta only in the current codebase)

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c     | 11 -----------
 drivers/net/wireless/mediatek/mt76/mt7603/init.c  | 10 ++++++++++
 drivers/net/wireless/mediatek/mt76/mt7615/init.c  | 10 ++++++++++
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c | 11 +++++++++++
 drivers/net/wireless/mediatek/mt76/mt7915/init.c  | 12 +++++++++++-
 drivers/net/wireless/mediatek/mt76/mt7921/init.c  |  1 +
 6 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index fa9f80686272..4c4a33e4025d 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -331,17 +331,6 @@ mt76_phy_init(struct mt76_phy *phy, struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, MFP_CAPABLE);
 	ieee80211_hw_set(hw, AP_LINK_PS);
 	ieee80211_hw_set(hw, REPORTS_TX_ACK_STATUS);
-
-	wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
-	wiphy->interface_modes =
-		BIT(NL80211_IFTYPE_STATION) |
-		BIT(NL80211_IFTYPE_AP) |
-#ifdef CONFIG_MAC80211_MESH
-		BIT(NL80211_IFTYPE_MESH_POINT) |
-#endif
-		BIT(NL80211_IFTYPE_P2P_CLIENT) |
-		BIT(NL80211_IFTYPE_P2P_GO) |
-		BIT(NL80211_IFTYPE_ADHOC);
 }
 
 struct mt76_phy *
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 031d39a48a55..dd54b342f11d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -528,6 +528,16 @@ int mt7603_register_device(struct mt7603_dev *dev)
 
 	wiphy->iface_combinations = if_comb;
 	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
+	wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
+	wiphy->interface_modes =
+		BIT(NL80211_IFTYPE_STATION) |
+		BIT(NL80211_IFTYPE_AP) |
+#ifdef CONFIG_MAC80211_MESH
+		BIT(NL80211_IFTYPE_MESH_POINT) |
+#endif
+		BIT(NL80211_IFTYPE_P2P_CLIENT) |
+		BIT(NL80211_IFTYPE_P2P_GO) |
+		BIT(NL80211_IFTYPE_ADHOC);
 
 	ieee80211_hw_set(hw, TX_STATUS_NO_AMPDU_LEN);
 	ieee80211_hw_set(hw, HOST_BROADCAST_PS_BUFFERING);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index a41a14f6d599..e19a5b7d0377 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -331,6 +331,16 @@ mt7615_init_wiphy(struct ieee80211_hw *hw)
 		wiphy->n_iface_combinations = ARRAY_SIZE(if_comb_radar);
 	}
 	wiphy->reg_notifier = mt7615_regd_notifier;
+	wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
+	wiphy->interface_modes =
+		BIT(NL80211_IFTYPE_STATION) |
+		BIT(NL80211_IFTYPE_AP) |
+#ifdef CONFIG_MAC80211_MESH
+		BIT(NL80211_IFTYPE_MESH_POINT) |
+#endif
+		BIT(NL80211_IFTYPE_P2P_CLIENT) |
+		BIT(NL80211_IFTYPE_P2P_GO) |
+		BIT(NL80211_IFTYPE_ADHOC);
 
 	wiphy->max_sched_scan_plan_interval =
 		MT76_CONNAC_MAX_SCHED_SCAN_INTERVAL;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index ccdbab341271..e9bfb04975d5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -173,6 +173,17 @@ void mt76x02_init_device(struct mt76x02_dev *dev)
 		}
 	}
 
+	wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
+	wiphy->interface_modes =
+		BIT(NL80211_IFTYPE_STATION) |
+		BIT(NL80211_IFTYPE_AP) |
+#ifdef CONFIG_MAC80211_MESH
+		BIT(NL80211_IFTYPE_MESH_POINT) |
+#endif
+		BIT(NL80211_IFTYPE_P2P_CLIENT) |
+		BIT(NL80211_IFTYPE_P2P_GO) |
+		BIT(NL80211_IFTYPE_ADHOC);
+
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
 
 	hw->sta_data_size = sizeof(struct mt76x02_sta);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index c103175d9954..17a65d57327a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -116,7 +116,17 @@ mt7915_init_wiphy(struct ieee80211_hw *hw)
 	wiphy->iface_combinations = if_comb;
 	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
 	wiphy->reg_notifier = mt7915_regd_notifier;
-	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
+	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH |
+			WIPHY_FLAG_IBSS_RSN;
+	wiphy->interface_modes =
+		BIT(NL80211_IFTYPE_STATION) |
+		BIT(NL80211_IFTYPE_AP) |
+#ifdef CONFIG_MAC80211_MESH
+		BIT(NL80211_IFTYPE_MESH_POINT) |
+#endif
+		BIT(NL80211_IFTYPE_P2P_CLIENT) |
+		BIT(NL80211_IFTYPE_P2P_GO) |
+		BIT(NL80211_IFTYPE_ADHOC);
 
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index d78eb4ec4b8a..f4bf8360615f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -62,6 +62,7 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	hw->vif_data_size = sizeof(struct mt7921_vif);
 
 	wiphy->iface_combinations = if_comb;
+	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION);
 	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
 	wiphy->max_scan_ie_len = MT76_CONNAC_SCAN_IE_LEN;
 	wiphy->max_scan_ssids = 4;
-- 
2.31.1

