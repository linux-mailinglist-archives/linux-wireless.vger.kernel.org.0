Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C166515549F
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2020 10:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgBGJ25 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Feb 2020 04:28:57 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:44688 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgBGJ24 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Feb 2020 04:28:56 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 0179Sog4018564, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 0179Sog4018564
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Feb 2020 17:28:50 +0800
Received: from RTEXMB05.realtek.com.tw (172.21.6.98) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 7 Feb 2020 17:28:50 +0800
Received: from RTEXMB06.realtek.com.tw (172.21.6.99) by
 RTEXMB05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 7 Feb 2020 17:28:50 +0800
Received: from RTITCASV01.realtek.com.tw (172.21.6.18) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1779.2
 via Frontend Transport; Fri, 7 Feb 2020 17:28:50 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Fri, 7 Feb 2020 17:28:49 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <pkshih@realtek.com>
Subject: [PATCH 4/8] rtw88: sar: Load static SAR table from ACPI WRDS method
Date:   Fri, 7 Feb 2020 17:28:40 +0800
Message-ID: <20200207092844.29175-5-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200207092844.29175-1-yhchuang@realtek.com>
References: <20200207092844.29175-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

ACPI WRDS method returns static SAR table that contains two chains (RF paths)
and five power limit data for each chain. The limit data are corresponding
to certain ranges of frequency, such as 2.4G band, 5.15~5.35G etc.

The data is in Q.3 notation that is the same with SAR entry function, so
we don't need to convert its quantity.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/Makefile |   1 +
 drivers/net/wireless/realtek/rtw88/main.c   |   2 +
 drivers/net/wireless/realtek/rtw88/sar.c    | 200 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/sar.h    |  10 +
 4 files changed, 213 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw88/sar.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/sar.h

diff --git a/drivers/net/wireless/realtek/rtw88/Makefile b/drivers/net/wireless/realtek/rtw88/Makefile
index 935333f734a9..0e141edfd174 100644
--- a/drivers/net/wireless/realtek/rtw88/Makefile
+++ b/drivers/net/wireless/realtek/rtw88/Makefile
@@ -17,6 +17,7 @@ rtw88-y += main.o \
 	   bf.o \
 	   wow.o \
 	   vndcmd.o \
+	   sar.o \
 	   regd.o
 
 rtw88-$(CONFIG_RTW88_8822BE)	+= rtw8822b.o rtw8822b_table.o
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 7156a06eea74..23cbb00e16b1 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -16,6 +16,7 @@
 #include "debug.h"
 #include "bf.h"
 #include "vndcmd.h"
+#include "sar.h"
 
 unsigned int rtw_fw_lps_deep_mode;
 EXPORT_SYMBOL(rtw_fw_lps_deep_mode);
@@ -1305,6 +1306,7 @@ static int rtw_chip_board_info_setup(struct rtw_dev *rtwdev)
 	rtw_load_table(rtwdev, rfe_def->txpwr_lmt_tbl);
 	rtw_phy_tx_power_by_rate_config(hal);
 	rtw_phy_tx_power_limit_config(hal);
+	rtw_sar_load_table(rtwdev);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw88/sar.c b/drivers/net/wireless/realtek/rtw88/sar.c
new file mode 100644
index 000000000000..f15366ce1046
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/sar.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2018-2019  Realtek Corporation
+ */
+
+#include <linux/acpi.h>
+#include "main.h"
+#include "debug.h"
+#include "phy.h"
+#include "sar.h"
+
+#define RTW_SAR_WRDS_CHAIN_NR	2
+
+enum rtw_sar_limit_index {
+	RTW_SAR_LMT_CH1_14,
+	RTW_SAR_LMT_CH36_64,
+	RTW_SAR_LMT_UND1,
+	RTW_SAR_LMT_CH100_144,
+	RTW_SAR_LMT_CH149_165,
+
+	RTW_SAR_LMT_TOTAL_NR,
+};
+
+struct rtw_sar_limits {
+	s8 limit[RTW_SAR_LMT_TOTAL_NR];
+};
+
+struct rtw_sar_wrds {
+	struct rtw_sar_limits chain[RTW_SAR_WRDS_CHAIN_NR];
+};
+
+#define ACPI_WRDS_METHOD	"WRDS"
+#define ACPI_WRDS_SIZE		sizeof(struct rtw_sar_wrds)
+#define ACPI_WRDS_TOTAL_SIZE	(sizeof(struct rtw_sar_wrds) + 2)
+#define ACPI_WIFI_DOMAIN	0x07
+
+#ifdef CONFIG_ACPI
+static union acpi_object *rtw_sar_get_acpiobj(struct rtw_dev *rtwdev,
+					      const char *method)
+{
+	struct device *dev = rtwdev->dev;
+	acpi_handle root_handle;
+	acpi_handle handle;
+	acpi_status status;
+	struct acpi_buffer buf = {ACPI_ALLOCATE_BUFFER, NULL};
+
+	/* Check device handler */
+	root_handle = ACPI_HANDLE(dev);
+	if (!root_handle) {
+		rtw_dbg(rtwdev, RTW_DBG_REGD,
+			"SAR: Could not retireve root port ACPI handle\n");
+		return NULL;
+	}
+
+	/* Get method's handler */
+	status = acpi_get_handle(root_handle, (acpi_string)method, &handle);
+	if (ACPI_FAILURE(status)) {
+		rtw_dbg(rtwdev, RTW_DBG_REGD, "SAR: %s method not found (0x%x)\n",
+			method, status);
+		return NULL;
+	}
+
+	/* Call specific method with no argument */
+	status = acpi_evaluate_object(handle, NULL, NULL, &buf);
+	if (ACPI_FAILURE(status)) {
+		rtw_dbg(rtwdev, RTW_DBG_REGD,
+			"SAR: %s invocation failed (0x%x)\n", method, status);
+		return NULL;
+	}
+
+	return buf.pointer;
+}
+
+static union acpi_object *rtw_sar_get_wifi_pkt(struct rtw_dev *rtwdev,
+					       union acpi_object *obj,
+					       u32 element_count)
+{
+	union acpi_object *wifi_pkg;
+	u32 i;
+
+	if (obj->type != ACPI_TYPE_PACKAGE ||
+	    obj->package.count < 2 ||
+	    obj->package.elements[0].type != ACPI_TYPE_INTEGER ||
+	    obj->package.elements[0].integer.value != 0) {
+		rtw_dbg(rtwdev, RTW_DBG_REGD,
+			"SAR: Unsupported wifi package structure\n");
+		return NULL;
+	}
+
+	/* loop through all the packages to find the one for WiFi */
+	for (i = 1; i < obj->package.count; i++) {
+		union acpi_object *domain;
+
+		wifi_pkg = &obj->package.elements[i];
+
+		/* Skip anything that is not a package with the right amount of
+		 * elements (i.e. domain_type, enabled/disabled plus the sar
+		 * table size.)
+		 */
+		if (wifi_pkg->type != ACPI_TYPE_PACKAGE ||
+		    wifi_pkg->package.count != element_count)
+			continue;
+
+		domain = &wifi_pkg->package.elements[0];
+		if (domain->type == ACPI_TYPE_INTEGER &&
+		    domain->integer.value == ACPI_WIFI_DOMAIN)
+			return wifi_pkg;
+	}
+
+	return NULL;
+}
+
+static void *rtw_sar_get_wrds_table(struct rtw_dev *rtwdev)
+{
+	union acpi_object *wrds, *wrds_pkg;
+	int i, idx = 2;
+	u8 *wrds_raw = NULL;
+
+	wrds = rtw_sar_get_acpiobj(rtwdev, ACPI_WRDS_METHOD);
+	if (!wrds)
+		return NULL;
+
+	wrds_pkg = rtw_sar_get_wifi_pkt(rtwdev, wrds, ACPI_WRDS_TOTAL_SIZE);
+	if (!wrds_pkg)
+		goto out;
+
+	/* WiFiSarEnable 0: ignore BIOS config; 1: use BIOS config */
+	if (wrds_pkg->package.elements[1].type != ACPI_TYPE_INTEGER ||
+	    wrds_pkg->package.elements[1].integer.value == 0)
+		goto out;
+
+	wrds_raw = kmalloc(ACPI_WRDS_SIZE, GFP_KERNEL);
+	if (!wrds_raw)
+		goto out;
+
+	/* read elements[2~11] */
+	for (i = 0; i < ACPI_WRDS_SIZE; i++) {
+		union acpi_object *entry;
+
+		entry = &wrds_pkg->package.elements[idx++];
+		if (entry->type != ACPI_TYPE_INTEGER ||
+		    entry->integer.value > U8_MAX) {
+			kfree(wrds_raw);
+			wrds_raw = NULL;
+			goto out;
+		}
+
+		wrds_raw[i] = entry->integer.value;
+	}
+out:
+	kfree(wrds);
+
+	return wrds_raw;
+}
+
+static void rtw_sar_apply_wrds(struct rtw_dev *rtwdev,
+			       const struct rtw_sar_wrds *wrds)
+{
+	int path;
+
+	for (path = 0; path < RTW_SAR_WRDS_CHAIN_NR; path++) {
+		rtw_phy_set_tx_power_sar(rtwdev, RTW_REGD_WW, path, 1, 14,
+					 wrds->chain[path].limit[RTW_SAR_LMT_CH1_14]);
+		rtw_phy_set_tx_power_sar(rtwdev, RTW_REGD_WW, path, 36, 64,
+					 wrds->chain[path].limit[RTW_SAR_LMT_CH36_64]);
+		rtw_phy_set_tx_power_sar(rtwdev, RTW_REGD_WW, path, 100, 144,
+					 wrds->chain[path].limit[RTW_SAR_LMT_CH100_144]);
+		rtw_phy_set_tx_power_sar(rtwdev, RTW_REGD_WW, path, 149, 165,
+					 wrds->chain[path].limit[RTW_SAR_LMT_CH149_165]);
+	}
+
+	rtwdev->sar.source = RTW_SAR_SOURCE_ACPI_STATIC;
+}
+
+static int rtw_sar_load_static_tables(struct rtw_dev *rtwdev)
+{
+	struct rtw_sar_wrds *wrds;
+
+	wrds = rtw_sar_get_wrds_table(rtwdev);
+	if (!wrds)
+		return -ENOENT;
+
+	rtw_dbg(rtwdev, RTW_DBG_REGD,
+		"SAR: Apply WRDS to TX power\n");
+
+	rtw_sar_apply_wrds(rtwdev, wrds);
+	kfree(wrds);
+
+	return 0;
+}
+#else
+static int rtw_sar_load_static_tables(struct rtw_dev *rtwdev)
+{
+	return -ENOENT;
+}
+#endif /* CONFIG_ACPI */
+
+void rtw_sar_load_table(struct rtw_dev *rtwdev)
+{
+	rtw_sar_load_static_tables(rtwdev);
+}
diff --git a/drivers/net/wireless/realtek/rtw88/sar.h b/drivers/net/wireless/realtek/rtw88/sar.h
new file mode 100644
index 000000000000..632de7ed58c3
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/sar.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2018-2019  Realtek Corporation
+ */
+
+#ifndef __RTW_SAR_H_
+#define __RTW_SAR_H_
+
+void rtw_sar_load_table(struct rtw_dev *rtwdev);
+
+#endif
-- 
2.17.1

