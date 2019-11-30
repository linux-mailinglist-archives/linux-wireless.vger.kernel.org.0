Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1619E10DE1F
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Nov 2019 16:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfK3PbI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Nov 2019 10:31:08 -0500
Received: from nbd.name ([46.4.11.11]:56048 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbfK3Pas (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Nov 2019 10:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=cwkOnXREUXHBy3U0Put0iCVmVll7pzgH8uQhezK3NwQ=; b=VLXwbqBxdwhaTDGfcpIHZsaht9
        SvO8tvJYyxqFa1/oEcimLTM7bQ8W1G5nfmP71m7wCJSFukcfF8dhWKbeMp8lyhX6GgbJmwOa5J/co
        TgINkctkcbBBzruD3AJqPbT5pKtdQve4sF5K1RHc8S1REorCWXrfph54saLhhO7jLg9Y=;
Received: from p5b2067e3.dip0.t-ipconnect.de ([91.32.103.227] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ib4hr-0006hc-6Q
        for linux-wireless@vger.kernel.org; Sat, 30 Nov 2019 16:30:47 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 0829C721EBDC; Sat, 30 Nov 2019 16:30:45 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 08/29] mt76: keep a set of software tx queues per phy
Date:   Sat, 30 Nov 2019 16:30:24 +0100
Message-Id: <20191130153045.28105-8-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130153045.28105-1-nbd@nbd.name>
References: <20191130153045.28105-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Allows tracking tx scheduling separately per phy

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/debugfs.c      |  2 +-
 drivers/net/wireless/mediatek/mt76/dma.c          | 12 ++++++++++--
 drivers/net/wireless/mediatek/mt76/mac80211.c     | 13 ++++++++-----
 drivers/net/wireless/mediatek/mt76/mt76.h         |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c |  2 +-
 drivers/net/wireless/mediatek/mt76/usb.c          |  2 +-
 7 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/debugfs.c b/drivers/net/wireless/mediatek/mt76/debugfs.c
index d2202acb8dc6..2567c5d6945f 100644
--- a/drivers/net/wireless/mediatek/mt76/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
@@ -30,7 +30,7 @@ int mt76_queues_read(struct seq_file *s, void *data)
 	struct mt76_dev *dev = dev_get_drvdata(s->private);
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(dev->q_tx); i++) {
+	for (i = 0; i < __MT_TXQ_MAX; i++) {
 		struct mt76_sw_queue *q = &dev->q_tx[i];
 
 		if (!q->q)
diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 67d10099cb71..f88d017ff987 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -141,7 +141,7 @@ mt76_dma_tx_cleanup(struct mt76_dev *dev, enum mt76_txq_id qid, bool flush)
 	struct mt76_sw_queue *sq = &dev->q_tx[qid];
 	struct mt76_queue *q = sq->q;
 	struct mt76_queue_entry entry;
-	unsigned int n_swq_queued[4] = {};
+	unsigned int n_swq_queued[8] = {};
 	unsigned int n_queued = 0;
 	bool wake = false;
 	int i, last;
@@ -178,13 +178,21 @@ mt76_dma_tx_cleanup(struct mt76_dev *dev, enum mt76_txq_id qid, bool flush)
 	spin_lock_bh(&q->lock);
 
 	q->queued -= n_queued;
-	for (i = 0; i < ARRAY_SIZE(n_swq_queued); i++) {
+	for (i = 0; i < 4; i++) {
 		if (!n_swq_queued[i])
 			continue;
 
 		dev->q_tx[i].swq_queued -= n_swq_queued[i];
 	}
 
+	/* ext PHY */
+	for (i = 0; i < 4; i++) {
+		if (!n_swq_queued[i])
+			continue;
+
+		dev->q_tx[__MT_TXQ_MAX + i].swq_queued -= n_swq_queued[4 + i];
+	}
+
 	if (flush)
 		mt76_dma_sync_idx(dev, q);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index ca408bddd491..da2d072cd0ea 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -411,13 +411,16 @@ void mt76_rx(struct mt76_dev *dev, enum mt76_rxq_id q, struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(mt76_rx);
 
-bool mt76_has_tx_pending(struct mt76_dev *dev)
+bool mt76_has_tx_pending(struct mt76_phy *phy)
 {
+	struct mt76_dev *dev = phy->dev;
 	struct mt76_queue *q;
-	int i;
+	int i, offset;
+
+	offset = __MT_TXQ_MAX * (phy != &dev->phy);
 
-	for (i = 0; i < ARRAY_SIZE(dev->q_tx); i++) {
-		q = dev->q_tx[i].q;
+	for (i = 0; i < __MT_TXQ_MAX; i++) {
+		q = dev->q_tx[offset + i].q;
 		if (q && q->queued)
 			return true;
 	}
@@ -485,7 +488,7 @@ void mt76_set_channel(struct mt76_phy *phy)
 	bool offchannel = hw->conf.flags & IEEE80211_CONF_OFFCHANNEL;
 	int timeout = HZ / 5;
 
-	wait_event_timeout(dev->tx_wait, !mt76_has_tx_pending(dev), timeout);
+	wait_event_timeout(dev->tx_wait, !mt76_has_tx_pending(phy), timeout);
 	mt76_update_survey(dev);
 
 	phy->chandef = *chandef;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 547d9a29afa7..a522c7a5e294 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -498,7 +498,7 @@ struct mt76_dev {
 	u32 ampdu_ref;
 
 	struct list_head txwi_cache;
-	struct mt76_sw_queue q_tx[__MT_TXQ_MAX];
+	struct mt76_sw_queue q_tx[2 * __MT_TXQ_MAX];
 	struct mt76_queue q_rx[__MT_RXQ_MAX];
 	const struct mt76_queue_ops *queue_ops;
 	int tx_dma_idx[4];
@@ -752,7 +752,7 @@ void mt76_release_buffered_frames(struct ieee80211_hw *hw,
 				  u16 tids, int nframes,
 				  enum ieee80211_frame_release_type reason,
 				  bool more_data);
-bool mt76_has_tx_pending(struct mt76_dev *dev);
+bool mt76_has_tx_pending(struct mt76_phy *phy);
 void mt76_set_channel(struct mt76_phy *phy);
 void mt76_update_survey(struct mt76_dev *dev);
 int mt76_get_survey(struct ieee80211_hw *hw, int idx,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 8aefadd6278e..588b21694ea3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1426,7 +1426,7 @@ static void mt7603_mac_watchdog_reset(struct mt7603_dev *dev)
 
 	mt7603_pse_client_reset(dev);
 
-	for (i = 0; i < ARRAY_SIZE(dev->mt76.q_tx); i++)
+	for (i = 0; i < __MT_TXQ_MAX; i++)
 		mt76_queue_tx_cleanup(dev, i, true);
 
 	for (i = 0; i < ARRAY_SIZE(dev->mt76.q_rx); i++)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 6006c831c0a2..7d463f7bc87f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -476,7 +476,7 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 	if (restart)
 		mt76_mcu_restart(dev);
 
-	for (i = 0; i < ARRAY_SIZE(dev->mt76.q_tx); i++)
+	for (i = 0; i < __MT_TXQ_MAX; i++)
 		mt76_queue_tx_cleanup(dev, i, true);
 
 	for (i = 0; i < ARRAY_SIZE(dev->mt76.q_rx); i++)
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index ea5eeaf2dd04..3478cff9ab9a 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -872,7 +872,7 @@ void mt76u_stop_tx(struct mt76_dev *dev)
 	struct mt76_queue *q;
 	int i, j, ret;
 
-	ret = wait_event_timeout(dev->tx_wait, !mt76_has_tx_pending(dev),
+	ret = wait_event_timeout(dev->tx_wait, !mt76_has_tx_pending(&dev->phy),
 				 HZ / 5);
 	if (!ret) {
 		dev_err(dev->dev, "timed out waiting for pending tx\n");
-- 
2.24.0

