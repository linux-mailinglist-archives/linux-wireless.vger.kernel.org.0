Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D44714819
	for <lists+linux-wireless@lfdr.de>; Mon, 29 May 2023 12:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjE2KmJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 May 2023 06:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjE2KmH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 May 2023 06:42:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D508E8
        for <linux-wireless@vger.kernel.org>; Mon, 29 May 2023 03:42:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEFB5622A7
        for <linux-wireless@vger.kernel.org>; Mon, 29 May 2023 10:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFBA1C433D2;
        Mon, 29 May 2023 10:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685356922;
        bh=bEdOkulCWuOefQOBOqtNaW0inZO0GDOKGFMsOWjOkTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CTM4t4Lr3QJ5+/fUEDPT0ckiFuvrhfU2WyjAV3+uRTKUxTxSC23Ko5BbwaZAiwc+/
         GH2eJUFQrxnebHMblXYwEpWDdk06rGatKPQ64h7Sc2aIFazod1EK9/rS7Dm6WrtcRB
         6F7eawqalXVkCNfdU1V1UO2oKvFBD+6EbnraDnAXjKvtZl2EWDOenXIJ1JsN4ohEN3
         gxWi7vORfOZJXL/MCpb0sHJpKcS8iOLB37piPTNa49X8CfLXtP7OEcb7/nOSDJPP5l
         ICc1OR1hwGwENosIjfE0xnhPOSwt2tBeMtiMRpTRSJov7d6Wf9D4m01rm618Xmyfbm
         YI5jS/JAuDgcw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH 08/13] wifi: mt76: mt7603: rely on shared poll_list field
Date:   Mon, 29 May 2023 12:40:59 +0200
Message-Id: <dda5c9ff257fed6d0d6fb6c53a45a2f1aa00698f.1685356673.git.lorenzo@kernel.org>
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
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c    |  8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7603/main.c   | 12 ++++++------
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h |  1 -
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index ac8a67e10a4d..de11557eb04c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -419,8 +419,8 @@ void mt7603_mac_sta_poll(struct mt7603_dev *dev)
 		}
 
 		msta = list_first_entry(&dev->mt76.sta_poll_list,
-					struct mt7603_sta, poll_list);
-		list_del_init(&msta->poll_list);
+					struct mt7603_sta, wcid.poll_list);
+		list_del_init(&msta->wcid.poll_list);
 		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 		addr = mt7603_wtbl4_addr(msta->wcid.idx);
@@ -1267,9 +1267,9 @@ void mt7603_mac_add_txs(struct mt7603_dev *dev, void *data)
 	msta = container_of(wcid, struct mt7603_sta, wcid);
 	sta = wcid_to_sta(wcid);
 
-	if (list_empty(&msta->poll_list)) {
+	if (list_empty(&msta->wcid.poll_list)) {
 		spin_lock_bh(&dev->mt76.sta_poll_lock);
-		list_add_tail(&msta->poll_list, &dev->mt76.sta_poll_list);
+		list_add_tail(&msta->wcid.poll_list, &dev->mt76.sta_poll_list);
 		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 2affa62caf2b..36f287bbddd1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -66,7 +66,7 @@ mt7603_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 
 	idx = MT7603_WTBL_RESERVED - 1 - mvif->idx;
 	dev->mt76.vif_mask |= BIT_ULL(mvif->idx);
-	INIT_LIST_HEAD(&mvif->sta.poll_list);
+	INIT_LIST_HEAD(&mvif->sta.wcid.poll_list);
 	mvif->sta.wcid.idx = idx;
 	mvif->sta.wcid.hw_key_idx = -1;
 	mt76_packet_id_init(&mvif->sta.wcid);
@@ -101,8 +101,8 @@ mt7603_remove_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
-	if (!list_empty(&msta->poll_list))
-		list_del_init(&msta->poll_list);
+	if (!list_empty(&msta->wcid.poll_list))
+		list_del_init(&msta->wcid.poll_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 	mutex_lock(&dev->mt76.mutex);
@@ -351,7 +351,7 @@ mt7603_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	if (idx < 0)
 		return -ENOSPC;
 
-	INIT_LIST_HEAD(&msta->poll_list);
+	INIT_LIST_HEAD(&msta->wcid.poll_list);
 	__skb_queue_head_init(&msta->psq);
 	msta->ps = ~0;
 	msta->smps = ~0;
@@ -389,8 +389,8 @@ mt7603_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	spin_unlock_bh(&dev->ps_lock);
 
 	spin_lock_bh(&mdev->sta_poll_lock);
-	if (!list_empty(&msta->poll_list))
-		list_del_init(&msta->poll_list);
+	if (!list_empty(&msta->wcid.poll_list))
+		list_del_init(&msta->wcid.poll_list);
 	spin_unlock_bh(&mdev->sta_poll_lock);
 
 	mt7603_wtbl_clear(dev, wcid->idx);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index 689922d133e7..354b189862f7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -64,7 +64,6 @@ struct mt7603_sta {
 
 	struct mt7603_vif *vif;
 
-	struct list_head poll_list;
 	u32 tx_airtime_ac[4];
 
 	struct sk_buff_head psq;
-- 
2.40.1

