Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D337151431C
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 09:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355087AbiD2HWT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 03:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355085AbiD2HWP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 03:22:15 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52AFBF303
        for <linux-wireless@vger.kernel.org>; Fri, 29 Apr 2022 00:18:57 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23T7IqFW2001537, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23T7IqFW2001537
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 Apr 2022 15:18:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 29 Apr 2022 15:18:52 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 29 Apr
 2022 15:18:51 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 16/16] rtw89: 8852c: add 8852ce to Makefile and Kconfig
Date:   Fri, 29 Apr 2022 15:18:09 +0800
Message-ID: <20220429071809.32104-17-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429071809.32104-1-pkshih@realtek.com>
References: <20220429071809.32104-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 04/29/2022 06:59:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMjkgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

This initial vesion is usable now. It can support STA, AP and monitor
modes, so we can add 8852ce to Kconfig and Makefile.

We are still working on some features, such as deep power save, and BT
coexistence. But, this version still can have a good WiFi-only performance
already, and will continue to fine tune power consumption.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/Kconfig  | 18 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/Makefile |  9 +++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/Kconfig b/drivers/net/wireless/realtek/rtw89/Kconfig
index dd02b6a6790e3..93e09400aac49 100644
--- a/drivers/net/wireless/realtek/rtw89/Kconfig
+++ b/drivers/net/wireless/realtek/rtw89/Kconfig
@@ -19,8 +19,11 @@ config RTW89_PCI
 config RTW89_8852A
 	tristate
 
+config RTW89_8852C
+	tristate
+
 config RTW89_8852AE
-	tristate "Realtek 8852AE PCI wireless network adapter"
+	tristate "Realtek 8852AE PCI wireless network (Wi-Fi 6) adapter"
 	depends on PCI
 	select RTW89_CORE
 	select RTW89_PCI
@@ -28,7 +31,18 @@ config RTW89_8852AE
 	help
 	  Select this option will enable support for 8852AE chipset
 
-	  802.11ax PCIe wireless network adapter
+	  802.11ax PCIe wireless network (Wi-Fi 6) adapter
+
+config RTW89_8852CE
+	tristate "Realtek 8852CE PCI wireless network (Wi-Fi 6E) adapter"
+	depends on PCI
+	select RTW89_CORE
+	select RTW89_PCI
+	select RTW89_8852C
+	help
+	  Select this option will enable support for 8852CE chipset
+
+	  802.11ax PCIe wireless network (Wi-Fi 6E) adapter
 
 config RTW89_DEBUG
 	bool
diff --git a/drivers/net/wireless/realtek/rtw89/Makefile b/drivers/net/wireless/realtek/rtw89/Makefile
index 012ae60c0b811..3006482d25c77 100644
--- a/drivers/net/wireless/realtek/rtw89/Makefile
+++ b/drivers/net/wireless/realtek/rtw89/Makefile
@@ -23,6 +23,15 @@ rtw89_8852a-objs := rtw8852a.o \
 obj-$(CONFIG_RTW89_8852AE) += rtw89_8852ae.o
 rtw89_8852ae-objs := rtw8852ae.o
 
+obj-$(CONFIG_RTW89_8852C) += rtw89_8852c.o
+rtw89_8852c-objs := rtw8852c.o \
+		    rtw8852c_table.o \
+		    rtw8852c_rfk.o \
+		    rtw8852c_rfk_table.o
+
+obj-$(CONFIG_RTW89_8852CE) += rtw89_8852ce.o
+rtw89_8852ce-objs := rtw8852ce.o
+
 rtw89_core-$(CONFIG_RTW89_DEBUG) += debug.o
 
 obj-$(CONFIG_RTW89_PCI) += rtw89_pci.o
-- 
2.25.1

