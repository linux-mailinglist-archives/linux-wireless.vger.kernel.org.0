Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E71C377F57
	for <lists+linux-wireless@lfdr.de>; Mon, 10 May 2021 11:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhEJJ2Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 May 2021 05:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhEJJ2M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 May 2021 05:28:12 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D58C0613ED
        for <linux-wireless@vger.kernel.org>; Mon, 10 May 2021 02:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3wTBJr6dnS+bodY1lF1H4lwiJFPil5P/U9ifGAb8wK4=; b=mLX9j9ma8YE82FIp7/7GcXFiqH
        iAnXS4nnxmalPHxZTAc2PP9v9591mK461nJXB2o1NmwpxReozBZZ7Yz48mrLMuJp+WxSyHuYiosrM
        UmyzXYUEPHGIbW6DcGf3E+WZGbR0A+cLJlhsFii79Ig+a4eRRYQYEhZW6t2Ikbdq8IoA=;
Received: from p54ae9ff2.dip0.t-ipconnect.de ([84.174.159.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lg2Bu-000572-5S
        for linux-wireless@vger.kernel.org; Mon, 10 May 2021 11:27:06 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 6/9] mt76: improve tx status codepath
Date:   Mon, 10 May 2021 11:27:00 +0200
Message-Id: <20210510092703.90500-6-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210510092703.90500-1-nbd@nbd.name>
References: <20210510092703.90500-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use ieee80211_tx_status_ext instead of ieee80211_free_skb and
ieee80211_tx_status. This makes it compatible with 802.3 encap offload
and improves performance by removing a redundant sta lookup

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76.h |  9 ++-
 drivers/net/wireless/mediatek/mt76/tx.c   | 73 +++++++++++++++--------
 2 files changed, 55 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 36ede65919f8..d3859eda2a4f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1056,7 +1056,14 @@ struct sk_buff *mt76_tx_status_skb_get(struct mt76_dev *dev,
 				       struct sk_buff_head *list);
 void mt76_tx_status_skb_done(struct mt76_dev *dev, struct sk_buff *skb,
 			     struct sk_buff_head *list);
-void mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid, struct sk_buff *skb);
+void __mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid, struct sk_buff *skb,
+			    struct list_head *free_list);
+static inline void
+mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid, struct sk_buff *skb)
+{
+    __mt76_tx_complete_skb(dev, wcid, skb, NULL);
+}
+
 void mt76_tx_status_check(struct mt76_dev *dev, struct mt76_wcid *wcid,
 			  bool flush);
 int mt76_sta_state(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 53ea8de82df0..70a830132a37 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -54,11 +54,23 @@ mt76_tx_status_unlock(struct mt76_dev *dev, struct sk_buff_head *list)
 
 	spin_unlock_bh(&dev->status_list.lock);
 
+	rcu_read_lock();
 	while ((skb = __skb_dequeue(list)) != NULL) {
+		struct ieee80211_tx_status status = {
+			.skb = skb,
+			.info = IEEE80211_SKB_CB(skb),
+		};
+		struct mt76_tx_cb *cb = mt76_tx_skb_cb(skb);
+		struct mt76_wcid *wcid;
+
+		wcid = rcu_dereference(dev->wcid[cb->wcid]);
+		if (wcid)
+			status.sta = wcid_to_sta(wcid);
+
 		hw = mt76_tx_status_get_hw(dev, skb);
-		ieee80211_tx_status(hw, skb);
+		ieee80211_tx_status_ext(hw, &status);
 	}
-
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(mt76_tx_status_unlock);
 
@@ -80,7 +92,7 @@ __mt76_tx_status_skb_done(struct mt76_dev *dev, struct sk_buff *skb, u8 flags,
 
 	/* Tx status can be unreliable. if it fails, mark the frame as ACKed */
 	if (flags & MT_TX_CB_TXS_FAILED) {
-		ieee80211_tx_info_clear_status(info);
+		info->status.rates[0].count = 0;
 		info->status.rates[0].idx = -1;
 		info->flags |= IEEE80211_TX_STAT_ACK;
 	}
@@ -173,36 +185,37 @@ mt76_tx_status_check(struct mt76_dev *dev, struct mt76_wcid *wcid, bool flush)
 EXPORT_SYMBOL_GPL(mt76_tx_status_check);
 
 static void
-mt76_tx_check_non_aql(struct mt76_dev *dev, u16 wcid_idx, struct sk_buff *skb)
+mt76_tx_check_non_aql(struct mt76_dev *dev, struct mt76_wcid *wcid,
+		      struct sk_buff *skb)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	struct mt76_wcid *wcid;
 	int pending;
 
-	if (info->tx_time_est)
+	if (!wcid || info->tx_time_est)
 		return;
 
-	if (wcid_idx >= ARRAY_SIZE(dev->wcid))
-		return;
-
-	rcu_read_lock();
-
-	wcid = rcu_dereference(dev->wcid[wcid_idx]);
-	if (wcid) {
-		pending = atomic_dec_return(&wcid->non_aql_packets);
-		if (pending < 0)
-			atomic_cmpxchg(&wcid->non_aql_packets, pending, 0);
-	}
-
-	rcu_read_unlock();
+	pending = atomic_dec_return(&wcid->non_aql_packets);
+	if (pending < 0)
+		atomic_cmpxchg(&wcid->non_aql_packets, pending, 0);
 }
 
-void mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid_idx, struct sk_buff *skb)
+void __mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid_idx, struct sk_buff *skb,
+			    struct list_head *free_list)
 {
+	struct ieee80211_tx_status status = {
+		.skb = skb,
+		.free_list = free_list,
+	};
+	struct mt76_wcid *wcid = NULL;
 	struct ieee80211_hw *hw;
 	struct sk_buff_head list;
 
-	mt76_tx_check_non_aql(dev, wcid_idx, skb);
+	rcu_read_lock();
+
+	if (wcid_idx < ARRAY_SIZE(dev->wcid))
+		wcid = rcu_dereference(dev->wcid[wcid_idx]);
+
+	mt76_tx_check_non_aql(dev, wcid, skb);
 
 #ifdef CONFIG_NL80211_TESTMODE
 	if (mt76_is_testmode_skb(dev, skb, &hw)) {
@@ -214,21 +227,25 @@ void mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid_idx, struct sk_buff *sk
 			wake_up(&dev->tx_wait);
 
 		dev_kfree_skb_any(skb);
-		return;
+		goto out;
 	}
 #endif
 
 	if (!skb->prev) {
 		hw = mt76_tx_status_get_hw(dev, skb);
-		ieee80211_free_txskb(hw, skb);
-		return;
+		status.sta = wcid_to_sta(wcid);
+		ieee80211_tx_status_ext(hw, &status);
+		goto out;
 	}
 
 	mt76_tx_status_lock(dev, &list);
 	__mt76_tx_status_skb_done(dev, skb, MT_TX_CB_DMA_DONE, &list);
 	mt76_tx_status_unlock(dev, &list);
+
+out:
+	rcu_read_unlock();
 }
-EXPORT_SYMBOL_GPL(mt76_tx_complete_skb);
+EXPORT_SYMBOL_GPL(__mt76_tx_complete_skb);
 
 static int
 __mt76_tx_queue_skb(struct mt76_phy *phy, int qid, struct sk_buff *skb,
@@ -244,11 +261,15 @@ __mt76_tx_queue_skb(struct mt76_phy *phy, int qid, struct sk_buff *skb,
 
 	non_aql = !info->tx_time_est;
 	idx = dev->queue_ops->tx_queue_skb(dev, q, skb, wcid, sta);
-	if (idx < 0 || !sta || !non_aql)
+	if (idx < 0 || !sta)
 		return idx;
 
 	wcid = (struct mt76_wcid *)sta->drv_priv;
 	q->entry[idx].wcid = wcid->idx;
+
+	if (!non_aql)
+		return idx;
+
 	pending = atomic_inc_return(&wcid->non_aql_packets);
 	if (stop && pending >= MT_MAX_NON_AQL_PKT)
 		*stop = true;
-- 
2.30.1

