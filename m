Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA2D2AE3D8
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 00:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732341AbgKJXDm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 18:03:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:56606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730254AbgKJXDk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 18:03:40 -0500
Received: from lore-desk.redhat.com (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE07220679;
        Tue, 10 Nov 2020 23:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605049418;
        bh=9rPpdiwf6UcjWoUh+zWZ3UKHnVcGUKhgNAdjGXWzfxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hi8H501fDRYtWy3fS/X3OKewlIRZs4xcDBwvE1NwH6fu+Vn/k2vD6kQ6rxrmVH5e1
         5iNibiQCUJJDhDZg8yiKObkTHNOy70ACWyqa7bMePL2wp4L5NvwtKdS0MFCXguXyeI
         hgQqjRz9nMzRR6ju4z3w+bC2UgBS4ekPrNwrxc1g=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH 10/10] mt76: move tx hw data queues in mt76_phy
Date:   Wed, 11 Nov 2020 00:03:00 +0100
Message-Id: <079a83d73878646d57e031902c9cc48ec645adc2.1605048763.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605048763.git.lorenzo@kernel.org>
References: <cover.1605048763.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move hw data queues in mt76_phy from mt76_dev since mt7915 supports per
phy hw queues in dbdc mode

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/debugfs.c       |  4 ++--
 drivers/net/wireless/mediatek/mt76/dma.c           | 10 +++++++---
 drivers/net/wireless/mediatek/mt76/mac80211.c      |  7 ++-----
 drivers/net/wireless/mediatek/mt76/mt76.h          |  7 ++++---
 drivers/net/wireless/mediatek/mt76/mt7603/beacon.c | 13 +++++++------
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c    |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c    |  8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7603/main.c   |  6 +++---
 .../net/wireless/mediatek/mt76/mt7615/debugfs.c    |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c    |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/init.c   |  6 +++++-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c    |  8 ++++----
 .../net/wireless/mediatek/mt76/mt7615/sdio_txrx.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c  | 12 ++++++------
 .../net/wireless/mediatek/mt76/mt76x02_usb_core.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c  |  4 ++--
 .../net/wireless/mediatek/mt76/mt7915/debugfs.c    |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c    |  8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    | 11 ++++++-----
 drivers/net/wireless/mediatek/mt76/sdio.c          |  7 ++++---
 drivers/net/wireless/mediatek/mt76/testmode.c      |  7 ++++---
 drivers/net/wireless/mediatek/mt76/tx.c            | 14 ++++++--------
 drivers/net/wireless/mediatek/mt76/usb.c           | 14 +++++++-------
 23 files changed, 85 insertions(+), 77 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/debugfs.c b/drivers/net/wireless/mediatek/mt76/debugfs.c
index 52f583cb1418..d4a6b8108971 100644
--- a/drivers/net/wireless/mediatek/mt76/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
@@ -30,8 +30,8 @@ int mt76_queues_read(struct seq_file *s, void *data)
 	struct mt76_dev *dev = dev_get_drvdata(s->private);
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(dev->q_tx); i++) {
-		struct mt76_queue *q = dev->q_tx[i];
+	for (i = 0; i < ARRAY_SIZE(dev->phy.q_tx); i++) {
+		struct mt76_queue *q = dev->phy.q_tx[i];
 
 		if (!q)
 			continue;
diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 20b293cf28a4..de07522750db 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -348,8 +348,8 @@ mt76_dma_tx_queue_skb(struct mt76_phy *phy, enum mt76_txq_id qid,
 		      struct sk_buff *skb, struct mt76_wcid *wcid,
 		      struct ieee80211_sta *sta)
 {
+	struct mt76_queue *q = phy->q_tx[qid];
 	struct mt76_dev *dev = phy->dev;
-	struct mt76_queue *q = dev->q_tx[qid];
 	struct mt76_tx_info tx_info = {
 		.skb = skb,
 	};
@@ -664,8 +664,12 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
 	mt76_worker_disable(&dev->tx_worker);
 	netif_napi_del(&dev->tx_napi);
 
-	for (i = 0; i < ARRAY_SIZE(dev->q_tx); i++)
-		mt76_dma_tx_cleanup(&dev->phy, dev->q_tx[i], true);
+	for (i = 0; i < ARRAY_SIZE(dev->phy.q_tx); i++) {
+		mt76_dma_tx_cleanup(&dev->phy, dev->phy.q_tx[i], true);
+		if (dev->phy2)
+			mt76_dma_tx_cleanup(dev->phy2, dev->phy2->q_tx[i],
+					    true);
+	}
 	for (i = 0; i < ARRAY_SIZE(dev->q_mcu); i++)
 		mt76_dma_tx_cleanup(&dev->phy, dev->q_mcu[i], true);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 6dcd902efb3d..0fc090283f80 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -539,14 +539,11 @@ EXPORT_SYMBOL_GPL(mt76_rx);
 
 bool mt76_has_tx_pending(struct mt76_phy *phy)
 {
-	struct mt76_dev *dev = phy->dev;
 	struct mt76_queue *q;
-	int i, offset;
-
-	offset = __MT_TXQ_MAX * (phy != &dev->phy);
+	int i;
 
 	for (i = 0; i < __MT_TXQ_MAX; i++) {
-		q = dev->q_tx[offset + i];
+		q = phy->q_tx[i];
 		if (q && q->queued)
 			return true;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 87c12d3e78c5..fc3130d02fb5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -561,6 +561,8 @@ struct mt76_phy {
 
 	unsigned long state;
 
+	struct mt76_queue *q_tx[__MT_TXQ_MAX];
+
 	struct cfg80211_chan_def chandef;
 	struct ieee80211_channel *main_chan;
 
@@ -607,7 +609,6 @@ struct mt76_dev {
 	struct sk_buff_head rx_skb[__MT_RXQ_MAX];
 
 	struct list_head txwi_cache;
-	struct mt76_queue *q_tx[2 * __MT_TXQ_MAX];
 	struct mt76_queue *q_mcu[__MT_MCUQ_MAX];
 	struct mt76_queue q_rx[__MT_RXQ_MAX];
 	const struct mt76_queue_ops *queue_ops;
@@ -798,7 +799,7 @@ static inline int mt76_init_tx_queue(struct mt76_phy *phy, int qid, int idx,
 		return PTR_ERR(q);
 
 	q->qid = qid;
-	phy->dev->q_tx[qid] = q;
+	phy->q_tx[qid] = q;
 
 	return 0;
 }
@@ -939,7 +940,7 @@ void mt76_rx(struct mt76_dev *dev, enum mt76_rxq_id q, struct sk_buff *skb);
 void mt76_tx(struct mt76_phy *dev, struct ieee80211_sta *sta,
 	     struct mt76_wcid *wcid, struct sk_buff *skb);
 void mt76_wake_tx_queue(struct ieee80211_hw *hw, struct ieee80211_txq *txq);
-void mt76_stop_tx_queues(struct mt76_dev *dev, struct ieee80211_sta *sta,
+void mt76_stop_tx_queues(struct mt76_phy *phy, struct ieee80211_sta *sta,
 			 bool send_bar);
 void mt76_tx_check_agg_ssn(struct ieee80211_sta *sta, struct sk_buff *skb);
 void mt76_txq_schedule(struct mt76_phy *phy, enum mt76_txq_id qid);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
index 66300311257d..460dc3cf1f43 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
@@ -31,7 +31,7 @@ mt7603_update_beacon_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	mt76_wr(dev, MT_DMA_FQCR0, MT_DMA_FQCR0_BUSY |
 		FIELD_PREP(MT_DMA_FQCR0_TARGET_WCID, mvif->sta.wcid.idx) |
 		FIELD_PREP(MT_DMA_FQCR0_TARGET_QID,
-			   mdev->q_tx[MT_TXQ_CAB]->hw_idx) |
+			   dev->mphy.q_tx[MT_TXQ_CAB]->hw_idx) |
 		FIELD_PREP(MT_DMA_FQCR0_DEST_PORT_ID, 3) |
 		FIELD_PREP(MT_DMA_FQCR0_DEST_QUEUE_ID, 8));
 
@@ -81,7 +81,7 @@ void mt7603_pre_tbtt_tasklet(struct tasklet_struct *t)
 	data.dev = dev;
 	__skb_queue_head_init(&data.q);
 
-	q = mdev->q_tx[MT_TXQ_BEACON];
+	q = dev->mphy.q_tx[MT_TXQ_BEACON];
 	spin_lock_bh(&q->lock);
 	ieee80211_iterate_active_interfaces_atomic(mt76_hw(dev),
 		IEEE80211_IFACE_ITER_RESUME_ALL,
@@ -92,13 +92,13 @@ void mt7603_pre_tbtt_tasklet(struct tasklet_struct *t)
 	/* Flush all previous CAB queue packets */
 	mt76_wr(dev, MT_WF_ARB_CAB_FLUSH, GENMASK(30, 16) | BIT(0));
 
-	__mt76_queue_tx_cleanup(&dev->mphy, mdev->q_tx[MT_TXQ_CAB], false);
+	__mt76_queue_tx_cleanup(&dev->mphy, dev->mphy.q_tx[MT_TXQ_CAB], false);
 
 	mt76_csa_check(mdev);
 	if (mdev->csa_complete)
 		goto out;
 
-	q = mdev->q_tx[MT_TXQ_CAB];
+	q = dev->mphy.q_tx[MT_TXQ_CAB];
 	do {
 		nframes = skb_queue_len(&data.q);
 		ieee80211_iterate_active_interfaces_atomic(mt76_hw(dev),
@@ -139,8 +139,9 @@ void mt7603_pre_tbtt_tasklet(struct tasklet_struct *t)
 		 ((1 << (MT7603_MAX_INTERFACES - 1)) - 1)));
 
 out:
-	__mt76_queue_tx_cleanup(&dev->mphy, mdev->q_tx[MT_TXQ_BEACON], false);
-	if (mdev->q_tx[MT_TXQ_BEACON]->queued > hweight8(mdev->beacon_mask))
+	__mt76_queue_tx_cleanup(&dev->mphy, dev->mphy.q_tx[MT_TXQ_BEACON],
+				false);
+	if (dev->mphy.q_tx[MT_TXQ_BEACON]->queued > hweight8(mdev->beacon_mask))
 		dev->beacon_check++;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index 56085b016cfc..5fef7187a27e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -134,7 +134,7 @@ static int mt7603_poll_tx(struct napi_struct *napi, int budget)
 	__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_mcu[MT_MCUQ_WM],
 				false);
 	for (i = MT_TXQ_PSD; i >= 0; i--)
-		__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_tx[i], false);
+		__mt76_queue_tx_cleanup(&dev->mphy, dev->mphy.q_tx[i], false);
 
 	if (napi_complete_done(napi, 0))
 		mt7603_irq_enable(dev, MT_INT_TX_DONE_ALL);
@@ -142,7 +142,7 @@ static int mt7603_poll_tx(struct napi_struct *napi, int budget)
 	__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_mcu[MT_MCUQ_WM],
 				false);
 	for (i = MT_TXQ_PSD; i >= 0; i--)
-		__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_tx[i], false);
+		__mt76_queue_tx_cleanup(&dev->mphy, dev->mphy.q_tx[i], false);
 
 	mt7603_mac_sta_poll(dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 47aee2391077..92126e0beb06 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -445,7 +445,7 @@ void mt7603_mac_sta_poll(struct mt7603_dev *dev)
 
 		sta = container_of((void *)msta, struct ieee80211_sta, drv_priv);
 		for (i = 0; i < 4; i++) {
-			struct mt76_queue *q = dev->mt76.q_tx[i];
+			struct mt76_queue *q = dev->mphy.q_tx[i];
 			u8 qidx = q->hw_idx;
 			u8 tid = ac_to_tid[i];
 			u32 txtime = airtime[qidx];
@@ -896,7 +896,7 @@ mt7603_mac_write_txwi(struct mt7603_dev *dev, __le32 *txwi,
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_bar *bar = (struct ieee80211_bar *)skb->data;
 	struct ieee80211_vif *vif = info->control.vif;
-	struct mt76_queue *q = dev->mt76.q_tx[qid];
+	struct mt76_queue *q = dev->mphy.q_tx[qid];
 	struct mt7603_vif *mvif;
 	int wlan_idx;
 	int hdr_len = ieee80211_get_hdrlen_from_skb(skb);
@@ -1436,7 +1436,7 @@ static void mt7603_mac_watchdog_reset(struct mt7603_dev *dev)
 
 	__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_mcu[MT_MCUQ_WM], true);
 	for (i = 0; i < __MT_TXQ_MAX; i++)
-		__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_tx[i], true);
+		__mt76_queue_tx_cleanup(&dev->mphy, dev->mphy.q_tx[i], true);
 
 	mt76_for_each_q_rx(&dev->mt76, i) {
 		mt76_queue_rx_reset(dev, i);
@@ -1515,7 +1515,7 @@ static bool mt7603_tx_hang(struct mt7603_dev *dev)
 	int i;
 
 	for (i = 0; i < 4; i++) {
-		q = dev->mt76.q_tx[i];
+		q = dev->mphy.q_tx[i];
 
 		if (!q->queued)
 			continue;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 64b259123001..6d47b57cbc39 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -383,7 +383,7 @@ mt7603_ps_tx_list(struct mt7603_dev *dev, struct sk_buff_head *list)
 	while ((skb = __skb_dequeue(list)) != NULL) {
 		int qid = skb_get_queue_mapping(skb);
 
-		mt76_tx_queue_skb_raw(dev, dev->mt76.q_tx[qid], skb, 0);
+		mt76_tx_queue_skb_raw(dev, dev->mphy.q_tx[qid], skb, 0);
 	}
 }
 
@@ -394,7 +394,7 @@ mt7603_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps)
 	struct mt7603_sta *msta = (struct mt7603_sta *)sta->drv_priv;
 	struct sk_buff_head list;
 
-	mt76_stop_tx_queues(&dev->mt76, sta, true);
+	mt76_stop_tx_queues(&dev->mphy, sta, true);
 	mt7603_wtbl_set_ps(dev, msta, ps);
 	if (ps)
 		return;
@@ -514,7 +514,7 @@ mt7603_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif, u16 queue,
 	u16 cw_max = (1 << 10) - 1;
 	u32 val;
 
-	queue = dev->mt76.q_tx[queue]->hw_idx;
+	queue = dev->mphy.q_tx[queue]->hw_idx;
 
 	if (params->cw_min)
 		cw_min = params->cw_min;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index c3a52467095d..4d5e3f8b2a62 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -187,7 +187,7 @@ mt7615_reset_test_set(void *data, u64 val)
 	skb_put(skb, 1);
 
 	mt7615_mutex_acquire(dev);
-	mt76_tx_queue_skb_raw(dev, dev->mt76.q_tx[0], skb, 0);
+	mt76_tx_queue_skb_raw(dev, dev->mphy.q_tx[0], skb, 0);
 	mt7615_mutex_release(dev);
 
 	return 0;
@@ -336,7 +336,7 @@ mt7615_queues_read(struct seq_file *s, void *data)
 		struct mt76_queue *q;
 		char *queue;
 	} queue_map[] = {
-		{ dev->mt76.q_tx[MT_TXQ_BE], "PDMA0" },
+		{ dev->mphy.q_tx[MT_TXQ_BE], "PDMA0" },
 		{ dev->mt76.q_mcu[MT_MCUQ_WM], "MCUQ" },
 		{ dev->mt76.q_mcu[MT_MCUQ_FWDL], "MCUFWQ" },
 	};
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index 9a43f14fb199..c25c0df5c8e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -60,7 +60,7 @@ mt7615_init_tx_queues(struct mt7615_dev *dev)
 		return ret;
 
 	for (i = 1; i <= MT_TXQ_PSD ; i++)
-		dev->mt76.q_tx[i] = dev->mt76.q_tx[0];
+		dev->mphy.q_tx[i] = dev->mphy.q_tx[0];
 
 	return mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_WM, MT7615_TXQ_MCU,
 				   MT7615_TX_MCU_RING_SIZE, MT_TX_RING_BASE);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index e470a75365f8..4ba52848cc61 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -385,7 +385,7 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 {
 	struct mt7615_phy *phy = mt7615_ext_phy(dev);
 	struct mt76_phy *mphy;
-	int ret;
+	int i, ret;
 
 	if (!is_mt7615(&dev->mt76))
 		return -EOPNOTSUPP;
@@ -429,6 +429,10 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 	mphy->sband_2g.sband.n_channels = 0;
 	mphy->hw->wiphy->bands[NL80211_BAND_2GHZ] = NULL;
 
+	/* mt7615 second phy shares the same hw queues with the primary one */
+	for (i = 0; i <= MT_TXQ_PSD ; i++)
+		mphy->q_tx[i] = dev->mphy.q_tx[i];
+
 	ret = mt76_register_phy(mphy);
 	if (ret)
 		ieee80211_free_hw(mphy->hw);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index db1bad9d5ea4..f2fee0a734e7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1435,13 +1435,13 @@ static void mt7615_mac_tx_free(struct mt7615_dev *dev, struct sk_buff *skb)
 	struct mt7615_tx_free *free = (struct mt7615_tx_free *)skb->data;
 	u8 i, count;
 
-	__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_tx[MT_TXQ_PSD], false);
+	__mt76_queue_tx_cleanup(&dev->mphy, dev->mphy.q_tx[MT_TXQ_PSD], false);
 	if (is_mt7615(&dev->mt76)) {
-		__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_tx[MT_TXQ_BE],
+		__mt76_queue_tx_cleanup(&dev->mphy, dev->mphy.q_tx[MT_TXQ_BE],
 					false);
 	} else {
 		for (i = 0; i < IEEE80211_NUM_ACS; i++)
-			__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_tx[i],
+			__mt76_queue_tx_cleanup(&dev->mphy, dev->mphy.q_tx[i],
 						false);
 	}
 
@@ -2048,7 +2048,7 @@ void mt7615_dma_reset(struct mt7615_dev *dev)
 
 	__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_mcu[MT_MCUQ_WM], true);
 	for (i = 0; i < __MT_TXQ_MAX; i++)
-		__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_tx[i], true);
+		__mt76_queue_tx_cleanup(&dev->mphy, dev->mphy.q_tx[i], true);
 
 	mt76_for_each_q_rx(&dev->mt76, i) {
 		mt76_queue_rx_reset(dev, i);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
index 9cd33dd8b20c..13d77f8fca86 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
@@ -287,7 +287,7 @@ void mt7663s_txrx_worker(struct mt76_worker *w)
 
 		/* tx */
 		for (i = 0; i <= MT_TXQ_PSD; i++) {
-			ret = mt7663s_tx_run_queue(dev, dev->q_tx[i]);
+			ret = mt7663s_tx_run_queue(dev, dev->phy.q_tx[i]);
 			if (ret > 0)
 				nframes += ret;
 		}
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 606d1da68f61..7e8f32c49632 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -15,7 +15,7 @@ static void mt76x02_pre_tbtt_tasklet(struct tasklet_struct *t)
 {
 	struct mt76x02_dev *dev = from_tasklet(dev, t, mt76.pre_tbtt_tasklet);
 	struct mt76_dev *mdev = &dev->mt76;
-	struct mt76_queue *q = mdev->q_tx[MT_TXQ_PSD];
+	struct mt76_queue *q = dev->mphy.q_tx[MT_TXQ_PSD];
 	struct beacon_bc_data data = {};
 	struct sk_buff *skb;
 	int i;
@@ -152,7 +152,7 @@ static int mt76x02_poll_tx(struct napi_struct *napi, int budget)
 	__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_mcu[MT_MCUQ_WM],
 				false);
 	for (i = MT_TXQ_PSD; i >= 0; i--)
-		__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_tx[i], false);
+		__mt76_queue_tx_cleanup(&dev->mphy, dev->mphy.q_tx[i], false);
 
 	if (napi_complete_done(napi, 0))
 		mt76x02_irq_enable(dev, MT_INT_TX_DONE_ALL);
@@ -160,7 +160,7 @@ static int mt76x02_poll_tx(struct napi_struct *napi, int budget)
 	__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_mcu[MT_MCUQ_WM],
 				false);
 	for (i = MT_TXQ_PSD; i >= 0; i--)
-		__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_tx[i], false);
+		__mt76_queue_tx_cleanup(&dev->mphy, dev->mphy.q_tx[i], false);
 
 	mt76_worker_schedule(&dev->mt76.tx_worker);
 
@@ -284,7 +284,7 @@ irqreturn_t mt76x02_irq_handler(int irq, void *dev_instance)
 		if (dev->mt76.csa_complete)
 			mt76_csa_finish(&dev->mt76);
 		else
-			mt76_queue_kick(dev, dev->mt76.q_tx[MT_TXQ_PSD]);
+			mt76_queue_kick(dev, dev->mphy.q_tx[MT_TXQ_PSD]);
 	}
 
 	if (intr & MT_INT_TX_STAT)
@@ -349,7 +349,7 @@ static bool mt76x02_tx_hang(struct mt76x02_dev *dev)
 	int i;
 
 	for (i = 0; i < 4; i++) {
-		q = dev->mt76.q_tx[i];
+		q = dev->mphy.q_tx[i];
 
 		if (!q->queued)
 			continue;
@@ -469,7 +469,7 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 
 	__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_mcu[MT_MCUQ_WM], true);
 	for (i = 0; i < __MT_TXQ_MAX; i++)
-		__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_tx[i], true);
+		__mt76_queue_tx_cleanup(&dev->mphy, dev->mphy.q_tx[i], true);
 
 	mt76_for_each_q_rx(&dev->mt76, i) {
 		mt76_queue_rx_reset(dev, i);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index 2c2f56112b57..efd70ddc2fd1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -67,7 +67,7 @@ int mt76x02u_tx_prepare_skb(struct mt76_dev *mdev, void *data,
 			    struct mt76_tx_info *tx_info)
 {
 	struct mt76x02_dev *dev = container_of(mdev, struct mt76x02_dev, mt76);
-	int pid, len = tx_info->skb->len, ep = q2ep(mdev->q_tx[qid]->hw_idx);
+	int pid, len = tx_info->skb->len, ep = q2ep(dev->mphy.q_tx[qid]->hw_idx);
 	struct mt76x02_txwi *txwi;
 	bool ampdu = IEEE80211_SKB_CB(tx_info->skb)->flags & IEEE80211_TX_CTL_AMPDU;
 	enum mt76_qsel qsel;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index ea31650a01b8..86c1b545f363 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -488,7 +488,7 @@ int mt76x02_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	u8 cw_min = 5, cw_max = 10, qid;
 	u32 val;
 
-	qid = dev->mt76.q_tx[queue]->hw_idx;
+	qid = dev->mphy.q_tx[queue]->hw_idx;
 
 	if (params->cw_min)
 		cw_min = fls(params->cw_min);
@@ -622,7 +622,7 @@ void mt76x02_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta,
 	struct mt76x02_sta *msta = (struct mt76x02_sta *)sta->drv_priv;
 	int idx = msta->wcid.idx;
 
-	mt76_stop_tx_queues(&dev->mt76, sta, true);
+	mt76_stop_tx_queues(&dev->mphy, sta, true);
 	if (mt76_is_mmio(mdev))
 		mt76x02_mac_wcid_set_drop(dev, idx, ps);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index ac2c5997b22f..551246ac931f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -284,7 +284,7 @@ mt7915_queues_read(struct seq_file *s, void *data)
 		struct mt76_queue *q;
 		char *queue;
 	} queue_map[] = {
-		{ dev->mt76.q_tx[MT_TXQ_BE], "WFDMA0" },
+		{ dev->mphy.q_tx[MT_TXQ_BE], "WFDMA0" },
 		{ dev->mt76.q_mcu[MT_MCUQ_WM], "MCUWM" },
 		{ dev->mt76.q_mcu[MT_MCUQ_WA], "MCUWA" },
 		{ dev->mt76.q_mcu[MT_MCUQ_FWDL], "MCUFWQ" },
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index e6ded7916a9f..3d80dd974825 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -6,16 +6,16 @@
 #include "mac.h"
 
 static int
-mt7915_init_tx_queues(struct mt7915_dev *dev, int idx, int n_desc)
+mt7915_init_tx_queues(struct mt7915_phy *phy, int idx, int n_desc)
 {
 	int i, err;
 
-	err = mt76_init_tx_queue(&dev->mphy, 0, idx, n_desc, MT_TX_RING_BASE);
+	err = mt76_init_tx_queue(phy->mt76, 0, idx, n_desc, MT_TX_RING_BASE);
 	if (err < 0)
 		return err;
 
 	for (i = 0; i <= MT_TXQ_PSD; i++)
-		dev->mt76.q_tx[i] = dev->mt76.q_tx[0];
+		phy->mt76->q_tx[i] = phy->mt76->q_tx[0];
 
 	return 0;
 }
@@ -239,7 +239,7 @@ int mt7915_dma_init(struct mt7915_dev *dev)
 	mt76_wr(dev, MT_WFDMA1_PRI_DLY_INT_CFG0, 0);
 
 	/* init tx queue */
-	ret = mt7915_init_tx_queues(dev, MT7915_TXQ_BAND0,
+	ret = mt7915_init_tx_queues(&dev->phy, MT7915_TXQ_BAND0,
 				    MT7915_TX_RING_SIZE);
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index b05c3cc6b678..c4dca12818ab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1084,8 +1084,8 @@ void mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 	u8 i, count;
 
 	/* clean DMA queues and unmap buffers first */
-	__mt76_queue_tx_cleanup(&dev->mphy, mdev->q_tx[MT_TXQ_PSD], false);
-	__mt76_queue_tx_cleanup(&dev->mphy, mdev->q_tx[MT_TXQ_BE], false);
+	__mt76_queue_tx_cleanup(&dev->mphy, dev->mphy.q_tx[MT_TXQ_PSD], false);
+	__mt76_queue_tx_cleanup(&dev->mphy, dev->mphy.q_tx[MT_TXQ_BE], false);
 
 	/*
 	 * TODO: MT_TX_FREE_LATENCY is msdu time from the TXD is queued into PLE,
@@ -1422,8 +1422,9 @@ mt7915_update_beacons(struct mt7915_dev *dev)
 }
 
 static void
-mt7915_dma_reset(struct mt7915_dev *dev)
+mt7915_dma_reset(struct mt7915_phy *phy)
 {
+	struct mt7915_dev *dev = phy->dev;
 	int i;
 
 	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
@@ -1434,7 +1435,7 @@ mt7915_dma_reset(struct mt7915_dev *dev)
 
 	__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_mcu[MT_MCUQ_WA], true);
 	for (i = 0; i < __MT_TXQ_MAX; i++)
-		__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_tx[i], true);
+		__mt76_queue_tx_cleanup(&dev->mphy, phy->mt76->q_tx[i], true);
 
 	mt76_for_each_q_rx(&dev->mt76, i) {
 		mt76_queue_rx_reset(dev, i);
@@ -1490,7 +1491,7 @@ void mt7915_mac_reset_work(struct work_struct *work)
 	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_DMA_STOPPED);
 
 	if (mt7915_wait_reset_state(dev, MT_MCU_CMD_RESET_DONE)) {
-		mt7915_dma_reset(dev);
+		mt7915_dma_reset(&dev->phy);
 
 		mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_DMA_INIT);
 		mt7915_wait_reset_state(dev, MT_MCU_CMD_RECOVERY_DONE);
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index e35b25e70947..8945aaf9965b 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -67,7 +67,7 @@ static int mt76s_alloc_tx(struct mt76_dev *dev)
 			return PTR_ERR(q);
 
 		q->qid = i;
-		dev->q_tx[i] = q;
+		dev->phy.q_tx[i] = q;
 	}
 
 	q = mt76s_alloc_tx_queue(dev);
@@ -206,7 +206,8 @@ static void mt76s_status_worker(struct mt76_worker *w)
 		nframes = mt76s_process_tx_queue(dev, dev->q_mcu[MT_MCUQ_WM]);
 
 		for (i = 0; i <= MT_TXQ_PSD; i++)
-			nframes += mt76s_process_tx_queue(dev, dev->q_tx[i]);
+			nframes += mt76s_process_tx_queue(dev,
+							  dev->phy.q_tx[i]);
 
 		if (dev->drv->tx_status_data &&
 		    !test_and_set_bit(MT76_READING_STATS, &dev->phy.state))
@@ -244,8 +245,8 @@ mt76s_tx_queue_skb(struct mt76_phy *phy, enum mt76_txq_id qid,
 		   struct sk_buff *skb, struct mt76_wcid *wcid,
 		   struct ieee80211_sta *sta)
 {
+	struct mt76_queue *q = phy->q_tx[qid];
 	struct mt76_dev *dev = phy->dev;
-	struct mt76_queue *q = dev->q_tx[qid];
 	struct mt76_tx_info tx_info = {
 		.skb = skb,
 	};
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/wireless/mediatek/mt76/testmode.c
index 8eb0905541de..c767fe6605d6 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/testmode.c
@@ -23,6 +23,7 @@ void mt76_testmode_tx_pending(struct mt76_dev *dev)
 {
 	struct mt76_testmode_data *td = &dev->test;
 	struct mt76_wcid *wcid = &dev->global_wcid;
+	struct mt76_phy *phy = &dev->phy;
 	struct sk_buff *skb = td->tx_skb;
 	struct mt76_queue *q;
 	int qid;
@@ -31,7 +32,7 @@ void mt76_testmode_tx_pending(struct mt76_dev *dev)
 		return;
 
 	qid = skb_get_queue_mapping(skb);
-	q = dev->q_tx[qid];
+	q = phy->q_tx[qid];
 
 	spin_lock_bh(&q->lock);
 
@@ -39,8 +40,8 @@ void mt76_testmode_tx_pending(struct mt76_dev *dev)
 	       q->queued < q->ndesc / 2) {
 		int ret;
 
-		ret = dev->queue_ops->tx_queue_skb(&dev->phy, qid,
-						   skb_get(skb), wcid, NULL);
+		ret = dev->queue_ops->tx_queue_skb(phy, qid, skb_get(skb),
+						   wcid, NULL);
 		if (ret < 0)
 			break;
 
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index d8270801b79a..ce2942f745fe 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -230,8 +230,8 @@ __mt76_tx_queue_skb(struct mt76_phy *phy, int qid, struct sk_buff *skb,
 		    bool *stop)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct mt76_queue *q = phy->q_tx[qid];
 	struct mt76_dev *dev = phy->dev;
-	struct mt76_queue *q;
 	bool non_aql;
 	int pending;
 	int idx;
@@ -242,7 +242,6 @@ __mt76_tx_queue_skb(struct mt76_phy *phy, int qid, struct sk_buff *skb,
 		return idx;
 
 	wcid = (struct mt76_wcid *)sta->drv_priv;
-	q = dev->q_tx[qid];
 	q->entry[idx].wcid = wcid->idx;
 	pending = atomic_inc_return(&wcid->non_aql_packets);
 	if (stop && pending >= MT_MAX_NON_AQL_PKT)
@@ -287,7 +286,7 @@ mt76_tx(struct mt76_phy *phy, struct ieee80211_sta *sta,
 	if (ext_phy)
 		info->hw_queue |= MT_TX_HW_QUEUE_EXT_PHY;
 
-	q = dev->q_tx[qid];
+	q = phy->q_tx[qid];
 
 	spin_lock_bh(&q->lock);
 	__mt76_tx_queue_skb(phy, qid, skb, wcid, sta, NULL);
@@ -346,7 +345,7 @@ mt76_release_buffered_frames(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 	struct mt76_phy *phy = hw->priv;
 	struct mt76_dev *dev = phy->dev;
 	struct sk_buff *last_skb = NULL;
-	struct mt76_queue *hwq = dev->q_tx[MT_TXQ_PSD];
+	struct mt76_queue *hwq = phy->q_tx[MT_TXQ_PSD];
 	int i;
 
 	spin_lock_bh(&hwq->lock);
@@ -450,8 +449,7 @@ mt76_txq_send_burst(struct mt76_phy *phy, struct mt76_queue *q,
 static int
 mt76_txq_schedule_list(struct mt76_phy *phy, enum mt76_txq_id qid)
 {
-	struct mt76_dev *dev = phy->dev;
-	struct mt76_queue *q = dev->q_tx[qid];
+	struct mt76_queue *q = phy->q_tx[qid];
 	struct ieee80211_txq *txq;
 	struct mt76_txq *mtxq;
 	struct mt76_wcid *wcid;
@@ -540,7 +538,7 @@ void mt76_tx_worker(struct mt76_worker *w)
 #endif
 }
 
-void mt76_stop_tx_queues(struct mt76_dev *dev, struct ieee80211_sta *sta,
+void mt76_stop_tx_queues(struct mt76_phy *phy, struct ieee80211_sta *sta,
 			 bool send_bar)
 {
 	int i;
@@ -553,7 +551,7 @@ void mt76_stop_tx_queues(struct mt76_dev *dev, struct ieee80211_sta *sta,
 		if (!txq)
 			continue;
 
-		hwq = dev->q_tx[mt76_txq_get_qid(txq)];
+		hwq = phy->q_tx[mt76_txq_get_qid(txq)];
 		mtxq = (struct mt76_txq *)txq->drv_priv;
 
 		spin_lock_bh(&hwq->lock);
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 38d029800d59..c6d123434165 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -815,7 +815,7 @@ static void mt76u_status_worker(struct mt76_worker *w)
 	int i;
 
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-		q = dev->q_tx[i];
+		q = dev->phy.q_tx[i];
 
 		while (q->queued > 0) {
 			if (!q->entry[q->tail].done)
@@ -905,8 +905,8 @@ mt76u_tx_queue_skb(struct mt76_phy *phy, enum mt76_txq_id qid,
 		   struct sk_buff *skb, struct mt76_wcid *wcid,
 		   struct ieee80211_sta *sta)
 {
+	struct mt76_queue *q = phy->q_tx[qid];
 	struct mt76_dev *dev = phy->dev;
-	struct mt76_queue *q = dev->q_tx[qid];
 	struct mt76_tx_info tx_info = {
 		.skb = skb,
 	};
@@ -985,7 +985,7 @@ static int mt76u_alloc_tx(struct mt76_dev *dev)
 
 	for (i = 0; i <= MT_TXQ_PSD; i++) {
 		if (i >= IEEE80211_NUM_ACS) {
-			dev->q_tx[i] = dev->q_tx[0];
+			dev->phy.q_tx[i] = dev->phy.q_tx[0];
 			continue;
 		}
 
@@ -995,7 +995,7 @@ static int mt76u_alloc_tx(struct mt76_dev *dev)
 
 		spin_lock_init(&q->lock);
 		q->hw_idx = mt76u_ac_to_hwq(dev, i);
-		dev->q_tx[i] = q;
+		dev->phy.q_tx[i] = q;
 
 		q->entry = devm_kcalloc(dev->dev,
 					MT_NUM_TX_ENTRIES, sizeof(*q->entry),
@@ -1024,7 +1024,7 @@ static void mt76u_free_tx(struct mt76_dev *dev)
 		struct mt76_queue *q;
 		int j;
 
-		q = dev->q_tx[i];
+		q = dev->phy.q_tx[i];
 		if (!q)
 			continue;
 
@@ -1052,7 +1052,7 @@ void mt76u_stop_tx(struct mt76_dev *dev)
 		dev_err(dev->dev, "timed out waiting for pending tx\n");
 
 		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-			q = dev->q_tx[i];
+			q = dev->phy.q_tx[i];
 			if (!q)
 				continue;
 
@@ -1064,7 +1064,7 @@ void mt76u_stop_tx(struct mt76_dev *dev)
 		 * will fail to submit urb, cleanup those skb's manually.
 		 */
 		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-			q = dev->q_tx[i];
+			q = dev->phy.q_tx[i];
 			if (!q)
 				continue;
 
-- 
2.26.2

