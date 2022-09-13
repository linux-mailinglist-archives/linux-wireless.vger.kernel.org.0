Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2071D5B6AA1
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Sep 2022 11:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiIMJ1A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Sep 2022 05:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiIMJ07 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Sep 2022 05:26:59 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B03C2A25C
        for <linux-wireless@vger.kernel.org>; Tue, 13 Sep 2022 02:26:57 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28D9QSVS0005511, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28D9QSVS0005511
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 13 Sep 2022 17:26:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 13 Sep 2022 17:26:49 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 13 Sep
 2022 17:26:49 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 1/7] wifi: rtw89: coex: use void pointer as temporal type to copy report
Date:   Tue, 13 Sep 2022 17:25:40 +0800
Message-ID: <20220913092546.43722-2-pkshih@realtek.com>
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

With void pointer, we don't need to cast to 'u8 *' by one by.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 33 ++++++++++++-----------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 732502b64b255..398bc395bc392 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -916,7 +916,8 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 	struct rtw89_btc_fbtc_cysta_cpu pcysta[1];
 	struct rtw89_btc_prpt *btc_prpt = NULL;
 	struct rtw89_btc_fbtc_slot *rtp_slot = NULL;
-	u8 rpt_type = 0, *rpt_content = NULL, *pfinfo = NULL;
+	void *rpt_content = NULL, *pfinfo = NULL;
+	u8 rpt_type = 0;
 	u16 wl_slot_set = 0, wl_slot_real = 0;
 	u32 trace_step = btc->ctrl.trace_step, rpt_len = 0, diff_t;
 	u32 cnt_leak_slot = 0, bt_slot_real = 0, cnt_rx_imr = 0;
@@ -944,10 +945,10 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 	case BTC_RPT_TYPE_CTRL:
 		pcinfo = &pfwinfo->rpt_ctrl.cinfo;
 		if (chip->chip_id == RTL8852A) {
-			pfinfo = (u8 *)(&pfwinfo->rpt_ctrl.finfo);
+			pfinfo = &pfwinfo->rpt_ctrl.finfo;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo);
 		} else {
-			pfinfo = (u8 *)(&pfwinfo->rpt_ctrl.finfo_v1);
+			pfinfo = &pfwinfo->rpt_ctrl.finfo_v1;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo_v1);
 		}
 		pcinfo->req_fver = chip->fcxbtcrpt_ver;
@@ -957,10 +958,10 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 	case BTC_RPT_TYPE_TDMA:
 		pcinfo = &pfwinfo->rpt_fbtc_tdma.cinfo;
 		if (chip->chip_id == RTL8852A) {
-			pfinfo = (u8 *)&pfwinfo->rpt_fbtc_tdma.finfo;
+			pfinfo = &pfwinfo->rpt_fbtc_tdma.finfo;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_tdma.finfo);
 		} else {
-			pfinfo = (u8 *)&pfwinfo->rpt_fbtc_tdma.finfo_v1;
+			pfinfo = &pfwinfo->rpt_fbtc_tdma.finfo_v1;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_tdma.finfo_v1);
 		}
 		pcinfo->req_fver = chip->fcxtdma_ver;
@@ -969,7 +970,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		break;
 	case BTC_RPT_TYPE_SLOT:
 		pcinfo = &pfwinfo->rpt_fbtc_slots.cinfo;
-		pfinfo = (u8 *)(&pfwinfo->rpt_fbtc_slots.finfo);
+		pfinfo = &pfwinfo->rpt_fbtc_slots.finfo;
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_slots.finfo);
 		pcinfo->req_fver = chip->fcxslots_ver;
 		pcinfo->rx_len = rpt_len;
@@ -978,12 +979,12 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 	case BTC_RPT_TYPE_CYSTA:
 		pcinfo = &pfwinfo->rpt_fbtc_cysta.cinfo;
 		if (chip->chip_id == RTL8852A) {
-			pfinfo = (u8 *)(&pfwinfo->rpt_fbtc_cysta.finfo);
+			pfinfo = &pfwinfo->rpt_fbtc_cysta.finfo;
 			pcysta_le32 = &pfwinfo->rpt_fbtc_cysta.finfo;
 			rtw89_btc_fbtc_cysta_to_cpu(pcysta_le32, pcysta);
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_cysta.finfo);
 		} else {
-			pfinfo = (u8 *)(&pfwinfo->rpt_fbtc_cysta.finfo_v1);
+			pfinfo = &pfwinfo->rpt_fbtc_cysta.finfo_v1;
 			pcysta_v1 = &pfwinfo->rpt_fbtc_cysta.finfo_v1;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_cysta.finfo_v1);
 		}
@@ -993,7 +994,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		break;
 	case BTC_RPT_TYPE_STEP:
 		pcinfo = &pfwinfo->rpt_fbtc_step.cinfo;
-		pfinfo = (u8 *)(&pfwinfo->rpt_fbtc_step.finfo);
+		pfinfo = &pfwinfo->rpt_fbtc_step.finfo;
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_step.finfo.step[0]) *
 				  trace_step + 8;
 		pcinfo->req_fver = chip->fcxstep_ver;
@@ -1002,7 +1003,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		break;
 	case BTC_RPT_TYPE_NULLSTA:
 		pcinfo = &pfwinfo->rpt_fbtc_nullsta.cinfo;
-		pfinfo = (u8 *)(&pfwinfo->rpt_fbtc_nullsta.finfo);
+		pfinfo = &pfwinfo->rpt_fbtc_nullsta.finfo;
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_nullsta.finfo);
 		pcinfo->req_fver = chip->fcxnullsta_ver;
 		pcinfo->rx_len = rpt_len;
@@ -1010,7 +1011,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		break;
 	case BTC_RPT_TYPE_MREG:
 		pcinfo = &pfwinfo->rpt_fbtc_mregval.cinfo;
-		pfinfo = (u8 *)(&pfwinfo->rpt_fbtc_mregval.finfo);
+		pfinfo = &pfwinfo->rpt_fbtc_mregval.finfo;
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_mregval.finfo);
 		pcinfo->req_fver = chip->fcxmreg_ver;
 		pcinfo->rx_len = rpt_len;
@@ -1018,7 +1019,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		break;
 	case BTC_RPT_TYPE_GPIO_DBG:
 		pcinfo = &pfwinfo->rpt_fbtc_gpio_dbg.cinfo;
-		pfinfo = (u8 *)(&pfwinfo->rpt_fbtc_gpio_dbg.finfo);
+		pfinfo = &pfwinfo->rpt_fbtc_gpio_dbg.finfo;
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_gpio_dbg.finfo);
 		pcinfo->req_fver = chip->fcxgpiodbg_ver;
 		pcinfo->rx_len = rpt_len;
@@ -1026,7 +1027,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		break;
 	case BTC_RPT_TYPE_BT_VER:
 		pcinfo = &pfwinfo->rpt_fbtc_btver.cinfo;
-		pfinfo = (u8 *)(&pfwinfo->rpt_fbtc_btver.finfo);
+		pfinfo = &pfwinfo->rpt_fbtc_btver.finfo;
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btver.finfo);
 		pcinfo->req_fver = chip->fcxbtver_ver;
 		pcinfo->rx_len = rpt_len;
@@ -1034,7 +1035,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		break;
 	case BTC_RPT_TYPE_BT_SCAN:
 		pcinfo = &pfwinfo->rpt_fbtc_btscan.cinfo;
-		pfinfo = (u8 *)(&pfwinfo->rpt_fbtc_btscan.finfo);
+		pfinfo = &pfwinfo->rpt_fbtc_btscan.finfo;
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btscan.finfo);
 		pcinfo->req_fver = chip->fcxbtscan_ver;
 		pcinfo->rx_len = rpt_len;
@@ -1042,7 +1043,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		break;
 	case BTC_RPT_TYPE_BT_AFH:
 		pcinfo = &pfwinfo->rpt_fbtc_btafh.cinfo;
-		pfinfo = (u8 *)(&pfwinfo->rpt_fbtc_btafh.finfo);
+		pfinfo = &pfwinfo->rpt_fbtc_btafh.finfo;
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btafh.finfo);
 		pcinfo->req_fver = chip->fcxbtafh_ver;
 		pcinfo->rx_len = rpt_len;
@@ -1050,7 +1051,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		break;
 	case BTC_RPT_TYPE_BT_DEVICE:
 		pcinfo = &pfwinfo->rpt_fbtc_btdev.cinfo;
-		pfinfo = (u8 *)(&pfwinfo->rpt_fbtc_btdev.finfo);
+		pfinfo = &pfwinfo->rpt_fbtc_btdev.finfo;
 		pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btdev.finfo);
 		pcinfo->req_fver = chip->fcxbtdevinfo_ver;
 		pcinfo->rx_len = rpt_len;
-- 
2.25.1

