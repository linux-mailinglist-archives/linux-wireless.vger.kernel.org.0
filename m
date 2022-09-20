Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0A45BD932
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 03:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiITBLm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 21:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiITBLG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 21:11:06 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0536352E69
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 18:10:33 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28K1A3TD0031089, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28K1A3TD0031089
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 20 Sep 2022 09:10:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 09:10:25 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 20 Sep
 2022 09:10:25 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 8/9] wifi: rtw89: coex: add logic to control BT scan priority
Date:   Tue, 20 Sep 2022 09:09:38 +0800
Message-ID: <20220920010939.12173-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920010939.12173-1-pkshih@realtek.com>
References: <20220920010939.12173-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/20/2022 00:43:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMTkgpFWkyCAwNzowODowMA==?=
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

From: Ching-Te Ku <ku920601@realtek.com>

Add control logic to operate Wi-Fi to BT scoreboard to control BT scan
priority. And patch mechanism parameter to enhance Wi-Fi throughput while
coexisting with BT profile & BT scan. Set PTA priority let Wi-Fi BT can RX
at the same time.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 114 ++++++++++++++++------
 drivers/net/wireless/realtek/rtw89/core.h |   3 +-
 2 files changed, 85 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index ef6c5701ebcf5..d3d32f25071e8 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -77,21 +77,21 @@ static const struct rtw89_btc_fbtc_tdma t_def[] = {
 
 static const struct rtw89_btc_fbtc_slot s_def[] = {
 	[CXST_OFF]	= __DEF_FBTC_SLOT(100, 0x55555555, SLOT_MIX),
-	[CXST_B2W]	= __DEF_FBTC_SLOT(5,   0x5a5a5a5a, SLOT_ISO),
-	[CXST_W1]	= __DEF_FBTC_SLOT(70,  0x5a5a5a5a, SLOT_ISO),
-	[CXST_W2]	= __DEF_FBTC_SLOT(70,  0x5a5a5aaa, SLOT_ISO),
-	[CXST_W2B]	= __DEF_FBTC_SLOT(15,  0x5a5a5a5a, SLOT_ISO),
-	[CXST_B1]	= __DEF_FBTC_SLOT(100, 0x55555555, SLOT_MIX),
-	[CXST_B2]	= __DEF_FBTC_SLOT(7,   0x6a5a5a5a, SLOT_MIX),
-	[CXST_B3]	= __DEF_FBTC_SLOT(5,   0x55555555, SLOT_MIX),
-	[CXST_B4]	= __DEF_FBTC_SLOT(50,  0x55555555, SLOT_MIX),
-	[CXST_LK]	= __DEF_FBTC_SLOT(20,  0x5a5a5a5a, SLOT_ISO),
+	[CXST_B2W]	= __DEF_FBTC_SLOT(5,   0xea5a5a5a, SLOT_ISO),
+	[CXST_W1]	= __DEF_FBTC_SLOT(70,  0xea5a5a5a, SLOT_ISO),
+	[CXST_W2]	= __DEF_FBTC_SLOT(70,  0xea5a5aaa, SLOT_ISO),
+	[CXST_W2B]	= __DEF_FBTC_SLOT(15,  0xea5a5a5a, SLOT_ISO),
+	[CXST_B1]	= __DEF_FBTC_SLOT(100, 0xe5555555, SLOT_MIX),
+	[CXST_B2]	= __DEF_FBTC_SLOT(7,   0xea5a5a5a, SLOT_MIX),
+	[CXST_B3]	= __DEF_FBTC_SLOT(5,   0xe5555555, SLOT_MIX),
+	[CXST_B4]	= __DEF_FBTC_SLOT(50,  0xe5555555, SLOT_MIX),
+	[CXST_LK]	= __DEF_FBTC_SLOT(20,  0xea5a5a5a, SLOT_ISO),
 	[CXST_BLK]	= __DEF_FBTC_SLOT(250, 0x55555555, SLOT_MIX),
-	[CXST_E2G]	= __DEF_FBTC_SLOT(20,  0x6a5a5a5a, SLOT_MIX),
+	[CXST_E2G]	= __DEF_FBTC_SLOT(20,  0xea5a5a5a, SLOT_MIX),
 	[CXST_E5G]	= __DEF_FBTC_SLOT(20,  0xffffffff, SLOT_MIX),
-	[CXST_EBT]	= __DEF_FBTC_SLOT(20,  0x55555555, SLOT_MIX),
+	[CXST_EBT]	= __DEF_FBTC_SLOT(20,  0xe5555555, SLOT_MIX),
 	[CXST_ENULL]	= __DEF_FBTC_SLOT(7,   0xaaaaaaaa, SLOT_ISO),
-	[CXST_WLK]	= __DEF_FBTC_SLOT(250, 0x6a5a6a5a, SLOT_MIX),
+	[CXST_WLK]	= __DEF_FBTC_SLOT(250, 0xea5a5a5a, SLOT_MIX),
 	[CXST_W1FDD]	= __DEF_FBTC_SLOT(35,  0xfafafafa, SLOT_ISO),
 	[CXST_B1FDD]	= __DEF_FBTC_SLOT(100, 0xffffffff, SLOT_MIX),
 };
@@ -99,13 +99,13 @@ static const struct rtw89_btc_fbtc_slot s_def[] = {
 static const u32 cxtbl[] = {
 	0xffffffff, /* 0 */
 	0xaaaaaaaa, /* 1 */
-	0x55555555, /* 2 */
-	0x66555555, /* 3 */
-	0x66556655, /* 4 */
+	0xe5555555, /* 2 */
+	0xee555555, /* 3 */
+	0xd5555555, /* 4 */
 	0x5a5a5a5a, /* 5 */
-	0x5a5a5aaa, /* 6 */
-	0xaa5a5a5a, /* 7 */
-	0x6a5a5a5a, /* 8 */
+	0xfa5a5a5a, /* 6 */
+	0xda5a5a5a, /* 7 */
+	0xea5a5a5a, /* 8 */
 	0x6a5a5aaa, /* 9 */
 	0x6a5a6a5a, /* 10 */
 	0x6a5a6aaa, /* 11 */
@@ -264,6 +264,9 @@ enum btc_cx_poicy_type {
 	/* TDMA off + pri: WL_Hi-Tx > BT, BT_Hi > other-WL > BT_Lo */
 	BTC_CXP_OFF_BWB2 = (BTC_CXP_OFF << 8) | 8,
 
+	/* TDMA off + pri: WL_Hi-Tx = BT */
+	BTC_CXP_OFF_BWB3 = (BTC_CXP_OFF << 8) | 9,
+
 	/* TDMA off+Bcn-Protect + pri: WL_Hi-Tx > BT_Hi_Rx, BT_Hi > WL > BT_Lo*/
 	BTC_CXP_OFFB_BWB0 = (BTC_CXP_OFFB << 8) | 0,
 
@@ -433,7 +436,7 @@ enum btc_w2b_scoreboard {
 	BTC_WSCB_TDMA = BIT(9),
 	BTC_WSCB_FIX2M = BIT(10),
 	BTC_WSCB_WLRFK = BIT(11),
-	BTC_WSCB_BTRFK_GNT = BIT(12), /* not used, use mailbox to inform BT */
+	BTC_WSCB_RXSCAN_PRI = BIT(12),
 	BTC_WSCB_BT_HILNA = BIT(13),
 	BTC_WSCB_BTLOG = BIT(14),
 	BTC_WSCB_ALL = GENMASK(23, 0),
@@ -2205,6 +2208,9 @@ void rtw89_btc_set_policy(struct rtw89_dev *rtwdev, u16 policy_type)
 		case BTC_CXP_OFF_BWB1:
 			_slot_set_tbl(btc, CXST_OFF, cxtbl[8]);
 			break;
+		case BTC_CXP_OFF_BWB3:
+			_slot_set_tbl(btc, CXST_OFF, cxtbl[6]);
+			break;
 		}
 		break;
 	case BTC_CXP_OFFB: /* TDMA off + beacon protect */
@@ -2524,6 +2530,9 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 		case BTC_CXP_OFF_BWB2:
 			_slot_set_tbl(btc, CXST_OFF, cxtbl[7]);
 			break;
+		case BTC_CXP_OFF_BWB3:
+			_slot_set_tbl(btc, CXST_OFF, cxtbl[6]);
+			break;
 		default:
 			break;
 		}
@@ -3057,14 +3066,19 @@ static void _action_bt_idle(struct rtw89_dev *rtwdev)
 static void _action_bt_hfp(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 
 	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
 
 	if (btc->mdinfo.ant.type == BTC_ANT_SHARED) {
-		if (btc->cx.wl.status.map._4way)
+		if (btc->cx.wl.status.map._4way) {
 			_set_policy(rtwdev, BTC_CXP_OFF_WL, BTC_ACT_BT_HFP);
-		else
-			_set_policy(rtwdev, BTC_CXP_OFF_BWB0, BTC_ACT_BT_HFP);
+		} else if (wl->status.map.traffic_dir & BIT(RTW89_TFC_UL)) {
+			btc->cx.bt.scan_rx_low_pri = true;
+			_set_policy(rtwdev, BTC_CXP_OFF_BWB2, BTC_ACT_BT_HFP);
+		} else {
+			_set_policy(rtwdev, BTC_CXP_OFF_BWB1, BTC_ACT_BT_HFP);
+		}
 	} else {
 		_set_policy(rtwdev, BTC_CXP_OFF_EQ2, BTC_ACT_BT_HFP);
 	}
@@ -3072,17 +3086,37 @@ static void _action_bt_hfp(struct rtw89_dev *rtwdev)
 
 static void _action_bt_hid(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	struct rtw89_btc_bt_hid_desc *hid = &bt->link_info.hid_desc;
+	u16 policy_type = BTC_CXP_OFF_BT;
 
 	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
 
-	if (btc->mdinfo.ant.type == BTC_ANT_SHARED) /* shared-antenna */
-		if (btc->cx.wl.status.map._4way)
-			_set_policy(rtwdev, BTC_CXP_OFF_WL, BTC_ACT_BT_HID);
-		else
-			_set_policy(rtwdev, BTC_CXP_OFF_BWB0, BTC_ACT_BT_HID);
-	else /* dedicated-antenna */
-		_set_policy(rtwdev, BTC_CXP_OFF_EQ3, BTC_ACT_BT_HID);
+	if (btc->mdinfo.ant.type == BTC_ANT_SHARED) { /* shared-antenna */
+		if (wl->status.map._4way) {
+			policy_type = BTC_CXP_OFF_WL;
+		} else if (wl->status.map.traffic_dir & BIT(RTW89_TFC_UL)) {
+			btc->cx.bt.scan_rx_low_pri = true;
+			if (hid->type & BTC_HID_BLE)
+				policy_type = BTC_CXP_OFF_BWB0;
+			else
+				policy_type = BTC_CXP_OFF_BWB2;
+		} else if (hid->type == BTC_HID_218) {
+			bt->scan_rx_low_pri = true;
+			policy_type = BTC_CXP_OFF_BWB2;
+		} else if (chip->para_ver == 0x1) {
+			policy_type = BTC_CXP_OFF_BWB3;
+		} else {
+			policy_type = BTC_CXP_OFF_BWB1;
+		}
+	} else { /* dedicated-antenna */
+		policy_type = BTC_CXP_OFF_EQ3;
+	}
+
+	_set_policy(rtwdev, policy_type, BTC_ACT_BT_HID);
 }
 
 static void _action_bt_a2dp(struct rtw89_dev *rtwdev)
@@ -3555,6 +3589,14 @@ static void _set_bt_rx_agc(struct rtw89_dev *rtwdev)
 	_write_scbd(rtwdev, BTC_WSCB_BT_HILNA, bt_hi_lna_rx);
 }
 
+static void _set_bt_rx_scan_pri(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+
+	_write_scbd(rtwdev, BTC_WSCB_RXSCAN_PRI, (bool)(!!bt->scan_rx_low_pri));
+}
+
 /* TODO add these functions */
 static void _action_common(struct rtw89_dev *rtwdev)
 {
@@ -3566,6 +3608,7 @@ static void _action_common(struct rtw89_dev *rtwdev)
 	_set_bt_afh_info(rtwdev);
 	_set_bt_rx_agc(rtwdev);
 	_set_rf_trx_para(rtwdev);
+	_set_bt_rx_scan_pri(rtwdev);
 
 	if (wl->scbd_change) {
 		rtw89_mac_cfg_sb(rtwdev, wl->scbd);
@@ -4401,6 +4444,7 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 	struct rtw89_btc_dm *dm = &rtwdev->btc.dm;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
 	u8 mode;
@@ -4477,6 +4521,7 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 
 	btc->ctrl.igno_bt = false;
 	dm->freerun = false;
+	bt->scan_rx_low_pri = false;
 
 	if (reason == BTC_RSN_NTFY_INIT) {
 		_action_wl_init(rtwdev);
@@ -4519,24 +4564,30 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 		_action_wl_2g_sta(rtwdev);
 		break;
 	case BTC_WLINK_2G_AP:
+		bt->scan_rx_low_pri = true;
 		_action_wl_2g_ap(rtwdev);
 		break;
 	case BTC_WLINK_2G_GO:
+		bt->scan_rx_low_pri = true;
 		_action_wl_2g_go(rtwdev);
 		break;
 	case BTC_WLINK_2G_GC:
+		bt->scan_rx_low_pri = true;
 		_action_wl_2g_gc(rtwdev);
 		break;
 	case BTC_WLINK_2G_SCC:
+		bt->scan_rx_low_pri = true;
 		if (chip->chip_id == RTL8852A)
 			_action_wl_2g_scc(rtwdev);
 		else if (chip->chip_id == RTL8852C)
 			_action_wl_2g_scc_v1(rtwdev);
 		break;
 	case BTC_WLINK_2G_MCC:
+		bt->scan_rx_low_pri = true;
 		_action_wl_2g_mcc(rtwdev);
 		break;
 	case BTC_WLINK_25G_MCC:
+		bt->scan_rx_low_pri = true;
 		_action_wl_25g_mcc(rtwdev);
 		break;
 	case BTC_WLINK_5G:
@@ -5812,6 +5863,7 @@ static const char *steps_to_str(u16 step)
 	CASE_BTC_POLICY_STR(OFF_BWB0);
 	CASE_BTC_POLICY_STR(OFF_BWB1);
 	CASE_BTC_POLICY_STR(OFF_BWB2);
+	CASE_BTC_POLICY_STR(OFF_BWB3);
 	CASE_BTC_POLICY_STR(OFFB_BWB0);
 	CASE_BTC_POLICY_STR(OFFE_DEF);
 	CASE_BTC_POLICY_STR(OFFE_DEF2);
@@ -5980,9 +6032,9 @@ static void _show_dm_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 		   (bt->hi_lna_rx ? "Hi" : "Ori"), dm->wl_btg_rx);
 
 	seq_printf(m,
-		   " %-15s : wl_tx_limit[en:%d/max_t:%dus/max_retry:%d], bt_slot_reg:%d-TU\n",
+		   " %-15s : wl_tx_limit[en:%d/max_t:%dus/max_retry:%d], bt_slot_reg:%d-TU, bt_scan_rx_low_pri:%d\n",
 		   "[dm_ctrl]", dm->wl_tx_limit.enable, dm->wl_tx_limit.tx_time,
-		   dm->wl_tx_limit.tx_retry, btc->bt_req_len);
+		   dm->wl_tx_limit.tx_retry, btc->bt_req_len, bt->scan_rx_low_pri);
 }
 
 static void _show_error(struct rtw89_dev *rtwdev, struct seq_file *m)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 8af1813cba884..3b184e3031d48 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1394,7 +1394,8 @@ struct rtw89_btc_bt_info {
 	u32 pag: 1;
 	u32 run_patch_code: 1;
 	u32 hi_lna_rx: 1;
-	u32 rsvd: 22;
+	u32 scan_rx_low_pri: 1;
+	u32 rsvd: 21;
 };
 
 struct rtw89_btc_cx {
-- 
2.25.1

