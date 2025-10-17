Return-Path: <linux-wireless+bounces-28020-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0645BE74BD
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 10:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26F1956341F
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 08:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73742D0627;
	Fri, 17 Oct 2025 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLHGxpFz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822362C21E1
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691062; cv=none; b=bRai9wKUbIDalYdL0/7zTZHIKnL6dIX4w0tenHtxxXiJXXcfQsco+fuUEFuMufV1DZ7HDhxTrsQRumrVJMXv7i1FO8f7o2Qdz2n5YsQM3Cn45roZal7w2ZdMFJSjNSoPpB580n39tZu94QBAUgCJU6ZYtrag/hNM6QF5pUQwQtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691062; c=relaxed/simple;
	bh=lzdG8ucE8RjuLJ2GRvAFH9cbRRBeYJjFF6aY/su+dUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hu0T8DC52PkitA9d14EVuhgPoeINfz4SvTBNcwzFhLSH08DC1t45THr6Jmntf1yaSjBhJWA1lSkDqB5gjPm2xsOGu9cZRfGGYFKldSyuLhs/J75JJnoZfn44zGrJ6u9BVL72LEM+EqUuQq+GfhpeiNAitMu5xUEp9AR1M1M1xpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLHGxpFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98899C4CEF9;
	Fri, 17 Oct 2025 08:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760691062;
	bh=lzdG8ucE8RjuLJ2GRvAFH9cbRRBeYJjFF6aY/su+dUk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FLHGxpFzJ5PR9HBnv+sqOc4QsWnIHJAnNQoW6ihVAkwkQ0rOCs53gyMifXhMea9Rn
	 jr6lzLOO5XmIZzywPmNBY1ByV7RVwfCnkXdodyZ+FVXGEBCqBc41+6Cx6g9M61n8LP
	 I1VVhJnRXzFlnguB7GsRLbWoWAsom+aLcpxZXra5Uc9ezrOYfXqnCPg4HUWtQloOwD
	 t0Tw4wmAbw6kD8OUYCTqaf4h3yNwzxThGmdguUSZNUm4U6xnn/EHU0f31M4DBu/+hJ
	 o4hlK1uHCpoLeoJrcgAXK5OjpVL87cNdwIjWobDxV94c/Qb1aCh+jmi4ak7IUtecBC
	 pay8ZwMu5AFgQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 17 Oct 2025 10:50:32 +0200
Subject: [PATCH mt76 v2 4/5] wifi: mt76: Introduce the NPU generic layer
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-mt76-npu-devel-v2-4-ddaa90901723@kernel.org>
References: <20251017-mt76-npu-devel-v2-0-ddaa90901723@kernel.org>
In-Reply-To: <20251017-mt76-npu-devel-v2-0-ddaa90901723@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

Add the NPU generic layer in mt76 module. NPU will be used to enable
traffic forward offloading between the MT76 NIC and the Airoha ethernet one
available on the Airoha EN7581 SoC using Netfilter Flowtable APIs.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/Kconfig    |   4 +
 drivers/net/wireless/mediatek/mt76/Makefile   |   1 +
 drivers/net/wireless/mediatek/mt76/dma.c      |  41 ++-
 drivers/net/wireless/mediatek/mt76/dma.h      |  36 ++
 drivers/net/wireless/mediatek/mt76/mac80211.c |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     | 135 +++++++
 drivers/net/wireless/mediatek/mt76/npu.c      | 494 ++++++++++++++++++++++++++
 include/linux/soc/airoha/airoha_offload.h     |   1 +
 8 files changed, 711 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/Kconfig b/drivers/net/wireless/mediatek/mt76/Kconfig
index d0aff94075d60a6d76fe29b2f8f8c94db1a157d6..502303622a5382aa58a85d2049f32132f04a568d 100644
--- a/drivers/net/wireless/mediatek/mt76/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/Kconfig
@@ -37,6 +37,10 @@ config MT792x_USB
 	tristate
 	select MT76_USB
 
+config MT76_NPU
+	bool
+	depends on MT76_CORE
+
 source "drivers/net/wireless/mediatek/mt76/mt76x0/Kconfig"
 source "drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig"
 source "drivers/net/wireless/mediatek/mt76/mt7603/Kconfig"
diff --git a/drivers/net/wireless/mediatek/mt76/Makefile b/drivers/net/wireless/mediatek/mt76/Makefile
index 53e7bcefe770e0d36eb5f09f97044a7522308ed3..1d42adfe8030447d551614abef35dde947b5f292 100644
--- a/drivers/net/wireless/mediatek/mt76/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/Makefile
@@ -12,6 +12,7 @@ mt76-y := \
 	mmio.o util.o trace.o dma.o mac80211.o debugfs.o eeprom.o \
 	tx.o agg-rx.o mcu.o wed.o scan.o channel.o
 
+mt76-$(CONFIG_MT76_NPU) += npu.o
 mt76-$(CONFIG_PCI) += pci.o
 mt76-$(CONFIG_NL80211_TESTMODE) += testmode.o
 
diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index a4c1b6c66488386805c4bb21fbd11d7857f69e4d..f240016ed9f0ead27e98e350f4fdb818e1686781 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -189,10 +189,15 @@ static void
 mt76_dma_sync_idx(struct mt76_dev *dev, struct mt76_queue *q)
 {
 	Q_WRITE(q, desc_base, q->desc_dma);
-	if (q->flags & MT_QFLAG_WED_RRO_EN)
+	if ((q->flags & MT_QFLAG_WED_RRO_EN) && !mt76_npu_device_active(dev))
 		Q_WRITE(q, ring_size, MT_DMA_RRO_EN | q->ndesc);
 	else
 		Q_WRITE(q, ring_size, q->ndesc);
+
+	if (mt76_queue_is_npu_tx(q)) {
+		writel(q->desc_dma, &q->regs->desc_base);
+		writel(q->ndesc, &q->regs->ring_size);
+	}
 	q->head = Q_READ(q, dma_idx);
 	q->tail = q->head;
 }
@@ -204,7 +209,7 @@ void mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q,
 		return;
 
 	if (!mt76_queue_is_wed_rro_ind(q) &&
-	    !mt76_queue_is_wed_rro_rxdmad_c(q)) {
+	    !mt76_queue_is_wed_rro_rxdmad_c(q) && !mt76_queue_is_npu(q)) {
 		int i;
 
 		/* clear descriptors */
@@ -415,6 +420,7 @@ mt76_dma_tx_cleanup(struct mt76_dev *dev, struct mt76_queue *q, bool flush)
 
 	while (q->queued > 0 && q->tail != last) {
 		mt76_dma_tx_cleanup_idx(dev, q, q->tail, &entry);
+		mt76_npu_txdesc_cleanup(q, q->tail);
 		mt76_queue_tx_complete(dev, q, &entry);
 
 		if (entry.txwi) {
@@ -649,6 +655,10 @@ mt76_dma_tx_queue_skb(struct mt76_phy *phy, struct mt76_queue *q,
 	if (test_bit(MT76_RESET, &phy->state))
 		goto free_skb;
 
+	/* TODO: Take into account unlinear skbs */
+	if (mt76_npu_device_active(dev) && skb_linearize(skb))
+		goto free_skb;
+
 	t = mt76_get_txwi(dev);
 	if (!t)
 		goto free_skb;
@@ -696,6 +706,9 @@ mt76_dma_tx_queue_skb(struct mt76_phy *phy, struct mt76_queue *q,
 	if (ret < 0)
 		goto unmap;
 
+	if (mt76_npu_device_active(dev))
+		return mt76_npu_dma_add_buf(phy, q, skb, &tx_info.buf[1], txwi);
+
 	return mt76_dma_add_buf(dev, q, tx_info.buf, tx_info.nbuf,
 				tx_info.info, tx_info.skb, t);
 
@@ -796,8 +809,15 @@ mt76_dma_alloc_queue(struct mt76_dev *dev, struct mt76_queue *q,
 	q->hw_idx = idx;
 	q->dev = dev;
 
-	size = mt76_queue_is_wed_rro_ind(q) ? sizeof(struct mt76_wed_rro_desc)
-					    : sizeof(struct mt76_desc);
+	if (mt76_queue_is_wed_rro_ind(q))
+		size = sizeof(struct mt76_wed_rro_desc);
+	else if (mt76_queue_is_npu_tx(q))
+		size = sizeof(struct airoha_npu_tx_dma_desc);
+	else if (mt76_queue_is_npu_rx(q))
+		size = sizeof(struct airoha_npu_rx_dma_desc);
+	else
+		size = sizeof(struct mt76_desc);
+
 	q->desc = dmam_alloc_coherent(dev->dma_dev, q->ndesc * size,
 				      &q->desc_dma, GFP_KERNEL);
 	if (!q->desc)
@@ -813,6 +833,7 @@ mt76_dma_alloc_queue(struct mt76_dev *dev, struct mt76_queue *q,
 	if (ret)
 		return ret;
 
+	mt76_npu_queue_setup(dev, q);
 	ret = mt76_wed_dma_setup(dev, q, false);
 	if (ret)
 		return ret;
@@ -840,6 +861,11 @@ mt76_dma_rx_cleanup(struct mt76_dev *dev, struct mt76_queue *q)
 	if (!q->ndesc)
 		return;
 
+	if (mt76_queue_is_npu(q)) {
+		mt76_npu_queue_cleanup(dev, q);
+		return;
+	}
+
 	do {
 		spin_lock_bh(&q->lock);
 		buf = mt76_dma_dequeue(dev, q, true, NULL, NULL, &more, NULL);
@@ -870,7 +896,7 @@ mt76_dma_rx_reset(struct mt76_dev *dev, enum mt76_rxq_id qid)
 		return;
 
 	if (!mt76_queue_is_wed_rro_ind(q) &&
-	    !mt76_queue_is_wed_rro_rxdmad_c(q)) {
+	    !mt76_queue_is_wed_rro_rxdmad_c(q) && !mt76_queue_is_npu(q)) {
 		int i;
 
 		for (i = 0; i < q->ndesc; i++)
@@ -890,7 +916,10 @@ mt76_dma_rx_reset(struct mt76_dev *dev, enum mt76_rxq_id qid)
 		return;
 
 	mt76_dma_sync_idx(dev, q);
-	mt76_dma_rx_fill_buf(dev, q, false);
+	if (mt76_queue_is_npu(q))
+		mt76_npu_fill_rx_queue(dev, q);
+	else
+		mt76_dma_rx_fill(dev, q, false);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/dma.h b/drivers/net/wireless/mediatek/mt76/dma.h
index 19bc768913fff30b221b2da4827dbc6aff5c9f3a..4fd779e1aa0f8f9c7a465b948e8bcce5f52711cf 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.h
+++ b/drivers/net/wireless/mediatek/mt76/dma.h
@@ -70,6 +70,42 @@
 		writel(_val, &(_q)->regs->_field);			\
 } while (0)
 
+#elif IS_ENABLED(CONFIG_MT76_NPU)
+
+#define Q_READ(_q, _field) ({						\
+	u32 _offset = offsetof(struct mt76_queue_regs, _field);		\
+	u32 _val;							\
+	if ((_q)->flags & MT_QFLAG_NPU) {				\
+		struct airoha_npu *npu;					\
+									\
+		rcu_read_lock();					\
+		npu = rcu_dereference(q->dev->mmio.npu);		\
+		if (npu)						\
+			regmap_read(npu->regmap,			\
+				    ((_q)->wed_regs + _offset), &_val);	\
+		rcu_read_unlock();					\
+	} else {							\
+		_val = readl(&(_q)->regs->_field);			\
+	}								\
+	_val;								\
+})
+
+#define Q_WRITE(_q, _field, _val)	do {				\
+	u32 _offset = offsetof(struct mt76_queue_regs, _field);		\
+	if ((_q)->flags & MT_QFLAG_NPU) {				\
+		struct airoha_npu *npu;					\
+									\
+		rcu_read_lock();					\
+		npu = rcu_dereference(q->dev->mmio.npu);		\
+		if (npu)						\
+			regmap_write(npu->regmap,			\
+				     ((_q)->wed_regs + _offset), _val);	\
+		rcu_read_unlock();					\
+	} else {							\
+		writel(_val, &(_q)->regs->_field);			\
+	}								\
+} while (0)
+
 #else
 
 #define Q_READ(_q, _field)		readl(&(_q)->regs->_field)
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 4be47aea2253ce7970080d3395690b3aec0aa29c..72ed3c825fa643328a2f7db346bcf2d6972882c2 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -630,6 +630,8 @@ int mt76_create_page_pool(struct mt76_dev *dev, struct mt76_queue *q)
 	case MT_RXQ_MAIN:
 	case MT_RXQ_BAND1:
 	case MT_RXQ_BAND2:
+	case MT_RXQ_NPU0:
+	case MT_RXQ_NPU1:
 		pp_params.pool_size = 256;
 		break;
 	default:
@@ -814,6 +816,7 @@ void mt76_free_device(struct mt76_dev *dev)
 		destroy_workqueue(dev->wq);
 		dev->wq = NULL;
 	}
+	mt76_npu_deinit(dev);
 	ieee80211_free_hw(dev->hw);
 }
 EXPORT_SYMBOL_GPL(mt76_free_device);
@@ -1553,7 +1556,8 @@ void mt76_rx_poll_complete(struct mt76_dev *dev, enum mt76_rxq_id q,
 
 	while ((skb = __skb_dequeue(&dev->rx_skb[q])) != NULL) {
 		mt76_check_sta(dev, skb);
-		if (mtk_wed_device_active(&dev->mmio.wed))
+		if (mtk_wed_device_active(&dev->mmio.wed) ||
+		    mt76_npu_device_active(dev))
 			__skb_queue_tail(&frames, skb);
 		else
 			mt76_rx_aggr_reorder(skb, &frames);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index a66b89bc4b4a5b9a4a8a21a0fea6c465d34ce552..d05e83ea1cacc43512f37743e1708390c3cb2f35 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -13,6 +13,7 @@
 #include <linux/leds.h>
 #include <linux/usb.h>
 #include <linux/average.h>
+#include <linux/soc/airoha/airoha_offload.h>
 #include <linux/soc/mediatek/mtk_wed.h>
 #include <net/mac80211.h>
 #include <net/page_pool/helpers.h>
@@ -34,6 +35,7 @@
 #define MT_QFLAG_WED_RRO	BIT(6)
 #define MT_QFLAG_WED_RRO_EN	BIT(7)
 #define MT_QFLAG_EMI_EN		BIT(8)
+#define MT_QFLAG_NPU		BIT(9)
 
 #define __MT_WED_Q(_type, _n)	(MT_QFLAG_WED | \
 				 FIELD_PREP(MT_QFLAG_WED_TYPE, _type) | \
@@ -48,6 +50,12 @@
 #define MT_WED_RRO_Q_IND	__MT_WED_RRO_Q(MT76_WED_RRO_Q_IND, 0)
 #define MT_WED_RRO_Q_RXDMAD_C	__MT_WED_RRO_Q(MT76_WED_RRO_Q_RXDMAD_C, 0)
 
+#define __MT_NPU_Q(_type, _n)	(MT_QFLAG_NPU | \
+				 FIELD_PREP(MT_QFLAG_WED_TYPE, _type) | \
+				 FIELD_PREP(MT_QFLAG_WED_RING, _n))
+#define MT_NPU_Q_TX(_n)		__MT_NPU_Q(MT76_WED_Q_TX, _n)
+#define MT_NPU_Q_RX(_n)		__MT_NPU_Q(MT76_WED_Q_RX, _n)
+
 struct mt76_dev;
 struct mt76_phy;
 struct mt76_wcid;
@@ -139,6 +147,8 @@ enum mt76_rxq_id {
 	MT_RXQ_TXFREE_BAND2,
 	MT_RXQ_RRO_IND,
 	MT_RXQ_RRO_RXDMAD_C,
+	MT_RXQ_NPU0,
+	MT_RXQ_NPU1,
 	__MT_RXQ_MAX
 };
 
@@ -707,6 +717,11 @@ struct mt76_mmio {
 	struct mtk_wed_device wed_hif2;
 	struct completion wed_reset;
 	struct completion wed_reset_complete;
+
+	struct airoha_ppe_dev __rcu *ppe_dev;
+	struct airoha_npu __rcu *npu;
+	phys_addr_t phy_addr;
+	int npu_type;
 };
 
 struct mt76_rx_status {
@@ -1617,6 +1632,109 @@ int mt76_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *skb,
 int mt76_testmode_set_state(struct mt76_phy *phy, enum mt76_testmode_state state);
 int mt76_testmode_alloc_skb(struct mt76_phy *phy, u32 len);
 
+#ifdef CONFIG_MT76_NPU
+void mt76_npu_check_ppe(struct mt76_dev *dev, struct sk_buff *skb,
+			u32 info);
+int mt76_npu_dma_add_buf(struct mt76_phy *phy, struct mt76_queue *q,
+			 struct sk_buff *skb, struct mt76_queue_buf *buf,
+			 void *txwi_ptr);
+int mt76_npu_rx_queue_init(struct mt76_dev *dev, struct mt76_queue *q);
+int mt76_npu_fill_rx_queue(struct mt76_dev *dev, struct mt76_queue *q);
+void mt76_npu_queue_cleanup(struct mt76_dev *dev, struct mt76_queue *q);
+void mt76_npu_disable_irqs(struct mt76_dev *dev);
+int mt76_npu_init(struct mt76_dev *dev, phys_addr_t phy_addr, int type);
+void mt76_npu_deinit(struct mt76_dev *dev);
+void mt76_npu_queue_setup(struct mt76_dev *dev, struct mt76_queue *q);
+void mt76_npu_txdesc_cleanup(struct mt76_queue *q, int index);
+int mt76_npu_net_setup_tc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			  struct net_device *dev, enum tc_setup_type type,
+			  void *type_data);
+#else
+static inline void mt76_npu_check_ppe(struct mt76_dev *dev,
+				      struct sk_buff *skb, u32 info)
+{
+}
+
+static inline int mt76_npu_dma_add_buf(struct mt76_phy *phy,
+				       struct mt76_queue *q,
+				       struct sk_buff *skb,
+				       struct mt76_queue_buf *buf,
+				       void *txwi_ptr)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int mt76_npu_fill_rx_queue(struct mt76_dev *dev,
+					 struct mt76_queue *q)
+{
+	return 0;
+}
+
+static inline void mt76_npu_queue_cleanup(struct mt76_dev *dev,
+					  struct mt76_queue *q)
+{
+}
+
+static inline void mt76_npu_disable_irqs(struct mt76_dev *dev)
+{
+}
+
+static inline int mt76_npu_init(struct mt76_dev *dev, phys_addr_t phy_addr,
+				int type)
+{
+	return 0;
+}
+
+static inline void mt76_npu_deinit(struct mt76_dev *dev)
+{
+}
+
+static inline void mt76_npu_queue_setup(struct mt76_dev *dev,
+					struct mt76_queue *q)
+{
+}
+
+static inline void mt76_npu_txdesc_cleanup(struct mt76_queue *q,
+					   int index)
+{
+}
+
+static inline int mt76_npu_net_setup_tc(struct ieee80211_hw *hw,
+					struct ieee80211_vif *vif,
+					struct net_device *dev,
+					enum tc_setup_type type,
+					void *type_data)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_MT76_NPU */
+
+static inline bool mt76_npu_device_active(struct mt76_dev *dev)
+{
+	return !!rcu_access_pointer(dev->mmio.npu);
+}
+
+static inline bool mt76_ppe_device_active(struct mt76_dev *dev)
+{
+	return !!rcu_access_pointer(dev->mmio.ppe_dev);
+}
+
+static inline int mt76_npu_send_msg(struct airoha_npu *npu, int ifindex,
+				    enum airoha_npu_wlan_set_cmd cmd,
+				    u32 val, gfp_t gfp)
+{
+	return airoha_npu_wlan_send_msg(npu, ifindex, cmd, &val, sizeof(val),
+					gfp);
+}
+
+static inline int mt76_npu_get_msg(struct airoha_npu *npu, int ifindex,
+				   enum airoha_npu_wlan_get_cmd cmd,
+				   u32 *val, gfp_t gfp)
+{
+	return airoha_npu_wlan_get_msg(npu, ifindex, cmd, val, sizeof(*val),
+				       gfp);
+}
+
 static inline void mt76_testmode_reset(struct mt76_phy *phy, bool disable)
 {
 #ifdef CONFIG_NL80211_TESTMODE
@@ -1858,6 +1976,23 @@ static inline bool mt76_queue_is_emi(struct mt76_queue *q)
 	return q->flags & MT_QFLAG_EMI_EN;
 }
 
+static inline bool mt76_queue_is_npu(struct mt76_queue *q)
+{
+	return q->flags & MT_QFLAG_NPU;
+}
+
+static inline bool mt76_queue_is_npu_tx(struct mt76_queue *q)
+{
+	return mt76_queue_is_npu(q) &&
+	       FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_TX;
+}
+
+static inline bool mt76_queue_is_npu_rx(struct mt76_queue *q)
+{
+	return mt76_queue_is_npu(q) &&
+	       FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_RX;
+}
+
 struct mt76_txwi_cache *
 mt76_token_release(struct mt76_dev *dev, int token, bool *wake);
 int mt76_token_consume(struct mt76_dev *dev, struct mt76_txwi_cache **ptxwi);
diff --git a/drivers/net/wireless/mediatek/mt76/npu.c b/drivers/net/wireless/mediatek/mt76/npu.c
new file mode 100644
index 0000000000000000000000000000000000000000..df5cecd05f50366397a25f14092702513049c5d6
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/npu.c
@@ -0,0 +1,494 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 AIROHA Inc
+ * Author: Lorenzo Bianconi <lorenzo@kernel.org>
+ */
+#include <linux/kernel.h>
+#include <net/flow_offload.h>
+#include <net/pkt_cls.h>
+
+#include "mt76.h"
+#include "dma.h"
+#include "mt76_connac.h"
+
+#define MT76_NPU_RX_BUF_SIZE	(1800 + \
+				 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
+
+int mt76_npu_fill_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
+{
+	int nframes = 0;
+
+	while (q->queued < q->ndesc - 1) {
+		struct airoha_npu_rx_dma_desc *desc = (void *)q->desc;
+		struct mt76_queue_entry *e = &q->entry[q->head];
+		struct page *page;
+		int offset;
+
+		e->buf = mt76_get_page_pool_buf(q, &offset, q->buf_size);
+		if (!e->buf)
+			break;
+
+		e->dma_len[0] = SKB_WITH_OVERHEAD(q->buf_size);
+		page = virt_to_head_page(e->buf);
+		e->dma_addr[0] = page_pool_get_dma_addr(page) + offset;
+
+		memset(&desc[q->head], 0, sizeof(*desc));
+		desc[q->head].addr = e->dma_addr[0];
+
+		q->head = (q->head + 1) % q->ndesc;
+		q->queued++;
+		nframes++;
+	}
+
+	return nframes;
+}
+
+void mt76_npu_queue_cleanup(struct mt76_dev *dev, struct mt76_queue *q)
+{
+	spin_lock_bh(&q->lock);
+	while (q->queued > 0) {
+		struct mt76_queue_entry *e = &q->entry[q->tail];
+
+		dma_sync_single_for_cpu(dev->dma_dev, e->dma_addr[0],
+					e->dma_len[0],
+					page_pool_get_dma_dir(q->page_pool));
+		mt76_put_page_pool_buf(e->buf, false);
+		q->tail = (q->tail + 1) % q->ndesc;
+		q->queued--;
+	}
+	spin_unlock_bh(&q->lock);
+}
+
+static struct sk_buff *mt76_npu_dequeue(struct mt76_dev *dev,
+					struct mt76_queue *q,
+					u32 *info)
+{
+	struct airoha_npu_rx_dma_desc *desc = (void *)q->desc;
+	int i, nframes, index = q->tail;
+	struct sk_buff *skb = NULL;
+
+	nframes = FIELD_GET(NPU_RX_DMA_PKT_COUNT_MASK, desc[index].info);
+	nframes = max_t(int, nframes, 1);
+
+	for (i = 0; i < nframes; i++) {
+		struct mt76_queue_entry *e = &q->entry[index];
+		int len = FIELD_GET(NPU_RX_DMA_DESC_CUR_LEN_MASK,
+				    desc[index].ctrl);
+
+		if (!FIELD_GET(NPU_RX_DMA_DESC_DONE_MASK, desc[index].ctrl)) {
+			dev_kfree_skb(skb);
+			return NULL;
+		}
+
+		dma_sync_single_for_cpu(dev->dma_dev, e->dma_addr[0],
+					e->dma_len[0],
+					page_pool_get_dma_dir(q->page_pool));
+
+		if (!skb) {
+			skb = napi_build_skb(e->buf, q->buf_size);
+			if (!skb)
+				return NULL;
+
+			__skb_put(skb, len);
+			skb_reset_mac_header(skb);
+			skb_mark_for_recycle(skb);
+		} else {
+			struct skb_shared_info *shinfo = skb_shinfo(skb);
+			struct page *page = virt_to_head_page(e->buf);
+			int nr_frags = shinfo->nr_frags;
+
+			if (nr_frags < ARRAY_SIZE(shinfo->frags))
+				skb_add_rx_frag(skb, nr_frags, page,
+						e->buf - page_address(page),
+						len, q->buf_size);
+		}
+
+		*info = desc[index].info;
+		index = (index + 1) % q->ndesc;
+	}
+	q->tail = index;
+	q->queued -= i;
+	Q_WRITE(q, dma_idx, q->tail);
+
+	return skb;
+}
+
+void mt76_npu_check_ppe(struct mt76_dev *dev, struct sk_buff *skb,
+			u32 info)
+{
+	struct airoha_ppe_dev *ppe_dev;
+	u16 reason, hash;
+
+	if (!mt76_npu_device_active(dev))
+		return;
+
+	rcu_read_lock();
+
+	ppe_dev = rcu_dereference(dev->mmio.ppe_dev);
+	if (!ppe_dev)
+		goto out;
+
+	hash = FIELD_GET(NPU_RX_DMA_FOE_ID_MASK, info);
+	skb_set_hash(skb, hash, PKT_HASH_TYPE_L4);
+
+	reason = FIELD_GET(NPU_RX_DMA_CRSN_MASK, info);
+	if (reason == PPE_CPU_REASON_HIT_UNBIND_RATE_REACHED) {
+		skb_set_mac_header(skb, 0);
+		airoha_ppe_dev_check_skb(ppe_dev, skb, hash, true);
+	}
+out:
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(mt76_npu_check_ppe);
+
+static int mt76_npu_rx_poll(struct napi_struct *napi, int budget)
+{
+	struct mt76_dev *dev = mt76_priv(napi->dev);
+	enum mt76_rxq_id qid = napi - dev->napi;
+	struct airoha_npu *npu;
+	int done = 0;
+
+	rcu_read_lock();
+
+	npu = rcu_dereference(dev->mmio.npu);
+	if (!npu)
+		goto out;
+
+	while (done < budget) {
+		struct sk_buff *skb;
+		u32 info = 0;
+
+		skb = mt76_npu_dequeue(dev, &dev->q_rx[qid], &info);
+		if (!skb)
+			break;
+
+		dev->drv->rx_skb(dev, qid, skb, &info);
+		mt76_rx_poll_complete(dev, qid, napi);
+		done++;
+	}
+
+	mt76_npu_fill_rx_queue(dev, &dev->q_rx[qid]);
+out:
+	if (done < budget && napi_complete(napi))
+		dev->drv->rx_poll_complete(dev, qid);
+
+	rcu_read_unlock();
+
+	return done;
+}
+
+static irqreturn_t mt76_npu_irq_handler(int irq, void *q_instance)
+{
+	struct mt76_queue *q = q_instance;
+	struct mt76_dev *dev = q->dev;
+	int qid = q - &dev->q_rx[0];
+	int index = qid - MT_RXQ_NPU0;
+	struct airoha_npu *npu;
+	u32 status;
+
+	rcu_read_lock();
+
+	npu = rcu_dereference(dev->mmio.npu);
+	if (!npu)
+		goto out;
+
+	status = airoha_npu_wlan_get_irq_status(npu, index);
+	airoha_npu_wlan_set_irq_status(npu, status);
+
+	airoha_npu_wlan_disable_irq(npu, index);
+	napi_schedule(&dev->napi[qid]);
+out:
+	rcu_read_unlock();
+
+	return IRQ_HANDLED;
+}
+
+int mt76_npu_dma_add_buf(struct mt76_phy *phy, struct mt76_queue *q,
+			 struct sk_buff *skb, struct mt76_queue_buf *buf,
+			 void *txwi_ptr)
+{
+	u16 txwi_len = min_t(u16, phy->dev->drv->txwi_size, NPU_TXWI_LEN);
+	struct airoha_npu_tx_dma_desc *desc = (void *)q->desc;
+	int ret;
+
+	/* TODO: Take into account unlinear skbs */
+	memcpy(desc[q->head].txwi, txwi_ptr, txwi_len);
+	desc[q->head].addr = buf->addr;
+	desc[q->head].ctrl = FIELD_PREP(NPU_TX_DMA_DESC_VEND_LEN_MASK, txwi_len) |
+			     FIELD_PREP(NPU_TX_DMA_DESC_LEN_MASK, skb->len) |
+			     NPU_TX_DMA_DESC_DONE_MASK;
+
+	ret = q->head;
+	q->entry[q->head].skip_buf0 = true;
+	q->entry[q->head].skip_buf1 = true;
+	q->entry[q->head].txwi = NULL;
+	q->entry[q->head].skb = NULL;
+	q->entry[q->head].wcid = 0xffff;
+
+	q->head = (q->head + 1) % q->ndesc;
+	q->queued++;
+
+	return ret;
+}
+
+void mt76_npu_txdesc_cleanup(struct mt76_queue *q, int index)
+{
+	struct airoha_npu_tx_dma_desc *desc = (void *)q->desc;
+
+	if (!mt76_queue_is_npu_tx(q))
+		return;
+
+	desc[index].ctrl &= ~NPU_TX_DMA_DESC_DONE_MASK;
+}
+
+void mt76_npu_queue_setup(struct mt76_dev *dev, struct mt76_queue *q)
+{
+	int qid = FIELD_GET(MT_QFLAG_WED_RING, q->flags);
+	bool xmit = mt76_queue_is_npu_tx(q);
+	struct airoha_npu *npu;
+
+	if (!mt76_queue_is_npu(q))
+		return;
+
+	npu = rcu_dereference_protected(dev->mmio.npu, &dev->mutex);
+	if (npu)
+		q->wed_regs = airoha_npu_wlan_get_queue_addr(npu, qid, xmit);
+}
+
+int mt76_npu_rx_queue_init(struct mt76_dev *dev, struct mt76_queue *q)
+{
+	int err, irq, qid = q - &dev->q_rx[0];
+	int size, index = qid - MT_RXQ_NPU0;
+	struct airoha_npu *npu;
+	const char *name;
+
+	mutex_lock(&dev->mutex);
+
+	npu = rcu_dereference_protected(dev->mmio.npu, &dev->mutex);
+	irq = npu && index < ARRAY_SIZE(npu->irqs) ? npu->irqs[index]
+						   : -EINVAL;
+	if (irq < 0) {
+		err = irq;
+		goto out;
+	}
+
+	q->flags = MT_NPU_Q_RX(index);
+	size = qid == MT_RXQ_NPU1 ? NPU_RX1_DESC_NUM : NPU_RX0_DESC_NUM;
+	err = dev->queue_ops->alloc(dev, q, 0, size,
+				    MT76_NPU_RX_BUF_SIZE, 0);
+	if (err)
+		goto out;
+
+	name = devm_kasprintf(dev->dev, GFP_KERNEL, "mt76-npu.%d", index);
+	if (!name) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	err = devm_request_irq(dev->dev, irq, mt76_npu_irq_handler,
+			       IRQF_SHARED, name, q);
+	if (err)
+		goto out;
+
+	netif_napi_add(dev->napi_dev, &dev->napi[qid], mt76_npu_rx_poll);
+	mt76_npu_fill_rx_queue(dev, q);
+	napi_enable(&dev->napi[qid]);
+out:
+	mutex_unlock(&dev->mutex);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(mt76_npu_rx_queue_init);
+
+static int mt76_npu_setup_tc_block_cb(enum tc_setup_type type,
+				      void *type_data, void *cb_priv)
+{
+	struct mt76_phy *phy = cb_priv;
+
+	if (type != TC_SETUP_CLSFLOWER)
+		return -EOPNOTSUPP;
+
+	if (!mt76_ppe_device_active(phy->dev))
+		return -EOPNOTSUPP;
+
+	return airoha_ppe_dev_setup_tc_block_cb(phy->dev->mmio.ppe_dev,
+						type_data);
+}
+
+static int mt76_npu_setup_tc_block(struct mt76_phy *phy,
+				   struct net_device *dev,
+				   struct flow_block_offload *f)
+{
+	flow_setup_cb_t *cb = mt76_npu_setup_tc_block_cb;
+	static LIST_HEAD(block_cb_list);
+	struct flow_block_cb *block_cb;
+
+	if (f->binder_type != FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS)
+		return -EOPNOTSUPP;
+
+	if (!tc_can_offload(dev))
+		return -EOPNOTSUPP;
+
+	f->driver_block_list = &block_cb_list;
+	switch (f->command) {
+	case FLOW_BLOCK_BIND:
+		block_cb = flow_block_cb_lookup(f->block, cb, dev);
+		if (block_cb) {
+			flow_block_cb_incref(block_cb);
+			return 0;
+		}
+
+		block_cb = flow_block_cb_alloc(cb, dev, phy, NULL);
+		if (IS_ERR(block_cb))
+			return PTR_ERR(block_cb);
+
+		flow_block_cb_incref(block_cb);
+		flow_block_cb_add(block_cb, f);
+		list_add_tail(&block_cb->driver_list, &block_cb_list);
+		return 0;
+	case FLOW_BLOCK_UNBIND:
+		block_cb = flow_block_cb_lookup(f->block, cb, dev);
+		if (!block_cb)
+			return -ENOENT;
+
+		if (!flow_block_cb_decref(block_cb)) {
+			flow_block_cb_remove(block_cb, f);
+			list_del(&block_cb->driver_list);
+		}
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+int mt76_npu_net_setup_tc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			  struct net_device *dev, enum tc_setup_type type,
+			  void *type_data)
+{
+	struct mt76_phy *phy = hw->priv;
+
+	if (!tc_can_offload(dev))
+		return -EOPNOTSUPP;
+
+	if (!mt76_npu_device_active(phy->dev))
+		return -EOPNOTSUPP;
+
+	switch (type) {
+	case TC_SETUP_BLOCK:
+	case TC_SETUP_FT:
+		return mt76_npu_setup_tc_block(phy, dev, type_data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+EXPORT_SYMBOL_GPL(mt76_npu_net_setup_tc);
+
+void mt76_npu_disable_irqs(struct mt76_dev *dev)
+{
+	struct airoha_npu *npu;
+	int i;
+
+	rcu_read_lock();
+
+	npu = rcu_dereference(dev->mmio.npu);
+	if (!npu)
+		goto unlock;
+
+	for (i = MT_RXQ_NPU0; i <= MT_RXQ_NPU1; i++) {
+		int qid = i - MT_RXQ_NPU0;
+		u32 status;
+
+		status = airoha_npu_wlan_get_irq_status(npu, qid);
+		airoha_npu_wlan_set_irq_status(npu, status);
+		airoha_npu_wlan_disable_irq(npu, qid);
+	}
+unlock:
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(mt76_npu_disable_irqs);
+
+int mt76_npu_init(struct mt76_dev *dev, phys_addr_t phy_addr, int type)
+{
+	struct airoha_ppe_dev *ppe_dev;
+	struct airoha_npu *npu;
+	int err = 0;
+
+	/* NPU offloading is only supported by MT7992 */
+	if (!is_mt7992(dev))
+		return 0;
+
+	mutex_lock(&dev->mutex);
+
+	npu = airoha_npu_get(dev->dev);
+	if (IS_ERR(npu)) {
+		request_module("airoha-npu");
+		npu = airoha_npu_get(dev->dev);
+	}
+
+	if (IS_ERR(npu)) {
+		err = PTR_ERR(npu);
+		goto error_unlock;
+	}
+
+	ppe_dev = airoha_ppe_get_dev(dev->dev);
+	if (IS_ERR(ppe_dev)) {
+		request_module("airoha-eth");
+		ppe_dev = airoha_ppe_get_dev(dev->dev);
+	}
+
+	if (IS_ERR(ppe_dev)) {
+		err = PTR_ERR(ppe_dev);
+		goto error_npu_put;
+	}
+
+	err = airoha_npu_wlan_init_reserved_memory(npu);
+	if (err)
+		goto error_ppe_put;
+
+	dev->dma_dev = npu->dev;
+	dev->mmio.phy_addr = phy_addr;
+	dev->mmio.npu_type = type;
+	/* NPU offloading requires HW-RRO for RX packet reordering. */
+	dev->hwrro_mode = MT76_HWRRO_V3_1;
+
+	rcu_assign_pointer(dev->mmio.npu, npu);
+	rcu_assign_pointer(dev->mmio.ppe_dev, ppe_dev);
+	synchronize_rcu();
+
+	mutex_unlock(&dev->mutex);
+
+	return 0;
+
+error_ppe_put:
+	airoha_ppe_put_dev(ppe_dev);
+error_npu_put:
+	airoha_npu_put(npu);
+error_unlock:
+	mutex_unlock(&dev->mutex);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(mt76_npu_init);
+
+void mt76_npu_deinit(struct mt76_dev *dev)
+{
+	struct airoha_ppe_dev *ppe_dev;
+	struct airoha_npu *npu;
+
+	mutex_lock(&dev->mutex);
+
+	npu = rcu_replace_pointer(dev->mmio.npu, NULL,
+				  lockdep_is_held(&dev->mutex));
+	if (npu)
+		airoha_npu_put(npu);
+
+	ppe_dev = rcu_replace_pointer(dev->mmio.ppe_dev, NULL,
+				      lockdep_is_held(&dev->mutex));
+	if (ppe_dev)
+		airoha_ppe_put_dev(ppe_dev);
+
+	mutex_unlock(&dev->mutex);
+
+	mt76_npu_queue_cleanup(dev, &dev->q_rx[MT_RXQ_NPU0]);
+	mt76_npu_queue_cleanup(dev, &dev->q_rx[MT_RXQ_NPU1]);
+}
diff --git a/include/linux/soc/airoha/airoha_offload.h b/include/linux/soc/airoha/airoha_offload.h
index 6f66eb339b3fc6e130c24bf04f7daa898314f1e2..4d23cbb7d407596a6180eba7d7c8ca2b3949ed09 100644
--- a/include/linux/soc/airoha/airoha_offload.h
+++ b/include/linux/soc/airoha/airoha_offload.h
@@ -6,6 +6,7 @@
 #ifndef AIROHA_OFFLOAD_H
 #define AIROHA_OFFLOAD_H
 
+#include <linux/skbuff.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 

-- 
2.51.0


