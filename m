Return-Path: <linux-wireless+bounces-27221-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0B5B51A99
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 16:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBAF216C724
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 14:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E40E329F38;
	Wed, 10 Sep 2025 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoeK1Fnt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D521329F37
	for <linux-wireless@vger.kernel.org>; Wed, 10 Sep 2025 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515238; cv=none; b=j3BCXYEfekhNtrtEipWfwsVBvtanz3tcWnF93RKS0Pr6T3M0pJ7rbmfCofmVi1q8k8xgliZEbD2Jngm2640dIcqJukGDlkc2OfSBBVqNH9KswR+GUyeArP0Jf54DWITK8fBEOJrQIVI/KnEfpsT/bE+rR7/9kAGT2XKRYEh87Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515238; c=relaxed/simple;
	bh=v1IpU8fCFT8XmifrZKfvk9dGxIXK2a35JZgaqcGn52c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DpHxDyz/P1qSJpTwhCJQyfuhbQkYcyjIbYgASmNUlxXIqWn4sZp+/zW/a9ycenKjnAwPpRcNFS4OeQizY4TD5nO0SMqsZTa3DiRCJqY9nPe+JwQ/LyvYesdcyTnN0jDyFJu5anLPljjJUOAfGm6c+CUnVPh6tE8+hMe4E8SRiHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoeK1Fnt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389ADC4CEFB;
	Wed, 10 Sep 2025 14:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515237;
	bh=v1IpU8fCFT8XmifrZKfvk9dGxIXK2a35JZgaqcGn52c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FoeK1FntqOs/iTFuP3hd+gLS5rRh+kVd+MqzULKsWMzUr3PyRkrWCYvN64iUe4hjR
	 rHbYBaIpx+59jnr+MA3S7GkDQAzRvI1nAF+5DEUjFUXig+juKMvuQcib93FQsr54IV
	 raDA2zjrxTR2xrMkn1aVN3nkO9FbUKNFqes7ZJehz4E1n4b4QyCiAfBe9ciOvdZGtN
	 eZrjJ++aaj++kjKGhw2nILiBd4rhw+5zwanZygVg7dil0lXRI4XRlmkKFeLs+06gjH
	 cGbVMyA86kNT5hotclTAZ831xqjMbVjAt9Y5T+wAdY0s6+uwZXd8/ANbnt+YW5MWvn
	 5MaM8Mgj+uiOQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 10 Sep 2025 16:40:06 +0200
Subject: [PATCH mt76 5/5] wifi: mt76: mt7996: Add NPU offload support to
 MT7996 driver
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-mt76-npu-devel-v1-5-dbde4a37b9c0@kernel.org>
References: <20250910-mt76-npu-devel-v1-0-dbde4a37b9c0@kernel.org>
In-Reply-To: <20250910-mt76-npu-devel-v1-0-dbde4a37b9c0@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

Introduce Airoha NPU support to MT7996 driver. NPU is used to enable
traffic forward offloading between the MT76 NIC and the Airoha ethernet one
available on the Airoha EN7581 SoC using Netfilter Flowtable APIs.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/Kconfig  |   7 +
 drivers/net/wireless/mediatek/mt76/mt7996/Makefile |   1 +
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    |  16 +-
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |  13 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |   4 +
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |  26 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |  13 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  21 ++
 drivers/net/wireless/mediatek/mt76/mt7996/npu.c    | 352 +++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c    |   3 +
 10 files changed, 438 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7996/Kconfig
index bb44d4a5e2dc983e8532011b76966ff48a73d100..d604a3cfd8dcee6ab292e520a0af560fcb3a3def 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/Kconfig
@@ -12,3 +12,10 @@ config MT7996E
 	  and 2.4GHz IEEE 802.11be 4x4:4SS 4096-QAM, 320MHz channels.
 
 	  To compile this driver as a module, choose M here.
+
+config MT7996_NPU
+	bool "MT7996 (PCIe) NPU support"
+	depends on MT7996E
+	depends on NET_AIROHA_NPU=y || MT7996E=NET_AIROHA_NPU
+	select MT76_NPU
+	default n
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/Makefile b/drivers/net/wireless/mediatek/mt76/mt7996/Makefile
index 07c8b555c1acf090c1a394da355d37f3e3aa6f98..21a5f33b1de1c7cdf7f1be0630dadf8b7854084a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/Makefile
@@ -5,4 +5,5 @@ obj-$(CONFIG_MT7996E) += mt7996e.o
 mt7996e-y := pci.o init.o dma.o eeprom.o main.o mcu.o mac.o \
 	     debugfs.o mmio.o
 
+mt7996e-$(CONFIG_MT7996_NPU) += npu.o
 mt7996e-$(CONFIG_DEV_COREDUMP) += coredump.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
index 659015f93d3238ba3b3c3779f4baa8f4b46b22e7..1ec17e0384673efa970a73e1a9a9c6cbe00bec20 100644
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
@@ -344,7 +347,7 @@ void mt7996_dma_start(struct mt7996_dev *dev, bool reset, bool wed_reset)
 		mtk_wed_device_start(wed, wed_irq_mask);
 	}
 
-	if (!mt7996_has_wa(dev))
+	if (!mt7996_has_wa(dev) || mt76_npu_device_active(&dev->mt76))
 		irq_mask &= ~(MT_INT_RX(MT_RXQ_MAIN_WA) |
 			      MT_INT_RX(MT_RXQ_BAND1_WA));
 	irq_mask = reset ? MT_INT_MCU_CMD : irq_mask;
@@ -502,7 +505,7 @@ int mt7996_dma_rro_init(struct mt7996_dev *dev)
 		mdev->q_rx[MT_RXQ_RRO_RXDMAD_C].flags = MT_WED_RRO_Q_RXDMAD_C;
 		if (mtk_wed_device_active(&mdev->mmio.wed))
 			mdev->q_rx[MT_RXQ_RRO_RXDMAD_C].wed = &mdev->mmio.wed;
-		else
+		else if (!mt76_npu_device_active(&dev->mt76))
 			mdev->q_rx[MT_RXQ_RRO_RXDMAD_C].flags |= MT_QFLAG_EMI_EN;
 		ret = mt76_queue_alloc(dev, &mdev->q_rx[MT_RXQ_RRO_RXDMAD_C],
 				       MT_RXQ_ID(MT_RXQ_RRO_RXDMAD_C),
@@ -610,7 +613,9 @@ int mt7996_dma_rro_init(struct mt7996_dev *dev)
 			mt76_queue_rx_init(dev, MT_RXQ_MSDU_PAGE_BAND0,
 					   mt76_dma_rx_poll);
 		}
-		mt7996_irq_enable(dev, MT_INT_RRO_RX_DONE);
+
+		if (!mt76_npu_device_active(&dev->mt76))
+			mt7996_irq_enable(dev, MT_INT_RRO_RX_DONE);
 	}
 
 	return 0;
@@ -884,6 +889,10 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 	if (ret < 0)
 		return ret;
 
+	ret = mt7996_npu_rx_queues_init(dev);
+	if (ret)
+		return ret;
+
 	netif_napi_add_tx(dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
 			  mt7996_poll_tx);
 	napi_enable(&dev->mt76.tx_napi);
@@ -941,6 +950,7 @@ void mt7996_dma_reset(struct mt7996_dev *dev, bool force)
 	if (mtk_wed_device_active(&dev->mt76.mmio.wed))
 		mtk_wed_device_dma_reset(&dev->mt76.mmio.wed);
 
+	mt76_npu_disable_irqs(&dev->mt76);
 	mt7996_dma_disable(dev, force);
 	mt76_wed_dma_reset(&dev->mt76);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index d0ed43a78c85a5e63fd8ede36d9ab86af16812cc..55eff2ef5d9e502973b150da0899f910ac7d5e27 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -474,7 +474,7 @@ mt7996_init_wiphy(struct ieee80211_hw *hw, struct mtk_wed_device *wed)
 		hw->max_tx_aggregation_subframes = 512;
 
 	hw->netdev_features = NETIF_F_RXCSUM;
-	if (mtk_wed_device_active(wed))
+	if (mtk_wed_device_active(wed) || mt76_npu_device_active(mdev))
 		hw->netdev_features |= NETIF_F_HW_TC;
 
 	hw->radiotap_timestamp.units_pos =
@@ -827,7 +827,8 @@ void mt7996_rro_hw_init(struct mt7996_dev *dev)
 				   MT_RRO_3_0_EMU_CONF_EN_MASK);
 			mt76_set(dev, MT_RRO_3_1_GLOBAL_CONFIG,
 				 MT_RRO_3_1_GLOBAL_CONFIG_RXDMAD_SEL);
-			if (!mtk_wed_device_active(&dev->mt76.mmio.wed)) {
+			if (!mtk_wed_device_active(&dev->mt76.mmio.wed) &&
+			    !mt76_npu_device_active(&dev->mt76)) {
 				mt76_set(dev, MT_RRO_3_1_GLOBAL_CONFIG,
 					 MT_RRO_3_1_GLOBAL_CONFIG_RX_DIDX_WR_EN |
 					 MT_RRO_3_1_GLOBAL_CONFIG_RX_CIDX_RD_EN);
@@ -1064,6 +1065,9 @@ static void mt7996_wed_rro_work(struct work_struct *work)
 				     list);
 		list_del_init(&e->list);
 
+		if (mt76_npu_device_active(&dev->mt76))
+			goto reset_session;
+
 		for (i = 0; i < MT7996_RRO_WINDOW_MAX_LEN; i++) {
 			void *ptr = dev->wed_rro.session.ptr;
 			struct mt7996_wed_rro_addr *elem;
@@ -1084,6 +1088,7 @@ static void mt7996_wed_rro_work(struct work_struct *work)
 			elem = ptr + elem_id * sizeof(*elem);
 			elem->data |= cpu_to_le32(val);
 		}
+reset_session:
 		mt7996_mcu_wed_rro_reset_sessions(dev, e->id);
 out:
 		kfree(e);
@@ -1671,6 +1676,10 @@ int mt7996_register_device(struct mt7996_dev *dev)
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
index 77b432c4447a1bbe598525e6a1a29d8d74df825a..6790ae354c9592ac839db5dc966e374c4ce0a151 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -718,6 +718,7 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, enum mt76_rxq_id q,
 		status->flag |= RX_FLAG_8023;
 		mt7996_wed_check_ppe(dev, &dev->mt76.q_rx[q], msta, skb,
 				     *info);
+		mt76_npu_check_ppe(&dev->mt76, skb, *info);
 	}
 
 	if (rxv && !(status->flag & RX_FLAG_8023)) {
@@ -2498,6 +2499,8 @@ void mt7996_mac_reset_work(struct work_struct *work)
 
 	mutex_lock(&dev->mt76.mutex);
 
+	mt7996_npu_hw_stop(dev);
+
 	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_DMA_STOPPED);
 
 	if (mt7996_wait_reset_state(dev, MT_MCU_CMD_RESET_DONE)) {
@@ -2571,6 +2574,7 @@ void mt7996_mac_reset_work(struct work_struct *work)
 
 	mutex_unlock(&dev->mt76.mutex);
 
+	mt7996_npu_hw_init(dev);
 	mt7996_update_beacons(dev);
 
 	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mphy.mac_work,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index ceb6880afb1b6d13d1704fad1c2b3451605ab9d0..be8bf03aeb4b1cc5d8e0b06e6125b5c8f6cf2f59 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -2140,7 +2140,6 @@ mt7996_set_radar_background(struct ieee80211_hw *hw,
 	return ret;
 }
 
-#ifdef CONFIG_NET_MEDIATEK_SOC_WED
 static int
 mt7996_net_fill_forward_path(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif,
@@ -2148,15 +2147,14 @@ mt7996_net_fill_forward_path(struct ieee80211_hw *hw,
 			     struct net_device_path_ctx *ctx,
 			     struct net_device_path *path)
 {
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
 	struct mt7996_sta_link *msta_link;
-	struct mt76_vif_link *mlink;
+	struct mt7996_vif_link *link;
 
-	mlink = rcu_dereference(mvif->mt76.link[msta->deflink_id]);
-	if (!mlink)
+	link = mt7996_vif_link(dev, vif, msta->deflink_id);
+	if (!link)
 		return -EIO;
 
 	msta_link = rcu_dereference(msta->link[msta->deflink_id]);
@@ -2171,13 +2169,19 @@ mt7996_net_fill_forward_path(struct ieee80211_hw *hw,
 	     (is_mt7992(&dev->mt76) && msta_link->wcid.phy_idx == MT_BAND1)))
 		wed = &dev->mt76.mmio.wed_hif2;
 
-	if (!mtk_wed_device_active(wed))
+	if (!mtk_wed_device_active(wed) &&
+	    !mt76_npu_device_active(&dev->mt76))
 		return -ENODEV;
 
 	path->type = DEV_PATH_MTK_WDMA;
 	path->dev = ctx->dev;
-	path->mtk_wdma.wdma_idx = wed->wdma_idx;
-	path->mtk_wdma.bss = mlink->idx;
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+	if (mtk_wed_device_active(wed))
+		path->mtk_wdma.wdma_idx = wed->wdma_idx;
+	else
+#endif
+		path->mtk_wdma.wdma_idx = link->mt76.band_idx;
+	path->mtk_wdma.bss = link->mt76.idx;
 	path->mtk_wdma.queue = 0;
 	path->mtk_wdma.wcid = msta_link->wcid.idx;
 
@@ -2191,8 +2195,6 @@ mt7996_net_fill_forward_path(struct ieee80211_hw *hw,
 	return 0;
 }
 
-#endif
-
 static int
 mt7996_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			u16 old_links, u16 new_links,
@@ -2253,9 +2255,11 @@ const struct ieee80211_ops mt7996_ops = {
 	.sta_add_debugfs = mt7996_sta_add_debugfs,
 #endif
 	.set_radar_background = mt7996_set_radar_background,
-#ifdef CONFIG_NET_MEDIATEK_SOC_WED
 	.net_fill_forward_path = mt7996_net_fill_forward_path,
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
 	.net_setup_tc = mt76_wed_net_setup_tc,
+#elifdef CONFIG_MT7996_NPU
+	.net_setup_tc = mt76_npu_net_setup_tc,
 #endif
 	.change_vif_links = mt7996_change_vif_links,
 	.change_sta_links = mt7996_mac_sta_change_links,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index d14b626ee511566e465588d2b2f7b77bd859a6ec..bd837f9107abc4660fc6af36a61ec87c8153c469 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -706,9 +706,18 @@ void mt7996_dual_hif_set_irq_mask(struct mt7996_dev *dev, bool write_reg,
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
index 4da10640916f50e1a3e3f0e1b25bd2977ded68be..016949a5cf596fecb26ef42507139e79ffce7523 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -866,4 +866,25 @@ int mt7996_mtk_init_debugfs(struct mt7996_phy *phy, struct dentry *dir);
 
 int mt7996_dma_rro_init(struct mt7996_dev *dev);
 
+#ifdef CONFIG_MT7996_NPU
+int mt7996_npu_hw_init(struct mt7996_dev *dev);
+int mt7996_npu_hw_stop(struct mt7996_dev *dev);
+int mt7996_npu_rx_queues_init(struct mt7996_dev *dev);
+#else
+static inline int mt7996_npu_hw_init(struct mt7996_dev *dev)
+{
+	return 0;
+}
+
+static inline int mt7996_npu_hw_stop(struct mt7996_dev *dev)
+{
+	return 0;
+}
+
+static inline int mt7996_npu_rx_queues_init(struct mt7996_dev *dev)
+{
+	return 0;
+}
+#endif /* CONFIG_MT7996_NPU */
+
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/npu.c b/drivers/net/wireless/mediatek/mt76/mt7996/npu.c
new file mode 100644
index 0000000000000000000000000000000000000000..29bb735da4cb8f5998c9483567c65f3e3530c771
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/npu.c
@@ -0,0 +1,352 @@
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
+	phys_addr_t phy_addr = dev->mt76.mmio.phy_addr;
+	u32 val, hif1_ofs = 0, dma_addr;
+	int i, err;
+
+	err = mt76_npu_get_msg(npu, 0, WLAN_FUNC_GET_WAIT_NPU_VERSION,
+			       &val, GFP_KERNEL);
+	if (err) {
+		dev_warn(dev->mt76.dev, "failed getting NPU fw version\n");
+		return err;
+	}
+
+	dev_info(dev->mt76.dev, "NPU version: %0d.%d\n",
+		 (val >> 16) & 0xffff, val & 0xffff);
+
+	err = mt76_npu_send_msg(npu, 0, WLAN_FUNC_SET_WAIT_PCIE_PORT_TYPE,
+				dev->mt76.mmio.npu_type, GFP_KERNEL);
+	if (err) {
+		dev_warn(dev->mt76.dev,
+			 "failed setting NPU wlan PCIe port type\n");
+		return err;
+	}
+
+	if (dev->hif2)
+		hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
+
+	for (i = MT_BAND0; i < MT_BAND2; i++) {
+		dma_addr = phy_addr;
+		if (i)
+			dma_addr += MT_RXQ_RING_BASE(MT_RXQ_RRO_BAND1) + 0x90 +
+				    hif1_ofs;
+		else
+			dma_addr += MT_RXQ_RING_BASE(MT_RXQ_RRO_BAND0) + 0x80;
+
+		err = mt76_npu_send_msg(npu, i, WLAN_FUNC_SET_WAIT_PCIE_ADDR,
+					dma_addr, GFP_KERNEL);
+		if (err) {
+			dev_warn(dev->mt76.dev,
+				 "failed setting NPU wlan PCIe desc addr\n");
+			return err;
+		}
+
+		err = mt76_npu_send_msg(npu, i, WLAN_FUNC_SET_WAIT_DESC,
+					MT7996_RX_RING_SIZE, GFP_KERNEL);
+		if (err) {
+			dev_warn(dev->mt76.dev,
+				 "failed setting NPU wlan PCIe desc size\n");
+			return err;
+		}
+
+		dma_addr = phy_addr;
+		if (i)
+			dma_addr += MT_TXQ_RING_BASE(0) + 0x150 + hif1_ofs;
+		else
+			dma_addr += MT_TXQ_RING_BASE(0) + 0x120;
+
+		err = mt76_npu_send_msg(npu, i,
+					WLAN_FUNC_SET_WAIT_TX_RING_PCIE_ADDR,
+					dma_addr, GFP_KERNEL);
+		if (err) {
+			dev_warn(dev->mt76.dev,
+				 "failed setting NPU wlan tx desc addr\n");
+			return err;
+		}
+	}
+
+	err = mt76_npu_send_msg(npu, 9, WLAN_FUNC_SET_WAIT_PCIE_ADDR,
+				phy_addr + MT_RXQ_RRO_AP_RING_BASE,
+				GFP_KERNEL);
+	if (err) {
+		dev_warn(dev->mt76.dev,
+			 "failed setting NPU wlan rxdmad_c addr\n");
+		return err;
+	}
+
+	err = mt76_npu_send_msg(npu, 9, WLAN_FUNC_SET_WAIT_DESC,
+				MT7996_RX_RING_SIZE, GFP_KERNEL);
+	if (err) {
+		dev_warn(dev->mt76.dev,
+			 "failed setting NPU wlan rxdmad_c desc size\n");
+		return err;
+	}
+
+	err = mt76_npu_send_msg(npu, 2, WLAN_FUNC_SET_WAIT_TX_RING_PCIE_ADDR,
+				phy_addr + MT_RRO_ACK_SN_CTRL, GFP_KERNEL);
+	if (err) {
+		dev_warn(dev->mt76.dev,
+			 "failed setting NPU wlan rro_ack_sn desc addr\n");
+		return err;
+	}
+
+	err = mt76_npu_send_msg(npu, 0, WLAN_FUNC_SET_WAIT_TOKEN_ID_SIZE,
+				MT7996_HW_TOKEN_SIZE, GFP_KERNEL);
+	if (err)
+		return err;
+
+	dev->mt76.token_start = MT7996_HW_TOKEN_SIZE;
+
+	return 0;
+}
+
+static int mt7996_npu_rxd_init(struct mt7996_dev *dev, struct airoha_npu *npu)
+{
+	u32 val;
+	int err;
+
+	err = mt76_npu_get_msg(npu, 0, WLAN_FUNC_GET_WAIT_RXDESC_BASE,
+			       &val, GFP_KERNEL);
+	if (err) {
+		dev_warn(dev->mt76.dev,
+			 "failed retriving NPU wlan rx ring0 addr\n");
+		return err;
+	}
+	writel(val, &dev->mt76.q_rx[MT_RXQ_RRO_BAND0].regs->desc_base);
+
+	err = mt76_npu_get_msg(npu, 1, WLAN_FUNC_GET_WAIT_RXDESC_BASE,
+			       &val, GFP_KERNEL);
+	if (err) {
+		dev_warn(dev->mt76.dev,
+			 "failed retriving NPU wlan rx ring1 addr\n");
+		return err;
+	}
+	writel(val, &dev->mt76.q_rx[MT_RXQ_RRO_BAND1].regs->desc_base);
+
+	err = mt76_npu_get_msg(npu, 9, WLAN_FUNC_GET_WAIT_RXDESC_BASE,
+			       &val, GFP_KERNEL);
+	if (err) {
+		dev_warn(dev->mt76.dev,
+			 "failed retriving NPU wlan rxdmad_c ring addr\n");
+		return err;
+	}
+	writel(val, &dev->mt76.q_rx[MT_RXQ_RRO_RXDMAD_C].regs->desc_base);
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
+		err = mt76_npu_get_msg(npu, i + 5,
+				       WLAN_FUNC_GET_WAIT_RXDESC_BASE,
+				       &val, GFP_KERNEL);
+		if (err) {
+			dev_warn(dev->mt76.dev,
+				 "failed retriving NPU wlan tx ring addr\n");
+			return err;
+		}
+		writel(val, &dev->mt76.phys[i]->q_tx[0]->regs->desc_base);
+
+		if (!dmam_alloc_coherent(dev->mt76.dma_dev,
+					 256 * MT7996_TX_RING_SIZE,
+					 &dma_addr, GFP_KERNEL))
+			return -ENOMEM;
+
+		err = mt76_npu_send_msg(npu, i,
+					WLAN_FUNC_SET_WAIT_TX_BUF_SPACE_HW_BASE,
+					dma_addr, GFP_KERNEL);
+		if (err) {
+			dev_warn(dev->mt76.dev,
+				 "failed setting NPU wlan queue buf addr\n");
+			return err;
+		}
+
+		if (!dmam_alloc_coherent(dev->mt76.dma_dev,
+					 256 * MT7996_TX_RING_SIZE,
+					 &dma_addr, GFP_KERNEL))
+			return -ENOMEM;
+
+		err = mt76_npu_send_msg(npu, i + 5,
+					WLAN_FUNC_SET_WAIT_TX_BUF_SPACE_HW_BASE,
+					dma_addr, GFP_KERNEL);
+		if (err) {
+			dev_warn(dev->mt76.dev,
+				 "failed setting NPU wlan tx buf addr\n");
+			return err;
+		}
+
+		if (!dmam_alloc_coherent(dev->mt76.dma_dev, 256 * 1024,
+					 &dma_addr, GFP_KERNEL))
+			return -ENOMEM;
+
+		err = mt76_npu_send_msg(npu, i + 10,
+					WLAN_FUNC_SET_WAIT_TX_BUF_SPACE_HW_BASE,
+					dma_addr, GFP_KERNEL);
+		if (err) {
+			dev_warn(dev->mt76.dev,
+				 "failed setting NPU wlan tx buf base\n");
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
+	err = mt76_npu_send_msg(npu, 0,
+				WLAN_FUNC_SET_WAIT_RX_RING_FOR_TXDONE_HW_BASE,
+				q->desc_dma, GFP_KERNEL);
+	if (err) {
+		dev_warn(dev->mt76.dev,
+			 "failed setting NPU wlan tx-done ring\n");
+		return err;
+	}
+
+	err = mt76_npu_send_msg(npu, 10, WLAN_FUNC_SET_WAIT_DESC,
+				MT7996_RX_MCU_RING_SIZE, GFP_KERNEL);
+	if (err) {
+		dev_warn(dev->mt76.dev,
+			 "failed setting NPU wlan descriptors\n");
+		return err;
+	}
+
+	phy_addr += MT_RXQ_RING_BASE(MT_RXQ_MAIN_WA) + 0x20;
+	err = mt76_npu_send_msg(npu, 10, WLAN_FUNC_SET_WAIT_PCIE_ADDR,
+				phy_addr, GFP_KERNEL);
+	if (err)
+		dev_warn(dev->mt76.dev,
+			 "failed setting NPU wlan rx pcie address\n");
+	return err;
+}
+
+static int mt7996_npu_tx_done_init(struct mt7996_dev *dev,
+				   struct airoha_npu *npu)
+{
+	int err;
+
+	err = mt76_npu_send_msg(npu, 2, WLAN_FUNC_SET_WAIT_INODE_TXRX_REG_ADDR,
+				0, GFP_KERNEL);
+	if (err) {
+		dev_warn(dev->mt76.dev, "failed setting NPU wlan txrx addr2\n");
+		return err;
+	}
+
+	err = mt76_npu_send_msg(npu, 7, WLAN_FUNC_SET_WAIT_INODE_TXRX_REG_ADDR,
+				0, GFP_KERNEL);
+	if (err)
+		dev_warn(dev->mt76.dev, "failed setting NPU wlan txrx addr7\n");
+
+	return err;
+}
+
+int mt7996_npu_rx_queues_init(struct mt7996_dev *dev)
+{
+	int err;
+
+	if (!mt76_npu_device_active(&dev->mt76))
+		return 0;
+
+	err = mt76_npu_rx_queue_init(&dev->mt76,
+				     &dev->mt76.q_rx[MT_RXQ_NPU0]);
+	if (err)
+		return err;
+
+	return mt76_npu_rx_queue_init(&dev->mt76,
+				      &dev->mt76.q_rx[MT_RXQ_NPU1]);
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
+	err = mt7996_npu_rxd_init(dev, npu);
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
+	err = mt76_npu_send_msg(npu, 4, WLAN_FUNC_SET_WAIT_INODE_TXRX_REG_ADDR,
+				0, GFP_KERNEL);
+	if (err)
+		return err;
+
+	for (i = 0; i < 10; i++) {
+		err = mt76_npu_get_msg(npu, 3, WLAN_FUNC_GET_WAIT_NPU_INFO,
+				       &info, GFP_KERNEL);
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
+		err = mt76_npu_send_msg(npu, 6,
+					WLAN_FUNC_SET_WAIT_INODE_TXRX_REG_ADDR,
+					0, GFP_KERNEL);
+	return err;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
index 3f49bbbba3b9ccd100267f54775838ddef634766..c364fdc560fd512b1a548e07455fe859db1d708e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
@@ -140,6 +140,9 @@ static int mt7996_pci_probe(struct pci_dev *pdev,
 	hif2 = mt7996_pci_init_hif2(pdev);
 	dev->hif2 = hif2;
 
+	mt76_npu_init(mdev, pci_resource_start(pdev, 0),
+		      pdev->bus && pci_domain_nr(pdev->bus) ? 3 : 2);
+
 	ret = mt7996_mmio_wed_init(dev, pdev, false, &irq);
 	if (ret < 0)
 		goto free_wed_or_irq_vector;

-- 
2.51.0


