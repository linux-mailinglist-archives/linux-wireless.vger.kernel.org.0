Return-Path: <linux-wireless+bounces-14820-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C89489B9429
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 16:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25437B21736
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 15:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7344E1C7265;
	Fri,  1 Nov 2024 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkUknXbg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F37D1C4614
	for <linux-wireless@vger.kernel.org>; Fri,  1 Nov 2024 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730474231; cv=none; b=lY+SVdSA1YRI+KPihwwtdMs9c6OoBVvda5hIJWM8CFsHWuFYfUnOIw3RS/A71bueKuASBQtHBWm0nE7aKDSTw4OakduNTmmKkBW6OblkFlSp2wLRHYGdo9pZZFj3ia4shCy4z6qLSioR50p49liV8pkPMjbia+uzM7jbq+MiYlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730474231; c=relaxed/simple;
	bh=rcBypkgCgL8SvIFBJXsWTYcHZliyF4Ma4VJgUOVrcJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BHNVTnDpfm70I/0ZBuYBE9glPxjID0DKQ+jSnFU4jcmGhxmmEHv44QqUiZTHcHH3Q79rGxmvEZXL7hnFDG4zetbPW648eQ6dVsl6CfcphW6Z25A041nQFjx0YUNmkRYncJTYGQaiByF1y5u882+UHhPSTB1yngSal7CuAXmrlUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkUknXbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4042CC4CECD;
	Fri,  1 Nov 2024 15:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730474230;
	bh=rcBypkgCgL8SvIFBJXsWTYcHZliyF4Ma4VJgUOVrcJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GkUknXbgM+PgLx0083Kk72TO+dKkwOxtTWSl7MYpvH7bInjHEfo+6cPeOurN3SQXN
	 8ccylpJD/rYndmRvjrnHbyqxDO5co7IPjq4s/6o1It2G6lcAd8kgtbyXDa2jpiCPRd
	 0mEM3ddppK3HJA0XG11n8PX0VEun/CEi/Zb8LWHlk7JFKeXi/TEzn1A9zMJhl4HdKS
	 bsFKiE0GgMiwTJDHBn+EMeNqz3RpYzoVKkB6HusrDHnC6UuwFug2hkJ81TgN8LgtMi
	 NHHQFu3LY4cqSgp0+73jYOdaQ58A6z3Tql1zdK/7adUN3eWf7M9bXTlAJrV6gRGqW7
	 5Y1kI0djHezEQ==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 3/8] wifi: ath12k: Refactor sta state machine
Date: Fri,  1 Nov 2024 17:17:00 +0200
Message-Id: <20241101151705.165987-4-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241101151705.165987-1-kvalo@kernel.org>
References: <20241101151705.165987-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sriram R <quic_srirrama@quicinc.com>

Refactor ath12k_mac_op_sta_state(), with generic wrappers which can be used for
both multi link stations and non-ML stations.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |   3 +
 drivers/net/wireless/ath/ath12k/mac.c  | 343 +++++++++++++++++--------
 2 files changed, 244 insertions(+), 102 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 06b637ba8b8f..6faa46b9adc9 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -461,6 +461,9 @@ struct ath12k_link_sta {
 	struct ath12k_link_vif *arvif;
 	struct ath12k_sta *ahsta;
 
+	/* link address similar to ieee80211_link_sta */
+	u8 addr[ETH_ALEN];
+
 	/* the following are protected by ar->data_lock */
 	u32 changed; /* IEEE80211_RC_* */
 	u32 bw;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 16b14ae502a6..354fc21f2af2 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4519,10 +4519,10 @@ ath12k_mac_set_peer_vht_fixed_rate(struct ath12k_link_vif *arvif,
 	return ret;
 }
 
-static int ath12k_station_assoc(struct ath12k *ar,
-				struct ath12k_link_vif *arvif,
-				struct ath12k_link_sta *arsta,
-				bool reassoc)
+static int ath12k_mac_station_assoc(struct ath12k *ar,
+				    struct ath12k_link_vif *arvif,
+				    struct ath12k_link_sta *arsta,
+				    bool reassoc)
 {
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
 	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
@@ -4609,28 +4609,19 @@ static int ath12k_station_assoc(struct ath12k *ar,
 	return 0;
 }
 
-static int ath12k_station_disassoc(struct ath12k *ar,
-				   struct ath12k_link_vif *arvif,
-				   struct ath12k_link_sta *arsta)
+static int ath12k_mac_station_disassoc(struct ath12k *ar,
+				       struct ath12k_link_vif *arvif,
+				       struct ath12k_link_sta *arsta)
 {
 	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
-	int ret;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	if (!sta->wme) {
 		arvif->num_legacy_stations--;
-		ret = ath12k_recalc_rtscts_prot(arvif);
-		if (ret)
-			return ret;
+		return ath12k_recalc_rtscts_prot(arvif);
 	}
 
-	ret = ath12k_clear_peer_keys(arvif, sta->addr);
-	if (ret) {
-		ath12k_warn(ar->ab, "failed to clear all peer keys for vdev %i: %d\n",
-			    arvif->vdev_id, ret);
-		return ret;
-	}
 	return 0;
 }
 
@@ -4826,6 +4817,147 @@ static void ath12k_mac_dec_num_stations(struct ath12k_link_vif *arvif,
 	ar->num_stations--;
 }
 
+static void ath12k_mac_station_post_remove(struct ath12k *ar,
+					   struct ath12k_link_vif *arvif,
+					   struct ath12k_link_sta *arsta)
+{
+	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
+	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
+	struct ath12k_sta *ahsta = arsta->ahsta;
+	struct ath12k_peer *peer;
+
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
+	ath12k_mac_dec_num_stations(arvif, arsta);
+
+	spin_lock_bh(&ar->ab->base_lock);
+
+	peer = ath12k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
+	if (peer && peer->sta == sta) {
+		ath12k_warn(ar->ab, "Found peer entry %pM n vdev %i after it was supposedly removed\n",
+			    vif->addr, arvif->vdev_id);
+		peer->sta = NULL;
+		list_del(&peer->list);
+		kfree(peer);
+		ar->num_peers--;
+	}
+
+	spin_unlock_bh(&ar->ab->base_lock);
+
+	kfree(arsta->rx_stats);
+	arsta->rx_stats = NULL;
+
+	if (arsta->link_id < IEEE80211_MLD_MAX_NUM_LINKS) {
+		ahsta->links_map &= ~(BIT(arsta->link_id));
+		rcu_assign_pointer(ahsta->link[arsta->link_id], NULL);
+		synchronize_rcu();
+		arsta->link_id = ATH12K_INVALID_LINK_ID;
+		arsta->ahsta = NULL;
+	}
+}
+
+static int ath12k_mac_station_unauthorize(struct ath12k *ar,
+					  struct ath12k_link_vif *arvif,
+					  struct ath12k_link_sta *arsta)
+{
+	struct ath12k_peer *peer;
+	int ret;
+
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
+	spin_lock_bh(&ar->ab->base_lock);
+
+	peer = ath12k_peer_find(ar->ab, arvif->vdev_id, arsta->addr);
+	if (peer)
+		peer->is_authorized = false;
+
+	spin_unlock_bh(&ar->ab->base_lock);
+
+	/* Driver must clear the keys during the state change from
+	 * IEEE80211_STA_AUTHORIZED to IEEE80211_STA_ASSOC, since after
+	 * returning from here, mac80211 is going to delete the keys
+	 * in __sta_info_destroy_part2(). This will ensure that the driver does
+	 * not retain stale key references after mac80211 deletes the keys.
+	 */
+	ret = ath12k_clear_peer_keys(arvif, arsta->addr);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to clear all peer keys for vdev %i: %d\n",
+			    arvif->vdev_id, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ath12k_mac_station_authorize(struct ath12k *ar,
+					struct ath12k_link_vif *arvif,
+					struct ath12k_link_sta *arsta)
+{
+	struct ath12k_peer *peer;
+	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
+	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
+	int ret;
+
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
+	spin_lock_bh(&ar->ab->base_lock);
+
+	peer = ath12k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
+	if (peer)
+		peer->is_authorized = true;
+
+	spin_unlock_bh(&ar->ab->base_lock);
+
+	if (vif->type == NL80211_IFTYPE_STATION && arvif->is_up) {
+		ret = ath12k_wmi_set_peer_param(ar, sta->addr,
+						arvif->vdev_id,
+						WMI_PEER_AUTHORIZE,
+						1);
+		if (ret) {
+			ath12k_warn(ar->ab, "Unable to authorize peer %pM vdev %d: %d\n",
+				    sta->addr, arvif->vdev_id, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int ath12k_mac_station_remove(struct ath12k *ar,
+				     struct ath12k_link_vif *arvif,
+				     struct ath12k_link_sta *arsta)
+{
+	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
+	struct ath12k_vif *ahvif = arvif->ahvif;
+	int ret;
+
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
+	wiphy_work_cancel(ar->ah->hw->wiphy, &arsta->update_wk);
+
+	if (ahvif->vdev_type == WMI_VDEV_TYPE_STA) {
+		ath12k_bss_disassoc(ar, arvif);
+		ret = ath12k_mac_vdev_stop(arvif);
+		if (ret)
+			ath12k_warn(ar->ab, "failed to stop vdev %i: %d\n",
+				    arvif->vdev_id, ret);
+	}
+
+	ath12k_dp_peer_cleanup(ar, arvif->vdev_id, sta->addr);
+
+	ret = ath12k_peer_delete(ar, arvif->vdev_id, sta->addr);
+	if (ret)
+		ath12k_warn(ar->ab, "Failed to delete peer: %pM for VDEV: %d\n",
+			    sta->addr, arvif->vdev_id);
+	else
+		ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "Removed peer: %pM for VDEV: %d\n",
+			   sta->addr, arvif->vdev_id);
+
+	ath12k_mac_station_post_remove(ar, arvif, arsta);
+
+	return ret;
+}
+
 static int ath12k_mac_station_add(struct ath12k *ar,
 				  struct ath12k_link_vif *arvif,
 				  struct ath12k_link_sta *arsta)
@@ -4933,31 +5065,37 @@ static u32 ath12k_mac_ieee80211_sta_bw_to_wmi(struct ath12k *ar,
 	return bw;
 }
 
-static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
-				   struct ieee80211_vif *vif,
-				   struct ieee80211_sta *sta,
-				   enum ieee80211_sta_state old_state,
-				   enum ieee80211_sta_state new_state)
+static int ath12k_mac_handle_link_sta_state(struct ieee80211_hw *hw,
+					    struct ath12k_link_vif *arvif,
+					    struct ath12k_link_sta *arsta,
+					    enum ieee80211_sta_state old_state,
+					    enum ieee80211_sta_state new_state)
 {
-	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
-	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
-	struct ath12k *ar;
-	struct ath12k_link_vif *arvif;
-	struct ath12k_link_sta *arsta;
-	struct ath12k_peer *peer;
+	struct ath12k *ar = arvif->ar;
+	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
+	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
+	struct ath12k_sta *ahsta = arsta->ahsta;
 	int ret = 0;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	arvif = &ahvif->deflink;
-	arsta = &ahsta->deflink;
+	/* IEEE80211_STA_NONE -> IEEE80211_STA_NOTEXIST: Remove the station
+	 * from driver
+	 */
+	if ((old_state == IEEE80211_STA_NONE &&
+	     new_state == IEEE80211_STA_NOTEXIST)) {
+		/* ML sta needs separate handling */
+		if (sta->mlo)
+			return 0;
 
-	ar = ath12k_get_ar_by_vif(hw, vif);
-	if (!ar) {
-		WARN_ON_ONCE(1);
-		return -EINVAL;
+		ret = ath12k_mac_station_remove(ar, arvif, arsta);
+		if (ret) {
+			ath12k_warn(ar->ab, "Failed to remove station: %pM for VDEV: %d\n",
+				    arsta->addr, arvif->vdev_id);
+		}
 	}
 
+	/* IEEE80211_STA_NOTEXIST -> IEEE80211_STA_NONE: Add new station to driver */
 	if (old_state == IEEE80211_STA_NOTEXIST &&
 	    new_state == IEEE80211_STA_NONE) {
 		memset(arsta, 0, sizeof(*arsta));
@@ -4975,56 +5113,16 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 		if (ret)
 			ath12k_warn(ar->ab, "Failed to add station: %pM for VDEV: %d\n",
 				    sta->addr, arvif->vdev_id);
-	} else if ((old_state == IEEE80211_STA_NONE &&
-		    new_state == IEEE80211_STA_NOTEXIST)) {
-		wiphy_work_cancel(hw->wiphy, &arsta->update_wk);
 
-		if (ahvif->vdev_type == WMI_VDEV_TYPE_STA) {
-			ath12k_bss_disassoc(ar, arvif);
-			ret = ath12k_mac_vdev_stop(arvif);
-			if (ret)
-				ath12k_warn(ar->ab, "failed to stop vdev %i: %d\n",
-					    arvif->vdev_id, ret);
-		}
-		ath12k_dp_peer_cleanup(ar, arvif->vdev_id, sta->addr);
-
-		ret = ath12k_peer_delete(ar, arvif->vdev_id, sta->addr);
-		if (ret)
-			ath12k_warn(ar->ab, "Failed to delete peer: %pM for VDEV: %d\n",
-				    sta->addr, arvif->vdev_id);
-		else
-			ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "Removed peer: %pM for VDEV: %d\n",
-				   sta->addr, arvif->vdev_id);
-
-		ath12k_mac_dec_num_stations(arvif, arsta);
-		spin_lock_bh(&ar->ab->base_lock);
-		peer = ath12k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
-		if (peer && peer->sta == sta) {
-			ath12k_warn(ar->ab, "Found peer entry %pM n vdev %i after it was supposedly removed\n",
-				    vif->addr, arvif->vdev_id);
-			peer->sta = NULL;
-			list_del(&peer->list);
-			kfree(peer);
-			ar->num_peers--;
-		}
-		spin_unlock_bh(&ar->ab->base_lock);
-
-		kfree(arsta->rx_stats);
-		arsta->rx_stats = NULL;
-
-		if (arsta->link_id < IEEE80211_MLD_MAX_NUM_LINKS) {
-			rcu_assign_pointer(ahsta->link[arsta->link_id], NULL);
-			synchronize_rcu();
-			ahsta->links_map &= ~(BIT(arsta->link_id));
-			arsta->link_id = ATH12K_INVALID_LINK_ID;
-			arsta->ahsta = NULL;
-		}
+	/* IEEE80211_STA_AUTH -> IEEE80211_STA_ASSOC: Send station assoc command for
+	 * peer associated to AP/Mesh/ADHOC vif type.
+	 */
 	} else if (old_state == IEEE80211_STA_AUTH &&
 		   new_state == IEEE80211_STA_ASSOC &&
 		   (vif->type == NL80211_IFTYPE_AP ||
 		    vif->type == NL80211_IFTYPE_MESH_POINT ||
 		    vif->type == NL80211_IFTYPE_ADHOC)) {
-		ret = ath12k_station_assoc(ar, arvif, arsta, false);
+		ret = ath12k_mac_station_assoc(ar, arvif, arsta, false);
 		if (ret)
 			ath12k_warn(ar->ab, "Failed to associate station: %pM\n",
 				    sta->addr);
@@ -5035,40 +5133,32 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 		arsta->bw_prev = sta->deflink.bandwidth;
 
 		spin_unlock_bh(&ar->data_lock);
+
+	/* IEEE80211_STA_ASSOC -> IEEE80211_STA_AUTHORIZED: set peer status as
+	 * authorized
+	 */
 	} else if (old_state == IEEE80211_STA_ASSOC &&
 		   new_state == IEEE80211_STA_AUTHORIZED) {
-		spin_lock_bh(&ar->ab->base_lock);
+		ret = ath12k_mac_station_authorize(ar, arvif, arsta);
+		if (ret)
+			ath12k_warn(ar->ab, "Failed to authorize station: %pM\n",
+				    sta->addr);
 
-		peer = ath12k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
-		if (peer)
-			peer->is_authorized = true;
-
-		spin_unlock_bh(&ar->ab->base_lock);
-
-		if (vif->type == NL80211_IFTYPE_STATION && arvif->is_up) {
-			ret = ath12k_wmi_set_peer_param(ar, sta->addr,
-							arvif->vdev_id,
-							WMI_PEER_AUTHORIZE,
-							1);
-			if (ret)
-				ath12k_warn(ar->ab, "Unable to authorize peer %pM vdev %d: %d\n",
-					    sta->addr, arvif->vdev_id, ret);
-		}
+	/* IEEE80211_STA_AUTHORIZED -> IEEE80211_STA_ASSOC: station may be in removal,
+	 * deauthorize it.
+	 */
 	} else if (old_state == IEEE80211_STA_AUTHORIZED &&
 		   new_state == IEEE80211_STA_ASSOC) {
-		spin_lock_bh(&ar->ab->base_lock);
-
-		peer = ath12k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
-		if (peer)
-			peer->is_authorized = false;
-
-		spin_unlock_bh(&ar->ab->base_lock);
+		ath12k_mac_station_unauthorize(ar, arvif, arsta);
+	/* IEEE80211_STA_ASSOC -> IEEE80211_STA_AUTH: disassoc peer connected to
+	 * AP/mesh/ADHOC vif type.
+	 */
 	} else if (old_state == IEEE80211_STA_ASSOC &&
 		   new_state == IEEE80211_STA_AUTH &&
 		   (vif->type == NL80211_IFTYPE_AP ||
 		    vif->type == NL80211_IFTYPE_MESH_POINT ||
 		    vif->type == NL80211_IFTYPE_ADHOC)) {
-		ret = ath12k_station_disassoc(ar, arvif, arsta);
+		ret = ath12k_mac_station_disassoc(ar, arvif, arsta);
 		if (ret)
 			ath12k_warn(ar->ab, "Failed to disassociate station: %pM\n",
 				    sta->addr);
@@ -5077,6 +5167,55 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 	return ret;
 }
 
+static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_sta *sta,
+				   enum ieee80211_sta_state old_state,
+				   enum ieee80211_sta_state new_state)
+{
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
+	struct ath12k_link_vif *arvif;
+	struct ath12k_link_sta *arsta;
+	int ret;
+	u8 link_id = 0;
+
+	lockdep_assert_wiphy(hw->wiphy);
+
+	if (ieee80211_vif_is_mld(vif) && sta->valid_links) {
+		WARN_ON(!sta->mlo && hweight16(sta->valid_links) != 1);
+		link_id = ffs(sta->valid_links) - 1;
+	}
+
+	/* Handle for non-ML station */
+	if (!sta->mlo) {
+		arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
+		arsta = &ahsta->deflink;
+		arsta->ahsta = ahsta;
+
+		if (WARN_ON(!arvif || !arsta)) {
+			ret = -EINVAL;
+			goto exit;
+		}
+
+		/* vdev might be in deleted */
+		if (WARN_ON(!arvif->ar)) {
+			ret = -EINVAL;
+			goto exit;
+		}
+
+		ret = ath12k_mac_handle_link_sta_state(hw, arvif, arsta,
+						       old_state, new_state);
+		if (ret)
+			goto exit;
+	}
+
+	ret = 0;
+
+exit:
+	return ret;
+}
+
 static int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif,
 				       struct ieee80211_sta *sta)
-- 
2.39.5


