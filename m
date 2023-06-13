Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B947C72E5CD
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 16:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242261AbjFMOeH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 10:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242928AbjFMOdo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 10:33:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73F31738
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 07:33:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A38C163725
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 14:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57A5C433F0;
        Tue, 13 Jun 2023 14:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686666815;
        bh=OYpsw9zUNNG9FUUXhVxN0+GzzKiZoHc0PafiZYwnyi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rkP+y1i49gnLf+KO4FjBvLNxyLx+zlFTOczbJyFbhX5vP7NB/S5EAI4eRQR1kL6sr
         IbB58GrTMWM3QPrpXpapj2cyIL4vX82wctlYEW52djc09rHroYurN7KFl1fMAd04h6
         P17ut2NgrZsKB10u5J0R56tvpzUX13kTnEgj8ZY1gUlBZzNPopGwI2CyxjtlwV7Raf
         dOcMDVEvWQd4jEwYIoBmRy9qt03mjYWch91gl1hVYeGU07jWmBjG82o01lnbTvZnlI
         n+aTjTLo/K23MHfapzhUyqDAGDUkfYQAj3kBO3FRRd0GkCa9ASfaxh6rmjnEbx+kSC
         eP6xX+ok0qNkA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        shayne.chen@mediatek.com, ryder.lee@mediatek.com,
        deren.wu@mediatek.com
Subject: [PATCH v3 04/15] wifi: mt76: mt7996: rely on shared sta_poll_list and sta_poll_lock
Date:   Tue, 13 Jun 2023 16:32:32 +0200
Message-Id: <de2cdc586d865d346506181b32ab304aac8e9bb7.1686664917.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1686664917.git.lorenzo@kernel.org>
References: <cover.1686664917.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on sta_poll_list and sta_poll_lock fields in mt76_dev structure
and get rid of private copies.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7996/init.c  |  2 -
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 40 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 12 +++---
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  2 -
 4 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index f1b48cdda58f..8f3536dbe2bb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -853,9 +853,7 @@ int mt7996_register_device(struct mt7996_dev *dev)
 	INIT_WORK(&dev->rc_work, mt7996_mac_sta_rc_work);
 	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt7996_mac_work);
 	INIT_LIST_HEAD(&dev->sta_rc_list);
-	INIT_LIST_HEAD(&dev->sta_poll_list);
 	INIT_LIST_HEAD(&dev->twt_list);
-	spin_lock_init(&dev->sta_poll_lock);
 
 	init_waitqueue_head(&dev->reset_wait);
 	INIT_WORK(&dev->reset_work, mt7996_mac_reset_work);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 740d08e9d5e5..18249572cb2e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -111,9 +111,9 @@ static void mt7996_mac_sta_poll(struct mt7996_dev *dev)
 	LIST_HEAD(sta_poll_list);
 	int i;
 
-	spin_lock_bh(&dev->sta_poll_lock);
-	list_splice_init(&dev->sta_poll_list, &sta_poll_list);
-	spin_unlock_bh(&dev->sta_poll_lock);
+	spin_lock_bh(&dev->mt76.sta_poll_lock);
+	list_splice_init(&dev->mt76.sta_poll_list, &sta_poll_list);
+	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 	rcu_read_lock();
 
@@ -124,15 +124,15 @@ static void mt7996_mac_sta_poll(struct mt7996_dev *dev)
 		s8 rssi[4];
 		u8 bw;
 
-		spin_lock_bh(&dev->sta_poll_lock);
+		spin_lock_bh(&dev->mt76.sta_poll_lock);
 		if (list_empty(&sta_poll_list)) {
-			spin_unlock_bh(&dev->sta_poll_lock);
+			spin_unlock_bh(&dev->mt76.sta_poll_lock);
 			break;
 		}
 		msta = list_first_entry(&sta_poll_list,
 					struct mt7996_sta, poll_list);
 		list_del_init(&msta->poll_list);
-		spin_unlock_bh(&dev->sta_poll_lock);
+		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 		idx = msta->wcid.idx;
 
@@ -681,10 +681,11 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, struct sk_buff *skb)
 		struct mt7996_sta *msta;
 
 		msta = container_of(status->wcid, struct mt7996_sta, wcid);
-		spin_lock_bh(&dev->sta_poll_lock);
+		spin_lock_bh(&dev->mt76.sta_poll_lock);
 		if (list_empty(&msta->poll_list))
-			list_add_tail(&msta->poll_list, &dev->sta_poll_list);
-		spin_unlock_bh(&dev->sta_poll_lock);
+			list_add_tail(&msta->poll_list,
+				      &dev->mt76.sta_poll_list);
+		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 	}
 
 	status->freq = mphy->chandef.chan->center_freq;
@@ -1286,10 +1287,11 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 				continue;
 
 			msta = container_of(wcid, struct mt7996_sta, wcid);
-			spin_lock_bh(&dev->sta_poll_lock);
+			spin_lock_bh(&mdev->sta_poll_lock);
 			if (list_empty(&msta->poll_list))
-				list_add_tail(&msta->poll_list, &dev->sta_poll_list);
-			spin_unlock_bh(&dev->sta_poll_lock);
+				list_add_tail(&msta->poll_list,
+					      &mdev->sta_poll_list);
+			spin_unlock_bh(&mdev->sta_poll_lock);
 			continue;
 		}
 
@@ -1494,10 +1496,10 @@ static void mt7996_mac_add_txs(struct mt7996_dev *dev, void *data)
 	if (!wcid->sta)
 		goto out;
 
-	spin_lock_bh(&dev->sta_poll_lock);
+	spin_lock_bh(&dev->mt76.sta_poll_lock);
 	if (list_empty(&msta->poll_list))
-		list_add_tail(&msta->poll_list, &dev->sta_poll_list);
-	spin_unlock_bh(&dev->sta_poll_lock);
+		list_add_tail(&msta->poll_list, &dev->mt76.sta_poll_list);
+	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 out:
 	rcu_read_unlock();
@@ -2340,7 +2342,7 @@ void mt7996_mac_sta_rc_work(struct work_struct *work)
 	u32 changed;
 	LIST_HEAD(list);
 
-	spin_lock_bh(&dev->sta_poll_lock);
+	spin_lock_bh(&dev->mt76.sta_poll_lock);
 	list_splice_init(&dev->sta_rc_list, &list);
 
 	while (!list_empty(&list)) {
@@ -2348,7 +2350,7 @@ void mt7996_mac_sta_rc_work(struct work_struct *work)
 		list_del_init(&msta->rc_list);
 		changed = msta->changed;
 		msta->changed = 0;
-		spin_unlock_bh(&dev->sta_poll_lock);
+		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 		sta = container_of((void *)msta, struct ieee80211_sta, drv_priv);
 		vif = container_of((void *)msta->vif, struct ieee80211_vif, drv_priv);
@@ -2360,10 +2362,10 @@ void mt7996_mac_sta_rc_work(struct work_struct *work)
 
 		/* TODO: smps change */
 
-		spin_lock_bh(&dev->sta_poll_lock);
+		spin_lock_bh(&dev->mt76.sta_poll_lock);
 	}
 
-	spin_unlock_bh(&dev->sta_poll_lock);
+	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 }
 
 void mt7996_mac_work(struct work_struct *work)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index c7917e301c87..ecac04066fda 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -262,10 +262,10 @@ static void mt7996_remove_interface(struct ieee80211_hw *hw,
 	phy->omac_mask &= ~BIT_ULL(mvif->mt76.omac_idx);
 	mutex_unlock(&dev->mt76.mutex);
 
-	spin_lock_bh(&dev->sta_poll_lock);
+	spin_lock_bh(&dev->mt76.sta_poll_lock);
 	if (!list_empty(&msta->poll_list))
 		list_del_init(&msta->poll_list);
-	spin_unlock_bh(&dev->sta_poll_lock);
+	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 	mt76_packet_id_flush(&dev->mt76, &msta->wcid);
 }
@@ -667,12 +667,12 @@ void mt7996_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	for (i = 0; i < ARRAY_SIZE(msta->twt.flow); i++)
 		mt7996_mac_twt_teardown_flow(dev, msta, i);
 
-	spin_lock_bh(&dev->sta_poll_lock);
+	spin_lock_bh(&mdev->sta_poll_lock);
 	if (!list_empty(&msta->poll_list))
 		list_del_init(&msta->poll_list);
 	if (!list_empty(&msta->rc_list))
 		list_del_init(&msta->rc_list);
-	spin_unlock_bh(&dev->sta_poll_lock);
+	spin_unlock_bh(&mdev->sta_poll_lock);
 }
 
 static void mt7996_tx(struct ieee80211_hw *hw,
@@ -982,11 +982,11 @@ static void mt7996_sta_rc_work(void *data, struct ieee80211_sta *sta)
 	struct mt7996_dev *dev = msta->vif->phy->dev;
 	u32 *changed = data;
 
-	spin_lock_bh(&dev->sta_poll_lock);
+	spin_lock_bh(&dev->mt76.sta_poll_lock);
 	msta->changed |= *changed;
 	if (list_empty(&msta->rc_list))
 		list_add_tail(&msta->rc_list, &dev->sta_rc_list);
-	spin_unlock_bh(&dev->sta_poll_lock);
+	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 }
 
 static void mt7996_sta_rc_update(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index c9f0e541abe4..9be7a5f80f4d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -270,9 +270,7 @@ struct mt7996_dev {
 #endif
 
 	struct list_head sta_rc_list;
-	struct list_head sta_poll_list;
 	struct list_head twt_list;
-	spinlock_t sta_poll_lock;
 
 	u32 hw_pattern;
 
-- 
2.40.1

