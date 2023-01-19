Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765C86731D2
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 07:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjASGgD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 01:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjASGf7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 01:35:59 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 030E953551
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 22:35:57 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 30J6ZoccE012556, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 30J6ZoccE012556
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 19 Jan 2023 14:35:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Thu, 19 Jan 2023 14:35:51 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 19 Jan
 2023 14:35:51 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/2] wifi: rtw89: deal with RXI300 error
Date:   Thu, 19 Jan 2023 14:35:29 +0800
Message-ID: <20230119063529.61563-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230119063529.61563-1-pkshih@realtek.com>
References: <20230119063529.61563-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 01/19/2023 06:15:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMTkgpFekyCAwMzozNzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

RXI300 is a HW design to maintain stuffs across BUS, e.g. AXI, AHB, APB.
It will feedback an error when host does an invalid BUS operation.
For example,
* BUS master request without power/clock on.
* host reads/writes/accesses an invalid address.

They might lead to problems such as BUS timeout, platform hang, etc. So,
once if RXI300 feedback an error, it notifies that driver need a L2 SER
(system error recovery) to reset things.

Previously, driver did not parse the error scenario for RXI300. We add
it and assign a corresponding error code which will make SER flow do L2
reset.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 5 ++++-
 drivers/net/wireless/realtek/rtw89/mac.h | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 5ab0590485e0d..baac14f8f5328 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -623,7 +623,8 @@ static void rtw89_mac_dump_err_status(struct rtw89_dev *rtwdev,
 	if (err != MAC_AX_ERR_L1_ERR_DMAC &&
 	    err != MAC_AX_ERR_L0_PROMOTE_TO_L1 &&
 	    err != MAC_AX_ERR_L0_ERR_CMAC0 &&
-	    err != MAC_AX_ERR_L0_ERR_CMAC1)
+	    err != MAC_AX_ERR_L0_ERR_CMAC1 &&
+	    err != MAC_AX_ERR_RXI300)
 		return;
 
 	rtw89_info(rtwdev, "--->\nerr=0x%x\n", err);
@@ -663,6 +664,8 @@ u32 rtw89_mac_get_err_status(struct rtw89_dev *rtwdev)
 		err = MAC_AX_ERR_CPU_EXCEPTION;
 	else if (err_scnr == RTW89_WCPU_ASSERTION)
 		err = MAC_AX_ERR_ASSERTION;
+	else if (err_scnr == RTW89_RXI300_ERROR)
+		err = MAC_AX_ERR_RXI300;
 
 	rtw89_fw_st_dbg_dump(rtwdev);
 	rtw89_mac_dump_err_status(rtwdev, err);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index f0b684b205f10..5a5feb9101a94 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -623,6 +623,7 @@ struct rtw89_mac_dle_dfi_qempty {
 };
 
 enum rtw89_mac_error_scenario {
+	RTW89_RXI300_ERROR		= 1,
 	RTW89_WCPU_CPU_EXCEPTION	= 2,
 	RTW89_WCPU_ASSERTION		= 3,
 };
@@ -769,6 +770,7 @@ enum mac_ax_err_info {
 	MAC_AX_ERR_L2_ERR_WDT_TIMEOUT_INT = 0x2599,
 	MAC_AX_ERR_CPU_EXCEPTION = 0x3000,
 	MAC_AX_ERR_ASSERTION = 0x4000,
+	MAC_AX_ERR_RXI300 = 0x5000,
 	MAC_AX_GET_ERR_MAX,
 	MAC_AX_DUMP_SHAREBUFF_INDICATOR = 0x80000000,
 
-- 
2.25.1

