Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559DF7980DB
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Sep 2023 05:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238449AbjIHDNG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Sep 2023 23:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238444AbjIHDNF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Sep 2023 23:13:05 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAB91BD8
        for <linux-wireless@vger.kernel.org>; Thu,  7 Sep 2023 20:13:00 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3883Cp6C21359701, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 3883Cp6C21359701
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Sep 2023 11:12:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 8 Sep 2023 11:12:52 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 8 Sep 2023
 11:12:51 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/8] wifi: rtw89: 52c: rfk: disable DPK during MCC
Date:   Fri, 8 Sep 2023 11:11:40 +0800
Message-ID: <20230908031145.20931-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230908031145.20931-1-pkshih@realtek.com>
References: <20230908031145.20931-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.25]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

DPK is one kind of RF calibration. When MCC (multi-channel concurrency)
start/stop, DPK needs to do extra things to be off/on. We add a chanctx
callback type, RTW89_CHANCTX_CALLBACK_RFK, and register it for RTL8852C
to deal with DPK according to MCC states.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  7 ++++
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c | 33 +++++++++++++++++--
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.h |  3 ++
 4 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 2eaf1df205ec..43a81acdaacf 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3429,6 +3429,7 @@ enum rtw89_chanctx_state {
 
 enum rtw89_chanctx_callbacks {
 	RTW89_CHANCTX_CALLBACK_PLACEHOLDER,
+	RTW89_CHANCTX_CALLBACK_RFK,
 
 	NUM_OF_RTW89_CHANCTX_CALLBACKS,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 7f80e0bf40a4..e344b76c6025 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2019-2022  Realtek Corporation
  */
 
+#include "chan.h"
 #include "coex.h"
 #include "debug.h"
 #include "fw.h"
@@ -1776,6 +1777,7 @@ static void rtw8852c_rfk_init(struct rtw89_dev *rtwdev)
 	rtwdev->is_tssi_mode[RF_PATH_B] = false;
 	memset(rfk_mcc, 0, sizeof(*rfk_mcc));
 	rtw8852c_lck_init(rtwdev);
+	rtw8852c_dpk_init(rtwdev);
 
 	rtw8852c_rck(rtwdev);
 	rtw8852c_dack(rtwdev);
@@ -2748,6 +2750,10 @@ static int rtw8852c_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static const struct rtw89_chanctx_listener rtw8852c_chanctx_listener = {
+	.callbacks[RTW89_CHANCTX_CALLBACK_RFK] = rtw8852c_rfk_chanctx_cb,
+};
+
 #ifdef CONFIG_PM
 static const struct wiphy_wowlan_support rtw_wowlan_stub_8852c = {
 	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT,
@@ -2841,6 +2847,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.byr_table		= &rtw89_8852c_byr_table,
 	.dflt_parms		= &rtw89_8852c_dflt_parms,
 	.rfe_parms_conf		= NULL,
+	.chanctx_listener	= &rtw8852c_chanctx_listener,
 	.txpwr_factor_rf	= 2,
 	.txpwr_factor_mac	= 1,
 	.dig_table		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index badd829ecfaa..654e3e5507cb 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -4265,6 +4265,14 @@ void rtw8852c_rx_dck_track(struct rtw89_dev *rtwdev)
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_RXDCK, BTC_WRFK_STOP);
 }
 
+void rtw8852c_dpk_init(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+
+	dpk->is_dpk_enable = true;
+	dpk->is_dpk_reload_en = false;
+}
+
 void rtw8852c_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	u32 tx_en;
@@ -4274,8 +4282,6 @@ void rtw8852c_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 	rtw89_chip_stop_sch_tx(rtwdev, phy_idx, &tx_en, RTW89_SCH_TX_SEL_ALL);
 	_wait_rx_mode(rtwdev, _kpath(rtwdev, phy_idx));
 
-	rtwdev->dpk.is_dpk_enable = true;
-	rtwdev->dpk.is_dpk_reload_en = false;
 	_dpk(rtwdev, phy_idx, false);
 
 	rtw89_chip_resume_sch_tx(rtwdev, phy_idx, tx_en);
@@ -4413,3 +4419,26 @@ void rtw8852c_wifi_scan_notify(struct rtw89_dev *rtwdev,
 	else
 		rtw8852c_tssi_default_txagc(rtwdev, phy_idx, false);
 }
+
+void rtw8852c_rfk_chanctx_cb(struct rtw89_dev *rtwdev,
+			     enum rtw89_chanctx_state state)
+{
+	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	u8 path;
+
+	switch (state) {
+	case RTW89_CHANCTX_STATE_MCC_START:
+		dpk->is_dpk_enable = false;
+		for (path = 0; path < RTW8852C_DPK_RF_PATH; path++)
+			_dpk_onoff(rtwdev, path, false);
+		break;
+	case RTW89_CHANCTX_STATE_MCC_STOP:
+		dpk->is_dpk_enable = true;
+		for (path = 0; path < RTW8852C_DPK_RF_PATH; path++)
+			_dpk_onoff(rtwdev, path, false);
+		rtw8852c_dpk(rtwdev, RTW89_PHY_0);
+		break;
+	default:
+		break;
+	}
+}
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
index 928a587cdd05..6605137e61aa 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
@@ -13,6 +13,7 @@ void rtw8852c_dack(struct rtw89_dev *rtwdev);
 void rtw8852c_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 void rtw8852c_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, bool is_afe);
 void rtw8852c_rx_dck_track(struct rtw89_dev *rtwdev);
+void rtw8852c_dpk_init(struct rtw89_dev *rtwdev);
 void rtw8852c_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
 void rtw8852c_dpk_track(struct rtw89_dev *rtwdev);
 void rtw8852c_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
@@ -25,5 +26,7 @@ void rtw8852c_set_channel_rf(struct rtw89_dev *rtwdev,
 			     enum rtw89_phy_idx phy_idx);
 void rtw8852c_lck_init(struct rtw89_dev *rtwdev);
 void rtw8852c_lck_track(struct rtw89_dev *rtwdev);
+void rtw8852c_rfk_chanctx_cb(struct rtw89_dev *rtwdev,
+			     enum rtw89_chanctx_state state);
 
 #endif
-- 
2.25.1

