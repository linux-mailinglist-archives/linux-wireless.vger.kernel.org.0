Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB947409E1
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 09:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjF1Hwn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 03:52:43 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50272 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230243AbjF1Hwa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 03:52:30 -0400
X-UUID: 6919c31e158211eeb20a276fd37b9834-20230628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=DeQgSbBosCVxbtWkXy7lbbEYWGUH+uErbczFYNbw/9E=;
        b=X8fRS2ugthz1+YXuYj6tnWi73F3MciR8fYp+nSLXfpi25TLZUbDZ6Qge8AyrUJnHCJEONSip50xmyMURHFpIjwCS9uSt/Hl2Bezks4E24AQJl8FHoRXxwy4QpcNGZWzqJP5Cu4EHOC66iQusyt3HTBL40Ru4NoowIPopD+Ag92o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:301ab7f0-1584-429a-8274-f6d13aa567a7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:01c9525,CLOUDID:6c694f0d-26a8-467f-b838-f99719a9c083,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6919c31e158211eeb20a276fd37b9834-20230628
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 957918742; Wed, 28 Jun 2023 15:07:14 +0800
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
Subject: [PATCH 03/16] wifi: mt76: mt7921: rename mt7921_vif in mt792x_vif
Date:   Wed, 28 Jun 2023 15:05:49 +0800
Message-ID: <15e12caa926f39bf8e14d14e700e2b6aeb77731f.1687919628.git.deren.wu@mediatek.com>
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
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  4 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 52 +++++++++----------
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 20 +++----
 .../wireless/mediatek/mt76/mt7921/mt7921.h    | 12 ++---
 5 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 94b7cdfd018b..f2a6fd61863b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -141,7 +141,7 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	phy->slottime = 9;
 
 	hw->sta_data_size = sizeof(struct mt7921_sta);
-	hw->vif_data_size = sizeof(struct mt7921_vif);
+	hw->vif_data_size = sizeof(struct mt792x_vif);
 
 	if (dev->fw_features & MT7921_FW_CAP_CNM) {
 		wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 368f92719abf..44b0122073f8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -204,7 +204,7 @@ mt7921_mac_rssi_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
 	struct sk_buff *skb = priv;
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct ieee80211_hdr *hdr = mt76_skb_get_hdr(skb);
 
 	if (status->signal > 0)
@@ -819,7 +819,7 @@ static void
 mt7921_vif_connect_iter(void *priv, u8 *mac,
 			struct ieee80211_vif *vif)
 {
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt7921_dev *dev = mvif->phy->dev;
 	struct ieee80211_hw *hw = mt76_hw(dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 87067ac367eb..de8c3a02cf4b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -284,7 +284,7 @@ EXPORT_SYMBOL_GPL(mt7921_stop);
 static int mt7921_add_interface(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif)
 {
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 	struct mt7921_phy *phy = mt7921_hw_phy(hw);
 	struct mt76_txq *mtxq;
@@ -341,7 +341,7 @@ static int mt7921_add_interface(struct ieee80211_hw *hw,
 static void mt7921_remove_interface(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif)
 {
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt7921_sta *msta = &mvif->sta;
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 	struct mt7921_phy *phy = mt7921_hw_phy(hw);
@@ -368,7 +368,7 @@ static void mt7921_remove_interface(struct ieee80211_hw *hw,
 static void mt7921_roc_iter(void *priv, u8 *mac,
 			    struct ieee80211_vif *vif)
 {
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt7921_phy *phy = priv;
 
 	mt7921_mcu_abort_roc(phy, mvif, phy->roc_token_id);
@@ -399,7 +399,7 @@ void mt7921_roc_timer(struct timer_list *timer)
 	ieee80211_queue_work(phy->mt76->hw, &phy->roc_work);
 }
 
-static int mt7921_abort_roc(struct mt7921_phy *phy, struct mt7921_vif *vif)
+static int mt7921_abort_roc(struct mt7921_phy *phy, struct mt792x_vif *vif)
 {
 	int err = 0;
 
@@ -415,7 +415,7 @@ static int mt7921_abort_roc(struct mt7921_phy *phy, struct mt7921_vif *vif)
 }
 
 static int mt7921_set_roc(struct mt7921_phy *phy,
-			  struct mt7921_vif *vif,
+			  struct mt792x_vif *vif,
 			  struct ieee80211_channel *chan,
 			  int duration,
 			  enum mt7921_roc_req type)
@@ -450,7 +450,7 @@ static int mt7921_remain_on_channel(struct ieee80211_hw *hw,
 				    int duration,
 				    enum ieee80211_roc_type type)
 {
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt7921_phy *phy = mt7921_hw_phy(hw);
 	int err;
 
@@ -464,7 +464,7 @@ static int mt7921_remain_on_channel(struct ieee80211_hw *hw,
 static int mt7921_cancel_remain_on_channel(struct ieee80211_hw *hw,
 					   struct ieee80211_vif *vif)
 {
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt7921_phy *phy = mt7921_hw_phy(hw);
 
 	return mt7921_abort_roc(phy, mvif);
@@ -507,7 +507,7 @@ static int mt7921_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			  struct ieee80211_key_conf *key)
 {
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt7921_sta *msta = sta ? (struct mt7921_sta *)sta->drv_priv :
 				  &mvif->sta;
 	struct mt76_wcid *wcid = &msta->wcid;
@@ -667,7 +667,7 @@ mt7921_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	       unsigned int link_id, u16 queue,
 	       const struct ieee80211_tx_queue_params *params)
 {
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 
 	/* no need to update right away, we'll get BSS_CHANGED_QOS */
 	queue = mt76_connac_lmac_mapping(queue);
@@ -743,7 +743,7 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 	}
 
 	if (changed & BSS_CHANGED_ARP_FILTER) {
-		struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+		struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 
 		mt76_connac_mcu_update_arp_filter(&dev->mt76, &mvif->mt76,
 						  info);
@@ -757,7 +757,7 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 {
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
 	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	int ret, idx;
 
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7921_WTBL_STA - 1);
@@ -798,7 +798,7 @@ void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 {
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
 	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 
 	mt7921_mutex_acquire(dev);
 
@@ -832,7 +832,7 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
 	if (vif->type == NL80211_IFTYPE_STATION) {
-		struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+		struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 
 		mvif->wep_sta = NULL;
 		ewma_rssi_init(&mvif->rssi);
@@ -884,9 +884,9 @@ static void mt7921_tx(struct ieee80211_hw *hw,
 	}
 
 	if (vif && !control->sta) {
-		struct mt7921_vif *mvif;
+		struct mt792x_vif *mvif;
 
-		mvif = (struct mt7921_vif *)vif->drv_priv;
+		mvif = (struct mt792x_vif *)vif->drv_priv;
 		wcid = &mvif->sta.wcid;
 	}
 
@@ -1133,7 +1133,7 @@ static
 void mt7921_get_et_stats(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			 struct ethtool_stats *stats, u64 *data)
 {
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	int stats_size = ARRAY_SIZE(mt7921_gstrings_stats);
 	struct mt7921_phy *phy = mt7921_hw_phy(hw);
 	struct mt7921_dev *dev = phy->dev;
@@ -1203,7 +1203,7 @@ void mt7921_get_et_stats(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 static u64
 mt7921_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 {
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 	u8 omac_idx = mvif->mt76.omac_idx;
 	union {
@@ -1229,7 +1229,7 @@ static void
 mt7921_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	       u64 timestamp)
 {
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 	u8 omac_idx = mvif->mt76.omac_idx;
 	union {
@@ -1521,7 +1521,7 @@ static void mt7921_ipv6_addr_change(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
 				    struct inet6_dev *idev)
 {
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt7921_dev *dev = mvif->phy->dev;
 	struct inet6_ifaddr *ifa;
 	struct in6_addr ns_addrs[IEEE80211_BSS_ARP_ADDR_LIST_LEN];
@@ -1630,7 +1630,7 @@ static int
 mt7921_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		struct ieee80211_bss_conf *link_conf)
 {
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt7921_phy *phy = mt7921_hw_phy(hw);
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 	int err;
@@ -1658,7 +1658,7 @@ static void
 mt7921_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	       struct ieee80211_bss_conf *link_conf)
 {
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt7921_phy *phy = mt7921_hw_phy(hw);
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 	int err;
@@ -1692,7 +1692,7 @@ mt7921_remove_chanctx(struct ieee80211_hw *hw,
 static void mt7921_ctx_iter(void *priv, u8 *mac,
 			    struct ieee80211_vif *vif)
 {
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct ieee80211_chanctx_conf *ctx = priv;
 
 	if (ctx != mvif->ctx)
@@ -1724,7 +1724,7 @@ mt7921_assign_vif_chanctx(struct ieee80211_hw *hw,
 			  struct ieee80211_bss_conf *link_conf,
 			  struct ieee80211_chanctx_conf *ctx)
 {
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 
 	mutex_lock(&dev->mt76.mutex);
@@ -1740,7 +1740,7 @@ mt7921_unassign_vif_chanctx(struct ieee80211_hw *hw,
 			    struct ieee80211_bss_conf *link_conf,
 			    struct ieee80211_chanctx_conf *ctx)
 {
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 
 	mutex_lock(&dev->mt76.mutex);
@@ -1752,7 +1752,7 @@ static void mt7921_mgd_prepare_tx(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_prep_tx_info *info)
 {
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 	u16 duration = info->duration ? info->duration :
 		       jiffies_to_msecs(HZ);
@@ -1767,7 +1767,7 @@ static void mt7921_mgd_complete_tx(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_prep_tx_info *info)
 {
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 
 	mt7921_abort_roc(mvif->phy, mvif);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index a0ad18c70b1a..4d8b4c802739 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -96,7 +96,7 @@ static int
 mt7921_mcu_set_ipv6_ns_filter(struct mt76_dev *dev,
 			      struct ieee80211_vif *vif, bool suspend)
 {
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct {
 		struct {
 			u8 bss_idx;
@@ -543,7 +543,7 @@ EXPORT_SYMBOL_GPL(mt7921_run_firmware);
 
 int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif)
 {
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct edca {
 		__le16 cw_min;
 		__le16 cw_max;
@@ -635,7 +635,7 @@ int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif)
 				 &req_mu, sizeof(req_mu), false);
 }
 
-int mt7921_mcu_set_roc(struct mt7921_phy *phy, struct mt7921_vif *vif,
+int mt7921_mcu_set_roc(struct mt7921_phy *phy, struct mt792x_vif *vif,
 		       struct ieee80211_channel *chan, int duration,
 		       enum mt7921_roc_req type, u8 token_id)
 {
@@ -702,7 +702,7 @@ int mt7921_mcu_set_roc(struct mt7921_phy *phy, struct mt7921_vif *vif,
 				 &req, sizeof(req), false);
 }
 
-int mt7921_mcu_abort_roc(struct mt7921_phy *phy, struct mt7921_vif *vif,
+int mt7921_mcu_abort_roc(struct mt7921_phy *phy, struct mt792x_vif *vif,
 			 u8 token_id)
 {
 	struct mt7921_dev *dev = phy->dev;
@@ -809,7 +809,7 @@ EXPORT_SYMBOL_GPL(mt7921_mcu_set_eeprom);
 
 int mt7921_mcu_uni_bss_ps(struct mt7921_dev *dev, struct ieee80211_vif *vif)
 {
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct {
 		struct {
 			u8 bss_idx;
@@ -848,7 +848,7 @@ static int
 mt7921_mcu_uni_bss_bcnft(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 			 bool enable)
 {
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct {
 		struct {
 			u8 bss_idx;
@@ -884,7 +884,7 @@ int
 mt7921_mcu_set_bss_pm(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 		      bool enable)
 {
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct {
 		u8 bss_idx;
 		u8 dtim_period;
@@ -922,7 +922,7 @@ int mt7921_mcu_sta_update(struct mt7921_dev *dev, struct ieee80211_sta *sta,
 			  struct ieee80211_vif *vif, bool enable,
 			  enum mt76_sta_info_state state)
 {
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	int rssi = -ewma_rssi_read(&mvif->rssi);
 	struct mt76_sta_cmd_info info = {
 		.sta = sta,
@@ -1074,7 +1074,7 @@ int mt7921_mcu_set_sniffer(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 				 true);
 }
 
-int mt7921_mcu_config_sniffer(struct mt7921_vif *vif,
+int mt7921_mcu_config_sniffer(struct mt792x_vif *vif,
 			      struct ieee80211_chanctx_conf *ctx)
 {
 	struct cfg80211_chan_def *chandef = &ctx->def;
@@ -1148,7 +1148,7 @@ mt7921_mcu_uni_add_beacon_offload(struct mt7921_dev *dev,
 				  struct ieee80211_vif *vif,
 				  bool enable)
 {
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
 	struct ieee80211_mutable_offsets offs;
 	struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 2e29a6bda7ad..6ec5b19f3c25 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -127,7 +127,7 @@ struct mt7921_sdio_intr {
 #define to_rssi(field, rxv)		((FIELD_GET(field, rxv) - 220) / 2)
 #define to_rcpi(rssi)			(2 * (rssi) + 220)
 
-struct mt7921_vif;
+struct mt792x_vif;
 struct mt7921_sta;
 
 enum mt7921_txq_id {
@@ -148,7 +148,7 @@ DECLARE_EWMA(avg_signal, 10, 8)
 struct mt7921_sta {
 	struct mt76_wcid wcid; /* must be first */
 
-	struct mt7921_vif *vif;
+	struct mt792x_vif *vif;
 
 	u32 airtime_ac[8];
 
@@ -162,7 +162,7 @@ struct mt7921_sta {
 
 DECLARE_EWMA(rssi, 10, 8);
 
-struct mt7921_vif {
+struct mt792x_vif {
 	struct mt76_vif mt76; /* must be first */
 
 	struct mt7921_sta sta;
@@ -497,7 +497,7 @@ void mt7921_set_ipv6_ns_work(struct work_struct *work);
 
 int mt7921_mcu_set_sniffer(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 			   bool enable);
-int mt7921_mcu_config_sniffer(struct mt7921_vif *vif,
+int mt7921_mcu_config_sniffer(struct mt792x_vif *vif,
 			      struct ieee80211_chanctx_conf *ctx);
 int mt7921_mcu_get_temperature(struct mt7921_phy *phy);
 
@@ -550,10 +550,10 @@ int mt7921_set_tx_sar_pwr(struct ieee80211_hw *hw,
 
 int mt7921_mcu_set_clc(struct mt7921_dev *dev, u8 *alpha2,
 		       enum environment_cap env_cap);
-int mt7921_mcu_set_roc(struct mt7921_phy *phy, struct mt7921_vif *vif,
+int mt7921_mcu_set_roc(struct mt7921_phy *phy, struct mt792x_vif *vif,
 		       struct ieee80211_channel *chan, int duration,
 		       enum mt7921_roc_req type, u8 token_id);
-int mt7921_mcu_abort_roc(struct mt7921_phy *phy, struct mt7921_vif *vif,
+int mt7921_mcu_abort_roc(struct mt7921_phy *phy, struct mt792x_vif *vif,
 			 u8 token_id);
 struct ieee80211_ops *mt7921_get_mac80211_ops(struct device *dev,
 					      void *drv_data, u8 *fw_features);
-- 
2.18.0

