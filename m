Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E994340BD03
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 03:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhIOBQh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Sep 2021 21:16:37 -0400
Received: from mailgw01.mediatek.com ([216.200.240.184]:35471 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbhIOBQh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Sep 2021 21:16:37 -0400
X-UUID: eb1c9411e07b4e989db4e2cccf721a8c-20210914
X-UUID: eb1c9411e07b4e989db4e2cccf721a8c-20210914
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1742301927; Tue, 14 Sep 2021 18:15:16 -0700
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 18:15:15 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Sep 2021 09:15:14 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <steve.lee@mediatek.com>, <jemele@google.com>,
        <shawnku@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v1 04/16] mt76: mt7921: refactor init.c to be bus independent
Date:   Wed, 15 Sep 2021 09:14:37 +0800
Message-ID: <210a8cd3ab6698401b55a3268719d194cc96e0b5.1631667941.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1631667941.git.objelf@gmail.com>
References: <cover.1631667941.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

This is a preliminary patch to introduce mt7921s support.

Make init.c reusable between mt7921s and mt7921e

Tested-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7921/Makefile    |  4 +--
 .../net/wireless/mediatek/mt76/mt7921/dma.c   |  8 ++++++
 .../net/wireless/mediatek/mt76/mt7921/init.c  | 28 +------------------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  3 ++
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  5 ++++
 .../wireless/mediatek/mt76/mt7921/pci_init.c  | 26 +++++++++++++++++
 6 files changed, 45 insertions(+), 29 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/pci_init.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
index 4cb0b000cfe1..15f940a23ea9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
@@ -4,6 +4,6 @@ obj-$(CONFIG_MT7921E) += mt7921e.o
 
 CFLAGS_trace.o := -I$(src)
 
-mt7921e-y := pci.o pci_mac.o pci_mcu.o mac.o mcu.o dma.o eeprom.o main.o \
-	     init.o debugfs.o trace.o
+mt7921e-y := pci.o pci_mac.o pci_mcu.o pci_init.o mac.o mcu.o dma.o \
+	     eeprom.o main.o init.o debugfs.o trace.o
 mt7921e-$(CONFIG_NL80211_TESTMODE) += testmode.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index d3e2036a1974..be24241fb8e6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -313,6 +313,11 @@ int mt7921_wpdma_reset(struct mt7921_dev *dev, bool force)
 	return 0;
 }
 
+int mt7921e_init_reset(struct mt7921_dev *dev)
+{
+	return mt7921_wpdma_reset(dev, true);
+}
+
 int mt7921_wpdma_reinit_cond(struct mt7921_dev *dev)
 {
 	struct mt76_connac_pm *pm = &dev->pm;
@@ -343,6 +348,9 @@ int mt7921_dma_init(struct mt7921_dev *dev)
 	struct mt76_bus_ops *bus_ops;
 	int ret;
 
+	dev->phy.dev = dev;
+	dev->phy.mt76 = &dev->mt76.phy;
+	dev->mt76.phy.priv = &dev->phy;
 	dev->bus_ops = dev->mt76.bus;
 	bus_ops = devm_kmemdup(dev->mt76.dev, dev->bus_ops, sizeof(*bus_ops),
 			       GFP_KERNEL);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 7c7a26102e11..f0fd32c424c6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -181,10 +181,6 @@ static int mt7921_init_hardware(struct mt7921_dev *dev)
 {
 	int ret, idx, i;
 
-	ret = mt7921_dma_init(dev);
-	if (ret)
-		return ret;
-
 	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
 
 	for (i = 0; i < MT7921_MCU_INIT_RETRY_COUNT; i++) {
@@ -192,7 +188,7 @@ static int mt7921_init_hardware(struct mt7921_dev *dev)
 		if (!ret)
 			break;
 
-		mt7921_wpdma_reset(dev, true);
+		mt7921_init_reset(dev);
 	}
 
 	if (i == MT7921_MCU_INIT_RETRY_COUNT) {
@@ -289,25 +285,3 @@ int mt7921_register_device(struct mt7921_dev *dev)
 
 	return 0;
 }
-
-void mt7921_unregister_device(struct mt7921_dev *dev)
-{
-	int i;
-	struct mt76_connac_pm *pm = &dev->pm;
-
-	mt76_unregister_device(&dev->mt76);
-	mt76_for_each_q_rx(&dev->mt76, i)
-		napi_disable(&dev->mt76.napi[i]);
-	cancel_delayed_work_sync(&pm->ps_work);
-	cancel_work_sync(&pm->wake_work);
-
-	mt7921_tx_token_put(dev);
-	mt7921_mcu_drv_pmctrl(dev);
-	mt7921_dma_cleanup(dev);
-	mt7921_wfsys_reset(dev);
-	mt7921_mcu_exit(dev);
-	mt7921_mcu_fw_pmctrl(dev);
-
-	tasklet_disable(&dev->irq_tasklet);
-	mt76_free_device(&dev->mt76);
-}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index dbace154bfa5..60f4552cb212 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -133,11 +133,13 @@ struct mt7921_phy {
 	struct delayed_work scan_work;
 };
 
+#define mt7921_init_reset(dev)	((dev)->hif_ops->init_reset(dev))
 #define mt7921_dev_reset(dev)	((dev)->hif_ops->reset(dev))
 #define mt7921_mcu_init(dev)	((dev)->hif_ops->mcu_init(dev))
 #define mt7921_drv_own(dev)	((dev)->hif_ops->drv_own(dev))
 #define mt7921_fw_own(dev)	((dev)->hif_ops->fw_own(dev))
 struct mt7921_hif_ops {
+	int (*init_reset)(struct mt7921_dev *dev);
 	int (*reset)(struct mt7921_dev *dev);
 	int (*mcu_init)(struct mt7921_dev *dev);
 	int (*drv_own)(struct mt7921_dev *dev);
@@ -394,5 +396,6 @@ int mt7921e_mac_reset(struct mt7921_dev *dev);
 int mt7921e_mcu_init(struct mt7921_dev *dev);
 int mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev);
 int mt7921e_mcu_fw_pmctrl(struct mt7921_dev *dev);
+int mt7921e_init_reset(struct mt7921_dev *dev);
 
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index b16bcee08cd7..f6bc3505b06a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -116,6 +116,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	};
 
 	static const struct mt7921_hif_ops mt7921_pcie_ops = {
+		.init_reset = mt7921e_init_reset,
 		.reset = mt7921e_mac_reset,
 		.mcu_init = mt7921e_mcu_init,
 		.drv_own = mt7921e_mcu_drv_pmctrl,
@@ -172,6 +173,10 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_free_dev;
 
+	ret = mt7921_dma_init(dev);
+	if (ret)
+		goto err_free_irq;
+
 	ret = mt7921_register_device(dev);
 	if (ret)
 		goto err_free_irq;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_init.c
new file mode 100644
index 000000000000..4511fec79d43
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_init.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2021 MediaTek Inc. */
+
+#include "mt7921.h"
+
+void mt7921_unregister_device(struct mt7921_dev *dev)
+{
+	int i;
+	struct mt76_connac_pm *pm = &dev->pm;
+
+	mt76_unregister_device(&dev->mt76);
+	mt76_for_each_q_rx(&dev->mt76, i)
+		napi_disable(&dev->mt76.napi[i]);
+	cancel_delayed_work_sync(&pm->ps_work);
+	cancel_work_sync(&pm->wake_work);
+
+	mt7921_tx_token_put(dev);
+	mt7921_mcu_drv_pmctrl(dev);
+	mt7921_dma_cleanup(dev);
+	mt7921_wfsys_reset(dev);
+	mt7921_mcu_exit(dev);
+	mt7921_mcu_fw_pmctrl(dev);
+
+	tasklet_disable(&dev->irq_tasklet);
+	mt76_free_device(&dev->mt76);
+}
-- 
2.25.1

