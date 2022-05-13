Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FD7525B10
	for <lists+linux-wireless@lfdr.de>; Fri, 13 May 2022 07:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377106AbiEMFnB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 May 2022 01:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377087AbiEMFmz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 May 2022 01:42:55 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B92E1DB59C
        for <linux-wireless@vger.kernel.org>; Thu, 12 May 2022 22:42:52 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 24D5ge5Y3005685, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 24D5ge5Y3005685
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 13 May 2022 13:42:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 13 May 2022 13:42:40 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 13 May
 2022 13:42:39 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 2/6] rtw89: 8852c: set TX antenna path
Date:   Fri, 13 May 2022 13:42:20 +0800
Message-ID: <20220513054224.16902-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513054224.16902-1-pkshih@realtek.com>
References: <20220513054224.16902-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 05/13/2022 05:24:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzUvMTIgpFWkyCAxMDo1OTowMA==?=
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

To make user space can set TX antenna via iw command. Then, we can diagnose
antenna is connected properly or not, and measure TX power in single path.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 77dcdbd86c63a..64840c8d9efe8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2360,19 +2360,19 @@ static void rtw8852c_ctrl_tx_path_tmac(struct rtw89_dev *rtwdev, u8 tx_path,
 		rtw89_write32(rtwdev, reg, 0);
 	}
 
-	if (tx_path == RF_PATH_A) {
+	if (tx_path == RF_A) {
 		path_com[0].data = AX_PATH_COM0_PATHA;
 		path_com[1].data = AX_PATH_COM1_PATHA;
 		path_com[2].data = AX_PATH_COM2_PATHA;
 		path_com[7].data = AX_PATH_COM7_PATHA;
 		path_com[8].data = AX_PATH_COM8_PATHA;
-	} else if (tx_path == RF_PATH_B) {
+	} else if (tx_path == RF_B) {
 		path_com[0].data = AX_PATH_COM0_PATHB;
 		path_com[1].data = AX_PATH_COM1_PATHB;
 		path_com[2].data = AX_PATH_COM2_PATHB;
 		path_com[7].data = AX_PATH_COM7_PATHB;
 		path_com[8].data = AX_PATH_COM8_PATHB;
-	} else if (tx_path == RF_PATH_AB) {
+	} else if (tx_path == RF_AB) {
 		path_com[0].data = AX_PATH_COM0_PATHAB;
 		path_com[1].data = AX_PATH_COM1_PATHAB;
 		path_com[2].data = AX_PATH_COM2_PATHAB;
@@ -2457,6 +2457,7 @@ static void rtw8852c_bb_ctrl_btc_preagc(struct rtw89_dev *rtwdev, bool bt_en)
 static void rtw8852c_bb_cfg_txrx_path(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
+	u8 ntx_path = hal->antenna_tx ? hal->antenna_tx : RF_AB;
 
 	rtw8852c_bb_cfg_rx_path(rtwdev, RF_PATH_AB);
 
@@ -2472,7 +2473,7 @@ static void rtw8852c_bb_cfg_txrx_path(struct rtw89_dev *rtwdev)
 		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHETB_MAX_NSS, 1);
 	}
 
-	rtw8852c_ctrl_tx_path_tmac(rtwdev, RF_PATH_AB, RTW89_MAC_0);
+	rtw8852c_ctrl_tx_path_tmac(rtwdev, ntx_path, RTW89_MAC_0);
 }
 
 static u8 rtw8852c_get_thermal(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path)
-- 
2.25.1

