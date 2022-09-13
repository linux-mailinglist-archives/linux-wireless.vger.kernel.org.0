Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52A25B6AA4
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Sep 2022 11:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiIMJ1E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Sep 2022 05:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiIMJ1A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Sep 2022 05:27:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 699CF286D5
        for <linux-wireless@vger.kernel.org>; Tue, 13 Sep 2022 02:26:59 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28D9QVCC0005578, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28D9QVCC0005578
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 13 Sep 2022 17:26:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 13 Sep 2022 17:26:51 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 13 Sep
 2022 17:26:51 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 3/7] wifi: rtw89: coex: Move coexistence firmware buffer size parameter to chip info
Date:   Tue, 13 Sep 2022 17:25:42 +0800
Message-ID: <20220913092546.43722-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913092546.43722-1-pkshih@realtek.com>
References: <20220913092546.43722-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/13/2022 08:01:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMTMgpFekyCAwNjowMDowMA==?=
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

From: Ching-Te Ku <ku920601@realtek.com>

Because RTL8852A/RTL8852C use different firmware buffer size to
send C2H packet, it's necessary to use different size to parse C2H report.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c     | 5 ++---
 drivers/net/wireless/realtek/rtw89/core.h     | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 1 +
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 74d503ea4965e..6fdc2c33b7c6a 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -650,8 +650,6 @@ static void _reset_btc_var(struct rtw89_dev *rtwdev, u8 type)
 		memset(&btc->mdinfo, 0, sizeof(btc->mdinfo));
 }
 
-#define BTC_FWINFO_BUF 1024
-
 #define BTC_RPT_HDR_SIZE 3
 #define BTC_CHK_WLSLOT_DRIFT_MAX 15
 #define BTC_CHK_HANG_MAX 3
@@ -1315,6 +1313,7 @@ static void _parse_btc_report(struct rtw89_dev *rtwdev,
 			      struct rtw89_btc_btf_fwinfo *pfwinfo,
 			      u8 *pbuf, u32 buf_len)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc_prpt *btc_prpt = NULL;
 	u32 index = 0, rpt_len = 0;
 
@@ -1324,7 +1323,7 @@ static void _parse_btc_report(struct rtw89_dev *rtwdev,
 
 	while (pbuf) {
 		btc_prpt = (struct rtw89_btc_prpt *)&pbuf[index];
-		if (index + 2 >= BTC_FWINFO_BUF)
+		if (index + 2 >= chip->btc_fwinfo_buf)
 			break;
 		/* At least 3 bytes: type(1) & len(2) */
 		rpt_len = le16_to_cpu(btc_prpt->len);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 6737ce7b6ebb6..3caa8cfd5e5e7 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2654,6 +2654,7 @@ struct rtw89_chip_info {
 	u8 btcx_desired;
 	u8 scbd;
 	u8 mailbox;
+	u16 btc_fwinfo_buf;
 
 	u8 fcxbtcrpt_ver;
 	u8 fcxtdma_ver;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 4eddfa23dcadc..a2d0f2e2794e5 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2190,6 +2190,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.btcx_desired		= 0x5,
 	.scbd			= 0x1,
 	.mailbox		= 0x1,
+	.btc_fwinfo_buf		= 1024,
 
 	.fcxbtcrpt_ver		= 1,
 	.fcxtdma_ver		= 1,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 0d92518a1e0df..817bb57698ba8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3035,6 +3035,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.btcx_desired		= 0x5,
 	.scbd			= 0x1,
 	.mailbox		= 0x1,
+	.btc_fwinfo_buf		= 1280,
 
 	.fcxbtcrpt_ver		= 4,
 	.fcxtdma_ver		= 3,
-- 
2.25.1

