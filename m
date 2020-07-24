Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC79222BDA2
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jul 2020 07:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgGXFme (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jul 2020 01:42:34 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:52367 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgGXFmd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jul 2020 01:42:33 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 06O5gDPP1009092, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 06O5gDPP1009092
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 24 Jul 2020 13:42:13 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 24 Jul 2020 13:42:13 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 24 Jul 2020 13:42:13 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <tehuang@realtek.com>,
        <bigeasy@linutronix.de>
Subject: [PATCH v3] rtw88: 8821c: coex: add functions and parameters
Date:   Fri, 24 Jul 2020 13:42:08 +0800
Message-ID: <20200724054208.31115-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Cheng Chen <pc.chen@realtek.com>

Without this patch, RTL8821CE will not have coex support,
and will crash the system because of the NULL pointers
for the coex functions.

While RTL8822C series are WiFi + BT combo chips, it needs
the co-existence mechanism for the device to work on both
WiFi and BT without interfering each other. And the coex
support has already been added before, most of the mechanisms
are implemented. The driver should just add corresponding
functions to operate on different types of chips and its
coex parameters.

Fixes: f745eb9ca5bf ("rtw88: 8821c: Add 8821CE to Kconfig and Makefile")
Signed-off-by: Ping-Cheng Chen <pc.chen@realtek.com>
Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---

v1 -> v3
  * use full name for the author

 drivers/net/wireless/realtek/rtw88/reg.h      |   1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 403 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8821c.h |  26 ++
 3 files changed, 430 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index f1275757f6b4..8f468d6b5f78 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -61,6 +61,7 @@
 #define BIT_FSPI_EN		BIT(19)
 #define BIT_EN_SIC		BIT(12)
 #define BIT_BT_AOD_GPIO3	BIT(9)
+#define BIT_PO_BT_PTA_PINS	BIT(9)
 #define BIT_BT_PTA_EN		BIT(5)
 #define BIT_WLRFE_4_5_EN	BIT(2)
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index c41c61ee2fb6..0ac8c005c8e1 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -649,6 +649,197 @@ static void rtw8821c_phy_calibration(struct rtw_dev *rtwdev)
 	rtw8821c_do_iqk(rtwdev);
 }
 
+/* for coex */
+static void rtw8821c_coex_cfg_init(struct rtw_dev *rtwdev)
+{
+	/* enable TBTT nterrupt */
+	rtw_write8_set(rtwdev, REG_BCN_CTRL, BIT_EN_BCN_FUNCTION);
+
+	/* BT report packet sample rate */
+	rtw_write8_mask(rtwdev, REG_BT_TDMA_TIME, SAMPLE_RATE_MASK,
+			SAMPLE_RATE);
+
+	/* enable BT counter statistics */
+	rtw_write8(rtwdev, REG_BT_STAT_CTRL, BT_CNT_ENABLE);
+
+	/* enable PTA (3-wire function form BT side) */
+	rtw_write32_set(rtwdev, REG_GPIO_MUXCFG, BIT_BT_PTA_EN);
+	rtw_write32_set(rtwdev, REG_GPIO_MUXCFG, BIT_PO_BT_PTA_PINS);
+
+	/* enable PTA (tx/rx signal form WiFi side) */
+	rtw_write8_set(rtwdev, REG_QUEUE_CTRL, BIT_PTA_WL_TX_EN);
+	/* wl tx signal to PTA not case EDCCA */
+	rtw_write8_clr(rtwdev, REG_QUEUE_CTRL, BIT_PTA_EDCCA_EN);
+	/* GNT_BT=1 while select both */
+	rtw_write16_set(rtwdev, REG_BT_COEX_V2, BIT_GNT_BT_POLARITY);
+
+	/* beacon queue always hi-pri  */
+	rtw_write8_mask(rtwdev, REG_BT_COEX_TABLE_H + 3, BIT_BCN_QUEUE,
+			BCN_PRI_EN);
+}
+
+static void rtw8821c_coex_cfg_ant_switch(struct rtw_dev *rtwdev, u8 ctrl_type,
+					 u8 pos_type)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
+	struct rtw_coex_rfe *coex_rfe = &coex->rfe;
+	u32 switch_status = FIELD_PREP(CTRL_TYPE_MASK, ctrl_type) | pos_type;
+	bool polarity_inverse;
+	u8 regval = 0;
+
+	if (switch_status == coex_dm->cur_switch_status)
+		return;
+
+	coex_dm->cur_switch_status = switch_status;
+
+	if (coex_rfe->ant_switch_diversity &&
+	    ctrl_type == COEX_SWITCH_CTRL_BY_BBSW)
+		ctrl_type = COEX_SWITCH_CTRL_BY_ANTDIV;
+
+	polarity_inverse = (coex_rfe->ant_switch_polarity == 1);
+
+	switch (ctrl_type) {
+	default:
+	case COEX_SWITCH_CTRL_BY_BBSW:
+		rtw_write32_clr(rtwdev, REG_LED_CFG, BIT_DPDT_SEL_EN);
+		rtw_write32_set(rtwdev, REG_LED_CFG, BIT_DPDT_WL_SEL);
+		/* BB SW, DPDT use RFE_ctrl8 and RFE_ctrl9 as ctrl pin */
+		rtw_write8_mask(rtwdev, REG_RFE_CTRL8, BIT_MASK_RFE_SEL89,
+				DPDT_CTRL_PIN);
+
+		if (pos_type == COEX_SWITCH_TO_WLG_BT) {
+			if (coex_rfe->rfe_module_type != 0x4 &&
+			    coex_rfe->rfe_module_type != 0x2)
+				regval = 0x3;
+			else
+				regval = (!polarity_inverse ? 0x2 : 0x1);
+		} else if (pos_type == COEX_SWITCH_TO_WLG) {
+			regval = (!polarity_inverse ? 0x2 : 0x1);
+		} else {
+			regval = (!polarity_inverse ? 0x1 : 0x2);
+		}
+
+		rtw_write8_mask(rtwdev, REG_RFE_CTRL8, BIT_MASK_R_RFE_SEL_15,
+				regval);
+		break;
+	case COEX_SWITCH_CTRL_BY_PTA:
+		rtw_write32_clr(rtwdev, REG_LED_CFG, BIT_DPDT_SEL_EN);
+		rtw_write32_set(rtwdev, REG_LED_CFG, BIT_DPDT_WL_SEL);
+		/* PTA,  DPDT use RFE_ctrl8 and RFE_ctrl9 as ctrl pin */
+		rtw_write8_mask(rtwdev, REG_RFE_CTRL8, BIT_MASK_RFE_SEL89,
+				PTA_CTRL_PIN);
+
+		regval = (!polarity_inverse ? 0x2 : 0x1);
+		rtw_write8_mask(rtwdev, REG_RFE_CTRL8, BIT_MASK_R_RFE_SEL_15,
+				regval);
+		break;
+	case COEX_SWITCH_CTRL_BY_ANTDIV:
+		rtw_write32_clr(rtwdev, REG_LED_CFG, BIT_DPDT_SEL_EN);
+		rtw_write32_set(rtwdev, REG_LED_CFG, BIT_DPDT_WL_SEL);
+		rtw_write8_mask(rtwdev, REG_RFE_CTRL8, BIT_MASK_RFE_SEL89,
+				ANTDIC_CTRL_PIN);
+		break;
+	case COEX_SWITCH_CTRL_BY_MAC:
+		rtw_write32_set(rtwdev, REG_LED_CFG, BIT_DPDT_SEL_EN);
+
+		regval = (!polarity_inverse ? 0x0 : 0x1);
+		rtw_write8_mask(rtwdev, REG_PAD_CTRL1, BIT_SW_DPDT_SEL_DATA,
+				regval);
+		break;
+	case COEX_SWITCH_CTRL_BY_FW:
+		rtw_write32_clr(rtwdev, REG_LED_CFG, BIT_DPDT_SEL_EN);
+		rtw_write32_set(rtwdev, REG_LED_CFG, BIT_DPDT_WL_SEL);
+		break;
+	case COEX_SWITCH_CTRL_BY_BT:
+		rtw_write32_clr(rtwdev, REG_LED_CFG, BIT_DPDT_SEL_EN);
+		rtw_write32_clr(rtwdev, REG_LED_CFG, BIT_DPDT_WL_SEL);
+		break;
+	}
+
+	if (ctrl_type == COEX_SWITCH_CTRL_BY_BT) {
+		rtw_write32_clr(rtwdev, REG_CTRL_TYPE, BIT_CTRL_TYPE1);
+		rtw_write32_clr(rtwdev, REG_CTRL_TYPE, BIT_CTRL_TYPE2);
+	} else {
+		rtw_write32_set(rtwdev, REG_CTRL_TYPE, BIT_CTRL_TYPE1);
+		rtw_write32_set(rtwdev, REG_CTRL_TYPE, BIT_CTRL_TYPE2);
+	}
+}
+
+static void rtw8821c_coex_cfg_gnt_fix(struct rtw_dev *rtwdev)
+{}
+
+static void rtw8821c_coex_cfg_gnt_debug(struct rtw_dev *rtwdev)
+{
+	rtw_write32_clr(rtwdev, REG_PAD_CTRL1, BIT_BTGP_SPI_EN);
+	rtw_write32_clr(rtwdev, REG_PAD_CTRL1, BIT_BTGP_JTAG_EN);
+	rtw_write32_clr(rtwdev, REG_GPIO_MUXCFG, BIT_FSPI_EN);
+	rtw_write32_clr(rtwdev, REG_PAD_CTRL1, BIT_LED1DIS);
+	rtw_write32_clr(rtwdev, REG_SYS_SDIO_CTRL, BIT_SDIO_INT);
+	rtw_write32_clr(rtwdev, REG_SYS_SDIO_CTRL, BIT_DBG_GNT_WL_BT);
+}
+
+static void rtw8821c_coex_cfg_rfe_type(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_rfe *coex_rfe = &coex->rfe;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+
+	coex_rfe->rfe_module_type = efuse->rfe_option;
+	coex_rfe->ant_switch_polarity = 0;
+	coex_rfe->ant_switch_exist = true;
+	coex_rfe->wlg_at_btg = false;
+
+	switch (coex_rfe->rfe_module_type) {
+	case 0:
+	case 8:
+	case 1:
+	case 9:  /* 1-Ant, Main, WLG */
+	default: /* 2-Ant, DPDT, WLG */
+		break;
+	case 2:
+	case 10: /* 1-Ant, Main, BTG */
+	case 7:
+	case 15: /* 2-Ant, DPDT, BTG */
+		coex_rfe->wlg_at_btg = true;
+		break;
+	case 3:
+	case 11: /* 1-Ant, Aux, WLG */
+		coex_rfe->ant_switch_polarity = 1;
+		break;
+	case 4:
+	case 12: /* 1-Ant, Aux, BTG */
+		coex_rfe->wlg_at_btg = true;
+		coex_rfe->ant_switch_polarity = 1;
+		break;
+	case 5:
+	case 13: /* 2-Ant, no switch, WLG */
+	case 6:
+	case 14: /* 2-Ant, no antenna switch, WLG */
+		coex_rfe->ant_switch_exist = false;
+		break;
+	}
+}
+
+static void rtw8821c_coex_cfg_wl_tx_power(struct rtw_dev *rtwdev, u8 wl_pwr)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	bool share_ant = efuse->share_ant;
+
+	if (share_ant)
+		return;
+
+	if (wl_pwr == coex_dm->cur_wl_pwr_lvl)
+		return;
+
+	coex_dm->cur_wl_pwr_lvl = wl_pwr;
+}
+
+static void rtw8821c_coex_cfg_wl_rx_gain(struct rtw_dev *rtwdev, bool low_gain)
+{}
+
 static void
 rtw8821c_txagc_swing_offset(struct rtw_dev *rtwdev, u8 pwr_idx_offset,
 			    s8 pwr_idx_offset_lower,
@@ -1293,8 +1484,166 @@ static struct rtw_chip_ops rtw8821c_ops = {
 	.config_bfee		= rtw8821c_bf_config_bfee,
 	.set_gid_table		= rtw_bf_set_gid_table,
 	.cfg_csi_rate		= rtw_bf_cfg_csi_rate,
+
+	.coex_set_init		= rtw8821c_coex_cfg_init,
+	.coex_set_ant_switch	= rtw8821c_coex_cfg_ant_switch,
+	.coex_set_gnt_fix	= rtw8821c_coex_cfg_gnt_fix,
+	.coex_set_gnt_debug	= rtw8821c_coex_cfg_gnt_debug,
+	.coex_set_rfe_type	= rtw8821c_coex_cfg_rfe_type,
+	.coex_set_wl_tx_power	= rtw8821c_coex_cfg_wl_tx_power,
+	.coex_set_wl_rx_gain	= rtw8821c_coex_cfg_wl_rx_gain,
+};
+
+/* rssi in percentage % (dbm = % - 100) */
+static const u8 wl_rssi_step_8821c[] = {101, 45, 101, 40};
+static const u8 bt_rssi_step_8821c[] = {101, 101, 101, 101};
+
+/* Shared-Antenna Coex Table */
+static const struct coex_table_para table_sant_8821c[] = {
+	{0x55555555, 0x55555555}, /* case-0 */
+	{0x55555555, 0x55555555},
+	{0x66555555, 0x66555555},
+	{0xaaaaaaaa, 0xaaaaaaaa},
+	{0x5a5a5a5a, 0x5a5a5a5a},
+	{0xfafafafa, 0xfafafafa}, /* case-5 */
+	{0x6a5a5555, 0xaaaaaaaa},
+	{0x6a5a56aa, 0x6a5a56aa},
+	{0x6a5a5a5a, 0x6a5a5a5a},
+	{0x66555555, 0x5a5a5a5a},
+	{0x66555555, 0x6a5a5a5a}, /* case-10 */
+	{0x66555555, 0xaaaaaaaa},
+	{0x66555555, 0x6a5a5aaa},
+	{0x66555555, 0x6aaa6aaa},
+	{0x66555555, 0x6a5a5aaa},
+	{0x66555555, 0xaaaaaaaa}, /* case-15 */
+	{0xffff55ff, 0xfafafafa},
+	{0xffff55ff, 0x6afa5afa},
+	{0xaaffffaa, 0xfafafafa},
+	{0xaa5555aa, 0x5a5a5a5a},
+	{0xaa5555aa, 0x6a5a5a5a}, /* case-20 */
+	{0xaa5555aa, 0xaaaaaaaa},
+	{0xffffffff, 0x55555555},
+	{0xffffffff, 0x5a5a5a5a},
+	{0xffffffff, 0x5a5a5a5a},
+	{0xffffffff, 0x5a5a5aaa}, /* case-25 */
+	{0x55555555, 0x5a5a5a5a},
+	{0x55555555, 0xaaaaaaaa},
+	{0x66555555, 0x6a5a6a5a},
+	{0x66556655, 0x66556655},
+	{0x66556aaa, 0x6a5a6aaa}, /* case-30 */
+	{0xffffffff, 0x5aaa5aaa},
+	{0x56555555, 0x5a5a5aaa}
+};
+
+/* Non-Shared-Antenna Coex Table */
+static const struct coex_table_para table_nsant_8821c[] = {
+	{0xffffffff, 0xffffffff}, /* case-100 */
+	{0xffff55ff, 0xfafafafa},
+	{0x66555555, 0x66555555},
+	{0xaaaaaaaa, 0xaaaaaaaa},
+	{0x5a5a5a5a, 0x5a5a5a5a},
+	{0xffffffff, 0xffffffff}, /* case-105 */
+	{0x5afa5afa, 0x5afa5afa},
+	{0x55555555, 0xfafafafa},
+	{0x66555555, 0xfafafafa},
+	{0x66555555, 0x5a5a5a5a},
+	{0x66555555, 0x6a5a5a5a}, /* case-110 */
+	{0x66555555, 0xaaaaaaaa},
+	{0xffff55ff, 0xfafafafa},
+	{0xffff55ff, 0x5afa5afa},
+	{0xffff55ff, 0xaaaaaaaa},
+	{0xffff55ff, 0xffff55ff}, /* case-115 */
+	{0xaaffffaa, 0x5afa5afa},
+	{0xaaffffaa, 0xaaaaaaaa},
+	{0xffffffff, 0xfafafafa},
+	{0xffff55ff, 0xfafafafa},
+	{0xffffffff, 0xaaaaaaaa}, /* case-120 */
+	{0xffff55ff, 0x5afa5afa},
+	{0xffff55ff, 0x5afa5afa},
+	{0x55ff55ff, 0x55ff55ff}
+};
+
+/* Shared-Antenna TDMA */
+static const struct coex_tdma_para tdma_sant_8821c[] = {
+	{ {0x00, 0x00, 0x00, 0x00, 0x00} }, /* case-0 */
+	{ {0x61, 0x45, 0x03, 0x11, 0x11} }, /* case-1 */
+	{ {0x61, 0x3a, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x35, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x20, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x3a, 0x03, 0x11, 0x11} }, /* case-5 */
+	{ {0x61, 0x45, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x35, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x30, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x20, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x10, 0x03, 0x11, 0x10} }, /* case-10 */
+	{ {0x61, 0x08, 0x03, 0x11, 0x15} },
+	{ {0x61, 0x08, 0x03, 0x10, 0x14} },
+	{ {0x51, 0x08, 0x03, 0x10, 0x54} },
+	{ {0x51, 0x08, 0x03, 0x10, 0x55} },
+	{ {0x51, 0x08, 0x07, 0x10, 0x54} }, /* case-15 */
+	{ {0x51, 0x45, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x3a, 0x03, 0x11, 0x50} },
+	{ {0x51, 0x30, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x21, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x10, 0x03, 0x10, 0x50} }, /* case-20 */
+	{ {0x51, 0x4a, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x08, 0x03, 0x30, 0x54} },
+	{ {0x55, 0x08, 0x03, 0x10, 0x54} },
+	{ {0x65, 0x10, 0x03, 0x11, 0x10} },
+	{ {0x51, 0x10, 0x03, 0x10, 0x51} }, /* case-25 */
+	{ {0x51, 0x21, 0x03, 0x10, 0x50} },
+	{ {0x61, 0x08, 0x03, 0x11, 0x11} }
+};
+
+/* Non-Shared-Antenna TDMA */
+static const struct coex_tdma_para tdma_nsant_8821c[] = {
+	{ {0x00, 0x00, 0x00, 0x40, 0x00} }, /* case-100 */
+	{ {0x61, 0x45, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x25, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x35, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x20, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x10, 0x03, 0x11, 0x11} }, /* case-105 */
+	{ {0x61, 0x45, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x30, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x30, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x20, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x10, 0x03, 0x11, 0x10} }, /* case-110 */
+	{ {0x61, 0x10, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x08, 0x03, 0x10, 0x14} },
+	{ {0x51, 0x08, 0x03, 0x10, 0x54} },
+	{ {0x51, 0x08, 0x03, 0x10, 0x55} },
+	{ {0x51, 0x08, 0x07, 0x10, 0x54} }, /* case-115 */
+	{ {0x51, 0x45, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x3a, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x30, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x21, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x21, 0x03, 0x10, 0x50} }, /* case-120 */
+	{ {0x51, 0x10, 0x03, 0x10, 0x50} }
 };
 
+static const struct coex_5g_afh_map afh_5g_8821c[] = { {0, 0, 0} };
+
+/* wl_tx_dec_power, bt_tx_dec_power, wl_rx_gain, bt_rx_lna_constrain */
+static const struct coex_rf_para rf_para_tx_8821c[] = {
+	{0, 0, false, 7},  /* for normal */
+	{0, 20, false, 7}, /* for WL-CPT */
+	{8, 17, true, 4},
+	{7, 18, true, 4},
+	{6, 19, true, 4},
+	{5, 20, true, 4}
+};
+
+static const struct coex_rf_para rf_para_rx_8821c[] = {
+	{0, 0, false, 7},  /* for normal */
+	{0, 20, false, 7}, /* for WL-CPT */
+	{3, 24, true, 5},
+	{2, 26, true, 5},
+	{1, 27, true, 5},
+	{0, 28, true, 5}
+};
+
+static_assert(ARRAY_SIZE(rf_para_tx_8821c) == ARRAY_SIZE(rf_para_rx_8821c));
+
 static const u8 rtw8821c_pwrtrk_5gb_n[][RTW_PWR_TRK_TBL_SZ] = {
 	{0, 1, 1, 2, 3, 3, 3, 4, 4, 5, 5, 6, 6, 6, 7, 8, 8, 8, 9, 9, 9, 10, 10,
 	 11, 11, 12, 12, 12, 12, 12},
@@ -1394,6 +1743,31 @@ const struct rtw_pwr_track_tbl rtw8821c_rtw_pwr_track_tbl = {
 	.pwrtrk_2g_ccka_p = rtw8821c_pwrtrk_2g_cck_a_p,
 };
 
+static const struct rtw_reg_domain coex_info_hw_regs_8821c[] = {
+	{0xCB0, MASKDWORD, RTW_REG_DOMAIN_MAC32},
+	{0xCB4, MASKDWORD, RTW_REG_DOMAIN_MAC32},
+	{0xCBA, MASKBYTE0, RTW_REG_DOMAIN_MAC8},
+	{0, 0, RTW_REG_DOMAIN_NL},
+	{0x430, MASKDWORD, RTW_REG_DOMAIN_MAC32},
+	{0x434, MASKDWORD, RTW_REG_DOMAIN_MAC32},
+	{0x42a, MASKLWORD, RTW_REG_DOMAIN_MAC16},
+	{0x426, MASKBYTE0, RTW_REG_DOMAIN_MAC8},
+	{0x45e, BIT(3), RTW_REG_DOMAIN_MAC8},
+	{0x454, MASKLWORD, RTW_REG_DOMAIN_MAC16},
+	{0, 0, RTW_REG_DOMAIN_NL},
+	{0x4c, BIT(24) | BIT(23), RTW_REG_DOMAIN_MAC32},
+	{0x64, BIT(0), RTW_REG_DOMAIN_MAC8},
+	{0x4c6, BIT(4), RTW_REG_DOMAIN_MAC8},
+	{0x40, BIT(5), RTW_REG_DOMAIN_MAC8},
+	{0x1, RFREG_MASK, RTW_REG_DOMAIN_RF_A},
+	{0, 0, RTW_REG_DOMAIN_NL},
+	{0x550, MASKDWORD, RTW_REG_DOMAIN_MAC32},
+	{0x522, MASKBYTE0, RTW_REG_DOMAIN_MAC8},
+	{0x953, BIT(1), RTW_REG_DOMAIN_MAC8},
+	{0xc50,  MASKBYTE0, RTW_REG_DOMAIN_MAC8},
+	{0x60A, MASKBYTE0, RTW_REG_DOMAIN_MAC8},
+};
+
 struct rtw_chip_info rtw8821c_hw_spec = {
 	.ops = &rtw8821c_ops,
 	.id = RTW_CHIP_TYPE_8821C,
@@ -1440,6 +1814,35 @@ struct rtw_chip_info rtw8821c_hw_spec = {
 	.iqk_threshold = 8,
 	.bfer_su_max_num = 2,
 	.bfer_mu_max_num = 1,
+
+	.coex_para_ver = 0x19092746,
+	.bt_desired_ver = 0x46,
+	.scbd_support = true,
+	.new_scbd10_def = false,
+	.pstdma_type = COEX_PSTDMA_FORCE_LPSOFF,
+	.bt_rssi_type = COEX_BTRSSI_RATIO,
+	.ant_isolation = 15,
+	.rssi_tolerance = 2,
+	.wl_rssi_step = wl_rssi_step_8821c,
+	.bt_rssi_step = bt_rssi_step_8821c,
+	.table_sant_num = ARRAY_SIZE(table_sant_8821c),
+	.table_sant = table_sant_8821c,
+	.table_nsant_num = ARRAY_SIZE(table_nsant_8821c),
+	.table_nsant = table_nsant_8821c,
+	.tdma_sant_num = ARRAY_SIZE(tdma_sant_8821c),
+	.tdma_sant = tdma_sant_8821c,
+	.tdma_nsant_num = ARRAY_SIZE(tdma_nsant_8821c),
+	.tdma_nsant = tdma_nsant_8821c,
+	.wl_rf_para_num = ARRAY_SIZE(rf_para_tx_8821c),
+	.wl_rf_para_tx = rf_para_tx_8821c,
+	.wl_rf_para_rx = rf_para_rx_8821c,
+	.bt_afh_span_bw20 = 0x24,
+	.bt_afh_span_bw40 = 0x36,
+	.afh_5g_num = ARRAY_SIZE(afh_5g_8821c),
+	.afh_5g = afh_5g_8821c,
+
+	.coex_info_hw_regs_num = ARRAY_SIZE(coex_info_hw_regs_8821c),
+	.coex_info_hw_regs = coex_info_hw_regs_8821c,
 };
 EXPORT_SYMBOL(rtw8821c_hw_spec);
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.h b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
index 166bd0e9294e..bd01e82b6bcd 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
@@ -160,6 +160,18 @@ _rtw_write32s_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 data)
 	le32_get_bits(*((__le32 *)(phy_stat) + 0x01), GENMASK(11, 8))
 #define GET_PHY_STAT_P1_HT_RXSC(phy_stat)                                      \
 	le32_get_bits(*((__le32 *)(phy_stat) + 0x01), GENMASK(15, 12))
+#define GET_PHY_STAT_P1_RXEVM_A(phy_stat)                                      \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x04), GENMASK(7, 0))
+#define GET_PHY_STAT_P1_RXEVM_B(phy_stat)                                      \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x04), GENMASK(15, 8))
+#define GET_PHY_STAT_P1_CFO_TAIL_A(phy_stat)                                 \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x05), GENMASK(7, 0))
+#define GET_PHY_STAT_P1_CFO_TAIL_B(phy_stat)                                 \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x05), GENMASK(15, 8))
+#define GET_PHY_STAT_P1_RXSNR_A(phy_stat)                                      \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x06), GENMASK(7, 0))
+#define GET_PHY_STAT_P1_RXSNR_B(phy_stat)                                      \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x06), GENMASK(15, 8))
 
 #define REG_INIRTS_RATE_SEL 0x0480
 #define REG_HTSTFWT	0x800
@@ -217,6 +229,20 @@ _rtw_write32s_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 data)
 #define REG_CCA_CCK	0xfcc
 #define REG_ANTWT	0x1904
 #define REG_IQKFAILMSK	0x1bf0
+#define BIT_MASK_R_RFE_SEL_15	GENMASK(31, 28)
+#define BIT_SDIO_INT BIT(18)
+#define SAMPLE_RATE_MASK GENMASK(5, 0)
+#define SAMPLE_RATE	0x5
+#define BT_CNT_ENABLE	0x1
+#define BIT_BCN_QUEUE	BIT(3)
+#define BCN_PRI_EN	0x1
+#define PTA_CTRL_PIN	0x66
+#define DPDT_CTRL_PIN	0x77
+#define ANTDIC_CTRL_PIN	0x88
+#define REG_CTRL_TYPE	0x67
+#define BIT_CTRL_TYPE1	BIT(5)
+#define BIT_CTRL_TYPE2	BIT(4)
+#define CTRL_TYPE_MASK	GENMASK(15, 8)
 
 #define RF18_BAND_MASK		(BIT(16) | BIT(9) | BIT(8))
 #define RF18_BAND_2G		(0)
-- 
2.17.1

