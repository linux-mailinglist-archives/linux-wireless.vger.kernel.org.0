Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D45382679
	for <lists+linux-wireless@lfdr.de>; Mon, 17 May 2021 10:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbhEQIQJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 May 2021 04:16:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2943 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbhEQIQF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 May 2021 04:16:05 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FkBgP4RD1zCsjs;
        Mon, 17 May 2021 16:12:01 +0800 (CST)
Received: from dggema704-chm.china.huawei.com (10.3.20.68) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 16:14:46 +0800
Received: from localhost.localdomain (10.67.165.2) by
 dggema704-chm.china.huawei.com (10.3.20.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 17 May 2021 16:14:46 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Yang Shen" <shenyang39@huawei.com>,
        Maya Erez <merez@codeaurora.org>
Subject: [PATCH 03/11] net: ath: wil6210: Fix wrong function name in comments
Date:   Mon, 17 May 2021 13:01:33 +0800
Message-ID: <20210517050141.61488-4-shenyang39@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210517050141.61488-1-shenyang39@huawei.com>
References: <20210517050141.61488-1-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema704-chm.china.huawei.com (10.3.20.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ath/wil6210/interrupt.c:28: warning: expecting prototype for Theory of operation(). Prototype was for WIL6210_IRQ_DISABLE() instead
 drivers/net/wireless/ath/wil6210/wmi.c:227: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/net/wireless/ath/wil6210/wmi.c:245: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/net/wireless/ath/wil6210/wmi.c:263: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Cc: Maya Erez <merez@codeaurora.org>
Signed-off-by: Yang Shen <shenyang39@huawei.com>
---
 drivers/net/wireless/ath/wil6210/interrupt.c | 2 +-
 drivers/net/wireless/ath/wil6210/wmi.c       | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/interrupt.c b/drivers/net/wireless/ath/wil6210/interrupt.c
index d13d081fdcc6..67172385a5d6 100644
--- a/drivers/net/wireless/ath/wil6210/interrupt.c
+++ b/drivers/net/wireless/ath/wil6210/interrupt.c
@@ -9,7 +9,7 @@
 #include "wil6210.h"
 #include "trace.h"
 
-/**
+/*
  * Theory of operation:
  *
  * There is ISR pseudo-cause register,
diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index 02ad44997e87..2dc8406736f4 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -224,7 +224,7 @@ struct auth_no_hdr {
 u8 led_polarity = LED_POLARITY_LOW_ACTIVE;
 
 /**
- * return AHB address for given firmware internal (linker) address
+ * wmi_addr_remap - return AHB address for given firmware internal (linker) address
  * @x: internal address
  * If address have no valid AHB mapping, return 0
  */
@@ -242,7 +242,7 @@ static u32 wmi_addr_remap(u32 x)
 }
 
 /**
- * find fw_mapping entry by section name
+ * wil_find_fw_mapping - find fw_mapping entry by section name
  * @section: section name
  *
  * Return pointer to section or NULL if not found
@@ -260,7 +260,7 @@ struct fw_map *wil_find_fw_mapping(const char *section)
 }
 
 /**
- * Check address validity for WMI buffer; remap if needed
+ * wmi_buffer_block - Check address validity for WMI buffer; remap if needed
  * @wil: driver data
  * @ptr_: internal (linker) fw/ucode address
  * @size: if non zero, validate the block does not
-- 
2.17.1

