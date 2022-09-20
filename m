Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C045BD92F
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 03:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiITBLa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 21:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiITBLF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 21:11:05 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE55852E63
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 18:10:33 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28K19ucP6031045, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28K19ucP6031045
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 20 Sep 2022 09:09:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 09:10:19 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 20 Sep
 2022 09:10:18 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/9] wifi: rtw89: coex: translate slot ID to readable name
Date:   Tue, 20 Sep 2022 09:09:32 +0800
Message-ID: <20220920010939.12173-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920010939.12173-1-pkshih@realtek.com>
References: <20220920010939.12173-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/20/2022 00:43:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMTkgpFWkyCAwNzowODowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

To analyze debug log quickly, use readable name in string format instead.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 30 ++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 991ebd94086bf..b6366e0cf82ad 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -5727,6 +5727,7 @@ static void _show_bt_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 #define CASE_BTC_ACT_STR(e) case BTC_ACT_ ## e | BTC_ACT_EXT_BIT: return #e
 #define CASE_BTC_POLICY_STR(e) \
 	case BTC_CXP_ ## e | BTC_POLICY_EXT_BIT: return #e
+#define CASE_BTC_SLOT_STR(e) case CXST_ ## e: return #e
 
 static const char *steps_to_str(u16 step)
 {
@@ -5840,6 +5841,32 @@ static const char *steps_to_str(u16 step)
 	}
 }
 
+static const char *id_to_slot(u32 id)
+{
+	switch (id) {
+	CASE_BTC_SLOT_STR(OFF);
+	CASE_BTC_SLOT_STR(B2W);
+	CASE_BTC_SLOT_STR(W1);
+	CASE_BTC_SLOT_STR(W2);
+	CASE_BTC_SLOT_STR(W2B);
+	CASE_BTC_SLOT_STR(B1);
+	CASE_BTC_SLOT_STR(B2);
+	CASE_BTC_SLOT_STR(B3);
+	CASE_BTC_SLOT_STR(B4);
+	CASE_BTC_SLOT_STR(LK);
+	CASE_BTC_SLOT_STR(BLK);
+	CASE_BTC_SLOT_STR(E2G);
+	CASE_BTC_SLOT_STR(E5G);
+	CASE_BTC_SLOT_STR(EBT);
+	CASE_BTC_SLOT_STR(ENULL);
+	CASE_BTC_SLOT_STR(WLK);
+	CASE_BTC_SLOT_STR(W1FDD);
+	CASE_BTC_SLOT_STR(B1FDD);
+	default:
+		return "unknown";
+	}
+}
+
 static
 void seq_print_segment(struct seq_file *m, const char *prefix, u16 *data,
 		       u8 len, u8 seg_len, u8 start_idx, u8 ring_len)
@@ -6239,7 +6266,8 @@ static void _show_fbtc_cysta_v1(struct rtw89_dev *rtwdev, struct seq_file *m)
 		if (!le32_to_cpu(pcysta->slot_cnt[i]))
 			continue;
 
-		seq_printf(m, ", %d:%d", i, le32_to_cpu(pcysta->slot_cnt[i]));
+		seq_printf(m, ", %s:%d", id_to_slot(i),
+			   le32_to_cpu(pcysta->slot_cnt[i]));
 	}
 
 	if (dm->tdma_now.rxflctrl)
-- 
2.25.1

