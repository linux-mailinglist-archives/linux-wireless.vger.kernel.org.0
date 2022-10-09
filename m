Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1458F5F8B60
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Oct 2022 14:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiJIMyv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Oct 2022 08:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiJIMyp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Oct 2022 08:54:45 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43252C20
        for <linux-wireless@vger.kernel.org>; Sun,  9 Oct 2022 05:54:37 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 299CrtiM7029512, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 299CrtiM7029512
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sun, 9 Oct 2022 20:53:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Sun, 9 Oct 2022 20:54:24 +0800
Received: from localhost (172.16.16.215) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sun, 9 Oct 2022
 20:54:23 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/9] wifi: rtw89: 8852b: add power on/off functions
Date:   Sun, 9 Oct 2022 20:53:56 +0800
Message-ID: <20221009125403.19662-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221009125403.19662-1-pkshih@realtek.com>
References: <20221009125403.19662-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.215]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/09/2022 12:37:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzkgpFekyCAwOTowNzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

We need power on function to enable hardware circuits of MAC/BB/RF, and
then download firmware and load PHY parameters. After more settings, it
starts to work. When it enters idle, use power off function to have the
lowest power consumption.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.h      |   1 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  18 ++
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 192 ++++++++++++++++++
 3 files changed, 211 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index a9867ac351da7..a6cbafb75a2b8 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1014,6 +1014,7 @@ enum rtw89_mac_xtal_si_offset {
 #define XTAL_SI_PON_EI		BIT(1)
 #define XTAL_SI_PON_WEI		BIT(0)
 	XTAL_SI_SRAM_CTRL = 0xA1,
+#define XTAL_SI_SRAM_DIS	BIT(1)
 #define FULL_BIT_MASK		GENMASK(7, 0)
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 1539973296cd1..376ce7135b388 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -34,6 +34,9 @@
 #define R_AX_SYS_CLK_CTRL 0x0008
 #define B_AX_CPU_CLK_EN BIT(14)
 
+#define R_AX_SYS_SWR_CTRL1 0x0010
+#define B_AX_SYM_CTRL_SPS_PWMFREQ BIT(10)
+
 #define R_AX_SYS_ADIE_PAD_PWR_CTRL 0x0018
 #define B_AX_SYM_PADPDN_WL_PTA_1P3 BIT(6)
 #define B_AX_SYM_PADPDN_WL_RFC_1P3 BIT(5)
@@ -42,6 +45,9 @@
 #define B_AX_R_DIS_PRST BIT(6)
 #define B_AX_WLOCK_1C_BIT6 BIT(5)
 
+#define R_AX_AFE_LDO_CTRL 0x0020
+#define B_AX_AON_OFF_PC_EN BIT(23)
+
 #define R_AX_EFUSE_CTRL_1 0x0038
 #define B_AX_EF_PGPD_MASK GENMASK(30, 28)
 #define B_AX_EF_RDT BIT(27)
@@ -118,6 +124,9 @@
 #define B_AX_R_AX_BG_LPF BIT(2)
 #define B_AX_R_AX_BG GENMASK(1, 0)
 
+#define R_AX_HCI_LDO_CTRL 0x007A
+#define B_AX_R_AX_VADJ_MASK GENMASK(3, 0)
+
 #define R_AX_PLATFORM_ENABLE 0x0088
 #define B_AX_AXIDMA_EN BIT(3)
 #define B_AX_WCPU_EN BIT(1)
@@ -125,6 +134,7 @@
 
 #define R_AX_WLLPS_CTRL 0x0090
 #define B_AX_DIS_WLBT_LPSEN_LOPC BIT(1)
+#define SW_LPS_OPTION 0x0001A0B2
 
 #define R_AX_SCOREBOARD  0x00AC
 #define B_AX_TOGGLE BIT(31)
@@ -229,6 +239,9 @@
 
 #define R_AX_GPIO0_7_FUNC_SEL 0x02D0
 
+#define R_AX_EECS_EESK_FUNC_SEL 0x02D8
+#define B_AX_PINMUX_EESK_FUNC_SEL_MASK GENMASK(7, 4)
+
 #define R_AX_LED1_FUNC_SEL 0x02DC
 #define B_AX_PINMUX_EESK_FUNC_SEL_V1_MASK GENMASK(27, 24)
 #define PINMUX_EESK_FUNC_SEL_BT_LOG 0x1
@@ -253,6 +266,10 @@
 #define B_AX_USB_HCISYS_PWR_STE_MASK GENMASK(3, 2)
 #define B_AX_PCIE_HCISYS_PWR_STE_MASK GENMASK(1, 0)
 
+#define R_AX_SPS_DIG_OFF_CTRL0 0x0400
+#define B_AX_C3_L1_MASK GENMASK(5, 4)
+#define B_AX_C1_L1_MASK GENMASK(1, 0)
+
 #define R_AX_AFE_OFF_CTRL1 0x0444
 #define B_AX_S1_LDO_VSEL_F_MASK GENMASK(25, 24)
 #define B_AX_S1_LDO2PWRCUT_F BIT(23)
@@ -449,6 +466,7 @@
 #define B_AX_DISPATCHER_EN BIT(18)
 #define B_AX_BBRPT_EN BIT(17)
 #define B_AX_MAC_SEC_EN BIT(16)
+#define B_AX_DMACREG_GCKEN BIT(15)
 #define B_AX_MAC_UN_EN BIT(15)
 #define B_AX_H_AXIDMA_EN BIT(14)
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index af04a0284b560..f54a4ea3c6b53 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -56,6 +56,194 @@ static const struct rtw89_dle_mem rtw8852b_dle_mem_pcie[] = {
 			       NULL},
 };
 
+static int rtw8852b_pwr_on_func(struct rtw89_dev *rtwdev)
+{
+	u32 val32;
+	u32 ret;
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
+	rtw89_write32_set(rtwdev, R_AX_AFE_LDO_CTRL, B_AX_AON_OFF_PC_EN);
+	ret = read_poll_timeout(rtw89_read32, val32, val32 & B_AX_AON_OFF_PC_EN,
+				1000, 20000, false, rtwdev, R_AX_AFE_LDO_CTRL);
+	if (ret)
+		return ret;
+
+	rtw89_write32_mask(rtwdev, R_AX_SPS_DIG_OFF_CTRL0, B_AX_C1_L1_MASK, 0x1);
+	rtw89_write32_mask(rtwdev, R_AX_SPS_DIG_OFF_CTRL0, B_AX_C3_L1_MASK, 0x3);
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
+	rtw89_write32_set(rtwdev, R_AX_SYS_ADIE_PAD_PWR_CTRL, B_AX_SYM_PADPDN_WL_PTA_1P3);
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL,
+				      XTAL_SI_GND_SHDN_WL, XTAL_SI_GND_SHDN_WL);
+	if (ret)
+		return ret;
+
+	rtw89_write32_set(rtwdev, R_AX_SYS_ADIE_PAD_PWR_CTRL, B_AX_SYM_PADPDN_WL_RFC_1P3);
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL,
+				      XTAL_SI_SHDN_WL, XTAL_SI_SHDN_WL);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, XTAL_SI_OFF_WEI,
+				      XTAL_SI_OFF_WEI);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, XTAL_SI_OFF_EI,
+				      XTAL_SI_OFF_EI);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, XTAL_SI_RFC2RF);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, XTAL_SI_PON_WEI,
+				      XTAL_SI_PON_WEI);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, XTAL_SI_PON_EI,
+				      XTAL_SI_PON_EI);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, XTAL_SI_SRAM2RFC);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_SRAM_CTRL, 0, XTAL_SI_SRAM_DIS);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_XTAL_XMD_2, 0, XTAL_SI_LDO_LPS);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_XTAL_XMD_4, 0, XTAL_SI_LPS_CAP);
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
+
+	if (!rtwdev->efuse.valid || rtwdev->efuse.power_k_valid)
+		goto func_en;
+
+	rtw89_write32_mask(rtwdev, R_AX_SPS_DIG_ON_CTRL0, B_AX_VOL_L1_MASK, 0x9);
+	rtw89_write32_mask(rtwdev, R_AX_SPS_DIG_ON_CTRL0, B_AX_VREFPFM_L_MASK, 0xA);
+
+	if (rtwdev->hal.cv == CHIP_CBV) {
+		rtw89_write32_set(rtwdev, R_AX_PMC_DBG_CTRL2, B_AX_SYSON_DIS_PMCR_AX_WRMSK);
+		rtw89_write16_mask(rtwdev, R_AX_HCI_LDO_CTRL, B_AX_R_AX_VADJ_MASK, 0xA);
+		rtw89_write32_clr(rtwdev, R_AX_PMC_DBG_CTRL2, B_AX_SYSON_DIS_PMCR_AX_WRMSK);
+	}
+
+func_en:
+	rtw89_write32_set(rtwdev, R_AX_DMAC_FUNC_EN,
+			  B_AX_MAC_FUNC_EN | B_AX_DMAC_FUNC_EN | B_AX_MPDU_PROC_EN |
+			  B_AX_WD_RLS_EN | B_AX_DLE_WDE_EN | B_AX_TXPKT_CTRL_EN |
+			  B_AX_STA_SCH_EN | B_AX_DLE_PLE_EN | B_AX_PKT_BUF_EN |
+			  B_AX_DMAC_TBL_EN | B_AX_PKT_IN_EN | B_AX_DLE_CPUIO_EN |
+			  B_AX_DISPATCHER_EN | B_AX_BBRPT_EN | B_AX_MAC_SEC_EN |
+			  B_AX_DMACREG_GCKEN);
+	rtw89_write32_set(rtwdev, R_AX_CMAC_FUNC_EN,
+			  B_AX_CMAC_EN | B_AX_CMAC_TXEN | B_AX_CMAC_RXEN |
+			  B_AX_FORCE_CMACREG_GCKEN | B_AX_PHYINTF_EN | B_AX_CMAC_DMA_EN |
+			  B_AX_PTCLTOP_EN | B_AX_SCHEDULER_EN | B_AX_TMAC_EN |
+			  B_AX_RMAC_EN);
+
+	rtw89_write32_mask(rtwdev, R_AX_EECS_EESK_FUNC_SEL, B_AX_PINMUX_EESK_FUNC_SEL_MASK,
+			   PINMUX_EESK_FUNC_SEL_BT_LOG);
+
+	return 0;
+}
+
+static int rtw8852b_pwr_off_func(struct rtw89_dev *rtwdev)
+{
+	u32 val32;
+	u32 ret;
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, XTAL_SI_RFC2RF,
+				      XTAL_SI_RFC2RF);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, XTAL_SI_OFF_EI);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, XTAL_SI_OFF_WEI);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S0, 0, XTAL_SI_RF00);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S1, 0, XTAL_SI_RF10);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, XTAL_SI_SRAM2RFC,
+				      XTAL_SI_SRAM2RFC);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, XTAL_SI_PON_EI);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, XTAL_SI_PON_WEI);
+	if (ret)
+		return ret;
+
+	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_EN_WLON);
+	rtw89_write8_clr(rtwdev, R_AX_SYS_FUNC_EN, B_AX_FEN_BB_GLB_RSTN | B_AX_FEN_BBRSTB);
+	rtw89_write32_clr(rtwdev, R_AX_SYS_ADIE_PAD_PWR_CTRL, B_AX_SYM_PADPDN_WL_RFC_1P3);
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, XTAL_SI_SHDN_WL);
+	if (ret)
+		return ret;
+
+	rtw89_write32_clr(rtwdev, R_AX_SYS_ADIE_PAD_PWR_CTRL, B_AX_SYM_PADPDN_WL_PTA_1P3);
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, XTAL_SI_GND_SHDN_WL);
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
+	rtw89_write32(rtwdev, R_AX_WLLPS_CTRL, SW_LPS_OPTION);
+	rtw89_write32_set(rtwdev, R_AX_SYS_SWR_CTRL1, B_AX_SYM_CTRL_SPS_PWMFREQ);
+	rtw89_write32_mask(rtwdev, R_AX_SPS_DIG_ON_CTRL0, B_AX_REG_ZCDC_H_MASK, 0x3);
+	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_SWLPS);
+
+	return 0;
+}
+
 static void rtw8852be_efuse_parsing(struct rtw89_efuse *efuse,
 				    struct rtw8852b_efuse *map)
 {
@@ -1233,6 +1421,8 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.set_txpwr		= rtw8852b_set_txpwr,
 	.set_txpwr_ctrl		= rtw8852b_set_txpwr_ctrl,
 	.init_txpwr_unit	= rtw8852b_init_txpwr_unit,
+	.pwr_on_func		= rtw8852b_pwr_on_func,
+	.pwr_off_func		= rtw8852b_pwr_off_func,
 };
 
 const struct rtw89_chip_info rtw8852b_chip_info = {
@@ -1242,6 +1432,8 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.dle_scc_rsvd_size	= 98304,
 	.hfc_param_ini		= rtw8852b_hfc_param_ini_pcie,
 	.dle_mem		= rtw8852b_dle_mem_pcie,
+	.pwr_on_seq		= NULL,
+	.pwr_off_seq		= NULL,
 	.sec_ctrl_efuse_size	= 4,
 	.physical_efuse_size	= 1216,
 	.logical_efuse_size	= 2048,
-- 
2.25.1

