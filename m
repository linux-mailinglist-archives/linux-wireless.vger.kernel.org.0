Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE44514328
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 09:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355066AbiD2HWR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 03:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355075AbiD2HWL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 03:22:11 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3938BF53F
        for <linux-wireless@vger.kernel.org>; Fri, 29 Apr 2022 00:18:51 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23T7Ih6I2001400, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23T7Ih6I2001400
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 Apr 2022 15:18:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 29 Apr 2022 15:18:43 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 29 Apr
 2022 15:18:42 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 08/16] rtw89: 8852c: rfk: add DPK
Date:   Fri, 29 Apr 2022 15:18:01 +0800
Message-ID: <20220429071809.32104-9-pkshih@realtek.com>
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

DPK is short for digital pre-distortion calibration. It can adjusts digital
waveform according to PA linear characteristics dynamically to enhance
TX EVM.

Do this calibration when we are going to run on AP channel. To prevent
power offset out of boundary, it monitors thermal and set proper boundary
to register.

8852c needs two backup buffers, so we enlarge the array. But, 8852a still
needs only one, so it only uses first element (index zero).

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |   11 +-
 drivers/net/wireless/realtek/rtw89/reg.h      |   49 +
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.c |    8 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |    2 +
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c | 1108 +++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.h |    2 +
 6 files changed, 1172 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 8fd719f93d6c7..2921814842ffa 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2690,6 +2690,7 @@ struct rtw89_dpk_bkup_para {
 	enum rtw89_bandwidth bw;
 	u8 ch;
 	bool path_ok;
+	u8 mdpd_en;
 	u8 txagc_dpk;
 	u8 ther_dpk;
 	u8 gs;
@@ -2699,11 +2700,12 @@ struct rtw89_dpk_bkup_para {
 struct rtw89_dpk_info {
 	bool is_dpk_enable;
 	bool is_dpk_reload_en;
-	u16 dc_i[RTW89_DPK_RF_PATH];
-	u16 dc_q[RTW89_DPK_RF_PATH];
-	u8 corr_val[RTW89_DPK_RF_PATH];
-	u8 corr_idx[RTW89_DPK_RF_PATH];
+	u16 dc_i[RTW89_DPK_RF_PATH][RTW89_DPK_BKUP_NUM];
+	u16 dc_q[RTW89_DPK_RF_PATH][RTW89_DPK_BKUP_NUM];
+	u8 corr_val[RTW89_DPK_RF_PATH][RTW89_DPK_BKUP_NUM];
+	u8 corr_idx[RTW89_DPK_RF_PATH][RTW89_DPK_BKUP_NUM];
 	u8 cur_idx[RTW89_DPK_RF_PATH];
+	u8 cur_k_set;
 	struct rtw89_dpk_bkup_para bp[RTW89_DPK_RF_PATH][RTW89_DPK_BKUP_NUM];
 };
 
@@ -2712,6 +2714,7 @@ struct rtw89_fem_info {
 	bool elna_5g;
 	bool epa_2g;
 	bool epa_5g;
+	bool epa_6g;
 };
 
 struct rtw89_phy_ch_info {
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 120fc13520fcc..6f5d1012c90c6 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3191,6 +3191,7 @@
 #define B_AX_GNT_BT_TX_SW_CTRL BIT(0)
 
 #define RR_MOD 0x00
+#define RR_MOD_V1 0x10000
 #define RR_MOD_IQK GENMASK(19, 4)
 #define RR_MOD_DPK GENMASK(19, 5)
 #define RR_MOD_MASK GENMASK(19, 16)
@@ -3357,8 +3358,16 @@
 #define RR_DCK2_CYCLE GENMASK(7, 2)
 #define RR_DCKC 0x95
 #define RR_DCKC_CHK BIT(3)
+#define RR_IQGEN 0x97
+#define RR_IQGEN_BIAS GENMASK(11, 8)
+#define RR_TXIQK 0x98
+#define RR_TXIQK_ATT2 GENMASK(15, 12)
+#define RR_TIA 0x9e
+#define RR_TIA_N6 BIT(8)
 #define RR_MIXER 0x9f
 #define RR_MIXER_GN GENMASK(4, 3)
+#define RR_LOGEN 0xa3
+#define RR_LOGEN_RPT GENMASK(19, 16)
 #define RR_XTALX2 0xb8
 #define RR_MALSEL 0xbe
 #define RR_LCK_TRG 0xd3
@@ -3370,6 +3379,7 @@
 #define RR_RCKD_BW BIT(2)
 #define RR_TXADBG 0xde
 #define RR_LUTDBG 0xdf
+#define RR_LUTDBG_TIA BIT(12)
 #define RR_LUTDBG_LOK BIT(2)
 #define RR_LUTWE2 0xee
 #define RR_LUTWE2_RTXBW BIT(2)
@@ -3580,6 +3590,8 @@
 #define B_TXAGC_TP GENMASK(2, 0)
 #define R_TSSI_THER 0x1C10
 #define B_TSSI_THER GENMASK(29, 24)
+#define R_TXAGC_BTP 0x1CA0
+#define B_TXAGC_BTP GENMASK(31, 24)
 #define R_TXAGC_BB 0x1C60
 #define B_TXAGC_BB_OFT GENMASK(31, 16)
 #define B_TXAGC_BB GENMASK(31, 24)
@@ -3866,10 +3878,15 @@
 #define B_DPD_DIS BIT(14)
 #define B_DPD_GDIS BIT(13)
 #define B_IQK_RFC_ON BIT(1)
+#define R_TXPWRB 0x56CC
+#define B_TXPWRB_ON BIT(28)
+#define B_TXPWRB_VAL GENMASK(27, 19)
 #define R_DPD_OFT_EN 0x5800
 #define B_DPD_OFT_EN BIT(28)
 #define R_DPD_OFT_ADDR 0x5804
 #define B_DPD_OFT_ADDR GENMASK(31, 27)
+#define R_TXPWRB_H 0x580c
+#define B_TXPWRB_RDY BIT(15)
 #define R_P0_TMETER 0x5810
 #define B_P0_TMETER GENMASK(15, 10)
 #define B_P0_TMETER_DIS BIT(16)
@@ -3981,16 +3998,23 @@
 #define IQK_DF4_TXT_8_25MHZ 0x021
 #define R_IQK_CFG 0x8034
 #define B_IQK_CFG_SET GENMASK(5, 4)
+#define R_TPG_SEL 0x8068
 #define R_TPG_MOD 0x806C
 #define B_TPG_MOD_F GENMASK(2, 1)
 #define R_MDPK_SYNC 0x8070
 #define B_MDPK_SYNC_SEL BIT(31)
 #define B_MDPK_SYNC_MAN GENMASK(31, 28)
 #define R_MDPK_RX_DCK 0x8074
+#define B_MDPK_RX_DCK_EN BIT(31)
+#define R_KIP_MOD 0x8078
+#define B_KIP_MOD GENMASK(19, 0)
 #define R_NCTL_RW 0x8080
 #define R_KIP_SYSCFG 0x8088
 #define R_KIP_CLK 0x808C
+#define R_DPK_IDL 0x809C
+#define B_DPK_IDL BIT(8)
 #define R_LDL_NORM 0x80A0
+#define B_LDL_NORM_MA BIT(16)
 #define B_LDL_NORM_PN GENMASK(12, 8)
 #define B_LDL_NORM_OP GENMASK(1, 0)
 #define R_DPK_CTL 0x80B0
@@ -4001,12 +4025,19 @@
 #define B_DPK_CFG2_ST BIT(14)
 #define R_DPK_CFG3 0x80C0
 #define R_KPATH_CFG 0x80D0
+#define B_KPATH_CFG_ED GENMASK(21, 20)
 #define R_KIP_RPT1 0x80D4
 #define B_KIP_RPT1_SEL GENMASK(21, 16)
 #define R_SRAM_IQRX 0x80D8
 #define R_GAPK 0x80E0
 #define B_GAPK_ADR BIT(0)
 #define R_SRAM_IQRX2 0x80E8
+#define R_DPK_MPA 0x80EC
+#define B_DPK_MPA_T0 BIT(10)
+#define B_DPK_MPA_T1 BIT(9)
+#define B_DPK_MPA_T2 BIT(8)
+#define R_DPK_WR 0x80F4
+#define B_DPK_WR_ST BIT(29)
 #define R_DPK_TRK 0x80f0
 #define B_DPK_TRK_DIS BIT(31)
 #define R_RPT_COM 0x80FC
@@ -4014,8 +4045,11 @@
 #define B_PRT_COM_DCI GENMASK(27, 16)
 #define B_PRT_COM_CORV GENMASK(15, 8)
 #define B_PRT_COM_DCQ GENMASK(11, 0)
+#define B_PRT_COM_RXOV BIT(8)
 #define B_PRT_COM_GL GENMASK(7, 4)
 #define B_PRT_COM_CORI GENMASK(7, 0)
+#define B_PRT_COM_RXBB GENMASK(5, 0)
+#define B_PRT_COM_DONE BIT(0)
 #define R_COEF_SEL 0x8104
 #define B_COEF_SEL_IQC BIT(0)
 #define B_COEF_SEL_MDPD BIT(8)
@@ -4045,14 +4079,22 @@
 #define B_CFIR_LUT_G2 BIT(2)
 #define B_CFIR_LUT_GP_V1 GENMASK(2, 0)
 #define B_CFIR_LUT_GP GENMASK(1, 0)
+#define R_DPK_GN 0x819C
+#define B_DPK_GN_EN GENMASK(17, 16)
+#define B_DPK_GN_AG GENMASK(9, 0)
 #define R_DPD_V1 0x81a0
+#define B_DPD_LBK BIT(7)
 #define R_DPD_CH0 0x81AC
 #define R_DPD_BND 0x81B4
 #define R_DPD_CH0A 0x81BC
+#define B_DPD_MEN GENMASK(31, 28)
+#define B_DPD_ORDER GENMASK(26, 24)
+#define B_DPD_SEL GENMASK(13, 8)
 #define R_TXAGC_RFK 0x81C4
 #define B_TXAGC_RFK_CH0 GENMASK(5, 0)
 #define R_DPD_COM 0x81C8
 #define R_KIP_IQP 0x81CC
+#define B_KIP_IQP_SW GENMASK(13, 12)
 #define B_KIP_IQP_IQSW GENMASK(5, 0)
 #define R_KIP_RPT 0x81D4
 #define B_KIP_RPT_SEL GENMASK(21, 16)
@@ -4060,8 +4102,15 @@
 #define R_LOAD_COEF 0x81DC
 #define B_LOAD_COEF_MDPD BIT(16)
 #define B_LOAD_COEF_CFIR GENMASK(1, 0)
+#define B_LOAD_COEF_DI BIT(1)
 #define B_LOAD_COEF_AUTO BIT(0)
+#define R_DPK_GL 0x81F0
+#define B_DPK_GL_A0 GENMASK(31, 28)
+#define B_DPK_GL_A1 GENMASK(17, 0)
 #define R_RPT_PER 0x81FC
+#define B_RPT_PER_TSSI GENMASK(28, 16)
+#define B_RPT_PER_OF GENMASK(15, 8)
+#define B_RPT_PER_TH GENMASK(5, 0)
 #define R_RXCFIR_P0C0 0x8D40
 #define R_RXCFIR_P0C1 0x8D84
 #define R_RXCFIR_P0C2 0x8DC8
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
index aa782534e76be..e3c2fce326516 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
@@ -2189,8 +2189,8 @@ static bool _dpk_sync_check(struct rtw89_dev *rtwdev,
 		    "[DPK] S%d Corr_idx / Corr_val = %d / %d\n", path, corr_idx,
 		    corr_val);
 
-	dpk->corr_idx[path] = corr_idx;
-	dpk->corr_val[path] = corr_val;
+	dpk->corr_idx[path][0] = corr_idx;
+	dpk->corr_val[path][0] = corr_val;
 
 	rtw89_phy_write32_mask(rtwdev, R_KIP_RPT1, B_KIP_RPT1_SEL, 0x9);
 
@@ -2203,8 +2203,8 @@ static bool _dpk_sync_check(struct rtw89_dev *rtwdev,
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d DC I/Q, = %d / %d\n",
 		    path, dc_i, dc_q);
 
-	dpk->dc_i[path] = dc_i;
-	dpk->dc_q[path] = dc_q;
+	dpk->dc_i[path][0] = dc_i;
+	dpk->dc_q[path][0] = dc_q;
 
 	if (dc_i > DPK_SYNC_TH_DC_I || dc_q > DPK_SYNC_TH_DC_Q ||
 	    corr_val < DPK_SYNC_TH_CORR)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 0b722675aad42..4fb3de71d032f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -1789,6 +1789,7 @@ static void rtw8852c_rfk_channel(struct rtw89_dev *rtwdev)
 	rtw8852c_rx_dck(rtwdev, phy_idx, false);
 	rtw8852c_iqk(rtwdev, phy_idx);
 	rtw8852c_tssi(rtwdev, phy_idx);
+	rtw8852c_dpk(rtwdev, phy_idx);
 	rtw89_fw_h2c_rf_ntfy_mcc(rtwdev);
 }
 
@@ -1804,6 +1805,7 @@ static void rtw8852c_rfk_scan(struct rtw89_dev *rtwdev, bool start)
 
 static void rtw8852c_rfk_track(struct rtw89_dev *rtwdev)
 {
+	rtw8852c_dpk_track(rtwdev);
 	rtw8852c_lck_track(rtwdev);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index 99258c6e5a811..84652a871a7e9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -1549,6 +1549,1092 @@ static void _set_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, u8 pat
 	}
 }
 
+#define RTW8852C_RF_REL_VERSION 34
+#define RTW8852C_DPK_VER 0x10
+#define RTW8852C_DPK_TH_AVG_NUM 4
+#define RTW8852C_DPK_RF_PATH 2
+#define RTW8852C_DPK_KIP_REG_NUM 5
+#define RTW8852C_DPK_RXSRAM_DBG 0
+
+enum rtw8852c_dpk_id {
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
+#define DPK_TXAGC_LOWER 0x2e
+#define DPK_TXAGC_UPPER 0x3f
+#define DPK_TXAGC_INVAL 0xff
+
+enum dpk_agc_step {
+	DPK_AGC_STEP_SYNC_DGAIN,
+	DPK_AGC_STEP_GAIN_LOSS_IDX,
+	DPK_AGC_STEP_GL_GT_CRITERION,
+	DPK_AGC_STEP_GL_LT_CRITERION,
+	DPK_AGC_STEP_SET_TX_GAIN,
+};
+
+static void _rf_direct_cntrl(struct rtw89_dev *rtwdev,
+			     enum rtw89_rf_path path, bool is_bybb)
+{
+	if (is_bybb)
+		rtw89_write_rf(rtwdev, path, RR_RSV1, RR_RSV1_RST, 0x1);
+	else
+		rtw89_write_rf(rtwdev, path, RR_RSV1, RR_RSV1_RST, 0x0);
+}
+
+static void _dpk_onoff(struct rtw89_dev *rtwdev,
+		       enum rtw89_rf_path path, bool off);
+
+static void _dpk_bkup_kip(struct rtw89_dev *rtwdev, const u32 reg[],
+			  u32 reg_bkup[][RTW8852C_DPK_KIP_REG_NUM], u8 path)
+{
+	u8 i;
+
+	for (i = 0; i < RTW8852C_DPK_KIP_REG_NUM; i++) {
+		reg_bkup[path][i] =
+			rtw89_phy_read32_mask(rtwdev, reg[i] + (path << 8), MASKDWORD);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] Backup 0x%x = %x\n",
+			    reg[i] + (path << 8), reg_bkup[path][i]);
+	}
+}
+
+static void _dpk_reload_kip(struct rtw89_dev *rtwdev, const u32 reg[],
+			    u32 reg_bkup[][RTW8852C_DPK_KIP_REG_NUM], u8 path)
+{
+	u8 i;
+
+	for (i = 0; i < RTW8852C_DPK_KIP_REG_NUM; i++) {
+		rtw89_phy_write32_mask(rtwdev, reg[i] + (path << 8),
+				       MASKDWORD, reg_bkup[path][i]);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] Reload 0x%x = %x\n",
+			    reg[i] + (path << 8), reg_bkup[path][i]);
+	}
+}
+
+static u8 _dpk_one_shot(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			enum rtw89_rf_path path, enum rtw8852c_dpk_id id)
+{
+	u16 dpk_cmd = 0x0;
+	u32 val;
+	int ret;
+
+	dpk_cmd = (u16)((id << 8) | (0x19 + path * 0x12));
+
+	rtw89_phy_write32_mask(rtwdev, R_NCTL_CFG, MASKDWORD, dpk_cmd);
+
+	ret = read_poll_timeout_atomic(rtw89_phy_read32_mask, val, val == 0x55,
+				       10, 20000, false, rtwdev, 0xbff8, MASKBYTE0);
+	mdelay(10);
+	rtw89_phy_write32_clr(rtwdev, R_NCTL_N1, MASKBYTE0);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DPK] one-shot for %s = 0x%x (ret=%d)\n",
+		    id == 0x06 ? "LBK_RXIQK" :
+		    id == 0x10 ? "SYNC" :
+		    id == 0x11 ? "MDPK_IDL" :
+		    id == 0x12 ? "MDPK_MPA" :
+		    id == 0x13 ? "GAIN_LOSS" : "PWR_CAL",
+		    dpk_cmd, ret);
+
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[DPK] one-shot over 20ms!!!!\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+static void _dpk_information(struct rtw89_dev *rtwdev,
+			     enum rtw89_phy_idx phy,
+			     enum rtw89_rf_path path)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	struct rtw89_hal *hal = &rtwdev->hal;
+
+	u8 kidx = dpk->cur_idx[path];
+
+	dpk->bp[path][kidx].band = hal->current_band_type;
+	dpk->bp[path][kidx].ch = hal->current_channel;
+	dpk->bp[path][kidx].bw = hal->current_band_width;
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
+	/*1. Keep ADC_fifo reset*/
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_A0 << path, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_A1 << path, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_A2 << path, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_A3 << path, 0x0);
+
+	/*2. BB for IQK DBG mode*/
+	rtw89_phy_write32_mask(rtwdev, R_UPD_CLK + (path << 13), MASKDWORD, 0xd801dffd);
+
+	/*3.Set DAC clk*/
+	rtw8852c_txck_force(rtwdev, path, true, DAC_960M);
+
+	/*4. Set ADC clk*/
+	rtw8852c_rxck_force(rtwdev, path, true, ADC_1920M);
+	rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0 + (path << 8), B_P0_CFCH_BW0, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW1 + (path << 8), B_P0_CFCH_BW1, 0xb);
+	rtw89_phy_write32_mask(rtwdev, R_P0_NRBW + (path << 13),
+			       B_P0_NRBW_DBG, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, MASKBYTE3, 0x1f);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, MASKBYTE3, 0x13);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, MASKHWORD, 0x0001);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, MASKHWORD, 0x0041);
+
+	/*5. ADDA fifo rst*/
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_A1 << path, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_A3 << path, 0x1);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d BB/AFE setting\n", path);
+}
+
+static void _dpk_bb_afe_restore(struct rtw89_dev *rtwdev, u8 path)
+{
+	rtw89_phy_write32_mask(rtwdev, R_P0_NRBW + (path << 13),
+			       B_P0_NRBW_DBG, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_A0 << path, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_A1 << path, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_A2 << path, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_A3 << path, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_UPD_CLK + (path << 13), MASKDWORD, 0x00000000);
+	rtw89_phy_write32_mask(rtwdev, R_P0_RXCK + (path << 13), B_P0_TXCK_ALL, 0x00);
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_A0 << path, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_A2 << path, 0x0);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d BB/AFE restore\n", path);
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
+static void _dpk_kip_control_rfc(struct rtw89_dev *rtwdev, u8 path, bool ctrl_by_kip)
+{
+	rtw89_phy_write32_mask(rtwdev, R_UPD_CLK + (path << 13), B_IQK_RFC_ON, ctrl_by_kip);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] RFC is controlled by %s\n",
+		    ctrl_by_kip ? "KIP" : "BB");
+}
+
+static void _dpk_txpwr_bb_force(struct rtw89_dev *rtwdev, u8 path, bool force)
+{
+	rtw89_phy_write32_mask(rtwdev, R_TXPWRB + (path << 13), B_TXPWRB_ON, force);
+	rtw89_phy_write32_mask(rtwdev, R_TXPWRB_H + (path << 13), B_TXPWRB_RDY, force);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,  "[DPK] S%d txpwr_bb_force %s\n",
+		    path, force ? "on" : "off");
+}
+
+static void _dpk_kip_restore(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			     enum rtw89_rf_path path)
+{
+	_dpk_one_shot(rtwdev, phy, path, D_KIP_RESTORE);
+	_dpk_kip_control_rfc(rtwdev, path, false);
+	_dpk_txpwr_bb_force(rtwdev, path, false);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d restore KIP\n", path);
+}
+
+static void _dpk_lbk_rxiqk(struct rtw89_dev *rtwdev,
+			   enum rtw89_phy_idx phy,
+			   enum rtw89_rf_path path)
+{
+#define RX_TONE_IDX 0x00250025 /* Q.2 9.25MHz */
+	u8 cur_rxbb;
+	u32 rf_11, reg_81cc;
+
+	rtw89_phy_write32_mask(rtwdev, R_DPD_V1 + (path << 8), B_DPD_LBK, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_MDPK_RX_DCK, B_MDPK_RX_DCK_EN, 0x1);
+
+	_dpk_kip_control_rfc(rtwdev, path, false);
+
+	cur_rxbb = rtw89_read_rf(rtwdev, path, RR_MOD, RR_MOD_M_RXBB);
+	rf_11 = rtw89_read_rf(rtwdev, path, RR_TXIG, RFREG_MASK);
+	reg_81cc = rtw89_phy_read32_mask(rtwdev, R_KIP_IQP + (path << 8),
+					 B_KIP_IQP_SW);
+
+	rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR0, 0x0);
+	rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_GR1, 0x3);
+	rtw89_write_rf(rtwdev, path, RR_TXIG, RR_TXIG_TG, 0xd);
+	rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_M_RXBB, 0x1f);
+
+	rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8), B_KIP_IQP_IQSW, 0x12);
+	rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8), B_KIP_IQP_SW, 0x3);
+
+	_dpk_kip_control_rfc(rtwdev, path, true);
+
+	rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, MASKDWORD, RX_TONE_IDX);
+
+	_dpk_one_shot(rtwdev, phy, path, LBK_RXIQK);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d LBK RXIQC = 0x%x\n", path,
+		    rtw89_phy_read32_mask(rtwdev, R_RXIQC + (path << 8), MASKDWORD));
+
+	_dpk_kip_control_rfc(rtwdev, path, false);
+
+	rtw89_write_rf(rtwdev, path, RR_TXIG, RFREG_MASK, rf_11);
+	rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_M_RXBB, cur_rxbb);
+	rtw89_phy_write32_mask(rtwdev, R_KIP_IQP + (path << 8), B_KIP_IQP_SW, reg_81cc);
+
+	rtw89_phy_write32_mask(rtwdev, R_MDPK_RX_DCK, B_MDPK_RX_DCK_EN, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_KPATH_CFG, B_KPATH_CFG_ED, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_LOAD_COEF + (path << 8), B_LOAD_COEF_DI, 0x1);
+
+	_dpk_kip_control_rfc(rtwdev, path, true);
+}
+
+static void _dpk_rf_setting(struct rtw89_dev *rtwdev, u8 gain,
+			    enum rtw89_rf_path path, u8 kidx)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+
+	if (dpk->bp[path][kidx].band == RTW89_BAND_2G) {
+		rtw89_write_rf(rtwdev, path, RR_MOD, RFREG_MASK,
+			       0x50121 | BIT(rtwdev->dbcc_en));
+		rtw89_write_rf(rtwdev, path, RR_MOD_V1, RR_MOD_MASK, RF_DPK);
+		rtw89_write_rf(rtwdev, path, RR_RXBB, RR_RXBB_ATTC, 0x2);
+		rtw89_write_rf(rtwdev, path, RR_RXBB, RR_RXBB_ATTR, 0x4);
+		rtw89_write_rf(rtwdev, path, RR_LUTDBG, RR_LUTDBG_TIA, 0x1);
+		rtw89_write_rf(rtwdev, path, RR_TIA, RR_TIA_N6, 0x1);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[DPK] RF 0x0/0x83/0x9e/0x1a/0xdf/0x1001a = 0x%x/ 0x%x/ 0x%x/ 0x%x/ 0x%x/ 0x%x\n",
+			    rtw89_read_rf(rtwdev, path, RR_MOD, RFREG_MASK),
+			    rtw89_read_rf(rtwdev, path, RR_RXBB, RFREG_MASK),
+			    rtw89_read_rf(rtwdev, path, RR_TIA, RFREG_MASK),
+			    rtw89_read_rf(rtwdev, path, RR_BTC, RFREG_MASK),
+			    rtw89_read_rf(rtwdev, path, RR_LUTDBG, RFREG_MASK),
+			    rtw89_read_rf(rtwdev, path, 0x1001a, RFREG_MASK));
+	} else {
+		rtw89_write_rf(rtwdev, path, RR_MOD, RFREG_MASK,
+			       0x50101 | BIT(rtwdev->dbcc_en));
+		rtw89_write_rf(rtwdev, path, RR_MOD_V1, RR_MOD_MASK, RF_DPK);
+
+		if (dpk->bp[path][kidx].band == RTW89_BAND_6G && dpk->bp[path][kidx].ch >= 161) {
+			rtw89_write_rf(rtwdev, path, RR_IQGEN, RR_IQGEN_BIAS, 0x8);
+			rtw89_write_rf(rtwdev, path, RR_LOGEN, RR_LOGEN_RPT, 0xd);
+		} else {
+			rtw89_write_rf(rtwdev, path, RR_LOGEN, RR_LOGEN_RPT, 0xd);
+		}
+
+		rtw89_write_rf(rtwdev, path, RR_RXA2, RR_RXA2_ATT, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_TXIQK, RR_TXIQK_ATT2, 0x3);
+		rtw89_write_rf(rtwdev, path, RR_LUTDBG, RR_LUTDBG_TIA, 0x1);
+		rtw89_write_rf(rtwdev, path, RR_TIA, RR_TIA_N6, 0x1);
+
+		if (dpk->bp[path][kidx].bw == RTW89_CHANNEL_WIDTH_160)
+			rtw89_write_rf(rtwdev, path, RR_RXBB2, RR_RXBB2_EBW, 0x0);
+	}
+}
+
+static void _dpk_tpg_sel(struct rtw89_dev *rtwdev, enum rtw89_rf_path path, u8 kidx)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+
+	if (dpk->bp[path][kidx].bw == RTW89_CHANNEL_WIDTH_160) {
+		rtw89_phy_write32_mask(rtwdev, R_TPG_MOD, B_TPG_MOD_F, 0x3);
+		rtw89_phy_write32_mask(rtwdev, R_TPG_SEL, MASKDWORD, 0x0180ff30);
+	} else if (dpk->bp[path][kidx].bw == RTW89_CHANNEL_WIDTH_80) {
+		rtw89_phy_write32_mask(rtwdev, R_TPG_MOD, B_TPG_MOD_F, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_TPG_SEL, MASKDWORD, 0xffe0fa00);
+	} else if (dpk->bp[path][kidx].bw == RTW89_CHANNEL_WIDTH_40) {
+		rtw89_phy_write32_mask(rtwdev, R_TPG_MOD, B_TPG_MOD_F, 0x2);
+		rtw89_phy_write32_mask(rtwdev, R_TPG_SEL, MASKDWORD, 0xff4009e0);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_TPG_MOD, B_TPG_MOD_F, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_TPG_SEL, MASKDWORD, 0xf9f007d0);
+	}
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] TPG_Select for %s\n",
+		    dpk->bp[path][kidx].bw == RTW89_CHANNEL_WIDTH_160 ? "160M" :
+		    dpk->bp[path][kidx].bw == RTW89_CHANNEL_WIDTH_80 ? "80M" :
+		    dpk->bp[path][kidx].bw == RTW89_CHANNEL_WIDTH_40 ? "40M" : "20M");
+}
+
+static bool _dpk_sync_check(struct rtw89_dev *rtwdev, enum rtw89_rf_path path, u8 kidx)
+{
+#define DPK_SYNC_TH_DC_I 200
+#define DPK_SYNC_TH_DC_Q 200
+#define DPK_SYNC_TH_CORR 170
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	u16 dc_i, dc_q;
+	u8 corr_val, corr_idx, rxbb;
+	u8 rxbb_ov;
+
+	rtw89_phy_write32_mask(rtwdev, R_KIP_RPT1, B_KIP_RPT1_SEL, 0x0);
+
+	corr_idx = rtw89_phy_read32_mask(rtwdev, R_RPT_COM, B_PRT_COM_CORI);
+	corr_val = rtw89_phy_read32_mask(rtwdev, R_RPT_COM, B_PRT_COM_CORV);
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
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DPK] S%d Corr_idx/ Corr_val /DC I/Q, = %d / %d / %d / %d\n",
+		    path, corr_idx, corr_val, dc_i, dc_q);
+
+	dpk->dc_i[path][kidx] = dc_i;
+	dpk->dc_q[path][kidx] = dc_q;
+
+	rtw89_phy_write32_mask(rtwdev, R_KIP_RPT1, B_KIP_RPT1_SEL, 0x8);
+	rxbb = rtw89_phy_read32_mask(rtwdev, R_RPT_COM, B_PRT_COM_RXBB);
+
+	rtw89_phy_write32_mask(rtwdev, R_KIP_RPT1, B_KIP_RPT1_SEL, 0x31);
+	rxbb_ov = rtw89_phy_read32_mask(rtwdev, R_RPT_COM, B_PRT_COM_RXOV);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DPK] S%d RXBB/ RXAGC_done /RXBB_ovlmt = %d / %d / %d\n",
+		    path, rxbb,
+		    rtw89_phy_read32_mask(rtwdev, R_RPT_COM, B_PRT_COM_DONE),
+		    rxbb_ov);
+
+	if (dc_i > DPK_SYNC_TH_DC_I || dc_q > DPK_SYNC_TH_DC_Q ||
+	    corr_val < DPK_SYNC_TH_CORR)
+		return true;
+	else
+		return false;
+}
+
+static u16 _dpk_dgain_read(struct rtw89_dev *rtwdev)
+{
+	u16 dgain = 0x0;
+
+	rtw89_phy_write32_clr(rtwdev, R_KIP_RPT1, B_KIP_RPT1_SEL);
+
+	dgain = rtw89_phy_read32_mask(rtwdev, R_RPT_COM, B_PRT_COM_DCI);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] DGain = 0x%x (%d)\n", dgain, dgain);
+
+	return dgain;
+}
+
+static u8 _dpk_gainloss_read(struct rtw89_dev *rtwdev)
+{
+	u8 result;
+
+	rtw89_phy_write32_mask(rtwdev, R_KIP_RPT1, B_KIP_RPT1_SEL, 0x6);
+	rtw89_phy_write32_mask(rtwdev, R_DPK_CFG2, B_DPK_CFG2_ST, 0x1);
+
+	result = rtw89_phy_read32_mask(rtwdev, R_RPT_COM, B_PRT_COM_GL);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] tmp GL = %d\n", result);
+
+	return result;
+}
+
+static void _dpk_kset_query(struct rtw89_dev *rtwdev, enum rtw89_rf_path path)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+
+	rtw89_phy_write32_mask(rtwdev, R_KIP_RPT + (path << 8), B_KIP_RPT_SEL, 0x10);
+	dpk->cur_k_set =
+		rtw89_phy_read32_mask(rtwdev, R_RPT_PER + (path << 8), 0xE0000000) - 1;
+}
+
+static void _dpk_kip_set_txagc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			       enum rtw89_rf_path path, u8 dbm, bool set_from_bb)
+{
+	if (set_from_bb) {
+		dbm = clamp_t(u8, dbm, 7, 24);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] set S%d txagc to %ddBm\n", path, dbm);
+		rtw89_phy_write32_mask(rtwdev, R_TXPWRB + (path << 13), B_TXPWRB_VAL, dbm << 2);
+	}
+	_dpk_one_shot(rtwdev, phy, path, D_TXAGC);
+	_dpk_kset_query(rtwdev, path);
+}
+
+static u8 _dpk_gainloss(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			enum rtw89_rf_path path, u8 kidx)
+{
+	_dpk_one_shot(rtwdev, phy, path, D_GAIN_LOSS);
+	_dpk_kip_set_txagc(rtwdev, phy, path, 0xff, false);
+
+	rtw89_phy_write32_mask(rtwdev, R_DPK_GL + (path << 8), B_DPK_GL_A1, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_DPK_GL + (path << 8), B_DPK_GL_A0, 0x0);
+
+	return _dpk_gainloss_read(rtwdev);
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
+			rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] PAS_Read[%02d]= 0x%08x\n", i,
+				    rtw89_phy_read32_mask(rtwdev, R_RPT_COM, MASKDWORD));
+		}
+	}
+
+	if (val1_i * val1_i + val1_q * val1_q >= (val2_i * val2_i + val2_q * val2_q) * 8 / 5)
+		return true;
+	else
+		return false;
+}
+
+static bool _dpk_kip_set_rxagc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			       enum rtw89_rf_path path, u8 kidx)
+{
+	_dpk_one_shot(rtwdev, phy, path, D_RXAGC);
+
+	return _dpk_sync_check(rtwdev, path, kidx);
+}
+
+static void _dpk_read_rxsram(struct rtw89_dev *rtwdev)
+{
+	u32 addr;
+
+	rtw89_rfk_parser(rtwdev, &rtw8852c_read_rxsram_pre_defs_tbl);
+
+	for (addr = 0; addr < 0x200; addr++) {
+		rtw89_phy_write32_mask(rtwdev, R_SRAM_IQRX, MASKDWORD, 0x00010000 | addr);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] RXSRAM[%03d] = 0x%07x\n", addr,
+			    rtw89_phy_read32_mask(rtwdev, R_RPT_COM, MASKDWORD));
+	}
+
+	rtw89_rfk_parser(rtwdev, &rtw8852c_read_rxsram_post_defs_tbl);
+}
+
+static void _dpk_bypass_rxiqc(struct rtw89_dev *rtwdev, enum rtw89_rf_path path)
+{
+	rtw89_phy_write32_mask(rtwdev, R_DPD_V1 + (path << 8), B_DPD_LBK, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_RXIQC + (path << 8), MASKDWORD, 0x40000002);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] Bypass RXIQC\n");
+}
+
+static u8 _dpk_agc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+		   enum rtw89_rf_path path, u8 kidx, u8 init_xdbm, u8 loss_only)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	u8 step = DPK_AGC_STEP_SYNC_DGAIN;
+	u8 tmp_dbm = init_xdbm, tmp_gl_idx = 0;
+	u8 tmp_rxbb;
+	u8 goout = 0, agc_cnt = 0;
+	u16 dgain = 0;
+	bool is_fail = false;
+	int limit = 200;
+
+	do {
+		switch (step) {
+		case DPK_AGC_STEP_SYNC_DGAIN:
+			is_fail = _dpk_kip_set_rxagc(rtwdev, phy, path, kidx);
+
+			if (RTW8852C_DPK_RXSRAM_DBG)
+				_dpk_read_rxsram(rtwdev);
+
+			if (is_fail) {
+				goout = 1;
+				break;
+			}
+
+			dgain = _dpk_dgain_read(rtwdev);
+
+			if (dgain > 0x5fc || dgain < 0x556) {
+				_dpk_one_shot(rtwdev, phy, path, D_SYNC);
+				dgain = _dpk_dgain_read(rtwdev);
+			}
+
+			if (agc_cnt == 0) {
+				if (dpk->bp[path][kidx].band == RTW89_BAND_2G)
+					_dpk_bypass_rxiqc(rtwdev, path);
+				else
+					_dpk_lbk_rxiqk(rtwdev, phy, path);
+			}
+			step = DPK_AGC_STEP_GAIN_LOSS_IDX;
+			break;
+
+		case DPK_AGC_STEP_GAIN_LOSS_IDX:
+			tmp_gl_idx = _dpk_gainloss(rtwdev, phy, path, kidx);
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
+			if (tmp_dbm <= 7) {
+				goout = 1;
+				rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] Txagc@lower bound!!\n");
+			} else {
+				tmp_dbm = max_t(u8, tmp_dbm - 3, 7);
+				_dpk_kip_set_txagc(rtwdev, phy, path, tmp_dbm, true);
+			}
+			step = DPK_AGC_STEP_SYNC_DGAIN;
+			agc_cnt++;
+			break;
+
+		case DPK_AGC_STEP_GL_LT_CRITERION:
+			if (tmp_dbm >= 24) {
+				goout = 1;
+				rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] Txagc@upper bound!!\n");
+			} else {
+				tmp_dbm = min_t(u8, tmp_dbm + 2, 24);
+				_dpk_kip_set_txagc(rtwdev, phy, path, tmp_dbm, true);
+			}
+			step = DPK_AGC_STEP_SYNC_DGAIN;
+			agc_cnt++;
+			break;
+
+		case DPK_AGC_STEP_SET_TX_GAIN:
+			_dpk_kip_control_rfc(rtwdev, path, false);
+			tmp_rxbb = rtw89_read_rf(rtwdev, path, RR_MOD, RR_MOD_M_RXBB);
+			if (tmp_rxbb + tmp_gl_idx > 0x1f)
+				tmp_rxbb = 0x1f;
+			else
+				tmp_rxbb = tmp_rxbb + tmp_gl_idx;
+
+			rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_M_RXBB, tmp_rxbb);
+			rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] Adjust RXBB (%+d) = 0x%x\n",
+				    tmp_gl_idx, tmp_rxbb);
+			_dpk_kip_control_rfc(rtwdev, path, true);
+			goout = 1;
+			break;
+		default:
+			goout = 1;
+			break;
+		}
+	} while (!goout && agc_cnt < 6 && --limit > 0);
+
+	if (limit <= 0)
+		rtw89_warn(rtwdev, "[DPK] exceed loop limit\n");
+
+	return is_fail;
+}
+
+static void _dpk_set_mdpd_para(struct rtw89_dev *rtwdev, u8 order)
+{
+	static const struct rtw89_rfk_tbl *order_tbls[] = {
+		&rtw8852c_dpk_mdpd_order0_defs_tbl,
+		&rtw8852c_dpk_mdpd_order1_defs_tbl,
+		&rtw8852c_dpk_mdpd_order2_defs_tbl,
+		&rtw8852c_dpk_mdpd_order3_defs_tbl,
+	};
+
+	if (order >= ARRAY_SIZE(order_tbls)) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] Wrong MDPD order!!(0x%x)\n", order);
+		return;
+	}
+
+	rtw89_rfk_parser(rtwdev, order_tbls[order]);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] Set %s for IDL\n",
+		    order == 0x0 ? "(5,3,1)" :
+		    order == 0x1 ? "(5,3,0)" :
+		    order == 0x2 ? "(5,0,0)" : "(7,3,1)");
+}
+
+static void _dpk_idl_mpa(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			 enum rtw89_rf_path path, u8 kidx)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	u8 cnt;
+	u8 ov_flag;
+	u32 dpk_sync;
+
+	rtw89_phy_write32_mask(rtwdev, R_LDL_NORM, B_LDL_NORM_MA, 0x1);
+
+	if (rtw89_phy_read32_mask(rtwdev, R_DPK_MPA, B_DPK_MPA_T2) == 0x1)
+		_dpk_set_mdpd_para(rtwdev, 0x2);
+	else if (rtw89_phy_read32_mask(rtwdev, R_DPK_MPA, B_DPK_MPA_T1) == 0x1)
+		_dpk_set_mdpd_para(rtwdev, 0x1);
+	else if (rtw89_phy_read32_mask(rtwdev, R_DPK_MPA, B_DPK_MPA_T0) == 0x1)
+		_dpk_set_mdpd_para(rtwdev, 0x0);
+	else if (dpk->bp[path][kidx].bw == RTW89_CHANNEL_WIDTH_5 ||
+		 dpk->bp[path][kidx].bw == RTW89_CHANNEL_WIDTH_10 ||
+		 dpk->bp[path][kidx].bw == RTW89_CHANNEL_WIDTH_20)
+		_dpk_set_mdpd_para(rtwdev, 0x2);
+	else if (dpk->bp[path][kidx].bw == RTW89_CHANNEL_WIDTH_40 ||
+		 dpk->bp[path][kidx].bw == RTW89_CHANNEL_WIDTH_80)
+		_dpk_set_mdpd_para(rtwdev, 0x1);
+	else
+		_dpk_set_mdpd_para(rtwdev, 0x0);
+
+	rtw89_phy_write32_mask(rtwdev, R_DPK_IDL, B_DPK_IDL, 0x0);
+	fsleep(1000);
+
+	_dpk_one_shot(rtwdev, phy, path, D_MDPK_IDL);
+	rtw89_phy_write32_mask(rtwdev, R_KIP_RPT1, B_KIP_RPT1_SEL, 0x0);
+	dpk_sync = rtw89_phy_read32_mask(rtwdev, R_RPT_COM, MASKDWORD);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] dpk_sync = 0x%x\n", dpk_sync);
+
+	rtw89_phy_write32_mask(rtwdev, R_KIP_RPT1, B_KIP_RPT1_SEL, 0xf);
+	ov_flag = rtw89_phy_read32_mask(rtwdev, R_RPT_COM, B_PRT_COM_SYNERR);
+	for (cnt = 0; cnt < 5 && ov_flag == 0x1; cnt++) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] ReK due to MDPK ov!!!\n");
+		_dpk_one_shot(rtwdev, phy, path, D_MDPK_IDL);
+		rtw89_phy_write32_mask(rtwdev, R_KIP_RPT1, B_KIP_RPT1_SEL, 0xf);
+		ov_flag = rtw89_phy_read32_mask(rtwdev, R_RPT_COM, B_PRT_COM_SYNERR);
+	}
+
+	if (ov_flag) {
+		_dpk_set_mdpd_para(rtwdev, 0x2);
+		_dpk_one_shot(rtwdev, phy, path, D_MDPK_IDL);
+	}
+}
+
+static bool _dpk_reload_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			      enum rtw89_rf_path path)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	bool is_reload = false;
+	u8 idx, cur_band, cur_ch;
+
+	cur_band = rtwdev->hal.current_band_type;
+	cur_ch = rtwdev->hal.current_channel;
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
+static void _dpk_kip_pwr_clk_onoff(struct rtw89_dev *rtwdev, bool turn_on)
+{
+	rtw89_rfk_parser(rtwdev, turn_on ? &rtw8852c_dpk_kip_pwr_clk_on_defs_tbl :
+					   &rtw8852c_dpk_kip_pwr_clk_off_defs_tbl);
+}
+
+static void _dpk_kip_preset_8852c(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+				  enum rtw89_rf_path path, u8 kidx)
+{
+	rtw89_phy_write32_mask(rtwdev, R_KIP_MOD, B_KIP_MOD,
+			       rtw89_read_rf(rtwdev, path, RR_MOD, RFREG_MASK));
+
+	if (rtwdev->hal.cv == CHIP_CAV)
+		rtw89_phy_write32_mask(rtwdev,
+				       R_DPD_CH0A + (path << 8) + (kidx << 2),
+				       B_DPD_SEL, 0x01);
+	else
+		rtw89_phy_write32_mask(rtwdev,
+				       R_DPD_CH0A + (path << 8) + (kidx << 2),
+				       B_DPD_SEL, 0x0c);
+
+	_dpk_kip_control_rfc(rtwdev, path, true);
+	rtw89_phy_write32_mask(rtwdev, R_COEF_SEL + (path << 8), B_COEF_SEL_MDPD, kidx);
+
+	_dpk_one_shot(rtwdev, phy, path, D_KIP_PRESET);
+}
+
+static const u32 dpk_par_regs[2][4] = {{0x8190, 0x8194, 0x8198, 0x81a4},
+				       {0x81a8, 0x81c4, 0x81c8, 0x81e8}
+};
+
+static void _dpk_para_query(struct rtw89_dev *rtwdev, enum rtw89_rf_path path, u8 kidx)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	u32 para;
+
+	para = rtw89_phy_read32_mask(rtwdev, dpk_par_regs[kidx][dpk->cur_k_set] + (path << 8),
+				     MASKDWORD);
+
+	dpk->bp[path][kidx].txagc_dpk = (para >> 10) & 0x3f;
+	dpk->bp[path][kidx].ther_dpk = (para >> 26) & 0x3f;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] thermal/ txagc_RF (K%d) = 0x%x/ 0x%x\n",
+		    dpk->cur_k_set, dpk->bp[path][kidx].ther_dpk, dpk->bp[path][kidx].txagc_dpk);
+}
+
+static void _dpk_gain_normalize_8852c(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+				      enum rtw89_rf_path path, u8 kidx, bool is_execute)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+
+	if (is_execute) {
+		rtw89_phy_write32_mask(rtwdev, R_DPK_GN + (path << 8), B_DPK_GN_AG, 0x200);
+		rtw89_phy_write32_mask(rtwdev, R_DPK_GN + (path << 8), B_DPK_GN_EN, 0x3);
+
+		_dpk_one_shot(rtwdev, phy, path, D_GAIN_NORM);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, dpk_par_regs[kidx][dpk->cur_k_set] + (path << 8),
+				       0x0000007F, 0x5b);
+	}
+	dpk->bp[path][kidx].gs =
+		rtw89_phy_read32_mask(rtwdev, dpk_par_regs[kidx][dpk->cur_k_set] + (path << 8),
+				      0x0000007F);
+}
+
+static u8 _dpk_order_convert(struct rtw89_dev *rtwdev)
+{
+	u32 val32 = rtw89_phy_read32_mask(rtwdev, R_LDL_NORM, B_LDL_NORM_OP);
+	u8 val;
+
+	switch (val32) {
+	case 0:
+		val = 0x6;
+		break;
+	case 1:
+		val = 0x2;
+		break;
+	case 2:
+		val = 0x0;
+		break;
+	case 3:
+		val = 0x7;
+		break;
+	default:
+		val = 0xff;
+		break;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] convert MDPD order to 0x%x\n", val);
+
+	return val;
+}
+
+static void _dpk_on(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+		    enum rtw89_rf_path path, u8 kidx)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+
+	rtw89_phy_write32_mask(rtwdev, R_LOAD_COEF + (path << 8), B_LOAD_COEF_MDPD, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_LOAD_COEF + (path << 8), B_LOAD_COEF_MDPD, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_DPD_CH0A + (path << 8) + (kidx << 2),
+			       B_DPD_ORDER, _dpk_order_convert(rtwdev));
+
+	dpk->bp[path][kidx].mdpd_en = BIT(dpk->cur_k_set);
+	dpk->bp[path][kidx].path_ok = true;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d[%d] path_ok = 0x%x\n",
+		    path, kidx, dpk->bp[path][kidx].mdpd_en);
+
+	rtw89_phy_write32_mask(rtwdev, R_DPD_CH0A + (path << 8) + (kidx << 2),
+			       B_DPD_MEN, dpk->bp[path][kidx].mdpd_en);
+
+	_dpk_gain_normalize_8852c(rtwdev, phy, path, kidx, false);
+}
+
+static bool _dpk_main(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+		      enum rtw89_rf_path path, u8 gain)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	u8 kidx = dpk->cur_idx[path];
+	u8 init_xdbm = 15;
+	bool is_fail;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DPK] ========= S%d[%d] DPK Start =========\n", path, kidx);
+	_dpk_kip_control_rfc(rtwdev, path, false);
+	_rf_direct_cntrl(rtwdev, path, false);
+	rtw89_write_rf(rtwdev, path, RR_BBDC, RFREG_MASK, 0x03ffd);
+	_dpk_rf_setting(rtwdev, gain, path, kidx);
+	_set_rx_dck(rtwdev, phy, path, false);
+	_dpk_kip_pwr_clk_onoff(rtwdev, true);
+	_dpk_kip_preset_8852c(rtwdev, phy, path, kidx);
+	_dpk_txpwr_bb_force(rtwdev, path, true);
+	_dpk_kip_set_txagc(rtwdev, phy, path, init_xdbm, true);
+	_dpk_tpg_sel(rtwdev, path, kidx);
+	is_fail = _dpk_agc(rtwdev, phy, path, kidx, init_xdbm, false);
+	if (is_fail)
+		goto _error;
+
+	_dpk_idl_mpa(rtwdev, phy, path, kidx);
+	_dpk_para_query(rtwdev, path, kidx);
+	_dpk_on(rtwdev, phy, path, kidx);
+
+_error:
+	_dpk_kip_control_rfc(rtwdev, path, false);
+	rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_MASK, RF_RX);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d[%d]_K%d %s\n", path, kidx,
+		    dpk->cur_k_set, is_fail ? "need Check" : "is Success");
+
+	return is_fail;
+}
+
+static void _dpk_init(struct rtw89_dev *rtwdev, u8 path)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	u8 kidx = dpk->cur_idx[path];
+
+	dpk->bp[path][kidx].path_ok = false;
+}
+
+static void _dpk_drf_direct_cntrl(struct rtw89_dev *rtwdev, u8 path, bool is_bybb)
+{
+	if (is_bybb)
+		rtw89_write_rf(rtwdev,  path, RR_BBDC, RR_BBDC_SEL, 0x1);
+	else
+		rtw89_write_rf(rtwdev,  path, RR_BBDC, RR_BBDC_SEL, 0x0);
+}
+
+static void _dpk_cal_select(struct rtw89_dev *rtwdev, bool force,
+			    enum rtw89_phy_idx phy, u8 kpath)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	static const u32 kip_reg[] = {0x813c, 0x8124, 0x8120, 0xc0d4, 0xc0d8};
+	u32 backup_rf_val[RTW8852C_DPK_RF_PATH][BACKUP_RF_REGS_NR];
+	u32 kip_bkup[RTW8852C_DPK_RF_PATH][RTW8852C_DPK_KIP_REG_NUM] = {};
+	u8 path;
+	bool is_fail = true, reloaded[RTW8852C_DPK_RF_PATH] = {false};
+
+	if (dpk->is_dpk_reload_en) {
+		for (path = 0; path < RTW8852C_DPK_RF_PATH; path++) {
+			if (!(kpath & BIT(path)))
+				continue;
+
+			reloaded[path] = _dpk_reload_check(rtwdev, phy, path);
+			if (!reloaded[path] && dpk->bp[path][0].ch != 0)
+				dpk->cur_idx[path] = !dpk->cur_idx[path];
+			else
+				_dpk_onoff(rtwdev, path, false);
+		}
+	} else {
+		for (path = 0; path < RTW8852C_DPK_RF_PATH; path++)
+			dpk->cur_idx[path] = 0;
+	}
+	for (path = 0; path < RTW8852C_DPK_RF_PATH; path++) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[DPK] ========= S%d[%d] DPK Init =========\n",
+			    path, dpk->cur_idx[path]);
+		_dpk_bkup_kip(rtwdev, kip_reg, kip_bkup, path);
+		_rfk_backup_rf_reg(rtwdev, backup_rf_val[path], path);
+		_dpk_information(rtwdev, phy, path);
+		_dpk_init(rtwdev, path);
+		if (rtwdev->is_tssi_mode[path])
+			_dpk_tssi_pause(rtwdev, path, true);
+	}
+
+	for (path = 0; path < RTW8852C_DPK_RF_PATH; path++) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[DPK] ========= S%d[%d] DPK Start =========\n",
+			    path, dpk->cur_idx[path]);
+		rtw8852c_disable_rxagc(rtwdev, path, 0x0);
+		_dpk_drf_direct_cntrl(rtwdev, path, false);
+		_dpk_bb_afe_setting(rtwdev, phy, path, kpath);
+		is_fail = _dpk_main(rtwdev, phy, path, 1);
+		_dpk_onoff(rtwdev, path, is_fail);
+	}
+
+	for (path = 0; path < RTW8852C_DPK_RF_PATH; path++) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[DPK] ========= S%d[%d] DPK Restore =========\n",
+			    path, dpk->cur_idx[path]);
+		_dpk_kip_restore(rtwdev, phy, path);
+		_dpk_reload_kip(rtwdev, kip_reg, kip_bkup, path);
+		_rfk_restore_rf_reg(rtwdev, backup_rf_val[path], path);
+		_dpk_bb_afe_restore(rtwdev, path);
+		rtw8852c_disable_rxagc(rtwdev, path, 0x1);
+		if (rtwdev->is_tssi_mode[path])
+			_dpk_tssi_pause(rtwdev, path, false);
+	}
+	_dpk_kip_pwr_clk_onoff(rtwdev, false);
+}
+
+static bool _dpk_bypass_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+{
+	struct rtw89_fem_info *fem = &rtwdev->fem;
+
+	if (rtwdev->hal.cv == CHIP_CAV && rtwdev->hal.current_band_type != RTW89_BAND_2G) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] Skip DPK due to CAV & not 2G!!\n");
+		return true;
+	} else if (fem->epa_2g && rtwdev->hal.current_band_type == RTW89_BAND_2G) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] Skip DPK due to 2G_ext_PA exist!!\n");
+		return true;
+	} else if (fem->epa_5g && rtwdev->hal.current_band_type == RTW89_BAND_5G) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] Skip DPK due to 5G_ext_PA exist!!\n");
+		return true;
+	} else if (fem->epa_6g && rtwdev->hal.current_band_type == RTW89_BAND_6G) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] Skip DPK due to 6G_ext_PA exist!!\n");
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
+	for (path = 0; path < RTW8852C_DPK_RF_PATH; path++) {
+		if (kpath & BIT(path))
+			_dpk_onoff(rtwdev, path, true);
+	}
+}
+
+static void _dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool force)
+{
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DPK] ****** DPK Start (Ver: 0x%x, Cv: %d, RF_para: %d) ******\n",
+		    RTW8852C_DPK_VER, rtwdev->hal.cv,
+		    RTW8852C_RF_REL_VERSION);
+
+	if (_dpk_bypass_check(rtwdev, phy))
+		_dpk_force_bypass(rtwdev, phy);
+	else
+		_dpk_cal_select(rtwdev, force, phy, _kpath(rtwdev, phy));
+
+	if (rtw89_read_rf(rtwdev, RF_PATH_A, RR_DCKC, RR_DCKC_CHK) == 0x1)
+		rtw8852c_rx_dck(rtwdev, phy, false);
+}
+
+static void _dpk_onoff(struct rtw89_dev *rtwdev,
+		       enum rtw89_rf_path path, bool off)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	u8 val, kidx = dpk->cur_idx[path];
+
+	val = dpk->is_dpk_enable && !off && dpk->bp[path][kidx].path_ok ?
+	      dpk->bp[path][kidx].mdpd_en : 0;
+
+	rtw89_phy_write32_mask(rtwdev, R_DPD_CH0A + (path << 8) + (kidx << 2),
+			       B_DPD_MEN, val);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d[%d] DPK %s !!!\n", path,
+		    kidx, dpk->is_dpk_enable && !off ? "enable" : "disable");
+}
+
+static void _dpk_track(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	u8 path, kidx;
+	u8 txagc_rf = 0;
+	s8 txagc_bb = 0, txagc_bb_tp = 0, txagc_ofst = 0;
+	u8 cur_ther;
+	s8 delta_ther = 0;
+	s16 pwsf_tssi_ofst;
+
+	for (path = 0; path < RTW8852C_DPK_RF_PATH; path++) {
+		kidx = dpk->cur_idx[path];
+		rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK,
+			    "[DPK_TRK] ================[S%d[%d] (CH %d)]================\n",
+			    path, kidx, dpk->bp[path][kidx].ch);
+
+		txagc_rf =
+			rtw89_phy_read32_mask(rtwdev, R_TXAGC_BB + (path << 13), 0x0000003f);
+		txagc_bb =
+			rtw89_phy_read32_mask(rtwdev, R_TXAGC_BB + (path << 13), MASKBYTE2);
+		txagc_bb_tp =
+			rtw89_phy_read32_mask(rtwdev, R_TXAGC_BTP + (path << 13), B_TXAGC_BTP);
+
+		/* rpt from KIP */
+		rtw89_phy_write32_mask(rtwdev, R_KIP_RPT + (path << 8), B_KIP_RPT_SEL, 0xf);
+		cur_ther =
+			rtw89_phy_read32_mask(rtwdev, R_RPT_PER + (path << 8), B_RPT_PER_TH);
+		txagc_ofst =
+			rtw89_phy_read32_mask(rtwdev, R_RPT_PER + (path << 8), B_RPT_PER_OF);
+		pwsf_tssi_ofst =
+			rtw89_phy_read32_mask(rtwdev, R_RPT_PER + (path << 8), B_RPT_PER_TSSI);
+		pwsf_tssi_ofst = sign_extend32(pwsf_tssi_ofst, 12);
+
+		cur_ther = ewma_thermal_read(&rtwdev->phystat.avg_thermal[path]);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK,
+			    "[DPK_TRK] thermal now = %d\n", cur_ther);
+
+		if (dpk->bp[path][kidx].ch != 0 && cur_ther != 0)
+			delta_ther = dpk->bp[path][kidx].ther_dpk - cur_ther;
+
+		delta_ther = delta_ther * 1 / 2;
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK,
+			    "[DPK_TRK] extra delta_ther = %d (0x%x / 0x%x@k)\n",
+			    delta_ther, cur_ther, dpk->bp[path][kidx].ther_dpk);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK,
+			    "[DPK_TRK] delta_txagc = %d (0x%x / 0x%x@k)\n",
+			    txagc_rf - dpk->bp[path][kidx].txagc_dpk, txagc_rf,
+			    dpk->bp[path][kidx].txagc_dpk);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK,
+			    "[DPK_TRK] txagc_offset / pwsf_tssi_ofst = 0x%x / %+d\n",
+			    txagc_ofst, pwsf_tssi_ofst);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK,
+			    "[DPK_TRK] txagc_bb_tp / txagc_bb = 0x%x / 0x%x\n",
+			    txagc_bb_tp, txagc_bb);
+
+		if (rtw89_phy_read32_mask(rtwdev, R_DPK_WR, B_DPK_WR_ST) == 0x0 &&
+		    txagc_rf != 0 && rtwdev->hal.cv == CHIP_CAV) {
+			rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK,
+				    "[DPK_TRK] New pwsf = 0x%x\n", 0x78 - delta_ther);
+
+			rtw89_phy_write32_mask(rtwdev, R_DPD_BND + (path << 8) + (kidx << 2),
+					       0x07FC0000, 0x78 - delta_ther);
+		}
+	}
+}
+
 static void _tssi_set_sys(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			  enum rtw89_rf_path path)
 {
@@ -2772,6 +3858,28 @@ void rtw8852c_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool is_a
 	}
 }
 
+void rtw8852c_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	u32 tx_en;
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
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
+void rtw8852c_dpk_track(struct rtw89_dev *rtwdev)
+{
+	_dpk_track(rtwdev);
+}
+
 void rtw8852c_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 {
 	u32 i, path = RF_PATH_A, path_max = RF_PATH_NUM_8852C;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
index 5c0623f6af208..e42fb1a4965ef 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
@@ -11,6 +11,8 @@ void rtw8852c_rck(struct rtw89_dev *rtwdev);
 void rtw8852c_dack(struct rtw89_dev *rtwdev);
 void rtw8852c_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 void rtw8852c_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, bool is_afe);
+void rtw8852c_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
+void rtw8852c_dpk_track(struct rtw89_dev *rtwdev);
 void rtw8852c_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
 void rtw8852c_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
 void rtw8852c_tssi_cont_en_phyidx(struct rtw89_dev *rtwdev, bool en, u8 phy_idx);
-- 
2.25.1

