Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDC65E0E5
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 12:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfD2Kyh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 06:54:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbfD2Kyg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 06:54:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 88AFC5945B;
        Mon, 29 Apr 2019 10:54:36 +0000 (UTC)
Received: from localhost (unknown [10.43.2.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26F7069733;
        Mon, 29 Apr 2019 10:54:35 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Tomislav=20Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Felix Fietkau <nbd@nbd.name>, Mathias Kresin <dev@kresin.me>
Subject: [RFC/RFT 2/7] rt2800: add helpers for reading dma done index
Date:   Mon, 29 Apr 2019 12:54:25 +0200
Message-Id: <1556535270-3551-3-git-send-email-sgruszka@redhat.com>
In-Reply-To: <1556535270-3551-1-git-send-email-sgruszka@redhat.com>
References: <1556535270-3551-1-git-send-email-sgruszka@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 29 Apr 2019 10:54:36 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For mmio we do not properlly trace dma done Q_INDEX_DMA_DONE index
for TX queues. That would require implementing INT_SOURCE_CSR_*_DMA_DONE
interrupts, what is rather not worth to do due to adding extra
CPU load (small but still somewhat not necessary otherwise).

We can just read TX DMA done indexes from registers directly. What
will be used by watchdog.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.h  |  8 +++++++
 drivers/net/wireless/ralink/rt2x00/rt2800mmio.c | 31 +++++++++++++++++++++++++
 drivers/net/wireless/ralink/rt2x00/rt2800mmio.h |  2 ++
 drivers/net/wireless/ralink/rt2x00/rt2800pci.c  |  1 +
 drivers/net/wireless/ralink/rt2x00/rt2800soc.c  |  1 +
 drivers/net/wireless/ralink/rt2x00/rt2800usb.c  |  9 +++++++
 6 files changed, 52 insertions(+)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.h b/drivers/net/wireless/ralink/rt2x00/rt2800lib.h
index 0dff2c7b3010..b3e6e15d34e5 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.h
@@ -76,6 +76,7 @@ struct rt2800_ops {
 				  const u8 *data, const size_t len);
 	int (*drv_init_registers)(struct rt2x00_dev *rt2x00dev);
 	__le32 *(*drv_get_txwi)(struct queue_entry *entry);
+	unsigned int (*drv_get_dma_done)(struct data_queue *queue);
 };
 
 static inline u32 rt2800_register_read(struct rt2x00_dev *rt2x00dev,
@@ -177,6 +178,13 @@ static inline __le32 *rt2800_drv_get_txwi(struct queue_entry *entry)
 	return rt2800ops->drv_get_txwi(entry);
 }
 
+static inline unsigned int rt2800_drv_get_dma_done(struct data_queue *queue)
+{
+	const struct rt2800_ops *rt2800ops = queue->rt2x00dev->ops->drv;
+
+	return rt2800ops->drv_get_dma_done(queue);
+}
+
 void rt2800_mcu_request(struct rt2x00_dev *rt2x00dev,
 			const u8 command, const u8 token,
 			const u8 arg0, const u8 arg1);
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800mmio.c b/drivers/net/wireless/ralink/rt2x00/rt2800mmio.c
index ddb88cfeace2..27d2d97c2317 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800mmio.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800mmio.c
@@ -36,6 +36,37 @@
 #include "rt2800lib.h"
 #include "rt2800mmio.h"
 
+unsigned int rt2800mmio_get_dma_done(struct data_queue *queue)
+{
+	struct rt2x00_dev *rt2x00dev = queue->rt2x00dev;
+	struct queue_entry *entry;
+	int idx, qid;
+
+	switch (queue->qid) {
+	case QID_AC_VO:
+	case QID_AC_VI:
+	case QID_AC_BE:
+	case QID_AC_BK:
+		qid = queue->qid;
+		idx = rt2x00mmio_register_read(rt2x00dev, TX_DTX_IDX(qid));
+		break;
+	case QID_MGMT:
+		idx = rt2x00mmio_register_read(rt2x00dev, TX_DTX_IDX(5));
+		break;
+	case QID_RX:
+		entry = rt2x00queue_get_entry(queue, Q_INDEX_DMA_DONE);
+		idx = entry->entry_idx;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		idx = 0;
+		break;
+	}
+
+	return idx;
+}
+EXPORT_SYMBOL_GPL(rt2800mmio_get_dma_done);
+
 /*
  * TX descriptor initialization
  */
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800mmio.h b/drivers/net/wireless/ralink/rt2x00/rt2800mmio.h
index 3a513273f414..fa90e3c29707 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800mmio.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800mmio.h
@@ -126,6 +126,8 @@
 #define RXD_W3_PLCP_SIGNAL		FIELD32(0x00020000)
 #define RXD_W3_PLCP_RSSI		FIELD32(0x00040000)
 
+unsigned int rt2800mmio_get_dma_done(struct data_queue *queue);
+
 /* TX descriptor initialization */
 __le32 *rt2800mmio_get_txwi(struct queue_entry *entry);
 void rt2800mmio_write_tx_desc(struct queue_entry *entry,
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800pci.c b/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
index 0291441ac548..f22260dc2eb4 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
@@ -337,6 +337,7 @@ static const struct rt2800_ops rt2800pci_rt2800_ops = {
 	.drv_write_firmware	= rt2800pci_write_firmware,
 	.drv_init_registers	= rt2800mmio_init_registers,
 	.drv_get_txwi		= rt2800mmio_get_txwi,
+	.drv_get_dma_done	= rt2800mmio_get_dma_done,
 };
 
 static const struct rt2x00lib_ops rt2800pci_rt2x00_ops = {
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
index 9c74be82e2be..5c4a745a7489 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
@@ -183,6 +183,7 @@ static const struct rt2800_ops rt2800soc_rt2800_ops = {
 	.drv_write_firmware	= rt2800soc_write_firmware,
 	.drv_init_registers	= rt2800mmio_init_registers,
 	.drv_get_txwi		= rt2800mmio_get_txwi,
+	.drv_get_dma_done	= rt2800mmio_get_dma_done,
 };
 
 static const struct rt2x00lib_ops rt2800soc_rt2x00_ops = {
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800usb.c b/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
index 19eabf16147b..1ec9b1eebedb 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
@@ -406,6 +406,14 @@ static int rt2800usb_set_device_state(struct rt2x00_dev *rt2x00dev,
 	return retval;
 }
 
+static unsigned int rt2800usb_get_dma_done(struct data_queue *queue)
+{
+	struct queue_entry *entry;
+
+	entry = rt2x00queue_get_entry(queue, Q_INDEX_DMA_DONE);
+	return entry->entry_idx;
+}
+
 /*
  * TX descriptor initialization
  */
@@ -688,6 +696,7 @@ static const struct rt2800_ops rt2800usb_rt2800_ops = {
 	.drv_write_firmware	= rt2800usb_write_firmware,
 	.drv_init_registers	= rt2800usb_init_registers,
 	.drv_get_txwi		= rt2800usb_get_txwi,
+	.drv_get_dma_done	= rt2800usb_get_dma_done,
 };
 
 static const struct rt2x00lib_ops rt2800usb_rt2x00_ops = {
-- 
2.7.5

