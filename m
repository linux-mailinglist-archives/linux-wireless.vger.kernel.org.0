Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93464DBF23
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Mar 2022 07:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiCQGSN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Mar 2022 02:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiCQGSB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Mar 2022 02:18:01 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE071D59E9
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 22:56:46 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22H5ub283009681, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22H5ub283009681
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Mar 2022 13:56:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 17 Mar 2022 13:56:37 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 13:56:37 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>,
        <hsuan8331@realtek.com>, <yuanhan1020@realtek.com>
Subject: [PATCH v2 01/12] rtw89: modify dcfo_comp to share with chips
Date:   Thu, 17 Mar 2022 13:55:32 +0800
Message-ID: <20220317055543.40514-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317055543.40514-1-pkshih@realtek.com>
References: <20220317055543.40514-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/17/2022 05:41:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMTcgpFekyCAwMzoyNjowMA==?=
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

From: Yuan-Han Zhang <yuanhan1020@realtek.com>

The dcfo_comp is digital CFO (central frequency offset) compensation.
Since the flow can be shared with all chips, add chip parameters to support
variant register address and format.

Signed-off-by: Yuan-Han Zhang <yuanhan1020@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  2 ++
 drivers/net/wireless/realtek/rtw89/phy.c      | 10 ++++++----
 drivers/net/wireless/realtek/rtw89/reg.h      |  2 ++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  6 ++++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  6 ++++++
 5 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 483cf45fbcc99..51c99e50b0ed9 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2332,6 +2332,8 @@ struct rtw89_chip_info {
 	u32 c2h_ctrl_reg;
 	const u32 *c2h_regs;
 	const struct rtw89_page_regs *page_regs;
+	const struct rtw89_reg_def *dcfo_comp;
+	u8 dcfo_comp_sft;
 };
 
 union rtw89_bus_info {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index c6953a78658ae..6a7e08bdd00e7 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1705,9 +1705,11 @@ static void rtw89_phy_cfo_reset(struct rtw89_dev *rtwdev)
 
 static void rtw89_dcfo_comp(struct rtw89_dev *rtwdev, s32 curr_cfo)
 {
+	const struct rtw89_reg_def *dcfo_comp = rtwdev->chip->dcfo_comp;
 	bool is_linked = rtwdev->total_sta_assoc > 0;
 	s32 cfo_avg_312;
-	s32 dcfo_comp;
+	s32 dcfo_comp_val;
+	u8 dcfo_comp_sft = rtwdev->chip->dcfo_comp_sft;
 	int sign;
 
 	if (!is_linked) {
@@ -1718,13 +1720,13 @@ static void rtw89_dcfo_comp(struct rtw89_dev *rtwdev, s32 curr_cfo)
 	rtw89_debug(rtwdev, RTW89_DBG_CFO, "DCFO: curr_cfo=%d\n", curr_cfo);
 	if (curr_cfo == 0)
 		return;
-	dcfo_comp = rtw89_phy_read32_mask(rtwdev, R_DCFO, B_DCFO);
+	dcfo_comp_val = rtw89_phy_read32_mask(rtwdev, R_DCFO, B_DCFO);
 	sign = curr_cfo > 0 ? 1 : -1;
-	cfo_avg_312 = (curr_cfo << 3) / 5 + sign * dcfo_comp;
+	cfo_avg_312 = (curr_cfo << dcfo_comp_sft) / 5 + sign * dcfo_comp_val;
 	rtw89_debug(rtwdev, RTW89_DBG_CFO, "DCFO: avg_cfo=%d\n", cfo_avg_312);
 	if (rtwdev->chip->chip_id == RTL8852A && rtwdev->hal.cv == CHIP_CBV)
 		cfo_avg_312 = -cfo_avg_312;
-	rtw89_phy_set_phy_regs(rtwdev, R_DCFO_COMP_S0, B_DCFO_COMP_S0_MSK,
+	rtw89_phy_set_phy_regs(rtwdev, dcfo_comp->addr, dcfo_comp->mask,
 			       cfo_avg_312);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index ec5e70b866009..a239bf017ac76 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -2093,6 +2093,8 @@
 #define R_CHBW_MOD 0x4978
 #define B_CHBW_MOD_PRICH GENMASK(11, 8)
 #define B_CHBW_MOD_SBW GENMASK(13, 12)
+#define R_DCFO_COMP_S0_V1 0x4A40
+#define B_DCFO_COMP_S0_V1_MSK GENMASK(13, 0)
 #define R_BMODE_PDTH_V1 0x4B64
 #define B_BMODE_PDTH_LOWER_BOUND_MSK_V1 GENMASK(31, 24)
 #define R_BMODE_PDTH_EN_V1 0x4B74
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index c429eeae1b567..392f6e6e0a132 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -402,6 +402,10 @@ static const struct rtw89_page_regs rtw8852a_page_regs = {
 	.wp_page_info1	= R_AX_WP_PAGE_INFO1,
 };
 
+static const struct rtw89_reg_def rtw8852a_dcfo_comp = {
+	R_DCFO_COMP_S0, B_DCFO_COMP_S0_MSK
+};
+
 static void rtw8852ae_efuse_parsing(struct rtw89_efuse *efuse,
 				    struct rtw8852a_efuse *map)
 {
@@ -2091,6 +2095,8 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.c2h_ctrl_reg		= R_AX_C2HREG_CTRL,
 	.c2h_regs		= rtw8852a_c2h_regs,
 	.page_regs		= &rtw8852a_page_regs,
+	.dcfo_comp		= &rtw8852a_dcfo_comp,
+	.dcfo_comp_sft		= 3,
 };
 EXPORT_SYMBOL(rtw8852a_chip_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 35a9f40af3c99..f37acfe7679e1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -44,6 +44,10 @@ static const struct rtw89_page_regs rtw8852c_page_regs = {
 	.wp_page_info1	= R_AX_WP_PAGE_INFO1_V1,
 };
 
+static const struct rtw89_reg_def rtw8852c_dcfo_comp = {
+	R_DCFO_COMP_S0_V1, B_DCFO_COMP_S0_V1_MSK
+};
+
 static int rtw8852c_pwr_on_func(struct rtw89_dev *rtwdev)
 {
 	u32 val32;
@@ -470,6 +474,8 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.c2h_ctrl_reg		= R_AX_C2HREG_CTRL_V1,
 	.c2h_regs		= rtw8852c_c2h_regs,
 	.page_regs		= &rtw8852c_page_regs,
+	.dcfo_comp		= &rtw8852c_dcfo_comp,
+	.dcfo_comp_sft		= 5,
 };
 EXPORT_SYMBOL(rtw8852c_chip_info);
 
-- 
2.25.1

