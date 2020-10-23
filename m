Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF2B296C3C
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Oct 2020 11:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461453AbgJWJim (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Oct 2020 05:38:42 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:45987 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461601AbgJWJil (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Oct 2020 05:38:41 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 09N9cVhnD024667, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 09N9cVhnD024667
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 23 Oct 2020 17:38:31 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Fri, 23 Oct 2020 17:38:31 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 10/11] rtw88: coex: add debug message
Date:   Fri, 23 Oct 2020 17:37:41 +0800
Message-ID: <20201023093742.29908-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201023093742.29908-1-pkshih@realtek.com>
References: <20201023093742.29908-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMB06.realtek.com.tw (172.21.6.99) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

Since coexistence issue is related to WL/BT and each digital/analog/rf,
and these issues are often critical with low failure rate, add more
debugging information is helpful to clarify issues.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c     | 409 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw88/coex.h     |  25 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |   2 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |   4 +
 4 files changed, 399 insertions(+), 41 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index f3b3e7e74f1a..b388979234a7 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -130,6 +130,9 @@ static void rtw_coex_wl_ccklock_action(struct rtw_dev *rtwdev)
 	para[0] = COEX_H2C69_WL_LEAKAP;
 
 	if (coex_stat->tdma_timer_base == 3 && coex_stat->wl_slot_extend) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], set h2c 0x69 opcode 12 to turn off 5ms WL slot extend!!\n");
+
 		para[1] = PARA1_H2C69_DIS_5MS; /* disable 5ms extend */
 		rtw_fw_bt_wifi_control(rtwdev, para[0], &para[1]);
 		coex_stat->wl_slot_extend = false;
@@ -144,13 +147,23 @@ static void rtw_coex_wl_ccklock_action(struct rtw_dev *rtwdev)
 		else
 			coex_stat->cnt_wl[COEX_CNT_WL_5MS_NOEXTEND] = 0;
 
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], 5ms WL slot extend cnt = %d!!\n",
+			coex_stat->cnt_wl[COEX_CNT_WL_5MS_NOEXTEND]);
+
 		if (coex_stat->cnt_wl[COEX_CNT_WL_5MS_NOEXTEND] == 7) {
+			rtw_dbg(rtwdev, RTW_DBG_COEX,
+				"[BTCoex], set h2c 0x69 opcode 12 to turn off 5ms WL slot extend!!\n");
+
 			para[1] = PARA1_H2C69_DIS_5MS;
 			rtw_fw_bt_wifi_control(rtwdev, para[0], &para[1]);
 			coex_stat->wl_slot_extend = false;
 			coex_stat->cnt_wl[COEX_CNT_WL_5MS_NOEXTEND] = 0;
 		}
 	} else if (!coex_stat->wl_slot_extend && coex_stat->wl_cck_lock) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], set h2c 0x69 opcode 12 to turn on 5ms WL slot extend!!\n");
+
 		para[1] = PARA1_H2C69_EN_5MS;
 		rtw_fw_bt_wifi_control(rtwdev, para[0], &para[1]);
 		coex_stat->wl_slot_extend = true;
@@ -211,6 +224,9 @@ static void rtw_coex_wl_noisy_detect(struct rtw_dev *rtwdev)
 			coex_stat->wl_noisy_level = 1;
 		else
 			coex_stat->wl_noisy_level = 0;
+
+		rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], wl_noisy_level = %d\n",
+			coex_stat->wl_noisy_level);
 	}
 }
 
@@ -234,6 +250,9 @@ static void rtw_coex_tdma_timer_base(struct rtw_dev *rtwdev, u8 type)
 
 	rtw_fw_bt_wifi_control(rtwdev, para[0], &para[1]);
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s(): h2c_0x69 = 0x%x\n",
+		__func__, para[1]);
+
 	/* no 5ms_wl_slot_extend for 4-slot mode  */
 	if (coex_stat->tdma_timer_base == 3)
 		rtw_coex_wl_ccklock_action(rtwdev);
@@ -307,6 +326,9 @@ static void rtw_coex_check_rfk(struct rtw_dev *rtwdev)
 
 	if (coex_rfe->wlg_at_btg && chip->scbd_support &&
 	    coex_stat->bt_iqk_state != 0xff) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], (Before Ant Setup) Delay by IQK\n");
+
 		wait_cnt = COEX_RFK_TIMEOUT / COEX_MIN_DELAY;
 		do {
 			/* BT RFK */
@@ -334,6 +356,8 @@ static void rtw_coex_query_bt_info(struct rtw_dev *rtwdev)
 	if (coex_stat->bt_disabled)
 		return;
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
+
 	rtw_fw_query_bt_info(rtwdev);
 }
 
@@ -357,7 +381,8 @@ static void rtw_coex_monitor_bt_enable(struct rtw_dev *rtwdev)
 	}
 
 	if (coex_stat->bt_disabled != bt_disabled) {
-		rtw_dbg(rtwdev, RTW_DBG_COEX, "coex: BT state changed (%d) -> (%d)\n",
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], BT state changed (%d) -> (%d)\n",
 			coex_stat->bt_disabled, bt_disabled);
 
 		coex_stat->bt_disabled = bt_disabled;
@@ -540,6 +565,23 @@ static bool rtw_coex_set_lna_constrain_level(struct rtw_dev *rtwdev,
 	return ret;
 }
 
+#define case_BTSTATUS(src) \
+	case COEX_BTSTATUS_##src: return #src
+
+static const char *rtw_coex_get_bt_status_string(u8 bt_status)
+{
+	switch (bt_status) {
+	case_BTSTATUS(NCON_IDLE);
+	case_BTSTATUS(CON_IDLE);
+	case_BTSTATUS(INQ_PAGE);
+	case_BTSTATUS(ACL_BUSY);
+	case_BTSTATUS(SCO_BUSY);
+	case_BTSTATUS(ACL_SCO_BUSY);
+	default:
+		return "Unknown";
+	}
+}
+
 static void rtw_coex_update_bt_link_info(struct rtw_dev *rtwdev)
 {
 	struct rtw_coex *coex = &rtwdev->coex;
@@ -644,7 +686,8 @@ static void rtw_coex_update_bt_link_info(struct rtw_dev *rtwdev)
 
 	coex_stat->cnt_bt[COEX_CNT_BT_INFOUPDATE]++;
 
-	rtw_dbg(rtwdev, RTW_DBG_COEX, "coex: bt status(%d)\n", coex_dm->bt_status);
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s(), %s!!!\n", __func__,
+		rtw_coex_get_bt_status_string(coex_dm->bt_status));
 }
 
 static void rtw_coex_update_wl_ch_info(struct rtw_dev *rtwdev, u8 type)
@@ -664,6 +707,8 @@ static void rtw_coex_update_wl_ch_info(struct rtw_dev *rtwdev, u8 type)
 
 	if (center_chan == 0 || (efuse->share_ant && center_chan <= 14)) {
 		link = 0;
+		center_chan = 0;
+		bw = 0;
 	} else if (center_chan <= 14) {
 		link = 0x1;
 
@@ -687,6 +732,9 @@ static void rtw_coex_update_wl_ch_info(struct rtw_dev *rtwdev, u8 type)
 	coex_dm->wl_ch_info[2] = bw;
 
 	rtw_fw_wl_ch_info(rtwdev, link, center_chan, bw);
+	rtw_dbg(rtwdev, RTW_DBG_COEX,
+		"[BTCoex], %s: para[0:2] = 0x%x 0x%x 0x%x\n", __func__, link,
+		center_chan, bw);
 }
 
 static void rtw_coex_set_bt_tx_power(struct rtw_dev *rtwdev, u8 bt_pwr_dec_lvl)
@@ -719,6 +767,8 @@ static void rtw_coex_set_bt_rx_gain(struct rtw_dev *rtwdev, u8 bt_lna_lvl)
 	} else {
 		rtw_coex_write_scbd(rtwdev, COEX_SCBD_RXGAIN, false);
 	}
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s(): bt_rx_LNA_level = %d\n",
+		__func__, bt_lna_lvl);
 }
 
 static void rtw_coex_set_rf_para(struct rtw_dev *rtwdev,
@@ -800,6 +850,10 @@ static void rtw_coex_set_table(struct rtw_dev *rtwdev, u32 table0, u32 table1)
 	rtw_write32(rtwdev, REG_BT_COEX_TABLE0, table0);
 	rtw_write32(rtwdev, REG_BT_COEX_TABLE1, table1);
 	rtw_write32(rtwdev, REG_BT_COEX_BRK_TABLE, DEF_BRK_TABLE_VAL);
+
+	rtw_dbg(rtwdev, RTW_DBG_COEX,
+		"[BTCoex], %s(): 0x6c0 = %x, 0x6c4 = %x\n", __func__, table0,
+		table1);
 }
 
 static void rtw_coex_table(struct rtw_dev *rtwdev, u8 type)
@@ -811,6 +865,8 @@ static void rtw_coex_table(struct rtw_dev *rtwdev, u8 type)
 
 	coex_dm->cur_table = type;
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], Coex_Table - %d\n", type);
+
 	if (efuse->share_ant) {
 		if (type < chip->table_sant_num)
 			rtw_coex_set_table(rtwdev,
@@ -848,7 +904,8 @@ static void rtw_coex_power_save_state(struct rtw_dev *rtwdev, u8 ps_type,
 	case COEX_PS_WIFI_NATIVE:
 		/* recover to original 32k low power setting */
 		coex_stat->wl_force_lps_ctrl = false;
-
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], %s(): COEX_PS_WIFI_NATIVE\n", __func__);
 		rtw_leave_lps(rtwdev);
 		break;
 	case COEX_PS_LPS_OFF:
@@ -857,6 +914,8 @@ static void rtw_coex_power_save_state(struct rtw_dev *rtwdev, u8 ps_type,
 			rtw_fw_coex_tdma_type(rtwdev, 0x8, 0, 0, 0, 0);
 
 		rtw_leave_lps(rtwdev);
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], %s(): COEX_PS_LPS_OFF\n", __func__);
 		break;
 	default:
 		break;
@@ -873,6 +932,9 @@ static void rtw_coex_set_tdma(struct rtw_dev *rtwdev, u8 byte1, u8 byte2,
 	bool ap_enable = false;
 
 	if (ap_enable && (byte1 & BIT(4) && !(byte1 & BIT(5)))) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s(): AP mode\n",
+			__func__);
+
 		byte1 &= ~BIT(4);
 		byte1 |= BIT(5);
 
@@ -882,12 +944,20 @@ static void rtw_coex_set_tdma(struct rtw_dev *rtwdev, u8 byte1, u8 byte2,
 		ps_type = COEX_PS_WIFI_NATIVE;
 		rtw_coex_power_save_state(rtwdev, ps_type, 0x0, 0x0);
 	} else if (byte1 & BIT(4) && !(byte1 & BIT(5))) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], %s(): Force LPS (byte1 = 0x%x)\n", __func__,
+			byte1);
+
 		if (chip->pstdma_type == COEX_PSTDMA_FORCE_LPSOFF)
 			ps_type = COEX_PS_LPS_OFF;
 		else
 			ps_type = COEX_PS_LPS_ON;
 		rtw_coex_power_save_state(rtwdev, ps_type, 0x50, 0x4);
 	} else {
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], %s(): native power save (byte1 = 0x%x)\n",
+			__func__, byte1);
+
 		ps_type = COEX_PS_WIFI_NATIVE;
 		rtw_coex_power_save_state(rtwdev, ps_type, 0x0, 0x0);
 	}
@@ -921,11 +991,14 @@ static void rtw_coex_tdma(struct rtw_dev *rtwdev, bool force, u32 tcase)
 
 	turn_on = (type == 0 || type == 100) ? false : true;
 
-	if (!force) {
-		if (turn_on == coex_dm->cur_ps_tdma_on &&
-		    type == coex_dm->cur_ps_tdma) {
-			return;
-		}
+	if (!force && turn_on == coex_dm->cur_ps_tdma_on &&
+	    type == coex_dm->cur_ps_tdma) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], Skip TDMA because no change TDMA(%s, %d)\n",
+			(coex_dm->cur_ps_tdma_on ? "on" : "off"),
+			coex_dm->cur_ps_tdma);
+
+		return;
 	}
 
 	/* enable TBTT interrupt */
@@ -964,7 +1037,7 @@ static void rtw_coex_tdma(struct rtw_dev *rtwdev, bool force, u32 tcase)
 	coex_dm->cur_ps_tdma_on = turn_on;
 	coex_dm->cur_ps_tdma = type;
 
-	rtw_dbg(rtwdev, RTW_DBG_COEX, "coex: coex tdma type (%d)\n", type);
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], coex tdma type (%d)\n", type);
 }
 
 static void rtw_coex_set_ant_path(struct rtw_dev *rtwdev, bool force, u8 phase)
@@ -983,8 +1056,14 @@ static void rtw_coex_set_ant_path(struct rtw_dev *rtwdev, bool force, u8 phase)
 	/* avoid switch coex_ctrl_owner during BT IQK */
 	rtw_coex_check_rfk(rtwdev);
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX,
+		"[BTCoex],  coex_stat->bt_disabled = 0x%x\n",
+		coex_stat->bt_disabled);
+
 	switch (phase) {
 	case COEX_SET_ANT_POWERON:
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], %s() - PHASE_COEX_POWERON\n", __func__);
 		/* set path control owner to BT at power-on */
 		if (coex_stat->bt_disabled)
 			rtw_coex_coex_ctrl_owner(rtwdev, true);
@@ -995,6 +1074,8 @@ static void rtw_coex_set_ant_path(struct rtw_dev *rtwdev, bool force, u8 phase)
 		pos_type = COEX_SWITCH_TO_BT;
 		break;
 	case COEX_SET_ANT_INIT:
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], %s() - PHASE_COEX_INIT\n", __func__);
 		if (coex_stat->bt_disabled) {
 			/* set GNT_BT to SW low */
 			rtw_coex_set_gnt_bt(rtwdev, COEX_GNT_SET_SW_LOW);
@@ -1016,6 +1097,8 @@ static void rtw_coex_set_ant_path(struct rtw_dev *rtwdev, bool force, u8 phase)
 		pos_type = COEX_SWITCH_TO_BT;
 		break;
 	case COEX_SET_ANT_WONLY:
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], %s() - PHASE_WLANONLY_INIT\n", __func__);
 		/* set GNT_BT to SW Low */
 		rtw_coex_set_gnt_bt(rtwdev, COEX_GNT_SET_SW_LOW);
 
@@ -1029,6 +1112,8 @@ static void rtw_coex_set_ant_path(struct rtw_dev *rtwdev, bool force, u8 phase)
 		pos_type = COEX_SWITCH_TO_WLG;
 		break;
 	case COEX_SET_ANT_WOFF:
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], %s() - PHASE_WLAN_OFF\n", __func__);
 		/* set path control owner to BT */
 		rtw_coex_coex_ctrl_owner(rtwdev, false);
 
@@ -1036,6 +1121,8 @@ static void rtw_coex_set_ant_path(struct rtw_dev *rtwdev, bool force, u8 phase)
 		pos_type = COEX_SWITCH_TO_NOCARE;
 		break;
 	case COEX_SET_ANT_2G:
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], %s() - PHASE_2G_RUNTIME\n", __func__);
 		/* set GNT_BT to PTA */
 		rtw_coex_set_gnt_bt(rtwdev, COEX_GNT_SET_HW_PTA);
 
@@ -1049,6 +1136,9 @@ static void rtw_coex_set_ant_path(struct rtw_dev *rtwdev, bool force, u8 phase)
 		pos_type = COEX_SWITCH_TO_NOCARE;
 		break;
 	case COEX_SET_ANT_5G:
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], %s() - PHASE_5G_RUNTIME\n", __func__);
+
 		/* set GNT_BT to PTA */
 		rtw_coex_set_gnt_bt(rtwdev, COEX_GNT_SET_SW_HIGH);
 
@@ -1062,6 +1152,9 @@ static void rtw_coex_set_ant_path(struct rtw_dev *rtwdev, bool force, u8 phase)
 		pos_type = COEX_SWITCH_TO_WLA;
 		break;
 	case COEX_SET_ANT_2G_FREERUN:
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], %s() - PHASE_2G_FREERUN\n", __func__);
+
 		/* set GNT_BT to SW high */
 		rtw_coex_set_gnt_bt(rtwdev, COEX_GNT_SET_SW_HIGH);
 
@@ -1075,6 +1168,8 @@ static void rtw_coex_set_ant_path(struct rtw_dev *rtwdev, bool force, u8 phase)
 		pos_type = COEX_SWITCH_TO_WLG_BT;
 		break;
 	case COEX_SET_ANT_2G_WLBT:
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], %s() - PHASE_2G_WLBT\n", __func__);
 		/* set GNT_BT to HW PTA */
 		rtw_coex_set_gnt_bt(rtwdev, COEX_GNT_SET_HW_PTA);
 
@@ -1096,6 +1191,53 @@ static void rtw_coex_set_ant_path(struct rtw_dev *rtwdev, bool force, u8 phase)
 		rtw_coex_set_ant_switch(rtwdev, ctrl_type, pos_type);
 }
 
+#define case_ALGO(src) \
+	case COEX_ALGO_##src: return #src
+
+static const char *rtw_coex_get_algo_string(u8 algo)
+{
+	switch (algo) {
+	case_ALGO(NOPROFILE);
+	case_ALGO(HFP);
+	case_ALGO(HID);
+	case_ALGO(A2DP);
+	case_ALGO(PAN);
+	case_ALGO(A2DP_HID);
+	case_ALGO(A2DP_PAN);
+	case_ALGO(PAN_HID);
+	case_ALGO(A2DP_PAN_HID);
+	default:
+		return "Unknown";
+	}
+}
+
+#define case_BT_PROFILE(src) \
+	case BPM_##src: return #src
+
+static const char *rtw_coex_get_bt_profile_string(u8 bt_profile)
+{
+	switch (bt_profile) {
+	case_BT_PROFILE(NOPROFILE);
+	case_BT_PROFILE(HFP);
+	case_BT_PROFILE(HID);
+	case_BT_PROFILE(A2DP);
+	case_BT_PROFILE(PAN);
+	case_BT_PROFILE(HID_HFP);
+	case_BT_PROFILE(A2DP_HFP);
+	case_BT_PROFILE(A2DP_HID);
+	case_BT_PROFILE(A2DP_HID_HFP);
+	case_BT_PROFILE(PAN_HFP);
+	case_BT_PROFILE(PAN_HID);
+	case_BT_PROFILE(PAN_HID_HFP);
+	case_BT_PROFILE(PAN_A2DP);
+	case_BT_PROFILE(PAN_A2DP_HFP);
+	case_BT_PROFILE(PAN_A2DP_HID);
+	case_BT_PROFILE(PAN_A2DP_HID_HFP);
+	default:
+		return "Unknown";
+	}
+}
+
 static u8 rtw_coex_algorithm(struct rtw_dev *rtwdev)
 {
 	struct rtw_coex *coex = &rtwdev->coex;
@@ -1156,6 +1298,10 @@ static u8 rtw_coex_algorithm(struct rtw_dev *rtwdev)
 		break;
 	}
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX,
+		"[BTCoex], BT Profile = %s => Algorithm = %s\n",
+		rtw_coex_get_bt_profile_string(profile_map),
+		rtw_coex_get_algo_string(algorithm));
 	return algorithm;
 }
 
@@ -1165,6 +1311,7 @@ static void rtw_coex_action_coex_all_off(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
 	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 
 	if (efuse->share_ant) {
@@ -1190,6 +1337,8 @@ static void rtw_coex_action_freerun(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 level = 0;
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
+
 	if (efuse->share_ant)
 		return;
 
@@ -1229,6 +1378,8 @@ static void rtw_coex_action_bt_whql_test(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
+
 	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
 	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 
@@ -1252,6 +1403,8 @@ static void rtw_coex_action_bt_relink(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
+
 	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
 	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 
@@ -1279,6 +1432,7 @@ static void rtw_coex_action_bt_idle(struct rtw_dev *rtwdev)
 	struct rtw_coex_rfe *coex_rfe = &coex->rfe;
 	u8 table_case = 0xff, tdma_case = 0xff;
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
 	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 
 	if (coex_rfe->ant_switch_with_bt &&
@@ -1343,6 +1497,7 @@ static void rtw_coex_action_bt_inquiry(struct rtw_dev *rtwdev)
 	u8 table_case, tdma_case;
 	u32 slot_type = 0;
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
 	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
 	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 
@@ -1353,6 +1508,8 @@ static void rtw_coex_action_bt_inquiry(struct rtw_dev *rtwdev)
 	if (efuse->share_ant) {
 		/* Shared-Ant */
 		if (wl_hi_pri) {
+			rtw_dbg(rtwdev, RTW_DBG_COEX,
+				"[BTCoex], bt inq/page +  wifi hi-pri task\n");
 			table_case = 15;
 			if (coex_stat->bt_profile_num > 0)
 				tdma_case = 10;
@@ -1377,15 +1534,21 @@ static void rtw_coex_action_bt_inquiry(struct rtw_dev *rtwdev)
 				tdma_case = 26;
 			}
 		} else if (coex_stat->wl_connected) {
+			rtw_dbg(rtwdev, RTW_DBG_COEX,
+				"[BTCoex], bt inq/page + wifi connected\n");
 			table_case = 9;
 			tdma_case = 27;
 		} else {
+			rtw_dbg(rtwdev, RTW_DBG_COEX,
+				"[BTCoex], bt inq/page + wifi not-connected\n");
 			table_case = 1;
 			tdma_case = 0;
 		}
 	} else {
 		/* Non_Shared-Ant */
 		if (wl_hi_pri) {
+			rtw_dbg(rtwdev, RTW_DBG_COEX,
+				"[BTCoex], bt inq/page +  wifi hi-pri task\n");
 			table_case = 113;
 			if (coex_stat->bt_a2dp_exist &&
 			    !coex_stat->bt_pan_exist)
@@ -1400,15 +1563,19 @@ static void rtw_coex_action_bt_inquiry(struct rtw_dev *rtwdev)
 			table_case = 114;
 			tdma_case = 121;
 		} else if (coex_stat->wl_connected) {
+			rtw_dbg(rtwdev, RTW_DBG_COEX,
+				"[BTCoex], bt inq/page +  wifi connected\n");
 			table_case = 100;
 			tdma_case = 100;
 		} else {
+			rtw_dbg(rtwdev, RTW_DBG_COEX,
+				"[BTCoex], bt inq/page +  wifi not-connected\n");
 			table_case = 101;
 			tdma_case = 100;
 		}
 	}
 
-	rtw_dbg(rtwdev, RTW_DBG_COEX, "coex: wifi hi(%d), bt page(%d)\n",
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], wifi hi(%d), bt page(%d)\n",
 		wl_hi_pri, coex_stat->bt_page);
 
 	rtw_coex_table(rtwdev, table_case);
@@ -1423,6 +1590,7 @@ static void rtw_coex_action_bt_hfp(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
 	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
 	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 
@@ -1459,6 +1627,7 @@ static void rtw_coex_action_bt_hid(struct rtw_dev *rtwdev)
 	u8 table_case, tdma_case;
 	u32 wl_bw;
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
 	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
 	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 
@@ -1526,6 +1695,8 @@ static void rtw_coex_action_bt_a2dp(struct rtw_dev *rtwdev)
 	u8 table_case, tdma_case;
 	u32 slot_type = 0;
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
+
 	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
 	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 
@@ -1565,6 +1736,8 @@ static void rtw_coex_action_bt_a2dpsink(struct rtw_dev *rtwdev)
 	u8 table_case, tdma_case;
 	bool ap_enable = false;
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
+
 	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
 	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 
@@ -1601,6 +1774,7 @@ static void rtw_coex_action_bt_pan(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
 	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
 	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 
@@ -1639,6 +1813,7 @@ static void rtw_coex_action_bt_a2dp_hid(struct rtw_dev *rtwdev)
 	u8 table_case, tdma_case;
 	u32 slot_type = 0;
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
 	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
 	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 
@@ -1680,9 +1855,10 @@ static void rtw_coex_action_bt_a2dp_pan(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
+
 	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
 	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
-
 	if (efuse->share_ant) {
 		/* Shared-Ant */
 		if (coex_stat->wl_gl_busy &&
@@ -1717,6 +1893,8 @@ static void rtw_coex_action_bt_pan_hid(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
+
 	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
 	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 
@@ -1750,6 +1928,7 @@ static void rtw_coex_action_bt_a2dp_pan_hid(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
 	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
 	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 
@@ -1781,6 +1960,8 @@ static void rtw_coex_action_wl_under5g(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
+
 	rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_5G);
 	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 
@@ -1806,6 +1987,7 @@ static void rtw_coex_action_wl_only(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
 	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
 	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 
@@ -1833,6 +2015,8 @@ static void rtw_coex_action_wl_native_lps(struct rtw_dev *rtwdev)
 	if (coex->under_5g)
 		return;
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
+
 	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
 	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 
@@ -1859,6 +2043,7 @@ static void rtw_coex_action_wl_linkscan(struct rtw_dev *rtwdev)
 	u8 table_case, tdma_case;
 	u32 slot_type = 0;
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
 	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
 	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 
@@ -1893,6 +2078,7 @@ static void rtw_coex_action_wl_not_connected(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
 	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
 	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 
@@ -1926,6 +2112,8 @@ static void rtw_coex_action_wl_connected(struct rtw_dev *rtwdev)
 		return;
 	}
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
+
 	algorithm = rtw_coex_algorithm(rtwdev);
 
 	switch (algorithm) {
@@ -1976,20 +2164,38 @@ static void rtw_coex_run_coex(struct rtw_dev *rtwdev, u8 reason)
 
 	coex_dm->reason = reason;
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s(): reason = %d\n", __func__,
+		reason);
+
 	/* update wifi_link_info_ext variable */
 	rtw_coex_update_wl_link_info(rtwdev, reason);
 
 	rtw_coex_monitor_bt_enable(rtwdev);
 
-	if (coex->manual_control || coex->stop_dm)
+	if (coex->manual_control) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], return for Manual CTRL!!\n");
 		return;
+	}
 
-	if (coex_stat->wl_under_ips)
+	if (coex->stop_dm) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], return for Stop Coex DM!!\n");
 		return;
+	}
+
+	if (coex_stat->wl_under_ips) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], return for wifi is under IPS!!\n");
+		return;
+	}
 
 	if (coex->freeze && coex_dm->reason == COEX_RSN_BTINFO &&
-	    !coex_stat->bt_setup_link)
+	    !coex_stat->bt_setup_link) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], return for coex_freeze!!\n");
 		return;
+	}
 
 	coex_stat->cnt_wl[COEX_CNT_WL_COEXRUN]++;
 	coex->freerun = false;
@@ -2001,6 +2207,7 @@ static void rtw_coex_run_coex(struct rtw_dev *rtwdev, u8 reason)
 		goto exit;
 	}
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], WiFi is single-port 2G!!\n");
 	coex_stat->wl_coex_mode = COEX_WLINK_2G1PORT;
 	rtw_coex_write_scbd(rtwdev, COEX_SCBD_FIX2M, false);
 	if (coex_stat->bt_disabled) {
@@ -2079,6 +2286,8 @@ static void __rtw_coex_init_hw_config(struct rtw_dev *rtwdev, bool wifi_only)
 {
 	struct rtw_coex *coex = &rtwdev->coex;
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
+
 	rtw_coex_init_coex_var(rtwdev);
 	rtw_coex_monitor_bt_enable(rtwdev);
 	rtw_coex_set_rfe_type(rtwdev);
@@ -2098,6 +2307,9 @@ static void __rtw_coex_init_hw_config(struct rtw_dev *rtwdev, bool wifi_only)
 		rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_WOFF);
 		rtw_coex_write_scbd(rtwdev, COEX_SCBD_ALL, false);
 		coex->stop_dm = true;
+
+		rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s(): RF Off\n",
+			__func__);
 	} else if (wifi_only) {
 		rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_WONLY);
 		rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE | COEX_SCBD_SCAN,
@@ -2121,6 +2333,8 @@ void rtw_coex_power_on_setting(struct rtw_dev *rtwdev)
 {
 	struct rtw_coex *coex = &rtwdev->coex;
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
+
 	coex->stop_dm = true;
 	coex->wl_rf_off = false;
 
@@ -2152,6 +2366,8 @@ void rtw_coex_ips_notify(struct rtw_dev *rtwdev, u8 type)
 		return;
 
 	if (type == COEX_IPS_ENTER) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], IPS ENTER notify\n");
+
 		coex_stat->wl_under_ips = true;
 
 		/* for lps off */
@@ -2160,8 +2376,9 @@ void rtw_coex_ips_notify(struct rtw_dev *rtwdev, u8 type)
 		rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_WOFF);
 		rtw_coex_action_coex_all_off(rtwdev);
 	} else if (type == COEX_IPS_LEAVE) {
-		rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE | COEX_SCBD_ONOFF, true);
+		rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], IPS LEAVE notify\n");
 
+		rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE | COEX_SCBD_ONOFF, true);
 		/* run init hw config (exclude wifi only) */
 		__rtw_coex_init_hw_config(rtwdev, false);
 
@@ -2178,6 +2395,8 @@ void rtw_coex_lps_notify(struct rtw_dev *rtwdev, u8 type)
 		return;
 
 	if (type == COEX_LPS_ENABLE) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], LPS ENABLE notify\n");
+
 		coex_stat->wl_under_lps = true;
 
 		if (coex_stat->wl_force_lps_ctrl) {
@@ -2190,6 +2409,8 @@ void rtw_coex_lps_notify(struct rtw_dev *rtwdev, u8 type)
 			rtw_coex_run_coex(rtwdev, COEX_RSN_LPS);
 		}
 	} else if (type == COEX_LPS_DISABLE) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], LPS DISABLE notify\n");
+
 		coex_stat->wl_under_lps = false;
 
 		/* for lps off */
@@ -2215,9 +2436,15 @@ void rtw_coex_scan_notify(struct rtw_dev *rtwdev, u8 type)
 				    COEX_SCBD_ONOFF, true);
 
 	if (type == COEX_SCAN_START_5G) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], SCAN START notify (5G)\n");
+
 		rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_5G);
 		rtw_coex_run_coex(rtwdev, COEX_RSN_5GSCANSTART);
 	} else if ((type == COEX_SCAN_START_2G) || (type == COEX_SCAN_START)) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], SCAN START notify (2G)\n");
+
 		coex_stat->wl_hi_pri_task2 = true;
 
 		/* Force antenna setup for no scan result issue */
@@ -2236,6 +2463,17 @@ void rtw_coex_switchband_notify(struct rtw_dev *rtwdev, u8 type)
 	if (coex->manual_control || coex->stop_dm)
 		return;
 
+	if (type == COEX_SWITCH_TO_5G) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s(): TO_5G\n",
+			__func__);
+	} else if (type == COEX_SWITCH_TO_24G_NOFORSCAN) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], %s(): TO_24G_NOFORSCAN\n", __func__);
+	} else {
+		rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s(): TO_2G\n",
+			__func__);
+	}
+
 	if (type == COEX_SWITCH_TO_5G)
 		rtw_coex_run_coex(rtwdev, COEX_RSN_5GSWITCHBAND);
 	else if (type == COEX_SWITCH_TO_24G_NOFORSCAN)
@@ -2256,9 +2494,15 @@ void rtw_coex_connect_notify(struct rtw_dev *rtwdev, u8 type)
 			    COEX_SCBD_ONOFF, true);
 
 	if (type == COEX_ASSOCIATE_5G_START) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s(): 5G start\n",
+			__func__);
+
 		rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_5G);
 		rtw_coex_run_coex(rtwdev, COEX_RSN_5GCONSTART);
 	} else if (type == COEX_ASSOCIATE_5G_FINISH) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s(): 5G finish\n",
+			__func__);
+
 		rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_5G);
 		rtw_coex_run_coex(rtwdev, COEX_RSN_5GCONFINISH);
 	} else if (type == COEX_ASSOCIATE_START) {
@@ -2268,8 +2512,8 @@ void rtw_coex_connect_notify(struct rtw_dev *rtwdev, u8 type)
 		ieee80211_queue_delayed_work(rtwdev->hw,
 					     &coex->wl_connecting_work, 2 * HZ);
 
-		rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], 2G start\n");
-
+		rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s(): 2G start\n",
+			__func__);
 		/* Force antenna setup for no scan result issue */
 		rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_2G);
 
@@ -2285,8 +2529,8 @@ void rtw_coex_connect_notify(struct rtw_dev *rtwdev, u8 type)
 		coex_stat->wl_hi_pri_task1 = false;
 		coex->freeze = false;
 
-		rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], 2G finish\n");
-
+		rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s(): 2G finish\n",
+			__func__);
 		rtw_coex_run_coex(rtwdev, COEX_RSN_2GCONFINISH);
 	}
 }
@@ -2301,11 +2545,15 @@ void rtw_coex_media_status_notify(struct rtw_dev *rtwdev, u8 type)
 		return;
 
 	if (type == COEX_MEDIA_CONNECT_5G) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s(): 5G\n", __func__);
+
 		rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE, true);
 
 		rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_5G);
 		rtw_coex_run_coex(rtwdev, COEX_RSN_5GMEDIA);
 	} else if (type == COEX_MEDIA_CONNECT) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s(): 2G\n", __func__);
+
 		rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE, true);
 
 		/* Force antenna setup for no scan result issue */
@@ -2322,9 +2570,9 @@ void rtw_coex_media_status_notify(struct rtw_dev *rtwdev, u8 type)
 		rtw_coex_run_coex(rtwdev, COEX_RSN_2GMEDIA);
 	} else {
 		rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE, false);
-
+		rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s(): disconnect!!\n",
+			__func__);
 		rtw_coex_set_wl_pri_mask(rtwdev, COEX_WLPRI_RX_CCK, 0);
-
 		rtw_coex_run_coex(rtwdev, COEX_RSN_MEDIADISCON);
 	}
 
@@ -2353,10 +2601,18 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 		else if (coex_stat->bt_iqk_state == 2)
 			coex_stat->cnt_bt[COEX_CNT_BT_IQKFAIL]++;
 
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], BT IQK by bt_info, data0 = 0x%02x\n",
+			buf[1]);
+
 		return;
 	}
 
 	if (rsp_source == COEX_BTINFO_SRC_BT_SCBD) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], BT Scoreboard change notify by WL FW c2h, 0xaa = 0x%02x, 0xab = 0x%02x\n",
+			buf[1], buf[2]);
+
 		rtw_coex_monitor_bt_enable(rtwdev);
 		if (coex_stat->bt_disabled != coex_stat->bt_disabled_pre) {
 			coex_stat->bt_disabled_pre = coex_stat->bt_disabled;
@@ -2366,12 +2622,19 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 	}
 
 	if (rsp_source == COEX_BTINFO_SRC_H2C60) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], H2C 0x60 content replied by WL FW: H2C_0x60 = [%02x %02x %02x %02x %02x]\n",
+			buf[1], buf[2], buf[3], buf[4], buf[5]);
+
 		for (i = 1; i <= COEX_WL_TDMA_PARA_LENGTH; i++)
 			coex_dm->fw_tdma_para[i - 1] = buf[i];
 		return;
 	}
 
 	if (rsp_source == COEX_BTINFO_SRC_WL_FW) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], bt_info reply by WL FW\n");
+
 		rtw_coex_update_bt_link_info(rtwdev);
 		return;
 	}
@@ -2384,6 +2647,8 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 			ieee80211_queue_delayed_work(rtwdev->hw,
 						     &coex->bt_reenable_work,
 						     15 * HZ);
+			rtw_dbg(rtwdev, RTW_DBG_COEX,
+				"[BTCoex], BT enable detected by bt_info\n");
 		}
 	}
 
@@ -2394,6 +2659,10 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 		return;
 	}
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX,
+		"[BTCoex], Bt_info[%d], len=%d, data=[%02x %02x %02x %02x %02x %02x]\n",
+		buf[0], length, buf[1], buf[2], buf[3], buf[4], buf[5], buf[6]);
+
 	for (i = 0; i < COEX_BTINFO_LENGTH; i++)
 		coex_stat->bt_info_c2h[rsp_source][i] = buf[i];
 
@@ -2403,8 +2672,11 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 	    coex_stat->bt_info_c2h[rsp_source][3] == coex_stat->bt_info_hb0 &&
 	    coex_stat->bt_info_c2h[rsp_source][4] == coex_stat->bt_info_hb1 &&
 	    coex_stat->bt_info_c2h[rsp_source][5] == coex_stat->bt_info_hb2 &&
-	    coex_stat->bt_info_c2h[rsp_source][6] == coex_stat->bt_info_hb3)
+	    coex_stat->bt_info_c2h[rsp_source][6] == coex_stat->bt_info_hb3) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], Return because Btinfo duplicate!!\n");
 		return;
+	}
 
 	coex_stat->bt_info_lb2 = coex_stat->bt_info_c2h[rsp_source][1];
 	coex_stat->bt_info_lb3 = coex_stat->bt_info_c2h[rsp_source][2];
@@ -2470,6 +2742,9 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 		ieee80211_queue_delayed_work(rtwdev->hw,
 					     &coex->bt_relink_work,
 					     bt_relink_time);
+
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], Re-Link start in BT info!!\n");
 	}
 
 	if (coex_stat->bt_info_hb1 & BIT(3))
@@ -2482,7 +2757,10 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 
 	coex_stat->bt_multi_link = ((coex_stat->bt_info_hb1 & BIT(7)) == BIT(7));
 	/* resend wifi info to bt, it is reset and lost the info */
-	if ((coex_stat->bt_info_hb1 & BIT(1))) {
+	if (coex_stat->bt_info_hb1 & BIT(1)) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], BT Re-init, send wifi BW & Chnl to BT!!\n");
+
 		if (coex_stat->wl_connected)
 			type = COEX_MEDIA_CONNECT;
 		else
@@ -2492,8 +2770,11 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 
 	/* if ignore_wlan_act && not set_up_link */
 	if ((coex_stat->bt_info_hb1 & BIT(3)) &&
-	    (!(coex_stat->bt_info_hb1 & BIT(2))))
+	    (!(coex_stat->bt_info_hb1 & BIT(2)))) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], BT ext info bit3 check, set BT NOT to ignore Wlan active!!\n");
 		rtw_coex_ignore_wlan_act(rtwdev, false);
+	}
 
 	coex_stat->bt_opp_exist = ((coex_stat->bt_info_hb2 & BIT(0)) == BIT(0));
 	if (coex_stat->bt_info_hb2 & BIT(1))
@@ -2526,6 +2807,9 @@ void rtw_coex_wl_fwdbginfo_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 	u8 val;
 	int i;
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX,
+		"[BTCoex], WiFi Fw Dbg info = %8ph (len = %d)\n",
+		buf, length);
 	if (WARN(length < 8, "invalid wl info c2h length\n"))
 		return;
 
@@ -2924,6 +3208,19 @@ static void rtw_coex_vif_stat_iter(void *data, u8 *mac,
 				&sta_iter_data);
 }
 
+#define case_WLINK(src) \
+	case COEX_WLINK_##src: return #src
+
+static const char *rtw_coex_get_wl_coex_mode(u8 coex_wl_link_mode)
+{
+	switch (coex_wl_link_mode) {
+	case_WLINK(2G1PORT);
+	case_WLINK(5G);
+	default:
+		return "Unknown";
+	}
+}
+
 void rtw_coex_display_coex_info(struct rtw_dev *rtwdev, struct seq_file *m)
 {
 	struct rtw_chip_info *chip = rtwdev->chip;
@@ -2972,9 +3269,24 @@ void rtw_coex_display_coex_info(struct rtw_dev *rtwdev, struct seq_file *m)
 			coex_stat->bt_mailbox_reply = true;
 	}
 
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
 	seq_printf(m, "**********************************************\n");
 	seq_printf(m, "\t\tBT Coexist info %x\n", chip->id);
 	seq_printf(m, "**********************************************\n");
+
+	if (coex->manual_control) {
+		seq_puts(m, "============[Under Manual Control]============\n");
+		seq_puts(m, "==========================================\n");
+
+	} else if (coex->stop_dm) {
+		seq_puts(m, "============[Coex is STOPPED]============\n");
+		seq_puts(m, "==========================================\n");
+
+	} else if (coex->freeze) {
+		seq_puts(m, "============[coex_freeze]============\n");
+		seq_puts(m, "==========================================\n");
+	}
+
 	seq_printf(m, "%-40s = %s/ %d\n",
 		   "Mech/ RFE",
 		   efuse->share_ant ? "Shared" : "Non-Shared",
@@ -3068,20 +3380,41 @@ void rtw_coex_display_coex_info(struct rtw_dev *rtwdev, struct seq_file *m)
 	vif_iter_data.file = m;
 	rtw_iterate_vifs_atomic(rtwdev, rtw_coex_vif_stat_iter, &vif_iter_data);
 
-	seq_printf(m, "**********************************************\n");
-	seq_printf(m, "\t\tMechanism\n");
-	seq_printf(m, "**********************************************\n");
-	seq_printf(m, "%-40s = %5ph (case-%d)\n",
-		   "TDMA",
-		   coex_dm->ps_tdma_para, coex_dm->cur_ps_tdma);
-	seq_printf(m, "%-40s = %d\n",
-		   "Timer base", coex_stat->tdma_timer_base);
+	if (coex->manual_control) {
+		seq_printf(m, "**********************************************\n");
+		seq_printf(m, "\t\tMechanism (Under Manual)\n");
+		seq_printf(m, "**********************************************\n");
+		seq_printf(m, "%-40s = %5ph\n",
+			   "TDMA Now",
+			   coex_dm->fw_tdma_para);
+	} else {
+		seq_printf(m, "**********************************************\n");
+		seq_printf(m, "\t\tMechanism\n");
+		seq_printf(m, "**********************************************\n");
+		seq_printf(m, "%-40s = %5ph (case-%d)\n",
+			   "TDMA",
+			   coex_dm->ps_tdma_para, coex_dm->cur_ps_tdma);
+	}
+	seq_printf(m, "%-40s = %s/ %s/ %d\n",
+		   "Coex Mode/Free Run/Timer base",
+		   rtw_coex_get_wl_coex_mode(coex_stat->wl_coex_mode),
+		   coex->freerun ? "Yes" : "No",
+		   coex_stat->tdma_timer_base);
 	seq_printf(m, "%-40s = %d/ 0x%08x/ 0x%08x/ 0x%08x\n",
 		   "Table/ 0x6c0/ 0x6c4/ 0x6c8",
 		   coex_dm->cur_table, wl_reg_6c0, wl_reg_6c4, wl_reg_6c8);
-	seq_printf(m, "%-40s = 0x%08x/ 0x%08x/ reason (%s)\n",
-		   "0x778/ 0x6cc/ Reason",
-		   wl_reg_778, wl_reg_6cc, rtw_coex_get_reason_string(reason));
+	seq_printf(m, "%-40s = 0x%08x/ 0x%08x/ %d/ reason (%s)\n",
+		   "0x778/ 0x6cc/ Run Count/ Reason",
+		   wl_reg_778, wl_reg_6cc,
+		   coex_stat->cnt_wl[COEX_CNT_WL_COEXRUN],
+		   rtw_coex_get_reason_string(reason));
+	seq_printf(m, "%-40s = %3ph\n",
+		   "AFH Map to BT",
+		   coex_dm->wl_ch_info);
+	seq_printf(m, "%-40s = %s/ %d\n",
+		   "AntDiv/ BtCtrlLPS/ g_busy",
+		   coex_stat->wl_force_lps_ctrl ? "On" : "Off",
+		   coex_stat->wl_gl_busy);
 	seq_printf(m, "%-40s = %u/ %u/ %u/ %u/ %u\n",
 		   "Null All/ Retry/ Ack/ BT Empty/ BT Late",
 		   coex_stat->wl_fw_dbg_info[1], coex_stat->wl_fw_dbg_info[2],
@@ -3093,6 +3426,12 @@ void rtw_coex_display_coex_info(struct rtw_dev *rtwdev, struct seq_file *m)
 		   coex_stat->wl_fw_dbg_info[7],
 		   coex_stat->wl_slot_extend ? "Yes" : "No",
 		   coex_stat->cnt_wl[COEX_CNT_WL_FW_NOTIFY]);
+	seq_printf(m, "%-40s = %d/ %d/ %s/ %d\n",
+		   "WL_TxPw/ BT_TxPw/ WL_Rx/ BT_LNA_Lvl",
+		   coex_dm->cur_wl_pwr_lvl,
+		   coex_dm->cur_bt_pwr_lvl,
+		   coex_dm->cur_wl_rx_low_gain_en ? "On" : "Off",
+		   coex_dm->cur_bt_lna_lvl);
 
 	seq_printf(m, "**********************************************\n");
 	seq_printf(m, "\t\tHW setting\n");
diff --git a/drivers/net/wireless/realtek/rtw88/coex.h b/drivers/net/wireless/realtek/rtw88/coex.h
index 712a3adb5d16..9b305fc6c984 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.h
+++ b/drivers/net/wireless/realtek/rtw88/coex.h
@@ -5,12 +5,6 @@
 #ifndef __RTW_COEX_H__
 #define __RTW_COEX_H__
 
-/* BT profile map bit definition */
-#define BPM_HFP		BIT(0)
-#define BPM_HID		BIT(1)
-#define BPM_A2DP		BIT(2)
-#define BPM_PAN		BIT(3)
-
 #define COEX_RESP_ACK_BY_WL_FW	0x1
 #define COEX_REQUEST_TIMEOUT	msecs_to_jiffies(10)
 
@@ -147,6 +141,25 @@ enum coex_algorithm {
 	COEX_ALGO_MAX
 };
 
+enum coex_bt_profile {
+	BPM_NOPROFILE		= 0,
+	BPM_HFP			= BIT(0),
+	BPM_HID			= BIT(1),
+	BPM_A2DP		= BIT(2),
+	BPM_PAN			= BIT(3),
+	BPM_HID_HFP		= BPM_HID | BPM_HFP,
+	BPM_A2DP_HFP		= BPM_A2DP | BPM_HFP,
+	BPM_A2DP_HID		= BPM_A2DP | BPM_HID,
+	BPM_A2DP_HID_HFP	= BPM_A2DP | BPM_HID | BPM_HFP,
+	BPM_PAN_HFP		= BPM_PAN | BPM_HFP,
+	BPM_PAN_HID		= BPM_PAN | BPM_HID,
+	BPM_PAN_HID_HFP		= BPM_PAN | BPM_HID | BPM_HFP,
+	BPM_PAN_A2DP		= BPM_PAN | BPM_A2DP,
+	BPM_PAN_A2DP_HFP	= BPM_PAN | BPM_A2DP | BPM_HFP,
+	BPM_PAN_A2DP_HID	= BPM_PAN | BPM_A2DP | BPM_HID,
+	BPM_PAN_A2DP_HID_HFP	= BPM_PAN | BPM_A2DP | BPM_HID | BPM_HFP,
+};
+
 enum coex_wl_link_mode {
 	COEX_WLINK_2G1PORT	= 0x0,
 	COEX_WLINK_5G		= 0x3,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index f7f6a63e576f..214d73efcf4d 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -1341,6 +1341,7 @@ static void rtw8822b_coex_cfg_wl_rx_gain(struct rtw_dev *rtwdev, bool low_gain)
 	coex_dm->cur_wl_rx_low_gain_en = low_gain;
 
 	if (coex_dm->cur_wl_rx_low_gain_en) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], Hi-Li Table On!\n");
 		for (i = 0; i < ARRAY_SIZE(wl_rx_low_gain_on); i++)
 			rtw_write32(rtwdev, REG_RX_GAIN_EN, wl_rx_low_gain_on[i]);
 
@@ -1350,6 +1351,7 @@ static void rtw8822b_coex_cfg_wl_rx_gain(struct rtw_dev *rtwdev, bool low_gain)
 		rtw_write_rf(rtwdev, RF_PATH_B, RF_RCKD, 0x2, 0x1);
 		rtw_write_rf(rtwdev, RF_PATH_B, RF_RCK, 0x3f, 0x3f);
 	} else {
+		rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], Hi-Li Table Off!\n");
 		for (i = 0; i < ARRAY_SIZE(wl_rx_low_gain_off); i++)
 			rtw_write32(rtwdev, 0x81c, wl_rx_low_gain_off[i]);
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 280a3ef98026..3b05c2cccb35 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -2274,6 +2274,8 @@ static void rtw8822c_coex_cfg_wl_rx_gain(struct rtw_dev *rtwdev, bool low_gain)
 	coex_dm->cur_wl_rx_low_gain_en = low_gain;
 
 	if (coex_dm->cur_wl_rx_low_gain_en) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], Hi-Li Table On!\n");
+
 		/* set Rx filter corner RCK offset */
 		rtw_write_rf(rtwdev, RF_PATH_A, RF_RCKD, RFREG_MASK, 0x22);
 		rtw_write_rf(rtwdev, RF_PATH_A, RF_RCK, RFREG_MASK, 0x36);
@@ -2281,6 +2283,8 @@ static void rtw8822c_coex_cfg_wl_rx_gain(struct rtw_dev *rtwdev, bool low_gain)
 		rtw_write_rf(rtwdev, RF_PATH_B, RF_RCK, RFREG_MASK, 0x36);
 
 	} else {
+		rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], Hi-Li Table Off!\n");
+
 		/* set Rx filter corner RCK offset */
 		rtw_write_rf(rtwdev, RF_PATH_A, RF_RCKD, RFREG_MASK, 0x20);
 		rtw_write_rf(rtwdev, RF_PATH_A, RF_RCK, RFREG_MASK, 0x0);
-- 
2.21.0

