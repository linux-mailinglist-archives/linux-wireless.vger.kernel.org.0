Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C4E4CF18B
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Mar 2022 07:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbiCGGGv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Mar 2022 01:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbiCGGGv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Mar 2022 01:06:51 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB575F24E
        for <linux-wireless@vger.kernel.org>; Sun,  6 Mar 2022 22:05:56 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22765lpmE022528, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22765lpmE022528
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 7 Mar 2022 14:05:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 14:05:47 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 7 Mar
 2022 14:05:46 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 01/13] rtw89: 8852c: add 8852c empty files
Date:   Mon, 7 Mar 2022 14:04:45 +0800
Message-ID: <20220307060457.56789-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307060457.56789-1-pkshih@realtek.com>
References: <20220307060457.56789-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/07/2022 05:48:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvNyCkV6TIIDAzOjQ5OjAw?=
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

Add these files, and then I can add specific chip::ops or chip::info along
with the existing chip.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 20 +++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.h | 12 +++++++
 .../net/wireless/realtek/rtw89/rtw8852ce.c    | 36 +++++++++++++++++++
 3 files changed, 68 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852c.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852c.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852ce.c

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
new file mode 100644
index 0000000000000..cd0004b01ebc2
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2019-2022  Realtek Corporation
+ */
+
+#include "rtw8852c.h"
+
+static const struct rtw89_chip_ops rtw8852c_chip_ops = {
+};
+
+const struct rtw89_chip_info rtw8852c_chip_info = {
+	.chip_id		= RTL8852C,
+	.ops			= &rtw8852c_chip_ops,
+	.fw_name		= "rtw89/rtw8852c_fw.bin",
+};
+EXPORT_SYMBOL(rtw8852c_chip_info);
+
+MODULE_FIRMWARE("rtw89/rtw8852c_fw.bin");
+MODULE_AUTHOR("Realtek Corporation");
+MODULE_DESCRIPTION("Realtek 802.11ax wireless 8852C driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.h b/drivers/net/wireless/realtek/rtw89/rtw8852c.h
new file mode 100644
index 0000000000000..68a397223a814
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2019-2022  Realtek Corporation
+ */
+
+#ifndef __RTW89_8852C_H__
+#define __RTW89_8852C_H__
+
+#include "core.h"
+
+extern const struct rtw89_chip_info rtw8852c_chip_info;
+
+#endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
new file mode 100644
index 0000000000000..ee700bba1eb10
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2020-2022  Realtek Corporation
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "pci.h"
+#include "reg.h"
+#include "rtw8852c.h"
+
+static const struct rtw89_driver_info rtw89_8852ce_info = {
+	.chip = &rtw8852c_chip_info,
+};
+
+static const struct pci_device_id rtw89_8852ce_id_table[] = {
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0xc852),
+		.driver_data = (kernel_ulong_t)&rtw89_8852ce_info,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(pci, rtw89_8852ce_id_table);
+
+static struct pci_driver rtw89_8852ce_driver = {
+	.name		= "rtw89_8852ce",
+	.id_table	= rtw89_8852ce_id_table,
+	.probe		= rtw89_pci_probe,
+	.remove		= rtw89_pci_remove,
+	.driver.pm	= &rtw89_pm_ops,
+};
+module_pci_driver(rtw89_8852ce_driver);
+
+MODULE_AUTHOR("Realtek Corporation");
+MODULE_DESCRIPTION("Realtek 802.11ax wireless 8852CE driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.25.1

