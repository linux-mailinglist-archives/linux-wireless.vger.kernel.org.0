Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF9164F937
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Dec 2022 15:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiLQOSV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Dec 2022 09:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiLQOSP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Dec 2022 09:18:15 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6822C11C1B
        for <linux-wireless@vger.kernel.org>; Sat, 17 Dec 2022 06:18:14 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2BHEHAS30024814, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2BHEHAS30024814
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sat, 17 Dec 2022 22:17:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Sat, 17 Dec 2022 22:18:01 +0800
Received: from localhost (172.16.16.141) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sat, 17 Dec
 2022 22:18:00 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/7] wifi: rtw89: coex: Enable Bluetooth report when show debug info
Date:   Sat, 17 Dec 2022 22:17:41 +0800
Message-ID: <20221217141745.43291-4-pkshih@realtek.com>
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

Ask WiFi firmware to send Bluetooth version report when we want to show
Bluetooth debug info. If there is no request for debug log, driver will
not enable the report. This modification can save some C2H/H2C resources.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 32 ++++++++++++++---------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index df3984ebba06e..b58c839e10d92 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -5066,11 +5066,6 @@ static void _update_bt_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 
 	a2dp->sink = btinfo.hb3.a2dp_sink;
 
-	if (b->profile_cnt.now || b->status.map.ble_connect)
-		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_AFH_MAP, 1);
-	else
-		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_AFH_MAP, 0);
-
 	if (!a2dp->exist_last && a2dp->exist) {
 		a2dp->vendor_id = 0;
 		a2dp->flush_time = 0;
@@ -5080,12 +5075,6 @@ static void _update_bt_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 					     RTW89_COEX_BT_DEVINFO_WORK_PERIOD);
 	}
 
-	if (a2dp->exist && (a2dp->flush_time == 0 || a2dp->vendor_id == 0 ||
-			    a2dp->play_latency == 1))
-		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_DEVICE_INFO, 1);
-	else
-		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_DEVICE_INFO, 0);
-
 	_run_coex(rtwdev, BTC_RSN_UPDATE_BT_INFO);
 }
 
@@ -5218,8 +5207,7 @@ void rtw89_btc_ntfy_radio_state(struct rtw89_dev *rtwdev, enum btc_rfctrl rf_sta
 
 	if (rf_state == BTC_RFCTRL_WL_ON) {
 		btc->dm.cnt_dm[BTC_DCNT_BTCNT_FREEZE] = 0;
-		rtw89_btc_fw_en_rpt(rtwdev,
-				    RPT_EN_MREG | RPT_EN_BT_VER_INFO, true);
+		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_MREG, true);
 		val = BTC_WSCB_ACTIVE | BTC_WSCB_ON | BTC_WSCB_BTLOG;
 		_write_scbd(rtwdev, val, true);
 		_update_bt_scbd(rtwdev, true);
@@ -5866,6 +5854,24 @@ static void _show_bt_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 		   "[trx_req_cnt]", cx->cnt_bt[BTC_BCNT_HIPRI_RX],
 		   cx->cnt_bt[BTC_BCNT_HIPRI_TX], cx->cnt_bt[BTC_BCNT_LOPRI_RX],
 		   cx->cnt_bt[BTC_BCNT_LOPRI_TX], cx->cnt_bt[BTC_BCNT_POLUT]);
+
+	if (bt->enable.now && bt->ver_info.fw == 0)
+		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_VER_INFO, true);
+	else
+		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_VER_INFO, false);
+
+	if (bt_linfo->profile_cnt.now || bt_linfo->status.map.ble_connect)
+		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_AFH_MAP, true);
+	else
+		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_AFH_MAP, false);
+
+	if (bt_linfo->a2dp_desc.exist &&
+	    (bt_linfo->a2dp_desc.flush_time == 0 ||
+	     bt_linfo->a2dp_desc.vendor_id == 0 ||
+	     bt_linfo->a2dp_desc.play_latency == 1))
+		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_DEVICE_INFO, true);
+	else
+		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_BT_DEVICE_INFO, false);
 }
 
 #define CASE_BTC_RSN_STR(e) case BTC_RSN_ ## e: return #e
-- 
2.25.1

