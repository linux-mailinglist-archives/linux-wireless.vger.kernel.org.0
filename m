Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F9D7980DC
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Sep 2023 05:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238800AbjIHDNI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Sep 2023 23:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238525AbjIHDNH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Sep 2023 23:13:07 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9C81BD9
        for <linux-wireless@vger.kernel.org>; Thu,  7 Sep 2023 20:13:01 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3883CrBS21359710, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 3883CrBS21359710
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Sep 2023 11:12:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 8 Sep 2023 11:12:54 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 8 Sep 2023
 11:12:53 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/8] wifi: rtw89: mcc: track beacon offset and update when needed
Date:   Fri, 8 Sep 2023 11:11:42 +0800
Message-ID: <20230908031145.20931-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230908031145.20931-1-pkshih@realtek.com>
References: <20230908031145.20931-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.25]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

In MCC STA+GC mode, the offset between TBTTs of remote AP and remote GO
might change. If the change is larger than tolerance, we should update
MCC after re-calculating parameters for new things. So, we track that in
rtw89_track_work() now. And, we add MCC update flow to tell FW either to
change durations of roles or to replace entire pattern according to how
MCC plans BT slot.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 145 +++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/chan.h |   3 +
 drivers/net/wireless/realtek/rtw89/core.c |   1 +
 drivers/net/wireless/realtek/rtw89/core.h |   1 +
 drivers/net/wireless/realtek/rtw89/fw.h   |   5 +
 5 files changed, 153 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 5ac6d60dfd73..417fb5e98813 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -1297,7 +1297,7 @@ static int __mcc_fw_add_bt_role(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
-static int __mcc_fw_start(struct rtw89_dev *rtwdev)
+static int __mcc_fw_start(struct rtw89_dev *rtwdev, bool replace)
 {
 	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
 	struct rtw89_mcc_role *ref = &mcc->role_ref;
@@ -1308,6 +1308,12 @@ static int __mcc_fw_start(struct rtw89_dev *rtwdev)
 	struct rtw89_fw_mcc_start_req req = {};
 	int ret;
 
+	if (replace) {
+		req.old_group = mcc->group;
+		req.old_group_action = RTW89_FW_MCC_OLD_GROUP_ACT_REPLACE;
+		mcc->group = RTW89_MCC_NEXT_GROUP(mcc->group);
+	}
+
 	req.group = mcc->group;
 
 	switch (pattern->plan) {
@@ -1376,6 +1382,47 @@ static int __mcc_fw_start(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static int __mcc_fw_set_duration_no_bt(struct rtw89_dev *rtwdev, bool sync_changed)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_config *config = &mcc->config;
+	struct rtw89_mcc_sync *sync = &config->sync;
+	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	struct rtw89_mcc_role *aux = &mcc->role_aux;
+	struct rtw89_fw_mcc_duration req = {
+		.group = mcc->group,
+		.btc_in_group = false,
+		.start_macid = ref->rtwvif->mac_id,
+		.macid_x = ref->rtwvif->mac_id,
+		.macid_y = aux->rtwvif->mac_id,
+		.duration_x = ref->duration,
+		.duration_y = aux->duration,
+		.start_tsf_high = config->start_tsf >> 32,
+		.start_tsf_low = config->start_tsf,
+	};
+	int ret;
+
+	ret = rtw89_fw_h2c_mcc_set_duration(rtwdev, &req);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MCC h2c failed to set duration: %d\n", ret);
+		return ret;
+	}
+
+	if (!sync->enable || !sync_changed)
+		return 0;
+
+	ret = rtw89_fw_h2c_mcc_sync(rtwdev, mcc->group, sync->macid_src,
+				    sync->macid_tgt, sync->offset);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+			    "MCC h2c failed to trigger sync: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int rtw89_mcc_start(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
@@ -1407,7 +1454,7 @@ static int rtw89_mcc_start(struct rtw89_dev *rtwdev)
 	if (ret)
 		return ret;
 
-	ret = __mcc_fw_start(rtwdev);
+	ret = __mcc_fw_start(rtwdev, false);
 	if (ret)
 		return ret;
 
@@ -1437,6 +1484,75 @@ static void rtw89_mcc_stop(struct rtw89_dev *rtwdev)
 	rtw89_chanctx_notify(rtwdev, RTW89_CHANCTX_STATE_MCC_STOP);
 }
 
+static int rtw89_mcc_update(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_config *config = &mcc->config;
+	struct rtw89_mcc_config old_cfg = *config;
+	bool sync_changed;
+	int ret;
+
+	if (rtwdev->scanning)
+		rtw89_hw_scan_abort(rtwdev, rtwdev->scan_info.scanning_vif);
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN, "MCC update\n");
+
+	ret = rtw89_mcc_fill_config(rtwdev);
+	if (ret)
+		return ret;
+
+	if (old_cfg.pattern.plan != RTW89_MCC_PLAN_NO_BT ||
+	    config->pattern.plan != RTW89_MCC_PLAN_NO_BT) {
+		ret = __mcc_fw_start(rtwdev, true);
+		if (ret)
+			return ret;
+	} else {
+		if (memcmp(&old_cfg.sync, &config->sync, sizeof(old_cfg.sync)) == 0)
+			sync_changed = false;
+		else
+			sync_changed = true;
+
+		ret = __mcc_fw_set_duration_no_bt(rtwdev, sync_changed);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void rtw89_mcc_track(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_config *config = &mcc->config;
+	struct rtw89_mcc_pattern *pattern = &config->pattern;
+	s16 tolerance;
+	u16 bcn_ofst;
+	u16 diff;
+
+	if (mcc->mode != RTW89_MCC_MODE_GC_STA)
+		return;
+
+	bcn_ofst = rtw89_mcc_get_bcn_ofst(rtwdev);
+	if (bcn_ofst > config->beacon_offset) {
+		diff = bcn_ofst - config->beacon_offset;
+		if (pattern->tob_aux < 0)
+			tolerance = -pattern->tob_aux;
+		else
+			tolerance = pattern->toa_aux;
+	} else {
+		diff = config->beacon_offset - bcn_ofst;
+		if (pattern->toa_aux < 0)
+			tolerance = -pattern->toa_aux;
+		else
+			tolerance = pattern->tob_aux;
+	}
+
+	if (diff <= tolerance)
+		return;
+
+	rtw89_queue_chanctx_change(rtwdev, RTW89_CHANCTX_BCN_OFFSET_CHANGE);
+}
+
 static int rtw89_mcc_upd_map_iterator(struct rtw89_dev *rtwdev,
 				      struct rtw89_mcc_role *mcc_role,
 				      unsigned int ordered_idx,
@@ -1485,6 +1601,7 @@ void rtw89_chanctx_work(struct work_struct *work)
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
 						chanctx_work.work);
 	struct rtw89_hal *hal = &rtwdev->hal;
+	bool update_mcc_pattern = false;
 	enum rtw89_entity_mode mode;
 	u32 changed = 0;
 	int ret;
@@ -1508,8 +1625,16 @@ void rtw89_chanctx_work(struct work_struct *work)
 			rtw89_warn(rtwdev, "failed to start MCC: %d\n", ret);
 		break;
 	case RTW89_ENTITY_MODE_MCC:
+		if (changed & BIT(RTW89_CHANCTX_BCN_OFFSET_CHANGE))
+			update_mcc_pattern = true;
 		if (changed & BIT(RTW89_CHANCTX_REMOTE_STA_CHANGE))
 			rtw89_mcc_update_macid_bitmap(rtwdev);
+		if (update_mcc_pattern) {
+			ret = rtw89_mcc_update(rtwdev);
+			if (ret)
+				rtw89_warn(rtwdev, "failed to update MCC: %d\n",
+					   ret);
+		}
 		break;
 	default:
 		break;
@@ -1555,6 +1680,22 @@ void rtw89_queue_chanctx_work(struct rtw89_dev *rtwdev)
 	rtw89_queue_chanctx_change(rtwdev, RTW89_CHANCTX_CHANGE_DFLT);
 }
 
+void rtw89_chanctx_track(struct rtw89_dev *rtwdev)
+{
+	enum rtw89_entity_mode mode;
+
+	lockdep_assert_held(&rtwdev->mutex);
+
+	mode = rtw89_get_entity_mode(rtwdev);
+	switch (mode) {
+	case RTW89_ENTITY_MODE_MCC:
+		rtw89_mcc_track(rtwdev);
+		break;
+	default:
+		break;
+	}
+}
+
 int rtw89_chanctx_ops_add(struct rtw89_dev *rtwdev,
 			  struct ieee80211_chanctx_conf *ctx)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index 2fca703c99f0..9fd46f5c37b9 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -26,6 +26,8 @@
 	(RTW89_MCC_EARLY_RX_BCN_TIME + RTW89_MCC_MIN_RX_BCN_TIME)
 
 #define RTW89_MCC_DFLT_GROUP 0
+#define RTW89_MCC_NEXT_GROUP(cur) (((cur) + 1) % 4)
+
 #define RTW89_MCC_DFLT_TX_NULL_EARLY 3
 #define RTW89_MCC_DFLT_COURTESY_SLOT 3
 
@@ -78,6 +80,7 @@ void rtw89_chanctx_work(struct work_struct *work);
 void rtw89_queue_chanctx_work(struct rtw89_dev *rtwdev);
 void rtw89_queue_chanctx_change(struct rtw89_dev *rtwdev,
 				enum rtw89_chanctx_changes change);
+void rtw89_chanctx_track(struct rtw89_dev *rtwdev);
 int rtw89_chanctx_ops_add(struct rtw89_dev *rtwdev,
 			  struct ieee80211_chanctx_conf *ctx);
 void rtw89_chanctx_ops_remove(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index a91011e7b05e..06dd9d105e38 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2722,6 +2722,7 @@ static void rtw89_track_work(struct work_struct *work)
 	rtw89_phy_antdiv_track(rtwdev);
 	rtw89_phy_ul_tb_ctrl_track(rtwdev);
 	rtw89_tas_track(rtwdev);
+	rtw89_chanctx_track(rtwdev);
 
 	if (rtwdev->lps_enabled && !rtwdev->btc.lps)
 		rtw89_enter_lps_track(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index eb185b3ffa3c..82291d9599a5 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3789,6 +3789,7 @@ struct rtw89_chanctx_cfg {
 
 enum rtw89_chanctx_changes {
 	RTW89_CHANCTX_REMOTE_STA_CHANGE,
+	RTW89_CHANCTX_BCN_OFFSET_CHANGE,
 
 	NUM_OF_RTW89_CHANCTX_CHANGES,
 	RTW89_CHANCTX_CHANGE_DFLT = NUM_OF_RTW89_CHANCTX_CHANGES,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index b034e4caed91..f965e2423447 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2931,6 +2931,11 @@ static inline void RTW89_SET_FWCMD_ADD_MCC_COURTESY_TARGET(void *cmd, u32 val)
 	le32p_replace_bits((__le32 *)cmd + 3, val, GENMASK(23, 16));
 }
 
+enum rtw89_fw_mcc_old_group_actions {
+	RTW89_FW_MCC_OLD_GROUP_ACT_NONE = 0,
+	RTW89_FW_MCC_OLD_GROUP_ACT_REPLACE = 1,
+};
+
 struct rtw89_fw_mcc_start_req {
 	u32 group: 2;
 	u32 btc_in_group: 1;
-- 
2.25.1

