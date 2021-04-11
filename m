Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE3835B383
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 13:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbhDKLRC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 07:17:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235095AbhDKLRA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 07:17:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E5B460FE6;
        Sun, 11 Apr 2021 11:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618139804;
        bh=tkf12RfKAqIBV4S4W4SMHgIhXewzpDDmMsjI0+YDGNY=;
        h=From:To:Cc:Subject:Date:From;
        b=Z59JfyA4pX2aY47+wZNWmih8iW54ZsGR1oJpisNdAOWAG+k6dp/7oOL4zAvcArHY8
         K46UbG3pFJA+LuAJl1hOJq2qgYeqbE0Hx9q8RR8gIxMiD8gNsqG7IauSArPh8qdal9
         AEBHw8wqwH1BrQmPqdfamUI+t/4lFniwwfQZrsJlgBinDH5JmHcCGnJlOv2kqUgwX3
         cU2X/69slG9zbscItQE/LjV0DMAg6HLokw4e5vXpK5MynHa2dxUbbKuezOyg4pdOr7
         wsGuCTBswxCAi48QKEQroe1QKxmr7rH8mhaeL++NmfLynBNczMKzSuS0TwREW+eSdD
         MCtuKoLZaSqzQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH v2] mt76: mt7921: introduce MCU_EVENT_LP_INFO event parsing
Date:   Sun, 11 Apr 2021 13:16:33 +0200
Message-Id: <46515032b1f9447854a52a4378a5d2d233aff1e5.1618139664.git.lorenzo@kernel.org>
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
Changes since v1:
- rebase on top of mt76 master branch
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
 .../wireless/mediatek/mt76/mt7921/Makefile    |  4 +-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 19 +++++++
 .../mediatek/mt76/mt7921/mt7921_trace.h       | 51 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/trace.c | 12 +++++
 5 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mt7921_trace.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/trace.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 54e6c15f276b..13b1ed545f94 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -575,6 +575,7 @@ enum {
 	MCU_EVENT_ACCESS_REG = 0x02,
 	MCU_EVENT_MT_PATCH_SEM = 0x04,
 	MCU_EVENT_REG_ACCESS = 0x05,
+	MCU_EVENT_LP_INFO = 0x07,
 	MCU_EVENT_SCAN_DONE = 0x0d,
 	MCU_EVENT_ROC = 0x10,
 	MCU_EVENT_BSS_ABSENCE  = 0x11,
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
index ca8f7430e7aa..868cd854e379 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -4,6 +4,7 @@
 #include <linux/firmware.h>
 #include <linux/fs.h>
 #include "mt7921.h"
+#include "mt7921_trace.h"
 #include "mcu.h"
 #include "mac.h"
 
@@ -509,6 +510,20 @@ mt7921_mcu_debug_msg_event(struct mt7921_dev *dev, struct sk_buff *skb)
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
@@ -535,6 +550,9 @@ mt7921_mcu_rx_unsolicited_event(struct mt7921_dev *dev, struct sk_buff *skb)
 		mt76_connac_mcu_coredump_event(&dev->mt76, skb,
 					       &dev->coredump);
 		return;
+	case MCU_EVENT_LP_INFO:
+		mt7921_mcu_low_power_event(dev, skb);
+		break;
 	default:
 		break;
 	}
@@ -557,6 +575,7 @@ void mt7921_mcu_rx_event(struct mt7921_dev *dev, struct sk_buff *skb)
 	    rxd->eid == MCU_EVENT_SCAN_DONE ||
 	    rxd->eid == MCU_EVENT_DBG_MSG ||
 	    rxd->eid == MCU_EVENT_COREDUMP ||
+	    rxd->eid == MCU_EVENT_LP_INFO ||
 	    rxd->eid == MCU_EVENT_ROC ||
 	    !rxd->seq)
 		mt7921_mcu_rx_unsolicited_event(dev, skb);
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

