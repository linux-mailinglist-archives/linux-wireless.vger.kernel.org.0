Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A50590E1B
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 11:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237976AbiHLJby (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Aug 2022 05:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiHLJbx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Aug 2022 05:31:53 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E87B883DF
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 02:31:51 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 27C9VQiK4018007, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 27C9VQiK4018007
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 12 Aug 2022 17:31:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 12 Aug 2022 17:31:37 +0800
Received: from localhost (172.16.16.191) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 12 Aug
 2022 17:31:36 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/3] wifi: rtw89: TX power limit/limit_ru consider negative
Date:   Fri, 12 Aug 2022 17:31:14 +0800
Message-ID: <20220812093116.56791-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812093116.56791-1-pkshih@realtek.com>
References: <20220812093116.56791-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.191]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/12/2022 09:23:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzgvMTIgpFekyCAwNjoyODowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Some chips' RF TX power limit/limit_ru tables start to configure some
negative values. Fix the setting logic to prevent negative values from
polluting fields of others.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 18 ++++++++++--------
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 18 ++++++++++--------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 81bd0c4fe21bc..c8cdbc32dcf7f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -1450,7 +1450,7 @@ static void rtw8852a_set_txpwr_limit(struct rtw89_dev *rtwdev,
 	struct rtw89_txpwr_limit lmt[NTX_NUM_8852A];
 	u32 addr, val;
 	const s8 *ptr;
-	u8 i, j, k;
+	u8 i, j;
 
 	rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
 		    "[TXPWR] set txpwr limit with ch=%d bw=%d\n", ch, bw);
@@ -1461,10 +1461,11 @@ static void rtw8852a_set_txpwr_limit(struct rtw89_dev *rtwdev,
 		for (j = 0; j < __MAC_TXPWR_LMT_PAGE_SIZE; j += 4) {
 			addr = R_AX_PWR_LMT + j + __MAC_TXPWR_LMT_PAGE_SIZE * i;
 			ptr = (s8 *)&lmt[i] + j;
-			val = 0;
 
-			for (k = 0; k < 4; k++)
-				val |= (ptr[k] << (8 * k));
+			val = FIELD_PREP(GENMASK(7, 0), ptr[0]) |
+			      FIELD_PREP(GENMASK(15, 8), ptr[1]) |
+			      FIELD_PREP(GENMASK(23, 16), ptr[2]) |
+			      FIELD_PREP(GENMASK(31, 24), ptr[3]);
 
 			rtw89_mac_txpwr_write32(rtwdev, phy_idx, addr, val);
 		}
@@ -1481,7 +1482,7 @@ static void rtw8852a_set_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 	struct rtw89_txpwr_limit_ru lmt_ru[NTX_NUM_8852A];
 	u32 addr, val;
 	const s8 *ptr;
-	u8 i, j, k;
+	u8 i, j;
 
 	rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
 		    "[TXPWR] set txpwr limit ru with ch=%d bw=%d\n", ch, bw);
@@ -1493,10 +1494,11 @@ static void rtw8852a_set_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 			addr = R_AX_PWR_RU_LMT + j +
 			       __MAC_TXPWR_LMT_RU_PAGE_SIZE * i;
 			ptr = (s8 *)&lmt_ru[i] + j;
-			val = 0;
 
-			for (k = 0; k < 4; k++)
-				val |= (ptr[k] << (8 * k));
+			val = FIELD_PREP(GENMASK(7, 0), ptr[0]) |
+			      FIELD_PREP(GENMASK(15, 8), ptr[1]) |
+			      FIELD_PREP(GENMASK(23, 16), ptr[2]) |
+			      FIELD_PREP(GENMASK(31, 24), ptr[3]);
 
 			rtw89_mac_txpwr_write32(rtwdev, phy_idx, addr, val);
 		}
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index b697aef2faf2d..7f5d609b31738 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2100,7 +2100,7 @@ static void rtw8852c_set_txpwr_limit(struct rtw89_dev *rtwdev,
 	struct rtw89_txpwr_limit lmt[NTX_NUM_8852C];
 	u32 addr, val;
 	const s8 *ptr;
-	u8 i, j, k;
+	u8 i, j;
 
 	rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
 		    "[TXPWR] set txpwr limit with ch=%d bw=%d\n", ch, bw);
@@ -2111,10 +2111,11 @@ static void rtw8852c_set_txpwr_limit(struct rtw89_dev *rtwdev,
 		for (j = 0; j < __MAC_TXPWR_LMT_PAGE_SIZE; j += 4) {
 			addr = R_AX_PWR_LMT + j + __MAC_TXPWR_LMT_PAGE_SIZE * i;
 			ptr = (s8 *)&lmt[i] + j;
-			val = 0;
 
-			for (k = 0; k < 4; k++)
-				val |= (ptr[k] << (8 * k));
+			val = FIELD_PREP(GENMASK(7, 0), ptr[0]) |
+			      FIELD_PREP(GENMASK(15, 8), ptr[1]) |
+			      FIELD_PREP(GENMASK(23, 16), ptr[2]) |
+			      FIELD_PREP(GENMASK(31, 24), ptr[3]);
 
 			rtw89_mac_txpwr_write32(rtwdev, phy_idx, addr, val);
 		}
@@ -2131,7 +2132,7 @@ static void rtw8852c_set_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 	struct rtw89_txpwr_limit_ru lmt_ru[NTX_NUM_8852C];
 	u32 addr, val;
 	const s8 *ptr;
-	u8 i, j, k;
+	u8 i, j;
 
 	rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
 		    "[TXPWR] set txpwr limit ru with ch=%d bw=%d\n", ch, bw);
@@ -2143,10 +2144,11 @@ static void rtw8852c_set_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 			addr = R_AX_PWR_RU_LMT + j +
 			       __MAC_TXPWR_LMT_RU_PAGE_SIZE * i;
 			ptr = (s8 *)&lmt_ru[i] + j;
-			val = 0;
 
-			for (k = 0; k < 4; k++)
-				val |= (ptr[k] << (8 * k));
+			val = FIELD_PREP(GENMASK(7, 0), ptr[0]) |
+			      FIELD_PREP(GENMASK(15, 8), ptr[1]) |
+			      FIELD_PREP(GENMASK(23, 16), ptr[2]) |
+			      FIELD_PREP(GENMASK(31, 24), ptr[3]);
 
 			rtw89_mac_txpwr_write32(rtwdev, phy_idx, addr, val);
 		}
-- 
2.25.1

