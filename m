Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F55F849D9
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2019 12:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfHGKk3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Aug 2019 06:40:29 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:56222 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbfHGKk1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Aug 2019 06:40:27 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x77AeHDv010068, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x77AeHDv010068
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 7 Aug 2019 18:40:17 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.439.0; Wed, 7 Aug 2019 18:40:17 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <sgruszka@redhat.com>
Subject: [PATCH 7/8] rtw88: add dynamic cck pd mechanism
Date:   Wed, 7 Aug 2019 18:40:04 +0800
Message-ID: <1565174405-2689-8-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565174405-2689-1-git-send-email-yhchuang@realtek.com>
References: <1565174405-2689-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

This mechanism reduces the numbers of false alram in cck rate by
dynamically adjusting the value of power threshold and cs_ratio.
We determine the new value by three factors, which are rssi, false alarm
count and igi. Based on these factors, we define the current condition
into five levels. Compared to the previous level, if the level is changed,
we set the new values for power threshold and cs_ratio.

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.h     | 17 +++++
 drivers/net/wireless/realtek/rtw88/phy.c      | 93 +++++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/phy.h      |  2 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 76 ++++++++++++++++++++++
 4 files changed, 188 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 76d9253..bede3f3 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -642,6 +642,7 @@ struct rtw_chip_ops {
 	void (*false_alarm_statistics)(struct rtw_dev *rtwdev);
 	void (*phy_calibration)(struct rtw_dev *rtwdev);
 	void (*dpk_track)(struct rtw_dev *rtwdev);
+	void (*cck_pd_set)(struct rtw_dev *rtwdev, u8 level);
 
 	/* for coex */
 	void (*coex_set_init)(struct rtw_dev *rtwdev);
@@ -1110,6 +1111,13 @@ struct rtw_dpk_info {
 	u8 dpk_bw;
 };
 
+struct rtw_phy_cck_pd_reg {
+	u32 reg_pd;
+	u32 mask_pd;
+	u32 reg_cs;
+	u32 mask_cs;
+};
+
 #define DACK_MSBK_BACKUP_NUM	0xf
 #define DACK_DCK_BACKUP_NUM	0x2
 
@@ -1145,6 +1153,10 @@ struct rtw_dm_info {
 	u8 dack_dck[RTW_RF_PATH_MAX][2][DACK_DCK_BACKUP_NUM];
 
 	struct rtw_dpk_info dpk_info;
+
+	/* [bandwidth 0:20M/1:40M][number of path] */
+	u8 cck_pd_lv[2][RTW_RF_PATH_MAX];
+	u32 cck_fa_avg;
 };
 
 struct rtw_efuse {
@@ -1381,6 +1393,11 @@ static inline void rtw_flag_set(struct rtw_dev *rtwdev, enum rtw_flags flag)
 	set_bit(flag, rtwdev->flags);
 }
 
+static inline bool rtw_is_assoc(struct rtw_dev *rtwdev)
+{
+	return !!rtwdev->sta_cnt;
+}
+
 void rtw_get_channel_params(struct cfg80211_chan_def *chandef,
 			    struct rtw_channel_params *ch_param);
 bool check_hw_ready(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 target);
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index ec0de49..6042341 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -111,6 +111,19 @@ enum rtw_phy_band_type {
 	PHY_BAND_5G	= 1,
 };
 
+static void rtw_phy_cck_pd_init(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u8 i, j;
+
+	for (i = 0; i <= RTW_CHANNEL_WIDTH_40; i++) {
+		for (j = 0; j < RTW_RF_PATH_MAX; j++)
+			dm_info->cck_pd_lv[i][j] = 0;
+	}
+
+	dm_info->cck_fa_avg = CCK_FA_AVG_RESET;
+}
+
 void rtw_phy_init(struct rtw_dev *rtwdev)
 {
 	struct rtw_chip_info *chip = rtwdev->chip;
@@ -129,6 +142,7 @@ void rtw_phy_init(struct rtw_dev *rtwdev)
 	addr = chip->dig[0].addr;
 	mask = chip->dig[0].mask;
 	dm_info->igi_history[0] = rtw_read32_mask(rtwdev, addr, mask);
+	rtw_phy_cck_pd_init(rtwdev);
 }
 
 void rtw_phy_dig_write(struct rtw_dev *rtwdev, u8 igi)
@@ -447,11 +461,90 @@ static void rtw_phy_dpk_track(struct rtw_dev *rtwdev)
 		chip->ops->dpk_track(rtwdev);
 }
 
+#define CCK_PD_LV_MAX		5
+#define CCK_PD_FA_LV1_MIN	1000
+#define CCK_PD_FA_LV0_MAX	500
+
+static u8 rtw_phy_cck_pd_lv_unlink(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u32 cck_fa_avg = dm_info->cck_fa_avg;
+
+	if (cck_fa_avg > CCK_PD_FA_LV1_MIN)
+		return 1;
+
+	if (cck_fa_avg < CCK_PD_FA_LV0_MAX)
+		return 0;
+
+	return CCK_PD_LV_MAX;
+}
+
+#define CCK_PD_IGI_LV4_VAL 0x38
+#define CCK_PD_IGI_LV3_VAL 0x2a
+#define CCK_PD_IGI_LV2_VAL 0x24
+#define CCK_PD_RSSI_LV4_VAL 32
+#define CCK_PD_RSSI_LV3_VAL 32
+#define CCK_PD_RSSI_LV2_VAL 24
+
+static u8 rtw_phy_cck_pd_lv_link(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u8 igi = dm_info->igi_history[0];
+	u8 rssi = dm_info->min_rssi;
+	u32 cck_fa_avg = dm_info->cck_fa_avg;
+
+	if (igi > CCK_PD_IGI_LV4_VAL && rssi > CCK_PD_RSSI_LV4_VAL)
+		return 4;
+	if (igi > CCK_PD_IGI_LV3_VAL && rssi > CCK_PD_RSSI_LV3_VAL)
+		return 3;
+	if (igi > CCK_PD_IGI_LV2_VAL || rssi > CCK_PD_RSSI_LV2_VAL)
+		return 2;
+	if (cck_fa_avg > CCK_PD_FA_LV1_MIN)
+		return 1;
+	if (cck_fa_avg < CCK_PD_FA_LV0_MAX)
+		return 0;
+
+	return CCK_PD_LV_MAX;
+}
+
+static u8 rtw_phy_cck_pd_lv(struct rtw_dev *rtwdev)
+{
+	if (!rtw_is_assoc(rtwdev))
+		return rtw_phy_cck_pd_lv_unlink(rtwdev);
+	else
+		return rtw_phy_cck_pd_lv_link(rtwdev);
+}
+
+static void rtw_phy_cck_pd(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u32 cck_fa = dm_info->cck_fa_cnt;
+	u8 level;
+
+	if (rtwdev->hal.current_band_type != RTW_BAND_2G)
+		return;
+
+	if (dm_info->cck_fa_avg == CCK_FA_AVG_RESET)
+		dm_info->cck_fa_avg = cck_fa;
+	else
+		dm_info->cck_fa_avg = (dm_info->cck_fa_avg * 3 + cck_fa) >> 2;
+
+	level = rtw_phy_cck_pd_lv(rtwdev);
+
+	if (level >= CCK_PD_LV_MAX)
+		return;
+
+	if (chip->ops->cck_pd_set)
+		chip->ops->cck_pd_set(rtwdev, level);
+}
+
 void rtw_phy_dynamic_mechanism(struct rtw_dev *rtwdev)
 {
 	/* for further calculation */
 	rtw_phy_statistics(rtwdev);
 	rtw_phy_dig(rtwdev);
+	rtw_phy_cck_pd(rtwdev);
 	rtw_phy_ra_info_update(rtwdev);
 	rtw_phy_dpk_track(rtwdev);
 }
diff --git a/drivers/net/wireless/realtek/rtw88/phy.h b/drivers/net/wireless/realtek/rtw88/phy.h
index cc87b15..e79b084 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.h
+++ b/drivers/net/wireless/realtek/rtw88/phy.h
@@ -146,4 +146,6 @@ rtw_get_tx_power_params(struct rtw_dev *rtwdev, u8 path,
 #define MASKBYTE3LOWNIBBLE	0x0f000000
 #define	MASKL3BYTES		0x00ffffff
 
+#define CCK_FA_AVG_RESET 0xffffffff
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 5a428e0..f28563d 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -3116,6 +3116,81 @@ void rtw8822c_dpk_track(struct rtw_dev *rtwdev)
 	}
 }
 
+static const struct rtw_phy_cck_pd_reg
+rtw8822c_cck_pd_reg[RTW_CHANNEL_WIDTH_40 + 1][RTW_RF_PATH_MAX] = {
+	{
+		{0x1ac8, 0x00ff, 0x1ad0, 0x01f},
+		{0x1ac8, 0xff00, 0x1ad0, 0x3e0}
+	},
+	{
+		{0x1acc, 0x00ff, 0x1ad0, 0x01F00000},
+		{0x1acc, 0xff00, 0x1ad0, 0x3E000000}
+	},
+};
+
+#define RTW_CCK_PD_MAX 255
+#define RTW_CCK_CS_MAX 31
+#define RTW_CCK_CS_ERR1 27
+#define RTW_CCK_CS_ERR2 29
+static void
+rtw8822c_phy_cck_pd_set_reg(struct rtw_dev *rtwdev,
+			    s8 pd_diff, s8 cs_diff, u8 bw, u8 nrx)
+{
+	u32 pd, cs;
+
+	if (WARN_ON(bw > RTW_CHANNEL_WIDTH_40 || nrx >= RTW_RF_PATH_MAX))
+		return;
+
+	pd = rtw_read32_mask(rtwdev,
+			     rtw8822c_cck_pd_reg[bw][nrx].reg_pd,
+			     rtw8822c_cck_pd_reg[bw][nrx].mask_pd);
+	cs = rtw_read32_mask(rtwdev,
+			     rtw8822c_cck_pd_reg[bw][nrx].reg_cs,
+			     rtw8822c_cck_pd_reg[bw][nrx].mask_cs);
+	pd += pd_diff;
+	cs += cs_diff;
+	if (pd > RTW_CCK_PD_MAX)
+		pd = RTW_CCK_PD_MAX;
+	if (cs == RTW_CCK_CS_ERR1 || cs == RTW_CCK_CS_ERR2)
+		cs++;
+	else if (cs > RTW_CCK_CS_MAX)
+		cs = RTW_CCK_CS_MAX;
+	rtw_write32_mask(rtwdev,
+			 rtw8822c_cck_pd_reg[bw][nrx].reg_pd,
+			 rtw8822c_cck_pd_reg[bw][nrx].mask_pd,
+			 pd);
+	rtw_write32_mask(rtwdev,
+			 rtw8822c_cck_pd_reg[bw][nrx].reg_cs,
+			 rtw8822c_cck_pd_reg[bw][nrx].mask_cs,
+			 cs);
+}
+
+static void rtw8822c_phy_cck_pd_set(struct rtw_dev *rtwdev, u8 new_lvl)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	s8 pd_lvl[4] = {2, 4, 6, 8};
+	s8 cs_lvl[4] = {2, 2, 2, 4};
+	u8 cur_lvl;
+	u8 nrx, bw;
+
+	nrx = (u8)rtw_read32_mask(rtwdev, 0x1a2c, 0x60000);
+	bw = (u8)rtw_read32_mask(rtwdev, 0x9b0, 0xc);
+
+	if (dm_info->cck_pd_lv[bw][nrx] == new_lvl)
+		return;
+
+	cur_lvl = dm_info->cck_pd_lv[bw][nrx];
+
+	/* update cck pd info */
+	dm_info->cck_fa_avg = CCK_FA_AVG_RESET;
+
+	rtw8822c_phy_cck_pd_set_reg(rtwdev,
+				    pd_lvl[new_lvl] - pd_lvl[cur_lvl],
+				    cs_lvl[new_lvl] - cs_lvl[cur_lvl],
+				    bw, nrx);
+	dm_info->cck_pd_lv[bw][nrx] = new_lvl;
+}
+
 static struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8822c[] = {
 	{0x0086,
 	 RTW_PWR_CUT_ALL_MSK,
@@ -3495,6 +3570,7 @@ static struct rtw_chip_ops rtw8822c_ops = {
 	.false_alarm_statistics	= rtw8822c_false_alarm_statistics,
 	.dpk_track		= rtw8822c_dpk_track,
 	.phy_calibration	= rtw8822c_phy_calibration,
+	.cck_pd_set		= rtw8822c_phy_cck_pd_set,
 
 	.coex_set_init		= rtw8822c_coex_cfg_init,
 	.coex_set_ant_switch	= NULL,
-- 
2.7.4

