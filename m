Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F021C6EA14F
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Apr 2023 03:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjDUBy2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 21:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjDUBy1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 21:54:27 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD37138
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 18:54:25 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33L1sAOg9005935, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33L1sAOg9005935
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 21 Apr 2023 09:54:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 21 Apr 2023 09:54:10 +0800
Received: from localhost.localdomain (172.21.69.188) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 21 Apr 2023 09:54:10 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: 8852b: adjust quota to avoid SER L1 caused by access null page
Date:   Fri, 21 Apr 2023 09:53:57 +0800
Message-ID: <20230421015357.13940-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Though SER can recover this case, traffic can get stuck for a while. Fix it
by adjusting page quota to avoid hardware access null page of CMAC/DMAC.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c      |  4 +++
 drivers/net/wireless/realtek/rtw89/mac.h      |  2 ++
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 28 +++++++++----------
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index b8019cfc11b20..512de491a064b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1425,6 +1425,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_size4 = {RTW89_WDE_PG_64, 0, 4096,},
 	/* PCIE 64 */
 	.wde_size6 = {RTW89_WDE_PG_64, 512, 0,},
+	/* 8852B PCIE SCC */
+	.wde_size7 = {RTW89_WDE_PG_64, 510, 2,},
 	/* DLFW */
 	.wde_size9 = {RTW89_WDE_PG_64, 0, 1024,},
 	/* 8852C DLFW */
@@ -1449,6 +1451,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_qt4 = {0, 0, 0, 0,},
 	/* PCIE 64 */
 	.wde_qt6 = {448, 48, 0, 16,},
+	/* 8852B PCIE SCC */
+	.wde_qt7 = {446, 48, 0, 16,},
 	/* 8852C DLFW */
 	.wde_qt17 = {0, 0, 0,  0,},
 	/* 8852C PCIE SCC */
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index a8d9847ef0b49..6ba633ccdd037 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -792,6 +792,7 @@ struct rtw89_mac_size_set {
 	const struct rtw89_dle_size wde_size0;
 	const struct rtw89_dle_size wde_size4;
 	const struct rtw89_dle_size wde_size6;
+	const struct rtw89_dle_size wde_size7;
 	const struct rtw89_dle_size wde_size9;
 	const struct rtw89_dle_size wde_size18;
 	const struct rtw89_dle_size wde_size19;
@@ -804,6 +805,7 @@ struct rtw89_mac_size_set {
 	const struct rtw89_wde_quota wde_qt0;
 	const struct rtw89_wde_quota wde_qt4;
 	const struct rtw89_wde_quota wde_qt6;
+	const struct rtw89_wde_quota wde_qt7;
 	const struct rtw89_wde_quota wde_qt17;
 	const struct rtw89_wde_quota wde_qt18;
 	const struct rtw89_ple_quota ple_qt4;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index eaa2ea0586bc6..6da1b603a9a95 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -18,25 +18,25 @@
 	RTW8852B_FW_BASENAME "-" __stringify(RTW8852B_FW_FORMAT_MAX) ".bin"
 
 static const struct rtw89_hfc_ch_cfg rtw8852b_hfc_chcfg_pcie[] = {
-	{5, 343, grp_0}, /* ACH 0 */
-	{5, 343, grp_0}, /* ACH 1 */
-	{5, 343, grp_0}, /* ACH 2 */
-	{5, 343, grp_0}, /* ACH 3 */
+	{5, 341, grp_0}, /* ACH 0 */
+	{5, 341, grp_0}, /* ACH 1 */
+	{4, 342, grp_0}, /* ACH 2 */
+	{4, 342, grp_0}, /* ACH 3 */
 	{0, 0, grp_0}, /* ACH 4 */
 	{0, 0, grp_0}, /* ACH 5 */
 	{0, 0, grp_0}, /* ACH 6 */
 	{0, 0, grp_0}, /* ACH 7 */
-	{4, 344, grp_0}, /* B0MGQ */
-	{4, 344, grp_0}, /* B0HIQ */
+	{4, 342, grp_0}, /* B0MGQ */
+	{4, 342, grp_0}, /* B0HIQ */
 	{0, 0, grp_0}, /* B1MGQ */
 	{0, 0, grp_0}, /* B1HIQ */
 	{40, 0, 0} /* FWCMDQ */
 };
 
 static const struct rtw89_hfc_pub_cfg rtw8852b_hfc_pubcfg_pcie = {
-	448, /* Group 0 */
+	446, /* Group 0 */
 	0, /* Group 1 */
-	448, /* Public Max */
+	446, /* Public Max */
 	0 /* WP threshold */
 };
 
@@ -49,13 +49,13 @@ static const struct rtw89_hfc_param_ini rtw8852b_hfc_param_ini_pcie[] = {
 };
 
 static const struct rtw89_dle_mem rtw8852b_dle_mem_pcie[] = {
-	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size6,
-			   &rtw89_mac_size.ple_size6, &rtw89_mac_size.wde_qt6,
-			   &rtw89_mac_size.wde_qt6, &rtw89_mac_size.ple_qt18,
+	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size7,
+			   &rtw89_mac_size.ple_size6, &rtw89_mac_size.wde_qt7,
+			   &rtw89_mac_size.wde_qt7, &rtw89_mac_size.ple_qt18,
 			   &rtw89_mac_size.ple_qt58},
-	[RTW89_QTA_WOW] = {RTW89_QTA_WOW, &rtw89_mac_size.wde_size6,
-			   &rtw89_mac_size.ple_size6, &rtw89_mac_size.wde_qt6,
-			   &rtw89_mac_size.wde_qt6, &rtw89_mac_size.ple_qt18,
+	[RTW89_QTA_WOW] = {RTW89_QTA_WOW, &rtw89_mac_size.wde_size7,
+			   &rtw89_mac_size.ple_size6, &rtw89_mac_size.wde_qt7,
+			   &rtw89_mac_size.wde_qt7, &rtw89_mac_size.ple_qt18,
 			   &rtw89_mac_size.ple_qt_52b_wow},
 	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_mac_size.wde_size9,
 			    &rtw89_mac_size.ple_size8, &rtw89_mac_size.wde_qt4,
-- 
2.25.1

