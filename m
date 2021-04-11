Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075DF35B6AC
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 21:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbhDKTEK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 15:04:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236231AbhDKTEJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 15:04:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4AB97600D3;
        Sun, 11 Apr 2021 19:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618167833;
        bh=VnS8PskpOdpL6yiZdsnTvzuUNJIiiUr4Rksj/b5Ms18=;
        h=From:To:Cc:Subject:Date:From;
        b=R+9BzT5um2SFeNjAPNZwHZpU+z7mNw6EzUIjVxFAxuyW2kBj89Q3JUD+u5KZofFnh
         Qv2iVsDyneTTTERQVERUQ1UWtiYWRap/o7E3WkbaTZBHHWtSDYWqfT/2m6CGPSu5xZ
         Sc3QJq72GLp3XLB5CVxEGz9Ith3tVXvwTT/WroJx1fZEa9cnmKxwpqDQY5DZZocfAA
         QAt/uXDOvrhBeWGmQ7FQPRPr/JUnKS15GHbdEphf2EitZlNLx4jWsV7ysx5YOCh1Lg
         zg2JQHXId66nWoEKAL7KhgCLqMmh7epZrF2LOvKmGQVqgwSWoXCXEgOESikjEhVbWh
         lxsvIennKeJkw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH v3] mt76: mt7921: introduce MCU_EVENT_LP_INFO event parsing
Date:   Sun, 11 Apr 2021 21:03:45 +0200
Message-Id: <402fc12903312f45de28b1fa5b6430807f0d6fa4.1618167620.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Report trace event related to MCU_EVENT_LP_INFO that is sent by the mcu
when it is ready to enter in deep sleep state

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v2:
- rebase on top of mt76 master branch

Changes since v1:
- rebase on top of mt76 master branch
---
 .../wireless/mediatek/mt76/mt7921/Makefile    |  4 +-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 19 +++++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   |  1 +
 .../mediatek/mt76/mt7921/mt7921_trace.h       | 51 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/trace.c | 12 +++++
 5 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mt7921_trace.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/trace.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
index 09d1446ad933..e531666f9fb4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
@@ -2,4 +2,6 @@
 
 obj-$(CONFIG_MT7921E) += mt7921e.o
 
-mt7921e-y := pci.o mac.o mcu.o dma.o eeprom.o main.o init.o debugfs.o
+CFLAGS_trace.o := -I$(src)
+
+mt7921e-y := pci.o mac.o mcu.o dma.o eeprom.o main.o init.o debugfs.o trace.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index b233b12860ef..7d45e8795e15 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -4,6 +4,7 @@
 #include <linux/firmware.h>
 #include <linux/fs.h>
 #include "mt7921.h"
+#include "mt7921_trace.h"
 #include "mcu.h"
 #include "mac.h"
 
@@ -498,6 +499,20 @@ mt7921_mcu_debug_msg_event(struct mt7921_dev *dev, struct sk_buff *skb)
 	}
 }
 
+static void
+mt7921_mcu_low_power_event(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt7921_mcu_lp_event {
+		u8 state;
+		u8 reserved[3];
+	} __packed * event;
+
+	skb_pull(skb, sizeof(struct mt7921_mcu_rxd));
+	event = (struct mt7921_mcu_lp_event *)skb->data;
+
+	trace_lp_event(dev, event->state);
+}
+
 static void
 mt7921_mcu_rx_unsolicited_event(struct mt7921_dev *dev, struct sk_buff *skb)
 {
@@ -521,6 +536,9 @@ mt7921_mcu_rx_unsolicited_event(struct mt7921_dev *dev, struct sk_buff *skb)
 		mt76_connac_mcu_coredump_event(&dev->mt76, skb,
 					       &dev->coredump);
 		return;
+	case MCU_EVENT_LP_INFO:
+		mt7921_mcu_low_power_event(dev, skb);
+		break;
 	default:
 		break;
 	}
@@ -543,6 +561,7 @@ void mt7921_mcu_rx_event(struct mt7921_dev *dev, struct sk_buff *skb)
 	    rxd->eid == MCU_EVENT_SCAN_DONE ||
 	    rxd->eid == MCU_EVENT_DBG_MSG ||
 	    rxd->eid == MCU_EVENT_COREDUMP ||
+	    rxd->eid == MCU_EVENT_LP_INFO ||
 	    !rxd->seq)
 		mt7921_mcu_rx_unsolicited_event(dev, skb);
 	else
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
index af8b42983a00..13e125f32283 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -79,6 +79,7 @@ struct mt7921_uni_txd {
 /* event table */
 enum {
 	MCU_EVENT_REG_ACCESS = 0x05,
+	MCU_EVENT_LP_INFO = 0x07,
 	MCU_EVENT_SCAN_DONE = 0x0d,
 	MCU_EVENT_BSS_ABSENCE  = 0x11,
 	MCU_EVENT_BSS_BEACON_LOSS = 0x13,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921_trace.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921_trace.h
new file mode 100644
index 000000000000..9bc4db67f352
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921_trace.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (C) 2021 Lorenzo Bianconi <lorenzo@kernel.org>
+ */
+
+#if !defined(__MT7921_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define __MT7921_TRACE_H
+
+#include <linux/tracepoint.h>
+#include "mt7921.h"
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM mt7921
+
+#define MAXNAME		32
+#define DEV_ENTRY	__array(char, wiphy_name, 32)
+#define DEV_ASSIGN	strlcpy(__entry->wiphy_name,	\
+				wiphy_name(mt76_hw(dev)->wiphy), MAXNAME)
+#define DEV_PR_FMT	"%s"
+#define DEV_PR_ARG	__entry->wiphy_name
+#define LP_STATE_PR_ARG	__entry->lp_state ? "lp ready" : "lp not ready"
+
+TRACE_EVENT(lp_event,
+	TP_PROTO(struct mt7921_dev *dev, u8 lp_state),
+
+	TP_ARGS(dev, lp_state),
+
+	TP_STRUCT__entry(
+		DEV_ENTRY
+		__field(u8, lp_state)
+	),
+
+	TP_fast_assign(
+		DEV_ASSIGN;
+		__entry->lp_state = lp_state;
+	),
+
+	TP_printk(
+		DEV_PR_FMT " %s",
+		DEV_PR_ARG, LP_STATE_PR_ARG
+	)
+);
+
+#endif
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE mt7921_trace
+
+#include <trace/define_trace.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/trace.c b/drivers/net/wireless/mediatek/mt76/mt7921/trace.c
new file mode 100644
index 000000000000..4dc3c7b89ebd
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/trace.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (C) 2021 Lorenzo Bianconi <lorenzo@kernel.org>
+ */
+
+#include <linux/module.h>
+
+#ifndef __CHECKER__
+#define CREATE_TRACE_POINTS
+#include "mt7921_trace.h"
+
+#endif
-- 
2.30.2

