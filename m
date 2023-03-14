Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979216B880C
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 03:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjCNCHf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 22:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjCNCHe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 22:07:34 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F32A67725
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 19:07:32 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32E27EFS0011870, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32E27EFS0011870
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 14 Mar 2023 10:07:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 14 Mar 2023 10:07:25 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 14 Mar
 2023 10:07:25 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/5] wifi: rtw89: coex: Update RTL8852B LNA2 hardware parameter
Date:   Tue, 14 Mar 2023 10:06:15 +0800
Message-ID: <20230314020617.28193-4-pkshih@realtek.com>
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

The LNA gain didn't set before, it will lead some WiFi RX issue.
And the setting can increase both of WiFi & BT performance while
they are both RX.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  3 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 11 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 51 ++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 11 ++--
 4 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index e447bfec508b8..3b13f2a6b42d6 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2186,12 +2186,13 @@ struct rtw89_btc_dm {
 	u32 wl_stb_chg: 1;
 	u32 pta_owner: 1;
 	u32 tdma_instant_excute: 1;
-	u32 rsvd: 1;
 
 	u16 slot_dur[CXST_MAX];
 
 	u8 run_reason;
 	u8 run_action;
+
+	u8 wl_lna2: 1;
 };
 
 struct rtw89_btc_ctrl {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 9c42b6abd2232..152f715d55d50 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -1947,20 +1947,25 @@ static void rtw8852a_set_wl_lna2(struct rtw89_dev *rtwdev, u8 level)
 
 static void rtw8852a_btc_set_wl_rx_gain(struct rtw89_dev *rtwdev, u32 level)
 {
+	struct rtw89_btc *btc = &rtwdev->btc;
+
 	switch (level) {
 	case 0: /* original */
+	default:
 		rtw8852a_bb_ctrl_btc_preagc(rtwdev, false);
-		rtw8852a_set_wl_lna2(rtwdev, 0);
+		btc->dm.wl_lna2 = 0;
 		break;
 	case 1: /* for FDD free-run */
 		rtw8852a_bb_ctrl_btc_preagc(rtwdev, true);
-		rtw8852a_set_wl_lna2(rtwdev, 0);
+		btc->dm.wl_lna2 = 0;
 		break;
 	case 2: /* for BTG Co-Rx*/
 		rtw8852a_bb_ctrl_btc_preagc(rtwdev, false);
-		rtw8852a_set_wl_lna2(rtwdev, 1);
+		btc->dm.wl_lna2 = 1;
 		break;
 	}
+
+	rtw8852a_set_wl_lna2(rtwdev, btc->dm.wl_lna2);
 }
 
 static void rtw8852a_fill_freq_with_ppdu(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 499ae0389c715..7bab6d2ab776d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2284,15 +2284,64 @@ static void rtw8852b_btc_wl_s1_standby(struct rtw89_dev *rtwdev, bool state)
 
 	/* set WL standby = Rx for GNT_BT_Tx = 1->0 settle issue */
 	if (state)
-		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x579);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x179);
 	else
 		rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWD0, RFREG_MASK, 0x20);
 
 	rtw89_write_rf(rtwdev, RF_PATH_B, RR_LUTWE, RFREG_MASK, 0x0);
 }
 
+static void rtw8852b_btc_set_wl_lna2(struct rtw89_dev *rtwdev, u8 level)
+{
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
 static void rtw8852b_btc_set_wl_rx_gain(struct rtw89_dev *rtwdev, u32 level)
 {
+	struct rtw89_btc *btc = &rtwdev->btc;
+
+	switch (level) {
+	case 0: /* original */
+	default:
+		rtw8852b_bb_ctrl_btc_preagc(rtwdev, false);
+		btc->dm.wl_lna2 = 0;
+		break;
+	case 1: /* for FDD free-run */
+		rtw8852b_bb_ctrl_btc_preagc(rtwdev, true);
+		btc->dm.wl_lna2 = 0;
+		break;
+	case 2: /* for BTG Co-Rx*/
+		rtw8852b_bb_ctrl_btc_preagc(rtwdev, false);
+		btc->dm.wl_lna2 = 1;
+		break;
+	}
+
+	rtw8852b_btc_set_wl_lna2(rtwdev, btc->dm.wl_lna2);
 }
 
 static void rtw8852b_fill_freq_with_ppdu(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 8af813132f71d..7580212875527 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2633,20 +2633,25 @@ static void rtw8852c_set_wl_lna2(struct rtw89_dev *rtwdev, u8 level)
 
 static void rtw8852c_btc_set_wl_rx_gain(struct rtw89_dev *rtwdev, u32 level)
 {
+	struct rtw89_btc *btc = &rtwdev->btc;
+
 	switch (level) {
 	case 0: /* original */
+	default:
 		rtw8852c_bb_ctrl_btc_preagc(rtwdev, false);
-		rtw8852c_set_wl_lna2(rtwdev, 0);
+		btc->dm.wl_lna2 = 0;
 		break;
 	case 1: /* for FDD free-run */
 		rtw8852c_bb_ctrl_btc_preagc(rtwdev, true);
-		rtw8852c_set_wl_lna2(rtwdev, 0);
+		btc->dm.wl_lna2 = 0;
 		break;
 	case 2: /* for BTG Co-Rx*/
 		rtw8852c_bb_ctrl_btc_preagc(rtwdev, false);
-		rtw8852c_set_wl_lna2(rtwdev, 1);
+		btc->dm.wl_lna2 = 1;
 		break;
 	}
+
+	rtw8852c_set_wl_lna2(rtwdev, btc->dm.wl_lna2);
 }
 
 static void rtw8852c_fill_freq_with_ppdu(struct rtw89_dev *rtwdev,
-- 
2.25.1

