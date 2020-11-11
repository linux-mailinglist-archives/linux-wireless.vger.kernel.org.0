Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F73D2AF27F
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 14:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgKKNsK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Nov 2020 08:48:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:36092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbgKKNr4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 08:47:56 -0500
Received: from lore-desk.redhat.com (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81C512074B;
        Wed, 11 Nov 2020 13:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605102474;
        bh=0zQTGQRPLmQFHkOPd3l9hRZ6ZhNHB6L6uEWOodNYmoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ruotejzxHjypr+8kZilQTdNTzpehWvpfvTCv9rbc4x+/cdueVpm5yd8CW/1fda3lH
         dP7Dh+Gqz7vQSLmaba3SExgjK5OdjnoM2n4xEHKLi+9KGqKk/6q992LfFrM7r8Rx1q
         8yk5eHIwS3Sh8pvaul3n4pawZXurGBY/8JaDq+nU=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH v2 06/10] mt76: rely on mt76_queue in tx_queue_skb signature
Date:   Wed, 11 Nov 2020 14:47:28 +0100
Message-Id: <c223eb96512fdf80ac19e128001b339ed764b254.1605102251.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605102251.git.lorenzo@kernel.org>
References: <cover.1605102251.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on mt76_queue instead of qid in tx_queue_skb signature.
This is a preliminary patch to move data queues in mt76_phy and add
dbdc support to mt7915 driver

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c      |  5 ++--
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 +-
 .../wireless/mediatek/mt76/mt7603/beacon.c    | 27 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c | 11 ++++----
 drivers/net/wireless/mediatek/mt76/sdio.c     |  5 ++--
 drivers/net/wireless/mediatek/mt76/testmode.c |  3 ++-
 drivers/net/wireless/mediatek/mt76/tx.c       | 22 +++++++--------
 drivers/net/wireless/mediatek/mt76/usb.c      |  7 ++---
 8 files changed, 43 insertions(+), 39 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 31ce7dc7643b..730f01935cfe 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -344,11 +344,10 @@ mt76_dma_tx_queue_skb_raw(struct mt76_dev *dev, enum mt76_txq_id qid,
 }
 
 static int
-mt76_dma_tx_queue_skb(struct mt76_dev *dev, enum mt76_txq_id qid,
+mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 		      struct sk_buff *skb, struct mt76_wcid *wcid,
 		      struct ieee80211_sta *sta)
 {
-	struct mt76_queue *q = dev->q_tx[qid];
 	struct mt76_tx_info tx_info = {
 		.skb = skb,
 	};
@@ -398,7 +397,7 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, enum mt76_txq_id qid,
 
 	dma_sync_single_for_cpu(dev->dev, t->dma_addr, dev->drv->txwi_size,
 				DMA_TO_DEVICE);
-	ret = dev->drv->tx_prepare_skb(dev, txwi, qid, wcid, sta, &tx_info);
+	ret = dev->drv->tx_prepare_skb(dev, txwi, q->qid, wcid, sta, &tx_info);
 	dma_sync_single_for_device(dev->dev, t->dma_addr, dev->drv->txwi_size,
 				   DMA_TO_DEVICE);
 	if (ret < 0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 4e691adb2a2b..ac0886a01aed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -167,7 +167,7 @@ struct mt76_queue_ops {
 		     int idx, int n_desc, int bufsize,
 		     u32 ring_base);
 
-	int (*tx_queue_skb)(struct mt76_dev *dev, enum mt76_txq_id qid,
+	int (*tx_queue_skb)(struct mt76_dev *dev, struct mt76_queue *q,
 			    struct sk_buff *skb, struct mt76_wcid *wcid,
 			    struct ieee80211_sta *sta);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
index 2d2b429c9ffc..c78321ea0a4f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
@@ -13,23 +13,25 @@ static void
 mt7603_update_beacon_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
 	struct mt7603_dev *dev = (struct mt7603_dev *)priv;
+	struct mt76_dev *mdev = &dev->mt76;
 	struct mt7603_vif *mvif = (struct mt7603_vif *)vif->drv_priv;
 	struct sk_buff *skb = NULL;
 
-	if (!(dev->mt76.beacon_mask & BIT(mvif->idx)))
+	if (!(mdev->beacon_mask & BIT(mvif->idx)))
 		return;
 
 	skb = ieee80211_beacon_get(mt76_hw(dev), vif);
 	if (!skb)
 		return;
 
-	mt76_tx_queue_skb(dev, MT_TXQ_BEACON, skb, &mvif->sta.wcid, NULL);
+	mt76_tx_queue_skb(dev, mdev->q_tx[MT_TXQ_BEACON], skb,
+			  &mvif->sta.wcid, NULL);
 
 	spin_lock_bh(&dev->ps_lock);
 	mt76_wr(dev, MT_DMA_FQCR0, MT_DMA_FQCR0_BUSY |
 		FIELD_PREP(MT_DMA_FQCR0_TARGET_WCID, mvif->sta.wcid.idx) |
 		FIELD_PREP(MT_DMA_FQCR0_TARGET_QID,
-			   dev->mt76.q_tx[MT_TXQ_CAB]->hw_idx) |
+			   mdev->q_tx[MT_TXQ_CAB]->hw_idx) |
 		FIELD_PREP(MT_DMA_FQCR0_DEST_PORT_ID, 3) |
 		FIELD_PREP(MT_DMA_FQCR0_DEST_QUEUE_ID, 8));
 
@@ -67,6 +69,7 @@ mt7603_add_buffered_bc(void *priv, u8 *mac, struct ieee80211_vif *vif)
 void mt7603_pre_tbtt_tasklet(struct tasklet_struct *t)
 {
 	struct mt7603_dev *dev = from_tasklet(dev, t, mt76.pre_tbtt_tasklet);
+	struct mt76_dev *mdev = &dev->mt76;
 	struct mt76_queue *q;
 	struct beacon_bc_data data = {};
 	struct sk_buff *skb;
@@ -78,7 +81,7 @@ void mt7603_pre_tbtt_tasklet(struct tasklet_struct *t)
 	data.dev = dev;
 	__skb_queue_head_init(&data.q);
 
-	q = dev->mt76.q_tx[MT_TXQ_BEACON];
+	q = mdev->q_tx[MT_TXQ_BEACON];
 	spin_lock_bh(&q->lock);
 	ieee80211_iterate_active_interfaces_atomic(mt76_hw(dev),
 		IEEE80211_IFACE_ITER_RESUME_ALL,
@@ -89,13 +92,13 @@ void mt7603_pre_tbtt_tasklet(struct tasklet_struct *t)
 	/* Flush all previous CAB queue packets */
 	mt76_wr(dev, MT_WF_ARB_CAB_FLUSH, GENMASK(30, 16) | BIT(0));
 
-	mt76_queue_tx_cleanup(dev, dev->mt76.q_tx[MT_TXQ_CAB], false);
+	mt76_queue_tx_cleanup(dev, mdev->q_tx[MT_TXQ_CAB], false);
 
-	mt76_csa_check(&dev->mt76);
-	if (dev->mt76.csa_complete)
+	mt76_csa_check(mdev);
+	if (mdev->csa_complete)
 		goto out;
 
-	q = dev->mt76.q_tx[MT_TXQ_CAB];
+	q = mdev->q_tx[MT_TXQ_CAB];
 	do {
 		nframes = skb_queue_len(&data.q);
 		ieee80211_iterate_active_interfaces_atomic(mt76_hw(dev),
@@ -120,7 +123,8 @@ void mt7603_pre_tbtt_tasklet(struct tasklet_struct *t)
 		struct ieee80211_vif *vif = info->control.vif;
 		struct mt7603_vif *mvif = (struct mt7603_vif *)vif->drv_priv;
 
-		mt76_tx_queue_skb(dev, MT_TXQ_CAB, skb, &mvif->sta.wcid, NULL);
+		mt76_tx_queue_skb(dev, mdev->q_tx[MT_TXQ_CAB], skb,
+				  &mvif->sta.wcid, NULL);
 	}
 	mt76_queue_kick(dev, q);
 	spin_unlock_bh(&q->lock);
@@ -135,9 +139,8 @@ void mt7603_pre_tbtt_tasklet(struct tasklet_struct *t)
 		 ((1 << (MT7603_MAX_INTERFACES - 1)) - 1)));
 
 out:
-	mt76_queue_tx_cleanup(dev, dev->mt76.q_tx[MT_TXQ_BEACON], false);
-	if (dev->mt76.q_tx[MT_TXQ_BEACON]->queued >
-	    hweight8(dev->mt76.beacon_mask))
+	mt76_queue_tx_cleanup(dev, mdev->q_tx[MT_TXQ_BEACON], false);
+	if (mdev->q_tx[MT_TXQ_BEACON]->queued > hweight8(mdev->beacon_mask))
 		dev->beacon_check++;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index e610544971a6..8b0e2a4bdf30 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -14,7 +14,8 @@
 static void mt76x02_pre_tbtt_tasklet(struct tasklet_struct *t)
 {
 	struct mt76x02_dev *dev = from_tasklet(dev, t, mt76.pre_tbtt_tasklet);
-	struct mt76_queue *q = dev->mt76.q_tx[MT_TXQ_PSD];
+	struct mt76_dev *mdev = &dev->mt76;
+	struct mt76_queue *q = mdev->q_tx[MT_TXQ_PSD];
 	struct beacon_bc_data data = {};
 	struct sk_buff *skb;
 	int i;
@@ -35,9 +36,9 @@ static void mt76x02_pre_tbtt_tasklet(struct tasklet_struct *t)
 	mt76_wr(dev, MT_BCN_BYPASS_MASK,
 		0xff00 | ~(0xff00 >> dev->beacon_data_count));
 
-	mt76_csa_check(&dev->mt76);
+	mt76_csa_check(mdev);
 
-	if (dev->mt76.csa_complete)
+	if (mdev->csa_complete)
 		return;
 
 	mt76x02_enqueue_buffered_bc(dev, &data, 8);
@@ -58,8 +59,8 @@ static void mt76x02_pre_tbtt_tasklet(struct tasklet_struct *t)
 		struct ieee80211_vif *vif = info->control.vif;
 		struct mt76x02_vif *mvif = (struct mt76x02_vif *)vif->drv_priv;
 
-		mt76_tx_queue_skb(dev, MT_TXQ_PSD, skb, &mvif->group_wcid,
-				  NULL);
+		mt76_tx_queue_skb(dev, mdev->q_tx[MT_TXQ_PSD], skb,
+				  &mvif->group_wcid, NULL);
 	}
 	spin_unlock_bh(&q->lock);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index ddd454d628aa..b1bc459a721d 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -239,11 +239,10 @@ static void mt76s_tx_status_data(struct work_struct *work)
 }
 
 static int
-mt76s_tx_queue_skb(struct mt76_dev *dev, enum mt76_txq_id qid,
+mt76s_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 		   struct sk_buff *skb, struct mt76_wcid *wcid,
 		   struct ieee80211_sta *sta)
 {
-	struct mt76_queue *q = dev->q_tx[qid];
 	struct mt76_tx_info tx_info = {
 		.skb = skb,
 	};
@@ -254,7 +253,7 @@ mt76s_tx_queue_skb(struct mt76_dev *dev, enum mt76_txq_id qid,
 		return -ENOSPC;
 
 	skb->prev = skb->next = NULL;
-	err = dev->drv->tx_prepare_skb(dev, NULL, qid, wcid, sta, &tx_info);
+	err = dev->drv->tx_prepare_skb(dev, NULL, q->qid, wcid, sta, &tx_info);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/wireless/mediatek/mt76/testmode.c
index d1b171697e28..733c396eb3d2 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/testmode.c
@@ -39,7 +39,8 @@ void mt76_testmode_tx_pending(struct mt76_dev *dev)
 	       q->queued < q->ndesc / 2) {
 		int ret;
 
-		ret = dev->queue_ops->tx_queue_skb(dev, qid, skb_get(skb), wcid, NULL);
+		ret = dev->queue_ops->tx_queue_skb(dev, q, skb_get(skb), wcid,
+						   NULL);
 		if (ret < 0)
 			break;
 
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 73624700fe44..844d04503102 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -225,23 +225,23 @@ void mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid_idx, struct sk_buff *sk
 EXPORT_SYMBOL_GPL(mt76_tx_complete_skb);
 
 static int
-__mt76_tx_queue_skb(struct mt76_dev *dev, int qid, struct sk_buff *skb,
+__mt76_tx_queue_skb(struct mt76_phy *phy, int qid, struct sk_buff *skb,
 		    struct mt76_wcid *wcid, struct ieee80211_sta *sta,
 		    bool *stop)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	struct mt76_queue *q;
+	struct mt76_dev *dev = phy->dev;
+	struct mt76_queue *q = dev->q_tx[qid];
 	bool non_aql;
 	int pending;
 	int idx;
 
 	non_aql = !info->tx_time_est;
-	idx = dev->queue_ops->tx_queue_skb(dev, qid, skb, wcid, sta);
+	idx = dev->queue_ops->tx_queue_skb(dev, q, skb, wcid, sta);
 	if (idx < 0 || !sta || !non_aql)
 		return idx;
 
 	wcid = (struct mt76_wcid *)sta->drv_priv;
-	q = dev->q_tx[qid];
 	q->entry[idx].wcid = wcid->idx;
 	pending = atomic_inc_return(&wcid->non_aql_packets);
 	if (stop && pending >= MT_MAX_NON_AQL_PKT)
@@ -289,7 +289,7 @@ mt76_tx(struct mt76_phy *phy, struct ieee80211_sta *sta,
 	q = dev->q_tx[qid];
 
 	spin_lock_bh(&q->lock);
-	__mt76_tx_queue_skb(dev, qid, skb, wcid, sta, NULL);
+	__mt76_tx_queue_skb(phy, qid, skb, wcid, sta, NULL);
 	dev->queue_ops->kick(dev, q);
 
 	if (q->queued > q->ndesc - 8 && !q->stopped) {
@@ -321,7 +321,7 @@ mt76_txq_dequeue(struct mt76_phy *phy, struct mt76_txq *mtxq)
 }
 
 static void
-mt76_queue_ps_skb(struct mt76_dev *dev, struct ieee80211_sta *sta,
+mt76_queue_ps_skb(struct mt76_phy *phy, struct ieee80211_sta *sta,
 		  struct sk_buff *skb, bool last)
 {
 	struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
@@ -333,7 +333,7 @@ mt76_queue_ps_skb(struct mt76_dev *dev, struct ieee80211_sta *sta,
 			       IEEE80211_TX_CTL_REQ_TX_STATUS;
 
 	mt76_skb_set_moredata(skb, !last);
-	__mt76_tx_queue_skb(dev, MT_TXQ_PSD, skb, wcid, sta, NULL);
+	__mt76_tx_queue_skb(phy, MT_TXQ_PSD, skb, wcid, sta, NULL);
 }
 
 void
@@ -364,14 +364,14 @@ mt76_release_buffered_frames(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 
 			nframes--;
 			if (last_skb)
-				mt76_queue_ps_skb(dev, sta, last_skb, false);
+				mt76_queue_ps_skb(phy, sta, last_skb, false);
 
 			last_skb = skb;
 		} while (nframes);
 	}
 
 	if (last_skb) {
-		mt76_queue_ps_skb(dev, sta, last_skb, true);
+		mt76_queue_ps_skb(phy, sta, last_skb, true);
 		dev->queue_ops->kick(dev, hwq);
 	} else {
 		ieee80211_sta_eosp(sta);
@@ -410,7 +410,7 @@ mt76_txq_send_burst(struct mt76_phy *phy, struct mt76_queue *q,
 		ieee80211_get_tx_rates(txq->vif, txq->sta, skb,
 				       info->control.rates, 1);
 
-	idx = __mt76_tx_queue_skb(dev, qid, skb, wcid, txq->sta, &stop);
+	idx = __mt76_tx_queue_skb(phy, qid, skb, wcid, txq->sta, &stop);
 	if (idx < 0)
 		return idx;
 
@@ -434,7 +434,7 @@ mt76_txq_send_burst(struct mt76_phy *phy, struct mt76_queue *q,
 			ieee80211_get_tx_rates(txq->vif, txq->sta, skb,
 					       info->control.rates, 1);
 
-		idx = __mt76_tx_queue_skb(dev, qid, skb, wcid, txq->sta, &stop);
+		idx = __mt76_tx_queue_skb(phy, qid, skb, wcid, txq->sta, &stop);
 		if (idx < 0)
 			break;
 
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 7396bdae6db0..6b27b01245ed 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -901,11 +901,10 @@ mt76u_tx_setup_buffers(struct mt76_dev *dev, struct sk_buff *skb,
 }
 
 static int
-mt76u_tx_queue_skb(struct mt76_dev *dev, enum mt76_txq_id qid,
+mt76u_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 		   struct sk_buff *skb, struct mt76_wcid *wcid,
 		   struct ieee80211_sta *sta)
 {
-	struct mt76_queue *q = dev->q_tx[qid];
 	struct mt76_tx_info tx_info = {
 		.skb = skb,
 	};
@@ -916,7 +915,7 @@ mt76u_tx_queue_skb(struct mt76_dev *dev, enum mt76_txq_id qid,
 		return -ENOSPC;
 
 	skb->prev = skb->next = NULL;
-	err = dev->drv->tx_prepare_skb(dev, NULL, qid, wcid, sta, &tx_info);
+	err = dev->drv->tx_prepare_skb(dev, NULL, q->qid, wcid, sta, &tx_info);
 	if (err < 0)
 		return err;
 
@@ -994,6 +993,8 @@ static int mt76u_alloc_tx(struct mt76_dev *dev)
 
 		spin_lock_init(&q->lock);
 		q->hw_idx = mt76u_ac_to_hwq(dev, i);
+		q->qid = i;
+
 		dev->q_tx[i] = q;
 
 		q->entry = devm_kcalloc(dev->dev,
-- 
2.26.2

