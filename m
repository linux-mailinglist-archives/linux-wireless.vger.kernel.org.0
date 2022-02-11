Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C434B1F2E
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 08:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbiBKHQZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Feb 2022 02:16:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241343AbiBKHQX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Feb 2022 02:16:23 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A721124
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 23:16:21 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 21B7GDrlC011290, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 21B7GDrlC011290
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Feb 2022 15:16:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 11 Feb 2022 15:16:13 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 11 Feb
 2022 15:16:12 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <timlee@realtek.com>,
        <ku920601@realtek.com>
Subject: [PATCH 4/6] rtw88: coex: Add WL MIMO power saving for Bluetooth gaming controller
Date:   Fri, 11 Feb 2022 15:15:31 +0800
Message-ID: <20220211071533.34716-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211071533.34716-1-pkshih@realtek.com>
References: <20220211071533.34716-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 02/11/2022 07:03:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvMTEgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

To keep high sensitivity reaction, Bluetooth gaming controller will send
packet very frequently, it will make WL performance very poor. To solve
this situation, MIMO PS mechanism makes WL/BT own an antenna itself, WL
quits 2SS performance but it can get a stable 1SS performance and Bluetooth
gaming controller can keep sensitivity reaction at the same time.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c     | 113 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw88/coex.h     |   2 +
 drivers/net/wireless/realtek/rtw88/main.h     |   3 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |   1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |   1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |   1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  38 ++++--
 7 files changed, 148 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 0aca8f089ebb4..632151f081a51 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -211,6 +211,10 @@ static void rtw_coex_wl_ccklock_detect(struct rtw_dev *rtwdev)
 
 	bool is_cck_lock_rate = false;
 
+	if (coex_stat->wl_coex_mode != COEX_WLINK_2G1PORT &&
+	    coex_stat->wl_coex_mode != COEX_WLINK_2GFREE)
+		return;
+
 	if (coex_dm->bt_status == COEX_BTSTATUS_INQ_PAGE ||
 	    coex_stat->bt_setup_link) {
 		coex_stat->wl_cck_lock = false;
@@ -803,7 +807,9 @@ static void rtw_coex_update_bt_link_info(struct rtw_dev *rtwdev)
 static void rtw_coex_update_wl_ch_info(struct rtw_dev *rtwdev, u8 type)
 {
 	struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
 	struct rtw_coex_dm *coex_dm = &rtwdev->coex.dm;
+	struct rtw_coex_stat *coex_stat = &rtwdev->coex.stat;
 	u8 link = 0;
 	u8 center_chan = 0;
 	u8 bw;
@@ -814,7 +820,9 @@ static void rtw_coex_update_wl_ch_info(struct rtw_dev *rtwdev, u8 type)
 	if (type != COEX_MEDIA_DISCONNECT)
 		center_chan = rtwdev->hal.current_channel;
 
-	if (center_chan == 0) {
+	if (center_chan == 0 ||
+	    (efuse->share_ant && center_chan <= 14 &&
+	     coex_stat->wl_coex_mode != COEX_WLINK_2GFREE)) {
 		link = 0;
 		center_chan = 0;
 		bw = 0;
@@ -953,6 +961,23 @@ static void rtw_coex_set_gnt_wl(struct rtw_dev *rtwdev, u8 state)
 	rtw_coex_write_indirect_reg(rtwdev, LTE_COEX_CTRL, 0x0300, state);
 }
 
+static void rtw_coex_mimo_ps(struct rtw_dev *rtwdev, bool force, bool state)
+{
+	struct rtw_coex_stat *coex_stat = &rtwdev->coex.stat;
+
+	if (!force && state == coex_stat->wl_mimo_ps)
+		return;
+
+	coex_stat->wl_mimo_ps = state;
+
+	rtw_set_txrx_1ss(rtwdev, state);
+
+	rtw_coex_update_wl_ch_info(rtwdev, (u8)coex_stat->wl_connected);
+
+	rtw_dbg(rtwdev, RTW_DBG_COEX,
+		"[BTCoex], %s(): state = %d\n", __func__, state);
+}
+
 static void rtw_btc_wltoggle_table_a(struct rtw_dev *rtwdev, bool force,
 				     u8 table_case)
 {
@@ -1129,7 +1154,8 @@ static void rtw_coex_set_tdma(struct rtw_dev *rtwdev, u8 byte1, u8 byte2,
 
 		ps_type = COEX_PS_WIFI_NATIVE;
 		rtw_coex_power_save_state(rtwdev, ps_type, 0x0, 0x0);
-	} else if (byte1 & BIT(4) && !(byte1 & BIT(5))) {
+	} else if ((byte1 & BIT(4) && !(byte1 & BIT(5))) ||
+		   coex_stat->wl_coex_mode == COEX_WLINK_2GFREE) {
 		rtw_dbg(rtwdev, RTW_DBG_COEX,
 			"[BTCoex], %s(): Force LPS (byte1 = 0x%x)\n", __func__,
 			byte1);
@@ -1825,6 +1851,54 @@ static void rtw_coex_action_bt_inquiry(struct rtw_dev *rtwdev)
 	rtw_coex_tdma(rtwdev, false, tdma_case | slot_type);
 }
 
+static void rtw_coex_action_bt_game_hid(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u8 table_case, tdma_case;
+
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+
+	if (efuse->share_ant) {
+		coex_stat->wl_coex_mode = COEX_WLINK_2GFREE;
+		if (coex_stat->bt_whck_test)
+			table_case = 2;
+		else if (coex_stat->wl_linkscan_proc || coex_stat->bt_hid_exist)
+			table_case = 33;
+		else if (coex_stat->bt_setup_link || coex_stat->bt_inq_page)
+			table_case = 0;
+		else if (coex_stat->bt_a2dp_exist)
+			table_case = 34;
+		else
+			table_case = 33;
+
+		tdma_case = 0;
+	} else {
+		if (COEX_RSSI_HIGH(coex_dm->wl_rssi_state[1]))
+			tdma_case = 112;
+		else
+			tdma_case = 113;
+
+		table_case = 121;
+	}
+
+	if (coex_stat->wl_coex_mode == COEX_WLINK_2GFREE) {
+		if (coex_stat->wl_tput_dir == COEX_WL_TPUT_TX)
+			rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_tx[6]);
+		else
+			rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[5]);
+	} else {
+		rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+	}
+
+	rtw_coex_table(rtwdev, false, table_case);
+	rtw_coex_tdma(rtwdev, false, tdma_case);
+}
+
 static void rtw_coex_action_bt_hfp(struct rtw_dev *rtwdev)
 {
 	struct rtw_coex *coex = &rtwdev->coex;
@@ -2242,8 +2316,10 @@ static void rtw_coex_action_bt_a2dp_pan_hid(struct rtw_dev *rtwdev)
 
 static void rtw_coex_action_wl_under5g(struct rtw_dev *rtwdev)
 {
+	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
 	struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
 	u8 table_case, tdma_case;
 
 	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
@@ -2253,6 +2329,9 @@ static void rtw_coex_action_wl_under5g(struct rtw_dev *rtwdev)
 
 	rtw_coex_write_scbd(rtwdev, COEX_SCBD_FIX2M, false);
 
+	if (coex_stat->bt_game_hid_exist && coex_stat->wl_linkscan_proc)
+		coex_stat->wl_coex_mode = COEX_WLINK_2GFREE;
+
 	if (efuse->share_ant) {
 		/* Shared-Ant */
 		table_case = 0;
@@ -2440,6 +2519,7 @@ static void rtw_coex_action_wl_connected(struct rtw_dev *rtwdev)
 static void rtw_coex_run_coex(struct rtw_dev *rtwdev, u8 reason)
 {
 	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex_dm *coex_dm = &coex->dm;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	bool rf4ce_en = false;
@@ -2512,6 +2592,11 @@ static void rtw_coex_run_coex(struct rtw_dev *rtwdev, u8 reason)
 		goto exit;
 	}
 
+	if (coex_stat->bt_game_hid_exist && coex_stat->wl_connected) {
+		rtw_coex_action_bt_game_hid(rtwdev);
+		goto exit;
+	}
+
 	if (coex_stat->bt_whck_test) {
 		rtw_coex_action_bt_whql_test(rtwdev);
 		goto exit;
@@ -2548,6 +2633,18 @@ static void rtw_coex_run_coex(struct rtw_dev *rtwdev, u8 reason)
 	}
 
 exit:
+
+	if (chip->wl_mimo_ps_support) {
+		if (coex_stat->wl_coex_mode == COEX_WLINK_2GFREE) {
+			if (coex_dm->reason == COEX_RSN_2GMEDIA)
+				rtw_coex_mimo_ps(rtwdev, true, true);
+			else
+				rtw_coex_mimo_ps(rtwdev, false, true);
+		} else {
+			rtw_coex_mimo_ps(rtwdev, false, false);
+		}
+	}
+
 	rtw_coex_gnt_workaround(rtwdev, false, coex_stat->wl_coex_mode);
 	rtw_coex_limited_wl(rtwdev);
 }
@@ -3152,6 +3249,17 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 		coex_stat->bt_a2dp_bitpool = 0;
 
 	coex_stat->bt_a2dp_sink = ((coex_stat->bt_info_hb3 & BIT(7)) == BIT(7));
+	if (chip->wl_mimo_ps_support && !coex_stat->bt_inq_page) {
+		if ((coex_stat->bt_info_lb2 & COEX_INFO_CONNECTION) &&
+		    (coex_stat->hi_pri_tx + coex_stat->hi_pri_rx >
+		     COEX_BT_GAMEHID_CNT) && !coex_stat->bt_slave) {
+			coex_stat->bt_game_hid_exist = true;
+			rtw_dbg(rtwdev, RTW_DBG_COEX,
+				"[BTCoex], BT game controller exisit!!\n");
+		} else {
+			coex_stat->bt_game_hid_exist = false;
+		}
+	}
 
 	rtw_coex_update_bt_link_info(rtwdev);
 	rtw_coex_run_coex(rtwdev, COEX_RSN_BTINFO);
@@ -3666,6 +3774,7 @@ static const char *rtw_coex_get_wl_coex_mode(u8 coex_wl_link_mode)
 	switch (coex_wl_link_mode) {
 	case_WLINK(2G1PORT);
 	case_WLINK(5G);
+	case_WLINK(2GFREE);
 	default:
 		return "Unknown";
 	}
diff --git a/drivers/net/wireless/realtek/rtw88/coex.h b/drivers/net/wireless/realtek/rtw88/coex.h
index 60a701c8ac13f..498b6432e7f8e 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.h
+++ b/drivers/net/wireless/realtek/rtw88/coex.h
@@ -11,6 +11,7 @@
 
 #define COEX_MIN_DELAY		10 /* delay unit in ms */
 #define COEX_RFK_TIMEOUT	600 /* RFK timeout in ms */
+#define COEX_BT_GAMEHID_CNT	800
 
 #define COEX_RF_OFF	0x0
 #define COEX_RF_ON	0x1
@@ -172,6 +173,7 @@ enum coex_bt_profile {
 enum coex_wl_link_mode {
 	COEX_WLINK_2G1PORT	= 0x0,
 	COEX_WLINK_5G		= 0x3,
+	COEX_WLINK_2GFREE	= 0x7,
 	COEX_WLINK_MAX
 };
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 970d29d19003d..e62b085d7b146 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1242,6 +1242,7 @@ struct rtw_chip_info {
 	bool scbd_support;
 	bool new_scbd10_def; /* true: fix 2M(8822c) */
 	bool ble_hid_profile_support;
+	bool wl_mimo_ps_support;
 	u8 pstdma_type; /* 0: LPSoff, 1:LPSon */
 	u8 bt_rssi_type;
 	u8 ant_isolation;
@@ -1384,6 +1385,7 @@ struct rtw_coex_stat {
 	bool bt_slave;
 	bool bt_418_hid_exist;
 	bool bt_ble_hid_exist;
+	bool bt_game_hid_exist;
 	bool bt_mailbox_reply;
 
 	bool wl_under_lps;
@@ -1404,6 +1406,7 @@ struct rtw_coex_stat {
 	bool wl_connecting;
 	bool wl_slot_toggle;
 	bool wl_slot_toggle_change; /* if toggle to no-toggle */
+	bool wl_mimo_ps;
 
 	u32 bt_supported_version;
 	u32 bt_supported_feature;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 3fdbaf7302c5e..ad2b323a0423c 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -2753,6 +2753,7 @@ struct rtw_chip_info rtw8723d_hw_spec = {
 	.scbd_support = true,
 	.new_scbd10_def = true,
 	.ble_hid_profile_support = false,
+	.wl_mimo_ps_support = false,
 	.pstdma_type = COEX_PSTDMA_FORCE_LPSOFF,
 	.bt_rssi_type = COEX_BTRSSI_RATIO,
 	.ant_isolation = 15,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index b1f4afb508308..a1ae1e7e59f67 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1925,6 +1925,7 @@ struct rtw_chip_info rtw8821c_hw_spec = {
 	.scbd_support = true,
 	.new_scbd10_def = false,
 	.ble_hid_profile_support = false,
+	.wl_mimo_ps_support = false,
 	.pstdma_type = COEX_PSTDMA_FORCE_LPSOFF,
 	.bt_rssi_type = COEX_BTRSSI_RATIO,
 	.ant_isolation = 15,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index dd4fbb82750d5..c9cedc349924a 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2554,6 +2554,7 @@ struct rtw_chip_info rtw8822b_hw_spec = {
 	.scbd_support = true,
 	.new_scbd10_def = false,
 	.ble_hid_profile_support = false,
+	.wl_mimo_ps_support = false,
 	.pstdma_type = COEX_PSTDMA_FORCE_LPSOFF,
 	.bt_rssi_type = COEX_BTRSSI_RATIO,
 	.ant_isolation = 15,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 01bb356b4b65f..39daca4405935 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -2996,19 +2996,34 @@ static void rtw8822c_coex_cfg_gnt_fix(struct rtw_dev *rtwdev)
 	 * enable "DAC off if GNT_WL = 0" for non-shared-antenna
 	 * disable 0x1c30[22] = 0,
 	 * enable: 0x1c30[22] = 1, 0x1c38[12] = 0, 0x1c38[28] = 1
-	 *
-	 * disable WL-S1 BB chage RF mode if GNT_BT
+	 */
+	if (coex_stat->wl_coex_mode == COEX_WLINK_2GFREE) {
+		rtw_write8_mask(rtwdev, REG_ANAPAR + 2,
+				BIT_ANAPAR_BTPS >> 16, 0);
+	} else {
+		rtw_write8_mask(rtwdev, REG_ANAPAR + 2,
+				BIT_ANAPAR_BTPS >> 16, 1);
+		rtw_write8_mask(rtwdev, REG_RSTB_SEL + 1,
+				BIT_DAC_OFF_ENABLE, 0);
+		rtw_write8_mask(rtwdev, REG_RSTB_SEL + 3,
+				BIT_DAC_OFF_ENABLE, 1);
+	}
+
+	/* disable WL-S1 BB chage RF mode if GNT_BT
 	 * since RF TRx mask can do it
 	 */
-	rtw_write8_mask(rtwdev, REG_ANAPAR + 2, BIT_ANAPAR_BTPS >> 16, 1);
-	rtw_write8_mask(rtwdev, REG_RSTB_SEL + 1, BIT_DAC_OFF_ENABLE, 0);
-	rtw_write8_mask(rtwdev, REG_RSTB_SEL + 3, BIT_DAC_OFF_ENABLE, 1);
-	rtw_write8_mask(rtwdev, REG_IGN_GNTBT4, BIT_PI_IGNORE_GNT_BT, 1);
+	rtw_write8_mask(rtwdev, REG_IGN_GNTBT4,
+			BIT_PI_IGNORE_GNT_BT, 1);
 
 	/* disable WL-S0 BB chage RF mode if wifi is at 5G,
 	 * or antenna path is separated
 	 */
-	if (coex_stat->wl_coex_mode == COEX_WLINK_5G ||
+	if (coex_stat->wl_coex_mode == COEX_WLINK_2GFREE) {
+		rtw_write8_mask(rtwdev, REG_IGN_GNT_BT1,
+				BIT_PI_IGNORE_GNT_BT, 1);
+		rtw_write8_mask(rtwdev, REG_NOMASK_TXBT,
+				BIT_NOMASK_TXBT_ENABLE, 1);
+	} else if (coex_stat->wl_coex_mode == COEX_WLINK_5G ||
 	    coex->under_5g || !efuse->share_ant) {
 		if (coex_stat->kt_ver >= 3) {
 			rtw_write8_mask(rtwdev, REG_IGN_GNT_BT1,
@@ -5008,6 +5023,8 @@ static const struct coex_table_para table_sant_8822c[] = {
 	{0x66556aaa, 0x6a5a6aaa}, /*case-30*/
 	{0xffffffff, 0x5aaa5aaa},
 	{0x56555555, 0x5a5a5aaa},
+	{0xdaffdaff, 0xdaffdaff},
+	{0xddffddff, 0xddffddff},
 };
 
 /* Non-Shared-Antenna Coex Table */
@@ -5108,7 +5125,8 @@ static const struct coex_rf_para rf_para_tx_8822c[] = {
 	{8, 17, true, 4},
 	{7, 18, true, 4},
 	{6, 19, true, 4},
-	{5, 20, true, 4}
+	{5, 20, true, 4},
+	{0, 21, true, 4}   /* for gamg hid */
 };
 
 static const struct coex_rf_para rf_para_rx_8822c[] = {
@@ -5117,7 +5135,8 @@ static const struct coex_rf_para rf_para_rx_8822c[] = {
 	{3, 24, true, 5},
 	{2, 26, true, 5},
 	{1, 27, true, 5},
-	{0, 28, true, 5}
+	{0, 28, true, 5},
+	{0, 28, true, 5}   /* for gamg hid */
 };
 
 static_assert(ARRAY_SIZE(rf_para_tx_8822c) == ARRAY_SIZE(rf_para_rx_8822c));
@@ -5360,6 +5379,7 @@ struct rtw_chip_info rtw8822c_hw_spec = {
 	.scbd_support = true,
 	.new_scbd10_def = true,
 	.ble_hid_profile_support = true,
+	.wl_mimo_ps_support = true,
 	.pstdma_type = COEX_PSTDMA_FORCE_LPSOFF,
 	.bt_rssi_type = COEX_BTRSSI_DBM,
 	.ant_isolation = 15,
-- 
2.25.1

