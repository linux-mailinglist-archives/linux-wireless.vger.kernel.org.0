Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86A4212C22B
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2019 11:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfL2KDD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Dec 2019 05:03:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:47548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfL2KDD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Dec 2019 05:03:03 -0500
Received: from localhost.localdomain.homenet.telecomitalia.it (host151-113-dynamic.27-79-r.retail.telecomitalia.it [79.27.113.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09788207E0;
        Sun, 29 Dec 2019 10:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577613782;
        bh=nFbtIoTveyFOCweB3nbodjSrb7GHXFZ0a1vD5c9CTQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2jnIiwqx6OuT5H829vN2YHD/NWIwG9YDn8s4rAXgr96Co3TL68FzrA3veE6kWa2NB
         zYT+WLX4/JMKpa1UDihhVRyqzg/Ietn0yK4dv/FPETNTGFFqvxtF3tecy5WNvUYx7y
         p9UqJ3FQBwTs9+IfyREq86nhGvYgb/nR1GngnmxQ=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 1/4] mt76: move dev_irq tracepoint in mt76 module
Date:   Sun, 29 Dec 2019 11:03:05 +0100
Message-Id: <678ec101ddc8a0c7744af4296d71724e14ecb308.1577613505.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1577613505.git.lorenzo@kernel.org>
References: <cover.1577613505.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move dev_irq tracepoint in common code in order to be reused by mt7603
and mt7615 drivers

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7603/core.c  |  3 +++
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |  3 +++
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c |  4 ++--
 .../wireless/mediatek/mt76/mt76x02_trace.h    | 23 -------------------
 drivers/net/wireless/mediatek/mt76/trace.c    |  2 ++
 drivers/net/wireless/mediatek/mt76/trace.h    | 23 +++++++++++++++++++
 6 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/core.c b/drivers/net/wireless/mediatek/mt76/mt7603/core.c
index 693a91be070a..60a996b63c0c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/core.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: ISC
 
 #include "mt7603.h"
+#include "../trace.h"
 
 void mt7603_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q)
 {
@@ -20,6 +21,8 @@ irqreturn_t mt7603_irq_handler(int irq, void *dev_instance)
 	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
 		return IRQ_NONE;
 
+	trace_dev_irq(&dev->mt76, intr, dev->mt76.mmio.irqmask);
+
 	intr &= dev->mt76.mmio.irqmask;
 
 	if (intr & MT_INT_MAC_IRQ3) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index 7e3556c3b6eb..828f11087b08 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -11,6 +11,7 @@
 
 #include "mt7615.h"
 #include "mac.h"
+#include "../trace.h"
 
 static const struct pci_device_id mt7615_pci_device_table[] = {
 	{ PCI_DEVICE(0x14c3, 0x7615) },
@@ -46,6 +47,8 @@ static irqreturn_t mt7615_irq_handler(int irq, void *dev_instance)
 	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
 		return IRQ_NONE;
 
+	trace_dev_irq(&dev->mt76, intr, dev->mt76.mmio.irqmask);
+
 	intr &= dev->mt76.mmio.irqmask;
 
 	if (intr & MT_INT_TX_DONE_ALL) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 094a4228b591..93d56d7ce5db 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -9,7 +9,7 @@
 
 #include "mt76x02.h"
 #include "mt76x02_mcu.h"
-#include "mt76x02_trace.h"
+#include "trace.h"
 
 static void mt76x02_pre_tbtt_tasklet(unsigned long arg)
 {
@@ -271,7 +271,7 @@ irqreturn_t mt76x02_irq_handler(int irq, void *dev_instance)
 	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
 		return IRQ_NONE;
 
-	trace_dev_irq(dev, intr, dev->mt76.mmio.irqmask);
+	trace_dev_irq(&dev->mt76, intr, dev->mt76.mmio.irqmask);
 
 	intr &= dev->mt76.mmio.irqmask;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_trace.h b/drivers/net/wireless/mediatek/mt76/mt76x02_trace.h
index 61ecaf0fe065..eea9afe154df 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_trace.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_trace.h
@@ -100,29 +100,6 @@ TRACE_EVENT(mac_txstat_fetch,
 	)
 );
 
-TRACE_EVENT(dev_irq,
-	TP_PROTO(struct mt76x02_dev *dev, u32 val, u32 mask),
-
-	TP_ARGS(dev, val, mask),
-
-	TP_STRUCT__entry(
-		DEV_ENTRY
-		__field(u32, val)
-		__field(u32, mask)
-	),
-
-	TP_fast_assign(
-		DEV_ASSIGN;
-		__entry->val = val;
-		__entry->mask = mask;
-	),
-
-	TP_printk(
-		DEV_PR_FMT " %08x & %08x",
-		DEV_PR_ARG, __entry->val, __entry->mask
-	)
-);
-
 #endif
 
 #undef TRACE_INCLUDE_PATH
diff --git a/drivers/net/wireless/mediatek/mt76/trace.c b/drivers/net/wireless/mediatek/mt76/trace.c
index ed3df3c8b4b3..3c63f3b8a499 100644
--- a/drivers/net/wireless/mediatek/mt76/trace.c
+++ b/drivers/net/wireless/mediatek/mt76/trace.c
@@ -9,4 +9,6 @@
 #define CREATE_TRACE_POINTS
 #include "trace.h"
 
+EXPORT_TRACEPOINT_SYMBOL_GPL(dev_irq);
+
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/trace.h b/drivers/net/wireless/mediatek/mt76/trace.h
index 0b3e635da868..41706a874afa 100644
--- a/drivers/net/wireless/mediatek/mt76/trace.h
+++ b/drivers/net/wireless/mediatek/mt76/trace.h
@@ -51,6 +51,29 @@ DEFINE_EVENT(dev_reg_evt, reg_wr,
 	TP_ARGS(dev, reg, val)
 );
 
+TRACE_EVENT(dev_irq,
+	TP_PROTO(struct mt76_dev *dev, u32 val, u32 mask),
+
+	TP_ARGS(dev, val, mask),
+
+	TP_STRUCT__entry(
+		DEV_ENTRY
+		__field(u32, val)
+		__field(u32, mask)
+	),
+
+	TP_fast_assign(
+		DEV_ASSIGN;
+		__entry->val = val;
+		__entry->mask = mask;
+	),
+
+	TP_printk(
+		DEV_PR_FMT " %08x & %08x",
+		DEV_PR_ARG, __entry->val, __entry->mask
+	)
+);
+
 #endif
 
 #undef TRACE_INCLUDE_PATH
-- 
2.21.0

