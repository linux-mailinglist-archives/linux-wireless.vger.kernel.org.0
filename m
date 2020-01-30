Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3C4114DD12
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2020 15:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgA3OrW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jan 2020 09:47:22 -0500
Received: from nbd.name ([46.4.11.11]:57434 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727190AbgA3OrW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jan 2020 09:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ICGQzIrxSFDTO1uQTJKA7L4lSQmY/RDhH1tmWvIAW8M=; b=RGzsQ5ppXkEP/9JhO3g1C365aL
        CHj/zpIOgDp+4lOfMMcwPh4AAmBYxzSIQ9RswqEuoME0G4JFaap9B9p3UulhvrfIyzNW6NQR9oJmZ
        5sfLe38sFrw8qeLgv3ahrBmfIwrgrM5BMw5aPDGhHUSZmqtFXiO3p0YqynKdIIyIBYpY=;
Received: from [178.162.209.135] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ixB6F-0001VJ-Kl
        for linux-wireless@vger.kernel.org; Thu, 30 Jan 2020 15:47:19 +0100
Received: by maeck.local (Postfix, from userid 501)
        id EB4297AE468A; Thu, 30 Jan 2020 15:47:18 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 11/15] mt76: mt7615: implement probing and firmware loading on MT7622
Date:   Thu, 30 Jan 2020 15:47:14 +0100
Message-Id: <20200130144718.14298-11-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200130144718.14298-1-nbd@nbd.name>
References: <20200130144718.14298-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

MT7622 does not have a CR4 microcontroller, so it only uses its own N9
firmware.

Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../wireless/mediatek/mt76/mt7615/Makefile    |  1 +
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  4 +
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 28 ++++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 85 ++++++++++++++++---
 .../wireless/mediatek/mt76/mt7615/mt7615.h    | 19 +++++
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |  3 -
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |  9 ++
 .../net/wireless/mediatek/mt76/mt7615/soc.c   | 77 +++++++++++++++++
 8 files changed, 213 insertions(+), 13 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/soc.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Makefile b/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
index a93d147edf44..5c6a220ed7e3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
@@ -6,3 +6,4 @@ CFLAGS_trace.o := -I$(src)
 
 mt7615e-y := pci.o init.o dma.o eeprom.o main.o mcu.o mac.o mmio.o \
 	     debugfs.o trace.o
+mt7615e-$(CONFIG_MT7622_WMAC) += soc.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 1af941f83213..df6ef323f7a2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -442,6 +442,10 @@ int mt7615_register_device(struct mt7615_dev *dev)
 	INIT_LIST_HEAD(&dev->sta_poll_list);
 	spin_lock_init(&dev->sta_poll_lock);
 
+	ret = mt7622_wmac_init(dev);
+	if (ret)
+		return ret;
+
 	ret = mt7615_init_hardware(dev);
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 14034592b918..b8e57bf7814b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -730,3 +730,31 @@ const struct ieee80211_ops mt7615_ops = {
 	.set_antenna = mt7615_set_antenna,
 	.set_coverage_class = mt7615_set_coverage_class,
 };
+
+static int __init mt7615_init(void)
+{
+	int ret;
+
+	ret = pci_register_driver(&mt7615_pci_driver);
+	if (ret)
+		return ret;
+
+	if (IS_ENABLED(CONFIG_MT7622_WMAC)) {
+		ret = platform_driver_register(&mt7622_wmac_driver);
+		if (ret)
+			pci_unregister_driver(&mt7615_pci_driver);
+	}
+
+	return ret;
+}
+
+static void __exit mt7615_exit(void)
+{
+	if (IS_ENABLED(CONFIG_MT7622_WMAC))
+		platform_driver_unregister(&mt7622_wmac_driver);
+	pci_unregister_driver(&mt7615_pci_driver);
+}
+
+module_init(mt7615_init);
+module_exit(mt7615_exit);
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index e51e584bf81f..d8bdd88d9fe9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -29,7 +29,8 @@ struct mt7615_fw_trailer {
 	__le32 len;
 } __packed;
 
-#define MCU_PATCH_ADDRESS		0x80000
+#define MT7615_PATCH_ADDRESS		0x80000
+#define MT7622_PATCH_ADDRESS		0x9c000
 
 #define N9_REGION_NUM			2
 #define CR4_REGION_NUM			1
@@ -333,19 +334,50 @@ static int mt7615_mcu_start_patch(struct mt7615_dev *dev)
 				   &req, sizeof(req), true);
 }
 
+static void mt7622_trigger_hif_int(struct mt7615_dev *dev, bool en)
+{
+	if (!is_mt7622(&dev->mt76))
+		return;
+
+	regmap_update_bits(dev->infracfg, MT_INFRACFG_MISC,
+			   MT_INFRACFG_MISC_AP2CONN_WAKE,
+			   !en * MT_INFRACFG_MISC_AP2CONN_WAKE);
+}
+
 static int mt7615_driver_own(struct mt7615_dev *dev)
 {
 	mt76_wr(dev, MT_CFG_LPCR_HOST, MT_CFG_LPCR_HOST_DRV_OWN);
+
+	mt7622_trigger_hif_int(dev, true);
 	if (!mt76_poll_msec(dev, MT_CFG_LPCR_HOST,
-			    MT_CFG_LPCR_HOST_FW_OWN, 0, 500)) {
+			    MT_CFG_LPCR_HOST_FW_OWN, 0, 3000)) {
 		dev_err(dev->mt76.dev, "Timeout for driver own\n");
 		return -EIO;
 	}
+	mt7622_trigger_hif_int(dev, false);
 
 	return 0;
 }
 
-static int mt7615_load_patch(struct mt7615_dev *dev, const char *name)
+static int mt7615_firmware_own(struct mt7615_dev *dev)
+{
+	mt7622_trigger_hif_int(dev, true);
+
+	mt76_wr(dev, MT_CFG_LPCR_HOST, MT_CFG_LPCR_HOST_FW_OWN);
+
+	if (is_mt7622(&dev->mt76) &&
+	    !mt76_poll_msec(dev, MT_CFG_LPCR_HOST,
+			    MT_CFG_LPCR_HOST_FW_OWN,
+			    MT_CFG_LPCR_HOST_FW_OWN, 3000)) {
+		dev_err(dev->mt76.dev, "Timeout for firmware own\n");
+		return -EIO;
+	}
+	mt7622_trigger_hif_int(dev, false);
+
+	return 0;
+}
+
+static int mt7615_load_patch(struct mt7615_dev *dev, u32 addr, const char *name)
 {
 	const struct mt7615_patch_hdr *hdr;
 	const struct firmware *fw = NULL;
@@ -379,8 +411,7 @@ static int mt7615_load_patch(struct mt7615_dev *dev, const char *name)
 
 	len = fw->size - sizeof(*hdr);
 
-	ret = mt7615_mcu_init_download(dev, MCU_PATCH_ADDRESS, len,
-				       DL_MODE_NEED_RSP);
+	ret = mt7615_mcu_init_download(dev, addr, len, DL_MODE_NEED_RSP);
 	if (ret) {
 		dev_err(dev->mt76.dev, "Download request failed\n");
 		goto out;
@@ -561,7 +592,7 @@ static int mt7615_load_firmware(struct mt7615_dev *dev)
 		return -EIO;
 	}
 
-	ret = mt7615_load_patch(dev, MT7615_ROM_PATCH);
+	ret = mt7615_load_patch(dev, MT7615_PATCH_ADDRESS, MT7615_ROM_PATCH);
 	if (ret)
 		return ret;
 
@@ -576,9 +607,38 @@ static int mt7615_load_firmware(struct mt7615_dev *dev)
 		return -EIO;
 	}
 
-	mt76_queue_tx_cleanup(dev, MT_TXQ_FWDL, false);
+	return 0;
+}
 
-	dev_dbg(dev->mt76.dev, "Firmware init done\n");
+static int mt7622_load_firmware(struct mt7615_dev *dev)
+{
+	int ret;
+	u32 val;
+
+	mt76_set(dev, MT_WPDMA_GLO_CFG, MT_WPDMA_GLO_CFG_BYPASS_TX_SCH);
+
+	val = mt76_get_field(dev, MT_TOP_OFF_RSV, MT_TOP_OFF_RSV_FW_STATE);
+	if (val != FW_STATE_FW_DOWNLOAD) {
+		dev_err(dev->mt76.dev, "Firmware is not ready for download\n");
+		return -EIO;
+	}
+
+	ret = mt7615_load_patch(dev, MT7622_PATCH_ADDRESS, MT7622_ROM_PATCH);
+	if (ret)
+		return ret;
+
+	ret = mt7615_load_n9(dev, MT7622_FIRMWARE_N9);
+	if (ret)
+		return ret;
+
+	if (!mt76_poll_msec(dev, MT_TOP_OFF_RSV, MT_TOP_OFF_RSV_FW_STATE,
+			    FIELD_PREP(MT_TOP_OFF_RSV_FW_STATE,
+				       FW_STATE_NORMAL_TRX), 1500)) {
+		dev_err(dev->mt76.dev, "Timeout for initializing firmware\n");
+		return -EIO;
+	}
+
+	mt76_clear(dev, MT_WPDMA_GLO_CFG, MT_WPDMA_GLO_CFG_BYPASS_TX_SCH);
 
 	return 0;
 }
@@ -597,10 +657,15 @@ int mt7615_mcu_init(struct mt7615_dev *dev)
 	if (ret)
 		return ret;
 
-	ret = mt7615_load_firmware(dev);
+	if (is_mt7622(&dev->mt76))
+		ret = mt7622_load_firmware(dev);
+	else
+		ret = mt7615_load_firmware(dev);
 	if (ret)
 		return ret;
 
+	mt76_queue_tx_cleanup(dev, MT_TXQ_FWDL, false);
+	dev_dbg(dev->mt76.dev, "Firmware init done\n");
 	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
 
 	return 0;
@@ -609,7 +674,7 @@ int mt7615_mcu_init(struct mt7615_dev *dev)
 void mt7615_mcu_exit(struct mt7615_dev *dev)
 {
 	__mt76_mcu_restart(&dev->mt76);
-	mt76_wr(dev, MT_CFG_LPCR_HOST, MT_CFG_LPCR_HOST_FW_OWN);
+	mt7615_firmware_own(dev);
 	skb_queue_purge(&dev->mt76.mmio.mcu.res_q);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index d9e487ba98e0..9eb5cfcfe704 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -6,6 +6,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/ktime.h>
+#include <linux/regmap.h>
 #include "../mt76.h"
 #include "regs.h"
 
@@ -31,6 +32,9 @@
 #define MT7615_FIRMWARE_N9		"mediatek/mt7615_n9.bin"
 #define MT7615_ROM_PATCH		"mediatek/mt7615_rom_patch.bin"
 
+#define MT7622_FIRMWARE_N9		"mediatek/mt7622_n9.bin"
+#define MT7622_ROM_PATCH		"mediatek/mt7622_rom_patch.bin"
+
 #define MT7615_EEPROM_SIZE		1024
 #define MT7615_TOKEN_SIZE		4096
 
@@ -148,6 +152,8 @@ struct mt7615_dev {
 
 	u16 chainmask;
 
+	struct regmap *infracfg;
+
 	struct work_struct mcu_work;
 
 	struct list_head sta_poll_list;
@@ -241,6 +247,16 @@ mt7615_ext_phy(struct mt7615_dev *dev)
 
 extern const struct ieee80211_ops mt7615_ops;
 extern struct pci_driver mt7615_pci_driver;
+extern struct platform_driver mt7622_wmac_driver;
+
+#ifdef CONFIG_MT7622_WMAC
+int mt7622_wmac_init(struct mt7615_dev *dev);
+#else
+static inline int mt7622_wmac_init(struct mt7615_dev *dev)
+{
+	return 0;
+}
+#endif
 
 int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base, int irq);
 u32 mt7615_reg_map(struct mt7615_dev *dev, u32 addr);
@@ -295,6 +311,9 @@ int mt7615_mcu_rdd_send_pattern(struct mt7615_dev *dev);
 
 static inline bool is_mt7622(struct mt76_dev *dev)
 {
+	if (!IS_ENABLED(CONFIG_MT7622_WMAC))
+		return false;
+
 	return mt76_chip(dev) == 0x7622;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index caaad936a34a..43e02128cc48 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -53,10 +53,7 @@ struct pci_driver mt7615_pci_driver = {
 	.remove		= mt7615_pci_remove,
 };
 
-module_pci_driver(mt7615_pci_driver);
-
 MODULE_DEVICE_TABLE(pci, mt7615_pci_device_table);
 MODULE_FIRMWARE(MT7615_FIRMWARE_CR4);
 MODULE_FIRMWARE(MT7615_FIRMWARE_N9);
 MODULE_FIRMWARE(MT7615_ROM_PATCH);
-MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index de71d2672cf7..abecb3bfbc4b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -8,6 +8,10 @@
 #define MT_HW_CHIPID			0x1008
 #define MT_TOP_STRAP_STA		0x1010
 #define MT_TOP_3NSS			BIT(24)
+
+#define MT_TOP_OFF_RSV			0x1128
+#define MT_TOP_OFF_RSV_FW_STATE		GENMASK(18, 16)
+
 #define MT_TOP_MISC2			0x1134
 #define MT_TOP_MISC2_FW_STATE		GENMASK(2, 0)
 
@@ -49,6 +53,7 @@
 #define MT_WPDMA_GLO_CFG_TX_WRITEBACK_DONE	BIT(6)
 #define MT_WPDMA_GLO_CFG_BIG_ENDIAN	BIT(7)
 #define MT_WPDMA_GLO_CFG_TX_BT_SIZE_BIT0	BIT(9)
+#define MT_WPDMA_GLO_CFG_BYPASS_TX_SCH		BIT(9) /* MT7622 */
 #define MT_WPDMA_GLO_CFG_MULTI_DMA_EN	GENMASK(11, 10)
 #define MT_WPDMA_GLO_CFG_FIFO_LITTLE_ENDIAN	BIT(12)
 #define MT_WPDMA_GLO_CFG_TX_BT_SIZE_BIT21	GENMASK(23, 22)
@@ -395,4 +400,8 @@
 #define MT_EFUSE_WDATA(_i)		(0x010 + ((_i) * 4))
 #define MT_EFUSE_RDATA(_i)		(0x030 + ((_i) * 4))
 
+/* INFRACFG host register range on MT7622 */
+#define MT_INFRACFG_MISC		0x700
+#define MT_INFRACFG_MISC_AP2CONN_WAKE	BIT(1)
+
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/soc.c b/drivers/net/wireless/mediatek/mt76/mt7615/soc.c
new file mode 100644
index 000000000000..07ec9ec282f5
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/soc.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2019 MediaTek Inc.
+ *
+ * Author: Ryder Lee <ryder.lee@mediatek.com>
+ *         Felix Fietkau <nbd@nbd.name>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include "mt7615.h"
+
+int mt7622_wmac_init(struct mt7615_dev *dev)
+{
+	struct device_node *np = dev->mt76.dev->of_node;
+
+	if (!is_mt7622(&dev->mt76))
+		return 0;
+
+	dev->infracfg = syscon_regmap_lookup_by_phandle(np, "mediatek,infracfg");
+	if (IS_ERR(dev->infracfg)) {
+		dev_err(dev->mt76.dev, "Cannot find infracfg controller\n");
+		return PTR_ERR(dev->infracfg);
+	}
+
+	return 0;
+}
+
+static int mt7622_wmac_probe(struct platform_device *pdev)
+{
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	void __iomem *mem_base;
+	int irq;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "Failed to get device IRQ\n");
+		return irq;
+	}
+
+	mem_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(mem_base)) {
+		dev_err(&pdev->dev, "Failed to get memory resource\n");
+		return PTR_ERR(mem_base);
+	}
+
+	return mt7615_mmio_probe(&pdev->dev, mem_base, irq);
+}
+
+static int mt7622_wmac_remove(struct platform_device *pdev)
+{
+	struct mt7615_dev *dev = platform_get_drvdata(pdev);
+
+	mt7615_unregister_device(dev);
+
+	return 0;
+}
+
+static const struct of_device_id mt7622_wmac_of_match[] = {
+	{ .compatible = "mediatek,mt7622-wmac" },
+	{},
+};
+
+struct platform_driver mt7622_wmac_driver = {
+	.driver = {
+		.name = "mt7622-wmac",
+		.of_match_table = mt7622_wmac_of_match,
+	},
+	.probe = mt7622_wmac_probe,
+	.remove = mt7622_wmac_remove,
+};
+
+MODULE_FIRMWARE(MT7622_FIRMWARE_N9);
+MODULE_FIRMWARE(MT7622_ROM_PATCH);
-- 
2.24.0

