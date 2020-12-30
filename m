Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483D62E7602
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Dec 2020 05:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgL3Ent (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Dec 2020 23:43:49 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:44480 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgL3Enr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Dec 2020 23:43:47 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0BU4h3fU5028183, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0BU4h3fU5028183
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 30 Dec 2020 12:43:03 +0800
Received: from localhost (172.21.69.213) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 30 Dec
 2020 12:43:02 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 02/18] rtw89: add BT coexistence files
Date:   Wed, 30 Dec 2020 12:42:07 +0800
Message-ID: <20201230044223.14085-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201230044223.14085-1-pkshih@realtek.com>
References: <20201230044223.14085-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

BT coexistence uses TDMA-based mechanism to coordinate with WiFi and BT.
Currently, it only set antenna statically for WiFi-only case, and full
version will be updated later.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 386 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/coex.h | 100 ++++++
 2 files changed, 486 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/coex.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/coex.h

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
new file mode 100644
index 000000000000..d211c0af16fc
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -0,0 +1,386 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2019-2020  Realtek Corporation
+ */
+
+#include "core.h"
+#include "mac.h"
+#include "coex.h"
+#include "debug.h"
+
+enum btc_phymap {
+	BTC_PHY_0 = BIT(0),
+	BTC_PHY_1 = BIT(1),
+	BTC_PHY_ALL = BIT(0) | BIT(1),
+};
+
+enum btc_cx_state_map {
+	BTC_WIDLE = 0,
+	BTC_WBUSY_BNOSCAN,
+	BTC_WBUSY_BSCAN,
+	BTC_WSCAN_BNOSCAN,
+	BTC_WSCAN_BSCAN,
+	BTC_WLINKING
+};
+
+enum btc_ant_phase {
+	BTC_ANT_WPOWERON = 0,
+	BTC_ANT_WINIT,
+	BTC_ANT_WONLY,
+	BTC_ANT_WOFF,
+	BTC_ANT_W2G,
+	BTC_ANT_W5G,
+	BTC_ANT_W25G,
+	BTC_ANT_FREERUN,
+	BTC_ANT_WRFK,
+	BTC_ANT_BRFK,
+	BTC_ANT_MAX
+};
+
+enum btc_plt {
+	BTC_PLT_NONE = 0,
+	BTC_PLT_LTE_RX = BIT(0),
+	BTC_PLT_GNT_BT_TX = BIT(1),
+	BTC_PLT_GNT_BT_RX = BIT(2),
+	BTC_PLT_GNT_WL = BIT(3),
+	BTC_PLT_BT = BIT(1) | BIT(2),
+	BTC_PLT_ALL = 0xf
+};
+
+enum btc_cx_poicy_main_type {
+	BTC_CXP_OFF = 0,
+	BTC_CXP_OFFB,
+	BTC_CXP_OFFE,
+	BTC_CXP_FIX,
+	BTC_CXP_PFIX,
+	BTC_CXP_AUTO,
+	BTC_CXP_PAUTO,
+	BTC_CXP_AUTO2,
+	BTC_CXP_PAUTO2,
+	BTC_CXP_MANUAL,
+	BTC_CXP_USERDEF0,
+	BTC_CXP_MAIN_MAX
+};
+
+enum btc_cx_poicy_type {
+	/* TDMA off + pri: BT > WL */
+	BTC_CXP_OFF_BT = (BTC_CXP_OFF << 8) | 0,
+
+	/* TDMA off + pri: WL > BT */
+	BTC_CXP_OFF_WL = (BTC_CXP_OFF << 8) | 1,
+
+	/* TDMA off + pri: BT = WL */
+	BTC_CXP_OFF_EQ0 = (BTC_CXP_OFF << 8) | 2,
+
+	/* TDMA off + pri: BT = WL > BT_Lo */
+	BTC_CXP_OFF_EQ1 = (BTC_CXP_OFF << 8) | 3,
+
+	/* TDMA off + pri: WL = BT, BT_Rx > WL_Lo_Tx */
+	BTC_CXP_OFF_EQ2 = (BTC_CXP_OFF << 8) | 4,
+
+	/* TDMA off + pri: WL_Rx = BT, BT_HI > WL_Tx > BT_Lo */
+	BTC_CXP_OFF_EQ3 = (BTC_CXP_OFF << 8) | 5,
+
+	/* TDMA off + pri: BT_Hi > WL > BT_Lo */
+	BTC_CXP_OFF_BWB0 = (BTC_CXP_OFF << 8) | 6,
+
+	/* TDMA off + pri: WL_Hi-Tx > BT_Hi_Rx, BT_Hi > WL > BT_Lo */
+	BTC_CXP_OFF_BWB1 = (BTC_CXP_OFF << 8) | 7,
+
+	/* TDMA off+Bcn-Protect + pri: WL_Hi-Tx > BT_Hi_Rx, BT_Hi > WL > BT_Lo*/
+	BTC_CXP_OFFB_BWB0 = (BTC_CXP_OFFB << 8) | 0,
+
+	/* TDMA off + Ext-Ctrl + pri: default */
+	BTC_CXP_OFFE_DEF = (BTC_CXP_OFFE << 8) | 0,
+
+	/* TDMA Fix slot-0: W1:B1 = 30:30 */
+	BTC_CXP_FIX_TD3030 = (BTC_CXP_FIX << 8) | 0,
+
+	/* TDMA Fix slot-1: W1:B1 = 50:50 */
+	BTC_CXP_FIX_TD5050 = (BTC_CXP_FIX << 8) | 1,
+
+	/* TDMA Fix slot-2: W1:B1 = 20:30 */
+	BTC_CXP_FIX_TD2030 = (BTC_CXP_FIX << 8) | 2,
+
+	/* TDMA Fix slot-3: W1:B1 = 40:10 */
+	BTC_CXP_FIX_TD4010 = (BTC_CXP_FIX << 8) | 3,
+
+	/* TDMA Fix slot-4: W1:B1 = 70:10 */
+	BTC_CXP_FIX_TD7010 = (BTC_CXP_FIX << 8) | 4,
+
+	/* TDMA Fix slot-5: W1:B1 = 20:60 */
+	BTC_CXP_FIX_TD2060 = (BTC_CXP_FIX << 8) | 5,
+
+	/* TDMA Fix slot-6: W1:B1 = 30:60 */
+	BTC_CXP_FIX_TD3060 = (BTC_CXP_FIX << 8) | 6,
+
+	/* TDMA Fix slot-6: W1:B1 = 20:80 */
+	BTC_CXP_FIX_TD2080 = (BTC_CXP_FIX << 8) | 7,
+
+	/* PS-TDMA Fix slot-0: W1:B1 = 30:30 */
+	BTC_CXP_PFIX_TD3030 = (BTC_CXP_PFIX << 8) | 0,
+
+	/* PS-TDMA Fix slot-1: W1:B1 = 50:50 */
+	BTC_CXP_PFIX_TD5050 = (BTC_CXP_PFIX << 8) | 1,
+
+	/* PS-TDMA Fix slot-2: W1:B1 = 20:30 */
+	BTC_CXP_PFIX_TD2030 = (BTC_CXP_PFIX << 8) | 2,
+
+	/* PS-TDMA Fix slot-3: W1:B1 = 20:60 */
+	BTC_CXP_PFIX_TD2060 = (BTC_CXP_PFIX << 8) | 3,
+
+	/* PS-TDMA Fix slot-4: W1:B1 = 30:70 */
+	BTC_CXP_PFIX_TD3070 = (BTC_CXP_PFIX << 8) | 4,
+
+	/* PS-TDMA Fix slot-5: W1:B1 = 20:80 */
+	BTC_CXP_PFIX_TD2080 = (BTC_CXP_PFIX << 8) | 5,
+
+	/* TDMA Auto slot-0: W1:B1 = 50:100 */
+	BTC_CXP_AUTO_TD50100 = (BTC_CXP_AUTO << 8) | 0,
+
+	/* TDMA Auto slot-1: W1:B1 = 60:150 */
+	BTC_CXP_AUTO_TD60150 = (BTC_CXP_AUTO << 8) | 1,
+
+	/* TDMA Auto slot-2: W1:B1 = 20:150 */
+	BTC_CXP_AUTO_TD20150 = (BTC_CXP_AUTO << 8) | 2,
+
+	/* PS-TDMA Auto slot-0: W1:B1 = 50:100 */
+	BTC_CXP_PAUTO_TD50100 = (BTC_CXP_PAUTO << 8) | 0,
+
+	/* PS-TDMA Auto slot-1: W1:B1 = 60:150 */
+	BTC_CXP_PAUTO_TD60150 = (BTC_CXP_PAUTO << 8) | 1,
+
+	/* PS-TDMA Auto slot-2: W1:B1 = 20:150 */
+	BTC_CXP_PAUTO_TD20150 = (BTC_CXP_PAUTO << 8) | 2,
+
+	/* TDMA Auto slot2-0: W1:B4 = 30:50 */
+	BTC_CXP_AUTO2_TD3050 = (BTC_CXP_AUTO2 << 8) | 0,
+
+	/* TDMA Auto slot2-1: W1:B4 = 30:70 */
+	BTC_CXP_AUTO2_TD3070 = (BTC_CXP_AUTO2 << 8) | 1,
+
+	/* TDMA Auto slot2-2: W1:B4 = 50:50 */
+	BTC_CXP_AUTO2_TD5050 = (BTC_CXP_AUTO2 << 8) | 2,
+
+	/* TDMA Auto slot2-3: W1:B4 = 60:60 */
+	BTC_CXP_AUTO2_TD6060 = (BTC_CXP_AUTO2 << 8) | 3,
+
+	/* TDMA Auto slot2-4: W1:B4 = 20:80 */
+	BTC_CXP_AUTO2_TD2080 = (BTC_CXP_AUTO2 << 8) | 4,
+
+	/* PS-TDMA Auto slot2-0: W1:B4 = 30:50 */
+	BTC_CXP_PAUTO2_TD3050 = (BTC_CXP_PAUTO2 << 8) | 0,
+
+	/* PS-TDMA Auto slot2-1: W1:B4 = 30:70 */
+	BTC_CXP_PAUTO2_TD3070 = (BTC_CXP_PAUTO2 << 8) | 1,
+
+	/* PS-TDMA Auto slot2-2: W1:B4 = 50:50 */
+	BTC_CXP_PAUTO2_TD5050 = (BTC_CXP_PAUTO2 << 8) | 2,
+
+	/* PS-TDMA Auto slot2-3: W1:B4 = 60:60 */
+	BTC_CXP_PAUTO2_TD6060 = (BTC_CXP_PAUTO2 << 8) | 3,
+
+	/* PS-TDMA Auto slot2-4: W1:B4 = 20:80 */
+	BTC_CXP_PAUTO2_TD2080 = (BTC_CXP_PAUTO2 << 8) | 4,
+
+	BTC_CXP_MAX = 0xffff
+};
+
+#define BTC_PHY_MAX 2
+#define BTC_CXP_MASK GENMASK(15, 8)
+
+enum btc_gnt_state {
+	BTC_GNT_HW	= 0,
+	BTC_GNT_SW_LO,
+	BTC_GNT_SW_HI,
+	BTC_GNT_MAX
+};
+
+enum btc_reason {
+	BTC_RSN_NTFY_INIT,
+	BTC_RSN_NTFY_SWBAND,
+	BTC_RSN_NUM,
+};
+
+enum btc_action {
+	BTC_ACT_WL_ONLY,
+	BTC_ACT_NUM,
+};
+
+static void _set_policy(struct rtw89_dev *rtwdev, u16 policy_type,
+			enum btc_action action)
+{
+}
+
+static void _set_gnt_wl(struct rtw89_dev *rtwdev, u8 phy_map, u8 state)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	struct rtw89_mac_ax_gnt *g = dm->gnt.band;
+	u8 i;
+
+	if (phy_map > BTC_PHY_ALL)
+		return;
+
+	for (i = 0; i < BTC_PHY_MAX; i++) {
+		if (!(phy_map & BIT(i)))
+			continue;
+
+		switch (state) {
+		case BTC_GNT_HW:
+			g[i].gnt_wl_sw_en = 0;
+			g[i].gnt_wl = 0;
+			break;
+		case BTC_GNT_SW_LO:
+			g[i].gnt_wl_sw_en = 1;
+			g[i].gnt_wl = 0;
+			break;
+		case BTC_GNT_SW_HI:
+			g[i].gnt_wl_sw_en = 1;
+			g[i].gnt_wl = 1;
+			break;
+		}
+	}
+
+	rtw89_mac_cfg_gnt(rtwdev, &dm->gnt);
+}
+
+static void _set_gnt_bt(struct rtw89_dev *rtwdev, u8 phy_map, u8 state)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	struct rtw89_mac_ax_gnt *g = dm->gnt.band;
+	u8 i;
+
+	if (phy_map > BTC_PHY_ALL)
+		return;
+
+	for (i = 0; i < BTC_PHY_MAX; i++) {
+		if (!(phy_map & BIT(i)))
+			continue;
+
+		switch (state) {
+		case BTC_GNT_HW:
+			g[i].gnt_bt_sw_en = 0;
+			g[i].gnt_bt = 0;
+			break;
+		case BTC_GNT_SW_LO:
+			g[i].gnt_bt_sw_en = 1;
+			g[i].gnt_bt = 0;
+			break;
+		case BTC_GNT_SW_HI:
+			g[i].gnt_bt_sw_en = 1;
+			g[i].gnt_bt = 1;
+			break;
+		}
+	}
+
+	rtw89_mac_cfg_gnt(rtwdev, &dm->gnt);
+}
+
+static void _set_bt_plut(struct rtw89_dev *rtwdev, u8 phy_map, u8 tx_val, u8 rx_val)
+{
+	struct rtw89_mac_ax_plt plt;
+
+	plt.band = RTW89_MAC_0;
+	plt.tx = tx_val;
+	plt.rx = rx_val;
+
+	if (phy_map & BTC_PHY_0)
+		rtw89_mac_cfg_plt(rtwdev, &plt);
+
+	if (!rtwdev->dbcc_en)
+		return;
+
+	plt.band = RTW89_MAC_1;
+	if (phy_map & BTC_PHY_1)
+		rtw89_mac_cfg_plt(rtwdev, &plt);
+}
+
+static void _set_ant(struct rtw89_dev *rtwdev, bool force_exec, u8 phy_map, u8 type)
+{
+	switch (type) {
+	case BTC_ANT_WONLY:
+		_set_gnt_wl(rtwdev, phy_map, BTC_GNT_SW_HI);
+		_set_gnt_bt(rtwdev, phy_map, BTC_GNT_SW_LO);
+		rtw89_mac_cfg_ctrl_path(rtwdev, true);
+		_set_bt_plut(rtwdev, BTC_PHY_ALL, BTC_PLT_NONE, BTC_PLT_NONE);
+		break;
+	default:
+		break;
+	}
+}
+
+static void _action_wl_only(struct rtw89_dev *rtwdev)
+{
+	_set_ant(rtwdev, FC_EXEC, BTC_PHY_ALL, BTC_ANT_WONLY);
+	_set_policy(rtwdev, BTC_CXP_OFF_BT, BTC_ACT_WL_ONLY);
+}
+
+static void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason reason)
+{
+	struct rtw89_btc_dm *dm = &rtwdev->btc.dm;
+
+	lockdep_assert_held(&rtwdev->mutex);
+
+	if (dm->wl_only)
+		_action_wl_only(rtwdev);
+}
+
+void rtw89_btc_ntfy_init(struct rtw89_dev *rtwdev, u8 mode)
+{
+	struct rtw89_btc_dm *dm = &rtwdev->btc.dm;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	dm->wl_only = mode == BTC_MODE_WL ? 1 : 0;
+
+	chip->ops->btc_set_rfe(rtwdev);
+
+	chip->ops->btc_init_cfg(rtwdev);
+
+	_run_coex(rtwdev, BTC_RSN_NTFY_INIT);
+
+	rtw89_ctrl_btg(rtwdev, true);
+}
+
+void rtw89_btc_ntfy_scan_start(struct rtw89_dev *rtwdev, u8 phy_idx, u8 band)
+{
+}
+
+void rtw89_btc_ntfy_scan_finish(struct rtw89_dev *rtwdev, u8 phy_idx)
+{
+}
+
+void rtw89_btc_ntfy_switch_band(struct rtw89_dev *rtwdev, u8 phy_idx, u8 band)
+{
+	_run_coex(rtwdev, BTC_RSN_NTFY_SWBAND);
+}
+
+static bool _ntfy_wl_rfk(struct rtw89_dev *rtwdev, u8 phy_path,
+			 enum btc_wl_rfk_type type,
+			 enum btc_wl_rfk_state state)
+{
+	return true;
+}
+
+void rtw89_btc_ntfy_wl_rfk(struct rtw89_dev *rtwdev, u8 phy_map,
+			   enum btc_wl_rfk_type type,
+			   enum btc_wl_rfk_state state)
+{
+	u8 band;
+
+	band = FIELD_GET(BTC_RFK_BAND_MAP, phy_map);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[RFK] RFK notify (%s / PHY%u / K_type = %u / path_idx = %lu / process = %s)\n",
+		    band == RTW89_BAND_2G ? "2G" :
+		    band == RTW89_BAND_5G ? "5G" : "6G",
+		    !!(FIELD_GET(BTC_RFK_PHY_MAP, phy_map) & BIT(RTW89_PHY_1)),
+		    type,
+		    FIELD_GET(BTC_RFK_PATH_MAP, phy_map),
+		    state == BTC_WRFK_STOP ? "RFK_STOP" :
+		    state == BTC_WRFK_START ? "RFK_START" :
+		    state == BTC_WRFK_ONESHOT_START ? "ONE-SHOT_START" :
+		    "ONE-SHOT_STOP");
+
+	_ntfy_wl_rfk(rtwdev, phy_map, type, state);
+}
diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
new file mode 100644
index 000000000000..ab1f057f4c9c
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2019-2020  Realtek Corporation
+ */
+
+#ifndef __RTW89_COEX_H__
+#define __RTW89_COEX_H__
+
+enum btc_mode {
+	BTC_MODE_NORMAL,
+	BTC_MODE_WL,
+	BTC_MODE_BT,
+	BTC_MODE_WLOFF,
+	BTC_MODE_MAX
+};
+
+enum btc_wl_rfk_type {
+	BTC_WRFKT_IQK = 0,
+	BTC_WRFKT_LCK = 1,
+	BTC_WRFKT_DPK = 2,
+	BTC_WRFKT_TXGAPK = 3,
+	BTC_WRFKT_DACK = 4,
+	BTC_WRFKT_RXDCK = 5,
+	BTC_WRFKT_TSSI = 6,
+};
+
+#define NM_EXEC false
+#define FC_EXEC true
+
+#define BTC_RFK_PATH_MAP GENMASK(3, 0)
+#define BTC_RFK_PHY_MAP GENMASK(5, 4)
+#define BTC_RFK_BAND_MAP GENMASK(7, 6)
+
+enum btc_wl_rfk_state {
+	BTC_WRFK_STOP = 0,
+	BTC_WRFK_START = 1,
+	BTC_WRFK_ONESHOT_START = 2,
+	BTC_WRFK_ONESHOT_STOP = 3,
+};
+
+enum btc_pri {
+	BTC_PRI_MASK_RX_RESP = 0,
+	BTC_PRI_MASK_TX_RESP,
+	BTC_PRI_MASK_BEACON,
+	BTC_PRI_MASK_RX_CCK,
+	BTC_PRI_MASK_MAX
+};
+
+enum btc_wtrs {
+	BTC_WTRX_SS_GROUP = 0x0,
+	BTC_WTRX_TX_GROUP = 0x2,
+	BTC_WTRX_RX_GROUP = 0x3,
+	BTC_WTRX_MAX,
+};
+
+enum btc_ant {
+	BTC_ANT_SHARED = 0,
+	BTC_ANT_DEDICATED,
+	BTC_ANTTYPE_MAX
+};
+
+enum btc_bt_btg {
+	BTC_BT_ALONE = 0,
+	BTC_BT_BTG
+};
+
+enum btc_switch {
+	BTC_SWITCH_INTERNAL = 0,
+	BTC_SWITCH_EXTERNAL
+};
+
+void rtw89_btc_ntfy_init(struct rtw89_dev *rtwdev, u8 mode);
+void rtw89_btc_ntfy_scan_start(struct rtw89_dev *rtwdev, u8 phy_idx, u8 band);
+void rtw89_btc_ntfy_scan_finish(struct rtw89_dev *rtwdev, u8 phy_idx);
+void rtw89_btc_ntfy_switch_band(struct rtw89_dev *rtwdev, u8 phy_idx, u8 band);
+void rtw89_btc_ntfy_wl_rfk(struct rtw89_dev *rtwdev, u8 phy_map,
+			   enum btc_wl_rfk_type type,
+			   enum btc_wl_rfk_state state);
+
+static inline u8 rtw89_btc_phymap(struct rtw89_dev *rtwdev,
+				  enum rtw89_phy_idx phy_idx,
+				  enum rtw89_rf_path_bit paths)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	u8 phy_map;
+
+	phy_map = FIELD_PREP(BTC_RFK_PATH_MAP, paths) |
+		  FIELD_PREP(BTC_RFK_PHY_MAP, BIT(phy_idx)) |
+		  FIELD_PREP(BTC_RFK_BAND_MAP, hal->current_band_type);
+
+	return phy_map;
+}
+
+static inline u8 rtw89_btc_path_phymap(struct rtw89_dev *rtwdev,
+				       enum rtw89_phy_idx phy_idx,
+				       enum rtw89_rf_path path)
+{
+	return rtw89_btc_phymap(rtwdev, phy_idx, BIT(path));
+}
+
+#endif
-- 
2.21.0

