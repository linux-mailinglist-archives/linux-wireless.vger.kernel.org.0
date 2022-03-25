Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40ED4E6E09
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 07:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358410AbiCYGDy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 02:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354867AbiCYGDx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 02:03:53 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135E0C682F
        for <linux-wireless@vger.kernel.org>; Thu, 24 Mar 2022 23:02:19 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22P62DOY0011128, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22P62DOY0011128
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Mar 2022 14:02:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 25 Mar 2022 14:02:13 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 14:02:12 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>
Subject: [PATCH 11/16] rtw89: Turn on CR protection of CMAC
Date:   Fri, 25 Mar 2022 14:00:50 +0800
Message-ID: <20220325060055.58482-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220325060055.58482-1-pkshih@realtek.com>
References: <20220325060055.58482-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/25/2022 05:51:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMjUgpFekyCAwNDo0ODowMA==?=
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

CMAC is Control MAC, and this patch is to turn on CR (control registers)
protection.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 07a5e10e010f5..85f2a147b5612 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1119,7 +1119,8 @@ static int cmac_func_en(struct rtw89_dev *rtwdev, u8 mac_idx, bool en)
 
 	func_en = B_AX_CMAC_EN | B_AX_CMAC_TXEN | B_AX_CMAC_RXEN |
 			B_AX_PHYINTF_EN | B_AX_CMAC_DMA_EN | B_AX_PTCLTOP_EN |
-			B_AX_SCHEDULER_EN | B_AX_TMAC_EN | B_AX_RMAC_EN;
+			B_AX_SCHEDULER_EN | B_AX_TMAC_EN | B_AX_RMAC_EN |
+			B_AX_CMAC_CRPRT;
 	ck_en = B_AX_CMAC_CKEN | B_AX_PHYINTF_CKEN | B_AX_CMAC_DMA_CKEN |
 		      B_AX_PTCLTOP_CKEN | B_AX_SCHEDULER_CKEN | B_AX_TMAC_CKEN |
 		      B_AX_RMAC_CKEN;
-- 
2.25.1

