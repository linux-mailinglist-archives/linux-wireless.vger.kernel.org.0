Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5C55183B5
	for <lists+linux-wireless@lfdr.de>; Tue,  3 May 2022 14:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbiECMEV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 May 2022 08:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbiECMED (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 May 2022 08:04:03 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B01D2A263
        for <linux-wireless@vger.kernel.org>; Tue,  3 May 2022 05:00:29 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 243C0NRl8005105, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 243C0NRl8005105
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 3 May 2022 20:00:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 3 May 2022 20:00:23 +0800
Received: from localhost (172.16.17.21) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 3 May
 2022 20:00:23 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 8/8] rtw89: 8852c: add 8852ce to Makefile and Kconfig
Date:   Tue, 3 May 2022 20:00:01 +0800
Message-ID: <20220503120001.79272-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220503120001.79272-1-pkshih@realtek.com>
References: <20220503120001.79272-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 05/03/2022 11:37:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzUvMyCkV6TIIDEwOjAxOjAw?=
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

