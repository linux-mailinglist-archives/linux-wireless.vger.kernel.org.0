Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A75F860B35
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2019 19:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfGERxS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Jul 2019 13:53:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41938 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfGERxS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Jul 2019 13:53:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so10702703wrm.8
        for <linux-wireless@vger.kernel.org>; Fri, 05 Jul 2019 10:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hVoCO3eGxvJosH7E25xavPJDi0Yj4PbMzWxlh8ECdjU=;
        b=MK0yEwzn53mL9/JuakMsJaY+/c4YjTODmxBW+AXlrhSvT5jZD6sd6Iy68OvTXsnXZC
         J7oImHw6nBQUi0WN5USdGi+ZddnoU8qC6VFfuIsE66hb5/n7+gchmCE8mmeRnKrRh3z8
         Vn/1OpLV9rc4UvU5gHqmIc28LGt9C+/ILTp/GBNuUAykRHj0rdaVmJvmAQQk1Ib6OTJu
         w2+WPCu8UYmK4DkK1NnNCm4IoUEK3Zl02r7R0Z0Qu4ZqxFlg6+a2dzJSEer8i21GKlyx
         r/KCU5M07m1z0erWd85bsmxMm+hvnJ3ixYXjGdGrY/j9JLHAjNns/pgvAiqg2h0iQkNj
         gDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hVoCO3eGxvJosH7E25xavPJDi0Yj4PbMzWxlh8ECdjU=;
        b=a7vY4wEI5RkI6Olx30Hh7TuiC3vxRzRTBvkpT9sopPhUoFhsNi3f1gcCLskmvKnq4H
         EQ+cyEOOs0dgGRTpDuqoRUuwOnjFm+6IqO8ZEDUrz/EnmVs0lt5vwtQ6fR6Ieet9Nu9u
         bbcYW299Ho7pd3FyIlHY9DIujmkJcf/hxJBKSvre3nMQGpn2pEkHOVPy6Yd0zRAkY8kz
         Ey94UTeCpDkNoBSM18Mi5eJEvvrkncsl1Aik1vfAKweLdACvW18ckVdZpBZ1zSkpyKYE
         EniGaMlidcBeGJefaoTL5XQrhpOoIYTNFUGAYOmbUu4ikLaMWQ2ZAUstWxgRLi4VwXqN
         yhqQ==
X-Gm-Message-State: APjAAAX3lTLAEM7jzklyKWuZAD9oPfNzUjk518aLaiWJ+i+iL8Ncf+mu
        Awdm07bu8WGB+O/OM6KZHto=
X-Google-Smtp-Source: APXvYqzkfpInj0K6aq85h0CTZwRQYdkPOfGkwSKI+vEj7yLDk8gKWcaoyl8wAZMzLqQYWBMJQe0t5Q==
X-Received: by 2002:a5d:53c2:: with SMTP id a2mr3443887wrw.8.1562349194776;
        Fri, 05 Jul 2019 10:53:14 -0700 (PDT)
Received: from debian64.daheim (p5B0D78D1.dip0.t-ipconnect.de. [91.13.120.209])
        by smtp.gmail.com with ESMTPSA id v124sm4388013wmf.23.2019.07.05.10.53.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 10:53:13 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.92)
        (envelope-from <chunkeey@gmail.com>)
        id 1hjSOX-00054w-2M; Fri, 05 Jul 2019 19:53:13 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Julian Calaby <julian.calaby@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v4] ath9k: add loader for AR92XX (and older) pci(e)
Date:   Fri,  5 Jul 2019 19:53:13 +0200
Message-Id: <20190705175313.19482-1-chunkeey@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Atheros cards with a AR92XX generation (and older) chip usually
store their pci(e) initialization vectors on an external eeprom chip.
However these chips technically don't need the eeprom chip attached,
the AR9280 Datasheet in section "6.1.2 DEVICE_ID" describes that
"... if the EEPROM content is not valid, a value of 0xFF1C returns
when read from the register". So, they will show up on the system's
pci bus. However in that state, ath9k can't load, since it relies
on having the correct pci-id, otherwise it doesn't know what chip it
actually is. This happens on many embedded devices like routers
and accesspoint since they want to keep the BOM low and store the
pci(e) initialization vectors together with the calibration data
on the system's FLASH, which is out of reach of the ath9k chip.

Furthermore, Some devices (like the Cisco Meraki Z1 Cloud Managed
Teleworker Gateway) need to be able to initialize the PCIe wifi device.
Normally, this should be done as a pci quirk during the early stages of
booting linux. However, this isn't possible for devices which have the
init code for the Atheros chip stored on NAND in an UBI volume.
Hence, this module can be used to initialize the chip when the
user-space is ready to extract the init code.

Martin Blumenstingl prodived the following fixes:
owl-loader: add support for OWL emulation PCI devices
owl-loader: don't re-scan the bus when ath9k_pci_fixup failed
owl-loader: use dev_* instead of pr_* logging functions
owl-loader: auto-generate the eeprom filename as fallback
owl-loader: add a debug message when swapping the eeprom data
owl-loader: add missing newlines in log messages

Reviewed-by: Julian Calaby <julian.calaby@gmail.com>
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

---
v4: copy SPDX license identifier from "ath: fix SPDX tags" (ISC)
    <https://www.spinics.net/lists/linux-wireless/msg187511.html>
    and use the MODULE_LICENSE from ath9k (Dual BSD/GPL) to match
    the ath9k module behavior 1:1.

v3: changed module description

v2: address Julian Calaby's comments:
    - make it a separate driver again (much like OpenWrt)
    - remove ar71xx leftovers (pdata)
---
 drivers/net/wireless/ath/ath9k/Kconfig        |  16 ++
 drivers/net/wireless/ath/ath9k/Makefile       |   2 +
 .../wireless/ath/ath9k/ath9k_pci_owl_loader.c | 215 ++++++++++++++++++
 3 files changed, 233 insertions(+)
 create mode 100644 drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c

diff --git a/drivers/net/wireless/ath/ath9k/Kconfig b/drivers/net/wireless/ath/ath9k/Kconfig
index 5601cfd6a293..2d1247f61297 100644
--- a/drivers/net/wireless/ath/ath9k/Kconfig
+++ b/drivers/net/wireless/ath/ath9k/Kconfig
@@ -157,6 +157,22 @@ config ATH9K_PCOEM
 	depends on ATH9K
 	default y
 
+config ATH9K_PCI_NO_EEPROM
+	tristate "Atheros ath9k pci loader for EEPROM-less chips"
+	depends on ATH9K_PCI
+	default n
+	help
+	 This separate driver provides a loader in order to support the
+	 AR500X to AR92XX-generation of ath9k PCI(e) WiFi chips, which have
+	 their initialization data (which contains the real PCI Device ID
+	 that ath9k will need) stored together with the calibration data out
+	 of reach for the ath9k chip.
+
+	 These devices are usually various network appliances, routers or
+	 access Points and such.
+
+	 If unsure say N.
+
 config ATH9K_HTC
        tristate "Atheros HTC based wireless cards support"
        depends on USB && MAC80211
diff --git a/drivers/net/wireless/ath/ath9k/Makefile b/drivers/net/wireless/ath/ath9k/Makefile
index 15af0a836925..eff94bcd1f0a 100644
--- a/drivers/net/wireless/ath/ath9k/Makefile
+++ b/drivers/net/wireless/ath/ath9k/Makefile
@@ -77,3 +77,5 @@ ath9k_htc-y +=	htc_hst.o \
 ath9k_htc-$(CONFIG_ATH9K_HTC_DEBUGFS) += htc_drv_debug.o
 
 obj-$(CONFIG_ATH9K_HTC) += ath9k_htc.o
+
+obj-$(CONFIG_ATH9K_PCI_NO_EEPROM) += ath9k_pci_owl_loader.o
diff --git a/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c b/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
new file mode 100644
index 000000000000..159490f5a111
--- /dev/null
+++ b/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: ISC
+/* Initialize Owl Emulation Devices
+ *
+ * Copyright (C) 2016 Christian Lamparter <chunkeey@gmail.com>
+ * Copyright (C) 2016 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+ *
+ * Some devices (like the Cisco Meraki Z1 Cloud Managed Teleworker Gateway)
+ * need to be able to initialize the PCIe wifi device. Normally, this is done
+ * during the early stages as a pci quirk.
+ * However, this isn't possible for devices which have the init code for the
+ * Atheros chip stored on UBI Volume on NAND. Hence, this module can be used to
+ * initialize the chip when the user-space is ready to extract the init code.
+ */
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/completion.h>
+#include <linux/etherdevice.h>
+#include <linux/firmware.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/ath9k_platform.h>
+
+struct owl_ctx {
+	struct completion eeprom_load;
+};
+
+#define EEPROM_FILENAME_LEN 100
+
+#define AR5416_EEPROM_MAGIC 0xa55a
+
+static int ath9k_pci_fixup(struct pci_dev *pdev, const u16 *cal_data,
+			   size_t cal_len)
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
+	if (*cal_data != AR5416_EEPROM_MAGIC) {
+		if (*cal_data != swab16(AR5416_EEPROM_MAGIC)) {
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
+static void owl_fw_cb(const struct firmware *fw, void *context)
+{
+	struct pci_dev *pdev = (struct pci_dev *)context;
+	struct owl_ctx *ctx = (struct owl_ctx *)pci_get_drvdata(pdev);
+	struct pci_bus *bus;
+
+	complete(&ctx->eeprom_load);
+
+	if (!fw) {
+		dev_err(&pdev->dev, "no eeprom data received.\n");
+		goto release;
+	}
+
+	/* also note that we are doing *u16 operations on the file */
+	if (fw->size > 4096 || fw->size < 0x200 || (fw->size & 1) == 1) {
+		dev_err(&pdev->dev, "eeprom file has an invalid size.\n");
+		goto release;
+	}
+
+	if (ath9k_pci_fixup(pdev, (const u16 *)fw->data, fw->size))
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
+static const char *owl_get_eeprom_name(struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
+	char *eeprom_name;
+
+	dev_dbg(dev, "using auto-generated eeprom filename\n");
+
+	eeprom_name = devm_kzalloc(dev, EEPROM_FILENAME_LEN, GFP_KERNEL);
+	if (!eeprom_name)
+		return NULL;
+
+	/* this should match the pattern used in ath9k/init.c */
+	scnprintf(eeprom_name, EEPROM_FILENAME_LEN, "ath9k-eeprom-pci-%s.bin",
+		  dev_name(dev));
+
+	return eeprom_name;
+}
+
+static int owl_probe(struct pci_dev *pdev,
+		     const struct pci_device_id *id)
+{
+	struct owl_ctx *ctx;
+	const char *eeprom_name;
+	int err = 0;
+
+	if (pcim_enable_device(pdev))
+		return -EIO;
+
+	pcim_pin_device(pdev);
+
+	eeprom_name = owl_get_eeprom_name(pdev);
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
+				      &pdev->dev, GFP_KERNEL, pdev, owl_fw_cb);
+	if (err)
+		dev_err(&pdev->dev, "failed to request caldata (%d).\n", err);
+
+	return err;
+}
+
+static void owl_remove(struct pci_dev *pdev)
+{
+	struct owl_ctx *ctx = pci_get_drvdata(pdev);
+
+	if (ctx) {
+		wait_for_completion(&ctx->eeprom_load);
+		pci_set_drvdata(pdev, NULL);
+	}
+}
+
+static const struct pci_device_id owl_pci_table[] = {
+	{ PCI_VDEVICE(ATHEROS, 0xff1c) }, /* PCIe */
+	{ PCI_VDEVICE(ATHEROS, 0xff1d) }, /* PCI */
+	{ },
+};
+MODULE_DEVICE_TABLE(pci, owl_pci_table);
+
+static struct pci_driver owl_driver = {
+	.name		= KBUILD_MODNAME,
+	.id_table	= owl_pci_table,
+	.probe		= owl_probe,
+	.remove		= owl_remove,
+};
+module_pci_driver(owl_driver);
+MODULE_AUTHOR("Christian Lamparter <chunkeey@gmail.com>");
+MODULE_DESCRIPTION("External EEPROM data loader for Atheros AR500X to AR92XX");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.20.1

