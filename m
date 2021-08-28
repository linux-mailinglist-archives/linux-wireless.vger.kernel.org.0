Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356A73FA60B
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Aug 2021 15:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbhH1N2D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 28 Aug 2021 09:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbhH1N17 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 28 Aug 2021 09:27:59 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C46C061756
        for <linux-wireless@vger.kernel.org>; Sat, 28 Aug 2021 06:27:08 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 79-20020a1c0452000000b002e6cf79e572so11258070wme.1
        for <linux-wireless@vger.kernel.org>; Sat, 28 Aug 2021 06:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iLQvE81eR+5NR1tm+/llRwBeJW5SU1QUf1tsFm9hUUs=;
        b=LIjfCfQvzebPNvtecMNR4FEXfFbrnZDCPTTZMDp/BPqXX12UlwYnptC1c6pvuVXGdC
         PWoWm85zjKu6DSQYPwTRfnXLahFSG1lg7deQC/WOeB1a7NNH9F8dgcztDmnVCCEPFhlI
         3E9IIHlyHir7l8s5/J+ln2O/G1FdTvDItaQpGNx4l7WzmTxBf0W2TtXWpz4pJzwPN0s2
         9eZC/78pOg4G4o5rKwkjUUynS52Exrtxl2L9i45aUWP66iB8zZPheo8ier/QeTx+JBSM
         gZ35EwvcflI/3/9ALfJJjmePRHNudKSFBugVqXdjelD9PAZ43NLIS7nVCyLO8EV5m3Dx
         VLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iLQvE81eR+5NR1tm+/llRwBeJW5SU1QUf1tsFm9hUUs=;
        b=AD4yJB4N75VZmJQRcimD796fYE8hQsxFGACCEHK/NlBp8A2e+yekgY3ZjqHmGPFHOL
         qtJsgDKF4vj4AkidUjywbz2IJddBMrwTMkm8T6IS1kRe/8bfxQnsbsTqv1PdKF6O56WV
         aZmjwmfjP+0tBpqMrumW9RZlFqRVTPxYq7/0F35/wOssxJtZC0FfP1/tnoAeM6x3lxpw
         au3Rm1LNRY2mBBeWBcMam9iuecRpmskpggRiwPqbIe1tA2pmdcBq1GyjlHM9m+9dvKwu
         QXH38T1ygZ/IfTt12ekjZonIgTFs/OJUVsl6DVpDmFtHpwTW5/5UnD4DgXKz7IV/py8c
         G4kA==
X-Gm-Message-State: AOAM531oQD2ci0exWIJ84Eej0c5Xnzme7qqzQbV4aeyzHxMKWbaV+U+J
        iF1FFvJJ78VqRMQ/04ACHxZ/ZzrM0mQ=
X-Google-Smtp-Source: ABdhPJyfBjAjledD6ifeq5JGDxEGb7sJ7UUgP1o1qLcGXVa0unWd6dYwU7Aek9vDGB3ms1UqQyJLeg==
X-Received: by 2002:a05:600c:4106:: with SMTP id j6mr772396wmi.102.1630157227017;
        Sat, 28 Aug 2021 06:27:07 -0700 (PDT)
Received: from debian64.daheim (p5b0d759d.dip0.t-ipconnect.de. [91.13.117.157])
        by smtp.gmail.com with ESMTPSA id p1sm1187783wmp.12.2021.08.28.06.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 06:27:06 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.94.2)
        (envelope-from <chunkeey@gmail.com>)
        id 1mJyMT-000C8i-M3; Sat, 28 Aug 2021 15:27:05 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Subject: [PATCH v1 2/2] ath9k: owl-loader: fetch pci init values through nvmem
Date:   Sat, 28 Aug 2021 15:27:05 +0200
Message-Id: <bc79ba1c6f6435000577bf1e5f4d7ebe18a8df97.1630157099.git.chunkeey@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <f9b732b50a3453fadf3923cc75d365bae3505fe7.1630157099.git.chunkeey@gmail.com>
References: <f9b732b50a3453fadf3923cc75d365bae3505fe7.1630157099.git.chunkeey@gmail.com>
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
reversal or unpacking)... than the current way through the
firmware_request which involves the filesystem/userspace.

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

