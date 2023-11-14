Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AE57EACC0
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Nov 2023 10:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjKNJPH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Nov 2023 04:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjKNJPE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Nov 2023 04:15:04 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662B4FA
        for <linux-wireless@vger.kernel.org>; Tue, 14 Nov 2023 01:15:01 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AE9Es8L2814942, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AE9Es8L2814942
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 17:14:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 14 Nov 2023 17:14:54 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 14 Nov
 2023 17:14:54 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/3] wifi: rtw89: regd: update regulatory map to R65-R44
Date:   Tue, 14 Nov 2023 17:13:59 +0800
Message-ID: <20231114091359.50664-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231114091359.50664-1-pkshih@realtek.com>
References: <20231114091359.50664-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.94]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Sync Realtek Regulatory R44 and Realtek Channel Plan R65.
Configure 6 GHz field of Realtek regd on SG, TW, GD.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/regd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index d9d13887604b..d0857ef60ea6 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -112,9 +112,9 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("MY", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("PK", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("PH", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
-	COUNTRY_REGD("SG", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
+	COUNTRY_REGD("SG", RTW89_ETSI, RTW89_ETSI, RTW89_ETSI),
 	COUNTRY_REGD("LK", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
-	COUNTRY_REGD("TW", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("TW", RTW89_FCC, RTW89_FCC, RTW89_ETSI),
 	COUNTRY_REGD("TH", RTW89_ETSI, RTW89_ETSI, RTW89_THAILAND),
 	COUNTRY_REGD("VN", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("AU", RTW89_ACMA, RTW89_ACMA, RTW89_ACMA),
@@ -179,7 +179,7 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("GE", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("GI", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("GL", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
-	COUNTRY_REGD("GD", RTW89_FCC, RTW89_FCC, RTW89_NA),
+	COUNTRY_REGD("GD", RTW89_FCC, RTW89_FCC, RTW89_FCC),
 	COUNTRY_REGD("GP", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("GU", RTW89_FCC, RTW89_FCC, RTW89_NA),
 	COUNTRY_REGD("GG", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
-- 
2.25.1

