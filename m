Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E235329A28C
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Oct 2020 03:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504393AbgJ0CM4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Oct 2020 22:12:56 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:36140 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504389AbgJ0CMz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Oct 2020 22:12:55 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 09R2CndcE015795, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 09R2CndcE015795
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 27 Oct 2020 10:12:49 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Tue, 27 Oct 2020 10:12:49 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 04/11] rtw88: coex: coding style adjustment
Date:   Tue, 27 Oct 2020 10:11:50 +0800
Message-ID: <20201027021157.6116-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201027021157.6116-1-pkshih@realtek.com>
References: <20201027021157.6116-1-pkshih@realtek.com>
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

Fix some coding style warning.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 42 +++++++++++++----------
 drivers/net/wireless/realtek/rtw88/coex.h | 10 +++---
 drivers/net/wireless/realtek/rtw88/main.c |  2 +-
 3 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index c0ea60303cd5..cfd78ebb7e4e 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -337,6 +337,11 @@ static void rtw_coex_query_bt_info(struct rtw_dev *rtwdev)
 	rtw_fw_query_bt_info(rtwdev);
 }
 
+static void rtw_coex_gnt_workaround(struct rtw_dev *rtwdev, bool force, u8 mode)
+{
+	rtw_coex_set_gnt_fix(rtwdev);
+}
+
 static void rtw_coex_monitor_bt_enable(struct rtw_dev *rtwdev)
 {
 	struct rtw_chip_info *chip = rtwdev->chip;
@@ -551,8 +556,8 @@ static void rtw_coex_update_bt_link_info(struct rtw_dev *rtwdev)
 		rssi_state = coex_dm->bt_rssi_state[i];
 		rssi_step = chip->bt_rssi_step[i];
 		rssi = coex_stat->bt_rssi;
-		rssi_state = rtw_coex_next_rssi_state(rtwdev, rssi_state,
-						      rssi, rssi_step);
+		rssi_state = rtw_coex_next_rssi_state(rtwdev, rssi_state, rssi,
+						      rssi_step);
 		coex_dm->bt_rssi_state[i] = rssi_state;
 	}
 
@@ -765,11 +770,13 @@ static void rtw_coex_coex_ctrl_owner(struct rtw_dev *rtwdev, bool wifi_control)
 	const struct rtw_hw_reg *btg_reg = chip->btg_reg;
 
 	if (wifi_control) {
-		rtw_write32_set(rtwdev, REG_SYS_SDIO_CTRL, BIT_LTE_MUX_CTRL_PATH);
+		rtw_write8_set(rtwdev, REG_SYS_SDIO_CTRL + 3,
+			       BIT_LTE_MUX_CTRL_PATH >> 24);
 		if (btg_reg)
 			rtw_write8_set(rtwdev, btg_reg->addr, btg_reg->mask);
 	} else {
-		rtw_write32_clr(rtwdev, REG_SYS_SDIO_CTRL, BIT_LTE_MUX_CTRL_PATH);
+		rtw_write8_clr(rtwdev, REG_SYS_SDIO_CTRL + 3,
+			       BIT_LTE_MUX_CTRL_PATH >> 24);
 		if (btg_reg)
 			rtw_write8_clr(rtwdev, btg_reg->addr, btg_reg->mask);
 	}
@@ -789,7 +796,7 @@ static void rtw_coex_set_gnt_wl(struct rtw_dev *rtwdev, u8 state)
 
 static void rtw_coex_set_table(struct rtw_dev *rtwdev, u32 table0, u32 table1)
 {
-#define DEF_BRK_TABLE_VAL	0xf0ffffff
+#define DEF_BRK_TABLE_VAL 0xf0ffffff
 	rtw_write32(rtwdev, REG_BT_COEX_TABLE0, table0);
 	rtw_write32(rtwdev, REG_BT_COEX_TABLE1, table1);
 	rtw_write32(rtwdev, REG_BT_COEX_BRK_TABLE, DEF_BRK_TABLE_VAL);
@@ -1012,7 +1019,7 @@ static void rtw_coex_set_ant_path(struct rtw_dev *rtwdev, bool force, u8 phase)
 		/* set GNT_BT to SW Low */
 		rtw_coex_set_gnt_bt(rtwdev, COEX_GNT_SET_SW_LOW);
 
-		/* Set GNT_WL to SW high */
+		/* set GNT_WL to SW high */
 		rtw_coex_set_gnt_wl(rtwdev, COEX_GNT_SET_SW_HIGH);
 
 		/* set path control owner to wl at initial step */
@@ -1068,10 +1075,10 @@ static void rtw_coex_set_ant_path(struct rtw_dev *rtwdev, bool force, u8 phase)
 		pos_type = COEX_SWITCH_TO_WLG_BT;
 		break;
 	case COEX_SET_ANT_2G_WLBT:
-		/* set GNT_BT to SW high */
+		/* set GNT_BT to HW PTA */
 		rtw_coex_set_gnt_bt(rtwdev, COEX_GNT_SET_HW_PTA);
 
-		/* Set GNT_WL to SW high */
+		/* Set GNT_WL to HW PTA */
 		rtw_coex_set_gnt_wl(rtwdev, COEX_GNT_SET_HW_PTA);
 
 		/* set path control owner to wl at runtime step */
@@ -1308,7 +1315,7 @@ static void rtw_coex_action_bt_idle(struct rtw_dev *rtwdev)
 			table_case = 112;
 			tdma_case = 104;
 		} else if ((coex_stat->bt_ble_scan_type & 0x2) &&
-			    coex_dm->bt_status == COEX_BTSTATUS_NCON_IDLE) {
+			   coex_dm->bt_status == COEX_BTSTATUS_NCON_IDLE) {
 			table_case = 114;
 			tdma_case = 103;
 		} else {
@@ -1631,11 +1638,10 @@ static void rtw_coex_action_bt_a2dp_hid(struct rtw_dev *rtwdev)
 		else
 			table_case = 9;
 
-		if (coex_stat->wl_gl_busy) {
+		if (coex_stat->wl_gl_busy)
 			tdma_case = 13;
-		} else {
+		else
 			tdma_case = 14;
-		}
 	} else {
 		/* Non-Shared-Ant */
 		if (coex_stat->bt_ble_exist)
@@ -2021,7 +2027,7 @@ static void rtw_coex_run_coex(struct rtw_dev *rtwdev, u8 reason)
 		rtw_coex_action_wl_not_connected(rtwdev);
 
 exit:
-	rtw_coex_set_gnt_fix(rtwdev);
+	rtw_coex_gnt_workaround(rtwdev, false, coex_stat->wl_coex_mode);
 	rtw_coex_limited_wl(rtwdev);
 }
 
@@ -2100,7 +2106,8 @@ void rtw_coex_power_on_setting(struct rtw_dev *rtwdev)
 	coex->wl_rf_off = false;
 
 	/* enable BB, we can write 0x948 */
-	rtw_write8_set(rtwdev, REG_SYS_FUNC_EN, BIT(0) | BIT(1));
+	rtw_write8_set(rtwdev, REG_SYS_FUNC_EN,
+		       BIT_FEN_BB_GLB_RST | BIT_FEN_BB_RSTB);
 
 	rtw_coex_monitor_bt_enable(rtwdev);
 	rtw_coex_set_rfe_type(rtwdev);
@@ -2138,7 +2145,6 @@ void rtw_coex_ips_notify(struct rtw_dev *rtwdev, u8 type)
 
 		/* run init hw config (exclude wifi only) */
 		__rtw_coex_init_hw_config(rtwdev, false);
-		/* sw all off */
 
 		coex_stat->wl_under_ips = false;
 	}
@@ -2304,7 +2310,7 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_chip_info *chip = rtwdev->chip;
-	unsigned long bt_relink_time;
+	u32 bt_relink_time;
 	u8 i, rsp_source = 0, type;
 	bool inq_page = false;
 
@@ -2413,7 +2419,7 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 	/* unit: % (value-100 to translate to unit: dBm in coex info) */
 	if (chip->bt_rssi_type == COEX_BTRSSI_RATIO) {
 		coex_stat->bt_rssi = coex_stat->bt_info_hb0 * 2 + 10;
-	} else { /* original unit: dbm -> unit: % ->  value-100 in coex info */
+	} else {
 		if (coex_stat->bt_info_hb0 <= 127)
 			coex_stat->bt_rssi = 100;
 		else if (256 - coex_stat->bt_info_hb0 <= 100)
@@ -2514,7 +2520,7 @@ void rtw_coex_wl_fwdbginfo_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 	rtw_coex_wl_ccklock_detect(rtwdev);
 }
 
-void rtw_coex_wl_status_change_notify(struct rtw_dev *rtwdev)
+void rtw_coex_wl_status_change_notify(struct rtw_dev *rtwdev, u32 type)
 {
 	struct rtw_coex *coex = &rtwdev->coex;
 
diff --git a/drivers/net/wireless/realtek/rtw88/coex.h b/drivers/net/wireless/realtek/rtw88/coex.h
index 44720fdfc053..e0d0be3f0dcf 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.h
+++ b/drivers/net/wireless/realtek/rtw88/coex.h
@@ -31,6 +31,7 @@
 #define TDMA_4SLOT	BIT(8)
 
 #define COEX_RSSI_STEP		4
+
 #define COEX_RSSI_HIGH(rssi) \
 	({ typeof(rssi) __rssi__ = rssi; \
 	   (__rssi__ == COEX_RSSI_STATE_HIGH || \
@@ -371,13 +372,12 @@ void rtw_coex_init_hw_config(struct rtw_dev *rtwdev, bool wifi_only);
 void rtw_coex_ips_notify(struct rtw_dev *rtwdev, u8 type);
 void rtw_coex_lps_notify(struct rtw_dev *rtwdev, u8 type);
 void rtw_coex_scan_notify(struct rtw_dev *rtwdev, u8 type);
-void rtw_coex_connect_notify(struct rtw_dev *rtwdev, u8 action);
-void rtw_coex_media_status_notify(struct rtw_dev *rtwdev, u8 status);
-void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 len);
+void rtw_coex_connect_notify(struct rtw_dev *rtwdev, u8 type);
+void rtw_coex_media_status_notify(struct rtw_dev *rtwdev, u8 type);
+void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length);
 void rtw_coex_wl_fwdbginfo_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length);
 void rtw_coex_switchband_notify(struct rtw_dev *rtwdev, u8 type);
-void rtw_coex_wl_status_change_notify(struct rtw_dev *rtwdev);
-
+void rtw_coex_wl_status_change_notify(struct rtw_dev *rtwdev, u32 type);
 void rtw_coex_display_coex_info(struct rtw_dev *rtwdev, struct seq_file *m);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 565efd880624..b3236c788467 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -196,7 +196,7 @@ static void rtw_watch_dog_work(struct work_struct *work)
 		clear_bit(RTW_FLAG_BUSY_TRAFFIC, rtwdev->flags);
 
 	if (busy_traffic != test_bit(RTW_FLAG_BUSY_TRAFFIC, rtwdev->flags))
-		rtw_coex_wl_status_change_notify(rtwdev);
+		rtw_coex_wl_status_change_notify(rtwdev, 0);
 
 	if (stats->tx_cnt > RTW_LPS_THRESHOLD ||
 	    stats->rx_cnt > RTW_LPS_THRESHOLD)
-- 
2.21.0

