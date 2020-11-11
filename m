Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1ABF2AF281
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 14:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgKKNsJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Nov 2020 08:48:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbgKKNry (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 08:47:54 -0500
Received: from lore-desk.redhat.com (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D3AA2072C;
        Wed, 11 Nov 2020 13:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605102472;
        bh=OrEdZD0oY52KXALuGK9d0sSUUG7QSgR8NsE6TyU2vKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oYfI8lCU2ugdJ7bffTwN5vS5AkfWBunVU0p2M5VT6/5Cp5Z2UhNJ5W+HrvjL/LnXn
         DuHxLaTBxbD2OmFjJOzRpXgOcVWvhXkU1S91k5V98AWosDqVKFxKGjI59ijhluYp8Y
         gfeyVLYyNOMN1D6hSK1W3vsoWS4zUFowtMNyh5KQ=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH v2 05/10] mt76: dma: rely on mt76_queue in mt76_dma_tx_cleanup signature
Date:   Wed, 11 Nov 2020 14:47:27 +0100
Message-Id: <84f2cb84ec62b24572c98afef8c93073742ad802.1605102251.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605102251.git.lorenzo@kernel.org>
References: <cover.1605102251.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to move data queues in mt76_phy and properly
support dbdc

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c           | 9 ++++-----
 drivers/net/wireless/mediatek/mt76/mcu.c           | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt76.h          | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7603/beacon.c | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c    | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c    | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c    | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c    | 8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c    | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c  | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c    | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    | 2 +-
 13 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 145e839fea4e..31ce7dc7643b 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -217,9 +217,8 @@ mt76_dma_kick_queue(struct mt76_dev *dev, struct mt76_queue *q)
 }
 
 static void
-mt76_dma_tx_cleanup(struct mt76_dev *dev, enum mt76_txq_id qid, bool flush)
+mt76_dma_tx_cleanup(struct mt76_dev *dev, struct mt76_queue *q, bool flush)
 {
-	struct mt76_queue *q = dev->q_tx[qid];
 	struct mt76_queue_entry entry;
 	bool wake = false;
 	int last;
@@ -255,7 +254,7 @@ mt76_dma_tx_cleanup(struct mt76_dev *dev, enum mt76_txq_id qid, bool flush)
 	}
 
 	wake = wake && q->stopped &&
-	       qid < IEEE80211_NUM_ACS && q->queued < q->ndesc - 8;
+	       q->qid < IEEE80211_NUM_ACS && q->queued < q->ndesc - 8;
 	if (wake)
 		q->stopped = false;
 
@@ -263,7 +262,7 @@ mt76_dma_tx_cleanup(struct mt76_dev *dev, enum mt76_txq_id qid, bool flush)
 		wake_up(&dev->tx_wait);
 
 	if (wake)
-		ieee80211_wake_queue(dev->hw, qid);
+		ieee80211_wake_queue(dev->hw, q->qid);
 }
 
 static void *
@@ -664,7 +663,7 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
 	mt76_worker_disable(&dev->tx_worker);
 	netif_napi_del(&dev->tx_napi);
 	for (i = 0; i < ARRAY_SIZE(dev->q_tx); i++)
-		mt76_dma_tx_cleanup(dev, i, true);
+		mt76_dma_tx_cleanup(dev, dev->q_tx[i], true);
 
 	mt76_for_each_q_rx(dev, i) {
 		netif_napi_del(&dev->napi[i]);
diff --git a/drivers/net/wireless/mediatek/mt76/mcu.c b/drivers/net/wireless/mediatek/mt76/mcu.c
index 30a6515758a8..1c727afe5e87 100644
--- a/drivers/net/wireless/mediatek/mt76/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mcu.c
@@ -122,7 +122,8 @@ int mt76_mcu_send_firmware(struct mt76_dev *dev, int cmd, const void *data,
 		len -= cur_len;
 
 		if (dev->queue_ops->tx_cleanup)
-			dev->queue_ops->tx_cleanup(dev, MT_TXQ_FWDL, false);
+			dev->queue_ops->tx_cleanup(dev, dev->q_tx[MT_TXQ_FWDL],
+						   false);
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index fc4f0b3e4873..4e691adb2a2b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -179,7 +179,7 @@ struct mt76_queue_ops {
 
 	void (*rx_reset)(struct mt76_dev *dev, enum mt76_rxq_id qid);
 
-	void (*tx_cleanup)(struct mt76_dev *dev, enum mt76_txq_id qid,
+	void (*tx_cleanup)(struct mt76_dev *dev, struct mt76_queue *q,
 			   bool flush);
 
 	void (*kick)(struct mt76_dev *dev, struct mt76_queue *q);
@@ -751,7 +751,7 @@ static inline u16 mt76_rev(struct mt76_dev *dev)
 #define mt76_tx_queue_skb_raw(dev, ...)	(dev)->mt76.queue_ops->tx_queue_skb_raw(&((dev)->mt76), __VA_ARGS__)
 #define mt76_tx_queue_skb(dev, ...)	(dev)->mt76.queue_ops->tx_queue_skb(&((dev)->mt76), __VA_ARGS__)
 #define mt76_queue_rx_reset(dev, ...)	(dev)->mt76.queue_ops->rx_reset(&((dev)->mt76), __VA_ARGS__)
-#define mt76_queue_tx_cleanup(dev, ...)	(dev)->mt76.queue_ops->tx_cleanup(&((dev)->mt76), __VA_ARGS__)
+#define mt76_queue_tx_cleanup(dev, ...)        (dev)->mt76.queue_ops->tx_cleanup(&((dev)->mt76), __VA_ARGS__)
 #define mt76_queue_kick(dev, ...)	(dev)->mt76.queue_ops->kick(&((dev)->mt76), __VA_ARGS__)
 
 #define mt76_for_each_q_rx(dev, i)	\
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
index 53c229cadbbf..2d2b429c9ffc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
@@ -89,7 +89,7 @@ void mt7603_pre_tbtt_tasklet(struct tasklet_struct *t)
 	/* Flush all previous CAB queue packets */
 	mt76_wr(dev, MT_WF_ARB_CAB_FLUSH, GENMASK(30, 16) | BIT(0));
 
-	mt76_queue_tx_cleanup(dev, MT_TXQ_CAB, false);
+	mt76_queue_tx_cleanup(dev, dev->mt76.q_tx[MT_TXQ_CAB], false);
 
 	mt76_csa_check(&dev->mt76);
 	if (dev->mt76.csa_complete)
@@ -135,7 +135,7 @@ void mt7603_pre_tbtt_tasklet(struct tasklet_struct *t)
 		 ((1 << (MT7603_MAX_INTERFACES - 1)) - 1)));
 
 out:
-	mt76_queue_tx_cleanup(dev, MT_TXQ_BEACON, false);
+	mt76_queue_tx_cleanup(dev, dev->mt76.q_tx[MT_TXQ_BEACON], false);
 	if (dev->mt76.q_tx[MT_TXQ_BEACON]->queued >
 	    hweight8(dev->mt76.beacon_mask))
 		dev->beacon_check++;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index 05a5801646d7..3c6399909c06 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -147,13 +147,13 @@ static int mt7603_poll_tx(struct napi_struct *napi, int budget)
 	dev->tx_dma_check = 0;
 
 	for (i = MT_TXQ_MCU; i >= 0; i--)
-		mt76_queue_tx_cleanup(dev, i, false);
+		mt76_queue_tx_cleanup(dev, dev->mt76.q_tx[i], false);
 
 	if (napi_complete_done(napi, 0))
 		mt7603_irq_enable(dev, MT_INT_TX_DONE_ALL);
 
 	for (i = MT_TXQ_MCU; i >= 0; i--)
-		mt76_queue_tx_cleanup(dev, i, false);
+		mt76_queue_tx_cleanup(dev, dev->mt76.q_tx[i], false);
 
 	mt7603_mac_sta_poll(dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index f665a1c95eed..aefa161ecbf8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1435,7 +1435,7 @@ static void mt7603_mac_watchdog_reset(struct mt7603_dev *dev)
 	mt7603_pse_client_reset(dev);
 
 	for (i = 0; i < __MT_TXQ_MAX; i++)
-		mt76_queue_tx_cleanup(dev, i, true);
+		mt76_queue_tx_cleanup(dev, dev->mt76.q_tx[i], true);
 
 	mt76_for_each_q_rx(&dev->mt76, i) {
 		mt76_queue_rx_reset(dev, i);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index 333254734ac5..0a11b346f522 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -75,7 +75,7 @@ static int mt7615_poll_tx(struct napi_struct *napi, int budget)
 
 	dev = container_of(napi, struct mt7615_dev, mt76.tx_napi);
 
-	mt76_queue_tx_cleanup(dev, MT_TXQ_MCU, false);
+	mt76_queue_tx_cleanup(dev, dev->mt76.q_tx[MT_TXQ_MCU], false);
 
 	if (napi_complete_done(napi, 0))
 		mt7615_irq_enable(dev, mt7615_tx_mcu_int_mask(dev));
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 54650f265df7..78fc7b962101 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1435,12 +1435,12 @@ static void mt7615_mac_tx_free(struct mt7615_dev *dev, struct sk_buff *skb)
 	struct mt7615_tx_free *free = (struct mt7615_tx_free *)skb->data;
 	u8 i, count;
 
-	mt76_queue_tx_cleanup(dev, MT_TXQ_PSD, false);
+	mt76_queue_tx_cleanup(dev, dev->mt76.q_tx[MT_TXQ_PSD], false);
 	if (is_mt7615(&dev->mt76)) {
-		mt76_queue_tx_cleanup(dev, MT_TXQ_BE, false);
+		mt76_queue_tx_cleanup(dev, dev->mt76.q_tx[MT_TXQ_BE], false);
 	} else {
 		for (i = 0; i < IEEE80211_NUM_ACS; i++)
-			mt76_queue_tx_cleanup(dev, i, false);
+			mt76_queue_tx_cleanup(dev, dev->mt76.q_tx[i], false);
 	}
 
 	count = FIELD_GET(MT_TX_FREE_MSDU_ID_CNT, le16_to_cpu(free->ctrl));
@@ -2045,7 +2045,7 @@ void mt7615_dma_reset(struct mt7615_dev *dev)
 	usleep_range(1000, 2000);
 
 	for (i = 0; i < __MT_TXQ_MAX; i++)
-		mt76_queue_tx_cleanup(dev, i, true);
+		mt76_queue_tx_cleanup(dev, dev->mt76.q_tx[i], true);
 
 	mt76_for_each_q_rx(&dev->mt76, i) {
 		mt76_queue_rx_reset(dev, i);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 6b05bb7dfc69..8525236d7d35 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2464,7 +2464,7 @@ int mt7615_mcu_init(struct mt7615_dev *dev)
 	if (ret)
 		return ret;
 
-	mt76_queue_tx_cleanup(dev, MT_TXQ_FWDL, false);
+	mt76_queue_tx_cleanup(dev, dev->mt76.q_tx[MT_TXQ_FWDL], false);
 	dev_dbg(dev->mt76.dev, "Firmware init done\n");
 	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
 	mt7615_mcu_fw_log_2_host(dev, 0);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 82f65fa1a39d..e610544971a6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -164,13 +164,13 @@ static int mt76x02_poll_tx(struct napi_struct *napi, int budget)
 	mt76x02_mac_poll_tx_status(dev, false);
 
 	for (i = MT_TXQ_MCU; i >= 0; i--)
-		mt76_queue_tx_cleanup(dev, i, false);
+		mt76_queue_tx_cleanup(dev, dev->mt76.q_tx[i], false);
 
 	if (napi_complete_done(napi, 0))
 		mt76x02_irq_enable(dev, MT_INT_TX_DONE_ALL);
 
 	for (i = MT_TXQ_MCU; i >= 0; i--)
-		mt76_queue_tx_cleanup(dev, i, false);
+		mt76_queue_tx_cleanup(dev, dev->mt76.q_tx[i], false);
 
 	mt76_worker_schedule(&dev->mt76.tx_worker);
 
@@ -469,7 +469,7 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 		mt76_mcu_restart(dev);
 
 	for (i = 0; i < __MT_TXQ_MAX; i++)
-		mt76_queue_tx_cleanup(dev, i, true);
+		mt76_queue_tx_cleanup(dev, dev->mt76.q_tx[i], true);
 
 	mt76_for_each_q_rx(&dev->mt76, i) {
 		mt76_queue_rx_reset(dev, i);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 7c9fe142ed41..702034be621c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -56,8 +56,8 @@ void mt7915_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 static void
 mt7915_tx_cleanup(struct mt7915_dev *dev)
 {
-	mt76_queue_tx_cleanup(dev, MT_TXQ_MCU, false);
-	mt76_queue_tx_cleanup(dev, MT_TXQ_MCU_WA, false);
+	mt76_queue_tx_cleanup(dev, dev->mt76.q_tx[MT_TXQ_MCU], false);
+	mt76_queue_tx_cleanup(dev, dev->mt76.q_tx[MT_TXQ_MCU_WA], false);
 }
 
 static int mt7915_poll_tx(struct napi_struct *napi, int budget)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 9714e06fcc41..5963455d6023 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1084,8 +1084,8 @@ void mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 	u8 i, count;
 
 	/* clean DMA queues and unmap buffers first */
-	mt76_queue_tx_cleanup(dev, MT_TXQ_PSD, false);
-	mt76_queue_tx_cleanup(dev, MT_TXQ_BE, false);
+	mt76_queue_tx_cleanup(dev, mdev->q_tx[MT_TXQ_PSD], false);
+	mt76_queue_tx_cleanup(dev, mdev->q_tx[MT_TXQ_BE], false);
 
 	/*
 	 * TODO: MT_TX_FREE_LATENCY is msdu time from the TXD is queued into PLE,
@@ -1433,7 +1433,7 @@ mt7915_dma_reset(struct mt7915_dev *dev)
 	usleep_range(1000, 2000);
 
 	for (i = 0; i < __MT_TXQ_MAX; i++)
-		mt76_queue_tx_cleanup(dev, i, true);
+		mt76_queue_tx_cleanup(dev, dev->mt76.q_tx[i], true);
 
 	mt76_for_each_q_rx(&dev->mt76, i) {
 		mt76_queue_rx_reset(dev, i);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 364ffa37de30..b135ad972e88 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2799,7 +2799,7 @@ static int mt7915_load_firmware(struct mt7915_dev *dev)
 		return -EIO;
 	}
 
-	mt76_queue_tx_cleanup(dev, MT_TXQ_FWDL, false);
+	mt76_queue_tx_cleanup(dev, dev->mt76.q_tx[MT_TXQ_FWDL], false);
 
 	dev_dbg(dev->mt76.dev, "Firmware init done\n");
 
-- 
2.26.2

