Return-Path: <linux-wireless+bounces-14822-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1879B942B
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 16:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC2D1C20F1F
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 15:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DDA1C7B6F;
	Fri,  1 Nov 2024 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEMG3nRw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610C71C7610
	for <linux-wireless@vger.kernel.org>; Fri,  1 Nov 2024 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730474233; cv=none; b=jqMNI+U7M2dj5XgLJ2IWIb4+WAyRIT7KzNBeiAUdPFk20LOU1zHfIYWQiyNHHb1Kf5bb1rDVL9C/kY19ShX1W0S5o1GFoBih9/hF059LEy8pdgJEVpSCiCSRJwa6/Dna0KyEXpgBXeH2bu74locWJLJT6TsrHFEmGj5LELjJFFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730474233; c=relaxed/simple;
	bh=U/I2toJsAW+b+idh0EjDN+aZmZ1KHED8feZQja3b3r8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZQYmLSQNTTCjfFVVTtwH7zwjfK/M4gmFPve3LVhkRh3cs1DM27IoLhZoUuVoFy6/UsjJ//HfnV4Oq4EOjTx/oCKK0octYzjI6e/bkUTf/ya1lvvHHc7Nw44okF09tE7/1QA7ylEI/vqIN68VN02396Og4thIVZEuX/AfeAPDlRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEMG3nRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59110C4CECD;
	Fri,  1 Nov 2024 15:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730474232;
	bh=U/I2toJsAW+b+idh0EjDN+aZmZ1KHED8feZQja3b3r8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DEMG3nRwu4LwnJdxxiPjYmII/FBc0j/cf9TAGB+mNXqlgp1XBsDfoyxJOU38rUYFx
	 qoKMJiFAFjkqjwKVMv2b9LlprJgz0cEMlzKQxpxfl7f4PDrofS1g5N5oau820AOjXc
	 orV8UROsm9Z3R3Bnpar/FncuPs9a47OGe20Piw5rQUJg8/MWjuo8ARJEQBxzQ/zIi5
	 ZptTJ/kC80bGPvHMU+a74s4y+9ItGiQGjx1rvINDK4UtiarsfhrAv0HXekyOqAMp9h
	 Y8qX01GNK3cOv/NrhVV2pjfQDRkM0i2CwpRc3U3lv0qTPEcRSwLAywDSyBUvBQehNK
	 2O+VuRvCnvXAw==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 5/8] wifi: ath12k: Add helpers for multi link peer creation and deletion
Date: Fri,  1 Nov 2024 17:17:02 +0200
Message-Id: <20241101151705.165987-6-kvalo@kernel.org>
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

Add helper functions for multi link peer addition and deletion. And add address
validation to ensure we are not creating link peers (belonging to different
clients) with same MLD address. To aid in this validation for faster lookup,
add a new list of ML peers to struct ath12k_hw::ml_peers and use the same for
parsing for the above address validation use cases.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h | 13 ++++
 drivers/net/wireless/ath/ath12k/mac.c  |  2 +
 drivers/net/wireless/ath/ath12k/peer.c | 98 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/peer.h |  8 +++
 4 files changed, 121 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 9c4e5fae8930..0a0c1a1594f2 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -63,6 +63,13 @@
 #define ATH12K_RECONFIGURE_TIMEOUT_HZ		(10 * HZ)
 #define ATH12K_RECOVER_START_TIMEOUT_HZ		(20 * HZ)
 
+#define ATH12K_MAX_SOCS 3
+#define ATH12K_INVALID_GROUP_ID  0xFF
+#define ATH12K_INVALID_DEVICE_ID 0xFF
+
+#define ATH12K_MAX_MLO_PEERS            256
+#define ATH12K_MLO_PEER_ID_INVALID      0xFFFF
+
 enum ath12k_bdf_search {
 	ATH12K_BDF_SEARCH_DEFAULT,
 	ATH12K_BDF_SEARCH_BUS_AND_BOARD,
@@ -488,6 +495,7 @@ struct ath12k_sta {
 	struct ath12k_link_sta __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
 	/* indicates bitmap of link sta created in FW */
 	u16 links_map;
+	u16 ml_peer_id;
 };
 
 #define ATH12K_MIN_5G_FREQ 4150
@@ -696,6 +704,11 @@ struct ath12k_hw {
 
 	u8 num_radio;
 
+	DECLARE_BITMAP(free_ml_peer_id_map, ATH12K_MAX_MLO_PEERS);
+
+	/* protected by wiphy_lock() */
+	struct list_head ml_peers;
+
 	/* Keep last */
 	struct ath12k radio[] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 9552a9495276..2f1edce0287a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5105,6 +5105,7 @@ static int ath12k_mac_handle_link_sta_state(struct ieee80211_hw *hw,
 		ahsta->links_map = BIT(arsta->link_id);
 		arsta->ahsta = ahsta;
 		arsta->arvif = arvif;
+		ether_addr_copy(arsta->addr, sta->addr);
 		wiphy_work_init(&arsta->update_wk, ath12k_sta_rc_update_wk);
 
 		synchronize_rcu();
@@ -10123,6 +10124,7 @@ static struct ath12k_hw *ath12k_mac_hw_allocate(struct ath12k_base *ab,
 	ah->num_radio = num_pdev_map;
 
 	mutex_init(&ah->hw_mutex);
+	INIT_LIST_HEAD(&ah->ml_peers);
 
 	for (i = 0; i < num_pdev_map; i++) {
 		ab = pdev_map[i].ab;
diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index 7a62665b8af9..2ad19baf0664 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -8,6 +8,22 @@
 #include "peer.h"
 #include "debug.h"
 
+static struct ath12k_ml_peer *ath12k_peer_ml_find(struct ath12k_hw *ah, const u8 *addr)
+{
+	struct ath12k_ml_peer *ml_peer;
+
+	lockdep_assert_wiphy(ah->hw->wiphy);
+
+	list_for_each_entry(ml_peer, &ah->ml_peers, list) {
+		if (!ether_addr_equal(ml_peer->addr, addr))
+			continue;
+
+		return ml_peer;
+	}
+
+	return NULL;
+}
+
 struct ath12k_peer *ath12k_peer_find(struct ath12k_base *ab, int vdev_id,
 				     const u8 *addr)
 {
@@ -341,3 +357,85 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 
 	return 0;
 }
+
+static u16 ath12k_peer_ml_alloc(struct ath12k_hw *ah)
+{
+	u16 ml_peer_id;
+
+	lockdep_assert_wiphy(ah->hw->wiphy);
+
+	for (ml_peer_id = 0; ml_peer_id < ATH12K_MAX_MLO_PEERS; ml_peer_id++) {
+		if (test_bit(ml_peer_id, ah->free_ml_peer_id_map))
+			continue;
+
+		set_bit(ml_peer_id, ah->free_ml_peer_id_map);
+		break;
+	}
+
+	if (ml_peer_id == ATH12K_MAX_MLO_PEERS)
+		ml_peer_id = ATH12K_MLO_PEER_ID_INVALID;
+
+	return ml_peer_id;
+}
+
+int ath12k_peer_ml_create(struct ath12k_hw *ah, struct ieee80211_sta *sta)
+{
+	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
+	struct ath12k_ml_peer *ml_peer;
+
+	lockdep_assert_wiphy(ah->hw->wiphy);
+
+	if (!sta->mlo)
+		return -EINVAL;
+
+	ml_peer = ath12k_peer_ml_find(ah, sta->addr);
+	if (ml_peer) {
+		ath12k_hw_warn(ah, "ML peer %d exists already, unable to add new entry for %pM",
+			       ml_peer->id, sta->addr);
+		return -EEXIST;
+	}
+
+	ml_peer = kzalloc(sizeof(*ml_peer), GFP_ATOMIC);
+	if (!ml_peer)
+		return -ENOMEM;
+
+	ahsta->ml_peer_id = ath12k_peer_ml_alloc(ah);
+
+	if (ahsta->ml_peer_id == ATH12K_MLO_PEER_ID_INVALID) {
+		ath12k_hw_warn(ah, "unable to allocate ML peer id for sta %pM",
+			       sta->addr);
+		kfree(ml_peer);
+		return -ENOMEM;
+	}
+
+	ether_addr_copy(ml_peer->addr, sta->addr);
+	ml_peer->id = ahsta->ml_peer_id;
+	list_add(&ml_peer->list, &ah->ml_peers);
+
+	return 0;
+}
+
+int ath12k_peer_ml_delete(struct ath12k_hw *ah, struct ieee80211_sta *sta)
+{
+	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
+	struct ath12k_ml_peer *ml_peer;
+
+	lockdep_assert_wiphy(ah->hw->wiphy);
+
+	if (!sta->mlo)
+		return -EINVAL;
+
+	clear_bit(ahsta->ml_peer_id, ah->free_ml_peer_id_map);
+	ahsta->ml_peer_id = ATH12K_MLO_PEER_ID_INVALID;
+
+	ml_peer = ath12k_peer_ml_find(ah, sta->addr);
+	if (!ml_peer) {
+		ath12k_hw_warn(ah, "ML peer for %pM not found", sta->addr);
+		return -EINVAL;
+	}
+
+	list_del(&ml_peer->list);
+	kfree(ml_peer);
+
+	return 0;
+}
diff --git a/drivers/net/wireless/ath/ath12k/peer.h b/drivers/net/wireless/ath/ath12k/peer.h
index b955f0cdf598..085246ca938d 100644
--- a/drivers/net/wireless/ath/ath12k/peer.h
+++ b/drivers/net/wireless/ath/ath12k/peer.h
@@ -49,6 +49,12 @@ struct ath12k_peer {
 	bool dp_setup_done;
 };
 
+struct ath12k_ml_peer {
+	struct list_head list;
+	u8 addr[ETH_ALEN];
+	u16 id;
+};
+
 void ath12k_peer_unmap_event(struct ath12k_base *ab, u16 peer_id);
 void ath12k_peer_map_event(struct ath12k_base *ab, u8 vdev_id, u16 peer_id,
 			   u8 *mac_addr, u16 ast_hash, u16 hw_peer_id);
@@ -66,5 +72,7 @@ int ath12k_wait_for_peer_delete_done(struct ath12k *ar, u32 vdev_id,
 				     const u8 *addr);
 bool ath12k_peer_exist_by_vdev_id(struct ath12k_base *ab, int vdev_id);
 struct ath12k_peer *ath12k_peer_find_by_ast(struct ath12k_base *ab, int ast_hash);
+int ath12k_peer_ml_create(struct ath12k_hw *ah, struct ieee80211_sta *sta);
+int ath12k_peer_ml_delete(struct ath12k_hw *ah, struct ieee80211_sta *sta);
 
 #endif /* _PEER_H_ */
-- 
2.39.5


