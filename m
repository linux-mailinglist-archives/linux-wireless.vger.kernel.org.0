Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA79C1CF246
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2020 12:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbgELK0z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 May 2020 06:26:55 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:36521 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729378AbgELK0g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 May 2020 06:26:36 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04CAQPYh8009505, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04CAQPYh8009505
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 May 2020 18:26:25 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 12 May 2020 18:26:25 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 12 May 2020 18:26:24 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <bigeasy@linutronix.de>
Subject: [PATCH v3 7/9] rtw88: 8723d: Add coex support
Date:   Tue, 12 May 2020 18:26:19 +0800
Message-ID: <20200512102621.5148-8-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512102621.5148-1-yhchuang@realtek.com>
References: <20200512102621.5148-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

8723D is a Wifi+BT combo card. To make them work properly, we need coex
mechanism to avoid interference, such as TX simultaneously. Basically,
coex.c provide main algorithm to deal with many use cases, and this commit
adds some parameters and ops differ from other chips, because coex
hardware and WiFi generation are changed.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 327 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.h |   3 +
 2 files changed, 330 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index e3dc27d6a6ad..400364aec393 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -1497,6 +1497,132 @@ static void rtw8723d_phy_calibration(struct rtw_dev *rtwdev)
 	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] finished\n");
 }
 
+/* for coex */
+static void rtw8723d_coex_cfg_init(struct rtw_dev *rtwdev)
+{
+	/* enable TBTT nterrupt */
+	rtw_write8_set(rtwdev, REG_BCN_CTRL, BIT_EN_BCN_FUNCTION);
+
+	/* BT report packet sample rate	 */
+	/* 0x790[5:0]=0x5 */
+	rtw_write8_set(rtwdev, REG_BT_TDMA_TIME, 0x05);
+
+	/* enable BT counter statistics */
+	rtw_write8(rtwdev, REG_BT_STAT_CTRL, 0x1);
+
+	/* enable PTA (3-wire function form BT side) */
+	rtw_write32_set(rtwdev, REG_GPIO_MUXCFG, BIT_BT_PTA_EN);
+	rtw_write32_set(rtwdev, REG_GPIO_MUXCFG, BIT_BT_AOD_GPIO3);
+
+	/* enable PTA (tx/rx signal form WiFi side) */
+	rtw_write8_set(rtwdev, REG_QUEUE_CTRL, BIT_PTA_WL_TX_EN);
+}
+
+static void rtw8723d_coex_cfg_gnt_fix(struct rtw_dev *rtwdev)
+{
+}
+
+static void rtw8723d_coex_cfg_gnt_debug(struct rtw_dev *rtwdev)
+{
+	rtw_write8_mask(rtwdev, REG_LEDCFG2, BIT(6), 0);
+	rtw_write8_mask(rtwdev, REG_PAD_CTRL1 + 3, BIT(0), 0);
+	rtw_write8_mask(rtwdev, REG_GPIO_INTM + 2, BIT(4), 0);
+	rtw_write8_mask(rtwdev, REG_GPIO_MUXCFG + 2, BIT(1), 0);
+	rtw_write8_mask(rtwdev, REG_PAD_CTRL1 + 3, BIT(1), 0);
+	rtw_write8_mask(rtwdev, REG_PAD_CTRL1 + 2, BIT(7), 0);
+	rtw_write8_mask(rtwdev, REG_SYS_CLKR + 1, BIT(1), 0);
+	rtw_write8_mask(rtwdev, REG_SYS_SDIO_CTRL + 3, BIT(3), 0);
+}
+
+static void rtw8723d_coex_cfg_rfe_type(struct rtw_dev *rtwdev)
+{
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_rfe *coex_rfe = &coex->rfe;
+	bool aux = efuse->bt_setting & BIT(6);
+
+	coex_rfe->rfe_module_type = rtwdev->efuse.rfe_option;
+	coex_rfe->ant_switch_polarity = 0;
+	coex_rfe->ant_switch_exist = false;
+	coex_rfe->ant_switch_with_bt = false;
+	coex_rfe->ant_switch_diversity = false;
+	coex_rfe->wlg_at_btg = true;
+
+	/* decide antenna at main or aux */
+	if (efuse->share_ant) {
+		if (aux)
+			rtw_write16(rtwdev, REG_BB_SEL_BTG, 0x80);
+		else
+			rtw_write16(rtwdev, REG_BB_SEL_BTG, 0x200);
+	} else {
+		if (aux)
+			rtw_write16(rtwdev, REG_BB_SEL_BTG, 0x280);
+		else
+			rtw_write16(rtwdev, REG_BB_SEL_BTG, 0x0);
+	}
+
+	/* disable LTE coex in wifi side */
+	rtw_coex_write_indirect_reg(rtwdev, LTE_COEX_CTRL, BIT_LTE_COEX_EN, 0x0);
+	rtw_coex_write_indirect_reg(rtwdev, LTE_WL_TRX_CTRL, MASKLWORD, 0xffff);
+	rtw_coex_write_indirect_reg(rtwdev, LTE_BT_TRX_CTRL, MASKLWORD, 0xffff);
+}
+
+static void rtw8723d_coex_cfg_wl_tx_power(struct rtw_dev *rtwdev, u8 wl_pwr)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
+	static const u8	wl_tx_power[] = {0xb2, 0x90};
+	u8 pwr;
+
+	if (wl_pwr == coex_dm->cur_wl_pwr_lvl)
+		return;
+
+	coex_dm->cur_wl_pwr_lvl = wl_pwr;
+
+	if (coex_dm->cur_wl_pwr_lvl >= ARRAY_SIZE(wl_tx_power))
+		coex_dm->cur_wl_pwr_lvl = ARRAY_SIZE(wl_tx_power) - 1;
+
+	pwr = wl_tx_power[coex_dm->cur_wl_pwr_lvl];
+
+	rtw_write8(rtwdev, REG_ANA_PARAM1 + 3, pwr);
+}
+
+static void rtw8723d_coex_cfg_wl_rx_gain(struct rtw_dev *rtwdev, bool low_gain)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_dm *coex_dm = &coex->dm;
+	/* WL Rx Low gain on */
+	static const u32 wl_rx_low_gain_on[] = {
+		0xec120101, 0xeb130101, 0xce140101, 0xcd150101, 0xcc160101,
+		0xcb170101, 0xca180101, 0x8d190101, 0x8c1a0101, 0x8b1b0101,
+		0x4f1c0101, 0x4e1d0101, 0x4d1e0101, 0x4c1f0101, 0x0e200101,
+		0x0d210101, 0x0c220101, 0x0b230101, 0xcf240001, 0xce250001,
+		0xcd260001, 0xcc270001, 0x8f280001
+	};
+	/* WL Rx Low gain off */
+	static const u32 wl_rx_low_gain_off[] = {
+		0xec120101, 0xeb130101, 0xea140101, 0xe9150101, 0xe8160101,
+		0xe7170101, 0xe6180101, 0xe5190101, 0xe41a0101, 0xe31b0101,
+		0xe21c0101, 0xe11d0101, 0xe01e0101, 0x861f0101, 0x85200101,
+		0x84210101, 0x83220101, 0x82230101, 0x81240101, 0x80250101,
+		0x44260101, 0x43270101, 0x42280101
+	};
+	u8 i;
+
+	if (low_gain == coex_dm->cur_wl_rx_low_gain_en)
+		return;
+
+	coex_dm->cur_wl_rx_low_gain_en = low_gain;
+
+	if (coex_dm->cur_wl_rx_low_gain_en) {
+		for (i = 0; i < ARRAY_SIZE(wl_rx_low_gain_on); i++)
+			rtw_write32(rtwdev, REG_AGCRSSI, wl_rx_low_gain_on[i]);
+	} else {
+		for (i = 0; i < ARRAY_SIZE(wl_rx_low_gain_off); i++)
+			rtw_write32(rtwdev, REG_AGCRSSI, wl_rx_low_gain_off[i]);
+	}
+}
+
 static u8 rtw8723d_pwrtrack_get_limit_ofdm(struct rtw_dev *rtwdev)
 {
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
@@ -1808,6 +1934,156 @@ static struct rtw_chip_ops rtw8723d_ops = {
 	.config_bfee		= NULL,
 	.set_gid_table		= NULL,
 	.cfg_csi_rate		= NULL,
+
+	.coex_set_init		= rtw8723d_coex_cfg_init,
+	.coex_set_ant_switch	= NULL,
+	.coex_set_gnt_fix	= rtw8723d_coex_cfg_gnt_fix,
+	.coex_set_gnt_debug	= rtw8723d_coex_cfg_gnt_debug,
+	.coex_set_rfe_type	= rtw8723d_coex_cfg_rfe_type,
+	.coex_set_wl_tx_power	= rtw8723d_coex_cfg_wl_tx_power,
+	.coex_set_wl_rx_gain	= rtw8723d_coex_cfg_wl_rx_gain,
+};
+
+/* Shared-Antenna Coex Table */
+static const struct coex_table_para table_sant_8723d[] = {
+	{0xffffffff, 0xffffffff}, /* case-0 */
+	{0x55555555, 0x55555555},
+	{0x65555555, 0x65555555},
+	{0xaaaaaaaa, 0xaaaaaaaa},
+	{0x5a5a5a5a, 0x5a5a5a5a},
+	{0xfafafafa, 0xfafafafa}, /* case-5 */
+	{0xa5555555, 0xaaaa5aaa},
+	{0x6a5a5a5a, 0x5a5a5a5a},
+	{0x6a5a5a5a, 0x6a5a5a5a},
+	{0x65555555, 0x5a5a5a5a},
+	{0x65555555, 0x6a5a5a5a}, /* case-10 */
+	{0x65555555, 0xfafafafa},
+	{0x65555555, 0x6a5a5aaa},
+	{0x65555555, 0x5aaa5aaa},
+	{0x65555555, 0xaaaa5aaa},
+	{0x65555555, 0xaaaaaaaa}, /* case-15 */
+	{0xffff55ff, 0xfafafafa},
+	{0xffff55ff, 0x6afa5afa},
+	{0xaaffffaa, 0xfafafafa},
+	{0xaa5555aa, 0x5a5a5a5a},
+	{0xaa5555aa, 0x6a5a5a5a}, /* case-20 */
+	{0xaa5555aa, 0xaaaaaaaa},
+	{0xffffffff, 0x5a5a5a5a},
+	{0xffffffff, 0x6a5a5a5a},
+	{0xffffffff, 0x55555555},
+	{0xffffffff, 0x6a5a5aaa}, /* case-25 */
+	{0x55555555, 0x5a5a5a5a},
+	{0x55555555, 0xaaaaaaaa},
+	{0x55555555, 0x6a6a6a6a},
+	{0x656a656a, 0x656a656a}
+};
+
+/* Non-Shared-Antenna Coex Table */
+static const struct coex_table_para table_nsant_8723d[] = {
+	{0xffffffff, 0xffffffff}, /* case-100 */
+	{0x55555555, 0x55555555},
+	{0x65555555, 0x65555555},
+	{0xaaaaaaaa, 0xaaaaaaaa},
+	{0x5a5a5a5a, 0x5a5a5a5a},
+	{0xfafafafa, 0xfafafafa}, /* case-105 */
+	{0x5afa5afa, 0x5afa5afa},
+	{0x55555555, 0xfafafafa},
+	{0x65555555, 0xfafafafa},
+	{0x65555555, 0x5a5a5a5a},
+	{0x65555555, 0x6a5a5a5a}, /* case-110 */
+	{0x65555555, 0xaaaaaaaa},
+	{0xffff55ff, 0xfafafafa},
+	{0xffff55ff, 0x5afa5afa},
+	{0xffff55ff, 0xaaaaaaaa},
+	{0xaaffffaa, 0xfafafafa}, /* case-115 */
+	{0xaaffffaa, 0x5afa5afa},
+	{0xaaffffaa, 0xaaaaaaaa},
+	{0xffffffff, 0xfafafafa},
+	{0xffffffff, 0x5afa5afa},
+	{0xffffffff, 0xaaaaaaaa},/* case-120 */
+	{0x55ff55ff, 0x5afa5afa},
+	{0x55ff55ff, 0xaaaaaaaa},
+	{0x55ff55ff, 0x55ff55ff}
+};
+
+/* Shared-Antenna TDMA */
+static const struct coex_tdma_para tdma_sant_8723d[] = {
+	{ {0x08, 0x00, 0x00, 0x00, 0x00} }, /* case-0 */
+	{ {0x61, 0x45, 0x03, 0x11, 0x11} }, /* case-1 */
+	{ {0x61, 0x3a, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x20, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x30, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x10, 0x03, 0x11, 0x11} }, /* case-5 */
+	{ {0x61, 0x48, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x3a, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x30, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x20, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x10, 0x03, 0x11, 0x10} }, /* case-10 */
+	{ {0x61, 0x10, 0x03, 0x11, 0x14} },
+	{ {0x61, 0x08, 0x03, 0x10, 0x14} },
+	{ {0x51, 0x10, 0x03, 0x10, 0x54} },
+	{ {0x51, 0x10, 0x03, 0x10, 0x55} },
+	{ {0x51, 0x10, 0x07, 0x10, 0x54} }, /* case-15 */
+	{ {0x51, 0x45, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x3a, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x30, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x20, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x15, 0x03, 0x10, 0x50} }, /* case-20 */
+	{ {0x51, 0x4a, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x0c, 0x03, 0x10, 0x54} },
+	{ {0x55, 0x08, 0x03, 0x10, 0x54} },
+	{ {0x65, 0x10, 0x03, 0x11, 0x11} },
+	{ {0x51, 0x10, 0x03, 0x10, 0x51} },
+	{ {0x61, 0x15, 0x03, 0x11, 0x10} }
+};
+
+/* Non-Shared-Antenna TDMA */
+static const struct coex_tdma_para tdma_nsant_8723d[] = {
+	{ {0x00, 0x00, 0x00, 0x40, 0x00} }, /* case-100 */
+	{ {0x61, 0x45, 0x03, 0x11, 0x11} }, /* case-101 */
+	{ {0x61, 0x3a, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x30, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x20, 0x03, 0x11, 0x11} },
+	{ {0x61, 0x10, 0x03, 0x11, 0x11} }, /* case-105 */
+	{ {0x61, 0x45, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x3a, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x30, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x20, 0x03, 0x11, 0x10} },
+	{ {0x61, 0x10, 0x03, 0x11, 0x10} }, /* case-110 */
+	{ {0x61, 0x08, 0x03, 0x11, 0x14} },
+	{ {0x61, 0x08, 0x03, 0x10, 0x14} },
+	{ {0x51, 0x08, 0x03, 0x10, 0x54} },
+	{ {0x51, 0x08, 0x03, 0x10, 0x55} },
+	{ {0x51, 0x08, 0x07, 0x10, 0x54} }, /* case-115 */
+	{ {0x51, 0x45, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x3a, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x30, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x20, 0x03, 0x10, 0x50} },
+	{ {0x51, 0x10, 0x03, 0x10, 0x50} }
+};
+
+/* rssi in percentage % (dbm = % - 100) */
+static const u8 wl_rssi_step_8723d[] = {60, 50, 44, 30};
+static const u8 bt_rssi_step_8723d[] = {30, 30, 30, 30};
+static const struct coex_5g_afh_map afh_5g_8723d[] = { {0, 0, 0} };
+
+/* wl_tx_dec_power, bt_tx_dec_power, wl_rx_gain, bt_rx_lna_constrain */
+static const struct coex_rf_para rf_para_tx_8723d[] = {
+	{0, 0, false, 7},  /* for normal */
+	{0, 10, false, 7}, /* for WL-CPT */
+	{1, 0, true, 4},
+	{1, 2, true, 4},
+	{1, 10, true, 4},
+	{1, 15, true, 4}
+};
+
+static const struct coex_rf_para rf_para_rx_8723d[] = {
+	{0, 0, false, 7},  /* for normal */
+	{0, 10, false, 7}, /* for WL-CPT */
+	{1, 0, true, 5},
+	{1, 2, true, 5},
+	{1, 10, true, 5},
+	{1, 15, true, 5}
 };
 
 static const struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8723d[] = {
@@ -2363,6 +2639,28 @@ static const struct rtw_pwr_track_tbl rtw8723d_rtw_pwr_track_tbl = {
 	.pwrtrk_xtal_n = rtw8723d_pwrtrk_xtal_n,
 };
 
+static const struct rtw_reg_domain coex_info_hw_regs_8723d[] = {
+	{0x948, MASKDWORD, RTW_REG_DOMAIN_MAC32},
+	{0x67, BIT(7), RTW_REG_DOMAIN_MAC8},
+	{0, 0, RTW_REG_DOMAIN_NL},
+	{0x964, BIT(1), RTW_REG_DOMAIN_MAC8},
+	{0x864, BIT(0), RTW_REG_DOMAIN_MAC8},
+	{0xab7, BIT(5), RTW_REG_DOMAIN_MAC8},
+	{0xa01, BIT(7), RTW_REG_DOMAIN_MAC8},
+	{0, 0, RTW_REG_DOMAIN_NL},
+	{0x430, MASKDWORD, RTW_REG_DOMAIN_MAC32},
+	{0x434, MASKDWORD, RTW_REG_DOMAIN_MAC32},
+	{0x42a, MASKLWORD, RTW_REG_DOMAIN_MAC16},
+	{0x426, MASKBYTE0, RTW_REG_DOMAIN_MAC8},
+	{0x45e, BIT(3), RTW_REG_DOMAIN_MAC8},
+	{0, 0, RTW_REG_DOMAIN_NL},
+	{0x4c6, BIT(4), RTW_REG_DOMAIN_MAC8},
+	{0x40, BIT(5), RTW_REG_DOMAIN_MAC8},
+	{0x550, MASKDWORD, RTW_REG_DOMAIN_MAC32},
+	{0x522, MASKBYTE0, RTW_REG_DOMAIN_MAC8},
+	{0x953, BIT(1), RTW_REG_DOMAIN_MAC8},
+};
+
 struct rtw_chip_info rtw8723d_hw_spec = {
 	.ops = &rtw8723d_ops,
 	.id = RTW_CHIP_TYPE_8723D,
@@ -2409,6 +2707,35 @@ struct rtw_chip_info rtw8723d_hw_spec = {
 	.rx_ldpc = false,
 	.pwr_track_tbl = &rtw8723d_rtw_pwr_track_tbl,
 	.iqk_threshold = 8,
+
+	.coex_para_ver = 0x1905302f,
+	.bt_desired_ver = 0x2f,
+	.scbd_support = true,
+	.new_scbd10_def = true,
+	.pstdma_type = COEX_PSTDMA_FORCE_LPSOFF,
+	.bt_rssi_type = COEX_BTRSSI_RATIO,
+	.ant_isolation = 15,
+	.rssi_tolerance = 2,
+	.wl_rssi_step = wl_rssi_step_8723d,
+	.bt_rssi_step = bt_rssi_step_8723d,
+	.table_sant_num = ARRAY_SIZE(table_sant_8723d),
+	.table_sant = table_sant_8723d,
+	.table_nsant_num = ARRAY_SIZE(table_nsant_8723d),
+	.table_nsant = table_nsant_8723d,
+	.tdma_sant_num = ARRAY_SIZE(tdma_sant_8723d),
+	.tdma_sant = tdma_sant_8723d,
+	.tdma_nsant_num = ARRAY_SIZE(tdma_nsant_8723d),
+	.tdma_nsant = tdma_nsant_8723d,
+	.wl_rf_para_num = ARRAY_SIZE(rf_para_tx_8723d),
+	.wl_rf_para_tx = rf_para_tx_8723d,
+	.wl_rf_para_rx = rf_para_rx_8723d,
+	.bt_afh_span_bw20 = 0x20,
+	.bt_afh_span_bw40 = 0x30,
+	.afh_5g_num = ARRAY_SIZE(afh_5g_8723d),
+	.afh_5g = afh_5g_8723d,
+
+	.coex_info_hw_regs_num = ARRAY_SIZE(coex_info_hw_regs_8723d),
+	.coex_info_hw_regs = coex_info_hw_regs_8723d,
 };
 EXPORT_SYMBOL(rtw8723d_hw_spec);
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.h b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
index d1f1c1a594ad..31b8ed9ee652 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
@@ -143,6 +143,7 @@ static inline s32 iqk_mult(s32 x, s32 y, s32 *ext)
 #define BIT_MASK_RFMOD		BIT(0)
 #define BIT_LCK			BIT(15)
 
+#define REG_GPIO_INTM		0x0048
 #define REG_BTG_SEL		0x0067
 #define REG_LTECOEX_PATH_CONTROL	0x0070
 #define REG_LTECOEX_CTRL	0x07c0
@@ -150,6 +151,7 @@ static inline s32 iqk_mult(s32 x, s32 y, s32 *ext)
 #define REG_LTECOEX_READ_DATA	0x07c8
 #define REG_PSDFN		0x0808
 #define REG_BB_PWR_SAV1_11N	0x0874
+#define REG_ANA_PARAM1		0x0880
 #define REG_ANALOG_P4		0x088c
 #define REG_PSDRPT		0x08b4
 #define REG_FPGA1_RFMOD		0x0900
@@ -192,6 +194,7 @@ static inline s32 iqk_mult(s32 x, s32 y, s32 *ext)
 #define BIT_SET_OFDM0_EXTS(a, c, d) (((a) << 31) | ((c) << 29) | ((d) << 28))
 #define REG_OFDM0_XAAGC1	0x0c50
 #define REG_OFDM0_XBAGC1	0x0c58
+#define REG_AGCRSSI		0x0c78
 #define REG_OFDM_0_XA_TX_IQ_IMBALANCE	0x0c80
 #define BIT_MASK_TXIQ_ELM_A	0x03ff
 #define BIT_SET_TXIQ_ELM_ACD(a, c, d) (((d) << 22) | (((c) & 0x3F) << 16) |    \
-- 
2.17.1

