Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A926C11CF
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 13:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjCTMYB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 08:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjCTMX7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 08:23:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA0228845
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 05:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679314978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vZb895osl+CN2z9eTj8NEZVzpb+fx5aExuqMfhHLR9w=;
        b=QaZjR3K2hATOF1oW+rPg6HpgZhpUM48Shtn7nkRQRVJhhcPykJx08msFVev9namEvKOxRO
        mk2OZa4Efp0T+UolSJYPa/pu+ccSsnoso9xMa1SQmQV9zCoZF8Ei4cXRGuIwrfBzwFpC0T
        UwHqhNphsqhNCK9cGqFseQUejT+j+jU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-bbsxfDOKP3-TZ5aWvYPdiw-1; Mon, 20 Mar 2023 08:22:55 -0400
X-MC-Unique: bbsxfDOKP3-TZ5aWvYPdiw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CD26299E741;
        Mon, 20 Mar 2023 12:22:55 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A3E92027047;
        Mon, 20 Mar 2023 12:22:53 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2] wifi: brcmfmac: Fix SDIO suspend/resume regression
Date:   Mon, 20 Mar 2023 13:22:52 +0100
Message-Id: <20230320122252.240070-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

After commit 92cadedd9d5f ("brcmfmac: Avoid keeping power to SDIO card
unless WOWL is used"), the wifi adapter by default is turned off on suspend
and then re-probed on resume.

In at least 2 model x86/acpi tablets with brcmfmac43430a1 wifi adapters,
the newly added re-probe on resume fails like this:

 brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
 ieee80211 phy1: brcmf_bus_started: failed: -110
 ieee80211 phy1: brcmf_attach: dongle is not responding: err=-110
 brcmfmac: brcmf_sdio_firmware_callback: brcmf_attach failed

It seems this specific brcmfmac model does not like being reprobed without
it actually being turned off first.

And the adapter is not being turned off during suspend because of
commit f0992ace680c ("brcmfmac: prohibit ACPI power management for brcmfmac
driver").

Now that the driver is being reprobed on resume, the disabling of ACPI
pm is no longer necessary, except when WOWL is used (in which case there
is no-reprobe).

Move the dis-/en-abling of ACPI pm to brcmf_sdio_wowl_config(), this fixes
the brcmfmac43430a1 suspend/resume regression and should help save some
power when suspended.

This change means that the code now also may re-enable ACPI pm when WOWL
gets disabled. ACPI pm should only be re-enabled if it was enabled by
the ACPI core originally. Add a brcmf_sdiod_acpi_save_power_manageable()
to save the original state for this.

This has been tested on the following devices:

Asus T100TA                brcmfmac43241b4-sdio
Acer Iconia One 7 B1-750   brcmfmac43340-sdio
Chuwi Hi8                  brcmfmac43430a0-sdio
Chuwi Hi8                  brcmfmac43430a1-sdio

(the Asus T100TA is the device for which the prohibiting of ACPI pm
 was originally added)

Fixes: 92cadedd9d5f ("brcmfmac: Avoid keeping power to SDIO card unless WOWL is used")
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Drop no longer used "struct device *dev" local variable from
  brcmf_ops_sdio_probe() - Reported-by: kernel test robot <lkp@intel.com>
---
- Note this is a resend of v2 with Kalle Valo/s email address fixed
---
 .../broadcom/brcm80211/brcmfmac/bcmsdh.c      | 36 +++++++++++++------
 .../broadcom/brcm80211/brcmfmac/sdio.h        |  2 ++
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index b7c918f241c9..65d4799a5658 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -994,15 +994,34 @@ static const struct sdio_device_id brcmf_sdmmc_ids[] = {
 MODULE_DEVICE_TABLE(sdio, brcmf_sdmmc_ids);
 
 
-static void brcmf_sdiod_acpi_set_power_manageable(struct device *dev,
-						  int val)
+static void brcmf_sdiod_acpi_save_power_manageable(struct brcmf_sdio_dev *sdiodev)
 {
 #if IS_ENABLED(CONFIG_ACPI)
 	struct acpi_device *adev;
 
-	adev = ACPI_COMPANION(dev);
+	adev = ACPI_COMPANION(&sdiodev->func1->dev);
 	if (adev)
-		adev->flags.power_manageable = 0;
+		sdiodev->func1_power_manageable = adev->flags.power_manageable;
+
+	adev = ACPI_COMPANION(&sdiodev->func2->dev);
+	if (adev)
+		sdiodev->func2_power_manageable = adev->flags.power_manageable;
+#endif
+}
+
+static void brcmf_sdiod_acpi_set_power_manageable(struct brcmf_sdio_dev *sdiodev,
+						  int enable)
+{
+#if IS_ENABLED(CONFIG_ACPI)
+	struct acpi_device *adev;
+
+	adev = ACPI_COMPANION(&sdiodev->func1->dev);
+	if (adev)
+		adev->flags.power_manageable = enable ? sdiodev->func1_power_manageable : 0;
+
+	adev = ACPI_COMPANION(&sdiodev->func2->dev);
+	if (adev)
+		adev->flags.power_manageable = enable ? sdiodev->func2_power_manageable : 0;
 #endif
 }
 
@@ -1012,7 +1031,6 @@ static int brcmf_ops_sdio_probe(struct sdio_func *func,
 	int err;
 	struct brcmf_sdio_dev *sdiodev;
 	struct brcmf_bus *bus_if;
-	struct device *dev;
 
 	brcmf_dbg(SDIO, "Enter\n");
 	brcmf_dbg(SDIO, "Class=%x\n", func->class);
@@ -1020,14 +1038,9 @@ static int brcmf_ops_sdio_probe(struct sdio_func *func,
 	brcmf_dbg(SDIO, "sdio device ID: 0x%04x\n", func->device);
 	brcmf_dbg(SDIO, "Function#: %d\n", func->num);
 
-	dev = &func->dev;
-
 	/* Set MMC_QUIRK_LENIENT_FN0 for this card */
 	func->card->quirks |= MMC_QUIRK_LENIENT_FN0;
 
-	/* prohibit ACPI power management for this device */
-	brcmf_sdiod_acpi_set_power_manageable(dev, 0);
-
 	/* Consume func num 1 but dont do anything with it. */
 	if (func->num == 1)
 		return 0;
@@ -1059,6 +1072,7 @@ static int brcmf_ops_sdio_probe(struct sdio_func *func,
 	dev_set_drvdata(&sdiodev->func1->dev, bus_if);
 	sdiodev->dev = &sdiodev->func1->dev;
 
+	brcmf_sdiod_acpi_save_power_manageable(sdiodev);
 	brcmf_sdiod_change_state(sdiodev, BRCMF_SDIOD_DOWN);
 
 	brcmf_dbg(SDIO, "F2 found, calling brcmf_sdiod_probe...\n");
@@ -1124,6 +1138,8 @@ void brcmf_sdio_wowl_config(struct device *dev, bool enabled)
 
 	if (sdiodev->settings->bus.sdio.oob_irq_supported ||
 	    pm_caps & MMC_PM_WAKE_SDIO_IRQ) {
+		/* Stop ACPI from turning off the device when wowl is enabled */
+		brcmf_sdiod_acpi_set_power_manageable(sdiodev, !enabled);
 		sdiodev->wowl_enabled = enabled;
 		brcmf_dbg(SDIO, "Configuring WOWL, enabled=%d\n", enabled);
 		return;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
index b76d34d36bde..0d18ed15b403 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
@@ -188,6 +188,8 @@ struct brcmf_sdio_dev {
 	char nvram_name[BRCMF_FW_NAME_LEN];
 	char clm_name[BRCMF_FW_NAME_LEN];
 	bool wowl_enabled;
+	bool func1_power_manageable;
+	bool func2_power_manageable;
 	enum brcmf_sdiod_state state;
 	struct brcmf_sdiod_freezer *freezer;
 	const struct firmware *clm_fw;
-- 
2.39.1

