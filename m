Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D9A7409DF
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 09:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjF1Hwk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 03:52:40 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50256 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230108AbjF1Hwa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 03:52:30 -0400
X-UUID: 691ac30e158211eeb20a276fd37b9834-20230628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rxM0nDOwUB4jnHLn5HVVvRYgSfpdsjGX+ltZIjUDYgQ=;
        b=qVUB1XcxqUfGQsz0PFCLimvWi4T93fDLXkugjU8tPB3+VxyYtDxa7fzVN9MgR4lLXSadixvT5G50d5iOkp/rCBBo0UHwpTnb/B7dGrmbWXBpM2dmquETPyEv8BwbTibaPpauKcULcHZsnmZ2enkPBudHWW3c0ajXn0RDlKBG1ac=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:8538afa3-df1e-42ca-9b28-954caf890c1e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:01c9525,CLOUDID:66d05eda-b4fa-43c8-9c3e-0d3fabd03ec0,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 691ac30e158211eeb20a276fd37b9834-20230628
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2078960267; Wed, 28 Jun 2023 15:07:14 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Jun 2023 15:07:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Jun 2023 15:07:14 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 05/16] wifi: mt76: mt7921: rename mt7921_phy in mt792x_phy
Date:   Wed, 28 Jun 2023 15:05:51 +0800
Message-ID: <81d8589e4873f0d3b24203b12ccbcfc3cc01aaab.1687919628.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1687919628.git.deren.wu@mediatek.com>
References: <cover.1687919628.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

This is a preliminary patch to introduce WiFi7 chipset support

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7921/acpi_sar.c  |  8 +--
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |  4 +-
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  6 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 14 ++---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 58 +++++++++----------
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 14 ++---
 .../wireless/mediatek/mt76/mt7921/mt7921.h    | 36 ++++++------
 .../wireless/mediatek/mt76/mt7921/testmode.c  |  4 +-
 8 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c b/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c
index 6feea2e515b3..06f2acdbfe1c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c
@@ -193,7 +193,7 @@ int mt7921_init_acpi_sar(struct mt7921_dev *dev)
 }
 
 static s8
-mt7921_asar_get_geo_pwr(struct mt7921_phy *phy,
+mt7921_asar_get_geo_pwr(struct mt792x_phy *phy,
 			enum nl80211_band band, s8 dyn_power)
 {
 	struct mt7921_acpi_sar *asar = phy->acpisar;
@@ -248,7 +248,7 @@ mt7921_asar_get_geo_pwr(struct mt7921_phy *phy,
 }
 
 static s8
-mt7921_asar_range_pwr(struct mt7921_phy *phy,
+mt7921_asar_range_pwr(struct mt792x_phy *phy,
 		      const struct cfg80211_sar_freq_ranges *range,
 		      u8 idx)
 {
@@ -280,7 +280,7 @@ mt7921_asar_range_pwr(struct mt7921_phy *phy,
 	return mt7921_asar_get_geo_pwr(phy, band, limit[idx]);
 }
 
-int mt7921_init_acpi_sar_power(struct mt7921_phy *phy, bool set_default)
+int mt7921_init_acpi_sar_power(struct mt792x_phy *phy, bool set_default)
 {
 	const struct cfg80211_sar_capa *capa = phy->mt76->hw->wiphy->sar_capa;
 	int i;
@@ -306,7 +306,7 @@ int mt7921_init_acpi_sar_power(struct mt7921_phy *phy, bool set_default)
 	return 0;
 }
 
-u8 mt7921_acpi_get_flags(struct mt7921_phy *phy)
+u8 mt7921_acpi_get_flags(struct mt792x_phy *phy)
 {
 	struct mt7921_acpi_sar *acpisar = phy->acpisar;
 	struct mt7921_asar_fg *fg;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index d6c66e775536..baa640e8a982 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -58,7 +58,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_fw_debug, mt7921_fw_debug_get,
 			 mt7921_fw_debug_set, "%lld\n");
 
 static void
-mt7921_ampdu_stat_read_phy(struct mt7921_phy *phy,
+mt7921_ampdu_stat_read_phy(struct mt792x_phy *phy,
 			   struct seq_file *file)
 {
 	struct mt7921_dev *dev = file->private;
@@ -94,7 +94,7 @@ static int
 mt7921_tx_stats_show(struct seq_file *file, void *data)
 {
 	struct mt7921_dev *dev = file->private;
-	struct mt7921_phy *phy = &dev->phy;
+	struct mt792x_phy *phy = &dev->phy;
 	struct mt76_mib_stats *mib = &phy->mib;
 	int i;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index df32f4f1b636..d383586eb429 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -60,7 +60,7 @@ static ssize_t mt7921_thermal_temp_show(struct device *dev,
 {
 	switch (to_sensor_dev_attr(attr)->index) {
 	case 0: {
-		struct mt7921_phy *phy = dev_get_drvdata(dev);
+		struct mt792x_phy *phy = dev_get_drvdata(dev);
 		struct mt7921_dev *mdev = phy->dev;
 		int temperature;
 
@@ -85,7 +85,7 @@ static struct attribute *mt7921_hwmon_attrs[] = {
 };
 ATTRIBUTE_GROUPS(mt7921_hwmon);
 
-static int mt7921_thermal_init(struct mt7921_phy *phy)
+static int mt7921_thermal_init(struct mt792x_phy *phy)
 {
 	struct wiphy *wiphy = phy->mt76->hw->wiphy;
 	struct device *hwmon;
@@ -126,7 +126,7 @@ mt7921_regd_notifier(struct wiphy *wiphy,
 static int
 mt7921_init_wiphy(struct ieee80211_hw *hw)
 {
-	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 	struct mt7921_dev *dev = phy->dev;
 	struct wiphy *wiphy = hw->wiphy;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index d4cf2ff18102..15c0e8be8f34 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -240,7 +240,7 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 	u16 hdr_gap;
 	__le32 *rxv = NULL, *rxd = (__le32 *)skb->data;
 	struct mt76_phy *mphy = &dev->mt76.phy;
-	struct mt7921_phy *phy = &dev->phy;
+	struct mt792x_phy *phy = &dev->phy;
 	struct ieee80211_supported_band *sband;
 	u32 csum_status = *(u32 *)skb->cb;
 	u32 rxd0 = le32_to_cpu(rxd[0]);
@@ -699,7 +699,7 @@ void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 }
 EXPORT_SYMBOL_GPL(mt7921_queue_rx_skb);
 
-void mt7921_mac_reset_counters(struct mt7921_phy *phy)
+void mt7921_mac_reset_counters(struct mt792x_phy *phy)
 {
 	struct mt7921_dev *dev = phy->dev;
 	int i;
@@ -721,7 +721,7 @@ void mt7921_mac_reset_counters(struct mt7921_phy *phy)
 	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0(0), MT_WF_RMAC_MIB_RXTIME_CLR);
 }
 
-void mt7921_mac_set_timing(struct mt7921_phy *phy)
+void mt7921_mac_set_timing(struct mt792x_phy *phy)
 {
 	s16 coverage_class = phy->coverage_class;
 	struct mt7921_dev *dev = phy->dev;
@@ -763,7 +763,7 @@ void mt7921_mac_set_timing(struct mt7921_phy *phy)
 }
 
 static u8
-mt7921_phy_get_nf(struct mt7921_phy *phy, int idx)
+mt7921_phy_get_nf(struct mt792x_phy *phy, int idx)
 {
 	return 0;
 }
@@ -772,7 +772,7 @@ static void
 mt7921_phy_update_channel(struct mt76_phy *mphy, int idx)
 {
 	struct mt7921_dev *dev = container_of(mphy->dev, struct mt7921_dev, mt76);
-	struct mt7921_phy *phy = (struct mt7921_phy *)mphy->priv;
+	struct mt792x_phy *phy = (struct mt792x_phy *)mphy->priv;
 	struct mt76_channel_state *state;
 	u64 busy_time, tx_time, rx_time, obss_time;
 	int nf;
@@ -902,7 +902,7 @@ void mt7921_reset(struct mt76_dev *mdev)
 }
 EXPORT_SYMBOL_GPL(mt7921_reset);
 
-void mt7921_mac_update_mib_stats(struct mt7921_phy *phy)
+void mt7921_mac_update_mib_stats(struct mt792x_phy *phy)
 {
 	struct mt76_mib_stats *mib = &phy->mib;
 	struct mt7921_dev *dev = phy->dev;
@@ -964,7 +964,7 @@ void mt7921_mac_update_mib_stats(struct mt7921_phy *phy)
 
 void mt7921_mac_work(struct work_struct *work)
 {
-	struct mt7921_phy *phy;
+	struct mt792x_phy *phy;
 	struct mt76_phy *mphy;
 
 	mphy = (struct mt76_phy *)container_of(work, struct mt76_phy,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index bd449423e5b3..fc9a306344cd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -10,7 +10,7 @@
 #include "mcu.h"
 
 static int
-mt7921_init_he_caps(struct mt7921_phy *phy, enum nl80211_band band,
+mt7921_init_he_caps(struct mt792x_phy *phy, enum nl80211_band band,
 		    struct ieee80211_sband_iftype_data *data)
 {
 	int i, idx = 0;
@@ -185,7 +185,7 @@ mt7921_init_he_caps(struct mt7921_phy *phy, enum nl80211_band band,
 	return idx;
 }
 
-void mt7921_set_stream_he_caps(struct mt7921_phy *phy)
+void mt7921_set_stream_he_caps(struct mt792x_phy *phy)
 {
 	struct ieee80211_sband_iftype_data *data;
 	struct ieee80211_supported_band *band;
@@ -219,7 +219,7 @@ void mt7921_set_stream_he_caps(struct mt7921_phy *phy)
 	}
 }
 
-int __mt7921_start(struct mt7921_phy *phy)
+int __mt7921_start(struct mt792x_phy *phy)
 {
 	struct mt76_phy *mphy = phy->mt76;
 	int err;
@@ -252,7 +252,7 @@ EXPORT_SYMBOL_GPL(__mt7921_start);
 
 static int mt7921_start(struct ieee80211_hw *hw)
 {
-	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 	int err;
 
 	mt7921_mutex_acquire(phy->dev);
@@ -265,7 +265,7 @@ static int mt7921_start(struct ieee80211_hw *hw)
 void mt7921_stop(struct ieee80211_hw *hw)
 {
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
-	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 
 	cancel_delayed_work_sync(&phy->mt76->mac_work);
 
@@ -286,7 +286,7 @@ static int mt7921_add_interface(struct ieee80211_hw *hw,
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
-	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 	struct mt76_txq *mtxq;
 	int idx, ret = 0;
 
@@ -344,7 +344,7 @@ static void mt7921_remove_interface(struct ieee80211_hw *hw,
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_sta *msta = &mvif->sta;
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
-	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 	int idx = msta->wcid.idx;
 
 	mt7921_mutex_acquire(dev);
@@ -369,16 +369,16 @@ static void mt7921_roc_iter(void *priv, u8 *mac,
 			    struct ieee80211_vif *vif)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt7921_phy *phy = priv;
+	struct mt792x_phy *phy = priv;
 
 	mt7921_mcu_abort_roc(phy, mvif, phy->roc_token_id);
 }
 
 void mt7921_roc_work(struct work_struct *work)
 {
-	struct mt7921_phy *phy;
+	struct mt792x_phy *phy;
 
-	phy = (struct mt7921_phy *)container_of(work, struct mt7921_phy,
+	phy = (struct mt792x_phy *)container_of(work, struct mt792x_phy,
 						roc_work);
 
 	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
@@ -394,12 +394,12 @@ void mt7921_roc_work(struct work_struct *work)
 
 void mt7921_roc_timer(struct timer_list *timer)
 {
-	struct mt7921_phy *phy = from_timer(phy, timer, roc_timer);
+	struct mt792x_phy *phy = from_timer(phy, timer, roc_timer);
 
 	ieee80211_queue_work(phy->mt76->hw, &phy->roc_work);
 }
 
-static int mt7921_abort_roc(struct mt7921_phy *phy, struct mt792x_vif *vif)
+static int mt7921_abort_roc(struct mt792x_phy *phy, struct mt792x_vif *vif)
 {
 	int err = 0;
 
@@ -414,7 +414,7 @@ static int mt7921_abort_roc(struct mt7921_phy *phy, struct mt792x_vif *vif)
 	return err;
 }
 
-static int mt7921_set_roc(struct mt7921_phy *phy,
+static int mt7921_set_roc(struct mt792x_phy *phy,
 			  struct mt792x_vif *vif,
 			  struct ieee80211_channel *chan,
 			  int duration,
@@ -451,7 +451,7 @@ static int mt7921_remain_on_channel(struct ieee80211_hw *hw,
 				    enum ieee80211_roc_type type)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 	int err;
 
 	mt7921_mutex_acquire(phy->dev);
@@ -465,12 +465,12 @@ static int mt7921_cancel_remain_on_channel(struct ieee80211_hw *hw,
 					   struct ieee80211_vif *vif)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 
 	return mt7921_abort_roc(phy, mvif);
 }
 
-static int mt7921_set_channel(struct mt7921_phy *phy)
+static int mt7921_set_channel(struct mt792x_phy *phy)
 {
 	struct mt7921_dev *dev = phy->dev;
 	int ret;
@@ -631,7 +631,7 @@ void mt7921_set_runtime_pm(struct mt7921_dev *dev)
 static int mt7921_config(struct ieee80211_hw *hw, u32 changed)
 {
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
-	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 	int ret = 0;
 
 	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
@@ -710,7 +710,7 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 				    struct ieee80211_bss_conf *info,
 				    u64 changed)
 {
-	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 
 	mt7921_mutex_acquire(dev);
@@ -994,7 +994,7 @@ static int
 mt7921_get_stats(struct ieee80211_hw *hw,
 		 struct ieee80211_low_level_stats *stats)
 {
-	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 	struct mt76_mib_stats *mib = &phy->mib;
 
 	mt7921_mutex_acquire(phy->dev);
@@ -1135,7 +1135,7 @@ void mt7921_get_et_stats(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	int stats_size = ARRAY_SIZE(mt7921_gstrings_stats);
-	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 	struct mt7921_dev *dev = phy->dev;
 	struct mt76_mib_stats *mib = &phy->mib;
 	struct mt76_ethtool_worker_info wi = {
@@ -1252,7 +1252,7 @@ mt7921_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 static void
 mt7921_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
 {
-	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 	struct mt7921_dev *dev = phy->dev;
 
 	mt7921_mutex_acquire(dev);
@@ -1263,9 +1263,9 @@ mt7921_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
 
 void mt7921_scan_work(struct work_struct *work)
 {
-	struct mt7921_phy *phy;
+	struct mt792x_phy *phy;
 
-	phy = (struct mt7921_phy *)container_of(work, struct mt7921_phy,
+	phy = (struct mt792x_phy *)container_of(work, struct mt792x_phy,
 						scan_work.work);
 
 	while (true) {
@@ -1360,7 +1360,7 @@ static int
 mt7921_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 {
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
-	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 	int max_nss = hweight8(hw->wiphy->available_antennas_tx);
 
 	if (!tx_ant || tx_ant != rx_ant || ffs(tx_ant) > max_nss)
@@ -1424,7 +1424,7 @@ static int mt7921_suspend(struct ieee80211_hw *hw,
 			  struct cfg80211_wowlan *wowlan)
 {
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
-	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 
 	cancel_delayed_work_sync(&phy->scan_work);
 	cancel_delayed_work_sync(&phy->mt76->mac_work);
@@ -1448,7 +1448,7 @@ static int mt7921_suspend(struct ieee80211_hw *hw,
 static int mt7921_resume(struct ieee80211_hw *hw)
 {
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
-	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 
 	mt7921_mutex_acquire(dev);
 
@@ -1631,7 +1631,7 @@ mt7921_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		struct ieee80211_bss_conf *link_conf)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 	int err;
 
@@ -1659,7 +1659,7 @@ mt7921_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	       struct ieee80211_bss_conf *link_conf)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 	int err;
 
@@ -1709,7 +1709,7 @@ mt7921_change_chanctx(struct ieee80211_hw *hw,
 		      struct ieee80211_chanctx_conf *ctx,
 		      u32 changed)
 {
-	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 
 	mt7921_mutex_acquire(phy->dev);
 	ieee80211_iterate_active_interfaces(phy->mt76->hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 1d1e8ee5bd3d..06fecc9dc220 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -160,7 +160,7 @@ static void
 mt7921_mcu_scan_event(struct mt7921_dev *dev, struct sk_buff *skb)
 {
 	struct mt76_phy *mphy = &dev->mt76.phy;
-	struct mt7921_phy *phy = (struct mt7921_phy *)mphy->priv;
+	struct mt792x_phy *phy = (struct mt792x_phy *)mphy->priv;
 
 	spin_lock_bh(&dev->mt76.lock);
 	__skb_queue_tail(&phy->scan_event_list, skb);
@@ -394,7 +394,7 @@ static int mt7921_load_clc(struct mt7921_dev *dev, const char *fw_name)
 	const struct mt76_connac2_fw_region *region;
 	const struct mt7921_clc *clc;
 	struct mt76_dev *mdev = &dev->mt76;
-	struct mt7921_phy *phy = &dev->phy;
+	struct mt792x_phy *phy = &dev->phy;
 	const struct firmware *fw;
 	int ret, i, len, offset = 0;
 	u8 *clc_base = NULL, hw_encap = 0;
@@ -635,7 +635,7 @@ int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif)
 				 &req_mu, sizeof(req_mu), false);
 }
 
-int mt7921_mcu_set_roc(struct mt7921_phy *phy, struct mt792x_vif *vif,
+int mt7921_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
 		       struct ieee80211_channel *chan, int duration,
 		       enum mt7921_roc_req type, u8 token_id)
 {
@@ -702,7 +702,7 @@ int mt7921_mcu_set_roc(struct mt7921_phy *phy, struct mt792x_vif *vif,
 				 &req, sizeof(req), false);
 }
 
-int mt7921_mcu_abort_roc(struct mt7921_phy *phy, struct mt792x_vif *vif,
+int mt7921_mcu_abort_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
 			 u8 token_id)
 {
 	struct mt7921_dev *dev = phy->dev;
@@ -732,7 +732,7 @@ int mt7921_mcu_abort_roc(struct mt7921_phy *phy, struct mt792x_vif *vif,
 				 &req, sizeof(req), false);
 }
 
-int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd)
+int mt7921_mcu_set_chan_info(struct mt792x_phy *phy, int cmd)
 {
 	struct mt7921_dev *dev = phy->dev;
 	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
@@ -1286,7 +1286,7 @@ int __mt7921_mcu_set_clc(struct mt7921_dev *dev, u8 *alpha2,
 int mt7921_mcu_set_clc(struct mt7921_dev *dev, u8 *alpha2,
 		       enum environment_cap env_cap)
 {
-	struct mt7921_phy *phy = (struct mt7921_phy *)&dev->phy;
+	struct mt792x_phy *phy = (struct mt792x_phy *)&dev->phy;
 	int i, ret;
 
 	/* submit all clc config */
@@ -1305,7 +1305,7 @@ int mt7921_mcu_set_clc(struct mt7921_dev *dev, u8 *alpha2,
 	return 0;
 }
 
-int mt7921_mcu_get_temperature(struct mt7921_phy *phy)
+int mt7921_mcu_get_temperature(struct mt792x_phy *phy)
 {
 	struct mt7921_dev *dev = phy->dev;
 	struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 4d409ba3fc21..d9550b0aba61 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -168,7 +168,7 @@ struct mt792x_vif {
 	struct mt792x_sta sta;
 	struct mt792x_sta *wep_sta;
 
-	struct mt7921_phy *phy;
+	struct mt792x_phy *phy;
 
 	struct ewma_rssi rssi;
 
@@ -199,7 +199,7 @@ struct mt7921_clc {
 	u8 data[];
 } __packed;
 
-struct mt7921_phy {
+struct mt792x_phy {
 	struct mt76_phy *mt76;
 	struct mt7921_dev *dev;
 
@@ -264,7 +264,7 @@ struct mt7921_dev {
 	};
 
 	const struct mt76_bus_ops *bus_ops;
-	struct mt7921_phy phy;
+	struct mt792x_phy phy;
 
 	struct work_struct reset_work;
 	bool hw_full_reset:1;
@@ -317,7 +317,7 @@ struct mt7921_txpwr {
 	} data[TXPWR_MAX_NUM];
 };
 
-static inline struct mt7921_phy *
+static inline struct mt792x_phy *
 mt7921_hw_phy(struct ieee80211_hw *hw)
 {
 	struct mt76_phy *phy = hw->priv;
@@ -342,7 +342,7 @@ extern const struct ieee80211_ops mt7921_ops;
 
 u32 mt7921_reg_map(struct mt7921_dev *dev, u32 addr);
 
-int __mt7921_start(struct mt7921_phy *phy);
+int __mt7921_start(struct mt792x_phy *phy);
 int mt7921_register_device(struct mt7921_dev *dev);
 void mt7921_unregister_device(struct mt7921_dev *dev);
 int mt7921_dma_init(struct mt7921_dev *dev);
@@ -355,10 +355,10 @@ int mt7921_mcu_set_bss_pm(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 int mt7921_mcu_sta_update(struct mt7921_dev *dev, struct ieee80211_sta *sta,
 			  struct ieee80211_vif *vif, bool enable,
 			  enum mt76_sta_info_state state);
-int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd);
+int mt7921_mcu_set_chan_info(struct mt792x_phy *phy, int cmd);
 int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif);
 int mt7921_mcu_set_eeprom(struct mt7921_dev *dev);
-int mt7921_mcu_get_rx_rate(struct mt7921_phy *phy, struct ieee80211_vif *vif,
+int mt7921_mcu_get_rx_rate(struct mt792x_phy *phy, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta, struct rate_info *rate);
 int mt7921_mcu_fw_log_2_host(struct mt7921_dev *dev, u8 ctrl);
 void mt7921_mcu_rx_event(struct mt7921_dev *dev, struct sk_buff *skb);
@@ -423,8 +423,8 @@ mt7921_skb_add_usb_sdio_hdr(struct mt7921_dev *dev, struct sk_buff *skb,
 void mt7921_stop(struct ieee80211_hw *hw);
 int mt7921_mac_init(struct mt7921_dev *dev);
 bool mt7921_mac_wtbl_update(struct mt7921_dev *dev, int idx, u32 mask);
-void mt7921_mac_reset_counters(struct mt7921_phy *phy);
-void mt7921_mac_set_timing(struct mt7921_phy *phy);
+void mt7921_mac_reset_counters(struct mt792x_phy *phy);
+void mt7921_mac_set_timing(struct mt792x_phy *phy);
 int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
 void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
@@ -433,7 +433,7 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta);
 void mt7921_mac_work(struct work_struct *work);
 void mt7921_mac_reset_work(struct work_struct *work);
-void mt7921_mac_update_mib_stats(struct mt7921_phy *phy);
+void mt7921_mac_update_mib_stats(struct mt792x_phy *phy);
 void mt7921_reset(struct mt76_dev *mdev);
 int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			   enum mt76_txq_id qid, struct mt76_wcid *wcid,
@@ -445,7 +445,7 @@ bool mt7921_rx_check(struct mt76_dev *mdev, void *data, int len);
 void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb, u32 *info);
 void mt7921_stats_work(struct work_struct *work);
-void mt7921_set_stream_he_caps(struct mt7921_phy *phy);
+void mt7921_set_stream_he_caps(struct mt792x_phy *phy);
 void mt7921_update_channel(struct mt76_phy *mphy);
 int mt7921_init_debugfs(struct mt7921_dev *dev);
 
@@ -499,7 +499,7 @@ int mt7921_mcu_set_sniffer(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 			   bool enable);
 int mt7921_mcu_config_sniffer(struct mt792x_vif *vif,
 			      struct ieee80211_chanctx_conf *ctx);
-int mt7921_mcu_get_temperature(struct mt7921_phy *phy);
+int mt7921_mcu_get_temperature(struct mt792x_phy *phy);
 
 int mt7921_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 				   enum mt76_txq_id qid, struct mt76_wcid *wcid,
@@ -524,8 +524,8 @@ int mt7921_mcu_uni_add_beacon_offload(struct mt7921_dev *dev,
 				      bool enable);
 #ifdef CONFIG_ACPI
 int mt7921_init_acpi_sar(struct mt7921_dev *dev);
-int mt7921_init_acpi_sar_power(struct mt7921_phy *phy, bool set_default);
-u8 mt7921_acpi_get_flags(struct mt7921_phy *phy);
+int mt7921_init_acpi_sar_power(struct mt792x_phy *phy, bool set_default);
+u8 mt7921_acpi_get_flags(struct mt792x_phy *phy);
 #else
 static inline int
 mt7921_init_acpi_sar(struct mt7921_dev *dev)
@@ -534,13 +534,13 @@ mt7921_init_acpi_sar(struct mt7921_dev *dev)
 }
 
 static inline int
-mt7921_init_acpi_sar_power(struct mt7921_phy *phy, bool set_default)
+mt7921_init_acpi_sar_power(struct mt792x_phy *phy, bool set_default)
 {
 	return 0;
 }
 
 static inline u8
-mt7921_acpi_get_flags(struct mt7921_phy *phy)
+mt7921_acpi_get_flags(struct mt792x_phy *phy)
 {
 	return 0;
 }
@@ -550,10 +550,10 @@ int mt7921_set_tx_sar_pwr(struct ieee80211_hw *hw,
 
 int mt7921_mcu_set_clc(struct mt7921_dev *dev, u8 *alpha2,
 		       enum environment_cap env_cap);
-int mt7921_mcu_set_roc(struct mt7921_phy *phy, struct mt792x_vif *vif,
+int mt7921_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
 		       struct ieee80211_channel *chan, int duration,
 		       enum mt7921_roc_req type, u8 token_id);
-int mt7921_mcu_abort_roc(struct mt7921_phy *phy, struct mt792x_vif *vif,
+int mt7921_mcu_abort_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
 			 u8 token_id);
 struct ieee80211_ops *mt7921_get_mac80211_ops(struct device *dev,
 					      void *drv_data, u8 *fw_features);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
index 7f408212e716..208dcb2afbe7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
@@ -113,7 +113,7 @@ int mt7921_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 {
 	struct nlattr *tb[NUM_MT76_TM_ATTRS];
 	struct mt76_phy *mphy = hw->priv;
-	struct mt7921_phy *phy = mphy->priv;
+	struct mt792x_phy *phy = mphy->priv;
 	int err;
 
 	if (!test_bit(MT76_STATE_RUNNING, &mphy->state) ||
@@ -150,7 +150,7 @@ int mt7921_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *msg,
 {
 	struct nlattr *tb[NUM_MT76_TM_ATTRS];
 	struct mt76_phy *mphy = hw->priv;
-	struct mt7921_phy *phy = mphy->priv;
+	struct mt792x_phy *phy = mphy->priv;
 	int err;
 
 	if (!test_bit(MT76_STATE_RUNNING, &mphy->state) ||
-- 
2.18.0

