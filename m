Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F4D73A670
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jun 2023 18:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjFVQu6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jun 2023 12:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjFVQu5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jun 2023 12:50:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649B910A
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 09:50:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8954618C4
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 16:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0700C433C0;
        Thu, 22 Jun 2023 16:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687452655;
        bh=4I3TLPTu6yk0qEp9h0zU3JnkPePDZ33z/w4ro7WZ4NI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eY2x8C4EKoE9z6YAZ/NnlWLvBPOhONIxZC7gJBf37AEshBrN+aqe1feA+3uw5IaLR
         X9/vG8w/43/qdKZeGDeBI6iSAYcAwOAienlbzupNpcACmbFRqNIVu7KsXGdjO4NRQi
         szRaH3cFpRJIhFrlovqTNu0ieabMr+ayVPubsyNcqTBD2BRyG3qJh7/BiDta/4e432
         08jCb09dK78rlb0Hcd6uBC1oqoGtf8sggjRB+TgfB7BwO4/qFZxEFzW+mlZmtUX2ml
         Ghf1X4M+OWG06zphYkHK1eg20VVouYv/ReWgxZBdrbQ3Jy0Y4sKMcP1W59EDGfkGme
         rZ8sD4/4pY86g==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, deren.wu@mediatek.com,
        shayne.chen@mediatek.com
Subject: [PATCH v4 01/15] wifi: mt76: mt7915: move sta_poll_list and sta_poll_lock in mt76_dev
Date:   Thu, 22 Jun 2023 18:50:18 +0200
Message-ID: <180cd9dc441ef94329079c54580bf843b25d3bbb.1687452202.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1687452202.git.lorenzo@kernel.org>
References: <cover.1687452202.git.lorenzo@kernel.org>
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

sta_poll_list and sta_poll_lock are used by most of the drivers, so move
them in mt76_dev structure.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c |  2 +
 drivers/net/wireless/mediatek/mt76/mt76.h     |  3 ++
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  2 -
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 47 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 12 ++---
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 -
 6 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 24ebf0504a3b..c0ff36a98bed 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -661,6 +661,8 @@ mt76_alloc_device(struct device *pdev, unsigned int size,
 	idr_init(&dev->rx_token);
 
 	INIT_LIST_HEAD(&dev->wcid_list);
+	INIT_LIST_HEAD(&dev->sta_poll_list);
+	spin_lock_init(&dev->sta_poll_lock);
 
 	INIT_LIST_HEAD(&dev->txwi_cache);
 	INIT_LIST_HEAD(&dev->rxwi_cache);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index c11a417c5e37..6becfcebb926 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -823,6 +823,9 @@ struct mt76_dev {
 	struct mt76_wcid __rcu *wcid[MT76_N_WCIDS];
 	struct list_head wcid_list;
 
+	struct list_head sta_poll_list;
+	spinlock_t sta_poll_lock;
+
 	u32 rev;
 
 	struct tasklet_struct pre_tbtt_tasklet;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 07cdf14c515f..fffab468efeb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -1185,9 +1185,7 @@ int mt7915_register_device(struct mt7915_dev *dev)
 	INIT_WORK(&dev->rc_work, mt7915_mac_sta_rc_work);
 	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt7915_mac_work);
 	INIT_LIST_HEAD(&dev->sta_rc_list);
-	INIT_LIST_HEAD(&dev->sta_poll_list);
 	INIT_LIST_HEAD(&dev->twt_list);
-	spin_lock_init(&dev->sta_poll_lock);
 
 	init_waitqueue_head(&dev->reset_wait);
 	INIT_WORK(&dev->reset_work, mt7915_mac_reset_work);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 2bc2fefa1cd0..8ed217ee592e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -105,9 +105,9 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 	LIST_HEAD(sta_poll_list);
 	int i;
 
-	spin_lock_bh(&dev->sta_poll_lock);
-	list_splice_init(&dev->sta_poll_list, &sta_poll_list);
-	spin_unlock_bh(&dev->sta_poll_lock);
+	spin_lock_bh(&dev->mt76.sta_poll_lock);
+	list_splice_init(&dev->mt76.sta_poll_list, &sta_poll_list);
+	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 	rcu_read_lock();
 
@@ -118,15 +118,15 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
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
 					struct mt7915_sta, poll_list);
 		list_del_init(&msta->poll_list);
-		spin_unlock_bh(&dev->sta_poll_lock);
+		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 		idx = msta->wcid.idx;
 
@@ -326,10 +326,11 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb,
 
 	if (status->wcid) {
 		msta = container_of(status->wcid, struct mt7915_sta, wcid);
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
@@ -892,10 +893,11 @@ mt7915_txwi_free(struct mt7915_dev *dev, struct mt76_txwi_cache *t,
 			msta = container_of(wcid, struct mt7915_sta, wcid);
 			sta = container_of((void *)msta, struct ieee80211_sta,
 					  drv_priv);
-			spin_lock_bh(&dev->sta_poll_lock);
+			spin_lock_bh(&mdev->sta_poll_lock);
 			if (list_empty(&msta->poll_list))
-				list_add_tail(&msta->poll_list, &dev->sta_poll_list);
-			spin_unlock_bh(&dev->sta_poll_lock);
+				list_add_tail(&msta->poll_list,
+					      &mdev->sta_poll_list);
+			spin_unlock_bh(&mdev->sta_poll_lock);
 		}
 	}
 
@@ -987,10 +989,11 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 				continue;
 
 			msta = container_of(wcid, struct mt7915_sta, wcid);
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
 
@@ -1099,10 +1102,10 @@ static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
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
@@ -2039,7 +2042,7 @@ void mt7915_mac_sta_rc_work(struct work_struct *work)
 	u32 changed;
 	LIST_HEAD(list);
 
-	spin_lock_bh(&dev->sta_poll_lock);
+	spin_lock_bh(&dev->mt76.sta_poll_lock);
 	list_splice_init(&dev->sta_rc_list, &list);
 
 	while (!list_empty(&list)) {
@@ -2047,7 +2050,7 @@ void mt7915_mac_sta_rc_work(struct work_struct *work)
 		list_del_init(&msta->rc_list);
 		changed = msta->changed;
 		msta->changed = 0;
-		spin_unlock_bh(&dev->sta_poll_lock);
+		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 		sta = container_of((void *)msta, struct ieee80211_sta, drv_priv);
 		vif = container_of((void *)msta->vif, struct ieee80211_vif, drv_priv);
@@ -2060,10 +2063,10 @@ void mt7915_mac_sta_rc_work(struct work_struct *work)
 		if (changed & IEEE80211_RC_SMPS_CHANGED)
 			mt7915_mcu_add_smps(dev, vif, sta);
 
-		spin_lock_bh(&dev->sta_poll_lock);
+		spin_lock_bh(&dev->mt76.sta_poll_lock);
 	}
 
-	spin_unlock_bh(&dev->sta_poll_lock);
+	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 }
 
 void mt7915_mac_work(struct work_struct *work)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 882dbaeecb78..465ee0a20041 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -308,10 +308,10 @@ static void mt7915_remove_interface(struct ieee80211_hw *hw,
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
@@ -740,12 +740,12 @@ void mt7915_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	for (i = 0; i < ARRAY_SIZE(msta->twt.flow); i++)
 		mt7915_mac_twt_teardown_flow(dev, msta, i);
 
-	spin_lock_bh(&dev->sta_poll_lock);
+	spin_lock_bh(&mdev->sta_poll_lock);
 	if (!list_empty(&msta->poll_list))
 		list_del_init(&msta->poll_list);
 	if (!list_empty(&msta->rc_list))
 		list_del_init(&msta->rc_list);
-	spin_unlock_bh(&dev->sta_poll_lock);
+	spin_unlock_bh(&mdev->sta_poll_lock);
 }
 
 static void mt7915_tx(struct ieee80211_hw *hw,
@@ -1100,11 +1100,11 @@ static void mt7915_sta_rc_work(void *data, struct ieee80211_sta *sta)
 	struct mt7915_dev *dev = msta->vif->phy->dev;
 	u32 *changed = data;
 
-	spin_lock_bh(&dev->sta_poll_lock);
+	spin_lock_bh(&dev->mt76.sta_poll_lock);
 	msta->changed |= *changed;
 	if (list_empty(&msta->rc_list))
 		list_add_tail(&msta->rc_list, &dev->sta_rc_list);
-	spin_unlock_bh(&dev->sta_poll_lock);
+	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 }
 
 static void mt7915_sta_rc_update(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 93b536e01eb5..fe5f90822b34 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -274,9 +274,7 @@ struct mt7915_dev {
 #endif
 
 	struct list_head sta_rc_list;
-	struct list_head sta_poll_list;
 	struct list_head twt_list;
-	spinlock_t sta_poll_lock;
 
 	u32 hw_pattern;
 
-- 
2.41.0

