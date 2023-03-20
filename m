Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C5B6C0F0B
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 11:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjCTKge (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 06:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjCTKgJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 06:36:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE5316326
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 03:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679308528; x=1710844528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FDEK7Vb+Ef5EgliwhKZIzFXcLLR7WxodTlVmW7q5kpI=;
  b=iUpf0Ah2UqJYqXDkyq5+TPZbMkfQuHfnoDhlWR9RaIIOoSpqgSxkai1c
   ZNK2uGTheUgId+XYd4U1WcZk1NFXJPUlSOsZbbLZOuRU55u3wp2yNMepw
   wkRoezC2A4ER1QmDG3T+fIm+18Pw6uSkvpsY7O8QPSnrN2c9FXWDyhjbO
   w3Najowok5+yT3Ejepg32OrxAZea4tDlu5QRgI5dxKFVhprGP7EnasUgb
   LwvjhLGQi7XLDsBmd1hs0WMyJK7RMDtEEOZWUB2zGvYiF1fhClPYDLuoR
   CZLc5B/Jalx4GFwkYX1BeRp37ljJWU7GW+7rTDQp39/j1syusFLMlArrF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="326997952"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="326997952"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:34:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="713523698"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="713523698"
Received: from ranikhou-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.179.26])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:34:08 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 15/18] wifi: iwlwifi: mvm: refactor iwl_mvm_add_sta(), iwl_mvm_rm_sta()
Date:   Mon, 20 Mar 2023 12:33:16 +0200
Message-Id: <20230320122330.d01e0c9ccdc3.I5e9e27c3b363b36209a0ff960d2e59708e7ff0bf@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230320103319.1309442-1-gregory.greenman@intel.com>
References: <20230320103319.1309442-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

As we have a new MLD STA cmd, there will be a different function to
add/remove a station in MLD mode. But both functions will share a
common part. Put this part in a separate function which will be used
later in adding/removing a sta in MLD mode.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 182 +++++++++++--------
 1 file changed, 106 insertions(+), 76 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index c22ba1ea42f6..7d9d4e85b548 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1648,52 +1648,17 @@ static int iwl_mvm_add_int_sta_common(struct iwl_mvm *mvm,
 	return ret;
 }
 
-int iwl_mvm_add_sta(struct iwl_mvm *mvm,
-		    struct ieee80211_vif *vif,
-		    struct ieee80211_sta *sta)
+/* Initialize driver data of a new sta */
+static int iwl_mvm_sta_init(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta, int sta_id, u8 sta_type)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
 	struct iwl_mvm_rxq_dup_data *dup_data;
-	int i, ret, sta_id;
-	bool sta_update = false;
-	unsigned int sta_flags = 0;
+	int i, ret = 0;
 
 	lockdep_assert_held(&mvm->mutex);
 
-	if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
-		sta_id = iwl_mvm_find_free_sta_id(mvm,
-						  ieee80211_vif_type_p2p(vif));
-	else
-		sta_id = mvm_sta->sta_id;
-
-	if (sta_id == IWL_MVM_INVALID_STA)
-		return -ENOSPC;
-
-	spin_lock_init(&mvm_sta->lock);
-
-	/* if this is a HW restart re-alloc existing queues */
-	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
-		struct iwl_mvm_int_sta tmp_sta = {
-			.sta_id = sta_id,
-			.type = mvm_sta->sta_type,
-		};
-
-		/*
-		 * First add an empty station since allocating
-		 * a queue requires a valid station
-		 */
-		ret = iwl_mvm_add_int_sta_common(mvm, &tmp_sta, sta->addr,
-						 mvmvif->id, mvmvif->color);
-		if (ret)
-			goto err;
-
-		iwl_mvm_realloc_queues_after_restart(mvm, sta);
-		sta_update = true;
-		sta_flags = iwl_mvm_has_new_tx_api(mvm) ? 0 : STA_MODIFY_QUEUES;
-		goto update_fw;
-	}
-
 	mvm_sta->sta_id = sta_id;
 	mvm_sta->mac_id_n_color = FW_CMD_ID_AND_COLOR(mvmvif->id,
 						      mvmvif->color);
@@ -1703,7 +1668,7 @@ int iwl_mvm_add_sta(struct iwl_mvm *mvm,
 	else
 		mvm_sta->max_agg_bufsize = LINK_QUAL_AGG_FRAME_LIMIT_GEN2_DEF;
 	mvm_sta->tt_tx_protection = false;
-	mvm_sta->sta_type = sta->tdls ? IWL_STA_TDLS_LINK : IWL_STA_LINK;
+	mvm_sta->sta_type = sta_type;
 
 	mvm_sta->tid_disable_agg = 0xffff; /* No aggs at first */
 
@@ -1724,8 +1689,7 @@ int iwl_mvm_add_sta(struct iwl_mvm *mvm,
 		atomic_set(&mvmtxq->tx_request, 0);
 	}
 
-	if (iwl_mvm_has_new_rx_api(mvm) &&
-	    !test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
+	if (iwl_mvm_has_new_rx_api(mvm)) {
 		int q;
 
 		dup_data = kcalloc(mvm->trans->num_rx_queues,
@@ -1751,7 +1715,7 @@ int iwl_mvm_add_sta(struct iwl_mvm *mvm,
 		ret = iwl_mvm_reserve_sta_stream(mvm, sta,
 						 ieee80211_vif_type_p2p(vif));
 		if (ret)
-			goto err;
+			return ret;
 	}
 
 	/*
@@ -1765,6 +1729,56 @@ int iwl_mvm_add_sta(struct iwl_mvm *mvm,
 
 	iwl_mvm_toggle_tx_ant(mvm, &mvm_sta->tx_ant);
 
+	return 0;
+}
+
+int iwl_mvm_add_sta(struct iwl_mvm *mvm,
+		    struct ieee80211_vif *vif,
+		    struct ieee80211_sta *sta)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
+	int ret, sta_id;
+	bool sta_update = false;
+	unsigned int sta_flags = 0;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
+		sta_id = iwl_mvm_find_free_sta_id(mvm,
+						  ieee80211_vif_type_p2p(vif));
+	else
+		sta_id = mvm_sta->sta_id;
+
+	if (sta_id == IWL_MVM_INVALID_STA)
+		return -ENOSPC;
+
+	spin_lock_init(&mvm_sta->lock);
+
+	/* if this is a HW restart re-alloc existing queues */
+	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
+		struct iwl_mvm_int_sta tmp_sta = {
+			.sta_id = sta_id,
+			.type = mvm_sta->sta_type,
+		};
+
+		/* First add an empty station since allocating
+		 * a queue requires a valid station
+		 */
+		ret = iwl_mvm_add_int_sta_common(mvm, &tmp_sta, sta->addr,
+						 mvmvif->id, mvmvif->color);
+		if (ret)
+			goto err;
+
+		iwl_mvm_realloc_queues_after_restart(mvm, sta);
+		sta_update = true;
+		sta_flags = iwl_mvm_has_new_tx_api(mvm) ? 0 : STA_MODIFY_QUEUES;
+		goto update_fw;
+	}
+
+	ret = iwl_mvm_sta_init(mvm, vif, sta, sta_id,
+			       sta->tdls ? IWL_STA_TDLS_LINK : IWL_STA_LINK);
+
 update_fw:
 	ret = iwl_mvm_sta_send_to_fw(mvm, sta, sta_update, sta_flags);
 	if (ret)
@@ -1912,43 +1926,16 @@ int iwl_mvm_wait_sta_queues_empty(struct iwl_mvm *mvm,
 	return 0;
 }
 
-int iwl_mvm_rm_sta(struct iwl_mvm *mvm,
-		   struct ieee80211_vif *vif,
-		   struct ieee80211_sta *sta)
+/* Execute the common part for both MLD and non-MLD modes */
+static bool iwl_mvm_sta_del(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta, int *ret)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
 	u8 sta_id = mvm_sta->sta_id;
-	int ret;
 
 	lockdep_assert_held(&mvm->mutex);
 
-	if (iwl_mvm_has_new_rx_api(mvm))
-		kfree(mvm_sta->dup_data);
-
-	ret = iwl_mvm_drain_sta(mvm, mvm_sta, true);
-	if (ret)
-		return ret;
-
-	/* flush its queues here since we are freeing mvm_sta */
-	ret = iwl_mvm_flush_sta(mvm, mvm_sta, false);
-	if (ret)
-		return ret;
-	if (iwl_mvm_has_new_tx_api(mvm)) {
-		ret = iwl_mvm_wait_sta_queues_empty(mvm, mvm_sta);
-	} else {
-		u32 q_mask = mvm_sta->tfd_queue_msk;
-
-		ret = iwl_trans_wait_tx_queues_empty(mvm->trans,
-						     q_mask);
-	}
-	if (ret)
-		return ret;
-
-	ret = iwl_mvm_drain_sta(mvm, mvm_sta, false);
-
-	iwl_mvm_disable_sta_queues(mvm, vif, sta);
-
 	/* If there is a TXQ still marked as reserved - free it */
 	if (mvm_sta->reserved_queue != IEEE80211_INVAL_HW_QUEUE) {
 		u8 reserved_txq = mvm_sta->reserved_queue;
@@ -1963,8 +1950,10 @@ int iwl_mvm_rm_sta(struct iwl_mvm *mvm,
 		if (WARN((*status != IWL_MVM_QUEUE_RESERVED) &&
 			 (*status != IWL_MVM_QUEUE_FREE),
 			 "sta_id %d reserved txq %d status %d",
-			 sta_id, reserved_txq, *status))
-			return -EINVAL;
+			 sta_id, reserved_txq, *status)) {
+			*ret = -EINVAL;
+			return true;
+		}
 
 		*status = IWL_MVM_QUEUE_FREE;
 	}
@@ -1973,7 +1962,7 @@ int iwl_mvm_rm_sta(struct iwl_mvm *mvm,
 	    mvmvif->ap_sta_id == sta_id) {
 		/* if associated - we can't remove the AP STA now */
 		if (vif->cfg.assoc)
-			return ret;
+			return true;
 
 		/* first remove remaining keys */
 		iwl_mvm_sec_key_remove_ap(mvm, vif);
@@ -2000,6 +1989,47 @@ int iwl_mvm_rm_sta(struct iwl_mvm *mvm,
 
 	iwl_mvm_time_sync_sta_rm(mvm, sta);
 
+	return false;
+}
+
+int iwl_mvm_rm_sta(struct iwl_mvm *mvm,
+		   struct ieee80211_vif *vif,
+		   struct ieee80211_sta *sta)
+{
+	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
+	int ret;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	if (iwl_mvm_has_new_rx_api(mvm))
+		kfree(mvm_sta->dup_data);
+
+	ret = iwl_mvm_drain_sta(mvm, mvm_sta, true);
+	if (ret)
+		return ret;
+
+	/* flush its queues here since we are freeing mvm_sta */
+	ret = iwl_mvm_flush_sta(mvm, mvm_sta, false);
+	if (ret)
+		return ret;
+	if (iwl_mvm_has_new_tx_api(mvm)) {
+		ret = iwl_mvm_wait_sta_queues_empty(mvm, mvm_sta);
+	} else {
+		u32 q_mask = mvm_sta->tfd_queue_msk;
+
+		ret = iwl_trans_wait_tx_queues_empty(mvm->trans,
+						     q_mask);
+	}
+	if (ret)
+		return ret;
+
+	ret = iwl_mvm_drain_sta(mvm, mvm_sta, false);
+
+	iwl_mvm_disable_sta_queues(mvm, vif, sta);
+
+	if (iwl_mvm_sta_del(mvm, vif, sta, &ret))
+		return ret;
+
 	ret = iwl_mvm_rm_sta_common(mvm, mvm_sta->sta_id);
 	RCU_INIT_POINTER(mvm->fw_id_to_mac_id[mvm_sta->sta_id], NULL);
 
-- 
2.38.1

