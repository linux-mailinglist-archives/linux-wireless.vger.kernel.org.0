Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238A068C6D6
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Feb 2023 20:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjBFTck (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Feb 2023 14:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjBFTcj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Feb 2023 14:32:39 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CBBFF03
        for <linux-wireless@vger.kernel.org>; Mon,  6 Feb 2023 11:32:37 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D55B38C008C;
        Mon,  6 Feb 2023 19:32:35 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 3356013C2B0;
        Mon,  6 Feb 2023 11:32:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3356013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1675711955;
        bh=IzYP8Uu/DUpj9qXN19YJ6WiKd2gyURFljQ3uNgOb5pc=;
        h=From:To:Cc:Subject:Date:From;
        b=hvyaCIIstBgX3vjme9+SbHPj1XzePxbHgar2DRBOYCIE166TnJhIi6Icl4vztOvLZ
         P32M7ZqMJg7L1Zl3j71kLsyr5l1t78BXQ+GnKWrV9OWkWDFP5aeZpn3atCjPzm0T7f
         pyFthQsI6JgWB4LRHwjy09JN+B7WjgNMx+c/UQyE=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Deren.Wu@mediatek.com, Ben Greear <greearb@candelatech.com>
Subject: [PATCH] wifi: mt76: mt7921:  retry dma-disable on startup.
Date:   Mon,  6 Feb 2023 11:32:33 -0800
Message-Id: <20230206193233.1716090-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1675711956-gFbVqQJNuqpw
X-MDID-O: us5-at1-1675711956-gFbVqQJNuqpw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

My system with lots of mtk7921k radios in it often fails to bring up
a few of them.  Adding a retry to the dma-disable logic appears to
fix the problem:

[   10.774941] mt7921e 0000:1d:00.0: ASIC revision: 79610010
[   10.776284] mt7921e 0000:1d:00.0: mt7921_dma_disable failed with timeout, force: 1
[   10.776285] mt7921e 0000:1d:00.0: mt7921_dma_disable failed: -110 (try 0/3)
[   10.778282] mt7921e 0000:1c:00.0: HW/SW Version: 0x8a108a10, Build Time: 20230117170855a
[   10.788427] mt7921e 0000:1c:00.0: WM Firmware Version: ____010000, Build Time: 20230117170942
[   10.852198] mt7921e 0000:1d:00.0: HW/SW Version: 0x8a108a10, Build Time: 20230117170855a
[   10.862222] mt7921e 0000:1d:00.0: WM Firmware Version: ____010000, Build Time: 20230117170942

Add additional logging to find other errors that could keep the radio from working
at all.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../net/wireless/mediatek/mt76/mt7921/dma.c   | 56 ++++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7921/pci.c   | 34 ++++++++---
 2 files changed, 69 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index d1f10f6d9adc..54308ebbc39d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -92,8 +92,11 @@ static int mt7921_dma_disable(struct mt7921_dev *dev, bool force)
 
 	if (!mt76_poll(dev, MT_WFDMA0_GLO_CFG,
 		       MT_WFDMA0_GLO_CFG_TX_DMA_BUSY |
-		       MT_WFDMA0_GLO_CFG_RX_DMA_BUSY, 0, 1000))
+		       MT_WFDMA0_GLO_CFG_RX_DMA_BUSY, 0, 1000)) {
+		dev_info(dev->mt76.dev,
+			 "%s failed with timeout, force: %d", __func__, force);
 		return -ETIMEDOUT;
+	}
 
 	return 0;
 }
@@ -224,70 +227,97 @@ int mt7921_wpdma_reinit_cond(struct mt7921_dev *dev)
 int mt7921_dma_init(struct mt7921_dev *dev)
 {
 	int ret;
+	int i;
 
 	mt76_dma_attach(&dev->mt76);
 
-	ret = mt7921_dma_disable(dev, true);
-	if (ret)
-		return ret;
+	for (i = 0; i < 3; i++) {
+		ret = mt7921_dma_disable(dev, true);
+		if (ret == 0)
+			break;
+		dev_info(dev->mt76.dev,
+			 "mt7921_dma_disable failed: %d (try %d/3)", ret, i);
+	}
+
+	if (ret < 0)
+		return ret; /* all dma disable retries failed */
 
 	ret = mt7921_wfsys_reset(dev);
-	if (ret)
+	if (ret) {
+		dev_info(dev->mt76.dev, "mt7921_wfsys_reset failed: %d", ret);
 		return ret;
+	}
 
 	/* init tx queue */
 	ret = mt76_connac_init_tx_queues(dev->phy.mt76, MT7921_TXQ_BAND0,
 					 MT7921_TX_RING_SIZE,
 					 MT_TX_RING_BASE, 0);
-	if (ret)
+	if (ret) {
+		dev_info(dev->mt76.dev, "mt76_connac_init_tx_queues failed: %d", ret);
 		return ret;
+	}
 
 	mt76_wr(dev, MT_WFDMA0_TX_RING0_EXT_CTRL, 0x4);
 
 	/* command to WM */
 	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_WM, MT7921_TXQ_MCU_WM,
 				  MT7921_TX_MCU_RING_SIZE, MT_TX_RING_BASE);
-	if (ret)
+	if (ret) {
+		dev_info(dev->mt76.dev, "mt76_init_mcu_queue failed: %d", ret);
 		return ret;
+	}
 
 	/* firmware download */
 	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_FWDL, MT7921_TXQ_FWDL,
 				  MT7921_TX_FWDL_RING_SIZE, MT_TX_RING_BASE);
-	if (ret)
+	if (ret) {
+		dev_info(dev->mt76.dev, "mt76_init_mcu_queue failed: %d", ret);
 		return ret;
+	}
 
 	/* event from WM before firmware download */
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU],
 			       MT7921_RXQ_MCU_WM,
 			       MT7921_RX_MCU_RING_SIZE,
 			       MT_RX_BUF_SIZE, MT_RX_EVENT_RING_BASE);
-	if (ret)
+	if (ret) {
+		dev_info(dev->mt76.dev, "mt76_queue_alloc failed: %d", ret);
 		return ret;
+	}
 
 	/* Change mcu queue after firmware download */
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU_WA],
 			       MT7921_RXQ_MCU_WM,
 			       MT7921_RX_MCU_RING_SIZE,
 			       MT_RX_BUF_SIZE, MT_WFDMA0(0x540));
-	if (ret)
+	if (ret) {
+		dev_info(dev->mt76.dev, "mt76_queue_alloc (after-fw-download) failed: %d", ret);
 		return ret;
+	}
 
 	/* rx data */
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN],
 			       MT7921_RXQ_BAND0, MT7921_RX_RING_SIZE,
 			       MT_RX_BUF_SIZE, MT_RX_DATA_RING_BASE);
-	if (ret)
+	if (ret) {
+		dev_info(dev->mt76.dev, "mt76_queue_alloc (rx-data) failed: %d", ret);
 		return ret;
+	}
 
 	ret = mt76_init_queues(dev, mt7921_poll_rx);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_info(dev->mt76.dev, "mt76_init_queues failed: %d", ret);
 		return ret;
+	}
 
 	netif_napi_add_tx(&dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
 			  mt7921_poll_tx);
 	napi_enable(&dev->mt76.tx_napi);
 
-	return mt7921_dma_enable(dev);
+	ret = mt7921_dma_enable(dev);
+	if (ret < 0)
+		dev_info(dev->mt76.dev, "mt7921_dma_enable failed: %d", ret);
+	return ret;
 }
 
 void mt7921_dma_cleanup(struct mt7921_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 7c923bb97c5d..e6e72c85c8d4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -262,22 +262,30 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	int ret;
 
 	ret = pcim_enable_device(pdev);
-	if (ret)
+	if (ret) {
+		pr_info("pcim_enable_device failed: %d\n", ret);
 		return ret;
+	}
 
 	ret = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
-	if (ret)
+	if (ret) {
+		pr_info("pcim_iomap_regions failed: %d\n", ret);
 		return ret;
+	}
 
 	pci_set_master(pdev);
 
 	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
-	if (ret < 0)
+	if (ret < 0) {
+		pr_info("pci_alloc_irq_vectors failed: %d\n", ret);
 		return ret;
+	}
 
 	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
-	if (ret)
+	if (ret) {
+		pr_info("dma_set_mask failed: %d\n", ret);
 		goto err_free_pci_vec;
+	}
 
 	if (mt7921_disable_aspm)
 		mt76_pci_disable_aspm(pdev);
@@ -285,6 +293,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	mdev = mt76_alloc_device(&pdev->dev, sizeof(*dev), &mt7921_ops,
 				 &drv_ops);
 	if (!mdev) {
+		pr_info("mt76_alloc_device failed (ENOMEM?)\n");
 		ret = -ENOMEM;
 		goto err_free_pci_vec;
 	}
@@ -304,6 +313,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	bus_ops = devm_kmemdup(dev->mt76.dev, dev->bus_ops, sizeof(*bus_ops),
 			       GFP_KERNEL);
 	if (!bus_ops) {
+		dev_info(mdev->dev, "devm_kmemdup bus-opps failed (ENOMEM?)\n");
 		ret = -ENOMEM;
 		goto err_free_dev;
 	}
@@ -314,8 +324,10 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	dev->mt76.bus = bus_ops;
 
 	ret = __mt7921e_mcu_drv_pmctrl(dev);
-	if (ret)
+	if (ret) {
+		dev_info(mdev->dev, "__mt7921e_mcu_drv_pmctrl failed: %d\n", ret);
 		goto err_free_dev;
+	}
 
 	mdev->rev = (mt7921_l1_rr(dev, MT_HW_CHIPID) << 16) |
 		    (mt7921_l1_rr(dev, MT_HW_REV) & 0xff);
@@ -327,16 +339,22 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 
 	ret = devm_request_irq(mdev->dev, pdev->irq, mt7921_irq_handler,
 			       IRQF_SHARED, KBUILD_MODNAME, dev);
-	if (ret)
+	if (ret) {
+		dev_info(mdev->dev, "devm_request_irq failed: %d\n", ret);
 		goto err_free_dev;
+	}
 
 	ret = mt7921_dma_init(dev);
-	if (ret)
+	if (ret) {
+		dev_info(mdev->dev, "mt7921_dma_init failed: %d\n", ret);
 		goto err_free_irq;
+	}
 
 	ret = mt7921_register_device(dev);
-	if (ret)
+	if (ret) {
+		dev_info(mdev->dev, "mt7921_register_device failed failed: %d\n", ret);
 		goto err_free_irq;
+	}
 
 	return 0;
 
-- 
2.39.1

