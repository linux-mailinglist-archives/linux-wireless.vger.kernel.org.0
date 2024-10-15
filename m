Return-Path: <linux-wireless+bounces-13979-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A6499F3CC
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 19:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A2B1F21A08
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 17:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A79207A2F;
	Tue, 15 Oct 2024 17:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kut/5m0a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E274520721A
	for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2024 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729012472; cv=none; b=bmdkDRQ7dpIki7hqBJAZWJciWBng3Nks+JpZFxuepb2hKSZ2PDMNyURFw4PcxKDnG16S+hWmXvAreMJd+T0bzE0N7BZx5uylF3+YUq4R5I+cMefd50qQTC2MNlb781HFq9x9Vx3YdGsD2aQizH7gpRZhZdoEShwytn1+t2DUqvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729012472; c=relaxed/simple;
	bh=/nDywqXPRck5RYmIA0BRdcUOPPOAwFzHL6B9kXxTjdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aI9KWMcVB1kdqP5ZgBEw2RYrSXw4TP3oYFmDap8TuTvgP/Qm2CKBoSUW1twNPgBZ0lk2Bkgn8o5cjlOhdJ1jZwy1hylhlBuV9PjyELsfVLkKlhXyG9Q7nFbkmBVhCOUwxGPjjlcSivlK5mt1gJKxZn260uUTezfFRCPdp8s0oKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kut/5m0a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38C2C4CECD;
	Tue, 15 Oct 2024 17:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729012471;
	bh=/nDywqXPRck5RYmIA0BRdcUOPPOAwFzHL6B9kXxTjdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kut/5m0amdJ/jsqkSYp5aIR8Ti8nMM/UQhMMWAPJDEu6RBwVFq3lc/3XkhnsY4+jB
	 A1JcovxLyr0j8jU4GP4E7rTjLCgdzkHePIGv7J9jj+w8PlxW57fYtOxUQZOY2Mde5x
	 f5oXUdpAmQw+Q3/5xr0IeWjDVCDlOPtSA5PXsJNZlELIaXMQ2EGHaH5RG177XpFjhs
	 r231xH65vDs+exyVCzHqQb7+x7zlMH0nMLPG0H4C98U8+Th6n0NEjF0jpciREVmJGo
	 VD1o8Dnyvr+vT2NSKqX8AflCASsn8poDWLN8NnFzfkSyG5PqUP3ej0UDmctE01fU2R
	 V5QWQG1KYL6cg==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 11/11] wifi: ath12k: modify link arvif creation and removal for MLO
Date: Tue, 15 Oct 2024 20:14:16 +0300
Message-Id: <20241015171416.518022-12-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015171416.518022-1-kvalo@kernel.org>
References: <20241015171416.518022-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sriram R <quic_srirrama@quicinc.com>

Currently ath12k_mac_op_assign_vif_chanctx() uses ahvif->deflink to create and
start vdev based on incoming channel context. With MLO multiple links could be
associated to the ahvif. Use link id from link_conf passed by mac80211 and do
vdev create start for intended link of ahvif.

Add ath12k_mac_assign_link_vif() helper to allocate and initialize link arvif
object based on input link_id.  The first link arvif that is being created in
an ahvif will use preallocated ahvif->deflink object and the rest gets
allocated.

Currently link arvif can be removed in two call backs namely
ath12k_mac_op_remove_interface() and ath12k_mac_op_unassign_vif_chanctx():

  * ath12k_mac_op_unassign_vif_chanctx() carries link_info so
    obtain link_id from link_info and handle removal for that
    link

  * ath12k_mac_op_remove_interface() is done at interface/MLD
    level hence loop through the active link arvifs and remove
    all of them

Add ath12k_mac_unassign_link_vif() helper to reset/destroy the link arvifs
allocated for an ahvif.

For scan request from mac80211, check if the any of the link arvifs of the
ahvif is already created on the radio in which scan is requested and use it. If
not use deflink(link 0) for creating scan arvif.

Also ath12k creates vdev during assign_vif_chanctx() mac80211 op callback as it
knows channel associated with given link only in this callback.  Whereas
mac80211 updates addition/deletion of links to an ML vif via
.change_vif_links() callback and this is done before channel assignment.  Hence
register an dummy ath12k_mac_op_change_vif_links() function to
change_vif_links() and acknowledge mac80211s link updates.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3


Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Co-developed-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 331 ++++++++++++++++++--------
 1 file changed, 228 insertions(+), 103 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index ba633dad4c47..f5f96a8b1d61 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3103,6 +3103,15 @@ static void ath12k_recalculate_mgmt_rate(struct ath12k *ar,
 		ath12k_warn(ar->ab, "failed to set beacon tx rate %d\n", ret);
 }
 
+static int
+ath12k_mac_op_change_vif_links(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *vif,
+			       u16 old_links, u16 new_links,
+			       struct ieee80211_bss_conf *ol[IEEE80211_MLD_MAX_NUM_LINKS])
+{
+	return 0;
+}
+
 static int ath12k_mac_fils_discovery(struct ath12k_link_vif *arvif,
 				     struct ieee80211_bss_conf *info)
 {
@@ -3581,6 +3590,109 @@ static void ath12k_mac_op_link_info_changed(struct ieee80211_hw *hw,
 	ath12k_mac_bss_info_changed(ar, arvif, info, changed);
 }
 
+static struct ath12k_link_vif *ath12k_mac_assign_link_vif(struct ath12k_hw *ah,
+							  struct ieee80211_vif *vif,
+							  u8 link_id)
+{
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_link_vif *arvif;
+	int i;
+
+	lockdep_assert_wiphy(ah->hw->wiphy);
+
+	arvif = wiphy_dereference(ah->hw->wiphy, ahvif->link[link_id]);
+	if (arvif)
+		return arvif;
+
+	if (!vif->valid_links) {
+		/* Use deflink for Non-ML VIFs and mark the link id as 0
+		 */
+		link_id = 0;
+		arvif = &ahvif->deflink;
+	} else {
+		/* If this is the first link arvif being created for an ML VIF
+		 * use the preallocated deflink memory
+		 */
+		if (!ahvif->links_map) {
+			arvif = &ahvif->deflink;
+		} else {
+			arvif = (struct ath12k_link_vif *)
+			kzalloc(sizeof(struct ath12k_link_vif), GFP_KERNEL);
+			if (!arvif)
+				return NULL;
+		}
+	}
+
+	arvif->ahvif = ahvif;
+	arvif->link_id = link_id;
+	ahvif->links_map |= BIT(link_id);
+
+	INIT_LIST_HEAD(&arvif->list);
+	INIT_DELAYED_WORK(&arvif->connection_loss_work,
+			  ath12k_mac_vif_sta_connection_loss_work);
+
+	for (i = 0; i < ARRAY_SIZE(arvif->bitrate_mask.control); i++) {
+		arvif->bitrate_mask.control[i].legacy = 0xffffffff;
+		memset(arvif->bitrate_mask.control[i].ht_mcs, 0xff,
+		       sizeof(arvif->bitrate_mask.control[i].ht_mcs));
+		memset(arvif->bitrate_mask.control[i].vht_mcs, 0xff,
+		       sizeof(arvif->bitrate_mask.control[i].vht_mcs));
+	}
+
+	/* Allocate Default Queue now and reassign during actual vdev create */
+	vif->cab_queue = ATH12K_HW_DEFAULT_QUEUE;
+	for (i = 0; i < ARRAY_SIZE(vif->hw_queue); i++)
+		vif->hw_queue[i] = ATH12K_HW_DEFAULT_QUEUE;
+
+	vif->driver_flags |= IEEE80211_VIF_SUPPORTS_UAPSD;
+
+	rcu_assign_pointer(ahvif->link[arvif->link_id], arvif);
+	ahvif->links_map |= BIT(link_id);
+	synchronize_rcu();
+	return arvif;
+}
+
+static void ath12k_mac_unassign_link_vif(struct ath12k_link_vif *arvif)
+{
+	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct ath12k_hw *ah = ahvif->ah;
+
+	lockdep_assert_wiphy(ah->hw->wiphy);
+
+	rcu_assign_pointer(ahvif->link[arvif->link_id], NULL);
+	synchronize_rcu();
+	ahvif->links_map &= ~BIT(arvif->link_id);
+
+	if (arvif != &ahvif->deflink)
+		kfree(arvif);
+	else
+		memset(arvif, 0, sizeof(*arvif));
+}
+
+static void ath12k_mac_remove_link_interface(struct ieee80211_hw *hw,
+					     struct ath12k_link_vif *arvif)
+{
+	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct ath12k_hw *ah = hw->priv;
+	struct ath12k *ar = arvif->ar;
+	int ret;
+
+	lockdep_assert_wiphy(ah->hw->wiphy);
+
+	cancel_delayed_work_sync(&arvif->connection_loss_work);
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac remove link interface (vdev %d link id %d)",
+		   arvif->vdev_id, arvif->link_id);
+
+	if (ahvif->vdev_type == WMI_VDEV_TYPE_AP) {
+		ret = ath12k_peer_delete(ar, arvif->vdev_id, arvif->bssid);
+		if (ret)
+			ath12k_warn(ar->ab, "failed to submit AP self-peer removal on vdev %d link id %d: %d",
+				    arvif->vdev_id, arvif->link_id, ret);
+	}
+	ath12k_mac_vdev_delete(ar, arvif);
+}
+
 static struct ath12k*
 ath12k_mac_select_scan_device(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif,
@@ -3781,16 +3893,43 @@ static int ath12k_start_scan(struct ath12k *ar,
 	return 0;
 }
 
+static u8
+ath12k_mac_find_link_id_by_ar(struct ath12k_vif *ahvif, struct ath12k *ar)
+{
+	struct ath12k_link_vif *arvif;
+	struct ath12k_hw *ah = ahvif->ah;
+	unsigned long links = ahvif->links_map;
+	u8 link_id;
+
+	lockdep_assert_wiphy(ah->hw->wiphy);
+
+	for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		arvif = wiphy_dereference(ah->hw->wiphy, ahvif->link[link_id]);
+
+		if (!arvif || !arvif->is_created)
+			continue;
+
+		if (ar == arvif->ar)
+			return link_id;
+	}
+
+	/* input ar is not assigned to any of the links, use link id
+	 * 0 for scan vdev creation.
+	 */
+	return 0;
+}
+
 static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_scan_request *hw_req)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
-	struct ath12k *ar, *prev_ar;
+	struct ath12k *ar;
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_link_vif *arvif;
 	struct cfg80211_scan_request *req = &hw_req->req;
 	struct ath12k_wmi_scan_req_arg *arg = NULL;
+	u8 link_id;
 	int ret;
 	int i;
 	bool create = true;
@@ -3799,12 +3938,6 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 
 	arvif = &ahvif->deflink;
 
-	if (ah->num_radio == 1) {
-		WARN_ON(!arvif->is_created);
-		ar = ath12k_ah_to_ar(ah, 0);
-		goto scan;
-	}
-
 	/* Since the targeted scan device could depend on the frequency
 	 * requested in the hw_req, select the corresponding radio
 	 */
@@ -3812,6 +3945,13 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 	if (!ar)
 		return -EINVAL;
 
+	/* check if any of the links of ML VIF is already started on
+	 * radio(ar) correpsondig to given scan frequency and use it,
+	 * if not use deflink(link 0) for scan purpose.
+	 */
+	link_id = ath12k_mac_find_link_id_by_ar(ahvif, ar);
+	arvif = ath12k_mac_assign_link_vif(ah, vif, link_id);
+
 	/* If the vif is already assigned to a specific vdev of an ar,
 	 * check whether its already started, vdev which is started
 	 * are not allowed to switch to a new radio.
@@ -3829,26 +3969,25 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 			return -EINVAL;
 
 		if (ar != arvif->ar) {
-			/* backup the previously used ar ptr, since the vdev delete
-			 * would assign the arvif->ar to NULL after the call
-			 */
-			prev_ar = arvif->ar;
-			ret = ath12k_mac_vdev_delete(prev_ar, arvif);
-			if (ret)
-				ath12k_warn(prev_ar->ab,
-					    "unable to delete scan vdev %d\n", ret);
+			ath12k_mac_remove_link_interface(hw, arvif);
+			ath12k_mac_unassign_link_vif(arvif);
 		} else {
 			create = false;
 		}
 	}
 	if (create) {
+		/* Previous arvif would've been cleared in radio switch block
+		 * above, assign arvif again for create.
+		 */
+		arvif = ath12k_mac_assign_link_vif(ah, vif, link_id);
+
 		ret = ath12k_mac_vdev_create(ar, arvif);
 		if (ret) {
 			ath12k_warn(ar->ab, "unable to create scan vdev %d\n", ret);
 			return -EINVAL;
 		}
 	}
-scan:
+
 	spin_lock_bh(&ar->data_lock);
 	switch (ar->scan.state) {
 	case ATH12K_SCAN_IDLE:
@@ -6714,6 +6853,7 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
 	struct ath12k_wmi_vdev_create_arg vdev_arg = {0};
 	struct ath12k_wmi_peer_create_arg peer_param;
+	struct ieee80211_bss_conf *link_conf;
 	u32 param_id, param_value;
 	u16 nss;
 	int i;
@@ -6721,6 +6861,15 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 
 	lockdep_assert_wiphy(hw->wiphy);
 
+	link_conf = wiphy_dereference(hw->wiphy, vif->link_conf[arvif->link_id]);
+	if (!link_conf) {
+		ath12k_warn(ar->ab, "unable to access bss link conf in vdev create for vif %pM link %u\n",
+			    vif->addr, arvif->link_id);
+		return -ENOLINK;
+	}
+
+	memcpy(arvif->bssid, link_conf->addr, ETH_ALEN);
+
 	arvif->ar = ar;
 	vdev_id = __ffs64(ab->free_vdev_map);
 	arvif->vdev_id = vdev_id;
@@ -6773,7 +6922,7 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 		goto err;
 	}
 
-	ret = ath12k_wmi_vdev_create(ar, vif->addr, &vdev_arg);
+	ret = ath12k_wmi_vdev_create(ar, arvif->bssid, &vdev_arg);
 	if (ret) {
 		ath12k_warn(ab, "failed to create WMI vdev %d: %d\n",
 			    arvif->vdev_id, ret);
@@ -6805,7 +6954,7 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 	switch (ahvif->vdev_type) {
 	case WMI_VDEV_TYPE_AP:
 		peer_param.vdev_id = arvif->vdev_id;
-		peer_param.peer_addr = vif->addr;
+		peer_param.peer_addr = arvif->bssid;
 		peer_param.peer_type = WMI_PEER_TYPE_DEFAULT;
 		ret = ath12k_peer_create(ar, arvif, NULL, &peer_param);
 		if (ret) {
@@ -6881,31 +7030,24 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 	if (vif->type != NL80211_IFTYPE_MONITOR && ar->monitor_conf_enabled)
 		ath12k_mac_monitor_vdev_create(ar);
 
-	arvif->ar = ar;
-	/* TODO use appropriate link id once MLO support is added.
-	 */
-	arvif->link_id = ATH12K_DEFAULT_LINK_ID;
-	rcu_assign_pointer(ahvif->link[arvif->link_id], arvif);
-	ahvif->links_map = BIT(arvif->link_id);
-	synchronize_rcu();
-
 	return ret;
 
 err_peer_del:
 	if (ahvif->vdev_type == WMI_VDEV_TYPE_AP) {
 		reinit_completion(&ar->peer_delete_done);
 
-		ret = ath12k_wmi_send_peer_delete_cmd(ar, vif->addr,
+		ret = ath12k_wmi_send_peer_delete_cmd(ar, arvif->bssid,
 						      arvif->vdev_id);
 		if (ret) {
 			ath12k_warn(ar->ab, "failed to delete peer vdev_id %d addr %pM\n",
-				    arvif->vdev_id, vif->addr);
-			return ret;
+				    arvif->vdev_id, arvif->bssid);
+			goto err;
 		}
 
 		ret = ath12k_wait_for_peer_delete_done(ar, arvif->vdev_id,
-						       vif->addr);
+						       arvif->bssid);
 		if (ret)
+			/* KVALO: why not goto err? */
 			return ret;
 
 		ar->num_peers--;
@@ -7002,8 +7144,9 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 {
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
 	struct ath12k_hw *ah = hw->priv;
-	struct ath12k *ar, *prev_ar;
+	struct ath12k *ar;
 	struct ath12k_base *ab;
+	u8 link_id = arvif->link_id;
 	int ret;
 
 	lockdep_assert_wiphy(hw->wiphy);
@@ -7036,14 +7179,8 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 			if (WARN_ON(arvif->is_started))
 				return NULL;
 
-			/* backup the previously used ar ptr since arvif->ar would
-			 * be set to NULL after vdev delete is done
-			 */
-			prev_ar = arvif->ar;
-			ret = ath12k_mac_vdev_delete(prev_ar, arvif);
-			if (ret)
-				ath12k_warn(prev_ar->ab, "unable to delete vdev %d\n",
-					    ret);
+			ath12k_mac_remove_link_interface(hw, arvif);
+			ath12k_mac_unassign_link_vif(arvif);
 		}
 	}
 
@@ -7052,6 +7189,10 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 	if (arvif->is_created)
 		goto flush;
 
+	/* Assign arvif again here since previous radio switch block
+	 * would've unassigned and cleared it.
+	 */
+	arvif = ath12k_mac_assign_link_vif(ah, vif, link_id);
 	if (vif->type == NL80211_IFTYPE_AP &&
 	    ar->num_peers > (ar->max_num_peers - 1)) {
 		ath12k_warn(ab, "failed to create vdev due to insufficient peer entry resource in firmware\n");
@@ -7115,11 +7256,11 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 		vif->hw_queue[i] = ATH12K_HW_DEFAULT_QUEUE;
 
 	vif->driver_flags |= IEEE80211_VIF_SUPPORTS_UAPSD;
-
-	/* For single radio wiphy(i.e ah->num_radio is 1), create the vdev
-	 * during add_interface itself, for multi radio wiphy, defer the vdev
-	 * creation until channel_assign to determine the radio on which the
-	 * vdev needs to be created
+	/* For non-ml vifs, vif->addr is the actual vdev address but for
+	 * ML vif link(link BSSID) address is the vdev address and it can be a
+	 * different one from vif->addr (i.e ML address).
+	 * Defer vdev creation until assign_chanctx or hw_scan is initiated as driver
+	 * will not know if this interface is an ML vif at this point.
 	 */
 	ath12k_mac_assign_vif_to_vdev(hw, arvif, NULL);
 
@@ -7211,12 +7352,6 @@ static int ath12k_mac_vdev_delete(struct ath12k *ar, struct ath12k_link_vif *arv
 	/* TODO: recal traffic pause state based on the available vdevs */
 	arvif->is_created = false;
 	arvif->ar = NULL;
-	if (arvif->link_id < IEEE80211_MLD_MAX_NUM_LINKS) {
-		rcu_assign_pointer(ahvif->link[arvif->link_id], NULL);
-		synchronize_rcu();
-		ahvif->links_map &= ~(BIT(arvif->link_id));
-		arvif->link_id = ATH12K_INVALID_LINK_ID;
-	}
 
 	return ret;
 }
@@ -7226,39 +7361,22 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 {
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_link_vif *arvif;
-	struct ath12k_base *ab;
-	struct ath12k *ar;
-	int ret;
+	u8 link_id;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	arvif = &ahvif->deflink;
-
-	if (!arvif->is_created) {
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
 		/* if we cached some config but never received assign chanctx,
 		 * free the allocated cache.
 		 */
-		ath12k_ahvif_put_link_cache(ahvif, ATH12K_DEFAULT_LINK_ID);
+		ath12k_ahvif_put_link_cache(ahvif, link_id);
+		arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
+		if (!arvif || !arvif->is_created)
+			continue;
 
-		return;
+		ath12k_mac_remove_link_interface(hw, arvif);
+		ath12k_mac_unassign_link_vif(arvif);
 	}
-
-	ar = arvif->ar;
-	ab = ar->ab;
-
-	cancel_delayed_work_sync(&arvif->connection_loss_work);
-
-	ath12k_dbg(ab, ATH12K_DBG_MAC, "mac remove interface (vdev %d)\n",
-		   arvif->vdev_id);
-
-	if (ahvif->vdev_type == WMI_VDEV_TYPE_AP) {
-		ret = ath12k_peer_delete(ar, arvif->vdev_id, vif->addr);
-		if (ret)
-			ath12k_warn(ab, "failed to submit AP self-peer removal on vdev %d: %d\n",
-				    arvif->vdev_id, ret);
-	}
-
-	ath12k_mac_vdev_delete(ar, arvif);
 }
 
 /* FIXME: Has to be verified. */
@@ -7975,9 +8093,11 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 				 struct ieee80211_bss_conf *link_conf,
 				 struct ieee80211_chanctx_conf *ctx)
 {
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
 	struct ath12k_base *ab;
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	u8 link_id = link_conf->link_id;
 	struct ath12k_link_vif *arvif;
 	int ret;
 
@@ -7986,12 +8106,20 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 	/* For multi radio wiphy, the vdev was not created during add_interface
 	 * create now since we have a channel ctx now to assign to a specific ar/fw
 	 */
-	arvif = &ahvif->deflink;
+	arvif = ath12k_mac_assign_link_vif(ah, vif, link_id);
+	if (!arvif) {
+		WARN_ON(1);
+		return -ENOMEM;
+	}
 
-	ar = ath12k_mac_assign_vif_to_vdev(hw, arvif, ctx);
-	if (WARN_ON(!ar)) {
-		ret = -EINVAL;
-		goto out;
+	if (!arvif->is_started) {
+		ar = ath12k_mac_assign_vif_to_vdev(hw, arvif, ctx);
+		if (!ar)
+			return -EINVAL;
+	} else {
+		ath12k_warn(arvif->ar->ab, "failed to assign chanctx for vif %pM link id %u link vif is already started",
+			    vif->addr, link_id);
+		return -EINVAL;
 	}
 
 	ab = ar->ab;
@@ -8055,11 +8183,12 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	struct ath12k_base *ab;
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_link_vif *arvif;
+	u8 link_id = link_conf->link_id;
 	int ret;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	arvif = &ahvif->deflink;
+	arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
 
 	/* The vif is expected to be attached to an ar's VDEV.
 	 * We leave the vif/vdev in this function as is
@@ -8068,7 +8197,7 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	 * remove_interface() or when there is a change in channel
 	 * that moves the vif to a new ar
 	 */
-	if (!arvif->is_created)
+	if (!arvif || !arvif->is_created)
 		return;
 
 	ar = arvif->ar;
@@ -8101,6 +8230,9 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	if (ahvif->vdev_type != WMI_VDEV_TYPE_MONITOR &&
 	    ar->num_started_vdevs == 1 && ar->monitor_vdev_created)
 		ath12k_mac_monitor_stop(ar);
+
+	ath12k_mac_remove_link_interface(hw, arvif);
+	ath12k_mac_unassign_link_vif(arvif);
 }
 
 static int
@@ -8845,27 +8977,27 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k_wmi_scan_req_arg arg;
 	struct ath12k_link_vif *arvif;
-	struct ath12k *ar, *prev_ar;
+	struct ath12k *ar;
 	u32 scan_time_msec;
 	bool create = true;
+	u8 link_id;
 	int ret;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	arvif = &ahvif->deflink;
-
-	if (ah->num_radio == 1) {
-		WARN_ON(!arvif->is_created);
-		ar = ath12k_ah_to_ar(ah, 0);
-		goto scan;
-	}
-
 	ar = ath12k_mac_select_scan_device(hw, vif, chan->center_freq);
 	if (!ar) {
 		ret = -EINVAL;
 		goto exit;
 	}
 
+	/* check if any of the links of ML VIF is already started on
+	 * radio(ar) correpsondig to given scan frequency and use it,
+	 * if not use deflink(link 0) for scan purpose.
+	 */
+
+	link_id = ath12k_mac_find_link_id_by_ar(ahvif, ar);
+	arvif = ath12k_mac_assign_link_vif(ah, vif, link_id);
 	/* If the vif is already assigned to a specific vdev of an ar,
 	 * check whether its already started, vdev which is started
 	 * are not allowed to switch to a new radio.
@@ -8887,23 +9019,16 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 		}
 
 		if (ar != arvif->ar) {
-			/* backup the previously used ar ptr, since the vdev delete
-			 * would assign the arvif->ar to NULL after the call
-			 */
-			prev_ar = arvif->ar;
-			ret = ath12k_mac_vdev_delete(prev_ar, arvif);
-			if (ret) {
-				ath12k_warn(prev_ar->ab,
-					    "unable to delete scan vdev for roc: %d\n",
-					    ret);
-				goto exit;
-			}
+			ath12k_mac_remove_link_interface(hw, arvif);
+			ath12k_mac_unassign_link_vif(arvif);
 		} else {
 			create = false;
 		}
 	}
 
 	if (create) {
+		arvif = ath12k_mac_assign_link_vif(ah, vif, link_id);
+
 		ret = ath12k_mac_vdev_create(ar, arvif);
 		if (ret) {
 			ath12k_warn(ar->ab, "unable to create scan vdev for roc: %d\n",
@@ -8912,7 +9037,6 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 		}
 	}
 
-scan:
 	spin_lock_bh(&ar->data_lock);
 
 	switch (ar->scan.state) {
@@ -9040,6 +9164,7 @@ static const struct ieee80211_ops ath12k_ops = {
 	.config                         = ath12k_mac_op_config,
 	.link_info_changed              = ath12k_mac_op_link_info_changed,
 	.vif_cfg_changed		= ath12k_mac_op_vif_cfg_changed,
+	.change_vif_links               = ath12k_mac_op_change_vif_links,
 	.configure_filter		= ath12k_mac_op_configure_filter,
 	.hw_scan                        = ath12k_mac_op_hw_scan,
 	.cancel_hw_scan                 = ath12k_mac_op_cancel_hw_scan,
-- 
2.39.5


