Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49456647C08
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Dec 2022 03:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiLICLB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Dec 2022 21:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiLICK6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Dec 2022 21:10:58 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B188B9580
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 18:10:55 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2B92A0XE0005392, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2B92A0XE0005392
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 9 Dec 2022 10:10:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Fri, 9 Dec 2022 10:10:48 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 9 Dec 2022
 10:10:47 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/3] wifi: rtw89: 8852c: rfk: correct DPK settings
Date:   Fri, 9 Dec 2022 10:09:39 +0800
Message-ID: <20221209020940.9573-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221209020940.9573-1-pkshih@realtek.com>
References: <20221209020940.9573-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 12/09/2022 01:50:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzkgpFekyCAxMjoyMzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some DPK settings are wrong, and causes bad TX performance occasionally.
So, fix them by internal suggestions.

Fixes: da4cea16cb13 ("rtw89: 8852c: rfk: add DPK")
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h          | 2 ++
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c | 9 ++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 5324e645728bb..ca6f6c3e63095 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3671,6 +3671,8 @@
 #define RR_TXRSV_GAPK BIT(19)
 #define RR_BIAS 0x5e
 #define RR_BIAS_GAPK BIT(19)
+#define RR_TXAC 0x5f
+#define RR_TXAC_IQG GENMASK(3, 0)
 #define RR_BIASA 0x60
 #define RR_BIASA_TXG GENMASK(15, 12)
 #define RR_BIASA_TXA GENMASK(19, 16)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index f5b0b57f33207..f3a07b0e672f7 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -1872,12 +1872,11 @@ static void _dpk_rf_setting(struct rtw89_dev *rtwdev, u8 gain,
 			       0x50101 | BIT(rtwdev->dbcc_en));
 		rtw89_write_rf(rtwdev, path, RR_MOD_V1, RR_MOD_MASK, RF_DPK);
 
-		if (dpk->bp[path][kidx].band == RTW89_BAND_6G && dpk->bp[path][kidx].ch >= 161) {
+		if (dpk->bp[path][kidx].band == RTW89_BAND_6G && dpk->bp[path][kidx].ch >= 161)
 			rtw89_write_rf(rtwdev, path, RR_IQGEN, RR_IQGEN_BIAS, 0x8);
-			rtw89_write_rf(rtwdev, path, RR_LOGEN, RR_LOGEN_RPT, 0xd);
-		} else {
-			rtw89_write_rf(rtwdev, path, RR_LOGEN, RR_LOGEN_RPT, 0xd);
-		}
+
+		rtw89_write_rf(rtwdev, path, RR_LOGEN, RR_LOGEN_RPT, 0xd);
+		rtw89_write_rf(rtwdev, path, RR_TXAC, RR_TXAC_IQG, 0x8);
 
 		rtw89_write_rf(rtwdev, path, RR_RXA2, RR_RXA2_ATT, 0x0);
 		rtw89_write_rf(rtwdev, path, RR_TXIQK, RR_TXIQK_ATT2, 0x3);
-- 
2.25.1

