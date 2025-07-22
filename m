Return-Path: <linux-wireless+bounces-25835-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF34B0D4D6
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 10:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7176116FBA5
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 08:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CAC228C86;
	Tue, 22 Jul 2025 08:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HF5MDKi5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CFE2D7805
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753173798; cv=none; b=dwIiIfONmMlHuLK2ODN3b/rcBHPJRkjyGOX/0tVL3cJ0rUIsTejVtcgXtdJmGd722XVP6POfxafLnOx6ii309NFOA5EmiyzvN66wt2ImtEwVNDEMwbbMn8dTsGmv0V1znBq2942MYMBYJnC8N7+rINF+7ulPWTeAumHOjfMB8nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753173798; c=relaxed/simple;
	bh=/C2Tsg2kumLYl3KA3/RFMLwL/WG8MKTuehNqGDyS4W4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnvwQDrI847avFiFOh5p2+zfQmZGZsYpZ+Q7+3VbwWUGX+pQ0PW3foaUphnG0k+mVXtTUmMKF8zbiBTq6plR6ojNyMxJCGiwJQjyAMTvlIH8qZsCRja7nqZhelzKYVi0+T75TSYf8+JVEW6J8HfnRiEeOmiCqf2VwyWeHLFENxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HF5MDKi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753DDC4CEEB;
	Tue, 22 Jul 2025 08:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753173797;
	bh=/C2Tsg2kumLYl3KA3/RFMLwL/WG8MKTuehNqGDyS4W4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HF5MDKi5AataHumpYN7Dh1/R0tbaiO9pNo2OjoMW8jpPJB6bO5ks2jszf+v0290LA
	 58YIHiq3IE2PPLKDnqvhkINvGw0ry6HFk+/rHxN0rGGU+3VETvnuZC5sNIm3GaEsZD
	 ENxn1BkABp+JdvTrTljcXfKibTJO7a/JDwv6CLMaQRnZchKG5znOqAquHpkXQa9h8x
	 VekpfQLFrQGS+K2y/owA0MZE3YoaFgj9pY1ifgJDaklBUW2Inasfkz4X4flI6H2v6q
	 CHhSJln8/mB5pN+3t/EHGHMgwbuS8GX6j9q54mrGENcHu/W70lIXCuyF9fvw8zRf8i
	 HyAOiLnySXcLA==
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
Subject: [RFC mt76 v2 3/4] wifi: mt76: Introduce the NPU generic layer
Date: Tue, 22 Jul 2025 10:42:26 +0200
Message-ID: <112fcef21bf490a2fa2c58ab1e4822756fe3c601.1753173330.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1753173330.git.lorenzo@kernel.org>
References: <cover.1753173330.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the NPU generic layer in mt76 module. NPU will be used to enable
traffic forward offloading between the MT76 NIC and Airoha ethernet one
available on the Airoha EN7581 SoC using Netfilter Flowtable APIs.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/Makefile   |   1 +
 drivers/net/wireless/mediatek/mt76/dma.c      |  39 +-
 drivers/net/wireless/mediatek/mt76/dma.h      |  36 ++
 drivers/net/wireless/mediatek/mt76/mac80211.c |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  90 +++++
 drivers/net/wireless/mediatek/mt76/npu.c      | 378 ++++++++++++++++++
 6 files changed, 544 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/npu.c

diff --git a/drivers/net/wireless/mediatek/mt76/Makefile b/drivers/net/wireless/mediatek/mt76/Makefile
index 87512d101a91..1bca01f2fe5e 100644
--- a/drivers/net/wireless/mediatek/mt76/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/Makefile
@@ -12,6 +12,7 @@ mt76-y := \
 	mmio.o util.o trace.o dma.o mac80211.o debugfs.o eeprom.o \
 	tx.o agg-rx.o mcu.o wed.o scan.o channel.o
 
+mt76-$(CONFIG_NET_AIROHA_NPU) += npu.o
 mt76-$(CONFIG_PCI) += pci.o
 mt76-$(CONFIG_NL80211_TESTMODE) += testmode.o
 
diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 48e5c4e98937..4299be20d906 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -162,6 +162,11 @@ mt76_dma_sync_idx(struct mt76_dev *dev, struct mt76_queue *q)
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
@@ -172,7 +177,7 @@ void __mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q,
 	if (!q || !q->ndesc)
 		return;
 
-	if (!mt76_queue_is_wed_rro_ind(q)) {
+	if (!mt76_queue_is_wed_rro_ind(q) && !mt76_queue_is_npu(q)) {
 		int i;
 
 		/* clear descriptors */
@@ -364,6 +369,7 @@ mt76_dma_tx_cleanup(struct mt76_dev *dev, struct mt76_queue *q, bool flush)
 
 	while (q->queued > 0 && q->tail != last) {
 		mt76_dma_tx_cleanup_idx(dev, q, q->tail, &entry);
+		mt76_npu_txdesc_cleanup(q, q->tail);
 		mt76_queue_tx_complete(dev, q, &entry);
 
 		if (entry.txwi) {
@@ -522,6 +528,10 @@ mt76_dma_tx_queue_skb(struct mt76_phy *phy, struct mt76_queue *q,
 	if (test_bit(MT76_RESET, &phy->state))
 		goto free_skb;
 
+	/* FIXME: Take into account unlinear skbs */
+	if (mt76_npu_device_active(dev) && skb_linearize(skb))
+		goto free_skb;
+
 	t = mt76_get_txwi(dev);
 	if (!t)
 		goto free_skb;
@@ -569,6 +579,9 @@ mt76_dma_tx_queue_skb(struct mt76_phy *phy, struct mt76_queue *q,
 	if (ret < 0)
 		goto unmap;
 
+	if (mt76_queue_is_npu_tx(q))
+		return mt76_npu_dma_add_buf(phy, q, skb, &tx_info.buf[1], txwi);
+
 	return mt76_dma_add_buf(dev, q, tx_info.buf, tx_info.nbuf,
 				tx_info.info, tx_info.skb, t);
 
@@ -671,8 +684,15 @@ mt76_dma_alloc_queue(struct mt76_dev *dev, struct mt76_queue *q,
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
@@ -700,6 +720,7 @@ mt76_dma_alloc_queue(struct mt76_dev *dev, struct mt76_queue *q,
 	if (ret)
 		return ret;
 
+	mt76_npu_queue_setup(dev, q);
 	ret = mt76_wed_dma_setup(dev, q, false);
 	if (ret)
 		return ret;
@@ -724,6 +745,11 @@ mt76_dma_rx_cleanup(struct mt76_dev *dev, struct mt76_queue *q)
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
@@ -753,7 +779,7 @@ mt76_dma_rx_reset(struct mt76_dev *dev, enum mt76_rxq_id qid)
 	if (!q->ndesc)
 		return;
 
-	if (!mt76_queue_is_wed_rro_ind(q)) {
+	if (!mt76_queue_is_wed_rro_ind(q) && !mt76_queue_is_npu(q)) {
 		int i;
 
 		for (i = 0; i < q->ndesc; i++)
@@ -773,7 +799,10 @@ mt76_dma_rx_reset(struct mt76_dev *dev, enum mt76_rxq_id qid)
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
index 982722b2e5a5..62c581b427ac 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.h
+++ b/drivers/net/wireless/mediatek/mt76/dma.h
@@ -65,6 +65,42 @@
 		writel(_val, &(_q)->regs->_field);			\
 } while (0)
 
+#elif (IS_BUILTIN(CONFIG_NET_AIROHA_NPU) || IS_MODULE(CONFIG_NET_AIROHA_NPU))
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
index 3afe4c4cd7bb..7aa62476e051 100644
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
@@ -1509,7 +1512,8 @@ void mt76_rx_poll_complete(struct mt76_dev *dev, enum mt76_rxq_id q,
 
 	while ((skb = __skb_dequeue(&dev->rx_skb[q])) != NULL) {
 		mt76_check_sta(dev, skb);
-		if (mtk_wed_device_active(&dev->mmio.wed))
+		if (mtk_wed_device_active(&dev->mmio.wed) ||
+		    mt76_npu_device_active(dev))
 			__skb_queue_tail(&frames, skb);
 		else
 			mt76_rx_aggr_reorder(skb, &frames);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index db37de583709..6523153eb5ff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -14,6 +14,7 @@
 #include <linux/usb.h>
 #include <linux/average.h>
 #include <linux/soc/mediatek/mtk_wed.h>
+#include <linux/soc/airoha/airoha_offload.h>
 #include <net/mac80211.h>
 #include <net/page_pool/helpers.h>
 #include "util.h"
@@ -33,6 +34,7 @@
 #define MT_QFLAG_WED		BIT(5)
 #define MT_QFLAG_WED_RRO	BIT(6)
 #define MT_QFLAG_WED_RRO_EN	BIT(7)
+#define MT_QFLAG_NPU		BIT(8)
 
 #define __MT_WED_Q(_type, _n)	(MT_QFLAG_WED | \
 				 FIELD_PREP(MT_QFLAG_WED_TYPE, _type) | \
@@ -46,6 +48,12 @@
 #define MT_WED_RRO_Q_MSDU_PG(_n)	__MT_WED_RRO_Q(MT76_WED_RRO_Q_MSDU_PG, _n)
 #define MT_WED_RRO_Q_IND	__MT_WED_RRO_Q(MT76_WED_RRO_Q_IND, 0)
 
+#define __MT_NPU_Q(_type, _n)	(MT_QFLAG_NPU | \
+				 FIELD_PREP(MT_QFLAG_WED_TYPE, _type) | \
+				 FIELD_PREP(MT_QFLAG_WED_RING, _n))
+#define MT_NPU_Q_TX(_n)		__MT_NPU_Q(MT76_WED_Q_TX, _n)
+#define MT_NPU_Q_RX(_n)		__MT_NPU_Q(MT76_WED_Q_RX, _n)
+
 struct mt76_dev;
 struct mt76_phy;
 struct mt76_wcid;
@@ -129,6 +137,8 @@ enum mt76_rxq_id {
 	MT_RXQ_TXFREE_BAND1,
 	MT_RXQ_TXFREE_BAND2,
 	MT_RXQ_RRO_IND,
+	MT_RXQ_NPU0,
+	MT_RXQ_NPU1,
 	__MT_RXQ_MAX
 };
 
@@ -683,6 +693,10 @@ struct mt76_mmio {
 	struct mtk_wed_device wed_hif2;
 	struct completion wed_reset;
 	struct completion wed_reset_complete;
+
+	struct airoha_npu __rcu *npu;
+	phys_addr_t phy_addr;
+	int npu_type;
 };
 
 struct mt76_rx_status {
@@ -1572,6 +1586,65 @@ int mt76_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *skb,
 int mt76_testmode_set_state(struct mt76_phy *phy, enum mt76_testmode_state state);
 int mt76_testmode_alloc_skb(struct mt76_phy *phy, u32 len);
 
+#if (IS_BUILTIN(CONFIG_NET_AIROHA_NPU) || IS_MODULE(CONFIG_NET_AIROHA_NPU))
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
+#else
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
+#endif /* CONFIG_NET_AIROHA_NPU */
+
+static inline bool mt76_npu_device_active(struct mt76_dev *dev)
+{
+	return !!rcu_access_pointer(dev->mmio.npu);
+}
+
 static inline void mt76_testmode_reset(struct mt76_phy *phy, bool disable)
 {
 #ifdef CONFIG_NL80211_TESTMODE
@@ -1799,6 +1872,23 @@ static inline bool mt76_queue_is_wed_rx(struct mt76_queue *q)
 
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
index 000000000000..a9d8ee674c72
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/npu.c
@@ -0,0 +1,378 @@
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
+static bool npu_enable = true;
+module_param(npu_enable, bool, 0644);
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
+	/* FIXME: Take into account unlinear skbs */
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
+	mutex_lock(&dev->mutex);
+
+	npu = rcu_dereference_protected(dev->mmio.npu, &dev->mutex);
+	if (npu)
+		q->wed_regs = airoha_npu_wlan_get_queue_addr(npu, qid, xmit);
+
+	mutex_unlock(&dev->mutex);
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
+		goto error_unlock;
+	}
+
+	err = mt76_create_page_pool(dev, q);
+	if (err)
+		goto error_unlock;
+
+	q->flags = MT_NPU_Q_RX(index);
+	size = qid == MT_RXQ_NPU1 ? NPU_RX1_DESC_NUM : NPU_RX0_DESC_NUM;
+	err = dev->queue_ops->alloc(dev, q, 0, size,
+				    MT76_NPU_RX_BUF_SIZE, 0);
+	if (err)
+		goto erro_destroy_page_pool;
+
+	name = devm_kasprintf(dev->dev, GFP_KERNEL, "mt76-npu" ".%d", index);
+	if (!name) {
+		err = -ENOMEM;
+		goto erro_destroy_page_pool;
+	}
+
+	err = devm_request_irq(dev->dev, irq, mt76_npu_irq_handler,
+			       IRQF_SHARED, name, q);
+	if (err)
+		goto erro_destroy_page_pool;
+
+	netif_napi_add(dev->napi_dev, &dev->napi[qid], mt76_npu_rx_poll);
+	mt76_npu_fill_rx_queue(dev, q);
+	napi_enable(&dev->napi[qid]);
+
+	mutex_unlock(&dev->mutex);
+
+	return 0;
+
+erro_destroy_page_pool:
+	page_pool_destroy(q->page_pool);
+error_unlock:
+	mutex_unlock(&dev->mutex);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(mt76_npu_rx_queue_init);
+
+void mt76_npu_disable_irqs(struct mt76_dev *dev)
+{
+	struct airoha_npu *npu;
+	u32 status;
+	int i;
+
+	rcu_read_lock();
+
+	npu = rcu_dereference(dev->mmio.npu);
+	if (!npu)
+		goto unlock;
+
+	for (i = MT_RXQ_NPU0; i <= MT_RXQ_NPU1; i++) {
+		status = airoha_npu_wlan_get_irq_status(npu, i);
+		airoha_npu_wlan_set_irq_status(npu, status);
+		airoha_npu_wlan_disable_irq(npu, i);
+	}
+unlock:
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(mt76_npu_disable_irqs);
+
+int mt76_npu_init(struct mt76_dev *dev, phys_addr_t phy_addr, int type)
+{
+	struct airoha_npu *npu;
+	int err = 0;
+
+	/* NPU offloading is only supported by MT7992 */
+	if (!is_mt7992(dev))
+		return 0;
+
+	if (!npu_enable)
+		return 0;
+
+	mutex_lock(&dev->mutex);
+
+	npu = airoha_npu_get(dev->dev, NULL);
+	if (IS_ERR(npu)) {
+		request_module("airoha-npu");
+		npu = airoha_npu_get(dev->dev, NULL);
+	}
+
+	if (IS_ERR(npu)) {
+		err = PTR_ERR(npu);
+		goto error_unlock;
+	}
+
+	err = airoha_npu_wlan_init_reserved_memory(npu);
+	if (err)
+		goto error_npu_put;
+
+	dev->dma_dev = npu->dev;
+	dev->mmio.phy_addr = phy_addr;
+	dev->mmio.npu_type = type;
+
+	rcu_assign_pointer(dev->mmio.npu, npu);
+	synchronize_rcu();
+
+	mutex_unlock(&dev->mutex);
+
+	return err;
+
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
+	struct airoha_npu *npu;
+
+	mutex_lock(&dev->mutex);
+
+	npu = rcu_replace_pointer(dev->mmio.npu, NULL,
+				  lockdep_is_held(&dev->mutex));
+	if (npu)
+		airoha_npu_put(npu);
+
+	mutex_unlock(&dev->mutex);
+
+	mt76_npu_queue_cleanup(dev, &dev->q_rx[MT_RXQ_NPU0]);
+	mt76_npu_queue_cleanup(dev, &dev->q_rx[MT_RXQ_NPU1]);
+}
-- 
2.50.1


