Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0687C25792B
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 14:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgHaM0T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 08:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgHaM0L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 08:26:11 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF09C061236
        for <linux-wireless@vger.kernel.org>; Mon, 31 Aug 2020 05:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Rd1q62g2NX1JG/KaD09izJE8ZKS+UV7eQLo4vgjr4LQ=; b=JL0XFDyi99AlRTt8bnxrqejGEY
        xirWyTHfCovi3iG/w8KdAmJrfn5M2+wywSHYBvOz++QVdRtJJv/LM/rpWpcHkGVHHqKn2jVrG1sfR
        /Em5YZBXXmx1jRGnfjIjvzXJDkgQLKJx028GAbS/JWV9Sw43bkcUTDg2zvc/8ALtZ7NU=;
Received: from p4ff13fcb.dip0.t-ipconnect.de ([79.241.63.203] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kCiss-0000Ok-Fi
        for linux-wireless@vger.kernel.org; Mon, 31 Aug 2020 14:26:02 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 6/9] mt76: rely on AQL for burst size limits on tx queueing
Date:   Mon, 31 Aug 2020 14:25:55 +0200
Message-Id: <20200831122558.1388-6-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200831122558.1388-1-nbd@nbd.name>
References: <20200831122558.1388-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Now that AQL works well on all mt76 drivers, completely replace the arbitrary
burst sizing and number of bursts logic for tx scheduling.
For the short period of time in which AQL does not work well yet, limit each
stations to 16 in-flight packets that have no estimated tx time.
This should avoid filling the queue if a station connects and queues up a
large number of packets before rate control information is available, especially
with hardware rate control

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/debugfs.c  |   9 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  11 +-
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |   9 +-
 .../wireless/mediatek/mt76/mt7615/pci_mac.c   |   2 +-
 .../wireless/mediatek/mt76/mt7615/usb_sdio.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  |   2 +-
 .../wireless/mediatek/mt76/mt76x02_usb_core.c |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  11 ++
 drivers/net/wireless/mediatek/mt76/sdio.c     |   1 -
 drivers/net/wireless/mediatek/mt76/tx.c       | 131 ++++++++++--------
 drivers/net/wireless/mediatek/mt76/usb.c      |   2 -
 12 files changed, 109 insertions(+), 75 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/debugfs.c b/drivers/net/wireless/mediatek/mt76/debugfs.c
index 5d58b16bfe9f..4a06d10e15ac 100644
--- a/drivers/net/wireless/mediatek/mt76/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
@@ -31,15 +31,14 @@ int mt76_queues_read(struct seq_file *s, void *data)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(dev->q_tx); i++) {
-		struct mt76_sw_queue *q = &dev->q_tx[i];
+		struct mt76_queue *q = dev->q_tx[i].q;
 
-		if (!q->q)
+		if (!q)
 			continue;
 
 		seq_printf(s,
-			   "%d:	queued=%d head=%d tail=%d swq_queued=%d\n",
-			   i, q->q->queued, q->q->head, q->q->tail,
-			   q->swq_queued);
+			   "%d:	queued=%d head=%d tail=%d\n",
+			   i, q->queued, q->head, q->tail);
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 6cb69e87e8a7..37f33f4d1280 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -22,6 +22,9 @@
 #define MT_RX_BUF_SIZE      2048
 #define MT_SKB_HEAD_LEN     128
 
+#define MT_MAX_NON_AQL_PKT  16
+#define MT_TXQ_FREE_THR     32
+
 struct mt76_dev;
 struct mt76_phy;
 struct mt76_wcid;
@@ -100,10 +103,9 @@ struct mt76_queue_entry {
 		struct urb *urb;
 		int buf_sz;
 	};
-	enum mt76_txq_id qid;
+	u16 wcid;
 	bool skip_buf0:1;
 	bool skip_buf1:1;
-	bool schedule:1;
 	bool done:1;
 };
 
@@ -139,8 +141,6 @@ struct mt76_queue {
 
 struct mt76_sw_queue {
 	struct mt76_queue *q;
-
-	int swq_queued;
 };
 
 struct mt76_mcu_ops {
@@ -205,6 +205,7 @@ DECLARE_EWMA(signal, 10, 8);
 struct mt76_wcid {
 	struct mt76_rx_tid __rcu *aggr[IEEE80211_NUM_TIDS];
 
+	atomic_t non_aql_packets;
 	unsigned long flags;
 
 	struct ewma_signal rssi;
@@ -943,7 +944,7 @@ struct sk_buff *mt76_tx_status_skb_get(struct mt76_dev *dev,
 				       struct sk_buff_head *list);
 void mt76_tx_status_skb_done(struct mt76_dev *dev, struct sk_buff *skb,
 			     struct sk_buff_head *list);
-void mt76_tx_complete_skb(struct mt76_dev *dev, struct sk_buff *skb);
+void mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid, struct sk_buff *skb);
 void mt76_tx_status_check(struct mt76_dev *dev, struct mt76_wcid *wcid,
 			  bool flush);
 int mt76_sta_state(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index cb99b7c39f51..15fb31fe9cf8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1282,7 +1282,7 @@ void mt7603_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 	}
 
 	dev->tx_hang_check = 0;
-	mt76_tx_complete_skb(mdev, skb);
+	mt76_tx_complete_skb(mdev, e->wcid, skb);
 }
 
 static bool
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 9b8fbf26cd1e..9d0edbaa67bc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1400,6 +1400,9 @@ mt7615_mac_tx_free_token(struct mt7615_dev *dev, u16 token)
 {
 	struct mt76_dev *mdev = &dev->mt76;
 	struct mt76_txwi_cache *txwi;
+	__le32 *txwi_data;
+	u32 val;
+	u8 wcid;
 
 	trace_mac_tx_free(dev, token);
 
@@ -1410,9 +1413,13 @@ mt7615_mac_tx_free_token(struct mt7615_dev *dev, u16 token)
 	if (!txwi)
 		return;
 
+	txwi_data = (__le32 *)mt76_get_txwi_ptr(mdev, txwi);
+	val = le32_to_cpu(txwi_data[1]);
+	wcid = FIELD_GET(MT_TXD1_WLAN_IDX, val);
+
 	mt7615_txp_skb_unmap(mdev, txwi);
 	if (txwi->skb) {
-		mt76_tx_complete_skb(mdev, txwi->skb);
+		mt76_tx_complete_skb(mdev, wcid, txwi->skb);
 		txwi->skb = NULL;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index ba53606c4586..4cf7c5d34325 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -44,7 +44,7 @@ void mt7615_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 	}
 
 	if (e->skb)
-		mt76_tx_complete_skb(mdev, e->skb);
+		mt76_tx_complete_skb(mdev, e->wcid, e->skb);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
index 30065b015776..56d82bd3a615 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
@@ -234,7 +234,7 @@ void mt7663_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
 		headroom += MT_USB_HDR_SIZE;
 	skb_pull(e->skb, headroom);
 
-	mt76_tx_complete_skb(mdev, e->skb);
+	mt76_tx_complete_skb(mdev, e->wcid, e->skb);
 }
 EXPORT_SYMBOL_GPL(mt7663_usb_sdio_tx_complete_skb);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 4c7a0482b344..8529837a846a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -917,7 +917,7 @@ void mt76x02_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 	txwi = (struct mt76x02_txwi *)txwi_ptr;
 	trace_mac_txdone(mdev, txwi->wcid, txwi->pktid);
 
-	mt76_tx_complete_skb(mdev, e->skb);
+	mt76_tx_complete_skb(mdev, e->wcid, e->skb);
 }
 EXPORT_SYMBOL_GPL(mt76x02_tx_complete_skb);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index cc28583226ff..693daab5ddfc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -18,7 +18,7 @@ static void mt76x02u_remove_dma_hdr(struct sk_buff *skb)
 void mt76x02u_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 {
 	mt76x02u_remove_dma_hdr(e->skb);
-	mt76_tx_complete_skb(mdev, e->skb);
+	mt76_tx_complete_skb(mdev, e->wcid, e->skb);
 }
 EXPORT_SYMBOL_GPL(mt76x02u_tx_complete_skb);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index cbcdd30a24d7..4d6e4143e346 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -927,10 +927,21 @@ void mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 
 		mt7915_txp_skb_unmap(mdev, txwi);
 		if (txwi->skb) {
+			struct ieee80211_tx_info *info = IEEE80211_SKB_CB(txwi->skb);
 			void *txwi_ptr = mt76_get_txwi_ptr(mdev, txwi);
 
 			if (likely(txwi->skb->protocol != cpu_to_be16(ETH_P_PAE)))
 				mt7915_tx_check_aggr(sta, txwi_ptr);
+
+			if (sta && !info->tx_time_est) {
+				struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
+				int pending;
+
+				pending = atomic_dec_return(&wcid->non_aql_packets);
+				if (pending < 0)
+					atomic_cmpxchg(&wcid->non_aql_packets, pending, 0);
+			}
+
 			mt7915_tx_complete_status(mdev, txwi->skb, sta, stat);
 			txwi->skb = NULL;
 		}
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index e41037ac0867..8ed18c9517ad 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -144,7 +144,6 @@ static void mt76s_process_tx_queue(struct mt76_dev *dev, enum mt76_txq_id qid)
 
 		entry = q->entry[q->tail];
 		q->entry[q->tail].done = false;
-		q->entry[q->tail].schedule = false;
 
 		if (qid == MT_TXQ_MCU) {
 			dev_kfree_skb(entry.skb);
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 3dac8f7dbff6..00332a2815c0 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -241,7 +241,32 @@ mt76_tx_status_check(struct mt76_dev *dev, struct mt76_wcid *wcid, bool flush)
 }
 EXPORT_SYMBOL_GPL(mt76_tx_status_check);
 
-void mt76_tx_complete_skb(struct mt76_dev *dev, struct sk_buff *skb)
+static void
+mt76_tx_check_non_aql(struct mt76_dev *dev, u16 wcid_idx, struct sk_buff *skb)
+{
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct mt76_wcid *wcid;
+	int pending;
+
+	if (info->tx_time_est)
+		return;
+
+	if (wcid_idx >= ARRAY_SIZE(dev->wcid))
+		return;
+
+	rcu_read_lock();
+
+	wcid = rcu_dereference(dev->wcid[wcid_idx]);
+	if (wcid) {
+		pending = atomic_dec_return(&wcid->non_aql_packets);
+		if (pending < 0)
+			atomic_cmpxchg(&wcid->non_aql_packets, pending, 0);
+	}
+
+	rcu_read_unlock();
+}
+
+void mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid_idx, struct sk_buff *skb)
 {
 	struct ieee80211_hw *hw;
 	struct sk_buff_head list;
@@ -254,6 +279,8 @@ void mt76_tx_complete_skb(struct mt76_dev *dev, struct sk_buff *skb)
 	}
 #endif
 
+	mt76_tx_check_non_aql(dev, wcid_idx, skb);
+
 	if (!skb->prev) {
 		hw = mt76_tx_status_get_hw(dev, skb);
 		ieee80211_free_txskb(hw, skb);
@@ -266,6 +293,32 @@ void mt76_tx_complete_skb(struct mt76_dev *dev, struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(mt76_tx_complete_skb);
 
+static int
+__mt76_tx_queue_skb(struct mt76_dev *dev, int qid, struct sk_buff *skb,
+		    struct mt76_wcid *wcid, struct ieee80211_sta *sta,
+		    bool *stop)
+{
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct mt76_queue *q;
+	bool non_aql;
+	int pending;
+	int idx;
+
+	non_aql = !info->tx_time_est;
+	idx = dev->queue_ops->tx_queue_skb(dev, qid, skb, wcid, sta);
+	if (idx < 0 || !sta || !non_aql)
+		return idx;
+
+	wcid = (struct mt76_wcid *)sta->drv_priv;
+	q = dev->q_tx[qid].q;
+	q->entry[idx].wcid = wcid->idx;
+	pending = atomic_inc_return(&wcid->non_aql_packets);
+	if (stop && pending >= MT_MAX_NON_AQL_PKT)
+		*stop = true;
+
+	return idx;
+}
+
 void
 mt76_tx(struct mt76_phy *phy, struct ieee80211_sta *sta,
 	struct mt76_wcid *wcid, struct sk_buff *skb)
@@ -304,7 +357,7 @@ mt76_tx(struct mt76_phy *phy, struct ieee80211_sta *sta,
 	q = dev->q_tx[qid].q;
 
 	spin_lock_bh(&q->lock);
-	dev->queue_ops->tx_queue_skb(dev, qid, skb, wcid, sta);
+	__mt76_tx_queue_skb(dev, qid, skb, wcid, sta, NULL);
 	dev->queue_ops->kick(dev, q);
 
 	if (q->queued > q->ndesc - 8 && !q->stopped) {
@@ -358,7 +411,7 @@ mt76_queue_ps_skb(struct mt76_dev *dev, struct ieee80211_sta *sta,
 			       IEEE80211_TX_CTL_REQ_TX_STATUS;
 
 	mt76_skb_set_moredata(skb, !last);
-	dev->queue_ops->tx_queue_skb(dev, MT_TXQ_PSD, skb, wcid, sta);
+	__mt76_tx_queue_skb(dev, MT_TXQ_PSD, skb, wcid, sta, NULL);
 }
 
 void
@@ -417,15 +470,16 @@ mt76_txq_send_burst(struct mt76_phy *phy, struct mt76_sw_queue *sq,
 	struct mt76_queue *hwq = sq->q;
 	struct ieee80211_tx_info *info;
 	struct sk_buff *skb;
-	int n_frames = 1, limit;
-	struct ieee80211_tx_rate tx_rate;
-	bool ampdu;
-	bool probe;
+	int n_frames = 1;
+	bool stop = false;
 	int idx;
 
 	if (test_bit(MT_WCID_FLAG_PS, &wcid->flags))
 		return 0;
 
+	if (atomic_read(&wcid->non_aql_packets) >= MT_MAX_NON_AQL_PKT)
+		return 0;
+
 	skb = mt76_txq_dequeue(phy, mtxq, false);
 	if (!skb)
 		return 0;
@@ -434,55 +488,34 @@ mt76_txq_send_burst(struct mt76_phy *phy, struct mt76_sw_queue *sq,
 	if (!(wcid->tx_info & MT_WCID_TX_INFO_SET))
 		ieee80211_get_tx_rates(txq->vif, txq->sta, skb,
 				       info->control.rates, 1);
-	tx_rate = info->control.rates[0];
-
-	probe = (info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE);
-	ampdu = IEEE80211_SKB_CB(skb)->flags & IEEE80211_TX_CTL_AMPDU;
-	limit = ampdu ? 16 : 3;
-
-	idx = dev->queue_ops->tx_queue_skb(dev, qid, skb, wcid, txq->sta);
 
+	idx = __mt76_tx_queue_skb(dev, qid, skb, wcid, txq->sta, &stop);
 	if (idx < 0)
 		return idx;
 
 	do {
-		bool cur_ampdu;
-
-		if (probe)
-			break;
-
 		if (test_bit(MT76_STATE_PM, &phy->state) ||
-		    test_bit(MT76_RESET, &phy->state))
+		    test_bit(MT76_RESET, &phy->state) || stop)
 			return -EBUSY;
 
+		if (q->queued + MT_TXQ_FREE_THR >= q->ndesc)
+			break;
+
 		skb = mt76_txq_dequeue(phy, mtxq, false);
 		if (!skb)
 			break;
 
 		info = IEEE80211_SKB_CB(skb);
-		cur_ampdu = info->flags & IEEE80211_TX_CTL_AMPDU;
+		if (!(wcid->tx_info & MT_WCID_TX_INFO_SET))
+			ieee80211_get_tx_rates(txq->vif, txq->sta, skb,
+					       info->control.rates, 1);
 
-		if (ampdu != cur_ampdu ||
-		    (info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE)) {
-			skb_queue_tail(&mtxq->retry_q, skb);
-			break;
-		}
-
-		info->control.rates[0] = tx_rate;
-
-		idx = dev->queue_ops->tx_queue_skb(dev, qid, skb, wcid,
-						   txq->sta);
+		idx = __mt76_tx_queue_skb(dev, qid, skb, wcid, txq->sta, &stop);
 		if (idx < 0)
-			return idx;
+			break;
 
 		n_frames++;
-	} while (n_frames < limit);
-
-	if (!probe) {
-		hwq->entry[idx].qid = sq - dev->q_tx;
-		hwq->entry[idx].schedule = true;
-		sq->swq_queued++;
-	}
+	} while (1);
 
 	dev->queue_ops->kick(dev, hwq);
 
@@ -502,15 +535,15 @@ mt76_txq_schedule_list(struct mt76_phy *phy, enum mt76_txq_id qid)
 
 	spin_lock_bh(&hwq->lock);
 	while (1) {
-		if (sq->swq_queued >= 4)
-			break;
-
 		if (test_bit(MT76_STATE_PM, &phy->state) ||
 		    test_bit(MT76_RESET, &phy->state)) {
 			ret = -EBUSY;
 			break;
 		}
 
+		if (q->queued + MT_TXQ_FREE_THR >= q->ndesc)
+			break;
+
 		txq = ieee80211_next_txq(phy->hw, qid);
 		if (!txq)
 			break;
@@ -544,16 +577,11 @@ mt76_txq_schedule_list(struct mt76_phy *phy, enum mt76_txq_id qid)
 
 void mt76_txq_schedule(struct mt76_phy *phy, enum mt76_txq_id qid)
 {
-	struct mt76_dev *dev = phy->dev;
-	struct mt76_sw_queue *sq = &dev->q_tx[qid];
 	int len;
 
 	if (qid >= 4)
 		return;
 
-	if (sq->swq_queued >= 4)
-		return;
-
 	rcu_read_lock();
 
 	do {
@@ -700,21 +728,12 @@ EXPORT_SYMBOL_GPL(mt76_skb_adjust_pad);
 void mt76_queue_tx_complete(struct mt76_dev *dev, struct mt76_queue *q,
 			    struct mt76_queue_entry *e)
 {
-	enum mt76_txq_id qid = e->qid % 4;
-	bool ext_phy = e->qid >= 4;
-
 	if (e->skb)
 		dev->drv->tx_complete_skb(dev, e);
 
 	spin_lock_bh(&q->lock);
 	q->tail = (q->tail + 1) % q->ndesc;
 	q->queued--;
-
-	if (ext_phy)
-		qid += __MT_TXQ_MAX;
-
-	if (e->schedule)
-		dev->q_tx[qid].swq_queued--;
 	spin_unlock_bh(&q->lock);
 }
 EXPORT_SYMBOL_GPL(mt76_queue_tx_complete);
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 14b93a0ef534..79e06c54a973 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -811,7 +811,6 @@ static void mt76u_tx_tasklet(unsigned long data)
 
 			entry = q->entry[q->tail];
 			q->entry[q->tail].done = false;
-			q->entry[q->tail].schedule = false;
 
 			mt76_queue_tx_complete(dev, q, &entry);
 		}
@@ -1053,7 +1052,6 @@ void mt76u_stop_tx(struct mt76_dev *dev)
 
 			entry = q->entry[q->tail];
 			q->entry[q->tail].done = false;
-			q->entry[q->tail].schedule = false;
 
 			mt76_queue_tx_complete(dev, q, &entry);
 		}
-- 
2.28.0

