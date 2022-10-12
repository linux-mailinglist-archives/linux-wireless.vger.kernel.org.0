Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF0C5FBE9C
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Oct 2022 02:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJLAQo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Oct 2022 20:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiJLAQk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Oct 2022 20:16:40 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C892C2BE3B
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 17:16:38 -0700 (PDT)
X-UUID: 84bed6c3fcf04b6bacd25fe4d387cca6-20221012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=BdI+K7SAnlxg5IzerH+Ln2BJShQ7bSNtqC4WSbmOrHY=;
        b=nLuQ7mxVIzutKFo1Hlpwx9vd+BjewANoXfHOOVsUzgS8EeAjOzA8uVBqIOlq0FL44h8HtSWnmZCuP79XNltXESBQj4T8MyxRGQkCNQHAI6ajPsx9p+OtoqeUKtR/YxTTSOKAovfAei7L+tP8loEI7daKS4lMj5JnoNcrSI8MoqA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:28781c0d-bf14-4fa8-bbe1-11e03caa79f6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:3513f3fe-ee8c-4ff7-afe9-644435e96625,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 84bed6c3fcf04b6bacd25fe4d387cca6-20221012
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 715578890; Wed, 12 Oct 2022 08:16:35 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 12 Oct 2022 08:16:33 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 12 Oct 2022 08:16:33 +0800
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
Subject: [PATCH v2 7/7] wifi: mt76: mt7921: introduce chanctx support
Date:   Wed, 12 Oct 2022 08:16:21 +0800
Message-ID: <5b78da05ba7061b2594cc603a986773dd40d3688.1665533390.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <8d784dba38cfb2183af2e4d9fc822a27ef34dcd2.1665533390.git.objelf@gmail.com>
References: <8d784dba38cfb2183af2e4d9fc822a27ef34dcd2.1665533390.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
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
v2:
1. decide the feature by the firmware capability bit
2. decide the channel by the hardware value in mt7921_get_status_freq_info()
---
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  33 +++++-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |   8 --
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 111 +++++++++++++++++-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   1 +
 4 files changed, 136 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 482b601f86d9..cc6cb7301bd9 100644
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
index 8e9257d3cc54..6e400a5a5e4e 100644
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

