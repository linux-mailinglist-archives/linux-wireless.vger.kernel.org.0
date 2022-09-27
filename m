Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8A35EBAA0
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Sep 2022 08:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiI0G2N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Sep 2022 02:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiI0G2L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Sep 2022 02:28:11 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D210785F9E
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 23:28:01 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28R6Qkj96008410, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28R6Qkj96008410
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 27 Sep 2022 14:26:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 27 Sep 2022 14:27:11 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 27 Sep
 2022 14:27:11 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 7/9] wifi: rtw89: mac: correct register of report IMR
Date:   Tue, 27 Sep 2022 14:26:09 +0800
Message-ID: <20220927062611.30484-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220927062611.30484-1-pkshih@realtek.com>
References: <20220927062611.30484-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/27/2022 06:02:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMjcgpFekyCAwNDo1MzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The register of report IMR is chip specific, so add a field to strut to
correct them.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     | 1 +
 drivers/net/wireless/realtek/rtw89/mac.c      | 2 +-
 drivers/net/wireless/realtek/rtw89/reg.h      | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 1 +
 5 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index d79e84f436c1a..be01350ee0e29 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2563,6 +2563,7 @@ struct rtw89_imr_info {
 	u32 cpu_disp_imr_set;
 	u32 other_disp_imr_clr;
 	u32 other_disp_imr_set;
+	u32 bbrpt_com_err_imr_reg;
 	u32 bbrpt_chinfo_err_imr_reg;
 	u32 bbrpt_err_imr_set;
 	u32 bbrpt_dfs_err_imr_reg;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 30132c4583d7d..8fd70730689f8 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2853,7 +2853,7 @@ static void rtw89_bbrpt_imr_enable(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_imr_info *imr = rtwdev->chip->imr_info;
 
-	rtw89_write32_set(rtwdev, R_AX_BBRPT_COM_ERR_IMR,
+	rtw89_write32_set(rtwdev, imr->bbrpt_com_err_imr_reg,
 			  B_AX_BBRPT_COM_NULL_PLPKTID_ERR_INT_EN);
 	rtw89_write32_clr(rtwdev, imr->bbrpt_chinfo_err_imr_reg,
 			  B_AX_BBRPT_CHINFO_IMR_CLR);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index cb81c7eaece8a..ca20bb024b407 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -2280,6 +2280,7 @@
 #define B_AX_F2PCMDRPT_FULL_DROP_ERR_INT_EN BIT(8)
 #define B_AX_FSM1_TIMEOUT_ERR_INT_EN BIT(1)
 #define B_AX_FSM_TIMEOUT_ERR_INT_EN BIT(0)
+#define B_AX_PTCL_IMR_CLR_ALL GENMASK(31, 0)
 #define B_AX_PTCL_IMR_CLR (B_AX_FSM_TIMEOUT_ERR_INT_EN | \
 			   B_AX_F2PCMDRPT_FULL_DROP_ERR_INT_EN | \
 			   B_AX_TXPRT_FULL_DROP_ERR_INT_EN | \
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 124e63fe69681..948a2027ed69c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -431,6 +431,7 @@ static const struct rtw89_imr_info rtw8852a_imr_info = {
 	.cpu_disp_imr_set	= B_AX_CPU_DISP_IMR_SET,
 	.other_disp_imr_clr	= B_AX_OTHER_DISP_IMR_CLR,
 	.other_disp_imr_set	= 0,
+	.bbrpt_com_err_imr_reg	= R_AX_BBRPT_COM_ERR_IMR_ISR,
 	.bbrpt_chinfo_err_imr_reg = R_AX_BBRPT_CHINFO_ERR_IMR_ISR,
 	.bbrpt_err_imr_set	= 0,
 	.bbrpt_dfs_err_imr_reg	= R_AX_BBRPT_DFS_ERR_IMR_ISR,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 00462c912ec7e..c8c0d68e16014 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -109,6 +109,7 @@ static const struct rtw89_imr_info rtw8852c_imr_info = {
 	.cpu_disp_imr_set	= B_AX_CPU_DISP_IMR_SET_V1,
 	.other_disp_imr_clr	= B_AX_OTHER_DISP_IMR_CLR_V1,
 	.other_disp_imr_set	= B_AX_OTHER_DISP_IMR_SET_V1,
+	.bbrpt_com_err_imr_reg	= R_AX_BBRPT_COM_ERR_IMR,
 	.bbrpt_chinfo_err_imr_reg = R_AX_BBRPT_CHINFO_ERR_IMR,
 	.bbrpt_err_imr_set	= R_AX_BBRPT_CHINFO_IMR_SET_V1,
 	.bbrpt_dfs_err_imr_reg	= R_AX_BBRPT_DFS_ERR_IMR,
-- 
2.25.1

