Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6502173A67D
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jun 2023 18:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjFVQv4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jun 2023 12:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjFVQvz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jun 2023 12:51:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC64FE9
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 09:51:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B288618B0
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 16:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F387C433C0;
        Thu, 22 Jun 2023 16:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687452712;
        bh=DzNu8tM/BRQ+B+dO4ToGCEXPhD6iokg7SPmnUhyxXE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AMr9amXm3C+rF1E7pVkLi0q+/PGESIMS6DhZwFueOk2a7YB28L/AfaMJr61fz40+o
         g1ZknjMbbKZg9xmeTs7FBP/vvwG9WA32it3fRTXDRHIBYU5UQjMvnUJWxr45YOXjoL
         9ODGV6StZaURL9vH00+jPXaOXJpSuzR5WpzsJouPEI4hGK5IBGjKdc7Is6q/iROiZo
         Ir6AFo1luso9Qf3Juy8gUbZvg3SGQ35CZb7XEt1WOuoSOMu1QvpUDBfzOme+pmabWc
         3KBe1U4X0npnJz3YebXV42riguQNtUzGJv2UlcZjOffJpRyZzUXvrmzLk1jdMRVqKw
         p0YZDO8XuJhMw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, deren.wu@mediatek.com,
        shayne.chen@mediatek.com
Subject: [PATCH v4 12/15] mt76: connac: move more mt7921/mt7915 mac shared code in connac lib
Date:   Thu, 22 Jun 2023 18:50:29 +0200
Message-ID: <2384eafd97036c8e671fa155066e830ce4bc4509.1687452202.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1687452202.git.lorenzo@kernel.org>
References: <cover.1687452202.git.lorenzo@kernel.org>
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
index 77ca8f057d61..d3bb9114160f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -419,5 +419,10 @@ int mt76_connac2_mac_fill_rx_rate(struct mt76_dev *dev,
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
index f481ca3a0db8..ee5177fd6dde 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -1112,3 +1112,85 @@ int mt76_connac2_mac_fill_rx_rate(struct mt76_dev *dev,
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
index fffab468efeb..ee976657bfc3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -1166,7 +1166,7 @@ static void mt7915_unregister_ext_phy(struct mt7915_dev *dev)
 static void mt7915_stop_hardware(struct mt7915_dev *dev)
 {
 	mt7915_mcu_exit(dev);
-	mt7915_tx_token_put(dev);
+	mt76_connac2_tx_token_put(&dev->mt76);
 	mt7915_dma_cleanup(dev);
 	tasklet_disable(&dev->mt76.irq_tasklet);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index b58e8275feef..b8b0c0fda752 100644
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
@@ -1031,7 +962,7 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 			if (!txwi)
 				continue;
 
-			mt7915_txwi_free(dev, txwi, sta, &free_list);
+			mt76_connac2_txwi_free(mdev, txwi, sta, &free_list);
 		}
 	}
 
@@ -1063,7 +994,7 @@ mt7915_mac_tx_free_v0(struct mt7915_dev *dev, void *data, int len)
 		if (!txwi)
 			continue;
 
-		mt7915_txwi_free(dev, txwi, NULL, &free_list);
+		mt76_connac2_txwi_free(mdev, txwi, NULL, &free_list);
 	}
 
 	mt7915_mac_tx_free_done(dev, &free_list, wake);
@@ -1378,20 +1309,6 @@ mt7915_update_beacons(struct mt7915_dev *dev)
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
@@ -1440,7 +1357,7 @@ mt7915_mac_restart(struct mt7915_dev *dev)
 	napi_disable(&dev->mt76.tx_napi);
 
 	/* token reinit */
-	mt7915_tx_token_put(dev);
+	mt76_connac2_tx_token_put(&dev->mt76);
 	idr_init(&dev->mt76.token);
 
 	mt7915_dma_reset(dev, true);
@@ -1633,7 +1550,7 @@ void mt7915_mac_reset_work(struct work_struct *work)
 	if (mt7915_wait_reset_state(dev, MT_MCU_CMD_RESET_DONE)) {
 		mt7915_dma_reset(dev, false);
 
-		mt7915_tx_token_put(dev);
+		mt76_connac2_tx_token_put(&dev->mt76);
 		idr_init(&dev->mt76.token);
 
 		mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_DMA_INIT);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 066934249a09..0c7226b8c805 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -555,7 +555,6 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
 			  struct ieee80211_sta *sta,
 			  struct mt76_tx_info *tx_info);
-void mt7915_tx_token_put(struct mt7915_dev *dev);
 void mt7915_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb, u32 *info);
 bool mt7915_rx_check(struct mt76_dev *mdev, void *data, int len);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 3e589748e1a3..368f92719abf 100644
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
@@ -669,7 +614,7 @@ static void mt7921_mac_tx_free(struct mt7921_dev *dev, void *data, int len)
 		if (!txwi)
 			continue;
 
-		mt7921_txwi_free(dev, txwi, sta, stat, &free_list);
+		mt76_connac2_txwi_free(mdev, txwi, sta, &free_list);
 	}
 
 	if (wake)
@@ -1235,7 +1180,7 @@ void mt7921_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
 	sta = wcid_to_sta(wcid);
 
 	if (sta && likely(e->skb->protocol != cpu_to_be16(ETH_P_PAE)))
-		mt7921_tx_check_aggr(sta, txwi);
+		mt76_connac2_tx_check_aggr(sta, txwi);
 
 	skb_pull(e->skb, headroom);
 	mt76_tx_complete_skb(mdev, e->wcid, e->skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 2694ecb1fdcb..ec9879650174 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -442,7 +442,6 @@ int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			   struct mt76_tx_info *tx_info);
 
 void mt7921_tx_worker(struct mt76_worker *w);
-void mt7921_tx_token_put(struct mt7921_dev *dev);
 bool mt7921_rx_check(struct mt76_dev *mdev, void *data, int len);
 void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb, u32 *info);
@@ -475,9 +474,6 @@ int mt7921_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			void *data, int len);
 int mt7921_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *msg,
 			 struct netlink_callback *cb, void *data, int len);
-void mt7921_txwi_free(struct mt7921_dev *dev, struct mt76_txwi_cache *t,
-		      struct ieee80211_sta *sta, bool clear_status,
-		      struct list_head *free_list);
 int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			      struct sk_buff *skb, int seq);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 95610a117d2f..1b7f19939a69 100644
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
2.41.0

