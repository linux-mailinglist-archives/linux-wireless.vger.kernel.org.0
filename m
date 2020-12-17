Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64062DD801
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 19:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbgLQSOL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 13:14:11 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:46170 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731390AbgLQSOK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 13:14:10 -0500
X-UUID: affa3d12fd37420fb67881824b30f626-20201218
X-UUID: affa3d12fd37420fb67881824b30f626-20201218
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 8969485; Fri, 18 Dec 2020 02:13:26 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 18 Dec 2020 02:13:20 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Dec 2020 02:13:21 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <Eric.Liang@mediatek.com>,
        <ryder.lee@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH -next v3 1/8] mt76: mt7921: add module support
Date:   Fri, 18 Dec 2020 02:13:14 +0800
Message-ID: <781bd384227cddeb18cd47dd861c0f5400625f55.1608227863.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1608227863.git.objelf@gmail.com>
References: <cover.1608227863.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 66CDB51BBAA2786F22A91D77AA86C1D99EF9FD178393AD1DF7AE9E90FC2C15FE2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add mt7921 as the pci driver module.

The purpose of the patch is to check about if the following patches are
able to compile properly.

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Co-developed-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/Kconfig    |  1 +
 drivers/net/wireless/mediatek/mt76/Makefile   |  1 +
 .../net/wireless/mediatek/mt76/mt7921/Kconfig | 10 +++
 .../wireless/mediatek/mt76/mt7921/Makefile    |  5 ++
 .../net/wireless/mediatek/mt76/mt7921/pci.c   | 63 +++++++++++++++++++
 5 files changed, 80 insertions(+)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/Makefile
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/pci.c

diff --git a/drivers/net/wireless/mediatek/mt76/Kconfig b/drivers/net/wireless/mediatek/mt76/Kconfig
index 31015d2a8e7d..5f42ce3267cb 100644
--- a/drivers/net/wireless/mediatek/mt76/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/Kconfig
@@ -29,3 +29,4 @@ source "drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig"
 source "drivers/net/wireless/mediatek/mt76/mt7603/Kconfig"
 source "drivers/net/wireless/mediatek/mt76/mt7615/Kconfig"
 source "drivers/net/wireless/mediatek/mt76/mt7915/Kconfig"
+source "drivers/net/wireless/mediatek/mt76/mt7921/Kconfig"
diff --git a/drivers/net/wireless/mediatek/mt76/Makefile b/drivers/net/wireless/mediatek/mt76/Makefile
index e53584db0756..1d72093b61a3 100644
--- a/drivers/net/wireless/mediatek/mt76/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/Makefile
@@ -31,3 +31,4 @@ obj-$(CONFIG_MT76x2_COMMON) += mt76x2/
 obj-$(CONFIG_MT7603E) += mt7603/
 obj-$(CONFIG_MT7615_COMMON) += mt7615/
 obj-$(CONFIG_MT7915E) += mt7915/
+obj-$(CONFIG_MT7921E) += mt7921/
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
new file mode 100644
index 000000000000..24932d2e8dee
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: ISC
+config MT7921E
+	tristate "MediaTek MT7921E (PCIe) support"
+	select MT76_CORE
+	depends on MAC80211
+	depends on PCI
+	help
+	  This adds support for MT7921E 802.11ax 2x2:2SS wireless devices.
+
+	  To compile this driver as a module, choose M here.
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
new file mode 100644
index 000000000000..fa7b42721631
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
@@ -0,0 +1,5 @@
+#SPDX-License-Identifier: ISC
+
+obj-$(CONFIG_MT7921E) += mt7921e.o
+
+mt7921e-y := pci.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
new file mode 100644
index 000000000000..9f003775c4d8
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+static const struct pci_device_id mt7921_pci_device_table[] = {
+	{ PCI_DEVICE(0x14c3, 0x7961) },
+	{ },
+};
+
+static int mt7921_pci_probe(struct pci_dev *pdev,
+			    const struct pci_device_id *id)
+{
+	int ret;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	ret = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
+	if (ret)
+		return ret;
+
+	pci_set_master(pdev);
+
+	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_LEGACY);
+	if (ret < 0)
+		return ret;
+
+	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+	if (ret)
+		goto err_free_pci_vec;
+
+	return 0;
+
+err_free_pci_vec:
+	pci_free_irq_vectors(pdev);
+
+	return ret;
+}
+
+static void mt7921_pci_remove(struct pci_dev *pdev)
+{
+	pci_free_irq_vectors(pdev);
+}
+
+struct pci_driver mt7921_pci_driver = {
+	.name		= KBUILD_MODNAME,
+	.id_table	= mt7921_pci_device_table,
+	.probe		= mt7921_pci_probe,
+	.remove		= mt7921_pci_remove,
+};
+
+module_pci_driver(mt7921_pci_driver);
+
+MODULE_DEVICE_TABLE(pci, mt7921_pci_device_table);
+MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
+MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.25.1

