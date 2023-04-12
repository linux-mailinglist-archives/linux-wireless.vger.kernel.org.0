Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFD06DE8DA
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Apr 2023 03:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjDLB2z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Apr 2023 21:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjDLB2x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Apr 2023 21:28:53 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F213A9E
        for <linux-wireless@vger.kernel.org>; Tue, 11 Apr 2023 18:28:51 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33C1SMf64009253, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33C1SMf64009253
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 12 Apr 2023 09:28:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 12 Apr 2023 09:28:44 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 12 Apr
 2023 09:28:43 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/4] wifi: rtw89: coex: Enable Wi-Fi RX gain control for free run solution
Date:   Wed, 12 Apr 2023 09:28:28 +0800
Message-ID: <20230412012831.10519-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230412012831.10519-1-pkshih@realtek.com>
References: <20230412012831.10519-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

When Wi-Fi & Bluetooth are both busy at the same time, Wi-Fi need to
enable RX gain to protect Wi-Fi RX RF ability. Without this configure
the interference from Bluetooth will bring a big impact to Wi-Fi RX.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index bae80984cfd51..ed12f72301be7 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -323,7 +323,7 @@ static const struct rtw89_btc_rf_trx_para rtw89_btc_8852b_rf_ul[] = {
 	{255, 0, 0, 7}, /* 2 ->reserved for shared-antenna */
 	{255, 0, 0, 7}, /* 3- >reserved for shared-antenna */
 	{255, 0, 0, 7}, /* 4 ->reserved for shared-antenna */
-	{255, 0, 0, 7}, /* the below id is for non-shared-antenna free-run */
+	{255, 1, 0, 7}, /* the below id is for non-shared-antenna free-run */
 	{6, 1, 0, 7},
 	{13, 1, 0, 7},
 	{13, 1, 0, 7}
@@ -335,7 +335,7 @@ static const struct rtw89_btc_rf_trx_para rtw89_btc_8852b_rf_dl[] = {
 	{255, 0, 0, 7}, /* 2 ->reserved for shared-antenna */
 	{255, 0, 0, 7}, /* 3- >reserved for shared-antenna */
 	{255, 0, 0, 7}, /* 4 ->reserved for shared-antenna */
-	{255, 0, 0, 7}, /* the below id is for non-shared-antenna free-run */
+	{255, 1, 0, 7}, /* the below id is for non-shared-antenna free-run */
 	{255, 1, 0, 7},
 	{255, 1, 0, 7},
 	{255, 1, 0, 7}
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index ba728fca91881..78d618dd714c0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2536,7 +2536,7 @@ static const struct rtw89_btc_rf_trx_para rtw89_btc_8852c_rf_ul[] = {
 	{255, 0, 0, 7}, /* 2 ->reserved for shared-antenna */
 	{255, 0, 0, 7}, /* 3- >reserved for shared-antenna */
 	{255, 0, 0, 7}, /* 4 ->reserved for shared-antenna */
-	{255, 0, 0, 7}, /* the below id is for non-shared-antenna free-run */
+	{255, 1, 0, 7}, /* the below id is for non-shared-antenna free-run */
 	{6, 1, 0, 7},
 	{13, 1, 0, 7},
 	{13, 1, 0, 7}
@@ -2548,7 +2548,7 @@ static const struct rtw89_btc_rf_trx_para rtw89_btc_8852c_rf_dl[] = {
 	{255, 0, 0, 7}, /* 2 ->reserved for shared-antenna */
 	{255, 0, 0, 7}, /* 3- >reserved for shared-antenna */
 	{255, 0, 0, 7}, /* 4 ->reserved for shared-antenna */
-	{255, 0, 0, 7}, /* the below id is for non-shared-antenna free-run */
+	{255, 1, 0, 7}, /* the below id is for non-shared-antenna free-run */
 	{255, 1, 0, 7},
 	{255, 1, 0, 7},
 	{255, 1, 0, 7}
-- 
2.25.1

