Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8143636BE
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 18:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhDRQq3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 12:46:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231844AbhDRQq3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 12:46:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 092896101E;
        Sun, 18 Apr 2021 16:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618764361;
        bh=uYkF5D1feXrV77PQBJ32Nbzlrk9cY6STAzRxc0GJj6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wqhk2j6ExrCLSZhfdiWpDuGLebbUTrsp1/bk99iJCkcpyAuHahUqoeO0QGHCXXEm8
         nxNyEuRAMTw1fi7W1HB8oDPSHMyqwEcdglBFSsqPVcmpQ5mOK77Ht/2XnwJJLtbjLa
         8dvNmRCSJGsHctrq8NAK/NNVXu9emgWJdGPlzMwYhdMAak205NniZEvLJTuZB4e3q1
         7JUQifMh30UhKMwQQObYg1eEEMir2Vl3M/3To5jtOEXKKgj7y1RWyX3Y5ZVMrempv0
         YHQ3QInTGJk0g521N9h4QiSSOJzM4f5kO/ufe4ltT3I/8yjuOd6nd0Bh1OJWJdRLD/
         J+2p7hGA8wyoA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 04/19] mt76: mt7921: rely on mt76_connac_pm_ref/mt76_connac_pm_unref in tx path
Date:   Sun, 18 Apr 2021 18:45:30 +0200
Message-Id: <78aa0a8b660d2334be224d66a0ad7190a8782011.1618763001.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618763000.git.lorenzo@kernel.org>
References: <cover.1618763000.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt7921_tx_worker routine as mt76 tx worker callback for
mt7921.
Rely on mt76_connac_pm_ref/mt76_connac_pm_unref to check PM state and
increment/decrement wake counter

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  2 ++
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 23 ++++++++-----------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 ++
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 0b8a5a7f4362..ce0e231ab772 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -219,9 +219,11 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	dev->phy.dev = dev;
 	dev->phy.mt76 = &dev->mt76.phy;
 	dev->mt76.phy.priv = &dev->phy;
+	dev->mt76.tx_worker.fn = mt7921_tx_worker;
 
 	INIT_DELAYED_WORK(&dev->pm.ps_work, mt7921_pm_power_save_work);
 	INIT_WORK(&dev->pm.wake_work, mt7921_pm_wake_work);
+	spin_lock_init(&dev->pm.wake.lock);
 	mutex_init(&dev->pm.mutex);
 	init_completion(&dev->pm.wake_cmpl);
 	spin_lock_init(&dev->pm.txq_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 25591e2c510c..95e1775c5c00 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -725,23 +725,18 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
 }
 
-static void
-mt7921_wake_tx_queue(struct ieee80211_hw *hw, struct ieee80211_txq *txq)
+void mt7921_tx_worker(struct mt76_worker *w)
 {
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
-	struct mt7921_phy *phy = mt7921_hw_phy(hw);
-	struct mt76_phy *mphy = phy->mt76;
-
-	if (!test_bit(MT76_STATE_RUNNING, &mphy->state))
-		return;
+	struct mt7921_dev *dev = container_of(w, struct mt7921_dev,
+					      mt76.tx_worker);
 
-	if (test_bit(MT76_STATE_PM, &mphy->state)) {
+	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm)) {
 		queue_work(dev->mt76.wq, &dev->pm.wake_work);
 		return;
 	}
 
-	dev->pm.last_activity = jiffies;
-	mt76_worker_schedule(&dev->mt76.tx_worker);
+	mt76_txq_schedule_all(&dev->mphy);
+	mt76_connac_pm_unref(&dev->pm);
 }
 
 static void mt7921_tx(struct ieee80211_hw *hw,
@@ -769,9 +764,9 @@ static void mt7921_tx(struct ieee80211_hw *hw,
 		wcid = &mvif->sta.wcid;
 	}
 
-	if (!test_bit(MT76_STATE_PM, &mphy->state)) {
-		dev->pm.last_activity = jiffies;
+	if (mt76_connac_pm_ref(mphy, &dev->pm)) {
 		mt76_tx(mphy, control->sta, wcid, skb);
+		mt76_connac_pm_unref(&dev->pm);
 		return;
 	}
 
@@ -1200,7 +1195,7 @@ const struct ieee80211_ops mt7921_ops = {
 	.set_key = mt7921_set_key,
 	.ampdu_action = mt7921_ampdu_action,
 	.set_rts_threshold = mt7921_set_rts_threshold,
-	.wake_tx_queue = mt7921_wake_tx_queue,
+	.wake_tx_queue = mt76_wake_tx_queue,
 	.release_buffered_frames = mt76_release_buffered_frames,
 	.get_txpower = mt76_get_txpower,
 	.get_stats = mt7921_get_stats,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 3780a7f4cb16..a794c074867e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -336,6 +336,8 @@ int mt7921_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
 			  struct ieee80211_sta *sta,
 			  struct mt76_tx_info *tx_info);
+
+void mt7921_tx_worker(struct mt76_worker *w);
 void mt7921_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
 int mt7921_init_tx_queues(struct mt7921_phy *phy, int idx, int n_desc);
 void mt7921_tx_token_put(struct mt7921_dev *dev);
-- 
2.30.2

