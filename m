Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65866155C50
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2020 18:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgBGRAG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Feb 2020 12:00:06 -0500
Received: from nbd.name ([46.4.11.11]:58240 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbgBGRAG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Feb 2020 12:00:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2fwu0xkJqTasgUQNnYfUESPsnqd3TiBv4Tv1YOs0RZ4=; b=KabN7sPuSXFD5lk7/GeTSyuOUd
        OkygQlkvMzL745tRPB/BXlZcXLdrO3FQPGTveWYpQHDazFkc+wPNjKSLPh3MnYPaJ7ET/boX2bjw5
        gWnJIz1lj4F56/meyaAPtbBZsOkJvLAJEICoA4+OzsNOQm6a3R2Kx9fQLrf9gwuJp38o=;
Received: from [80.255.10.202] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1j06z6-0000Wh-CA
        for linux-wireless@vger.kernel.org; Fri, 07 Feb 2020 18:00:04 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 7DE647B99ACD; Fri,  7 Feb 2020 18:00:03 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] mt76: avoid extra RCU synchronization on station removal
Date:   Fri,  7 Feb 2020 18:00:02 +0100
Message-Id: <20200207170003.35765-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use sta_pre_rcu_remove callback to clear wcid pointer earlier

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c    | 16 +++++++++++++---
 drivers/net/wireless/mediatek/mt76/mt76.h        |  2 ++
 drivers/net/wireless/mediatek/mt76/mt7603/main.c |  1 +
 drivers/net/wireless/mediatek/mt76/mt7615/main.c |  1 +
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c  |  1 +
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c  |  1 +
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c    |  2 ++
 .../net/wireless/mediatek/mt76/mt76x2/pci_main.c |  1 +
 .../net/wireless/mediatek/mt76/mt76x2/usb_main.c |  1 +
 9 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 2a85e0cb5793..545fa729117f 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -983,9 +983,6 @@ void __mt76_sta_remove(struct mt76_dev *dev, struct ieee80211_vif *vif,
 	struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
 	int i, idx = wcid->idx;
 
-	rcu_assign_pointer(dev->wcid[idx], NULL);
-	synchronize_rcu();
-
 	for (i = 0; i < ARRAY_SIZE(wcid->aggr); i++)
 		mt76_rx_aggr_stop(dev, wcid, i);
 
@@ -1035,6 +1032,19 @@ int mt76_sta_state(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(mt76_sta_state);
 
+void mt76_sta_pre_rcu_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			     struct ieee80211_sta *sta)
+{
+	struct mt76_phy *phy = hw->priv;
+	struct mt76_dev *dev = phy->dev;
+	struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
+
+	mutex_lock(&dev->mutex);
+	rcu_assign_pointer(dev->wcid[wcid->idx], NULL);
+	mutex_unlock(&dev->mutex);
+}
+EXPORT_SYMBOL_GPL(mt76_sta_pre_rcu_remove);
+
 int mt76_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		     int *dbm)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 0956785ad6f8..bf0b0c027939 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -806,6 +806,8 @@ int mt76_sta_state(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		   enum ieee80211_sta_state new_state);
 void __mt76_sta_remove(struct mt76_dev *dev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
+void mt76_sta_pre_rcu_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			     struct ieee80211_sta *sta);
 
 int mt76_get_min_avg_rssi(struct mt76_dev *dev, bool ext_phy);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index e5776d936c0a..26cb711b465f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -680,6 +680,7 @@ const struct ieee80211_ops mt7603_ops = {
 	.configure_filter = mt7603_configure_filter,
 	.bss_info_changed = mt7603_bss_info_changed,
 	.sta_state = mt76_sta_state,
+	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
 	.set_key = mt7603_set_key,
 	.conf_tx = mt7603_conf_tx,
 	.sw_scan_start = mt76_sw_scan,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 7f9aa84388fd..8e5a955190b8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -710,6 +710,7 @@ const struct ieee80211_ops mt7615_ops = {
 	.bss_info_changed = mt7615_bss_info_changed,
 	.sta_add = mt7615_sta_add,
 	.sta_remove = mt7615_sta_remove,
+	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
 	.set_key = mt7615_set_key,
 	.ampdu_action = mt7615_ampdu_action,
 	.set_rts_threshold = mt7615_set_rts_threshold,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
index 88ff51400f8f..0b520ae08d01 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
@@ -67,6 +67,7 @@ static const struct ieee80211_ops mt76x0e_ops = {
 	.configure_filter = mt76x02_configure_filter,
 	.bss_info_changed = mt76x02_bss_info_changed,
 	.sta_state = mt76_sta_state,
+	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
 	.set_key = mt76x02_set_key,
 	.conf_tx = mt76x02_conf_tx,
 	.sw_scan_start = mt76_sw_scan,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index 747d21b3ee57..5535b9c0632f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -126,6 +126,7 @@ static const struct ieee80211_ops mt76x0u_ops = {
 	.configure_filter = mt76x02_configure_filter,
 	.bss_info_changed = mt76x02_bss_info_changed,
 	.sta_state = mt76_sta_state,
+	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
 	.set_key = mt76x02_set_key,
 	.conf_tx = mt76x02_conf_tx,
 	.sw_scan_start = mt76_sw_scan,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 93d56d7ce5db..3d8bd61c5b43 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -427,6 +427,8 @@ static void mt76x02_reset_state(struct mt76x02_dev *dev)
 		if (!wcid)
 			continue;
 
+		rcu_assign_pointer(dev->mt76.wcid[i], NULL);
+
 		priv = msta = container_of(wcid, struct mt76x02_sta, wcid);
 		sta = container_of(priv, struct ieee80211_sta, drv_priv);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
index dd336f54b8ee..105e5b99b3f9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
@@ -145,6 +145,7 @@ const struct ieee80211_ops mt76x2_ops = {
 	.configure_filter = mt76x02_configure_filter,
 	.bss_info_changed = mt76x02_bss_info_changed,
 	.sta_state = mt76_sta_state,
+	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
 	.set_key = mt76x02_set_key,
 	.conf_tx = mt76x02_conf_tx,
 	.sw_scan_start = mt76_sw_scan,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
index 746f1a8304a6..bab4e6e1904e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
@@ -105,6 +105,7 @@ const struct ieee80211_ops mt76x2u_ops = {
 	.add_interface = mt76x02_add_interface,
 	.remove_interface = mt76x02_remove_interface,
 	.sta_state = mt76_sta_state,
+	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
 	.set_key = mt76x02_set_key,
 	.ampdu_action = mt76x02_ampdu_action,
 	.config = mt76x2u_config,
-- 
2.24.0

