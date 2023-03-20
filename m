Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC6A6C0EFD
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 11:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjCTKfe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 06:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjCTKe4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 06:34:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D41B18142
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 03:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679308456; x=1710844456;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nJ67BMfUu2VjAudsmLufJ37tGxnW8CdZgGyR9gCwCRE=;
  b=aFfLdBdJDlPC9eMGxT0/L0+C8jozHLBX4js2yGECeja0AxV2HTxWEBJw
   9epzToFFgTpPkSHyeT7oH2SsjPfqO2uz12xknttKZU/okY5aMSgnrk156
   NHJ6/GSTZ1u8OwG6Llliru3wGkz3d/PEyBYx1CC6QUcZZODF6uRu0YVBo
   VFd6ntC1I7/FCwSlMM9UlgNd15ClYl+xxYDKPh214tzlhSlZEacdIlGjN
   a5aSDopxyEjsJnMJHWShMRCGkPNferh13JFDDPgUlz4usiaz/+6+Lyq7n
   i5YI+qBFrQCRa15AXrkC2gymW2jIKDhfKkX0CFjM7nqbFbt2hFdaSlNHG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="326997907"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="326997907"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:33:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="713523670"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="713523670"
Received: from ranikhou-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.179.26])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:33:50 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/18] wifi: iwlwifi: mvm: add start_ap() and join_ibss() callbacks for MLD mode
Date:   Mon, 20 Mar 2023 12:33:09 +0200
Message-Id: <20230320122330.3eb485c359fc.I28be198ea9389083d5a01f68c92763722613ba9b@changeid>
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

This is another patch in the series adding all the ops
for the new MLD ieee80211_ops.
The callbacks added here use the new MLD FW API

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 76 +++++++++++-------
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 78 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 45 +++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  4 +
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  2 +
 5 files changed, 175 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 99a51d519214..165358a4a97e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2669,13 +2669,54 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 		iwl_mvm_apply_fw_smps_request(vif);
 }
 
+bool iwl_mvm_start_ap_ibss_common(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  int *ret)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	int i;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	mvmvif->ap_assoc_sta_count = 0;
+
+	/* must be set before quota calculations */
+	mvmvif->ap_ibss_active = true;
+
+	/* send all the early keys to the device now */
+	for (i = 0; i < ARRAY_SIZE(mvmvif->ap_early_keys); i++) {
+		struct ieee80211_key_conf *key = mvmvif->ap_early_keys[i];
+
+		if (!key)
+			continue;
+
+		mvmvif->ap_early_keys[i] = NULL;
+
+		*ret = __iwl_mvm_mac_set_key(hw, SET_KEY, vif, NULL, key);
+		if (*ret)
+			return true;
+	}
+
+	if (vif->type == NL80211_IFTYPE_AP && !vif->p2p) {
+		iwl_mvm_vif_set_low_latency(mvmvif, true,
+					    LOW_LATENCY_VIF_TYPE);
+		iwl_mvm_send_low_latency_cmd(mvm, true, mvmvif->id);
+	}
+
+	/* power updated needs to be done before quotas */
+	iwl_mvm_power_update_mac(mvm);
+
+	return false;
+}
+
 static int iwl_mvm_start_ap_ibss(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_bss_conf *link_conf)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	int ret, i;
+	int ret;
 
 	mutex_lock(&mvm->mutex);
 
@@ -2692,8 +2733,6 @@ static int iwl_mvm_start_ap_ibss(struct ieee80211_hw *hw,
 	if (vif->type == NL80211_IFTYPE_AP)
 		iwl_mvm_mac_ctxt_recalc_tsf_id(mvm, vif);
 
-	mvmvif->ap_assoc_sta_count = 0;
-
 	/* Add the mac context */
 	ret = iwl_mvm_mac_ctxt_add(mvm, vif);
 	if (ret)
@@ -2739,35 +2778,12 @@ static int iwl_mvm_start_ap_ibss(struct ieee80211_hw *hw,
 		}
 	}
 
-	/* must be set before quota calculations */
-	mvmvif->ap_ibss_active = true;
-
-	/* send all the early keys to the device now */
-	for (i = 0; i < ARRAY_SIZE(mvmvif->ap_early_keys); i++) {
-		struct ieee80211_key_conf *key = mvmvif->ap_early_keys[i];
-
-		if (!key)
-			continue;
-
-		mvmvif->ap_early_keys[i] = NULL;
-
-		ret = __iwl_mvm_mac_set_key(hw, SET_KEY, vif, NULL, key);
-		if (ret)
-			goto out_quota_failed;
-	}
-
-	if (vif->type == NL80211_IFTYPE_AP && !vif->p2p) {
-		iwl_mvm_vif_set_low_latency(mvmvif, true,
-					    LOW_LATENCY_VIF_TYPE);
-		iwl_mvm_send_low_latency_cmd(mvm, true, mvmvif->id);
-	}
-
-	/* power updated needs to be done before quotas */
-	iwl_mvm_power_update_mac(mvm);
+	if (iwl_mvm_start_ap_ibss_common(hw, vif, &ret))
+		goto out_failed;
 
 	ret = iwl_mvm_update_quotas(mvm, false, NULL);
 	if (ret)
-		goto out_quota_failed;
+		goto out_failed;
 
 	/* Need to update the P2P Device MAC (only GO, IBSS is single vif) */
 	if (vif->p2p && mvm->p2p_device_vif)
@@ -2783,7 +2799,7 @@ static int iwl_mvm_start_ap_ibss(struct ieee80211_hw *hw,
 
 	goto out_unlock;
 
-out_quota_failed:
+out_failed:
 	iwl_mvm_power_update_mac(mvm);
 	mvmvif->ap_ibss_active = false;
 	iwl_mvm_send_rm_bcast_sta(mvm, vif);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index f402e235525c..866415dc40bc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -245,9 +245,87 @@ static void iwl_mvm_mld_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	__iwl_mvm_mld_unassign_vif_chanctx(mvm, vif, ctx, false);
 	mutex_unlock(&mvm->mutex);
 }
+
+static int iwl_mvm_mld_start_ap_ibss(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	int ret;
+
+	mutex_lock(&mvm->mutex);
+
+	/* Send the beacon template */
+	ret = iwl_mvm_mac_ctxt_beacon_changed(mvm, vif);
+	if (ret)
+		goto out_unlock;
+
+	/* No need to re-calculate the tsf_is, as it was offloaded */
+
+	/* Add the mac context */
+	ret = iwl_mvm_mld_mac_ctxt_add(mvm, vif);
+	if (ret)
+		goto out_unlock;
+
+	/* Add link and activate it */
+	ret = iwl_mvm_add_link(mvm, vif);
+	if (ret)
+		goto out_remove_mac;
+
+	ret = iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE,
+				   true);
+	if (ret)
+		goto out_remove_link;
+
+	ret = iwl_mvm_mld_add_mcast_sta(mvm, vif);
+	if (ret)
+		goto out_remove_link;
+
+	/* Send the bcast station. At this stage the TBTT and DTIM time
+	 * events are added and applied to the scheduler
+	 */
+	ret = iwl_mvm_mld_add_bcast_sta(mvm, vif);
+	if (ret)
+		goto out_rm_mcast;
+
+	if (iwl_mvm_start_ap_ibss_common(hw, vif, &ret))
+		goto out_failed;
+
+	/* Need to update the P2P Device MAC (only GO, IBSS is single vif) */
+	if (vif->p2p && mvm->p2p_device_vif)
+		iwl_mvm_mld_mac_ctxt_changed(mvm, mvm->p2p_device_vif, false);
+
+	iwl_mvm_bt_coex_vif_change(mvm);
+
+	/* we don't support TDLS during DCM */
+	if (iwl_mvm_phy_ctx_count(mvm) > 1)
+		iwl_mvm_teardown_tdls_peers(mvm);
+
+	iwl_mvm_ftm_restart_responder(mvm, vif);
+
+	goto out_unlock;
+
+out_failed:
+	iwl_mvm_power_update_mac(mvm);
+	mvmvif->ap_ibss_active = false;
+	iwl_mvm_mld_rm_bcast_sta(mvm, vif);
+out_rm_mcast:
+	iwl_mvm_mld_rm_mcast_sta(mvm, vif);
+out_remove_link:
+	/* Link needs to be deactivated before removal */
+	iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE, false);
+	iwl_mvm_remove_link(mvm, vif);
+out_remove_mac:
+	iwl_mvm_mld_mac_ctxt_remove(mvm, vif);
+out_unlock:
+	mutex_unlock(&mvm->mutex);
+	return ret;
+}
+
 const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.add_interface = iwl_mvm_mld_mac_add_interface,
 	.remove_interface = iwl_mvm_mld_mac_remove_interface,
 	.assign_vif_chanctx = iwl_mvm_mld_assign_vif_chanctx,
 	.unassign_vif_chanctx = iwl_mvm_mld_unassign_vif_chanctx,
+	.join_ibss = iwl_mvm_mld_start_ap_ibss,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 4ee6f9b250d3..d81fc9207ef0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -176,6 +176,38 @@ int iwl_mvm_mld_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 				       IWL_MAX_TID_COUNT, &wdg_timeout);
 }
 
+/* Allocate a new station entry for the broadcast station to the given vif,
+ * and send it to the FW.
+ * Note that each AP/GO mac should have its own multicast station.
+ */
+int iwl_mvm_mld_add_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_int_sta *msta = &mvmvif->mcast_sta;
+	static const u8 _maddr[] = {0x03, 0x00, 0x00, 0x00, 0x00, 0x00};
+	const u8 *maddr = _maddr;
+	unsigned int timeout = iwl_mvm_get_wd_timeout(mvm, vif, false, false);
+
+	lockdep_assert_held(&mvm->mutex);
+
+	if (WARN_ON(vif->type != NL80211_IFTYPE_AP &&
+		    vif->type != NL80211_IFTYPE_ADHOC))
+		return -EOPNOTSUPP;
+
+	/* In IBSS, ieee80211_check_queues() sets the cab_queue to be
+	 * invalid, so make sure we use the queue we want.
+	 * Note that this is done here as we want to avoid making DQA
+	 * changes in mac80211 layer.
+	 */
+	if (vif->type == NL80211_IFTYPE_ADHOC)
+		mvmvif->cab_queue = IWL_MVM_DQA_GCAST_QUEUE;
+
+	return iwl_mvm_mld_add_int_sta(mvm, msta, &mvmvif->cab_queue,
+				       vif->type, STATION_TYPE_MCAST,
+				       mvmvif->phy_ctxt->id, maddr, 0,
+				       &timeout);
+}
+
 /* Allocate a new station entry for the sniffer station to the given vif,
  * and send it to the FW.
  */
@@ -272,6 +304,19 @@ int iwl_mvm_mld_rm_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 				      IWL_MAX_TID_COUNT, queueptr);
 }
 
+/* Send the FW a request to remove the station from it's internal data
+ * structures, and in addition remove it from the local data structure.
+ */
+int iwl_mvm_mld_rm_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
+	lockdep_assert_held(&mvm->mutex);
+
+	return iwl_mvm_mld_rm_int_sta(mvm, &mvmvif->mcast_sta, true, 0,
+				      &mvmvif->cab_queue);
+}
+
 int iwl_mvm_mld_rm_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
 	lockdep_assert_held(&mvm->mutex);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 2cd86237bc14..a21ccbfd017c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1766,6 +1766,10 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			 u32 changes, bool active);
 int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 
+/* AP and IBSS */
+bool iwl_mvm_start_ap_ibss_common(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif, int *ret);
+
 /* Quota management */
 static inline size_t iwl_mvm_quota_cmd_size(struct iwl_mvm *mvm)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index f0d22e9a117b..432768bfc433 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -563,8 +563,10 @@ int iwl_mvm_tvqm_enable_txq(struct iwl_mvm *mvm,
 /* STA */
 int iwl_mvm_mld_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 int iwl_mvm_mld_add_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+int iwl_mvm_mld_add_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 int iwl_mvm_mld_rm_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 int iwl_mvm_mld_rm_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+int iwl_mvm_mld_rm_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 
 /* Queues */
 void iwl_mvm_mld_modify_all_sta_disable_tx(struct iwl_mvm *mvm,
-- 
2.38.1

