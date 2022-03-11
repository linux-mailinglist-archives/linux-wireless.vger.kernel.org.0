Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184F24D58AA
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Mar 2022 04:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345926AbiCKDFJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Mar 2022 22:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345925AbiCKDFI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Mar 2022 22:05:08 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E461A6FA9
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 19:04:05 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22B33xrZ6021517, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22B33xrZ6021517
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Mar 2022 11:03:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 11 Mar 2022 11:03:59 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 11 Mar
 2022 11:03:58 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>,
        <hsuan8331@realtek.com>, <yuanhan1020@realtek.com>
Subject: [PATCH 08/11] rtw89: disable FW and H2C function if CPU disabled
Date:   Fri, 11 Mar 2022 11:02:58 +0800
Message-ID: <20220311030301.33921-9-pkshih@realtek.com>
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

Initialize FW status and disabled H2C function if CPU disabled. Then, it
can reset to initial state.

Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 83690656c3e8e..e52b0e7b53829 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2685,7 +2685,11 @@ static void rtw89_mac_disable_cpu(struct rtw89_dev *rtwdev)
 	clear_bit(RTW89_FLAG_FW_RDY, rtwdev->flags);
 
 	rtw89_write32_clr(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_WCPU_EN);
+	rtw89_write32_clr(rtwdev, R_AX_WCPU_FW_CTRL, B_AX_WCPU_FWDL_EN |
+			  B_AX_H2C_PATH_RDY | B_AX_FWDL_PATH_RDY);
 	rtw89_write32_clr(rtwdev, R_AX_SYS_CLK_CTRL, B_AX_CPU_CLK_EN);
+	rtw89_write32_clr(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_PLATFORM_EN);
+	rtw89_write32_set(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_PLATFORM_EN);
 }
 
 static int rtw89_mac_enable_cpu(struct rtw89_dev *rtwdev, u8 boot_reason,
-- 
2.25.1

