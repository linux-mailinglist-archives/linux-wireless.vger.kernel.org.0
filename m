Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFEA1C80CE
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2020 06:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgEGEWV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 May 2020 00:22:21 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:34097 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgEGEWU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 May 2020 00:22:20 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 0474Lv502027277, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 0474Lv502027277
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 7 May 2020 12:21:57 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 7 May 2020 12:21:57 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 7 May 2020 12:21:56 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <bigeasy@linutronix.de>
Subject: [PATCH v2 3/9] rtw88: 8723d: Add power tracking
Date:   Thu, 7 May 2020 12:21:45 +0800
Message-ID: <20200507042151.15634-4-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507042151.15634-1-yhchuang@realtek.com>
References: <20200507042151.15634-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

When chip's temperature is changed, RF characters are changed. To keep the
characters to be consistent, 8723d uses thermal meter to assist in
calibrating LCK, IQK, crystal and TX power.

A base thermal value is programmed in efuse, all calibration data in
MP process is based on this thermal value. So we calucate the delta of
thermal value between the base value, and use this delta to reference XTAL
and TX power offset tables to know how much we need to adjust.

For IQK and LCK, driver checks if delta of thermal value is over 8, then
they are triggered.

For crystal adjustment, when delta of thermal value is changed, we check
XTAL tables to get offset of XTAL value. If thermal value is larger than
base value, positive table (_p as suffix) is used. Otherwise, we use
negative table (_n as suffix). Then, we add offset to XTAL default value
programmed in efuse, and write sum value to register.

To compensate TX power, there are two hierarchical tables. First level use
delta of thermal value to access eight tables to yield delta of TX power
index. Then, plus base TX power index to get index of BB swing table
(second level tables) where register value is induced.

BB swing table can't deal with all cases, if index of BB swing table is
over the size of the table. In this case, TX AGC is used to compensate the
remnant part. Assume 'upper' is the upper bound of BB swing table, and
'target' is the desired index. Then, we can illustrate them as

  compensation method    BB swing        TX AGC
  -------------------    --------    --------------
  target > upper         upper       target - upper
  target < 0             0           target
  otherwise              target      0

For debug purpose, add a column 'rem' to tx_pwr_tbl entry, and it looks
like

  path rate       pwr       base      (byr  lmt ) rem
    A  CCK_1M     32(0x20)   34   -2 (   0   -2)    0

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/debug.c    |   9 +-
 drivers/net/wireless/realtek/rtw88/main.h     |   4 +
 drivers/net/wireless/realtek/rtw88/phy.c      |   6 +-
 drivers/net/wireless/realtek/rtw88/phy.h      |   1 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 400 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.h |   7 +
 6 files changed, 422 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index b4964306de61..09f04feb8fe1 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -531,8 +531,8 @@ static int rtw_debugfs_get_tx_pwr_tbl(struct seq_file *m, void *v)
 	u8 ch = hal->current_channel;
 	u8 regd = rtwdev->regd.txpwr_regd;
 
-	seq_printf(m, "%-4s %-10s %-3s%6s %-4s %4s (%-4s %-4s)\n",
-		   "path", "rate", "pwr", "", "base", "", "byr", "lmt");
+	seq_printf(m, "%-4s %-10s %-3s%6s %-4s %4s (%-4s %-4s) %-4s\n",
+		   "path", "rate", "pwr", "", "base", "", "byr", "lmt", "rem");
 
 	mutex_lock(&hal->tx_power_mutex);
 	for (path = RF_PATH_A; path <= RF_PATH_B; path++) {
@@ -554,13 +554,14 @@ static int rtw_debugfs_get_tx_pwr_tbl(struct seq_file *m, void *v)
 
 			seq_printf(m, "%4c ", path + 'A');
 			rtw_print_rate(m, rate);
-			seq_printf(m, " %3u(0x%02x) %4u %4d (%4d %4d)\n",
+			seq_printf(m, " %3u(0x%02x) %4u %4d (%4d %4d) %4d\n",
 				   hal->tx_pwr_tbl[path][rate],
 				   hal->tx_pwr_tbl[path][rate],
 				   pwr_param.pwr_base,
 				   min_t(s8, pwr_param.pwr_offset,
 					 pwr_param.pwr_limit),
-				   pwr_param.pwr_offset, pwr_param.pwr_limit);
+				   pwr_param.pwr_offset, pwr_param.pwr_limit,
+				   pwr_param.pwr_remnant);
 		}
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index af8c50e3687d..bfdc27c187f6 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1056,6 +1056,8 @@ struct rtw_pwr_track_tbl {
 	const u8 *pwrtrk_2g_cckb_p;
 	const u8 *pwrtrk_2g_ccka_n;
 	const u8 *pwrtrk_2g_ccka_p;
+	const s8 *pwrtrk_xtal_n;
+	const s8 *pwrtrk_xtal_p;
 };
 
 enum rtw_wlan_cpu {
@@ -1447,6 +1449,8 @@ struct rtw_dm_info {
 	bool pwr_trk_triggered;
 	bool pwr_trk_init_trigger;
 	struct ewma_thermal avg_thermal[RTW_RF_PATH_MAX];
+	s8 txagc_remnant_cck;
+	s8 txagc_remnant_ofdm;
 
 	/* backup dack results for each path and I/Q */
 	u32 dack_adck[RTW_RF_PATH_MAX];
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 837b7bd04126..45181f602e3f 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -1785,11 +1785,13 @@ void rtw_get_tx_power_params(struct rtw_dev *rtwdev, u8 path, u8 rate, u8 bw,
 			     u8 ch, u8 regd, struct rtw_power_params *pwr_param)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
 	struct rtw_txpwr_idx *pwr_idx;
 	u8 group, band;
 	u8 *base = &pwr_param->pwr_base;
 	s8 *offset = &pwr_param->pwr_offset;
 	s8 *limit = &pwr_param->pwr_limit;
+	s8 *remnant = &pwr_param->pwr_remnant;
 
 	pwr_idx = &rtwdev->efuse.txpwr_idx_table[path];
 	group = rtw_get_channel_group(ch);
@@ -1811,6 +1813,8 @@ void rtw_get_tx_power_params(struct rtw_dev *rtwdev, u8 path, u8 rate, u8 bw,
 
 	*limit = rtw_phy_get_tx_power_limit(rtwdev, band, bw, path,
 					    rate, ch, regd);
+	*remnant = (rate <= DESC_RATE11M ? dm_info->txagc_remnant_cck :
+		    dm_info->txagc_remnant_ofdm);
 }
 
 u8
@@ -1830,7 +1834,7 @@ rtw_phy_get_tx_power_index(struct rtw_dev *rtwdev, u8 rf_path, u8 rate,
 	if (rtwdev->chip->en_dis_dpd)
 		offset += rtw_phy_get_dis_dpd_by_rate_diff(rtwdev, rate);
 
-	tx_power += offset;
+	tx_power += offset + pwr_param.pwr_remnant;
 
 	if (tx_power > rtwdev->chip->max_power_index)
 		tx_power = rtwdev->chip->max_power_index;
diff --git a/drivers/net/wireless/realtek/rtw88/phy.h b/drivers/net/wireless/realtek/rtw88/phy.h
index 413bf7165cc0..b924ed07630a 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.h
+++ b/drivers/net/wireless/realtek/rtw88/phy.h
@@ -141,6 +141,7 @@ struct rtw_power_params {
 	u8 pwr_base;
 	s8 pwr_offset;
 	s8 pwr_limit;
+	s8 pwr_remnant;
 };
 
 void
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 0cfa493e7742..4fc2d0bb2704 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -92,6 +92,46 @@ static void rtw8723d_lck(struct rtw_dev *rtwdev)
 		rtw_write8(rtwdev, REG_TXPAUSE, 0x00);
 }
 
+static const u32 rtw8723d_ofdm_swing_table[] = {
+	0x0b40002d, 0x0c000030, 0x0cc00033, 0x0d800036, 0x0e400039, 0x0f00003c,
+	0x10000040, 0x11000044, 0x12000048, 0x1300004c, 0x14400051, 0x15800056,
+	0x16c0005b, 0x18000060, 0x19800066, 0x1b00006c, 0x1c800072, 0x1e400079,
+	0x20000080, 0x22000088, 0x24000090, 0x26000098, 0x288000a2, 0x2ac000ab,
+	0x2d4000b5, 0x300000c0, 0x32c000cb, 0x35c000d7, 0x390000e4, 0x3c8000f2,
+	0x40000100, 0x43c0010f, 0x47c0011f, 0x4c000130, 0x50800142, 0x55400155,
+	0x5a400169, 0x5fc0017f, 0x65400195, 0x6b8001ae, 0x71c001c7, 0x788001e2,
+	0x7f8001fe,
+};
+
+static const u32 rtw8723d_cck_swing_table[] = {
+	0x0CD, 0x0D9, 0x0E6, 0x0F3, 0x102, 0x111, 0x121, 0x132, 0x144, 0x158,
+	0x16C, 0x182, 0x198, 0x1B1, 0x1CA, 0x1E5, 0x202, 0x221, 0x241, 0x263,
+	0x287, 0x2AE, 0x2D6, 0x301, 0x32F, 0x35F, 0x392, 0x3C9, 0x402, 0x43F,
+	0x47F, 0x4C3, 0x50C, 0x558, 0x5A9, 0x5FF, 0x65A, 0x6BA, 0x720, 0x78C,
+	0x7FF,
+};
+
+#define RTW_OFDM_SWING_TABLE_SIZE	ARRAY_SIZE(rtw8723d_ofdm_swing_table)
+#define RTW_CCK_SWING_TABLE_SIZE	ARRAY_SIZE(rtw8723d_cck_swing_table)
+
+static void rtw8723d_pwrtrack_init(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u8 path;
+
+	dm_info->default_ofdm_index = RTW_DEF_OFDM_SWING_INDEX;
+
+	for (path = RF_PATH_A; path < rtwdev->hal.rf_path_num; path++) {
+		ewma_thermal_init(&dm_info->avg_thermal[path]);
+		dm_info->delta_power_index[path] = 0;
+	}
+	dm_info->pwr_trk_triggered = false;
+	dm_info->pwr_trk_init_trigger = true;
+	dm_info->thermal_meter_k = rtwdev->efuse.thermal_meter_k;
+	dm_info->txagc_remnant_cck = 0;
+	dm_info->txagc_remnant_ofdm = 0;
+}
+
 static void rtw8723d_phy_set_param(struct rtw_dev *rtwdev)
 {
 	u8 xtal_cap;
@@ -158,6 +198,8 @@ static void rtw8723d_phy_set_param(struct rtw_dev *rtwdev)
 
 	rtw_write32_mask(rtwdev, REG_OFDM0_XAAGC1, MASKBYTE0, 0x50);
 	rtw_write32_mask(rtwdev, REG_OFDM0_XAAGC1, MASKBYTE0, 0x20);
+
+	rtw8723d_pwrtrack_init(rtwdev);
 }
 
 static void rtw8723de_efuse_parsing(struct rtw_efuse *efuse,
@@ -1450,6 +1492,298 @@ static void rtw8723d_phy_calibration(struct rtw_dev *rtwdev)
 	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] finished\n");
 }
 
+static u8 rtw8723d_pwrtrack_get_limit_ofdm(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u8 tx_rate = dm_info->tx_rate;
+	u8 limit_ofdm = 30;
+
+	switch (tx_rate) {
+	case DESC_RATE1M...DESC_RATE5_5M:
+	case DESC_RATE11M:
+		break;
+	case DESC_RATE6M...DESC_RATE48M:
+		limit_ofdm = 36;
+		break;
+	case DESC_RATE54M:
+		limit_ofdm = 34;
+		break;
+	case DESC_RATEMCS0...DESC_RATEMCS2:
+		limit_ofdm = 38;
+		break;
+	case DESC_RATEMCS3...DESC_RATEMCS4:
+		limit_ofdm = 36;
+		break;
+	case DESC_RATEMCS5...DESC_RATEMCS7:
+		limit_ofdm = 34;
+		break;
+	default:
+		rtw_warn(rtwdev, "pwrtrack unhandled tx_rate 0x%x\n", tx_rate);
+		break;
+	}
+
+	return limit_ofdm;
+}
+
+static void rtw8723d_set_iqk_matrix_by_result(struct rtw_dev *rtwdev,
+					      u32 ofdm_swing, u8 rf_path)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	s32 ele_A, ele_D, ele_C;
+	s32 ele_A_ext, ele_C_ext, ele_D_ext;
+	s32 iqk_result_x;
+	s32 iqk_result_y;
+	s32 value32;
+
+	switch (rf_path) {
+	default:
+	case RF_PATH_A:
+		iqk_result_x = dm_info->iqk.result.s1_x;
+		iqk_result_y = dm_info->iqk.result.s1_y;
+		break;
+	case RF_PATH_B:
+		iqk_result_x = dm_info->iqk.result.s0_x;
+		iqk_result_y = dm_info->iqk.result.s0_y;
+		break;
+	}
+
+	/* new element D */
+	ele_D = OFDM_SWING_D(ofdm_swing);
+	iqk_mult(iqk_result_x, ele_D, &ele_D_ext);
+	/* new element A */
+	iqk_result_x = iqkxy_to_s32(iqk_result_x);
+	ele_A = iqk_mult(iqk_result_x, ele_D, &ele_A_ext);
+	/* new element C */
+	iqk_result_y = iqkxy_to_s32(iqk_result_y);
+	ele_C = iqk_mult(iqk_result_y, ele_D, &ele_C_ext);
+
+	switch (rf_path) {
+	case RF_PATH_A:
+	default:
+		/* write new elements A, C, D, and element B is always 0 */
+		value32 = BIT_SET_TXIQ_ELM_ACD(ele_A, ele_C, ele_D);
+		rtw_write32(rtwdev, REG_OFDM_0_XA_TX_IQ_IMBALANCE, value32);
+		value32 = BIT_SET_TXIQ_ELM_C1(ele_C);
+		rtw_write32_mask(rtwdev, REG_TXIQK_MATRIXA_LSB2_11N, MASKH4BITS,
+				 value32);
+		value32 = rtw_read32(rtwdev, REG_OFDM_0_ECCA_THRESHOLD);
+		value32 &= ~BIT_MASK_OFDM0_EXTS;
+		value32 |= BIT_SET_OFDM0_EXTS(ele_A_ext, ele_C_ext, ele_D_ext);
+		rtw_write32(rtwdev, REG_OFDM_0_ECCA_THRESHOLD, value32);
+		break;
+
+	case RF_PATH_B:
+		/* write new elements A, C, D, and element B is always 0 */
+		rtw_write32_mask(rtwdev, REG_TXIQ_CD_S0, BIT_MASK_TXIQ_D_S0, ele_D);
+		rtw_write32_mask(rtwdev, REG_TXIQ_CD_S0, BIT_MASK_TXIQ_C_S0, ele_C);
+		rtw_write32_mask(rtwdev, REG_TXIQ_AB_S0, BIT_MASK_TXIQ_A_S0, ele_A);
+
+		rtw_write32_mask(rtwdev, REG_TXIQ_CD_S0, BIT_MASK_TXIQ_D_EXT_S0,
+				 ele_D_ext);
+		rtw_write32_mask(rtwdev, REG_TXIQ_AB_S0, BIT_MASK_TXIQ_A_EXT_S0,
+				 ele_A_ext);
+		rtw_write32_mask(rtwdev, REG_TXIQ_CD_S0, BIT_MASK_TXIQ_C_EXT_S0,
+				 ele_C_ext);
+		break;
+	}
+}
+
+static void rtw8723d_set_iqk_matrix(struct rtw_dev *rtwdev, s8 ofdm_index,
+				    u8 rf_path)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	s32 value32;
+	u32 ofdm_swing;
+
+	if (ofdm_index >= RTW_OFDM_SWING_TABLE_SIZE)
+		ofdm_index = RTW_OFDM_SWING_TABLE_SIZE - 1;
+	else if (ofdm_index < 0)
+		ofdm_index = 0;
+
+	ofdm_swing = rtw8723d_ofdm_swing_table[ofdm_index];
+
+	if (dm_info->iqk.done) {
+		rtw8723d_set_iqk_matrix_by_result(rtwdev, ofdm_swing, rf_path);
+		return;
+	}
+
+	switch (rf_path) {
+	case RF_PATH_A:
+	default:
+		rtw_write32(rtwdev, REG_OFDM_0_XA_TX_IQ_IMBALANCE, ofdm_swing);
+		rtw_write32_mask(rtwdev, REG_TXIQK_MATRIXA_LSB2_11N, MASKH4BITS,
+				 0x00);
+		value32 = rtw_read32(rtwdev, REG_OFDM_0_ECCA_THRESHOLD);
+		value32 &= ~BIT_MASK_OFDM0_EXTS;
+		rtw_write32(rtwdev, REG_OFDM_0_ECCA_THRESHOLD, value32);
+		break;
+
+	case RF_PATH_B:
+		/* image S1:c80 to S0:Cd0 and Cd4 */
+		rtw_write32_mask(rtwdev, REG_TXIQ_AB_S0, BIT_MASK_TXIQ_A_S0,
+				 OFDM_SWING_A(ofdm_swing));
+		rtw_write32_mask(rtwdev, REG_TXIQ_AB_S0, BIT_MASK_TXIQ_B_S0,
+				 OFDM_SWING_B(ofdm_swing));
+		rtw_write32_mask(rtwdev, REG_TXIQ_CD_S0, BIT_MASK_TXIQ_C_S0,
+				 OFDM_SWING_C(ofdm_swing));
+		rtw_write32_mask(rtwdev, REG_TXIQ_CD_S0, BIT_MASK_TXIQ_D_S0,
+				 OFDM_SWING_D(ofdm_swing));
+		rtw_write32_mask(rtwdev, REG_TXIQ_CD_S0, BIT_MASK_TXIQ_D_EXT_S0, 0x0);
+		rtw_write32_mask(rtwdev, REG_TXIQ_CD_S0, BIT_MASK_TXIQ_C_EXT_S0, 0x0);
+		rtw_write32_mask(rtwdev, REG_TXIQ_AB_S0, BIT_MASK_TXIQ_A_EXT_S0, 0x0);
+		break;
+	}
+}
+
+static void rtw8723d_pwrtrack_set_ofdm_pwr(struct rtw_dev *rtwdev, s8 swing_idx,
+					   s8 txagc_idx)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+
+	dm_info->txagc_remnant_ofdm = txagc_idx;
+
+	rtw8723d_set_iqk_matrix(rtwdev, swing_idx, RF_PATH_A);
+	rtw8723d_set_iqk_matrix(rtwdev, swing_idx, RF_PATH_B);
+}
+
+static void rtw8723d_pwrtrack_set_cck_pwr(struct rtw_dev *rtwdev, s8 swing_idx,
+					  s8 txagc_idx)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+
+	dm_info->txagc_remnant_cck = txagc_idx;
+
+	rtw_write32_mask(rtwdev, 0xab4, 0x000007FF,
+			 rtw8723d_cck_swing_table[swing_idx]);
+}
+
+static void rtw8723d_pwrtrack_set(struct rtw_dev *rtwdev, u8 path)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	struct rtw_hal *hal = &rtwdev->hal;
+	u8 limit_ofdm;
+	u8 limit_cck = 40;
+	s8 final_ofdm_swing_index;
+	s8 final_cck_swing_index;
+
+	limit_ofdm = rtw8723d_pwrtrack_get_limit_ofdm(rtwdev);
+
+	final_ofdm_swing_index = RTW_DEF_OFDM_SWING_INDEX +
+				 dm_info->delta_power_index[path];
+	final_cck_swing_index = RTW_DEF_CCK_SWING_INDEX +
+				dm_info->delta_power_index[path];
+
+	if (final_ofdm_swing_index > limit_ofdm)
+		rtw8723d_pwrtrack_set_ofdm_pwr(rtwdev, limit_ofdm,
+					       final_ofdm_swing_index - limit_ofdm);
+	else if (final_ofdm_swing_index < 0)
+		rtw8723d_pwrtrack_set_ofdm_pwr(rtwdev, 0,
+					       final_ofdm_swing_index);
+	else
+		rtw8723d_pwrtrack_set_ofdm_pwr(rtwdev, final_ofdm_swing_index, 0);
+
+	if (final_cck_swing_index > limit_cck)
+		rtw8723d_pwrtrack_set_cck_pwr(rtwdev, limit_cck,
+					      final_cck_swing_index - limit_cck);
+	else if (final_cck_swing_index < 0)
+		rtw8723d_pwrtrack_set_cck_pwr(rtwdev, 0,
+					      final_cck_swing_index);
+	else
+		rtw8723d_pwrtrack_set_cck_pwr(rtwdev, final_cck_swing_index, 0);
+
+	rtw_phy_set_tx_power_level(rtwdev, hal->current_channel);
+}
+
+static void rtw8723d_pwrtrack_set_xtal(struct rtw_dev *rtwdev, u8 therm_path,
+				       u8 delta)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	const struct rtw_pwr_track_tbl *tbl = rtwdev->chip->pwr_track_tbl;
+	const s8 *pwrtrk_xtal;
+	s8 xtal_cap;
+
+	if (dm_info->thermal_avg[therm_path] >
+	    rtwdev->efuse.thermal_meter[therm_path])
+		pwrtrk_xtal = tbl->pwrtrk_xtal_p;
+	else
+		pwrtrk_xtal = tbl->pwrtrk_xtal_n;
+
+	xtal_cap = rtwdev->efuse.crystal_cap & 0x3F;
+	xtal_cap = clamp_t(s8, xtal_cap + pwrtrk_xtal[delta], 0, 0x3F);
+	rtw_write32_mask(rtwdev, REG_AFE_CTRL3, BIT_MASK_XTAL,
+			 xtal_cap | (xtal_cap << 6));
+}
+
+static void rtw8723d_phy_pwrtrack(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	struct rtw_swing_table swing_table;
+	u8 thermal_value, delta, path;
+	bool do_iqk = false;
+
+	rtw_phy_config_swing_table(rtwdev, &swing_table);
+
+	if (rtwdev->efuse.thermal_meter[0] == 0xff)
+		return;
+
+	thermal_value = rtw_read_rf(rtwdev, RF_PATH_A, RF_T_METER, 0xfc00);
+
+	rtw_phy_pwrtrack_avg(rtwdev, thermal_value, RF_PATH_A);
+
+	do_iqk = rtw_phy_pwrtrack_need_iqk(rtwdev);
+
+	if (do_iqk)
+		rtw8723d_lck(rtwdev);
+
+	if (dm_info->pwr_trk_init_trigger)
+		dm_info->pwr_trk_init_trigger = false;
+	else if (!rtw_phy_pwrtrack_thermal_changed(rtwdev, thermal_value,
+						   RF_PATH_A))
+		goto iqk;
+
+	delta = rtw_phy_pwrtrack_get_delta(rtwdev, RF_PATH_A);
+
+	delta = min_t(u8, delta, RTW_PWR_TRK_TBL_SZ - 1);
+
+	for (path = 0; path < rtwdev->hal.rf_path_num; path++) {
+		s8 delta_cur, delta_last;
+
+		delta_last = dm_info->delta_power_index[path];
+		delta_cur = rtw_phy_pwrtrack_get_pwridx(rtwdev, &swing_table,
+							path, RF_PATH_A, delta);
+		if (delta_last == delta_cur)
+			continue;
+
+		dm_info->delta_power_index[path] = delta_cur;
+		rtw8723d_pwrtrack_set(rtwdev, path);
+	}
+
+	rtw8723d_pwrtrack_set_xtal(rtwdev, RF_PATH_A, delta);
+
+iqk:
+	if (do_iqk)
+		rtw8723d_phy_calibration(rtwdev);
+}
+
+void rtw8723d_pwr_track(struct rtw_dev *rtwdev)
+{
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+
+	if (efuse->power_track_type != 0)
+		return;
+
+	if (!dm_info->pwr_trk_triggered) {
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_T_METER,
+			     GENMASK(17, 16), 0x03);
+		dm_info->pwr_trk_triggered = true;
+		return;
+	}
+
+	rtw8723d_phy_pwrtrack(rtwdev);
+	dm_info->pwr_trk_triggered = false;
+}
+
 static struct rtw_chip_ops rtw8723d_ops = {
 	.phy_set_param		= rtw8723d_phy_set_param,
 	.read_efuse		= rtw8723d_read_efuse,
@@ -1464,6 +1798,7 @@ static struct rtw_chip_ops rtw8723d_ops = {
 	.efuse_grant		= rtw8723d_efuse_grant,
 	.false_alarm_statistics	= rtw8723d_false_alarm_statistics,
 	.phy_calibration	= rtw8723d_phy_calibration,
+	.pwr_track		= rtw8723d_pwr_track,
 	.config_bfee		= NULL,
 	.set_gid_table		= NULL,
 	.cfg_csi_rate		= NULL,
@@ -1937,6 +2272,69 @@ static const struct rtw_rfe_def rtw8723d_rfe_defs[] = {
 		.txpwr_lmt_tbl	= &rtw8723d_txpwr_lmt_tbl,},
 };
 
+static const u8 rtw8723d_pwrtrk_2gb_n[] = {
+	0, 0, 1, 1, 1, 2, 2, 3, 4, 4, 4, 4, 5, 5, 5,
+	6, 6, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10, 10, 10
+};
+
+static const u8 rtw8723d_pwrtrk_2gb_p[] = {
+	0, 0, 1, 1, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7,
+	7, 8, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10
+};
+
+static const u8 rtw8723d_pwrtrk_2ga_n[] = {
+	0, 0, 1, 1, 1, 2, 2, 3, 4, 4, 4, 4, 5, 5, 5,
+	6, 6, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10, 10, 10
+};
+
+static const u8 rtw8723d_pwrtrk_2ga_p[] = {
+	0, 0, 1, 1, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7,
+	7, 8, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10
+};
+
+static const u8 rtw8723d_pwrtrk_2g_cck_b_n[] = {
+	0, 1, 1, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6,
+	6, 7, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 11, 11, 11
+};
+
+static const u8 rtw8723d_pwrtrk_2g_cck_b_p[] = {
+	0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7,
+	7, 8, 9, 9, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11
+};
+
+static const u8 rtw8723d_pwrtrk_2g_cck_a_n[] = {
+	0, 1, 1, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6,
+	6, 7, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 11, 11, 11
+};
+
+static const u8 rtw8723d_pwrtrk_2g_cck_a_p[] = {
+	0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7,
+	7, 8, 9, 9, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11
+};
+
+static const s8 rtw8723d_pwrtrk_xtal_n[] = {
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
+};
+
+static const s8 rtw8723d_pwrtrk_xtal_p[] = {
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, -10, -12, -14, -16, -16, -16, -16, -16, -16, -16, -16, -16, -16, -16
+};
+
+static const struct rtw_pwr_track_tbl rtw8723d_rtw_pwr_track_tbl = {
+	.pwrtrk_2gb_n = rtw8723d_pwrtrk_2gb_n,
+	.pwrtrk_2gb_p = rtw8723d_pwrtrk_2gb_p,
+	.pwrtrk_2ga_n = rtw8723d_pwrtrk_2ga_n,
+	.pwrtrk_2ga_p = rtw8723d_pwrtrk_2ga_p,
+	.pwrtrk_2g_cckb_n = rtw8723d_pwrtrk_2g_cck_b_n,
+	.pwrtrk_2g_cckb_p = rtw8723d_pwrtrk_2g_cck_b_p,
+	.pwrtrk_2g_ccka_n = rtw8723d_pwrtrk_2g_cck_a_n,
+	.pwrtrk_2g_ccka_p = rtw8723d_pwrtrk_2g_cck_a_p,
+	.pwrtrk_xtal_p = rtw8723d_pwrtrk_xtal_p,
+	.pwrtrk_xtal_n = rtw8723d_pwrtrk_xtal_n,
+};
+
 struct rtw_chip_info rtw8723d_hw_spec = {
 	.ops = &rtw8723d_ops,
 	.id = RTW_CHIP_TYPE_8723D,
@@ -1979,6 +2377,8 @@ struct rtw_chip_info rtw8723d_hw_spec = {
 	.rfe_defs = rtw8723d_rfe_defs,
 	.rfe_defs_size = ARRAY_SIZE(rtw8723d_rfe_defs),
 	.rx_ldpc = false,
+	.pwr_track_tbl = &rtw8723d_rtw_pwr_track_tbl,
+	.iqk_threshold = 8,
 };
 EXPORT_SYMBOL(rtw8723d_hw_spec);
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.h b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
index 549dfcf7f5da..843472a1cd54 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
@@ -112,6 +112,13 @@ static inline s32 iqk_mult(s32 x, s32 y, s32 *ext)
 	return (t >> 8);	/* Q.16 --> Q.8 */
 }
 
+#define OFDM_SWING_A(swing)		FIELD_GET(GENMASK(9, 0), swing)
+#define OFDM_SWING_B(swing)		FIELD_GET(GENMASK(15, 10), swing)
+#define OFDM_SWING_C(swing)		FIELD_GET(GENMASK(21, 16), swing)
+#define OFDM_SWING_D(swing)		FIELD_GET(GENMASK(31, 22), swing)
+#define RTW_DEF_OFDM_SWING_INDEX	28
+#define RTW_DEF_CCK_SWING_INDEX		28
+
 #define MAX_TOLERANCE	5
 #define IQK_TX_X_ERR	0x142
 #define IQK_TX_Y_ERR	0x42
-- 
2.17.1

