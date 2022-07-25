Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A0057F846
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jul 2022 04:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbiGYCgD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Jul 2022 22:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiGYCf7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Jul 2022 22:35:59 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B436E022
        for <linux-wireless@vger.kernel.org>; Sun, 24 Jul 2022 19:35:56 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 26P2ZadX6014733, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 26P2ZadX6014733
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 25 Jul 2022 10:35:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 25 Jul 2022 10:35:42 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Mon, 25 Jul
 2022 10:35:42 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 4/9] rtw89: coex: Define BT B1 slot length
Date:   Mon, 25 Jul 2022 10:35:04 +0800
Message-ID: <20220725023509.43114-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220725023509.43114-1-pkshih@realtek.com>
References: <20220725023509.43114-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 07/25/2022 02:16:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzcvMjQgpFWkyCAxMToyOTowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

It is for setting up BT slot max length at BT auto slot mechanism.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 131 +++++++++++-----------
 1 file changed, 66 insertions(+), 65 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 020b2628ef2c4..f8e335ead91a2 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -322,25 +322,25 @@ enum btc_cx_poicy_type {
 	BTC_CXP_PFIX_TDW1B1 = (BTC_CXP_PFIX << 8) | 6,
 
 	/* TDMA Auto slot-0: W1:B1 = 50:200 */
-	BTC_CXP_AUTO_TD50200 = (BTC_CXP_AUTO << 8) | 0,
+	BTC_CXP_AUTO_TD50B1 = (BTC_CXP_AUTO << 8) | 0,
 
 	/* TDMA Auto slot-1: W1:B1 = 60:200 */
-	BTC_CXP_AUTO_TD60200 = (BTC_CXP_AUTO << 8) | 1,
+	BTC_CXP_AUTO_TD60B1 = (BTC_CXP_AUTO << 8) | 1,
 
 	/* TDMA Auto slot-2: W1:B1 = 20:200 */
-	BTC_CXP_AUTO_TD20200 = (BTC_CXP_AUTO << 8) | 2,
+	BTC_CXP_AUTO_TD20B1 = (BTC_CXP_AUTO << 8) | 2,
 
 	/* TDMA Auto slot-3: W1:B1 = user-define */
 	BTC_CXP_AUTO_TDW1B1 = (BTC_CXP_AUTO << 8) | 3,
 
 	/* PS-TDMA Auto slot-0: W1:B1 = 50:200 */
-	BTC_CXP_PAUTO_TD50200 = (BTC_CXP_PAUTO << 8) | 0,
+	BTC_CXP_PAUTO_TD50B1 = (BTC_CXP_PAUTO << 8) | 0,
 
 	/* PS-TDMA Auto slot-1: W1:B1 = 60:200 */
-	BTC_CXP_PAUTO_TD60200 = (BTC_CXP_PAUTO << 8) | 1,
+	BTC_CXP_PAUTO_TD60B1 = (BTC_CXP_PAUTO << 8) | 1,
 
 	/* PS-TDMA Auto slot-2: W1:B1 = 20:200 */
-	BTC_CXP_PAUTO_TD20200 = (BTC_CXP_PAUTO << 8) | 2,
+	BTC_CXP_PAUTO_TD20B1 = (BTC_CXP_PAUTO << 8) | 2,
 
 	/* PS-TDMA Auto slot-3: W1:B1 = user-define */
 	BTC_CXP_PAUTO_TDW1B1 = (BTC_CXP_PAUTO << 8) | 3,
@@ -531,6 +531,7 @@ enum btc_reason_and_action {
 #define BTC_FREERUN_ANTISO_MIN 30
 #define BTC_TDMA_BTHID_MAX 2
 #define BTC_BLINK_NOCONNECT 0
+#define BTC_B1_MAX 250 /* unit ms */
 
 static void _run_coex(struct rtw89_dev *rtwdev,
 		      enum btc_reason_and_action reason);
@@ -2117,17 +2118,17 @@ static void _set_policy(struct rtw89_dev *rtwdev, u16 policy_type,
 		_write_scbd(rtwdev, BTC_WSCB_TDMA, true);
 		*t = t_def[CXTD_AUTO];
 		switch (policy_type) {
-		case BTC_CXP_AUTO_TD50200:
-			_slot_set(btc, CXST_W1,  50, tbl_w1, SLOT_ISO);
-			_slot_set(btc, CXST_B1, 200, tbl_b1, SLOT_MIX);
+		case BTC_CXP_AUTO_TD50B1:
+			_slot_set(btc, CXST_W1, 50, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
 			break;
-		case BTC_CXP_AUTO_TD60200:
-			_slot_set(btc, CXST_W1,  60, tbl_w1, SLOT_ISO);
-			_slot_set(btc, CXST_B1, 200, tbl_b1, SLOT_MIX);
+		case BTC_CXP_AUTO_TD60B1:
+			_slot_set(btc, CXST_W1, 60, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
 			break;
-		case BTC_CXP_AUTO_TD20200:
-			_slot_set(btc, CXST_W1,  20, tbl_w1, SLOT_ISO);
-			_slot_set(btc, CXST_B1, 200, tbl_b1, SLOT_MIX);
+		case BTC_CXP_AUTO_TD20B1:
+			_slot_set(btc, CXST_W1, 20, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
 			break;
 		case BTC_CXP_AUTO_TDW1B1: /* W1:B1 = user-define */
 			_slot_set(btc, CXST_W1, dm->slot_dur[CXST_W1],
@@ -2141,17 +2142,17 @@ static void _set_policy(struct rtw89_dev *rtwdev, u16 policy_type,
 		_write_scbd(rtwdev, BTC_WSCB_TDMA, true);
 		*t = t_def[CXTD_PAUTO];
 		switch (policy_type) {
-		case BTC_CXP_PAUTO_TD50200:
-			_slot_set(btc, CXST_W1,  50, tbl_w1, SLOT_ISO);
-			_slot_set(btc, CXST_B1, 200, tbl_b1, SLOT_MIX);
+		case BTC_CXP_PAUTO_TD50B1:
+			_slot_set(btc, CXST_W1, 50, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
 			break;
-		case BTC_CXP_PAUTO_TD60200:
-			_slot_set(btc, CXST_W1,  60, tbl_w1, SLOT_ISO);
-			_slot_set(btc, CXST_B1, 200, tbl_b1, SLOT_MIX);
+		case BTC_CXP_PAUTO_TD60B1:
+			_slot_set(btc, CXST_W1, 60, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
 			break;
-		case BTC_CXP_PAUTO_TD20200:
-			_slot_set(btc, CXST_W1,  20, tbl_w1, SLOT_ISO);
-			_slot_set(btc, CXST_B1, 200, tbl_b1, SLOT_MIX);
+		case BTC_CXP_PAUTO_TD20B1:
+			_slot_set(btc, CXST_W1, 20, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
 			break;
 		case BTC_CXP_PAUTO_TDW1B1:
 			_slot_set(btc, CXST_W1, dm->slot_dur[CXST_W1],
@@ -2166,29 +2167,29 @@ static void _set_policy(struct rtw89_dev *rtwdev, u16 policy_type,
 		*t = t_def[CXTD_AUTO2];
 		switch (policy_type) {
 		case BTC_CXP_AUTO2_TD3050:
-			_slot_set(btc, CXST_W1,  30, tbl_w1, SLOT_ISO);
-			_slot_set(btc, CXST_B1, 200, tbl_b1, SLOT_MIX);
-			_slot_set(btc, CXST_B4,  50, tbl_b4, SLOT_MIX);
+			_slot_set(btc, CXST_W1, 30, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B4, 50, tbl_b4, SLOT_MIX);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
 			break;
 		case BTC_CXP_AUTO2_TD3070:
-			_slot_set(btc, CXST_W1,  30, tbl_w1, SLOT_ISO);
-			_slot_set(btc, CXST_B1, 200, tbl_b1, SLOT_MIX);
-			_slot_set(btc, CXST_B4,  70, tbl_b4, SLOT_MIX);
+			_slot_set(btc, CXST_W1, 30, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B4, 70, tbl_b4, SLOT_MIX);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
 			break;
 		case BTC_CXP_AUTO2_TD5050:
-			_slot_set(btc, CXST_W1,  50, tbl_w1, SLOT_ISO);
-			_slot_set(btc, CXST_B1, 200, tbl_b1, SLOT_MIX);
-			_slot_set(btc, CXST_B4,  50, tbl_b4, SLOT_MIX);
+			_slot_set(btc, CXST_W1, 50, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B4, 50, tbl_b4, SLOT_MIX);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
 			break;
 		case BTC_CXP_AUTO2_TD6060:
-			_slot_set(btc, CXST_W1,  60, tbl_w1, SLOT_ISO);
-			_slot_set(btc, CXST_B1, 200, tbl_b1, SLOT_MIX);
-			_slot_set(btc, CXST_B4,  60, tbl_b4, SLOT_MIX);
+			_slot_set(btc, CXST_W1, 60, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B4, 60, tbl_b4, SLOT_MIX);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
 			break;
 		case BTC_CXP_AUTO2_TD2080:
-			_slot_set(btc, CXST_W1,  20, tbl_w1, SLOT_ISO);
-			_slot_set(btc, CXST_B1, 200, tbl_b1, SLOT_MIX);
-			_slot_set(btc, CXST_B4,  80, tbl_b4, SLOT_MIX);
+			_slot_set(btc, CXST_W1, 20, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B4, 80, tbl_b4, SLOT_MIX);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
 			break;
 		case BTC_CXP_AUTO2_TDW1B4: /* W1:B1 = user-define */
 			_slot_set(btc, CXST_W1, dm->slot_dur[CXST_W1],
@@ -2203,29 +2204,29 @@ static void _set_policy(struct rtw89_dev *rtwdev, u16 policy_type,
 		*t = t_def[CXTD_PAUTO2];
 		switch (policy_type) {
 		case BTC_CXP_PAUTO2_TD3050:
-			_slot_set(btc, CXST_W1,  30, tbl_w1, SLOT_ISO);
-			_slot_set(btc, CXST_B1, 200, tbl_b1, SLOT_MIX);
-			_slot_set(btc, CXST_B4,  50, tbl_b4, SLOT_MIX);
+			_slot_set(btc, CXST_W1, 30, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B4, 50, tbl_b4, SLOT_MIX);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
 			break;
 		case BTC_CXP_PAUTO2_TD3070:
-			_slot_set(btc, CXST_W1,  30, tbl_w1, SLOT_ISO);
-			_slot_set(btc, CXST_B1, 200, tbl_b1, SLOT_MIX);
-			_slot_set(btc, CXST_B4,  70, tbl_b4, SLOT_MIX);
+			_slot_set(btc, CXST_W1, 30, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B4, 70, tbl_b4, SLOT_MIX);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
 			break;
 		case BTC_CXP_PAUTO2_TD5050:
-			_slot_set(btc, CXST_W1,  50, tbl_w1, SLOT_ISO);
-			_slot_set(btc, CXST_B1, 200, tbl_b1, SLOT_MIX);
-			_slot_set(btc, CXST_B4,  50, tbl_b4, SLOT_MIX);
+			_slot_set(btc, CXST_W1, 50, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B4, 50, tbl_b4, SLOT_MIX);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
 			break;
 		case BTC_CXP_PAUTO2_TD6060:
-			_slot_set(btc, CXST_W1,  60, tbl_w1, SLOT_ISO);
-			_slot_set(btc, CXST_B1, 200, tbl_b1, SLOT_MIX);
-			_slot_set(btc, CXST_B4,  60, tbl_b4, SLOT_MIX);
+			_slot_set(btc, CXST_W1, 60, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B4, 60, tbl_b4, SLOT_MIX);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
 			break;
 		case BTC_CXP_PAUTO2_TD2080:
-			_slot_set(btc, CXST_W1,  20, tbl_w1, SLOT_ISO);
-			_slot_set(btc, CXST_B1, 200, tbl_b1, SLOT_MIX);
-			_slot_set(btc, CXST_B4,  80, tbl_b4, SLOT_MIX);
+			_slot_set(btc, CXST_W1, 20, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_B4, 80, tbl_b4, SLOT_MIX);
+			_slot_set(btc, CXST_B1, BTC_B1_MAX, tbl_b1, SLOT_MIX);
 			break;
 		case BTC_CXP_PAUTO2_TDW1B4: /* W1:B1 = user-define */
 			_slot_set(btc, CXST_W1, dm->slot_dur[CXST_W1],
@@ -2574,7 +2575,7 @@ static void _action_bt_a2dp(struct rtw89_dev *rtwdev)
 				    BTC_CXP_PAUTO_TDW1B1, BTC_ACT_BT_A2DP);
 		} else {
 			_set_policy(rtwdev,
-				    BTC_CXP_PAUTO_TD50200, BTC_ACT_BT_A2DP);
+				    BTC_CXP_PAUTO_TD50B1, BTC_ACT_BT_A2DP);
 		}
 		break;
 	case BTC_WBUSY_BSCAN: /* wl-busy + bt-inq + bt-A2DP */
@@ -2591,12 +2592,12 @@ static void _action_bt_a2dp(struct rtw89_dev *rtwdev)
 			_set_policy(rtwdev, BTC_CXP_AUTO_TDW1B1,
 				    BTC_ACT_BT_A2DP);
 		} else {
-			_set_policy(rtwdev, BTC_CXP_AUTO_TD50200,
+			_set_policy(rtwdev, BTC_CXP_AUTO_TD50B1,
 				    BTC_ACT_BT_A2DP);
 		}
 		break;
 	case BTC_WIDLE:  /* wl-idle + bt-A2DP */
-		_set_policy(rtwdev, BTC_CXP_AUTO_TD20200, BTC_ACT_BT_A2DP);
+		_set_policy(rtwdev, BTC_CXP_AUTO_TD20B1, BTC_ACT_BT_A2DP);
 		break;
 	}
 }
@@ -2676,7 +2677,7 @@ static void _action_bt_a2dp_hid(struct rtw89_dev *rtwdev)
 				    BTC_CXP_PAUTO_TDW1B1, BTC_ACT_BT_A2DP_HID);
 		} else {
 			_set_policy(rtwdev,
-				    BTC_CXP_PAUTO_TD50200, BTC_ACT_BT_A2DP_HID);
+				    BTC_CXP_PAUTO_TD50B1, BTC_ACT_BT_A2DP_HID);
 		}
 		break;
 	case BTC_WBUSY_BSCAN: /* wl-busy + bt-inq + bt-A2DP+HID */
@@ -2694,7 +2695,7 @@ static void _action_bt_a2dp_hid(struct rtw89_dev *rtwdev)
 			_set_policy(rtwdev, BTC_CXP_AUTO_TDW1B1,
 				    BTC_ACT_BT_A2DP_HID);
 		} else {
-			_set_policy(rtwdev, BTC_CXP_AUTO_TD50200,
+			_set_policy(rtwdev, BTC_CXP_AUTO_TD50B1,
 				    BTC_ACT_BT_A2DP_HID);
 		}
 		break;
@@ -5033,13 +5034,13 @@ static const char *steps_to_str(u16 step)
 	CASE_BTC_POLICY_STR(PFIX_TD3070);
 	CASE_BTC_POLICY_STR(PFIX_TD2080);
 	CASE_BTC_POLICY_STR(PFIX_TDW1B1);
-	CASE_BTC_POLICY_STR(AUTO_TD50200);
-	CASE_BTC_POLICY_STR(AUTO_TD60200);
-	CASE_BTC_POLICY_STR(AUTO_TD20200);
+	CASE_BTC_POLICY_STR(AUTO_TD50B1);
+	CASE_BTC_POLICY_STR(AUTO_TD60B1);
+	CASE_BTC_POLICY_STR(AUTO_TD20B1);
 	CASE_BTC_POLICY_STR(AUTO_TDW1B1);
-	CASE_BTC_POLICY_STR(PAUTO_TD50200);
-	CASE_BTC_POLICY_STR(PAUTO_TD60200);
-	CASE_BTC_POLICY_STR(PAUTO_TD20200);
+	CASE_BTC_POLICY_STR(PAUTO_TD50B1);
+	CASE_BTC_POLICY_STR(PAUTO_TD60B1);
+	CASE_BTC_POLICY_STR(PAUTO_TD20B1);
 	CASE_BTC_POLICY_STR(PAUTO_TDW1B1);
 	CASE_BTC_POLICY_STR(AUTO2_TD3050);
 	CASE_BTC_POLICY_STR(AUTO2_TD3070);
-- 
2.25.1

