Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8AB322EE
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jun 2019 12:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbfFBKVu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Jun 2019 06:21:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35859 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfFBKVu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Jun 2019 06:21:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id v22so8502058wml.1
        for <linux-wireless@vger.kernel.org>; Sun, 02 Jun 2019 03:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sbZJeT9nPMblQMiYpj0OO6ZuW3ofXW6ugHOXX3Xfg0E=;
        b=F8hf9pL7JK1ijV2dfqVRJfk98EJZDJrkEjTOj4Mx0eXzu3sXlk3KnqiKn8hvMZv5aM
         u5EyK2tNBi9WWZH9npqKrLKPTaxe7V3+iDxgQVUaPbotGk/ko72lwAK1nJcJ//X86jvl
         6YJyD5MlZo81/2wDxTJoWUsdbP+Ks62P+XBxEyLh/KKE5qW+/92hq/2WL/xqSOvrJSvR
         6khEA6VZryUjgYGleFpAZPirQfUD0DXZ232M4xVU0kGvAGv9mhjHhMcTUej1Vz3rTh/H
         /T743jlqSZVWW0yPRXg48WlBDIx/jwPy8BlS3xh0GF5yRoDvfmu7xd0wXwLffChgQ2dR
         VasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sbZJeT9nPMblQMiYpj0OO6ZuW3ofXW6ugHOXX3Xfg0E=;
        b=Rf+LX8TrVRmeXs4oo+pUJcB7E8RP0GoUyRbNFe9ldZF37QsZMaP7KV0ZGYApZzD5em
         1dv8N4a8rG8HZ660383f8TrsMSDp6kiLoPBeBG7QLRV9mgpl9IRab5wjhE45FacZPp4H
         iBvYVyzBFCP/f22ccP8RiBWxgB482nd/w6dFCb38OsWNExyMrApgA+1M87l5pYiW+6Ax
         /HT/AiFSXRRW17H7aUuTvqsz2QdjJAt8F7U9gWKoTPqzPs0OZIacjTBMzqrrIVvdk9MZ
         4fXQCtZOpvpq3DyjaM4IcA5ZHVEBxhQEp0GRYALvbHjeipt7g5Q8ueYlIbFTeuPjQmlq
         UbcQ==
X-Gm-Message-State: APjAAAVIRepfCfZjK6BLZywmftixaYLc8Gyoo+xP0gqX7947NP2uW5gM
        FzX2U6wmpBmYpBe9h8K7qXU=
X-Google-Smtp-Source: APXvYqwbvKSatwC+uhNh/cvKmzyraiL10BFA9d4Ik9ln3qyPY1eUIF/TS4h0pudUEXdwPtzXK4Avwg==
X-Received: by 2002:a1c:48c5:: with SMTP id v188mr10652721wma.175.1559470906204;
        Sun, 02 Jun 2019 03:21:46 -0700 (PDT)
Received: from debian64.daheim (p4FD09A91.dip0.t-ipconnect.de. [79.208.154.145])
        by smtp.gmail.com with ESMTPSA id s8sm21565855wra.55.2019.06.02.03.21.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 02 Jun 2019 03:21:45 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.92)
        (envelope-from <chunkeey@gmail.com>)
        id 1hXNcW-0004Wk-EJ; Sun, 02 Jun 2019 12:21:44 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        linux-wireless@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC PATCH] ath9k: integrate AR92XX pci fixup code
Date:   Sun,  2 Jun 2019 12:21:44 +0200
Message-Id: <20190602102144.17360-1-chunkeey@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some devices (like the Cisco Meraki Z1 Cloud Managed Teleworker Gateway)
need to be able to initialize the PCIe wifi device. Normally, this is done
during the early stages of booting linux, because the necessary init code
is read from the memory mapped SPI and passed to pci_enable_ath9k_fixup.
However, this isn't possible for devices which have the init code for the
Atheros chip stored on NAND in an UBI volume. Hence, this module can be
used to initialize the chip when the user-space is ready to extract the
init code.

Martin Blumenstingl prodived the following fixes:
owl-loader: add support for OWL emulation PCI devices
owl-loader: don't re-scan the bus when ath9k_pci_fixup failed
owl-loader: use dev_* instead of pr_* logging functions
owl-loader: auto-generate the eeprom filename as fallback
owl-loader: add a debug message when swapping the eeprom data
owl-loader: add missing newlines in log messages

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/net/wireless/ath/ath9k/Kconfig |  15 ++
 drivers/net/wireless/ath/ath9k/ath9k.h |   1 +
 drivers/net/wireless/ath/ath9k/pci.c   | 252 ++++++++++++++++++++++++-
 3 files changed, 266 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/Kconfig b/drivers/net/wireless/ath/ath9k/Kconfig
index a1ef8769983a..25b791389816 100644
--- a/drivers/net/wireless/ath/ath9k/Kconfig
+++ b/drivers/net/wireless/ath/ath9k/Kconfig
@@ -157,6 +157,21 @@ config ATH9K_PCOEM
 	depends on ATH9K
 	default y
 
+config ATH9K_PCI_NO_EEPROM
+	bool "Atheros ath9k support for EEPROM-less chips"
+	depends on ATH9K_PCI
+	default n
+	help
+	 Say Y to support AR92XX-generation of ath9k PCI(e) WiFi chips, which
+	 have their initialization data (which contains the PCI Device ID!)
+	 stored together with the calibration data out of reach for the ath9k
+	 chip.
+
+	 These devices are usually various network appliances, routers or
+	 access Points and such.
+
+	 If unsure say N.
+
 config ATH9K_HTC
        tristate "Atheros HTC based wireless cards support"
        depends on USB && MAC80211
diff --git a/drivers/net/wireless/ath/ath9k/ath9k.h b/drivers/net/wireless/ath/ath9k/ath9k.h
index a412b352182c..ec649446421b 100644
--- a/drivers/net/wireless/ath/ath9k/ath9k.h
+++ b/drivers/net/wireless/ath/ath9k/ath9k.h
@@ -959,6 +959,7 @@ void ath_ant_comb_scan(struct ath_softc *sc, struct ath_rx_status *rs);
 #define ATH9K_PCI_NO_PLL_PWRSAVE  0x0200
 #define ATH9K_PCI_KILLER          0x0400
 #define ATH9K_PCI_LED_ACT_HI      0x0800
+#define ATH9K_PCI_NO_EEPROM       0x1000
 
 /*
  * Default cache line size, in bytes.
diff --git a/drivers/net/wireless/ath/ath9k/pci.c b/drivers/net/wireless/ath/ath9k/pci.c
index 92b2dd396436..53a16e961055 100644
--- a/drivers/net/wireless/ath/ath9k/pci.c
+++ b/drivers/net/wireless/ath/ath9k/pci.c
@@ -19,7 +19,11 @@
 #include <linux/nl80211.h>
 #include <linux/pci.h>
 #include <linux/module.h>
+#include <linux/firmware.h>
+#include <linux/completion.h>
+#include <linux/ath9k_platform.h>
 #include "ath9k.h"
+#include "eeprom.h"
 
 extern int ath9k_use_msi;
 
@@ -774,6 +778,17 @@ static const struct pci_device_id ath_pci_id_table[] = {
 	  .driver_data = ATH9K_PCI_BT_ANT_DIV },
 #endif
 
+#ifdef CONFIG_ATH9K_PCI_NO_EEPROM
+	/* If a physical EEPROM or OTP is not used (such as for an integrated
+	 * access point), the device responds to bus probing with default
+	 * hardware deviceID and subvendorDeviceID information.
+	 */
+	{ PCI_VDEVICE(ATHEROS, 0xff1c),
+	  .driver_data = ATH9K_PCI_NO_EEPROM }, /* PCIe */
+	{ PCI_VDEVICE(ATHEROS, 0xff1d),
+	  .driver_data = ATH9K_PCI_NO_EEPROM }, /* PCI */
+#endif /* CONFIG_ATH9K_PCI_NO_EEPROM */
+
 	{ 0 }
 };
 
@@ -882,6 +897,228 @@ static const struct ath_bus_ops ath_pci_bus_ops = {
 	.aspm_init = ath_pci_aspm_init,
 };
 
+#ifdef CONFIG_ATH9K_PCI_NO_EEPROM
+
+struct ath_pci_fixup_ctx {
+	struct completion eeprom_load;
+};
+
+#define EEPROM_FILENAME_LEN 100
+/* AR5416_EEPROM_MAGIC changes depending on target endian */
+#define ATH_PCI_FIXUP_MAGIC 0xa55a
+
+static int ath_pci_fixup(struct pci_dev *pdev, const u16 *cal_data,
+			 size_t cal_len)
+{
+	void __iomem *mem;
+	const void *cal_end = (void *)cal_data + cal_len;
+	const struct {
+		u16 reg;
+		u16 low_val;
+		u16 high_val;
+	} __packed * data;
+	u16 cmd;
+	u32 bar0;
+	bool swap_needed = false;
+
+	if (*cal_data != ATH_PCI_FIXUP_MAGIC) {
+		if (*cal_data != swab16(ATH_PCI_FIXUP_MAGIC)) {
+			dev_err(&pdev->dev, "invalid calibration data\n");
+			return -EINVAL;
+		}
+
+		dev_dbg(&pdev->dev, "calibration data needs swapping\n");
+		swap_needed = true;
+	}
+
+	dev_info(&pdev->dev, "fixup device configuration\n");
+
+	mem = pcim_iomap(pdev, 0, 0);
+	if (!mem) {
+		dev_err(&pdev->dev, "ioremap error\n");
+		return -EINVAL;
+	}
+
+	pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &bar0);
+	pci_write_config_dword(pdev, PCI_BASE_ADDRESS_0,
+			       pci_resource_start(pdev, 0));
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	cmd |= PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY;
+	pci_write_config_word(pdev, PCI_COMMAND, cmd);
+
+	/* set pointer to first reg address */
+	for (data = (const void *)(cal_data + 3);
+	     (const void *)data <= cal_end && data->reg != (u16)~0;
+	     data++) {
+		u32 val;
+		u16 reg;
+
+		reg = data->reg;
+		val = data->low_val;
+		val |= ((u32)data->high_val) << 16;
+
+		if (swap_needed) {
+			reg = swab16(reg);
+			val = swahb32(val);
+		}
+
+		__raw_writel(val, mem + reg);
+		usleep_range(100, 120);
+	}
+
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	cmd &= ~(PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY);
+	pci_write_config_word(pdev, PCI_COMMAND, cmd);
+
+	pci_write_config_dword(pdev, PCI_BASE_ADDRESS_0, bar0);
+	pcim_iounmap(pdev, mem);
+
+	pci_disable_device(pdev);
+
+	return 0;
+}
+
+static void ath_pci_fixup_fw_cb(const struct firmware *fw, void *context)
+{
+	struct pci_dev *pdev = (struct pci_dev *)context;
+	struct ath_pci_fixup_ctx *ctx;
+	struct ath9k_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct pci_bus *bus;
+
+	ctx = (struct ath_pci_fixup_ctx *)pci_get_drvdata(pdev);
+	complete(&ctx->eeprom_load);
+
+	if (!fw) {
+		dev_err(&pdev->dev, "no eeprom data received.\n");
+		goto release;
+	}
+
+	/* also note that we are doing *u16 operations on the file */
+	if (fw->size > sizeof(pdata->eeprom_data) || fw->size < 0x200 ||
+	    (fw->size & 1) == 1) {
+		dev_err(&pdev->dev, "eeprom file has an invalid size.\n");
+		goto release;
+	}
+
+	if (pdata) {
+		memcpy(pdata->eeprom_data, fw->data, fw->size);
+
+		/* eeprom has been successfully loaded - pass the data to ath9k
+		 * but remove the eeprom_name, so it doesn't try to load it too.
+		 */
+		pdata->eeprom_name = NULL;
+	}
+
+	if (ath_pci_fixup(pdev, (const u16 *)fw->data, fw->size))
+		goto release;
+
+	pci_lock_rescan_remove();
+	bus = pdev->bus;
+	pci_stop_and_remove_bus_device(pdev);
+	/* the device should come back with the proper
+	 * ProductId. But we have to initiate a rescan.
+	 */
+	pci_rescan_bus(bus);
+	pci_unlock_rescan_remove();
+
+release:
+	release_firmware(fw);
+}
+
+static const char *ath_pci_fixup_get_eeprom_name(struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ath9k_platform_data *pdata;
+	char *eeprom_name;
+
+	/* try the existing platform data first */
+	pdata = dev_get_platdata(dev);
+	if (pdata && pdata->eeprom_name)
+		return pdata->eeprom_name;
+
+	dev_dbg(dev, "using auto-generated eeprom filename\n");
+
+	eeprom_name = devm_kzalloc(dev, EEPROM_FILENAME_LEN, GFP_KERNEL);
+	if (!eeprom_name)
+		return NULL;
+
+	/* this should match the pattern used in init.c */
+	scnprintf(eeprom_name, EEPROM_FILENAME_LEN, "ath9k-eeprom-pci-%s.bin",
+		  dev_name(dev));
+
+	return eeprom_name;
+}
+
+static int ath_pci_fixup_probe(struct pci_dev *pdev,
+			       const struct pci_device_id *id)
+{
+	struct ath_pci_fixup_ctx *ctx;
+	const char *eeprom_name;
+	int err = 0;
+
+	/* only handle devices that do not have a support EEPROM */
+	if (!(id->driver_data & ATH9K_PCI_NO_EEPROM))
+		return 0;
+
+	pcim_pin_device(pdev);
+
+	eeprom_name = ath_pci_fixup_get_eeprom_name(pdev);
+	if (!eeprom_name) {
+		dev_err(&pdev->dev, "no eeprom filename found.\n");
+		return -ENODEV;
+	}
+
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	init_completion(&ctx->eeprom_load);
+
+	pci_set_drvdata(pdev, ctx);
+	err = request_firmware_nowait(THIS_MODULE, true, eeprom_name,
+				      &pdev->dev, GFP_KERNEL, pdev,
+				      ath_pci_fixup_fw_cb);
+	if (err)
+		dev_err(&pdev->dev, "failed to request caldata (%d).\n", err);
+
+	/* Use the return code "1" as a way to tell the ath_pci_probe()
+	 * function that we will be taking an alternative code-path from
+	 * now on. Once the device has the proper ProductIDs it will
+	 * go through ath_pci_probe() again.
+	 */
+	return err < 0 ? err : 1;
+}
+
+static bool ath_pci_fixup_remove(struct pci_dev *pdev)
+{
+	const struct pci_device_id *id;
+	struct ath_pci_fixup_ctx *ctx;
+
+	id = pci_match_id(ath_pci_id_table, pdev);
+	if (!id || !(id->driver_data & ATH9K_PCI_NO_EEPROM))
+		return false;
+
+	ctx = pci_get_drvdata(pdev);
+	if (ctx) {
+		wait_for_completion(&ctx->eeprom_load);
+		pci_set_drvdata(pdev, NULL);
+	}
+
+	return true;
+}
+#else
+static int ath_pci_fixup_probe(struct pci_dev __maybe_unused *pdev,
+			       const struct pci_device_id __maybe_unused *id)
+{
+	return 0;
+}
+
+static bool ath_pci_fixup_remove(struct pci_dev __maybe_unused *pdev)
+{
+	return false;
+}
+#endif /* CONFIG_ATH9K_PCI_NO_EEPROM */
+
 static int ath_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct ath_softc *sc;
@@ -895,6 +1132,12 @@ static int ath_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (pcim_enable_device(pdev))
 		return -EIO;
 
+	ret = ath_pci_fixup_probe(pdev, id);
+	if (ret < 0)
+		return ret;
+	if (ret == 1)
+		return 0; /* ath_pci_fixup_probe took over */
+
 	ret =  pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
 	if (ret) {
 		pr_err("32-bit DMA not available\n");
@@ -1007,9 +1250,14 @@ static int ath_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 static void ath_pci_remove(struct pci_dev *pdev)
 {
-	struct ieee80211_hw *hw = pci_get_drvdata(pdev);
-	struct ath_softc *sc = hw->priv;
+	struct ieee80211_hw *hw;
+	struct ath_softc *sc;
 
+	if (ath_pci_fixup_remove(pdev))
+		return;
+
+	hw = pci_get_drvdata(pdev);
+	sc = hw->priv;
 	if (!is_ath9k_unloaded)
 		sc->sc_ah->ah_flags |= AH_UNPLUGGED;
 	ath9k_deinit_device(sc);
-- 
2.20.1

