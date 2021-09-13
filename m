Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643B540882B
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Sep 2021 11:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbhIMJ1C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 05:27:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238444AbhIMJ06 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 05:26:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BEB760FE6;
        Mon, 13 Sep 2021 09:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631525139;
        bh=RuiYPSpojTVPkYg9GZHaoNkUDBDpegq2Nh2HNRC52UM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bZo1N7JmjRbwBWUvrGA+S86pqspdtZQ2C/NH9pztLNP1qaWhdIlIrKyG+SbODj+Hc
         RR4noVFLXNrltb1/6/sq2OrgPV5lh6Yo0KXEvFyteYgGfqI5jiAmjXbI4lFaNbgd2K
         ftQq+ypntTaAJ/JF9emSPzqlSUhJrqzLrjyVBZLkJM0jaReZr2LMreSyC2zPRyT1Fw
         zC6D57LPSlE+Rqu4DMkAqCMWPBloLZnTR9NbRFzxfCJGS8ulk6wgzaLZrlLYwWY94M
         Y7YqWqHlOo8MlszvrwsJG1MzhDboPIh2u7aK8bY25gq86sosPRhb4PwdbSXmHyph4V
         mCKX65xkcQAuQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        greearb@candelatech.com, mrkiko.rs@gmail.com
Subject: [PATCH 3/4] mt76: substitute sk_buff_head status_list with spinlock_t status_lock
Date:   Mon, 13 Sep 2021 11:25:04 +0200
Message-Id: <636b790f32c15ee22715ed927efaaee1bdc2ebf0.1631525026.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631525026.git.lorenzo@kernel.org>
References: <cover.1631525026.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Substitute sk_buff_head status_list with spinlock_t status_lock since we
just need it for locking

Tested-by: mrkiko.rs@gmail.com
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  7 ++++---
 drivers/net/wireless/mediatek/mt76/tx.c       | 14 +++++++-------
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 47e4494bcbff..29e6270032ad 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -543,9 +543,9 @@ mt76_alloc_device(struct device *pdev, unsigned int size,
 	spin_lock_init(&dev->rx_lock);
 	spin_lock_init(&dev->lock);
 	spin_lock_init(&dev->cc_lock);
+	spin_lock_init(&dev->status_lock);
 	mutex_init(&dev->mutex);
 	init_waitqueue_head(&dev->tx_wait);
-	skb_queue_head_init(&dev->status_list);
 
 	skb_queue_head_init(&dev->mcu.res_q);
 	init_waitqueue_head(&dev->mcu.wait);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index a62d74500fd0..bb3f7314fcf2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -693,7 +693,8 @@ struct mt76_dev {
 	int token_count;
 
 	wait_queue_head_t tx_wait;
-	struct sk_buff_head status_list;
+	/* spinclock used to protect wcid pktid linked list */
+	spinlock_t status_lock;
 
 	u32 wcid_mask[DIV_ROUND_UP(MT76_N_WCIDS, 32)];
 	u32 wcid_phy_mask[DIV_ROUND_UP(MT76_N_WCIDS, 32)];
@@ -1096,9 +1097,9 @@ void mt76_wcid_key_setup(struct mt76_dev *dev, struct mt76_wcid *wcid,
 			 struct ieee80211_key_conf *key);
 
 void mt76_tx_status_lock(struct mt76_dev *dev, struct sk_buff_head *list)
-			 __acquires(&dev->status_list.lock);
+			 __acquires(&dev->status_lock);
 void mt76_tx_status_unlock(struct mt76_dev *dev, struct sk_buff_head *list)
-			   __releases(&dev->status_list.lock);
+			   __releases(&dev->status_lock);
 
 int mt76_tx_status_skb_add(struct mt76_dev *dev, struct mt76_wcid *wcid,
 			   struct sk_buff *skb);
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 5f0040df9e1c..aca41468cd75 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -38,21 +38,21 @@ EXPORT_SYMBOL_GPL(mt76_tx_check_agg_ssn);
 
 void
 mt76_tx_status_lock(struct mt76_dev *dev, struct sk_buff_head *list)
-		   __acquires(&dev->status_list.lock)
+		   __acquires(&dev->status_lock)
 {
 	__skb_queue_head_init(list);
-	spin_lock_bh(&dev->status_list.lock);
+	spin_lock_bh(&dev->status_lock);
 }
 EXPORT_SYMBOL_GPL(mt76_tx_status_lock);
 
 void
 mt76_tx_status_unlock(struct mt76_dev *dev, struct sk_buff_head *list)
-		      __releases(&dev->status_list.lock)
+		      __releases(&dev->status_lock)
 {
 	struct ieee80211_hw *hw;
 	struct sk_buff *skb;
 
-	spin_unlock_bh(&dev->status_list.lock);
+	spin_unlock_bh(&dev->status_lock);
 
 	rcu_read_lock();
 	while ((skb = __skb_dequeue(list)) != NULL) {
@@ -130,7 +130,7 @@ mt76_tx_status_skb_add(struct mt76_dev *dev, struct mt76_wcid *wcid,
 			     IEEE80211_TX_CTL_RATE_CTRL_PROBE)))
 		return MT_PACKET_ID_NO_SKB;
 
-	spin_lock_bh(&dev->status_list.lock);
+	spin_lock_bh(&dev->status_lock);
 
 	pid = idr_alloc(&wcid->pktid, skb, MT_PACKET_ID_FIRST,
 			MT_PACKET_ID_MASK, GFP_ATOMIC);
@@ -147,7 +147,7 @@ mt76_tx_status_skb_add(struct mt76_dev *dev, struct mt76_wcid *wcid,
 		list_add_tail(&wcid->list, &dev->wcid_list);
 
 out:
-	spin_unlock_bh(&dev->status_list.lock);
+	spin_unlock_bh(&dev->status_lock);
 
 	return pid;
 }
@@ -160,7 +160,7 @@ mt76_tx_status_skb_get(struct mt76_dev *dev, struct mt76_wcid *wcid, int pktid,
 	struct sk_buff *skb;
 	int id;
 
-	lockdep_assert_held(&dev->status_list.lock);
+	lockdep_assert_held(&dev->status_lock);
 
 	skb = idr_remove(&wcid->pktid, pktid);
 	if (skb)
-- 
2.31.1

