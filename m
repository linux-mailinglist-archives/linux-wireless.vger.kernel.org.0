Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F5D475F7D
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Dec 2021 18:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbhLORiw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Dec 2021 12:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbhLORiw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Dec 2021 12:38:52 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C0DC06173F
        for <linux-wireless@vger.kernel.org>; Wed, 15 Dec 2021 09:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=No23zpZ5I2BhKviUpveWFlAOy4WRUk+ss6gHkGcTI1c=; b=tWvLCz2qDYUyoO7a1atydIPBwn
        CsBncTJE6GcJfG1bQDiVjyEKCyUVGvnEInuK2sUSnU79USiTWQw7asEXcevaZY0uPTleR2LycMpkY
        1qNsHKqN1NDzlA9Ff8GKEtpR9EAFzgSuJ4ihgNCILcTeQqze2KZEhu+41x4ySTtbrCBM=;
Received: from p54ae911a.dip0.t-ipconnect.de ([84.174.145.26] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mxYEr-0000He-Lv
        for linux-wireless@vger.kernel.org; Wed, 15 Dec 2021 18:38:49 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/3] mt76: mt7915: process txfree and txstatus without allocating skbs
Date:   Wed, 15 Dec 2021 18:38:38 +0100
Message-Id: <20211215173839.20853-2-nbd@nbd.name>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211215173839.20853-1-nbd@nbd.name>
References: <20211215173839.20853-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Reduces pressure on the memory allocator

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 36 +++++++++++++++----
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  1 +
 .../net/wireless/mediatek/mt76/mt7915/pci.c   |  1 +
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index a1556fe2f421..f25b36ff31ff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1373,15 +1373,16 @@ mt7915_txwi_free(struct mt7915_dev *dev, struct mt76_txwi_cache *t,
 }
 
 static void
-mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
+mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 {
-	struct mt7915_tx_free *free = (struct mt7915_tx_free *)skb->data;
+	struct mt7915_tx_free *free = (struct mt7915_tx_free *)data;
 	struct mt76_dev *mdev = &dev->mt76;
 	struct mt76_phy *mphy_ext = mdev->phy2;
 	struct mt76_txwi_cache *txwi;
 	struct ieee80211_sta *sta = NULL;
 	LIST_HEAD(free_list);
-	struct sk_buff *tmp;
+	struct sk_buff *skb, *tmp;
+	void *end = data + len;
 	u8 i, count;
 	bool wake = false;
 
@@ -1399,6 +1400,9 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 	 * Should avoid accessing WTBL to get Tx airtime, and use it instead.
 	 */
 	count = FIELD_GET(MT_TX_FREE_MSDU_CNT, le16_to_cpu(free->ctrl));
+	if (WARN_ON_ONCE((void *)&free->info[count] > end))
+		return;
+
 	for (i = 0; i < count; i++) {
 		u32 msdu, info = le32_to_cpu(free->info[i]);
 
@@ -1441,8 +1445,6 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 
 	mt76_worker_schedule(&dev->mt76.tx_worker);
 
-	napi_consume_skb(skb, 1);
-
 	list_for_each_entry_safe(skb, tmp, &free_list, list) {
 		skb_list_del_init(skb);
 		napi_consume_skb(skb, 1);
@@ -1617,6 +1619,27 @@ static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
 	rcu_read_unlock();
 }
 
+bool mt7915_rx_check(struct mt76_dev *mdev, void *data, int len)
+{
+	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
+	__le32 *rxd = (__le32 *)data;
+	__le32 *end = (__le32 *)&rxd[len / 4];
+	enum rx_pkt_type type;
+
+	type = FIELD_GET(MT_RXD0_PKT_TYPE, le32_to_cpu(rxd[0]));
+	switch (type) {
+	case PKT_TYPE_TXRX_NOTIFY:
+		mt7915_mac_tx_free(dev, data, len);
+		return false;
+	case PKT_TYPE_TXS:
+		for (rxd += 2; rxd + 8 <= end; rxd += 8)
+		    mt7915_mac_add_txs(dev, rxd);
+		return false;
+	default:
+		return true;
+	}
+}
+
 void mt7915_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb)
 {
@@ -1629,7 +1652,8 @@ void mt7915_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 
 	switch (type) {
 	case PKT_TYPE_TXRX_NOTIFY:
-		mt7915_mac_tx_free(dev, skb);
+		mt7915_mac_tx_free(dev, skb->data, skb->len);
+		napi_consume_skb(skb, 1);
 		break;
 	case PKT_TYPE_RX_EVENT:
 		mt7915_mcu_rx_event(dev, skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index c6c846d1900b..10e43307e486 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -519,6 +519,7 @@ void mt7915_tx_token_put(struct mt7915_dev *dev);
 int mt7915_init_tx_queues(struct mt7915_phy *phy, int idx, int n_desc);
 void mt7915_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb);
+bool mt7915_rx_check(struct mt76_dev *mdev, void *data, int len);
 void mt7915_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps);
 void mt7915_stats_work(struct work_struct *work);
 int mt76_dfs_start_rdd(struct mt7915_dev *dev, bool force);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
index 0af4cdb897b7..8130ea43971f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -230,6 +230,7 @@ static int mt7915_pci_probe(struct pci_dev *pdev,
 		.tx_prepare_skb = mt7915_tx_prepare_skb,
 		.tx_complete_skb = mt7915_tx_complete_skb,
 		.rx_skb = mt7915_queue_rx_skb,
+		.rx_check = mt7915_rx_check,
 		.rx_poll_complete = mt7915_rx_poll_complete,
 		.sta_ps = mt7915_sta_ps,
 		.sta_add = mt7915_mac_sta_add,
-- 
2.34.1

