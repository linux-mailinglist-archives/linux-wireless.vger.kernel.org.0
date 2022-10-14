Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD0C5FE8A5
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Oct 2022 08:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJNGEN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Oct 2022 02:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiJNGEH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Oct 2022 02:04:07 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 491281ABED8
        for <linux-wireless@vger.kernel.org>; Thu, 13 Oct 2022 23:03:51 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29E62TeP4023532, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29E62TeP4023532
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 14 Oct 2022 14:02:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 14 Oct 2022 14:02:59 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 14 Oct
 2022 14:02:58 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/4] wifi: rtw89: 8852b: rfk: add DPK
Date:   Fri, 14 Oct 2022 14:02:34 +0800
Message-ID: <20221014060237.29050-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014060237.29050-1-pkshih@realtek.com>
References: <20221014060237.29050-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 10/14/2022 05:44:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzE0IKRXpMggMDM6MTg6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DPK is short for digital pre-distortion calibration. It can adjusts digital
waveform according to PA linear characteristics dynamically to enhance
TX EVM.

Do this calibration when we are going to run on AP channel. To prevent
power offset out of boundary, it monitors thermal and set proper boundary
to register.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |    1 +
 drivers/net/wireless/realtek/rtw89/reg.h      |   17 +
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.c | 1148 +++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.h |    3 +
 4 files changed, 1169 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 856d9712f0ae7..90bf7bdb60628 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3049,6 +3049,7 @@ struct rtw89_dpk_bkup_para {
 struct rtw89_dpk_info {
 	bool is_dpk_enable;
 	bool is_dpk_reload_en;
+	u8 dpk_gs[RTW89_PHY_MAX];
 	u16 dc_i[RTW89_DPK_RF_PATH][RTW89_DPK_BKUP_NUM];
 	u16 dc_q[RTW89_DPK_RF_PATH][RTW89_DPK_BKUP_NUM];
 	u8 corr_val[RTW89_DPK_RF_PATH][RTW89_DPK_BKUP_NUM];
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 4393b409cbe6f..2b938d11d2381 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3298,6 +3298,7 @@
 #define RR_MOD_RGM GENMASK(13, 4)
 #define RR_MOD_V_DOWN 0x0
 #define RR_MOD_V_STANDBY 0x1
+#define RR_TXAGC 0x10001
 #define RR_MOD_V_TX 0x2
 #define RR_MOD_V_RX 0x3
 #define RR_MOD_V_TXIQK 0x4
@@ -3431,6 +3432,7 @@
 #define RR_RXBB_VOBUF GENMASK(15, 12)
 #define RR_RXBB_C2G GENMASK(16, 10)
 #define RR_RXBB_C1G GENMASK(9, 8)
+#define RR_RXBB_FATT GENMASK(7, 0)
 #define RR_RXBB_ATTR GENMASK(7, 4)
 #define RR_RXBB_ATTC GENMASK(2, 0)
 #define RR_RXG 0x84
@@ -3441,7 +3443,9 @@
 #define RR_RXAE_IQKMOD GENMASK(3, 0)
 #define RR_RXA 0x8a
 #define RR_RXA_DPK GENMASK(9, 8)
+#define RR_RXA_LNA 0x8b
 #define RR_RXA2 0x8c
+#define RR_RAA2_SWATT GENMASK(15, 9)
 #define RR_RXA2_C1 GENMASK(12, 10)
 #define RR_RXA2_C2 GENMASK(9, 3)
 #define RR_RXA2_CC2 GENMASK(8, 7)
@@ -3476,6 +3480,7 @@
 #define RR_IQGEN_BIAS GENMASK(11, 8)
 #define RR_TXIQK 0x98
 #define RR_TXIQK_ATT2 GENMASK(15, 12)
+#define RR_TXIQK_ATT1 GENMASK(6, 0)
 #define RR_TIA 0x9e
 #define RR_TIA_N6 BIT(8)
 #define RR_MIXER 0x9f
@@ -3851,6 +3856,9 @@
 #define B_TXSHAPE_TRIANGULAR_CFG GENMASK(25, 24)
 #define R_BANDEDGE 0x4498
 #define B_BANDEDGE_EN BIT(30)
+#define R_DPD_BF 0x44a0
+#define B_DPD_BF_OFDM GENMASK(16, 12)
+#define B_DPD_BF_SCA GENMASK(6, 0)
 #define R_TXPATH_SEL 0x458C
 #define B_TXPATH_SEL_MSK GENMASK(31, 28)
 #define R_TXPWR 0x4594
@@ -4297,6 +4305,7 @@
 #define B_KPATH_CFG_ED GENMASK(21, 20)
 #define R_KIP_RPT1 0x80D4
 #define B_KIP_RPT1_SEL GENMASK(21, 16)
+#define B_KIP_RPT1_SEL_V1 GENMASK(19, 16)
 #define R_SRAM_IQRX 0x80D8
 #define R_GAPK 0x80E0
 #define B_GAPK_ADR BIT(0)
@@ -4318,6 +4327,7 @@
 #define B_PRT_COM_GL GENMASK(7, 4)
 #define B_PRT_COM_CORI GENMASK(7, 0)
 #define B_PRT_COM_RXBB GENMASK(5, 0)
+#define B_PRT_COM_RXBB_V1 GENMASK(4, 0)
 #define B_PRT_COM_DONE BIT(0)
 #define R_COEF_SEL 0x8104
 #define B_COEF_SEL_IQC BIT(0)
@@ -4356,13 +4366,18 @@
 #define B_DPD_LBK BIT(7)
 #define R_DPD_CH0 0x81AC
 #define R_DPD_BND 0x81B4
+#define B_DPD_BND_1 GENMASK(24, 16)
+#define B_DPD_BND_0 GENMASK(8, 0)
 #define R_DPD_CH0A 0x81BC
 #define B_DPD_MEN GENMASK(31, 28)
 #define B_DPD_ORDER GENMASK(26, 24)
+#define B_DPD_ORDER_V1 GENMASK(26, 25)
+#define B_DPD_CFG GENMASK(22, 0)
 #define B_DPD_SEL GENMASK(13, 8)
 #define R_TXAGC_RFK 0x81C4
 #define B_TXAGC_RFK_CH0 GENMASK(5, 0)
 #define R_DPD_COM 0x81C8
+#define B_DPD_COM_OF BIT(15)
 #define R_KIP_IQP 0x81CC
 #define B_KIP_IQP_SW GENMASK(13, 12)
 #define B_KIP_IQP_IQSW GENMASK(5, 0)
@@ -4462,6 +4477,7 @@
 #define R_P0_CFCH_BW0 0xC0D4
 #define B_P0_CFCH_BW0 GENMASK(27, 26)
 #define R_P0_CFCH_BW1 0xC0D8
+#define B_P0_CFCH_EX BIT(13)
 #define B_P0_CFCH_BW1 GENMASK(8, 5)
 #define R_ADDCK0D 0xC0F0
 #define B_ADDCK0D_VAL2 GENMASK(31, 26)
@@ -4511,6 +4527,7 @@
 #define R_PATH0_BW_SEL_V1 0xC0D8
 #define B_PATH0_BW_SEL_MSK_V1 GENMASK(8, 5)
 #define R_PATH1_BW_SEL_V1 0xC1D8
+#define B_PATH1_BW_SEL_EX BIT(13)
 #define B_PATH1_BW_SEL_MSK_V1 GENMASK(8, 5)
 #define R_ADDCK1D 0xC1F0
 #define B_ADDCK1D_VAL2 GENMASK(31, 26)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
index d0ac883772c11..8fd01502ac5be 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
@@ -17,9 +17,49 @@
 #define RTW8852B_IQK_SS 2
 #define RTW8852B_RXK_GROUP_NR 4
 #define RTW8852B_TSSI_PATH_NR 2
+#define RTW8852B_RF_REL_VERSION 34
+#define RTW8852B_DPK_VER 0x0d
+#define RTW8852B_DPK_RF_PATH 2
+#define RTW8852B_DPK_KIP_REG_NUM 2
 
 #define _TSSI_DE_MASK GENMASK(21, 12)
 #define ADDC_T_AVG 100
+#define DPK_TXAGC_LOWER 0x2e
+#define DPK_TXAGC_UPPER 0x3f
+#define DPK_TXAGC_INVAL 0xff
+#define RFREG_MASKRXBB 0x003e0
+#define RFREG_MASKMODE 0xf0000
+
+enum rtw8852b_dpk_id {
+	LBK_RXIQK	= 0x06,
+	SYNC		= 0x10,
+	MDPK_IDL	= 0x11,
+	MDPK_MPA	= 0x12,
+	GAIN_LOSS	= 0x13,
+	GAIN_CAL	= 0x14,
+	DPK_RXAGC	= 0x15,
+	KIP_PRESET	= 0x16,
+	KIP_RESTORE	= 0x17,
+	DPK_TXAGC	= 0x19,
+	D_KIP_PRESET	= 0x28,
+	D_TXAGC		= 0x29,
+	D_RXAGC		= 0x2a,
+	D_SYNC		= 0x2b,
+	D_GAIN_LOSS	= 0x2c,
+	D_MDPK_IDL	= 0x2d,
+	D_GAIN_NORM	= 0x2f,
+	D_KIP_THERMAL	= 0x30,
+	D_KIP_RESTORE	= 0x31
+};
+
+enum dpk_agc_step {
+	DPK_AGC_STEP_SYNC_DGAIN,
+	DPK_AGC_STEP_GAIN_ADJ,
+	DPK_AGC_STEP_GAIN_LOSS_IDX,
+	DPK_AGC_STEP_GL_GT_CRITERION,
+	DPK_AGC_STEP_GL_LT_CRITERION,
+	DPK_AGC_STEP_SET_TX_GAIN,
+};
 
 enum rtw8852b_iqk_type {
 	ID_TXAGC = 0x0,
@@ -190,6 +230,24 @@ static void _rfk_restore_rf_reg(struct rtw89_dev *rtwdev,
 	}
 }
 
+static void _rfk_rf_direct_cntrl(struct rtw89_dev *rtwdev,
+				 enum rtw89_rf_path path, bool is_bybb)
+{
+	if (is_bybb)
+		rtw89_write_rf(rtwdev, path, RR_RSV1, RR_RSV1_RST, 0x1);
+	else
+		rtw89_write_rf(rtwdev, path, RR_RSV1, RR_RSV1_RST, 0x0);
+}
+
+static void _rfk_drf_direct_cntrl(struct rtw89_dev *rtwdev,
+				  enum rtw89_rf_path path, bool is_bybb)
+{
+	if (is_bybb)
+		rtw89_write_rf(rtwdev, path, RR_BBDC, RR_BBDC_SEL, 0x1);
+	else
+		rtw89_write_rf(rtwdev, path, RR_BBDC, RR_BBDC_SEL, 0x0);
+}
+
 static bool _iqk_check_cal(struct rtw89_dev *rtwdev, u8 path)
 {
 	bool fail = true;
@@ -1605,6 +1663,1069 @@ static void _iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, bool forc
 	}
 }
 
+static void _dpk_bkup_kip(struct rtw89_dev *rtwdev, const u32 reg[],
+			  u32 reg_bkup[][RTW8852B_DPK_KIP_REG_NUM], u8 path)
+{
+	u8 i;
+
+	for (i = 0; i < RTW8852B_DPK_KIP_REG_NUM; i++) {
+		reg_bkup[path][i] =
+			rtw89_phy_read32_mask(rtwdev, reg[i] + (path << 8), MASKDWORD);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] Backup 0x%x = %x\n",
+			    reg[i] + (path << 8), reg_bkup[path][i]);
+	}
+}
+
+static void _dpk_reload_kip(struct rtw89_dev *rtwdev, const u32 reg[],
+			    const u32 reg_bkup[][RTW8852B_DPK_KIP_REG_NUM], u8 path)
+{
+	u8 i;
+
+	for (i = 0; i < RTW8852B_DPK_KIP_REG_NUM; i++) {
+		rtw89_phy_write32_mask(rtwdev, reg[i] + (path << 8), MASKDWORD,
+				       reg_bkup[path][i]);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] Reload 0x%x = %x\n",
+			    reg[i] + (path << 8), reg_bkup[path][i]);
+	}
+}
+
+static u8 _dpk_order_convert(struct rtw89_dev *rtwdev)
+{
+	u8 order;
+	u8 val;
+
+	order = rtw89_phy_read32_mask(rtwdev, R_LDL_NORM, B_LDL_NORM_OP);
+	val = 0x3 >> order;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] convert MDPD order to 0x%x\n", val);
+
+	return val;
+}
+
+static void _dpk_onoff(struct rtw89_dev *rtwdev, enum rtw89_rf_path path, bool off)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	u8 val, kidx = dpk->cur_idx[path];
+
+	val = dpk->is_dpk_enable && !off && dpk->bp[path][kidx].path_ok;
+
+	rtw89_phy_write32_mask(rtwdev, R_DPD_CH0A + (path << 8) + (kidx << 2),
+			       MASKBYTE3, _dpk_order_convert(rtwdev) << 1 | val);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d[%d] DPK %s !!!\n", path,
+		    kidx, dpk->is_dpk_enable && !off ? "enable" : "disable");
+}
+
+static void _dpk_one_shot(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			  enum rtw89_rf_path path, enum rtw8852b_dpk_id id)
+{
+	u16 dpk_cmd;
+	u32 val;
+	int ret;
+
+	dpk_cmd = (id << 8) | (0x19 + (path << 4));
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_CFG, MASKDWORD, dpk_cmd);
+
+	ret = read_poll_timeout_atomic(rtw89_phy_read32_mask, val, val == 0x55,
+				       1, 20000, false,
+				       rtwdev, 0xbff8, MASKBYTE0);
+	if (ret)
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] one-shot over 20ms!!!!\n");
+
+	udelay(1);
+
+	rtw89_phy_write32_mask(rtwdev, R_KIP_RPT1, MASKDWORD, 0x00030000);
+
+	ret = read_poll_timeout_atomic(rtw89_phy_read32_mask, val, val == 0x8000,
+				       1, 2000, false,
+				       rtwdev, 0x80fc, MASKLWORD);
+	if (ret)
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] one-shot over 20ms!!!!\n");
+
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_N1, MASKBYTE0, 0x0);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DPK] one-shot for %s = 0x%x\n",
+		    id == 0x06 ? "LBK_RXIQK" :
+		    id == 0x10 ? "SYNC" :
+		    id == 0x11 ? "MDPK_IDL" :
+		    id == 0x12 ? "MDPK_MPA" :
+		    id == 0x13 ? "GAIN_LOSS" :
+		    id == 0x14 ? "PWR_CAL" :
+		    id == 0x15 ? "DPK_RXAGC" :
+		    id == 0x16 ? "KIP_PRESET" :
+		    id == 0x17 ? "KIP_RESOTRE" : "DPK_TXAGC",
+		    dpk_cmd);
+}
+
+static void _dpk_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			enum rtw89_rf_path path)
+{
+	rtw89_write_rf(rtwdev, path, RR_RXBB2, RR_EN_TIA_IDA, 0x3);
+	_set_rx_dck(rtwdev, phy, path);
+}
+
+static void _dpk_information(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			     enum rtw89_rf_path path)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+
+	u8 kidx = dpk->cur_idx[path];
+
+	dpk->bp[path][kidx].band = chan->band_type;
+	dpk->bp[path][kidx].ch = chan->channel;
+	dpk->bp[path][kidx].bw = chan->band_width;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DPK] S%d[%d] (PHY%d): TSSI %s/ DBCC %s/ %s/ CH%d/ %s\n",
+		    path, dpk->cur_idx[path], phy,
+		    rtwdev->is_tssi_mode[path] ? "on" : "off",
+		    rtwdev->dbcc_en ? "on" : "off",
+		    dpk->bp[path][kidx].band == 0 ? "2G" :
+		    dpk->bp[path][kidx].band == 1 ? "5G" : "6G",
+		    dpk->bp[path][kidx].ch,
+		    dpk->bp[path][kidx].bw == 0 ? "20M" :
+		    dpk->bp[path][kidx].bw == 1 ? "40M" : "80M");
+}
+
+static void _dpk_bb_afe_setting(struct rtw89_dev *rtwdev,
+				enum rtw89_phy_idx phy,
+				enum rtw89_rf_path path, u8 kpath)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+
+	rtw89_rfk_parser(rtwdev, &rtw8852b_dpk_afe_defs_tbl);
+
+	if (chan->band_width == RTW89_CHANNEL_WIDTH_80) {
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW1, B_P0_CFCH_EX, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_BW_SEL_V1, B_PATH1_BW_SEL_EX, 0x1);
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DPK] Set BB/AFE for PHY%d (kpath=%d)\n", phy, kpath);
+}
+
+static void _dpk_bb_afe_restore(struct rtw89_dev *rtwdev,
+				enum rtw89_phy_idx phy,
+				enum rtw89_rf_path path, u8 kpath)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+
+	rtw89_rfk_parser(rtwdev, &rtw8852b_dpk_afe_restore_defs_tbl);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DPK] Restore BB/AFE for PHY%d (kpath=%d)\n", phy, kpath);
+
+	if (chan->band_width == RTW89_CHANNEL_WIDTH_80) {
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW1, B_P0_CFCH_EX, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_BW_SEL_V1,  B_PATH1_BW_SEL_EX, 0x0);
+	}
+}
+
+static void _dpk_tssi_pause(struct rtw89_dev *rtwdev,
+			    enum rtw89_rf_path path, bool is_pause)
+{
+	rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_TRK + (path << 13),
+			       B_P0_TSSI_TRK_EN, is_pause);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d TSSI %s\n", path,
+		    is_pause ? "pause" : "resume");
+}
+
+static void _dpk_kip_restore(struct rtw89_dev *rtwdev,
+			     enum rtw89_rf_path path)
+{
+	rtw89_rfk_parser(rtwdev, &rtw8852b_dpk_kip_defs_tbl);
+
+	if (rtwdev->hal.cv > CHIP_CAV)
+		rtw89_phy_write32_mask(rtwdev, R_DPD_COM + (path << 8), B_DPD_COM_OF, 0x1);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d restore KIP\n", path);
+}
+
+static void _dpk_lbk_rxiqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			   enum rtw89_rf_path path)
+{
+	u8 cur_rxbb;
+	u32 tmp;
+
+	cur_rxbb = rtw89_read_rf(rtwdev, path, RR_MOD, RFREG_MASKRXBB);
+
+	rtw89_phy_write32_mask(rtwdev, R_MDPK_RX_DCK, B_MDPK_RX_DCK_EN, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_IQK_RES + (path << 8), B_IQK_RES_RXCFIR, 0x0);
+
+	tmp = rtw89_read_rf(rtwdev, path, RR_CFGCH, RFREG_MASK);
+	rtw89_write_rf(rtwdev, path, RR_RSV4, RFREG_MASK, tmp);
+	rtw89_write_rf(rtwdev, path, RR_MOD, RFREG_MASKMODE, 0xd);
+	rtw89_write_rf(rtwdev, path, RR_RXK, RR_RXK_PLLEN, 0x1);
+
+	if (cur_rxbb >= 0x11)
+		rtw89_write_rf(rtwdev, path, RR_TXIQK, RR_TXIQK_ATT1, 0x13);
+	else if (cur_rxbb <= 0xa)
+		rtw89_write_rf(rtwdev, path, RR_TXIQK, RR_TXIQK_ATT1, 0x00);
+	else
+		rtw89_write_rf(rtwdev, path, RR_TXIQK, RR_TXIQK_ATT1, 0x05);
+
+	rtw89_write_rf(rtwdev, path, RR_XGLNA2, RR_XGLNA2_SW, 0x0);
+	rtw89_write_rf(rtwdev, path, RR_RXKPLL, RR_RXKPLL_POW, 0x0);
+	rtw89_write_rf(rtwdev, path, RR_RXKPLL, RFREG_MASK, 0x80014);
+	udelay(70);
+
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_RXT, 0x025);
+
+	_dpk_one_shot(rtwdev, phy, path, LBK_RXIQK);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d LBK RXIQC = 0x%x\n", path,
+		    rtw89_phy_read32_mask(rtwdev, R_RXIQC, MASKDWORD));
+
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x0);
+	rtw89_write_rf(rtwdev, path, RR_RXK, RR_RXK_PLLEN, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_MDPK_RX_DCK, B_MDPK_RX_DCK_EN, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_KPATH_CFG, B_KPATH_CFG_ED, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_LOAD_COEF + (path << 8), B_LOAD_COEF_DI, 0x1);
+	rtw89_write_rf(rtwdev, path, RR_MOD, RFREG_MASKMODE, 0x5);
+}
+
+static void _dpk_get_thermal(struct rtw89_dev *rtwdev, u8 kidx, enum rtw89_rf_path path)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+
+	rtw89_write_rf(rtwdev, path, RR_TM, RR_TM_TRI, 0x1);
+	rtw89_write_rf(rtwdev, path, RR_TM, RR_TM_TRI, 0x0);
+	rtw89_write_rf(rtwdev, path, RR_TM, RR_TM_TRI, 0x1);
+
+	udelay(200);
+
+	dpk->bp[path][kidx].ther_dpk = rtw89_read_rf(rtwdev, path, RR_TM, RR_TM_VAL);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] thermal@DPK = 0x%x\n",
+		    dpk->bp[path][kidx].ther_dpk);
+}
+
+static void _dpk_rf_setting(struct rtw89_dev *rtwdev, u8 gain,
+			    enum rtw89_rf_path path, u8 kidx)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+
+	if (dpk->bp[path][kidx].band == RTW89_BAND_2G) {
+		rtw89_write_rf(rtwdev, path, RR_MOD, RFREG_MASK, 0x50220);
+		rtw89_write_rf(rtwdev, path, RR_RXBB, RR_RXBB_FATT, 0xf2);
+		rtw89_write_rf(rtwdev, path, RR_LUTDBG, RR_LUTDBG_TIA, 0x1);
+		rtw89_write_rf(rtwdev, path, RR_TIA, RR_TIA_N6, 0x1);
+	} else {
+		rtw89_write_rf(rtwdev, path, RR_MOD, RFREG_MASK, 0x50220);
+		rtw89_write_rf(rtwdev, path, RR_RXA2, RR_RAA2_SWATT, 0x5);
+		rtw89_write_rf(rtwdev, path, RR_LUTDBG, RR_LUTDBG_TIA, 0x1);
+		rtw89_write_rf(rtwdev, path, RR_TIA, RR_TIA_N6, 0x1);
+		rtw89_write_rf(rtwdev, path, RR_RXA_LNA, RFREG_MASK, 0x920FC);
+		rtw89_write_rf(rtwdev, path, RR_XALNA2, RFREG_MASK, 0x002C0);
+		rtw89_write_rf(rtwdev, path, RR_IQGEN, RFREG_MASK, 0x38800);
+	}
+
+	rtw89_write_rf(rtwdev, path, RR_RCKD, RR_RCKD_BW, 0x1);
+	rtw89_write_rf(rtwdev, path, RR_BTC, RR_BTC_TXBB, dpk->bp[path][kidx].bw + 1);
+	rtw89_write_rf(rtwdev, path, RR_BTC, RR_BTC_RXBB, 0x0);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DPK] ARF 0x0/0x11/0x1a = 0x%x/ 0x%x/ 0x%x\n",
+		    rtw89_read_rf(rtwdev, path, RR_MOD, RFREG_MASK),
+		    rtw89_read_rf(rtwdev, path, RR_TXIG, RFREG_MASK),
+		    rtw89_read_rf(rtwdev, path, RR_BTC, RFREG_MASK));
+}
+
+static void _dpk_bypass_rxcfir(struct rtw89_dev *rtwdev,
+			       enum rtw89_rf_path path, bool is_bypass)
+{
+	if (is_bypass) {
+		rtw89_phy_write32_mask(rtwdev, R_RXIQC + (path << 8),
+				       B_RXIQC_BYPASS2, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_RXIQC + (path << 8),
+				       B_RXIQC_BYPASS, 0x1);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[DPK] Bypass RXIQC (0x8%d3c = 0x%x)\n", 1 + path,
+			    rtw89_phy_read32_mask(rtwdev, R_RXIQC + (path << 8),
+						  MASKDWORD));
+	} else {
+		rtw89_phy_write32_clr(rtwdev, R_RXIQC + (path << 8), B_RXIQC_BYPASS2);
+		rtw89_phy_write32_clr(rtwdev, R_RXIQC + (path << 8), B_RXIQC_BYPASS);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[DPK] restore 0x8%d3c = 0x%x\n", 1 + path,
+			    rtw89_phy_read32_mask(rtwdev, R_RXIQC + (path << 8),
+						  MASKDWORD));
+	}
+}
+
+static
+void _dpk_tpg_sel(struct rtw89_dev *rtwdev, enum rtw89_rf_path path, u8 kidx)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+
+	if (dpk->bp[path][kidx].bw == RTW89_CHANNEL_WIDTH_80)
+		rtw89_phy_write32_clr(rtwdev, R_TPG_MOD, B_TPG_MOD_F);
+	else if (dpk->bp[path][kidx].bw == RTW89_CHANNEL_WIDTH_40)
+		rtw89_phy_write32_mask(rtwdev, R_TPG_MOD, B_TPG_MOD_F, 0x2);
+	else
+		rtw89_phy_write32_mask(rtwdev, R_TPG_MOD, B_TPG_MOD_F, 0x1);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] TPG_Select for %s\n",
+		    dpk->bp[path][kidx].bw == RTW89_CHANNEL_WIDTH_80 ? "80M" :
+		    dpk->bp[path][kidx].bw == RTW89_CHANNEL_WIDTH_40 ? "40M" : "20M");
+}
+
+static void _dpk_table_select(struct rtw89_dev *rtwdev,
+			      enum rtw89_rf_path path, u8 kidx, u8 gain)
+{
+	u8 val;
+
+	val = 0x80 + kidx * 0x20 + gain * 0x10;
+	rtw89_phy_write32_mask(rtwdev, R_DPD_CH0 + (path << 8), MASKBYTE3, val);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DPK] table select for Kidx[%d], Gain[%d] (0x%x)\n", kidx,
+		    gain, val);
+}
+
+static bool _dpk_sync_check(struct rtw89_dev *rtwdev, enum rtw89_rf_path path, u8 kidx)
+{
+#define DPK_SYNC_TH_DC_I 200
+#define DPK_SYNC_TH_DC_Q 200
+#define DPK_SYNC_TH_CORR 170
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	u16 dc_i, dc_q;
+	u8 corr_val, corr_idx;
+
+	rtw89_phy_write32_clr(rtwdev, R_KIP_RPT1, B_KIP_RPT1_SEL);
+
+	corr_idx = rtw89_phy_read32_mask(rtwdev, R_RPT_COM, B_PRT_COM_CORI);
+	corr_val = rtw89_phy_read32_mask(rtwdev, R_RPT_COM, B_PRT_COM_CORV);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DPK] S%d Corr_idx / Corr_val = %d / %d\n",
+		    path, corr_idx, corr_val);
+
+	dpk->corr_idx[path][kidx] = corr_idx;
+	dpk->corr_val[path][kidx] = corr_val;
+
+	rtw89_phy_write32_mask(rtwdev, R_KIP_RPT1, B_KIP_RPT1_SEL, 0x9);
+
+	dc_i = rtw89_phy_read32_mask(rtwdev, R_RPT_COM, B_PRT_COM_DCI);
+	dc_q = rtw89_phy_read32_mask(rtwdev, R_RPT_COM, B_PRT_COM_DCQ);
+
+	dc_i = abs(sign_extend32(dc_i, 11));
+	dc_q = abs(sign_extend32(dc_q, 11));
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d DC I/Q, = %d / %d\n",
+		    path, dc_i, dc_q);
+
+	dpk->dc_i[path][kidx] = dc_i;
+	dpk->dc_q[path][kidx] = dc_q;
+
+	if (dc_i > DPK_SYNC_TH_DC_I || dc_q > DPK_SYNC_TH_DC_Q ||
+	    corr_val < DPK_SYNC_TH_CORR)
+		return true;
+	else
+		return false;
+}
+
+static bool _dpk_sync(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+		      enum rtw89_rf_path path, u8 kidx)
+{
+	_dpk_one_shot(rtwdev, phy, path, SYNC);
+
+	return _dpk_sync_check(rtwdev, path, kidx);
+}
+
+static u16 _dpk_dgain_read(struct rtw89_dev *rtwdev)
+{
+	u16 dgain;
+
+	rtw89_phy_write32_mask(rtwdev, R_KIP_RPT1, B_KIP_RPT1_SEL, 0x0);
+
+	dgain = rtw89_phy_read32_mask(rtwdev, R_RPT_COM, B_PRT_COM_DCI);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] DGain = 0x%x\n", dgain);
+
+	return dgain;
+}
+
+static s8 _dpk_dgain_mapping(struct rtw89_dev *rtwdev, u16 dgain)
+{
+	static const u16 bnd[15] = {
+		0xbf1, 0xaa5, 0x97d, 0x875, 0x789, 0x6b7, 0x5fc, 0x556,
+		0x4c1, 0x43d, 0x3c7, 0x35e, 0x2ac, 0x262, 0x220
+	};
+	s8 offset;
+
+	if (dgain >= bnd[0])
+		offset = 0x6;
+	else if (bnd[0] > dgain && dgain >= bnd[1])
+		offset = 0x6;
+	else if (bnd[1] > dgain && dgain >= bnd[2])
+		offset = 0x5;
+	else if (bnd[2] > dgain && dgain >= bnd[3])
+		offset = 0x4;
+	else if (bnd[3] > dgain && dgain >= bnd[4])
+		offset = 0x3;
+	else if (bnd[4] > dgain && dgain >= bnd[5])
+		offset = 0x2;
+	else if (bnd[5] > dgain && dgain >= bnd[6])
+		offset = 0x1;
+	else if (bnd[6] > dgain && dgain >= bnd[7])
+		offset = 0x0;
+	else if (bnd[7] > dgain && dgain >= bnd[8])
+		offset = 0xff;
+	else if (bnd[8] > dgain && dgain >= bnd[9])
+		offset = 0xfe;
+	else if (bnd[9] > dgain && dgain >= bnd[10])
+		offset = 0xfd;
+	else if (bnd[10] > dgain && dgain >= bnd[11])
+		offset = 0xfc;
+	else if (bnd[11] > dgain && dgain >= bnd[12])
+		offset = 0xfb;
+	else if (bnd[12] > dgain && dgain >= bnd[13])
+		offset = 0xfa;
+	else if (bnd[13] > dgain && dgain >= bnd[14])
+		offset = 0xf9;
+	else if (bnd[14] > dgain)
+		offset = 0xf8;
+	else
+		offset = 0x0;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] DGain offset = %d\n", offset);
+
+	return offset;
+}
+
+static u8 _dpk_gainloss_read(struct rtw89_dev *rtwdev)
+{
+	rtw89_phy_write32_mask(rtwdev, R_KIP_RPT1, B_KIP_RPT1_SEL, 0x6);
+	rtw89_phy_write32_mask(rtwdev, R_DPK_CFG2, B_DPK_CFG2_ST, 0x1);
+
+	return rtw89_phy_read32_mask(rtwdev, R_RPT_COM, B_PRT_COM_GL);
+}
+
+static void _dpk_gainloss(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			  enum rtw89_rf_path path, u8 kidx)
+{
+	_dpk_table_select(rtwdev, path, kidx, 1);
+	_dpk_one_shot(rtwdev, phy, path, GAIN_LOSS);
+}
+
+static void _dpk_kip_preset(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			    enum rtw89_rf_path path, u8 kidx)
+{
+	_dpk_tpg_sel(rtwdev, path, kidx);
+	_dpk_one_shot(rtwdev, phy, path, KIP_PRESET);
+}
+
+static void _dpk_kip_pwr_clk_on(struct rtw89_dev *rtwdev,
+				enum rtw89_rf_path path)
+{
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_RPT, MASKDWORD, 0x00000080);
+	rtw89_phy_write32_mask(rtwdev, R_KIP_SYSCFG, MASKDWORD, 0x807f030a);
+	rtw89_phy_write32_mask(rtwdev, R_CFIR_SYS + (path << 8), MASKDWORD, 0xce000a08);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] KIP Power/CLK on\n");
+}
+
+static void _dpk_kip_set_txagc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			       enum rtw89_rf_path path, u8 txagc)
+{
+	rtw89_write_rf(rtwdev, path, RR_TXAGC, RFREG_MASK, txagc);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x1);
+	_dpk_one_shot(rtwdev, phy, path, DPK_TXAGC);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x0);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] set TXAGC = 0x%x\n", txagc);
+}
+
+static void _dpk_kip_set_rxagc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			       enum rtw89_rf_path path)
+{
+	u32 tmp;
+
+	tmp = rtw89_read_rf(rtwdev, path, RR_MOD, RFREG_MASK);
+	rtw89_phy_write32_mask(rtwdev, R_KIP_MOD, B_KIP_MOD, tmp);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x1);
+	_dpk_one_shot(rtwdev, phy, path, DPK_RXAGC);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_KIP_RPT1, B_KIP_RPT1_SEL_V1, 0x8);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DPK] set RXBB = 0x%x (RF0x0[9:5] = 0x%x)\n",
+		    rtw89_phy_read32_mask(rtwdev, R_RPT_COM, B_PRT_COM_RXBB_V1),
+		    rtw89_read_rf(rtwdev, path, RR_MOD, RFREG_MASKRXBB));
+}
+
+static u8 _dpk_set_offset(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			  enum rtw89_rf_path path, s8 gain_offset)
+{
+	u8 txagc;
+
+	txagc = rtw89_read_rf(rtwdev, path, RR_TXAGC, RFREG_MASK);
+
+	if (txagc - gain_offset < DPK_TXAGC_LOWER)
+		txagc = DPK_TXAGC_LOWER;
+	else if (txagc - gain_offset > DPK_TXAGC_UPPER)
+		txagc = DPK_TXAGC_UPPER;
+	else
+		txagc = txagc - gain_offset;
+
+	_dpk_kip_set_txagc(rtwdev, phy, path, txagc);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] tmp_txagc (GL=%d) = 0x%x\n",
+		    gain_offset, txagc);
+	return txagc;
+}
+
+static bool _dpk_pas_read(struct rtw89_dev *rtwdev, bool is_check)
+{
+	u32 val1_i = 0, val1_q = 0, val2_i = 0, val2_q = 0;
+	u8 i;
+
+	rtw89_phy_write32_mask(rtwdev, R_KIP_RPT1, MASKBYTE2, 0x06);
+	rtw89_phy_write32_mask(rtwdev, R_DPK_CFG2, B_DPK_CFG2_ST, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_DPK_CFG3, MASKBYTE2, 0x08);
+
+	if (is_check) {
+		rtw89_phy_write32_mask(rtwdev, R_DPK_CFG3, MASKBYTE3, 0x00);
+		val1_i = rtw89_phy_read32_mask(rtwdev, R_RPT_COM, MASKHWORD);
+		val1_i = abs(sign_extend32(val1_i, 11));
+		val1_q = rtw89_phy_read32_mask(rtwdev, R_RPT_COM, MASKLWORD);
+		val1_q = abs(sign_extend32(val1_q, 11));
+
+		rtw89_phy_write32_mask(rtwdev, R_DPK_CFG3, MASKBYTE3, 0x1f);
+		val2_i = rtw89_phy_read32_mask(rtwdev, R_RPT_COM, MASKHWORD);
+		val2_i = abs(sign_extend32(val2_i, 11));
+		val2_q = rtw89_phy_read32_mask(rtwdev, R_RPT_COM, MASKLWORD);
+		val2_q = abs(sign_extend32(val2_q, 11));
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] PAS_delta = 0x%x\n",
+			    phy_div(val1_i * val1_i + val1_q * val1_q,
+				    val2_i * val2_i + val2_q * val2_q));
+	} else {
+		for (i = 0; i < 32; i++) {
+			rtw89_phy_write32_mask(rtwdev, R_DPK_CFG3, MASKBYTE3, i);
+			rtw89_debug(rtwdev, RTW89_DBG_RFK,
+				    "[DPK] PAS_Read[%02d]= 0x%08x\n", i,
+				    rtw89_phy_read32_mask(rtwdev, R_RPT_COM, MASKDWORD));
+		}
+	}
+
+	if (val1_i * val1_i + val1_q * val1_q >=
+	    (val2_i * val2_i + val2_q * val2_q) * 8 / 5)
+		return true;
+
+	return false;
+}
+
+static u8 _dpk_agc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+		   enum rtw89_rf_path path, u8 kidx, u8 init_txagc,
+		   bool loss_only)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 step = DPK_AGC_STEP_SYNC_DGAIN;
+	u8 tmp_txagc, tmp_rxbb = 0, tmp_gl_idx = 0;
+	u8 goout = 0, agc_cnt = 0, limited_rxbb = 0;
+	u16 dgain = 0;
+	s8 offset;
+	int limit = 200;
+
+	tmp_txagc = init_txagc;
+
+	do {
+		switch (step) {
+		case DPK_AGC_STEP_SYNC_DGAIN:
+			if (_dpk_sync(rtwdev, phy, path, kidx)) {
+				tmp_txagc = 0xff;
+				goout = 1;
+				break;
+			}
+
+			dgain = _dpk_dgain_read(rtwdev);
+
+			if (loss_only == 1 || limited_rxbb == 1)
+				step = DPK_AGC_STEP_GAIN_LOSS_IDX;
+			else
+				step = DPK_AGC_STEP_GAIN_ADJ;
+			break;
+
+		case DPK_AGC_STEP_GAIN_ADJ:
+			tmp_rxbb = rtw89_read_rf(rtwdev, path, RR_MOD,
+						 RFREG_MASKRXBB);
+			offset = _dpk_dgain_mapping(rtwdev, dgain);
+
+			if (tmp_rxbb + offset > 0x1f) {
+				tmp_rxbb = 0x1f;
+				limited_rxbb = 1;
+			} else if (tmp_rxbb + offset < 0) {
+				tmp_rxbb = 0;
+				limited_rxbb = 1;
+			} else {
+				tmp_rxbb = tmp_rxbb + offset;
+			}
+
+			rtw89_write_rf(rtwdev, path, RR_MOD, RFREG_MASKRXBB,
+				       tmp_rxbb);
+			rtw89_debug(rtwdev, RTW89_DBG_RFK,
+				    "[DPK] Adjust RXBB (%d) = 0x%x\n", offset, tmp_rxbb);
+			if (offset || agc_cnt == 0) {
+				if (chan->band_width < RTW89_CHANNEL_WIDTH_80)
+					_dpk_bypass_rxcfir(rtwdev, path, true);
+				else
+					_dpk_lbk_rxiqk(rtwdev, phy, path);
+			}
+			if (dgain > 1922 || dgain < 342)
+				step = DPK_AGC_STEP_SYNC_DGAIN;
+			else
+				step = DPK_AGC_STEP_GAIN_LOSS_IDX;
+
+			agc_cnt++;
+			break;
+
+		case DPK_AGC_STEP_GAIN_LOSS_IDX:
+			_dpk_gainloss(rtwdev, phy, path, kidx);
+			tmp_gl_idx = _dpk_gainloss_read(rtwdev);
+
+			if ((tmp_gl_idx == 0 && _dpk_pas_read(rtwdev, true)) ||
+			    tmp_gl_idx >= 7)
+				step = DPK_AGC_STEP_GL_GT_CRITERION;
+			else if (tmp_gl_idx == 0)
+				step = DPK_AGC_STEP_GL_LT_CRITERION;
+			else
+				step = DPK_AGC_STEP_SET_TX_GAIN;
+			break;
+
+		case DPK_AGC_STEP_GL_GT_CRITERION:
+			if (tmp_txagc == 0x2e) {
+				goout = 1;
+				rtw89_debug(rtwdev, RTW89_DBG_RFK,
+					    "[DPK] Txagc@lower bound!!\n");
+			} else {
+				tmp_txagc = _dpk_set_offset(rtwdev, phy, path, 0x3);
+			}
+			step = DPK_AGC_STEP_GAIN_LOSS_IDX;
+			agc_cnt++;
+			break;
+
+		case DPK_AGC_STEP_GL_LT_CRITERION:
+			if (tmp_txagc == 0x3f) {
+				goout = 1;
+				rtw89_debug(rtwdev, RTW89_DBG_RFK,
+					    "[DPK] Txagc@upper bound!!\n");
+			} else {
+				tmp_txagc = _dpk_set_offset(rtwdev, phy, path, 0xfe);
+			}
+			step = DPK_AGC_STEP_GAIN_LOSS_IDX;
+			agc_cnt++;
+			break;
+		case DPK_AGC_STEP_SET_TX_GAIN:
+			tmp_txagc = _dpk_set_offset(rtwdev, phy, path, tmp_gl_idx);
+			goout = 1;
+			agc_cnt++;
+			break;
+
+		default:
+			goout = 1;
+			break;
+		}
+	} while (!goout && agc_cnt < 6 && limit-- > 0);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DPK] Txagc / RXBB for DPK = 0x%x / 0x%x\n", tmp_txagc,
+		    tmp_rxbb);
+
+	return tmp_txagc;
+}
+
+static void _dpk_set_mdpd_para(struct rtw89_dev *rtwdev, u8 order)
+{
+	switch (order) {
+	case 0:
+		rtw89_phy_write32_mask(rtwdev, R_LDL_NORM, B_LDL_NORM_OP, order);
+		rtw89_phy_write32_mask(rtwdev, R_LDL_NORM, B_LDL_NORM_PN, 0x3);
+		rtw89_phy_write32_mask(rtwdev, R_MDPK_SYNC, B_MDPK_SYNC_MAN, 0x1);
+		break;
+	case 1:
+		rtw89_phy_write32_mask(rtwdev, R_LDL_NORM, B_LDL_NORM_OP, order);
+		rtw89_phy_write32_clr(rtwdev, R_LDL_NORM, B_LDL_NORM_PN);
+		rtw89_phy_write32_clr(rtwdev, R_MDPK_SYNC, B_MDPK_SYNC_MAN);
+		break;
+	case 2:
+		rtw89_phy_write32_mask(rtwdev, R_LDL_NORM, B_LDL_NORM_OP, order);
+		rtw89_phy_write32_clr(rtwdev, R_LDL_NORM, B_LDL_NORM_PN);
+		rtw89_phy_write32_clr(rtwdev, R_MDPK_SYNC, B_MDPK_SYNC_MAN);
+		break;
+	default:
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[DPK] Wrong MDPD order!!(0x%x)\n", order);
+		break;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DPK] Set MDPD order to 0x%x for IDL\n", order);
+}
+
+static void _dpk_idl_mpa(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			 enum rtw89_rf_path path, u8 kidx, u8 gain)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+
+	if (dpk->bp[path][kidx].bw < RTW89_CHANNEL_WIDTH_80 &&
+	    dpk->bp[path][kidx].band == RTW89_BAND_5G)
+		_dpk_set_mdpd_para(rtwdev, 0x2);
+	else
+		_dpk_set_mdpd_para(rtwdev, 0x0);
+
+	_dpk_one_shot(rtwdev, phy, path, MDPK_IDL);
+}
+
+static void _dpk_fill_result(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			     enum rtw89_rf_path path, u8 kidx, u8 gain, u8 txagc)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	const u16 pwsf = 0x78;
+	u8 gs = dpk->dpk_gs[phy];
+
+	rtw89_phy_write32_mask(rtwdev, R_COEF_SEL + (path << 8),
+			       B_COEF_SEL_MDPD, kidx);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DPK] Fill txagc/ pwsf/ gs = 0x%x/ 0x%x/ 0x%x\n", txagc,
+		    pwsf, gs);
+
+	dpk->bp[path][kidx].txagc_dpk = txagc;
+	rtw89_phy_write32_mask(rtwdev, R_TXAGC_RFK + (path << 8),
+			       0x3F << ((gain << 3) + (kidx << 4)), txagc);
+
+	dpk->bp[path][kidx].pwsf = pwsf;
+	rtw89_phy_write32_mask(rtwdev, R_DPD_BND + (path << 8) + (kidx << 2),
+			       0x1FF << (gain << 4), pwsf);
+
+	rtw89_phy_write32_mask(rtwdev, R_LOAD_COEF + (path << 8), B_LOAD_COEF_MDPD, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_LOAD_COEF + (path << 8), B_LOAD_COEF_MDPD, 0x0);
+
+	dpk->bp[path][kidx].gs = gs;
+	if (dpk->dpk_gs[phy] == 0x7f)
+		rtw89_phy_write32_mask(rtwdev, R_DPD_CH0A + (path << 8) + (kidx << 2),
+				       MASKDWORD, 0x007f7f7f);
+	else
+		rtw89_phy_write32_mask(rtwdev, R_DPD_CH0A + (path << 8) + (kidx << 2),
+				       MASKDWORD, 0x005b5b5b);
+
+	rtw89_phy_write32_mask(rtwdev, R_DPD_CH0A + (path << 8) + (kidx << 2),
+			       B_DPD_ORDER_V1, _dpk_order_convert(rtwdev));
+	rtw89_phy_write32_mask(rtwdev, R_DPD_V1 + (path << 8), MASKDWORD, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_MDPK_SYNC, B_MDPK_SYNC_SEL, 0x0);
+}
+
+static bool _dpk_reload_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			      enum rtw89_rf_path path)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	bool is_reload = false;
+	u8 idx, cur_band, cur_ch;
+
+	cur_band = chan->band_type;
+	cur_ch = chan->channel;
+
+	for (idx = 0; idx < RTW89_DPK_BKUP_NUM; idx++) {
+		if (cur_band != dpk->bp[path][idx].band ||
+		    cur_ch != dpk->bp[path][idx].ch)
+			continue;
+
+		rtw89_phy_write32_mask(rtwdev, R_COEF_SEL + (path << 8),
+				       B_COEF_SEL_MDPD, idx);
+		dpk->cur_idx[path] = idx;
+		is_reload = true;
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[DPK] reload S%d[%d] success\n", path, idx);
+	}
+
+	return is_reload;
+}
+
+static bool _dpk_main(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+		      enum rtw89_rf_path path, u8 gain)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	u8 txagc = 0x38, kidx = dpk->cur_idx[path];
+	bool is_fail = false;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DPK] ========= S%d[%d] DPK Start =========\n", path, kidx);
+
+	_rfk_rf_direct_cntrl(rtwdev, path, false);
+	_rfk_drf_direct_cntrl(rtwdev, path, false);
+
+	_dpk_kip_pwr_clk_on(rtwdev, path);
+	_dpk_kip_set_txagc(rtwdev, phy, path, txagc);
+	_dpk_rf_setting(rtwdev, gain, path, kidx);
+	_dpk_rx_dck(rtwdev, phy, path);
+
+	_dpk_kip_preset(rtwdev, phy, path, kidx);
+	_dpk_kip_set_rxagc(rtwdev, phy, path);
+	_dpk_table_select(rtwdev, path, kidx, gain);
+
+	txagc = _dpk_agc(rtwdev, phy, path, kidx, txagc, false);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] Adjust txagc = 0x%x\n", txagc);
+
+	if (txagc == 0xff) {
+		is_fail = true;
+	} else {
+		_dpk_get_thermal(rtwdev, kidx, path);
+
+		_dpk_idl_mpa(rtwdev, phy, path, kidx, gain);
+
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_MASK, RR_MOD_V_RX);
+
+		_dpk_fill_result(rtwdev, phy, path, kidx, gain, txagc);
+	}
+
+	if (!is_fail)
+		dpk->bp[path][kidx].path_ok = true;
+	else
+		dpk->bp[path][kidx].path_ok = false;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d[%d] DPK %s\n", path, kidx,
+		    is_fail ? "Check" : "Success");
+
+	return is_fail;
+}
+
+static void _dpk_cal_select(struct rtw89_dev *rtwdev, bool force,
+			    enum rtw89_phy_idx phy, u8 kpath)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	static const u32 kip_reg[] = {0x813c, 0x8124, 0x8120};
+	u32 kip_bkup[RTW8852B_DPK_RF_PATH][RTW8852B_DPK_KIP_REG_NUM] = {};
+	u32 backup_rf_val[RTW8852B_DPK_RF_PATH][BACKUP_RF_REGS_NR];
+	u32 backup_bb_val[BACKUP_BB_REGS_NR];
+	bool is_fail = true, reloaded[RTW8852B_DPK_RF_PATH] = {};
+	u8 path;
+
+	if (dpk->is_dpk_reload_en) {
+		for (path = 0; path < RTW8852B_DPK_RF_PATH; path++) {
+			reloaded[path] = _dpk_reload_check(rtwdev, phy, path);
+			if (!reloaded[path] && dpk->bp[path][0].ch)
+				dpk->cur_idx[path] = !dpk->cur_idx[path];
+			else
+				_dpk_onoff(rtwdev, path, false);
+		}
+	} else {
+		for (path = 0; path < RTW8852B_DPK_RF_PATH; path++)
+			dpk->cur_idx[path] = 0;
+	}
+
+	_rfk_backup_bb_reg(rtwdev, &backup_bb_val[0]);
+
+	for (path = 0; path < RTW8852B_DPK_RF_PATH; path++) {
+		_dpk_bkup_kip(rtwdev, kip_reg, kip_bkup, path);
+		_rfk_backup_rf_reg(rtwdev, &backup_rf_val[path][0], path);
+		_dpk_information(rtwdev, phy, path);
+		if (rtwdev->is_tssi_mode[path])
+			_dpk_tssi_pause(rtwdev, path, true);
+	}
+
+	_dpk_bb_afe_setting(rtwdev, phy, path, kpath);
+
+	for (path = 0; path < RTW8852B_DPK_RF_PATH; path++) {
+		is_fail = _dpk_main(rtwdev, phy, path, 1);
+		_dpk_onoff(rtwdev, path, is_fail);
+	}
+
+	_dpk_bb_afe_restore(rtwdev, phy, path, kpath);
+	_rfk_restore_bb_reg(rtwdev, &backup_bb_val[0]);
+
+	for (path = 0; path < RTW8852B_DPK_RF_PATH; path++) {
+		_dpk_kip_restore(rtwdev, path);
+		_dpk_reload_kip(rtwdev, kip_reg, kip_bkup, path);
+		_rfk_restore_rf_reg(rtwdev, &backup_rf_val[path][0], path);
+		if (rtwdev->is_tssi_mode[path])
+			_dpk_tssi_pause(rtwdev, path, false);
+	}
+}
+
+static bool _dpk_bypass_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	struct rtw89_fem_info *fem = &rtwdev->fem;
+
+	if (fem->epa_2g && chan->band_type == RTW89_BAND_2G) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[DPK] Skip DPK due to 2G_ext_PA exist!!\n");
+		return true;
+	} else if (fem->epa_5g && chan->band_type == RTW89_BAND_5G) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[DPK] Skip DPK due to 5G_ext_PA exist!!\n");
+		return true;
+	} else if (fem->epa_6g && chan->band_type == RTW89_BAND_6G) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[DPK] Skip DPK due to 6G_ext_PA exist!!\n");
+		return true;
+	}
+
+	return false;
+}
+
+static void _dpk_force_bypass(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+{
+	u8 path, kpath;
+
+	kpath = _kpath(rtwdev, phy);
+
+	for (path = 0; path < RTW8852B_DPK_RF_PATH; path++) {
+		if (kpath & BIT(path))
+			_dpk_onoff(rtwdev, path, true);
+	}
+}
+
+static void _dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool force)
+{
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DPK] ****** DPK Start (Ver: 0x%x, Cv: %d, RF_para: %d) ******\n",
+		    RTW8852B_DPK_VER, rtwdev->hal.cv,
+		    RTW8852B_RF_REL_VERSION);
+
+	if (_dpk_bypass_check(rtwdev, phy))
+		_dpk_force_bypass(rtwdev, phy);
+	else
+		_dpk_cal_select(rtwdev, force, phy, RF_AB);
+}
+
+static void _dpk_track(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	s8 txagc_bb, txagc_bb_tp, ini_diff = 0, txagc_ofst;
+	s8 delta_ther[2] = {};
+	u8 trk_idx, txagc_rf;
+	u8 path, kidx;
+	u16 pwsf[2];
+	u8 cur_ther;
+	u32 tmp;
+
+	for (path = 0; path < RF_PATH_NUM_8852B; path++) {
+		kidx = dpk->cur_idx[path];
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK,
+			    "[DPK_TRK] ================[S%d[%d] (CH %d)]================\n",
+			    path, kidx, dpk->bp[path][kidx].ch);
+
+		cur_ther = ewma_thermal_read(&rtwdev->phystat.avg_thermal[path]);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK,
+			    "[DPK_TRK] thermal now = %d\n", cur_ther);
+
+		if (dpk->bp[path][kidx].ch && cur_ther)
+			delta_ther[path] = dpk->bp[path][kidx].ther_dpk - cur_ther;
+
+		if (dpk->bp[path][kidx].band == RTW89_BAND_2G)
+			delta_ther[path] = delta_ther[path] * 3 / 2;
+		else
+			delta_ther[path] = delta_ther[path] * 5 / 2;
+
+		txagc_rf = rtw89_phy_read32_mask(rtwdev, R_TXAGC_BB + (path << 13),
+						 0x0000003f);
+
+		if (rtwdev->is_tssi_mode[path]) {
+			trk_idx = rtw89_read_rf(rtwdev, path, RR_TXA, RR_TXA_TRK);
+
+			rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK,
+				    "[DPK_TRK] txagc_RF / track_idx = 0x%x / %d\n",
+				    txagc_rf, trk_idx);
+
+			txagc_bb =
+				rtw89_phy_read32_mask(rtwdev, R_TXAGC_BB + (path << 13),
+						      MASKBYTE2);
+			txagc_bb_tp =
+				rtw89_phy_read32_mask(rtwdev, R_TXAGC_TP + (path << 13),
+						      B_TXAGC_TP);
+
+			rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK,
+				    "[DPK_TRK] txagc_bb_tp / txagc_bb = 0x%x / 0x%x\n",
+				    txagc_bb_tp, txagc_bb);
+
+			txagc_ofst =
+				rtw89_phy_read32_mask(rtwdev, R_TXAGC_BB + (path << 13),
+						      MASKBYTE3);
+
+			rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK,
+				    "[DPK_TRK] txagc_offset / delta_ther = %d / %d\n",
+				    txagc_ofst, delta_ther[path]);
+			tmp = rtw89_phy_read32_mask(rtwdev, R_DPD_COM + (path << 8),
+						    B_DPD_COM_OF);
+			if (tmp == 0x1) {
+				txagc_ofst = 0;
+				rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK,
+					    "[DPK_TRK] HW txagc offset mode\n");
+			}
+
+			if (txagc_rf && cur_ther)
+				ini_diff = txagc_ofst + (delta_ther[path]);
+
+			tmp = rtw89_phy_read32_mask(rtwdev,
+						    R_P0_TXDPD + (path << 13),
+						    B_P0_TXDPD);
+			if (tmp == 0x0) {
+				pwsf[0] = dpk->bp[path][kidx].pwsf +
+					  txagc_bb_tp - txagc_bb + ini_diff;
+				pwsf[1] = dpk->bp[path][kidx].pwsf +
+					  txagc_bb_tp - txagc_bb + ini_diff;
+			} else {
+				pwsf[0] = dpk->bp[path][kidx].pwsf + ini_diff;
+				pwsf[1] = dpk->bp[path][kidx].pwsf + ini_diff;
+			}
+
+		} else {
+			pwsf[0] = (dpk->bp[path][kidx].pwsf + delta_ther[path]) & 0x1ff;
+			pwsf[1] = (dpk->bp[path][kidx].pwsf + delta_ther[path]) & 0x1ff;
+		}
+
+		tmp = rtw89_phy_read32_mask(rtwdev, R_DPK_TRK, B_DPK_TRK_DIS);
+		if (!tmp && txagc_rf) {
+			rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK,
+				    "[DPK_TRK] New pwsf[0] / pwsf[1] = 0x%x / 0x%x\n",
+				    pwsf[0], pwsf[1]);
+
+			rtw89_phy_write32_mask(rtwdev,
+					       R_DPD_BND + (path << 8) + (kidx << 2),
+					       B_DPD_BND_0, pwsf[0]);
+			rtw89_phy_write32_mask(rtwdev,
+					       R_DPD_BND + (path << 8) + (kidx << 2),
+					       B_DPD_BND_1, pwsf[1]);
+		}
+	}
+}
+
+static void _set_dpd_backoff(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	u8 tx_scale, ofdm_bkof, path, kpath;
+
+	kpath = _kpath(rtwdev, phy);
+
+	ofdm_bkof = rtw89_phy_read32_mask(rtwdev, R_DPD_BF + (phy << 13), B_DPD_BF_OFDM);
+	tx_scale = rtw89_phy_read32_mask(rtwdev, R_DPD_BF + (phy << 13), B_DPD_BF_SCA);
+
+	if (ofdm_bkof + tx_scale >= 44) {
+		/* move dpd backoff to bb, and set dpd backoff to 0 */
+		dpk->dpk_gs[phy] = 0x7f;
+		for (path = 0; path < RF_PATH_NUM_8852B; path++) {
+			if (!(kpath & BIT(path)))
+				continue;
+
+			rtw89_phy_write32_mask(rtwdev, R_DPD_CH0A + (path << 8),
+					       B_DPD_CFG, 0x7f7f7f);
+			rtw89_debug(rtwdev, RTW89_DBG_RFK,
+				    "[RFK] Set S%d DPD backoff to 0dB\n", path);
+		}
+	} else {
+		dpk->dpk_gs[phy] = 0x5b;
+	}
+}
+
 static void _tssi_rf_setting(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			     enum rtw89_rf_path path)
 {
@@ -2626,6 +3747,11 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 		    tssi_info->tssi_alimk_time);
 }
 
+void rtw8852b_dpk_init(struct rtw89_dev *rtwdev)
+{
+	_set_dpd_backoff(rtwdev, RTW89_PHY_0);
+}
+
 void rtw8852b_rck(struct rtw89_dev *rtwdev)
 {
 	u8 path;
@@ -2674,6 +3800,28 @@ void rtw8852b_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_RXDCK, BTC_WRFK_STOP);
 }
 
+void rtw8852b_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
+	u32 tx_en;
+
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DPK, BTC_WRFK_START);
+	rtw89_chip_stop_sch_tx(rtwdev, phy_idx, &tx_en, RTW89_SCH_TX_SEL_ALL);
+	_wait_rx_mode(rtwdev, _kpath(rtwdev, phy_idx));
+
+	rtwdev->dpk.is_dpk_enable = true;
+	rtwdev->dpk.is_dpk_reload_en = false;
+	_dpk(rtwdev, phy_idx, false);
+
+	rtw89_chip_resume_sch_tx(rtwdev, phy_idx, tx_en);
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DPK, BTC_WRFK_STOP);
+}
+
+void rtw8852b_dpk_track(struct rtw89_dev *rtwdev)
+{
+	_dpk_track(rtwdev);
+}
+
 void rtw8852b_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool hwtx_en)
 {
 	u8 phy_map = rtw89_btc_phymap(rtwdev, phy, RF_AB);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h
index e7402733d8480..f528320656001 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h
@@ -11,6 +11,9 @@ void rtw8852b_rck(struct rtw89_dev *rtwdev);
 void rtw8852b_dack(struct rtw89_dev *rtwdev);
 void rtw8852b_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 void rtw8852b_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
+void rtw8852b_dpk_init(struct rtw89_dev *rtwdev);
+void rtw8852b_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
+void rtw8852b_dpk_track(struct rtw89_dev *rtwdev);
 void rtw8852b_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool hwtx_en);
 void rtw8852b_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
 void rtw8852b_wifi_scan_notify(struct rtw89_dev *rtwdev, bool scan_start,
-- 
2.25.1

