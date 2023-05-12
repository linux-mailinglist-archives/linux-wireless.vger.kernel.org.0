Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92967700023
	for <lists+linux-wireless@lfdr.de>; Fri, 12 May 2023 08:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239839AbjELGND (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 May 2023 02:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239720AbjELGNB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 May 2023 02:13:01 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7744835A3
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 23:12:56 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34C6CaAdA013925, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34C6CaAdA013925
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 12 May 2023 14:12:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 12 May 2023 14:12:43 +0800
Received: from [127.0.1.1] (172.16.17.85) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 12 May
 2023 14:12:42 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/6] wifi: rtw89: 8851b: configure GPIO according to RFE type
Date:   Fri, 12 May 2023 14:12:16 +0800
Message-ID: <20230512061220.16544-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230512061220.16544-1-pkshih@realtek.com>
References: <20230512061220.16544-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.85]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Though 8851BE is a 1x1 chip, but it has two antenna hardware module that
needs additional configuration to help choose antenna we are going to use.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  9 +++
 drivers/net/wireless/realtek/rtw89/phy.c      |  1 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  9 +++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 64 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 7 files changed, 86 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b60cd9852259e..fe464b7212f55 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2799,6 +2799,7 @@ struct rtw89_chip_ops {
 	int (*read_efuse)(struct rtw89_dev *rtwdev, u8 *log_map);
 	int (*read_phycap)(struct rtw89_dev *rtwdev, u8 *phycap_map);
 	void (*fem_setup)(struct rtw89_dev *rtwdev);
+	void (*rfe_gpio)(struct rtw89_dev *rtwdev);
 	void (*rfk_init)(struct rtw89_dev *rtwdev);
 	void (*rfk_channel)(struct rtw89_dev *rtwdev);
 	void (*rfk_band_changed)(struct rtw89_dev *rtwdev,
@@ -4700,6 +4701,14 @@ static inline void rtw89_chip_fem_setup(struct rtw89_dev *rtwdev)
 		chip->ops->fem_setup(rtwdev);
 }
 
+static inline void rtw89_chip_rfe_gpio(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (chip->ops->rfe_gpio)
+		chip->ops->rfe_gpio(rtwdev);
+}
+
 static inline void rtw89_chip_bb_sethw(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 568488da3ff15..de0776dfddf7e 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -4399,6 +4399,7 @@ void rtw89_phy_dm_init(struct rtw89_dev *rtwdev)
 	rtw89_phy_cfo_init(rtwdev);
 	rtw89_phy_ul_tb_info_init(rtwdev);
 	rtw89_phy_antdiv_init(rtwdev);
+	rtw89_chip_rfe_gpio(rtwdev);
 	rtw89_phy_antdiv_set_ant(rtwdev);
 
 	rtw89_phy_init_rf_nctl(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 21f68787ff109..a15bf3a6687c5 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -254,6 +254,10 @@
 #define R_AX_EECS_EESK_FUNC_SEL 0x02D8
 #define B_AX_PINMUX_EESK_FUNC_SEL_MASK GENMASK(7, 4)
 
+#define R_AX_GPIO16_23_FUNC_SEL 0x02D8
+#define B_AX_PINMUX_GPIO17_FUNC_SEL_MASK GENMASK(7, 4)
+#define B_AX_PINMUX_GPIO16_FUNC_SEL_MASK GENMASK(3, 0)
+
 #define R_AX_LED1_FUNC_SEL 0x02DC
 #define B_AX_PINMUX_EESK_FUNC_SEL_V1_MASK GENMASK(27, 24)
 #define PINMUX_EESK_FUNC_SEL_BT_LOG 0x1
@@ -3846,6 +3850,7 @@
 #define R_RFE_E_A2 0x0334
 #define R_RFE_O_SEL_A2 0x0338
 #define R_RFE_SEL0_A2 0x033C
+#define B_RFE_SEL0_MASK GENMASK(1, 0)
 #define R_RFE_SEL32_A2 0x0340
 #define R_CIRST 0x035c
 #define B_CIRST_SYN GENMASK(11, 10)
@@ -4490,6 +4495,10 @@
 #define B_P0_ANTSEL_RX_ORI GENMASK(7, 4)
 #define R_RFSW_CTRL_ANT0_BASE 0x5870
 #define B_RFSW_CTRL_ANT_MAPPING GENMASK(15, 0)
+#define R_RFE_SEL0_BASE 0x5880
+#define B_RFE_SEL0_SRC_MASK GENMASK(3, 0)
+#define RFE_SEL0_SRC_ANTSEL_0 8
+#define R_RFE_INV0 0x5890
 #define R_P0_RFM 0x5894
 #define B_P0_RFM_DIS_WL BIT(7)
 #define B_P0_RFM_TX_OPT BIT(6)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 00cabf92c5a99..047171ead2e97 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -72,8 +72,72 @@ static const struct rtw89_xtal_info rtw8851b_xtal_info = {
 	.sc_xi_mask		= B_AX_XTAL_SC_XI_A_BLOCK_MASK,
 };
 
+static void rtw8851b_set_bb_gpio(struct rtw89_dev *rtwdev, u8 gpio_idx, bool inv,
+				 u8 src_sel)
+{
+	u32 addr, mask;
+
+	if (gpio_idx >= 32)
+		return;
+
+	/* 2 continual 32-bit registers for 32 GPIOs, and each GPIO occupies 2 bits */
+	addr = R_RFE_SEL0_A2 + (gpio_idx / 16) * sizeof(u32);
+	mask = B_RFE_SEL0_MASK << (gpio_idx % 16) * 2;
+
+	rtw89_phy_write32_mask(rtwdev, addr, mask, RF_PATH_A);
+	rtw89_phy_write32_mask(rtwdev, R_RFE_INV0, BIT(gpio_idx), inv);
+
+	/* 4 continual 32-bit registers for 32 GPIOs, and each GPIO occupies 4 bits */
+	addr = R_RFE_SEL0_BASE + (gpio_idx / 8) * sizeof(u32);
+	mask = B_RFE_SEL0_SRC_MASK << (gpio_idx % 8) * 4;
+
+	rtw89_phy_write32_mask(rtwdev, addr, mask, src_sel);
+}
+
+static void rtw8851b_set_mac_gpio(struct rtw89_dev *rtwdev, u8 func)
+{
+	static const struct rtw89_reg3_def func16 = {
+		R_AX_GPIO16_23_FUNC_SEL, B_AX_PINMUX_GPIO16_FUNC_SEL_MASK, BIT(3)
+	};
+	static const struct rtw89_reg3_def func17 = {
+		R_AX_GPIO16_23_FUNC_SEL, B_AX_PINMUX_GPIO17_FUNC_SEL_MASK, BIT(7) >> 4,
+	};
+	const struct rtw89_reg3_def *def;
+
+	switch (func) {
+	case 16:
+		def = &func16;
+		break;
+	case 17:
+		def = &func17;
+		break;
+	default:
+		rtw89_warn(rtwdev, "undefined gpio func %d\n", func);
+		return;
+	}
+
+	rtw89_write8_mask(rtwdev, def->addr, def->mask, def->data);
+}
+
+static void rtw8851b_rfe_gpio(struct rtw89_dev *rtwdev)
+{
+	u8 rfe_type = rtwdev->efuse.rfe_type;
+
+	if (rfe_type > 50)
+		return;
+
+	if (rfe_type % 3 == 2) {
+		rtw8851b_set_bb_gpio(rtwdev, 16, true, RFE_SEL0_SRC_ANTSEL_0);
+		rtw8851b_set_bb_gpio(rtwdev, 17, false, RFE_SEL0_SRC_ANTSEL_0);
+
+		rtw8851b_set_mac_gpio(rtwdev, 16);
+		rtw8851b_set_mac_gpio(rtwdev, 17);
+	}
+}
+
 static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.fem_setup		= NULL,
+	.rfe_gpio		= rtw8851b_rfe_gpio,
 	.fill_txdesc		= rtw89_core_fill_txdesc,
 	.fill_txdesc_fwcmd	= rtw89_core_fill_txdesc,
 	.h2c_dctl_sec_cam	= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 4e6f3bbdc2d8f..541ad2f4b0c2b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2032,6 +2032,7 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.read_efuse		= rtw8852a_read_efuse,
 	.read_phycap		= rtw8852a_read_phycap,
 	.fem_setup		= rtw8852a_fem_setup,
+	.rfe_gpio		= NULL,
 	.rfk_init		= rtw8852a_rfk_init,
 	.rfk_channel		= rtw8852a_rfk_channel,
 	.rfk_band_changed	= rtw8852a_rfk_band_changed,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index b1a6b985842be..4e4023f114ec8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2454,6 +2454,7 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.read_efuse		= rtw8852b_read_efuse,
 	.read_phycap		= rtw8852b_read_phycap,
 	.fem_setup		= NULL,
+	.rfe_gpio		= NULL,
 	.rfk_init		= rtw8852b_rfk_init,
 	.rfk_channel		= rtw8852b_rfk_channel,
 	.rfk_band_changed	= rtw8852b_rfk_band_changed,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index f2e70bda8e480..e4c984c87d6cc 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2762,6 +2762,7 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.read_efuse		= rtw8852c_read_efuse,
 	.read_phycap		= rtw8852c_read_phycap,
 	.fem_setup		= NULL,
+	.rfe_gpio		= NULL,
 	.rfk_init		= rtw8852c_rfk_init,
 	.rfk_channel		= rtw8852c_rfk_channel,
 	.rfk_band_changed	= rtw8852c_rfk_band_changed,
-- 
2.25.1

