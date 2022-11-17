Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDE462D361
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Nov 2022 07:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238829AbiKQGT2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Nov 2022 01:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbiKQGT1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Nov 2022 01:19:27 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4ADDA22500
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 22:19:24 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2AH6IZkrC008775, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2AH6IZkrC008775
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 17 Nov 2022 14:18:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 17 Nov 2022 14:19:16 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 17 Nov
 2022 14:19:15 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: 8852b: correct TX power controlled by BT-coexistence
Date:   Thu, 17 Nov 2022 14:18:32 +0800
Message-ID: <20221117061832.42057-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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
X-KSE-Antiphishing-Bases: 11/17/2022 06:00:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzE3IKRXpMggMDM6MzM6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When coexistence mechanism is under free-run mode, it could adjust WiFi
and BT TX power to avoid interference with each other. For other cases,
it should keep original TX power from regular predefined tables, so
set correct values to 255 for these cases.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 0df044b1c392a..85dfc1ebb0d97 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -318,27 +318,27 @@ static const struct rtw89_dig_regs rtw8852b_dig_regs = {
 };
 
 static const struct rtw89_btc_rf_trx_para rtw89_btc_8852b_rf_ul[] = {
-	{15, 0, 0, 7}, /* 0 -> original */
-	{15, 2, 0, 7}, /* 1 -> for BT-connected ACI issue && BTG co-rx */
-	{15, 0, 0, 7}, /* 2 ->reserved for shared-antenna */
-	{15, 0, 0, 7}, /* 3- >reserved for shared-antenna */
-	{15, 0, 0, 7}, /* 4 ->reserved for shared-antenna */
-	{15, 0, 0, 7}, /* the below id is for non-shared-antenna free-run */
+	{255, 0, 0, 7}, /* 0 -> original */
+	{255, 2, 0, 7}, /* 1 -> for BT-connected ACI issue && BTG co-rx */
+	{255, 0, 0, 7}, /* 2 ->reserved for shared-antenna */
+	{255, 0, 0, 7}, /* 3- >reserved for shared-antenna */
+	{255, 0, 0, 7}, /* 4 ->reserved for shared-antenna */
+	{255, 0, 0, 7}, /* the below id is for non-shared-antenna free-run */
 	{6, 1, 0, 7},
 	{13, 1, 0, 7},
 	{13, 1, 0, 7}
 };
 
 static const struct rtw89_btc_rf_trx_para rtw89_btc_8852b_rf_dl[] = {
-	{15, 0, 0, 7}, /* 0 -> original */
-	{15, 2, 0, 7}, /* 1 -> reserved for shared-antenna */
-	{15, 0, 0, 7}, /* 2 ->reserved for shared-antenna */
-	{15, 0, 0, 7}, /* 3- >reserved for shared-antenna */
-	{15, 0, 0, 7}, /* 4 ->reserved for shared-antenna */
-	{15, 0, 0, 7}, /* the below id is for non-shared-antenna free-run */
-	{15, 1, 0, 7},
-	{15, 1, 0, 7},
-	{15, 1, 0, 7}
+	{255, 0, 0, 7}, /* 0 -> original */
+	{255, 2, 0, 7}, /* 1 -> reserved for shared-antenna */
+	{255, 0, 0, 7}, /* 2 ->reserved for shared-antenna */
+	{255, 0, 0, 7}, /* 3- >reserved for shared-antenna */
+	{255, 0, 0, 7}, /* 4 ->reserved for shared-antenna */
+	{255, 0, 0, 7}, /* the below id is for non-shared-antenna free-run */
+	{255, 1, 0, 7},
+	{255, 1, 0, 7},
+	{255, 1, 0, 7}
 };
 
 static const struct rtw89_btc_fbtc_mreg rtw89_btc_8852b_mon_reg[] = {
-- 
2.25.1

