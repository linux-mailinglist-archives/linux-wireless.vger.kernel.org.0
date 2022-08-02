Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB29587C87
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Aug 2022 14:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbiHBMi4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Aug 2022 08:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbiHBMiz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Aug 2022 08:38:55 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B2D520BC2
        for <linux-wireless@vger.kernel.org>; Tue,  2 Aug 2022 05:38:54 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 272CccuT7002236, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 272CccuT7002236
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 2 Aug 2022 20:38:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 2 Aug 2022 20:38:47 +0800
Received: from localhost (172.16.16.191) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 2 Aug 2022
 20:38:46 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <leo.li@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: 8852a: correct WDE IMR settings
Date:   Tue, 2 Aug 2022 20:38:16 +0800
Message-ID: <20220802123816.16685-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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
X-KSE-Antiphishing-Bases: 08/02/2022 12:07:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzgvMiCkV6TIIDEwOjMzOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chia-Yuan Li <leo.li@realtek.com>

Correct IMR settings to let self error recover mechanism works accurately.

Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index ebf28719d935e..76d3d9aa8745b 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -1024,15 +1024,13 @@
 			  B_AX_WDE_DATCHN_NULLPG_ERR_INT_EN | \
 			  B_AX_WDE_DATCHN_FRZTO_ERR_INT_EN)
 #define B_AX_WDE_IMR_SET (B_AX_WDE_BUFREQ_QTAID_ERR_INT_EN | \
-			  B_AX_WDE_BUFREQ_SIZE0_INT_EN | \
-			  B_AX_WDE_BUFREQ_SIZELMT_INT_EN | \
-			  B_AX_WDE_BUFREQ_UNAVAL_ERR_INT_EN_V1 | \
-			  B_AX_WDE_BUFRTN_INVLD_PKTID_ERR_INT_EN_V1 | \
-			  B_AX_WDE_BUFRTN_SIZE_ERR_INT_EN_V1 | \
-			  B_AX_WDE_BUFREQ_SRCHTAILPG_ERR_INT_EN_V1 | \
-			  B_AX_WDE_GETNPG_STRPG_ERR_INT_EN_V1 | \
-			  B_AX_WDE_GETNPG_PGOFST_ERR_INT_EN_V1 | \
-			  B_AX_WDE_BUFMGN_FRZTO_ERR_INT_EN_V1 | \
+			  B_AX_WDE_BUFREQ_UNAVAL_ERR_INT_EN | \
+			  B_AX_WDE_BUFRTN_INVLD_PKTID_ERR_INT_EN | \
+			  B_AX_WDE_BUFRTN_SIZE_ERR_INT_EN | \
+			  B_AX_WDE_BUFREQ_SRCHTAILPG_ERR_INT_EN | \
+			  B_AX_WDE_GETNPG_STRPG_ERR_INT_EN | \
+			  B_AX_WDE_GETNPG_PGOFST_ERR_INT_EN | \
+			  B_AX_WDE_BUFMGN_FRZTO_ERR_INT_EN | \
 			  B_AX_WDE_QUE_CMDTYPE_ERR_INT_EN | \
 			  B_AX_WDE_QUE_DSTQUEID_ERR_INT_EN | \
 			  B_AX_WDE_QUE_SRCQUEID_ERR_INT_EN | \
@@ -1043,10 +1041,7 @@
 			  B_AX_WDE_QUEMGN_FRZTO_ERR_INT_EN | \
 			  B_AX_WDE_DATCHN_ARBT_ERR_INT_EN | \
 			  B_AX_WDE_DATCHN_NULLPG_ERR_INT_EN | \
-			  B_AX_WDE_DATCHN_FRZTO_ERR_INT_EN | \
-			  B_AX_WDE_DATCHN_RRDY_ERR_INT_EN | \
-			  B_AX_WDE_DATCHN_ADRERR_ERR_INT_EN | \
-			  B_AX_WDE_DATCHN_CAMREQ_ERR_INT_EN)
+			  B_AX_WDE_DATCHN_FRZTO_ERR_INT_EN)
 
 #define B_AX_WDE_DATCHN_CAMREQ_ERR_INT_EN BIT(29)
 #define B_AX_WDE_DATCHN_ADRERR_ERR_INT_EN BIT(28)
-- 
2.25.1

