Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDF724371A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Aug 2020 11:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgHMJEk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Aug 2020 05:04:40 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:63560 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbgHMJEj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Aug 2020 05:04:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597309478; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=WSglx3V/Rl6H9fEQf/IcdTPBV6jpZw60LbPeLH4Y7v4=; b=ZiaipPXlzKzF4ETR7PFqHCraz98sV6opB4/RTIFPHZ+qgKAsrVG4FuYkNeOdWWTt8nurRFeB
 oYtwKloZCzZ0Vg2BOJjs2amiTAYfVp5OgpPHdvjwwcIzGE5uuItnqP2Zz0BEl9FdYuG2gGnX
 EzCM9XV9HSICyB4ZqETWstcoqlQ=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f350225d48d4625ca9bd332 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 13 Aug 2020 09:04:37
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 01247C433C6; Thu, 13 Aug 2020 09:04:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 52392C433C9;
        Thu, 13 Aug 2020 09:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 52392C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 04/10] ath11k: add simple PCI client driver for QCA6390 chipset
Date:   Thu, 13 Aug 2020 12:04:20 +0300
Message-Id: <1597309466-19688-5-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597309466-19688-1-git-send-email-kvalo@codeaurora.org>
References: <1597309466-19688-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Govind Singh <govinds@codeaurora.org>

QCA6390 is a PCI based 11ax chipset, split AHB into own kernel module
ath11k_ahb.ko and add ath11k_pci.ko for PCI devices.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Govind Singh <govinds@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/Kconfig  | 12 +++++
 drivers/net/wireless/ath/ath11k/Makefile |  7 ++-
 drivers/net/wireless/ath/ath11k/ahb.c    |  2 +-
 drivers/net/wireless/ath/ath11k/ce.c     |  2 +
 drivers/net/wireless/ath/ath11k/core.c   |  7 +++
 drivers/net/wireless/ath/ath11k/debug.c  |  5 ++
 drivers/net/wireless/ath/ath11k/dp.c     |  1 +
 drivers/net/wireless/ath/ath11k/hal.c    |  1 +
 drivers/net/wireless/ath/ath11k/hif.h    |  4 ++
 drivers/net/wireless/ath/ath11k/pci.c    | 88 ++++++++++++++++++++++++++++++++
 10 files changed, 127 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/pci.c

diff --git a/drivers/net/wireless/ath/ath11k/Kconfig b/drivers/net/wireless/ath/ath11k/Kconfig
index 0fd44d83e0e9..2a792ddd6fea 100644
--- a/drivers/net/wireless/ath/ath11k/Kconfig
+++ b/drivers/net/wireless/ath/ath11k/Kconfig
@@ -12,6 +12,18 @@ config ATH11K
 
 	  If you choose to build a module, it'll be called ath11k.
 
+config ATH11K_AHB
+	tristate "Atheros ath11k AHB support"
+	depends on ATH11K
+	help
+	  This module adds support for AHB bus
+
+config ATH11K_PCI
+	tristate "Atheros ath11k PCI support"
+	depends on ATH11K && PCI
+	help
+	  This module adds support for PCIE bus
+
 config ATH11K_DEBUG
 	bool "QCA ath11k debugging"
 	depends on ATH11K
diff --git a/drivers/net/wireless/ath/ath11k/Makefile b/drivers/net/wireless/ath/ath11k/Makefile
index ee13a3becbcf..4d1807f52d92 100644
--- a/drivers/net/wireless/ath/ath11k/Makefile
+++ b/drivers/net/wireless/ath/ath11k/Makefile
@@ -4,7 +4,6 @@ ath11k-y += core.o \
 	    hal.o \
 	    hal_tx.o \
 	    hal_rx.o \
-	    ahb.o \
 	    wmi.o \
 	    mac.o \
 	    reg.o \
@@ -25,5 +24,11 @@ ath11k-$(CONFIG_ATH11K_TRACING) += trace.o
 ath11k-$(CONFIG_THERMAL) += thermal.o
 ath11k-$(CONFIG_ATH11K_SPECTRAL) += spectral.o
 
+obj-$(CONFIG_ATH11K_AHB) += ath11k_ahb.o
+ath11k_ahb-y += ahb.o
+
+obj-$(CONFIG_ATH11K_PCI) += ath11k_pci.o
+ath11k_pci-y += pci.o
+
 # for tracing framework to find trace.h
 CFLAGS_trace.o := -I$(src)
diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index e3228a4f485f..042019de0a81 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -952,5 +952,5 @@ static void ath11k_ahb_exit(void)
 }
 module_exit(ath11k_ahb_exit);
 
-MODULE_DESCRIPTION("Driver support for Qualcomm Technologies 802.11ax wireless chip");
+MODULE_DESCRIPTION("Driver support for Qualcomm Technologies 802.11ax WLAN AHB devices");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index cdd40c8fc867..7ae1bef0ab30 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -752,6 +752,7 @@ void ath11k_ce_free_pipes(struct ath11k_base *ab)
 		}
 	}
 }
+EXPORT_SYMBOL(ath11k_ce_free_pipes);
 
 int ath11k_ce_alloc_pipes(struct ath11k_base *ab)
 {
@@ -806,3 +807,4 @@ int ath11k_ce_get_attr_flags(int ce_id)
 
 	return host_ce_config_wlan[ce_id].flags;
 }
+EXPORT_SYMBOL(ath11k_ce_get_attr_flags);
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 5638f0731634..2dfbe4276514 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -14,6 +14,7 @@
 #include "hif.h"
 
 unsigned int ath11k_debug_mask;
+EXPORT_SYMBOL(ath11k_debug_mask);
 module_param_named(debug_mask, ath11k_debug_mask, uint, 0644);
 MODULE_PARM_DESC(debug_mask, "Debugging mask");
 
@@ -788,11 +789,13 @@ void ath11k_core_deinit(struct ath11k_base *ab)
 	ath11k_mac_destroy(ab);
 	ath11k_core_soc_destroy(ab);
 }
+EXPORT_SYMBOL(ath11k_core_deinit);
 
 void ath11k_core_free(struct ath11k_base *ab)
 {
 	kfree(ab);
 }
+EXPORT_SYMBOL(ath11k_core_free);
 
 struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 				      enum ath11k_bus bus)
@@ -825,3 +828,7 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 	kfree(ab);
 	return NULL;
 }
+EXPORT_SYMBOL(ath11k_core_alloc);
+
+MODULE_DESCRIPTION("Core module for Qualcomm Atheros 802.11ax wireless LAN cards.");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/ath/ath11k/debug.c b/drivers/net/wireless/ath/ath11k/debug.c
index 62a1aa0565a9..60b961e59189 100644
--- a/drivers/net/wireless/ath/ath11k/debug.c
+++ b/drivers/net/wireless/ath/ath11k/debug.c
@@ -62,6 +62,7 @@ void ath11k_info(struct ath11k_base *ab, const char *fmt, ...)
 	/* TODO: Trace the log */
 	va_end(args);
 }
+EXPORT_SYMBOL(ath11k_info);
 
 void ath11k_err(struct ath11k_base *ab, const char *fmt, ...)
 {
@@ -76,6 +77,7 @@ void ath11k_err(struct ath11k_base *ab, const char *fmt, ...)
 	/* TODO: Trace the log */
 	va_end(args);
 }
+EXPORT_SYMBOL(ath11k_err);
 
 void ath11k_warn(struct ath11k_base *ab, const char *fmt, ...)
 {
@@ -90,6 +92,7 @@ void ath11k_warn(struct ath11k_base *ab, const char *fmt, ...)
 	/* TODO: Trace the log */
 	va_end(args);
 }
+EXPORT_SYMBOL(ath11k_warn);
 
 #ifdef CONFIG_ATH11K_DEBUG
 void __ath11k_dbg(struct ath11k_base *ab, enum ath11k_debug_mask mask,
@@ -110,6 +113,7 @@ void __ath11k_dbg(struct ath11k_base *ab, enum ath11k_debug_mask mask,
 
 	va_end(args);
 }
+EXPORT_SYMBOL(__ath11k_dbg);
 
 void ath11k_dbg_dump(struct ath11k_base *ab,
 		     enum ath11k_debug_mask mask,
@@ -138,6 +142,7 @@ void ath11k_dbg_dump(struct ath11k_base *ab,
 		}
 	}
 }
+EXPORT_SYMBOL(ath11k_dbg_dump);
 
 #endif
 
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index 73fcb4f7f3c4..d6a2fd5e641c 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -7,6 +7,7 @@
 #include "core.h"
 #include "dp_tx.h"
 #include "hal_tx.h"
+#include "hif.h"
 #include "debug.h"
 #include "dp_rx.h"
 #include "peer.h"
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index d63785178afa..c7b26478d3e7 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -1133,6 +1133,7 @@ void ath11k_hal_srng_deinit(struct ath11k_base *ab)
 	ath11k_hal_free_cont_rdp(ab);
 	ath11k_hal_free_cont_wrp(ab);
 }
+EXPORT_SYMBOL(ath11k_hal_srng_deinit);
 
 void ath11k_hal_dump_srng_stats(struct ath11k_base *ab)
 {
diff --git a/drivers/net/wireless/ath/ath11k/hif.h b/drivers/net/wireless/ath/ath11k/hif.h
index 165f7e51c238..48ee55cebc81 100644
--- a/drivers/net/wireless/ath/ath11k/hif.h
+++ b/drivers/net/wireless/ath/ath11k/hif.h
@@ -3,6 +3,9 @@
  * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
  */
 
+#ifndef _HIF_H_
+#define _HIF_H_
+
 #include "core.h"
 
 struct ath11k_hif_ops {
@@ -63,3 +66,4 @@ static inline int ath11k_hif_map_service_to_pipe(struct ath11k_base *sc, u16 ser
 {
 	return sc->hif.ops->map_service_to_pipe(sc, service_id, ul_pipe, dl_pipe);
 }
+#endif /* _HIF_H_ */
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
new file mode 100644
index 000000000000..a88536d2c64b
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "core.h"
+#include "debug.h"
+
+#define QCA6390_DEVICE_ID		0x1101
+
+static const struct pci_device_id ath11k_pci_id_table[] = {
+	{ PCI_VDEVICE(QCOM, QCA6390_DEVICE_ID) },
+	{0}
+};
+
+MODULE_DEVICE_TABLE(pci, ath11k_pci_id_table);
+
+static int ath11k_pci_probe(struct pci_dev *pdev,
+			    const struct pci_device_id *pci_dev)
+{
+	struct ath11k_base *ab;
+	enum ath11k_hw_rev hw_rev;
+
+	dev_warn(&pdev->dev, "WARNING: ath11k PCI support is experimental!\n");
+
+	switch (pci_dev->device) {
+	case QCA6390_DEVICE_ID:
+		hw_rev = ATH11K_HW_QCA6390_HW20;
+		break;
+	default:
+		dev_err(&pdev->dev, "Unknown PCI device found: 0x%x\n",
+			pci_dev->device);
+		return -ENOTSUPP;
+	}
+
+	ab = ath11k_core_alloc(&pdev->dev, 0, ATH11K_BUS_PCI);
+	if (!ab) {
+		dev_err(&pdev->dev, "failed to allocate ath11k base\n");
+		return -ENOMEM;
+	}
+
+	ab->dev = &pdev->dev;
+	ab->hw_rev = hw_rev;
+	pci_set_drvdata(pdev, ab);
+
+	return 0;
+}
+
+static void ath11k_pci_remove(struct pci_dev *pdev)
+{
+	struct ath11k_base *ab = pci_get_drvdata(pdev);
+
+	set_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags);
+	ath11k_core_free(ab);
+}
+
+static struct pci_driver ath11k_pci_driver = {
+	.name = "ath11k_pci",
+	.id_table = ath11k_pci_id_table,
+	.probe = ath11k_pci_probe,
+	.remove = ath11k_pci_remove,
+};
+
+static int ath11k_pci_init(void)
+{
+	int ret;
+
+	ret = pci_register_driver(&ath11k_pci_driver);
+	if (ret)
+		pr_err("failed to register ath11k pci driver: %d\n",
+		       ret);
+
+	return ret;
+}
+module_init(ath11k_pci_init);
+
+static void ath11k_pci_exit(void)
+{
+	pci_unregister_driver(&ath11k_pci_driver);
+}
+
+module_exit(ath11k_pci_exit);
+
+MODULE_DESCRIPTION("Driver support for Qualcomm Technologies 802.11ax WLAN PCIe devices");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.7.4

