Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53F94E6E0C
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 07:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354867AbiCYGEB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 02:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358412AbiCYGEA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 02:04:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EDBC6824
        for <linux-wireless@vger.kernel.org>; Thu, 24 Mar 2022 23:02:23 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22P62H3l8011157, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22P62H3l8011157
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Mar 2022 14:02:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 25 Mar 2022 14:02:17 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 14:02:16 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>
Subject: [PATCH 14/16] rtw89: initialize NAV control
Date:   Fri, 25 Mar 2022 14:00:53 +0800
Message-ID: <20220325060055.58482-15-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220325060055.58482-1-pkshih@realtek.com>
References: <20220325060055.58482-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/25/2022 05:51:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMjUgpFekyCAwNDo0ODowMA==?=
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

Configure NAV function and its parameters.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 17 +++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h | 10 ++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 569c390a03cb0..72debef03f6e3 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1959,6 +1959,16 @@ static int cca_ctrl_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	return 0;
 }
 
+static int nav_ctrl_init(struct rtw89_dev *rtwdev)
+{
+	rtw89_write32_set(rtwdev, R_AX_WMAC_NAV_CTL, B_AX_WMAC_PLCP_UP_NAV_EN |
+						     B_AX_WMAC_TF_UP_NAV_EN |
+						     B_AX_WMAC_NAV_UPPER_EN);
+	rtw89_write32_mask(rtwdev, R_AX_WMAC_NAV_CTL, B_AX_WMAC_NAV_UPPER_MASK, NAV_12MS);
+
+	return 0;
+}
+
 static int spatial_reuse_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
 	u32 reg;
@@ -2174,6 +2184,13 @@ static int cmac_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 		return ret;
 	}
 
+	ret = nav_ctrl_init(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]CMAC%d NAV CTRL init %d\n", mac_idx,
+			  ret);
+		return ret;
+	}
+
 	ret = spatial_reuse_init(rtwdev, mac_idx);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]CMAC%d Spatial Reuse init %d\n",
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index dea7d2c8547be..aca9fc3ac09ed 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -1435,6 +1435,16 @@
 #define R_AX_MAC_LOOPBACK_C1 0xEC20
 #define B_AX_MACLBK_EN BIT(0)
 
+#define R_AX_WMAC_NAV_CTL 0xCC80
+#define R_AX_WMAC_NAV_CTL_C1 0xEC80
+#define B_AX_WMAC_NAV_UPPER_EN BIT(26)
+#define B_AX_WMAC_0P125US_TIMER_MASK GENMASK(25, 18)
+#define B_AX_WMAC_PLCP_UP_NAV_EN BIT(17)
+#define B_AX_WMAC_TF_UP_NAV_EN BIT(16)
+#define B_AX_WMAC_NAV_UPPER_MASK GENMASK(15, 8)
+#define NAV_12MS 0xBC
+#define B_AX_WMAC_RTS_RST_DUR_MASK GENMASK(7, 0)
+
 #define R_AX_RXTRIG_TEST_USER_2 0xCCB0
 #define R_AX_RXTRIG_TEST_USER_2_C1 0xECB0
 #define B_AX_RXTRIG_MACID_MASK GENMASK(31, 24)
-- 
2.25.1

