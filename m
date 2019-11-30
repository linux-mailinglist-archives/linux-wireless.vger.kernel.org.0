Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C37510DE22
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Nov 2019 16:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfK3PbM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Nov 2019 10:31:12 -0500
Received: from nbd.name ([46.4.11.11]:56026 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbfK3Pas (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Nov 2019 10:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=jPWQiv00OgES6TRIzNUVttaWrYd9646K8c5NAl2P/08=; b=TN2B6Ic/+iQ5UTEhJZR0hxSCGX
        t6H0O8BKIzwrcSWcz4/qulzCb9rtkXrv8n5ivDJhziSgBdV29XftPf7hD0eXbSinJfp7JEvY8AUW2
        1QzibbrnBveqV9BSyFzc8csD8g9smEpgSuZKm3G8GfdldTLwU8N0+Xhm8iWV9A/24sZI=;
Received: from p5b2067e3.dip0.t-ipconnect.de ([91.32.103.227] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ib4hq-0006hA-Gq
        for linux-wireless@vger.kernel.org; Sat, 30 Nov 2019 16:30:46 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 06014721EBD5; Sat, 30 Nov 2019 16:30:45 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 04/29] mt76: add support for an extra wiphy in the main tx path
Date:   Sat, 30 Nov 2019 16:30:20 +0100
Message-Id: <20191130153045.28105-4-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130153045.28105-1-nbd@nbd.name>
References: <20191130153045.28105-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is preparation for supporting multiple wiphys per device to support the
concurrent dual-band feature of MT7615D

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  6 +--
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  4 +-
 .../net/wireless/mediatek/mt76/mt7603/main.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt76x0/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c |  4 +-
 .../net/wireless/mediatek/mt76/mt76x02_txrx.c |  2 +-
 .../wireless/mediatek/mt76/mt76x2/pci_main.c  |  2 +-
 .../wireless/mediatek/mt76/mt76x2/usb_main.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/tx.c       | 50 +++++++++++--------
 drivers/net/wireless/mediatek/mt76/usb.c      |  2 +-
 11 files changed, 45 insertions(+), 37 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 705d25f9778a..4fd36b3e9440 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -720,15 +720,15 @@ static inline bool mt76_is_skb_pktid(u8 pktid)
 }
 
 void mt76_rx(struct mt76_dev *dev, enum mt76_rxq_id q, struct sk_buff *skb);
-void mt76_tx(struct mt76_dev *dev, struct ieee80211_sta *sta,
+void mt76_tx(struct mt76_phy *dev, struct ieee80211_sta *sta,
 	     struct mt76_wcid *wcid, struct sk_buff *skb);
 void mt76_txq_init(struct mt76_dev *dev, struct ieee80211_txq *txq);
 void mt76_txq_remove(struct mt76_dev *dev, struct ieee80211_txq *txq);
 void mt76_wake_tx_queue(struct ieee80211_hw *hw, struct ieee80211_txq *txq);
 void mt76_stop_tx_queues(struct mt76_dev *dev, struct ieee80211_sta *sta,
 			 bool send_bar);
-void mt76_txq_schedule(struct mt76_dev *dev, enum mt76_txq_id qid);
-void mt76_txq_schedule_all(struct mt76_dev *dev);
+void mt76_txq_schedule(struct mt76_phy *phy, enum mt76_txq_id qid);
+void mt76_txq_schedule_all(struct mt76_phy *phy);
 void mt76_tx_tasklet(unsigned long data);
 void mt76_release_buffered_frames(struct ieee80211_hw *hw,
 				  struct ieee80211_sta *sta,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 812d081ad943..31611195251b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1392,7 +1392,7 @@ static void mt7603_mac_watchdog_reset(struct mt7603_dev *dev)
 	set_bit(MT76_RESET, &dev->mt76.state);
 
 	/* lock/unlock all queues to ensure that no tx is pending */
-	mt76_txq_schedule_all(&dev->mt76);
+	mt76_txq_schedule_all(&dev->mphy);
 
 	tasklet_disable(&dev->mt76.tx_tasklet);
 	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
@@ -1456,7 +1456,7 @@ static void mt7603_mac_watchdog_reset(struct mt7603_dev *dev)
 	napi_schedule(&dev->mt76.napi[1]);
 
 	ieee80211_wake_queues(dev->mt76.hw);
-	mt76_txq_schedule_all(&dev->mt76);
+	mt76_txq_schedule_all(&dev->mphy);
 }
 
 static u32 mt7603_dma_debug(struct mt7603_dev *dev, u8 index)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 962e2822d19f..b10bf9da3798 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -178,7 +178,7 @@ mt7603_set_channel(struct mt7603_dev *dev, struct cfg80211_chan_def *def)
 
 	clear_bit(MT76_RESET, &dev->mt76.state);
 
-	mt76_txq_schedule_all(&dev->mt76);
+	mt76_txq_schedule_all(&dev->mphy);
 
 	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mt76.mac_work,
 				     msecs_to_jiffies(MT7603_WATCHDOG_TIME));
@@ -667,7 +667,7 @@ static void mt7603_tx(struct ieee80211_hw *hw,
 		wcid = &mvif->sta.wcid;
 	}
 
-	mt76_tx(&dev->mt76, control->sta, wcid, skb);
+	mt76_tx(&dev->mphy, control->sta, wcid, skb);
 }
 
 const struct ieee80211_ops mt7603_ops = {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 070b03403894..c55609c06fc4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -171,7 +171,7 @@ static int mt7615_set_channel(struct mt7615_dev *dev)
 	clear_bit(MT76_RESET, &dev->mt76.state);
 	mutex_unlock(&dev->mt76.mutex);
 
-	mt76_txq_schedule_all(&dev->mt76);
+	mt76_txq_schedule_all(&dev->mphy);
 	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mt76.mac_work,
 				     MT7615_WATCHDOG_TIME);
 	return ret;
@@ -458,7 +458,7 @@ static void mt7615_tx(struct ieee80211_hw *hw,
 		wcid = &mvif->sta.wcid;
 	}
 
-	mt76_tx(&dev->mt76, control->sta, wcid, skb);
+	mt76_tx(&dev->mphy, control->sta, wcid, skb);
 }
 
 static int mt7615_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
index b2ccf50512dc..bae99aa4d863 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
@@ -28,7 +28,7 @@ mt76x0_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
 	}
 	mt76x02_pre_tbtt_enable(dev, true);
 
-	mt76_txq_schedule_all(&dev->mt76);
+	mt76_txq_schedule_all(&dev->mphy);
 }
 
 int mt76x0_config(struct ieee80211_hw *hw, u32 changed)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 4e2371c926d8..6006c831c0a2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -151,7 +151,7 @@ static void mt76x02_tx_tasklet(unsigned long data)
 	mt76x02_mac_poll_tx_status(dev, false);
 	mt76x02_process_tx_status_fifo(dev);
 
-	mt76_txq_schedule_all(&dev->mt76);
+	mt76_txq_schedule_all(&dev->mphy);
 }
 
 static int mt76x02_poll_tx(struct napi_struct *napi, int budget)
@@ -514,7 +514,7 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 		ieee80211_restart_hw(dev->mt76.hw);
 	} else {
 		ieee80211_wake_queues(dev->mt76.hw);
-		mt76_txq_schedule_all(&dev->mt76);
+		mt76_txq_schedule_all(&dev->mphy);
 	}
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c b/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
index 13825f642087..05dd531a9e1a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
@@ -28,7 +28,7 @@ void mt76x02_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
 		wcid = &mvif->group_wcid;
 	}
 
-	mt76_tx(&dev->mt76, control->sta, wcid, skb);
+	mt76_tx(&dev->mphy, control->sta, wcid, skb);
 }
 EXPORT_SYMBOL_GPL(mt76x02_tx);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
index cfe8905ce73f..7845e56cb23b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
@@ -63,7 +63,7 @@ mt76x2_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
 	tasklet_enable(&dev->dfs_pd.dfs_tasklet);
 	tasklet_enable(&dev->mt76.pre_tbtt_tasklet);
 
-	mt76_txq_schedule_all(&dev->mt76);
+	mt76_txq_schedule_all(&dev->mphy);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
index 9e97204841f5..8a04a7bf25c0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
@@ -56,7 +56,7 @@ mt76x2u_set_channel(struct mt76x02_dev *dev,
 	mutex_unlock(&dev->mt76.mutex);
 
 	mt76x02_pre_tbtt_enable(dev, true);
-	mt76_txq_schedule_all(&dev->mt76);
+	mt76_txq_schedule_all(&dev->mphy);
 
 	return err;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 7ee91d946882..d9fccbeff206 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -245,9 +245,10 @@ void mt76_tx_complete_skb(struct mt76_dev *dev, struct sk_buff *skb)
 EXPORT_SYMBOL_GPL(mt76_tx_complete_skb);
 
 void
-mt76_tx(struct mt76_dev *dev, struct ieee80211_sta *sta,
+mt76_tx(struct mt76_phy *phy, struct ieee80211_sta *sta,
 	struct mt76_wcid *wcid, struct sk_buff *skb)
 {
+	struct mt76_dev *dev = phy->dev;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct mt76_queue *q;
@@ -282,7 +283,7 @@ mt76_tx(struct mt76_dev *dev, struct ieee80211_sta *sta,
 	dev->queue_ops->kick(dev, q);
 
 	if (q->queued > q->ndesc - 8 && !q->stopped) {
-		ieee80211_stop_queue(dev->hw, skb_get_queue_mapping(skb));
+		ieee80211_stop_queue(phy->hw, skb_get_queue_mapping(skb));
 		q->stopped = true;
 	}
 
@@ -291,7 +292,7 @@ mt76_tx(struct mt76_dev *dev, struct ieee80211_sta *sta,
 EXPORT_SYMBOL_GPL(mt76_tx);
 
 static struct sk_buff *
-mt76_txq_dequeue(struct mt76_dev *dev, struct mt76_txq *mtxq, bool ps)
+mt76_txq_dequeue(struct mt76_phy *phy, struct mt76_txq *mtxq, bool ps)
 {
 	struct ieee80211_txq *txq = mtxq_to_txq(mtxq);
 	struct sk_buff *skb;
@@ -306,7 +307,7 @@ mt76_txq_dequeue(struct mt76_dev *dev, struct mt76_txq *mtxq, bool ps)
 		return skb;
 	}
 
-	skb = ieee80211_tx_dequeue(dev->hw, txq);
+	skb = ieee80211_tx_dequeue(phy->hw, txq);
 	if (!skb)
 		return NULL;
 
@@ -335,7 +336,8 @@ mt76_release_buffered_frames(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 			     enum ieee80211_frame_release_type reason,
 			     bool more_data)
 {
-	struct mt76_dev *dev = hw->priv;
+	struct mt76_phy *phy = hw->priv;
+	struct mt76_dev *dev = phy->dev;
 	struct sk_buff *last_skb = NULL;
 	struct mt76_queue *hwq = dev->q_tx[MT_TXQ_PSD].q;
 	int i;
@@ -350,7 +352,7 @@ mt76_release_buffered_frames(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 			continue;
 
 		do {
-			skb = mt76_txq_dequeue(dev, mtxq, true);
+			skb = mt76_txq_dequeue(phy, mtxq, true);
 			if (!skb)
 				break;
 
@@ -377,9 +379,10 @@ mt76_release_buffered_frames(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 EXPORT_SYMBOL_GPL(mt76_release_buffered_frames);
 
 static int
-mt76_txq_send_burst(struct mt76_dev *dev, struct mt76_sw_queue *sq,
+mt76_txq_send_burst(struct mt76_phy *phy, struct mt76_sw_queue *sq,
 		    struct mt76_txq *mtxq)
 {
+	struct mt76_dev *dev = phy->dev;
 	struct ieee80211_txq *txq = mtxq_to_txq(mtxq);
 	enum mt76_txq_id qid = mt76_txq_get_qid(txq);
 	struct mt76_wcid *wcid = mtxq->wcid;
@@ -395,7 +398,7 @@ mt76_txq_send_burst(struct mt76_dev *dev, struct mt76_sw_queue *sq,
 	if (test_bit(MT_WCID_FLAG_PS, &wcid->flags))
 		return 0;
 
-	skb = mt76_txq_dequeue(dev, mtxq, false);
+	skb = mt76_txq_dequeue(phy, mtxq, false);
 	if (!skb)
 		return 0;
 
@@ -426,7 +429,7 @@ mt76_txq_send_burst(struct mt76_dev *dev, struct mt76_sw_queue *sq,
 		if (test_bit(MT76_RESET, &dev->state))
 			return -EBUSY;
 
-		skb = mt76_txq_dequeue(dev, mtxq, false);
+		skb = mt76_txq_dequeue(phy, mtxq, false);
 		if (!skb)
 			break;
 
@@ -464,8 +467,9 @@ mt76_txq_send_burst(struct mt76_dev *dev, struct mt76_sw_queue *sq,
 }
 
 static int
-mt76_txq_schedule_list(struct mt76_dev *dev, enum mt76_txq_id qid)
+mt76_txq_schedule_list(struct mt76_phy *phy, enum mt76_txq_id qid)
 {
+	struct mt76_dev *dev = phy->dev;
 	struct mt76_sw_queue *sq = &dev->q_tx[qid];
 	struct mt76_queue *hwq = sq->q;
 	struct ieee80211_txq *txq;
@@ -483,7 +487,7 @@ mt76_txq_schedule_list(struct mt76_dev *dev, enum mt76_txq_id qid)
 			break;
 		}
 
-		txq = ieee80211_next_txq(dev->hw, qid);
+		txq = ieee80211_next_txq(phy->hw, qid);
 		if (!txq)
 			break;
 
@@ -505,8 +509,8 @@ mt76_txq_schedule_list(struct mt76_dev *dev, enum mt76_txq_id qid)
 			spin_lock_bh(&hwq->lock);
 		}
 
-		ret += mt76_txq_send_burst(dev, sq, mtxq);
-		ieee80211_return_txq(dev->hw, txq,
+		ret += mt76_txq_send_burst(phy, sq, mtxq);
+		ieee80211_return_txq(phy->hw, txq,
 				     !skb_queue_empty(&mtxq->retry_q));
 	}
 	spin_unlock_bh(&hwq->lock);
@@ -514,8 +518,9 @@ mt76_txq_schedule_list(struct mt76_dev *dev, enum mt76_txq_id qid)
 	return ret;
 }
 
-void mt76_txq_schedule(struct mt76_dev *dev, enum mt76_txq_id qid)
+void mt76_txq_schedule(struct mt76_phy *phy, enum mt76_txq_id qid)
 {
+	struct mt76_dev *dev = phy->dev;
 	struct mt76_sw_queue *sq = &dev->q_tx[qid];
 	int len;
 
@@ -528,21 +533,21 @@ void mt76_txq_schedule(struct mt76_dev *dev, enum mt76_txq_id qid)
 	rcu_read_lock();
 
 	do {
-		ieee80211_txq_schedule_start(dev->hw, qid);
-		len = mt76_txq_schedule_list(dev, qid);
-		ieee80211_txq_schedule_end(dev->hw, qid);
+		ieee80211_txq_schedule_start(phy->hw, qid);
+		len = mt76_txq_schedule_list(phy, qid);
+		ieee80211_txq_schedule_end(phy->hw, qid);
 	} while (len > 0);
 
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(mt76_txq_schedule);
 
-void mt76_txq_schedule_all(struct mt76_dev *dev)
+void mt76_txq_schedule_all(struct mt76_phy *phy)
 {
 	int i;
 
 	for (i = 0; i <= MT_TXQ_BK; i++)
-		mt76_txq_schedule(dev, i);
+		mt76_txq_schedule(phy, i);
 }
 EXPORT_SYMBOL_GPL(mt76_txq_schedule_all);
 
@@ -550,7 +555,9 @@ void mt76_tx_tasklet(unsigned long data)
 {
 	struct mt76_dev *dev = (struct mt76_dev *)data;
 
-	mt76_txq_schedule_all(dev);
+	mt76_txq_schedule_all(&dev->phy);
+	if (dev->phy2)
+		mt76_txq_schedule_all(dev->phy2);
 }
 
 void mt76_stop_tx_queues(struct mt76_dev *dev, struct ieee80211_sta *sta,
@@ -578,7 +585,8 @@ EXPORT_SYMBOL_GPL(mt76_stop_tx_queues);
 
 void mt76_wake_tx_queue(struct ieee80211_hw *hw, struct ieee80211_txq *txq)
 {
-	struct mt76_dev *dev = hw->priv;
+	struct mt76_phy *phy = hw->priv;
+	struct mt76_dev *dev = phy->dev;
 
 	if (!test_bit(MT76_STATE_RUNNING, &dev->state))
 		return;
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 3b9849b59571..ea5eeaf2dd04 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -694,7 +694,7 @@ static void mt76u_tx_tasklet(unsigned long data)
 
 		spin_unlock_bh(&q->lock);
 
-		mt76_txq_schedule(dev, i);
+		mt76_txq_schedule(&dev->phy, i);
 
 		if (!test_and_set_bit(MT76_READING_STATS, &dev->state))
 			queue_work(dev->usb.stat_wq, &dev->usb.stat_work);
-- 
2.24.0

