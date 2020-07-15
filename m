Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B33B220D48
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 14:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbgGOMq6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jul 2020 08:46:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728861AbgGOMq6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jul 2020 08:46:58 -0400
Received: from localhost.localdomain.com (unknown [151.48.133.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACB5B206D5;
        Wed, 15 Jul 2020 12:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594817217;
        bh=nuVu5KiZ7l/VWyRnNlVxJNoYpU7Z23rwt4vp1KKnGvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=izjvo47ZCTKkqYBj1FVx1rInIMcHo5zC2DhU/yFvp93drFKn16wmqBfJBm8PXBZI8
         MHxJ5bdjvUJH+XgnjPYZlqkgcTKe95h/uQI9+NUOZjKDSG6omykMc+swbpa4nX0qud
         qOGSYC9zP9nbUKt8ATI4dcIU2/ZVAosak7QV9FtM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 5/6] mt76: introduce mt76_sdio module
Date:   Wed, 15 Jul 2020 14:46:30 +0200
Message-Id: <ae5146b640aab1d7c2af3a5c9de58c054b6e4d7c.1594815602.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1594815602.git.lorenzo@kernel.org>
References: <cover.1594815602.git.lorenzo@kernel.org>
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
 drivers/net/wireless/mediatek/mt76/mt76.h     |  30 ++
 .../wireless/mediatek/mt76/mt7615/usb_sdio.c  |   5 +-
 drivers/net/wireless/mediatek/mt76/sdio.c     | 363 ++++++++++++++++++
 6 files changed, 408 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/sdio.c

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
index e6a402c0f5eb..4482eeb91a64 100644
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
+		int buf_sz;
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
@@ -441,6 +446,24 @@ struct mt76_usb {
 	} mcu;
 };
 
+struct mt76_sdio {
+	struct task_struct *tx_kthread;
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
@@ -628,6 +651,7 @@ struct mt76_dev {
 	union {
 		struct mt76_mmio mmio;
 		struct mt76_usb usb;
+		struct mt76_sdio sdio;
 	};
 };
 
@@ -1039,6 +1063,12 @@ void mt76u_stop_rx(struct mt76_dev *dev);
 int mt76u_resume_rx(struct mt76_dev *dev);
 void mt76u_queues_deinit(struct mt76_dev *dev);
 
+int mt76s_init(struct mt76_dev *dev, struct sdio_func *func,
+	       const struct mt76_bus_ops *bus_ops);
+int mt76s_alloc_queues(struct mt76_dev *dev);
+void mt76s_stop_txrx(struct mt76_dev *dev);
+void mt76s_deinit(struct mt76_dev *dev);
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
index 000000000000..a6f3255c4d84
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -0,0 +1,363 @@
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
+
+static int
+mt76s_alloc_rx_queue(struct mt76_dev *dev, enum mt76_rxq_id qid)
+{
+	struct mt76_queue *q = &dev->q_rx[qid];
+
+	spin_lock_init(&q->lock);
+	q->entry = devm_kcalloc(dev->dev,
+				MT_NUM_RX_ENTRIES, sizeof(*q->entry),
+				GFP_KERNEL);
+	if (!q->entry)
+		return -ENOMEM;
+
+	q->ndesc = MT_NUM_RX_ENTRIES;
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
+	int err;
+
+	err = mt76s_alloc_rx_queue(dev, MT_RXQ_MAIN);
+	if (err < 0)
+		return err;
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
+static int
+mt76s_process_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
+{
+	int qid = q - &dev->q_rx[MT_RXQ_MAIN];
+	int nframes = 0;
+
+	while (true) {
+		struct mt76_queue_entry *e;
+
+		if (!test_bit(MT76_STATE_INITIALIZED, &dev->phy.state))
+			break;
+
+		e = mt76s_get_next_rx_entry(q);
+		if (!e || !e->skb)
+			break;
+
+		dev->drv->rx_skb(dev, MT_RXQ_MAIN, e->skb);
+		e->skb = NULL;
+		nframes++;
+	}
+	if (qid == MT_RXQ_MAIN)
+		mt76_rx_poll_complete(dev, MT_RXQ_MAIN, NULL);
+
+	return nframes;
+}
+
+static int mt76s_process_tx_queue(struct mt76_dev *dev, enum mt76_txq_id qid)
+{
+	struct mt76_sw_queue *sq = &dev->q_tx[qid];
+	u32 n_dequeued = 0, n_sw_dequeued = 0;
+	struct mt76_queue_entry entry;
+	struct mt76_queue *q = sq->q;
+	bool wake;
+
+	while (q->queued > n_dequeued) {
+		if (q->entry[q->head].schedule) {
+			q->entry[q->head].schedule = false;
+			n_sw_dequeued++;
+		}
+
+		entry = q->entry[q->head];
+		q->entry[q->head].done = false;
+		q->head = (q->head + 1) % q->ndesc;
+		n_dequeued++;
+
+		if (qid == MT_TXQ_MCU)
+			dev_kfree_skb(entry.skb);
+		else
+			dev->drv->tx_complete_skb(dev, qid, &entry);
+	}
+
+	spin_lock_bh(&q->lock);
+
+	sq->swq_queued -= n_sw_dequeued;
+	q->queued -= n_dequeued;
+
+	wake = q->stopped && q->queued < q->ndesc - 8;
+	if (wake)
+		q->stopped = false;
+
+	if (!q->queued)
+		wake_up(&dev->tx_wait);
+
+	spin_unlock_bh(&q->lock);
+
+	if (qid == MT_TXQ_MCU)
+		goto out;
+
+	mt76_txq_schedule(&dev->phy, qid);
+
+	if (wake)
+		ieee80211_wake_queue(dev->hw, qid);
+
+	wake_up_process(dev->sdio.tx_kthread);
+out:
+	return n_dequeued;
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
+	q->entry[q->tail].buf_sz = len;
+	q->entry[q->tail].skb = skb;
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
+	wake_up_process(sdio->tx_kthread);
+}
+
+static const struct mt76_queue_ops sdio_queue_ops = {
+	.tx_queue_skb = mt76s_tx_queue_skb,
+	.kick = mt76s_tx_kick,
+	.tx_queue_skb_raw = mt76s_tx_queue_skb_raw,
+};
+
+static int mt76s_kthread_run(void *data)
+{
+	struct mt76_dev *dev = data;
+	struct mt76_phy *mphy = &dev->phy;
+
+	while (!kthread_should_stop()) {
+		int i, nframes = 0;
+
+		cond_resched();
+
+		/* rx processing */
+		local_bh_disable();
+		rcu_read_lock();
+
+		mt76_for_each_q_rx(dev, i)
+			nframes += mt76s_process_rx_queue(dev, &dev->q_rx[i]);
+
+		rcu_read_unlock();
+		local_bh_enable();
+
+		/* tx processing */
+		for (i = 0; i < MT_TXQ_MCU_WA; i++)
+			nframes += mt76s_process_tx_queue(dev, i);
+
+		if (dev->drv->tx_status_data &&
+		    !test_and_set_bit(MT76_READING_STATS, &mphy->state))
+			queue_work(dev->wq, &dev->sdio.stat_work);
+
+		if (!nframes || !test_bit(MT76_STATE_RUNNING, &mphy->state)) {
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule();
+		}
+	}
+
+	return 0;
+}
+
+void mt76s_deinit(struct mt76_dev *dev)
+{
+	struct mt76_sdio *sdio = &dev->sdio;
+	int i;
+
+	kthread_stop(sdio->kthread);
+	kthread_stop(sdio->tx_kthread);
+	mt76s_stop_txrx(dev);
+
+	sdio_claim_host(sdio->func);
+	sdio_release_irq(sdio->func);
+	sdio_release_host(sdio->func);
+
+	mt76_for_each_q_rx(dev, i) {
+		struct mt76_queue *q = &dev->q_rx[i];
+		int j;
+
+		for (j = 0; j < q->ndesc; j++) {
+			struct mt76_queue_entry *e = &q->entry[j];
+
+			if (!e->skb)
+				continue;
+
+			dev_kfree_skb(e->skb);
+			e->skb = NULL;
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(mt76s_deinit);
+
+int mt76s_init(struct mt76_dev *dev, struct sdio_func *func,
+	       const struct mt76_bus_ops *bus_ops)
+{
+	struct mt76_sdio *sdio = &dev->sdio;
+
+	sdio->kthread = kthread_create(mt76s_kthread_run, dev, "mt76s");
+	if (IS_ERR(sdio->kthread))
+		return PTR_ERR(sdio->kthread);
+
+	INIT_WORK(&sdio->stat_work, mt76s_tx_status_data);
+
+	mutex_init(&sdio->sched.lock);
+	dev->queue_ops = &sdio_queue_ops;
+	dev->bus = bus_ops;
+	dev->sdio.func = func;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76s_init);
+
+MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
+MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.26.2

