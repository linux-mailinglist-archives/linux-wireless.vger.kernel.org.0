Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25985624CF2
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 22:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiKJVZQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Nov 2022 16:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiKJVYl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Nov 2022 16:24:41 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4541D2
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 13:24:19 -0800 (PST)
X-UUID: 4943a87749234ab398b7985e3b48e328-20221111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nTrKgW0O6IY5Rsi1eg9QyPI5s4jmnFbMLTtY42BqCo0=;
        b=Urfy4Q8Qm/xdQax3adfJDz/dFUrRIJbrJ87rqDLy0NvLgHHFVGHJw2U8pc31hXaQwwbVwRGcwgn1+GUzD3hlfgxbQxiFtyBCVBwKY1b5KFe/N7m03NhJGAb3lfk8QPayDiPXXGshil8GCZRZjHQUYrJismtrQpLUE1SoEEeuqT8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:be4a764f-c3d7-431f-b488-51095004ebe1,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d12e911,CLOUDID:7898f350-b7af-492d-8b40-b1032f90ce11,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 4943a87749234ab398b7985e3b48e328-20221111
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2114887214; Fri, 11 Nov 2022 05:24:14 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 11 Nov 2022 05:24:12 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 11 Nov 2022 05:24:12 +0800
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
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH v3 7/7] wifi: mt76: mt7921: introduce chanctx support
Date:   Fri, 11 Nov 2022 05:23:49 +0800
Message-ID: <a6f342b356b87415a123e2ae144b3c7c9f3a9fca.1668068326.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1668068326.git.objelf@gmail.com>
References: <cover.1668068326.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

The firmware can have the capability to manage the channel context
scheduling on multiple roles running on the device including Station,
AP and P2P GC/GO mode (will be extended based on the future patchset)
to help users sharing the network with others on a single device.

The firmware is able to support the channel chanctx up to 2 interface
simultaneously running on the different channels.

Another thing to be noted is that before the driver is going sent out the
management frames, the driver has to get the privilege from the firmware
to occupy the current channel context until the frame handshake is
completed and then get the privilege back to the firmware.

Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  33 +++++-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |   8 --
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 111 +++++++++++++++++-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   1 +
 4 files changed, 136 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index e9353e9929a9..79b8055ce4c4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -26,6 +26,27 @@ static const struct ieee80211_iface_combination if_comb[] = {
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
 
@@ -66,17 +87,19 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	hw->sta_data_size = sizeof(struct mt7921_sta);
 	hw->vif_data_size = sizeof(struct mt7921_vif);
 
-	if (dev->fw_features & MT7921_FW_CAP_CNM)
+	if (dev->fw_features & MT7921_FW_CAP_CNM) {
 		wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
-	else
+		wiphy->iface_combinations = if_comb_chanctx;
+		wiphy->n_iface_combinations = ARRAY_SIZE(if_comb_chanctx);
+	} else {
 		wiphy->flags &= ~WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
-
-	wiphy->iface_combinations = if_comb;
+		wiphy->iface_combinations = if_comb;
+		wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
+	}
 	wiphy->flags &= ~(WIPHY_FLAG_IBSS_RSN | WIPHY_FLAG_4ADDR_AP |
 			  WIPHY_FLAG_4ADDR_STATION);
 	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
 				 BIT(NL80211_IFTYPE_AP);
-	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
 	wiphy->max_remain_on_channel_duration = 5000;
 	wiphy->max_scan_ie_len = MT76_CONNAC_SCAN_IE_LEN;
 	wiphy->max_scan_ssids = 4;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 2cf709a80b5f..08c9a2cec687 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -168,14 +168,6 @@ static void
 mt7921_get_status_freq_info(struct mt7921_dev *dev, struct mt76_phy *mphy,
 			    struct mt76_rx_status *status, u8 chfreq)
 {
-	if (!test_bit(MT76_HW_SCANNING, &mphy->state) &&
-	    !test_bit(MT76_HW_SCHED_SCANNING, &mphy->state) &&
-	    !test_bit(MT76_STATE_ROC, &mphy->state)) {
-		status->freq = mphy->chandef.chan->center_freq;
-		status->band = mphy->chandef.chan->band;
-		return;
-	}
-
 	if (chfreq > 180) {
 		status->band = NL80211_BAND_6GHZ;
 		chfreq = (chfreq - 181) * 4 + 1;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 82837ccc104d..6206aa44c0e7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -858,7 +858,7 @@ void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
 		mt76_connac_mcu_uni_add_bss(&dev->mphy, vif, &mvif->sta.wcid,
-					    true, NULL);
+					    true, mvif->ctx);
 
 	mt7921_mac_wtbl_update(dev, msta->wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
@@ -891,7 +891,7 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		if (!sta->tdls)
 			mt76_connac_mcu_uni_add_bss(&dev->mphy, vif,
 						    &mvif->sta.wcid, false,
-						    NULL);
+						    mvif->ctx);
 	}
 
 	spin_lock_bh(&dev->sta_poll_lock);
@@ -1645,7 +1645,7 @@ mt7921_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mt7921_mutex_acquire(dev);
 
 	err = mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid,
-					  true, NULL);
+					  true, mvif->ctx);
 	if (err)
 		goto out;
 
@@ -1677,12 +1677,108 @@ mt7921_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		goto out;
 
 	mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid, false,
-				    NULL);
+				    mvif->ctx);
 
 out:
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
+	mutex_lock(&dev->mt76.mutex);
+	mvif->ctx = ctx;
+	mutex_unlock(&dev->mt76.mutex);
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
+	mutex_lock(&dev->mt76.mutex);
+	mvif->ctx = NULL;
+	mutex_unlock(&dev->mt76.mutex);
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
 const struct ieee80211_ops mt7921_ops_chanctx = {
 	.tx = mt7921_tx,
 	.start = mt7921_start,
@@ -1735,6 +1831,13 @@ const struct ieee80211_ops mt7921_ops_chanctx = {
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
 EXPORT_SYMBOL_GPL(mt7921_ops_chanctx);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index ab1bf34d5616..681356c80870 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -171,6 +171,7 @@ struct mt7921_vif {
 	struct ewma_rssi rssi;
 
 	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
+	struct ieee80211_chanctx_conf *ctx;
 };
 
 struct mib_stats {
-- 
2.25.1

