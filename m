Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78672AB301
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Nov 2020 10:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbgKIJAW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Nov 2020 04:00:22 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:60052 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgKIJAT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Nov 2020 04:00:19 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0A990CmY4021869, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0A990CmY4021869
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 9 Nov 2020 17:00:12 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Mon, 9 Nov 2020 17:00:11 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 08/11] rtw88: coex: change the parameter for A2DP when WLAN connecting
Date:   Mon, 9 Nov 2020 16:59:06 +0800
Message-ID: <20201109085909.9143-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201109085909.9143-1-pkshih@realtek.com>
References: <20201109085909.9143-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

The original mechanism may cause A2DP glitch during WiFi connecting AP.
Because the original TDMA may decrease too much A2DP slot.
This patch add a timer and variable to let the case A2DP + WL_Connecting
performed more well.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 26 ++++++++++++++++++++---
 drivers/net/wireless/realtek/rtw88/coex.h |  1 +
 drivers/net/wireless/realtek/rtw88/main.c |  2 ++
 drivers/net/wireless/realtek/rtw88/main.h |  2 ++
 4 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index c47771f7020a..777955d5ed1b 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -1544,10 +1544,10 @@ static void rtw_coex_action_bt_a2dp(struct rtw_dev *rtwdev)
 		else
 			table_case = 9;
 
-		if (coex_stat->wl_gl_busy)
-			tdma_case = 13;
-		else
+		if (coex_stat->wl_connecting || !coex_stat->wl_gl_busy)
 			tdma_case = 14;
+		else
+			tdma_case = 13;
 	} else {
 		/* Non-Shared-Ant */
 		table_case = 112;
@@ -2270,6 +2270,11 @@ void rtw_coex_connect_notify(struct rtw_dev *rtwdev, u8 type)
 	} else if (type == COEX_ASSOCIATE_START) {
 		coex_stat->wl_hi_pri_task1 = true;
 		coex_stat->cnt_wl[COEX_CNT_WL_CONNPKT] = 2;
+		coex_stat->wl_connecting = true;
+		ieee80211_queue_delayed_work(rtwdev->hw,
+					     &coex->wl_connecting_work, 2 * HZ);
+
+		rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], 2G start\n");
 
 		/* Force antenna setup for no scan result issue */
 		rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_2G);
@@ -2286,6 +2291,8 @@ void rtw_coex_connect_notify(struct rtw_dev *rtwdev, u8 type)
 		coex_stat->wl_hi_pri_task1 = false;
 		coex->freeze = false;
 
+		rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], 2G finish\n");
+
 		rtw_coex_run_coex(rtwdev, COEX_RSN_2GCONFINISH);
 	}
 }
@@ -2633,6 +2640,19 @@ void rtw_coex_bt_remain_work(struct work_struct *work)
 	mutex_unlock(&rtwdev->mutex);
 }
 
+void rtw_coex_wl_connecting_work(struct work_struct *work)
+{
+	struct rtw_dev *rtwdev = container_of(work, struct rtw_dev,
+					      coex.wl_connecting_work.work);
+	struct rtw_coex_stat *coex_stat = &rtwdev->coex.stat;
+
+	mutex_lock(&rtwdev->mutex);
+	coex_stat->wl_connecting = false;
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], WL connecting stop!!\n");
+	rtw_coex_run_coex(rtwdev, COEX_RSN_WLSTATUS);
+	mutex_unlock(&rtwdev->mutex);
+}
+
 #ifdef CONFIG_RTW88_DEBUGFS
 #define INFO_SIZE	80
 
diff --git a/drivers/net/wireless/realtek/rtw88/coex.h b/drivers/net/wireless/realtek/rtw88/coex.h
index e0d0be3f0dcf..712a3adb5d16 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.h
+++ b/drivers/net/wireless/realtek/rtw88/coex.h
@@ -366,6 +366,7 @@ void rtw_coex_bt_reenable_work(struct work_struct *work);
 void rtw_coex_defreeze_work(struct work_struct *work);
 void rtw_coex_wl_remain_work(struct work_struct *work);
 void rtw_coex_bt_remain_work(struct work_struct *work);
+void rtw_coex_wl_connecting_work(struct work_struct *work);
 
 void rtw_coex_power_on_setting(struct rtw_dev *rtwdev);
 void rtw_coex_init_hw_config(struct rtw_dev *rtwdev, bool wifi_only);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 670202e3ff9e..6290ecc97f5b 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1153,6 +1153,7 @@ void rtw_core_stop(struct rtw_dev *rtwdev)
 	cancel_delayed_work_sync(&coex->defreeze_work);
 	cancel_delayed_work_sync(&coex->wl_remain_work);
 	cancel_delayed_work_sync(&coex->bt_remain_work);
+	cancel_delayed_work_sync(&coex->wl_connecting_work);
 
 	mutex_lock(&rtwdev->mutex);
 
@@ -1658,6 +1659,7 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 	INIT_DELAYED_WORK(&coex->defreeze_work, rtw_coex_defreeze_work);
 	INIT_DELAYED_WORK(&coex->wl_remain_work, rtw_coex_wl_remain_work);
 	INIT_DELAYED_WORK(&coex->bt_remain_work, rtw_coex_bt_remain_work);
+	INIT_DELAYED_WORK(&coex->wl_connecting_work, rtw_coex_wl_connecting_work);
 	INIT_WORK(&rtwdev->c2h_work, rtw_c2h_work);
 	INIT_WORK(&rtwdev->fw_recovery_work, rtw_fw_recovery_work);
 	INIT_WORK(&rtwdev->ba_work, rtw_txq_ba_work);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 97f75a99d0a4..a3a687a63734 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1329,6 +1329,7 @@ struct rtw_coex_stat {
 	bool wl_cck_lock;
 	bool wl_cck_lock_pre;
 	bool wl_cck_lock_ever;
+	bool wl_connecting;
 
 	u32 bt_supported_version;
 	u32 bt_supported_feature;
@@ -1398,6 +1399,7 @@ struct rtw_coex {
 	struct delayed_work defreeze_work;
 	struct delayed_work wl_remain_work;
 	struct delayed_work bt_remain_work;
+	struct delayed_work wl_connecting_work;
 };
 
 #define DPK_RF_REG_NUM 7
-- 
2.21.0

