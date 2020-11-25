Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EBB2C38CD
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Nov 2020 06:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgKYFk1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Nov 2020 00:40:27 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:45835 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgKYFkZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Nov 2020 00:40:25 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AP5eINR1026142, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AP5eINR1026142
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 25 Nov 2020 13:40:18 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Wed, 25 Nov 2020 13:40:18 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <yhchuang@realtek.com>, <ku920601@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 07/10] rtw88: coex: add function to avoid cck lock
Date:   Wed, 25 Nov 2020 13:38:58 +0800
Message-ID: <20201125053901.29678-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201125053901.29678-1-pkshih@realtek.com>
References: <20201125053901.29678-1-pkshih@realtek.com>
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

Some AP will not follow the power save request, or it cannot stop
transmission until its queue is empty. It may bring the decreasing of
data rate.

WLAN firmware will count is the AP still leaked packet after power save
handshake was done or not to enable WLAN slot extend mechanism.

The extend WLAN slot mechanism will extend the WLAN slot after power save
handshake, 5 ms per times, maximum is 5 times to received the leaked packet
to avoid the rate lower down.

And if the transmission was already locked at CCK rate.
The extended WLAN slot can also increase the opportunity that we can
received the CCK's long packet and be released from CCK rate.

While BT multi-link status was finished, there is possible that it still
has some packet remained for seconds. Add a timer to remain the multi-link
mechanism to protect WLAN Rx.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 171 +++++++++++++++++-----
 drivers/net/wireless/realtek/rtw88/coex.h |   3 +
 drivers/net/wireless/realtek/rtw88/main.c |   5 +
 drivers/net/wireless/realtek/rtw88/main.h |  10 ++
 4 files changed, 155 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index fc96641dd133..eab5529e6764 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -109,25 +109,73 @@ static void rtw_coex_limited_wl(struct rtw_dev *rtwdev)
 	rtw_coex_limited_tx(rtwdev, tx_limit, tx_agg_ctrl);
 }
 
-static void rtw_coex_wl_ccklock_action(struct rtw_dev *rtwdev)
+static bool rtw_coex_freerun_check(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	u8 bt_rssi;
+	u8 ant_distance = 10;
+
+	if (coex_stat->bt_disabled)
+		return false;
+
+	if (efuse->share_ant || ant_distance <= 5 || !coex_stat->wl_gl_busy)
+		return false;
+
+	if (ant_distance >= 40 || coex_stat->bt_hid_pair_num >= 2)
+		return true;
+
+	/* ant_distance = 5 ~ 40  */
+	if (COEX_RSSI_HIGH(coex_dm->wl_rssi_state[1]) &&
+	    COEX_RSSI_HIGH(coex_dm->bt_rssi_state[0]))
+		return true;
+
+	if (coex_stat->wl_tput_dir == COEX_WL_TPUT_TX)
+		bt_rssi = coex_dm->bt_rssi_state[0];
+	else
+		bt_rssi = coex_dm->bt_rssi_state[1];
+
+	if (COEX_RSSI_HIGH(coex_dm->wl_rssi_state[3]) &&
+	    COEX_RSSI_HIGH(bt_rssi) &&
+	    coex_stat->cnt_wl[COEX_CNT_WL_SCANAP] <= 5)
+		return true;
+
+	return false;
+}
+
+static void rtw_coex_wl_slot_extend(struct rtw_dev *rtwdev, bool enable)
 {
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	u8 para[6] = {0};
 
+	para[0] = COEX_H2C69_WL_LEAKAP;
+	para[1] = PARA1_H2C69_DIS_5MS;
+
+	if (enable)
+		para[1] = PARA1_H2C69_EN_5MS;
+	else
+		coex_stat->cnt_wl[COEX_CNT_WL_5MS_NOEXTEND] = 0;
+
+	coex_stat->wl_slot_extend = enable;
+	rtw_fw_bt_wifi_control(rtwdev, para[0], &para[1]);
+}
+
+static void rtw_coex_wl_ccklock_action(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+
 	if (coex->manual_control || coex->stop_dm)
 		return;
 
-	para[0] = COEX_H2C69_WL_LEAKAP;
 
 	if (coex_stat->tdma_timer_base == 3 && coex_stat->wl_slot_extend) {
 		rtw_dbg(rtwdev, RTW_DBG_COEX,
 			"[BTCoex], set h2c 0x69 opcode 12 to turn off 5ms WL slot extend!!\n");
-
-		para[1] = PARA1_H2C69_DIS_5MS; /* disable 5ms extend */
-		rtw_fw_bt_wifi_control(rtwdev, para[0], &para[1]);
-		coex_stat->wl_slot_extend = false;
-		coex_stat->cnt_wl[COEX_CNT_WL_5MS_NOEXTEND] = 0;
+		rtw_coex_wl_slot_extend(rtwdev, false);
 		return;
 	}
 
@@ -145,19 +193,13 @@ static void rtw_coex_wl_ccklock_action(struct rtw_dev *rtwdev)
 		if (coex_stat->cnt_wl[COEX_CNT_WL_5MS_NOEXTEND] == 7) {
 			rtw_dbg(rtwdev, RTW_DBG_COEX,
 				"[BTCoex], set h2c 0x69 opcode 12 to turn off 5ms WL slot extend!!\n");
-
-			para[1] = PARA1_H2C69_DIS_5MS;
-			rtw_fw_bt_wifi_control(rtwdev, para[0], &para[1]);
-			coex_stat->wl_slot_extend = false;
-			coex_stat->cnt_wl[COEX_CNT_WL_5MS_NOEXTEND] = 0;
+			rtw_coex_wl_slot_extend(rtwdev, false);
 		}
 	} else if (!coex_stat->wl_slot_extend && coex_stat->wl_cck_lock) {
 		rtw_dbg(rtwdev, RTW_DBG_COEX,
 			"[BTCoex], set h2c 0x69 opcode 12 to turn on 5ms WL slot extend!!\n");
 
-		para[1] = PARA1_H2C69_EN_5MS;
-		rtw_fw_bt_wifi_control(rtwdev, para[0], &para[1]);
-		coex_stat->wl_slot_extend = true;
+		rtw_coex_wl_slot_extend(rtwdev, true);
 	}
 }
 
@@ -165,11 +207,48 @@ static void rtw_coex_wl_ccklock_detect(struct rtw_dev *rtwdev)
 {
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
 
-	/* TODO: wait for rx_rate_change_notify implement */
-	coex_stat->wl_cck_lock = false;
-	coex_stat->wl_cck_lock_pre = false;
-	coex_stat->wl_cck_lock_ever = false;
+	bool is_cck_lock_rate = false;
+
+	if (coex_dm->bt_status == COEX_BTSTATUS_INQ_PAGE ||
+	    coex_stat->bt_setup_link) {
+		coex_stat->wl_cck_lock = false;
+		coex_stat->wl_cck_lock_pre = false;
+		return;
+	}
+
+	if (coex_stat->wl_rx_rate <= COEX_CCK_2 ||
+	    coex_stat->wl_rts_rx_rate <= COEX_CCK_2)
+		is_cck_lock_rate = true;
+
+	if (coex_stat->wl_connected && coex_stat->wl_gl_busy &&
+	    COEX_RSSI_HIGH(coex_dm->wl_rssi_state[3]) &&
+	    (coex_dm->bt_status == COEX_BTSTATUS_ACL_BUSY ||
+	     coex_dm->bt_status == COEX_BTSTATUS_ACL_SCO_BUSY ||
+	     coex_dm->bt_status == COEX_BTSTATUS_SCO_BUSY)) {
+		if (is_cck_lock_rate) {
+			coex_stat->wl_cck_lock = true;
+
+			rtw_dbg(rtwdev, RTW_DBG_COEX,
+				"[BTCoex], cck locking...\n");
+
+		} else {
+			coex_stat->wl_cck_lock = false;
+
+			rtw_dbg(rtwdev, RTW_DBG_COEX,
+				"[BTCoex], cck unlock...\n");
+		}
+	} else {
+		coex_stat->wl_cck_lock = false;
+	}
+
+	/* CCK lock identification */
+	if (coex_stat->wl_cck_lock && !coex_stat->wl_cck_lock_pre)
+		ieee80211_queue_delayed_work(rtwdev->hw, &coex->wl_ccklock_work,
+					     3 * HZ);
+
+	coex_stat->wl_cck_lock_pre = coex_stat->wl_cck_lock;
 }
 
 static void rtw_coex_wl_noisy_detect(struct rtw_dev *rtwdev)
@@ -178,11 +257,12 @@ static void rtw_coex_wl_noisy_detect(struct rtw_dev *rtwdev)
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
 	u32 cnt_cck;
+	bool wl_cck_lock = false;
 
 	/* wifi noisy environment identification */
 	cnt_cck = dm_info->cck_ok_cnt + dm_info->cck_err_cnt;
 
-	if (!coex_stat->wl_gl_busy) {
+	if (!coex_stat->wl_gl_busy && !wl_cck_lock) {
 		if (cnt_cck > 250) {
 			if (coex_stat->cnt_wl[COEX_CNT_WL_NOISY2] < 5)
 				coex_stat->cnt_wl[COEX_CNT_WL_NOISY2]++;
@@ -2177,19 +2257,8 @@ static void rtw_coex_action_wl_connected(struct rtw_dev *rtwdev)
 {
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
-	struct rtw_coex_dm *coex_dm = &coex->dm;
-	struct rtw_efuse *efuse = &rtwdev->efuse;
-	bool freerun_check = false;
 	u8 algorithm;
 
-	/* Non-Shared-Ant */
-	if (!efuse->share_ant && coex_stat->wl_gl_busy &&
-	    COEX_RSSI_HIGH(coex_dm->wl_rssi_state[3]) &&
-	    COEX_RSSI_HIGH(coex_dm->bt_rssi_state[0])) {
-		rtw_coex_action_freerun(rtwdev);
-		return;
-	}
-
 	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
 
 	algorithm = rtw_coex_algorithm(rtwdev);
@@ -2199,13 +2268,13 @@ static void rtw_coex_action_wl_connected(struct rtw_dev *rtwdev)
 		rtw_coex_action_bt_hfp(rtwdev);
 		break;
 	case COEX_ALGO_HID:
-		if (freerun_check)
+		if (rtw_coex_freerun_check(rtwdev))
 			rtw_coex_action_freerun(rtwdev);
 		else
 			rtw_coex_action_bt_hid(rtwdev);
 		break;
 	case COEX_ALGO_A2DP:
-		if (freerun_check)
+		if (rtw_coex_freerun_check(rtwdev))
 			rtw_coex_action_freerun(rtwdev);
 		else if (coex_stat->bt_a2dp_sink)
 			rtw_coex_action_bt_a2dpsink(rtwdev);
@@ -2216,7 +2285,7 @@ static void rtw_coex_action_wl_connected(struct rtw_dev *rtwdev)
 		rtw_coex_action_bt_pan(rtwdev);
 		break;
 	case COEX_ALGO_A2DP_HID:
-		if (freerun_check)
+		if (rtw_coex_freerun_check(rtwdev))
 			rtw_coex_action_freerun(rtwdev);
 		else
 			rtw_coex_action_bt_a2dp_hid(rtwdev);
@@ -2372,6 +2441,8 @@ static void rtw_coex_init_coex_var(struct rtw_dev *rtwdev)
 		coex_dm->wl_rssi_state[i] = COEX_RSSI_STATE_LOW;
 
 	coex_stat->wl_coex_mode = COEX_WLINK_MAX;
+	coex_stat->wl_rx_rate = DESC_RATE5_5M;
+	coex_stat->wl_rts_rx_rate = DESC_RATE5_5M;
 }
 
 static void __rtw_coex_init_hw_config(struct rtw_dev *rtwdev, bool wifi_only)
@@ -2855,6 +2926,16 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 		coex_stat->cnt_bt[COEX_CNT_BT_ROLESWITCH]++;
 
 	coex_stat->bt_multi_link = ((coex_stat->bt_info_hb1 & BIT(7)) == BIT(7));
+	/* for multi_link = 0 but bt pkt remain exist */
+	/* Use PS-TDMA to protect WL RX */
+	if (!coex_stat->bt_multi_link && coex_stat->bt_multi_link_pre) {
+		coex_stat->bt_multi_link_remain = true;
+		ieee80211_queue_delayed_work(rtwdev->hw,
+					     &coex->bt_multi_link_remain_work,
+					     3 * HZ);
+	}
+	coex_stat->bt_multi_link_pre = coex_stat->bt_multi_link;
+
 	/* resend wifi info to bt, it is reset and lost the info */
 	if (coex_stat->bt_info_hb1 & BIT(1)) {
 		rtw_dbg(rtwdev, RTW_DBG_COEX,
@@ -3009,6 +3090,28 @@ void rtw_coex_wl_connecting_work(struct work_struct *work)
 	mutex_unlock(&rtwdev->mutex);
 }
 
+void rtw_coex_bt_multi_link_remain_work(struct work_struct *work)
+{
+	struct rtw_dev *rtwdev = container_of(work, struct rtw_dev,
+		coex.bt_multi_link_remain_work.work);
+	struct rtw_coex_stat *coex_stat = &rtwdev->coex.stat;
+
+	mutex_lock(&rtwdev->mutex);
+	coex_stat->bt_multi_link_remain = false;
+	mutex_unlock(&rtwdev->mutex);
+}
+
+void rtw_coex_wl_ccklock_work(struct work_struct *work)
+{
+	struct rtw_dev *rtwdev = container_of(work, struct rtw_dev,
+					      coex.wl_ccklock_work.work);
+	struct rtw_coex_stat *coex_stat = &rtwdev->coex.stat;
+
+	mutex_lock(&rtwdev->mutex);
+	coex_stat->wl_cck_lock = false;
+	mutex_unlock(&rtwdev->mutex);
+}
+
 #ifdef CONFIG_RTW88_DEBUGFS
 #define INFO_SIZE	80
 
diff --git a/drivers/net/wireless/realtek/rtw88/coex.h b/drivers/net/wireless/realtek/rtw88/coex.h
index 73f1bbc68490..c4898132702f 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.h
+++ b/drivers/net/wireless/realtek/rtw88/coex.h
@@ -5,6 +5,7 @@
 #ifndef __RTW_COEX_H__
 #define __RTW_COEX_H__
 
+#define COEX_CCK_2	0x1
 #define COEX_RESP_ACK_BY_WL_FW	0x1
 #define COEX_REQUEST_TIMEOUT	msecs_to_jiffies(10)
 
@@ -385,6 +386,8 @@ void rtw_coex_defreeze_work(struct work_struct *work);
 void rtw_coex_wl_remain_work(struct work_struct *work);
 void rtw_coex_bt_remain_work(struct work_struct *work);
 void rtw_coex_wl_connecting_work(struct work_struct *work);
+void rtw_coex_bt_multi_link_remain_work(struct work_struct *work);
+void rtw_coex_wl_ccklock_work(struct work_struct *work);
 
 void rtw_coex_power_on_setting(struct rtw_dev *rtwdev);
 void rtw_coex_init_hw_config(struct rtw_dev *rtwdev, bool wifi_only);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 6290ecc97f5b..47969a6f957c 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1154,6 +1154,8 @@ void rtw_core_stop(struct rtw_dev *rtwdev)
 	cancel_delayed_work_sync(&coex->wl_remain_work);
 	cancel_delayed_work_sync(&coex->bt_remain_work);
 	cancel_delayed_work_sync(&coex->wl_connecting_work);
+	cancel_delayed_work_sync(&coex->bt_multi_link_remain_work);
+	cancel_delayed_work_sync(&coex->wl_ccklock_work);
 
 	mutex_lock(&rtwdev->mutex);
 
@@ -1660,6 +1662,9 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 	INIT_DELAYED_WORK(&coex->wl_remain_work, rtw_coex_wl_remain_work);
 	INIT_DELAYED_WORK(&coex->bt_remain_work, rtw_coex_bt_remain_work);
 	INIT_DELAYED_WORK(&coex->wl_connecting_work, rtw_coex_wl_connecting_work);
+	INIT_DELAYED_WORK(&coex->bt_multi_link_remain_work,
+			  rtw_coex_bt_multi_link_remain_work);
+	INIT_DELAYED_WORK(&coex->wl_ccklock_work, rtw_coex_wl_ccklock_work);
 	INIT_WORK(&rtwdev->c2h_work, rtw_c2h_work);
 	INIT_WORK(&rtwdev->fw_recovery_work, rtw_fw_recovery_work);
 	INIT_WORK(&rtwdev->ba_work, rtw_txq_ba_work);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index af5f2024251b..ac6d78507904 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1220,6 +1220,7 @@ enum rtw_coex_bt_state_cnt {
 };
 
 enum rtw_coex_wl_state_cnt {
+	COEX_CNT_WL_SCANAP,
 	COEX_CNT_WL_CONNPKT,
 	COEX_CNT_WL_COEXRUN,
 	COEX_CNT_WL_NOISY0,
@@ -1305,6 +1306,8 @@ struct rtw_coex_stat {
 	bool bt_fix_2M;
 	bool bt_setup_link;
 	bool bt_multi_link;
+	bool bt_multi_link_pre;
+	bool bt_multi_link_remain;
 	bool bt_a2dp_sink;
 	bool bt_a2dp_active;
 	bool bt_reenable;
@@ -1363,7 +1366,11 @@ struct rtw_coex_stat {
 	u8 wl_noisy_level;
 	u8 wl_fw_dbg_info[10];
 	u8 wl_fw_dbg_info_pre[10];
+	u8 wl_rx_rate;
+	u8 wl_tx_rate;
+	u8 wl_rts_rx_rate;
 	u8 wl_coex_mode;
+	u8 wl_iot_peer;
 	u8 ampdu_max_time;
 	u8 wl_tput_dir;
 
@@ -1406,6 +1413,9 @@ struct rtw_coex {
 	struct delayed_work wl_remain_work;
 	struct delayed_work bt_remain_work;
 	struct delayed_work wl_connecting_work;
+	struct delayed_work bt_multi_link_remain_work;
+	struct delayed_work wl_ccklock_work;
+
 };
 
 #define DPK_RF_REG_NUM 7
-- 
2.21.0

