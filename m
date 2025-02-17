Return-Path: <linux-wireless+bounces-19054-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 352A8A37CE4
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 09:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB349188DD3B
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 08:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF8519C553;
	Mon, 17 Feb 2025 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="c9LM7UpP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A426D191F68
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 08:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739780258; cv=none; b=kKME0cxMM6Q3RiO2cnjR8+UnUPIIk0MbXiW32EB8P1C7T3JJaxpswTWjkkut5+txf1u2AMyMvO+Bp5uQ0N2i1xBrDRoCmli43HCzzAXe8qY2VLclWPqO15C9ssM+62R2iUaAJYMuLtU6Fi9U4hUNjeA9nqK4BEUSodYZRc/I3ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739780258; c=relaxed/simple;
	bh=uhja3bHBvT6/2JHEF8DkTI5CLL2G/BY082Im3dZo7z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2UhaHZcskD5Xra4sVBGTUTIVq0TOMjTSUdvdkRT+/QgNJgutlVY6DWplydCY5CF5U4Qh8Kit31MdGckkMGmjpsmHIgDoWUP6DrGimw6AsGiykjGKGfxAhPQPCsPKzulZcTA7oXLyIGbBLyYBJQe6Cl9b87eaW86MQzfCyq3ygo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=c9LM7UpP; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1739780252;
	bh=uhja3bHBvT6/2JHEF8DkTI5CLL2G/BY082Im3dZo7z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c9LM7UpPT7wwoKv32fzH55Fn7PcEZKd8F9KOVCj1jwkWv/pD6MSgyNwCsqUyOiz3a
	 5/ylGPUpTVoM6WUnWcQLvGGivC9FAco6DYdwRDvAvQ/OD40wvZor4T06qdk3i1bw9D
	 aqwd0mw38Hqt6UwdPTKfkZpgHPT9uQ0l8PldMJlc=
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Alexander Wetzel <alexander@wetzel-home.de>
Subject: [PATCH v2 03/10] wifi: mac80211: Convert vif->txq to an array
Date: Mon, 17 Feb 2025 09:17:14 +0100
Message-ID: <20250217081721.45110-4-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217081721.45110-1-Alexander@wetzel-home.de>
References: <20250217081721.45110-1-Alexander@wetzel-home.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Wetzel <alexander@wetzel-home.de>

Mac80211 needs additional TX queues to handle all TX within TXQs.
Convert vif->txq to an array, allowing other patches to extend vif TXQs.

Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
---
 drivers/net/wireless/ath/ath10k/mac.c             |  8 ++++----
 drivers/net/wireless/ath/ath9k/ath9k.h            |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |  6 +++---
 drivers/net/wireless/mediatek/mt76/mt7603/main.c  |  3 ++-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c  |  5 +++--
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c |  3 ++-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c  |  6 +++---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c  |  5 +++--
 drivers/net/wireless/mediatek/mt76/mt7925/main.c  |  5 +++--
 drivers/net/wireless/mediatek/mt76/mt7996/main.c  |  5 +++--
 drivers/net/wireless/realtek/rtw88/mac80211.c     |  4 ++--
 drivers/net/wireless/realtek/rtw88/main.c         |  2 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c     |  2 +-
 include/net/mac80211.h                            | 15 +++++++++++++--
 net/mac80211/cfg.c                                |  8 ++++++--
 net/mac80211/debugfs_netdev.c                     |  4 ++--
 net/mac80211/iface.c                              |  6 ++++--
 net/mac80211/tx.c                                 |  8 ++++----
 net/mac80211/util.c                               |  7 ++++---
 19 files changed, 64 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index c61b95a928da..53df2a9102a7 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -4297,7 +4297,7 @@ struct ieee80211_txq *ath10k_mac_txq_lookup(struct ath10k *ar,
 	if (peer->sta)
 		return peer->sta->txq[tid];
 	else if (peer->vif)
-		return peer->vif->txq;
+		return peer->vif->txq[IEEE80211_VIF_TXQ_MULTICAST];
 	else
 		return NULL;
 }
@@ -5539,7 +5539,7 @@ static int ath10k_add_interface(struct ieee80211_hw *hw,
 	mutex_lock(&ar->conf_mutex);
 
 	memset(arvif, 0, sizeof(*arvif));
-	ath10k_mac_txq_init(vif->txq);
+	ath10k_mac_txq_init(vif->txq[IEEE80211_VIF_TXQ_MULTICAST]);
 
 	arvif->ar = ar;
 	arvif->vif = vif;
@@ -5985,7 +5985,7 @@ static void ath10k_remove_interface(struct ieee80211_hw *hw,
 	spin_unlock_bh(&ar->data_lock);
 
 	ath10k_peer_cleanup(ar, arvif->vdev_id);
-	ath10k_mac_txq_unref(ar, vif->txq);
+	ath10k_mac_txq_unref(ar, vif->txq[IEEE80211_VIF_TXQ_MULTICAST]);
 
 	if (vif->type == NL80211_IFTYPE_MONITOR) {
 		ar->monitor_arvif = NULL;
@@ -6002,7 +6002,7 @@ static void ath10k_remove_interface(struct ieee80211_hw *hw,
 	ath10k_mac_vif_tx_unlock_all(arvif);
 	spin_unlock_bh(&ar->htt.tx_lock);
 
-	ath10k_mac_txq_unref(ar, vif->txq);
+	ath10k_mac_txq_unref(ar, vif->txq[IEEE80211_VIF_TXQ_MULTICAST]);
 
 out:
 	mutex_unlock(&ar->conf_mutex);
diff --git a/drivers/net/wireless/ath/ath9k/ath9k.h b/drivers/net/wireless/ath/ath9k/ath9k.h
index a728cc0387df..d681a9a2f377 100644
--- a/drivers/net/wireless/ath/ath9k/ath9k.h
+++ b/drivers/net/wireless/ath/ath9k/ath9k.h
@@ -437,7 +437,7 @@ ath_node_to_tid(struct ath_node *an, u8 tidno)
 	if (sta)
 		txq = sta->txq[tidno % ARRAY_SIZE(sta->txq)];
 	else
-		txq = vif->txq;
+		txq = vif->txq[IEEE80211_VIF_TXQ_MULTICAST];
 
 	return (struct ath_atx_tid *) txq->drv_priv;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 014777c9cc5d..df7bc70f6744 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1597,12 +1597,12 @@ int iwl_mvm_post_channel_switch(struct ieee80211_hw *hw,
 		}
 	} else if (vif->type == NL80211_IFTYPE_AP && mvmvif->csa_blocks_tx) {
 		struct iwl_mvm_txq *mvmtxq =
-			iwl_mvm_txq_from_mac80211(vif->txq);
+			iwl_mvm_txq_from_mac80211(vif->txq[IEEE80211_VIF_TXQ_MULTICAST]);
 
 		clear_bit(IWL_MVM_TXQ_STATE_STOP_AP_CSA, &mvmtxq->state);
 
 		local_bh_disable();
-		iwl_mvm_mac_itxq_xmit(hw, vif->txq);
+		iwl_mvm_mac_itxq_xmit(hw, vif->txq[IEEE80211_VIF_TXQ_MULTICAST]);
 		ieee80211_iterate_stations_atomic(hw, iwl_mvm_post_csa_tx, hw);
 		local_bh_enable();
 
@@ -5712,7 +5712,7 @@ int iwl_mvm_pre_channel_switch(struct iwl_mvm *mvm,
 			break;
 
 		mvmvif->csa_blocks_tx = true;
-		mvmtxq = iwl_mvm_txq_from_mac80211(vif->txq);
+		mvmtxq = iwl_mvm_txq_from_mac80211(vif->txq[IEEE80211_VIF_TXQ_MULTICAST]);
 		set_bit(IWL_MVM_TXQ_STATE_STOP_AP_CSA, &mvmtxq->state);
 		ieee80211_iterate_stations_atomic(mvm->hw,
 						  iwl_mvm_csa_block_txqs,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 3e8b1ec76169..6f385e2a77ad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -35,6 +35,7 @@ mt7603_stop(struct ieee80211_hw *hw, bool suspend)
 static int
 mt7603_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 {
+	struct ieee80211_txq *txq = vif->txq[IEEE80211_VIF_TXQ_MULTICAST];
 	struct mt7603_vif *mvif = (struct mt7603_vif *)vif->drv_priv;
 	struct mt7603_dev *dev = hw->priv;
 	struct mt76_txq *mtxq;
@@ -73,7 +74,7 @@ mt7603_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	eth_broadcast_addr(bc_addr);
 	mt7603_wtbl_init(dev, idx, mvif->idx, bc_addr);
 
-	mtxq = (struct mt76_txq *)vif->txq->drv_priv;
+	mtxq = (struct mt76_txq *)txq->drv_priv;
 	mtxq->wcid = idx;
 	rcu_assign_pointer(dev->mt76.wcid[idx], &mvif->sta.wcid);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 2e7b05eeef7a..81ab5d8b7c8e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -179,6 +179,7 @@ static int get_omac_idx(enum nl80211_iftype type, u64 mask)
 static int mt7615_add_interface(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif)
 {
+	struct ieee80211_txq *txq = vif->txq[IEEE80211_VIF_TXQ_MULTICAST];
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
@@ -231,8 +232,8 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], &mvif->sta.wcid);
-	if (vif->txq) {
-		mtxq = (struct mt76_txq *)vif->txq->drv_priv;
+	if (txq) {
+		mtxq = (struct mt76_txq *)txq->drv_priv;
 		mtxq->wcid = idx;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 4fb30589fa7a..c02639af7df0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -280,6 +280,7 @@ static void
 mt76x02_vif_init(struct mt76x02_dev *dev, struct ieee80211_vif *vif,
 		 unsigned int idx)
 {
+	struct ieee80211_txq *txq = vif->txq[IEEE80211_VIF_TXQ_MULTICAST];
 	struct mt76x02_vif *mvif = (struct mt76x02_vif *)vif->drv_priv;
 	struct mt76_txq *mtxq;
 
@@ -289,7 +290,7 @@ mt76x02_vif_init(struct mt76x02_dev *dev, struct ieee80211_vif *vif,
 	mvif->group_wcid.idx = MT_VIF_WCID(idx);
 	mt76_wcid_init(&mvif->group_wcid, 0);
 
-	mtxq = (struct mt76_txq *)vif->txq->drv_priv;
+	mtxq = (struct mt76_txq *)txq->drv_priv;
 	rcu_assign_pointer(dev->mt76.wcid[MT_VIF_WCID(idx)], &mvif->group_wcid);
 	mtxq->wcid = MT_VIF_WCID(idx);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 3aa31c5cefa6..020d74b573ec 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -204,6 +204,7 @@ static void mt7915_init_bitrate_mask(struct ieee80211_vif *vif)
 static int mt7915_add_interface(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif)
 {
+	struct ieee80211_txq *txq = vif->txq[IEEE80211_VIF_TXQ_MULTICAST];
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
@@ -259,9 +260,8 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 
 	mt7915_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
-
-	if (vif->txq) {
-		mtxq = (struct mt76_txq *)vif->txq->drv_priv;
+	if (txq) {
+		mtxq = (struct mt76_txq *)txq->drv_priv;
 		mtxq->wcid = idx;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 13e58c328aff..625e0268f81c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -292,6 +292,7 @@ static void mt7921_stop(struct ieee80211_hw *hw, bool suspend)
 static int
 mt7921_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 {
+	struct ieee80211_txq *txq = vif->txq[IEEE80211_VIF_TXQ_MULTICAST];
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct mt792x_phy *phy = mt792x_hw_phy(hw);
@@ -334,8 +335,8 @@ mt7921_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	ewma_rssi_init(&mvif->bss_conf.rssi);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], &mvif->sta.deflink.wcid);
-	if (vif->txq) {
-		mtxq = (struct mt76_txq *)vif->txq->drv_priv;
+	if (txq) {
+		mtxq = (struct mt76_txq *)txq->drv_priv;
 		mtxq->wcid = idx;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 98daf80ac131..c776f33705ab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -356,6 +356,7 @@ static int mt7925_mac_link_bss_add(struct mt792x_dev *dev,
 {
 	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
 	struct ieee80211_vif *vif = link_conf->vif;
+	struct ieee80211_txq *txq = vif->txq[IEEE80211_VIF_TXQ_MULTICAST];
 	struct mt792x_vif *mvif = mconf->vif;
 	struct mt76_txq *mtxq;
 	int idx, ret = 0;
@@ -398,8 +399,8 @@ static int mt7925_mac_link_bss_add(struct mt792x_dev *dev,
 	if (ret)
 		goto out;
 
-	if (vif->txq) {
-		mtxq = (struct mt76_txq *)vif->txq->drv_priv;
+	if (txq) {
+		mtxq = (struct mt76_txq *)txq->drv_priv;
 		mtxq->wcid = idx;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 69dd565d8319..77ea8878e197 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -229,6 +229,7 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 			struct ieee80211_bss_conf *link_conf,
 			struct mt76_vif_link *mlink)
 {
+	struct ieee80211_txq *txq = vif->txq[IEEE80211_VIF_TXQ_MULTICAST];
 	struct mt7996_vif_link *link = container_of(mlink, struct mt7996_vif_link, mt76);
 	struct mt7996_phy *phy = mphy->priv;
 	struct mt7996_dev *dev = phy->dev;
@@ -267,8 +268,8 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	mt7996_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
-	if (vif->txq) {
-		mtxq = (struct mt76_txq *)vif->txq->drv_priv;
+	if (txq) {
+		mtxq = (struct mt76_txq *)txq->drv_priv;
 		mtxq->wcid = idx;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 026fbf4ad9cc..f689e37c4f7d 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -162,7 +162,7 @@ static int rtw_ops_add_interface(struct ieee80211_hw *hw,
 	rtwvif->stats.rx_cnt = 0;
 	rtwvif->scan_req = NULL;
 	memset(&rtwvif->bfee, 0, sizeof(struct rtw_bfee));
-	rtw_txq_init(rtwdev, vif->txq);
+	rtw_txq_init(rtwdev, vif->txq[IEEE80211_VIF_TXQ_MULTICAST]);
 	INIT_LIST_HEAD(&rtwvif->rsvd_page_list);
 
 	mutex_lock(&rtwdev->mutex);
@@ -239,7 +239,7 @@ static void rtw_ops_remove_interface(struct ieee80211_hw *hw,
 
 	rtw_leave_lps_deep(rtwdev);
 
-	rtw_txq_cleanup(rtwdev, vif->txq);
+	rtw_txq_cleanup(rtwdev, vif->txq[IEEE80211_VIF_TXQ_MULTICAST]);
 	rtw_remove_rsvd_page(rtwdev, rtwvif);
 
 	eth_zero_addr(rtwvif->mac_addr);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index e4f9b744f24d..8ba10a1dfcce 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -626,7 +626,7 @@ static void rtw_reset_vif_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
 
 	rtw_bf_disassoc(rtwdev, vif, NULL);
 	rtw_vif_assoc_changed(rtwvif, NULL);
-	rtw_txq_cleanup(rtwdev, vif->txq);
+	rtw_txq_cleanup(rtwdev, vif->txq[IEEE80211_VIF_TXQ_MULTICAST]);
 
 	rtw_release_macid(rtwdev, rtwvif->mac_id);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 778ca8589284..c36afe809255 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -181,7 +181,7 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 
 	rtw89_init_vif(rtwdev, rtwvif, mac_id, port);
 
-	rtw89_core_txq_init(rtwdev, vif->txq);
+	rtw89_core_txq_init(rtwdev, vif->txq[IEEE80211_VIF_TXQ_MULTICAST]);
 
 	if (!rtw89_rtwvif_in_list(rtwdev, rtwvif)) {
 		list_add_tail(&rtwvif->list, &rtwdev->rtwvifs_list);
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 22d32419e8a0..11552c872f2a 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1966,6 +1966,17 @@ enum ieee80211_neg_ttlm_res {
 	NEG_TTLM_RES_SUGGEST_PREFERRED
 };
 
+/**
+ * enum ieee80211_vif_txq - per-vif intermediate queues (txqi)
+ *
+ * @IEEE80211_VIF_TXQ_MULTICAST: queue for broadcast/multicast data frames.
+ * @IEEE80211_VIF_TXQ_NUM: max number of available vif TXQs.
+ */
+enum ieee80211_vif_txq {
+	IEEE80211_VIF_TXQ_MULTICAST,
+	IEEE80211_VIF_TXQ_NUM,
+};
+
 /**
  * struct ieee80211_vif - per-interface data
  *
@@ -2020,7 +2031,7 @@ enum ieee80211_neg_ttlm_res {
  *	for this interface.
  * @drv_priv: data area for driver use, will always be aligned to
  *	sizeof(void \*).
- * @txq: the multicast data TX queue
+ * @txq: per-vif iTXQs (see enum ieee80211_vif_txq for available queues)
  * @offload_flags: 802.3 -> 802.11 enapsulation offload flags, see
  *	&enum ieee80211_offload_flags.
  * @mbssid_tx_vif: Pointer to the transmitting interface if MBSSID is enabled.
@@ -2039,7 +2050,7 @@ struct ieee80211_vif {
 	u8 cab_queue;
 	u8 hw_queue[IEEE80211_NUM_ACS];
 
-	struct ieee80211_txq *txq;
+	struct ieee80211_txq *txq[IEEE80211_VIF_TXQ_NUM];
 
 	netdev_features_t netdev_features;
 	u32 driver_flags;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 5785fe30adaa..805dd0a799bc 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4634,12 +4634,16 @@ static int ieee80211_get_txq_stats(struct wiphy *wiphy,
 	rcu_read_lock();
 
 	if (wdev) {
+		struct ieee80211_txq *txq;
+
 		sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
-		if (!sdata->vif.txq) {
+		txq = sdata->vif.txq[IEEE80211_VIF_TXQ_MULTICAST];
+
+		if (!txq) {
 			ret = 1;
 			goto out;
 		}
-		ieee80211_fill_txq_stats(txqstats, to_txq_info(sdata->vif.txq));
+		ieee80211_fill_txq_stats(txqstats, to_txq_info(txq));
 	} else {
 		/* phy stats */
 		txqstats->filled |= BIT(NL80211_TXQ_STATS_BACKLOG_PACKETS) |
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index 54c479910d05..73de4c6d420e 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -619,10 +619,10 @@ static ssize_t ieee80211_if_fmt_aqm(
 	struct txq_info *txqi;
 	int len;
 
-	if (!sdata->vif.txq)
+	if (!sdata->vif.txq[IEEE80211_VIF_TXQ_MULTICAST])
 		return 0;
 
-	txqi = to_txq_info(sdata->vif.txq);
+	txqi = to_txq_info(sdata->vif.txq[IEEE80211_VIF_TXQ_MULTICAST]);
 
 	spin_lock_bh(&local->fq.lock);
 	rcu_read_lock();
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index e01beda8c414..c6966836817f 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -2238,6 +2238,8 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 
 void ieee80211_if_remove(struct ieee80211_sub_if_data *sdata)
 {
+	struct ieee80211_txq *txq = sdata->vif.txq[IEEE80211_VIF_TXQ_MULTICAST];
+
 	ASSERT_RTNL();
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
@@ -2245,8 +2247,8 @@ void ieee80211_if_remove(struct ieee80211_sub_if_data *sdata)
 	list_del_rcu(&sdata->list);
 	mutex_unlock(&sdata->local->iflist_mtx);
 
-	if (sdata->vif.txq)
-		ieee80211_txq_purge(sdata->local, to_txq_info(sdata->vif.txq));
+	if (txq)
+		ieee80211_txq_purge(sdata->local, to_txq_info(txq));
 
 	synchronize_rcu();
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 914fba53d7f1..e0a63668c785 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1321,7 +1321,7 @@ static struct txq_info *ieee80211_get_txq(struct ieee80211_local *local,
 
 		txq = sta->sta.txq[tid];
 	} else {
-		txq = vif->txq;
+		txq = vif->txq[IEEE80211_VIF_TXQ_MULTICAST];
 	}
 
 	if (!txq)
@@ -1485,10 +1485,10 @@ void ieee80211_txq_remove_vlan(struct ieee80211_local *local,
 
 	ap = container_of(sdata->bss, struct ieee80211_sub_if_data, u.ap);
 
-	if (!ap->vif.txq)
+	if (!ap->vif.txq[IEEE80211_VIF_TXQ_MULTICAST])
 		return;
 
-	txqi = to_txq_info(ap->vif.txq);
+	txqi = to_txq_info(ap->vif.txq[IEEE80211_VIF_TXQ_MULTICAST]);
 	tin = &txqi->tin;
 
 	spin_lock_bh(&fq->lock);
@@ -1510,7 +1510,7 @@ void ieee80211_txq_init(struct ieee80211_sub_if_data *sdata,
 	txqi->txq.vif = &sdata->vif;
 
 	if (!sta) {
-		sdata->vif.txq = &txqi->txq;
+		sdata->vif.txq[IEEE80211_VIF_TXQ_MULTICAST] = &txqi->txq;
 		txqi->txq.tid = 0;
 		txqi->txq.ac = IEEE80211_AC_BE;
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 7f02bd5891eb..9f99128d6219 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -324,6 +324,7 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_vif *vif = &sdata->vif;
+	struct ieee80211_txq *txq_mc = vif->txq[IEEE80211_VIF_TXQ_MULTICAST];
 	struct fq *fq = &local->fq;
 	struct ps_data *ps = NULL;
 	struct txq_info *txqi;
@@ -364,13 +365,13 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 		}
 	}
 
-	if (!vif->txq)
+	if (!txq_mc)
 		goto out;
 
-	txqi = to_txq_info(vif->txq);
+	txqi = to_txq_info(txq_mc);
 
 	if (!test_and_clear_bit(IEEE80211_TXQ_DIRTY, &txqi->flags) ||
-	    (ps && atomic_read(&ps->num_sta_ps)) || ac != vif->txq->ac)
+	    (ps && atomic_read(&ps->num_sta_ps)) || ac != txq_mc->ac)
 		goto out;
 
 	spin_unlock(&fq->lock);
-- 
2.48.1


