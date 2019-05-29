Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFE242D712
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 09:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfE2HzB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 03:55:01 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37211 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfE2HzA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 03:55:00 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x4T7suNd005591, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x4T7suNd005591
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Wed, 29 May 2019 15:54:56 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.408.0; Wed, 29 May 2019 15:54:55 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 09/11] rtw88: remove all RTW_MAX_POWER_INDEX macro
Date:   Wed, 29 May 2019 15:54:45 +0800
Message-ID: <1559116487-5244-10-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559116487-5244-1-git-send-email-yhchuang@realtek.com>
References: <1559116487-5244-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

Since this macro definition has different values in different chipset,
the current defined macro value is for 8822b. This will cause the
settings of 8822c be incorrect.
Remove RTW_MAX_POWER_INDEX and use max_power_index in struct rtw_chip_info
to make sure the value of different chipset is right.

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c |  2 +-
 drivers/net/wireless/realtek/rtw88/phy.c  | 28 +++++++++++++++++-----------
 drivers/net/wireless/realtek/rtw88/phy.h  |  4 +---
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index e7a74b0..231c5a4 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1066,7 +1066,7 @@ static int rtw_chip_board_info_setup(struct rtw_dev *rtwdev)
 
 	rtw_phy_setup_phy_cond(rtwdev, 0);
 
-	rtw_phy_init_tx_power(hal);
+	rtw_phy_init_tx_power(rtwdev);
 	rtw_load_table(rtwdev, rfe_def->phy_pg_tbl);
 	rtw_load_table(rtwdev, rfe_def->txpwr_lmt_tbl);
 	rtw_phy_tx_power_by_rate_config(hal);
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 840538f..c4e43c3 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -1165,11 +1165,12 @@ static void rtw_phy_set_tx_power_limit(struct rtw_dev *rtwdev, u8 regd, u8 band,
 				       u8 bw, u8 rs, u8 ch, s8 pwr_limit)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
+	u8 max_power_index = rtwdev->chip->max_power_index;
 	s8 ww;
 	int ch_idx;
 
 	pwr_limit = clamp_t(s8, pwr_limit,
-			    -RTW_MAX_POWER_INDEX, RTW_MAX_POWER_INDEX);
+			    -max_power_index, max_power_index);
 	ch_idx = rtw_channel_to_idx(band, ch);
 
 	if (regd >= RTW_REGD_MAX || bw >= RTW_CHANNEL_WIDTH_MAX ||
@@ -1199,16 +1200,17 @@ rtw_xref_5g_txpwr_lmt(struct rtw_dev *rtwdev, u8 regd,
 		      u8 bw, u8 ch_idx, u8 rs_ht, u8 rs_vht)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
+	u8 max_power_index = rtwdev->chip->max_power_index;
 	s8 lmt_ht = hal->tx_pwr_limit_5g[regd][bw][rs_ht][ch_idx];
 	s8 lmt_vht = hal->tx_pwr_limit_5g[regd][bw][rs_vht][ch_idx];
 
 	if (lmt_ht == lmt_vht)
 		return;
 
-	if (lmt_ht == RTW_MAX_POWER_INDEX)
+	if (lmt_ht == max_power_index)
 		hal->tx_pwr_limit_5g[regd][bw][rs_ht][ch_idx] = lmt_vht;
 
-	else if (lmt_vht == RTW_MAX_POWER_INDEX)
+	else if (lmt_vht == max_power_index)
 		hal->tx_pwr_limit_5g[regd][bw][rs_vht][ch_idx] = lmt_ht;
 }
 
@@ -1541,14 +1543,14 @@ static s8 rtw_phy_get_tx_power_limit(struct rtw_dev *rtwdev, u8 band,
 {
 	struct rtw_hal *hal = &rtwdev->hal;
 	u8 *cch_by_bw = hal->cch_by_bw;
-	s8 power_limit = RTW_MAX_POWER_INDEX;
+	s8 power_limit = (s8)rtwdev->chip->max_power_index;
 	u8 rs;
 	int ch_idx;
 	u8 cur_bw, cur_ch;
 	s8 cur_lmt;
 
 	if (regd > RTW_REGD_WW)
-		return RTW_MAX_POWER_INDEX;
+		return power_limit;
 
 	if (rate >= DESC_RATE1M && rate <= DESC_RATE11M)
 		rs = RTW_RATE_SECTION_CCK;
@@ -1593,7 +1595,7 @@ static s8 rtw_phy_get_tx_power_limit(struct rtw_dev *rtwdev, u8 band,
 err:
 	WARN(1, "invalid arguments, band=%d, bw=%d, path=%d, rate=%d, ch=%d\n",
 	     band, bw, rf_path, rate, channel);
-	return RTW_MAX_POWER_INDEX;
+	return (s8)rtwdev->chip->max_power_index;
 }
 
 static u8
@@ -1780,22 +1782,25 @@ void rtw_phy_tx_power_limit_config(struct rtw_hal *hal)
 				__rtw_phy_tx_power_limit_config(hal, regd, bw, rs);
 }
 
-static void rtw_phy_init_tx_power_limit(struct rtw_hal *hal,
+static void rtw_phy_init_tx_power_limit(struct rtw_dev *rtwdev,
 					u8 regd, u8 bw, u8 rs)
 {
+	struct rtw_hal *hal = &rtwdev->hal;
+	s8 max_power_index = (s8)rtwdev->chip->max_power_index;
 	u8 ch;
 
 	/* 2.4G channels */
 	for (ch = 0; ch < RTW_MAX_CHANNEL_NUM_2G; ch++)
-		hal->tx_pwr_limit_2g[regd][bw][rs][ch] = RTW_MAX_POWER_INDEX;
+		hal->tx_pwr_limit_2g[regd][bw][rs][ch] = max_power_index;
 
 	/* 5G channels */
 	for (ch = 0; ch < RTW_MAX_CHANNEL_NUM_5G; ch++)
-		hal->tx_pwr_limit_5g[regd][bw][rs][ch] = RTW_MAX_POWER_INDEX;
+		hal->tx_pwr_limit_5g[regd][bw][rs][ch] = max_power_index;
 }
 
-void rtw_phy_init_tx_power(struct rtw_hal *hal)
+void rtw_phy_init_tx_power(struct rtw_dev *rtwdev)
 {
+	struct rtw_hal *hal = &rtwdev->hal;
 	u8 regd, path, rate, rs, bw;
 
 	/* init tx power by rate offset */
@@ -1810,5 +1815,6 @@ void rtw_phy_init_tx_power(struct rtw_hal *hal)
 	for (regd = 0; regd < RTW_REGD_MAX; regd++)
 		for (bw = 0; bw < RTW_CHANNEL_WIDTH_MAX; bw++)
 			for (rs = 0; rs < RTW_RATE_SECTION_MAX; rs++)
-				rtw_phy_init_tx_power_limit(hal, regd, bw, rs);
+				rtw_phy_init_tx_power_limit(rtwdev, regd, bw,
+							    rs);
 }
diff --git a/drivers/net/wireless/realtek/rtw88/phy.h b/drivers/net/wireless/realtek/rtw88/phy.h
index dfd8d77..5bd4b9b 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.h
+++ b/drivers/net/wireless/realtek/rtw88/phy.h
@@ -7,8 +7,6 @@
 
 #include "debug.h"
 
-#define RTW_MAX_POWER_INDEX		0x7F
-
 extern u8 rtw_cck_rates[];
 extern u8 rtw_ofdm_rates[];
 extern u8 rtw_ht_1s_rates[];
@@ -41,7 +39,7 @@ void rtw_phy_cfg_bb(struct rtw_dev *rtwdev, const struct rtw_table *tbl,
 		    u32 addr, u32 data);
 void rtw_phy_cfg_rf(struct rtw_dev *rtwdev, const struct rtw_table *tbl,
 		    u32 addr, u32 data);
-void rtw_phy_init_tx_power(struct rtw_hal *hal);
+void rtw_phy_init_tx_power(struct rtw_dev *rtwdev);
 void rtw_phy_load_tables(struct rtw_dev *rtwdev);
 void rtw_phy_set_tx_power_level(struct rtw_dev *rtwdev, u8 channel);
 void rtw_phy_tx_power_by_rate_config(struct rtw_hal *hal);
-- 
2.7.4

