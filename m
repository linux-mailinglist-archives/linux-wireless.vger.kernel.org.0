Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1621CF274
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2020 12:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbgELKbo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 May 2020 06:31:44 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:36684 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbgELKbj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 May 2020 06:31:39 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04CAVNFp8009941, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04CAVNFp8009941
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 May 2020 18:31:23 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 12 May 2020 18:31:22 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 12 May 2020 18:31:22 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <bigeasy@linutronix.de>, <kevin_yang@realtek.com>,
        <briannorris@chromium.org>
Subject: [PATCH v3 3/7] rtw88: extract: make 8822c an individual kernel module
Date:   Tue, 12 May 2020 18:31:16 +0800
Message-ID: <20200512103120.5280-4-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512103120.5280-1-yhchuang@realtek.com>
References: <20200512103120.5280-1-yhchuang@realtek.com>
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
 .../net/wireless/realtek/rtw88/rtw8822ce.h    | 14 +++++++++
 7 files changed, 60 insertions(+), 6 deletions(-)
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
index c9156b9b532c..d6e25d4c5aed 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -41,7 +41,6 @@ extern unsigned int rtw_fw_lps_deep_mode;
 extern unsigned int rtw_debug_mask;
 extern const struct ieee80211_ops rtw_ops;
 extern struct rtw_chip_info rtw8822b_hw_spec;
-extern struct rtw_chip_info rtw8822c_hw_spec;
 extern struct rtw_chip_info rtw8723d_hw_spec;
 
 #define RTW_MAX_CHANNEL_NUM_2G 14
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index fb5d28152775..af9cd23a3273 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1597,9 +1597,6 @@ static const struct pci_device_id rtw_pci_id_table[] = {
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
index d697d70170af..5e4cc57dbd7c 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2018-2019  Realtek Corporation
  */
 
+#include <linux/module.h>
 #include "main.h"
 #include "coex.h"
 #include "fw.h"
@@ -4377,3 +4378,7 @@ EXPORT_SYMBOL(rtw8822c_hw_spec);
 
 MODULE_FIRMWARE("rtw88/rtw8822c_fw.bin");
 MODULE_FIRMWARE("rtw88/rtw8822c_wow_fw.bin");
+
+MODULE_AUTHOR("Realtek Corporation");
+MODULE_DESCRIPTION("Realtek 802.11ac wireless 8822c driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822ce.c b/drivers/net/wireless/realtek/rtw88/rtw8822ce.c
new file mode 100644
index 000000000000..7b6bd990651e
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
+	.driver.pm = &rtw_pm_ops,
+	.shutdown = rtw_pci_shutdown,
+};
+module_pci_driver(rtw_8822ce_driver);
+
+MODULE_AUTHOR("Realtek Corporation");
+MODULE_DESCRIPTION("Realtek 802.11ac wireless 8822ce driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822ce.h b/drivers/net/wireless/realtek/rtw88/rtw8822ce.h
new file mode 100644
index 000000000000..c2c0e8675d74
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822ce.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2018-2019  Realtek Corporation
+ */
+
+#ifndef __RTW_8822CE_H_
+#define __RTW_8822CE_H_
+
+extern const struct dev_pm_ops rtw_pm_ops;
+extern struct rtw_chip_info rtw8822c_hw_spec;
+int rtw_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id);
+void rtw_pci_remove(struct pci_dev *pdev);
+void rtw_pci_shutdown(struct pci_dev *pdev);
+
+#endif
-- 
2.17.1

