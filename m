Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78AF3636BF
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 18:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbhDRQqb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 12:46:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229783AbhDRQqa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 12:46:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57CE06135D;
        Sun, 18 Apr 2021 16:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618764362;
        bh=i3dxuGiPEMOtGf/J+ut0MmVQpTRjIwdv0R+Mx522G7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jENkYs3p2oeedvjgYVlOp/ZTRMwVXoIxG2/Y7oKI5+nOF55o4MPJUHOqv4URdxB5z
         lLVZSYkgyE6Bx3aW0dz+CN0eK/eMQk8/RDCaijmNbJ02ETe3QPvAlcG99EAZoef6y8
         63RaEhDdP/2FLesO7X8cGZjcPf+3f/7/xYmQQXx2guKkBTo+w6lFu1l8fW/pQ1wtOD
         0JQemBU/SITjXd4YfO9fzwDDCz0x3eMMQ/qds4pUppyYstQL6CrfHBAPM7kobVgsjz
         rJAEFujJLLSLHSuRHRpD7W7YSpcKH1kJoyQh3rzTdacdCNFgjTiTmP7us+XDpsYl5O
         ZwdbxjwabMNLA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 05/19] mt76: mt7663: rely on mt76_connac_pm_ref/mt76_connac_pm_unref in tx path
Date:   Sun, 18 Apr 2021 18:45:31 +0200
Message-Id: <d66e37becf46f13f1e0f24f2ab373b45f03df659.1618763001.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618763000.git.lorenzo@kernel.org>
References: <cover.1618763000.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt7615_tx_worker routine as mt76 tx worker callback for
mt7663.
Rely on mt76_connac_pm_ref/mt76_connac_pm_unref to check PM state and
increment/decrement wake counter

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  2 ++
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 27 +++++++++----------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  1 +
 drivers/net/wireless/mediatek/mt76/tx.c       | 12 ++++++---
 5 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 289f195a7951..0660b708156d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1015,6 +1015,7 @@ void mt76_stop_tx_queues(struct mt76_phy *phy, struct ieee80211_sta *sta,
 void mt76_tx_check_agg_ssn(struct ieee80211_sta *sta, struct sk_buff *skb);
 void mt76_txq_schedule(struct mt76_phy *phy, enum mt76_txq_id qid);
 void mt76_txq_schedule_all(struct mt76_phy *phy);
+void mt76_tx_worker_run(struct mt76_dev *dev);
 void mt76_tx_worker(struct mt76_worker *w);
 void mt76_release_buffered_frames(struct ieee80211_hw *hw,
 				  struct ieee80211_sta *sta,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 5429536e8d43..3ef6bcdf38c4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -502,9 +502,11 @@ void mt7615_init_device(struct mt7615_dev *dev)
 	dev->phy.dev = dev;
 	dev->phy.mt76 = &dev->mt76.phy;
 	dev->mt76.phy.priv = &dev->phy;
+	dev->mt76.tx_worker.fn = mt7615_tx_worker;
 
 	INIT_DELAYED_WORK(&dev->pm.ps_work, mt7615_pm_power_save_work);
 	INIT_WORK(&dev->pm.wake_work, mt7615_pm_wake_work);
+	spin_lock_init(&dev->pm.wake.lock);
 	mutex_init(&dev->pm.mutex);
 	init_completion(&dev->pm.wake_cmpl);
 	spin_lock_init(&dev->pm.txq_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 8313bf468db2..a3e53d3aec02 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -694,28 +694,25 @@ static void mt7615_sta_rate_tbl_update(struct ieee80211_hw *hw,
 			break;
 	}
 	msta->n_rates = i;
-	if (!test_bit(MT76_STATE_PM, &phy->mt76->state))
+	if (mt76_connac_pm_ref(phy->mt76, &dev->pm)) {
 		mt7615_mac_set_rates(phy, msta, NULL, msta->rates);
+		mt76_connac_pm_unref(&dev->pm);
+	}
 	spin_unlock_bh(&dev->mt76.lock);
 }
 
-static void
-mt7615_wake_tx_queue(struct ieee80211_hw *hw, struct ieee80211_txq *txq)
+void mt7615_tx_worker(struct mt76_worker *w)
 {
-	struct mt7615_dev *dev = mt7615_hw_dev(hw);
-	struct mt7615_phy *phy = mt7615_hw_phy(hw);
-	struct mt76_phy *mphy = phy->mt76;
-
-	if (!test_bit(MT76_STATE_RUNNING, &mphy->state))
-		return;
+	struct mt7615_dev *dev = container_of(w, struct mt7615_dev,
+					      mt76.tx_worker);
 
-	if (test_bit(MT76_STATE_PM, &mphy->state)) {
+	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm)) {
 		queue_work(dev->mt76.wq, &dev->pm.wake_work);
 		return;
 	}
 
-	dev->pm.last_activity = jiffies;
-	mt76_worker_schedule(&dev->mt76.tx_worker);
+	mt76_tx_worker_run(&dev->mt76);
+	mt76_connac_pm_unref(&dev->pm);
 }
 
 static void mt7615_tx(struct ieee80211_hw *hw,
@@ -743,9 +740,9 @@ static void mt7615_tx(struct ieee80211_hw *hw,
 		wcid = &msta->wcid;
 	}
 
-	if (!test_bit(MT76_STATE_PM, &mphy->state)) {
-		dev->pm.last_activity = jiffies;
+	if (mt76_connac_pm_ref(mphy, &dev->pm)) {
 		mt76_tx(mphy, control->sta, wcid, skb);
+		mt76_connac_pm_unref(&dev->pm);
 		return;
 	}
 
@@ -1272,7 +1269,7 @@ const struct ieee80211_ops mt7615_ops = {
 	.sta_set_decap_offload = mt7615_sta_set_decap_offload,
 	.ampdu_action = mt7615_ampdu_action,
 	.set_rts_threshold = mt7615_set_rts_threshold,
-	.wake_tx_queue = mt7615_wake_tx_queue,
+	.wake_tx_queue = mt76_wake_tx_queue,
 	.sta_rate_tbl_update = mt7615_sta_rate_tbl_update,
 	.sw_scan_start = mt76_sw_scan,
 	.sw_scan_complete = mt76_sw_scan_complete,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 5262b84a28c7..4c533b8ffa47 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -508,6 +508,7 @@ int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  struct ieee80211_sta *sta,
 			  struct mt76_tx_info *tx_info);
 
+void mt7615_tx_worker(struct mt76_worker *w);
 void mt7615_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
 void mt7615_tx_token_put(struct mt7615_dev *dev);
 void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 04e47259ea5f..cfc7229aa7b0 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -540,10 +540,8 @@ void mt76_txq_schedule_all(struct mt76_phy *phy)
 }
 EXPORT_SYMBOL_GPL(mt76_txq_schedule_all);
 
-void mt76_tx_worker(struct mt76_worker *w)
+void mt76_tx_worker_run(struct mt76_dev *dev)
 {
-	struct mt76_dev *dev = container_of(w, struct mt76_dev, tx_worker);
-
 	mt76_txq_schedule_all(&dev->phy);
 	if (dev->phy2)
 		mt76_txq_schedule_all(dev->phy2);
@@ -555,6 +553,14 @@ void mt76_tx_worker(struct mt76_worker *w)
 		mt76_testmode_tx_pending(dev->phy2);
 #endif
 }
+EXPORT_SYMBOL_GPL(mt76_tx_worker_run);
+
+void mt76_tx_worker(struct mt76_worker *w)
+{
+	struct mt76_dev *dev = container_of(w, struct mt76_dev, tx_worker);
+
+	mt76_tx_worker_run(dev);
+}
 
 void mt76_stop_tx_queues(struct mt76_phy *phy, struct ieee80211_sta *sta,
 			 bool send_bar)
-- 
2.30.2

