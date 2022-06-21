Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F57A5533BB
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jun 2022 15:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350446AbiFUNei (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jun 2022 09:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351878AbiFUNdH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jun 2022 09:33:07 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B85D25E9B
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jun 2022 06:29:32 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 25LDTJHH0005916, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 25LDTJHH0005916
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Jun 2022 21:29:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 21 Jun 2022 21:29:19 +0800
Received: from localhost (172.16.16.223) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Tue, 21 Jun
 2022 21:29:18 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <gary.chang@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 4/4] rtw88: phy: fix warning of possible buffer overflow
Date:   Tue, 21 Jun 2022 21:28:30 +0800
Message-ID: <20220621132830.8913-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220621132830.8913-1-pkshih@realtek.com>
References: <20220621132830.8913-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.223]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/21/2022 13:06:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzYvMjEgpFekyCAxMDozOTowMA==?=
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

reported by smatch

phy.c:854 rtw_phy_linear_2_db() error: buffer overflow 'db_invert_table[i]'
8 <= 8 (assuming for loop doesn't break)

However, it seems to be a false alarm because we prevent it originally via
       if (linear >= db_invert_table[11][7])
               return 96; /* maximum 96 dB */

Still, we adjust the code to be more readable and avoid smatch warning.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/phy.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 8982e0c98dac9..da1efec0aa85c 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -816,23 +816,18 @@ static u8 rtw_phy_linear_2_db(u64 linear)
 	u8 j;
 	u32 dB;
 
-	if (linear >= db_invert_table[11][7])
-		return 96; /* maximum 96 dB */
-
 	for (i = 0; i < 12; i++) {
-		if (i <= 2 && (linear << FRAC_BITS) <= db_invert_table[i][7])
-			break;
-		else if (i > 2 && linear <= db_invert_table[i][7])
-			break;
+		for (j = 0; j < 8; j++) {
+			if (i <= 2 && (linear << FRAC_BITS) <= db_invert_table[i][j])
+				goto cnt;
+			else if (i > 2 && linear <= db_invert_table[i][j])
+				goto cnt;
+		}
 	}
 
-	for (j = 0; j < 8; j++) {
-		if (i <= 2 && (linear << FRAC_BITS) <= db_invert_table[i][j])
-			break;
-		else if (i > 2 && linear <= db_invert_table[i][j])
-			break;
-	}
+	return 96; /* maximum 96 dB */
 
+cnt:
 	if (j == 0 && i == 0)
 		goto end;
 
-- 
2.25.1

