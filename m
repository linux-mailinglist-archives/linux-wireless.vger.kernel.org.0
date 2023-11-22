Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775117F3DEB
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Nov 2023 07:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbjKVGGQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Nov 2023 01:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjKVGGM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Nov 2023 01:06:12 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A641A4
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 22:06:08 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AM662c442079027, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AM662c442079027
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Nov 2023 14:06:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 22 Nov 2023 14:06:02 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 22 Nov
 2023 14:06:02 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <jamie_chen@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/4] wifi: rtw89: debug: remove wrapper of rtw89_debug()
Date:   Wed, 22 Nov 2023 14:04:58 +0800
Message-ID: <20231122060458.30878-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122060458.30878-1-pkshih@realtek.com>
References: <20231122060458.30878-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.94]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The wrapper of rtw89_debug() is unnecessary, so just remove it.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 7 +++----
 drivers/net/wireless/realtek/rtw89/debug.h | 6 ++----
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index f914c0750576..9780af8e296d 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3947,9 +3947,8 @@ void rtw89_debugfs_init(struct rtw89_dev *rtwdev)
 #endif
 
 #ifdef CONFIG_RTW89_DEBUGMSG
-void __rtw89_debug(struct rtw89_dev *rtwdev,
-		   enum rtw89_debug_mask mask,
-		   const char *fmt, ...)
+void rtw89_debug(struct rtw89_dev *rtwdev, enum rtw89_debug_mask mask,
+		 const char *fmt, ...)
 {
 	struct va_format vaf = {
 	.fmt = fmt,
@@ -3965,5 +3964,5 @@ void __rtw89_debug(struct rtw89_dev *rtwdev,
 
 	va_end(args);
 }
-EXPORT_SYMBOL(__rtw89_debug);
+EXPORT_SYMBOL(rtw89_debug);
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/debug.h b/drivers/net/wireless/realtek/rtw89/debug.h
index a4cdc3c8c622..800ea59873a1 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.h
+++ b/drivers/net/wireless/realtek/rtw89/debug.h
@@ -59,12 +59,10 @@ static inline void rtw89_debugfs_init(struct rtw89_dev *rtwdev) {}
 
 #ifdef CONFIG_RTW89_DEBUGMSG
 extern unsigned int rtw89_debug_mask;
-#define rtw89_debug(rtwdev, a...) __rtw89_debug(rtwdev, ##a)
 
 __printf(3, 4)
-void __rtw89_debug(struct rtw89_dev *rtwdev,
-		   enum rtw89_debug_mask mask,
-		   const char *fmt, ...);
+void rtw89_debug(struct rtw89_dev *rtwdev, enum rtw89_debug_mask mask,
+		 const char *fmt, ...);
 static inline void rtw89_hex_dump(struct rtw89_dev *rtwdev,
 				  enum rtw89_debug_mask mask,
 				  const char *prefix_str,
-- 
2.25.1

