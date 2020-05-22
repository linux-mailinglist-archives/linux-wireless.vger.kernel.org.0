Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7F61DE950
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 16:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbgEVOqC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 10:46:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730357AbgEVOqB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 10:46:01 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60DF52053B;
        Fri, 22 May 2020 14:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590158760;
        bh=8NLVpRbZ9BVGCWTSzZ0LcYnOFxjviPD4hKwEfLQKjkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iJlmtjMJMGRFGvCBTfXLTroUx4zFYQR1M8BRpOEOKuS/9mTVqF+U2NaRvKIIHitu6
         Qp7FLN7G6reB0jwhmKQNqDJrwTvoN2/ethiYKSKd/XfyyyY6MBImIgktC9mmooYrqa
         NKBQ1W+FcGCCVTQWWH3mSt79AXrAoUquVdBRYR/I=
Received: by pali.im (Postfix)
        id 97FDF51E; Fri, 22 May 2020 16:45:58 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-kernel@vger.kernel.org, ath10k@lists.infradead.org,
        b43-dev@lists.infradead.org, brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, libertas-dev@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH 07/11] mmc: sdio: Move SDIO IDs from ath6kl driver to common include file
Date:   Fri, 22 May 2020 16:44:08 +0200
Message-Id: <20200522144412.19712-8-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522144412.19712-1-pali@kernel.org>
References: <20200522144412.19712-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Also replace generic MANUFACTURER macros by proper SDIO IDs macros.

Check for "AR6003 or later" is slightly modified to use SDIO device IDs.
This allows removal of all custom MANUFACTURER macros from ath6kl.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/net/wireless/ath/ath6kl/hif.h  |  6 ------
 drivers/net/wireless/ath/ath6kl/sdio.c | 17 ++++++++---------
 include/linux/mmc/sdio_ids.h           | 10 ++++++++++
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/hif.h b/drivers/net/wireless/ath/ath6kl/hif.h
index dc6bd8cd9b83..c6dafc38936a 100644
--- a/drivers/net/wireless/ath/ath6kl/hif.h
+++ b/drivers/net/wireless/ath/ath6kl/hif.h
@@ -35,12 +35,6 @@
 #define MAX_SCATTER_ENTRIES_PER_REQ      16
 #define MAX_SCATTER_REQ_TRANSFER_SIZE    (32 * 1024)
 
-#define MANUFACTURER_ID_AR6003_BASE        0x300
-#define MANUFACTURER_ID_AR6004_BASE        0x400
-    /* SDIO manufacturer ID and Codes */
-#define MANUFACTURER_ID_ATH6KL_BASE_MASK     0xFF00
-#define MANUFACTURER_CODE                  0x271	/* Atheros */
-
 /* Mailbox address in SDIO address space */
 #define HIF_MBOX_BASE_ADDR                 0x800
 #define HIF_MBOX_WIDTH                     0x800
diff --git a/drivers/net/wireless/ath/ath6kl/sdio.c b/drivers/net/wireless/ath/ath6kl/sdio.c
index bb50680580f3..6b51a2dceadc 100644
--- a/drivers/net/wireless/ath/ath6kl/sdio.c
+++ b/drivers/net/wireless/ath/ath6kl/sdio.c
@@ -799,8 +799,7 @@ static int ath6kl_sdio_config(struct ath6kl *ar)
 
 	sdio_claim_host(func);
 
-	if ((ar_sdio->id->device & MANUFACTURER_ID_ATH6KL_BASE_MASK) >=
-	    MANUFACTURER_ID_AR6003_BASE) {
+	if (ar_sdio->id->device >= SDIO_DEVICE_ID_ATHEROS_AR6003_00) {
 		/* enable 4-bit ASYNC interrupt on AR6003 or later */
 		ret = ath6kl_sdio_func0_cmd52_wr_byte(func->card,
 						CCCR_SDIO_IRQ_MODE_REG,
@@ -1409,13 +1408,13 @@ static void ath6kl_sdio_remove(struct sdio_func *func)
 }
 
 static const struct sdio_device_id ath6kl_sdio_devices[] = {
-	{SDIO_DEVICE(MANUFACTURER_CODE, (MANUFACTURER_ID_AR6003_BASE | 0x0))},
-	{SDIO_DEVICE(MANUFACTURER_CODE, (MANUFACTURER_ID_AR6003_BASE | 0x1))},
-	{SDIO_DEVICE(MANUFACTURER_CODE, (MANUFACTURER_ID_AR6004_BASE | 0x0))},
-	{SDIO_DEVICE(MANUFACTURER_CODE, (MANUFACTURER_ID_AR6004_BASE | 0x1))},
-	{SDIO_DEVICE(MANUFACTURER_CODE, (MANUFACTURER_ID_AR6004_BASE | 0x2))},
-	{SDIO_DEVICE(MANUFACTURER_CODE, (MANUFACTURER_ID_AR6004_BASE | 0x18))},
-	{SDIO_DEVICE(MANUFACTURER_CODE, (MANUFACTURER_ID_AR6004_BASE | 0x19))},
+	{SDIO_DEVICE(SDIO_VENDOR_ID_ATHEROS, SDIO_DEVICE_ID_ATHEROS_AR6003_00)},
+	{SDIO_DEVICE(SDIO_VENDOR_ID_ATHEROS, SDIO_DEVICE_ID_ATHEROS_AR6003_01)},
+	{SDIO_DEVICE(SDIO_VENDOR_ID_ATHEROS, SDIO_DEVICE_ID_ATHEROS_AR6004_00)},
+	{SDIO_DEVICE(SDIO_VENDOR_ID_ATHEROS, SDIO_DEVICE_ID_ATHEROS_AR6004_01)},
+	{SDIO_DEVICE(SDIO_VENDOR_ID_ATHEROS, SDIO_DEVICE_ID_ATHEROS_AR6004_02)},
+	{SDIO_DEVICE(SDIO_VENDOR_ID_ATHEROS, SDIO_DEVICE_ID_ATHEROS_AR6004_18)},
+	{SDIO_DEVICE(SDIO_VENDOR_ID_ATHEROS, SDIO_DEVICE_ID_ATHEROS_AR6004_19)},
 	{},
 };
 
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 9ec675a7ac37..95b67ab7d06a 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -24,6 +24,16 @@
 /*
  * Vendors and devices.  Sort key: vendor first, device next.
  */
+
+#define SDIO_VENDOR_ID_ATHEROS			0x0271
+#define SDIO_DEVICE_ID_ATHEROS_AR6003_00	0x0300
+#define SDIO_DEVICE_ID_ATHEROS_AR6003_01	0x0301
+#define SDIO_DEVICE_ID_ATHEROS_AR6004_00	0x0400
+#define SDIO_DEVICE_ID_ATHEROS_AR6004_01	0x0401
+#define SDIO_DEVICE_ID_ATHEROS_AR6004_02	0x0402
+#define SDIO_DEVICE_ID_ATHEROS_AR6004_18	0x0418
+#define SDIO_DEVICE_ID_ATHEROS_AR6004_19	0x0419
+
 #define SDIO_VENDOR_ID_BROADCOM			0x02d0
 #define SDIO_DEVICE_ID_BROADCOM_43143		0xa887
 #define SDIO_DEVICE_ID_BROADCOM_43241		0x4324
-- 
2.20.1

