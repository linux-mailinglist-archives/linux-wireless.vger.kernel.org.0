Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505616FA1F2
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 10:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbjEHIMs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 04:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbjEHIMp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 04:12:45 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D002B1A10A
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 01:12:41 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3488COI80006068, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3488COI80006068
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 8 May 2023 16:12:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 8 May 2023 16:12:29 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 May 2023
 16:12:29 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/3] wifi: rtw89: introduce realtek ACPI DSM method
Date:   Mon, 8 May 2023 16:12:09 +0800
Message-ID: <20230508081211.38760-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230508081211.38760-1-pkshih@realtek.com>
References: <20230508081211.38760-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Introduce realtek ACPI DSM method to get required BIOS
configurations. It will be used in the following commits.

And, enum rtw89_acpi_dsm_func is added for listing the functions
which are currently recognized.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/Makefile |  3 +-
 drivers/net/wireless/realtek/rtw89/acpi.c   | 52 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/acpi.h   | 21 +++++++++
 3 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/acpi.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/acpi.h

diff --git a/drivers/net/wireless/realtek/rtw89/Makefile b/drivers/net/wireless/realtek/rtw89/Makefile
index 2dc48fa10c6b6..99e870d6a7d7d 100644
--- a/drivers/net/wireless/realtek/rtw89/Makefile
+++ b/drivers/net/wireless/realtek/rtw89/Makefile
@@ -13,7 +13,8 @@ rtw89_core-y += core.o \
 		coex.o \
 		ps.o \
 		chan.o \
-		ser.o
+		ser.o \
+		acpi.o
 
 rtw89_core-$(CONFIG_PM) += wow.o
 
diff --git a/drivers/net/wireless/realtek/rtw89/acpi.c b/drivers/net/wireless/realtek/rtw89/acpi.c
new file mode 100644
index 0000000000000..8aaf83a2a6b48
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/acpi.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2021-2023  Realtek Corporation
+ */
+
+#include <linux/acpi.h>
+#include <linux/uuid.h>
+
+#include "acpi.h"
+#include "debug.h"
+
+static const guid_t rtw89_guid = GUID_INIT(0xD2A8C3E8, 0x4B69, 0x4F00,
+					   0x82, 0xBD, 0xFE, 0x86,
+					   0x07, 0x80, 0x3A, 0xA7);
+
+static int rtw89_acpi_dsm_get(struct rtw89_dev *rtwdev, union acpi_object *obj,
+			      u8 *value)
+{
+	switch (obj->type) {
+	case ACPI_TYPE_INTEGER:
+		*value = (u8)obj->integer.value;
+		break;
+	case ACPI_TYPE_BUFFER:
+		*value = obj->buffer.pointer[0];
+		break;
+	default:
+		rtw89_debug(rtwdev, RTW89_DBG_UNEXP,
+			    "acpi dsm return unhandled type: %d\n", obj->type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int rtw89_acpi_evaluate_dsm(struct rtw89_dev *rtwdev,
+			    enum rtw89_acpi_dsm_func func, u8 *value)
+{
+	union acpi_object *obj;
+	int ret;
+
+	obj = acpi_evaluate_dsm(ACPI_HANDLE(rtwdev->dev), &rtw89_guid,
+				0, func, NULL);
+	if (!obj) {
+		rtw89_debug(rtwdev, RTW89_DBG_UNEXP,
+			    "acpi dsm fail to evaluate func: %d\n", func);
+		return -ENOENT;
+	}
+
+	ret = rtw89_acpi_dsm_get(rtwdev, obj, value);
+
+	ACPI_FREE(obj);
+	return ret;
+}
diff --git a/drivers/net/wireless/realtek/rtw89/acpi.h b/drivers/net/wireless/realtek/rtw89/acpi.h
new file mode 100644
index 0000000000000..ed74d8ceb7339
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/acpi.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2021-2023  Realtek Corporation
+ */
+
+#ifndef __RTW89_ACPI_H__
+#define __RTW89_ACPI_H__
+
+#include "core.h"
+
+enum rtw89_acpi_dsm_func {
+	RTW89_ACPI_DSM_FUNC_IDN_BAND_SUP = 2,
+	RTW89_ACPI_DSM_FUNC_6G_DIS = 3,
+	RTW89_ACPI_DSM_FUNC_6G_BP = 4,
+	RTW89_ACPI_DSM_FUNC_TAS_EN = 5,
+	RTW89_ACPI_DSM_FUNC_59G_EN = 6,
+};
+
+int rtw89_acpi_evaluate_dsm(struct rtw89_dev *rtwdev,
+			    enum rtw89_acpi_dsm_func func, u8 *value);
+
+#endif
-- 
2.25.1

