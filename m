Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C887F382675
	for <lists+linux-wireless@lfdr.de>; Mon, 17 May 2021 10:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbhEQIQH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 May 2021 04:16:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2945 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbhEQIQE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 May 2021 04:16:04 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FkBgQ5pXbzCswH;
        Mon, 17 May 2021 16:12:02 +0800 (CST)
Received: from dggema704-chm.china.huawei.com (10.3.20.68) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 16:14:47 +0800
Received: from localhost.localdomain (10.67.165.2) by
 dggema704-chm.china.huawei.com (10.3.20.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 17 May 2021 16:14:47 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Yang Shen" <shenyang39@huawei.com>
Subject: [PATCH 10/11] net: ti: wl1251: Fix missing function name in comments
Date:   Mon, 17 May 2021 13:01:40 +0800
Message-ID: <20210517050141.61488-11-shenyang39@huawei.com>
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

 drivers/net/wireless/ti/wl1251/cmd.c:15: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/net/wireless/ti/wl1251/cmd.c:62: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/net/wireless/ti/wl1251/cmd.c:103: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/net/wireless/ti/wl1251/cmd.c:141: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Signed-off-by: Yang Shen <shenyang39@huawei.com>
---
 drivers/net/wireless/ti/wl1251/cmd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ti/wl1251/cmd.c b/drivers/net/wireless/ti/wl1251/cmd.c
index 498c8db2eb48..eb92dde786e7 100644
--- a/drivers/net/wireless/ti/wl1251/cmd.c
+++ b/drivers/net/wireless/ti/wl1251/cmd.c
@@ -12,7 +12,7 @@
 #include "acx.h"

 /**
- * send command to firmware
+ * wl1251_cmd_send - Send command to firmware
  *
  * @wl: wl struct
  * @id: command id
@@ -59,7 +59,7 @@ int wl1251_cmd_send(struct wl1251 *wl, u16 id, void *buf, size_t len)
 }

 /**
- * send test command to firmware
+ * wl1251_cmd_test - Send test command to firmware
  *
  * @wl: wl struct
  * @buf: buffer containing the command, with all headers, must work with dma
@@ -100,7 +100,7 @@ int wl1251_cmd_test(struct wl1251 *wl, void *buf, size_t buf_len, u8 answer)
 }

 /**
- * read acx from firmware
+ * wl1251_cmd_interrogate - Read acx from firmware
  *
  * @wl: wl struct
  * @id: acx id
@@ -138,7 +138,7 @@ int wl1251_cmd_interrogate(struct wl1251 *wl, u16 id, void *buf, size_t len)
 }

 /**
- * write acx value to firmware
+ * wl1251_cmd_configure - Write acx value to firmware
  *
  * @wl: wl struct
  * @id: acx id
--
2.17.1

