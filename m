Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D89A2D710
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 09:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfE2Hy6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 03:54:58 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37200 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfE2Hy5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 03:54:57 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x4T7sqg5005550, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x4T7sqg5005550
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Wed, 29 May 2019 15:54:53 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.408.0; Wed, 29 May 2019 15:54:52 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 03/11] rtw88: unify prefixes for tx power setting routine
Date:   Wed, 29 May 2019 15:54:39 +0800
Message-ID: <1559116487-5244-4-git-send-email-yhchuang@realtek.com>
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

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Rename the function names to make them have the same prefix "rtw_phy"
for the tx power setting routines. Only the function names and
corresponding identation are modified.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c |   2 +-
 drivers/net/wireless/realtek/rtw88/phy.c  | 128 +++++++++++++++---------------
 drivers/net/wireless/realtek/rtw88/phy.h  |   2 +-
 3 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index b2dac460..f1ea5aa 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1042,7 +1042,7 @@ static int rtw_chip_board_info_setup(struct rtw_dev *rtwdev)
 
 	rtw_phy_setup_phy_cond(rtwdev, 0);
 
-	rtw_hw_init_tx_power(hal);
+	rtw_phy_init_tx_power(hal);
 	rtw_load_table(rtwdev, rfe_def->phy_pg_tbl);
 	rtw_load_table(rtwdev, rfe_def->txpwr_lmt_tbl);
 	rtw_phy_tx_power_by_rate_config(hal);
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index d4bcc89..9733dba 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -774,10 +774,10 @@ static u8 tbl_to_dec_pwr_by_rate(struct rtw_dev *rtwdev, u32 hex, u8 i)
 	return (hex >> (i * 8)) & 0xFF;
 }
 
-static void phy_get_rate_values_of_txpwr_by_rate(struct rtw_dev *rtwdev,
-						 u32 addr, u32 mask,
-						 u32 val, u8 *rate,
-						 u8 *pwr_by_rate, u8 *rate_num)
+static void
+rtw_phy_get_rate_values_of_txpwr_by_rate(struct rtw_dev *rtwdev,
+					 u32 addr, u32 mask, u32 val, u8 *rate,
+					 u8 *pwr_by_rate, u8 *rate_num)
 {
 	int i;
 
@@ -1079,9 +1079,9 @@ static void phy_get_rate_values_of_txpwr_by_rate(struct rtw_dev *rtwdev,
 	}
 }
 
-static void phy_store_tx_power_by_rate(struct rtw_dev *rtwdev,
-				       u32 band, u32 rfpath, u32 txnum,
-				       u32 regaddr, u32 bitmask, u32 data)
+static void rtw_phy_store_tx_power_by_rate(struct rtw_dev *rtwdev,
+					   u32 band, u32 rfpath, u32 txnum,
+					   u32 regaddr, u32 bitmask, u32 data)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
 	u8 rate_num = 0;
@@ -1091,8 +1091,8 @@ static void phy_store_tx_power_by_rate(struct rtw_dev *rtwdev,
 	s8 pwr_by_rate[RTW_RF_PATH_MAX] = {0};
 	int i;
 
-	phy_get_rate_values_of_txpwr_by_rate(rtwdev, regaddr, bitmask, data,
-					     rates, pwr_by_rate, &rate_num);
+	rtw_phy_get_rate_values_of_txpwr_by_rate(rtwdev, regaddr, bitmask, data,
+						 rates, pwr_by_rate, &rate_num);
 
 	if (WARN_ON(rfpath >= RTW_RF_PATH_MAX ||
 		    (band != PHY_BAND_2G && band != PHY_BAND_5G) ||
@@ -1123,9 +1123,9 @@ void rtw_parse_tbl_bb_pg(struct rtw_dev *rtwdev, const struct rtw_table *tbl)
 			msleep(50);
 			continue;
 		}
-		phy_store_tx_power_by_rate(rtwdev, p->band, p->rf_path,
-					   p->tx_num, p->addr, p->bitmask,
-					   p->data);
+		rtw_phy_store_tx_power_by_rate(rtwdev, p->band, p->rf_path,
+					       p->tx_num, p->addr, p->bitmask,
+					       p->data);
 	}
 }
 
@@ -1161,8 +1161,8 @@ static int rtw_channel_to_idx(u8 band, u8 channel)
 	return ch_idx;
 }
 
-static void phy_set_tx_power_limit(struct rtw_dev *rtwdev, u8 regd, u8 band,
-				   u8 bw, u8 rs, u8 ch, s8 pwr_limit)
+static void rtw_phy_set_tx_power_limit(struct rtw_dev *rtwdev, u8 regd, u8 band,
+				       u8 bw, u8 rs, u8 ch, s8 pwr_limit)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
 	int ch_idx;
@@ -1194,9 +1194,8 @@ void rtw_parse_tbl_txpwr_lmt(struct rtw_dev *rtwdev,
 	BUILD_BUG_ON(sizeof(struct txpwr_lmt_cfg_pair) != sizeof(u8) * 6);
 
 	for (; p < end; p++) {
-		phy_set_tx_power_limit(rtwdev, p->regd, p->band,
-				       p->bw, p->rs,
-				       p->ch, p->txpwr_lmt);
+		rtw_phy_set_tx_power_limit(rtwdev, p->regd, p->band,
+					   p->bw, p->rs, p->ch, p->txpwr_lmt);
 	}
 }
 
@@ -1361,10 +1360,10 @@ static u8 rtw_get_channel_group(u8 channel)
 	}
 }
 
-static u8 phy_get_2g_tx_power_index(struct rtw_dev *rtwdev,
-				    struct rtw_2g_txpwr_idx *pwr_idx_2g,
-				    enum rtw_bandwidth bandwidth,
-				    u8 rate, u8 group)
+static u8 rtw_phy_get_2g_tx_power_index(struct rtw_dev *rtwdev,
+					struct rtw_2g_txpwr_idx *pwr_idx_2g,
+					enum rtw_bandwidth bandwidth,
+					u8 rate, u8 group)
 {
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 tx_power;
@@ -1408,10 +1407,10 @@ static u8 phy_get_2g_tx_power_index(struct rtw_dev *rtwdev,
 	return tx_power;
 }
 
-static u8 phy_get_5g_tx_power_index(struct rtw_dev *rtwdev,
-				    struct rtw_5g_txpwr_idx *pwr_idx_5g,
-				    enum rtw_bandwidth bandwidth,
-				    u8 rate, u8 group)
+static u8 rtw_phy_get_5g_tx_power_index(struct rtw_dev *rtwdev,
+					struct rtw_5g_txpwr_idx *pwr_idx_5g,
+					enum rtw_bandwidth bandwidth,
+					u8 rate, u8 group)
 {
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 tx_power;
@@ -1462,7 +1461,8 @@ static u8 phy_get_5g_tx_power_index(struct rtw_dev *rtwdev,
 	return tx_power;
 }
 
-static s8 get_tx_power_limit(struct rtw_hal *hal, u8 bw, u8 rs, u8 ch, u8 regd)
+static s8 __rtw_phy_get_tx_power_limit(struct rtw_hal *hal,
+				       u8 bw, u8 rs, u8 ch, u8 regd)
 {
 	if (regd > RTW_REGD_WW)
 		return RTW_MAX_POWER_INDEX;
@@ -1470,9 +1470,9 @@ static s8 get_tx_power_limit(struct rtw_hal *hal, u8 bw, u8 rs, u8 ch, u8 regd)
 	return hal->tx_pwr_limit_2g[regd][bw][rs][ch];
 }
 
-static s8 phy_get_tx_power_limit(struct rtw_dev *rtwdev, u8 band,
-				 enum rtw_bandwidth bw, u8 rf_path,
-				 u8 rate, u8 channel, u8 regd)
+static s8 rtw_phy_get_tx_power_limit(struct rtw_dev *rtwdev, u8 band,
+				     enum rtw_bandwidth bw, u8 rf_path,
+				     u8 rate, u8 channel, u8 regd)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
 	s8 power_limit;
@@ -1498,7 +1498,7 @@ static s8 phy_get_tx_power_limit(struct rtw_dev *rtwdev, u8 band,
 	if (ch_idx < 0)
 		goto err;
 
-	power_limit = get_tx_power_limit(hal, bw, rs, ch_idx, regd);
+	power_limit = __rtw_phy_get_tx_power_limit(hal, bw, rs, ch_idx, regd);
 
 	return power_limit;
 
@@ -1508,9 +1508,9 @@ static s8 phy_get_tx_power_limit(struct rtw_dev *rtwdev, u8 band,
 	return RTW_MAX_POWER_INDEX;
 }
 
-static
-u8 phy_get_tx_power_index(struct rtw_dev *rtwdev, u8 rf_path, u8 rate,
-			  enum rtw_bandwidth bandwidth, u8 channel, u8 regd)
+static u8
+rtw_phy_get_tx_power_index(struct rtw_dev *rtwdev, u8 rf_path, u8 rate,
+			   enum rtw_bandwidth bandwidth, u8 channel, u8 regd)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
 	struct rtw_txpwr_idx *pwr_idx;
@@ -1525,20 +1525,20 @@ u8 phy_get_tx_power_index(struct rtw_dev *rtwdev, u8 rf_path, u8 rate,
 	/* base power index for 2.4G/5G */
 	if (channel <= 14) {
 		band = PHY_BAND_2G;
-		tx_power = phy_get_2g_tx_power_index(rtwdev,
-						     &pwr_idx->pwr_idx_2g,
-						     bandwidth, rate, group);
+		tx_power = rtw_phy_get_2g_tx_power_index(rtwdev,
+							 &pwr_idx->pwr_idx_2g,
+							 bandwidth, rate, group);
 		offset = hal->tx_pwr_by_rate_offset_2g[rf_path][rate];
 	} else {
 		band = PHY_BAND_5G;
-		tx_power = phy_get_5g_tx_power_index(rtwdev,
-						     &pwr_idx->pwr_idx_5g,
-						     bandwidth, rate, group);
+		tx_power = rtw_phy_get_5g_tx_power_index(rtwdev,
+							 &pwr_idx->pwr_idx_5g,
+							 bandwidth, rate, group);
 		offset = hal->tx_pwr_by_rate_offset_5g[rf_path][rate];
 	}
 
-	limit = phy_get_tx_power_limit(rtwdev, band, bandwidth, rf_path,
-				       rate, channel, regd);
+	limit = rtw_phy_get_tx_power_limit(rtwdev, band, bandwidth, rf_path,
+					   rate, channel, regd);
 
 	if (offset > limit)
 		offset = limit;
@@ -1551,8 +1551,8 @@ u8 phy_get_tx_power_index(struct rtw_dev *rtwdev, u8 rf_path, u8 rate,
 	return tx_power;
 }
 
-static void phy_set_tx_power_index_by_rs(struct rtw_dev *rtwdev,
-					 u8 ch, u8 path, u8 rs)
+static void rtw_phy_set_tx_power_index_by_rs(struct rtw_dev *rtwdev,
+					     u8 ch, u8 path, u8 rs)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
 	u8 regd = rtwdev->regd.txpwr_regd;
@@ -1571,8 +1571,8 @@ static void phy_set_tx_power_index_by_rs(struct rtw_dev *rtwdev,
 	bw = hal->current_band_width;
 	for (i = 0; i < size; i++) {
 		rate = rates[i];
-		pwr_idx = phy_get_tx_power_index(rtwdev, path, rate, bw, ch,
-						 regd);
+		pwr_idx = rtw_phy_get_tx_power_index(rtwdev, path, rate,
+						     bw, ch, regd);
 		hal->tx_pwr_tbl[path][rate] = pwr_idx;
 	}
 }
@@ -1582,8 +1582,8 @@ static void phy_set_tx_power_index_by_rs(struct rtw_dev *rtwdev,
  * power index into a four-byte power index register, and calls set_tx_agc to
  * write these values into hardware
  */
-static
-void phy_set_tx_power_level_by_path(struct rtw_dev *rtwdev, u8 ch, u8 path)
+static void rtw_phy_set_tx_power_level_by_path(struct rtw_dev *rtwdev,
+					       u8 ch, u8 path)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
 	u8 rs;
@@ -1595,7 +1595,7 @@ void phy_set_tx_power_level_by_path(struct rtw_dev *rtwdev, u8 ch, u8 path)
 		rs = RTW_RATE_SECTION_OFDM;
 
 	for (; rs < RTW_RATE_SECTION_MAX; rs++)
-		phy_set_tx_power_index_by_rs(rtwdev, ch, path, rs);
+		rtw_phy_set_tx_power_index_by_rs(rtwdev, ch, path, rs);
 }
 
 void rtw_phy_set_tx_power_level(struct rtw_dev *rtwdev, u8 channel)
@@ -1607,15 +1607,15 @@ void rtw_phy_set_tx_power_level(struct rtw_dev *rtwdev, u8 channel)
 	mutex_lock(&hal->tx_power_mutex);
 
 	for (path = 0; path < hal->rf_path_num; path++)
-		phy_set_tx_power_level_by_path(rtwdev, channel, path);
+		rtw_phy_set_tx_power_level_by_path(rtwdev, channel, path);
 
 	chip->ops->set_tx_power_index(rtwdev);
 	mutex_unlock(&hal->tx_power_mutex);
 }
 
-static
-void phy_tx_power_by_rate_config_by_path(struct rtw_hal *hal, u8 path,
-					 u8 rs, u8 size, u8 *rates)
+static void
+rtw_phy_tx_power_by_rate_config_by_path(struct rtw_hal *hal, u8 path,
+					u8 rs, u8 size, u8 *rates)
 {
 	u8 rate;
 	u8 base_idx, rate_idx;
@@ -1641,29 +1641,29 @@ void rtw_phy_tx_power_by_rate_config(struct rtw_hal *hal)
 	u8 path;
 
 	for (path = 0; path < RTW_RF_PATH_MAX; path++) {
-		phy_tx_power_by_rate_config_by_path(hal, path,
+		rtw_phy_tx_power_by_rate_config_by_path(hal, path,
 				RTW_RATE_SECTION_CCK,
 				rtw_cck_size, rtw_cck_rates);
-		phy_tx_power_by_rate_config_by_path(hal, path,
+		rtw_phy_tx_power_by_rate_config_by_path(hal, path,
 				RTW_RATE_SECTION_OFDM,
 				rtw_ofdm_size, rtw_ofdm_rates);
-		phy_tx_power_by_rate_config_by_path(hal, path,
+		rtw_phy_tx_power_by_rate_config_by_path(hal, path,
 				RTW_RATE_SECTION_HT_1S,
 				rtw_ht_1s_size, rtw_ht_1s_rates);
-		phy_tx_power_by_rate_config_by_path(hal, path,
+		rtw_phy_tx_power_by_rate_config_by_path(hal, path,
 				RTW_RATE_SECTION_HT_2S,
 				rtw_ht_2s_size, rtw_ht_2s_rates);
-		phy_tx_power_by_rate_config_by_path(hal, path,
+		rtw_phy_tx_power_by_rate_config_by_path(hal, path,
 				RTW_RATE_SECTION_VHT_1S,
 				rtw_vht_1s_size, rtw_vht_1s_rates);
-		phy_tx_power_by_rate_config_by_path(hal, path,
+		rtw_phy_tx_power_by_rate_config_by_path(hal, path,
 				RTW_RATE_SECTION_VHT_2S,
 				rtw_vht_2s_size, rtw_vht_2s_rates);
 	}
 }
 
 static void
-phy_tx_power_limit_config(struct rtw_hal *hal, u8 regd, u8 bw, u8 rs)
+__rtw_phy_tx_power_limit_config(struct rtw_hal *hal, u8 regd, u8 bw, u8 rs)
 {
 	s8 base, orig;
 	u8 ch;
@@ -1687,11 +1687,11 @@ void rtw_phy_tx_power_limit_config(struct rtw_hal *hal)
 	for (regd = 0; regd < RTW_REGD_MAX; regd++)
 		for (bw = 0; bw < RTW_CHANNEL_WIDTH_MAX; bw++)
 			for (rs = 0; rs < RTW_RATE_SECTION_MAX; rs++)
-				phy_tx_power_limit_config(hal, regd, bw, rs);
+				__rtw_phy_tx_power_limit_config(hal, regd, bw, rs);
 }
 
-static
-void rtw_hw_tx_power_limit_init(struct rtw_hal *hal, u8 regd, u8 bw, u8 rs)
+static void rtw_phy_init_tx_power_limit(struct rtw_hal *hal,
+					u8 regd, u8 bw, u8 rs)
 {
 	u8 ch;
 
@@ -1704,7 +1704,7 @@ void rtw_hw_tx_power_limit_init(struct rtw_hal *hal, u8 regd, u8 bw, u8 rs)
 		hal->tx_pwr_limit_5g[regd][bw][rs][ch] = RTW_MAX_POWER_INDEX;
 }
 
-void rtw_hw_init_tx_power(struct rtw_hal *hal)
+void rtw_phy_init_tx_power(struct rtw_hal *hal)
 {
 	u8 regd, path, rate, rs, bw;
 
@@ -1720,5 +1720,5 @@ void rtw_hw_init_tx_power(struct rtw_hal *hal)
 	for (regd = 0; regd < RTW_REGD_MAX; regd++)
 		for (bw = 0; bw < RTW_CHANNEL_WIDTH_MAX; bw++)
 			for (rs = 0; rs < RTW_RATE_SECTION_MAX; rs++)
-				rtw_hw_tx_power_limit_init(hal, regd, bw, rs);
+				rtw_phy_init_tx_power_limit(hal, regd, bw, rs);
 }
diff --git a/drivers/net/wireless/realtek/rtw88/phy.h b/drivers/net/wireless/realtek/rtw88/phy.h
index 7ad64e7..dfd8d77 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.h
+++ b/drivers/net/wireless/realtek/rtw88/phy.h
@@ -41,7 +41,7 @@ void rtw_phy_cfg_bb(struct rtw_dev *rtwdev, const struct rtw_table *tbl,
 		    u32 addr, u32 data);
 void rtw_phy_cfg_rf(struct rtw_dev *rtwdev, const struct rtw_table *tbl,
 		    u32 addr, u32 data);
-void rtw_hw_init_tx_power(struct rtw_hal *hal);
+void rtw_phy_init_tx_power(struct rtw_hal *hal);
 void rtw_phy_load_tables(struct rtw_dev *rtwdev);
 void rtw_phy_set_tx_power_level(struct rtw_dev *rtwdev, u8 channel);
 void rtw_phy_tx_power_by_rate_config(struct rtw_hal *hal);
-- 
2.7.4

