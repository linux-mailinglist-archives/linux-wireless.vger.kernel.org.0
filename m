Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFC65BD92D
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 03:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiITBL0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 21:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiITBKy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 21:10:54 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0403D52E44
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 18:10:31 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28K1A1UK0031075, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28K1A1UK0031075
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 20 Sep 2022 09:10:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 09:10:23 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 20 Sep
 2022 09:10:23 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/9] wifi: rtw89: coex: modify LNA2 setting to avoid BT destroyed Wi-Fi aggregation
Date:   Tue, 20 Sep 2022 09:09:36 +0800
Message-ID: <20220920010939.12173-7-pkshih@realtek.com>
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

To prevent LNA2 change its gain during a Wi-Fi aggregation packet while
GNT_BT pull high. Otherwise, changes of this gain will destroy the whole
aggregation when Wi-Fi RX.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c     |  3 ++
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 46 ++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 54 +++++++++++++++++++
 4 files changed, 104 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 42fc90a359b06..85c8e7ffb56c7 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1735,6 +1735,7 @@ static void _set_wl_tx_power(struct rtw89_dev *rtwdev, u32 level)
 
 static void _set_wl_rx_gain(struct rtw89_dev *rtwdev, u32 level)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 
@@ -1747,6 +1748,8 @@ static void _set_wl_rx_gain(struct rtw89_dev *rtwdev, u32 level)
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], %s(): level = %d\n",
 		    __func__, level);
+
+	chip->ops->btc_set_wl_rx_gain(rtwdev, level);
 }
 
 static void _set_bt_tx_power(struct rtw89_dev *rtwdev, u8 level)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 1d8e20708d092..c4eefa54ed864 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2356,6 +2356,7 @@ struct rtw89_chip_ops {
 	void (*btc_update_bt_cnt)(struct rtw89_dev *rtwdev);
 	void (*btc_wl_s1_standby)(struct rtw89_dev *rtwdev, bool state);
 	void (*btc_set_policy)(struct rtw89_dev *rtwdev, u16 policy_type);
+	void (*btc_set_wl_rx_gain)(struct rtw89_dev *rtwdev, u32 level);
 };
 
 enum rtw89_dma_ch {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index c6c92a2a16134..f81335aacddfa 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2059,6 +2059,51 @@ void rtw8852a_btc_wl_s1_standby(struct rtw89_dev *rtwdev, bool state)
 	rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x0);
 }
 
+static void rtw8852a_set_wl_lna2(struct rtw89_dev *rtwdev, u8 level)
+{
+	/* level=0 Default:    TIA 1/0= (LNA2,TIAN6) = (7,1)/(5,1) = 21dB/12dB
+	 * level=1 Fix LNA2=5: TIA 1/0= (LNA2,TIAN6) = (5,0)/(5,1) = 18dB/12dB
+	 * To improve BT ACI in co-rx
+	 */
+
+	switch (level) {
+	case 0: /* default */
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x1000);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x3);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x17);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x2);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x15);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x0);
+		break;
+	case 1: /* Fix LNA2=5  */
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x1000);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x3);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x5);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x2);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x15);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x0);
+		break;
+	}
+}
+
+static void rtw8852a_btc_set_wl_rx_gain(struct rtw89_dev *rtwdev, u32 level)
+{
+	switch (level) {
+	case 0: /* original */
+		rtw8852a_bb_ctrl_btc_preagc(rtwdev, false);
+		rtw8852a_set_wl_lna2(rtwdev, 0);
+		break;
+	case 1: /* for FDD free-run */
+		rtw8852a_bb_ctrl_btc_preagc(rtwdev, true);
+		rtw8852a_set_wl_lna2(rtwdev, 0);
+		break;
+	case 2: /* for BTG Co-Rx*/
+		rtw8852a_bb_ctrl_btc_preagc(rtwdev, false);
+		rtw8852a_set_wl_lna2(rtwdev, 1);
+		break;
+	}
+}
+
 static void rtw8852a_fill_freq_with_ppdu(struct rtw89_dev *rtwdev,
 					 struct rtw89_rx_phy_ppdu *phy_ppdu,
 					 struct ieee80211_rx_status *status)
@@ -2135,6 +2180,7 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.btc_bt_aci_imp		= rtw8852a_btc_bt_aci_imp,
 	.btc_update_bt_cnt	= rtw8852a_btc_update_bt_cnt,
 	.btc_wl_s1_standby	= rtw8852a_btc_wl_s1_standby,
+	.btc_set_wl_rx_gain	= rtw8852a_btc_set_wl_rx_gain,
 	.btc_set_policy		= rtw89_btc_set_policy,
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 817bb57698ba8..5b8292d151f6f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2854,6 +2854,59 @@ void rtw8852c_btc_wl_s1_standby(struct rtw89_dev *rtwdev, bool state)
 	rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x0);
 }
 
+static void rtw8852c_set_wl_lna2(struct rtw89_dev *rtwdev, u8 level)
+{
+	/* level=0 Default:    TIA 1/0= (LNA2,TIAN6) = (7,1)/(5,1) = 21dB/12dB
+	 * level=1 Fix LNA2=5: TIA 1/0= (LNA2,TIAN6) = (5,0)/(5,1) = 18dB/12dB
+	 * To improve BT ACI in co-rx
+	 */
+
+	switch (level) {
+	case 0: /* default */
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x1000);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x0);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x15);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x1);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x17);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x2);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x15);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x3);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x17);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x0);
+		break;
+	case 1: /* Fix LNA2=5  */
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x1000);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x0);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x15);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x1);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x5);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x2);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x15);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWA, RFREG_MASK, 0x3);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x5);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x0);
+		break;
+	}
+}
+
+static void rtw8852c_btc_set_wl_rx_gain(struct rtw89_dev *rtwdev, u32 level)
+{
+	switch (level) {
+	case 0: /* original */
+		rtw8852c_bb_ctrl_btc_preagc(rtwdev, false);
+		rtw8852c_set_wl_lna2(rtwdev, 0);
+		break;
+	case 1: /* for FDD free-run */
+		rtw8852c_bb_ctrl_btc_preagc(rtwdev, true);
+		rtw8852c_set_wl_lna2(rtwdev, 0);
+		break;
+	case 2: /* for BTG Co-Rx*/
+		rtw8852c_bb_ctrl_btc_preagc(rtwdev, false);
+		rtw8852c_set_wl_lna2(rtwdev, 1);
+		break;
+	}
+}
+
 static void rtw8852c_fill_freq_with_ppdu(struct rtw89_dev *rtwdev,
 					 struct rtw89_rx_phy_ppdu *phy_ppdu,
 					 struct ieee80211_rx_status *status)
@@ -2974,6 +3027,7 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.btc_bt_aci_imp		= rtw8852c_btc_bt_aci_imp,
 	.btc_update_bt_cnt	= rtw8852c_btc_update_bt_cnt,
 	.btc_wl_s1_standby	= rtw8852c_btc_wl_s1_standby,
+	.btc_set_wl_rx_gain	= rtw8852c_btc_set_wl_rx_gain,
 	.btc_set_policy		= rtw89_btc_set_policy_v1,
 };
 
-- 
2.25.1

