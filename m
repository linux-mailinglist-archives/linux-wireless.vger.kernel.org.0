Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7762E5B7FC2
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Sep 2022 05:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiINDve (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Sep 2022 23:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiINDv3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Sep 2022 23:51:29 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D53326F54E
        for <linux-wireless@vger.kernel.org>; Tue, 13 Sep 2022 20:51:26 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28E3oqcZ7007538, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28E3oqcZ7007538
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 14 Sep 2022 11:50:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 11:51:13 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 14 Sep
 2022 11:51:12 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/4] wifi: rtw89: 8852c: support fw crash simulation
Date:   Wed, 14 Sep 2022 11:50:33 +0800
Message-ID: <20220914035034.14521-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914035034.14521-1-pkshih@realtek.com>
References: <20220914035034.14521-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/14/2022 03:18:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMTMgpFWkyCAxMToxMjowMA==?=
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

With FW >= v0.27.40.0, 8852C FW has feature to handle crash simulation.
Besides, use RTW89_WCPU_BASE_MASK to replace use of RTW89_WCPU_BASE_ADDR
and work for both 8852A and 8852C.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c  | 1 +
 drivers/net/wireless/realtek/rtw89/fw.h  | 2 +-
 drivers/net/wireless/realtek/rtw89/ser.c | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index a312da5042c41..91d572530468b 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -230,6 +230,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852C, le, 0, 27, 33, 0, NO_DEEP_PS),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 34, 0, TX_WAKE),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 36, 0, SCAN_OFFLOAD),
+	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 40, 0, CRASH_TRIGGER),
 };
 
 static void rtw89_fw_recognize_features(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index b5ee92b727c4b..1d53c944965f9 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2642,7 +2642,7 @@ struct rtw89_fw_h2c_rf_get_mccch {
 
 #define RTW89_FW_RSVD_PLE_SIZE 0x800
 
-#define RTW89_WCPU_BASE_ADDR 0xA0000000
+#define RTW89_WCPU_BASE_MASK GENMASK(27, 0)
 
 #define RTW89_FW_BACKTRACE_INFO_SIZE 8
 #define RTW89_VALID_FW_BACKTRACE_SIZE(_size) \
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index ee0ae2816860b..1b01ff0402fb6 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -539,7 +539,7 @@ static int rtw89_ser_fw_backtrace_dump(struct rtw89_dev *rtwdev, u8 *buf,
 				       const struct __fw_backtrace_entry *ent)
 {
 	struct __fw_backtrace_info *ptr = (struct __fw_backtrace_info *)buf;
-	u32 fwbt_addr = ent->wcpu_addr - RTW89_WCPU_BASE_ADDR;
+	u32 fwbt_addr = ent->wcpu_addr & RTW89_WCPU_BASE_MASK;
 	u32 fwbt_size = ent->size;
 	u32 fwbt_key = ent->key;
 	u32 i;
-- 
2.25.1

