Return-Path: <linux-wireless+bounces-19444-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B698BA4518F
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 01:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55344179270
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 00:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B3C148FE6;
	Wed, 26 Feb 2025 00:36:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5017B219FF;
	Wed, 26 Feb 2025 00:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740530196; cv=none; b=XlqitUgfRF3XQO1EN2ZsfqhYq+d0a74klvvHDYQxXSAxF62K6tLE6/vxhyTDhW/YMlJy0huOBjj0K4/qzC4AGRlLn+GY6BtuLeQwjjvdq+9Qwfx42tCX6j4jEfb85WzfXXpM3RUXDXO7nzp+aIBzxtWRpwRlHEKW0naUFyFWEyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740530196; c=relaxed/simple;
	bh=xUSt8L0H6l/W9KluaR498B+64seyfZE0lk+Ze7ParbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dh2sCYy3NEqU1j5cXO8bXRuamobHyzMLNGGACJx7Ex5AkKxi+jnNN8CROuHh2Rf2DDN9E5b+qUBqzro46kQaEk2+dFteejcIQVh4juZ8Ce/EE5s+tVXX7Dj+u7XyggwygBmhQ6XePbAPM7FaQe7/GN3yVw1X7OL6ki6CvAnC7sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5fe9c1c14baso379982eaf.0;
        Tue, 25 Feb 2025 16:36:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740530174; x=1741134974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPnM2MnQkrrFLWiGvlH1hamHsYt7h9LB67Ily/omLDI=;
        b=daC/saonA0LkRwgvx4/93cx1hbnZJ71Ae2RetOokpwjFWgPS9+7EK6JLgBdf7P9v0B
         nes1cOm493b1q8G2rGOXxAf0QOzPyapm3TwKh2eQRENy/hl39MPQxXE206Lyq4tCMa5x
         X2OFilYQtBchjmjH4p+KhLrAZKUO6H7j1yQ5eh1rJrfIFCzwWj16cmhjQJbwJkXJwVGh
         uFQQRDNQw+Lgy46bJejwnlvumFI1OYfprWGWTZ5VHXXbtBv98Y0UazSoGAO9mm4s9JCu
         s4s/LFQK24H20ibYurt+dGQSiFHhYry55PDgLVUfE+0PxsMroejN8f3r6jQ4/RpBzaVt
         w5xg==
X-Forwarded-Encrypted: i=1; AJvYcCUJAi1dOweIK8p02sF3nB8FzaIBklsq8c9evKJkQ9N2HsUie+2gQci8S3oC8bbRQcpRDyDkRE+E@vger.kernel.org, AJvYcCX+D/8gjwl++P3fwpgqUfvXHq19NzeIwW5J8JFHg+rEWBFeSko5itF0jtRrTLnYp7fPXIM/930h8Zkmd6P2Lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNg3cNH0z8R9DEusCCHdL8ap3LiHnl4SNbDdmiPZsRYm6vf/V5
	TMEDhKDPRGFDHQdKSlWG7Ly9Jvusk9gQyKe1RfeqoqYXmTxOf63Q
X-Gm-Gg: ASbGncu85hlN9ytuygVzfUnSbBun88np7g1yp0affRzYn5wT9MRlxEH/RZkl3MsgTjk
	jM6dfbUQhp4cldy4IcDt0cT7ADWjPzGRpnDoCB7avVn5e3idHC75pt7gVfUEZqj5XxiYYHN2cOv
	e5jBDi/YaStHrOqSDOwwMjjyo70r0XY+ndhQmPavBNSSHvoT1/U2JJU69uZsTBheU8eRQ6l/Db9
	SpcxZdoaEkhSfXW2WYyhO6waoysKr3DPjo0RwcsKnntlmTBZYgV7rIjeWfry3qSFIMHhKHhuVAZ
	LOIn+KZKmlfNooWpzZHIJ4K4f8o1K75BawZ95kWHOWM=
X-Google-Smtp-Source: AGHT+IHNDd+dSwWQHs+dbswXKgmYa5ZBVF25sMvUiGM27QewFMBJAoyaJ/uKvLieFxhY8HcpGuOoJg==
X-Received: by 2002:a05:6870:ac25:b0:2b8:308d:fa75 with SMTP id 586e51a60fabf-2c13071ce53mr991759fac.31.1740530173186;
        Tue, 25 Feb 2025 16:36:13 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7289dedfcd8sm507149a34.16.2025.02.25.16.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 16:36:11 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH v3 2/6] wifi: mt76: mt7925: fix the wrong link_idx when has p2p_device
Date: Tue, 25 Feb 2025 16:35:52 -0800
Message-Id: <20250226003556.82644-2-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226003556.82644-1-sean.wang@kernel.org>
References: <20250226003556.82644-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

When the p2p device and MLO station concurrent, the p2p device
will occupy the wrong link_idx when the MLO secondary link is added.

Fixes: e38a82d25b08 ("wifi: mt76: connac: Extend mt76_connac_mcu_uni_add_dev for MLO")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2, v3: generate the patch based on the latest mt76 tree
---
 .../net/wireless/mediatek/mt76/Makefile.orig  |   42 +
 drivers/net/wireless/mediatek/mt76/dma.c.orig |  994 +++++
 .../wireless/mediatek/mt76/mac80211.c.orig    | 1793 +++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     |    1 +
 .../net/wireless/mediatek/mt76/mt76.h.orig    | 1876 +++++++++
 .../mediatek/mt76/mt76_connac_mac.c.orig      | 1196 ++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |    4 +-
 .../mediatek/mt76/mt76_connac_mcu.c.orig      | 3200 +++++++++++++++
 .../wireless/mediatek/mt76/mt7921/dma.c.orig  |  314 ++
 .../wireless/mediatek/mt76/mt7921/init.c.orig |  326 ++
 .../wireless/mediatek/mt76/mt7921/mac.c.orig  | 1121 ++++++
 .../wireless/mediatek/mt76/mt7921/main.c.orig | 1838 +++++++++
 .../wireless/mediatek/mt76/mt7921/mcu.c.orig  | 1357 +++++++
 .../mediatek/mt76/mt7921/mt7921.h.orig        |  561 +++
 .../wireless/mediatek/mt76/mt7921/pci.c.orig  |  497 +++
 .../mediatek/mt76/mt7921/pci_mac.c.orig       |  348 ++
 .../wireless/mediatek/mt76/mt7921/sdio.c.orig |  322 ++
 .../mediatek/mt76/mt7921/sdio_mac.c.orig      |  142 +
 .../net/wireless/mediatek/mt76/mt7925/main.c  |   14 +-
 .../wireless/mediatek/mt76/mt7925/main.c.orig | 2209 +++++++++++
 .../wireless/mediatek/mt76/mt7925/mcu.c.orig  | 3506 +++++++++++++++++
 .../wireless/mediatek/mt76/mt7925/mcu.c.rej   |   35 +
 22 files changed, 21690 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/Makefile.orig
 create mode 100644 drivers/net/wireless/mediatek/mt76/dma.c.orig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mac80211.c.orig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76.h.orig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c.orig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c.orig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/dma.c.orig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/init.c.orig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mac.c.orig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/main.c.orig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c.orig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h.orig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/pci.c.orig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c.orig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c.orig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c.orig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/main.c.orig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c.orig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c.rej

diff --git a/drivers/net/wireless/mediatek/mt76/Makefile.orig b/drivers/net/wireless/mediatek/mt76/Makefile.orig
new file mode 100644
index 000000000000..3cf605075d33
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/Makefile.orig
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_MT76_CORE) += mt76.o
+obj-$(CONFIG_MT76_USB) += mt76-usb.o
+obj-$(CONFIG_MT76_SDIO) += mt76-sdio.o
+obj-$(CONFIG_MT76x02_LIB) += mt76x02-lib.o
+obj-$(CONFIG_MT76x02_USB) += mt76x02-usb.o
+obj-$(CONFIG_MT76_CONNAC_LIB) += mt76-connac-lib.o
+
+mt76-y := \
+	mmio.o util.o trace.o dma.o mac80211.o debugfs.o eeprom.o \
+	tx.o agg-rx.o mcu.o
+
+mt76-$(CONFIG_PCI) += pci.o
+mt76-$(CONFIG_NL80211_TESTMODE) += testmode.o
+
+mt76-usb-y := usb.o usb_trace.o
+mt76-sdio-y := sdio.o sdio_txrx.o
+
+CFLAGS_trace.o := -I$(src)
+CFLAGS_usb_trace.o := -I$(src)
+CFLAGS_mt76x02_trace.o := -I$(src)
+
+mt76x02-lib-y := mt76x02_util.o mt76x02_mac.o mt76x02_mcu.o \
+		 mt76x02_eeprom.o mt76x02_phy.o mt76x02_mmio.o \
+		 mt76x02_txrx.o mt76x02_trace.o mt76x02_debugfs.o \
+		 mt76x02_dfs.o mt76x02_beacon.o
+
+mt76x02-usb-y := mt76x02_usb_mcu.o mt76x02_usb_core.o
+
+mt76-connac-lib-y := mt76_connac_mcu.o mt76_connac_mac.o
+
+obj-$(CONFIG_MT76x0_COMMON) += mt76x0/
+obj-$(CONFIG_MT76x2_COMMON) += mt76x2/
+obj-$(CONFIG_MT7603E) += mt7603/
+obj-$(CONFIG_MT7615_COMMON) += mt7615/
+obj-$(CONFIG_MT7915E) += mt7915/
+obj-$(CONFIG_MT7921_COMMON) += mt7921/
+<<<<<<< HEAD
+=======
+obj-$(CONFIG_MT7996E) += mt7996/
+obj-$(CONFIG_MT7925_COMMON) += mt7925/
+>>>>>>> dev: mt7925: build mt7925 pass
diff --git a/drivers/net/wireless/mediatek/mt76/dma.c.orig b/drivers/net/wireless/mediatek/mt76/dma.c.orig
new file mode 100644
index 000000000000..643e18ebb5ee
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/dma.c.orig
@@ -0,0 +1,994 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
+ */
+
+#include <linux/dma-mapping.h>
+#include "mt76.h"
+#include "dma.h"
+
+#if IS_ENABLED(CONFIG_NET_MEDIATEK_SOC_WED)
+
+#define Q_READ(_dev, _q, _field) ({					\
+	u32 _offset = offsetof(struct mt76_queue_regs, _field);		\
+	u32 _val;							\
+	if ((_q)->flags & MT_QFLAG_WED)					\
+		_val = mtk_wed_device_reg_read(&(_dev)->mmio.wed,	\
+					       ((_q)->wed_regs +	\
+					        _offset));		\
+	else								\
+		_val = readl(&(_q)->regs->_field);			\
+	_val;								\
+})
+
+#define Q_WRITE(_dev, _q, _field, _val)	do {				\
+	u32 _offset = offsetof(struct mt76_queue_regs, _field);		\
+	if ((_q)->flags & MT_QFLAG_WED)					\
+		mtk_wed_device_reg_write(&(_dev)->mmio.wed,		\
+					 ((_q)->wed_regs + _offset),	\
+					 _val);				\
+	else								\
+		writel(_val, &(_q)->regs->_field);			\
+} while (0)
+
+#else
+
+#define Q_READ(_dev, _q, _field)	readl(&(_q)->regs->_field)
+#define Q_WRITE(_dev, _q, _field, _val)	writel(_val, &(_q)->regs->_field)
+
+#endif
+
+static struct mt76_txwi_cache *
+mt76_alloc_txwi(struct mt76_dev *dev)
+{
+	struct mt76_txwi_cache *t;
+	dma_addr_t addr;
+	u8 *txwi;
+	int size;
+
+	size = L1_CACHE_ALIGN(dev->drv->txwi_size + sizeof(*t));
+	txwi = kzalloc(size, GFP_ATOMIC);
+	if (!txwi)
+		return NULL;
+
+	addr = dma_map_single(dev->dma_dev, txwi, dev->drv->txwi_size,
+			      DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(dev->dma_dev, addr))) {
+		kfree(txwi);
+		return NULL;
+	}
+
+	t = (struct mt76_txwi_cache *)(txwi + dev->drv->txwi_size);
+	t->dma_addr = addr;
+
+	return t;
+}
+
+static struct mt76_txwi_cache *
+mt76_alloc_rxwi(struct mt76_dev *dev)
+{
+	struct mt76_txwi_cache *t;
+
+	t = kzalloc(L1_CACHE_ALIGN(sizeof(*t)), GFP_ATOMIC);
+	if (!t)
+		return NULL;
+
+	t->ptr = NULL;
+	return t;
+}
+
+static struct mt76_txwi_cache *
+__mt76_get_txwi(struct mt76_dev *dev)
+{
+	struct mt76_txwi_cache *t = NULL;
+
+	spin_lock(&dev->lock);
+	if (!list_empty(&dev->txwi_cache)) {
+		t = list_first_entry(&dev->txwi_cache, struct mt76_txwi_cache,
+				     list);
+		list_del(&t->list);
+	}
+	spin_unlock(&dev->lock);
+
+	return t;
+}
+
+static struct mt76_txwi_cache *
+__mt76_get_rxwi(struct mt76_dev *dev)
+{
+	struct mt76_txwi_cache *t = NULL;
+
+	spin_lock(&dev->wed_lock);
+	if (!list_empty(&dev->rxwi_cache)) {
+		t = list_first_entry(&dev->rxwi_cache, struct mt76_txwi_cache,
+				     list);
+		list_del(&t->list);
+	}
+	spin_unlock(&dev->wed_lock);
+
+	return t;
+}
+
+static struct mt76_txwi_cache *
+mt76_get_txwi(struct mt76_dev *dev)
+{
+	struct mt76_txwi_cache *t = __mt76_get_txwi(dev);
+
+	if (t)
+		return t;
+
+	return mt76_alloc_txwi(dev);
+}
+
+struct mt76_txwi_cache *
+mt76_get_rxwi(struct mt76_dev *dev)
+{
+	struct mt76_txwi_cache *t = __mt76_get_rxwi(dev);
+
+	if (t)
+		return t;
+
+	return mt76_alloc_rxwi(dev);
+}
+EXPORT_SYMBOL_GPL(mt76_get_rxwi);
+
+void
+mt76_put_txwi(struct mt76_dev *dev, struct mt76_txwi_cache *t)
+{
+	if (!t)
+		return;
+
+	spin_lock(&dev->lock);
+	list_add(&t->list, &dev->txwi_cache);
+	spin_unlock(&dev->lock);
+}
+EXPORT_SYMBOL_GPL(mt76_put_txwi);
+
+void
+mt76_put_rxwi(struct mt76_dev *dev, struct mt76_txwi_cache *t)
+{
+	if (!t)
+		return;
+
+	spin_lock(&dev->wed_lock);
+	list_add(&t->list, &dev->rxwi_cache);
+	spin_unlock(&dev->wed_lock);
+}
+EXPORT_SYMBOL_GPL(mt76_put_rxwi);
+
+static void
+mt76_free_pending_txwi(struct mt76_dev *dev)
+{
+	struct mt76_txwi_cache *t;
+
+	local_bh_disable();
+	while ((t = __mt76_get_txwi(dev)) != NULL) {
+		dma_unmap_single(dev->dma_dev, t->dma_addr, dev->drv->txwi_size,
+				 DMA_TO_DEVICE);
+		kfree(mt76_get_txwi_ptr(dev, t));
+	}
+	local_bh_enable();
+}
+
+void
+mt76_free_pending_rxwi(struct mt76_dev *dev)
+{
+	struct mt76_txwi_cache *t;
+
+	local_bh_disable();
+	while ((t = __mt76_get_rxwi(dev)) != NULL) {
+		if (t->ptr)
+			mt76_put_page_pool_buf(t->ptr, false);
+		kfree(t);
+	}
+	local_bh_enable();
+}
+EXPORT_SYMBOL_GPL(mt76_free_pending_rxwi);
+
+static void
+mt76_dma_sync_idx(struct mt76_dev *dev, struct mt76_queue *q)
+{
+	Q_WRITE(dev, q, desc_base, q->desc_dma);
+	Q_WRITE(dev, q, ring_size, q->ndesc);
+	q->head = Q_READ(dev, q, dma_idx);
+	q->tail = q->head;
+}
+
+static void
+mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q)
+{
+	int i;
+
+	if (!q || !q->ndesc)
+		return;
+
+	/* clear descriptors */
+	for (i = 0; i < q->ndesc; i++)
+		q->desc[i].ctrl = cpu_to_le32(MT_DMA_CTL_DMA_DONE);
+
+	Q_WRITE(dev, q, cpu_idx, 0);
+	Q_WRITE(dev, q, dma_idx, 0);
+	mt76_dma_sync_idx(dev, q);
+}
+
+static int
+mt76_dma_add_rx_buf(struct mt76_dev *dev, struct mt76_queue *q,
+		    struct mt76_queue_buf *buf, void *data)
+{
+	struct mt76_desc *desc = &q->desc[q->head];
+	struct mt76_queue_entry *entry = &q->entry[q->head];
+	struct mt76_txwi_cache *txwi = NULL;
+	u32 buf1 = 0, ctrl;
+	int idx = q->head;
+	int rx_token;
+
+	ctrl = FIELD_PREP(MT_DMA_CTL_SD_LEN0, buf[0].len);
+
+	if (mt76_queue_is_wed_rx(q)) {
+		txwi = mt76_get_rxwi(dev);
+		if (!txwi)
+			return -ENOMEM;
+
+		rx_token = mt76_rx_token_consume(dev, data, txwi, buf->addr);
+		if (rx_token < 0) {
+			mt76_put_rxwi(dev, txwi);
+			return -ENOMEM;
+		}
+
+		buf1 |= FIELD_PREP(MT_DMA_CTL_TOKEN, rx_token);
+		ctrl |= MT_DMA_CTL_TO_HOST;
+	}
+
+	WRITE_ONCE(desc->buf0, cpu_to_le32(buf->addr));
+	WRITE_ONCE(desc->buf1, cpu_to_le32(buf1));
+	WRITE_ONCE(desc->ctrl, cpu_to_le32(ctrl));
+	WRITE_ONCE(desc->info, 0);
+
+	entry->dma_addr[0] = buf->addr;
+	entry->dma_len[0] = buf->len;
+	entry->txwi = txwi;
+	entry->buf = data;
+	entry->wcid = 0xffff;
+	entry->skip_buf1 = true;
+	q->head = (q->head + 1) % q->ndesc;
+	q->queued++;
+
+	return idx;
+}
+
+static int
+mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_queue *q,
+		 struct mt76_queue_buf *buf, int nbufs, u32 info,
+		 struct sk_buff *skb, void *txwi)
+{
+	struct mt76_queue_entry *entry;
+	struct mt76_desc *desc;
+	int i, idx = -1;
+	u32 ctrl, next;
+
+	if (txwi) {
+		q->entry[q->head].txwi = DMA_DUMMY_DATA;
+		q->entry[q->head].skip_buf0 = true;
+	}
+
+	for (i = 0; i < nbufs; i += 2, buf += 2) {
+		u32 buf0 = buf[0].addr, buf1 = 0;
+
+		idx = q->head;
+		next = (q->head + 1) % q->ndesc;
+
+		desc = &q->desc[idx];
+		entry = &q->entry[idx];
+
+		if (buf[0].skip_unmap)
+			entry->skip_buf0 = true;
+		entry->skip_buf1 = i == nbufs - 1;
+
+		entry->dma_addr[0] = buf[0].addr;
+		entry->dma_len[0] = buf[0].len;
+
+		ctrl = FIELD_PREP(MT_DMA_CTL_SD_LEN0, buf[0].len);
+		if (i < nbufs - 1) {
+			entry->dma_addr[1] = buf[1].addr;
+			entry->dma_len[1] = buf[1].len;
+			buf1 = buf[1].addr;
+			ctrl |= FIELD_PREP(MT_DMA_CTL_SD_LEN1, buf[1].len);
+			if (buf[1].skip_unmap)
+				entry->skip_buf1 = true;
+		}
+
+		if (i == nbufs - 1)
+			ctrl |= MT_DMA_CTL_LAST_SEC0;
+		else if (i == nbufs - 2)
+			ctrl |= MT_DMA_CTL_LAST_SEC1;
+
+		WRITE_ONCE(desc->buf0, cpu_to_le32(buf0));
+		WRITE_ONCE(desc->buf1, cpu_to_le32(buf1));
+		WRITE_ONCE(desc->info, cpu_to_le32(info));
+		WRITE_ONCE(desc->ctrl, cpu_to_le32(ctrl));
+
+		q->head = next;
+		q->queued++;
+	}
+
+	q->entry[idx].txwi = txwi;
+	q->entry[idx].skb = skb;
+	q->entry[idx].wcid = 0xffff;
+
+	return idx;
+}
+
+static void
+mt76_dma_tx_cleanup_idx(struct mt76_dev *dev, struct mt76_queue *q, int idx,
+			struct mt76_queue_entry *prev_e)
+{
+	struct mt76_queue_entry *e = &q->entry[idx];
+
+	if (!e->skip_buf0)
+		dma_unmap_single(dev->dma_dev, e->dma_addr[0], e->dma_len[0],
+				 DMA_TO_DEVICE);
+
+	if (!e->skip_buf1)
+		dma_unmap_single(dev->dma_dev, e->dma_addr[1], e->dma_len[1],
+				 DMA_TO_DEVICE);
+
+	if (e->txwi == DMA_DUMMY_DATA)
+		e->txwi = NULL;
+
+	*prev_e = *e;
+	memset(e, 0, sizeof(*e));
+}
+
+static void
+mt76_dma_kick_queue(struct mt76_dev *dev, struct mt76_queue *q)
+{
+	wmb();
+	Q_WRITE(dev, q, cpu_idx, q->head);
+}
+
+static void
+mt76_dma_tx_cleanup(struct mt76_dev *dev, struct mt76_queue *q, bool flush)
+{
+	struct mt76_queue_entry entry;
+	int last;
+
+	if (!q || !q->ndesc)
+		return;
+
+	spin_lock_bh(&q->cleanup_lock);
+	if (flush)
+		last = -1;
+	else
+		last = Q_READ(dev, q, dma_idx);
+
+	while (q->queued > 0 && q->tail != last) {
+		mt76_dma_tx_cleanup_idx(dev, q, q->tail, &entry);
+		mt76_queue_tx_complete(dev, q, &entry);
+
+		if (entry.txwi) {
+			if (!(dev->drv->drv_flags & MT_DRV_TXWI_NO_FREE))
+				mt76_put_txwi(dev, entry.txwi);
+		}
+
+		if (!flush && q->tail == last)
+			last = Q_READ(dev, q, dma_idx);
+	}
+	spin_unlock_bh(&q->cleanup_lock);
+
+	if (flush) {
+		spin_lock_bh(&q->lock);
+		mt76_dma_sync_idx(dev, q);
+		mt76_dma_kick_queue(dev, q);
+		spin_unlock_bh(&q->lock);
+	}
+
+	if (!q->queued)
+		wake_up(&dev->tx_wait);
+}
+
+static void *
+mt76_dma_get_buf(struct mt76_dev *dev, struct mt76_queue *q, int idx,
+		 int *len, u32 *info, bool *more, bool *drop)
+{
+	struct mt76_queue_entry *e = &q->entry[idx];
+	struct mt76_desc *desc = &q->desc[idx];
+	void *buf;
+
+	if (len) {
+		u32 ctrl = le32_to_cpu(READ_ONCE(desc->ctrl));
+		*len = FIELD_GET(MT_DMA_CTL_SD_LEN0, ctrl);
+		*more = !(ctrl & MT_DMA_CTL_LAST_SEC0);
+	}
+
+	if (info)
+		*info = le32_to_cpu(desc->info);
+
+	if (mt76_queue_is_wed_rx(q)) {
+		u32 buf1 = le32_to_cpu(desc->buf1);
+		u32 token = FIELD_GET(MT_DMA_CTL_TOKEN, buf1);
+		struct mt76_txwi_cache *t = mt76_rx_token_release(dev, token);
+
+		if (!t)
+			return NULL;
+
+		dma_sync_single_for_cpu(dev->dma_dev, t->dma_addr,
+				SKB_WITH_OVERHEAD(q->buf_size),
+				page_pool_get_dma_dir(q->page_pool));
+
+		buf = t->ptr;
+		t->dma_addr = 0;
+		t->ptr = NULL;
+
+		mt76_put_rxwi(dev, t);
+
+		if (drop) {
+			u32 ctrl = le32_to_cpu(READ_ONCE(desc->ctrl));
+
+			*drop = !!(ctrl & (MT_DMA_CTL_TO_HOST_A |
+					   MT_DMA_CTL_DROP));
+
+			*drop |= !!(buf1 & MT_DMA_CTL_WO_DROP);
+		}
+	} else {
+		buf = e->buf;
+		e->buf = NULL;
+		dma_sync_single_for_cpu(dev->dma_dev, e->dma_addr[0],
+				SKB_WITH_OVERHEAD(q->buf_size),
+				page_pool_get_dma_dir(q->page_pool));
+	}
+
+	return buf;
+}
+
+static void *
+mt76_dma_dequeue(struct mt76_dev *dev, struct mt76_queue *q, bool flush,
+		 int *len, u32 *info, bool *more, bool *drop)
+{
+	int idx = q->tail;
+
+	*more = false;
+	if (!q->queued)
+		return NULL;
+
+	if (flush)
+		q->desc[idx].ctrl |= cpu_to_le32(MT_DMA_CTL_DMA_DONE);
+	else if (!(q->desc[idx].ctrl & cpu_to_le32(MT_DMA_CTL_DMA_DONE)))
+		return NULL;
+
+	q->tail = (q->tail + 1) % q->ndesc;
+	q->queued--;
+
+	return mt76_dma_get_buf(dev, q, idx, len, info, more, drop);
+}
+
+static int
+mt76_dma_tx_queue_skb_raw(struct mt76_dev *dev, struct mt76_queue *q,
+			  struct sk_buff *skb, u32 tx_info)
+{
+	struct mt76_queue_buf buf = {};
+	dma_addr_t addr;
+
+	if (test_bit(MT76_MCU_RESET, &dev->phy.state))
+		goto error;
+
+	if (q->queued + 1 >= q->ndesc - 1)
+		goto error;
+
+	addr = dma_map_single(dev->dma_dev, skb->data, skb->len,
+			      DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(dev->dma_dev, addr)))
+		goto error;
+
+	buf.addr = addr;
+	buf.len = skb->len;
+
+	spin_lock_bh(&q->lock);
+	mt76_dma_add_buf(dev, q, &buf, 1, tx_info, skb, NULL);
+	mt76_dma_kick_queue(dev, q);
+	spin_unlock_bh(&q->lock);
+
+	return 0;
+
+error:
+	dev_kfree_skb(skb);
+	return -ENOMEM;
+}
+
+static int
+mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
+		      enum mt76_txq_id qid, struct sk_buff *skb,
+		      struct mt76_wcid *wcid, struct ieee80211_sta *sta)
+{
+	struct ieee80211_tx_status status = {
+		.sta = sta,
+	};
+	struct mt76_tx_info tx_info = {
+		.skb = skb,
+	};
+	struct ieee80211_hw *hw;
+	int len, n = 0, ret = -ENOMEM;
+	struct mt76_txwi_cache *t;
+	struct sk_buff *iter;
+	dma_addr_t addr;
+	u8 *txwi;
+
+	if (test_bit(MT76_RESET, &dev->phy.state))
+		goto free_skb;
+
+	t = mt76_get_txwi(dev);
+	if (!t)
+		goto free_skb;
+
+	txwi = mt76_get_txwi_ptr(dev, t);
+
+	skb->prev = skb->next = NULL;
+	if (dev->drv->drv_flags & MT_DRV_TX_ALIGNED4_SKBS)
+		mt76_insert_hdr_pad(skb);
+
+	len = skb_headlen(skb);
+	addr = dma_map_single(dev->dma_dev, skb->data, len, DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(dev->dma_dev, addr)))
+		goto free;
+
+	tx_info.buf[n].addr = t->dma_addr;
+	tx_info.buf[n++].len = dev->drv->txwi_size;
+	tx_info.buf[n].addr = addr;
+	tx_info.buf[n++].len = len;
+
+	skb_walk_frags(skb, iter) {
+		if (n == ARRAY_SIZE(tx_info.buf))
+			goto unmap;
+
+		addr = dma_map_single(dev->dma_dev, iter->data, iter->len,
+				      DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(dev->dma_dev, addr)))
+			goto unmap;
+
+		tx_info.buf[n].addr = addr;
+		tx_info.buf[n++].len = iter->len;
+	}
+	tx_info.nbuf = n;
+
+	if (q->queued + (tx_info.nbuf + 1) / 2 >= q->ndesc - 1) {
+		ret = -ENOMEM;
+		goto unmap;
+	}
+
+	dma_sync_single_for_cpu(dev->dma_dev, t->dma_addr, dev->drv->txwi_size,
+				DMA_TO_DEVICE);
+	ret = dev->drv->tx_prepare_skb(dev, txwi, qid, wcid, sta, &tx_info);
+	dma_sync_single_for_device(dev->dma_dev, t->dma_addr, dev->drv->txwi_size,
+				   DMA_TO_DEVICE);
+	if (ret < 0)
+		goto unmap;
+
+	return mt76_dma_add_buf(dev, q, tx_info.buf, tx_info.nbuf,
+				tx_info.info, tx_info.skb, t);
+
+unmap:
+	for (n--; n > 0; n--)
+		dma_unmap_single(dev->dma_dev, tx_info.buf[n].addr,
+				 tx_info.buf[n].len, DMA_TO_DEVICE);
+
+free:
+#ifdef CONFIG_NL80211_TESTMODE
+	/* fix tx_done accounting on queue overflow */
+	if (mt76_is_testmode_skb(dev, skb, &hw)) {
+		struct mt76_phy *phy = hw->priv;
+
+		if (tx_info.skb == phy->test.tx_skb)
+			phy->test.tx_done--;
+	}
+#endif
+
+	mt76_put_txwi(dev, t);
+
+free_skb:
+	status.skb = tx_info.skb;
+	hw = mt76_tx_status_get_hw(dev, tx_info.skb);
+	spin_lock_bh(&dev->rx_lock);
+	ieee80211_tx_status_ext(hw, &status);
+	spin_unlock_bh(&dev->rx_lock);
+
+	return ret;
+}
+
+static int
+mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q,
+		 bool allow_direct)
+{
+	int len = SKB_WITH_OVERHEAD(q->buf_size);
+	int frames = 0;
+
+	if (!q->ndesc)
+		return 0;
+
+	spin_lock_bh(&q->lock);
+
+	while (q->queued < q->ndesc - 1) {
+		enum dma_data_direction dir;
+		struct mt76_queue_buf qbuf;
+		dma_addr_t addr;
+		int offset;
+		void *buf;
+
+		buf = mt76_get_page_pool_buf(q, &offset, q->buf_size);
+		if (!buf)
+			break;
+
+		addr = page_pool_get_dma_addr(virt_to_head_page(buf)) + offset;
+		dir = page_pool_get_dma_dir(q->page_pool);
+		dma_sync_single_for_device(dev->dma_dev, addr, len, dir);
+
+		qbuf.addr = addr + q->buf_offset;
+		qbuf.len = len - q->buf_offset;
+		qbuf.skip_unmap = false;
+		if (mt76_dma_add_rx_buf(dev, q, &qbuf, buf) < 0) {
+			mt76_put_page_pool_buf(buf, allow_direct);
+			break;
+		}
+		frames++;
+	}
+
+	if (frames)
+		mt76_dma_kick_queue(dev, q);
+
+	spin_unlock_bh(&q->lock);
+
+	return frames;
+}
+
+int mt76_dma_wed_setup(struct mt76_dev *dev, struct mt76_queue *q, bool reset)
+{
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+	struct mtk_wed_device *wed = &dev->mmio.wed;
+	int ret, type, ring;
+	u8 flags;
+
+	if (!q || !q->ndesc)
+		return -EINVAL;
+
+	flags = q->flags;
+	if (!mtk_wed_device_active(wed))
+		q->flags &= ~MT_QFLAG_WED;
+
+	if (!(q->flags & MT_QFLAG_WED))
+		return 0;
+
+	type = FIELD_GET(MT_QFLAG_WED_TYPE, q->flags);
+	ring = FIELD_GET(MT_QFLAG_WED_RING, q->flags);
+
+	switch (type) {
+	case MT76_WED_Q_TX:
+		ret = mtk_wed_device_tx_ring_setup(wed, ring, q->regs, reset);
+		if (!ret)
+			q->wed_regs = wed->tx_ring[ring].reg_base;
+		break;
+	case MT76_WED_Q_TXFREE:
+		/* WED txfree queue needs ring to be initialized before setup */
+		q->flags = 0;
+		mt76_dma_queue_reset(dev, q);
+		mt76_dma_rx_fill(dev, q, false);
+		q->flags = flags;
+
+		ret = mtk_wed_device_txfree_ring_setup(wed, q->regs);
+		if (!ret)
+			q->wed_regs = wed->txfree_ring.reg_base;
+		break;
+	case MT76_WED_Q_RX:
+		ret = mtk_wed_device_rx_ring_setup(wed, ring, q->regs, reset);
+		if (!ret)
+			q->wed_regs = wed->rx_ring[ring].reg_base;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+#else
+	return 0;
+#endif
+}
+EXPORT_SYMBOL_GPL(mt76_dma_wed_setup);
+
+static int
+mt76_dma_alloc_queue(struct mt76_dev *dev, struct mt76_queue *q,
+		     int idx, int n_desc, int bufsize,
+		     u32 ring_base)
+{
+	int ret, size;
+
+	spin_lock_init(&q->lock);
+	spin_lock_init(&q->cleanup_lock);
+
+	q->regs = dev->mmio.regs + ring_base + idx * MT_RING_SIZE;
+	q->ndesc = n_desc;
+	q->buf_size = bufsize;
+	q->hw_idx = idx;
+
+	size = q->ndesc * sizeof(struct mt76_desc);
+	q->desc = dmam_alloc_coherent(dev->dma_dev, size, &q->desc_dma, GFP_KERNEL);
+	if (!q->desc)
+		return -ENOMEM;
+
+	size = q->ndesc * sizeof(*q->entry);
+	q->entry = devm_kzalloc(dev->dev, size, GFP_KERNEL);
+	if (!q->entry)
+		return -ENOMEM;
+
+	ret = mt76_create_page_pool(dev, q);
+	if (ret)
+		return ret;
+
+	ret = mt76_dma_wed_setup(dev, q, false);
+	if (ret)
+		return ret;
+
+	if (q->flags != MT_WED_Q_TXFREE)
+		mt76_dma_queue_reset(dev, q);
+
+	return 0;
+}
+
+static void
+mt76_dma_rx_cleanup(struct mt76_dev *dev, struct mt76_queue *q)
+{
+	void *buf;
+	bool more;
+
+	if (!q->ndesc)
+		return;
+
+	spin_lock_bh(&q->lock);
+
+	do {
+		buf = mt76_dma_dequeue(dev, q, true, NULL, NULL, &more, NULL);
+		if (!buf)
+			break;
+
+		mt76_put_page_pool_buf(buf, false);
+	} while (1);
+
+	if (q->rx_head) {
+		dev_kfree_skb(q->rx_head);
+		q->rx_head = NULL;
+	}
+
+	spin_unlock_bh(&q->lock);
+}
+
+static void
+mt76_dma_rx_reset(struct mt76_dev *dev, enum mt76_rxq_id qid)
+{
+	struct mt76_queue *q = &dev->q_rx[qid];
+	int i;
+
+	if (!q->ndesc)
+		return;
+
+	for (i = 0; i < q->ndesc; i++)
+		q->desc[i].ctrl = cpu_to_le32(MT_DMA_CTL_DMA_DONE);
+
+	mt76_dma_rx_cleanup(dev, q);
+
+	/* reset WED rx queues */
+	mt76_dma_wed_setup(dev, q, true);
+	if (q->flags != MT_WED_Q_TXFREE) {
+		mt76_dma_sync_idx(dev, q);
+		mt76_dma_rx_fill(dev, q, false);
+	}
+}
+
+static void
+mt76_add_fragment(struct mt76_dev *dev, struct mt76_queue *q, void *data,
+		  int len, bool more, u32 info)
+{
+	struct sk_buff *skb = q->rx_head;
+	struct skb_shared_info *shinfo = skb_shinfo(skb);
+	int nr_frags = shinfo->nr_frags;
+
+	if (nr_frags < ARRAY_SIZE(shinfo->frags)) {
+		struct page *page = virt_to_head_page(data);
+		int offset = data - page_address(page) + q->buf_offset;
+
+		skb_add_rx_frag(skb, nr_frags, page, offset, len, q->buf_size);
+	} else {
+		mt76_put_page_pool_buf(data, true);
+	}
+
+	if (more)
+		return;
+
+	q->rx_head = NULL;
+	if (nr_frags < ARRAY_SIZE(shinfo->frags))
+		dev->drv->rx_skb(dev, q - dev->q_rx, skb, &info);
+	else
+		dev_kfree_skb(skb);
+}
+
+static int
+mt76_dma_rx_process(struct mt76_dev *dev, struct mt76_queue *q, int budget)
+{
+	int len, data_len, done = 0, dma_idx;
+	struct sk_buff *skb;
+	unsigned char *data;
+	bool check_ddone = false;
+	bool more;
+
+	if (IS_ENABLED(CONFIG_NET_MEDIATEK_SOC_WED) &&
+	    q->flags == MT_WED_Q_TXFREE) {
+		dma_idx = Q_READ(dev, q, dma_idx);
+		check_ddone = true;
+	}
+
+	while (done < budget) {
+		bool drop = false;
+		u32 info;
+
+		if (check_ddone) {
+			if (q->tail == dma_idx)
+				dma_idx = Q_READ(dev, q, dma_idx);
+
+			if (q->tail == dma_idx)
+				break;
+		}
+
+		data = mt76_dma_dequeue(dev, q, false, &len, &info, &more,
+					&drop);
+		if (!data)
+			break;
+
+		if (drop)
+			goto free_frag;
+
+		if (q->rx_head)
+			data_len = q->buf_size;
+		else
+			data_len = SKB_WITH_OVERHEAD(q->buf_size);
+
+		if (data_len < len + q->buf_offset) {
+			dev_kfree_skb(q->rx_head);
+			q->rx_head = NULL;
+			goto free_frag;
+		}
+
+		if (q->rx_head) {
+			mt76_add_fragment(dev, q, data, len, more, info);
+			continue;
+		}
+
+		if (!more && dev->drv->rx_check &&
+		    !(dev->drv->rx_check(dev, data, len)))
+			goto free_frag;
+
+		skb = napi_build_skb(data, q->buf_size);
+		if (!skb)
+			goto free_frag;
+
+		skb_reserve(skb, q->buf_offset);
+		skb_mark_for_recycle(skb);
+
+		*(u32 *)skb->cb = info;
+
+		__skb_put(skb, len);
+		done++;
+
+		if (more) {
+			q->rx_head = skb;
+			continue;
+		}
+
+		dev->drv->rx_skb(dev, q - dev->q_rx, skb, &info);
+		continue;
+
+free_frag:
+		mt76_put_page_pool_buf(data, true);
+	}
+
+	mt76_dma_rx_fill(dev, q, true);
+	return done;
+}
+
+int mt76_dma_rx_poll(struct napi_struct *napi, int budget)
+{
+	struct mt76_dev *dev;
+	int qid, done = 0, cur;
+
+	dev = container_of(napi->dev, struct mt76_dev, napi_dev);
+	qid = napi - dev->napi;
+
+	rcu_read_lock();
+
+	do {
+		cur = mt76_dma_rx_process(dev, &dev->q_rx[qid], budget - done);
+		mt76_rx_poll_complete(dev, qid, napi);
+		done += cur;
+	} while (cur && done < budget);
+
+	rcu_read_unlock();
+
+	if (done < budget && napi_complete(napi))
+		dev->drv->rx_poll_complete(dev, qid);
+
+	return done;
+}
+EXPORT_SYMBOL_GPL(mt76_dma_rx_poll);
+
+static int
+mt76_dma_init(struct mt76_dev *dev,
+	      int (*poll)(struct napi_struct *napi, int budget))
+{
+	int i;
+
+	init_dummy_netdev(&dev->napi_dev);
+	init_dummy_netdev(&dev->tx_napi_dev);
+	snprintf(dev->napi_dev.name, sizeof(dev->napi_dev.name), "%s",
+		 wiphy_name(dev->hw->wiphy));
+	dev->napi_dev.threaded = 1;
+	init_completion(&dev->mmio.wed_reset);
+	init_completion(&dev->mmio.wed_reset_complete);
+
+	mt76_for_each_q_rx(dev, i) {
+		netif_napi_add(&dev->napi_dev, &dev->napi[i], poll);
+		mt76_dma_rx_fill(dev, &dev->q_rx[i], false);
+		napi_enable(&dev->napi[i]);
+	}
+
+	return 0;
+}
+
+static const struct mt76_queue_ops mt76_dma_ops = {
+	.init = mt76_dma_init,
+	.alloc = mt76_dma_alloc_queue,
+	.reset_q = mt76_dma_queue_reset,
+	.tx_queue_skb_raw = mt76_dma_tx_queue_skb_raw,
+	.tx_queue_skb = mt76_dma_tx_queue_skb,
+	.tx_cleanup = mt76_dma_tx_cleanup,
+	.rx_cleanup = mt76_dma_rx_cleanup,
+	.rx_reset = mt76_dma_rx_reset,
+	.kick = mt76_dma_kick_queue,
+};
+
+void mt76_dma_attach(struct mt76_dev *dev)
+{
+	dev->queue_ops = &mt76_dma_ops;
+}
+EXPORT_SYMBOL_GPL(mt76_dma_attach);
+
+void mt76_dma_cleanup(struct mt76_dev *dev)
+{
+	int i;
+
+	mt76_worker_disable(&dev->tx_worker);
+	netif_napi_del(&dev->tx_napi);
+
+	for (i = 0; i < ARRAY_SIZE(dev->phys); i++) {
+		struct mt76_phy *phy = dev->phys[i];
+		int j;
+
+		if (!phy)
+			continue;
+
+		for (j = 0; j < ARRAY_SIZE(phy->q_tx); j++)
+			mt76_dma_tx_cleanup(dev, phy->q_tx[j], true);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(dev->q_mcu); i++)
+		mt76_dma_tx_cleanup(dev, dev->q_mcu[i], true);
+
+	mt76_for_each_q_rx(dev, i) {
+		struct mt76_queue *q = &dev->q_rx[i];
+
+		netif_napi_del(&dev->napi[i]);
+		mt76_dma_rx_cleanup(dev, q);
+
+		page_pool_destroy(q->page_pool);
+	}
+
+	mt76_free_pending_txwi(dev);
+	mt76_free_pending_rxwi(dev);
+
+	if (mtk_wed_device_active(&dev->mmio.wed))
+		mtk_wed_device_detach(&dev->mmio.wed);
+}
+EXPORT_SYMBOL_GPL(mt76_dma_cleanup);
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c.orig b/drivers/net/wireless/mediatek/mt76/mac80211.c.orig
new file mode 100644
index 000000000000..c0ff36a98bed
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c.orig
@@ -0,0 +1,1793 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
+ */
+#include <linux/sched.h>
+#include <linux/of.h>
+#include <net/page_pool.h>
+#include "mt76.h"
+
+#define CHAN2G(_idx, _freq) {			\
+	.band = NL80211_BAND_2GHZ,		\
+	.center_freq = (_freq),			\
+	.hw_value = (_idx),			\
+	.max_power = 30,			\
+}
+
+#define CHAN5G(_idx, _freq) {			\
+	.band = NL80211_BAND_5GHZ,		\
+	.center_freq = (_freq),			\
+	.hw_value = (_idx),			\
+	.max_power = 30,			\
+}
+
+#define CHAN6G(_idx, _freq) {			\
+	.band = NL80211_BAND_6GHZ,		\
+	.center_freq = (_freq),			\
+	.hw_value = (_idx),			\
+	.max_power = 30,			\
+}
+
+static const struct ieee80211_channel mt76_channels_2ghz[] = {
+	CHAN2G(1, 2412),
+	CHAN2G(2, 2417),
+	CHAN2G(3, 2422),
+	CHAN2G(4, 2427),
+	CHAN2G(5, 2432),
+	CHAN2G(6, 2437),
+	CHAN2G(7, 2442),
+	CHAN2G(8, 2447),
+	CHAN2G(9, 2452),
+	CHAN2G(10, 2457),
+	CHAN2G(11, 2462),
+	CHAN2G(12, 2467),
+	CHAN2G(13, 2472),
+	CHAN2G(14, 2484),
+};
+
+static const struct ieee80211_channel mt76_channels_5ghz[] = {
+	CHAN5G(36, 5180),
+	CHAN5G(40, 5200),
+	CHAN5G(44, 5220),
+	CHAN5G(48, 5240),
+
+	CHAN5G(52, 5260),
+	CHAN5G(56, 5280),
+	CHAN5G(60, 5300),
+	CHAN5G(64, 5320),
+
+	CHAN5G(100, 5500),
+	CHAN5G(104, 5520),
+	CHAN5G(108, 5540),
+	CHAN5G(112, 5560),
+	CHAN5G(116, 5580),
+	CHAN5G(120, 5600),
+	CHAN5G(124, 5620),
+	CHAN5G(128, 5640),
+	CHAN5G(132, 5660),
+	CHAN5G(136, 5680),
+	CHAN5G(140, 5700),
+	CHAN5G(144, 5720),
+
+	CHAN5G(149, 5745),
+	CHAN5G(153, 5765),
+	CHAN5G(157, 5785),
+	CHAN5G(161, 5805),
+	CHAN5G(165, 5825),
+	CHAN5G(169, 5845),
+	CHAN5G(173, 5865),
+	CHAN5G(177, 5885),
+};
+
+static const struct ieee80211_channel mt76_channels_6ghz[] = {
+	/* UNII-5 */
+	CHAN6G(1, 5955),
+	CHAN6G(5, 5975),
+	CHAN6G(9, 5995),
+	CHAN6G(13, 6015),
+	CHAN6G(17, 6035),
+	CHAN6G(21, 6055),
+	CHAN6G(25, 6075),
+	CHAN6G(29, 6095),
+	CHAN6G(33, 6115),
+	CHAN6G(37, 6135),
+	CHAN6G(41, 6155),
+	CHAN6G(45, 6175),
+	CHAN6G(49, 6195),
+	CHAN6G(53, 6215),
+	CHAN6G(57, 6235),
+	CHAN6G(61, 6255),
+	CHAN6G(65, 6275),
+	CHAN6G(69, 6295),
+	CHAN6G(73, 6315),
+	CHAN6G(77, 6335),
+	CHAN6G(81, 6355),
+	CHAN6G(85, 6375),
+	CHAN6G(89, 6395),
+	CHAN6G(93, 6415),
+	/* UNII-6 */
+	CHAN6G(97, 6435),
+	CHAN6G(101, 6455),
+	CHAN6G(105, 6475),
+	CHAN6G(109, 6495),
+	CHAN6G(113, 6515),
+	CHAN6G(117, 6535),
+	/* UNII-7 */
+	CHAN6G(121, 6555),
+	CHAN6G(125, 6575),
+	CHAN6G(129, 6595),
+	CHAN6G(133, 6615),
+	CHAN6G(137, 6635),
+	CHAN6G(141, 6655),
+	CHAN6G(145, 6675),
+	CHAN6G(149, 6695),
+	CHAN6G(153, 6715),
+	CHAN6G(157, 6735),
+	CHAN6G(161, 6755),
+	CHAN6G(165, 6775),
+	CHAN6G(169, 6795),
+	CHAN6G(173, 6815),
+	CHAN6G(177, 6835),
+	CHAN6G(181, 6855),
+	CHAN6G(185, 6875),
+	/* UNII-8 */
+	CHAN6G(189, 6895),
+	CHAN6G(193, 6915),
+	CHAN6G(197, 6935),
+	CHAN6G(201, 6955),
+	CHAN6G(205, 6975),
+	CHAN6G(209, 6995),
+	CHAN6G(213, 7015),
+	CHAN6G(217, 7035),
+	CHAN6G(221, 7055),
+	CHAN6G(225, 7075),
+	CHAN6G(229, 7095),
+	CHAN6G(233, 7115),
+};
+
+static const struct ieee80211_tpt_blink mt76_tpt_blink[] = {
+	{ .throughput =   0 * 1024, .blink_time = 334 },
+	{ .throughput =   1 * 1024, .blink_time = 260 },
+	{ .throughput =   5 * 1024, .blink_time = 220 },
+	{ .throughput =  10 * 1024, .blink_time = 190 },
+	{ .throughput =  20 * 1024, .blink_time = 170 },
+	{ .throughput =  50 * 1024, .blink_time = 150 },
+	{ .throughput =  70 * 1024, .blink_time = 130 },
+	{ .throughput = 100 * 1024, .blink_time = 110 },
+	{ .throughput = 200 * 1024, .blink_time =  80 },
+	{ .throughput = 300 * 1024, .blink_time =  50 },
+};
+
+struct ieee80211_rate mt76_rates[] = {
+	CCK_RATE(0, 10),
+	CCK_RATE(1, 20),
+	CCK_RATE(2, 55),
+	CCK_RATE(3, 110),
+	OFDM_RATE(11, 60),
+	OFDM_RATE(15, 90),
+	OFDM_RATE(10, 120),
+	OFDM_RATE(14, 180),
+	OFDM_RATE(9,  240),
+	OFDM_RATE(13, 360),
+	OFDM_RATE(8,  480),
+	OFDM_RATE(12, 540),
+};
+EXPORT_SYMBOL_GPL(mt76_rates);
+
+static const struct cfg80211_sar_freq_ranges mt76_sar_freq_ranges[] = {
+	{ .start_freq = 2402, .end_freq = 2494, },
+	{ .start_freq = 5150, .end_freq = 5350, },
+	{ .start_freq = 5350, .end_freq = 5470, },
+	{ .start_freq = 5470, .end_freq = 5725, },
+	{ .start_freq = 5725, .end_freq = 5950, },
+	{ .start_freq = 5945, .end_freq = 6165, },
+	{ .start_freq = 6165, .end_freq = 6405, },
+	{ .start_freq = 6405, .end_freq = 6525, },
+	{ .start_freq = 6525, .end_freq = 6705, },
+	{ .start_freq = 6705, .end_freq = 6865, },
+	{ .start_freq = 6865, .end_freq = 7125, },
+};
+
+static const struct cfg80211_sar_capa mt76_sar_capa = {
+	.type = NL80211_SAR_TYPE_POWER,
+	.num_freq_ranges = ARRAY_SIZE(mt76_sar_freq_ranges),
+	.freq_ranges = &mt76_sar_freq_ranges[0],
+};
+
+static int mt76_led_init(struct mt76_phy *phy)
+{
+	struct mt76_dev *dev = phy->dev;
+	struct ieee80211_hw *hw = phy->hw;
+
+	if (!phy->leds.cdev.brightness_set && !phy->leds.cdev.blink_set)
+		return 0;
+
+	snprintf(phy->leds.name, sizeof(phy->leds.name), "mt76-%s",
+		 wiphy_name(hw->wiphy));
+
+	phy->leds.cdev.name = phy->leds.name;
+	phy->leds.cdev.default_trigger =
+		ieee80211_create_tpt_led_trigger(hw,
+					IEEE80211_TPT_LEDTRIG_FL_RADIO,
+					mt76_tpt_blink,
+					ARRAY_SIZE(mt76_tpt_blink));
+
+	if (phy == &dev->phy) {
+		struct device_node *np = dev->dev->of_node;
+
+		np = of_get_child_by_name(np, "led");
+		if (np) {
+			int led_pin;
+
+			if (!of_property_read_u32(np, "led-sources", &led_pin))
+				phy->leds.pin = led_pin;
+			phy->leds.al = of_property_read_bool(np,
+							     "led-active-low");
+			of_node_put(np);
+		}
+	}
+
+	return led_classdev_register(dev->dev, &phy->leds.cdev);
+}
+
+static void mt76_led_cleanup(struct mt76_phy *phy)
+{
+	if (!phy->leds.cdev.brightness_set && !phy->leds.cdev.blink_set)
+		return;
+
+	led_classdev_unregister(&phy->leds.cdev);
+}
+
+static void mt76_init_stream_cap(struct mt76_phy *phy,
+				 struct ieee80211_supported_band *sband,
+				 bool vht)
+{
+	struct ieee80211_sta_ht_cap *ht_cap = &sband->ht_cap;
+	int i, nstream = hweight8(phy->antenna_mask);
+	struct ieee80211_sta_vht_cap *vht_cap;
+	u16 mcs_map = 0;
+
+	if (nstream > 1)
+		ht_cap->cap |= IEEE80211_HT_CAP_TX_STBC;
+	else
+		ht_cap->cap &= ~IEEE80211_HT_CAP_TX_STBC;
+
+	for (i = 0; i < IEEE80211_HT_MCS_MASK_LEN; i++)
+		ht_cap->mcs.rx_mask[i] = i < nstream ? 0xff : 0;
+
+	if (!vht)
+		return;
+
+	vht_cap = &sband->vht_cap;
+	if (nstream > 1)
+		vht_cap->cap |= IEEE80211_VHT_CAP_TXSTBC;
+	else
+		vht_cap->cap &= ~IEEE80211_VHT_CAP_TXSTBC;
+	vht_cap->cap |= IEEE80211_VHT_CAP_TX_ANTENNA_PATTERN |
+			IEEE80211_VHT_CAP_RX_ANTENNA_PATTERN;
+
+	for (i = 0; i < 8; i++) {
+		if (i < nstream)
+			mcs_map |= (IEEE80211_VHT_MCS_SUPPORT_0_9 << (i * 2));
+		else
+			mcs_map |=
+				(IEEE80211_VHT_MCS_NOT_SUPPORTED << (i * 2));
+	}
+	vht_cap->vht_mcs.rx_mcs_map = cpu_to_le16(mcs_map);
+	vht_cap->vht_mcs.tx_mcs_map = cpu_to_le16(mcs_map);
+	if (ieee80211_hw_check(phy->hw, SUPPORTS_VHT_EXT_NSS_BW))
+		vht_cap->vht_mcs.tx_highest |=
+				cpu_to_le16(IEEE80211_VHT_EXT_NSS_BW_CAPABLE);
+}
+
+void mt76_set_stream_caps(struct mt76_phy *phy, bool vht)
+{
+	if (phy->cap.has_2ghz)
+		mt76_init_stream_cap(phy, &phy->sband_2g.sband, false);
+	if (phy->cap.has_5ghz)
+		mt76_init_stream_cap(phy, &phy->sband_5g.sband, vht);
+	if (phy->cap.has_6ghz)
+		mt76_init_stream_cap(phy, &phy->sband_6g.sband, vht);
+}
+EXPORT_SYMBOL_GPL(mt76_set_stream_caps);
+
+static int
+mt76_init_sband(struct mt76_phy *phy, struct mt76_sband *msband,
+		const struct ieee80211_channel *chan, int n_chan,
+		struct ieee80211_rate *rates, int n_rates,
+		bool ht, bool vht)
+{
+	struct ieee80211_supported_band *sband = &msband->sband;
+	struct ieee80211_sta_vht_cap *vht_cap;
+	struct ieee80211_sta_ht_cap *ht_cap;
+	struct mt76_dev *dev = phy->dev;
+	void *chanlist;
+	int size;
+
+	size = n_chan * sizeof(*chan);
+	chanlist = devm_kmemdup(dev->dev, chan, size, GFP_KERNEL);
+	if (!chanlist)
+		return -ENOMEM;
+
+	msband->chan = devm_kcalloc(dev->dev, n_chan, sizeof(*msband->chan),
+				    GFP_KERNEL);
+	if (!msband->chan)
+		return -ENOMEM;
+
+	sband->channels = chanlist;
+	sband->n_channels = n_chan;
+	sband->bitrates = rates;
+	sband->n_bitrates = n_rates;
+
+	if (!ht)
+		return 0;
+
+	ht_cap = &sband->ht_cap;
+	ht_cap->ht_supported = true;
+	ht_cap->cap |= IEEE80211_HT_CAP_SUP_WIDTH_20_40 |
+		       IEEE80211_HT_CAP_GRN_FLD |
+		       IEEE80211_HT_CAP_SGI_20 |
+		       IEEE80211_HT_CAP_SGI_40 |
+		       (1 << IEEE80211_HT_CAP_RX_STBC_SHIFT);
+
+	ht_cap->mcs.tx_params = IEEE80211_HT_MCS_TX_DEFINED;
+	ht_cap->ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K;
+
+	mt76_init_stream_cap(phy, sband, vht);
+
+	if (!vht)
+		return 0;
+
+	vht_cap = &sband->vht_cap;
+	vht_cap->vht_supported = true;
+	vht_cap->cap |= IEEE80211_VHT_CAP_RXLDPC |
+			IEEE80211_VHT_CAP_RXSTBC_1 |
+			IEEE80211_VHT_CAP_SHORT_GI_80 |
+			(3 << IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT);
+
+	return 0;
+}
+
+static int
+mt76_init_sband_2g(struct mt76_phy *phy, struct ieee80211_rate *rates,
+		   int n_rates)
+{
+	phy->hw->wiphy->bands[NL80211_BAND_2GHZ] = &phy->sband_2g.sband;
+
+	return mt76_init_sband(phy, &phy->sband_2g, mt76_channels_2ghz,
+			       ARRAY_SIZE(mt76_channels_2ghz), rates,
+			       n_rates, true, false);
+}
+
+static int
+mt76_init_sband_5g(struct mt76_phy *phy, struct ieee80211_rate *rates,
+		   int n_rates, bool vht)
+{
+	phy->hw->wiphy->bands[NL80211_BAND_5GHZ] = &phy->sband_5g.sband;
+
+	return mt76_init_sband(phy, &phy->sband_5g, mt76_channels_5ghz,
+			       ARRAY_SIZE(mt76_channels_5ghz), rates,
+			       n_rates, true, vht);
+}
+
+static int
+mt76_init_sband_6g(struct mt76_phy *phy, struct ieee80211_rate *rates,
+		   int n_rates)
+{
+	phy->hw->wiphy->bands[NL80211_BAND_6GHZ] = &phy->sband_6g.sband;
+
+	return mt76_init_sband(phy, &phy->sband_6g, mt76_channels_6ghz,
+			       ARRAY_SIZE(mt76_channels_6ghz), rates,
+			       n_rates, false, false);
+}
+
+static void
+mt76_check_sband(struct mt76_phy *phy, struct mt76_sband *msband,
+		 enum nl80211_band band)
+{
+	struct ieee80211_supported_band *sband = &msband->sband;
+	bool found = false;
+	int i;
+
+	if (!sband)
+		return;
+
+	for (i = 0; i < sband->n_channels; i++) {
+		if (sband->channels[i].flags & IEEE80211_CHAN_DISABLED)
+			continue;
+
+		found = true;
+		break;
+	}
+
+	if (found) {
+		phy->chandef.chan = &sband->channels[0];
+		phy->chan_state = &msband->chan[0];
+		return;
+	}
+
+	sband->n_channels = 0;
+	phy->hw->wiphy->bands[band] = NULL;
+}
+
+static int
+mt76_phy_init(struct mt76_phy *phy, struct ieee80211_hw *hw)
+{
+	struct mt76_dev *dev = phy->dev;
+	struct wiphy *wiphy = hw->wiphy;
+
+	SET_IEEE80211_DEV(hw, dev->dev);
+	SET_IEEE80211_PERM_ADDR(hw, phy->macaddr);
+
+	wiphy->features |= NL80211_FEATURE_ACTIVE_MONITOR |
+			   NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE;
+	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH |
+			WIPHY_FLAG_SUPPORTS_TDLS |
+			WIPHY_FLAG_AP_UAPSD;
+
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_AIRTIME_FAIRNESS);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_AQL);
+
+	wiphy->available_antennas_tx = phy->antenna_mask;
+	wiphy->available_antennas_rx = phy->antenna_mask;
+
+	wiphy->sar_capa = &mt76_sar_capa;
+	phy->frp = devm_kcalloc(dev->dev, wiphy->sar_capa->num_freq_ranges,
+				sizeof(struct mt76_freq_range_power),
+				GFP_KERNEL);
+	if (!phy->frp)
+		return -ENOMEM;
+
+	hw->txq_data_size = sizeof(struct mt76_txq);
+	hw->uapsd_max_sp_len = IEEE80211_WMM_IE_STA_QOSINFO_SP_ALL;
+
+	if (!hw->max_tx_fragments)
+		hw->max_tx_fragments = 16;
+
+	ieee80211_hw_set(hw, SIGNAL_DBM);
+	ieee80211_hw_set(hw, AMPDU_AGGREGATION);
+	ieee80211_hw_set(hw, SUPPORTS_RC_TABLE);
+	ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
+	ieee80211_hw_set(hw, SUPPORTS_CLONED_SKBS);
+	ieee80211_hw_set(hw, SUPPORTS_AMSDU_IN_AMPDU);
+	ieee80211_hw_set(hw, SUPPORTS_REORDERING_BUFFER);
+
+	if (!(dev->drv->drv_flags & MT_DRV_AMSDU_OFFLOAD)) {
+		ieee80211_hw_set(hw, TX_AMSDU);
+		ieee80211_hw_set(hw, TX_FRAG_LIST);
+	}
+
+	ieee80211_hw_set(hw, MFP_CAPABLE);
+	ieee80211_hw_set(hw, AP_LINK_PS);
+	ieee80211_hw_set(hw, REPORTS_TX_ACK_STATUS);
+
+	return 0;
+}
+
+struct mt76_phy *
+mt76_alloc_phy(struct mt76_dev *dev, unsigned int size,
+	       const struct ieee80211_ops *ops, u8 band_idx)
+{
+	struct ieee80211_hw *hw;
+	unsigned int phy_size;
+	struct mt76_phy *phy;
+
+	phy_size = ALIGN(sizeof(*phy), 8);
+	hw = ieee80211_alloc_hw(size + phy_size, ops);
+	if (!hw)
+		return NULL;
+
+	phy = hw->priv;
+	phy->dev = dev;
+	phy->hw = hw;
+	phy->priv = hw->priv + phy_size;
+	phy->band_idx = band_idx;
+
+	hw->wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
+	hw->wiphy->interface_modes =
+		BIT(NL80211_IFTYPE_STATION) |
+		BIT(NL80211_IFTYPE_AP) |
+#ifdef CONFIG_MAC80211_MESH
+		BIT(NL80211_IFTYPE_MESH_POINT) |
+#endif
+		BIT(NL80211_IFTYPE_P2P_CLIENT) |
+		BIT(NL80211_IFTYPE_P2P_GO) |
+		BIT(NL80211_IFTYPE_ADHOC);
+
+	return phy;
+}
+EXPORT_SYMBOL_GPL(mt76_alloc_phy);
+
+int mt76_register_phy(struct mt76_phy *phy, bool vht,
+		      struct ieee80211_rate *rates, int n_rates)
+{
+	int ret;
+
+	ret = mt76_phy_init(phy, phy->hw);
+	if (ret)
+		return ret;
+
+	if (phy->cap.has_2ghz) {
+		ret = mt76_init_sband_2g(phy, rates, n_rates);
+		if (ret)
+			return ret;
+	}
+
+	if (phy->cap.has_5ghz) {
+		ret = mt76_init_sband_5g(phy, rates + 4, n_rates - 4, vht);
+		if (ret)
+			return ret;
+	}
+
+	if (phy->cap.has_6ghz) {
+		ret = mt76_init_sband_6g(phy, rates + 4, n_rates - 4);
+		if (ret)
+			return ret;
+	}
+
+	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
+		ret = mt76_led_init(phy);
+		if (ret)
+			return ret;
+	}
+
+	wiphy_read_of_freq_limits(phy->hw->wiphy);
+	mt76_check_sband(phy, &phy->sband_2g, NL80211_BAND_2GHZ);
+	mt76_check_sband(phy, &phy->sband_5g, NL80211_BAND_5GHZ);
+	mt76_check_sband(phy, &phy->sband_6g, NL80211_BAND_6GHZ);
+
+	ret = ieee80211_register_hw(phy->hw);
+	if (ret)
+		return ret;
+
+	set_bit(MT76_STATE_REGISTERED, &phy->state);
+	phy->dev->phys[phy->band_idx] = phy;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_register_phy);
+
+void mt76_unregister_phy(struct mt76_phy *phy)
+{
+	struct mt76_dev *dev = phy->dev;
+
+	if (!test_bit(MT76_STATE_REGISTERED, &phy->state))
+		return;
+
+	if (IS_ENABLED(CONFIG_MT76_LEDS))
+		mt76_led_cleanup(phy);
+	mt76_tx_status_check(dev, true);
+	ieee80211_unregister_hw(phy->hw);
+	dev->phys[phy->band_idx] = NULL;
+}
+EXPORT_SYMBOL_GPL(mt76_unregister_phy);
+
+int mt76_create_page_pool(struct mt76_dev *dev, struct mt76_queue *q)
+{
+	struct page_pool_params pp_params = {
+		.order = 0,
+		.flags = PP_FLAG_PAGE_FRAG,
+		.nid = NUMA_NO_NODE,
+		.dev = dev->dma_dev,
+	};
+	int idx = q - dev->q_rx;
+
+	switch (idx) {
+	case MT_RXQ_MAIN:
+	case MT_RXQ_BAND1:
+	case MT_RXQ_BAND2:
+		pp_params.pool_size = 256;
+		break;
+	default:
+		pp_params.pool_size = 16;
+		break;
+	}
+
+	if (mt76_is_mmio(dev)) {
+		/* rely on page_pool for DMA mapping */
+		pp_params.flags |= PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+		pp_params.dma_dir = DMA_FROM_DEVICE;
+		pp_params.max_len = PAGE_SIZE;
+		pp_params.offset = 0;
+	}
+
+	q->page_pool = page_pool_create(&pp_params);
+	if (IS_ERR(q->page_pool)) {
+		int err = PTR_ERR(q->page_pool);
+
+		q->page_pool = NULL;
+		return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_create_page_pool);
+
+struct mt76_dev *
+mt76_alloc_device(struct device *pdev, unsigned int size,
+		  const struct ieee80211_ops *ops,
+		  const struct mt76_driver_ops *drv_ops)
+{
+	struct ieee80211_hw *hw;
+	struct mt76_phy *phy;
+	struct mt76_dev *dev;
+	int i;
+
+	hw = ieee80211_alloc_hw(size, ops);
+	if (!hw)
+		return NULL;
+
+	dev = hw->priv;
+	dev->hw = hw;
+	dev->dev = pdev;
+	dev->drv = drv_ops;
+	dev->dma_dev = pdev;
+
+	phy = &dev->phy;
+	phy->dev = dev;
+	phy->hw = hw;
+	phy->band_idx = MT_BAND0;
+	dev->phys[phy->band_idx] = phy;
+
+	spin_lock_init(&dev->rx_lock);
+	spin_lock_init(&dev->lock);
+	spin_lock_init(&dev->cc_lock);
+	spin_lock_init(&dev->status_lock);
+	spin_lock_init(&dev->wed_lock);
+	mutex_init(&dev->mutex);
+	init_waitqueue_head(&dev->tx_wait);
+
+	skb_queue_head_init(&dev->mcu.res_q);
+	init_waitqueue_head(&dev->mcu.wait);
+	mutex_init(&dev->mcu.mutex);
+	dev->tx_worker.fn = mt76_tx_worker;
+
+	hw->wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
+	hw->wiphy->interface_modes =
+		BIT(NL80211_IFTYPE_STATION) |
+		BIT(NL80211_IFTYPE_AP) |
+#ifdef CONFIG_MAC80211_MESH
+		BIT(NL80211_IFTYPE_MESH_POINT) |
+#endif
+		BIT(NL80211_IFTYPE_P2P_CLIENT) |
+		BIT(NL80211_IFTYPE_P2P_GO) |
+		BIT(NL80211_IFTYPE_ADHOC);
+
+	spin_lock_init(&dev->token_lock);
+	idr_init(&dev->token);
+
+	spin_lock_init(&dev->rx_token_lock);
+	idr_init(&dev->rx_token);
+
+	INIT_LIST_HEAD(&dev->wcid_list);
+	INIT_LIST_HEAD(&dev->sta_poll_list);
+	spin_lock_init(&dev->sta_poll_lock);
+
+	INIT_LIST_HEAD(&dev->txwi_cache);
+	INIT_LIST_HEAD(&dev->rxwi_cache);
+	dev->token_size = dev->drv->token_size;
+
+	for (i = 0; i < ARRAY_SIZE(dev->q_rx); i++)
+		skb_queue_head_init(&dev->rx_skb[i]);
+
+	dev->wq = alloc_ordered_workqueue("mt76", 0);
+	if (!dev->wq) {
+		ieee80211_free_hw(hw);
+		return NULL;
+	}
+
+	return dev;
+}
+EXPORT_SYMBOL_GPL(mt76_alloc_device);
+
+int mt76_register_device(struct mt76_dev *dev, bool vht,
+			 struct ieee80211_rate *rates, int n_rates)
+{
+	struct ieee80211_hw *hw = dev->hw;
+	struct mt76_phy *phy = &dev->phy;
+	int ret;
+
+	dev_set_drvdata(dev->dev, dev);
+	ret = mt76_phy_init(phy, hw);
+	if (ret)
+		return ret;
+
+	if (phy->cap.has_2ghz) {
+		ret = mt76_init_sband_2g(phy, rates, n_rates);
+		if (ret)
+			return ret;
+	}
+
+	if (phy->cap.has_5ghz) {
+		ret = mt76_init_sband_5g(phy, rates + 4, n_rates - 4, vht);
+		if (ret)
+			return ret;
+	}
+
+	if (phy->cap.has_6ghz) {
+		ret = mt76_init_sband_6g(phy, rates + 4, n_rates - 4);
+		if (ret)
+			return ret;
+	}
+
+	wiphy_read_of_freq_limits(hw->wiphy);
+	mt76_check_sband(&dev->phy, &phy->sband_2g, NL80211_BAND_2GHZ);
+	mt76_check_sband(&dev->phy, &phy->sband_5g, NL80211_BAND_5GHZ);
+	mt76_check_sband(&dev->phy, &phy->sband_6g, NL80211_BAND_6GHZ);
+
+	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
+		ret = mt76_led_init(phy);
+		if (ret)
+			return ret;
+	}
+
+	ret = ieee80211_register_hw(hw);
+	if (ret)
+		return ret;
+
+	WARN_ON(mt76_worker_setup(hw, &dev->tx_worker, NULL, "tx"));
+	set_bit(MT76_STATE_REGISTERED, &phy->state);
+	sched_set_fifo_low(dev->tx_worker.task);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_register_device);
+
+void mt76_unregister_device(struct mt76_dev *dev)
+{
+	struct ieee80211_hw *hw = dev->hw;
+
+	if (!test_bit(MT76_STATE_REGISTERED, &dev->phy.state))
+		return;
+
+	if (IS_ENABLED(CONFIG_MT76_LEDS))
+		mt76_led_cleanup(&dev->phy);
+	mt76_tx_status_check(dev, true);
+	ieee80211_unregister_hw(hw);
+}
+EXPORT_SYMBOL_GPL(mt76_unregister_device);
+
+void mt76_free_device(struct mt76_dev *dev)
+{
+	mt76_worker_teardown(&dev->tx_worker);
+	if (dev->wq) {
+		destroy_workqueue(dev->wq);
+		dev->wq = NULL;
+	}
+	ieee80211_free_hw(dev->hw);
+}
+EXPORT_SYMBOL_GPL(mt76_free_device);
+
+static void mt76_rx_release_amsdu(struct mt76_phy *phy, enum mt76_rxq_id q)
+{
+	struct sk_buff *skb = phy->rx_amsdu[q].head;
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	struct mt76_dev *dev = phy->dev;
+
+	phy->rx_amsdu[q].head = NULL;
+	phy->rx_amsdu[q].tail = NULL;
+
+	/*
+	 * Validate if the amsdu has a proper first subframe.
+	 * A single MSDU can be parsed as A-MSDU when the unauthenticated A-MSDU
+	 * flag of the QoS header gets flipped. In such cases, the first
+	 * subframe has a LLC/SNAP header in the location of the destination
+	 * address.
+	 */
+	if (skb_shinfo(skb)->frag_list) {
+		int offset = 0;
+
+		if (!(status->flag & RX_FLAG_8023)) {
+			offset = ieee80211_get_hdrlen_from_skb(skb);
+
+			if ((status->flag &
+			     (RX_FLAG_DECRYPTED | RX_FLAG_IV_STRIPPED)) ==
+			    RX_FLAG_DECRYPTED)
+				offset += 8;
+		}
+
+		if (ether_addr_equal(skb->data + offset, rfc1042_header)) {
+			dev_kfree_skb(skb);
+			return;
+		}
+	}
+	__skb_queue_tail(&dev->rx_skb[q], skb);
+}
+
+static void mt76_rx_release_burst(struct mt76_phy *phy, enum mt76_rxq_id q,
+				  struct sk_buff *skb)
+{
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+
+	if (phy->rx_amsdu[q].head &&
+	    (!status->amsdu || status->first_amsdu ||
+	     status->seqno != phy->rx_amsdu[q].seqno))
+		mt76_rx_release_amsdu(phy, q);
+
+	if (!phy->rx_amsdu[q].head) {
+		phy->rx_amsdu[q].tail = &skb_shinfo(skb)->frag_list;
+		phy->rx_amsdu[q].seqno = status->seqno;
+		phy->rx_amsdu[q].head = skb;
+	} else {
+		*phy->rx_amsdu[q].tail = skb;
+		phy->rx_amsdu[q].tail = &skb->next;
+	}
+
+	if (!status->amsdu || status->last_amsdu)
+		mt76_rx_release_amsdu(phy, q);
+}
+
+void mt76_rx(struct mt76_dev *dev, enum mt76_rxq_id q, struct sk_buff *skb)
+{
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	struct mt76_phy *phy = mt76_dev_phy(dev, status->phy_idx);
+
+	if (!test_bit(MT76_STATE_RUNNING, &phy->state)) {
+		dev_kfree_skb(skb);
+		return;
+	}
+
+#ifdef CONFIG_NL80211_TESTMODE
+	if (phy->test.state == MT76_TM_STATE_RX_FRAMES) {
+		phy->test.rx_stats.packets[q]++;
+		if (status->flag & RX_FLAG_FAILED_FCS_CRC)
+			phy->test.rx_stats.fcs_error[q]++;
+	}
+#endif
+
+	mt76_rx_release_burst(phy, q, skb);
+}
+EXPORT_SYMBOL_GPL(mt76_rx);
+
+bool mt76_has_tx_pending(struct mt76_phy *phy)
+{
+	struct mt76_queue *q;
+	int i;
+
+	for (i = 0; i < __MT_TXQ_MAX; i++) {
+		q = phy->q_tx[i];
+		if (q && q->queued)
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(mt76_has_tx_pending);
+
+static struct mt76_channel_state *
+mt76_channel_state(struct mt76_phy *phy, struct ieee80211_channel *c)
+{
+	struct mt76_sband *msband;
+	int idx;
+
+	if (c->band == NL80211_BAND_2GHZ)
+		msband = &phy->sband_2g;
+	else if (c->band == NL80211_BAND_6GHZ)
+		msband = &phy->sband_6g;
+	else
+		msband = &phy->sband_5g;
+
+	idx = c - &msband->sband.channels[0];
+	return &msband->chan[idx];
+}
+
+void mt76_update_survey_active_time(struct mt76_phy *phy, ktime_t time)
+{
+	struct mt76_channel_state *state = phy->chan_state;
+
+	state->cc_active += ktime_to_us(ktime_sub(time,
+						  phy->survey_time));
+	phy->survey_time = time;
+}
+EXPORT_SYMBOL_GPL(mt76_update_survey_active_time);
+
+void mt76_update_survey(struct mt76_phy *phy)
+{
+	struct mt76_dev *dev = phy->dev;
+	ktime_t cur_time;
+
+	if (dev->drv->update_survey)
+		dev->drv->update_survey(phy);
+
+	cur_time = ktime_get_boottime();
+	mt76_update_survey_active_time(phy, cur_time);
+
+	if (dev->drv->drv_flags & MT_DRV_SW_RX_AIRTIME) {
+		struct mt76_channel_state *state = phy->chan_state;
+
+		spin_lock_bh(&dev->cc_lock);
+		state->cc_bss_rx += dev->cur_cc_bss_rx;
+		dev->cur_cc_bss_rx = 0;
+		spin_unlock_bh(&dev->cc_lock);
+	}
+}
+EXPORT_SYMBOL_GPL(mt76_update_survey);
+
+void mt76_set_channel(struct mt76_phy *phy)
+{
+	struct mt76_dev *dev = phy->dev;
+	struct ieee80211_hw *hw = phy->hw;
+	struct cfg80211_chan_def *chandef = &hw->conf.chandef;
+	bool offchannel = hw->conf.flags & IEEE80211_CONF_OFFCHANNEL;
+	int timeout = HZ / 5;
+
+	wait_event_timeout(dev->tx_wait, !mt76_has_tx_pending(phy), timeout);
+	mt76_update_survey(phy);
+
+	if (phy->chandef.chan->center_freq != chandef->chan->center_freq ||
+	    phy->chandef.width != chandef->width)
+		phy->dfs_state = MT_DFS_STATE_UNKNOWN;
+
+	phy->chandef = *chandef;
+	phy->chan_state = mt76_channel_state(phy, chandef->chan);
+
+	if (!offchannel)
+		phy->main_chan = chandef->chan;
+
+	if (chandef->chan != phy->main_chan)
+		memset(phy->chan_state, 0, sizeof(*phy->chan_state));
+}
+EXPORT_SYMBOL_GPL(mt76_set_channel);
+
+int mt76_get_survey(struct ieee80211_hw *hw, int idx,
+		    struct survey_info *survey)
+{
+	struct mt76_phy *phy = hw->priv;
+	struct mt76_dev *dev = phy->dev;
+	struct mt76_sband *sband;
+	struct ieee80211_channel *chan;
+	struct mt76_channel_state *state;
+	int ret = 0;
+
+	mutex_lock(&dev->mutex);
+	if (idx == 0 && dev->drv->update_survey)
+		mt76_update_survey(phy);
+
+	if (idx >= phy->sband_2g.sband.n_channels +
+		   phy->sband_5g.sband.n_channels) {
+		idx -= (phy->sband_2g.sband.n_channels +
+			phy->sband_5g.sband.n_channels);
+		sband = &phy->sband_6g;
+	} else if (idx >= phy->sband_2g.sband.n_channels) {
+		idx -= phy->sband_2g.sband.n_channels;
+		sband = &phy->sband_5g;
+	} else {
+		sband = &phy->sband_2g;
+	}
+
+	if (idx >= sband->sband.n_channels) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	chan = &sband->sband.channels[idx];
+	state = mt76_channel_state(phy, chan);
+
+	memset(survey, 0, sizeof(*survey));
+	survey->channel = chan;
+	survey->filled = SURVEY_INFO_TIME | SURVEY_INFO_TIME_BUSY;
+	survey->filled |= dev->drv->survey_flags;
+	if (state->noise)
+		survey->filled |= SURVEY_INFO_NOISE_DBM;
+
+	if (chan == phy->main_chan) {
+		survey->filled |= SURVEY_INFO_IN_USE;
+
+		if (dev->drv->drv_flags & MT_DRV_SW_RX_AIRTIME)
+			survey->filled |= SURVEY_INFO_TIME_BSS_RX;
+	}
+
+	survey->time_busy = div_u64(state->cc_busy, 1000);
+	survey->time_rx = div_u64(state->cc_rx, 1000);
+	survey->time = div_u64(state->cc_active, 1000);
+	survey->noise = state->noise;
+
+	spin_lock_bh(&dev->cc_lock);
+	survey->time_bss_rx = div_u64(state->cc_bss_rx, 1000);
+	survey->time_tx = div_u64(state->cc_tx, 1000);
+	spin_unlock_bh(&dev->cc_lock);
+
+out:
+	mutex_unlock(&dev->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt76_get_survey);
+
+void mt76_wcid_key_setup(struct mt76_dev *dev, struct mt76_wcid *wcid,
+			 struct ieee80211_key_conf *key)
+{
+	struct ieee80211_key_seq seq;
+	int i;
+
+	wcid->rx_check_pn = false;
+
+	if (!key)
+		return;
+
+	if (key->cipher != WLAN_CIPHER_SUITE_CCMP)
+		return;
+
+	wcid->rx_check_pn = true;
+
+	/* data frame */
+	for (i = 0; i < IEEE80211_NUM_TIDS; i++) {
+		ieee80211_get_key_rx_seq(key, i, &seq);
+		memcpy(wcid->rx_key_pn[i], seq.ccmp.pn, sizeof(seq.ccmp.pn));
+	}
+
+	/* robust management frame */
+	ieee80211_get_key_rx_seq(key, -1, &seq);
+	memcpy(wcid->rx_key_pn[i], seq.ccmp.pn, sizeof(seq.ccmp.pn));
+
+}
+EXPORT_SYMBOL(mt76_wcid_key_setup);
+
+int mt76_rx_signal(u8 chain_mask, s8 *chain_signal)
+{
+	int signal = -128;
+	u8 chains;
+
+	for (chains = chain_mask; chains; chains >>= 1, chain_signal++) {
+		int cur, diff;
+
+		cur = *chain_signal;
+		if (!(chains & BIT(0)) ||
+		    cur > 0)
+			continue;
+
+		if (cur > signal)
+			swap(cur, signal);
+
+		diff = signal - cur;
+		if (diff == 0)
+			signal += 3;
+		else if (diff <= 2)
+			signal += 2;
+		else if (diff <= 6)
+			signal += 1;
+	}
+
+	return signal;
+}
+EXPORT_SYMBOL(mt76_rx_signal);
+
+static void
+mt76_rx_convert(struct mt76_dev *dev, struct sk_buff *skb,
+		struct ieee80211_hw **hw,
+		struct ieee80211_sta **sta)
+{
+	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
+	struct ieee80211_hdr *hdr = mt76_skb_get_hdr(skb);
+	struct mt76_rx_status mstat;
+
+	mstat = *((struct mt76_rx_status *)skb->cb);
+	memset(status, 0, sizeof(*status));
+
+	status->flag = mstat.flag;
+	status->freq = mstat.freq;
+	status->enc_flags = mstat.enc_flags;
+	status->encoding = mstat.encoding;
+	status->bw = mstat.bw;
+	if (status->encoding == RX_ENC_EHT) {
+		status->eht.ru = mstat.eht.ru;
+		status->eht.gi = mstat.eht.gi;
+	} else {
+		status->he_ru = mstat.he_ru;
+		status->he_gi = mstat.he_gi;
+		status->he_dcm = mstat.he_dcm;
+	}
+	status->rate_idx = mstat.rate_idx;
+	status->nss = mstat.nss;
+	status->band = mstat.band;
+	status->signal = mstat.signal;
+	status->chains = mstat.chains;
+	status->ampdu_reference = mstat.ampdu_ref;
+	status->device_timestamp = mstat.timestamp;
+	status->mactime = mstat.timestamp;
+	status->signal = mt76_rx_signal(mstat.chains, mstat.chain_signal);
+	if (status->signal <= -128)
+		status->flag |= RX_FLAG_NO_SIGNAL_VAL;
+
+	if (ieee80211_is_beacon(hdr->frame_control) ||
+	    ieee80211_is_probe_resp(hdr->frame_control))
+		status->boottime_ns = ktime_get_boottime_ns();
+
+	BUILD_BUG_ON(sizeof(mstat) > sizeof(skb->cb));
+	BUILD_BUG_ON(sizeof(status->chain_signal) !=
+		     sizeof(mstat.chain_signal));
+	memcpy(status->chain_signal, mstat.chain_signal,
+	       sizeof(mstat.chain_signal));
+
+	*sta = wcid_to_sta(mstat.wcid);
+	*hw = mt76_phy_hw(dev, mstat.phy_idx);
+}
+
+static void
+mt76_check_ccmp_pn(struct sk_buff *skb)
+{
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	struct mt76_wcid *wcid = status->wcid;
+	struct ieee80211_hdr *hdr;
+	int security_idx;
+	int ret;
+
+	if (!(status->flag & RX_FLAG_DECRYPTED))
+		return;
+
+	if (status->flag & RX_FLAG_ONLY_MONITOR)
+		return;
+
+	if (!wcid || !wcid->rx_check_pn)
+		return;
+
+	security_idx = status->qos_ctl & IEEE80211_QOS_CTL_TID_MASK;
+	if (status->flag & RX_FLAG_8023)
+		goto skip_hdr_check;
+
+	hdr = mt76_skb_get_hdr(skb);
+	if (!(status->flag & RX_FLAG_IV_STRIPPED)) {
+		/*
+		 * Validate the first fragment both here and in mac80211
+		 * All further fragments will be validated by mac80211 only.
+		 */
+		if (ieee80211_is_frag(hdr) &&
+		    !ieee80211_is_first_frag(hdr->frame_control))
+			return;
+	}
+
+	/* IEEE 802.11-2020, 12.5.3.4.4 "PN and replay detection" c):
+	 *
+	 * the recipient shall maintain a single replay counter for received
+	 * individually addressed robust Management frames that are received
+	 * with the To DS subfield equal to 0, [...]
+	 */
+	if (ieee80211_is_mgmt(hdr->frame_control) &&
+	    !ieee80211_has_tods(hdr->frame_control))
+		security_idx = IEEE80211_NUM_TIDS;
+
+skip_hdr_check:
+	BUILD_BUG_ON(sizeof(status->iv) != sizeof(wcid->rx_key_pn[0]));
+	ret = memcmp(status->iv, wcid->rx_key_pn[security_idx],
+		     sizeof(status->iv));
+	if (ret <= 0) {
+		status->flag |= RX_FLAG_ONLY_MONITOR;
+		return;
+	}
+
+	memcpy(wcid->rx_key_pn[security_idx], status->iv, sizeof(status->iv));
+
+	if (status->flag & RX_FLAG_IV_STRIPPED)
+		status->flag |= RX_FLAG_PN_VALIDATED;
+}
+
+static void
+mt76_airtime_report(struct mt76_dev *dev, struct mt76_rx_status *status,
+		    int len)
+{
+	struct mt76_wcid *wcid = status->wcid;
+	struct ieee80211_rx_status info = {
+		.enc_flags = status->enc_flags,
+		.rate_idx = status->rate_idx,
+		.encoding = status->encoding,
+		.band = status->band,
+		.nss = status->nss,
+		.bw = status->bw,
+	};
+	struct ieee80211_sta *sta;
+	u32 airtime;
+	u8 tidno = status->qos_ctl & IEEE80211_QOS_CTL_TID_MASK;
+
+	airtime = ieee80211_calc_rx_airtime(dev->hw, &info, len);
+	spin_lock(&dev->cc_lock);
+	dev->cur_cc_bss_rx += airtime;
+	spin_unlock(&dev->cc_lock);
+
+	if (!wcid || !wcid->sta)
+		return;
+
+	sta = container_of((void *)wcid, struct ieee80211_sta, drv_priv);
+	ieee80211_sta_register_airtime(sta, tidno, 0, airtime);
+}
+
+static void
+mt76_airtime_flush_ampdu(struct mt76_dev *dev)
+{
+	struct mt76_wcid *wcid;
+	int wcid_idx;
+
+	if (!dev->rx_ampdu_len)
+		return;
+
+	wcid_idx = dev->rx_ampdu_status.wcid_idx;
+	if (wcid_idx < ARRAY_SIZE(dev->wcid))
+		wcid = rcu_dereference(dev->wcid[wcid_idx]);
+	else
+		wcid = NULL;
+	dev->rx_ampdu_status.wcid = wcid;
+
+	mt76_airtime_report(dev, &dev->rx_ampdu_status, dev->rx_ampdu_len);
+
+	dev->rx_ampdu_len = 0;
+	dev->rx_ampdu_ref = 0;
+}
+
+static void
+mt76_airtime_check(struct mt76_dev *dev, struct sk_buff *skb)
+{
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	struct mt76_wcid *wcid = status->wcid;
+
+	if (!(dev->drv->drv_flags & MT_DRV_SW_RX_AIRTIME))
+		return;
+
+	if (!wcid || !wcid->sta) {
+		struct ieee80211_hdr *hdr = mt76_skb_get_hdr(skb);
+
+		if (status->flag & RX_FLAG_8023)
+			return;
+
+		if (!ether_addr_equal(hdr->addr1, dev->phy.macaddr))
+			return;
+
+		wcid = NULL;
+	}
+
+	if (!(status->flag & RX_FLAG_AMPDU_DETAILS) ||
+	    status->ampdu_ref != dev->rx_ampdu_ref)
+		mt76_airtime_flush_ampdu(dev);
+
+	if (status->flag & RX_FLAG_AMPDU_DETAILS) {
+		if (!dev->rx_ampdu_len ||
+		    status->ampdu_ref != dev->rx_ampdu_ref) {
+			dev->rx_ampdu_status = *status;
+			dev->rx_ampdu_status.wcid_idx = wcid ? wcid->idx : 0xff;
+			dev->rx_ampdu_ref = status->ampdu_ref;
+		}
+
+		dev->rx_ampdu_len += skb->len;
+		return;
+	}
+
+	mt76_airtime_report(dev, status, skb->len);
+}
+
+static void
+mt76_check_sta(struct mt76_dev *dev, struct sk_buff *skb)
+{
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	struct ieee80211_hdr *hdr = mt76_skb_get_hdr(skb);
+	struct ieee80211_sta *sta;
+	struct ieee80211_hw *hw;
+	struct mt76_wcid *wcid = status->wcid;
+	u8 tidno = status->qos_ctl & IEEE80211_QOS_CTL_TID_MASK;
+	bool ps;
+
+	hw = mt76_phy_hw(dev, status->phy_idx);
+	if (ieee80211_is_pspoll(hdr->frame_control) && !wcid &&
+	    !(status->flag & RX_FLAG_8023)) {
+		sta = ieee80211_find_sta_by_ifaddr(hw, hdr->addr2, NULL);
+		if (sta)
+			wcid = status->wcid = (struct mt76_wcid *)sta->drv_priv;
+	}
+
+	mt76_airtime_check(dev, skb);
+
+	if (!wcid || !wcid->sta)
+		return;
+
+	sta = container_of((void *)wcid, struct ieee80211_sta, drv_priv);
+
+	if (status->signal <= 0)
+		ewma_signal_add(&wcid->rssi, -status->signal);
+
+	wcid->inactive_count = 0;
+
+	if (status->flag & RX_FLAG_8023)
+		return;
+
+	if (!test_bit(MT_WCID_FLAG_CHECK_PS, &wcid->flags))
+		return;
+
+	if (ieee80211_is_pspoll(hdr->frame_control)) {
+		ieee80211_sta_pspoll(sta);
+		return;
+	}
+
+	if (ieee80211_has_morefrags(hdr->frame_control) ||
+	    !(ieee80211_is_mgmt(hdr->frame_control) ||
+	      ieee80211_is_data(hdr->frame_control)))
+		return;
+
+	ps = ieee80211_has_pm(hdr->frame_control);
+
+	if (ps && (ieee80211_is_data_qos(hdr->frame_control) ||
+		   ieee80211_is_qos_nullfunc(hdr->frame_control)))
+		ieee80211_sta_uapsd_trigger(sta, tidno);
+
+	if (!!test_bit(MT_WCID_FLAG_PS, &wcid->flags) == ps)
+		return;
+
+	if (ps)
+		set_bit(MT_WCID_FLAG_PS, &wcid->flags);
+
+	if (dev->drv->sta_ps)
+		dev->drv->sta_ps(dev, sta, ps);
+
+	if (!ps)
+		clear_bit(MT_WCID_FLAG_PS, &wcid->flags);
+
+	ieee80211_sta_ps_transition(sta, ps);
+}
+
+void mt76_rx_complete(struct mt76_dev *dev, struct sk_buff_head *frames,
+		      struct napi_struct *napi)
+{
+	struct ieee80211_sta *sta;
+	struct ieee80211_hw *hw;
+	struct sk_buff *skb, *tmp;
+	LIST_HEAD(list);
+
+	spin_lock(&dev->rx_lock);
+	while ((skb = __skb_dequeue(frames)) != NULL) {
+		struct sk_buff *nskb = skb_shinfo(skb)->frag_list;
+
+		mt76_check_ccmp_pn(skb);
+		skb_shinfo(skb)->frag_list = NULL;
+		mt76_rx_convert(dev, skb, &hw, &sta);
+		ieee80211_rx_list(hw, sta, skb, &list);
+
+		/* subsequent amsdu frames */
+		while (nskb) {
+			skb = nskb;
+			nskb = nskb->next;
+			skb->next = NULL;
+
+			mt76_rx_convert(dev, skb, &hw, &sta);
+			ieee80211_rx_list(hw, sta, skb, &list);
+		}
+	}
+	spin_unlock(&dev->rx_lock);
+
+	if (!napi) {
+		netif_receive_skb_list(&list);
+		return;
+	}
+
+	list_for_each_entry_safe(skb, tmp, &list, list) {
+		skb_list_del_init(skb);
+		napi_gro_receive(napi, skb);
+	}
+}
+
+void mt76_rx_poll_complete(struct mt76_dev *dev, enum mt76_rxq_id q,
+			   struct napi_struct *napi)
+{
+	struct sk_buff_head frames;
+	struct sk_buff *skb;
+
+	__skb_queue_head_init(&frames);
+
+	while ((skb = __skb_dequeue(&dev->rx_skb[q])) != NULL) {
+		mt76_check_sta(dev, skb);
+		if (mtk_wed_device_active(&dev->mmio.wed))
+			__skb_queue_tail(&frames, skb);
+		else
+			mt76_rx_aggr_reorder(skb, &frames);
+	}
+
+	mt76_rx_complete(dev, &frames, napi);
+}
+EXPORT_SYMBOL_GPL(mt76_rx_poll_complete);
+
+static int
+mt76_sta_add(struct mt76_phy *phy, struct ieee80211_vif *vif,
+	     struct ieee80211_sta *sta)
+{
+	struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
+	struct mt76_dev *dev = phy->dev;
+	int ret;
+	int i;
+
+	mutex_lock(&dev->mutex);
+
+	ret = dev->drv->sta_add(dev, vif, sta);
+	if (ret)
+		goto out;
+
+	for (i = 0; i < ARRAY_SIZE(sta->txq); i++) {
+		struct mt76_txq *mtxq;
+
+		if (!sta->txq[i])
+			continue;
+
+		mtxq = (struct mt76_txq *)sta->txq[i]->drv_priv;
+		mtxq->wcid = wcid->idx;
+	}
+
+	ewma_signal_init(&wcid->rssi);
+	if (phy->band_idx == MT_BAND1)
+		mt76_wcid_mask_set(dev->wcid_phy_mask, wcid->idx);
+	wcid->phy_idx = phy->band_idx;
+	rcu_assign_pointer(dev->wcid[wcid->idx], wcid);
+
+	mt76_packet_id_init(wcid);
+out:
+	mutex_unlock(&dev->mutex);
+
+	return ret;
+}
+
+void __mt76_sta_remove(struct mt76_dev *dev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta)
+{
+	struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
+	int i, idx = wcid->idx;
+
+	for (i = 0; i < ARRAY_SIZE(wcid->aggr); i++)
+		mt76_rx_aggr_stop(dev, wcid, i);
+
+	if (dev->drv->sta_remove)
+		dev->drv->sta_remove(dev, vif, sta);
+
+	mt76_packet_id_flush(dev, wcid);
+
+	mt76_wcid_mask_clear(dev->wcid_mask, idx);
+	mt76_wcid_mask_clear(dev->wcid_phy_mask, idx);
+}
+EXPORT_SYMBOL_GPL(__mt76_sta_remove);
+
+static void
+mt76_sta_remove(struct mt76_dev *dev, struct ieee80211_vif *vif,
+		struct ieee80211_sta *sta)
+{
+	mutex_lock(&dev->mutex);
+	__mt76_sta_remove(dev, vif, sta);
+	mutex_unlock(&dev->mutex);
+}
+
+int mt76_sta_state(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		   struct ieee80211_sta *sta,
+		   enum ieee80211_sta_state old_state,
+		   enum ieee80211_sta_state new_state)
+{
+	struct mt76_phy *phy = hw->priv;
+	struct mt76_dev *dev = phy->dev;
+
+	if (old_state == IEEE80211_STA_NOTEXIST &&
+	    new_state == IEEE80211_STA_NONE)
+		return mt76_sta_add(phy, vif, sta);
+
+	if (old_state == IEEE80211_STA_AUTH &&
+	    new_state == IEEE80211_STA_ASSOC &&
+	    dev->drv->sta_assoc)
+		dev->drv->sta_assoc(dev, vif, sta);
+
+	if (old_state == IEEE80211_STA_NONE &&
+	    new_state == IEEE80211_STA_NOTEXIST)
+		mt76_sta_remove(dev, vif, sta);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_sta_state);
+
+void mt76_sta_pre_rcu_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			     struct ieee80211_sta *sta)
+{
+	struct mt76_phy *phy = hw->priv;
+	struct mt76_dev *dev = phy->dev;
+	struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
+
+	mutex_lock(&dev->mutex);
+	spin_lock_bh(&dev->status_lock);
+	rcu_assign_pointer(dev->wcid[wcid->idx], NULL);
+	spin_unlock_bh(&dev->status_lock);
+	mutex_unlock(&dev->mutex);
+}
+EXPORT_SYMBOL_GPL(mt76_sta_pre_rcu_remove);
+
+int mt76_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		     int *dbm)
+{
+	struct mt76_phy *phy = hw->priv;
+	int n_chains = hweight8(phy->antenna_mask);
+	int delta = mt76_tx_power_nss_delta(n_chains);
+
+	*dbm = DIV_ROUND_UP(phy->txpower_cur + delta, 2);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_get_txpower);
+
+int mt76_init_sar_power(struct ieee80211_hw *hw,
+			const struct cfg80211_sar_specs *sar)
+{
+	struct mt76_phy *phy = hw->priv;
+	const struct cfg80211_sar_capa *capa = hw->wiphy->sar_capa;
+	int i;
+
+	if (sar->type != NL80211_SAR_TYPE_POWER || !sar->num_sub_specs)
+		return -EINVAL;
+
+	for (i = 0; i < sar->num_sub_specs; i++) {
+		u32 index = sar->sub_specs[i].freq_range_index;
+		/* SAR specifies power limitaton in 0.25dbm */
+		s32 power = sar->sub_specs[i].power >> 1;
+
+		if (power > 127 || power < -127)
+			power = 127;
+
+		phy->frp[index].range = &capa->freq_ranges[index];
+		phy->frp[index].power = power;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_init_sar_power);
+
+int mt76_get_sar_power(struct mt76_phy *phy,
+		       struct ieee80211_channel *chan,
+		       int power)
+{
+	const struct cfg80211_sar_capa *capa = phy->hw->wiphy->sar_capa;
+	int freq, i;
+
+	if (!capa || !phy->frp)
+		return power;
+
+	if (power > 127 || power < -127)
+		power = 127;
+
+	freq = ieee80211_channel_to_frequency(chan->hw_value, chan->band);
+	for (i = 0 ; i < capa->num_freq_ranges; i++) {
+		if (phy->frp[i].range &&
+		    freq >= phy->frp[i].range->start_freq &&
+		    freq < phy->frp[i].range->end_freq) {
+			power = min_t(int, phy->frp[i].power, power);
+			break;
+		}
+	}
+
+	return power;
+}
+EXPORT_SYMBOL_GPL(mt76_get_sar_power);
+
+static void
+__mt76_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	if (vif->bss_conf.csa_active && ieee80211_beacon_cntdwn_is_complete(vif))
+		ieee80211_csa_finish(vif);
+}
+
+void mt76_csa_finish(struct mt76_dev *dev)
+{
+	if (!dev->csa_complete)
+		return;
+
+	ieee80211_iterate_active_interfaces_atomic(dev->hw,
+		IEEE80211_IFACE_ITER_RESUME_ALL,
+		__mt76_csa_finish, dev);
+
+	dev->csa_complete = 0;
+}
+EXPORT_SYMBOL_GPL(mt76_csa_finish);
+
+static void
+__mt76_csa_check(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct mt76_dev *dev = priv;
+
+	if (!vif->bss_conf.csa_active)
+		return;
+
+	dev->csa_complete |= ieee80211_beacon_cntdwn_is_complete(vif);
+}
+
+void mt76_csa_check(struct mt76_dev *dev)
+{
+	ieee80211_iterate_active_interfaces_atomic(dev->hw,
+		IEEE80211_IFACE_ITER_RESUME_ALL,
+		__mt76_csa_check, dev);
+}
+EXPORT_SYMBOL_GPL(mt76_csa_check);
+
+int
+mt76_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta, bool set)
+{
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_set_tim);
+
+void mt76_insert_ccmp_hdr(struct sk_buff *skb, u8 key_id)
+{
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	int hdr_len = ieee80211_get_hdrlen_from_skb(skb);
+	u8 *hdr, *pn = status->iv;
+
+	__skb_push(skb, 8);
+	memmove(skb->data, skb->data + 8, hdr_len);
+	hdr = skb->data + hdr_len;
+
+	hdr[0] = pn[5];
+	hdr[1] = pn[4];
+	hdr[2] = 0;
+	hdr[3] = 0x20 | (key_id << 6);
+	hdr[4] = pn[3];
+	hdr[5] = pn[2];
+	hdr[6] = pn[1];
+	hdr[7] = pn[0];
+
+	status->flag &= ~RX_FLAG_IV_STRIPPED;
+}
+EXPORT_SYMBOL_GPL(mt76_insert_ccmp_hdr);
+
+int mt76_get_rate(struct mt76_dev *dev,
+		  struct ieee80211_supported_band *sband,
+		  int idx, bool cck)
+{
+	int i, offset = 0, len = sband->n_bitrates;
+
+	if (cck) {
+		if (sband != &dev->phy.sband_2g.sband)
+			return 0;
+
+		idx &= ~BIT(2); /* short preamble */
+	} else if (sband == &dev->phy.sband_2g.sband) {
+		offset = 4;
+	}
+
+	for (i = offset; i < len; i++) {
+		if ((sband->bitrates[i].hw_value & GENMASK(7, 0)) == idx)
+			return i;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_get_rate);
+
+void mt76_sw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		  const u8 *mac)
+{
+	struct mt76_phy *phy = hw->priv;
+
+	set_bit(MT76_SCANNING, &phy->state);
+}
+EXPORT_SYMBOL_GPL(mt76_sw_scan);
+
+void mt76_sw_scan_complete(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct mt76_phy *phy = hw->priv;
+
+	clear_bit(MT76_SCANNING, &phy->state);
+}
+EXPORT_SYMBOL_GPL(mt76_sw_scan_complete);
+
+int mt76_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
+{
+	struct mt76_phy *phy = hw->priv;
+	struct mt76_dev *dev = phy->dev;
+
+	mutex_lock(&dev->mutex);
+	*tx_ant = phy->antenna_mask;
+	*rx_ant = phy->antenna_mask;
+	mutex_unlock(&dev->mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_get_antenna);
+
+struct mt76_queue *
+mt76_init_queue(struct mt76_dev *dev, int qid, int idx, int n_desc,
+		int ring_base, u32 flags)
+{
+	struct mt76_queue *hwq;
+	int err;
+
+	hwq = devm_kzalloc(dev->dev, sizeof(*hwq), GFP_KERNEL);
+	if (!hwq)
+		return ERR_PTR(-ENOMEM);
+
+	hwq->flags = flags;
+
+	err = dev->queue_ops->alloc(dev, hwq, idx, n_desc, 0, ring_base);
+	if (err < 0)
+		return ERR_PTR(err);
+
+	return hwq;
+}
+EXPORT_SYMBOL_GPL(mt76_init_queue);
+
+u16 mt76_calculate_default_rate(struct mt76_phy *phy, int rateidx)
+{
+	int offset = 0;
+
+	if (phy->chandef.chan->band != NL80211_BAND_2GHZ)
+		offset = 4;
+
+	/* pick the lowest rate for hidden nodes */
+	if (rateidx < 0)
+		rateidx = 0;
+
+	rateidx += offset;
+	if (rateidx >= ARRAY_SIZE(mt76_rates))
+		rateidx = offset;
+
+	return mt76_rates[rateidx].hw_value;
+}
+EXPORT_SYMBOL_GPL(mt76_calculate_default_rate);
+
+void mt76_ethtool_worker(struct mt76_ethtool_worker_info *wi,
+			 struct mt76_sta_stats *stats, bool eht)
+{
+	int i, ei = wi->initial_stat_idx;
+	u64 *data = wi->data;
+
+	wi->sta_count++;
+
+	data[ei++] += stats->tx_mode[MT_PHY_TYPE_CCK];
+	data[ei++] += stats->tx_mode[MT_PHY_TYPE_OFDM];
+	data[ei++] += stats->tx_mode[MT_PHY_TYPE_HT];
+	data[ei++] += stats->tx_mode[MT_PHY_TYPE_HT_GF];
+	data[ei++] += stats->tx_mode[MT_PHY_TYPE_VHT];
+	data[ei++] += stats->tx_mode[MT_PHY_TYPE_HE_SU];
+	data[ei++] += stats->tx_mode[MT_PHY_TYPE_HE_EXT_SU];
+	data[ei++] += stats->tx_mode[MT_PHY_TYPE_HE_TB];
+	data[ei++] += stats->tx_mode[MT_PHY_TYPE_HE_MU];
+	if (eht) {
+		data[ei++] += stats->tx_mode[MT_PHY_TYPE_EHT_SU];
+		data[ei++] += stats->tx_mode[MT_PHY_TYPE_EHT_TRIG];
+		data[ei++] += stats->tx_mode[MT_PHY_TYPE_EHT_MU];
+	}
+
+	for (i = 0; i < (ARRAY_SIZE(stats->tx_bw) - !eht); i++)
+		data[ei++] += stats->tx_bw[i];
+
+	for (i = 0; i < (eht ? 14 : 12); i++)
+		data[ei++] += stats->tx_mcs[i];
+
+	for (i = 0; i < 4; i++)
+		data[ei++] += stats->tx_nss[i];
+
+	wi->worker_stat_count = ei - wi->initial_stat_idx;
+}
+EXPORT_SYMBOL_GPL(mt76_ethtool_worker);
+
+void mt76_ethtool_page_pool_stats(struct mt76_dev *dev, u64 *data, int *index)
+{
+#ifdef CONFIG_PAGE_POOL_STATS
+	struct page_pool_stats stats = {};
+	int i;
+
+	mt76_for_each_q_rx(dev, i)
+		page_pool_get_stats(dev->q_rx[i].page_pool, &stats);
+
+	page_pool_ethtool_stats_get(data, &stats);
+	*index += page_pool_ethtool_stats_get_count();
+#endif
+}
+EXPORT_SYMBOL_GPL(mt76_ethtool_page_pool_stats);
+
+enum mt76_dfs_state mt76_phy_dfs_state(struct mt76_phy *phy)
+{
+	struct ieee80211_hw *hw = phy->hw;
+	struct mt76_dev *dev = phy->dev;
+
+	if (dev->region == NL80211_DFS_UNSET ||
+	    test_bit(MT76_SCANNING, &phy->state))
+		return MT_DFS_STATE_DISABLED;
+
+	if (!hw->conf.radar_enabled) {
+		if ((hw->conf.flags & IEEE80211_CONF_MONITOR) &&
+		    (phy->chandef.chan->flags & IEEE80211_CHAN_RADAR))
+			return MT_DFS_STATE_ACTIVE;
+
+		return MT_DFS_STATE_DISABLED;
+	}
+
+	if (!cfg80211_reg_can_beacon(hw->wiphy, &phy->chandef, NL80211_IFTYPE_AP))
+		return MT_DFS_STATE_CAC;
+
+	return MT_DFS_STATE_ACTIVE;
+}
+EXPORT_SYMBOL_GPL(mt76_phy_dfs_state);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 132148f7b107..05651efb549e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -769,6 +769,7 @@ struct mt76_testmode_data {
 
 struct mt76_vif_link {
 	u8 idx;
+	u8 link_idx;
 	u8 omac_idx;
 	u8 band_idx;
 	u8 wmm_idx;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h.orig b/drivers/net/wireless/mediatek/mt76/mt76.h.orig
new file mode 100644
index 000000000000..132148f7b107
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h.orig
@@ -0,0 +1,1876 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
+ */
+
+#ifndef __MT76_H
+#define __MT76_H
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/spinlock.h>
+#include <linux/skbuff.h>
+#include <linux/leds.h>
+#include <linux/usb.h>
+#include <linux/average.h>
+#include <linux/soc/mediatek/mtk_wed.h>
+#include <net/mac80211.h>
+#include <net/page_pool/helpers.h>
+#include "util.h"
+#include "testmode.h"
+
+#define MT_MCU_RING_SIZE	32
+#define MT_RX_BUF_SIZE		2048
+#define MT_SKB_HEAD_LEN		256
+
+#define MT_MAX_NON_AQL_PKT	16
+#define MT_TXQ_FREE_THR		32
+
+#define MT76_TOKEN_FREE_THR	64
+
+#define MT_QFLAG_WED_RING	GENMASK(1, 0)
+#define MT_QFLAG_WED_TYPE	GENMASK(4, 2)
+#define MT_QFLAG_WED		BIT(5)
+#define MT_QFLAG_WED_RRO	BIT(6)
+#define MT_QFLAG_WED_RRO_EN	BIT(7)
+
+#define __MT_WED_Q(_type, _n)	(MT_QFLAG_WED | \
+				 FIELD_PREP(MT_QFLAG_WED_TYPE, _type) | \
+				 FIELD_PREP(MT_QFLAG_WED_RING, _n))
+#define __MT_WED_RRO_Q(_type, _n)	(MT_QFLAG_WED_RRO | __MT_WED_Q(_type, _n))
+
+#define MT_WED_Q_TX(_n)		__MT_WED_Q(MT76_WED_Q_TX, _n)
+#define MT_WED_Q_RX(_n)		__MT_WED_Q(MT76_WED_Q_RX, _n)
+#define MT_WED_Q_TXFREE		__MT_WED_Q(MT76_WED_Q_TXFREE, 0)
+#define MT_WED_RRO_Q_DATA(_n)	__MT_WED_RRO_Q(MT76_WED_RRO_Q_DATA, _n)
+#define MT_WED_RRO_Q_MSDU_PG(_n)	__MT_WED_RRO_Q(MT76_WED_RRO_Q_MSDU_PG, _n)
+#define MT_WED_RRO_Q_IND	__MT_WED_RRO_Q(MT76_WED_RRO_Q_IND, 0)
+
+struct mt76_dev;
+struct mt76_phy;
+struct mt76_wcid;
+struct mt76s_intr;
+struct mt76_chanctx;
+struct mt76_vif_link;
+
+struct mt76_reg_pair {
+	u32 reg;
+	u32 value;
+};
+
+enum mt76_bus_type {
+	MT76_BUS_MMIO,
+	MT76_BUS_USB,
+	MT76_BUS_SDIO,
+};
+
+enum mt76_wed_type {
+	MT76_WED_Q_TX,
+	MT76_WED_Q_TXFREE,
+	MT76_WED_Q_RX,
+	MT76_WED_RRO_Q_DATA,
+	MT76_WED_RRO_Q_MSDU_PG,
+	MT76_WED_RRO_Q_IND,
+};
+
+struct mt76_bus_ops {
+	u32 (*rr)(struct mt76_dev *dev, u32 offset);
+	void (*wr)(struct mt76_dev *dev, u32 offset, u32 val);
+	u32 (*rmw)(struct mt76_dev *dev, u32 offset, u32 mask, u32 val);
+	void (*write_copy)(struct mt76_dev *dev, u32 offset, const void *data,
+			   int len);
+	void (*read_copy)(struct mt76_dev *dev, u32 offset, void *data,
+			  int len);
+	int (*wr_rp)(struct mt76_dev *dev, u32 base,
+		     const struct mt76_reg_pair *rp, int len);
+	int (*rd_rp)(struct mt76_dev *dev, u32 base,
+		     struct mt76_reg_pair *rp, int len);
+	enum mt76_bus_type type;
+};
+
+#define mt76_is_usb(dev) ((dev)->bus->type == MT76_BUS_USB)
+#define mt76_is_mmio(dev) ((dev)->bus->type == MT76_BUS_MMIO)
+#define mt76_is_sdio(dev) ((dev)->bus->type == MT76_BUS_SDIO)
+
+enum mt76_txq_id {
+	MT_TXQ_VO = IEEE80211_AC_VO,
+	MT_TXQ_VI = IEEE80211_AC_VI,
+	MT_TXQ_BE = IEEE80211_AC_BE,
+	MT_TXQ_BK = IEEE80211_AC_BK,
+	MT_TXQ_PSD,
+	MT_TXQ_BEACON,
+	MT_TXQ_CAB,
+	__MT_TXQ_MAX
+};
+
+enum mt76_mcuq_id {
+	MT_MCUQ_WM,
+	MT_MCUQ_WA,
+	MT_MCUQ_FWDL,
+	__MT_MCUQ_MAX
+};
+
+enum mt76_rxq_id {
+	MT_RXQ_MAIN,
+	MT_RXQ_MCU,
+	MT_RXQ_MCU_WA,
+	MT_RXQ_BAND1,
+	MT_RXQ_BAND1_WA,
+	MT_RXQ_MAIN_WA,
+	MT_RXQ_BAND2,
+	MT_RXQ_BAND2_WA,
+	MT_RXQ_RRO_BAND0,
+	MT_RXQ_RRO_BAND1,
+	MT_RXQ_RRO_BAND2,
+	MT_RXQ_MSDU_PAGE_BAND0,
+	MT_RXQ_MSDU_PAGE_BAND1,
+	MT_RXQ_MSDU_PAGE_BAND2,
+	MT_RXQ_TXFREE_BAND0,
+	MT_RXQ_TXFREE_BAND1,
+	MT_RXQ_TXFREE_BAND2,
+	MT_RXQ_RRO_IND,
+	__MT_RXQ_MAX
+};
+
+enum mt76_band_id {
+	MT_BAND0,
+	MT_BAND1,
+	MT_BAND2,
+	__MT_MAX_BAND
+};
+
+enum mt76_cipher_type {
+	MT_CIPHER_NONE,
+	MT_CIPHER_WEP40,
+	MT_CIPHER_TKIP,
+	MT_CIPHER_TKIP_NO_MIC,
+	MT_CIPHER_AES_CCMP,
+	MT_CIPHER_WEP104,
+	MT_CIPHER_BIP_CMAC_128,
+	MT_CIPHER_WEP128,
+	MT_CIPHER_WAPI,
+	MT_CIPHER_CCMP_CCX,
+	MT_CIPHER_CCMP_256,
+	MT_CIPHER_GCMP,
+	MT_CIPHER_GCMP_256,
+};
+
+enum mt76_dfs_state {
+	MT_DFS_STATE_UNKNOWN,
+	MT_DFS_STATE_DISABLED,
+	MT_DFS_STATE_CAC,
+	MT_DFS_STATE_ACTIVE,
+};
+
+struct mt76_queue_buf {
+	dma_addr_t addr;
+	u16 len:15,
+	    skip_unmap:1;
+};
+
+struct mt76_tx_info {
+	struct mt76_queue_buf buf[32];
+	struct sk_buff *skb;
+	int nbuf;
+	u32 info;
+};
+
+struct mt76_queue_entry {
+	union {
+		void *buf;
+		struct sk_buff *skb;
+	};
+	union {
+		struct mt76_txwi_cache *txwi;
+		struct urb *urb;
+		int buf_sz;
+	};
+	dma_addr_t dma_addr[2];
+	u16 dma_len[2];
+	u16 wcid;
+	bool skip_buf0:1;
+	bool skip_buf1:1;
+	bool done:1;
+};
+
+struct mt76_queue_regs {
+	u32 desc_base;
+	u32 ring_size;
+	u32 cpu_idx;
+	u32 dma_idx;
+} __packed __aligned(4);
+
+struct mt76_queue {
+	struct mt76_queue_regs __iomem *regs;
+
+	spinlock_t lock;
+	spinlock_t cleanup_lock;
+	struct mt76_queue_entry *entry;
+	struct mt76_rro_desc *rro_desc;
+	struct mt76_desc *desc;
+
+	u16 first;
+	u16 head;
+	u16 tail;
+	u8 hw_idx;
+	u8 ep;
+	int ndesc;
+	int queued;
+	int buf_size;
+	bool stopped;
+	bool blocked;
+
+	u8 buf_offset;
+	u16 flags;
+
+	struct mtk_wed_device *wed;
+	u32 wed_regs;
+
+	dma_addr_t desc_dma;
+	struct sk_buff *rx_head;
+	struct page_pool *page_pool;
+};
+
+struct mt76_mcu_ops {
+	unsigned int max_retry;
+	u32 headroom;
+	u32 tailroom;
+
+	int (*mcu_send_msg)(struct mt76_dev *dev, int cmd, const void *data,
+			    int len, bool wait_resp);
+	int (*mcu_skb_prepare_msg)(struct mt76_dev *dev, struct sk_buff *skb,
+				   int cmd, int *seq);
+	int (*mcu_skb_send_msg)(struct mt76_dev *dev, struct sk_buff *skb,
+				int cmd, int *seq);
+	int (*mcu_parse_response)(struct mt76_dev *dev, int cmd,
+				  struct sk_buff *skb, int seq);
+	u32 (*mcu_rr)(struct mt76_dev *dev, u32 offset);
+	void (*mcu_wr)(struct mt76_dev *dev, u32 offset, u32 val);
+	int (*mcu_wr_rp)(struct mt76_dev *dev, u32 base,
+			 const struct mt76_reg_pair *rp, int len);
+	int (*mcu_rd_rp)(struct mt76_dev *dev, u32 base,
+			 struct mt76_reg_pair *rp, int len);
+	int (*mcu_restart)(struct mt76_dev *dev);
+};
+
+struct mt76_queue_ops {
+	int (*init)(struct mt76_dev *dev,
+		    int (*poll)(struct napi_struct *napi, int budget));
+
+	int (*alloc)(struct mt76_dev *dev, struct mt76_queue *q,
+		     int idx, int n_desc, int bufsize,
+		     u32 ring_base);
+
+	int (*tx_queue_skb)(struct mt76_phy *phy, struct mt76_queue *q,
+			    enum mt76_txq_id qid, struct sk_buff *skb,
+			    struct mt76_wcid *wcid, struct ieee80211_sta *sta);
+
+	int (*tx_queue_skb_raw)(struct mt76_dev *dev, struct mt76_queue *q,
+				struct sk_buff *skb, u32 tx_info);
+
+	void *(*dequeue)(struct mt76_dev *dev, struct mt76_queue *q, bool flush,
+			 int *len, u32 *info, bool *more);
+
+	void (*rx_reset)(struct mt76_dev *dev, enum mt76_rxq_id qid);
+
+	void (*tx_cleanup)(struct mt76_dev *dev, struct mt76_queue *q,
+			   bool flush);
+
+	void (*rx_cleanup)(struct mt76_dev *dev, struct mt76_queue *q);
+
+	void (*kick)(struct mt76_dev *dev, struct mt76_queue *q);
+
+	void (*reset_q)(struct mt76_dev *dev, struct mt76_queue *q);
+};
+
+enum mt76_phy_type {
+	MT_PHY_TYPE_CCK,
+	MT_PHY_TYPE_OFDM,
+	MT_PHY_TYPE_HT,
+	MT_PHY_TYPE_HT_GF,
+	MT_PHY_TYPE_VHT,
+	MT_PHY_TYPE_HE_SU = 8,
+	MT_PHY_TYPE_HE_EXT_SU,
+	MT_PHY_TYPE_HE_TB,
+	MT_PHY_TYPE_HE_MU,
+	MT_PHY_TYPE_EHT_SU = 13,
+	MT_PHY_TYPE_EHT_TRIG,
+	MT_PHY_TYPE_EHT_MU,
+	__MT_PHY_TYPE_MAX,
+};
+
+struct mt76_sta_stats {
+	u64 tx_mode[__MT_PHY_TYPE_MAX];
+	u64 tx_bw[5];		/* 20, 40, 80, 160, 320 */
+	u64 tx_nss[4];		/* 1, 2, 3, 4 */
+	u64 tx_mcs[16];		/* mcs idx */
+	u64 tx_bytes;
+	/* WED TX */
+	u32 tx_packets;		/* unit: MSDU */
+	u32 tx_retries;
+	u32 tx_failed;
+	/* WED RX */
+	u64 rx_bytes;
+	u32 rx_packets;
+	u32 rx_errors;
+	u32 rx_drops;
+};
+
+enum mt76_wcid_flags {
+	MT_WCID_FLAG_CHECK_PS,
+	MT_WCID_FLAG_PS,
+	MT_WCID_FLAG_4ADDR,
+	MT_WCID_FLAG_HDR_TRANS,
+};
+
+#define MT76_N_WCIDS 1088
+
+/* stored in ieee80211_tx_info::hw_queue */
+#define MT_TX_HW_QUEUE_PHY		GENMASK(3, 2)
+
+DECLARE_EWMA(signal, 10, 8);
+
+#define MT_WCID_TX_INFO_RATE		GENMASK(15, 0)
+#define MT_WCID_TX_INFO_NSS		GENMASK(17, 16)
+#define MT_WCID_TX_INFO_TXPWR_ADJ	GENMASK(25, 18)
+#define MT_WCID_TX_INFO_SET		BIT(31)
+
+struct mt76_wcid {
+	struct mt76_rx_tid __rcu *aggr[IEEE80211_NUM_TIDS];
+
+	atomic_t non_aql_packets;
+	unsigned long flags;
+
+	struct ewma_signal rssi;
+	int inactive_count;
+
+	struct rate_info rate;
+	unsigned long ampdu_state;
+
+	u16 idx;
+	u8 hw_key_idx;
+	u8 hw_key_idx2;
+
+	u8 sta:1;
+	u8 sta_disabled:1;
+	u8 amsdu:1;
+	u8 phy_idx:2;
+	u8 link_id:4;
+	bool link_valid;
+
+	u8 rx_check_pn;
+	u8 rx_key_pn[IEEE80211_NUM_TIDS + 1][6];
+	u16 cipher;
+
+	u32 tx_info;
+	bool sw_iv;
+
+	struct list_head tx_list;
+	struct sk_buff_head tx_pending;
+	struct sk_buff_head tx_offchannel;
+
+	struct list_head list;
+	struct idr pktid;
+
+	struct mt76_sta_stats stats;
+
+	struct list_head poll_list;
+
+	struct mt76_wcid *def_wcid;
+};
+
+struct mt76_txq {
+	u16 wcid;
+
+	u16 agg_ssn;
+	bool send_bar;
+	bool aggr;
+};
+
+struct mt76_wed_rro_ind {
+	u32 se_id	: 12;
+	u32 rsv		: 4;
+	u32 start_sn	: 12;
+	u32 ind_reason	: 4;
+	u32 ind_cnt	: 13;
+	u32 win_sz	: 3;
+	u32 rsv2	: 13;
+	u32 magic_cnt	: 3;
+};
+
+struct mt76_txwi_cache {
+	struct list_head list;
+	dma_addr_t dma_addr;
+
+	union {
+		struct sk_buff *skb;
+		void *ptr;
+	};
+};
+
+struct mt76_rx_tid {
+	struct rcu_head rcu_head;
+
+	struct mt76_dev *dev;
+
+	spinlock_t lock;
+	struct delayed_work reorder_work;
+
+	u16 id;
+	u16 head;
+	u16 size;
+	u16 nframes;
+
+	u8 num;
+
+	u8 started:1, stopped:1, timer_pending:1;
+
+	struct sk_buff *reorder_buf[] __counted_by(size);
+};
+
+#define MT_TX_CB_DMA_DONE		BIT(0)
+#define MT_TX_CB_TXS_DONE		BIT(1)
+#define MT_TX_CB_TXS_FAILED		BIT(2)
+
+#define MT_PACKET_ID_MASK		GENMASK(6, 0)
+#define MT_PACKET_ID_NO_ACK		0
+#define MT_PACKET_ID_NO_SKB		1
+#define MT_PACKET_ID_WED		2
+#define MT_PACKET_ID_FIRST		3
+#define MT_PACKET_ID_HAS_RATE		BIT(7)
+/* This is timer for when to give up when waiting for TXS callback,
+ * with starting time being the time at which the DMA_DONE callback
+ * was seen (so, we know packet was processed then, it should not take
+ * long after that for firmware to send the TXS callback if it is going
+ * to do so.)
+ */
+#define MT_TX_STATUS_SKB_TIMEOUT	(HZ / 4)
+
+struct mt76_tx_cb {
+	unsigned long jiffies;
+	u16 wcid;
+	u8 pktid;
+	u8 flags;
+};
+
+enum {
+	MT76_STATE_INITIALIZED,
+	MT76_STATE_REGISTERED,
+	MT76_STATE_RUNNING,
+	MT76_STATE_MCU_RUNNING,
+	MT76_SCANNING,
+	MT76_HW_SCANNING,
+	MT76_HW_SCHED_SCANNING,
+	MT76_RESTART,
+	MT76_RESET,
+	MT76_MCU_RESET,
+	MT76_REMOVED,
+	MT76_READING_STATS,
+	MT76_STATE_POWER_OFF,
+	MT76_STATE_SUSPEND,
+	MT76_STATE_ROC,
+	MT76_STATE_PM,
+	MT76_STATE_WED_RESET,
+};
+
+enum mt76_sta_event {
+	MT76_STA_EVENT_ASSOC,
+	MT76_STA_EVENT_AUTHORIZE,
+	MT76_STA_EVENT_DISASSOC,
+};
+
+struct mt76_hw_cap {
+	bool has_2ghz;
+	bool has_5ghz;
+	bool has_6ghz;
+};
+
+#define MT_DRV_TXWI_NO_FREE		BIT(0)
+#define MT_DRV_TX_ALIGNED4_SKBS		BIT(1)
+#define MT_DRV_SW_RX_AIRTIME		BIT(2)
+#define MT_DRV_RX_DMA_HDR		BIT(3)
+#define MT_DRV_HW_MGMT_TXQ		BIT(4)
+#define MT_DRV_AMSDU_OFFLOAD		BIT(5)
+
+struct mt76_driver_ops {
+	u32 drv_flags;
+	u32 survey_flags;
+	u16 txwi_size;
+	u16 token_size;
+	u8 mcs_rates;
+
+	unsigned int link_data_size;
+
+	void (*update_survey)(struct mt76_phy *phy);
+	int (*set_channel)(struct mt76_phy *phy);
+
+	int (*tx_prepare_skb)(struct mt76_dev *dev, void *txwi_ptr,
+			      enum mt76_txq_id qid, struct mt76_wcid *wcid,
+			      struct ieee80211_sta *sta,
+			      struct mt76_tx_info *tx_info);
+
+	void (*tx_complete_skb)(struct mt76_dev *dev,
+				struct mt76_queue_entry *e);
+
+	bool (*tx_status_data)(struct mt76_dev *dev, u8 *update);
+
+	bool (*rx_check)(struct mt76_dev *dev, void *data, int len);
+
+	void (*rx_skb)(struct mt76_dev *dev, enum mt76_rxq_id q,
+		       struct sk_buff *skb, u32 *info);
+
+	void (*rx_poll_complete)(struct mt76_dev *dev, enum mt76_rxq_id q);
+
+	void (*sta_ps)(struct mt76_dev *dev, struct ieee80211_sta *sta,
+		       bool ps);
+
+	int (*sta_add)(struct mt76_dev *dev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta);
+
+	int (*sta_event)(struct mt76_dev *dev, struct ieee80211_vif *vif,
+			 struct ieee80211_sta *sta, enum mt76_sta_event ev);
+
+	void (*sta_remove)(struct mt76_dev *dev, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta);
+
+	int (*vif_link_add)(struct mt76_phy *phy, struct ieee80211_vif *vif,
+			    struct ieee80211_bss_conf *link_conf,
+			    struct mt76_vif_link *mlink);
+
+	void (*vif_link_remove)(struct mt76_phy *phy,
+				struct ieee80211_vif *vif,
+				struct ieee80211_bss_conf *link_conf,
+				struct mt76_vif_link *mlink);
+};
+
+struct mt76_channel_state {
+	u64 cc_active;
+	u64 cc_busy;
+	u64 cc_rx;
+	u64 cc_bss_rx;
+	u64 cc_tx;
+
+	s8 noise;
+};
+
+struct mt76_sband {
+	struct ieee80211_supported_band sband;
+	struct mt76_channel_state *chan;
+};
+
+/* addr req mask */
+#define MT_VEND_TYPE_EEPROM	BIT(31)
+#define MT_VEND_TYPE_CFG	BIT(30)
+#define MT_VEND_TYPE_MASK	(MT_VEND_TYPE_EEPROM | MT_VEND_TYPE_CFG)
+
+#define MT_VEND_ADDR(type, n)	(MT_VEND_TYPE_##type | (n))
+enum mt_vendor_req {
+	MT_VEND_DEV_MODE =	0x1,
+	MT_VEND_WRITE =		0x2,
+	MT_VEND_POWER_ON =	0x4,
+	MT_VEND_MULTI_WRITE =	0x6,
+	MT_VEND_MULTI_READ =	0x7,
+	MT_VEND_READ_EEPROM =	0x9,
+	MT_VEND_WRITE_FCE =	0x42,
+	MT_VEND_WRITE_CFG =	0x46,
+	MT_VEND_READ_CFG =	0x47,
+	MT_VEND_READ_EXT =	0x63,
+	MT_VEND_WRITE_EXT =	0x66,
+	MT_VEND_FEATURE_SET =	0x91,
+};
+
+enum mt76u_in_ep {
+	MT_EP_IN_PKT_RX,
+	MT_EP_IN_CMD_RESP,
+	__MT_EP_IN_MAX,
+};
+
+enum mt76u_out_ep {
+	MT_EP_OUT_INBAND_CMD,
+	MT_EP_OUT_AC_BE,
+	MT_EP_OUT_AC_BK,
+	MT_EP_OUT_AC_VI,
+	MT_EP_OUT_AC_VO,
+	MT_EP_OUT_HCCA,
+	__MT_EP_OUT_MAX,
+};
+
+struct mt76_mcu {
+	struct mutex mutex;
+	u32 msg_seq;
+	int timeout;
+
+	struct sk_buff_head res_q;
+	wait_queue_head_t wait;
+};
+
+#define MT_TX_SG_MAX_SIZE	8
+#define MT_RX_SG_MAX_SIZE	4
+#define MT_NUM_TX_ENTRIES	256
+#define MT_NUM_RX_ENTRIES	128
+#define MCU_RESP_URB_SIZE	1024
+struct mt76_usb {
+	struct mutex usb_ctrl_mtx;
+	u8 *data;
+	u16 data_len;
+
+	struct mt76_worker status_worker;
+	struct mt76_worker rx_worker;
+
+	struct work_struct stat_work;
+
+	u8 out_ep[__MT_EP_OUT_MAX];
+	u8 in_ep[__MT_EP_IN_MAX];
+	bool sg_en;
+
+	struct mt76u_mcu {
+		u8 *data;
+		/* multiple reads */
+		struct mt76_reg_pair *rp;
+		int rp_len;
+		u32 base;
+	} mcu;
+};
+
+#define MT76S_XMIT_BUF_SZ	0x3fe00
+#define MT76S_NUM_TX_ENTRIES	256
+#define MT76S_NUM_RX_ENTRIES	512
+struct mt76_sdio {
+	struct mt76_worker txrx_worker;
+	struct mt76_worker status_worker;
+	struct mt76_worker net_worker;
+	struct mt76_worker stat_worker;
+
+	u8 *xmit_buf;
+	u32 xmit_buf_sz;
+
+	struct sdio_func *func;
+	void *intr_data;
+	u8 hw_ver;
+	wait_queue_head_t wait;
+
+	int pse_mcu_quota_max;
+	struct {
+		int pse_data_quota;
+		int ple_data_quota;
+		int pse_mcu_quota;
+		int pse_page_size;
+		int deficit;
+	} sched;
+
+	int (*parse_irq)(struct mt76_dev *dev, struct mt76s_intr *intr);
+};
+
+struct mt76_mmio {
+	void __iomem *regs;
+	spinlock_t irq_lock;
+	u32 irqmask;
+
+	struct mtk_wed_device wed;
+	struct mtk_wed_device wed_hif2;
+	struct completion wed_reset;
+	struct completion wed_reset_complete;
+};
+
+struct mt76_rx_status {
+	union {
+		struct mt76_wcid *wcid;
+		u16 wcid_idx;
+	};
+
+	u32 reorder_time;
+
+	u32 ampdu_ref;
+	u32 timestamp;
+
+	u8 iv[6];
+
+	u8 phy_idx:2;
+	u8 aggr:1;
+	u8 qos_ctl;
+	u16 seqno;
+
+	u16 freq;
+	u32 flag;
+	u8 enc_flags;
+	u8 encoding:3, bw:4;
+	union {
+		struct {
+			u8 he_ru:3;
+			u8 he_gi:2;
+			u8 he_dcm:1;
+		};
+		struct {
+			u8 ru:4;
+			u8 gi:2;
+		} eht;
+	};
+
+	u8 amsdu:1, first_amsdu:1, last_amsdu:1;
+	u8 rate_idx;
+	u8 nss:5, band:3;
+	s8 signal;
+	u8 chains;
+	s8 chain_signal[IEEE80211_MAX_CHAINS];
+};
+
+struct mt76_freq_range_power {
+	const struct cfg80211_sar_freq_ranges *range;
+	s8 power;
+};
+
+struct mt76_testmode_ops {
+	int (*set_state)(struct mt76_phy *phy, enum mt76_testmode_state state);
+	int (*set_params)(struct mt76_phy *phy, struct nlattr **tb,
+			  enum mt76_testmode_state new_state);
+	int (*dump_stats)(struct mt76_phy *phy, struct sk_buff *msg);
+};
+
+struct mt76_testmode_data {
+	enum mt76_testmode_state state;
+
+	u32 param_set[DIV_ROUND_UP(NUM_MT76_TM_ATTRS, 32)];
+	struct sk_buff *tx_skb;
+
+	u32 tx_count;
+	u16 tx_mpdu_len;
+
+	u8 tx_rate_mode;
+	u8 tx_rate_idx;
+	u8 tx_rate_nss;
+	u8 tx_rate_sgi;
+	u8 tx_rate_ldpc;
+	u8 tx_rate_stbc;
+	u8 tx_ltf;
+
+	u8 tx_antenna_mask;
+	u8 tx_spe_idx;
+
+	u8 tx_duty_cycle;
+	u32 tx_time;
+	u32 tx_ipg;
+
+	u32 freq_offset;
+
+	u8 tx_power[4];
+	u8 tx_power_control;
+
+	u8 addr[3][ETH_ALEN];
+
+	u32 tx_pending;
+	u32 tx_queued;
+	u16 tx_queued_limit;
+	u32 tx_done;
+	struct {
+		u64 packets[__MT_RXQ_MAX];
+		u64 fcs_error[__MT_RXQ_MAX];
+	} rx_stats;
+};
+
+struct mt76_vif_link {
+	u8 idx;
+	u8 omac_idx;
+	u8 band_idx;
+	u8 wmm_idx;
+	u8 scan_seq_num;
+	u8 cipher;
+	u8 basic_rates_idx;
+	u8 mcast_rates_idx;
+	u8 beacon_rates_idx;
+	bool offchannel;
+	struct ieee80211_chanctx_conf *ctx;
+	struct mt76_wcid *wcid;
+	struct mt76_vif_data *mvif;
+	struct rcu_head rcu_head;
+};
+
+struct mt76_vif_data {
+	struct mt76_vif_link __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
+
+	struct mt76_phy *roc_phy;
+	u16 valid_links;
+	u8 deflink_id;
+};
+
+struct mt76_phy {
+	struct ieee80211_hw *hw;
+	struct mt76_dev *dev;
+	void *priv;
+
+	unsigned long state;
+	unsigned int num_sta;
+	u8 band_idx;
+
+	spinlock_t tx_lock;
+	struct list_head tx_list;
+	struct mt76_queue *q_tx[__MT_TXQ_MAX];
+
+	struct cfg80211_chan_def chandef;
+	struct cfg80211_chan_def main_chandef;
+	bool offchannel;
+	bool radar_enabled;
+
+	struct delayed_work roc_work;
+	struct ieee80211_vif *roc_vif;
+	struct mt76_vif_link *roc_link;
+
+	struct mt76_chanctx *chanctx;
+
+	struct mt76_channel_state *chan_state;
+	enum mt76_dfs_state dfs_state;
+	ktime_t survey_time;
+
+	u32 aggr_stats[32];
+
+	struct mt76_hw_cap cap;
+	struct mt76_sband sband_2g;
+	struct mt76_sband sband_5g;
+	struct mt76_sband sband_6g;
+
+	u8 macaddr[ETH_ALEN];
+
+	int txpower_cur;
+	u8 antenna_mask;
+	u16 chainmask;
+
+#ifdef CONFIG_NL80211_TESTMODE
+	struct mt76_testmode_data test;
+#endif
+
+	struct delayed_work mac_work;
+	u8 mac_work_count;
+
+	struct {
+		struct sk_buff *head;
+		struct sk_buff **tail;
+		u16 seqno;
+	} rx_amsdu[__MT_RXQ_MAX];
+
+	struct mt76_freq_range_power *frp;
+
+	struct {
+		struct led_classdev cdev;
+		char name[32];
+		bool al;
+		u8 pin;
+	} leds;
+};
+
+struct mt76_dev {
+	struct mt76_phy phy; /* must be first */
+	struct mt76_phy *phys[__MT_MAX_BAND];
+	struct mt76_phy *band_phys[NUM_NL80211_BANDS];
+
+	struct ieee80211_hw *hw;
+
+	spinlock_t wed_lock;
+	spinlock_t lock;
+	spinlock_t cc_lock;
+
+	u32 cur_cc_bss_rx;
+
+	struct mt76_rx_status rx_ampdu_status;
+	u32 rx_ampdu_len;
+	u32 rx_ampdu_ref;
+
+	struct mutex mutex;
+
+	const struct mt76_bus_ops *bus;
+	const struct mt76_driver_ops *drv;
+	const struct mt76_mcu_ops *mcu_ops;
+	struct device *dev;
+	struct device *dma_dev;
+
+	struct mt76_mcu mcu;
+
+	struct net_device *napi_dev;
+	struct net_device *tx_napi_dev;
+	spinlock_t rx_lock;
+	struct napi_struct napi[__MT_RXQ_MAX];
+	struct sk_buff_head rx_skb[__MT_RXQ_MAX];
+	struct tasklet_struct irq_tasklet;
+
+	struct list_head txwi_cache;
+	struct list_head rxwi_cache;
+	struct mt76_queue *q_mcu[__MT_MCUQ_MAX];
+	struct mt76_queue q_rx[__MT_RXQ_MAX];
+	const struct mt76_queue_ops *queue_ops;
+	int tx_dma_idx[4];
+
+	struct mt76_worker tx_worker;
+	struct napi_struct tx_napi;
+
+	spinlock_t token_lock;
+	struct idr token;
+	u16 wed_token_count;
+	u16 token_count;
+	u16 token_size;
+
+	spinlock_t rx_token_lock;
+	struct idr rx_token;
+	u16 rx_token_size;
+
+	wait_queue_head_t tx_wait;
+	/* spinclock used to protect wcid pktid linked list */
+	spinlock_t status_lock;
+
+	u32 wcid_mask[DIV_ROUND_UP(MT76_N_WCIDS, 32)];
+
+	u64 vif_mask;
+
+	struct mt76_wcid global_wcid;
+	struct mt76_wcid __rcu *wcid[MT76_N_WCIDS];
+	struct list_head wcid_list;
+
+	struct list_head sta_poll_list;
+	spinlock_t sta_poll_lock;
+
+	u32 rev;
+
+	struct tasklet_struct pre_tbtt_tasklet;
+	int beacon_int;
+	u8 beacon_mask;
+
+	struct debugfs_blob_wrapper eeprom;
+	struct debugfs_blob_wrapper otp;
+
+	char alpha2[3];
+	enum nl80211_dfs_regions region;
+
+	u32 debugfs_reg;
+
+	u8 csa_complete;
+
+	u32 rxfilter;
+
+	struct delayed_work scan_work;
+	struct {
+		struct cfg80211_scan_request *req;
+		struct ieee80211_channel *chan;
+		struct ieee80211_vif *vif;
+		struct mt76_vif_link *mlink;
+		struct mt76_phy *phy;
+		int chan_idx;
+	} scan;
+
+#ifdef CONFIG_NL80211_TESTMODE
+	const struct mt76_testmode_ops *test_ops;
+	struct {
+		const char *name;
+		u32 offset;
+	} test_mtd;
+#endif
+	struct workqueue_struct *wq;
+
+	union {
+		struct mt76_mmio mmio;
+		struct mt76_usb usb;
+		struct mt76_sdio sdio;
+	};
+};
+
+/* per-phy stats.  */
+struct mt76_mib_stats {
+	u32 ack_fail_cnt;
+	u32 fcs_err_cnt;
+	u32 rts_cnt;
+	u32 rts_retries_cnt;
+	u32 ba_miss_cnt;
+	u32 tx_bf_cnt;
+	u32 tx_mu_bf_cnt;
+	u32 tx_mu_mpdu_cnt;
+	u32 tx_mu_acked_mpdu_cnt;
+	u32 tx_su_acked_mpdu_cnt;
+	u32 tx_bf_ibf_ppdu_cnt;
+	u32 tx_bf_ebf_ppdu_cnt;
+
+	u32 tx_bf_rx_fb_all_cnt;
+	u32 tx_bf_rx_fb_eht_cnt;
+	u32 tx_bf_rx_fb_he_cnt;
+	u32 tx_bf_rx_fb_vht_cnt;
+	u32 tx_bf_rx_fb_ht_cnt;
+
+	u32 tx_bf_rx_fb_bw; /* value of last sample, not cumulative */
+	u32 tx_bf_rx_fb_nc_cnt;
+	u32 tx_bf_rx_fb_nr_cnt;
+	u32 tx_bf_fb_cpl_cnt;
+	u32 tx_bf_fb_trig_cnt;
+
+	u32 tx_ampdu_cnt;
+	u32 tx_stop_q_empty_cnt;
+	u32 tx_mpdu_attempts_cnt;
+	u32 tx_mpdu_success_cnt;
+	u32 tx_pkt_ebf_cnt;
+	u32 tx_pkt_ibf_cnt;
+
+	u32 tx_rwp_fail_cnt;
+	u32 tx_rwp_need_cnt;
+
+	/* rx stats */
+	u32 rx_fifo_full_cnt;
+	u32 channel_idle_cnt;
+	u32 primary_cca_busy_time;
+	u32 secondary_cca_busy_time;
+	u32 primary_energy_detect_time;
+	u32 cck_mdrdy_time;
+	u32 ofdm_mdrdy_time;
+	u32 green_mdrdy_time;
+	u32 rx_vector_mismatch_cnt;
+	u32 rx_delimiter_fail_cnt;
+	u32 rx_mrdy_cnt;
+	u32 rx_len_mismatch_cnt;
+	u32 rx_mpdu_cnt;
+	u32 rx_ampdu_cnt;
+	u32 rx_ampdu_bytes_cnt;
+	u32 rx_ampdu_valid_subframe_cnt;
+	u32 rx_ampdu_valid_subframe_bytes_cnt;
+	u32 rx_pfdrop_cnt;
+	u32 rx_vec_queue_overflow_drop_cnt;
+	u32 rx_ba_cnt;
+
+	u32 tx_amsdu[8];
+	u32 tx_amsdu_cnt;
+
+	/* mcu_muru_stats */
+	u32 dl_cck_cnt;
+	u32 dl_ofdm_cnt;
+	u32 dl_htmix_cnt;
+	u32 dl_htgf_cnt;
+	u32 dl_vht_su_cnt;
+	u32 dl_vht_2mu_cnt;
+	u32 dl_vht_3mu_cnt;
+	u32 dl_vht_4mu_cnt;
+	u32 dl_he_su_cnt;
+	u32 dl_he_ext_su_cnt;
+	u32 dl_he_2ru_cnt;
+	u32 dl_he_2mu_cnt;
+	u32 dl_he_3ru_cnt;
+	u32 dl_he_3mu_cnt;
+	u32 dl_he_4ru_cnt;
+	u32 dl_he_4mu_cnt;
+	u32 dl_he_5to8ru_cnt;
+	u32 dl_he_9to16ru_cnt;
+	u32 dl_he_gtr16ru_cnt;
+
+	u32 ul_hetrig_su_cnt;
+	u32 ul_hetrig_2ru_cnt;
+	u32 ul_hetrig_3ru_cnt;
+	u32 ul_hetrig_4ru_cnt;
+	u32 ul_hetrig_5to8ru_cnt;
+	u32 ul_hetrig_9to16ru_cnt;
+	u32 ul_hetrig_gtr16ru_cnt;
+	u32 ul_hetrig_2mu_cnt;
+	u32 ul_hetrig_3mu_cnt;
+	u32 ul_hetrig_4mu_cnt;
+};
+
+struct mt76_power_limits {
+	s8 cck[4];
+	s8 ofdm[8];
+	s8 mcs[4][10];
+	s8 ru[7][12];
+	s8 eht[16][16];
+};
+
+struct mt76_ethtool_worker_info {
+	u64 *data;
+	int idx;
+	int initial_stat_idx;
+	int worker_stat_count;
+	int sta_count;
+};
+
+struct mt76_chanctx {
+	struct mt76_phy *phy;
+};
+
+#define CCK_RATE(_idx, _rate) {					\
+	.bitrate = _rate,					\
+	.flags = IEEE80211_RATE_SHORT_PREAMBLE,			\
+	.hw_value = (MT_PHY_TYPE_CCK << 8) | (_idx),		\
+	.hw_value_short = (MT_PHY_TYPE_CCK << 8) | (4 + _idx),	\
+}
+
+#define OFDM_RATE(_idx, _rate) {				\
+	.bitrate = _rate,					\
+	.hw_value = (MT_PHY_TYPE_OFDM << 8) | (_idx),		\
+	.hw_value_short = (MT_PHY_TYPE_OFDM << 8) | (_idx),	\
+}
+
+extern struct ieee80211_rate mt76_rates[12];
+
+#define __mt76_rr(dev, ...)	(dev)->bus->rr((dev), __VA_ARGS__)
+#define __mt76_wr(dev, ...)	(dev)->bus->wr((dev), __VA_ARGS__)
+#define __mt76_rmw(dev, ...)	(dev)->bus->rmw((dev), __VA_ARGS__)
+#define __mt76_wr_copy(dev, ...)	(dev)->bus->write_copy((dev), __VA_ARGS__)
+#define __mt76_rr_copy(dev, ...)	(dev)->bus->read_copy((dev), __VA_ARGS__)
+
+#define __mt76_set(dev, offset, val)	__mt76_rmw(dev, offset, 0, val)
+#define __mt76_clear(dev, offset, val)	__mt76_rmw(dev, offset, val, 0)
+
+#define mt76_rr(dev, ...)	(dev)->mt76.bus->rr(&((dev)->mt76), __VA_ARGS__)
+#define mt76_wr(dev, ...)	(dev)->mt76.bus->wr(&((dev)->mt76), __VA_ARGS__)
+#define mt76_rmw(dev, ...)	(dev)->mt76.bus->rmw(&((dev)->mt76), __VA_ARGS__)
+#define mt76_wr_copy(dev, ...)	(dev)->mt76.bus->write_copy(&((dev)->mt76), __VA_ARGS__)
+#define mt76_rr_copy(dev, ...)	(dev)->mt76.bus->read_copy(&((dev)->mt76), __VA_ARGS__)
+#define mt76_wr_rp(dev, ...)	(dev)->mt76.bus->wr_rp(&((dev)->mt76), __VA_ARGS__)
+#define mt76_rd_rp(dev, ...)	(dev)->mt76.bus->rd_rp(&((dev)->mt76), __VA_ARGS__)
+
+
+#define mt76_mcu_restart(dev, ...)	(dev)->mt76.mcu_ops->mcu_restart(&((dev)->mt76))
+
+#define mt76_set(dev, offset, val)	mt76_rmw(dev, offset, 0, val)
+#define mt76_clear(dev, offset, val)	mt76_rmw(dev, offset, val, 0)
+
+#define mt76_get_field(_dev, _reg, _field)		\
+	FIELD_GET(_field, mt76_rr(dev, _reg))
+
+#define mt76_rmw_field(_dev, _reg, _field, _val)	\
+	mt76_rmw(_dev, _reg, _field, FIELD_PREP(_field, _val))
+
+#define __mt76_rmw_field(_dev, _reg, _field, _val)	\
+	__mt76_rmw(_dev, _reg, _field, FIELD_PREP(_field, _val))
+
+#define mt76_hw(dev) (dev)->mphy.hw
+
+bool __mt76_poll(struct mt76_dev *dev, u32 offset, u32 mask, u32 val,
+		 int timeout);
+
+#define mt76_poll(dev, ...) __mt76_poll(&((dev)->mt76), __VA_ARGS__)
+
+bool ____mt76_poll_msec(struct mt76_dev *dev, u32 offset, u32 mask, u32 val,
+			int timeout, int kick);
+#define __mt76_poll_msec(...)         ____mt76_poll_msec(__VA_ARGS__, 10)
+#define mt76_poll_msec(dev, ...)      ____mt76_poll_msec(&((dev)->mt76), __VA_ARGS__, 10)
+#define mt76_poll_msec_tick(dev, ...) ____mt76_poll_msec(&((dev)->mt76), __VA_ARGS__)
+
+void mt76_mmio_init(struct mt76_dev *dev, void __iomem *regs);
+void mt76_pci_disable_aspm(struct pci_dev *pdev);
+bool mt76_pci_aspm_supported(struct pci_dev *pdev);
+
+static inline u16 mt76_chip(struct mt76_dev *dev)
+{
+	return dev->rev >> 16;
+}
+
+static inline u16 mt76_rev(struct mt76_dev *dev)
+{
+	return dev->rev & 0xffff;
+}
+
+void mt76_wed_release_rx_buf(struct mtk_wed_device *wed);
+void mt76_wed_offload_disable(struct mtk_wed_device *wed);
+void mt76_wed_reset_complete(struct mtk_wed_device *wed);
+void mt76_wed_dma_reset(struct mt76_dev *dev);
+int mt76_wed_net_setup_tc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			  struct net_device *netdev, enum tc_setup_type type,
+			  void *type_data);
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+u32 mt76_wed_init_rx_buf(struct mtk_wed_device *wed, int size);
+int mt76_wed_offload_enable(struct mtk_wed_device *wed);
+int mt76_wed_dma_setup(struct mt76_dev *dev, struct mt76_queue *q, bool reset);
+#else
+static inline u32 mt76_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
+{
+	return 0;
+}
+
+static inline int mt76_wed_offload_enable(struct mtk_wed_device *wed)
+{
+	return 0;
+}
+
+static inline int mt76_wed_dma_setup(struct mt76_dev *dev, struct mt76_queue *q,
+				     bool reset)
+{
+	return 0;
+}
+#endif /* CONFIG_NET_MEDIATEK_SOC_WED */
+
+#define mt76xx_chip(dev) mt76_chip(&((dev)->mt76))
+#define mt76xx_rev(dev) mt76_rev(&((dev)->mt76))
+
+#define mt76_init_queues(dev, ...)		(dev)->mt76.queue_ops->init(&((dev)->mt76), __VA_ARGS__)
+#define mt76_queue_alloc(dev, ...)	(dev)->mt76.queue_ops->alloc(&((dev)->mt76), __VA_ARGS__)
+#define mt76_tx_queue_skb_raw(dev, ...)	(dev)->mt76.queue_ops->tx_queue_skb_raw(&((dev)->mt76), __VA_ARGS__)
+#define mt76_tx_queue_skb(dev, ...)	(dev)->mt76.queue_ops->tx_queue_skb(&((dev)->mphy), __VA_ARGS__)
+#define mt76_queue_rx_reset(dev, ...)	(dev)->mt76.queue_ops->rx_reset(&((dev)->mt76), __VA_ARGS__)
+#define mt76_queue_tx_cleanup(dev, ...)	(dev)->mt76.queue_ops->tx_cleanup(&((dev)->mt76), __VA_ARGS__)
+#define mt76_queue_rx_cleanup(dev, ...)	(dev)->mt76.queue_ops->rx_cleanup(&((dev)->mt76), __VA_ARGS__)
+#define mt76_queue_kick(dev, ...)	(dev)->mt76.queue_ops->kick(&((dev)->mt76), __VA_ARGS__)
+#define mt76_queue_reset(dev, ...)	(dev)->mt76.queue_ops->reset_q(&((dev)->mt76), __VA_ARGS__)
+
+#define mt76_for_each_q_rx(dev, i)	\
+	for (i = 0; i < ARRAY_SIZE((dev)->q_rx); i++)	\
+		if ((dev)->q_rx[i].ndesc)
+
+
+#define mt76_dereference(p, dev) \
+	rcu_dereference_protected(p, lockdep_is_held(&(dev)->mutex))
+
+struct mt76_dev *mt76_alloc_device(struct device *pdev, unsigned int size,
+				   const struct ieee80211_ops *ops,
+				   const struct mt76_driver_ops *drv_ops);
+int mt76_register_device(struct mt76_dev *dev, bool vht,
+			 struct ieee80211_rate *rates, int n_rates);
+void mt76_unregister_device(struct mt76_dev *dev);
+void mt76_free_device(struct mt76_dev *dev);
+void mt76_unregister_phy(struct mt76_phy *phy);
+
+struct mt76_phy *mt76_alloc_radio_phy(struct mt76_dev *dev, unsigned int size,
+				      u8 band_idx);
+struct mt76_phy *mt76_alloc_phy(struct mt76_dev *dev, unsigned int size,
+				const struct ieee80211_ops *ops,
+				u8 band_idx);
+int mt76_register_phy(struct mt76_phy *phy, bool vht,
+		      struct ieee80211_rate *rates, int n_rates);
+
+struct dentry *mt76_register_debugfs_fops(struct mt76_phy *phy,
+					  const struct file_operations *ops);
+static inline struct dentry *mt76_register_debugfs(struct mt76_dev *dev)
+{
+	return mt76_register_debugfs_fops(&dev->phy, NULL);
+}
+
+int mt76_queues_read(struct seq_file *s, void *data);
+void mt76_seq_puts_array(struct seq_file *file, const char *str,
+			 s8 *val, int len);
+
+int mt76_eeprom_init(struct mt76_dev *dev, int len);
+void mt76_eeprom_override(struct mt76_phy *phy);
+int mt76_get_of_data_from_mtd(struct mt76_dev *dev, void *eep, int offset, int len);
+int mt76_get_of_data_from_nvmem(struct mt76_dev *dev, void *eep,
+				const char *cell_name, int len);
+
+struct mt76_queue *
+mt76_init_queue(struct mt76_dev *dev, int qid, int idx, int n_desc,
+		int ring_base, void *wed, u32 flags);
+static inline int mt76_init_tx_queue(struct mt76_phy *phy, int qid, int idx,
+				     int n_desc, int ring_base, void *wed,
+				     u32 flags)
+{
+	struct mt76_queue *q;
+
+	q = mt76_init_queue(phy->dev, qid, idx, n_desc, ring_base, wed, flags);
+	if (IS_ERR(q))
+		return PTR_ERR(q);
+
+	phy->q_tx[qid] = q;
+
+	return 0;
+}
+
+static inline int mt76_init_mcu_queue(struct mt76_dev *dev, int qid, int idx,
+				      int n_desc, int ring_base)
+{
+	struct mt76_queue *q;
+
+	q = mt76_init_queue(dev, qid, idx, n_desc, ring_base, NULL, 0);
+	if (IS_ERR(q))
+		return PTR_ERR(q);
+
+	dev->q_mcu[qid] = q;
+
+	return 0;
+}
+
+static inline struct mt76_phy *
+mt76_dev_phy(struct mt76_dev *dev, u8 phy_idx)
+{
+	if ((phy_idx == MT_BAND1 && dev->phys[phy_idx]) ||
+	    (phy_idx == MT_BAND2 && dev->phys[phy_idx]))
+		return dev->phys[phy_idx];
+
+	return &dev->phy;
+}
+
+static inline struct ieee80211_hw *
+mt76_phy_hw(struct mt76_dev *dev, u8 phy_idx)
+{
+	return mt76_dev_phy(dev, phy_idx)->hw;
+}
+
+static inline u8 *
+mt76_get_txwi_ptr(struct mt76_dev *dev, struct mt76_txwi_cache *t)
+{
+	return (u8 *)t - dev->drv->txwi_size;
+}
+
+/* increment with wrap-around */
+static inline int mt76_incr(int val, int size)
+{
+	return (val + 1) & (size - 1);
+}
+
+/* decrement with wrap-around */
+static inline int mt76_decr(int val, int size)
+{
+	return (val - 1) & (size - 1);
+}
+
+u8 mt76_ac_to_hwq(u8 ac);
+
+static inline struct ieee80211_txq *
+mtxq_to_txq(struct mt76_txq *mtxq)
+{
+	void *ptr = mtxq;
+
+	return container_of(ptr, struct ieee80211_txq, drv_priv);
+}
+
+static inline struct ieee80211_sta *
+wcid_to_sta(struct mt76_wcid *wcid)
+{
+	void *ptr = wcid;
+
+	if (!wcid || !wcid->sta)
+		return NULL;
+
+	if (wcid->def_wcid)
+		ptr = wcid->def_wcid;
+
+	return container_of(ptr, struct ieee80211_sta, drv_priv);
+}
+
+static inline struct mt76_tx_cb *mt76_tx_skb_cb(struct sk_buff *skb)
+{
+	BUILD_BUG_ON(sizeof(struct mt76_tx_cb) >
+		     sizeof(IEEE80211_SKB_CB(skb)->status.status_driver_data));
+	return ((void *)IEEE80211_SKB_CB(skb)->status.status_driver_data);
+}
+
+static inline void *mt76_skb_get_hdr(struct sk_buff *skb)
+{
+	struct mt76_rx_status mstat;
+	u8 *data = skb->data;
+
+	/* Alignment concerns */
+	BUILD_BUG_ON(sizeof(struct ieee80211_radiotap_he) % 4);
+	BUILD_BUG_ON(sizeof(struct ieee80211_radiotap_he_mu) % 4);
+
+	mstat = *((struct mt76_rx_status *)skb->cb);
+
+	if (mstat.flag & RX_FLAG_RADIOTAP_HE)
+		data += sizeof(struct ieee80211_radiotap_he);
+	if (mstat.flag & RX_FLAG_RADIOTAP_HE_MU)
+		data += sizeof(struct ieee80211_radiotap_he_mu);
+
+	return data;
+}
+
+static inline void mt76_insert_hdr_pad(struct sk_buff *skb)
+{
+	int len = ieee80211_get_hdrlen_from_skb(skb);
+
+	if (len % 4 == 0)
+		return;
+
+	skb_push(skb, 2);
+	memmove(skb->data, skb->data + 2, len);
+
+	skb->data[len] = 0;
+	skb->data[len + 1] = 0;
+}
+
+static inline bool mt76_is_skb_pktid(u8 pktid)
+{
+	if (pktid & MT_PACKET_ID_HAS_RATE)
+		return false;
+
+	return pktid >= MT_PACKET_ID_FIRST;
+}
+
+static inline u8 mt76_tx_power_nss_delta(u8 nss)
+{
+	static const u8 nss_delta[4] = { 0, 6, 9, 12 };
+	u8 idx = nss - 1;
+
+	return (idx < ARRAY_SIZE(nss_delta)) ? nss_delta[idx] : 0;
+}
+
+static inline bool mt76_testmode_enabled(struct mt76_phy *phy)
+{
+#ifdef CONFIG_NL80211_TESTMODE
+	return phy->test.state != MT76_TM_STATE_OFF;
+#else
+	return false;
+#endif
+}
+
+static inline bool mt76_is_testmode_skb(struct mt76_dev *dev,
+					struct sk_buff *skb,
+					struct ieee80211_hw **hw)
+{
+#ifdef CONFIG_NL80211_TESTMODE
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dev->phys); i++) {
+		struct mt76_phy *phy = dev->phys[i];
+
+		if (phy && skb == phy->test.tx_skb) {
+			*hw = dev->phys[i]->hw;
+			return true;
+		}
+	}
+	return false;
+#else
+	return false;
+#endif
+}
+
+void mt76_rx(struct mt76_dev *dev, enum mt76_rxq_id q, struct sk_buff *skb);
+void mt76_tx(struct mt76_phy *dev, struct ieee80211_sta *sta,
+	     struct mt76_wcid *wcid, struct sk_buff *skb);
+void mt76_wake_tx_queue(struct ieee80211_hw *hw, struct ieee80211_txq *txq);
+void mt76_stop_tx_queues(struct mt76_phy *phy, struct ieee80211_sta *sta,
+			 bool send_bar);
+void mt76_tx_check_agg_ssn(struct ieee80211_sta *sta, struct sk_buff *skb);
+void mt76_txq_schedule(struct mt76_phy *phy, enum mt76_txq_id qid);
+void mt76_txq_schedule_all(struct mt76_phy *phy);
+void mt76_tx_worker_run(struct mt76_dev *dev);
+void mt76_tx_worker(struct mt76_worker *w);
+void mt76_release_buffered_frames(struct ieee80211_hw *hw,
+				  struct ieee80211_sta *sta,
+				  u16 tids, int nframes,
+				  enum ieee80211_frame_release_type reason,
+				  bool more_data);
+bool mt76_has_tx_pending(struct mt76_phy *phy);
+int mt76_update_channel(struct mt76_phy *phy);
+void mt76_update_survey(struct mt76_phy *phy);
+void mt76_update_survey_active_time(struct mt76_phy *phy, ktime_t time);
+int mt76_get_survey(struct ieee80211_hw *hw, int idx,
+		    struct survey_info *survey);
+int mt76_rx_signal(u8 chain_mask, s8 *chain_signal);
+void mt76_set_stream_caps(struct mt76_phy *phy, bool vht);
+
+int mt76_rx_aggr_start(struct mt76_dev *dev, struct mt76_wcid *wcid, u8 tid,
+		       u16 ssn, u16 size);
+void mt76_rx_aggr_stop(struct mt76_dev *dev, struct mt76_wcid *wcid, u8 tid);
+
+void mt76_wcid_key_setup(struct mt76_dev *dev, struct mt76_wcid *wcid,
+			 struct ieee80211_key_conf *key);
+
+void mt76_tx_status_lock(struct mt76_dev *dev, struct sk_buff_head *list)
+			 __acquires(&dev->status_lock);
+void mt76_tx_status_unlock(struct mt76_dev *dev, struct sk_buff_head *list)
+			   __releases(&dev->status_lock);
+
+int mt76_tx_status_skb_add(struct mt76_dev *dev, struct mt76_wcid *wcid,
+			   struct sk_buff *skb);
+struct sk_buff *mt76_tx_status_skb_get(struct mt76_dev *dev,
+				       struct mt76_wcid *wcid, int pktid,
+				       struct sk_buff_head *list);
+void mt76_tx_status_skb_done(struct mt76_dev *dev, struct sk_buff *skb,
+			     struct sk_buff_head *list);
+void __mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid, struct sk_buff *skb,
+			    struct list_head *free_list);
+static inline void
+mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid, struct sk_buff *skb)
+{
+    __mt76_tx_complete_skb(dev, wcid, skb, NULL);
+}
+
+void mt76_tx_status_check(struct mt76_dev *dev, bool flush);
+int mt76_sta_state(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		   struct ieee80211_sta *sta,
+		   enum ieee80211_sta_state old_state,
+		   enum ieee80211_sta_state new_state);
+void __mt76_sta_remove(struct mt76_phy *phy, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta);
+void mt76_sta_pre_rcu_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			     struct ieee80211_sta *sta);
+
+int mt76_get_min_avg_rssi(struct mt76_dev *dev, u8 phy_idx);
+
+int mt76_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		     unsigned int link_id, int *dbm);
+int mt76_init_sar_power(struct ieee80211_hw *hw,
+			const struct cfg80211_sar_specs *sar);
+int mt76_get_sar_power(struct mt76_phy *phy,
+		       struct ieee80211_channel *chan,
+		       int power);
+
+void mt76_csa_check(struct mt76_dev *dev);
+void mt76_csa_finish(struct mt76_dev *dev);
+
+int mt76_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant);
+int mt76_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta, bool set);
+void mt76_insert_ccmp_hdr(struct sk_buff *skb, u8 key_id);
+int mt76_get_rate(struct mt76_dev *dev,
+		  struct ieee80211_supported_band *sband,
+		  int idx, bool cck);
+int mt76_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		 struct ieee80211_scan_request *hw_req);
+void mt76_cancel_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
+void mt76_sw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		  const u8 *mac);
+void mt76_sw_scan_complete(struct ieee80211_hw *hw,
+			   struct ieee80211_vif *vif);
+enum mt76_dfs_state mt76_phy_dfs_state(struct mt76_phy *phy);
+int mt76_add_chanctx(struct ieee80211_hw *hw,
+		     struct ieee80211_chanctx_conf *conf);
+void mt76_remove_chanctx(struct ieee80211_hw *hw,
+			 struct ieee80211_chanctx_conf *conf);
+void mt76_change_chanctx(struct ieee80211_hw *hw,
+			 struct ieee80211_chanctx_conf *conf,
+			 u32 changed);
+int mt76_assign_vif_chanctx(struct ieee80211_hw *hw,
+			    struct ieee80211_vif *vif,
+			    struct ieee80211_bss_conf *link_conf,
+			    struct ieee80211_chanctx_conf *conf);
+void mt76_unassign_vif_chanctx(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *vif,
+			       struct ieee80211_bss_conf *link_conf,
+			       struct ieee80211_chanctx_conf *conf);
+int mt76_switch_vif_chanctx(struct ieee80211_hw *hw,
+			    struct ieee80211_vif_chanctx_switch *vifs,
+			    int n_vifs,
+			    enum ieee80211_chanctx_switch_mode mode);
+int mt76_remain_on_channel(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			   struct ieee80211_channel *chan, int duration,
+			   enum ieee80211_roc_type type);
+int mt76_cancel_remain_on_channel(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif);
+int mt76_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		      void *data, int len);
+int mt76_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *skb,
+		       struct netlink_callback *cb, void *data, int len);
+int mt76_testmode_set_state(struct mt76_phy *phy, enum mt76_testmode_state state);
+int mt76_testmode_alloc_skb(struct mt76_phy *phy, u32 len);
+
+static inline void mt76_testmode_reset(struct mt76_phy *phy, bool disable)
+{
+#ifdef CONFIG_NL80211_TESTMODE
+	enum mt76_testmode_state state = MT76_TM_STATE_IDLE;
+
+	if (disable || phy->test.state == MT76_TM_STATE_OFF)
+		state = MT76_TM_STATE_OFF;
+
+	mt76_testmode_set_state(phy, state);
+#endif
+}
+
+
+/* internal */
+static inline struct ieee80211_hw *
+mt76_tx_status_get_hw(struct mt76_dev *dev, struct sk_buff *skb)
+{
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	u8 phy_idx = (info->hw_queue & MT_TX_HW_QUEUE_PHY) >> 2;
+	struct ieee80211_hw *hw = mt76_phy_hw(dev, phy_idx);
+
+	info->hw_queue &= ~MT_TX_HW_QUEUE_PHY;
+
+	return hw;
+}
+
+void mt76_put_txwi(struct mt76_dev *dev, struct mt76_txwi_cache *t);
+void mt76_put_rxwi(struct mt76_dev *dev, struct mt76_txwi_cache *t);
+struct mt76_txwi_cache *mt76_get_rxwi(struct mt76_dev *dev);
+void mt76_free_pending_rxwi(struct mt76_dev *dev);
+void mt76_rx_complete(struct mt76_dev *dev, struct sk_buff_head *frames,
+		      struct napi_struct *napi);
+void mt76_rx_poll_complete(struct mt76_dev *dev, enum mt76_rxq_id q,
+			   struct napi_struct *napi);
+void mt76_rx_aggr_reorder(struct sk_buff *skb, struct sk_buff_head *frames);
+void mt76_testmode_tx_pending(struct mt76_phy *phy);
+void mt76_queue_tx_complete(struct mt76_dev *dev, struct mt76_queue *q,
+			    struct mt76_queue_entry *e);
+int __mt76_set_channel(struct mt76_phy *phy, struct cfg80211_chan_def *chandef,
+		       bool offchannel);
+int mt76_set_channel(struct mt76_phy *phy, struct cfg80211_chan_def *chandef,
+		     bool offchannel);
+void mt76_scan_work(struct work_struct *work);
+void mt76_abort_scan(struct mt76_dev *dev);
+void mt76_roc_complete_work(struct work_struct *work);
+void mt76_abort_roc(struct mt76_phy *phy);
+struct mt76_vif_link *mt76_get_vif_phy_link(struct mt76_phy *phy,
+					    struct ieee80211_vif *vif);
+void mt76_put_vif_phy_link(struct mt76_phy *phy, struct ieee80211_vif *vif,
+			   struct mt76_vif_link *mlink);
+
+/* usb */
+static inline bool mt76u_urb_error(struct urb *urb)
+{
+	return urb->status &&
+	       urb->status != -ECONNRESET &&
+	       urb->status != -ESHUTDOWN &&
+	       urb->status != -ENOENT;
+}
+
+static inline int
+mt76u_bulk_msg(struct mt76_dev *dev, void *data, int len, int *actual_len,
+	       int timeout, int ep)
+{
+	struct usb_interface *uintf = to_usb_interface(dev->dev);
+	struct usb_device *udev = interface_to_usbdev(uintf);
+	struct mt76_usb *usb = &dev->usb;
+	unsigned int pipe;
+
+	if (actual_len)
+		pipe = usb_rcvbulkpipe(udev, usb->in_ep[ep]);
+	else
+		pipe = usb_sndbulkpipe(udev, usb->out_ep[ep]);
+
+	return usb_bulk_msg(udev, pipe, data, len, actual_len, timeout);
+}
+
+void mt76_ethtool_page_pool_stats(struct mt76_dev *dev, u64 *data, int *index);
+void mt76_ethtool_worker(struct mt76_ethtool_worker_info *wi,
+			 struct mt76_sta_stats *stats, bool eht);
+int mt76_skb_adjust_pad(struct sk_buff *skb, int pad);
+int __mt76u_vendor_request(struct mt76_dev *dev, u8 req, u8 req_type,
+			   u16 val, u16 offset, void *buf, size_t len);
+int mt76u_vendor_request(struct mt76_dev *dev, u8 req,
+			 u8 req_type, u16 val, u16 offset,
+			 void *buf, size_t len);
+void mt76u_single_wr(struct mt76_dev *dev, const u8 req,
+		     const u16 offset, const u32 val);
+void mt76u_read_copy(struct mt76_dev *dev, u32 offset,
+		     void *data, int len);
+u32 ___mt76u_rr(struct mt76_dev *dev, u8 req, u8 req_type, u32 addr);
+void ___mt76u_wr(struct mt76_dev *dev, u8 req, u8 req_type,
+		 u32 addr, u32 val);
+int __mt76u_init(struct mt76_dev *dev, struct usb_interface *intf,
+		 struct mt76_bus_ops *ops);
+int mt76u_init(struct mt76_dev *dev, struct usb_interface *intf);
+int mt76u_alloc_mcu_queue(struct mt76_dev *dev);
+int mt76u_alloc_queues(struct mt76_dev *dev);
+void mt76u_stop_tx(struct mt76_dev *dev);
+void mt76u_stop_rx(struct mt76_dev *dev);
+int mt76u_resume_rx(struct mt76_dev *dev);
+void mt76u_queues_deinit(struct mt76_dev *dev);
+
+int mt76s_init(struct mt76_dev *dev, struct sdio_func *func,
+	       const struct mt76_bus_ops *bus_ops);
+int mt76s_alloc_rx_queue(struct mt76_dev *dev, enum mt76_rxq_id qid);
+int mt76s_alloc_tx(struct mt76_dev *dev);
+void mt76s_deinit(struct mt76_dev *dev);
+void mt76s_sdio_irq(struct sdio_func *func);
+void mt76s_txrx_worker(struct mt76_sdio *sdio);
+bool mt76s_txqs_empty(struct mt76_dev *dev);
+int mt76s_hw_init(struct mt76_dev *dev, struct sdio_func *func,
+		  int hw_ver);
+u32 mt76s_rr(struct mt76_dev *dev, u32 offset);
+void mt76s_wr(struct mt76_dev *dev, u32 offset, u32 val);
+u32 mt76s_rmw(struct mt76_dev *dev, u32 offset, u32 mask, u32 val);
+u32 mt76s_read_pcr(struct mt76_dev *dev);
+void mt76s_write_copy(struct mt76_dev *dev, u32 offset,
+		      const void *data, int len);
+void mt76s_read_copy(struct mt76_dev *dev, u32 offset,
+		     void *data, int len);
+int mt76s_wr_rp(struct mt76_dev *dev, u32 base,
+		const struct mt76_reg_pair *data,
+		int len);
+int mt76s_rd_rp(struct mt76_dev *dev, u32 base,
+		struct mt76_reg_pair *data, int len);
+
+struct sk_buff *
+__mt76_mcu_msg_alloc(struct mt76_dev *dev, const void *data,
+		     int len, int data_len, gfp_t gfp);
+static inline struct sk_buff *
+mt76_mcu_msg_alloc(struct mt76_dev *dev, const void *data,
+		   int data_len)
+{
+	return __mt76_mcu_msg_alloc(dev, data, data_len, data_len, GFP_KERNEL);
+}
+
+void mt76_mcu_rx_event(struct mt76_dev *dev, struct sk_buff *skb);
+struct sk_buff *mt76_mcu_get_response(struct mt76_dev *dev,
+				      unsigned long expires);
+int mt76_mcu_send_and_get_msg(struct mt76_dev *dev, int cmd, const void *data,
+			      int len, bool wait_resp, struct sk_buff **ret);
+int mt76_mcu_skb_send_and_get_msg(struct mt76_dev *dev, struct sk_buff *skb,
+				  int cmd, bool wait_resp, struct sk_buff **ret);
+int __mt76_mcu_send_firmware(struct mt76_dev *dev, int cmd, const void *data,
+			     int len, int max_len);
+static inline int
+mt76_mcu_send_firmware(struct mt76_dev *dev, int cmd, const void *data,
+		       int len)
+{
+	int max_len = 4096 - dev->mcu_ops->headroom;
+
+	return __mt76_mcu_send_firmware(dev, cmd, data, len, max_len);
+}
+
+static inline int
+mt76_mcu_send_msg(struct mt76_dev *dev, int cmd, const void *data, int len,
+		  bool wait_resp)
+{
+	return mt76_mcu_send_and_get_msg(dev, cmd, data, len, wait_resp, NULL);
+}
+
+static inline int
+mt76_mcu_skb_send_msg(struct mt76_dev *dev, struct sk_buff *skb, int cmd,
+		      bool wait_resp)
+{
+	return mt76_mcu_skb_send_and_get_msg(dev, skb, cmd, wait_resp, NULL);
+}
+
+void mt76_set_irq_mask(struct mt76_dev *dev, u32 addr, u32 clear, u32 set);
+
+struct device_node *
+mt76_find_power_limits_node(struct mt76_dev *dev);
+struct device_node *
+mt76_find_channel_node(struct device_node *np, struct ieee80211_channel *chan);
+
+s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
+			      struct ieee80211_channel *chan,
+			      struct mt76_power_limits *dest,
+			      s8 target_power);
+
+static inline bool mt76_queue_is_rx(struct mt76_dev *dev, struct mt76_queue *q)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dev->q_rx); i++) {
+		if (q == &dev->q_rx[i])
+			return true;
+	}
+
+	return false;
+}
+
+static inline bool mt76_queue_is_wed_tx_free(struct mt76_queue *q)
+{
+	return (q->flags & MT_QFLAG_WED) &&
+	       FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_TXFREE;
+}
+
+static inline bool mt76_queue_is_wed_rro(struct mt76_queue *q)
+{
+	return q->flags & MT_QFLAG_WED_RRO;
+}
+
+static inline bool mt76_queue_is_wed_rro_ind(struct mt76_queue *q)
+{
+	return mt76_queue_is_wed_rro(q) &&
+	       FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_RRO_Q_IND;
+}
+
+static inline bool mt76_queue_is_wed_rro_data(struct mt76_queue *q)
+{
+	return mt76_queue_is_wed_rro(q) &&
+	       (FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_RRO_Q_DATA ||
+		FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_RRO_Q_MSDU_PG);
+}
+
+static inline bool mt76_queue_is_wed_rx(struct mt76_queue *q)
+{
+	if (!(q->flags & MT_QFLAG_WED))
+		return false;
+
+	return FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_RX ||
+	       mt76_queue_is_wed_rro_ind(q) || mt76_queue_is_wed_rro_data(q);
+
+}
+
+struct mt76_txwi_cache *
+mt76_token_release(struct mt76_dev *dev, int token, bool *wake);
+int mt76_token_consume(struct mt76_dev *dev, struct mt76_txwi_cache **ptxwi);
+void __mt76_set_tx_blocked(struct mt76_dev *dev, bool blocked);
+struct mt76_txwi_cache *mt76_rx_token_release(struct mt76_dev *dev, int token);
+int mt76_rx_token_consume(struct mt76_dev *dev, void *ptr,
+			  struct mt76_txwi_cache *r, dma_addr_t phys);
+int mt76_create_page_pool(struct mt76_dev *dev, struct mt76_queue *q);
+static inline void mt76_put_page_pool_buf(void *buf, bool allow_direct)
+{
+	struct page *page = virt_to_head_page(buf);
+
+	page_pool_put_full_page(page->pp, page, allow_direct);
+}
+
+static inline void *
+mt76_get_page_pool_buf(struct mt76_queue *q, u32 *offset, u32 size)
+{
+	struct page *page;
+
+	page = page_pool_dev_alloc_frag(q->page_pool, offset, size);
+	if (!page)
+		return NULL;
+
+	return page_address(page) + *offset;
+}
+
+static inline void mt76_set_tx_blocked(struct mt76_dev *dev, bool blocked)
+{
+	spin_lock_bh(&dev->token_lock);
+	__mt76_set_tx_blocked(dev, blocked);
+	spin_unlock_bh(&dev->token_lock);
+}
+
+static inline int
+mt76_token_get(struct mt76_dev *dev, struct mt76_txwi_cache **ptxwi)
+{
+	int token;
+
+	spin_lock_bh(&dev->token_lock);
+	token = idr_alloc(&dev->token, *ptxwi, 0, dev->token_size, GFP_ATOMIC);
+	spin_unlock_bh(&dev->token_lock);
+
+	return token;
+}
+
+static inline struct mt76_txwi_cache *
+mt76_token_put(struct mt76_dev *dev, int token)
+{
+	struct mt76_txwi_cache *txwi;
+
+	spin_lock_bh(&dev->token_lock);
+	txwi = idr_remove(&dev->token, token);
+	spin_unlock_bh(&dev->token_lock);
+
+	return txwi;
+}
+
+void mt76_wcid_init(struct mt76_wcid *wcid, u8 band_idx);
+void mt76_wcid_cleanup(struct mt76_dev *dev, struct mt76_wcid *wcid);
+void mt76_wcid_add_poll(struct mt76_dev *dev, struct mt76_wcid *wcid);
+
+static inline void
+mt76_vif_init(struct ieee80211_vif *vif, struct mt76_vif_data *mvif)
+{
+	struct mt76_vif_link *mlink = (struct mt76_vif_link *)vif->drv_priv;
+
+	mlink->mvif = mvif;
+	rcu_assign_pointer(mvif->link[0], mlink);
+}
+
+void mt76_vif_cleanup(struct mt76_dev *dev, struct ieee80211_vif *vif);
+
+static inline struct mt76_vif_link *
+mt76_vif_link(struct mt76_dev *dev, struct ieee80211_vif *vif, int link_id)
+{
+	struct mt76_vif_link *mlink = (struct mt76_vif_link *)vif->drv_priv;
+	struct mt76_vif_data *mvif = mlink->mvif;
+
+	return mt76_dereference(mvif->link[link_id], dev);
+}
+
+static inline struct mt76_vif_link *
+mt76_vif_conf_link(struct mt76_dev *dev, struct ieee80211_vif *vif,
+		   struct ieee80211_bss_conf *link_conf)
+{
+	struct mt76_vif_link *mlink = (struct mt76_vif_link *)vif->drv_priv;
+	struct mt76_vif_data *mvif = mlink->mvif;
+
+	if (link_conf == &vif->bss_conf)
+		return mlink;
+
+	return mt76_dereference(mvif->link[link_conf->link_id], dev);
+}
+
+static inline struct mt76_phy *
+mt76_vif_link_phy(struct mt76_vif_link *mlink)
+{
+	struct mt76_chanctx *ctx;
+
+	if (!mlink->ctx)
+		return NULL;
+
+	ctx = (struct mt76_chanctx *)mlink->ctx->drv_priv;
+
+	return ctx->phy;
+}
+
+#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c.orig b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c.orig
new file mode 100644
index 000000000000..ee5177fd6dde
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c.orig
@@ -0,0 +1,1196 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#include "mt76_connac.h"
+#include "mt76_connac2_mac.h"
+#include "dma.h"
+
+#define HE_BITS(f)		cpu_to_le16(IEEE80211_RADIOTAP_HE_##f)
+#define HE_PREP(f, m, v)	le16_encode_bits(le32_get_bits(v, MT_CRXV_HE_##m),\
+						 IEEE80211_RADIOTAP_HE_##f)
+
+void mt76_connac_gen_ppe_thresh(u8 *he_ppet, int nss)
+{
+	static const u8 ppet16_ppet8_ru3_ru0[] = { 0x1c, 0xc7, 0x71 };
+	u8 i, ppet_bits, ppet_size, ru_bit_mask = 0x7; /* HE80 */
+
+	he_ppet[0] = FIELD_PREP(IEEE80211_PPE_THRES_NSS_MASK, nss - 1) |
+		     FIELD_PREP(IEEE80211_PPE_THRES_RU_INDEX_BITMASK_MASK,
+				ru_bit_mask);
+
+	ppet_bits = IEEE80211_PPE_THRES_INFO_PPET_SIZE *
+		    nss * hweight8(ru_bit_mask) * 2;
+	ppet_size = DIV_ROUND_UP(ppet_bits, 8);
+
+	for (i = 0; i < ppet_size - 1; i++)
+		he_ppet[i + 1] = ppet16_ppet8_ru3_ru0[i % 3];
+
+	he_ppet[i + 1] = ppet16_ppet8_ru3_ru0[i % 3] &
+			 (0xff >> (8 - (ppet_bits - 1) % 8));
+}
+EXPORT_SYMBOL_GPL(mt76_connac_gen_ppe_thresh);
+
+int mt76_connac_pm_wake(struct mt76_phy *phy, struct mt76_connac_pm *pm)
+{
+	struct mt76_dev *dev = phy->dev;
+
+	if (mt76_is_usb(dev))
+		return 0;
+
+	cancel_delayed_work_sync(&pm->ps_work);
+	if (!test_bit(MT76_STATE_PM, &phy->state))
+		return 0;
+
+	if (pm->suspended)
+		return 0;
+
+	queue_work(dev->wq, &pm->wake_work);
+	if (!wait_event_timeout(pm->wait,
+				!test_bit(MT76_STATE_PM, &phy->state),
+				3 * HZ)) {
+		ieee80211_wake_queues(phy->hw);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_pm_wake);
+
+void mt76_connac_power_save_sched(struct mt76_phy *phy,
+				  struct mt76_connac_pm *pm)
+{
+	struct mt76_dev *dev = phy->dev;
+
+	if (mt76_is_usb(dev))
+		return;
+
+	if (!pm->enable)
+		return;
+
+	if (pm->suspended)
+		return;
+
+	pm->last_activity = jiffies;
+
+	if (!test_bit(MT76_STATE_PM, &phy->state)) {
+		cancel_delayed_work(&phy->mac_work);
+		queue_delayed_work(dev->wq, &pm->ps_work, pm->idle_timeout);
+	}
+}
+EXPORT_SYMBOL_GPL(mt76_connac_power_save_sched);
+
+void mt76_connac_free_pending_tx_skbs(struct mt76_connac_pm *pm,
+				      struct mt76_wcid *wcid)
+{
+	int i;
+
+	spin_lock_bh(&pm->txq_lock);
+	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+		if (wcid && pm->tx_q[i].wcid != wcid)
+			continue;
+
+		dev_kfree_skb(pm->tx_q[i].skb);
+		pm->tx_q[i].skb = NULL;
+	}
+	spin_unlock_bh(&pm->txq_lock);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_free_pending_tx_skbs);
+
+void mt76_connac_pm_queue_skb(struct ieee80211_hw *hw,
+			      struct mt76_connac_pm *pm,
+			      struct mt76_wcid *wcid,
+			      struct sk_buff *skb)
+{
+	int qid = skb_get_queue_mapping(skb);
+	struct mt76_phy *phy = hw->priv;
+
+	spin_lock_bh(&pm->txq_lock);
+	if (!pm->tx_q[qid].skb) {
+		ieee80211_stop_queues(hw);
+		pm->tx_q[qid].wcid = wcid;
+		pm->tx_q[qid].skb = skb;
+		queue_work(phy->dev->wq, &pm->wake_work);
+	} else {
+		dev_kfree_skb(skb);
+	}
+	spin_unlock_bh(&pm->txq_lock);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_pm_queue_skb);
+
+void mt76_connac_pm_dequeue_skbs(struct mt76_phy *phy,
+				 struct mt76_connac_pm *pm)
+{
+	int i;
+
+	spin_lock_bh(&pm->txq_lock);
+	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+		struct mt76_wcid *wcid = pm->tx_q[i].wcid;
+		struct ieee80211_sta *sta = NULL;
+
+		if (!pm->tx_q[i].skb)
+			continue;
+
+		if (wcid && wcid->sta)
+			sta = container_of((void *)wcid, struct ieee80211_sta,
+					   drv_priv);
+
+		mt76_tx(phy, sta, wcid, pm->tx_q[i].skb);
+		pm->tx_q[i].skb = NULL;
+	}
+	spin_unlock_bh(&pm->txq_lock);
+
+	mt76_worker_schedule(&phy->dev->tx_worker);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_pm_dequeue_skbs);
+
+void mt76_connac_tx_complete_skb(struct mt76_dev *mdev,
+				 struct mt76_queue_entry *e)
+{
+	if (!e->txwi) {
+		dev_kfree_skb_any(e->skb);
+		return;
+	}
+
+	/* error path */
+	if (e->skb == DMA_DUMMY_DATA) {
+		struct mt76_connac_txp_common *txp;
+		struct mt76_txwi_cache *t;
+		u16 token;
+
+		txp = mt76_connac_txwi_to_txp(mdev, e->txwi);
+		if (is_mt76_fw_txp(mdev))
+			token = le16_to_cpu(txp->fw.token);
+		else
+			token = le16_to_cpu(txp->hw.msdu_id[0]) &
+				~MT_MSDU_ID_VALID;
+
+		t = mt76_token_put(mdev, token);
+		e->skb = t ? t->skb : NULL;
+	}
+
+	if (e->skb)
+		mt76_tx_complete_skb(mdev, e->wcid, e->skb);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_tx_complete_skb);
+
+void mt76_connac_write_hw_txp(struct mt76_dev *dev,
+			      struct mt76_tx_info *tx_info,
+			      void *txp_ptr, u32 id)
+{
+	struct mt76_connac_hw_txp *txp = txp_ptr;
+	struct mt76_connac_txp_ptr *ptr = &txp->ptr[0];
+	int i, nbuf = tx_info->nbuf - 1;
+	u32 last_mask;
+
+	tx_info->buf[0].len = MT_TXD_SIZE + sizeof(*txp);
+	tx_info->nbuf = 1;
+
+	txp->msdu_id[0] = cpu_to_le16(id | MT_MSDU_ID_VALID);
+
+	if (is_mt7663(dev) || is_mt7921(dev))
+		last_mask = MT_TXD_LEN_LAST;
+	else
+		last_mask = MT_TXD_LEN_AMSDU_LAST |
+			    MT_TXD_LEN_MSDU_LAST;
+
+	for (i = 0; i < nbuf; i++) {
+		u16 len = tx_info->buf[i + 1].len & MT_TXD_LEN_MASK;
+		u32 addr = tx_info->buf[i + 1].addr;
+
+		if (i == nbuf - 1)
+			len |= last_mask;
+
+		if (i & 1) {
+			ptr->buf1 = cpu_to_le32(addr);
+			ptr->len1 = cpu_to_le16(len);
+			ptr++;
+		} else {
+			ptr->buf0 = cpu_to_le32(addr);
+			ptr->len0 = cpu_to_le16(len);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(mt76_connac_write_hw_txp);
+
+static void
+mt76_connac_txp_skb_unmap_fw(struct mt76_dev *mdev,
+			     struct mt76_connac_fw_txp *txp)
+{
+	struct device *dev = is_connac_v1(mdev) ? mdev->dev : mdev->dma_dev;
+	int i;
+
+	for (i = 0; i < txp->nbuf; i++)
+		dma_unmap_single(dev, le32_to_cpu(txp->buf[i]),
+				 le16_to_cpu(txp->len[i]), DMA_TO_DEVICE);
+}
+
+static void
+mt76_connac_txp_skb_unmap_hw(struct mt76_dev *dev,
+			     struct mt76_connac_hw_txp *txp)
+{
+	u32 last_mask;
+	int i;
+
+	if (is_mt7663(dev) || is_mt7921(dev))
+		last_mask = MT_TXD_LEN_LAST;
+	else
+		last_mask = MT_TXD_LEN_MSDU_LAST;
+
+	for (i = 0; i < ARRAY_SIZE(txp->ptr); i++) {
+		struct mt76_connac_txp_ptr *ptr = &txp->ptr[i];
+		bool last;
+		u16 len;
+
+		len = le16_to_cpu(ptr->len0);
+		last = len & last_mask;
+		len &= MT_TXD_LEN_MASK;
+		dma_unmap_single(dev->dev, le32_to_cpu(ptr->buf0), len,
+				 DMA_TO_DEVICE);
+		if (last)
+			break;
+
+		len = le16_to_cpu(ptr->len1);
+		last = len & last_mask;
+		len &= MT_TXD_LEN_MASK;
+		dma_unmap_single(dev->dev, le32_to_cpu(ptr->buf1), len,
+				 DMA_TO_DEVICE);
+		if (last)
+			break;
+	}
+}
+
+void mt76_connac_txp_skb_unmap(struct mt76_dev *dev,
+			       struct mt76_txwi_cache *t)
+{
+	struct mt76_connac_txp_common *txp;
+
+	txp = mt76_connac_txwi_to_txp(dev, t);
+	if (is_mt76_fw_txp(dev))
+		mt76_connac_txp_skb_unmap_fw(dev, &txp->fw);
+	else
+		mt76_connac_txp_skb_unmap_hw(dev, &txp->hw);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_txp_skb_unmap);
+
+int mt76_connac_init_tx_queues(struct mt76_phy *phy, int idx, int n_desc,
+			       int ring_base, u32 flags)
+{
+	int i, err;
+
+	err = mt76_init_tx_queue(phy, 0, idx, n_desc, ring_base, flags);
+	if (err < 0)
+		return err;
+
+	for (i = 1; i <= MT_TXQ_PSD; i++)
+		phy->q_tx[i] = phy->q_tx[0];
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_init_tx_queues);
+
+#define __bitrate_mask_check(_mcs, _mode)				\
+({									\
+	u8 i = 0;							\
+	for (nss = 0; i < ARRAY_SIZE(mask->control[band]._mcs); i++) {	\
+		if (!mask->control[band]._mcs[i])			\
+			continue;					\
+		if (hweight16(mask->control[band]._mcs[i]) == 1) {	\
+			mode = MT_PHY_TYPE_##_mode;			\
+			rateidx = ffs(mask->control[band]._mcs[i]) - 1;	\
+			if (mode == MT_PHY_TYPE_HT)			\
+				rateidx += 8 * i;			\
+			else						\
+				nss = i + 1;				\
+			goto out;					\
+		}							\
+	}								\
+})
+
+u16 mt76_connac2_mac_tx_rate_val(struct mt76_phy *mphy,
+				 struct ieee80211_vif *vif,
+				 bool beacon, bool mcast)
+{
+	u8 nss = 0, mode = 0, band = mphy->chandef.chan->band;
+	int rateidx = 0, mcast_rate;
+
+	if (!vif)
+		goto legacy;
+
+	if (is_mt7921(mphy->dev)) {
+		rateidx = ffs(vif->bss_conf.basic_rates) - 1;
+		goto legacy;
+	}
+
+	if (beacon) {
+		struct cfg80211_bitrate_mask *mask;
+
+		mask = &vif->bss_conf.beacon_tx_rate;
+
+		__bitrate_mask_check(he_mcs, HE_SU);
+		__bitrate_mask_check(vht_mcs, VHT);
+		__bitrate_mask_check(ht_mcs, HT);
+
+		if (hweight32(mask->control[band].legacy) == 1) {
+			rateidx = ffs(mask->control[band].legacy) - 1;
+			goto legacy;
+		}
+	}
+
+	mcast_rate = vif->bss_conf.mcast_rate[band];
+	if (mcast && mcast_rate > 0)
+		rateidx = mcast_rate - 1;
+	else
+		rateidx = ffs(vif->bss_conf.basic_rates) - 1;
+
+legacy:
+	rateidx = mt76_calculate_default_rate(mphy, rateidx);
+	mode = rateidx >> 8;
+	rateidx &= GENMASK(7, 0);
+out:
+	return FIELD_PREP(MT_TX_RATE_NSS, nss) |
+	       FIELD_PREP(MT_TX_RATE_IDX, rateidx) |
+	       FIELD_PREP(MT_TX_RATE_MODE, mode);
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_mac_tx_rate_val);
+
+static void
+mt76_connac2_mac_write_txwi_8023(__le32 *txwi, struct sk_buff *skb,
+				 struct mt76_wcid *wcid)
+{
+	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
+	u8 fc_type, fc_stype;
+	u16 ethertype;
+	bool wmm = false;
+	u32 val;
+
+	if (wcid->sta) {
+		struct ieee80211_sta *sta;
+
+		sta = container_of((void *)wcid, struct ieee80211_sta, drv_priv);
+		wmm = sta->wme;
+	}
+
+	val = FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_3) |
+	      FIELD_PREP(MT_TXD1_TID, tid);
+
+	ethertype = get_unaligned_be16(&skb->data[12]);
+	if (ethertype >= ETH_P_802_3_MIN)
+		val |= MT_TXD1_ETH_802_3;
+
+	txwi[1] |= cpu_to_le32(val);
+
+	fc_type = IEEE80211_FTYPE_DATA >> 2;
+	fc_stype = wmm ? IEEE80211_STYPE_QOS_DATA >> 4 : 0;
+
+	val = FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
+	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype);
+
+	txwi[2] |= cpu_to_le32(val);
+
+	val = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
+	      FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
+
+	txwi[7] |= cpu_to_le32(val);
+}
+
+static void
+mt76_connac2_mac_write_txwi_80211(struct mt76_dev *dev, __le32 *txwi,
+				  struct sk_buff *skb,
+				  struct ieee80211_key_conf *key)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	bool multicast = is_multicast_ether_addr(hdr->addr1);
+	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
+	__le16 fc = hdr->frame_control;
+	u8 fc_type, fc_stype;
+	u32 val;
+
+	if (ieee80211_is_action(fc) &&
+	    mgmt->u.action.category == WLAN_CATEGORY_BACK &&
+	    mgmt->u.action.u.addba_req.action_code == WLAN_ACTION_ADDBA_REQ) {
+		u16 capab = le16_to_cpu(mgmt->u.action.u.addba_req.capab);
+
+		txwi[5] |= cpu_to_le32(MT_TXD5_ADD_BA);
+		tid = (capab >> 2) & IEEE80211_QOS_CTL_TID_MASK;
+	} else if (ieee80211_is_back_req(hdr->frame_control)) {
+		struct ieee80211_bar *bar = (struct ieee80211_bar *)hdr;
+		u16 control = le16_to_cpu(bar->control);
+
+		tid = FIELD_GET(IEEE80211_BAR_CTRL_TID_INFO_MASK, control);
+	}
+
+	val = FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_11) |
+	      FIELD_PREP(MT_TXD1_HDR_INFO,
+			 ieee80211_get_hdrlen_from_skb(skb) / 2) |
+	      FIELD_PREP(MT_TXD1_TID, tid);
+
+	txwi[1] |= cpu_to_le32(val);
+
+	fc_type = (le16_to_cpu(fc) & IEEE80211_FCTL_FTYPE) >> 2;
+	fc_stype = (le16_to_cpu(fc) & IEEE80211_FCTL_STYPE) >> 4;
+
+	val = FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
+	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype) |
+	      FIELD_PREP(MT_TXD2_MULTICAST, multicast);
+
+	if (key && multicast && ieee80211_is_robust_mgmt_frame(skb) &&
+	    key->cipher == WLAN_CIPHER_SUITE_AES_CMAC) {
+		val |= MT_TXD2_BIP;
+		txwi[3] &= ~cpu_to_le32(MT_TXD3_PROTECT_FRAME);
+	}
+
+	if (!ieee80211_is_data(fc) || multicast ||
+	    info->flags & IEEE80211_TX_CTL_USE_MINRATE)
+		val |= MT_TXD2_FIX_RATE;
+
+	txwi[2] |= cpu_to_le32(val);
+
+	if (ieee80211_is_beacon(fc)) {
+		txwi[3] &= ~cpu_to_le32(MT_TXD3_SW_POWER_MGMT);
+		txwi[3] |= cpu_to_le32(MT_TXD3_REM_TX_COUNT);
+	}
+
+	if (info->flags & IEEE80211_TX_CTL_INJECTED) {
+		u16 seqno = le16_to_cpu(hdr->seq_ctrl);
+
+		if (ieee80211_is_back_req(hdr->frame_control)) {
+			struct ieee80211_bar *bar;
+
+			bar = (struct ieee80211_bar *)skb->data;
+			seqno = le16_to_cpu(bar->start_seq_num);
+		}
+
+		val = MT_TXD3_SN_VALID |
+		      FIELD_PREP(MT_TXD3_SEQ, IEEE80211_SEQ_TO_SN(seqno));
+		txwi[3] |= cpu_to_le32(val);
+		txwi[7] &= ~cpu_to_le32(MT_TXD7_HW_AMSDU);
+	}
+
+	if (mt76_is_mmio(dev)) {
+		val = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
+		      FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
+		txwi[7] |= cpu_to_le32(val);
+	} else {
+		val = FIELD_PREP(MT_TXD8_L_TYPE, fc_type) |
+		      FIELD_PREP(MT_TXD8_L_SUB_TYPE, fc_stype);
+		txwi[8] |= cpu_to_le32(val);
+	}
+}
+
+void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
+				 struct sk_buff *skb, struct mt76_wcid *wcid,
+				 struct ieee80211_key_conf *key, int pid,
+				 enum mt76_txq_id qid, u32 changed)
+{
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	u8 phy_idx = (info->hw_queue & MT_TX_HW_QUEUE_PHY) >> 2;
+	struct ieee80211_vif *vif = info->control.vif;
+	struct mt76_phy *mphy = &dev->phy;
+	u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0, band_idx = 0;
+	u32 val, sz_txd = mt76_is_mmio(dev) ? MT_TXD_SIZE : MT_SDIO_TXD_SIZE;
+	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
+	bool beacon = !!(changed & (BSS_CHANGED_BEACON |
+				    BSS_CHANGED_BEACON_ENABLED));
+	bool inband_disc = !!(changed & (BSS_CHANGED_UNSOL_BCAST_PROBE_RESP |
+					 BSS_CHANGED_FILS_DISCOVERY));
+	bool amsdu_en = wcid->amsdu;
+
+	if (vif) {
+		struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+
+		omac_idx = mvif->omac_idx;
+		wmm_idx = mvif->wmm_idx;
+		band_idx = mvif->band_idx;
+	}
+
+	if (phy_idx && dev->phys[MT_BAND1])
+		mphy = dev->phys[MT_BAND1];
+
+	if (inband_disc) {
+		p_fmt = MT_TX_TYPE_FW;
+		q_idx = MT_LMAC_ALTX0;
+	} else if (beacon) {
+		p_fmt = MT_TX_TYPE_FW;
+		q_idx = MT_LMAC_BCN0;
+	} else if (qid >= MT_TXQ_PSD) {
+		p_fmt = mt76_is_mmio(dev) ? MT_TX_TYPE_CT : MT_TX_TYPE_SF;
+		q_idx = MT_LMAC_ALTX0;
+	} else {
+		p_fmt = mt76_is_mmio(dev) ? MT_TX_TYPE_CT : MT_TX_TYPE_SF;
+		q_idx = wmm_idx * MT76_CONNAC_MAX_WMM_SETS +
+			mt76_connac_lmac_mapping(skb_get_queue_mapping(skb));
+
+		/* mt7915 WA only counts WED path */
+		if (is_mt7915(dev) && mtk_wed_device_active(&dev->mmio.wed))
+			wcid->stats.tx_packets++;
+	}
+
+	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len + sz_txd) |
+	      FIELD_PREP(MT_TXD0_PKT_FMT, p_fmt) |
+	      FIELD_PREP(MT_TXD0_Q_IDX, q_idx);
+	txwi[0] = cpu_to_le32(val);
+
+	val = MT_TXD1_LONG_FORMAT |
+	      FIELD_PREP(MT_TXD1_WLAN_IDX, wcid->idx) |
+	      FIELD_PREP(MT_TXD1_OWN_MAC, omac_idx);
+	if (!is_mt7921(dev))
+		val |= MT_TXD1_VTA;
+	if (phy_idx || band_idx)
+		val |= MT_TXD1_TGID;
+
+	txwi[1] = cpu_to_le32(val);
+	txwi[2] = 0;
+
+	val = FIELD_PREP(MT_TXD3_REM_TX_COUNT, 15);
+	if (!is_mt7921(dev))
+		val |= MT_TXD3_SW_POWER_MGMT;
+	if (key)
+		val |= MT_TXD3_PROTECT_FRAME;
+	if (info->flags & IEEE80211_TX_CTL_NO_ACK)
+		val |= MT_TXD3_NO_ACK;
+
+	txwi[3] = cpu_to_le32(val);
+	txwi[4] = 0;
+
+	val = FIELD_PREP(MT_TXD5_PID, pid);
+	if (pid >= MT_PACKET_ID_FIRST) {
+		val |= MT_TXD5_TX_STATUS_HOST;
+		amsdu_en = amsdu_en && !is_mt7921(dev);
+	}
+
+	txwi[5] = cpu_to_le32(val);
+	txwi[6] = 0;
+	txwi[7] = amsdu_en ? cpu_to_le32(MT_TXD7_HW_AMSDU) : 0;
+
+	if (is_8023)
+		mt76_connac2_mac_write_txwi_8023(txwi, skb, wcid);
+	else
+		mt76_connac2_mac_write_txwi_80211(dev, txwi, skb, key);
+
+	if (txwi[2] & cpu_to_le32(MT_TXD2_FIX_RATE)) {
+		/* Fixed rata is available just for 802.11 txd */
+		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+		bool multicast = ieee80211_is_data(hdr->frame_control) &&
+				 is_multicast_ether_addr(hdr->addr1);
+		u16 rate = mt76_connac2_mac_tx_rate_val(mphy, vif, beacon,
+							multicast);
+		u32 val = MT_TXD6_FIXED_BW;
+
+		/* hardware won't add HTC for mgmt/ctrl frame */
+		txwi[2] |= cpu_to_le32(MT_TXD2_HTC_VLD);
+
+		val |= FIELD_PREP(MT_TXD6_TX_RATE, rate);
+		txwi[6] |= cpu_to_le32(val);
+		txwi[3] |= cpu_to_le32(MT_TXD3_BA_DISABLE);
+
+		if (!is_mt7921(dev)) {
+			u8 spe_idx = mt76_connac_spe_idx(mphy->antenna_mask);
+
+			if (!spe_idx)
+				spe_idx = 24 + phy_idx;
+			txwi[7] |= cpu_to_le32(FIELD_PREP(MT_TXD7_SPE_IDX, spe_idx));
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_mac_write_txwi);
+
+bool mt76_connac2_mac_fill_txs(struct mt76_dev *dev, struct mt76_wcid *wcid,
+			       __le32 *txs_data)
+{
+	struct mt76_sta_stats *stats = &wcid->stats;
+	struct ieee80211_supported_band *sband;
+	struct mt76_phy *mphy;
+	struct rate_info rate = {};
+	bool cck = false;
+	u32 txrate, txs, mode, stbc;
+
+	txs = le32_to_cpu(txs_data[0]);
+
+	/* PPDU based reporting */
+	if (mtk_wed_device_active(&dev->mmio.wed) &&
+	    FIELD_GET(MT_TXS0_TXS_FORMAT, txs) > 1) {
+		stats->tx_bytes +=
+			le32_get_bits(txs_data[5], MT_TXS5_MPDU_TX_BYTE) -
+			le32_get_bits(txs_data[7], MT_TXS7_MPDU_RETRY_BYTE);
+		stats->tx_failed +=
+			le32_get_bits(txs_data[6], MT_TXS6_MPDU_FAIL_CNT);
+		stats->tx_retries +=
+			le32_get_bits(txs_data[7], MT_TXS7_MPDU_RETRY_CNT);
+
+		if (wcid->sta) {
+			struct ieee80211_sta *sta;
+			u8 tid;
+
+			sta = container_of((void *)wcid, struct ieee80211_sta,
+					   drv_priv);
+			tid = FIELD_GET(MT_TXS0_TID, txs);
+
+			ieee80211_refresh_tx_agg_session_timer(sta, tid);
+		}
+	}
+
+	txrate = FIELD_GET(MT_TXS0_TX_RATE, txs);
+
+	rate.mcs = FIELD_GET(MT_TX_RATE_IDX, txrate);
+	rate.nss = FIELD_GET(MT_TX_RATE_NSS, txrate) + 1;
+	stbc = FIELD_GET(MT_TX_RATE_STBC, txrate);
+
+	if (stbc && rate.nss > 1)
+		rate.nss >>= 1;
+
+	if (rate.nss - 1 < ARRAY_SIZE(stats->tx_nss))
+		stats->tx_nss[rate.nss - 1]++;
+	if (rate.mcs < ARRAY_SIZE(stats->tx_mcs))
+		stats->tx_mcs[rate.mcs]++;
+
+	mode = FIELD_GET(MT_TX_RATE_MODE, txrate);
+	switch (mode) {
+	case MT_PHY_TYPE_CCK:
+		cck = true;
+		fallthrough;
+	case MT_PHY_TYPE_OFDM:
+		mphy = &dev->phy;
+		if (wcid->phy_idx == MT_BAND1 && dev->phys[MT_BAND1])
+			mphy = dev->phys[MT_BAND1];
+
+		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
+			sband = &mphy->sband_5g.sband;
+		else if (mphy->chandef.chan->band == NL80211_BAND_6GHZ)
+			sband = &mphy->sband_6g.sband;
+		else
+			sband = &mphy->sband_2g.sband;
+
+		rate.mcs = mt76_get_rate(mphy->dev, sband, rate.mcs, cck);
+		rate.legacy = sband->bitrates[rate.mcs].bitrate;
+		break;
+	case MT_PHY_TYPE_HT:
+	case MT_PHY_TYPE_HT_GF:
+		if (rate.mcs > 31)
+			return false;
+
+		rate.flags = RATE_INFO_FLAGS_MCS;
+		if (wcid->rate.flags & RATE_INFO_FLAGS_SHORT_GI)
+			rate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+		break;
+	case MT_PHY_TYPE_VHT:
+		if (rate.mcs > 9)
+			return false;
+
+		rate.flags = RATE_INFO_FLAGS_VHT_MCS;
+		break;
+	case MT_PHY_TYPE_HE_SU:
+	case MT_PHY_TYPE_HE_EXT_SU:
+	case MT_PHY_TYPE_HE_TB:
+	case MT_PHY_TYPE_HE_MU:
+		if (rate.mcs > 11)
+			return false;
+
+		rate.he_gi = wcid->rate.he_gi;
+		rate.he_dcm = FIELD_GET(MT_TX_RATE_DCM, txrate);
+		rate.flags = RATE_INFO_FLAGS_HE_MCS;
+		break;
+	default:
+		return false;
+	}
+
+	stats->tx_mode[mode]++;
+
+	switch (FIELD_GET(MT_TXS0_BW, txs)) {
+	case IEEE80211_STA_RX_BW_160:
+		rate.bw = RATE_INFO_BW_160;
+		stats->tx_bw[3]++;
+		break;
+	case IEEE80211_STA_RX_BW_80:
+		rate.bw = RATE_INFO_BW_80;
+		stats->tx_bw[2]++;
+		break;
+	case IEEE80211_STA_RX_BW_40:
+		rate.bw = RATE_INFO_BW_40;
+		stats->tx_bw[1]++;
+		break;
+	default:
+		rate.bw = RATE_INFO_BW_20;
+		stats->tx_bw[0]++;
+		break;
+	}
+	wcid->rate = rate;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_mac_fill_txs);
+
+bool mt76_connac2_mac_add_txs_skb(struct mt76_dev *dev, struct mt76_wcid *wcid,
+				  int pid, __le32 *txs_data)
+{
+	struct sk_buff_head list;
+	struct sk_buff *skb;
+
+	mt76_tx_status_lock(dev, &list);
+	skb = mt76_tx_status_skb_get(dev, wcid, pid, &list);
+	if (skb) {
+		struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+
+		if (!(le32_to_cpu(txs_data[0]) & MT_TXS0_ACK_ERROR_MASK))
+			info->flags |= IEEE80211_TX_STAT_ACK;
+
+		info->status.ampdu_len = 1;
+		info->status.ampdu_ack_len =
+			!!(info->flags & IEEE80211_TX_STAT_ACK);
+		info->status.rates[0].idx = -1;
+
+		mt76_connac2_mac_fill_txs(dev, wcid, txs_data);
+		mt76_tx_status_skb_done(dev, skb, &list);
+	}
+	mt76_tx_status_unlock(dev, &list);
+
+	return !!skb;
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_mac_add_txs_skb);
+
+static void
+mt76_connac2_mac_decode_he_radiotap_ru(struct mt76_rx_status *status,
+				       struct ieee80211_radiotap_he *he,
+				       __le32 *rxv)
+{
+	u32 ru_h, ru_l;
+	u8 ru, offs = 0;
+
+	ru_l = le32_get_bits(rxv[0], MT_PRXV_HE_RU_ALLOC_L);
+	ru_h = le32_get_bits(rxv[1], MT_PRXV_HE_RU_ALLOC_H);
+	ru = (u8)(ru_l | ru_h << 4);
+
+	status->bw = RATE_INFO_BW_HE_RU;
+
+	switch (ru) {
+	case 0 ... 36:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_26;
+		offs = ru;
+		break;
+	case 37 ... 52:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_52;
+		offs = ru - 37;
+		break;
+	case 53 ... 60:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_106;
+		offs = ru - 53;
+		break;
+	case 61 ... 64:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_242;
+		offs = ru - 61;
+		break;
+	case 65 ... 66:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_484;
+		offs = ru - 65;
+		break;
+	case 67:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_996;
+		break;
+	case 68:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_2x996;
+		break;
+	}
+
+	he->data1 |= HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
+	he->data2 |= HE_BITS(DATA2_RU_OFFSET_KNOWN) |
+		     le16_encode_bits(offs,
+				      IEEE80211_RADIOTAP_HE_DATA2_RU_OFFSET);
+}
+
+static void
+mt76_connac2_mac_decode_he_mu_radiotap(struct mt76_dev *dev, struct sk_buff *skb,
+				       __le32 *rxv)
+{
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	static struct ieee80211_radiotap_he_mu mu_known = {
+		.flags1 = HE_BITS(MU_FLAGS1_SIG_B_MCS_KNOWN) |
+			  HE_BITS(MU_FLAGS1_SIG_B_DCM_KNOWN) |
+			  HE_BITS(MU_FLAGS1_CH1_RU_KNOWN) |
+			  HE_BITS(MU_FLAGS1_SIG_B_SYMS_USERS_KNOWN),
+		.flags2 = HE_BITS(MU_FLAGS2_BW_FROM_SIG_A_BW_KNOWN),
+	};
+	struct ieee80211_radiotap_he_mu *he_mu;
+
+	if (is_mt7921(dev)) {
+		mu_known.flags1 |= HE_BITS(MU_FLAGS1_SIG_B_COMP_KNOWN);
+		mu_known.flags2 |= HE_BITS(MU_FLAGS2_PUNC_FROM_SIG_A_BW_KNOWN);
+	}
+
+	status->flag |= RX_FLAG_RADIOTAP_HE_MU;
+
+	he_mu = skb_push(skb, sizeof(mu_known));
+	memcpy(he_mu, &mu_known, sizeof(mu_known));
+
+#define MU_PREP(f, v)	le16_encode_bits(v, IEEE80211_RADIOTAP_HE_MU_##f)
+
+	he_mu->flags1 |= MU_PREP(FLAGS1_SIG_B_MCS, status->rate_idx);
+	if (status->he_dcm)
+		he_mu->flags1 |= MU_PREP(FLAGS1_SIG_B_DCM, status->he_dcm);
+
+	he_mu->flags2 |= MU_PREP(FLAGS2_BW_FROM_SIG_A_BW, status->bw) |
+			 MU_PREP(FLAGS2_SIG_B_SYMS_USERS,
+				 le32_get_bits(rxv[2], MT_CRXV_HE_NUM_USER));
+
+	he_mu->ru_ch1[0] = le32_get_bits(rxv[3], MT_CRXV_HE_RU0);
+
+	if (status->bw >= RATE_INFO_BW_40) {
+		he_mu->flags1 |= HE_BITS(MU_FLAGS1_CH2_RU_KNOWN);
+		he_mu->ru_ch2[0] =
+			le32_get_bits(rxv[3], MT_CRXV_HE_RU1);
+	}
+
+	if (status->bw >= RATE_INFO_BW_80) {
+		he_mu->ru_ch1[1] =
+			le32_get_bits(rxv[3], MT_CRXV_HE_RU2);
+		he_mu->ru_ch2[1] =
+			le32_get_bits(rxv[3], MT_CRXV_HE_RU3);
+	}
+}
+
+void mt76_connac2_mac_decode_he_radiotap(struct mt76_dev *dev,
+					 struct sk_buff *skb,
+					 __le32 *rxv, u32 mode)
+{
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	static const struct ieee80211_radiotap_he known = {
+		.data1 = HE_BITS(DATA1_DATA_MCS_KNOWN) |
+			 HE_BITS(DATA1_DATA_DCM_KNOWN) |
+			 HE_BITS(DATA1_STBC_KNOWN) |
+			 HE_BITS(DATA1_CODING_KNOWN) |
+			 HE_BITS(DATA1_LDPC_XSYMSEG_KNOWN) |
+			 HE_BITS(DATA1_DOPPLER_KNOWN) |
+			 HE_BITS(DATA1_SPTL_REUSE_KNOWN) |
+			 HE_BITS(DATA1_BSS_COLOR_KNOWN),
+		.data2 = HE_BITS(DATA2_GI_KNOWN) |
+			 HE_BITS(DATA2_TXBF_KNOWN) |
+			 HE_BITS(DATA2_PE_DISAMBIG_KNOWN) |
+			 HE_BITS(DATA2_TXOP_KNOWN),
+	};
+	u32 ltf_size = le32_get_bits(rxv[2], MT_CRXV_HE_LTF_SIZE) + 1;
+	struct ieee80211_radiotap_he *he;
+
+	status->flag |= RX_FLAG_RADIOTAP_HE;
+
+	he = skb_push(skb, sizeof(known));
+	memcpy(he, &known, sizeof(known));
+
+	he->data3 = HE_PREP(DATA3_BSS_COLOR, BSS_COLOR, rxv[14]) |
+		    HE_PREP(DATA3_LDPC_XSYMSEG, LDPC_EXT_SYM, rxv[2]);
+	he->data4 = HE_PREP(DATA4_SU_MU_SPTL_REUSE, SR_MASK, rxv[11]);
+	he->data5 = HE_PREP(DATA5_PE_DISAMBIG, PE_DISAMBIG, rxv[2]) |
+		    le16_encode_bits(ltf_size,
+				     IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE);
+	if (le32_to_cpu(rxv[0]) & MT_PRXV_TXBF)
+		he->data5 |= HE_BITS(DATA5_TXBF);
+	he->data6 = HE_PREP(DATA6_TXOP, TXOP_DUR, rxv[14]) |
+		    HE_PREP(DATA6_DOPPLER, DOPPLER, rxv[14]);
+
+	switch (mode) {
+	case MT_PHY_TYPE_HE_SU:
+		he->data1 |= HE_BITS(DATA1_FORMAT_SU) |
+			     HE_BITS(DATA1_UL_DL_KNOWN) |
+			     HE_BITS(DATA1_BEAM_CHANGE_KNOWN) |
+			     HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
+
+		he->data3 |= HE_PREP(DATA3_BEAM_CHANGE, BEAM_CHNG, rxv[14]) |
+			     HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
+		break;
+	case MT_PHY_TYPE_HE_EXT_SU:
+		he->data1 |= HE_BITS(DATA1_FORMAT_EXT_SU) |
+			     HE_BITS(DATA1_UL_DL_KNOWN) |
+			     HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
+
+		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
+		break;
+	case MT_PHY_TYPE_HE_MU:
+		he->data1 |= HE_BITS(DATA1_FORMAT_MU) |
+			     HE_BITS(DATA1_UL_DL_KNOWN);
+
+		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
+		he->data4 |= HE_PREP(DATA4_MU_STA_ID, MU_AID, rxv[7]);
+
+		mt76_connac2_mac_decode_he_radiotap_ru(status, he, rxv);
+		mt76_connac2_mac_decode_he_mu_radiotap(dev, skb, rxv);
+		break;
+	case MT_PHY_TYPE_HE_TB:
+		he->data1 |= HE_BITS(DATA1_FORMAT_TRIG) |
+			     HE_BITS(DATA1_SPTL_REUSE2_KNOWN) |
+			     HE_BITS(DATA1_SPTL_REUSE3_KNOWN) |
+			     HE_BITS(DATA1_SPTL_REUSE4_KNOWN);
+
+		he->data4 |= HE_PREP(DATA4_TB_SPTL_REUSE1, SR_MASK, rxv[11]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE2, SR1_MASK, rxv[11]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE3, SR2_MASK, rxv[11]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE4, SR3_MASK, rxv[11]);
+
+		mt76_connac2_mac_decode_he_radiotap_ru(status, he, rxv);
+		break;
+	default:
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_mac_decode_he_radiotap);
+
+/* The HW does not translate the mac header to 802.3 for mesh point */
+int mt76_connac2_reverse_frag0_hdr_trans(struct ieee80211_vif *vif,
+					 struct sk_buff *skb, u16 hdr_offset)
+{
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	struct ethhdr *eth_hdr = (struct ethhdr *)(skb->data + hdr_offset);
+	__le32 *rxd = (__le32 *)skb->data;
+	struct ieee80211_sta *sta;
+	struct ieee80211_hdr hdr;
+	u16 frame_control;
+
+	if (le32_get_bits(rxd[3], MT_RXD3_NORMAL_ADDR_TYPE) !=
+	    MT_RXD3_NORMAL_U2M)
+		return -EINVAL;
+
+	if (!(le32_to_cpu(rxd[1]) & MT_RXD1_NORMAL_GROUP_4))
+		return -EINVAL;
+
+	sta = container_of((void *)status->wcid, struct ieee80211_sta, drv_priv);
+
+	/* store the info from RXD and ethhdr to avoid being overridden */
+	frame_control = le32_get_bits(rxd[6], MT_RXD6_FRAME_CONTROL);
+	hdr.frame_control = cpu_to_le16(frame_control);
+	hdr.seq_ctrl = cpu_to_le16(le32_get_bits(rxd[8], MT_RXD8_SEQ_CTRL));
+	hdr.duration_id = 0;
+
+	ether_addr_copy(hdr.addr1, vif->addr);
+	ether_addr_copy(hdr.addr2, sta->addr);
+	switch (frame_control & (IEEE80211_FCTL_TODS |
+				 IEEE80211_FCTL_FROMDS)) {
+	case 0:
+		ether_addr_copy(hdr.addr3, vif->bss_conf.bssid);
+		break;
+	case IEEE80211_FCTL_FROMDS:
+		ether_addr_copy(hdr.addr3, eth_hdr->h_source);
+		break;
+	case IEEE80211_FCTL_TODS:
+		ether_addr_copy(hdr.addr3, eth_hdr->h_dest);
+		break;
+	case IEEE80211_FCTL_TODS | IEEE80211_FCTL_FROMDS:
+		ether_addr_copy(hdr.addr3, eth_hdr->h_dest);
+		ether_addr_copy(hdr.addr4, eth_hdr->h_source);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	skb_pull(skb, hdr_offset + sizeof(struct ethhdr) - 2);
+	if (eth_hdr->h_proto == cpu_to_be16(ETH_P_AARP) ||
+	    eth_hdr->h_proto == cpu_to_be16(ETH_P_IPX))
+		ether_addr_copy(skb_push(skb, ETH_ALEN), bridge_tunnel_header);
+	else if (be16_to_cpu(eth_hdr->h_proto) >= ETH_P_802_3_MIN)
+		ether_addr_copy(skb_push(skb, ETH_ALEN), rfc1042_header);
+	else
+		skb_pull(skb, 2);
+
+	if (ieee80211_has_order(hdr.frame_control))
+		memcpy(skb_push(skb, IEEE80211_HT_CTL_LEN), &rxd[9],
+		       IEEE80211_HT_CTL_LEN);
+	if (ieee80211_is_data_qos(hdr.frame_control)) {
+		__le16 qos_ctrl;
+
+		qos_ctrl = cpu_to_le16(le32_get_bits(rxd[8], MT_RXD8_QOS_CTL));
+		memcpy(skb_push(skb, IEEE80211_QOS_CTL_LEN), &qos_ctrl,
+		       IEEE80211_QOS_CTL_LEN);
+	}
+
+	if (ieee80211_has_a4(hdr.frame_control))
+		memcpy(skb_push(skb, sizeof(hdr)), &hdr, sizeof(hdr));
+	else
+		memcpy(skb_push(skb, sizeof(hdr) - 6), &hdr, sizeof(hdr) - 6);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_reverse_frag0_hdr_trans);
+
+int mt76_connac2_mac_fill_rx_rate(struct mt76_dev *dev,
+				  struct mt76_rx_status *status,
+				  struct ieee80211_supported_band *sband,
+				  __le32 *rxv, u8 *mode)
+{
+	u32 v0, v2;
+	u8 stbc, gi, bw, dcm, nss;
+	int i, idx;
+	bool cck = false;
+
+	v0 = le32_to_cpu(rxv[0]);
+	v2 = le32_to_cpu(rxv[2]);
+
+	idx = i = FIELD_GET(MT_PRXV_TX_RATE, v0);
+	nss = FIELD_GET(MT_PRXV_NSTS, v0) + 1;
+
+	if (!is_mt7915(dev)) {
+		stbc = FIELD_GET(MT_PRXV_HT_STBC, v0);
+		gi = FIELD_GET(MT_PRXV_HT_SGI, v0);
+		*mode = FIELD_GET(MT_PRXV_TX_MODE, v0);
+		if (is_mt7921(dev))
+			dcm = !!(idx & MT_PRXV_TX_DCM);
+		else
+			dcm = FIELD_GET(MT_PRXV_DCM, v0);
+		bw = FIELD_GET(MT_PRXV_FRAME_MODE, v0);
+	} else {
+		stbc = FIELD_GET(MT_CRXV_HT_STBC, v2);
+		gi = FIELD_GET(MT_CRXV_HT_SHORT_GI, v2);
+		*mode = FIELD_GET(MT_CRXV_TX_MODE, v2);
+		dcm = !!(idx & GENMASK(3, 0) & MT_PRXV_TX_DCM);
+		bw = FIELD_GET(MT_CRXV_FRAME_MODE, v2);
+	}
+
+	switch (*mode) {
+	case MT_PHY_TYPE_CCK:
+		cck = true;
+		fallthrough;
+	case MT_PHY_TYPE_OFDM:
+		i = mt76_get_rate(dev, sband, i, cck);
+		break;
+	case MT_PHY_TYPE_HT_GF:
+	case MT_PHY_TYPE_HT:
+		status->encoding = RX_ENC_HT;
+		if (gi)
+			status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+		if (i > 31)
+			return -EINVAL;
+		break;
+	case MT_PHY_TYPE_VHT:
+		status->nss = nss;
+		status->encoding = RX_ENC_VHT;
+		if (gi)
+			status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+		if (i > 11)
+			return -EINVAL;
+		break;
+	case MT_PHY_TYPE_HE_MU:
+	case MT_PHY_TYPE_HE_SU:
+	case MT_PHY_TYPE_HE_EXT_SU:
+	case MT_PHY_TYPE_HE_TB:
+		status->nss = nss;
+		status->encoding = RX_ENC_HE;
+		i &= GENMASK(3, 0);
+
+		if (gi <= NL80211_RATE_INFO_HE_GI_3_2)
+			status->he_gi = gi;
+
+		status->he_dcm = dcm;
+		break;
+	default:
+		return -EINVAL;
+	}
+	status->rate_idx = i;
+
+	switch (bw) {
+	case IEEE80211_STA_RX_BW_20:
+		break;
+	case IEEE80211_STA_RX_BW_40:
+		if (*mode & MT_PHY_TYPE_HE_EXT_SU &&
+		    (idx & MT_PRXV_TX_ER_SU_106T)) {
+			status->bw = RATE_INFO_BW_HE_RU;
+			status->he_ru =
+				NL80211_RATE_INFO_HE_RU_ALLOC_106;
+		} else {
+			status->bw = RATE_INFO_BW_40;
+		}
+		break;
+	case IEEE80211_STA_RX_BW_80:
+		status->bw = RATE_INFO_BW_80;
+		break;
+	case IEEE80211_STA_RX_BW_160:
+		status->bw = RATE_INFO_BW_160;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	status->enc_flags |= RX_ENC_FLAG_STBC_MASK * stbc;
+	if (*mode < MT_PHY_TYPE_HE_SU && gi)
+		status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_mac_fill_rx_rate);
+
+void mt76_connac2_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
+{
+	struct mt76_wcid *wcid;
+	u16 fc, tid;
+	u32 val;
+
+	if (!sta ||
+	    !(sta->deflink.ht_cap.ht_supported || sta->deflink.he_cap.has_he))
+		return;
+
+	tid = le32_get_bits(txwi[1], MT_TXD1_TID);
+	if (tid >= 6) /* skip VO queue */
+		return;
+
+	val = le32_to_cpu(txwi[2]);
+	fc = FIELD_GET(MT_TXD2_FRAME_TYPE, val) << 2 |
+	     FIELD_GET(MT_TXD2_SUB_TYPE, val) << 4;
+	if (unlikely(fc != (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_QOS_DATA)))
+		return;
+
+	wcid = (struct mt76_wcid *)sta->drv_priv;
+	if (!test_and_set_bit(tid, &wcid->ampdu_state))
+		ieee80211_start_tx_ba_session(sta, tid, 0);
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_tx_check_aggr);
+
+void mt76_connac2_txwi_free(struct mt76_dev *dev, struct mt76_txwi_cache *t,
+			    struct ieee80211_sta *sta,
+			    struct list_head *free_list)
+{
+	struct mt76_wcid *wcid;
+	__le32 *txwi;
+	u16 wcid_idx;
+
+	mt76_connac_txp_skb_unmap(dev, t);
+	if (!t->skb)
+		goto out;
+
+	txwi = (__le32 *)mt76_get_txwi_ptr(dev, t);
+	if (sta) {
+		wcid = (struct mt76_wcid *)sta->drv_priv;
+		wcid_idx = wcid->idx;
+	} else {
+		wcid_idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
+		wcid = rcu_dereference(dev->wcid[wcid_idx]);
+
+		if (wcid && wcid->sta) {
+			sta = container_of((void *)wcid, struct ieee80211_sta,
+					   drv_priv);
+			spin_lock_bh(&dev->sta_poll_lock);
+			if (list_empty(&wcid->poll_list))
+				list_add_tail(&wcid->poll_list,
+					      &dev->sta_poll_list);
+			spin_unlock_bh(&dev->sta_poll_lock);
+		}
+	}
+
+	if (sta && likely(t->skb->protocol != cpu_to_be16(ETH_P_PAE)))
+		mt76_connac2_tx_check_aggr(sta, txwi);
+
+	__mt76_tx_complete_skb(dev, wcid_idx, t->skb, free_list);
+out:
+	t->skb = NULL;
+	mt76_put_txwi(dev, t);
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_txwi_free);
+
+void mt76_connac2_tx_token_put(struct mt76_dev *dev)
+{
+	struct mt76_txwi_cache *txwi;
+	int id;
+
+	spin_lock_bh(&dev->token_lock);
+	idr_for_each_entry(&dev->token, txwi, id) {
+		mt76_connac2_txwi_free(dev, txwi, NULL, NULL);
+		dev->token_count--;
+	}
+	spin_unlock_bh(&dev->token_lock);
+	idr_destroy(&dev->token);
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_tx_token_put);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index f30cf9e71610..d0e49d68c5db 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1168,7 +1168,7 @@ int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
 			.len = cpu_to_le16(sizeof(struct req_tlv)),
 			.active = enable,
-			.link_idx = mvif->idx,
+			.link_idx = mvif->link_idx,
 		},
 	};
 	struct {
@@ -1191,7 +1191,7 @@ int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 			.bmc_tx_wlan_idx = cpu_to_le16(wcid->idx),
 			.sta_idx = cpu_to_le16(wcid->idx),
 			.conn_state = 1,
-			.link_idx = mvif->idx,
+			.link_idx = mvif->link_idx,
 		},
 	};
 	int err, idx, cmd, len;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c.orig b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c.orig
new file mode 100644
index 000000000000..f30cf9e71610
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c.orig
@@ -0,0 +1,3200 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#include <linux/firmware.h>
+#include "mt76_connac2_mac.h"
+#include "mt76_connac_mcu.h"
+
+int mt76_connac_mcu_start_firmware(struct mt76_dev *dev, u32 addr, u32 option)
+{
+	struct {
+		__le32 option;
+		__le32 addr;
+	} req = {
+		.option = cpu_to_le32(option),
+		.addr = cpu_to_le32(addr),
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_CMD(FW_START_REQ), &req,
+				 sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_start_firmware);
+
+int mt76_connac_mcu_patch_sem_ctrl(struct mt76_dev *dev, bool get)
+{
+	u32 op = get ? PATCH_SEM_GET : PATCH_SEM_RELEASE;
+	struct {
+		__le32 op;
+	} req = {
+		.op = cpu_to_le32(op),
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_CMD(PATCH_SEM_CONTROL),
+				 &req, sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_patch_sem_ctrl);
+
+int mt76_connac_mcu_start_patch(struct mt76_dev *dev)
+{
+	struct {
+		u8 check_crc;
+		u8 reserved[3];
+	} req = {
+		.check_crc = 0,
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_CMD(PATCH_FINISH_REQ),
+				 &req, sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_start_patch);
+
+#define MCU_PATCH_ADDRESS	0x200000
+
+int mt76_connac_mcu_init_download(struct mt76_dev *dev, u32 addr, u32 len,
+				  u32 mode)
+{
+	struct {
+		__le32 addr;
+		__le32 len;
+		__le32 mode;
+	} req = {
+		.addr = cpu_to_le32(addr),
+		.len = cpu_to_le32(len),
+		.mode = cpu_to_le32(mode),
+	};
+	int cmd;
+
+	if ((!is_connac_v1(dev) && addr == MCU_PATCH_ADDRESS) ||
+	    (is_mt7921(dev) && addr == 0x900000) ||
+	    (is_mt7925(dev) && (addr == 0x900000 || addr == 0xe0002800)) ||
+	    (is_mt7996(dev) && addr == 0x900000) ||
+	    (is_mt7992(dev) && addr == 0x900000))
+		cmd = MCU_CMD(PATCH_START_REQ);
+	else
+		cmd = MCU_CMD(TARGET_ADDRESS_LEN_REQ);
+
+	return mt76_mcu_send_msg(dev, cmd, &req, sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_init_download);
+
+int mt76_connac_mcu_set_channel_domain(struct mt76_phy *phy)
+{
+	int len, i, n_max_channels, n_2ch = 0, n_5ch = 0, n_6ch = 0;
+	struct mt76_connac_mcu_channel_domain {
+		u8 alpha2[4]; /* regulatory_request.alpha2 */
+		u8 bw_2g; /* BW_20_40M		0
+			   * BW_20M		1
+			   * BW_20_40_80M	2
+			   * BW_20_40_80_160M	3
+			   * BW_20_40_80_8080M	4
+			   */
+		u8 bw_5g;
+		u8 bw_6g;
+		u8 pad;
+		u8 n_2ch;
+		u8 n_5ch;
+		u8 n_6ch;
+		u8 pad2;
+	} __packed hdr = {
+		.bw_2g = 0,
+		.bw_5g = 3, /* BW_20_40_80_160M */
+		.bw_6g = 3,
+	};
+	struct mt76_connac_mcu_chan {
+		__le16 hw_value;
+		__le16 pad;
+		__le32 flags;
+	} __packed channel;
+	struct mt76_dev *dev = phy->dev;
+	struct ieee80211_channel *chan;
+	struct sk_buff *skb;
+
+	n_max_channels = phy->sband_2g.sband.n_channels +
+			 phy->sband_5g.sband.n_channels +
+			 phy->sband_6g.sband.n_channels;
+	len = sizeof(hdr) + n_max_channels * sizeof(channel);
+
+	skb = mt76_mcu_msg_alloc(dev, NULL, len);
+	if (!skb)
+		return -ENOMEM;
+
+	skb_reserve(skb, sizeof(hdr));
+
+	for (i = 0; i < phy->sband_2g.sband.n_channels; i++) {
+		chan = &phy->sband_2g.sband.channels[i];
+		if (chan->flags & IEEE80211_CHAN_DISABLED)
+			continue;
+
+		channel.hw_value = cpu_to_le16(chan->hw_value);
+		channel.flags = cpu_to_le32(chan->flags);
+		channel.pad = 0;
+
+		skb_put_data(skb, &channel, sizeof(channel));
+		n_2ch++;
+	}
+	for (i = 0; i < phy->sband_5g.sband.n_channels; i++) {
+		chan = &phy->sband_5g.sband.channels[i];
+		if (chan->flags & IEEE80211_CHAN_DISABLED)
+			continue;
+
+		channel.hw_value = cpu_to_le16(chan->hw_value);
+		channel.flags = cpu_to_le32(chan->flags);
+		channel.pad = 0;
+
+		skb_put_data(skb, &channel, sizeof(channel));
+		n_5ch++;
+	}
+	for (i = 0; i < phy->sband_6g.sband.n_channels; i++) {
+		chan = &phy->sband_6g.sband.channels[i];
+		if (chan->flags & IEEE80211_CHAN_DISABLED)
+			continue;
+
+		channel.hw_value = cpu_to_le16(chan->hw_value);
+		channel.flags = cpu_to_le32(chan->flags);
+		channel.pad = 0;
+
+		skb_put_data(skb, &channel, sizeof(channel));
+		n_6ch++;
+	}
+
+	BUILD_BUG_ON(sizeof(dev->alpha2) > sizeof(hdr.alpha2));
+	memcpy(hdr.alpha2, dev->alpha2, sizeof(dev->alpha2));
+	hdr.n_2ch = n_2ch;
+	hdr.n_5ch = n_5ch;
+	hdr.n_6ch = n_6ch;
+
+	memcpy(__skb_push(skb, sizeof(hdr)), &hdr, sizeof(hdr));
+
+	return mt76_mcu_skb_send_msg(dev, skb, MCU_CE_CMD(SET_CHAN_DOMAIN),
+				     false);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_channel_domain);
+
+int mt76_connac_mcu_set_mac_enable(struct mt76_dev *dev, int band, bool enable,
+				   bool hdr_trans)
+{
+	struct {
+		u8 enable;
+		u8 band;
+		u8 rsv[2];
+	} __packed req_mac = {
+		.enable = enable,
+		.band = band,
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_EXT_CMD(MAC_INIT_CTRL), &req_mac,
+				 sizeof(req_mac), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_mac_enable);
+
+int mt76_connac_mcu_set_vif_ps(struct mt76_dev *dev, struct ieee80211_vif *vif)
+{
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
+	struct {
+		u8 bss_idx;
+		u8 ps_state; /* 0: device awake
+			      * 1: static power save
+			      * 2: dynamic power saving
+			      */
+	} req = {
+		.bss_idx = mvif->idx,
+		.ps_state = vif->cfg.ps ? 2 : 0,
+	};
+
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return -EOPNOTSUPP;
+
+	return mt76_mcu_send_msg(dev, MCU_CE_CMD(SET_PS_PROFILE),
+				 &req, sizeof(req), false);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_vif_ps);
+
+int mt76_connac_mcu_set_rts_thresh(struct mt76_dev *dev, u32 val, u8 band)
+{
+	struct {
+		u8 prot_idx;
+		u8 band;
+		u8 rsv[2];
+		__le32 len_thresh;
+		__le32 pkt_thresh;
+	} __packed req = {
+		.prot_idx = 1,
+		.band = band,
+		.len_thresh = cpu_to_le32(val),
+		.pkt_thresh = cpu_to_le32(0x2),
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_EXT_CMD(PROTECT_CTRL), &req,
+				 sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_rts_thresh);
+
+void mt76_connac_mcu_beacon_loss_iter(void *priv, u8 *mac,
+				      struct ieee80211_vif *vif)
+{
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
+	struct mt76_connac_beacon_loss_event *event = priv;
+
+	if (mvif->idx != event->bss_idx)
+		return;
+
+	if (!(vif->driver_flags & IEEE80211_VIF_BEACON_FILTER))
+		return;
+
+	ieee80211_beacon_loss(vif);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_beacon_loss_iter);
+
+struct tlv *
+mt76_connac_mcu_add_nested_tlv(struct sk_buff *skb, int tag, int len,
+			       void *sta_ntlv, void *sta_wtbl)
+{
+	struct sta_ntlv_hdr *ntlv_hdr = sta_ntlv;
+	struct tlv *sta_hdr = sta_wtbl;
+	struct tlv *ptlv, tlv = {
+		.tag = cpu_to_le16(tag),
+		.len = cpu_to_le16(len),
+	};
+	u16 ntlv;
+
+	ptlv = skb_put_zero(skb, len);
+	memcpy(ptlv, &tlv, sizeof(tlv));
+
+	ntlv = le16_to_cpu(ntlv_hdr->tlv_num);
+	ntlv_hdr->tlv_num = cpu_to_le16(ntlv + 1);
+
+	if (sta_hdr) {
+		len += le16_to_cpu(sta_hdr->len);
+		sta_hdr->len = cpu_to_le16(len);
+	}
+
+	return ptlv;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_add_nested_tlv);
+
+struct sk_buff *
+__mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif_link *mvif,
+				struct mt76_wcid *wcid, int len)
+{
+	struct sta_req_hdr hdr = {
+		.bss_idx = mvif->idx,
+		.muar_idx = wcid ? mvif->omac_idx : 0,
+		.is_tlv_append = 1,
+	};
+	struct sk_buff *skb;
+
+	if (wcid && !wcid->sta && !wcid->sta_disabled)
+		hdr.muar_idx = 0xe;
+
+	mt76_connac_mcu_get_wlan_idx(dev, wcid, &hdr.wlan_idx_lo,
+				     &hdr.wlan_idx_hi);
+	skb = mt76_mcu_msg_alloc(dev, NULL, len);
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
+
+	skb_put_data(skb, &hdr, sizeof(hdr));
+
+	return skb;
+}
+EXPORT_SYMBOL_GPL(__mt76_connac_mcu_alloc_sta_req);
+
+struct wtbl_req_hdr *
+mt76_connac_mcu_alloc_wtbl_req(struct mt76_dev *dev, struct mt76_wcid *wcid,
+			       int cmd, void *sta_wtbl, struct sk_buff **skb)
+{
+	struct tlv *sta_hdr = sta_wtbl;
+	struct wtbl_req_hdr hdr = {
+		.operation = cmd,
+	};
+	struct sk_buff *nskb = *skb;
+
+	mt76_connac_mcu_get_wlan_idx(dev, wcid, &hdr.wlan_idx_lo,
+				     &hdr.wlan_idx_hi);
+	if (!nskb) {
+		nskb = mt76_mcu_msg_alloc(dev, NULL,
+					  MT76_CONNAC_WTBL_UPDATE_MAX_SIZE);
+		if (!nskb)
+			return ERR_PTR(-ENOMEM);
+
+		*skb = nskb;
+	}
+
+	if (sta_hdr)
+		le16_add_cpu(&sta_hdr->len, sizeof(hdr));
+
+	return skb_put_data(nskb, &hdr, sizeof(hdr));
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_alloc_wtbl_req);
+
+void mt76_connac_mcu_bss_omac_tlv(struct sk_buff *skb,
+				  struct ieee80211_vif *vif)
+{
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
+	u8 omac_idx = mvif->omac_idx;
+	struct bss_info_omac *omac;
+	struct tlv *tlv;
+	u32 type = 0;
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_MONITOR:
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_AP:
+		if (vif->p2p)
+			type = CONNECTION_P2P_GO;
+		else
+			type = CONNECTION_INFRA_AP;
+		break;
+	case NL80211_IFTYPE_STATION:
+		if (vif->p2p)
+			type = CONNECTION_P2P_GC;
+		else
+			type = CONNECTION_INFRA_STA;
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		type = CONNECTION_IBSS_ADHOC;
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_OMAC, sizeof(*omac));
+
+	omac = (struct bss_info_omac *)tlv;
+	omac->conn_type = cpu_to_le32(type);
+	omac->omac_idx = mvif->omac_idx;
+	omac->band_idx = mvif->band_idx;
+	omac->hw_bss_idx = omac_idx > EXT_BSSID_START ? HW_BSSID_0 : omac_idx;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_bss_omac_tlv);
+
+void mt76_connac_mcu_sta_basic_tlv(struct mt76_dev *dev, struct sk_buff *skb,
+				   struct ieee80211_bss_conf *link_conf,
+				   struct ieee80211_link_sta *link_sta,
+				   int conn_state, bool newly)
+{
+	struct ieee80211_vif *vif = link_conf->vif;
+	struct sta_rec_basic *basic;
+	struct tlv *tlv;
+	int conn_type;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_BASIC, sizeof(*basic));
+
+	basic = (struct sta_rec_basic *)tlv;
+	basic->extra_info = cpu_to_le16(EXTRA_INFO_VER);
+
+	if (newly && conn_state != CONN_STATE_DISCONNECT)
+		basic->extra_info |= cpu_to_le16(EXTRA_INFO_NEW);
+	basic->conn_state = conn_state;
+
+	if (!link_sta) {
+		basic->conn_type = cpu_to_le32(CONNECTION_INFRA_BC);
+
+		if (vif->type == NL80211_IFTYPE_STATION &&
+		    !is_zero_ether_addr(link_conf->bssid)) {
+			memcpy(basic->peer_addr, link_conf->bssid, ETH_ALEN);
+			basic->aid = cpu_to_le16(vif->cfg.aid);
+		} else {
+			eth_broadcast_addr(basic->peer_addr);
+		}
+		return;
+	}
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_AP:
+		if (vif->p2p && !is_mt7921(dev))
+			conn_type = CONNECTION_P2P_GC;
+		else
+			conn_type = CONNECTION_INFRA_STA;
+		basic->conn_type = cpu_to_le32(conn_type);
+		basic->aid = cpu_to_le16(link_sta->sta->aid);
+		break;
+	case NL80211_IFTYPE_STATION:
+		if (vif->p2p && !is_mt7921(dev))
+			conn_type = CONNECTION_P2P_GO;
+		else
+			conn_type = CONNECTION_INFRA_AP;
+		basic->conn_type = cpu_to_le32(conn_type);
+		basic->aid = cpu_to_le16(vif->cfg.aid);
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		basic->conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
+		basic->aid = cpu_to_le16(link_sta->sta->aid);
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	memcpy(basic->peer_addr, link_sta->addr, ETH_ALEN);
+	basic->qos = link_sta->sta->wme;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_basic_tlv);
+
+void mt76_connac_mcu_sta_uapsd(struct sk_buff *skb, struct ieee80211_vif *vif,
+			       struct ieee80211_sta *sta)
+{
+	struct sta_rec_uapsd *uapsd;
+	struct tlv *tlv;
+
+	if (vif->type != NL80211_IFTYPE_AP || !sta->wme)
+		return;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_APPS, sizeof(*uapsd));
+	uapsd = (struct sta_rec_uapsd *)tlv;
+
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_VO) {
+		uapsd->dac_map |= BIT(3);
+		uapsd->tac_map |= BIT(3);
+	}
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_VI) {
+		uapsd->dac_map |= BIT(2);
+		uapsd->tac_map |= BIT(2);
+	}
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_BE) {
+		uapsd->dac_map |= BIT(1);
+		uapsd->tac_map |= BIT(1);
+	}
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_BK) {
+		uapsd->dac_map |= BIT(0);
+		uapsd->tac_map |= BIT(0);
+	}
+	uapsd->max_sp = sta->max_sp;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_uapsd);
+
+void mt76_connac_mcu_wtbl_hdr_trans_tlv(struct sk_buff *skb,
+					struct ieee80211_vif *vif,
+					struct mt76_wcid *wcid,
+					void *sta_wtbl, void *wtbl_tlv)
+{
+	struct wtbl_hdr_trans *htr;
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_HDR_TRANS,
+					     sizeof(*htr),
+					     wtbl_tlv, sta_wtbl);
+	htr = (struct wtbl_hdr_trans *)tlv;
+	htr->no_rx_trans = true;
+
+	if (vif->type == NL80211_IFTYPE_STATION)
+		htr->to_ds = true;
+	else
+		htr->from_ds = true;
+
+	if (!wcid)
+		return;
+
+	htr->no_rx_trans = !test_bit(MT_WCID_FLAG_HDR_TRANS, &wcid->flags);
+	if (test_bit(MT_WCID_FLAG_4ADDR, &wcid->flags)) {
+		htr->to_ds = true;
+		htr->from_ds = true;
+	}
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_wtbl_hdr_trans_tlv);
+
+int mt76_connac_mcu_sta_update_hdr_trans(struct mt76_dev *dev,
+					 struct ieee80211_vif *vif,
+					 struct mt76_wcid *wcid, int cmd)
+{
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
+	struct wtbl_req_hdr *wtbl_hdr;
+	struct tlv *sta_wtbl;
+	struct sk_buff *skb;
+
+	skb = mt76_connac_mcu_alloc_sta_req(dev, mvif, wcid);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	sta_wtbl = mt76_connac_mcu_add_tlv(skb, STA_REC_WTBL,
+					   sizeof(struct tlv));
+
+	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(dev, wcid, WTBL_SET,
+						  sta_wtbl, &skb);
+	if (IS_ERR(wtbl_hdr))
+		return PTR_ERR(wtbl_hdr);
+
+	mt76_connac_mcu_wtbl_hdr_trans_tlv(skb, vif, wcid, sta_wtbl, wtbl_hdr);
+
+	return mt76_mcu_skb_send_msg(dev, skb, cmd, true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_update_hdr_trans);
+
+int mt76_connac_mcu_wtbl_update_hdr_trans(struct mt76_dev *dev,
+					  struct ieee80211_vif *vif,
+					  struct ieee80211_sta *sta)
+{
+	struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
+	struct wtbl_req_hdr *wtbl_hdr;
+	struct sk_buff *skb = NULL;
+
+	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(dev, wcid, WTBL_SET, NULL,
+						  &skb);
+	if (IS_ERR(wtbl_hdr))
+		return PTR_ERR(wtbl_hdr);
+
+	mt76_connac_mcu_wtbl_hdr_trans_tlv(skb, vif, wcid, NULL, wtbl_hdr);
+
+	return mt76_mcu_skb_send_msg(dev, skb, MCU_EXT_CMD(WTBL_UPDATE), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_wtbl_update_hdr_trans);
+
+void mt76_connac_mcu_wtbl_generic_tlv(struct mt76_dev *dev,
+				      struct sk_buff *skb,
+				      struct ieee80211_vif *vif,
+				      struct ieee80211_sta *sta,
+				      void *sta_wtbl, void *wtbl_tlv)
+{
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
+	struct wtbl_generic *generic;
+	struct wtbl_rx *rx;
+	struct wtbl_spe *spe;
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_GENERIC,
+					     sizeof(*generic),
+					     wtbl_tlv, sta_wtbl);
+
+	generic = (struct wtbl_generic *)tlv;
+
+	if (sta) {
+		if (vif->type == NL80211_IFTYPE_STATION)
+			generic->partial_aid = cpu_to_le16(vif->cfg.aid);
+		else
+			generic->partial_aid = cpu_to_le16(sta->aid);
+		memcpy(generic->peer_addr, sta->addr, ETH_ALEN);
+		generic->muar_idx = mvif->omac_idx;
+		generic->qos = sta->wme;
+	} else {
+		if (!is_connac_v1(dev) && vif->type == NL80211_IFTYPE_STATION)
+			memcpy(generic->peer_addr, vif->bss_conf.bssid,
+			       ETH_ALEN);
+		else
+			eth_broadcast_addr(generic->peer_addr);
+
+		generic->muar_idx = 0xe;
+	}
+
+	tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_RX, sizeof(*rx),
+					     wtbl_tlv, sta_wtbl);
+
+	rx = (struct wtbl_rx *)tlv;
+	rx->rca1 = sta ? vif->type != NL80211_IFTYPE_AP : 1;
+	rx->rca2 = 1;
+	rx->rv = 1;
+
+	if (!is_connac_v1(dev))
+		return;
+
+	tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_SPE, sizeof(*spe),
+					     wtbl_tlv, sta_wtbl);
+	spe = (struct wtbl_spe *)tlv;
+	spe->spe_idx = 24;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_wtbl_generic_tlv);
+
+static void
+mt76_connac_mcu_sta_amsdu_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
+			      struct ieee80211_vif *vif)
+{
+	struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
+	struct sta_rec_amsdu *amsdu;
+	struct tlv *tlv;
+
+	if (vif->type != NL80211_IFTYPE_AP &&
+	    vif->type != NL80211_IFTYPE_STATION)
+		return;
+
+	if (!sta->deflink.agg.max_amsdu_len)
+		return;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HW_AMSDU, sizeof(*amsdu));
+	amsdu = (struct sta_rec_amsdu *)tlv;
+	amsdu->max_amsdu_num = 8;
+	amsdu->amsdu_en = true;
+	amsdu->max_mpdu_size = sta->deflink.agg.max_amsdu_len >=
+			       IEEE80211_MAX_MPDU_LEN_VHT_7991;
+
+	wcid->amsdu = true;
+}
+
+#define HE_PHY(p, c)	u8_get_bits(c, IEEE80211_HE_PHY_##p)
+#define HE_MAC(m, c)	u8_get_bits(c, IEEE80211_HE_MAC_##m)
+static void
+mt76_connac_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
+{
+	struct ieee80211_sta_he_cap *he_cap = &sta->deflink.he_cap;
+	struct ieee80211_he_cap_elem *elem = &he_cap->he_cap_elem;
+	struct sta_rec_he *he;
+	struct tlv *tlv;
+	u32 cap = 0;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HE, sizeof(*he));
+
+	he = (struct sta_rec_he *)tlv;
+
+	if (elem->mac_cap_info[0] & IEEE80211_HE_MAC_CAP0_HTC_HE)
+		cap |= STA_REC_HE_CAP_HTC;
+
+	if (elem->mac_cap_info[2] & IEEE80211_HE_MAC_CAP2_BSR)
+		cap |= STA_REC_HE_CAP_BSR;
+
+	if (elem->mac_cap_info[3] & IEEE80211_HE_MAC_CAP3_OMI_CONTROL)
+		cap |= STA_REC_HE_CAP_OM;
+
+	if (elem->mac_cap_info[4] & IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU)
+		cap |= STA_REC_HE_CAP_AMSDU_IN_AMPDU;
+
+	if (elem->mac_cap_info[4] & IEEE80211_HE_MAC_CAP4_BQR)
+		cap |= STA_REC_HE_CAP_BQR;
+
+	if (elem->phy_cap_info[0] &
+	    (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_2G |
+	     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_5G))
+		cap |= STA_REC_HE_CAP_BW20_RU242_SUPPORT;
+
+	if (elem->phy_cap_info[1] &
+	    IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD)
+		cap |= STA_REC_HE_CAP_LDPC;
+
+	if (elem->phy_cap_info[1] &
+	    IEEE80211_HE_PHY_CAP1_HE_LTF_AND_GI_FOR_HE_PPDUS_0_8US)
+		cap |= STA_REC_HE_CAP_SU_PPDU_1LTF_8US_GI;
+
+	if (elem->phy_cap_info[2] &
+	    IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US)
+		cap |= STA_REC_HE_CAP_NDP_4LTF_3DOT2MS_GI;
+
+	if (elem->phy_cap_info[2] &
+	    IEEE80211_HE_PHY_CAP2_STBC_TX_UNDER_80MHZ)
+		cap |= STA_REC_HE_CAP_LE_EQ_80M_TX_STBC;
+
+	if (elem->phy_cap_info[2] &
+	    IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ)
+		cap |= STA_REC_HE_CAP_LE_EQ_80M_RX_STBC;
+
+	if (elem->phy_cap_info[6] &
+	    IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE)
+		cap |= STA_REC_HE_CAP_PARTIAL_BW_EXT_RANGE;
+
+	if (elem->phy_cap_info[7] &
+	    IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI)
+		cap |= STA_REC_HE_CAP_SU_MU_PPDU_4LTF_8US_GI;
+
+	if (elem->phy_cap_info[7] &
+	    IEEE80211_HE_PHY_CAP7_STBC_TX_ABOVE_80MHZ)
+		cap |= STA_REC_HE_CAP_GT_80M_TX_STBC;
+
+	if (elem->phy_cap_info[7] &
+	    IEEE80211_HE_PHY_CAP7_STBC_RX_ABOVE_80MHZ)
+		cap |= STA_REC_HE_CAP_GT_80M_RX_STBC;
+
+	if (elem->phy_cap_info[8] &
+	    IEEE80211_HE_PHY_CAP8_HE_ER_SU_PPDU_4XLTF_AND_08_US_GI)
+		cap |= STA_REC_HE_CAP_ER_SU_PPDU_4LTF_8US_GI;
+
+	if (elem->phy_cap_info[8] &
+	    IEEE80211_HE_PHY_CAP8_HE_ER_SU_1XLTF_AND_08_US_GI)
+		cap |= STA_REC_HE_CAP_ER_SU_PPDU_1LTF_8US_GI;
+
+	if (elem->phy_cap_info[9] &
+	    IEEE80211_HE_PHY_CAP9_NON_TRIGGERED_CQI_FEEDBACK)
+		cap |= STA_REC_HE_CAP_TRIG_CQI_FK;
+
+	if (elem->phy_cap_info[9] &
+	    IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU)
+		cap |= STA_REC_HE_CAP_TX_1024QAM_UNDER_RU242;
+
+	if (elem->phy_cap_info[9] &
+	    IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU)
+		cap |= STA_REC_HE_CAP_RX_1024QAM_UNDER_RU242;
+
+	he->he_cap = cpu_to_le32(cap);
+
+	switch (sta->deflink.bandwidth) {
+	case IEEE80211_STA_RX_BW_160:
+		if (elem->phy_cap_info[0] &
+		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
+			he->max_nss_mcs[CMD_HE_MCS_BW8080] =
+				he_cap->he_mcs_nss_supp.rx_mcs_80p80;
+
+		he->max_nss_mcs[CMD_HE_MCS_BW160] =
+				he_cap->he_mcs_nss_supp.rx_mcs_160;
+		fallthrough;
+	default:
+		he->max_nss_mcs[CMD_HE_MCS_BW80] =
+				he_cap->he_mcs_nss_supp.rx_mcs_80;
+		break;
+	}
+
+	he->t_frame_dur =
+		HE_MAC(CAP1_TF_MAC_PAD_DUR_MASK, elem->mac_cap_info[1]);
+	he->max_ampdu_exp =
+		HE_MAC(CAP3_MAX_AMPDU_LEN_EXP_MASK, elem->mac_cap_info[3]);
+
+	he->bw_set =
+		HE_PHY(CAP0_CHANNEL_WIDTH_SET_MASK, elem->phy_cap_info[0]);
+	he->device_class =
+		HE_PHY(CAP1_DEVICE_CLASS_A, elem->phy_cap_info[1]);
+	he->punc_pream_rx =
+		HE_PHY(CAP1_PREAMBLE_PUNC_RX_MASK, elem->phy_cap_info[1]);
+
+	he->dcm_tx_mode =
+		HE_PHY(CAP3_DCM_MAX_CONST_TX_MASK, elem->phy_cap_info[3]);
+	he->dcm_tx_max_nss =
+		HE_PHY(CAP3_DCM_MAX_TX_NSS_2, elem->phy_cap_info[3]);
+	he->dcm_rx_mode =
+		HE_PHY(CAP3_DCM_MAX_CONST_RX_MASK, elem->phy_cap_info[3]);
+	he->dcm_rx_max_nss =
+		HE_PHY(CAP3_DCM_MAX_RX_NSS_2, elem->phy_cap_info[3]);
+	he->dcm_rx_max_nss =
+		HE_PHY(CAP8_DCM_MAX_RU_MASK, elem->phy_cap_info[8]);
+
+	he->pkt_ext = 2;
+}
+
+void
+mt76_connac_mcu_sta_he_tlv_v2(struct sk_buff *skb, struct ieee80211_sta *sta)
+{
+	struct ieee80211_sta_he_cap *he_cap = &sta->deflink.he_cap;
+	struct ieee80211_he_cap_elem *elem = &he_cap->he_cap_elem;
+	struct sta_rec_he_v2 *he;
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HE_V2, sizeof(*he));
+
+	he = (struct sta_rec_he_v2 *)tlv;
+	memcpy(he->he_phy_cap, elem->phy_cap_info, sizeof(he->he_phy_cap));
+	memcpy(he->he_mac_cap, elem->mac_cap_info, sizeof(he->he_mac_cap));
+
+	switch (sta->deflink.bandwidth) {
+	case IEEE80211_STA_RX_BW_160:
+		if (elem->phy_cap_info[0] &
+		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
+			he->max_nss_mcs[CMD_HE_MCS_BW8080] =
+				he_cap->he_mcs_nss_supp.rx_mcs_80p80;
+
+		he->max_nss_mcs[CMD_HE_MCS_BW160] =
+				he_cap->he_mcs_nss_supp.rx_mcs_160;
+		fallthrough;
+	default:
+		he->max_nss_mcs[CMD_HE_MCS_BW80] =
+				he_cap->he_mcs_nss_supp.rx_mcs_80;
+		break;
+	}
+
+	he->pkt_ext = IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_he_tlv_v2);
+
+u8
+mt76_connac_get_phy_mode_v2(struct mt76_phy *mphy, struct ieee80211_vif *vif,
+			    enum nl80211_band band,
+			    struct ieee80211_link_sta *link_sta)
+{
+	struct ieee80211_sta_ht_cap *ht_cap;
+	struct ieee80211_sta_vht_cap *vht_cap;
+	const struct ieee80211_sta_he_cap *he_cap;
+	const struct ieee80211_sta_eht_cap *eht_cap;
+	u8 mode = 0;
+
+	if (link_sta) {
+		ht_cap = &link_sta->ht_cap;
+		vht_cap = &link_sta->vht_cap;
+		he_cap = &link_sta->he_cap;
+		eht_cap = &link_sta->eht_cap;
+	} else {
+		struct ieee80211_supported_band *sband;
+
+		sband = mphy->hw->wiphy->bands[band];
+		ht_cap = &sband->ht_cap;
+		vht_cap = &sband->vht_cap;
+		he_cap = ieee80211_get_he_iftype_cap(sband, vif->type);
+		eht_cap = ieee80211_get_eht_iftype_cap(sband, vif->type);
+	}
+
+	if (band == NL80211_BAND_2GHZ) {
+		mode |= PHY_TYPE_BIT_HR_DSSS | PHY_TYPE_BIT_ERP;
+
+		if (ht_cap->ht_supported)
+			mode |= PHY_TYPE_BIT_HT;
+
+		if (he_cap && he_cap->has_he)
+			mode |= PHY_TYPE_BIT_HE;
+
+		if (eht_cap && eht_cap->has_eht)
+			mode |= PHY_TYPE_BIT_BE;
+	} else if (band == NL80211_BAND_5GHZ || band == NL80211_BAND_6GHZ) {
+		mode |= PHY_TYPE_BIT_OFDM;
+
+		if (ht_cap->ht_supported)
+			mode |= PHY_TYPE_BIT_HT;
+
+		if (vht_cap->vht_supported)
+			mode |= PHY_TYPE_BIT_VHT;
+
+		if (he_cap && he_cap->has_he)
+			mode |= PHY_TYPE_BIT_HE;
+
+		if (eht_cap && eht_cap->has_eht)
+			mode |= PHY_TYPE_BIT_BE;
+	}
+
+	return mode;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_get_phy_mode_v2);
+
+void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
+			     struct ieee80211_sta *sta,
+			     struct ieee80211_vif *vif,
+			     u8 rcpi, u8 sta_state)
+{
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
+	struct cfg80211_chan_def *chandef = mvif->ctx ?
+					    &mvif->ctx->def : &mphy->chandef;
+	enum nl80211_band band = chandef->chan->band;
+	struct mt76_dev *dev = mphy->dev;
+	struct sta_rec_ra_info *ra_info;
+	struct sta_rec_state *state;
+	struct sta_rec_phy *phy;
+	struct tlv *tlv;
+	u16 supp_rates;
+
+	/* starec ht */
+	if (sta->deflink.ht_cap.ht_supported) {
+		struct sta_rec_ht *ht;
+
+		tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HT, sizeof(*ht));
+		ht = (struct sta_rec_ht *)tlv;
+		ht->ht_cap = cpu_to_le16(sta->deflink.ht_cap.cap);
+	}
+
+	/* starec vht */
+	if (sta->deflink.vht_cap.vht_supported) {
+		struct sta_rec_vht *vht;
+		int len;
+
+		len = is_mt7921(dev) ? sizeof(*vht) : sizeof(*vht) - 4;
+		tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_VHT, len);
+		vht = (struct sta_rec_vht *)tlv;
+		vht->vht_cap = cpu_to_le32(sta->deflink.vht_cap.cap);
+		vht->vht_rx_mcs_map = sta->deflink.vht_cap.vht_mcs.rx_mcs_map;
+		vht->vht_tx_mcs_map = sta->deflink.vht_cap.vht_mcs.tx_mcs_map;
+	}
+
+	/* starec uapsd */
+	mt76_connac_mcu_sta_uapsd(skb, vif, sta);
+
+	if (!is_mt7921(dev))
+		return;
+
+	if (sta->deflink.ht_cap.ht_supported || sta->deflink.he_cap.has_he)
+		mt76_connac_mcu_sta_amsdu_tlv(skb, sta, vif);
+
+	/* starec he */
+	if (sta->deflink.he_cap.has_he) {
+		mt76_connac_mcu_sta_he_tlv(skb, sta);
+		mt76_connac_mcu_sta_he_tlv_v2(skb, sta);
+		if (band == NL80211_BAND_6GHZ &&
+		    sta_state == MT76_STA_INFO_STATE_ASSOC) {
+			struct sta_rec_he_6g_capa *he_6g_capa;
+
+			tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HE_6G,
+						      sizeof(*he_6g_capa));
+			he_6g_capa = (struct sta_rec_he_6g_capa *)tlv;
+			he_6g_capa->capa = sta->deflink.he_6ghz_capa.capa;
+		}
+	}
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_PHY, sizeof(*phy));
+	phy = (struct sta_rec_phy *)tlv;
+	phy->phy_type = mt76_connac_get_phy_mode_v2(mphy, vif, band,
+						    &sta->deflink);
+	phy->basic_rate = cpu_to_le16((u16)vif->bss_conf.basic_rates);
+	phy->rcpi = rcpi;
+	phy->ampdu = FIELD_PREP(IEEE80211_HT_AMPDU_PARM_FACTOR,
+				sta->deflink.ht_cap.ampdu_factor) |
+		     FIELD_PREP(IEEE80211_HT_AMPDU_PARM_DENSITY,
+				sta->deflink.ht_cap.ampdu_density);
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_RA, sizeof(*ra_info));
+	ra_info = (struct sta_rec_ra_info *)tlv;
+
+	supp_rates = sta->deflink.supp_rates[band];
+	if (band == NL80211_BAND_2GHZ)
+		supp_rates = FIELD_PREP(RA_LEGACY_OFDM, supp_rates >> 4) |
+			     FIELD_PREP(RA_LEGACY_CCK, supp_rates & 0xf);
+	else
+		supp_rates = FIELD_PREP(RA_LEGACY_OFDM, supp_rates);
+
+	ra_info->legacy = cpu_to_le16(supp_rates);
+
+	if (sta->deflink.ht_cap.ht_supported)
+		memcpy(ra_info->rx_mcs_bitmask,
+		       sta->deflink.ht_cap.mcs.rx_mask,
+		       HT_MCS_MASK_NUM);
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_STATE, sizeof(*state));
+	state = (struct sta_rec_state *)tlv;
+	state->state = sta_state;
+
+	if (sta->deflink.vht_cap.vht_supported) {
+		state->vht_opmode = sta->deflink.bandwidth;
+		state->vht_opmode |= (sta->deflink.rx_nss - 1) <<
+			IEEE80211_OPMODE_NOTIF_RX_NSS_SHIFT;
+	}
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_tlv);
+
+void mt76_connac_mcu_wtbl_smps_tlv(struct sk_buff *skb,
+				   struct ieee80211_sta *sta,
+				   void *sta_wtbl, void *wtbl_tlv)
+{
+	struct wtbl_smps *smps;
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_SMPS, sizeof(*smps),
+					     wtbl_tlv, sta_wtbl);
+	smps = (struct wtbl_smps *)tlv;
+	smps->smps = (sta->deflink.smps_mode == IEEE80211_SMPS_DYNAMIC);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_wtbl_smps_tlv);
+
+void mt76_connac_mcu_wtbl_ht_tlv(struct mt76_dev *dev, struct sk_buff *skb,
+				 struct ieee80211_sta *sta, void *sta_wtbl,
+				 void *wtbl_tlv, bool ht_ldpc, bool vht_ldpc)
+{
+	struct wtbl_ht *ht = NULL;
+	struct tlv *tlv;
+	u32 flags = 0;
+
+	if (sta->deflink.ht_cap.ht_supported || sta->deflink.he_6ghz_capa.capa) {
+		tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_HT, sizeof(*ht),
+						     wtbl_tlv, sta_wtbl);
+		ht = (struct wtbl_ht *)tlv;
+		ht->ldpc = ht_ldpc &&
+			   !!(sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING);
+
+		if (sta->deflink.ht_cap.ht_supported) {
+			ht->af = sta->deflink.ht_cap.ampdu_factor;
+			ht->mm = sta->deflink.ht_cap.ampdu_density;
+		} else {
+			ht->af = le16_get_bits(sta->deflink.he_6ghz_capa.capa,
+					       IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP);
+			ht->mm = le16_get_bits(sta->deflink.he_6ghz_capa.capa,
+					       IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START);
+		}
+
+		ht->ht = true;
+	}
+
+	if (sta->deflink.vht_cap.vht_supported || sta->deflink.he_6ghz_capa.capa) {
+		struct wtbl_vht *vht;
+		u8 af;
+
+		tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_VHT,
+						     sizeof(*vht), wtbl_tlv,
+						     sta_wtbl);
+		vht = (struct wtbl_vht *)tlv;
+		vht->ldpc = vht_ldpc &&
+			    !!(sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC);
+		vht->vht = true;
+
+		af = FIELD_GET(IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK,
+			       sta->deflink.vht_cap.cap);
+		if (ht)
+			ht->af = max(ht->af, af);
+	}
+
+	mt76_connac_mcu_wtbl_smps_tlv(skb, sta, sta_wtbl, wtbl_tlv);
+
+	if (is_connac_v1(dev) && sta->deflink.ht_cap.ht_supported) {
+		/* sgi */
+		u32 msk = MT_WTBL_W5_SHORT_GI_20 | MT_WTBL_W5_SHORT_GI_40 |
+			  MT_WTBL_W5_SHORT_GI_80 | MT_WTBL_W5_SHORT_GI_160;
+		struct wtbl_raw *raw;
+
+		tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_RAW_DATA,
+						     sizeof(*raw), wtbl_tlv,
+						     sta_wtbl);
+
+		if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SGI_20)
+			flags |= MT_WTBL_W5_SHORT_GI_20;
+		if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SGI_40)
+			flags |= MT_WTBL_W5_SHORT_GI_40;
+
+		if (sta->deflink.vht_cap.vht_supported) {
+			if (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_80)
+				flags |= MT_WTBL_W5_SHORT_GI_80;
+			if (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_160)
+				flags |= MT_WTBL_W5_SHORT_GI_160;
+		}
+		raw = (struct wtbl_raw *)tlv;
+		raw->val = cpu_to_le32(flags);
+		raw->msk = cpu_to_le32(~msk);
+		raw->wtbl_idx = 1;
+		raw->dw = 5;
+	}
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_wtbl_ht_tlv);
+
+int mt76_connac_mcu_sta_cmd(struct mt76_phy *phy,
+			    struct mt76_sta_cmd_info *info)
+{
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)info->vif->drv_priv;
+	struct ieee80211_link_sta *link_sta;
+	struct mt76_dev *dev = phy->dev;
+	struct wtbl_req_hdr *wtbl_hdr;
+	struct tlv *sta_wtbl;
+	struct sk_buff *skb;
+	int conn_state;
+
+	if (!info->link_conf)
+		info->link_conf = &info->vif->bss_conf;
+
+	skb = mt76_connac_mcu_alloc_sta_req(dev, mvif, info->wcid);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	conn_state = info->enable ? CONN_STATE_PORT_SECURE :
+				    CONN_STATE_DISCONNECT;
+	link_sta = info->sta ? &info->sta->deflink : NULL;
+	if (info->sta || !info->offload_fw)
+		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->link_conf,
+					      link_sta, conn_state,
+					      info->newly);
+	if (info->sta && info->enable)
+		mt76_connac_mcu_sta_tlv(phy, skb, info->sta,
+					info->vif, info->rcpi,
+					info->state);
+
+	sta_wtbl = mt76_connac_mcu_add_tlv(skb, STA_REC_WTBL,
+					   sizeof(struct tlv));
+
+	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(dev, info->wcid,
+						  WTBL_RESET_AND_SET,
+						  sta_wtbl, &skb);
+	if (IS_ERR(wtbl_hdr))
+		return PTR_ERR(wtbl_hdr);
+
+	if (info->enable) {
+		mt76_connac_mcu_wtbl_generic_tlv(dev, skb, info->vif,
+						 info->sta, sta_wtbl,
+						 wtbl_hdr);
+		mt76_connac_mcu_wtbl_hdr_trans_tlv(skb, info->vif, info->wcid,
+						   sta_wtbl, wtbl_hdr);
+		if (info->sta)
+			mt76_connac_mcu_wtbl_ht_tlv(dev, skb, info->sta,
+						    sta_wtbl, wtbl_hdr,
+						    true, true);
+	}
+
+	return mt76_mcu_skb_send_msg(dev, skb, info->cmd, true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_cmd);
+
+void mt76_connac_mcu_wtbl_ba_tlv(struct mt76_dev *dev, struct sk_buff *skb,
+				 struct ieee80211_ampdu_params *params,
+				 bool enable, bool tx, void *sta_wtbl,
+				 void *wtbl_tlv)
+{
+	struct wtbl_ba *ba;
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_BA, sizeof(*ba),
+					     wtbl_tlv, sta_wtbl);
+
+	ba = (struct wtbl_ba *)tlv;
+	ba->tid = params->tid;
+
+	if (tx) {
+		ba->ba_type = MT_BA_TYPE_ORIGINATOR;
+		ba->sn = enable ? cpu_to_le16(params->ssn) : 0;
+		ba->ba_winsize = enable ? cpu_to_le16(params->buf_size) : 0;
+		ba->ba_en = enable;
+	} else {
+		memcpy(ba->peer_addr, params->sta->addr, ETH_ALEN);
+		ba->ba_type = MT_BA_TYPE_RECIPIENT;
+		ba->rst_ba_tid = params->tid;
+		ba->rst_ba_sel = RST_BA_MAC_TID_MATCH;
+		ba->rst_ba_sb = 1;
+	}
+
+	if (!is_connac_v1(dev)) {
+		ba->ba_winsize = enable ? cpu_to_le16(params->buf_size) : 0;
+		return;
+	}
+
+	if (enable && tx) {
+		static const u8 ba_range[] = { 4, 8, 12, 24, 36, 48, 54, 64 };
+		int i;
+
+		for (i = 7; i > 0; i--) {
+			if (params->buf_size >= ba_range[i])
+				break;
+		}
+		ba->ba_winsize_idx = i;
+	}
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_wtbl_ba_tlv);
+
+int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
+				struct ieee80211_bss_conf *bss_conf,
+				struct mt76_vif_link *mvif,
+				struct mt76_wcid *wcid,
+				bool enable)
+{
+	struct mt76_dev *dev = phy->dev;
+	struct {
+		struct {
+			u8 omac_idx;
+			u8 band_idx;
+			__le16 pad;
+		} __packed hdr;
+		struct req_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 active;
+			u8 link_idx; /* not link_id */
+			u8 omac_addr[ETH_ALEN];
+		} __packed tlv;
+	} dev_req = {
+		.hdr = {
+			.omac_idx = mvif->omac_idx,
+			.band_idx = mvif->band_idx,
+		},
+		.tlv = {
+			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
+			.len = cpu_to_le16(sizeof(struct req_tlv)),
+			.active = enable,
+			.link_idx = mvif->idx,
+		},
+	};
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt76_connac_bss_basic_tlv basic;
+	} basic_req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.basic = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_BASIC),
+			.len = cpu_to_le16(sizeof(struct mt76_connac_bss_basic_tlv)),
+			.omac_idx = mvif->omac_idx,
+			.band_idx = mvif->band_idx,
+			.wmm_idx = mvif->wmm_idx,
+			.active = enable,
+			.bmc_tx_wlan_idx = cpu_to_le16(wcid->idx),
+			.sta_idx = cpu_to_le16(wcid->idx),
+			.conn_state = 1,
+			.link_idx = mvif->idx,
+		},
+	};
+	int err, idx, cmd, len;
+	void *data;
+
+	switch (bss_conf->vif->type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_MONITOR:
+	case NL80211_IFTYPE_AP:
+		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_AP);
+		break;
+	case NL80211_IFTYPE_STATION:
+		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_STA);
+		break;
+	case NL80211_IFTYPE_P2P_DEVICE:
+		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_P2P_GO);
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	idx = mvif->omac_idx > EXT_BSSID_START ? HW_BSSID_0 : mvif->omac_idx;
+	basic_req.basic.hw_bss_idx = idx;
+
+	memcpy(dev_req.tlv.omac_addr, bss_conf->addr, ETH_ALEN);
+
+	cmd = enable ? MCU_UNI_CMD(DEV_INFO_UPDATE) : MCU_UNI_CMD(BSS_INFO_UPDATE);
+	data = enable ? (void *)&dev_req : (void *)&basic_req;
+	len = enable ? sizeof(dev_req) : sizeof(basic_req);
+
+	err = mt76_mcu_send_msg(dev, cmd, data, len, true);
+	if (err < 0)
+		return err;
+
+	cmd = enable ? MCU_UNI_CMD(BSS_INFO_UPDATE) : MCU_UNI_CMD(DEV_INFO_UPDATE);
+	data = enable ? (void *)&basic_req : (void *)&dev_req;
+	len = enable ? sizeof(basic_req) : sizeof(dev_req);
+
+	return mt76_mcu_send_msg(dev, cmd, data, len, true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_uni_add_dev);
+
+void mt76_connac_mcu_sta_ba_tlv(struct sk_buff *skb,
+				struct ieee80211_ampdu_params *params,
+				bool enable, bool tx)
+{
+	struct sta_rec_ba *ba;
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_BA, sizeof(*ba));
+
+	ba = (struct sta_rec_ba *)tlv;
+	ba->ba_type = tx ? MT_BA_TYPE_ORIGINATOR : MT_BA_TYPE_RECIPIENT;
+	ba->winsize = cpu_to_le16(params->buf_size);
+	ba->ssn = cpu_to_le16(params->ssn);
+	ba->ba_en = enable << params->tid;
+	ba->amsdu = params->amsdu;
+	ba->tid = params->tid;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_ba_tlv);
+
+int mt76_connac_mcu_sta_wed_update(struct mt76_dev *dev, struct sk_buff *skb)
+{
+	if (!mt76_is_mmio(dev))
+		return 0;
+
+	if (!mtk_wed_device_active(&dev->mmio.wed))
+		return 0;
+
+	return mtk_wed_device_update_msg(&dev->mmio.wed, WED_WO_STA_REC,
+					 skb->data, skb->len);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_wed_update);
+
+int mt76_connac_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif_link *mvif,
+			   struct ieee80211_ampdu_params *params,
+			   int cmd, bool enable, bool tx)
+{
+	struct mt76_wcid *wcid = (struct mt76_wcid *)params->sta->drv_priv;
+	struct wtbl_req_hdr *wtbl_hdr;
+	struct tlv *sta_wtbl;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = mt76_connac_mcu_alloc_sta_req(dev, mvif, wcid);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	sta_wtbl = mt76_connac_mcu_add_tlv(skb, STA_REC_WTBL,
+					   sizeof(struct tlv));
+
+	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(dev, wcid, WTBL_SET,
+						  sta_wtbl, &skb);
+	if (IS_ERR(wtbl_hdr))
+		return PTR_ERR(wtbl_hdr);
+
+	mt76_connac_mcu_wtbl_ba_tlv(dev, skb, params, enable, tx, sta_wtbl,
+				    wtbl_hdr);
+
+	ret = mt76_connac_mcu_sta_wed_update(dev, skb);
+	if (ret)
+		return ret;
+
+	ret = mt76_mcu_skb_send_msg(dev, skb, cmd, true);
+	if (ret)
+		return ret;
+
+	skb = mt76_connac_mcu_alloc_sta_req(dev, mvif, wcid);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	mt76_connac_mcu_sta_ba_tlv(skb, params, enable, tx);
+
+	ret = mt76_connac_mcu_sta_wed_update(dev, skb);
+	if (ret)
+		return ret;
+
+	return mt76_mcu_skb_send_msg(dev, skb, cmd, true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_ba);
+
+u8 mt76_connac_get_phy_mode(struct mt76_phy *phy, struct ieee80211_vif *vif,
+			    enum nl80211_band band,
+			    struct ieee80211_link_sta *link_sta)
+{
+	struct mt76_dev *dev = phy->dev;
+	const struct ieee80211_sta_he_cap *he_cap;
+	struct ieee80211_sta_vht_cap *vht_cap;
+	struct ieee80211_sta_ht_cap *ht_cap;
+	u8 mode = 0;
+
+	if (is_connac_v1(dev))
+		return 0x38;
+
+	if (link_sta) {
+		ht_cap = &link_sta->ht_cap;
+		vht_cap = &link_sta->vht_cap;
+		he_cap = &link_sta->he_cap;
+	} else {
+		struct ieee80211_supported_band *sband;
+
+		sband = phy->hw->wiphy->bands[band];
+		ht_cap = &sband->ht_cap;
+		vht_cap = &sband->vht_cap;
+		he_cap = ieee80211_get_he_iftype_cap(sband, vif->type);
+	}
+
+	if (band == NL80211_BAND_2GHZ) {
+		mode |= PHY_MODE_B | PHY_MODE_G;
+
+		if (ht_cap->ht_supported)
+			mode |= PHY_MODE_GN;
+
+		if (he_cap && he_cap->has_he)
+			mode |= PHY_MODE_AX_24G;
+	} else if (band == NL80211_BAND_5GHZ) {
+		mode |= PHY_MODE_A;
+
+		if (ht_cap->ht_supported)
+			mode |= PHY_MODE_AN;
+
+		if (vht_cap->vht_supported)
+			mode |= PHY_MODE_AC;
+
+		if (he_cap && he_cap->has_he)
+			mode |= PHY_MODE_AX_5G;
+	} else if (band == NL80211_BAND_6GHZ) {
+		mode |= PHY_MODE_A | PHY_MODE_AN |
+			PHY_MODE_AC | PHY_MODE_AX_5G;
+	}
+
+	return mode;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_get_phy_mode);
+
+u8 mt76_connac_get_phy_mode_ext(struct mt76_phy *phy, struct ieee80211_bss_conf *conf,
+				enum nl80211_band band)
+{
+	const struct ieee80211_sta_eht_cap *eht_cap;
+	struct ieee80211_supported_band *sband;
+	u8 mode = 0;
+
+	if (band == NL80211_BAND_6GHZ)
+		mode |= PHY_MODE_AX_6G;
+
+	sband = phy->hw->wiphy->bands[band];
+	eht_cap = ieee80211_get_eht_iftype_cap(sband, conf->vif->type);
+
+	if (!eht_cap || !eht_cap->has_eht || !conf->eht_support)
+		return mode;
+
+	switch (band) {
+	case NL80211_BAND_6GHZ:
+		mode |= PHY_MODE_BE_6G;
+		break;
+	case NL80211_BAND_5GHZ:
+		mode |= PHY_MODE_BE_5G;
+		break;
+	case NL80211_BAND_2GHZ:
+		mode |= PHY_MODE_BE_24G;
+		break;
+	default:
+		break;
+	}
+
+	return mode;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_get_phy_mode_ext);
+
+const struct ieee80211_sta_he_cap *
+mt76_connac_get_he_phy_cap(struct mt76_phy *phy, struct ieee80211_vif *vif)
+{
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
+	struct cfg80211_chan_def *chandef = mvif->ctx ?
+					    &mvif->ctx->def : &phy->chandef;
+	enum nl80211_band band = chandef->chan->band;
+	struct ieee80211_supported_band *sband;
+
+	sband = phy->hw->wiphy->bands[band];
+
+	return ieee80211_get_he_iftype_cap(sband, vif->type);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_get_he_phy_cap);
+
+const struct ieee80211_sta_eht_cap *
+mt76_connac_get_eht_phy_cap(struct mt76_phy *phy, struct ieee80211_vif *vif)
+{
+	enum nl80211_band band = phy->chandef.chan->band;
+	struct ieee80211_supported_band *sband;
+
+	sband = phy->hw->wiphy->bands[band];
+
+	return ieee80211_get_eht_iftype_cap(sband, vif->type);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_get_eht_phy_cap);
+
+#define DEFAULT_HE_PE_DURATION		4
+#define DEFAULT_HE_DURATION_RTS_THRES	1023
+static void
+mt76_connac_mcu_uni_bss_he_tlv(struct mt76_phy *phy, struct ieee80211_vif *vif,
+			       struct tlv *tlv)
+{
+	const struct ieee80211_sta_he_cap *cap;
+	struct bss_info_uni_he *he;
+
+	cap = mt76_connac_get_he_phy_cap(phy, vif);
+
+	he = (struct bss_info_uni_he *)tlv;
+	he->he_pe_duration = vif->bss_conf.htc_trig_based_pkt_ext;
+	if (!he->he_pe_duration)
+		he->he_pe_duration = DEFAULT_HE_PE_DURATION;
+
+	he->he_rts_thres = cpu_to_le16(vif->bss_conf.frame_time_rts_th);
+	if (!he->he_rts_thres)
+		he->he_rts_thres = cpu_to_le16(DEFAULT_HE_DURATION_RTS_THRES);
+
+	he->max_nss_mcs[CMD_HE_MCS_BW80] = cap->he_mcs_nss_supp.tx_mcs_80;
+	he->max_nss_mcs[CMD_HE_MCS_BW160] = cap->he_mcs_nss_supp.tx_mcs_160;
+	he->max_nss_mcs[CMD_HE_MCS_BW8080] = cap->he_mcs_nss_supp.tx_mcs_80p80;
+}
+
+int mt76_connac_mcu_uni_set_chctx(struct mt76_phy *phy, struct mt76_vif_link *mvif,
+				  struct ieee80211_chanctx_conf *ctx)
+{
+	struct cfg80211_chan_def *chandef = ctx ? &ctx->def : &phy->chandef;
+	int freq1 = chandef->center_freq1, freq2 = chandef->center_freq2;
+	enum nl80211_band band = chandef->chan->band;
+	struct mt76_dev *mdev = phy->dev;
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct rlm_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 control_channel;
+			u8 center_chan;
+			u8 center_chan2;
+			u8 bw;
+			u8 tx_streams;
+			u8 rx_streams;
+			u8 short_st;
+			u8 ht_op_info;
+			u8 sco;
+			u8 band;
+			u8 pad[2];
+		} __packed rlm;
+	} __packed rlm_req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.rlm = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_RLM),
+			.len = cpu_to_le16(sizeof(struct rlm_tlv)),
+			.control_channel = chandef->chan->hw_value,
+			.center_chan = ieee80211_frequency_to_channel(freq1),
+			.center_chan2 = ieee80211_frequency_to_channel(freq2),
+			.tx_streams = hweight8(phy->antenna_mask),
+			.ht_op_info = 4, /* set HT 40M allowed */
+			.rx_streams = phy->chainmask,
+			.short_st = true,
+			.band = band,
+		},
+	};
+
+	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_40:
+		rlm_req.rlm.bw = CMD_CBW_40MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_80:
+		rlm_req.rlm.bw = CMD_CBW_80MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_80P80:
+		rlm_req.rlm.bw = CMD_CBW_8080MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_160:
+		rlm_req.rlm.bw = CMD_CBW_160MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_5:
+		rlm_req.rlm.bw = CMD_CBW_5MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_10:
+		rlm_req.rlm.bw = CMD_CBW_10MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_20_NOHT:
+	case NL80211_CHAN_WIDTH_20:
+	default:
+		rlm_req.rlm.bw = CMD_CBW_20MHZ;
+		rlm_req.rlm.ht_op_info = 0;
+		break;
+	}
+
+	if (rlm_req.rlm.control_channel < rlm_req.rlm.center_chan)
+		rlm_req.rlm.sco = 1; /* SCA */
+	else if (rlm_req.rlm.control_channel > rlm_req.rlm.center_chan)
+		rlm_req.rlm.sco = 3; /* SCB */
+
+	return mt76_mcu_send_msg(mdev, MCU_UNI_CMD(BSS_INFO_UPDATE), &rlm_req,
+				 sizeof(rlm_req), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_uni_set_chctx);
+
+int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
+				struct ieee80211_vif *vif,
+				struct mt76_wcid *wcid,
+				bool enable,
+				struct ieee80211_chanctx_conf *ctx)
+{
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
+	struct cfg80211_chan_def *chandef = ctx ? &ctx->def : &phy->chandef;
+	enum nl80211_band band = chandef->chan->band;
+	struct mt76_dev *mdev = phy->dev;
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt76_connac_bss_basic_tlv basic;
+		struct mt76_connac_bss_qos_tlv qos;
+	} basic_req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.basic = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_BASIC),
+			.len = cpu_to_le16(sizeof(struct mt76_connac_bss_basic_tlv)),
+			.bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int),
+			.dtim_period = vif->bss_conf.dtim_period,
+			.omac_idx = mvif->omac_idx,
+			.band_idx = mvif->band_idx,
+			.wmm_idx = mvif->wmm_idx,
+			.active = true, /* keep bss deactivated */
+			.phymode = mt76_connac_get_phy_mode(phy, vif, band, NULL),
+		},
+		.qos = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_QBSS),
+			.len = cpu_to_le16(sizeof(struct mt76_connac_bss_qos_tlv)),
+			.qos = vif->bss_conf.qos,
+		},
+	};
+	int err, conn_type;
+	u8 idx, basic_phy;
+
+	idx = mvif->omac_idx > EXT_BSSID_START ? HW_BSSID_0 : mvif->omac_idx;
+	basic_req.basic.hw_bss_idx = idx;
+	if (band == NL80211_BAND_6GHZ)
+		basic_req.basic.phymode_ext = PHY_MODE_AX_6G;
+
+	basic_phy = mt76_connac_get_phy_mode_v2(phy, vif, band, NULL);
+	basic_req.basic.nonht_basic_phy = cpu_to_le16(basic_phy);
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_AP:
+		if (vif->p2p)
+			conn_type = CONNECTION_P2P_GO;
+		else
+			conn_type = CONNECTION_INFRA_AP;
+		basic_req.basic.conn_type = cpu_to_le32(conn_type);
+		/* Fully active/deactivate BSS network in AP mode only */
+		basic_req.basic.active = enable;
+		break;
+	case NL80211_IFTYPE_STATION:
+		if (vif->p2p)
+			conn_type = CONNECTION_P2P_GC;
+		else
+			conn_type = CONNECTION_INFRA_STA;
+		basic_req.basic.conn_type = cpu_to_le32(conn_type);
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	memcpy(basic_req.basic.bssid, vif->bss_conf.bssid, ETH_ALEN);
+	basic_req.basic.bmc_tx_wlan_idx = cpu_to_le16(wcid->idx);
+	basic_req.basic.sta_idx = cpu_to_le16(wcid->idx);
+	basic_req.basic.conn_state = !enable;
+
+	err = mt76_mcu_send_msg(mdev, MCU_UNI_CMD(BSS_INFO_UPDATE), &basic_req,
+				sizeof(basic_req), true);
+	if (err < 0)
+		return err;
+
+	if (vif->bss_conf.he_support) {
+		struct {
+			struct {
+				u8 bss_idx;
+				u8 pad[3];
+			} __packed hdr;
+			struct bss_info_uni_he he;
+			struct bss_info_uni_bss_color bss_color;
+		} he_req = {
+			.hdr = {
+				.bss_idx = mvif->idx,
+			},
+			.he = {
+				.tag = cpu_to_le16(UNI_BSS_INFO_HE_BASIC),
+				.len = cpu_to_le16(sizeof(struct bss_info_uni_he)),
+			},
+			.bss_color = {
+				.tag = cpu_to_le16(UNI_BSS_INFO_BSS_COLOR),
+				.len = cpu_to_le16(sizeof(struct bss_info_uni_bss_color)),
+				.enable = 0,
+				.bss_color = 0,
+			},
+		};
+
+		if (enable) {
+			he_req.bss_color.enable =
+				vif->bss_conf.he_bss_color.enabled;
+			he_req.bss_color.bss_color =
+				vif->bss_conf.he_bss_color.color;
+		}
+
+		mt76_connac_mcu_uni_bss_he_tlv(phy, vif,
+					       (struct tlv *)&he_req.he);
+		err = mt76_mcu_send_msg(mdev, MCU_UNI_CMD(BSS_INFO_UPDATE),
+					&he_req, sizeof(he_req), true);
+		if (err < 0)
+			return err;
+	}
+
+	return mt76_connac_mcu_uni_set_chctx(phy, mvif, ctx);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_uni_add_bss);
+
+#define MT76_CONNAC_SCAN_CHANNEL_TIME		60
+int mt76_connac_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
+			    struct ieee80211_scan_request *scan_req)
+{
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
+	struct cfg80211_scan_request *sreq = &scan_req->req;
+	int n_ssids = 0, err, i, duration;
+	int ext_channels_num = max_t(int, sreq->n_channels - 32, 0);
+	struct ieee80211_channel **scan_list = sreq->channels;
+	struct mt76_dev *mdev = phy->dev;
+	struct mt76_connac_mcu_scan_channel *chan;
+	struct mt76_connac_hw_scan_req *req;
+	struct sk_buff *skb;
+
+	if (test_bit(MT76_HW_SCANNING, &phy->state))
+		return -EBUSY;
+
+	skb = mt76_mcu_msg_alloc(mdev, NULL, sizeof(*req));
+	if (!skb)
+		return -ENOMEM;
+
+	set_bit(MT76_HW_SCANNING, &phy->state);
+	mvif->scan_seq_num = (mvif->scan_seq_num + 1) & 0x7f;
+
+	req = (struct mt76_connac_hw_scan_req *)skb_put_zero(skb, sizeof(*req));
+
+	req->seq_num = mvif->scan_seq_num | mvif->band_idx << 7;
+	req->bss_idx = mvif->idx;
+	req->scan_type = sreq->n_ssids ? 1 : 0;
+	req->probe_req_num = sreq->n_ssids ? 2 : 0;
+	req->version = 1;
+
+	for (i = 0; i < sreq->n_ssids; i++) {
+		if (!sreq->ssids[i].ssid_len)
+			continue;
+
+		req->ssids[i].ssid_len = cpu_to_le32(sreq->ssids[i].ssid_len);
+		memcpy(req->ssids[i].ssid, sreq->ssids[i].ssid,
+		       sreq->ssids[i].ssid_len);
+		n_ssids++;
+	}
+	req->ssid_type = n_ssids ? BIT(2) : BIT(0);
+	req->ssid_type_ext = n_ssids ? BIT(0) : 0;
+	req->ssids_num = n_ssids;
+
+	duration = is_mt7921(phy->dev) ? 0 : MT76_CONNAC_SCAN_CHANNEL_TIME;
+	/* increase channel time for passive scan */
+	if (!sreq->n_ssids)
+		duration *= 2;
+	req->timeout_value = cpu_to_le16(sreq->n_channels * duration);
+	req->channel_min_dwell_time = cpu_to_le16(duration);
+	req->channel_dwell_time = cpu_to_le16(duration);
+
+	if (sreq->n_channels == 0 || sreq->n_channels > 64) {
+		req->channel_type = 0;
+		req->channels_num = 0;
+		req->ext_channels_num = 0;
+	} else {
+		req->channel_type = 4;
+		req->channels_num = min_t(u8, sreq->n_channels, 32);
+		req->ext_channels_num = min_t(u8, ext_channels_num, 32);
+	}
+
+	for (i = 0; i < req->channels_num + req->ext_channels_num; i++) {
+		if (i >= 32)
+			chan = &req->ext_channels[i - 32];
+		else
+			chan = &req->channels[i];
+
+		switch (scan_list[i]->band) {
+		case NL80211_BAND_2GHZ:
+			chan->band = 1;
+			break;
+		case NL80211_BAND_6GHZ:
+			chan->band = 3;
+			break;
+		default:
+			chan->band = 2;
+			break;
+		}
+		chan->channel_num = scan_list[i]->hw_value;
+	}
+
+	if (sreq->ie_len > 0) {
+		memcpy(req->ies, sreq->ie, sreq->ie_len);
+		req->ies_len = cpu_to_le16(sreq->ie_len);
+	}
+
+	if (is_mt7921(phy->dev))
+		req->scan_func |= SCAN_FUNC_SPLIT_SCAN;
+
+	memcpy(req->bssid, sreq->bssid, ETH_ALEN);
+	if (sreq->flags & NL80211_SCAN_FLAG_RANDOM_ADDR) {
+		get_random_mask_addr(req->random_mac, sreq->mac_addr,
+				     sreq->mac_addr_mask);
+		req->scan_func |= SCAN_FUNC_RANDOM_MAC;
+	}
+
+	err = mt76_mcu_skb_send_msg(mdev, skb, MCU_CE_CMD(START_HW_SCAN),
+				    false);
+	if (err < 0)
+		clear_bit(MT76_HW_SCANNING, &phy->state);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_hw_scan);
+
+int mt76_connac_mcu_cancel_hw_scan(struct mt76_phy *phy,
+				   struct ieee80211_vif *vif)
+{
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
+	struct {
+		u8 seq_num;
+		u8 is_ext_channel;
+		u8 rsv[2];
+	} __packed req = {
+		.seq_num = mvif->scan_seq_num,
+	};
+
+	if (test_and_clear_bit(MT76_HW_SCANNING, &phy->state)) {
+		struct cfg80211_scan_info info = {
+			.aborted = true,
+		};
+
+		ieee80211_scan_completed(phy->hw, &info);
+	}
+
+	return mt76_mcu_send_msg(phy->dev, MCU_CE_CMD(CANCEL_HW_SCAN),
+				 &req, sizeof(req), false);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_cancel_hw_scan);
+
+int mt76_connac_mcu_sched_scan_req(struct mt76_phy *phy,
+				   struct ieee80211_vif *vif,
+				   struct cfg80211_sched_scan_request *sreq)
+{
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
+	struct ieee80211_channel **scan_list = sreq->channels;
+	struct mt76_connac_mcu_scan_channel *chan;
+	struct mt76_connac_sched_scan_req *req;
+	struct mt76_dev *mdev = phy->dev;
+	struct cfg80211_match_set *match;
+	struct cfg80211_ssid *ssid;
+	struct sk_buff *skb;
+	int i;
+
+	skb = mt76_mcu_msg_alloc(mdev, NULL, sizeof(*req) + sreq->ie_len);
+	if (!skb)
+		return -ENOMEM;
+
+	mvif->scan_seq_num = (mvif->scan_seq_num + 1) & 0x7f;
+
+	req = (struct mt76_connac_sched_scan_req *)skb_put_zero(skb, sizeof(*req));
+	req->version = 1;
+	req->seq_num = mvif->scan_seq_num | mvif->band_idx << 7;
+
+	if (sreq->flags & NL80211_SCAN_FLAG_RANDOM_ADDR) {
+		u8 *addr = is_mt7663(phy->dev) ? req->mt7663.random_mac
+					       : req->mt7921.random_mac;
+
+		req->scan_func = 1;
+		get_random_mask_addr(addr, sreq->mac_addr,
+				     sreq->mac_addr_mask);
+	}
+	if (is_mt7921(phy->dev)) {
+		req->mt7921.bss_idx = mvif->idx;
+		req->mt7921.delay = cpu_to_le32(sreq->delay);
+	}
+
+	req->ssids_num = sreq->n_ssids;
+	for (i = 0; i < req->ssids_num; i++) {
+		ssid = &sreq->ssids[i];
+		memcpy(req->ssids[i].ssid, ssid->ssid, ssid->ssid_len);
+		req->ssids[i].ssid_len = cpu_to_le32(ssid->ssid_len);
+	}
+
+	req->match_num = sreq->n_match_sets;
+	for (i = 0; i < req->match_num; i++) {
+		match = &sreq->match_sets[i];
+		memcpy(req->match[i].ssid, match->ssid.ssid,
+		       match->ssid.ssid_len);
+		req->match[i].rssi_th = cpu_to_le32(match->rssi_thold);
+		req->match[i].ssid_len = match->ssid.ssid_len;
+	}
+
+	req->channel_type = sreq->n_channels ? 4 : 0;
+	req->channels_num = min_t(u8, sreq->n_channels, 64);
+	for (i = 0; i < req->channels_num; i++) {
+		chan = &req->channels[i];
+
+		switch (scan_list[i]->band) {
+		case NL80211_BAND_2GHZ:
+			chan->band = 1;
+			break;
+		case NL80211_BAND_6GHZ:
+			chan->band = 3;
+			break;
+		default:
+			chan->band = 2;
+			break;
+		}
+		chan->channel_num = scan_list[i]->hw_value;
+	}
+
+	req->intervals_num = sreq->n_scan_plans;
+	for (i = 0; i < req->intervals_num; i++)
+		req->intervals[i] = cpu_to_le16(sreq->scan_plans[i].interval);
+
+	if (sreq->ie_len > 0) {
+		req->ie_len = cpu_to_le16(sreq->ie_len);
+		memcpy(skb_put(skb, sreq->ie_len), sreq->ie, sreq->ie_len);
+	}
+
+	return mt76_mcu_skb_send_msg(mdev, skb, MCU_CE_CMD(SCHED_SCAN_REQ),
+				     false);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_sched_scan_req);
+
+int mt76_connac_mcu_sched_scan_enable(struct mt76_phy *phy,
+				      struct ieee80211_vif *vif,
+				      bool enable)
+{
+	struct {
+		u8 active; /* 0: enabled 1: disabled */
+		u8 rsv[3];
+	} __packed req = {
+		.active = !enable,
+	};
+
+	if (enable)
+		set_bit(MT76_HW_SCHED_SCANNING, &phy->state);
+	else
+		clear_bit(MT76_HW_SCHED_SCANNING, &phy->state);
+
+	return mt76_mcu_send_msg(phy->dev, MCU_CE_CMD(SCHED_SCAN_ENABLE),
+				 &req, sizeof(req), false);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_sched_scan_enable);
+
+int mt76_connac_mcu_chip_config(struct mt76_dev *dev)
+{
+	struct mt76_connac_config req = {
+		.resp_type = 0,
+	};
+
+	memcpy(req.data, "assert", 7);
+
+	return mt76_mcu_send_msg(dev, MCU_CE_CMD(CHIP_CONFIG),
+				 &req, sizeof(req), false);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_chip_config);
+
+int mt76_connac_mcu_set_deep_sleep(struct mt76_dev *dev, bool enable)
+{
+	struct mt76_connac_config req = {
+		.resp_type = 0,
+	};
+
+	snprintf(req.data, sizeof(req.data), "KeepFullPwr %d", !enable);
+
+	return mt76_mcu_send_msg(dev, MCU_CE_CMD(CHIP_CONFIG),
+				 &req, sizeof(req), false);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_deep_sleep);
+
+int mt76_connac_sta_state_dp(struct mt76_dev *dev,
+			     enum ieee80211_sta_state old_state,
+			     enum ieee80211_sta_state new_state)
+{
+	if ((old_state == IEEE80211_STA_ASSOC &&
+	     new_state == IEEE80211_STA_AUTHORIZED) ||
+	    (old_state == IEEE80211_STA_NONE &&
+	     new_state == IEEE80211_STA_NOTEXIST))
+		mt76_connac_mcu_set_deep_sleep(dev, true);
+
+	if ((old_state == IEEE80211_STA_NOTEXIST &&
+	     new_state == IEEE80211_STA_NONE) ||
+	    (old_state == IEEE80211_STA_AUTHORIZED &&
+	     new_state == IEEE80211_STA_ASSOC))
+		mt76_connac_mcu_set_deep_sleep(dev, false);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_sta_state_dp);
+
+void mt76_connac_mcu_coredump_event(struct mt76_dev *dev, struct sk_buff *skb,
+				    struct mt76_connac_coredump *coredump)
+{
+	spin_lock_bh(&dev->lock);
+	__skb_queue_tail(&coredump->msg_list, skb);
+	spin_unlock_bh(&dev->lock);
+
+	coredump->last_activity = jiffies;
+
+	queue_delayed_work(dev->wq, &coredump->work,
+			   MT76_CONNAC_COREDUMP_TIMEOUT);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_coredump_event);
+
+static void
+mt76_connac_mcu_build_sku(struct mt76_dev *dev, s8 *sku,
+			  struct mt76_power_limits *limits,
+			  enum nl80211_band band)
+{
+	int max_power = is_mt7921(dev) ? 127 : 63;
+	int i, offset = sizeof(limits->cck);
+
+	memset(sku, max_power, MT_SKU_POWER_LIMIT);
+
+	if (band == NL80211_BAND_2GHZ) {
+		/* cck */
+		memcpy(sku, limits->cck, sizeof(limits->cck));
+	}
+
+	/* ofdm */
+	memcpy(&sku[offset], limits->ofdm, sizeof(limits->ofdm));
+	offset += sizeof(limits->ofdm);
+
+	/* ht */
+	for (i = 0; i < 2; i++) {
+		memcpy(&sku[offset], limits->mcs[i], 8);
+		offset += 8;
+	}
+	sku[offset++] = limits->mcs[0][0];
+
+	/* vht */
+	for (i = 0; i < ARRAY_SIZE(limits->mcs); i++) {
+		memcpy(&sku[offset], limits->mcs[i],
+		       ARRAY_SIZE(limits->mcs[i]));
+		offset += 12;
+	}
+
+	if (!is_mt7921(dev))
+		return;
+
+	/* he */
+	for (i = 0; i < ARRAY_SIZE(limits->ru); i++) {
+		memcpy(&sku[offset], limits->ru[i], ARRAY_SIZE(limits->ru[i]));
+		offset += ARRAY_SIZE(limits->ru[i]);
+	}
+}
+
+s8 mt76_connac_get_ch_power(struct mt76_phy *phy,
+			    struct ieee80211_channel *chan,
+			    s8 target_power)
+{
+	struct mt76_dev *dev = phy->dev;
+	struct ieee80211_supported_band *sband;
+	int i;
+
+	switch (chan->band) {
+	case NL80211_BAND_2GHZ:
+		sband = &phy->sband_2g.sband;
+		break;
+	case NL80211_BAND_5GHZ:
+		sband = &phy->sband_5g.sband;
+		break;
+	case NL80211_BAND_6GHZ:
+		sband = &phy->sband_6g.sband;
+		break;
+	default:
+		return target_power;
+	}
+
+	for (i = 0; i < sband->n_channels; i++) {
+		struct ieee80211_channel *ch = &sband->channels[i];
+
+		if (ch->hw_value == chan->hw_value) {
+			if (!(ch->flags & IEEE80211_CHAN_DISABLED)) {
+				int power = 2 * ch->max_reg_power;
+
+				if (is_mt7663(dev) && (power > 63 || power < -64))
+					power = 63;
+				target_power = min_t(s8, power, target_power);
+			}
+			break;
+		}
+	}
+
+	return target_power;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_get_ch_power);
+
+static int
+mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
+				  enum nl80211_band band)
+{
+	struct mt76_dev *dev = phy->dev;
+	int sku_len, batch_len = is_mt7921(dev) ? 8 : 16;
+	static const u8 chan_list_2ghz[] = {
+		1, 2,  3,  4,  5,  6,  7,
+		8, 9, 10, 11, 12, 13, 14
+	};
+	static const u8 chan_list_5ghz[] = {
+		 36,  38,  40,  42,  44,  46,  48,
+		 50,  52,  54,  56,  58,  60,  62,
+		 64, 100, 102, 104, 106, 108, 110,
+		112, 114, 116, 118, 120, 122, 124,
+		126, 128, 132, 134, 136, 138, 140,
+		142, 144, 149, 151, 153, 155, 157,
+		159, 161, 165, 169, 173, 177
+	};
+	static const u8 chan_list_6ghz[] = {
+		  1,   3,   5,   7,   9,  11,  13,
+		 15,  17,  19,  21,  23,  25,  27,
+		 29,  33,  35,  37,  39,  41,  43,
+		 45,  47,  49,  51,  53,  55,  57,
+		 59,  61,  65,  67,  69,  71,  73,
+		 75,  77,  79,  81,  83,  85,  87,
+		 89,  91,  93,  97,  99, 101, 103,
+		105, 107, 109, 111, 113, 115, 117,
+		119, 121, 123, 125, 129, 131, 133,
+		135, 137, 139, 141, 143, 145, 147,
+		149, 151, 153, 155, 157, 161, 163,
+		165, 167, 169, 171, 173, 175, 177,
+		179, 181, 183, 185, 187, 189, 193,
+		195, 197, 199, 201, 203, 205, 207,
+		209, 211, 213, 215, 217, 219, 221,
+		225, 227, 229, 233
+	};
+	int i, n_chan, batch_size, idx = 0, tx_power, last_ch, err = 0;
+	struct mt76_connac_sku_tlv sku_tlbv;
+	struct mt76_power_limits *limits;
+	const u8 *ch_list;
+
+	limits = devm_kmalloc(dev->dev, sizeof(*limits), GFP_KERNEL);
+	if (!limits)
+		return -ENOMEM;
+
+	sku_len = is_mt7921(dev) ? sizeof(sku_tlbv) : sizeof(sku_tlbv) - 92;
+	tx_power = 2 * phy->hw->conf.power_level;
+	if (!tx_power)
+		tx_power = 127;
+
+	if (band == NL80211_BAND_2GHZ) {
+		n_chan = ARRAY_SIZE(chan_list_2ghz);
+		ch_list = chan_list_2ghz;
+	} else if (band == NL80211_BAND_6GHZ) {
+		n_chan = ARRAY_SIZE(chan_list_6ghz);
+		ch_list = chan_list_6ghz;
+	} else {
+		n_chan = ARRAY_SIZE(chan_list_5ghz);
+		ch_list = chan_list_5ghz;
+	}
+	batch_size = DIV_ROUND_UP(n_chan, batch_len);
+
+	if (phy->cap.has_6ghz)
+		last_ch = chan_list_6ghz[ARRAY_SIZE(chan_list_6ghz) - 1];
+	else if (phy->cap.has_5ghz)
+		last_ch = chan_list_5ghz[ARRAY_SIZE(chan_list_5ghz) - 1];
+	else
+		last_ch = chan_list_2ghz[ARRAY_SIZE(chan_list_2ghz) - 1];
+
+	for (i = 0; i < batch_size; i++) {
+		struct mt76_connac_tx_power_limit_tlv tx_power_tlv = {};
+		int j, msg_len, num_ch;
+		struct sk_buff *skb;
+
+		num_ch = i == batch_size - 1 ? n_chan - i * batch_len : batch_len;
+		msg_len = sizeof(tx_power_tlv) + num_ch * sizeof(sku_tlbv);
+		skb = mt76_mcu_msg_alloc(dev, NULL, msg_len);
+		if (!skb) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		skb_reserve(skb, sizeof(tx_power_tlv));
+
+		BUILD_BUG_ON(sizeof(dev->alpha2) > sizeof(tx_power_tlv.alpha2));
+		memcpy(tx_power_tlv.alpha2, dev->alpha2, sizeof(dev->alpha2));
+		tx_power_tlv.n_chan = num_ch;
+
+		switch (band) {
+		case NL80211_BAND_2GHZ:
+			tx_power_tlv.band = 1;
+			break;
+		case NL80211_BAND_6GHZ:
+			tx_power_tlv.band = 3;
+			break;
+		default:
+			tx_power_tlv.band = 2;
+			break;
+		}
+
+		for (j = 0; j < num_ch; j++, idx++) {
+			struct ieee80211_channel chan = {
+				.hw_value = ch_list[idx],
+				.band = band,
+			};
+			s8 reg_power, sar_power;
+
+			reg_power = mt76_connac_get_ch_power(phy, &chan,
+							     tx_power);
+			sar_power = mt76_get_sar_power(phy, &chan, reg_power);
+
+			mt76_get_rate_power_limits(phy, &chan, limits,
+						   sar_power);
+
+			tx_power_tlv.last_msg = ch_list[idx] == last_ch;
+			sku_tlbv.channel = ch_list[idx];
+
+			mt76_connac_mcu_build_sku(dev, sku_tlbv.pwr_limit,
+						  limits, band);
+			skb_put_data(skb, &sku_tlbv, sku_len);
+		}
+		__skb_push(skb, sizeof(tx_power_tlv));
+		memcpy(skb->data, &tx_power_tlv, sizeof(tx_power_tlv));
+
+		err = mt76_mcu_skb_send_msg(dev, skb,
+					    MCU_CE_CMD(SET_RATE_TX_POWER),
+					    false);
+		if (err < 0)
+			goto out;
+	}
+
+out:
+	devm_kfree(dev->dev, limits);
+	return err;
+}
+
+int mt76_connac_mcu_set_rate_txpower(struct mt76_phy *phy)
+{
+	int err;
+
+	if (phy->cap.has_2ghz) {
+		err = mt76_connac_mcu_rate_txpower_band(phy,
+							NL80211_BAND_2GHZ);
+		if (err < 0)
+			return err;
+	}
+	if (phy->cap.has_5ghz) {
+		err = mt76_connac_mcu_rate_txpower_band(phy,
+							NL80211_BAND_5GHZ);
+		if (err < 0)
+			return err;
+	}
+	if (phy->cap.has_6ghz) {
+		err = mt76_connac_mcu_rate_txpower_band(phy,
+							NL80211_BAND_6GHZ);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_rate_txpower);
+
+int mt76_connac_mcu_update_arp_filter(struct mt76_dev *dev,
+				      struct mt76_vif_link *vif,
+				      struct ieee80211_bss_conf *info)
+{
+	struct ieee80211_vif *mvif = container_of(info, struct ieee80211_vif,
+						  bss_conf);
+	struct sk_buff *skb;
+	int i, len = min_t(int, mvif->cfg.arp_addr_cnt,
+			   IEEE80211_BSS_ARP_ADDR_LIST_LEN);
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt76_connac_arpns_tlv arp;
+	} req_hdr = {
+		.hdr = {
+			.bss_idx = vif->idx,
+		},
+		.arp = {
+			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_ARP),
+			.len = cpu_to_le16(sizeof(struct mt76_connac_arpns_tlv)),
+			.ips_num = len,
+			.mode = 2,  /* update */
+			.option = 1,
+		},
+	};
+
+	skb = mt76_mcu_msg_alloc(dev, NULL,
+				 sizeof(req_hdr) + len * sizeof(__be32));
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put_data(skb, &req_hdr, sizeof(req_hdr));
+	for (i = 0; i < len; i++)
+		skb_put_data(skb, &mvif->cfg.arp_addr_list[i], sizeof(__be32));
+
+	return mt76_mcu_skb_send_msg(dev, skb, MCU_UNI_CMD(OFFLOAD), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_update_arp_filter);
+
+int mt76_connac_mcu_set_p2p_oppps(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif)
+{
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
+	int ct_window = vif->bss_conf.p2p_noa_attr.oppps_ctwindow;
+	struct mt76_phy *phy = hw->priv;
+	struct {
+		__le32 ct_win;
+		u8 bss_idx;
+		u8 rsv[3];
+	} __packed req = {
+		.ct_win = cpu_to_le32(ct_window),
+		.bss_idx = mvif->idx,
+	};
+
+	return mt76_mcu_send_msg(phy->dev, MCU_CE_CMD(SET_P2P_OPPPS),
+				 &req, sizeof(req), false);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_p2p_oppps);
+
+#ifdef CONFIG_PM
+
+const struct wiphy_wowlan_support mt76_connac_wowlan_support = {
+	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT |
+		 WIPHY_WOWLAN_SUPPORTS_GTK_REKEY | WIPHY_WOWLAN_NET_DETECT,
+	.n_patterns = 1,
+	.pattern_min_len = 1,
+	.pattern_max_len = MT76_CONNAC_WOW_PATTEN_MAX_LEN,
+	.max_nd_match_sets = 10,
+};
+EXPORT_SYMBOL_GPL(mt76_connac_wowlan_support);
+
+static void
+mt76_connac_mcu_key_iter(struct ieee80211_hw *hw,
+			 struct ieee80211_vif *vif,
+			 struct ieee80211_sta *sta,
+			 struct ieee80211_key_conf *key,
+			 void *data)
+{
+	struct mt76_connac_gtk_rekey_tlv *gtk_tlv = data;
+	u32 cipher;
+
+	if (key->cipher != WLAN_CIPHER_SUITE_AES_CMAC &&
+	    key->cipher != WLAN_CIPHER_SUITE_CCMP &&
+	    key->cipher != WLAN_CIPHER_SUITE_TKIP)
+		return;
+
+	if (key->cipher == WLAN_CIPHER_SUITE_TKIP)
+		cipher = BIT(3);
+	else
+		cipher = BIT(4);
+
+	/* we are assuming here to have a single pairwise key */
+	if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE) {
+		if (key->cipher == WLAN_CIPHER_SUITE_TKIP)
+			gtk_tlv->proto = cpu_to_le32(NL80211_WPA_VERSION_1);
+		else
+			gtk_tlv->proto = cpu_to_le32(NL80211_WPA_VERSION_2);
+
+		gtk_tlv->pairwise_cipher = cpu_to_le32(cipher);
+		gtk_tlv->keyid = key->keyidx;
+	} else {
+		gtk_tlv->group_cipher = cpu_to_le32(cipher);
+	}
+}
+
+int mt76_connac_mcu_update_gtk_rekey(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif,
+				     struct cfg80211_gtk_rekey_data *key)
+{
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
+	struct mt76_connac_gtk_rekey_tlv *gtk_tlv;
+	struct mt76_phy *phy = hw->priv;
+	struct sk_buff *skb;
+	struct {
+		u8 bss_idx;
+		u8 pad[3];
+	} __packed hdr = {
+		.bss_idx = mvif->idx,
+	};
+
+	skb = mt76_mcu_msg_alloc(phy->dev, NULL,
+				 sizeof(hdr) + sizeof(*gtk_tlv));
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put_data(skb, &hdr, sizeof(hdr));
+	gtk_tlv = (struct mt76_connac_gtk_rekey_tlv *)skb_put_zero(skb,
+							 sizeof(*gtk_tlv));
+	gtk_tlv->tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_GTK_REKEY);
+	gtk_tlv->len = cpu_to_le16(sizeof(*gtk_tlv));
+	gtk_tlv->rekey_mode = 2;
+	gtk_tlv->option = 1;
+
+	rcu_read_lock();
+	ieee80211_iter_keys_rcu(hw, vif, mt76_connac_mcu_key_iter, gtk_tlv);
+	rcu_read_unlock();
+
+	memcpy(gtk_tlv->kek, key->kek, NL80211_KEK_LEN);
+	memcpy(gtk_tlv->kck, key->kck, NL80211_KCK_LEN);
+	memcpy(gtk_tlv->replay_ctr, key->replay_ctr, NL80211_REPLAY_CTR_LEN);
+
+	return mt76_mcu_skb_send_msg(phy->dev, skb,
+				     MCU_UNI_CMD(OFFLOAD), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_update_gtk_rekey);
+
+static int
+mt76_connac_mcu_set_arp_filter(struct mt76_dev *dev, struct ieee80211_vif *vif,
+			       bool suspend)
+{
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt76_connac_arpns_tlv arpns;
+	} req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.arpns = {
+			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_ARP),
+			.len = cpu_to_le16(sizeof(struct mt76_connac_arpns_tlv)),
+			.mode = suspend,
+		},
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_UNI_CMD(OFFLOAD), &req,
+				 sizeof(req), true);
+}
+
+int
+mt76_connac_mcu_set_gtk_rekey(struct mt76_dev *dev, struct ieee80211_vif *vif,
+			      bool suspend)
+{
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt76_connac_gtk_rekey_tlv gtk_tlv;
+	} __packed req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.gtk_tlv = {
+			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_GTK_REKEY),
+			.len = cpu_to_le16(sizeof(struct mt76_connac_gtk_rekey_tlv)),
+			.rekey_mode = !suspend,
+		},
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_UNI_CMD(OFFLOAD), &req,
+				 sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_gtk_rekey);
+
+int
+mt76_connac_mcu_set_suspend_mode(struct mt76_dev *dev,
+				 struct ieee80211_vif *vif,
+				 bool enable, u8 mdtim,
+				 bool wow_suspend)
+{
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt76_connac_suspend_tlv suspend_tlv;
+	} req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.suspend_tlv = {
+			.tag = cpu_to_le16(UNI_SUSPEND_MODE_SETTING),
+			.len = cpu_to_le16(sizeof(struct mt76_connac_suspend_tlv)),
+			.enable = enable,
+			.mdtim = mdtim,
+			.wow_suspend = wow_suspend,
+		},
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_UNI_CMD(SUSPEND), &req,
+				 sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_suspend_mode);
+
+static int
+mt76_connac_mcu_set_wow_pattern(struct mt76_dev *dev,
+				struct ieee80211_vif *vif,
+				u8 index, bool enable,
+				struct cfg80211_pkt_pattern *pattern)
+{
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
+	struct mt76_connac_wow_pattern_tlv *ptlv;
+	struct sk_buff *skb;
+	struct req_hdr {
+		u8 bss_idx;
+		u8 pad[3];
+	} __packed hdr = {
+		.bss_idx = mvif->idx,
+	};
+
+	skb = mt76_mcu_msg_alloc(dev, NULL, sizeof(hdr) + sizeof(*ptlv));
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put_data(skb, &hdr, sizeof(hdr));
+	ptlv = (struct mt76_connac_wow_pattern_tlv *)skb_put_zero(skb, sizeof(*ptlv));
+	ptlv->tag = cpu_to_le16(UNI_SUSPEND_WOW_PATTERN);
+	ptlv->len = cpu_to_le16(sizeof(*ptlv));
+	ptlv->data_len = pattern->pattern_len;
+	ptlv->enable = enable;
+	ptlv->index = index;
+
+	memcpy(ptlv->pattern, pattern->pattern, pattern->pattern_len);
+	memcpy(ptlv->mask, pattern->mask, DIV_ROUND_UP(pattern->pattern_len, 8));
+
+	return mt76_mcu_skb_send_msg(dev, skb, MCU_UNI_CMD(SUSPEND), true);
+}
+
+int
+mt76_connac_mcu_set_wow_ctrl(struct mt76_phy *phy, struct ieee80211_vif *vif,
+			     bool suspend, struct cfg80211_wowlan *wowlan)
+{
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
+	struct mt76_dev *dev = phy->dev;
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt76_connac_wow_ctrl_tlv wow_ctrl_tlv;
+		struct mt76_connac_wow_gpio_param_tlv gpio_tlv;
+	} req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.wow_ctrl_tlv = {
+			.tag = cpu_to_le16(UNI_SUSPEND_WOW_CTRL),
+			.len = cpu_to_le16(sizeof(struct mt76_connac_wow_ctrl_tlv)),
+			.cmd = suspend ? 1 : 2,
+		},
+		.gpio_tlv = {
+			.tag = cpu_to_le16(UNI_SUSPEND_WOW_GPIO_PARAM),
+			.len = cpu_to_le16(sizeof(struct mt76_connac_wow_gpio_param_tlv)),
+			.gpio_pin = 0xff, /* follow fw about GPIO pin */
+		},
+	};
+
+	if (wowlan->magic_pkt)
+		req.wow_ctrl_tlv.trigger |= UNI_WOW_DETECT_TYPE_MAGIC;
+	if (wowlan->disconnect)
+		req.wow_ctrl_tlv.trigger |= (UNI_WOW_DETECT_TYPE_DISCONNECT |
+					     UNI_WOW_DETECT_TYPE_BCN_LOST);
+	if (wowlan->nd_config) {
+		mt76_connac_mcu_sched_scan_req(phy, vif, wowlan->nd_config);
+		req.wow_ctrl_tlv.trigger |= UNI_WOW_DETECT_TYPE_SCH_SCAN_HIT;
+		mt76_connac_mcu_sched_scan_enable(phy, vif, suspend);
+	}
+	if (wowlan->n_patterns)
+		req.wow_ctrl_tlv.trigger |= UNI_WOW_DETECT_TYPE_BITMAP;
+
+	if (mt76_is_mmio(dev))
+		req.wow_ctrl_tlv.wakeup_hif = WOW_PCIE;
+	else if (mt76_is_usb(dev))
+		req.wow_ctrl_tlv.wakeup_hif = WOW_USB;
+	else if (mt76_is_sdio(dev))
+		req.wow_ctrl_tlv.wakeup_hif = WOW_GPIO;
+
+	return mt76_mcu_send_msg(dev, MCU_UNI_CMD(SUSPEND), &req,
+				 sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_wow_ctrl);
+
+int mt76_connac_mcu_set_hif_suspend(struct mt76_dev *dev, bool suspend, bool wait_resp)
+{
+	struct {
+		struct {
+			u8 hif_type; /* 0x0: HIF_SDIO
+				      * 0x1: HIF_USB
+				      * 0x2: HIF_PCIE
+				      */
+			u8 pad[3];
+		} __packed hdr;
+		struct hif_suspend_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 suspend;
+			u8 pad[7];
+		} __packed hif_suspend;
+	} req = {
+		.hif_suspend = {
+			.tag = cpu_to_le16(0), /* 0: UNI_HIF_CTRL_BASIC */
+			.len = cpu_to_le16(sizeof(struct hif_suspend_tlv)),
+			.suspend = suspend,
+		},
+	};
+
+	if (mt76_is_mmio(dev))
+		req.hdr.hif_type = 2;
+	else if (mt76_is_usb(dev))
+		req.hdr.hif_type = 1;
+	else if (mt76_is_sdio(dev))
+		req.hdr.hif_type = 0;
+
+	return mt76_mcu_send_msg(dev, MCU_UNI_CMD(HIF_CTRL), &req,
+				 sizeof(req), wait_resp);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_hif_suspend);
+
+void mt76_connac_mcu_set_suspend_iter(void *priv, u8 *mac,
+				      struct ieee80211_vif *vif)
+{
+	struct mt76_phy *phy = priv;
+	bool suspend = !test_bit(MT76_STATE_RUNNING, &phy->state);
+	struct ieee80211_hw *hw = phy->hw;
+	struct cfg80211_wowlan *wowlan = hw->wiphy->wowlan_config;
+	int i;
+
+	mt76_connac_mcu_set_gtk_rekey(phy->dev, vif, suspend);
+	mt76_connac_mcu_set_arp_filter(phy->dev, vif, suspend);
+
+	mt76_connac_mcu_set_suspend_mode(phy->dev, vif, suspend, 1, true);
+
+	for (i = 0; i < wowlan->n_patterns; i++)
+		mt76_connac_mcu_set_wow_pattern(phy->dev, vif, i, suspend,
+						&wowlan->patterns[i]);
+	mt76_connac_mcu_set_wow_ctrl(phy, vif, suspend, wowlan);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_suspend_iter);
+#endif /* CONFIG_PM */
+
+u32 mt76_connac_mcu_reg_rr(struct mt76_dev *dev, u32 offset)
+{
+	struct {
+		__le32 addr;
+		__le32 val;
+	} __packed req = {
+		.addr = cpu_to_le32(offset),
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_CE_QUERY(REG_READ), &req,
+				 sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_reg_rr);
+
+void mt76_connac_mcu_reg_wr(struct mt76_dev *dev, u32 offset, u32 val)
+{
+	struct {
+		__le32 addr;
+		__le32 val;
+	} __packed req = {
+		.addr = cpu_to_le32(offset),
+		.val = cpu_to_le32(val),
+	};
+
+	mt76_mcu_send_msg(dev, MCU_CE_CMD(REG_WRITE), &req,
+			  sizeof(req), false);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_reg_wr);
+
+static int
+mt76_connac_mcu_sta_key_tlv(struct mt76_connac_sta_key_conf *sta_key_conf,
+			    struct sk_buff *skb,
+			    struct ieee80211_key_conf *key,
+			    enum set_key_cmd cmd)
+{
+	struct sta_rec_sec *sec;
+	u32 len = sizeof(*sec);
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_KEY_V2, sizeof(*sec));
+	sec = (struct sta_rec_sec *)tlv;
+	sec->add = cmd;
+
+	if (cmd == SET_KEY) {
+		struct sec_key *sec_key;
+		u8 cipher;
+
+		cipher = mt76_connac_mcu_get_cipher(key->cipher);
+		if (cipher == MCU_CIPHER_NONE)
+			return -EOPNOTSUPP;
+
+		sec_key = &sec->key[0];
+		sec_key->cipher_len = sizeof(*sec_key);
+
+		if (cipher == MCU_CIPHER_BIP_CMAC_128) {
+			sec_key->cipher_id = MCU_CIPHER_AES_CCMP;
+			sec_key->key_id = sta_key_conf->keyidx;
+			sec_key->key_len = 16;
+			memcpy(sec_key->key, sta_key_conf->key, 16);
+
+			sec_key = &sec->key[1];
+			sec_key->cipher_id = MCU_CIPHER_BIP_CMAC_128;
+			sec_key->cipher_len = sizeof(*sec_key);
+			sec_key->key_len = 16;
+			memcpy(sec_key->key, key->key, 16);
+			sec->n_cipher = 2;
+		} else {
+			sec_key->cipher_id = cipher;
+			sec_key->key_id = key->keyidx;
+			sec_key->key_len = key->keylen;
+			memcpy(sec_key->key, key->key, key->keylen);
+
+			if (cipher == MCU_CIPHER_TKIP) {
+				/* Rx/Tx MIC keys are swapped */
+				memcpy(sec_key->key + 16, key->key + 24, 8);
+				memcpy(sec_key->key + 24, key->key + 16, 8);
+			}
+
+			/* store key_conf for BIP batch update */
+			if (cipher == MCU_CIPHER_AES_CCMP) {
+				memcpy(sta_key_conf->key, key->key, key->keylen);
+				sta_key_conf->keyidx = key->keyidx;
+			}
+
+			len -= sizeof(*sec_key);
+			sec->n_cipher = 1;
+		}
+	} else {
+		len -= sizeof(sec->key);
+		sec->n_cipher = 0;
+	}
+	sec->len = cpu_to_le16(len);
+
+	return 0;
+}
+
+int mt76_connac_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
+			    struct mt76_connac_sta_key_conf *sta_key_conf,
+			    struct ieee80211_key_conf *key, int mcu_cmd,
+			    struct mt76_wcid *wcid, enum set_key_cmd cmd)
+{
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = mt76_connac_mcu_alloc_sta_req(dev, mvif, wcid);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	ret = mt76_connac_mcu_sta_key_tlv(sta_key_conf, skb, key, cmd);
+	if (ret)
+		return ret;
+
+	ret = mt76_connac_mcu_sta_wed_update(dev, skb);
+	if (ret)
+		return ret;
+
+	return mt76_mcu_skb_send_msg(dev, skb, mcu_cmd, true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_add_key);
+
+/* SIFS 20us + 512 byte beacon transmitted by 1Mbps (3906us) */
+#define BCN_TX_ESTIMATE_TIME (4096 + 20)
+void mt76_connac_mcu_bss_ext_tlv(struct sk_buff *skb, struct mt76_vif_link *mvif)
+{
+	struct bss_info_ext_bss *ext;
+	int ext_bss_idx, tsf_offset;
+	struct tlv *tlv;
+
+	ext_bss_idx = mvif->omac_idx - EXT_BSSID_START;
+	if (ext_bss_idx < 0)
+		return;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_EXT_BSS, sizeof(*ext));
+
+	ext = (struct bss_info_ext_bss *)tlv;
+	tsf_offset = ext_bss_idx * BCN_TX_ESTIMATE_TIME;
+	ext->mbss_tsf_offset = cpu_to_le32(tsf_offset);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_bss_ext_tlv);
+
+int mt76_connac_mcu_bss_basic_tlv(struct sk_buff *skb,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_sta *sta,
+				  struct mt76_phy *phy, u16 wlan_idx,
+				  bool enable)
+{
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
+	u32 type = vif->p2p ? NETWORK_P2P : NETWORK_INFRA;
+	struct bss_info_basic *bss;
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_BASIC, sizeof(*bss));
+	bss = (struct bss_info_basic *)tlv;
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_MONITOR:
+		break;
+	case NL80211_IFTYPE_AP:
+		if (ieee80211_hw_check(phy->hw, SUPPORTS_MULTI_BSSID)) {
+			u8 bssid_id = vif->bss_conf.bssid_indicator;
+			struct wiphy *wiphy = phy->hw->wiphy;
+
+			if (bssid_id > ilog2(wiphy->mbssid_max_interfaces))
+				return -EINVAL;
+
+			bss->non_tx_bssid = vif->bss_conf.bssid_index;
+			bss->max_bssid = bssid_id;
+		}
+		break;
+	case NL80211_IFTYPE_STATION:
+		if (enable) {
+			rcu_read_lock();
+			if (!sta)
+				sta = ieee80211_find_sta(vif,
+							 vif->bss_conf.bssid);
+			/* TODO: enable BSS_INFO_UAPSD & BSS_INFO_PM */
+			if (sta) {
+				struct mt76_wcid *wcid;
+
+				wcid = (struct mt76_wcid *)sta->drv_priv;
+				wlan_idx = wcid->idx;
+			}
+			rcu_read_unlock();
+		}
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		type = NETWORK_IBSS;
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	bss->network_type = cpu_to_le32(type);
+	bss->bmc_wcid_lo = to_wcid_lo(wlan_idx);
+	bss->bmc_wcid_hi = to_wcid_hi(wlan_idx);
+	bss->wmm_idx = mvif->wmm_idx;
+	bss->active = enable;
+	bss->cipher = mvif->cipher;
+
+	if (vif->type != NL80211_IFTYPE_MONITOR) {
+		struct cfg80211_chan_def *chandef = &phy->chandef;
+
+		memcpy(bss->bssid, vif->bss_conf.bssid, ETH_ALEN);
+		bss->bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int);
+		bss->dtim_period = vif->bss_conf.dtim_period;
+		bss->phy_mode = mt76_connac_get_phy_mode(phy, vif,
+							 chandef->chan->band, NULL);
+	} else {
+		memcpy(bss->bssid, phy->macaddr, ETH_ALEN);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_bss_basic_tlv);
+
+#define ENTER_PM_STATE		1
+#define EXIT_PM_STATE		2
+int mt76_connac_mcu_set_pm(struct mt76_dev *dev, int band, int enter)
+{
+	struct {
+		u8 pm_number;
+		u8 pm_state;
+		u8 bssid[ETH_ALEN];
+		u8 dtim_period;
+		u8 wlan_idx_lo;
+		__le16 bcn_interval;
+		__le32 aid;
+		__le32 rx_filter;
+		u8 band_idx;
+		u8 wlan_idx_hi;
+		u8 rsv[2];
+		__le32 feature;
+		u8 omac_idx;
+		u8 wmm_idx;
+		u8 bcn_loss_cnt;
+		u8 bcn_sp_duration;
+	} __packed req = {
+		.pm_number = 5,
+		.pm_state = enter ? ENTER_PM_STATE : EXIT_PM_STATE,
+		.band_idx = band,
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_EXT_CMD(PM_STATE_CTRL), &req,
+				 sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_pm);
+
+int mt76_connac_mcu_restart(struct mt76_dev *dev)
+{
+	struct {
+		u8 power_mode;
+		u8 rsv[3];
+	} req = {
+		.power_mode = 1,
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_CMD(NIC_POWER_CTRL), &req,
+				 sizeof(req), false);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_restart);
+
+int mt76_connac_mcu_del_wtbl_all(struct mt76_dev *dev)
+{
+	struct wtbl_req_hdr req = {
+		.operation = WTBL_RESET_ALL,
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_EXT_CMD(WTBL_UPDATE),
+				 &req, sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_del_wtbl_all);
+
+int mt76_connac_mcu_rdd_cmd(struct mt76_dev *dev, int cmd, u8 index,
+			    u8 rx_sel, u8 val)
+{
+	struct {
+		u8 ctrl;
+		u8 rdd_idx;
+		u8 rdd_rx_sel;
+		u8 val;
+		u8 rsv[4];
+	} __packed req = {
+		.ctrl = cmd,
+		.rdd_idx = index,
+		.rdd_rx_sel = rx_sel,
+		.val = val,
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_EXT_CMD(SET_RDD_CTRL), &req,
+				 sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_rdd_cmd);
+
+static int
+mt76_connac_mcu_send_ram_firmware(struct mt76_dev *dev,
+				  const struct mt76_connac2_fw_trailer *hdr,
+				  const u8 *data, bool is_wa)
+{
+	int i, offset = 0, max_len = mt76_is_sdio(dev) ? 2048 : 4096;
+	u32 override = 0, option = 0;
+
+	for (i = 0; i < hdr->n_region; i++) {
+		const struct mt76_connac2_fw_region *region;
+		u32 len, addr, mode;
+		int err;
+
+		region = (const void *)((const u8 *)hdr -
+					(hdr->n_region - i) * sizeof(*region));
+		mode = mt76_connac_mcu_gen_dl_mode(dev, region->feature_set,
+						   is_wa);
+		len = le32_to_cpu(region->len);
+		addr = le32_to_cpu(region->addr);
+
+		if (region->feature_set & FW_FEATURE_NON_DL)
+			goto next;
+
+		if (region->feature_set & FW_FEATURE_OVERRIDE_ADDR)
+			override = addr;
+
+		err = mt76_connac_mcu_init_download(dev, addr, len, mode);
+		if (err) {
+			dev_err(dev->dev, "Download request failed\n");
+			return err;
+		}
+
+		err = __mt76_mcu_send_firmware(dev, MCU_CMD(FW_SCATTER),
+					       data + offset, len, max_len);
+		if (err) {
+			dev_err(dev->dev, "Failed to send firmware.\n");
+			return err;
+		}
+
+next:
+		offset += len;
+	}
+
+	if (override)
+		option |= FW_START_OVERRIDE;
+	if (is_wa)
+		option |= FW_START_WORKING_PDA_CR4;
+
+	return mt76_connac_mcu_start_firmware(dev, override, option);
+}
+
+int mt76_connac2_load_ram(struct mt76_dev *dev, const char *fw_wm,
+			  const char *fw_wa)
+{
+	const struct mt76_connac2_fw_trailer *hdr;
+	const struct firmware *fw;
+	int ret;
+
+	ret = request_firmware(&fw, fw_wm, dev->dev);
+	if (ret)
+		return ret;
+
+	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
+		dev_err(dev->dev, "Invalid firmware\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hdr = (const void *)(fw->data + fw->size - sizeof(*hdr));
+	dev_info(dev->dev, "WM Firmware Version: %.10s, Build Time: %.15s\n",
+		 hdr->fw_ver, hdr->build_date);
+
+	ret = mt76_connac_mcu_send_ram_firmware(dev, hdr, fw->data, false);
+	if (ret) {
+		dev_err(dev->dev, "Failed to start WM firmware\n");
+		goto out;
+	}
+
+	snprintf(dev->hw->wiphy->fw_version,
+		 sizeof(dev->hw->wiphy->fw_version),
+		 "%.10s-%.15s", hdr->fw_ver, hdr->build_date);
+
+	release_firmware(fw);
+
+	if (!fw_wa)
+		return 0;
+
+	ret = request_firmware(&fw, fw_wa, dev->dev);
+	if (ret)
+		return ret;
+
+	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
+		dev_err(dev->dev, "Invalid firmware\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hdr = (const void *)(fw->data + fw->size - sizeof(*hdr));
+	dev_info(dev->dev, "WA Firmware Version: %.10s, Build Time: %.15s\n",
+		 hdr->fw_ver, hdr->build_date);
+
+	ret = mt76_connac_mcu_send_ram_firmware(dev, hdr, fw->data, true);
+	if (ret) {
+		dev_err(dev->dev, "Failed to start WA firmware\n");
+		goto out;
+	}
+
+	snprintf(dev->hw->wiphy->fw_version,
+		 sizeof(dev->hw->wiphy->fw_version),
+		 "%.10s-%.15s", hdr->fw_ver, hdr->build_date);
+
+out:
+	release_firmware(fw);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_load_ram);
+
+static u32 mt76_connac2_get_data_mode(struct mt76_dev *dev, u32 info)
+{
+	u32 mode = DL_MODE_NEED_RSP;
+
+	if ((!is_mt7921(dev) && !is_mt7925(dev)) || info == PATCH_SEC_NOT_SUPPORT)
+		return mode;
+
+	switch (FIELD_GET(PATCH_SEC_ENC_TYPE_MASK, info)) {
+	case PATCH_SEC_ENC_TYPE_PLAIN:
+		break;
+	case PATCH_SEC_ENC_TYPE_AES:
+		mode |= DL_MODE_ENCRYPT;
+		mode |= FIELD_PREP(DL_MODE_KEY_IDX,
+				(info & PATCH_SEC_ENC_AES_KEY_MASK)) & DL_MODE_KEY_IDX;
+		mode |= DL_MODE_RESET_SEC_IV;
+		break;
+	case PATCH_SEC_ENC_TYPE_SCRAMBLE:
+		mode |= DL_MODE_ENCRYPT;
+		mode |= DL_CONFIG_ENCRY_MODE_SEL;
+		mode |= DL_MODE_RESET_SEC_IV;
+		break;
+	default:
+		dev_err(dev->dev, "Encryption type not support!\n");
+	}
+
+	return mode;
+}
+
+int mt76_connac2_load_patch(struct mt76_dev *dev, const char *fw_name)
+{
+	int i, ret, sem, max_len = mt76_is_sdio(dev) ? 2048 : 4096;
+	const struct mt76_connac2_patch_hdr *hdr;
+	const struct firmware *fw = NULL;
+
+	sem = mt76_connac_mcu_patch_sem_ctrl(dev, true);
+	switch (sem) {
+	case PATCH_IS_DL:
+		return 0;
+	case PATCH_NOT_DL_SEM_SUCCESS:
+		break;
+	default:
+		dev_err(dev->dev, "Failed to get patch semaphore\n");
+		return -EAGAIN;
+	}
+
+	ret = request_firmware(&fw, fw_name, dev->dev);
+	if (ret)
+		goto out;
+
+	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
+		dev_err(dev->dev, "Invalid firmware\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hdr = (const void *)fw->data;
+	dev_info(dev->dev, "HW/SW Version: 0x%x, Build Time: %.16s\n",
+		 be32_to_cpu(hdr->hw_sw_ver), hdr->build_date);
+
+	for (i = 0; i < be32_to_cpu(hdr->desc.n_region); i++) {
+		struct mt76_connac2_patch_sec *sec;
+		u32 len, addr, mode;
+		const u8 *dl;
+		u32 sec_info;
+
+		sec = (void *)(fw->data + sizeof(*hdr) + i * sizeof(*sec));
+		if ((be32_to_cpu(sec->type) & PATCH_SEC_TYPE_MASK) !=
+		    PATCH_SEC_TYPE_INFO) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		addr = be32_to_cpu(sec->info.addr);
+		len = be32_to_cpu(sec->info.len);
+		dl = fw->data + be32_to_cpu(sec->offs);
+		sec_info = be32_to_cpu(sec->info.sec_key_idx);
+		mode = mt76_connac2_get_data_mode(dev, sec_info);
+
+		ret = mt76_connac_mcu_init_download(dev, addr, len, mode);
+		if (ret) {
+			dev_err(dev->dev, "Download request failed\n");
+			goto out;
+		}
+
+		ret = __mt76_mcu_send_firmware(dev, MCU_CMD(FW_SCATTER),
+					       dl, len, max_len);
+		if (ret) {
+			dev_err(dev->dev, "Failed to send patch\n");
+			goto out;
+		}
+	}
+
+	ret = mt76_connac_mcu_start_patch(dev);
+	if (ret)
+		dev_err(dev->dev, "Failed to start patch\n");
+
+out:
+	sem = mt76_connac_mcu_patch_sem_ctrl(dev, false);
+	switch (sem) {
+	case PATCH_REL_SEM_SUCCESS:
+		break;
+	default:
+		ret = -EAGAIN;
+		dev_err(dev->dev, "Failed to release patch semaphore\n");
+		break;
+	}
+
+	release_firmware(fw);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_load_patch);
+
+int mt76_connac2_mcu_fill_message(struct mt76_dev *dev, struct sk_buff *skb,
+				  int cmd, int *wait_seq)
+{
+	int txd_len, mcu_cmd = FIELD_GET(__MCU_CMD_FIELD_ID, cmd);
+	struct mt76_connac2_mcu_uni_txd *uni_txd;
+	struct mt76_connac2_mcu_txd *mcu_txd;
+	__le32 *txd;
+	u32 val;
+	u8 seq;
+
+	/* TODO: make dynamic based on msg type */
+	dev->mcu.timeout = 20 * HZ;
+
+	seq = ++dev->mcu.msg_seq & 0xf;
+	if (!seq)
+		seq = ++dev->mcu.msg_seq & 0xf;
+
+	if (cmd == MCU_CMD(FW_SCATTER))
+		goto exit;
+
+	txd_len = cmd & __MCU_CMD_FIELD_UNI ? sizeof(*uni_txd) : sizeof(*mcu_txd);
+	txd = (__le32 *)skb_push(skb, txd_len);
+
+	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len) |
+	      FIELD_PREP(MT_TXD0_PKT_FMT, MT_TX_TYPE_CMD) |
+	      FIELD_PREP(MT_TXD0_Q_IDX, MT_TX_MCU_PORT_RX_Q0);
+	txd[0] = cpu_to_le32(val);
+
+	val = MT_TXD1_LONG_FORMAT |
+	      FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_CMD);
+	txd[1] = cpu_to_le32(val);
+
+	if (cmd & __MCU_CMD_FIELD_UNI) {
+		uni_txd = (struct mt76_connac2_mcu_uni_txd *)txd;
+		uni_txd->len = cpu_to_le16(skb->len - sizeof(uni_txd->txd));
+		uni_txd->option = MCU_CMD_UNI_EXT_ACK;
+		uni_txd->cid = cpu_to_le16(mcu_cmd);
+		uni_txd->s2d_index = MCU_S2D_H2N;
+		uni_txd->pkt_type = MCU_PKT_ID;
+		uni_txd->seq = seq;
+
+		goto exit;
+	}
+
+	mcu_txd = (struct mt76_connac2_mcu_txd *)txd;
+	mcu_txd->len = cpu_to_le16(skb->len - sizeof(mcu_txd->txd));
+	mcu_txd->pq_id = cpu_to_le16(MCU_PQ_ID(MT_TX_PORT_IDX_MCU,
+					       MT_TX_MCU_PORT_RX_Q0));
+	mcu_txd->pkt_type = MCU_PKT_ID;
+	mcu_txd->seq = seq;
+	mcu_txd->cid = mcu_cmd;
+	mcu_txd->ext_cid = FIELD_GET(__MCU_CMD_FIELD_EXT_ID, cmd);
+
+	if (mcu_txd->ext_cid || (cmd & __MCU_CMD_FIELD_CE)) {
+		if (cmd & __MCU_CMD_FIELD_QUERY)
+			mcu_txd->set_query = MCU_Q_QUERY;
+		else
+			mcu_txd->set_query = MCU_Q_SET;
+		mcu_txd->ext_cid_ack = !!mcu_txd->ext_cid;
+	} else {
+		mcu_txd->set_query = MCU_Q_NA;
+	}
+
+	if (cmd & __MCU_CMD_FIELD_WA)
+		mcu_txd->s2d_index = MCU_S2D_H2C;
+	else
+		mcu_txd->s2d_index = MCU_S2D_H2N;
+
+exit:
+	if (wait_seq)
+		*wait_seq = seq;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_mcu_fill_message);
+
+MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
+MODULE_DESCRIPTION("MediaTek MT76x connac layer helpers");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c.orig b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c.orig
new file mode 100644
index 000000000000..d1f10f6d9adc
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c.orig
@@ -0,0 +1,314 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#include "mt7921.h"
+#include "../dma.h"
+#include "mac.h"
+
+static int mt7921_poll_tx(struct napi_struct *napi, int budget)
+{
+	struct mt7921_dev *dev;
+
+	dev = container_of(napi, struct mt7921_dev, mt76.tx_napi);
+
+	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm)) {
+		napi_complete(napi);
+		queue_work(dev->mt76.wq, &dev->pm.wake_work);
+		return 0;
+	}
+
+	mt76_connac_tx_cleanup(&dev->mt76);
+	if (napi_complete(napi))
+		mt7921_irq_enable(dev, MT_INT_TX_DONE_ALL);
+	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
+
+	return 0;
+}
+
+static int mt7921_poll_rx(struct napi_struct *napi, int budget)
+{
+	struct mt7921_dev *dev;
+	int done;
+
+	dev = container_of(napi->dev, struct mt7921_dev, mt76.napi_dev);
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
+
+static void mt7921_dma_prefetch(struct mt7921_dev *dev)
+{
+#define PREFETCH(base, depth)	((base) << 16 | (depth))
+
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
+static int mt7921_dma_disable(struct mt7921_dev *dev, bool force)
+{
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
+	/* disable dmashdl */
+	mt76_clear(dev, MT_WFDMA0_GLO_CFG_EXT0,
+		   MT_WFDMA0_CSR_TX_DMASHDL_ENABLE);
+	mt76_set(dev, MT_DMASHDL_SW_CONTROL, MT_DMASHDL_DMASHDL_BYPASS);
+
+	/* disable WFDMA0 */
+	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
+		   MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN |
+		   MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN |
+		   MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO |
+		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
+
+	if (!mt76_poll(dev, MT_WFDMA0_GLO_CFG,
+		       MT_WFDMA0_GLO_CFG_TX_DMA_BUSY |
+		       MT_WFDMA0_GLO_CFG_RX_DMA_BUSY, 0, 1000))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int mt7921_dma_enable(struct mt7921_dev *dev)
+{
+	/* configure perfetch settings */
+	mt7921_dma_prefetch(dev);
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
+	mt7921_irq_enable(dev,
+			  MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
+			  MT_INT_MCU_CMD);
+	mt76_set(dev, MT_MCU2HOST_SW_INT_ENA, MT_MCU_CMD_WAKE_RX_PCIE);
+
+	return 0;
+}
+
+static int mt7921_dma_reset(struct mt7921_dev *dev, bool force)
+{
+	int i, err;
+
+	err = mt7921_dma_disable(dev, force);
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
+	return mt7921_dma_enable(dev);
+}
+
+int mt7921_wfsys_reset(struct mt7921_dev *dev)
+{
+	mt76_clear(dev, MT_WFSYS_SW_RST_B, WFSYS_SW_RST_B);
+	msleep(50);
+	mt76_set(dev, MT_WFSYS_SW_RST_B, WFSYS_SW_RST_B);
+
+	if (!__mt76_poll_msec(&dev->mt76, MT_WFSYS_SW_RST_B,
+			      WFSYS_SW_INIT_DONE, WFSYS_SW_INIT_DONE, 500))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+int mt7921_wpdma_reset(struct mt7921_dev *dev, bool force)
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
+		err = mt7921_wfsys_reset(dev);
+		if (err)
+			return err;
+	}
+	err = mt7921_dma_reset(dev, force);
+	if (err)
+		return err;
+
+	mt76_for_each_q_rx(&dev->mt76, i)
+		mt76_queue_rx_reset(dev, i);
+
+	return 0;
+}
+
+int mt7921_wpdma_reinit_cond(struct mt7921_dev *dev)
+{
+	struct mt76_connac_pm *pm = &dev->pm;
+	int err;
+
+	/* check if the wpdma must be reinitialized */
+	if (mt7921_dma_need_reinit(dev)) {
+		/* disable interrutpts */
+		mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
+		mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
+
+		err = mt7921_wpdma_reset(dev, false);
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
+
+int mt7921_dma_init(struct mt7921_dev *dev)
+{
+	int ret;
+
+	mt76_dma_attach(&dev->mt76);
+
+	ret = mt7921_dma_disable(dev, true);
+	if (ret)
+		return ret;
+
+	ret = mt7921_wfsys_reset(dev);
+	if (ret)
+		return ret;
+
+	/* init tx queue */
+	ret = mt76_connac_init_tx_queues(dev->phy.mt76, MT7921_TXQ_BAND0,
+					 MT7921_TX_RING_SIZE,
+					 MT_TX_RING_BASE, 0);
+	if (ret)
+		return ret;
+
+	mt76_wr(dev, MT_WFDMA0_TX_RING0_EXT_CTRL, 0x4);
+
+	/* command to WM */
+	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_WM, MT7921_TXQ_MCU_WM,
+				  MT7921_TX_MCU_RING_SIZE, MT_TX_RING_BASE);
+	if (ret)
+		return ret;
+
+	/* firmware download */
+	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_FWDL, MT7921_TXQ_FWDL,
+				  MT7921_TX_FWDL_RING_SIZE, MT_TX_RING_BASE);
+	if (ret)
+		return ret;
+
+	/* event from WM before firmware download */
+	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU],
+			       MT7921_RXQ_MCU_WM,
+			       MT7921_RX_MCU_RING_SIZE,
+			       MT_RX_BUF_SIZE, MT_RX_EVENT_RING_BASE);
+	if (ret)
+		return ret;
+
+	/* Change mcu queue after firmware download */
+	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU_WA],
+			       MT7921_RXQ_MCU_WM,
+			       MT7921_RX_MCU_RING_SIZE,
+			       MT_RX_BUF_SIZE, MT_WFDMA0(0x540));
+	if (ret)
+		return ret;
+
+	/* rx data */
+	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN],
+			       MT7921_RXQ_BAND0, MT7921_RX_RING_SIZE,
+			       MT_RX_BUF_SIZE, MT_RX_DATA_RING_BASE);
+	if (ret)
+		return ret;
+
+	ret = mt76_init_queues(dev, mt7921_poll_rx);
+	if (ret < 0)
+		return ret;
+
+	netif_napi_add_tx(&dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
+			  mt7921_poll_tx);
+	napi_enable(&dev->mt76.tx_napi);
+
+	return mt7921_dma_enable(dev);
+}
+
+void mt7921_dma_cleanup(struct mt7921_dev *dev)
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
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c.orig b/drivers/net/wireless/mediatek/mt76/mt7921/init.c.orig
new file mode 100644
index 000000000000..79023992715e
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c.orig
@@ -0,0 +1,326 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#include <linux/etherdevice.h>
+#include "mt7921.h"
+#include "mac.h"
+#include "mcu.h"
+#include "eeprom.h"
+
+static const struct ieee80211_iface_limit if_limits[] = {
+	{
+		.max = MT7921_MAX_INTERFACES,
+		.types = BIT(NL80211_IFTYPE_STATION)
+	},
+	{
+		.max = 1,
+		.types = BIT(NL80211_IFTYPE_AP)
+	}
+};
+
+static const struct ieee80211_iface_combination if_comb[] = {
+	{
+		.limits = if_limits,
+		.n_limits = ARRAY_SIZE(if_limits),
+		.max_interfaces = MT7921_MAX_INTERFACES,
+		.num_different_channels = 1,
+		.beacon_int_infra_match = true,
+	}
+};
+
+static void
+mt7921_regd_notifier(struct wiphy *wiphy,
+		     struct regulatory_request *request)
+{
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+
+	memcpy(dev->mt76.alpha2, request->alpha2, sizeof(dev->mt76.alpha2));
+	dev->mt76.region = request->dfs_region;
+
+	mt7921_mutex_acquire(dev);
+	mt76_connac_mcu_set_channel_domain(hw->priv);
+	mt7921_set_tx_sar_pwr(hw, NULL);
+	mt7921_mutex_release(dev);
+}
+
+static int
+mt7921_init_wiphy(struct ieee80211_hw *hw)
+{
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt7921_dev *dev = phy->dev;
+	struct wiphy *wiphy = hw->wiphy;
+
+	hw->queues = 4;
+	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
+	hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
+	hw->netdev_features = NETIF_F_RXCSUM;
+
+	hw->radiotap_timestamp.units_pos =
+		IEEE80211_RADIOTAP_TIMESTAMP_UNIT_US;
+
+	phy->slottime = 9;
+
+	hw->sta_data_size = sizeof(struct mt7921_sta);
+	hw->vif_data_size = sizeof(struct mt7921_vif);
+
+	wiphy->iface_combinations = if_comb;
+	wiphy->flags &= ~(WIPHY_FLAG_IBSS_RSN | WIPHY_FLAG_4ADDR_AP |
+			  WIPHY_FLAG_4ADDR_STATION);
+	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
+				 BIT(NL80211_IFTYPE_AP);
+	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
+	wiphy->max_scan_ie_len = MT76_CONNAC_SCAN_IE_LEN;
+	wiphy->max_scan_ssids = 4;
+	wiphy->max_sched_scan_plan_interval =
+		MT76_CONNAC_MAX_TIME_SCHED_SCAN_INTERVAL;
+	wiphy->max_sched_scan_ie_len = IEEE80211_MAX_DATA_LEN;
+	wiphy->max_sched_scan_ssids = MT76_CONNAC_MAX_SCHED_SCAN_SSID;
+	wiphy->max_match_sets = MT76_CONNAC_MAX_SCAN_MATCH;
+	wiphy->max_sched_scan_reqs = 1;
+	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
+	wiphy->reg_notifier = mt7921_regd_notifier;
+
+	wiphy->features |= NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR |
+			   NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_SET_SCAN_DWELL);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_LEGACY);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_HT);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_VHT);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_HE);
+
+	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
+	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
+	ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
+	ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
+	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
+	ieee80211_hw_set(hw, SUPPORTS_PS);
+	ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
+	ieee80211_hw_set(hw, SUPPORTS_VHT_EXT_NSS_BW);
+
+	if (dev->pm.enable)
+		ieee80211_hw_set(hw, CONNECTION_MONITOR);
+
+	hw->max_tx_fragments = 4;
+
+	return 0;
+}
+
+static void
+mt7921_mac_init_band(struct mt7921_dev *dev, u8 band)
+{
+	mt76_rmw_field(dev, MT_TMAC_CTCR0(band),
+		       MT_TMAC_CTCR0_INS_DDLMT_REFTIME, 0x3f);
+	mt76_set(dev, MT_TMAC_CTCR0(band),
+		 MT_TMAC_CTCR0_INS_DDLMT_VHT_SMPDU_EN |
+		 MT_TMAC_CTCR0_INS_DDLMT_EN);
+
+	mt76_set(dev, MT_WF_RMAC_MIB_TIME0(band), MT_WF_RMAC_MIB_RXTIME_EN);
+	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0(band), MT_WF_RMAC_MIB_RXTIME_EN);
+
+	/* enable MIB tx-rx time reporting */
+	mt76_set(dev, MT_MIB_SCR1(band), MT_MIB_TXDUR_EN);
+	mt76_set(dev, MT_MIB_SCR1(band), MT_MIB_RXDUR_EN);
+
+	mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_MAX_RX_LEN, 1536);
+	/* disable rx rate report by default due to hw issues */
+	mt76_clear(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN);
+}
+
+int mt7921_mac_init(struct mt7921_dev *dev)
+{
+	int i;
+
+	mt76_rmw_field(dev, MT_MDP_DCR1, MT_MDP_DCR1_MAX_RX_LEN, 1536);
+	/* enable hardware de-agg */
+	mt76_set(dev, MT_MDP_DCR0, MT_MDP_DCR0_DAMSDU_EN);
+	/* enable hardware rx header translation */
+	mt76_set(dev, MT_MDP_DCR0, MT_MDP_DCR0_RX_HDR_TRANS_EN);
+
+	for (i = 0; i < MT7921_WTBL_SIZE; i++)
+		mt7921_mac_wtbl_update(dev, i,
+				       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+	for (i = 0; i < 2; i++)
+		mt7921_mac_init_band(dev, i);
+
+	dev->mt76.rxfilter = mt76_rr(dev, MT_WF_RFCR(0));
+
+	return mt76_connac_mcu_set_rts_thresh(&dev->mt76, 0x92b, 0);
+}
+EXPORT_SYMBOL_GPL(mt7921_mac_init);
+
+static int __mt7921_init_hardware(struct mt7921_dev *dev)
+{
+	int ret;
+
+	/* force firmware operation mode into normal state,
+	 * which should be set before firmware download stage.
+	 */
+	mt76_wr(dev, MT_SWDEF_MODE, MT_SWDEF_NORMAL_MODE);
+	ret = mt7921_mcu_init(dev);
+	if (ret)
+		goto out;
+
+	mt76_eeprom_override(&dev->mphy);
+
+	ret = mt7921_mcu_set_eeprom(dev);
+	if (ret)
+		goto out;
+
+	ret = mt7921_mac_init(dev);
+out:
+	return ret;
+}
+
+static int mt7921_init_hardware(struct mt7921_dev *dev)
+{
+	int ret, i;
+
+	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
+
+	for (i = 0; i < MT7921_MCU_INIT_RETRY_COUNT; i++) {
+		ret = __mt7921_init_hardware(dev);
+		if (!ret)
+			break;
+
+		mt7921_init_reset(dev);
+	}
+
+	if (i == MT7921_MCU_INIT_RETRY_COUNT) {
+		dev_err(dev->mt76.dev, "hardware init failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int mt7921_init_wcid(struct mt7921_dev *dev)
+{
+	int idx;
+
+	/* Beacon and mgmt frames should occupy wcid 0 */
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7921_WTBL_STA - 1);
+	if (idx)
+		return -ENOSPC;
+
+	dev->mt76.global_wcid.idx = idx;
+	dev->mt76.global_wcid.hw_key_idx = -1;
+	dev->mt76.global_wcid.tx_info |= MT_WCID_TX_INFO_SET;
+	rcu_assign_pointer(dev->mt76.wcid[idx], &dev->mt76.global_wcid);
+
+	return 0;
+}
+
+static void mt7921_init_work(struct work_struct *work)
+{
+	struct mt7921_dev *dev = container_of(work, struct mt7921_dev,
+					      init_work);
+	int ret;
+
+	ret = mt7921_init_hardware(dev);
+	if (ret)
+		return;
+
+	mt76_set_stream_caps(&dev->mphy, true);
+	mt7921_set_stream_he_caps(&dev->phy);
+
+	ret = mt76_register_device(&dev->mt76, true, mt76_rates,
+				   ARRAY_SIZE(mt76_rates));
+	if (ret) {
+		dev_err(dev->mt76.dev, "register device failed\n");
+		return;
+	}
+
+	ret = mt7921_init_debugfs(dev);
+	if (ret) {
+		dev_err(dev->mt76.dev, "register debugfs failed\n");
+		return;
+	}
+
+	/* we support chip reset now */
+	dev->hw_init_done = true;
+
+	mt76_connac_mcu_set_deep_sleep(&dev->mt76, dev->pm.ds_enable);
+}
+
+int mt7921_register_device(struct mt7921_dev *dev)
+{
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	int ret;
+
+	dev->phy.dev = dev;
+	dev->phy.mt76 = &dev->mt76.phy;
+	dev->mt76.phy.priv = &dev->phy;
+	dev->mt76.tx_worker.fn = mt7921_tx_worker;
+
+	INIT_DELAYED_WORK(&dev->pm.ps_work, mt7921_pm_power_save_work);
+	INIT_WORK(&dev->pm.wake_work, mt7921_pm_wake_work);
+	spin_lock_init(&dev->pm.wake.lock);
+	mutex_init(&dev->pm.mutex);
+	init_waitqueue_head(&dev->pm.wait);
+	if (mt76_is_sdio(&dev->mt76))
+		init_waitqueue_head(&dev->mt76.sdio.wait);
+	spin_lock_init(&dev->pm.txq_lock);
+	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt7921_mac_work);
+	INIT_DELAYED_WORK(&dev->phy.scan_work, mt7921_scan_work);
+	INIT_DELAYED_WORK(&dev->coredump.work, mt7921_coredump_work);
+#if IS_ENABLED(CONFIG_IPV6)
+	INIT_WORK(&dev->ipv6_ns_work, mt7921_set_ipv6_ns_work);
+	skb_queue_head_init(&dev->ipv6_ns_list);
+#endif
+	skb_queue_head_init(&dev->phy.scan_event_list);
+	skb_queue_head_init(&dev->coredump.msg_list);
+	INIT_LIST_HEAD(&dev->sta_poll_list);
+	spin_lock_init(&dev->sta_poll_lock);
+
+	INIT_WORK(&dev->reset_work, mt7921_mac_reset_work);
+	INIT_WORK(&dev->init_work, mt7921_init_work);
+
+	dev->pm.idle_timeout = MT7921_PM_TIMEOUT;
+	dev->pm.stats.last_wake_event = jiffies;
+	dev->pm.stats.last_doze_event = jiffies;
+	if (!mt76_is_usb(&dev->mt76)) {
+		dev->pm.enable_user = true;
+		dev->pm.enable = true;
+		dev->pm.ds_enable_user = true;
+		dev->pm.ds_enable = true;
+	}
+
+	if (!mt76_is_mmio(&dev->mt76))
+		hw->extra_tx_headroom += MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE;
+
+	mt7921_init_acpi_sar(dev);
+
+	ret = mt7921_init_wcid(dev);
+	if (ret)
+		return ret;
+
+	ret = mt7921_init_wiphy(hw);
+	if (ret)
+		return ret;
+
+	dev->mphy.sband_2g.sband.ht_cap.cap |=
+			IEEE80211_HT_CAP_LDPC_CODING |
+			IEEE80211_HT_CAP_MAX_AMSDU;
+	dev->mphy.sband_5g.sband.ht_cap.cap |=
+			IEEE80211_HT_CAP_LDPC_CODING |
+			IEEE80211_HT_CAP_MAX_AMSDU;
+	dev->mphy.sband_5g.sband.vht_cap.cap |=
+			IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991 |
+			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK |
+			IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
+			IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE |
+			(3 << IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT);
+	if (is_mt7922(&dev->mt76))
+		dev->mphy.sband_5g.sband.vht_cap.cap |=
+			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ |
+			IEEE80211_VHT_CAP_SHORT_GI_160;
+
+	dev->mphy.hw->wiphy->available_antennas_rx = dev->mphy.chainmask;
+	dev->mphy.hw->wiphy->available_antennas_tx = dev->mphy.chainmask;
+
+	queue_work(system_wq, &dev->init_work);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt7921_register_device);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c.orig b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c.orig
new file mode 100644
index 000000000000..5d3eede4e200
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c.orig
@@ -0,0 +1,1121 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#include <linux/devcoredump.h>
+#include <linux/etherdevice.h>
+#include <linux/timekeeping.h>
+#include "mt7921.h"
+#include "../dma.h"
+#include "mac.h"
+#include "mcu.h"
+
+static struct mt76_wcid *mt7921_rx_get_wcid(struct mt7921_dev *dev,
+					    u16 idx, bool unicast)
+{
+	struct mt7921_sta *sta;
+	struct mt76_wcid *wcid;
+
+	if (idx >= ARRAY_SIZE(dev->mt76.wcid))
+		return NULL;
+
+	wcid = rcu_dereference(dev->mt76.wcid[idx]);
+	if (unicast || !wcid)
+		return wcid;
+
+	if (!wcid->sta)
+		return NULL;
+
+	sta = container_of(wcid, struct mt7921_sta, wcid);
+	if (!sta->vif)
+		return NULL;
+
+	return &sta->vif->sta.wcid;
+}
+
+void mt7921_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps)
+{
+}
+EXPORT_SYMBOL_GPL(mt7921_sta_ps);
+
+bool mt7921_mac_wtbl_update(struct mt7921_dev *dev, int idx, u32 mask)
+{
+	mt76_rmw(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_WLAN_IDX,
+		 FIELD_PREP(MT_WTBL_UPDATE_WLAN_IDX, idx) | mask);
+
+	return mt76_poll(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_BUSY,
+			 0, 5000);
+}
+
+void mt7921_mac_sta_poll(struct mt7921_dev *dev)
+{
+	static const u8 ac_to_tid[] = {
+		[IEEE80211_AC_BE] = 0,
+		[IEEE80211_AC_BK] = 1,
+		[IEEE80211_AC_VI] = 4,
+		[IEEE80211_AC_VO] = 6
+	};
+	struct ieee80211_sta *sta;
+	struct mt7921_sta *msta;
+	u32 tx_time[IEEE80211_NUM_ACS], rx_time[IEEE80211_NUM_ACS];
+	LIST_HEAD(sta_poll_list);
+	struct rate_info *rate;
+	int i;
+
+	spin_lock_bh(&dev->sta_poll_lock);
+	list_splice_init(&dev->sta_poll_list, &sta_poll_list);
+	spin_unlock_bh(&dev->sta_poll_lock);
+
+	while (true) {
+		bool clear = false;
+		u32 addr, val;
+		u16 idx;
+		u8 bw;
+
+		spin_lock_bh(&dev->sta_poll_lock);
+		if (list_empty(&sta_poll_list)) {
+			spin_unlock_bh(&dev->sta_poll_lock);
+			break;
+		}
+		msta = list_first_entry(&sta_poll_list,
+					struct mt7921_sta, poll_list);
+		list_del_init(&msta->poll_list);
+		spin_unlock_bh(&dev->sta_poll_lock);
+
+		idx = msta->wcid.idx;
+		addr = mt7921_mac_wtbl_lmac_addr(idx, MT_WTBL_AC0_CTT_OFFSET);
+
+		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+			u32 tx_last = msta->airtime_ac[i];
+			u32 rx_last = msta->airtime_ac[i + 4];
+
+			msta->airtime_ac[i] = mt76_rr(dev, addr);
+			msta->airtime_ac[i + 4] = mt76_rr(dev, addr + 4);
+
+			tx_time[i] = msta->airtime_ac[i] - tx_last;
+			rx_time[i] = msta->airtime_ac[i + 4] - rx_last;
+
+			if ((tx_last | rx_last) & BIT(30))
+				clear = true;
+
+			addr += 8;
+		}
+
+		if (clear) {
+			mt7921_mac_wtbl_update(dev, idx,
+					       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+			memset(msta->airtime_ac, 0, sizeof(msta->airtime_ac));
+		}
+
+		if (!msta->wcid.sta)
+			continue;
+
+		sta = container_of((void *)msta, struct ieee80211_sta,
+				   drv_priv);
+		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+			u8 q = mt76_connac_lmac_mapping(i);
+			u32 tx_cur = tx_time[q];
+			u32 rx_cur = rx_time[q];
+			u8 tid = ac_to_tid[i];
+
+			if (!tx_cur && !rx_cur)
+				continue;
+
+			ieee80211_sta_register_airtime(sta, tid, tx_cur,
+						       rx_cur);
+		}
+
+		/* We don't support reading GI info from txs packets.
+		 * For accurate tx status reporting and AQL improvement,
+		 * we need to make sure that flags match so polling GI
+		 * from per-sta counters directly.
+		 */
+		rate = &msta->wcid.rate;
+		addr = mt7921_mac_wtbl_lmac_addr(idx,
+						 MT_WTBL_TXRX_CAP_RATE_OFFSET);
+		val = mt76_rr(dev, addr);
+
+		switch (rate->bw) {
+		case RATE_INFO_BW_160:
+			bw = IEEE80211_STA_RX_BW_160;
+			break;
+		case RATE_INFO_BW_80:
+			bw = IEEE80211_STA_RX_BW_80;
+			break;
+		case RATE_INFO_BW_40:
+			bw = IEEE80211_STA_RX_BW_40;
+			break;
+		default:
+			bw = IEEE80211_STA_RX_BW_20;
+			break;
+		}
+
+		if (rate->flags & RATE_INFO_FLAGS_HE_MCS) {
+			u8 offs = MT_WTBL_TXRX_RATE_G2_HE + 2 * bw;
+
+			rate->he_gi = (val & (0x3 << offs)) >> offs;
+		} else if (rate->flags &
+			   (RATE_INFO_FLAGS_VHT_MCS | RATE_INFO_FLAGS_MCS)) {
+			if (val & BIT(MT_WTBL_TXRX_RATE_G2 + bw))
+				rate->flags |= RATE_INFO_FLAGS_SHORT_GI;
+			else
+				rate->flags &= ~RATE_INFO_FLAGS_SHORT_GI;
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(mt7921_mac_sta_poll);
+
+static void
+mt7921_get_status_freq_info(struct mt7921_dev *dev, struct mt76_phy *mphy,
+			    struct mt76_rx_status *status, u8 chfreq)
+{
+	if (!test_bit(MT76_HW_SCANNING, &mphy->state) &&
+	    !test_bit(MT76_HW_SCHED_SCANNING, &mphy->state) &&
+	    !test_bit(MT76_STATE_ROC, &mphy->state)) {
+		status->freq = mphy->chandef.chan->center_freq;
+		status->band = mphy->chandef.chan->band;
+		return;
+	}
+
+	if (chfreq > 180) {
+		status->band = NL80211_BAND_6GHZ;
+		chfreq = (chfreq - 181) * 4 + 1;
+	} else if (chfreq > 14) {
+		status->band = NL80211_BAND_5GHZ;
+	} else {
+		status->band = NL80211_BAND_2GHZ;
+	}
+	status->freq = ieee80211_channel_to_frequency(chfreq, status->band);
+}
+
+static void
+mt7921_mac_rssi_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct sk_buff *skb = priv;
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct ieee80211_hdr *hdr = mt76_skb_get_hdr(skb);
+
+	if (status->signal > 0)
+		return;
+
+	if (!ether_addr_equal(vif->addr, hdr->addr1))
+		return;
+
+	ewma_rssi_add(&mvif->rssi, -status->signal);
+}
+
+static void
+mt7921_mac_assoc_rssi(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct ieee80211_hdr *hdr = mt76_skb_get_hdr(skb);
+
+	if (!ieee80211_is_assoc_resp(hdr->frame_control) &&
+	    !ieee80211_is_auth(hdr->frame_control))
+		return;
+
+	ieee80211_iterate_active_interfaces_atomic(mt76_hw(dev),
+		IEEE80211_IFACE_ITER_RESUME_ALL,
+		mt7921_mac_rssi_iter, skb);
+}
+
+static int
+mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	u32 csum_mask = MT_RXD0_NORMAL_IP_SUM | MT_RXD0_NORMAL_UDP_TCP_SUM;
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	bool hdr_trans, unicast, insert_ccmp_hdr = false;
+	u8 chfreq, qos_ctl = 0, remove_pad, amsdu_info;
+	u16 hdr_gap;
+	__le32 *rxv = NULL, *rxd = (__le32 *)skb->data;
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt7921_phy *phy = &dev->phy;
+	struct ieee80211_supported_band *sband;
+	u32 rxd0 = le32_to_cpu(rxd[0]);
+	u32 rxd1 = le32_to_cpu(rxd[1]);
+	u32 rxd2 = le32_to_cpu(rxd[2]);
+	u32 rxd3 = le32_to_cpu(rxd[3]);
+	u32 rxd4 = le32_to_cpu(rxd[4]);
+	struct mt7921_sta *msta;
+	u16 seq_ctrl = 0;
+	__le16 fc = 0;
+	u8 mode = 0;
+	int i, idx;
+
+	memset(status, 0, sizeof(*status));
+
+	if (rxd1 & MT_RXD1_NORMAL_BAND_IDX)
+		return -EINVAL;
+
+	if (!test_bit(MT76_STATE_RUNNING, &mphy->state))
+		return -EINVAL;
+
+	if (rxd2 & MT_RXD2_NORMAL_AMSDU_ERR)
+		return -EINVAL;
+
+	hdr_trans = rxd2 & MT_RXD2_NORMAL_HDR_TRANS;
+	if (hdr_trans && (rxd1 & MT_RXD1_NORMAL_CM))
+		return -EINVAL;
+
+	/* ICV error or CCMP/BIP/WPI MIC error */
+	if (rxd1 & MT_RXD1_NORMAL_ICV_ERR)
+		status->flag |= RX_FLAG_ONLY_MONITOR;
+
+	chfreq = FIELD_GET(MT_RXD3_NORMAL_CH_FREQ, rxd3);
+	unicast = FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, rxd3) == MT_RXD3_NORMAL_U2M;
+	idx = FIELD_GET(MT_RXD1_NORMAL_WLAN_IDX, rxd1);
+	status->wcid = mt7921_rx_get_wcid(dev, idx, unicast);
+
+	if (status->wcid) {
+		msta = container_of(status->wcid, struct mt7921_sta, wcid);
+		spin_lock_bh(&dev->sta_poll_lock);
+		if (list_empty(&msta->poll_list))
+			list_add_tail(&msta->poll_list, &dev->sta_poll_list);
+		spin_unlock_bh(&dev->sta_poll_lock);
+	}
+
+	mt7921_get_status_freq_info(dev, mphy, status, chfreq);
+
+	switch (status->band) {
+	case NL80211_BAND_5GHZ:
+		sband = &mphy->sband_5g.sband;
+		break;
+	case NL80211_BAND_6GHZ:
+		sband = &mphy->sband_6g.sband;
+		break;
+	default:
+		sband = &mphy->sband_2g.sband;
+		break;
+	}
+
+	if (!sband->channels)
+		return -EINVAL;
+
+	if ((rxd0 & csum_mask) == csum_mask)
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	if (rxd1 & MT_RXD1_NORMAL_FCS_ERR)
+		status->flag |= RX_FLAG_FAILED_FCS_CRC;
+
+	if (rxd1 & MT_RXD1_NORMAL_TKIP_MIC_ERR)
+		status->flag |= RX_FLAG_MMIC_ERROR;
+
+	if (FIELD_GET(MT_RXD1_NORMAL_SEC_MODE, rxd1) != 0 &&
+	    !(rxd1 & (MT_RXD1_NORMAL_CLM | MT_RXD1_NORMAL_CM))) {
+		status->flag |= RX_FLAG_DECRYPTED;
+		status->flag |= RX_FLAG_IV_STRIPPED;
+		status->flag |= RX_FLAG_MMIC_STRIPPED | RX_FLAG_MIC_STRIPPED;
+	}
+
+	remove_pad = FIELD_GET(MT_RXD2_NORMAL_HDR_OFFSET, rxd2);
+
+	if (rxd2 & MT_RXD2_NORMAL_MAX_LEN_ERROR)
+		return -EINVAL;
+
+	rxd += 6;
+	if (rxd1 & MT_RXD1_NORMAL_GROUP_4) {
+		u32 v0 = le32_to_cpu(rxd[0]);
+		u32 v2 = le32_to_cpu(rxd[2]);
+
+		fc = cpu_to_le16(FIELD_GET(MT_RXD6_FRAME_CONTROL, v0));
+		seq_ctrl = FIELD_GET(MT_RXD8_SEQ_CTRL, v2);
+		qos_ctl = FIELD_GET(MT_RXD8_QOS_CTL, v2);
+
+		rxd += 4;
+		if ((u8 *)rxd - skb->data >= skb->len)
+			return -EINVAL;
+	}
+
+	if (rxd1 & MT_RXD1_NORMAL_GROUP_1) {
+		u8 *data = (u8 *)rxd;
+
+		if (status->flag & RX_FLAG_DECRYPTED) {
+			switch (FIELD_GET(MT_RXD1_NORMAL_SEC_MODE, rxd1)) {
+			case MT_CIPHER_AES_CCMP:
+			case MT_CIPHER_CCMP_CCX:
+			case MT_CIPHER_CCMP_256:
+				insert_ccmp_hdr =
+					FIELD_GET(MT_RXD2_NORMAL_FRAG, rxd2);
+				fallthrough;
+			case MT_CIPHER_TKIP:
+			case MT_CIPHER_TKIP_NO_MIC:
+			case MT_CIPHER_GCMP:
+			case MT_CIPHER_GCMP_256:
+				status->iv[0] = data[5];
+				status->iv[1] = data[4];
+				status->iv[2] = data[3];
+				status->iv[3] = data[2];
+				status->iv[4] = data[1];
+				status->iv[5] = data[0];
+				break;
+			default:
+				break;
+			}
+		}
+		rxd += 4;
+		if ((u8 *)rxd - skb->data >= skb->len)
+			return -EINVAL;
+	}
+
+	if (rxd1 & MT_RXD1_NORMAL_GROUP_2) {
+		status->timestamp = le32_to_cpu(rxd[0]);
+		status->flag |= RX_FLAG_MACTIME_START;
+
+		if (!(rxd2 & MT_RXD2_NORMAL_NON_AMPDU)) {
+			status->flag |= RX_FLAG_AMPDU_DETAILS;
+
+			/* all subframes of an A-MPDU have the same timestamp */
+			if (phy->rx_ampdu_ts != status->timestamp) {
+				if (!++phy->ampdu_ref)
+					phy->ampdu_ref++;
+			}
+			phy->rx_ampdu_ts = status->timestamp;
+
+			status->ampdu_ref = phy->ampdu_ref;
+		}
+
+		rxd += 2;
+		if ((u8 *)rxd - skb->data >= skb->len)
+			return -EINVAL;
+	}
+
+	/* RXD Group 3 - P-RXV */
+	if (rxd1 & MT_RXD1_NORMAL_GROUP_3) {
+		u32 v0, v1;
+		int ret;
+
+		rxv = rxd;
+		rxd += 2;
+		if ((u8 *)rxd - skb->data >= skb->len)
+			return -EINVAL;
+
+		v0 = le32_to_cpu(rxv[0]);
+		v1 = le32_to_cpu(rxv[1]);
+
+		if (v0 & MT_PRXV_HT_AD_CODE)
+			status->enc_flags |= RX_ENC_FLAG_LDPC;
+
+		ret = mt76_connac2_mac_fill_rx_rate(&dev->mt76, status, sband,
+						    rxv, &mode);
+		if (ret < 0)
+			return ret;
+
+		if (rxd1 & MT_RXD1_NORMAL_GROUP_5) {
+			rxd += 6;
+			if ((u8 *)rxd - skb->data >= skb->len)
+				return -EINVAL;
+
+			rxv = rxd;
+			/* Monitor mode would use RCPI described in GROUP 5
+			 * instead.
+			 * */
+			v1 = le32_to_cpu(rxv[0]);
+
+			rxd += 12;
+			if ((u8 *)rxd - skb->data >= skb->len)
+				return -EINVAL;
+		}
+
+		status->chains = mphy->antenna_mask;
+		status->chain_signal[0] = to_rssi(MT_PRXV_RCPI0, v1);
+		status->chain_signal[1] = to_rssi(MT_PRXV_RCPI1, v1);
+		status->chain_signal[2] = to_rssi(MT_PRXV_RCPI2, v1);
+		status->chain_signal[3] = to_rssi(MT_PRXV_RCPI3, v1);
+		status->signal = -128;
+
+		for (i = 0; i < hweight8(mphy->antenna_mask); i++) {
+			if (!(status->chains & BIT(i)) ||
+			    status->chain_signal[i] >= 0)
+				continue;
+
+			status->signal = max(status->signal,
+					     status->chain_signal[i]);
+		}
+	}
+
+	amsdu_info = FIELD_GET(MT_RXD4_NORMAL_PAYLOAD_FORMAT, rxd4);
+	status->amsdu = !!amsdu_info;
+	if (status->amsdu) {
+		status->first_amsdu = amsdu_info == MT_RXD4_FIRST_AMSDU_FRAME;
+		status->last_amsdu = amsdu_info == MT_RXD4_LAST_AMSDU_FRAME;
+	}
+
+	hdr_gap = (u8 *)rxd - skb->data + 2 * remove_pad;
+	if (hdr_trans && ieee80211_has_morefrags(fc)) {
+		struct ieee80211_vif *vif;
+		int err;
+
+		if (!msta || !msta->vif)
+			return -EINVAL;
+
+		vif = container_of((void *)msta->vif, struct ieee80211_vif,
+				   drv_priv);
+		err = mt76_connac2_reverse_frag0_hdr_trans(vif, skb, hdr_gap);
+		if (err)
+			return err;
+
+		hdr_trans = false;
+	} else {
+		skb_pull(skb, hdr_gap);
+		if (!hdr_trans && status->amsdu) {
+			memmove(skb->data + 2, skb->data,
+				ieee80211_get_hdrlen_from_skb(skb));
+			skb_pull(skb, 2);
+		}
+	}
+
+	if (!hdr_trans) {
+		struct ieee80211_hdr *hdr;
+
+		if (insert_ccmp_hdr) {
+			u8 key_id = FIELD_GET(MT_RXD1_NORMAL_KEY_ID, rxd1);
+
+			mt76_insert_ccmp_hdr(skb, key_id);
+		}
+
+		hdr = mt76_skb_get_hdr(skb);
+		fc = hdr->frame_control;
+		if (ieee80211_is_data_qos(fc)) {
+			seq_ctrl = le16_to_cpu(hdr->seq_ctrl);
+			qos_ctl = *ieee80211_get_qos_ctl(hdr);
+		}
+	} else {
+		status->flag |= RX_FLAG_8023;
+	}
+
+	mt7921_mac_assoc_rssi(dev, skb);
+
+	if (rxv && mode >= MT_PHY_TYPE_HE_SU && !(status->flag & RX_FLAG_8023))
+		mt76_connac2_mac_decode_he_radiotap(&dev->mt76, skb, rxv, mode);
+
+	if (!status->wcid || !ieee80211_is_data_qos(fc))
+		return 0;
+
+	status->aggr = unicast && !ieee80211_is_qos_nullfunc(fc);
+	status->seqno = IEEE80211_SEQ_TO_SN(seq_ctrl);
+	status->qos_ctl = qos_ctl;
+
+	return 0;
+}
+
+void mt7921_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
+{
+	struct mt7921_sta *msta;
+	u16 fc, tid;
+	u32 val;
+
+	if (!sta || !(sta->deflink.ht_cap.ht_supported || sta->deflink.he_cap.has_he))
+		return;
+
+	tid = le32_get_bits(txwi[1], MT_TXD1_TID);
+	if (tid >= 6) /* skip VO queue */
+		return;
+
+	val = le32_to_cpu(txwi[2]);
+	fc = FIELD_GET(MT_TXD2_FRAME_TYPE, val) << 2 |
+	     FIELD_GET(MT_TXD2_SUB_TYPE, val) << 4;
+	if (unlikely(fc != (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_QOS_DATA)))
+		return;
+
+	msta = (struct mt7921_sta *)sta->drv_priv;
+	if (!test_and_set_bit(tid, &msta->ampdu_state))
+		ieee80211_start_tx_ba_session(sta, tid, 0);
+}
+EXPORT_SYMBOL_GPL(mt7921_tx_check_aggr);
+
+void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data)
+{
+	struct mt7921_sta *msta = NULL;
+	struct mt76_wcid *wcid;
+	__le32 *txs_data = data;
+	u16 wcidx;
+	u8 pid;
+
+	if (le32_get_bits(txs_data[0], MT_TXS0_TXS_FORMAT) > 1)
+		return;
+
+	wcidx = le32_get_bits(txs_data[2], MT_TXS2_WCID);
+	pid = le32_get_bits(txs_data[3], MT_TXS3_PID);
+
+	if (pid < MT_PACKET_ID_FIRST)
+		return;
+
+	if (wcidx >= MT7921_WTBL_SIZE)
+		return;
+
+	rcu_read_lock();
+
+	wcid = rcu_dereference(dev->mt76.wcid[wcidx]);
+	if (!wcid)
+		goto out;
+
+	msta = container_of(wcid, struct mt7921_sta, wcid);
+
+	mt76_connac2_mac_add_txs_skb(&dev->mt76, wcid, pid, txs_data,
+				     &msta->stats);
+	if (!wcid->sta)
+		goto out;
+
+	spin_lock_bh(&dev->sta_poll_lock);
+	if (list_empty(&msta->poll_list))
+		list_add_tail(&msta->poll_list, &dev->sta_poll_list);
+	spin_unlock_bh(&dev->sta_poll_lock);
+
+out:
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(mt7921_mac_add_txs);
+
+void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
+			 struct sk_buff *skb)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	__le32 *rxd = (__le32 *)skb->data;
+	__le32 *end = (__le32 *)&skb->data[skb->len];
+	enum rx_pkt_type type;
+	u16 flag;
+
+	type = le32_get_bits(rxd[0], MT_RXD0_PKT_TYPE);
+	flag = le32_get_bits(rxd[0], MT_RXD0_PKT_FLAG);
+
+	if (type == PKT_TYPE_RX_EVENT && flag == 0x1)
+		type = PKT_TYPE_NORMAL_MCU;
+
+	switch (type) {
+	case PKT_TYPE_RX_EVENT:
+		mt7921_mcu_rx_event(dev, skb);
+		break;
+	case PKT_TYPE_TXS:
+		for (rxd += 2; rxd + 8 <= end; rxd += 8)
+			mt7921_mac_add_txs(dev, rxd);
+		dev_kfree_skb(skb);
+		break;
+	case PKT_TYPE_NORMAL_MCU:
+	case PKT_TYPE_NORMAL:
+		if (!mt7921_mac_fill_rx(dev, skb)) {
+			mt76_rx(&dev->mt76, q, skb);
+			return;
+		}
+		fallthrough;
+	default:
+		dev_kfree_skb(skb);
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(mt7921_queue_rx_skb);
+
+void mt7921_mac_reset_counters(struct mt7921_phy *phy)
+{
+	struct mt7921_dev *dev = phy->dev;
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		mt76_rr(dev, MT_TX_AGG_CNT(0, i));
+		mt76_rr(dev, MT_TX_AGG_CNT2(0, i));
+	}
+
+	dev->mt76.phy.survey_time = ktime_get_boottime();
+	memset(&dev->mt76.aggr_stats[0], 0, sizeof(dev->mt76.aggr_stats) / 2);
+
+	/* reset airtime counters */
+	mt76_rr(dev, MT_MIB_SDR9(0));
+	mt76_rr(dev, MT_MIB_SDR36(0));
+	mt76_rr(dev, MT_MIB_SDR37(0));
+
+	mt76_set(dev, MT_WF_RMAC_MIB_TIME0(0), MT_WF_RMAC_MIB_RXTIME_CLR);
+	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0(0), MT_WF_RMAC_MIB_RXTIME_CLR);
+}
+
+void mt7921_mac_set_timing(struct mt7921_phy *phy)
+{
+	s16 coverage_class = phy->coverage_class;
+	struct mt7921_dev *dev = phy->dev;
+	u32 val, reg_offset;
+	u32 cck = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, 231) |
+		  FIELD_PREP(MT_TIMEOUT_VAL_CCA, 48);
+	u32 ofdm = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, 60) |
+		   FIELD_PREP(MT_TIMEOUT_VAL_CCA, 28);
+	bool is_2ghz = phy->mt76->chandef.chan->band == NL80211_BAND_2GHZ;
+	int sifs = is_2ghz ? 10 : 16, offset;
+
+	if (!test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
+		return;
+
+	mt76_set(dev, MT_ARB_SCR(0),
+		 MT_ARB_SCR_TX_DISABLE | MT_ARB_SCR_RX_DISABLE);
+	udelay(1);
+
+	offset = 3 * coverage_class;
+	reg_offset = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, offset) |
+		     FIELD_PREP(MT_TIMEOUT_VAL_CCA, offset);
+
+	mt76_wr(dev, MT_TMAC_CDTR(0), cck + reg_offset);
+	mt76_wr(dev, MT_TMAC_ODTR(0), ofdm + reg_offset);
+	mt76_wr(dev, MT_TMAC_ICR0(0),
+		FIELD_PREP(MT_IFS_EIFS, 360) |
+		FIELD_PREP(MT_IFS_RIFS, 2) |
+		FIELD_PREP(MT_IFS_SIFS, sifs) |
+		FIELD_PREP(MT_IFS_SLOT, phy->slottime));
+
+	if (phy->slottime < 20 || !is_2ghz)
+		val = MT7921_CFEND_RATE_DEFAULT;
+	else
+		val = MT7921_CFEND_RATE_11B;
+
+	mt76_rmw_field(dev, MT_AGG_ACR0(0), MT_AGG_ACR_CFEND_RATE, val);
+	mt76_clear(dev, MT_ARB_SCR(0),
+		   MT_ARB_SCR_TX_DISABLE | MT_ARB_SCR_RX_DISABLE);
+}
+
+static u8
+mt7921_phy_get_nf(struct mt7921_phy *phy, int idx)
+{
+	return 0;
+}
+
+static void
+mt7921_phy_update_channel(struct mt76_phy *mphy, int idx)
+{
+	struct mt7921_dev *dev = container_of(mphy->dev, struct mt7921_dev, mt76);
+	struct mt7921_phy *phy = (struct mt7921_phy *)mphy->priv;
+	struct mt76_channel_state *state;
+	u64 busy_time, tx_time, rx_time, obss_time;
+	int nf;
+
+	busy_time = mt76_get_field(dev, MT_MIB_SDR9(idx),
+				   MT_MIB_SDR9_BUSY_MASK);
+	tx_time = mt76_get_field(dev, MT_MIB_SDR36(idx),
+				 MT_MIB_SDR36_TXTIME_MASK);
+	rx_time = mt76_get_field(dev, MT_MIB_SDR37(idx),
+				 MT_MIB_SDR37_RXTIME_MASK);
+	obss_time = mt76_get_field(dev, MT_WF_RMAC_MIB_AIRTIME14(idx),
+				   MT_MIB_OBSSTIME_MASK);
+
+	nf = mt7921_phy_get_nf(phy, idx);
+	if (!phy->noise)
+		phy->noise = nf << 4;
+	else if (nf)
+		phy->noise += nf - (phy->noise >> 4);
+
+	state = mphy->chan_state;
+	state->cc_busy += busy_time;
+	state->cc_tx += tx_time;
+	state->cc_rx += rx_time + obss_time;
+	state->cc_bss_rx += rx_time;
+	state->noise = -(phy->noise >> 4);
+}
+
+void mt7921_update_channel(struct mt76_phy *mphy)
+{
+	struct mt7921_dev *dev = container_of(mphy->dev, struct mt7921_dev, mt76);
+
+	if (mt76_connac_pm_wake(mphy, &dev->pm))
+		return;
+
+	mt7921_phy_update_channel(mphy, 0);
+	/* reset obss airtime */
+	mt76_set(dev, MT_WF_RMAC_MIB_TIME0(0), MT_WF_RMAC_MIB_RXTIME_CLR);
+
+	mt76_connac_power_save_sched(mphy, &dev->pm);
+}
+EXPORT_SYMBOL_GPL(mt7921_update_channel);
+
+static void
+mt7921_vif_connect_iter(void *priv, u8 *mac,
+			struct ieee80211_vif *vif)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_dev *dev = mvif->phy->dev;
+	struct ieee80211_hw *hw = mt76_hw(dev);
+
+	if (vif->type == NL80211_IFTYPE_STATION)
+		ieee80211_disconnect(vif, true);
+
+	mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.wcid, true);
+	mt7921_mcu_set_tx(dev, vif);
+
+	if (vif->type == NL80211_IFTYPE_AP) {
+		mt76_connac_mcu_uni_add_bss(dev->phy.mt76, vif, &mvif->sta.wcid,
+					    true);
+		mt7921_mcu_sta_update(dev, NULL, vif, true,
+				      MT76_STA_INFO_STATE_NONE);
+		mt7921_mcu_uni_add_beacon_offload(dev, hw, vif, true);
+	}
+}
+
+/* system error recovery */
+void mt7921_mac_reset_work(struct work_struct *work)
+{
+	struct mt7921_dev *dev = container_of(work, struct mt7921_dev,
+					      reset_work);
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	struct mt76_connac_pm *pm = &dev->pm;
+	int i, ret;
+
+	dev_dbg(dev->mt76.dev, "chip reset\n");
+	dev->hw_full_reset = true;
+	ieee80211_stop_queues(hw);
+
+	cancel_delayed_work_sync(&dev->mphy.mac_work);
+	cancel_delayed_work_sync(&pm->ps_work);
+	cancel_work_sync(&pm->wake_work);
+
+	for (i = 0; i < 10; i++) {
+		mutex_lock(&dev->mt76.mutex);
+		ret = mt7921_dev_reset(dev);
+		mutex_unlock(&dev->mt76.mutex);
+
+		if (!ret)
+			break;
+	}
+
+	if (i == 10)
+		dev_err(dev->mt76.dev, "chip reset failed\n");
+
+	if (test_and_clear_bit(MT76_HW_SCANNING, &dev->mphy.state)) {
+		struct cfg80211_scan_info info = {
+			.aborted = true,
+		};
+
+		ieee80211_scan_completed(dev->mphy.hw, &info);
+	}
+
+	dev->hw_full_reset = false;
+	pm->suspended = false;
+	ieee80211_wake_queues(hw);
+	ieee80211_iterate_active_interfaces(hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7921_vif_connect_iter, NULL);
+	mt76_connac_power_save_sched(&dev->mt76.phy, pm);
+}
+
+void mt7921_reset(struct mt76_dev *mdev)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+
+	if (!dev->hw_init_done)
+		return;
+
+	if (dev->hw_full_reset)
+		return;
+
+	queue_work(dev->mt76.wq, &dev->reset_work);
+}
+
+void mt7921_mac_update_mib_stats(struct mt7921_phy *phy)
+{
+	struct mt7921_dev *dev = phy->dev;
+	struct mib_stats *mib = &phy->mib;
+	int i, aggr0 = 0, aggr1;
+	u32 val;
+
+	mib->fcs_err_cnt += mt76_get_field(dev, MT_MIB_SDR3(0),
+					   MT_MIB_SDR3_FCS_ERR_MASK);
+	mib->ack_fail_cnt += mt76_get_field(dev, MT_MIB_MB_BSDR3(0),
+					    MT_MIB_ACK_FAIL_COUNT_MASK);
+	mib->ba_miss_cnt += mt76_get_field(dev, MT_MIB_MB_BSDR2(0),
+					   MT_MIB_BA_FAIL_COUNT_MASK);
+	mib->rts_cnt += mt76_get_field(dev, MT_MIB_MB_BSDR0(0),
+				       MT_MIB_RTS_COUNT_MASK);
+	mib->rts_retries_cnt += mt76_get_field(dev, MT_MIB_MB_BSDR1(0),
+					       MT_MIB_RTS_FAIL_COUNT_MASK);
+
+	mib->tx_ampdu_cnt += mt76_rr(dev, MT_MIB_SDR12(0));
+	mib->tx_mpdu_attempts_cnt += mt76_rr(dev, MT_MIB_SDR14(0));
+	mib->tx_mpdu_success_cnt += mt76_rr(dev, MT_MIB_SDR15(0));
+
+	val = mt76_rr(dev, MT_MIB_SDR32(0));
+	mib->tx_pkt_ebf_cnt += FIELD_GET(MT_MIB_SDR9_EBF_CNT_MASK, val);
+	mib->tx_pkt_ibf_cnt += FIELD_GET(MT_MIB_SDR9_IBF_CNT_MASK, val);
+
+	val = mt76_rr(dev, MT_ETBF_TX_APP_CNT(0));
+	mib->tx_bf_ibf_ppdu_cnt += FIELD_GET(MT_ETBF_TX_IBF_CNT, val);
+	mib->tx_bf_ebf_ppdu_cnt += FIELD_GET(MT_ETBF_TX_EBF_CNT, val);
+
+	val = mt76_rr(dev, MT_ETBF_RX_FB_CNT(0));
+	mib->tx_bf_rx_fb_all_cnt += FIELD_GET(MT_ETBF_RX_FB_ALL, val);
+	mib->tx_bf_rx_fb_he_cnt += FIELD_GET(MT_ETBF_RX_FB_HE, val);
+	mib->tx_bf_rx_fb_vht_cnt += FIELD_GET(MT_ETBF_RX_FB_VHT, val);
+	mib->tx_bf_rx_fb_ht_cnt += FIELD_GET(MT_ETBF_RX_FB_HT, val);
+
+	mib->rx_mpdu_cnt += mt76_rr(dev, MT_MIB_SDR5(0));
+	mib->rx_ampdu_cnt += mt76_rr(dev, MT_MIB_SDR22(0));
+	mib->rx_ampdu_bytes_cnt += mt76_rr(dev, MT_MIB_SDR23(0));
+	mib->rx_ba_cnt += mt76_rr(dev, MT_MIB_SDR31(0));
+
+	for (i = 0; i < ARRAY_SIZE(mib->tx_amsdu); i++) {
+		val = mt76_rr(dev, MT_PLE_AMSDU_PACK_MSDU_CNT(i));
+		mib->tx_amsdu[i] += val;
+		mib->tx_amsdu_cnt += val;
+	}
+
+	for (i = 0, aggr1 = aggr0 + 4; i < 4; i++) {
+		u32 val2;
+
+		val = mt76_rr(dev, MT_TX_AGG_CNT(0, i));
+		val2 = mt76_rr(dev, MT_TX_AGG_CNT2(0, i));
+
+		dev->mt76.aggr_stats[aggr0++] += val & 0xffff;
+		dev->mt76.aggr_stats[aggr0++] += val >> 16;
+		dev->mt76.aggr_stats[aggr1++] += val2 & 0xffff;
+		dev->mt76.aggr_stats[aggr1++] += val2 >> 16;
+	}
+}
+
+void mt7921_mac_work(struct work_struct *work)
+{
+	struct mt7921_phy *phy;
+	struct mt76_phy *mphy;
+
+	mphy = (struct mt76_phy *)container_of(work, struct mt76_phy,
+					       mac_work.work);
+	phy = mphy->priv;
+
+	mt7921_mutex_acquire(phy->dev);
+
+	mt76_update_survey(mphy);
+	if (++mphy->mac_work_count == 2) {
+		mphy->mac_work_count = 0;
+
+		mt7921_mac_update_mib_stats(phy);
+	}
+
+	mt7921_mutex_release(phy->dev);
+
+	mt76_tx_status_check(mphy->dev, false);
+	ieee80211_queue_delayed_work(phy->mt76->hw, &mphy->mac_work,
+				     MT7921_WATCHDOG_TIME);
+}
+
+void mt7921_pm_wake_work(struct work_struct *work)
+{
+	struct mt7921_dev *dev;
+	struct mt76_phy *mphy;
+
+	dev = (struct mt7921_dev *)container_of(work, struct mt7921_dev,
+						pm.wake_work);
+	mphy = dev->phy.mt76;
+
+	if (!mt7921_mcu_drv_pmctrl(dev)) {
+		struct mt76_dev *mdev = &dev->mt76;
+		int i;
+
+		if (mt76_is_sdio(mdev)) {
+			mt76_connac_pm_dequeue_skbs(mphy, &dev->pm);
+			mt76_worker_schedule(&mdev->sdio.txrx_worker);
+		} else {
+			local_bh_disable();
+			mt76_for_each_q_rx(mdev, i)
+				napi_schedule(&mdev->napi[i]);
+			local_bh_enable();
+			mt76_connac_pm_dequeue_skbs(mphy, &dev->pm);
+			mt76_connac_tx_cleanup(mdev);
+		}
+		if (test_bit(MT76_STATE_RUNNING, &mphy->state))
+			ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
+						     MT7921_WATCHDOG_TIME);
+	}
+
+	ieee80211_wake_queues(mphy->hw);
+	wake_up(&dev->pm.wait);
+}
+
+void mt7921_pm_power_save_work(struct work_struct *work)
+{
+	struct mt7921_dev *dev;
+	unsigned long delta;
+	struct mt76_phy *mphy;
+
+	dev = (struct mt7921_dev *)container_of(work, struct mt7921_dev,
+						pm.ps_work.work);
+	mphy = dev->phy.mt76;
+
+	delta = dev->pm.idle_timeout;
+	if (test_bit(MT76_HW_SCANNING, &mphy->state) ||
+	    test_bit(MT76_HW_SCHED_SCANNING, &mphy->state) ||
+	    dev->fw_assert)
+		goto out;
+
+	if (mutex_is_locked(&dev->mt76.mutex))
+		/* if mt76 mutex is held we should not put the device
+		 * to sleep since we are currently accessing device
+		 * register map. We need to wait for the next power_save
+		 * trigger.
+		 */
+		goto out;
+
+	if (time_is_after_jiffies(dev->pm.last_activity + delta)) {
+		delta = dev->pm.last_activity + delta - jiffies;
+		goto out;
+	}
+
+	if (!mt7921_mcu_fw_pmctrl(dev)) {
+		cancel_delayed_work_sync(&mphy->mac_work);
+		return;
+	}
+out:
+	queue_delayed_work(dev->mt76.wq, &dev->pm.ps_work, delta);
+}
+
+void mt7921_coredump_work(struct work_struct *work)
+{
+	struct mt7921_dev *dev;
+	char *dump, *data;
+
+	dev = (struct mt7921_dev *)container_of(work, struct mt7921_dev,
+						coredump.work.work);
+
+	if (time_is_after_jiffies(dev->coredump.last_activity +
+				  4 * MT76_CONNAC_COREDUMP_TIMEOUT)) {
+		queue_delayed_work(dev->mt76.wq, &dev->coredump.work,
+				   MT76_CONNAC_COREDUMP_TIMEOUT);
+		return;
+	}
+
+	dump = vzalloc(MT76_CONNAC_COREDUMP_SZ);
+	data = dump;
+
+	while (true) {
+		struct sk_buff *skb;
+
+		spin_lock_bh(&dev->mt76.lock);
+		skb = __skb_dequeue(&dev->coredump.msg_list);
+		spin_unlock_bh(&dev->mt76.lock);
+
+		if (!skb)
+			break;
+
+		skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
+		if (!dump || data + skb->len - dump > MT76_CONNAC_COREDUMP_SZ) {
+			dev_kfree_skb(skb);
+			continue;
+		}
+
+		memcpy(data, skb->data, skb->len);
+		data += skb->len;
+
+		dev_kfree_skb(skb);
+	}
+
+	if (dump)
+		dev_coredumpv(dev->mt76.dev, dump, MT76_CONNAC_COREDUMP_SZ,
+			      GFP_KERNEL);
+
+	mt7921_reset(&dev->mt76);
+}
+
+/* usb_sdio */
+static void
+mt7921_usb_sdio_write_txwi(struct mt7921_dev *dev, struct mt76_wcid *wcid,
+			   enum mt76_txq_id qid, struct ieee80211_sta *sta,
+			   struct ieee80211_key_conf *key, int pid,
+			   struct sk_buff *skb)
+{
+	__le32 *txwi = (__le32 *)(skb->data - MT_SDIO_TXD_SIZE);
+
+	memset(txwi, 0, MT_SDIO_TXD_SIZE);
+	mt76_connac2_mac_write_txwi(&dev->mt76, txwi, skb, wcid, key, pid, qid, 0);
+	skb_push(skb, MT_SDIO_TXD_SIZE);
+}
+
+int mt7921_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
+				   enum mt76_txq_id qid, struct mt76_wcid *wcid,
+				   struct ieee80211_sta *sta,
+				   struct mt76_tx_info *tx_info)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
+	struct ieee80211_key_conf *key = info->control.hw_key;
+	struct sk_buff *skb = tx_info->skb;
+	int err, pad, pktid, type;
+
+	if (unlikely(tx_info->skb->len <= ETH_HLEN))
+		return -EINVAL;
+
+	if (!wcid)
+		wcid = &dev->mt76.global_wcid;
+
+	if (sta) {
+		struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+
+		if (time_after(jiffies, msta->last_txs + HZ / 4)) {
+			info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
+			msta->last_txs = jiffies;
+		}
+	}
+
+	pktid = mt76_tx_status_skb_add(&dev->mt76, wcid, skb);
+	mt7921_usb_sdio_write_txwi(dev, wcid, qid, sta, key, pktid, skb);
+
+	type = mt76_is_sdio(mdev) ? MT7921_SDIO_DATA : 0;
+	mt7921_skb_add_usb_sdio_hdr(dev, skb, type);
+	pad = round_up(skb->len, 4) - skb->len;
+	if (mt76_is_usb(mdev))
+		pad += 4;
+
+	err = mt76_skb_adjust_pad(skb, pad);
+	if (err)
+		/* Release pktid in case of error. */
+		idr_remove(&wcid->pktid, pktid);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(mt7921_usb_sdio_tx_prepare_skb);
+
+void mt7921_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
+				     struct mt76_queue_entry *e)
+{
+	__le32 *txwi = (__le32 *)(e->skb->data + MT_SDIO_HDR_SIZE);
+	unsigned int headroom = MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE;
+	struct ieee80211_sta *sta;
+	struct mt76_wcid *wcid;
+	u16 idx;
+
+	idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
+	wcid = rcu_dereference(mdev->wcid[idx]);
+	sta = wcid_to_sta(wcid);
+
+	if (sta && likely(e->skb->protocol != cpu_to_be16(ETH_P_PAE)))
+		mt7921_tx_check_aggr(sta, txwi);
+
+	skb_pull(e->skb, headroom);
+	mt76_tx_complete_skb(mdev, e->wcid, e->skb);
+}
+EXPORT_SYMBOL_GPL(mt7921_usb_sdio_tx_complete_skb);
+
+bool mt7921_usb_sdio_tx_status_data(struct mt76_dev *mdev, u8 *update)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+
+	mt7921_mutex_acquire(dev);
+	mt7921_mac_sta_poll(dev);
+	mt7921_mutex_release(dev);
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(mt7921_usb_sdio_tx_status_data);
+
+#if IS_ENABLED(CONFIG_IPV6)
+void mt7921_set_ipv6_ns_work(struct work_struct *work)
+{
+	struct mt7921_dev *dev = container_of(work, struct mt7921_dev,
+						ipv6_ns_work);
+	struct sk_buff *skb;
+	int ret = 0;
+
+	do {
+		skb = skb_dequeue(&dev->ipv6_ns_list);
+
+		if (!skb)
+			break;
+
+		mt7921_mutex_acquire(dev);
+		ret = mt76_mcu_skb_send_msg(&dev->mt76, skb,
+					    MCU_UNI_CMD(OFFLOAD), true);
+		mt7921_mutex_release(dev);
+
+	} while (!ret);
+
+	if (ret)
+		skb_queue_purge(&dev->ipv6_ns_list);
+}
+#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c.orig b/drivers/net/wireless/mediatek/mt76/mt7921/main.c.orig
new file mode 100644
index 000000000000..87067ac367eb
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c.orig
@@ -0,0 +1,1838 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#include <linux/etherdevice.h>
+#include <linux/platform_device.h>
+#include <linux/pci.h>
+#include <linux/module.h>
+#include <net/ipv6.h>
+#include "mt7921.h"
+#include "mcu.h"
+
+static int
+mt7921_init_he_caps(struct mt7921_phy *phy, enum nl80211_band band,
+		    struct ieee80211_sband_iftype_data *data)
+{
+	int i, idx = 0;
+	int nss = hweight8(phy->mt76->chainmask);
+	u16 mcs_map = 0;
+
+	for (i = 0; i < 8; i++) {
+		if (i < nss)
+			mcs_map |= (IEEE80211_HE_MCS_SUPPORT_0_11 << (i * 2));
+		else
+			mcs_map |= (IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2));
+	}
+
+	for (i = 0; i < NUM_NL80211_IFTYPES; i++) {
+		struct ieee80211_sta_he_cap *he_cap = &data[idx].he_cap;
+		struct ieee80211_he_cap_elem *he_cap_elem =
+				&he_cap->he_cap_elem;
+		struct ieee80211_he_mcs_nss_supp *he_mcs =
+				&he_cap->he_mcs_nss_supp;
+
+		switch (i) {
+		case NL80211_IFTYPE_STATION:
+		case NL80211_IFTYPE_AP:
+			break;
+		default:
+			continue;
+		}
+
+		data[idx].types_mask = BIT(i);
+		he_cap->has_he = true;
+
+		he_cap_elem->mac_cap_info[0] =
+			IEEE80211_HE_MAC_CAP0_HTC_HE;
+		he_cap_elem->mac_cap_info[3] =
+			IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
+			IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_3;
+		he_cap_elem->mac_cap_info[4] =
+			IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU;
+
+		if (band == NL80211_BAND_2GHZ)
+			he_cap_elem->phy_cap_info[0] =
+				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
+		else
+			he_cap_elem->phy_cap_info[0] =
+				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G;
+
+		he_cap_elem->phy_cap_info[1] =
+			IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD;
+		he_cap_elem->phy_cap_info[2] =
+			IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US |
+			IEEE80211_HE_PHY_CAP2_STBC_TX_UNDER_80MHZ |
+			IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ |
+			IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO |
+			IEEE80211_HE_PHY_CAP2_UL_MU_PARTIAL_MU_MIMO;
+
+		switch (i) {
+		case NL80211_IFTYPE_AP:
+			he_cap_elem->mac_cap_info[2] |=
+				IEEE80211_HE_MAC_CAP2_BSR;
+			he_cap_elem->mac_cap_info[4] |=
+				IEEE80211_HE_MAC_CAP4_BQR;
+			he_cap_elem->mac_cap_info[5] |=
+				IEEE80211_HE_MAC_CAP5_OM_CTRL_UL_MU_DATA_DIS_RX;
+			he_cap_elem->phy_cap_info[3] |=
+				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_QPSK |
+				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_QPSK;
+			he_cap_elem->phy_cap_info[6] |=
+				IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE |
+				IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT;
+			he_cap_elem->phy_cap_info[9] |=
+				IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU |
+				IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU;
+			break;
+		case NL80211_IFTYPE_STATION:
+			he_cap_elem->mac_cap_info[1] |=
+				IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_16US;
+
+			if (band == NL80211_BAND_2GHZ)
+				he_cap_elem->phy_cap_info[0] |=
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_2G;
+			else
+				he_cap_elem->phy_cap_info[0] |=
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_5G;
+
+			he_cap_elem->phy_cap_info[1] |=
+				IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
+				IEEE80211_HE_PHY_CAP1_HE_LTF_AND_GI_FOR_HE_PPDUS_0_8US;
+			he_cap_elem->phy_cap_info[3] |=
+				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_QPSK |
+				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_QPSK;
+			he_cap_elem->phy_cap_info[4] |=
+				IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE |
+				IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_4;
+			he_cap_elem->phy_cap_info[5] |=
+				IEEE80211_HE_PHY_CAP5_NG16_SU_FEEDBACK |
+				IEEE80211_HE_PHY_CAP5_NG16_MU_FEEDBACK;
+			he_cap_elem->phy_cap_info[6] |=
+				IEEE80211_HE_PHY_CAP6_CODEBOOK_SIZE_42_SU |
+				IEEE80211_HE_PHY_CAP6_CODEBOOK_SIZE_75_MU |
+				IEEE80211_HE_PHY_CAP6_TRIG_CQI_FB |
+				IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE |
+				IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT;
+			he_cap_elem->phy_cap_info[7] |=
+				IEEE80211_HE_PHY_CAP7_POWER_BOOST_FACTOR_SUPP |
+				IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI;
+			he_cap_elem->phy_cap_info[8] |=
+				IEEE80211_HE_PHY_CAP8_20MHZ_IN_40MHZ_HE_PPDU_IN_2G |
+				IEEE80211_HE_PHY_CAP8_DCM_MAX_RU_484;
+			he_cap_elem->phy_cap_info[9] |=
+				IEEE80211_HE_PHY_CAP9_LONGER_THAN_16_SIGB_OFDM_SYM |
+				IEEE80211_HE_PHY_CAP9_NON_TRIGGERED_CQI_FEEDBACK |
+				IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU |
+				IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU |
+				IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_COMP_SIGB |
+				IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_NON_COMP_SIGB;
+
+			if (is_mt7922(phy->mt76->dev)) {
+				he_cap_elem->phy_cap_info[0] |=
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+				he_cap_elem->phy_cap_info[8] |=
+					IEEE80211_HE_PHY_CAP8_20MHZ_IN_160MHZ_HE_PPDU |
+					IEEE80211_HE_PHY_CAP8_80MHZ_IN_160MHZ_HE_PPDU;
+			}
+			break;
+		}
+
+		he_mcs->rx_mcs_80 = cpu_to_le16(mcs_map);
+		he_mcs->tx_mcs_80 = cpu_to_le16(mcs_map);
+		if (is_mt7922(phy->mt76->dev)) {
+			he_mcs->rx_mcs_160 = cpu_to_le16(mcs_map);
+			he_mcs->tx_mcs_160 = cpu_to_le16(mcs_map);
+		}
+
+		memset(he_cap->ppe_thres, 0, sizeof(he_cap->ppe_thres));
+		if (he_cap_elem->phy_cap_info[6] &
+		    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
+			mt76_connac_gen_ppe_thresh(he_cap->ppe_thres, nss);
+		} else {
+			he_cap_elem->phy_cap_info[9] |=
+				u8_encode_bits(IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US,
+					       IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_MASK);
+		}
+
+		if (band == NL80211_BAND_6GHZ) {
+			struct ieee80211_supported_band *sband =
+				&phy->mt76->sband_5g.sband;
+			struct ieee80211_sta_vht_cap *vht_cap = &sband->vht_cap;
+			struct ieee80211_sta_ht_cap *ht_cap = &sband->ht_cap;
+			u32 exp;
+			u16 cap;
+
+			cap = u16_encode_bits(ht_cap->ampdu_density,
+					IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START);
+			exp = u32_get_bits(vht_cap->cap,
+				IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK);
+			cap |= u16_encode_bits(exp,
+					IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP);
+			exp = u32_get_bits(vht_cap->cap,
+					   IEEE80211_VHT_CAP_MAX_MPDU_MASK);
+			cap |= u16_encode_bits(exp,
+					IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN);
+			if (vht_cap->cap & IEEE80211_VHT_CAP_TX_ANTENNA_PATTERN)
+				cap |= IEEE80211_HE_6GHZ_CAP_TX_ANTPAT_CONS;
+			if (vht_cap->cap & IEEE80211_VHT_CAP_RX_ANTENNA_PATTERN)
+				cap |= IEEE80211_HE_6GHZ_CAP_RX_ANTPAT_CONS;
+
+			data[idx].he_6ghz_capa.capa = cpu_to_le16(cap);
+		}
+		idx++;
+	}
+
+	return idx;
+}
+
+void mt7921_set_stream_he_caps(struct mt7921_phy *phy)
+{
+	struct ieee80211_sband_iftype_data *data;
+	struct ieee80211_supported_band *band;
+	int n;
+
+	if (phy->mt76->cap.has_2ghz) {
+		data = phy->iftype[NL80211_BAND_2GHZ];
+		n = mt7921_init_he_caps(phy, NL80211_BAND_2GHZ, data);
+
+		band = &phy->mt76->sband_2g.sband;
+		band->iftype_data = data;
+		band->n_iftype_data = n;
+	}
+
+	if (phy->mt76->cap.has_5ghz) {
+		data = phy->iftype[NL80211_BAND_5GHZ];
+		n = mt7921_init_he_caps(phy, NL80211_BAND_5GHZ, data);
+
+		band = &phy->mt76->sband_5g.sband;
+		band->iftype_data = data;
+		band->n_iftype_data = n;
+
+		if (phy->mt76->cap.has_6ghz) {
+			data = phy->iftype[NL80211_BAND_6GHZ];
+			n = mt7921_init_he_caps(phy, NL80211_BAND_6GHZ, data);
+
+			band = &phy->mt76->sband_6g.sband;
+			band->iftype_data = data;
+			band->n_iftype_data = n;
+		}
+	}
+}
+
+int __mt7921_start(struct mt7921_phy *phy)
+{
+	struct mt76_phy *mphy = phy->mt76;
+	int err;
+
+	err = mt76_connac_mcu_set_mac_enable(mphy->dev, 0, true, false);
+	if (err)
+		return err;
+
+	err = mt76_connac_mcu_set_channel_domain(mphy);
+	if (err)
+		return err;
+
+	err = mt7921_mcu_set_chan_info(phy, MCU_EXT_CMD(SET_RX_PATH));
+	if (err)
+		return err;
+
+	err = mt7921_set_tx_sar_pwr(mphy->hw, NULL);
+	if (err)
+		return err;
+
+	mt7921_mac_reset_counters(phy);
+	set_bit(MT76_STATE_RUNNING, &mphy->state);
+
+	ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
+				     MT7921_WATCHDOG_TIME);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__mt7921_start);
+
+static int mt7921_start(struct ieee80211_hw *hw)
+{
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	int err;
+
+	mt7921_mutex_acquire(phy->dev);
+	err = __mt7921_start(phy);
+	mt7921_mutex_release(phy->dev);
+
+	return err;
+}
+
+void mt7921_stop(struct ieee80211_hw *hw)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+
+	cancel_delayed_work_sync(&phy->mt76->mac_work);
+
+	cancel_delayed_work_sync(&dev->pm.ps_work);
+	cancel_work_sync(&dev->pm.wake_work);
+	cancel_work_sync(&dev->reset_work);
+	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
+
+	mt7921_mutex_acquire(dev);
+	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
+	mt76_connac_mcu_set_mac_enable(&dev->mt76, 0, false, false);
+	mt7921_mutex_release(dev);
+}
+EXPORT_SYMBOL_GPL(mt7921_stop);
+
+static int mt7921_add_interface(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt76_txq *mtxq;
+	int idx, ret = 0;
+
+	mt7921_mutex_acquire(dev);
+
+	mvif->mt76.idx = __ffs64(~dev->mt76.vif_mask);
+	if (mvif->mt76.idx >= MT7921_MAX_INTERFACES) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	mvif->mt76.omac_idx = mvif->mt76.idx;
+	mvif->phy = phy;
+	mvif->mt76.band_idx = 0;
+	mvif->mt76.wmm_idx = mvif->mt76.idx % MT76_CONNAC_MAX_WMM_SETS;
+
+	ret = mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.wcid,
+					  true);
+	if (ret)
+		goto out;
+
+	dev->mt76.vif_mask |= BIT_ULL(mvif->mt76.idx);
+	phy->omac_mask |= BIT_ULL(mvif->mt76.omac_idx);
+
+	idx = MT7921_WTBL_RESERVED - mvif->mt76.idx;
+
+	INIT_LIST_HEAD(&mvif->sta.wcid.poll_list);
+	mvif->sta.wcid.idx = idx;
+	mvif->sta.wcid.phy_idx = mvif->mt76.band_idx;
+	mvif->sta.wcid.hw_key_idx = -1;
+	mvif->sta.wcid.tx_info |= MT_WCID_TX_INFO_SET;
+	mt76_packet_id_init(&mvif->sta.wcid);
+
+	mt7921_mac_wtbl_update(dev, idx,
+			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+
+	ewma_rssi_init(&mvif->rssi);
+
+	rcu_assign_pointer(dev->mt76.wcid[idx], &mvif->sta.wcid);
+	if (vif->txq) {
+		mtxq = (struct mt76_txq *)vif->txq->drv_priv;
+		mtxq->wcid = idx;
+	}
+
+	vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
+out:
+	mt7921_mutex_release(dev);
+
+	return ret;
+}
+
+static void mt7921_remove_interface(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_sta *msta = &mvif->sta;
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	int idx = msta->wcid.idx;
+
+	mt7921_mutex_acquire(dev);
+	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->wcid);
+	mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.wcid, false);
+
+	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
+
+	dev->mt76.vif_mask &= ~BIT_ULL(mvif->mt76.idx);
+	phy->omac_mask &= ~BIT_ULL(mvif->mt76.omac_idx);
+	mt7921_mutex_release(dev);
+
+	spin_lock_bh(&dev->mt76.sta_poll_lock);
+	if (!list_empty(&msta->wcid.poll_list))
+		list_del_init(&msta->wcid.poll_list);
+	spin_unlock_bh(&dev->mt76.sta_poll_lock);
+
+	mt76_packet_id_flush(&dev->mt76, &msta->wcid);
+}
+
+static void mt7921_roc_iter(void *priv, u8 *mac,
+			    struct ieee80211_vif *vif)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_phy *phy = priv;
+
+	mt7921_mcu_abort_roc(phy, mvif, phy->roc_token_id);
+}
+
+void mt7921_roc_work(struct work_struct *work)
+{
+	struct mt7921_phy *phy;
+
+	phy = (struct mt7921_phy *)container_of(work, struct mt7921_phy,
+						roc_work);
+
+	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
+		return;
+
+	mt7921_mutex_acquire(phy->dev);
+	ieee80211_iterate_active_interfaces(phy->mt76->hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7921_roc_iter, phy);
+	mt7921_mutex_release(phy->dev);
+	ieee80211_remain_on_channel_expired(phy->mt76->hw);
+}
+
+void mt7921_roc_timer(struct timer_list *timer)
+{
+	struct mt7921_phy *phy = from_timer(phy, timer, roc_timer);
+
+	ieee80211_queue_work(phy->mt76->hw, &phy->roc_work);
+}
+
+static int mt7921_abort_roc(struct mt7921_phy *phy, struct mt7921_vif *vif)
+{
+	int err = 0;
+
+	del_timer_sync(&phy->roc_timer);
+	cancel_work_sync(&phy->roc_work);
+
+	mt7921_mutex_acquire(phy->dev);
+	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
+		err = mt7921_mcu_abort_roc(phy, vif, phy->roc_token_id);
+	mt7921_mutex_release(phy->dev);
+
+	return err;
+}
+
+static int mt7921_set_roc(struct mt7921_phy *phy,
+			  struct mt7921_vif *vif,
+			  struct ieee80211_channel *chan,
+			  int duration,
+			  enum mt7921_roc_req type)
+{
+	int err;
+
+	if (test_and_set_bit(MT76_STATE_ROC, &phy->mt76->state))
+		return -EBUSY;
+
+	phy->roc_grant = false;
+
+	err = mt7921_mcu_set_roc(phy, vif, chan, duration, type,
+				 ++phy->roc_token_id);
+	if (err < 0) {
+		clear_bit(MT76_STATE_ROC, &phy->mt76->state);
+		goto out;
+	}
+
+	if (!wait_event_timeout(phy->roc_wait, phy->roc_grant, HZ)) {
+		mt7921_mcu_abort_roc(phy, vif, phy->roc_token_id);
+		clear_bit(MT76_STATE_ROC, &phy->mt76->state);
+		err = -ETIMEDOUT;
+	}
+
+out:
+	return err;
+}
+
+static int mt7921_remain_on_channel(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_channel *chan,
+				    int duration,
+				    enum ieee80211_roc_type type)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	int err;
+
+	mt7921_mutex_acquire(phy->dev);
+	err = mt7921_set_roc(phy, mvif, chan, duration, MT7921_ROC_REQ_ROC);
+	mt7921_mutex_release(phy->dev);
+
+	return err;
+}
+
+static int mt7921_cancel_remain_on_channel(struct ieee80211_hw *hw,
+					   struct ieee80211_vif *vif)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+
+	return mt7921_abort_roc(phy, mvif);
+}
+
+static int mt7921_set_channel(struct mt7921_phy *phy)
+{
+	struct mt7921_dev *dev = phy->dev;
+	int ret;
+
+	cancel_delayed_work_sync(&phy->mt76->mac_work);
+
+	mt7921_mutex_acquire(dev);
+	set_bit(MT76_RESET, &phy->mt76->state);
+
+	mt76_set_channel(phy->mt76);
+
+	ret = mt7921_mcu_set_chan_info(phy, MCU_EXT_CMD(CHANNEL_SWITCH));
+	if (ret)
+		goto out;
+
+	mt7921_mac_set_timing(phy);
+
+	mt7921_mac_reset_counters(phy);
+	phy->noise = 0;
+
+out:
+	clear_bit(MT76_RESET, &phy->mt76->state);
+	mt7921_mutex_release(dev);
+
+	mt76_worker_schedule(&dev->mt76.tx_worker);
+	ieee80211_queue_delayed_work(phy->mt76->hw, &phy->mt76->mac_work,
+				     MT7921_WATCHDOG_TIME);
+
+	return ret;
+}
+
+static int mt7921_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
+			  struct ieee80211_vif *vif, struct ieee80211_sta *sta,
+			  struct ieee80211_key_conf *key)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_sta *msta = sta ? (struct mt7921_sta *)sta->drv_priv :
+				  &mvif->sta;
+	struct mt76_wcid *wcid = &msta->wcid;
+	u8 *wcid_keyidx = &wcid->hw_key_idx;
+	int idx = key->keyidx, err = 0;
+
+	/* The hardware does not support per-STA RX GTK, fallback
+	 * to software mode for these.
+	 */
+	if ((vif->type == NL80211_IFTYPE_ADHOC ||
+	     vif->type == NL80211_IFTYPE_MESH_POINT) &&
+	    (key->cipher == WLAN_CIPHER_SUITE_TKIP ||
+	     key->cipher == WLAN_CIPHER_SUITE_CCMP) &&
+	    !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
+		return -EOPNOTSUPP;
+
+	/* fall back to sw encryption for unsupported ciphers */
+	switch (key->cipher) {
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIE;
+		wcid_keyidx = &wcid->hw_key_idx2;
+		break;
+	case WLAN_CIPHER_SUITE_WEP40:
+	case WLAN_CIPHER_SUITE_WEP104:
+		if (!mvif->wep_sta)
+			return -EOPNOTSUPP;
+		break;
+	case WLAN_CIPHER_SUITE_TKIP:
+	case WLAN_CIPHER_SUITE_CCMP:
+	case WLAN_CIPHER_SUITE_CCMP_256:
+	case WLAN_CIPHER_SUITE_GCMP:
+	case WLAN_CIPHER_SUITE_GCMP_256:
+	case WLAN_CIPHER_SUITE_SMS4:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	mt7921_mutex_acquire(dev);
+
+	if (cmd == SET_KEY) {
+		*wcid_keyidx = idx;
+	} else {
+		if (idx == *wcid_keyidx)
+			*wcid_keyidx = -1;
+		goto out;
+	}
+
+	mt76_wcid_key_setup(&dev->mt76, wcid, key);
+	err = mt76_connac_mcu_add_key(&dev->mt76, vif, &msta->bip,
+				      key, MCU_UNI_CMD(STA_REC_UPDATE),
+				      &msta->wcid, cmd);
+	if (err)
+		goto out;
+
+	if (key->cipher == WLAN_CIPHER_SUITE_WEP104 ||
+	    key->cipher == WLAN_CIPHER_SUITE_WEP40)
+		err = mt76_connac_mcu_add_key(&dev->mt76, vif,
+					      &mvif->wep_sta->bip,
+					      key, MCU_UNI_CMD(STA_REC_UPDATE),
+					      &mvif->wep_sta->wcid, cmd);
+out:
+	mt7921_mutex_release(dev);
+
+	return err;
+}
+
+static void
+mt7921_pm_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct mt7921_dev *dev = priv;
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	bool pm_enable = dev->pm.enable;
+	int err;
+
+	err = mt7921_mcu_set_beacon_filter(dev, vif, pm_enable);
+	if (err < 0)
+		return;
+
+	if (pm_enable) {
+		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
+		ieee80211_hw_set(hw, CONNECTION_MONITOR);
+	} else {
+		vif->driver_flags &= ~IEEE80211_VIF_BEACON_FILTER;
+		__clear_bit(IEEE80211_HW_CONNECTION_MONITOR, hw->flags);
+	}
+}
+
+static void
+mt7921_sniffer_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct mt7921_dev *dev = priv;
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	struct mt76_connac_pm *pm = &dev->pm;
+	bool monitor = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
+
+	mt7921_mcu_set_sniffer(dev, vif, monitor);
+	pm->enable = pm->enable_user && !monitor;
+	pm->ds_enable = pm->ds_enable_user && !monitor;
+
+	mt76_connac_mcu_set_deep_sleep(&dev->mt76, pm->ds_enable);
+
+	if (monitor)
+		mt7921_mcu_set_beacon_filter(dev, vif, false);
+}
+
+void mt7921_set_runtime_pm(struct mt7921_dev *dev)
+{
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	struct mt76_connac_pm *pm = &dev->pm;
+	bool monitor = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
+
+	pm->enable = pm->enable_user && !monitor;
+	ieee80211_iterate_active_interfaces(hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7921_pm_interface_iter, dev);
+	pm->ds_enable = pm->ds_enable_user && !monitor;
+	mt76_connac_mcu_set_deep_sleep(&dev->mt76, pm->ds_enable);
+}
+
+static int mt7921_config(struct ieee80211_hw *hw, u32 changed)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	int ret = 0;
+
+	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
+		ieee80211_stop_queues(hw);
+		ret = mt7921_set_channel(phy);
+		if (ret)
+			return ret;
+		ieee80211_wake_queues(hw);
+	}
+
+	mt7921_mutex_acquire(dev);
+
+	if (changed & IEEE80211_CONF_CHANGE_POWER) {
+		ret = mt7921_set_tx_sar_pwr(hw, NULL);
+		if (ret)
+			goto out;
+	}
+
+	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
+		ieee80211_iterate_active_interfaces(hw,
+						    IEEE80211_IFACE_ITER_RESUME_ALL,
+						    mt7921_sniffer_interface_iter, dev);
+	}
+
+out:
+	mt7921_mutex_release(dev);
+
+	return ret;
+}
+
+static int
+mt7921_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+	       unsigned int link_id, u16 queue,
+	       const struct ieee80211_tx_queue_params *params)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+
+	/* no need to update right away, we'll get BSS_CHANGED_QOS */
+	queue = mt76_connac_lmac_mapping(queue);
+	mvif->queue_params[queue] = *params;
+
+	return 0;
+}
+
+static void mt7921_configure_filter(struct ieee80211_hw *hw,
+				    unsigned int changed_flags,
+				    unsigned int *total_flags,
+				    u64 multicast)
+{
+#define MT7921_FILTER_FCSFAIL    BIT(2)
+#define MT7921_FILTER_CONTROL    BIT(5)
+#define MT7921_FILTER_OTHER_BSS  BIT(6)
+#define MT7921_FILTER_ENABLE     BIT(31)
+
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	u32 flags = MT7921_FILTER_ENABLE;
+
+#define MT7921_FILTER(_fif, _type) do {			\
+		if (*total_flags & (_fif))		\
+			flags |= MT7921_FILTER_##_type;	\
+	} while (0)
+
+	MT7921_FILTER(FIF_FCSFAIL, FCSFAIL);
+	MT7921_FILTER(FIF_CONTROL, CONTROL);
+	MT7921_FILTER(FIF_OTHER_BSS, OTHER_BSS);
+
+	mt7921_mutex_acquire(dev);
+	mt7921_mcu_set_rxfilter(dev, flags, 0, 0);
+	mt7921_mutex_release(dev);
+
+	*total_flags &= (FIF_OTHER_BSS | FIF_FCSFAIL | FIF_CONTROL);
+}
+
+static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_bss_conf *info,
+				    u64 changed)
+{
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+
+	mt7921_mutex_acquire(dev);
+
+	if (changed & BSS_CHANGED_ERP_SLOT) {
+		int slottime = info->use_short_slot ? 9 : 20;
+
+		if (slottime != phy->slottime) {
+			phy->slottime = slottime;
+			mt7921_mac_set_timing(phy);
+		}
+	}
+
+	if (changed & (BSS_CHANGED_BEACON |
+		       BSS_CHANGED_BEACON_ENABLED))
+		mt7921_mcu_uni_add_beacon_offload(dev, hw, vif,
+						  info->enable_beacon);
+
+	/* ensure that enable txcmd_mode after bss_info */
+	if (changed & (BSS_CHANGED_QOS | BSS_CHANGED_BEACON_ENABLED))
+		mt7921_mcu_set_tx(dev, vif);
+
+	if (changed & BSS_CHANGED_PS)
+		mt7921_mcu_uni_bss_ps(dev, vif);
+
+	if (changed & BSS_CHANGED_ASSOC) {
+		mt7921_mcu_sta_update(dev, NULL, vif, true,
+				      MT76_STA_INFO_STATE_ASSOC);
+		mt7921_mcu_set_beacon_filter(dev, vif, vif->cfg.assoc);
+	}
+
+	if (changed & BSS_CHANGED_ARP_FILTER) {
+		struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+
+		mt76_connac_mcu_update_arp_filter(&dev->mt76, &mvif->mt76,
+						  info);
+	}
+
+	mt7921_mutex_release(dev);
+}
+
+int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	int ret, idx;
+
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7921_WTBL_STA - 1);
+	if (idx < 0)
+		return -ENOSPC;
+
+	INIT_LIST_HEAD(&msta->wcid.poll_list);
+	msta->vif = mvif;
+	msta->wcid.sta = 1;
+	msta->wcid.idx = idx;
+	msta->wcid.phy_idx = mvif->mt76.band_idx;
+	msta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
+	msta->last_txs = jiffies;
+
+	ret = mt76_connac_pm_wake(&dev->mphy, &dev->pm);
+	if (ret)
+		return ret;
+
+	if (vif->type == NL80211_IFTYPE_STATION)
+		mvif->wep_sta = msta;
+
+	mt7921_mac_wtbl_update(dev, idx,
+			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+
+	ret = mt7921_mcu_sta_update(dev, sta, vif, true,
+				    MT76_STA_INFO_STATE_NONE);
+	if (ret)
+		return ret;
+
+	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt7921_mac_sta_add);
+
+void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			  struct ieee80211_sta *sta)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+
+	mt7921_mutex_acquire(dev);
+
+	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
+		mt76_connac_mcu_uni_add_bss(&dev->mphy, vif, &mvif->sta.wcid,
+					    true, mvif->ctx);
+
+	ewma_avg_signal_init(&msta->avg_ack_signal);
+
+	mt7921_mac_wtbl_update(dev, msta->wcid.idx,
+			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+	memset(msta->airtime_ac, 0, sizeof(msta->airtime_ac));
+
+	mt7921_mcu_sta_update(dev, sta, vif, true, MT76_STA_INFO_STATE_ASSOC);
+
+	mt7921_mutex_release(dev);
+}
+EXPORT_SYMBOL_GPL(mt7921_mac_sta_assoc);
+
+void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+
+	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->wcid);
+	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
+
+	mt7921_mcu_sta_update(dev, sta, vif, false, MT76_STA_INFO_STATE_NONE);
+	mt7921_mac_wtbl_update(dev, msta->wcid.idx,
+			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+
+	if (vif->type == NL80211_IFTYPE_STATION) {
+		struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+
+		mvif->wep_sta = NULL;
+		ewma_rssi_init(&mvif->rssi);
+		if (!sta->tdls)
+			mt76_connac_mcu_uni_add_bss(&dev->mphy, vif,
+						    &mvif->sta.wcid, false,
+						    mvif->ctx);
+	}
+
+	spin_lock_bh(&dev->mt76.sta_poll_lock);
+	if (!list_empty(&msta->wcid.poll_list))
+		list_del_init(&msta->wcid.poll_list);
+	spin_unlock_bh(&dev->mt76.sta_poll_lock);
+
+	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
+}
+EXPORT_SYMBOL_GPL(mt7921_mac_sta_remove);
+
+void mt7921_tx_worker(struct mt76_worker *w)
+{
+	struct mt7921_dev *dev = container_of(w, struct mt7921_dev,
+					      mt76.tx_worker);
+
+	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm)) {
+		queue_work(dev->mt76.wq, &dev->pm.wake_work);
+		return;
+	}
+
+	mt76_txq_schedule_all(&dev->mphy);
+	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
+}
+
+static void mt7921_tx(struct ieee80211_hw *hw,
+		      struct ieee80211_tx_control *control,
+		      struct sk_buff *skb)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt76_phy *mphy = hw->priv;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_vif *vif = info->control.vif;
+	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
+	int qid;
+
+	if (control->sta) {
+		struct mt7921_sta *sta;
+
+		sta = (struct mt7921_sta *)control->sta->drv_priv;
+		wcid = &sta->wcid;
+	}
+
+	if (vif && !control->sta) {
+		struct mt7921_vif *mvif;
+
+		mvif = (struct mt7921_vif *)vif->drv_priv;
+		wcid = &mvif->sta.wcid;
+	}
+
+	if (mt76_connac_pm_ref(mphy, &dev->pm)) {
+		mt76_tx(mphy, control->sta, wcid, skb);
+		mt76_connac_pm_unref(mphy, &dev->pm);
+		return;
+	}
+
+	qid = skb_get_queue_mapping(skb);
+	if (qid >= MT_TXQ_PSD) {
+		qid = IEEE80211_AC_BE;
+		skb_set_queue_mapping(skb, qid);
+	}
+
+	mt76_connac_pm_queue_skb(hw, &dev->pm, wcid, skb);
+}
+
+static int mt7921_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+
+	mt7921_mutex_acquire(dev);
+	mt76_connac_mcu_set_rts_thresh(&dev->mt76, val, 0);
+	mt7921_mutex_release(dev);
+
+	return 0;
+}
+
+static int
+mt7921_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		    struct ieee80211_ampdu_params *params)
+{
+	enum ieee80211_ampdu_mlme_action action = params->action;
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct ieee80211_sta *sta = params->sta;
+	struct ieee80211_txq *txq = sta->txq[params->tid];
+	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+	u16 tid = params->tid;
+	u16 ssn = params->ssn;
+	struct mt76_txq *mtxq;
+	int ret = 0;
+
+	if (!txq)
+		return -EINVAL;
+
+	mtxq = (struct mt76_txq *)txq->drv_priv;
+
+	mt7921_mutex_acquire(dev);
+	switch (action) {
+	case IEEE80211_AMPDU_RX_START:
+		mt76_rx_aggr_start(&dev->mt76, &msta->wcid, tid, ssn,
+				   params->buf_size);
+		mt7921_mcu_uni_rx_ba(dev, params, true);
+		break;
+	case IEEE80211_AMPDU_RX_STOP:
+		mt76_rx_aggr_stop(&dev->mt76, &msta->wcid, tid);
+		mt7921_mcu_uni_rx_ba(dev, params, false);
+		break;
+	case IEEE80211_AMPDU_TX_OPERATIONAL:
+		mtxq->aggr = true;
+		mtxq->send_bar = false;
+		mt7921_mcu_uni_tx_ba(dev, params, true);
+		break;
+	case IEEE80211_AMPDU_TX_STOP_FLUSH:
+	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
+		mtxq->aggr = false;
+		clear_bit(tid, &msta->wcid.ampdu_state);
+		mt7921_mcu_uni_tx_ba(dev, params, false);
+		break;
+	case IEEE80211_AMPDU_TX_START:
+		set_bit(tid, &msta->wcid.ampdu_state);
+		ret = IEEE80211_AMPDU_TX_START_IMMEDIATE;
+		break;
+	case IEEE80211_AMPDU_TX_STOP_CONT:
+		mtxq->aggr = false;
+		clear_bit(tid, &msta->wcid.ampdu_state);
+		mt7921_mcu_uni_tx_ba(dev, params, false);
+		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
+		break;
+	}
+	mt7921_mutex_release(dev);
+
+	return ret;
+}
+
+static int mt7921_sta_state(struct ieee80211_hw *hw,
+			    struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta,
+			    enum ieee80211_sta_state old_state,
+			    enum ieee80211_sta_state new_state)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+
+	if (dev->pm.ds_enable) {
+		mt7921_mutex_acquire(dev);
+		mt76_connac_sta_state_dp(&dev->mt76, old_state, new_state);
+		mt7921_mutex_release(dev);
+	}
+
+	return mt76_sta_state(hw, vif, sta, old_state, new_state);
+}
+
+static int
+mt7921_get_stats(struct ieee80211_hw *hw,
+		 struct ieee80211_low_level_stats *stats)
+{
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt76_mib_stats *mib = &phy->mib;
+
+	mt7921_mutex_acquire(phy->dev);
+
+	stats->dot11RTSSuccessCount = mib->rts_cnt;
+	stats->dot11RTSFailureCount = mib->rts_retries_cnt;
+	stats->dot11FCSErrorCount = mib->fcs_err_cnt;
+	stats->dot11ACKFailureCount = mib->ack_fail_cnt;
+
+	mt7921_mutex_release(phy->dev);
+
+	return 0;
+}
+
+static const char mt7921_gstrings_stats[][ETH_GSTRING_LEN] = {
+	/* tx counters */
+	"tx_ampdu_cnt",
+	"tx_mpdu_attempts",
+	"tx_mpdu_success",
+	"tx_pkt_ebf_cnt",
+	"tx_pkt_ibf_cnt",
+	"tx_ampdu_len:0-1",
+	"tx_ampdu_len:2-10",
+	"tx_ampdu_len:11-19",
+	"tx_ampdu_len:20-28",
+	"tx_ampdu_len:29-37",
+	"tx_ampdu_len:38-46",
+	"tx_ampdu_len:47-55",
+	"tx_ampdu_len:56-79",
+	"tx_ampdu_len:80-103",
+	"tx_ampdu_len:104-127",
+	"tx_ampdu_len:128-151",
+	"tx_ampdu_len:152-175",
+	"tx_ampdu_len:176-199",
+	"tx_ampdu_len:200-223",
+	"tx_ampdu_len:224-247",
+	"ba_miss_count",
+	"tx_beamformer_ppdu_iBF",
+	"tx_beamformer_ppdu_eBF",
+	"tx_beamformer_rx_feedback_all",
+	"tx_beamformer_rx_feedback_he",
+	"tx_beamformer_rx_feedback_vht",
+	"tx_beamformer_rx_feedback_ht",
+	"tx_msdu_pack_1",
+	"tx_msdu_pack_2",
+	"tx_msdu_pack_3",
+	"tx_msdu_pack_4",
+	"tx_msdu_pack_5",
+	"tx_msdu_pack_6",
+	"tx_msdu_pack_7",
+	"tx_msdu_pack_8",
+	/* rx counters */
+	"rx_mpdu_cnt",
+	"rx_ampdu_cnt",
+	"rx_ampdu_bytes_cnt",
+	"rx_ba_cnt",
+	/* per vif counters */
+	"v_tx_mode_cck",
+	"v_tx_mode_ofdm",
+	"v_tx_mode_ht",
+	"v_tx_mode_ht_gf",
+	"v_tx_mode_vht",
+	"v_tx_mode_he_su",
+	"v_tx_mode_he_ext_su",
+	"v_tx_mode_he_tb",
+	"v_tx_mode_he_mu",
+	"v_tx_bw_20",
+	"v_tx_bw_40",
+	"v_tx_bw_80",
+	"v_tx_bw_160",
+	"v_tx_mcs_0",
+	"v_tx_mcs_1",
+	"v_tx_mcs_2",
+	"v_tx_mcs_3",
+	"v_tx_mcs_4",
+	"v_tx_mcs_5",
+	"v_tx_mcs_6",
+	"v_tx_mcs_7",
+	"v_tx_mcs_8",
+	"v_tx_mcs_9",
+	"v_tx_mcs_10",
+	"v_tx_mcs_11",
+	"v_tx_nss_1",
+	"v_tx_nss_2",
+	"v_tx_nss_3",
+	"v_tx_nss_4",
+};
+
+static void
+mt7921_get_et_strings(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		      u32 sset, u8 *data)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+
+	if (sset != ETH_SS_STATS)
+		return;
+
+	memcpy(data, *mt7921_gstrings_stats, sizeof(mt7921_gstrings_stats));
+
+	if (mt76_is_sdio(&dev->mt76))
+		return;
+
+	data += sizeof(mt7921_gstrings_stats);
+	page_pool_ethtool_stats_get_strings(data);
+}
+
+static int
+mt7921_get_et_sset_count(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			 int sset)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+
+	if (sset != ETH_SS_STATS)
+		return 0;
+
+	if (mt76_is_sdio(&dev->mt76))
+		return ARRAY_SIZE(mt7921_gstrings_stats);
+
+	return ARRAY_SIZE(mt7921_gstrings_stats) +
+	       page_pool_ethtool_stats_get_count();
+}
+
+static void
+mt7921_ethtool_worker(void *wi_data, struct ieee80211_sta *sta)
+{
+	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+	struct mt76_ethtool_worker_info *wi = wi_data;
+
+	if (msta->vif->mt76.idx != wi->idx)
+		return;
+
+	mt76_ethtool_worker(wi, &msta->wcid.stats, false);
+}
+
+static
+void mt7921_get_et_stats(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			 struct ethtool_stats *stats, u64 *data)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	int stats_size = ARRAY_SIZE(mt7921_gstrings_stats);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt7921_dev *dev = phy->dev;
+	struct mt76_mib_stats *mib = &phy->mib;
+	struct mt76_ethtool_worker_info wi = {
+		.data = data,
+		.idx = mvif->mt76.idx,
+	};
+	int i, ei = 0;
+
+	mt7921_mutex_acquire(dev);
+
+	mt7921_mac_update_mib_stats(phy);
+
+	data[ei++] = mib->tx_ampdu_cnt;
+	data[ei++] = mib->tx_mpdu_attempts_cnt;
+	data[ei++] = mib->tx_mpdu_success_cnt;
+	data[ei++] = mib->tx_pkt_ebf_cnt;
+	data[ei++] = mib->tx_pkt_ibf_cnt;
+
+	/* Tx ampdu stat */
+	for (i = 0; i < 15; i++)
+		data[ei++] = phy->mt76->aggr_stats[i];
+
+	data[ei++] = phy->mib.ba_miss_cnt;
+
+	/* Tx Beamformer monitor */
+	data[ei++] = mib->tx_bf_ibf_ppdu_cnt;
+	data[ei++] = mib->tx_bf_ebf_ppdu_cnt;
+
+	/* Tx Beamformer Rx feedback monitor */
+	data[ei++] = mib->tx_bf_rx_fb_all_cnt;
+	data[ei++] = mib->tx_bf_rx_fb_he_cnt;
+	data[ei++] = mib->tx_bf_rx_fb_vht_cnt;
+	data[ei++] = mib->tx_bf_rx_fb_ht_cnt;
+
+	/* Tx amsdu info (pack-count histogram) */
+	for (i = 0; i < ARRAY_SIZE(mib->tx_amsdu); i++)
+		data[ei++] = mib->tx_amsdu[i];
+
+	/* rx counters */
+	data[ei++] = mib->rx_mpdu_cnt;
+	data[ei++] = mib->rx_ampdu_cnt;
+	data[ei++] = mib->rx_ampdu_bytes_cnt;
+	data[ei++] = mib->rx_ba_cnt;
+
+	/* Add values for all stations owned by this vif */
+	wi.initial_stat_idx = ei;
+	ieee80211_iterate_stations_atomic(hw, mt7921_ethtool_worker, &wi);
+
+	mt7921_mutex_release(dev);
+
+	if (!wi.sta_count)
+		return;
+
+	ei += wi.worker_stat_count;
+
+	if (!mt76_is_sdio(&dev->mt76)) {
+		mt76_ethtool_page_pool_stats(&dev->mt76, &data[ei], &ei);
+		stats_size += page_pool_ethtool_stats_get_count();
+	}
+
+	if (ei != stats_size)
+		dev_err(dev->mt76.dev, "ei: %d  SSTATS_LEN: %d", ei, stats_size);
+}
+
+static u64
+mt7921_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	u8 omac_idx = mvif->mt76.omac_idx;
+	union {
+		u64 t64;
+		u32 t32[2];
+	} tsf;
+	u16 n;
+
+	mt7921_mutex_acquire(dev);
+
+	n = omac_idx > HW_BSSID_MAX ? HW_BSSID_0 : omac_idx;
+	/* TSF software read */
+	mt76_set(dev, MT_LPON_TCR(0, n), MT_LPON_TCR_SW_MODE);
+	tsf.t32[0] = mt76_rr(dev, MT_LPON_UTTR0(0));
+	tsf.t32[1] = mt76_rr(dev, MT_LPON_UTTR1(0));
+
+	mt7921_mutex_release(dev);
+
+	return tsf.t64;
+}
+
+static void
+mt7921_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+	       u64 timestamp)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	u8 omac_idx = mvif->mt76.omac_idx;
+	union {
+		u64 t64;
+		u32 t32[2];
+	} tsf = { .t64 = timestamp, };
+	u16 n;
+
+	mt7921_mutex_acquire(dev);
+
+	n = omac_idx > HW_BSSID_MAX ? HW_BSSID_0 : omac_idx;
+	mt76_wr(dev, MT_LPON_UTTR0(0), tsf.t32[0]);
+	mt76_wr(dev, MT_LPON_UTTR1(0), tsf.t32[1]);
+	/* TSF software overwrite */
+	mt76_set(dev, MT_LPON_TCR(0, n), MT_LPON_TCR_SW_WRITE);
+
+	mt7921_mutex_release(dev);
+}
+
+static void
+mt7921_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
+{
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt7921_dev *dev = phy->dev;
+
+	mt7921_mutex_acquire(dev);
+	phy->coverage_class = max_t(s16, coverage_class, 0);
+	mt7921_mac_set_timing(phy);
+	mt7921_mutex_release(dev);
+}
+
+void mt7921_scan_work(struct work_struct *work)
+{
+	struct mt7921_phy *phy;
+
+	phy = (struct mt7921_phy *)container_of(work, struct mt7921_phy,
+						scan_work.work);
+
+	while (true) {
+		struct mt76_connac2_mcu_rxd *rxd;
+		struct sk_buff *skb;
+
+		spin_lock_bh(&phy->dev->mt76.lock);
+		skb = __skb_dequeue(&phy->scan_event_list);
+		spin_unlock_bh(&phy->dev->mt76.lock);
+
+		if (!skb)
+			break;
+
+		rxd = (struct mt76_connac2_mcu_rxd *)skb->data;
+		if (rxd->eid == MCU_EVENT_SCHED_SCAN_DONE) {
+			ieee80211_sched_scan_results(phy->mt76->hw);
+		} else if (test_and_clear_bit(MT76_HW_SCANNING,
+					      &phy->mt76->state)) {
+			struct cfg80211_scan_info info = {
+				.aborted = false,
+			};
+
+			ieee80211_scan_completed(phy->mt76->hw, &info);
+		}
+		dev_kfree_skb(skb);
+	}
+}
+
+static int
+mt7921_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+	       struct ieee80211_scan_request *req)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt76_phy *mphy = hw->priv;
+	int err;
+
+	mt7921_mutex_acquire(dev);
+	err = mt76_connac_mcu_hw_scan(mphy, vif, req);
+	mt7921_mutex_release(dev);
+
+	return err;
+}
+
+static void
+mt7921_cancel_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt76_phy *mphy = hw->priv;
+
+	mt7921_mutex_acquire(dev);
+	mt76_connac_mcu_cancel_hw_scan(mphy, vif);
+	mt7921_mutex_release(dev);
+}
+
+static int
+mt7921_start_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			struct cfg80211_sched_scan_request *req,
+			struct ieee80211_scan_ies *ies)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt76_phy *mphy = hw->priv;
+	int err;
+
+	mt7921_mutex_acquire(dev);
+
+	err = mt76_connac_mcu_sched_scan_req(mphy, vif, req);
+	if (err < 0)
+		goto out;
+
+	err = mt76_connac_mcu_sched_scan_enable(mphy, vif, true);
+out:
+	mt7921_mutex_release(dev);
+
+	return err;
+}
+
+static int
+mt7921_stop_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt76_phy *mphy = hw->priv;
+	int err;
+
+	mt7921_mutex_acquire(dev);
+	err = mt76_connac_mcu_sched_scan_enable(mphy, vif, false);
+	mt7921_mutex_release(dev);
+
+	return err;
+}
+
+static int
+mt7921_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	int max_nss = hweight8(hw->wiphy->available_antennas_tx);
+
+	if (!tx_ant || tx_ant != rx_ant || ffs(tx_ant) > max_nss)
+		return -EINVAL;
+
+	if ((BIT(hweight8(tx_ant)) - 1) != tx_ant)
+		return -EINVAL;
+
+	mt7921_mutex_acquire(dev);
+
+	phy->mt76->antenna_mask = tx_ant;
+	phy->mt76->chainmask = tx_ant;
+
+	mt76_set_stream_caps(phy->mt76, true);
+	mt7921_set_stream_he_caps(phy);
+
+	mt7921_mutex_release(dev);
+
+	return 0;
+}
+
+static void mt7921_sta_statistics(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_sta *sta,
+				  struct station_info *sinfo)
+{
+	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+	struct rate_info *txrate = &msta->wcid.rate;
+
+	if (!txrate->legacy && !txrate->flags)
+		return;
+
+	if (txrate->legacy) {
+		sinfo->txrate.legacy = txrate->legacy;
+	} else {
+		sinfo->txrate.mcs = txrate->mcs;
+		sinfo->txrate.nss = txrate->nss;
+		sinfo->txrate.bw = txrate->bw;
+		sinfo->txrate.he_gi = txrate->he_gi;
+		sinfo->txrate.he_dcm = txrate->he_dcm;
+		sinfo->txrate.he_ru_alloc = txrate->he_ru_alloc;
+	}
+	sinfo->tx_failed = msta->wcid.stats.tx_failed;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
+
+	sinfo->tx_retries = msta->wcid.stats.tx_retries;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
+
+	sinfo->txrate.flags = txrate->flags;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+
+	sinfo->ack_signal = (s8)msta->ack_signal;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL);
+
+	sinfo->avg_ack_signal = -(s8)ewma_avg_signal_read(&msta->avg_ack_signal);
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL_AVG);
+}
+
+#ifdef CONFIG_PM
+static int mt7921_suspend(struct ieee80211_hw *hw,
+			  struct cfg80211_wowlan *wowlan)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+
+	cancel_delayed_work_sync(&phy->scan_work);
+	cancel_delayed_work_sync(&phy->mt76->mac_work);
+
+	cancel_delayed_work_sync(&dev->pm.ps_work);
+	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
+
+	mt7921_mutex_acquire(dev);
+
+	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
+	ieee80211_iterate_active_interfaces(hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7921_mcu_set_suspend_iter,
+					    &dev->mphy);
+
+	mt7921_mutex_release(dev);
+
+	return 0;
+}
+
+static int mt7921_resume(struct ieee80211_hw *hw)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+
+	mt7921_mutex_acquire(dev);
+
+	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
+	ieee80211_iterate_active_interfaces(hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt76_connac_mcu_set_suspend_iter,
+					    &dev->mphy);
+
+	ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
+				     MT7921_WATCHDOG_TIME);
+
+	mt7921_mutex_release(dev);
+
+	return 0;
+}
+
+static void mt7921_set_wakeup(struct ieee80211_hw *hw, bool enabled)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt76_dev *mdev = &dev->mt76;
+
+	device_set_wakeup_enable(mdev->dev, enabled);
+}
+
+static void mt7921_set_rekey_data(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct cfg80211_gtk_rekey_data *data)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+
+	mt7921_mutex_acquire(dev);
+	mt76_connac_mcu_update_gtk_rekey(hw, vif, data);
+	mt7921_mutex_release(dev);
+}
+#endif /* CONFIG_PM */
+
+static void mt7921_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			 u32 queues, bool drop)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+
+	wait_event_timeout(dev->mt76.tx_wait, !mt76_has_tx_pending(&dev->mphy),
+			   HZ / 2);
+}
+
+static void mt7921_sta_set_decap_offload(struct ieee80211_hw *hw,
+					 struct ieee80211_vif *vif,
+					 struct ieee80211_sta *sta,
+					 bool enabled)
+{
+	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+
+	mt7921_mutex_acquire(dev);
+
+	if (enabled)
+		set_bit(MT_WCID_FLAG_HDR_TRANS, &msta->wcid.flags);
+	else
+		clear_bit(MT_WCID_FLAG_HDR_TRANS, &msta->wcid.flags);
+
+	mt76_connac_mcu_sta_update_hdr_trans(&dev->mt76, vif, &msta->wcid,
+					     MCU_UNI_CMD(STA_REC_UPDATE));
+
+	mt7921_mutex_release(dev);
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+static void mt7921_ipv6_addr_change(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    struct inet6_dev *idev)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_dev *dev = mvif->phy->dev;
+	struct inet6_ifaddr *ifa;
+	struct in6_addr ns_addrs[IEEE80211_BSS_ARP_ADDR_LIST_LEN];
+	struct sk_buff *skb;
+	u8 i, idx = 0;
+
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt76_connac_arpns_tlv arpns;
+	} req_hdr = {
+		.hdr = {
+			.bss_idx = mvif->mt76.idx,
+		},
+		.arpns = {
+			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_ND),
+			.mode = 2,  /* update */
+			.option = 1, /* update only */
+		},
+	};
+
+	read_lock_bh(&idev->lock);
+	list_for_each_entry(ifa, &idev->addr_list, if_list) {
+		if (ifa->flags & IFA_F_TENTATIVE)
+			continue;
+		ns_addrs[idx] = ifa->addr;
+		if (++idx >= IEEE80211_BSS_ARP_ADDR_LIST_LEN)
+			break;
+	}
+	read_unlock_bh(&idev->lock);
+
+	if (!idx)
+		return;
+
+	req_hdr.arpns.ips_num = idx;
+	req_hdr.arpns.len = cpu_to_le16(sizeof(struct mt76_connac_arpns_tlv)
+					+ idx * sizeof(struct in6_addr));
+	skb = __mt76_mcu_msg_alloc(&dev->mt76, &req_hdr,
+			sizeof(req_hdr) + idx * sizeof(struct in6_addr),
+			sizeof(req_hdr), GFP_ATOMIC);
+	if (!skb)
+		return;
+
+	for (i = 0; i < idx; i++)
+		skb_put_data(skb, &ns_addrs[i].in6_u, sizeof(struct in6_addr));
+
+	skb_queue_tail(&dev->ipv6_ns_list, skb);
+
+	ieee80211_queue_work(dev->mt76.hw, &dev->ipv6_ns_work);
+}
+#endif
+
+int mt7921_set_tx_sar_pwr(struct ieee80211_hw *hw,
+			  const struct cfg80211_sar_specs *sar)
+{
+	struct mt76_phy *mphy = hw->priv;
+	int err;
+
+	if (sar) {
+		err = mt76_init_sar_power(hw, sar);
+		if (err)
+			return err;
+	}
+
+	mt7921_init_acpi_sar_power(mt7921_hw_phy(hw), !sar);
+
+	err = mt76_connac_mcu_set_rate_txpower(mphy);
+
+	return err;
+}
+
+static int mt7921_set_sar_specs(struct ieee80211_hw *hw,
+				const struct cfg80211_sar_specs *sar)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	int err;
+
+	mt7921_mutex_acquire(dev);
+	err = mt7921_mcu_set_clc(dev, dev->mt76.alpha2,
+				 dev->country_ie_env);
+	if (err < 0)
+		goto out;
+
+	err = mt7921_set_tx_sar_pwr(hw, sar);
+out:
+	mt7921_mutex_release(dev);
+
+	return err;
+}
+
+static void
+mt7921_channel_switch_beacon(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif,
+			     struct cfg80211_chan_def *chandef)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+
+	mt7921_mutex_acquire(dev);
+	mt7921_mcu_uni_add_beacon_offload(dev, hw, vif, true);
+	mt7921_mutex_release(dev);
+}
+
+static int
+mt7921_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		struct ieee80211_bss_conf *link_conf)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	int err;
+
+	mt7921_mutex_acquire(dev);
+
+	err = mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid,
+					  true, mvif->ctx);
+	if (err)
+		goto out;
+
+	err = mt7921_mcu_set_bss_pm(dev, vif, true);
+	if (err)
+		goto out;
+
+	err = mt7921_mcu_sta_update(dev, NULL, vif, true,
+				    MT76_STA_INFO_STATE_NONE);
+out:
+	mt7921_mutex_release(dev);
+
+	return err;
+}
+
+static void
+mt7921_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+	       struct ieee80211_bss_conf *link_conf)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	int err;
+
+	mt7921_mutex_acquire(dev);
+
+	err = mt7921_mcu_set_bss_pm(dev, vif, false);
+	if (err)
+		goto out;
+
+	mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid, false,
+				    mvif->ctx);
+
+out:
+	mt7921_mutex_release(dev);
+}
+
+static int
+mt7921_add_chanctx(struct ieee80211_hw *hw,
+		   struct ieee80211_chanctx_conf *ctx)
+{
+	return 0;
+}
+
+static void
+mt7921_remove_chanctx(struct ieee80211_hw *hw,
+		      struct ieee80211_chanctx_conf *ctx)
+{
+}
+
+static void mt7921_ctx_iter(void *priv, u8 *mac,
+			    struct ieee80211_vif *vif)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct ieee80211_chanctx_conf *ctx = priv;
+
+	if (ctx != mvif->ctx)
+		return;
+
+	if (vif->type == NL80211_IFTYPE_MONITOR)
+		mt7921_mcu_config_sniffer(mvif, ctx);
+	else
+		mt76_connac_mcu_uni_set_chctx(mvif->phy->mt76, &mvif->mt76, ctx);
+}
+
+static void
+mt7921_change_chanctx(struct ieee80211_hw *hw,
+		      struct ieee80211_chanctx_conf *ctx,
+		      u32 changed)
+{
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+
+	mt7921_mutex_acquire(phy->dev);
+	ieee80211_iterate_active_interfaces(phy->mt76->hw,
+					    IEEE80211_IFACE_ITER_ACTIVE,
+					    mt7921_ctx_iter, ctx);
+	mt7921_mutex_release(phy->dev);
+}
+
+static int
+mt7921_assign_vif_chanctx(struct ieee80211_hw *hw,
+			  struct ieee80211_vif *vif,
+			  struct ieee80211_bss_conf *link_conf,
+			  struct ieee80211_chanctx_conf *ctx)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+
+	mutex_lock(&dev->mt76.mutex);
+	mvif->ctx = ctx;
+	mutex_unlock(&dev->mt76.mutex);
+
+	return 0;
+}
+
+static void
+mt7921_unassign_vif_chanctx(struct ieee80211_hw *hw,
+			    struct ieee80211_vif *vif,
+			    struct ieee80211_bss_conf *link_conf,
+			    struct ieee80211_chanctx_conf *ctx)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+
+	mutex_lock(&dev->mt76.mutex);
+	mvif->ctx = NULL;
+	mutex_unlock(&dev->mt76.mutex);
+}
+
+static void mt7921_mgd_prepare_tx(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_prep_tx_info *info)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	u16 duration = info->duration ? info->duration :
+		       jiffies_to_msecs(HZ);
+
+	mt7921_mutex_acquire(dev);
+	mt7921_set_roc(mvif->phy, mvif, mvif->ctx->def.chan, duration,
+		       MT7921_ROC_REQ_JOIN);
+	mt7921_mutex_release(dev);
+}
+
+static void mt7921_mgd_complete_tx(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_prep_tx_info *info)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+
+	mt7921_abort_roc(mvif->phy, mvif);
+}
+
+const struct ieee80211_ops mt7921_ops = {
+	.tx = mt7921_tx,
+	.start = mt7921_start,
+	.stop = mt7921_stop,
+	.add_interface = mt7921_add_interface,
+	.remove_interface = mt7921_remove_interface,
+	.config = mt7921_config,
+	.conf_tx = mt7921_conf_tx,
+	.configure_filter = mt7921_configure_filter,
+	.bss_info_changed = mt7921_bss_info_changed,
+	.start_ap = mt7921_start_ap,
+	.stop_ap = mt7921_stop_ap,
+	.sta_state = mt7921_sta_state,
+	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
+	.set_key = mt7921_set_key,
+	.sta_set_decap_offload = mt7921_sta_set_decap_offload,
+#if IS_ENABLED(CONFIG_IPV6)
+	.ipv6_addr_change = mt7921_ipv6_addr_change,
+#endif /* CONFIG_IPV6 */
+	.ampdu_action = mt7921_ampdu_action,
+	.set_rts_threshold = mt7921_set_rts_threshold,
+	.wake_tx_queue = mt76_wake_tx_queue,
+	.release_buffered_frames = mt76_release_buffered_frames,
+	.channel_switch_beacon = mt7921_channel_switch_beacon,
+	.get_txpower = mt76_get_txpower,
+	.get_stats = mt7921_get_stats,
+	.get_et_sset_count = mt7921_get_et_sset_count,
+	.get_et_strings = mt7921_get_et_strings,
+	.get_et_stats = mt7921_get_et_stats,
+	.get_tsf = mt7921_get_tsf,
+	.set_tsf = mt7921_set_tsf,
+	.get_survey = mt76_get_survey,
+	.get_antenna = mt76_get_antenna,
+	.set_antenna = mt7921_set_antenna,
+	.set_coverage_class = mt7921_set_coverage_class,
+	.hw_scan = mt7921_hw_scan,
+	.cancel_hw_scan = mt7921_cancel_hw_scan,
+	.sta_statistics = mt7921_sta_statistics,
+	.sched_scan_start = mt7921_start_sched_scan,
+	.sched_scan_stop = mt7921_stop_sched_scan,
+	CFG80211_TESTMODE_CMD(mt7921_testmode_cmd)
+	CFG80211_TESTMODE_DUMP(mt7921_testmode_dump)
+#ifdef CONFIG_PM
+	.suspend = mt7921_suspend,
+	.resume = mt7921_resume,
+	.set_wakeup = mt7921_set_wakeup,
+	.set_rekey_data = mt7921_set_rekey_data,
+#endif /* CONFIG_PM */
+	.flush = mt7921_flush,
+	.set_sar_specs = mt7921_set_sar_specs,
+	.remain_on_channel = mt7921_remain_on_channel,
+	.cancel_remain_on_channel = mt7921_cancel_remain_on_channel,
+	.add_chanctx = mt7921_add_chanctx,
+	.remove_chanctx = mt7921_remove_chanctx,
+	.change_chanctx = mt7921_change_chanctx,
+	.assign_vif_chanctx = mt7921_assign_vif_chanctx,
+	.unassign_vif_chanctx = mt7921_unassign_vif_chanctx,
+	.mgd_prepare_tx = mt7921_mgd_prepare_tx,
+	.mgd_complete_tx = mt7921_mgd_complete_tx,
+};
+EXPORT_SYMBOL_GPL(mt7921_ops);
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c.orig b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c.orig
new file mode 100644
index 000000000000..c5e7ad06f877
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c.orig
@@ -0,0 +1,1357 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#include <linux/fs.h>
+#include <linux/firmware.h>
+#include "mt7921.h"
+#include "mt7921_trace.h"
+#include "eeprom.h"
+#include "mcu.h"
+#include "mac.h"
+
+#define MT_STA_BFER			BIT(0)
+#define MT_STA_BFEE			BIT(1)
+
+static bool mt7921_disable_clc;
+module_param_named(disable_clc, mt7921_disable_clc, bool, 0644);
+MODULE_PARM_DESC(disable_clc, "disable CLC support");
+
+static int
+mt7921_mcu_parse_eeprom(struct mt76_dev *dev, struct sk_buff *skb)
+{
+	struct mt7921_mcu_eeprom_info *res;
+	u8 *buf;
+
+	if (!skb)
+		return -EINVAL;
+
+	skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
+
+	res = (struct mt7921_mcu_eeprom_info *)skb->data;
+	buf = dev->eeprom.data + le32_to_cpu(res->addr);
+	memcpy(buf, res->data, 16);
+
+	return 0;
+}
+
+int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
+			      struct sk_buff *skb, int seq)
+{
+	int mcu_cmd = FIELD_GET(__MCU_CMD_FIELD_ID, cmd);
+	struct mt76_connac2_mcu_rxd *rxd;
+	int ret = 0;
+
+	if (!skb) {
+		dev_err(mdev->dev, "Message %08x (seq %d) timeout\n",
+			cmd, seq);
+		mt7921_reset(mdev);
+
+		return -ETIMEDOUT;
+	}
+
+	rxd = (struct mt76_connac2_mcu_rxd *)skb->data;
+	if (seq != rxd->seq)
+		return -EAGAIN;
+
+	if (cmd == MCU_CMD(PATCH_SEM_CONTROL) ||
+	    cmd == MCU_CMD(PATCH_FINISH_REQ)) {
+		skb_pull(skb, sizeof(*rxd) - 4);
+		ret = *skb->data;
+	} else if (cmd == MCU_EXT_CMD(THERMAL_CTRL)) {
+		skb_pull(skb, sizeof(*rxd) + 4);
+		ret = le32_to_cpu(*(__le32 *)skb->data);
+	} else if (cmd == MCU_EXT_CMD(EFUSE_ACCESS)) {
+		ret = mt7921_mcu_parse_eeprom(mdev, skb);
+	} else if (cmd == MCU_UNI_CMD(DEV_INFO_UPDATE) ||
+		   cmd == MCU_UNI_CMD(BSS_INFO_UPDATE) ||
+		   cmd == MCU_UNI_CMD(STA_REC_UPDATE) ||
+		   cmd == MCU_UNI_CMD(HIF_CTRL) ||
+		   cmd == MCU_UNI_CMD(OFFLOAD) ||
+		   cmd == MCU_UNI_CMD(SUSPEND)) {
+		struct mt7921_mcu_uni_event *event;
+
+		skb_pull(skb, sizeof(*rxd));
+		event = (struct mt7921_mcu_uni_event *)skb->data;
+		ret = le32_to_cpu(event->status);
+		/* skip invalid event */
+		if (mcu_cmd != event->cid)
+			ret = -EAGAIN;
+	} else if (cmd == MCU_CE_QUERY(REG_READ)) {
+		struct mt7921_mcu_reg_event *event;
+
+		skb_pull(skb, sizeof(*rxd));
+		event = (struct mt7921_mcu_reg_event *)skb->data;
+		ret = (int)le32_to_cpu(event->val);
+	} else {
+		skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt7921_mcu_parse_response);
+
+static int mt7921_mcu_read_eeprom(struct mt7921_dev *dev, u32 offset, u8 *val)
+{
+	struct mt7921_mcu_eeprom_info *res, req = {
+		.addr = cpu_to_le32(round_down(offset,
+				    MT7921_EEPROM_BLOCK_SIZE)),
+	};
+	struct sk_buff *skb;
+	int ret;
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_QUERY(EFUSE_ACCESS),
+					&req, sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	res = (struct mt7921_mcu_eeprom_info *)skb->data;
+	*val = res->data[offset % MT7921_EEPROM_BLOCK_SIZE];
+	dev_kfree_skb(skb);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+
+static int
+mt7921_mcu_set_ipv6_ns_filter(struct mt76_dev *dev,
+			      struct ieee80211_vif *vif, bool suspend)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt76_connac_arpns_tlv arpns;
+	} req = {
+		.hdr = {
+			.bss_idx = mvif->mt76.idx,
+		},
+		.arpns = {
+			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_ND),
+			.len = cpu_to_le16(sizeof(struct mt76_connac_arpns_tlv)),
+			.mode = suspend,
+		},
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_UNI_CMD_OFFLOAD, &req, sizeof(req),
+				 true);
+}
+
+void mt7921_mcu_set_suspend_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	if (IS_ENABLED(CONFIG_IPV6)) {
+		struct mt76_phy *phy = priv;
+
+		mt7921_mcu_set_ipv6_ns_filter(phy->dev, vif,
+					      !test_bit(MT76_STATE_RUNNING,
+					      &phy->state));
+	}
+
+	mt76_connac_mcu_set_suspend_iter(priv, mac, vif);
+}
+
+#endif /* CONFIG_PM */
+
+static void
+mt7921_mcu_uni_roc_event(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt7921_roc_grant_tlv *grant;
+	struct mt76_connac2_mcu_rxd *rxd;
+	int duration;
+
+	rxd = (struct mt76_connac2_mcu_rxd *)skb->data;
+	grant = (struct mt7921_roc_grant_tlv *)(rxd->tlv + 4);
+
+	/* should never happen */
+	WARN_ON_ONCE((le16_to_cpu(grant->tag) != UNI_EVENT_ROC_GRANT));
+
+	if (grant->reqtype == MT7921_ROC_REQ_ROC)
+		ieee80211_ready_on_channel(dev->mt76.phy.hw);
+
+	dev->phy.roc_grant = true;
+	wake_up(&dev->phy.roc_wait);
+	duration = le32_to_cpu(grant->max_interval);
+	mod_timer(&dev->phy.roc_timer,
+		  jiffies + msecs_to_jiffies(duration));
+}
+
+static void
+mt7921_mcu_scan_event(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt7921_phy *phy = (struct mt7921_phy *)mphy->priv;
+
+	spin_lock_bh(&dev->mt76.lock);
+	__skb_queue_tail(&phy->scan_event_list, skb);
+	spin_unlock_bh(&dev->mt76.lock);
+
+	ieee80211_queue_delayed_work(mphy->hw, &phy->scan_work,
+				     MT7921_HW_SCAN_TIMEOUT);
+}
+
+static void
+mt7921_mcu_connection_loss_iter(void *priv, u8 *mac,
+				struct ieee80211_vif *vif)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_connac_beacon_loss_event *event = priv;
+
+	if (mvif->idx != event->bss_idx)
+		return;
+
+	if (!(vif->driver_flags & IEEE80211_VIF_BEACON_FILTER) ||
+	    vif->type != NL80211_IFTYPE_STATION)
+		return;
+
+	ieee80211_connection_loss(vif);
+}
+
+static void
+mt7921_mcu_connection_loss_event(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt76_connac_beacon_loss_event *event;
+	struct mt76_phy *mphy = &dev->mt76.phy;
+
+	skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
+	event = (struct mt76_connac_beacon_loss_event *)skb->data;
+
+	ieee80211_iterate_active_interfaces_atomic(mphy->hw,
+					IEEE80211_IFACE_ITER_RESUME_ALL,
+					mt7921_mcu_connection_loss_iter, event);
+}
+
+static void
+mt7921_mcu_debug_msg_event(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt7921_debug_msg {
+		__le16 id;
+		u8 type;
+		u8 flag;
+		__le32 value;
+		__le16 len;
+		u8 content[512];
+	} __packed * msg;
+
+	skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
+	msg = (struct mt7921_debug_msg *)skb->data;
+
+	if (msg->type == 3) { /* fw log */
+		u16 len = min_t(u16, le16_to_cpu(msg->len), 512);
+		int i;
+
+		for (i = 0 ; i < len; i++) {
+			if (!msg->content[i])
+				msg->content[i] = ' ';
+		}
+		wiphy_info(mt76_hw(dev)->wiphy, "%.*s", len, msg->content);
+	}
+}
+
+static void
+mt7921_mcu_low_power_event(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt7921_mcu_lp_event {
+		u8 state;
+		u8 reserved[3];
+	} __packed * event;
+
+	skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
+	event = (struct mt7921_mcu_lp_event *)skb->data;
+
+	trace_lp_event(dev, event->state);
+}
+
+static void
+mt7921_mcu_tx_done_event(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt7921_mcu_tx_done_event *event;
+
+	skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
+	event = (struct mt7921_mcu_tx_done_event *)skb->data;
+
+	mt7921_mac_add_txs(dev, event->txs);
+}
+
+static void
+mt7921_mcu_rx_unsolicited_event(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt76_connac2_mcu_rxd *rxd;
+
+	rxd = (struct mt76_connac2_mcu_rxd *)skb->data;
+	switch (rxd->eid) {
+	case MCU_EVENT_BSS_BEACON_LOSS:
+		mt7921_mcu_connection_loss_event(dev, skb);
+		break;
+	case MCU_EVENT_SCHED_SCAN_DONE:
+	case MCU_EVENT_SCAN_DONE:
+		mt7921_mcu_scan_event(dev, skb);
+		return;
+	case MCU_EVENT_DBG_MSG:
+		mt7921_mcu_debug_msg_event(dev, skb);
+		break;
+	case MCU_EVENT_COREDUMP:
+		dev->fw_assert = true;
+		mt76_connac_mcu_coredump_event(&dev->mt76, skb,
+					       &dev->coredump);
+		return;
+	case MCU_EVENT_LP_INFO:
+		mt7921_mcu_low_power_event(dev, skb);
+		break;
+	case MCU_EVENT_TX_DONE:
+		mt7921_mcu_tx_done_event(dev, skb);
+		break;
+	default:
+		break;
+	}
+	dev_kfree_skb(skb);
+}
+
+static void
+mt7921_mcu_uni_rx_unsolicited_event(struct mt7921_dev *dev,
+				    struct sk_buff *skb)
+{
+	struct mt76_connac2_mcu_rxd *rxd;
+
+	rxd = (struct mt76_connac2_mcu_rxd *)skb->data;
+
+	switch (rxd->eid) {
+	case MCU_UNI_EVENT_ROC:
+		mt7921_mcu_uni_roc_event(dev, skb);
+		break;
+	default:
+		break;
+	}
+	dev_kfree_skb(skb);
+}
+
+void mt7921_mcu_rx_event(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt76_connac2_mcu_rxd *rxd;
+
+	if (skb_linearize(skb))
+		return;
+
+	rxd = (struct mt76_connac2_mcu_rxd *)skb->data;
+
+	if (rxd->option & MCU_UNI_CMD_UNSOLICITED_EVENT) {
+		mt7921_mcu_uni_rx_unsolicited_event(dev, skb);
+		return;
+	}
+
+	if (rxd->eid == 0x6) {
+		mt76_mcu_rx_event(&dev->mt76, skb);
+		return;
+	}
+
+	if (rxd->ext_eid == MCU_EXT_EVENT_RATE_REPORT ||
+	    rxd->eid == MCU_EVENT_BSS_BEACON_LOSS ||
+	    rxd->eid == MCU_EVENT_SCHED_SCAN_DONE ||
+	    rxd->eid == MCU_EVENT_SCAN_DONE ||
+	    rxd->eid == MCU_EVENT_TX_DONE ||
+	    rxd->eid == MCU_EVENT_DBG_MSG ||
+	    rxd->eid == MCU_EVENT_COREDUMP ||
+	    rxd->eid == MCU_EVENT_LP_INFO ||
+	    !rxd->seq)
+		mt7921_mcu_rx_unsolicited_event(dev, skb);
+	else
+		mt76_mcu_rx_event(&dev->mt76, skb);
+}
+
+/** starec & wtbl **/
+int mt7921_mcu_uni_tx_ba(struct mt7921_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool enable)
+{
+	struct mt7921_sta *msta = (struct mt7921_sta *)params->sta->drv_priv;
+
+	if (enable && !params->amsdu)
+		msta->wcid.amsdu = false;
+
+	return mt76_connac_mcu_sta_ba(&dev->mt76, &msta->vif->mt76, params,
+				      MCU_UNI_CMD(STA_REC_UPDATE),
+				      enable, true);
+}
+
+int mt7921_mcu_uni_rx_ba(struct mt7921_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool enable)
+{
+	struct mt7921_sta *msta = (struct mt7921_sta *)params->sta->drv_priv;
+
+	return mt76_connac_mcu_sta_ba(&dev->mt76, &msta->vif->mt76, params,
+				      MCU_UNI_CMD(STA_REC_UPDATE),
+				      enable, false);
+}
+
+static char *mt7921_patch_name(struct mt7921_dev *dev)
+{
+	char *ret;
+
+	if (is_mt7922(&dev->mt76))
+		ret = MT7922_ROM_PATCH;
+	else
+		ret = MT7921_ROM_PATCH;
+
+	return ret;
+}
+
+static char *mt7921_ram_name(struct mt7921_dev *dev)
+{
+	char *ret;
+
+	if (is_mt7922(&dev->mt76))
+		ret = MT7922_FIRMWARE_WM;
+	else
+		ret = MT7921_FIRMWARE_WM;
+
+	return ret;
+}
+
+static int mt7921_load_clc(struct mt7921_dev *dev, const char *fw_name)
+{
+	const struct mt76_connac2_fw_trailer *hdr;
+	const struct mt76_connac2_fw_region *region;
+	const struct mt7921_clc *clc;
+	struct mt76_dev *mdev = &dev->mt76;
+	struct mt7921_phy *phy = &dev->phy;
+	const struct firmware *fw;
+	int ret, i, len, offset = 0;
+	u8 *clc_base = NULL, hw_encap = 0;
+
+	if (mt7921_disable_clc ||
+	    mt76_is_usb(&dev->mt76))
+		return 0;
+
+	if (mt76_is_mmio(&dev->mt76)) {
+		ret = mt7921_mcu_read_eeprom(dev, MT_EE_HW_TYPE, &hw_encap);
+		if (ret)
+			return ret;
+		hw_encap = u8_get_bits(hw_encap, MT_EE_HW_TYPE_ENCAP);
+	}
+
+	ret = request_firmware(&fw, fw_name, mdev->dev);
+	if (ret)
+		return ret;
+
+	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
+		dev_err(mdev->dev, "Invalid firmware\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hdr = (const void *)(fw->data + fw->size - sizeof(*hdr));
+	for (i = 0; i < hdr->n_region; i++) {
+		region = (const void *)((const u8 *)hdr -
+					(hdr->n_region - i) * sizeof(*region));
+		len = le32_to_cpu(region->len);
+
+		/* check if we have valid buffer size */
+		if (offset + len > fw->size) {
+			dev_err(mdev->dev, "Invalid firmware region\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if ((region->feature_set & FW_FEATURE_NON_DL) &&
+		    region->type == FW_TYPE_CLC) {
+			clc_base = (u8 *)(fw->data + offset);
+			break;
+		}
+		offset += len;
+	}
+
+	if (!clc_base)
+		goto out;
+
+	for (offset = 0; offset < len; offset += le32_to_cpu(clc->len)) {
+		clc = (const struct mt7921_clc *)(clc_base + offset);
+
+		/* do not init buf again if chip reset triggered */
+		if (phy->clc[clc->idx])
+			continue;
+
+		/* header content sanity */
+		if (clc->idx == MT7921_CLC_POWER &&
+		    u8_get_bits(clc->type, MT_EE_HW_TYPE_ENCAP) != hw_encap)
+			continue;
+
+		phy->clc[clc->idx] = devm_kmemdup(mdev->dev, clc,
+						  le32_to_cpu(clc->len),
+						  GFP_KERNEL);
+
+		if (!phy->clc[clc->idx]) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+	ret = mt7921_mcu_set_clc(dev, "00", ENVIRON_INDOOR);
+out:
+	release_firmware(fw);
+
+	return ret;
+}
+
+static int mt7921_load_firmware(struct mt7921_dev *dev)
+{
+	int ret;
+
+	ret = mt76_get_field(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_N9_RDY);
+	if (ret && mt76_is_mmio(&dev->mt76)) {
+		dev_dbg(dev->mt76.dev, "Firmware is already download\n");
+		goto fw_loaded;
+	}
+
+	ret = mt76_connac2_load_patch(&dev->mt76, mt7921_patch_name(dev));
+	if (ret)
+		return ret;
+
+	if (mt76_is_sdio(&dev->mt76)) {
+		/* activate again */
+		ret = __mt7921_mcu_fw_pmctrl(dev);
+		if (!ret)
+			ret = __mt7921_mcu_drv_pmctrl(dev);
+	}
+
+	ret = mt76_connac2_load_ram(&dev->mt76, mt7921_ram_name(dev), NULL);
+	if (ret)
+		return ret;
+
+	if (!mt76_poll_msec(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_N9_RDY,
+			    MT_TOP_MISC2_FW_N9_RDY, 1500)) {
+		dev_err(dev->mt76.dev, "Timeout for initializing firmware\n");
+
+		return -EIO;
+	}
+
+fw_loaded:
+
+#ifdef CONFIG_PM
+	dev->mt76.hw->wiphy->wowlan = &mt76_connac_wowlan_support;
+#endif /* CONFIG_PM */
+
+	dev_dbg(dev->mt76.dev, "Firmware init done\n");
+
+	return 0;
+}
+
+int mt7921_mcu_fw_log_2_host(struct mt7921_dev *dev, u8 ctrl)
+{
+	struct {
+		u8 ctrl_val;
+		u8 pad[3];
+	} data = {
+		.ctrl_val = ctrl
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(FWLOG_2_HOST),
+				 &data, sizeof(data), false);
+}
+
+int mt7921_run_firmware(struct mt7921_dev *dev)
+{
+	int err;
+
+	err = mt7921_load_firmware(dev);
+	if (err)
+		return err;
+
+	err = mt76_connac_mcu_get_nic_capability(&dev->mphy);
+	if (err)
+		return err;
+
+	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
+	err = mt7921_load_clc(dev, mt7921_ram_name(dev));
+	if (err)
+		return err;
+
+	return mt7921_mcu_fw_log_2_host(dev, 1);
+}
+EXPORT_SYMBOL_GPL(mt7921_run_firmware);
+
+int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct edca {
+		__le16 cw_min;
+		__le16 cw_max;
+		__le16 txop;
+		__le16 aifs;
+		u8 guardtime;
+		u8 acm;
+	} __packed;
+	struct mt7921_mcu_tx {
+		struct edca edca[IEEE80211_NUM_ACS];
+		u8 bss_idx;
+		u8 qos;
+		u8 wmm_idx;
+		u8 pad;
+	} __packed req = {
+		.bss_idx = mvif->mt76.idx,
+		.qos = vif->bss_conf.qos,
+		.wmm_idx = mvif->mt76.wmm_idx,
+	};
+	struct mu_edca {
+		u8 cw_min;
+		u8 cw_max;
+		u8 aifsn;
+		u8 acm;
+		u8 timer;
+		u8 padding[3];
+	};
+	struct mt7921_mcu_mu_tx {
+		u8 ver;
+		u8 pad0;
+		__le16 len;
+		u8 bss_idx;
+		u8 qos;
+		u8 wmm_idx;
+		u8 pad1;
+		struct mu_edca edca[IEEE80211_NUM_ACS];
+		u8 pad3[32];
+	} __packed req_mu = {
+		.bss_idx = mvif->mt76.idx,
+		.qos = vif->bss_conf.qos,
+		.wmm_idx = mvif->mt76.wmm_idx,
+	};
+	static const int to_aci[] = { 1, 0, 2, 3 };
+	int ac, ret;
+
+	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
+		struct ieee80211_tx_queue_params *q = &mvif->queue_params[ac];
+		struct edca *e = &req.edca[to_aci[ac]];
+
+		e->aifs = cpu_to_le16(q->aifs);
+		e->txop = cpu_to_le16(q->txop);
+
+		if (q->cw_min)
+			e->cw_min = cpu_to_le16(q->cw_min);
+		else
+			e->cw_min = cpu_to_le16(5);
+
+		if (q->cw_max)
+			e->cw_max = cpu_to_le16(q->cw_max);
+		else
+			e->cw_max = cpu_to_le16(10);
+	}
+
+	ret = mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(SET_EDCA_PARMS), &req,
+				sizeof(req), false);
+	if (ret)
+		return ret;
+
+	if (!vif->bss_conf.he_support)
+		return 0;
+
+	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
+		struct ieee80211_he_mu_edca_param_ac_rec *q;
+		struct mu_edca *e;
+
+		if (!mvif->queue_params[ac].mu_edca)
+			break;
+
+		q = &mvif->queue_params[ac].mu_edca_param_rec;
+		e = &(req_mu.edca[to_aci[ac]]);
+
+		e->cw_min = q->ecw_min_max & 0xf;
+		e->cw_max = (q->ecw_min_max & 0xf0) >> 4;
+		e->aifsn = q->aifsn;
+		e->timer = q->mu_edca_timer;
+	}
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(SET_MU_EDCA_PARMS),
+				 &req_mu, sizeof(req_mu), false);
+}
+
+int mt7921_mcu_set_roc(struct mt7921_phy *phy, struct mt7921_vif *vif,
+		       struct ieee80211_channel *chan, int duration,
+		       enum mt7921_roc_req type, u8 token_id)
+{
+	int center_ch = ieee80211_frequency_to_channel(chan->center_freq);
+	struct mt7921_dev *dev = phy->dev;
+	struct {
+		struct {
+			u8 rsv[4];
+		} __packed hdr;
+		struct roc_acquire_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 bss_idx;
+			u8 tokenid;
+			u8 control_channel;
+			u8 sco;
+			u8 band;
+			u8 bw;
+			u8 center_chan;
+			u8 center_chan2;
+			u8 bw_from_ap;
+			u8 center_chan_from_ap;
+			u8 center_chan2_from_ap;
+			u8 reqtype;
+			__le32 maxinterval;
+			u8 dbdcband;
+			u8 rsv[3];
+		} __packed roc;
+	} __packed req = {
+		.roc = {
+			.tag = cpu_to_le16(UNI_ROC_ACQUIRE),
+			.len = cpu_to_le16(sizeof(struct roc_acquire_tlv)),
+			.tokenid = token_id,
+			.reqtype = type,
+			.maxinterval = cpu_to_le32(duration),
+			.bss_idx = vif->mt76.idx,
+			.control_channel = chan->hw_value,
+			.bw = CMD_CBW_20MHZ,
+			.bw_from_ap = CMD_CBW_20MHZ,
+			.center_chan = center_ch,
+			.center_chan_from_ap = center_ch,
+			.dbdcband = 0xff, /* auto */
+		},
+	};
+
+	if (chan->hw_value < center_ch)
+		req.roc.sco = 1; /* SCA */
+	else if (chan->hw_value > center_ch)
+		req.roc.sco = 3; /* SCB */
+
+	switch (chan->band) {
+	case NL80211_BAND_6GHZ:
+		req.roc.band = 3;
+		break;
+	case NL80211_BAND_5GHZ:
+		req.roc.band = 2;
+		break;
+	default:
+		req.roc.band = 1;
+		break;
+	}
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(ROC),
+				 &req, sizeof(req), false);
+}
+
+int mt7921_mcu_abort_roc(struct mt7921_phy *phy, struct mt7921_vif *vif,
+			 u8 token_id)
+{
+	struct mt7921_dev *dev = phy->dev;
+	struct {
+		struct {
+			u8 rsv[4];
+		} __packed hdr;
+		struct roc_abort_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 bss_idx;
+			u8 tokenid;
+			u8 dbdcband;
+			u8 rsv[5];
+		} __packed abort;
+	} __packed req = {
+		.abort = {
+			.tag = cpu_to_le16(UNI_ROC_ABORT),
+			.len = cpu_to_le16(sizeof(struct roc_abort_tlv)),
+			.tokenid = token_id,
+			.bss_idx = vif->mt76.idx,
+			.dbdcband = 0xff, /* auto*/
+		},
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(ROC),
+				 &req, sizeof(req), false);
+}
+
+int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd)
+{
+	struct mt7921_dev *dev = phy->dev;
+	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
+	int freq1 = chandef->center_freq1;
+	struct {
+		u8 control_ch;
+		u8 center_ch;
+		u8 bw;
+		u8 tx_streams_num;
+		u8 rx_streams;	/* mask or num */
+		u8 switch_reason;
+		u8 band_idx;
+		u8 center_ch2;	/* for 80+80 only */
+		__le16 cac_case;
+		u8 channel_band;
+		u8 rsv0;
+		__le32 outband_freq;
+		u8 txpower_drop;
+		u8 ap_bw;
+		u8 ap_center_ch;
+		u8 rsv1[57];
+	} __packed req = {
+		.control_ch = chandef->chan->hw_value,
+		.center_ch = ieee80211_frequency_to_channel(freq1),
+		.bw = mt76_connac_chan_bw(chandef),
+		.tx_streams_num = hweight8(phy->mt76->antenna_mask),
+		.rx_streams = phy->mt76->antenna_mask,
+		.band_idx = phy != &dev->phy,
+	};
+
+	if (chandef->chan->band == NL80211_BAND_6GHZ)
+		req.channel_band = 2;
+	else
+		req.channel_band = chandef->chan->band;
+
+	if (cmd == MCU_EXT_CMD(SET_RX_PATH) ||
+	    dev->mt76.hw->conf.flags & IEEE80211_CONF_MONITOR)
+		req.switch_reason = CH_SWITCH_NORMAL;
+	else if (dev->mt76.hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
+		req.switch_reason = CH_SWITCH_SCAN_BYPASS_DPD;
+	else if (!cfg80211_reg_can_beacon(dev->mt76.hw->wiphy, chandef,
+					  NL80211_IFTYPE_AP))
+		req.switch_reason = CH_SWITCH_DFS;
+	else
+		req.switch_reason = CH_SWITCH_NORMAL;
+
+	if (cmd == MCU_EXT_CMD(CHANNEL_SWITCH))
+		req.rx_streams = hweight8(req.rx_streams);
+
+	if (chandef->width == NL80211_CHAN_WIDTH_80P80) {
+		int freq2 = chandef->center_freq2;
+
+		req.center_ch2 = ieee80211_frequency_to_channel(freq2);
+	}
+
+	return mt76_mcu_send_msg(&dev->mt76, cmd, &req, sizeof(req), true);
+}
+
+int mt7921_mcu_set_eeprom(struct mt7921_dev *dev)
+{
+	struct req_hdr {
+		u8 buffer_mode;
+		u8 format;
+		__le16 len;
+	} __packed req = {
+		.buffer_mode = EE_MODE_EFUSE,
+		.format = EE_FORMAT_WHOLE,
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(EFUSE_BUFFER_MODE),
+				 &req, sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt7921_mcu_set_eeprom);
+
+int mt7921_mcu_uni_bss_ps(struct mt7921_dev *dev, struct ieee80211_vif *vif)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct ps_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 ps_state; /* 0: device awake
+				      * 1: static power save
+				      * 2: dynamic power saving
+				      * 3: enter TWT power saving
+				      * 4: leave TWT power saving
+				      */
+			u8 pad[3];
+		} __packed ps;
+	} __packed ps_req = {
+		.hdr = {
+			.bss_idx = mvif->mt76.idx,
+		},
+		.ps = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_PS),
+			.len = cpu_to_le16(sizeof(struct ps_tlv)),
+			.ps_state = vif->cfg.ps ? 2 : 0,
+		},
+	};
+
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return -EOPNOTSUPP;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(BSS_INFO_UPDATE),
+				 &ps_req, sizeof(ps_req), true);
+}
+
+static int
+mt7921_mcu_uni_bss_bcnft(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+			 bool enable)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct bcnft_tlv {
+			__le16 tag;
+			__le16 len;
+			__le16 bcn_interval;
+			u8 dtim_period;
+			u8 pad;
+		} __packed bcnft;
+	} __packed bcnft_req = {
+		.hdr = {
+			.bss_idx = mvif->mt76.idx,
+		},
+		.bcnft = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_BCNFT),
+			.len = cpu_to_le16(sizeof(struct bcnft_tlv)),
+			.bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int),
+			.dtim_period = vif->bss_conf.dtim_period,
+		},
+	};
+
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return 0;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(BSS_INFO_UPDATE),
+				 &bcnft_req, sizeof(bcnft_req), true);
+}
+
+int
+mt7921_mcu_set_bss_pm(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+		      bool enable)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct {
+		u8 bss_idx;
+		u8 dtim_period;
+		__le16 aid;
+		__le16 bcn_interval;
+		__le16 atim_window;
+		u8 uapsd;
+		u8 bmc_delivered_ac;
+		u8 bmc_triggered_ac;
+		u8 pad;
+	} req = {
+		.bss_idx = mvif->mt76.idx,
+		.aid = cpu_to_le16(vif->cfg.aid),
+		.dtim_period = vif->bss_conf.dtim_period,
+		.bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int),
+	};
+	struct {
+		u8 bss_idx;
+		u8 pad[3];
+	} req_hdr = {
+		.bss_idx = mvif->mt76.idx,
+	};
+	int err;
+
+	err = mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(SET_BSS_ABORT),
+				&req_hdr, sizeof(req_hdr), false);
+	if (err < 0 || !enable)
+		return err;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(SET_BSS_CONNECTED),
+				 &req, sizeof(req), false);
+}
+
+int mt7921_mcu_sta_update(struct mt7921_dev *dev, struct ieee80211_sta *sta,
+			  struct ieee80211_vif *vif, bool enable,
+			  enum mt76_sta_info_state state)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	int rssi = -ewma_rssi_read(&mvif->rssi);
+	struct mt76_sta_cmd_info info = {
+		.sta = sta,
+		.vif = vif,
+		.enable = enable,
+		.cmd = MCU_UNI_CMD(STA_REC_UPDATE),
+		.state = state,
+		.offload_fw = true,
+		.rcpi = to_rcpi(rssi),
+	};
+	struct mt7921_sta *msta;
+
+	msta = sta ? (struct mt7921_sta *)sta->drv_priv : NULL;
+	info.wcid = msta ? &msta->wcid : &mvif->sta.wcid;
+	info.newly = msta ? state != MT76_STA_INFO_STATE_ASSOC : true;
+
+	return mt76_connac_mcu_sta_cmd(&dev->mphy, &info);
+}
+
+int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev)
+{
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt76_connac_pm *pm = &dev->pm;
+	int err = 0;
+
+	mutex_lock(&pm->mutex);
+
+	if (!test_bit(MT76_STATE_PM, &mphy->state))
+		goto out;
+
+	err = __mt7921_mcu_drv_pmctrl(dev);
+out:
+	mutex_unlock(&pm->mutex);
+
+	if (err)
+		mt7921_reset(&dev->mt76);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(mt7921_mcu_drv_pmctrl);
+
+int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev)
+{
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt76_connac_pm *pm = &dev->pm;
+	int err = 0;
+
+	mutex_lock(&pm->mutex);
+
+	if (mt76_connac_skip_fw_pmctrl(mphy, pm))
+		goto out;
+
+	err = __mt7921_mcu_fw_pmctrl(dev);
+out:
+	mutex_unlock(&pm->mutex);
+
+	if (err)
+		mt7921_reset(&dev->mt76);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(mt7921_mcu_fw_pmctrl);
+
+int mt7921_mcu_set_beacon_filter(struct mt7921_dev *dev,
+				 struct ieee80211_vif *vif,
+				 bool enable)
+{
+#define MT7921_FIF_BIT_CLR		BIT(1)
+#define MT7921_FIF_BIT_SET		BIT(0)
+	int err;
+
+	if (enable) {
+		err = mt7921_mcu_uni_bss_bcnft(dev, vif, true);
+		if (err)
+			return err;
+
+		err = mt7921_mcu_set_rxfilter(dev, 0,
+					      MT7921_FIF_BIT_SET,
+					      MT_WF_RFCR_DROP_OTHER_BEACON);
+		if (err)
+			return err;
+
+		return 0;
+	}
+
+	err = mt7921_mcu_set_bss_pm(dev, vif, false);
+	if (err)
+		return err;
+
+	err = mt7921_mcu_set_rxfilter(dev, 0,
+				      MT7921_FIF_BIT_CLR,
+				      MT_WF_RFCR_DROP_OTHER_BEACON);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+int mt7921_get_txpwr_info(struct mt7921_dev *dev, struct mt7921_txpwr *txpwr)
+{
+	struct mt7921_txpwr_event *event;
+	struct mt7921_txpwr_req req = {
+		.dbdc_idx = 0,
+	};
+	struct sk_buff *skb;
+	int ret;
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_CE_CMD(GET_TXPWR),
+					&req, sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	event = (struct mt7921_txpwr_event *)skb->data;
+	WARN_ON(skb->len != le16_to_cpu(event->len));
+	memcpy(txpwr, &event->txpwr, sizeof(event->txpwr));
+
+	dev_kfree_skb(skb);
+
+	return 0;
+}
+
+int mt7921_mcu_set_sniffer(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+			   bool enable)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct {
+		struct {
+			u8 band_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct sniffer_enable_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 enable;
+			u8 pad[3];
+		} __packed enable;
+	} req = {
+		.hdr = {
+			.band_idx = mvif->band_idx,
+		},
+		.enable = {
+			.tag = cpu_to_le16(0),
+			.len = cpu_to_le16(sizeof(struct sniffer_enable_tlv)),
+			.enable = enable,
+		},
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(SNIFFER), &req, sizeof(req),
+				 true);
+}
+
+int mt7921_mcu_config_sniffer(struct mt7921_vif *vif,
+			      struct ieee80211_chanctx_conf *ctx)
+{
+	struct cfg80211_chan_def *chandef = &ctx->def;
+	int freq1 = chandef->center_freq1, freq2 = chandef->center_freq2;
+	const u8 ch_band[] = {
+		[NL80211_BAND_2GHZ] = 1,
+		[NL80211_BAND_5GHZ] = 2,
+		[NL80211_BAND_6GHZ] = 3,
+	};
+	const u8 ch_width[] = {
+		[NL80211_CHAN_WIDTH_20_NOHT] = 0,
+		[NL80211_CHAN_WIDTH_20] = 0,
+		[NL80211_CHAN_WIDTH_40] = 0,
+		[NL80211_CHAN_WIDTH_80] = 1,
+		[NL80211_CHAN_WIDTH_160] = 2,
+		[NL80211_CHAN_WIDTH_80P80] = 3,
+		[NL80211_CHAN_WIDTH_5] = 4,
+		[NL80211_CHAN_WIDTH_10] = 5,
+		[NL80211_CHAN_WIDTH_320] = 6,
+	};
+	struct {
+		struct {
+			u8 band_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct config_tlv {
+			__le16 tag;
+			__le16 len;
+			u16 aid;
+			u8 ch_band;
+			u8 bw;
+			u8 control_ch;
+			u8 sco;
+			u8 center_ch;
+			u8 center_ch2;
+			u8 drop_err;
+			u8 pad[3];
+		} __packed tlv;
+	} __packed req = {
+		.hdr = {
+			.band_idx = vif->mt76.band_idx,
+		},
+		.tlv = {
+			.tag = cpu_to_le16(1),
+			.len = cpu_to_le16(sizeof(req.tlv)),
+			.control_ch = chandef->chan->hw_value,
+			.center_ch = ieee80211_frequency_to_channel(freq1),
+			.drop_err = 1,
+		},
+	};
+	if (chandef->chan->band < ARRAY_SIZE(ch_band))
+		req.tlv.ch_band = ch_band[chandef->chan->band];
+	if (chandef->width < ARRAY_SIZE(ch_width))
+		req.tlv.bw = ch_width[chandef->width];
+
+	if (freq2)
+		req.tlv.center_ch2 = ieee80211_frequency_to_channel(freq2);
+
+	if (req.tlv.control_ch < req.tlv.center_ch)
+		req.tlv.sco = 1; /* SCA */
+	else if (req.tlv.control_ch > req.tlv.center_ch)
+		req.tlv.sco = 3; /* SCB */
+
+	return mt76_mcu_send_msg(vif->phy->mt76->dev, MCU_UNI_CMD(SNIFFER),
+				 &req, sizeof(req), true);
+}
+
+int
+mt7921_mcu_uni_add_beacon_offload(struct mt7921_dev *dev,
+				  struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  bool enable)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
+	struct ieee80211_mutable_offsets offs;
+	struct {
+		struct req_hdr {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct bcn_content_tlv {
+			__le16 tag;
+			__le16 len;
+			__le16 tim_ie_pos;
+			__le16 csa_ie_pos;
+			__le16 bcc_ie_pos;
+			/* 0: disable beacon offload
+			 * 1: enable beacon offload
+			 * 2: update probe respond offload
+			 */
+			u8 enable;
+			/* 0: legacy format (TXD + payload)
+			 * 1: only cap field IE
+			 */
+			u8 type;
+			__le16 pkt_len;
+			u8 pkt[512];
+		} __packed beacon_tlv;
+	} req = {
+		.hdr = {
+			.bss_idx = mvif->mt76.idx,
+		},
+		.beacon_tlv = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_BCN_CONTENT),
+			.len = cpu_to_le16(sizeof(struct bcn_content_tlv)),
+			.enable = enable,
+		},
+	};
+	struct sk_buff *skb;
+
+	/* support enable/update process only
+	 * disable flow would be handled in bss stop handler automatically
+	 */
+	if (!enable)
+		return -EOPNOTSUPP;
+
+	skb = ieee80211_beacon_get_template(mt76_hw(dev), vif, &offs, 0);
+	if (!skb)
+		return -EINVAL;
+
+	if (skb->len > 512 - MT_TXD_SIZE) {
+		dev_err(dev->mt76.dev, "beacon size limit exceed\n");
+		dev_kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	mt76_connac2_mac_write_txwi(&dev->mt76, (__le32 *)(req.beacon_tlv.pkt),
+				    skb, wcid, NULL, 0, 0, BSS_CHANGED_BEACON);
+	memcpy(req.beacon_tlv.pkt + MT_TXD_SIZE, skb->data, skb->len);
+	req.beacon_tlv.pkt_len = cpu_to_le16(MT_TXD_SIZE + skb->len);
+	req.beacon_tlv.tim_ie_pos = cpu_to_le16(MT_TXD_SIZE + offs.tim_offset);
+
+	if (offs.cntdwn_counter_offs[0]) {
+		u16 csa_offs;
+
+		csa_offs = MT_TXD_SIZE + offs.cntdwn_counter_offs[0] - 4;
+		req.beacon_tlv.csa_ie_pos = cpu_to_le16(csa_offs);
+	}
+	dev_kfree_skb(skb);
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(BSS_INFO_UPDATE),
+				 &req, sizeof(req), true);
+}
+
+static
+int __mt7921_mcu_set_clc(struct mt7921_dev *dev, u8 *alpha2,
+			 enum environment_cap env_cap,
+			 struct mt7921_clc *clc,
+			 u8 idx)
+{
+	struct sk_buff *skb;
+	struct {
+		u8 ver;
+		u8 pad0;
+		__le16 len;
+		u8 idx;
+		u8 env;
+		u8 acpi_conf;
+		u8 pad1;
+		u8 alpha2[2];
+		u8 type[2];
+		u8 rsvd[64];
+	} __packed req = {
+		.idx = idx,
+		.env = env_cap,
+		.acpi_conf = mt7921_acpi_get_flags(&dev->phy),
+	};
+	int ret, valid_cnt = 0;
+	u8 i, *pos;
+
+	if (!clc)
+		return 0;
+
+	pos = clc->data;
+	for (i = 0; i < clc->nr_country; i++) {
+		struct mt7921_clc_rule *rule = (struct mt7921_clc_rule *)pos;
+		u16 len = le16_to_cpu(rule->len);
+
+		pos += len + sizeof(*rule);
+		if (rule->alpha2[0] != alpha2[0] ||
+		    rule->alpha2[1] != alpha2[1])
+			continue;
+
+		memcpy(req.alpha2, rule->alpha2, 2);
+		memcpy(req.type, rule->type, 2);
+
+		req.len = cpu_to_le16(sizeof(req) + len);
+		skb = __mt76_mcu_msg_alloc(&dev->mt76, &req,
+					   le16_to_cpu(req.len),
+					   sizeof(req), GFP_KERNEL);
+		if (!skb)
+			return -ENOMEM;
+		skb_put_data(skb, rule->data, len);
+
+		ret = mt76_mcu_skb_send_msg(&dev->mt76, skb,
+					    MCU_CE_CMD(SET_CLC), false);
+		if (ret < 0)
+			return ret;
+		valid_cnt++;
+	}
+
+	if (!valid_cnt)
+		return -ENOENT;
+
+	return 0;
+}
+
+int mt7921_mcu_set_clc(struct mt7921_dev *dev, u8 *alpha2,
+		       enum environment_cap env_cap)
+{
+	struct mt7921_phy *phy = (struct mt7921_phy *)&dev->phy;
+	int i, ret;
+
+	/* submit all clc config */
+	for (i = 0; i < ARRAY_SIZE(phy->clc); i++) {
+		ret = __mt7921_mcu_set_clc(dev, alpha2, env_cap,
+					   phy->clc[i], i);
+
+		/* If no country found, set "00" as default */
+		if (ret == -ENOENT)
+			ret = __mt7921_mcu_set_clc(dev, "00",
+						   ENVIRON_INDOOR,
+						   phy->clc[i], i);
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
+int mt7921_mcu_set_rxfilter(struct mt7921_dev *dev, u32 fif,
+			    u8 bit_op, u32 bit_map)
+{
+	struct {
+		u8 rsv[4];
+		u8 mode;
+		u8 rsv2[3];
+		__le32 fif;
+		__le32 bit_map; /* bit_* for bitmap update */
+		u8 bit_op;
+		u8 pad[51];
+	} __packed data = {
+		.mode = fif ? 1 : 2,
+		.fif = cpu_to_le32(fif),
+		.bit_map = cpu_to_le32(bit_map),
+		.bit_op = bit_op,
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(SET_RX_FILTER),
+				 &data, sizeof(data), false);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h.orig b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h.orig
new file mode 100644
index 000000000000..ec9879650174
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h.orig
@@ -0,0 +1,561 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#ifndef __MT7921_H
+#define __MT7921_H
+
+#include <linux/interrupt.h>
+#include <linux/ktime.h>
+#include "../mt76_connac_mcu.h"
+#include "regs.h"
+#include "acpi_sar.h"
+
+#define MT7921_MAX_INTERFACES		4
+#define MT7921_WTBL_SIZE		20
+#define MT7921_WTBL_RESERVED		(MT7921_WTBL_SIZE - 1)
+#define MT7921_WTBL_STA			(MT7921_WTBL_RESERVED - \
+					 MT7921_MAX_INTERFACES)
+
+#define MT7921_PM_TIMEOUT		(HZ / 12)
+#define MT7921_HW_SCAN_TIMEOUT		(HZ / 10)
+#define MT7921_WATCHDOG_TIME		(HZ / 4)
+
+#define MT7921_TX_RING_SIZE		2048
+#define MT7921_TX_MCU_RING_SIZE		256
+#define MT7921_TX_FWDL_RING_SIZE	128
+
+#define MT7921_RX_RING_SIZE		1536
+#define MT7921_RX_MCU_RING_SIZE		512
+
+#define MT7921_DRV_OWN_RETRY_COUNT	10
+#define MT7921_MCU_INIT_RETRY_COUNT	10
+#define MT7921_WFSYS_INIT_RETRY_COUNT	2
+
+#define MT7921_FW_TAG_FEATURE		4
+#define MT7921_FW_CAP_CNM		BIT(7)
+
+#define MT7921_FIRMWARE_WM		"mediatek/WIFI_RAM_CODE_MT7961_1.bin"
+#define MT7921_ROM_PATCH		"mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin"
+
+#define MT7922_FIRMWARE_WM		"mediatek/WIFI_RAM_CODE_MT7922_1.bin"
+#define MT7922_ROM_PATCH		"mediatek/WIFI_MT7922_patch_mcu_1_1_hdr.bin"
+
+#define MT7921_EEPROM_SIZE		3584
+#define MT7921_TOKEN_SIZE		8192
+
+#define MT7921_EEPROM_BLOCK_SIZE	16
+
+#define MT7921_CFEND_RATE_DEFAULT	0x49	/* OFDM 24M */
+#define MT7921_CFEND_RATE_11B		0x03	/* 11B LP, 11M */
+
+#define MT7921_SKU_RATE_NUM		161
+#define MT7921_SKU_MAX_DELTA_IDX	MT7921_SKU_RATE_NUM
+#define MT7921_SKU_TABLE_SIZE		(MT7921_SKU_RATE_NUM + 1)
+
+#define MT7921_SDIO_HDR_TX_BYTES	GENMASK(15, 0)
+#define MT7921_SDIO_HDR_PKT_TYPE	GENMASK(17, 16)
+
+#define MCU_UNI_EVENT_ROC  0x27
+
+enum {
+	UNI_ROC_ACQUIRE,
+	UNI_ROC_ABORT,
+	UNI_ROC_NUM
+};
+
+enum mt7921_roc_req {
+	MT7921_ROC_REQ_JOIN,
+	MT7921_ROC_REQ_ROC,
+	MT7921_ROC_REQ_NUM
+};
+
+enum {
+	UNI_EVENT_ROC_GRANT = 0,
+	UNI_EVENT_ROC_TAG_NUM
+};
+
+struct mt7921_realease_info {
+	__le16 len;
+	u8 pad_len;
+	u8 tag;
+} __packed;
+
+struct mt7921_fw_features {
+	u8 segment;
+	u8 data;
+	u8 rsv[14];
+} __packed;
+
+struct mt7921_roc_grant_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 bss_idx;
+	u8 tokenid;
+	u8 status;
+	u8 primarychannel;
+	u8 rfsco;
+	u8 rfband;
+	u8 channelwidth;
+	u8 centerfreqseg1;
+	u8 centerfreqseg2;
+	u8 reqtype;
+	u8 dbdcband;
+	u8 rsv[1];
+	__le32 max_interval;
+} __packed;
+
+enum mt7921_sdio_pkt_type {
+	MT7921_SDIO_TXD,
+	MT7921_SDIO_DATA,
+	MT7921_SDIO_CMD,
+	MT7921_SDIO_FWDL,
+};
+
+struct mt7921_sdio_intr {
+	u32 isr;
+	struct {
+		u32 wtqcr[16];
+	} tx;
+	struct {
+		u16 num[2];
+		u16 len0[16];
+		u16 len1[128];
+	} rx;
+	u32 rec_mb[2];
+} __packed;
+
+#define to_rssi(field, rxv)		((FIELD_GET(field, rxv) - 220) / 2)
+#define to_rcpi(rssi)			(2 * (rssi) + 220)
+
+struct mt7921_vif;
+struct mt7921_sta;
+
+enum mt7921_txq_id {
+	MT7921_TXQ_BAND0,
+	MT7921_TXQ_BAND1,
+	MT7921_TXQ_FWDL = 16,
+	MT7921_TXQ_MCU_WM,
+};
+
+enum mt7921_rxq_id {
+	MT7921_RXQ_BAND0 = 0,
+	MT7921_RXQ_BAND1,
+	MT7921_RXQ_MCU_WM = 0,
+};
+
+DECLARE_EWMA(avg_signal, 10, 8)
+
+struct mt7921_sta {
+	struct mt76_wcid wcid; /* must be first */
+
+	struct mt7921_vif *vif;
+
+	u32 airtime_ac[8];
+
+	int ack_signal;
+	struct ewma_avg_signal avg_ack_signal;
+
+	unsigned long last_txs;
+
+	struct mt76_connac_sta_key_conf bip;
+};
+
+DECLARE_EWMA(rssi, 10, 8);
+
+struct mt7921_vif {
+	struct mt76_vif mt76; /* must be first */
+
+	struct mt7921_sta sta;
+	struct mt7921_sta *wep_sta;
+
+	struct mt7921_phy *phy;
+
+	struct ewma_rssi rssi;
+
+	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
+	struct ieee80211_chanctx_conf *ctx;
+};
+
+enum {
+	MT7921_CLC_POWER,
+	MT7921_CLC_CHAN,
+	MT7921_CLC_MAX_NUM,
+};
+
+struct mt7921_clc_rule {
+	u8 alpha2[2];
+	u8 type[2];
+	__le16 len;
+	u8 data[];
+} __packed;
+
+struct mt7921_clc {
+	__le32 len;
+	u8 idx;
+	u8 ver;
+	u8 nr_country;
+	u8 type;
+	u8 rsv[8];
+	u8 data[];
+} __packed;
+
+struct mt7921_phy {
+	struct mt76_phy *mt76;
+	struct mt7921_dev *dev;
+
+	struct ieee80211_sband_iftype_data iftype[NUM_NL80211_BANDS][NUM_NL80211_IFTYPES];
+
+	u64 omac_mask;
+
+	u16 noise;
+
+	s16 coverage_class;
+	u8 slottime;
+
+	u32 rx_ampdu_ts;
+	u32 ampdu_ref;
+
+	struct mt76_mib_stats mib;
+
+	u8 sta_work_count;
+
+	struct sk_buff_head scan_event_list;
+	struct delayed_work scan_work;
+#ifdef CONFIG_ACPI
+	struct mt7921_acpi_sar *acpisar;
+#endif
+
+	struct mt7921_clc *clc[MT7921_CLC_MAX_NUM];
+
+	struct work_struct roc_work;
+	struct timer_list roc_timer;
+	wait_queue_head_t roc_wait;
+	u8 roc_token_id;
+	bool roc_grant;
+};
+
+enum mt7921_eeprom_field {
+	MT_EE_CHIP_ID =		0x000,
+	MT_EE_VERSION =		0x002,
+	MT_EE_MAC_ADDR =	0x004,
+	MT_EE_WIFI_CONF =	0x07c,
+	MT_EE_HW_TYPE =		0x55b,
+	__MT_EE_MAX =		0x9ff
+};
+
+#define MT_EE_HW_TYPE_ENCAP			BIT(0)
+
+#define mt7921_init_reset(dev)		((dev)->hif_ops->init_reset(dev))
+#define mt7921_dev_reset(dev)		((dev)->hif_ops->reset(dev))
+#define mt7921_mcu_init(dev)		((dev)->hif_ops->mcu_init(dev))
+#define __mt7921_mcu_drv_pmctrl(dev)	((dev)->hif_ops->drv_own(dev))
+#define	__mt7921_mcu_fw_pmctrl(dev)	((dev)->hif_ops->fw_own(dev))
+struct mt7921_hif_ops {
+	int (*init_reset)(struct mt7921_dev *dev);
+	int (*reset)(struct mt7921_dev *dev);
+	int (*mcu_init)(struct mt7921_dev *dev);
+	int (*drv_own)(struct mt7921_dev *dev);
+	int (*fw_own)(struct mt7921_dev *dev);
+};
+
+struct mt7921_dev {
+	union { /* must be first */
+		struct mt76_dev mt76;
+		struct mt76_phy mphy;
+	};
+
+	const struct mt76_bus_ops *bus_ops;
+	struct mt7921_phy phy;
+
+	struct work_struct reset_work;
+	bool hw_full_reset:1;
+	bool hw_init_done:1;
+	bool fw_assert:1;
+
+	struct work_struct init_work;
+
+	u8 fw_debug;
+	u8 fw_features;
+
+	struct mt76_connac_pm pm;
+	struct mt76_connac_coredump coredump;
+	const struct mt7921_hif_ops *hif_ops;
+
+	struct work_struct ipv6_ns_work;
+	/* IPv6 addresses for WoWLAN */
+	struct sk_buff_head ipv6_ns_list;
+
+	enum environment_cap country_ie_env;
+};
+
+enum {
+	TXPWR_USER,
+	TXPWR_EEPROM,
+	TXPWR_MAC,
+	TXPWR_MAX_NUM,
+};
+
+struct mt7921_txpwr {
+	u8 ch;
+	u8 rsv[3];
+	struct {
+		u8 ch;
+		u8 cck[4];
+		u8 ofdm[8];
+		u8 ht20[8];
+		u8 ht40[9];
+		u8 vht20[12];
+		u8 vht40[12];
+		u8 vht80[12];
+		u8 vht160[12];
+		u8 he26[12];
+		u8 he52[12];
+		u8 he106[12];
+		u8 he242[12];
+		u8 he484[12];
+		u8 he996[12];
+		u8 he996x2[12];
+	} data[TXPWR_MAX_NUM];
+};
+
+static inline struct mt7921_phy *
+mt7921_hw_phy(struct ieee80211_hw *hw)
+{
+	struct mt76_phy *phy = hw->priv;
+
+	return phy->priv;
+}
+
+static inline struct mt7921_dev *
+mt7921_hw_dev(struct ieee80211_hw *hw)
+{
+	struct mt76_phy *phy = hw->priv;
+
+	return container_of(phy->dev, struct mt7921_dev, mt76);
+}
+
+#define mt7921_mutex_acquire(dev)	\
+	mt76_connac_mutex_acquire(&(dev)->mt76, &(dev)->pm)
+#define mt7921_mutex_release(dev)	\
+	mt76_connac_mutex_release(&(dev)->mt76, &(dev)->pm)
+
+extern const struct ieee80211_ops mt7921_ops;
+
+u32 mt7921_reg_map(struct mt7921_dev *dev, u32 addr);
+
+int __mt7921_start(struct mt7921_phy *phy);
+int mt7921_register_device(struct mt7921_dev *dev);
+void mt7921_unregister_device(struct mt7921_dev *dev);
+int mt7921_dma_init(struct mt7921_dev *dev);
+int mt7921_wpdma_reset(struct mt7921_dev *dev, bool force);
+int mt7921_wpdma_reinit_cond(struct mt7921_dev *dev);
+void mt7921_dma_cleanup(struct mt7921_dev *dev);
+int mt7921_run_firmware(struct mt7921_dev *dev);
+int mt7921_mcu_set_bss_pm(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+			  bool enable);
+int mt7921_mcu_sta_update(struct mt7921_dev *dev, struct ieee80211_sta *sta,
+			  struct ieee80211_vif *vif, bool enable,
+			  enum mt76_sta_info_state state);
+int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd);
+int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif);
+int mt7921_mcu_set_eeprom(struct mt7921_dev *dev);
+int mt7921_mcu_get_rx_rate(struct mt7921_phy *phy, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta, struct rate_info *rate);
+int mt7921_mcu_fw_log_2_host(struct mt7921_dev *dev, u8 ctrl);
+void mt7921_mcu_rx_event(struct mt7921_dev *dev, struct sk_buff *skb);
+int mt7921_mcu_set_rxfilter(struct mt7921_dev *dev, u32 fif,
+			    u8 bit_op, u32 bit_map);
+
+static inline u32
+mt7921_reg_map_l1(struct mt7921_dev *dev, u32 addr)
+{
+	u32 offset = FIELD_GET(MT_HIF_REMAP_L1_OFFSET, addr);
+	u32 base = FIELD_GET(MT_HIF_REMAP_L1_BASE, addr);
+
+	mt76_rmw_field(dev, MT_HIF_REMAP_L1, MT_HIF_REMAP_L1_MASK, base);
+	/* use read to push write */
+	mt76_rr(dev, MT_HIF_REMAP_L1);
+
+	return MT_HIF_REMAP_BASE_L1 + offset;
+}
+
+static inline u32
+mt7921_l1_rr(struct mt7921_dev *dev, u32 addr)
+{
+	return mt76_rr(dev, mt7921_reg_map_l1(dev, addr));
+}
+
+static inline void
+mt7921_l1_wr(struct mt7921_dev *dev, u32 addr, u32 val)
+{
+	mt76_wr(dev, mt7921_reg_map_l1(dev, addr), val);
+}
+
+static inline u32
+mt7921_l1_rmw(struct mt7921_dev *dev, u32 addr, u32 mask, u32 val)
+{
+	val |= mt7921_l1_rr(dev, addr) & ~mask;
+	mt7921_l1_wr(dev, addr, val);
+
+	return val;
+}
+
+#define mt7921_l1_set(dev, addr, val)	mt7921_l1_rmw(dev, addr, 0, val)
+#define mt7921_l1_clear(dev, addr, val)	mt7921_l1_rmw(dev, addr, val, 0)
+
+static inline bool mt7921_dma_need_reinit(struct mt7921_dev *dev)
+{
+	return !mt76_get_field(dev, MT_WFDMA_DUMMY_CR, MT_WFDMA_NEED_REINIT);
+}
+
+static inline void
+mt7921_skb_add_usb_sdio_hdr(struct mt7921_dev *dev, struct sk_buff *skb,
+			    int type)
+{
+	u32 hdr, len;
+
+	len = mt76_is_usb(&dev->mt76) ? skb->len : skb->len + sizeof(hdr);
+	hdr = FIELD_PREP(MT7921_SDIO_HDR_TX_BYTES, len) |
+	      FIELD_PREP(MT7921_SDIO_HDR_PKT_TYPE, type);
+
+	put_unaligned_le32(hdr, skb_push(skb, sizeof(hdr)));
+}
+
+void mt7921_stop(struct ieee80211_hw *hw);
+int mt7921_mac_init(struct mt7921_dev *dev);
+bool mt7921_mac_wtbl_update(struct mt7921_dev *dev, int idx, u32 mask);
+void mt7921_mac_reset_counters(struct mt7921_phy *phy);
+void mt7921_mac_set_timing(struct mt7921_phy *phy);
+int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta);
+void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			  struct ieee80211_sta *sta);
+void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta);
+void mt7921_mac_work(struct work_struct *work);
+void mt7921_mac_reset_work(struct work_struct *work);
+void mt7921_mac_update_mib_stats(struct mt7921_phy *phy);
+void mt7921_reset(struct mt76_dev *mdev);
+int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
+			   enum mt76_txq_id qid, struct mt76_wcid *wcid,
+			   struct ieee80211_sta *sta,
+			   struct mt76_tx_info *tx_info);
+
+void mt7921_tx_worker(struct mt76_worker *w);
+bool mt7921_rx_check(struct mt76_dev *mdev, void *data, int len);
+void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
+			 struct sk_buff *skb, u32 *info);
+void mt7921_stats_work(struct work_struct *work);
+void mt7921_set_stream_he_caps(struct mt7921_phy *phy);
+void mt7921_update_channel(struct mt76_phy *mphy);
+int mt7921_init_debugfs(struct mt7921_dev *dev);
+
+int mt7921_mcu_set_beacon_filter(struct mt7921_dev *dev,
+				 struct ieee80211_vif *vif,
+				 bool enable);
+int mt7921_mcu_uni_tx_ba(struct mt7921_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool enable);
+int mt7921_mcu_uni_rx_ba(struct mt7921_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool enable);
+void mt7921_scan_work(struct work_struct *work);
+void mt7921_roc_work(struct work_struct *work);
+void mt7921_roc_timer(struct timer_list *timer);
+int mt7921_mcu_uni_bss_ps(struct mt7921_dev *dev, struct ieee80211_vif *vif);
+int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev);
+int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev);
+void mt7921_pm_wake_work(struct work_struct *work);
+void mt7921_pm_power_save_work(struct work_struct *work);
+void mt7921_coredump_work(struct work_struct *work);
+int mt7921_wfsys_reset(struct mt7921_dev *dev);
+int mt7921_get_txpwr_info(struct mt7921_dev *dev, struct mt7921_txpwr *txpwr);
+int mt7921_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			void *data, int len);
+int mt7921_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *msg,
+			 struct netlink_callback *cb, void *data, int len);
+int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
+			      struct sk_buff *skb, int seq);
+
+int mt7921e_driver_own(struct mt7921_dev *dev);
+int mt7921e_mac_reset(struct mt7921_dev *dev);
+int mt7921e_mcu_init(struct mt7921_dev *dev);
+int mt7921s_wfsys_reset(struct mt7921_dev *dev);
+int mt7921s_mac_reset(struct mt7921_dev *dev);
+int mt7921s_init_reset(struct mt7921_dev *dev);
+int __mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev);
+int mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev);
+int mt7921e_mcu_fw_pmctrl(struct mt7921_dev *dev);
+
+int mt7921s_mcu_init(struct mt7921_dev *dev);
+int mt7921s_mcu_drv_pmctrl(struct mt7921_dev *dev);
+int mt7921s_mcu_fw_pmctrl(struct mt7921_dev *dev);
+void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data);
+void mt7921_set_runtime_pm(struct mt7921_dev *dev);
+void mt7921_mcu_set_suspend_iter(void *priv, u8 *mac,
+				 struct ieee80211_vif *vif);
+void mt7921_set_ipv6_ns_work(struct work_struct *work);
+
+int mt7921_mcu_set_sniffer(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+			   bool enable);
+int mt7921_mcu_config_sniffer(struct mt7921_vif *vif,
+			      struct ieee80211_chanctx_conf *ctx);
+int mt7921_mcu_get_temperature(struct mt7921_phy *phy);
+
+int mt7921_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
+				   enum mt76_txq_id qid, struct mt76_wcid *wcid,
+				   struct ieee80211_sta *sta,
+				   struct mt76_tx_info *tx_info);
+void mt7921_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
+				     struct mt76_queue_entry *e);
+bool mt7921_usb_sdio_tx_status_data(struct mt76_dev *mdev, u8 *update);
+
+/* usb */
+#define MT_USB_TYPE_VENDOR	(USB_TYPE_VENDOR | 0x1f)
+#define MT_USB_TYPE_UHW_VENDOR	(USB_TYPE_VENDOR | 0x1e)
+
+int mt7921u_mcu_power_on(struct mt7921_dev *dev);
+int mt7921u_wfsys_reset(struct mt7921_dev *dev);
+int mt7921u_dma_init(struct mt7921_dev *dev, bool resume);
+int mt7921u_init_reset(struct mt7921_dev *dev);
+int mt7921u_mac_reset(struct mt7921_dev *dev);
+int mt7921_mcu_uni_add_beacon_offload(struct mt7921_dev *dev,
+				      struct ieee80211_hw *hw,
+				      struct ieee80211_vif *vif,
+				      bool enable);
+#ifdef CONFIG_ACPI
+int mt7921_init_acpi_sar(struct mt7921_dev *dev);
+int mt7921_init_acpi_sar_power(struct mt7921_phy *phy, bool set_default);
+u8 mt7921_acpi_get_flags(struct mt7921_phy *phy);
+#else
+static inline int
+mt7921_init_acpi_sar(struct mt7921_dev *dev)
+{
+	return 0;
+}
+
+static inline int
+mt7921_init_acpi_sar_power(struct mt7921_phy *phy, bool set_default)
+{
+	return 0;
+}
+
+static inline u8
+mt7921_acpi_get_flags(struct mt7921_phy *phy)
+{
+	return 0;
+}
+#endif
+int mt7921_set_tx_sar_pwr(struct ieee80211_hw *hw,
+			  const struct cfg80211_sar_specs *sar);
+
+int mt7921_mcu_set_clc(struct mt7921_dev *dev, u8 *alpha2,
+		       enum environment_cap env_cap);
+int mt7921_mcu_set_roc(struct mt7921_phy *phy, struct mt7921_vif *vif,
+		       struct ieee80211_channel *chan, int duration,
+		       enum mt7921_roc_req type, u8 token_id);
+int mt7921_mcu_abort_roc(struct mt7921_phy *phy, struct mt7921_vif *vif,
+			 u8 token_id);
+struct ieee80211_ops *mt7921_get_mac80211_ops(struct device *dev,
+					      void *drv_data, u8 *fw_features);
+#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c.orig b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c.orig
new file mode 100644
index 000000000000..9d1ba838e54f
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c.orig
@@ -0,0 +1,497 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "mt7921.h"
+#include "mac.h"
+#include "mcu.h"
+#include "../trace.h"
+
+static const struct pci_device_id mt7921_pci_device_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7961) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7922) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x0608) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x0616) },
+	{ },
+};
+
+static bool mt7921_disable_aspm;
+module_param_named(disable_aspm, mt7921_disable_aspm, bool, 0644);
+MODULE_PARM_DESC(disable_aspm, "disable PCI ASPM support");
+
+static void
+mt7921_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+
+	if (q == MT_RXQ_MAIN)
+		mt7921_irq_enable(dev, MT_INT_RX_DONE_DATA);
+	else if (q == MT_RXQ_MCU_WA)
+		mt7921_irq_enable(dev, MT_INT_RX_DONE_WM2);
+	else
+		mt7921_irq_enable(dev, MT_INT_RX_DONE_WM);
+}
+
+static irqreturn_t mt7921_irq_handler(int irq, void *dev_instance)
+{
+	struct mt7921_dev *dev = dev_instance;
+
+	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
+
+	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
+		return IRQ_NONE;
+
+	tasklet_schedule(&dev->irq_tasklet);
+
+	return IRQ_HANDLED;
+}
+
+static void mt7921_irq_tasklet(unsigned long data)
+{
+	struct mt7921_dev *dev = (struct mt7921_dev *)data;
+	u32 intr, mask = 0;
+
+	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
+
+	intr = mt76_rr(dev, MT_WFDMA0_HOST_INT_STA);
+	intr &= dev->mt76.mmio.irqmask;
+	mt76_wr(dev, MT_WFDMA0_HOST_INT_STA, intr);
+
+	trace_dev_irq(&dev->mt76, intr, dev->mt76.mmio.irqmask);
+
+	mask |= intr & MT_INT_RX_DONE_ALL;
+	if (intr & MT_INT_TX_DONE_MCU)
+		mask |= MT_INT_TX_DONE_MCU;
+
+	if (intr & MT_INT_MCU_CMD) {
+		u32 intr_sw;
+
+		intr_sw = mt76_rr(dev, MT_MCU_CMD);
+		/* ack MCU2HOST_SW_INT_STA */
+		mt76_wr(dev, MT_MCU_CMD, intr_sw);
+		if (intr_sw & MT_MCU_CMD_WAKE_RX_PCIE) {
+			mask |= MT_INT_RX_DONE_DATA;
+			intr |= MT_INT_RX_DONE_DATA;
+		}
+	}
+
+	mt76_set_irq_mask(&dev->mt76, MT_WFDMA0_HOST_INT_ENA, mask, 0);
+
+	if (intr & MT_INT_TX_DONE_ALL)
+		napi_schedule(&dev->mt76.tx_napi);
+
+	if (intr & MT_INT_RX_DONE_WM)
+		napi_schedule(&dev->mt76.napi[MT_RXQ_MCU]);
+
+	if (intr & MT_INT_RX_DONE_WM2)
+		napi_schedule(&dev->mt76.napi[MT_RXQ_MCU_WA]);
+
+	if (intr & MT_INT_RX_DONE_DATA)
+		napi_schedule(&dev->mt76.napi[MT_RXQ_MAIN]);
+}
+
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
+	cancel_work_sync(&dev->init_work);
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
+	skb_queue_purge(&dev->mt76.mcu.res_q);
+
+	tasklet_disable(&dev->irq_tasklet);
+}
+
+static u32 __mt7921_reg_addr(struct mt7921_dev *dev, u32 addr)
+{
+	static const struct mt76_connac_reg_map fixed_map[] = {
+		{ 0x820d0000, 0x30000, 0x10000 }, /* WF_LMAC_TOP (WF_WTBLON) */
+		{ 0x820ed000, 0x24800, 0x00800 }, /* WF_LMAC_TOP BN0 (WF_MIB) */
+		{ 0x820e4000, 0x21000, 0x00400 }, /* WF_LMAC_TOP BN0 (WF_TMAC) */
+		{ 0x820e7000, 0x21e00, 0x00200 }, /* WF_LMAC_TOP BN0 (WF_DMA) */
+		{ 0x820eb000, 0x24200, 0x00400 }, /* WF_LMAC_TOP BN0 (WF_LPON) */
+		{ 0x820e2000, 0x20800, 0x00400 }, /* WF_LMAC_TOP BN0 (WF_AGG) */
+		{ 0x820e3000, 0x20c00, 0x00400 }, /* WF_LMAC_TOP BN0 (WF_ARB) */
+		{ 0x820e5000, 0x21400, 0x00800 }, /* WF_LMAC_TOP BN0 (WF_RMAC) */
+		{ 0x00400000, 0x80000, 0x10000 }, /* WF_MCU_SYSRAM */
+		{ 0x00410000, 0x90000, 0x10000 }, /* WF_MCU_SYSRAM (configure register) */
+		{ 0x40000000, 0x70000, 0x10000 }, /* WF_UMAC_SYSRAM */
+		{ 0x54000000, 0x02000, 0x01000 }, /* WFDMA PCIE0 MCU DMA0 */
+		{ 0x55000000, 0x03000, 0x01000 }, /* WFDMA PCIE0 MCU DMA1 */
+		{ 0x58000000, 0x06000, 0x01000 }, /* WFDMA PCIE1 MCU DMA0 (MEM_DMA) */
+		{ 0x59000000, 0x07000, 0x01000 }, /* WFDMA PCIE1 MCU DMA1 */
+		{ 0x7c000000, 0xf0000, 0x10000 }, /* CONN_INFRA */
+		{ 0x7c020000, 0xd0000, 0x10000 }, /* CONN_INFRA, WFDMA */
+		{ 0x7c060000, 0xe0000, 0x10000 }, /* CONN_INFRA, conn_host_csr_top */
+		{ 0x80020000, 0xb0000, 0x10000 }, /* WF_TOP_MISC_OFF */
+		{ 0x81020000, 0xc0000, 0x10000 }, /* WF_TOP_MISC_ON */
+		{ 0x820c0000, 0x08000, 0x04000 }, /* WF_UMAC_TOP (PLE) */
+		{ 0x820c8000, 0x0c000, 0x02000 }, /* WF_UMAC_TOP (PSE) */
+		{ 0x820cc000, 0x0e000, 0x01000 }, /* WF_UMAC_TOP (PP) */
+		{ 0x820cd000, 0x0f000, 0x01000 }, /* WF_MDP_TOP */
+		{ 0x820ce000, 0x21c00, 0x00200 }, /* WF_LMAC_TOP (WF_SEC) */
+		{ 0x820cf000, 0x22000, 0x01000 }, /* WF_LMAC_TOP (WF_PF) */
+		{ 0x820e0000, 0x20000, 0x00400 }, /* WF_LMAC_TOP BN0 (WF_CFG) */
+		{ 0x820e1000, 0x20400, 0x00200 }, /* WF_LMAC_TOP BN0 (WF_TRB) */
+		{ 0x820e9000, 0x23400, 0x00200 }, /* WF_LMAC_TOP BN0 (WF_WTBLOFF) */
+		{ 0x820ea000, 0x24000, 0x00200 }, /* WF_LMAC_TOP BN0 (WF_ETBF) */
+		{ 0x820ec000, 0x24600, 0x00200 }, /* WF_LMAC_TOP BN0 (WF_INT) */
+		{ 0x820f0000, 0xa0000, 0x00400 }, /* WF_LMAC_TOP BN1 (WF_CFG) */
+		{ 0x820f1000, 0xa0600, 0x00200 }, /* WF_LMAC_TOP BN1 (WF_TRB) */
+		{ 0x820f2000, 0xa0800, 0x00400 }, /* WF_LMAC_TOP BN1 (WF_AGG) */
+		{ 0x820f3000, 0xa0c00, 0x00400 }, /* WF_LMAC_TOP BN1 (WF_ARB) */
+		{ 0x820f4000, 0xa1000, 0x00400 }, /* WF_LMAC_TOP BN1 (WF_TMAC) */
+		{ 0x820f5000, 0xa1400, 0x00800 }, /* WF_LMAC_TOP BN1 (WF_RMAC) */
+		{ 0x820f7000, 0xa1e00, 0x00200 }, /* WF_LMAC_TOP BN1 (WF_DMA) */
+		{ 0x820f9000, 0xa3400, 0x00200 }, /* WF_LMAC_TOP BN1 (WF_WTBLOFF) */
+		{ 0x820fa000, 0xa4000, 0x00200 }, /* WF_LMAC_TOP BN1 (WF_ETBF) */
+		{ 0x820fb000, 0xa4200, 0x00400 }, /* WF_LMAC_TOP BN1 (WF_LPON) */
+		{ 0x820fc000, 0xa4600, 0x00200 }, /* WF_LMAC_TOP BN1 (WF_INT) */
+		{ 0x820fd000, 0xa4800, 0x00800 }, /* WF_LMAC_TOP BN1 (WF_MIB) */
+	};
+	int i;
+
+	if (addr < 0x100000)
+		return addr;
+
+	for (i = 0; i < ARRAY_SIZE(fixed_map); i++) {
+		u32 ofs;
+
+		if (addr < fixed_map[i].phys)
+			continue;
+
+		ofs = addr - fixed_map[i].phys;
+		if (ofs > fixed_map[i].size)
+			continue;
+
+		return fixed_map[i].maps + ofs;
+	}
+
+	if ((addr >= 0x18000000 && addr < 0x18c00000) ||
+	    (addr >= 0x70000000 && addr < 0x78000000) ||
+	    (addr >= 0x7c000000 && addr < 0x7c400000))
+		return mt7921_reg_map_l1(dev, addr);
+
+	dev_err(dev->mt76.dev, "Access currently unsupported address %08x\n",
+		addr);
+
+	return 0;
+}
+
+static u32 mt7921_rr(struct mt76_dev *mdev, u32 offset)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	u32 addr = __mt7921_reg_addr(dev, offset);
+
+	return dev->bus_ops->rr(mdev, addr);
+}
+
+static void mt7921_wr(struct mt76_dev *mdev, u32 offset, u32 val)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	u32 addr = __mt7921_reg_addr(dev, offset);
+
+	dev->bus_ops->wr(mdev, addr, val);
+}
+
+static u32 mt7921_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32 val)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	u32 addr = __mt7921_reg_addr(dev, offset);
+
+	return dev->bus_ops->rmw(mdev, addr, mask, val);
+}
+
+static int mt7921_pci_probe(struct pci_dev *pdev,
+			    const struct pci_device_id *id)
+{
+	static const struct mt76_driver_ops drv_ops = {
+		/* txwi_size = txd size + txp size */
+		.txwi_size = MT_TXD_SIZE + sizeof(struct mt76_connac_hw_txp),
+		.drv_flags = MT_DRV_TXWI_NO_FREE | MT_DRV_HW_MGMT_TXQ,
+		.survey_flags = SURVEY_INFO_TIME_TX |
+				SURVEY_INFO_TIME_RX |
+				SURVEY_INFO_TIME_BSS_RX,
+		.token_size = MT7921_TOKEN_SIZE,
+		.tx_prepare_skb = mt7921e_tx_prepare_skb,
+		.tx_complete_skb = mt76_connac_tx_complete_skb,
+		.rx_check = mt7921e_rx_check,
+		.rx_skb = mt7921e_queue_rx_skb,
+		.rx_poll_complete = mt7921_rx_poll_complete,
+		.sta_ps = mt7921_sta_ps,
+		.sta_add = mt7921_mac_sta_add,
+		.sta_assoc = mt7921_mac_sta_assoc,
+		.sta_remove = mt7921_mac_sta_remove,
+		.update_survey = mt7921_update_channel,
+	};
+	static const struct mt7921_hif_ops mt7921_pcie_ops = {
+		.init_reset = mt7921e_init_reset,
+		.reset = mt7921e_mac_reset,
+		.mcu_init = mt7921e_mcu_init,
+		.drv_own = mt7921e_mcu_drv_pmctrl,
+		.fw_own = mt7921e_mcu_fw_pmctrl,
+	};
+
+	struct mt76_bus_ops *bus_ops;
+	struct mt7921_dev *dev;
+	struct mt76_dev *mdev;
+	int ret;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	ret = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
+	if (ret)
+		return ret;
+
+	pci_set_master(pdev);
+
+	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (ret < 0)
+		return ret;
+
+	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
+	if (ret)
+		goto err_free_pci_vec;
+
+	if (mt7921_disable_aspm)
+		mt76_pci_disable_aspm(pdev);
+
+	mdev = mt76_alloc_device(&pdev->dev, sizeof(*dev), &mt7921_ops,
+				 &drv_ops);
+	if (!mdev) {
+		ret = -ENOMEM;
+		goto err_free_pci_vec;
+	}
+
+	dev = container_of(mdev, struct mt7921_dev, mt76);
+	dev->hif_ops = &mt7921_pcie_ops;
+
+	mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
+	tasklet_init(&dev->irq_tasklet, mt7921_irq_tasklet, (unsigned long)dev);
+
+	dev->phy.dev = dev;
+	dev->phy.mt76 = &dev->mt76.phy;
+	dev->mt76.phy.priv = &dev->phy;
+	dev->bus_ops = dev->mt76.bus;
+	bus_ops = devm_kmemdup(dev->mt76.dev, dev->bus_ops, sizeof(*bus_ops),
+			       GFP_KERNEL);
+	if (!bus_ops) {
+		ret = -ENOMEM;
+		goto err_free_dev;
+	}
+
+	bus_ops->rr = mt7921_rr;
+	bus_ops->wr = mt7921_wr;
+	bus_ops->rmw = mt7921_rmw;
+	dev->mt76.bus = bus_ops;
+
+	ret = __mt7921e_mcu_drv_pmctrl(dev);
+	if (ret)
+		goto err_free_dev;
+
+	mdev->rev = (mt7921_l1_rr(dev, MT_HW_CHIPID) << 16) |
+		    (mt7921_l1_rr(dev, MT_HW_REV) & 0xff);
+	dev_info(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
+
+	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
+
+	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
+
+	ret = devm_request_irq(mdev->dev, pdev->irq, mt7921_irq_handler,
+			       IRQF_SHARED, KBUILD_MODNAME, dev);
+	if (ret)
+		goto err_free_dev;
+
+	ret = mt7921_dma_init(dev);
+	if (ret)
+		goto err_free_irq;
+
+	ret = mt7921_register_device(dev);
+	if (ret)
+		goto err_free_irq;
+
+	return 0;
+
+err_free_irq:
+	devm_free_irq(&pdev->dev, pdev->irq, dev);
+err_free_dev:
+	mt76_free_device(&dev->mt76);
+err_free_pci_vec:
+	pci_free_irq_vectors(pdev);
+
+	return ret;
+}
+
+static void mt7921_pci_remove(struct pci_dev *pdev)
+{
+	struct mt76_dev *mdev = pci_get_drvdata(pdev);
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+
+	mt7921e_unregister_device(dev);
+	devm_free_irq(&pdev->dev, pdev->irq, dev);
+	mt76_free_device(&dev->mt76);
+	pci_free_irq_vectors(pdev);
+}
+
+static int mt7921_pci_suspend(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	struct mt76_dev *mdev = pci_get_drvdata(pdev);
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt76_connac_pm *pm = &dev->pm;
+	int i, err;
+
+	pm->suspended = true;
+	cancel_delayed_work_sync(&pm->ps_work);
+	cancel_work_sync(&pm->wake_work);
+
+	err = mt7921_mcu_drv_pmctrl(dev);
+	if (err < 0)
+		goto restore_suspend;
+
+	err = mt76_connac_mcu_set_hif_suspend(mdev, true);
+	if (err)
+		goto restore_suspend;
+
+	/* always enable deep sleep during suspend to reduce
+	 * power consumption
+	 */
+	mt76_connac_mcu_set_deep_sleep(&dev->mt76, true);
+
+	napi_disable(&mdev->tx_napi);
+	mt76_worker_disable(&mdev->tx_worker);
+
+	mt76_for_each_q_rx(mdev, i) {
+		napi_disable(&mdev->napi[i]);
+	}
+
+	/* wait until dma is idle  */
+	mt76_poll(dev, MT_WFDMA0_GLO_CFG,
+		  MT_WFDMA0_GLO_CFG_TX_DMA_BUSY |
+		  MT_WFDMA0_GLO_CFG_RX_DMA_BUSY, 0, 1000);
+
+	/* put dma disabled */
+	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
+		   MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
+
+	/* disable interrupt */
+	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
+	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
+	synchronize_irq(pdev->irq);
+	tasklet_kill(&dev->irq_tasklet);
+
+	err = mt7921_mcu_fw_pmctrl(dev);
+	if (err)
+		goto restore_napi;
+
+	if (err)
+		goto restore_napi;
+
+	return 0;
+
+restore_napi:
+	mt76_for_each_q_rx(mdev, i) {
+		napi_enable(&mdev->napi[i]);
+	}
+	napi_enable(&mdev->tx_napi);
+
+	if (!pm->ds_enable)
+		mt76_connac_mcu_set_deep_sleep(&dev->mt76, false);
+
+	mt76_connac_mcu_set_hif_suspend(mdev, false);
+
+restore_suspend:
+	pm->suspended = false;
+
+	return err;
+}
+
+static int mt7921_pci_resume(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	struct mt76_dev *mdev = pci_get_drvdata(pdev);
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct mt76_connac_pm *pm = &dev->pm;
+	int i, err;
+
+	err = mt7921_mcu_drv_pmctrl(dev);
+	if (err < 0)
+		return err;
+
+	mt7921_wpdma_reinit_cond(dev);
+
+	/* enable interrupt */
+	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
+	mt7921_irq_enable(dev, MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
+			  MT_INT_MCU_CMD);
+	mt76_set(dev, MT_MCU2HOST_SW_INT_ENA, MT_MCU_CMD_WAKE_RX_PCIE);
+
+	/* put dma enabled */
+	mt76_set(dev, MT_WFDMA0_GLO_CFG,
+		 MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
+
+	mt76_worker_enable(&mdev->tx_worker);
+
+	local_bh_disable();
+	mt76_for_each_q_rx(mdev, i) {
+		napi_enable(&mdev->napi[i]);
+		napi_schedule(&mdev->napi[i]);
+	}
+	napi_enable(&mdev->tx_napi);
+	napi_schedule(&mdev->tx_napi);
+	local_bh_enable();
+
+	/* restore previous ds setting */
+	if (!pm->ds_enable)
+		mt76_connac_mcu_set_deep_sleep(&dev->mt76, false);
+
+	err = mt76_connac_mcu_set_hif_suspend(mdev, false);
+	if (err)
+		return err;
+
+	pm->suspended = false;
+
+	return err;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(mt7921_pm_ops, mt7921_pci_suspend, mt7921_pci_resume);
+
+static struct pci_driver mt7921_pci_driver = {
+	.name		= KBUILD_MODNAME,
+	.id_table	= mt7921_pci_device_table,
+	.probe		= mt7921_pci_probe,
+	.remove		= mt7921_pci_remove,
+	.driver.pm	= pm_sleep_ptr(&mt7921_pm_ops),
+};
+
+module_pci_driver(mt7921_pci_driver);
+
+MODULE_DEVICE_TABLE(pci, mt7921_pci_device_table);
+MODULE_FIRMWARE(MT7921_FIRMWARE_WM);
+MODULE_FIRMWARE(MT7921_ROM_PATCH);
+MODULE_FIRMWARE(MT7922_FIRMWARE_WM);
+MODULE_FIRMWARE(MT7922_ROM_PATCH);
+MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
+MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c.orig b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c.orig
new file mode 100644
index 000000000000..f9547d27356e
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c.orig
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2021 MediaTek Inc. */
+
+#include "mt7921.h"
+#include "../dma.h"
+#include "mac.h"
+
+static void
+mt7921_write_hw_txp(struct mt7921_dev *dev, struct mt76_tx_info *tx_info,
+		    void *txp_ptr, u32 id)
+{
+	struct mt7921_hw_txp *txp = txp_ptr;
+	struct mt7921_txp_ptr *ptr = &txp->ptr[0];
+	int i, nbuf = tx_info->nbuf - 1;
+
+	tx_info->buf[0].len = MT_TXD_SIZE + sizeof(*txp);
+	tx_info->nbuf = 1;
+
+	txp->msdu_id[0] = cpu_to_le16(id | MT_MSDU_ID_VALID);
+
+	for (i = 0; i < nbuf; i++) {
+		u16 len = tx_info->buf[i + 1].len & MT_TXD_LEN_MASK;
+		u32 addr = tx_info->buf[i + 1].addr;
+
+		if (i == nbuf - 1)
+			len |= MT_TXD_LEN_LAST;
+
+		if (i & 1) {
+			ptr->buf1 = cpu_to_le32(addr);
+			ptr->len1 = cpu_to_le16(len);
+			ptr++;
+		} else {
+			ptr->buf0 = cpu_to_le32(addr);
+			ptr->len0 = cpu_to_le16(len);
+		}
+	}
+}
+
+int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
+			   enum mt76_txq_id qid, struct mt76_wcid *wcid,
+			   struct ieee80211_sta *sta,
+			   struct mt76_tx_info *tx_info)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
+	struct ieee80211_key_conf *key = info->control.hw_key;
+	struct mt76_txwi_cache *t;
+	struct mt7921_txp_common *txp;
+	int id, pid;
+	u8 *txwi = (u8 *)txwi_ptr;
+
+	if (unlikely(tx_info->skb->len <= ETH_HLEN))
+		return -EINVAL;
+
+	if (!wcid)
+		wcid = &dev->mt76.global_wcid;
+
+	t = (struct mt76_txwi_cache *)(txwi + mdev->drv->txwi_size);
+	t->skb = tx_info->skb;
+
+	id = mt76_token_consume(mdev, &t);
+	if (id < 0)
+		return id;
+
+	if (sta) {
+		struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+
+		if (time_after(jiffies, msta->last_txs + HZ / 4)) {
+			info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
+			msta->last_txs = jiffies;
+		}
+	}
+
+	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
+	mt7921_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, key,
+			      pid, false);
+
+	txp = (struct mt7921_txp_common *)(txwi + MT_TXD_SIZE);
+	memset(txp, 0, sizeof(struct mt7921_txp_common));
+	mt7921_write_hw_txp(dev, tx_info, txp, id);
+
+	tx_info->skb = DMA_DUMMY_DATA;
+
+	return 0;
+}
+
+static void
+mt7921_txp_skb_unmap(struct mt76_dev *dev, struct mt76_txwi_cache *t)
+{
+	struct mt7921_txp_common *txp;
+	int i;
+
+	txp = mt7921_txwi_to_txp(dev, t);
+
+	for (i = 0; i < ARRAY_SIZE(txp->hw.ptr); i++) {
+		struct mt7921_txp_ptr *ptr = &txp->hw.ptr[i];
+		bool last;
+		u16 len;
+
+		len = le16_to_cpu(ptr->len0);
+		last = len & MT_TXD_LEN_LAST;
+		len &= MT_TXD_LEN_MASK;
+		dma_unmap_single(dev->dev, le32_to_cpu(ptr->buf0), len,
+				 DMA_TO_DEVICE);
+		if (last)
+			break;
+
+		len = le16_to_cpu(ptr->len1);
+		last = len & MT_TXD_LEN_LAST;
+		len &= MT_TXD_LEN_MASK;
+		dma_unmap_single(dev->dev, le32_to_cpu(ptr->buf1), len,
+				 DMA_TO_DEVICE);
+		if (last)
+			break;
+	}
+}
+
+static void
+mt7921_txwi_free(struct mt7921_dev *dev, struct mt76_txwi_cache *t,
+		 struct ieee80211_sta *sta, bool clear_status,
+		 struct list_head *free_list)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+	__le32 *txwi;
+	u16 wcid_idx;
+
+	mt7921_txp_skb_unmap(mdev, t);
+	if (!t->skb)
+		goto out;
+
+	txwi = (__le32 *)mt76_get_txwi_ptr(mdev, t);
+	if (sta) {
+		struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
+
+		if (likely(t->skb->protocol != cpu_to_be16(ETH_P_PAE)))
+			mt7921_tx_check_aggr(sta, txwi);
+
+		wcid_idx = wcid->idx;
+	} else {
+		wcid_idx = FIELD_GET(MT_TXD1_WLAN_IDX, le32_to_cpu(txwi[1]));
+	}
+
+	__mt76_tx_complete_skb(mdev, wcid_idx, t->skb, free_list);
+
+out:
+	t->skb = NULL;
+	mt76_put_txwi(mdev, t);
+}
+
+static void
+mt7921_mac_tx_free(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt7921_tx_free *free = (struct mt7921_tx_free *)skb->data;
+	struct mt76_dev *mdev = &dev->mt76;
+	struct mt76_txwi_cache *txwi;
+	struct ieee80211_sta *sta = NULL;
+	LIST_HEAD(free_list);
+	struct sk_buff *tmp;
+	bool wake = false;
+	u8 i, count;
+
+	/* clean DMA queues and unmap buffers first */
+	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
+	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_BE], false);
+
+	/* TODO: MT_TX_FREE_LATENCY is msdu time from the TXD is queued into PLE,
+	 * to the time ack is received or dropped by hw (air + hw queue time).
+	 * Should avoid accessing WTBL to get Tx airtime, and use it instead.
+	 */
+	count = FIELD_GET(MT_TX_FREE_MSDU_CNT, le16_to_cpu(free->ctrl));
+	for (i = 0; i < count; i++) {
+		u32 msdu, info = le32_to_cpu(free->info[i]);
+		u8 stat;
+
+		/* 1'b1: new wcid pair.
+		 * 1'b0: msdu_id with the same 'wcid pair' as above.
+		 */
+		if (info & MT_TX_FREE_PAIR) {
+			struct mt7921_sta *msta;
+			struct mt76_wcid *wcid;
+			u16 idx;
+
+			count++;
+			idx = FIELD_GET(MT_TX_FREE_WLAN_ID, info);
+			wcid = rcu_dereference(dev->mt76.wcid[idx]);
+			sta = wcid_to_sta(wcid);
+			if (!sta)
+				continue;
+
+			msta = container_of(wcid, struct mt7921_sta, wcid);
+			spin_lock_bh(&dev->sta_poll_lock);
+			if (list_empty(&msta->poll_list))
+				list_add_tail(&msta->poll_list, &dev->sta_poll_list);
+			spin_unlock_bh(&dev->sta_poll_lock);
+			continue;
+		}
+
+		msdu = FIELD_GET(MT_TX_FREE_MSDU_ID, info);
+		stat = FIELD_GET(MT_TX_FREE_STATUS, info);
+
+		txwi = mt76_token_release(mdev, msdu, &wake);
+		if (!txwi)
+			continue;
+
+		mt7921_txwi_free(dev, txwi, sta, stat, &free_list);
+	}
+
+	if (wake)
+		mt76_set_tx_blocked(&dev->mt76, false);
+
+	napi_consume_skb(skb, 1);
+
+	list_for_each_entry_safe(skb, tmp, &free_list, list) {
+		skb_list_del_init(skb);
+		napi_consume_skb(skb, 1);
+	}
+
+	rcu_read_lock();
+	mt7921_mac_sta_poll(dev);
+	rcu_read_unlock();
+
+	mt76_worker_schedule(&dev->mt76.tx_worker);
+}
+
+void mt7921e_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
+			  struct sk_buff *skb)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	__le32 *rxd = (__le32 *)skb->data;
+	enum rx_pkt_type type;
+
+	type = FIELD_GET(MT_RXD0_PKT_TYPE, le32_to_cpu(rxd[0]));
+
+	switch (type) {
+	case PKT_TYPE_TXRX_NOTIFY:
+		mt7921_mac_tx_free(dev, skb);
+		break;
+	default:
+		mt7921_queue_rx_skb(mdev, q, skb);
+		break;
+	}
+}
+
+void mt7921e_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
+{
+	if (!e->txwi) {
+		dev_kfree_skb_any(e->skb);
+		return;
+	}
+
+	/* error path */
+	if (e->skb == DMA_DUMMY_DATA) {
+		struct mt76_txwi_cache *t;
+		struct mt7921_txp_common *txp;
+		u16 token;
+
+		txp = mt7921_txwi_to_txp(mdev, e->txwi);
+		token = le16_to_cpu(txp->hw.msdu_id[0]) & ~MT_MSDU_ID_VALID;
+		t = mt76_token_put(mdev, token);
+		e->skb = t ? t->skb : NULL;
+	}
+
+	if (e->skb)
+		mt76_tx_complete_skb(mdev, e->wcid, e->skb);
+}
+
+void mt7921_tx_token_put(struct mt7921_dev *dev)
+{
+	struct mt76_txwi_cache *txwi;
+	int id;
+
+	spin_lock_bh(&dev->mt76.token_lock);
+	idr_for_each_entry(&dev->mt76.token, txwi, id) {
+		mt7921_txwi_free(dev, txwi, NULL, false, NULL);
+		dev->mt76.token_count--;
+	}
+	spin_unlock_bh(&dev->mt76.token_lock);
+	idr_destroy(&dev->mt76.token);
+}
+
+int mt7921e_mac_reset(struct mt7921_dev *dev)
+{
+	int i, err;
+
+	mt7921e_mcu_drv_pmctrl(dev);
+
+	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
+
+	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
+	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
+
+	set_bit(MT76_RESET, &dev->mphy.state);
+	set_bit(MT76_MCU_RESET, &dev->mphy.state);
+	wake_up(&dev->mt76.mcu.wait);
+	skb_queue_purge(&dev->mt76.mcu.res_q);
+
+	mt76_txq_schedule_all(&dev->mphy);
+
+	mt76_worker_disable(&dev->mt76.tx_worker);
+	napi_disable(&dev->mt76.napi[MT_RXQ_MAIN]);
+	napi_disable(&dev->mt76.napi[MT_RXQ_MCU]);
+	napi_disable(&dev->mt76.napi[MT_RXQ_MCU_WA]);
+	napi_disable(&dev->mt76.tx_napi);
+
+	mt7921_tx_token_put(dev);
+	idr_init(&dev->mt76.token);
+
+	mt7921_wpdma_reset(dev, true);
+
+	local_bh_disable();
+	mt76_for_each_q_rx(&dev->mt76, i) {
+		napi_enable(&dev->mt76.napi[i]);
+		napi_schedule(&dev->mt76.napi[i]);
+	}
+	local_bh_enable();
+
+	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
+
+	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA,
+		MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
+		MT_INT_MCU_CMD);
+	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
+
+	err = mt7921_run_firmware(dev);
+	if (err)
+		goto out;
+
+	err = mt7921_mcu_set_eeprom(dev);
+	if (err)
+		goto out;
+
+	err = mt7921_mac_init(dev);
+	if (err)
+		goto out;
+
+	err = __mt7921_start(&dev->phy);
+out:
+	clear_bit(MT76_RESET, &dev->mphy.state);
+
+	local_bh_disable();
+	napi_enable(&dev->mt76.tx_napi);
+	napi_schedule(&dev->mt76.tx_napi);
+	local_bh_enable();
+
+	mt76_worker_enable(&dev->mt76.tx_worker);
+
+	return err;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c.orig b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c.orig
new file mode 100644
index 000000000000..487acd6e2be8
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c.orig
@@ -0,0 +1,322 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2021 MediaTek Inc.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+
+#include <linux/mmc/host.h>
+#include <linux/mmc/sdio_ids.h>
+#include <linux/mmc/sdio_func.h>
+
+#include "mt7921.h"
+#include "../sdio.h"
+#include "mac.h"
+#include "mcu.h"
+
+static const struct sdio_device_id mt7921s_table[] = {
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_MEDIATEK, 0x7901) },
+	{ }	/* Terminating entry */
+};
+
+static void mt7921s_txrx_worker(struct mt76_worker *w)
+{
+	struct mt76_sdio *sdio = container_of(w, struct mt76_sdio,
+					      txrx_worker);
+	struct mt76_dev *mdev = container_of(sdio, struct mt76_dev, sdio);
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+
+	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm)) {
+		queue_work(mdev->wq, &dev->pm.wake_work);
+		return;
+	}
+
+	mt76s_txrx_worker(sdio);
+	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
+}
+
+static void mt7921s_unregister_device(struct mt7921_dev *dev)
+{
+	struct mt76_connac_pm *pm = &dev->pm;
+
+	cancel_work_sync(&dev->init_work);
+	mt76_unregister_device(&dev->mt76);
+	cancel_delayed_work_sync(&pm->ps_work);
+	cancel_work_sync(&pm->wake_work);
+
+	mt76s_deinit(&dev->mt76);
+	mt7921s_wfsys_reset(dev);
+	skb_queue_purge(&dev->mt76.mcu.res_q);
+
+	mt76_free_device(&dev->mt76);
+}
+
+static int mt7921s_parse_intr(struct mt76_dev *dev, struct mt76s_intr *intr)
+{
+	struct mt76_sdio *sdio = &dev->sdio;
+	struct mt7921_sdio_intr *irq_data = sdio->intr_data;
+	int i, err;
+
+	sdio_claim_host(sdio->func);
+	err = sdio_readsb(sdio->func, irq_data, MCR_WHISR, sizeof(*irq_data));
+	sdio_release_host(sdio->func);
+
+	if (err < 0)
+		return err;
+
+	if (irq_data->rx.num[0] > 16 ||
+	    irq_data->rx.num[1] > 128)
+		return -EINVAL;
+
+	intr->isr = irq_data->isr;
+	intr->rec_mb = irq_data->rec_mb;
+	intr->tx.wtqcr = irq_data->tx.wtqcr;
+	intr->rx.num = irq_data->rx.num;
+	for (i = 0; i < 2 ; i++) {
+		if (!i)
+			intr->rx.len[0] = irq_data->rx.len0;
+		else
+			intr->rx.len[1] = irq_data->rx.len1;
+	}
+
+	return 0;
+}
+
+static int mt7921s_probe(struct sdio_func *func,
+			 const struct sdio_device_id *id)
+{
+	static const struct mt76_driver_ops drv_ops = {
+		.txwi_size = MT_SDIO_TXD_SIZE,
+		.survey_flags = SURVEY_INFO_TIME_TX |
+				SURVEY_INFO_TIME_RX |
+				SURVEY_INFO_TIME_BSS_RX,
+		.tx_prepare_skb = mt7921_usb_sdio_tx_prepare_skb,
+		.tx_complete_skb = mt7921_usb_sdio_tx_complete_skb,
+		.tx_status_data = mt7921_usb_sdio_tx_status_data,
+		.rx_skb = mt7921_queue_rx_skb,
+		.sta_ps = mt7921_sta_ps,
+		.sta_add = mt7921_mac_sta_add,
+		.sta_assoc = mt7921_mac_sta_assoc,
+		.sta_remove = mt7921_mac_sta_remove,
+		.update_survey = mt7921_update_channel,
+	};
+	static const struct mt76_bus_ops mt7921s_ops = {
+		.rr = mt76s_rr,
+		.rmw = mt76s_rmw,
+		.wr = mt76s_wr,
+		.write_copy = mt76s_write_copy,
+		.read_copy = mt76s_read_copy,
+		.wr_rp = mt76s_wr_rp,
+		.rd_rp = mt76s_rd_rp,
+		.type = MT76_BUS_SDIO,
+	};
+	static const struct mt7921_hif_ops mt7921_sdio_ops = {
+		.init_reset = mt7921s_init_reset,
+		.reset = mt7921s_mac_reset,
+		.mcu_init = mt7921s_mcu_init,
+		.drv_own = mt7921s_mcu_drv_pmctrl,
+		.fw_own = mt7921s_mcu_fw_pmctrl,
+	};
+
+	struct mt7921_dev *dev;
+	struct mt76_dev *mdev;
+	int ret;
+
+	mdev = mt76_alloc_device(&func->dev, sizeof(*dev), &mt7921_ops,
+				 &drv_ops);
+	if (!mdev)
+		return -ENOMEM;
+
+	dev = container_of(mdev, struct mt7921_dev, mt76);
+	dev->hif_ops = &mt7921_sdio_ops;
+
+	sdio_set_drvdata(func, dev);
+
+	ret = mt76s_init(mdev, func, &mt7921s_ops);
+	if (ret < 0)
+		goto error;
+
+	ret = mt76s_hw_init(mdev, func, MT76_CONNAC2_SDIO);
+	if (ret)
+		goto error;
+
+	mdev->rev = (mt76_rr(dev, MT_HW_CHIPID) << 16) |
+		    (mt76_rr(dev, MT_HW_REV) & 0xff);
+	dev_dbg(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
+
+	mdev->sdio.parse_irq = mt7921s_parse_intr;
+	mdev->sdio.intr_data = devm_kmalloc(mdev->dev,
+					    sizeof(struct mt7921_sdio_intr),
+					    GFP_KERNEL);
+	if (!mdev->sdio.intr_data) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	ret = mt76s_alloc_rx_queue(mdev, MT_RXQ_MAIN);
+	if (ret)
+		goto error;
+
+	ret = mt76s_alloc_rx_queue(mdev, MT_RXQ_MCU);
+	if (ret)
+		goto error;
+
+	ret = mt76s_alloc_tx(mdev);
+	if (ret)
+		goto error;
+
+	ret = mt76_worker_setup(mt76_hw(dev), &mdev->sdio.txrx_worker,
+				mt7921s_txrx_worker, "sdio-txrx");
+	if (ret)
+		goto error;
+
+	sched_set_fifo_low(mdev->sdio.txrx_worker.task);
+
+	ret = mt7921_register_device(dev);
+	if (ret)
+		goto error;
+
+	return 0;
+
+error:
+	mt76s_deinit(&dev->mt76);
+	mt76_free_device(&dev->mt76);
+
+	return ret;
+}
+
+static void mt7921s_remove(struct sdio_func *func)
+{
+	struct mt7921_dev *dev = sdio_get_drvdata(func);
+
+	mt7921s_unregister_device(dev);
+}
+
+#ifdef CONFIG_PM
+static int mt7921s_suspend(struct device *__dev)
+{
+	struct sdio_func *func = dev_to_sdio_func(__dev);
+	struct mt7921_dev *dev = sdio_get_drvdata(func);
+	struct mt76_connac_pm *pm = &dev->pm;
+	struct mt76_dev *mdev = &dev->mt76;
+	int err;
+
+	pm->suspended = true;
+	set_bit(MT76_STATE_SUSPEND, &mdev->phy.state);
+
+	cancel_delayed_work_sync(&pm->ps_work);
+	cancel_work_sync(&pm->wake_work);
+
+	err = mt7921_mcu_drv_pmctrl(dev);
+	if (err < 0)
+		goto restore_suspend;
+
+	/* always enable deep sleep during suspend to reduce
+	 * power consumption
+	 */
+	mt76_connac_mcu_set_deep_sleep(mdev, true);
+
+	mt76_txq_schedule_all(&dev->mphy);
+	mt76_worker_disable(&mdev->tx_worker);
+	mt76_worker_disable(&mdev->sdio.status_worker);
+	cancel_work_sync(&mdev->sdio.stat_work);
+	clear_bit(MT76_READING_STATS, &dev->mphy.state);
+	mt76_tx_status_check(mdev, true);
+
+	mt76_worker_schedule(&mdev->sdio.txrx_worker);
+	wait_event_timeout(dev->mt76.sdio.wait,
+			   mt76s_txqs_empty(&dev->mt76), 5 * HZ);
+
+	/* It is supposed that SDIO bus is idle at the point */
+	err = mt76_connac_mcu_set_hif_suspend(mdev, true);
+	if (err)
+		goto restore_worker;
+
+	mt76_worker_disable(&mdev->sdio.txrx_worker);
+	mt76_worker_disable(&mdev->sdio.net_worker);
+
+	err = mt7921_mcu_fw_pmctrl(dev);
+	if (err)
+		goto restore_txrx_worker;
+
+	sdio_set_host_pm_flags(func, MMC_PM_KEEP_POWER);
+
+	return 0;
+
+restore_txrx_worker:
+	mt76_worker_enable(&mdev->sdio.net_worker);
+	mt76_worker_enable(&mdev->sdio.txrx_worker);
+	mt76_connac_mcu_set_hif_suspend(mdev, false);
+
+restore_worker:
+	mt76_worker_enable(&mdev->tx_worker);
+	mt76_worker_enable(&mdev->sdio.status_worker);
+
+	if (!pm->ds_enable)
+		mt76_connac_mcu_set_deep_sleep(mdev, false);
+
+restore_suspend:
+	clear_bit(MT76_STATE_SUSPEND, &mdev->phy.state);
+	pm->suspended = false;
+
+	return err;
+}
+
+static int mt7921s_resume(struct device *__dev)
+{
+	struct sdio_func *func = dev_to_sdio_func(__dev);
+	struct mt7921_dev *dev = sdio_get_drvdata(func);
+	struct mt76_connac_pm *pm = &dev->pm;
+	struct mt76_dev *mdev = &dev->mt76;
+	int err;
+
+	clear_bit(MT76_STATE_SUSPEND, &mdev->phy.state);
+
+	err = mt7921_mcu_drv_pmctrl(dev);
+	if (err < 0)
+		return err;
+
+	mt76_worker_enable(&mdev->tx_worker);
+	mt76_worker_enable(&mdev->sdio.txrx_worker);
+	mt76_worker_enable(&mdev->sdio.status_worker);
+	mt76_worker_enable(&mdev->sdio.net_worker);
+
+	/* restore previous ds setting */
+	if (!pm->ds_enable)
+		mt76_connac_mcu_set_deep_sleep(mdev, false);
+
+	err = mt76_connac_mcu_set_hif_suspend(mdev, false);
+	if (err)
+		return err;
+
+	pm->suspended = false;
+
+	return err;
+}
+
+static const struct dev_pm_ops mt7921s_pm_ops = {
+	.suspend = mt7921s_suspend,
+	.resume = mt7921s_resume,
+};
+#endif
+
+MODULE_DEVICE_TABLE(sdio, mt7921s_table);
+MODULE_FIRMWARE(MT7921_FIRMWARE_WM);
+MODULE_FIRMWARE(MT7921_ROM_PATCH);
+
+static struct sdio_driver mt7921s_driver = {
+	.name		= KBUILD_MODNAME,
+	.probe		= mt7921s_probe,
+	.remove		= mt7921s_remove,
+	.id_table	= mt7921s_table,
+#ifdef CONFIG_PM
+	.drv = {
+		.pm = &mt7921s_pm_ops,
+	}
+#endif
+};
+module_sdio_driver(mt7921s_driver);
+MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c.orig b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c.orig
new file mode 100644
index 000000000000..1b3adb3d91e8
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c.orig
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2021 MediaTek Inc. */
+
+#include <linux/iopoll.h>
+#include <linux/mmc/sdio_func.h>
+#include "mt7921.h"
+#include "mac.h"
+#include "../sdio.h"
+
+static void mt7921s_enable_irq(struct mt76_dev *dev)
+{
+	struct mt76_sdio *sdio = &dev->sdio;
+
+	sdio_claim_host(sdio->func);
+	sdio_writel(sdio->func, WHLPCR_INT_EN_SET, MCR_WHLPCR, NULL);
+	sdio_release_host(sdio->func);
+}
+
+static void mt7921s_disable_irq(struct mt76_dev *dev)
+{
+	struct mt76_sdio *sdio = &dev->sdio;
+
+	sdio_claim_host(sdio->func);
+	sdio_writel(sdio->func, WHLPCR_INT_EN_CLR, MCR_WHLPCR, NULL);
+	sdio_release_host(sdio->func);
+}
+
+static u32 mt7921s_read_whcr(struct mt76_dev *dev)
+{
+	return sdio_readl(dev->sdio.func, MCR_WHCR, NULL);
+}
+
+int mt7921s_wfsys_reset(struct mt7921_dev *dev)
+{
+	struct mt76_sdio *sdio = &dev->mt76.sdio;
+	u32 val, status;
+
+	mt7921s_mcu_drv_pmctrl(dev);
+
+	sdio_claim_host(sdio->func);
+
+	val = sdio_readl(sdio->func, MCR_WHCR, NULL);
+	val &= ~WF_WHOLE_PATH_RSTB;
+	sdio_writel(sdio->func, val, MCR_WHCR, NULL);
+
+	msleep(50);
+
+	val = sdio_readl(sdio->func, MCR_WHCR, NULL);
+	val &= ~WF_SDIO_WF_PATH_RSTB;
+	sdio_writel(sdio->func, val, MCR_WHCR, NULL);
+
+	usleep_range(1000, 2000);
+
+	val = sdio_readl(sdio->func, MCR_WHCR, NULL);
+	val |= WF_WHOLE_PATH_RSTB;
+	sdio_writel(sdio->func, val, MCR_WHCR, NULL);
+
+	readx_poll_timeout(mt7921s_read_whcr, &dev->mt76, status,
+			   status & WF_RST_DONE, 50000, 2000000);
+
+	sdio_release_host(sdio->func);
+
+	clear_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
+
+	/* activate mt7921s again */
+	mt7921s_mcu_drv_pmctrl(dev);
+	mt76_clear(dev, MT_CONN_STATUS, MT_WIFI_PATCH_DL_STATE);
+	mt7921s_mcu_fw_pmctrl(dev);
+	mt7921s_mcu_drv_pmctrl(dev);
+
+	return 0;
+}
+
+int mt7921s_init_reset(struct mt7921_dev *dev)
+{
+	set_bit(MT76_MCU_RESET, &dev->mphy.state);
+
+	wake_up(&dev->mt76.mcu.wait);
+	skb_queue_purge(&dev->mt76.mcu.res_q);
+	wait_event_timeout(dev->mt76.sdio.wait,
+			   mt76s_txqs_empty(&dev->mt76), 5 * HZ);
+	mt76_worker_disable(&dev->mt76.sdio.txrx_worker);
+
+	mt7921s_disable_irq(&dev->mt76);
+	mt7921s_wfsys_reset(dev);
+
+	mt76_worker_enable(&dev->mt76.sdio.txrx_worker);
+	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
+	mt7921s_enable_irq(&dev->mt76);
+
+	return 0;
+}
+
+int mt7921s_mac_reset(struct mt7921_dev *dev)
+{
+	int err;
+
+	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
+	mt76_txq_schedule_all(&dev->mphy);
+	mt76_worker_disable(&dev->mt76.tx_worker);
+	set_bit(MT76_RESET, &dev->mphy.state);
+	set_bit(MT76_MCU_RESET, &dev->mphy.state);
+	wake_up(&dev->mt76.mcu.wait);
+	skb_queue_purge(&dev->mt76.mcu.res_q);
+	wait_event_timeout(dev->mt76.sdio.wait,
+			   mt76s_txqs_empty(&dev->mt76), 5 * HZ);
+	mt76_worker_disable(&dev->mt76.sdio.txrx_worker);
+	mt76_worker_disable(&dev->mt76.sdio.status_worker);
+	mt76_worker_disable(&dev->mt76.sdio.net_worker);
+	cancel_work_sync(&dev->mt76.sdio.stat_work);
+
+	mt7921s_disable_irq(&dev->mt76);
+	mt7921s_wfsys_reset(dev);
+
+	mt76_worker_enable(&dev->mt76.sdio.txrx_worker);
+	mt76_worker_enable(&dev->mt76.sdio.status_worker);
+	mt76_worker_enable(&dev->mt76.sdio.net_worker);
+
+	dev->fw_assert = false;
+	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
+	mt7921s_enable_irq(&dev->mt76);
+
+	err = mt7921_run_firmware(dev);
+	if (err)
+		goto out;
+
+	err = mt7921_mcu_set_eeprom(dev);
+	if (err)
+		goto out;
+
+	err = mt7921_mac_init(dev);
+	if (err)
+		goto out;
+
+	err = __mt7921_start(&dev->phy);
+out:
+	clear_bit(MT76_RESET, &dev->mphy.state);
+
+	mt76_worker_enable(&dev->mt76.tx_worker);
+
+	return err;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 8dba17c8697c..4f35c2f16d0d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -360,10 +360,15 @@ static int mt7925_mac_link_bss_add(struct mt792x_dev *dev,
 	struct mt76_txq *mtxq;
 	int idx, ret = 0;
 
-	mconf->mt76.idx = __ffs64(~dev->mt76.vif_mask);
-	if (mconf->mt76.idx >= MT792x_MAX_INTERFACES) {
-		ret = -ENOSPC;
-		goto out;
+	if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
+		mconf->mt76.idx = MT792x_MAX_INTERFACES;
+	} else {
+		mconf->mt76.idx = __ffs64(~dev->mt76.vif_mask);
+
+		if (mconf->mt76.idx >= MT792x_MAX_INTERFACES) {
+			ret = -ENOSPC;
+			goto out;
+		}
 	}
 
 	mconf->mt76.omac_idx = ieee80211_vif_is_mld(vif) ?
@@ -371,6 +376,7 @@ static int mt7925_mac_link_bss_add(struct mt792x_dev *dev,
 	mconf->mt76.band_idx = 0xff;
 	mconf->mt76.wmm_idx = ieee80211_vif_is_mld(vif) ?
 			      0 : mconf->mt76.idx % MT76_CONNAC_MAX_WMM_SETS;
+	mconf->mt76.link_idx = hweight16(mvif->valid_links);
 
 	if (mvif->phy->mt76->chandef.chan->band != NL80211_BAND_2GHZ)
 		mconf->mt76.basic_rates_idx = MT792x_BASIC_RATES_TBL + 4;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c.orig b/drivers/net/wireless/mediatek/mt76/mt7925/main.c.orig
new file mode 100644
index 000000000000..8dba17c8697c
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c.orig
@@ -0,0 +1,2209 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2023 MediaTek Inc. */
+
+#include <linux/etherdevice.h>
+#include <linux/platform_device.h>
+#include <linux/pci.h>
+#include <linux/module.h>
+#include <linux/ctype.h>
+#include <net/ipv6.h>
+#include "mt7925.h"
+#include "mcu.h"
+#include "mac.h"
+
+static void
+mt7925_init_he_caps(struct mt792x_phy *phy, enum nl80211_band band,
+		    struct ieee80211_sband_iftype_data *data,
+		    enum nl80211_iftype iftype)
+{
+	struct ieee80211_sta_he_cap *he_cap = &data->he_cap;
+	struct ieee80211_he_cap_elem *he_cap_elem = &he_cap->he_cap_elem;
+	struct ieee80211_he_mcs_nss_supp *he_mcs = &he_cap->he_mcs_nss_supp;
+	int i, nss = hweight8(phy->mt76->antenna_mask);
+	u16 mcs_map = 0;
+
+	for (i = 0; i < 8; i++) {
+		if (i < nss)
+			mcs_map |= (IEEE80211_HE_MCS_SUPPORT_0_11 << (i * 2));
+		else
+			mcs_map |= (IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2));
+	}
+
+	he_cap->has_he = true;
+
+	he_cap_elem->mac_cap_info[0] = IEEE80211_HE_MAC_CAP0_HTC_HE;
+	he_cap_elem->mac_cap_info[3] = IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
+				       IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_3;
+	he_cap_elem->mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU;
+
+	if (band == NL80211_BAND_2GHZ)
+		he_cap_elem->phy_cap_info[0] =
+			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
+	else
+		he_cap_elem->phy_cap_info[0] =
+			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
+			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+
+	he_cap_elem->phy_cap_info[1] =
+		IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD;
+	he_cap_elem->phy_cap_info[2] =
+		IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US |
+		IEEE80211_HE_PHY_CAP2_STBC_TX_UNDER_80MHZ |
+		IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ |
+		IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO |
+		IEEE80211_HE_PHY_CAP2_UL_MU_PARTIAL_MU_MIMO;
+
+	switch (iftype) {
+	case NL80211_IFTYPE_AP:
+		he_cap_elem->mac_cap_info[2] |=
+			IEEE80211_HE_MAC_CAP2_BSR;
+		he_cap_elem->mac_cap_info[4] |=
+			IEEE80211_HE_MAC_CAP4_BQR;
+		he_cap_elem->mac_cap_info[5] |=
+			IEEE80211_HE_MAC_CAP5_OM_CTRL_UL_MU_DATA_DIS_RX;
+		he_cap_elem->phy_cap_info[3] |=
+			IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_QPSK |
+			IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_QPSK;
+		he_cap_elem->phy_cap_info[6] |=
+			IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE |
+			IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT;
+		he_cap_elem->phy_cap_info[9] |=
+			IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU |
+			IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU;
+		break;
+	case NL80211_IFTYPE_STATION:
+		he_cap_elem->mac_cap_info[1] |=
+			IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_16US;
+
+		if (band == NL80211_BAND_2GHZ)
+			he_cap_elem->phy_cap_info[0] |=
+				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_2G;
+		else
+			he_cap_elem->phy_cap_info[0] |=
+				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_5G;
+
+		he_cap_elem->phy_cap_info[1] |=
+			IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
+			IEEE80211_HE_PHY_CAP1_HE_LTF_AND_GI_FOR_HE_PPDUS_0_8US;
+		he_cap_elem->phy_cap_info[3] |=
+			IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_QPSK |
+			IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_QPSK;
+		he_cap_elem->phy_cap_info[4] |=
+			IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE |
+			IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_4 |
+			IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_4;
+		he_cap_elem->phy_cap_info[5] |=
+			IEEE80211_HE_PHY_CAP5_NG16_SU_FEEDBACK |
+			IEEE80211_HE_PHY_CAP5_NG16_MU_FEEDBACK;
+		he_cap_elem->phy_cap_info[6] |=
+			IEEE80211_HE_PHY_CAP6_CODEBOOK_SIZE_42_SU |
+			IEEE80211_HE_PHY_CAP6_CODEBOOK_SIZE_75_MU |
+			IEEE80211_HE_PHY_CAP6_TRIG_CQI_FB |
+			IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE |
+			IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT;
+		he_cap_elem->phy_cap_info[7] |=
+			IEEE80211_HE_PHY_CAP7_POWER_BOOST_FACTOR_SUPP |
+			IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI;
+		he_cap_elem->phy_cap_info[8] |=
+			IEEE80211_HE_PHY_CAP8_20MHZ_IN_40MHZ_HE_PPDU_IN_2G |
+			IEEE80211_HE_PHY_CAP8_20MHZ_IN_160MHZ_HE_PPDU |
+			IEEE80211_HE_PHY_CAP8_80MHZ_IN_160MHZ_HE_PPDU |
+			IEEE80211_HE_PHY_CAP8_DCM_MAX_RU_484;
+		he_cap_elem->phy_cap_info[9] |=
+			IEEE80211_HE_PHY_CAP9_LONGER_THAN_16_SIGB_OFDM_SYM |
+			IEEE80211_HE_PHY_CAP9_NON_TRIGGERED_CQI_FEEDBACK |
+			IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU |
+			IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU |
+			IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_COMP_SIGB |
+			IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_NON_COMP_SIGB;
+		break;
+	default:
+		break;
+	}
+
+	he_mcs->rx_mcs_80 = cpu_to_le16(mcs_map);
+	he_mcs->tx_mcs_80 = cpu_to_le16(mcs_map);
+	he_mcs->rx_mcs_160 = cpu_to_le16(mcs_map);
+	he_mcs->tx_mcs_160 = cpu_to_le16(mcs_map);
+
+	memset(he_cap->ppe_thres, 0, sizeof(he_cap->ppe_thres));
+
+	if (he_cap_elem->phy_cap_info[6] &
+	    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
+		mt76_connac_gen_ppe_thresh(he_cap->ppe_thres, nss, band);
+	} else {
+		he_cap_elem->phy_cap_info[9] |=
+			u8_encode_bits(IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US,
+				       IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_MASK);
+	}
+
+	if (band == NL80211_BAND_6GHZ) {
+		u16 cap = IEEE80211_HE_6GHZ_CAP_TX_ANTPAT_CONS |
+			  IEEE80211_HE_6GHZ_CAP_RX_ANTPAT_CONS;
+
+		cap |= u16_encode_bits(IEEE80211_HT_MPDU_DENSITY_0_5,
+				       IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START) |
+		       u16_encode_bits(IEEE80211_VHT_MAX_AMPDU_1024K,
+				       IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP) |
+		       u16_encode_bits(IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454,
+				       IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN);
+
+		data->he_6ghz_capa.capa = cpu_to_le16(cap);
+	}
+}
+
+static void
+mt7925_init_eht_caps(struct mt792x_phy *phy, enum nl80211_band band,
+		     struct ieee80211_sband_iftype_data *data)
+{
+	struct ieee80211_sta_eht_cap *eht_cap = &data->eht_cap;
+	struct ieee80211_eht_cap_elem_fixed *eht_cap_elem = &eht_cap->eht_cap_elem;
+	struct ieee80211_eht_mcs_nss_supp *eht_nss = &eht_cap->eht_mcs_nss_supp;
+	enum nl80211_chan_width width = phy->mt76->chandef.width;
+	int nss = hweight8(phy->mt76->antenna_mask);
+	int sts = hweight16(phy->mt76->chainmask);
+	u8 val;
+
+	if (!phy->dev->has_eht)
+		return;
+
+	eht_cap->has_eht = true;
+
+	eht_cap_elem->mac_cap_info[0] =
+		IEEE80211_EHT_MAC_CAP0_EPCS_PRIO_ACCESS |
+		IEEE80211_EHT_MAC_CAP0_OM_CONTROL;
+
+	eht_cap_elem->phy_cap_info[0] =
+		IEEE80211_EHT_PHY_CAP0_NDP_4_EHT_LFT_32_GI |
+		IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMER |
+		IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMEE;
+
+	eht_cap_elem->phy_cap_info[0] |=
+		u8_encode_bits(u8_get_bits(sts - 1, BIT(0)),
+			       IEEE80211_EHT_PHY_CAP0_BEAMFORMEE_SS_80MHZ_MASK);
+
+	eht_cap_elem->phy_cap_info[1] =
+		u8_encode_bits(u8_get_bits(sts - 1, GENMASK(2, 1)),
+			       IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_80MHZ_MASK) |
+		u8_encode_bits(sts - 1,
+			       IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_160MHZ_MASK);
+
+	eht_cap_elem->phy_cap_info[2] =
+		u8_encode_bits(sts - 1, IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_80MHZ_MASK) |
+		u8_encode_bits(sts - 1, IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_160MHZ_MASK);
+
+	eht_cap_elem->phy_cap_info[3] =
+		IEEE80211_EHT_PHY_CAP3_NG_16_SU_FEEDBACK |
+		IEEE80211_EHT_PHY_CAP3_NG_16_MU_FEEDBACK |
+		IEEE80211_EHT_PHY_CAP3_CODEBOOK_4_2_SU_FDBK |
+		IEEE80211_EHT_PHY_CAP3_CODEBOOK_7_5_MU_FDBK |
+		IEEE80211_EHT_PHY_CAP3_TRIG_SU_BF_FDBK |
+		IEEE80211_EHT_PHY_CAP3_TRIG_MU_BF_PART_BW_FDBK |
+		IEEE80211_EHT_PHY_CAP3_TRIG_CQI_FDBK;
+
+	eht_cap_elem->phy_cap_info[4] =
+		u8_encode_bits(min_t(int, sts - 1, 2),
+			       IEEE80211_EHT_PHY_CAP4_MAX_NC_MASK);
+
+	eht_cap_elem->phy_cap_info[5] =
+		IEEE80211_EHT_PHY_CAP5_NON_TRIG_CQI_FEEDBACK |
+		u8_encode_bits(IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_16US,
+			       IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_MASK) |
+		u8_encode_bits(u8_get_bits(0x11, GENMASK(1, 0)),
+			       IEEE80211_EHT_PHY_CAP5_MAX_NUM_SUPP_EHT_LTF_MASK);
+
+	val = width == NL80211_CHAN_WIDTH_160 ? 0x7 :
+	      width == NL80211_CHAN_WIDTH_80 ? 0x3 : 0x1;
+	eht_cap_elem->phy_cap_info[6] =
+		u8_encode_bits(u8_get_bits(0x11, GENMASK(4, 2)),
+			       IEEE80211_EHT_PHY_CAP6_MAX_NUM_SUPP_EHT_LTF_MASK) |
+		u8_encode_bits(val, IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_MASK);
+
+	eht_cap_elem->phy_cap_info[7] =
+		IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_80MHZ |
+		IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_160MHZ |
+		IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_80MHZ |
+		IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_160MHZ;
+
+	val = u8_encode_bits(nss, IEEE80211_EHT_MCS_NSS_RX) |
+	      u8_encode_bits(nss, IEEE80211_EHT_MCS_NSS_TX);
+
+	eht_nss->bw._80.rx_tx_mcs9_max_nss = val;
+	eht_nss->bw._80.rx_tx_mcs11_max_nss = val;
+	eht_nss->bw._80.rx_tx_mcs13_max_nss = val;
+	eht_nss->bw._160.rx_tx_mcs9_max_nss = val;
+	eht_nss->bw._160.rx_tx_mcs11_max_nss = val;
+	eht_nss->bw._160.rx_tx_mcs13_max_nss = val;
+}
+
+int mt7925_init_mlo_caps(struct mt792x_phy *phy)
+{
+	struct wiphy *wiphy = phy->mt76->hw->wiphy;
+	static const u8 ext_capa_sta[] = {
+		[7] = WLAN_EXT_CAPA8_OPMODE_NOTIF,
+	};
+	static struct wiphy_iftype_ext_capab ext_capab[] = {
+		{
+			.iftype = NL80211_IFTYPE_STATION,
+			.extended_capabilities = ext_capa_sta,
+			.extended_capabilities_mask = ext_capa_sta,
+			.extended_capabilities_len = sizeof(ext_capa_sta),
+		},
+	};
+
+	if (!(phy->chip_cap & MT792x_CHIP_CAP_MLO_EVT_EN))
+		return 0;
+
+	ext_capab[0].eml_capabilities = phy->eml_cap;
+	ext_capab[0].mld_capa_and_ops =
+		u16_encode_bits(1, IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS);
+
+	wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
+	wiphy->iftype_ext_capab = ext_capab;
+	wiphy->num_iftype_ext_capab = ARRAY_SIZE(ext_capab);
+
+	return 0;
+}
+
+static void
+__mt7925_set_stream_he_eht_caps(struct mt792x_phy *phy,
+				struct ieee80211_supported_band *sband,
+				enum nl80211_band band)
+{
+	struct ieee80211_sband_iftype_data *data = phy->iftype[band];
+	int i, n = 0;
+
+	for (i = 0; i < NUM_NL80211_IFTYPES; i++) {
+		switch (i) {
+		case NL80211_IFTYPE_STATION:
+		case NL80211_IFTYPE_AP:
+			break;
+		default:
+			continue;
+		}
+
+		data[n].types_mask = BIT(i);
+		mt7925_init_he_caps(phy, band, &data[n], i);
+		mt7925_init_eht_caps(phy, band, &data[n]);
+
+		n++;
+	}
+
+	_ieee80211_set_sband_iftype_data(sband, data, n);
+}
+
+void mt7925_set_stream_he_eht_caps(struct mt792x_phy *phy)
+{
+	if (phy->mt76->cap.has_2ghz)
+		__mt7925_set_stream_he_eht_caps(phy, &phy->mt76->sband_2g.sband,
+						NL80211_BAND_2GHZ);
+
+	if (phy->mt76->cap.has_5ghz)
+		__mt7925_set_stream_he_eht_caps(phy, &phy->mt76->sband_5g.sband,
+						NL80211_BAND_5GHZ);
+
+	if (phy->mt76->cap.has_6ghz)
+		__mt7925_set_stream_he_eht_caps(phy, &phy->mt76->sband_6g.sband,
+						NL80211_BAND_6GHZ);
+}
+
+int __mt7925_start(struct mt792x_phy *phy)
+{
+	struct mt76_phy *mphy = phy->mt76;
+	struct mt792x_dev *dev = phy->dev;
+	int err;
+
+	err = mt7925_mcu_set_channel_domain(mphy);
+	if (err)
+		return err;
+
+	err = mt7925_mcu_set_rts_thresh(phy, 0x92b);
+	if (err)
+		return err;
+
+	if (!dev->sar_inited) {
+		err = mt7925_set_tx_sar_pwr(mphy->hw, NULL);
+		if (err)
+			return err;
+		dev->sar_inited = true;
+	}
+
+	mt792x_mac_reset_counters(phy);
+	set_bit(MT76_STATE_RUNNING, &mphy->state);
+
+	ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
+				     MT792x_WATCHDOG_TIME);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__mt7925_start);
+
+static int mt7925_start(struct ieee80211_hw *hw)
+{
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	int err;
+
+	mt792x_mutex_acquire(phy->dev);
+	err = __mt7925_start(phy);
+	mt792x_mutex_release(phy->dev);
+
+	return err;
+}
+
+static int mt7925_mac_link_bss_add(struct mt792x_dev *dev,
+				   struct ieee80211_bss_conf *link_conf,
+				   struct mt792x_link_sta *mlink)
+{
+	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
+	struct ieee80211_vif *vif = link_conf->vif;
+	struct mt792x_vif *mvif = mconf->vif;
+	struct mt76_txq *mtxq;
+	int idx, ret = 0;
+
+	mconf->mt76.idx = __ffs64(~dev->mt76.vif_mask);
+	if (mconf->mt76.idx >= MT792x_MAX_INTERFACES) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	mconf->mt76.omac_idx = ieee80211_vif_is_mld(vif) ?
+			       0 : mconf->mt76.idx;
+	mconf->mt76.band_idx = 0xff;
+	mconf->mt76.wmm_idx = ieee80211_vif_is_mld(vif) ?
+			      0 : mconf->mt76.idx % MT76_CONNAC_MAX_WMM_SETS;
+
+	if (mvif->phy->mt76->chandef.chan->band != NL80211_BAND_2GHZ)
+		mconf->mt76.basic_rates_idx = MT792x_BASIC_RATES_TBL + 4;
+	else
+		mconf->mt76.basic_rates_idx = MT792x_BASIC_RATES_TBL;
+
+	dev->mt76.vif_mask |= BIT_ULL(mconf->mt76.idx);
+	mvif->phy->omac_mask |= BIT_ULL(mconf->mt76.omac_idx);
+
+	idx = MT792x_WTBL_RESERVED - mconf->mt76.idx;
+
+	mlink->wcid.idx = idx;
+	mlink->wcid.tx_info |= MT_WCID_TX_INFO_SET;
+	mt76_wcid_init(&mlink->wcid, 0);
+
+	mt7925_mac_wtbl_update(dev, idx,
+			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+
+	ewma_rssi_init(&mconf->rssi);
+
+	rcu_assign_pointer(dev->mt76.wcid[idx], &mlink->wcid);
+
+	ret = mt76_connac_mcu_uni_add_dev(&dev->mphy, link_conf, &mconf->mt76,
+					  &mlink->wcid, true);
+	if (ret)
+		goto out;
+
+	if (vif->txq) {
+		mtxq = (struct mt76_txq *)vif->txq->drv_priv;
+		mtxq->wcid = idx;
+	}
+
+out:
+	return ret;
+}
+
+static int
+mt7925_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	int ret = 0;
+
+	mt792x_mutex_acquire(dev);
+
+	mvif->phy = phy;
+	mvif->bss_conf.vif = mvif;
+	mvif->sta.vif = mvif;
+	mvif->deflink_id = IEEE80211_LINK_UNSPECIFIED;
+
+	ret = mt7925_mac_link_bss_add(dev, &vif->bss_conf, &mvif->sta.deflink);
+	if (ret < 0)
+		goto out;
+
+	vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
+out:
+	mt792x_mutex_release(dev);
+
+	return ret;
+}
+
+static void mt7925_roc_iter(void *priv, u8 *mac,
+			    struct ieee80211_vif *vif)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_phy *phy = priv;
+
+	mt7925_mcu_abort_roc(phy, &mvif->bss_conf, phy->roc_token_id);
+}
+
+void mt7925_roc_abort_sync(struct mt792x_dev *dev)
+{
+	struct mt792x_phy *phy = &dev->phy;
+
+	del_timer_sync(&phy->roc_timer);
+	cancel_work_sync(&phy->roc_work);
+	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
+		ieee80211_iterate_interfaces(mt76_hw(dev),
+					     IEEE80211_IFACE_ITER_RESUME_ALL,
+					     mt7925_roc_iter, (void *)phy);
+}
+EXPORT_SYMBOL_GPL(mt7925_roc_abort_sync);
+
+void mt7925_roc_work(struct work_struct *work)
+{
+	struct mt792x_phy *phy;
+
+	phy = (struct mt792x_phy *)container_of(work, struct mt792x_phy,
+						roc_work);
+
+	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
+		return;
+
+	mt792x_mutex_acquire(phy->dev);
+	ieee80211_iterate_active_interfaces(phy->mt76->hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7925_roc_iter, phy);
+	mt792x_mutex_release(phy->dev);
+	ieee80211_remain_on_channel_expired(phy->mt76->hw);
+}
+
+static int mt7925_abort_roc(struct mt792x_phy *phy,
+			    struct mt792x_bss_conf *mconf)
+{
+	int err = 0;
+
+	del_timer_sync(&phy->roc_timer);
+	cancel_work_sync(&phy->roc_work);
+
+	mt792x_mutex_acquire(phy->dev);
+	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
+		err = mt7925_mcu_abort_roc(phy, mconf, phy->roc_token_id);
+	mt792x_mutex_release(phy->dev);
+
+	return err;
+}
+
+static int mt7925_set_roc(struct mt792x_phy *phy,
+			  struct mt792x_bss_conf *mconf,
+			  struct ieee80211_channel *chan,
+			  int duration,
+			  enum mt7925_roc_req type)
+{
+	int err;
+
+	if (test_and_set_bit(MT76_STATE_ROC, &phy->mt76->state))
+		return -EBUSY;
+
+	phy->roc_grant = false;
+
+	err = mt7925_mcu_set_roc(phy, mconf, chan, duration, type,
+				 ++phy->roc_token_id);
+	if (err < 0) {
+		clear_bit(MT76_STATE_ROC, &phy->mt76->state);
+		goto out;
+	}
+
+	if (!wait_event_timeout(phy->roc_wait, phy->roc_grant, 4 * HZ)) {
+		mt7925_mcu_abort_roc(phy, mconf, phy->roc_token_id);
+		clear_bit(MT76_STATE_ROC, &phy->mt76->state);
+		err = -ETIMEDOUT;
+	}
+
+out:
+	return err;
+}
+
+static int mt7925_set_mlo_roc(struct mt792x_phy *phy,
+			      struct mt792x_bss_conf *mconf,
+			      u16 sel_links)
+{
+	int err;
+
+	if (WARN_ON_ONCE(test_and_set_bit(MT76_STATE_ROC, &phy->mt76->state)))
+		return -EBUSY;
+
+	phy->roc_grant = false;
+
+	err = mt7925_mcu_set_mlo_roc(mconf, sel_links, 5, ++phy->roc_token_id);
+	if (err < 0) {
+		clear_bit(MT76_STATE_ROC, &phy->mt76->state);
+		goto out;
+	}
+
+	if (!wait_event_timeout(phy->roc_wait, phy->roc_grant, 4 * HZ)) {
+		mt7925_mcu_abort_roc(phy, mconf, phy->roc_token_id);
+		clear_bit(MT76_STATE_ROC, &phy->mt76->state);
+		err = -ETIMEDOUT;
+	}
+
+out:
+	return err;
+}
+
+static int mt7925_remain_on_channel(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_channel *chan,
+				    int duration,
+				    enum ieee80211_roc_type type)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	int err;
+
+	mt792x_mutex_acquire(phy->dev);
+	err = mt7925_set_roc(phy, &mvif->bss_conf,
+			     chan, duration, MT7925_ROC_REQ_ROC);
+	mt792x_mutex_release(phy->dev);
+
+	return err;
+}
+
+static int mt7925_cancel_remain_on_channel(struct ieee80211_hw *hw,
+					   struct ieee80211_vif *vif)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+
+	return mt7925_abort_roc(phy, &mvif->bss_conf);
+}
+
+static int mt7925_set_link_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
+			       struct ieee80211_vif *vif, struct ieee80211_sta *sta,
+			       struct ieee80211_key_conf *key, int link_id)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_sta *msta = sta ? (struct mt792x_sta *)sta->drv_priv :
+				  &mvif->sta;
+	struct ieee80211_bss_conf *link_conf;
+	struct ieee80211_link_sta *link_sta;
+	int idx = key->keyidx, err = 0;
+	struct mt792x_link_sta *mlink;
+	struct mt792x_bss_conf *mconf;
+	struct mt76_wcid *wcid;
+	u8 *wcid_keyidx;
+
+	link_conf = mt792x_vif_to_bss_conf(vif, link_id);
+	link_sta = sta ? mt792x_sta_to_link_sta(vif, sta, link_id) : NULL;
+	mconf = mt792x_vif_to_link(mvif, link_id);
+	mlink = mt792x_sta_to_link(msta, link_id);
+	wcid = &mlink->wcid;
+	wcid_keyidx = &wcid->hw_key_idx;
+
+	/* fall back to sw encryption for unsupported ciphers */
+	switch (key->cipher) {
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIE;
+		wcid_keyidx = &wcid->hw_key_idx2;
+		break;
+	case WLAN_CIPHER_SUITE_WEP40:
+	case WLAN_CIPHER_SUITE_WEP104:
+		if (!mvif->wep_sta)
+			return -EOPNOTSUPP;
+		break;
+	case WLAN_CIPHER_SUITE_TKIP:
+	case WLAN_CIPHER_SUITE_CCMP:
+	case WLAN_CIPHER_SUITE_CCMP_256:
+	case WLAN_CIPHER_SUITE_GCMP:
+	case WLAN_CIPHER_SUITE_GCMP_256:
+	case WLAN_CIPHER_SUITE_SMS4:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	if (cmd == SET_KEY && !mconf->mt76.cipher) {
+		struct mt792x_phy *phy = mt792x_hw_phy(hw);
+
+		mconf->mt76.cipher = mt7925_mcu_get_cipher(key->cipher);
+		mt7925_mcu_add_bss_info(phy, mconf->mt76.ctx, link_conf,
+					link_sta, true);
+	}
+
+	if (cmd == SET_KEY)
+		*wcid_keyidx = idx;
+	else if (idx == *wcid_keyidx)
+		*wcid_keyidx = -1;
+	else
+		goto out;
+
+	mt76_wcid_key_setup(&dev->mt76, wcid,
+			    cmd == SET_KEY ? key : NULL);
+
+	err = mt7925_mcu_add_key(&dev->mt76, vif, &mlink->bip,
+				 key, MCU_UNI_CMD(STA_REC_UPDATE),
+				 &mlink->wcid, cmd, msta);
+
+	if (err)
+		goto out;
+
+	if (key->cipher == WLAN_CIPHER_SUITE_WEP104 ||
+	    key->cipher == WLAN_CIPHER_SUITE_WEP40)
+		err = mt7925_mcu_add_key(&dev->mt76, vif, &mvif->wep_sta->deflink.bip,
+					 key, MCU_WMWA_UNI_CMD(STA_REC_UPDATE),
+					 &mvif->wep_sta->deflink.wcid, cmd, msta);
+out:
+	return err;
+}
+
+static int mt7925_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
+			  struct ieee80211_vif *vif, struct ieee80211_sta *sta,
+			  struct ieee80211_key_conf *key)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_sta *msta = sta ? (struct mt792x_sta *)sta->drv_priv :
+				  &mvif->sta;
+	int err;
+
+	/* The hardware does not support per-STA RX GTK, fallback
+	 * to software mode for these.
+	 */
+	if ((vif->type == NL80211_IFTYPE_ADHOC ||
+	     vif->type == NL80211_IFTYPE_MESH_POINT) &&
+	    (key->cipher == WLAN_CIPHER_SUITE_TKIP ||
+	     key->cipher == WLAN_CIPHER_SUITE_CCMP) &&
+	    !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
+		return -EOPNOTSUPP;
+
+	mt792x_mutex_acquire(dev);
+
+	if (ieee80211_vif_is_mld(vif)) {
+		unsigned int link_id;
+		unsigned long add;
+
+		add = key->link_id != -1 ? BIT(key->link_id) : msta->valid_links;
+
+		for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
+			err = mt7925_set_link_key(hw, cmd, vif, sta, key, link_id);
+			if (err < 0)
+				break;
+		}
+	} else {
+		err = mt7925_set_link_key(hw, cmd, vif, sta, key, vif->bss_conf.link_id);
+	}
+
+	mt792x_mutex_release(dev);
+
+	return err;
+}
+
+static void
+mt7925_pm_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct mt792x_dev *dev = priv;
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	bool pm_enable = dev->pm.enable;
+	int err;
+
+	err = mt7925_mcu_set_beacon_filter(dev, vif, pm_enable);
+	if (err < 0)
+		return;
+
+	if (pm_enable) {
+		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
+		ieee80211_hw_set(hw, CONNECTION_MONITOR);
+	} else {
+		vif->driver_flags &= ~IEEE80211_VIF_BEACON_FILTER;
+		__clear_bit(IEEE80211_HW_CONNECTION_MONITOR, hw->flags);
+	}
+}
+
+static void
+mt7925_sniffer_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct mt792x_dev *dev = priv;
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	struct mt76_connac_pm *pm = &dev->pm;
+	bool monitor = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
+
+	mt7925_mcu_set_sniffer(dev, vif, monitor);
+	pm->enable = pm->enable_user && !monitor;
+	pm->ds_enable = pm->ds_enable_user && !monitor;
+
+	mt7925_mcu_set_deep_sleep(dev, pm->ds_enable);
+
+	if (monitor)
+		mt7925_mcu_set_beacon_filter(dev, vif, false);
+}
+
+void mt7925_set_runtime_pm(struct mt792x_dev *dev)
+{
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	struct mt76_connac_pm *pm = &dev->pm;
+	bool monitor = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
+
+	pm->enable = pm->enable_user && !monitor;
+	ieee80211_iterate_active_interfaces(hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7925_pm_interface_iter, dev);
+	pm->ds_enable = pm->ds_enable_user && !monitor;
+	mt7925_mcu_set_deep_sleep(dev, pm->ds_enable);
+}
+
+static int mt7925_config(struct ieee80211_hw *hw, u32 changed)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	int ret = 0;
+
+	mt792x_mutex_acquire(dev);
+
+	if (changed & IEEE80211_CONF_CHANGE_POWER) {
+		ret = mt7925_set_tx_sar_pwr(hw, NULL);
+		if (ret)
+			goto out;
+	}
+
+	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
+		ieee80211_iterate_active_interfaces(hw,
+						    IEEE80211_IFACE_ITER_RESUME_ALL,
+						    mt7925_sniffer_interface_iter, dev);
+	}
+
+out:
+	mt792x_mutex_release(dev);
+
+	return ret;
+}
+
+static void mt7925_configure_filter(struct ieee80211_hw *hw,
+				    unsigned int changed_flags,
+				    unsigned int *total_flags,
+				    u64 multicast)
+{
+#define MT7925_FILTER_FCSFAIL    BIT(2)
+#define MT7925_FILTER_CONTROL    BIT(5)
+#define MT7925_FILTER_OTHER_BSS  BIT(6)
+#define MT7925_FILTER_ENABLE     BIT(31)
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	u32 flags = MT7925_FILTER_ENABLE;
+
+#define MT7925_FILTER(_fif, _type) do {			\
+		if (*total_flags & (_fif))		\
+			flags |= MT7925_FILTER_##_type;	\
+	} while (0)
+
+	MT7925_FILTER(FIF_FCSFAIL, FCSFAIL);
+	MT7925_FILTER(FIF_CONTROL, CONTROL);
+	MT7925_FILTER(FIF_OTHER_BSS, OTHER_BSS);
+
+	mt792x_mutex_acquire(dev);
+	mt7925_mcu_set_rxfilter(dev, flags, 0, 0);
+	mt792x_mutex_release(dev);
+
+	*total_flags &= (FIF_OTHER_BSS | FIF_FCSFAIL | FIF_CONTROL);
+}
+
+static u8
+mt7925_get_rates_table(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		       bool beacon, bool mcast)
+{
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
+	struct mt76_phy *mphy = hw->priv;
+	u16 rate;
+	u8 i, idx, ht;
+
+	rate = mt76_connac2_mac_tx_rate_val(mphy, &vif->bss_conf, beacon, mcast);
+	ht = FIELD_GET(MT_TX_RATE_MODE, rate) > MT_PHY_TYPE_OFDM;
+
+	if (beacon && ht) {
+		struct mt792x_dev *dev = mt792x_hw_dev(hw);
+
+		/* must odd index */
+		idx = MT7925_BEACON_RATES_TBL + 2 * (mvif->idx % 20);
+		mt7925_mac_set_fixed_rate_table(dev, idx, rate);
+		return idx;
+	}
+
+	idx = FIELD_GET(MT_TX_RATE_IDX, rate);
+	for (i = 0; i < ARRAY_SIZE(mt76_rates); i++)
+		if ((mt76_rates[i].hw_value & GENMASK(7, 0)) == idx)
+			return MT792x_BASIC_RATES_TBL + i;
+
+	return mvif->basic_rates_idx;
+}
+
+static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_link_sta *link_sta)
+{
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct ieee80211_bss_conf *link_conf;
+	struct mt792x_bss_conf *mconf;
+	u8 link_id = link_sta->link_id;
+	struct mt792x_link_sta *mlink;
+	struct mt792x_sta *msta;
+	struct mt76_wcid *wcid;
+	int ret, idx;
+
+	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
+	mlink = mt792x_sta_to_link(msta, link_id);
+
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT792x_WTBL_STA - 1);
+	if (idx < 0)
+		return -ENOSPC;
+
+	mconf = mt792x_vif_to_link(mvif, link_id);
+	mt76_wcid_init(&mlink->wcid, 0);
+	mlink->wcid.sta = 1;
+	mlink->wcid.idx = idx;
+	mlink->wcid.tx_info |= MT_WCID_TX_INFO_SET;
+	mlink->last_txs = jiffies;
+	mlink->wcid.link_id = link_sta->link_id;
+	mlink->wcid.link_valid = !!link_sta->sta->valid_links;
+	mlink->sta = msta;
+
+	wcid = &mlink->wcid;
+	ewma_signal_init(&wcid->rssi);
+	rcu_assign_pointer(dev->mt76.wcid[wcid->idx], wcid);
+	mt76_wcid_init(wcid, 0);
+	ewma_avg_signal_init(&mlink->avg_ack_signal);
+	memset(mlink->airtime_ac, 0,
+	       sizeof(msta->deflink.airtime_ac));
+
+	ret = mt76_connac_pm_wake(&dev->mphy, &dev->pm);
+	if (ret)
+		return ret;
+
+	mt7925_mac_wtbl_update(dev, idx,
+			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+
+	link_conf = mt792x_vif_to_bss_conf(vif, link_id);
+
+	/* should update bss info before STA add */
+	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
+		if (ieee80211_vif_is_mld(vif))
+			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
+						link_conf, link_sta, link_sta != mlink->pri_link);
+		else
+			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
+						link_conf, link_sta, false);
+	}
+
+	if (ieee80211_vif_is_mld(vif) &&
+	    link_sta == mlink->pri_link) {
+		ret = mt7925_mcu_sta_update(dev, link_sta, vif, true,
+					    MT76_STA_INFO_STATE_NONE);
+		if (ret)
+			return ret;
+	} else if (ieee80211_vif_is_mld(vif) &&
+		   link_sta != mlink->pri_link) {
+		ret = mt7925_mcu_sta_update(dev, mlink->pri_link, vif,
+					    true, MT76_STA_INFO_STATE_ASSOC);
+		if (ret)
+			return ret;
+
+		ret = mt7925_mcu_sta_update(dev, link_sta, vif, true,
+					    MT76_STA_INFO_STATE_ASSOC);
+		if (ret)
+			return ret;
+	} else {
+		ret = mt7925_mcu_sta_update(dev, link_sta, vif, true,
+					    MT76_STA_INFO_STATE_NONE);
+		if (ret)
+			return ret;
+	}
+
+	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
+
+	return 0;
+}
+
+static int
+mt7925_mac_sta_add_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
+			 struct ieee80211_sta *sta, unsigned long new_links)
+{
+	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	unsigned int link_id;
+	int err = 0;
+
+	for_each_set_bit(link_id, &new_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_link_sta *link_sta;
+		struct mt792x_link_sta *mlink;
+
+		if (msta->deflink_id == IEEE80211_LINK_UNSPECIFIED) {
+			mlink = &msta->deflink;
+			msta->deflink_id = link_id;
+		} else {
+			mlink = devm_kzalloc(dev->mt76.dev, sizeof(*mlink), GFP_KERNEL);
+			if (!mlink) {
+				err = -ENOMEM;
+				break;
+			}
+		}
+
+		msta->valid_links |= BIT(link_id);
+		rcu_assign_pointer(msta->link[link_id], mlink);
+		mlink->sta = msta;
+		mlink->pri_link = &sta->deflink;
+		mlink->wcid.def_wcid = &msta->deflink.wcid;
+
+		link_sta = mt792x_sta_to_link_sta(vif, sta, link_id);
+		mt7925_mac_link_sta_add(&dev->mt76, vif, link_sta);
+	}
+
+	return err;
+}
+
+int mt7925_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta)
+{
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	int err;
+
+	msta->vif = mvif;
+
+	if (vif->type == NL80211_IFTYPE_STATION)
+		mvif->wep_sta = msta;
+
+	if (ieee80211_vif_is_mld(vif)) {
+		msta->deflink_id = IEEE80211_LINK_UNSPECIFIED;
+
+		err = mt7925_mac_sta_add_links(dev, vif, sta, sta->valid_links);
+	} else {
+		err = mt7925_mac_link_sta_add(mdev, vif, &sta->deflink);
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(mt7925_mac_sta_add);
+
+static u16
+mt7925_mac_select_links(struct mt76_dev *mdev, struct ieee80211_vif *vif)
+{
+	unsigned long usable_links = ieee80211_vif_usable_links(vif);
+	struct  {
+		u8 link_id;
+		enum nl80211_band band;
+	} data[IEEE80211_MLD_MAX_NUM_LINKS];
+	u8 link_id, i, j, n_data = 0;
+	u16 sel_links = 0;
+
+	if (!ieee80211_vif_is_mld(vif))
+		return 0;
+
+	if (vif->active_links == usable_links)
+		return vif->active_links;
+
+	rcu_read_lock();
+	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_bss_conf *link_conf =
+			rcu_dereference(vif->link_conf[link_id]);
+
+		if (WARN_ON_ONCE(!link_conf))
+			continue;
+
+		data[n_data].link_id = link_id;
+		data[n_data].band = link_conf->chanreq.oper.chan->band;
+		n_data++;
+	}
+	rcu_read_unlock();
+
+	for (i = 0; i < n_data; i++) {
+		if (!(BIT(data[i].link_id) & vif->active_links))
+			continue;
+
+		sel_links = BIT(data[i].link_id);
+
+		for (j = 0; j < n_data; j++) {
+			if (data[i].band != data[j].band) {
+				sel_links |= BIT(data[j].link_id);
+				break;
+			}
+		}
+
+		break;
+	}
+
+	return sel_links;
+}
+
+static void
+mt7925_mac_set_links(struct mt76_dev *mdev, struct ieee80211_vif *vif)
+{
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct ieee80211_bss_conf *link_conf =
+		mt792x_vif_to_bss_conf(vif, mvif->deflink_id);
+	struct cfg80211_chan_def *chandef = &link_conf->chanreq.oper;
+	enum nl80211_band band = chandef->chan->band, secondary_band;
+
+	u16 sel_links = mt7925_mac_select_links(mdev, vif);
+	u8 secondary_link_id = __ffs(~BIT(mvif->deflink_id) & sel_links);
+
+	if (!ieee80211_vif_is_mld(vif) || hweight16(sel_links) < 2)
+		return;
+
+	link_conf = mt792x_vif_to_bss_conf(vif, secondary_link_id);
+	secondary_band = link_conf->chanreq.oper.chan->band;
+
+	if (band == NL80211_BAND_2GHZ ||
+	    (band == NL80211_BAND_5GHZ && secondary_band == NL80211_BAND_6GHZ)) {
+		mt7925_abort_roc(mvif->phy, &mvif->bss_conf);
+
+		mt792x_mutex_acquire(dev);
+
+		mt7925_set_mlo_roc(mvif->phy, &mvif->bss_conf, sel_links);
+
+		mt792x_mutex_release(dev);
+	}
+
+	ieee80211_set_active_links_async(vif, sel_links);
+}
+
+static void mt7925_mac_link_sta_assoc(struct mt76_dev *mdev,
+				      struct ieee80211_vif *vif,
+				      struct ieee80211_link_sta *link_sta)
+{
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	struct ieee80211_bss_conf *link_conf;
+	struct mt792x_link_sta *mlink;
+	struct mt792x_sta *msta;
+
+	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
+	mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+
+	mt792x_mutex_acquire(dev);
+
+	if (ieee80211_vif_is_mld(vif)) {
+		link_conf = mt792x_vif_to_bss_conf(vif, msta->deflink_id);
+	} else {
+		link_conf = mt792x_vif_to_bss_conf(vif, vif->bss_conf.link_id);
+	}
+
+	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
+		struct mt792x_bss_conf *mconf;
+
+		mconf = mt792x_link_conf_to_mconf(link_conf);
+		mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
+					link_conf, link_sta, true);
+	}
+
+	ewma_avg_signal_init(&mlink->avg_ack_signal);
+
+	mt7925_mac_wtbl_update(dev, mlink->wcid.idx,
+			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+	memset(mlink->airtime_ac, 0, sizeof(mlink->airtime_ac));
+
+	mt7925_mcu_sta_update(dev, link_sta, vif, true, MT76_STA_INFO_STATE_ASSOC);
+
+	mt792x_mutex_release(dev);
+}
+
+int mt7925_mac_sta_event(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			 struct ieee80211_sta *sta, enum mt76_sta_event ev)
+{
+	struct ieee80211_link_sta *link_sta = &sta->deflink;
+
+	if (ev != MT76_STA_EVENT_ASSOC)
+		return 0;
+
+	if (ieee80211_vif_is_mld(vif)) {
+		struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+
+		link_sta = mt792x_sta_to_link_sta(vif, sta, msta->deflink_id);
+		mt7925_mac_set_links(mdev, vif);
+	}
+
+	mt7925_mac_link_sta_assoc(mdev, vif, link_sta);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt7925_mac_sta_event);
+
+static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
+				       struct ieee80211_vif *vif,
+				       struct ieee80211_link_sta *link_sta)
+{
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	struct ieee80211_bss_conf *link_conf;
+	u8 link_id = link_sta->link_id;
+	struct mt792x_link_sta *mlink;
+	struct mt792x_sta *msta;
+
+	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
+	mlink = mt792x_sta_to_link(msta, link_id);
+
+	mt7925_roc_abort_sync(dev);
+
+	mt76_connac_free_pending_tx_skbs(&dev->pm, &mlink->wcid);
+	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
+
+	mt7925_mcu_sta_update(dev, link_sta, vif, false,
+			      MT76_STA_INFO_STATE_NONE);
+	mt7925_mac_wtbl_update(dev, mlink->wcid.idx,
+			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+
+	link_conf = mt792x_vif_to_bss_conf(vif, link_id);
+
+	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
+		struct mt792x_bss_conf *mconf;
+
+		mconf = mt792x_link_conf_to_mconf(link_conf);
+		mt792x_mac_link_bss_remove(dev, mconf, mlink);
+	}
+
+	spin_lock_bh(&mdev->sta_poll_lock);
+	if (!list_empty(&mlink->wcid.poll_list))
+		list_del_init(&mlink->wcid.poll_list);
+	spin_unlock_bh(&mdev->sta_poll_lock);
+
+	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
+}
+
+static int
+mt7925_mac_sta_remove_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta, unsigned long old_links)
+{
+	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	struct mt76_dev *mdev = &dev->mt76;
+	struct mt76_wcid *wcid;
+	unsigned int link_id;
+
+	for_each_set_bit(link_id, &old_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_link_sta *link_sta;
+		struct mt792x_link_sta *mlink;
+
+		link_sta = mt792x_sta_to_link_sta(vif, sta, link_id);
+		if (!link_sta)
+			continue;
+
+		mlink = mt792x_sta_to_link(msta, link_id);
+		if (!mlink)
+			continue;
+
+		mt7925_mac_link_sta_remove(&dev->mt76, vif, link_sta);
+
+		wcid = &mlink->wcid;
+		rcu_assign_pointer(msta->link[link_id], NULL);
+		msta->valid_links &= ~BIT(link_id);
+		mlink->sta = NULL;
+		mlink->pri_link = NULL;
+
+		if (link_sta != mlink->pri_link) {
+			mt76_wcid_cleanup(mdev, wcid);
+			mt76_wcid_mask_clear(mdev->wcid_mask, wcid->idx);
+		}
+
+		if (msta->deflink_id == link_id)
+			msta->deflink_id = IEEE80211_LINK_UNSPECIFIED;
+	}
+
+	return 0;
+}
+
+void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta)
+{
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	struct {
+		struct {
+			u8 omac_idx;
+			u8 band_idx;
+			__le16 pad;
+		} __packed hdr;
+		struct req_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 active;
+			u8 link_idx; /* hw link idx */
+			u8 omac_addr[ETH_ALEN];
+		} __packed tlv;
+	} dev_req = {
+		.hdr = {
+			.omac_idx = 0,
+			.band_idx = 0,
+		},
+		.tlv = {
+			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
+			.len = cpu_to_le16(sizeof(struct req_tlv)),
+			.active = true,
+		},
+	};
+	unsigned long rem;
+
+	rem = ieee80211_vif_is_mld(vif) ? msta->valid_links : BIT(0);
+
+	mt7925_mac_sta_remove_links(dev, vif, sta, rem);
+
+	if (ieee80211_vif_is_mld(vif)) {
+		mt7925_mcu_set_dbdc(&dev->mphy, false);
+
+		/* recovery omac address for the legacy interface */
+		memcpy(dev_req.tlv.omac_addr, vif->addr, ETH_ALEN);
+		mt76_mcu_send_msg(mdev, MCU_UNI_CMD(DEV_INFO_UPDATE),
+				  &dev_req, sizeof(dev_req), true);
+	}
+
+	if (vif->type == NL80211_IFTYPE_STATION) {
+		struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+
+		mvif->wep_sta = NULL;
+		ewma_rssi_init(&mvif->bss_conf.rssi);
+	}
+}
+EXPORT_SYMBOL_GPL(mt7925_mac_sta_remove);
+
+static int mt7925_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+
+	mt792x_mutex_acquire(dev);
+	mt7925_mcu_set_rts_thresh(&dev->phy, val);
+	mt792x_mutex_release(dev);
+
+	return 0;
+}
+
+static int
+mt7925_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		    struct ieee80211_ampdu_params *params)
+{
+	enum ieee80211_ampdu_mlme_action action = params->action;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct ieee80211_sta *sta = params->sta;
+	struct ieee80211_txq *txq = sta->txq[params->tid];
+	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	u16 tid = params->tid;
+	u16 ssn = params->ssn;
+	struct mt76_txq *mtxq;
+	int ret = 0;
+
+	if (!txq)
+		return -EINVAL;
+
+	mtxq = (struct mt76_txq *)txq->drv_priv;
+
+	mt792x_mutex_acquire(dev);
+	switch (action) {
+	case IEEE80211_AMPDU_RX_START:
+		mt76_rx_aggr_start(&dev->mt76, &msta->deflink.wcid, tid, ssn,
+				   params->buf_size);
+		mt7925_mcu_uni_rx_ba(dev, params, true);
+		break;
+	case IEEE80211_AMPDU_RX_STOP:
+		mt76_rx_aggr_stop(&dev->mt76, &msta->deflink.wcid, tid);
+		mt7925_mcu_uni_rx_ba(dev, params, false);
+		break;
+	case IEEE80211_AMPDU_TX_OPERATIONAL:
+		mtxq->aggr = true;
+		mtxq->send_bar = false;
+		mt7925_mcu_uni_tx_ba(dev, params, true);
+		break;
+	case IEEE80211_AMPDU_TX_STOP_FLUSH:
+	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
+		mtxq->aggr = false;
+		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
+		mt7925_mcu_uni_tx_ba(dev, params, false);
+		break;
+	case IEEE80211_AMPDU_TX_START:
+		set_bit(tid, &msta->deflink.wcid.ampdu_state);
+		ret = IEEE80211_AMPDU_TX_START_IMMEDIATE;
+		break;
+	case IEEE80211_AMPDU_TX_STOP_CONT:
+		mtxq->aggr = false;
+		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
+		mt7925_mcu_uni_tx_ba(dev, params, false);
+		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
+		break;
+	}
+	mt792x_mutex_release(dev);
+
+	return ret;
+}
+
+static bool is_valid_alpha2(const char *alpha2)
+{
+	if (!alpha2)
+		return false;
+
+	if (alpha2[0] == '0' && alpha2[1] == '0')
+		return true;
+
+	if (isalpha(alpha2[0]) && isalpha(alpha2[1]))
+		return true;
+
+	return false;
+}
+
+void mt7925_scan_work(struct work_struct *work)
+{
+	struct mt792x_phy *phy;
+
+	phy = (struct mt792x_phy *)container_of(work, struct mt792x_phy,
+						scan_work.work);
+
+	while (true) {
+		struct mt76_dev *mdev = &phy->dev->mt76;
+		struct sk_buff *skb;
+		struct tlv *tlv;
+		int tlv_len;
+
+		spin_lock_bh(&phy->dev->mt76.lock);
+		skb = __skb_dequeue(&phy->scan_event_list);
+		spin_unlock_bh(&phy->dev->mt76.lock);
+
+		if (!skb)
+			break;
+
+		skb_pull(skb, sizeof(struct mt7925_mcu_rxd) + 4);
+		tlv = (struct tlv *)skb->data;
+		tlv_len = skb->len;
+
+		while (tlv_len > 0 && le16_to_cpu(tlv->len) <= tlv_len) {
+			struct mt7925_mcu_scan_chinfo_event *evt;
+
+			switch (le16_to_cpu(tlv->tag)) {
+			case UNI_EVENT_SCAN_DONE_BASIC:
+				if (test_and_clear_bit(MT76_HW_SCANNING, &phy->mt76->state)) {
+					struct cfg80211_scan_info info = {
+						.aborted = false,
+					};
+					ieee80211_scan_completed(phy->mt76->hw, &info);
+				}
+				break;
+			case UNI_EVENT_SCAN_DONE_CHNLINFO:
+				evt = (struct mt7925_mcu_scan_chinfo_event *)tlv->data;
+
+				if (!is_valid_alpha2(evt->alpha2))
+					break;
+
+				if (mdev->alpha2[0] != '0' && mdev->alpha2[1] != '0')
+					break;
+
+				mt7925_mcu_set_clc(phy->dev, evt->alpha2, ENVIRON_INDOOR);
+
+				break;
+			case UNI_EVENT_SCAN_DONE_NLO:
+				ieee80211_sched_scan_results(phy->mt76->hw);
+				break;
+			default:
+				break;
+			}
+
+			tlv_len -= le16_to_cpu(tlv->len);
+			tlv = (struct tlv *)((char *)(tlv) + le16_to_cpu(tlv->len));
+		}
+
+		dev_kfree_skb(skb);
+	}
+}
+
+static int
+mt7925_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+	       struct ieee80211_scan_request *req)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt76_phy *mphy = hw->priv;
+	int err;
+
+	mt792x_mutex_acquire(dev);
+	err = mt7925_mcu_hw_scan(mphy, vif, req);
+	mt792x_mutex_release(dev);
+
+	return err;
+}
+
+static void
+mt7925_cancel_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt76_phy *mphy = hw->priv;
+
+	mt792x_mutex_acquire(dev);
+	mt7925_mcu_cancel_hw_scan(mphy, vif);
+	mt792x_mutex_release(dev);
+}
+
+static int
+mt7925_start_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			struct cfg80211_sched_scan_request *req,
+			struct ieee80211_scan_ies *ies)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt76_phy *mphy = hw->priv;
+	int err;
+
+	mt792x_mutex_acquire(dev);
+
+	err = mt7925_mcu_sched_scan_req(mphy, vif, req);
+	if (err < 0)
+		goto out;
+
+	err = mt7925_mcu_sched_scan_enable(mphy, vif, true);
+out:
+	mt792x_mutex_release(dev);
+
+	return err;
+}
+
+static int
+mt7925_stop_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt76_phy *mphy = hw->priv;
+	int err;
+
+	mt792x_mutex_acquire(dev);
+	err = mt7925_mcu_sched_scan_enable(mphy, vif, false);
+	mt792x_mutex_release(dev);
+
+	return err;
+}
+
+static int
+mt7925_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	int max_nss = hweight8(hw->wiphy->available_antennas_tx);
+
+	if (!tx_ant || tx_ant != rx_ant || ffs(tx_ant) > max_nss)
+		return -EINVAL;
+
+	if ((BIT(hweight8(tx_ant)) - 1) != tx_ant)
+		tx_ant = BIT(ffs(tx_ant) - 1) - 1;
+
+	mt792x_mutex_acquire(dev);
+
+	phy->mt76->antenna_mask = tx_ant;
+	phy->mt76->chainmask = tx_ant;
+
+	mt76_set_stream_caps(phy->mt76, true);
+	mt7925_set_stream_he_eht_caps(phy);
+
+	/* TODO: update bmc_wtbl spe_idx when antenna changes */
+	mt792x_mutex_release(dev);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int mt7925_suspend(struct ieee80211_hw *hw,
+			  struct cfg80211_wowlan *wowlan)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+
+	cancel_delayed_work_sync(&phy->scan_work);
+	cancel_delayed_work_sync(&phy->mt76->mac_work);
+
+	cancel_delayed_work_sync(&dev->pm.ps_work);
+	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
+
+	mt792x_mutex_acquire(dev);
+
+	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
+	ieee80211_iterate_active_interfaces(hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7925_mcu_set_suspend_iter,
+					    &dev->mphy);
+
+	mt792x_mutex_release(dev);
+
+	return 0;
+}
+
+static int mt7925_resume(struct ieee80211_hw *hw)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+
+	mt792x_mutex_acquire(dev);
+
+	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
+	ieee80211_iterate_active_interfaces(hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7925_mcu_set_suspend_iter,
+					    &dev->mphy);
+
+	ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
+				     MT792x_WATCHDOG_TIME);
+
+	mt792x_mutex_release(dev);
+
+	return 0;
+}
+
+static void mt7925_set_rekey_data(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct cfg80211_gtk_rekey_data *data)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+
+	mt792x_mutex_acquire(dev);
+	mt76_connac_mcu_update_gtk_rekey(hw, vif, data);
+	mt792x_mutex_release(dev);
+}
+#endif /* CONFIG_PM */
+
+static void mt7925_sta_set_decap_offload(struct ieee80211_hw *hw,
+					 struct ieee80211_vif *vif,
+					 struct ieee80211_sta *sta,
+					 bool enabled)
+{
+	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	unsigned long valid = mvif->valid_links;
+	u8 i;
+
+	mt792x_mutex_acquire(dev);
+
+	valid = ieee80211_vif_is_mld(vif) ? mvif->valid_links : BIT(0);
+
+	for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct mt792x_link_sta *mlink;
+
+		mlink = mt792x_sta_to_link(msta, i);
+
+		if (enabled)
+			set_bit(MT_WCID_FLAG_HDR_TRANS, &mlink->wcid.flags);
+		else
+			clear_bit(MT_WCID_FLAG_HDR_TRANS, &mlink->wcid.flags);
+
+		mt7925_mcu_wtbl_update_hdr_trans(dev, vif, sta, i);
+	}
+
+	mt792x_mutex_release(dev);
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+static void __mt7925_ipv6_addr_change(struct ieee80211_hw *hw,
+				      struct ieee80211_bss_conf *link_conf,
+				      struct inet6_dev *idev)
+{
+	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct inet6_ifaddr *ifa;
+	struct sk_buff *skb;
+	u8 idx = 0;
+
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt7925_arpns_tlv arpns;
+		struct in6_addr ns_addrs[IEEE80211_BSS_ARP_ADDR_LIST_LEN];
+	} req_hdr = {
+		.hdr = {
+			.bss_idx = mconf->mt76.idx,
+		},
+		.arpns = {
+			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_ND),
+			.len = cpu_to_le16(sizeof(req_hdr) - 4),
+			.enable = true,
+		},
+	};
+
+	read_lock_bh(&idev->lock);
+	list_for_each_entry(ifa, &idev->addr_list, if_list) {
+		if (ifa->flags & IFA_F_TENTATIVE)
+			continue;
+		req_hdr.ns_addrs[idx] = ifa->addr;
+		if (++idx >= IEEE80211_BSS_ARP_ADDR_LIST_LEN)
+			break;
+	}
+	read_unlock_bh(&idev->lock);
+
+	if (!idx)
+		return;
+
+	req_hdr.arpns.ips_num = idx;
+
+	skb = __mt76_mcu_msg_alloc(&dev->mt76, NULL, sizeof(req_hdr),
+				   0, GFP_ATOMIC);
+	if (!skb)
+		return;
+
+	skb_put_data(skb, &req_hdr, sizeof(req_hdr));
+
+	skb_queue_tail(&dev->ipv6_ns_list, skb);
+
+	ieee80211_queue_work(dev->mt76.hw, &dev->ipv6_ns_work);
+}
+
+static void mt7925_ipv6_addr_change(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    struct inet6_dev *idev)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	unsigned long valid = ieee80211_vif_is_mld(vif) ?
+			      mvif->valid_links : BIT(0);
+	struct ieee80211_bss_conf *bss_conf;
+	int i;
+
+	for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
+		bss_conf = mt792x_vif_to_bss_conf(vif, i);
+		__mt7925_ipv6_addr_change(hw, bss_conf, idev);
+	}
+}
+
+#endif
+
+int mt7925_set_tx_sar_pwr(struct ieee80211_hw *hw,
+			  const struct cfg80211_sar_specs *sar)
+{
+	struct mt76_phy *mphy = hw->priv;
+
+	if (sar) {
+		int err = mt76_init_sar_power(hw, sar);
+
+		if (err)
+			return err;
+	}
+	mt792x_init_acpi_sar_power(mt792x_hw_phy(hw), !sar);
+
+	return mt7925_mcu_set_rate_txpower(mphy);
+}
+
+static int mt7925_set_sar_specs(struct ieee80211_hw *hw,
+				const struct cfg80211_sar_specs *sar)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	int err;
+
+	mt792x_mutex_acquire(dev);
+	err = mt7925_mcu_set_clc(dev, dev->mt76.alpha2,
+				 dev->country_ie_env);
+	if (err < 0)
+		goto out;
+
+	err = mt7925_set_tx_sar_pwr(hw, sar);
+out:
+	mt792x_mutex_release(dev);
+
+	return err;
+}
+
+static void
+mt7925_channel_switch_beacon(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif,
+			     struct cfg80211_chan_def *chandef)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+
+	mt792x_mutex_acquire(dev);
+	mt7925_mcu_uni_add_beacon_offload(dev, hw, vif, true);
+	mt792x_mutex_release(dev);
+}
+
+static int
+mt7925_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+	       unsigned int link_id, u16 queue,
+	       const struct ieee80211_tx_queue_params *params)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_bss_conf *mconf = mt792x_vif_to_link(mvif, link_id);
+	static const u8 mq_to_aci[] = {
+		    [IEEE80211_AC_VO] = 3,
+		    [IEEE80211_AC_VI] = 2,
+		    [IEEE80211_AC_BE] = 0,
+		    [IEEE80211_AC_BK] = 1,
+	};
+
+	/* firmware uses access class index */
+	mconf->queue_params[mq_to_aci[queue]] = *params;
+
+	return 0;
+}
+
+static int
+mt7925_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		struct ieee80211_bss_conf *link_conf)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	int err;
+
+	mt792x_mutex_acquire(dev);
+
+	err = mt7925_mcu_add_bss_info(&dev->phy, mvif->bss_conf.mt76.ctx,
+				      link_conf, NULL, true);
+	if (err)
+		goto out;
+
+	err = mt7925_mcu_set_bss_pm(dev, link_conf, true);
+	if (err)
+		goto out;
+
+	err = mt7925_mcu_sta_update(dev, NULL, vif, true,
+				    MT76_STA_INFO_STATE_NONE);
+out:
+	mt792x_mutex_release(dev);
+
+	return err;
+}
+
+static void
+mt7925_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+	       struct ieee80211_bss_conf *link_conf)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	int err;
+
+	mt792x_mutex_acquire(dev);
+
+	err = mt7925_mcu_set_bss_pm(dev, link_conf, false);
+	if (err)
+		goto out;
+
+	mt7925_mcu_add_bss_info(&dev->phy, mvif->bss_conf.mt76.ctx, link_conf,
+				NULL, false);
+
+out:
+	mt792x_mutex_release(dev);
+}
+
+static int
+mt7925_add_chanctx(struct ieee80211_hw *hw,
+		   struct ieee80211_chanctx_conf *ctx)
+{
+	return 0;
+}
+
+static void
+mt7925_remove_chanctx(struct ieee80211_hw *hw,
+		      struct ieee80211_chanctx_conf *ctx)
+{
+}
+
+static void
+mt7925_change_chanctx(struct ieee80211_hw *hw,
+		      struct ieee80211_chanctx_conf *ctx,
+		      u32 changed)
+{
+	struct mt792x_chanctx *mctx = (struct mt792x_chanctx *)ctx->drv_priv;
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	struct mt792x_bss_conf *mconf;
+	struct ieee80211_vif *vif;
+	struct mt792x_vif *mvif;
+
+	if (!mctx->bss_conf)
+		return;
+
+	mconf = mctx->bss_conf;
+	mvif = mconf->vif;
+	vif = container_of((void *)mvif, struct ieee80211_vif, drv_priv);
+
+	mt792x_mutex_acquire(phy->dev);
+	if (vif->type == NL80211_IFTYPE_MONITOR) {
+		mt7925_mcu_set_sniffer(mvif->phy->dev, vif, true);
+		mt7925_mcu_config_sniffer(mvif, ctx);
+	} else {
+		if (ieee80211_vif_is_mld(vif)) {
+			unsigned long valid = mvif->valid_links;
+			u8 i;
+
+			for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
+				mconf = mt792x_vif_to_link(mvif, i);
+				if (mconf && mconf->mt76.ctx == ctx)
+					break;
+			}
+
+		} else {
+			mconf = &mvif->bss_conf;
+		}
+
+		if (mconf) {
+			struct ieee80211_bss_conf *link_conf;
+
+			link_conf = mt792x_vif_to_bss_conf(vif, mconf->link_id);
+			mt7925_mcu_set_chctx(mvif->phy->mt76, &mconf->mt76,
+					     link_conf, ctx);
+		}
+	}
+
+	mt792x_mutex_release(phy->dev);
+}
+
+static void mt7925_mgd_prepare_tx(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_prep_tx_info *info)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	u16 duration = info->duration ? info->duration :
+		       jiffies_to_msecs(HZ);
+
+	mt792x_mutex_acquire(dev);
+	mt7925_set_roc(mvif->phy, &mvif->bss_conf,
+		       mvif->bss_conf.mt76.ctx->def.chan, duration,
+		       MT7925_ROC_REQ_JOIN);
+	mt792x_mutex_release(dev);
+}
+
+static void mt7925_mgd_complete_tx(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_prep_tx_info *info)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+
+	mt7925_abort_roc(mvif->phy, &mvif->bss_conf);
+}
+
+static void mt7925_vif_cfg_changed(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif,
+				   u64 changed)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	unsigned long valid = ieee80211_vif_is_mld(vif) ?
+				      mvif->valid_links : BIT(0);
+	struct ieee80211_bss_conf *bss_conf;
+	int i;
+
+	mt792x_mutex_acquire(dev);
+
+	if (changed & BSS_CHANGED_ASSOC) {
+		mt7925_mcu_sta_update(dev, NULL, vif, true,
+				      MT76_STA_INFO_STATE_ASSOC);
+		mt7925_mcu_set_beacon_filter(dev, vif, vif->cfg.assoc);
+	}
+
+	if (changed & BSS_CHANGED_ARP_FILTER) {
+		for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
+			bss_conf = mt792x_vif_to_bss_conf(vif, i);
+			mt7925_mcu_update_arp_filter(&dev->mt76, bss_conf);
+		}
+	}
+
+	if (changed & BSS_CHANGED_PS) {
+		for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
+			bss_conf = mt792x_vif_to_bss_conf(vif, i);
+			mt7925_mcu_uni_bss_ps(dev, bss_conf);
+		}
+	}
+
+	mt792x_mutex_release(dev);
+}
+
+static void mt7925_link_info_changed(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_bss_conf *info,
+				     u64 changed)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt792x_bss_conf *mconf;
+
+	mconf = mt792x_vif_to_link(mvif, info->link_id);
+
+	mt792x_mutex_acquire(dev);
+
+	if (changed & BSS_CHANGED_ERP_SLOT) {
+		int slottime = info->use_short_slot ? 9 : 20;
+
+		if (slottime != phy->slottime) {
+			phy->slottime = slottime;
+			mt7925_mcu_set_timing(phy, info);
+		}
+	}
+
+	if (changed & BSS_CHANGED_MCAST_RATE)
+		mconf->mt76.mcast_rates_idx =
+				mt7925_get_rates_table(hw, vif, false, true);
+
+	if (changed & BSS_CHANGED_BASIC_RATES)
+		mconf->mt76.basic_rates_idx =
+				mt7925_get_rates_table(hw, vif, false, false);
+
+	if (changed & (BSS_CHANGED_BEACON |
+		       BSS_CHANGED_BEACON_ENABLED)) {
+		mconf->mt76.beacon_rates_idx =
+				mt7925_get_rates_table(hw, vif, true, false);
+
+		mt7925_mcu_uni_add_beacon_offload(dev, hw, vif,
+						  info->enable_beacon);
+	}
+
+	/* ensure that enable txcmd_mode after bss_info */
+	if (changed & (BSS_CHANGED_QOS | BSS_CHANGED_BEACON_ENABLED))
+		mt7925_mcu_set_tx(dev, info);
+
+	if (changed & BSS_CHANGED_BSSID) {
+		if (ieee80211_vif_is_mld(vif) &&
+		    hweight16(mvif->valid_links) == 2)
+			/* Indicate the secondary setup done */
+			mt7925_mcu_uni_bss_bcnft(dev, info, true);
+	}
+
+	mt792x_mutex_release(dev);
+}
+
+static int
+mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			u16 old_links, u16 new_links,
+			struct ieee80211_bss_conf *old[IEEE80211_MLD_MAX_NUM_LINKS])
+{
+	struct mt792x_bss_conf *mconfs[IEEE80211_MLD_MAX_NUM_LINKS] = {}, *mconf;
+	struct mt792x_link_sta *mlinks[IEEE80211_MLD_MAX_NUM_LINKS] = {}, *mlink;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	unsigned long add = new_links & ~old_links;
+	unsigned long rem = old_links & ~new_links;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	struct ieee80211_bss_conf *link_conf;
+	unsigned int link_id;
+	int err;
+
+	if (old_links == new_links)
+		return 0;
+
+	mt792x_mutex_acquire(dev);
+
+	for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
+		mconf = mt792x_vif_to_link(mvif, link_id);
+		mlink = mt792x_sta_to_link(&mvif->sta, link_id);
+
+		if (!mconf || !mlink)
+			continue;
+
+		if (mconf != &mvif->bss_conf) {
+			mt792x_mac_link_bss_remove(dev, mconf, mlink);
+			devm_kfree(dev->mt76.dev, mconf);
+			devm_kfree(dev->mt76.dev, mlink);
+		}
+
+		rcu_assign_pointer(mvif->link_conf[link_id], NULL);
+		rcu_assign_pointer(mvif->sta.link[link_id], NULL);
+	}
+
+	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
+		if (!old_links) {
+			mvif->deflink_id = link_id;
+			mconf = &mvif->bss_conf;
+			mlink = &mvif->sta.deflink;
+		} else {
+			mconf = devm_kzalloc(dev->mt76.dev, sizeof(*mconf),
+					     GFP_KERNEL);
+			mlink = devm_kzalloc(dev->mt76.dev, sizeof(*mlink),
+					     GFP_KERNEL);
+			if (!mconf || !mlink)
+				return -ENOMEM;
+		}
+
+		mconfs[link_id] = mconf;
+		mlinks[link_id] = mlink;
+		mconf->link_id = link_id;
+		mconf->vif = mvif;
+		mlink->wcid.link_id = link_id;
+		mlink->wcid.link_valid = !!vif->valid_links;
+		mlink->wcid.def_wcid = &mvif->sta.deflink.wcid;
+	}
+
+	if (hweight16(mvif->valid_links) == 0)
+		mt792x_mac_link_bss_remove(dev, &mvif->bss_conf,
+					   &mvif->sta.deflink);
+
+	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
+		mconf = mconfs[link_id];
+		mlink = mlinks[link_id];
+		link_conf = mt792x_vif_to_bss_conf(vif, link_id);
+
+		rcu_assign_pointer(mvif->link_conf[link_id], mconf);
+		rcu_assign_pointer(mvif->sta.link[link_id], mlink);
+
+		err = mt7925_mac_link_bss_add(dev, link_conf, mlink);
+		if (err < 0)
+			goto free;
+
+		if (mconf != &mvif->bss_conf) {
+			mt7925_mcu_set_bss_pm(dev, link_conf, true);
+
+			err = mt7925_set_mlo_roc(phy, &mvif->bss_conf,
+						 vif->active_links);
+			if (err < 0)
+				goto free;
+		}
+	}
+
+	mvif->valid_links = new_links;
+
+	mt792x_mutex_release(dev);
+
+	return 0;
+
+free:
+	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
+		rcu_assign_pointer(mvif->link_conf[link_id], NULL);
+		rcu_assign_pointer(mvif->sta.link[link_id], NULL);
+
+		if (mconf != &mvif->bss_conf)
+			devm_kfree(dev->mt76.dev, mconfs[link_id]);
+		if (mlink != &mvif->sta.deflink)
+			devm_kfree(dev->mt76.dev, mlinks[link_id]);
+	}
+
+	mt792x_mutex_release(dev);
+
+	return err;
+}
+
+static int
+mt7925_change_sta_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			struct ieee80211_sta *sta, u16 old_links, u16 new_links)
+{
+	unsigned long add = new_links & ~old_links;
+	unsigned long rem = old_links & ~new_links;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	int err = 0;
+
+	if (old_links == new_links)
+		return 0;
+
+	mt792x_mutex_acquire(dev);
+
+	err = mt7925_mac_sta_remove_links(dev, vif, sta, rem);
+	if (err < 0)
+		goto out;
+
+	err = mt7925_mac_sta_add_links(dev, vif, sta, add);
+	if (err < 0)
+		goto out;
+
+out:
+	mt792x_mutex_release(dev);
+
+	return err;
+}
+
+static int mt7925_assign_vif_chanctx(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_bss_conf *link_conf,
+				     struct ieee80211_chanctx_conf *ctx)
+{
+	struct mt792x_chanctx *mctx = (struct mt792x_chanctx *)ctx->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct ieee80211_bss_conf *pri_link_conf;
+	struct mt792x_bss_conf *mconf;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if (ieee80211_vif_is_mld(vif)) {
+		mconf = mt792x_vif_to_link(mvif, link_conf->link_id);
+		pri_link_conf = mt792x_vif_to_bss_conf(vif, mvif->deflink_id);
+
+		if (vif->type == NL80211_IFTYPE_STATION &&
+		    mconf == &mvif->bss_conf)
+			mt7925_mcu_add_bss_info(&dev->phy, NULL, pri_link_conf,
+						NULL, true);
+	} else {
+		mconf = &mvif->bss_conf;
+	}
+
+	mconf->mt76.ctx = ctx;
+	mctx->bss_conf = mconf;
+	mutex_unlock(&dev->mt76.mutex);
+
+	return 0;
+}
+
+static void mt7925_unassign_vif_chanctx(struct ieee80211_hw *hw,
+					struct ieee80211_vif *vif,
+					struct ieee80211_bss_conf *link_conf,
+					struct ieee80211_chanctx_conf *ctx)
+{
+	struct mt792x_chanctx *mctx = (struct mt792x_chanctx *)ctx->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt792x_bss_conf *mconf;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if (ieee80211_vif_is_mld(vif)) {
+		mconf = mt792x_vif_to_link(mvif, link_conf->link_id);
+
+		if (vif->type == NL80211_IFTYPE_STATION &&
+		    mconf == &mvif->bss_conf)
+			mt7925_mcu_add_bss_info(&dev->phy, NULL, link_conf,
+						NULL, false);
+	} else {
+		mconf = &mvif->bss_conf;
+	}
+
+	mctx->bss_conf = NULL;
+	mconf->mt76.ctx = NULL;
+	mutex_unlock(&dev->mt76.mutex);
+}
+
+const struct ieee80211_ops mt7925_ops = {
+	.tx = mt792x_tx,
+	.start = mt7925_start,
+	.stop = mt792x_stop,
+	.add_interface = mt7925_add_interface,
+	.remove_interface = mt792x_remove_interface,
+	.config = mt7925_config,
+	.conf_tx = mt7925_conf_tx,
+	.configure_filter = mt7925_configure_filter,
+	.start_ap = mt7925_start_ap,
+	.stop_ap = mt7925_stop_ap,
+	.sta_state = mt76_sta_state,
+	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
+	.set_key = mt7925_set_key,
+	.sta_set_decap_offload = mt7925_sta_set_decap_offload,
+#if IS_ENABLED(CONFIG_IPV6)
+	.ipv6_addr_change = mt7925_ipv6_addr_change,
+#endif /* CONFIG_IPV6 */
+	.ampdu_action = mt7925_ampdu_action,
+	.set_rts_threshold = mt7925_set_rts_threshold,
+	.wake_tx_queue = mt76_wake_tx_queue,
+	.release_buffered_frames = mt76_release_buffered_frames,
+	.channel_switch_beacon = mt7925_channel_switch_beacon,
+	.get_txpower = mt76_get_txpower,
+	.get_stats = mt792x_get_stats,
+	.get_et_sset_count = mt792x_get_et_sset_count,
+	.get_et_strings = mt792x_get_et_strings,
+	.get_et_stats = mt792x_get_et_stats,
+	.get_tsf = mt792x_get_tsf,
+	.set_tsf = mt792x_set_tsf,
+	.get_survey = mt76_get_survey,
+	.get_antenna = mt76_get_antenna,
+	.set_antenna = mt7925_set_antenna,
+	.set_coverage_class = mt792x_set_coverage_class,
+	.hw_scan = mt7925_hw_scan,
+	.cancel_hw_scan = mt7925_cancel_hw_scan,
+	.sta_statistics = mt792x_sta_statistics,
+	.sched_scan_start = mt7925_start_sched_scan,
+	.sched_scan_stop = mt7925_stop_sched_scan,
+#ifdef CONFIG_PM
+	.suspend = mt7925_suspend,
+	.resume = mt7925_resume,
+	.set_wakeup = mt792x_set_wakeup,
+	.set_rekey_data = mt7925_set_rekey_data,
+#endif /* CONFIG_PM */
+	.flush = mt792x_flush,
+	.set_sar_specs = mt7925_set_sar_specs,
+	.remain_on_channel = mt7925_remain_on_channel,
+	.cancel_remain_on_channel = mt7925_cancel_remain_on_channel,
+	.add_chanctx = mt7925_add_chanctx,
+	.remove_chanctx = mt7925_remove_chanctx,
+	.change_chanctx = mt7925_change_chanctx,
+	.assign_vif_chanctx = mt7925_assign_vif_chanctx,
+	.unassign_vif_chanctx = mt7925_unassign_vif_chanctx,
+	.mgd_prepare_tx = mt7925_mgd_prepare_tx,
+	.mgd_complete_tx = mt7925_mgd_complete_tx,
+	.vif_cfg_changed = mt7925_vif_cfg_changed,
+	.link_info_changed = mt7925_link_info_changed,
+	.change_vif_links = mt7925_change_vif_links,
+	.change_sta_links = mt7925_change_sta_links,
+};
+EXPORT_SYMBOL_GPL(mt7925_ops);
+
+MODULE_AUTHOR("Deren Wu <deren.wu@mediatek.com>");
+MODULE_DESCRIPTION("MediaTek MT7925 core driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c.orig b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c.orig
new file mode 100644
index 000000000000..295112a2e37b
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c.orig
@@ -0,0 +1,3506 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2023 MediaTek Inc. */
+
+#include <linux/fs.h>
+#include <linux/firmware.h>
+#include "mt7925.h"
+#include "mcu.h"
+#include "mac.h"
+
+#define MT_STA_BFER			BIT(0)
+#define MT_STA_BFEE			BIT(1)
+
+static bool mt7925_disable_clc;
+module_param_named(disable_clc, mt7925_disable_clc, bool, 0644);
+MODULE_PARM_DESC(disable_clc, "disable CLC support");
+
+int mt7925_mcu_parse_response(struct mt76_dev *mdev, int cmd,
+			      struct sk_buff *skb, int seq)
+{
+	int mcu_cmd = FIELD_GET(__MCU_CMD_FIELD_ID, cmd);
+	struct mt7925_mcu_rxd *rxd;
+	int ret = 0;
+
+	if (!skb) {
+		dev_err(mdev->dev, "Message %08x (seq %d) timeout\n", cmd, seq);
+		mt792x_reset(mdev);
+
+		return -ETIMEDOUT;
+	}
+
+	rxd = (struct mt7925_mcu_rxd *)skb->data;
+	if (seq != rxd->seq)
+		return -EAGAIN;
+
+	if (cmd == MCU_CMD(PATCH_SEM_CONTROL) ||
+	    cmd == MCU_CMD(PATCH_FINISH_REQ)) {
+		skb_pull(skb, sizeof(*rxd) - 4);
+		ret = *skb->data;
+	} else if (cmd == MCU_UNI_CMD(DEV_INFO_UPDATE) ||
+		   cmd == MCU_UNI_CMD(BSS_INFO_UPDATE) ||
+		   cmd == MCU_UNI_CMD(STA_REC_UPDATE) ||
+		   cmd == MCU_UNI_CMD(HIF_CTRL) ||
+		   cmd == MCU_UNI_CMD(OFFLOAD) ||
+		   cmd == MCU_UNI_CMD(SUSPEND)) {
+		struct mt7925_mcu_uni_event *event;
+
+		skb_pull(skb, sizeof(*rxd));
+		event = (struct mt7925_mcu_uni_event *)skb->data;
+		ret = le32_to_cpu(event->status);
+		/* skip invalid event */
+		if (mcu_cmd != event->cid)
+			ret = -EAGAIN;
+	} else {
+		skb_pull(skb, sizeof(*rxd));
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt7925_mcu_parse_response);
+
+int mt7925_mcu_regval(struct mt792x_dev *dev, u32 regidx, u32 *val, bool set)
+{
+#define MT_RF_REG_HDR           GENMASK(31, 24)
+#define MT_RF_REG_ANT           GENMASK(23, 16)
+#define RF_REG_PREFIX           0x99
+	struct {
+		u8 __rsv[4];
+		union {
+			struct uni_cmd_access_reg_basic {
+				__le16 tag;
+				__le16 len;
+				__le32 idx;
+				__le32 data;
+			} __packed reg;
+			struct uni_cmd_access_rf_reg_basic {
+				__le16 tag;
+				__le16 len;
+				__le16 ant;
+				u8 __rsv[2];
+				__le32 idx;
+				__le32 data;
+			} __packed rf_reg;
+		};
+	} __packed * res, req;
+	struct sk_buff *skb;
+	int ret;
+
+	if (u32_get_bits(regidx, MT_RF_REG_HDR) == RF_REG_PREFIX) {
+		req.rf_reg.tag = cpu_to_le16(UNI_CMD_ACCESS_RF_REG_BASIC);
+		req.rf_reg.len = cpu_to_le16(sizeof(req.rf_reg));
+		req.rf_reg.ant = cpu_to_le16(u32_get_bits(regidx, MT_RF_REG_ANT));
+		req.rf_reg.idx = cpu_to_le32(regidx);
+		req.rf_reg.data = set ? cpu_to_le32(*val) : 0;
+	} else {
+		req.reg.tag = cpu_to_le16(UNI_CMD_ACCESS_REG_BASIC);
+		req.reg.len = cpu_to_le16(sizeof(req.reg));
+		req.reg.idx = cpu_to_le32(regidx);
+		req.reg.data = set ? cpu_to_le32(*val) : 0;
+	}
+
+	if (set)
+		return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(REG_ACCESS),
+					 &req, sizeof(req), true);
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76,
+					MCU_WM_UNI_CMD_QUERY(REG_ACCESS),
+					&req, sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	res = (void *)skb->data;
+	if (u32_get_bits(regidx, MT_RF_REG_HDR) == RF_REG_PREFIX)
+		*val = le32_to_cpu(res->rf_reg.data);
+	else
+		*val = le32_to_cpu(res->reg.data);
+
+	dev_kfree_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt7925_mcu_regval);
+
+int mt7925_mcu_update_arp_filter(struct mt76_dev *dev,
+				 struct ieee80211_bss_conf *link_conf)
+{
+	struct ieee80211_vif *mvif = container_of((void *)link_conf->vif,
+						  struct ieee80211_vif,
+						  drv_priv);
+	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
+	struct sk_buff *skb;
+	int i, len = min_t(int, mvif->cfg.arp_addr_cnt,
+			   IEEE80211_BSS_ARP_ADDR_LIST_LEN);
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt7925_arpns_tlv arp;
+	} req = {
+		.hdr = {
+			.bss_idx = mconf->mt76.idx,
+		},
+		.arp = {
+			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_ARP),
+			.len = cpu_to_le16(sizeof(req) - 4 + len * 2 * sizeof(__be32)),
+			.ips_num = len,
+			.enable = true,
+		},
+	};
+
+	skb = mt76_mcu_msg_alloc(dev, NULL, sizeof(req) + len * 2 * sizeof(__be32));
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put_data(skb, &req, sizeof(req));
+	for (i = 0; i < len; i++) {
+		skb_put_data(skb, &mvif->cfg.arp_addr_list[i], sizeof(__be32));
+		skb_put_zero(skb, sizeof(__be32));
+	}
+
+	return mt76_mcu_skb_send_msg(dev, skb, MCU_UNI_CMD(OFFLOAD), true);
+}
+
+#ifdef CONFIG_PM
+static int
+mt7925_connac_mcu_set_wow_ctrl(struct mt76_phy *phy, struct ieee80211_vif *vif,
+			       bool suspend, struct cfg80211_wowlan *wowlan)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt76_dev *dev = phy->dev;
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt76_connac_wow_ctrl_tlv wow_ctrl_tlv;
+		struct mt76_connac_wow_gpio_param_tlv gpio_tlv;
+	} req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.wow_ctrl_tlv = {
+			.tag = cpu_to_le16(UNI_SUSPEND_WOW_CTRL),
+			.len = cpu_to_le16(sizeof(struct mt76_connac_wow_ctrl_tlv)),
+			.cmd = suspend ? 1 : 2,
+		},
+		.gpio_tlv = {
+			.tag = cpu_to_le16(UNI_SUSPEND_WOW_GPIO_PARAM),
+			.len = cpu_to_le16(sizeof(struct mt76_connac_wow_gpio_param_tlv)),
+			.gpio_pin = 0xff, /* follow fw about GPIO pin */
+		},
+	};
+
+	if (wowlan->magic_pkt)
+		req.wow_ctrl_tlv.trigger |= UNI_WOW_DETECT_TYPE_MAGIC;
+	if (wowlan->disconnect)
+		req.wow_ctrl_tlv.trigger |= (UNI_WOW_DETECT_TYPE_DISCONNECT |
+					     UNI_WOW_DETECT_TYPE_BCN_LOST);
+	if (wowlan->nd_config) {
+		mt7925_mcu_sched_scan_req(phy, vif, wowlan->nd_config);
+		req.wow_ctrl_tlv.trigger |= UNI_WOW_DETECT_TYPE_SCH_SCAN_HIT;
+		mt7925_mcu_sched_scan_enable(phy, vif, suspend);
+	}
+	if (wowlan->n_patterns)
+		req.wow_ctrl_tlv.trigger |= UNI_WOW_DETECT_TYPE_BITMAP;
+
+	if (mt76_is_mmio(dev))
+		req.wow_ctrl_tlv.wakeup_hif = WOW_PCIE;
+	else if (mt76_is_usb(dev))
+		req.wow_ctrl_tlv.wakeup_hif = WOW_USB;
+	else if (mt76_is_sdio(dev))
+		req.wow_ctrl_tlv.wakeup_hif = WOW_GPIO;
+
+	return mt76_mcu_send_msg(dev, MCU_UNI_CMD(SUSPEND), &req,
+				 sizeof(req), true);
+}
+
+static int
+mt7925_mcu_set_wow_pattern(struct mt76_dev *dev,
+			   struct ieee80211_vif *vif,
+			   u8 index, bool enable,
+			   struct cfg80211_pkt_pattern *pattern)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt7925_wow_pattern_tlv *tlv;
+	struct sk_buff *skb;
+	struct {
+		u8 bss_idx;
+		u8 pad[3];
+	} __packed hdr = {
+		.bss_idx = mvif->idx,
+	};
+
+	skb = mt76_mcu_msg_alloc(dev, NULL, sizeof(hdr) + sizeof(*tlv));
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put_data(skb, &hdr, sizeof(hdr));
+	tlv = (struct mt7925_wow_pattern_tlv *)skb_put(skb, sizeof(*tlv));
+	tlv->tag = cpu_to_le16(UNI_SUSPEND_WOW_PATTERN);
+	tlv->len = cpu_to_le16(sizeof(*tlv));
+	tlv->bss_idx = 0xF;
+	tlv->data_len = pattern->pattern_len;
+	tlv->enable = enable;
+	tlv->index = index;
+	tlv->offset = 0;
+
+	memcpy(tlv->pattern, pattern->pattern, pattern->pattern_len);
+	memcpy(tlv->mask, pattern->mask, DIV_ROUND_UP(pattern->pattern_len, 8));
+
+	return mt76_mcu_skb_send_msg(dev, skb, MCU_UNI_CMD(SUSPEND), true);
+}
+
+void mt7925_mcu_set_suspend_iter(void *priv, u8 *mac,
+				 struct ieee80211_vif *vif)
+{
+	struct mt76_phy *phy = priv;
+	bool suspend = !test_bit(MT76_STATE_RUNNING, &phy->state);
+	struct ieee80211_hw *hw = phy->hw;
+	struct cfg80211_wowlan *wowlan = hw->wiphy->wowlan_config;
+	int i;
+
+	mt76_connac_mcu_set_gtk_rekey(phy->dev, vif, suspend);
+
+	mt76_connac_mcu_set_suspend_mode(phy->dev, vif, suspend, 1, true);
+
+	for (i = 0; i < wowlan->n_patterns; i++)
+		mt7925_mcu_set_wow_pattern(phy->dev, vif, i, suspend,
+					   &wowlan->patterns[i]);
+	mt7925_connac_mcu_set_wow_ctrl(phy, vif, suspend, wowlan);
+}
+
+#endif /* CONFIG_PM */
+
+static void
+mt7925_mcu_connection_loss_iter(void *priv, u8 *mac,
+				struct ieee80211_vif *vif)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt7925_uni_beacon_loss_event *event = priv;
+
+	if (mvif->idx != event->hdr.bss_idx)
+		return;
+
+	if (!(vif->driver_flags & IEEE80211_VIF_BEACON_FILTER) ||
+	    vif->type != NL80211_IFTYPE_STATION)
+		return;
+
+	ieee80211_connection_loss(vif);
+}
+
+static void
+mt7925_mcu_connection_loss_event(struct mt792x_dev *dev, struct sk_buff *skb)
+{
+	struct mt7925_uni_beacon_loss_event *event;
+	struct mt76_phy *mphy = &dev->mt76.phy;
+
+	skb_pull(skb, sizeof(struct mt7925_mcu_rxd));
+	event = (struct mt7925_uni_beacon_loss_event *)skb->data;
+
+	ieee80211_iterate_active_interfaces_atomic(mphy->hw,
+					IEEE80211_IFACE_ITER_RESUME_ALL,
+					mt7925_mcu_connection_loss_iter, event);
+}
+
+static void
+mt7925_mcu_roc_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt7925_roc_grant_tlv *grant = priv;
+
+	if (ieee80211_vif_is_mld(vif) && vif->type == NL80211_IFTYPE_STATION)
+		return;
+
+	if (mvif->idx != grant->bss_idx)
+		return;
+
+	mvif->band_idx = grant->dbdcband;
+}
+
+static void mt7925_mcu_roc_handle_grant(struct mt792x_dev *dev,
+					struct tlv *tlv)
+{
+	struct ieee80211_hw *hw = dev->mt76.hw;
+	struct mt7925_roc_grant_tlv *grant;
+	int duration;
+
+	grant = (struct mt7925_roc_grant_tlv *)tlv;
+
+	/* should never happen */
+	WARN_ON_ONCE((le16_to_cpu(grant->tag) != UNI_EVENT_ROC_GRANT));
+
+	if (grant->reqtype == MT7925_ROC_REQ_ROC)
+		ieee80211_ready_on_channel(hw);
+	else if (grant->reqtype == MT7925_ROC_REQ_JOIN)
+		ieee80211_iterate_active_interfaces_atomic(hw,
+						IEEE80211_IFACE_ITER_RESUME_ALL,
+						mt7925_mcu_roc_iter, grant);
+	dev->phy.roc_grant = true;
+	wake_up(&dev->phy.roc_wait);
+	duration = le32_to_cpu(grant->max_interval);
+	mod_timer(&dev->phy.roc_timer,
+		  jiffies + msecs_to_jiffies(duration));
+}
+
+static void
+mt7925_mcu_uni_roc_event(struct mt792x_dev *dev, struct sk_buff *skb)
+{
+	struct tlv *tlv;
+	int i = 0;
+
+	skb_pull(skb, sizeof(struct mt7925_mcu_rxd) + 4);
+
+	while (i < skb->len) {
+		tlv = (struct tlv *)(skb->data + i);
+
+		switch (le16_to_cpu(tlv->tag)) {
+		case UNI_EVENT_ROC_GRANT:
+			mt7925_mcu_roc_handle_grant(dev, tlv);
+			break;
+		case UNI_EVENT_ROC_GRANT_SUB_LINK:
+			break;
+		}
+
+		i += le16_to_cpu(tlv->len);
+	}
+}
+
+static void
+mt7925_mcu_scan_event(struct mt792x_dev *dev, struct sk_buff *skb)
+{
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt792x_phy *phy = mphy->priv;
+
+	spin_lock_bh(&dev->mt76.lock);
+	__skb_queue_tail(&phy->scan_event_list, skb);
+	spin_unlock_bh(&dev->mt76.lock);
+
+	ieee80211_queue_delayed_work(mphy->hw, &phy->scan_work,
+				     MT792x_HW_SCAN_TIMEOUT);
+}
+
+static void
+mt7925_mcu_tx_done_event(struct mt792x_dev *dev, struct sk_buff *skb)
+{
+#define UNI_EVENT_TX_DONE_MSG 0
+#define UNI_EVENT_TX_DONE_RAW 1
+	struct mt7925_mcu_txs_event {
+		u8 ver;
+		u8 rsv[3];
+		u8 data[0];
+	} __packed * txs;
+	struct tlv *tlv;
+	u32 tlv_len;
+
+	skb_pull(skb, sizeof(struct mt7925_mcu_rxd) + 4);
+	tlv = (struct tlv *)skb->data;
+	tlv_len = skb->len;
+
+	while (tlv_len > 0 && le16_to_cpu(tlv->len) <= tlv_len) {
+		switch (le16_to_cpu(tlv->tag)) {
+		case UNI_EVENT_TX_DONE_RAW:
+			txs = (struct mt7925_mcu_txs_event *)tlv->data;
+			mt7925_mac_add_txs(dev, txs->data);
+			break;
+		default:
+			break;
+		}
+		tlv_len -= le16_to_cpu(tlv->len);
+		tlv = (struct tlv *)((char *)(tlv) + le16_to_cpu(tlv->len));
+	}
+}
+
+static void
+mt7925_mcu_uni_debug_msg_event(struct mt792x_dev *dev, struct sk_buff *skb)
+{
+	struct mt7925_uni_debug_msg {
+		__le16 tag;
+		__le16 len;
+		u8 fmt;
+		u8 rsv[3];
+		u8 id;
+		u8 type:3;
+		u8 nr_args:5;
+		union {
+			struct idxlog {
+				__le16 rsv;
+				__le32 ts;
+				__le32 idx;
+				u8 data[];
+			} __packed idx;
+			struct txtlog {
+				u8 len;
+				u8 rsv;
+				__le32 ts;
+				u8 data[];
+			} __packed txt;
+		};
+	} __packed * hdr;
+
+	skb_pull(skb, sizeof(struct mt7925_mcu_rxd) + 4);
+	hdr = (struct mt7925_uni_debug_msg *)skb->data;
+
+	if (hdr->id == 0x28) {
+		skb_pull(skb, offsetof(struct mt7925_uni_debug_msg, id));
+		wiphy_info(mt76_hw(dev)->wiphy, "%.*s", skb->len, skb->data);
+		return;
+	} else if (hdr->id != 0xa8) {
+		return;
+	}
+
+	if (hdr->type == 0) { /* idx log */
+		int i, ret, len = PAGE_SIZE - 1, nr_val;
+		struct page *page = dev_alloc_pages(get_order(len));
+		__le32 *val;
+		char *buf, *cur;
+
+		if (!page)
+			return;
+
+		buf = page_address(page);
+		cur = buf;
+
+		nr_val = (le16_to_cpu(hdr->len) - sizeof(*hdr)) / 4;
+		val = (__le32 *)hdr->idx.data;
+		for (i = 0; i < nr_val && len > 0; i++) {
+			ret = snprintf(cur, len, "0x%x,", le32_to_cpu(val[i]));
+			if (ret <= 0)
+				break;
+
+			cur += ret;
+			len -= ret;
+		}
+		if (cur > buf)
+			wiphy_info(mt76_hw(dev)->wiphy, "idx: 0x%X,%d,%s",
+				   le32_to_cpu(hdr->idx.idx), nr_val, buf);
+		put_page(page);
+	} else if (hdr->type == 2) { /* str log */
+		wiphy_info(mt76_hw(dev)->wiphy, "%.*s", hdr->txt.len, hdr->txt.data);
+	}
+}
+
+static void
+mt7925_mcu_uni_rx_unsolicited_event(struct mt792x_dev *dev,
+				    struct sk_buff *skb)
+{
+	struct mt7925_mcu_rxd *rxd;
+
+	rxd = (struct mt7925_mcu_rxd *)skb->data;
+
+	switch (rxd->eid) {
+	case MCU_UNI_EVENT_FW_LOG_2_HOST:
+		mt7925_mcu_uni_debug_msg_event(dev, skb);
+		break;
+	case MCU_UNI_EVENT_ROC:
+		mt7925_mcu_uni_roc_event(dev, skb);
+		break;
+	case MCU_UNI_EVENT_SCAN_DONE:
+		mt7925_mcu_scan_event(dev, skb);
+		return;
+	case MCU_UNI_EVENT_TX_DONE:
+		mt7925_mcu_tx_done_event(dev, skb);
+		break;
+	case MCU_UNI_EVENT_BSS_BEACON_LOSS:
+		mt7925_mcu_connection_loss_event(dev, skb);
+		break;
+	case MCU_UNI_EVENT_COREDUMP:
+		dev->fw_assert = true;
+		mt76_connac_mcu_coredump_event(&dev->mt76, skb, &dev->coredump);
+		return;
+	default:
+		break;
+	}
+	dev_kfree_skb(skb);
+}
+
+void mt7925_mcu_rx_event(struct mt792x_dev *dev, struct sk_buff *skb)
+{
+	struct mt7925_mcu_rxd *rxd = (struct mt7925_mcu_rxd *)skb->data;
+
+	if (skb_linearize(skb))
+		return;
+
+	if (rxd->option & MCU_UNI_CMD_UNSOLICITED_EVENT) {
+		mt7925_mcu_uni_rx_unsolicited_event(dev, skb);
+		return;
+	}
+
+	mt76_mcu_rx_event(&dev->mt76, skb);
+}
+
+static int
+mt7925_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
+		  struct ieee80211_ampdu_params *params,
+		  bool enable, bool tx)
+{
+	struct mt76_wcid *wcid = (struct mt76_wcid *)params->sta->drv_priv;
+	struct sta_rec_ba_uni *ba;
+	struct sk_buff *skb;
+	struct tlv *tlv;
+	int len;
+
+	len = sizeof(struct sta_req_hdr) + sizeof(*ba);
+	skb = __mt76_connac_mcu_alloc_sta_req(dev, mvif, wcid,
+					      len);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_BA, sizeof(*ba));
+
+	ba = (struct sta_rec_ba_uni *)tlv;
+	ba->ba_type = tx ? MT_BA_TYPE_ORIGINATOR : MT_BA_TYPE_RECIPIENT;
+	ba->winsize = cpu_to_le16(params->buf_size);
+	ba->ssn = cpu_to_le16(params->ssn);
+	ba->ba_en = enable << params->tid;
+	ba->amsdu = params->amsdu;
+	ba->tid = params->tid;
+
+	return mt76_mcu_skb_send_msg(dev, skb,
+				     MCU_UNI_CMD(STA_REC_UPDATE), true);
+}
+
+/** starec & wtbl **/
+int mt7925_mcu_uni_tx_ba(struct mt792x_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool enable)
+{
+	struct mt792x_sta *msta = (struct mt792x_sta *)params->sta->drv_priv;
+	struct mt792x_vif *mvif = msta->vif;
+
+	if (enable && !params->amsdu)
+		msta->deflink.wcid.amsdu = false;
+
+	return mt7925_mcu_sta_ba(&dev->mt76, &mvif->bss_conf.mt76, params,
+				 enable, true);
+}
+
+int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool enable)
+{
+	struct mt792x_sta *msta = (struct mt792x_sta *)params->sta->drv_priv;
+	struct mt792x_vif *mvif = msta->vif;
+
+	return mt7925_mcu_sta_ba(&dev->mt76, &mvif->bss_conf.mt76, params,
+				 enable, false);
+}
+
+static int mt7925_load_clc(struct mt792x_dev *dev, const char *fw_name)
+{
+	const struct mt76_connac2_fw_trailer *hdr;
+	const struct mt76_connac2_fw_region *region;
+	const struct mt7925_clc *clc;
+	struct mt76_dev *mdev = &dev->mt76;
+	struct mt792x_phy *phy = &dev->phy;
+	const struct firmware *fw;
+	int ret, i, len, offset = 0;
+	u8 *clc_base = NULL;
+
+	if (mt7925_disable_clc ||
+	    mt76_is_usb(&dev->mt76))
+		return 0;
+
+	ret = request_firmware(&fw, fw_name, mdev->dev);
+	if (ret)
+		return ret;
+
+	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
+		dev_err(mdev->dev, "Invalid firmware\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hdr = (const void *)(fw->data + fw->size - sizeof(*hdr));
+	for (i = 0; i < hdr->n_region; i++) {
+		region = (const void *)((const u8 *)hdr -
+					(hdr->n_region - i) * sizeof(*region));
+		len = le32_to_cpu(region->len);
+
+		/* check if we have valid buffer size */
+		if (offset + len > fw->size) {
+			dev_err(mdev->dev, "Invalid firmware region\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if ((region->feature_set & FW_FEATURE_NON_DL) &&
+		    region->type == FW_TYPE_CLC) {
+			clc_base = (u8 *)(fw->data + offset);
+			break;
+		}
+		offset += len;
+	}
+
+	if (!clc_base)
+		goto out;
+
+	for (offset = 0; offset < len; offset += le32_to_cpu(clc->len)) {
+		clc = (const struct mt7925_clc *)(clc_base + offset);
+
+		if (clc->idx >= ARRAY_SIZE(phy->clc))
+			break;
+
+		/* do not init buf again if chip reset triggered */
+		if (phy->clc[clc->idx])
+			continue;
+
+		phy->clc[clc->idx] = devm_kmemdup(mdev->dev, clc,
+						  le32_to_cpu(clc->len),
+						  GFP_KERNEL);
+
+		if (!phy->clc[clc->idx]) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+
+	ret = mt7925_mcu_set_clc(dev, "00", ENVIRON_INDOOR);
+out:
+	release_firmware(fw);
+
+	return ret;
+}
+
+int mt7925_mcu_fw_log_2_host(struct mt792x_dev *dev, u8 ctrl)
+{
+	struct {
+		u8 _rsv[4];
+
+		__le16 tag;
+		__le16 len;
+		u8 ctrl;
+		u8 interval;
+		u8 _rsv2[2];
+	} __packed req = {
+		.tag = cpu_to_le16(UNI_WSYS_CONFIG_FW_LOG_CTRL),
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.ctrl = ctrl,
+	};
+	int ret;
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_UNI_CMD(WSYS_CONFIG),
+					&req, sizeof(req), false, NULL);
+	return ret;
+}
+
+int mt7925_mcu_get_temperature(struct mt792x_phy *phy)
+{
+	struct {
+		u8 _rsv[4];
+
+		__le16 tag;
+		__le16 len;
+		u8 _rsv2[4];
+	} __packed req = {
+		.tag = cpu_to_le16(0x0),
+		.len = cpu_to_le16(sizeof(req) - 4),
+	};
+	struct mt7925_thermal_evt {
+		u8 rsv[4];
+		__le32 temperature;
+	} __packed * evt;
+	struct mt792x_dev *dev = phy->dev;
+	int temperature, ret;
+	struct sk_buff *skb;
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76,
+					MCU_WM_UNI_CMD_QUERY(THERMAL),
+					&req, sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	skb_pull(skb, 4 + sizeof(struct tlv));
+	evt = (struct mt7925_thermal_evt *)skb->data;
+
+	temperature = le32_to_cpu(evt->temperature);
+
+	dev_kfree_skb(skb);
+
+	return temperature;
+}
+
+static void
+mt7925_mcu_parse_phy_cap(struct mt792x_dev *dev, char *data)
+{
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt76_dev *mdev = mphy->dev;
+	struct mt7925_mcu_phy_cap {
+		u8 ht;
+		u8 vht;
+		u8 _5g;
+		u8 max_bw;
+		u8 nss;
+		u8 dbdc;
+		u8 tx_ldpc;
+		u8 rx_ldpc;
+		u8 tx_stbc;
+		u8 rx_stbc;
+		u8 hw_path;
+		u8 he;
+		u8 eht;
+	} __packed * cap;
+	enum {
+		WF0_24G,
+		WF0_5G
+	};
+
+	cap = (struct mt7925_mcu_phy_cap *)data;
+
+	mdev->phy.antenna_mask = BIT(cap->nss) - 1;
+	mdev->phy.chainmask = mdev->phy.antenna_mask;
+	mdev->phy.cap.has_2ghz = cap->hw_path & BIT(WF0_24G);
+	mdev->phy.cap.has_5ghz = cap->hw_path & BIT(WF0_5G);
+	dev->has_eht = cap->eht;
+}
+
+static void
+mt7925_mcu_parse_eml_cap(struct mt792x_dev *dev, char *data)
+{
+	struct mt7925_mcu_eml_cap {
+		u8 rsv[4];
+		__le16 eml_cap;
+		u8 rsv2[6];
+	} __packed * cap;
+
+	cap = (struct mt7925_mcu_eml_cap *)data;
+
+	dev->phy.eml_cap = le16_to_cpu(cap->eml_cap);
+}
+
+static int
+mt7925_mcu_get_nic_capability(struct mt792x_dev *dev)
+{
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct {
+		u8 _rsv[4];
+
+		__le16 tag;
+		__le16 len;
+	} __packed req = {
+		.tag = cpu_to_le16(UNI_CHIP_CONFIG_NIC_CAPA),
+		.len = cpu_to_le16(sizeof(req) - 4),
+	};
+	struct mt76_connac_cap_hdr {
+		__le16 n_element;
+		u8 rsv[2];
+	} __packed * hdr;
+	struct sk_buff *skb;
+	int ret, i;
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_UNI_CMD(CHIP_CONFIG),
+					&req, sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	hdr = (struct mt76_connac_cap_hdr *)skb->data;
+	if (skb->len < sizeof(*hdr)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	skb_pull(skb, sizeof(*hdr));
+
+	for (i = 0; i < le16_to_cpu(hdr->n_element); i++) {
+		struct tlv *tlv = (struct tlv *)skb->data;
+		int len;
+
+		if (skb->len < sizeof(*tlv))
+			break;
+
+		len = le16_to_cpu(tlv->len);
+		if (skb->len < len)
+			break;
+
+		switch (le16_to_cpu(tlv->tag)) {
+		case MT_NIC_CAP_6G:
+			mphy->cap.has_6ghz = !!tlv->data[0];
+			break;
+		case MT_NIC_CAP_MAC_ADDR:
+			memcpy(mphy->macaddr, (void *)tlv->data, ETH_ALEN);
+			break;
+		case MT_NIC_CAP_PHY:
+			mt7925_mcu_parse_phy_cap(dev, tlv->data);
+			break;
+		case MT_NIC_CAP_CHIP_CAP:
+			memcpy(&dev->phy.chip_cap, (void *)skb->data, sizeof(u64));
+			break;
+		case MT_NIC_CAP_EML_CAP:
+			mt7925_mcu_parse_eml_cap(dev, tlv->data);
+			break;
+		default:
+			break;
+		}
+		skb_pull(skb, len);
+	}
+out:
+	dev_kfree_skb(skb);
+	return ret;
+}
+
+int mt7925_mcu_chip_config(struct mt792x_dev *dev, const char *cmd)
+{
+	u16 len = strlen(cmd) + 1;
+	struct {
+		u8 _rsv[4];
+		__le16 tag;
+		__le16 len;
+		struct mt76_connac_config config;
+	} __packed req = {
+		.tag = cpu_to_le16(UNI_CHIP_CONFIG_CHIP_CFG),
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.config = {
+			.resp_type = 0,
+			.type = 0,
+			.data_size = cpu_to_le16(len),
+		},
+	};
+
+	memcpy(req.config.data, cmd, len);
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(CHIP_CONFIG),
+				 &req, sizeof(req), false);
+}
+
+int mt7925_mcu_set_deep_sleep(struct mt792x_dev *dev, bool enable)
+{
+	char cmd[16];
+
+	snprintf(cmd, sizeof(cmd), "KeepFullPwr %d", !enable);
+
+	return mt7925_mcu_chip_config(dev, cmd);
+}
+EXPORT_SYMBOL_GPL(mt7925_mcu_set_deep_sleep);
+
+int mt7925_run_firmware(struct mt792x_dev *dev)
+{
+	int err;
+
+	err = mt792x_load_firmware(dev);
+	if (err)
+		return err;
+
+	err = mt7925_mcu_get_nic_capability(dev);
+	if (err)
+		return err;
+
+	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
+	err = mt7925_load_clc(dev, mt792x_ram_name(dev));
+	if (err)
+		return err;
+
+	return mt7925_mcu_fw_log_2_host(dev, 1);
+}
+EXPORT_SYMBOL_GPL(mt7925_run_firmware);
+
+static void
+mt7925_mcu_sta_hdr_trans_tlv(struct sk_buff *skb,
+			     struct ieee80211_vif *vif,
+			     struct ieee80211_link_sta *link_sta)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct sta_rec_hdr_trans *hdr_trans;
+	struct mt76_wcid *wcid;
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HDR_TRANS, sizeof(*hdr_trans));
+	hdr_trans = (struct sta_rec_hdr_trans *)tlv;
+	hdr_trans->dis_rx_hdr_tran = true;
+
+	if (vif->type == NL80211_IFTYPE_STATION)
+		hdr_trans->to_ds = true;
+	else
+		hdr_trans->from_ds = true;
+
+	if (link_sta) {
+		struct mt792x_sta *msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
+		struct mt792x_link_sta *mlink;
+
+		mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+		wcid = &mlink->wcid;
+	} else {
+		wcid = &mvif->sta.deflink.wcid;
+	}
+
+	if (!wcid)
+		return;
+
+	hdr_trans->dis_rx_hdr_tran = !test_bit(MT_WCID_FLAG_HDR_TRANS, &wcid->flags);
+	if (test_bit(MT_WCID_FLAG_4ADDR, &wcid->flags)) {
+		hdr_trans->to_ds = true;
+		hdr_trans->from_ds = true;
+	}
+}
+
+int mt7925_mcu_wtbl_update_hdr_trans(struct mt792x_dev *dev,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_sta *sta,
+				     int link_id)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct ieee80211_link_sta *link_sta = sta ? &sta->deflink : NULL;
+	struct mt792x_link_sta *mlink;
+	struct mt792x_bss_conf *mconf;
+	struct mt792x_sta *msta;
+	struct sk_buff *skb;
+
+	msta = sta ? (struct mt792x_sta *)sta->drv_priv : &mvif->sta;
+
+	mlink = mt792x_sta_to_link(msta, link_id);
+	link_sta = mt792x_sta_to_link_sta(vif, sta, link_id);
+	mconf = mt792x_vif_to_link(mvif, link_id);
+
+	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mconf->mt76,
+					      &mlink->wcid,
+					      MT7925_STA_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	/* starec hdr trans */
+	mt7925_mcu_sta_hdr_trans_tlv(skb, vif, link_sta);
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_WMWA_UNI_CMD(STA_REC_UPDATE), true);
+}
+
+int mt7925_mcu_set_tx(struct mt792x_dev *dev,
+		      struct ieee80211_bss_conf *bss_conf)
+{
+#define MCU_EDCA_AC_PARAM	0
+#define WMM_AIFS_SET		BIT(0)
+#define WMM_CW_MIN_SET		BIT(1)
+#define WMM_CW_MAX_SET		BIT(2)
+#define WMM_TXOP_SET		BIT(3)
+#define WMM_PARAM_SET		(WMM_AIFS_SET | WMM_CW_MIN_SET | \
+				 WMM_CW_MAX_SET | WMM_TXOP_SET)
+	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(bss_conf);
+	struct {
+		u8 bss_idx;
+		u8 __rsv[3];
+	} __packed hdr = {
+		.bss_idx = mconf->mt76.idx,
+	};
+	struct sk_buff *skb;
+	int len = sizeof(hdr) + IEEE80211_NUM_ACS * sizeof(struct edca);
+	int ac;
+
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, len);
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put_data(skb, &hdr, sizeof(hdr));
+
+	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
+		struct ieee80211_tx_queue_params *q = &mconf->queue_params[ac];
+		struct edca *e;
+		struct tlv *tlv;
+
+		tlv = mt76_connac_mcu_add_tlv(skb, MCU_EDCA_AC_PARAM, sizeof(*e));
+
+		e = (struct edca *)tlv;
+		e->set = WMM_PARAM_SET;
+		e->queue = ac;
+		e->aifs = q->aifs;
+		e->txop = cpu_to_le16(q->txop);
+
+		if (q->cw_min)
+			e->cw_min = fls(q->cw_min);
+		else
+			e->cw_min = 5;
+
+		if (q->cw_max)
+			e->cw_max = fls(q->cw_max);
+		else
+			e->cw_max = 10;
+	}
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_UNI_CMD(EDCA_UPDATE), true);
+}
+
+static int
+mt7925_mcu_sta_key_tlv(struct mt76_wcid *wcid,
+		       struct mt76_connac_sta_key_conf *sta_key_conf,
+		       struct sk_buff *skb,
+		       struct ieee80211_key_conf *key,
+		       enum set_key_cmd cmd,
+		       struct mt792x_sta *msta)
+{
+	struct mt792x_vif *mvif = msta->vif;
+	struct mt792x_bss_conf *mconf = mt792x_vif_to_link(mvif, wcid->link_id);
+	struct sta_rec_sec_uni *sec;
+	struct ieee80211_sta *sta;
+	struct ieee80211_vif *vif;
+	struct tlv *tlv;
+
+	sta = msta == &mvif->sta ?
+		      NULL :
+		      container_of((void *)msta, struct ieee80211_sta, drv_priv);
+	vif = container_of((void *)mvif, struct ieee80211_vif, drv_priv);
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_KEY_V3, sizeof(*sec));
+	sec = (struct sta_rec_sec_uni *)tlv;
+	sec->bss_idx = mconf->mt76.idx;
+	sec->is_authenticator = 0;
+	sec->mgmt_prot = 1; /* only used in MLO mode */
+	sec->wlan_idx = (u8)wcid->idx;
+
+	if (sta) {
+		struct ieee80211_link_sta *link_sta;
+
+		sec->tx_key = 1;
+		sec->key_type = 1;
+		link_sta = mt792x_sta_to_link_sta(vif, sta, wcid->link_id);
+
+		if (link_sta)
+			memcpy(sec->peer_addr, link_sta->addr, ETH_ALEN);
+	} else {
+		struct ieee80211_bss_conf *link_conf;
+
+		link_conf = mt792x_vif_to_bss_conf(vif, wcid->link_id);
+
+		if (link_conf)
+			memcpy(sec->peer_addr, link_conf->bssid, ETH_ALEN);
+	}
+
+	if (cmd == SET_KEY) {
+		u8 cipher;
+
+		sec->add = 1;
+		cipher = mt7925_mcu_get_cipher(key->cipher);
+		if (cipher == CONNAC3_CIPHER_NONE)
+			return -EOPNOTSUPP;
+
+		if (cipher == CONNAC3_CIPHER_BIP_CMAC_128) {
+			sec->cipher_id = CONNAC3_CIPHER_BIP_CMAC_128;
+			sec->key_id = sta_key_conf->keyidx;
+			sec->key_len = 32;
+			memcpy(sec->key, sta_key_conf->key, 16);
+			memcpy(sec->key + 16, key->key, 16);
+		} else {
+			sec->cipher_id = cipher;
+			sec->key_id = key->keyidx;
+			sec->key_len = key->keylen;
+			memcpy(sec->key, key->key, key->keylen);
+
+			if (cipher == CONNAC3_CIPHER_TKIP) {
+				/* Rx/Tx MIC keys are swapped */
+				memcpy(sec->key + 16, key->key + 24, 8);
+				memcpy(sec->key + 24, key->key + 16, 8);
+			}
+
+			/* store key_conf for BIP batch update */
+			if (cipher == CONNAC3_CIPHER_AES_CCMP) {
+				memcpy(sta_key_conf->key, key->key, key->keylen);
+				sta_key_conf->keyidx = key->keyidx;
+			}
+		}
+	} else {
+		sec->add = 0;
+	}
+
+	return 0;
+}
+
+int mt7925_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
+		       struct mt76_connac_sta_key_conf *sta_key_conf,
+		       struct ieee80211_key_conf *key, int mcu_cmd,
+		       struct mt76_wcid *wcid, enum set_key_cmd cmd,
+		       struct mt792x_sta *msta)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_bss_conf *mconf = mt792x_vif_to_link(mvif, wcid->link_id);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = __mt76_connac_mcu_alloc_sta_req(dev, &mconf->mt76, wcid,
+					      MT7925_STA_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	ret = mt7925_mcu_sta_key_tlv(wcid, sta_key_conf, skb, key, cmd, msta);
+	if (ret)
+		return ret;
+
+	return mt76_mcu_skb_send_msg(dev, skb, mcu_cmd, true);
+}
+
+int mt7925_mcu_set_mlo_roc(struct mt792x_bss_conf *mconf, u16 sel_links,
+			   int duration, u8 token_id)
+{
+	struct mt792x_vif *mvif = mconf->vif;
+	struct ieee80211_vif *vif = container_of((void *)mvif,
+						 struct ieee80211_vif, drv_priv);
+	struct ieee80211_bss_conf *link_conf;
+	struct ieee80211_channel *chan;
+	const u8 ch_band[] = {
+		[NL80211_BAND_2GHZ] = 1,
+		[NL80211_BAND_5GHZ] = 2,
+		[NL80211_BAND_6GHZ] = 3,
+	};
+	enum mt7925_roc_req type;
+	int center_ch, i = 0;
+	bool is_AG_band = false;
+	struct {
+		u8 id;
+		u8 bss_idx;
+		u16 tag;
+		struct mt792x_bss_conf *mconf;
+		struct ieee80211_channel *chan;
+	} links[2];
+
+	struct {
+		struct {
+			u8 rsv[4];
+		} __packed hdr;
+		struct roc_acquire_tlv roc[2];
+	} __packed req;
+
+	if (!mconf || hweight16(vif->valid_links) < 2 ||
+	    hweight16(sel_links) != 2)
+		return -EPERM;
+
+	for (i = 0; i < ARRAY_SIZE(links); i++) {
+		links[i].id = i ? __ffs(~BIT(mconf->link_id) & sel_links) :
+				 mconf->link_id;
+		link_conf = mt792x_vif_to_bss_conf(vif, links[i].id);
+		if (WARN_ON_ONCE(!link_conf))
+			return -EPERM;
+
+		links[i].chan = link_conf->chanreq.oper.chan;
+		if (WARN_ON_ONCE(!links[i].chan))
+			return -EPERM;
+
+		links[i].mconf = mt792x_vif_to_link(mvif, links[i].id);
+		links[i].tag = links[i].id == mconf->link_id ?
+			       UNI_ROC_ACQUIRE : UNI_ROC_SUB_LINK;
+
+		is_AG_band |= links[i].chan->band == NL80211_BAND_2GHZ;
+	}
+
+	if (vif->cfg.eml_cap & IEEE80211_EML_CAP_EMLSR_SUPP)
+		type = is_AG_band ? MT7925_ROC_REQ_MLSR_AG :
+				    MT7925_ROC_REQ_MLSR_AA;
+	else
+		type = MT7925_ROC_REQ_JOIN;
+
+	for (i = 0; i < ARRAY_SIZE(links) && i < hweight16(vif->active_links); i++) {
+		if (WARN_ON_ONCE(!links[i].mconf || !links[i].chan))
+			continue;
+
+		chan = links[i].chan;
+		center_ch = ieee80211_frequency_to_channel(chan->center_freq);
+		req.roc[i].len = cpu_to_le16(sizeof(struct roc_acquire_tlv));
+		req.roc[i].tag = cpu_to_le16(links[i].tag);
+		req.roc[i].tokenid = token_id;
+		req.roc[i].reqtype = type;
+		req.roc[i].maxinterval = cpu_to_le32(duration);
+		req.roc[i].bss_idx = links[i].mconf->mt76.idx;
+		req.roc[i].control_channel = chan->hw_value;
+		req.roc[i].bw = CMD_CBW_20MHZ;
+		req.roc[i].bw_from_ap = CMD_CBW_20MHZ;
+		req.roc[i].center_chan = center_ch;
+		req.roc[i].center_chan_from_ap = center_ch;
+
+		/* STR : 0xfe indicates BAND_ALL with enabling DBDC
+		 * EMLSR : 0xff indicates (BAND_AUTO) without DBDC
+		 */
+		req.roc[i].dbdcband = type == MT7925_ROC_REQ_JOIN ? 0xfe : 0xff;
+
+		if (chan->hw_value < center_ch)
+			req.roc[i].sco = 1; /* SCA */
+		else if (chan->hw_value > center_ch)
+			req.roc[i].sco = 3; /* SCB */
+
+		req.roc[i].band = ch_band[chan->band];
+	}
+
+	return mt76_mcu_send_msg(&mvif->phy->dev->mt76, MCU_UNI_CMD(ROC),
+				 &req, sizeof(req), false);
+}
+
+int mt7925_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_bss_conf *mconf,
+		       struct ieee80211_channel *chan, int duration,
+		       enum mt7925_roc_req type, u8 token_id)
+{
+	int center_ch = ieee80211_frequency_to_channel(chan->center_freq);
+	struct mt792x_dev *dev = phy->dev;
+	struct {
+		struct {
+			u8 rsv[4];
+		} __packed hdr;
+		struct roc_acquire_tlv roc;
+	} __packed req = {
+		.roc = {
+			.tag = cpu_to_le16(UNI_ROC_ACQUIRE),
+			.len = cpu_to_le16(sizeof(struct roc_acquire_tlv)),
+			.tokenid = token_id,
+			.reqtype = type,
+			.maxinterval = cpu_to_le32(duration),
+			.bss_idx = mconf->mt76.idx,
+			.control_channel = chan->hw_value,
+			.bw = CMD_CBW_20MHZ,
+			.bw_from_ap = CMD_CBW_20MHZ,
+			.center_chan = center_ch,
+			.center_chan_from_ap = center_ch,
+			.dbdcband = 0xff, /* auto */
+		},
+	};
+
+	if (chan->hw_value < center_ch)
+		req.roc.sco = 1; /* SCA */
+	else if (chan->hw_value > center_ch)
+		req.roc.sco = 3; /* SCB */
+
+	switch (chan->band) {
+	case NL80211_BAND_6GHZ:
+		req.roc.band = 3;
+		break;
+	case NL80211_BAND_5GHZ:
+		req.roc.band = 2;
+		break;
+	default:
+		req.roc.band = 1;
+		break;
+	}
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(ROC),
+				 &req, sizeof(req), false);
+}
+
+int mt7925_mcu_abort_roc(struct mt792x_phy *phy, struct mt792x_bss_conf *mconf,
+			 u8 token_id)
+{
+	struct mt792x_dev *dev = phy->dev;
+	struct {
+		struct {
+			u8 rsv[4];
+		} __packed hdr;
+		struct roc_abort_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 bss_idx;
+			u8 tokenid;
+			u8 dbdcband;
+			u8 rsv[5];
+		} __packed abort;
+	} __packed req = {
+		.abort = {
+			.tag = cpu_to_le16(UNI_ROC_ABORT),
+			.len = cpu_to_le16(sizeof(struct roc_abort_tlv)),
+			.tokenid = token_id,
+			.bss_idx = mconf->mt76.idx,
+			.dbdcband = 0xff, /* auto*/
+		},
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(ROC),
+				 &req, sizeof(req), false);
+}
+
+int mt7925_mcu_set_eeprom(struct mt792x_dev *dev)
+{
+	struct {
+		u8 _rsv[4];
+
+		__le16 tag;
+		__le16 len;
+		u8 buffer_mode;
+		u8 format;
+		__le16 buf_len;
+	} __packed req = {
+		.tag = cpu_to_le16(UNI_EFUSE_BUFFER_MODE),
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.buffer_mode = EE_MODE_EFUSE,
+		.format = EE_FORMAT_WHOLE
+	};
+
+	return mt76_mcu_send_and_get_msg(&dev->mt76, MCU_UNI_CMD(EFUSE_CTRL),
+					 &req, sizeof(req), false, NULL);
+}
+EXPORT_SYMBOL_GPL(mt7925_mcu_set_eeprom);
+
+int mt7925_mcu_uni_bss_ps(struct mt792x_dev *dev,
+			  struct ieee80211_bss_conf *link_conf)
+{
+	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct ps_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 ps_state; /* 0: device awake
+				      * 1: static power save
+				      * 2: dynamic power saving
+				      * 3: enter TWT power saving
+				      * 4: leave TWT power saving
+				      */
+			u8 pad[3];
+		} __packed ps;
+	} __packed ps_req = {
+		.hdr = {
+			.bss_idx = mconf->mt76.idx,
+		},
+		.ps = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_PS),
+			.len = cpu_to_le16(sizeof(struct ps_tlv)),
+			.ps_state = link_conf->vif->cfg.ps ? 2 : 0,
+		},
+	};
+
+	if (link_conf->vif->type != NL80211_IFTYPE_STATION)
+		return -EOPNOTSUPP;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(BSS_INFO_UPDATE),
+				 &ps_req, sizeof(ps_req), true);
+}
+
+static int
+mt7925_mcu_uni_bss_bcnft(struct mt792x_dev *dev,
+			 struct ieee80211_bss_conf *link_conf, bool enable)
+{
+	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct bcnft_tlv {
+			__le16 tag;
+			__le16 len;
+			__le16 bcn_interval;
+			u8 dtim_period;
+			u8 bmc_delivered_ac;
+			u8 bmc_triggered_ac;
+			u8 pad[3];
+		} __packed bcnft;
+	} __packed bcnft_req = {
+		.hdr = {
+			.bss_idx = mconf->mt76.idx,
+		},
+		.bcnft = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_BCNFT),
+			.len = cpu_to_le16(sizeof(struct bcnft_tlv)),
+			.bcn_interval = cpu_to_le16(link_conf->beacon_int),
+			.dtim_period = link_conf->dtim_period,
+		},
+	};
+
+	if (link_conf->vif->type != NL80211_IFTYPE_STATION)
+		return 0;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(BSS_INFO_UPDATE),
+				 &bcnft_req, sizeof(bcnft_req), true);
+}
+
+int
+mt7925_mcu_set_bss_pm(struct mt792x_dev *dev,
+		      struct ieee80211_bss_conf *link_conf,
+		      bool enable)
+{
+	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct bcnft_tlv {
+			__le16 tag;
+			__le16 len;
+			__le16 bcn_interval;
+			u8 dtim_period;
+			u8 bmc_delivered_ac;
+			u8 bmc_triggered_ac;
+			u8 pad[3];
+		} __packed enable;
+	} req = {
+		.hdr = {
+			.bss_idx = mconf->mt76.idx,
+		},
+		.enable = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_BCNFT),
+			.len = cpu_to_le16(sizeof(struct bcnft_tlv)),
+			.dtim_period = link_conf->dtim_period,
+			.bcn_interval = cpu_to_le16(link_conf->beacon_int),
+		},
+	};
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct pm_disable {
+			__le16 tag;
+			__le16 len;
+		} __packed disable;
+	} req1 = {
+		.hdr = {
+			.bss_idx = mconf->mt76.idx,
+		},
+		.disable = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_PM_DISABLE),
+			.len = cpu_to_le16(sizeof(struct pm_disable))
+		},
+	};
+	int err;
+
+	err = mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(BSS_INFO_UPDATE),
+				&req1, sizeof(req1), false);
+	if (err < 0 || !enable)
+		return err;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(BSS_INFO_UPDATE),
+				 &req, sizeof(req), false);
+}
+
+static void
+mt7925_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_link_sta *link_sta)
+{
+	if (!link_sta->he_cap.has_he)
+		return;
+
+	mt76_connac_mcu_sta_he_tlv_v2(skb, link_sta->sta);
+}
+
+static void
+mt7925_mcu_sta_he_6g_tlv(struct sk_buff *skb,
+			 struct ieee80211_link_sta *link_sta)
+{
+	struct sta_rec_he_6g_capa *he_6g;
+	struct tlv *tlv;
+
+	if (!link_sta->he_6ghz_capa.capa)
+		return;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HE_6G, sizeof(*he_6g));
+
+	he_6g = (struct sta_rec_he_6g_capa *)tlv;
+	he_6g->capa = link_sta->he_6ghz_capa.capa;
+}
+
+static void
+mt7925_mcu_sta_eht_tlv(struct sk_buff *skb, struct ieee80211_link_sta *link_sta)
+{
+	struct ieee80211_eht_mcs_nss_supp *mcs_map;
+	struct ieee80211_eht_cap_elem_fixed *elem;
+	struct sta_rec_eht *eht;
+	struct tlv *tlv;
+
+	if (!link_sta->eht_cap.has_eht)
+		return;
+
+	mcs_map = &link_sta->eht_cap.eht_mcs_nss_supp;
+	elem = &link_sta->eht_cap.eht_cap_elem;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_EHT, sizeof(*eht));
+
+	eht = (struct sta_rec_eht *)tlv;
+	eht->tid_bitmap = 0xff;
+	eht->mac_cap = cpu_to_le16(*(u16 *)elem->mac_cap_info);
+	eht->phy_cap = cpu_to_le64(*(u64 *)elem->phy_cap_info);
+	eht->phy_cap_ext = cpu_to_le64(elem->phy_cap_info[8]);
+
+	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_20)
+		memcpy(eht->mcs_map_bw20, &mcs_map->only_20mhz, sizeof(eht->mcs_map_bw20));
+	memcpy(eht->mcs_map_bw80, &mcs_map->bw._80, sizeof(eht->mcs_map_bw80));
+	memcpy(eht->mcs_map_bw160, &mcs_map->bw._160, sizeof(eht->mcs_map_bw160));
+}
+
+static void
+mt7925_mcu_sta_ht_tlv(struct sk_buff *skb, struct ieee80211_link_sta *link_sta)
+{
+	struct sta_rec_ht *ht;
+	struct tlv *tlv;
+
+	if (!link_sta->ht_cap.ht_supported)
+		return;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HT, sizeof(*ht));
+
+	ht = (struct sta_rec_ht *)tlv;
+	ht->ht_cap = cpu_to_le16(link_sta->ht_cap.cap);
+}
+
+static void
+mt7925_mcu_sta_vht_tlv(struct sk_buff *skb, struct ieee80211_link_sta *link_sta)
+{
+	struct sta_rec_vht *vht;
+	struct tlv *tlv;
+
+	/* For 6G band, this tlv is necessary to let hw work normally */
+	if (!link_sta->he_6ghz_capa.capa && !link_sta->vht_cap.vht_supported)
+		return;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_VHT, sizeof(*vht));
+
+	vht = (struct sta_rec_vht *)tlv;
+	vht->vht_cap = cpu_to_le32(link_sta->vht_cap.cap);
+	vht->vht_rx_mcs_map = link_sta->vht_cap.vht_mcs.rx_mcs_map;
+	vht->vht_tx_mcs_map = link_sta->vht_cap.vht_mcs.tx_mcs_map;
+}
+
+static void
+mt7925_mcu_sta_amsdu_tlv(struct sk_buff *skb,
+			 struct ieee80211_vif *vif,
+			 struct ieee80211_link_sta *link_sta)
+{
+	struct mt792x_sta *msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
+	struct mt792x_link_sta *mlink;
+	struct sta_rec_amsdu *amsdu;
+	struct tlv *tlv;
+
+	if (vif->type != NL80211_IFTYPE_STATION &&
+	    vif->type != NL80211_IFTYPE_AP)
+		return;
+
+	if (!link_sta->agg.max_amsdu_len)
+		return;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HW_AMSDU, sizeof(*amsdu));
+	amsdu = (struct sta_rec_amsdu *)tlv;
+	amsdu->max_amsdu_num = 8;
+	amsdu->amsdu_en = true;
+
+	mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+	mlink->wcid.amsdu = true;
+
+	switch (link_sta->agg.max_amsdu_len) {
+	case IEEE80211_MAX_MPDU_LEN_VHT_11454:
+		amsdu->max_mpdu_size =
+			IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454;
+		return;
+	case IEEE80211_MAX_MPDU_LEN_HT_7935:
+	case IEEE80211_MAX_MPDU_LEN_VHT_7991:
+		amsdu->max_mpdu_size = IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991;
+		return;
+	default:
+		amsdu->max_mpdu_size = IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_3895;
+		return;
+	}
+}
+
+static void
+mt7925_mcu_sta_phy_tlv(struct sk_buff *skb,
+		       struct ieee80211_vif *vif,
+		       struct ieee80211_link_sta *link_sta)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct ieee80211_bss_conf *link_conf;
+	struct cfg80211_chan_def *chandef;
+	struct mt792x_bss_conf *mconf;
+	struct sta_rec_phy *phy;
+	struct tlv *tlv;
+	u8 af = 0, mm = 0;
+
+	link_conf = mt792x_vif_to_bss_conf(vif, link_sta->link_id);
+	mconf = mt792x_vif_to_link(mvif, link_sta->link_id);
+	chandef = mconf->mt76.ctx ? &mconf->mt76.ctx->def :
+				    &link_conf->chanreq.oper;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_PHY, sizeof(*phy));
+	phy = (struct sta_rec_phy *)tlv;
+	phy->phy_type = mt76_connac_get_phy_mode_v2(mvif->phy->mt76, vif,
+						    chandef->chan->band,
+						    link_sta);
+	phy->basic_rate = cpu_to_le16((u16)link_conf->basic_rates);
+	if (link_sta->ht_cap.ht_supported) {
+		af = link_sta->ht_cap.ampdu_factor;
+		mm = link_sta->ht_cap.ampdu_density;
+	}
+
+	if (link_sta->vht_cap.vht_supported) {
+		u8 vht_af = FIELD_GET(IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK,
+				      link_sta->vht_cap.cap);
+
+		af = max_t(u8, af, vht_af);
+	}
+
+	if (link_sta->he_6ghz_capa.capa) {
+		af = le16_get_bits(link_sta->he_6ghz_capa.capa,
+				   IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP);
+		mm = le16_get_bits(link_sta->he_6ghz_capa.capa,
+				   IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START);
+	}
+
+	phy->ampdu = FIELD_PREP(IEEE80211_HT_AMPDU_PARM_FACTOR, af) |
+		     FIELD_PREP(IEEE80211_HT_AMPDU_PARM_DENSITY, mm);
+	phy->max_ampdu_len = af;
+}
+
+static void
+mt7925_mcu_sta_state_v2_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
+			    struct ieee80211_link_sta *link_sta,
+			    struct ieee80211_vif *vif,
+			    u8 rcpi, u8 sta_state)
+{
+	struct sta_rec_state_v2 {
+		__le16 tag;
+		__le16 len;
+		u8 state;
+		u8 rsv[3];
+		__le32 flags;
+		u8 vht_opmode;
+		u8 action;
+		u8 rsv2[2];
+	} __packed * state;
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_STATE, sizeof(*state));
+	state = (struct sta_rec_state_v2 *)tlv;
+	state->state = sta_state;
+
+	if (link_sta->vht_cap.vht_supported) {
+		state->vht_opmode = link_sta->bandwidth;
+		state->vht_opmode |= link_sta->rx_nss <<
+			IEEE80211_OPMODE_NOTIF_RX_NSS_SHIFT;
+	}
+}
+
+static void
+mt7925_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb,
+			     struct ieee80211_vif *vif,
+			     struct ieee80211_link_sta *link_sta)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct ieee80211_bss_conf *link_conf;
+	struct cfg80211_chan_def *chandef;
+	struct sta_rec_ra_info *ra_info;
+	struct mt792x_bss_conf *mconf;
+	enum nl80211_band band;
+	struct tlv *tlv;
+	u16 supp_rates;
+
+	link_conf = mt792x_vif_to_bss_conf(vif, link_sta->link_id);
+	mconf = mt792x_vif_to_link(mvif, link_sta->link_id);
+	chandef = mconf->mt76.ctx ? &mconf->mt76.ctx->def :
+				    &link_conf->chanreq.oper;
+	band = chandef->chan->band;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_RA, sizeof(*ra_info));
+	ra_info = (struct sta_rec_ra_info *)tlv;
+
+	supp_rates = link_sta->supp_rates[band];
+	if (band == NL80211_BAND_2GHZ)
+		supp_rates = FIELD_PREP(RA_LEGACY_OFDM, supp_rates >> 4) |
+			     FIELD_PREP(RA_LEGACY_CCK, supp_rates & 0xf);
+	else
+		supp_rates = FIELD_PREP(RA_LEGACY_OFDM, supp_rates);
+
+	ra_info->legacy = cpu_to_le16(supp_rates);
+
+	if (link_sta->ht_cap.ht_supported)
+		memcpy(ra_info->rx_mcs_bitmask,
+		       link_sta->ht_cap.mcs.rx_mask,
+		       HT_MCS_MASK_NUM);
+}
+
+static void
+mt7925_mcu_sta_eht_mld_tlv(struct sk_buff *skb,
+			   struct ieee80211_vif *vif, struct ieee80211_sta *sta)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct wiphy *wiphy = mvif->phy->mt76->hw->wiphy;
+	const struct wiphy_iftype_ext_capab *ext_capa;
+	struct sta_rec_eht_mld *eht_mld;
+	struct tlv *tlv;
+	u16 eml_cap;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_EHT_MLD, sizeof(*eht_mld));
+	eht_mld = (struct sta_rec_eht_mld *)tlv;
+	eht_mld->mld_type = 0xff;
+
+	if (!ieee80211_vif_is_mld(vif))
+		return;
+
+	ext_capa = cfg80211_get_iftype_ext_capa(wiphy,
+						ieee80211_vif_type_p2p(vif));
+	if (!ext_capa)
+		return;
+
+	eml_cap = (vif->cfg.eml_cap & (IEEE80211_EML_CAP_EMLSR_SUPP |
+				       IEEE80211_EML_CAP_TRANSITION_TIMEOUT)) |
+		  (ext_capa->eml_capabilities & (IEEE80211_EML_CAP_EMLSR_PADDING_DELAY |
+						IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY));
+
+	if (eml_cap & IEEE80211_EML_CAP_EMLSR_SUPP) {
+		eht_mld->eml_cap[0] = u16_get_bits(eml_cap, GENMASK(7, 0));
+		eht_mld->eml_cap[1] = u16_get_bits(eml_cap, GENMASK(15, 8));
+	} else {
+		eht_mld->str_cap[0] = BIT(1);
+	}
+}
+
+static void
+mt7925_mcu_sta_mld_tlv(struct sk_buff *skb,
+		       struct ieee80211_vif *vif, struct ieee80211_sta *sta)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	unsigned long valid = mvif->valid_links;
+	struct mt792x_bss_conf *mconf;
+	struct mt792x_link_sta *mlink;
+	struct sta_rec_mld *mld;
+	struct tlv *tlv;
+	int i, cnt = 0;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_MLD, sizeof(*mld));
+	mld = (struct sta_rec_mld *)tlv;
+	memcpy(mld->mac_addr, sta->addr, ETH_ALEN);
+	mld->primary_id = cpu_to_le16(msta->deflink.wcid.idx);
+	mld->wlan_id = cpu_to_le16(msta->deflink.wcid.idx);
+	mld->link_num = min_t(u8, hweight16(mvif->valid_links), 2);
+
+	for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
+		if (cnt == mld->link_num)
+			break;
+
+		mconf = mt792x_vif_to_link(mvif, i);
+		mlink = mt792x_sta_to_link(msta, i);
+		mld->link[cnt].wlan_id = cpu_to_le16(mlink->wcid.idx);
+		mld->link[cnt++].bss_idx = mconf->mt76.idx;
+
+		if (mlink != &msta->deflink)
+			mld->secondary_id = cpu_to_le16(mlink->wcid.idx);
+	}
+}
+
+static int
+mt7925_mcu_sta_cmd(struct mt76_phy *phy,
+		   struct mt76_sta_cmd_info *info)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)info->vif->drv_priv;
+	struct mt76_dev *dev = phy->dev;
+	struct sk_buff *skb;
+	int conn_state;
+
+	skb = __mt76_connac_mcu_alloc_sta_req(dev, mvif, info->wcid,
+					      MT7925_STA_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	conn_state = info->enable ? CONN_STATE_PORT_SECURE :
+				    CONN_STATE_DISCONNECT;
+	if (info->link_sta)
+		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->vif,
+					      info->link_sta,
+					      conn_state, info->newly);
+	if (info->link_sta && info->enable) {
+		mt7925_mcu_sta_phy_tlv(skb, info->vif, info->link_sta);
+		mt7925_mcu_sta_ht_tlv(skb, info->link_sta);
+		mt7925_mcu_sta_vht_tlv(skb, info->link_sta);
+		mt76_connac_mcu_sta_uapsd(skb, info->vif, info->link_sta->sta);
+		mt7925_mcu_sta_amsdu_tlv(skb, info->vif, info->link_sta);
+		mt7925_mcu_sta_he_tlv(skb, info->link_sta);
+		mt7925_mcu_sta_he_6g_tlv(skb, info->link_sta);
+		mt7925_mcu_sta_eht_tlv(skb, info->link_sta);
+		mt7925_mcu_sta_rate_ctrl_tlv(skb, info->vif,
+					     info->link_sta);
+		mt7925_mcu_sta_state_v2_tlv(phy, skb, info->link_sta,
+					    info->vif, info->rcpi,
+					    info->state);
+		mt7925_mcu_sta_mld_tlv(skb, info->vif, info->link_sta->sta);
+	}
+
+	if (info->enable)
+		mt7925_mcu_sta_hdr_trans_tlv(skb, info->vif, info->link_sta);
+
+	return mt76_mcu_skb_send_msg(dev, skb, info->cmd, true);
+}
+
+static void
+mt7925_mcu_sta_remove_tlv(struct sk_buff *skb)
+{
+	struct sta_rec_remove *rem;
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, 0x25, sizeof(*rem));
+	rem = (struct sta_rec_remove *)tlv;
+	rem->action = 0;
+}
+
+static int
+mt7925_mcu_mlo_sta_cmd(struct mt76_phy *phy,
+		       struct mt76_sta_cmd_info *info)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)info->vif->drv_priv;
+	struct mt76_dev *dev = phy->dev;
+	struct mt792x_bss_conf *mconf;
+	struct sk_buff *skb;
+
+	mconf = mt792x_vif_to_link(mvif, info->wcid->link_id);
+
+	skb = __mt76_connac_mcu_alloc_sta_req(dev, &mconf->mt76, info->wcid,
+					      MT7925_STA_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	if (info->enable)
+		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->vif,
+					      info->link_sta,
+					      info->enable, info->newly);
+
+	if (info->enable && info->link_sta) {
+		mt7925_mcu_sta_phy_tlv(skb, info->vif, info->link_sta);
+		mt7925_mcu_sta_ht_tlv(skb, info->link_sta);
+		mt7925_mcu_sta_vht_tlv(skb, info->link_sta);
+		mt76_connac_mcu_sta_uapsd(skb, info->vif, info->link_sta->sta);
+		mt7925_mcu_sta_amsdu_tlv(skb, info->vif, info->link_sta);
+		mt7925_mcu_sta_he_tlv(skb, info->link_sta);
+		mt7925_mcu_sta_he_6g_tlv(skb, info->link_sta);
+		mt7925_mcu_sta_eht_tlv(skb, info->link_sta);
+		mt7925_mcu_sta_rate_ctrl_tlv(skb, info->vif,
+					     info->link_sta);
+		mt7925_mcu_sta_state_v2_tlv(phy, skb, info->link_sta,
+					    info->vif, info->rcpi,
+					    info->state);
+
+		if (info->state != MT76_STA_INFO_STATE_NONE) {
+			mt7925_mcu_sta_mld_tlv(skb, info->vif, info->link_sta->sta);
+			mt7925_mcu_sta_eht_mld_tlv(skb, info->vif, info->link_sta->sta);
+		}
+
+		mt7925_mcu_sta_hdr_trans_tlv(skb, info->vif, info->link_sta);
+	}
+
+	if (!info->enable) {
+		mt7925_mcu_sta_remove_tlv(skb);
+		mt76_connac_mcu_add_tlv(skb, STA_REC_MLD_OFF,
+					sizeof(struct tlv));
+	}
+
+	return mt76_mcu_skb_send_msg(dev, skb, info->cmd, true);
+}
+
+int mt7925_mcu_sta_update(struct mt792x_dev *dev,
+			  struct ieee80211_link_sta *link_sta,
+			  struct ieee80211_vif *vif, bool enable,
+			  enum mt76_sta_info_state state)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	int rssi = -ewma_rssi_read(&mvif->bss_conf.rssi);
+	struct mt76_sta_cmd_info info = {
+		.link_sta = link_sta,
+		.vif = vif,
+		.enable = enable,
+		.cmd = MCU_UNI_CMD(STA_REC_UPDATE),
+		.state = state,
+		.offload_fw = true,
+		.rcpi = to_rcpi(rssi),
+	};
+	struct mt792x_sta *msta;
+	struct mt792x_link_sta *mlink;
+	int err;
+
+	if (link_sta) {
+		msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
+		mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+	}
+	info.wcid = link_sta ? &mlink->wcid : &mvif->sta.deflink.wcid;
+	info.newly = link_sta ? state != MT76_STA_INFO_STATE_ASSOC : true;
+
+	if (ieee80211_vif_is_mld(vif))
+		err = mt7925_mcu_mlo_sta_cmd(&dev->mphy, &info);
+	else
+		err = mt7925_mcu_sta_cmd(&dev->mphy, &info);
+
+	return err;
+}
+
+int mt7925_mcu_set_beacon_filter(struct mt792x_dev *dev,
+				 struct ieee80211_vif *vif,
+				 bool enable)
+{
+#define MT7925_FIF_BIT_CLR		BIT(1)
+#define MT7925_FIF_BIT_SET		BIT(0)
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	unsigned long valid = ieee80211_vif_is_mld(vif) ?
+				      mvif->valid_links : BIT(0);
+	struct ieee80211_bss_conf *bss_conf;
+	int err = 0;
+	int i;
+
+	if (enable) {
+		for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
+			bss_conf = mt792x_vif_to_bss_conf(vif, i);
+			err = mt7925_mcu_uni_bss_bcnft(dev, bss_conf, true);
+			if (err < 0)
+				return err;
+		}
+
+		return mt7925_mcu_set_rxfilter(dev, 0,
+					       MT7925_FIF_BIT_SET,
+					       MT_WF_RFCR_DROP_OTHER_BEACON);
+	}
+
+	for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
+		bss_conf = mt792x_vif_to_bss_conf(vif, i);
+		err = mt7925_mcu_set_bss_pm(dev, bss_conf, false);
+		if (err)
+			return err;
+	}
+
+	return mt7925_mcu_set_rxfilter(dev, 0,
+				       MT7925_FIF_BIT_CLR,
+				       MT_WF_RFCR_DROP_OTHER_BEACON);
+}
+
+int mt7925_get_txpwr_info(struct mt792x_dev *dev, u8 band_idx, struct mt7925_txpwr *txpwr)
+{
+#define TX_POWER_SHOW_INFO 0x7
+#define TXPOWER_ALL_RATE_POWER_INFO 0x2
+	struct mt7925_txpwr_event *event;
+	struct mt7925_txpwr_req req = {
+		.tag = cpu_to_le16(TX_POWER_SHOW_INFO),
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.catg = TXPOWER_ALL_RATE_POWER_INFO,
+		.band_idx = band_idx,
+	};
+	struct sk_buff *skb;
+	int ret;
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_UNI_CMD(TXPOWER),
+					&req, sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	event = (struct mt7925_txpwr_event *)skb->data;
+	memcpy(txpwr, &event->txpwr, sizeof(event->txpwr));
+
+	dev_kfree_skb(skb);
+
+	return 0;
+}
+
+int mt7925_mcu_set_sniffer(struct mt792x_dev *dev, struct ieee80211_vif *vif,
+			   bool enable)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+
+	struct {
+		struct {
+			u8 band_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct sniffer_enable_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 enable;
+			u8 pad[3];
+		} __packed enable;
+	} __packed req = {
+		.hdr = {
+			.band_idx = 0,
+		},
+		.enable = {
+			.tag = cpu_to_le16(UNI_SNIFFER_ENABLE),
+			.len = cpu_to_le16(sizeof(struct sniffer_enable_tlv)),
+			.enable = enable,
+		},
+	};
+
+	mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(SNIFFER), &req, sizeof(req), true);
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(SNIFFER), &req, sizeof(req),
+				 true);
+}
+
+int mt7925_mcu_config_sniffer(struct mt792x_vif *vif,
+			      struct ieee80211_chanctx_conf *ctx)
+{
+	struct mt76_phy *mphy = vif->phy->mt76;
+	struct cfg80211_chan_def *chandef = ctx ? &ctx->def : &mphy->chandef;
+	int freq1 = chandef->center_freq1, freq2 = chandef->center_freq2;
+
+	static const u8 ch_band[] = {
+		[NL80211_BAND_2GHZ] = 1,
+		[NL80211_BAND_5GHZ] = 2,
+		[NL80211_BAND_6GHZ] = 3,
+	};
+	static const u8 ch_width[] = {
+		[NL80211_CHAN_WIDTH_20_NOHT] = 0,
+		[NL80211_CHAN_WIDTH_20] = 0,
+		[NL80211_CHAN_WIDTH_40] = 0,
+		[NL80211_CHAN_WIDTH_80] = 1,
+		[NL80211_CHAN_WIDTH_160] = 2,
+		[NL80211_CHAN_WIDTH_80P80] = 3,
+		[NL80211_CHAN_WIDTH_5] = 4,
+		[NL80211_CHAN_WIDTH_10] = 5,
+		[NL80211_CHAN_WIDTH_320] = 6,
+	};
+
+	struct {
+		struct {
+			u8 band_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct config_tlv {
+			__le16 tag;
+			__le16 len;
+			u16 aid;
+			u8 ch_band;
+			u8 bw;
+			u8 control_ch;
+			u8 sco;
+			u8 center_ch;
+			u8 center_ch2;
+			u8 drop_err;
+			u8 pad[3];
+		} __packed tlv;
+	} __packed req = {
+		.hdr = {
+			.band_idx = vif->bss_conf.mt76.band_idx,
+		},
+		.tlv = {
+			.tag = cpu_to_le16(UNI_SNIFFER_CONFIG),
+			.len = cpu_to_le16(sizeof(req.tlv)),
+			.control_ch = chandef->chan->hw_value,
+			.center_ch = ieee80211_frequency_to_channel(freq1),
+			.drop_err = 1,
+		},
+	};
+
+	if (chandef->chan->band < ARRAY_SIZE(ch_band))
+		req.tlv.ch_band = ch_band[chandef->chan->band];
+	if (chandef->width < ARRAY_SIZE(ch_width))
+		req.tlv.bw = ch_width[chandef->width];
+
+	if (freq2)
+		req.tlv.center_ch2 = ieee80211_frequency_to_channel(freq2);
+
+	if (req.tlv.control_ch < req.tlv.center_ch)
+		req.tlv.sco = 1; /* SCA */
+	else if (req.tlv.control_ch > req.tlv.center_ch)
+		req.tlv.sco = 3; /* SCB */
+
+	return mt76_mcu_send_msg(mphy->dev, MCU_UNI_CMD(SNIFFER),
+				 &req, sizeof(req), true);
+}
+
+int
+mt7925_mcu_uni_add_beacon_offload(struct mt792x_dev *dev,
+				  struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  bool enable)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct ieee80211_mutable_offsets offs;
+	struct {
+		struct req_hdr {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct bcn_content_tlv {
+			__le16 tag;
+			__le16 len;
+			__le16 tim_ie_pos;
+			__le16 csa_ie_pos;
+			__le16 bcc_ie_pos;
+			/* 0: disable beacon offload
+			 * 1: enable beacon offload
+			 * 2: update probe respond offload
+			 */
+			u8 enable;
+			/* 0: legacy format (TXD + payload)
+			 * 1: only cap field IE
+			 */
+			u8 type;
+			__le16 pkt_len;
+			u8 pkt[512];
+		} __packed beacon_tlv;
+	} req = {
+		.hdr = {
+			.bss_idx = mvif->bss_conf.mt76.idx,
+		},
+		.beacon_tlv = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_BCN_CONTENT),
+			.len = cpu_to_le16(sizeof(struct bcn_content_tlv)),
+			.enable = enable,
+			.type = 1,
+		},
+	};
+	struct sk_buff *skb;
+	u8 cap_offs;
+
+	/* support enable/update process only
+	 * disable flow would be handled in bss stop handler automatically
+	 */
+	if (!enable)
+		return -EOPNOTSUPP;
+
+	skb = ieee80211_beacon_get_template(mt76_hw(dev), vif, &offs, 0);
+	if (!skb)
+		return -EINVAL;
+
+	cap_offs = offsetof(struct ieee80211_mgmt, u.beacon.capab_info);
+	if (!skb_pull(skb, cap_offs)) {
+		dev_err(dev->mt76.dev, "beacon format err\n");
+		dev_kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	if (skb->len > 512) {
+		dev_err(dev->mt76.dev, "beacon size limit exceed\n");
+		dev_kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	memcpy(req.beacon_tlv.pkt, skb->data, skb->len);
+	req.beacon_tlv.pkt_len = cpu_to_le16(skb->len);
+	offs.tim_offset -= cap_offs;
+	req.beacon_tlv.tim_ie_pos = cpu_to_le16(offs.tim_offset);
+
+	if (offs.cntdwn_counter_offs[0]) {
+		u16 csa_offs;
+
+		csa_offs = offs.cntdwn_counter_offs[0] - cap_offs - 4;
+		req.beacon_tlv.csa_ie_pos = cpu_to_le16(csa_offs);
+	}
+	dev_kfree_skb(skb);
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(BSS_INFO_UPDATE),
+				 &req, sizeof(req), true);
+}
+
+static
+void mt7925_mcu_bss_rlm_tlv(struct sk_buff *skb, struct mt76_phy *phy,
+			    struct ieee80211_bss_conf *link_conf,
+			    struct ieee80211_chanctx_conf *ctx)
+{
+	struct cfg80211_chan_def *chandef = ctx ? &ctx->def :
+						  &link_conf->chanreq.oper;
+	int freq1 = chandef->center_freq1, freq2 = chandef->center_freq2;
+	enum nl80211_band band = chandef->chan->band;
+	struct bss_rlm_tlv *req;
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_RLM, sizeof(*req));
+	req = (struct bss_rlm_tlv *)tlv;
+	req->control_channel = chandef->chan->hw_value;
+	req->center_chan = ieee80211_frequency_to_channel(freq1);
+	req->center_chan2 = ieee80211_frequency_to_channel(freq2);
+	req->tx_streams = hweight8(phy->antenna_mask);
+	req->ht_op_info = 4; /* set HT 40M allowed */
+	req->rx_streams = hweight8(phy->antenna_mask);
+	req->band = band;
+
+	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_40:
+		req->bw = CMD_CBW_40MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_80:
+		req->bw = CMD_CBW_80MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_80P80:
+		req->bw = CMD_CBW_8080MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_160:
+		req->bw = CMD_CBW_160MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_5:
+		req->bw = CMD_CBW_5MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_10:
+		req->bw = CMD_CBW_10MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_20_NOHT:
+	case NL80211_CHAN_WIDTH_20:
+	default:
+		req->bw = CMD_CBW_20MHZ;
+		req->ht_op_info = 0;
+		break;
+	}
+
+	if (req->control_channel < req->center_chan)
+		req->sco = 1; /* SCA */
+	else if (req->control_channel > req->center_chan)
+		req->sco = 3; /* SCB */
+}
+
+static struct sk_buff *
+__mt7925_mcu_alloc_bss_req(struct mt76_dev *dev, struct mt76_vif *mvif, int len)
+{
+	struct bss_req_hdr hdr = {
+		.bss_idx = mvif->idx,
+	};
+	struct sk_buff *skb;
+
+	skb = mt76_mcu_msg_alloc(dev, NULL, len);
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
+
+	skb_put_data(skb, &hdr, sizeof(hdr));
+
+	return skb;
+}
+
+int mt7925_mcu_set_chctx(struct mt76_phy *phy, struct mt76_vif *mvif,
+			 struct ieee80211_bss_conf *link_conf,
+			 struct ieee80211_chanctx_conf *ctx)
+{
+	struct sk_buff *skb;
+
+	skb = __mt7925_mcu_alloc_bss_req(phy->dev, mvif,
+					 MT7925_BSS_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	mt7925_mcu_bss_rlm_tlv(skb, phy, link_conf, ctx);
+
+	return mt76_mcu_skb_send_msg(phy->dev, skb,
+				     MCU_UNI_CMD(BSS_INFO_UPDATE), true);
+}
+
+static u8
+mt7925_get_phy_mode_ext(struct mt76_phy *phy, struct ieee80211_vif *vif,
+			enum nl80211_band band,
+			struct ieee80211_link_sta *link_sta)
+{
+	struct ieee80211_he_6ghz_capa *he_6ghz_capa;
+	const struct ieee80211_sta_eht_cap *eht_cap;
+	__le16 capa = 0;
+	u8 mode = 0;
+
+	if (link_sta) {
+		he_6ghz_capa = &link_sta->he_6ghz_capa;
+		eht_cap = &link_sta->eht_cap;
+	} else {
+		struct ieee80211_supported_band *sband;
+
+		sband = phy->hw->wiphy->bands[band];
+		capa = ieee80211_get_he_6ghz_capa(sband, vif->type);
+		he_6ghz_capa = (struct ieee80211_he_6ghz_capa *)&capa;
+
+		eht_cap = ieee80211_get_eht_iftype_cap(sband, vif->type);
+	}
+
+	switch (band) {
+	case NL80211_BAND_2GHZ:
+		if (eht_cap && eht_cap->has_eht)
+			mode |= PHY_MODE_BE_24G;
+		break;
+	case NL80211_BAND_5GHZ:
+		if (eht_cap && eht_cap->has_eht)
+			mode |= PHY_MODE_BE_5G;
+		break;
+	case NL80211_BAND_6GHZ:
+		if (he_6ghz_capa && he_6ghz_capa->capa)
+			mode |= PHY_MODE_AX_6G;
+
+		if (eht_cap && eht_cap->has_eht)
+			mode |= PHY_MODE_BE_6G;
+		break;
+	default:
+		break;
+	}
+
+	return mode;
+}
+
+static void
+mt7925_mcu_bss_basic_tlv(struct sk_buff *skb,
+			 struct ieee80211_bss_conf *link_conf,
+			 struct ieee80211_link_sta *link_sta,
+			 struct ieee80211_chanctx_conf *ctx,
+			 struct mt76_phy *phy, u16 wlan_idx,
+			 bool enable)
+{
+	struct ieee80211_vif *vif = link_conf->vif;
+	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
+	struct cfg80211_chan_def *chandef = ctx ? &ctx->def :
+						  &link_conf->chanreq.oper;
+	enum nl80211_band band = chandef->chan->band;
+	struct mt76_connac_bss_basic_tlv *basic_req;
+	struct mt792x_link_sta *mlink;
+	struct tlv *tlv;
+	int conn_type;
+	u8 idx;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_BASIC, sizeof(*basic_req));
+	basic_req = (struct mt76_connac_bss_basic_tlv *)tlv;
+
+	idx = mconf->mt76.omac_idx > EXT_BSSID_START ? HW_BSSID_0 :
+						      mconf->mt76.omac_idx;
+	basic_req->hw_bss_idx = idx;
+
+	basic_req->phymode_ext = mt7925_get_phy_mode_ext(phy, vif, band,
+							 link_sta);
+
+	if (band == NL80211_BAND_2GHZ)
+		basic_req->nonht_basic_phy = cpu_to_le16(PHY_TYPE_ERP_INDEX);
+	else
+		basic_req->nonht_basic_phy = cpu_to_le16(PHY_TYPE_OFDM_INDEX);
+
+	memcpy(basic_req->bssid, link_conf->bssid, ETH_ALEN);
+	basic_req->phymode = mt76_connac_get_phy_mode(phy, vif, band, link_sta);
+	basic_req->bcn_interval = cpu_to_le16(link_conf->beacon_int);
+	basic_req->dtim_period = link_conf->dtim_period;
+	basic_req->bmc_tx_wlan_idx = cpu_to_le16(wlan_idx);
+	basic_req->link_idx = mconf->mt76.idx;
+
+	if (link_sta) {
+		struct mt792x_sta *msta;
+
+		msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
+		mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+
+	} else {
+		mlink = &mconf->vif->sta.deflink;
+	}
+
+	basic_req->sta_idx = cpu_to_le16(mlink->wcid.idx);
+	basic_req->omac_idx = mconf->mt76.omac_idx;
+	basic_req->band_idx = mconf->mt76.band_idx;
+	basic_req->wmm_idx = mconf->mt76.wmm_idx;
+	basic_req->conn_state = !enable;
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_AP:
+		if (vif->p2p)
+			conn_type = CONNECTION_P2P_GO;
+		else
+			conn_type = CONNECTION_INFRA_AP;
+		basic_req->conn_type = cpu_to_le32(conn_type);
+		basic_req->active = enable;
+		break;
+	case NL80211_IFTYPE_STATION:
+		if (vif->p2p)
+			conn_type = CONNECTION_P2P_GC;
+		else
+			conn_type = CONNECTION_INFRA_STA;
+		basic_req->conn_type = cpu_to_le32(conn_type);
+		basic_req->active = true;
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		basic_req->conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
+		basic_req->active = true;
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+}
+
+static void
+mt7925_mcu_bss_sec_tlv(struct sk_buff *skb,
+		       struct ieee80211_bss_conf *link_conf)
+{
+	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
+	struct mt76_vif *mvif = &mconf->mt76;
+	struct bss_sec_tlv {
+		__le16 tag;
+		__le16 len;
+		u8 mode;
+		u8 status;
+		u8 cipher;
+		u8 __rsv;
+	} __packed * sec;
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_SEC, sizeof(*sec));
+	sec = (struct bss_sec_tlv *)tlv;
+
+	switch (mvif->cipher) {
+	case CONNAC3_CIPHER_GCMP_256:
+	case CONNAC3_CIPHER_GCMP:
+		sec->mode = MODE_WPA3_SAE;
+		sec->status = 8;
+		break;
+	case CONNAC3_CIPHER_AES_CCMP:
+		sec->mode = MODE_WPA2_PSK;
+		sec->status = 6;
+		break;
+	case CONNAC3_CIPHER_TKIP:
+		sec->mode = MODE_WPA2_PSK;
+		sec->status = 4;
+		break;
+	case CONNAC3_CIPHER_WEP104:
+	case CONNAC3_CIPHER_WEP40:
+		sec->mode = MODE_SHARED;
+		sec->status = 0;
+		break;
+	default:
+		sec->mode = MODE_OPEN;
+		sec->status = 1;
+		break;
+	}
+
+	sec->cipher = mvif->cipher;
+}
+
+static void
+mt7925_mcu_bss_bmc_tlv(struct sk_buff *skb, struct mt792x_phy *phy,
+		       struct ieee80211_chanctx_conf *ctx,
+		       struct ieee80211_bss_conf *link_conf)
+{
+	struct cfg80211_chan_def *chandef = ctx ? &ctx->def :
+						  &link_conf->chanreq.oper;
+	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
+	enum nl80211_band band = chandef->chan->band;
+	struct mt76_vif *mvif = &mconf->mt76;
+	struct bss_rate_tlv *bmc;
+	struct tlv *tlv;
+	u8 idx = mvif->mcast_rates_idx ?
+		 mvif->mcast_rates_idx : mvif->basic_rates_idx;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_RATE, sizeof(*bmc));
+
+	bmc = (struct bss_rate_tlv *)tlv;
+
+	if (band == NL80211_BAND_2GHZ)
+		bmc->basic_rate = cpu_to_le16(HR_DSSS_ERP_BASIC_RATE);
+	else
+		bmc->basic_rate = cpu_to_le16(OFDM_BASIC_RATE);
+
+	bmc->short_preamble = (band == NL80211_BAND_2GHZ);
+	bmc->bc_fixed_rate = idx;
+	bmc->mc_fixed_rate = idx;
+}
+
+static void
+mt7925_mcu_bss_mld_tlv(struct sk_buff *skb,
+		       struct ieee80211_bss_conf *link_conf)
+{
+	struct ieee80211_vif *vif = link_conf->vif;
+	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
+	struct mt792x_vif *mvif = (struct mt792x_vif *)link_conf->vif->drv_priv;
+	struct bss_mld_tlv *mld;
+	struct tlv *tlv;
+	bool is_mld;
+
+	is_mld = ieee80211_vif_is_mld(link_conf->vif) ||
+		 (hweight16(mvif->valid_links) > 1);
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_MLD, sizeof(*mld));
+	mld = (struct bss_mld_tlv *)tlv;
+
+	mld->link_id = is_mld ? link_conf->link_id : 0xff;
+	/* apply the index of the primary link */
+	mld->group_mld_id = is_mld ? mvif->bss_conf.mt76.idx : 0xff;
+	mld->own_mld_id = mconf->mt76.idx + 32;
+	mld->remap_idx = 0xff;
+	mld->eml_enable = !!(link_conf->vif->cfg.eml_cap &
+			     IEEE80211_EML_CAP_EMLSR_SUPP);
+
+	memcpy(mld->mac_addr, vif->addr, ETH_ALEN);
+}
+
+static void
+mt7925_mcu_bss_qos_tlv(struct sk_buff *skb, struct ieee80211_bss_conf *link_conf)
+{
+	struct mt76_connac_bss_qos_tlv *qos;
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_QBSS, sizeof(*qos));
+	qos = (struct mt76_connac_bss_qos_tlv *)tlv;
+	qos->qos = link_conf->qos;
+}
+
+static void
+mt7925_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_bss_conf *link_conf,
+		      struct mt792x_phy *phy)
+{
+#define DEFAULT_HE_PE_DURATION		4
+#define DEFAULT_HE_DURATION_RTS_THRES	1023
+	const struct ieee80211_sta_he_cap *cap;
+	struct bss_info_uni_he *he;
+	struct tlv *tlv;
+
+	cap = mt76_connac_get_he_phy_cap(phy->mt76, link_conf->vif);
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_HE_BASIC, sizeof(*he));
+
+	he = (struct bss_info_uni_he *)tlv;
+	he->he_pe_duration = link_conf->htc_trig_based_pkt_ext;
+	if (!he->he_pe_duration)
+		he->he_pe_duration = DEFAULT_HE_PE_DURATION;
+
+	he->he_rts_thres = cpu_to_le16(link_conf->frame_time_rts_th);
+	if (!he->he_rts_thres)
+		he->he_rts_thres = cpu_to_le16(DEFAULT_HE_DURATION_RTS_THRES);
+
+	he->max_nss_mcs[CMD_HE_MCS_BW80] = cap->he_mcs_nss_supp.tx_mcs_80;
+	he->max_nss_mcs[CMD_HE_MCS_BW160] = cap->he_mcs_nss_supp.tx_mcs_160;
+	he->max_nss_mcs[CMD_HE_MCS_BW8080] = cap->he_mcs_nss_supp.tx_mcs_80p80;
+}
+
+static void
+mt7925_mcu_bss_color_tlv(struct sk_buff *skb, struct ieee80211_bss_conf *link_conf,
+			 bool enable)
+{
+	struct bss_info_uni_bss_color *color;
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_BSS_COLOR, sizeof(*color));
+	color = (struct bss_info_uni_bss_color *)tlv;
+
+	color->enable = enable ?
+		link_conf->he_bss_color.enabled : 0;
+	color->bss_color = enable ?
+		link_conf->he_bss_color.color : 0;
+}
+
+static void
+mt7925_mcu_bss_ifs_tlv(struct sk_buff *skb,
+		       struct ieee80211_bss_conf *link_conf)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)link_conf->vif->drv_priv;
+	struct mt792x_phy *phy = mvif->phy;
+	struct bss_ifs_time_tlv *ifs_time;
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_IFS_TIME, sizeof(*ifs_time));
+	ifs_time = (struct bss_ifs_time_tlv *)tlv;
+	ifs_time->slot_valid = true;
+	ifs_time->slot_time = cpu_to_le16(phy->slottime);
+}
+
+int mt7925_mcu_set_timing(struct mt792x_phy *phy,
+			  struct ieee80211_bss_conf *link_conf)
+{
+	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
+	struct mt792x_dev *dev = phy->dev;
+	struct sk_buff *skb;
+
+	skb = __mt7925_mcu_alloc_bss_req(&dev->mt76, &mconf->mt76,
+					 MT7925_BSS_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	mt7925_mcu_bss_ifs_tlv(skb, link_conf);
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_UNI_CMD(BSS_INFO_UPDATE), true);
+}
+
+int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
+			    struct ieee80211_chanctx_conf *ctx,
+			    struct ieee80211_bss_conf *link_conf,
+			    struct ieee80211_link_sta *link_sta,
+			    int enable)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)link_conf->vif->drv_priv;
+	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
+	struct mt792x_dev *dev = phy->dev;
+	struct mt792x_link_sta *mlink_bc;
+	struct sk_buff *skb;
+
+	skb = __mt7925_mcu_alloc_bss_req(&dev->mt76, &mconf->mt76,
+					 MT7925_BSS_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	mlink_bc = mt792x_sta_to_link(&mvif->sta, mconf->link_id);
+
+	/* bss_basic must be first */
+	mt7925_mcu_bss_basic_tlv(skb, link_conf, link_sta, ctx, phy->mt76,
+				 mlink_bc->wcid.idx, enable);
+	mt7925_mcu_bss_sec_tlv(skb, link_conf);
+	mt7925_mcu_bss_bmc_tlv(skb, phy, ctx, link_conf);
+	mt7925_mcu_bss_qos_tlv(skb, link_conf);
+	mt7925_mcu_bss_mld_tlv(skb, link_conf);
+	mt7925_mcu_bss_ifs_tlv(skb, link_conf);
+
+	if (link_conf->he_support) {
+		mt7925_mcu_bss_he_tlv(skb, link_conf, phy);
+		mt7925_mcu_bss_color_tlv(skb, link_conf, enable);
+	}
+
+	if (enable)
+		mt7925_mcu_bss_rlm_tlv(skb, phy->mt76, link_conf, ctx);
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_UNI_CMD(BSS_INFO_UPDATE), true);
+}
+
+int mt7925_mcu_set_dbdc(struct mt76_phy *phy)
+{
+	struct mt76_dev *mdev = phy->dev;
+
+	struct mbmc_conf_tlv *conf;
+	struct mbmc_set_req *hdr;
+	struct sk_buff *skb;
+	struct tlv *tlv;
+	int max_len, err;
+
+	max_len = sizeof(*hdr) + sizeof(*conf);
+	skb = mt76_mcu_msg_alloc(mdev, NULL, max_len);
+	if (!skb)
+		return -ENOMEM;
+
+	hdr = (struct mbmc_set_req *)skb_put(skb, sizeof(*hdr));
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_MBMC_SETTING, sizeof(*conf));
+	conf = (struct mbmc_conf_tlv *)tlv;
+
+	conf->mbmc_en = 1;
+	conf->band = 0; /* unused */
+
+	err = mt76_mcu_skb_send_msg(mdev, skb, MCU_UNI_CMD(SET_DBDC_PARMS),
+				    false);
+
+	return err;
+}
+
+#define MT76_CONNAC_SCAN_CHANNEL_TIME		60
+
+int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
+		       struct ieee80211_scan_request *scan_req)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct cfg80211_scan_request *sreq = &scan_req->req;
+	int n_ssids = 0, err, i, duration;
+	struct ieee80211_channel **scan_list = sreq->channels;
+	struct mt76_dev *mdev = phy->dev;
+	struct mt76_connac_mcu_scan_channel *chan;
+	struct sk_buff *skb;
+
+	struct scan_hdr_tlv *hdr;
+	struct scan_req_tlv *req;
+	struct scan_ssid_tlv *ssid;
+	struct scan_bssid_tlv *bssid;
+	struct scan_chan_info_tlv *chan_info;
+	struct scan_ie_tlv *ie;
+	struct scan_misc_tlv *misc;
+	struct tlv *tlv;
+	int max_len;
+
+	max_len = sizeof(*hdr) + sizeof(*req) + sizeof(*ssid) +
+				sizeof(*bssid) + sizeof(*chan_info) +
+				sizeof(*misc) + sizeof(*ie);
+
+	skb = mt76_mcu_msg_alloc(mdev, NULL, max_len);
+	if (!skb)
+		return -ENOMEM;
+
+	set_bit(MT76_HW_SCANNING, &phy->state);
+	mvif->scan_seq_num = (mvif->scan_seq_num + 1) & 0x7f;
+
+	hdr = (struct scan_hdr_tlv *)skb_put(skb, sizeof(*hdr));
+	hdr->seq_num = mvif->scan_seq_num | mvif->band_idx << 7;
+	hdr->bss_idx = mvif->idx;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_SCAN_REQ, sizeof(*req));
+	req = (struct scan_req_tlv *)tlv;
+	req->scan_type = sreq->n_ssids ? 1 : 0;
+	req->probe_req_num = sreq->n_ssids ? 2 : 0;
+
+	duration = MT76_CONNAC_SCAN_CHANNEL_TIME;
+	/* increase channel time for passive scan */
+	if (!sreq->n_ssids)
+		duration *= 2;
+	req->timeout_value = cpu_to_le16(sreq->n_channels * duration);
+	req->channel_min_dwell_time = cpu_to_le16(duration);
+	req->channel_dwell_time = cpu_to_le16(duration);
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_SCAN_SSID, sizeof(*ssid));
+	ssid = (struct scan_ssid_tlv *)tlv;
+	for (i = 0; i < sreq->n_ssids; i++) {
+		if (!sreq->ssids[i].ssid_len)
+			continue;
+
+		ssid->ssids[i].ssid_len = cpu_to_le32(sreq->ssids[i].ssid_len);
+		memcpy(ssid->ssids[i].ssid, sreq->ssids[i].ssid,
+		       sreq->ssids[i].ssid_len);
+		n_ssids++;
+	}
+	ssid->ssid_type = n_ssids ? BIT(2) : BIT(0);
+	ssid->ssids_num = n_ssids;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_SCAN_BSSID, sizeof(*bssid));
+	bssid = (struct scan_bssid_tlv *)tlv;
+
+	memcpy(bssid->bssid, sreq->bssid, ETH_ALEN);
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_SCAN_CHANNEL, sizeof(*chan_info));
+	chan_info = (struct scan_chan_info_tlv *)tlv;
+	chan_info->channels_num = min_t(u8, sreq->n_channels,
+					ARRAY_SIZE(chan_info->channels));
+	for (i = 0; i < chan_info->channels_num; i++) {
+		chan = &chan_info->channels[i];
+
+		switch (scan_list[i]->band) {
+		case NL80211_BAND_2GHZ:
+			chan->band = 1;
+			break;
+		case NL80211_BAND_6GHZ:
+			chan->band = 3;
+			break;
+		default:
+			chan->band = 2;
+			break;
+		}
+		chan->channel_num = scan_list[i]->hw_value;
+	}
+	chan_info->channel_type = sreq->n_channels ? 4 : 0;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_SCAN_IE, sizeof(*ie));
+	ie = (struct scan_ie_tlv *)tlv;
+	if (sreq->ie_len > 0) {
+		memcpy(ie->ies, sreq->ie, sreq->ie_len);
+		ie->ies_len = cpu_to_le16(sreq->ie_len);
+	}
+
+	req->scan_func |= SCAN_FUNC_SPLIT_SCAN;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_SCAN_MISC, sizeof(*misc));
+	misc = (struct scan_misc_tlv *)tlv;
+	if (sreq->flags & NL80211_SCAN_FLAG_RANDOM_ADDR) {
+		get_random_mask_addr(misc->random_mac, sreq->mac_addr,
+				     sreq->mac_addr_mask);
+		req->scan_func |= SCAN_FUNC_RANDOM_MAC;
+	}
+
+	err = mt76_mcu_skb_send_msg(mdev, skb, MCU_UNI_CMD(SCAN_REQ),
+				    false);
+	if (err < 0)
+		clear_bit(MT76_HW_SCANNING, &phy->state);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(mt7925_mcu_hw_scan);
+
+int mt7925_mcu_sched_scan_req(struct mt76_phy *phy,
+			      struct ieee80211_vif *vif,
+			      struct cfg80211_sched_scan_request *sreq)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct ieee80211_channel **scan_list = sreq->channels;
+	struct mt76_connac_mcu_scan_channel *chan;
+	struct mt76_dev *mdev = phy->dev;
+	struct cfg80211_match_set *cfg_match;
+	struct cfg80211_ssid *cfg_ssid;
+
+	struct scan_hdr_tlv *hdr;
+	struct scan_sched_req *req;
+	struct scan_ssid_tlv *ssid;
+	struct scan_chan_info_tlv *chan_info;
+	struct scan_ie_tlv *ie;
+	struct scan_sched_ssid_match_sets *match;
+	struct sk_buff *skb;
+	struct tlv *tlv;
+	int i, max_len;
+
+	max_len = sizeof(*hdr) + sizeof(*req) + sizeof(*ssid) +
+		  sizeof(*chan_info) + sizeof(*ie) +
+		  sizeof(*match);
+
+	skb = mt76_mcu_msg_alloc(mdev, NULL, max_len);
+	if (!skb)
+		return -ENOMEM;
+
+	mvif->scan_seq_num = (mvif->scan_seq_num + 1) & 0x7f;
+
+	hdr = (struct scan_hdr_tlv *)skb_put(skb, sizeof(*hdr));
+	hdr->seq_num = mvif->scan_seq_num | mvif->band_idx << 7;
+	hdr->bss_idx = mvif->idx;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_SCAN_SCHED_REQ, sizeof(*req));
+	req = (struct scan_sched_req *)tlv;
+	req->version = 1;
+
+	if (sreq->flags & NL80211_SCAN_FLAG_RANDOM_ADDR)
+		req->scan_func |= SCAN_FUNC_RANDOM_MAC;
+
+	req->intervals_num = sreq->n_scan_plans;
+	for (i = 0; i < req->intervals_num; i++)
+		req->intervals[i] = cpu_to_le16(sreq->scan_plans[i].interval);
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_SCAN_SSID, sizeof(*ssid));
+	ssid = (struct scan_ssid_tlv *)tlv;
+
+	ssid->ssids_num = sreq->n_ssids;
+	ssid->ssid_type = BIT(2);
+	for (i = 0; i < ssid->ssids_num; i++) {
+		cfg_ssid = &sreq->ssids[i];
+		memcpy(ssid->ssids[i].ssid, cfg_ssid->ssid, cfg_ssid->ssid_len);
+		ssid->ssids[i].ssid_len = cpu_to_le32(cfg_ssid->ssid_len);
+	}
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_SCAN_SSID_MATCH_SETS, sizeof(*match));
+	match = (struct scan_sched_ssid_match_sets *)tlv;
+	match->match_num = sreq->n_match_sets;
+	for (i = 0; i < match->match_num; i++) {
+		cfg_match = &sreq->match_sets[i];
+		memcpy(match->match[i].ssid, cfg_match->ssid.ssid,
+		       cfg_match->ssid.ssid_len);
+		match->match[i].rssi_th = cpu_to_le32(cfg_match->rssi_thold);
+		match->match[i].ssid_len = cfg_match->ssid.ssid_len;
+	}
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_SCAN_CHANNEL, sizeof(*chan_info));
+	chan_info = (struct scan_chan_info_tlv *)tlv;
+	chan_info->channels_num = min_t(u8, sreq->n_channels,
+					ARRAY_SIZE(chan_info->channels));
+	for (i = 0; i < chan_info->channels_num; i++) {
+		chan = &chan_info->channels[i];
+
+		switch (scan_list[i]->band) {
+		case NL80211_BAND_2GHZ:
+			chan->band = 1;
+			break;
+		case NL80211_BAND_6GHZ:
+			chan->band = 3;
+			break;
+		default:
+			chan->band = 2;
+			break;
+		}
+		chan->channel_num = scan_list[i]->hw_value;
+	}
+	chan_info->channel_type = sreq->n_channels ? 4 : 0;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_SCAN_IE, sizeof(*ie));
+	ie = (struct scan_ie_tlv *)tlv;
+	if (sreq->ie_len > 0) {
+		memcpy(ie->ies, sreq->ie, sreq->ie_len);
+		ie->ies_len = cpu_to_le16(sreq->ie_len);
+	}
+
+	return mt76_mcu_skb_send_msg(mdev, skb, MCU_UNI_CMD(SCAN_REQ),
+				     false);
+}
+EXPORT_SYMBOL_GPL(mt7925_mcu_sched_scan_req);
+
+int
+mt7925_mcu_sched_scan_enable(struct mt76_phy *phy,
+			     struct ieee80211_vif *vif,
+			     bool enable)
+{
+	struct mt76_dev *mdev = phy->dev;
+	struct scan_sched_enable *req;
+	struct scan_hdr_tlv *hdr;
+	struct sk_buff *skb;
+	struct tlv *tlv;
+	int max_len;
+
+	max_len = sizeof(*hdr) + sizeof(*req);
+
+	skb = mt76_mcu_msg_alloc(mdev, NULL, max_len);
+	if (!skb)
+		return -ENOMEM;
+
+	hdr = (struct scan_hdr_tlv *)skb_put(skb, sizeof(*hdr));
+	hdr->seq_num = 0;
+	hdr->bss_idx = 0;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_SCAN_SCHED_ENABLE, sizeof(*req));
+	req = (struct scan_sched_enable *)tlv;
+	req->active = !enable;
+
+	if (enable)
+		set_bit(MT76_HW_SCHED_SCANNING, &phy->state);
+	else
+		clear_bit(MT76_HW_SCHED_SCANNING, &phy->state);
+
+	return mt76_mcu_skb_send_msg(mdev, skb, MCU_UNI_CMD(SCAN_REQ),
+				     false);
+}
+
+int mt7925_mcu_cancel_hw_scan(struct mt76_phy *phy,
+			      struct ieee80211_vif *vif)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct {
+		struct scan_hdr {
+			u8 seq_num;
+			u8 bss_idx;
+			u8 pad[2];
+		} __packed hdr;
+		struct scan_cancel_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 is_ext_channel;
+			u8 rsv[3];
+		} __packed cancel;
+	} req = {
+		.hdr = {
+			.seq_num = mvif->scan_seq_num,
+			.bss_idx = mvif->idx,
+		},
+		.cancel = {
+			.tag = cpu_to_le16(UNI_SCAN_CANCEL),
+			.len = cpu_to_le16(sizeof(struct scan_cancel_tlv)),
+		},
+	};
+
+	if (test_and_clear_bit(MT76_HW_SCANNING, &phy->state)) {
+		struct cfg80211_scan_info info = {
+			.aborted = true,
+		};
+
+		ieee80211_scan_completed(phy->hw, &info);
+	}
+
+	return mt76_mcu_send_msg(phy->dev, MCU_UNI_CMD(SCAN_REQ),
+				 &req, sizeof(req), false);
+}
+EXPORT_SYMBOL_GPL(mt7925_mcu_cancel_hw_scan);
+
+int mt7925_mcu_set_channel_domain(struct mt76_phy *phy)
+{
+	int len, i, n_max_channels, n_2ch = 0, n_5ch = 0, n_6ch = 0;
+	struct {
+		struct {
+			u8 alpha2[4]; /* regulatory_request.alpha2 */
+			u8 bw_2g; /* BW_20_40M		0
+				   * BW_20M		1
+				   * BW_20_40_80M	2
+				   * BW_20_40_80_160M	3
+				   * BW_20_40_80_8080M	4
+				   */
+			u8 bw_5g;
+			u8 bw_6g;
+			u8 pad;
+		} __packed hdr;
+		struct n_chan {
+			__le16 tag;
+			__le16 len;
+			u8 n_2ch;
+			u8 n_5ch;
+			u8 n_6ch;
+			u8 pad;
+		} __packed n_ch;
+	} req = {
+		.hdr = {
+			.bw_2g = 0,
+			.bw_5g = 3, /* BW_20_40_80_160M */
+			.bw_6g = 3,
+		},
+		.n_ch = {
+			.tag = cpu_to_le16(2),
+		},
+	};
+	struct mt76_connac_mcu_chan {
+		__le16 hw_value;
+		__le16 pad;
+		__le32 flags;
+	} __packed channel;
+	struct mt76_dev *dev = phy->dev;
+	struct ieee80211_channel *chan;
+	struct sk_buff *skb;
+
+	n_max_channels = phy->sband_2g.sband.n_channels +
+			 phy->sband_5g.sband.n_channels +
+			 phy->sband_6g.sband.n_channels;
+	len = sizeof(req) + n_max_channels * sizeof(channel);
+
+	skb = mt76_mcu_msg_alloc(dev, NULL, len);
+	if (!skb)
+		return -ENOMEM;
+
+	skb_reserve(skb, sizeof(req));
+
+	for (i = 0; i < phy->sband_2g.sband.n_channels; i++) {
+		chan = &phy->sband_2g.sband.channels[i];
+		if (chan->flags & IEEE80211_CHAN_DISABLED)
+			continue;
+
+		channel.hw_value = cpu_to_le16(chan->hw_value);
+		channel.flags = cpu_to_le32(chan->flags);
+		channel.pad = 0;
+
+		skb_put_data(skb, &channel, sizeof(channel));
+		n_2ch++;
+	}
+	for (i = 0; i < phy->sband_5g.sband.n_channels; i++) {
+		chan = &phy->sband_5g.sband.channels[i];
+		if (chan->flags & IEEE80211_CHAN_DISABLED)
+			continue;
+
+		channel.hw_value = cpu_to_le16(chan->hw_value);
+		channel.flags = cpu_to_le32(chan->flags);
+		channel.pad = 0;
+
+		skb_put_data(skb, &channel, sizeof(channel));
+		n_5ch++;
+	}
+	for (i = 0; i < phy->sband_6g.sband.n_channels; i++) {
+		chan = &phy->sband_6g.sband.channels[i];
+		if (chan->flags & IEEE80211_CHAN_DISABLED)
+			continue;
+
+		channel.hw_value = cpu_to_le16(chan->hw_value);
+		channel.flags = cpu_to_le32(chan->flags);
+		channel.pad = 0;
+
+		skb_put_data(skb, &channel, sizeof(channel));
+		n_6ch++;
+	}
+
+	BUILD_BUG_ON(sizeof(dev->alpha2) > sizeof(req.hdr.alpha2));
+	memcpy(req.hdr.alpha2, dev->alpha2, sizeof(dev->alpha2));
+	req.n_ch.n_2ch = n_2ch;
+	req.n_ch.n_5ch = n_5ch;
+	req.n_ch.n_6ch = n_6ch;
+	len = sizeof(struct n_chan) + (n_2ch + n_5ch + n_6ch) * sizeof(channel);
+	req.n_ch.len = cpu_to_le16(len);
+	memcpy(__skb_push(skb, sizeof(req)), &req, sizeof(req));
+
+	return mt76_mcu_skb_send_msg(dev, skb, MCU_UNI_CMD(SET_DOMAIN_INFO),
+				     false);
+}
+EXPORT_SYMBOL_GPL(mt7925_mcu_set_channel_domain);
+
+static int
+__mt7925_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
+		     enum environment_cap env_cap,
+		     struct mt7925_clc *clc, u8 idx)
+{
+	struct mt7925_clc_segment *seg;
+	struct sk_buff *skb;
+	struct {
+		u8 rsv[4];
+		__le16 tag;
+		__le16 len;
+
+		u8 ver;
+		u8 pad0;
+		__le16 size;
+		u8 idx;
+		u8 env;
+		u8 acpi_conf;
+		u8 pad1;
+		u8 alpha2[2];
+		u8 type[2];
+		u8 rsvd[64];
+	} __packed req = {
+		.tag = cpu_to_le16(0x3),
+		.len = cpu_to_le16(sizeof(req) - 4),
+
+		.idx = idx,
+		.env = env_cap,
+		.acpi_conf = mt792x_acpi_get_flags(&dev->phy),
+	};
+	int ret, valid_cnt = 0;
+	u8 i, *pos;
+
+	if (!clc)
+		return 0;
+
+	pos = clc->data + sizeof(*seg) * clc->nr_seg;
+	for (i = 0; i < clc->nr_country; i++) {
+		struct mt7925_clc_rule *rule = (struct mt7925_clc_rule *)pos;
+
+		pos += sizeof(*rule);
+		if (rule->alpha2[0] != alpha2[0] ||
+		    rule->alpha2[1] != alpha2[1])
+			continue;
+
+		seg = (struct mt7925_clc_segment *)clc->data
+			  + rule->seg_idx - 1;
+
+		memcpy(req.alpha2, rule->alpha2, 2);
+		memcpy(req.type, rule->type, 2);
+
+		req.size = cpu_to_le16(seg->len);
+		skb = __mt76_mcu_msg_alloc(&dev->mt76, &req,
+					   le16_to_cpu(req.size) + sizeof(req),
+					   sizeof(req), GFP_KERNEL);
+		if (!skb)
+			return -ENOMEM;
+		skb_put_data(skb, clc->data + seg->offset, seg->len);
+
+		ret = mt76_mcu_skb_send_msg(&dev->mt76, skb,
+					    MCU_UNI_CMD(SET_POWER_LIMIT),
+					    true);
+		if (ret < 0)
+			return ret;
+		valid_cnt++;
+	}
+
+	if (!valid_cnt)
+		return -ENOENT;
+
+	return 0;
+}
+
+int mt7925_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
+		       enum environment_cap env_cap)
+{
+	struct mt792x_phy *phy = (struct mt792x_phy *)&dev->phy;
+	int i, ret;
+
+	/* submit all clc config */
+	for (i = 0; i < ARRAY_SIZE(phy->clc); i++) {
+		ret = __mt7925_mcu_set_clc(dev, alpha2, env_cap,
+					   phy->clc[i], i);
+
+		/* If no country found, set "00" as default */
+		if (ret == -ENOENT)
+			ret = __mt7925_mcu_set_clc(dev, "00",
+						   ENVIRON_INDOOR,
+						   phy->clc[i], i);
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
+int mt7925_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
+			    int cmd, int *wait_seq)
+{
+	int txd_len, mcu_cmd = FIELD_GET(__MCU_CMD_FIELD_ID, cmd);
+	struct mt76_connac2_mcu_uni_txd *uni_txd;
+	struct mt76_connac2_mcu_txd *mcu_txd;
+	__le32 *txd;
+	u32 val;
+	u8 seq;
+
+	/* TODO: make dynamic based on msg type */
+	mdev->mcu.timeout = 20 * HZ;
+
+	seq = ++mdev->mcu.msg_seq & 0xf;
+	if (!seq)
+		seq = ++mdev->mcu.msg_seq & 0xf;
+
+	if (cmd == MCU_CMD(FW_SCATTER))
+		goto exit;
+
+	txd_len = cmd & __MCU_CMD_FIELD_UNI ? sizeof(*uni_txd) : sizeof(*mcu_txd);
+	txd = (__le32 *)skb_push(skb, txd_len);
+
+	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len) |
+	      FIELD_PREP(MT_TXD0_PKT_FMT, MT_TX_TYPE_CMD) |
+	      FIELD_PREP(MT_TXD0_Q_IDX, MT_TX_MCU_PORT_RX_Q0);
+	txd[0] = cpu_to_le32(val);
+
+	val = FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_CMD);
+	txd[1] = cpu_to_le32(val);
+
+	if (cmd & __MCU_CMD_FIELD_UNI) {
+		uni_txd = (struct mt76_connac2_mcu_uni_txd *)txd;
+		uni_txd->len = cpu_to_le16(skb->len - sizeof(uni_txd->txd));
+		uni_txd->cid = cpu_to_le16(mcu_cmd);
+		uni_txd->s2d_index = MCU_S2D_H2N;
+		uni_txd->pkt_type = MCU_PKT_ID;
+		uni_txd->seq = seq;
+
+		if (cmd & __MCU_CMD_FIELD_QUERY)
+			uni_txd->option = MCU_CMD_UNI_QUERY_ACK;
+		else
+			uni_txd->option = MCU_CMD_UNI_EXT_ACK;
+
+		goto exit;
+	}
+
+	mcu_txd = (struct mt76_connac2_mcu_txd *)txd;
+	mcu_txd->len = cpu_to_le16(skb->len - sizeof(mcu_txd->txd));
+	mcu_txd->pq_id = cpu_to_le16(MCU_PQ_ID(MT_TX_PORT_IDX_MCU,
+					       MT_TX_MCU_PORT_RX_Q0));
+	mcu_txd->pkt_type = MCU_PKT_ID;
+	mcu_txd->seq = seq;
+	mcu_txd->cid = mcu_cmd;
+	mcu_txd->ext_cid = FIELD_GET(__MCU_CMD_FIELD_EXT_ID, cmd);
+
+	if (mcu_txd->ext_cid || (cmd & __MCU_CMD_FIELD_CE)) {
+		if (cmd & __MCU_CMD_FIELD_QUERY)
+			mcu_txd->set_query = MCU_Q_QUERY;
+		else
+			mcu_txd->set_query = MCU_Q_SET;
+		mcu_txd->ext_cid_ack = !!mcu_txd->ext_cid;
+	} else {
+		mcu_txd->set_query = MCU_Q_NA;
+	}
+
+	if (cmd & __MCU_CMD_FIELD_WA)
+		mcu_txd->s2d_index = MCU_S2D_H2C;
+	else
+		mcu_txd->s2d_index = MCU_S2D_H2N;
+
+exit:
+	if (wait_seq)
+		*wait_seq = seq;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt7925_mcu_fill_message);
+
+int mt7925_mcu_set_rts_thresh(struct mt792x_phy *phy, u32 val)
+{
+	struct {
+		u8 band_idx;
+		u8 _rsv[3];
+
+		__le16 tag;
+		__le16 len;
+		__le32 len_thresh;
+		__le32 pkt_thresh;
+	} __packed req = {
+		.band_idx = phy->mt76->band_idx,
+		.tag = cpu_to_le16(UNI_BAND_CONFIG_RTS_THRESHOLD),
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.len_thresh = cpu_to_le32(val),
+		.pkt_thresh = cpu_to_le32(0x2),
+	};
+
+	return mt76_mcu_send_msg(&phy->dev->mt76, MCU_UNI_CMD(BAND_CONFIG),
+				 &req, sizeof(req), true);
+}
+
+int mt7925_mcu_set_radio_en(struct mt792x_phy *phy, bool enable)
+{
+	struct {
+		u8 band_idx;
+		u8 _rsv[3];
+
+		__le16 tag;
+		__le16 len;
+		u8 enable;
+		u8 _rsv2[3];
+	} __packed req = {
+		.band_idx = phy->mt76->band_idx,
+		.tag = cpu_to_le16(UNI_BAND_CONFIG_RADIO_ENABLE),
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.enable = enable,
+	};
+
+	return mt76_mcu_send_msg(&phy->dev->mt76, MCU_UNI_CMD(BAND_CONFIG),
+				 &req, sizeof(req), true);
+}
+
+static void
+mt7925_mcu_build_sku(struct mt76_dev *dev, s8 *sku,
+		     struct mt76_power_limits *limits,
+		     enum nl80211_band band)
+{
+	int i, offset = sizeof(limits->cck);
+
+	memset(sku, 127, MT_CONNAC3_SKU_POWER_LIMIT);
+
+	if (band == NL80211_BAND_2GHZ) {
+		/* cck */
+		memcpy(sku, limits->cck, sizeof(limits->cck));
+	}
+
+	/* ofdm */
+	memcpy(&sku[offset], limits->ofdm, sizeof(limits->ofdm));
+	offset += (sizeof(limits->ofdm) * 5);
+
+	/* ht */
+	for (i = 0; i < 2; i++) {
+		memcpy(&sku[offset], limits->mcs[i], 8);
+		offset += 8;
+	}
+	sku[offset++] = limits->mcs[0][0];
+
+	/* vht */
+	for (i = 0; i < ARRAY_SIZE(limits->mcs); i++) {
+		memcpy(&sku[offset], limits->mcs[i],
+		       ARRAY_SIZE(limits->mcs[i]));
+		offset += 12;
+	}
+
+	/* he */
+	for (i = 0; i < ARRAY_SIZE(limits->ru); i++) {
+		memcpy(&sku[offset], limits->ru[i], ARRAY_SIZE(limits->ru[i]));
+		offset += ARRAY_SIZE(limits->ru[i]);
+	}
+
+	/* eht */
+	for (i = 0; i < ARRAY_SIZE(limits->eht); i++) {
+		memcpy(&sku[offset], limits->eht[i], ARRAY_SIZE(limits->eht[i]));
+		offset += ARRAY_SIZE(limits->eht[i]);
+	}
+}
+
+static int
+mt7925_mcu_rate_txpower_band(struct mt76_phy *phy,
+			     enum nl80211_band band)
+{
+	int tx_power, n_chan, last_ch, err = 0, idx = 0;
+	int i, sku_len, batch_size, batch_len = 3;
+	struct mt76_dev *dev = phy->dev;
+	static const u8 chan_list_2ghz[] = {
+		1, 2,  3,  4,  5,  6,  7,
+		8, 9, 10, 11, 12, 13, 14
+	};
+	static const u8 chan_list_5ghz[] = {
+		 36,  38,  40,  42,  44,  46,  48,
+		 50,  52,  54,  56,  58,  60,  62,
+		 64, 100, 102, 104, 106, 108, 110,
+		112, 114, 116, 118, 120, 122, 124,
+		126, 128, 132, 134, 136, 138, 140,
+		142, 144, 149, 151, 153, 155, 157,
+		159, 161, 165, 167
+	};
+	static const u8 chan_list_6ghz[] = {
+		  1,   3,   5,   7,   9,  11,  13,
+		 15,  17,  19,  21,  23,  25,  27,
+		 29,  33,  35,  37,  39,  41,  43,
+		 45,  47,  49,  51,  53,  55,  57,
+		 59,  61,  65,  67,  69,  71,  73,
+		 75,  77,  79,  81,  83,  85,  87,
+		 89,  91,  93,  97,  99, 101, 103,
+		105, 107, 109, 111, 113, 115, 117,
+		119, 121, 123, 125, 129, 131, 133,
+		135, 137, 139, 141, 143, 145, 147,
+		149, 151, 153, 155, 157, 161, 163,
+		165, 167, 169, 171, 173, 175, 177,
+		179, 181, 183, 185, 187, 189, 193,
+		195, 197, 199, 201, 203, 205, 207,
+		209, 211, 213, 215, 217, 219, 221,
+		225, 227, 229, 233
+	};
+	struct mt76_power_limits *limits;
+	struct mt7925_sku_tlv *sku_tlbv;
+	const u8 *ch_list;
+
+	sku_len = sizeof(*sku_tlbv);
+	tx_power = 2 * phy->hw->conf.power_level;
+	if (!tx_power)
+		tx_power = 127;
+
+	if (band == NL80211_BAND_2GHZ) {
+		n_chan = ARRAY_SIZE(chan_list_2ghz);
+		ch_list = chan_list_2ghz;
+		last_ch = chan_list_2ghz[ARRAY_SIZE(chan_list_2ghz) - 1];
+	} else if (band == NL80211_BAND_6GHZ) {
+		n_chan = ARRAY_SIZE(chan_list_6ghz);
+		ch_list = chan_list_6ghz;
+		last_ch = chan_list_6ghz[ARRAY_SIZE(chan_list_6ghz) - 1];
+	} else {
+		n_chan = ARRAY_SIZE(chan_list_5ghz);
+		ch_list = chan_list_5ghz;
+		last_ch = chan_list_5ghz[ARRAY_SIZE(chan_list_5ghz) - 1];
+	}
+	batch_size = DIV_ROUND_UP(n_chan, batch_len);
+
+	limits = devm_kmalloc(dev->dev, sizeof(*limits), GFP_KERNEL);
+	if (!limits)
+		return -ENOMEM;
+
+	sku_tlbv = devm_kmalloc(dev->dev, sku_len, GFP_KERNEL);
+	if (!sku_tlbv) {
+		devm_kfree(dev->dev, limits);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < batch_size; i++) {
+		struct mt7925_tx_power_limit_tlv *tx_power_tlv;
+		int j, msg_len, num_ch;
+		struct sk_buff *skb;
+
+		num_ch = i == batch_size - 1 ? n_chan % batch_len : batch_len;
+		msg_len = sizeof(*tx_power_tlv) + num_ch * sku_len;
+		skb = mt76_mcu_msg_alloc(dev, NULL, msg_len);
+		if (!skb) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		tx_power_tlv = (struct mt7925_tx_power_limit_tlv *)
+			       skb_put(skb, sizeof(*tx_power_tlv));
+
+		BUILD_BUG_ON(sizeof(dev->alpha2) > sizeof(tx_power_tlv->alpha2));
+		memcpy(tx_power_tlv->alpha2, dev->alpha2, sizeof(dev->alpha2));
+		tx_power_tlv->n_chan = num_ch;
+		tx_power_tlv->tag = cpu_to_le16(0x1);
+		tx_power_tlv->len = cpu_to_le16(sizeof(*tx_power_tlv));
+
+		switch (band) {
+		case NL80211_BAND_2GHZ:
+			tx_power_tlv->band = 1;
+			break;
+		case NL80211_BAND_6GHZ:
+			tx_power_tlv->band = 3;
+			break;
+		default:
+			tx_power_tlv->band = 2;
+			break;
+		}
+
+		for (j = 0; j < num_ch; j++, idx++) {
+			struct ieee80211_channel chan = {
+				.hw_value = ch_list[idx],
+				.band = band,
+			};
+			s8 reg_power, sar_power;
+
+			reg_power = mt76_connac_get_ch_power(phy, &chan,
+							     tx_power);
+			sar_power = mt76_get_sar_power(phy, &chan, reg_power);
+
+			mt76_get_rate_power_limits(phy, &chan, limits,
+						   sar_power);
+
+			tx_power_tlv->last_msg = ch_list[idx] == last_ch;
+			sku_tlbv->channel = ch_list[idx];
+
+			mt7925_mcu_build_sku(dev, sku_tlbv->pwr_limit,
+					     limits, band);
+			skb_put_data(skb, sku_tlbv, sku_len);
+		}
+		err = mt76_mcu_skb_send_msg(dev, skb,
+					    MCU_UNI_CMD(SET_POWER_LIMIT),
+					    true);
+		if (err < 0)
+			goto out;
+	}
+
+out:
+	devm_kfree(dev->dev, sku_tlbv);
+	devm_kfree(dev->dev, limits);
+	return err;
+}
+
+int mt7925_mcu_set_rate_txpower(struct mt76_phy *phy)
+{
+	int err;
+
+	if (phy->cap.has_2ghz) {
+		err = mt7925_mcu_rate_txpower_band(phy,
+						   NL80211_BAND_2GHZ);
+		if (err < 0)
+			return err;
+	}
+
+	if (phy->cap.has_5ghz) {
+		err = mt7925_mcu_rate_txpower_band(phy,
+						   NL80211_BAND_5GHZ);
+		if (err < 0)
+			return err;
+	}
+
+	if (phy->cap.has_6ghz) {
+		err = mt7925_mcu_rate_txpower_band(phy,
+						   NL80211_BAND_6GHZ);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+int mt7925_mcu_set_rxfilter(struct mt792x_dev *dev, u32 fif,
+			    u8 bit_op, u32 bit_map)
+{
+	struct mt792x_phy *phy = &dev->phy;
+	struct {
+		u8 band_idx;
+		u8 rsv1[3];
+
+		__le16 tag;
+		__le16 len;
+		u8 mode;
+		u8 rsv2[3];
+		__le32 fif;
+		__le32 bit_map; /* bit_* for bitmap update */
+		u8 bit_op;
+		u8 pad[51];
+	} __packed req = {
+		.band_idx = phy->mt76->band_idx,
+		.tag = cpu_to_le16(UNI_BAND_CONFIG_SET_MAC80211_RX_FILTER),
+		.len = cpu_to_le16(sizeof(req) - 4),
+
+		.mode = fif ? 0 : 1,
+		.fif = cpu_to_le32(fif),
+		.bit_map = cpu_to_le32(bit_map),
+		.bit_op = bit_op,
+	};
+
+	return mt76_mcu_send_msg(&phy->dev->mt76, MCU_UNI_CMD(BAND_CONFIG),
+				 &req, sizeof(req), true);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c.rej b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c.rej
new file mode 100644
index 000000000000..3cdfc4e9a45f
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c.rej
@@ -0,0 +1,35 @@
+--- drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
++++ drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+@@ -2176,13 +2178,26 @@ void mt7925_mcu_bss_rlm_tlv(struct sk_buff *skb, struct mt76_phy *phy,
+ 
+ 	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_RLM, sizeof(*req));
+ 	req = (struct bss_rlm_tlv *)tlv;
+-	req->control_channel = chandef->chan->hw_value,
+-	req->center_chan = ieee80211_frequency_to_channel(freq1),
+-	req->center_chan2 = ieee80211_frequency_to_channel(freq2),
+-	req->tx_streams = hweight8(phy->antenna_mask),
++	req->control_channel = chandef->chan->hw_value;
++	req->center_chan = ieee80211_frequency_to_channel(freq1);
++	req->center_chan2 = 0;
++	req->tx_streams = hweight8(phy->antenna_mask);
+ 	req->ht_op_info = 4, /* set HT 40M allowed */
+-	req->rx_streams = hweight8(phy->antenna_mask),
+-	req->band = band;
++	req->rx_streams = hweight8(phy->antenna_mask);
++	req->center_chan2 = 0;
++	req->sco = 0;
++
++	switch (band) {
++	case NL80211_BAND_2GHZ:
++		req->band = 1;
++		break;
++	case NL80211_BAND_5GHZ:
++		req->band = 2;
++		break;
++	case NL80211_BAND_6GHZ:
++		req->band = 3;
++		break;
++	}
+ 
+ 	switch (chandef->width) {
+ 	case NL80211_CHAN_WIDTH_40:
-- 
2.25.1


