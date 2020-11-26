Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A5B2C4D34
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Nov 2020 03:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733047AbgKZCMa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Nov 2020 21:12:30 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:60683 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732932AbgKZCM3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Nov 2020 21:12:29 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AQ2CLO30030358, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AQ2CLO30030358
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 26 Nov 2020 10:12:21 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Thu, 26 Nov 2020 10:12:21 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <tony0620emma@gmail.com>, <ku920601@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 09/10] rtw88: coex: upgrade coexistence A2DP mechanism
Date:   Thu, 26 Nov 2020 10:10:58 +0800
Message-ID: <20201126021059.11981-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201126021059.11981-1-pkshih@realtek.com>
References: <20201126021059.11981-1-pkshih@realtek.com>
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

Add modifications for A2DP interoperability issue of TWS earphones.
Some TWS earphones has low buffer size, so it's necessary to reduce
the slot period to let it get data more frequently.
(e.g. use 4-slot to replace the original 2-slot method).

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
  * fix "set but not used" warnings reported by kernel test robot.
    I move some variables to PATCH 10/10 because they are used there, and
    delete others that are not used.
---
 drivers/net/wireless/realtek/rtw88/coex.c     | 255 +++++++++++-------
 drivers/net/wireless/realtek/rtw88/main.h     |   1 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |   1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |   1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |   1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |   1 +
 6 files changed, 161 insertions(+), 99 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index f1f12ff0797b..4d921e9d8956 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -319,7 +319,7 @@ static void rtw_coex_tdma_timer_base(struct rtw_dev *rtwdev, u8 type)
 	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], tbtt_interval = %d\n",
 		tbtt_interval);
 
-	if (type == TDMA_TIMER_TYPE_4SLOT) {
+	if (type == TDMA_TIMER_TYPE_4SLOT && tbtt_interval < 120) {
 		para[1] = PARA1_H2C69_TDMA_4SLOT; /* 4-slot */
 	} else if (tbtt_interval < 80 && tbtt_interval > 0) {
 		times = 100 / tbtt_interval;
@@ -762,6 +762,7 @@ static void rtw_coex_update_bt_link_info(struct rtw_dev *rtwdev)
 		coex_dm->bt_status = COEX_BTSTATUS_INQ_PAGE;
 	} else if (!(coex_stat->bt_info_lb2 & COEX_INFO_CONNECTION)) {
 		coex_dm->bt_status = COEX_BTSTATUS_NCON_IDLE;
+		coex_stat->bt_multi_link_remain = false;
 	} else if (coex_stat->bt_info_lb2 == COEX_INFO_CONNECTION) {
 		coex_dm->bt_status = COEX_BTSTATUS_CON_IDLE;
 	} else if ((coex_stat->bt_info_lb2 & COEX_INFO_SCO_ESCO) ||
@@ -870,7 +871,7 @@ static void rtw_coex_set_rf_para(struct rtw_dev *rtwdev,
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	u8 offset = 0;
 
-	if (coex->freerun && coex_stat->wl_noisy_level <= 1)
+	if (coex->freerun && coex_stat->cnt_wl[COEX_CNT_WL_SCANAP] <= 5)
 		offset = 3;
 
 	rtw_coex_set_wl_tx_power(rtwdev, para.wl_pwr_dec_lvl);
@@ -1102,11 +1103,6 @@ static void rtw_coex_tdma(struct rtw_dev *rtwdev, bool force, u32 tcase)
 
 		return;
 	}
-
-	/* enable TBTT interrupt */
-	if (turn_on)
-		rtw_write8_set(rtwdev, REG_BCN_CTRL, BIT_EN_BCN_FUNCTION);
-
 	wl_busy = test_bit(RTW_FLAG_BUSY_TRAFFIC, rtwdev->flags);
 
 	if ((coex_stat->bt_a2dp_exist &&
@@ -1116,6 +1112,10 @@ static void rtw_coex_tdma(struct rtw_dev *rtwdev, bool force, u32 tcase)
 	else
 		rtw_coex_write_scbd(rtwdev, COEX_SCBD_TDMA, true);
 
+	/* update pre state */
+	coex_dm->cur_ps_tdma_on = turn_on;
+	coex_dm->cur_ps_tdma = type;
+
 	if (efuse->share_ant) {
 		if (type < chip->tdma_sant_num)
 			rtw_coex_set_tdma(rtwdev,
@@ -1135,9 +1135,6 @@ static void rtw_coex_tdma(struct rtw_dev *rtwdev, bool force, u32 tcase)
 					  chip->tdma_nsant[n].para[4]);
 	}
 
-	/* update pre state */
-	coex_dm->cur_ps_tdma_on = turn_on;
-	coex_dm->cur_ps_tdma = type;
 
 	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], coex tdma type(%s, %d)\n",
 		turn_on ? "on" : "off", type);
@@ -1530,6 +1527,8 @@ static void rtw_coex_action_bt_whql_test(struct rtw_dev *rtwdev)
 
 static void rtw_coex_action_bt_relink(struct rtw_dev *rtwdev)
 {
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
@@ -1539,13 +1538,24 @@ static void rtw_coex_action_bt_relink(struct rtw_dev *rtwdev)
 	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
 	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 
-	if (efuse->share_ant) {
-		/* Shared-Ant */
-		table_case = 1;
-		tdma_case = 0;
-	} else {
-		/* Non-Shared-Ant */
-		table_case = 100;
+	if (efuse->share_ant) { /* Shared-Ant */
+		if (coex_stat->wl_gl_busy) {
+			table_case = 26;
+			if (coex_stat->bt_hid_exist &&
+			    coex_stat->bt_profile_num == 1) {
+				tdma_case = 20;
+			} else {
+				tdma_case = 20;
+			}
+		} else {
+			table_case = 1;
+			tdma_case = 0;
+		}
+	} else { /* Non-Shared-Ant */
+		if (coex_stat->wl_gl_busy)
+			table_case = 115;
+		else
+			table_case = 100;
 		tdma_case = 100;
 	}
 
@@ -1569,7 +1579,8 @@ static void rtw_coex_action_bt_idle(struct rtw_dev *rtwdev)
 	if (coex_rfe->ant_switch_with_bt &&
 	    coex_dm->bt_status == COEX_BTSTATUS_NCON_IDLE) {
 		if (efuse->share_ant &&
-		    COEX_RSSI_HIGH(coex_dm->wl_rssi_state[1])) {
+		    COEX_RSSI_HIGH(coex_dm->wl_rssi_state[3]) &&
+		    coex_stat->wl_gl_busy) {
 			table_case = 0;
 			tdma_case = 0;
 		} else if (!efuse->share_ant) {
@@ -1580,9 +1591,7 @@ static void rtw_coex_action_bt_idle(struct rtw_dev *rtwdev)
 
 	if (table_case != 0xff && tdma_case != 0xff) {
 		rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G_FREERUN);
-		rtw_coex_table(rtwdev, false, table_case);
-		rtw_coex_tdma(rtwdev, false, tdma_case);
-		return;
+		goto exit;
 	}
 
 	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
@@ -1593,8 +1602,12 @@ static void rtw_coex_action_bt_idle(struct rtw_dev *rtwdev)
 			table_case = 10;
 			tdma_case = 3;
 		} else if (coex_dm->bt_status == COEX_BTSTATUS_NCON_IDLE) {
-			table_case = 6;
-			tdma_case = 7;
+			table_case = 11;
+
+			if (coex_stat->lo_pri_rx + coex_stat->lo_pri_tx > 250)
+				tdma_case = 17;
+			else
+				tdma_case = 7;
 		} else {
 			table_case = 12;
 			tdma_case = 7;
@@ -1614,6 +1627,7 @@ static void rtw_coex_action_bt_idle(struct rtw_dev *rtwdev)
 		}
 	}
 
+exit:
 	rtw_coex_table(rtwdev, false, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
@@ -1642,6 +1656,7 @@ static void rtw_coex_action_bt_inquiry(struct rtw_dev *rtwdev)
 			rtw_dbg(rtwdev, RTW_DBG_COEX,
 				"[BTCoex], bt inq/page +  wifi hi-pri task\n");
 			table_case = 15;
+
 			if (coex_stat->bt_profile_num > 0)
 				tdma_case = 10;
 			else if (coex_stat->wl_hi_pri_task1)
@@ -1651,6 +1666,8 @@ static void rtw_coex_action_bt_inquiry(struct rtw_dev *rtwdev)
 			else
 				tdma_case = 9;
 		} else if (coex_stat->wl_gl_busy) {
+			rtw_dbg(rtwdev, RTW_DBG_COEX,
+				"[BTCoex], bt inq/page + wifi busy\n");
 			if (coex_stat->bt_profile_num == 0) {
 				table_case = 12;
 				tdma_case = 18;
@@ -1680,23 +1697,25 @@ static void rtw_coex_action_bt_inquiry(struct rtw_dev *rtwdev)
 		if (wl_hi_pri) {
 			rtw_dbg(rtwdev, RTW_DBG_COEX,
 				"[BTCoex], bt inq/page +  wifi hi-pri task\n");
-			table_case = 113;
-			if (coex_stat->bt_a2dp_exist &&
-			    !coex_stat->bt_pan_exist)
-				tdma_case = 111;
+			table_case = 114;
+
+			if (coex_stat->bt_profile_num > 0)
+				tdma_case = 110;
 			else if (coex_stat->wl_hi_pri_task1)
 				tdma_case = 106;
 			else if (!coex_stat->bt_page)
 				tdma_case = 108;
 			else
 				tdma_case = 109;
-		} else if (coex_stat->wl_gl_busy) {
+		}  else if (coex_stat->wl_gl_busy) {
+			rtw_dbg(rtwdev, RTW_DBG_COEX,
+				"[BTCoex], bt inq/page + wifi busy\n");
 			table_case = 114;
 			tdma_case = 121;
 		} else if (coex_stat->wl_connected) {
 			rtw_dbg(rtwdev, RTW_DBG_COEX,
 				"[BTCoex], bt inq/page +  wifi connected\n");
-			table_case = 100;
+			table_case = 101;
 			tdma_case = 100;
 		} else {
 			rtw_dbg(rtwdev, RTW_DBG_COEX,
@@ -1756,63 +1775,66 @@ static void rtw_coex_action_bt_hid(struct rtw_dev *rtwdev)
 	struct rtw_efuse *efuse = &rtwdev->efuse;
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
-	u32 wl_bw;
 	u32 slot_type = 0;
+	bool bt_multi_link_remain = false;
 
 	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
 	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
 	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 
-	wl_bw = rtwdev->hal.current_band_width;
-
 	if (efuse->share_ant) {
 		/* Shared-Ant */
 		if (coex_stat->bt_ble_exist) {
 			/* RCU */
-			if (!coex_stat->wl_gl_busy)
-				table_case = 14;
-			else
-				table_case = 15;
-
-			if (coex_stat->bt_a2dp_active || wl_bw == 0)
-				tdma_case = 18;
-			else if (coex_stat->wl_gl_busy)
-				tdma_case = 8;
-			else
-				tdma_case = 4;
+			if (coex_stat->cnt_wl[COEX_CNT_WL_SCANAP] > 5) {
+				table_case = 26;
+				tdma_case = 2;
+			} else {
+				table_case = 27;
+				tdma_case = 9;
+			}
 		} else {
-			if (coex_stat->bt_a2dp_active || wl_bw == 0) {
-				table_case = 8;
-				tdma_case = 4;
+			/* Legacy HID  */
+			if (coex_stat->bt_profile_num == 1 &&
+			    (coex_stat->bt_multi_link ||
+			    (coex_stat->lo_pri_rx +
+			     coex_stat->lo_pri_tx > 360) ||
+			     coex_stat->bt_slave ||
+			     bt_multi_link_remain)) {
+				slot_type = TDMA_4SLOT;
+				table_case = 12;
+				tdma_case = 20;
+			} else if (coex_stat->bt_a2dp_active) {
+				table_case = 9;
+				tdma_case = 18;
+			} else if (coex_stat->bt_418_hid_exist &&
+				   coex_stat->wl_gl_busy) {
+				slot_type = TDMA_4SLOT;
+				table_case = 9;
+				tdma_case = 24;
+			} else if (coex_stat->bt_ble_hid_exist &&
+				   coex_stat->wl_gl_busy) {
+				table_case = 32;
+				tdma_case = 9;
 			} else {
-				/* for 4/18 HID */
-				if (coex_stat->bt_418_hid_exist &&
-				    coex_stat->wl_gl_busy) {
-					table_case = 12;
-					tdma_case = 4;
-				} else if (coex_stat->bt_ble_hid_exist &&
-					   coex_stat->wl_gl_busy) {
-					table_case = 32;
-					tdma_case = 9;
-				} else {
-					table_case = 10;
-					tdma_case = 4;
-				}
+				table_case = 9;
+				tdma_case = 9;
 			}
 		}
 	} else {
 		/* Non-Shared-Ant */
-		if (coex_stat->bt_a2dp_active) {
-			table_case = 113;
-			tdma_case = 118;
-		} else if (coex_stat->bt_ble_exist) {
+		if (coex_stat->bt_ble_exist) {
 			/* BLE */
+			if (coex_stat->cnt_wl[COEX_CNT_WL_SCANAP] > 5) {
+				table_case = 121;
+				tdma_case = 102;
+			} else {
+				table_case = 122;
+				tdma_case = 109;
+			}
+		} else if (coex_stat->bt_a2dp_active) {
 			table_case = 113;
-
-			if (coex_stat->wl_gl_busy)
-				tdma_case = 106;
-			else
-				tdma_case = 104;
+			tdma_case = 118;
 		} else {
 			table_case = 113;
 			tdma_case = 104;
@@ -1838,12 +1860,12 @@ static void rtw_coex_action_bt_a2dp(struct rtw_dev *rtwdev)
 	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
 	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 
+	slot_type = TDMA_4SLOT;
+
 	if (efuse->share_ant) {
 		/* Shared-Ant */
-		slot_type = TDMA_4SLOT;
-
 		if (coex_stat->wl_gl_busy && coex_stat->wl_noisy_level == 0)
-			table_case = 11;
+			table_case = 12;
 		else
 			table_case = 9;
 
@@ -1926,7 +1948,7 @@ static void rtw_coex_action_bt_pan(struct rtw_dev *rtwdev)
 		if (coex_stat->wl_gl_busy)
 			tdma_case = 17;
 		else
-			tdma_case = 19;
+			tdma_case = 20;
 	} else {
 		/* Non-Shared-Ant */
 		table_case = 112;
@@ -1951,23 +1973,27 @@ static void rtw_coex_action_bt_a2dp_hid(struct rtw_dev *rtwdev)
 	u8 table_case, tdma_case;
 	u32 slot_type = 0;
 
+	slot_type = TDMA_4SLOT;
+
 	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
 	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
 	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 
 	if (efuse->share_ant) {
 		/* Shared-Ant */
-		slot_type = TDMA_4SLOT;
-
 		if (coex_stat->bt_ble_exist)
-			table_case = 26;
+			table_case = 26; /* for RCU */
 		else
 			table_case = 9;
 
-		if (coex_stat->wl_gl_busy)
-			tdma_case = 13;
-		else
+		if (coex_stat->wl_connecting || !coex_stat->wl_gl_busy) {
 			tdma_case = 14;
+		} else if (coex_stat->bt_418_hid_exist ||
+			   coex_stat->bt_ble_hid_exist) {
+			tdma_case = 23;
+		} else {
+			tdma_case = 13;
+		}
 	} else {
 		/* Non-Shared-Ant */
 		if (coex_stat->bt_ble_exist)
@@ -2204,8 +2230,7 @@ static void rtw_coex_action_wl_linkscan(struct rtw_dev *rtwdev)
 	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
 	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 
-	if (efuse->share_ant) {
-		/* Shared-Ant */
+	if (efuse->share_ant) { /* Shared-Ant */
 		if (coex_stat->bt_a2dp_exist) {
 			slot_type = TDMA_4SLOT;
 			table_case = 9;
@@ -2214,9 +2239,9 @@ static void rtw_coex_action_wl_linkscan(struct rtw_dev *rtwdev)
 			table_case = 9;
 			tdma_case = 7;
 		}
-	} else {
-		/* Non-Shared-Ant */
+	} else { /* Non-Shared-Ant */
 		if (coex_stat->bt_a2dp_exist) {
+			slot_type = TDMA_4SLOT;
 			table_case = 112;
 			tdma_case = 111;
 		} else {
@@ -2365,7 +2390,7 @@ static void rtw_coex_run_coex(struct rtw_dev *rtwdev, u8 reason)
 
 	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], WiFi is single-port 2G!!\n");
 	coex_stat->wl_coex_mode = COEX_WLINK_2G1PORT;
-	rtw_coex_write_scbd(rtwdev, COEX_SCBD_FIX2M, false);
+
 	if (coex_stat->bt_disabled) {
 		if (coex_stat->wl_connected && rf4ce_en)
 			rtw_coex_action_rf4ce(rtwdev);
@@ -2403,15 +2428,18 @@ static void rtw_coex_run_coex(struct rtw_dev *rtwdev, u8 reason)
 		goto exit;
 	}
 
-	if (coex_stat->wl_linkscan_proc) {
+	if (coex_stat->wl_linkscan_proc && !coex->freerun) {
 		rtw_coex_action_wl_linkscan(rtwdev);
 		goto exit;
 	}
 
-	if (coex_stat->wl_connected)
+	if (coex_stat->wl_connected) {
 		rtw_coex_action_wl_connected(rtwdev);
-	else
+		goto exit;
+	} else {
 		rtw_coex_action_wl_not_connected(rtwdev);
+		goto exit;
+	}
 
 exit:
 	rtw_coex_gnt_workaround(rtwdev, false, coex_stat->wl_coex_mode);
@@ -2579,6 +2607,7 @@ void rtw_coex_lps_notify(struct rtw_dev *rtwdev, u8 type)
 		} else {
 			/* for native ps */
 			rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE, false);
+			rtw_coex_write_scbd(rtwdev, COEX_SCBD_WLBUSY, false);
 
 			rtw_coex_run_coex(rtwdev, COEX_RSN_LPS);
 		}
@@ -2624,6 +2653,12 @@ void rtw_coex_scan_notify(struct rtw_dev *rtwdev, u8 type)
 		rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_2G);
 		rtw_coex_run_coex(rtwdev, COEX_RSN_2GSCANSTART);
 	} else {
+		coex_stat->cnt_wl[COEX_CNT_WL_SCANAP] = 30; /* To do */
+
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], SCAN FINISH notify (Scan-AP = %d)\n",
+			coex_stat->cnt_wl[COEX_CNT_WL_SCANAP]);
+
 		coex_stat->wl_hi_pri_task2 = false;
 		rtw_coex_run_coex(rtwdev, COEX_RSN_SCANFINISH);
 	}
@@ -2679,6 +2714,7 @@ void rtw_coex_connect_notify(struct rtw_dev *rtwdev, u8 type)
 		rtw_coex_run_coex(rtwdev, COEX_RSN_5GCONFINISH);
 	} else if (type == COEX_ASSOCIATE_START) {
 		coex_stat->wl_hi_pri_task1 = true;
+		coex_stat->wl_connecting = true;
 		coex_stat->cnt_wl[COEX_CNT_WL_CONNPKT] = 2;
 		coex_stat->wl_connecting = true;
 		ieee80211_queue_delayed_work(rtwdev->hw,
@@ -2700,6 +2736,7 @@ void rtw_coex_connect_notify(struct rtw_dev *rtwdev, u8 type)
 	} else {
 		coex_stat->wl_hi_pri_task1 = false;
 		coex->freeze = false;
+		coex_stat->wl_connecting = false;
 
 		rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s(): 2G finish\n",
 			__func__);
@@ -2710,6 +2747,7 @@ void rtw_coex_connect_notify(struct rtw_dev *rtwdev, u8 type)
 void rtw_coex_media_status_notify(struct rtw_dev *rtwdev, u8 type)
 {
 	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
 
 	if (coex->manual_control || coex->stop_dm)
 		return;
@@ -2724,6 +2762,8 @@ void rtw_coex_media_status_notify(struct rtw_dev *rtwdev, u8 type)
 	} else if (type == COEX_MEDIA_CONNECT) {
 		rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s(): 2G\n", __func__);
 
+		coex_stat->wl_connecting = false;
+
 		rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE, true);
 
 		/* Force antenna setup for no scan result issue */
@@ -2865,21 +2905,38 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 						     4 * HZ);
 	}
 	coex_stat->bt_acl_busy = ((coex_stat->bt_info_lb2 & BIT(3)) == BIT(3));
-	if (coex_stat->bt_info_lb2 & BIT(5)) {
-		if (coex_stat->bt_info_hb1 & BIT(0)) {
-			/*BLE HID*/
-			coex_stat->bt_ble_hid_exist = true;
+	if (chip->ble_hid_profile_support) {
+		if (coex_stat->bt_info_lb2 & BIT(5)) {
+			if (coex_stat->bt_info_hb1 & BIT(0)) {
+				/*BLE HID*/
+				coex_stat->bt_ble_hid_exist = true;
+			} else {
+				coex_stat->bt_ble_hid_exist = false;
+			}
+			coex_stat->bt_ble_exist = false;
+		} else if (coex_stat->bt_info_hb1 & BIT(0)) {
+			/*RCU*/
+			coex_stat->bt_ble_hid_exist = false;
+			coex_stat->bt_ble_exist = true;
 		} else {
 			coex_stat->bt_ble_hid_exist = false;
+			coex_stat->bt_ble_exist = false;
 		}
-		coex_stat->bt_ble_exist = false;
-	} else if (coex_stat->bt_info_hb1 & BIT(0)) {
-		/*RCU*/
-		coex_stat->bt_ble_hid_exist = false;
-		coex_stat->bt_ble_exist = true;
 	} else {
-		coex_stat->bt_ble_hid_exist = false;
-		coex_stat->bt_ble_exist = false;
+		if (coex_stat->bt_info_hb1 & BIT(0)) {
+			if (coex_stat->bt_hid_slot == 1 &&
+			    coex_stat->hi_pri_rx + 100 < coex_stat->hi_pri_tx &&
+			    coex_stat->hi_pri_rx < 100) {
+				coex_stat->bt_ble_hid_exist = true;
+				coex_stat->bt_ble_exist = false;
+			} else {
+				coex_stat->bt_ble_hid_exist = false;
+				coex_stat->bt_ble_exist = true;
+			}
+		} else {
+			coex_stat->bt_ble_hid_exist = false;
+			coex_stat->bt_ble_exist = false;
+		}
 	}
 
 	coex_stat->cnt_bt[COEX_CNT_BT_RETRY] = coex_stat->bt_info_lb3 & 0xf;
@@ -2916,7 +2973,7 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 		if (coex_stat->bt_reenable)
 			bt_relink_time = 6 * HZ;
 		else
-			bt_relink_time = 2 * HZ;
+			bt_relink_time = 1 * HZ;
 
 		ieee80211_queue_delayed_work(rtwdev->hw,
 					     &coex->bt_relink_work,
@@ -2975,7 +3032,7 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 	coex_stat->bt_hid_pair_num = (coex_stat->bt_info_hb2 & 0xc0) >> 6;
 	if (coex_stat->bt_hid_pair_num > 0 && coex_stat->bt_hid_slot >= 2)
 		coex_stat->bt_418_hid_exist = true;
-	else if (coex_stat->bt_hid_pair_num == 0)
+	else if (coex_stat->bt_hid_pair_num == 0 || coex_stat->bt_hid_slot == 1)
 		coex_stat->bt_418_hid_exist = false;
 
 	if ((coex_stat->bt_info_lb2 & 0x49) == 0x49)
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index ac6d78507904..4e1369298a82 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1174,6 +1174,7 @@ struct rtw_chip_info {
 	u8 bt_desired_ver;
 	bool scbd_support;
 	bool new_scbd10_def; /* true: fix 2M(8822c) */
+	bool ble_hid_profile_support;
 	u8 pstdma_type; /* 0: LPSoff, 1:LPSon */
 	u8 bt_rssi_type;
 	u8 ant_isolation;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 92652b808578..9268ea8b6dda 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -2752,6 +2752,7 @@ struct rtw_chip_info rtw8723d_hw_spec = {
 	.bt_desired_ver = 0x2f,
 	.scbd_support = true,
 	.new_scbd10_def = true,
+	.ble_hid_profile_support = false,
 	.pstdma_type = COEX_PSTDMA_FORCE_LPSOFF,
 	.bt_rssi_type = COEX_BTRSSI_RATIO,
 	.ant_isolation = 15,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 3f4b2898cedc..fbfd85439d1f 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1830,6 +1830,7 @@ struct rtw_chip_info rtw8821c_hw_spec = {
 	.bt_desired_ver = 0x46,
 	.scbd_support = true,
 	.new_scbd10_def = false,
+	.ble_hid_profile_support = false,
 	.pstdma_type = COEX_PSTDMA_FORCE_LPSOFF,
 	.bt_rssi_type = COEX_BTRSSI_RATIO,
 	.ant_isolation = 15,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 9c73937c9dde..f1789155e901 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2507,6 +2507,7 @@ struct rtw_chip_info rtw8822b_hw_spec = {
 	.bt_desired_ver = 0x6,
 	.scbd_support = true,
 	.new_scbd10_def = false,
+	.ble_hid_profile_support = false,
 	.pstdma_type = COEX_PSTDMA_FORCE_LPSOFF,
 	.bt_rssi_type = COEX_BTRSSI_RATIO,
 	.ant_isolation = 15,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 06cefe384f34..7dd3ccb73793 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -4365,6 +4365,7 @@ struct rtw_chip_info rtw8822c_hw_spec = {
 	.bt_desired_ver = 0x1c,
 	.scbd_support = true,
 	.new_scbd10_def = true,
+	.ble_hid_profile_support = true,
 	.pstdma_type = COEX_PSTDMA_FORCE_LPSOFF,
 	.bt_rssi_type = COEX_BTRSSI_DBM,
 	.ant_isolation = 15,
-- 
2.21.0

