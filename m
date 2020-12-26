Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736ED2E2EB3
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Dec 2020 18:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgLZRKE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Dec 2020 12:10:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:58602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgLZRKE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Dec 2020 12:10:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67D3E2184D;
        Sat, 26 Dec 2020 17:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609002563;
        bh=tUAB4o7mupT3n5Llg9Fo3tV1kw9opG0xQ9cQiFy91MA=;
        h=From:To:Cc:Subject:Date:From;
        b=Oe1Tml6dpsqU/h+EhHItQoqxNJ4JmmPYO71CgoRkCsYRpIkR2H2KiRxDnv5K2wQa3
         kFeJDfhiyutBeUWrMVp/x2FjYcqhTsNQYc777gESxW/3kCmEf62MiIiEE1YAy59IqR
         bBdIrqENeUhg0Jspng74XL9kzoNZz0M1C5yPJ13A+/hnS+FHku0RL/IN6pSe9fzf/V
         4g6TnOz4JInlVB754DwgqbRDTmU+VfQjsf8bNMH0+g9xKfZJg5VpkNTvOwPpAjxpPK
         V8FDHfnm8140Dl8CcyN4Z6blC+bqgfml3i2q7KEFAPC7VG1WdjN1lPuAL+XC0zvJyv
         f1W4q2ie3PXBw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, ryder.lee@mediatek.com,
        lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7915: simplify mt7915_mcu_send_message routine
Date:   Sat, 26 Dec 2020 18:09:04 +0100
Message-Id: <c8e4db2a31d4293212d3562a413236b85e7a7b03.1609002263.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Simplify mt7915_mcu_send_message routine removing unused code

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 5fdd1a6d32ee..80d8d471ee1c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -255,10 +255,10 @@ mt7915_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 {
 	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
 	struct mt7915_mcu_txd *mcu_txd;
-	u8 seq, pkt_fmt, qidx;
 	enum mt76_txq_id txq;
 	__le32 *txd;
 	u32 val;
+	u8 seq;
 
 	/* TODO: make dynamic based on msg type */
 	mdev->mcu.timeout = 20 * HZ;
@@ -273,22 +273,16 @@ mt7915_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	}
 
 	mcu_txd = (struct mt7915_mcu_txd *)skb_push(skb, sizeof(*mcu_txd));
-
-	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state)) {
+	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state))
 		txq = MT_MCUQ_WA;
-		qidx = MT_TX_MCU_PORT_RX_Q0;
-		pkt_fmt = MT_TX_TYPE_CMD;
-	} else {
+	else
 		txq = MT_MCUQ_WM;
-		qidx = MT_TX_MCU_PORT_RX_Q0;
-		pkt_fmt = MT_TX_TYPE_CMD;
-	}
 
 	txd = mcu_txd->txd;
 
 	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len) |
-	      FIELD_PREP(MT_TXD0_PKT_FMT, pkt_fmt) |
-	      FIELD_PREP(MT_TXD0_Q_IDX, qidx);
+	      FIELD_PREP(MT_TXD0_PKT_FMT, MT_TX_TYPE_CMD) |
+	      FIELD_PREP(MT_TXD0_Q_IDX, MT_TX_MCU_PORT_RX_Q0);
 	txd[0] = cpu_to_le32(val);
 
 	val = MT_TXD1_LONG_FORMAT |
@@ -296,7 +290,8 @@ mt7915_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	txd[1] = cpu_to_le32(val);
 
 	mcu_txd->len = cpu_to_le16(skb->len - sizeof(mcu_txd->txd));
-	mcu_txd->pq_id = cpu_to_le16(MCU_PQ_ID(MT_TX_PORT_IDX_MCU, qidx));
+	mcu_txd->pq_id = cpu_to_le16(MCU_PQ_ID(MT_TX_PORT_IDX_MCU,
+					       MT_TX_MCU_PORT_RX_Q0));
 	mcu_txd->pkt_type = MCU_PKT_ID;
 	mcu_txd->seq = seq;
 
-- 
2.29.2

