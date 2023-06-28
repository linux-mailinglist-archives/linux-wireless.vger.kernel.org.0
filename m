Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EF7740A00
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 09:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjF1H4I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 03:56:08 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52848 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231153AbjF1HyL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 03:54:11 -0400
X-UUID: a7043dbc158211eeb20a276fd37b9834-20230628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Ssrrmj/mmvB/nghm1CoEY8Iw7VKaaHOiuZ9eqsUUwyE=;
        b=ecmyU7dH2of3YTVtwc/I0rRdS4TnlTpyTea9LgolAdc7v+NGl0mmHd/Vmt/oaJhMwdYpErWHqrRCR4x4uzcc7RvqPz256YTtHZqL4QvmF5ETV3K3VFATyg5c8rSgiQfONShEcBz/DUJ0aeGhGyi8jaXovoLxrdjI4ZRU6ycx4b0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:11b152c4-fce8-4279-9d47-7c714a2fa14c,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.27,REQID:11b152c4-fce8-4279-9d47-7c714a2fa14c,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:01c9525,CLOUDID:ad889b0d-c22b-45ab-8a43-3004e9216b56,B
        ulkID:230628150859GEWO2UM1,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD,TF_CID_SPAM_ULN
X-UUID: a7043dbc158211eeb20a276fd37b9834-20230628
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1113607770; Wed, 28 Jun 2023 15:08:58 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Jun 2023 15:08:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Jun 2023 15:08:57 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 01/11] wifi: mt76: mt792x: move more dma shared code in mt792x_dma
Date:   Wed, 28 Jun 2023 15:07:14 +0800
Message-ID: <6564f618f3acad04692d38c815cbeb8f0714d437.1687920269.git.deren.wu@mediatek.com>
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

Rely on irq_map support, move more dma shared code between mt7921 and
mt7925 in mt792x_dma.c
Move the following dma code in mt792x-lib
- mt792x_dma_enable
- mt792x_dma_reset
- mt792x_wpdma_reset
- mt792x_wpdma_reinit_cond

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/Makefile   |   2 +-
 .../net/wireless/mediatek/mt76/mt7921/dma.c   | 156 +-------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   2 -
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  88 +----
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   |   2 +-
 .../wireless/mediatek/mt76/mt7921/pci_mcu.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h   |   9 +-
 .../net/wireless/mediatek/mt76/mt792x_core.c  |  96 -----
 .../net/wireless/mediatek/mt76/mt792x_dma.c   | 344 ++++++++++++++++++
 9 files changed, 364 insertions(+), 337 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_dma.c

diff --git a/drivers/net/wireless/mediatek/mt76/Makefile b/drivers/net/wireless/mediatek/mt76/Makefile
index a45853ab958f..d6231948dd6e 100644
--- a/drivers/net/wireless/mediatek/mt76/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/Makefile
@@ -32,7 +32,7 @@ mt76x02-usb-y := mt76x02_usb_mcu.o mt76x02_usb_core.o
 mt76-connac-lib-y := mt76_connac_mcu.o mt76_connac_mac.o mt76_connac3_mac.o
 
 mt792x-lib-y := mt792x_core.o mt792x_mac.o mt792x_trace.o \
-		mt792x_debugfs.o
+		mt792x_debugfs.o mt792x_dma.o
 
 obj-$(CONFIG_MT76x0_COMMON) += mt76x0/
 obj-$(CONFIG_MT76x2_COMMON) += mt76x2/
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index 1ac66526eb02..fdc598e099f6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -5,158 +5,6 @@
 #include "../dma.h"
 #include "../mt76_connac2_mac.h"
 
-static int mt7921_poll_tx(struct napi_struct *napi, int budget)
-{
-	struct mt792x_dev *dev;
-
-	dev = container_of(napi, struct mt792x_dev, mt76.tx_napi);
-
-	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm)) {
-		napi_complete(napi);
-		queue_work(dev->mt76.wq, &dev->pm.wake_work);
-		return 0;
-	}
-
-	mt76_connac_tx_cleanup(&dev->mt76);
-	if (napi_complete(napi))
-		mt76_connac_irq_enable(&dev->mt76,
-				       dev->irq_map->tx.all_complete_mask);
-	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
-
-	return 0;
-}
-
-static void mt7921_dma_prefetch(struct mt792x_dev *dev)
-{
-#define PREFETCH(base, depth)	((base) << 16 | (depth))
-
-	mt76_wr(dev, MT_WFDMA0_RX_RING0_EXT_CTRL, PREFETCH(0x0, 0x4));
-	mt76_wr(dev, MT_WFDMA0_RX_RING2_EXT_CTRL, PREFETCH(0x40, 0x4));
-	mt76_wr(dev, MT_WFDMA0_RX_RING3_EXT_CTRL, PREFETCH(0x80, 0x4));
-	mt76_wr(dev, MT_WFDMA0_RX_RING4_EXT_CTRL, PREFETCH(0xc0, 0x4));
-	mt76_wr(dev, MT_WFDMA0_RX_RING5_EXT_CTRL, PREFETCH(0x100, 0x4));
-
-	mt76_wr(dev, MT_WFDMA0_TX_RING0_EXT_CTRL, PREFETCH(0x140, 0x4));
-	mt76_wr(dev, MT_WFDMA0_TX_RING1_EXT_CTRL, PREFETCH(0x180, 0x4));
-	mt76_wr(dev, MT_WFDMA0_TX_RING2_EXT_CTRL, PREFETCH(0x1c0, 0x4));
-	mt76_wr(dev, MT_WFDMA0_TX_RING3_EXT_CTRL, PREFETCH(0x200, 0x4));
-	mt76_wr(dev, MT_WFDMA0_TX_RING4_EXT_CTRL, PREFETCH(0x240, 0x4));
-	mt76_wr(dev, MT_WFDMA0_TX_RING5_EXT_CTRL, PREFETCH(0x280, 0x4));
-	mt76_wr(dev, MT_WFDMA0_TX_RING6_EXT_CTRL, PREFETCH(0x2c0, 0x4));
-	mt76_wr(dev, MT_WFDMA0_TX_RING16_EXT_CTRL, PREFETCH(0x340, 0x4));
-	mt76_wr(dev, MT_WFDMA0_TX_RING17_EXT_CTRL, PREFETCH(0x380, 0x4));
-}
-
-static int mt7921_dma_enable(struct mt792x_dev *dev)
-{
-	/* configure perfetch settings */
-	mt7921_dma_prefetch(dev);
-
-	/* reset dma idx */
-	mt76_wr(dev, MT_WFDMA0_RST_DTX_PTR, ~0);
-
-	/* configure delay interrupt */
-	mt76_wr(dev, MT_WFDMA0_PRI_DLY_INT_CFG0, 0);
-
-	mt76_set(dev, MT_WFDMA0_GLO_CFG,
-		 MT_WFDMA0_GLO_CFG_TX_WB_DDONE |
-		 MT_WFDMA0_GLO_CFG_FIFO_LITTLE_ENDIAN |
-		 MT_WFDMA0_GLO_CFG_CLK_GAT_DIS |
-		 MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
-		 MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN |
-		 MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
-
-	mt76_set(dev, MT_WFDMA0_GLO_CFG,
-		 MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
-
-	mt76_set(dev, MT_WFDMA_DUMMY_CR, MT_WFDMA_NEED_REINIT);
-
-	/* enable interrupts for TX/RX rings */
-	mt76_connac_irq_enable(&dev->mt76,
-			       dev->irq_map->tx.all_complete_mask |
-			       MT_INT_RX_DONE_ALL | MT_INT_MCU_CMD);
-	mt76_set(dev, MT_MCU2HOST_SW_INT_ENA, MT_MCU_CMD_WAKE_RX_PCIE);
-
-	return 0;
-}
-
-static int mt7921_dma_reset(struct mt792x_dev *dev, bool force)
-{
-	int i, err;
-
-	err = mt792x_dma_disable(dev, force);
-	if (err)
-		return err;
-
-	/* reset hw queues */
-	for (i = 0; i < __MT_TXQ_MAX; i++)
-		mt76_queue_reset(dev, dev->mphy.q_tx[i]);
-
-	for (i = 0; i < __MT_MCUQ_MAX; i++)
-		mt76_queue_reset(dev, dev->mt76.q_mcu[i]);
-
-	mt76_for_each_q_rx(&dev->mt76, i)
-		mt76_queue_reset(dev, &dev->mt76.q_rx[i]);
-
-	mt76_tx_status_check(&dev->mt76, true);
-
-	return mt7921_dma_enable(dev);
-}
-
-int mt7921_wpdma_reset(struct mt792x_dev *dev, bool force)
-{
-	int i, err;
-
-	/* clean up hw queues */
-	for (i = 0; i < ARRAY_SIZE(dev->mt76.phy.q_tx); i++)
-		mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[i], true);
-
-	for (i = 0; i < ARRAY_SIZE(dev->mt76.q_mcu); i++)
-		mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[i], true);
-
-	mt76_for_each_q_rx(&dev->mt76, i)
-		mt76_queue_rx_cleanup(dev, &dev->mt76.q_rx[i]);
-
-	if (force) {
-		err = mt792x_wfsys_reset(dev, MT_WFSYS_SW_RST_B);
-		if (err)
-			return err;
-	}
-	err = mt7921_dma_reset(dev, force);
-	if (err)
-		return err;
-
-	mt76_for_each_q_rx(&dev->mt76, i)
-		mt76_queue_rx_reset(dev, i);
-
-	return 0;
-}
-
-int mt7921_wpdma_reinit_cond(struct mt792x_dev *dev)
-{
-	struct mt76_connac_pm *pm = &dev->pm;
-	int err;
-
-	/* check if the wpdma must be reinitialized */
-	if (mt792x_dma_need_reinit(dev)) {
-		/* disable interrutpts */
-		mt76_wr(dev, dev->irq_map->host_irq_enable, 0);
-		mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
-
-		err = mt7921_wpdma_reset(dev, false);
-		if (err) {
-			dev_err(dev->mt76.dev, "wpdma reset failed\n");
-			return err;
-		}
-
-		/* enable interrutpts */
-		mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
-		pm->stats.lp_wake++;
-	}
-
-	return 0;
-}
-
 int mt7921_dma_init(struct mt792x_dev *dev)
 {
 	int ret;
@@ -216,8 +64,8 @@ int mt7921_dma_init(struct mt792x_dev *dev)
 		return ret;
 
 	netif_napi_add_tx(&dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
-			  mt7921_poll_tx);
+			  mt792x_poll_tx);
 	napi_enable(&dev->mt76.tx_napi);
 
-	return mt7921_dma_enable(dev);
+	return mt792x_dma_enable(dev);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index fc952c30ca07..b797d8bab5e2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -203,8 +203,6 @@ int __mt7921_start(struct mt792x_phy *phy);
 int mt7921_register_device(struct mt792x_dev *dev);
 void mt7921_unregister_device(struct mt792x_dev *dev);
 int mt7921_dma_init(struct mt792x_dev *dev);
-int mt7921_wpdma_reset(struct mt792x_dev *dev, bool force);
-int mt7921_wpdma_reinit_cond(struct mt792x_dev *dev);
 int mt7921_run_firmware(struct mt792x_dev *dev);
 int mt7921_mcu_set_bss_pm(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 			  bool enable);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 606a7e41a240..d11406c87df7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -10,7 +10,6 @@
 #include "mt7921.h"
 #include "../mt76_connac2_mac.h"
 #include "mcu.h"
-#include "../trace.h"
 
 static const struct pci_device_id mt7921_pci_device_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7961),
@@ -28,82 +27,9 @@ static bool mt7921_disable_aspm;
 module_param_named(disable_aspm, mt7921_disable_aspm, bool, 0644);
 MODULE_PARM_DESC(disable_aspm, "disable PCI ASPM support");
 
-static void
-mt7921_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q)
-{
-	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
-	const struct mt792x_irq_map *irq_map = dev->irq_map;
-
-	if (q == MT_RXQ_MAIN)
-		mt76_connac_irq_enable(mdev, irq_map->rx.data_complete_mask);
-	else if (q == MT_RXQ_MCU_WA)
-		mt76_connac_irq_enable(mdev, irq_map->rx.wm2_complete_mask);
-	else
-		mt76_connac_irq_enable(mdev, irq_map->rx.wm_complete_mask);
-}
-
-static irqreturn_t mt7921_irq_handler(int irq, void *dev_instance)
-{
-	struct mt792x_dev *dev = dev_instance;
-
-	mt76_wr(dev, dev->irq_map->host_irq_enable, 0);
-
-	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
-		return IRQ_NONE;
-
-	tasklet_schedule(&dev->mt76.irq_tasklet);
-
-	return IRQ_HANDLED;
-}
-
-static void mt7921_irq_tasklet(unsigned long data)
-{
-	struct mt792x_dev *dev = (struct mt792x_dev *)data;
-	const struct mt792x_irq_map *irq_map = dev->irq_map;
-	u32 intr, mask = 0;
-
-	mt76_wr(dev, irq_map->host_irq_enable, 0);
-
-	intr = mt76_rr(dev, MT_WFDMA0_HOST_INT_STA);
-	intr &= dev->mt76.mmio.irqmask;
-	mt76_wr(dev, MT_WFDMA0_HOST_INT_STA, intr);
-
-	trace_dev_irq(&dev->mt76, intr, dev->mt76.mmio.irqmask);
-
-	mask |= intr & MT_INT_RX_DONE_ALL;
-	if (intr & irq_map->tx.mcu_complete_mask)
-		mask |= irq_map->tx.mcu_complete_mask;
-
-	if (intr & MT_INT_MCU_CMD) {
-		u32 intr_sw;
-
-		intr_sw = mt76_rr(dev, MT_MCU_CMD);
-		/* ack MCU2HOST_SW_INT_STA */
-		mt76_wr(dev, MT_MCU_CMD, intr_sw);
-		if (intr_sw & MT_MCU_CMD_WAKE_RX_PCIE) {
-			mask |= irq_map->rx.data_complete_mask;
-			intr |= irq_map->rx.data_complete_mask;
-		}
-	}
-
-	mt76_set_irq_mask(&dev->mt76, irq_map->host_irq_enable, mask, 0);
-
-	if (intr & irq_map->tx.all_complete_mask)
-		napi_schedule(&dev->mt76.tx_napi);
-
-	if (intr & irq_map->rx.wm_complete_mask)
-		napi_schedule(&dev->mt76.napi[MT_RXQ_MCU]);
-
-	if (intr & irq_map->rx.wm2_complete_mask)
-		napi_schedule(&dev->mt76.napi[MT_RXQ_MCU_WA]);
-
-	if (intr & irq_map->rx.data_complete_mask)
-		napi_schedule(&dev->mt76.napi[MT_RXQ_MAIN]);
-}
-
 static int mt7921e_init_reset(struct mt792x_dev *dev)
 {
-	return mt7921_wpdma_reset(dev, true);
+	return mt792x_wpdma_reset(dev, true);
 }
 
 static void mt7921e_unregister_device(struct mt792x_dev *dev)
@@ -122,7 +48,7 @@ static void mt7921e_unregister_device(struct mt792x_dev *dev)
 	mt76_connac2_tx_token_put(&dev->mt76);
 	__mt7921_mcu_drv_pmctrl(dev);
 	mt792x_dma_cleanup(dev);
-	mt792x_wfsys_reset(dev, MT_WFSYS_SW_RST_B);
+	mt792x_wfsys_reset(dev);
 	skb_queue_purge(&dev->mt76.mcu.res_q);
 
 	tasklet_disable(&dev->mt76.irq_tasklet);
@@ -245,7 +171,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 		.tx_complete_skb = mt76_connac_tx_complete_skb,
 		.rx_check = mt7921_rx_check,
 		.rx_skb = mt7921_queue_rx_skb,
-		.rx_poll_complete = mt7921_rx_poll_complete,
+		.rx_poll_complete = mt792x_rx_poll_complete,
 		.sta_add = mt7921_mac_sta_add,
 		.sta_assoc = mt7921_mac_sta_assoc,
 		.sta_remove = mt7921_mac_sta_remove,
@@ -324,7 +250,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	dev->hif_ops = &mt7921_pcie_ops;
 	dev->irq_map = &irq_map;
 	mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
-	tasklet_init(&mdev->irq_tasklet, mt7921_irq_tasklet, (unsigned long)dev);
+	tasklet_init(&mdev->irq_tasklet, mt792x_irq_tasklet, (unsigned long)dev);
 
 	dev->phy.dev = dev;
 	dev->phy.mt76 = &dev->mt76.phy;
@@ -354,7 +280,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 		    (mt7921_l1_rr(dev, MT_HW_REV) & 0xff);
 	dev_info(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
 
-	ret = mt792x_wfsys_reset(dev, MT_WFSYS_SW_RST_B);
+	ret = mt792x_wfsys_reset(dev);
 	if (ret)
 		goto err_free_dev;
 
@@ -362,7 +288,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
 
-	ret = devm_request_irq(mdev->dev, pdev->irq, mt7921_irq_handler,
+	ret = devm_request_irq(mdev->dev, pdev->irq, mt792x_irq_handler,
 			       IRQF_SHARED, KBUILD_MODNAME, dev);
 	if (ret)
 		goto err_free_dev;
@@ -484,7 +410,7 @@ static int mt7921_pci_resume(struct device *device)
 	if (err < 0)
 		goto failed;
 
-	mt7921_wpdma_reinit_cond(dev);
+	mt792x_wpdma_reinit_cond(dev);
 
 	/* enable interrupt */
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index 1f508244d615..bd3f004d1a18 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -80,7 +80,7 @@ int mt7921e_mac_reset(struct mt792x_dev *dev)
 	mt76_connac2_tx_token_put(&dev->mt76);
 	idr_init(&dev->mt76.token);
 
-	mt7921_wpdma_reset(dev, true);
+	mt792x_wpdma_reset(dev, true);
 
 	local_bh_disable();
 	mt76_for_each_q_rx(&dev->mt76, i) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
index 5a30cd0b9382..57bd02746f5f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
@@ -91,7 +91,7 @@ int mt7921e_mcu_drv_pmctrl(struct mt792x_dev *dev)
 	if (err < 0)
 		goto out;
 
-	mt7921_wpdma_reinit_cond(dev);
+	mt792x_wpdma_reinit_cond(dev);
 	clear_bit(MT76_STATE_PM, &mphy->state);
 
 	pm->stats.last_wake_event = jiffies;
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 6fd1f542da17..894fb0fe8cba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -256,9 +256,16 @@ void mt792x_sta_statistics(struct ieee80211_hw *hw,
 			   struct station_info *sinfo);
 void mt792x_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class);
 void mt792x_dma_cleanup(struct mt792x_dev *dev);
+int mt792x_dma_enable(struct mt792x_dev *dev);
+int mt792x_wpdma_reset(struct mt792x_dev *dev, bool force);
+int mt792x_wpdma_reinit_cond(struct mt792x_dev *dev);
 int mt792x_dma_disable(struct mt792x_dev *dev, bool force);
+irqreturn_t mt792x_irq_handler(int irq, void *dev_instance);
+void mt792x_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q);
+int mt792x_poll_tx(struct napi_struct *napi, int budget);
 int mt792x_poll_rx(struct napi_struct *napi, int budget);
-int mt792x_wfsys_reset(struct mt792x_dev *dev, u32 addr);
+void mt792x_irq_tasklet(unsigned long data);
+int mt792x_wfsys_reset(struct mt792x_dev *dev);
 int mt792x_tx_stats_show(struct seq_file *file, void *data);
 int mt792x_queues_acq(struct seq_file *s, void *data);
 int mt792x_queues_read(struct seq_file *s, void *data);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 87d2a614e590..a4aa9694de7f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -510,102 +510,6 @@ void mt792x_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
 }
 EXPORT_SYMBOL_GPL(mt792x_set_coverage_class);
 
-int mt792x_dma_disable(struct mt792x_dev *dev, bool force)
-{
-	/* disable WFDMA0 */
-	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
-		   MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN |
-		   MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN |
-		   MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
-		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO |
-		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
-
-	if (!mt76_poll_msec_tick(dev, MT_WFDMA0_GLO_CFG,
-				 MT_WFDMA0_GLO_CFG_TX_DMA_BUSY |
-				 MT_WFDMA0_GLO_CFG_RX_DMA_BUSY, 0, 100, 1))
-		return -ETIMEDOUT;
-
-	/* disable dmashdl */
-	mt76_clear(dev, MT_WFDMA0_GLO_CFG_EXT0,
-		   MT_WFDMA0_CSR_TX_DMASHDL_ENABLE);
-	mt76_set(dev, MT_DMASHDL_SW_CONTROL, MT_DMASHDL_DMASHDL_BYPASS);
-
-	if (force) {
-		/* reset */
-		mt76_clear(dev, MT_WFDMA0_RST,
-			   MT_WFDMA0_RST_DMASHDL_ALL_RST |
-			   MT_WFDMA0_RST_LOGIC_RST);
-
-		mt76_set(dev, MT_WFDMA0_RST,
-			 MT_WFDMA0_RST_DMASHDL_ALL_RST |
-			 MT_WFDMA0_RST_LOGIC_RST);
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(mt792x_dma_disable);
-
-void mt792x_dma_cleanup(struct mt792x_dev *dev)
-{
-	/* disable */
-	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
-		   MT_WFDMA0_GLO_CFG_TX_DMA_EN |
-		   MT_WFDMA0_GLO_CFG_RX_DMA_EN |
-		   MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN |
-		   MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
-		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO |
-		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
-
-	mt76_poll_msec_tick(dev, MT_WFDMA0_GLO_CFG,
-			    MT_WFDMA0_GLO_CFG_TX_DMA_BUSY |
-			    MT_WFDMA0_GLO_CFG_RX_DMA_BUSY, 0, 100, 1);
-
-	/* reset */
-	mt76_clear(dev, MT_WFDMA0_RST,
-		   MT_WFDMA0_RST_DMASHDL_ALL_RST |
-		   MT_WFDMA0_RST_LOGIC_RST);
-
-	mt76_set(dev, MT_WFDMA0_RST,
-		 MT_WFDMA0_RST_DMASHDL_ALL_RST |
-		 MT_WFDMA0_RST_LOGIC_RST);
-
-	mt76_dma_cleanup(&dev->mt76);
-}
-EXPORT_SYMBOL_GPL(mt792x_dma_cleanup);
-
-int mt792x_poll_rx(struct napi_struct *napi, int budget)
-{
-	struct mt792x_dev *dev;
-	int done;
-
-	dev = container_of(napi->dev, struct mt792x_dev, mt76.napi_dev);
-
-	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm)) {
-		napi_complete(napi);
-		queue_work(dev->mt76.wq, &dev->pm.wake_work);
-		return 0;
-	}
-	done = mt76_dma_rx_poll(napi, budget);
-	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
-
-	return done;
-}
-EXPORT_SYMBOL_GPL(mt792x_poll_rx);
-
-int mt792x_wfsys_reset(struct mt792x_dev *dev, u32 addr)
-{
-	mt76_clear(dev, addr, WFSYS_SW_RST_B);
-	msleep(50);
-	mt76_set(dev, addr, WFSYS_SW_RST_B);
-
-	if (!__mt76_poll_msec(&dev->mt76, addr, WFSYS_SW_INIT_DONE,
-			      WFSYS_SW_INIT_DONE, 500))
-		return -ETIMEDOUT;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(mt792x_wfsys_reset);
-
 int mt792x_init_wiphy(struct ieee80211_hw *hw)
 {
 	struct mt792x_phy *phy = mt792x_hw_phy(hw);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
new file mode 100644
index 000000000000..a3dbd3865b2f
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2023 MediaTek Inc. */
+
+#include <linux/module.h>
+#include <linux/firmware.h>
+
+#include "mt792x.h"
+#include "dma.h"
+#include "trace.h"
+
+irqreturn_t mt792x_irq_handler(int irq, void *dev_instance)
+{
+	struct mt792x_dev *dev = dev_instance;
+
+	mt76_wr(dev, dev->irq_map->host_irq_enable, 0);
+
+	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
+		return IRQ_NONE;
+
+	tasklet_schedule(&dev->mt76.irq_tasklet);
+
+	return IRQ_HANDLED;
+}
+EXPORT_SYMBOL_GPL(mt792x_irq_handler);
+
+void mt792x_irq_tasklet(unsigned long data)
+{
+	struct mt792x_dev *dev = (struct mt792x_dev *)data;
+	const struct mt792x_irq_map *irq_map = dev->irq_map;
+	u32 intr, mask = 0;
+
+	mt76_wr(dev, irq_map->host_irq_enable, 0);
+
+	intr = mt76_rr(dev, MT_WFDMA0_HOST_INT_STA);
+	intr &= dev->mt76.mmio.irqmask;
+	mt76_wr(dev, MT_WFDMA0_HOST_INT_STA, intr);
+
+	trace_dev_irq(&dev->mt76, intr, dev->mt76.mmio.irqmask);
+
+	mask |= intr & (irq_map->rx.data_complete_mask |
+			irq_map->rx.wm_complete_mask |
+			irq_map->rx.wm2_complete_mask);
+	if (intr & dev->irq_map->tx.mcu_complete_mask)
+		mask |= dev->irq_map->tx.mcu_complete_mask;
+
+	if (intr & MT_INT_MCU_CMD) {
+		u32 intr_sw;
+
+		intr_sw = mt76_rr(dev, MT_MCU_CMD);
+		/* ack MCU2HOST_SW_INT_STA */
+		mt76_wr(dev, MT_MCU_CMD, intr_sw);
+		if (intr_sw & MT_MCU_CMD_WAKE_RX_PCIE) {
+			mask |= irq_map->rx.data_complete_mask;
+			intr |= irq_map->rx.data_complete_mask;
+		}
+	}
+
+	mt76_set_irq_mask(&dev->mt76, irq_map->host_irq_enable, mask, 0);
+
+	if (intr & dev->irq_map->tx.all_complete_mask)
+		napi_schedule(&dev->mt76.tx_napi);
+
+	if (intr & irq_map->rx.wm_complete_mask)
+		napi_schedule(&dev->mt76.napi[MT_RXQ_MCU]);
+
+	if (intr & irq_map->rx.wm2_complete_mask)
+		napi_schedule(&dev->mt76.napi[MT_RXQ_MCU_WA]);
+
+	if (intr & irq_map->rx.data_complete_mask)
+		napi_schedule(&dev->mt76.napi[MT_RXQ_MAIN]);
+}
+EXPORT_SYMBOL_GPL(mt792x_irq_tasklet);
+
+void mt792x_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q)
+{
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	const struct mt792x_irq_map *irq_map = dev->irq_map;
+
+	if (q == MT_RXQ_MAIN)
+		mt76_connac_irq_enable(mdev, irq_map->rx.data_complete_mask);
+	else if (q == MT_RXQ_MCU_WA)
+		mt76_connac_irq_enable(mdev, irq_map->rx.wm2_complete_mask);
+	else
+		mt76_connac_irq_enable(mdev, irq_map->rx.wm_complete_mask);
+}
+EXPORT_SYMBOL_GPL(mt792x_rx_poll_complete);
+
+#define PREFETCH(base, depth)	((base) << 16 | (depth))
+static void mt792x_dma_prefetch(struct mt792x_dev *dev)
+{
+	mt76_wr(dev, MT_WFDMA0_RX_RING0_EXT_CTRL, PREFETCH(0x0, 0x4));
+	mt76_wr(dev, MT_WFDMA0_RX_RING2_EXT_CTRL, PREFETCH(0x40, 0x4));
+	mt76_wr(dev, MT_WFDMA0_RX_RING3_EXT_CTRL, PREFETCH(0x80, 0x4));
+	mt76_wr(dev, MT_WFDMA0_RX_RING4_EXT_CTRL, PREFETCH(0xc0, 0x4));
+	mt76_wr(dev, MT_WFDMA0_RX_RING5_EXT_CTRL, PREFETCH(0x100, 0x4));
+
+	mt76_wr(dev, MT_WFDMA0_TX_RING0_EXT_CTRL, PREFETCH(0x140, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING1_EXT_CTRL, PREFETCH(0x180, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING2_EXT_CTRL, PREFETCH(0x1c0, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING3_EXT_CTRL, PREFETCH(0x200, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING4_EXT_CTRL, PREFETCH(0x240, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING5_EXT_CTRL, PREFETCH(0x280, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING6_EXT_CTRL, PREFETCH(0x2c0, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING16_EXT_CTRL, PREFETCH(0x340, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING17_EXT_CTRL, PREFETCH(0x380, 0x4));
+}
+
+int mt792x_dma_enable(struct mt792x_dev *dev)
+{
+	/* configure perfetch settings */
+	mt792x_dma_prefetch(dev);
+
+	/* reset dma idx */
+	mt76_wr(dev, MT_WFDMA0_RST_DTX_PTR, ~0);
+
+	/* configure delay interrupt */
+	mt76_wr(dev, MT_WFDMA0_PRI_DLY_INT_CFG0, 0);
+
+	mt76_set(dev, MT_WFDMA0_GLO_CFG,
+		 MT_WFDMA0_GLO_CFG_TX_WB_DDONE |
+		 MT_WFDMA0_GLO_CFG_FIFO_LITTLE_ENDIAN |
+		 MT_WFDMA0_GLO_CFG_CLK_GAT_DIS |
+		 MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+		 MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN |
+		 MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
+
+	mt76_set(dev, MT_WFDMA0_GLO_CFG,
+		 MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
+
+	mt76_set(dev, MT_WFDMA_DUMMY_CR, MT_WFDMA_NEED_REINIT);
+
+	/* enable interrupts for TX/RX rings */
+	mt76_connac_irq_enable(&dev->mt76,
+			       dev->irq_map->tx.all_complete_mask |
+			       dev->irq_map->rx.data_complete_mask |
+			       dev->irq_map->rx.wm2_complete_mask |
+			       dev->irq_map->rx.wm_complete_mask |
+			       MT_INT_MCU_CMD);
+	mt76_set(dev, MT_MCU2HOST_SW_INT_ENA, MT_MCU_CMD_WAKE_RX_PCIE);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt792x_dma_enable);
+
+static int
+mt792x_dma_reset(struct mt792x_dev *dev, bool force)
+{
+	int i, err;
+
+	err = mt792x_dma_disable(dev, force);
+	if (err)
+		return err;
+
+	/* reset hw queues */
+	for (i = 0; i < __MT_TXQ_MAX; i++)
+		mt76_queue_reset(dev, dev->mphy.q_tx[i]);
+
+	for (i = 0; i < __MT_MCUQ_MAX; i++)
+		mt76_queue_reset(dev, dev->mt76.q_mcu[i]);
+
+	mt76_for_each_q_rx(&dev->mt76, i)
+		mt76_queue_reset(dev, &dev->mt76.q_rx[i]);
+
+	mt76_tx_status_check(&dev->mt76, true);
+
+	return mt792x_dma_enable(dev);
+}
+
+int mt792x_wpdma_reset(struct mt792x_dev *dev, bool force)
+{
+	int i, err;
+
+	/* clean up hw queues */
+	for (i = 0; i < ARRAY_SIZE(dev->mt76.phy.q_tx); i++)
+		mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[i], true);
+
+	for (i = 0; i < ARRAY_SIZE(dev->mt76.q_mcu); i++)
+		mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[i], true);
+
+	mt76_for_each_q_rx(&dev->mt76, i)
+		mt76_queue_rx_cleanup(dev, &dev->mt76.q_rx[i]);
+
+	if (force) {
+		err = mt792x_wfsys_reset(dev);
+		if (err)
+			return err;
+	}
+	err = mt792x_dma_reset(dev, force);
+	if (err)
+		return err;
+
+	mt76_for_each_q_rx(&dev->mt76, i)
+		mt76_queue_rx_reset(dev, i);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt792x_wpdma_reset);
+
+int mt792x_wpdma_reinit_cond(struct mt792x_dev *dev)
+{
+	struct mt76_connac_pm *pm = &dev->pm;
+	int err;
+
+	/* check if the wpdma must be reinitialized */
+	if (mt792x_dma_need_reinit(dev)) {
+		/* disable interrutpts */
+		mt76_wr(dev, dev->irq_map->host_irq_enable, 0);
+		mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
+
+		err = mt792x_wpdma_reset(dev, false);
+		if (err) {
+			dev_err(dev->mt76.dev, "wpdma reset failed\n");
+			return err;
+		}
+
+		/* enable interrutpts */
+		mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
+		pm->stats.lp_wake++;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt792x_wpdma_reinit_cond);
+
+int mt792x_dma_disable(struct mt792x_dev *dev, bool force)
+{
+	/* disable WFDMA0 */
+	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
+		   MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN |
+		   MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN |
+		   MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO |
+		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
+
+	if (!mt76_poll_msec_tick(dev, MT_WFDMA0_GLO_CFG,
+				 MT_WFDMA0_GLO_CFG_TX_DMA_BUSY |
+				 MT_WFDMA0_GLO_CFG_RX_DMA_BUSY, 0, 100, 1))
+		return -ETIMEDOUT;
+
+	/* disable dmashdl */
+	mt76_clear(dev, MT_WFDMA0_GLO_CFG_EXT0,
+		   MT_WFDMA0_CSR_TX_DMASHDL_ENABLE);
+	mt76_set(dev, MT_DMASHDL_SW_CONTROL, MT_DMASHDL_DMASHDL_BYPASS);
+
+	if (force) {
+		/* reset */
+		mt76_clear(dev, MT_WFDMA0_RST,
+			   MT_WFDMA0_RST_DMASHDL_ALL_RST |
+			   MT_WFDMA0_RST_LOGIC_RST);
+
+		mt76_set(dev, MT_WFDMA0_RST,
+			 MT_WFDMA0_RST_DMASHDL_ALL_RST |
+			 MT_WFDMA0_RST_LOGIC_RST);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt792x_dma_disable);
+
+void mt792x_dma_cleanup(struct mt792x_dev *dev)
+{
+	/* disable */
+	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
+		   MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+		   MT_WFDMA0_GLO_CFG_RX_DMA_EN |
+		   MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN |
+		   MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO |
+		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
+
+	mt76_poll_msec_tick(dev, MT_WFDMA0_GLO_CFG,
+			    MT_WFDMA0_GLO_CFG_TX_DMA_BUSY |
+			    MT_WFDMA0_GLO_CFG_RX_DMA_BUSY, 0, 100, 1);
+
+	/* reset */
+	mt76_clear(dev, MT_WFDMA0_RST,
+		   MT_WFDMA0_RST_DMASHDL_ALL_RST |
+		   MT_WFDMA0_RST_LOGIC_RST);
+
+	mt76_set(dev, MT_WFDMA0_RST,
+		 MT_WFDMA0_RST_DMASHDL_ALL_RST |
+		 MT_WFDMA0_RST_LOGIC_RST);
+
+	mt76_dma_cleanup(&dev->mt76);
+}
+EXPORT_SYMBOL_GPL(mt792x_dma_cleanup);
+
+int mt792x_poll_tx(struct napi_struct *napi, int budget)
+{
+	struct mt792x_dev *dev;
+
+	dev = container_of(napi, struct mt792x_dev, mt76.tx_napi);
+
+	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm)) {
+		napi_complete(napi);
+		queue_work(dev->mt76.wq, &dev->pm.wake_work);
+		return 0;
+	}
+
+	mt76_connac_tx_cleanup(&dev->mt76);
+	if (napi_complete(napi))
+		mt76_connac_irq_enable(&dev->mt76,
+				       dev->irq_map->tx.all_complete_mask);
+	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt792x_poll_tx);
+
+int mt792x_poll_rx(struct napi_struct *napi, int budget)
+{
+	struct mt792x_dev *dev;
+	int done;
+
+	dev = container_of(napi->dev, struct mt792x_dev, mt76.napi_dev);
+
+	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm)) {
+		napi_complete(napi);
+		queue_work(dev->mt76.wq, &dev->pm.wake_work);
+		return 0;
+	}
+	done = mt76_dma_rx_poll(napi, budget);
+	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
+
+	return done;
+}
+EXPORT_SYMBOL_GPL(mt792x_poll_rx);
+
+int mt792x_wfsys_reset(struct mt792x_dev *dev)
+{
+	u32 addr = is_mt7921(&dev->mt76) ? 0x18000140 : 0x7c000140;
+
+	mt76_clear(dev, addr, WFSYS_SW_RST_B);
+	msleep(50);
+	mt76_set(dev, addr, WFSYS_SW_RST_B);
+
+	if (!__mt76_poll_msec(&dev->mt76, addr, WFSYS_SW_INIT_DONE,
+			      WFSYS_SW_INIT_DONE, 500))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt792x_wfsys_reset);
+
-- 
2.18.0

