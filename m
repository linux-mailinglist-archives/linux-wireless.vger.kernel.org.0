Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749441AD7D7
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 09:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbgDQHr2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 03:47:28 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37066 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgDQHrP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 03:47:15 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03H7l8hI5020159, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03H7l8hI5020159
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Apr 2020 15:47:08 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Apr 2020 15:47:05 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Apr 2020 15:47:05 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>,
        <briannorris@chromium.org>, <kevin_yang@realtek.com>
Subject: [PATCH 36/40] rtw88: extract: make 8822c an individual kernel module
Date:   Fri, 17 Apr 2020 15:46:49 +0800
Message-ID: <20200417074653.15591-37-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417074653.15591-1-yhchuang@realtek.com>
References: <20200417074653.15591-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Make objects about 8822c functions and 8822c tables,
i.e. rtw8822c.o and rtw8822c_table.o, an individual
kernel module called rtw88_8822c.ko.

For 8822c pcie chip, i.e. 8822CE chip, add a chip
entry point module called rtw88_8822ce.ko which
will depend on rtw88_8822c.ko and rtwpci.ko.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/Kconfig    |  6 +++-
 drivers/net/wireless/realtek/rtw88/Makefile   |  7 ++++-
 drivers/net/wireless/realtek/rtw88/main.h     |  1 -
 drivers/net/wireless/realtek/rtw88/pci.c      |  3 --
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  5 ++++
 .../net/wireless/realtek/rtw88/rtw8822ce.c    | 30 +++++++++++++++++++
 .../net/wireless/realtek/rtw88/rtw8822ce.h    | 20 +++++++++++++
 7 files changed, 66 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8822ce.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8822ce.h

diff --git a/drivers/net/wireless/realtek/rtw88/Kconfig b/drivers/net/wireless/realtek/rtw88/Kconfig
index 7a5fa68945c4..f4dbb5914bde 100644
--- a/drivers/net/wireless/realtek/rtw88/Kconfig
+++ b/drivers/net/wireless/realtek/rtw88/Kconfig
@@ -16,6 +16,9 @@ config RTW88_CORE
 config RTW88_PCI
 	tristate
 
+config RTW88_8822C
+	tristate
+
 config RTW88_8822BE
 	bool "Realtek 8822BE PCI wireless network adapter"
 	depends on PCI
@@ -27,10 +30,11 @@ config RTW88_8822BE
 	  802.11ac PCIe wireless network adapter
 
 config RTW88_8822CE
-	bool "Realtek 8822CE PCI wireless network adapter"
+	tristate "Realtek 8822CE PCI wireless network adapter"
 	depends on PCI
 	select RTW88_CORE
 	select RTW88_PCI
+	select RTW88_8822C
 	help
 	  Select this option will enable support for 8822CE chipset
 
diff --git a/drivers/net/wireless/realtek/rtw88/Makefile b/drivers/net/wireless/realtek/rtw88/Makefile
index 385facc0dd20..e45efd2deaa3 100644
--- a/drivers/net/wireless/realtek/rtw88/Makefile
+++ b/drivers/net/wireless/realtek/rtw88/Makefile
@@ -19,8 +19,13 @@ rtw88-y += main.o \
 	   regd.o
 
 rtw88-$(CONFIG_RTW88_8822BE)	+= rtw8822b.o rtw8822b_table.o
-rtw88-$(CONFIG_RTW88_8822CE)	+= rtw8822c.o rtw8822c_table.o
 rtw88-$(CONFIG_RTW88_8723DE)	+= rtw8723d.o rtw8723d_table.o
 
+obj-$(CONFIG_RTW88_8822C)	+= rtw88_8822c.o
+rtw88_8822c-objs		:= rtw8822c.o rtw8822c_table.o
+
+obj-$(CONFIG_RTW88_8822CE)	+= rtw88_8822ce.o
+rtw88_8822ce-objs		:= rtw8822ce.o
+
 obj-$(CONFIG_RTW88_PCI)		+= rtwpci.o
 rtwpci-objs			:= pci.o
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 35e2fb19ad56..d5514a33b109 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -40,7 +40,6 @@ extern unsigned int rtw_fw_lps_deep_mode;
 extern unsigned int rtw_debug_mask;
 extern const struct ieee80211_ops rtw_ops;
 extern struct rtw_chip_info rtw8822b_hw_spec;
-extern struct rtw_chip_info rtw8822c_hw_spec;
 extern struct rtw_chip_info rtw8723d_hw_spec;
 
 #define RTW_MAX_CHANNEL_NUM_2G 14
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 66feaab0261e..90a6624065c1 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1601,9 +1601,6 @@ static const struct pci_device_id rtw_pci_id_table[] = {
 #ifdef CONFIG_RTW88_8822BE
 	{ RTK_PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0xB822, rtw8822b_hw_spec) },
 #endif
-#ifdef CONFIG_RTW88_8822CE
-	{ RTK_PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0xC822, rtw8822c_hw_spec) },
-#endif
 #ifdef CONFIG_RTW88_8723DE
 	{ RTK_PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0xD723, rtw8723d_hw_spec) },
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index d2e74ac21d07..5e9a77d94ca1 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2018-2019  Realtek Corporation
  */
 
+#include <linux/module.h>
 #include "main.h"
 #include "coex.h"
 #include "fw.h"
@@ -4262,3 +4263,7 @@ EXPORT_SYMBOL(rtw8822c_hw_spec);
 
 MODULE_FIRMWARE("rtw88/rtw8822c_fw.bin");
 MODULE_FIRMWARE("rtw88/rtw8822c_wow_fw.bin");
+
+MODULE_AUTHOR("Realtek Corporation");
+MODULE_DESCRIPTION("Realtek 802.11ac wireless 8822c driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822ce.c b/drivers/net/wireless/realtek/rtw88/rtw8822ce.c
new file mode 100644
index 000000000000..c7d75edcaa2e
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822ce.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2018-2019  Realtek Corporation
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include "rtw8822ce.h"
+
+static const struct pci_device_id rtw_8822ce_id_table[] = {
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0xC822),
+		.driver_data = (kernel_ulong_t)&rtw8822c_hw_spec
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(pci, rtw_8822ce_id_table);
+
+static struct pci_driver rtw_8822ce_driver = {
+	.name = "rtw_8822ce",
+	.id_table = rtw_8822ce_id_table,
+	.probe = rtw_pci_probe,
+	.remove = rtw_pci_remove,
+	.driver.pm = RTW_PM_OPS,
+	.shutdown = rtw_pci_shutdown,
+};
+module_pci_driver(rtw_8822ce_driver);
+
+MODULE_AUTHOR("Realtek Corporation");
+MODULE_DESCRIPTION("Realtek 802.11ac wireless 8822ce driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822ce.h b/drivers/net/wireless/realtek/rtw88/rtw8822ce.h
new file mode 100644
index 000000000000..ed2eff4d5fd0
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822ce.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2018-2019  Realtek Corporation
+ */
+
+#ifndef __RTW_8822CE_H_
+#define __RTW_8822CE_H_
+
+#ifdef CONFIG_PM
+extern const struct dev_pm_ops rtw_pci_pm;
+#define RTW_PM_OPS (&rtw_pci_pm)
+#else
+#define RTW_PM_OPS NULL
+#endif
+
+extern struct rtw_chip_info rtw8822c_hw_spec;
+int rtw_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id);
+void rtw_pci_remove(struct pci_dev *pdev);
+void rtw_pci_shutdown(struct pci_dev *pdev);
+
+#endif
-- 
2.17.1

