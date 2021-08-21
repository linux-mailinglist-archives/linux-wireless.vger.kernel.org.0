Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CFA3F37E1
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Aug 2021 03:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240927AbhHUBJ6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 21:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhHUBJ5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 21:09:57 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD4BC061575;
        Fri, 20 Aug 2021 18:09:18 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u16so16580841wrn.5;
        Fri, 20 Aug 2021 18:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/oZ+KBthaGg5R0Lga8JYmghLqYOInCSyoGhUWJuf5Fg=;
        b=up9NvqsaE1X2uNtv+tk/1rrTTQbblNZNzEcLUB/WChGmUnCXK84hnflgjqpxQYSvqa
         W3t+8i0SMMwOXyQ0oQjZx2vK4BBCswkRNp3qWl/T0KSg3pJzZ5SwtjKBsVae0Cpa5aMq
         gOYroB91h7ce52yYY73Llpl1mhdNO+HbsOmgjdjTdyMDUq2iTm/ZEHA+AC4pR5H3jK7z
         kXigEL3kWzcxZNjK0i/7t1SdgmUjA9tDV3/mfkxgQrGL4IFScDR9nX233/A1p38kV9+l
         iiupy6Bt4ePOGv5HcFY5YJOQxaUjhZ2CoGRxSoQMcqnTmw2pk/twPUBhsMZIfFQ0JSI+
         8EQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/oZ+KBthaGg5R0Lga8JYmghLqYOInCSyoGhUWJuf5Fg=;
        b=ZON41UBmch/HXDXswhZT7MyCgj7BgGTH+EApIneGb8NrVZRcksKd/ygHDZWksRMg5i
         CDcEvKVmTY3DrWWrBAzmwLaQoKKKk1X9k36CvkCyw1Bm82IwZXZsQDIuvO+z6PeHL4NC
         Vi8ALbZCHJAwhkyE/d+DSzzsk7cjLWprHvBMOuMvvjKb9nfOGsuhKx6urBD6fhwEvv8d
         HUBl0HG3u6X6ZCa4wLXob8yk93dvFpo3+l0PSfitko63QuBcQx5vE9HBnHLsSzzm9x7z
         j8e1laN20e3Ue2JBqBmCjkTqR3Eui23EoqO55CJwRd7tb/bvB8FqMrywETus9haGx6T6
         UtZQ==
X-Gm-Message-State: AOAM530sjKRZmxNtnaglhellFKhRxlrqZyUKGTPxFipoEkLSngL9BgVK
        J+QzEx+RSC2dUGqz346z1hoWon/niAI=
X-Google-Smtp-Source: ABdhPJwpdjjbaIAnSrbGQoygE55Z+vBB6F0UybfUhi+lUEQsOdkvJMCBE+2qRupVS6Q4O+aRf9SLJA==
X-Received: by 2002:adf:c006:: with SMTP id z6mr1442666wre.157.1629508156374;
        Fri, 20 Aug 2021 18:09:16 -0700 (PDT)
Received: from debian64.daheim (pd9e297bb.dip0.t-ipconnect.de. [217.226.151.187])
        by smtp.gmail.com with ESMTPSA id u5sm7349201wrr.94.2021.08.20.18.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 18:09:15 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.94.2)
        (envelope-from <chunkeey@gmail.com>)
        id 1mHFVb-0046Wz-9A; Sat, 21 Aug 2021 03:09:15 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com
Subject: [RFC PATCH v1 3/3] ath9k: owl-loader: fetch pci init values through nvmem
Date:   Sat, 21 Aug 2021 03:09:15 +0200
Message-Id: <b7ce5cccc99f7ff05fb9e669b32a7c3dbcffafd2.1629508039.git.chunkeey@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <91e68ca7f65bee7197ed5829ef91bc526df16e8a.1629508039.git.chunkeey@gmail.com>
References: <91e68ca7f65bee7197ed5829ef91bc526df16e8a.1629508039.git.chunkeey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

extends the owl loader to fetch important pci initialization
values - which are stored together with the calibration data -
through the nvmem subsystem.

This allows for much faster WIFI/ath9k initializations on devices
that do not require to perform any post-processing (like XOR'ing/
reversal or unpacking) since no userspace helper is required.

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 .../wireless/ath/ath9k/ath9k_pci_owl_loader.c | 105 +++++++++++++-----
 1 file changed, 76 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c b/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
index 56d1a7764b9f..708c8969b503 100644
--- a/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
+++ b/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
@@ -19,9 +19,14 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/ath9k_platform.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/workqueue.h>
 
 struct owl_ctx {
+	struct pci_dev *pdev;
 	struct completion eeprom_load;
+	struct work_struct work;
+	struct nvmem_cell *cell;
 };
 
 #define EEPROM_FILENAME_LEN 100
@@ -42,6 +47,12 @@ static int ath9k_pci_fixup(struct pci_dev *pdev, const u16 *cal_data,
 	u32 bar0;
 	bool swap_needed = false;
 
+	/* also note that we are doing *u16 operations on the file */
+	if (cal_len > 4096 || cal_len < 0x200 || (cal_len & 1) == 1) {
+		dev_err(&pdev->dev, "eeprom has an invalid size.\n");
+		return -EINVAL;
+	}
+
 	if (*cal_data != AR5416_EEPROM_MAGIC) {
 		if (*cal_data != swab16(AR5416_EEPROM_MAGIC)) {
 			dev_err(&pdev->dev, "invalid calibration data\n");
@@ -99,38 +110,31 @@ static int ath9k_pci_fixup(struct pci_dev *pdev, const u16 *cal_data,
 	return 0;
 }
 
-static void owl_fw_cb(const struct firmware *fw, void *context)
+static void owl_rescan(struct pci_dev *pdev)
 {
-	struct pci_dev *pdev = (struct pci_dev *)context;
-	struct owl_ctx *ctx = (struct owl_ctx *)pci_get_drvdata(pdev);
-	struct pci_bus *bus;
-
-	complete(&ctx->eeprom_load);
-
-	if (!fw) {
-		dev_err(&pdev->dev, "no eeprom data received.\n");
-		goto release;
-	}
-
-	/* also note that we are doing *u16 operations on the file */
-	if (fw->size > 4096 || fw->size < 0x200 || (fw->size & 1) == 1) {
-		dev_err(&pdev->dev, "eeprom file has an invalid size.\n");
-		goto release;
-	}
-
-	if (ath9k_pci_fixup(pdev, (const u16 *)fw->data, fw->size))
-		goto release;
+	struct pci_bus *bus = pdev->bus;
 
 	pci_lock_rescan_remove();
-	bus = pdev->bus;
 	pci_stop_and_remove_bus_device(pdev);
 	/* the device should come back with the proper
 	 * ProductId. But we have to initiate a rescan.
 	 */
 	pci_rescan_bus(bus);
 	pci_unlock_rescan_remove();
+}
+
+static void owl_fw_cb(const struct firmware *fw, void *context)
+{
+	struct owl_ctx *ctx = (struct owl_ctx *)context;
+
+	complete(&ctx->eeprom_load);
 
-release:
+	if (fw) {
+		ath9k_pci_fixup(ctx->pdev, (const u16 *)fw->data, fw->size);
+		owl_rescan(ctx->pdev);
+	} else {
+		dev_err(&ctx->pdev->dev, "no eeprom data received.\n");
+	}
 	release_firmware(fw);
 }
 
@@ -152,6 +156,43 @@ static const char *owl_get_eeprom_name(struct pci_dev *pdev)
 	return eeprom_name;
 }
 
+static void owl_nvmem_work(struct work_struct *work)
+{
+	struct owl_ctx *ctx = container_of(work, struct owl_ctx, work);
+	void *buf;
+	size_t len;
+
+	complete(&ctx->eeprom_load);
+
+	buf = nvmem_cell_read(ctx->cell, &len);
+	if (!IS_ERR(buf)) {
+		ath9k_pci_fixup(ctx->pdev, buf, len);
+		kfree(buf);
+		owl_rescan(ctx->pdev);
+	} else {
+		dev_err(&ctx->pdev->dev, "no nvmem data received.\n");
+	}
+}
+
+static int owl_nvmem_probe(struct owl_ctx *ctx)
+{
+	int err;
+
+	ctx->cell = devm_nvmem_cell_get(&ctx->pdev->dev, "calibration");
+	if (IS_ERR(ctx->cell)) {
+		err = PTR_ERR(ctx->cell);
+		if (err == -ENOENT || err == -EOPNOTSUPP)
+			return 1; /* not present, try firmware_request */
+
+		return err;
+	}
+
+	INIT_WORK(&ctx->work, owl_nvmem_work);
+	schedule_work(&ctx->work);
+
+	return 0;
+}
+
 static int owl_probe(struct pci_dev *pdev,
 		     const struct pci_device_id *id)
 {
@@ -164,21 +205,27 @@ static int owl_probe(struct pci_dev *pdev,
 
 	pcim_pin_device(pdev);
 
-	eeprom_name = owl_get_eeprom_name(pdev);
-	if (!eeprom_name) {
-		dev_err(&pdev->dev, "no eeprom filename found.\n");
-		return -ENODEV;
-	}
-
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
 	init_completion(&ctx->eeprom_load);
+	ctx->pdev = pdev;
 
 	pci_set_drvdata(pdev, ctx);
+
+	err = owl_nvmem_probe(ctx);
+	if (err <= 0)
+		return err;
+
+	eeprom_name = owl_get_eeprom_name(pdev);
+	if (!eeprom_name) {
+		dev_err(&pdev->dev, "no eeprom filename found.\n");
+		return -ENODEV;
+	}
+
 	err = request_firmware_nowait(THIS_MODULE, true, eeprom_name,
-				      &pdev->dev, GFP_KERNEL, pdev, owl_fw_cb);
+				      &pdev->dev, GFP_KERNEL, ctx, owl_fw_cb);
 	if (err)
 		dev_err(&pdev->dev, "failed to request caldata (%d).\n", err);
 
-- 
2.33.0

