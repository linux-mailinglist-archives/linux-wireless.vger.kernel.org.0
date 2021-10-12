Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C01942AFD5
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Oct 2021 00:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbhJLWyh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Oct 2021 18:54:37 -0400
Received: from mailgw01.mediatek.com ([216.200.240.184]:41298 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbhJLWyg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Oct 2021 18:54:36 -0400
X-UUID: 249e628e95764c57b2f151f6f9653cff-20211012
X-UUID: 249e628e95764c57b2f151f6f9653cff-20211012
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1832575835; Tue, 12 Oct 2021 15:52:30 -0700
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 12 Oct 2021 15:52:29 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 13 Oct 2021 06:52:28 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Mark-YW.Chen@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v4 04/16] mt76: mt7921: refactor init.c to be bus independent
Date:   Wed, 13 Oct 2021 06:51:57 +0800
Message-ID: <6312af017d9ff767c261f65794b3d30ace98b247.1634077769.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1634077769.git.objelf@gmail.com>
References: <cover.1634077769.git.objelf@gmail.com>
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
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/dma.c   |  3 ++
 .../net/wireless/mediatek/mt76/mt7921/init.c  | 27 +--------------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 ++
 .../net/wireless/mediatek/mt76/mt7921/pci.c   | 33 ++++++++++++++++++-
 4 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index d3e2036a1974..8f29d09179e4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -343,6 +343,9 @@ int mt7921_dma_init(struct mt7921_dev *dev)
 	struct mt76_bus_ops *bus_ops;
 	int ret;
 
+	dev->phy.dev = dev;
+	dev->phy.mt76 = &dev->mt76.phy;
+	dev->mt76.phy.priv = &dev->phy;
 	dev->bus_ops = dev->mt76.bus;
 	bus_ops = devm_kmemdup(dev->mt76.dev, dev->bus_ops, sizeof(*bus_ops),
 			       GFP_KERNEL);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 7956a57510c4..f0fd32c424c6 100644
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
@@ -289,24 +285,3 @@ int mt7921_register_device(struct mt7921_dev *dev)
 
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
-
-	tasklet_disable(&dev->irq_tasklet);
-	mt76_free_device(&dev->mt76);
-}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 9c15c9bdd41e..295f57ce7eba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -133,11 +133,13 @@ struct mt7921_phy {
 	struct delayed_work scan_work;
 };
 
+#define mt7921_init_reset(dev)		((dev)->hif_ops->init_reset(dev))
 #define mt7921_dev_reset(dev)		((dev)->hif_ops->reset(dev))
 #define mt7921_mcu_init(dev)		((dev)->hif_ops->mcu_init(dev))
 #define __mt7921_mcu_drv_pmctrl(dev)	((dev)->hif_ops->drv_own(dev))
 #define	__mt7921_mcu_fw_pmctrl(dev)	((dev)->hif_ops->fw_own(dev))
 struct mt7921_hif_ops {
+	int (*init_reset)(struct mt7921_dev *dev);
 	int (*reset)(struct mt7921_dev *dev);
 	int (*mcu_init)(struct mt7921_dev *dev);
 	int (*drv_own)(struct mt7921_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 171aa2daef4d..305b63fa1a8a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -93,6 +93,32 @@ static void mt7921_irq_tasklet(unsigned long data)
 		napi_schedule(&dev->mt76.napi[MT_RXQ_MAIN]);
 }
 
+static int mt7921e_init_reset(struct mt7921_dev *dev)
+{
+	return mt7921_wpdma_reset(dev, true);
+}
+
+static void mt7921e_unregister_device(struct mt7921_dev *dev)
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
+
+	tasklet_disable(&dev->irq_tasklet);
+	mt76_free_device(&dev->mt76);
+}
+
 static int mt7921_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
@@ -116,6 +142,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	};
 
 	static const struct mt7921_hif_ops mt7921_pcie_ops = {
+		.init_reset = mt7921e_init_reset,
 		.reset = mt7921e_mac_reset,
 		.mcu_init = mt7921e_mcu_init,
 		.drv_own = mt7921e_mcu_drv_pmctrl,
@@ -172,6 +199,10 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_free_dev;
 
+	ret = mt7921_dma_init(dev);
+	if (ret)
+		goto err_free_irq;
+
 	ret = mt7921_register_device(dev);
 	if (ret)
 		goto err_free_irq;
@@ -193,7 +224,7 @@ static void mt7921_pci_remove(struct pci_dev *pdev)
 	struct mt76_dev *mdev = pci_get_drvdata(pdev);
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
 
-	mt7921_unregister_device(dev);
+	mt7921e_unregister_device(dev);
 	devm_free_irq(&pdev->dev, pdev->irq, dev);
 	pci_free_irq_vectors(pdev);
 }
-- 
2.25.1

