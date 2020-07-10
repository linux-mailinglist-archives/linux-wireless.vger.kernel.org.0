Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9B021B592
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2020 14:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgGJM4w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jul 2020 08:56:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727886AbgGJM4s (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jul 2020 08:56:48 -0400
Received: from localhost.localdomain.com (unknown [151.48.133.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27F6020720;
        Fri, 10 Jul 2020 12:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594385806;
        bh=m9fkXE/wN6sjNWRY/iDWi8IDwmDaQOUSQg1FB2cZVNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l6DitMPg4tZbGyI09tsUQQ+htuGs+GI5C5fB6sMxobyIHhx4/HjfjA9AFulWjT941
         T0vsLd3ccgJOZCHybL0wgVFhbtrNRDj1d0Oclvb4Tt84V42/BhI9lqnzmVRx+yYxdh
         y1KdBYcuv8kHko0l0VTld5XavUZV4DUUYQOnJF3s=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 5/6] mt76: introduce mt76_sdio module
Date:   Fri, 10 Jul 2020 14:56:19 +0200
Message-Id: <1070b3bf1f02941f122b19e80354c25761d0cf87.1594384887.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1594384887.git.lorenzo@kernel.org>
References: <cover.1594384887.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Introduce mt76_sdio module as common layer to add mt7663s support

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/Kconfig    |   4 +
 drivers/net/wireless/mediatek/mt76/Makefile   |   2 +
 drivers/net/wireless/mediatek/mt76/mac80211.c |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  32 +
 .../wireless/mediatek/mt76/mt7615/usb_sdio.c  |   5 +-
 drivers/net/wireless/mediatek/mt76/sdio.c     | 948 ++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/sdio.h     | 111 ++
 7 files changed, 1106 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/sdio.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/sdio.h

diff --git a/drivers/net/wireless/mediatek/mt76/Kconfig b/drivers/net/wireless/mediatek/mt76/Kconfig
index 41533a0e1720..31015d2a8e7d 100644
--- a/drivers/net/wireless/mediatek/mt76/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/Kconfig
@@ -12,6 +12,10 @@ config MT76_USB
 	tristate
 	depends on MT76_CORE
 
+config MT76_SDIO
+	tristate
+	depends on MT76_CORE
+
 config MT76x02_LIB
 	tristate
 	select MT76_CORE
diff --git a/drivers/net/wireless/mediatek/mt76/Makefile b/drivers/net/wireless/mediatek/mt76/Makefile
index 949b3c8ffa1b..e53584db0756 100644
--- a/drivers/net/wireless/mediatek/mt76/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_MT76_CORE) += mt76.o
 obj-$(CONFIG_MT76_USB) += mt76-usb.o
+obj-$(CONFIG_MT76_SDIO) += mt76-sdio.o
 obj-$(CONFIG_MT76x02_LIB) += mt76x02-lib.o
 obj-$(CONFIG_MT76x02_USB) += mt76x02-usb.o
 
@@ -12,6 +13,7 @@ mt76-$(CONFIG_PCI) += pci.o
 mt76-$(CONFIG_NL80211_TESTMODE) += testmode.o
 
 mt76-usb-y := usb.o usb_trace.o
+mt76-sdio-y := sdio.o
 
 CFLAGS_trace.o := -I$(src)
 CFLAGS_usb_trace.o := -I$(src)
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index f340af40f8f4..3d4bf72700a5 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -305,7 +305,11 @@ mt76_phy_init(struct mt76_dev *dev, struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, SUPPORTS_CLONED_SKBS);
 	ieee80211_hw_set(hw, SUPPORTS_AMSDU_IN_AMPDU);
 	ieee80211_hw_set(hw, TX_AMSDU);
-	ieee80211_hw_set(hw, TX_FRAG_LIST);
+
+	/* TODO: avoid linearization for SDIO */
+	if (!mt76_is_sdio(dev))
+		ieee80211_hw_set(hw, TX_FRAG_LIST);
+
 	ieee80211_hw_set(hw, MFP_CAPABLE);
 	ieee80211_hw_set(hw, AP_LINK_PS);
 	ieee80211_hw_set(hw, REPORTS_TX_ACK_STATUS);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index e6a402c0f5eb..136cb5d60f54 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -34,6 +34,7 @@ struct mt76_reg_pair {
 enum mt76_bus_type {
 	MT76_BUS_MMIO,
 	MT76_BUS_USB,
+	MT76_BUS_SDIO,
 };
 
 struct mt76_bus_ops {
@@ -53,6 +54,7 @@ struct mt76_bus_ops {
 
 #define mt76_is_usb(dev) ((dev)->bus->type == MT76_BUS_USB)
 #define mt76_is_mmio(dev) ((dev)->bus->type == MT76_BUS_MMIO)
+#define mt76_is_sdio(dev) ((dev)->bus->type == MT76_BUS_SDIO)
 
 enum mt76_txq_id {
 	MT_TXQ_VO = IEEE80211_AC_VO,
@@ -95,6 +97,7 @@ struct mt76_queue_entry {
 	union {
 		struct mt76_txwi_cache *txwi;
 		struct urb *urb;
+		size_t buf_sz;
 	};
 	enum mt76_txq_id qid;
 	bool skip_buf0:1;
@@ -147,6 +150,8 @@ struct mt76_mcu_ops {
 			    int len, bool wait_resp);
 	int (*mcu_skb_send_msg)(struct mt76_dev *dev, struct sk_buff *skb,
 				int cmd, bool wait_resp);
+	u32 (*mcu_rr)(struct mt76_dev *dev, u32 offset);
+	void (*mcu_wr)(struct mt76_dev *dev, u32 offset, u32 val);
 	int (*mcu_wr_rp)(struct mt76_dev *dev, u32 base,
 			 const struct mt76_reg_pair *rp, int len);
 	int (*mcu_rd_rp)(struct mt76_dev *dev, u32 base,
@@ -441,6 +446,26 @@ struct mt76_usb {
 	} mcu;
 };
 
+#define MT76_SDIO_RX_QUOTA	32
+struct mt76_sdio {
+	struct tasklet_struct rx_tasklet;
+
+	struct task_struct *kthread;
+	struct work_struct stat_work;
+
+	unsigned long state;
+
+	struct sdio_func *func;
+
+	struct {
+		struct mutex lock;
+		int pse_data_quota;
+		int ple_data_quota;
+		int pse_mcu_quota;
+		int deficit;
+	} sched;
+};
+
 struct mt76_mmio {
 	void __iomem *regs;
 	spinlock_t irq_lock;
@@ -628,6 +653,7 @@ struct mt76_dev {
 	union {
 		struct mt76_mmio mmio;
 		struct mt76_usb usb;
+		struct mt76_sdio sdio;
 	};
 };
 
@@ -1039,6 +1065,12 @@ void mt76u_stop_rx(struct mt76_dev *dev);
 int mt76u_resume_rx(struct mt76_dev *dev);
 void mt76u_queues_deinit(struct mt76_dev *dev);
 
+int mt76s_init(struct mt76_dev *dev, struct sdio_func *func);
+int mt76s_alloc_queues(struct mt76_dev *dev);
+void mt76s_stop_txrx(struct mt76_dev *dev);
+void mt76s_deinit(struct mt76_dev *dev);
+u32 mt76s_read_pcr(struct mt76_dev *dev);
+
 struct sk_buff *
 mt76_mcu_msg_alloc(struct mt76_dev *dev, const void *data,
 		   int data_len);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
index 610cc1fbec5b..50009bc5ee8d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
@@ -359,7 +359,10 @@ int mt7663_usb_sdio_register_device(struct mt7615_dev *dev)
 		return err;
 
 	/* check hw sg support in order to enable AMSDU */
-	hw->max_tx_fragments = dev->mt76.usb.sg_en ? MT_HW_TXP_MAX_BUF_NUM : 1;
+	if (dev->mt76.usb.sg_en || mt76_is_sdio(&dev->mt76))
+		hw->max_tx_fragments = MT_HW_TXP_MAX_BUF_NUM;
+	else
+		hw->max_tx_fragments = 1;
 	hw->extra_tx_headroom += MT_USB_TXD_SIZE;
 	if (mt76_is_usb(&dev->mt76))
 		hw->extra_tx_headroom += MT_USB_HDR_SIZE;
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
new file mode 100644
index 000000000000..f49ebd4ed835
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -0,0 +1,948 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc.
+ *
+ * This file is written based on mt76/usb.c.
+ *
+ * Author: Felix Fietkau <nbd@nbd.name>
+ *	   Lorenzo Bianconi <lorenzo@kernel.org>
+ *	   Sean Wang <sean.wang@mediatek.com>
+ */
+
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mmc/sdio_func.h>
+#include <linux/sched.h>
+#include <linux/kthread.h>
+
+#include "mt76.h"
+#include "sdio.h"
+#include "trace.h"
+
+static u32 mt76s_read_whisr(struct mt76_dev *dev)
+{
+	return sdio_readl(dev->sdio.func, MCR_WHISR, NULL);
+}
+
+u32 mt76s_read_pcr(struct mt76_dev *dev)
+{
+	return sdio_readl(dev->sdio.func, MCR_WHLPCR, NULL);
+}
+EXPORT_SYMBOL_GPL(mt76s_read_pcr);
+
+static u32 mt76s_rr_mailbox(struct mt76_dev *dev, u32 offset)
+{
+	struct sdio_func *func = dev->sdio.func;
+	u32 val = ~0, status;
+	int err;
+
+	sdio_claim_host(func);
+
+	sdio_writel(func, offset, MCR_H2DSM0R, &err);
+	if (err < 0) {
+		dev_err(dev->dev, "failed setting address [err=%d]\n", err);
+		goto out;
+	}
+
+	sdio_writel(func, H2D_SW_INT_READ, MCR_WSICR, &err);
+	if (err < 0) {
+		dev_err(dev->dev, "failed setting read mode [err=%d]\n", err);
+		goto out;
+	}
+
+	err = readx_poll_timeout(mt76s_read_whisr, dev, status,
+				 status & H2D_SW_INT_READ, 0, 1000000);
+	if (err < 0) {
+		dev_err(dev->dev, "query whisr timeout\n");
+		goto out;
+	}
+
+	sdio_writel(func, H2D_SW_INT_READ, MCR_WHISR, &err);
+	if (err < 0) {
+		dev_err(dev->dev, "failed setting read mode [err=%d]\n", err);
+		goto out;
+	}
+
+	val = sdio_readl(func, MCR_H2DSM0R, &err);
+	if (err < 0) {
+		dev_err(dev->dev, "failed reading h2dsm0r [err=%d]\n", err);
+		goto out;
+	}
+
+	if (val != offset) {
+		dev_err(dev->dev, "register mismatch\n");
+		val = ~0;
+		goto out;
+	}
+
+	val = sdio_readl(func, MCR_D2HRM1R, &err);
+	if (err < 0)
+		dev_err(dev->dev, "failed reading d2hrm1r [err=%d]\n", err);
+
+out:
+	sdio_release_host(func);
+
+	return val;
+}
+
+static void mt76s_wr_mailbox(struct mt76_dev *dev, u32 offset, u32 val)
+{
+	struct sdio_func *func = dev->sdio.func;
+	u32 status;
+	int err;
+
+	sdio_claim_host(func);
+
+	sdio_writel(func, offset, MCR_H2DSM0R, &err);
+	if (err < 0) {
+		dev_err(dev->dev, "failed setting address [err=%d]\n", err);
+		goto out;
+	}
+
+	sdio_writel(func, val, MCR_H2DSM1R, &err);
+	if (err < 0) {
+		dev_err(dev->dev,
+			"failed setting write value [err=%d]\n", err);
+		goto out;
+	}
+
+	sdio_writel(func, H2D_SW_INT_WRITE, MCR_WSICR, &err);
+	if (err < 0) {
+		dev_err(dev->dev, "failed setting write mode [err=%d]\n", err);
+		goto out;
+	}
+
+	err = readx_poll_timeout(mt76s_read_whisr, dev, status,
+				 status & H2D_SW_INT_WRITE, 0, 1000000);
+	if (err < 0) {
+		dev_err(dev->dev, "query whisr timeout\n");
+		goto out;
+	}
+
+	sdio_writel(func, H2D_SW_INT_WRITE, MCR_WHISR, &err);
+	if (err < 0) {
+		dev_err(dev->dev, "failed setting write mode [err=%d]\n", err);
+		goto out;
+	}
+
+	val = sdio_readl(func, MCR_H2DSM0R, &err);
+	if (err < 0) {
+		dev_err(dev->dev, "failed reading h2dsm0r [err=%d]\n", err);
+		goto out;
+	}
+
+	if (val != offset)
+		dev_err(dev->dev, "register mismatch\n");
+
+out:
+	sdio_release_host(func);
+}
+
+static u32 mt76s_rr(struct mt76_dev *dev, u32 offset)
+{
+	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->phy.state))
+		return dev->mcu_ops->mcu_rr(dev, offset);
+	else
+		return mt76s_rr_mailbox(dev, offset);
+}
+
+static void mt76s_wr(struct mt76_dev *dev, u32 offset, u32 val)
+{
+	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->phy.state))
+		dev->mcu_ops->mcu_wr(dev, offset, val);
+	else
+		mt76s_wr_mailbox(dev, offset, val);
+}
+
+static u32 mt76s_rmw(struct mt76_dev *dev, u32 offset, u32 mask, u32 val)
+{
+	val |= mt76s_rr(dev, offset) & ~mask;
+	mt76s_wr(dev, offset, val);
+
+	return val;
+}
+
+static void mt76s_write_copy(struct mt76_dev *dev, u32 offset,
+			     const void *data, int len)
+{
+	const u32 *val = data;
+	int i;
+
+	for (i = 0; i < len / sizeof(u32); i++) {
+		mt76s_wr(dev, offset, val[i]);
+		offset += sizeof(u32);
+	}
+}
+
+static void mt76s_read_copy(struct mt76_dev *dev, u32 offset,
+			    void *data, int len)
+{
+	u32 *val = data;
+	int i;
+
+	for (i = 0; i < len / sizeof(u32); i++) {
+		val[i] = mt76s_rr(dev, offset);
+		offset += sizeof(u32);
+	}
+}
+
+static int
+mt76s_wr_rp(struct mt76_dev *dev, u32 base,
+	    const struct mt76_reg_pair *data, int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++) {
+		mt76s_wr(dev, data->reg, data->value);
+		data++;
+	}
+
+	return 0;
+}
+
+static int
+mt76s_rd_rp(struct mt76_dev *dev, u32 base,
+	    struct mt76_reg_pair *data, int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++) {
+		data->value = mt76s_rr(dev, data->reg);
+		data++;
+	}
+
+	return 0;
+}
+
+static void
+mt76s_free_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
+{
+	struct page *page;
+	int i;
+
+	for (i = 0; i < q->ndesc; i++) {
+		if (!q->entry[i].buf)
+			continue;
+
+		skb_free_frag(q->entry[i].buf);
+		q->entry[i].buf = NULL;
+	}
+
+	if (!q->rx_page.va)
+		return;
+
+	page = virt_to_page(q->rx_page.va);
+	__page_frag_cache_drain(page, q->rx_page.pagecnt_bias);
+	memset(&q->rx_page, 0, sizeof(q->rx_page));
+}
+
+static int
+mt76s_alloc_rx_queue(struct mt76_dev *dev, enum mt76_rxq_id qid)
+{
+	struct mt76_queue *q = &dev->q_rx[qid];
+	int i;
+
+	spin_lock_init(&q->lock);
+	q->entry = devm_kcalloc(dev->dev,
+				MT_NUM_RX_ENTRIES, sizeof(*q->entry),
+				GFP_KERNEL);
+	if (!q->entry)
+		return -ENOMEM;
+
+	q->ndesc = MT_NUM_RX_ENTRIES;
+	q->buf_size = PAGE_SIZE;
+
+	for (i = 0; i < q->ndesc; i++) {
+		struct mt76_queue_entry *e = &q->entry[i];
+
+		e->buf = page_frag_alloc(&q->rx_page, q->buf_size,
+					 GFP_KERNEL);
+		if (!e->buf) {
+			mt76s_free_rx_queue(dev, q);
+			return -ENOMEM;
+		}
+	}
+
+	q->head = q->tail = 0;
+	q->queued = 0;
+
+	return 0;
+}
+
+static int mt76s_alloc_tx(struct mt76_dev *dev)
+{
+	struct mt76_queue *q;
+	int i;
+
+	for (i = 0; i < MT_TXQ_MCU_WA; i++) {
+		INIT_LIST_HEAD(&dev->q_tx[i].swq);
+
+		q = devm_kzalloc(dev->dev, sizeof(*q), GFP_KERNEL);
+		if (!q)
+			return -ENOMEM;
+
+		spin_lock_init(&q->lock);
+		q->hw_idx = i;
+		dev->q_tx[i].q = q;
+
+		q->entry = devm_kcalloc(dev->dev,
+					MT_NUM_TX_ENTRIES, sizeof(*q->entry),
+					GFP_KERNEL);
+		if (!q->entry)
+			return -ENOMEM;
+
+		q->ndesc = MT_NUM_TX_ENTRIES;
+	}
+
+	return 0;
+}
+
+void mt76s_stop_txrx(struct mt76_dev *dev)
+{
+	struct mt76_sdio *sdio = &dev->sdio;
+	int i;
+
+	tasklet_kill(&dev->tx_tasklet);
+	tasklet_kill(&sdio->rx_tasklet);
+
+	for (i = 0; i < MT_TXQ_MCU_WA; i++) {
+		struct mt76_queue_entry entry;
+		struct mt76_queue *q;
+
+		q = dev->q_tx[i].q;
+		if (!q)
+			continue;
+
+		spin_lock_bh(&q->lock);
+		while (q->queued) {
+			entry = q->entry[q->head];
+			q->head = (q->head + 1) % q->ndesc;
+			q->queued--;
+
+			if (i != MT_TXQ_MCU)
+				dev->drv->tx_complete_skb(dev, i, &entry);
+			else
+				dev_kfree_skb(entry.skb);
+		}
+		spin_unlock_bh(&q->lock);
+	}
+
+	cancel_work_sync(&sdio->stat_work);
+	clear_bit(MT76_READING_STATS, &dev->phy.state);
+
+	mt76_tx_status_check(dev, NULL, true);
+}
+EXPORT_SYMBOL_GPL(mt76s_stop_txrx);
+
+int mt76s_alloc_queues(struct mt76_dev *dev)
+{
+	int i;
+
+	for (i = 0; i < MT_RXQ_MCU_WA; i++) {
+		int err;
+
+		err = mt76s_alloc_rx_queue(dev, i);
+		if (err < 0)
+			return err;
+	}
+
+	return mt76s_alloc_tx(dev);
+}
+EXPORT_SYMBOL_GPL(mt76s_alloc_queues);
+
+static struct mt76_queue_entry *
+mt76s_get_next_rx_entry(struct mt76_queue *q)
+{
+	struct mt76_queue_entry *e = NULL;
+
+	spin_lock_bh(&q->lock);
+	if (q->queued > 0) {
+		e = &q->entry[q->head];
+		q->head = (q->head + 1) % q->ndesc;
+		q->queued--;
+	}
+	spin_unlock_bh(&q->lock);
+
+	return e;
+}
+
+static struct sk_buff *
+mt76s_build_rx_skb(struct mt76_dev *dev, void *data,
+		   int len, int buf_size)
+{
+	struct sk_buff *skb;
+
+	if (SKB_WITH_OVERHEAD(buf_size) < len) {
+		struct page *page;
+
+		/* slow path, not enough space for data and
+		 * skb_shared_info
+		 */
+		skb = alloc_skb(MT_SKB_HEAD_LEN, GFP_ATOMIC);
+		if (!skb)
+			return NULL;
+
+		skb_put_data(skb, data, MT_SKB_HEAD_LEN);
+		data += MT_SKB_HEAD_LEN;
+		page = virt_to_head_page(data);
+		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+				page, data - page_address(page),
+				len - MT_SKB_HEAD_LEN, buf_size);
+		return skb;
+	}
+
+	/* fast path */
+	skb = build_skb(data, buf_size);
+	if (!skb)
+		return NULL;
+
+	__skb_put(skb, len);
+
+	return skb;
+}
+
+static int
+mt76s_process_rx_entry(struct mt76_dev *dev, struct mt76_queue_entry *e,
+		       int buf_size)
+{
+	struct sk_buff *skb;
+
+	if (!test_bit(MT76_STATE_INITIALIZED, &dev->phy.state))
+		return 0;
+
+	skb = mt76s_build_rx_skb(dev, e->buf, e->buf_sz, buf_size);
+	if (!skb)
+		return 0;
+
+	dev->drv->rx_skb(dev, MT_RXQ_MAIN, skb);
+
+	return 1;
+}
+
+static void
+mt76s_process_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
+{
+	int qid = q - &dev->q_rx[MT_RXQ_MAIN];
+
+	while (true) {
+		struct mt76_queue_entry *e;
+		int count;
+
+		e = mt76s_get_next_rx_entry(q);
+		if (!e)
+			break;
+
+		count = mt76s_process_rx_entry(dev, e, q->buf_size);
+		if (count > 0) {
+			e->buf = page_frag_alloc(&q->rx_page, q->buf_size,
+						 GFP_ATOMIC);
+			if (!e->buf)
+				break;
+		}
+	}
+	if (qid == MT_RXQ_MAIN)
+		mt76_rx_poll_complete(dev, MT_RXQ_MAIN, NULL);
+}
+
+static void mt76s_rx_tasklet(unsigned long data)
+{
+	struct mt76_dev *dev = (struct mt76_dev *)data;
+	int i;
+
+	rcu_read_lock();
+	mt76_for_each_q_rx(dev, i)
+		mt76s_process_rx_queue(dev, &dev->q_rx[i]);
+	rcu_read_unlock();
+}
+
+static int mt76s_rx_run_queue(struct mt76_dev *dev, struct mt76_queue *q)
+{
+	int i;
+
+	sdio_claim_host(dev->sdio.func);
+
+	for (i = 0; i < MT76_SDIO_RX_QUOTA; i++) {
+		struct mt76_queue_entry *e = &q->entry[q->tail];
+		struct mt76_sdio *sdio = &dev->sdio;
+		int len, err;
+		u32 val;
+
+		val = sdio_readl(sdio->func, MCR_WRPLR, &err);
+		if (err < 0) {
+			dev_err(dev->dev, "sdio read len failed:%d\n", err);
+			i = err;
+			break;
+		}
+
+		len = FIELD_GET(RX0_PACKET_LENGTH, val);
+		if (!len)
+			break;
+
+		/* Assume that an entry can hold a complete packet from SDIO
+		 * port.
+		 */
+		e->buf_sz = len;
+
+		len = roundup(len + 4, 4);
+		if (len > sdio->func->cur_blksize)
+			len = roundup(len, sdio->func->cur_blksize);
+
+		if (WARN_ON_ONCE(len > q->buf_size)) {
+			len = rounddown(q->buf_size, sdio->func->cur_blksize);
+			e->buf_sz = len;
+		}
+
+		err = sdio_readsb(sdio->func, e->buf, MCR_WRDR(0), len);
+		if (err < 0) {
+			dev_err(dev->dev, "sdio read data failed:%d\n", err);
+			i = err;
+			break;
+		}
+
+		spin_lock_bh(&q->lock);
+		q->tail = (q->tail + 1) % q->ndesc;
+		q->queued++;
+		spin_unlock_bh(&q->lock);
+	}
+
+	sdio_release_host(dev->sdio.func);
+
+	return i;
+}
+
+static void mt76s_tx_tasklet(unsigned long data)
+{
+	struct mt76_dev *dev = (struct mt76_dev *)data;
+	int i;
+
+	for (i = 0; i < MT_TXQ_MCU_WA; i++) {
+		struct mt76_sw_queue *sq = &dev->q_tx[i];
+		u32 n_dequeued = 0, n_sw_dequeued = 0;
+		bool wake, mcu = i == MT_TXQ_MCU;
+		struct mt76_queue_entry entry;
+		struct mt76_queue *q = sq->q;
+
+		while (q->queued > n_dequeued) {
+			if (q->entry[q->head].schedule) {
+				q->entry[q->head].schedule = false;
+				n_sw_dequeued++;
+			}
+
+			entry = q->entry[q->head];
+			q->entry[q->head].done = false;
+			q->head = (q->head + 1) % q->ndesc;
+			n_dequeued++;
+
+			if (mcu)
+				dev_kfree_skb(entry.skb);
+			else
+				dev->drv->tx_complete_skb(dev, i, &entry);
+		}
+
+		spin_lock_bh(&q->lock);
+
+		sq->swq_queued -= n_sw_dequeued;
+		q->queued -= n_dequeued;
+
+		wake = q->stopped && q->queued < q->ndesc - 8;
+		if (wake)
+			q->stopped = false;
+
+		if (!q->queued)
+			wake_up(&dev->tx_wait);
+
+		spin_unlock_bh(&q->lock);
+
+		if (mcu)
+			continue;
+
+		mt76_txq_schedule(&dev->phy, i);
+
+		if (dev->drv->tx_status_data &&
+		    !test_and_set_bit(MT76_READING_STATS, &dev->phy.state))
+			queue_work(dev->wq, &dev->sdio.stat_work);
+		if (wake)
+			ieee80211_wake_queue(dev->hw, i);
+	}
+	wake_up_process(dev->sdio.kthread);
+}
+
+static void mt76s_tx_status_data(struct work_struct *work)
+{
+	struct mt76_sdio *sdio;
+	struct mt76_dev *dev;
+	u8 update = 1;
+	u16 count = 0;
+
+	sdio = container_of(work, struct mt76_sdio, stat_work);
+	dev = container_of(sdio, struct mt76_dev, sdio);
+
+	while (true) {
+		if (test_bit(MT76_REMOVED, &dev->phy.state))
+			break;
+
+		if (!dev->drv->tx_status_data(dev, &update))
+			break;
+		count++;
+	}
+
+	if (count && test_bit(MT76_STATE_RUNNING, &dev->phy.state))
+		queue_work(dev->wq, &sdio->stat_work);
+	else
+		clear_bit(MT76_READING_STATS, &dev->phy.state);
+}
+
+static int mt76s_tx_add_buff(struct mt76_sdio *sdio, struct sk_buff *skb)
+{
+	int err, len = skb->len;
+
+	if (len > sdio->func->cur_blksize)
+		len = roundup(len, sdio->func->cur_blksize);
+
+	sdio_claim_host(sdio->func);
+
+	/* TODO: skb_walk_frags and then write to SDIO port */
+	err = sdio_writesb(sdio->func, MCR_WTDR1, skb->data, len);
+
+	sdio_release_host(sdio->func);
+
+	return err;
+}
+
+static int
+mt76s_tx_update_sched(struct mt76_dev *dev,
+		      struct mt76_queue_entry *e, bool mcu)
+{
+	struct mt76_sdio *sdio = &dev->sdio;
+	struct ieee80211_hdr *hdr;
+	int size, ret = -EBUSY;
+
+	size = DIV_ROUND_UP(e->buf_sz + sdio->sched.deficit, MT_PSE_PAGE_SZ);
+
+	if (mcu) {
+		if (!test_bit(MT76_STATE_MCU_RUNNING, &dev->phy.state))
+			return 0;
+
+		mutex_lock(&sdio->sched.lock);
+		if (sdio->sched.pse_mcu_quota > size) {
+			sdio->sched.pse_mcu_quota -= size;
+			ret = 0;
+		}
+		mutex_unlock(&sdio->sched.lock);
+
+		return ret;
+	}
+
+	hdr = (struct ieee80211_hdr *)(e->skb->data + dev->drv->txwi_size);
+	if (ieee80211_is_ctl(hdr->frame_control))
+		return 0;
+
+	mutex_lock(&sdio->sched.lock);
+	if (sdio->sched.pse_data_quota > size &&
+	    sdio->sched.ple_data_quota > 0) {
+		sdio->sched.pse_data_quota -= size;
+		sdio->sched.ple_data_quota--;
+		ret = 0;
+	}
+	mutex_unlock(&sdio->sched.lock);
+
+	return ret;
+}
+
+static int mt76s_tx_run_queue(struct mt76_dev *dev, struct mt76_queue *q)
+{
+	bool mcu = q == dev->q_tx[MT_TXQ_MCU].q;
+	int nframes = 0;
+
+	while (q->first != q->tail) {
+		struct mt76_queue_entry *e = &q->entry[q->first];
+		int err;
+
+		if (mt76s_tx_update_sched(dev, e, mcu))
+			break;
+
+		err = mt76s_tx_add_buff(&dev->sdio, e->skb);
+		if (err) {
+			dev_err(dev->dev, "sdio write failed: %d\n", err);
+			return -EIO;
+		}
+
+		q->first = (q->first + 1) % q->ndesc;
+		nframes++;
+	}
+
+	spin_lock_bh(&q->lock);
+	q->queued += nframes;
+	spin_unlock_bh(&q->lock);
+
+	return nframes;
+}
+
+static void mt76s_refill_sched_quota(struct mt76_dev *dev)
+{
+	struct mt76_sdio *sdio = &dev->sdio;
+	u32 data[8];
+	int i;
+
+	sdio_claim_host(sdio->func);
+	for (i = 0 ; i < ARRAY_SIZE(data); i++)
+		data[i] = sdio_readl(sdio->func, MCR_WTQCR(i), 0);
+	sdio_release_host(sdio->func);
+
+	mutex_lock(&sdio->sched.lock);
+	sdio->sched.pse_data_quota += FIELD_GET(TXQ_CNT_L, data[0]) + /* BK */
+				      FIELD_GET(TXQ_CNT_H, data[0]) + /* BE */
+				      FIELD_GET(TXQ_CNT_L, data[1]) + /* VI */
+				      FIELD_GET(TXQ_CNT_H, data[1]);  /* VO */
+	sdio->sched.ple_data_quota += FIELD_GET(TXQ_CNT_H, data[2]) + /* BK */
+				      FIELD_GET(TXQ_CNT_L, data[3]) + /* BE */
+				      FIELD_GET(TXQ_CNT_H, data[3]) + /* VI */
+				      FIELD_GET(TXQ_CNT_L, data[4]);  /* VO */
+	sdio->sched.pse_mcu_quota += FIELD_GET(TXQ_CNT_L, data[2]);
+	mutex_unlock(&sdio->sched.lock);
+}
+
+static int mt76s_kthread_run(void *data)
+{
+	struct mt76_dev *dev = data;
+	struct mt76_phy *mphy = &dev->phy;
+
+	while (!kthread_should_stop()) {
+		int i, ret, nframes = 0;
+
+		cond_resched();
+
+		mt76_for_each_q_rx(dev, i) {
+			ret = mt76s_rx_run_queue(dev, &dev->q_rx[i]);
+			if (ret < 0) {
+				nframes = 0;
+				goto out;
+			}
+			if (ret)
+				tasklet_schedule(&dev->sdio.rx_tasklet);
+			nframes += ret;
+		}
+
+		mt76s_refill_sched_quota(dev);
+		for (i = 0; i < MT_TXQ_MCU_WA; i++) {
+			ret = mt76s_tx_run_queue(dev, dev->q_tx[i].q);
+			if (ret < 0) {
+				nframes = 0;
+				break;
+			}
+			nframes += ret;
+		}
+
+out:
+		if (!nframes || !test_bit(MT76_STATE_RUNNING, &mphy->state)) {
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule();
+		}
+	}
+
+	return 0;
+}
+
+static int
+mt76s_tx_queue_skb(struct mt76_dev *dev, enum mt76_txq_id qid,
+		   struct sk_buff *skb, struct mt76_wcid *wcid,
+		   struct ieee80211_sta *sta)
+{
+	struct mt76_queue *q = dev->q_tx[qid].q;
+	struct mt76_tx_info tx_info = {
+		.skb = skb,
+	};
+	int err, len = skb->len;
+	u16 idx = q->tail;
+
+	if (q->queued == q->ndesc)
+		return -ENOSPC;
+
+	skb->prev = skb->next = NULL;
+	err = dev->drv->tx_prepare_skb(dev, NULL, qid, wcid, sta, &tx_info);
+	if (err < 0)
+		return err;
+
+	q->entry[q->tail].skb = tx_info.skb;
+	q->entry[q->tail].buf_sz = len;
+	q->tail = (q->tail + 1) % q->ndesc;
+
+	return idx;
+}
+
+static int
+mt76s_tx_queue_skb_raw(struct mt76_dev *dev, enum mt76_txq_id qid,
+		       struct sk_buff *skb, u32 tx_info)
+{
+	struct mt76_queue *q = dev->q_tx[qid].q;
+	int ret = -ENOSPC, len = skb->len;
+
+	spin_lock_bh(&q->lock);
+	if (q->queued == q->ndesc)
+		goto out;
+
+	ret = mt76_skb_adjust_pad(skb);
+	if (ret)
+		goto out;
+
+	q->entry[q->tail].skb = skb;
+	q->entry[q->tail].buf_sz = len;
+	q->tail = (q->tail + 1) % q->ndesc;
+
+out:
+	spin_unlock_bh(&q->lock);
+
+	return ret;
+}
+
+static void mt76s_tx_kick(struct mt76_dev *dev, struct mt76_queue *q)
+{
+	struct mt76_sdio *sdio = &dev->sdio;
+
+	wake_up_process(sdio->kthread);
+}
+
+static void mt76s_sdio_irq(struct sdio_func *func)
+{
+	struct mt76_dev *dev = sdio_get_drvdata(func);
+	struct mt76_sdio *sdio = &dev->sdio;
+	u32 intr;
+
+	/* disable interrupt */
+	sdio_writel(func, WHLPCR_INT_EN_CLR, MCR_WHLPCR, 0);
+
+	intr = sdio_readl(func, MCR_WHISR, 0);
+	trace_dev_irq(dev, intr, 0);
+
+	if (!test_bit(MT76_STATE_INITIALIZED, &dev->phy.state))
+		goto out;
+
+	if (intr & (WHIER_RX0_DONE_INT_EN | WHIER_RX1_DONE_INT_EN |
+		    WHIER_TX_DONE_INT_EN))
+		wake_up_process(sdio->kthread);
+
+	if (intr & WHIER_TX_DONE_INT_EN)
+		tasklet_schedule(&dev->tx_tasklet);
+out:
+	/* enable interrupt */
+	sdio_writel(func, WHLPCR_INT_EN_SET, MCR_WHLPCR, 0);
+}
+
+static int mt76s_hw_init(struct mt76_dev *dev, struct sdio_func *func)
+{
+	u32 status, ctrl;
+	int ret;
+
+	sdio_claim_host(func);
+
+	ret = sdio_enable_func(func);
+	if (ret < 0)
+		goto release;
+
+	/* Get ownership from the device */
+	sdio_writel(func, WHLPCR_INT_EN_CLR | WHLPCR_FW_OWN_REQ_CLR,
+		    MCR_WHLPCR, &ret);
+	if (ret < 0)
+		goto disable_func;
+
+	ret = readx_poll_timeout(mt76s_read_pcr, dev, status,
+				 status & WHLPCR_IS_DRIVER_OWN, 2000, 1000000);
+	if (ret < 0) {
+		dev_err(dev->dev, "Cannot get ownership from device");
+		goto disable_func;
+	}
+
+	ret = sdio_set_block_size(func, 512);
+	if (ret < 0)
+		goto disable_func;
+
+	/* Enable interrupt */
+	sdio_writel(func, WHLPCR_INT_EN_SET, MCR_WHLPCR, &ret);
+	if (ret < 0)
+		goto disable_func;
+
+	ctrl = WHIER_RX0_DONE_INT_EN | WHIER_TX_DONE_INT_EN;
+	sdio_writel(func, ctrl, MCR_WHIER, &ret);
+	if (ret < 0)
+		goto disable_func;
+
+	/* set WHISR as read clear and Rx aggregation number as 1 */
+	ctrl = FIELD_PREP(MAX_HIF_RX_LEN_NUM, 1);
+	sdio_writel(func, ctrl, MCR_WHCR, &ret);
+	if (ret < 0)
+		goto disable_func;
+
+	ret = sdio_claim_irq(func, mt76s_sdio_irq);
+	if (ret < 0)
+		goto disable_func;
+
+	sdio_release_host(func);
+
+	return 0;
+
+disable_func:
+	sdio_disable_func(func);
+release:
+	sdio_release_host(func);
+
+	return ret;
+}
+
+static const struct mt76_queue_ops sdio_queue_ops = {
+	.tx_queue_skb = mt76s_tx_queue_skb,
+	.kick = mt76s_tx_kick,
+	.tx_queue_skb_raw = mt76s_tx_queue_skb_raw,
+};
+
+void mt76s_deinit(struct mt76_dev *dev)
+{
+	struct mt76_sdio *sdio = &dev->sdio;
+	int i;
+
+	kthread_stop(sdio->kthread);
+	mt76s_stop_txrx(dev);
+
+	mt76_for_each_q_rx(dev, i)
+		mt76s_free_rx_queue(dev, &dev->q_rx[i]);
+
+	sdio_claim_host(sdio->func);
+	sdio_release_irq(sdio->func);
+	sdio_release_host(sdio->func);
+}
+EXPORT_SYMBOL_GPL(mt76s_deinit);
+
+int mt76s_init(struct mt76_dev *dev, struct sdio_func *func)
+{
+	static const struct mt76_bus_ops mt76s_ops = {
+		.rr = mt76s_rr,
+		.rmw = mt76s_rmw,
+		.wr = mt76s_wr,
+		.write_copy = mt76s_write_copy,
+		.read_copy = mt76s_read_copy,
+		.wr_rp = mt76s_wr_rp,
+		.rd_rp = mt76s_rd_rp,
+		.type = MT76_BUS_SDIO,
+	};
+	struct mt76_sdio *sdio = &dev->sdio;
+
+	sdio->kthread = kthread_create(mt76s_kthread_run, dev, "mt76s");
+	if (IS_ERR(sdio->kthread))
+		return PTR_ERR(sdio->kthread);
+
+	tasklet_init(&sdio->rx_tasklet, mt76s_rx_tasklet, (unsigned long)dev);
+	tasklet_init(&dev->tx_tasklet, mt76s_tx_tasklet, (unsigned long)dev);
+
+	INIT_WORK(&sdio->stat_work, mt76s_tx_status_data);
+
+	mutex_init(&sdio->sched.lock);
+	dev->queue_ops = &sdio_queue_ops;
+	dev->bus = &mt76s_ops;
+	dev->sdio.func = func;
+
+	return mt76s_hw_init(dev, func);
+}
+EXPORT_SYMBOL_GPL(mt76s_init);
+
+MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
+MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.h b/drivers/net/wireless/mediatek/mt76/sdio.h
new file mode 100644
index 000000000000..cd7c773ccd59
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/sdio.h
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc.
+ *
+ * Author: Sean Wang <sean.wang@mediatek.com>
+ */
+
+#ifndef __MT76S_H
+#define __MT76S_H
+
+#define MT_PSE_PAGE_SZ			128
+
+#define MCR_WCIR			0x0000
+#define MCR_WHLPCR			0x0004
+#define WHLPCR_FW_OWN_REQ_CLR		BIT(9)
+#define WHLPCR_FW_OWN_REQ_SET		BIT(8)
+#define WHLPCR_IS_DRIVER_OWN		BIT(8)
+#define WHLPCR_INT_EN_CLR		BIT(1)
+#define WHLPCR_INT_EN_SET		BIT(0)
+
+#define MCR_WSDIOCSR			0x0008
+#define MCR_WHCR			0x000C
+#define W_INT_CLR_CTRL			BIT(1)
+#define RECV_MAILBOX_RD_CLR_EN		BIT(2)
+#define MAX_HIF_RX_LEN_NUM		GENMASK(13, 8)
+#define RX_ENHANCE_MODE			BIT(16)
+
+#define MCR_WHISR			0x0010
+#define MCR_WHIER			0x0014
+#define WHIER_D2H_SW_INT		GENMASK(31, 8)
+#define WHIER_FW_OWN_BACK_INT_EN	BIT(7)
+#define WHIER_ABNORMAL_INT_EN		BIT(6)
+#define WHIER_RX1_DONE_INT_EN		BIT(2)
+#define WHIER_RX0_DONE_INT_EN		BIT(1)
+#define WHIER_TX_DONE_INT_EN		BIT(0)
+#define WHIER_DEFAULT			(WHIER_RX0_DONE_INT_EN	| \
+					 WHIER_RX1_DONE_INT_EN	| \
+					 WHIER_TX_DONE_INT_EN	| \
+					 WHIER_ABNORMAL_INT_EN	| \
+					 WHIER_D2H_SW_INT)
+
+#define MCR_WASR			0x0020
+#define MCR_WSICR			0x0024
+#define MCR_WTSR0			0x0028
+#define TQ0_CNT				GENMASK(7, 0)
+#define TQ1_CNT				GENMASK(15, 8)
+#define TQ2_CNT				GENMASK(23, 16)
+#define TQ3_CNT				GENMASK(31, 24)
+
+#define MCR_WTSR1			0x002c
+#define TQ4_CNT				GENMASK(7, 0)
+#define TQ5_CNT				GENMASK(15, 8)
+#define TQ6_CNT				GENMASK(23, 16)
+#define TQ7_CNT				GENMASK(31, 24)
+
+#define MCR_WTDR1			0x0034
+#define MCR_WRDR0			0x0050
+#define MCR_WRDR1			0x0054
+#define MCR_WRDR(p)			(0x0050 + 4 * (p))
+#define MCR_H2DSM0R			0x0070
+#define H2D_SW_INT_READ			BIT(16)
+#define H2D_SW_INT_WRITE		BIT(17)
+
+#define MCR_H2DSM1R			0x0074
+#define MCR_D2HRM0R			0x0078
+#define MCR_D2HRM1R			0x007c
+#define MCR_D2HRM2R			0x0080
+#define MCR_WRPLR			0x0090
+#define RX0_PACKET_LENGTH		GENMASK(15, 0)
+#define RX1_PACKET_LENGTH		GENMASK(31, 16)
+
+#define MCR_WTMDR			0x00b0
+#define MCR_WTMCR			0x00b4
+#define MCR_WTMDPCR0			0x00b8
+#define MCR_WTMDPCR1			0x00bc
+#define MCR_WPLRCR			0x00d4
+#define MCR_WSR				0x00D8
+#define MCR_CLKIOCR			0x0100
+#define MCR_CMDIOCR			0x0104
+#define MCR_DAT0IOCR			0x0108
+#define MCR_DAT1IOCR			0x010C
+#define MCR_DAT2IOCR			0x0110
+#define MCR_DAT3IOCR			0x0114
+#define MCR_CLKDLYCR			0x0118
+#define MCR_CMDDLYCR			0x011C
+#define MCR_ODATDLYCR			0x0120
+#define MCR_IDATDLYCR1			0x0124
+#define MCR_IDATDLYCR2			0x0128
+#define MCR_ILCHCR			0x012C
+#define MCR_WTQCR0			0x0130
+#define MCR_WTQCR1			0x0134
+#define MCR_WTQCR2			0x0138
+#define MCR_WTQCR3			0x013C
+#define MCR_WTQCR4			0x0140
+#define MCR_WTQCR5			0x0144
+#define MCR_WTQCR6			0x0148
+#define MCR_WTQCR7			0x014C
+#define MCR_WTQCR(x)                   (0x130 + 4 * (x))
+#define TXQ_CNT_L			GENMASK(15, 0)
+#define TXQ_CNT_H			GENMASK(31, 16)
+
+#define MCR_SWPCDBGR			0x0154
+
+struct mt76s_intr {
+	u32 whisr;
+	u32 wtqcr[8];
+	u16 pkt_num[2];
+	u16 pkt_len[2][16];
+	u32 rec_mb[2];
+} __packed;
+
+#endif
-- 
2.26.2

