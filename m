Return-Path: <linux-wireless+bounces-892-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2A8816665
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 07:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 276D3B21C03
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 06:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94835F508;
	Mon, 18 Dec 2023 06:15:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F1BDF4B
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 06:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BI6FJB203224896, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BI6FJB203224896
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 14:15:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 18 Dec 2023 14:15:19 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 18 Dec
 2023 14:15:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 11/11] wifi: rtw89: coex: To improve Wi-Fi performance while BT is idle
Date: Mon, 18 Dec 2023 14:13:41 +0800
Message-ID: <20231218061341.51255-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218061341.51255-1-pkshih@realtek.com>
References: <20231218061341.51255-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Ching-Te Ku <ku920601@realtek.com>

Because some platform Bluetooth will have many background scan when idle.
And the frequently Bluetooth scan will break Wi-Fi traffic many times at
a short duration, it will make Wi-Fi throughput become lower. This patch
will shorter Bluetooth slot and adjust priority settings, make Wi-Fi can
have a more completed duration to do traffic.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 63 +++++++++++++----------
 1 file changed, 37 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 0b430eace1aa..f37afb4cbb63 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -123,7 +123,8 @@ static const u32 cxtbl[] = {
 	0xea55556a, /* 21 */
 	0xaafafafa, /* 22 */
 	0xfafaaafa, /* 23 */
-	0xfafffaff  /* 24 */
+	0xfafffaff, /* 24 */
+	0xea6a5a5a, /* 25 */
 };
 
 static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
@@ -413,11 +414,14 @@ enum btc_cx_poicy_type {
 	/* TDMA Fix slot-8: W1:B1 = user-define */
 	BTC_CXP_FIX_TDW1B1 = (BTC_CXP_FIX << 8) | 8,
 
-	/* TDMA Fix slot-9: W1:B1 = 40:20 */
-	BTC_CXP_FIX_TD4020 = (BTC_CXP_FIX << 8) | 9,
-
 	/* TDMA Fix slot-9: W1:B1 = 40:10 */
-	BTC_CXP_FIX_TD4010ISO = (BTC_CXP_FIX << 8) | 10,
+	BTC_CXP_FIX_TD4010ISO = (BTC_CXP_FIX << 8) | 9,
+
+	/* TDMA Fix slot-10: W1:B1 = 40:10 */
+	BTC_CXP_FIX_TD4010ISO_DL = (BTC_CXP_FIX << 8) | 10,
+
+	/* TDMA Fix slot-11: W1:B1 = 40:10 */
+	BTC_CXP_FIX_TD4010ISO_UL = (BTC_CXP_FIX << 8) | 11,
 
 	/* PS-TDMA Fix slot-0: W1:B1 = 30:30 */
 	BTC_CXP_PFIX_TD3030 = (BTC_CXP_PFIX << 8) | 0,
@@ -2815,9 +2819,17 @@ void rtw89_btc_set_policy(struct rtw89_dev *rtwdev, u16 policy_type)
 			_slot_set(btc, CXST_W1, 40, tbl_w1, SLOT_ISO);
 			_slot_set(btc, CXST_B1, 10, tbl_b1, SLOT_MIX);
 			break;
-		case BTC_CXP_FIX_TD4020:
-			_slot_set(btc, CXST_W1, 40, cxtbl[1], SLOT_MIX);
-			_slot_set(btc, CXST_B1, 20, tbl_b1, SLOT_MIX);
+		case BTC_CXP_FIX_TD4010ISO:
+			_slot_set(btc, CXST_W1, 40, cxtbl[1], SLOT_ISO);
+			_slot_set(btc, CXST_B1, 10, tbl_b1, SLOT_MIX);
+			break;
+		case BTC_CXP_FIX_TD4010ISO_DL:
+			_slot_set(btc, CXST_W1, 40, cxtbl[25], SLOT_ISO);
+			_slot_set(btc, CXST_B1, 10, cxtbl[25], SLOT_ISO);
+			break;
+		case BTC_CXP_FIX_TD4010ISO_UL:
+			_slot_set(btc, CXST_W1, 40, cxtbl[20], SLOT_ISO);
+			_slot_set(btc, CXST_B1, 10, cxtbl[25], SLOT_MIX);
 			break;
 		case BTC_CXP_FIX_TD7010:
 			_slot_set(btc, CXST_W1, 70, tbl_w1, SLOT_ISO);
@@ -3156,9 +3168,13 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 			_slot_set(btc, CXST_W1, 40, cxtbl[1], SLOT_ISO);
 			_slot_set(btc, CXST_B1, 10, tbl_b1, SLOT_MIX);
 			break;
-		case BTC_CXP_FIX_TD4020:
-			_slot_set(btc, CXST_W1, 40, cxtbl[1], SLOT_MIX);
-			_slot_set(btc, CXST_B1, 20, tbl_b1, SLOT_MIX);
+		case BTC_CXP_FIX_TD4010ISO_DL:
+			_slot_set(btc, CXST_W1, 40, cxtbl[25], SLOT_ISO);
+			_slot_set(btc, CXST_B1, 10, cxtbl[25], SLOT_ISO);
+			break;
+		case BTC_CXP_FIX_TD4010ISO_UL:
+			_slot_set(btc, CXST_W1, 40, cxtbl[20], SLOT_ISO);
+			_slot_set(btc, CXST_B1, 10, cxtbl[25], SLOT_MIX);
 			break;
 		case BTC_CXP_FIX_TD7010:
 			_slot_set(btc, CXST_W1, 70, tbl_w1, SLOT_ISO);
@@ -3595,31 +3611,25 @@ static void _action_bt_idle(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_bt_link_info *b = &btc->cx.bt.link_info;
+	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 
 	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
 
 	if (btc->mdinfo.ant.type == BTC_ANT_SHARED) { /* shared-antenna */
 		switch (btc->cx.state_map) {
 		case BTC_WBUSY_BNOSCAN: /*wl-busy + bt idle*/
-			if (b->profile_cnt.now > 0)
-				_set_policy(rtwdev, BTC_CXP_FIX_TD4010,
-					    BTC_ACT_BT_IDLE);
+		case BTC_WSCAN_BNOSCAN: /* wl-scan + bt-idle */
+			if (b->status.map.connect)
+				_set_policy(rtwdev, BTC_CXP_FIX_TD4010, BTC_ACT_BT_IDLE);
+			else if (wl->status.map.traffic_dir & BIT(RTW89_TFC_DL))
+				_set_policy(rtwdev, BTC_CXP_FIX_TD4010ISO_DL, BTC_ACT_BT_IDLE);
 			else
-				_set_policy(rtwdev, BTC_CXP_FIX_TD4020,
-					    BTC_ACT_BT_IDLE);
+				_set_policy(rtwdev, BTC_CXP_FIX_TD4010ISO_UL, BTC_ACT_BT_IDLE);
 			break;
 		case BTC_WBUSY_BSCAN: /*wl-busy + bt-inq */
 			_set_policy(rtwdev, BTC_CXP_PFIX_TD5050,
 				    BTC_ACT_BT_IDLE);
 			break;
-		case BTC_WSCAN_BNOSCAN: /* wl-scan + bt-idle */
-			if (b->profile_cnt.now > 0)
-				_set_policy(rtwdev, BTC_CXP_FIX_TD4010,
-					    BTC_ACT_BT_IDLE);
-			else
-				_set_policy(rtwdev, BTC_CXP_FIX_TD4020,
-					    BTC_ACT_BT_IDLE);
-			break;
 		case BTC_WSCAN_BSCAN: /* wl-scan + bt-inq */
 			_set_policy(rtwdev, BTC_CXP_FIX_TD5050,
 				    BTC_ACT_BT_IDLE);
@@ -3786,7 +3796,7 @@ static void _action_bt_pan(struct rtw89_dev *rtwdev)
 		_set_policy(rtwdev, BTC_CXP_FIX_TD3060, BTC_ACT_BT_PAN);
 		break;
 	case BTC_WLINKING: /* wl-connecting + bt-PAN */
-		_set_policy(rtwdev, BTC_CXP_FIX_TD4020, BTC_ACT_BT_PAN);
+		_set_policy(rtwdev, BTC_CXP_FIX_TD4010ISO, BTC_ACT_BT_PAN);
 		break;
 	case BTC_WIDLE: /* wl-idle + bt-pan */
 		_set_policy(rtwdev, BTC_CXP_PFIX_TD2080, BTC_ACT_BT_PAN);
@@ -6945,8 +6955,9 @@ static const char *steps_to_str(u16 step)
 	CASE_BTC_POLICY_STR(FIX_TD3060);
 	CASE_BTC_POLICY_STR(FIX_TD2080);
 	CASE_BTC_POLICY_STR(FIX_TDW1B1);
-	CASE_BTC_POLICY_STR(FIX_TD4020);
 	CASE_BTC_POLICY_STR(FIX_TD4010ISO);
+	CASE_BTC_POLICY_STR(FIX_TD4010ISO_DL);
+	CASE_BTC_POLICY_STR(FIX_TD4010ISO_UL);
 	CASE_BTC_POLICY_STR(PFIX_TD3030);
 	CASE_BTC_POLICY_STR(PFIX_TD5050);
 	CASE_BTC_POLICY_STR(PFIX_TD2030);
-- 
2.25.1


