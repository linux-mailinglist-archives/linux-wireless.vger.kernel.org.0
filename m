Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9625BD931
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 03:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiITBLj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 21:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiITBLG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 21:11:06 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A578452E72
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 18:10:34 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28K1A47f8031095, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28K1A47f8031095
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 20 Sep 2022 09:10:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 20 Sep 2022 09:10:27 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 20 Sep
 2022 09:10:26 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 9/9] wifi: rtw89: coex: update coexistence to 6.3.0
Date:   Tue, 20 Sep 2022 09:09:39 +0800
Message-ID: <20220920010939.12173-10-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

Since we maintain coexistence as shared code, so move coexistence version
from chip specific attribute to a definition.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c     | 9 +++++----
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 6 +++---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 6 +++---
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index d3d32f25071e8..bbdfa9ac203cc 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -9,6 +9,7 @@
 #include "ps.h"
 #include "reg.h"
 
+#define RTW89_COEX_VERSION 0x06030013
 #define FCXDEF_STEP 50 /* MUST <= FCXMAX_STEP and match with wl fw*/
 
 enum btc_fbtc_tdma_template {
@@ -5495,10 +5496,10 @@ static void _show_cx_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 	seq_printf(m, "========== [BTC COEX INFO (%d)] ==========\n",
 		   chip->chip_id);
 
-	ver_main = FIELD_GET(GENMASK(31, 24), chip->para_ver);
-	ver_sub = FIELD_GET(GENMASK(23, 16), chip->para_ver);
-	ver_hotfix = FIELD_GET(GENMASK(15, 8), chip->para_ver);
-	id_branch = FIELD_GET(GENMASK(7, 0), chip->para_ver);
+	ver_main = FIELD_GET(GENMASK(31, 24), RTW89_COEX_VERSION);
+	ver_sub = FIELD_GET(GENMASK(23, 16), RTW89_COEX_VERSION);
+	ver_hotfix = FIELD_GET(GENMASK(15, 8), RTW89_COEX_VERSION);
+	id_branch = FIELD_GET(GENMASK(7, 0), RTW89_COEX_VERSION);
 	seq_printf(m, " %-15s : Coex:%d.%d.%d(branch:%d), ",
 		   "[coex_version]", ver_main, ver_sub, ver_hotfix, id_branch);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index f81335aacddfa..be3ec41dc55c0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2234,9 +2234,9 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.dav_log_efuse_size	= 0,
 	.phycap_addr		= 0x580,
 	.phycap_size		= 128,
-	.para_ver		= 0x05050864,
-	.wlcx_desired		= 0x05050000,
-	.btcx_desired		= 0x5,
+	.para_ver		= 0x0,
+	.wlcx_desired		= 0x06000000,
+	.btcx_desired		= 0x7,
 	.scbd			= 0x1,
 	.mailbox		= 0x1,
 	.btc_fwinfo_buf		= 1024,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 5b8292d151f6f..5dff65dbc142b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3084,9 +3084,9 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.dav_log_efuse_size	= 16,
 	.phycap_addr		= 0x590,
 	.phycap_size		= 0x60,
-	.para_ver		= 0x05050764,
-	.wlcx_desired		= 0x05050000,
-	.btcx_desired		= 0x5,
+	.para_ver		= 0x1,
+	.wlcx_desired		= 0x06000000,
+	.btcx_desired		= 0x7,
 	.scbd			= 0x1,
 	.mailbox		= 0x1,
 	.btc_fwinfo_buf		= 1280,
-- 
2.25.1

