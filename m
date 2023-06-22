Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F93273A673
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jun 2023 18:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjFVQvO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jun 2023 12:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjFVQvN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jun 2023 12:51:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD2010D
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 09:51:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 937166184D
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 16:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9847CC433C8;
        Thu, 22 Jun 2023 16:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687452671;
        bh=pgCOOC/rljmnSym4Gib74DXMilsYnwIUioftRgpqIKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XROA/wgl0MfhwDWMGGNDnnMOvbvCKHjrIxBFbJ6FEqCzRXlyX0R1tTR0Lg32lQ9Rb
         9YcMxiPMQY8OI9sC43oeCrLmMVFcAF9jbYiTqPERmwZhGesl/KQBUNPdktNLign00M
         4oOhr8lqH4oQf/NDMK0ObfHN9ktfJN5d4hm1GQVGi3XUt+61C7SHVEPdTeWTlqmqM7
         qYEY2L2oQGuRWl9GkRi6ceHha5Tiv2QeDv4rsZazdlppiwttcfoxaAzrVYPIP26rtL
         m8jiay35J2RBcmb6idvm3C+UycuxdP56tN2TYq41pyGg7nfzlpyOqzGzsnOf0qJu7R
         W7bOQP9pxFMvw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, deren.wu@mediatek.com,
        shayne.chen@mediatek.com
Subject: [PATCH v4 04/15] wifi: mt76: mt7996: rely on shared sta_poll_list and sta_poll_lock
Date:   Thu, 22 Jun 2023 18:50:21 +0200
Message-ID: <0831f25de04f1cc9a3cb12b21fe39a49b3b74140.1687452202.git.lorenzo@kernel.org>
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
index 38ff33a7fc12..e297e7cb3a7a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -856,9 +856,7 @@ int mt7996_register_device(struct mt7996_dev *dev)
 	INIT_WORK(&dev->rc_work, mt7996_mac_sta_rc_work);
 	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt7996_mac_work);
 	INIT_LIST_HEAD(&dev->sta_rc_list);
-	INIT_LIST_HEAD(&dev->sta_poll_list);
 	INIT_LIST_HEAD(&dev->twt_list);
-	spin_lock_init(&dev->sta_poll_lock);
 
 	init_waitqueue_head(&dev->reset_wait);
 	INIT_WORK(&dev->reset_work, mt7996_mac_reset_work);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index a39bb39af540..46b1dbcb4b45 100644
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
@@ -1291,10 +1292,11 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
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
 
@@ -1499,10 +1501,10 @@ static void mt7996_mac_add_txs(struct mt7996_dev *dev, void *data)
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
@@ -2325,7 +2327,7 @@ void mt7996_mac_sta_rc_work(struct work_struct *work)
 	u32 changed;
 	LIST_HEAD(list);
 
-	spin_lock_bh(&dev->sta_poll_lock);
+	spin_lock_bh(&dev->mt76.sta_poll_lock);
 	list_splice_init(&dev->sta_rc_list, &list);
 
 	while (!list_empty(&list)) {
@@ -2333,7 +2335,7 @@ void mt7996_mac_sta_rc_work(struct work_struct *work)
 		list_del_init(&msta->rc_list);
 		changed = msta->changed;
 		msta->changed = 0;
-		spin_unlock_bh(&dev->sta_poll_lock);
+		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 		sta = container_of((void *)msta, struct ieee80211_sta, drv_priv);
 		vif = container_of((void *)msta->vif, struct ieee80211_vif, drv_priv);
@@ -2345,10 +2347,10 @@ void mt7996_mac_sta_rc_work(struct work_struct *work)
 
 		/* TODO: smps change */
 
-		spin_lock_bh(&dev->sta_poll_lock);
+		spin_lock_bh(&dev->mt76.sta_poll_lock);
 	}
 
-	spin_unlock_bh(&dev->sta_poll_lock);
+	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 }
 
 void mt7996_mac_work(struct work_struct *work)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index f173d197fcf6..975aac210a7d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -263,10 +263,10 @@ static void mt7996_remove_interface(struct ieee80211_hw *hw,
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
@@ -689,12 +689,12 @@ void mt7996_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
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
@@ -1005,11 +1005,11 @@ static void mt7996_sta_rc_work(void *data, struct ieee80211_sta *sta)
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
index 23de7508c954..b45a9eecd71e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -224,9 +224,7 @@ struct mt7996_dev {
 #endif
 
 	struct list_head sta_rc_list;
-	struct list_head sta_poll_list;
 	struct list_head twt_list;
-	spinlock_t sta_poll_lock;
 
 	u32 hw_pattern;
 
-- 
2.41.0

