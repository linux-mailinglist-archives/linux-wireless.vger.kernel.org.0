Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD351ECCCE
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2020 11:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgFCJmi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jun 2020 05:42:38 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:42390 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgFCJmh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jun 2020 05:42:37 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 0539gNEU1012446, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 0539gNEU1012446
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 3 Jun 2020 17:42:23 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 3 Jun 2020 17:42:23 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 3 Jun 2020 17:42:23 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <tehuang@realtek.com>,
        <bigeasy@linutronix.de>
Subject: [PATCH v2 2/5] rtw88: 8821c: add power tracking
Date:   Wed, 3 Jun 2020 17:42:15 +0800
Message-ID: <20200603094218.19942-3-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603094218.19942-1-yhchuang@realtek.com>
References: <20200603094218.19942-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

The TX power requires to be adjusted based on the thermal value.
The actual power will decrease if the thermal value raised, and
will increase if the thermal value lowered. Driver comapres the
thermal value, as moving averages. If it changes over a limit,
driver will modify the TX power index to compensate.

Implement rtw_chip_ops::pwr_track() for 8821c.

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.h     |   1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 291 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8821c.h |   1 +
 3 files changed, 293 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 605a70e311fc..776ec0590aba 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1466,6 +1466,7 @@ struct rtw_dm_info {
 	u8 thermal_avg[RTW_RF_PATH_MAX];
 	u8 thermal_meter_k;
 	s8 delta_power_index[RTW_RF_PATH_MAX];
+	s8 delta_power_index_last[RTW_RF_PATH_MAX];
 	u8 default_ofdm_index;
 	bool pwr_trk_triggered;
 	bool pwr_trk_init_trigger;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 904eb494ccad..aa2457046ad1 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -61,6 +61,46 @@ static int rtw8821c_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
 	return 0;
 }
 
+static const u32 rtw8821c_txscale_tbl[] = {
+	0x081, 0x088, 0x090, 0x099, 0x0a2, 0x0ac, 0x0b6, 0x0c0, 0x0cc, 0x0d8,
+	0x0e5, 0x0f2, 0x101, 0x110, 0x120, 0x131, 0x143, 0x156, 0x16a, 0x180,
+	0x197, 0x1af, 0x1c8, 0x1e3, 0x200, 0x21e, 0x23e, 0x261, 0x285, 0x2ab,
+	0x2d3, 0x2fe, 0x32b, 0x35c, 0x38e, 0x3c4, 0x3fe
+};
+
+static const u8 rtw8821c_get_swing_index(struct rtw_dev *rtwdev)
+{
+	u8 i = 0;
+	u32 swing, table_value;
+
+	swing = rtw_read32_mask(rtwdev, REG_TXSCALE_A, 0xffe00000);
+	for (i = 0; i < ARRAY_SIZE(rtw8821c_txscale_tbl); i++) {
+		table_value = rtw8821c_txscale_tbl[i];
+		if (swing == table_value)
+			break;
+	}
+
+	return i;
+}
+
+static void rtw8821c_pwrtrack_init(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u8 swing_idx = rtw8821c_get_swing_index(rtwdev);
+
+	if (swing_idx >= ARRAY_SIZE(rtw8821c_txscale_tbl))
+		dm_info->default_ofdm_index = 24;
+	else
+		dm_info->default_ofdm_index = swing_idx;
+
+	ewma_thermal_init(&dm_info->avg_thermal[RF_PATH_A]);
+	dm_info->delta_power_index[RF_PATH_A] = 0;
+	dm_info->delta_power_index_last[RF_PATH_A] = 0;
+	dm_info->pwr_trk_triggered = false;
+	dm_info->pwr_trk_init_trigger = true;
+	dm_info->thermal_meter_k = rtwdev->efuse.thermal_meter_k;
+}
+
 static void rtw8821c_phy_set_param(struct rtw_dev *rtwdev)
 {
 	u8 crystal_cap, val;
@@ -103,6 +143,8 @@ static void rtw8821c_phy_set_param(struct rtw_dev *rtwdev)
 
 	rtw_phy_init(rtwdev);
 	rtwdev->dm_info.cck_pd_default = rtw_read8(rtwdev, REG_CSRATIO) & 0x1f;
+
+	rtw8821c_pwrtrack_init(rtwdev);
 }
 
 static int rtw8821c_mac_init(struct rtw_dev *rtwdev)
@@ -362,6 +404,7 @@ static void rtw8821c_set_channel_bb_swing(struct rtw_dev *rtwdev, u8 channel,
 {
 	rtw_write32_mask(rtwdev, REG_TXSCALE_A, GENMASK(31, 21),
 			 rtw8821c_get_bb_swing(rtwdev, channel));
+	rtw8821c_pwrtrack_init(rtwdev);
 }
 
 static void rtw8821c_set_channel(struct rtw_dev *rtwdev, u8 channel, u8 bw,
@@ -597,6 +640,152 @@ static void rtw8821c_phy_calibration(struct rtw_dev *rtwdev)
 	rtw8821c_do_iqk(rtwdev);
 }
 
+static void
+rtw8821c_txagc_swing_offset(struct rtw_dev *rtwdev, u8 pwr_idx_offset,
+			    s8 pwr_idx_offset_lower,
+			    s8 *txagc_idx, u8 *swing_idx)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	s8 delta_pwr_idx = dm_info->delta_power_index[RF_PATH_A];
+	u8 swing_upper_bound = dm_info->default_ofdm_index + 10;
+	u8 swing_lower_bound = 0;
+	u8 max_pwr_idx_offset = 0xf;
+	s8 agc_index = 0;
+	u8 swing_index = dm_info->default_ofdm_index;
+
+	pwr_idx_offset = min_t(u8, pwr_idx_offset, max_pwr_idx_offset);
+	pwr_idx_offset_lower = max_t(s8, pwr_idx_offset_lower, -15);
+
+	if (delta_pwr_idx >= 0) {
+		if (delta_pwr_idx <= pwr_idx_offset) {
+			agc_index = delta_pwr_idx;
+			swing_index = dm_info->default_ofdm_index;
+		} else if (delta_pwr_idx > pwr_idx_offset) {
+			agc_index = pwr_idx_offset;
+			swing_index = dm_info->default_ofdm_index +
+					delta_pwr_idx - pwr_idx_offset;
+			swing_index = min_t(u8, swing_index, swing_upper_bound);
+		}
+	} else if (delta_pwr_idx < 0) {
+		if (delta_pwr_idx >= pwr_idx_offset_lower) {
+			agc_index = delta_pwr_idx;
+			swing_index = dm_info->default_ofdm_index;
+		} else if (delta_pwr_idx < pwr_idx_offset_lower) {
+			if (dm_info->default_ofdm_index >
+				(pwr_idx_offset_lower - delta_pwr_idx))
+				swing_index = dm_info->default_ofdm_index +
+					delta_pwr_idx - pwr_idx_offset_lower;
+			else
+				swing_index = swing_lower_bound;
+
+			agc_index = pwr_idx_offset_lower;
+		}
+	}
+
+	if (swing_index >= ARRAY_SIZE(rtw8821c_txscale_tbl)) {
+		rtw_warn(rtwdev, "swing index overflow\n");
+		swing_index = ARRAY_SIZE(rtw8821c_txscale_tbl) - 1;
+	}
+
+	*txagc_idx = agc_index;
+	*swing_idx = swing_index;
+}
+
+static void rtw8821c_pwrtrack_set_pwr(struct rtw_dev *rtwdev, u8 pwr_idx_offset,
+				      s8 pwr_idx_offset_lower)
+{
+	s8 txagc_idx;
+	u8 swing_idx;
+
+	rtw8821c_txagc_swing_offset(rtwdev, pwr_idx_offset, pwr_idx_offset_lower,
+				    &txagc_idx, &swing_idx);
+	rtw_write32_mask(rtwdev, REG_TXAGCIDX, GENMASK(6, 1), txagc_idx);
+	rtw_write32_mask(rtwdev, REG_TXSCALE_A, GENMASK(31, 21),
+			 rtw8821c_txscale_tbl[swing_idx]);
+}
+
+static void rtw8821c_pwrtrack_set(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u8 pwr_idx_offset, tx_pwr_idx;
+	s8 pwr_idx_offset_lower;
+	u8 channel = rtwdev->hal.current_channel;
+	u8 band_width = rtwdev->hal.current_band_width;
+	u8 regd = rtwdev->regd.txpwr_regd;
+	u8 tx_rate = dm_info->tx_rate;
+	u8 max_pwr_idx = rtwdev->chip->max_power_index;
+
+	tx_pwr_idx = rtw_phy_get_tx_power_index(rtwdev, RF_PATH_A, tx_rate,
+						band_width, channel, regd);
+
+	tx_pwr_idx = min_t(u8, tx_pwr_idx, max_pwr_idx);
+
+	pwr_idx_offset = max_pwr_idx - tx_pwr_idx;
+	pwr_idx_offset_lower = 0 - tx_pwr_idx;
+
+	rtw8821c_pwrtrack_set_pwr(rtwdev, pwr_idx_offset, pwr_idx_offset_lower);
+}
+
+static void rtw8821c_phy_pwrtrack(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	struct rtw_swing_table swing_table;
+	u8 thermal_value, delta;
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
+	dm_info->delta_power_index[RF_PATH_A] =
+		rtw_phy_pwrtrack_get_pwridx(rtwdev, &swing_table, RF_PATH_A,
+					    RF_PATH_A, delta);
+	if (dm_info->delta_power_index[RF_PATH_A] ==
+			dm_info->delta_power_index_last[RF_PATH_A])
+		goto iqk;
+	else
+		dm_info->delta_power_index_last[RF_PATH_A] =
+			dm_info->delta_power_index[RF_PATH_A];
+	rtw8821c_pwrtrack_set(rtwdev);
+
+iqk:
+	if (rtw_phy_pwrtrack_need_iqk(rtwdev))
+		rtw8821c_do_iqk(rtwdev);
+}
+
+static void rtw8821c_pwr_track(struct rtw_dev *rtwdev)
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
+	rtw8821c_phy_pwrtrack(rtwdev);
+	dm_info->pwr_trk_triggered = false;
+}
+
 static void rtw8821c_phy_cck_pd_set(struct rtw_dev *rtwdev, u8 new_lvl)
 {
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
@@ -1060,6 +1249,106 @@ static struct rtw_chip_ops rtw8821c_ops = {
 	.false_alarm_statistics	= rtw8821c_false_alarm_statistics,
 	.phy_calibration	= rtw8821c_phy_calibration,
 	.cck_pd_set		= rtw8821c_phy_cck_pd_set,
+	.pwr_track		= rtw8821c_pwr_track,
+};
+
+static const u8 rtw8821c_pwrtrk_5gb_n[][RTW_PWR_TRK_TBL_SZ] = {
+	{0, 1, 1, 2, 3, 3, 3, 4, 4, 5, 5, 6, 6, 6, 7, 8, 8, 8, 9, 9, 9, 10, 10,
+	 11, 11, 12, 12, 12, 12, 12},
+	{0, 1, 1, 1, 2, 3, 3, 4, 4, 5, 5, 5, 6, 6, 7, 8, 8, 9, 9, 10, 10, 11,
+	 11, 12, 12, 12, 12, 12, 12, 12},
+	{0, 1, 2, 2, 3, 4, 4, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 9, 10, 10, 11,
+	 11, 12, 12, 12, 12, 12, 12},
+};
+
+static const u8 rtw8821c_pwrtrk_5gb_p[][RTW_PWR_TRK_TBL_SZ] = {
+	{0, 1, 1, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 11, 11,
+	 12, 12, 12, 12, 12, 12, 12},
+	{0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 5, 6, 7, 7, 8, 8, 9, 10, 10, 11, 11,
+	 12, 12, 12, 12, 12, 12, 12, 12},
+	{0, 1, 1, 1, 2, 3, 3, 3, 4, 4, 4, 5, 6, 6, 7, 7, 8, 8, 9, 10, 10, 11,
+	 11, 12, 12, 12, 12, 12, 12, 12},
+};
+
+static const u8 rtw8821c_pwrtrk_5ga_n[][RTW_PWR_TRK_TBL_SZ] = {
+	{0, 1, 1, 2, 3, 3, 3, 4, 4, 5, 5, 6, 6, 6, 7, 8, 8, 8, 9, 9, 9, 10, 10,
+	 11, 11, 12, 12, 12, 12, 12},
+	{0, 1, 1, 1, 2, 3, 3, 4, 4, 5, 5, 5, 6, 6, 7, 8, 8, 9, 9, 10, 10, 11,
+	 11, 12, 12, 12, 12, 12, 12, 12},
+	{0, 1, 2, 2, 3, 4, 4, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 9, 10, 10, 11,
+	 11, 12, 12, 12, 12, 12, 12},
+};
+
+static const u8 rtw8821c_pwrtrk_5ga_p[][RTW_PWR_TRK_TBL_SZ] = {
+	{0, 1, 1, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 11, 11,
+	 12, 12, 12, 12, 12, 12, 12},
+	{0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 5, 6, 7, 7, 8, 8, 9, 10, 10, 11, 11,
+	 12, 12, 12, 12, 12, 12, 12, 12},
+	{0, 1, 1, 1, 2, 3, 3, 3, 4, 4, 4, 5, 6, 6, 7, 7, 8, 8, 9, 10, 10, 11,
+	 11, 12, 12, 12, 12, 12, 12, 12},
+};
+
+static const u8 rtw8821c_pwrtrk_2gb_n[] = {
+	0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4,
+	4, 4, 5, 5, 5, 5, 6, 6, 6, 7, 7, 8, 8, 9
+};
+
+static const u8 rtw8821c_pwrtrk_2gb_p[] = {
+	0, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 5, 5,
+	5, 5, 6, 6, 6, 7, 7, 7, 8, 8, 9, 9, 9, 9
+};
+
+static const u8 rtw8821c_pwrtrk_2ga_n[] = {
+	0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4,
+	4, 4, 5, 5, 5, 5, 6, 6, 6, 7, 7, 8, 8, 9
+};
+
+static const u8 rtw8821c_pwrtrk_2ga_p[] = {
+	0, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 5, 5,
+	5, 5, 6, 6, 6, 7, 7, 7, 8, 8, 9, 9, 9, 9
+};
+
+static const u8 rtw8821c_pwrtrk_2g_cck_b_n[] = {
+	0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4,
+	4, 5, 5, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 9
+};
+
+static const u8 rtw8821c_pwrtrk_2g_cck_b_p[] = {
+	0, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5,
+	5, 6, 6, 7, 7, 7, 8, 8, 9, 9, 9, 9, 9, 9
+};
+
+static const u8 rtw8821c_pwrtrk_2g_cck_a_n[] = {
+	0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4,
+	4, 5, 5, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 9
+};
+
+static const u8 rtw8821c_pwrtrk_2g_cck_a_p[] = {
+	0, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5,
+	5, 6, 6, 7, 7, 7, 8, 8, 9, 9, 9, 9, 9, 9
+};
+
+const struct rtw_pwr_track_tbl rtw8821c_rtw_pwr_track_tbl = {
+	.pwrtrk_5gb_n[0] = rtw8821c_pwrtrk_5gb_n[0],
+	.pwrtrk_5gb_n[1] = rtw8821c_pwrtrk_5gb_n[1],
+	.pwrtrk_5gb_n[2] = rtw8821c_pwrtrk_5gb_n[2],
+	.pwrtrk_5gb_p[0] = rtw8821c_pwrtrk_5gb_p[0],
+	.pwrtrk_5gb_p[1] = rtw8821c_pwrtrk_5gb_p[1],
+	.pwrtrk_5gb_p[2] = rtw8821c_pwrtrk_5gb_p[2],
+	.pwrtrk_5ga_n[0] = rtw8821c_pwrtrk_5ga_n[0],
+	.pwrtrk_5ga_n[1] = rtw8821c_pwrtrk_5ga_n[1],
+	.pwrtrk_5ga_n[2] = rtw8821c_pwrtrk_5ga_n[2],
+	.pwrtrk_5ga_p[0] = rtw8821c_pwrtrk_5ga_p[0],
+	.pwrtrk_5ga_p[1] = rtw8821c_pwrtrk_5ga_p[1],
+	.pwrtrk_5ga_p[2] = rtw8821c_pwrtrk_5ga_p[2],
+	.pwrtrk_2gb_n = rtw8821c_pwrtrk_2gb_n,
+	.pwrtrk_2gb_p = rtw8821c_pwrtrk_2gb_p,
+	.pwrtrk_2ga_n = rtw8821c_pwrtrk_2ga_n,
+	.pwrtrk_2ga_p = rtw8821c_pwrtrk_2ga_p,
+	.pwrtrk_2g_cckb_n = rtw8821c_pwrtrk_2g_cck_b_n,
+	.pwrtrk_2g_cckb_p = rtw8821c_pwrtrk_2g_cck_b_p,
+	.pwrtrk_2g_ccka_n = rtw8821c_pwrtrk_2g_cck_a_n,
+	.pwrtrk_2g_ccka_p = rtw8821c_pwrtrk_2g_cck_a_p,
 };
 
 struct rtw_chip_info rtw8821c_hw_spec = {
@@ -1104,6 +1393,8 @@ struct rtw_chip_info rtw8821c_hw_spec = {
 	.rfe_defs = rtw8821c_rfe_defs,
 	.rfe_defs_size = ARRAY_SIZE(rtw8821c_rfe_defs),
 	.rx_ldpc = false,
+	.pwr_track_tbl = &rtw8821c_rtw_pwr_track_tbl,
+	.iqk_threshold = 8,
 };
 EXPORT_SYMBOL(rtw8821c_hw_spec);
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.h b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
index bc66b91cd961..166bd0e9294e 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
@@ -200,6 +200,7 @@ _rtw_write32s_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 data)
 #define REG_TXSCALE_A	0xc1c
 #define REG_TXDFIR	0xc20
 #define REG_RXIGI_A	0xc50
+#define REG_TXAGCIDX	0xc94
 #define REG_TRSW	0xca0
 #define REG_RFESEL0	0xcb0
 #define REG_RFESEL8	0xcb4
-- 
2.17.1

