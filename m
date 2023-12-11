Return-Path: <linux-wireless+bounces-636-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5C280C357
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 09:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03AC280DFA
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 08:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57428210F5;
	Mon, 11 Dec 2023 08:35:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FD7B7
	for <linux-wireless@vger.kernel.org>; Mon, 11 Dec 2023 00:35:03 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BB8Yt8qA2598433, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BB8Yt8qA2598433
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Dec 2023 16:34:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 11 Dec 2023 16:34:55 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 11 Dec
 2023 16:34:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/6] wifi: rtw89: 8922a: add power on/off functions
Date: Mon, 11 Dec 2023 16:33:37 +0800
Message-ID: <20231211083341.118047-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211083341.118047-1-pkshih@realtek.com>
References: <20231211083341.118047-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

The power on/off functions are to turn on hardware function blocks and
to turn off them if we are going to stay in idle state.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.h      |   5 +
 drivers/net/wireless/realtek/rtw89/reg.h      | 168 +++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 233 ++++++++++++++++++
 3 files changed, 406 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 70071b5243c6..44248900f426 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1261,6 +1261,7 @@ enum rtw89_mac_xtal_si_offset {
 #define XTAL_SC_XI_MASK		GENMASK(7, 0)
 	XTAL_SI_XTAL_SC_XO = 0x05,
 #define XTAL_SC_XO_MASK		GENMASK(7, 0)
+	XTAL_SI_XREF_MODE = 0x0B,
 	XTAL_SI_PWR_CUT = 0x10,
 #define XTAL_SI_SMALL_PWR_CUT	BIT(0)
 #define XTAL_SI_BIG_PWR_CUT	BIT(1)
@@ -1270,6 +1271,8 @@ enum rtw89_mac_xtal_si_offset {
 #define XTAL_SI_LDO_LPS		GENMASK(6, 4)
 	XTAL_SI_XTAL_XMD_4 = 0x26,
 #define XTAL_SI_LPS_CAP		GENMASK(3, 0)
+	XTAL_SI_XREF_RF1 = 0x2D,
+	XTAL_SI_XREF_RF2 = 0x2E,
 	XTAL_SI_CV = 0x41,
 #define XTAL_SI_ACV_MASK	GENMASK(3, 0)
 	XTAL_SI_LOW_ADDR = 0x62,
@@ -1297,6 +1300,8 @@ enum rtw89_mac_xtal_si_offset {
 	XTAL_SI_SRAM_CTRL = 0xA1,
 #define XTAL_SI_SRAM_DIS	BIT(1)
 #define FULL_BIT_MASK		GENMASK(7, 0)
+	XTAL_SI_PLL = 0xE0,
+	XTAL_SI_PLL_1 = 0xE1,
 };
 
 static inline
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index eb40bfed9ed4..65d8a0f36700 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3742,6 +3742,44 @@
 #define B_BE_DIS_CLK_REG1_GATE BIT(1)
 #define B_BE_DIS_CLK_REG0_GATE BIT(0)
 
+#define R_BE_ANAPAR_POW_MAC 0x0016
+#define B_BE_POW_PC_LDO_PORT1 BIT(3)
+#define B_BE_POW_PC_LDO_PORT0 BIT(2)
+#define B_BE_POW_PLL_V1 BIT(1)
+#define B_BE_POW_POWER_CUT_POW_LDO BIT(0)
+
+#define R_BE_SYS_ADIE_PAD_PWR_CTRL 0x0018
+#define B_BE_SYM_PADPDN_WL_RFC1_1P3 BIT(6)
+#define B_BE_SYM_PADPDN_WL_RFC0_1P3 BIT(5)
+
+#define R_BE_AFE_LDO_CTRL 0x0020
+#define B_BE_FORCE_MACBBBT_PWR_ON BIT(31)
+#define B_BE_R_SYM_WLPOFF_P4_PC_EN BIT(28)
+#define B_BE_R_SYM_WLPOFF_P3_PC_EN BIT(27)
+#define B_BE_R_SYM_WLPOFF_P2_PC_EN BIT(26)
+#define B_BE_R_SYM_WLPOFF_P1_PC_EN BIT(25)
+#define B_BE_R_SYM_WLPOFF_PC_EN BIT(24)
+#define B_BE_AON_OFF_PC_EN BIT(23)
+#define B_BE_R_SYM_WLPON_P3_PC_EN BIT(21)
+#define B_BE_R_SYM_WLPON_P2_PC_EN BIT(20)
+#define B_BE_R_SYM_WLPON_P1_PC_EN BIT(19)
+#define B_BE_R_SYM_WLPON_PC_EN BIT(18)
+#define B_BE_R_SYM_WLBBPON1_P1_PC_EN BIT(15)
+#define B_BE_R_SYM_WLBBPON1_PC_EN BIT(14)
+#define B_BE_R_SYM_WLBBPON_P1_PC_EN BIT(13)
+#define B_BE_R_SYM_WLBBPON_PC_EN BIT(12)
+#define B_BE_R_SYM_DIS_WPHYBBOFF_PC BIT(10)
+#define B_BE_R_SYM_WLBBOFF1_P4_PC_EN BIT(9)
+#define B_BE_R_SYM_WLBBOFF1_P3_PC_EN BIT(8)
+#define B_BE_R_SYM_WLBBOFF1_P2_PC_EN BIT(7)
+#define B_BE_R_SYM_WLBBOFF1_P1_PC_EN BIT(6)
+#define B_BE_R_SYM_WLBBOFF1_PC_EN BIT(5)
+#define B_BE_R_SYM_WLBBOFF_P4_PC_EN BIT(4)
+#define B_BE_R_SYM_WLBBOFF_P3_PC_EN BIT(3)
+#define B_BE_R_SYM_WLBBOFF_P2_PC_EN BIT(2)
+#define B_BE_R_SYM_WLBBOFF_P1_PC_EN BIT(1)
+#define B_BE_R_SYM_WLBBOFF_PC_EN BIT(0)
+
 #define R_BE_AFE_CTRL1 0x0024
 #define B_BE_R_SYM_WLCMAC0_P4_PC_EN BIT(28)
 #define B_BE_R_SYM_WLCMAC0_P3_PC_EN BIT(27)
@@ -3886,6 +3924,28 @@
 #define B_BE_R_SYM_ISO_BTSDIO2PP BIT(1)
 #define B_BE_R_SYM_ISO_SPDIO2PP BIT(0)
 
+#define R_BE_FEN_RST_ENABLE 0x0084
+#define B_BE_R_SYM_FEN_WLMACOFF BIT(31)
+#define B_BE_R_SYM_ISO_WA12PP BIT(28)
+#define B_BE_R_SYM_ISO_CMAC12PP BIT(25)
+#define B_BE_R_SYM_ISO_CMAC02PP BIT(24)
+#define B_BE_R_SYM_ISO_ADDA_P32PP BIT(23)
+#define B_BE_R_SYM_ISO_ADDA_P22PP BIT(22)
+#define B_BE_R_SYM_ISO_ADDA_P12PP BIT(21)
+#define B_BE_R_SYM_ISO_ADDA_P02PP BIT(20)
+#define B_BE_CMAC1_FEN BIT(17)
+#define B_BE_CMAC0_FEN BIT(16)
+#define B_BE_SYM_ISO_BBPON12PP BIT(13)
+#define B_BE_SYM_ISO_BB12PP BIT(12)
+#define B_BE_BOOT_RDY1 BIT(10)
+#define B_BE_FEN_BB1_IP_RSTN BIT(9)
+#define B_BE_FEN_BB1PLAT_RSTB BIT(8)
+#define B_BE_SYM_ISO_BBPON02PP BIT(5)
+#define B_BE_SYM_ISO_BB02PP BIT(4)
+#define B_BE_BOOT_RDY0 BIT(2)
+#define B_BE_FEN_BB_IP_RSTN BIT(1)
+#define B_BE_FEN_BBPLAT_RSTB BIT(0)
+
 #define R_BE_PLATFORM_ENABLE 0x0088
 #define B_BE_HOLD_AFTER_RESET BIT(11)
 #define B_BE_SYM_WLPLT_MEM_MUX_EN BIT(10)
@@ -3899,6 +3959,51 @@
 #define B_BE_WCPU_EN BIT(1)
 #define B_BE_PLATFORM_EN BIT(0)
 
+#define R_BE_WLLPS_CTRL 0x0090
+#define B_BE_LPSOP_BBMEMDS BIT(30)
+#define B_BE_LPSOP_BBOFF BIT(29)
+#define B_BE_LPSOP_MACOFF BIT(28)
+#define B_BE_LPSOP_OFF_CAPC_EN BIT(27)
+#define B_BE_LPSOP_MEM_DS BIT(26)
+#define B_BE_LPSOP_XTALM_LPS BIT(23)
+#define B_BE_LPSOP_XTAL BIT(22)
+#define B_BE_LPSOP_ACLK_DIV_2 BIT(21)
+#define B_BE_LPSOP_ACLK_SEL BIT(20)
+#define B_BE_LPSOP_ASWRM BIT(17)
+#define B_BE_LPSOP_ASWR BIT(16)
+#define B_BE_LPSOP_DSWR_ADJ_MASK GENMASK(15, 12)
+#define B_BE_LPSOP_DSWRSD BIT(10)
+#define B_BE_LPSOP_DSWRM BIT(9)
+#define B_BE_LPSOP_DSWR BIT(8)
+#define B_BE_LPSOP_OLD_ADJ_MASK GENMASK(7, 4)
+#define B_BE_FORCE_LEAVE_LPS BIT(3)
+#define B_BE_LPSOP_OLDSD BIT(2)
+#define B_BE_DIS_WLBT_LPSEN_LOPC BIT(1)
+#define B_BE_WL_LPS_EN BIT(0)
+
+#define R_BE_WLRESUME_CTRL 0x0094
+#define B_BE_LPSROP_DMEM5_RSU_EN BIT(31)
+#define B_BE_LPSROP_DMEM4_RSU_EN BIT(30)
+#define B_BE_LPSROP_DMEM3_RSU_EN BIT(29)
+#define B_BE_LPSROP_DMEM2_RSU_EN BIT(28)
+#define B_BE_LPSROP_DMEM1_RSU_EN BIT(27)
+#define B_BE_LPSROP_DMEM0_RSU_EN BIT(26)
+#define B_BE_LPSROP_IMEM5_RSU_EN BIT(25)
+#define B_BE_LPSROP_IMEM4_RSU_EN BIT(24)
+#define B_BE_LPSROP_IMEM3_RSU_EN BIT(23)
+#define B_BE_LPSROP_IMEM2_RSU_EN BIT(22)
+#define B_BE_LPSROP_IMEM1_RSU_EN BIT(21)
+#define B_BE_LPSROP_IMEM0_RSU_EN BIT(20)
+#define B_BE_LPSROP_BB1_W_BB0 BIT(14)
+#define B_BE_LPSROP_CMAC1 BIT(13)
+#define B_BE_LPSROP_CMAC0 BIT(12)
+#define B_BE_LPSROP_XTALM BIT(11)
+#define B_BE_LPSROP_PLLM BIT(10)
+#define B_BE_LPSROP_HIOE BIT(9)
+#define B_BE_LPSROP_CPU BIT(8)
+#define B_BE_LPSROP_LOWPWRPLL BIT(7)
+#define B_BE_LPSROP_DSWRSD_SEL_MASK GENMASK(5, 4)
+
 #define R_BE_EFUSE_CTRL_2_V1 0x00A4
 #define B_BE_EF_ENT BIT(31)
 #define B_BE_EF_TCOLUMN_EN BIT(29)
@@ -4085,6 +4190,59 @@
 #define R_BE_UDM2 0x01F8
 #define B_BE_UDM2_EPC_RA_MASK GENMASK(31, 0)
 
+#define R_BE_AFE_ON_CTRL0 0x0240
+#define B_BE_REG_LPF_R3_3_0_MASK GENMASK(31, 29)
+#define B_BE_REG_LPF_R2_MASK GENMASK(28, 24)
+#define B_BE_REG_LPF_C3_MASK GENMASK(23, 21)
+#define B_BE_REG_LPF_C2_MASK GENMASK(20, 18)
+#define B_BE_REG_LPF_C1_MASK GENMASK(17, 15)
+#define B_BE_REG_CP_ICPX2 BIT(14)
+#define B_BE_REG_CP_ICP_SEL_FAST_MASK GENMASK(13, 10)
+#define B_BE_REG_CP_ICP_SEL_MASK GENMASK(9, 6)
+#define B_BE_REG_IB_PI_MASK GENMASK(5, 4)
+#define B_BE_REG_CK_DEBUG_BT BIT(3)
+#define B_BE_EN_PC_LDO BIT(2)
+#define B_BE_LDO_VSEL_MASK GENMASK(1, 0)
+
+#define R_BE_AFE_ON_CTRL1 0x0244
+#define B_BE_REG_CK_MON_SEL_MASK GENMASK(31, 29)
+#define B_BE_REG_CK_MON_CK960M_EN BIT(28)
+#define B_BE_REG_XTAL_FREQ_SEL BIT(27)
+#define B_BE_REG_XTAL_EDGE_SEL BIT(26)
+#define B_BE_REG_VCO_KVCO BIT(25)
+#define B_BE_REG_SDM_EDGE_SEL BIT(24)
+#define B_BE_REG_SDM_CK_SEL BIT(23)
+#define B_BE_REG_SDM_CK_GATED BIT(22)
+#define B_BE_REG_PFD_RESET_GATED BIT(21)
+#define B_BE_REG_LPF_R3_FAST_MASK GENMASK(20, 16)
+#define B_BE_REG_LPF_R2_FAST_MASK GENMASK(15, 11)
+#define B_BE_REG_LPF_C3_FAST_MASK GENMASK(10, 8)
+#define B_BE_REG_LPF_C2_FAST_MASK GENMASK(7, 5)
+#define B_BE_REG_LPF_C1_FAST_MASK GENMASK(4, 2)
+#define B_BE_REG_LPF_R3_4_MASK GENMASK(1, 0)
+
+#define R_BE_AFE_ON_CTRL3 0x024C
+#define B_BE_LDO_VSEL_DA_1_MASK GENMASK(31, 30)
+#define B_BE_LDO_VSEL_DA_0_MASK GENMASK(29, 28)
+#define B_BE_LDO_VSEL_D2S_1_MASK GENMASK(27, 26)
+#define B_BE_LDO_VSEL_D2S_0_MASK GENMASK(25, 24)
+#define B_BE_LDO_VSEL_BUF_MASK GENMASK(23, 22)
+#define B_BE_REG_R2_L_MASK GENMASK(21, 19)
+#define B_BE_REG_R1_L_MASK GENMASK(18, 16)
+#define B_BE_REG_CK_DEBUG_BT_MON BIT(15)
+#define B_BE_REG_BT_CLK_BUF_POWER BIT(14)
+#define B_BE_REG_BG_OUT_BTADC_V1 BIT(13)
+#define B_BE_REG_SEL_V18 BIT(11)
+#define B_BE_REG_FRAC_EN BIT(10)
+#define B_BE_REG_CK1920M_EN BIT(9)
+#define B_BE_REG_CK1280M_EN BIT(8)
+#define B_BE_REG_12LDO_SEL_MASK GENMASK(7, 6)
+#define B_BE_REG_09LDO_SEL_MASK GENMASK(5, 4)
+#define B_BE_REG_VC_TH BIT(3)
+#define B_BE_REG_VC_TL BIT(2)
+#define B_BE_REG_CK40M_EN BIT(1)
+#define B_BE_REG_CK640M_EN BIT(0)
+
 #define R_BE_WLAN_XTAL_SI_CTRL 0x0270
 #define B_BE_WL_XTAL_SI_CMD_POLL BIT(31)
 #define B_BE_WL_XTAL_SI_CHIPID_MASK GENMASK(30, 28)
@@ -5537,6 +5695,16 @@
 #define R_BE_WP_PAGE_INFO1 0xB7AC
 #define B_BE_WP_AVAL_PG_MASK GENMASK(28, 16)
 
+#define R_BE_CMAC_SHARE_FUNC_EN 0x0E000
+#define B_BE_CMAC_SHARE_CRPRT BIT(31)
+#define B_BE_CMAC_SHARE_EN BIT(30)
+#define B_BE_FORCE_BTCOEX_REG_GCKEN BIT(24)
+#define B_BE_FORCE_CMAC_SHARE_COMMON_REG_GCKEN BIT(16)
+#define B_BE_FORCE_CMAC_SHARE_REG_GCKEN BIT(15)
+#define B_BE_RESPBA_EN BIT(2)
+#define B_BE_ADDRSRCH_EN BIT(1)
+#define B_BE_BTCOEX_EN BIT(0)
+
 #define R_BE_CMAC_FUNC_EN 0x10000
 #define R_BE_CMAC_FUNC_EN_C1 0x14000
 #define B_BE_CMAC_CRPRT BIT(31)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 398f8e48b7f3..92677d7ce249 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -130,6 +130,237 @@ static const struct rtw89_efuse_block_cfg rtw8922a_efuse_blocks[] = {
 	[RTW89_EFUSE_BLOCK_ADIE]		= {.offset = 0x70000, .size = 0x10},
 };
 
+static int rtw8922a_pwr_on_func(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	u32 val32;
+	int ret;
+
+	rtw89_write32_clr(rtwdev, R_BE_SYS_PW_CTRL, B_BE_AFSM_WLSUS_EN |
+						    B_BE_AFSM_PCIE_SUS_EN);
+	rtw89_write32_set(rtwdev, R_BE_SYS_PW_CTRL, B_BE_DIS_WLBT_PDNSUSEN_SOPC);
+	rtw89_write32_set(rtwdev, R_BE_WLLPS_CTRL, B_BE_DIS_WLBT_LPSEN_LOPC);
+	rtw89_write32_clr(rtwdev, R_BE_SYS_PW_CTRL, B_BE_APDM_HPDN);
+	rtw89_write32_clr(rtwdev, R_BE_SYS_PW_CTRL, B_BE_APFM_SWLPS);
+
+	ret = read_poll_timeout(rtw89_read32, val32, val32 & B_BE_RDY_SYSPWR,
+				1000, 3000000, false, rtwdev, R_BE_SYS_PW_CTRL);
+	if (ret)
+		return ret;
+
+	rtw89_write32_set(rtwdev, R_BE_SYS_PW_CTRL, B_BE_EN_WLON);
+	rtw89_write32_set(rtwdev, R_BE_WLRESUME_CTRL, B_BE_LPSROP_CMAC0 |
+						      B_BE_LPSROP_CMAC1);
+	rtw89_write32_set(rtwdev, R_BE_SYS_PW_CTRL, B_BE_APFN_ONMAC);
+
+	ret = read_poll_timeout(rtw89_read32, val32, !(val32 & B_BE_APFN_ONMAC),
+				1000, 3000000, false, rtwdev, R_BE_SYS_PW_CTRL);
+	if (ret)
+		return ret;
+
+	rtw89_write32_clr(rtwdev, R_BE_AFE_ON_CTRL1, B_BE_REG_CK_MON_CK960M_EN);
+	rtw89_write8_set(rtwdev, R_BE_ANAPAR_POW_MAC, B_BE_POW_PC_LDO_PORT0 |
+						      B_BE_POW_PC_LDO_PORT1);
+	rtw89_write32_clr(rtwdev, R_BE_FEN_RST_ENABLE, B_BE_R_SYM_ISO_ADDA_P02PP |
+						       B_BE_R_SYM_ISO_ADDA_P12PP);
+	rtw89_write8_set(rtwdev, R_BE_PLATFORM_ENABLE, B_BE_PLATFORM_EN);
+	rtw89_write32_set(rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HAXIDMA_IO_EN);
+
+	ret = read_poll_timeout(rtw89_read32, val32, val32 & B_BE_HAXIDMA_IO_ST,
+				1000, 3000000, false, rtwdev, R_BE_HCI_OPT_CTRL);
+	if (ret)
+		return ret;
+
+	ret = read_poll_timeout(rtw89_read32, val32, !(val32 & B_BE_HAXIDMA_BACKUP_RESTORE_ST),
+				1000, 3000000, false, rtwdev, R_BE_HCI_OPT_CTRL);
+	if (ret)
+		return ret;
+
+	rtw89_write32_set(rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HCI_WLAN_IO_EN);
+
+	ret = read_poll_timeout(rtw89_read32, val32, val32 & B_BE_HCI_WLAN_IO_ST,
+				1000, 3000000, false, rtwdev, R_BE_HCI_OPT_CTRL);
+	if (ret)
+		return ret;
+
+	rtw89_write32_clr(rtwdev, R_BE_SYS_SDIO_CTRL, B_BE_PCIE_FORCE_IBX_EN);
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_PLL, 0x02, 0x02);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_PLL, 0x01, 0x01);
+	if (ret)
+		return ret;
+
+	rtw89_write32_set(rtwdev, R_BE_SYS_ADIE_PAD_PWR_CTRL, B_BE_SYM_PADPDN_WL_RFC1_1P3);
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0x40, 0x40);
+	if (ret)
+		return ret;
+
+	rtw89_write32_set(rtwdev, R_BE_SYS_ADIE_PAD_PWR_CTRL, B_BE_SYM_PADPDN_WL_RFC0_1P3);
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0x20, 0x20);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0x04, 0x04);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0x08, 0x08);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, 0x10);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S0, 0xEB, 0xFF);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S1, 0xEB, 0xFF);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0x01, 0x01);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0x02, 0x02);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, 0x80);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_XREF_RF1, 0, 0x40);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_XREF_RF2, 0, 0x40);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_PLL_1, 0x40, 0x60);
+	if (ret)
+		return ret;
+
+	if (hal->cv != CHIP_CAV) {
+		rtw89_write32_set(rtwdev, R_BE_PMC_DBG_CTRL2, B_BE_SYSON_DIS_PMCR_BE_WRMSK);
+		rtw89_write32_set(rtwdev, R_BE_SYS_ISO_CTRL, B_BE_ISO_EB2CORE);
+		rtw89_write32_clr(rtwdev, R_BE_SYS_ISO_CTRL, B_BE_PWC_EV2EF_B);
+
+		mdelay(1);
+
+		rtw89_write32_clr(rtwdev, R_BE_SYS_ISO_CTRL, B_BE_PWC_EV2EF_S);
+		rtw89_write32_clr(rtwdev, R_BE_PMC_DBG_CTRL2, B_BE_SYSON_DIS_PMCR_BE_WRMSK);
+	}
+
+	rtw89_write32_set(rtwdev, R_BE_DMAC_FUNC_EN,
+			  B_BE_MAC_FUNC_EN | B_BE_DMAC_FUNC_EN | B_BE_MPDU_PROC_EN |
+			  B_BE_WD_RLS_EN | B_BE_DLE_WDE_EN | B_BE_TXPKT_CTRL_EN |
+			  B_BE_STA_SCH_EN | B_BE_DLE_PLE_EN | B_BE_PKT_BUF_EN |
+			  B_BE_DMAC_TBL_EN | B_BE_PKT_IN_EN | B_BE_DLE_CPUIO_EN |
+			  B_BE_DISPATCHER_EN | B_BE_BBRPT_EN | B_BE_MAC_SEC_EN |
+			  B_BE_H_AXIDMA_EN | B_BE_DMAC_MLO_EN | B_BE_PLRLS_EN |
+			  B_BE_P_AXIDMA_EN | B_BE_DLE_DATACPUIO_EN | B_BE_LTR_CTL_EN);
+
+	rtw89_write32_set(rtwdev, R_BE_CMAC_SHARE_FUNC_EN,
+			  B_BE_CMAC_SHARE_EN | B_BE_RESPBA_EN | B_BE_ADDRSRCH_EN |
+			  B_BE_BTCOEX_EN);
+	rtw89_write32_set(rtwdev, R_BE_CMAC_FUNC_EN,
+			  B_BE_CMAC_EN | B_BE_CMAC_TXEN |  B_BE_CMAC_RXEN |
+			  B_BE_SIGB_EN | B_BE_PHYINTF_EN | B_BE_CMAC_DMA_EN |
+			  B_BE_PTCLTOP_EN | B_BE_SCHEDULER_EN | B_BE_TMAC_EN |
+			  B_BE_RMAC_EN | B_BE_TXTIME_EN | B_BE_RESP_PKTCTL_EN);
+
+	rtw89_write32_set(rtwdev, R_BE_FEN_RST_ENABLE, B_BE_FEN_BB_IP_RSTN |
+						       B_BE_FEN_BBPLAT_RSTB);
+
+	return 0;
+}
+
+static int rtw8922a_pwr_off_func(struct rtw89_dev *rtwdev)
+{
+	u32 val32;
+	int ret;
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0x10, 0x10);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, 0x08);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, 0x04);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S0, 0xC6, 0xFF);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S1, 0xC6, 0xFF);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0x80, 0x80);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, 0x02);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, 0x01);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_PLL, 0x02, 0xFF);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_PLL, 0x00, 0xFF);
+	if (ret)
+		return ret;
+
+	rtw89_write32_set(rtwdev, R_BE_FEN_RST_ENABLE, B_BE_R_SYM_ISO_ADDA_P02PP |
+						       B_BE_R_SYM_ISO_ADDA_P12PP);
+	rtw89_write8_clr(rtwdev, R_BE_ANAPAR_POW_MAC, B_BE_POW_PC_LDO_PORT0 |
+						      B_BE_POW_PC_LDO_PORT1);
+	rtw89_write32_set(rtwdev, R_BE_SYS_PW_CTRL, B_BE_EN_WLON);
+	rtw89_write8_clr(rtwdev, R_BE_FEN_RST_ENABLE, B_BE_FEN_BB_IP_RSTN |
+						      B_BE_FEN_BBPLAT_RSTB);
+	rtw89_write32_clr(rtwdev, R_BE_SYS_ADIE_PAD_PWR_CTRL, B_BE_SYM_PADPDN_WL_RFC0_1P3);
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, 0x20);
+	if (ret)
+		return ret;
+
+	rtw89_write32_clr(rtwdev, R_BE_SYS_ADIE_PAD_PWR_CTRL, B_BE_SYM_PADPDN_WL_RFC1_1P3);
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, 0x40);
+	if (ret)
+		return ret;
+
+	rtw89_write32_clr(rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HAXIDMA_IO_EN);
+
+	ret = read_poll_timeout(rtw89_read32, val32, !(val32 & B_BE_HAXIDMA_IO_ST),
+				1000, 3000000, false, rtwdev, R_BE_HCI_OPT_CTRL);
+	if (ret)
+		return ret;
+
+	ret = read_poll_timeout(rtw89_read32, val32, !(val32 & B_BE_HAXIDMA_BACKUP_RESTORE_ST),
+				1000, 3000000, false, rtwdev, R_BE_HCI_OPT_CTRL);
+	if (ret)
+		return ret;
+
+	rtw89_write32_clr(rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HCI_WLAN_IO_EN);
+
+	ret = read_poll_timeout(rtw89_read32, val32, !(val32 & B_BE_HCI_WLAN_IO_ST),
+				1000, 3000000, false, rtwdev, R_BE_HCI_OPT_CTRL);
+	if (ret)
+		return ret;
+
+	rtw89_write32_set(rtwdev, R_BE_SYS_PW_CTRL, B_BE_APFM_OFFMAC);
+
+	ret = read_poll_timeout(rtw89_read32, val32, !(val32 & B_BE_APFM_OFFMAC),
+				1000, 3000000, false, rtwdev, R_BE_SYS_PW_CTRL);
+	if (ret)
+		return ret;
+
+	rtw89_write32(rtwdev, R_BE_WLLPS_CTRL, 0x0000A1B2);
+	rtw89_write32_set(rtwdev, R_BE_SYS_PW_CTRL, B_BE_XTAL_OFF_A_DIE);
+	rtw89_write32_set(rtwdev, R_BE_SYS_PW_CTRL, B_BE_APFM_SWLPS);
+	rtw89_write32(rtwdev, R_BE_UDM1, 0);
+
+	return 0;
+}
+
 static void rtw8922a_efuse_parsing_tssi(struct rtw89_dev *rtwdev,
 					struct rtw8922a_efuse *map)
 {
@@ -377,6 +608,8 @@ static const struct wiphy_wowlan_support rtw_wowlan_stub_8922a = {
 static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.read_efuse		= rtw8922a_read_efuse,
 	.read_phycap		= rtw8922a_read_phycap,
+	.pwr_on_func		= rtw8922a_pwr_on_func,
+	.pwr_off_func		= rtw8922a_pwr_off_func,
 };
 
 const struct rtw89_chip_info rtw8922a_chip_info = {
-- 
2.25.1


