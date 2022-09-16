Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EF45BA57B
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Sep 2022 05:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiIPDjT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Sep 2022 23:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiIPDi7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Sep 2022 23:38:59 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45DDB9DB55
        for <linux-wireless@vger.kernel.org>; Thu, 15 Sep 2022 20:38:58 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28G3cTn75003901, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28G3cTn75003901
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 16 Sep 2022 11:38:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 16 Sep 2022 11:38:51 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 16 Sep
 2022 11:38:50 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/7] wifi: rtw89: pci: update LTR settings
Date:   Fri, 16 Sep 2022 11:38:07 +0800
Message-ID: <20220916033811.13862-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220916033811.13862-1-pkshih@realtek.com>
References: <20220916033811.13862-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/16/2022 02:51:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMTUgpFWkyCAxMDo1NzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

Modify PCI LTR control flow and LTR idle latency to improve power save
efficiency.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 8 ++++----
 drivers/net/wireless/realtek/rtw89/reg.h | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index d2cbe0468cd78..71cc4e9093718 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -2491,15 +2491,15 @@ int rtw89_pci_ltr_set(struct rtw89_dev *rtwdev, bool en)
 	if (rtw89_pci_ltr_is_err_reg_val(val))
 		return -EINVAL;
 
-	rtw89_write32_clr(rtwdev, R_AX_LTR_CTRL_0, B_AX_LTR_HW_EN);
-	rtw89_write32_set(rtwdev, R_AX_LTR_CTRL_0, B_AX_LTR_EN);
+	rtw89_write32_set(rtwdev, R_AX_LTR_CTRL_0, B_AX_LTR_HW_EN | B_AX_LTR_EN |
+						   B_AX_LTR_WD_NOEMP_CHK);
 	rtw89_write32_mask(rtwdev, R_AX_LTR_CTRL_0, B_AX_LTR_SPACE_IDX_MASK,
 			   PCI_LTR_SPC_500US);
 	rtw89_write32_mask(rtwdev, R_AX_LTR_CTRL_0, B_AX_LTR_IDLE_TIMER_IDX_MASK,
-			   PCI_LTR_IDLE_TIMER_800US);
+			   PCI_LTR_IDLE_TIMER_3_2MS);
 	rtw89_write32_mask(rtwdev, R_AX_LTR_CTRL_1, B_AX_LTR_RX0_TH_MASK, 0x28);
 	rtw89_write32_mask(rtwdev, R_AX_LTR_CTRL_1, B_AX_LTR_RX1_TH_MASK, 0x28);
-	rtw89_write32(rtwdev, R_AX_LTR_IDLE_LATENCY, 0x88e088e0);
+	rtw89_write32(rtwdev, R_AX_LTR_IDLE_LATENCY, 0x90039003);
 	rtw89_write32(rtwdev, R_AX_LTR_ACTIVE_LATENCY, 0x880b880b);
 
 	return 0;
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 32605841c98c4..aa164ec0cc5af 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -479,6 +479,7 @@
 #define R_AX_LTR_CTRL_0 0x8410
 #define B_AX_LTR_SPACE_IDX_MASK GENMASK(13, 12)
 #define B_AX_LTR_IDLE_TIMER_IDX_MASK GENMASK(10, 8)
+#define B_AX_LTR_WD_NOEMP_CHK BIT(6)
 #define B_AX_APP_LTR_ACT BIT(5)
 #define B_AX_APP_LTR_IDLE BIT(4)
 #define B_AX_LTR_EN BIT(1)
-- 
2.25.1

