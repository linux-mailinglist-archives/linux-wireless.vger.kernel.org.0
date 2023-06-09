Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED37729270
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 10:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240071AbjFIIQF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 04:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238963AbjFIIQF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 04:16:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55052121
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 01:16:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7320565198
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 08:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B46C433D2;
        Fri,  9 Jun 2023 08:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686298561;
        bh=APZV41sSLKhwHB92+tLxSCoRN4r+Oh/gMwVm8Ug7ON8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XKIH5AJsQjAKEi9wAX9ZhWp0XJ9vn3aR6M4k15RIlJYjq0Qwke1tEcGjLN/OCYAhj
         Um25qpPVzgeXwgSa/Dn6sFIlKTqIV1EHxSgHi+IPble24IA8P5Q0ZU5UUd3K9LVDqW
         xtlg4SmweB9RPrTHCEJ5IDMTpZIkAT7GplsrxNSlN/Ky7S8We2Rj3brJ5rZGqVP+22
         9baNCfxVa8v/tEm1cGkmut1N72XfuVG2itdDd9iMJUBtj1N4BszY+o7W1DLCgZVFb9
         ASAIesKhBmE/LIHo13EX0VSs+YUdtHklywu0rFdPRGwiJsU4KRMoVKyf1GwOVOu8MW
         +rsV9FcnMr3SA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH v2 02/15] wifi: mt76: mt7603: rely on shared sta_poll_list and sta_poll_lock
Date:   Fri,  9 Jun 2023 10:15:31 +0200
Message-Id: <1a6233c7bca8c5c98d7efa3d4dd866eb579f6df4.1686298162.git.lorenzo@kernel.org>
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
 .../net/wireless/mediatek/mt76/mt7603/init.c   |  2 --
 .../net/wireless/mediatek/mt76/mt7603/mac.c    | 18 +++++++++---------
 .../net/wireless/mediatek/mt76/mt7603/main.c   |  8 ++++----
 .../net/wireless/mediatek/mt76/mt7603/mt7603.h |  3 ---
 4 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 9a2e632d577a..0762de3ce5ac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -500,8 +500,6 @@ int mt7603_register_device(struct mt7603_dev *dev)
 	bus_ops->rmw = mt7603_rmw;
 	dev->mt76.bus = bus_ops;
 
-	INIT_LIST_HEAD(&dev->sta_poll_list);
-	spin_lock_init(&dev->sta_poll_lock);
 	spin_lock_init(&dev->ps_lock);
 
 	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt7603_mac_work);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 12e0af52082a..ac8a67e10a4d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -412,16 +412,16 @@ void mt7603_mac_sta_poll(struct mt7603_dev *dev)
 	while (1) {
 		bool clear = false;
 
-		spin_lock_bh(&dev->sta_poll_lock);
-		if (list_empty(&dev->sta_poll_list)) {
-			spin_unlock_bh(&dev->sta_poll_lock);
+		spin_lock_bh(&dev->mt76.sta_poll_lock);
+		if (list_empty(&dev->mt76.sta_poll_list)) {
+			spin_unlock_bh(&dev->mt76.sta_poll_lock);
 			break;
 		}
 
-		msta = list_first_entry(&dev->sta_poll_list, struct mt7603_sta,
-					poll_list);
+		msta = list_first_entry(&dev->mt76.sta_poll_list,
+					struct mt7603_sta, poll_list);
 		list_del_init(&msta->poll_list);
-		spin_unlock_bh(&dev->sta_poll_lock);
+		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 		addr = mt7603_wtbl4_addr(msta->wcid.idx);
 		for (i = 0; i < 4; i++) {
@@ -1268,9 +1268,9 @@ void mt7603_mac_add_txs(struct mt7603_dev *dev, void *data)
 	sta = wcid_to_sta(wcid);
 
 	if (list_empty(&msta->poll_list)) {
-		spin_lock_bh(&dev->sta_poll_lock);
-		list_add_tail(&msta->poll_list, &dev->sta_poll_list);
-		spin_unlock_bh(&dev->sta_poll_lock);
+		spin_lock_bh(&dev->mt76.sta_poll_lock);
+		list_add_tail(&msta->poll_list, &dev->mt76.sta_poll_list);
+		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 	}
 
 	if (mt7603_mac_add_txs_skb(dev, msta, pid, txs_data))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index ca50feb0b3a9..2affa62caf2b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -100,10 +100,10 @@ mt7603_remove_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
-	spin_lock_bh(&dev->sta_poll_lock);
+	spin_lock_bh(&dev->mt76.sta_poll_lock);
 	if (!list_empty(&msta->poll_list))
 		list_del_init(&msta->poll_list);
-	spin_unlock_bh(&dev->sta_poll_lock);
+	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 	mutex_lock(&dev->mt76.mutex);
 	dev->mt76.vif_mask &= ~BIT_ULL(mvif->idx);
@@ -388,10 +388,10 @@ mt7603_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	mt7603_filter_tx(dev, wcid->idx, true);
 	spin_unlock_bh(&dev->ps_lock);
 
-	spin_lock_bh(&dev->sta_poll_lock);
+	spin_lock_bh(&mdev->sta_poll_lock);
 	if (!list_empty(&msta->poll_list))
 		list_del_init(&msta->poll_list);
-	spin_unlock_bh(&dev->sta_poll_lock);
+	spin_unlock_bh(&mdev->sta_poll_lock);
 
 	mt7603_wtbl_clear(dev, wcid->idx);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index 7c3be596da09..689922d133e7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -110,9 +110,6 @@ struct mt7603_dev {
 
 	u32 rxfilter;
 
-	struct list_head sta_poll_list;
-	spinlock_t sta_poll_lock;
-
 	struct mt7603_sta global_sta;
 
 	u32 agc0, agc3;
-- 
2.40.1

