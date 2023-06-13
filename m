Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6FC72E5CE
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 16:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242542AbjFMOdf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 10:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240957AbjFMOdd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 10:33:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3106BE54
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 07:33:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B410463728
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 14:33:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0716C433F0;
        Tue, 13 Jun 2023 14:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686666811;
        bh=AR4fyZALblyLBVVOYRYuSdyTURsUxLuKK+IcTM7OeTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j3TPZQ8EKVzWU9QfiMbZTtRl/rmMBSR2sFrtNdbOdst80Ktt3dVZeQxiINggmRrSZ
         9JnR4XJAJKz3tB8ZuwSSvfvXIPHzB4VAgJqSzZDPqmm5IwiyEtSC7bODbUADtQ3uRJ
         X77dH+bRosyV00W4Q7uUTvmD++MOz1GZClkgakvCNkpFzz6W73TFwVpI7lEnk8pvKK
         r6/+QoxQRZoLhp2M7ld8oRiO/kKZZ4COJZXb/l/1IyC64empUTSiI7hN2WNh7pqj+Q
         62Du9nniR6hglo6hCHoNug1bbjtvmXOKlnK6n3kHexIsopiYAqtLAfJGMwpXAKvD0O
         x6FqdAwJcF7Ng==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        shayne.chen@mediatek.com, ryder.lee@mediatek.com,
        deren.wu@mediatek.com
Subject: [PATCH v3 03/15] wifi: mt76: mt7615: rely on shared sta_poll_list and sta_poll_lock
Date:   Tue, 13 Jun 2023 16:32:31 +0200
Message-Id: <713afba35f91cc6d70f54ed1d07cff86ffc0688e.1686664917.git.lorenzo@kernel.org>
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

