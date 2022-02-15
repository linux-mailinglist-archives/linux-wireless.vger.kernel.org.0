Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712054B5F56
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Feb 2022 01:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiBOAtx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 19:49:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiBOAtv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 19:49:51 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9C413C3A9
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 16:49:41 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 21F0nYRC1021054, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 21F0nYRC1021054
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 15 Feb 2022 08:49:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 15 Feb 2022 08:49:33 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 15 Feb
 2022 08:49:33 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <timlee@realtek.com>,
        <ku920601@realtek.com>
Subject: [PATCH v2 5/6] rtw88: coex: Add C2H/H2C handshake with BT mailbox for asking HID Info
Date:   Tue, 15 Feb 2022 08:48:54 +0800
Message-ID: <20220215004855.4098-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220215004855.4098-1-pkshih@realtek.com>
References: <20220215004855.4098-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 02/15/2022 00:31:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvMTQgpFWkyCAwODo0MjowMA==?=
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

In order to recognize the gaming controller HID, make a C2H/H2C/Mailbox
handshake to collect all the connected information from BT.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 150 ++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw88/coex.h |   2 +
 drivers/net/wireless/realtek/rtw88/fw.c   |  15 +++
 drivers/net/wireless/realtek/rtw88/fw.h   |   9 ++
 drivers/net/wireless/realtek/rtw88/main.c |   1 +
 drivers/net/wireless/realtek/rtw88/main.h |  40 ++++++
 6 files changed, 206 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 632151f081a51..cac053f485c3b 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -2375,6 +2375,7 @@ static void rtw_coex_action_wl_native_lps(struct rtw_dev *rtwdev)
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
 	struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
 	u8 table_case, tdma_case;
 
 	if (coex->under_5g)
@@ -2383,7 +2384,6 @@ static void rtw_coex_action_wl_native_lps(struct rtw_dev *rtwdev)
 	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
 
 	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 
 	if (efuse->share_ant) {
 		/* Shared-Ant */
@@ -2395,6 +2395,16 @@ static void rtw_coex_action_wl_native_lps(struct rtw_dev *rtwdev)
 		tdma_case = 100;
 	}
 
+	if (coex_stat->bt_game_hid_exist) {
+		coex_stat->wl_coex_mode = COEX_WLINK_2GFREE;
+		if (coex_stat->wl_tput_dir == COEX_WL_TPUT_TX)
+			rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_tx[6]);
+		else
+			rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[5]);
+	} else {
+		rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+	}
+
 	rtw_coex_table(rtwdev, false, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
@@ -3249,20 +3259,138 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 		coex_stat->bt_a2dp_bitpool = 0;
 
 	coex_stat->bt_a2dp_sink = ((coex_stat->bt_info_hb3 & BIT(7)) == BIT(7));
-	if (chip->wl_mimo_ps_support && !coex_stat->bt_inq_page) {
-		if ((coex_stat->bt_info_lb2 & COEX_INFO_CONNECTION) &&
-		    (coex_stat->hi_pri_tx + coex_stat->hi_pri_rx >
-		     COEX_BT_GAMEHID_CNT) && !coex_stat->bt_slave) {
-			coex_stat->bt_game_hid_exist = true;
-			rtw_dbg(rtwdev, RTW_DBG_COEX,
-				"[BTCoex], BT game controller exisit!!\n");
+
+	rtw_coex_update_bt_link_info(rtwdev);
+	rtw_coex_run_coex(rtwdev, COEX_RSN_BTINFO);
+}
+
+#define COEX_BT_HIDINFO_MTK	0x46
+static const u8 coex_bt_hidinfo_ps[] = {0x57, 0x69, 0x72};
+static const u8 coex_bt_hidinfo_xb[] = {0x58, 0x62, 0x6f};
+
+void rtw_coex_bt_hid_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	struct rtw_coex_hid *hidinfo;
+	struct rtw_coex_hid_info_a *hida;
+	struct rtw_coex_hid_handle_list *hl, *bhl;
+	u8 sub_id = buf[2], gamehid_cnt = 0, handle, i;
+	bool cur_game_hid_exist, complete;
+
+	if (!chip->wl_mimo_ps_support &&
+	    (sub_id == COEX_BT_HIDINFO_LIST || sub_id == COEX_BT_HIDINFO_A))
+		return;
+
+	rtw_dbg(rtwdev, RTW_DBG_COEX,
+		"[BTCoex], HID info notify, sub_id = 0x%x\n", sub_id);
+
+	switch (sub_id) {
+	case COEX_BT_HIDINFO_LIST:
+		hl = &coex_stat->hid_handle_list;
+		bhl = (struct rtw_coex_hid_handle_list *)buf;
+		if (!memcmp(hl, bhl, sizeof(*hl)))
+			return;
+		coex_stat->hid_handle_list = *bhl;
+		memset(&coex_stat->hid_info, 0, sizeof(coex_stat->hid_info));
+		for (i = 0; i < COEX_BT_HIDINFO_HANDLE_NUM; i++) {
+			hidinfo = &coex_stat->hid_info[i];
+			if (hl->handle[i] != COEX_BT_HIDINFO_NOTCON &&
+			    hl->handle[i] != 0)
+				hidinfo->hid_handle = hl->handle[i];
+		}
+		break;
+	case COEX_BT_HIDINFO_A:
+		hida = (struct rtw_coex_hid_info_a *)buf;
+		handle = hida->handle;
+		for (i = 0; i < COEX_BT_HIDINFO_HANDLE_NUM; i++) {
+			hidinfo = &coex_stat->hid_info[i];
+			if (hidinfo->hid_handle == handle) {
+				hidinfo->hid_vendor = hida->vendor;
+				memcpy(hidinfo->hid_name, hida->name,
+				       sizeof(hidinfo->hid_name));
+				hidinfo->hid_info_completed = true;
+				break;
+			}
+		}
+		break;
+	}
+	for (i = 0; i < COEX_BT_HIDINFO_HANDLE_NUM; i++) {
+		hidinfo = &coex_stat->hid_info[i];
+		complete = hidinfo->hid_info_completed;
+		handle = hidinfo->hid_handle;
+		if (!complete || handle == COEX_BT_HIDINFO_NOTCON ||
+		    handle == 0 || handle >= COEX_BT_BLE_HANDLE_THRS) {
+			hidinfo->is_game_hid = false;
+			continue;
+		}
+
+		if (hidinfo->hid_vendor == COEX_BT_HIDINFO_MTK) {
+			if ((memcmp(hidinfo->hid_name,
+				    coex_bt_hidinfo_ps,
+				    COEX_BT_HIDINFO_NAME)) == 0)
+				hidinfo->is_game_hid = true;
+			else if ((memcmp(hidinfo->hid_name,
+					 coex_bt_hidinfo_xb,
+					 COEX_BT_HIDINFO_NAME)) == 0)
+				hidinfo->is_game_hid = true;
+			else
+				hidinfo->is_game_hid = false;
 		} else {
-			coex_stat->bt_game_hid_exist = false;
+			hidinfo->is_game_hid = false;
 		}
+		if (hidinfo->is_game_hid)
+			gamehid_cnt++;
 	}
 
-	rtw_coex_update_bt_link_info(rtwdev);
-	rtw_coex_run_coex(rtwdev, COEX_RSN_BTINFO);
+	if (gamehid_cnt > 0)
+		cur_game_hid_exist = true;
+	else
+		cur_game_hid_exist = false;
+
+	if (cur_game_hid_exist != coex_stat->bt_game_hid_exist) {
+		coex_stat->bt_game_hid_exist = cur_game_hid_exist;
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], HID info changed!bt_game_hid_exist = %d!\n",
+			coex_stat->bt_game_hid_exist);
+		rtw_coex_run_coex(rtwdev, COEX_RSN_BTSTATUS);
+	}
+}
+
+void rtw_coex_query_bt_hid_list(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+	struct rtw_coex_hid *hidinfo;
+	u8 i, handle;
+	bool complete;
+
+	if (!chip->wl_mimo_ps_support || coex_stat->wl_under_ips ||
+	    (coex_stat->wl_under_lps && !coex_stat->wl_force_lps_ctrl))
+		return;
+
+	if (!coex_stat->bt_hid_exist &&
+	    !((coex_stat->bt_info_lb2 & COEX_INFO_CONNECTION) &&
+	      (coex_stat->hi_pri_tx + coex_stat->hi_pri_rx >
+	       COEX_BT_GAMEHID_CNT)))
+		return;
+
+	rtw_fw_coex_query_hid_info(rtwdev, COEX_BT_HIDINFO_LIST, 0);
+
+	for (i = 0; i < COEX_BT_HIDINFO_HANDLE_NUM; i++) {
+		hidinfo = &coex_stat->hid_info[i];
+		complete = hidinfo->hid_info_completed;
+		handle = hidinfo->hid_handle;
+		if (handle == 0 || handle == COEX_BT_HIDINFO_NOTCON ||
+		    handle >= COEX_BT_BLE_HANDLE_THRS || complete)
+			continue;
+
+		rtw_fw_coex_query_hid_info(rtwdev,
+					   COEX_BT_HIDINFO_A,
+					   handle);
+	}
 }
 
 void rtw_coex_wl_fwdbginfo_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
diff --git a/drivers/net/wireless/realtek/rtw88/coex.h b/drivers/net/wireless/realtek/rtw88/coex.h
index 498b6432e7f8e..07fa7aa34d4ba 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.h
+++ b/drivers/net/wireless/realtek/rtw88/coex.h
@@ -403,10 +403,12 @@ void rtw_coex_scan_notify(struct rtw_dev *rtwdev, u8 type);
 void rtw_coex_connect_notify(struct rtw_dev *rtwdev, u8 type);
 void rtw_coex_media_status_notify(struct rtw_dev *rtwdev, u8 type);
 void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length);
+void rtw_coex_bt_hid_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length);
 void rtw_coex_wl_fwdbginfo_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length);
 void rtw_coex_switchband_notify(struct rtw_dev *rtwdev, u8 type);
 void rtw_coex_wl_status_change_notify(struct rtw_dev *rtwdev, u32 type);
 void rtw_coex_wl_status_check(struct rtw_dev *rtwdev);
+void rtw_coex_query_bt_hid_list(struct rtw_dev *rtwdev);
 void rtw_coex_display_coex_info(struct rtw_dev *rtwdev, struct seq_file *m);
 
 static inline bool rtw_coex_disabled(struct rtw_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 4c8e5ea5d069c..ac581df6290e8 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -233,6 +233,9 @@ void rtw_fw_c2h_cmd_handle(struct rtw_dev *rtwdev, struct sk_buff *skb)
 	case C2H_BT_INFO:
 		rtw_coex_bt_info_notify(rtwdev, c2h->payload, len);
 		break;
+	case C2H_BT_HID_INFO:
+		rtw_coex_bt_hid_info_notify(rtwdev, c2h->payload, len);
+		break;
 	case C2H_WLAN_INFO:
 		rtw_coex_wl_fwdbginfo_notify(rtwdev, c2h->payload, len);
 		break;
@@ -538,6 +541,18 @@ void rtw_fw_coex_tdma_type(struct rtw_dev *rtwdev,
 	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
 }
 
+void rtw_fw_coex_query_hid_info(struct rtw_dev *rtwdev, u8 sub_id, u8 data)
+{
+	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
+
+	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_QUERY_BT_HID_INFO);
+
+	SET_COEX_QUERY_HID_INFO_SUBID(h2c_pkt, sub_id);
+	SET_COEX_QUERY_HID_INFO_DATA1(h2c_pkt, data);
+
+	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+}
+
 void rtw_fw_bt_wifi_control(struct rtw_dev *rtwdev, u8 op_code, u8 *data)
 {
 	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 654c3c2e57218..b59d2cbad5d73 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -47,6 +47,7 @@ enum rtw_c2h_cmd_id {
 	C2H_CCX_TX_RPT = 0x03,
 	C2H_BT_INFO = 0x09,
 	C2H_BT_MP_INFO = 0x0b,
+	C2H_BT_HID_INFO = 0x45,
 	C2H_RA_RPT = 0x0c,
 	C2H_HW_FEATURE_REPORT = 0x19,
 	C2H_WLAN_INFO = 0x27,
@@ -529,6 +530,7 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 #define H2C_CMD_QUERY_BT_MP_INFO	0x67
 #define H2C_CMD_BT_WIFI_CONTROL		0x69
 #define H2C_CMD_WIFI_CALIBRATION	0x6d
+#define H2C_CMD_QUERY_BT_HID_INFO	0x73
 
 #define H2C_CMD_KEEP_ALIVE		0x03
 #define H2C_CMD_DISCONNECT_DECISION	0x04
@@ -681,6 +683,11 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 #define SET_BT_WIFI_CONTROL_DATA5(h2c_pkt, value)                              \
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x01, value, GENMASK(23, 16))
 
+#define SET_COEX_QUERY_HID_INFO_SUBID(h2c_pkt, value)                          \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(15, 8))
+#define SET_COEX_QUERY_HID_INFO_DATA1(h2c_pkt, value)                          \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(23, 16))
+
 #define SET_KEEP_ALIVE_ENABLE(h2c_pkt, value)				       \
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(8))
 #define SET_KEEP_ALIVE_ADOPT(h2c_pkt, value)				       \
@@ -780,6 +787,8 @@ void rtw_fw_force_bt_tx_power(struct rtw_dev *rtwdev, u8 bt_pwr_dec_lvl);
 void rtw_fw_bt_ignore_wlan_action(struct rtw_dev *rtwdev, bool enable);
 void rtw_fw_coex_tdma_type(struct rtw_dev *rtwdev,
 			   u8 para1, u8 para2, u8 para3, u8 para4, u8 para5);
+void rtw_fw_coex_query_hid_info(struct rtw_dev *rtwdev, u8 sub_id, u8 data);
+
 void rtw_fw_bt_wifi_control(struct rtw_dev *rtwdev, u8 op_code, u8 *data);
 void rtw_fw_send_rssi_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si);
 void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index da4657ac7c30b..79a8e0282aa0b 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -208,6 +208,7 @@ static void rtw_watch_dog_work(struct work_struct *work)
 		clear_bit(RTW_FLAG_BUSY_TRAFFIC, rtwdev->flags);
 
 	rtw_coex_wl_status_check(rtwdev);
+	rtw_coex_query_bt_hid_list(rtwdev);
 
 	if (busy_traffic != test_bit(RTW_FLAG_BUSY_TRAFFIC, rtwdev->flags))
 		rtw_coex_wl_status_change_notify(rtwdev, 0);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index e62b085d7b146..17815af9dd4ea 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1355,6 +1355,42 @@ struct rtw_coex_dm {
 #define COEX_BTINFO_LENGTH_MAX	10
 #define COEX_BTINFO_LENGTH	7
 
+#define COEX_BT_HIDINFO_LIST	0x0
+#define COEX_BT_HIDINFO_A	0x1
+#define COEX_BT_HIDINFO_NAME	3
+
+#define COEX_BT_HIDINFO_LENGTH	6
+#define COEX_BT_HIDINFO_HANDLE_NUM	4
+#define COEX_BT_HIDINFO_C2H_HANDLE	0
+#define COEX_BT_HIDINFO_C2H_VENDOR	1
+#define COEX_BT_BLE_HANDLE_THRS	0x10
+#define COEX_BT_HIDINFO_NOTCON	0xff
+
+struct rtw_coex_hid {
+	u8 hid_handle;
+	u8 hid_vendor;
+	u8 hid_name[COEX_BT_HIDINFO_NAME];
+	bool hid_info_completed;
+	bool is_game_hid;
+};
+
+struct rtw_coex_hid_handle_list {
+	u8 cmd_id;
+	u8 len;
+	u8 subid;
+	u8 handle_cnt;
+	u8 handle[COEX_BT_HIDINFO_HANDLE_NUM];
+} __packed;
+
+struct rtw_coex_hid_info_a {
+	u8 cmd_id;
+	u8 len;
+	u8 subid;
+	u8 handle;
+	u8 vendor;
+	u8 name[COEX_BT_HIDINFO_NAME];
+} __packed;
+
 struct rtw_coex_stat {
 	bool bt_disabled;
 	bool bt_disabled_pre;
@@ -1386,6 +1422,7 @@ struct rtw_coex_stat {
 	bool bt_418_hid_exist;
 	bool bt_ble_hid_exist;
 	bool bt_game_hid_exist;
+	bool bt_hid_handle_cnt;
 	bool bt_mailbox_reply;
 
 	bool wl_under_lps;
@@ -1464,6 +1501,9 @@ struct rtw_coex_stat {
 
 	u32 darfrc;
 	u32 darfrch;
+
+	struct rtw_coex_hid hid_info[COEX_BT_HIDINFO_HANDLE_NUM];
+	struct rtw_coex_hid_handle_list hid_handle_list;
 };
 
 struct rtw_coex {
-- 
2.25.1

