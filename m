Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAC72AB303
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Nov 2020 10:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbgKIJAV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Nov 2020 04:00:21 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:60057 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbgKIJAT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Nov 2020 04:00:19 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0A990CmX4021869, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0A990CmX4021869
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 9 Nov 2020 17:00:12 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Mon, 9 Nov 2020 17:00:11 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 07/11] rtw88: coex: modified for BT info notify
Date:   Mon, 9 Nov 2020 16:59:05 +0800
Message-ID: <20201109085909.9143-8-pkshih@realtek.com>
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

Add counter to count BT info C2H command for debug usage.
It could present the C2H channel situation.

Fix BT IQK state decision condition for counting.
The original condition is wrong, it would cause coexistence mechanism
going to the wrong strategy.

New format supports getting TDMA parameter from WL firmware, since
coexistence needs current TDMA parameter to decide strategy.

Remove unnecessary operations about scoreboard, it is not a must for
current version.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 43 ++++++++++++-----------
 drivers/net/wireless/realtek/rtw88/main.h | 10 +++++-
 2 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 6de98414e3bf..c47771f7020a 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -2335,17 +2335,19 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
 	u32 bt_relink_time;
 	u8 i, rsp_source = 0, type;
 	bool inq_page = false;
 
 	rsp_source = buf[0] & 0xf;
 	if (rsp_source >= COEX_BTINFO_SRC_MAX)
-		rsp_source = COEX_BTINFO_SRC_WL_FW;
+		return;
+	coex_stat->cnt_bt_info_c2h[rsp_source]++;
 
 	if (rsp_source == COEX_BTINFO_SRC_BT_IQK) {
 		coex_stat->bt_iqk_state = buf[1];
-		if (coex_stat->bt_iqk_state == 1)
+		if (coex_stat->bt_iqk_state == 0)
 			coex_stat->cnt_bt[COEX_CNT_BT_IQK]++;
 		else if (coex_stat->bt_iqk_state == 2)
 			coex_stat->cnt_bt[COEX_CNT_BT_IQKFAIL]++;
@@ -2362,6 +2364,17 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 		return;
 	}
 
+	if (rsp_source == COEX_BTINFO_SRC_H2C60) {
+		for (i = 1; i <= COEX_WL_TDMA_PARA_LENGTH; i++)
+			coex_dm->fw_tdma_para[i - 1] = buf[i];
+		return;
+	}
+
+	if (rsp_source == COEX_BTINFO_SRC_WL_FW) {
+		rtw_coex_update_bt_link_info(rtwdev);
+		return;
+	}
+
 	if (rsp_source == COEX_BTINFO_SRC_BT_RSP ||
 	    rsp_source == COEX_BTINFO_SRC_BT_ACT) {
 		if (coex_stat->bt_disabled) {
@@ -2373,19 +2386,16 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 		}
 	}
 
-	for (i = 0; i < length; i++) {
-		if (i < COEX_BTINFO_LENGTH_MAX)
-			coex_stat->bt_info_c2h[rsp_source][i] = buf[i];
-		else
-			break;
-	}
+	if (length != COEX_BTINFO_LENGTH) {
+		rtw_dbg(rtwdev, RTW_DBG_COEX,
+			"[BTCoex], Bt_info length = %d invalid!!\n", length);
 
-	if (rsp_source == COEX_BTINFO_SRC_WL_FW) {
-		rtw_coex_update_bt_link_info(rtwdev);
-		rtw_coex_run_coex(rtwdev, COEX_RSN_BTINFO);
 		return;
 	}
 
+	for (i = 0; i < COEX_BTINFO_LENGTH; i++)
+		coex_stat->bt_info_c2h[rsp_source][i] = buf[i];
+
 	/* get the same info from bt, skip it */
 	if (coex_stat->bt_info_c2h[rsp_source][1] == coex_stat->bt_info_lb2 &&
 	    coex_stat->bt_info_c2h[rsp_source][2] == coex_stat->bt_info_lb3 &&
@@ -2446,17 +2456,8 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 		coex_stat->cnt_bt[COEX_CNT_BT_INQ]++;
 
 	coex_stat->bt_page = ((coex_stat->bt_info_lb3 & BIT(7)) == BIT(7));
-	if (coex_stat->bt_page) {
+	if (coex_stat->bt_page)
 		coex_stat->cnt_bt[COEX_CNT_BT_PAGE]++;
-		if (coex_stat->wl_linkscan_proc ||
-		    coex_stat->wl_hi_pri_task1 ||
-		    coex_stat->wl_hi_pri_task2 || coex_stat->wl_gl_busy)
-			rtw_coex_write_scbd(rtwdev, COEX_SCBD_SCAN, true);
-		else
-			rtw_coex_write_scbd(rtwdev, COEX_SCBD_SCAN, false);
-	} else {
-		rtw_coex_write_scbd(rtwdev, COEX_SCBD_SCAN, false);
-	}
 
 	/* unit: % (value-100 to translate to unit: dBm in coex info) */
 	if (chip->bt_rssi_type == COEX_BTRSSI_RATIO) {
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 632d14683b61..97f75a99d0a4 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1241,6 +1241,8 @@ struct rtw_coex_rfe {
 	bool wlg_at_btg;
 };
 
+#define COEX_WL_TDMA_PARA_LENGTH	5
+
 struct rtw_coex_dm {
 	bool cur_ps_tdma_on;
 	bool cur_wl_rx_low_gain_en;
@@ -1260,6 +1262,7 @@ struct rtw_coex_dm {
 	u32 cur_ant_pos_type;
 	u32 cur_switch_status;
 	u32 setting_tdma;
+	u8 fw_tdma_para[COEX_WL_TDMA_PARA_LENGTH];
 };
 
 #define COEX_BTINFO_SRC_WL_FW	0x0
@@ -1267,7 +1270,8 @@ struct rtw_coex_dm {
 #define COEX_BTINFO_SRC_BT_ACT	0x2
 #define COEX_BTINFO_SRC_BT_IQK	0x3
 #define COEX_BTINFO_SRC_BT_SCBD	0x4
-#define COEX_BTINFO_SRC_MAX	0x5
+#define COEX_BTINFO_SRC_H2C60	0x5
+#define COEX_BTINFO_SRC_MAX	0x6
 
 #define COEX_INFO_FTP		BIT(7)
 #define COEX_INFO_A2DP		BIT(6)
@@ -1278,6 +1282,7 @@ struct rtw_coex_dm {
 #define COEX_INFO_SCO_ESCO	BIT(1)
 #define COEX_INFO_CONNECTION	BIT(0)
 #define COEX_BTINFO_LENGTH_MAX	10
+#define COEX_BTINFO_LENGTH	7
 
 struct rtw_coex_stat {
 	bool bt_disabled;
@@ -1364,6 +1369,9 @@ struct rtw_coex_stat {
 	/* counters to record wifi states */
 	u32 cnt_wl[COEX_CNT_WL_MAX];
 
+	/* counters to record bt c2h data */
+	u32 cnt_bt_info_c2h[COEX_BTINFO_SRC_MAX];
+
 	u32 darfrc;
 	u32 darfrch;
 };
-- 
2.21.0

