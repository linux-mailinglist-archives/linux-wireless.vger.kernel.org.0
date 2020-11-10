Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882772AE3D7
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 00:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbgKJXDi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 18:03:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:56580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730254AbgKJXDh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 18:03:37 -0500
Received: from lore-desk.redhat.com (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 791A020780;
        Tue, 10 Nov 2020 23:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605049415;
        bh=IDrr5gcf59VhB6VN4eYvwQH5PbcvmUcOJxNACv2mM5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cb51mFsT6mhm8FoC2O3pjtUkaQnIbiAqT0J+1V8QKaKybwBQ6MpBRjR1f+/Ryq7f0
         Lq4hWCMNBQd8QcLZ7xwW6wfci29o0tKxMqfwSGy1LtkLjyHf95bU0PUY/hIWYIHfmW
         arMQkwnvihy9ihM81tFrDDY1aWU/1fetsSPlwqwI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH 09/10] mt76: move mcu queues to mt76_dev q_mcu array
Date:   Wed, 11 Nov 2020 00:02:59 +0100
Message-Id: <f7effa30aeb60ed37cc4c80c35f696f208f71f48.1605048763.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605048763.git.lorenzo@kernel.org>
References: <cover.1605048763.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mcu queue to a dedicated array q_mcu in mt76_dev structure.
This is a preliminary patch to move data queues in mt76_phy and properly
support dbdc

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c      |  3 ++
 drivers/net/wireless/mediatek/mt76/mcu.c      |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  8 +--
 .../net/wireless/mediatek/mt76/mt7603/dma.c   | 53 +++++++++----------
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  1 +
 .../net/wireless/mediatek/mt76/mt7603/mcu.c   |  2 +-
 .../wireless/mediatek/mt76/mt7615/debugfs.c   | 15 +++---
 .../net/wireless/mediatek/mt76/mt7615/dma.c   | 19 +++----
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  1 +
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  8 +--
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 +-
 .../wireless/mediatek/mt76/mt7615/sdio_mcu.c  |  4 +-
 .../wireless/mediatek/mt76/mt7615/sdio_txrx.c |  7 ++-
 .../net/wireless/mediatek/mt76/mt76x02_mcu.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c | 45 ++++++++--------
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 17 +++---
 .../net/wireless/mediatek/mt76/mt7915/dma.c   | 19 +++----
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  1 +
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 10 ++--
 drivers/net/wireless/mediatek/mt76/sdio.c     | 11 ++--
 20 files changed, 115 insertions(+), 115 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index b6fc3285a31c..20b293cf28a4 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -663,8 +663,11 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
 
 	mt76_worker_disable(&dev->tx_worker);
 	netif_napi_del(&dev->tx_napi);
+
 	for (i = 0; i < ARRAY_SIZE(dev->q_tx); i++)
 		mt76_dma_tx_cleanup(&dev->phy, dev->q_tx[i], true);
+	for (i = 0; i < ARRAY_SIZE(dev->q_mcu); i++)
+		mt76_dma_tx_cleanup(&dev->phy, dev->q_mcu[i], true);
 
 	mt76_for_each_q_rx(dev, i) {
 		netif_napi_del(&dev->napi[i]);
diff --git a/drivers/net/wireless/mediatek/mt76/mcu.c b/drivers/net/wireless/mediatek/mt76/mcu.c
index 09ff394d539a..2c4ab763d474 100644
--- a/drivers/net/wireless/mediatek/mt76/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mcu.c
@@ -123,7 +123,7 @@ int mt76_mcu_send_firmware(struct mt76_dev *dev, int cmd, const void *data,
 
 		if (dev->queue_ops->tx_cleanup)
 			dev->queue_ops->tx_cleanup(&dev->phy,
-						   dev->q_tx[MT_TXQ_FWDL],
+						   dev->q_mcu[MT_MCUQ_FWDL],
 						   false);
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index d9aee03825f8..87c12d3e78c5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -64,15 +64,15 @@ enum mt76_txq_id {
 	MT_TXQ_BE = IEEE80211_AC_BE,
 	MT_TXQ_BK = IEEE80211_AC_BK,
 	MT_TXQ_PSD,
-	MT_TXQ_MCU,
-	MT_TXQ_MCU_WA,
 	MT_TXQ_BEACON,
 	MT_TXQ_CAB,
-	MT_TXQ_FWDL,
 	__MT_TXQ_MAX
 };
 
 enum mt76_mcuq_id {
+	MT_MCUQ_WM,
+	MT_MCUQ_WA,
+	MT_MCUQ_FWDL,
 	__MT_MCUQ_MAX
 };
 
@@ -812,7 +812,7 @@ static inline int mt76_init_mcu_queue(struct mt76_dev *dev, int qid, int idx,
 	if (IS_ERR(q))
 		return PTR_ERR(q);
 
-	q->qid = qid;
+	q->qid = __MT_TXQ_MAX + qid;
 	dev->q_mcu[qid] = q;
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index 8fbbee2e1ad7..56085b016cfc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -4,21 +4,6 @@
 #include "mac.h"
 #include "../dma.h"
 
-static int
-mt7603_init_tx_queue(struct mt7603_dev *dev, int qid, int idx, int n_desc)
-{
-	int err;
-
-	err = mt76_init_tx_queue(&dev->mphy, qid, idx, n_desc,
-				 MT_TX_RING_BASE);
-	if (err < 0)
-		return err;
-
-	mt7603_irq_enable(dev, MT_INT_TX_DONE(idx));
-
-	return 0;
-}
-
 static void
 mt7603_rx_loopback_skb(struct mt7603_dev *dev, struct sk_buff *skb)
 {
@@ -146,13 +131,17 @@ static int mt7603_poll_tx(struct napi_struct *napi, int budget)
 	dev = container_of(napi, struct mt7603_dev, mt76.tx_napi);
 	dev->tx_dma_check = 0;
 
-	for (i = MT_TXQ_MCU; i >= 0; i--)
+	__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_mcu[MT_MCUQ_WM],
+				false);
+	for (i = MT_TXQ_PSD; i >= 0; i--)
 		__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_tx[i], false);
 
 	if (napi_complete_done(napi, 0))
 		mt7603_irq_enable(dev, MT_INT_TX_DONE_ALL);
 
-	for (i = MT_TXQ_MCU; i >= 0; i--)
+	__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_mcu[MT_MCUQ_WM],
+				false);
+	for (i = MT_TXQ_PSD; i >= 0; i--)
 		__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_tx[i], false);
 
 	mt7603_mac_sta_poll(dev);
@@ -185,32 +174,42 @@ int mt7603_dma_init(struct mt7603_dev *dev)
 	mt7603_pse_client_reset(dev);
 
 	for (i = 0; i < ARRAY_SIZE(wmm_queue_map); i++) {
-		ret = mt7603_init_tx_queue(dev, i, wmm_queue_map[i],
-					   MT7603_TX_RING_SIZE);
+		ret = mt76_init_tx_queue(&dev->mphy, i, wmm_queue_map[i],
+					 MT7603_TX_RING_SIZE, MT_TX_RING_BASE);
 		if (ret)
 			return ret;
 	}
 
-	ret = mt7603_init_tx_queue(dev, MT_TXQ_PSD,
-				   MT_TX_HW_QUEUE_MGMT, MT7603_PSD_RING_SIZE);
+	ret = mt76_init_tx_queue(&dev->mphy, MT_TXQ_PSD, MT_TX_HW_QUEUE_MGMT,
+				 MT7603_PSD_RING_SIZE, MT_TX_RING_BASE);
 	if (ret)
 		return ret;
 
-	ret = mt7603_init_tx_queue(dev, MT_TXQ_MCU,
-				   MT_TX_HW_QUEUE_MCU, MT_MCU_RING_SIZE);
+	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_WM, MT_TX_HW_QUEUE_MCU,
+				  MT_MCU_RING_SIZE, MT_TX_RING_BASE);
 	if (ret)
 		return ret;
 
-	ret = mt7603_init_tx_queue(dev, MT_TXQ_BEACON,
-				   MT_TX_HW_QUEUE_BCN, MT_MCU_RING_SIZE);
+	ret = mt76_init_tx_queue(&dev->mphy, MT_TXQ_BEACON, MT_TX_HW_QUEUE_BCN,
+				 MT_MCU_RING_SIZE, MT_TX_RING_BASE);
 	if (ret)
 		return ret;
 
-	ret = mt7603_init_tx_queue(dev, MT_TXQ_CAB,
-				   MT_TX_HW_QUEUE_BMC, MT_MCU_RING_SIZE);
+	ret = mt76_init_tx_queue(&dev->mphy, MT_TXQ_CAB, MT_TX_HW_QUEUE_BMC,
+				 MT_MCU_RING_SIZE, MT_TX_RING_BASE);
 	if (ret)
 		return ret;
 
+	mt7603_irq_enable(dev,
+			  MT_INT_TX_DONE(IEEE80211_AC_VO) |
+			  MT_INT_TX_DONE(IEEE80211_AC_VI) |
+			  MT_INT_TX_DONE(IEEE80211_AC_BE) |
+			  MT_INT_TX_DONE(IEEE80211_AC_BK) |
+			  MT_INT_TX_DONE(MT_TX_HW_QUEUE_MGMT) |
+			  MT_INT_TX_DONE(MT_TX_HW_QUEUE_MCU) |
+			  MT_INT_TX_DONE(MT_TX_HW_QUEUE_BCN) |
+			  MT_INT_TX_DONE(MT_TX_HW_QUEUE_BMC));
+
 	ret = mt7603_init_rx_queue(dev, &dev->mt76.q_rx[MT_RXQ_MCU], 1,
 				   MT7603_MCU_RX_RING_SIZE, MT_RX_BUF_SIZE);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 1db6f64f59cf..47aee2391077 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1434,6 +1434,7 @@ static void mt7603_mac_watchdog_reset(struct mt7603_dev *dev)
 
 	mt7603_pse_client_reset(dev);
 
+	__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_mcu[MT_MCUQ_WM], true);
 	for (i = 0; i < __MT_TXQ_MAX; i++)
 		__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_tx[i], true);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
index d275aa6e003c..96b6c8916730 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
@@ -73,7 +73,7 @@ mt7603_mcu_skb_send_msg(struct mt76_dev *mdev, struct sk_buff *skb,
 	if (wait_seq)
 		*wait_seq = seq;
 
-	return mt76_tx_queue_skb_raw(dev, mdev->q_tx[MT_TXQ_MCU], skb, 0);
+	return mt76_tx_queue_skb_raw(dev, mdev->q_mcu[MT_MCUQ_WM], skb, 0);
 }
 
 static int
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index ffe36e5ee98d..c3a52467095d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -332,21 +332,18 @@ static int
 mt7615_queues_read(struct seq_file *s, void *data)
 {
 	struct mt7615_dev *dev = dev_get_drvdata(s->private);
-	static const struct {
+	struct {
+		struct mt76_queue *q;
 		char *queue;
-		int id;
 	} queue_map[] = {
-		{ "PDMA0", MT_TXQ_BE },
-		{ "MCUQ", MT_TXQ_MCU },
-		{ "MCUFWQ", MT_TXQ_FWDL },
+		{ dev->mt76.q_tx[MT_TXQ_BE], "PDMA0" },
+		{ dev->mt76.q_mcu[MT_MCUQ_WM], "MCUQ" },
+		{ dev->mt76.q_mcu[MT_MCUQ_FWDL], "MCUFWQ" },
 	};
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(queue_map); i++) {
-		struct mt76_queue *q = dev->mt76.q_tx[queue_map[i].id];
-
-		if (!q)
-			continue;
+		struct mt76_queue *q = queue_map[i].q;
 
 		seq_printf(s,
 			   "%s:	queued=%d head=%d tail=%d\n",
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index 0072331701f9..9a43f14fb199 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -37,9 +37,8 @@ mt7622_init_tx_queues_multi(struct mt7615_dev *dev)
 	if (ret)
 		return ret;
 
-	return mt76_init_tx_queue(&dev->mphy, MT_TXQ_MCU, MT7622_TXQ_MCU,
-				  MT7615_TX_MCU_RING_SIZE,
-				  MT_TX_RING_BASE);
+	return mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_WM, MT7622_TXQ_MCU,
+				   MT7615_TX_MCU_RING_SIZE, MT_TX_RING_BASE);
 }
 
 static int
@@ -47,9 +46,8 @@ mt7615_init_tx_queues(struct mt7615_dev *dev)
 {
 	int ret, i;
 
-	ret = mt76_init_tx_queue(&dev->mphy, MT_TXQ_FWDL, MT7615_TXQ_FWDL,
-				 MT7615_TX_FWDL_RING_SIZE,
-				 MT_TX_RING_BASE);
+	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_FWDL, MT7615_TXQ_FWDL,
+				  MT7615_TX_FWDL_RING_SIZE, MT_TX_RING_BASE);
 	if (ret)
 		return ret;
 
@@ -61,12 +59,11 @@ mt7615_init_tx_queues(struct mt7615_dev *dev)
 	if (ret)
 		return ret;
 
-	for (i = 1; i < MT_TXQ_MCU; i++)
+	for (i = 1; i <= MT_TXQ_PSD ; i++)
 		dev->mt76.q_tx[i] = dev->mt76.q_tx[0];
 
-	return mt76_init_tx_queue(&dev->mphy, MT_TXQ_MCU, MT7615_TXQ_MCU,
-				  MT7615_TX_MCU_RING_SIZE,
-				  MT_TX_RING_BASE);
+	return mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_WM, MT7615_TXQ_MCU,
+				   MT7615_TX_MCU_RING_SIZE, MT_TX_RING_BASE);
 }
 
 static int mt7615_poll_tx(struct napi_struct *napi, int budget)
@@ -75,7 +72,7 @@ static int mt7615_poll_tx(struct napi_struct *napi, int budget)
 
 	dev = container_of(napi, struct mt7615_dev, mt76.tx_napi);
 
-	__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_tx[MT_TXQ_MCU], false);
+	__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_mcu[MT_MCUQ_WM], false);
 
 	if (napi_complete_done(napi, 0))
 		mt7615_irq_enable(dev, mt7615_tx_mcu_int_mask(dev));
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index aea80509f669..db1bad9d5ea4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -2046,6 +2046,7 @@ void mt7615_dma_reset(struct mt7615_dev *dev)
 		   MT_WPDMA_GLO_CFG_TX_WRITEBACK_DONE);
 	usleep_range(1000, 2000);
 
+	__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_mcu[MT_MCUQ_WM], true);
 	for (i = 0; i < __MT_TXQ_MAX; i++)
 		__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_tx[i], true);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 01cfac49b43c..972890a3ca80 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -235,11 +235,11 @@ mt7615_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 
 	mt7615_mcu_fill_msg(dev, skb, cmd, seq);
 	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state))
-		qid = MT_TXQ_MCU;
+		qid = MT_MCUQ_WM;
 	else
-		qid = MT_TXQ_FWDL;
+		qid = MT_MCUQ_FWDL;
 
-	return mt76_tx_queue_skb_raw(dev, dev->mt76.q_tx[qid], skb, 0);
+	return mt76_tx_queue_skb_raw(dev, dev->mt76.q_mcu[qid], skb, 0);
 }
 
 u32 mt7615_rf_rr(struct mt7615_dev *dev, u32 wf, u32 reg)
@@ -2464,7 +2464,7 @@ int mt7615_mcu_init(struct mt7615_dev *dev)
 	if (ret)
 		return ret;
 
-	__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_tx[MT_TXQ_FWDL],
+	__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_mcu[MT_MCUQ_FWDL],
 				false);
 	dev_dbg(dev->mt76.dev, "Firmware init done\n");
 	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 625df4b8e730..99b8abdbb08f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -516,7 +516,7 @@ static inline u8 mt7615_lmac_mapping(struct mt7615_dev *dev, u8 ac)
 
 static inline u32 mt7615_tx_mcu_int_mask(struct mt7615_dev *dev)
 {
-	return MT_INT_TX_DONE(dev->mt76.q_tx[MT_TXQ_MCU]->hw_idx);
+	return MT_INT_TX_DONE(dev->mt76.q_mcu[MT_MCUQ_WM]->hw_idx);
 }
 
 void mt7615_dma_reset(struct mt7615_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
index a6f28b80feba..17fe4187d1de 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
@@ -42,11 +42,11 @@ mt7663s_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	int ret;
 
 	mt7615_mcu_fill_msg(dev, skb, cmd, seq);
-	ret = mt76_tx_queue_skb_raw(dev, mdev->q_tx[MT_TXQ_MCU], skb, 0);
+	ret = mt76_tx_queue_skb_raw(dev, mdev->q_mcu[MT_MCUQ_WM], skb, 0);
 	if (ret)
 		return ret;
 
-	mt76_queue_kick(dev, mdev->q_tx[MT_TXQ_MCU]);
+	mt76_queue_kick(dev, mdev->q_mcu[MT_MCUQ_WM]);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
index ab883b4bca45..9cd33dd8b20c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
@@ -217,7 +217,7 @@ static int __mt7663s_xmit_queue(struct mt76_dev *dev, u8 *data, int len)
 static int mt7663s_tx_run_queue(struct mt76_dev *dev, struct mt76_queue *q)
 {
 	int qid, err, nframes = 0, len = 0, pse_sz = 0, ple_sz = 0;
-	bool mcu = q == dev->q_tx[MT_TXQ_MCU];
+	bool mcu = q == dev->q_mcu[MT_MCUQ_WM];
 	struct mt76_sdio *sdio = &dev->sdio;
 
 	qid = mcu ? ARRAY_SIZE(sdio->xmit_buf) - 1 : q->qid;
@@ -286,11 +286,14 @@ void mt7663s_txrx_worker(struct mt76_worker *w)
 		nframes = 0;
 
 		/* tx */
-		for (i = 0; i < MT_TXQ_MCU_WA; i++) {
+		for (i = 0; i <= MT_TXQ_PSD; i++) {
 			ret = mt7663s_tx_run_queue(dev, dev->q_tx[i]);
 			if (ret > 0)
 				nframes += ret;
 		}
+		ret = mt7663s_tx_run_queue(dev, dev->q_mcu[MT_MCUQ_WM]);
+		if (ret > 0)
+			nframes += ret;
 
 		/* rx */
 		ret = mt7663s_rx_handler(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
index 3846e5be62c0..4aa5c36afeaf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
@@ -61,7 +61,7 @@ int mt76x02_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 		  FIELD_PREP(MT_MCU_MSG_PORT, CPU_TX_PORT) |
 		  FIELD_PREP(MT_MCU_MSG_LEN, skb->len);
 
-	ret = mt76_tx_queue_skb_raw(dev, mdev->q_tx[MT_TXQ_MCU], skb, tx_info);
+	ret = mt76_tx_queue_skb_raw(dev, mdev->q_mcu[MT_MCUQ_WM], skb, tx_info);
 	if (ret)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index c5212f8b08e9..606d1da68f61 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -104,21 +104,6 @@ void mt76x02e_init_beacon_config(struct mt76x02_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt76x02e_init_beacon_config);
 
-static int
-mt76x02_init_tx_queue(struct mt76x02_dev *dev, int qid, int idx, int n_desc)
-{
-	int err;
-
-	err = mt76_init_tx_queue(&dev->mphy, qid, idx, n_desc,
-				 MT_TX_RING_BASE);
-	if (err < 0)
-		return err;
-
-	mt76x02_irq_enable(dev, MT_INT_TX_DONE(idx));
-
-	return 0;
-}
-
 static int
 mt76x02_init_rx_queue(struct mt76x02_dev *dev, struct mt76_queue *q,
 		      int idx, int n_desc, int bufsize)
@@ -164,13 +149,17 @@ static int mt76x02_poll_tx(struct napi_struct *napi, int budget)
 
 	mt76x02_mac_poll_tx_status(dev, false);
 
-	for (i = MT_TXQ_MCU; i >= 0; i--)
+	__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_mcu[MT_MCUQ_WM],
+				false);
+	for (i = MT_TXQ_PSD; i >= 0; i--)
 		__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_tx[i], false);
 
 	if (napi_complete_done(napi, 0))
 		mt76x02_irq_enable(dev, MT_INT_TX_DONE_ALL);
 
-	for (i = MT_TXQ_MCU; i >= 0; i--)
+	__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_mcu[MT_MCUQ_WM],
+				false);
+	for (i = MT_TXQ_PSD; i >= 0; i--)
 		__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_tx[i], false);
 
 	mt76_worker_schedule(&dev->mt76.tx_worker);
@@ -203,22 +192,31 @@ int mt76x02_dma_init(struct mt76x02_dev *dev)
 	mt76_wr(dev, MT_WPDMA_RST_IDX, ~0);
 
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-		ret = mt76x02_init_tx_queue(dev, i, mt76_ac_to_hwq(i),
-					    MT76x02_TX_RING_SIZE);
+		ret = mt76_init_tx_queue(&dev->mphy, i, mt76_ac_to_hwq(i),
+					 MT76x02_TX_RING_SIZE,
+					 MT_TX_RING_BASE);
 		if (ret)
 			return ret;
 	}
 
-	ret = mt76x02_init_tx_queue(dev, MT_TXQ_PSD,
-				    MT_TX_HW_QUEUE_MGMT, MT76x02_PSD_RING_SIZE);
+	ret = mt76_init_tx_queue(&dev->mphy, MT_TXQ_PSD, MT_TX_HW_QUEUE_MGMT,
+				 MT76x02_PSD_RING_SIZE, MT_TX_RING_BASE);
 	if (ret)
 		return ret;
 
-	ret = mt76x02_init_tx_queue(dev, MT_TXQ_MCU,
-				    MT_TX_HW_QUEUE_MCU, MT_MCU_RING_SIZE);
+	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_WM, MT_TX_HW_QUEUE_MCU,
+				  MT_MCU_RING_SIZE, MT_TX_RING_BASE);
 	if (ret)
 		return ret;
 
+	mt76x02_irq_enable(dev,
+			   MT_INT_TX_DONE(IEEE80211_AC_VO) |
+			   MT_INT_TX_DONE(IEEE80211_AC_VI) |
+			   MT_INT_TX_DONE(IEEE80211_AC_BE) |
+			   MT_INT_TX_DONE(IEEE80211_AC_BK) |
+			   MT_INT_TX_DONE(MT_TX_HW_QUEUE_MGMT) |
+			   MT_INT_TX_DONE(MT_TX_HW_QUEUE_MCU));
+
 	ret = mt76x02_init_rx_queue(dev, &dev->mt76.q_rx[MT_RXQ_MCU], 1,
 				    MT_MCU_RING_SIZE, MT_RX_BUF_SIZE);
 	if (ret)
@@ -469,6 +467,7 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 	if (restart)
 		mt76_mcu_restart(dev);
 
+	__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_mcu[MT_MCUQ_WM], true);
 	for (i = 0; i < __MT_TXQ_MAX; i++)
 		__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_tx[i], true);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 8f2ad32ade18..ac2c5997b22f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -280,22 +280,19 @@ static int
 mt7915_queues_read(struct seq_file *s, void *data)
 {
 	struct mt7915_dev *dev = dev_get_drvdata(s->private);
-	static const struct {
+	struct {
+		struct mt76_queue *q;
 		char *queue;
-		int id;
 	} queue_map[] = {
-		{ "WFDMA0", MT_TXQ_BE },
-		{ "MCUWM", MT_TXQ_MCU },
-		{ "MCUWA", MT_TXQ_MCU_WA },
-		{ "MCUFWQ", MT_TXQ_FWDL },
+		{ dev->mt76.q_tx[MT_TXQ_BE], "WFDMA0" },
+		{ dev->mt76.q_mcu[MT_MCUQ_WM], "MCUWM" },
+		{ dev->mt76.q_mcu[MT_MCUQ_WA], "MCUWA" },
+		{ dev->mt76.q_mcu[MT_MCUQ_FWDL], "MCUFWQ" },
 	};
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(queue_map); i++) {
-		struct mt76_queue *q = dev->mt76.q_tx[queue_map[i].id];
-
-		if (!q)
-			continue;
+		struct mt76_queue *q = queue_map[i].q;
 
 		seq_printf(s,
 			   "%s:	queued=%d head=%d tail=%d\n",
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 445530031d81..e6ded7916a9f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -14,7 +14,7 @@ mt7915_init_tx_queues(struct mt7915_dev *dev, int idx, int n_desc)
 	if (err < 0)
 		return err;
 
-	for (i = 0; i < MT_TXQ_MCU; i++)
+	for (i = 0; i <= MT_TXQ_PSD; i++)
 		dev->mt76.q_tx[i] = dev->mt76.q_tx[0];
 
 	return 0;
@@ -56,8 +56,9 @@ void mt7915_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 static void
 mt7915_tx_cleanup(struct mt7915_dev *dev)
 {
-	__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_tx[MT_TXQ_MCU], false);
-	__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_tx[MT_TXQ_MCU_WA],
+	__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_mcu[MT_MCUQ_WM],
+				false);
+	__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_mcu[MT_MCUQ_WA],
 				false);
 }
 
@@ -244,20 +245,20 @@ int mt7915_dma_init(struct mt7915_dev *dev)
 		return ret;
 
 	/* command to WM */
-	ret = mt76_init_tx_queue(&dev->mphy, MT_TXQ_MCU, MT7915_TXQ_MCU_WM,
-				 MT7915_TX_MCU_RING_SIZE, MT_TX_RING_BASE);
+	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_WM, MT7915_TXQ_MCU_WM,
+				  MT7915_TX_MCU_RING_SIZE, MT_TX_RING_BASE);
 	if (ret)
 		return ret;
 
 	/* command to WA */
-	ret = mt76_init_tx_queue(&dev->mphy, MT_TXQ_MCU_WA, MT7915_TXQ_MCU_WA,
-				 MT7915_TX_MCU_RING_SIZE, MT_TX_RING_BASE);
+	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_WA, MT7915_TXQ_MCU_WA,
+				  MT7915_TX_MCU_RING_SIZE, MT_TX_RING_BASE);
 	if (ret)
 		return ret;
 
 	/* firmware download */
-	ret = mt76_init_tx_queue(&dev->mphy, MT_TXQ_FWDL, MT7915_TXQ_FWDL,
-				 MT7915_TX_FWDL_RING_SIZE, MT_TX_RING_BASE);
+	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_FWDL, MT7915_TXQ_FWDL,
+				  MT7915_TX_FWDL_RING_SIZE, MT_TX_RING_BASE);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 0da0927d45f8..b05c3cc6b678 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1432,6 +1432,7 @@ mt7915_dma_reset(struct mt7915_dev *dev)
 		   MT_WFDMA1_GLO_CFG_TX_DMA_EN | MT_WFDMA1_GLO_CFG_RX_DMA_EN);
 	usleep_range(1000, 2000);
 
+	__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_mcu[MT_MCUQ_WA], true);
 	for (i = 0; i < __MT_TXQ_MAX; i++)
 		__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_tx[i], true);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index a415212b845b..a4056b8679cd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -268,18 +268,18 @@ mt7915_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 		seq = ++dev->mt76.mcu.msg_seq & 0xf;
 
 	if (cmd == -MCU_CMD_FW_SCATTER) {
-		txq = MT_TXQ_FWDL;
+		txq = MT_MCUQ_FWDL;
 		goto exit;
 	}
 
 	mcu_txd = (struct mt7915_mcu_txd *)skb_push(skb, sizeof(*mcu_txd));
 
 	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state)) {
-		txq = MT_TXQ_MCU_WA;
+		txq = MT_MCUQ_WA;
 		qidx = MT_TX_MCU_PORT_RX_Q0;
 		pkt_fmt = MT_TX_TYPE_CMD;
 	} else {
-		txq = MT_TXQ_MCU;
+		txq = MT_MCUQ_WM;
 		qidx = MT_TX_MCU_PORT_RX_Q0;
 		pkt_fmt = MT_TX_TYPE_CMD;
 	}
@@ -326,7 +326,7 @@ mt7915_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	if (wait_seq)
 		*wait_seq = seq;
 
-	return mt76_tx_queue_skb_raw(dev, mdev->q_tx[txq], skb, 0);
+	return mt76_tx_queue_skb_raw(dev, mdev->q_mcu[txq], skb, 0);
 }
 
 static void
@@ -2799,7 +2799,7 @@ static int mt7915_load_firmware(struct mt7915_dev *dev)
 		return -EIO;
 	}
 
-	__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_tx[MT_TXQ_FWDL],
+	__mt76_queue_tx_cleanup(&dev->mphy, dev->mt76.q_mcu[MT_MCUQ_FWDL],
 				false);
 
 	dev_dbg(dev->mt76.dev, "Firmware init done\n");
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index e890d7714341..e35b25e70947 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -74,8 +74,8 @@ static int mt76s_alloc_tx(struct mt76_dev *dev)
 	if (IS_ERR(q))
 		return PTR_ERR(q);
 
-	q->qid = MT_TXQ_MCU;
-	dev->q_tx[MT_TXQ_MCU] = q;
+	q->qid = MT_MCUQ_WM;
+	dev->q_mcu[MT_MCUQ_WM] = q;
 
 	return 0;
 }
@@ -157,7 +157,7 @@ static void mt76s_net_worker(struct mt76_worker *w)
 
 static int mt76s_process_tx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 {
-	bool wake, mcu = q == dev->q_tx[MT_TXQ_MCU];
+	bool wake, mcu = q == dev->q_mcu[MT_MCUQ_WM];
 	struct mt76_queue_entry entry;
 	int nframes = 0;
 
@@ -203,8 +203,9 @@ static void mt76s_status_worker(struct mt76_worker *w)
 	int i, nframes;
 
 	do {
-		nframes = 0;
-		for (i = 0; i < MT_TXQ_MCU_WA; i++)
+		nframes = mt76s_process_tx_queue(dev, dev->q_mcu[MT_MCUQ_WM]);
+
+		for (i = 0; i <= MT_TXQ_PSD; i++)
 			nframes += mt76s_process_tx_queue(dev, dev->q_tx[i]);
 
 		if (dev->drv->tx_status_data &&
-- 
2.26.2

