Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387C764F939
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Dec 2022 15:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiLQOSU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Dec 2022 09:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiLQOSP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Dec 2022 09:18:15 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 409F41208F
        for <linux-wireless@vger.kernel.org>; Sat, 17 Dec 2022 06:18:14 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2BHEHBSx8024820, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2BHEHBSx8024820
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sat, 17 Dec 2022 22:17:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Sat, 17 Dec 2022 22:18:02 +0800
Received: from localhost (172.16.16.141) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sat, 17 Dec
 2022 22:18:01 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/7] wifi: rtw89: coex: Update BTC firmware report bitmap definition
Date:   Sat, 17 Dec 2022 22:17:42 +0800
Message-ID: <20221217141745.43291-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221217141745.43291-1-pkshih@realtek.com>
References: <20221217141745.43291-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.141]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 12/17/2022 14:00:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzE3IKRXpMggMTE6MjQ6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

The different version use different bit definition to enable firmware
report. WiFi firmware will report information from Bluetooth firmware or
some Wi-Fi firmware mechanism/status to driver by these bits. To solve the
difference, add a function to map bitmap and versions.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 177 ++++++++++++++++++++--
 1 file changed, 164 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index b58c839e10d92..6840f0363d96c 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -191,16 +191,20 @@ struct rtw89_btc_btf_tlv {
 } __packed;
 
 enum btc_btf_set_report_en {
-	RPT_EN_TDMA = BIT(0),
-	RPT_EN_CYCLE = BIT(1),
-	RPT_EN_MREG = BIT(2),
-	RPT_EN_BT_VER_INFO = BIT(3),
-	RPT_EN_BT_SCAN_INFO = BIT(4),
-	RPT_EN_BT_AFH_MAP = BIT(5),
-	RPT_EN_BT_DEVICE_INFO = BIT(6),
-	RPT_EN_WL_ALL = GENMASK(2, 0),
-	RPT_EN_BT_ALL = GENMASK(6, 3),
-	RPT_EN_ALL = GENMASK(6, 0),
+	RPT_EN_TDMA,
+	RPT_EN_CYCLE,
+	RPT_EN_MREG,
+	RPT_EN_BT_VER_INFO,
+	RPT_EN_BT_SCAN_INFO,
+	RPT_EN_BT_DEVICE_INFO,
+	RPT_EN_BT_AFH_MAP,
+	RPT_EN_BT_AFH_MAP_LE,
+	RPT_EN_FW_STEP_INFO,
+	RPT_EN_TEST,
+	RPT_EN_WL_ALL,
+	RPT_EN_BT_ALL,
+	RPT_EN_ALL,
+	RPT_EN_MONITER,
 };
 
 #define BTF_SET_REPORT_VER 1
@@ -1507,22 +1511,169 @@ static void _append_slot(struct rtw89_dev *rtwdev)
 			    __func__, cnt);
 }
 
+static u32 rtw89_btc_fw_rpt_ver(struct rtw89_dev *rtwdev, u32 rpt_map)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *ver = btc->ver;
+	u32 bit_map = 0;
+
+	switch (rpt_map) {
+	case RPT_EN_TDMA:
+		bit_map = BIT(0);
+		break;
+	case RPT_EN_CYCLE:
+		bit_map = BIT(1);
+		break;
+	case RPT_EN_MREG:
+		bit_map = BIT(2);
+		break;
+	case RPT_EN_BT_VER_INFO:
+		bit_map = BIT(3);
+		break;
+	case RPT_EN_BT_SCAN_INFO:
+		bit_map = BIT(4);
+		break;
+	case RPT_EN_BT_DEVICE_INFO:
+		switch (ver->frptmap) {
+		case 0:
+		case 1:
+		case 2:
+			bit_map = BIT(6);
+			break;
+		case 3:
+			bit_map = BIT(5);
+			break;
+		default:
+			break;
+		}
+		break;
+	case RPT_EN_BT_AFH_MAP:
+		switch (ver->frptmap) {
+		case 0:
+		case 1:
+		case 2:
+			bit_map = BIT(5);
+			break;
+		case 3:
+			bit_map = BIT(6);
+			break;
+		default:
+			break;
+		}
+		break;
+	case RPT_EN_BT_AFH_MAP_LE:
+		switch (ver->frptmap) {
+		case 2:
+			bit_map = BIT(8);
+			break;
+		case 3:
+			bit_map = BIT(7);
+			break;
+		default:
+			break;
+		}
+		break;
+	case RPT_EN_FW_STEP_INFO:
+		switch (ver->frptmap) {
+		case 1:
+		case 2:
+			bit_map = BIT(7);
+			break;
+		case 3:
+			bit_map = BIT(8);
+			break;
+		default:
+			break;
+		}
+		break;
+	case RPT_EN_TEST:
+		bit_map = BIT(31);
+		break;
+	case RPT_EN_WL_ALL:
+		switch (ver->frptmap) {
+		case 0:
+		case 1:
+		case 2:
+			bit_map = GENMASK(2, 0);
+			break;
+		case 3:
+			bit_map = GENMASK(2, 0) | BIT(8);
+			break;
+		default:
+			break;
+		}
+		break;
+	case RPT_EN_BT_ALL:
+		switch (ver->frptmap) {
+		case 0:
+		case 1:
+			bit_map = GENMASK(6, 3);
+			break;
+		case 2:
+			bit_map = GENMASK(6, 3) | BIT(8);
+			break;
+		case 3:
+			bit_map = GENMASK(7, 3);
+			break;
+		default:
+			break;
+		}
+		break;
+	case RPT_EN_ALL:
+		switch (ver->frptmap) {
+		case 0:
+			bit_map = GENMASK(6, 0);
+			break;
+		case 1:
+			bit_map = GENMASK(7, 0);
+			break;
+		case 2:
+		case 3:
+			bit_map = GENMASK(8, 0);
+			break;
+		default:
+			break;
+		}
+		break;
+	case RPT_EN_MONITER:
+		switch (ver->frptmap) {
+		case 0:
+		case 1:
+			bit_map = GENMASK(6, 2);
+			break;
+		case 2:
+			bit_map = GENMASK(6, 2) | BIT(8);
+			break;
+		case 3:
+			bit_map = GENMASK(8, 2);
+			break;
+		default:
+			break;
+		}
+		break;
+	}
+
+	return bit_map;
+}
+
 static void rtw89_btc_fw_en_rpt(struct rtw89_dev *rtwdev,
 				u32 rpt_map, bool rpt_state)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_btf_fwinfo *fwinfo = &btc->fwinfo;
 	struct rtw89_btc_btf_set_report r = {0};
-	u32 val = 0;
+	u32 val, bit_map;
+
+	bit_map = rtw89_btc_fw_rpt_ver(rtwdev, rpt_map);
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], %s(): rpt_map=%x, rpt_state=%x\n",
 		    __func__, rpt_map, rpt_state);
 
 	if (rpt_state)
-		val = fwinfo->rpt_en_map | rpt_map;
+		val = fwinfo->rpt_en_map | bit_map;
 	else
-		val = fwinfo->rpt_en_map & ~rpt_map;
+		val = fwinfo->rpt_en_map & ~bit_map;
 
 	if (val == fwinfo->rpt_en_map)
 		return;
-- 
2.25.1

