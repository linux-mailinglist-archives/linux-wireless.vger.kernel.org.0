Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFCD12C22C
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2019 11:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfL2KDH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Dec 2019 05:03:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:47658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfL2KDH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Dec 2019 05:03:07 -0500
Received: from localhost.localdomain.homenet.telecomitalia.it (host151-113-dynamic.27-79-r.retail.telecomitalia.it [79.27.113.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39E77207FF;
        Sun, 29 Dec 2019 10:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577613786;
        bh=pkQvyn6+N9HZPoT8+LI/fpWNBOKuQHfWIoOcsojrZbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I45sJ8IVHgWOXgUbb8um5cDKYTdPNXJTjfAf8vBh3ozVBFRR/FOEfWyYyBA8PNELc
         2SP4idOdG7Pu4Hi1A2CVGHAoQQMMXFGDbU/zqFeOJlHnBwJ63hrLwqmILgntmNx3Gj
         k/BY6sV2LQnftFXDheE0OBsxrwXWelZca/7TdB+4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 2/4] mt76: move mac_txdone tracepoint in mt76 module
Date:   Sun, 29 Dec 2019 11:03:06 +0100
Message-Id: <978713df1cbbcef5d5a9a7c6978719f16bd4df41.1577613505.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1577613505.git.lorenzo@kernel.org>
References: <cover.1577613505.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mac_txdone tracepoint in common code in order to
be reused by mt7603 and mt7615 drivers

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  3 ++
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  3 ++
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  |  3 +-
 .../wireless/mediatek/mt76/mt76x02_trace.h    | 23 -------------
 drivers/net/wireless/mediatek/mt76/trace.c    |  1 +
 drivers/net/wireless/mediatek/mt76/trace.h    | 33 +++++++++++++++++--
 6 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 2a384fd0f088..8f5ca9283f7d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -4,6 +4,7 @@
 #include <linux/timekeeping.h>
 #include "mt7603.h"
 #include "mac.h"
+#include "../trace.h"
 
 #define MT_PSE_PAGE_SIZE	128
 
@@ -1193,6 +1194,8 @@ mt7603_mac_add_txs_skb(struct mt7603_dev *dev, struct mt7603_sta *sta, int pid,
 	if (pid < MT_PACKET_ID_FIRST)
 		return false;
 
+	trace_mac_txdone(mdev, sta->wcid.idx, pid);
+
 	mt76_tx_status_lock(mdev, &list);
 	skb = mt76_tx_status_skb_get(mdev, &sta->wcid, pid, &list);
 	if (skb) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 885a57df76eb..3819a330804c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -10,6 +10,7 @@
 #include <linux/etherdevice.h>
 #include <linux/timekeeping.h>
 #include "mt7615.h"
+#include "../trace.h"
 #include "../dma.h"
 #include "mac.h"
 
@@ -1218,6 +1219,8 @@ static bool mt7615_mac_add_txs_skb(struct mt7615_dev *dev,
 	if (pid < MT_PACKET_ID_FIRST)
 		return false;
 
+	trace_mac_txdone(mdev, sta->wcid.idx, pid);
+
 	mt76_tx_status_lock(mdev, &list);
 	skb = mt76_tx_status_skb_get(mdev, &sta->wcid, pid, &list);
 	if (skb) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 6c988d779a3e..8b072277ea10 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -6,6 +6,7 @@
 
 #include "mt76x02.h"
 #include "mt76x02_trace.h"
+#include "trace.h"
 
 void mt76x02_mac_reset_counters(struct mt76x02_dev *dev)
 {
@@ -910,7 +911,7 @@ void mt76x02_tx_complete_skb(struct mt76_dev *mdev, enum mt76_txq_id qid,
 
 	txwi_ptr = mt76_get_txwi_ptr(mdev, e->txwi);
 	txwi = (struct mt76x02_txwi *)txwi_ptr;
-	trace_mac_txdone_add(dev, txwi->wcid, txwi->pktid);
+	trace_mac_txdone(mdev, txwi->wcid, txwi->pktid);
 
 	mt76_tx_complete_skb(mdev, e->skb);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_trace.h b/drivers/net/wireless/mediatek/mt76/mt76x02_trace.h
index eea9afe154df..6a98092e996b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_trace.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_trace.h
@@ -20,7 +20,6 @@
 #define DEV_PR_ARG	__entry->wiphy_name
 
 #define TXID_ENTRY	__field(u8, wcid) __field(u8, pktid)
-#define TXID_ASSIGN	__entry->wcid = wcid; __entry->pktid = pktid
 #define TXID_PR_FMT	" [%d:%d]"
 #define TXID_PR_ARG	__entry->wcid, __entry->pktid
 
@@ -36,28 +35,6 @@ DECLARE_EVENT_CLASS(dev_evt,
 	TP_printk(DEV_PR_FMT, DEV_PR_ARG)
 );
 
-DECLARE_EVENT_CLASS(dev_txid_evt,
-	TP_PROTO(struct mt76x02_dev *dev, u8 wcid, u8 pktid),
-	TP_ARGS(dev, wcid, pktid),
-	TP_STRUCT__entry(
-		DEV_ENTRY
-		TXID_ENTRY
-	),
-	TP_fast_assign(
-		DEV_ASSIGN;
-		TXID_ASSIGN;
-	),
-	TP_printk(
-		DEV_PR_FMT TXID_PR_FMT,
-		DEV_PR_ARG, TXID_PR_ARG
-	)
-);
-
-DEFINE_EVENT(dev_txid_evt, mac_txdone_add,
-	TP_PROTO(struct mt76x02_dev *dev, u8 wcid, u8 pktid),
-	TP_ARGS(dev, wcid, pktid)
-);
-
 DEFINE_EVENT(dev_evt, mac_txstat_poll,
 	TP_PROTO(struct mt76x02_dev *dev),
 	TP_ARGS(dev)
diff --git a/drivers/net/wireless/mediatek/mt76/trace.c b/drivers/net/wireless/mediatek/mt76/trace.c
index 3c63f3b8a499..f199fcd2a63d 100644
--- a/drivers/net/wireless/mediatek/mt76/trace.c
+++ b/drivers/net/wireless/mediatek/mt76/trace.c
@@ -9,6 +9,7 @@
 #define CREATE_TRACE_POINTS
 #include "trace.h"
 
+EXPORT_TRACEPOINT_SYMBOL_GPL(mac_txdone);
 EXPORT_TRACEPOINT_SYMBOL_GPL(dev_irq);
 
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/trace.h b/drivers/net/wireless/mediatek/mt76/trace.h
index 41706a874afa..c3d0ef8e2890 100644
--- a/drivers/net/wireless/mediatek/mt76/trace.h
+++ b/drivers/net/wireless/mediatek/mt76/trace.h
@@ -14,7 +14,7 @@
 
 #define MAXNAME		32
 #define DEV_ENTRY	__array(char, wiphy_name, 32)
-#define DEV_ASSIGN	strlcpy(__entry->wiphy_name,	\
+#define DEVICE_ASSIGN	strlcpy(__entry->wiphy_name,	\
 				wiphy_name(dev->hw->wiphy), MAXNAME)
 #define DEV_PR_FMT	"%s"
 #define DEV_PR_ARG	__entry->wiphy_name
@@ -24,6 +24,11 @@
 #define REG_PR_FMT	" %04x=%08x"
 #define REG_PR_ARG	__entry->reg, __entry->val
 
+#define TXID_ENTRY	__field(u8, wcid) __field(u8, pktid)
+#define TXID_ASSIGN	__entry->wcid = wcid; __entry->pktid = pktid
+#define TXID_PR_FMT	" [%d:%d]"
+#define TXID_PR_ARG	__entry->wcid, __entry->pktid
+
 DECLARE_EVENT_CLASS(dev_reg_evt,
 	TP_PROTO(struct mt76_dev *dev, u32 reg, u32 val),
 	TP_ARGS(dev, reg, val),
@@ -32,7 +37,7 @@ DECLARE_EVENT_CLASS(dev_reg_evt,
 		REG_ENTRY
 	),
 	TP_fast_assign(
-		DEV_ASSIGN;
+		DEVICE_ASSIGN;
 		REG_ASSIGN;
 	),
 	TP_printk(
@@ -63,7 +68,7 @@ TRACE_EVENT(dev_irq,
 	),
 
 	TP_fast_assign(
-		DEV_ASSIGN;
+		DEVICE_ASSIGN;
 		__entry->val = val;
 		__entry->mask = mask;
 	),
@@ -74,6 +79,28 @@ TRACE_EVENT(dev_irq,
 	)
 );
 
+DECLARE_EVENT_CLASS(dev_txid_evt,
+	TP_PROTO(struct mt76_dev *dev, u8 wcid, u8 pktid),
+	TP_ARGS(dev, wcid, pktid),
+	TP_STRUCT__entry(
+		DEV_ENTRY
+		TXID_ENTRY
+	),
+	TP_fast_assign(
+		DEVICE_ASSIGN;
+		TXID_ASSIGN;
+	),
+	TP_printk(
+		DEV_PR_FMT TXID_PR_FMT,
+		DEV_PR_ARG, TXID_PR_ARG
+	)
+);
+
+DEFINE_EVENT(dev_txid_evt, mac_txdone,
+	TP_PROTO(struct mt76_dev *dev, u8 wcid, u8 pktid),
+	TP_ARGS(dev, wcid, pktid)
+);
+
 #endif
 
 #undef TRACE_INCLUDE_PATH
-- 
2.21.0

