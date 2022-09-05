Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14155ACEC7
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Sep 2022 11:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbiIEJ0d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Sep 2022 05:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236692AbiIEJ01 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Sep 2022 05:26:27 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE8BF3C17D
        for <linux-wireless@vger.kernel.org>; Mon,  5 Sep 2022 02:26:24 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2859PsFjA013732, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2859PsFjA013732
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 5 Sep 2022 17:25:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Sep 2022 17:26:12 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 5 Sep 2022
 17:26:11 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/7] wifi: rtw89: coex: Parsing Wi-Fi firmware error message from reports
Date:   Mon, 5 Sep 2022 17:25:36 +0800
Message-ID: <20220905092539.51926-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905092539.51926-1-pkshih@realtek.com>
References: <20220905092539.51926-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/05/2022 09:05:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvNSCkV6TIIDAzOjM4OjAw?=
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

Parsing firmware error message from original version and v1 reports.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 6fdc2c33b7c6a..66adf4eb44559 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -5963,14 +5963,24 @@ static void _show_dm_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 
 static void _show_error(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
-	struct rtw89_btc_fbtc_cysta *pcysta = NULL;
+	struct rtw89_btc_fbtc_cysta *pcysta;
+	struct rtw89_btc_fbtc_cysta_v1 *pcysta_v1;
+	u32 except_cnt, exception_map;
 
-	pcysta = &pfwinfo->rpt_fbtc_cysta.finfo;
+	if (chip->chip_id == RTL8852A) {
+		pcysta = &pfwinfo->rpt_fbtc_cysta.finfo;
+		except_cnt = le32_to_cpu(pcysta->except_cnt);
+		exception_map = le32_to_cpu(pcysta->exception);
+	} else {
+		pcysta_v1 = &pfwinfo->rpt_fbtc_cysta.finfo_v1;
+		except_cnt = le32_to_cpu(pcysta_v1->except_cnt);
+		exception_map = le32_to_cpu(pcysta_v1->except_map);
+	}
 
-	if (pfwinfo->event[BTF_EVNT_BUF_OVERFLOW] == 0 &&
-	    pcysta->except_cnt == 0 &&
+	if (pfwinfo->event[BTF_EVNT_BUF_OVERFLOW] == 0 && except_cnt == 0 &&
 	    !pfwinfo->len_mismch && !pfwinfo->fver_mismch)
 		return;
 
@@ -5995,10 +6005,10 @@ static void _show_error(struct rtw89_dev *rtwdev, struct seq_file *m)
 	}
 
 	/* cycle statistics exceptions */
-	if (pcysta->exception || pcysta->except_cnt) {
+	if (exception_map || except_cnt) {
 		seq_printf(m,
 			   "exception-type: 0x%x, exception-cnt = %d",
-			   pcysta->exception, pcysta->except_cnt);
+			   exception_map, except_cnt);
 	}
 	seq_puts(m, "\n");
 }
-- 
2.25.1

