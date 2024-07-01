Return-Path: <linux-wireless+bounces-9744-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E18891D5D8
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 03:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB1B9B20952
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 01:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6905382;
	Mon,  1 Jul 2024 01:46:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633BB2566
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 01:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719798407; cv=none; b=twlmbE7HR8I5UfU9WZHYYfZbwl87AVyeChzZgYPMhTomi0SgkIJdrYfj9Q+fSACtz58kPdVI15V+qqUH62BgmufrHaFpT7DkV6hFiC340ckx4IVWai4kQpIGFalDECO8JAGVkL/WPi43YqI29ZZc9cOS4JG5Gi+ZosiPxPDrwrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719798407; c=relaxed/simple;
	bh=UtSgSsJwIkIHv1a5+CdAQjcMM3+gX/p/gBahPk1cRT4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uJYLeaNpSzFBqoUOO++WRAt4VdrhXJA7T+0tCzBZZJ4LA6GssXZ9sWLP6tQuXNulxJiy7c/nk87KLxg1yo8HlMTsbyDZ7d+SPqzNYWzpqcrhB2Z/W4OgTScYu5AvnwnwznE9o4FvpTSKL/EIYE2nmfJpcwSi0kpnphi9Pd6/3P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4611kd6bB3206213, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4611kd6bB3206213
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jul 2024 09:46:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 09:46:40 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 1 Jul
 2024 09:46:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/2] wifi: rtw89: 8852bx: move BTC common code from 8852b to 8852b_common
Date: Mon, 1 Jul 2024 09:46:18 +0800
Message-ID: <20240701014619.7300-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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

The BT coexistence part of 8852B and 8852BT are similar, so move shared
code into common module.

Don't change logic for existing RTL8852BE.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 173 +-----------------
 .../wireless/realtek/rtw89/rtw8852b_common.c  | 168 +++++++++++++++++
 .../wireless/realtek/rtw89/rtw8852b_common.h  |  42 +++++
 3 files changed, 216 insertions(+), 167 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 1a9c4951060a..a22847a311ad 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -633,86 +633,6 @@ static void rtw8852b_btc_set_rfe(struct rtw89_dev *rtwdev)
 	}
 }
 
-static
-void rtw8852b_set_trx_mask(struct rtw89_dev *rtwdev, u8 path, u8 group, u32 val)
-{
-	rtw89_write_rf(rtwdev, path, RR_LUTWE, RFREG_MASK, 0x20000);
-	rtw89_write_rf(rtwdev, path, RR_LUTWA, RFREG_MASK, group);
-	rtw89_write_rf(rtwdev, path, RR_LUTWD0, RFREG_MASK, val);
-	rtw89_write_rf(rtwdev, path, RR_LUTWE, RFREG_MASK, 0x0);
-}
-
-static void rtw8852b_btc_init_cfg(struct rtw89_dev *rtwdev)
-{
-	struct rtw89_btc *btc = &rtwdev->btc;
-	const struct rtw89_chip_info *chip = rtwdev->chip;
-	const struct rtw89_mac_ax_coex coex_params = {
-		.pta_mode = RTW89_MAC_AX_COEX_RTK_MODE,
-		.direction = RTW89_MAC_AX_COEX_INNER,
-	};
-
-	/* PTA init  */
-	rtw89_mac_coex_init(rtwdev, &coex_params);
-
-	/* set WL Tx response = Hi-Pri */
-	chip->ops->btc_set_wl_pri(rtwdev, BTC_PRI_MASK_TX_RESP, true);
-	chip->ops->btc_set_wl_pri(rtwdev, BTC_PRI_MASK_BEACON, true);
-
-	/* set rf gnt debug off */
-	rtw89_write_rf(rtwdev, RF_PATH_A, RR_WLSEL, RFREG_MASK, 0x0);
-	rtw89_write_rf(rtwdev, RF_PATH_B, RR_WLSEL, RFREG_MASK, 0x0);
-
-	/* set WL Tx thru in TRX mask table if GNT_WL = 0 && BT_S1 = ss group */
-	if (btc->ant_type == BTC_ANT_SHARED) {
-		rtw8852b_set_trx_mask(rtwdev, RF_PATH_A, BTC_BT_SS_GROUP, 0x5ff);
-		rtw8852b_set_trx_mask(rtwdev, RF_PATH_B, BTC_BT_SS_GROUP, 0x5ff);
-		/* set path-A(S0) Tx/Rx no-mask if GNT_WL=0 && BT_S1=tx group */
-		rtw8852b_set_trx_mask(rtwdev, RF_PATH_A, BTC_BT_TX_GROUP, 0x5ff);
-		rtw8852b_set_trx_mask(rtwdev, RF_PATH_B, BTC_BT_TX_GROUP, 0x55f);
-	} else { /* set WL Tx stb if GNT_WL = 0 && BT_S1 = ss group for 3-ant */
-		rtw8852b_set_trx_mask(rtwdev, RF_PATH_A, BTC_BT_SS_GROUP, 0x5df);
-		rtw8852b_set_trx_mask(rtwdev, RF_PATH_B, BTC_BT_SS_GROUP, 0x5df);
-		rtw8852b_set_trx_mask(rtwdev, RF_PATH_A, BTC_BT_TX_GROUP, 0x5ff);
-		rtw8852b_set_trx_mask(rtwdev, RF_PATH_B, BTC_BT_TX_GROUP, 0x5ff);
-	}
-
-	/* set PTA break table */
-	rtw89_write32(rtwdev, R_BTC_BREAK_TABLE, BTC_BREAK_PARAM);
-
-	 /* enable BT counter 0xda40[16,2] = 2b'11 */
-	rtw89_write32_set(rtwdev, R_AX_CSR_MODE, B_AX_BT_CNT_RST | B_AX_STATIS_BT_EN);
-	btc->cx.wl.status.map.init_ok = true;
-}
-
-static
-void rtw8852b_btc_set_wl_pri(struct rtw89_dev *rtwdev, u8 map, bool state)
-{
-	u32 bitmap;
-	u32 reg;
-
-	switch (map) {
-	case BTC_PRI_MASK_TX_RESP:
-		reg = R_BTC_BT_COEX_MSK_TABLE;
-		bitmap = B_BTC_PRI_MASK_TX_RESP_V1;
-		break;
-	case BTC_PRI_MASK_BEACON:
-		reg = R_AX_WL_PRI_MSK;
-		bitmap = B_AX_PTA_WL_PRI_MASK_BCNQ;
-		break;
-	case BTC_PRI_MASK_RX_CCK:
-		reg = R_BTC_BT_COEX_MSK_TABLE;
-		bitmap = B_BTC_PRI_MASK_RXCCK_V1;
-		break;
-	default:
-		return;
-	}
-
-	if (state)
-		rtw89_write32_set(rtwdev, reg, bitmap);
-	else
-		rtw89_write32_clr(rtwdev, reg, bitmap);
-}
-
 union rtw8852b_btc_wl_txpwr_ctrl {
 	u32 txpwr_val;
 	struct {
@@ -780,87 +700,6 @@ do {								\
 #undef __write_ctrl
 }
 
-static
-s8 rtw8852b_btc_get_bt_rssi(struct rtw89_dev *rtwdev, s8 val)
-{
-	/* +6 for compensate offset */
-	return clamp_t(s8, val + 6, -100, 0) + 100;
-}
-
-static
-void rtw8852b_btc_update_bt_cnt(struct rtw89_dev *rtwdev)
-{
-	/* Feature move to firmware */
-}
-
-static void rtw8852b_btc_wl_s1_standby(struct rtw89_dev *rtwdev, bool state)
-{
-	rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x80000);
-	rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x1);
-	rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD1, RFREG_MASK, 0x31);
-
-	/* set WL standby = Rx for GNT_BT_Tx = 1->0 settle issue */
-	if (state)
-		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x179);
-	else
-		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x20);
-
-	rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x0);
-}
-
-static void rtw8852b_btc_set_wl_lna2(struct rtw89_dev *rtwdev, u8 level)
-{
-	switch (level) {
-	case 0: /* default */
-		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x1000);
-		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x0);
-		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x15);
-		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x1);
-		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x17);
-		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x2);
-		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x15);
-		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x3);
-		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x17);
-		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x0);
-		break;
-	case 1: /* Fix LNA2=5  */
-		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x1000);
-		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x0);
-		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x15);
-		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x1);
-		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x5);
-		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x2);
-		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x15);
-		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x3);
-		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x5);
-		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x0);
-		break;
-	}
-}
-
-static void rtw8852b_btc_set_wl_rx_gain(struct rtw89_dev *rtwdev, u32 level)
-{
-	struct rtw89_btc *btc = &rtwdev->btc;
-
-	switch (level) {
-	case 0: /* original */
-	default:
-		rtw8852bx_ctrl_nbtg_bt_tx(rtwdev, false, RTW89_PHY_0);
-		btc->dm.wl_lna2 = 0;
-		break;
-	case 1: /* for FDD free-run */
-		rtw8852bx_ctrl_nbtg_bt_tx(rtwdev, true, RTW89_PHY_0);
-		btc->dm.wl_lna2 = 0;
-		break;
-	case 2: /* for BTG Co-Rx*/
-		rtw8852bx_ctrl_nbtg_bt_tx(rtwdev, false, RTW89_PHY_0);
-		btc->dm.wl_lna2 = 1;
-		break;
-	}
-
-	rtw8852b_btc_set_wl_lna2(rtwdev, btc->dm.wl_lna2);
-}
-
 static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.enable_bb_rf		= rtw8852bx_mac_enable_bb_rf,
 	.disable_bb_rf		= rtw8852bx_mac_disable_bb_rf,
@@ -911,13 +750,13 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
 
 	.btc_set_rfe		= rtw8852b_btc_set_rfe,
-	.btc_init_cfg		= rtw8852b_btc_init_cfg,
-	.btc_set_wl_pri		= rtw8852b_btc_set_wl_pri,
+	.btc_init_cfg		= rtw8852bx_btc_init_cfg,
+	.btc_set_wl_pri		= rtw8852bx_btc_set_wl_pri,
 	.btc_set_wl_txpwr_ctrl	= rtw8852b_btc_set_wl_txpwr_ctrl,
-	.btc_get_bt_rssi	= rtw8852b_btc_get_bt_rssi,
-	.btc_update_bt_cnt	= rtw8852b_btc_update_bt_cnt,
-	.btc_wl_s1_standby	= rtw8852b_btc_wl_s1_standby,
-	.btc_set_wl_rx_gain	= rtw8852b_btc_set_wl_rx_gain,
+	.btc_get_bt_rssi	= rtw8852bx_btc_get_bt_rssi,
+	.btc_update_bt_cnt	= rtw8852bx_btc_update_bt_cnt,
+	.btc_wl_s1_standby	= rtw8852bx_btc_wl_s1_standby,
+	.btc_set_wl_rx_gain	= rtw8852bx_btc_set_wl_rx_gain,
 	.btc_set_policy		= rtw89_btc_set_policy_v1,
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
index 60e9bd5b1376..f183dce16398 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2024  Realtek Corporation
  */
 
+#include "coex.h"
 #include "debug.h"
 #include "mac.h"
 #include "phy.h"
@@ -1749,6 +1750,167 @@ static u8 __rtw8852bx_get_thermal(struct rtw89_dev *rtwdev, enum rtw89_rf_path r
 	return rtw89_read_rf(rtwdev, rf_path, RR_TM, RR_TM_VAL);
 }
 
+static
+void rtw8852bx_set_trx_mask(struct rtw89_dev *rtwdev, u8 path, u8 group, u32 val)
+{
+	rtw89_write_rf(rtwdev, path, RR_LUTWE, RFREG_MASK, 0x20000);
+	rtw89_write_rf(rtwdev, path, RR_LUTWA, RFREG_MASK, group);
+	rtw89_write_rf(rtwdev, path, RR_LUTWD0, RFREG_MASK, val);
+	rtw89_write_rf(rtwdev, path, RR_LUTWE, RFREG_MASK, 0x0);
+}
+
+static void __rtw8852bx_btc_init_cfg(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
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
+	if (btc->ant_type == BTC_ANT_SHARED) {
+		rtw8852bx_set_trx_mask(rtwdev, RF_PATH_A, BTC_BT_SS_GROUP, 0x5ff);
+		rtw8852bx_set_trx_mask(rtwdev, RF_PATH_B, BTC_BT_SS_GROUP, 0x5ff);
+		/* set path-A(S0) Tx/Rx no-mask if GNT_WL=0 && BT_S1=tx group */
+		rtw8852bx_set_trx_mask(rtwdev, RF_PATH_A, BTC_BT_TX_GROUP, 0x5ff);
+		rtw8852bx_set_trx_mask(rtwdev, RF_PATH_B, BTC_BT_TX_GROUP, 0x55f);
+	} else { /* set WL Tx stb if GNT_WL = 0 && BT_S1 = ss group for 3-ant */
+		rtw8852bx_set_trx_mask(rtwdev, RF_PATH_A, BTC_BT_SS_GROUP, 0x5df);
+		rtw8852bx_set_trx_mask(rtwdev, RF_PATH_B, BTC_BT_SS_GROUP, 0x5df);
+		rtw8852bx_set_trx_mask(rtwdev, RF_PATH_A, BTC_BT_TX_GROUP, 0x5ff);
+		rtw8852bx_set_trx_mask(rtwdev, RF_PATH_B, BTC_BT_TX_GROUP, 0x5ff);
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
+void __rtw8852bx_btc_set_wl_pri(struct rtw89_dev *rtwdev, u8 map, bool state)
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
+static
+s8 __rtw8852bx_btc_get_bt_rssi(struct rtw89_dev *rtwdev, s8 val)
+{
+	/* +6 for compensate offset */
+	return clamp_t(s8, val + 6, -100, 0) + 100;
+}
+
+static
+void __rtw8852bx_btc_update_bt_cnt(struct rtw89_dev *rtwdev)
+{
+	/* Feature move to firmware */
+}
+
+static void __rtw8852bx_btc_wl_s1_standby(struct rtw89_dev *rtwdev, bool state)
+{
+	rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x80000);
+	rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x1);
+	rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD1, RFREG_MASK, 0x31);
+
+	/* set WL standby = Rx for GNT_BT_Tx = 1->0 settle issue */
+	if (state)
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x179);
+	else
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x20);
+
+	rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x0);
+}
+
+static void rtw8852bx_btc_set_wl_lna2(struct rtw89_dev *rtwdev, u8 level)
+{
+	switch (level) {
+	case 0: /* default */
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x1000);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x0);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x15);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x1);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x17);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x2);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x15);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x3);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x17);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x0);
+		break;
+	case 1: /* Fix LNA2=5  */
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x1000);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x0);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x15);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x1);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x5);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x2);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x15);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x3);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x5);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x0);
+		break;
+	}
+}
+
+static void __rtw8852bx_btc_set_wl_rx_gain(struct rtw89_dev *rtwdev, u32 level)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+
+	switch (level) {
+	case 0: /* original */
+	default:
+		rtw8852bx_ctrl_nbtg_bt_tx(rtwdev, false, RTW89_PHY_0);
+		btc->dm.wl_lna2 = 0;
+		break;
+	case 1: /* for FDD free-run */
+		rtw8852bx_ctrl_nbtg_bt_tx(rtwdev, true, RTW89_PHY_0);
+		btc->dm.wl_lna2 = 0;
+		break;
+	case 2: /* for BTG Co-Rx*/
+		rtw8852bx_ctrl_nbtg_bt_tx(rtwdev, false, RTW89_PHY_0);
+		btc->dm.wl_lna2 = 1;
+		break;
+	}
+
+	rtw8852bx_btc_set_wl_lna2(rtwdev, btc->dm.wl_lna2);
+}
+
 static void rtw8852bx_fill_freq_with_ppdu(struct rtw89_dev *rtwdev,
 					  struct rtw89_rx_phy_ppdu *phy_ppdu,
 					  struct ieee80211_rx_status *status)
@@ -1872,6 +2034,12 @@ const struct rtw8852bx_info rtw8852bx_info = {
 	.set_txpwr_ul_tb_offset = __rtw8852bx_set_txpwr_ul_tb_offset,
 	.get_thermal = __rtw8852bx_get_thermal,
 	.adc_cfg = rtw8852bt_adc_cfg,
+	.btc_init_cfg = __rtw8852bx_btc_init_cfg,
+	.btc_set_wl_pri = __rtw8852bx_btc_set_wl_pri,
+	.btc_get_bt_rssi = __rtw8852bx_btc_get_bt_rssi,
+	.btc_update_bt_cnt = __rtw8852bx_btc_update_bt_cnt,
+	.btc_wl_s1_standby = __rtw8852bx_btc_wl_s1_standby,
+	.btc_set_wl_rx_gain = __rtw8852bx_btc_set_wl_rx_gain,
 };
 EXPORT_SYMBOL(rtw8852bx_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.h b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.h
index b8e3f20ba189..801e7ab9f4fa 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.h
@@ -159,6 +159,12 @@ struct rtw8852bx_info {
 				       s8 pw_ofst, enum rtw89_mac_idx mac_idx);
 	u8 (*get_thermal)(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path);
 	void (*adc_cfg)(struct rtw89_dev *rtwdev, u8 bw, u8 path);
+	void (*btc_init_cfg)(struct rtw89_dev *rtwdev);
+	void (*btc_set_wl_pri)(struct rtw89_dev *rtwdev, u8 map, bool state);
+	s8 (*btc_get_bt_rssi)(struct rtw89_dev *rtwdev, s8 val);
+	void (*btc_update_bt_cnt)(struct rtw89_dev *rtwdev);
+	void (*btc_wl_s1_standby)(struct rtw89_dev *rtwdev, bool state);
+	void (*btc_set_wl_rx_gain)(struct rtw89_dev *rtwdev, u32 level);
 };
 
 extern const struct rtw8852bx_info rtw8852bx_info;
@@ -343,4 +349,40 @@ void rtw8852bx_adc_cfg(struct rtw89_dev *rtwdev, u8 bw, u8 path)
 	rtw8852bx_info.adc_cfg(rtwdev, bw, path);
 }
 
+static inline
+void rtw8852bx_btc_init_cfg(struct rtw89_dev *rtwdev)
+{
+	rtw8852bx_info.btc_init_cfg(rtwdev);
+}
+
+static inline
+void rtw8852bx_btc_set_wl_pri(struct rtw89_dev *rtwdev, u8 map, bool state)
+{
+	rtw8852bx_info.btc_set_wl_pri(rtwdev, map, state);
+}
+
+static inline
+s8 rtw8852bx_btc_get_bt_rssi(struct rtw89_dev *rtwdev, s8 val)
+{
+	return rtw8852bx_info.btc_get_bt_rssi(rtwdev, val);
+}
+
+static inline
+void rtw8852bx_btc_update_bt_cnt(struct rtw89_dev *rtwdev)
+{
+	rtw8852bx_info.btc_update_bt_cnt(rtwdev);
+}
+
+static inline
+void rtw8852bx_btc_wl_s1_standby(struct rtw89_dev *rtwdev, bool state)
+{
+	rtw8852bx_info.btc_wl_s1_standby(rtwdev, state);
+}
+
+static inline
+void rtw8852bx_btc_set_wl_rx_gain(struct rtw89_dev *rtwdev, u32 level)
+{
+	rtw8852bx_info.btc_set_wl_rx_gain(rtwdev, level);
+}
+
 #endif
-- 
2.25.1


