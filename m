Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9D94CCE13
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Mar 2022 07:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238569AbiCDGsZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Mar 2022 01:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238564AbiCDGsT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Mar 2022 01:48:19 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FECB18E3FF
        for <linux-wireless@vger.kernel.org>; Thu,  3 Mar 2022 22:47:17 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2246lB1U1011654, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2246lB1U1011654
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 4 Mar 2022 14:47:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 14:47:11 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 4 Mar
 2022 14:47:11 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 06/13] rtw89: add power_{on/off}_func
Date:   Fri, 4 Mar 2022 14:46:12 +0800
Message-ID: <20220304064619.23662-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220304064619.23662-1-pkshih@realtek.com>
References: <20220304064619.23662-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/04/2022 06:29:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvNCCkV6TIIDA0OjM0OjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

New chipset uses individual power_{on/off} functions to replace old power
sequences, because it is hard to represent new complicated flow in a
sequence table.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |   2 +
 drivers/net/wireless/realtek/rtw89/mac.c      |  34 +++-
 drivers/net/wireless/realtek/rtw89/mac.h      |  14 ++
 drivers/net/wireless/realtek/rtw89/reg.h      |  57 ++++++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 175 ++++++++++++++++++
 6 files changed, 281 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 634fcc37eeaa9..1338c08d7bd39 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2046,6 +2046,8 @@ struct rtw89_chip_ops {
 	void (*bb_ctrl_btc_preagc)(struct rtw89_dev *rtwdev, bool bt_en);
 	void (*set_txpwr_ul_tb_offset)(struct rtw89_dev *rtwdev,
 				       s16 pw_ofst, enum rtw89_mac_idx mac_idx);
+	int (*pwr_on_func)(struct rtw89_dev *rtwdev);
+	int (*pwr_off_func)(struct rtw89_dev *rtwdev);
 
 	void (*btc_set_rfe)(struct rtw89_dev *rtwdev);
 	void (*btc_init_cfg)(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 9a91b408cd28e..d202ee761e902 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1022,14 +1022,18 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 #define PWR_ACT 1
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_pwr_cfg * const *cfg_seq;
+	int (*cfg_func)(struct rtw89_dev *rtwdev);
 	struct rtw89_hal *hal = &rtwdev->hal;
 	int ret;
 	u8 val;
 
-	if (on)
+	if (on) {
 		cfg_seq = chip->pwr_on_seq;
-	else
+		cfg_func = chip->ops->pwr_on_func;
+	} else {
 		cfg_seq = chip->pwr_off_seq;
+		cfg_func = chip->ops->pwr_off_func;
+	}
 
 	if (test_bit(RTW89_FLAG_FW_RDY, rtwdev->flags))
 		__rtw89_leave_ps_mode(rtwdev);
@@ -1040,7 +1044,7 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 		return -EBUSY;
 	}
 
-	ret = rtw89_mac_pwr_seq(rtwdev, cfg_seq);
+	ret = cfg_func ? cfg_func(rtwdev) : rtw89_mac_pwr_seq(rtwdev, cfg_seq);
 	if (ret)
 		return ret;
 
@@ -3968,3 +3972,27 @@ int rtw89_mac_set_hw_muedca_ctrl(struct rtw89_dev *rtwdev,
 
 	return 0;
 }
+
+int rtw89_mac_write_xtal_si(struct rtw89_dev *rtwdev, u8 offset, u8 val, u8 mask)
+{
+	u32 val32;
+	int ret;
+
+	val32 = FIELD_PREP(B_AX_WL_XTAL_SI_ADDR_MASK, offset) |
+		FIELD_PREP(B_AX_WL_XTAL_SI_DATA_MASK, val) |
+		FIELD_PREP(B_AX_WL_XTAL_SI_BITMASK_MASK, mask) |
+		FIELD_PREP(B_AX_WL_XTAL_SI_MODE_MASK, XTAL_SI_NORMAL_WRITE) |
+		FIELD_PREP(B_AX_WL_XTAL_SI_CMD_POLL, 1);
+	rtw89_write32(rtwdev, R_AX_WLAN_XTAL_SI_CTRL, val32);
+
+	ret = read_poll_timeout(rtw89_read32, val32, !(val32 & B_AX_WL_XTAL_SI_CMD_POLL),
+				50, 50000, false, rtwdev, R_AX_WLAN_XTAL_SI_CTRL);
+	if (ret) {
+		rtw89_warn(rtwdev, "xtal si not ready(W): offset=%x val=%x mask=%x\n",
+			   offset, val, mask);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(rtw89_mac_write_xtal_si);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 5c7a9d784265a..93595d3e07b99 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -872,4 +872,18 @@ int rtw89_mac_set_tx_retry_limit(struct rtw89_dev *rtwdev,
 int rtw89_mac_get_tx_retry_limit(struct rtw89_dev *rtwdev,
 				 struct rtw89_sta *rtwsta, u8 *tx_retry);
 
+enum rtw89_mac_xtal_si_offset {
+	XTAL_SI_XTAL_SC_XI = 0x04,
+	XTAL_SI_XTAL_SC_XO = 0x05,
+	XTAL_SI_XTAL_XMD_2 = 0x24,
+	XTAL_SI_XTAL_XMD_4 = 0x26,
+	XTAL_SI_CV = 0x41,
+	XTAL_SI_WL_RFC_S0 = 0x80,
+	XTAL_SI_WL_RFC_S1 = 0x81,
+	XTAL_SI_ANAPAR_WL = 0x90,
+	XTAL_SI_SRAM_CTRL = 0xA1,
+};
+
+int rtw89_mac_write_xtal_si(struct rtw89_dev *rtwdev, u8 offset, u8 val, u8 mask);
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 62dca0888d88d..bb95e524d67be 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -8,16 +8,36 @@
 #define R_AX_SYS_WL_EFUSE_CTRL 0x000A
 #define B_AX_AUTOLOAD_SUS BIT(5)
 
+#define R_AX_SYS_ISO_CTRL 0x0000
+#define B_AX_PWC_EV2EF_MASK GENMASK(15, 14)
+#define B_AX_PWC_EV2EF_B15 BIT(15)
+#define B_AX_PWC_EV2EF_B14 BIT(14)
+#define B_AX_ISO_EB2CORE BIT(8)
+
 #define R_AX_SYS_FUNC_EN 0x0002
 #define B_AX_FEN_BB_GLB_RSTN BIT(1)
 #define B_AX_FEN_BBRSTB BIT(0)
 
 #define R_AX_SYS_PW_CTRL 0x0004
+#define B_AX_XTAL_OFF_A_DIE BIT(22)
+#define B_AX_DIS_WLBT_PDNSUSEN_SOPC BIT(18)
+#define B_AX_RDY_SYSPWR BIT(17)
+#define B_AX_EN_WLON BIT(16)
+#define B_AX_APDM_HPDN BIT(15)
 #define B_AX_PSUS_OFF_CAPC_EN BIT(14)
+#define B_AX_AFSM_PCIE_SUS_EN BIT(12)
+#define B_AX_AFSM_WLSUS_EN BIT(11)
+#define B_AX_APFM_SWLPS BIT(10)
+#define B_AX_APFM_OFFMAC BIT(9)
+#define B_AX_APFN_ONMAC BIT(8)
 
 #define R_AX_SYS_CLK_CTRL 0x0008
 #define B_AX_CPU_CLK_EN BIT(14)
 
+#define R_AX_SYS_ADIE_PAD_PWR_CTRL 0x0018
+#define B_AX_SYM_PADPDN_WL_PTA_1P3 BIT(6)
+#define B_AX_SYM_PADPDN_WL_RFC_1P3 BIT(5)
+
 #define R_AX_RSV_CTRL 0x001C
 #define B_AX_R_DIS_PRST BIT(6)
 #define B_AX_WLOCK_1C_BIT6 BIT(5)
@@ -72,11 +92,16 @@
 #define R_AX_SYS_SDIO_CTRL 0x0070
 #define B_AX_PCIE_DIS_L2_CTRL_LDO_HCI BIT(15)
 #define B_AX_PCIE_DIS_WLSUS_AFT_PDN BIT(14)
+#define B_AX_PCIE_CALIB_EN_V1 BIT(12)
 #define B_AX_PCIE_AUXCLK_GATE BIT(11)
 #define B_AX_LTE_MUX_CTRL_PATH BIT(26)
 
 #define R_AX_PLATFORM_ENABLE 0x0088
 #define B_AX_WCPU_EN BIT(1)
+#define B_AX_PLATFORM_EN BIT(0)
+
+#define R_AX_WLLPS_CTRL 0x0090
+#define B_AX_DIS_WLBT_LPSEN_LOPC BIT(1)
 
 #define R_AX_SCOREBOARD  0x00AC
 #define B_AX_TOGGLE BIT(31)
@@ -89,11 +114,20 @@
 #define R_AX_DBG_PORT_SEL 0x00C0
 #define B_AX_DEBUG_ST_MASK GENMASK(31, 0)
 
+#define R_AX_PMC_DBG_CTRL2 0x00CC
+#define B_AX_SYSON_DIS_PMCR_AX_WRMSK BIT(2)
+
 #define R_AX_SYS_CFG1 0x00F0
 #define B_AX_CHIP_VER_MASK GENMASK(15, 12)
 
 #define R_AX_SYS_STATUS1 0x00F4
 #define B_AX_SEL_0XC0_MASK GENMASK(17, 16)
+#define B_AX_PAD_HCI_SEL_V2_MASK GENMASK(5, 3)
+#define MAC_AX_HCI_SEL_SDIO_UART 0
+#define MAC_AX_HCI_SEL_MULTI_USB 1
+#define MAC_AX_HCI_SEL_PCIE_UART 2
+#define MAC_AX_HCI_SEL_PCIE_USB 3
+#define MAC_AX_HCI_SEL_MULTI_SDIO 4
 
 #define R_AX_HALT_H2C_CTRL 0x0160
 #define R_AX_HALT_H2C 0x0168
@@ -131,6 +165,21 @@
 #define R_AX_UDM2 0x01F8
 #define R_AX_UDM3 0x01FC
 
+#define R_AX_LDO_AON_CTRL0 0x0218
+#define B_AX_PD_REGU_L BIT(16)
+
+#define R_AX_WLAN_XTAL_SI_CTRL 0x0270
+#define B_AX_WL_XTAL_SI_CMD_POLL BIT(31)
+#define B_AX_BT_XTAL_SI_ERR_FLAG BIT(30)
+#define B_AX_WL_XTAL_GNT BIT(29)
+#define B_AX_BT_XTAL_GNT BIT(28)
+#define B_AX_WL_XTAL_SI_MODE_MASK GENMASK(25, 24)
+#define XTAL_SI_NORMAL_WRITE 0x00
+#define XTAL_SI_NORMAL_READ 0x01
+#define B_AX_WL_XTAL_SI_BITMASK_MASK GENMASK(23, 16)
+#define B_AX_WL_XTAL_SI_DATA_MASK GENMASK(15, 8)
+#define B_AX_WL_XTAL_SI_ADDR_MASK GENMASK(7, 0)
+
 #define R_AX_XTAL_ON_CTRL0 0x0280
 #define B_AX_XTAL_SC_LPS BIT(31)
 #define B_AX_XTAL_SC_XO_MASK GENMASK(23, 17)
@@ -139,6 +188,11 @@
 
 #define R_AX_GPIO0_7_FUNC_SEL 0x02D0
 
+#define R_AX_GPIO0_15_EECS_EESK_LED1_PULL_LOW_EN 0x02E4
+#define B_AX_LED1_PULL_LOW_EN BIT(18)
+#define B_AX_EESK_PULL_LOW_EN BIT(17)
+#define B_AX_EECS_PULL_LOW_EN BIT(16)
+
 #define R_AX_WLRF_CTRL 0x02F0
 #define B_AX_WLRF1_CTRL_7 BIT(15)
 #define B_AX_WLRF1_CTRL_1 BIT(9)
@@ -208,7 +262,10 @@
 #define B_AX_PKT_IN_EN BIT(20)
 #define B_AX_DLE_CPUIO_EN BIT(19)
 #define B_AX_DISPATCHER_EN BIT(18)
+#define B_AX_BBRPT_EN BIT(17)
 #define B_AX_MAC_SEC_EN BIT(16)
+#define B_AX_MAC_UN_EN BIT(15)
+#define B_AX_H_AXIDMA_EN BIT(14)
 
 #define R_AX_DMAC_CLK_EN 0x8404
 #define B_AX_WD_RLS_CLK_EN BIT(27)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index a222e11de6acf..1448214d6241b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -1987,6 +1987,8 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.query_ppdu		= rtw8852a_query_ppdu,
 	.bb_ctrl_btc_preagc	= rtw8852a_bb_ctrl_btc_preagc,
 	.set_txpwr_ul_tb_offset	= rtw8852a_set_txpwr_ul_tb_offset,
+	.pwr_on_func		= NULL,
+	.pwr_off_func		= NULL,
 
 	.btc_set_rfe		= rtw8852a_btc_set_rfe,
 	.btc_init_cfg		= rtw8852a_btc_init_cfg,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index cd0004b01ebc2..62eb7cb78fdce 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2,15 +2,190 @@
 /* Copyright(c) 2019-2022  Realtek Corporation
  */
 
+#include "mac.h"
+#include "reg.h"
 #include "rtw8852c.h"
 
+static int rtw8852c_pwr_on_func(struct rtw89_dev *rtwdev)
+{
+	u32 val32;
+	u32 ret;
+
+	val32 = rtw89_read32_mask(rtwdev, R_AX_SYS_STATUS1, B_AX_PAD_HCI_SEL_V2_MASK);
+	if (val32 == MAC_AX_HCI_SEL_PCIE_USB)
+		rtw89_write32_set(rtwdev, R_AX_LDO_AON_CTRL0, B_AX_PD_REGU_L);
+
+	rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_AFSM_WLSUS_EN |
+						    B_AX_AFSM_PCIE_SUS_EN);
+	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_DIS_WLBT_PDNSUSEN_SOPC);
+	rtw89_write32_set(rtwdev, R_AX_WLLPS_CTRL, B_AX_DIS_WLBT_LPSEN_LOPC);
+	rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APDM_HPDN);
+	rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_SWLPS);
+
+	ret = read_poll_timeout(rtw89_read32, val32, val32 & B_AX_RDY_SYSPWR,
+				1000, 20000, false, rtwdev, R_AX_SYS_PW_CTRL);
+	if (ret)
+		return ret;
+
+	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_EN_WLON);
+	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFN_ONMAC);
+
+	ret = read_poll_timeout(rtw89_read32, val32, !(val32 & B_AX_APFN_ONMAC),
+				1000, 20000, false, rtwdev, R_AX_SYS_PW_CTRL);
+	if (ret)
+		return ret;
+
+	rtw89_write8_set(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_PLATFORM_EN);
+	rtw89_write8_clr(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_PLATFORM_EN);
+	rtw89_write8_set(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_PLATFORM_EN);
+	rtw89_write8_clr(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_PLATFORM_EN);
+
+	rtw89_write8_set(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_PLATFORM_EN);
+	rtw89_write32_clr(rtwdev, R_AX_SYS_SDIO_CTRL, B_AX_PCIE_CALIB_EN_V1);
+
+	rtw89_write32_clr(rtwdev, R_AX_SYS_ISO_CTRL_EXTEND, B_AX_CMAC1_FEN);
+	rtw89_write32_set(rtwdev, R_AX_SYS_ISO_CTRL_EXTEND, B_AX_R_SYM_ISO_CMAC12PP);
+	rtw89_write32_clr(rtwdev, R_AX_AFE_CTRL1, B_AX_R_SYM_WLCMAC1_P4_PC_EN |
+						  B_AX_R_SYM_WLCMAC1_P3_PC_EN |
+						  B_AX_R_SYM_WLCMAC1_P2_PC_EN |
+						  B_AX_R_SYM_WLCMAC1_P1_PC_EN |
+						  B_AX_R_SYM_WLCMAC1_PC_EN);
+	rtw89_write32_set(rtwdev, R_AX_SYS_ADIE_PAD_PWR_CTRL, B_AX_SYM_PADPDN_WL_PTA_1P3);
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0x40, 0x40);
+	if (ret)
+		return ret;
+
+	rtw89_write32_set(rtwdev, R_AX_SYS_ADIE_PAD_PWR_CTRL, B_AX_SYM_PADPDN_WL_RFC_1P3);
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
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0x01, 0x01);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0x02, 0x02);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, 0x80);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_XTAL_XMD_2, 0, 0x70);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_XTAL_XMD_4, 0, 0x0F);
+	if (ret)
+		return ret;
+
+	rtw89_write32_set(rtwdev, R_AX_PMC_DBG_CTRL2, B_AX_SYSON_DIS_PMCR_AX_WRMSK);
+	rtw89_write32_set(rtwdev, R_AX_SYS_ISO_CTRL, B_AX_ISO_EB2CORE);
+	rtw89_write32_clr(rtwdev, R_AX_SYS_ISO_CTRL, B_AX_PWC_EV2EF_B15);
+
+	fsleep(1000);
+
+	rtw89_write32_clr(rtwdev, R_AX_SYS_ISO_CTRL, B_AX_PWC_EV2EF_B14);
+	rtw89_write32_clr(rtwdev, R_AX_PMC_DBG_CTRL2, B_AX_SYSON_DIS_PMCR_AX_WRMSK);
+	rtw89_write32_set(rtwdev, R_AX_GPIO0_15_EECS_EESK_LED1_PULL_LOW_EN,
+			  B_AX_EECS_PULL_LOW_EN | B_AX_EESK_PULL_LOW_EN |
+			  B_AX_LED1_PULL_LOW_EN);
+
+	rtw89_write32_set(rtwdev, R_AX_DMAC_FUNC_EN,
+			  B_AX_MAC_FUNC_EN | B_AX_DMAC_FUNC_EN | B_AX_MPDU_PROC_EN |
+			  B_AX_WD_RLS_EN | B_AX_DLE_WDE_EN | B_AX_TXPKT_CTRL_EN |
+			  B_AX_STA_SCH_EN | B_AX_DLE_PLE_EN | B_AX_PKT_BUF_EN |
+			  B_AX_DMAC_TBL_EN | B_AX_PKT_IN_EN | B_AX_DLE_CPUIO_EN |
+			  B_AX_DISPATCHER_EN | B_AX_BBRPT_EN | B_AX_MAC_SEC_EN |
+			  B_AX_MAC_UN_EN | B_AX_H_AXIDMA_EN);
+
+	rtw89_write32_set(rtwdev, R_AX_CMAC_FUNC_EN,
+			  B_AX_CMAC_EN | B_AX_CMAC_TXEN | B_AX_CMAC_RXEN |
+			  B_AX_FORCE_CMACREG_GCKEN | B_AX_PHYINTF_EN |
+			  B_AX_CMAC_DMA_EN | B_AX_PTCLTOP_EN | B_AX_SCHEDULER_EN |
+			  B_AX_TMAC_EN | B_AX_RMAC_EN);
+
+	return 0;
+}
+
+static int rtw8852c_pwr_off_func(struct rtw89_dev *rtwdev)
+{
+	u32 val32;
+	u32 ret;
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
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S0, 0, 0x01);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S1, 0, 0x01);
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
+
+	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_EN_WLON);
+	rtw89_write8_clr(rtwdev, R_AX_SYS_FUNC_EN, B_AX_FEN_BB_GLB_RSTN | B_AX_FEN_BBRSTB);
+	rtw89_write32_clr(rtwdev, R_AX_SYS_ISO_CTRL_EXTEND,
+			  B_AX_R_SYM_FEN_WLBBGLB_1 | B_AX_R_SYM_FEN_WLBBFUN_1);
+	rtw89_write32_clr(rtwdev, R_AX_SYS_ADIE_PAD_PWR_CTRL, B_AX_SYM_PADPDN_WL_RFC_1P3);
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, 0x20);
+	if (ret)
+		return ret;
+
+	rtw89_write32_clr(rtwdev, R_AX_SYS_ADIE_PAD_PWR_CTRL, B_AX_SYM_PADPDN_WL_PTA_1P3);
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, 0x40);
+	if (ret)
+		return ret;
+
+	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_OFFMAC);
+
+	ret = read_poll_timeout(rtw89_read32, val32, !(val32 & B_AX_APFM_OFFMAC),
+				1000, 20000, false, rtwdev, R_AX_SYS_PW_CTRL);
+	if (ret)
+		return ret;
+
+	rtw89_write32(rtwdev, R_AX_WLLPS_CTRL, 0x0001A0B0);
+	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_XTAL_OFF_A_DIE);
+	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_SWLPS);
+
+	return 0;
+}
+
 static const struct rtw89_chip_ops rtw8852c_chip_ops = {
+	.pwr_on_func		= rtw8852c_pwr_on_func,
+	.pwr_off_func		= rtw8852c_pwr_off_func,
 };
 
 const struct rtw89_chip_info rtw8852c_chip_info = {
 	.chip_id		= RTL8852C,
 	.ops			= &rtw8852c_chip_ops,
 	.fw_name		= "rtw89/rtw8852c_fw.bin",
+	.pwr_on_seq		= NULL,
+	.pwr_off_seq		= NULL,
 };
 EXPORT_SYMBOL(rtw8852c_chip_info);
 
-- 
2.25.1

