Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97E63F2890
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Aug 2021 10:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhHTIic (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 04:38:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230176AbhHTIib (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 04:38:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8073D610F9;
        Fri, 20 Aug 2021 08:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629448674;
        bh=AVOInSvsyg4DkN3OCBaeOmLUt0TAC/2N0BrnBuKph2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tZ+NIAbykaRayDIR9bkrLLSOp3UzaxxNl1VIWo8RR9pBZT0o2wxY4fLIfJfxrjJx5
         FIl2/34UR8Rq7u1eiqO4kraNZ2vIEDNBt6qvw6UahnqaMDfO7gRkeXWJmiKqZicmY4
         hP7TVuydAVLEErKVIn8L4/JhLhL24j96x70IaVgpuxakcf628u1i6a3TLxzocFlM4E
         LPTSY5JR5Sgc3qQrXuH3WOflG/Q489v3vavQhmRwKrlQLjcwj0FBRG2vVdtD6oZ13Z
         md+IsErDQ6yvoPwWLYpZUwKvUYz3UAeuNcjc7DWgNBm/YFPvL8RzVXyMb06xyLBmxp
         xoSl/2YhpRK4A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, Deren.Wu@mediatek.com
Subject: [PATCH v3 1/5] mt76: mt7921: start reworking tx rate reporting
Date:   Fri, 20 Aug 2021 10:37:41 +0200
Message-Id: <b7b61c7395d64a368cf61ecedd76607e55a839de.1629448559.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629448559.git.lorenzo@kernel.org>
References: <cover.1629448559.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to mt7915, introduce mt7921_txwi_free to report tx rate to
mac80211. This is a preliminary patch to add proper tx status report.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 76 ++++++++++---------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 -
 2 files changed, 42 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 87f73acd181c..63151bdb8fcf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -981,7 +981,7 @@ mt7921_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
 
 static void
 mt7921_tx_complete_status(struct mt76_dev *mdev, struct sk_buff *skb,
-			  struct ieee80211_sta *sta, u8 stat,
+			  struct ieee80211_sta *sta, bool clear_status,
 			  struct list_head *free_list)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
@@ -1005,7 +1005,7 @@ mt7921_tx_complete_status(struct mt76_dev *mdev, struct sk_buff *skb,
 	if (info->flags & IEEE80211_TX_CTL_AMPDU)
 		info->flags |= IEEE80211_TX_STAT_AMPDU;
 
-	if (stat)
+	if (clear_status)
 		ieee80211_tx_info_clear_status(info);
 
 	if (!(info->flags & IEEE80211_TX_CTL_NO_ACK))
@@ -1015,8 +1015,8 @@ mt7921_tx_complete_status(struct mt76_dev *mdev, struct sk_buff *skb,
 	ieee80211_tx_status_ext(hw, &status);
 }
 
-void mt7921_txp_skb_unmap(struct mt76_dev *dev,
-			  struct mt76_txwi_cache *t)
+static void
+mt7921_txp_skb_unmap(struct mt76_dev *dev, struct mt76_txwi_cache *t)
 {
 	struct mt7921_txp_common *txp;
 	int i;
@@ -1046,6 +1046,42 @@ void mt7921_txp_skb_unmap(struct mt76_dev *dev,
 	}
 }
 
+static void
+mt7921_txwi_free(struct mt7921_dev *dev, struct mt76_txwi_cache *t,
+		 struct ieee80211_sta *sta, bool clear_status,
+		 struct list_head *free_list)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+	struct ieee80211_tx_info *info;
+	__le32 *txwi;
+
+	mt7921_txp_skb_unmap(mdev, t);
+	if (!t->skb)
+		goto out;
+
+	if (!sta)
+		goto out;
+
+	txwi = (__le32 *)mt76_get_txwi_ptr(mdev, t);
+	if (likely(t->skb->protocol != cpu_to_be16(ETH_P_PAE)))
+		mt7921_tx_check_aggr(sta, txwi);
+
+	info = IEEE80211_SKB_CB(t->skb);
+	if (!info->tx_time_est) {
+		struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
+		int pending;
+
+		pending = atomic_dec_return(&wcid->non_aql_packets);
+		if (pending < 0)
+			atomic_cmpxchg(&wcid->non_aql_packets, pending, 0);
+	}
+
+	mt7921_tx_complete_status(mdev, t->skb, sta, clear_status, free_list);
+out:
+	t->skb = NULL;
+	mt76_put_txwi(mdev, t);
+}
+
 static void
 mt7921_mac_tx_free(struct mt7921_dev *dev, struct sk_buff *skb)
 {
@@ -1105,28 +1141,7 @@ mt7921_mac_tx_free(struct mt7921_dev *dev, struct sk_buff *skb)
 		if (!txwi)
 			continue;
 
-		mt7921_txp_skb_unmap(mdev, txwi);
-		if (txwi->skb) {
-			struct ieee80211_tx_info *info = IEEE80211_SKB_CB(txwi->skb);
-			void *txwi_ptr = mt76_get_txwi_ptr(mdev, txwi);
-
-			if (likely(txwi->skb->protocol != cpu_to_be16(ETH_P_PAE)))
-				mt7921_tx_check_aggr(sta, txwi_ptr);
-
-			if (sta && !info->tx_time_est) {
-				struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
-				int pending;
-
-				pending = atomic_dec_return(&wcid->non_aql_packets);
-				if (pending < 0)
-					atomic_cmpxchg(&wcid->non_aql_packets, pending, 0);
-			}
-
-			mt7921_tx_complete_status(mdev, txwi->skb, sta, stat, &free_list);
-			txwi->skb = NULL;
-		}
-
-		mt76_put_txwi(mdev, txwi);
+		mt7921_txwi_free(dev, txwi, sta, stat, &free_list);
 	}
 
 	if (wake)
@@ -1338,14 +1353,7 @@ void mt7921_tx_token_put(struct mt7921_dev *dev)
 
 	spin_lock_bh(&dev->mt76.token_lock);
 	idr_for_each_entry(&dev->mt76.token, txwi, id) {
-		mt7921_txp_skb_unmap(&dev->mt76, txwi);
-		if (txwi->skb) {
-			struct ieee80211_hw *hw;
-
-			hw = mt76_tx_status_get_hw(&dev->mt76, txwi->skb);
-			ieee80211_free_txskb(hw, txwi->skb);
-		}
-		mt76_put_txwi(&dev->mt76, txwi);
+		mt7921_txwi_free(dev, txwi, NULL, false, NULL);
 		dev->mt76.token_count--;
 	}
 	spin_unlock_bh(&dev->mt76.token_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 5aac76dba90c..0baa9b37aeda 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -354,8 +354,6 @@ void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb);
 void mt7921_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps);
 void mt7921_stats_work(struct work_struct *work);
-void mt7921_txp_skb_unmap(struct mt76_dev *dev,
-			  struct mt76_txwi_cache *txwi);
 void mt7921_set_stream_he_caps(struct mt7921_phy *phy);
 void mt7921_update_channel(struct mt76_phy *mphy);
 int mt7921_init_debugfs(struct mt7921_dev *dev);
-- 
2.31.1

