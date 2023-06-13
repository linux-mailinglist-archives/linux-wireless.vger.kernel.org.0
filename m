Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E7872E5D8
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 16:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242934AbjFMOeN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 10:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242983AbjFMOeA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 10:34:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B471727
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 07:33:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A182C63726
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 14:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51AEC433F0;
        Tue, 13 Jun 2023 14:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686666834;
        bh=yKZz2ZsDU1MyM56KnR6CGsLopFqK07krZu9V+BDDPP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EFRgg7snrSwzcXGv/tjc/2uLfg2GiAxk55UDUyU/nTZM/FhnyCjJeELdBtBzfi2f1
         JA06zUw0E/ZXiIx72/AYpFS1pNybhNeAapc8ZkyN6VzQUz9LzKz2lvV5l1WkvnNlMt
         89gsOKlsNKEITdL1mzI7PSyzmVvHHuq6mbt6F4IU4MTS159o291pSv4v1zNnnKL+nD
         lvKURYLT+cYihzwgOe92H0hBlYyTXKRErOLpraXpH7CYW/tReJU8Eqcx/Z1URO0HuN
         LZgjb6CbZ6eSvFGa8g3NLmrWPePRQ6zYkCMqU4UEYe4y1Cq7j3pUiZX7Q5bd9KEKjZ
         eMaFb8a7pKL0A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        shayne.chen@mediatek.com, ryder.lee@mediatek.com,
        deren.wu@mediatek.com
Subject: [PATCH v3 09/15] wifi: mt76: mt7996: rely on shared poll_list field
Date:   Tue, 13 Jun 2023 16:32:37 +0200
Message-Id: <d09a57ba70ae5636b5620d882152863395284721.1686664917.git.lorenzo@kernel.org>
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

Rely on poll_list field in mt76_wcid  structure and get rid of
private copy.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c  | 16 ++++++++--------
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 12 ++++++------
 .../net/wireless/mediatek/mt76/mt7996/mt7996.h   |  1 -
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 18249572cb2e..5e1f26d3c5ad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -130,8 +130,8 @@ static void mt7996_mac_sta_poll(struct mt7996_dev *dev)
 			break;
 		}
 		msta = list_first_entry(&sta_poll_list,
-					struct mt7996_sta, poll_list);
-		list_del_init(&msta->poll_list);
+					struct mt7996_sta, wcid.poll_list);
+		list_del_init(&msta->wcid.poll_list);
 		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 		idx = msta->wcid.idx;
@@ -682,8 +682,8 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, struct sk_buff *skb)
 
 		msta = container_of(status->wcid, struct mt7996_sta, wcid);
 		spin_lock_bh(&dev->mt76.sta_poll_lock);
-		if (list_empty(&msta->poll_list))
-			list_add_tail(&msta->poll_list,
+		if (list_empty(&msta->wcid.poll_list))
+			list_add_tail(&msta->wcid.poll_list,
 				      &dev->mt76.sta_poll_list);
 		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 	}
@@ -1288,8 +1288,8 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 
 			msta = container_of(wcid, struct mt7996_sta, wcid);
 			spin_lock_bh(&mdev->sta_poll_lock);
-			if (list_empty(&msta->poll_list))
-				list_add_tail(&msta->poll_list,
+			if (list_empty(&msta->wcid.poll_list))
+				list_add_tail(&msta->wcid.poll_list,
 					      &mdev->sta_poll_list);
 			spin_unlock_bh(&mdev->sta_poll_lock);
 			continue;
@@ -1497,8 +1497,8 @@ static void mt7996_mac_add_txs(struct mt7996_dev *dev, void *data)
 		goto out;
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
-	if (list_empty(&msta->poll_list))
-		list_add_tail(&msta->poll_list, &dev->mt76.sta_poll_list);
+	if (list_empty(&msta->wcid.poll_list))
+		list_add_tail(&msta->wcid.poll_list, &dev->mt76.sta_poll_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 out:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index ecac04066fda..1a5d646631a6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -200,7 +200,7 @@ static int mt7996_add_interface(struct ieee80211_hw *hw,
 	idx = MT7996_WTBL_RESERVED - mvif->mt76.idx;
 
 	INIT_LIST_HEAD(&mvif->sta.rc_list);
-	INIT_LIST_HEAD(&mvif->sta.poll_list);
+	INIT_LIST_HEAD(&mvif->sta.wcid.poll_list);
 	mvif->sta.wcid.idx = idx;
 	mvif->sta.wcid.phy_idx = band_idx;
 	mvif->sta.wcid.hw_key_idx = -1;
@@ -263,8 +263,8 @@ static void mt7996_remove_interface(struct ieee80211_hw *hw,
 	mutex_unlock(&dev->mt76.mutex);
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
-	if (!list_empty(&msta->poll_list))
-		list_del_init(&msta->poll_list);
+	if (!list_empty(&msta->wcid.poll_list))
+		list_del_init(&msta->wcid.poll_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 	mt76_packet_id_flush(&dev->mt76, &msta->wcid);
@@ -632,7 +632,7 @@ int mt7996_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		return -ENOSPC;
 
 	INIT_LIST_HEAD(&msta->rc_list);
-	INIT_LIST_HEAD(&msta->poll_list);
+	INIT_LIST_HEAD(&msta->wcid.poll_list);
 	msta->vif = mvif;
 	msta->wcid.sta = 1;
 	msta->wcid.idx = idx;
@@ -668,8 +668,8 @@ void mt7996_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		mt7996_mac_twt_teardown_flow(dev, msta, i);
 
 	spin_lock_bh(&mdev->sta_poll_lock);
-	if (!list_empty(&msta->poll_list))
-		list_del_init(&msta->poll_list);
+	if (!list_empty(&msta->wcid.poll_list))
+		list_del_init(&msta->wcid.poll_list);
 	if (!list_empty(&msta->rc_list))
 		list_del_init(&msta->rc_list);
 	spin_unlock_bh(&mdev->sta_poll_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 9be7a5f80f4d..e1ab38bf9118 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -95,7 +95,6 @@ struct mt7996_sta {
 
 	struct mt7996_vif *vif;
 
-	struct list_head poll_list;
 	struct list_head rc_list;
 	u32 airtime_ac[8];
 
-- 
2.40.1

