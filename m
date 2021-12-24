Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9ED347EE5C
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Dec 2021 11:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352496AbhLXK6e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Dec 2021 05:58:34 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51840 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343969AbhLXK6d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Dec 2021 05:58:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BAFD6202C
        for <linux-wireless@vger.kernel.org>; Fri, 24 Dec 2021 10:58:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1F3C36AEA;
        Fri, 24 Dec 2021 10:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640343512;
        bh=rR/HRd3dHOiBB0i7DsjwTYpuh7vNvLiluIqYcVFIZms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DiBPH4oIZwZH4hxo12Zlu2qeXdlGL127kimA4ms+ybOxIyUji7d0nTdVE30QvenMu
         k04yiSyeBROcIZYoKVb1PX7iMYoTBFmZlc93d+znCAXAC5BvTse9O48fa1rS7UhdlD
         2fGMlQGa5pqRS3IcW4ytC8xwRPXrtJfmZoI8aj4hge1PIJkBHh4ZHraYuEop9d8dm+
         NDho9q1fH30Ce853cBLZZ/aTqcehdN+EWim1SkS1ocWQqtmjhWKwhgIbOTvZJALS+Z
         sHUWVppDy4ulzMBfe9F83flfyBSx9vl0Bu6OF+K6Lyma6RM+xDTwGgUgukEJvkw9S+
         TEvPgkMK4fmbQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 02/10] mt76: connac: move mt76_connac_mcu_set_pm in connac module
Date:   Fri, 24 Dec 2021 11:58:03 +0100
Message-Id: <45836afa1bd86a9c57df6ff82ea664ebaa3aaf5b.1640342400.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640342400.git.lorenzo@kernel.org>
References: <cover.1640342400.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt76_connac_mcu_set_pm utility routine in connac module since it is
shared between mt7615 and mt7915 drivers.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 27 +---------------
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 32 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  8 ++---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 31 ------------------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  1 -
 6 files changed, 38 insertions(+), 62 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 31f40e5ead10..3b94e4f675ca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -756,32 +756,7 @@ mt7615_mcu_add_beacon_offload(struct mt7615_dev *dev,
 static int
 mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int band, int state)
 {
-#define ENTER_PM_STATE	1
-#define EXIT_PM_STATE	2
-	struct {
-		u8 pm_number;
-		u8 pm_state;
-		u8 bssid[ETH_ALEN];
-		u8 dtim_period;
-		u8 wlan_idx;
-		__le16 bcn_interval;
-		__le32 aid;
-		__le32 rx_filter;
-		u8 band_idx;
-		u8 rsv[3];
-		__le32 feature;
-		u8 omac_idx;
-		u8 wmm_idx;
-		u8 bcn_loss_cnt;
-		u8 bcn_sp_duration;
-	} __packed req = {
-		.pm_number = 5,
-		.pm_state = state ? ENTER_PM_STATE : EXIT_PM_STATE,
-		.band_idx = band,
-	};
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(PM_STATE_CTRL),
-				 &req, sizeof(req), true);
+	return mt76_connac_mcu_set_pm(&dev->mt76, band, state);
 }
 
 static int
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 142017457f72..6b714928d70a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2718,5 +2718,37 @@ int mt76_connac_mcu_bss_basic_tlv(struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_bss_basic_tlv);
 
+#define ENTER_PM_STATE		1
+#define EXIT_PM_STATE		2
+int mt76_connac_mcu_set_pm(struct mt76_dev *dev, int band, int enter)
+{
+	struct {
+		u8 pm_number;
+		u8 pm_state;
+		u8 bssid[ETH_ALEN];
+		u8 dtim_period;
+		u8 wlan_idx_lo;
+		__le16 bcn_interval;
+		__le32 aid;
+		__le32 rx_filter;
+		u8 band_idx;
+		u8 wlan_idx_hi;
+		u8 rsv[2];
+		__le32 feature;
+		u8 omac_idx;
+		u8 wmm_idx;
+		u8 bcn_loss_cnt;
+		u8 bcn_sp_duration;
+	} __packed req = {
+		.pm_number = 5,
+		.pm_state = enter ? ENTER_PM_STATE : EXIT_PM_STATE,
+		.band_idx = band,
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_EXT_CMD(PM_STATE_CTRL), &req,
+				 sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_pm);
+
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 0908d30552d4..285c6529474d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1609,4 +1609,5 @@ void mt76_connac_mcu_sta_uapsd(struct sk_buff *skb, struct ieee80211_vif *vif,
 void mt76_connac_mcu_wtbl_smps_tlv(struct sk_buff *skb,
 				   struct ieee80211_sta *sta,
 				   void *sta_wtbl, void *wtbl_tlv);
+int mt76_connac_mcu_set_pm(struct mt76_dev *dev, int band, int enter);
 #endif /* __MT76_CONNAC_MCU_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index a6553a8298c8..228bbc6e98c8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -34,7 +34,7 @@ static int mt7915_start(struct ieee80211_hw *hw)
 	running = mt7915_dev_running(dev);
 
 	if (!running) {
-		ret = mt7915_mcu_set_pm(dev, 0, 0);
+		ret = mt76_connac_mcu_set_pm(&dev->mt76, 0, 0);
 		if (ret)
 			goto out;
 
@@ -50,7 +50,7 @@ static int mt7915_start(struct ieee80211_hw *hw)
 	}
 
 	if (phy != &dev->phy) {
-		ret = mt7915_mcu_set_pm(dev, 1, 0);
+		ret = mt76_connac_mcu_set_pm(&dev->mt76, 1, 0);
 		if (ret)
 			goto out;
 
@@ -106,12 +106,12 @@ static void mt7915_stop(struct ieee80211_hw *hw)
 	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 
 	if (phy != &dev->phy) {
-		mt7915_mcu_set_pm(dev, 1, 1);
+		mt76_connac_mcu_set_pm(&dev->mt76, 1, 1);
 		mt7915_mcu_set_mac(dev, 1, false, false);
 	}
 
 	if (!mt7915_dev_running(dev)) {
-		mt7915_mcu_set_pm(dev, 0, 1);
+		mt76_connac_mcu_set_pm(&dev->mt76, 0, 1);
 		mt7915_mcu_set_mac(dev, 0, false, false);
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 06458384f62e..b8640422d475 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2651,37 +2651,6 @@ int mt7915_mcu_set_tx(struct mt7915_dev *dev, struct ieee80211_vif *vif)
 	return mt7915_mcu_update_edca(dev, &req);
 }
 
-int mt7915_mcu_set_pm(struct mt7915_dev *dev, int band, int enter)
-{
-#define ENTER_PM_STATE		1
-#define EXIT_PM_STATE		2
-	struct {
-		u8 pm_number;
-		u8 pm_state;
-		u8 bssid[ETH_ALEN];
-		u8 dtim_period;
-		u8 wlan_idx_lo;
-		__le16 bcn_interval;
-		__le32 aid;
-		__le32 rx_filter;
-		u8 band_idx;
-		u8 wlan_idx_hi;
-		u8 rsv[2];
-		__le32 feature;
-		u8 omac_idx;
-		u8 wmm_idx;
-		u8 bcn_loss_cnt;
-		u8 bcn_sp_duration;
-	} __packed req = {
-		.pm_number = 5,
-		.pm_state = (enter) ? ENTER_PM_STATE : EXIT_PM_STATE,
-		.band_idx = band,
-	};
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(PM_STATE_CTRL), &req,
-				 sizeof(req), true);
-}
-
 int mt7915_mcu_rdd_cmd(struct mt7915_dev *dev,
 		       enum mt7915_rdd_cmd cmd, u8 index,
 		       u8 rx_sel, u8 val)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 3be14a6a0604..9fb2810f9c33 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -441,7 +441,6 @@ int mt7915_mcu_set_test_param(struct mt7915_dev *dev, u8 param, bool test_mode,
 int mt7915_mcu_set_scs(struct mt7915_dev *dev, u8 band, bool enable);
 int mt7915_mcu_set_ser(struct mt7915_dev *dev, u8 action, u8 set, u8 band);
 int mt7915_mcu_set_rts_thresh(struct mt7915_phy *phy, u32 val);
-int mt7915_mcu_set_pm(struct mt7915_dev *dev, int band, int enter);
 int mt7915_mcu_set_sku_en(struct mt7915_phy *phy, bool enable);
 int mt7915_mcu_set_txpower_sku(struct mt7915_phy *phy);
 int mt7915_mcu_get_txpower_sku(struct mt7915_phy *phy, s8 *txpower, int len);
-- 
2.33.1

