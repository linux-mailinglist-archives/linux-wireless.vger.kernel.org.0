Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFC171481C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 May 2023 12:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjE2KmU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 May 2023 06:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjE2KmT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 May 2023 06:42:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6DBE8
        for <linux-wireless@vger.kernel.org>; Mon, 29 May 2023 03:42:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE32F62355
        for <linux-wireless@vger.kernel.org>; Mon, 29 May 2023 10:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29D9C4339C;
        Mon, 29 May 2023 10:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685356933;
        bh=zL4T+vIwGBtzXntXbY/9KOqcnljqlQVEh1IpdQVSKbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U8tJo3eju/k7/swvQwwYRUw13R/G6PxTrDbSx1WthNDfZvc1SE7edfxIauJruobXs
         Q/Fltgs0Uxw0W+aJ00vbX/QzOg1t0+BzzCRJip7g0TzjlTLb8APdYgr8bM6y5kbCr/
         2R+SJEMcyJGC05rPO5rZYJPyeADNFiznYf7huLERewXqJ1J/4ykEBqqppjSSOC7FEU
         JGZYqY0qle55flGe2q7ytPfz7BuJhSz5irJ1v8MP73z5PCrbIxPp7pFuX1a8FPl+DZ
         yYIEQkBziYaU+PGpF/8xSJivUZ+HxUaZQqozE5/viPbXS9ywajFTg02ZlgBr9AhhmE
         bXz2M49CjwStw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH 11/13] wifi: mt76: mt7921: rely on shared poll_list field
Date:   Mon, 29 May 2023 12:41:02 +0200
Message-Id: <09f1cf3d730c41a2e1302acd4a2760187b50e6a3.1685356673.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685356673.git.lorenzo@kernel.org>
References: <cover.1685356673.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on poll_list field in mt76_wcid structure and get rid of
private copy.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c  | 16 ++++++++--------
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 12 ++++++------
 .../net/wireless/mediatek/mt76/mt7921/mt7921.h   |  1 -
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index d81d78ac5c91..561590713e0b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -84,8 +84,8 @@ static void mt7921_mac_sta_poll(struct mt7921_dev *dev)
 			break;
 		}
 		msta = list_first_entry(&sta_poll_list,
-					struct mt7921_sta, poll_list);
-		list_del_init(&msta->poll_list);
+					struct mt7921_sta, wcid.poll_list);
+		list_del_init(&msta->wcid.poll_list);
 		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 		idx = msta->wcid.idx;
@@ -281,8 +281,8 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 	if (status->wcid) {
 		msta = container_of(status->wcid, struct mt7921_sta, wcid);
 		spin_lock_bh(&dev->mt76.sta_poll_lock);
-		if (list_empty(&msta->poll_list))
-			list_add_tail(&msta->poll_list,
+		if (list_empty(&msta->wcid.poll_list))
+			list_add_tail(&msta->wcid.poll_list,
 				      &dev->mt76.sta_poll_list);
 		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 	}
@@ -568,8 +568,8 @@ void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data)
 		goto out;
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
-	if (list_empty(&msta->poll_list))
-		list_add_tail(&msta->poll_list, &dev->mt76.sta_poll_list);
+	if (list_empty(&msta->wcid.poll_list))
+		list_add_tail(&msta->wcid.poll_list, &dev->mt76.sta_poll_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 out:
@@ -649,8 +649,8 @@ static void mt7921_mac_tx_free(struct mt7921_dev *dev, void *data, int len)
 
 			msta = container_of(wcid, struct mt7921_sta, wcid);
 			spin_lock_bh(&mdev->sta_poll_lock);
-			if (list_empty(&msta->poll_list))
-				list_add_tail(&msta->poll_list,
+			if (list_empty(&msta->wcid.poll_list))
+				list_add_tail(&msta->wcid.poll_list,
 					      &mdev->sta_poll_list);
 			spin_unlock_bh(&mdev->sta_poll_lock);
 			continue;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index ffbe48f33d49..2512c1c1fb89 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -313,7 +313,7 @@ static int mt7921_add_interface(struct ieee80211_hw *hw,
 
 	idx = MT7921_WTBL_RESERVED - mvif->mt76.idx;
 
-	INIT_LIST_HEAD(&mvif->sta.poll_list);
+	INIT_LIST_HEAD(&mvif->sta.wcid.poll_list);
 	mvif->sta.wcid.idx = idx;
 	mvif->sta.wcid.phy_idx = mvif->mt76.band_idx;
 	mvif->sta.wcid.hw_key_idx = -1;
@@ -358,8 +358,8 @@ static void mt7921_remove_interface(struct ieee80211_hw *hw,
 	mt7921_mutex_release(dev);
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
-	if (!list_empty(&msta->poll_list))
-		list_del_init(&msta->poll_list);
+	if (!list_empty(&msta->wcid.poll_list))
+		list_del_init(&msta->wcid.poll_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 	mt76_packet_id_flush(&dev->mt76, &msta->wcid);
@@ -765,7 +765,7 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	if (idx < 0)
 		return -ENOSPC;
 
-	INIT_LIST_HEAD(&msta->poll_list);
+	INIT_LIST_HEAD(&msta->wcid.poll_list);
 	msta->vif = mvif;
 	msta->wcid.sta = 1;
 	msta->wcid.idx = idx;
@@ -844,8 +844,8 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	}
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
-	if (!list_empty(&msta->poll_list))
-		list_del_init(&msta->poll_list);
+	if (!list_empty(&msta->wcid.poll_list))
+		list_del_init(&msta->wcid.poll_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 78e1ae17834f..c8d7564ff17e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -151,7 +151,6 @@ struct mt7921_sta {
 
 	struct mt7921_vif *vif;
 
-	struct list_head poll_list;
 	u32 airtime_ac[8];
 
 	int ack_signal;
-- 
2.40.1

