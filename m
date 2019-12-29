Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A06F112C22D
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2019 11:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfL2KDM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Dec 2019 05:03:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:47696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfL2KDM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Dec 2019 05:03:12 -0500
Received: from localhost.localdomain.homenet.telecomitalia.it (host151-113-dynamic.27-79-r.retail.telecomitalia.it [79.27.113.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 571A9207E0;
        Sun, 29 Dec 2019 10:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577613791;
        bh=dW6tRX8ChHIaLCZHBiJAGMxF44VkHpyMEz3S2HRRinM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M7JsMyLO/0fByoI6LqNvE2WhHt3T12WWQFmxZCZo3OW2wWDLAsYIbbnxvwYgZVMtT
         K0h0R74DEE/cU3NxemEBfqNTnJ0/euVi2Mx0AUeCi0oZE/C7y1nKtlcNFqaauEesUv
         yzrcBYIiN4oYAi9HOAnZIFedUbfVQJ4w9ouavi6A=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 3/4] mt76: mt7615: add tracing support
Date:   Sun, 29 Dec 2019 11:03:07 +0100
Message-Id: <041a78b35173c57e0d27b9cb263181e3b2245c33.1577613505.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1577613505.git.lorenzo@kernel.org>
References: <cover.1577613505.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce token tracing support in mt7615_mac_tx_free routine

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7615/Makefile    |  4 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  7 ++-
 .../mediatek/mt76/mt7615/mt7615_trace.h       | 56 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/trace.c | 12 ++++
 4 files changed, 77 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/mt7615_trace.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/trace.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Makefile b/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
index 5aaac69849d6..dcd6b0e7ce84 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
@@ -2,5 +2,7 @@
 
 obj-$(CONFIG_MT7615E) += mt7615e.o
 
+CFLAGS_trace.o := -I$(src)
+
 mt7615e-y := pci.o init.o dma.o eeprom.o main.o mcu.o mac.o \
-	     debugfs.o
+	     debugfs.o trace.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 3819a330804c..c958137465c9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -12,6 +12,7 @@
 #include "mt7615.h"
 #include "../trace.h"
 #include "../dma.h"
+#include "mt7615_trace.h"
 #include "mac.h"
 
 #define to_rssi(field, rxv)		((FIELD_GET(field, rxv) - 220) / 2)
@@ -1300,13 +1301,17 @@ void mt7615_mac_tx_free(struct mt7615_dev *dev, struct sk_buff *skb)
 
 	count = FIELD_GET(MT_TX_FREE_MSDU_ID_CNT, le16_to_cpu(free->ctrl));
 	for (i = 0; i < count; i++) {
+		u16 token = le16_to_cpu(free->token[i]);
+
 		spin_lock_bh(&dev->token_lock);
-		txwi = idr_remove(&dev->token, le16_to_cpu(free->token[i]));
+		txwi = idr_remove(&dev->token, token);
 		spin_unlock_bh(&dev->token_lock);
 
 		if (!txwi)
 			continue;
 
+		trace_mac_tx_free(dev, token);
+
 		mt7615_txp_skb_unmap(mdev, txwi);
 		if (txwi->skb) {
 			mt76_tx_complete_skb(mdev, txwi->skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615_trace.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615_trace.h
new file mode 100644
index 000000000000..d3eb49d83b98
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615_trace.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (C) 2019 Lorenzo Bianconi <lorenzo@kernel.org>
+ */
+
+#if !defined(__MT7615_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define __MT7615_TRACE_H
+
+#include <linux/tracepoint.h>
+#include "mt7615.h"
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM mt7615
+
+#define MAXNAME		32
+#define DEV_ENTRY	__array(char, wiphy_name, 32)
+#define DEV_ASSIGN	strlcpy(__entry->wiphy_name,	\
+				wiphy_name(mt76_hw(dev)->wiphy), MAXNAME)
+#define DEV_PR_FMT	"%s"
+#define DEV_PR_ARG	__entry->wiphy_name
+
+#define TOKEN_ENTRY	__field(u16, token)
+#define TOKEN_ASSIGN	__entry->token = token
+#define TOKEN_PR_FMT	" %d"
+#define TOKEN_PR_ARG	__entry->token
+
+DECLARE_EVENT_CLASS(dev_token,
+	TP_PROTO(struct mt7615_dev *dev, u16 token),
+	TP_ARGS(dev, token),
+	TP_STRUCT__entry(
+		DEV_ENTRY
+		TOKEN_ENTRY
+	),
+	TP_fast_assign(
+		DEV_ASSIGN;
+		TOKEN_ASSIGN;
+	),
+	TP_printk(
+		DEV_PR_FMT TOKEN_PR_FMT,
+		DEV_PR_ARG, TOKEN_PR_ARG
+	)
+);
+
+DEFINE_EVENT(dev_token, mac_tx_free,
+	TP_PROTO(struct mt7615_dev *dev, u16 token),
+	TP_ARGS(dev, token)
+);
+
+#endif
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE mt7615_trace
+
+#include <trace/define_trace.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/trace.c b/drivers/net/wireless/mediatek/mt76/mt7615/trace.c
new file mode 100644
index 000000000000..6c02d5aff68f
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/trace.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (C) 2019 Lorenzo Bianconi <lorenzo@kernel.org>
+ */
+
+#include <linux/module.h>
+
+#ifndef __CHECKER__
+#define CREATE_TRACE_POINTS
+#include "mt7615_trace.h"
+
+#endif
-- 
2.21.0

