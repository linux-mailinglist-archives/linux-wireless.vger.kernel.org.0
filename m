Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFF1382677
	for <lists+linux-wireless@lfdr.de>; Mon, 17 May 2021 10:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbhEQIQJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 May 2021 04:16:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2946 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbhEQIQF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 May 2021 04:16:05 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FkBgQ6frdzCtZ2;
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
Subject: [PATCH 11/11] net: ti: wlcore: Fix missing function name in comments
Date:   Mon, 17 May 2021 13:01:41 +0800
Message-ID: <20210517050141.61488-12-shenyang39@huawei.com>
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

 drivers/net/wireless/ti/wlcore/cmd.c:824: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/net/wireless/ti/wlcore/cmd.c:853: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/net/wireless/ti/wlcore/cmd.c:882: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Signed-off-by: Yang Shen <shenyang39@huawei.com>
---
 drivers/net/wireless/ti/wlcore/cmd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/cmd.c b/drivers/net/wireless/ti/wlcore/cmd.c
index 32a2e27cc561..8b798b5fcaf5 100644
--- a/drivers/net/wireless/ti/wlcore/cmd.c
+++ b/drivers/net/wireless/ti/wlcore/cmd.c
@@ -821,7 +821,7 @@ int wl12xx_cmd_role_start_ibss(struct wl1271 *wl, struct wl12xx_vif *wlvif)


 /**
- * send test command to firmware
+ * wl1271_cmd_test - send test command to firmware
  *
  * @wl: wl struct
  * @buf: buffer containing the command, with all headers, must work with dma
@@ -850,7 +850,7 @@ int wl1271_cmd_test(struct wl1271 *wl, void *buf, size_t buf_len, u8 answer)
 EXPORT_SYMBOL_GPL(wl1271_cmd_test);

 /**
- * read acx from firmware
+ * wl1271_cmd_interrogate - read acx from firmware
  *
  * @wl: wl struct
  * @id: acx id
@@ -879,7 +879,7 @@ int wl1271_cmd_interrogate(struct wl1271 *wl, u16 id, void *buf,
 }

 /**
- * write acx value to firmware
+ * wlcore_cmd_configure_failsafe - write acx value to firmware
  *
  * @wl: wl struct
  * @id: acx id
--
2.17.1

