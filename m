Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9417A9031
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 02:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjIUAgc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 20:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjIUAg2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 20:36:28 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C880DD
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 17:36:20 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38L0aAIJ11966994, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38L0aAIJ11966994
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 08:36:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 21 Sep 2023 08:36:11 +0800
Received: from [127.0.1.1] (172.16.16.112) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 21 Sep
 2023 08:36:10 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/4] wifi: rtw89: pause/proceed MCC for ROC and HW scan
Date:   Thu, 21 Sep 2023 08:35:57 +0800
Message-ID: <20230921003559.11588-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230921003559.11588-1-pkshih@realtek.com>
References: <20230921003559.11588-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.112]
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

During (TDMA-based) MCC (multi-channel concurrency), the below two
cases might not have a good behavior on channel usage.
* ROC (remain on channel)
* HW scan
So, we tend to separate them from MCC.

The two cases would expect to operate the channel to which they want.
However, during MCC, channels are scheduled by FW MCC state mechanism.
So, channels cannot be controlled explicitly. To avoid the two cases
from operating wrong channels with chance, we pause MCC (essentially
stop FW MCC) once the two cases are coming. And then, we proceed MCC
again (essentially restart FW MCC) once the two cases finish.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 70 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/chan.h |  8 +++
 drivers/net/wireless/realtek/rtw89/core.c |  3 +-
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c   |  4 +-
 5 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 5564067c45cc..5ef250439bf9 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -190,6 +190,7 @@ void rtw89_entity_init(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
 
+	hal->entity_pause = false;
 	bitmap_zero(hal->entity_map, NUM_OF_RTW89_SUB_ENTITY);
 	bitmap_zero(hal->changes, NUM_OF_RTW89_CHANCTX_CHANGES);
 	atomic_set(&hal->roc_entity_idx, RTW89_SUB_ENTITY_IDLE);
@@ -206,6 +207,8 @@ enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev)
 	u8 last;
 	u8 idx;
 
+	lockdep_assert_held(&rtwdev->mutex);
+
 	weight = bitmap_weight(hal->entity_map, NUM_OF_RTW89_SUB_ENTITY);
 	switch (weight) {
 	default:
@@ -240,6 +243,9 @@ enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev)
 		rtw89_assign_entity_chan(rtwdev, idx, &chan);
 	}
 
+	if (hal->entity_pause)
+		return rtw89_get_entity_mode(rtwdev);
+
 	rtw89_set_entity_mode(rtwdev, mode);
 	return mode;
 }
@@ -1721,6 +1727,11 @@ void rtw89_chanctx_work(struct work_struct *work)
 
 	mutex_lock(&rtwdev->mutex);
 
+	if (hal->entity_pause) {
+		mutex_unlock(&rtwdev->mutex);
+		return;
+	}
+
 	for (i = 0; i < NUM_OF_RTW89_CHANCTX_CHANGES; i++) {
 		if (test_and_clear_bit(i, hal->changes))
 			changed |= BIT(i);
@@ -1801,10 +1812,14 @@ void rtw89_queue_chanctx_work(struct rtw89_dev *rtwdev)
 
 void rtw89_chanctx_track(struct rtw89_dev *rtwdev)
 {
+	struct rtw89_hal *hal = &rtwdev->hal;
 	enum rtw89_entity_mode mode;
 
 	lockdep_assert_held(&rtwdev->mutex);
 
+	if (hal->entity_pause)
+		return;
+
 	mode = rtw89_get_entity_mode(rtwdev);
 	switch (mode) {
 	case RTW89_ENTITY_MODE_MCC:
@@ -1815,6 +1830,61 @@ void rtw89_chanctx_track(struct rtw89_dev *rtwdev)
 	}
 }
 
+void rtw89_chanctx_pause(struct rtw89_dev *rtwdev,
+			 enum rtw89_chanctx_pause_reasons rsn)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	enum rtw89_entity_mode mode;
+
+	lockdep_assert_held(&rtwdev->mutex);
+
+	if (hal->entity_pause)
+		return;
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN, "chanctx pause (rsn: %d)\n", rsn);
+
+	mode = rtw89_get_entity_mode(rtwdev);
+	switch (mode) {
+	case RTW89_ENTITY_MODE_MCC:
+		rtw89_mcc_stop(rtwdev);
+		break;
+	default:
+		break;
+	}
+
+	hal->entity_pause = true;
+}
+
+void rtw89_chanctx_proceed(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	enum rtw89_entity_mode mode;
+	int ret;
+
+	lockdep_assert_held(&rtwdev->mutex);
+
+	if (!hal->entity_pause)
+		return;
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN, "chanctx proceed\n");
+
+	hal->entity_pause = false;
+	rtw89_set_channel(rtwdev);
+
+	mode = rtw89_get_entity_mode(rtwdev);
+	switch (mode) {
+	case RTW89_ENTITY_MODE_MCC:
+		ret = rtw89_mcc_start(rtwdev);
+		if (ret)
+			rtw89_warn(rtwdev, "failed to start MCC: %d\n", ret);
+		break;
+	default:
+		break;
+	}
+
+	rtw89_queue_chanctx_work(rtwdev);
+}
+
 int rtw89_chanctx_ops_add(struct rtw89_dev *rtwdev,
 			  struct ieee80211_chanctx_conf *ctx)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index 9fd46f5c37b9..9b98d8f4ee9d 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -33,6 +33,11 @@
 
 #define NUM_OF_RTW89_MCC_ROLES 2
 
+enum rtw89_chanctx_pause_reasons {
+	RTW89_CHANCTX_PAUSE_REASON_HW_SCAN,
+	RTW89_CHANCTX_PAUSE_REASON_ROC,
+};
+
 static inline bool rtw89_get_entity_state(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
@@ -81,6 +86,9 @@ void rtw89_queue_chanctx_work(struct rtw89_dev *rtwdev);
 void rtw89_queue_chanctx_change(struct rtw89_dev *rtwdev,
 				enum rtw89_chanctx_changes change);
 void rtw89_chanctx_track(struct rtw89_dev *rtwdev);
+void rtw89_chanctx_pause(struct rtw89_dev *rtwdev,
+			 enum rtw89_chanctx_pause_reasons rsn);
+void rtw89_chanctx_proceed(struct rtw89_dev *rtwdev);
 int rtw89_chanctx_ops_add(struct rtw89_dev *rtwdev,
 			  struct ieee80211_chanctx_conf *ctx);
 void rtw89_chanctx_ops_remove(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 362aa0922339..ac5a4b0d8282 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2706,6 +2706,7 @@ void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 
 	rtw89_leave_ips_by_hwflags(rtwdev);
 	rtw89_leave_lps(rtwdev);
+	rtw89_chanctx_pause(rtwdev, RTW89_CHANCTX_PAUSE_REASON_ROC);
 
 	ret = rtw89_core_send_nullfunc(rtwdev, rtwvif, true, true);
 	if (ret)
@@ -2748,7 +2749,7 @@ void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 
 	roc->state = RTW89_ROC_IDLE;
 	rtw89_config_roc_chandef(rtwdev, rtwvif->sub_entity_idx, NULL);
-	rtw89_set_channel(rtwdev);
+	rtw89_chanctx_proceed(rtwdev);
 	ret = rtw89_core_send_nullfunc(rtwdev, rtwvif, true, false);
 	if (ret)
 		rtw89_debug(rtwdev, RTW89_DBG_TXRX,
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 08fa83995e17..d5c67708d639 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3889,6 +3889,7 @@ struct rtw89_hal {
 	struct cfg80211_chan_def roc_chandef;
 
 	bool entity_active;
+	bool entity_pause;
 	enum rtw89_entity_mode entity_mode;
 
 	u32 edcca_bak;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 0f6ac26870b5..33ebe2721fd2 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3932,6 +3932,8 @@ void rtw89_hw_scan_start(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			   rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, RTW89_MAC_0),
 			   B_AX_RX_FLTR_CFG_MASK,
 			   rx_fltr);
+
+	rtw89_chanctx_pause(rtwdev, RTW89_CHANCTX_PAUSE_REASON_HW_SCAN);
 }
 
 void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
@@ -3963,7 +3965,7 @@ void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 	scan_info->last_chan_idx = 0;
 	scan_info->scanning_vif = NULL;
 
-	rtw89_set_channel(rtwdev);
+	rtw89_chanctx_proceed(rtwdev);
 }
 
 void rtw89_hw_scan_abort(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif)
-- 
2.25.1

