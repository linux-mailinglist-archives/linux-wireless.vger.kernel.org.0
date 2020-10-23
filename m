Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921ED296C3F
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Oct 2020 11:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461623AbgJWJip (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Oct 2020 05:38:45 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:45985 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461599AbgJWJih (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Oct 2020 05:38:37 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 09N9cVhkD024667, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 09N9cVhkD024667
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 23 Oct 2020 17:38:31 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Fri, 23 Oct 2020 17:38:30 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 07/11] rtw88: coex: modified for BT info notify
Date:   Fri, 23 Oct 2020 17:37:38 +0800
Message-ID: <20201023093742.29908-8-pkshih@realtek.com>
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
index 511b73bb6e0f..a906cb3b479d 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -2329,17 +2329,19 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
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
@@ -2356,6 +2358,17 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
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
@@ -2367,19 +2380,16 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
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
@@ -2423,17 +2433,8 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
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
index c7aed2156e46..1400ba21278f 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1240,6 +1240,8 @@ struct rtw_coex_rfe {
 	bool wlg_at_btg;
 };
 
+#define COEX_WL_TDMA_PARA_LENGTH	5
+
 struct rtw_coex_dm {
 	bool cur_ps_tdma_on;
 	bool cur_wl_rx_low_gain_en;
@@ -1259,6 +1261,7 @@ struct rtw_coex_dm {
 	u32 cur_ant_pos_type;
 	u32 cur_switch_status;
 	u32 setting_tdma;
+	u8 fw_tdma_para[COEX_WL_TDMA_PARA_LENGTH];
 };
 
 #define COEX_BTINFO_SRC_WL_FW	0x0
@@ -1266,7 +1269,8 @@ struct rtw_coex_dm {
 #define COEX_BTINFO_SRC_BT_ACT	0x2
 #define COEX_BTINFO_SRC_BT_IQK	0x3
 #define COEX_BTINFO_SRC_BT_SCBD	0x4
-#define COEX_BTINFO_SRC_MAX	0x5
+#define COEX_BTINFO_SRC_H2C60	0x5
+#define COEX_BTINFO_SRC_MAX	0x6
 
 #define COEX_INFO_FTP		BIT(7)
 #define COEX_INFO_A2DP		BIT(6)
@@ -1277,6 +1281,7 @@ struct rtw_coex_dm {
 #define COEX_INFO_SCO_ESCO	BIT(1)
 #define COEX_INFO_CONNECTION	BIT(0)
 #define COEX_BTINFO_LENGTH_MAX	10
+#define COEX_BTINFO_LENGTH	7
 
 struct rtw_coex_stat {
 	bool bt_disabled;
@@ -1362,6 +1367,9 @@ struct rtw_coex_stat {
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

