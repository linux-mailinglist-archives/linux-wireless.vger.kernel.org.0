Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF36CF4E5
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 10:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbfJHIVO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 04:21:14 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:47338 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbfJHIVN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 04:21:13 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x988L4Tq028125, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x988L4Tq028125
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 8 Oct 2019 16:21:05 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Tue, 8 Oct 2019 16:21:04 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 01/10] rtw88: add power tracking support
Date:   Tue, 8 Oct 2019 16:20:52 +0800
Message-ID: <20191008082101.2494-2-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191008082101.2494-1-yhchuang@realtek.com>
References: <20191008082101.2494-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

The temperature of the chip can affect the output power
of the RF components. Hence driver requires to compensate
the power by adjusting the power index recorded in the
power swing table.

And if the difference of current thermal value to the
default thermal value exceeds a threshold, the RF IQK
should be triggered to re-calibrate the characteristics
of the RF components, to keep the output IQ vectors of
the RF components orthogonal enough.

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c       |   1 +
 drivers/net/wireless/realtek/rtw88/main.h     |  49 ++-
 drivers/net/wireless/realtek/rtw88/phy.c      | 109 ++++++
 drivers/net/wireless/realtek/rtw88/phy.h      |  12 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 322 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 231 +++++++++++++
 6 files changed, 723 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 65594393dd1e..b8c581161f61 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -117,6 +117,7 @@ static void rtw_fw_ra_report_handle(struct rtw_dev *rtwdev, u8 *payload,
 	if (WARN(length < 7, "invalid ra report c2h length\n"))
 		return;
 
+	rtwdev->dm_info.tx_rate = GET_RA_REPORT_RATE(payload);
 	ra_data.rtwdev = rtwdev;
 	ra_data.payload = payload;
 	rtw_iterate_stas_atomic(rtwdev, rtw_fw_ra_report_iter, &ra_data);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index f3eab96dba86..417c4200b758 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -677,6 +677,7 @@ struct rtw_chip_ops {
 	void (*phy_calibration)(struct rtw_dev *rtwdev);
 	void (*dpk_track)(struct rtw_dev *rtwdev);
 	void (*cck_pd_set)(struct rtw_dev *rtwdev, u8 level);
+	void (*pwrtrack_check)(struct rtw_dev *rtwdev);
 
 	/* for coex */
 	void (*coex_set_init)(struct rtw_dev *rtwdev);
@@ -853,6 +854,33 @@ struct rtw_rfe_def {
 	.txpwr_lmt_tbl = &rtw ## chip ## _txpwr_lmt_type ## pwrlmt ## _tbl, \
 	}
 
+#define RTW_PWRTRACK_5G_BAND_0		0
+#define RTW_PWRTRACK_5G_BAND_1		1
+#define RTW_PWRTRACK_5G_BAND_2		2
+#define RTW_PWRTRACK_5G_BAND_SIZE	3
+#define RTW_PWRTRACK_TBL_SIZE		30
+
+/* This table stores the values of TX power that will be adjusted by power
+ * tracking.
+ *
+ * For 5G bands, there are 3 different settings.
+ * For 2G there are cck rate and ofdm rate with different settings.
+ */
+struct rtw_pwr_track_tbl {
+	const u8 *pwrtrk_5gb_n[RTW_PWRTRACK_5G_BAND_SIZE];
+	const u8 *pwrtrk_5gb_p[RTW_PWRTRACK_5G_BAND_SIZE];
+	const u8 *pwrtrk_5ga_n[RTW_PWRTRACK_5G_BAND_SIZE];
+	const u8 *pwrtrk_5ga_p[RTW_PWRTRACK_5G_BAND_SIZE];
+	const u8 *pwrtrk_2gb_n;
+	const u8 *pwrtrk_2gb_p;
+	const u8 *pwrtrk_2ga_n;
+	const u8 *pwrtrk_2ga_p;
+	const u8 *pwrtrk_2g_cckb_n;
+	const u8 *pwrtrk_2g_cckb_p;
+	const u8 *pwrtrk_2g_ccka_n;
+	const u8 *pwrtrk_2g_ccka_p;
+};
+
 /* hardware configuration for each IC */
 struct rtw_chip_info {
 	struct rtw_chip_ops *ops;
@@ -904,6 +932,8 @@ struct rtw_chip_info {
 
 	bool en_dis_dpd;
 	u16 dpd_ratemask;
+	u8 iqk_threshold;
+	const struct rtw_pwr_track_tbl *pwr_track_tbl;
 
 	/* coex paras */
 	u32 coex_para_ver;
@@ -1157,6 +1187,11 @@ struct rtw_phy_cck_pd_reg {
 #define DACK_MSBK_BACKUP_NUM	0xf
 #define DACK_DCK_BACKUP_NUM	0x2
 
+struct rtw_swing_table {
+	u8 *tup[RTW_RF_PATH_MAX];
+	u8 *tdown[RTW_RF_PATH_MAX];
+};
+
 struct rtw_dm_info {
 	u32 cck_fa_cnt;
 	u32 ofdm_fa_cnt;
@@ -1183,6 +1218,16 @@ struct rtw_dm_info {
 	u8 cck_gi_u_bnd;
 	u8 cck_gi_l_bnd;
 
+	u8 tx_rate;
+	u8 thermal_avg[RTW_RF_PATH_MAX];
+	u8 thermal_meter_k;
+	s8 delta_power_index[RTW_RF_PATH_MAX];
+	s8 delta_power_index_last[RTW_RF_PATH_MAX];
+	u8 default_ofdm_index;
+	bool pwrtrack_trigger;
+	bool pwrtrack_initial_trigger;
+	struct ewma_thermal avg_thermal[RTW_RF_PATH_MAX];
+
 	/* backup dack results for each path and I/Q */
 	u32 dack_adck[RTW_RF_PATH_MAX];
 	u16 dack_msbk[RTW_RF_PATH_MAX][2][DACK_MSBK_BACKUP_NUM];
@@ -1206,7 +1251,9 @@ struct rtw_efuse {
 	u8 country_code[2];
 	u8 rf_board_option;
 	u8 rfe_option;
-	u8 thermal_meter;
+	u8 power_track_type;
+	u8 thermal_meter[2];
+	u8 thermal_meter_k;
 	u8 crystal_cap;
 	u8 ant_div_cfg;
 	u8 ant_div_type;
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 8ebe1f4b76ad..e9c50a274f48 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -547,6 +547,7 @@ void rtw_phy_dynamic_mechanism(struct rtw_dev *rtwdev)
 	rtw_phy_cck_pd(rtwdev);
 	rtw_phy_ra_info_update(rtwdev);
 	rtw_phy_dpk_track(rtwdev);
+	rtwdev->chip->ops->pwrtrack_check(rtwdev);
 }
 
 #define FRAC_BITS 3
@@ -1968,3 +1969,111 @@ void rtw_phy_init_tx_power(struct rtw_dev *rtwdev)
 				rtw_phy_init_tx_power_limit(rtwdev, regd, bw,
 							    rs);
 }
+
+void rtw_phy_config_swing_table(struct rtw_dev *rtwdev,
+				struct rtw_swing_table *swing_table)
+{
+	const struct rtw_pwr_track_tbl *tbl = rtwdev->chip->pwr_track_tbl;
+	u8 channel = rtwdev->hal.current_channel;
+
+	if (channel >= 1 && channel <= 14) {
+		if (rtwdev->dm_info.tx_rate <= DESC_RATE11M) {
+			swing_table->tup[0] = (u8 *)tbl->pwrtrk_2g_ccka_p;
+			swing_table->tdown[0] = (u8 *)tbl->pwrtrk_2g_ccka_n;
+			swing_table->tup[1] = (u8 *)tbl->pwrtrk_2g_cckb_p;
+			swing_table->tdown[1] = (u8 *)tbl->pwrtrk_2g_cckb_n;
+		} else {
+			swing_table->tup[0] = (u8 *)tbl->pwrtrk_2ga_p;
+			swing_table->tdown[0] = (u8 *)tbl->pwrtrk_2ga_n;
+			swing_table->tup[1] = (u8 *)tbl->pwrtrk_2gb_p;
+			swing_table->tdown[1] = (u8 *)tbl->pwrtrk_2gb_n;
+		}
+	}
+	if (channel >= 36 && channel <= 64) {
+		swing_table->tup[0] = (u8 *)tbl->pwrtrk_5ga_p[0];
+		swing_table->tdown[0] = (u8 *)tbl->pwrtrk_5ga_n[0];
+		swing_table->tup[1] = (u8 *)tbl->pwrtrk_5gb_p[0];
+		swing_table->tdown[1] = (u8 *)tbl->pwrtrk_5gb_n[0];
+	} else if (channel >= 100 && channel <= 144) {
+		swing_table->tup[0] = (u8 *)tbl->pwrtrk_5ga_p[1];
+		swing_table->tdown[0] = (u8 *)tbl->pwrtrk_5ga_n[1];
+		swing_table->tup[1] = (u8 *)tbl->pwrtrk_5gb_p[1];
+		swing_table->tdown[1] = (u8 *)tbl->pwrtrk_5gb_n[1];
+	} else if (channel >= 149 && channel <= 177) {
+		swing_table->tup[0] = (u8 *)tbl->pwrtrk_5ga_p[2];
+		swing_table->tdown[0] = (u8 *)tbl->pwrtrk_5ga_n[2];
+		swing_table->tup[1] = (u8 *)tbl->pwrtrk_5gb_p[2];
+		swing_table->tdown[1] = (u8 *)tbl->pwrtrk_5gb_n[2];
+	} else {
+		swing_table->tup[0] = (u8 *)tbl->pwrtrk_2ga_p;
+		swing_table->tdown[0] = (u8 *)tbl->pwrtrk_2ga_n;
+		swing_table->tup[1] = (u8 *)tbl->pwrtrk_2gb_p;
+		swing_table->tdown[1] = (u8 *)tbl->pwrtrk_2gb_n;
+	}
+}
+
+void rtw_phy_pwrtrack_avg(struct rtw_dev *rtwdev, u8 thermal, u8 path)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+
+	ewma_thermal_add(&dm_info->avg_thermal[path], thermal);
+	dm_info->thermal_avg[path] =
+		ewma_thermal_read(&dm_info->avg_thermal[path]);
+}
+
+bool rtw_phy_pwrtrack_thermal_changed(struct rtw_dev *rtwdev, u8 thermal,
+				      u8 path)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u8 avg = ewma_thermal_read(&dm_info->avg_thermal[path]);
+
+	if (avg == thermal)
+		return false;
+
+	return true;
+}
+
+u8 rtw_phy_pwrtrack_get_delta(struct rtw_dev *rtwdev, u8 path)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+
+	return abs(dm_info->thermal_avg[path] -
+		   rtwdev->efuse.thermal_meter[path]);
+}
+
+s8 rtw_phy_pwrtrack_get_pwridx(struct rtw_dev *rtwdev,
+			       struct rtw_swing_table *swing_table,
+			       u8 tbl_path, u8 therm_path, u8 delta)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u8 *delta_swing_table_idx_tup;
+	u8 *delta_swing_table_idx_tdown;
+
+	if (!swing_table)
+		return 0;
+
+	delta_swing_table_idx_tup = swing_table->tup[tbl_path];
+	delta_swing_table_idx_tdown = swing_table->tdown[tbl_path];
+
+	if (!delta_swing_table_idx_tup || !delta_swing_table_idx_tdown)
+		return 0;
+
+	if (dm_info->thermal_avg[therm_path] >
+	    rtwdev->efuse.thermal_meter[therm_path])
+		return delta_swing_table_idx_tup[delta];
+	else
+		return -delta_swing_table_idx_tdown[delta];
+}
+
+bool rtw_phy_pwrtrack_need_iqk(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u8 delta_iqk;
+
+	delta_iqk = abs(dm_info->thermal_avg[0] - dm_info->thermal_meter_k);
+	if (delta_iqk >= rtwdev->chip->iqk_threshold) {
+		dm_info->thermal_meter_k = dm_info->thermal_avg[0];
+		return true;
+	}
+	return false;
+}
diff --git a/drivers/net/wireless/realtek/rtw88/phy.h b/drivers/net/wireless/realtek/rtw88/phy.h
index e79b084628e7..0dc7720aaad7 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.h
+++ b/drivers/net/wireless/realtek/rtw88/phy.h
@@ -41,9 +41,21 @@ void rtw_phy_cfg_rf(struct rtw_dev *rtwdev, const struct rtw_table *tbl,
 		    u32 addr, u32 data);
 void rtw_phy_init_tx_power(struct rtw_dev *rtwdev);
 void rtw_phy_load_tables(struct rtw_dev *rtwdev);
+u8 rtw_phy_get_tx_power_index(struct rtw_dev *rtwdev, u8 rf_path, u8 rate,
+			      enum rtw_bandwidth bw, u8 channel, u8 regd);
 void rtw_phy_set_tx_power_level(struct rtw_dev *rtwdev, u8 channel);
 void rtw_phy_tx_power_by_rate_config(struct rtw_hal *hal);
 void rtw_phy_tx_power_limit_config(struct rtw_hal *hal);
+void rtw_phy_pwrtrack_avg(struct rtw_dev *rtwdev, u8 thermal, u8 path);
+bool rtw_phy_pwrtrack_thermal_changed(struct rtw_dev *rtwdev, u8 thermal,
+				      u8 path);
+u8 rtw_phy_pwrtrack_get_delta(struct rtw_dev *rtwdev, u8 path);
+s8 rtw_phy_pwrtrack_get_pwridx(struct rtw_dev *rtwdev,
+			       struct rtw_swing_table *swing_table,
+			       u8 tbl_path, u8 therm_path, u8 delta);
+bool rtw_phy_pwrtrack_need_iqk(struct rtw_dev *rtwdev);
+void rtw_phy_config_swing_table(struct rtw_dev *rtwdev,
+				struct rtw_swing_table *swing_table);
 
 struct rtw_txpwr_lmt_cfg_pair {
 	u8 regd;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 1e20c4465bc9..51b7f5eb9e9d 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -43,6 +43,8 @@ static int rtw8822b_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
 	efuse->country_code[1] = map->country_code[1];
 	efuse->bt_setting = map->rf_bt_setting;
 	efuse->regd = map->rf_board_option & 0x7;
+	efuse->thermal_meter[0] = map->thermal_meter;
+	efuse->thermal_meter_k = map->thermal_meter;
 
 	for (i = 0; i < 4; i++)
 		efuse->txpwr_idx_table[i] = map->txpwr_idx_table[i];
@@ -75,6 +77,50 @@ static void rtw8822b_phy_rfe_init(struct rtw_dev *rtwdev)
 	rtw_write32_mask(rtwdev, 0x974, (BIT(11) | BIT(10)), 0x3);
 }
 
+#define RTW_TXSCALE_SIZE 37
+static const u32 rtw8822b_txscale_tbl[RTW_TXSCALE_SIZE] = {
+	0x081, 0x088, 0x090, 0x099, 0x0a2, 0x0ac, 0x0b6, 0x0c0, 0x0cc, 0x0d8,
+	0x0e5, 0x0f2, 0x101, 0x110, 0x120, 0x131, 0x143, 0x156, 0x16a, 0x180,
+	0x197, 0x1af, 0x1c8, 0x1e3, 0x200, 0x21e, 0x23e, 0x261, 0x285, 0x2ab,
+	0x2d3, 0x2fe, 0x32b, 0x35c, 0x38e, 0x3c4, 0x3fe
+};
+
+static const u8 rtw8822b_get_swing_index(struct rtw_dev *rtwdev)
+{
+	u8 i = 0;
+	u32 swing, table_value;
+
+	swing = rtw_read32_mask(rtwdev, 0xc1c, 0xffe00000);
+	for (i = 0; i < RTW_TXSCALE_SIZE; i++) {
+		table_value = rtw8822b_txscale_tbl[i];
+		if (swing == table_value)
+			break;
+	}
+
+	return i;
+}
+
+static void rtw8822b_pwrtrack_init(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u8 swing_idx = rtw8822b_get_swing_index(rtwdev);
+	u8 path;
+
+	if (swing_idx >= RTW_TXSCALE_SIZE)
+		dm_info->default_ofdm_index = 24;
+	else
+		dm_info->default_ofdm_index = swing_idx;
+
+	for (path = RF_PATH_A; path < rtwdev->hal.rf_path_num; path++) {
+		ewma_thermal_init(&dm_info->avg_thermal[path]);
+		dm_info->delta_power_index[path] = 0;
+		dm_info->delta_power_index_last[path] = 0;
+	}
+	dm_info->pwrtrack_trigger = false;
+	dm_info->pwrtrack_initial_trigger = true;
+	dm_info->thermal_meter_k = rtwdev->efuse.thermal_meter_k;
+}
+
 static void rtw8822b_phy_set_param(struct rtw_dev *rtwdev)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
@@ -106,6 +152,7 @@ static void rtw8822b_phy_set_param(struct rtw_dev *rtwdev)
 	rtw_phy_init(rtwdev);
 
 	rtw8822b_phy_rfe_init(rtwdev);
+	rtw8822b_pwrtrack_init(rtwdev);
 }
 
 #define WLAN_SLOT_TIME		0x09
@@ -1256,6 +1303,155 @@ static void rtw8822b_coex_cfg_wl_rx_gain(struct rtw_dev *rtwdev, bool low_gain)
 	}
 }
 
+static void rtw8822b_txagc_swing_offset(struct rtw_dev *rtwdev, u8 path,
+					u8 tx_pwr_idx_offset,
+					s8 *txagc_idx, u8 *swing_idx)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	s8 delta_pwr_idx = dm_info->delta_power_index[path];
+	u8 swing_upper_bound = dm_info->default_ofdm_index + 10;
+	u8 swing_lower_bound = 0;
+	u8 max_tx_pwr_idx_offset = 0xf;
+	s8 agc_index = 0;
+	u8 swing_index = dm_info->default_ofdm_index;
+
+	tx_pwr_idx_offset = min_t(u8, tx_pwr_idx_offset, max_tx_pwr_idx_offset);
+
+	if (delta_pwr_idx >= 0) {
+		if (delta_pwr_idx <= tx_pwr_idx_offset) {
+			agc_index = delta_pwr_idx;
+			swing_index = dm_info->default_ofdm_index;
+		} else if (delta_pwr_idx > tx_pwr_idx_offset) {
+			agc_index = tx_pwr_idx_offset;
+			swing_index = dm_info->default_ofdm_index +
+					delta_pwr_idx - tx_pwr_idx_offset;
+			swing_index = min_t(u8, swing_index, swing_upper_bound);
+		}
+	} else {
+		if (dm_info->default_ofdm_index > abs(delta_pwr_idx))
+			swing_index =
+				dm_info->default_ofdm_index + delta_pwr_idx;
+		else
+			swing_index = swing_lower_bound;
+		swing_index = max_t(u8, swing_index, swing_lower_bound);
+
+		agc_index = 0;
+	}
+
+	if (swing_index >= RTW_TXSCALE_SIZE) {
+		rtw_warn(rtwdev, "swing index overflow\n");
+		swing_index = RTW_TXSCALE_SIZE - 1;
+	}
+	*txagc_idx = agc_index;
+	*swing_idx = swing_index;
+}
+
+static void rtw8822b_pwrtrack_set_pwr(struct rtw_dev *rtwdev, u8 path,
+				      u8 pwr_idx_offset)
+{
+	s8 txagc_idx;
+	u8 swing_idx;
+	u32 reg1, reg2;
+
+	if (path == RF_PATH_A) {
+		reg1 = 0xc94;
+		reg2 = 0xc1c;
+	} else if (path == RF_PATH_B) {
+		reg1 = 0xe94;
+		reg2 = 0xe1c;
+	} else {
+		return;
+	}
+
+	rtw8822b_txagc_swing_offset(rtwdev, path, pwr_idx_offset,
+				    &txagc_idx, &swing_idx);
+	rtw_write32_mask(rtwdev, reg1, GENMASK(29, 25), txagc_idx);
+	rtw_write32_mask(rtwdev, reg2, GENMASK(31, 21),
+			 rtw8822b_txscale_tbl[swing_idx]);
+}
+
+static void rtw8822b_pwrtrack_set(struct rtw_dev *rtwdev, u8 path)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u8 pwr_idx_offset, tx_pwr_idx;
+	u8 channel = rtwdev->hal.current_channel;
+	u8 band_width = rtwdev->hal.current_band_width;
+	u8 regd = rtwdev->regd.txpwr_regd;
+	u8 tx_rate = dm_info->tx_rate;
+	u8 max_pwr_idx = rtwdev->chip->max_power_index;
+
+	tx_pwr_idx = rtw_phy_get_tx_power_index(rtwdev, path, tx_rate,
+						band_width, channel, regd);
+
+	tx_pwr_idx = min_t(u8, tx_pwr_idx, max_pwr_idx);
+
+	pwr_idx_offset = max_pwr_idx - tx_pwr_idx;
+
+	rtw8822b_pwrtrack_set_pwr(rtwdev, path, pwr_idx_offset);
+}
+
+static void rtw8822b_phy_pwrtrack(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	struct rtw_swing_table swing_table;
+	u8 thermal_value, delta, path;
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
+	if (dm_info->pwrtrack_initial_trigger)
+		dm_info->pwrtrack_initial_trigger = false;
+	else if (!rtw_phy_pwrtrack_thermal_changed(rtwdev, thermal_value,
+						   RF_PATH_A))
+		goto iqk;
+
+	delta = rtw_phy_pwrtrack_get_delta(rtwdev, RF_PATH_A);
+
+	delta = min_t(u8, delta, RTW_PWRTRACK_TBL_SIZE - 1);
+
+	for (path = 0; path < rtwdev->hal.rf_path_num; path++) {
+		dm_info->delta_power_index[path] =
+			rtw_phy_pwrtrack_get_pwridx(rtwdev, &swing_table, path,
+						    RF_PATH_A, delta);
+		if (dm_info->delta_power_index[path] ==
+				dm_info->delta_power_index_last[path])
+			continue;
+		else
+			dm_info->delta_power_index_last[path] =
+				dm_info->delta_power_index[path];
+		rtw8822b_pwrtrack_set(rtwdev, path);
+	}
+
+iqk:
+	if (rtw_phy_pwrtrack_need_iqk(rtwdev))
+		rtw8822b_do_iqk(rtwdev);
+}
+
+void rtw8822b_pwrtrack_check(struct rtw_dev *rtwdev)
+{
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+
+	if (efuse->power_track_type != 0)
+		return;
+
+	if (!dm_info->pwrtrack_trigger) {
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_T_METER,
+			     GENMASK(17, 16), 0x03);
+		dm_info->pwrtrack_trigger = true;
+		return;
+	}
+
+	rtw8822b_phy_pwrtrack(rtwdev);
+	dm_info->pwrtrack_trigger = false;
+}
+
 static struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8822b[] = {
 	{0x0086,
 	 RTW_PWR_CUT_ALL_MSK,
@@ -1802,6 +1998,7 @@ static struct rtw_chip_ops rtw8822b_ops = {
 	.cfg_ldo25		= rtw8822b_cfg_ldo25,
 	.false_alarm_statistics	= rtw8822b_false_alarm_statistics,
 	.phy_calibration	= rtw8822b_phy_calibration,
+	.pwrtrack_check		= rtw8822b_pwrtrack_check,
 
 	.coex_set_init		= rtw8822b_coex_cfg_init,
 	.coex_set_ant_switch	= rtw8822b_coex_cfg_ant_switch,
@@ -1956,6 +2153,129 @@ static const struct coex_rf_para rf_para_rx_8822b[] = {
 
 static_assert(ARRAY_SIZE(rf_para_tx_8822b) == ARRAY_SIZE(rf_para_rx_8822b));
 
+static const u8
+rtw8822b_pwrtrk_5gb_n[RTW_PWRTRACK_5G_BAND_SIZE][RTW_PWRTRACK_TBL_SIZE] = {
+	{ 0,  1,  2,  2,  3,  4,  5,  5,  6,  7,
+	  8,  8,  9, 10, 11, 11, 12, 13, 14, 14,
+	 15, 16, 17, 17, 18, 19, 20, 20, 21, 22 },
+	{ 0,  1,  2,  2,  3,  4,  5,  5,  6,  7,
+	  8,  8,  9, 10, 11, 11, 12, 13, 14, 14,
+	 15, 16, 17, 17, 18, 19, 20, 20, 21, 22 },
+	{ 0,  1,  2,  2,  3,  4,  5,  5,  6,  7,
+	  8,  8,  9, 10, 11, 11, 12, 13, 14, 14,
+	 15, 16, 17, 17, 18, 19, 20, 20, 21, 22 },
+};
+
+static const u8
+rtw8822b_pwrtrk_5gb_p[RTW_PWRTRACK_5G_BAND_SIZE][RTW_PWRTRACK_TBL_SIZE] = {
+	{ 0,  1,  2,  2,  3,  4,  5,  5,  6,  7,
+	  8,  9,  9, 10, 11, 12, 13, 14, 14, 15,
+	 16, 17, 18, 19, 19, 20, 21, 22, 22, 23 },
+	{ 0,  1,  2,  2,  3,  4,  5,  5,  6,  7,
+	  8,  9,  9, 10, 11, 12, 13, 14, 14, 15,
+	 16, 17, 18, 19, 19, 20, 21, 22, 22, 23 },
+	{ 0,  1,  2,  2,  3,  4,  5,  5,  6,  7,
+	  8,  9,  9, 10, 11, 12, 13, 14, 14, 15,
+	 16, 17, 18, 19, 19, 20, 21, 22, 22, 23 },
+};
+
+static const u8
+rtw8822b_pwrtrk_5ga_n[RTW_PWRTRACK_5G_BAND_SIZE][RTW_PWRTRACK_TBL_SIZE] = {
+	{ 0,  1,  2,  2,  3,  4,  5,  5,  6,  7,
+	  8,  8,  9, 10, 11, 11, 12, 13, 14, 14,
+	 15, 16, 17, 17, 18, 19, 20, 20, 21, 22 },
+	{ 0,  1,  2,  2,  3,  4,  5,  5,  6,  7,
+	  8,  8,  9, 10, 11, 11, 12, 13, 14, 14,
+	 15, 16, 17, 17, 18, 19, 20, 20, 21, 22 },
+	{ 0,  1,  2,  2,  3,  4,  5,  5,  6,  7,
+	  8,  8,  9, 10, 11, 11, 12, 13, 14, 14,
+	 15, 16, 17, 17, 18, 19, 20, 20, 21, 22 },
+};
+
+static const u8
+rtw8822b_pwrtrk_5ga_p[RTW_PWRTRACK_5G_BAND_SIZE][RTW_PWRTRACK_TBL_SIZE] = {
+	{ 0,  1,  2,  2,  3,  4,  5,  5,  6,  7,
+	  8,  9,  9, 10, 11, 12, 13, 14, 14, 15,
+	 16, 17, 18, 19, 19, 20, 21, 22, 22, 23},
+	{ 0,  1,  2,  2,  3,  4,  5,  5,  6,  7,
+	  8,  9,  9, 10, 11, 12, 13, 14, 14, 15,
+	 16, 17, 18, 19, 19, 20, 21, 22, 22, 23},
+	{ 0,  1,  2,  2,  3,  4,  5,  5,  6,  7,
+	  8,  9,  9, 10, 11, 12, 13, 14, 14, 15,
+	 16, 17, 18, 19, 19, 20, 21, 22, 22, 23},
+};
+
+static const u8 rtw8822b_pwrtrk_2gb_n[RTW_PWRTRACK_TBL_SIZE] = {
+	0,  1,  1,  1,  2,  2,  3,  3,  3,  4,
+	4,  5,  5,  5,  6,  6,  7,  7,  7,  8,
+	8,  9,  9,  9, 10, 10, 11, 11, 11, 12
+};
+
+static const u8 rtw8822b_pwrtrk_2gb_p[RTW_PWRTRACK_TBL_SIZE] = {
+	0,  0,  1,  1,  2,  2,  3,  3,  4,  4,
+	5,  5,  6,  6,  6,  7,  7,  8,  8,  9,
+	9, 10, 10, 11, 11, 12, 12, 12, 13, 13
+};
+
+static const u8 rtw8822b_pwrtrk_2ga_n[RTW_PWRTRACK_TBL_SIZE] = {
+	0,  1,  1,  1,  2,  2,  3,  3,  3,  4,
+	4,  5,  5,  5,  6,  6,  7,  7,  7,  8,
+	8,  9,  9,  9, 10, 10, 11, 11, 11, 12
+};
+
+static const u8 rtw8822b_pwrtrk_2ga_p[RTW_PWRTRACK_TBL_SIZE] = {
+	0,  1,  1,  2,  2,  3,  3,  4,  4,  5,
+	5,  6,  6,  7,  7,  8,  8,  9,  9, 10,
+	10, 11, 11, 12, 12, 13, 13, 14, 14, 15
+};
+
+static const u8 rtw8822b_pwrtrk_2g_cck_b_n[RTW_PWRTRACK_TBL_SIZE] = {
+	0,  1,  1,  1,  2,  2,  3,  3,  3,  4,
+	4,  5,  5,  5,  6,  6,  7,  7,  7,  8,
+	8,  9,  9,  9, 10, 10, 11, 11, 11, 12
+};
+
+static const u8 rtw8822b_pwrtrk_2g_cck_b_p[RTW_PWRTRACK_TBL_SIZE] = {
+	0,  0,  1,  1,  2,  2,  3,  3,  4,  4,
+	5,  5,  6,  6,  6,  7,  7,  8,  8,  9,
+	9, 10, 10, 11, 11, 12, 12, 12, 13, 13
+};
+
+static const u8 rtw8822b_pwrtrk_2g_cck_a_n[RTW_PWRTRACK_TBL_SIZE] = {
+	0,  1,  1,  1,  2,  2,  3,  3,  3,  4,
+	4,  5,  5,  5,  6,  6,  7,  7,  7,  8,
+	8,  9,  9,  9, 10, 10, 11, 11, 11, 12
+};
+
+static const u8 rtw8822b_pwrtrk_2g_cck_a_p[RTW_PWRTRACK_TBL_SIZE] = {
+	 0,  1,  1,  2,  2,  3,  3,  4,  4,  5,
+	 5,  6,  6,  7,  7,  8,  8,  9,  9, 10,
+	10, 11, 11, 12, 12, 13, 13, 14, 14, 15
+};
+
+static const struct rtw_pwr_track_tbl rtw8822b_rtw_pwr_track_tbl = {
+	.pwrtrk_5gb_n[0] = rtw8822b_pwrtrk_5gb_n[0],
+	.pwrtrk_5gb_n[1] = rtw8822b_pwrtrk_5gb_n[1],
+	.pwrtrk_5gb_n[2] = rtw8822b_pwrtrk_5gb_n[2],
+	.pwrtrk_5gb_p[0] = rtw8822b_pwrtrk_5gb_p[0],
+	.pwrtrk_5gb_p[1] = rtw8822b_pwrtrk_5gb_p[1],
+	.pwrtrk_5gb_p[2] = rtw8822b_pwrtrk_5gb_p[2],
+	.pwrtrk_5ga_n[0] = rtw8822b_pwrtrk_5ga_n[0],
+	.pwrtrk_5ga_n[1] = rtw8822b_pwrtrk_5ga_n[1],
+	.pwrtrk_5ga_n[2] = rtw8822b_pwrtrk_5ga_n[2],
+	.pwrtrk_5ga_p[0] = rtw8822b_pwrtrk_5ga_p[0],
+	.pwrtrk_5ga_p[1] = rtw8822b_pwrtrk_5ga_p[1],
+	.pwrtrk_5ga_p[2] = rtw8822b_pwrtrk_5ga_p[2],
+	.pwrtrk_2gb_n = rtw8822b_pwrtrk_2gb_n,
+	.pwrtrk_2gb_p = rtw8822b_pwrtrk_2gb_p,
+	.pwrtrk_2ga_n = rtw8822b_pwrtrk_2ga_n,
+	.pwrtrk_2ga_p = rtw8822b_pwrtrk_2ga_p,
+	.pwrtrk_2g_cckb_n = rtw8822b_pwrtrk_2g_cck_b_n,
+	.pwrtrk_2g_cckb_p = rtw8822b_pwrtrk_2g_cck_b_p,
+	.pwrtrk_2g_ccka_n = rtw8822b_pwrtrk_2g_cck_a_n,
+	.pwrtrk_2g_ccka_p = rtw8822b_pwrtrk_2g_cck_a_p,
+};
+
 struct rtw_chip_info rtw8822b_hw_spec = {
 	.ops = &rtw8822b_ops,
 	.id = RTW_CHIP_TYPE_8822B,
@@ -1994,6 +2314,8 @@ struct rtw_chip_info rtw8822b_hw_spec = {
 	.rf_tbl = {&rtw8822b_rf_a_tbl, &rtw8822b_rf_b_tbl},
 	.rfe_defs = rtw8822b_rfe_defs,
 	.rfe_defs_size = ARRAY_SIZE(rtw8822b_rfe_defs),
+	.pwr_track_tbl = &rtw8822b_rtw_pwr_track_tbl,
+	.iqk_threshold = 8,
 
 	.coex_para_ver = 0x19062706,
 	.bt_desired_ver = 0x6,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 5075c7045b8f..ddf16ff4bb35 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -40,6 +40,11 @@ static int rtw8822c_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
 	efuse->country_code[1] = map->country_code[1];
 	efuse->bt_setting = map->rf_bt_setting;
 	efuse->regd = map->rf_board_option & 0x7;
+	efuse->thermal_meter[0] = map->path_a_thermal;
+	efuse->thermal_meter[1] = map->path_b_thermal;
+	efuse->thermal_meter_k =
+			(map->path_a_thermal + map->path_b_thermal) >> 1;
+	efuse->power_track_type = (map->tx_pwr_calibrate_rate >> 4) & 0xf;
 
 	for (i = 0; i < 4; i++)
 		efuse->txpwr_idx_table[i] = map->txpwr_idx_table[i];
@@ -1000,6 +1005,21 @@ static void rtw8822c_rf_init(struct rtw_dev *rtwdev)
 	rtw8822c_rf_x2_check(rtwdev);
 }
 
+void rtw8822c_pwrtrack_init(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u8 path;
+
+	for (path = RF_PATH_A; path < RTW_RF_PATH_MAX; path++) {
+		dm_info->delta_power_index[path] = 0;
+		ewma_thermal_init(&dm_info->avg_thermal[path]);
+		dm_info->thermal_avg[path] = 0xff;
+	}
+
+	dm_info->pwrtrack_trigger = false;
+	dm_info->thermal_meter_k = rtwdev->efuse.thermal_meter_k;
+}
+
 static void rtw8822c_phy_set_param(struct rtw_dev *rtwdev)
 {
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
@@ -1047,6 +1067,7 @@ static void rtw8822c_phy_set_param(struct rtw_dev *rtwdev)
 	dm_info->cck_gi_l_bnd = ((cck_gi_l_bnd_msb << 4) | (cck_gi_l_bnd_lsb));
 
 	rtw8822c_rf_init(rtwdev);
+	rtw8822c_pwrtrack_init(rtwdev);
 }
 
 #define WLAN_TXQ_RPT_EN		0x1F
@@ -3192,6 +3213,90 @@ static void rtw8822c_phy_cck_pd_set(struct rtw_dev *rtwdev, u8 new_lvl)
 	dm_info->cck_pd_lv[bw][nrx] = new_lvl;
 }
 
+#define PWR_TRACK_MASK 0x7f
+static void rtw8822c_pwrtrack_set(struct rtw_dev *rtwdev, u8 rf_path)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+
+	switch (rf_path) {
+	case RF_PATH_A:
+		rtw_write32_mask(rtwdev, 0x18a0, PWR_TRACK_MASK,
+				 dm_info->delta_power_index[rf_path]);
+		break;
+	case RF_PATH_B:
+		rtw_write32_mask(rtwdev, 0x41a0, PWR_TRACK_MASK,
+				 dm_info->delta_power_index[rf_path]);
+		break;
+	default:
+		break;
+	}
+}
+
+static void rtw8822c_phy_pwrtrack_path(struct rtw_dev *rtwdev,
+				       struct rtw_swing_table *swing_table,
+				       u8 path)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u8 thermal_value, delta;
+
+	if (rtwdev->efuse.thermal_meter[path] == 0xff)
+		return;
+
+	thermal_value = rtw_read_rf(rtwdev, path, RF_T_METER, 0x7e);
+
+	rtw_phy_pwrtrack_avg(rtwdev, thermal_value, path);
+
+	delta = rtw_phy_pwrtrack_get_delta(rtwdev, path);
+
+	if (delta >= RTW_PWRTRACK_TBL_SIZE)
+		delta = RTW_PWRTRACK_TBL_SIZE - 1;
+
+	dm_info->delta_power_index[path] =
+		rtw_phy_pwrtrack_get_pwridx(rtwdev, swing_table, path, path,
+					    delta);
+
+	rtw8822c_pwrtrack_set(rtwdev, path);
+}
+
+static void rtw8822c_phy_pwrtrack(struct rtw_dev *rtwdev)
+{
+	struct rtw_swing_table swing_table;
+	u8 i;
+
+	rtw_phy_config_swing_table(rtwdev, &swing_table);
+
+	for (i = 0; i < rtwdev->hal.rf_path_num; i++)
+		rtw8822c_phy_pwrtrack_path(rtwdev, &swing_table, i);
+
+	if (rtw_phy_pwrtrack_need_iqk(rtwdev))
+		rtw8822c_do_iqk(rtwdev);
+}
+
+static void rtw8822c_pwrtrack_check(struct rtw_dev *rtwdev)
+{
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+
+	if (efuse->power_track_type != 0)
+		return;
+
+	if (!dm_info->pwrtrack_trigger) {
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_T_METER, BIT(19), 0x01);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_T_METER, BIT(19), 0x00);
+		rtw_write_rf(rtwdev, RF_PATH_A, RF_T_METER, BIT(19), 0x01);
+
+		rtw_write_rf(rtwdev, RF_PATH_B, RF_T_METER, BIT(19), 0x01);
+		rtw_write_rf(rtwdev, RF_PATH_B, RF_T_METER, BIT(19), 0x00);
+		rtw_write_rf(rtwdev, RF_PATH_B, RF_T_METER, BIT(19), 0x01);
+
+		dm_info->pwrtrack_trigger = true;
+		return;
+	}
+
+	rtw8822c_phy_pwrtrack(rtwdev);
+	dm_info->pwrtrack_trigger = false;
+}
+
 static struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8822c[] = {
 	{0x0086,
 	 RTW_PWR_CUT_ALL_MSK,
@@ -3572,6 +3677,7 @@ static struct rtw_chip_ops rtw8822c_ops = {
 	.dpk_track		= rtw8822c_dpk_track,
 	.phy_calibration	= rtw8822c_phy_calibration,
 	.cck_pd_set		= rtw8822c_phy_cck_pd_set,
+	.pwrtrack_check		= rtw8822c_pwrtrack_check,
 
 	.coex_set_init		= rtw8822c_coex_cfg_init,
 	.coex_set_ant_switch	= NULL,
@@ -3726,6 +3832,129 @@ static const struct coex_rf_para rf_para_rx_8822c[] = {
 
 static_assert(ARRAY_SIZE(rf_para_tx_8822c) == ARRAY_SIZE(rf_para_rx_8822c));
 
+static const u8
+rtw8822c_pwrtrk_5gb_n[RTW_PWRTRACK_5G_BAND_SIZE][RTW_PWRTRACK_TBL_SIZE] = {
+	{ 0,  1,  2,  3,  5,  6,  7,  8,  9, 10,
+	 11, 12, 13, 14, 15, 16, 18, 19, 20, 21,
+	 22, 23, 24, 25, 26, 27, 28, 29, 30, 32 },
+	{ 0,  1,  2,  3,  5,  6,  7,  8,  9, 10,
+	 11, 12, 13, 14, 15, 16, 18, 19, 20, 21,
+	 22, 23, 24, 25, 26, 27, 28, 29, 30, 32 },
+	{ 0,  1,  2,  3,  5,  6,  7,  8,  9, 10,
+	 11, 12, 13, 14, 15, 16, 18, 19, 20, 21,
+	 22, 23, 24, 25, 26, 27, 28, 29, 30, 32 },
+};
+
+static const u8
+rtw8822c_pwrtrk_5gb_p[RTW_PWRTRACK_5G_BAND_SIZE][RTW_PWRTRACK_TBL_SIZE] = {
+	{ 0,  1,  2,  3,  4,  5,  6,  7,  8,  9,
+	 10, 10, 11, 12, 13, 14, 15, 16, 17, 18,
+	 19, 20, 21, 22, 22, 23, 24, 25, 26, 27 },
+	{ 0,  1,  2,  3,  4,  5,  6,  7,  8,  9,
+	 10, 10, 11, 12, 13, 14, 15, 16, 17, 18,
+	 19, 20, 21, 22, 22, 23, 24, 25, 26, 27 },
+	{ 0,  1,  2,  3,  4,  5,  6,  7,  8,  9,
+	 10, 10, 11, 12, 13, 14, 15, 16, 17, 18,
+	 19, 20, 21, 22, 22, 23, 24, 25, 26, 27 },
+};
+
+static const u8
+rtw8822c_pwrtrk_5ga_n[RTW_PWRTRACK_5G_BAND_SIZE][RTW_PWRTRACK_TBL_SIZE] = {
+	{ 0,  1,  2,  4,  5,  6,  7,  8,  9, 10,
+	 11, 13, 14, 15, 16, 17, 18, 19, 20, 21,
+	 23, 24, 25, 26, 27, 28, 29, 30, 31, 33 },
+	{ 0,  1,  2,  4,  5,  6,  7,  8,  9, 10,
+	 11, 13, 14, 15, 16, 17, 18, 19, 20, 21,
+	 23, 24, 25, 26, 27, 28, 29, 30, 31, 33 },
+	{ 0,  1,  2,  4,  5,  6,  7,  8,  9, 10,
+	 11, 13, 14, 15, 16, 17, 18, 19, 20, 21,
+	 23, 24, 25, 26, 27, 28, 29, 30, 31, 33 },
+};
+
+static const u8
+rtw8822c_pwrtrk_5ga_p[RTW_PWRTRACK_5G_BAND_SIZE][RTW_PWRTRACK_TBL_SIZE] = {
+	{ 0,  1,  2,  3,  4,  5,  6,  7,  8,  9,
+	 10, 11, 12, 13, 14, 15, 16, 17, 18, 20,
+	 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 },
+	{ 0,  1,  2,  3,  4,  5,  6,  7,  8,  9,
+	 10, 11, 12, 13, 14, 15, 16, 17, 18, 20,
+	 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 },
+	{ 0,  1,  2,  3,  4,  5,  6,  7,  8,  9,
+	 10, 11, 12, 13, 14, 15, 16, 17, 18, 20,
+	 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 },
+};
+
+static const u8 rtw8822c_pwrtrk_2gb_n[RTW_PWRTRACK_TBL_SIZE] = {
+	 0,  1,  2,  3,  4,  4,  5,  6,  7,  8,
+	 9,  9, 10, 11, 12, 13, 14, 15, 15, 16,
+	17, 18, 19, 20, 20, 21, 22, 23, 24, 25
+};
+
+static const u8 rtw8822c_pwrtrk_2gb_p[RTW_PWRTRACK_TBL_SIZE] = {
+	 0,  1,  2,  3,  4,  5,  6,  7,  8,  9,
+	10, 11, 12, 13, 14, 14, 15, 16, 17, 18,
+	19, 20, 21, 22, 23, 24, 25, 26, 27, 28
+};
+
+static const u8 rtw8822c_pwrtrk_2ga_n[RTW_PWRTRACK_TBL_SIZE] = {
+	 0,  1,  2,  2,  3,  4,  4,  5,  6,  6,
+	 7,  8,  8,  9,  9, 10, 11, 11, 12, 13,
+	13, 14, 15, 15, 16, 17, 17, 18, 19, 19
+};
+
+static const u8 rtw8822c_pwrtrk_2ga_p[RTW_PWRTRACK_TBL_SIZE] = {
+	 0,  1,  2,  3,  4,  5,  6,  7,  8,  9,
+	10, 11, 11, 12, 13, 14, 15, 16, 17, 18,
+	19, 20, 21, 22, 23, 24, 25, 25, 26, 27
+};
+
+static const u8 rtw8822c_pwrtrk_2g_cck_b_n[RTW_PWRTRACK_TBL_SIZE] = {
+	 0,  1,  2,  3,  4,  5,  5,  6,  7,  8,
+	 9, 10, 11, 11, 12, 13, 14, 15, 16, 17,
+	17, 18, 19, 20, 21, 22, 23, 23, 24, 25
+};
+
+static const u8 rtw8822c_pwrtrk_2g_cck_b_p[RTW_PWRTRACK_TBL_SIZE] = {
+	 0,  1,  2,  3,  4,  5,  6,  7,  8,  9,
+	10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
+	20, 21, 22, 23, 24, 25, 26, 27, 28, 29
+};
+
+static const u8 rtw8822c_pwrtrk_2g_cck_a_n[RTW_PWRTRACK_TBL_SIZE] = {
+	 0,  1,  2,  3,  3,  4,  5,  6,  6,  7,
+	 8,  9,  9, 10, 11, 12, 12, 13, 14, 15,
+	15, 16, 17, 18, 18, 19, 20, 21, 21, 22
+};
+
+static const u8 rtw8822c_pwrtrk_2g_cck_a_p[RTW_PWRTRACK_TBL_SIZE] = {
+	 0,  1,  2,  3,  4,  5,  5,  6,  7,  8,
+	 9, 10, 11, 11, 12, 13, 14, 15, 16, 17,
+	 18, 18, 19, 20, 21, 22, 23, 24, 24, 25
+};
+
+static const struct rtw_pwr_track_tbl rtw8822c_rtw_pwr_track_tbl = {
+	.pwrtrk_5gb_n[0] = rtw8822c_pwrtrk_5gb_n[0],
+	.pwrtrk_5gb_n[1] = rtw8822c_pwrtrk_5gb_n[1],
+	.pwrtrk_5gb_n[2] = rtw8822c_pwrtrk_5gb_n[2],
+	.pwrtrk_5gb_p[0] = rtw8822c_pwrtrk_5gb_p[0],
+	.pwrtrk_5gb_p[1] = rtw8822c_pwrtrk_5gb_p[1],
+	.pwrtrk_5gb_p[2] = rtw8822c_pwrtrk_5gb_p[2],
+	.pwrtrk_5ga_n[0] = rtw8822c_pwrtrk_5ga_n[0],
+	.pwrtrk_5ga_n[1] = rtw8822c_pwrtrk_5ga_n[1],
+	.pwrtrk_5ga_n[2] = rtw8822c_pwrtrk_5ga_n[2],
+	.pwrtrk_5ga_p[0] = rtw8822c_pwrtrk_5ga_p[0],
+	.pwrtrk_5ga_p[1] = rtw8822c_pwrtrk_5ga_p[1],
+	.pwrtrk_5ga_p[2] = rtw8822c_pwrtrk_5ga_p[2],
+	.pwrtrk_2gb_n = rtw8822c_pwrtrk_2gb_n,
+	.pwrtrk_2gb_p = rtw8822c_pwrtrk_2gb_p,
+	.pwrtrk_2ga_n = rtw8822c_pwrtrk_2ga_n,
+	.pwrtrk_2ga_p = rtw8822c_pwrtrk_2ga_p,
+	.pwrtrk_2g_cckb_n = rtw8822c_pwrtrk_2g_cck_b_n,
+	.pwrtrk_2g_cckb_p = rtw8822c_pwrtrk_2g_cck_b_p,
+	.pwrtrk_2g_ccka_n = rtw8822c_pwrtrk_2g_cck_a_n,
+	.pwrtrk_2g_ccka_p = rtw8822c_pwrtrk_2g_cck_a_p,
+};
+
 struct rtw_chip_info rtw8822c_hw_spec = {
 	.ops = &rtw8822c_ops,
 	.id = RTW_CHIP_TYPE_8822C,
@@ -3767,6 +3996,8 @@ struct rtw_chip_info rtw8822c_hw_spec = {
 	.rfe_defs_size = ARRAY_SIZE(rtw8822c_rfe_defs),
 	.en_dis_dpd = true,
 	.dpd_ratemask = DIS_DPD_RATEALL,
+	.pwr_track_tbl = &rtw8822c_rtw_pwr_track_tbl,
+	.iqk_threshold = 8,
 
 	.coex_para_ver = 0x19062706,
 	.bt_desired_ver = 0x6,
-- 
2.17.1

