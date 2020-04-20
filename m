Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343E01B0133
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2020 07:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgDTFvV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Apr 2020 01:51:21 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:42175 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDTFvP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Apr 2020 01:51:15 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03K5p8T31000866, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03K5p8T31000866
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 Apr 2020 13:51:08 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 20 Apr 2020 13:51:07 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 20 Apr 2020 13:51:07 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 1/8] rtw88: 8723d: Add basic chip capabilities
Date:   Mon, 20 Apr 2020 13:50:47 +0800
Message-ID: <20200420055054.14592-2-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420055054.14592-1-yhchuang@realtek.com>
References: <20200420055054.14592-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

RTL8723DE is an 11n 1x1 2.4G single band chip with the
following capabilities:

 - TX/RX BD size: 16/8
 - TX/RX desc size: 40/24
 - physical/logical/protected efuse size: 512/512/96
 - TX gain index factor: 1
 - max TX power index: 0x3F
 - band: 2G
 - HT: support
 - VHT: Not support

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.h     |  2 +
 drivers/net/wireless/realtek/rtw88/pci.c      |  3 ++
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 44 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.h |  8 ++++
 .../wireless/realtek/rtw88/rtw8723d_table.c   |  7 +++
 .../wireless/realtek/rtw88/rtw8723d_table.h   |  8 ++++
 6 files changed, 72 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723d.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723d.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723d_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723d_table.h

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index c9edcabd7c42..be74533320ad 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -41,6 +41,7 @@ extern unsigned int rtw_debug_mask;
 extern const struct ieee80211_ops rtw_ops;
 extern struct rtw_chip_info rtw8822b_hw_spec;
 extern struct rtw_chip_info rtw8822c_hw_spec;
+extern struct rtw_chip_info rtw8723d_hw_spec;
 
 #define RTW_MAX_CHANNEL_NUM_2G 14
 #define RTW_MAX_CHANNEL_NUM_5G 49
@@ -183,6 +184,7 @@ enum rtw_wireless_set {
 enum rtw_chip_type {
 	RTW_CHIP_TYPE_8822B,
 	RTW_CHIP_TYPE_8822C,
+	RTW_CHIP_TYPE_8723D,
 };
 
 enum rtw_tx_queue_type {
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index e37c71495c0d..b3e76b579af9 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1572,6 +1572,9 @@ static const struct pci_device_id rtw_pci_id_table[] = {
 #endif
 #ifdef CONFIG_RTW88_8822CE
 	{ RTK_PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0xC822, rtw8822c_hw_spec) },
+#endif
+#ifdef CONFIG_RTW88_8723DE
+	{ RTK_PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0xD723, rtw8723d_hw_spec) },
 #endif
 	{},
 };
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
new file mode 100644
index 000000000000..cccf05ee6807
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2018-2019  Realtek Corporation
+ */
+
+#include "main.h"
+#include "coex.h"
+#include "fw.h"
+#include "tx.h"
+#include "rx.h"
+#include "phy.h"
+#include "rtw8723d.h"
+#include "rtw8723d_table.h"
+#include "mac.h"
+#include "reg.h"
+#include "debug.h"
+
+static struct rtw_chip_ops rtw8723d_ops = {
+	.set_antenna		= NULL,
+};
+
+struct rtw_chip_info rtw8723d_hw_spec = {
+	.ops = &rtw8723d_ops,
+	.id = RTW_CHIP_TYPE_8723D,
+	.fw_name = "rtw88/rtw8723d_fw.bin",
+	.tx_pkt_desc_sz = 40,
+	.tx_buf_desc_sz = 16,
+	.rx_pkt_desc_sz = 24,
+	.rx_buf_desc_sz = 8,
+	.phy_efuse_size = 512,
+	.log_efuse_size = 512,
+	.ptct_efuse_size = 96 + 1,
+	.txgi_factor = 1,
+	.is_pwr_by_rate_dec = true,
+	.max_power_index = 0x3f,
+	.csi_buf_pg_num = 0,
+	.band = RTW_BAND_2G,
+	.ht_supported = true,
+	.vht_supported = false,
+	.lps_deep_mode_supported = 0,
+	.sys_func_en = 0xFD,
+};
+EXPORT_SYMBOL(rtw8723d_hw_spec);
+
+MODULE_FIRMWARE("rtw88/rtw8723d_fw.bin");
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.h b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
new file mode 100644
index 000000000000..0b784cfc34c6
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2018-2019  Realtek Corporation
+ */
+
+#ifndef __RTW8723D_H__
+#define __RTW8723D_H__
+
+#endif
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d_table.c b/drivers/net/wireless/realtek/rtw88/rtw8723d_table.c
new file mode 100644
index 000000000000..b22b4b0f2fcf
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d_table.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2018-2019  Realtek Corporation
+ */
+
+#include "main.h"
+#include "phy.h"
+#include "rtw8723d_table.h"
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d_table.h b/drivers/net/wireless/realtek/rtw88/rtw8723d_table.h
new file mode 100644
index 000000000000..ea5933ffd043
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d_table.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2018-2019  Realtek Corporation
+ */
+
+#ifndef __RTW8723D_TABLE_H__
+#define __RTW8723D_TABLE_H__
+
+#endif
-- 
2.17.1

