Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAE71AD7CB
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 09:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgDQHrT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 03:47:19 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37073 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729322AbgDQHrS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 03:47:18 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03H7l8hJ5020159, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03H7l8hJ5020159
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
Subject: [PATCH 37/40] rtw88: extract: make 8822b an individual kernel module
Date:   Fri, 17 Apr 2020 15:46:50 +0800
Message-ID: <20200417074653.15591-38-yhchuang@realtek.com>
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

Make objects about 8822b functions and 8822b tables,
i.e. rtw8822b.o and rtw8822b_table.o, an individual
kernel module called rtw88_8822b.ko.

For 8822b pcie chip, i.e. 8822BE chip, add a chip
entry point module called rtw88_8822be.ko which
will depend on rtw88_8822b.ko and rtwpci.ko.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/Kconfig    |  6 +++-
 drivers/net/wireless/realtek/rtw88/Makefile   |  7 ++++-
 drivers/net/wireless/realtek/rtw88/main.h     |  1 -
 drivers/net/wireless/realtek/rtw88/pci.c      |  3 --
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  5 ++++
 .../net/wireless/realtek/rtw88/rtw8822be.c    | 30 +++++++++++++++++++
 .../net/wireless/realtek/rtw88/rtw8822be.h    | 20 +++++++++++++
 7 files changed, 66 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8822be.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8822be.h

diff --git a/drivers/net/wireless/realtek/rtw88/Kconfig b/drivers/net/wireless/realtek/rtw88/Kconfig
index f4dbb5914bde..dd71407a06c3 100644
--- a/drivers/net/wireless/realtek/rtw88/Kconfig
+++ b/drivers/net/wireless/realtek/rtw88/Kconfig
@@ -16,14 +16,18 @@ config RTW88_CORE
 config RTW88_PCI
 	tristate
 
+config RTW88_8822B
+	tristate
+
 config RTW88_8822C
 	tristate
 
 config RTW88_8822BE
-	bool "Realtek 8822BE PCI wireless network adapter"
+	tristate "Realtek 8822BE PCI wireless network adapter"
 	depends on PCI
 	select RTW88_CORE
 	select RTW88_PCI
+	select RTW88_8822B
 	help
 	  Select this option will enable support for 8822BE chipset
 
diff --git a/drivers/net/wireless/realtek/rtw88/Makefile b/drivers/net/wireless/realtek/rtw88/Makefile
index e45efd2deaa3..0b29f07e3661 100644
--- a/drivers/net/wireless/realtek/rtw88/Makefile
+++ b/drivers/net/wireless/realtek/rtw88/Makefile
@@ -18,9 +18,14 @@ rtw88-y += main.o \
 	   wow.o \
 	   regd.o
 
-rtw88-$(CONFIG_RTW88_8822BE)	+= rtw8822b.o rtw8822b_table.o
 rtw88-$(CONFIG_RTW88_8723DE)	+= rtw8723d.o rtw8723d_table.o
 
+obj-$(CONFIG_RTW88_8822B)	+= rtw88_8822b.o
+rtw88_8822b-objs		:= rtw8822b.o rtw8822b_table.o
+
+obj-$(CONFIG_RTW88_8822BE)	+= rtw88_8822be.o
+rtw88_8822be-objs		:= rtw8822be.o
+
 obj-$(CONFIG_RTW88_8822C)	+= rtw88_8822c.o
 rtw88_8822c-objs		:= rtw8822c.o rtw8822c_table.o
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index d5514a33b109..a0c34c1154b6 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -39,7 +39,6 @@ extern bool rtw_bf_support;
 extern unsigned int rtw_fw_lps_deep_mode;
 extern unsigned int rtw_debug_mask;
 extern const struct ieee80211_ops rtw_ops;
-extern struct rtw_chip_info rtw8822b_hw_spec;
 extern struct rtw_chip_info rtw8723d_hw_spec;
 
 #define RTW_MAX_CHANNEL_NUM_2G 14
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 90a6624065c1..25672d0a09aa 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1598,9 +1598,6 @@ void rtw_pci_shutdown(struct pci_dev *pdev)
 EXPORT_SYMBOL(rtw_pci_shutdown);
 
 static const struct pci_device_id rtw_pci_id_table[] = {
-#ifdef CONFIG_RTW88_8822BE
-	{ RTK_PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0xB822, rtw8822b_hw_spec) },
-#endif
 #ifdef CONFIG_RTW88_8723DE
 	{ RTK_PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0xD723, rtw8723d_hw_spec) },
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index c76cd0893d12..63c209062910 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2018-2019  Realtek Corporation
  */
 
+#include <linux/module.h>
 #include "main.h"
 #include "coex.h"
 #include "fw.h"
@@ -2505,3 +2506,7 @@ struct rtw_chip_info rtw8822b_hw_spec = {
 EXPORT_SYMBOL(rtw8822b_hw_spec);
 
 MODULE_FIRMWARE("rtw88/rtw8822b_fw.bin");
+
+MODULE_AUTHOR("Realtek Corporation");
+MODULE_DESCRIPTION("Realtek 802.11ac wireless 8822b driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822be.c b/drivers/net/wireless/realtek/rtw88/rtw8822be.c
new file mode 100644
index 000000000000..4cebfbab886d
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822be.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2018-2019  Realtek Corporation
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include "rtw8822be.h"
+
+static const struct pci_device_id rtw_8822be_id_table[] = {
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0xB822),
+		.driver_data = (kernel_ulong_t)&rtw8822b_hw_spec
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(pci, rtw_8822be_id_table);
+
+static struct pci_driver rtw_8822be_driver = {
+	.name = "rtw_8822be",
+	.id_table = rtw_8822be_id_table,
+	.probe = rtw_pci_probe,
+	.remove = rtw_pci_remove,
+	.driver.pm = RTW_PM_OPS,
+	.shutdown = rtw_pci_shutdown,
+};
+module_pci_driver(rtw_8822be_driver);
+
+MODULE_AUTHOR("Realtek Corporation");
+MODULE_DESCRIPTION("Realtek 802.11ac wireless 8822be driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822be.h b/drivers/net/wireless/realtek/rtw88/rtw8822be.h
new file mode 100644
index 000000000000..1ae4a6cbfcd8
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822be.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2018-2019  Realtek Corporation
+ */
+
+#ifndef __RTW_8822BE_H_
+#define __RTW_8822BE_H_
+
+#ifdef CONFIG_PM
+extern const struct dev_pm_ops rtw_pci_pm;
+#define RTW_PM_OPS (&rtw_pci_pm)
+#else
+#define RTW_PM_OPS NULL
+#endif
+
+extern struct rtw_chip_info rtw8822b_hw_spec;
+int rtw_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id);
+void rtw_pci_remove(struct pci_dev *pdev);
+void rtw_pci_shutdown(struct pci_dev *pdev);
+
+#endif
-- 
2.17.1

