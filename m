Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD69B3F21E0
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Aug 2021 22:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbhHSUuz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Aug 2021 16:50:55 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.49]:40962 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235563AbhHSUuy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Aug 2021 16:50:54 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.65.202])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 2E2B11C0069
        for <linux-wireless@vger.kernel.org>; Thu, 19 Aug 2021 20:50:16 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 01F988007D
        for <linux-wireless@vger.kernel.org>; Thu, 19 Aug 2021 20:50:15 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 4B60413C2B1;
        Thu, 19 Aug 2021 13:49:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4B60413C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1629406195;
        bh=fi3p6mUjaKj8NPoDcxaPuge/ESbAWXaVFnYe16yZJfg=;
        h=From:To:Cc:Subject:Date:From;
        b=QZvzB5a4hiXWt3Ga/ZwuYlIr5ipozeGYRNikdgwBeo/KLbNYcWtTGINkIVZiObNYJ
         yURxVhUHpPC1xc2ZU2xFdDd8Z+Br4sz00sMHyVvNXbAXoxOpGjnk4+K79vGhp4pndA
         /P3h/gy01nrxnzD9IGeLi6ee+zKWB+ltOKO37nes=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v8 1/9] mt76:  add hash lookup for skb on TXS status_list
Date:   Thu, 19 Aug 2021 13:49:42 -0700
Message-Id: <20210819204950.12150-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1629406216-VzFZlG0mso4U
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This improves performance when sending lots of frames that
are requesting being mapped to a TXS callback.

Add comments to help next person understood the tx path
better.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

v8:  Re-do the txs hash per Felix's suggestions.
   Remove the tx-overrides patch from this series per Kalle.

 drivers/net/wireless/mediatek/mt76/mt76.h     | 48 +++++++---
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  4 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  9 +-
 drivers/net/wireless/mediatek/mt76/tx.c       | 94 ++++++++++++++++---
 7 files changed, 130 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 436bf2b8e2cd..3ea4936753c2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -235,6 +235,16 @@ DECLARE_EWMA(signal, 10, 8);
 #define MT_WCID_TX_INFO_TXPWR_ADJ	GENMASK(25, 18)
 #define MT_WCID_TX_INFO_SET		BIT(31)
 
+#define MT_PACKET_ID_MASK		GENMASK(6, 0)
+#define MT_PACKET_ID_NO_ACK		0
+/* Request TXS, but don't try to match with skb. */
+#define MT_PACKET_ID_NO_SKB		1
+#define MT_PACKET_ID_FIRST		2
+#define MT_PACKET_ID_HAS_RATE		BIT(7)
+#define MT_PACKET_ID_MAX		(GENMASK(7, 0) - 1)
+#define MT_NUM_STATUS_PACKETS \
+	(MT_PACKET_ID_MAX + 1 - MT_PACKET_ID_FIRST)
+
 struct mt76_wcid {
 	struct mt76_rx_tid __rcu *aggr[IEEE80211_NUM_TIDS];
 
@@ -246,6 +256,8 @@ struct mt76_wcid {
 
 	struct rate_info rate;
 
+	struct sk_buff *skb_status_array[MT_NUM_STATUS_PACKETS];
+
 	u16 idx;
 	u8 hw_key_idx;
 	u8 hw_key_idx2;
@@ -302,16 +314,16 @@ struct mt76_rx_tid {
 #define MT_TX_CB_TXS_DONE		BIT(1)
 #define MT_TX_CB_TXS_FAILED		BIT(2)
 
-#define MT_PACKET_ID_MASK		GENMASK(6, 0)
-#define MT_PACKET_ID_NO_ACK		0
-#define MT_PACKET_ID_NO_SKB		1
-#define MT_PACKET_ID_FIRST		2
-#define MT_PACKET_ID_HAS_RATE		BIT(7)
-
-#define MT_TX_STATUS_SKB_TIMEOUT	HZ
+/* This is timer for when to give up when waiting for TXS callback,
+ * with starting time being the time at which the DMA_DONE callback
+ * was seen (so, we know packet was processed then, it should not take
+ * long after that for firmware to send the TXS callback if it is going
+ * to do so.)
+ */
+#define MT_TX_STATUS_SKB_TIMEOUT	(HZ / 4)
 
 struct mt76_tx_cb {
-	unsigned long jiffies;
+	unsigned long jiffies; /* for when DMA_DONE was reported. */
 	u16 wcid;
 	u8 pktid;
 	u8 flags;
@@ -651,6 +663,7 @@ struct mt76_dev {
 	spinlock_t cc_lock;
 
 	u32 cur_cc_bss_rx;
+	unsigned long next_status_jiffies;
 
 	struct mt76_rx_status rx_ampdu_status;
 	u32 rx_ampdu_len;
@@ -1090,7 +1103,7 @@ struct sk_buff *mt76_tx_status_skb_get(struct mt76_dev *dev,
 				       struct mt76_wcid *wcid, int pktid,
 				       struct sk_buff_head *list);
 void mt76_tx_status_skb_done(struct mt76_dev *dev, struct sk_buff *skb,
-			     struct sk_buff_head *list);
+			     struct sk_buff_head *list, struct mt76_wcid *wcid);
 void __mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid, struct sk_buff *skb,
 			    struct list_head *free_list);
 static inline void
@@ -1297,13 +1310,24 @@ mt76_token_put(struct mt76_dev *dev, int token)
 }
 
 static inline int
-mt76_get_next_pkt_id(struct mt76_wcid *wcid)
+mt76_get_next_pkt_id(struct mt76_dev *dev, struct mt76_wcid *wcid,
+		     struct sk_buff *skb)
 {
+	struct sk_buff *qskb;
+
+	lockdep_assert_held(&dev->status_list.lock);
+
 	wcid->packet_id = (wcid->packet_id + 1) & MT_PACKET_ID_MASK;
-	if (wcid->packet_id == MT_PACKET_ID_NO_ACK ||
-	    wcid->packet_id == MT_PACKET_ID_NO_SKB)
+	if (wcid->packet_id < MT_PACKET_ID_FIRST)
 		wcid->packet_id = MT_PACKET_ID_FIRST;
 
+	qskb = wcid->skb_status_array[wcid->packet_id - MT_PACKET_ID_FIRST];
+	if (qskb)
+		/* bummer, already waiting on this pid.  Other logic
+		 * will clean up stale entries.
+		 */
+		return MT_PACKET_ID_NO_SKB;
+
 	return wcid->packet_id;
 }
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 3972c56136a2..2f268eb7c1e6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1230,7 +1230,7 @@ mt7603_mac_add_txs_skb(struct mt7603_dev *dev, struct mt7603_sta *sta, int pid,
 			info->status.rates[0].idx = -1;
 		}
 
-		mt76_tx_status_skb_done(mdev, skb, &list);
+		mt76_tx_status_skb_done(mdev, skb, &list, &sta->wcid);
 	}
 	mt76_tx_status_unlock(mdev, &list);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index ff3f85e4087c..381a998817d4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1433,7 +1433,7 @@ static bool mt7615_mac_add_txs_skb(struct mt7615_dev *dev,
 			info->status.rates[0].idx = -1;
 		}
 
-		mt76_tx_status_skb_done(mdev, skb, &list);
+		mt76_tx_status_skb_done(mdev, skb, &list, &sta->wcid);
 	}
 	mt76_tx_status_unlock(mdev, &list);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index c32e6dc68773..fce020e64678 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -622,7 +622,7 @@ void mt76x02_send_tx_status(struct mt76x02_dev *dev,
 		info = *status.info;
 		len = status.skb->len;
 		ac = skb_get_queue_mapping(status.skb);
-		mt76_tx_status_skb_done(mdev, status.skb, &list);
+		mt76_tx_status_skb_done(mdev, status.skb, &list, wcid);
 	} else if (msta) {
 		len = status.info->status.ampdu_len * ewma_pktlen_read(&msta->pktlen);
 		ac = FIELD_GET(MT_PKTID_AC, cur_pktid);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index d9f52e2611a7..c8432054a63e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1318,6 +1318,7 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 
 	mt76_tx_status_lock(mdev, &list);
 	skb = mt76_tx_status_skb_get(mdev, wcid, pid, &list);
+
 	if (!skb)
 		goto out;
 
@@ -1417,10 +1418,11 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 		stats->tx_bw[0]++;
 		break;
 	}
+
 	wcid->rate = rate;
 
 out:
-	mt76_tx_status_skb_done(mdev, skb, &list);
+	mt76_tx_status_skb_done(mdev, skb, &list, wcid);
 	mt76_tx_status_unlock(mdev, &list);
 
 	return !!skb;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 76985a6b3be5..219c17d77e46 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -732,7 +732,9 @@ mt7921_mac_write_txwi_80211(struct mt7921_dev *dev, __le32 *txwi,
 	txwi[7] |= cpu_to_le32(val);
 }
 
-static void mt7921_update_txs(struct mt76_wcid *wcid, __le32 *txwi)
+static void mt7921_update_txs(struct mt7921_dev *dev,
+			      struct mt76_wcid *wcid, __le32 *txwi,
+			      struct sk_buff *skb)
 {
 	struct mt7921_sta *msta = container_of(wcid, struct mt7921_sta, wcid);
 	u32 pid, frame_type = FIELD_GET(MT_TXD2_FRAME_TYPE, txwi[2]);
@@ -744,7 +746,7 @@ static void mt7921_update_txs(struct mt76_wcid *wcid, __le32 *txwi)
 		return;
 
 	msta->next_txs_ts = jiffies + msecs_to_jiffies(250);
-	pid = mt76_get_next_pkt_id(wcid);
+	pid = mt76_get_next_pkt_id(&dev->mt76, wcid, skb);
 	txwi[5] |= cpu_to_le32(MT_TXD5_TX_STATUS_MCU |
 			       FIELD_PREP(MT_TXD5_PID, pid));
 }
@@ -771,7 +773,6 @@ void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = info->control.vif;
-	struct mt76_phy *mphy = &dev->mphy;
 	u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
 	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
 	u16 tx_count = 15;
@@ -839,7 +840,7 @@ void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
 		txwi[3] |= cpu_to_le32(MT_TXD3_BA_DISABLE);
 	}
 
-	mt7921_update_txs(wcid, txwi);
+	mt7921_update_txs(dev, wcid, txwi, skb);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 6f302acb6e69..7b281cd062c9 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -36,6 +36,7 @@ mt76_tx_check_agg_ssn(struct ieee80211_sta *sta, struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(mt76_tx_check_agg_ssn);
 
+/* Lock list, and initialize the timed-out-skb list object. */
 void
 mt76_tx_status_lock(struct mt76_dev *dev, struct sk_buff_head *list)
 		   __acquires(&dev->status_list.lock)
@@ -45,6 +46,9 @@ mt76_tx_status_lock(struct mt76_dev *dev, struct sk_buff_head *list)
 }
 EXPORT_SYMBOL_GPL(mt76_tx_status_lock);
 
+/* Unlock list, and use last-received status for any skbs that
+ * timed out getting TXS callback (they are on the list passed in
+ */
 void
 mt76_tx_status_unlock(struct mt76_dev *dev, struct sk_buff_head *list)
 		      __releases(&dev->status_list.lock)
@@ -80,20 +84,44 @@ EXPORT_SYMBOL_GPL(mt76_tx_status_unlock);
 
 static void
 __mt76_tx_status_skb_done(struct mt76_dev *dev, struct sk_buff *skb, u8 flags,
-			  struct sk_buff_head *list)
+			  struct sk_buff_head *list, struct mt76_wcid *wcid)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct mt76_tx_cb *cb = mt76_tx_skb_cb(skb);
 	u8 done = MT_TX_CB_DMA_DONE | MT_TX_CB_TXS_DONE;
 
+	lockdep_assert_held(&dev->status_list.lock);
+
+	/* Start timer for TXS callback expiration. */
+	if (flags & MT_TX_CB_DMA_DONE)
+		cb->jiffies = jiffies;
+
 	flags |= cb->flags;
 	cb->flags = flags;
 
+	/* Only process skb with TXS status has been received and also
+	 * the txfree (DMA_DONE) callback has happened.
+	 */
 	if ((flags & done) != done)
 		return;
 
 	__skb_unlink(skb, &dev->status_list);
 
+	rcu_read_lock();
+	/* calling code may not know wcid, for instance in the tx_status_check
+	 * path, look it up in that case.
+	 */
+	if (!wcid)
+		wcid = rcu_dereference(dev->wcid[cb->wcid]);
+
+	/* Make sure we clear any cached skb. */
+	if (wcid) {
+		if (!(WARN_ON_ONCE(cb->pktid - MT_PACKET_ID_FIRST
+				   >= ARRAY_SIZE(wcid->skb_status_array))))
+			wcid->skb_status_array[cb->pktid - MT_PACKET_ID_FIRST] = NULL;
+	}
+	rcu_read_unlock();
+
 	/* Tx status can be unreliable. if it fails, mark the frame as ACKed */
 	if (flags & MT_TX_CB_TXS_FAILED) {
 		info->status.rates[0].count = 0;
@@ -106,9 +134,9 @@ __mt76_tx_status_skb_done(struct mt76_dev *dev, struct sk_buff *skb, u8 flags,
 
 void
 mt76_tx_status_skb_done(struct mt76_dev *dev, struct sk_buff *skb,
-			struct sk_buff_head *list)
+			struct sk_buff_head *list, struct mt76_wcid *wcid)
 {
-	__mt76_tx_status_skb_done(dev, skb, MT_TX_CB_TXS_DONE, list);
+	__mt76_tx_status_skb_done(dev, skb, MT_TX_CB_TXS_DONE, list, wcid);
 }
 EXPORT_SYMBOL_GPL(mt76_tx_status_skb_done);
 
@@ -133,12 +161,16 @@ mt76_tx_status_skb_add(struct mt76_dev *dev, struct mt76_wcid *wcid,
 	spin_lock_bh(&dev->status_list.lock);
 
 	memset(cb, 0, sizeof(*cb));
-	pid = mt76_get_next_pkt_id(wcid);
+	pid = mt76_get_next_pkt_id(dev, wcid, skb);
 	cb->wcid = wcid->idx;
 	cb->pktid = pid;
-	cb->jiffies = jiffies;
 
-	__skb_queue_tail(&dev->status_list, skb);
+	if (cb->pktid != MT_PACKET_ID_NO_SKB) {
+		__skb_queue_tail(&dev->status_list, skb);
+		/* cache this skb for fast lookup by packet-id */
+		wcid->skb_status_array[pid - MT_PACKET_ID_FIRST] = skb;
+	}
+
 	spin_unlock_bh(&dev->status_list.lock);
 
 	return pid;
@@ -150,25 +182,65 @@ mt76_tx_status_skb_get(struct mt76_dev *dev, struct mt76_wcid *wcid, int pktid,
 		       struct sk_buff_head *list)
 {
 	struct sk_buff *skb, *tmp;
+	struct sk_buff *rvskb = NULL;
 
+	/* If pktid is < first-valid-id, then it is not something we requested
+	 * TXS for, so we will not find SKB.  Bail out early in that case,
+	 * unless we need to walk due to stale-skb-reaper timeout.
+	 */
+	if (pktid < MT_PACKET_ID_FIRST) {
+		if (!time_after(jiffies, dev->next_status_jiffies))
+			return NULL;
+		goto check_list;
+	}
+
+	if (wcid) {
+		lockdep_assert_held(&dev->status_list.lock);
+		if (WARN_ON_ONCE(pktid - MT_PACKET_ID_FIRST
+				 >= ARRAY_SIZE(wcid->skb_status_array))) {
+			dev_err(dev->dev, "invalid pktid: %d  status-array-size: %d\n",
+				pktid, (int)(ARRAY_SIZE(wcid->skb_status_array)));
+			WARN_ON_ONCE(true);
+			goto check_list;
+		}
+
+		skb = wcid->skb_status_array[pktid - MT_PACKET_ID_FIRST];
+
+		if (skb && !time_after(jiffies, dev->next_status_jiffies))
+			return skb;
+	}
+
+check_list:
 	skb_queue_walk_safe(&dev->status_list, skb, tmp) {
 		struct mt76_tx_cb *cb = mt76_tx_skb_cb(skb);
 
 		if (wcid && cb->wcid != wcid->idx)
 			continue;
 
-		if (cb->pktid == pktid)
-			return skb;
+		if (cb->pktid == pktid) {
+			/* Found our skb, but check for timeouts too */
+			rvskb = skb;
+			continue;
+		}
+
+		/* Cannot time out anything that does not have DMA completed. */
+		if (!(cb->flags & MT_TX_CB_DMA_DONE))
+			continue;
 
+		/* Check if it has been too long since DMA_DONE was reported. */
 		if (pktid >= 0 && !time_after(jiffies, cb->jiffies +
 					      MT_TX_STATUS_SKB_TIMEOUT))
 			continue;
 
+		/* It has been too long since DMA_DONE, time out this packet
+		 * and stop waiting for TXS callback.
+		 */
 		__mt76_tx_status_skb_done(dev, skb, MT_TX_CB_TXS_FAILED |
-						    MT_TX_CB_TXS_DONE, list);
+					  MT_TX_CB_TXS_DONE, list, wcid);
 	}
+	dev->next_status_jiffies = jiffies + MT_TX_STATUS_SKB_TIMEOUT + 1;
 
-	return NULL;
+	return rvskb;
 }
 EXPORT_SYMBOL_GPL(mt76_tx_status_skb_get);
 
@@ -238,7 +310,7 @@ void __mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid_idx, struct sk_buff *
 	}
 
 	mt76_tx_status_lock(dev, &list);
-	__mt76_tx_status_skb_done(dev, skb, MT_TX_CB_DMA_DONE, &list);
+	__mt76_tx_status_skb_done(dev, skb, MT_TX_CB_DMA_DONE, &list, wcid);
 	mt76_tx_status_unlock(dev, &list);
 
 out:
-- 
2.20.1

