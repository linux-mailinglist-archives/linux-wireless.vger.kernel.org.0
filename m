Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5D11DE955
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 16:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbgEVOqL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 10:46:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730427AbgEVOqI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 10:46:08 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 600162054F;
        Fri, 22 May 2020 14:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590158767;
        bh=TJohxP7W9jg/tdaIFO6IgAHGCrICOTbIc/uilKm/8Sk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0tmb1v0XU35+tUH6DDmz3g8ydeL47t0zXZM93MTVX34VGrqnEHSD3SE4WgZUUui0R
         kwXHdMPvtB16hmvqI0wplZanV9HIRyrBokqMVm1qcACmcMEB5o6NPmIFpP6ucuef3u
         gcSDdyYJtjWyI+jvGmpKI5HpNSfQZ4W9GmgxnEkA=
Received: by pali.im (Postfix)
        id 99D2751E; Fri, 22 May 2020 16:46:05 +0200 (CEST)
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
Subject: [PATCH 10/11] mmc: sdio: Fix Cypress SDIO IDs macros in common include file
Date:   Fri, 22 May 2020 16:44:11 +0200
Message-Id: <20200522144412.19712-11-pali@kernel.org>
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

All macro names for SDIO device IDs are prefixed by vendor name to which
device ID belongs. So for consistency add Broadcom string vendor prefix to
all Cypress macro names as they belong to SDIO Broadcom vendor ID.

Change also Cypress 43012 value from decimal do hexadecimal notation to be
consistent with all other values.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 6 +++---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c   | 4 ++--
 include/linux/mmc/sdio_ids.h                              | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index b684a5b6d904..a1fdb618cf14 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -970,9 +970,9 @@ static const struct sdio_device_id brcmf_sdmmc_ids[] = {
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4354),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4356),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4359),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_CYPRESS_4373),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_CYPRESS_43012),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_CYPRESS_89359),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43012),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_89359),
 	{ /* end: all zeroes */ }
 };
 MODULE_DEVICE_TABLE(sdio, brcmf_sdmmc_ids);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 3a08252f1a53..1c9561665a67 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -4187,7 +4187,7 @@ static void brcmf_sdio_firmware_callback(struct device *dev, int err,
 				   bus->hostintmask, NULL);
 
 		switch (sdiod->func1->device) {
-		case SDIO_DEVICE_ID_CYPRESS_4373:
+		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373:
 			brcmf_dbg(INFO, "set F2 watermark to 0x%x*4 bytes\n",
 				  CY_4373_F2_WATERMARK);
 			brcmf_sdiod_writeb(sdiod, SBSDIO_WATERMARK,
@@ -4201,7 +4201,7 @@ static void brcmf_sdio_firmware_callback(struct device *dev, int err,
 					   CY_4373_F2_WATERMARK |
 					   SBSDIO_MESBUSYCTRL_ENAB, &err);
 			break;
-		case SDIO_DEVICE_ID_CYPRESS_43012:
+		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_43012:
 			brcmf_dbg(INFO, "set F2 watermark to 0x%x*4 bytes\n",
 				  CY_43012_F2_WATERMARK);
 			brcmf_sdiod_writeb(sdiod, SBSDIO_WATERMARK,
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 8e7a0683b927..b19200aea56a 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -58,9 +58,9 @@
 #define SDIO_DEVICE_ID_BROADCOM_4354		0x4354
 #define SDIO_DEVICE_ID_BROADCOM_4356		0x4356
 #define SDIO_DEVICE_ID_BROADCOM_4359		0x4359
-#define SDIO_DEVICE_ID_CYPRESS_4373		0x4373
-#define SDIO_DEVICE_ID_CYPRESS_43012		43012
-#define SDIO_DEVICE_ID_CYPRESS_89359		0x4355
+#define SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373	0x4373
+#define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43012	0xa804
+#define SDIO_DEVICE_ID_BROADCOM_CYPRESS_89359	0x4355
 
 #define SDIO_VENDOR_ID_INTEL			0x0089
 #define SDIO_DEVICE_ID_INTEL_IWMC3200WIMAX	0x1402
-- 
2.20.1

