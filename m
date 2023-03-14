Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3266B880A
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 03:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjCNCHc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 22:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjCNCHb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 22:07:31 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F236C67725
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 19:07:30 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32E27BZB0011745, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32E27BZB0011745
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 14 Mar 2023 10:07:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 14 Mar 2023 10:07:23 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 14 Mar
 2023 10:07:22 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/5] wifi: rtw89: coex: Add LPS protocol radio state for RTL8852B
Date:   Tue, 14 Mar 2023 10:06:13 +0800
Message-ID: <20230314020617.28193-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314020617.28193-1-pkshih@realtek.com>
References: <20230314020617.28193-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
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

This LPS state will not turn off RF, and it can still do some basic
traffic, only RTL8852B has the state. Coexistence need let Bluetooth
know WiFi is still alive to prevent some Bluetooth performance issue.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 10 +++++++++-
 drivers/net/wireless/realtek/rtw89/coex.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 3dbd4ee14c70d..bd06388ea211e 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -5728,6 +5728,11 @@ void rtw89_btc_ntfy_radio_state(struct rtw89_dev *rtwdev, enum btc_rfctrl rf_sta
 		wl->status.map.lps = BTC_LPS_RF_OFF;
 		wl->status.map.busy = 0;
 		break;
+	case BTC_RFCTRL_LPS_WL_ON: /* LPS-Protocol (RFon) */
+		wl->status.map.rf_off = 0;
+		wl->status.map.lps = BTC_LPS_RF_ON;
+		wl->status.map.busy = 0;
+		break;
 	case BTC_RFCTRL_WL_ON:
 	default:
 		wl->status.map.rf_off = 0;
@@ -5745,6 +5750,9 @@ void rtw89_btc_ntfy_radio_state(struct rtw89_dev *rtwdev, enum btc_rfctrl rf_sta
 		rtw89_btc_fw_en_rpt(rtwdev, RPT_EN_ALL, false);
 		if (rf_state == BTC_RFCTRL_WL_OFF)
 			_write_scbd(rtwdev, BTC_WSCB_ALL, false);
+		else if (rf_state == BTC_RFCTRL_LPS_WL_ON &&
+			 wl->status.map.lps_pre != BTC_LPS_OFF)
+			_update_bt_scbd(rtwdev, true);
 	}
 
 	btc->dm.cnt_dm[BTC_DCNT_BTCNT_HANG] = 0;
@@ -5755,7 +5763,7 @@ void rtw89_btc_ntfy_radio_state(struct rtw89_dev *rtwdev, enum btc_rfctrl rf_sta
 		btc->dm.tdma_instant_excute = 0;
 
 	_run_coex(rtwdev, BTC_RSN_NTFY_RADIO_STATE);
-
+	btc->dm.tdma_instant_excute = 0;
 	wl->status.map.rf_off_pre = wl->status.map.rf_off;
 	wl->status.map.lps_pre = wl->status.map.lps;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index 38cc53a505c36..f16421cb30efb 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -131,6 +131,7 @@ enum btc_role_state {
 enum btc_rfctrl {
 	BTC_RFCTRL_WL_OFF,
 	BTC_RFCTRL_WL_ON,
+	BTC_RFCTRL_LPS_WL_ON,
 	BTC_RFCTRL_FW_CTRL,
 	BTC_RFCTRL_MAX
 };
-- 
2.25.1

