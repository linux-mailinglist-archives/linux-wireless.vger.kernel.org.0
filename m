Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FCA39419F
	for <lists+linux-wireless@lfdr.de>; Fri, 28 May 2021 13:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbhE1LE2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 May 2021 07:04:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236596AbhE1LEW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 May 2021 07:04:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24AA9613B6;
        Fri, 28 May 2021 11:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622199763;
        bh=Yp5M4BTKVbrtIZiKOHmt6JRhzbPNWFwKVyM03acKxww=;
        h=From:To:Cc:Subject:Date:From;
        b=sofQnFolcXfewv5fs+qKmypLeq8mThwtdN5nvBDryKsM8O70Kl1heggodKTxOik8/
         CK983vMWmA9OG2v3r30NQsOoHQCjINO33arGHVmQYFV8HWbR9/QsHZVda22flf1vxs
         erDHo0oR8lz7Z4PFYtYVjnVk+r3yrNc6Qb4z5E/37fQ3+rXl0C/X8LNEpOaCVeYR0j
         e4lymi+HZyRiIZL2jHIrXW7R/z81ceFdagn3blvXlvhBN0GGUNpZDqWUyPXfy4sWoC
         mFhDtC24MYQy7ahzx2ZMhJhSsRutczwYkTa1Gx+EYx27eJgSeeLaCiagcra9Fh6j0Q
         5GSxJ0KH8piVg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH v2] mt76: allow hw driver code to overwrite wiphy interface_modes
Date:   Fri, 28 May 2021 13:02:24 +0200
Message-Id: <ab0e389729d33759ad0aca1f1a98546bc4599df4.1622199436.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move wiphy interface_modes configuration in mt76_alloc_device and
mt76_alloc_phy in order to be overwritten by hw specific code
since some drivers do not support all operating modes (mt7921
supports sta only in the current codebase)

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- move wiphy interface_modes configuration in mt76_alloc_device and
  mt76_alloc_phy
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 33 ++++++++++++-------
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  2 ++
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index fa9f80686272..5a11dacae09f 100644
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
@@ -362,6 +351,17 @@ mt76_alloc_phy(struct mt76_dev *dev, unsigned int size,
 	phy->hw = hw;
 	phy->priv = hw->priv + phy_size;
 
+	hw->wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
+	hw->wiphy->interface_modes =
+		BIT(NL80211_IFTYPE_STATION) |
+		BIT(NL80211_IFTYPE_AP) |
+#ifdef CONFIG_MAC80211_MESH
+		BIT(NL80211_IFTYPE_MESH_POINT) |
+#endif
+		BIT(NL80211_IFTYPE_P2P_CLIENT) |
+		BIT(NL80211_IFTYPE_P2P_GO) |
+		BIT(NL80211_IFTYPE_ADHOC);
+
 	return phy;
 }
 EXPORT_SYMBOL_GPL(mt76_alloc_phy);
@@ -444,6 +444,17 @@ mt76_alloc_device(struct device *pdev, unsigned int size,
 	mutex_init(&dev->mcu.mutex);
 	dev->tx_worker.fn = mt76_tx_worker;
 
+	hw->wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
+	hw->wiphy->interface_modes =
+		BIT(NL80211_IFTYPE_STATION) |
+		BIT(NL80211_IFTYPE_AP) |
+#ifdef CONFIG_MAC80211_MESH
+		BIT(NL80211_IFTYPE_MESH_POINT) |
+#endif
+		BIT(NL80211_IFTYPE_P2P_CLIENT) |
+		BIT(NL80211_IFTYPE_P2P_GO) |
+		BIT(NL80211_IFTYPE_ADHOC);
+
 	spin_lock_init(&dev->token_lock);
 	idr_init(&dev->token);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 6374f6719856..59da29032645 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -62,6 +62,8 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	hw->vif_data_size = sizeof(struct mt7921_vif);
 
 	wiphy->iface_combinations = if_comb;
+	wiphy->flags &= ~WIPHY_FLAG_IBSS_RSN;
+	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION);
 	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
 	wiphy->max_scan_ie_len = MT76_CONNAC_SCAN_IE_LEN;
 	wiphy->max_scan_ssids = 4;
-- 
2.31.1

