Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251CC296C3E
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Oct 2020 11:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461621AbgJWJip (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Oct 2020 05:38:45 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:45982 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461208AbgJWJih (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Oct 2020 05:38:37 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 09N9cVhjD024667, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 09N9cVhjD024667
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 23 Oct 2020 17:38:31 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Fri, 23 Oct 2020 17:38:30 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 05/11] rtw88: coex: Modify the timing of set_ant_path/set_rf_para
Date:   Fri, 23 Oct 2020 17:37:36 +0800
Message-ID: <20201023093742.29908-6-pkshih@realtek.com>
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

To make sure the related ANT/RF_PARA setting will be expected result in COEX.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 91 ++++++++++++++---------
 1 file changed, 55 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 18994e0c19c0..f263c49dce3c 100644
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
@@ -1503,8 +1512,6 @@ static void rtw_coex_action_bt_hid(struct rtw_dev *rtwdev)
 		}
 	}
 
-	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
@@ -1519,6 +1526,9 @@ static void rtw_coex_action_bt_a2dp(struct rtw_dev *rtwdev)
 	u8 table_case, tdma_case;
 	u32 slot_type = 0;
 
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	if (efuse->share_ant) {
 		/* Shared-Ant */
 		slot_type = TDMA_4SLOT;
@@ -1542,8 +1552,6 @@ static void rtw_coex_action_bt_a2dp(struct rtw_dev *rtwdev)
 			tdma_case = 113;
 	}
 
-	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case | slot_type);
 }
@@ -1557,6 +1565,9 @@ static void rtw_coex_action_bt_a2dpsink(struct rtw_dev *rtwdev)
 	u8 table_case, tdma_case;
 	bool ap_enable = false;
 
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	if (efuse->share_ant) { /* Shared-Ant */
 		if (ap_enable) {
 			table_case = 2;
@@ -1578,8 +1589,6 @@ static void rtw_coex_action_bt_a2dpsink(struct rtw_dev *rtwdev)
 		}
 	}
 
-	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
@@ -1592,6 +1601,9 @@ static void rtw_coex_action_bt_pan(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	if (efuse->share_ant) {
 		/* Shared-Ant */
 		if (coex_stat->wl_gl_busy && coex_stat->wl_noisy_level == 0)
@@ -1613,8 +1625,6 @@ static void rtw_coex_action_bt_pan(struct rtw_dev *rtwdev)
 			tdma_case = 119;
 	}
 
-	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
@@ -1629,6 +1639,9 @@ static void rtw_coex_action_bt_a2dp_hid(struct rtw_dev *rtwdev)
 	u8 table_case, tdma_case;
 	u32 slot_type = 0;
 
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	if (efuse->share_ant) {
 		/* Shared-Ant */
 		slot_type = TDMA_4SLOT;
@@ -1655,8 +1668,6 @@ static void rtw_coex_action_bt_a2dp_hid(struct rtw_dev *rtwdev)
 			tdma_case = 113;
 	}
 
-	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case | slot_type);
 }
@@ -1669,6 +1680,9 @@ static void rtw_coex_action_bt_a2dp_pan(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	if (efuse->share_ant) {
 		/* Shared-Ant */
 		if (coex_stat->wl_gl_busy &&
@@ -1691,8 +1705,6 @@ static void rtw_coex_action_bt_a2dp_pan(struct rtw_dev *rtwdev)
 			tdma_case = 120;
 	}
 
-	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
@@ -1705,6 +1717,9 @@ static void rtw_coex_action_bt_pan_hid(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	if (efuse->share_ant) {
 		/* Shared-Ant */
 		table_case = 9;
@@ -1723,8 +1738,6 @@ static void rtw_coex_action_bt_pan_hid(struct rtw_dev *rtwdev)
 			tdma_case = 119;
 	}
 
-	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
@@ -1737,6 +1750,9 @@ static void rtw_coex_action_bt_a2dp_pan_hid(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	if (efuse->share_ant) {
 		/* Shared-Ant */
 		table_case = 10;
@@ -1755,8 +1771,6 @@ static void rtw_coex_action_bt_a2dp_pan_hid(struct rtw_dev *rtwdev)
 			tdma_case = 120;
 	}
 
-	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
@@ -1767,6 +1781,9 @@ static void rtw_coex_action_wl_under5g(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
+	rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_5G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	rtw_coex_write_scbd(rtwdev, COEX_SCBD_FIX2M, false);
 
 	if (efuse->share_ant) {
@@ -1779,8 +1796,6 @@ static void rtw_coex_action_wl_under5g(struct rtw_dev *rtwdev)
 		tdma_case = 100;
 	}
 
-	rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_5G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
@@ -1791,6 +1806,9 @@ static void rtw_coex_action_wl_only(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	if (efuse->share_ant) {
 		/* Shared-Ant */
 		table_case = 2;
@@ -1801,8 +1819,6 @@ static void rtw_coex_action_wl_only(struct rtw_dev *rtwdev)
 		tdma_case = 100;
 	}
 
-	rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_2G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
@@ -1817,6 +1833,9 @@ static void rtw_coex_action_wl_native_lps(struct rtw_dev *rtwdev)
 	if (coex->under_5g)
 		return;
 
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	if (efuse->share_ant) {
 		/* Shared-Ant */
 		table_case = 28;
@@ -1827,8 +1846,6 @@ static void rtw_coex_action_wl_native_lps(struct rtw_dev *rtwdev)
 		tdma_case = 100;
 	}
 
-	rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_2G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
@@ -1842,6 +1859,9 @@ static void rtw_coex_action_wl_linkscan(struct rtw_dev *rtwdev)
 	u8 table_case, tdma_case;
 	u32 slot_type = 0;
 
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	if (efuse->share_ant) {
 		/* Shared-Ant */
 		if (coex_stat->bt_a2dp_exist) {
@@ -1863,8 +1883,6 @@ static void rtw_coex_action_wl_linkscan(struct rtw_dev *rtwdev)
 		}
 	}
 
-	rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_2G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case | slot_type);
 }
@@ -1875,6 +1893,9 @@ static void rtw_coex_action_wl_not_connected(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	if (efuse->share_ant) {
 		/* Shared-Ant */
 		table_case = 1;
@@ -1885,8 +1906,6 @@ static void rtw_coex_action_wl_not_connected(struct rtw_dev *rtwdev)
 		tdma_case = 100;
 	}
 
-	rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_2G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
-- 
2.21.0

