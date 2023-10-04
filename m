Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A187B7BB9
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 11:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjJDJSY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 05:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241873AbjJDIv2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 04:51:28 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BE0B0
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 01:51:24 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3948pFTW13164838, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 3948pFTW13164838
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Oct 2023 16:51:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 4 Oct 2023 16:51:15 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 4 Oct 2023
 16:51:14 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/5] wifi: rtw88: regd: update regulatory map to R64-R42
Date:   Wed, 4 Oct 2023 16:50:50 +0800
Message-ID: <20231004085051.205683-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004085051.205683-1-pkshih@realtek.com>
References: <20231004085051.205683-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.25]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Sync Realtek Regulatory R42 and Realtek Channel Plan R64.
Start to configure with Realtek regd CHILE, CN, UK, QATAR, UKRAINE.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/regd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/regd.c b/drivers/net/wireless/realtek/rtw88/regd.c
index 680d8f32fce6..124fc7ae6a14 100644
--- a/drivers/net/wireless/realtek/rtw88/regd.c
+++ b/drivers/net/wireless/realtek/rtw88/regd.c
@@ -70,16 +70,16 @@ static const struct rtw_regulatory rtw_reg_map[] = {
 	COUNTRY_REGD_ENT("BY", RTW_REGD_ETSI, RTW_REGD_ETSI),
 	COUNTRY_REGD_ENT("BZ", RTW_REGD_FCC, RTW_REGD_FCC),
 	COUNTRY_REGD_ENT("CA", RTW_REGD_IC, RTW_REGD_IC),
-	COUNTRY_REGD_ENT("CC", RTW_REGD_ETSI, RTW_REGD_ETSI),
+	COUNTRY_REGD_ENT("CC", RTW_REGD_ACMA, RTW_REGD_ACMA),
 	COUNTRY_REGD_ENT("CD", RTW_REGD_ETSI, RTW_REGD_ETSI),
 	COUNTRY_REGD_ENT("CF", RTW_REGD_ETSI, RTW_REGD_ETSI),
 	COUNTRY_REGD_ENT("CG", RTW_REGD_ETSI, RTW_REGD_ETSI),
 	COUNTRY_REGD_ENT("CH", RTW_REGD_ETSI, RTW_REGD_ETSI),
 	COUNTRY_REGD_ENT("CI", RTW_REGD_ETSI, RTW_REGD_ETSI),
 	COUNTRY_REGD_ENT("CK", RTW_REGD_ETSI, RTW_REGD_ETSI),
-	COUNTRY_REGD_ENT("CL", RTW_REGD_FCC, RTW_REGD_FCC),
+	COUNTRY_REGD_ENT("CL", RTW_REGD_CHILE, RTW_REGD_CHILE),
 	COUNTRY_REGD_ENT("CM", RTW_REGD_ETSI, RTW_REGD_ETSI),
-	COUNTRY_REGD_ENT("CN", RTW_REGD_ETSI, RTW_REGD_ETSI),
+	COUNTRY_REGD_ENT("CN", RTW_REGD_CN, RTW_REGD_CN),
 	COUNTRY_REGD_ENT("CO", RTW_REGD_FCC, RTW_REGD_FCC),
 	COUNTRY_REGD_ENT("CR", RTW_REGD_FCC, RTW_REGD_FCC),
 	COUNTRY_REGD_ENT("CV", RTW_REGD_ETSI, RTW_REGD_ETSI),
@@ -106,7 +106,7 @@ static const struct rtw_regulatory rtw_reg_map[] = {
 	COUNTRY_REGD_ENT("FO", RTW_REGD_ETSI, RTW_REGD_ETSI),
 	COUNTRY_REGD_ENT("FR", RTW_REGD_ETSI, RTW_REGD_ETSI),
 	COUNTRY_REGD_ENT("GA", RTW_REGD_ETSI, RTW_REGD_ETSI),
-	COUNTRY_REGD_ENT("GB", RTW_REGD_ETSI, RTW_REGD_ETSI),
+	COUNTRY_REGD_ENT("GB", RTW_REGD_UK, RTW_REGD_UK),
 	COUNTRY_REGD_ENT("GD", RTW_REGD_FCC, RTW_REGD_FCC),
 	COUNTRY_REGD_ENT("GE", RTW_REGD_ETSI, RTW_REGD_ETSI),
 	COUNTRY_REGD_ENT("GF", RTW_REGD_ETSI, RTW_REGD_ETSI),
@@ -214,7 +214,7 @@ static const struct rtw_regulatory rtw_reg_map[] = {
 	COUNTRY_REGD_ENT("PT", RTW_REGD_ETSI, RTW_REGD_ETSI),
 	COUNTRY_REGD_ENT("PW", RTW_REGD_FCC, RTW_REGD_FCC),
 	COUNTRY_REGD_ENT("PY", RTW_REGD_FCC, RTW_REGD_FCC),
-	COUNTRY_REGD_ENT("QA", RTW_REGD_ETSI, RTW_REGD_ETSI),
+	COUNTRY_REGD_ENT("QA", RTW_REGD_QATAR, RTW_REGD_QATAR),
 	COUNTRY_REGD_ENT("RE", RTW_REGD_ETSI, RTW_REGD_ETSI),
 	COUNTRY_REGD_ENT("RO", RTW_REGD_ETSI, RTW_REGD_ETSI),
 	COUNTRY_REGD_ENT("RS", RTW_REGD_ETSI, RTW_REGD_ETSI),
@@ -234,7 +234,7 @@ static const struct rtw_regulatory rtw_reg_map[] = {
 	COUNTRY_REGD_ENT("SN", RTW_REGD_ETSI, RTW_REGD_ETSI),
 	COUNTRY_REGD_ENT("SO", RTW_REGD_ETSI, RTW_REGD_ETSI),
 	COUNTRY_REGD_ENT("SR", RTW_REGD_FCC, RTW_REGD_FCC),
-	COUNTRY_REGD_ENT("ST", RTW_REGD_FCC, RTW_REGD_FCC),
+	COUNTRY_REGD_ENT("ST", RTW_REGD_ETSI, RTW_REGD_ETSI),
 	COUNTRY_REGD_ENT("SV", RTW_REGD_FCC, RTW_REGD_FCC),
 	COUNTRY_REGD_ENT("SX", RTW_REGD_FCC, RTW_REGD_FCC),
 	COUNTRY_REGD_ENT("SZ", RTW_REGD_ETSI, RTW_REGD_ETSI),
@@ -253,7 +253,7 @@ static const struct rtw_regulatory rtw_reg_map[] = {
 	COUNTRY_REGD_ENT("TV", RTW_REGD_ETSI, RTW_REGD_WW),
 	COUNTRY_REGD_ENT("TW", RTW_REGD_FCC, RTW_REGD_FCC),
 	COUNTRY_REGD_ENT("TZ", RTW_REGD_ETSI, RTW_REGD_ETSI),
-	COUNTRY_REGD_ENT("UA", RTW_REGD_ETSI, RTW_REGD_ETSI),
+	COUNTRY_REGD_ENT("UA", RTW_REGD_UKRAINE, RTW_REGD_UKRAINE),
 	COUNTRY_REGD_ENT("UG", RTW_REGD_ETSI, RTW_REGD_ETSI),
 	COUNTRY_REGD_ENT("US", RTW_REGD_FCC, RTW_REGD_FCC),
 	COUNTRY_REGD_ENT("UY", RTW_REGD_FCC, RTW_REGD_FCC),
-- 
2.25.1

