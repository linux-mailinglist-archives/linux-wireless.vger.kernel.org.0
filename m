Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 250F1EAD08
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2019 11:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfJaKDb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Oct 2019 06:03:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbfJaKDa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Oct 2019 06:03:30 -0400
Received: from localhost.localdomain.com (unknown [176.229.194.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36E1620862;
        Thu, 31 Oct 2019 10:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572516209;
        bh=pzit5unwoaiIN6E5PyZAEM/n4wlr/kcb2JmVVdV6kNU=;
        h=From:To:Cc:Subject:Date:From;
        b=LHuwJ6KtCcCjCvrRJWa70ayqZoCYofqhzHKi5I77pxtNGeBC1a10Ms7mPfLtL2YxO
         mqcnM0q4K+bg4d1ap+c42zsykBJkxsxumgVYwoxvK2JwMY91g7rYCzZdgbDMLdhkTQ
         +lYuAXaRWYOjZJ8gy6b2fnfPOO69Ei2YrhIQ8BC4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sgruszka@redhat.com
Subject: [PATCH] mt76: move interface_modes definition in mt76_core module
Date:   Thu, 31 Oct 2019 11:03:12 +0100
Message-Id: <551855c98d4c09fff460e2e3c9239a0ac8ee82fc.1572516107.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move interface modes declaration in common code since now mt76
chipsets support all modes (NL80211_IFTYPE_STATION, NL80211_IFTYPE_AP,
NL80211_IFTYPE_MESH_POINT and NL80211_IFTYPE_ADHOC)

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c     | 7 +++++++
 drivers/net/wireless/mediatek/mt76/mt7603/init.c  | 9 ---------
 drivers/net/wireless/mediatek/mt76/mt7615/init.c  | 7 -------
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c | 8 --------
 4 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 17d04ebff996..2003223ff329 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -340,6 +340,13 @@ int mt76_register_device(struct mt76_dev *dev, bool vht,
 	ieee80211_hw_set(hw, SUPPORTS_REORDERING_BUFFER);
 
 	wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
+	wiphy->interface_modes =
+		BIT(NL80211_IFTYPE_STATION) |
+		BIT(NL80211_IFTYPE_AP) |
+#ifdef CONFIG_MAC80211_MESH
+		BIT(NL80211_IFTYPE_MESH_POINT) |
+#endif
+		BIT(NL80211_IFTYPE_ADHOC);
 
 	if (dev->cap.has_2ghz) {
 		ret = mt76_init_sband_2g(dev, rates, n_rates);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 50c6a2828c18..0696dbf28c5b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -564,16 +564,7 @@ int mt7603_register_device(struct mt7603_dev *dev)
 		dev->mt76.led_cdev.blink_set = mt7603_led_set_blink;
 	}
 
-	wiphy->interface_modes =
-		BIT(NL80211_IFTYPE_STATION) |
-		BIT(NL80211_IFTYPE_AP) |
-#ifdef CONFIG_MAC80211_MESH
-		BIT(NL80211_IFTYPE_MESH_POINT) |
-#endif
-		BIT(NL80211_IFTYPE_ADHOC);
-
 	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
-
 	wiphy->reg_notifier = mt7603_regd_notifier;
 
 	ret = mt76_register_device(&dev->mt76, true, mt7603_rates,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 888ca8bbdef0..128a6ee1fa6d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -307,13 +307,6 @@ int mt7615_register_device(struct mt7615_dev *dev)
 	dev->mt76.antenna_mask = 0xf;
 	dev->dfs_state = -1;
 
-	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
-				 BIT(NL80211_IFTYPE_ADHOC) |
-#ifdef CONFIG_MAC80211_MESH
-				 BIT(NL80211_IFTYPE_MESH_POINT) |
-#endif
-				 BIT(NL80211_IFTYPE_AP);
-
 	ret = mt76_register_device(&dev->mt76, true, mt7615_rates,
 				   ARRAY_SIZE(mt7615_rates));
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 2ce852caf247..c0500d8f9a67 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -153,14 +153,6 @@ void mt76x02_init_device(struct mt76x02_dev *dev)
 	hw->max_rate_tries = 1;
 	hw->extra_tx_headroom = 2;
 
-	wiphy->interface_modes =
-		BIT(NL80211_IFTYPE_STATION) |
-		BIT(NL80211_IFTYPE_AP) |
-#ifdef CONFIG_MAC80211_MESH
-		BIT(NL80211_IFTYPE_MESH_POINT) |
-#endif
-		BIT(NL80211_IFTYPE_ADHOC);
-
 	if (mt76_is_usb(&dev->mt76)) {
 		hw->extra_tx_headroom += sizeof(struct mt76x02_txwi) +
 					 MT_DMA_HDR_LEN;
-- 
2.21.0

