Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB6471481B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 May 2023 12:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjE2KmS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 May 2023 06:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjE2KmP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 May 2023 06:42:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C570DF
        for <linux-wireless@vger.kernel.org>; Mon, 29 May 2023 03:42:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21E59622A7
        for <linux-wireless@vger.kernel.org>; Mon, 29 May 2023 10:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367C4C433D2;
        Mon, 29 May 2023 10:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685356929;
        bh=TZdDEEq5Bjn+DnbT0/RNuPam61YIMtxnA1cvk9JKA2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WjsQLVKBTG3/WIDTaagAV4uUPfufyu4hAVCjpypu5KLMHaFSqigfBN62ChdY2fTSp
         tq0pp+v+JIYs8DAOKxjJSBAJX2rlFmYX/cl3AI+RU2v7X2dV0imLKOlv2so4EUx1m/
         Uioc1YzUWIhr2pqTdFsmvHZ5YhoDxggG7chICKtq22oWw6wFJnE2x9N2XlDhcXLR9D
         Q4jVWd30sLYHVmR0XzcE6JhKzcdyGhFIindGPJD4LMHXHelUqSACjQtXq+tOkLwNG5
         EWQzFHWvtCtpupo8rpjwxK4CCTJZL0ZxYtkzwpG4v/oeHtd2zmheVnUcMW6+fO6GZl
         MqNwF6y3uIqzQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH 10/13] wifi: mt76: mt7996: rely on shared poll_list field
Date:   Mon, 29 May 2023 12:41:01 +0200
Message-Id: <db2b64f1eb6515d82328337368fe6dc8d1ed3cb2.1685356673.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685356673.git.lorenzo@kernel.org>
References: <cover.1685356673.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index b2ad74798cf9..f69ade14e7ab 100644
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
@@ -1283,8 +1283,8 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 
 			msta = container_of(wcid, struct mt7996_sta, wcid);
 			spin_lock_bh(&mdev->sta_poll_lock);
-			if (list_empty(&msta->poll_list))
-				list_add_tail(&msta->poll_list,
+			if (list_empty(&msta->wcid.poll_list))
+				list_add_tail(&msta->wcid.poll_list,
 					      &mdev->sta_poll_list);
 			spin_unlock_bh(&mdev->sta_poll_lock);
 			continue;
@@ -1491,8 +1491,8 @@ static void mt7996_mac_add_txs(struct mt7996_dev *dev, void *data)
 		goto out;
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
-	if (list_empty(&msta->poll_list))
-		list_add_tail(&msta->poll_list, &dev->mt76.sta_poll_list);
+	if (list_empty(&msta->wcid.poll_list))
+		list_add_tail(&msta->wcid.poll_list, &dev->mt76.sta_poll_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 out:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index ee632467c1a3..1ab8dba4db9a 100644
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
index 313e94eae4ab..cf27f892eaf5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -95,7 +95,6 @@ struct mt7996_sta {
 
 	struct mt7996_vif *vif;
 
-	struct list_head poll_list;
 	struct list_head rc_list;
 	u32 airtime_ac[8];
 
-- 
2.40.1

