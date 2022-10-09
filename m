Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1902B5F8B62
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Oct 2022 14:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiJIMyy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Oct 2022 08:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiJIMyp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Oct 2022 08:54:45 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43692C5F
        for <linux-wireless@vger.kernel.org>; Sun,  9 Oct 2022 05:54:39 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 299CrwdeF029524, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 299CrwdeF029524
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sun, 9 Oct 2022 20:53:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 9 Oct 2022 20:54:27 +0800
Received: from localhost (172.16.16.215) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sun, 9 Oct 2022
 20:54:27 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/9] wifi: rtw89: 8852b: add chip_ops related to BT coexistence
Date:   Sun, 9 Oct 2022 20:53:59 +0800
Message-ID: <20221009125403.19662-6-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

These chip_ops are used to assist BT coexistence module to control chip
specific operations, such as initial, pre-AGC, BT grant, set wifi priority
and tx power, RX gain, and get BT counter.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 305 ++++++++++++++++++
 2 files changed, 306 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 376ce7135b388..570fb1aee80c3 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3151,6 +3151,7 @@
 #define BTC_BREAK_PARAM 0xf0ffffff
 
 #define R_BTC_BT_COEX_MSK_TABLE 0xDA30
+#define B_BTC_PRI_MASK_RXCCK_V1 BIT(28)
 #define B_BTC_PRI_MASK_TX_RESP_V1 BIT(3)
 
 #define R_AX_BT_COEX_CFG_2 0xDA34
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 09374b92f6617..ee5a29f35db25 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -56,6 +56,44 @@ static const struct rtw89_dle_mem rtw8852b_dle_mem_pcie[] = {
 			       NULL},
 };
 
+static const struct rtw89_reg3_def rtw8852b_btc_preagc_en_defs[] = {
+	{0x46D0, GENMASK(1, 0), 0x3},
+	{0x4790, GENMASK(1, 0), 0x3},
+	{0x4AD4, GENMASK(31, 0), 0xf},
+	{0x4AE0, GENMASK(31, 0), 0xf},
+	{0x4688, GENMASK(31, 24), 0x80},
+	{0x476C, GENMASK(31, 24), 0x80},
+	{0x4694, GENMASK(7, 0), 0x80},
+	{0x4694, GENMASK(15, 8), 0x80},
+	{0x4778, GENMASK(7, 0), 0x80},
+	{0x4778, GENMASK(15, 8), 0x80},
+	{0x4AE4, GENMASK(23, 0), 0x780D1E},
+	{0x4AEC, GENMASK(23, 0), 0x780D1E},
+	{0x469C, GENMASK(31, 26), 0x34},
+	{0x49F0, GENMASK(31, 26), 0x34},
+};
+
+static DECLARE_PHY_REG3_TBL(rtw8852b_btc_preagc_en_defs);
+
+static const struct rtw89_reg3_def rtw8852b_btc_preagc_dis_defs[] = {
+	{0x46D0, GENMASK(1, 0), 0x0},
+	{0x4790, GENMASK(1, 0), 0x0},
+	{0x4AD4, GENMASK(31, 0), 0x60},
+	{0x4AE0, GENMASK(31, 0), 0x60},
+	{0x4688, GENMASK(31, 24), 0x1a},
+	{0x476C, GENMASK(31, 24), 0x1a},
+	{0x4694, GENMASK(7, 0), 0x2a},
+	{0x4694, GENMASK(15, 8), 0x2a},
+	{0x4778, GENMASK(7, 0), 0x2a},
+	{0x4778, GENMASK(15, 8), 0x2a},
+	{0x4AE4, GENMASK(23, 0), 0x79E99E},
+	{0x4AEC, GENMASK(23, 0), 0x79E99E},
+	{0x469C, GENMASK(31, 26), 0x26},
+	{0x49F0, GENMASK(31, 26), 0x26},
+};
+
+static DECLARE_PHY_REG3_TBL(rtw8852b_btc_preagc_dis_defs);
+
 static int rtw8852b_pwr_on_func(struct rtw89_dev *rtwdev)
 {
 	u32 val32;
@@ -1397,6 +1435,55 @@ rtw8852b_init_txpwr_unit(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 	return 0;
 }
 
+static void rtw8852b_bb_ctrl_btc_preagc(struct rtw89_dev *rtwdev, bool bt_en)
+{
+	rtw89_phy_write_reg3_tbl(rtwdev, bt_en ? &rtw8852b_btc_preagc_en_defs_tbl :
+						 &rtw8852b_btc_preagc_dis_defs_tbl);
+}
+
+static void rtw8852b_ctrl_btg(struct rtw89_dev *rtwdev, bool btg)
+{
+	if (btg) {
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_BT_SHARE_V1,
+				       B_PATH0_BT_SHARE_V1, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_BTG_PATH_V1,
+				       B_PATH0_BTG_PATH_V1, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_G_LNA6_OP1DB_V1,
+				       B_PATH1_G_LNA6_OP1DB_V1, 0x20);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_G_TIA0_LNA6_OP1DB_V1,
+				       B_PATH1_G_TIA0_LNA6_OP1DB_V1, 0x30);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_BT_SHARE_V1,
+				       B_PATH1_BT_SHARE_V1, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_BTG_PATH_V1,
+				       B_PATH1_BTG_PATH_V1, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_PMAC_GNT, B_PMAC_GNT_P1, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_CHBW_MOD_V1, B_BT_SHARE, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_BT_SEG0, 0x2);
+		rtw89_phy_write32_mask(rtwdev, R_BT_DYN_DC_EST_EN_V1,
+				       B_BT_DYN_DC_EST_EN_MSK, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_GNT_BT_WGT_EN, B_GNT_BT_WGT_EN, 0x1);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_BT_SHARE_V1,
+				       B_PATH0_BT_SHARE_V1, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_BTG_PATH_V1,
+				       B_PATH0_BTG_PATH_V1, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_G_LNA6_OP1DB_V1,
+				       B_PATH1_G_LNA6_OP1DB_V1, 0x1a);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_G_TIA0_LNA6_OP1DB_V1,
+				       B_PATH1_G_TIA0_LNA6_OP1DB_V1, 0x2a);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_BT_SHARE_V1,
+				       B_PATH1_BT_SHARE_V1, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_BTG_PATH_V1,
+				       B_PATH1_BTG_PATH_V1, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PMAC_GNT, B_PMAC_GNT_P1, 0xc);
+		rtw89_phy_write32_mask(rtwdev, R_CHBW_MOD_V1, B_BT_SHARE, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_BT_SEG0, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_BT_DYN_DC_EST_EN_V1,
+				       B_BT_DYN_DC_EST_EN_MSK, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_GNT_BT_WGT_EN, B_GNT_BT_WGT_EN, 0x0);
+	}
+}
+
 static u8 rtw8852b_get_thermal(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path)
 {
 	if (rtwdev->is_tssi_mode[rf_path]) {
@@ -1414,6 +1501,212 @@ static u8 rtw8852b_get_thermal(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_p
 	return rtw89_read_rf(rtwdev, rf_path, RR_TM, RR_TM_VAL);
 }
 
+static void rtw8852b_btc_set_rfe(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_module *module = &btc->mdinfo;
+
+	module->rfe_type = rtwdev->efuse.rfe_type;
+	module->cv = rtwdev->hal.cv;
+	module->bt_solo = 0;
+	module->switch_type = BTC_SWITCH_INTERNAL;
+
+	if (module->rfe_type > 0)
+		module->ant.num = module->rfe_type % 2 ? 2 : 3;
+	else
+		module->ant.num = 2;
+
+	module->ant.diversity = 0;
+	module->ant.isolation = 10;
+
+	if (module->ant.num == 3) {
+		module->ant.type = BTC_ANT_DEDICATED;
+		module->bt_pos = BTC_BT_ALONE;
+	} else {
+		module->ant.type = BTC_ANT_SHARED;
+		module->bt_pos = BTC_BT_BTG;
+	}
+}
+
+static
+void rtw8852b_set_trx_mask(struct rtw89_dev *rtwdev, u8 path, u8 group, u32 val)
+{
+	rtw89_write_rf(rtwdev, path, RR_LUTWE, RFREG_MASK, 0x20000);
+	rtw89_write_rf(rtwdev, path, RR_LUTWA, RFREG_MASK, group);
+	rtw89_write_rf(rtwdev, path, RR_LUTWD0, RFREG_MASK, val);
+	rtw89_write_rf(rtwdev, path, RR_LUTWE, RFREG_MASK, 0x0);
+}
+
+static void rtw8852b_btc_init_cfg(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_module *module = &btc->mdinfo;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_mac_ax_coex coex_params = {
+		.pta_mode = RTW89_MAC_AX_COEX_RTK_MODE,
+		.direction = RTW89_MAC_AX_COEX_INNER,
+	};
+
+	/* PTA init  */
+	rtw89_mac_coex_init(rtwdev, &coex_params);
+
+	/* set WL Tx response = Hi-Pri */
+	chip->ops->btc_set_wl_pri(rtwdev, BTC_PRI_MASK_TX_RESP, true);
+	chip->ops->btc_set_wl_pri(rtwdev, BTC_PRI_MASK_BEACON, true);
+
+	/* set rf gnt debug off */
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_WLSEL, RFREG_MASK, 0x0);
+	rtw89_write_rf(rtwdev, RF_PATH_B, RR_WLSEL, RFREG_MASK, 0x0);
+
+	/* set WL Tx thru in TRX mask table if GNT_WL = 0 && BT_S1 = ss group */
+	if (module->ant.type == BTC_ANT_SHARED) {
+		rtw8852b_set_trx_mask(rtwdev, RF_PATH_A, BTC_BT_SS_GROUP, 0x5ff);
+		rtw8852b_set_trx_mask(rtwdev, RF_PATH_B, BTC_BT_SS_GROUP, 0x5ff);
+		/* set path-A(S0) Tx/Rx no-mask if GNT_WL=0 && BT_S1=tx group */
+		rtw8852b_set_trx_mask(rtwdev, RF_PATH_A, BTC_BT_TX_GROUP, 0x5ff);
+		rtw8852b_set_trx_mask(rtwdev, RF_PATH_B, BTC_BT_TX_GROUP, 0x55f);
+	} else { /* set WL Tx stb if GNT_WL = 0 && BT_S1 = ss group for 3-ant */
+		rtw8852b_set_trx_mask(rtwdev, RF_PATH_A, BTC_BT_SS_GROUP, 0x5df);
+		rtw8852b_set_trx_mask(rtwdev, RF_PATH_B, BTC_BT_SS_GROUP, 0x5df);
+		rtw8852b_set_trx_mask(rtwdev, RF_PATH_A, BTC_BT_TX_GROUP, 0x5ff);
+		rtw8852b_set_trx_mask(rtwdev, RF_PATH_B, BTC_BT_TX_GROUP, 0x5ff);
+	}
+
+	/* set PTA break table */
+	rtw89_write32(rtwdev, R_BTC_BREAK_TABLE, BTC_BREAK_PARAM);
+
+	 /* enable BT counter 0xda40[16,2] = 2b'11 */
+	rtw89_write32_set(rtwdev, R_AX_CSR_MODE, B_AX_BT_CNT_RST | B_AX_STATIS_BT_EN);
+	btc->cx.wl.status.map.init_ok = true;
+}
+
+static
+void rtw8852b_btc_set_wl_pri(struct rtw89_dev *rtwdev, u8 map, bool state)
+{
+	u32 bitmap;
+	u32 reg;
+
+	switch (map) {
+	case BTC_PRI_MASK_TX_RESP:
+		reg = R_BTC_BT_COEX_MSK_TABLE;
+		bitmap = B_BTC_PRI_MASK_TX_RESP_V1;
+		break;
+	case BTC_PRI_MASK_BEACON:
+		reg = R_AX_WL_PRI_MSK;
+		bitmap = B_AX_PTA_WL_PRI_MASK_BCNQ;
+		break;
+	case BTC_PRI_MASK_RX_CCK:
+		reg = R_BTC_BT_COEX_MSK_TABLE;
+		bitmap = B_BTC_PRI_MASK_RXCCK_V1;
+		break;
+	default:
+		return;
+	}
+
+	if (state)
+		rtw89_write32_set(rtwdev, reg, bitmap);
+	else
+		rtw89_write32_clr(rtwdev, reg, bitmap);
+}
+
+union rtw8852b_btc_wl_txpwr_ctrl {
+	u32 txpwr_val;
+	struct {
+		union {
+			u16 ctrl_all_time;
+			struct {
+				s16 data:9;
+				u16 rsvd:6;
+				u16 flag:1;
+			} all_time;
+		};
+		union {
+			u16 ctrl_gnt_bt;
+			struct {
+				s16 data:9;
+				u16 rsvd:7;
+			} gnt_bt;
+		};
+	};
+} __packed;
+
+static void
+rtw8852b_btc_set_wl_txpwr_ctrl(struct rtw89_dev *rtwdev, u32 txpwr_val)
+{
+	union rtw8852b_btc_wl_txpwr_ctrl arg = { .txpwr_val = txpwr_val };
+	s32 val;
+
+#define __write_ctrl(_reg, _msk, _val, _en, _cond)		\
+do {								\
+	u32 _wrt = FIELD_PREP(_msk, _val);			\
+	BUILD_BUG_ON(!!(_msk & _en));				\
+	if (_cond)						\
+		_wrt |= _en;					\
+	else							\
+		_wrt &= ~_en;					\
+	rtw89_mac_txpwr_write32_mask(rtwdev, RTW89_PHY_0, _reg,	\
+				     _msk | _en, _wrt);		\
+} while (0)
+
+	switch (arg.ctrl_all_time) {
+	case 0xffff:
+		val = 0;
+		break;
+	default:
+		val = arg.all_time.data;
+		break;
+	}
+
+	__write_ctrl(R_AX_PWR_RATE_CTRL, B_AX_FORCE_PWR_BY_RATE_VALUE_MASK,
+		     val, B_AX_FORCE_PWR_BY_RATE_EN,
+		     arg.ctrl_all_time != 0xffff);
+
+	switch (arg.ctrl_gnt_bt) {
+	case 0xffff:
+		val = 0;
+		break;
+	default:
+		val = arg.gnt_bt.data;
+		break;
+	}
+
+	__write_ctrl(R_AX_PWR_COEXT_CTRL, B_AX_TXAGC_BT_MASK, val,
+		     B_AX_TXAGC_BT_EN, arg.ctrl_gnt_bt != 0xffff);
+
+#undef __write_ctrl
+}
+
+static
+s8 rtw8852b_btc_get_bt_rssi(struct rtw89_dev *rtwdev, s8 val)
+{
+	return clamp_t(s8, val, -100, 0) + 100;
+}
+
+static
+void rtw8852b_btc_update_bt_cnt(struct rtw89_dev *rtwdev)
+{
+	/* Feature move to firmware */
+}
+
+static void rtw8852b_btc_wl_s1_standby(struct rtw89_dev *rtwdev, bool state)
+{
+	rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x80000);
+	rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x1);
+	rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD1, RFREG_MASK, 0x31);
+
+	/* set WL standby = Rx for GNT_BT_Tx = 1->0 settle issue */
+	if (state)
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x579);
+	else
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x20);
+
+	rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x0);
+}
+
+static void rtw8852b_btc_set_wl_rx_gain(struct rtw89_dev *rtwdev, u32 level)
+{
+}
+
 static int rtw8852b_mac_enable_bb_rf(struct rtw89_dev *rtwdev)
 {
 	int ret;
@@ -1481,8 +1774,20 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.set_txpwr_ctrl		= rtw8852b_set_txpwr_ctrl,
 	.init_txpwr_unit	= rtw8852b_init_txpwr_unit,
 	.get_thermal		= rtw8852b_get_thermal,
+	.ctrl_btg		= rtw8852b_ctrl_btg,
+	.bb_ctrl_btc_preagc	= rtw8852b_bb_ctrl_btc_preagc,
 	.pwr_on_func		= rtw8852b_pwr_on_func,
 	.pwr_off_func		= rtw8852b_pwr_off_func,
+
+	.btc_set_rfe		= rtw8852b_btc_set_rfe,
+	.btc_init_cfg		= rtw8852b_btc_init_cfg,
+	.btc_set_wl_pri		= rtw8852b_btc_set_wl_pri,
+	.btc_set_wl_txpwr_ctrl	= rtw8852b_btc_set_wl_txpwr_ctrl,
+	.btc_get_bt_rssi	= rtw8852b_btc_get_bt_rssi,
+	.btc_update_bt_cnt	= rtw8852b_btc_update_bt_cnt,
+	.btc_wl_s1_standby	= rtw8852b_btc_wl_s1_standby,
+	.btc_set_wl_rx_gain	= rtw8852b_btc_set_wl_rx_gain,
+	.btc_set_policy		= rtw89_btc_set_policy,
 };
 
 const struct rtw89_chip_info rtw8852b_chip_info = {
-- 
2.25.1

