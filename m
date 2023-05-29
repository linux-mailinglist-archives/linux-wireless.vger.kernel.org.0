Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD609714816
	for <lists+linux-wireless@lfdr.de>; Mon, 29 May 2023 12:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjE2Kl5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 May 2023 06:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjE2Kl4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 May 2023 06:41:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EF8C4
        for <linux-wireless@vger.kernel.org>; Mon, 29 May 2023 03:41:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FA6762354
        for <linux-wireless@vger.kernel.org>; Mon, 29 May 2023 10:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DA6C4339B;
        Mon, 29 May 2023 10:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685356914;
        bh=DBWeMq80+u76FKevDW1SUGRxhkjUY02EUBN4r2LSQ6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iiHftCXftcanfH/lf3thS3mZhMgp/6+wZm5P7nOdUerK6XhTmyvD9iyTogGmi9YVL
         HS9zbQ2nV69+aD1+5enE19Gi2N/jm0dk5TsdvO5efgiSuvEHX4K1oiucEQQHX2pXim
         j8ftixVa2zkD2A9wmTsMxFKpLMBOM7yHhR6qQwB7WSHKTOACKJUDTAqGQS8ANRgpVw
         GH1ZfiBhJ9tySI+2DONlGqFy5JN7LztxHoRh2mJUG1tzlMxPUT6iufiYW+VF59Chjh
         7SJTQcGOfw5/vXXgDPNNCyQR98mDH5BA3Oh0ME4xvQWUQt+RJlcWFLAiwY1SpLGaz8
         PSOyfQUIQ7tAg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH 06/13] wifi: mt76: mt7921: rely on shared sta_poll_list and sta_poll_lock
Date:   Mon, 29 May 2023 12:40:57 +0200
Message-Id: <62f39dbc5c2ffc83e03444541f9c195096f5ac45.1685356673.git.lorenzo@kernel.org>
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
index 39d7ebba0457..78e1ae17834f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -304,9 +304,6 @@ struct mt7921_dev {
 	bool hw_init_done:1;
 	bool fw_assert:1;
 
-	struct list_head sta_poll_list;
-	spinlock_t sta_poll_lock;
-
 	struct work_struct init_work;
 
 	u8 fw_debug;
-- 
2.40.1

