Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970657CA39C
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Oct 2023 11:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjJPJKe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Oct 2023 05:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjJPJKc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Oct 2023 05:10:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DB6AB
        for <linux-wireless@vger.kernel.org>; Mon, 16 Oct 2023 02:10:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3E2C433C8;
        Mon, 16 Oct 2023 09:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697447429;
        bh=Ak0QFvH77MLGFgfI6JsaCzO9S99tDGkLifJGZt947IY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mHstVgy3SGRitKWNU7heS4orsHe/TQwLcU7zgcSnkOqXvRS569gDh/PThsKb2Arm/
         MFf3jMAP4XiO2sgAhJvh5uR696W58FNj3vgoXF7d6hM/RtO35xM7awl4SMef3gnYoV
         yvs+bOzLZcrSVxpdg+uL6pNLEwODU1PGJZkqSxLPe6bx3d3uz4ovWvv11dUFRvWTyV
         86mCieRr3NEkHya5LGqxCDdKTIczrWWKwUVXcHyqN+VHMrDQ5dDJ0gN6NMC9dW6WKs
         3BJpAWx4JiO4BwyEk8rAvYeqIfoZ8xdzZGilE25e9kBAeANYUi3WwTxdKEGjjAoWU8
         GuWoQk+Mz0NVw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        shayne.chen@mediatek.com, Bo.Jiao@mediatek.com,
        sujuan.chen@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH v2 12/12] mt76: mt7996: add wed reset support
Date:   Mon, 16 Oct 2023 11:03:45 +0200
Message-ID: <e513fd0bd194b892a9e114e7aceaf3244f5824b9.1697445996.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697445995.git.lorenzo@kernel.org>
References: <cover.1697445995.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce the capability to reset mt7996 chipset if requested by wed
driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c      | 14 ++++--
 .../net/wireless/mediatek/mt76/mt7996/dma.c   | 18 +++++--
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 47 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7996/mmio.c  | 37 +++++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/regs.h  |  7 ++-
 5 files changed, 114 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 71f07deeeaab..d0067b8dbbc8 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -854,10 +854,16 @@ mt76_dma_rx_reset(struct mt76_dev *dev, enum mt76_rxq_id qid)
 
 	/* reset WED rx queues */
 	mt76_dma_wed_setup(dev, q, true);
-	if (!mt76_queue_is_wed_tx_free(q)) {
-		mt76_dma_sync_idx(dev, q);
-		mt76_dma_rx_fill(dev, q, false);
-	}
+
+	if (mt76_queue_is_wed_tx_free(q))
+		return;
+
+	if (mtk_wed_device_active(&dev->mmio.wed) &&
+	    mt76_queue_is_wed_rro(q))
+		return;
+
+	mt76_dma_sync_idx(dev, q);
+	mt76_dma_rx_fill(dev, q, false);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
index 2221d22ccffb..8bc08d993085 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
@@ -621,21 +621,33 @@ void mt7996_dma_reset(struct mt7996_dev *dev, bool force)
 	if (force)
 		mt7996_wfsys_reset(dev);
 
+	if (dev->hif2 && mtk_wed_device_active(&dev->mt76.mmio.wed_hif2))
+		mtk_wed_device_dma_reset(&dev->mt76.mmio.wed_hif2);
+
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed))
+		mtk_wed_device_dma_reset(&dev->mt76.mmio.wed);
+
 	mt7996_dma_disable(dev, force);
+	mt76_dma_wed_reset(&dev->mt76);
 
 	/* reset hw queues */
 	for (i = 0; i < __MT_TXQ_MAX; i++) {
-		mt76_queue_reset(dev, dev->mphy.q_tx[i]);
+		mt76_dma_reset_tx_queue(&dev->mt76, dev->mphy.q_tx[i]);
 		if (phy2)
-			mt76_queue_reset(dev, phy2->q_tx[i]);
+			mt76_dma_reset_tx_queue(&dev->mt76, phy2->q_tx[i]);
 		if (phy3)
-			mt76_queue_reset(dev, phy3->q_tx[i]);
+			mt76_dma_reset_tx_queue(&dev->mt76, phy3->q_tx[i]);
 	}
 
 	for (i = 0; i < __MT_MCUQ_MAX; i++)
 		mt76_queue_reset(dev, dev->mt76.q_mcu[i]);
 
 	mt76_for_each_q_rx(&dev->mt76, i) {
+		if (mtk_wed_device_active(&dev->mt76.mmio.wed))
+			if (mt76_queue_is_wed_rro(&dev->mt76.q_rx[i]) ||
+			    mt76_queue_is_wed_tx_free(&dev->mt76.q_rx[i]))
+				continue;
+
 		mt76_queue_reset(dev, &dev->mt76.q_rx[i]);
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index c79e1b4588b4..236a88b50e97 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1712,6 +1712,10 @@ mt7996_mac_restart(struct mt7996_dev *dev)
 	/* disable all tx/rx napi */
 	mt76_worker_disable(&dev->mt76.tx_worker);
 	mt76_for_each_q_rx(mdev, i) {
+		if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
+		    mt76_queue_is_wed_rro(&mdev->q_rx[i]))
+			continue;
+
 		if (mdev->q_rx[i].ndesc)
 			napi_disable(&dev->mt76.napi[i]);
 	}
@@ -1725,6 +1729,10 @@ mt7996_mac_restart(struct mt7996_dev *dev)
 
 	local_bh_disable();
 	mt76_for_each_q_rx(mdev, i) {
+		if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
+		    mt76_queue_is_wed_rro(&mdev->q_rx[i]))
+			continue;
+
 		if (mdev->q_rx[i].ndesc) {
 			napi_enable(&dev->mt76.napi[i]);
 			napi_schedule(&dev->mt76.napi[i]);
@@ -1896,6 +1904,13 @@ void mt7996_mac_reset_work(struct work_struct *work)
 
 	dev_info(dev->mt76.dev,"\n%s L1 SER recovery start.",
 		 wiphy_name(dev->mt76.hw->wiphy));
+
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed_hif2))
+		mtk_wed_device_stop(&dev->mt76.mmio.wed_hif2);
+
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed))
+		mtk_wed_device_stop(&dev->mt76.mmio.wed);
+
 	ieee80211_stop_queues(mt76_hw(dev));
 	if (phy2)
 		ieee80211_stop_queues(phy2->mt76->hw);
@@ -1915,8 +1930,13 @@ void mt7996_mac_reset_work(struct work_struct *work)
 		cancel_delayed_work_sync(&phy3->mt76->mac_work);
 	}
 	mt76_worker_disable(&dev->mt76.tx_worker);
-	mt76_for_each_q_rx(&dev->mt76, i)
+	mt76_for_each_q_rx(&dev->mt76, i) {
+		if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
+		    mt76_queue_is_wed_rro(&dev->mt76.q_rx[i]))
+			continue;
+
 		napi_disable(&dev->mt76.napi[i]);
+	}
 	napi_disable(&dev->mt76.tx_napi);
 
 	mutex_lock(&dev->mt76.mutex);
@@ -1939,6 +1959,27 @@ void mt7996_mac_reset_work(struct work_struct *work)
 	/* enable DMA Tx/Tx and interrupt */
 	mt7996_dma_start(dev, false, false);
 
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed)) {
+		u32 wed_irq_mask = MT_INT_RRO_RX_DONE | MT_INT_TX_DONE_BAND2 |
+				   dev->mt76.mmio.irqmask;
+
+		if (mtk_wed_get_rx_capa(&dev->mt76.mmio.wed))
+			wed_irq_mask &= ~MT_INT_RX_DONE_RRO_IND;
+
+		mt76_wr(dev, MT_INT_MASK_CSR, wed_irq_mask);
+
+		mtk_wed_device_start_hw_rro(&dev->mt76.mmio.wed, wed_irq_mask,
+					    true);
+		mt7996_irq_enable(dev, wed_irq_mask);
+		mt7996_irq_disable(dev, 0);
+	}
+
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed_hif2)) {
+		mt76_wr(dev, MT_INT_PCIE1_MASK_CSR, MT_INT_TX_RX_DONE_EXT);
+		mtk_wed_device_start(&dev->mt76.mmio.wed_hif2,
+				     MT_INT_TX_RX_DONE_EXT);
+	}
+
 	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
 	clear_bit(MT76_RESET, &dev->mphy.state);
 	if (phy2)
@@ -1948,6 +1989,10 @@ void mt7996_mac_reset_work(struct work_struct *work)
 
 	local_bh_disable();
 	mt76_for_each_q_rx(&dev->mt76, i) {
+		if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
+		    mt76_queue_is_wed_rro(&dev->mt76.q_rx[i]))
+			continue;
+
 		napi_enable(&dev->mt76.napi[i]);
 		napi_schedule(&dev->mt76.napi[i]);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index c7b6d4bd2ded..739d7f53d347 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -6,9 +6,11 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/rtnetlink.h>
 
 #include "mt7996.h"
 #include "mac.h"
+#include "mcu.h"
 #include "../trace.h"
 #include "../dma.h"
 
@@ -195,6 +197,37 @@ static u32 mt7996_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32 val)
 	return dev->bus_ops->rmw(mdev, __mt7996_reg_addr(dev, offset), mask, val);
 }
 
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+static int mt7996_mmio_wed_reset(struct mtk_wed_device *wed)
+{
+	struct mt76_dev *mdev = container_of(wed, struct mt76_dev, mmio.wed);
+	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
+	struct mt76_phy *mphy = &dev->mphy;
+	int ret;
+
+	ASSERT_RTNL();
+
+	if (test_and_set_bit(MT76_STATE_WED_RESET, &mphy->state))
+		return -EBUSY;
+
+	ret = mt7996_mcu_set_ser(dev, UNI_CMD_SER_TRIGGER, UNI_CMD_SER_SET_RECOVER_L1,
+				 mphy->band_idx);
+	if (ret)
+		goto out;
+
+	rtnl_unlock();
+	if (!wait_for_completion_timeout(&mdev->mmio.wed_reset, 20 * HZ)) {
+		dev_err(mdev->dev, "wed reset timeout\n");
+		ret = -ETIMEDOUT;
+	}
+	rtnl_lock();
+out:
+	clear_bit(MT76_STATE_WED_RESET, &mphy->state);
+
+	return ret;
+}
+#endif
+
 int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 			 bool hif2, int *irq)
 {
@@ -311,6 +344,10 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 	wed->wlan.release_rx_buf = mt76_mmio_wed_release_rx_buf;
 	wed->wlan.offload_enable = mt76_mmio_wed_offload_enable;
 	wed->wlan.offload_disable = mt76_mmio_wed_offload_disable;
+	if (!hif2) {
+		wed->wlan.reset = mt7996_mmio_wed_reset;
+		wed->wlan.reset_complete = mt76_mmio_wed_reset_complete;
+	}
 
 	if (mtk_wed_device_attach(wed))
 		return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
index 7cefe8985590..49eb583399c5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -455,8 +455,9 @@ enum base_rev {
 #define MT_INT_RX_DONE_WA_TRI			BIT(3)
 #define MT_INT_RX_TXFREE_MAIN			BIT(17)
 #define MT_INT_RX_TXFREE_TRI			BIT(15)
-#define MT_INT_MCU_CMD				BIT(29)
+#define MT_INT_RX_DONE_BAND2_EXT		BIT(23)
 #define MT_INT_RX_TXFREE_EXT			BIT(26)
+#define MT_INT_MCU_CMD				BIT(29)
 
 #define MT_INT_RX_DONE_RRO_BAND0		BIT(16)
 #define MT_INT_RX_DONE_RRO_BAND1		BIT(16)
@@ -506,6 +507,10 @@ enum base_rev {
 #define MT_INT_TX_DONE_BAND1			BIT(31)
 #define MT_INT_TX_DONE_BAND2			BIT(15)
 
+#define MT_INT_TX_RX_DONE_EXT			(MT_INT_TX_DONE_BAND2 |		\
+						 MT_INT_RX_DONE_BAND2_EXT |	\
+						 MT_INT_RX_TXFREE_EXT)
+
 #define MT_INT_TX_DONE_MCU			(MT_INT_TX_MCU(MT_MCUQ_WA) |	\
 						 MT_INT_TX_MCU(MT_MCUQ_WM) |	\
 						 MT_INT_TX_MCU(MT_MCUQ_FWDL))
-- 
2.41.0

