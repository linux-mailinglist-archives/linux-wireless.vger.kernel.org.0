Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C9B2C4D2D
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Nov 2020 03:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733016AbgKZCM2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Nov 2020 21:12:28 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:60677 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732921AbgKZCM1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Nov 2020 21:12:27 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AQ2CLO50030358, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AQ2CLO50030358
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
Subject: [PATCH v2 10/10] rtw88: coex: add feature to enhance HID coexistence performance
Date:   Thu, 26 Nov 2020 10:10:59 +0800
Message-ID: <20201126021059.11981-11-pkshih@realtek.com>
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

Add toggle table related function to enhance WL throughput when WL coexist
with 4/18 HID.
The toggle table feature will toggle WL/BT priority table during WL slot,
it can decrease the impact from HID's frequently packets and prevent HID
lag.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
  * fix "set but not used" warnings reported by kernel test robot on
    PATCH 9/10.
    I move some variables from PATCH 9/10 because they are used in this
    patch.
---
 drivers/net/wireless/realtek/rtw88/coex.c | 102 ++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw88/coex.h |   3 +
 drivers/net/wireless/realtek/rtw88/main.h |   5 ++
 3 files changed, 104 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 4d921e9d8956..c704c6885a18 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -937,6 +937,69 @@ static void rtw_coex_set_gnt_wl(struct rtw_dev *rtwdev, u8 state)
 	rtw_coex_write_indirect_reg(rtwdev, LTE_COEX_CTRL, 0x0300, state);
 }
 
+static void rtw_btc_wltoggle_table_a(struct rtw_dev *rtwdev, bool force,
+				     u8 table_case)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	u8 h2c_para[6] = {0};
+	u32 table_wl = 0x5a5a5a5a;
+
+	h2c_para[0] = COEX_H2C69_TOGGLE_TABLE_A;
+	/* no definition */
+	h2c_para[1] = 0x1;
+
+	if (efuse->share_ant) {
+		if (table_case < chip->table_sant_num)
+			table_wl = chip->table_sant[table_case].wl;
+	} else {
+		if (table_case < chip->table_nsant_num)
+			table_wl = chip->table_nsant[table_case].wl;
+	}
+
+	/* tell WL FW WL slot toggle table-A*/
+	h2c_para[2] = (u8)u32_get_bits(table_wl, GENMASK(7, 0));
+	h2c_para[3] = (u8)u32_get_bits(table_wl, GENMASK(15, 8));
+	h2c_para[4] = (u8)u32_get_bits(table_wl, GENMASK(23, 16));
+	h2c_para[5] = (u8)u32_get_bits(table_wl, GENMASK(31, 24));
+
+	rtw_fw_bt_wifi_control(rtwdev, h2c_para[0], &h2c_para[1]);
+
+	rtw_dbg(rtwdev, RTW_DBG_COEX,
+		"[BTCoex], %s(): H2C = [%02x %02x %02x %02x %02x %02x]\n",
+		__func__, h2c_para[0], h2c_para[1], h2c_para[2],
+		h2c_para[3], h2c_para[4], h2c_para[5]);
+}
+
+#define COEX_WL_SLOT_TOGLLE 0x5a5a5aaa
+static void rtw_btc_wltoggle_table_b(struct rtw_dev *rtwdev, bool force,
+				     u8 interval, u32 table)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	u8 cur_h2c_para[6] = {0};
+	u8 i;
+
+	cur_h2c_para[0] = COEX_H2C69_TOGGLE_TABLE_B;
+	cur_h2c_para[1] = interval;
+	cur_h2c_para[2] = (u8)u32_get_bits(table, GENMASK(7, 0));
+	cur_h2c_para[3] = (u8)u32_get_bits(table, GENMASK(15, 8));
+	cur_h2c_para[4] = (u8)u32_get_bits(table, GENMASK(23, 16));
+	cur_h2c_para[5] = (u8)u32_get_bits(table, GENMASK(31, 24));
+
+	coex_stat->wl_toggle_interval = interval;
+
+	for (i = 0; i <= 5; i++)
+		coex_stat->wl_toggle_para[i] = cur_h2c_para[i];
+
+	rtw_fw_bt_wifi_control(rtwdev, cur_h2c_para[0], &cur_h2c_para[1]);
+
+	rtw_dbg(rtwdev, RTW_DBG_COEX,
+		"[BTCoex], %s(): H2C = [%02x %02x %02x %02x %02x %02x]\n",
+		__func__, cur_h2c_para[0], cur_h2c_para[1], cur_h2c_para[2],
+		cur_h2c_para[3], cur_h2c_para[4], cur_h2c_para[5]);
+}
+
 static void rtw_coex_set_table(struct rtw_dev *rtwdev, bool force, u32 table0,
 			       u32 table1)
 {
@@ -965,6 +1028,7 @@ static void rtw_coex_table(struct rtw_dev *rtwdev, bool force, u8 type)
 	struct rtw_coex_dm *coex_dm = &coex->dm;
 	struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
 
 	coex_dm->cur_table = type;
 
@@ -982,6 +1046,8 @@ static void rtw_coex_table(struct rtw_dev *rtwdev, bool force, u8 type)
 					   chip->table_nsant[type].bt,
 					   chip->table_nsant[type].wl);
 	}
+	if (coex_stat->wl_slot_toggle_change)
+		rtw_btc_wltoggle_table_a(rtwdev, true, type);
 }
 
 static void rtw_coex_ignore_wlan_act(struct rtw_dev *rtwdev, bool enable)
@@ -1031,6 +1097,7 @@ static void rtw_coex_set_tdma(struct rtw_dev *rtwdev, u8 byte1, u8 byte2,
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_dm *coex_dm = &coex->dm;
 	struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
 	u8 ps_type = COEX_PS_WIFI_NATIVE;
 	bool ap_enable = false;
 
@@ -1072,6 +1139,14 @@ static void rtw_coex_set_tdma(struct rtw_dev *rtwdev, u8 byte1, u8 byte2,
 	coex_dm->ps_tdma_para[4] = byte5;
 
 	rtw_fw_coex_tdma_type(rtwdev, byte1, byte2, byte3, byte4, byte5);
+
+	if (byte1 & BIT(2)) {
+		coex_stat->wl_slot_toggle = true;
+		coex_stat->wl_slot_toggle_change = false;
+	} else {
+		coex_stat->wl_slot_toggle_change = coex_stat->wl_slot_toggle;
+		coex_stat->wl_slot_toggle = false;
+	}
 }
 
 static void rtw_coex_tdma(struct rtw_dev *rtwdev, bool force, u32 tcase)
@@ -1776,7 +1851,7 @@ static void rtw_coex_action_bt_hid(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 	u32 slot_type = 0;
-	bool bt_multi_link_remain = false;
+	bool bt_multi_link_remain = false, is_toggle_table = false;
 
 	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
 	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
@@ -1809,6 +1884,7 @@ static void rtw_coex_action_bt_hid(struct rtw_dev *rtwdev)
 				tdma_case = 18;
 			} else if (coex_stat->bt_418_hid_exist &&
 				   coex_stat->wl_gl_busy) {
+				is_toggle_table = true;
 				slot_type = TDMA_4SLOT;
 				table_case = 9;
 				tdma_case = 24;
@@ -1842,6 +1918,11 @@ static void rtw_coex_action_bt_hid(struct rtw_dev *rtwdev)
 	}
 
 	rtw_coex_table(rtwdev, false, table_case);
+	if (is_toggle_table) {
+		rtw_btc_wltoggle_table_a(rtwdev, true, table_case);
+		rtw_btc_wltoggle_table_b(rtwdev, false, 1, COEX_WL_SLOT_TOGLLE);
+	}
+
 	rtw_coex_tdma(rtwdev, false, tdma_case | slot_type);
 }
 
@@ -1970,8 +2051,9 @@ static void rtw_coex_action_bt_a2dp_hid(struct rtw_dev *rtwdev)
 	struct rtw_coex_dm *coex_dm = &coex->dm;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
 	struct rtw_chip_info *chip = rtwdev->chip;
-	u8 table_case, tdma_case;
+	u8 table_case, tdma_case, interval;
 	u32 slot_type = 0;
+	bool is_toggle_table = false;
 
 	slot_type = TDMA_4SLOT;
 
@@ -1981,15 +2063,19 @@ static void rtw_coex_action_bt_a2dp_hid(struct rtw_dev *rtwdev)
 
 	if (efuse->share_ant) {
 		/* Shared-Ant */
-		if (coex_stat->bt_ble_exist)
+		if (coex_stat->bt_ble_exist) {
 			table_case = 26; /* for RCU */
-		else
+		} else if (coex_stat->bt_418_hid_exist) {
+			table_case = 9;
+			interval = 1;
+		} else {
 			table_case = 9;
+		}
 
 		if (coex_stat->wl_connecting || !coex_stat->wl_gl_busy) {
 			tdma_case = 14;
-		} else if (coex_stat->bt_418_hid_exist ||
-			   coex_stat->bt_ble_hid_exist) {
+		} else if (coex_stat->bt_418_hid_exist) {
+			is_toggle_table = true;
 			tdma_case = 23;
 		} else {
 			tdma_case = 13;
@@ -2008,6 +2094,10 @@ static void rtw_coex_action_bt_a2dp_hid(struct rtw_dev *rtwdev)
 	}
 
 	rtw_coex_table(rtwdev, false, table_case);
+	if (is_toggle_table) {
+		rtw_btc_wltoggle_table_a(rtwdev, true, table_case);
+		rtw_btc_wltoggle_table_b(rtwdev, false, interval, COEX_WL_SLOT_TOGLLE);
+	}
 	rtw_coex_tdma(rtwdev, false, tdma_case | slot_type);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/coex.h b/drivers/net/wireless/realtek/rtw88/coex.h
index c4898132702f..8ab9852ec9ed 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.h
+++ b/drivers/net/wireless/realtek/rtw88/coex.h
@@ -25,6 +25,9 @@
 #define PARA1_H2C69_TBTT_TIMES	GENMASK(5, 0)
 #define PARA1_H2C69_TBTT_DIV100	BIT(7)
 
+#define COEX_H2C69_TOGGLE_TABLE_A 0xd
+#define COEX_H2C69_TOGGLE_TABLE_B 0x7
+
 #define TDMA_4SLOT	BIT(8)
 
 #define TDMA_TIMER_TYPE_2SLOT 0
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 4e1369298a82..9a318dfd04f9 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1335,6 +1335,8 @@ struct rtw_coex_stat {
 	bool wl_cck_lock_pre;
 	bool wl_cck_lock_ever;
 	bool wl_connecting;
+	bool wl_slot_toggle;
+	bool wl_slot_toggle_change; /* if toggle to no-toggle */
 
 	u32 bt_supported_version;
 	u32 bt_supported_feature;
@@ -1375,6 +1377,9 @@ struct rtw_coex_stat {
 	u8 ampdu_max_time;
 	u8 wl_tput_dir;
 
+	u8 wl_toggle_para[6];
+	u8 wl_toggle_interval;
+
 	u16 score_board;
 	u16 retry_limit;
 
-- 
2.21.0

