Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD22740A0C
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 09:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjF1H41 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 03:56:27 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52982 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231219AbjF1HyR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 03:54:17 -0400
X-UUID: a8de1c7a158211eeb20a276fd37b9834-20230628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=SXSbyB9/u8C0lViXzIP/tEqH/B93jr15p2pDLciWS9E=;
        b=YKB1uuHQ1gvcgukXWImXTIHsR9aHRPL4etr6kms2w8CNVp5H0I1rzcI4tffOJ6TU2/UKIaf7mtvD1PCs6qGSmvSLKBSen2nYVFD37ijhSMmxpYMOjDQ7xdVyJzdirzHJ+5LKm91dw4hi542krrcjHlnupAZ7VDAM9rLQJJLzokE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:60539542-7a27-44a4-b7ce-64feae1543db,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:01c9525,CLOUDID:fa764f0d-26a8-467f-b838-f99719a9c083,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a8de1c7a158211eeb20a276fd37b9834-20230628
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 476027258; Wed, 28 Jun 2023 15:09:01 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Jun 2023 15:09:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Jun 2023 15:09:00 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 10/11] wifi: mt76: mt7921: move mt7921_dma_init in pci.c
Date:   Wed, 28 Jun 2023 15:07:23 +0800
Message-ID: <b2214090ac6fdfd2ee5b36da037eb4988e991f5d.1687920269.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1687920269.git.deren.wu@mediatek.com>
References: <cover.1687920269.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Move mt7921_dma_init routine in pci.c and make it static since it is run
just in mt7921_pci_probe(). Get rid of dma.c.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7921/Makefile    |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/dma.c   | 71 -------------------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 -
 .../net/wireless/mediatek/mt76/mt7921/pci.c   | 66 +++++++++++++++++
 4 files changed, 67 insertions(+), 73 deletions(-)
 delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/dma.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
index 964eb55824cd..849be9e848e0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
@@ -7,6 +7,6 @@ obj-$(CONFIG_MT7921U) += mt7921u.o
 
 mt7921-common-y := mac.o mcu.o main.o init.o debugfs.o
 mt7921-common-$(CONFIG_NL80211_TESTMODE) += testmode.o
-mt7921e-y := pci.o pci_mac.o pci_mcu.o dma.o
+mt7921e-y := pci.o pci_mac.o pci_mcu.o
 mt7921s-y := sdio.o sdio_mac.o sdio_mcu.o
 mt7921u-y := usb.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
deleted file mode 100644
index fdc598e099f6..000000000000
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ /dev/null
@@ -1,71 +0,0 @@
-// SPDX-License-Identifier: ISC
-/* Copyright (C) 2020 MediaTek Inc. */
-
-#include "mt7921.h"
-#include "../dma.h"
-#include "../mt76_connac2_mac.h"
-
-int mt7921_dma_init(struct mt792x_dev *dev)
-{
-	int ret;
-
-	mt76_dma_attach(&dev->mt76);
-
-	ret = mt792x_dma_disable(dev, true);
-	if (ret)
-		return ret;
-
-	/* init tx queue */
-	ret = mt76_connac_init_tx_queues(dev->phy.mt76, MT7921_TXQ_BAND0,
-					 MT7921_TX_RING_SIZE,
-					 MT_TX_RING_BASE, 0);
-	if (ret)
-		return ret;
-
-	mt76_wr(dev, MT_WFDMA0_TX_RING0_EXT_CTRL, 0x4);
-
-	/* command to WM */
-	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_WM, MT7921_TXQ_MCU_WM,
-				  MT7921_TX_MCU_RING_SIZE, MT_TX_RING_BASE);
-	if (ret)
-		return ret;
-
-	/* firmware download */
-	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_FWDL, MT7921_TXQ_FWDL,
-				  MT7921_TX_FWDL_RING_SIZE, MT_TX_RING_BASE);
-	if (ret)
-		return ret;
-
-	/* event from WM before firmware download */
-	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU],
-			       MT7921_RXQ_MCU_WM,
-			       MT7921_RX_MCU_RING_SIZE,
-			       MT_RX_BUF_SIZE, MT_RX_EVENT_RING_BASE);
-	if (ret)
-		return ret;
-
-	/* Change mcu queue after firmware download */
-	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU_WA],
-			       MT7921_RXQ_MCU_WM,
-			       MT7921_RX_MCU_RING_SIZE,
-			       MT_RX_BUF_SIZE, MT_WFDMA0(0x540));
-	if (ret)
-		return ret;
-
-	/* rx data */
-	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN],
-			       MT7921_RXQ_BAND0, MT7921_RX_RING_SIZE,
-			       MT_RX_BUF_SIZE, MT_RX_DATA_RING_BASE);
-	if (ret)
-		return ret;
-
-	ret = mt76_init_queues(dev, mt792x_poll_rx);
-	if (ret < 0)
-		return ret;
-
-	netif_napi_add_tx(&dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
-			  mt792x_poll_tx);
-	napi_enable(&dev->mt76.tx_napi);
-
-	return mt792x_dma_enable(dev);
-}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 0f8b93a2be3a..87dd06855f68 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -182,7 +182,6 @@ u32 mt7921_reg_map(struct mt792x_dev *dev, u32 addr);
 int __mt7921_start(struct mt792x_phy *phy);
 int mt7921_register_device(struct mt792x_dev *dev);
 void mt7921_unregister_device(struct mt792x_dev *dev);
-int mt7921_dma_init(struct mt792x_dev *dev);
 int mt7921_run_firmware(struct mt792x_dev *dev);
 int mt7921_mcu_set_bss_pm(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 			  bool enable);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index c3f22ce9f5c4..3dda84a93717 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -9,6 +9,7 @@
 
 #include "mt7921.h"
 #include "../mt76_connac2_mac.h"
+#include "../dma.h"
 #include "mcu.h"
 
 static const struct pci_device_id mt7921_pci_device_table[] = {
@@ -155,6 +156,71 @@ static u32 mt7921_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32 val)
 	return dev->bus_ops->rmw(mdev, addr, mask, val);
 }
 
+static int mt7921_dma_init(struct mt792x_dev *dev)
+{
+	int ret;
+
+	mt76_dma_attach(&dev->mt76);
+
+	ret = mt792x_dma_disable(dev, true);
+	if (ret)
+		return ret;
+
+	/* init tx queue */
+	ret = mt76_connac_init_tx_queues(dev->phy.mt76, MT7921_TXQ_BAND0,
+					 MT7921_TX_RING_SIZE,
+					 MT_TX_RING_BASE, 0);
+	if (ret)
+		return ret;
+
+	mt76_wr(dev, MT_WFDMA0_TX_RING0_EXT_CTRL, 0x4);
+
+	/* command to WM */
+	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_WM, MT7921_TXQ_MCU_WM,
+				  MT7921_TX_MCU_RING_SIZE, MT_TX_RING_BASE);
+	if (ret)
+		return ret;
+
+	/* firmware download */
+	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_FWDL, MT7921_TXQ_FWDL,
+				  MT7921_TX_FWDL_RING_SIZE, MT_TX_RING_BASE);
+	if (ret)
+		return ret;
+
+	/* event from WM before firmware download */
+	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU],
+			       MT7921_RXQ_MCU_WM,
+			       MT7921_RX_MCU_RING_SIZE,
+			       MT_RX_BUF_SIZE, MT_RX_EVENT_RING_BASE);
+	if (ret)
+		return ret;
+
+	/* Change mcu queue after firmware download */
+	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU_WA],
+			       MT7921_RXQ_MCU_WM,
+			       MT7921_RX_MCU_RING_SIZE,
+			       MT_RX_BUF_SIZE, MT_WFDMA0(0x540));
+	if (ret)
+		return ret;
+
+	/* rx data */
+	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN],
+			       MT7921_RXQ_BAND0, MT7921_RX_RING_SIZE,
+			       MT_RX_BUF_SIZE, MT_RX_DATA_RING_BASE);
+	if (ret)
+		return ret;
+
+	ret = mt76_init_queues(dev, mt792x_poll_rx);
+	if (ret < 0)
+		return ret;
+
+	netif_napi_add_tx(&dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
+			  mt792x_poll_tx);
+	napi_enable(&dev->mt76.tx_napi);
+
+	return mt792x_dma_enable(dev);
+}
+
 static int mt7921_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
-- 
2.18.0

