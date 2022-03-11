Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298D64D58A7
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Mar 2022 04:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345923AbiCKDFF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Mar 2022 22:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345905AbiCKDFE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Mar 2022 22:05:04 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB59119CCF3
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 19:04:01 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22B33tFqA021503, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22B33tFqA021503
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Mar 2022 11:03:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 11 Mar 2022 11:03:55 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 11 Mar
 2022 11:03:55 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>,
        <hsuan8331@realtek.com>, <yuanhan1020@realtek.com>
Subject: [PATCH 06/11] rtw89: modify MAC enable functions
Date:   Fri, 11 Mar 2022 11:02:56 +0800
Message-ID: <20220311030301.33921-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220311030301.33921-1-pkshih@realtek.com>
References: <20220311030301.33921-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/11/2022 02:42:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMTEgpFekyCAwMTowNjowMA==?=
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

From: Chia-Yuan Li <leo.li@realtek.com>

Modify functions that control D-MAC (data MAC) and LDO to support variant
chips.

Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 29 +++++++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/reg.h |  2 ++
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 8fbdfd983cc53..aa33ec95aa36b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1128,18 +1128,31 @@ static int cmac_func_en(struct rtw89_dev *rtwdev, u8 mac_idx, bool en)
 
 static int dmac_func_en(struct rtw89_dev *rtwdev)
 {
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	u32 val32;
 
-	val32 = (B_AX_MAC_FUNC_EN | B_AX_DMAC_FUNC_EN | B_AX_MAC_SEC_EN |
-		 B_AX_DISPATCHER_EN | B_AX_DLE_CPUIO_EN | B_AX_PKT_IN_EN |
-		 B_AX_DMAC_TBL_EN | B_AX_PKT_BUF_EN | B_AX_STA_SCH_EN |
-		 B_AX_TXPKT_CTRL_EN | B_AX_WD_RLS_EN | B_AX_MPDU_PROC_EN);
+	if (chip_id == RTL8852C)
+		val32 = (B_AX_MAC_FUNC_EN | B_AX_DMAC_FUNC_EN |
+			 B_AX_MAC_SEC_EN | B_AX_DISPATCHER_EN |
+			 B_AX_DLE_CPUIO_EN | B_AX_PKT_IN_EN |
+			 B_AX_DMAC_TBL_EN | B_AX_PKT_BUF_EN |
+			 B_AX_STA_SCH_EN | B_AX_TXPKT_CTRL_EN |
+			 B_AX_WD_RLS_EN | B_AX_MPDU_PROC_EN |
+			 B_AX_DMAC_CRPRT | B_AX_H_AXIDMA_EN);
+	else
+		val32 = (B_AX_MAC_FUNC_EN | B_AX_DMAC_FUNC_EN |
+			 B_AX_MAC_SEC_EN | B_AX_DISPATCHER_EN |
+			 B_AX_DLE_CPUIO_EN | B_AX_PKT_IN_EN |
+			 B_AX_DMAC_TBL_EN | B_AX_PKT_BUF_EN |
+			 B_AX_STA_SCH_EN | B_AX_TXPKT_CTRL_EN |
+			 B_AX_WD_RLS_EN | B_AX_MPDU_PROC_EN |
+			 B_AX_DMAC_CRPRT);
 	rtw89_write32(rtwdev, R_AX_DMAC_FUNC_EN, val32);
 
 	val32 = (B_AX_MAC_SEC_CLK_EN | B_AX_DISPATCHER_CLK_EN |
 		 B_AX_DLE_CPUIO_CLK_EN | B_AX_PKT_IN_CLK_EN |
 		 B_AX_STA_SCH_CLK_EN | B_AX_TXPKT_CTRL_CLK_EN |
-		 B_AX_WD_RLS_CLK_EN);
+		 B_AX_WD_RLS_CLK_EN | B_AX_BBRPT_CLK_EN);
 	rtw89_write32(rtwdev, R_AX_DMAC_CLK_EN, val32);
 
 	return 0;
@@ -1147,7 +1160,11 @@ static int dmac_func_en(struct rtw89_dev *rtwdev)
 
 static int chip_func_en(struct rtw89_dev *rtwdev)
 {
-	rtw89_write32_set(rtwdev, R_AX_SPSLDO_ON_CTRL0, B_AX_OCP_L1_MASK);
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
+
+	if (chip_id == RTL8852A)
+		rtw89_write32_set(rtwdev, R_AX_SPSLDO_ON_CTRL0,
+				  B_AX_OCP_L1_MASK);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 26efdfa70c044..94ec7b2aad9db 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -312,6 +312,7 @@
 #define R_AX_BOOT_DBG 0x83F0
 
 #define R_AX_DMAC_FUNC_EN 0x8400
+#define B_AX_DMAC_CRPRT BIT(31)
 #define B_AX_MAC_FUNC_EN BIT(30)
 #define B_AX_DMAC_FUNC_EN BIT(29)
 #define B_AX_MPDU_PROC_EN BIT(28)
@@ -339,6 +340,7 @@
 #define B_AX_PKT_IN_CLK_EN BIT(20)
 #define B_AX_DLE_CPUIO_CLK_EN BIT(19)
 #define B_AX_DISPATCHER_CLK_EN BIT(18)
+#define B_AX_BBRPT_CLK_EN BIT(17)
 #define B_AX_MAC_SEC_CLK_EN BIT(16)
 
 #define PCI_LTR_IDLE_TIMER_1US 0
-- 
2.25.1

