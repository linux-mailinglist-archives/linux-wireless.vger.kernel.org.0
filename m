Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B535B13E3
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Sep 2022 07:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiIHFNu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Sep 2022 01:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiIHFNs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Sep 2022 01:13:48 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E7F3B6D6D
        for <linux-wireless@vger.kernel.org>; Wed,  7 Sep 2022 22:13:44 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2885DDezC009566, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2885DDezC009566
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 8 Sep 2022 13:13:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 13:13:32 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 8 Sep 2022
 13:13:31 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <leo.li@realtek.com>, <timlee@realtek.com>, <echuang@realtek.com>,
        <phhuang@realtek.com>, <chiuyitang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/9] wifi: rtw89: 8852c: set TX to single path TX on path B in 6GHz band
Date:   Thu, 8 Sep 2022 13:12:52 +0800
Message-ID: <20220908051257.25353-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908051257.25353-1-pkshih@realtek.com>
References: <20220908051257.25353-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/08/2022 04:54:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvOCCkV6TIIDEyOjQ5OjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yi-Tang Chiu <chiuyitang@realtek.com>

With one path TX for 1SS rate, it can transmit higher power in 6GHz band
to yield better performance in high attenuation circumstance.

Signed-off-by: Yi-Tang Chiu <chiuyitang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      | 12 ++++++------
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 14 +++++++++++---
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 48df4389013a5..23823f03c5218 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -2978,18 +2978,18 @@
 
 #define R_AX_PATH_COM0 0xD800
 #define AX_PATH_COM0_DFVAL 0x00000000
-#define AX_PATH_COM0_PATHA 0x08888880
-#define AX_PATH_COM0_PATHB 0x11111100
+#define AX_PATH_COM0_PATHA 0x08889880
+#define AX_PATH_COM0_PATHB 0x11111900
 #define AX_PATH_COM0_PATHAB 0x19999980
 #define R_AX_PATH_COM1 0xD804
 #define AX_PATH_COM1_DFVAL 0x00000000
-#define AX_PATH_COM1_PATHA 0x11111111
-#define AX_PATH_COM1_PATHB 0x22222222
+#define AX_PATH_COM1_PATHA 0x13111111
+#define AX_PATH_COM1_PATHB 0x23222222
 #define AX_PATH_COM1_PATHAB 0x33333333
 #define R_AX_PATH_COM2 0xD808
 #define AX_PATH_COM2_DFVAL 0x00000000
-#define AX_PATH_COM2_PATHA 0x01209111
-#define AX_PATH_COM2_PATHB 0x01209222
+#define AX_PATH_COM2_PATHA 0x01209313
+#define AX_PATH_COM2_PATHB 0x01209323
 #define AX_PATH_COM2_PATHAB 0x01209333
 #define R_AX_PATH_COM3 0xD80C
 #define AX_PATH_COM3_DFVAL 0x49249249
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index a30b723cc992e..a1747acd383d1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -152,6 +152,8 @@ static const struct rtw89_dig_regs rtw8852c_dig_regs = {
 };
 
 static void rtw8852c_ctrl_btg(struct rtw89_dev *rtwdev, bool btg);
+static void rtw8852c_ctrl_tx_path_tmac(struct rtw89_dev *rtwdev, u8 tx_path,
+				       enum rtw89_mac_idx mac_idx);
 
 static int rtw8852c_pwr_on_func(struct rtw89_dev *rtwdev)
 {
@@ -1714,11 +1716,13 @@ static void rtw8852c_set_channel_bb(struct rtw89_dev *rtwdev,
 				    const struct rtw89_chan *chan,
 				    enum rtw89_phy_idx phy_idx)
 {
+	struct rtw89_hal *hal = &rtwdev->hal;
 	bool cck_en = chan->band_type == RTW89_BAND_2G;
 	u8 pri_ch_idx = chan->pri_ch_idx;
 	u32 mask, reg;
 	u32 ru_alloc_msk[2] = {B_P80_AT_HIGH_FREQ_RU_ALLOC_PHY0,
 			       B_P80_AT_HIGH_FREQ_RU_ALLOC_PHY1};
+	u8 ntx_path;
 
 	if (chan->band_type == RTW89_BAND_2G)
 		rtw8852c_ctrl_sco_cck(rtwdev, chan->channel,
@@ -1796,6 +1800,13 @@ static void rtw8852c_set_channel_bb(struct rtw89_dev *rtwdev,
 	else
 		rtw89_phy_write32_clr(rtwdev, R_MUIC, B_MUIC_EN);
 
+	if (hal->antenna_tx)
+		ntx_path = hal->antenna_tx;
+	else
+		ntx_path = chan->band_type == RTW89_BAND_6G ? RF_B : RF_AB;
+
+	rtw8852c_ctrl_tx_path_tmac(rtwdev, ntx_path, (enum rtw89_mac_idx)phy_idx);
+
 	rtw8852c_bb_reset_all(rtwdev, phy_idx);
 }
 
@@ -2505,7 +2516,6 @@ static void rtw8852c_bb_ctrl_btc_preagc(struct rtw89_dev *rtwdev, bool bt_en)
 static void rtw8852c_bb_cfg_txrx_path(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
-	u8 ntx_path = hal->antenna_tx ? hal->antenna_tx : RF_AB;
 
 	rtw8852c_bb_cfg_rx_path(rtwdev, RF_PATH_AB);
 
@@ -2520,8 +2530,6 @@ static void rtw8852c_bb_cfg_txrx_path(struct rtw89_dev *rtwdev)
 		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHE_MAX_NSS, 1);
 		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHETB_MAX_NSS, 1);
 	}
-
-	rtw8852c_ctrl_tx_path_tmac(rtwdev, ntx_path, RTW89_MAC_0);
 }
 
 static u8 rtw8852c_get_thermal(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path)
-- 
2.25.1

