Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA66341500
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Mar 2021 06:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbhCSFnc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Mar 2021 01:43:32 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:39729 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbhCSFnW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Mar 2021 01:43:22 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 12J5hGvY5007732, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 12J5hGvY5007732
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 19 Mar 2021 13:43:16 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 19 Mar
 2021 13:43:16 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <ku920601@realtek.com>,
        <phhuang@realtek.com>, <shaofu@realtek.com>,
        <steventing@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 5/7] rtw88: 8822c: add LC calibration for RTL8822C
Date:   Fri, 19 Mar 2021 13:42:16 +0800
Message-ID: <20210319054218.3319-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210319054218.3319-1-pkshih@realtek.com>
References: <20210319054218.3319-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXMBS03.realtek.com.tw (172.21.6.96) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Fix power tracking issue by replacing unnecessary IQ calibration
with LC calibration.
When thermal difference exceeds limitation, let RF circuit adjsut
its characteristic to fit in current environment.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.h     |  2 ++
 drivers/net/wireless/realtek/rtw88/phy.c      | 14 ++++++++++
 drivers/net/wireless/realtek/rtw88/phy.h      |  1 +
 drivers/net/wireless/realtek/rtw88/reg.h      |  5 ++++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 27 +++++++++++++++++--
 5 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index e01eb7feed4e..4be1c8b3b83c 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1168,6 +1168,7 @@ struct rtw_chip_info {
 	bool en_dis_dpd;
 	u16 dpd_ratemask;
 	u8 iqk_threshold;
+	u8 lck_threshold;
 	const struct rtw_pwr_track_tbl *pwr_track_tbl;
 
 	u8 bfer_su_max_num;
@@ -1536,6 +1537,7 @@ struct rtw_dm_info {
 	u32 rrsr_mask_min;
 	u8 thermal_avg[RTW_RF_PATH_MAX];
 	u8 thermal_meter_k;
+	u8 thermal_meter_lck;
 	s8 delta_power_index[RTW_RF_PATH_MAX];
 	s8 delta_power_index_last[RTW_RF_PATH_MAX];
 	u8 default_ofdm_index;
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index f96edc049718..b3c0a38771a7 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -2220,6 +2220,20 @@ s8 rtw_phy_pwrtrack_get_pwridx(struct rtw_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw_phy_pwrtrack_get_pwridx);
 
+bool rtw_phy_pwrtrack_need_lck(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u8 delta_lck;
+
+	delta_lck = abs(dm_info->thermal_avg[0] - dm_info->thermal_meter_lck);
+	if (delta_lck >= rtwdev->chip->lck_threshold) {
+		dm_info->thermal_meter_lck = dm_info->thermal_avg[0];
+		return true;
+	}
+	return false;
+}
+EXPORT_SYMBOL(rtw_phy_pwrtrack_need_lck);
+
 bool rtw_phy_pwrtrack_need_iqk(struct rtw_dev *rtwdev)
 {
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
diff --git a/drivers/net/wireless/realtek/rtw88/phy.h b/drivers/net/wireless/realtek/rtw88/phy.h
index a4fcfb878550..a0742a69446d 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.h
+++ b/drivers/net/wireless/realtek/rtw88/phy.h
@@ -55,6 +55,7 @@ u8 rtw_phy_pwrtrack_get_delta(struct rtw_dev *rtwdev, u8 path);
 s8 rtw_phy_pwrtrack_get_pwridx(struct rtw_dev *rtwdev,
 			       struct rtw_swing_table *swing_table,
 			       u8 tbl_path, u8 therm_path, u8 delta);
+bool rtw_phy_pwrtrack_need_lck(struct rtw_dev *rtwdev);
 bool rtw_phy_pwrtrack_need_iqk(struct rtw_dev *rtwdev);
 void rtw_phy_config_swing_table(struct rtw_dev *rtwdev,
 				struct rtw_swing_table *swing_table);
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index e3a981ad01a6..a85fe29f13f7 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -653,8 +653,13 @@
 #define RF_TXATANK	0x64
 #define RF_TRXIQ	0x66
 #define RF_RXIQGEN	0x8d
+#define RF_SYN_PFD	0xb0
 #define RF_XTALX2	0xb8
+#define RF_SYN_CTRL	0xbb
 #define RF_MALSEL	0xbe
+#define RF_SYN_AAC	0xc9
+#define RF_AAC_CTRL	0xca
+#define RF_FAST_LCK	0xcc
 #define RF_RCKD		0xde
 #define RF_TXADBG	0xde
 #define RF_LUTDBG	0xdf
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index a1f1da3db029..9453a20f966a 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -1126,6 +1126,7 @@ static void rtw8822c_pwrtrack_init(struct rtw_dev *rtwdev)
 
 	dm_info->pwr_trk_triggered = false;
 	dm_info->thermal_meter_k = rtwdev->efuse.thermal_meter_k;
+	dm_info->thermal_meter_lck = rtwdev->efuse.thermal_meter_k;
 }
 
 static void rtw8822c_phy_set_param(struct rtw_dev *rtwdev)
@@ -2117,6 +2118,26 @@ static void rtw8822c_false_alarm_statistics(struct rtw_dev *rtwdev)
 	rtw_write32_set(rtwdev, REG_RX_BREAK, BIT_COM_RX_GCK_EN);
 }
 
+static void rtw8822c_do_lck(struct rtw_dev *rtwdev)
+{
+	u32 val;
+
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_SYN_CTRL, RFREG_MASK, 0x80010);
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_SYN_PFD, RFREG_MASK, 0x1F0FA);
+	fsleep(1);
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_AAC_CTRL, RFREG_MASK, 0x80000);
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_SYN_AAC, RFREG_MASK, 0x80001);
+	read_poll_timeout(rtw_read_rf, val, val != 0x1, 1000, 100000,
+			  true, rtwdev, RF_PATH_A, RF_AAC_CTRL, 0x1000);
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_SYN_PFD, RFREG_MASK, 0x1F0F8);
+	rtw_write_rf(rtwdev, RF_PATH_B, RF_SYN_CTRL, RFREG_MASK, 0x80010);
+
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_FAST_LCK, RFREG_MASK, 0x0f000);
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_FAST_LCK, RFREG_MASK, 0x4f000);
+	fsleep(1);
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_FAST_LCK, RFREG_MASK, 0x0f000);
+}
+
 static void rtw8822c_do_iqk(struct rtw_dev *rtwdev)
 {
 	struct rtw_iqk_para para = {0};
@@ -3547,11 +3568,12 @@ static void __rtw8822c_pwr_track(struct rtw_dev *rtwdev)
 
 	rtw_phy_config_swing_table(rtwdev, &swing_table);
 
+	if (rtw_phy_pwrtrack_need_lck(rtwdev))
+		rtw8822c_do_lck(rtwdev);
+
 	for (i = 0; i < rtwdev->hal.rf_path_num; i++)
 		rtw8822c_pwr_track_path(rtwdev, &swing_table, i);
 
-	if (rtw_phy_pwrtrack_need_iqk(rtwdev))
-		rtw8822c_do_iqk(rtwdev);
 }
 
 static void rtw8822c_pwr_track(struct rtw_dev *rtwdev)
@@ -4361,6 +4383,7 @@ struct rtw_chip_info rtw8822c_hw_spec = {
 	.dpd_ratemask = DIS_DPD_RATEALL,
 	.pwr_track_tbl = &rtw8822c_rtw_pwr_track_tbl,
 	.iqk_threshold = 8,
+	.lck_threshold = 8,
 	.bfer_su_max_num = 2,
 	.bfer_mu_max_num = 1,
 	.rx_ldpc = true,
-- 
2.21.0

