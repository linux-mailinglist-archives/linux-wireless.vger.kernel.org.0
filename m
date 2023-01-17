Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0031F66DCB8
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jan 2023 12:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbjAQLmG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Jan 2023 06:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236411AbjAQLl5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Jan 2023 06:41:57 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73C2D233E2
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 03:41:56 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 30HBfg1nB012213, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 30HBfg1nB012213
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 17 Jan 2023 19:41:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 17 Jan 2023 19:41:43 +0800
Received: from localhost (172.16.17.65) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 17 Jan
 2023 19:41:42 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/8] wifi: rtw89: coex: Update Wi-Fi external control TDMA parameters/tables
Date:   Tue, 17 Jan 2023 19:41:02 +0800
Message-ID: <20230117114109.4298-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230117114109.4298-1-pkshih@realtek.com>
References: <20230117114109.4298-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.65]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/17/2023 11:09:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMTcgpFekyCAwOToxNDowMA==?=
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

This patch update the external control (Wi-Fi firmware control) type of
TDMA related parameters, almost all of these case were related to Wi-Fi
multi-role situations & AP mode.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 37 +++++++++++++++--------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index d48ae25823ffa..a9db33e3bcade 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -63,7 +63,7 @@ struct btc_fbtc_1slot {
 static const struct rtw89_btc_fbtc_tdma t_def[] = {
 	[CXTD_OFF]	= { CXTDMA_OFF,    CXFLC_OFF, CXTPS_OFF, 0, 0, 0, 0, 0},
 	[CXTD_OFF_B2]	= { CXTDMA_OFF,    CXFLC_OFF, CXTPS_OFF, 0, 0, 1, 0, 0},
-	[CXTD_OFF_EXT]	= { CXTDMA_OFF,    CXFLC_OFF, CXTPS_OFF, 0, 0, 3, 0, 0},
+	[CXTD_OFF_EXT]	= { CXTDMA_OFF,    CXFLC_OFF, CXTPS_OFF, 0, 0, 2, 0, 0},
 	[CXTD_FIX]	= { CXTDMA_FIX,    CXFLC_OFF, CXTPS_OFF, 0, 0, 0, 0, 0},
 	[CXTD_PFIX]	= { CXTDMA_FIX,  CXFLC_NULLP,  CXTPS_ON, 0, 5, 0, 0, 0},
 	[CXTD_AUTO]	= { CXTDMA_AUTO,   CXFLC_OFF, CXTPS_OFF, 0, 0, 0, 0, 0},
@@ -80,21 +80,21 @@ static const struct rtw89_btc_fbtc_slot s_def[] = {
 	[CXST_OFF]	= __DEF_FBTC_SLOT(100, 0x55555555, SLOT_MIX),
 	[CXST_B2W]	= __DEF_FBTC_SLOT(5,   0xea5a5a5a, SLOT_ISO),
 	[CXST_W1]	= __DEF_FBTC_SLOT(70,  0xea5a5a5a, SLOT_ISO),
-	[CXST_W2]	= __DEF_FBTC_SLOT(70,  0xea5a5aaa, SLOT_ISO),
+	[CXST_W2]	= __DEF_FBTC_SLOT(15,  0xea5a5a5a, SLOT_ISO),
 	[CXST_W2B]	= __DEF_FBTC_SLOT(15,  0xea5a5a5a, SLOT_ISO),
-	[CXST_B1]	= __DEF_FBTC_SLOT(100, 0xe5555555, SLOT_MIX),
+	[CXST_B1]	= __DEF_FBTC_SLOT(250, 0xe5555555, SLOT_MIX),
 	[CXST_B2]	= __DEF_FBTC_SLOT(7,   0xea5a5a5a, SLOT_MIX),
 	[CXST_B3]	= __DEF_FBTC_SLOT(5,   0xe5555555, SLOT_MIX),
 	[CXST_B4]	= __DEF_FBTC_SLOT(50,  0xe5555555, SLOT_MIX),
 	[CXST_LK]	= __DEF_FBTC_SLOT(20,  0xea5a5a5a, SLOT_ISO),
-	[CXST_BLK]	= __DEF_FBTC_SLOT(250, 0x55555555, SLOT_MIX),
-	[CXST_E2G]	= __DEF_FBTC_SLOT(20,  0xea5a5a5a, SLOT_MIX),
-	[CXST_E5G]	= __DEF_FBTC_SLOT(20,  0xffffffff, SLOT_MIX),
-	[CXST_EBT]	= __DEF_FBTC_SLOT(20,  0xe5555555, SLOT_MIX),
-	[CXST_ENULL]	= __DEF_FBTC_SLOT(7,   0xaaaaaaaa, SLOT_ISO),
+	[CXST_BLK]	= __DEF_FBTC_SLOT(500, 0x55555555, SLOT_MIX),
+	[CXST_E2G]	= __DEF_FBTC_SLOT(0,   0xea5a5a5a, SLOT_MIX),
+	[CXST_E5G]	= __DEF_FBTC_SLOT(0,   0xffffffff, SLOT_ISO),
+	[CXST_EBT]	= __DEF_FBTC_SLOT(0,   0xe5555555, SLOT_MIX),
+	[CXST_ENULL]	= __DEF_FBTC_SLOT(0,   0xaaaaaaaa, SLOT_ISO),
 	[CXST_WLK]	= __DEF_FBTC_SLOT(250, 0xea5a5a5a, SLOT_MIX),
-	[CXST_W1FDD]	= __DEF_FBTC_SLOT(35,  0xfafafafa, SLOT_ISO),
-	[CXST_B1FDD]	= __DEF_FBTC_SLOT(100, 0xffffffff, SLOT_MIX),
+	[CXST_W1FDD]	= __DEF_FBTC_SLOT(50,  0xffffffff, SLOT_ISO),
+	[CXST_B1FDD]	= __DEF_FBTC_SLOT(50,  0xffffdfff, SLOT_ISO),
 };
 
 static const u32 cxtbl[] = {
@@ -117,7 +117,12 @@ static const u32 cxtbl[] = {
 	0xfafafafa, /* 16 */
 	0xffffddff, /* 17 */
 	0xdaffdaff, /* 18 */
-	0xfafadafa  /* 19 */
+	0xfafadafa, /* 19 */
+	0xea6a6a6a, /* 20 */
+	0xea55556a, /* 21 */
+	0xaafafafa, /* 22 */
+	0xfafaaafa, /* 23 */
+	0xfafffaff  /* 24 */
 };
 
 static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
@@ -2701,15 +2706,16 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 			break;
 		case BTC_CXP_OFF_EQ0:
 			_slot_set_tbl(btc, CXST_OFF, cxtbl[0]);
+			_slot_set_type(btc, CXST_OFF, SLOT_ISO);
 			break;
 		case BTC_CXP_OFF_EQ1:
 			_slot_set_tbl(btc, CXST_OFF, cxtbl[16]);
 			break;
 		case BTC_CXP_OFF_EQ2:
-			_slot_set_tbl(btc, CXST_OFF, cxtbl[17]);
+			_slot_set_tbl(btc, CXST_OFF, cxtbl[0]);
 			break;
 		case BTC_CXP_OFF_EQ3:
-			_slot_set_tbl(btc, CXST_OFF, cxtbl[18]);
+			_slot_set_tbl(btc, CXST_OFF, cxtbl[24]);
 			break;
 		case BTC_CXP_OFF_BWB0:
 			_slot_set_tbl(btc, CXST_OFF, cxtbl[5]);
@@ -2765,6 +2771,7 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 		default:
 			break;
 		}
+		s[CXST_OFF] = s_def[CXST_OFF];
 		break;
 	case BTC_CXP_FIX: /* TDMA Fix-Slot */
 		_write_scbd(rtwdev, BTC_WSCB_TDMA, true);
@@ -2791,6 +2798,10 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 			_slot_set(btc, CXST_W1, 40, cxtbl[1], SLOT_ISO);
 			_slot_set(btc, CXST_B1, 10, tbl_b1, SLOT_MIX);
 			break;
+		case BTC_CXP_FIX_TD4020:
+			_slot_set(btc, CXST_W1, 40, cxtbl[1], SLOT_MIX);
+			_slot_set(btc, CXST_B1, 20, tbl_b1, SLOT_MIX);
+			break;
 		case BTC_CXP_FIX_TD7010:
 			_slot_set(btc, CXST_W1, 70, tbl_w1, SLOT_ISO);
 			_slot_set(btc, CXST_B1, 10, tbl_b1, SLOT_MIX);
-- 
2.25.1

