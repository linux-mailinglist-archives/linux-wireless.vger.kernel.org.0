Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FE65FC212
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Oct 2022 10:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiJLIdr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Oct 2022 04:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiJLIdi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Oct 2022 04:33:38 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64ACAB5FEC
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 01:33:08 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29C8WSekC026287, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29C8WSekC026287
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 12 Oct 2022 16:32:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 12 Oct 2022 16:32:57 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 12 Oct
 2022 16:32:55 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/5] wifi: rtw89: 8852b: rfk: add TSSI
Date:   Wed, 12 Oct 2022 16:32:34 +0800
Message-ID: <20221012083234.20224-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221012083234.20224-1-pkshih@realtek.com>
References: <20221012083234.20224-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 10/12/2022 08:00:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzEyIKRXpMggMDY6MDA6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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
 drivers/net/wireless/realtek/rtw89/core.h     |   15 +
 drivers/net/wireless/realtek/rtw89/reg.h      |   43 +
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.c | 1174 +++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.h |    4 +
 4 files changed, 1236 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 0a0343608ba63..856d9712f0ae7 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3164,6 +3164,14 @@ struct rtw89_cfo_tracking_info {
 	u8 lock_cnt;
 };
 
+enum rtw89_tssi_alimk_band {
+	TSSI_ALIMK_2G = 0,
+	TSSI_ALIMK_5GL,
+	TSSI_ALIMK_5GM,
+	TSSI_ALIMK_5GH,
+	TSSI_ALIMK_MAX
+};
+
 /* 2GL, 2GH, 5GL1, 5GH1, 5GM1, 5GM2, 5GH1, 5GH2 */
 #define TSSI_TRIM_CH_GROUP_NUM 8
 #define TSSI_TRIM_CH_GROUP_NUM_6G 16
@@ -3174,6 +3182,8 @@ struct rtw89_cfo_tracking_info {
 #define TSSI_MCS_6G_CH_GROUP_NUM 32
 #define TSSI_MCS_CH_GROUP_NUM \
 	(TSSI_MCS_2G_CH_GROUP_NUM + TSSI_MCS_5G_CH_GROUP_NUM)
+#define TSSI_MAX_CH_NUM 67
+#define TSSI_ALIMK_VALUE_NUM 8
 
 struct rtw89_tssi_info {
 	u8 thermal[RF_PATH_MAX];
@@ -3186,6 +3196,11 @@ struct rtw89_tssi_info {
 	bool tssi_tracking_check[RF_PATH_MAX];
 	u8 default_txagc_offset[RF_PATH_MAX];
 	u32 base_thermal[RF_PATH_MAX];
+	bool check_backup_aligmk[RF_PATH_MAX][TSSI_MAX_CH_NUM];
+	u32 alignment_backup_by_ch[RF_PATH_MAX][TSSI_MAX_CH_NUM][TSSI_ALIMK_VALUE_NUM];
+	u32 alignment_value[RF_PATH_MAX][TSSI_ALIMK_MAX][TSSI_ALIMK_VALUE_NUM];
+	bool alignment_done[RF_PATH_MAX][TSSI_ALIMK_MAX];
+	u32 tssi_alimk_time;
 };
 
 struct rtw89_power_trim_info {
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 6dc078969d588..4393b409cbe6f 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3389,6 +3389,8 @@
 #define RR_TXGA_TRK_EN BIT(7)
 #define RR_TXGA_LOK_EXT GENMASK(4, 0)
 #define RR_TXGA_LOK_EN BIT(0)
+#define RR_TXGA_V1 0x10055
+#define RR_TXGA_V1_TRK_EN BIT(7)
 #define RR_GAINTX 0x56
 #define RR_GAINTX_ALL GENMASK(15, 0)
 #define RR_GAINTX_PAD GENMASK(9, 5)
@@ -3730,6 +3732,9 @@
 #define B_TXAGC_TP GENMASK(2, 0)
 #define R_TSSI_THER 0x1C10
 #define B_TSSI_THER GENMASK(29, 24)
+#define R_TSSI_CWRPT 0x1C18
+#define B_TSSI_CWRPT_RDY BIT(16)
+#define B_TSSI_CWRPT GENMASK(8, 0)
 #define R_TXAGC_BTP 0x1CA0
 #define B_TXAGC_BTP GENMASK(31, 24)
 #define R_TXAGC_BB 0x1C60
@@ -4092,6 +4097,20 @@
 #define B_CFO_COMP_VALID_BIT BIT(29)
 #define B_CFO_COMP_WEIGHT_MSK GENMASK(27, 24)
 #define B_CFO_COMP_VAL_MSK GENMASK(11, 0)
+#define R_TSSI_PA_K1 0x5600
+#define R_TSSI_PA_K2 0x5604
+#define R_P0_TSSI_ALIM1 0x5630
+#define B_P0_TSSI_ALIM1 GENMASK(29, 0)
+#define B_P0_TSSI_ALIM11 GENMASK(29, 20)
+#define B_P0_TSSI_ALIM12 GENMASK(19, 10)
+#define B_P0_TSSI_ALIM13 GENMASK(9, 0)
+#define R_P0_TSSI_ALIM3 0x5634
+#define B_P0_TSSI_ALIM31 GENMASK(9, 0)
+#define R_TSSI_PA_K5 0x5638
+#define R_P0_TSSI_ALIM2 0x563c
+#define B_P0_TSSI_ALIM2 GENMASK(29, 0)
+#define R_P0_TSSI_ALIM4 0x5640
+#define R_TSSI_PA_K8 0x5644
 #define R_UPD_CLK 0x5670
 #define B_DAC_VAL BIT(31)
 #define B_ACK_VAL GENMASK(30, 29)
@@ -4106,6 +4125,8 @@
 #define B_DPD_TSSI_CW GENMASK(26, 18)
 #define B_DPD_PWR_CW GENMASK(17, 9)
 #define B_DPD_REF GENMASK(8, 0)
+#define R_P0_TSSIC 0x5814
+#define B_P0_TSSIC_BYPASS BIT(11)
 #define R_DPD_OFT_ADDR 0x5804
 #define B_DPD_OFT_ADDR GENMASK(31, 27)
 #define R_TXPWRB_H 0x580c
@@ -4114,11 +4135,15 @@
 #define B_P0_TMETER GENMASK(15, 10)
 #define B_P0_TMETER_DIS BIT(16)
 #define B_P0_TMETER_TRK BIT(24)
+#define R_P1_TSSIC 0x7814
+#define B_P1_TSSIC_BYPASS BIT(11)
 #define R_P0_TSSI_TRK 0x5818
 #define B_P0_TSSI_TRK_EN BIT(30)
+#define B_P0_TSSI_RFC GENMASK(28, 27)
 #define B_P0_TSSI_OFT_EN BIT(28)
 #define B_P0_TSSI_OFT GENMASK(7, 0)
 #define R_P0_TSSI_AVG 0x5820
+#define B_P0_TSSI_EN BIT(31)
 #define B_P0_TSSI_AVG GENMASK(15, 12)
 #define R_P0_RFCTM 0x5864
 #define B_P0_RFCTM_EN BIT(29)
@@ -4141,7 +4166,9 @@
 #define B_P0_TXPW_RSTB_MANON BIT(30)
 #define B_P0_TXPW_RSTB_TSSI BIT(31)
 #define R_P0_TSSI_MV_AVG 0x58E4
+#define B_P0_TSSI_MV_MIX GENMASK(19, 11)
 #define B_P0_TSSI_MV_AVG GENMASK(13, 11)
+#define B_P0_TSSI_MV_CLR BIT(14)
 #define R_TXGAIN_SCALE 0x58F0
 #define B_TXGAIN_SCALE_EN BIT(19)
 #define B_TXGAIN_SCALE_OFT GENMASK(31, 24)
@@ -4166,25 +4193,41 @@
 #define B_S0_DACKQ8_K GENMASK(15, 8)
 #define R_RPL_BIAS_COMP1 0x6DF0
 #define B_RPL_BIAS_COMP1_MASK GENMASK(7, 0)
+#define R_P1_TSSI_ALIM1 0x7630
+#define B_P1_TSSI_ALIM1 GENMASK(29, 0)
+#define B_P1_TSSI_ALIM11 GENMASK(29, 20)
+#define B_P1_TSSI_ALIM12 GENMASK(19, 10)
+#define B_P1_TSSI_ALIM13 GENMASK(9, 0)
+#define R_P1_TSSI_ALIM3 0x7634
+#define B_P1_TSSI_ALIM31 GENMASK(9, 0)
+#define R_P1_TSSI_ALIM2 0x763c
+#define B_P1_TSSI_ALIM2 GENMASK(29, 0)
+#define R_P1_TSSIC 0x7814
+#define B_P1_TSSIC_BYPASS BIT(11)
 #define R_P1_TMETER 0x7810
 #define B_P1_TMETER GENMASK(15, 10)
 #define B_P1_TMETER_DIS BIT(16)
 #define B_P1_TMETER_TRK BIT(24)
 #define R_P1_TSSI_TRK 0x7818
 #define B_P1_TSSI_TRK_EN BIT(30)
+#define B_P1_TSSI_RFC GENMASK(28, 27)
 #define B_P1_TSSI_OFT_EN BIT(28)
 #define B_P1_TSSI_OFT GENMASK(7, 0)
 #define R_P1_TSSI_AVG 0x7820
+#define B_P1_TSSI_EN BIT(31)
 #define B_P1_TSSI_AVG GENMASK(15, 12)
 #define R_P1_RFCTM 0x7864
 #define R_P1_RFCTM_RDY BIT(26)
 #define B_P1_RFCTM_VAL GENMASK(25, 20)
+#define B_P1_RFCTM_DEL GENMASK(19, 11)
 #define R_P1_PATH_RST 0x78AC
 #define R_P1_TXPW_RSTB 0x78DC
 #define B_P1_TXPW_RSTB_MANON BIT(30)
 #define B_P1_TXPW_RSTB_TSSI BIT(31)
 #define R_P1_TSSI_MV_AVG 0x78E4
+#define B_P1_TSSI_MV_MIX GENMASK(19, 11)
 #define B_P1_TSSI_MV_AVG GENMASK(13, 11)
+#define B_P1_TSSI_MV_CLR BIT(14)
 #define R_TSSI_THOF 0x7C00
 #define R_S1_DACKI 0x7E00
 #define B_S1_DACKI_AR GENMASK(31, 28)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
index 466f908e0214a..d0ac883772c11 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
@@ -16,6 +16,9 @@
 #define RTW8852B_IQK_VER 0x2a
 #define RTW8852B_IQK_SS 2
 #define RTW8852B_RXK_GROUP_NR 4
+#define RTW8852B_TSSI_PATH_NR 2
+
+#define _TSSI_DE_MASK GENMASK(21, 12)
 #define ADDC_T_AVG 100
 
 enum rtw8852b_iqk_type {
@@ -35,6 +38,21 @@ enum rtw8852b_iqk_type {
 	ID_IQK_RESTORE = 0x10,
 };
 
+static const u32 _tssi_trigger[RTW8852B_TSSI_PATH_NR] = {0x5820, 0x7820};
+static const u32 _tssi_cw_rpt_addr[RTW8852B_TSSI_PATH_NR] = {0x1c18, 0x3c18};
+static const u32 _tssi_cw_default_addr[RTW8852B_TSSI_PATH_NR][4] = {
+	{0x5634, 0x5630, 0x5630, 0x5630},
+	{0x7634, 0x7630, 0x7630, 0x7630} };
+static const u32 _tssi_cw_default_mask[4] = {
+	0x000003ff, 0x3ff00000, 0x000ffc00, 0x000003ff};
+static const u32 _tssi_de_cck_long[RF_PATH_NUM_8852B] = {0x5858, 0x7858};
+static const u32 _tssi_de_cck_short[RF_PATH_NUM_8852B] = {0x5860, 0x7860};
+static const u32 _tssi_de_mcs_20m[RF_PATH_NUM_8852B] = {0x5838, 0x7838};
+static const u32 _tssi_de_mcs_40m[RF_PATH_NUM_8852B] = {0x5840, 0x7840};
+static const u32 _tssi_de_mcs_80m[RF_PATH_NUM_8852B] = {0x5848, 0x7848};
+static const u32 _tssi_de_mcs_80m_80m[RF_PATH_NUM_8852B] = {0x5850, 0x7850};
+static const u32 _tssi_de_mcs_5m[RF_PATH_NUM_8852B] = {0x5828, 0x7828};
+static const u32 _tssi_de_mcs_10m[RF_PATH_NUM_8852B] = {0x5830, 0x7830};
 static const u32 _a_idxrxgain[RTW8852B_RXK_GROUP_NR] = {0x190, 0x198, 0x350, 0x352};
 static const u32 _a_idxattc2[RTW8852B_RXK_GROUP_NR] = {0x0f, 0x0f, 0x3f, 0x7f};
 static const u32 _a_idxattc1[RTW8852B_RXK_GROUP_NR] = {0x3, 0x1, 0x0, 0x0};
@@ -1526,6 +1544,15 @@ static void _wait_rx_mode(struct rtw89_dev *rtwdev, u8 kpath)
 	}
 }
 
+static void _tmac_tx_pause(struct rtw89_dev *rtwdev, enum rtw89_phy_idx band_idx,
+			   bool is_pause)
+{
+	if (!is_pause)
+		return;
+
+	_wait_rx_mode(rtwdev, _kpath(rtwdev, band_idx));
+}
+
 static void _doiqk(struct rtw89_dev *rtwdev, bool force,
 		   enum rtw89_phy_idx phy_idx, u8 path)
 {
@@ -1578,6 +1605,1027 @@ static void _iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, bool forc
 	}
 }
 
+static void _tssi_rf_setting(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			     enum rtw89_rf_path path)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	enum rtw89_band band = chan->band_type;
+
+	if (band == RTW89_BAND_2G)
+		rtw89_write_rf(rtwdev, path, RR_TXPOW, RR_TXPOW_TXG, 0x1);
+	else
+		rtw89_write_rf(rtwdev, path, RR_TXPOW, RR_TXPOW_TXA, 0x1);
+}
+
+static void _tssi_set_sys(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			  enum rtw89_rf_path path)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	enum rtw89_band band = chan->band_type;
+
+	rtw89_rfk_parser(rtwdev, &rtw8852b_tssi_sys_defs_tbl);
+
+	if (path == RF_PATH_A)
+		rtw89_rfk_parser_by_cond(rtwdev, band == RTW89_BAND_2G,
+					 &rtw8852b_tssi_sys_a_defs_2g_tbl,
+					 &rtw8852b_tssi_sys_a_defs_5g_tbl);
+	else
+		rtw89_rfk_parser_by_cond(rtwdev, band == RTW89_BAND_2G,
+					 &rtw8852b_tssi_sys_b_defs_2g_tbl,
+					 &rtw8852b_tssi_sys_b_defs_5g_tbl);
+}
+
+static void _tssi_ini_txpwr_ctrl_bb(struct rtw89_dev *rtwdev,
+				    enum rtw89_phy_idx phy,
+				    enum rtw89_rf_path path)
+{
+	rtw89_rfk_parser_by_cond(rtwdev, path == RF_PATH_A,
+				 &rtw8852b_tssi_init_txpwr_defs_a_tbl,
+				 &rtw8852b_tssi_init_txpwr_defs_b_tbl);
+}
+
+static void _tssi_ini_txpwr_ctrl_bb_he_tb(struct rtw89_dev *rtwdev,
+					  enum rtw89_phy_idx phy,
+					  enum rtw89_rf_path path)
+{
+	rtw89_rfk_parser_by_cond(rtwdev, path == RF_PATH_A,
+				 &rtw8852b_tssi_init_txpwr_he_tb_defs_a_tbl,
+				 &rtw8852b_tssi_init_txpwr_he_tb_defs_b_tbl);
+}
+
+static void _tssi_set_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			  enum rtw89_rf_path path)
+{
+	rtw89_rfk_parser_by_cond(rtwdev, path == RF_PATH_A,
+				 &rtw8852b_tssi_dck_defs_a_tbl,
+				 &rtw8852b_tssi_dck_defs_b_tbl);
+}
+
+static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+				 enum rtw89_rf_path path)
+{
+#define RTW8852B_TSSI_GET_VAL(ptr, idx)			\
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
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 ch = chan->channel;
+	u8 subband = chan->subband_type;
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
+		thm_up_a = rtw89_8852b_trk_cfg.delta_swingidx_2ga_p;
+		thm_down_a = rtw89_8852b_trk_cfg.delta_swingidx_2ga_n;
+		thm_up_b = rtw89_8852b_trk_cfg.delta_swingidx_2gb_p;
+		thm_down_b = rtw89_8852b_trk_cfg.delta_swingidx_2gb_n;
+		break;
+	case RTW89_CH_5G_BAND_1:
+		thm_up_a = rtw89_8852b_trk_cfg.delta_swingidx_5ga_p[0];
+		thm_down_a = rtw89_8852b_trk_cfg.delta_swingidx_5ga_n[0];
+		thm_up_b = rtw89_8852b_trk_cfg.delta_swingidx_5gb_p[0];
+		thm_down_b = rtw89_8852b_trk_cfg.delta_swingidx_5gb_n[0];
+		break;
+	case RTW89_CH_5G_BAND_3:
+		thm_up_a = rtw89_8852b_trk_cfg.delta_swingidx_5ga_p[1];
+		thm_down_a = rtw89_8852b_trk_cfg.delta_swingidx_5ga_n[1];
+		thm_up_b = rtw89_8852b_trk_cfg.delta_swingidx_5gb_p[1];
+		thm_down_b = rtw89_8852b_trk_cfg.delta_swingidx_5gb_n[1];
+		break;
+	case RTW89_CH_5G_BAND_4:
+		thm_up_a = rtw89_8852b_trk_cfg.delta_swingidx_5ga_p[2];
+		thm_down_a = rtw89_8852b_trk_cfg.delta_swingidx_5ga_n[2];
+		thm_up_b = rtw89_8852b_trk_cfg.delta_swingidx_5gb_p[2];
+		thm_down_b = rtw89_8852b_trk_cfg.delta_swingidx_5gb_n[2];
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
+					    R_P0_TSSI_BASE + i, 0x0);
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
+				tmp = RTW8852B_TSSI_GET_VAL(thm_ofst, i);
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
+				tmp = RTW8852B_TSSI_GET_VAL(thm_ofst, i);
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
+#undef RTW8852B_TSSI_GET_VAL
+}
+
+static void _tssi_set_dac_gain_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+				   enum rtw89_rf_path path)
+{
+	rtw89_rfk_parser_by_cond(rtwdev, path == RF_PATH_A,
+				 &rtw8852b_tssi_dac_gain_defs_a_tbl,
+				 &rtw8852b_tssi_dac_gain_defs_b_tbl);
+}
+
+static void _tssi_slope_cal_org(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+				enum rtw89_rf_path path)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	enum rtw89_band band = chan->band_type;
+
+	if (path == RF_PATH_A)
+		rtw89_rfk_parser_by_cond(rtwdev, band == RTW89_BAND_2G,
+					 &rtw8852b_tssi_slope_a_defs_2g_tbl,
+					 &rtw8852b_tssi_slope_a_defs_5g_tbl);
+	else
+		rtw89_rfk_parser_by_cond(rtwdev, band == RTW89_BAND_2G,
+					 &rtw8852b_tssi_slope_b_defs_2g_tbl,
+					 &rtw8852b_tssi_slope_b_defs_5g_tbl);
+}
+
+static void _tssi_alignment_default(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+				    enum rtw89_rf_path path, bool all)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	enum rtw89_band band = chan->band_type;
+	const struct rtw89_rfk_tbl *tbl = NULL;
+	u8 ch = chan->channel;
+
+	if (path == RF_PATH_A) {
+		if (band == RTW89_BAND_2G) {
+			if (all)
+				tbl = &rtw8852b_tssi_align_a_2g_all_defs_tbl;
+			else
+				tbl = &rtw8852b_tssi_align_a_2g_part_defs_tbl;
+		} else if (ch >= 36 && ch <= 64) {
+			if (all)
+				tbl = &rtw8852b_tssi_align_a_5g1_all_defs_tbl;
+			else
+				tbl = &rtw8852b_tssi_align_a_5g1_part_defs_tbl;
+		} else if (ch >= 100 && ch <= 144) {
+			if (all)
+				tbl = &rtw8852b_tssi_align_a_5g2_all_defs_tbl;
+			else
+				tbl = &rtw8852b_tssi_align_a_5g2_part_defs_tbl;
+		} else if (ch >= 149 && ch <= 177) {
+			if (all)
+				tbl = &rtw8852b_tssi_align_a_5g3_all_defs_tbl;
+			else
+				tbl = &rtw8852b_tssi_align_a_5g3_part_defs_tbl;
+		}
+	} else {
+		if (ch >= 1 && ch <= 14) {
+			if (all)
+				tbl = &rtw8852b_tssi_align_b_2g_all_defs_tbl;
+			else
+				tbl = &rtw8852b_tssi_align_b_2g_part_defs_tbl;
+		} else if (ch >= 36 && ch <= 64) {
+			if (all)
+				tbl = &rtw8852b_tssi_align_b_5g1_all_defs_tbl;
+			else
+				tbl = &rtw8852b_tssi_align_b_5g1_part_defs_tbl;
+		} else if (ch >= 100 && ch <= 144) {
+			if (all)
+				tbl = &rtw8852b_tssi_align_b_5g2_all_defs_tbl;
+			else
+				tbl = &rtw8852b_tssi_align_b_5g2_part_defs_tbl;
+		} else if (ch >= 149 && ch <= 177) {
+			if (all)
+				tbl = &rtw8852b_tssi_align_b_5g3_all_defs_tbl;
+			else
+				tbl = &rtw8852b_tssi_align_b_5g3_part_defs_tbl;
+		}
+	}
+
+	if (tbl)
+		rtw89_rfk_parser(rtwdev, tbl);
+}
+
+static void _tssi_set_tssi_slope(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+				 enum rtw89_rf_path path)
+{
+	rtw89_rfk_parser_by_cond(rtwdev, path == RF_PATH_A,
+				 &rtw8852b_tssi_slope_defs_a_tbl,
+				 &rtw8852b_tssi_slope_defs_b_tbl);
+}
+
+static void _tssi_set_tssi_track(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+				 enum rtw89_rf_path path)
+{
+	if (path == RF_PATH_A)
+		rtw89_phy_write32_mask(rtwdev, R_P0_TSSIC, B_P0_TSSIC_BYPASS, 0x0);
+	else
+		rtw89_phy_write32_mask(rtwdev, R_P1_TSSIC, B_P1_TSSIC_BYPASS, 0x0);
+}
+
+static void _tssi_set_txagc_offset_mv_avg(struct rtw89_dev *rtwdev,
+					  enum rtw89_phy_idx phy,
+					  enum rtw89_rf_path path)
+{
+	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "======>%s   path=%d\n", __func__,
+		    path);
+
+	if (path == RF_PATH_A)
+		rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_MV_AVG, B_P0_TSSI_MV_MIX, 0x010);
+	else
+		rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_MV_AVG, B_P1_RFCTM_DEL, 0x010);
+}
+
+static void _tssi_enable(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+{
+	u8 i;
+
+	for (i = 0; i < RF_PATH_NUM_8852B; i++) {
+		_tssi_set_tssi_track(rtwdev, phy, i);
+		_tssi_set_txagc_offset_mv_avg(rtwdev, phy, i);
+
+		if (i == RF_PATH_A) {
+			rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_MV_AVG,
+					       B_P0_TSSI_MV_CLR, 0x0);
+			rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_AVG,
+					       B_P0_TSSI_EN, 0x0);
+			rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_AVG,
+					       B_P0_TSSI_EN, 0x1);
+			rtw89_write_rf(rtwdev, i, RR_TXGA_V1,
+				       RR_TXGA_V1_TRK_EN, 0x1);
+			rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_TRK,
+					       B_P0_TSSI_RFC, 0x3);
+
+			rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_TRK,
+					       B_P0_TSSI_OFT, 0xc0);
+			rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_TRK,
+					       B_P0_TSSI_OFT_EN, 0x0);
+			rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_TRK,
+					       B_P0_TSSI_OFT_EN, 0x1);
+
+			rtwdev->is_tssi_mode[RF_PATH_A] = true;
+		} else {
+			rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_MV_AVG,
+					       B_P1_TSSI_MV_CLR, 0x0);
+			rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_AVG,
+					       B_P1_TSSI_EN, 0x0);
+			rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_AVG,
+					       B_P1_TSSI_EN, 0x1);
+			rtw89_write_rf(rtwdev, i, RR_TXGA_V1,
+				       RR_TXGA_V1_TRK_EN, 0x1);
+			rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_TRK,
+					       B_P1_TSSI_RFC, 0x3);
+
+			rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_TRK,
+					       B_P1_TSSI_OFT, 0xc0);
+			rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_TRK,
+					       B_P1_TSSI_OFT_EN, 0x0);
+			rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_TRK,
+					       B_P1_TSSI_OFT_EN, 0x1);
+
+			rtwdev->is_tssi_mode[RF_PATH_B] = true;
+		}
+	}
+}
+
+static void _tssi_disable(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+{
+	rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_AVG, B_P0_TSSI_EN, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_TRK, B_P0_TSSI_RFC, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_MV_AVG, B_P0_TSSI_MV_CLR, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_AVG, B_P1_TSSI_EN, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_TRK, B_P1_TSSI_RFC, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_MV_AVG, B_P1_TSSI_MV_CLR, 0x1);
+
+	rtwdev->is_tssi_mode[RF_PATH_A] = false;
+	rtwdev->is_tssi_mode[RF_PATH_B] = false;
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
+static u32 _tssi_get_trim_group(struct rtw89_dev *rtwdev, u8 ch)
+{
+	switch (ch) {
+	case 1 ... 8:
+		return 0;
+	case 9 ... 14:
+		return 1;
+	case 36 ... 48:
+		return 2;
+	case 52 ... 64:
+		return 3;
+	case 100 ... 112:
+		return 4;
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
+static s8 _tssi_get_ofdm_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			    enum rtw89_rf_path path)
+{
+	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 ch = chan->channel;
+	u32 gidx, gidx_1st, gidx_2nd;
+	s8 de_1st;
+	s8 de_2nd;
+	s8 val;
+
+	gidx = _tssi_get_ofdm_group(rtwdev, ch);
+
+	rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+		    "[TSSI][TRIM]: path=%d mcs group_idx=0x%x\n", path, gidx);
+
+	if (IS_TSSI_EXTRA_GROUP(gidx)) {
+		gidx_1st = TSSI_EXTRA_GET_GROUP_IDX1(gidx);
+		gidx_2nd = TSSI_EXTRA_GET_GROUP_IDX2(gidx);
+		de_1st = tssi_info->tssi_mcs[path][gidx_1st];
+		de_2nd = tssi_info->tssi_mcs[path][gidx_2nd];
+		val = (de_1st + de_2nd) / 2;
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM]: path=%d mcs de=%d 1st=%d 2nd=%d\n",
+			    path, val, de_1st, de_2nd);
+	} else {
+		val = tssi_info->tssi_mcs[path][gidx];
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM]: path=%d mcs de=%d\n", path, val);
+	}
+
+	return val;
+}
+
+static s8 _tssi_get_ofdm_trim_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+				 enum rtw89_rf_path path)
+{
+	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 ch = chan->channel;
+	u32 tgidx, tgidx_1st, tgidx_2nd;
+	s8 tde_1st;
+	s8 tde_2nd;
+	s8 val;
+
+	tgidx = _tssi_get_trim_group(rtwdev, ch);
+
+	rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+		    "[TSSI][TRIM]: path=%d mcs trim_group_idx=0x%x\n",
+		    path, tgidx);
+
+	if (IS_TSSI_EXTRA_GROUP(tgidx)) {
+		tgidx_1st = TSSI_EXTRA_GET_GROUP_IDX1(tgidx);
+		tgidx_2nd = TSSI_EXTRA_GET_GROUP_IDX2(tgidx);
+		tde_1st = tssi_info->tssi_trim[path][tgidx_1st];
+		tde_2nd = tssi_info->tssi_trim[path][tgidx_2nd];
+		val = (tde_1st + tde_2nd) / 2;
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM]: path=%d mcs trim_de=%d 1st=%d 2nd=%d\n",
+			    path, val, tde_1st, tde_2nd);
+	} else {
+		val = tssi_info->tssi_trim[path][tgidx];
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM]: path=%d mcs trim_de=%d\n",
+			    path, val);
+	}
+
+	return val;
+}
+
+static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+{
+	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 ch = chan->channel;
+	u8 gidx;
+	s8 ofdm_de;
+	s8 trim_de;
+	s32 val;
+	u32 i;
+
+	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "[TSSI][TRIM]: phy=%d ch=%d\n",
+		    phy, ch);
+
+	for (i = RF_PATH_A; i < RF_PATH_NUM_8852B; i++) {
+		gidx = _tssi_get_cck_group(rtwdev, ch);
+		trim_de = _tssi_get_ofdm_trim_de(rtwdev, phy, i);
+		val = tssi_info->tssi_cck[i][gidx] + trim_de;
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM]: path=%d cck[%d]=0x%x trim=0x%x\n",
+			    i, gidx, tssi_info->tssi_cck[i][gidx], trim_de);
+
+		rtw89_phy_write32_mask(rtwdev, _tssi_de_cck_long[i], _TSSI_DE_MASK, val);
+		rtw89_phy_write32_mask(rtwdev, _tssi_de_cck_short[i], _TSSI_DE_MASK, val);
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI] Set TSSI CCK DE 0x%x[21:12]=0x%x\n",
+			    _tssi_de_cck_long[i],
+			    rtw89_phy_read32_mask(rtwdev, _tssi_de_cck_long[i],
+						  _TSSI_DE_MASK));
+
+		ofdm_de = _tssi_get_ofdm_de(rtwdev, phy, i);
+		trim_de = _tssi_get_ofdm_trim_de(rtwdev, phy, i);
+		val = ofdm_de + trim_de;
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM]: path=%d mcs=0x%x trim=0x%x\n",
+			    i, ofdm_de, trim_de);
+
+		rtw89_phy_write32_mask(rtwdev, _tssi_de_mcs_20m[i], _TSSI_DE_MASK, val);
+		rtw89_phy_write32_mask(rtwdev, _tssi_de_mcs_40m[i], _TSSI_DE_MASK, val);
+		rtw89_phy_write32_mask(rtwdev, _tssi_de_mcs_80m[i], _TSSI_DE_MASK, val);
+		rtw89_phy_write32_mask(rtwdev, _tssi_de_mcs_80m_80m[i], _TSSI_DE_MASK, val);
+		rtw89_phy_write32_mask(rtwdev, _tssi_de_mcs_5m[i], _TSSI_DE_MASK, val);
+		rtw89_phy_write32_mask(rtwdev, _tssi_de_mcs_10m[i], _TSSI_DE_MASK, val);
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI] Set TSSI MCS DE 0x%x[21:12]=0x%x\n",
+			    _tssi_de_mcs_20m[i],
+			    rtw89_phy_read32_mask(rtwdev, _tssi_de_mcs_20m[i],
+						  _TSSI_DE_MASK));
+	}
+}
+
+static void _tssi_alimentk_dump_result(struct rtw89_dev *rtwdev, enum rtw89_rf_path path)
+{
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[TSSI PA K]\n0x%x = 0x%08x\n0x%x = 0x%08x\n0x%x = 0x%08x\n0x%x = 0x%08x\n"
+		    "0x%x = 0x%08x\n0x%x = 0x%08x\n0x%x = 0x%08x\n0x%x = 0x%08x\n",
+		    R_TSSI_PA_K1 + (path << 13),
+		    rtw89_phy_read32_mask(rtwdev, R_TSSI_PA_K1 + (path << 13), MASKDWORD),
+		    R_TSSI_PA_K2 + (path << 13),
+		    rtw89_phy_read32_mask(rtwdev, R_TSSI_PA_K2 + (path << 13), MASKDWORD),
+		    R_P0_TSSI_ALIM1 + (path << 13),
+		    rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_ALIM1 + (path << 13), MASKDWORD),
+		    R_P0_TSSI_ALIM3 + (path << 13),
+		    rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_ALIM3 + (path << 13), MASKDWORD),
+		    R_TSSI_PA_K5 + (path << 13),
+		    rtw89_phy_read32_mask(rtwdev, R_TSSI_PA_K5 + (path << 13), MASKDWORD),
+		    R_P0_TSSI_ALIM2 + (path << 13),
+		    rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_ALIM2 + (path << 13), MASKDWORD),
+		    R_P0_TSSI_ALIM4 + (path << 13),
+		    rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_ALIM4 + (path << 13), MASKDWORD),
+		    R_TSSI_PA_K8 + (path << 13),
+		    rtw89_phy_read32_mask(rtwdev, R_TSSI_PA_K8 + (path << 13), MASKDWORD));
+}
+
+static void _tssi_alimentk_done(struct rtw89_dev *rtwdev,
+				enum rtw89_phy_idx phy, enum rtw89_rf_path path)
+{
+	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 channel = chan->channel;
+	u8 band;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "======>%s   phy=%d   path=%d\n", __func__, phy, path);
+
+	if (channel >= 1 && channel <= 14)
+		band = TSSI_ALIMK_2G;
+	else if (channel >= 36 && channel <= 64)
+		band = TSSI_ALIMK_5GL;
+	else if (channel >= 100 && channel <= 144)
+		band = TSSI_ALIMK_5GM;
+	else if (channel >= 149 && channel <= 177)
+		band = TSSI_ALIMK_5GH;
+	else
+		band = TSSI_ALIMK_2G;
+
+	if (tssi_info->alignment_done[path][band]) {
+		rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_ALIM1 + (path << 13), MASKDWORD,
+				       tssi_info->alignment_value[path][band][0]);
+		rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_ALIM3 + (path << 13), MASKDWORD,
+				       tssi_info->alignment_value[path][band][1]);
+		rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_ALIM2 + (path << 13), MASKDWORD,
+				       tssi_info->alignment_value[path][band][2]);
+		rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_ALIM4 + (path << 13), MASKDWORD,
+				       tssi_info->alignment_value[path][band][3]);
+	}
+
+	_tssi_alimentk_dump_result(rtwdev, path);
+}
+
+static void _tssi_hw_tx(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			enum rtw89_rf_path path, u16 cnt, u16 period, s16 pwr_dbm,
+			u8 enable)
+{
+	enum rtw89_rf_path_bit rx_path;
+
+	if (path == RF_PATH_A)
+		rx_path = RF_A;
+	else if (path == RF_PATH_B)
+		rx_path = RF_B;
+	else if (path == RF_PATH_AB)
+		rx_path = RF_AB;
+	else
+		rx_path = RF_ABCD; /* don't change path, but still set others */
+
+	if (enable) {
+		rtw8852b_bb_set_plcp_tx(rtwdev);
+		rtw8852b_bb_cfg_tx_path(rtwdev, path);
+		rtw8852b_bb_ctrl_rx_path(rtwdev, rx_path);
+		rtw8852b_bb_set_power(rtwdev, pwr_dbm, phy);
+	}
+
+	rtw8852b_bb_set_pmac_pkt_tx(rtwdev, enable, cnt, period, 20, phy);
+}
+
+static void _tssi_backup_bb_registers(struct rtw89_dev *rtwdev,
+				      enum rtw89_phy_idx phy, const u32 reg[],
+				      u32 reg_backup[], u32 reg_num)
+{
+	u32 i;
+
+	for (i = 0; i < reg_num; i++) {
+		reg_backup[i] = rtw89_phy_read32_mask(rtwdev, reg[i], MASKDWORD);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[TSSI] Backup BB 0x%x = 0x%x\n", reg[i],
+			    reg_backup[i]);
+	}
+}
+
+static void _tssi_reload_bb_registers(struct rtw89_dev *rtwdev,
+				      enum rtw89_phy_idx phy, const u32 reg[],
+				      u32 reg_backup[], u32 reg_num)
+
+{
+	u32 i;
+
+	for (i = 0; i < reg_num; i++) {
+		rtw89_phy_write32_mask(rtwdev, reg[i], MASKDWORD, reg_backup[i]);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[TSSI] Reload BB 0x%x = 0x%x\n", reg[i],
+			    reg_backup[i]);
+	}
+}
+
+static u8 _tssi_ch_to_idx(struct rtw89_dev *rtwdev, u8 channel)
+{
+	u8 channel_index;
+
+	if (channel >= 1 && channel <= 14)
+		channel_index = channel - 1;
+	else if (channel >= 36 && channel <= 64)
+		channel_index = (channel - 36) / 2 + 14;
+	else if (channel >= 100 && channel <= 144)
+		channel_index = ((channel - 100) / 2) + 15 + 14;
+	else if (channel >= 149 && channel <= 177)
+		channel_index = ((channel - 149) / 2) + 38 + 14;
+	else
+		channel_index = 0;
+
+	return channel_index;
+}
+
+static bool _tssi_get_cw_report(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+				enum rtw89_rf_path path, const s16 *power,
+				u32 *tssi_cw_rpt)
+{
+	u32 tx_counter, tx_counter_tmp;
+	const int retry = 100;
+	u32 tmp;
+	int j, k;
+
+	for (j = 0; j < RTW8852B_TSSI_PATH_NR; j++) {
+		rtw89_phy_write32_mask(rtwdev, _tssi_trigger[path], B_P0_TSSI_EN, 0x0);
+		rtw89_phy_write32_mask(rtwdev, _tssi_trigger[path], B_P0_TSSI_EN, 0x1);
+
+		tx_counter = rtw89_phy_read32_mask(rtwdev, R_TX_COUNTER, MASKLWORD);
+
+		tmp = rtw89_phy_read32_mask(rtwdev, _tssi_trigger[path], MASKDWORD);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[TSSI PA K] 0x%x = 0x%08x   path=%d\n",
+			    _tssi_trigger[path], tmp, path);
+
+		if (j == 0)
+			_tssi_hw_tx(rtwdev, phy, path, 100, 5000, power[j], true);
+		else
+			_tssi_hw_tx(rtwdev, phy, RF_PATH_ABCD, 100, 5000, power[j], true);
+
+		tx_counter_tmp = rtw89_phy_read32_mask(rtwdev, R_TX_COUNTER, MASKLWORD);
+		tx_counter_tmp -= tx_counter;
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[TSSI PA K] First HWTXcounter=%d path=%d\n",
+			    tx_counter_tmp, path);
+
+		for (k = 0; k < retry; k++) {
+			tmp = rtw89_phy_read32_mask(rtwdev, _tssi_cw_rpt_addr[path],
+						    B_TSSI_CWRPT_RDY);
+			if (tmp)
+				break;
+
+			udelay(30);
+
+			tx_counter_tmp =
+				rtw89_phy_read32_mask(rtwdev, R_TX_COUNTER, MASKLWORD);
+			tx_counter_tmp -= tx_counter;
+
+			rtw89_debug(rtwdev, RTW89_DBG_RFK,
+				    "[TSSI PA K] Flow k = %d HWTXcounter=%d path=%d\n",
+				    k, tx_counter_tmp, path);
+		}
+
+		if (k >= retry) {
+			rtw89_debug(rtwdev, RTW89_DBG_RFK,
+				    "[TSSI PA K] TSSI finish bit k > %d mp:100ms normal:30us path=%d\n",
+				    k, path);
+
+			_tssi_hw_tx(rtwdev, phy, path, 100, 5000, power[j], false);
+			return false;
+		}
+
+		tssi_cw_rpt[j] =
+			rtw89_phy_read32_mask(rtwdev, _tssi_cw_rpt_addr[path], B_TSSI_CWRPT);
+
+		_tssi_hw_tx(rtwdev, phy, path, 100, 5000, power[j], false);
+
+		tx_counter_tmp = rtw89_phy_read32_mask(rtwdev, R_TX_COUNTER, MASKLWORD);
+		tx_counter_tmp -= tx_counter;
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[TSSI PA K] Final HWTXcounter=%d path=%d\n",
+			    tx_counter_tmp, path);
+	}
+
+	return true;
+}
+
+static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			   enum rtw89_rf_path path)
+{
+	static const u32 bb_reg[8] = {0x5820, 0x7820, 0x4978, 0x58e4,
+				      0x78e4, 0x49c0, 0x0d18, 0x0d80};
+	static const s16 power_2g[4] = {48, 20, 4, 4};
+	static const s16 power_5g[4] = {48, 20, 4, 4};
+	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	s32 tssi_alim_offset_1, tssi_alim_offset_2, tssi_alim_offset_3;
+	u32 tssi_cw_rpt[RTW8852B_TSSI_PATH_NR] = {0};
+	u8 channel = chan->channel;
+	u8 ch_idx = _tssi_ch_to_idx(rtwdev, channel);
+	struct rtw8852b_bb_tssi_bak tssi_bak;
+	s32 aliment_diff, tssi_cw_default;
+	u32 start_time, finish_time;
+	u32 bb_reg_backup[8] = {0};
+	const s16 *power;
+	u8 band;
+	bool ok;
+	u32 tmp;
+	u8 j;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "======> %s   channel=%d   path=%d\n", __func__, channel,
+		    path);
+
+	if (tssi_info->check_backup_aligmk[path][ch_idx]) {
+		rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_ALIM1 + (path << 13), MASKDWORD,
+				       tssi_info->alignment_backup_by_ch[path][ch_idx][0]);
+		rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_ALIM3 + (path << 13), MASKDWORD,
+				       tssi_info->alignment_backup_by_ch[path][ch_idx][1]);
+		rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_ALIM2 + (path << 13), MASKDWORD,
+				       tssi_info->alignment_backup_by_ch[path][ch_idx][2]);
+		rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_ALIM4 + (path << 13), MASKDWORD,
+				       tssi_info->alignment_backup_by_ch[path][ch_idx][3]);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "======> %s   Reload TSSI Alignment !!!\n", __func__);
+		_tssi_alimentk_dump_result(rtwdev, path);
+		return;
+	}
+
+	start_time = ktime_get_ns();
+
+	if (chan->band_type == RTW89_BAND_2G)
+		power = power_2g;
+	else
+		power = power_5g;
+
+	if (channel >= 1 && channel <= 14)
+		band = TSSI_ALIMK_2G;
+	else if (channel >= 36 && channel <= 64)
+		band = TSSI_ALIMK_5GL;
+	else if (channel >= 100 && channel <= 144)
+		band = TSSI_ALIMK_5GM;
+	else if (channel >= 149 && channel <= 177)
+		band = TSSI_ALIMK_5GH;
+	else
+		band = TSSI_ALIMK_2G;
+
+	rtw8852b_bb_backup_tssi(rtwdev, phy, &tssi_bak);
+	_tssi_backup_bb_registers(rtwdev, phy, bb_reg, bb_reg_backup, ARRAY_SIZE(bb_reg_backup));
+
+	rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_AVG, B_P0_TSSI_AVG, 0x8);
+	rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_AVG, B_P1_TSSI_AVG, 0x8);
+	rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_MV_AVG, B_P0_TSSI_MV_AVG, 0x2);
+	rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_MV_AVG, B_P1_TSSI_MV_AVG, 0x2);
+
+	ok = _tssi_get_cw_report(rtwdev, phy, path, power, tssi_cw_rpt);
+	if (!ok)
+		goto out;
+
+	for (j = 0; j < RTW8852B_TSSI_PATH_NR; j++) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[TSSI PA K] power[%d]=%d  tssi_cw_rpt[%d]=%d\n", j,
+			    power[j], j, tssi_cw_rpt[j]);
+	}
+
+	tmp = rtw89_phy_read32_mask(rtwdev, _tssi_cw_default_addr[path][1],
+				    _tssi_cw_default_mask[1]);
+	tssi_cw_default = sign_extend32(tmp, 8);
+	tssi_alim_offset_1 = tssi_cw_rpt[0] - ((power[0] - power[1]) * 2) -
+			     tssi_cw_rpt[1] + tssi_cw_default;
+	aliment_diff = tssi_alim_offset_1 - tssi_cw_default;
+
+	tmp = rtw89_phy_read32_mask(rtwdev, _tssi_cw_default_addr[path][2],
+				    _tssi_cw_default_mask[2]);
+	tssi_cw_default = sign_extend32(tmp, 8);
+	tssi_alim_offset_2 = tssi_cw_default + aliment_diff;
+
+	tmp = rtw89_phy_read32_mask(rtwdev, _tssi_cw_default_addr[path][3],
+				    _tssi_cw_default_mask[3]);
+	tssi_cw_default = sign_extend32(tmp, 8);
+	tssi_alim_offset_3 = tssi_cw_default + aliment_diff;
+
+	if (path == RF_PATH_A) {
+		tmp = FIELD_PREP(B_P1_TSSI_ALIM11, tssi_alim_offset_1) |
+		      FIELD_PREP(B_P1_TSSI_ALIM12, tssi_alim_offset_2) |
+		      FIELD_PREP(B_P1_TSSI_ALIM13, tssi_alim_offset_3);
+
+		rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_ALIM1, B_P0_TSSI_ALIM1, tmp);
+		rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_ALIM2, B_P0_TSSI_ALIM2, tmp);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[TSSI PA K] tssi_alim_offset = 0x%x   0x%x   0x%x   0x%x\n",
+			    rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_ALIM3, B_P0_TSSI_ALIM31),
+			    rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_ALIM1, B_P0_TSSI_ALIM11),
+			    rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_ALIM1, B_P0_TSSI_ALIM12),
+			    rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_ALIM1, B_P0_TSSI_ALIM13));
+	} else {
+		tmp = FIELD_PREP(B_P1_TSSI_ALIM11, tssi_alim_offset_1) |
+		      FIELD_PREP(B_P1_TSSI_ALIM12, tssi_alim_offset_2) |
+		      FIELD_PREP(B_P1_TSSI_ALIM13, tssi_alim_offset_3);
+
+		rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_ALIM1, B_P1_TSSI_ALIM1, tmp);
+		rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_ALIM2, B_P1_TSSI_ALIM2, tmp);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[TSSI PA K] tssi_alim_offset = 0x%x   0x%x   0x%x   0x%x\n",
+			    rtw89_phy_read32_mask(rtwdev, R_P1_TSSI_ALIM3, B_P1_TSSI_ALIM31),
+			    rtw89_phy_read32_mask(rtwdev, R_P1_TSSI_ALIM1, B_P1_TSSI_ALIM11),
+			    rtw89_phy_read32_mask(rtwdev, R_P1_TSSI_ALIM1, B_P1_TSSI_ALIM12),
+			    rtw89_phy_read32_mask(rtwdev, R_P1_TSSI_ALIM1, B_P1_TSSI_ALIM13));
+	}
+
+	tssi_info->alignment_done[path][band] = true;
+	tssi_info->alignment_value[path][band][0] =
+		rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_ALIM1 + (path << 13), MASKDWORD);
+	tssi_info->alignment_value[path][band][1] =
+		rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_ALIM3 + (path << 13), MASKDWORD);
+	tssi_info->alignment_value[path][band][2] =
+		rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_ALIM2 + (path << 13), MASKDWORD);
+	tssi_info->alignment_value[path][band][3] =
+		rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_ALIM4 + (path << 13), MASKDWORD);
+
+	tssi_info->check_backup_aligmk[path][ch_idx] = true;
+	tssi_info->alignment_backup_by_ch[path][ch_idx][0] =
+		rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_ALIM1 + (path << 13), MASKDWORD);
+	tssi_info->alignment_backup_by_ch[path][ch_idx][1] =
+		rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_ALIM3 + (path << 13), MASKDWORD);
+	tssi_info->alignment_backup_by_ch[path][ch_idx][2] =
+		rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_ALIM2 + (path << 13), MASKDWORD);
+	tssi_info->alignment_backup_by_ch[path][ch_idx][3] =
+		rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_ALIM4 + (path << 13), MASKDWORD);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[TSSI PA K] tssi_info->alignment_value[path=%d][band=%d][0], 0x%x = 0x%08x\n",
+		    path, band, R_P0_TSSI_ALIM1 + (path << 13),
+		    tssi_info->alignment_value[path][band][0]);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[TSSI PA K] tssi_info->alignment_value[path=%d][band=%d][1], 0x%x = 0x%08x\n",
+		    path, band, R_P0_TSSI_ALIM3 + (path << 13),
+		    tssi_info->alignment_value[path][band][1]);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[TSSI PA K] tssi_info->alignment_value[path=%d][band=%d][2], 0x%x = 0x%08x\n",
+		    path, band, R_P0_TSSI_ALIM2 + (path << 13),
+		    tssi_info->alignment_value[path][band][2]);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[TSSI PA K] tssi_info->alignment_value[path=%d][band=%d][3], 0x%x = 0x%08x\n",
+		    path, band, R_P0_TSSI_ALIM4 + (path << 13),
+		    tssi_info->alignment_value[path][band][3]);
+
+out:
+	_tssi_reload_bb_registers(rtwdev, phy, bb_reg, bb_reg_backup, ARRAY_SIZE(bb_reg_backup));
+	rtw8852b_bb_restore_tssi(rtwdev, phy, &tssi_bak);
+	rtw8852b_bb_tx_mode_switch(rtwdev, phy, 0);
+
+	finish_time = ktime_get_ns();
+	tssi_info->tssi_alimk_time += finish_time - start_time;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[TSSI PA K] %s processing time = %d ms\n", __func__,
+		    tssi_info->tssi_alimk_time);
+}
+
 void rtw8852b_rck(struct rtw89_dev *rtwdev)
 {
 	u8 path;
@@ -1626,6 +2674,132 @@ void rtw8852b_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_RXDCK, BTC_WRFK_STOP);
 }
 
+void rtw8852b_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool hwtx_en)
+{
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy, RF_AB);
+	u32 tx_en;
+	u8 i;
+
+	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "[TSSI] %s: phy=%d\n", __func__, phy);
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_ONESHOT_START);
+
+	_tssi_disable(rtwdev, phy);
+
+	for (i = RF_PATH_A; i < RF_PATH_NUM_8852B; i++) {
+		_tssi_rf_setting(rtwdev, phy, i);
+		_tssi_set_sys(rtwdev, phy, i);
+		_tssi_ini_txpwr_ctrl_bb(rtwdev, phy, i);
+		_tssi_ini_txpwr_ctrl_bb_he_tb(rtwdev, phy, i);
+		_tssi_set_dck(rtwdev, phy, i);
+		_tssi_set_tmeter_tbl(rtwdev, phy, i);
+		_tssi_set_dac_gain_tbl(rtwdev, phy, i);
+		_tssi_slope_cal_org(rtwdev, phy, i);
+		_tssi_alignment_default(rtwdev, phy, i, true);
+		_tssi_set_tssi_slope(rtwdev, phy, i);
+
+		rtw89_chip_stop_sch_tx(rtwdev, phy, &tx_en, RTW89_SCH_TX_SEL_ALL);
+		_tmac_tx_pause(rtwdev, phy, true);
+		if (hwtx_en)
+			_tssi_alimentk(rtwdev, phy, i);
+		_tmac_tx_pause(rtwdev, phy, false);
+		rtw89_chip_resume_sch_tx(rtwdev, phy, tx_en);
+	}
+
+	_tssi_enable(rtwdev, phy);
+	_tssi_set_efuse_to_de(rtwdev, phy);
+
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_ONESHOT_STOP);
+}
+
+void rtw8852b_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
+	u8 channel = chan->channel;
+	u8 band;
+	u32 i;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "======>%s   phy=%d  channel=%d\n", __func__, phy, channel);
+
+	if (channel >= 1 && channel <= 14)
+		band = TSSI_ALIMK_2G;
+	else if (channel >= 36 && channel <= 64)
+		band = TSSI_ALIMK_5GL;
+	else if (channel >= 100 && channel <= 144)
+		band = TSSI_ALIMK_5GM;
+	else if (channel >= 149 && channel <= 177)
+		band = TSSI_ALIMK_5GH;
+	else
+		band = TSSI_ALIMK_2G;
+
+	_tssi_disable(rtwdev, phy);
+
+	for (i = RF_PATH_A; i < RTW8852B_TSSI_PATH_NR; i++) {
+		_tssi_rf_setting(rtwdev, phy, i);
+		_tssi_set_sys(rtwdev, phy, i);
+		_tssi_set_tmeter_tbl(rtwdev, phy, i);
+
+		if (tssi_info->alignment_done[i][band])
+			_tssi_alimentk_done(rtwdev, phy, i);
+		else
+			_tssi_alignment_default(rtwdev, phy, i, true);
+	}
+
+	_tssi_enable(rtwdev, phy);
+	_tssi_set_efuse_to_de(rtwdev, phy);
+}
+
+static void rtw8852b_tssi_default_txagc(struct rtw89_dev *rtwdev,
+					enum rtw89_phy_idx phy, bool enable)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 channel = chan->channel;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "======> %s   ch=%d\n",
+		    __func__, channel);
+
+	if (enable) {
+		if (!rtwdev->is_tssi_mode[RF_PATH_A] && !rtwdev->is_tssi_mode[RF_PATH_B])
+			rtw8852b_tssi(rtwdev, phy, true);
+		return;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "======>%s 1 SCAN_END Set 0x5818[7:0]=0x%x 0x7818[7:0]=0x%x\n",
+		    __func__,
+		    rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_TRK, B_P0_TSSI_OFT),
+		    rtw89_phy_read32_mask(rtwdev, R_P1_TSSI_TRK, B_P1_TSSI_OFT));
+
+	rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_TRK, B_P0_TSSI_OFT, 0xc0);
+	rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_TRK, B_P1_TSSI_OFT,  0xc0);
+	rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_TRK, B_P0_TSSI_OFT_EN, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_TRK, B_P0_TSSI_OFT_EN, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_TRK, B_P1_TSSI_OFT_EN, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_TRK, B_P1_TSSI_OFT_EN, 0x1);
+
+	_tssi_alimentk_done(rtwdev, phy, RF_PATH_A);
+	_tssi_alimentk_done(rtwdev, phy, RF_PATH_B);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "======>%s 2 SCAN_END Set 0x5818[7:0]=0x%x 0x7818[7:0]=0x%x\n",
+		    __func__,
+		    rtw89_phy_read32_mask(rtwdev, R_P0_TSSI_TRK, B_P0_TSSI_OFT),
+		    rtw89_phy_read32_mask(rtwdev, R_P1_TSSI_TRK, B_P1_TSSI_OFT));
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "======> %s   SCAN_END\n", __func__);
+}
+
+void rtw8852b_wifi_scan_notify(struct rtw89_dev *rtwdev, bool scan_start,
+			       enum rtw89_phy_idx phy_idx)
+{
+	if (scan_start)
+		rtw8852b_tssi_default_txagc(rtwdev, phy_idx, true);
+	else
+		rtw8852b_tssi_default_txagc(rtwdev, phy_idx, false);
+}
+
 static void _bw_setting(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
 			enum rtw89_bandwidth bw, bool dav)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h
index 81eb9bddb6d7a..e7402733d8480 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h
@@ -11,6 +11,10 @@ void rtw8852b_rck(struct rtw89_dev *rtwdev);
 void rtw8852b_dack(struct rtw89_dev *rtwdev);
 void rtw8852b_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 void rtw8852b_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
+void rtw8852b_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool hwtx_en);
+void rtw8852b_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
+void rtw8852b_wifi_scan_notify(struct rtw89_dev *rtwdev, bool scan_start,
+			       enum rtw89_phy_idx phy_idx);
 void rtw8852b_set_channel_rf(struct rtw89_dev *rtwdev,
 			     const struct rtw89_chan *chan,
 			     enum rtw89_phy_idx phy_idx);
-- 
2.25.1

