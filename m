Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38122E9285
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jan 2021 10:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbhADJWY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jan 2021 04:22:24 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:52385 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbhADJWW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jan 2021 04:22:22 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1049LcwpE024481, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 1049LcwpE024481
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 4 Jan 2021 17:21:39 +0800
Received: from localhost (172.21.69.213) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 4 Jan 2021
 17:21:38 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH V2 18/18] rtw89: add Kconfig and Makefile
Date:   Mon, 4 Jan 2021 17:20:36 +0800
Message-ID: <20210104092036.16089-16-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210104092036.16089-1-pkshih@realtek.com>
References: <20210104092036.16089-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMBS01.realtek.com.tw (172.21.6.94) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With Kconfig and Makefile, we can build rtw89 and support 8852AE chip.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/Kconfig        |  1 +
 drivers/net/wireless/realtek/Makefile       |  1 +
 drivers/net/wireless/realtek/rtw89/Kconfig  | 50 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/Makefile | 23 ++++++++++
 4 files changed, 75 insertions(+)
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
index 000000000000..6752f0c64727
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/Makefile
@@ -0,0 +1,23 @@
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
+		coex.o \
+		ser.o
+
+rtw89_core-$(CONFIG_RTW89_DEBUG) += debug.o
+
+obj-$(CONFIG_RTW89_PCI) += rtw89_pci.o
+rtw89_pci-y := pci.o
+
-- 
2.21.0

