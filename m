Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F333776F66E
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Aug 2023 02:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjHDAOs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 20:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjHDAOr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 20:14:47 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A8693AA9
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 17:14:44 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3740EIz34026165, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3740EIz34026165
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 4 Aug 2023 08:14:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 4 Aug 2023 08:13:48 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 4 Aug 2023
 08:13:47 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2] wifi: rtw89: regd: update regulatory map to R64-R42
Date:   Fri, 4 Aug 2023 08:13:22 +0800
Message-ID: <20230804001322.4131-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Sync Realtek Regulatory R42 and Realtek Channel Plan R64, which configures
Realtek 6 GHz regd for some countries as below.
 * AR, MX, HT -> FCC
 * LB, ZA, TH, BF, LA, MN -> ETSI

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: add more description about the changes of regulatory map.
---
 drivers/net/wireless/realtek/rtw89/regd.c | 26 +++++++++++------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index 34c4d40cfa02..b9a62a5dad51 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -13,10 +13,10 @@
 	}
 
 static const struct rtw89_regd rtw89_ww_regd =
-	COUNTRY_REGD("00", RTW89_WW, RTW89_WW);
+	COUNTRY_REGD("00", RTW89_WW, RTW89_WW, RTW89_WW);
 
 static const struct rtw89_regd rtw89_regd_map[] = {
-	COUNTRY_REGD("AR", RTW89_MEXICO, RTW89_MEXICO, RTW89_NA),
+	COUNTRY_REGD("AR", RTW89_MEXICO, RTW89_MEXICO, RTW89_FCC),
 	COUNTRY_REGD("BO", RTW89_FCC, RTW89_FCC, RTW89_FCC),
 	COUNTRY_REGD("BR", RTW89_FCC, RTW89_FCC, RTW89_FCC),
 	COUNTRY_REGD("CL", RTW89_CHILE, RTW89_CHILE, RTW89_CHILE),
@@ -26,7 +26,7 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("SV", RTW89_FCC, RTW89_FCC, RTW89_FCC),
 	COUNTRY_REGD("GT", RTW89_FCC, RTW89_FCC, RTW89_FCC),
 	COUNTRY_REGD("HN", RTW89_FCC, RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("MX", RTW89_MEXICO, RTW89_MEXICO, RTW89_NA),
+	COUNTRY_REGD("MX", RTW89_MEXICO, RTW89_MEXICO, RTW89_FCC),
 	COUNTRY_REGD("NI", RTW89_FCC, RTW89_FCC, RTW89_NA),
 	COUNTRY_REGD("PA", RTW89_FCC, RTW89_FCC, RTW89_NA),
 	COUNTRY_REGD("PY", RTW89_FCC, RTW89_FCC, RTW89_NA),
@@ -81,7 +81,7 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("KE", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("KW", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("KG", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("LB", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("LB", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("LS", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("MK", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("MA", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
@@ -96,7 +96,7 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("SN", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("RS", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("ME", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
-	COUNTRY_REGD("ZA", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("ZA", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("TR", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("UA", RTW89_UKRAINE, RTW89_UKRAINE, RTW89_UKRAINE),
 	COUNTRY_REGD("AE", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
@@ -115,7 +115,7 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("SG", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("LK", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("TW", RTW89_FCC, RTW89_FCC, RTW89_NA),
-	COUNTRY_REGD("TH", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("TH", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("VN", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("AU", RTW89_ACMA, RTW89_ACMA, RTW89_ACMA),
 	COUNTRY_REGD("NZ", RTW89_ACMA, RTW89_ACMA, RTW89_ACMA),
@@ -148,7 +148,7 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("IO", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("VG", RTW89_FCC, RTW89_FCC, RTW89_FCC),
 	COUNTRY_REGD("BN", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
-	COUNTRY_REGD("BF", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("BF", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("MM", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("BI", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("CM", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
@@ -164,7 +164,7 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("CK", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("CI", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("DJ", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("DM", RTW89_FCC, RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("DM", RTW89_FCC, RTW89_FCC, RTW89_NA),
 	COUNTRY_REGD("GQ", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("ER", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("ET", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
@@ -179,20 +179,20 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("GE", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("GI", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("GL", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
-	COUNTRY_REGD("GD", RTW89_FCC, RTW89_FCC, RTW89_FCC),
+	COUNTRY_REGD("GD", RTW89_FCC, RTW89_FCC, RTW89_NA),
 	COUNTRY_REGD("GP", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("GU", RTW89_FCC, RTW89_FCC, RTW89_NA),
 	COUNTRY_REGD("GG", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("GN", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("GW", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
-	COUNTRY_REGD("GY", RTW89_FCC, RTW89_FCC, RTW89_FCC),
-	COUNTRY_REGD("HT", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("GY", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("HT", RTW89_FCC, RTW89_FCC, RTW89_FCC),
 	COUNTRY_REGD("HM", RTW89_ACMA, RTW89_ACMA, RTW89_NA),
 	COUNTRY_REGD("VA", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("IM", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("JE", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("KI", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
-	COUNTRY_REGD("LA", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("LA", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("LR", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("LY", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("MO", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
@@ -207,7 +207,7 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("YT", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("FM", RTW89_FCC, RTW89_FCC, RTW89_NA),
 	COUNTRY_REGD("MD", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
-	COUNTRY_REGD("MN", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("MN", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("MS", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("NR", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("NP", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
-- 
2.25.1

