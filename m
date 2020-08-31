Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4E225792C
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 14:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgHaM0X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 08:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbgHaM0L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 08:26:11 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1782CC061755
        for <linux-wireless@vger.kernel.org>; Mon, 31 Aug 2020 05:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=7jcmTkwALF10lx0z4Ucgh8nL45+JquzTXt2xC0VyyKE=; b=ZjIqh2uhWitwUZEVeuD7V4p9lb
        2di05F4tZlPlXzDT27Skr9yMTHufI1fUlnxOJxZwJI1qLPKpbhA1GVY3o1MAhYwD0LHUJY/GTvumE
        ObQdGVPHkCBob1jeZzEsM8mNts2wK4VLYjKPjqik92xtRr5LWhKV9B5HHhx0bsn9pKjs=;
Received: from p4ff13fcb.dip0.t-ipconnect.de ([79.241.63.203] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kCiss-0000Ok-MF
        for linux-wireless@vger.kernel.org; Mon, 31 Aug 2020 14:26:02 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 7/9] mt76: remove struct mt76_sw_queue
Date:   Mon, 31 Aug 2020 14:25:56 +0200
Message-Id: <20200831122558.1388-7-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200831122558.1388-1-nbd@nbd.name>
References: <20200831122558.1388-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

All members except for the struct mt76_queue pointer have been removed

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/debugfs.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/dma.c      |  7 ++---
 drivers/net/wireless/mediatek/mt76/mac80211.c |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  8 ++----
 .../wireless/mediatek/mt76/mt7603/beacon.c    |  8 +++---
 .../net/wireless/mediatek/mt76/mt7603/dma.c   | 16 +++++------
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  6 ++--
 .../net/wireless/mediatek/mt76/mt7603/main.c  |  2 +-
 .../wireless/mediatek/mt76/mt7615/debugfs.c   |  8 +++---
 .../net/wireless/mediatek/mt76/mt7615/dma.c   | 27 +++++++-----------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 +-
 .../wireless/mediatek/mt76/mt7615/sdio_mcu.c  |  2 +-
 .../wireless/mediatek/mt76/mt7615/sdio_txrx.c |  4 +--
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c | 18 ++++++------
 .../wireless/mediatek/mt76/mt76x02_usb_core.c |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  2 +-
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  8 +++---
 .../net/wireless/mediatek/mt76/mt7915/dma.c   | 21 +++++---------
 drivers/net/wireless/mediatek/mt76/sdio.c     |  9 +++---
 drivers/net/wireless/mediatek/mt76/testmode.c |  2 +-
 drivers/net/wireless/mediatek/mt76/tx.c       | 28 +++++++++----------
 drivers/net/wireless/mediatek/mt76/usb.c      | 16 +++++------
 22 files changed, 86 insertions(+), 114 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/debugfs.c b/drivers/net/wireless/mediatek/mt76/debugfs.c
index 4a06d10e15ac..52f583cb1418 100644
--- a/drivers/net/wireless/mediatek/mt76/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
@@ -31,7 +31,7 @@ int mt76_queues_read(struct seq_file *s, void *data)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(dev->q_tx); i++) {
-		struct mt76_queue *q = dev->q_tx[i].q;
+		struct mt76_queue *q = dev->q_tx[i];
 
 		if (!q)
 			continue;
diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 0d47d29e5003..240f04b10daf 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -150,8 +150,7 @@ mt76_dma_kick_queue(struct mt76_dev *dev, struct mt76_queue *q)
 static void
 mt76_dma_tx_cleanup(struct mt76_dev *dev, enum mt76_txq_id qid, bool flush)
 {
-	struct mt76_sw_queue *sq = &dev->q_tx[qid];
-	struct mt76_queue *q = sq->q;
+	struct mt76_queue *q = dev->q_tx[qid];
 	struct mt76_queue_entry entry;
 	bool wake = false;
 	int last;
@@ -249,7 +248,7 @@ static int
 mt76_dma_tx_queue_skb_raw(struct mt76_dev *dev, enum mt76_txq_id qid,
 			  struct sk_buff *skb, u32 tx_info)
 {
-	struct mt76_queue *q = dev->q_tx[qid].q;
+	struct mt76_queue *q = dev->q_tx[qid];
 	struct mt76_queue_buf buf;
 	dma_addr_t addr;
 
@@ -281,7 +280,7 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, enum mt76_txq_id qid,
 		      struct sk_buff *skb, struct mt76_wcid *wcid,
 		      struct ieee80211_sta *sta)
 {
-	struct mt76_queue *q = dev->q_tx[qid].q;
+	struct mt76_queue *q = dev->q_tx[qid];
 	struct mt76_tx_info tx_info = {
 		.skb = skb,
 	};
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 8b41558c7855..7014846fd854 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -543,7 +543,7 @@ bool mt76_has_tx_pending(struct mt76_phy *phy)
 	offset = __MT_TXQ_MAX * (phy != &dev->phy);
 
 	for (i = 0; i < __MT_TXQ_MAX; i++) {
-		q = dev->q_tx[offset + i].q;
+		q = dev->q_tx[offset + i];
 		if (q && q->queued)
 			return true;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 37f33f4d1280..3600b0e84aeb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -139,10 +139,6 @@ struct mt76_queue {
 	struct page_frag_cache rx_page;
 };
 
-struct mt76_sw_queue {
-	struct mt76_queue *q;
-};
-
 struct mt76_mcu_ops {
 	u32 headroom;
 	u32 tailroom;
@@ -229,7 +225,7 @@ struct mt76_wcid {
 };
 
 struct mt76_txq {
-	struct mt76_sw_queue *swq;
+	struct mt76_queue *q;
 	struct mt76_wcid *wcid;
 
 	struct sk_buff_head retry_q;
@@ -604,7 +600,7 @@ struct mt76_dev {
 	struct sk_buff_head rx_skb[__MT_RXQ_MAX];
 
 	struct list_head txwi_cache;
-	struct mt76_sw_queue q_tx[2 * __MT_TXQ_MAX];
+	struct mt76_queue *q_tx[2 * __MT_TXQ_MAX];
 	struct mt76_queue q_rx[__MT_RXQ_MAX];
 	const struct mt76_queue_ops *queue_ops;
 	int tx_dma_idx[4];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
index 7a41cdf1c4ae..d728c5e43783 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
@@ -29,7 +29,7 @@ mt7603_update_beacon_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	mt76_wr(dev, MT_DMA_FQCR0, MT_DMA_FQCR0_BUSY |
 		FIELD_PREP(MT_DMA_FQCR0_TARGET_WCID, mvif->sta.wcid.idx) |
 		FIELD_PREP(MT_DMA_FQCR0_TARGET_QID,
-			   dev->mt76.q_tx[MT_TXQ_CAB].q->hw_idx) |
+			   dev->mt76.q_tx[MT_TXQ_CAB]->hw_idx) |
 		FIELD_PREP(MT_DMA_FQCR0_DEST_PORT_ID, 3) |
 		FIELD_PREP(MT_DMA_FQCR0_DEST_QUEUE_ID, 8));
 
@@ -78,7 +78,7 @@ void mt7603_pre_tbtt_tasklet(unsigned long arg)
 	data.dev = dev;
 	__skb_queue_head_init(&data.q);
 
-	q = dev->mt76.q_tx[MT_TXQ_BEACON].q;
+	q = dev->mt76.q_tx[MT_TXQ_BEACON];
 	spin_lock_bh(&q->lock);
 	ieee80211_iterate_active_interfaces_atomic(mt76_hw(dev),
 		IEEE80211_IFACE_ITER_RESUME_ALL,
@@ -95,7 +95,7 @@ void mt7603_pre_tbtt_tasklet(unsigned long arg)
 	if (dev->mt76.csa_complete)
 		goto out;
 
-	q = dev->mt76.q_tx[MT_TXQ_CAB].q;
+	q = dev->mt76.q_tx[MT_TXQ_CAB];
 	do {
 		nframes = skb_queue_len(&data.q);
 		ieee80211_iterate_active_interfaces_atomic(mt76_hw(dev),
@@ -136,7 +136,7 @@ void mt7603_pre_tbtt_tasklet(unsigned long arg)
 
 out:
 	mt76_queue_tx_cleanup(dev, MT_TXQ_BEACON, false);
-	if (dev->mt76.q_tx[MT_TXQ_BEACON].q->queued >
+	if (dev->mt76.q_tx[MT_TXQ_BEACON]->queued >
 	    hweight8(dev->mt76.beacon_mask))
 		dev->beacon_check++;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index fd54062f0517..4ab35d2f8cef 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -5,8 +5,7 @@
 #include "../dma.h"
 
 static int
-mt7603_init_tx_queue(struct mt7603_dev *dev, struct mt76_sw_queue *q,
-		     int idx, int n_desc)
+mt7603_init_tx_queue(struct mt7603_dev *dev, int qid, int idx, int n_desc)
 {
 	struct mt76_queue *hwq;
 	int err;
@@ -19,7 +18,7 @@ mt7603_init_tx_queue(struct mt7603_dev *dev, struct mt76_sw_queue *q,
 	if (err < 0)
 		return err;
 
-	q->q = hwq;
+	dev->mt76.q_tx[qid] = hwq;
 
 	mt7603_irq_enable(dev, MT_INT_TX_DONE(idx));
 
@@ -192,29 +191,28 @@ int mt7603_dma_init(struct mt7603_dev *dev)
 	mt7603_pse_client_reset(dev);
 
 	for (i = 0; i < ARRAY_SIZE(wmm_queue_map); i++) {
-		ret = mt7603_init_tx_queue(dev, &dev->mt76.q_tx[i],
-					   wmm_queue_map[i],
+		ret = mt7603_init_tx_queue(dev, i, wmm_queue_map[i],
 					   MT_TX_RING_SIZE);
 		if (ret)
 			return ret;
 	}
 
-	ret = mt7603_init_tx_queue(dev, &dev->mt76.q_tx[MT_TXQ_PSD],
+	ret = mt7603_init_tx_queue(dev, MT_TXQ_PSD,
 				   MT_TX_HW_QUEUE_MGMT, MT_TX_RING_SIZE);
 	if (ret)
 		return ret;
 
-	ret = mt7603_init_tx_queue(dev, &dev->mt76.q_tx[MT_TXQ_MCU],
+	ret = mt7603_init_tx_queue(dev, MT_TXQ_MCU,
 				   MT_TX_HW_QUEUE_MCU, MT_MCU_RING_SIZE);
 	if (ret)
 		return ret;
 
-	ret = mt7603_init_tx_queue(dev, &dev->mt76.q_tx[MT_TXQ_BEACON],
+	ret = mt7603_init_tx_queue(dev, MT_TXQ_BEACON,
 				   MT_TX_HW_QUEUE_BCN, MT_MCU_RING_SIZE);
 	if (ret)
 		return ret;
 
-	ret = mt7603_init_tx_queue(dev, &dev->mt76.q_tx[MT_TXQ_CAB],
+	ret = mt7603_init_tx_queue(dev, MT_TXQ_CAB,
 				   MT_TX_HW_QUEUE_BMC, MT_MCU_RING_SIZE);
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 15fb31fe9cf8..91a4f7036fea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -445,7 +445,7 @@ void mt7603_mac_sta_poll(struct mt7603_dev *dev)
 
 		sta = container_of((void *)msta, struct ieee80211_sta, drv_priv);
 		for (i = 0; i < 4; i++) {
-			struct mt76_queue *q = dev->mt76.q_tx[i].q;
+			struct mt76_queue *q = dev->mt76.q_tx[i];
 			u8 qidx = q->hw_idx;
 			u8 tid = ac_to_tid[i];
 			u32 txtime = airtime[qidx];
@@ -896,7 +896,7 @@ mt7603_mac_write_txwi(struct mt7603_dev *dev, __le32 *txwi,
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_bar *bar = (struct ieee80211_bar *)skb->data;
 	struct ieee80211_vif *vif = info->control.vif;
-	struct mt76_queue *q = dev->mt76.q_tx[qid].q;
+	struct mt76_queue *q = dev->mt76.q_tx[qid];
 	struct mt7603_vif *mvif;
 	int wlan_idx;
 	int hdr_len = ieee80211_get_hdrlen_from_skb(skb);
@@ -1514,7 +1514,7 @@ static bool mt7603_tx_hang(struct mt7603_dev *dev)
 	int i;
 
 	for (i = 0; i < 4; i++) {
-		q = dev->mt76.q_tx[i].q;
+		q = dev->mt76.q_tx[i];
 
 		if (!q->queued)
 			continue;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 447f2c63ef38..f9ffa8825a79 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -514,7 +514,7 @@ mt7603_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif, u16 queue,
 	u16 cw_max = (1 << 10) - 1;
 	u32 val;
 
-	queue = dev->mt76.q_tx[queue].q->hw_idx;
+	queue = dev->mt76.q_tx[queue]->hw_idx;
 
 	if (params->cw_min)
 		cw_min = params->cw_min;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index 937cb71bed64..27c3216d9810 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -339,15 +339,15 @@ mt7615_queues_read(struct seq_file *s, void *data)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(queue_map); i++) {
-		struct mt76_sw_queue *q = &dev->mt76.q_tx[queue_map[i].id];
+		struct mt76_queue *q = dev->mt76.q_tx[queue_map[i].id];
 
-		if (!q->q)
+		if (!q)
 			continue;
 
 		seq_printf(s,
 			   "%s:	queued=%d head=%d tail=%d\n",
-			   queue_map[i].queue, q->q->queued, q->q->head,
-			   q->q->tail);
+			   queue_map[i].queue, q->queued, q->head,
+			   q->tail);
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index 5f0469b56a1a..242638f96aa0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -12,8 +12,7 @@
 #include "mac.h"
 
 static int
-mt7615_init_tx_queue(struct mt7615_dev *dev, struct mt76_sw_queue *q,
-		      int idx, int n_desc)
+mt7615_init_tx_queue(struct mt7615_dev *dev, int qid, int idx, int n_desc)
 {
 	struct mt76_queue *hwq;
 	int err;
@@ -26,7 +25,7 @@ mt7615_init_tx_queue(struct mt7615_dev *dev, struct mt76_sw_queue *q,
 	if (err < 0)
 		return err;
 
-	q->q = hwq;
+	dev->mt76.q_tx[qid] = hwq;
 
 	return 0;
 }
@@ -44,19 +43,18 @@ mt7622_init_tx_queues_multi(struct mt7615_dev *dev)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(wmm_queue_map); i++) {
-		ret = mt7615_init_tx_queue(dev, &dev->mt76.q_tx[i],
-					   wmm_queue_map[i],
+		ret = mt7615_init_tx_queue(dev, i, wmm_queue_map[i],
 					   MT7615_TX_RING_SIZE / 2);
 		if (ret)
 			return ret;
 	}
 
-	ret = mt7615_init_tx_queue(dev, &dev->mt76.q_tx[MT_TXQ_PSD],
+	ret = mt7615_init_tx_queue(dev, MT_TXQ_PSD,
 				   MT7622_TXQ_MGMT, MT7615_TX_MGMT_RING_SIZE);
 	if (ret)
 		return ret;
 
-	ret = mt7615_init_tx_queue(dev, &dev->mt76.q_tx[MT_TXQ_MCU],
+	ret = mt7615_init_tx_queue(dev, MT_TXQ_MCU,
 				   MT7622_TXQ_MCU, MT7615_TX_MCU_RING_SIZE);
 	return ret;
 }
@@ -64,10 +62,9 @@ mt7622_init_tx_queues_multi(struct mt7615_dev *dev)
 static int
 mt7615_init_tx_queues(struct mt7615_dev *dev)
 {
-	struct mt76_sw_queue *q;
 	int ret, i;
 
-	ret = mt7615_init_tx_queue(dev, &dev->mt76.q_tx[MT_TXQ_FWDL],
+	ret = mt7615_init_tx_queue(dev, MT_TXQ_FWDL,
 				   MT7615_TXQ_FWDL,
 				   MT7615_TX_FWDL_RING_SIZE);
 	if (ret)
@@ -76,18 +73,14 @@ mt7615_init_tx_queues(struct mt7615_dev *dev)
 	if (!is_mt7615(&dev->mt76))
 		return mt7622_init_tx_queues_multi(dev);
 
-	ret = mt7615_init_tx_queue(dev, &dev->mt76.q_tx[0], 0,
-				   MT7615_TX_RING_SIZE);
+	ret = mt7615_init_tx_queue(dev, 0, 0, MT7615_TX_RING_SIZE);
 	if (ret)
 		return ret;
 
-	for (i = 1; i < MT_TXQ_MCU; i++) {
-		q = &dev->mt76.q_tx[i];
-		q->q = dev->mt76.q_tx[0].q;
-	}
+	for (i = 1; i < MT_TXQ_MCU; i++)
+		dev->mt76.q_tx[i] = dev->mt76.q_tx[0];
 
-	ret = mt7615_init_tx_queue(dev, &dev->mt76.q_tx[MT_TXQ_MCU],
-				   MT7615_TXQ_MCU,
+	ret = mt7615_init_tx_queue(dev, MT_TXQ_MCU, MT7615_TXQ_MCU,
 				   MT7615_TX_MCU_RING_SIZE);
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 9e048ff85d0c..6a9f9187f76a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -542,7 +542,7 @@ static inline u8 mt7615_lmac_mapping(struct mt7615_dev *dev, u8 ac)
 
 static inline u32 mt7615_tx_mcu_int_mask(struct mt7615_dev *dev)
 {
-	return MT_INT_TX_DONE(dev->mt76.q_tx[MT_TXQ_MCU].q->hw_idx);
+	return MT_INT_TX_DONE(dev->mt76.q_tx[MT_TXQ_MCU]->hw_idx);
 }
 
 void mt7615_dma_reset(struct mt7615_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
index 53fb6018d013..38670c00380c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
@@ -53,7 +53,7 @@ mt7663s_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	if (ret)
 		goto out;
 
-	mt76_queue_kick(dev, mdev->q_tx[MT_TXQ_MCU].q);
+	mt76_queue_kick(dev, mdev->q_tx[MT_TXQ_MCU]);
 	if (wait_resp)
 		ret = mt7615_mcu_wait_response(dev, cmd, seq);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
index 8863c3a230d1..3557df52846f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
@@ -162,7 +162,7 @@ static int mt7663s_tx_update_sched(struct mt76_dev *dev,
 
 static int mt7663s_tx_run_queue(struct mt76_dev *dev, struct mt76_queue *q)
 {
-	bool mcu = q == dev->q_tx[MT_TXQ_MCU].q;
+	bool mcu = q == dev->q_tx[MT_TXQ_MCU];
 	struct mt76_sdio *sdio = &dev->sdio;
 	int nframes = 0;
 
@@ -204,7 +204,7 @@ void mt7663s_tx_work(struct work_struct *work)
 	for (i = 0; i < MT_TXQ_MCU_WA; i++) {
 		int ret;
 
-		ret = mt7663s_tx_run_queue(dev, dev->q_tx[i].q);
+		ret = mt7663s_tx_run_queue(dev, dev->q_tx[i]);
 		if (ret < 0)
 			break;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index a0a48c2160a9..66453c85f0de 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -14,7 +14,7 @@
 static void mt76x02_pre_tbtt_tasklet(unsigned long arg)
 {
 	struct mt76x02_dev *dev = (struct mt76x02_dev *)arg;
-	struct mt76_queue *q = dev->mt76.q_tx[MT_TXQ_PSD].q;
+	struct mt76_queue *q = dev->mt76.q_tx[MT_TXQ_PSD];
 	struct beacon_bc_data data = {};
 	struct sk_buff *skb;
 	int i;
@@ -104,8 +104,7 @@ void mt76x02e_init_beacon_config(struct mt76x02_dev *dev)
 EXPORT_SYMBOL_GPL(mt76x02e_init_beacon_config);
 
 static int
-mt76x02_init_tx_queue(struct mt76x02_dev *dev, struct mt76_sw_queue *q,
-		      int idx, int n_desc)
+mt76x02_init_tx_queue(struct mt76x02_dev *dev, int qid, int idx, int n_desc)
 {
 	struct mt76_queue *hwq;
 	int err;
@@ -118,7 +117,7 @@ mt76x02_init_tx_queue(struct mt76x02_dev *dev, struct mt76_sw_queue *q,
 	if (err < 0)
 		return err;
 
-	q->q = hwq;
+	dev->mt76.q_tx[qid] = hwq;
 
 	mt76x02_irq_enable(dev, MT_INT_TX_DONE(idx));
 
@@ -209,19 +208,18 @@ int mt76x02_dma_init(struct mt76x02_dev *dev)
 	mt76_wr(dev, MT_WPDMA_RST_IDX, ~0);
 
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-		ret = mt76x02_init_tx_queue(dev, &dev->mt76.q_tx[i],
-					    mt76_ac_to_hwq(i),
+		ret = mt76x02_init_tx_queue(dev, i, mt76_ac_to_hwq(i),
 					    MT_TX_RING_SIZE);
 		if (ret)
 			return ret;
 	}
 
-	ret = mt76x02_init_tx_queue(dev, &dev->mt76.q_tx[MT_TXQ_PSD],
+	ret = mt76x02_init_tx_queue(dev, MT_TXQ_PSD,
 				    MT_TX_HW_QUEUE_MGMT, MT_TX_RING_SIZE);
 	if (ret)
 		return ret;
 
-	ret = mt76x02_init_tx_queue(dev, &dev->mt76.q_tx[MT_TXQ_MCU],
+	ret = mt76x02_init_tx_queue(dev, MT_TXQ_MCU,
 				    MT_TX_HW_QUEUE_MCU, MT_MCU_RING_SIZE);
 	if (ret)
 		return ret;
@@ -293,7 +291,7 @@ irqreturn_t mt76x02_irq_handler(int irq, void *dev_instance)
 		if (dev->mt76.csa_complete)
 			mt76_csa_finish(&dev->mt76);
 		else
-			mt76_queue_kick(dev, dev->mt76.q_tx[MT_TXQ_PSD].q);
+			mt76_queue_kick(dev, dev->mt76.q_tx[MT_TXQ_PSD]);
 	}
 
 	if (intr & MT_INT_TX_STAT)
@@ -365,7 +363,7 @@ static bool mt76x02_tx_hang(struct mt76x02_dev *dev)
 	int i;
 
 	for (i = 0; i < 4; i++) {
-		q = dev->mt76.q_tx[i].q;
+		q = dev->mt76.q_tx[i];
 
 		if (!q->queued)
 			continue;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index 693daab5ddfc..5d0a2857f193 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -66,7 +66,7 @@ int mt76x02u_tx_prepare_skb(struct mt76_dev *mdev, void *data,
 			    struct mt76_tx_info *tx_info)
 {
 	struct mt76x02_dev *dev = container_of(mdev, struct mt76x02_dev, mt76);
-	int pid, len = tx_info->skb->len, ep = q2ep(mdev->q_tx[qid].q->hw_idx);
+	int pid, len = tx_info->skb->len, ep = q2ep(mdev->q_tx[qid]->hw_idx);
 	struct mt76x02_txwi *txwi;
 	bool ampdu = IEEE80211_SKB_CB(tx_info->skb)->flags & IEEE80211_TX_CTL_AMPDU;
 	enum mt76_qsel qsel;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index dbd4077ea283..412f3f7aab46 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -490,7 +490,7 @@ int mt76x02_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	u8 cw_min = 5, cw_max = 10, qid;
 	u32 val;
 
-	qid = dev->mt76.q_tx[queue].q->hw_idx;
+	qid = dev->mt76.q_tx[queue]->hw_idx;
 
 	if (params->cw_min)
 		cw_min = fls(params->cw_min);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 47cce0e4c8a5..0f5de0507dc3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -292,15 +292,15 @@ mt7915_queues_read(struct seq_file *s, void *data)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(queue_map); i++) {
-		struct mt76_sw_queue *q = &dev->mt76.q_tx[queue_map[i].id];
+		struct mt76_queue *q = dev->mt76.q_tx[queue_map[i].id];
 
-		if (!q->q)
+		if (!q)
 			continue;
 
 		seq_printf(s,
 			   "%s:	queued=%d head=%d tail=%d\n",
-			   queue_map[i].queue, q->q->queued, q->q->head,
-			   q->q->tail);
+			   queue_map[i].queue, q->queued, q->head,
+			   q->tail);
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 0904b94c90ff..a183b76855b8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -8,7 +8,6 @@
 static int
 mt7915_init_tx_queues(struct mt7915_dev *dev, int n_desc)
 {
-	struct mt76_sw_queue *q;
 	struct mt76_queue *hwq;
 	int err, i;
 
@@ -21,17 +20,14 @@ mt7915_init_tx_queues(struct mt7915_dev *dev, int n_desc)
 	if (err < 0)
 		return err;
 
-	for (i = 0; i < MT_TXQ_MCU; i++) {
-		q = &dev->mt76.q_tx[i];
-		q->q = hwq;
-	}
+	for (i = 0; i < MT_TXQ_MCU; i++)
+		dev->mt76.q_tx[i] = hwq;
 
 	return 0;
 }
 
 static int
-mt7915_init_mcu_queue(struct mt7915_dev *dev, struct mt76_sw_queue *q,
-		      int idx, int n_desc)
+mt7915_init_mcu_queue(struct mt7915_dev *dev, int qid, int idx, int n_desc)
 {
 	struct mt76_queue *hwq;
 	int err;
@@ -44,7 +40,7 @@ mt7915_init_mcu_queue(struct mt7915_dev *dev, struct mt76_sw_queue *q,
 	if (err < 0)
 		return err;
 
-	q->q = hwq;
+	dev->mt76.q_tx[qid] = hwq;
 
 	return 0;
 }
@@ -266,22 +262,19 @@ int mt7915_dma_init(struct mt7915_dev *dev)
 		return ret;
 
 	/* command to WM */
-	ret = mt7915_init_mcu_queue(dev, &dev->mt76.q_tx[MT_TXQ_MCU],
-				    MT7915_TXQ_MCU_WM,
+	ret = mt7915_init_mcu_queue(dev, MT_TXQ_MCU, MT7915_TXQ_MCU_WM,
 				    MT7915_TX_MCU_RING_SIZE);
 	if (ret)
 		return ret;
 
 	/* command to WA */
-	ret = mt7915_init_mcu_queue(dev, &dev->mt76.q_tx[MT_TXQ_MCU_WA],
-				    MT7915_TXQ_MCU_WA,
+	ret = mt7915_init_mcu_queue(dev, MT_TXQ_MCU_WA, MT7915_TXQ_MCU_WA,
 				    MT7915_TX_MCU_RING_SIZE);
 	if (ret)
 		return ret;
 
 	/* firmware download */
-	ret = mt7915_init_mcu_queue(dev, &dev->mt76.q_tx[MT_TXQ_FWDL],
-				    MT7915_TXQ_FWDL,
+	ret = mt7915_init_mcu_queue(dev, MT_TXQ_FWDL, MT7915_TXQ_FWDL,
 				    MT7915_TX_FWDL_RING_SIZE);
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 8ed18c9517ad..7777d4944081 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -48,7 +48,7 @@ static int mt76s_alloc_tx(struct mt76_dev *dev)
 
 		spin_lock_init(&q->lock);
 		q->hw_idx = i;
-		dev->q_tx[i].q = q;
+		dev->q_tx[i] = q;
 
 		q->entry = devm_kcalloc(dev->dev,
 					MT_NUM_TX_ENTRIES, sizeof(*q->entry),
@@ -133,9 +133,8 @@ mt76s_process_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 
 static void mt76s_process_tx_queue(struct mt76_dev *dev, enum mt76_txq_id qid)
 {
-	struct mt76_sw_queue *sq = &dev->q_tx[qid];
+	struct mt76_queue *q = dev->q_tx[qid];
 	struct mt76_queue_entry entry;
-	struct mt76_queue *q = sq->q;
 	bool wake;
 
 	while (q->queued > 0) {
@@ -199,7 +198,7 @@ mt76s_tx_queue_skb(struct mt76_dev *dev, enum mt76_txq_id qid,
 		   struct sk_buff *skb, struct mt76_wcid *wcid,
 		   struct ieee80211_sta *sta)
 {
-	struct mt76_queue *q = dev->q_tx[qid].q;
+	struct mt76_queue *q = dev->q_tx[qid];
 	struct mt76_tx_info tx_info = {
 		.skb = skb,
 	};
@@ -226,7 +225,7 @@ static int
 mt76s_tx_queue_skb_raw(struct mt76_dev *dev, enum mt76_txq_id qid,
 		       struct sk_buff *skb, u32 tx_info)
 {
-	struct mt76_queue *q = dev->q_tx[qid].q;
+	struct mt76_queue *q = dev->q_tx[qid];
 	int ret = -ENOSPC, len = skb->len;
 
 	if (q->queued == q->ndesc)
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/wireless/mediatek/mt76/testmode.c
index 5bd6ac1ba3b5..f6fd515dfe57 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/testmode.c
@@ -29,7 +29,7 @@ void mt76_testmode_tx_pending(struct mt76_dev *dev)
 		return;
 
 	qid = skb_get_queue_mapping(skb);
-	q = dev->q_tx[qid].q;
+	q = dev->q_tx[qid];
 
 	spin_lock_bh(&q->lock);
 
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 00332a2815c0..b6e52a324e28 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -310,7 +310,7 @@ __mt76_tx_queue_skb(struct mt76_dev *dev, int qid, struct sk_buff *skb,
 		return idx;
 
 	wcid = (struct mt76_wcid *)sta->drv_priv;
-	q = dev->q_tx[qid].q;
+	q = dev->q_tx[qid];
 	q->entry[idx].wcid = wcid->idx;
 	pending = atomic_inc_return(&wcid->non_aql_packets);
 	if (stop && pending >= MT_MAX_NON_AQL_PKT)
@@ -354,7 +354,7 @@ mt76_tx(struct mt76_phy *phy, struct ieee80211_sta *sta,
 	if (ext_phy)
 		info->hw_queue |= MT_TX_HW_QUEUE_EXT_PHY;
 
-	q = dev->q_tx[qid].q;
+	q = dev->q_tx[qid];
 
 	spin_lock_bh(&q->lock);
 	__mt76_tx_queue_skb(dev, qid, skb, wcid, sta, NULL);
@@ -423,7 +423,7 @@ mt76_release_buffered_frames(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 	struct mt76_phy *phy = hw->priv;
 	struct mt76_dev *dev = phy->dev;
 	struct sk_buff *last_skb = NULL;
-	struct mt76_queue *hwq = dev->q_tx[MT_TXQ_PSD].q;
+	struct mt76_queue *hwq = dev->q_tx[MT_TXQ_PSD];
 	int i;
 
 	spin_lock_bh(&hwq->lock);
@@ -460,14 +460,13 @@ mt76_release_buffered_frames(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 EXPORT_SYMBOL_GPL(mt76_release_buffered_frames);
 
 static int
-mt76_txq_send_burst(struct mt76_phy *phy, struct mt76_sw_queue *sq,
+mt76_txq_send_burst(struct mt76_phy *phy, struct mt76_queue *q,
 		    struct mt76_txq *mtxq)
 {
 	struct mt76_dev *dev = phy->dev;
 	struct ieee80211_txq *txq = mtxq_to_txq(mtxq);
 	enum mt76_txq_id qid = mt76_txq_get_qid(txq);
 	struct mt76_wcid *wcid = mtxq->wcid;
-	struct mt76_queue *hwq = sq->q;
 	struct ieee80211_tx_info *info;
 	struct sk_buff *skb;
 	int n_frames = 1;
@@ -517,7 +516,7 @@ mt76_txq_send_burst(struct mt76_phy *phy, struct mt76_sw_queue *sq,
 		n_frames++;
 	} while (1);
 
-	dev->queue_ops->kick(dev, hwq);
+	dev->queue_ops->kick(dev, q);
 
 	return n_frames;
 }
@@ -526,14 +525,13 @@ static int
 mt76_txq_schedule_list(struct mt76_phy *phy, enum mt76_txq_id qid)
 {
 	struct mt76_dev *dev = phy->dev;
-	struct mt76_sw_queue *sq = &dev->q_tx[qid];
-	struct mt76_queue *hwq = sq->q;
+	struct mt76_queue *q = dev->q_tx[qid];
 	struct ieee80211_txq *txq;
 	struct mt76_txq *mtxq;
 	struct mt76_wcid *wcid;
 	int ret = 0;
 
-	spin_lock_bh(&hwq->lock);
+	spin_lock_bh(&q->lock);
 	while (1) {
 		if (test_bit(MT76_STATE_PM, &phy->state) ||
 		    test_bit(MT76_RESET, &phy->state)) {
@@ -561,16 +559,16 @@ mt76_txq_schedule_list(struct mt76_phy *phy, enum mt76_txq_id qid)
 			u8 tid = txq->tid;
 
 			mtxq->send_bar = false;
-			spin_unlock_bh(&hwq->lock);
+			spin_unlock_bh(&q->lock);
 			ieee80211_send_bar(vif, sta->addr, tid, agg_ssn);
-			spin_lock_bh(&hwq->lock);
+			spin_lock_bh(&q->lock);
 		}
 
-		ret += mt76_txq_send_burst(phy, sq, mtxq);
+		ret += mt76_txq_send_burst(phy, q, mtxq);
 		ieee80211_return_txq(phy->hw, txq,
 				     !skb_queue_empty(&mtxq->retry_q));
 	}
-	spin_unlock_bh(&hwq->lock);
+	spin_unlock_bh(&q->lock);
 
 	return ret;
 }
@@ -631,7 +629,7 @@ void mt76_stop_tx_queues(struct mt76_dev *dev, struct ieee80211_sta *sta,
 			continue;
 
 		mtxq = (struct mt76_txq *)txq->drv_priv;
-		hwq = mtxq->swq->q;
+		hwq = mtxq->q;
 
 		spin_lock_bh(&hwq->lock);
 		mtxq->send_bar = mtxq->aggr && send_bar;
@@ -676,7 +674,7 @@ void mt76_txq_init(struct mt76_dev *dev, struct ieee80211_txq *txq)
 
 	skb_queue_head_init(&mtxq->retry_q);
 
-	mtxq->swq = &dev->q_tx[mt76_txq_get_qid(txq)];
+	mtxq->q = dev->q_tx[mt76_txq_get_qid(txq)];
 }
 EXPORT_SYMBOL_GPL(mt76_txq_init);
 
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 79e06c54a973..18dbecafb7a0 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -796,14 +796,12 @@ static void mt76u_tx_tasklet(unsigned long data)
 {
 	struct mt76_dev *dev = (struct mt76_dev *)data;
 	struct mt76_queue_entry entry;
-	struct mt76_sw_queue *sq;
 	struct mt76_queue *q;
 	bool wake;
 	int i;
 
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-		sq = &dev->q_tx[i];
-		q = sq->q;
+		q = dev->q_tx[i];
 
 		while (q->queued > 0) {
 			if (!q->entry[q->tail].done)
@@ -893,7 +891,7 @@ mt76u_tx_queue_skb(struct mt76_dev *dev, enum mt76_txq_id qid,
 		   struct sk_buff *skb, struct mt76_wcid *wcid,
 		   struct ieee80211_sta *sta)
 {
-	struct mt76_queue *q = dev->q_tx[qid].q;
+	struct mt76_queue *q = dev->q_tx[qid];
 	struct mt76_tx_info tx_info = {
 		.skb = skb,
 	};
@@ -972,7 +970,7 @@ static int mt76u_alloc_tx(struct mt76_dev *dev)
 
 	for (i = 0; i <= MT_TXQ_PSD; i++) {
 		if (i >= IEEE80211_NUM_ACS) {
-			dev->q_tx[i].q = dev->q_tx[0].q;
+			dev->q_tx[i] = dev->q_tx[0];
 			continue;
 		}
 
@@ -982,7 +980,7 @@ static int mt76u_alloc_tx(struct mt76_dev *dev)
 
 		spin_lock_init(&q->lock);
 		q->hw_idx = mt76u_ac_to_hwq(dev, i);
-		dev->q_tx[i].q = q;
+		dev->q_tx[i] = q;
 
 		q->entry = devm_kcalloc(dev->dev,
 					MT_NUM_TX_ENTRIES, sizeof(*q->entry),
@@ -1009,7 +1007,7 @@ static void mt76u_free_tx(struct mt76_dev *dev)
 		struct mt76_queue *q;
 		int j;
 
-		q = dev->q_tx[i].q;
+		q = dev->q_tx[i];
 		if (!q)
 			continue;
 
@@ -1032,7 +1030,7 @@ void mt76u_stop_tx(struct mt76_dev *dev)
 		dev_err(dev->dev, "timed out waiting for pending tx\n");
 
 		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-			q = dev->q_tx[i].q;
+			q = dev->q_tx[i];
 			if (!q)
 				continue;
 
@@ -1046,7 +1044,7 @@ void mt76u_stop_tx(struct mt76_dev *dev)
 		 * will fail to submit urb, cleanup those skb's manually.
 		 */
 		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-			q = dev->q_tx[i].q;
+			q = dev->q_tx[i];
 			if (!q)
 				continue;
 
-- 
2.28.0

