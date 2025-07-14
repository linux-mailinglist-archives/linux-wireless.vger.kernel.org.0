Return-Path: <linux-wireless+bounces-25395-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15744B0436E
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 17:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A5F3AE4C6
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 15:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BF626058B;
	Mon, 14 Jul 2025 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYd2BCO6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AF226280A
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506228; cv=none; b=O7qjyvPuse9dLNKFPxRocYwv89Qz6TpwAI7hIzLRSBGDN5fP0jDrY3i4jDgzS51RdS835l5zy/VeT47EyLrRqfEjYTt55/X0kPeSXXY3jkedH94s2C2drtHpwebvRlTnjjA3/c0nHOqrvHAEl+wWtfftMTOeGiCp1SKLZPmD2Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506228; c=relaxed/simple;
	bh=HY39uDgY9hysxAuRaO156t68YA0wod3hDYYueiMBkAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/XVYn3k8ZLY69Ha++IXMrouv9HzSDXV/5pdO5RZ6x3Y3XutJQpaC6G8jCqHkAqR2la+BDLv7YIvbm01PFwKEUABCr488xIWNPEftkvqqUifGUAKRHCBu49AHOS3Ti3AV6z0WkCU5RXiltY9dpnY8xZi3UbL2WFWKB9EVd6F3Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYd2BCO6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D98C4CEF6;
	Mon, 14 Jul 2025 15:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752506227;
	bh=HY39uDgY9hysxAuRaO156t68YA0wod3hDYYueiMBkAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uYd2BCO6TgA1a3kYbVVnxR4RqOIIIhC/qdobREX41ZAg1k8lGy+xhqgoTbKLJ0hgQ
	 0WGLkJxcu8DND98PnAOLUhNCqzmMew78Vz4MJmZNdJx6JK6uEuqFg4qr8qyLjolzgX
	 3qBQGDhrjdzS6a8qWsXOgR3T4uaxGUCPGTnUJm884RrnB9hzAqfCQ9b3ouiFXSh3/d
	 dwSwfx3qM2I6wV7s5rNV0hnEqlt2DpzdeAlD7v6HcZvcrrGleiCSZQzUj7OTQMP1vM
	 +1zEqnhI3cJZaGhyMSNsEqAzIY2sJsP7KJvyy8dLvQHMr5Ig+uS1QT1HpiyzDoqCqD
	 W2Z9w12/eGIkg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: nbd@nbd.name,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com
Cc: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	krzk@kernel.org,
	lorenzo@kernel.org,
	horms@kernel.org
Subject: [RFC mt76 4/4] wifi: mt76: mt7996: Add NPU offload support to MT7996 driver
Date: Mon, 14 Jul 2025 17:16:22 +0200
Message-ID: <e06c62af1711a5ccc51e7680d1930dc7a075d6f4.1752505597.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752505597.git.lorenzo@kernel.org>
References: <cover.1752505597.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce Airoha NPU support to MT7996 driver. NPU is used to enable
traffic forward offloading between the MT76 NIC and Airoha ethernet one
available on the Airoha EN7581 SoC using Netfilter Flowtable APIs.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7996/Makefile    |   2 +-
 .../net/wireless/mediatek/mt76/mt7996/dma.c   |  17 +-
 .../net/wireless/mediatek/mt76/mt7996/init.c  |   4 +
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |   3 +
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  15 +-
 .../net/wireless/mediatek/mt76/mt7996/mmio.c  |  13 +-
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |   3 +
 .../net/wireless/mediatek/mt76/mt7996/npu.c   | 268 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/pci.c   |   6 +-
 9 files changed, 320 insertions(+), 11 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/npu.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/Makefile b/drivers/net/wireless/mediatek/mt76/mt7996/Makefile
index 07c8b555c1ac..87041a0ad84b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/Makefile
@@ -3,6 +3,6 @@
 obj-$(CONFIG_MT7996E) += mt7996e.o
 
 mt7996e-y := pci.o init.o dma.o eeprom.o main.o mcu.o mac.o \
-	     debugfs.o mmio.o
+	     debugfs.o mmio.o npu.o
 
 mt7996e-$(CONFIG_DEV_COREDUMP) += coredump.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
index c8bef0b2a144..d93b9ed50972 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
@@ -23,6 +23,9 @@ int mt7996_init_tx_queues(struct mt7996_phy *phy, int idx, int n_desc,
 			flags = MT_WED_Q_TX(idx);
 	}
 
+	if (mt76_npu_device_active(&dev->mt76))
+		flags = MT_NPU_Q_TX(phy->mt76->band_idx);
+
 	return mt76_connac_init_tx_queues(phy->mt76, idx, n_desc,
 					  ring_base, wed, flags);
 }
@@ -302,7 +305,7 @@ void mt7996_dma_start(struct mt7996_dev *dev, bool reset, bool wed_reset)
 		mtk_wed_device_start(wed, wed_irq_mask);
 	}
 
-	if (!mt7996_has_wa(dev))
+	if (!mt7996_has_wa(dev) || mt76_npu_device_active(&dev->mt76))
 		irq_mask &= ~(MT_INT_RX(MT_RXQ_MAIN_WA) |
 			      MT_INT_RX(MT_RXQ_BAND1_WA));
 	irq_mask = reset ? MT_INT_MCU_CMD : irq_mask;
@@ -705,6 +708,18 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 		}
 	}
 
+	if (mt76_npu_device_active(&dev->mt76)) {
+		ret = mt76_npu_rx_queue_init(&dev->mt76,
+					     &dev->mt76.q_rx[MT_RXQ_NPU0]);
+		if (ret)
+			return ret;
+
+		ret = mt76_npu_rx_queue_init(&dev->mt76,
+					     &dev->mt76.q_rx[MT_RXQ_NPU1]);
+		if (ret)
+			return ret;
+	}
+
 	ret = mt76_init_queues(dev, mt76_dma_rx_poll);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index a9599c286328..66db8d4aa5a0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -1511,6 +1511,10 @@ int mt7996_register_device(struct mt7996_dev *dev)
 	if (ret)
 		return ret;
 
+	ret = mt7996_npu_hw_init(dev);
+	if (ret)
+		return ret;
+
 	ret = mt76_register_device(&dev->mt76, true, mt76_rates,
 				   ARRAY_SIZE(mt76_rates));
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 226534490792..6fac336bac0c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2018,6 +2018,8 @@ void mt7996_mac_reset_work(struct work_struct *work)
 
 	mutex_lock(&dev->mt76.mutex);
 
+	mt7996_npu_hw_stop(dev);
+
 	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_DMA_STOPPED);
 
 	if (mt7996_wait_reset_state(dev, MT_MCU_CMD_RESET_DONE)) {
@@ -2092,6 +2094,7 @@ void mt7996_mac_reset_work(struct work_struct *work)
 
 	mutex_unlock(&dev->mt76.mutex);
 
+	mt7996_npu_hw_init(dev);
 	mt7996_update_beacons(dev);
 
 	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mphy.mac_work,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 92b57bcce749..af68b9f64376 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -2054,7 +2054,6 @@ mt7996_set_radar_background(struct ieee80211_hw *hw,
 	return ret;
 }
 
-#ifdef CONFIG_NET_MEDIATEK_SOC_WED
 static int
 mt7996_net_fill_forward_path(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif,
@@ -2090,12 +2089,18 @@ mt7996_net_fill_forward_path(struct ieee80211_hw *hw,
 	if (phy != &dev->phy && phy->mt76->band_idx == MT_BAND2)
 		wed = &dev->mt76.mmio.wed_hif2;
 
-	if (!mtk_wed_device_active(wed))
+	if (!mtk_wed_device_active(wed) &&
+	    !mt76_npu_device_active(&dev->mt76))
 		return -ENODEV;
 
 	path->type = DEV_PATH_MTK_WDMA;
 	path->dev = ctx->dev;
-	path->mtk_wdma.wdma_idx = wed->wdma_idx;
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+	if (mtk_wed_device_active(wed))
+		path->mtk_wdma.wdma_idx = wed->wdma_idx;
+	else
+#endif
+		path->mtk_wdma.wdma_idx = link->phy->mt76->band_idx;
 	path->mtk_wdma.bss = mlink->idx;
 	path->mtk_wdma.queue = 0;
 	path->mtk_wdma.wcid = msta_link->wcid.idx;
@@ -2106,8 +2111,6 @@ mt7996_net_fill_forward_path(struct ieee80211_hw *hw,
 	return 0;
 }
 
-#endif
-
 static int
 mt7996_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			u16 old_links, u16 new_links,
@@ -2168,8 +2171,8 @@ const struct ieee80211_ops mt7996_ops = {
 	.sta_add_debugfs = mt7996_sta_add_debugfs,
 #endif
 	.set_radar_background = mt7996_set_radar_background,
-#ifdef CONFIG_NET_MEDIATEK_SOC_WED
 	.net_fill_forward_path = mt7996_net_fill_forward_path,
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
 	.net_setup_tc = mt76_wed_net_setup_tc,
 #endif
 	.change_vif_links = mt7996_change_vif_links,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index 30b40f4a91be..a8b5e754ca26 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -671,9 +671,18 @@ void mt7996_dual_hif_set_irq_mask(struct mt7996_dev *dev, bool write_reg,
 static void mt7996_rx_poll_complete(struct mt76_dev *mdev,
 				    enum mt76_rxq_id q)
 {
-	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
+	if (q == MT_RXQ_NPU0 || q == MT_RXQ_NPU1) {
+		struct airoha_npu *npu;
+
+		npu = rcu_dereference(mdev->mmio.npu);
+		if (npu)
+			airoha_npu_wlan_enable_irq(npu, q - MT_RXQ_NPU0);
+	} else {
+		struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev,
+						      mt76);
 
-	mt7996_irq_enable(dev, MT_INT_RX(q));
+		mt7996_irq_enable(dev, MT_INT_RX(q));
+	}
 }
 
 /* TODO: support 2/4/6/8 MSI-X vectors */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 33ac16b64ef1..54d5ddbfc4dc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -782,6 +782,9 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 			 bool hif2, int *irq);
 u32 mt7996_wed_init_buf(void *ptr, dma_addr_t phys, int token_id);
 
+int mt7996_npu_hw_init(struct mt7996_dev *dev);
+int mt7996_npu_hw_stop(struct mt7996_dev *dev);
+
 #ifdef CONFIG_MTK_DEBUG
 int mt7996_mtk_init_debugfs(struct mt7996_phy *phy, struct dentry *dir);
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/npu.c b/drivers/net/wireless/mediatek/mt76/mt7996/npu.c
new file mode 100644
index 000000000000..bce448820e73
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/npu.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 AIROHA Inc
+ * Author: Lorenzo Bianconi <lorenzo@kernel.org>
+ */
+#include <linux/kernel.h>
+#include <linux/soc/airoha/airoha_offload.h>
+
+#include "mt7996.h"
+
+static int mt7996_npu_offload_init(struct mt7996_dev *dev,
+				   struct airoha_npu *npu)
+{
+	u32 hif1_ofs = 0, phy_addr;
+	int i, err;
+
+	err = airoha_npu_wlan_send_msg(npu, 0,
+				       WLAN_FUNC_SET_WAIT_PCIE_PORT_TYPE,
+				       dev->mt76.mmio.npu_type, GFP_KERNEL);
+	if (err) {
+		dev_warn(dev->mt76.dev,
+			 "failed setting npu wlan PCIe port type\n");
+		return err;
+	}
+
+	if (dev->hif2)
+		hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
+
+	for (i = MT_BAND0; i < MT_BAND2; i++) {
+		phy_addr = dev->mt76.mmio.phy_addr;
+		if (i)
+			phy_addr += MT_RXQ_RING_BASE(MT_RXQ_RRO_BAND1) + 0x90 +
+				    hif1_ofs;
+		else
+			phy_addr += MT_RXQ_RING_BASE(MT_RXQ_RRO_BAND0) + 0x80;
+
+		err = airoha_npu_wlan_send_msg(npu, i,
+					       WLAN_FUNC_SET_WAIT_PCIE_ADDR,
+					       phy_addr, GFP_KERNEL);
+		if (err) {
+			dev_warn(dev->mt76.dev,
+				 "failed setting npu wlan PCIe desc addr\n");
+			return err;
+		}
+
+		err = airoha_npu_wlan_send_msg(npu, i, WLAN_FUNC_SET_WAIT_DESC,
+					       MT7996_RX_RING_SIZE, GFP_KERNEL);
+		if (err) {
+			dev_warn(dev->mt76.dev,
+				 "failed setting npu wlan PCIe desc size\n");
+			return err;
+		}
+
+		phy_addr = dev->mt76.mmio.phy_addr;
+		if (i)
+			phy_addr += MT_TXQ_RING_BASE(0) + 0x150 + hif1_ofs;
+		else
+			phy_addr += MT_TXQ_RING_BASE(0) + 0x120;
+
+		err = airoha_npu_wlan_send_msg(npu, i,
+					       WLAN_FUNC_SET_WAIT_TX_RING_PCIE_ADDR,
+					       phy_addr, GFP_KERNEL);
+		if (err) {
+			dev_warn(dev->mt76.dev,
+				 "failed setting npu wlan tx desc addr\n");
+			return err;
+		}
+	}
+
+	err = airoha_npu_wlan_send_msg(npu, 9, WLAN_FUNC_SET_WAIT_DESC,
+				       MT7996_RX_RING_SIZE, GFP_KERNEL);
+	if (err) {
+		dev_warn(dev->mt76.dev,
+			 "failed setting npu wlan rxdmad_c desc size\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static int mt7996_npu_txd_init(struct mt7996_dev *dev, struct airoha_npu *npu)
+{
+	int i, err;
+
+	for (i = MT_BAND0; i < MT_BAND2; i++) {
+		dma_addr_t dma_addr;
+		u32 val;
+
+		err = airoha_npu_wlan_get_msg(npu, i + 5,
+					      WLAN_FUNC_GET_WAIT_RXDESC_BASE,
+					      &val, GFP_KERNEL);
+		if (err) {
+			dev_warn(dev->mt76.dev,
+				 "failed retriving npu wlan tx ring addr\n");
+			return err;
+		}
+		writel(val, &dev->mt76.phys[i]->q_tx[0]->regs->desc_base);
+
+		if (!dmam_alloc_coherent(dev->mt76.dma_dev,
+					 256 * MT7996_TX_RING_SIZE,
+					 &dma_addr, GFP_KERNEL))
+			return -ENOMEM;
+
+		err = airoha_npu_wlan_send_msg(npu, i,
+					       WLAN_FUNC_SET_WAIT_TX_BUF_SPACE_HW_BASE,
+					       dma_addr, GFP_KERNEL);
+		if (err) {
+			dev_warn(dev->mt76.dev,
+				 "failed setting npu wlan queue buf addr\n");
+			return err;
+		}
+
+		if (!dmam_alloc_coherent(dev->mt76.dma_dev,
+					 256 * MT7996_TX_RING_SIZE,
+					 &dma_addr, GFP_KERNEL))
+			return -ENOMEM;
+
+		err = airoha_npu_wlan_send_msg(npu, i + 5,
+					       WLAN_FUNC_SET_WAIT_TX_BUF_SPACE_HW_BASE,
+					       dma_addr, GFP_KERNEL);
+		if (err) {
+			dev_warn(dev->mt76.dev,
+				 "failed setting npu wlan tx buf addr\n");
+			return err;
+		}
+
+		if (!dmam_alloc_coherent(dev->mt76.dma_dev, 256 * 1024,
+					 &dma_addr, GFP_KERNEL))
+			return -ENOMEM;
+
+		err = airoha_npu_wlan_send_msg(npu, i + 10,
+					       WLAN_FUNC_SET_WAIT_TX_BUF_SPACE_HW_BASE,
+					       dma_addr, GFP_KERNEL);
+		if (err) {
+			dev_warn(dev->mt76.dev,
+				 "failed setting npu wlan tx buf base\n");
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int mt7996_npu_rx_event_init(struct mt7996_dev *dev,
+				    struct airoha_npu *npu)
+{
+	struct mt76_queue *q = &dev->mt76.q_rx[MT_RXQ_MAIN_WA];
+	phys_addr_t phy_addr = dev->mt76.mmio.phy_addr;
+	int err;
+
+	err = airoha_npu_wlan_send_msg(npu, 0,
+				       WLAN_FUNC_SET_WAIT_RX_RING_FOR_TXDONE_HW_BASE,
+				       q->desc_dma, GFP_KERNEL);
+	if (err) {
+		dev_warn(dev->mt76.dev,
+			 "failed setting npu wlan tx-done ring\n");
+		return err;
+	}
+
+	err = airoha_npu_wlan_send_msg(npu, 10, WLAN_FUNC_SET_WAIT_DESC,
+				       MT7996_RX_MCU_RING_SIZE, GFP_KERNEL);
+	if (err) {
+		dev_warn(dev->mt76.dev,
+			 "failed setting npu wlan descriptors\n");
+		return err;
+	}
+
+	phy_addr += MT_RXQ_RING_BASE(MT_RXQ_MAIN_WA) + 0x20;
+	err = airoha_npu_wlan_send_msg(npu, 10, WLAN_FUNC_SET_WAIT_PCIE_ADDR,
+				       phy_addr, GFP_KERNEL);
+	if (err)
+		dev_warn(dev->mt76.dev,
+			 "failed setting npu wlan rx pcie address\n");
+	return err;
+}
+
+static int mt7996_npu_tx_done_init(struct mt7996_dev *dev,
+				   struct airoha_npu *npu)
+{
+	int err;
+
+	err = airoha_npu_wlan_send_msg(npu, 2,
+				       WLAN_FUNC_SET_WAIT_INODE_TXRX_REG_ADDR, 0,
+				       GFP_KERNEL);
+	if (err) {
+		dev_warn(dev->mt76.dev, "failed setting npu wlan txrx addr2\n");
+		return err;
+	}
+
+	err = airoha_npu_wlan_send_msg(npu, 7,
+				       WLAN_FUNC_SET_WAIT_INODE_TXRX_REG_ADDR, 0,
+				       GFP_KERNEL);
+	if (err)
+		dev_warn(dev->mt76.dev, "failed setting npu wlan txrx addr7\n");
+
+	return err;
+}
+
+int mt7996_npu_hw_init(struct mt7996_dev *dev)
+{
+	struct airoha_npu *npu;
+	int i, err = 0;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	npu = rcu_dereference_protected(dev->mt76.mmio.npu, &dev->mt76.mutex);
+	if (!npu)
+		goto unlock;
+
+	err = mt7996_npu_offload_init(dev, npu);
+	if (err)
+		goto unlock;
+
+	err = mt7996_npu_txd_init(dev, npu);
+	if (err)
+		goto unlock;
+
+	err = mt7996_npu_rx_event_init(dev, npu);
+	if (err)
+		goto unlock;
+
+	err = mt7996_npu_tx_done_init(dev, npu);
+	if (err)
+		goto unlock;
+
+	for (i = MT_RXQ_NPU0; i <= MT_RXQ_NPU1; i++)
+		airoha_npu_wlan_enable_irq(npu, i - MT_RXQ_NPU0);
+unlock:
+	mutex_unlock(&dev->mt76.mutex);
+
+	return err;
+}
+
+int mt7996_npu_hw_stop(struct mt7996_dev *dev)
+{
+	struct airoha_npu *npu;
+	int i, err;
+	u32 info;
+
+	npu = rcu_dereference_protected(dev->mt76.mmio.npu, &dev->mt76.mutex);
+	if (!npu)
+		return 0;
+
+	err = airoha_npu_wlan_send_msg(npu, 4,
+				       WLAN_FUNC_SET_WAIT_INODE_TXRX_REG_ADDR,
+				       0, GFP_KERNEL);
+	if (err)
+		return err;
+
+	for (i = 0; i < 10; i++) {
+		err = airoha_npu_wlan_get_msg(npu, 3,
+					      WLAN_FUNC_GET_WAIT_NPU_INFO,
+					      &info, GFP_KERNEL);
+		if (err)
+			continue;
+
+		if (info) {
+			err = -ETIMEDOUT;
+			continue;
+		}
+	}
+
+	if (!err)
+		err = airoha_npu_wlan_send_msg(npu, 6,
+					       WLAN_FUNC_SET_WAIT_INODE_TXRX_REG_ADDR,
+					       0, GFP_KERNEL);
+	return err;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
index 19e99bc1c6c4..2dbb6e51e80a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
@@ -98,10 +98,10 @@ static int mt7996_pci_hif2_probe(struct pci_dev *pdev)
 static int mt7996_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
+	int irq, hif2_irq, ret, npu_type;
 	struct pci_dev *hif2_dev;
 	struct mt7996_hif *hif2;
 	struct mt7996_dev *dev;
-	int irq, hif2_irq, ret;
 	struct mt76_dev *mdev;
 
 	ret = pcim_enable_device(pdev);
@@ -138,6 +138,10 @@ static int mt7996_pci_probe(struct pci_dev *pdev,
 	mt7996_wfsys_reset(dev);
 	hif2 = mt7996_pci_init_hif2(pdev);
 
+	npu_type = pdev->bus && pci_domain_nr(pdev->bus) ? 3 : 2;
+	if (mt76_npu_init(mdev, pci_resource_start(pdev, 0), npu_type))
+		dev_warn(mdev->dev, "failed loading npu\n");
+
 	ret = mt7996_mmio_wed_init(dev, pdev, false, &irq);
 	if (ret < 0)
 		goto free_wed_or_irq_vector;
-- 
2.50.1


