Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0315272927A
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 10:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239337AbjFIIQg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 04:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240097AbjFIIQd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 04:16:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CF1210C
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 01:16:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CBD865477
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 08:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EA3C4339B;
        Fri,  9 Jun 2023 08:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686298581;
        bh=bEdOkulCWuOefQOBOqtNaW0inZO0GDOKGFMsOWjOkTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F7O7qfHFOUSx/nX9gY2A5EdmipxKqPuMQEhmeN6pDg4jeS5XAuNMYOBVRxJvmfX7F
         Qtknt0br/o7K06AoBa9k8cGaM8gPOQQUCs0/uncSv2ERAR5aa3elJSaEyPlNCB5Bmh
         QUGsZGuACj8ScIyzK3a+jHlJCcL3x4Q9yrqnR6g9KjMQgPvKYF84XnxBmQ110jt2sQ
         PlH9EC8i8DiDn1G3O5RVD13jjvzh7GilLO+v+K/UsDcvhB5lFdLkrqd1HOth3aHEoP
         sfIPa8pLS8A9qB1r0lNYQmTihIymuVYpFSIW/+w9CV4r1v3BaeaddFMwEkND/6PLVL
         Dwn3FE2aSJbXA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH v2 07/15] wifi: mt76: mt7603: rely on shared poll_list field
Date:   Fri,  9 Jun 2023 10:15:36 +0200
Message-Id: <c73fc99f49b07566458a4b10b8a487571fb4c552.1686298162.git.lorenzo@kernel.org>
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

