Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24ADA51D73E
	for <lists+linux-wireless@lfdr.de>; Fri,  6 May 2022 14:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391621AbiEFMGi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 May 2022 08:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391620AbiEFMGh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 May 2022 08:06:37 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F095644FF
        for <linux-wireless@vger.kernel.org>; Fri,  6 May 2022 05:02:54 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 246C2gj46029478, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 246C2gj46029478
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 6 May 2022 20:02:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 6 May 2022 20:02:42 +0800
Received: from localhost (172.16.17.21) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 6 May
 2022 20:02:42 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <hsuan8331@realtek.com>
Subject: [PATCH 3/5] rtw89: correct CCA control
Date:   Fri, 6 May 2022 20:02:14 +0800
Message-ID: <20220506120216.58567-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506120216.58567-1-pkshih@realtek.com>
References: <20220506120216.58567-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.21]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/06/2022 11:45:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzUvNiCkV6TIIDEwOjM5OjAw?=
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

EDCCA signal can block transmitting in certain situation, so ignore this
signal and use others to decide transmitting time.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index e1a1699a1a9cf..3b61ff02fe849 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1890,11 +1890,12 @@ static int cca_ctrl_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 		B_AX_CTN_CHK_BASIC_NAV | B_AX_CTN_CHK_BTCCA |
 		B_AX_CTN_CHK_EDCCA | B_AX_CTN_CHK_CCA_S80 |
 		B_AX_CTN_CHK_CCA_S40 | B_AX_CTN_CHK_CCA_S20 |
-		B_AX_CTN_CHK_CCA_P20 | B_AX_SIFS_CHK_EDCCA);
+		B_AX_CTN_CHK_CCA_P20);
 	val &= ~(B_AX_TB_CHK_TX_NAV | B_AX_TB_CHK_CCA_S80 |
 		 B_AX_TB_CHK_CCA_S40 | B_AX_TB_CHK_CCA_S20 |
 		 B_AX_SIFS_CHK_CCA_S80 | B_AX_SIFS_CHK_CCA_S40 |
-		 B_AX_SIFS_CHK_CCA_S20 | B_AX_CTN_CHK_TXNAV);
+		 B_AX_SIFS_CHK_CCA_S20 | B_AX_CTN_CHK_TXNAV |
+		 B_AX_SIFS_CHK_EDCCA);
 
 	rtw89_write32(rtwdev, reg, val);
 
-- 
2.25.1

