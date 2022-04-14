Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BEC5005E5
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Apr 2022 08:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240053AbiDNGXi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Apr 2022 02:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240021AbiDNGXd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Apr 2022 02:23:33 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33771F601
        for <linux-wireless@vger.kernel.org>; Wed, 13 Apr 2022 23:21:08 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23E6L1yvC001349, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23E6L1yvC001349
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 Apr 2022 14:21:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Apr 2022 14:21:01 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 14 Apr
 2022 14:21:01 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 05/12] rtw89: 8852c: add BB initial and reset functions
Date:   Thu, 14 Apr 2022 14:20:19 +0800
Message-ID: <20220414062027.62638-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220414062027.62638-1-pkshih@realtek.com>
References: <20220414062027.62638-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 04/14/2022 06:05:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMTQgpFekyCAwMzo1OTowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

chip_ops::bb_sethw is to initialize BB settings out of BB parameters
tables. Once switching channel or initialing, we do chip_ops::bb_reset to
reset hardware counters and states to make things in expectation.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  26 +++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 182 ++++++++++++++++++
 2 files changed, 208 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index cd7916085e007..a7daca1d462c0 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3280,6 +3280,10 @@
 #define B_ANAPAR_FLTRST BIT(22)
 #define B_ANAPAR_CRXBB GENMASK(18, 16)
 #define B_ANAPAR_14 GENMASK(15, 0)
+#define R_RFE_E_A2 0x0334
+#define R_RFE_O_SEL_A2 0x0338
+#define R_RFE_SEL0_A2 0x033C
+#define R_RFE_SEL32_A2 0x0340
 #define R_SWSI_DATA_V1 0x0370
 #define B_SWSI_DATA_VAL_V1 GENMASK(19, 0)
 #define B_SWSI_DATA_ADDR_V1 GENMASK(27, 20)
@@ -3340,6 +3344,8 @@
 #define B_PMAC_PTX_EN BIT(4)
 #define R_PMAC_TX_CNT 0x09C8
 #define B_PMAC_TX_CNT_MSK GENMASK(31, 0)
+#define R_DBCC_80P80_SEL_EVM_RPT 0x0A10
+#define B_DBCC_80P80_SEL_EVM_RPT_EN BIT(0)
 #define R_CCX 0x0C00
 #define B_CCX_EDCCA_OPT_MSK GENMASK(6, 4)
 #define B_MEASUREMENT_TRIG_MSK BIT(2)
@@ -3380,6 +3386,8 @@
 #define R_BRK_ASYNC_RST_EN_1 0x0DC0
 #define R_BRK_ASYNC_RST_EN_2 0x0DC4
 #define R_BRK_ASYNC_RST_EN_3 0x0DC8
+#define R_S0_HW_SI_DIS 0x1200
+#define B_S0_HW_SI_DIS_W_R_TRIG GENMASK(30, 28)
 #define R_P0_RXCK 0x12A0
 #define B_P0_RXCK_VAL GENMASK(18, 16)
 #define B_P0_RXCK_ON BIT(19)
@@ -3460,16 +3468,24 @@
 #define B_TXFIR_CCD GENMASK(23, 0)
 #define R_TXFIRE 0x231c
 #define B_TXFIR_CEF GENMASK(23, 0)
+#define R_11B_RX_V1 0x2320
+#define B_11B_RXCCA_DIS_V1 BIT(0)
 #define R_RXCCA 0x2344
 #define B_RXCCA_DIS BIT(31)
+#define R_RXCCA_V1 0x2320
+#define B_RXCCA_DIS_V1 BIT(0)
 #define R_RXSC 0x237C
 #define B_RXSC_EN BIT(0)
 #define R_RXSCOBC 0x23B0
 #define B_RXSCOBC_TH GENMASK(18, 0)
 #define R_RXSCOCCK 0x23B4
 #define B_RXSCOCCK_TH GENMASK(18, 0)
+#define R_DBCC_80P80_SEL_EVM_RPT2 0x2A10
+#define B_DBCC_80P80_SEL_EVM_RPT2_EN BIT(0)
 #define R_P1_EN_SOUND_WO_NDP 0x2D7C
 #define B_P1_EN_SOUND_WO_NDP BIT(1)
+#define R_S1_HW_SI_DIS 0x3200
+#define B_S1_HW_SI_DIS_W_R_TRIG GENMASK(30, 28)
 #define R_P1_DBGMOD 0x32B8
 #define B_P1_DBGMOD_ON BIT(30)
 #define R_S1_RXDC 0x32D4
@@ -3614,6 +3630,16 @@
 #define R_P0_RFCTM 0x5864
 #define B_P0_RFCTM_VAL GENMASK(25, 20)
 #define R_P0_RFCTM_RDY BIT(26)
+#define R_P0_TRSW 0x5868
+#define B_P0_TRSW_B BIT(0)
+#define B_P0_TRSW_A BIT(1)
+#define B_P0_TRSW_X BIT(2)
+#define B_P0_TRSW_SO_A2 GENMASK(7, 5)
+#define R_P0_RFM 0x5894
+#define B_P0_RFM_DIS_WL BIT(7)
+#define B_P0_RFM_TX_OPT BIT(6)
+#define B_P0_RFM_BT_EN BIT(5)
+#define B_P0_RFM_OUT GENMASK(4, 0)
 #define R_P0_TXDPD 0x58D4
 #define B_P0_TXDPD GENMASK(31, 28)
 #define R_P0_TXPW_RSTB 0x58DC
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 1b5f8da2e9e85..9c6bef665c764 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -495,6 +495,186 @@ static void rtw8852c_power_trim(struct rtw89_dev *rtwdev)
 	rtw8852c_pa_bias_trim(rtwdev);
 }
 
+static void rtw8852c_bb_reset_all(struct rtw89_dev *rtwdev,
+				  enum rtw89_phy_idx phy_idx)
+{
+	/*HW SI reset*/
+	rtw89_phy_write32_mask(rtwdev, R_S0_HW_SI_DIS, B_S0_HW_SI_DIS_W_R_TRIG,
+			       0x7);
+	rtw89_phy_write32_mask(rtwdev, R_S1_HW_SI_DIS, B_S1_HW_SI_DIS_W_R_TRIG,
+			       0x7);
+
+	udelay(1);
+
+	rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_ALL, 1,
+			      phy_idx);
+	rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_ALL, 0,
+			      phy_idx);
+	/*HW SI reset*/
+	rtw89_phy_write32_mask(rtwdev, R_S0_HW_SI_DIS, B_S0_HW_SI_DIS_W_R_TRIG,
+			       0x0);
+	rtw89_phy_write32_mask(rtwdev, R_S1_HW_SI_DIS, B_S1_HW_SI_DIS_W_R_TRIG,
+			       0x0);
+
+	rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_ALL, 1,
+			      phy_idx);
+}
+
+static void rtw8852c_bb_reset_en(struct rtw89_dev *rtwdev,
+				 enum rtw89_phy_idx phy_idx, bool en)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+
+	if (en) {
+		rtw89_phy_write32_idx(rtwdev, R_S0_HW_SI_DIS,
+				      B_S0_HW_SI_DIS_W_R_TRIG, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_S1_HW_SI_DIS,
+				      B_S1_HW_SI_DIS_W_R_TRIG, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_ALL, 1,
+				      phy_idx);
+		if (hal->current_band_type == RTW89_BAND_2G)
+			rtw89_phy_write32_mask(rtwdev, R_RXCCA_V1, B_RXCCA_DIS_V1, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PD_CTRL, B_PD_HIT_DIS, 0x0);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_RXCCA_V1, B_RXCCA_DIS_V1, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_PD_CTRL, B_PD_HIT_DIS, 0x1);
+		rtw89_phy_write32_idx(rtwdev, R_S0_HW_SI_DIS,
+				      B_S0_HW_SI_DIS_W_R_TRIG, 0x7, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_S1_HW_SI_DIS,
+				      B_S1_HW_SI_DIS_W_R_TRIG, 0x7, phy_idx);
+		fsleep(1);
+		rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_ALL, 0,
+				      phy_idx);
+	}
+}
+
+static void rtw8852c_bb_reset(struct rtw89_dev *rtwdev,
+			      enum rtw89_phy_idx phy_idx)
+{
+	rtw8852c_bb_reset_all(rtwdev, phy_idx);
+}
+
+static
+void rtw8852c_bb_gpio_trsw(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
+			   u8 tx_path_en, u8 trsw_tx,
+			   u8 trsw_rx, u8 trsw, u8 trsw_b)
+{
+	static const u32 path_cr_bases[] = {0x5868, 0x7868};
+	u32 mask_ofst = 16;
+	u32 cr;
+	u32 val;
+
+	if (path >= ARRAY_SIZE(path_cr_bases))
+		return;
+
+	cr = path_cr_bases[path];
+
+	mask_ofst += (tx_path_en * 4 + trsw_tx * 2 + trsw_rx) * 2;
+	val = FIELD_PREP(B_P0_TRSW_A, trsw) | FIELD_PREP(B_P0_TRSW_B, trsw_b);
+
+	rtw89_phy_write32_mask(rtwdev, cr, (B_P0_TRSW_A | B_P0_TRSW_B) << mask_ofst, val);
+}
+
+enum rtw8852c_rfe_src {
+	PAPE_RFM,
+	TRSW_RFM,
+	LNAON_RFM,
+};
+
+static
+void rtw8852c_bb_gpio_rfm(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
+			  enum rtw8852c_rfe_src src, u8 dis_tx_gnt_wl,
+			  u8 active_tx_opt, u8 act_bt_en, u8 rfm_output_val)
+{
+	static const u32 path_cr_bases[] = {0x5894, 0x7894};
+	static const u32 masks[] = {0, 8, 16};
+	u32 mask, mask_ofst;
+	u32 cr;
+	u32 val;
+
+	if (src >= ARRAY_SIZE(masks) || path >= ARRAY_SIZE(path_cr_bases))
+		return;
+
+	mask_ofst = masks[src];
+	cr = path_cr_bases[path];
+
+	val = FIELD_PREP(B_P0_RFM_DIS_WL, dis_tx_gnt_wl) |
+	      FIELD_PREP(B_P0_RFM_TX_OPT, active_tx_opt) |
+	      FIELD_PREP(B_P0_RFM_BT_EN, act_bt_en) |
+	      FIELD_PREP(B_P0_RFM_OUT, rfm_output_val);
+	mask = 0xff << mask_ofst;
+
+	rtw89_phy_write32_mask(rtwdev, cr, mask, val);
+}
+
+static void rtw8852c_bb_gpio_init(struct rtw89_dev *rtwdev)
+{
+	static const u32 cr_bases[] = {0x5800, 0x7800};
+	u32 addr;
+	u8 i;
+
+	for (i = 0; i < ARRAY_SIZE(cr_bases); i++) {
+		addr = cr_bases[i];
+		rtw89_phy_write32_set(rtwdev, (addr | 0x68), B_P0_TRSW_A);
+		rtw89_phy_write32_clr(rtwdev, (addr | 0x68), B_P0_TRSW_X);
+		rtw89_phy_write32_clr(rtwdev, (addr | 0x68), B_P0_TRSW_SO_A2);
+		rtw89_phy_write32(rtwdev, (addr | 0x80), 0x77777777);
+		rtw89_phy_write32(rtwdev, (addr | 0x84), 0x77777777);
+	}
+
+	rtw89_phy_write32(rtwdev, R_RFE_E_A2, 0xffffffff);
+	rtw89_phy_write32(rtwdev, R_RFE_O_SEL_A2, 0);
+	rtw89_phy_write32(rtwdev, R_RFE_SEL0_A2, 0);
+	rtw89_phy_write32(rtwdev, R_RFE_SEL32_A2, 0);
+
+	rtw8852c_bb_gpio_trsw(rtwdev, RF_PATH_A, 0, 0, 0, 0, 1);
+	rtw8852c_bb_gpio_trsw(rtwdev, RF_PATH_A, 0, 0, 1, 1, 0);
+	rtw8852c_bb_gpio_trsw(rtwdev, RF_PATH_A, 0, 1, 0, 1, 0);
+	rtw8852c_bb_gpio_trsw(rtwdev, RF_PATH_A, 0, 1, 1, 1, 0);
+	rtw8852c_bb_gpio_trsw(rtwdev, RF_PATH_A, 1, 0, 0, 0, 1);
+	rtw8852c_bb_gpio_trsw(rtwdev, RF_PATH_A, 1, 0, 1, 1, 0);
+	rtw8852c_bb_gpio_trsw(rtwdev, RF_PATH_A, 1, 1, 0, 1, 0);
+	rtw8852c_bb_gpio_trsw(rtwdev, RF_PATH_A, 1, 1, 1, 1, 0);
+
+	rtw8852c_bb_gpio_trsw(rtwdev, RF_PATH_B, 0, 0, 0, 0, 1);
+	rtw8852c_bb_gpio_trsw(rtwdev, RF_PATH_B, 0, 0, 1, 1, 0);
+	rtw8852c_bb_gpio_trsw(rtwdev, RF_PATH_B, 0, 1, 0, 1, 0);
+	rtw8852c_bb_gpio_trsw(rtwdev, RF_PATH_B, 0, 1, 1, 1, 0);
+	rtw8852c_bb_gpio_trsw(rtwdev, RF_PATH_B, 1, 0, 0, 0, 1);
+	rtw8852c_bb_gpio_trsw(rtwdev, RF_PATH_B, 1, 0, 1, 1, 0);
+	rtw8852c_bb_gpio_trsw(rtwdev, RF_PATH_B, 1, 1, 0, 1, 0);
+	rtw8852c_bb_gpio_trsw(rtwdev, RF_PATH_B, 1, 1, 1, 1, 0);
+
+	rtw8852c_bb_gpio_rfm(rtwdev, RF_PATH_A, PAPE_RFM, 0, 0, 0, 0x0);
+	rtw8852c_bb_gpio_rfm(rtwdev, RF_PATH_A, TRSW_RFM, 0, 0, 0, 0x4);
+	rtw8852c_bb_gpio_rfm(rtwdev, RF_PATH_A, LNAON_RFM, 0, 0, 0, 0x8);
+
+	rtw8852c_bb_gpio_rfm(rtwdev, RF_PATH_B, PAPE_RFM, 0, 0, 0, 0x0);
+	rtw8852c_bb_gpio_rfm(rtwdev, RF_PATH_B, TRSW_RFM, 0, 0, 0, 0x4);
+	rtw8852c_bb_gpio_rfm(rtwdev, RF_PATH_B, LNAON_RFM, 0, 0, 0, 0x8);
+}
+
+static void rtw8852c_bb_macid_ctrl_init(struct rtw89_dev *rtwdev,
+					enum rtw89_phy_idx phy_idx)
+{
+	u32 addr;
+
+	for (addr = R_AX_PWR_MACID_LMT_TABLE0;
+	     addr <= R_AX_PWR_MACID_LMT_TABLE127; addr += 4)
+		rtw89_mac_txpwr_write32(rtwdev, phy_idx, addr, 0);
+}
+
+static void rtw8852c_bb_sethw(struct rtw89_dev *rtwdev)
+{
+	rtw89_phy_write32_set(rtwdev, R_DBCC_80P80_SEL_EVM_RPT,
+			      B_DBCC_80P80_SEL_EVM_RPT_EN);
+	rtw89_phy_write32_set(rtwdev, R_DBCC_80P80_SEL_EVM_RPT2,
+			      B_DBCC_80P80_SEL_EVM_RPT2_EN);
+
+	rtw8852c_bb_macid_ctrl_init(rtwdev, RTW89_PHY_0);
+	rtw8852c_bb_gpio_init(rtwdev);
+}
+
 static
 void rtw8852c_set_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
 				     s8 pw_ofst, enum rtw89_mac_idx mac_idx)
@@ -632,6 +812,8 @@ static void rtw8852c_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
 static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.enable_bb_rf		= rtw8852c_mac_enable_bb_rf,
 	.disable_bb_rf		= rtw8852c_mac_disable_bb_rf,
+	.bb_reset		= rtw8852c_bb_reset,
+	.bb_sethw		= rtw8852c_bb_sethw,
 	.read_efuse		= rtw8852c_read_efuse,
 	.read_phycap		= rtw8852c_read_phycap,
 	.power_trim		= rtw8852c_power_trim,
-- 
2.25.1

