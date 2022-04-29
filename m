Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EBF51431D
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 09:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355067AbiD2HWM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 03:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355051AbiD2HWF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 03:22:05 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3494BF514
        for <linux-wireless@vger.kernel.org>; Fri, 29 Apr 2022 00:18:46 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23T7IdzsE001358, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23T7IdzsE001358
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 Apr 2022 15:18:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 15:18:39 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 29 Apr
 2022 15:18:38 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 04/16] rtw89: 8852c: rfk: add TSSI
Date:   Fri, 29 Apr 2022 15:17:57 +0800
Message-ID: <20220429071809.32104-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429071809.32104-1-pkshih@realtek.com>
References: <20220429071809.32104-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/29/2022 06:59:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMjkgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

TSSI is transmitter signal strength indication, which is a close-loop
hardware circuit to feedback actual transmitting power as a reference for
next transmission.

When we setup channel to connect an AP, it does full calibration. When
switching bands or channels, it needs to reset hardware status to prevent
use wrong feedback of previous transmission.

To do TX power compensation reflecting current temperature, it loads tables
of compensation values into registers according to channel and band group.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   19 +
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c | 1033 +++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.h |    5 +
 3 files changed, 1057 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 14302ebed3d5e..36406488e60e4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -1754,6 +1754,7 @@ static void rtw8852c_set_channel_help(struct rtw89_dev *rtwdev, bool enter,
 		rtw89_chip_stop_sch_tx(rtwdev, RTW89_MAC_0, &p->tx_en, RTW89_SCH_TX_SEL_ALL);
 		rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, false);
 		rtw8852c_dfs_en(rtwdev, false);
+		rtw8852c_tssi_cont_en_phyidx(rtwdev, false, RTW89_PHY_0);
 		rtw8852c_adc_en(rtwdev, false);
 		fsleep(40);
 		rtw8852c_bb_reset_en(rtwdev, phy_idx, false);
@@ -1761,6 +1762,7 @@ static void rtw8852c_set_channel_help(struct rtw89_dev *rtwdev, bool enter,
 		rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, true);
 		rtw8852c_adc_en(rtwdev, true);
 		rtw8852c_dfs_en(rtwdev, true);
+		rtw8852c_tssi_cont_en_phyidx(rtwdev, true, RTW89_PHY_0);
 		rtw8852c_bb_reset_en(rtwdev, phy_idx, true);
 		rtw89_chip_resume_sch_tx(rtwdev, RTW89_MAC_0, p->tx_en);
 	}
@@ -1770,6 +1772,8 @@ static void rtw8852c_rfk_init(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_mcc_info *mcc_info = &rtwdev->mcc;
 
+	rtwdev->is_tssi_mode[RF_PATH_A] = false;
+	rtwdev->is_tssi_mode[RF_PATH_B] = false;
 	memset(mcc_info, 0, sizeof(*mcc_info));
 	rtw8852c_lck_init(rtwdev);
 
@@ -1778,9 +1782,22 @@ static void rtw8852c_rfk_init(struct rtw89_dev *rtwdev)
 
 static void rtw8852c_rfk_channel(struct rtw89_dev *rtwdev)
 {
+	enum rtw89_phy_idx phy_idx = RTW89_PHY_0;
+
+	rtw8852c_tssi(rtwdev, phy_idx);
 	rtw89_fw_h2c_rf_ntfy_mcc(rtwdev);
 }
 
+static void rtw8852c_rfk_band_changed(struct rtw89_dev *rtwdev)
+{
+	rtw8852c_tssi_scan(rtwdev, RTW89_PHY_0);
+}
+
+static void rtw8852c_rfk_scan(struct rtw89_dev *rtwdev, bool start)
+{
+	rtw8852c_wifi_scan_notify(rtwdev, start, RTW89_PHY_0);
+}
+
 static void rtw8852c_rfk_track(struct rtw89_dev *rtwdev)
 {
 	rtw8852c_lck_track(rtwdev);
@@ -2714,6 +2731,8 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.read_phycap		= rtw8852c_read_phycap,
 	.rfk_init		= rtw8852c_rfk_init,
 	.rfk_channel		= rtw8852c_rfk_channel,
+	.rfk_band_changed	= rtw8852c_rfk_band_changed,
+	.rfk_scan		= rtw8852c_rfk_scan,
 	.rfk_track		= rtw8852c_rfk_track,
 	.power_trim		= rtw8852c_power_trim,
 	.set_txpwr		= rtw8852c_set_txpwr,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index 7af21986e79bd..21693dce79e82 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -9,6 +9,7 @@
 #include "rtw8852c.h"
 #include "rtw8852c_rfk.h"
 #include "rtw8852c_rfk_table.h"
+#include "rtw8852c_table.h"
 
 static u8 _kpath(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
@@ -455,6 +456,911 @@ static void _dac_cal(struct rtw89_dev *rtwdev, bool force)
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]DACK finish!!!\n");
 }
 
+static void _tssi_set_sys(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			  enum rtw89_rf_path path)
+{
+	enum rtw89_band band = rtwdev->hal.current_band_type;
+
+	rtw89_rfk_parser(rtwdev, &rtw8852c_tssi_sys_defs_tbl);
+
+	if (path == RF_PATH_A)
+		rtw89_rfk_parser_by_cond(rtwdev, band == RTW89_BAND_2G,
+					 &rtw8852c_tssi_sys_defs_2g_a_tbl,
+					 &rtw8852c_tssi_sys_defs_5g_a_tbl);
+	else
+		rtw89_rfk_parser_by_cond(rtwdev, band == RTW89_BAND_2G,
+					 &rtw8852c_tssi_sys_defs_2g_b_tbl,
+					 &rtw8852c_tssi_sys_defs_5g_b_tbl);
+}
+
+static void _tssi_ini_txpwr_ctrl_bb(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+				    enum rtw89_rf_path path)
+{
+	rtw89_rfk_parser_by_cond(rtwdev, path == RF_PATH_A,
+				 &rtw8852c_tssi_txpwr_ctrl_bb_defs_a_tbl,
+				 &rtw8852c_tssi_txpwr_ctrl_bb_defs_b_tbl);
+}
+
+static void _tssi_ini_txpwr_ctrl_bb_he_tb(struct rtw89_dev *rtwdev,
+					  enum rtw89_phy_idx phy,
+					  enum rtw89_rf_path path)
+{
+	rtw89_rfk_parser_by_cond(rtwdev, path == RF_PATH_A,
+				 &rtw8852c_tssi_txpwr_ctrl_bb_he_tb_defs_a_tbl,
+				 &rtw8852c_tssi_txpwr_ctrl_bb_he_tb_defs_b_tbl);
+}
+
+static void _tssi_set_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			  enum rtw89_rf_path path)
+{
+	enum rtw89_band band = rtwdev->hal.current_band_type;
+
+	if (path == RF_PATH_A) {
+		rtw89_rfk_parser(rtwdev, &rtw8852c_tssi_dck_defs_a_tbl);
+		rtw89_rfk_parser_by_cond(rtwdev, band == RTW89_BAND_2G,
+					 &rtw8852c_tssi_dck_defs_2g_a_tbl,
+					 &rtw8852c_tssi_dck_defs_5g_a_tbl);
+	} else {
+		rtw89_rfk_parser(rtwdev, &rtw8852c_tssi_dck_defs_b_tbl);
+		rtw89_rfk_parser_by_cond(rtwdev, band == RTW89_BAND_2G,
+					 &rtw8852c_tssi_dck_defs_2g_b_tbl,
+					 &rtw8852c_tssi_dck_defs_5g_b_tbl);
+	}
+}
+
+static void _tssi_set_bbgain_split(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+				   enum rtw89_rf_path path)
+{
+	rtw89_rfk_parser_by_cond(rtwdev, path == RF_PATH_A,
+				 &rtw8852c_tssi_set_bbgain_split_a_tbl,
+				 &rtw8852c_tssi_set_bbgain_split_b_tbl);
+}
+
+static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+				 enum rtw89_rf_path path)
+{
+#define __get_val(ptr, idx)				\
+({							\
+	s8 *__ptr = (ptr);				\
+	u8 __idx = (idx), __i, __v;			\
+	u32 __val = 0;					\
+	for (__i = 0; __i < 4; __i++) {			\
+		__v = (__ptr[__idx + __i]);		\
+		__val |= (__v << (8 * __i));		\
+	}						\
+	__val;						\
+})
+	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
+	u8 ch = rtwdev->hal.current_channel;
+	u8 subband = rtwdev->hal.current_subband;
+	const s8 *thm_up_a = NULL;
+	const s8 *thm_down_a = NULL;
+	const s8 *thm_up_b = NULL;
+	const s8 *thm_down_b = NULL;
+	u8 thermal = 0xff;
+	s8 thm_ofst[64] = {0};
+	u32 tmp = 0;
+	u8 i, j;
+
+	switch (subband) {
+	default:
+	case RTW89_CH_2G:
+		thm_up_a = rtw89_8852c_trk_cfg.delta_swingidx_2ga_p;
+		thm_down_a = rtw89_8852c_trk_cfg.delta_swingidx_2ga_n;
+		thm_up_b = rtw89_8852c_trk_cfg.delta_swingidx_2gb_p;
+		thm_down_b = rtw89_8852c_trk_cfg.delta_swingidx_2gb_n;
+		break;
+	case RTW89_CH_5G_BAND_1:
+		thm_up_a = rtw89_8852c_trk_cfg.delta_swingidx_5ga_p[0];
+		thm_down_a = rtw89_8852c_trk_cfg.delta_swingidx_5ga_n[0];
+		thm_up_b = rtw89_8852c_trk_cfg.delta_swingidx_5gb_p[0];
+		thm_down_b = rtw89_8852c_trk_cfg.delta_swingidx_5gb_n[0];
+		break;
+	case RTW89_CH_5G_BAND_3:
+		thm_up_a = rtw89_8852c_trk_cfg.delta_swingidx_5ga_p[1];
+		thm_down_a = rtw89_8852c_trk_cfg.delta_swingidx_5ga_n[1];
+		thm_up_b = rtw89_8852c_trk_cfg.delta_swingidx_5gb_p[1];
+		thm_down_b = rtw89_8852c_trk_cfg.delta_swingidx_5gb_n[1];
+		break;
+	case RTW89_CH_5G_BAND_4:
+		thm_up_a = rtw89_8852c_trk_cfg.delta_swingidx_5ga_p[2];
+		thm_down_a = rtw89_8852c_trk_cfg.delta_swingidx_5ga_n[2];
+		thm_up_b = rtw89_8852c_trk_cfg.delta_swingidx_5gb_p[2];
+		thm_down_b = rtw89_8852c_trk_cfg.delta_swingidx_5gb_n[2];
+		break;
+	case RTW89_CH_6G_BAND_IDX0:
+	case RTW89_CH_6G_BAND_IDX1:
+		thm_up_a = rtw89_8852c_trk_cfg.delta_swingidx_6ga_p[0];
+		thm_down_a = rtw89_8852c_trk_cfg.delta_swingidx_6ga_n[0];
+		thm_up_b = rtw89_8852c_trk_cfg.delta_swingidx_6gb_p[0];
+		thm_down_b = rtw89_8852c_trk_cfg.delta_swingidx_6gb_n[0];
+		break;
+	case RTW89_CH_6G_BAND_IDX2:
+	case RTW89_CH_6G_BAND_IDX3:
+		thm_up_a = rtw89_8852c_trk_cfg.delta_swingidx_6ga_p[1];
+		thm_down_a = rtw89_8852c_trk_cfg.delta_swingidx_6ga_n[1];
+		thm_up_b = rtw89_8852c_trk_cfg.delta_swingidx_6gb_p[1];
+		thm_down_b = rtw89_8852c_trk_cfg.delta_swingidx_6gb_n[1];
+		break;
+	case RTW89_CH_6G_BAND_IDX4:
+	case RTW89_CH_6G_BAND_IDX5:
+		thm_up_a = rtw89_8852c_trk_cfg.delta_swingidx_6ga_p[2];
+		thm_down_a = rtw89_8852c_trk_cfg.delta_swingidx_6ga_n[2];
+		thm_up_b = rtw89_8852c_trk_cfg.delta_swingidx_6gb_p[2];
+		thm_down_b = rtw89_8852c_trk_cfg.delta_swingidx_6gb_n[2];
+		break;
+	case RTW89_CH_6G_BAND_IDX6:
+	case RTW89_CH_6G_BAND_IDX7:
+		thm_up_a = rtw89_8852c_trk_cfg.delta_swingidx_6ga_p[3];
+		thm_down_a = rtw89_8852c_trk_cfg.delta_swingidx_6ga_n[3];
+		thm_up_b = rtw89_8852c_trk_cfg.delta_swingidx_6gb_p[3];
+		thm_down_b = rtw89_8852c_trk_cfg.delta_swingidx_6gb_n[3];
+		break;
+	}
+
+	if (path == RF_PATH_A) {
+		thermal = tssi_info->thermal[RF_PATH_A];
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI] ch=%d thermal_pathA=0x%x\n", ch, thermal);
+
+		rtw89_phy_write32_mask(rtwdev, R_P0_TMETER, B_P0_TMETER_DIS, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_P0_TMETER, B_P0_TMETER_TRK, 0x1);
+
+		if (thermal == 0xff) {
+			rtw89_phy_write32_mask(rtwdev, R_P0_TMETER, B_P0_TMETER, 32);
+			rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_VAL, 32);
+
+			for (i = 0; i < 64; i += 4) {
+				rtw89_phy_write32(rtwdev, R_P0_TSSI_BASE + i, 0x0);
+
+				rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+					    "[TSSI] write 0x%x val=0x%08x\n",
+					    0x5c00 + i, 0x0);
+			}
+
+		} else {
+			rtw89_phy_write32_mask(rtwdev, R_P0_TMETER, B_P0_TMETER, thermal);
+			rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_VAL,
+					       thermal);
+
+			i = 0;
+			for (j = 0; j < 32; j++)
+				thm_ofst[j] = i < DELTA_SWINGIDX_SIZE ?
+					      -thm_down_a[i++] :
+					      -thm_down_a[DELTA_SWINGIDX_SIZE - 1];
+
+			i = 1;
+			for (j = 63; j >= 32; j--)
+				thm_ofst[j] = i < DELTA_SWINGIDX_SIZE ?
+					      thm_up_a[i++] :
+					      thm_up_a[DELTA_SWINGIDX_SIZE - 1];
+
+			for (i = 0; i < 64; i += 4) {
+				tmp = __get_val(thm_ofst, i);
+				rtw89_phy_write32(rtwdev, R_P0_TSSI_BASE + i, tmp);
+
+				rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+					    "[TSSI] write 0x%x val=0x%08x\n",
+					    0x5c00 + i, tmp);
+			}
+		}
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, R_P0_RFCTM_RDY, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, R_P0_RFCTM_RDY, 0x0);
+
+	} else {
+		thermal = tssi_info->thermal[RF_PATH_B];
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI] ch=%d thermal_pathB=0x%x\n", ch, thermal);
+
+		rtw89_phy_write32_mask(rtwdev, R_P1_TMETER, B_P1_TMETER_DIS, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_P1_TMETER, B_P1_TMETER_TRK, 0x1);
+
+		if (thermal == 0xff) {
+			rtw89_phy_write32_mask(rtwdev, R_P1_TMETER, B_P1_TMETER, 32);
+			rtw89_phy_write32_mask(rtwdev, R_P1_RFCTM, B_P1_RFCTM_VAL, 32);
+
+			for (i = 0; i < 64; i += 4) {
+				rtw89_phy_write32(rtwdev, R_TSSI_THOF + i, 0x0);
+
+				rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+					    "[TSSI] write 0x%x val=0x%08x\n",
+					    0x7c00 + i, 0x0);
+			}
+
+		} else {
+			rtw89_phy_write32_mask(rtwdev, R_P1_TMETER, B_P1_TMETER, thermal);
+			rtw89_phy_write32_mask(rtwdev, R_P1_RFCTM, B_P1_RFCTM_VAL,
+					       thermal);
+
+			i = 0;
+			for (j = 0; j < 32; j++)
+				thm_ofst[j] = i < DELTA_SWINGIDX_SIZE ?
+					      -thm_down_b[i++] :
+					      -thm_down_b[DELTA_SWINGIDX_SIZE - 1];
+
+			i = 1;
+			for (j = 63; j >= 32; j--)
+				thm_ofst[j] = i < DELTA_SWINGIDX_SIZE ?
+					      thm_up_b[i++] :
+					      thm_up_b[DELTA_SWINGIDX_SIZE - 1];
+
+			for (i = 0; i < 64; i += 4) {
+				tmp = __get_val(thm_ofst, i);
+				rtw89_phy_write32(rtwdev, R_TSSI_THOF + i, tmp);
+
+				rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+					    "[TSSI] write 0x%x val=0x%08x\n",
+					    0x7c00 + i, tmp);
+			}
+		}
+		rtw89_phy_write32_mask(rtwdev, R_P1_RFCTM, R_P1_RFCTM_RDY, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_P1_RFCTM, R_P1_RFCTM_RDY, 0x0);
+	}
+#undef __get_val
+}
+
+static void _tssi_slope_cal_org(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+				enum rtw89_rf_path path)
+{
+	enum rtw89_band band = rtwdev->hal.current_band_type;
+
+	if (path == RF_PATH_A) {
+		rtw89_rfk_parser_by_cond(rtwdev, band == RTW89_BAND_2G,
+					 &rtw8852c_tssi_slope_cal_org_defs_2g_a_tbl,
+					 &rtw8852c_tssi_slope_cal_org_defs_5g_a_tbl);
+	} else {
+		rtw89_rfk_parser_by_cond(rtwdev, band == RTW89_BAND_2G,
+					 &rtw8852c_tssi_slope_cal_org_defs_2g_b_tbl,
+					 &rtw8852c_tssi_slope_cal_org_defs_5g_b_tbl);
+	}
+}
+
+static void _tssi_set_aligk_default(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+				    enum rtw89_rf_path path)
+{
+	enum rtw89_band band = rtwdev->hal.current_band_type;
+	const struct rtw89_rfk_tbl *tbl;
+
+	if (path == RF_PATH_A) {
+		if (band == RTW89_BAND_2G)
+			tbl = &rtw8852c_tssi_set_aligk_default_defs_2g_a_tbl;
+		else if (band == RTW89_BAND_6G)
+			tbl = &rtw8852c_tssi_set_aligk_default_defs_6g_a_tbl;
+		else
+			tbl = &rtw8852c_tssi_set_aligk_default_defs_5g_a_tbl;
+	} else {
+		if (band == RTW89_BAND_2G)
+			tbl = &rtw8852c_tssi_set_aligk_default_defs_2g_b_tbl;
+		else if (band == RTW89_BAND_6G)
+			tbl = &rtw8852c_tssi_set_aligk_default_defs_6g_b_tbl;
+		else
+			tbl = &rtw8852c_tssi_set_aligk_default_defs_5g_b_tbl;
+	}
+
+	rtw89_rfk_parser(rtwdev, tbl);
+}
+
+static void _tssi_set_slope(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			    enum rtw89_rf_path path)
+{
+	rtw89_rfk_parser_by_cond(rtwdev, path == RF_PATH_A,
+				 &rtw8852c_tssi_slope_defs_a_tbl,
+				 &rtw8852c_tssi_slope_defs_b_tbl);
+}
+
+static void _tssi_run_slope(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			    enum rtw89_rf_path path)
+{
+	rtw89_rfk_parser_by_cond(rtwdev, path == RF_PATH_A,
+				 &rtw8852c_tssi_run_slope_defs_a_tbl,
+				 &rtw8852c_tssi_run_slope_defs_b_tbl);
+}
+
+static void _tssi_set_track(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			    enum rtw89_rf_path path)
+{
+	rtw89_rfk_parser_by_cond(rtwdev, path == RF_PATH_A,
+				 &rtw8852c_tssi_track_defs_a_tbl,
+				 &rtw8852c_tssi_track_defs_b_tbl);
+}
+
+static void _tssi_set_txagc_offset_mv_avg(struct rtw89_dev *rtwdev,
+					  enum rtw89_phy_idx phy,
+					  enum rtw89_rf_path path)
+{
+	rtw89_rfk_parser_by_cond(rtwdev, path == RF_PATH_A,
+				 &rtw8852c_tssi_txagc_ofst_mv_avg_defs_a_tbl,
+				 &rtw8852c_tssi_txagc_ofst_mv_avg_defs_b_tbl);
+}
+
+static void _tssi_enable(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+{
+	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
+	u32 i, path = RF_PATH_A, path_max = RF_PATH_NUM_8852C;
+
+	if (rtwdev->dbcc_en) {
+		if (phy == RTW89_PHY_0) {
+			path = RF_PATH_A;
+			path_max = RF_PATH_B;
+		} else if (phy == RTW89_PHY_1) {
+			path = RF_PATH_B;
+			path_max = RF_PATH_NUM_8852C;
+		}
+	}
+
+	for (i = path; i < path_max; i++) {
+		_tssi_set_track(rtwdev, phy, i);
+		_tssi_set_txagc_offset_mv_avg(rtwdev, phy, i);
+
+		rtw89_rfk_parser_by_cond(rtwdev, i == RF_PATH_A,
+					 &rtw8852c_tssi_enable_defs_a_tbl,
+					 &rtw8852c_tssi_enable_defs_b_tbl);
+
+		tssi_info->base_thermal[i] =
+			ewma_thermal_read(&rtwdev->phystat.avg_thermal[i]);
+		rtwdev->is_tssi_mode[i] = true;
+	}
+}
+
+static void _tssi_disable(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+{
+	u32 i, path = RF_PATH_A, path_max = RF_PATH_NUM_8852C;
+
+	if (rtwdev->dbcc_en) {
+		if (phy == RTW89_PHY_0) {
+			path = RF_PATH_A;
+			path_max = RF_PATH_B;
+		} else if (phy == RTW89_PHY_1) {
+			path = RF_PATH_B;
+			path_max = RF_PATH_NUM_8852C;
+		}
+	}
+
+	for (i = path; i < path_max; i++) {
+		if (i == RF_PATH_A) {
+			rtw89_rfk_parser(rtwdev, &rtw8852c_tssi_disable_defs_a_tbl);
+			rtwdev->is_tssi_mode[RF_PATH_A] = false;
+		}  else if (i == RF_PATH_B) {
+			rtw89_rfk_parser(rtwdev, &rtw8852c_tssi_disable_defs_b_tbl);
+			rtwdev->is_tssi_mode[RF_PATH_B] = false;
+		}
+	}
+}
+
+static u32 _tssi_get_cck_group(struct rtw89_dev *rtwdev, u8 ch)
+{
+	switch (ch) {
+	case 1 ... 2:
+		return 0;
+	case 3 ... 5:
+		return 1;
+	case 6 ... 8:
+		return 2;
+	case 9 ... 11:
+		return 3;
+	case 12 ... 13:
+		return 4;
+	case 14:
+		return 5;
+	}
+
+	return 0;
+}
+
+#define TSSI_EXTRA_GROUP_BIT (BIT(31))
+#define TSSI_EXTRA_GROUP(idx) (TSSI_EXTRA_GROUP_BIT | (idx))
+#define IS_TSSI_EXTRA_GROUP(group) ((group) & TSSI_EXTRA_GROUP_BIT)
+#define TSSI_EXTRA_GET_GROUP_IDX1(group) ((group) & ~TSSI_EXTRA_GROUP_BIT)
+#define TSSI_EXTRA_GET_GROUP_IDX2(group) (TSSI_EXTRA_GET_GROUP_IDX1(group) + 1)
+
+static u32 _tssi_get_ofdm_group(struct rtw89_dev *rtwdev, u8 ch)
+{
+	switch (ch) {
+	case 1 ... 2:
+		return 0;
+	case 3 ... 5:
+		return 1;
+	case 6 ... 8:
+		return 2;
+	case 9 ... 11:
+		return 3;
+	case 12 ... 14:
+		return 4;
+	case 36 ... 40:
+		return 5;
+	case 41 ... 43:
+		return TSSI_EXTRA_GROUP(5);
+	case 44 ... 48:
+		return 6;
+	case 49 ... 51:
+		return TSSI_EXTRA_GROUP(6);
+	case 52 ... 56:
+		return 7;
+	case 57 ... 59:
+		return TSSI_EXTRA_GROUP(7);
+	case 60 ... 64:
+		return 8;
+	case 100 ... 104:
+		return 9;
+	case 105 ... 107:
+		return TSSI_EXTRA_GROUP(9);
+	case 108 ... 112:
+		return 10;
+	case 113 ... 115:
+		return TSSI_EXTRA_GROUP(10);
+	case 116 ... 120:
+		return 11;
+	case 121 ... 123:
+		return TSSI_EXTRA_GROUP(11);
+	case 124 ... 128:
+		return 12;
+	case 129 ... 131:
+		return TSSI_EXTRA_GROUP(12);
+	case 132 ... 136:
+		return 13;
+	case 137 ... 139:
+		return TSSI_EXTRA_GROUP(13);
+	case 140 ... 144:
+		return 14;
+	case 149 ... 153:
+		return 15;
+	case 154 ... 156:
+		return TSSI_EXTRA_GROUP(15);
+	case 157 ... 161:
+		return 16;
+	case 162 ... 164:
+		return TSSI_EXTRA_GROUP(16);
+	case 165 ... 169:
+		return 17;
+	case 170 ... 172:
+		return TSSI_EXTRA_GROUP(17);
+	case 173 ... 177:
+		return 18;
+	}
+
+	return 0;
+}
+
+static u32 _tssi_get_6g_ofdm_group(struct rtw89_dev *rtwdev, u8 ch)
+{
+	switch (ch) {
+	case 1 ... 5:
+		return 0;
+	case 6 ... 8:
+		return TSSI_EXTRA_GROUP(0);
+	case 9 ... 13:
+		return 1;
+	case 14 ... 16:
+		return TSSI_EXTRA_GROUP(1);
+	case 17 ... 21:
+		return 2;
+	case 22 ... 24:
+		return TSSI_EXTRA_GROUP(2);
+	case 25 ... 29:
+		return 3;
+	case 33 ... 37:
+		return 4;
+	case 38 ... 40:
+		return TSSI_EXTRA_GROUP(4);
+	case 41 ... 45:
+		return 5;
+	case 46 ... 48:
+		return TSSI_EXTRA_GROUP(5);
+	case 49 ... 53:
+		return 6;
+	case 54 ... 56:
+		return TSSI_EXTRA_GROUP(6);
+	case 57 ... 61:
+		return 7;
+	case 65 ... 69:
+		return 8;
+	case 70 ... 72:
+		return TSSI_EXTRA_GROUP(8);
+	case 73 ... 77:
+		return 9;
+	case 78 ... 80:
+		return TSSI_EXTRA_GROUP(9);
+	case 81 ... 85:
+		return 10;
+	case 86 ... 88:
+		return TSSI_EXTRA_GROUP(10);
+	case 89 ... 93:
+		return 11;
+	case 97 ... 101:
+		return 12;
+	case 102 ... 104:
+		return TSSI_EXTRA_GROUP(12);
+	case 105 ... 109:
+		return 13;
+	case 110 ... 112:
+		return TSSI_EXTRA_GROUP(13);
+	case 113 ... 117:
+		return 14;
+	case 118 ... 120:
+		return TSSI_EXTRA_GROUP(14);
+	case 121 ... 125:
+		return 15;
+	case 129 ... 133:
+		return 16;
+	case 134 ... 136:
+		return TSSI_EXTRA_GROUP(16);
+	case 137 ... 141:
+		return 17;
+	case 142 ... 144:
+		return TSSI_EXTRA_GROUP(17);
+	case 145 ... 149:
+		return 18;
+	case 150 ... 152:
+		return TSSI_EXTRA_GROUP(18);
+	case 153 ... 157:
+		return 19;
+	case 161 ... 165:
+		return 20;
+	case 166 ... 168:
+		return TSSI_EXTRA_GROUP(20);
+	case 169 ... 173:
+		return 21;
+	case 174 ... 176:
+		return TSSI_EXTRA_GROUP(21);
+	case 177 ... 181:
+		return 22;
+	case 182 ... 184:
+		return TSSI_EXTRA_GROUP(22);
+	case 185 ... 189:
+		return 23;
+	case 193 ... 197:
+		return 24;
+	case 198 ... 200:
+		return TSSI_EXTRA_GROUP(24);
+	case 201 ... 205:
+		return 25;
+	case 206 ... 208:
+		return TSSI_EXTRA_GROUP(25);
+	case 209 ... 213:
+		return 26;
+	case 214 ... 216:
+		return TSSI_EXTRA_GROUP(26);
+	case 217 ... 221:
+		return 27;
+	case 225 ... 229:
+		return 28;
+	case 230 ... 232:
+		return TSSI_EXTRA_GROUP(28);
+	case 233 ... 237:
+		return 29;
+	case 238 ... 240:
+		return TSSI_EXTRA_GROUP(29);
+	case 241 ... 245:
+		return 30;
+	case 246 ... 248:
+		return TSSI_EXTRA_GROUP(30);
+	case 249 ... 253:
+		return 31;
+	}
+
+	return 0;
+}
+
+static u32 _tssi_get_trim_group(struct rtw89_dev *rtwdev, u8 ch)
+{
+	switch (ch) {
+	case 1 ... 8:
+		return 0;
+	case 9 ... 14:
+		return 1;
+	case 36 ... 48:
+		return 2;
+	case 49 ... 51:
+		return TSSI_EXTRA_GROUP(2);
+	case 52 ... 64:
+		return 3;
+	case 100 ... 112:
+		return 4;
+	case 113 ... 115:
+		return TSSI_EXTRA_GROUP(4);
+	case 116 ... 128:
+		return 5;
+	case 132 ... 144:
+		return 6;
+	case 149 ... 177:
+		return 7;
+	}
+
+	return 0;
+}
+
+static u32 _tssi_get_6g_trim_group(struct rtw89_dev *rtwdev, u8 ch)
+{
+	switch (ch) {
+	case 1 ... 13:
+		return 0;
+	case 14 ... 16:
+		return TSSI_EXTRA_GROUP(0);
+	case 17 ... 29:
+		return 1;
+	case 33 ... 45:
+		return 2;
+	case 46 ... 48:
+		return TSSI_EXTRA_GROUP(2);
+	case 49 ... 61:
+		return 3;
+	case 65 ... 77:
+		return 4;
+	case 78 ... 80:
+		return TSSI_EXTRA_GROUP(4);
+	case 81 ... 93:
+		return 5;
+	case 97 ... 109:
+		return 6;
+	case 110 ... 112:
+		return TSSI_EXTRA_GROUP(6);
+	case 113 ... 125:
+		return 7;
+	case 129 ... 141:
+		return 8;
+	case 142 ... 144:
+		return TSSI_EXTRA_GROUP(8);
+	case 145 ... 157:
+		return 9;
+	case 161 ... 173:
+		return 10;
+	case 174 ... 176:
+		return TSSI_EXTRA_GROUP(10);
+	case 177 ... 189:
+		return 11;
+	case 193 ... 205:
+		return 12;
+	case 206 ... 208:
+		return TSSI_EXTRA_GROUP(12);
+	case 209 ... 221:
+		return 13;
+	case 225 ... 237:
+		return 14;
+	case 238 ... 240:
+		return TSSI_EXTRA_GROUP(14);
+	case 241 ... 253:
+		return 15;
+	}
+
+	return 0;
+}
+
+static s8 _tssi_get_ofdm_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			    enum rtw89_rf_path path)
+{
+	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
+	enum rtw89_band band = rtwdev->hal.current_band_type;
+	u8 ch = rtwdev->hal.current_channel;
+	u32 gidx, gidx_1st, gidx_2nd;
+	s8 de_1st;
+	s8 de_2nd;
+	s8 val;
+
+	if (band == RTW89_BAND_2G || band == RTW89_BAND_5G) {
+		gidx = _tssi_get_ofdm_group(rtwdev, ch);
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM]: path=%d mcs group_idx=0x%x\n",
+			    path, gidx);
+
+		if (IS_TSSI_EXTRA_GROUP(gidx)) {
+			gidx_1st = TSSI_EXTRA_GET_GROUP_IDX1(gidx);
+			gidx_2nd = TSSI_EXTRA_GET_GROUP_IDX2(gidx);
+			de_1st = tssi_info->tssi_mcs[path][gidx_1st];
+			de_2nd = tssi_info->tssi_mcs[path][gidx_2nd];
+			val = (de_1st + de_2nd) / 2;
+
+			rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+				    "[TSSI][TRIM]: path=%d mcs de=%d 1st=%d 2nd=%d\n",
+				    path, val, de_1st, de_2nd);
+		} else {
+			val = tssi_info->tssi_mcs[path][gidx];
+
+			rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+				    "[TSSI][TRIM]: path=%d mcs de=%d\n", path, val);
+		}
+	} else {
+		gidx = _tssi_get_6g_ofdm_group(rtwdev, ch);
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM]: path=%d mcs group_idx=0x%x\n",
+			    path, gidx);
+
+		if (IS_TSSI_EXTRA_GROUP(gidx)) {
+			gidx_1st = TSSI_EXTRA_GET_GROUP_IDX1(gidx);
+			gidx_2nd = TSSI_EXTRA_GET_GROUP_IDX2(gidx);
+			de_1st = tssi_info->tssi_6g_mcs[path][gidx_1st];
+			de_2nd = tssi_info->tssi_6g_mcs[path][gidx_2nd];
+			val = (de_1st + de_2nd) / 2;
+
+			rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+				    "[TSSI][TRIM]: path=%d mcs de=%d 1st=%d 2nd=%d\n",
+				    path, val, de_1st, de_2nd);
+		} else {
+			val = tssi_info->tssi_6g_mcs[path][gidx];
+
+			rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+				    "[TSSI][TRIM]: path=%d mcs de=%d\n", path, val);
+		}
+	}
+
+	return val;
+}
+
+static s8 _tssi_get_ofdm_trim_de(struct rtw89_dev *rtwdev,
+				 enum rtw89_phy_idx phy,
+				 enum rtw89_rf_path path)
+{
+	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
+	enum rtw89_band band = rtwdev->hal.current_band_type;
+	u8 ch = rtwdev->hal.current_channel;
+	u32 tgidx, tgidx_1st, tgidx_2nd;
+	s8 tde_1st = 0;
+	s8 tde_2nd = 0;
+	s8 val;
+
+	if (band == RTW89_BAND_2G || band == RTW89_BAND_5G) {
+		tgidx = _tssi_get_trim_group(rtwdev, ch);
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM]: path=%d mcs trim_group_idx=0x%x\n",
+			    path, tgidx);
+
+		if (IS_TSSI_EXTRA_GROUP(tgidx)) {
+			tgidx_1st = TSSI_EXTRA_GET_GROUP_IDX1(tgidx);
+			tgidx_2nd = TSSI_EXTRA_GET_GROUP_IDX2(tgidx);
+			tde_1st = tssi_info->tssi_trim[path][tgidx_1st];
+			tde_2nd = tssi_info->tssi_trim[path][tgidx_2nd];
+			val = (tde_1st + tde_2nd) / 2;
+
+			rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+				    "[TSSI][TRIM]: path=%d mcs trim_de=%d 1st=%d 2nd=%d\n",
+				    path, val, tde_1st, tde_2nd);
+		} else {
+			val = tssi_info->tssi_trim[path][tgidx];
+
+			rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+				    "[TSSI][TRIM]: path=%d mcs trim_de=%d\n",
+				    path, val);
+		}
+	} else {
+		tgidx = _tssi_get_6g_trim_group(rtwdev, ch);
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM]: path=%d mcs trim_group_idx=0x%x\n",
+			    path, tgidx);
+
+		if (IS_TSSI_EXTRA_GROUP(tgidx)) {
+			tgidx_1st = TSSI_EXTRA_GET_GROUP_IDX1(tgidx);
+			tgidx_2nd = TSSI_EXTRA_GET_GROUP_IDX2(tgidx);
+			tde_1st = tssi_info->tssi_trim_6g[path][tgidx_1st];
+			tde_2nd = tssi_info->tssi_trim_6g[path][tgidx_2nd];
+			val = (tde_1st + tde_2nd) / 2;
+
+			rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+				    "[TSSI][TRIM]: path=%d mcs trim_de=%d 1st=%d 2nd=%d\n",
+				    path, val, tde_1st, tde_2nd);
+		} else {
+			val = tssi_info->tssi_trim_6g[path][tgidx];
+
+			rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+				    "[TSSI][TRIM]: path=%d mcs trim_de=%d\n",
+				    path, val);
+		}
+	}
+
+	return val;
+}
+
+static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev,
+				  enum rtw89_phy_idx phy)
+{
+#define __DE_MASK 0x003ff000
+	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
+	static const u32 r_cck_long[RF_PATH_NUM_8852C] = {0x5858, 0x7858};
+	static const u32 r_cck_short[RF_PATH_NUM_8852C] = {0x5860, 0x7860};
+	static const u32 r_mcs_20m[RF_PATH_NUM_8852C] = {0x5838, 0x7838};
+	static const u32 r_mcs_40m[RF_PATH_NUM_8852C] = {0x5840, 0x7840};
+	static const u32 r_mcs_80m[RF_PATH_NUM_8852C] = {0x5848, 0x7848};
+	static const u32 r_mcs_80m_80m[RF_PATH_NUM_8852C] = {0x5850, 0x7850};
+	static const u32 r_mcs_5m[RF_PATH_NUM_8852C] = {0x5828, 0x7828};
+	static const u32 r_mcs_10m[RF_PATH_NUM_8852C] = {0x5830, 0x7830};
+	u8 ch = rtwdev->hal.current_channel;
+	u8 gidx;
+	s8 ofdm_de;
+	s8 trim_de;
+	s32 val;
+	u32 i, path = RF_PATH_A, path_max = RF_PATH_NUM_8852C;
+
+	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "[TSSI][TRIM]: phy=%d ch=%d\n",
+		    phy, ch);
+
+	if (rtwdev->dbcc_en) {
+		if (phy == RTW89_PHY_0) {
+			path = RF_PATH_A;
+			path_max = RF_PATH_B;
+		} else if (phy == RTW89_PHY_1) {
+			path = RF_PATH_B;
+			path_max = RF_PATH_NUM_8852C;
+		}
+	}
+
+	for (i = path; i < path_max; i++) {
+		gidx = _tssi_get_cck_group(rtwdev, ch);
+		trim_de = _tssi_get_ofdm_trim_de(rtwdev, phy, i);
+		val = tssi_info->tssi_cck[i][gidx] + trim_de;
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM]: path=%d cck[%d]=0x%x trim=0x%x\n",
+			    i, gidx, tssi_info->tssi_cck[i][gidx], trim_de);
+
+		rtw89_phy_write32_mask(rtwdev, r_cck_long[i], __DE_MASK, val);
+		rtw89_phy_write32_mask(rtwdev, r_cck_short[i], __DE_MASK, val);
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI] Set TSSI CCK DE 0x%x[21:12]=0x%x\n",
+			    r_cck_long[i],
+			    rtw89_phy_read32_mask(rtwdev, r_cck_long[i],
+						  __DE_MASK));
+
+		ofdm_de = _tssi_get_ofdm_de(rtwdev, phy, i);
+		trim_de = _tssi_get_ofdm_trim_de(rtwdev, phy, i);
+		val = ofdm_de + trim_de;
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM]: path=%d mcs=0x%x trim=0x%x\n",
+			    i, ofdm_de, trim_de);
+
+		rtw89_phy_write32_mask(rtwdev, r_mcs_20m[i], __DE_MASK, val);
+		rtw89_phy_write32_mask(rtwdev, r_mcs_40m[i], __DE_MASK, val);
+		rtw89_phy_write32_mask(rtwdev, r_mcs_80m[i], __DE_MASK, val);
+		rtw89_phy_write32_mask(rtwdev, r_mcs_80m_80m[i], __DE_MASK, val);
+		rtw89_phy_write32_mask(rtwdev, r_mcs_5m[i], __DE_MASK, val);
+		rtw89_phy_write32_mask(rtwdev, r_mcs_10m[i], __DE_MASK, val);
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI] Set TSSI MCS DE 0x%x[21:12]=0x%x\n",
+			    r_mcs_20m[i],
+			    rtw89_phy_read32_mask(rtwdev, r_mcs_20m[i],
+						  __DE_MASK));
+	}
+#undef __DE_MASK
+}
+
+static void rtw8852c_tssi_cont_en(struct rtw89_dev *rtwdev, bool en,
+				  enum rtw89_rf_path path)
+{
+	static const u32 tssi_trk[2] = {0x5818, 0x7818};
+	static const u32 tssi_en[2] = {0x5820, 0x7820};
+
+	if (en) {
+		rtw89_phy_write32_mask(rtwdev, tssi_trk[path], BIT(30), 0x0);
+		rtw89_phy_write32_mask(rtwdev, tssi_en[path], BIT(31), 0x0);
+		if (rtwdev->dbcc_en && path == RF_PATH_B)
+			_tssi_set_efuse_to_de(rtwdev, RTW89_PHY_1);
+		else
+			_tssi_set_efuse_to_de(rtwdev, RTW89_PHY_0);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, tssi_trk[path], BIT(30), 0x1);
+		rtw89_phy_write32_mask(rtwdev, tssi_en[path], BIT(31), 0x1);
+	}
+}
+
+void rtw8852c_tssi_cont_en_phyidx(struct rtw89_dev *rtwdev, bool en, u8 phy_idx)
+{
+	if (!rtwdev->dbcc_en) {
+		rtw8852c_tssi_cont_en(rtwdev, en, RF_PATH_A);
+		rtw8852c_tssi_cont_en(rtwdev, en, RF_PATH_B);
+	} else {
+		if (phy_idx == RTW89_PHY_0)
+			rtw8852c_tssi_cont_en(rtwdev, en, RF_PATH_A);
+		else
+			rtw8852c_tssi_cont_en(rtwdev, en, RF_PATH_B);
+	}
+}
+
 static void _bw_setting(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
 			enum rtw89_bandwidth bw, bool is_dav)
 {
@@ -717,3 +1623,130 @@ void rtw8852c_dack(struct rtw89_dev *rtwdev)
 	_dac_cal(rtwdev, false);
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DACK, BTC_WRFK_STOP);
 }
+
+void rtw8852c_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+{
+	u32 i, path = RF_PATH_A, path_max = RF_PATH_NUM_8852C;
+
+	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "[TSSI] %s: phy=%d\n", __func__, phy);
+
+	if (rtwdev->dbcc_en) {
+		if (phy == RTW89_PHY_0) {
+			path = RF_PATH_A;
+			path_max = RF_PATH_B;
+		} else if (phy == RTW89_PHY_1) {
+			path = RF_PATH_B;
+			path_max = RF_PATH_NUM_8852C;
+		}
+	}
+
+	_tssi_disable(rtwdev, phy);
+
+	for (i = path; i < path_max; i++) {
+		_tssi_set_sys(rtwdev, phy, i);
+		_tssi_ini_txpwr_ctrl_bb(rtwdev, phy, i);
+		_tssi_ini_txpwr_ctrl_bb_he_tb(rtwdev, phy, i);
+		_tssi_set_dck(rtwdev, phy, i);
+		_tssi_set_bbgain_split(rtwdev, phy, i);
+		_tssi_set_tmeter_tbl(rtwdev, phy, i);
+		_tssi_slope_cal_org(rtwdev, phy, i);
+		_tssi_set_aligk_default(rtwdev, phy, i);
+		_tssi_set_slope(rtwdev, phy, i);
+		_tssi_run_slope(rtwdev, phy, i);
+	}
+
+	_tssi_enable(rtwdev, phy);
+	_tssi_set_efuse_to_de(rtwdev, phy);
+}
+
+void rtw8852c_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+{
+	u32 i, path = RF_PATH_A, path_max = RF_PATH_NUM_8852C;
+
+	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "[TSSI] %s: phy=%d\n",
+		    __func__, phy);
+
+	if (!rtwdev->is_tssi_mode[RF_PATH_A])
+		return;
+	if (!rtwdev->is_tssi_mode[RF_PATH_B])
+		return;
+
+	if (rtwdev->dbcc_en) {
+		if (phy == RTW89_PHY_0) {
+			path = RF_PATH_A;
+			path_max = RF_PATH_B;
+		} else if (phy == RTW89_PHY_1) {
+			path = RF_PATH_B;
+			path_max = RF_PATH_NUM_8852C;
+		}
+	}
+
+	_tssi_disable(rtwdev, phy);
+
+	for (i = path; i < path_max; i++) {
+		_tssi_set_sys(rtwdev, phy, i);
+		_tssi_set_dck(rtwdev, phy, i);
+		_tssi_set_tmeter_tbl(rtwdev, phy, i);
+		_tssi_slope_cal_org(rtwdev, phy, i);
+		_tssi_set_aligk_default(rtwdev, phy, i);
+	}
+
+	_tssi_enable(rtwdev, phy);
+	_tssi_set_efuse_to_de(rtwdev, phy);
+}
+
+static void rtw8852c_tssi_default_txagc(struct rtw89_dev *rtwdev,
+					enum rtw89_phy_idx phy, bool enable)
+{
+	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
+	u8 i;
+
+	if (!rtwdev->is_tssi_mode[RF_PATH_A] && !rtwdev->is_tssi_mode[RF_PATH_B])
+		return;
+
+	if (enable) {
+		/* SCAN_START */
+		if (rtw89_phy_read32_mask(rtwdev, R_TXAGC_BB, B_TXAGC_BB_OFT) != 0xc000 &&
+		    rtw89_phy_read32_mask(rtwdev, R_TXAGC_BB, B_TXAGC_BB_OFT) != 0x0) {
+			for (i = 0; i < 6; i++) {
+				tssi_info->default_txagc_offset[RF_PATH_A] =
+					rtw89_phy_read32_mask(rtwdev, R_TXAGC_BB,
+							      B_TXAGC_BB);
+				if (tssi_info->default_txagc_offset[RF_PATH_A])
+					break;
+			}
+		}
+
+		if (rtw89_phy_read32_mask(rtwdev, R_TXAGC_BB_S1, B_TXAGC_BB_S1_OFT) != 0xc000 &&
+		    rtw89_phy_read32_mask(rtwdev, R_TXAGC_BB_S1, B_TXAGC_BB_S1_OFT) != 0x0) {
+			for (i = 0; i < 6; i++) {
+				tssi_info->default_txagc_offset[RF_PATH_B] =
+					rtw89_phy_read32_mask(rtwdev, R_TXAGC_BB_S1,
+							      B_TXAGC_BB_S1);
+				if (tssi_info->default_txagc_offset[RF_PATH_B])
+					break;
+			}
+		}
+	} else {
+		/* SCAN_END */
+		rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_TRK, B_P0_TSSI_OFT,
+				       tssi_info->default_txagc_offset[RF_PATH_A]);
+		rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_TRK, B_P1_TSSI_OFT,
+				       tssi_info->default_txagc_offset[RF_PATH_B]);
+
+		rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_TRK, B_P0_TSSI_OFT_EN, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_TRK, B_P0_TSSI_OFT_EN, 0x1);
+
+		rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_TRK, B_P1_TSSI_OFT_EN, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_TRK, B_P1_TSSI_OFT_EN, 0x1);
+	}
+}
+
+void rtw8852c_wifi_scan_notify(struct rtw89_dev *rtwdev,
+			       bool scan_start, enum rtw89_phy_idx phy_idx)
+{
+	if (scan_start)
+		rtw8852c_tssi_default_txagc(rtwdev, phy_idx, true);
+	else
+		rtw8852c_tssi_default_txagc(rtwdev, phy_idx, false);
+}
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
index 4ce76ef4c5e60..a16ad9305ba42 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
@@ -8,6 +8,11 @@
 #include "core.h"
 
 void rtw8852c_dack(struct rtw89_dev *rtwdev);
+void rtw8852c_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
+void rtw8852c_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
+void rtw8852c_tssi_cont_en_phyidx(struct rtw89_dev *rtwdev, bool en, u8 phy_idx);
+void rtw8852c_wifi_scan_notify(struct rtw89_dev *rtwdev, bool scan_start,
+			       enum rtw89_phy_idx phy_idx);
 void rtw8852c_set_channel_rf(struct rtw89_dev *rtwdev,
 			     struct rtw89_channel_params *param,
 			     enum rtw89_phy_idx phy_idx);
-- 
2.25.1

