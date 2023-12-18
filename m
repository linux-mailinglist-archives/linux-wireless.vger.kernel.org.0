Return-Path: <linux-wireless+bounces-887-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 772F6816660
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 07:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044A71F22ACE
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 06:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACF7C8F1;
	Mon, 18 Dec 2023 06:15:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D309847F
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 06:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BI6FCFs83224869, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BI6FCFs83224869
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 14:15:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 18 Dec 2023 14:15:13 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 18 Dec
 2023 14:15:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 06/11] wifi: rtw89: coex: Update coexistence policy for Wi-Fi LPS
Date: Mon, 18 Dec 2023 14:13:36 +0800
Message-ID: <20231218061341.51255-7-pkshih@realtek.com>
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

From: Ching-Te Ku <ku920601@realtek.com>

Including Wi-Fi RF mode to judge is Wi-Fi RF still on or off,
if Wi-Fi is RF off should set scoreboard to let Bluetooth know
Wi-Fi has gone. Every time the Wi-Fi radio state changed firmware
should force execute refresh the TDMA coexistence mechanism to
prevent incorrect mechanism runs at mismatch state. The coexistence
antenna/TDMA settings should consider what the Wi-Fi mode it is now,
this can help to solve some LPS transient state issue like A2DP
slightly glitch.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 70 +++++++++++++++--------
 1 file changed, 46 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index a5373660da5b..e89af5915657 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -3503,17 +3503,32 @@ static void _action_wl_init(struct rtw89_dev *rtwdev)
 	_set_policy(rtwdev, BTC_CXP_OFF_BT, BTC_ACT_WL_INIT);
 }
 
-static void _action_wl_off(struct rtw89_dev *rtwdev)
+static void _action_wl_off(struct rtw89_dev *rtwdev, u8 mode)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s(): !!\n", __func__);
 
-	if (wl->status.map.rf_off || btc->dm.bt_only)
+	if (wl->status.map.rf_off || btc->dm.bt_only) {
 		_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_WOFF);
+	} else if (wl->status.map.lps == BTC_LPS_RF_ON) {
+		if (wl->role_info.link_mode == BTC_WLINK_5G)
+			_set_ant(rtwdev, FC_EXEC, BTC_PHY_ALL, BTC_ANT_W5G);
+		else
+			_set_ant(rtwdev, FC_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
+	}
 
-	_set_policy(rtwdev, BTC_CXP_OFF_BT, BTC_ACT_WL_OFF);
+	if (mode == BTC_WLINK_5G) {
+		_set_policy(rtwdev, BTC_CXP_OFF_EQ0, BTC_ACT_WL_OFF);
+	} else if (wl->status.map.lps == BTC_LPS_RF_ON) {
+		if (btc->cx.bt.link_info.a2dp_desc.active)
+			_set_policy(rtwdev, BTC_CXP_OFF_BT, BTC_ACT_WL_OFF);
+		else
+			_set_policy(rtwdev, BTC_CXP_OFF_BWB1, BTC_ACT_WL_OFF);
+	} else {
+		_set_policy(rtwdev, BTC_CXP_OFF_BT, BTC_ACT_WL_OFF);
+	}
 }
 
 static void _action_freerun(struct rtw89_dev *rtwdev)
@@ -5339,17 +5354,28 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 	}
 
 	if (wl->status.map.rf_off_pre == wl->status.map.rf_off &&
-	    wl->status.map.lps_pre == wl->status.map.lps &&
-	    (reason == BTC_RSN_NTFY_POWEROFF ||
-	    reason == BTC_RSN_NTFY_RADIO_STATE)) {
-		rtw89_debug(rtwdev, RTW89_DBG_BTC,
-			    "[BTC], %s(): return for WL rf off state no change!!\n",
-			    __func__);
-		return;
+	    wl->status.map.lps_pre == wl->status.map.lps) {
+		if (reason == BTC_RSN_NTFY_POWEROFF ||
+		    reason == BTC_RSN_NTFY_RADIO_STATE) {
+			rtw89_debug(rtwdev, RTW89_DBG_BTC,
+				    "[BTC], %s(): return for WL rf off state no change!!\n",
+				    __func__);
+			return;
+		}
+		if (wl->status.map.rf_off == 1 ||
+		    wl->status.map.lps == BTC_LPS_RF_OFF) {
+			rtw89_debug(rtwdev, RTW89_DBG_BTC,
+				    "[BTC], %s(): return for WL rf off state!!\n",
+				    __func__);
+			return;
+		}
 	}
 
+	dm->freerun = false;
 	dm->cnt_dm[BTC_DCNT_RUN]++;
 	dm->fddt_train = BTC_FDDT_DISABLE;
+	btc->ctrl.igno_bt = false;
+	bt->scan_rx_low_pri = false;
 
 	if (btc->ctrl.always_freerun) {
 		_action_freerun(rtwdev);
@@ -5364,15 +5390,11 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 	}
 
 	if (wl->status.map.rf_off || wl->status.map.lps || dm->bt_only) {
-		_action_wl_off(rtwdev);
+		_action_wl_off(rtwdev, mode);
 		btc->ctrl.igno_bt = true;
 		goto exit;
 	}
 
-	btc->ctrl.igno_bt = false;
-	dm->freerun = false;
-	bt->scan_rx_low_pri = false;
-
 	if (reason == BTC_RSN_NTFY_INIT) {
 		_action_wl_init(rtwdev);
 		goto exit;
@@ -6016,22 +6038,22 @@ void rtw89_btc_ntfy_radio_state(struct rtw89_dev *rtwdev, enum btc_rfctrl rf_sta
 		chip->ops->btc_init_cfg(rtwdev);
 	} else {
 		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_ALL, false);
-		if (rf_state == BTC_RFCTRL_WL_OFF)
+		if (rf_state == BTC_RFCTRL_FW_CTRL)
+			_write_scbd(rtwdev, BTC_WSCB_ACTIVE, false);
+		else if (rf_state == BTC_RFCTRL_WL_OFF)
 			_write_scbd(rtwdev, BTC_WSCB_ALL, false);
-		else if (rf_state == BTC_RFCTRL_LPS_WL_ON &&
-			 wl->status.map.lps_pre != BTC_LPS_OFF)
+		else
+			_write_scbd(rtwdev, BTC_WSCB_ACTIVE, false);
+
+		if (rf_state == BTC_RFCTRL_LPS_WL_ON &&
+		    wl->status.map.lps_pre != BTC_LPS_OFF)
 			_update_bt_scbd(rtwdev, true);
 	}
 
 	btc->dm.cnt_dm[BTC_DCNT_BTCNT_HANG] = 0;
-	if (wl->status.map.lps_pre == BTC_LPS_OFF &&
-	    wl->status.map.lps_pre != wl->status.map.lps)
-		btc->dm.tdma_instant_excute = 1;
-	else
-		btc->dm.tdma_instant_excute = 0;
+	btc->dm.tdma_instant_excute = 1;
 
 	_run_coex(rtwdev, BTC_RSN_NTFY_RADIO_STATE);
-	btc->dm.tdma_instant_excute = 0;
 	wl->status.map.rf_off_pre = wl->status.map.rf_off;
 	wl->status.map.lps_pre = wl->status.map.lps;
 }
-- 
2.25.1


