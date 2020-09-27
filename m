Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607BB27A204
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Sep 2020 19:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgI0RTA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Sep 2020 13:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgI0RS4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Sep 2020 13:18:56 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACC5C0613D3
        for <linux-wireless@vger.kernel.org>; Sun, 27 Sep 2020 10:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DWZlNSjMLbvprOQj/I8OSEvmPTpri7ZdhcZumO9tgig=; b=TgE8J+m1SX/a5DafMWztMh5rvE
        +0abQLjmZmyvtHMHp7HHVQD+F5HV+yQ46HG/29hV01tySM7LRdDWAzCmQU9yhodEt0nhFW+jWamh0
        krg4Sj320M4b8mmaixof3bbf+9AaMnN7FkFTOEJEcDhaAom9sPkyDmoLGzQcbK3QRxSk=;
Received: from p4ff134da.dip0.t-ipconnect.de ([79.241.52.218] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kMaK6-0002oU-Of
        for linux-wireless@vger.kernel.org; Sun, 27 Sep 2020 19:18:54 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 8/8] mt76: mt7915: use napi_consume_skb to bulk-free tx skbs
Date:   Sun, 27 Sep 2020 19:18:52 +0200
Message-Id: <20200927171852.48669-8-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200927171852.48669-1-nbd@nbd.name>
References: <20200927171852.48669-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Slightly improves performance

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 52 ++++++++-----------
 1 file changed, 21 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 3456d9532f29..a7118df7b93f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -858,17 +858,19 @@ mt7915_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
 		ieee80211_start_tx_ba_session(sta, tid, 0);
 }
 
-static inline void
-mt7915_tx_status(struct ieee80211_sta *sta, struct ieee80211_hw *hw,
-		 struct ieee80211_tx_info *info, struct sk_buff *skb)
+static void
+mt7915_tx_complete_status(struct mt76_dev *mdev, struct sk_buff *skb,
+			  struct ieee80211_sta *sta, u8 stat,
+			  struct list_head *free_list)
 {
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_tx_status status = {
 		.sta = sta,
 		.info = info,
+		.skb = skb,
+		.free_list = free_list,
 	};
-
-	if (skb)
-		status.skb = skb;
+	struct ieee80211_hw *hw;
 
 	if (sta) {
 		struct mt7915_sta *msta;
@@ -877,17 +879,6 @@ mt7915_tx_status(struct ieee80211_sta *sta, struct ieee80211_hw *hw,
 		status.rate = &msta->stats.tx_rate;
 	}
 
-	/* use status_ext to report HE rate */
-	ieee80211_tx_status_ext(hw, &status);
-}
-
-static void
-mt7915_tx_complete_status(struct mt76_dev *mdev, struct sk_buff *skb,
-			  struct ieee80211_sta *sta, u8 stat)
-{
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	struct ieee80211_hw *hw;
-
 	hw = mt76_tx_status_get_hw(mdev, skb);
 
 	if (info->flags & IEEE80211_TX_CTL_AMPDU)
@@ -900,17 +891,7 @@ mt7915_tx_complete_status(struct mt76_dev *mdev, struct sk_buff *skb,
 		info->flags |= IEEE80211_TX_STAT_ACK;
 
 	info->status.tx_time = 0;
-
-	if (info->flags & (IEEE80211_TX_CTL_REQ_TX_STATUS |
-			   IEEE80211_TX_CTL_HW_80211_ENCAP)) {
-		mt7915_tx_status(sta, hw, info, skb);
-		return;
-	}
-
-	if (sta || !(info->flags & IEEE80211_TX_CTL_NO_ACK))
-		mt7915_tx_status(sta, hw, info, NULL);
-
-	ieee80211_free_txskb(hw, skb);
+	ieee80211_tx_status_ext(hw, &status);
 }
 
 void mt7915_txp_skb_unmap(struct mt76_dev *dev,
@@ -931,6 +912,8 @@ void mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 	struct mt76_dev *mdev = &dev->mt76;
 	struct mt76_txwi_cache *txwi;
 	struct ieee80211_sta *sta = NULL;
+	LIST_HEAD(free_list);
+	struct sk_buff *tmp;
 	u8 i, count;
 
 	/* clean DMA queues and unmap buffers first */
@@ -1002,16 +985,22 @@ void mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 					atomic_cmpxchg(&wcid->non_aql_packets, pending, 0);
 			}
 
-			mt7915_tx_complete_status(mdev, txwi->skb, sta, stat);
+			mt7915_tx_complete_status(mdev, txwi->skb, sta, stat, &free_list);
 			txwi->skb = NULL;
 		}
 
 		mt76_put_txwi(mdev, txwi);
 	}
-	dev_kfree_skb(skb);
 
 	mt7915_mac_sta_poll(dev);
 	mt76_worker_schedule(&dev->mt76.tx_worker);
+
+	napi_consume_skb(skb, 1);
+
+	list_for_each_entry_safe(skb, tmp, &free_list, list) {
+		skb_list_del_init(skb);
+		napi_consume_skb(skb, 1);
+	}
 }
 
 void mt7915_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
@@ -1044,7 +1033,8 @@ void mt7915_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 
 		wcid = rcu_dereference(dev->mt76.wcid[cb->wcid]);
 
-		mt7915_tx_complete_status(mdev, e->skb, wcid_to_sta(wcid), 0);
+		mt7915_tx_complete_status(mdev, e->skb, wcid_to_sta(wcid), 0,
+					  NULL);
 	}
 }
 
-- 
2.28.0

