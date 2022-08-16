Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41119595267
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Aug 2022 08:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiHPGPV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Aug 2022 02:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiHPGPF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Aug 2022 02:15:05 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CC579616
        for <linux-wireless@vger.kernel.org>; Mon, 15 Aug 2022 17:04:36 -0700 (PDT)
X-UUID: 447f2740d9c447769ae1c018b880c855-20220816
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kECh0wNU119oEV/LptBPxjwfbwW/P70bQy0YJwQ56ME=;
        b=gOkk6pjpLbwZ0u6qSlnDwrlZAvVbodOZGgNIs+v4sNNJj3lOX6QP1xh3trzKTHKTBIplR4aN3th760ggRSIVNEsn4zjCK56X8XFDxGRW4MK7AFunw7gBn0I+z1jcpc1NWRBBINkOnbbfZwazPmdi6vkh0HRd3AIaiup9rhrBmIE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:d5c2cc2d-db13-4aa3-bf34-6bdff699f851,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_H
        am,ACTION:release,TS:5
X-CID-META: VersionHash:3d8acc9,CLOUDID:b57ee4ae-9535-44a6-aa9b-7f62b79b6ff6,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:
        nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 447f2740d9c447769ae1c018b880c855-20220816
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1433546199; Tue, 16 Aug 2022 08:04:31 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 16 Aug 2022 08:04:29 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Aug 2022 08:04:29 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <jenhao.yang@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <kuabhs@google.com>,
        <druth@google.com>, <abhishekpandit@google.com>,
        <shawnku@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Deren Wu" <deren.wu@mediatek.com>
Subject: [PATCH 9/9] wifi: mt76: mt7921: introduce chanctx support
Date:   Tue, 16 Aug 2022 08:03:47 +0800
Message-ID: <3cf2e1a9658e971392b9b42f05f7b2a36815c7af.1660606893.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1660606893.git.objelf@gmail.com>
References: <cover.1660606893.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

The firmware can have the capability to manage the channel context
scheduling on multiple roles running on the device including Station,
AP and P2P GC/GO mode (will be extended based on the patchset) to help
users sharing the network with others on a single device.

The firmware is able to support the channel chanctx up to 2 interface
simultaneously running on the different channels.

Another thing to be noted is that before the driver is going sent out the
management frames, the driver has to get the privilege from the firmware
to occupy the current channel context until the frame handshake is
completed and then get the privilege back to the firmware.

We temporarily disable the feature with a module parameter
mt7921_disable_cnm for a while until we can ensure the patchset doesn't
cause any regression.

Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  40 ++++++-
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 111 +++++++++++++++++-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   1 +
 3 files changed, 145 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 1b7a18d42f5b..208a6117cb69 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -7,6 +7,10 @@
 #include "mcu.h"
 #include "eeprom.h"
 
+static bool mt7921_disable_cnm = true;
+module_param_named(disable_cnm, mt7921_disable_cnm, bool, 0644);
+MODULE_PARM_DESC(disable_cnm, "disable concurrent network support");
+
 static const struct ieee80211_iface_limit if_limits[] = {
 	{
 		.max = MT7921_MAX_INTERFACES,
@@ -25,6 +29,27 @@ static const struct ieee80211_iface_combination if_comb[] = {
 		.max_interfaces = MT7921_MAX_INTERFACES,
 		.num_different_channels = 1,
 		.beacon_int_infra_match = true,
+	},
+};
+
+static const struct ieee80211_iface_limit if_limits_chanctx[] = {
+	{
+		.max = 2,
+		.types = BIT(NL80211_IFTYPE_STATION),
+	},
+	{
+		.max = 1,
+		.types = BIT(NL80211_IFTYPE_AP),
+	}
+};
+
+static const struct ieee80211_iface_combination if_comb_chanctx[] = {
+	{
+		.limits = if_limits_chanctx,
+		.n_limits = ARRAY_SIZE(if_limits_chanctx),
+		.max_interfaces = 2,
+		.num_different_channels = 2,
+		.beacon_int_infra_match = false,
 	}
 };
 
@@ -63,11 +88,20 @@ static int mt7921_check_offload_capability(struct mt7921_dev *dev)
 	fw_can_roc =  mktime64(year, mon, day, hour, min, sec) >=
 		      mktime64(2022, 7, 15, 12, 1, 1);
 out:
-	if (!fw_can_roc) {
+	if (!fw_can_roc || mt7921_disable_cnm) {
 		dev->ops->remain_on_channel = NULL;
 		dev->ops->cancel_remain_on_channel = NULL;
+		dev->ops->add_chanctx = NULL;
+		dev->ops->remove_chanctx = NULL;
+		dev->ops->change_chanctx = NULL;
+		dev->ops->assign_vif_chanctx = NULL;
+		dev->ops->unassign_vif_chanctx = NULL;
+		dev->ops->mgd_prepare_tx = NULL;
+		dev->ops->mgd_complete_tx = NULL;
 
 		wiphy->flags &= ~WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
+		wiphy->iface_combinations = if_comb;
+		wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
 	}
 
 	return 0;
@@ -93,12 +127,12 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	hw->sta_data_size = sizeof(struct mt7921_sta);
 	hw->vif_data_size = sizeof(struct mt7921_vif);
 
-	wiphy->iface_combinations = if_comb;
+	wiphy->iface_combinations = if_comb_chanctx;
 	wiphy->flags &= ~(WIPHY_FLAG_IBSS_RSN | WIPHY_FLAG_4ADDR_AP |
 			  WIPHY_FLAG_4ADDR_STATION);
 	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
 				 BIT(NL80211_IFTYPE_AP);
-	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
+	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb_chanctx);
 	wiphy->max_remain_on_channel_duration = 5000;
 	wiphy->max_scan_ie_len = MT76_CONNAC_SCAN_IE_LEN;
 	wiphy->max_scan_ssids = 4;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index ae0aabe052e3..6386290ba71c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -858,7 +858,7 @@ void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
 		mt76_connac_mcu_uni_add_bss(&dev->mphy, vif, &mvif->sta.wcid,
-					    true, NULL);
+					    true, mvif->ctx);
 
 	mt7921_mac_wtbl_update(dev, msta->wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
@@ -890,7 +890,7 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		if (!sta->tdls)
 			mt76_connac_mcu_uni_add_bss(&dev->mphy, vif,
 						    &mvif->sta.wcid, false,
-						    NULL);
+						    mvif->ctx);
 	}
 
 	spin_lock_bh(&dev->sta_poll_lock);
@@ -1640,7 +1640,7 @@ mt7921_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mt7921_mutex_acquire(dev);
 
 	err = mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid,
-					  true, NULL);
+					  true, mvif->ctx);
 	if (err)
 		goto failed;
 
@@ -1672,12 +1672,108 @@ mt7921_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		goto failed;
 
 	mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid, false,
-				    NULL);
+				    mvif->ctx);
 
 failed:
 	mt7921_mutex_release(dev);
 }
 
+static int
+mt7921_add_chanctx(struct ieee80211_hw *hw,
+		   struct ieee80211_chanctx_conf *ctx)
+{
+	return 0;
+}
+
+static void
+mt7921_remove_chanctx(struct ieee80211_hw *hw,
+		      struct ieee80211_chanctx_conf *ctx)
+{
+}
+
+static void mt7921_ctx_iter(void *priv, u8 *mac,
+			    struct ieee80211_vif *vif)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct ieee80211_chanctx_conf *ctx = priv;
+
+	if (ctx != mvif->ctx)
+		return;
+
+	mt76_connac_mcu_uni_set_chctx(mvif->phy->mt76, &mvif->mt76, ctx);
+}
+
+static void
+mt7921_change_chanctx(struct ieee80211_hw *hw,
+		      struct ieee80211_chanctx_conf *ctx,
+		      u32 changed)
+{
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+
+	mt7921_mutex_acquire(phy->dev);
+	ieee80211_iterate_active_interfaces(phy->mt76->hw,
+					    IEEE80211_IFACE_ITER_ACTIVE,
+					    mt7921_ctx_iter, ctx);
+	mt7921_mutex_release(phy->dev);
+}
+
+static int
+mt7921_assign_vif_chanctx(struct ieee80211_hw *hw,
+			  struct ieee80211_vif *vif,
+			  struct ieee80211_bss_conf *link_conf,
+			  struct ieee80211_chanctx_conf *ctx)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+
+	mt7921_mutex_acquire(dev);
+	mvif->ctx = ctx;
+	mt7921_mutex_release(dev);
+
+	return 0;
+}
+
+static void
+mt7921_unassign_vif_chanctx(struct ieee80211_hw *hw,
+			    struct ieee80211_vif *vif,
+			    struct ieee80211_bss_conf *link_conf,
+			    struct ieee80211_chanctx_conf *ctx)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+
+	mt7921_mutex_acquire(dev);
+	mvif->ctx = NULL;
+	mt7921_mutex_release(dev);
+}
+
+static void mt7921_mgd_prepare_tx(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_prep_tx_info *info)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	u16 duration = info->duration ? info->duration :
+		       jiffies_to_msecs(HZ);
+
+	mt7921_mutex_acquire(dev);
+	mt7921_set_roc(mvif->phy, mvif, mvif->ctx->def.chan, duration,
+		       MT7921_ROC_REQ_JOIN);
+	mt7921_mutex_release(dev);
+}
+
+static void mt7921_mgd_complete_tx(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_prep_tx_info *info)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+
+	mt7921_mutex_acquire(dev);
+	mt7921_abort_roc(mvif->phy, mvif);
+	mt7921_mutex_release(dev);
+}
+
 const struct ieee80211_ops mt7921_ops = {
 	.tx = mt7921_tx,
 	.start = mt7921_start,
@@ -1730,6 +1826,13 @@ const struct ieee80211_ops mt7921_ops = {
 	.set_sar_specs = mt7921_set_sar_specs,
 	.remain_on_channel = mt7921_remain_on_channel,
 	.cancel_remain_on_channel = mt7921_cancel_remain_on_channel,
+	.add_chanctx = mt7921_add_chanctx,
+	.remove_chanctx = mt7921_remove_chanctx,
+	.change_chanctx = mt7921_change_chanctx,
+	.assign_vif_chanctx = mt7921_assign_vif_chanctx,
+	.unassign_vif_chanctx = mt7921_unassign_vif_chanctx,
+	.mgd_prepare_tx = mt7921_mgd_prepare_tx,
+	.mgd_complete_tx = mt7921_mgd_complete_tx,
 };
 EXPORT_SYMBOL_GPL(mt7921_ops);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 280605ffc4da..fda85252325c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -156,6 +156,7 @@ struct mt7921_vif {
 	struct ewma_rssi rssi;
 
 	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
+	struct ieee80211_chanctx_conf *ctx;
 };
 
 struct mib_stats {
-- 
2.25.1

