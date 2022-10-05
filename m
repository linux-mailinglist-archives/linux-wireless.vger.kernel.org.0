Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F0E5F50DE
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 10:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiJEIdM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 04:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiJEIdE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 04:33:04 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A322E74DC6
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 01:32:49 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2958W88G0010386, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2958W88G0010386
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 5 Oct 2022 16:32:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 5 Oct 2022 16:32:35 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 5 Oct 2022
 16:32:28 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <echuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/6] wifi: rtw89: 8852b: set proper configuration before loading NCTL
Date:   Wed, 5 Oct 2022 16:32:09 +0800
Message-ID: <20221005083212.45683-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221005083212.45683-1-pkshih@realtek.com>
References: <20221005083212.45683-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 10/05/2022 03:37:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzUgpFekyCAwMjo1OTowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Before loading RF NCTL table, we need to configure IQK/DPK clock and reset
them, and then polling NCTL state ready. Since 8852BE needs additional
one setting, add it by this patch. Also, give them proper names.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 12 +++++++-----
 drivers/net/wireless/realtek/rtw89/reg.h |  2 ++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index d9c4debecc622..fb7872225ee3d 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1368,13 +1368,15 @@ static void rtw89_phy_init_rf_nctl(struct rtw89_dev *rtwdev)
 	int ret;
 
 	/* IQK/DPK clock & reset */
-	rtw89_phy_write32_set(rtwdev, 0x0c60, 0x3);
-	rtw89_phy_write32_set(rtwdev, 0x0c6c, 0x1);
-	rtw89_phy_write32_set(rtwdev, 0x58ac, 0x8000000);
-	rtw89_phy_write32_set(rtwdev, 0x78ac, 0x8000000);
+	rtw89_phy_write32_set(rtwdev, R_IOQ_IQK_DPK, 0x3);
+	rtw89_phy_write32_set(rtwdev, R_GNT_BT_WGT_EN, 0x1);
+	rtw89_phy_write32_set(rtwdev, R_P0_PATH_RST, 0x8000000);
+	rtw89_phy_write32_set(rtwdev, R_P1_PATH_RST, 0x8000000);
+	if (chip->chip_id == RTL8852B)
+		rtw89_phy_write32_set(rtwdev, R_IOQ_IQK_DPK, 0x2);
 
 	/* check 0x8080 */
-	rtw89_phy_write32(rtwdev, 0x8000, 0x8);
+	rtw89_phy_write32(rtwdev, R_NCTL_CFG, 0x8);
 
 	ret = read_poll_timeout(rtw89_phy_nctl_poll, val, val == 0x4, 10,
 				1000, false, rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 874cca85eaadf..82af17d7d8d31 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -4039,6 +4039,7 @@
 #define B_P0_RFM_TX_OPT BIT(6)
 #define B_P0_RFM_BT_EN BIT(5)
 #define B_P0_RFM_OUT GENMASK(4, 0)
+#define R_P0_PATH_RST 0x58AC
 #define R_P0_TXDPD 0x58D4
 #define B_P0_TXDPD GENMASK(31, 28)
 #define R_P0_TXPW_RSTB 0x58DC
@@ -4083,6 +4084,7 @@
 #define R_P1_RFCTM 0x7864
 #define R_P1_RFCTM_RDY BIT(26)
 #define B_P1_RFCTM_VAL GENMASK(25, 20)
+#define R_P1_PATH_RST 0x78AC
 #define R_P1_TXPW_RSTB 0x78DC
 #define B_P1_TXPW_RSTB_MANON BIT(30)
 #define B_P1_TXPW_RSTB_TSSI BIT(31)
-- 
2.25.1

