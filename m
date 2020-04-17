Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7251E1AD7D3
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 09:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbgDQHrY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 03:47:24 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37074 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729313AbgDQHrV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 03:47:21 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03H7l9hE5020159, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03H7l9hE5020159
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Apr 2020 15:47:09 +0800
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
Subject: [PATCH 38/40] rtw88: extract: make 8723d an individual kernel module
Date:   Fri, 17 Apr 2020 15:46:51 +0800
Message-ID: <20200417074653.15591-39-yhchuang@realtek.com>
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

Make objects about 8723d functions and 8723d tables,
i.e. rtw8723d.o and rtw8723d_table.o, an individual
kernel module called rtw88_8723d.ko.

For 8723d pcie chip, i.e. 8723DE chip, add a chip
entry point module called rtw88_8723de.ko which
will depend on rtw88_8723d.ko and rtwpci.ko.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/Kconfig    |  6 +++-
 drivers/net/wireless/realtek/rtw88/Makefile   |  7 ++++-
 drivers/net/wireless/realtek/rtw88/main.h     |  1 -
 drivers/net/wireless/realtek/rtw88/pci.c      |  3 --
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  5 ++++
 .../net/wireless/realtek/rtw88/rtw8723de.c    | 30 +++++++++++++++++++
 .../net/wireless/realtek/rtw88/rtw8723de.h    | 20 +++++++++++++
 7 files changed, 66 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723de.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723de.h

diff --git a/drivers/net/wireless/realtek/rtw88/Kconfig b/drivers/net/wireless/realtek/rtw88/Kconfig
index dd71407a06c3..ca894c4f96ac 100644
--- a/drivers/net/wireless/realtek/rtw88/Kconfig
+++ b/drivers/net/wireless/realtek/rtw88/Kconfig
@@ -22,6 +22,9 @@ config RTW88_8822B
 config RTW88_8822C
 	tristate
 
+config RTW88_8723D
+	tristate
+
 config RTW88_8822BE
 	tristate "Realtek 8822BE PCI wireless network adapter"
 	depends on PCI
@@ -45,10 +48,11 @@ config RTW88_8822CE
 	  802.11ac PCIe wireless network adapter
 
 config RTW88_8723DE
-	bool "Realtek 8723DE PCI wireless network adapter"
+	tristate "Realtek 8723DE PCI wireless network adapter"
 	depends on PCI
 	select RTW88_CORE
 	select RTW88_PCI
+	select RTW88_8723D
 	help
 	  Select this option will enable support for 8723DE chipset
 
diff --git a/drivers/net/wireless/realtek/rtw88/Makefile b/drivers/net/wireless/realtek/rtw88/Makefile
index 0b29f07e3661..9e3e95360089 100644
--- a/drivers/net/wireless/realtek/rtw88/Makefile
+++ b/drivers/net/wireless/realtek/rtw88/Makefile
@@ -18,7 +18,6 @@ rtw88-y += main.o \
 	   wow.o \
 	   regd.o
 
-rtw88-$(CONFIG_RTW88_8723DE)	+= rtw8723d.o rtw8723d_table.o
 
 obj-$(CONFIG_RTW88_8822B)	+= rtw88_8822b.o
 rtw88_8822b-objs		:= rtw8822b.o rtw8822b_table.o
@@ -32,5 +31,11 @@ rtw88_8822c-objs		:= rtw8822c.o rtw8822c_table.o
 obj-$(CONFIG_RTW88_8822CE)	+= rtw88_8822ce.o
 rtw88_8822ce-objs		:= rtw8822ce.o
 
+obj-$(CONFIG_RTW88_8723D)	+= rtw88_8723d.o
+rtw88_8723d-objs		:= rtw8723d.o rtw8723d_table.o
+
+obj-$(CONFIG_RTW88_8723DE)	+= rtw88_8723de.o
+rtw88_8723de-objs		:= rtw8723de.o
+
 obj-$(CONFIG_RTW88_PCI)		+= rtwpci.o
 rtwpci-objs			:= pci.o
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index a0c34c1154b6..7c785a63fadf 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -39,7 +39,6 @@ extern bool rtw_bf_support;
 extern unsigned int rtw_fw_lps_deep_mode;
 extern unsigned int rtw_debug_mask;
 extern const struct ieee80211_ops rtw_ops;
-extern struct rtw_chip_info rtw8723d_hw_spec;
 
 #define RTW_MAX_CHANNEL_NUM_2G 14
 #define RTW_MAX_CHANNEL_NUM_5G 49
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 25672d0a09aa..46aaac94287b 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1598,9 +1598,6 @@ void rtw_pci_shutdown(struct pci_dev *pdev)
 EXPORT_SYMBOL(rtw_pci_shutdown);
 
 static const struct pci_device_id rtw_pci_id_table[] = {
-#ifdef CONFIG_RTW88_8723DE
-	{ RTK_PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0xD723, rtw8723d_hw_spec) },
-#endif
 	{},
 };
 MODULE_DEVICE_TABLE(pci, rtw_pci_id_table);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 5a662112752d..5c592560c3e0 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2018-2019  Realtek Corporation
  */
 
+#include <linux/module.h>
 #include "main.h"
 #include "coex.h"
 #include "fw.h"
@@ -2758,3 +2759,7 @@ struct rtw_chip_info rtw8723d_hw_spec = {
 EXPORT_SYMBOL(rtw8723d_hw_spec);
 
 MODULE_FIRMWARE("rtw88/rtw8723d_fw.bin");
+
+MODULE_AUTHOR("Realtek Corporation");
+MODULE_DESCRIPTION("Realtek 802.11n wireless 8723d driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723de.c b/drivers/net/wireless/realtek/rtw88/rtw8723de.c
new file mode 100644
index 000000000000..105866eb0a55
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723de.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2018-2019  Realtek Corporation
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include "rtw8723de.h"
+
+static const struct pci_device_id rtw_8723de_id_table[] = {
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0xD723),
+		.driver_data = (kernel_ulong_t)&rtw8723d_hw_spec
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(pci, rtw_8723de_id_table);
+
+static struct pci_driver rtw_8723de_driver = {
+	.name = "rtw_8723de",
+	.id_table = rtw_8723de_id_table,
+	.probe = rtw_pci_probe,
+	.remove = rtw_pci_remove,
+	.driver.pm = RTW_PM_OPS,
+	.shutdown = rtw_pci_shutdown,
+};
+module_pci_driver(rtw_8723de_driver);
+
+MODULE_AUTHOR("Realtek Corporation");
+MODULE_DESCRIPTION("Realtek 802.11n wireless 8723de driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723de.h b/drivers/net/wireless/realtek/rtw88/rtw8723de.h
new file mode 100644
index 000000000000..fbf5b9bcd314
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723de.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2018-2019  Realtek Corporation
+ */
+
+#ifndef __RTW_8723DE_H_
+#define __RTW_8723DE_H_
+
+#ifdef CONFIG_PM
+extern const struct dev_pm_ops rtw_pci_pm;
+#define RTW_PM_OPS (&rtw_pci_pm)
+#else
+#define RTW_PM_OPS NULL
+#endif
+
+extern struct rtw_chip_info rtw8723d_hw_spec;
+int rtw_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id);
+void rtw_pci_remove(struct pci_dev *pdev);
+void rtw_pci_shutdown(struct pci_dev *pdev);
+
+#endif
-- 
2.17.1

