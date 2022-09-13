Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B8D5B6AA7
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Sep 2022 11:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiIMJ1I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Sep 2022 05:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiIMJ1H (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Sep 2022 05:27:07 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AEAF286D5
        for <linux-wireless@vger.kernel.org>; Tue, 13 Sep 2022 02:27:03 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28D9QZZm8005713, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28D9QZZm8005713
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 13 Sep 2022 17:26:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 13 Sep 2022 17:26:56 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 13 Sep
 2022 17:26:55 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 7/7] wifi: rtw89: coex: Combine set grant WL/BT and correct the debug log
Date:   Tue, 13 Sep 2022 17:25:46 +0800
Message-ID: <20220913092546.43722-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913092546.43722-1-pkshih@realtek.com>
References: <20220913092546.43722-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/13/2022 08:01:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMTMgpFekyCAwNjowMDowMA==?=
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

From: Ching-Te Ku <ku920601@realtek.com>

To reduce register IO, combine set_gnt_wl/set_gnt_bt to set the same
register one time. Because RTL8852C use different register to control
antenna path, so make correction of path control related debug logs.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 208 +++++++++++-----------
 drivers/net/wireless/realtek/rtw89/core.h |   3 +-
 drivers/net/wireless/realtek/rtw89/reg.h  |  12 ++
 3 files changed, 118 insertions(+), 105 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index c67ceea3a3828..194695309c63e 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -491,6 +491,11 @@ enum btc_gnt_state {
 	BTC_GNT_MAX
 };
 
+enum btc_ctr_path {
+	BTC_CTRL_BY_BT = 0,
+	BTC_CTRL_BY_WL
+};
+
 enum btc_wl_max_tx_time {
 	BTC_MAX_TX_TIME_L1 = 500,
 	BTC_MAX_TX_TIME_L2 = 1000,
@@ -1621,7 +1626,7 @@ void btc_fw_event(struct rtw89_dev *rtwdev, u8 evt_id, void *data, u32 len)
 	}
 }
 
-static void _set_gnt_wl(struct rtw89_dev *rtwdev, u8 phy_map, u8 state)
+static void _set_gnt(struct rtw89_dev *rtwdev, u8 phy_map, u8 wl_state, u8 bt_state)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_dm *dm = &btc->dm;
@@ -1635,7 +1640,7 @@ static void _set_gnt_wl(struct rtw89_dev *rtwdev, u8 phy_map, u8 state)
 		if (!(phy_map & BIT(i)))
 			continue;
 
-		switch (state) {
+		switch (wl_state) {
 		case BTC_GNT_HW:
 			g[i].gnt_wl_sw_en = 0;
 			g[i].gnt_wl = 0;
@@ -1649,6 +1654,21 @@ static void _set_gnt_wl(struct rtw89_dev *rtwdev, u8 phy_map, u8 state)
 			g[i].gnt_wl = 1;
 			break;
 		}
+
+		switch (bt_state) {
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
 	}
 
 	rtw89_chip_mac_cfg_gnt(rtwdev, &dm->gnt);
@@ -2783,39 +2803,6 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 }
 EXPORT_SYMBOL(rtw89_btc_set_policy_v1);
 
-static void _set_gnt_bt(struct rtw89_dev *rtwdev, u8 phy_map, u8 state)
-{
-	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_dm *dm = &btc->dm;
-	struct rtw89_mac_ax_gnt *g = dm->gnt.band;
-	u8 i;
-
-	if (phy_map > BTC_PHY_ALL)
-		return;
-
-	for (i = 0; i < RTW89_PHY_MAX; i++) {
-		if (!(phy_map & BIT(i)))
-			continue;
-
-		switch (state) {
-		case BTC_GNT_HW:
-			g[i].gnt_bt_sw_en = 0;
-			g[i].gnt_bt = 0;
-			break;
-		case BTC_GNT_SW_LO:
-			g[i].gnt_bt_sw_en = 1;
-			g[i].gnt_bt = 0;
-			break;
-		case BTC_GNT_SW_HI:
-			g[i].gnt_bt_sw_en = 1;
-			g[i].gnt_bt = 1;
-			break;
-		}
-	}
-
-	rtw89_chip_mac_cfg_gnt(rtwdev, &dm->gnt);
-}
-
 static void _set_bt_plut(struct rtw89_dev *rtwdev, u8 phy_map,
 			 u8 tx_val, u8 rx_val)
 {
@@ -2880,86 +2867,74 @@ static void _set_ant(struct rtw89_dev *rtwdev, bool force_exec,
 
 	switch (type) {
 	case BTC_ANT_WPOWERON:
-		rtw89_chip_cfg_ctrl_path(rtwdev, false);
+		rtw89_chip_cfg_ctrl_path(rtwdev, BTC_CTRL_BY_BT);
 		break;
 	case BTC_ANT_WINIT:
-		if (bt->enable.now) {
-			_set_gnt_wl(rtwdev, phy_map, BTC_GNT_SW_LO);
-			_set_gnt_bt(rtwdev, phy_map, BTC_GNT_SW_HI);
-		} else {
-			_set_gnt_wl(rtwdev, phy_map, BTC_GNT_SW_HI);
-			_set_gnt_bt(rtwdev, phy_map, BTC_GNT_SW_LO);
-		}
-		rtw89_chip_cfg_ctrl_path(rtwdev, true);
+		if (bt->enable.now)
+			_set_gnt(rtwdev, phy_map, BTC_GNT_SW_LO, BTC_GNT_SW_HI);
+		else
+			_set_gnt(rtwdev, phy_map, BTC_GNT_SW_HI, BTC_GNT_SW_LO);
+
+		rtw89_chip_cfg_ctrl_path(rtwdev, BTC_CTRL_BY_WL);
 		_set_bt_plut(rtwdev, BTC_PHY_ALL, BTC_PLT_BT, BTC_PLT_BT);
 		break;
 	case BTC_ANT_WONLY:
-		_set_gnt_wl(rtwdev, phy_map, BTC_GNT_SW_HI);
-		_set_gnt_bt(rtwdev, phy_map, BTC_GNT_SW_LO);
-		rtw89_chip_cfg_ctrl_path(rtwdev, true);
+		_set_gnt(rtwdev, phy_map, BTC_GNT_SW_HI, BTC_GNT_SW_LO);
+		rtw89_chip_cfg_ctrl_path(rtwdev, BTC_CTRL_BY_WL);
 		_set_bt_plut(rtwdev, BTC_PHY_ALL, BTC_PLT_NONE, BTC_PLT_NONE);
 		break;
 	case BTC_ANT_WOFF:
-		rtw89_chip_cfg_ctrl_path(rtwdev, false);
+		rtw89_chip_cfg_ctrl_path(rtwdev, BTC_CTRL_BY_BT);
 		_set_bt_plut(rtwdev, BTC_PHY_ALL, BTC_PLT_NONE, BTC_PLT_NONE);
 		break;
 	case BTC_ANT_W2G:
-		rtw89_chip_cfg_ctrl_path(rtwdev, true);
+		rtw89_chip_cfg_ctrl_path(rtwdev, BTC_CTRL_BY_WL);
 		if (rtwdev->dbcc_en) {
 			for (i = 0; i < RTW89_PHY_MAX; i++) {
 				b2g = (wl_dinfo->real_band[i] == RTW89_BAND_2G);
 
 				gnt_wl_ctrl = b2g ? BTC_GNT_HW : BTC_GNT_SW_HI;
-				_set_gnt_wl(rtwdev, BIT(i), gnt_wl_ctrl);
-
 				gnt_bt_ctrl = b2g ? BTC_GNT_HW : BTC_GNT_SW_HI;
 				/* BT should control by GNT_BT if WL_2G at S0 */
 				if (i == 1 &&
 				    wl_dinfo->real_band[0] == RTW89_BAND_2G &&
 				    wl_dinfo->real_band[1] == RTW89_BAND_5G)
 					gnt_bt_ctrl = BTC_GNT_HW;
-				_set_gnt_bt(rtwdev, BIT(i), gnt_bt_ctrl);
-
+				_set_gnt(rtwdev, BIT(i), gnt_wl_ctrl, gnt_bt_ctrl);
 				plt_ctrl = b2g ? BTC_PLT_BT : BTC_PLT_NONE;
 				_set_bt_plut(rtwdev, BIT(i),
 					     plt_ctrl, plt_ctrl);
 			}
 		} else {
-			_set_gnt_wl(rtwdev, phy_map, BTC_GNT_HW);
-			_set_gnt_bt(rtwdev, phy_map, BTC_GNT_HW);
+			_set_gnt(rtwdev, phy_map, BTC_GNT_HW, BTC_GNT_HW);
 			_set_bt_plut(rtwdev, BTC_PHY_ALL,
 				     BTC_PLT_BT, BTC_PLT_BT);
 		}
 		break;
 	case BTC_ANT_W5G:
-		rtw89_chip_cfg_ctrl_path(rtwdev, true);
-		_set_gnt_wl(rtwdev, phy_map, BTC_GNT_SW_HI);
-		_set_gnt_bt(rtwdev, phy_map, BTC_GNT_HW);
+		rtw89_chip_cfg_ctrl_path(rtwdev, BTC_CTRL_BY_WL);
+		_set_gnt(rtwdev, phy_map, BTC_GNT_SW_HI, BTC_GNT_HW);
 		_set_bt_plut(rtwdev, BTC_PHY_ALL, BTC_PLT_NONE, BTC_PLT_NONE);
 		break;
 	case BTC_ANT_W25G:
-		rtw89_chip_cfg_ctrl_path(rtwdev, true);
-		_set_gnt_wl(rtwdev, phy_map, BTC_GNT_HW);
-		_set_gnt_bt(rtwdev, phy_map, BTC_GNT_HW);
+		rtw89_chip_cfg_ctrl_path(rtwdev, BTC_CTRL_BY_WL);
+		_set_gnt(rtwdev, phy_map, BTC_GNT_HW, BTC_GNT_HW);
 		_set_bt_plut(rtwdev, BTC_PHY_ALL,
 			     BTC_PLT_GNT_WL, BTC_PLT_GNT_WL);
 		break;
 	case BTC_ANT_FREERUN:
-		rtw89_chip_cfg_ctrl_path(rtwdev, true);
-		_set_gnt_wl(rtwdev, phy_map, BTC_GNT_SW_HI);
-		_set_gnt_bt(rtwdev, phy_map, BTC_GNT_SW_HI);
+		rtw89_chip_cfg_ctrl_path(rtwdev, BTC_CTRL_BY_WL);
+		_set_gnt(rtwdev, phy_map, BTC_GNT_SW_HI, BTC_GNT_SW_HI);
 		_set_bt_plut(rtwdev, BTC_PHY_ALL, BTC_PLT_NONE, BTC_PLT_NONE);
 		break;
 	case BTC_ANT_WRFK:
-		rtw89_chip_cfg_ctrl_path(rtwdev, true);
-		_set_gnt_wl(rtwdev, phy_map, BTC_GNT_SW_HI);
-		_set_gnt_bt(rtwdev, phy_map, BTC_GNT_SW_LO);
+		rtw89_chip_cfg_ctrl_path(rtwdev, BTC_CTRL_BY_WL);
+		_set_gnt(rtwdev, phy_map, BTC_GNT_SW_HI, BTC_GNT_SW_LO);
 		_set_bt_plut(rtwdev, phy_map, BTC_PLT_NONE, BTC_PLT_NONE);
 		break;
 	case BTC_ANT_BRFK:
-		rtw89_chip_cfg_ctrl_path(rtwdev, false);
-		_set_gnt_wl(rtwdev, phy_map, BTC_GNT_SW_LO);
-		_set_gnt_bt(rtwdev, phy_map, BTC_GNT_SW_HI);
+		rtw89_chip_cfg_ctrl_path(rtwdev, BTC_CTRL_BY_BT);
+		_set_gnt(rtwdev, phy_map, BTC_GNT_SW_LO, BTC_GNT_SW_HI);
 		_set_bt_plut(rtwdev, phy_map, BTC_PLT_NONE, BTC_PLT_NONE);
 		break;
 	default:
@@ -4636,7 +4611,7 @@ void rtw89_btc_ntfy_init(struct rtw89_dev *rtwdev, u8 mode)
 	_write_scbd(rtwdev,
 		    BTC_WSCB_ACTIVE | BTC_WSCB_ON | BTC_WSCB_BTLOG, true);
 	_update_bt_scbd(rtwdev, true);
-	if (rtw89_mac_get_ctrl_path(rtwdev)) {
+	if (rtw89_mac_get_ctrl_path(rtwdev) && chip->chip_id == RTL8852A) {
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): PTA owner warning!!\n",
 			    __func__);
@@ -6391,6 +6366,47 @@ static void _show_fw_dm_msg(struct rtw89_dev *rtwdev, struct seq_file *m)
 	_show_fbtc_step(rtwdev, m);
 }
 
+static void _get_gnt(struct rtw89_dev *rtwdev, struct rtw89_mac_ax_coex_gnt *gnt_cfg)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_mac_ax_gnt *gnt;
+	u32 val, status;
+
+	if (chip->chip_id == RTL8852A || chip->chip_id == RTL8852B) {
+		rtw89_mac_read_lte(rtwdev, R_AX_LTE_SW_CFG_1, &val);
+		rtw89_mac_read_lte(rtwdev, R_AX_GNT_VAL, &status);
+
+		gnt = &gnt_cfg->band[0];
+		gnt->gnt_bt_sw_en = !!(val & B_AX_GNT_BT_RFC_S0_SW_CTRL);
+		gnt->gnt_bt = !!(status & B_AX_GNT_BT_RFC_S0_STA);
+		gnt->gnt_wl_sw_en = !!(val & B_AX_GNT_WL_RFC_S0_SW_CTRL);
+		gnt->gnt_wl = !!(status & B_AX_GNT_WL_RFC_S0_STA);
+
+		gnt = &gnt_cfg->band[1];
+		gnt->gnt_bt_sw_en = !!(val & B_AX_GNT_BT_RFC_S1_SW_CTRL);
+		gnt->gnt_bt = !!(status & B_AX_GNT_BT_RFC_S1_STA);
+		gnt->gnt_wl_sw_en = !!(val & B_AX_GNT_WL_RFC_S1_SW_CTRL);
+		gnt->gnt_wl = !!(status & B_AX_GNT_WL_RFC_S1_STA);
+	} else if (chip->chip_id == RTL8852C) {
+		val = rtw89_read32(rtwdev, R_AX_GNT_SW_CTRL);
+		status = rtw89_read32(rtwdev, R_AX_GNT_VAL_V1);
+
+		gnt = &gnt_cfg->band[0];
+		gnt->gnt_bt_sw_en = !!(val & B_AX_GNT_BT_RFC_S0_SWCTRL);
+		gnt->gnt_bt = !!(status & B_AX_GNT_BT_RFC_S0);
+		gnt->gnt_wl_sw_en = !!(val & B_AX_GNT_WL_RFC_S0_SWCTRL);
+		gnt->gnt_wl = !!(status & B_AX_GNT_WL_RFC_S0);
+
+		gnt = &gnt_cfg->band[1];
+		gnt->gnt_bt_sw_en = !!(val & B_AX_GNT_BT_RFC_S1_SWCTRL);
+		gnt->gnt_bt = !!(status & B_AX_GNT_BT_RFC_S1);
+		gnt->gnt_wl_sw_en = !!(val & B_AX_GNT_WL_RFC_S1_SWCTRL);
+		gnt->gnt_wl = !!(status & B_AX_GNT_WL_RFC_S1);
+	} else {
+		return;
+	}
+}
+
 static void _show_mreg(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
@@ -6402,7 +6418,8 @@ static void _show_mreg(struct rtw89_dev *rtwdev, struct seq_file *m)
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
-	struct rtw89_mac_ax_gnt gnt[2] = {0};
+	struct rtw89_mac_ax_coex_gnt gnt_cfg = {};
+	struct rtw89_mac_ax_gnt gnt;
 	u8 i = 0, type = 0, cnt = 0;
 	u32 val, offset;
 
@@ -6419,45 +6436,28 @@ static void _show_mreg(struct rtw89_dev *rtwdev, struct seq_file *m)
 
 	/* To avoid I/O if WL LPS or power-off  */
 	if (!wl->status.map.lps && !wl->status.map.rf_off) {
-		rtw89_mac_read_lte(rtwdev, R_AX_LTE_SW_CFG_1, &val);
-		if (val & (B_AX_GNT_BT_RFC_S0_SW_VAL |
-		    B_AX_GNT_BT_BB_S0_SW_VAL))
-			gnt[0].gnt_bt = true;
-		if (val & (B_AX_GNT_BT_RFC_S0_SW_CTRL |
-		    B_AX_GNT_BT_BB_S0_SW_CTRL))
-			gnt[0].gnt_bt_sw_en = true;
-		if (val & (B_AX_GNT_WL_RFC_S0_SW_VAL |
-		    B_AX_GNT_WL_BB_S0_SW_VAL))
-			gnt[0].gnt_wl = true;
-		if (val & (B_AX_GNT_WL_RFC_S0_SW_CTRL |
-		    B_AX_GNT_WL_BB_S0_SW_CTRL))
-			gnt[0].gnt_wl_sw_en = true;
-
-		if (val & (B_AX_GNT_BT_RFC_S1_SW_VAL |
-		    B_AX_GNT_BT_BB_S1_SW_VAL))
-			gnt[1].gnt_bt = true;
-		if (val & (B_AX_GNT_BT_RFC_S1_SW_CTRL |
-		    B_AX_GNT_BT_BB_S1_SW_CTRL))
-			gnt[1].gnt_bt_sw_en = true;
-		if (val & (B_AX_GNT_WL_RFC_S1_SW_VAL |
-		    B_AX_GNT_WL_BB_S1_SW_VAL))
-			gnt[1].gnt_wl = true;
-		if (val & (B_AX_GNT_WL_RFC_S1_SW_CTRL |
-		    B_AX_GNT_WL_BB_S1_SW_CTRL))
-			gnt[1].gnt_wl_sw_en = true;
+		if (chip->chip_id == RTL8852A)
+			btc->dm.pta_owner = rtw89_mac_get_ctrl_path(rtwdev);
+		else if (chip->chip_id == RTL8852C)
+			btc->dm.pta_owner = 0;
 
+		_get_gnt(rtwdev, &gnt_cfg);
+		gnt = gnt_cfg.band[0];
 		seq_printf(m,
 			   " %-15s : pta_owner:%s, phy-0[gnt_wl:%s-%d/gnt_bt:%s-%d], ",
 			   "[gnt_status]",
-			   (rtw89_mac_get_ctrl_path(rtwdev) ? "WL" : "BT"),
-			   (gnt[0].gnt_wl_sw_en ? "SW" : "HW"), gnt[0].gnt_wl,
-			   (gnt[0].gnt_bt_sw_en ? "SW" : "HW"), gnt[0].gnt_bt);
+			   chip->chip_id == RTL8852C ? "HW" :
+			   btc->dm.pta_owner == BTC_CTRL_BY_WL ? "WL" : "BT",
+			   gnt.gnt_wl_sw_en ? "SW" : "HW", gnt.gnt_wl,
+			   gnt.gnt_bt_sw_en ? "SW" : "HW", gnt.gnt_bt);
 
+		gnt = gnt_cfg.band[1];
 		seq_printf(m, "phy-1[gnt_wl:%s-%d/gnt_bt:%s-%d]\n",
-			   (gnt[1].gnt_wl_sw_en ? "SW" : "HW"), gnt[1].gnt_wl,
-			   (gnt[1].gnt_bt_sw_en ? "SW" : "HW"), gnt[1].gnt_bt);
+			   gnt.gnt_wl_sw_en ? "SW" : "HW",
+			   gnt.gnt_wl,
+			   gnt.gnt_bt_sw_en ? "SW" : "HW",
+			   gnt.gnt_bt);
 	}
-
 	pcinfo = &pfwinfo->rpt_fbtc_mregval.cinfo;
 	if (!pcinfo->valid) {
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 3caa8cfd5e5e7..28a33039e29ec 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1798,8 +1798,9 @@ struct rtw89_btc_dm {
 	u32 wl_btg_rx: 1;
 	u32 trx_para_level: 8;
 	u32 wl_stb_chg: 1;
+	u32 pta_owner: 1;
 	u32 tdma_instant_excute: 1;
-	u32 rsvd: 2;
+	u32 rsvd: 1;
 
 	u16 slot_dur[CXST_MAX];
 
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 19e5e09bf726b..9f56f77ec86a2 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3156,6 +3156,18 @@
 #define B_AX_GNT_WL_BB_VAL BIT(1)
 #define B_AX_GNT_WL_BB_SWCTRL BIT(0)
 
+#define R_AX_GNT_VAL 0x0054
+#define B_AX_GNT_BT_RFC_S1_STA BIT(5)
+#define B_AX_GNT_WL_RFC_S1_STA BIT(4)
+#define B_AX_GNT_BT_RFC_S0_STA BIT(3)
+#define B_AX_GNT_WL_RFC_S0_STA BIT(2)
+
+#define R_AX_GNT_VAL_V1 0xDA4C
+#define B_AX_GNT_BT_RFC_S1 BIT(4)
+#define B_AX_GNT_BT_RFC_S0 BIT(3)
+#define B_AX_GNT_WL_RFC_S1 BIT(2)
+#define B_AX_GNT_WL_RFC_S0 BIT(1)
+
 #define R_AX_TDMA_MODE 0xDA4C
 #define R_AX_TDMA_MODE_C1 0xFA4C
 #define B_AX_R_BT_CMD_RPT_MASK GENMASK(31, 16)
-- 
2.25.1

