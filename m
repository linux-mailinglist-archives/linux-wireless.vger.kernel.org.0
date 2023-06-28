Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60437409E2
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 09:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjF1Hwo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 03:52:44 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50356 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230378AbjF1Hwc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 03:52:32 -0400
X-UUID: 6a2cfeb0158211eeb20a276fd37b9834-20230628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=aiige29cQhVK8Tub9ovePbpVSwyD7YX9Lm59TJVPf0k=;
        b=AWG0AbBzhVqML4MGdeBwnGLCajL0KUL7wB0gH8A6Ah8y9vh2Q4IwFJbTp8S33za7VU7inZMOC65Vx1oPP6gkT+a0hDelk/LHim+VPnG7R3VdNlLbI9PEp4UZF7KW4Q4QLJB36GMJUn+UvWCIejLYMms6zpj4PdRcueKYZHeH8OM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:efc59053-3167-4808-8440-6b5318814f29,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:01c9525,CLOUDID:b67b9b0d-c22b-45ab-8a43-3004e9216b56,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6a2cfeb0158211eeb20a276fd37b9834-20230628
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2080584031; Wed, 28 Jun 2023 15:07:16 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Jun 2023 15:07:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Jun 2023 15:07:15 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 10/16] wifi: mt76: mt7921: move mt792x_hw_dev in mt792x.h
Date:   Wed, 28 Jun 2023 15:05:56 +0800
Message-ID: <5ce5a874d6e17a96949c8598de18a58949c05aa5.1687919628.git.deren.wu@mediatek.com>
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
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 66 +++++++++----------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  8 ---
 .../net/wireless/mediatek/mt76/mt7921/usb.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  8 +++
 5 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 100479c2e9f1..d78cdaaf5bb6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -110,7 +110,7 @@ mt7921_regd_notifier(struct wiphy *wiphy,
 		     struct regulatory_request *request)
 {
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
 	memcpy(dev->mt76.alpha2, request->alpha2, sizeof(dev->mt76.alpha2));
 	dev->mt76.region = request->dfs_region;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 2cd85fdd15f6..7213718ae399 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -264,7 +264,7 @@ static int mt7921_start(struct ieee80211_hw *hw)
 
 void mt7921_stop(struct ieee80211_hw *hw)
 {
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 
 	cancel_delayed_work_sync(&phy->mt76->mac_work);
@@ -285,7 +285,7 @@ static int mt7921_add_interface(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 	struct mt76_txq *mtxq;
 	int idx, ret = 0;
@@ -343,7 +343,7 @@ static void mt7921_remove_interface(struct ieee80211_hw *hw,
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_sta *msta = &mvif->sta;
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 	int idx = msta->wcid.idx;
 
@@ -506,7 +506,7 @@ static int mt7921_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			  struct ieee80211_vif *vif, struct ieee80211_sta *sta,
 			  struct ieee80211_key_conf *key)
 {
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_sta *msta = sta ? (struct mt792x_sta *)sta->drv_priv :
 				  &mvif->sta;
@@ -630,7 +630,7 @@ void mt7921_set_runtime_pm(struct mt792x_dev *dev)
 
 static int mt7921_config(struct ieee80211_hw *hw, u32 changed)
 {
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 	int ret = 0;
 
@@ -686,7 +686,7 @@ static void mt7921_configure_filter(struct ieee80211_hw *hw,
 #define MT7921_FILTER_OTHER_BSS  BIT(6)
 #define MT7921_FILTER_ENABLE     BIT(31)
 
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	u32 flags = MT7921_FILTER_ENABLE;
 
 #define MT7921_FILTER(_fif, _type) do {			\
@@ -711,7 +711,7 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 				    u64 changed)
 {
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
 	mt792x_mutex_acquire(dev);
 
@@ -869,7 +869,7 @@ static void mt7921_tx(struct ieee80211_hw *hw,
 		      struct ieee80211_tx_control *control,
 		      struct sk_buff *skb)
 {
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct mt76_phy *mphy = hw->priv;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = info->control.vif;
@@ -907,7 +907,7 @@ static void mt7921_tx(struct ieee80211_hw *hw,
 
 static int mt7921_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
 {
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
 	mt792x_mutex_acquire(dev);
 	mt76_connac_mcu_set_rts_thresh(&dev->mt76, val, 0);
@@ -921,7 +921,7 @@ mt7921_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		    struct ieee80211_ampdu_params *params)
 {
 	enum ieee80211_ampdu_mlme_action action = params->action;
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct ieee80211_sta *sta = params->sta;
 	struct ieee80211_txq *txq = sta->txq[params->tid];
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
@@ -979,7 +979,7 @@ static int mt7921_sta_state(struct ieee80211_hw *hw,
 			    enum ieee80211_sta_state old_state,
 			    enum ieee80211_sta_state new_state)
 {
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
 	if (dev->pm.ds_enable) {
 		mt792x_mutex_acquire(dev);
@@ -1087,7 +1087,7 @@ static void
 mt7921_get_et_strings(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		      u32 sset, u8 *data)
 {
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
 	if (sset != ETH_SS_STATS)
 		return;
@@ -1105,7 +1105,7 @@ static int
 mt7921_get_et_sset_count(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			 int sset)
 {
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
 	if (sset != ETH_SS_STATS)
 		return 0;
@@ -1204,7 +1204,7 @@ static u64
 mt7921_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	u8 omac_idx = mvif->mt76.omac_idx;
 	union {
 		u64 t64;
@@ -1230,7 +1230,7 @@ mt7921_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	       u64 timestamp)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	u8 omac_idx = mvif->mt76.omac_idx;
 	union {
 		u64 t64;
@@ -1298,7 +1298,7 @@ static int
 mt7921_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	       struct ieee80211_scan_request *req)
 {
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct mt76_phy *mphy = hw->priv;
 	int err;
 
@@ -1312,7 +1312,7 @@ mt7921_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 static void
 mt7921_cancel_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 {
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct mt76_phy *mphy = hw->priv;
 
 	mt792x_mutex_acquire(dev);
@@ -1325,7 +1325,7 @@ mt7921_start_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			struct cfg80211_sched_scan_request *req,
 			struct ieee80211_scan_ies *ies)
 {
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct mt76_phy *mphy = hw->priv;
 	int err;
 
@@ -1345,7 +1345,7 @@ mt7921_start_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 static int
 mt7921_stop_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 {
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct mt76_phy *mphy = hw->priv;
 	int err;
 
@@ -1359,7 +1359,7 @@ mt7921_stop_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 static int
 mt7921_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 {
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 	int max_nss = hweight8(hw->wiphy->available_antennas_tx);
 
@@ -1423,7 +1423,7 @@ static void mt7921_sta_statistics(struct ieee80211_hw *hw,
 static int mt7921_suspend(struct ieee80211_hw *hw,
 			  struct cfg80211_wowlan *wowlan)
 {
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 
 	cancel_delayed_work_sync(&phy->scan_work);
@@ -1447,7 +1447,7 @@ static int mt7921_suspend(struct ieee80211_hw *hw,
 
 static int mt7921_resume(struct ieee80211_hw *hw)
 {
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 
 	mt792x_mutex_acquire(dev);
@@ -1468,7 +1468,7 @@ static int mt7921_resume(struct ieee80211_hw *hw)
 
 static void mt7921_set_wakeup(struct ieee80211_hw *hw, bool enabled)
 {
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct mt76_dev *mdev = &dev->mt76;
 
 	device_set_wakeup_enable(mdev->dev, enabled);
@@ -1478,7 +1478,7 @@ static void mt7921_set_rekey_data(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif,
 				  struct cfg80211_gtk_rekey_data *data)
 {
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
 	mt792x_mutex_acquire(dev);
 	mt76_connac_mcu_update_gtk_rekey(hw, vif, data);
@@ -1489,7 +1489,7 @@ static void mt7921_set_rekey_data(struct ieee80211_hw *hw,
 static void mt7921_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			 u32 queues, bool drop)
 {
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
 	wait_event_timeout(dev->mt76.tx_wait, !mt76_has_tx_pending(&dev->mphy),
 			   HZ / 2);
@@ -1501,7 +1501,7 @@ static void mt7921_sta_set_decap_offload(struct ieee80211_hw *hw,
 					 bool enabled)
 {
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
 	mt792x_mutex_acquire(dev);
 
@@ -1598,7 +1598,7 @@ int mt7921_set_tx_sar_pwr(struct ieee80211_hw *hw,
 static int mt7921_set_sar_specs(struct ieee80211_hw *hw,
 				const struct cfg80211_sar_specs *sar)
 {
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	int err;
 
 	mt792x_mutex_acquire(dev);
@@ -1619,7 +1619,7 @@ mt7921_channel_switch_beacon(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif,
 			     struct cfg80211_chan_def *chandef)
 {
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
 	mt792x_mutex_acquire(dev);
 	mt7921_mcu_uni_add_beacon_offload(dev, hw, vif, true);
@@ -1632,7 +1632,7 @@ mt7921_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	int err;
 
 	mt792x_mutex_acquire(dev);
@@ -1660,7 +1660,7 @@ mt7921_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	int err;
 
 	mt792x_mutex_acquire(dev);
@@ -1725,7 +1725,7 @@ mt7921_assign_vif_chanctx(struct ieee80211_hw *hw,
 			  struct ieee80211_chanctx_conf *ctx)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
 	mutex_lock(&dev->mt76.mutex);
 	mvif->ctx = ctx;
@@ -1741,7 +1741,7 @@ mt7921_unassign_vif_chanctx(struct ieee80211_hw *hw,
 			    struct ieee80211_chanctx_conf *ctx)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
 	mutex_lock(&dev->mt76.mutex);
 	mvif->ctx = NULL;
@@ -1753,7 +1753,7 @@ static void mt7921_mgd_prepare_tx(struct ieee80211_hw *hw,
 				  struct ieee80211_prep_tx_info *info)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	u16 duration = info->duration ? info->duration :
 		       jiffies_to_msecs(HZ);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 2ca8560aa523..ad18fcc4a7b0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -216,14 +216,6 @@ mt7921_hw_phy(struct ieee80211_hw *hw)
 	return phy->priv;
 }
 
-static inline struct mt792x_dev *
-mt7921_hw_dev(struct ieee80211_hw *hw)
-{
-	struct mt76_phy *phy = hw->priv;
-
-	return container_of(phy->dev, struct mt792x_dev, mt76);
-}
-
 extern const struct ieee80211_ops mt7921_ops;
 
 u32 mt7921_reg_map(struct mt792x_dev *dev, u32 addr);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index b02a6d03c645..9d54be3d3d03 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -157,7 +157,7 @@ static int mt7921u_mcu_init(struct mt792x_dev *dev)
 
 static void mt7921u_stop(struct ieee80211_hw *hw)
 {
-	struct mt792x_dev *dev = mt7921_hw_dev(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
 	mt76u_stop_tx(&dev->mt76);
 	mt7921_stop(hw);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index bc7d11acfa6a..9c724bc156af 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -126,6 +126,14 @@ struct mt792x_dev {
 	u32 backup_l2;
 };
 
+static inline struct mt792x_dev *
+mt792x_hw_dev(struct ieee80211_hw *hw)
+{
+	struct mt76_phy *phy = hw->priv;
+
+	return container_of(phy->dev, struct mt792x_dev, mt76);
+}
+
 #define mt792x_mutex_acquire(dev)	\
 	mt76_connac_mutex_acquire(&(dev)->mt76, &(dev)->pm)
 #define mt792x_mutex_release(dev)	\
-- 
2.18.0

