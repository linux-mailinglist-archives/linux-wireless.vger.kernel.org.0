Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD0377DC1C
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 10:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242889AbjHPIW6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 04:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242884AbjHPIWe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 04:22:34 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FDC61FFF
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 01:22:31 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37G8M53Y0001439, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37G8M53Y0001439
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Aug 2023 16:22:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 16 Aug 2023 16:22:25 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 16 Aug
 2023 16:22:24 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/6] wifi: rtw89: initialize multi-channel handling
Date:   Wed, 16 Aug 2023 16:21:33 +0800
Message-ID: <20230816082133.57474-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816082133.57474-1-pkshih@realtek.com>
References: <20230816082133.57474-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

We prepare to deal with multiple channels via new entity modes.
* MCC_PREPARE:	Transitional mode before MCC
* MCC:		Multi-Channel Concurrent mode
And, enum of sub-entity is extended for second channel context.

We add the entry flow of multi-channel handling and the core stuffs
for extended index of sub-entity. And, we now deal with the filling
of entity channels' info in entity recalc where we know the number
of active chanctx. However, the other detail coding of MCC start/stop
will be implemented in the following.

Besides, chanctx listener struct is pre-added in chip info. Each
component can add callback type in chanctx listener and configure
its callback function to react according to chanctx states. We know
at least RFK (RF calibration) and BTC (BT coexistence) will require
such callbacks.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c     | 124 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/chan.h     |   5 +
 drivers/net/wireless/realtek/rtw89/core.c     |  68 +++++++---
 drivers/net/wireless/realtek/rtw89/core.h     |  27 ++++
 drivers/net/wireless/realtek/rtw89/mac80211.c |   4 +
 drivers/net/wireless/realtek/rtw89/ps.c       |  14 +-
 6 files changed, 219 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 4663db4ce2f6..e1bc3606f9ae 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -4,6 +4,8 @@
 
 #include "chan.h"
 #include "debug.h"
+#include "fw.h"
+#include "ps.h"
 #include "util.h"
 
 static enum rtw89_subband rtw89_get_subband_type(enum rtw89_band band,
@@ -116,6 +118,7 @@ bool rtw89_assign_entity_chan(struct rtw89_dev *rtwdev,
 	rcd->prev_primary_channel = chan->primary_channel;
 	rcd->prev_band_type = chan->band_type;
 	band_changed = new->band_type != chan->band_type;
+	rcd->band_changed = band_changed;
 
 	*chan = *new;
 	return band_changed;
@@ -193,8 +196,12 @@ void rtw89_entity_init(struct rtw89_dev *rtwdev)
 enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
+	const struct cfg80211_chan_def *chandef;
 	enum rtw89_entity_mode mode;
+	struct rtw89_chan chan;
 	u8 weight;
+	u8 last;
+	u8 idx;
 
 	weight = bitmap_weight(hal->entity_map, NUM_OF_RTW89_SUB_ENTITY);
 	switch (weight) {
@@ -206,14 +213,121 @@ enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev)
 		rtw89_config_default_chandef(rtwdev);
 		fallthrough;
 	case 1:
+		last = RTW89_SUB_ENTITY_0;
 		mode = RTW89_ENTITY_MODE_SCC;
 		break;
+	case 2:
+		last = RTW89_SUB_ENTITY_1;
+		mode = rtw89_get_entity_mode(rtwdev);
+		if (mode == RTW89_ENTITY_MODE_MCC)
+			break;
+
+		mode = RTW89_ENTITY_MODE_MCC_PREPARE;
+		break;
+	}
+
+	for (idx = 0; idx <= last; idx++) {
+		chandef = rtw89_chandef_get(rtwdev, idx);
+		rtw89_get_channel_params(chandef, &chan);
+		if (chan.channel == 0) {
+			WARN(1, "Invalid channel on chanctx %d\n", idx);
+			return RTW89_ENTITY_MODE_INVALID;
+		}
+
+		rtw89_assign_entity_chan(rtwdev, idx, &chan);
 	}
 
 	rtw89_set_entity_mode(rtwdev, mode);
 	return mode;
 }
 
+static void rtw89_chanctx_notify(struct rtw89_dev *rtwdev,
+				 enum rtw89_chanctx_state state)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_chanctx_listener *listener = chip->chanctx_listener;
+	int i;
+
+	if (!listener)
+		return;
+
+	for (i = 0; i < NUM_OF_RTW89_CHANCTX_CALLBACKS; i++) {
+		if (!listener->callbacks[i])
+			continue;
+
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "chanctx notify listener: cb %d, state %d\n",
+			    i, state);
+
+		listener->callbacks[i](rtwdev, state);
+	}
+}
+
+static int rtw89_mcc_start(struct rtw89_dev *rtwdev)
+{
+	if (rtwdev->scanning)
+		rtw89_hw_scan_abort(rtwdev, rtwdev->scan_info.scanning_vif);
+
+	rtw89_leave_lps(rtwdev);
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN, "MCC start\n");
+	rtw89_chanctx_notify(rtwdev, RTW89_CHANCTX_STATE_MCC_START);
+	return 0;
+}
+
+static void rtw89_mcc_stop(struct rtw89_dev *rtwdev)
+{
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN, "MCC stop\n");
+	rtw89_chanctx_notify(rtwdev, RTW89_CHANCTX_STATE_MCC_STOP);
+}
+
+void rtw89_chanctx_work(struct work_struct *work)
+{
+	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
+						chanctx_work.work);
+	enum rtw89_entity_mode mode;
+	int ret;
+
+	mutex_lock(&rtwdev->mutex);
+
+	mode = rtw89_get_entity_mode(rtwdev);
+	switch (mode) {
+	case RTW89_ENTITY_MODE_MCC_PREPARE:
+		rtw89_set_entity_mode(rtwdev, RTW89_ENTITY_MODE_MCC);
+		rtw89_set_channel(rtwdev);
+
+		ret = rtw89_mcc_start(rtwdev);
+		if (ret)
+			rtw89_warn(rtwdev, "failed to start MCC: %d\n", ret);
+		break;
+	default:
+		break;
+	}
+
+	mutex_unlock(&rtwdev->mutex);
+}
+
+void rtw89_queue_chanctx_work(struct rtw89_dev *rtwdev)
+{
+	enum rtw89_entity_mode mode;
+	u32 delay;
+
+	mode = rtw89_get_entity_mode(rtwdev);
+	switch (mode) {
+	default:
+		return;
+	case RTW89_ENTITY_MODE_MCC_PREPARE:
+		delay = ieee80211_tu_to_usec(RTW89_CHANCTX_TIME_MCC_PREPARE);
+		break;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+		    "queue chanctx work for mode %d with delay %d us\n",
+		    mode, delay);
+	ieee80211_queue_delayed_work(rtwdev->hw, &rtwdev->chanctx_work,
+				     usecs_to_jiffies(delay));
+}
+
 int rtw89_chanctx_ops_add(struct rtw89_dev *rtwdev,
 			  struct ieee80211_chanctx_conf *ctx)
 {
@@ -238,6 +352,7 @@ void rtw89_chanctx_ops_remove(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_chanctx_cfg *cfg = (struct rtw89_chanctx_cfg *)ctx->drv_priv;
+	enum rtw89_entity_mode mode;
 	struct rtw89_vif *rtwvif;
 	u8 drop, roll;
 
@@ -267,6 +382,15 @@ void rtw89_chanctx_ops_remove(struct rtw89_dev *rtwdev,
 	drop = roll;
 
 out:
+	mode = rtw89_get_entity_mode(rtwdev);
+	switch (mode) {
+	case RTW89_ENTITY_MODE_MCC:
+		rtw89_mcc_stop(rtwdev);
+		break;
+	default:
+		break;
+	}
+
 	clear_bit(drop, hal->entity_map);
 	rtw89_set_channel(rtwdev);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index bdf369db5041..448e6c5df9f1 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -7,6 +7,9 @@
 
 #include "core.h"
 
+/* The dwell time in TU before doing rtw89_chanctx_work(). */
+#define RTW89_CHANCTX_TIME_MCC_PREPARE 100
+
 static inline bool rtw89_get_entity_state(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
@@ -50,6 +53,8 @@ void rtw89_config_roc_chandef(struct rtw89_dev *rtwdev,
 			      const struct cfg80211_chan_def *chandef);
 void rtw89_entity_init(struct rtw89_dev *rtwdev);
 enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev);
+void rtw89_chanctx_work(struct work_struct *work);
+void rtw89_queue_chanctx_work(struct rtw89_dev *rtwdev);
 int rtw89_chanctx_ops_add(struct rtw89_dev *rtwdev,
 			  struct ieee80211_chanctx_conf *ctx);
 void rtw89_chanctx_ops_remove(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 91f9a587220b..92fbbcd5dd3f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -256,8 +256,8 @@ void rtw89_get_default_chandef(struct cfg80211_chan_def *chandef)
 				NL80211_CHAN_NO_HT);
 }
 
-static void rtw89_get_channel_params(const struct cfg80211_chan_def *chandef,
-				     struct rtw89_chan *chan)
+void rtw89_get_channel_params(const struct cfg80211_chan_def *chandef,
+			      struct rtw89_chan *chan)
 {
 	struct ieee80211_channel *channel = chandef->chan;
 	enum nl80211_chan_width width = chandef->width;
@@ -318,9 +318,11 @@ static void rtw89_get_channel_params(const struct cfg80211_chan_def *chandef,
 
 void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev)
 {
+	struct rtw89_hal *hal = &rtwdev->hal;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_chan *chan;
 	enum rtw89_sub_entity_idx sub_entity_idx;
+	enum rtw89_sub_entity_idx roc_idx;
 	enum rtw89_phy_idx phy_idx;
 	enum rtw89_entity_mode mode;
 	bool entity_active;
@@ -330,10 +332,23 @@ void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev)
 		return;
 
 	mode = rtw89_get_entity_mode(rtwdev);
-	if (WARN(mode != RTW89_ENTITY_MODE_SCC, "Invalid ent mode: %d\n", mode))
+	switch (mode) {
+	case RTW89_ENTITY_MODE_SCC:
+	case RTW89_ENTITY_MODE_MCC:
+		sub_entity_idx = RTW89_SUB_ENTITY_0;
+		break;
+	case RTW89_ENTITY_MODE_MCC_PREPARE:
+		sub_entity_idx = RTW89_SUB_ENTITY_1;
+		break;
+	default:
+		WARN(1, "Invalid ent mode: %d\n", mode);
 		return;
+	}
+
+	roc_idx = atomic_read(&hal->roc_entity_idx);
+	if (roc_idx != RTW89_SUB_ENTITY_IDLE)
+		sub_entity_idx = roc_idx;
 
-	sub_entity_idx = RTW89_SUB_ENTITY_0;
 	phy_idx = RTW89_PHY_0;
 	chan = rtw89_chan_get(rtwdev, sub_entity_idx);
 	chip->ops->set_txpwr(rtwdev, chan, phy_idx);
@@ -341,43 +356,54 @@ void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev)
 
 void rtw89_set_channel(struct rtw89_dev *rtwdev)
 {
+	struct rtw89_hal *hal = &rtwdev->hal;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	const struct cfg80211_chan_def *chandef;
+	const struct rtw89_chan_rcd *chan_rcd;
+	const struct rtw89_chan *chan;
 	enum rtw89_sub_entity_idx sub_entity_idx;
+	enum rtw89_sub_entity_idx roc_idx;
 	enum rtw89_mac_idx mac_idx;
 	enum rtw89_phy_idx phy_idx;
-	struct rtw89_chan chan;
 	struct rtw89_channel_help_params bak;
 	enum rtw89_entity_mode mode;
-	bool band_changed;
 	bool entity_active;
 
 	entity_active = rtw89_get_entity_state(rtwdev);
 
 	mode = rtw89_entity_recalc(rtwdev);
-	if (WARN(mode != RTW89_ENTITY_MODE_SCC, "Invalid ent mode: %d\n", mode))
+	switch (mode) {
+	case RTW89_ENTITY_MODE_SCC:
+	case RTW89_ENTITY_MODE_MCC:
+		sub_entity_idx = RTW89_SUB_ENTITY_0;
+		break;
+	case RTW89_ENTITY_MODE_MCC_PREPARE:
+		sub_entity_idx = RTW89_SUB_ENTITY_1;
+		break;
+	default:
+		WARN(1, "Invalid ent mode: %d\n", mode);
 		return;
+	}
+
+	roc_idx = atomic_read(&hal->roc_entity_idx);
+	if (roc_idx != RTW89_SUB_ENTITY_IDLE)
+		sub_entity_idx = roc_idx;
 
-	sub_entity_idx = RTW89_SUB_ENTITY_0;
 	mac_idx = RTW89_MAC_0;
 	phy_idx = RTW89_PHY_0;
-	chandef = rtw89_chandef_get(rtwdev, sub_entity_idx);
-	rtw89_get_channel_params(chandef, &chan);
-	if (WARN(chan.channel == 0, "Invalid channel\n"))
-		return;
 
-	band_changed = rtw89_assign_entity_chan(rtwdev, sub_entity_idx, &chan);
+	chan = rtw89_chan_get(rtwdev, sub_entity_idx);
+	chan_rcd = rtw89_chan_rcd_get(rtwdev, sub_entity_idx);
 
-	rtw89_chip_set_channel_prepare(rtwdev, &bak, &chan, mac_idx, phy_idx);
+	rtw89_chip_set_channel_prepare(rtwdev, &bak, chan, mac_idx, phy_idx);
 
-	chip->ops->set_channel(rtwdev, &chan, mac_idx, phy_idx);
+	chip->ops->set_channel(rtwdev, chan, mac_idx, phy_idx);
 
-	chip->ops->set_txpwr(rtwdev, &chan, phy_idx);
+	chip->ops->set_txpwr(rtwdev, chan, phy_idx);
 
-	rtw89_chip_set_channel_done(rtwdev, &bak, &chan, mac_idx, phy_idx);
+	rtw89_chip_set_channel_done(rtwdev, &bak, chan, mac_idx, phy_idx);
 
-	if (!entity_active || band_changed) {
-		rtw89_btc_ntfy_switch_band(rtwdev, phy_idx, chan.band_type);
+	if (!entity_active || chan_rcd->band_changed) {
+		rtw89_btc_ntfy_switch_band(rtwdev, phy_idx, chan->band_type);
 		rtw89_chip_rfk_band_changed(rtwdev, phy_idx);
 	}
 
@@ -3562,6 +3588,7 @@ void rtw89_core_stop(struct rtw89_dev *rtwdev)
 	cancel_work_sync(&btc->icmp_notify_work);
 	cancel_delayed_work_sync(&rtwdev->txq_reinvoke_work);
 	cancel_delayed_work_sync(&rtwdev->track_work);
+	cancel_delayed_work_sync(&rtwdev->chanctx_work);
 	cancel_delayed_work_sync(&rtwdev->coex_act1_work);
 	cancel_delayed_work_sync(&rtwdev->coex_bt_devinfo_work);
 	cancel_delayed_work_sync(&rtwdev->coex_rfk_chk_work);
@@ -3598,6 +3625,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	INIT_WORK(&rtwdev->txq_work, rtw89_core_txq_work);
 	INIT_DELAYED_WORK(&rtwdev->txq_reinvoke_work, rtw89_core_txq_reinvoke_work);
 	INIT_DELAYED_WORK(&rtwdev->track_work, rtw89_track_work);
+	INIT_DELAYED_WORK(&rtwdev->chanctx_work, rtw89_chanctx_work);
 	INIT_DELAYED_WORK(&rtwdev->coex_act1_work, rtw89_coex_act1_work);
 	INIT_DELAYED_WORK(&rtwdev->coex_bt_devinfo_work, rtw89_coex_bt_devinfo_work);
 	INIT_DELAYED_WORK(&rtwdev->coex_rfk_chk_work, rtw89_coex_rfk_chk_work);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 431b0d3daa2a..284d8f7a7a0c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -789,6 +789,7 @@ enum rtw89_phy_idx {
 
 enum rtw89_sub_entity_idx {
 	RTW89_SUB_ENTITY_0 = 0,
+	RTW89_SUB_ENTITY_1 = 1,
 
 	NUM_OF_RTW89_SUB_ENTITY,
 	RTW89_SUB_ENTITY_IDLE = NUM_OF_RTW89_SUB_ENTITY,
@@ -900,6 +901,7 @@ struct rtw89_chan {
 struct rtw89_chan_rcd {
 	u8 prev_primary_channel;
 	enum rtw89_band prev_band_type;
+	bool band_changed;
 };
 
 struct rtw89_channel_help_params {
@@ -3413,6 +3415,22 @@ struct rtw89_antdiv_info {
 	bool get_stats;
 };
 
+enum rtw89_chanctx_state {
+	RTW89_CHANCTX_STATE_MCC_START,
+	RTW89_CHANCTX_STATE_MCC_STOP,
+};
+
+enum rtw89_chanctx_callbacks {
+	RTW89_CHANCTX_CALLBACK_PLACEHOLDER,
+
+	NUM_OF_RTW89_CHANCTX_CALLBACKS,
+};
+
+struct rtw89_chanctx_listener {
+	void (*callbacks[NUM_OF_RTW89_CHANCTX_CALLBACKS])
+		(struct rtw89_dev *rtwdev, enum rtw89_chanctx_state state);
+};
+
 struct rtw89_chip_info {
 	enum rtw89_core_chip_id chip_id;
 	enum rtw89_chip_gen chip_gen;
@@ -3472,6 +3490,7 @@ struct rtw89_chip_info {
 	/* NULL if no rfe-specific, or a null-terminated array by rfe_parms */
 	const struct rtw89_rfe_parms_conf *rfe_parms_conf;
 	const struct rtw89_rfe_parms *dflt_parms;
+	const struct rtw89_chanctx_listener *chanctx_listener;
 
 	u8 txpwr_factor_rf;
 	u8 txpwr_factor_mac;
@@ -3751,6 +3770,11 @@ struct rtw89_chanctx_cfg {
 
 enum rtw89_entity_mode {
 	RTW89_ENTITY_MODE_SCC,
+	RTW89_ENTITY_MODE_MCC_PREPARE,
+	RTW89_ENTITY_MODE_MCC,
+
+	NUM_OF_RTW89_ENTITY_MODE,
+	RTW89_ENTITY_MODE_INVALID = NUM_OF_RTW89_ENTITY_MODE,
 };
 
 struct rtw89_sub_entity {
@@ -4407,6 +4431,7 @@ struct rtw89_dev {
 	struct rtw89_antdiv_info antdiv;
 
 	struct delayed_work track_work;
+	struct delayed_work chanctx_work;
 	struct delayed_work coex_act1_work;
 	struct delayed_work coex_bt_devinfo_work;
 	struct delayed_work coex_rfk_chk_work;
@@ -5341,6 +5366,8 @@ struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
 void rtw89_free_ieee80211_hw(struct rtw89_dev *rtwdev);
 void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev);
 void rtw89_get_default_chandef(struct cfg80211_chan_def *chandef);
+void rtw89_get_channel_params(const struct cfg80211_chan_def *chandef,
+			      struct rtw89_chan *chan);
 void rtw89_set_channel(struct rtw89_dev *rtwdev);
 void rtw89_get_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 		       struct rtw89_chan *chan);
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 7c3066c0a550..c9ed369015fe 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -414,6 +414,8 @@ static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
 			rtw89_chip_cfg_txpwr_ul_tb_offset(rtwdev, vif);
 			rtw89_mac_port_update(rtwdev, rtwvif);
 			rtw89_mac_set_he_obss_narrow_bw_ru(rtwdev, vif);
+
+			rtw89_queue_chanctx_work(rtwdev);
 		} else {
 			/* Abort ongoing scan if cancel_scan isn't issued
 			 * when disconnected by peer
@@ -477,6 +479,8 @@ static int rtw89_ops_start_ap(struct ieee80211_hw *hw,
 	rtw89_fw_h2c_join_info(rtwdev, rtwvif, NULL, true);
 	rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL, NULL);
 	rtw89_chip_rfk_channel(rtwdev);
+
+	rtw89_queue_chanctx_work(rtwdev);
 	mutex_unlock(&rtwdev->mutex);
 
 	return 0;
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index b98ec178abe1..917c01e5e9ed 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2019-2020  Realtek Corporation
  */
 
+#include "chan.h"
 #include "coex.h"
 #include "core.h"
 #include "debug.h"
@@ -257,8 +258,13 @@ void rtw89_recalc_lps(struct rtw89_dev *rtwdev)
 {
 	struct ieee80211_vif *vif, *found_vif = NULL;
 	struct rtw89_vif *rtwvif;
+	enum rtw89_entity_mode mode;
 	int count = 0;
 
+	mode = rtw89_get_entity_mode(rtwdev);
+	if (mode == RTW89_ENTITY_MODE_MCC)
+		goto disable_lps;
+
 	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
 		vif = rtwvif_to_vif(rtwvif);
 
@@ -273,10 +279,12 @@ void rtw89_recalc_lps(struct rtw89_dev *rtwdev)
 
 	if (count == 1 && found_vif->cfg.ps) {
 		rtwdev->lps_enabled = true;
-	} else {
-		rtw89_leave_lps(rtwdev);
-		rtwdev->lps_enabled = false;
+		return;
 	}
+
+disable_lps:
+	rtw89_leave_lps(rtwdev);
+	rtwdev->lps_enabled = false;
 }
 
 void rtw89_p2p_noa_renew(struct rtw89_vif *rtwvif)
-- 
2.25.1

