Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63C1729278
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 10:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240087AbjFIIQa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 04:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240127AbjFIIQ2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 04:16:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CD2359E
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 01:16:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8659E65475
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 08:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9B6C4339B;
        Fri,  9 Jun 2023 08:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686298577;
        bh=ZzaJJeuF4aXMwf+ltR3hOB0XLZRsZdXWO8xWF/E94Tw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jICNTL5FdxhsAfDBHCaPBssXxu/5GFBVj+iDPU5IPWP3roJUiodWZQdN5qQ1J2FYn
         x93v3+mHxWR0vgn8ZlOSw+1oYhPX+YCum/MIaFCnFQ9rFkXCqm98DWP77CtwUiGjJx
         J6ctb+gMLOvOwzMf4GuXQT6aGEpuwF7FhNUFuXzYLxNWYHyNEaBrZ5Xz+eIZSslwR4
         +W7nVVB+8TqSUwN56yVo8XAPxgZVRa61oM8+j2aJT4yVc7qXcUZFcH/OeLpL7FB38G
         YcKVP5twqKW4yRRaxfjAt2OUYFXwUUCnsTjxm291EYPZDuVHAZHj7VYBBUignIl6oN
         JVa/Q3lk7XaHA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH v2 06/15] wifi: mt76: mt7915: move poll_list in mt76_wcid
Date:   Fri,  9 Jun 2023 10:15:35 +0200
Message-Id: <1d4716560a7433a1f0d916ee069e51f34f013837.1686298162.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1686298162.git.lorenzo@kernel.org>
References: <cover.1686298162.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

poll_list field is used by most of the drivers, so move it in mt76_wcid
structure.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 ++
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 20 +++++++++----------
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 12 +++++------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  1 -
 4 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 5eae2e666ff6..997bd722b045 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -336,6 +336,8 @@ struct mt76_wcid {
 	struct idr pktid;
 
 	struct mt76_sta_stats stats;
+
+	struct list_head poll_list;
 };
 
 struct mt76_txq {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index f29ab70d3ce2..b499ab7d95f8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -124,8 +124,8 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 			break;
 		}
 		msta = list_first_entry(&sta_poll_list,
-					struct mt7915_sta, poll_list);
-		list_del_init(&msta->poll_list);
+					struct mt7915_sta, wcid.poll_list);
+		list_del_init(&msta->wcid.poll_list);
 		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 		idx = msta->wcid.idx;
@@ -327,8 +327,8 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb,
 	if (status->wcid) {
 		msta = container_of(status->wcid, struct mt7915_sta, wcid);
 		spin_lock_bh(&dev->mt76.sta_poll_lock);
-		if (list_empty(&msta->poll_list))
-			list_add_tail(&msta->poll_list,
+		if (list_empty(&msta->wcid.poll_list))
+			list_add_tail(&msta->wcid.poll_list,
 				      &dev->mt76.sta_poll_list);
 		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 	}
@@ -894,8 +894,8 @@ mt7915_txwi_free(struct mt7915_dev *dev, struct mt76_txwi_cache *t,
 			sta = container_of((void *)msta, struct ieee80211_sta,
 					  drv_priv);
 			spin_lock_bh(&mdev->sta_poll_lock);
-			if (list_empty(&msta->poll_list))
-				list_add_tail(&msta->poll_list,
+			if (list_empty(&msta->wcid.poll_list))
+				list_add_tail(&msta->wcid.poll_list,
 					      &mdev->sta_poll_list);
 			spin_unlock_bh(&mdev->sta_poll_lock);
 		}
@@ -990,8 +990,8 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 
 			msta = container_of(wcid, struct mt7915_sta, wcid);
 			spin_lock_bh(&mdev->sta_poll_lock);
-			if (list_empty(&msta->poll_list))
-				list_add_tail(&msta->poll_list,
+			if (list_empty(&msta->wcid.poll_list))
+				list_add_tail(&msta->wcid.poll_list,
 					      &mdev->sta_poll_list);
 			spin_unlock_bh(&mdev->sta_poll_lock);
 			continue;
@@ -1085,8 +1085,8 @@ static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
 		goto out;
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
-	if (list_empty(&msta->poll_list))
-		list_add_tail(&msta->poll_list, &dev->mt76.sta_poll_list);
+	if (list_empty(&msta->wcid.poll_list))
+		list_add_tail(&msta->wcid.poll_list, &dev->mt76.sta_poll_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 out:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 805b4522a813..cf1ed8632925 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -248,7 +248,7 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	idx = MT7915_WTBL_RESERVED - mvif->mt76.idx;
 
 	INIT_LIST_HEAD(&mvif->sta.rc_list);
-	INIT_LIST_HEAD(&mvif->sta.poll_list);
+	INIT_LIST_HEAD(&mvif->sta.wcid.poll_list);
 	mvif->sta.wcid.idx = idx;
 	mvif->sta.wcid.phy_idx = ext_phy;
 	mvif->sta.wcid.hw_key_idx = -1;
@@ -309,8 +309,8 @@ static void mt7915_remove_interface(struct ieee80211_hw *hw,
 	mutex_unlock(&dev->mt76.mutex);
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
-	if (!list_empty(&msta->poll_list))
-		list_del_init(&msta->poll_list);
+	if (!list_empty(&msta->wcid.poll_list))
+		list_del_init(&msta->wcid.poll_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 	mt76_packet_id_flush(&dev->mt76, &msta->wcid);
@@ -680,7 +680,7 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		return -ENOSPC;
 
 	INIT_LIST_HEAD(&msta->rc_list);
-	INIT_LIST_HEAD(&msta->poll_list);
+	INIT_LIST_HEAD(&msta->wcid.poll_list);
 	msta->vif = mvif;
 	msta->wcid.sta = 1;
 	msta->wcid.idx = idx;
@@ -716,8 +716,8 @@ void mt7915_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		mt7915_mac_twt_teardown_flow(dev, msta, i);
 
 	spin_lock_bh(&mdev->sta_poll_lock);
-	if (!list_empty(&msta->poll_list))
-		list_del_init(&msta->poll_list);
+	if (!list_empty(&msta->wcid.poll_list))
+		list_del_init(&msta->wcid.poll_list);
 	if (!list_empty(&msta->rc_list))
 		list_del_init(&msta->rc_list);
 	spin_unlock_bh(&mdev->sta_poll_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index f8ff190e9c4e..0ebd44fa5f5f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -129,7 +129,6 @@ struct mt7915_sta {
 
 	struct mt7915_vif *vif;
 
-	struct list_head poll_list;
 	struct list_head rc_list;
 	u32 airtime_ac[8];
 
-- 
2.40.1

