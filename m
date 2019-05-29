Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7A432D70E
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 09:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfE2Hy5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 03:54:57 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37189 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfE2Hy5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 03:54:57 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x4T7spjm005542, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x4T7spjm005542
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Wed, 29 May 2019 15:54:51 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.408.0; Wed, 29 May 2019 15:54:50 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 01/11] rtw88: resolve order of tx power setting routines
Date:   Wed, 29 May 2019 15:54:37 +0800
Message-ID: <1559116487-5244-2-git-send-email-yhchuang@realtek.com>
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

Some functions that should be static are unnecessarily exposed, remove
their declaration in header file phy.h.

After resolving their declaration order, they can be declared as static.
So this commit changes nothing except the order and marking them static.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/phy.c | 1287 +++++++++++++++---------------
 drivers/net/wireless/realtek/rtw88/phy.h |    7 +-
 2 files changed, 642 insertions(+), 652 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 404d894..ed104ea 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -65,6 +65,56 @@ static const u32 db_invert_table[12][8] = {
 	 1995262315,	2511886432U,	3162277660U,	3981071706U}
 };
 
+u8 rtw_cck_rates[] = { DESC_RATE1M, DESC_RATE2M, DESC_RATE5_5M, DESC_RATE11M };
+u8 rtw_ofdm_rates[] = {
+	DESC_RATE6M,  DESC_RATE9M,  DESC_RATE12M,
+	DESC_RATE18M, DESC_RATE24M, DESC_RATE36M,
+	DESC_RATE48M, DESC_RATE54M
+};
+u8 rtw_ht_1s_rates[] = {
+	DESC_RATEMCS0, DESC_RATEMCS1, DESC_RATEMCS2,
+	DESC_RATEMCS3, DESC_RATEMCS4, DESC_RATEMCS5,
+	DESC_RATEMCS6, DESC_RATEMCS7
+};
+u8 rtw_ht_2s_rates[] = {
+	DESC_RATEMCS8,  DESC_RATEMCS9,  DESC_RATEMCS10,
+	DESC_RATEMCS11, DESC_RATEMCS12, DESC_RATEMCS13,
+	DESC_RATEMCS14, DESC_RATEMCS15
+};
+u8 rtw_vht_1s_rates[] = {
+	DESC_RATEVHT1SS_MCS0, DESC_RATEVHT1SS_MCS1,
+	DESC_RATEVHT1SS_MCS2, DESC_RATEVHT1SS_MCS3,
+	DESC_RATEVHT1SS_MCS4, DESC_RATEVHT1SS_MCS5,
+	DESC_RATEVHT1SS_MCS6, DESC_RATEVHT1SS_MCS7,
+	DESC_RATEVHT1SS_MCS8, DESC_RATEVHT1SS_MCS9
+};
+u8 rtw_vht_2s_rates[] = {
+	DESC_RATEVHT2SS_MCS0, DESC_RATEVHT2SS_MCS1,
+	DESC_RATEVHT2SS_MCS2, DESC_RATEVHT2SS_MCS3,
+	DESC_RATEVHT2SS_MCS4, DESC_RATEVHT2SS_MCS5,
+	DESC_RATEVHT2SS_MCS6, DESC_RATEVHT2SS_MCS7,
+	DESC_RATEVHT2SS_MCS8, DESC_RATEVHT2SS_MCS9
+};
+u8 *rtw_rate_section[RTW_RATE_SECTION_MAX] = {
+	rtw_cck_rates, rtw_ofdm_rates,
+	rtw_ht_1s_rates, rtw_ht_2s_rates,
+	rtw_vht_1s_rates, rtw_vht_2s_rates
+};
+u8 rtw_rate_size[RTW_RATE_SECTION_MAX] = {
+	ARRAY_SIZE(rtw_cck_rates),
+	ARRAY_SIZE(rtw_ofdm_rates),
+	ARRAY_SIZE(rtw_ht_1s_rates),
+	ARRAY_SIZE(rtw_ht_2s_rates),
+	ARRAY_SIZE(rtw_vht_1s_rates),
+	ARRAY_SIZE(rtw_vht_2s_rates)
+};
+static const u8 rtw_cck_size = ARRAY_SIZE(rtw_cck_rates);
+static const u8 rtw_ofdm_size = ARRAY_SIZE(rtw_ofdm_rates);
+static const u8 rtw_ht_1s_size = ARRAY_SIZE(rtw_ht_1s_rates);
+static const u8 rtw_ht_2s_size = ARRAY_SIZE(rtw_ht_2s_rates);
+static const u8 rtw_vht_1s_size = ARRAY_SIZE(rtw_vht_1s_rates);
+static const u8 rtw_vht_2s_size = ARRAY_SIZE(rtw_vht_2s_rates);
+
 enum rtw_phy_band_type {
 	PHY_BAND_2G	= 0,
 	PHY_BAND_5G	= 1,
@@ -714,563 +764,73 @@ void rtw_parse_tbl_phy_cond(struct rtw_dev *rtwdev, const struct rtw_table *tbl)
 	}
 }
 
-void rtw_parse_tbl_bb_pg(struct rtw_dev *rtwdev, const struct rtw_table *tbl)
-{
-	const struct phy_pg_cfg_pair *p = tbl->data;
-	const struct phy_pg_cfg_pair *end = p + tbl->size / 6;
-
-	BUILD_BUG_ON(sizeof(struct phy_pg_cfg_pair) != sizeof(u32) * 6);
-
-	for (; p < end; p++) {
-		if (p->addr == 0xfe || p->addr == 0xffe) {
-			msleep(50);
-			continue;
-		}
-		phy_store_tx_power_by_rate(rtwdev, p->band, p->rf_path,
-					   p->tx_num, p->addr, p->bitmask,
-					   p->data);
-	}
-}
-
-void rtw_parse_tbl_txpwr_lmt(struct rtw_dev *rtwdev,
-			     const struct rtw_table *tbl)
-{
-	const struct txpwr_lmt_cfg_pair *p = tbl->data;
-	const struct txpwr_lmt_cfg_pair *end = p + tbl->size / 6;
-
-	BUILD_BUG_ON(sizeof(struct txpwr_lmt_cfg_pair) != sizeof(u8) * 6);
-
-	for (; p < end; p++) {
-		phy_set_tx_power_limit(rtwdev, p->regd, p->band,
-				       p->bw, p->rs,
-				       p->ch, p->txpwr_lmt);
-	}
-}
-
-void rtw_phy_cfg_mac(struct rtw_dev *rtwdev, const struct rtw_table *tbl,
-		     u32 addr, u32 data)
-{
-	rtw_write8(rtwdev, addr, data);
-}
-
-void rtw_phy_cfg_agc(struct rtw_dev *rtwdev, const struct rtw_table *tbl,
-		     u32 addr, u32 data)
-{
-	rtw_write32(rtwdev, addr, data);
-}
-
-void rtw_phy_cfg_bb(struct rtw_dev *rtwdev, const struct rtw_table *tbl,
-		    u32 addr, u32 data)
-{
-	if (addr == 0xfe)
-		msleep(50);
-	else if (addr == 0xfd)
-		mdelay(5);
-	else if (addr == 0xfc)
-		mdelay(1);
-	else if (addr == 0xfb)
-		usleep_range(50, 60);
-	else if (addr == 0xfa)
-		udelay(5);
-	else if (addr == 0xf9)
-		udelay(1);
-	else
-		rtw_write32(rtwdev, addr, data);
-}
-
-void rtw_phy_cfg_rf(struct rtw_dev *rtwdev, const struct rtw_table *tbl,
-		    u32 addr, u32 data)
-{
-	if (addr == 0xffe) {
-		msleep(50);
-	} else if (addr == 0xfe) {
-		usleep_range(100, 110);
-	} else {
-		rtw_write_rf(rtwdev, tbl->rf_path, addr, RFREG_MASK, data);
-		udelay(1);
-	}
-}
-
-static void rtw_load_rfk_table(struct rtw_dev *rtwdev)
-{
-	struct rtw_chip_info *chip = rtwdev->chip;
-
-	if (!chip->rfk_init_tbl)
-		return;
-
-	rtw_load_table(rtwdev, chip->rfk_init_tbl);
-}
-
-void rtw_phy_load_tables(struct rtw_dev *rtwdev)
-{
-	struct rtw_chip_info *chip = rtwdev->chip;
-	u8 rf_path;
-
-	rtw_load_table(rtwdev, chip->mac_tbl);
-	rtw_load_table(rtwdev, chip->bb_tbl);
-	rtw_load_table(rtwdev, chip->agc_tbl);
-	rtw_load_rfk_table(rtwdev);
-
-	for (rf_path = 0; rf_path < rtwdev->hal.rf_path_num; rf_path++) {
-		const struct rtw_table *tbl;
-
-		tbl = chip->rf_tbl[rf_path];
-		rtw_load_table(rtwdev, tbl);
-	}
-}
-
 #define bcd_to_dec_pwr_by_rate(val, i) bcd2bin(val >> (i * 8))
 
-#define RTW_MAX_POWER_INDEX		0x3F
-
-u8 rtw_cck_rates[] = { DESC_RATE1M, DESC_RATE2M, DESC_RATE5_5M, DESC_RATE11M };
-u8 rtw_ofdm_rates[] = {
-	DESC_RATE6M,  DESC_RATE9M,  DESC_RATE12M,
-	DESC_RATE18M, DESC_RATE24M, DESC_RATE36M,
-	DESC_RATE48M, DESC_RATE54M
-};
-u8 rtw_ht_1s_rates[] = {
-	DESC_RATEMCS0, DESC_RATEMCS1, DESC_RATEMCS2,
-	DESC_RATEMCS3, DESC_RATEMCS4, DESC_RATEMCS5,
-	DESC_RATEMCS6, DESC_RATEMCS7
-};
-u8 rtw_ht_2s_rates[] = {
-	DESC_RATEMCS8,  DESC_RATEMCS9,  DESC_RATEMCS10,
-	DESC_RATEMCS11, DESC_RATEMCS12, DESC_RATEMCS13,
-	DESC_RATEMCS14, DESC_RATEMCS15
-};
-u8 rtw_vht_1s_rates[] = {
-	DESC_RATEVHT1SS_MCS0, DESC_RATEVHT1SS_MCS1,
-	DESC_RATEVHT1SS_MCS2, DESC_RATEVHT1SS_MCS3,
-	DESC_RATEVHT1SS_MCS4, DESC_RATEVHT1SS_MCS5,
-	DESC_RATEVHT1SS_MCS6, DESC_RATEVHT1SS_MCS7,
-	DESC_RATEVHT1SS_MCS8, DESC_RATEVHT1SS_MCS9
-};
-u8 rtw_vht_2s_rates[] = {
-	DESC_RATEVHT2SS_MCS0, DESC_RATEVHT2SS_MCS1,
-	DESC_RATEVHT2SS_MCS2, DESC_RATEVHT2SS_MCS3,
-	DESC_RATEVHT2SS_MCS4, DESC_RATEVHT2SS_MCS5,
-	DESC_RATEVHT2SS_MCS6, DESC_RATEVHT2SS_MCS7,
-	DESC_RATEVHT2SS_MCS8, DESC_RATEVHT2SS_MCS9
-};
-
-static u8 rtw_cck_size = ARRAY_SIZE(rtw_cck_rates);
-static u8 rtw_ofdm_size = ARRAY_SIZE(rtw_ofdm_rates);
-static u8 rtw_ht_1s_size = ARRAY_SIZE(rtw_ht_1s_rates);
-static u8 rtw_ht_2s_size = ARRAY_SIZE(rtw_ht_2s_rates);
-static u8 rtw_vht_1s_size = ARRAY_SIZE(rtw_vht_1s_rates);
-static u8 rtw_vht_2s_size = ARRAY_SIZE(rtw_vht_2s_rates);
-u8 *rtw_rate_section[RTW_RATE_SECTION_MAX] = {
-	rtw_cck_rates, rtw_ofdm_rates,
-	rtw_ht_1s_rates, rtw_ht_2s_rates,
-	rtw_vht_1s_rates, rtw_vht_2s_rates
-};
-u8 rtw_rate_size[RTW_RATE_SECTION_MAX] = {
-	ARRAY_SIZE(rtw_cck_rates),
-	ARRAY_SIZE(rtw_ofdm_rates),
-	ARRAY_SIZE(rtw_ht_1s_rates),
-	ARRAY_SIZE(rtw_ht_2s_rates),
-	ARRAY_SIZE(rtw_vht_1s_rates),
-	ARRAY_SIZE(rtw_vht_2s_rates)
-};
-
-static const u8 rtw_channel_idx_5g[RTW_MAX_CHANNEL_NUM_5G] = {
-	36,  38,  40,  42,  44,  46,  48, /* Band 1 */
-	52,  54,  56,  58,  60,  62,  64, /* Band 2 */
-	100, 102, 104, 106, 108, 110, 112, /* Band 3 */
-	116, 118, 120, 122, 124, 126, 128, /* Band 3 */
-	132, 134, 136, 138, 140, 142, 144, /* Band 3 */
-	149, 151, 153, 155, 157, 159, 161, /* Band 4 */
-	165, 167, 169, 171, 173, 175, 177}; /* Band 4 */
-
-static int rtw_channel_to_idx(u8 band, u8 channel)
+static u8 tbl_to_dec_pwr_by_rate(struct rtw_dev *rtwdev, u32 hex, u8 i)
 {
-	int ch_idx;
-	u8 n_channel;
-
-	if (band == PHY_BAND_2G) {
-		ch_idx = channel - 1;
-		n_channel = RTW_MAX_CHANNEL_NUM_2G;
-	} else if (band == PHY_BAND_5G) {
-		n_channel = RTW_MAX_CHANNEL_NUM_5G;
-		for (ch_idx = 0; ch_idx < n_channel; ch_idx++)
-			if (rtw_channel_idx_5g[ch_idx] == channel)
-				break;
-	} else {
-		return -1;
-	}
-
-	if (ch_idx >= n_channel)
-		return -1;
+	if (rtwdev->chip->is_pwr_by_rate_dec)
+		return bcd_to_dec_pwr_by_rate(hex, i);
 
-	return ch_idx;
+	return (hex >> (i * 8)) & 0xFF;
 }
 
-static u8 rtw_get_channel_group(u8 channel)
+static void phy_get_rate_values_of_txpwr_by_rate(struct rtw_dev *rtwdev,
+						 u32 addr, u32 mask,
+						 u32 val, u8 *rate,
+						 u8 *pwr_by_rate, u8 *rate_num)
 {
-	switch (channel) {
-	default:
-		WARN_ON(1);
-		/* fall through */
-	case 1:
-	case 2:
-	case 36:
-	case 38:
-	case 40:
-	case 42:
-		return 0;
-	case 3:
-	case 4:
-	case 5:
-	case 44:
-	case 46:
-	case 48:
-	case 50:
-		return 1;
-	case 6:
-	case 7:
-	case 8:
-	case 52:
-	case 54:
-	case 56:
-	case 58:
-		return 2;
-	case 9:
-	case 10:
-	case 11:
-	case 60:
-	case 62:
-	case 64:
-		return 3;
-	case 12:
-	case 13:
-	case 100:
-	case 102:
-	case 104:
-	case 106:
-		return 4;
-	case 14:
-	case 108:
-	case 110:
-	case 112:
-	case 114:
-		return 5;
-	case 116:
-	case 118:
-	case 120:
-	case 122:
-		return 6;
-	case 124:
-	case 126:
-	case 128:
-	case 130:
-		return 7;
-	case 132:
-	case 134:
-	case 136:
-	case 138:
-		return 8;
-	case 140:
-	case 142:
-	case 144:
-		return 9;
-	case 149:
-	case 151:
-	case 153:
-	case 155:
-		return 10;
-	case 157:
-	case 159:
-	case 161:
-		return 11;
-	case 165:
-	case 167:
-	case 169:
-	case 171:
-		return 12;
-	case 173:
-	case 175:
-	case 177:
-		return 13;
-	}
-}
-
-static u8 phy_get_2g_tx_power_index(struct rtw_dev *rtwdev,
-				    struct rtw_2g_txpwr_idx *pwr_idx_2g,
-				    enum rtw_bandwidth bandwidth,
-				    u8 rate, u8 group)
-{
-	struct rtw_chip_info *chip = rtwdev->chip;
-	u8 tx_power;
-	bool mcs_rate;
-	bool above_2ss;
-	u8 factor = chip->txgi_factor;
-
-	if (rate <= DESC_RATE11M)
-		tx_power = pwr_idx_2g->cck_base[group];
-	else
-		tx_power = pwr_idx_2g->bw40_base[group];
-
-	if (rate >= DESC_RATE6M && rate <= DESC_RATE54M)
-		tx_power += pwr_idx_2g->ht_1s_diff.ofdm * factor;
-
-	mcs_rate = (rate >= DESC_RATEMCS0 && rate <= DESC_RATEMCS15) ||
-		   (rate >= DESC_RATEVHT1SS_MCS0 &&
-		    rate <= DESC_RATEVHT2SS_MCS9);
-	above_2ss = (rate >= DESC_RATEMCS8 && rate <= DESC_RATEMCS15) ||
-		    (rate >= DESC_RATEVHT2SS_MCS0);
-
-	if (!mcs_rate)
-		return tx_power;
+	int i;
 
-	switch (bandwidth) {
-	default:
-		WARN_ON(1);
-		/* fall through */
-	case RTW_CHANNEL_WIDTH_20:
-		tx_power += pwr_idx_2g->ht_1s_diff.bw20 * factor;
-		if (above_2ss)
-			tx_power += pwr_idx_2g->ht_2s_diff.bw20 * factor;
+	switch (addr) {
+	case 0xE00:
+	case 0x830:
+		rate[0] = DESC_RATE6M;
+		rate[1] = DESC_RATE9M;
+		rate[2] = DESC_RATE12M;
+		rate[3] = DESC_RATE18M;
+		for (i = 0; i < 4; ++i)
+			pwr_by_rate[i] = tbl_to_dec_pwr_by_rate(rtwdev, val, i);
+		*rate_num = 4;
 		break;
-	case RTW_CHANNEL_WIDTH_40:
-		/* bw40 is the base power */
-		if (above_2ss)
-			tx_power += pwr_idx_2g->ht_2s_diff.bw40 * factor;
+	case 0xE04:
+	case 0x834:
+		rate[0] = DESC_RATE24M;
+		rate[1] = DESC_RATE36M;
+		rate[2] = DESC_RATE48M;
+		rate[3] = DESC_RATE54M;
+		for (i = 0; i < 4; ++i)
+			pwr_by_rate[i] = tbl_to_dec_pwr_by_rate(rtwdev, val, i);
+		*rate_num = 4;
 		break;
-	}
-
-	return tx_power;
-}
-
-static u8 phy_get_5g_tx_power_index(struct rtw_dev *rtwdev,
-				    struct rtw_5g_txpwr_idx *pwr_idx_5g,
-				    enum rtw_bandwidth bandwidth,
-				    u8 rate, u8 group)
-{
-	struct rtw_chip_info *chip = rtwdev->chip;
-	u8 tx_power;
-	u8 upper, lower;
-	bool mcs_rate;
-	bool above_2ss;
-	u8 factor = chip->txgi_factor;
-
-	tx_power = pwr_idx_5g->bw40_base[group];
-
-	mcs_rate = (rate >= DESC_RATEMCS0 && rate <= DESC_RATEMCS15) ||
-		   (rate >= DESC_RATEVHT1SS_MCS0 &&
-		    rate <= DESC_RATEVHT2SS_MCS9);
-	above_2ss = (rate >= DESC_RATEMCS8 && rate <= DESC_RATEMCS15) ||
-		    (rate >= DESC_RATEVHT2SS_MCS0);
-
-	if (!mcs_rate) {
-		tx_power += pwr_idx_5g->ht_1s_diff.ofdm * factor;
-		return tx_power;
-	}
-
-	switch (bandwidth) {
-	default:
-		WARN_ON(1);
-		/* fall through */
-	case RTW_CHANNEL_WIDTH_20:
-		tx_power += pwr_idx_5g->ht_1s_diff.bw20 * factor;
-		if (above_2ss)
-			tx_power += pwr_idx_5g->ht_2s_diff.bw20 * factor;
+	case 0xE08:
+		rate[0] = DESC_RATE1M;
+		pwr_by_rate[0] = bcd_to_dec_pwr_by_rate(val, 1);
+		*rate_num = 1;
 		break;
-	case RTW_CHANNEL_WIDTH_40:
-		/* bw40 is the base power */
-		if (above_2ss)
-			tx_power += pwr_idx_5g->ht_2s_diff.bw40 * factor;
+	case 0x86C:
+		if (mask == 0xffffff00) {
+			rate[0] = DESC_RATE2M;
+			rate[1] = DESC_RATE5_5M;
+			rate[2] = DESC_RATE11M;
+			for (i = 1; i < 4; ++i)
+				pwr_by_rate[i - 1] =
+					tbl_to_dec_pwr_by_rate(rtwdev, val, i);
+			*rate_num = 3;
+		} else if (mask == 0x000000ff) {
+			rate[0] = DESC_RATE11M;
+			pwr_by_rate[0] = bcd_to_dec_pwr_by_rate(val, 0);
+			*rate_num = 1;
+		}
 		break;
-	case RTW_CHANNEL_WIDTH_80:
-		/* the base idx of bw80 is the average of bw40+/bw40- */
-		lower = pwr_idx_5g->bw40_base[group];
-		upper = pwr_idx_5g->bw40_base[group + 1];
-
-		tx_power = (lower + upper) / 2;
-		tx_power += pwr_idx_5g->vht_1s_diff.bw80 * factor;
-		if (above_2ss)
-			tx_power += pwr_idx_5g->vht_2s_diff.bw80 * factor;
-		break;
-	}
-
-	return tx_power;
-}
-
-/* set tx power level by path for each rates, note that the order of the rates
- * are *very* important, bacause 8822B/8821C combines every four bytes of tx
- * power index into a four-byte power index register, and calls set_tx_agc to
- * write these values into hardware
- */
-static
-void phy_set_tx_power_level_by_path(struct rtw_dev *rtwdev, u8 ch, u8 path)
-{
-	struct rtw_hal *hal = &rtwdev->hal;
-	u8 rs;
-
-	/* do not need cck rates if we are not in 2.4G */
-	if (hal->current_band_type == RTW_BAND_2G)
-		rs = RTW_RATE_SECTION_CCK;
-	else
-		rs = RTW_RATE_SECTION_OFDM;
-
-	for (; rs < RTW_RATE_SECTION_MAX; rs++)
-		phy_set_tx_power_index_by_rs(rtwdev, ch, path, rs);
-}
-
-void rtw_phy_set_tx_power_level(struct rtw_dev *rtwdev, u8 channel)
-{
-	struct rtw_chip_info *chip = rtwdev->chip;
-	struct rtw_hal *hal = &rtwdev->hal;
-	u8 path;
-
-	mutex_lock(&hal->tx_power_mutex);
-
-	for (path = 0; path < hal->rf_path_num; path++)
-		phy_set_tx_power_level_by_path(rtwdev, channel, path);
-
-	chip->ops->set_tx_power_index(rtwdev);
-	mutex_unlock(&hal->tx_power_mutex);
-}
-
-s8 phy_get_tx_power_limit(struct rtw_dev *rtwdev, u8 band,
-			  enum rtw_bandwidth bandwidth, u8 rf_path,
-			  u8 rate, u8 channel, u8 regd);
-
-static
-u8 phy_get_tx_power_index(void *adapter, u8 rf_path, u8 rate,
-			  enum rtw_bandwidth bandwidth, u8 channel, u8 regd)
-{
-	struct rtw_dev *rtwdev = adapter;
-	struct rtw_hal *hal = &rtwdev->hal;
-	struct rtw_txpwr_idx *pwr_idx;
-	u8 tx_power;
-	u8 group;
-	u8 band;
-	s8 offset, limit;
-
-	pwr_idx = &rtwdev->efuse.txpwr_idx_table[rf_path];
-	group = rtw_get_channel_group(channel);
-
-	/* base power index for 2.4G/5G */
-	if (channel <= 14) {
-		band = PHY_BAND_2G;
-		tx_power = phy_get_2g_tx_power_index(rtwdev,
-						     &pwr_idx->pwr_idx_2g,
-						     bandwidth, rate, group);
-		offset = hal->tx_pwr_by_rate_offset_2g[rf_path][rate];
-	} else {
-		band = PHY_BAND_5G;
-		tx_power = phy_get_5g_tx_power_index(rtwdev,
-						     &pwr_idx->pwr_idx_5g,
-						     bandwidth, rate, group);
-		offset = hal->tx_pwr_by_rate_offset_5g[rf_path][rate];
-	}
-
-	limit = phy_get_tx_power_limit(rtwdev, band, bandwidth, rf_path,
-				       rate, channel, regd);
-
-	if (offset > limit)
-		offset = limit;
-
-	tx_power += offset;
-
-	if (tx_power > rtwdev->chip->max_power_index)
-		tx_power = rtwdev->chip->max_power_index;
-
-	return tx_power;
-}
-
-void phy_set_tx_power_index_by_rs(void *adapter, u8 ch, u8 path, u8 rs)
-{
-	struct rtw_dev *rtwdev = adapter;
-	struct rtw_hal *hal = &rtwdev->hal;
-	u8 regd = rtwdev->regd.txpwr_regd;
-	u8 *rates;
-	u8 size;
-	u8 rate;
-	u8 pwr_idx;
-	u8 bw;
-	int i;
-
-	if (rs >= RTW_RATE_SECTION_MAX)
-		return;
-
-	rates = rtw_rate_section[rs];
-	size = rtw_rate_size[rs];
-	bw = hal->current_band_width;
-	for (i = 0; i < size; i++) {
-		rate = rates[i];
-		pwr_idx = phy_get_tx_power_index(adapter, path, rate, bw, ch,
-						 regd);
-		hal->tx_pwr_tbl[path][rate] = pwr_idx;
-	}
-}
-
-static u8 tbl_to_dec_pwr_by_rate(struct rtw_dev *rtwdev, u32 hex, u8 i)
-{
-	if (rtwdev->chip->is_pwr_by_rate_dec)
-		return bcd_to_dec_pwr_by_rate(hex, i);
-	else
-		return (hex >> (i * 8)) & 0xFF;
-}
-
-static void phy_get_rate_values_of_txpwr_by_rate(struct rtw_dev *rtwdev,
-						 u32 addr, u32 mask,
-						 u32 val, u8 *rate,
-						 u8 *pwr_by_rate, u8 *rate_num)
-{
-	int i;
-
-	switch (addr) {
-	case 0xE00:
-	case 0x830:
-		rate[0] = DESC_RATE6M;
-		rate[1] = DESC_RATE9M;
-		rate[2] = DESC_RATE12M;
-		rate[3] = DESC_RATE18M;
-		for (i = 0; i < 4; ++i)
-			pwr_by_rate[i] = tbl_to_dec_pwr_by_rate(rtwdev, val, i);
-		*rate_num = 4;
-		break;
-	case 0xE04:
-	case 0x834:
-		rate[0] = DESC_RATE24M;
-		rate[1] = DESC_RATE36M;
-		rate[2] = DESC_RATE48M;
-		rate[3] = DESC_RATE54M;
-		for (i = 0; i < 4; ++i)
-			pwr_by_rate[i] = tbl_to_dec_pwr_by_rate(rtwdev, val, i);
-		*rate_num = 4;
-		break;
-	case 0xE08:
-		rate[0] = DESC_RATE1M;
-		pwr_by_rate[0] = bcd_to_dec_pwr_by_rate(val, 1);
-		*rate_num = 1;
-		break;
-	case 0x86C:
-		if (mask == 0xffffff00) {
-			rate[0] = DESC_RATE2M;
-			rate[1] = DESC_RATE5_5M;
-			rate[2] = DESC_RATE11M;
-			for (i = 1; i < 4; ++i)
-				pwr_by_rate[i - 1] =
-					tbl_to_dec_pwr_by_rate(rtwdev, val, i);
-			*rate_num = 3;
-		} else if (mask == 0x000000ff) {
-			rate[0] = DESC_RATE11M;
-			pwr_by_rate[0] = bcd_to_dec_pwr_by_rate(val, 0);
-			*rate_num = 1;
-		}
-		break;
-	case 0xE10:
-	case 0x83C:
-		rate[0] = DESC_RATEMCS0;
-		rate[1] = DESC_RATEMCS1;
-		rate[2] = DESC_RATEMCS2;
-		rate[3] = DESC_RATEMCS3;
-		for (i = 0; i < 4; ++i)
-			pwr_by_rate[i] = tbl_to_dec_pwr_by_rate(rtwdev, val, i);
-		*rate_num = 4;
+	case 0xE10:
+	case 0x83C:
+		rate[0] = DESC_RATEMCS0;
+		rate[1] = DESC_RATEMCS1;
+		rate[2] = DESC_RATEMCS2;
+		rate[3] = DESC_RATEMCS3;
+		for (i = 0; i < 4; ++i)
+			pwr_by_rate[i] = tbl_to_dec_pwr_by_rate(rtwdev, val, i);
+		*rate_num = 4;
 		break;
 	case 0xE14:
 	case 0x848:
@@ -1301,7 +861,6 @@ static void phy_get_rate_values_of_txpwr_by_rate(struct rtw_dev *rtwdev,
 		for (i = 0; i < 4; ++i)
 			pwr_by_rate[i] = tbl_to_dec_pwr_by_rate(rtwdev, val, i);
 		*rate_num = 4;
-
 		break;
 	case 0x838:
 		rate[0] = DESC_RATE1M;
@@ -1504,54 +1063,558 @@ static void phy_get_rate_values_of_txpwr_by_rate(struct rtw_dev *rtwdev,
 			pwr_by_rate[i] = tbl_to_dec_pwr_by_rate(rtwdev, val, i);
 		*rate_num = 4;
 		break;
-	case 0xCE8:
-	case 0xEE8:
-	case 0x18E8:
-	case 0x1AE8:
-		rate[0] = DESC_RATEVHT3SS_MCS8;
-		rate[1] = DESC_RATEVHT3SS_MCS9;
-		for (i = 0; i < 2; ++i)
-			pwr_by_rate[i] = tbl_to_dec_pwr_by_rate(rtwdev, val, i);
-		*rate_num = 2;
+	case 0xCE8:
+	case 0xEE8:
+	case 0x18E8:
+	case 0x1AE8:
+		rate[0] = DESC_RATEVHT3SS_MCS8;
+		rate[1] = DESC_RATEVHT3SS_MCS9;
+		for (i = 0; i < 2; ++i)
+			pwr_by_rate[i] = tbl_to_dec_pwr_by_rate(rtwdev, val, i);
+		*rate_num = 2;
+		break;
+	default:
+		rtw_warn(rtwdev, "invalid tx power index addr 0x%08x\n", addr);
+		break;
+	}
+}
+
+static void phy_store_tx_power_by_rate(void *adapter,
+				       u32 band, u32 rfpath, u32 txnum,
+				       u32 regaddr, u32 bitmask, u32 data)
+{
+	struct rtw_dev *rtwdev = adapter;
+	struct rtw_hal *hal = &rtwdev->hal;
+	u8 rate_num = 0;
+	u8 rate;
+	u8 rates[RTW_RF_PATH_MAX] = {0};
+	s8 offset;
+	s8 pwr_by_rate[RTW_RF_PATH_MAX] = {0};
+	int i;
+
+	phy_get_rate_values_of_txpwr_by_rate(rtwdev, regaddr, bitmask, data,
+					     rates, pwr_by_rate, &rate_num);
+
+	if (WARN_ON(rfpath >= RTW_RF_PATH_MAX ||
+		    (band != PHY_BAND_2G && band != PHY_BAND_5G) ||
+		    rate_num > RTW_RF_PATH_MAX))
+		return;
+
+	for (i = 0; i < rate_num; i++) {
+		offset = pwr_by_rate[i];
+		rate = rates[i];
+		if (band == PHY_BAND_2G)
+			hal->tx_pwr_by_rate_offset_2g[rfpath][rate] = offset;
+		else if (band == PHY_BAND_5G)
+			hal->tx_pwr_by_rate_offset_5g[rfpath][rate] = offset;
+		else
+			continue;
+	}
+}
+
+void rtw_parse_tbl_bb_pg(struct rtw_dev *rtwdev, const struct rtw_table *tbl)
+{
+	const struct phy_pg_cfg_pair *p = tbl->data;
+	const struct phy_pg_cfg_pair *end = p + tbl->size / 6;
+
+	BUILD_BUG_ON(sizeof(struct phy_pg_cfg_pair) != sizeof(u32) * 6);
+
+	for (; p < end; p++) {
+		if (p->addr == 0xfe || p->addr == 0xffe) {
+			msleep(50);
+			continue;
+		}
+		phy_store_tx_power_by_rate(rtwdev, p->band, p->rf_path,
+					   p->tx_num, p->addr, p->bitmask,
+					   p->data);
+	}
+}
+
+static const u8 rtw_channel_idx_5g[RTW_MAX_CHANNEL_NUM_5G] = {
+	36,  38,  40,  42,  44,  46,  48, /* Band 1 */
+	52,  54,  56,  58,  60,  62,  64, /* Band 2 */
+	100, 102, 104, 106, 108, 110, 112, /* Band 3 */
+	116, 118, 120, 122, 124, 126, 128, /* Band 3 */
+	132, 134, 136, 138, 140, 142, 144, /* Band 3 */
+	149, 151, 153, 155, 157, 159, 161, /* Band 4 */
+	165, 167, 169, 171, 173, 175, 177}; /* Band 4 */
+
+static int rtw_channel_to_idx(u8 band, u8 channel)
+{
+	int ch_idx;
+	u8 n_channel;
+
+	if (band == PHY_BAND_2G) {
+		ch_idx = channel - 1;
+		n_channel = RTW_MAX_CHANNEL_NUM_2G;
+	} else if (band == PHY_BAND_5G) {
+		n_channel = RTW_MAX_CHANNEL_NUM_5G;
+		for (ch_idx = 0; ch_idx < n_channel; ch_idx++)
+			if (rtw_channel_idx_5g[ch_idx] == channel)
+				break;
+	} else {
+		return -1;
+	}
+
+	if (ch_idx >= n_channel)
+		return -1;
+
+	return ch_idx;
+}
+
+static void phy_set_tx_power_limit(struct rtw_dev *rtwdev, u8 regd, u8 band,
+				   u8 bw, u8 rs, u8 ch, s8 pwr_limit)
+{
+	struct rtw_hal *hal = &rtwdev->hal;
+	int ch_idx;
+
+	pwr_limit = clamp_t(s8, pwr_limit,
+			    -RTW_MAX_POWER_INDEX, RTW_MAX_POWER_INDEX);
+	ch_idx = rtw_channel_to_idx(band, ch);
+
+	if (regd >= RTW_REGD_MAX || bw >= RTW_CHANNEL_WIDTH_MAX ||
+	    rs >= RTW_RATE_SECTION_MAX || ch_idx < 0) {
+		WARN(1,
+		     "wrong txpwr_lmt regd=%u, band=%u bw=%u, rs=%u, ch_idx=%u, pwr_limit=%d\n",
+		     regd, band, bw, rs, ch_idx, pwr_limit);
+		return;
+	}
+
+	if (band == PHY_BAND_2G)
+		hal->tx_pwr_limit_2g[regd][bw][rs][ch_idx] = pwr_limit;
+	else if (band == PHY_BAND_5G)
+		hal->tx_pwr_limit_5g[regd][bw][rs][ch_idx] = pwr_limit;
+}
+
+void rtw_parse_tbl_txpwr_lmt(struct rtw_dev *rtwdev,
+			     const struct rtw_table *tbl)
+{
+	const struct txpwr_lmt_cfg_pair *p = tbl->data;
+	const struct txpwr_lmt_cfg_pair *end = p + tbl->size / 6;
+
+	BUILD_BUG_ON(sizeof(struct txpwr_lmt_cfg_pair) != sizeof(u8) * 6);
+
+	for (; p < end; p++) {
+		phy_set_tx_power_limit(rtwdev, p->regd, p->band,
+				       p->bw, p->rs,
+				       p->ch, p->txpwr_lmt);
+	}
+}
+
+void rtw_phy_cfg_mac(struct rtw_dev *rtwdev, const struct rtw_table *tbl,
+		     u32 addr, u32 data)
+{
+	rtw_write8(rtwdev, addr, data);
+}
+
+void rtw_phy_cfg_agc(struct rtw_dev *rtwdev, const struct rtw_table *tbl,
+		     u32 addr, u32 data)
+{
+	rtw_write32(rtwdev, addr, data);
+}
+
+void rtw_phy_cfg_bb(struct rtw_dev *rtwdev, const struct rtw_table *tbl,
+		    u32 addr, u32 data)
+{
+	if (addr == 0xfe)
+		msleep(50);
+	else if (addr == 0xfd)
+		mdelay(5);
+	else if (addr == 0xfc)
+		mdelay(1);
+	else if (addr == 0xfb)
+		usleep_range(50, 60);
+	else if (addr == 0xfa)
+		udelay(5);
+	else if (addr == 0xf9)
+		udelay(1);
+	else
+		rtw_write32(rtwdev, addr, data);
+}
+
+void rtw_phy_cfg_rf(struct rtw_dev *rtwdev, const struct rtw_table *tbl,
+		    u32 addr, u32 data)
+{
+	if (addr == 0xffe) {
+		msleep(50);
+	} else if (addr == 0xfe) {
+		usleep_range(100, 110);
+	} else {
+		rtw_write_rf(rtwdev, tbl->rf_path, addr, RFREG_MASK, data);
+		udelay(1);
+	}
+}
+
+static void rtw_load_rfk_table(struct rtw_dev *rtwdev)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+
+	if (!chip->rfk_init_tbl)
+		return;
+
+	rtw_load_table(rtwdev, chip->rfk_init_tbl);
+}
+
+void rtw_phy_load_tables(struct rtw_dev *rtwdev)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u8 rf_path;
+
+	rtw_load_table(rtwdev, chip->mac_tbl);
+	rtw_load_table(rtwdev, chip->bb_tbl);
+	rtw_load_table(rtwdev, chip->agc_tbl);
+	rtw_load_rfk_table(rtwdev);
+
+	for (rf_path = 0; rf_path < rtwdev->hal.rf_path_num; rf_path++) {
+		const struct rtw_table *tbl;
+
+		tbl = chip->rf_tbl[rf_path];
+		rtw_load_table(rtwdev, tbl);
+	}
+}
+
+static u8 rtw_get_channel_group(u8 channel)
+{
+	switch (channel) {
+	default:
+		WARN_ON(1);
+		/* fall through */
+	case 1:
+	case 2:
+	case 36:
+	case 38:
+	case 40:
+	case 42:
+		return 0;
+	case 3:
+	case 4:
+	case 5:
+	case 44:
+	case 46:
+	case 48:
+	case 50:
+		return 1;
+	case 6:
+	case 7:
+	case 8:
+	case 52:
+	case 54:
+	case 56:
+	case 58:
+		return 2;
+	case 9:
+	case 10:
+	case 11:
+	case 60:
+	case 62:
+	case 64:
+		return 3;
+	case 12:
+	case 13:
+	case 100:
+	case 102:
+	case 104:
+	case 106:
+		return 4;
+	case 14:
+	case 108:
+	case 110:
+	case 112:
+	case 114:
+		return 5;
+	case 116:
+	case 118:
+	case 120:
+	case 122:
+		return 6;
+	case 124:
+	case 126:
+	case 128:
+	case 130:
+		return 7;
+	case 132:
+	case 134:
+	case 136:
+	case 138:
+		return 8;
+	case 140:
+	case 142:
+	case 144:
+		return 9;
+	case 149:
+	case 151:
+	case 153:
+	case 155:
+		return 10;
+	case 157:
+	case 159:
+	case 161:
+		return 11;
+	case 165:
+	case 167:
+	case 169:
+	case 171:
+		return 12;
+	case 173:
+	case 175:
+	case 177:
+		return 13;
+	}
+}
+
+static u8 phy_get_2g_tx_power_index(struct rtw_dev *rtwdev,
+				    struct rtw_2g_txpwr_idx *pwr_idx_2g,
+				    enum rtw_bandwidth bandwidth,
+				    u8 rate, u8 group)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u8 tx_power;
+	bool mcs_rate;
+	bool above_2ss;
+	u8 factor = chip->txgi_factor;
+
+	if (rate <= DESC_RATE11M)
+		tx_power = pwr_idx_2g->cck_base[group];
+	else
+		tx_power = pwr_idx_2g->bw40_base[group];
+
+	if (rate >= DESC_RATE6M && rate <= DESC_RATE54M)
+		tx_power += pwr_idx_2g->ht_1s_diff.ofdm * factor;
+
+	mcs_rate = (rate >= DESC_RATEMCS0 && rate <= DESC_RATEMCS15) ||
+		   (rate >= DESC_RATEVHT1SS_MCS0 &&
+		    rate <= DESC_RATEVHT2SS_MCS9);
+	above_2ss = (rate >= DESC_RATEMCS8 && rate <= DESC_RATEMCS15) ||
+		    (rate >= DESC_RATEVHT2SS_MCS0);
+
+	if (!mcs_rate)
+		return tx_power;
+
+	switch (bandwidth) {
+	default:
+		WARN_ON(1);
+		/* fall through */
+	case RTW_CHANNEL_WIDTH_20:
+		tx_power += pwr_idx_2g->ht_1s_diff.bw20 * factor;
+		if (above_2ss)
+			tx_power += pwr_idx_2g->ht_2s_diff.bw20 * factor;
+		break;
+	case RTW_CHANNEL_WIDTH_40:
+		/* bw40 is the base power */
+		if (above_2ss)
+			tx_power += pwr_idx_2g->ht_2s_diff.bw40 * factor;
+		break;
+	}
+
+	return tx_power;
+}
+
+static u8 phy_get_5g_tx_power_index(struct rtw_dev *rtwdev,
+				    struct rtw_5g_txpwr_idx *pwr_idx_5g,
+				    enum rtw_bandwidth bandwidth,
+				    u8 rate, u8 group)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u8 tx_power;
+	u8 upper, lower;
+	bool mcs_rate;
+	bool above_2ss;
+	u8 factor = chip->txgi_factor;
+
+	tx_power = pwr_idx_5g->bw40_base[group];
+
+	mcs_rate = (rate >= DESC_RATEMCS0 && rate <= DESC_RATEMCS15) ||
+		   (rate >= DESC_RATEVHT1SS_MCS0 &&
+		    rate <= DESC_RATEVHT2SS_MCS9);
+	above_2ss = (rate >= DESC_RATEMCS8 && rate <= DESC_RATEMCS15) ||
+		    (rate >= DESC_RATEVHT2SS_MCS0);
+
+	if (!mcs_rate) {
+		tx_power += pwr_idx_5g->ht_1s_diff.ofdm * factor;
+		return tx_power;
+	}
+
+	switch (bandwidth) {
+	default:
+		WARN_ON(1);
+		/* fall through */
+	case RTW_CHANNEL_WIDTH_20:
+		tx_power += pwr_idx_5g->ht_1s_diff.bw20 * factor;
+		if (above_2ss)
+			tx_power += pwr_idx_5g->ht_2s_diff.bw20 * factor;
+		break;
+	case RTW_CHANNEL_WIDTH_40:
+		/* bw40 is the base power */
+		if (above_2ss)
+			tx_power += pwr_idx_5g->ht_2s_diff.bw40 * factor;
 		break;
-	default:
-		rtw_warn(rtwdev, "invalid tx power index addr 0x%08x\n", addr);
+	case RTW_CHANNEL_WIDTH_80:
+		/* the base idx of bw80 is the average of bw40+/bw40- */
+		lower = pwr_idx_5g->bw40_base[group];
+		upper = pwr_idx_5g->bw40_base[group + 1];
+
+		tx_power = (lower + upper) / 2;
+		tx_power += pwr_idx_5g->vht_1s_diff.bw80 * factor;
+		if (above_2ss)
+			tx_power += pwr_idx_5g->vht_2s_diff.bw80 * factor;
 		break;
 	}
+
+	return tx_power;
+}
+
+static s8 get_tx_power_limit(struct rtw_hal *hal, u8 bw, u8 rs, u8 ch, u8 regd)
+{
+	if (regd > RTW_REGD_WW)
+		return RTW_MAX_POWER_INDEX;
+
+	return hal->tx_pwr_limit_2g[regd][bw][rs][ch];
+}
+
+static s8 phy_get_tx_power_limit(struct rtw_dev *rtwdev, u8 band,
+				 enum rtw_bandwidth bw, u8 rf_path,
+				 u8 rate, u8 channel, u8 regd)
+{
+	struct rtw_hal *hal = &rtwdev->hal;
+	s8 power_limit;
+	u8 rs;
+	int ch_idx;
+
+	if (rate >= DESC_RATE1M && rate <= DESC_RATE11M)
+		rs = RTW_RATE_SECTION_CCK;
+	else if (rate >= DESC_RATE6M && rate <= DESC_RATE54M)
+		rs = RTW_RATE_SECTION_OFDM;
+	else if (rate >= DESC_RATEMCS0 && rate <= DESC_RATEMCS7)
+		rs = RTW_RATE_SECTION_HT_1S;
+	else if (rate >= DESC_RATEMCS8 && rate <= DESC_RATEMCS15)
+		rs = RTW_RATE_SECTION_HT_2S;
+	else if (rate >= DESC_RATEVHT1SS_MCS0 && rate <= DESC_RATEVHT1SS_MCS9)
+		rs = RTW_RATE_SECTION_VHT_1S;
+	else if (rate >= DESC_RATEVHT2SS_MCS0 && rate <= DESC_RATEVHT2SS_MCS9)
+		rs = RTW_RATE_SECTION_VHT_2S;
+	else
+		goto err;
+
+	ch_idx = rtw_channel_to_idx(band, channel);
+	if (ch_idx < 0)
+		goto err;
+
+	power_limit = get_tx_power_limit(hal, bw, rs, ch_idx, regd);
+
+	return power_limit;
+
+err:
+	WARN(1, "invalid arguments, band=%d, bw=%d, path=%d, rate=%d, ch=%d\n",
+	     band, bw, rf_path, rate, channel);
+	return RTW_MAX_POWER_INDEX;
+}
+
+static
+u8 phy_get_tx_power_index(void *adapter, u8 rf_path, u8 rate,
+			  enum rtw_bandwidth bandwidth, u8 channel, u8 regd)
+{
+	struct rtw_dev *rtwdev = adapter;
+	struct rtw_hal *hal = &rtwdev->hal;
+	struct rtw_txpwr_idx *pwr_idx;
+	u8 tx_power;
+	u8 group;
+	u8 band;
+	s8 offset, limit;
+
+	pwr_idx = &rtwdev->efuse.txpwr_idx_table[rf_path];
+	group = rtw_get_channel_group(channel);
+
+	/* base power index for 2.4G/5G */
+	if (channel <= 14) {
+		band = PHY_BAND_2G;
+		tx_power = phy_get_2g_tx_power_index(rtwdev,
+						     &pwr_idx->pwr_idx_2g,
+						     bandwidth, rate, group);
+		offset = hal->tx_pwr_by_rate_offset_2g[rf_path][rate];
+	} else {
+		band = PHY_BAND_5G;
+		tx_power = phy_get_5g_tx_power_index(rtwdev,
+						     &pwr_idx->pwr_idx_5g,
+						     bandwidth, rate, group);
+		offset = hal->tx_pwr_by_rate_offset_5g[rf_path][rate];
+	}
+
+	limit = phy_get_tx_power_limit(rtwdev, band, bandwidth, rf_path,
+				       rate, channel, regd);
+
+	if (offset > limit)
+		offset = limit;
+
+	tx_power += offset;
+
+	if (tx_power > rtwdev->chip->max_power_index)
+		tx_power = rtwdev->chip->max_power_index;
+
+	return tx_power;
 }
 
-void phy_store_tx_power_by_rate(void *adapter, u32 band, u32 rfpath, u32 txnum,
-				u32 regaddr, u32 bitmask, u32 data)
+static void phy_set_tx_power_index_by_rs(void *adapter, u8 ch, u8 path, u8 rs)
 {
 	struct rtw_dev *rtwdev = adapter;
 	struct rtw_hal *hal = &rtwdev->hal;
-	u8 rate_num = 0;
+	u8 regd = rtwdev->regd.txpwr_regd;
+	u8 *rates;
+	u8 size;
 	u8 rate;
-	u8 rates[RTW_RF_PATH_MAX] = {0};
-	s8 offset;
-	s8 pwr_by_rate[RTW_RF_PATH_MAX] = {0};
+	u8 pwr_idx;
+	u8 bw;
 	int i;
 
-	phy_get_rate_values_of_txpwr_by_rate(rtwdev, regaddr, bitmask, data,
-					     rates, pwr_by_rate, &rate_num);
-
-	if (WARN_ON(rfpath >= RTW_RF_PATH_MAX ||
-		    (band != PHY_BAND_2G && band != PHY_BAND_5G) ||
-		    rate_num > RTW_RF_PATH_MAX))
+	if (rs >= RTW_RATE_SECTION_MAX)
 		return;
 
-	for (i = 0; i < rate_num; i++) {
-		offset = pwr_by_rate[i];
+	rates = rtw_rate_section[rs];
+	size = rtw_rate_size[rs];
+	bw = hal->current_band_width;
+	for (i = 0; i < size; i++) {
 		rate = rates[i];
-		if (band == PHY_BAND_2G)
-			hal->tx_pwr_by_rate_offset_2g[rfpath][rate] = offset;
-		else if (band == PHY_BAND_5G)
-			hal->tx_pwr_by_rate_offset_5g[rfpath][rate] = offset;
-		else
-			continue;
+		pwr_idx = phy_get_tx_power_index(adapter, path, rate, bw, ch,
+						 regd);
+		hal->tx_pwr_tbl[path][rate] = pwr_idx;
 	}
 }
 
+/* set tx power level by path for each rates, note that the order of the rates
+ * are *very* important, bacause 8822B/8821C combines every four bytes of tx
+ * power index into a four-byte power index register, and calls set_tx_agc to
+ * write these values into hardware
+ */
+static
+void phy_set_tx_power_level_by_path(struct rtw_dev *rtwdev, u8 ch, u8 path)
+{
+	struct rtw_hal *hal = &rtwdev->hal;
+	u8 rs;
+
+	/* do not need cck rates if we are not in 2.4G */
+	if (hal->current_band_type == RTW_BAND_2G)
+		rs = RTW_RATE_SECTION_CCK;
+	else
+		rs = RTW_RATE_SECTION_OFDM;
+
+	for (; rs < RTW_RATE_SECTION_MAX; rs++)
+		phy_set_tx_power_index_by_rs(rtwdev, ch, path, rs);
+}
+
+void rtw_phy_set_tx_power_level(struct rtw_dev *rtwdev, u8 channel)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_hal *hal = &rtwdev->hal;
+	u8 path;
+
+	mutex_lock(&hal->tx_power_mutex);
+
+	for (path = 0; path < hal->rf_path_num; path++)
+		phy_set_tx_power_level_by_path(rtwdev, channel, path);
+
+	chip->ops->set_tx_power_index(rtwdev);
+	mutex_unlock(&hal->tx_power_mutex);
+}
+
 static
 void phy_tx_power_by_rate_config_by_path(struct rtw_hal *hal, u8 path,
 					 u8 rs, u8 size, u8 *rates)
@@ -1629,76 +1692,6 @@ void rtw_phy_tx_power_limit_config(struct rtw_hal *hal)
 				phy_tx_power_limit_config(hal, regd, bw, rs);
 }
 
-static s8 get_tx_power_limit(struct rtw_hal *hal, u8 bw, u8 rs, u8 ch, u8 regd)
-{
-	if (regd > RTW_REGD_WW)
-		return RTW_MAX_POWER_INDEX;
-
-	return hal->tx_pwr_limit_2g[regd][bw][rs][ch];
-}
-
-s8 phy_get_tx_power_limit(struct rtw_dev *rtwdev, u8 band,
-			  enum rtw_bandwidth bw, u8 rf_path,
-			  u8 rate, u8 channel, u8 regd)
-{
-	struct rtw_hal *hal = &rtwdev->hal;
-	s8 power_limit;
-	u8 rs;
-	int ch_idx;
-
-	if (rate >= DESC_RATE1M && rate <= DESC_RATE11M)
-		rs = RTW_RATE_SECTION_CCK;
-	else if (rate >= DESC_RATE6M && rate <= DESC_RATE54M)
-		rs = RTW_RATE_SECTION_OFDM;
-	else if (rate >= DESC_RATEMCS0 && rate <= DESC_RATEMCS7)
-		rs = RTW_RATE_SECTION_HT_1S;
-	else if (rate >= DESC_RATEMCS8 && rate <= DESC_RATEMCS15)
-		rs = RTW_RATE_SECTION_HT_2S;
-	else if (rate >= DESC_RATEVHT1SS_MCS0 && rate <= DESC_RATEVHT1SS_MCS9)
-		rs = RTW_RATE_SECTION_VHT_1S;
-	else if (rate >= DESC_RATEVHT2SS_MCS0 && rate <= DESC_RATEVHT2SS_MCS9)
-		rs = RTW_RATE_SECTION_VHT_2S;
-	else
-		goto err;
-
-	ch_idx = rtw_channel_to_idx(band, channel);
-	if (ch_idx < 0)
-		goto err;
-
-	power_limit = get_tx_power_limit(hal, bw, rs, ch_idx, regd);
-
-	return power_limit;
-
-err:
-	WARN(1, "invalid arguments, band=%d, bw=%d, path=%d, rate=%d, ch=%d\n",
-	     band, bw, rf_path, rate, channel);
-	return RTW_MAX_POWER_INDEX;
-}
-
-void phy_set_tx_power_limit(struct rtw_dev *rtwdev, u8 regd, u8 band,
-			    u8 bw, u8 rs, u8 ch, s8 pwr_limit)
-{
-	struct rtw_hal *hal = &rtwdev->hal;
-	int ch_idx;
-
-	pwr_limit = clamp_t(s8, pwr_limit,
-			    -RTW_MAX_POWER_INDEX, RTW_MAX_POWER_INDEX);
-	ch_idx = rtw_channel_to_idx(band, ch);
-
-	if (regd >= RTW_REGD_MAX || bw >= RTW_CHANNEL_WIDTH_MAX ||
-	    rs >= RTW_RATE_SECTION_MAX || ch_idx < 0) {
-		WARN(1,
-		     "wrong txpwr_lmt regd=%u, band=%u bw=%u, rs=%u, ch_idx=%u, pwr_limit=%d\n",
-		     regd, band, bw, rs, ch_idx, pwr_limit);
-		return;
-	}
-
-	if (band == PHY_BAND_2G)
-		hal->tx_pwr_limit_2g[regd][bw][rs][ch_idx] = pwr_limit;
-	else if (band == PHY_BAND_5G)
-		hal->tx_pwr_limit_5g[regd][bw][rs][ch_idx] = pwr_limit;
-}
-
 static
 void rtw_hw_tx_power_limit_init(struct rtw_hal *hal, u8 regd, u8 bw, u8 rs)
 {
diff --git a/drivers/net/wireless/realtek/rtw88/phy.h b/drivers/net/wireless/realtek/rtw88/phy.h
index ec03a20..7ad64e7 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.h
+++ b/drivers/net/wireless/realtek/rtw88/phy.h
@@ -7,6 +7,8 @@
 
 #include "debug.h"
 
+#define RTW_MAX_POWER_INDEX		0x7F
+
 extern u8 rtw_cck_rates[];
 extern u8 rtw_ofdm_rates[];
 extern u8 rtw_ht_1s_rates[];
@@ -27,11 +29,6 @@ bool rtw_phy_write_rf_reg(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
 			  u32 addr, u32 mask, u32 data);
 bool rtw_phy_write_rf_reg_mix(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
 			      u32 addr, u32 mask, u32 data);
-void phy_store_tx_power_by_rate(void *adapter, u32 band, u32 rfpath, u32 txnum,
-				u32 regaddr, u32 bitmask, u32 data);
-void phy_set_tx_power_limit(struct rtw_dev *rtwdev, u8 regd, u8 band,
-			    u8 bw, u8 rs, u8 ch, s8 pwr_limit);
-void phy_set_tx_power_index_by_rs(void *adapter, u8 ch, u8 path, u8 rs);
 void rtw_phy_setup_phy_cond(struct rtw_dev *rtwdev, u32 pkg);
 void rtw_parse_tbl_phy_cond(struct rtw_dev *rtwdev, const struct rtw_table *tbl);
 void rtw_parse_tbl_bb_pg(struct rtw_dev *rtwdev, const struct rtw_table *tbl);
-- 
2.7.4

