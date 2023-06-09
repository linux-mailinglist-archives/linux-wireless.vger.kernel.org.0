Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC790729275
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 10:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239506AbjFIIQJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 04:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239432AbjFIIQH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 04:16:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D392132
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 01:16:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A94865198
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 08:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DE7C433EF;
        Fri,  9 Jun 2023 08:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686298565;
        bh=AR4fyZALblyLBVVOYRYuSdyTURsUxLuKK+IcTM7OeTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LoKC0d78XpWQtHU9xg4OEghYxxsc+RpJVaAufTJtbZfGK+uSy7I7tvzmUAok3Kl0d
         1Wu36aD2OIhy19tYDyf2zGAIzT2iJbZSITCQQmEADIXAUVVyOel4yiHDiPTop9zteV
         jW0kPfx4rTY1cLb55zfOaIA3UJGHS4ISE4qMvUiajkv9bjC6IY0tFzIyLN4BW/inMN
         F/RvrtWR/aVtzt0jxyek3YddfnOTAFNxVF+ThcfFQ9wGyU9JbQbaIZBbFS8Mw1uFjx
         dAPbTH3mcVKRCFNXKJ69JYIG+atSDtHU5eB1Rux1NVhUlx3zDZvLcmkPtGa86AHz2a
         oGYtTVR26ob/g==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH v2 03/15] wifi: mt76: mt7615: rely on shared sta_poll_list and sta_poll_lock
Date:   Fri,  9 Jun 2023 10:15:32 +0200
Message-Id: <713afba35f91cc6d70f54ed1d07cff86ffc0688e.1686298162.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1686298162.git.lorenzo@kernel.org>
References: <cover.1686298162.git.lorenzo@kernel.org>
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
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  2 --
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 23 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  8 +++----
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  3 ---
 4 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 621e69f07e3c..155931978ed8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -626,8 +626,6 @@ void mt7615_init_device(struct mt7615_dev *dev)
 	INIT_DELAYED_WORK(&dev->coredump.work, mt7615_coredump_work);
 	skb_queue_head_init(&dev->phy.scan_event_list);
 	skb_queue_head_init(&dev->coredump.msg_list);
-	INIT_LIST_HEAD(&dev->sta_poll_list);
-	spin_lock_init(&dev->sta_poll_lock);
 	init_waitqueue_head(&dev->reset_wait);
 	init_waitqueue_head(&dev->phy.roc_wait);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 415b5ff3ee4f..0fc6d7765f83 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -387,10 +387,11 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 		struct mt7615_sta *msta;
 
 		msta = container_of(status->wcid, struct mt7615_sta, wcid);
-		spin_lock_bh(&dev->sta_poll_lock);
+		spin_lock_bh(&dev->mt76.sta_poll_lock);
 		if (list_empty(&msta->poll_list))
-			list_add_tail(&msta->poll_list, &dev->sta_poll_list);
-		spin_unlock_bh(&dev->sta_poll_lock);
+			list_add_tail(&msta->poll_list,
+				      &dev->mt76.sta_poll_list);
+		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 	}
 
 	if (mt76_is_mmio(&dev->mt76) && (rxd0 & csum_mask) == csum_mask &&
@@ -905,9 +906,9 @@ void mt7615_mac_sta_poll(struct mt7615_dev *dev)
 	int i;
 
 	INIT_LIST_HEAD(&sta_poll_list);
-	spin_lock_bh(&dev->sta_poll_lock);
-	list_splice_init(&dev->sta_poll_list, &sta_poll_list);
-	spin_unlock_bh(&dev->sta_poll_lock);
+	spin_lock_bh(&dev->mt76.sta_poll_lock);
+	list_splice_init(&dev->mt76.sta_poll_list, &sta_poll_list);
+	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 	while (!list_empty(&sta_poll_list)) {
 		bool clear = false;
@@ -915,9 +916,9 @@ void mt7615_mac_sta_poll(struct mt7615_dev *dev)
 		msta = list_first_entry(&sta_poll_list, struct mt7615_sta,
 					poll_list);
 
-		spin_lock_bh(&dev->sta_poll_lock);
+		spin_lock_bh(&dev->mt76.sta_poll_lock);
 		list_del_init(&msta->poll_list);
-		spin_unlock_bh(&dev->sta_poll_lock);
+		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 		addr = mt7615_mac_wtbl_addr(dev, msta->wcid.idx) + 19 * 4;
 
@@ -1542,10 +1543,10 @@ static void mt7615_mac_add_txs(struct mt7615_dev *dev, void *data)
 	msta = container_of(wcid, struct mt7615_sta, wcid);
 	sta = wcid_to_sta(wcid);
 
-	spin_lock_bh(&dev->sta_poll_lock);
+	spin_lock_bh(&dev->mt76.sta_poll_lock);
 	if (list_empty(&msta->poll_list))
-		list_add_tail(&msta->poll_list, &dev->sta_poll_list);
-	spin_unlock_bh(&dev->sta_poll_lock);
+		list_add_tail(&msta->poll_list, &dev->mt76.sta_poll_list);
+	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 	if (mt7615_mac_add_txs_skb(dev, msta, pid, txs_data))
 		goto out;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index ab4c1b4478aa..2a5462bd54c2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -274,10 +274,10 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 
 	mt7615_mutex_release(dev);
 
-	spin_lock_bh(&dev->sta_poll_lock);
+	spin_lock_bh(&dev->mt76.sta_poll_lock);
 	if (!list_empty(&msta->poll_list))
 		list_del_init(&msta->poll_list);
-	spin_unlock_bh(&dev->sta_poll_lock);
+	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 	mt76_packet_id_flush(&dev->mt76, &mvif->sta.wcid);
 }
@@ -677,10 +677,10 @@ void mt7615_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
 		mt7615_mcu_add_bss_info(phy, vif, sta, false);
 
-	spin_lock_bh(&dev->sta_poll_lock);
+	spin_lock_bh(&mdev->sta_poll_lock);
 	if (!list_empty(&msta->poll_list))
 		list_del_init(&msta->poll_list);
-	spin_unlock_bh(&dev->sta_poll_lock);
+	spin_unlock_bh(&mdev->sta_poll_lock);
 
 	mt76_connac_power_save_sched(phy->mt76, &dev->pm);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 0381c53bc96a..7386495f8299 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -262,9 +262,6 @@ struct mt7615_dev {
 	wait_queue_head_t reset_wait;
 	u32 reset_state;
 
-	struct list_head sta_poll_list;
-	spinlock_t sta_poll_lock;
-
 	struct {
 		u8 n_pulses;
 		u32 period;
-- 
2.40.1

