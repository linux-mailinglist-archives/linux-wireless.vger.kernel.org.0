Return-Path: <linux-wireless+bounces-15554-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C4D9D503A
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 16:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9D321F2325D
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 15:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1366779C4;
	Thu, 21 Nov 2024 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8LWEZyz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E530319CD1D
	for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2024 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732204690; cv=none; b=qXhixXEgosHNlWyVn9UmXzLO2AY+0EStLVNI5Y0Dtj+G+1KoObqMrjcZJhGDfzkgs6tT9D8dGh/1FM7kMn3nC6IxUwwmE0O3eio7o0SEDmPuXdKccgww4GJK1lIE6mUEELa9ZoUEntxCBWwMGrxB2yqBpswjyFerwIfF7ABD6G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732204690; c=relaxed/simple;
	bh=RzuK677p7aM4LquuWO3rvfGBko1mHP7whjs5/BmUzxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E3UtcEt5qvra64wYGr9IIQ8W5Xom2TLzwihUYlx2unhoPPI/g1M/lvI1xFIJ9T45JYVKLHpgndYd9vkCiWo4XivzbFL51sbxvz641m7yZPn7JFrZE5ieqeOyfDcPOJ+9YI733jD3XRFOkiBLyhU8AVkWjFcdEAmCHhVlmLmJpqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8LWEZyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDE2C4CECD;
	Thu, 21 Nov 2024 15:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732204689;
	bh=RzuK677p7aM4LquuWO3rvfGBko1mHP7whjs5/BmUzxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O8LWEZyziTlIsaEM8jzI0XXB3yfsEvTRNJlROfPE54zUo+CxW/Fm+/5Bz8C3RHhLY
	 ycP8UjeVr/nLk808foTLojsimRfXvhdfcjO6OMvu/piEMJa92GHPQvCNurKTtxMgLc
	 UcjmemD9P0Uni2cVu6+RtJffo6dQglaOM9VIsuITHjFwatbHz9VpYys+LTPLGyPlEj
	 hJDpipDNE1nJsavpBOV1VUNTerD01hEOIW2om7Ea2utuWN0+qiJk7PgBV0sYNT5brF
	 nAz7Ecs1ybzcBsEEt1mLIr0XqSuaigTv5QTKtiVdR7Dmw4NdlFl1NVF3KZE9Fr1JwL
	 /UiSbxC7hfOcg==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 1/8] wifi: ath12k: Add MLO station state change handling
Date: Thu, 21 Nov 2024 17:57:59 +0200
Message-Id: <20241121155806.1862733-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121155806.1862733-1-kvalo@kernel.org>
References: <20241121155806.1862733-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sriram R <quic_srirrama@quicinc.com>

Add changes to handle multi-link station state change with proper
link handling and add code changes for ML peer creation, peer deletion.

In ath12k_mac_assign_link_sta() initialise all arsta fields first and only then
call rcu_assign_pointer(). This is to make sure that readers don't have access
to arsta which is still modified.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |   4 +
 drivers/net/wireless/ath/ath12k/mac.c  | 227 ++++++++++++++++++++-----
 drivers/net/wireless/ath/ath12k/mac.h  |   1 +
 drivers/net/wireless/ath/ath12k/peer.c |  83 ++++++++-
 drivers/net/wireless/ath/ath12k/peer.h |   1 +
 5 files changed, 272 insertions(+), 44 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 8dbdf6818f58..c1d5e93b679a 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -510,7 +510,11 @@ struct ath12k_sta {
 	struct ath12k_link_sta __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
 	/* indicates bitmap of link sta created in FW */
 	u16 links_map;
+	u8 assoc_link_id;
 	u16 ml_peer_id;
+	u8 num_peer;
+
+	enum ieee80211_sta_state state;
 };
 
 #define ATH12K_MIN_5G_FREQ 4150
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index ad27a2552a2c..d796185c8431 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1251,7 +1251,7 @@ static int ath12k_mac_monitor_stop(struct ath12k *ar)
 	return ret;
 }
 
-static int ath12k_mac_vdev_stop(struct ath12k_link_vif *arvif)
+int ath12k_mac_vdev_stop(struct ath12k_link_vif *arvif)
 {
 	struct ath12k_vif *ahvif = arvif->ahvif;
 	struct ath12k *ar = arvif->ar;
@@ -4832,6 +4832,35 @@ static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 	}
 }
 
+static void ath12k_mac_free_unassign_link_sta(struct ath12k_hw *ah,
+					      struct ath12k_sta *ahsta,
+					      u8 link_id)
+{
+	struct ath12k_link_sta *arsta;
+
+	lockdep_assert_wiphy(ah->hw->wiphy);
+
+	if (WARN_ON(link_id >= IEEE80211_MLD_MAX_NUM_LINKS))
+		return;
+
+	arsta = wiphy_dereference(ah->hw->wiphy, ahsta->link[link_id]);
+	if (WARN_ON(!arsta))
+		return;
+
+	ahsta->links_map &= ~BIT(link_id);
+	rcu_assign_pointer(ahsta->link[link_id], NULL);
+	synchronize_rcu();
+
+	if (arsta == &ahsta->deflink) {
+		arsta->link_id = ATH12K_INVALID_LINK_ID;
+		arsta->ahsta = NULL;
+		arsta->arvif = NULL;
+		return;
+	}
+
+	kfree(arsta);
+}
+
 static int ath12k_mac_inc_num_stations(struct ath12k_link_vif *arvif,
 				       struct ath12k_link_sta *arsta)
 {
@@ -4871,7 +4900,6 @@ static void ath12k_mac_station_post_remove(struct ath12k *ar,
 {
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
 	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
-	struct ath12k_sta *ahsta = arsta->ahsta;
 	struct ath12k_peer *peer;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
@@ -4894,14 +4922,6 @@ static void ath12k_mac_station_post_remove(struct ath12k *ar,
 
 	kfree(arsta->rx_stats);
 	arsta->rx_stats = NULL;
-
-	if (arsta->link_id < IEEE80211_MLD_MAX_NUM_LINKS) {
-		ahsta->links_map &= ~(BIT(arsta->link_id));
-		rcu_assign_pointer(ahsta->link[arsta->link_id], NULL);
-		synchronize_rcu();
-		arsta->link_id = ATH12K_INVALID_LINK_ID;
-		arsta->ahsta = NULL;
-	}
 }
 
 static int ath12k_mac_station_unauthorize(struct ath12k *ar,
@@ -4977,7 +4997,7 @@ static int ath12k_mac_station_remove(struct ath12k *ar,
 {
 	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
 	struct ath12k_vif *ahvif = arvif->ahvif;
-	int ret;
+	int ret = 0;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
@@ -4991,6 +5011,9 @@ static int ath12k_mac_station_remove(struct ath12k *ar,
 				    arvif->vdev_id, ret);
 	}
 
+	if (sta->mlo)
+		return ret;
+
 	ath12k_dp_peer_cleanup(ar, arvif->vdev_id, sta->addr);
 
 	ret = ath12k_peer_delete(ar, arvif->vdev_id, sta->addr);
@@ -5003,6 +5026,10 @@ static int ath12k_mac_station_remove(struct ath12k *ar,
 
 	ath12k_mac_station_post_remove(ar, arvif, arsta);
 
+	if (sta->valid_links)
+		ath12k_mac_free_unassign_link_sta(ahvif->ah,
+						  arsta->ahsta, arsta->link_id);
+
 	return ret;
 }
 
@@ -5114,51 +5141,112 @@ static u32 ath12k_mac_ieee80211_sta_bw_to_wmi(struct ath12k *ar,
 	return bw;
 }
 
+static int ath12k_mac_assign_link_sta(struct ath12k_hw *ah,
+				      struct ath12k_sta *ahsta,
+				      struct ath12k_link_sta *arsta,
+				      struct ath12k_vif *ahvif,
+				      u8 link_id)
+{
+	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(ahsta);
+	struct ieee80211_link_sta *link_sta;
+	struct ath12k_link_vif *arvif;
+
+	lockdep_assert_wiphy(ah->hw->wiphy);
+
+	if (!arsta || link_id >= IEEE80211_MLD_MAX_NUM_LINKS)
+		return -EINVAL;
+
+	arvif = wiphy_dereference(ah->hw->wiphy, ahvif->link[link_id]);
+	if (!arvif)
+		return -EINVAL;
+
+	memset(arsta, 0, sizeof(*arsta));
+
+	link_sta = wiphy_dereference(ah->hw->wiphy, sta->link[link_id]);
+	if (!link_sta)
+		return -EINVAL;
+
+	ether_addr_copy(arsta->addr, link_sta->addr);
+
+	/* logical index of the link sta in order of creation */
+	arsta->link_idx = ahsta->num_peer++;
+
+	arsta->link_id = link_id;
+	ahsta->links_map |= BIT(arsta->link_id);
+	arsta->arvif = arvif;
+	arsta->ahsta = ahsta;
+	wiphy_work_init(&arsta->update_wk, ath12k_sta_rc_update_wk);
+
+	rcu_assign_pointer(ahsta->link[link_id], arsta);
+
+	return 0;
+}
+
+static void ath12k_mac_ml_station_remove(struct ath12k_vif *ahvif,
+					 struct ath12k_sta *ahsta)
+{
+	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(ahsta);
+	struct ath12k_hw *ah = ahvif->ah;
+	struct ath12k_link_vif *arvif;
+	struct ath12k_link_sta *arsta;
+	unsigned long links;
+	struct ath12k *ar;
+	u8 link_id;
+
+	lockdep_assert_wiphy(ah->hw->wiphy);
+
+	ath12k_peer_mlo_link_peers_delete(ahvif, ahsta);
+
+	/* validate link station removal and clear arsta links */
+	links = ahsta->links_map;
+	for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		arvif = wiphy_dereference(ah->hw->wiphy, ahvif->link[link_id]);
+		arsta = wiphy_dereference(ah->hw->wiphy, ahsta->link[link_id]);
+		if (!arvif || !arsta)
+			continue;
+
+		ar = arvif->ar;
+
+		ath12k_mac_station_post_remove(ar, arvif, arsta);
+
+		ath12k_mac_free_unassign_link_sta(ah, ahsta, link_id);
+	}
+
+	ath12k_peer_ml_delete(ah, sta);
+}
+
 static int ath12k_mac_handle_link_sta_state(struct ieee80211_hw *hw,
 					    struct ath12k_link_vif *arvif,
 					    struct ath12k_link_sta *arsta,
 					    enum ieee80211_sta_state old_state,
 					    enum ieee80211_sta_state new_state)
 {
-	struct ath12k *ar = arvif->ar;
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
 	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
-	struct ath12k_sta *ahsta = arsta->ahsta;
+	struct ath12k *ar = arvif->ar;
 	int ret = 0;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac handle link %u sta %pM state %d -> %d\n",
+		   arsta->link_id, arsta->addr, old_state, new_state);
+
 	/* IEEE80211_STA_NONE -> IEEE80211_STA_NOTEXIST: Remove the station
 	 * from driver
 	 */
 	if ((old_state == IEEE80211_STA_NONE &&
 	     new_state == IEEE80211_STA_NOTEXIST)) {
-		/* ML sta needs separate handling */
-		if (sta->mlo)
-			return 0;
-
 		ret = ath12k_mac_station_remove(ar, arvif, arsta);
 		if (ret) {
 			ath12k_warn(ar->ab, "Failed to remove station: %pM for VDEV: %d\n",
 				    arsta->addr, arvif->vdev_id);
+			goto exit;
 		}
 	}
 
 	/* IEEE80211_STA_NOTEXIST -> IEEE80211_STA_NONE: Add new station to driver */
 	if (old_state == IEEE80211_STA_NOTEXIST &&
 	    new_state == IEEE80211_STA_NONE) {
-		memset(arsta, 0, sizeof(*arsta));
-		rcu_assign_pointer(ahsta->link[0], arsta);
-		/* TODO use appropriate link id once MLO support is added  */
-		arsta->link_id = ATH12K_DEFAULT_LINK_ID;
-		ahsta->links_map = BIT(arsta->link_id);
-		arsta->ahsta = ahsta;
-		arsta->arvif = arvif;
-		ether_addr_copy(arsta->addr, sta->addr);
-		wiphy_work_init(&arsta->update_wk, ath12k_sta_rc_update_wk);
-
-		synchronize_rcu();
-
 		ret = ath12k_mac_station_add(ar, arvif, arsta);
 		if (ret)
 			ath12k_warn(ar->ab, "Failed to add station: %pM for VDEV: %d\n",
@@ -5200,6 +5288,7 @@ static int ath12k_mac_handle_link_sta_state(struct ieee80211_hw *hw,
 	} else if (old_state == IEEE80211_STA_AUTHORIZED &&
 		   new_state == IEEE80211_STA_ASSOC) {
 		ath12k_mac_station_unauthorize(ar, arvif, arsta);
+
 	/* IEEE80211_STA_ASSOC -> IEEE80211_STA_AUTH: disassoc peer connected to
 	 * AP/mesh/ADHOC vif type.
 	 */
@@ -5214,6 +5303,7 @@ static int ath12k_mac_handle_link_sta_state(struct ieee80211_hw *hw,
 				    sta->addr);
 	}
 
+exit:
 	return ret;
 }
 
@@ -5225,10 +5315,12 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 {
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k_link_vif *arvif;
 	struct ath12k_link_sta *arsta;
-	int ret;
+	unsigned long valid_links;
 	u8 link_id = 0;
+	int ret;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
@@ -5237,32 +5329,83 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 		link_id = ffs(sta->valid_links) - 1;
 	}
 
-	/* Handle for non-ML station */
-	if (!sta->mlo) {
-		arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
-		arsta = &ahsta->deflink;
-		arsta->ahsta = ahsta;
+	/* IEEE80211_STA_NOTEXIST -> IEEE80211_STA_NONE:
+	 * New station add received. If this is a ML station then
+	 * ahsta->links_map will be zero and sta->valid_links will be 1.
+	 * Assign default link to the first link sta.
+	 */
+	if (old_state == IEEE80211_STA_NOTEXIST &&
+	    new_state == IEEE80211_STA_NONE) {
+		memset(ahsta, 0, sizeof(*ahsta));
 
-		if (WARN_ON(!arvif || !arsta)) {
-			ret = -EINVAL;
+		arsta = &ahsta->deflink;
+
+		/* ML sta */
+		if (sta->mlo && !ahsta->links_map &&
+		    (hweight16(sta->valid_links) == 1)) {
+			ret = ath12k_peer_ml_create(ah, sta);
+			if (ret) {
+				ath12k_hw_warn(ah, "unable to create ML peer for sta %pM",
+					       sta->addr);
+				goto exit;
+			}
+		}
+
+		ret = ath12k_mac_assign_link_sta(ah, ahsta, arsta, ahvif,
+						 link_id);
+		if (ret) {
+			ath12k_hw_warn(ah, "unable assign link %d for sta %pM",
+				       link_id, sta->addr);
 			goto exit;
 		}
 
+		/* above arsta will get memset, hence do this after assign
+		 * link sta
+		 */
+		if (sta->mlo) {
+			arsta->is_assoc_link = true;
+			ahsta->assoc_link_id = link_id;
+		}
+	}
+
+	/* Handle all the other state transitions in generic way */
+	valid_links = ahsta->links_map;
+	for_each_set_bit(link_id, &valid_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
+		arsta = wiphy_dereference(hw->wiphy, ahsta->link[link_id]);
+		/* some assumptions went wrong! */
+		if (WARN_ON(!arvif || !arsta))
+			continue;
+
 		/* vdev might be in deleted */
-		if (WARN_ON(!arvif->ar)) {
-			ret = -EINVAL;
-			goto exit;
-		}
+		if (WARN_ON(!arvif->ar))
+			continue;
 
 		ret = ath12k_mac_handle_link_sta_state(hw, arvif, arsta,
 						       old_state, new_state);
-		if (ret)
+		if (ret) {
+			ath12k_hw_warn(ah, "unable to move link sta %d of sta %pM from state %d to %d",
+				       link_id, arsta->addr, old_state, new_state);
 			goto exit;
+		}
 	}
 
+	/* IEEE80211_STA_NONE -> IEEE80211_STA_NOTEXIST:
+	 * Remove the station from driver (handle ML sta here since that
+	 * needs special handling. Normal sta will be handled in generic
+	 * handler below
+	 */
+	if (old_state == IEEE80211_STA_NONE &&
+	    new_state == IEEE80211_STA_NOTEXIST && sta->mlo)
+		ath12k_mac_ml_station_remove(ahvif, ahsta);
+
 	ret = 0;
 
 exit:
+	/* update the state if everything went well */
+	if (!ret)
+		ahsta->state = new_state;
+
 	return ret;
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index d382337ba649..c13630ee479a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -89,5 +89,6 @@ int ath12k_mac_vif_set_keepalive(struct ath12k_link_vif *arvif,
 				 enum wmi_sta_keepalive_method method,
 				 u32 interval);
 u8 ath12k_mac_get_target_pdev_id(struct ath12k *ar);
+int ath12k_mac_vdev_stop(struct ath12k_link_vif *arvif);
 
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index 0e86847edd6e..ffbc1265ccc1 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -264,8 +264,9 @@ int ath12k_wait_for_peer_delete_done(struct ath12k *ar, u32 vdev_id,
 	return 0;
 }
 
-int ath12k_peer_delete(struct ath12k *ar, u32 vdev_id, u8 *addr)
+static int ath12k_peer_delete_send(struct ath12k *ar, u32 vdev_id, const u8 *addr)
 {
+	struct ath12k_base *ab = ar->ab;
 	int ret;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
@@ -274,12 +275,25 @@ int ath12k_peer_delete(struct ath12k *ar, u32 vdev_id, u8 *addr)
 
 	ret = ath12k_wmi_send_peer_delete_cmd(ar, addr, vdev_id);
 	if (ret) {
-		ath12k_warn(ar->ab,
+		ath12k_warn(ab,
 			    "failed to delete peer vdev_id %d addr %pM ret %d\n",
 			    vdev_id, addr, ret);
 		return ret;
 	}
 
+	return 0;
+}
+
+int ath12k_peer_delete(struct ath12k *ar, u32 vdev_id, u8 *addr)
+{
+	int ret;
+
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
+	ret = ath12k_peer_delete_send(ar, vdev_id, addr);
+	if (ret)
+		return ret;
+
 	ret = ath12k_wait_for_peer_delete_done(ar, vdev_id, addr);
 	if (ret)
 		return ret;
@@ -456,3 +470,68 @@ int ath12k_peer_ml_delete(struct ath12k_hw *ah, struct ieee80211_sta *sta)
 
 	return 0;
 }
+
+int ath12k_peer_mlo_link_peers_delete(struct ath12k_vif *ahvif, struct ath12k_sta *ahsta)
+{
+	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(ahsta);
+	struct ath12k_hw *ah = ahvif->ah;
+	struct ath12k_link_vif *arvif;
+	struct ath12k_link_sta *arsta;
+	unsigned long links;
+	struct ath12k *ar;
+	int ret, err_ret = 0;
+	u8 link_id;
+
+	lockdep_assert_wiphy(ah->hw->wiphy);
+
+	if (!sta->mlo)
+		return -EINVAL;
+
+	/* FW expects delete of all link peers at once before waiting for reception
+	 * of peer unmap or delete responses
+	 */
+	links = ahsta->links_map;
+	for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		arvif = wiphy_dereference(ah->hw->wiphy, ahvif->link[link_id]);
+		arsta = wiphy_dereference(ah->hw->wiphy, ahsta->link[link_id]);
+		if (!arvif || !arsta)
+			continue;
+
+		ar = arvif->ar;
+		if (!ar)
+			continue;
+
+		ath12k_dp_peer_cleanup(ar, arvif->vdev_id, arsta->addr);
+
+		ret = ath12k_peer_delete_send(ar, arvif->vdev_id, arsta->addr);
+		if (ret) {
+			ath12k_warn(ar->ab,
+				    "failed to delete peer vdev_id %d addr %pM ret %d\n",
+				    arvif->vdev_id, arsta->addr, ret);
+			err_ret = ret;
+			continue;
+		}
+	}
+
+	/* Ensure all link peers are deleted and unmapped */
+	links = ahsta->links_map;
+	for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		arvif = wiphy_dereference(ah->hw->wiphy, ahvif->link[link_id]);
+		arsta = wiphy_dereference(ah->hw->wiphy, ahsta->link[link_id]);
+		if (!arvif || !arsta)
+			continue;
+
+		ar = arvif->ar;
+		if (!ar)
+			continue;
+
+		ret = ath12k_wait_for_peer_delete_done(ar, arvif->vdev_id, arsta->addr);
+		if (ret) {
+			err_ret = ret;
+			continue;
+		}
+		ar->num_peers--;
+	}
+
+	return err_ret;
+}
diff --git a/drivers/net/wireless/ath/ath12k/peer.h b/drivers/net/wireless/ath/ath12k/peer.h
index c28aca5d88a0..e398d5a3fdc8 100644
--- a/drivers/net/wireless/ath/ath12k/peer.h
+++ b/drivers/net/wireless/ath/ath12k/peer.h
@@ -78,5 +78,6 @@ bool ath12k_peer_exist_by_vdev_id(struct ath12k_base *ab, int vdev_id);
 struct ath12k_peer *ath12k_peer_find_by_ast(struct ath12k_base *ab, int ast_hash);
 int ath12k_peer_ml_create(struct ath12k_hw *ah, struct ieee80211_sta *sta);
 int ath12k_peer_ml_delete(struct ath12k_hw *ah, struct ieee80211_sta *sta);
+int ath12k_peer_mlo_link_peers_delete(struct ath12k_vif *ahvif, struct ath12k_sta *ahsta);
 
 #endif /* _PEER_H_ */
-- 
2.39.5


