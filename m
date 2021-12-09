Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D857646E449
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 09:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbhLIIg5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 03:36:57 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:37347 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbhLIIg4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 03:36:56 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1B98XK2q8006440, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1B98XK2q8006440
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 9 Dec 2021 16:33:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Dec 2021 16:33:19 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 9 Dec
 2021 16:33:19 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <ku920601@realtek.com>
Subject: [PATCH 4/7] rtw89: coex: Define LPS state for BTC using
Date:   Thu, 9 Dec 2021 16:32:26 +0800
Message-ID: <20211209083229.10815-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211209083229.10815-1-pkshih@realtek.com>
References: <20211209083229.10815-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 12/09/2021 08:09:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzEyLzkgpFekyCAwNjozMjowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

To distinguish three types of LPS state.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 8 ++++----
 drivers/net/wireless/realtek/rtw89/coex.h | 6 ++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 8763114eab274..436f5ccb193a5 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1622,7 +1622,7 @@ static void _set_rf_trx_para(struct rtw89_dev *rtwdev)
 	_set_bt_rx_gain(rtwdev, para.bt_rx_gain);
 
 	if (bt->enable.now == 0 || wl->status.map.rf_off == 1 ||
-	    wl->status.map.lps == 1)
+	    wl->status.map.lps == BTC_LPS_RF_OFF)
 		wl_stb_chg = 0;
 	else
 		wl_stb_chg = 1;
@@ -4225,16 +4225,16 @@ void rtw89_btc_ntfy_radio_state(struct rtw89_dev *rtwdev, enum btc_rfctrl rf_sta
 	switch (rf_state) {
 	case BTC_RFCTRL_WL_OFF:
 		wl->status.map.rf_off = 1;
-		wl->status.map.lps = 0;
+		wl->status.map.lps = BTC_LPS_OFF;
 		break;
 	case BTC_RFCTRL_FW_CTRL:
 		wl->status.map.rf_off = 0;
-		wl->status.map.lps = 1;
+		wl->status.map.lps = BTC_LPS_RF_OFF;
 		break;
 	case BTC_RFCTRL_WL_ON:
 	default:
 		wl->status.map.rf_off = 0;
-		wl->status.map.lps = 0;
+		wl->status.map.lps = BTC_LPS_OFF;
 		break;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index 4b4565d15c9ec..c3a722d259d7f 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -130,6 +130,12 @@ enum btc_rfctrl {
 	BTC_RFCTRL_MAX
 };
 
+enum btc_lps_state {
+	BTC_LPS_OFF = 0,
+	BTC_LPS_RF_OFF = 1,
+	BTC_LPS_RF_ON = 2
+};
+
 void rtw89_btc_ntfy_poweron(struct rtw89_dev *rtwdev);
 void rtw89_btc_ntfy_poweroff(struct rtw89_dev *rtwdev);
 void rtw89_btc_ntfy_init(struct rtw89_dev *rtwdev, u8 mode);
-- 
2.25.1

