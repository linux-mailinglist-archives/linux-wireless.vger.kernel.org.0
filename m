Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD19D731988
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jun 2023 15:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239668AbjFONFb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jun 2023 09:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238051AbjFONF3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jun 2023 09:05:29 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF2B213F
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 06:05:28 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35FD51Kc8032315, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35FD51Kc8032315
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 15 Jun 2023 21:05:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 15 Jun 2023 21:05:20 +0800
Received: from [127.0.1.1] (172.16.16.227) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 15 Jun
 2023 21:05:20 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/5] wifi: rtw89: 8851b: update RF radio A parameters to R28
Date:   Thu, 15 Jun 2023 21:04:38 +0800
Message-ID: <20230615130442.18116-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615130442.18116-1-pkshih@realtek.com>
References: <20230615130442.18116-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.227]
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

Update 8851b radio A parameters to R28 along with internal HALRF_029_00_103

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../wireless/realtek/rtw89/rtw8851b_table.c   | 28 +++++++++++++++----
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c
index bb724140df4f7..aeee246baba9c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c
@@ -1273,6 +1273,25 @@ static const struct rtw89_reg2_def rtw89_8851b_phy_radioa_regs[] = {
 	{0xF0010000, 0x00000000},
 	{0xF0020000, 0x00000001},
 	{0xF0030000, 0x00000002},
+	{0xF0010001, 0x00000003},
+	{0xF0020001, 0x00000004},
+	{0xF0030001, 0x00000005},
+	{0xF0040001, 0x00000006},
+	{0xF0050001, 0x00000007},
+	{0xF0060001, 0x00000008},
+	{0x000, 0x00000000},
+	{0x0EF, 0x00080000},
+	{0x033, 0x00000003},
+	{0x03E, 0x00000150},
+	{0x03F, 0x0000D79C},
+	{0x0EF, 0x00000000},
+	{0x052, 0x000C3338},
+	{0x053, 0x000608AF},
+	{0x054, 0x00006C04},
+	{0x063, 0x000FC082},
+	{0x065, 0x00018122},
+	{0x000, 0x00010000},
+	{0x0FE, 0x0000005A},
 	{0x000, 0x00030000},
 	{0x018, 0x00013124},
 	{0x0EF, 0x00080000},
@@ -1834,8 +1853,6 @@ static const struct rtw89_reg2_def rtw89_8851b_phy_radioa_regs[] = {
 	{0x059, 0x00050033},
 	{0x061, 0x0005F48A},
 	{0x062, 0x00077435},
-	{0x063, 0x000F80A2},
-	{0x065, 0x00018F22},
 	{0x067, 0x00008060},
 	{0x07E, 0x0009780B},
 	{0x0EE, 0x00000004},
@@ -2074,9 +2091,6 @@ static const struct rtw89_reg2_def rtw89_8851b_phy_radioa_regs[] = {
 	{0x03F, 0x0001C3C3},
 	{0x0EF, 0x00000000},
 	{0x051, 0x0003D368},
-	{0x052, 0x000A3338},
-	{0x053, 0x000688AF},
-	{0x054, 0x00012C04},
 	{0x058, 0x00084221},
 	{0x05B, 0x000EB000},
 	{0x100EE, 0x00002000},
@@ -2229,9 +2243,11 @@ static const struct rtw89_reg2_def rtw89_8851b_phy_radioa_regs[] = {
 	{0x033, 0x00000000},
 	{0x03F, 0x00000004},
 	{0x0EF, 0x00000000},
+	{0x000, 0x00010000},
+	{0x0FE, 0x0000005A},
 	{0x005, 0x00000001},
 	{0x10005, 0x00000001},
-	{0x0FE, 0x00000022},
+	{0x0FE, 0x00000028},
 };
 
 static const struct rtw89_reg2_def rtw89_8851b_phy_nctl_regs[] = {
-- 
2.25.1

