Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A3457C622
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Jul 2022 10:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiGUIWZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Jul 2022 04:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiGUIWY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Jul 2022 04:22:24 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB1157E015
        for <linux-wireless@vger.kernel.org>; Thu, 21 Jul 2022 01:22:22 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 26L8MAa44010396, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 26L8MAa44010396
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 21 Jul 2022 16:22:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 21 Jul 2022 16:22:15 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Thu, 21 Jul
 2022 16:22:14 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/9] rtw89: coex: update radio state for RTL8852A/RTL8852C
Date:   Thu, 21 Jul 2022 16:21:40 +0800
Message-ID: <20220721082148.29682-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721082148.29682-1-pkshih@realtek.com>
References: <20220721082148.29682-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 07/21/2022 08:09:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzcvMjEgpFekyCAwNzoxODowMA==?=
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

Update scoreboard setting to let Bluetooth know Wi-Fi power save state.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 24 ++++++++++++++++-------
 drivers/net/wireless/realtek/rtw89/core.h |  4 ++--
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 5e169388867f8..286dd086a1338 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -551,8 +551,10 @@ static void _send_fw_cmd(struct rtw89_dev *rtwdev, u8 h2c_class, u8 h2c_func,
 			    "[BTC], %s(): return by btc not init!!\n", __func__);
 		pfwinfo->cnt_h2c_fail++;
 		return;
-	} else if ((wl->status.map.rf_off_pre == 1 && wl->status.map.rf_off == 1) ||
-		   (wl->status.map.lps_pre == 1 && wl->status.map.lps == 1)) {
+	} else if ((wl->status.map.rf_off_pre == BTC_LPS_RF_OFF &&
+		    wl->status.map.rf_off == BTC_LPS_RF_OFF) ||
+		   (wl->status.map.lps_pre == BTC_LPS_RF_OFF &&
+		    wl->status.map.lps == BTC_LPS_RF_OFF)) {
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): return by wl off!!\n", __func__);
 		pfwinfo->cnt_h2c_fail++;
@@ -3743,11 +3745,14 @@ void rtw89_btc_ntfy_poweron(struct rtw89_dev *rtwdev)
 void rtw89_btc_ntfy_poweroff(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s(): !!\n", __func__);
 	btc->dm.cnt_notify[BTC_NCNT_POWER_OFF]++;
 
 	btc->cx.wl.status.map.rf_off = 1;
+	btc->cx.wl.status.map.busy = 0;
+	wl->status.map.lps = BTC_LPS_OFF;
 
 	_write_scbd(rtwdev, BTC_WSCB_ALL, false);
 	_run_coex(rtwdev, BTC_RSN_NTFY_POWEROFF);
@@ -4239,6 +4244,7 @@ void rtw89_btc_ntfy_radio_state(struct rtw89_dev *rtwdev, enum btc_rfctrl rf_sta
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	u32 val;
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s(): rf_state = %d\n",
 		    __func__, rf_state);
@@ -4248,10 +4254,12 @@ void rtw89_btc_ntfy_radio_state(struct rtw89_dev *rtwdev, enum btc_rfctrl rf_sta
 	case BTC_RFCTRL_WL_OFF:
 		wl->status.map.rf_off = 1;
 		wl->status.map.lps = BTC_LPS_OFF;
+		wl->status.map.busy = 0;
 		break;
 	case BTC_RFCTRL_FW_CTRL:
 		wl->status.map.rf_off = 0;
 		wl->status.map.lps = BTC_LPS_RF_OFF;
+		wl->status.map.busy = 0;
 		break;
 	case BTC_RFCTRL_WL_ON:
 	default:
@@ -4261,14 +4269,17 @@ void rtw89_btc_ntfy_radio_state(struct rtw89_dev *rtwdev, enum btc_rfctrl rf_sta
 	}
 
 	if (rf_state == BTC_RFCTRL_WL_ON) {
+		btc->dm.cnt_dm[BTC_DCNT_BTCNT_FREEZE] = 0;
 		rtw89_btc_fw_en_rpt(rtwdev,
 				    RPT_EN_MREG | RPT_EN_BT_VER_INFO, true);
-		_write_scbd(rtwdev, BTC_WSCB_ACTIVE, true);
+		val = BTC_WSCB_ACTIVE | BTC_WSCB_ON | BTC_WSCB_BTLOG;
+		_write_scbd(rtwdev, val, true);
 		_update_bt_scbd(rtwdev, true);
 		chip->ops->btc_init_cfg(rtwdev);
 	} else {
 		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_ALL, false);
-		_write_scbd(rtwdev, BTC_WSCB_ACTIVE | BTC_WSCB_WLBUSY, false);
+		if (rf_state == BTC_RFCTRL_WL_OFF)
+			_write_scbd(rtwdev, BTC_WSCB_ALL, false);
 	}
 
 	_run_coex(rtwdev, BTC_RSN_NTFY_RADIO_STATE);
@@ -4739,9 +4750,8 @@ static void _show_wl_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 		   "[status]", (u32)wl_rinfo->link_mode);
 
 	seq_printf(m,
-		   "rf_off:%s, power_save:%s, scan:%s(band:%d/phy_map:0x%x), ",
-		   wl->status.map.rf_off ? "Y" : "N",
-		   wl->status.map.lps ? "Y" : "N",
+		   "rf_off:%d, power_save:%d, scan:%s(band:%d/phy_map:0x%x), ",
+		   wl->status.map.rf_off, wl->status.map.lps,
 		   wl->status.map.scan ? "Y" : "N",
 		   wl->scan_info.band[RTW89_PHY_0], wl->scan_info.phy_map);
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 47dee2b37620a..05b5282c770da 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -936,12 +936,12 @@ struct rtw89_btc_wl_smap {
 	u32 roaming: 1;
 	u32 _4way: 1;
 	u32 rf_off: 1;
-	u32 lps: 1;
+	u32 lps: 2;
 	u32 ips: 1;
 	u32 init_ok: 1;
 	u32 traffic_dir : 2;
 	u32 rf_off_pre: 1;
-	u32 lps_pre: 1;
+	u32 lps_pre: 2;
 };
 
 enum rtw89_tfc_lv {
-- 
2.25.1

