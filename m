Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897744DD317
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Mar 2022 03:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiCRCes (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Mar 2022 22:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiCRCen (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Mar 2022 22:34:43 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1136199E1B
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 19:33:20 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22I2XDjG4017651, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22I2XDjG4017651
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Mar 2022 10:33:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 18 Mar 2022 10:33:13 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Mar
 2022 10:33:12 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <johnson.lin@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH 05/11] rtw89: packed IGI configuration flow into function for DIG feature
Date:   Fri, 18 Mar 2022 10:32:08 +0800
Message-ID: <20220318023214.32411-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220318023214.32411-1-pkshih@realtek.com>
References: <20220318023214.32411-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/18/2022 02:15:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMTggpFekyCAxMjo0MDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

From: Johnson Lin <johnson.lin@realtek.com>

Refinement of DIG flow, a mechanism to adjust Rx gain for better Rx
performance, by packing IGI(initial gain index) configuration flow into
one function.

Signed-off-by: Johnson Lin <johnson.lin@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 25 +++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index c9a04ca0b1f21..c27148acfa048 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3180,6 +3180,21 @@ static void rtw89_phy_dig_sdagc_follow_pagc_config(struct rtw89_dev *rtwdev,
 	rtw89_debug(rtwdev, RTW89_DBG_DIG, "sdagc_follow_pagc=%d\n", enable);
 }
 
+static void rtw89_phy_dig_config_igi(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_dig_info *dig = &rtwdev->dig;
+
+	if (dig->force_gaincode_idx_en) {
+		rtw89_phy_dig_set_igi_cr(rtwdev, dig->force_gaincode);
+		rtw89_debug(rtwdev, RTW89_DBG_DIG,
+			    "Force gaincode index enabled.\n");
+	} else {
+		rtw89_phy_dig_gaincode_by_rssi(rtwdev, dig->igi_fa_rssi,
+					       &dig->cur_gaincode);
+		rtw89_phy_dig_set_igi_cr(rtwdev, dig->cur_gaincode);
+	}
+}
+
 static void rtw89_phy_dig_dyn_pd_th(struct rtw89_dev *rtwdev, u8 rssi,
 				    bool enable)
 {
@@ -3294,15 +3309,7 @@ void rtw89_phy_dig(struct rtw89_dev *rtwdev)
 		    dig->igi_rssi, dig->dyn_igi_max, dig->dyn_igi_min,
 		    dig->igi_fa_rssi);
 
-	if (dig->force_gaincode_idx_en) {
-		rtw89_phy_dig_set_igi_cr(rtwdev, dig->force_gaincode);
-		rtw89_debug(rtwdev, RTW89_DBG_DIG,
-			    "Force gaincode index enabled.\n");
-	} else {
-		rtw89_phy_dig_gaincode_by_rssi(rtwdev, dig->igi_fa_rssi,
-					       &dig->cur_gaincode);
-		rtw89_phy_dig_set_igi_cr(rtwdev, dig->cur_gaincode);
-	}
+	rtw89_phy_dig_config_igi(rtwdev);
 
 	rtw89_phy_dig_dyn_pd_th(rtwdev, dig->igi_fa_rssi, dig->dyn_pd_th_en);
 
-- 
2.25.1

