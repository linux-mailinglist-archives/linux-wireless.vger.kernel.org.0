Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D54B5BD933
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 03:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiITBLq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 21:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiITBLZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 21:11:25 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95D8C52E5B
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 18:10:33 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28K1A2MI0031081, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28K1A2MI0031081
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 20 Sep 2022 09:10:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 20 Sep 2022 09:10:24 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 20 Sep
 2022 09:10:24 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 7/9] wifi: rtw89: coex: summarize Wi-Fi to BT scoreboard and inform BT one time a cycle
Date:   Tue, 20 Sep 2022 09:09:37 +0800
Message-ID: <20220920010939.12173-8-pkshih@realtek.com>
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

If Wi-Fi driver send Wi-Fi status to BT via scoreboard too frequent in a
short moment, BT will loss some of them because of hardware response time.
To avoid this issue, change the code flow. Summarize the scoreboard changes
and if the value have changed, send the scoreboard to BT only once in
a coexistence processing cycle. It also can help to reduce driver I/O.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 25 ++++++++++++++++-------
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 85c8e7ffb56c7..ef6c5701ebcf5 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -3558,11 +3558,22 @@ static void _set_bt_rx_agc(struct rtw89_dev *rtwdev)
 /* TODO add these functions */
 static void _action_common(struct rtw89_dev *rtwdev)
 {
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+
 	_set_btg_ctrl(rtwdev);
 	_set_wl_tx_limit(rtwdev);
 	_set_bt_afh_info(rtwdev);
 	_set_bt_rx_agc(rtwdev);
 	_set_rf_trx_para(rtwdev);
+
+	if (wl->scbd_change) {
+		rtw89_mac_cfg_sb(rtwdev, wl->scbd);
+		rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], write scbd: 0x%08x\n",
+			    wl->scbd);
+		wl->scbd_change = false;
+		btc->cx.cnt_wl[BTC_WCNT_SCBDUPDATE]++;
+	}
 }
 
 static void _action_by_bt(struct rtw89_dev *rtwdev)
@@ -3885,20 +3896,20 @@ static void _write_scbd(struct rtw89_dev *rtwdev, u32 val, bool state)
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	u32 scbd_val = 0;
+	u8 force_exec = false;
 
 	if (!chip->scbd)
 		return;
 
 	scbd_val = state ? wl->scbd | val : wl->scbd & ~val;
 
-	if (scbd_val == wl->scbd)
-		return;
-	rtw89_mac_cfg_sb(rtwdev, scbd_val);
-	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], write scbd: 0x%08x\n",
-		    scbd_val);
-	wl->scbd = scbd_val;
+	if (val & BTC_WSCB_ACTIVE || val & BTC_WSCB_ON)
+		force_exec = true;
 
-	btc->cx.cnt_wl[BTC_WCNT_SCBDUPDATE]++;
+	if (scbd_val != wl->scbd || force_exec) {
+		wl->scbd = scbd_val;
+		wl->scbd_change = true;
+	}
 }
 
 static u8
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c4eefa54ed864..8af1813cba884 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1308,6 +1308,7 @@ struct rtw89_btc_wl_info {
 	u8 port_id[RTW89_WIFI_ROLE_MLME_MAX];
 	u8 rssi_level;
 
+	bool scbd_change;
 	u32 scbd;
 };
 
-- 
2.25.1

