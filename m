Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE9B4808E4
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Dec 2021 13:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhL1MBh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Dec 2021 07:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhL1MBh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Dec 2021 07:01:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D888BC061574
        for <linux-wireless@vger.kernel.org>; Tue, 28 Dec 2021 04:01:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16E93611A1
        for <linux-wireless@vger.kernel.org>; Tue, 28 Dec 2021 12:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393EEC36AE7;
        Tue, 28 Dec 2021 12:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640692895;
        bh=qP6DlQiVsbFBpK/rosQggNGRw8fy+OUQ6bLfJw4zZTw=;
        h=From:To:Cc:Subject:Date:From;
        b=cJT8doYKoLlycwTsfsDNxA0od+fN6rffD4J3wz8PwlaaXalp/+4iCxYKF37PcelK/
         t6lZzQxR583k4+947rHAo4lFtJfIQRC5Njx/4X+lt2dpCAR9bEjiX/JmBYpghj/f9N
         Yh09gW1aufXZSiORfRTdVKQ7ZyHvnDl7TeLA/ddPUPYXLFm+EZ8uLl7JtycmbJ21xZ
         U7KufLyue17ffFihEfHhj9j2ZEOCTps5+kldQbq3TsWHVQvWN6cibwYzjiPWigqtzk
         /lMt96jTXPpDTkvU8SqmnB/BtYSpQH8eHV+wM1tSbaUYETdc/u4W9yRbcOJAt8dPUk
         XCQYFNBBKie2Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com, deren.wu@mediatek.com
Subject: [PATCH] mt76: mt7921e: process txfree and txstatus without allocating skbs
Date:   Tue, 28 Dec 2021 13:01:19 +0100
Message-Id: <20ad4a5dcca713de579de51f0369d731fcc12e23.1640692286.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to mt7915 driver, process txfree and txstatus without allocating
skbs in order to reduce pressure on the memory allocator

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  1 +
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 +
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  1 +
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   | 36 +++++++++++++++----
 4 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index ec10f95a4649..675100310135 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1195,6 +1195,7 @@ void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data)
 out:
 	rcu_read_unlock();
 }
+EXPORT_SYMBOL_GPL(mt7921_mac_add_txs);
 
 void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index fd9331783931..8b674e042568 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -434,6 +434,7 @@ int mt7921_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
 int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			      struct sk_buff *skb, int seq);
 
+bool mt7921e_rx_check(struct mt76_dev *mdev, void *data, int len);
 void mt7921e_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			  struct sk_buff *skb);
 int mt7921e_driver_own(struct mt7921_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 9dae2f5972bf..1ae0d5826ca7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -134,6 +134,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 		.token_size = MT7921_TOKEN_SIZE,
 		.tx_prepare_skb = mt7921e_tx_prepare_skb,
 		.tx_complete_skb = mt7921e_tx_complete_skb,
+		.rx_check = mt7921e_rx_check,
 		.rx_skb = mt7921e_queue_rx_skb,
 		.rx_poll_complete = mt7921_rx_poll_complete,
 		.sta_ps = mt7921_sta_ps,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index 85286cc9add1..291d80f17b25 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -148,14 +148,15 @@ mt7921_txwi_free(struct mt7921_dev *dev, struct mt76_txwi_cache *t,
 }
 
 static void
-mt7921_mac_tx_free(struct mt7921_dev *dev, struct sk_buff *skb)
+mt7921e_mac_tx_free(struct mt7921_dev *dev, void *data, int len)
 {
-	struct mt7921_tx_free *free = (struct mt7921_tx_free *)skb->data;
+	struct mt7921_tx_free *free = (struct mt7921_tx_free *)data;
 	struct mt76_dev *mdev = &dev->mt76;
 	struct mt76_txwi_cache *txwi;
 	struct ieee80211_sta *sta = NULL;
+	struct sk_buff *skb, *tmp;
+	void *end = data + len;
 	LIST_HEAD(free_list);
-	struct sk_buff *tmp;
 	bool wake = false;
 	u8 i, count;
 
@@ -168,6 +169,9 @@ mt7921_mac_tx_free(struct mt7921_dev *dev, struct sk_buff *skb)
 	 * Should avoid accessing WTBL to get Tx airtime, and use it instead.
 	 */
 	count = FIELD_GET(MT_TX_FREE_MSDU_CNT, le16_to_cpu(free->ctrl));
+	if (WARN_ON_ONCE((void *)&free->info[count] > end))
+		return;
+
 	for (i = 0; i < count; i++) {
 		u32 msdu, info = le32_to_cpu(free->info[i]);
 		u8 stat;
@@ -208,8 +212,6 @@ mt7921_mac_tx_free(struct mt7921_dev *dev, struct sk_buff *skb)
 	if (wake)
 		mt76_set_tx_blocked(&dev->mt76, false);
 
-	napi_consume_skb(skb, 1);
-
 	list_for_each_entry_safe(skb, tmp, &free_list, list) {
 		skb_list_del_init(skb);
 		napi_consume_skb(skb, 1);
@@ -222,6 +224,27 @@ mt7921_mac_tx_free(struct mt7921_dev *dev, struct sk_buff *skb)
 	mt76_worker_schedule(&dev->mt76.tx_worker);
 }
 
+bool mt7921e_rx_check(struct mt76_dev *mdev, void *data, int len)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	__le32 *rxd = (__le32 *)data;
+	__le32 *end = (__le32 *)&rxd[len / 4];
+	enum rx_pkt_type type;
+
+	type = FIELD_GET(MT_RXD0_PKT_TYPE, le32_to_cpu(rxd[0]));
+	switch (type) {
+	case PKT_TYPE_TXRX_NOTIFY:
+		mt7921e_mac_tx_free(dev, data, len);
+		return false;
+	case PKT_TYPE_TXS:
+		for (rxd += 2; rxd + 8 <= end; rxd += 8)
+			mt7921_mac_add_txs(dev, rxd);
+		return false;
+	default:
+		return true;
+	}
+}
+
 void mt7921e_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			  struct sk_buff *skb)
 {
@@ -233,7 +256,8 @@ void mt7921e_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 
 	switch (type) {
 	case PKT_TYPE_TXRX_NOTIFY:
-		mt7921_mac_tx_free(dev, skb);
+		mt7921e_mac_tx_free(dev, skb->data, skb->len);
+		napi_consume_skb(skb, 1);
 		break;
 	default:
 		mt7921_queue_rx_skb(mdev, q, skb);
-- 
2.33.1

