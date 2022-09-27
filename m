Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FA55EBA9C
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Sep 2022 08:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiI0G2H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Sep 2022 02:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiI0G2B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Sep 2022 02:28:01 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18994857E6
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 23:27:56 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28R6QmtK6008430, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28R6QmtK6008430
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 27 Sep 2022 14:26:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 27 Sep 2022 14:27:13 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 27 Sep
 2022 14:27:13 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 9/9] wifi: rtw89: 8852b: configure DLE mem
Date:   Tue, 27 Sep 2022 14:26:11 +0800
Message-ID: <20220927062611.30484-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220927062611.30484-1-pkshih@realtek.com>
References: <20220927062611.30484-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/27/2022 06:02:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMjcgpFekyCAwNDo1MzowMA==?=
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

Configure DLE (data link engine) memory size for operating modes.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c      | 14 ++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h      |  7 +++++++
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 14 ++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 892fdb7f090ef..0508dfca8edf7 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1256,6 +1256,10 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_size0 = {RTW89_WDE_PG_64, 4095, 1,},
 	/* DLFW */
 	.wde_size4 = {RTW89_WDE_PG_64, 0, 4096,},
+	/* PCIE 64 */
+	.wde_size6 = {RTW89_WDE_PG_64, 512, 0,},
+	/* DLFW */
+	.wde_size9 = {RTW89_WDE_PG_64, 0, 1024,},
 	/* 8852C DLFW */
 	.wde_size18 = {RTW89_WDE_PG_64, 0, 2048,},
 	/* 8852C PCIE SCC */
@@ -1264,6 +1268,10 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.ple_size0 = {RTW89_PLE_PG_128, 1520, 16,},
 	/* DLFW */
 	.ple_size4 = {RTW89_PLE_PG_128, 64, 1472,},
+	/* PCIE 64 */
+	.ple_size6 = {RTW89_PLE_PG_128, 496, 16,},
+	/* DLFW */
+	.ple_size8 = {RTW89_PLE_PG_128, 64, 960,},
 	/* 8852C DLFW */
 	.ple_size18 = {RTW89_PLE_PG_128, 2544, 16,},
 	/* 8852C PCIE SCC */
@@ -1272,6 +1280,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_qt0 = {3792, 196, 0, 107,},
 	/* DLFW */
 	.wde_qt4 = {0, 0, 0, 0,},
+	/* PCIE 64 */
+	.wde_qt6 = {448, 48, 0, 16,},
 	/* 8852C DLFW */
 	.wde_qt17 = {0, 0, 0,  0,},
 	/* 8852C PCIE SCC */
@@ -1282,6 +1292,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.ple_qt5 = {264, 0, 32, 20, 64, 13, 1101, 0, 64, 128, 120,},
 	/* DLFW */
 	.ple_qt13 = {0, 0, 16, 48, 0, 0, 0, 0, 0, 0, 0,},
+	/* PCIE 64 */
+	.ple_qt18 = {147, 0, 16, 20, 17, 13, 89, 0, 32, 14, 8, 0,},
 	/* DLFW 52C */
 	.ple_qt44 = {0, 0, 16, 256, 0, 0, 0, 0, 0, 0, 0, 0,},
 	/* DLFW 52C */
@@ -1290,6 +1302,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.ple_qt46 = {525, 0, 16, 20, 13, 13, 178, 0, 32, 62, 8, 16,},
 	/* 8852C PCIE SCC */
 	.ple_qt47 = {525, 0, 32, 20, 1034, 13, 1199, 0, 1053, 62, 160, 1037,},
+	/* PCIE 64 */
+	.ple_qt58 = {147, 0, 16, 20, 157, 13, 229, 0, 172, 14, 24, 0,},
 };
 EXPORT_SYMBOL(rtw89_mac_size);
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index c09cc1f56ec1d..6f4ada1869a17 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -691,23 +691,30 @@ struct rtw89_mac_size_set {
 	const struct rtw89_hfc_prec_cfg hfc_preccfg_pcie;
 	const struct rtw89_dle_size wde_size0;
 	const struct rtw89_dle_size wde_size4;
+	const struct rtw89_dle_size wde_size6;
+	const struct rtw89_dle_size wde_size9;
 	const struct rtw89_dle_size wde_size18;
 	const struct rtw89_dle_size wde_size19;
 	const struct rtw89_dle_size ple_size0;
 	const struct rtw89_dle_size ple_size4;
+	const struct rtw89_dle_size ple_size6;
+	const struct rtw89_dle_size ple_size8;
 	const struct rtw89_dle_size ple_size18;
 	const struct rtw89_dle_size ple_size19;
 	const struct rtw89_wde_quota wde_qt0;
 	const struct rtw89_wde_quota wde_qt4;
+	const struct rtw89_wde_quota wde_qt6;
 	const struct rtw89_wde_quota wde_qt17;
 	const struct rtw89_wde_quota wde_qt18;
 	const struct rtw89_ple_quota ple_qt4;
 	const struct rtw89_ple_quota ple_qt5;
 	const struct rtw89_ple_quota ple_qt13;
+	const struct rtw89_ple_quota ple_qt18;
 	const struct rtw89_ple_quota ple_qt44;
 	const struct rtw89_ple_quota ple_qt45;
 	const struct rtw89_ple_quota ple_qt46;
 	const struct rtw89_ple_quota ple_qt47;
+	const struct rtw89_ple_quota ple_qt58;
 };
 
 extern const struct rtw89_mac_size_set rtw89_mac_size;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 8428614a3b150..9f9908418ee4e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -6,6 +6,19 @@
 #include "mac.h"
 #include "reg.h"
 
+static const struct rtw89_dle_mem rtw8852b_dle_mem_pcie[] = {
+	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size6,
+			   &rtw89_mac_size.ple_size6, &rtw89_mac_size.wde_qt6,
+			   &rtw89_mac_size.wde_qt6, &rtw89_mac_size.ple_qt18,
+			   &rtw89_mac_size.ple_qt58},
+	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_mac_size.wde_size9,
+			    &rtw89_mac_size.ple_size8, &rtw89_mac_size.wde_qt4,
+			    &rtw89_mac_size.wde_qt4, &rtw89_mac_size.ple_qt13,
+			    &rtw89_mac_size.ple_qt13},
+	[RTW89_QTA_INVALID] = {RTW89_QTA_INVALID, NULL, NULL, NULL, NULL, NULL,
+			       NULL},
+};
+
 static int rtw8852b_mac_enable_bb_rf(struct rtw89_dev *rtwdev)
 {
 	int ret;
@@ -68,6 +81,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.chip_id		= RTL8852B,
 	.fifo_size		= 196608,
 	.dle_scc_rsvd_size	= 98304,
+	.dle_mem		= rtw8852b_dle_mem_pcie,
 	.dma_ch_mask		= BIT(RTW89_DMA_ACH4) | BIT(RTW89_DMA_ACH5) |
 				  BIT(RTW89_DMA_ACH6) | BIT(RTW89_DMA_ACH7) |
 				  BIT(RTW89_DMA_B1MG) | BIT(RTW89_DMA_B1HI),
-- 
2.25.1

