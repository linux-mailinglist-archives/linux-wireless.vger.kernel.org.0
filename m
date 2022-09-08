Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B015B15DC
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Sep 2022 09:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiIHHmd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Sep 2022 03:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiIHHm3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Sep 2022 03:42:29 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2277FD51DE
        for <linux-wireless@vger.kernel.org>; Thu,  8 Sep 2022 00:42:25 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2887fvOJ3010385, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2887fvOJ3010385
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 8 Sep 2022 15:41:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 8 Sep 2022 15:42:16 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 8 Sep 2022
 15:42:16 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 5/5] wifi: rtw89: support TX diversity for 1T2R chipset
Date:   Thu, 8 Sep 2022 15:41:40 +0800
Message-ID: <20220908074140.39776-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908074140.39776-1-pkshih@realtek.com>
References: <20220908074140.39776-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/08/2022 07:27:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvOCCkV6TIIDA2OjAwOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Check RSSI strength to decide which path is better, and then set TX path
accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c  |  1 +
 drivers/net/wireless/realtek/rtw89/core.h  |  1 +
 drivers/net/wireless/realtek/rtw89/debug.c |  4 +-
 drivers/net/wireless/realtek/rtw89/phy.c   | 56 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h   |  1 +
 drivers/net/wireless/realtek/rtw89/reg.h   |  6 +++
 6 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 0f474b50b161e..8c64af9157e49 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2218,6 +2218,7 @@ static void rtw89_track_work(struct work_struct *work)
 	rtw89_chip_rfk_track(rtwdev);
 	rtw89_phy_ra_update(rtwdev);
 	rtw89_phy_cfo_track(rtwdev);
+	rtw89_phy_tx_path_div_track(rtwdev);
 
 	if (rtwdev->lps_enabled && !rtwdev->btc.lps)
 		rtw89_enter_lps_track(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 392a8bf4372e8..40453ed6a6997 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -34,6 +34,7 @@ extern const struct ieee80211_ops rtw89_ops;
 #define MAX_RSSI 110
 #define RSSI_FACTOR 1
 #define RTW89_RSSI_RAW_TO_DBM(rssi) ((s8)((rssi) >> RSSI_FACTOR) - MAX_RSSI)
+#define RTW89_TX_DIV_RSSI_RAW_TH (2 << RSSI_FACTOR)
 
 #define RTW89_HTC_MASK_VARIANT GENMASK(1, 0)
 #define RTW89_HTC_VARIANT_HE 3
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index a34f612ac8d90..eed28c3b440f4 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -2291,6 +2291,7 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 	struct ieee80211_rx_status *status = &rtwsta->rx_status;
 	struct seq_file *m = (struct seq_file *)data;
 	struct rtw89_dev *rtwdev = rtwsta->rtwdev;
+	struct rtw89_hal *hal = &rtwdev->hal;
 	u8 rssi;
 	int i;
 
@@ -2341,7 +2342,8 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 		   RTW89_RSSI_RAW_TO_DBM(rssi), rssi, rtwsta->prev_rssi);
 	for (i = 0; i < rtwdev->chip->rf_path_num; i++) {
 		rssi = ewma_rssi_read(&rtwsta->rssi[i]);
-		seq_printf(m, "%d%s", RTW89_RSSI_RAW_TO_DBM(rssi),
+		seq_printf(m, "%d%s%s", RTW89_RSSI_RAW_TO_DBM(rssi),
+			   hal->tx_path_diversity && (hal->antenna_tx & BIT(i)) ? "*" : "",
 			   i + 1 == rtwdev->chip->rf_path_num ? "" : ", ");
 	}
 	seq_puts(m, "]\n");
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index a2ebef0051b83..9733ad1135f16 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3660,6 +3660,62 @@ void rtw89_phy_dig(struct rtw89_dev *rtwdev)
 		rtw89_phy_dig_sdagc_follow_pagc_config(rtwdev, false);
 }
 
+static void rtw89_phy_tx_path_div_sta_iter(void *data, struct ieee80211_sta *sta)
+{
+	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_dev *rtwdev = rtwsta->rtwdev;
+	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	bool *done = data;
+	u8 rssi_a, rssi_b;
+	u32 candidate;
+
+	if (rtwvif->wifi_role != RTW89_WIFI_ROLE_STATION || sta->tdls)
+		return;
+
+	if (*done)
+		return;
+
+	*done = true;
+
+	rssi_a = ewma_rssi_read(&rtwsta->rssi[RF_PATH_A]);
+	rssi_b = ewma_rssi_read(&rtwsta->rssi[RF_PATH_B]);
+
+	if (rssi_a > rssi_b + RTW89_TX_DIV_RSSI_RAW_TH)
+		candidate = RF_A;
+	else if (rssi_b > rssi_a + RTW89_TX_DIV_RSSI_RAW_TH)
+		candidate = RF_B;
+	else
+		return;
+
+	if (hal->antenna_tx == candidate)
+		return;
+
+	hal->antenna_tx = candidate;
+	rtw89_fw_h2c_txpath_cmac_tbl(rtwdev, rtwsta);
+
+	if (hal->antenna_tx == RF_A) {
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFMODE, B_P0_RFMODE_MUX, 0x12);
+		rtw89_phy_write32_mask(rtwdev, R_P1_RFMODE, B_P1_RFMODE_MUX, 0x11);
+	} else if (hal->antenna_tx == RF_B) {
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFMODE, B_P0_RFMODE_MUX, 0x11);
+		rtw89_phy_write32_mask(rtwdev, R_P1_RFMODE, B_P1_RFMODE_MUX, 0x12);
+	}
+}
+
+void rtw89_phy_tx_path_div_track(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	bool done = false;
+
+	if (!hal->tx_path_diversity)
+		return;
+
+	ieee80211_iterate_stations_atomic(rtwdev->hw,
+					  rtw89_phy_tx_path_div_sta_iter,
+					  &done);
+}
+
 static void rtw89_phy_env_monitor_init(struct rtw89_dev *rtwdev)
 {
 	rtw89_phy_ccx_top_setting_init(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 0eeab18fd97e8..ee3bc5e111e16 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -491,6 +491,7 @@ void rtw89_phy_set_phy_regs(struct rtw89_dev *rtwdev, u32 addr, u32 mask,
 			    u32 val);
 void rtw89_phy_dig_reset(struct rtw89_dev *rtwdev);
 void rtw89_phy_dig(struct rtw89_dev *rtwdev);
+void rtw89_phy_tx_path_div_track(struct rtw89_dev *rtwdev);
 void rtw89_phy_set_bss_color(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif);
 void rtw89_phy_tssi_ctrl_set_bandedge_cfg(struct rtw89_dev *rtwdev,
 					  enum rtw89_mac_idx mac_idx,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 38139fff03475..cd7b21b49df8f 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3553,6 +3553,9 @@
 #define B_P0_RXCK_VAL GENMASK(18, 16)
 #define B_P0_TXCK_ON BIT(15)
 #define B_P0_TXCK_VAL GENMASK(14, 12)
+#define R_P0_RFMODE 0x12AC
+#define B_P0_RFMODE_ORI_TXRX_FTM_TX GENMASK(31, 4)
+#define B_P0_RFMODE_MUX GENMASK(11, 4)
 #define R_P0_NRBW 0x12B8
 #define B_P0_NRBW_DBG BIT(30)
 #define R_S0_RXDC 0x12D4
@@ -3659,6 +3662,9 @@
 #define B_P1_EN_SOUND_WO_NDP BIT(1)
 #define R_S1_HW_SI_DIS 0x3200
 #define B_S1_HW_SI_DIS_W_R_TRIG GENMASK(30, 28)
+#define R_P1_RFMODE 0x32AC
+#define B_P1_RFMODE_ORI_TXRX_FTM_TX GENMASK(31, 4)
+#define B_P1_RFMODE_MUX GENMASK(11, 4)
 #define R_P1_DBGMOD 0x32B8
 #define B_P1_DBGMOD_ON BIT(30)
 #define R_S1_RXDC 0x32D4
-- 
2.25.1

