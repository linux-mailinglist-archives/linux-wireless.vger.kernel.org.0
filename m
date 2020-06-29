Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7AFA20E57E
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2020 00:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgF2Vhk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jun 2020 17:37:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:60596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728372AbgF2Skd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:33 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 627C423128;
        Mon, 29 Jun 2020 07:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593415374;
        bh=yT91BYvH3WjdmAvG2j2qrg9Xq6C0JSmmu5V70ZdeVAE=;
        h=From:To:Cc:Subject:Date:From;
        b=Y0p63s01rk+DVrstkcB9Db5yUPgHaeny0zC60+6dYzTJATXErTMDJEmi4aXIgBaet
         QF+ho1djOTn6KVLeI8TZoiLcitj4+MdwV8uRljaCvrtcueHzMIw4T0Bhg2RxeATNMn
         gWqaqAr/3Zsadcx1J7DlSM1FV/Q00KdP/F1C4lzI=
Received: by pali.im (Postfix)
        id CBE1881F; Mon, 29 Jun 2020 09:22:51 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdio: Move SDIO IDs from rsi_sdio driver to common include file
Date:   Mon, 29 Jun 2020 09:21:44 +0200
Message-Id: <20200629072144.24351-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Define appropriate macro names for consistency with other macros.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
Hello Ulf! I forgot to include change for rsi driver into patch series:
"mmc: sdio: Move SDIO IDs from drivers to common include file"
https://lore.kernel.org/linux-mmc/20200522144412.19712-1-pali@kernel.org/
As patch series was already merged, I'm sending this patch separately.
---
 drivers/net/wireless/rsi/rsi_91x_sdio.c | 8 ++++----
 drivers/net/wireless/rsi/rsi_sdio.h     | 4 ----
 include/linux/mmc/sdio_ids.h            | 4 ++++
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_sdio.c b/drivers/net/wireless/rsi/rsi_91x_sdio.c
index 5d6143a55187..a04ff75c409f 100644
--- a/drivers/net/wireless/rsi/rsi_91x_sdio.c
+++ b/drivers/net/wireless/rsi/rsi_91x_sdio.c
@@ -1038,10 +1038,10 @@ static int rsi_probe(struct sdio_func *pfunction,
 		goto fail_free_adapter;
 	}
 
-	if (pfunction->device == RSI_SDIO_PID_9113) {
+	if (pfunction->device == SDIO_DEVICE_ID_RSI_9113) {
 		rsi_dbg(ERR_ZONE, "%s: 9113 module detected\n", __func__);
 		adapter->device_model = RSI_DEV_9113;
-	} else  if (pfunction->device == RSI_SDIO_PID_9116) {
+	} else  if (pfunction->device == SDIO_DEVICE_ID_RSI_9116) {
 		rsi_dbg(ERR_ZONE, "%s: 9116 module detected\n", __func__);
 		adapter->device_model = RSI_DEV_9116;
 	} else {
@@ -1526,8 +1526,8 @@ static const struct dev_pm_ops rsi_pm_ops = {
 #endif
 
 static const struct sdio_device_id rsi_dev_table[] =  {
-	{ SDIO_DEVICE(RSI_SDIO_VENDOR_ID, RSI_SDIO_PID_9113) },
-	{ SDIO_DEVICE(RSI_SDIO_VENDOR_ID, RSI_SDIO_PID_9116) },
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_RSI, SDIO_DEVICE_ID_RSI_9113) },
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_RSI, SDIO_DEVICE_ID_RSI_9116) },
 	{ /* Blank */},
 };
 
diff --git a/drivers/net/wireless/rsi/rsi_sdio.h b/drivers/net/wireless/rsi/rsi_sdio.h
index c5cfb6238f73..9afc1d0d2684 100644
--- a/drivers/net/wireless/rsi/rsi_sdio.h
+++ b/drivers/net/wireless/rsi/rsi_sdio.h
@@ -28,10 +28,6 @@
 #include <linux/mmc/sdio_ids.h>
 #include "rsi_main.h"
 
-#define RSI_SDIO_VENDOR_ID   0x041B
-#define RSI_SDIO_PID_9113    0x9330
-#define RSI_SDIO_PID_9116    0x9116
-
 enum sdio_interrupt_type {
 	BUFFER_FULL         = 0x0,
 	BUFFER_AVAILABLE    = 0x2,
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 15ed8ce9d394..ab41801c5f51 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -118,6 +118,10 @@
 #define SDIO_DEVICE_ID_SIANO_NOVA_A0		0x1100
 #define SDIO_DEVICE_ID_SIANO_STELLAR 		0x5347
 
+#define SDIO_VENDOR_ID_RSI			0x041b
+#define SDIO_DEVICE_ID_RSI_9113			0x9330
+#define SDIO_DEVICE_ID_RSI_9116			0x9116
+
 #define SDIO_VENDOR_ID_TI_WL1251		0x104c
 #define SDIO_DEVICE_ID_TI_WL1251		0x9066
 
-- 
2.20.1

