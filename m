Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28EE2AB2FF
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Nov 2020 10:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgKIJAU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Nov 2020 04:00:20 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:60053 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbgKIJAT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Nov 2020 04:00:19 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0A990BmbC021869, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0A990BmbC021869
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 9 Nov 2020 17:00:11 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Mon, 9 Nov 2020 17:00:11 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 05/11] rtw88: coex: Modify the timing of set_ant_path/set_rf_para
Date:   Mon, 9 Nov 2020 16:59:03 +0800
Message-ID: <20201109085909.9143-6-pkshih@realtek.com>
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

To make sure the related ANT/RF_PARA setting will be expected result in COEX.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 91 ++++++++++++++---------
 1 file changed, 55 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 4f4477c8262a..af7e692137ba 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -1165,6 +1165,8 @@ static void rtw_coex_action_coex_all_off(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	if (efuse->share_ant) {
 		/* Shared-Ant */
 		table_case = 2;
@@ -1175,7 +1177,6 @@ static void rtw_coex_action_coex_all_off(struct rtw_dev *rtwdev)
 		tdma_case = 100;
 	}
 
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
@@ -1228,6 +1229,9 @@ static void rtw_coex_action_bt_whql_test(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	if (efuse->share_ant) {
 		/* Shared-Ant */
 		table_case = 2;
@@ -1238,8 +1242,6 @@ static void rtw_coex_action_bt_whql_test(struct rtw_dev *rtwdev)
 		tdma_case = 100;
 	}
 
-	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
@@ -1250,6 +1252,9 @@ static void rtw_coex_action_bt_relink(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	if (efuse->share_ant) {
 		/* Shared-Ant */
 		table_case = 1;
@@ -1260,8 +1265,6 @@ static void rtw_coex_action_bt_relink(struct rtw_dev *rtwdev)
 		tdma_case = 100;
 	}
 
-	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
@@ -1276,6 +1279,8 @@ static void rtw_coex_action_bt_idle(struct rtw_dev *rtwdev)
 	struct rtw_coex_rfe *coex_rfe = &coex->rfe;
 	u8 table_case = 0xff, tdma_case = 0xff;
 
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	if (coex_rfe->ant_switch_with_bt &&
 	    coex_dm->bt_status == COEX_BTSTATUS_NCON_IDLE) {
 		if (efuse->share_ant &&
@@ -1324,7 +1329,6 @@ static void rtw_coex_action_bt_idle(struct rtw_dev *rtwdev)
 		}
 	}
 
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
@@ -1339,6 +1343,9 @@ static void rtw_coex_action_bt_inquiry(struct rtw_dev *rtwdev)
 	u8 table_case, tdma_case;
 	u32 slot_type = 0;
 
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	if (coex_stat->wl_linkscan_proc || coex_stat->wl_hi_pri_task1 ||
 	    coex_stat->wl_hi_pri_task2)
 		wl_hi_pri = true;
@@ -1404,8 +1411,6 @@ static void rtw_coex_action_bt_inquiry(struct rtw_dev *rtwdev)
 	rtw_dbg(rtwdev, RTW_DBG_COEX, "coex: wifi hi(%d), bt page(%d)\n",
 		wl_hi_pri, coex_stat->bt_page);
 
-	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case | slot_type);
 }
@@ -1418,6 +1423,9 @@ static void rtw_coex_action_bt_hfp(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	if (efuse->share_ant) {
 		/* Shared-Ant */
 		if (coex_stat->bt_multi_link) {
@@ -1438,8 +1446,6 @@ static void rtw_coex_action_bt_hfp(struct rtw_dev *rtwdev)
 		}
 	}
 
-	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
@@ -1453,6 +1459,9 @@ static void rtw_coex_action_bt_hid(struct rtw_dev *rtwdev)
 	u8 table_case, tdma_case;
 	u32 wl_bw;
 
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	wl_bw = rtwdev->hal.current_band_width;
 
 	if (efuse->share_ant) {
@@ -1509,8 +1518,6 @@ static void rtw_coex_action_bt_hid(struct rtw_dev *rtwdev)
 		}
 	}
 
-	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
@@ -1525,6 +1532,9 @@ static void rtw_coex_action_bt_a2dp(struct rtw_dev *rtwdev)
 	u8 table_case, tdma_case;
 	u32 slot_type = 0;
 
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	if (efuse->share_ant) {
 		/* Shared-Ant */
 		slot_type = TDMA_4SLOT;
@@ -1548,8 +1558,6 @@ static void rtw_coex_action_bt_a2dp(struct rtw_dev *rtwdev)
 			tdma_case = 113;
 	}
 
-	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case | slot_type);
 }
@@ -1563,6 +1571,9 @@ static void rtw_coex_action_bt_a2dpsink(struct rtw_dev *rtwdev)
 	u8 table_case, tdma_case;
 	bool ap_enable = false;
 
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	if (efuse->share_ant) { /* Shared-Ant */
 		if (ap_enable) {
 			table_case = 2;
@@ -1584,8 +1595,6 @@ static void rtw_coex_action_bt_a2dpsink(struct rtw_dev *rtwdev)
 		}
 	}
 
-	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
@@ -1598,6 +1607,9 @@ static void rtw_coex_action_bt_pan(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	if (efuse->share_ant) {
 		/* Shared-Ant */
 		if (coex_stat->wl_gl_busy && coex_stat->wl_noisy_level == 0)
@@ -1619,8 +1631,6 @@ static void rtw_coex_action_bt_pan(struct rtw_dev *rtwdev)
 			tdma_case = 119;
 	}
 
-	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
@@ -1635,6 +1645,9 @@ static void rtw_coex_action_bt_a2dp_hid(struct rtw_dev *rtwdev)
 	u8 table_case, tdma_case;
 	u32 slot_type = 0;
 
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	if (efuse->share_ant) {
 		/* Shared-Ant */
 		slot_type = TDMA_4SLOT;
@@ -1661,8 +1674,6 @@ static void rtw_coex_action_bt_a2dp_hid(struct rtw_dev *rtwdev)
 			tdma_case = 113;
 	}
 
-	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case | slot_type);
 }
@@ -1675,6 +1686,9 @@ static void rtw_coex_action_bt_a2dp_pan(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	if (efuse->share_ant) {
 		/* Shared-Ant */
 		if (coex_stat->wl_gl_busy &&
@@ -1697,8 +1711,6 @@ static void rtw_coex_action_bt_a2dp_pan(struct rtw_dev *rtwdev)
 			tdma_case = 120;
 	}
 
-	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
@@ -1711,6 +1723,9 @@ static void rtw_coex_action_bt_pan_hid(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	if (efuse->share_ant) {
 		/* Shared-Ant */
 		table_case = 9;
@@ -1729,8 +1744,6 @@ static void rtw_coex_action_bt_pan_hid(struct rtw_dev *rtwdev)
 			tdma_case = 119;
 	}
 
-	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
@@ -1743,6 +1756,9 @@ static void rtw_coex_action_bt_a2dp_pan_hid(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	if (efuse->share_ant) {
 		/* Shared-Ant */
 		table_case = 10;
@@ -1761,8 +1777,6 @@ static void rtw_coex_action_bt_a2dp_pan_hid(struct rtw_dev *rtwdev)
 			tdma_case = 120;
 	}
 
-	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
@@ -1773,6 +1787,9 @@ static void rtw_coex_action_wl_under5g(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
+	rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_5G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	rtw_coex_write_scbd(rtwdev, COEX_SCBD_FIX2M, false);
 
 	if (efuse->share_ant) {
@@ -1785,8 +1802,6 @@ static void rtw_coex_action_wl_under5g(struct rtw_dev *rtwdev)
 		tdma_case = 100;
 	}
 
-	rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_5G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
@@ -1797,6 +1812,9 @@ static void rtw_coex_action_wl_only(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	if (efuse->share_ant) {
 		/* Shared-Ant */
 		table_case = 2;
@@ -1807,8 +1825,6 @@ static void rtw_coex_action_wl_only(struct rtw_dev *rtwdev)
 		tdma_case = 100;
 	}
 
-	rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_2G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
@@ -1823,6 +1839,9 @@ static void rtw_coex_action_wl_native_lps(struct rtw_dev *rtwdev)
 	if (coex->under_5g)
 		return;
 
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	if (efuse->share_ant) {
 		/* Shared-Ant */
 		table_case = 28;
@@ -1833,8 +1852,6 @@ static void rtw_coex_action_wl_native_lps(struct rtw_dev *rtwdev)
 		tdma_case = 100;
 	}
 
-	rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_2G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
@@ -1848,6 +1865,9 @@ static void rtw_coex_action_wl_linkscan(struct rtw_dev *rtwdev)
 	u8 table_case, tdma_case;
 	u32 slot_type = 0;
 
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	if (efuse->share_ant) {
 		/* Shared-Ant */
 		if (coex_stat->bt_a2dp_exist) {
@@ -1869,8 +1889,6 @@ static void rtw_coex_action_wl_linkscan(struct rtw_dev *rtwdev)
 		}
 	}
 
-	rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_2G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case | slot_type);
 }
@@ -1881,6 +1899,9 @@ static void rtw_coex_action_wl_not_connected(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	if (efuse->share_ant) {
 		/* Shared-Ant */
 		table_case = 1;
@@ -1891,8 +1912,6 @@ static void rtw_coex_action_wl_not_connected(struct rtw_dev *rtwdev)
 		tdma_case = 100;
 	}
 
-	rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_2G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
-- 
2.21.0

