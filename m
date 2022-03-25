Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E43F4E6E0A
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 07:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358411AbiCYGD5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 02:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358396AbiCYGDz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 02:03:55 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CF9C6835
        for <linux-wireless@vger.kernel.org>; Thu, 24 Mar 2022 23:02:20 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22P62EgrC011135, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22P62EgrC011135
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Mar 2022 14:02:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 25 Mar 2022 14:02:14 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 14:02:14 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>
Subject: [PATCH 12/16] rtw89: 8852c: update security engine setting
Date:   Fri, 25 Mar 2022 14:00:51 +0800
Message-ID: <20220325060055.58482-13-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

The security setting of 8852A and 8852C are different, so change the
settings accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 8 +++++++-
 drivers/net/wireless/realtek/rtw89/reg.h | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 85f2a147b5612..f542678b1c22d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1696,6 +1696,7 @@ static int mpdu_proc_init(struct rtw89_dev *rtwdev)
 
 static int sec_eng_init(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u32 val = 0;
 	int ret;
 
@@ -1709,7 +1710,8 @@ static int sec_eng_init(struct rtw89_dev *rtwdev)
 	/* init TX encryption */
 	val |= (B_AX_SEC_TX_ENC | B_AX_SEC_RX_DEC);
 	val |= (B_AX_MC_DEC | B_AX_BC_DEC);
-	val &= ~B_AX_TX_PARTIAL_MODE;
+	if (chip->chip_id == RTL8852A || chip->chip_id == RTL8852B)
+		val &= ~B_AX_TX_PARTIAL_MODE;
 	rtw89_write32(rtwdev, R_AX_SEC_ENG_CTRL, val);
 
 	/* init MIC ICV append */
@@ -1719,6 +1721,10 @@ static int sec_eng_init(struct rtw89_dev *rtwdev)
 	/* option init */
 	rtw89_write32(rtwdev, R_AX_SEC_MPDU_PROC, val);
 
+	if (chip->chip_id == RTL8852C)
+		rtw89_write32_mask(rtwdev, R_AX_SEC_DEBUG1,
+				   B_AX_TX_TIMEOUT_SEL_MASK, AX_TX_TO_VAL);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 1f4cf30f3822b..3505c9dd8a793 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -799,6 +799,9 @@
 #define R_AX_SEC_CAM_RDATA 0x9D14
 #define R_AX_SEC_CAM_WDATA 0x9D18
 #define R_AX_SEC_DEBUG 0x9D1C
+#define R_AX_SEC_DEBUG1 0x9D1C
+#define B_AX_TX_TIMEOUT_SEL_MASK GENMASK(31, 30)
+#define AX_TX_TO_VAL  0x2
 #define R_AX_SEC_TX_DEBUG 0x9D20
 #define R_AX_SEC_RX_DEBUG 0x9D24
 #define R_AX_SEC_TRX_PKT_CNT 0x9D28
-- 
2.25.1

