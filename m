Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F0766925B
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jan 2023 10:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241200AbjAMJKZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Jan 2023 04:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240798AbjAMJJ7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Jan 2023 04:09:59 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BF3A43A39
        for <linux-wireless@vger.kernel.org>; Fri, 13 Jan 2023 01:07:12 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 30D95qLhA029922, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 30D95qLhA029922
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 13 Jan 2023 17:05:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Fri, 13 Jan 2023 17:06:50 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 13 Jan
 2023 17:06:50 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <gary.chang@realtek.com>, <echuang@realtek.com>,
        <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/4] wifi: rtw89: correct register definitions of digital CFO and spur elimination
Date:   Fri, 13 Jan 2023 17:06:29 +0800
Message-ID: <20230113090632.60957-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230113090632.60957-1-pkshih@realtek.com>
References: <20230113090632.60957-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 01/13/2023 08:45:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMTMgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Eric Huang <echuang@realtek.com>

This change fixes the precision of CFO and TX EVM, and it could imporve
performance in some cases. Also, use the correctted definition for 8852A.

Signed-off-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 578a1969afd61..412a6918efd6c 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -4102,9 +4102,9 @@
 #define R_MUIC 0x40F8
 #define B_MUIC_EN BIT(0)
 #define R_DCFO 0x4264
-#define B_DCFO GENMASK(1, 0)
+#define B_DCFO GENMASK(7, 0)
 #define R_SEG0CSI 0x42AC
-#define B_SEG0CSI_IDX GENMASK(11, 0)
+#define B_SEG0CSI_IDX GENMASK(10, 0)
 #define R_SEG0CSI_EN 0x42C4
 #define B_SEG0CSI_EN BIT(23)
 #define R_BSS_CLR_MAP 0x43ac
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 1875c2537ddbd..9f1b134ec8590 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -1035,7 +1035,7 @@ static void rtw8852a_spur_elimination(struct rtw89_dev *rtwdev, u8 central_ch)
 				       0x210);
 		rtw89_phy_write32_mask(rtwdev, R_P1_NBIIDX, B_P1_NBIIDX_VAL,
 				       0x210);
-		rtw89_phy_write32_mask(rtwdev, R_SEG0CSI, 0xfff, 0x7c0);
+		rtw89_phy_write32_mask(rtwdev, R_SEG0CSI, B_SEG0CSI_IDX, 0x7c0);
 		rtw89_phy_write32_mask(rtwdev, R_P0_NBIIDX,
 				       B_P0_NBIIDX_NOTCH_EN, 0x1);
 		rtw89_phy_write32_mask(rtwdev, R_P1_NBIIDX,
@@ -1047,7 +1047,7 @@ static void rtw8852a_spur_elimination(struct rtw89_dev *rtwdev, u8 central_ch)
 				       0x210);
 		rtw89_phy_write32_mask(rtwdev, R_P1_NBIIDX, B_P1_NBIIDX_VAL,
 				       0x210);
-		rtw89_phy_write32_mask(rtwdev, R_SEG0CSI, 0xfff, 0x40);
+		rtw89_phy_write32_mask(rtwdev, R_SEG0CSI, B_SEG0CSI_IDX, 0x40);
 		rtw89_phy_write32_mask(rtwdev, R_P0_NBIIDX,
 				       B_P0_NBIIDX_NOTCH_EN, 0x1);
 		rtw89_phy_write32_mask(rtwdev, R_P1_NBIIDX,
@@ -1059,7 +1059,7 @@ static void rtw8852a_spur_elimination(struct rtw89_dev *rtwdev, u8 central_ch)
 				       0x2d0);
 		rtw89_phy_write32_mask(rtwdev, R_P1_NBIIDX, B_P1_NBIIDX_VAL,
 				       0x2d0);
-		rtw89_phy_write32_mask(rtwdev, R_SEG0CSI, 0xfff, 0x740);
+		rtw89_phy_write32_mask(rtwdev, R_SEG0CSI, B_SEG0CSI_IDX, 0x740);
 		rtw89_phy_write32_mask(rtwdev, R_P0_NBIIDX,
 				       B_P0_NBIIDX_NOTCH_EN, 0x1);
 		rtw89_phy_write32_mask(rtwdev, R_P1_NBIIDX,
-- 
2.25.1

