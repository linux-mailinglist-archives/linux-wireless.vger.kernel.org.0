Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3152571481E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 May 2023 12:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjE2Kma (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 May 2023 06:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjE2Km3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 May 2023 06:42:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9A9C4
        for <linux-wireless@vger.kernel.org>; Mon, 29 May 2023 03:42:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EA3962355
        for <linux-wireless@vger.kernel.org>; Mon, 29 May 2023 10:42:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F1FC433D2;
        Mon, 29 May 2023 10:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685356940;
        bh=gT3ueQ6kMESGTxdQe/sF4CKr6Co06AAnkl8QrwzOXD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s7HUGuXSoYFqxoYRUUFrstnn07jfC2c97BsWRR1fBrUlzbnaloQ058Pxt7wJOVBhZ
         hexL4LP7j5HBf3H42tcZaqBrHCIq5N9vpRz9hnDseTGd+XZ6i+AmiY4Bz26sETq4zb
         IlWZDDTFdims1ZmdOzwsFnaM49zLfnbwNqiAqkp8lekR6894ch+9I79AVNFf1YaA4c
         lwfHAxIxXcqxMIBPayrtr+m+7FxxaEQtrvZLWrSp3vHUEGIaWvnpffh8g/YfyOYOEl
         aS+eGKJQlsoZvCWJWEHRRWN33BmKJOVToKjTQqydsLR5JmL1WwQUn22G8nxyxfUoaf
         H+C6fnBSuQinA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH 13/13] mt76: connac: move more mt7921/mt7915 mac shared code in connac lib
Date:   Mon, 29 May 2023 12:41:04 +0200
Message-Id: <bede71605cbf2d62a1af6474f9fa1e37b302f7bc.1685356673.git.lorenzo@kernel.org>
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

Move the following routines in mt76-connac lib since they are shared
between mt7915 and mt7921:
- mt76_connac2_tx_check_aggr
- mt76_connac2_txwi_free
- mt76_connac2_tx_token_put

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  5 +
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 82 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 91 +------------------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  1 -
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 59 +-----------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  4 -
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  2 +-
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   | 16 +---
 9 files changed, 96 insertions(+), 166 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 15653b274f83..68bdeada1421 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -409,5 +409,10 @@ int mt76_connac2_mac_fill_rx_rate(struct mt76_dev *dev,
 				  struct mt76_rx_status *status,
 				  struct ieee80211_supported_band *sband,
 				  __le32 *rxv, u8 *mode);
+void mt76_connac2_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi);
+void mt76_connac2_txwi_free(struct mt76_dev *dev, struct mt76_txwi_cache *t,
+			    struct ieee80211_sta *sta,
+			    struct list_head *free_list);
+void mt76_connac2_tx_token_put(struct mt76_dev *dev);
 
 #endif /* __MT76_CONNAC_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index ee0fbfcd07d6..bd3f696c37da 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -1111,3 +1111,85 @@ int mt76_connac2_mac_fill_rx_rate(struct mt76_dev *dev,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mt76_connac2_mac_fill_rx_rate);
+
+void mt76_connac2_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
+{
+	struct mt76_wcid *wcid;
+	u16 fc, tid;
+	u32 val;
+
+	if (!sta ||
+	    !(sta->deflink.ht_cap.ht_supported || sta->deflink.he_cap.has_he))
+		return;
+
+	tid = le32_get_bits(txwi[1], MT_TXD1_TID);
+	if (tid >= 6) /* skip VO queue */
+		return;
+
+	val = le32_to_cpu(txwi[2]);
+	fc = FIELD_GET(MT_TXD2_FRAME_TYPE, val) << 2 |
+	     FIELD_GET(MT_TXD2_SUB_TYPE, val) << 4;
+	if (unlikely(fc != (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_QOS_DATA)))
+		return;
+
+	wcid = (struct mt76_wcid *)sta->drv_priv;
+	if (!test_and_set_bit(tid, &wcid->ampdu_state))
+		ieee80211_start_tx_ba_session(sta, tid, 0);
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_tx_check_aggr);
+
+void mt76_connac2_txwi_free(struct mt76_dev *dev, struct mt76_txwi_cache *t,
+			    struct ieee80211_sta *sta,
+			    struct list_head *free_list)
+{
+	struct mt76_wcid *wcid;
+	__le32 *txwi;
+	u16 wcid_idx;
+
+	mt76_connac_txp_skb_unmap(dev, t);
+	if (!t->skb)
+		goto out;
+
+	txwi = (__le32 *)mt76_get_txwi_ptr(dev, t);
+	if (sta) {
+		wcid = (struct mt76_wcid *)sta->drv_priv;
+		wcid_idx = wcid->idx;
+	} else {
+		wcid_idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
+		wcid = rcu_dereference(dev->wcid[wcid_idx]);
+
+		if (wcid && wcid->sta) {
+			sta = container_of((void *)wcid, struct ieee80211_sta,
+					   drv_priv);
+			spin_lock_bh(&dev->sta_poll_lock);
+			if (list_empty(&wcid->poll_list))
+				list_add_tail(&wcid->poll_list,
+					      &dev->sta_poll_list);
+			spin_unlock_bh(&dev->sta_poll_lock);
+		}
+	}
+
+	if (sta && likely(t->skb->protocol != cpu_to_be16(ETH_P_PAE)))
+		mt76_connac2_tx_check_aggr(sta, txwi);
+
+	__mt76_tx_complete_skb(dev, wcid_idx, t->skb, free_list);
+out:
+	t->skb = NULL;
+	mt76_put_txwi(dev, t);
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_txwi_free);
+
+void mt76_connac2_tx_token_put(struct mt76_dev *dev)
+{
+	struct mt76_txwi_cache *txwi;
+	int id;
+
+	spin_lock_bh(&dev->token_lock);
+	idr_for_each_entry(&dev->token, txwi, id) {
+		mt76_connac2_txwi_free(dev, txwi, NULL, NULL);
+		dev->token_count--;
+	}
+	spin_unlock_bh(&dev->token_lock);
+	idr_destroy(&dev->token);
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_tx_token_put);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 90c883c7fe05..1bb687bee8c8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -1158,7 +1158,7 @@ static void mt7915_unregister_ext_phy(struct mt7915_dev *dev)
 static void mt7915_stop_hardware(struct mt7915_dev *dev)
 {
 	mt7915_mcu_exit(dev);
-	mt7915_tx_token_put(dev);
+	mt76_connac2_tx_token_put(&dev->mt76);
 	mt7915_dma_cleanup(dev);
 	tasklet_disable(&dev->mt76.irq_tasklet);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 5c2c054b31fb..c8a09634c650 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -842,75 +842,6 @@ u32 mt7915_wed_init_buf(void *ptr, dma_addr_t phys, int token_id)
 	return MT_TXD_SIZE + sizeof(*txp);
 }
 
-static void
-mt7915_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
-{
-	struct mt7915_sta *msta;
-	u16 fc, tid;
-	u32 val;
-
-	if (!sta || !(sta->deflink.ht_cap.ht_supported || sta->deflink.he_cap.has_he))
-		return;
-
-	tid = le32_get_bits(txwi[1], MT_TXD1_TID);
-	if (tid >= 6) /* skip VO queue */
-		return;
-
-	val = le32_to_cpu(txwi[2]);
-	fc = FIELD_GET(MT_TXD2_FRAME_TYPE, val) << 2 |
-	     FIELD_GET(MT_TXD2_SUB_TYPE, val) << 4;
-	if (unlikely(fc != (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_QOS_DATA)))
-		return;
-
-	msta = (struct mt7915_sta *)sta->drv_priv;
-	if (!test_and_set_bit(tid, &msta->wcid.ampdu_state))
-		ieee80211_start_tx_ba_session(sta, tid, 0);
-}
-
-static void
-mt7915_txwi_free(struct mt7915_dev *dev, struct mt76_txwi_cache *t,
-		 struct ieee80211_sta *sta, struct list_head *free_list)
-{
-	struct mt76_dev *mdev = &dev->mt76;
-	struct mt7915_sta *msta;
-	struct mt76_wcid *wcid;
-	__le32 *txwi;
-	u16 wcid_idx;
-
-	mt76_connac_txp_skb_unmap(mdev, t);
-	if (!t->skb)
-		goto out;
-
-	txwi = (__le32 *)mt76_get_txwi_ptr(mdev, t);
-	if (sta) {
-		wcid = (struct mt76_wcid *)sta->drv_priv;
-		wcid_idx = wcid->idx;
-	} else {
-		wcid_idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
-		wcid = rcu_dereference(dev->mt76.wcid[wcid_idx]);
-
-		if (wcid && wcid->sta) {
-			msta = container_of(wcid, struct mt7915_sta, wcid);
-			sta = container_of((void *)msta, struct ieee80211_sta,
-					  drv_priv);
-			spin_lock_bh(&mdev->sta_poll_lock);
-			if (list_empty(&msta->wcid.poll_list))
-				list_add_tail(&msta->wcid.poll_list,
-					      &mdev->sta_poll_list);
-			spin_unlock_bh(&mdev->sta_poll_lock);
-		}
-	}
-
-	if (sta && likely(t->skb->protocol != cpu_to_be16(ETH_P_PAE)))
-		mt7915_tx_check_aggr(sta, txwi);
-
-	__mt76_tx_complete_skb(mdev, wcid_idx, t->skb, free_list);
-
-out:
-	t->skb = NULL;
-	mt76_put_txwi(mdev, t);
-}
-
 static void
 mt7915_mac_tx_free_prepare(struct mt7915_dev *dev)
 {
@@ -1013,7 +944,7 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 			if (!txwi)
 				continue;
 
-			mt7915_txwi_free(dev, txwi, sta, &free_list);
+			mt76_connac2_txwi_free(mdev, txwi, sta, &free_list);
 		}
 	}
 
@@ -1045,7 +976,7 @@ mt7915_mac_tx_free_v0(struct mt7915_dev *dev, void *data, int len)
 		if (!txwi)
 			continue;
 
-		mt7915_txwi_free(dev, txwi, NULL, &free_list);
+		mt76_connac2_txwi_free(mdev, txwi, NULL, &free_list);
 	}
 
 	mt7915_mac_tx_free_done(dev, &free_list, wake);
@@ -1360,20 +1291,6 @@ mt7915_update_beacons(struct mt7915_dev *dev)
 		mt7915_update_vif_beacon, mphy_ext->hw);
 }
 
-void mt7915_tx_token_put(struct mt7915_dev *dev)
-{
-	struct mt76_txwi_cache *txwi;
-	int id;
-
-	spin_lock_bh(&dev->mt76.token_lock);
-	idr_for_each_entry(&dev->mt76.token, txwi, id) {
-		mt7915_txwi_free(dev, txwi, NULL, NULL);
-		dev->mt76.token_count--;
-	}
-	spin_unlock_bh(&dev->mt76.token_lock);
-	idr_destroy(&dev->mt76.token);
-}
-
 static int
 mt7915_mac_restart(struct mt7915_dev *dev)
 {
@@ -1418,7 +1335,7 @@ mt7915_mac_restart(struct mt7915_dev *dev)
 	napi_disable(&dev->mt76.tx_napi);
 
 	/* token reinit */
-	mt7915_tx_token_put(dev);
+	mt76_connac2_tx_token_put(&dev->mt76);
 	idr_init(&dev->mt76.token);
 
 	mt7915_dma_reset(dev, true);
@@ -1607,7 +1524,7 @@ void mt7915_mac_reset_work(struct work_struct *work)
 	if (mt7915_wait_reset_state(dev, MT_MCU_CMD_RESET_DONE)) {
 		mt7915_dma_reset(dev, false);
 
-		mt7915_tx_token_put(dev);
+		mt76_connac2_tx_token_put(&dev->mt76);
 		idr_init(&dev->mt76.token);
 
 		mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_DMA_INIT);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index ca01199afd11..ac116ab03690 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -608,7 +608,6 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
 			  struct ieee80211_sta *sta,
 			  struct mt76_tx_info *tx_info);
-void mt7915_tx_token_put(struct mt7915_dev *dev);
 void mt7915_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb, u32 *info);
 bool mt7915_rx_check(struct mt76_dev *mdev, void *data, int len);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index f0e67e62abc2..2de0114d7cd1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -511,30 +511,6 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 	return 0;
 }
 
-static void mt7921_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
-{
-	struct mt7921_sta *msta;
-	u16 fc, tid;
-	u32 val;
-
-	if (!sta || !(sta->deflink.ht_cap.ht_supported || sta->deflink.he_cap.has_he))
-		return;
-
-	tid = le32_get_bits(txwi[1], MT_TXD1_TID);
-	if (tid >= 6) /* skip VO queue */
-		return;
-
-	val = le32_to_cpu(txwi[2]);
-	fc = FIELD_GET(MT_TXD2_FRAME_TYPE, val) << 2 |
-	     FIELD_GET(MT_TXD2_SUB_TYPE, val) << 4;
-	if (unlikely(fc != (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_QOS_DATA)))
-		return;
-
-	msta = (struct mt7921_sta *)sta->drv_priv;
-	if (!test_and_set_bit(tid, &msta->wcid.ampdu_state))
-		ieee80211_start_tx_ba_session(sta, tid, 0);
-}
-
 void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data)
 {
 	struct mt7921_sta *msta = NULL;
@@ -576,37 +552,6 @@ void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data)
 	rcu_read_unlock();
 }
 
-void mt7921_txwi_free(struct mt7921_dev *dev, struct mt76_txwi_cache *t,
-		      struct ieee80211_sta *sta, bool clear_status,
-		      struct list_head *free_list)
-{
-	struct mt76_dev *mdev = &dev->mt76;
-	__le32 *txwi;
-	u16 wcid_idx;
-
-	mt76_connac_txp_skb_unmap(mdev, t);
-	if (!t->skb)
-		goto out;
-
-	txwi = (__le32 *)mt76_get_txwi_ptr(mdev, t);
-	if (sta) {
-		struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
-
-		if (likely(t->skb->protocol != cpu_to_be16(ETH_P_PAE)))
-			mt7921_tx_check_aggr(sta, txwi);
-
-		wcid_idx = wcid->idx;
-	} else {
-		wcid_idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
-	}
-
-	__mt76_tx_complete_skb(mdev, wcid_idx, t->skb, free_list);
-out:
-	t->skb = NULL;
-	mt76_put_txwi(mdev, t);
-}
-EXPORT_SYMBOL_GPL(mt7921_txwi_free);
-
 static void mt7921_mac_tx_free(struct mt7921_dev *dev, void *data, int len)
 {
 	struct mt76_connac_tx_free *free = data;
@@ -663,7 +608,7 @@ static void mt7921_mac_tx_free(struct mt7921_dev *dev, void *data, int len)
 		if (!txwi)
 			continue;
 
-		mt7921_txwi_free(dev, txwi, sta, stat, &free_list);
+		mt76_connac2_txwi_free(mdev, txwi, sta, &free_list);
 	}
 
 	if (wake)
@@ -1225,7 +1170,7 @@ void mt7921_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
 	sta = wcid_to_sta(wcid);
 
 	if (sta && likely(e->skb->protocol != cpu_to_be16(ETH_P_PAE)))
-		mt7921_tx_check_aggr(sta, txwi);
+		mt76_connac2_tx_check_aggr(sta, txwi);
 
 	skb_pull(e->skb, headroom);
 	mt76_tx_complete_skb(mdev, e->wcid, e->skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 233e7be90992..6cb9bdd6f50b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -472,7 +472,6 @@ int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			   struct mt76_tx_info *tx_info);
 
 void mt7921_tx_worker(struct mt76_worker *w);
-void mt7921_tx_token_put(struct mt7921_dev *dev);
 bool mt7921_rx_check(struct mt76_dev *mdev, void *data, int len);
 void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb, u32 *info);
@@ -505,9 +504,6 @@ int mt7921_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			void *data, int len);
 int mt7921_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *msg,
 			 struct netlink_callback *cb, void *data, int len);
-void mt7921_txwi_free(struct mt7921_dev *dev, struct mt76_txwi_cache *t,
-		      struct ieee80211_sta *sta, bool clear_status,
-		      struct list_head *free_list);
 int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			      struct sk_buff *skb, int seq);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 1c727870bbdb..6c06d4b5856e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -115,7 +115,7 @@ static void mt7921e_unregister_device(struct mt7921_dev *dev)
 	cancel_work_sync(&pm->wake_work);
 	cancel_work_sync(&dev->reset_work);
 
-	mt7921_tx_token_put(dev);
+	mt76_connac2_tx_token_put(&dev->mt76);
 	__mt7921_mcu_drv_pmctrl(dev);
 	mt7921_dma_cleanup(dev);
 	mt7921_wfsys_reset(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index 6053a2556c20..978c90a034cf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -53,20 +53,6 @@ int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	return 0;
 }
 
-void mt7921_tx_token_put(struct mt7921_dev *dev)
-{
-	struct mt76_txwi_cache *txwi;
-	int id;
-
-	spin_lock_bh(&dev->mt76.token_lock);
-	idr_for_each_entry(&dev->mt76.token, txwi, id) {
-		mt7921_txwi_free(dev, txwi, NULL, false, NULL);
-		dev->mt76.token_count--;
-	}
-	spin_unlock_bh(&dev->mt76.token_lock);
-	idr_destroy(&dev->mt76.token);
-}
-
 int mt7921e_mac_reset(struct mt7921_dev *dev)
 {
 	int i, err;
@@ -91,7 +77,7 @@ int mt7921e_mac_reset(struct mt7921_dev *dev)
 	napi_disable(&dev->mt76.napi[MT_RXQ_MCU_WA]);
 	napi_disable(&dev->mt76.tx_napi);
 
-	mt7921_tx_token_put(dev);
+	mt76_connac2_tx_token_put(&dev->mt76);
 	idr_init(&dev->mt76.token);
 
 	mt7921_wpdma_reset(dev, true);
-- 
2.40.1

