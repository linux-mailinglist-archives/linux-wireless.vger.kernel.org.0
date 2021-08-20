Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DE93F260F
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Aug 2021 06:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbhHTEis (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 00:38:48 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:39312 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbhHTEis (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 00:38:48 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 17K4c7Eh9004321, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 17K4c7Eh9004321
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 20 Aug 2021 12:38:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 20 Aug 2021 12:38:06 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 20 Aug
 2021 12:38:06 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v6 24/24] rtw89: add Kconfig and Makefile
Date:   Fri, 20 Aug 2021 12:35:38 +0800
Message-ID: <20210820043538.12424-25-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210820043538.12424-1-pkshih@realtek.com>
References: <20210820043538.12424-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/20/2021 04:22:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzgvMjAgpFekyCAwMzowODowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 08/20/2021 04:18:54
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 165674 [Aug 20 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 454 454 39c6e442fd417993330528e7f9d13ac1bf7fdf8c
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/20/2021 04:22:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With Kconfig and Makefile, we can build rtw89 and support 8852AE chip.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/Kconfig        |  1 +
 drivers/net/wireless/realtek/Makefile       |  1 +
 drivers/net/wireless/realtek/rtw89/Kconfig  | 50 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/Makefile | 25 +++++++++++
 4 files changed, 77 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/Kconfig
 create mode 100644 drivers/net/wireless/realtek/rtw89/Makefile

diff --git a/drivers/net/wireless/realtek/Kconfig b/drivers/net/wireless/realtek/Kconfig
index 474843277fa1..4a1f0e64df03 100644
--- a/drivers/net/wireless/realtek/Kconfig
+++ b/drivers/net/wireless/realtek/Kconfig
@@ -16,5 +16,6 @@ source "drivers/net/wireless/realtek/rtl818x/Kconfig"
 source "drivers/net/wireless/realtek/rtlwifi/Kconfig"
 source "drivers/net/wireless/realtek/rtl8xxxu/Kconfig"
 source "drivers/net/wireless/realtek/rtw88/Kconfig"
+source "drivers/net/wireless/realtek/rtw89/Kconfig"
 
 endif # WLAN_VENDOR_REALTEK
diff --git a/drivers/net/wireless/realtek/Makefile b/drivers/net/wireless/realtek/Makefile
index 888b5d594e79..ab25419f56c6 100644
--- a/drivers/net/wireless/realtek/Makefile
+++ b/drivers/net/wireless/realtek/Makefile
@@ -8,4 +8,5 @@ obj-$(CONFIG_RTL8187)		+= rtl818x/
 obj-$(CONFIG_RTLWIFI)		+= rtlwifi/
 obj-$(CONFIG_RTL8XXXU)		+= rtl8xxxu/
 obj-$(CONFIG_RTW88)		+= rtw88/
+obj-$(CONFIG_RTW89)		+= rtw89/
 
diff --git a/drivers/net/wireless/realtek/rtw89/Kconfig b/drivers/net/wireless/realtek/rtw89/Kconfig
new file mode 100644
index 000000000000..055d45103a4b
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/Kconfig
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menuconfig RTW89
+	tristate "Realtek 802.11ax wireless chips support"
+	depends on MAC80211
+	help
+	  This module adds support for mac80211-based wireless drivers that
+	  enables Realtek IEEE 802.11ax wireless chipsets.
+
+	  If you choose to build a module, it'll be called rtw89.
+
+if RTW89
+
+config RTW89_CORE
+	tristate
+
+config RTW89_PCI
+	tristate
+
+config RTW89_8852AE
+	tristate "Realtek 8852AE PCI wireless network adapter"
+	depends on PCI
+	select RTW89_CORE
+	select RTW89_PCI
+	help
+	  Select this option will enable support for 8852AE chipset
+
+	  802.11ax PCIe wireless network adapter
+
+config RTW89_DEBUG
+	bool
+
+config RTW89_DEBUGMSG
+	bool "Realtek rtw89 debug message support"
+	depends on RTW89_CORE
+	select RTW89_DEBUG
+	help
+	  Enable debug message support
+
+	  If unsure, say Y to simplify debug problems
+
+config RTW89_DEBUGFS
+	bool "Realtek rtw89 debugfs support"
+	depends on RTW89_CORE
+	select RTW89_DEBUG
+	help
+	  Enable debugfs support
+
+	  If unsure, say Y to simplify debug problems
+
+endif
diff --git a/drivers/net/wireless/realtek/rtw89/Makefile b/drivers/net/wireless/realtek/rtw89/Makefile
new file mode 100644
index 000000000000..077e8fe23f60
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/Makefile
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+
+obj-$(CONFIG_RTW89_CORE) += rtw89_core.o
+rtw89_core-y += core.o \
+		mac80211.o \
+		mac.o \
+		phy.o \
+		fw.o \
+		rtw8852a.o \
+		rtw8852a_table.o \
+		rtw8852a_rfk.o \
+		rtw8852a_rfk_table.o \
+		cam.o \
+		efuse.o \
+		regd.o \
+		sar.o \
+		coex.o \
+		ps.o \
+		ser.o
+
+rtw89_core-$(CONFIG_RTW89_DEBUG) += debug.o
+
+obj-$(CONFIG_RTW89_PCI) += rtw89_pci.o
+rtw89_pci-y := pci.o
+
-- 
2.25.1

