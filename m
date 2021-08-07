Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D893E33FC
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Aug 2021 09:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhHGHkx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Aug 2021 03:40:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231490AbhHGHkw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Aug 2021 03:40:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFD8A610CB;
        Sat,  7 Aug 2021 07:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628322035;
        bh=53mGiYjCJgajosU+BkA+CzZJ+1b7FYN5XUfvUMzRow0=;
        h=From:To:Cc:Subject:Date:From;
        b=BqFFP+7vnGw8P4n0bc9/3j4FrW05aIitE+UWUuya0K425ptvTHqEFWLEWzfO3x9St
         LHci7A2M0qavgg1RJAl0EQssA3J3SldD4Irhd7iYYZf8MA6J8tORNugJQ6lKJCfozT
         HW+8hTJKlRXpdpTnj0KJA2+IkGBPvLtVvRNIDwo3wPgZMAfepNnpsrx25UMLMZ/Xd5
         vd971Vr3QVwj6QrwB3fW+YgwwcaxNMD1fg86EWG6AHp+QHpDNnTEvy/fcFgjGOc7d+
         +RiGoX8tseFEOPpmdR9VFhKkmr8V8PEt4fWVZK706fal/4ZixxBaUFbGBEmN0HBTGQ
         T0jd2s+WRZxcw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7615: move mt7615_mcu_set_p2p_oppps in mt76_connac module
Date:   Sat,  7 Aug 2021 09:40:30 +0200
Message-Id: <c2d278faf03f8d17d3c02710f4e07ce55215eb09.1628321941.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt7615_mcu_set_p2p_oppps routine in mt76_connac_lib module in order
to be reused in mt7921 driver

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  4 ++--
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 22 -------------------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 --
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 20 +++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  2 ++
 5 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index dada43d6d879..457e50255250 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -567,8 +567,8 @@ static void mt7615_bss_info_changed(struct ieee80211_hw *hw,
 		mt7615_mcu_add_bss_info(phy, vif, NULL, true);
 		mt7615_mcu_sta_add(phy, vif, NULL, true);
 
-		if (vif->p2p)
-			mt7615_mcu_set_p2p_oppps(hw, vif);
+		if (mt7615_firmware_offload(dev) && vif->p2p)
+			mt76_connac_mcu_set_p2p_oppps(hw, vif);
 	}
 
 	if (changed & (BSS_CHANGED_BEACON |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index f8a09692d3e4..a39776833efd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2762,28 +2762,6 @@ int mt7615_mcu_set_roc(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 				 sizeof(req), false);
 }
 
-int mt7615_mcu_set_p2p_oppps(struct ieee80211_hw *hw,
-			     struct ieee80211_vif *vif)
-{
-	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	int ct_window = vif->bss_conf.p2p_noa_attr.oppps_ctwindow;
-	struct mt7615_dev *dev = mt7615_hw_dev(hw);
-	struct {
-		__le32 ct_win;
-		u8 bss_idx;
-		u8 rsv[3];
-	} __packed req = {
-		.ct_win = cpu_to_le32(ct_window),
-		.bss_idx = mvif->mt76.idx,
-	};
-
-	if (!mt7615_firmware_offload(dev))
-		return -ENOTSUPP;
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_P2P_OPPPS, &req,
-				 sizeof(req), false);
-}
-
 u32 mt7615_mcu_reg_rr(struct mt76_dev *dev, u32 offset)
 {
 	struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index d0c64a9b09cf..58a98b5c0cbc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -541,8 +541,6 @@ int mt7615_mcu_apply_rx_dcoc(struct mt7615_phy *phy);
 int mt7615_mcu_apply_tx_dpd(struct mt7615_phy *phy);
 int mt7615_dfs_init_radar_detector(struct mt7615_phy *phy);
 
-int mt7615_mcu_set_p2p_oppps(struct ieee80211_hw *hw,
-			     struct ieee80211_vif *vif);
 int mt7615_mcu_set_roc(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		       struct ieee80211_channel *chan, int duration);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index a2555dc0f003..ce5985f6b515 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1930,6 +1930,26 @@ int mt76_connac_mcu_update_arp_filter(struct mt76_dev *dev,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_update_arp_filter);
 
+int mt76_connac_mcu_set_p2p_oppps(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	int ct_window = vif->bss_conf.p2p_noa_attr.oppps_ctwindow;
+	struct mt76_phy *phy = hw->priv;
+	struct {
+		__le32 ct_win;
+		u8 bss_idx;
+		u8 rsv[3];
+	} __packed req = {
+		.ct_win = cpu_to_le32(ct_window),
+		.bss_idx = mvif->idx,
+	};
+
+	return mt76_mcu_send_msg(phy->dev, MCU_CMD_SET_P2P_OPPPS, &req,
+				 sizeof(req), false);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_p2p_oppps);
+
 #ifdef CONFIG_PM
 
 const struct wiphy_wowlan_support mt76_connac_wowlan_support = {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index ab77289c0541..43787ab224b2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1094,4 +1094,6 @@ int mt76_connac_mcu_set_deep_sleep(struct mt76_dev *dev, bool enable);
 void mt76_connac_mcu_coredump_event(struct mt76_dev *dev, struct sk_buff *skb,
 				    struct mt76_connac_coredump *coredump);
 int mt76_connac_mcu_set_rate_txpower(struct mt76_phy *phy);
+int mt76_connac_mcu_set_p2p_oppps(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif);
 #endif /* __MT76_CONNAC_MCU_H */
-- 
2.31.1

