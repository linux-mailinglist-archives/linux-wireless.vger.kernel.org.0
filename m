Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99961D4523
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2020 07:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgEOFXk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 May 2020 01:23:40 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:55375 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgEOFXj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 May 2020 01:23:39 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04F5NURI0016800, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04F5NURI0016800
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 May 2020 13:23:30 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 15 May 2020 13:23:30 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 15 May 2020 13:23:30 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <kevin_yang@realtek.com>, <briannorris@chromium.org>,
        <bigeasy@linutronix.de>
Subject: [PATCH v4 4/7] rtw88: extract: make 8822b an individual kernel module
Date:   Fri, 15 May 2020 13:23:24 +0800
Message-ID: <20200515052327.31874-5-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200515052327.31874-1-yhchuang@realtek.com>
References: <20200515052327.31874-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
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
 .../net/wireless/realtek/rtw88/rtw8822be.h    | 14 +++++++++
 7 files changed, 60 insertions(+), 6 deletions(-)
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
index d6e25d4c5aed..a4c4ce511e6a 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -40,7 +40,6 @@ extern bool rtw_bf_support;
 extern unsigned int rtw_fw_lps_deep_mode;
 extern unsigned int rtw_debug_mask;
 extern const struct ieee80211_ops rtw_ops;
-extern struct rtw_chip_info rtw8822b_hw_spec;
 extern struct rtw_chip_info rtw8723d_hw_spec;
 
 #define RTW_MAX_CHANNEL_NUM_2G 14
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index af9cd23a3273..39dee8368718 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1594,9 +1594,6 @@ void rtw_pci_shutdown(struct pci_dev *pdev)
 EXPORT_SYMBOL(rtw_pci_shutdown);
 
 static const struct pci_device_id rtw_pci_id_table[] = {
-#ifdef CONFIG_RTW88_8822BE
-	{ RTK_PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0xB822, rtw8822b_hw_spec) },
-#endif
 #ifdef CONFIG_RTW88_8723DE
 	{ RTK_PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0xD723, rtw8723d_hw_spec) },
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 18c5a5a96d90..e49bdd76ab9a 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2018-2019  Realtek Corporation
  */
 
+#include <linux/module.h>
 #include "main.h"
 #include "coex.h"
 #include "fw.h"
@@ -2506,3 +2507,7 @@ struct rtw_chip_info rtw8822b_hw_spec = {
 EXPORT_SYMBOL(rtw8822b_hw_spec);
 
 MODULE_FIRMWARE("rtw88/rtw8822b_fw.bin");
+
+MODULE_AUTHOR("Realtek Corporation");
+MODULE_DESCRIPTION("Realtek 802.11ac wireless 8822b driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822be.c b/drivers/net/wireless/realtek/rtw88/rtw8822be.c
new file mode 100644
index 000000000000..921916ae15ca
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
+	.driver.pm = &rtw_pm_ops,
+	.shutdown = rtw_pci_shutdown,
+};
+module_pci_driver(rtw_8822be_driver);
+
+MODULE_AUTHOR("Realtek Corporation");
+MODULE_DESCRIPTION("Realtek 802.11ac wireless 8822be driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822be.h b/drivers/net/wireless/realtek/rtw88/rtw8822be.h
new file mode 100644
index 000000000000..d823ca059f5c
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822be.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2018-2019  Realtek Corporation
+ */
+
+#ifndef __RTW_8822BE_H_
+#define __RTW_8822BE_H_
+
+extern const struct dev_pm_ops rtw_pm_ops;
+extern struct rtw_chip_info rtw8822b_hw_spec;
+int rtw_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id);
+void rtw_pci_remove(struct pci_dev *pdev);
+void rtw_pci_shutdown(struct pci_dev *pdev);
+
+#endif
-- 
2.17.1

