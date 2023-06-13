Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC9E72E5D2
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 16:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242720AbjFMOeI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 10:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242949AbjFMOdt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 10:33:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2AA1726
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 07:33:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F96663130
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 14:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDFBC433D9;
        Tue, 13 Jun 2023 14:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686666818;
        bh=OPmrK71qMy64vPoT6d4Tw4lBQQAA/BuLCxPBEPnPOzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MAJrmCuRP+P5azozVYvbOAHQBFfkGDNrPDXqlHBK1vnrwOe+gd/DstCdYJe0iTTJj
         +JmEPympIX24AwZdYS1ccB3O31z4RmjB7L9xMNuy7E8GecjIlwFvz0n5gOo2zAjAgS
         1C/7fBBl5zE4wowV2QpE8aCLP06yPs7pfJOektURLZ6nLPmz4N8wE/2Bit8KjXVUKq
         ZDwWTdVv5Qs1i4Uh9HOvQKizt11oP4kYyrEBAaMosnionQrUpIaY2iBnHca/rfbUkO
         N2EU48jIov5r9Ndi3XAnWXXF6jkr+XJfWWgjYNfsxGfqRnWtCmVVqeq9y5a7b8Wi96
         z1QTW5HhkYHLw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        shayne.chen@mediatek.com, ryder.lee@mediatek.com,
        deren.wu@mediatek.com
Subject: [PATCH v3 05/15] wifi: mt76: mt7921: rely on shared sta_poll_list and sta_poll_lock
Date:   Tue, 13 Jun 2023 16:32:33 +0200
Message-Id: <9a3a8b5b5631ca876ae3798d65b73b62d9d113e2.1686664917.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1686664917.git.lorenzo@kernel.org>
References: <cover.1686664917.git.lorenzo@kernel.org>
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
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  2 --
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 32 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  8 ++---
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  3 --
 4 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index e929f6eb65ce..cdb4478f04d0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -392,8 +392,6 @@ int mt7921_register_device(struct mt7921_dev *dev)
 #endif
 	skb_queue_head_init(&dev->phy.scan_event_list);
 	skb_queue_head_init(&dev->coredump.msg_list);
-	INIT_LIST_HEAD(&dev->sta_poll_list);
-	spin_lock_init(&dev->sta_poll_lock);
 
 	INIT_WORK(&dev->reset_work, mt7921_mac_reset_work);
 	INIT_WORK(&dev->init_work, mt7921_init_work);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index bde73859b5da..d81d78ac5c91 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -68,9 +68,9 @@ static void mt7921_mac_sta_poll(struct mt7921_dev *dev)
 	s8 rssi[4];
 	int i;
 
-	spin_lock_bh(&dev->sta_poll_lock);
-	list_splice_init(&dev->sta_poll_list, &sta_poll_list);
-	spin_unlock_bh(&dev->sta_poll_lock);
+	spin_lock_bh(&dev->mt76.sta_poll_lock);
+	list_splice_init(&dev->mt76.sta_poll_list, &sta_poll_list);
+	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 	while (true) {
 		bool clear = false;
@@ -78,15 +78,15 @@ static void mt7921_mac_sta_poll(struct mt7921_dev *dev)
 		u16 idx;
 		u8 bw;
 
-		spin_lock_bh(&dev->sta_poll_lock);
+		spin_lock_bh(&dev->mt76.sta_poll_lock);
 		if (list_empty(&sta_poll_list)) {
-			spin_unlock_bh(&dev->sta_poll_lock);
+			spin_unlock_bh(&dev->mt76.sta_poll_lock);
 			break;
 		}
 		msta = list_first_entry(&sta_poll_list,
 					struct mt7921_sta, poll_list);
 		list_del_init(&msta->poll_list);
-		spin_unlock_bh(&dev->sta_poll_lock);
+		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 		idx = msta->wcid.idx;
 		addr = mt7921_mac_wtbl_lmac_addr(idx, MT_WTBL_AC0_CTT_OFFSET);
@@ -280,10 +280,11 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 
 	if (status->wcid) {
 		msta = container_of(status->wcid, struct mt7921_sta, wcid);
-		spin_lock_bh(&dev->sta_poll_lock);
+		spin_lock_bh(&dev->mt76.sta_poll_lock);
 		if (list_empty(&msta->poll_list))
-			list_add_tail(&msta->poll_list, &dev->sta_poll_list);
-		spin_unlock_bh(&dev->sta_poll_lock);
+			list_add_tail(&msta->poll_list,
+				      &dev->mt76.sta_poll_list);
+		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 	}
 
 	mt7921_get_status_freq_info(dev, mphy, status, chfreq);
@@ -566,10 +567,10 @@ void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data)
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
@@ -647,10 +648,11 @@ static void mt7921_mac_tx_free(struct mt7921_dev *dev, void *data, int len)
 				continue;
 
 			msta = container_of(wcid, struct mt7921_sta, wcid);
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
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 0c9a472bc81a..ffbe48f33d49 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -357,10 +357,10 @@ static void mt7921_remove_interface(struct ieee80211_hw *hw,
 	phy->omac_mask &= ~BIT_ULL(mvif->mt76.omac_idx);
 	mt7921_mutex_release(dev);
 
-	spin_lock_bh(&dev->sta_poll_lock);
+	spin_lock_bh(&dev->mt76.sta_poll_lock);
 	if (!list_empty(&msta->poll_list))
 		list_del_init(&msta->poll_list);
-	spin_unlock_bh(&dev->sta_poll_lock);
+	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 	mt76_packet_id_flush(&dev->mt76, &msta->wcid);
 }
@@ -843,10 +843,10 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 						    mvif->ctx);
 	}
 
-	spin_lock_bh(&dev->sta_poll_lock);
+	spin_lock_bh(&dev->mt76.sta_poll_lock);
 	if (!list_empty(&msta->poll_list))
 		list_del_init(&msta->poll_list);
-	spin_unlock_bh(&dev->sta_poll_lock);
+	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 9640cc033300..ef1fe4d9ab99 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -303,9 +303,6 @@ struct mt7921_dev {
 	bool hw_init_done:1;
 	bool fw_assert:1;
 
-	struct list_head sta_poll_list;
-	spinlock_t sta_poll_lock;
-
 	struct work_struct init_work;
 
 	u8 fw_debug;
-- 
2.40.1

