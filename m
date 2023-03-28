Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B0F6CB8F3
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 10:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjC1IA1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 04:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbjC1IAU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 04:00:20 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F2E4206
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 01:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990418; x=1711526418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cnw79LyaT+ZxC6w4Lbxk+k66xoaG1m/pkYH1JwUu/pQ=;
  b=NM73J9zjLRibiNFX59hXclSTFZjtwLPbVZcv0Rs1Q3Ds1YqKIuaZCzQ9
   mz9mDwgdcZSRe3RbfgJOR6jJzB1OLAMJqnJcFjgl43YLhyr+PfhvIziAX
   2yTMUxOFYmoEzMYH6/LgG7DAzPXArvdTk9fDZYroyGEyj4ycWehukBxsC
   gjAnTa/yf2uBw92gojjI2KwVAqrfKl9BmPQE7r01NHToG3fhpahS5aTsk
   WcDT29oLG9SI+NKNGNrkVvzM6L8B2/NZX09S/i2fd6bfvDy3+suc8UI3d
   U5mnV4s9WmLdikvNvM2C5ESxm1m++gnexDgkO0RktBWdB+Xt3t/B1SNa1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958209"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958209"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 01:00:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045247"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045247"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 01:00:02 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 19/31] wifi: iwlwifi: mvm: add link to firmware earlier
Date:   Tue, 28 Mar 2023 10:58:59 +0300
Message-Id: <20230328104949.097e5008b637.I4e75c6c11e21c08d28ff6a066be36629d3975db6@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230328075911.2370108-1-gregory.greenman@intel.com>
References: <20230328075911.2370108-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The firmware now allows adding a link that's not yet bound
to a PHY context. Make use of that to align the driver with
mac80211's API expectations. For now, just add the link at
the same time as the MAC since we don't yet have real MLD
support, but that'll obviously change later. This fixes an
issue with apStaId tracking in the firmware.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  21 +--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  17 +-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 173 +++++++++++-------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   7 +-
 4 files changed, 133 insertions(+), 85 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 4905dac3a048..d8902e0ed2ae 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -23,11 +23,9 @@ static int iwl_mvm_link_cmd_send(struct iwl_mvm *mvm,
 int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_phy_ctxt *phyctxt = mvmvif->deflink.phy_ctxt;
 	struct iwl_link_config_cmd cmd = {};
 
-	if (WARN_ON_ONCE(!mvmvif->deflink.phy_ctxt))
-		return -EINVAL;
-
 	/* Update SF - Disable if needed. if this fails, SF might still be on
 	 * while many macs are bound, which is forbidden - so fail the binding.
 	 */
@@ -36,7 +34,11 @@ int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 
 	cmd.link_id = cpu_to_le32(mvmvif->id);
 	cmd.mac_id = cpu_to_le32(mvmvif->id);
-	cmd.phy_id = cpu_to_le32(mvmvif->deflink.phy_ctxt->id);
+	/* P2P-Device already has a valid PHY context during add */
+	if (phyctxt)
+		cmd.phy_id = cpu_to_le32(phyctxt->id);
+	else
+		cmd.phy_id = cpu_to_le32(FW_CTXT_INVALID);
 
 	memcpy(cmd.local_link_addr, vif->addr, ETH_ALEN);
 
@@ -54,15 +56,15 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	struct iwl_link_config_cmd cmd = {};
 	u32 ht_flag, flags = 0, flags_mask = 0;
 
-	if (!phyctxt)
-		return -EINVAL;
-
 	cmd.link_id = cpu_to_le32(mvmvif->id);
 
 	/* The phy_id, link address and listen_lmac can be modified only until
 	 * the link becomes active, otherwise they will be ignored.
 	 */
-	cmd.phy_id = cpu_to_le32(phyctxt->id);
+	if (phyctxt)
+		cmd.phy_id = cpu_to_le32(phyctxt->id);
+	else
+		cmd.phy_id = cpu_to_le32(FW_CTXT_INVALID);
 	cmd.mac_id = cpu_to_le32(mvmvif->id);
 
 	memcpy(cmd.local_link_addr, vif->addr, ETH_ALEN);
@@ -157,9 +159,6 @@ int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	struct iwl_link_config_cmd cmd = {};
 	int ret;
 
-	if (WARN_ON_ONCE(!mvmvif->deflink.phy_ctxt))
-		return -EINVAL;
-
 	cmd.link_id = cpu_to_le32(mvmvif->id);
 	ret = iwl_mvm_link_cmd_send(mvm, &cmd, FW_CTXT_ACTION_REMOVE);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 2989285d451a..18e7ba98daa0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1437,10 +1437,13 @@ iwl_mvm_chandef_get_primary_80(struct cfg80211_chan_def *chandef)
 /*
  * Returns true if addding the interface is done
  * (either with success or failure)
+ *
+ * FIXME: remove this again and merge it in
  */
-bool iwl_mvm_mac_add_interface_common(struct iwl_mvm *mvm,
-				      struct ieee80211_hw *hw,
-				      struct ieee80211_vif *vif, int *ret)
+static bool iwl_mvm_mac_add_interface_common(struct iwl_mvm *mvm,
+					     struct ieee80211_hw *hw,
+					     struct ieee80211_vif *vif,
+					     int *ret)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
@@ -1621,8 +1624,8 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 	return ret;
 }
 
-static void iwl_mvm_prepare_mac_removal(struct iwl_mvm *mvm,
-					struct ieee80211_vif *vif)
+void iwl_mvm_prepare_mac_removal(struct iwl_mvm *mvm,
+				 struct ieee80211_vif *vif)
 {
 	if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
 		/*
@@ -1638,8 +1641,8 @@ static void iwl_mvm_prepare_mac_removal(struct iwl_mvm *mvm,
  * both - MLD and non-MLD modes. Returns true if removing the interface
  * is done
  */
-bool iwl_mvm_mac_remove_interface_common(struct ieee80211_hw *hw,
-					 struct ieee80211_vif *vif)
+static bool iwl_mvm_mac_remove_interface_common(struct ieee80211_hw *hw,
+						struct ieee80211_vif *vif)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index ec0789484d8b..1d2da26408e6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -13,17 +13,34 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 
 	mutex_lock(&mvm->mutex);
 
-	/* Common for MLD and non-MLD API */
-	if (iwl_mvm_mac_add_interface_common(mvm, hw, vif, &ret))
-		goto out_unlock;
+	mvmvif->mvm = mvm;
+	RCU_INIT_POINTER(mvmvif->deflink.probe_resp_data, NULL);
 
-	ret = iwl_mvm_mld_mac_ctxt_add(mvm, vif);
+	/* Not much to do here. The stack will not allow interface
+	 * types or combinations that we didn't advertise, so we
+	 * don't really have to check the types.
+	 */
+
+	/* make sure that beacon statistics don't go backwards with FW reset */
+	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
+		mvmvif->deflink.beacon_stats.accu_num_beacons +=
+			mvmvif->deflink.beacon_stats.num_beacons;
+
+	/* Allocate resources for the MAC context, and add it to the fw  */
+	ret = iwl_mvm_mac_ctxt_init(mvm, vif);
 	if (ret)
 		goto out_unlock;
 
-	ret = iwl_mvm_power_update_mac(mvm);
+	rcu_assign_pointer(mvm->vif_id_to_mac[mvmvif->id], vif);
+
+	mvmvif->features |= hw->netdev_features;
+
+	/* the first link always points to the default one */
+	mvmvif->link[0] = &mvmvif->deflink;
+
+	ret = iwl_mvm_mld_mac_ctxt_add(mvm, vif);
 	if (ret)
-		goto out_remove_mac;
+		goto out_unlock;
 
 	/* beacon filtering */
 	ret = iwl_mvm_disable_beacon_filter(mvm, vif, 0);
@@ -67,8 +84,16 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 		 * update the p2p device MAC when a GO is started/stopped
 		 */
 		mvm->p2p_device_vif = vif;
+	} else {
+		ret = iwl_mvm_add_link(mvm, vif);
+		if (ret)
+			goto out_free_bf;
 	}
 
+	ret = iwl_mvm_power_update_mac(mvm);
+	if (ret)
+		goto out_free_bf;
+
 	iwl_mvm_tcm_add_vif(mvm, vif);
 	INIT_DELAYED_WORK(&mvmvif->csa_work,
 			  iwl_mvm_channel_switch_disconnect_wk);
@@ -117,9 +142,52 @@ static void iwl_mvm_mld_mac_remove_interface(struct ieee80211_hw *hw,
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_probe_resp_data *probe_data;
 
-	if (iwl_mvm_mac_remove_interface_common(hw, vif))
-		goto out;
+	iwl_mvm_prepare_mac_removal(mvm, vif);
+
+	if (!(vif->type == NL80211_IFTYPE_AP ||
+	      vif->type == NL80211_IFTYPE_ADHOC))
+		iwl_mvm_tcm_rm_vif(mvm, vif);
+
+	mutex_lock(&mvm->mutex);
+
+	if (vif == mvm->csme_vif) {
+		iwl_mei_set_netdev(NULL);
+		mvm->csme_vif = NULL;
+	}
+
+	probe_data = rcu_dereference_protected(mvmvif->deflink.probe_resp_data,
+					       lockdep_is_held(&mvm->mutex));
+	RCU_INIT_POINTER(mvmvif->deflink.probe_resp_data, NULL);
+	if (probe_data)
+		kfree_rcu(probe_data, rcu_head);
+
+	if (mvm->bf_allowed_vif == mvmvif) {
+		mvm->bf_allowed_vif = NULL;
+		vif->driver_flags &= ~(IEEE80211_VIF_BEACON_FILTER |
+				       IEEE80211_VIF_SUPPORTS_CQM_RSSI);
+	}
+
+	if (vif->bss_conf.ftm_responder)
+		memset(&mvm->ftm_resp_stats, 0, sizeof(mvm->ftm_resp_stats));
+
+	iwl_mvm_vif_dbgfs_clean(mvm, vif);
+
+	/* For AP/GO interface, the tear down of the resources allocated to the
+	 * interface is be handled as part of the stop_ap flow.
+	 */
+	if (vif->type == NL80211_IFTYPE_AP ||
+	    vif->type == NL80211_IFTYPE_ADHOC) {
+#ifdef CONFIG_NL80211_TESTMODE
+		if (vif == mvm->noa_vif) {
+			mvm->noa_vif = NULL;
+			mvm->noa_duration = 0;
+		}
+#endif
+	}
+
+	iwl_mvm_power_update_mac(mvm);
 
 	if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
 		mvm->p2p_device_vif = NULL;
@@ -130,6 +198,8 @@ static void iwl_mvm_mld_mac_remove_interface(struct ieee80211_hw *hw,
 		iwl_mvm_remove_link(mvm, vif);
 		iwl_mvm_phy_ctxt_unref(mvm, mvmvif->deflink.phy_ctxt);
 		mvmvif->deflink.phy_ctxt = NULL;
+	} else {
+		iwl_mvm_remove_link(mvm, vif);
 	}
 
 	iwl_mvm_mld_mac_ctxt_remove(mvm, vif);
@@ -141,7 +211,6 @@ static void iwl_mvm_mld_mac_remove_interface(struct ieee80211_hw *hw,
 		__clear_bit(IEEE80211_HW_RX_INCLUDES_FCS, mvm->hw->flags);
 	}
 
-out:
 	mutex_unlock(&mvm->mutex);
 }
 
@@ -150,28 +219,30 @@ static int __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 					    struct ieee80211_chanctx_conf *ctx,
 					    bool switching_chanctx)
 {
+	u16 *phy_ctxt_id = (u16 *)ctx->drv_priv;
+	struct iwl_mvm_phy_ctxt *phy_ctxt = &mvm->phy_ctxts[*phy_ctxt_id];
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	int ret;
 
-	if (__iwl_mvm_assign_vif_chanctx_common(mvm, vif, ctx,
-						switching_chanctx, &ret))
-		goto out;
+	mvmvif->deflink.phy_ctxt = phy_ctxt;
 
-	if (!switching_chanctx) {
-		ret = iwl_mvm_add_link(mvm, vif);
-		if (ret)
-			goto out;
-	} else {
-		ret = iwl_mvm_link_changed(mvm, vif, 0, false);
-		if (ret)
-			goto out_remove_link;
+	if (switching_chanctx) {
+		/* reactivate if we turned this off during channel switch */
+		if (vif->type == NL80211_IFTYPE_AP)
+			mvmvif->ap_ibss_active = true;
 	}
 
+	/* send it first with phy context ID */
+	ret = iwl_mvm_link_changed(mvm, vif, 0, false);
+	if (ret)
+		goto out;
+
+	/* then activate */
 	ret = iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE |
 				   LINK_CONTEXT_MODIFY_RATES_INFO,
 				   true);
 	if (ret)
-		goto out_remove_link;
+		goto out;
 
 	/*
 	 * Power state must be updated before quotas,
@@ -182,19 +253,16 @@ static int __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 	if (vif->type == NL80211_IFTYPE_MONITOR) {
 		ret = iwl_mvm_mld_add_snif_sta(mvm, vif);
 		if (ret)
-			goto out_remove_link;
+			goto deactivate;
 	}
 
-	goto out;
+	return 0;
 
-out_remove_link:
-	/* Link needs to be deactivated before removal */
+deactivate:
 	iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE, false);
-	iwl_mvm_remove_link(mvm, vif);
-	iwl_mvm_power_update_mac(mvm);
 out:
-	if (ret)
-		mvmvif->deflink.phy_ctxt = NULL;
+	mvmvif->deflink.phy_ctxt = NULL;
+	iwl_mvm_power_update_mac(mvm);
 	return ret;
 }
 
@@ -220,16 +288,23 @@ static void __iwl_mvm_mld_unassign_vif_chanctx(struct iwl_mvm *mvm,
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
-	if (__iwl_mvm_unassign_vif_chanctx_common(mvm, vif, switching_chanctx))
-		goto out;
+	if (vif->type == NL80211_IFTYPE_AP && switching_chanctx) {
+		mvmvif->csa_countdown = false;
+
+		/* Set CS bit on all the stations */
+		iwl_mvm_modify_all_sta_disable_tx(mvm, mvmvif, true);
+
+		/* Save blocked iface, the timeout is set on the next beacon */
+		rcu_assign_pointer(mvm->csa_tx_blocked_vif, vif);
+
+		mvmvif->ap_ibss_active = false;
+	}
 
 	if (vif->type == NL80211_IFTYPE_MONITOR)
 		iwl_mvm_mld_rm_snif_sta(mvm, vif);
 
 	iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE, false);
-	if (!switching_chanctx)
-		iwl_mvm_remove_link(mvm, vif);
-out:
+
 	if (switching_chanctx)
 		return;
 	mvmvif->deflink.phy_ctxt = NULL;
@@ -257,32 +332,19 @@ static int iwl_mvm_mld_start_ap_ibss(struct ieee80211_hw *hw,
 	int ret;
 
 	mutex_lock(&mvm->mutex);
-
-	/* No need to re-calculate the tsf_is, as it was offloaded */
-
-	/* Add the mac context */
-	ret = iwl_mvm_mld_mac_ctxt_add(mvm, vif);
-	if (ret)
-		goto out_unlock;
-
 	/* Send the beacon template */
 	ret = iwl_mvm_mac_ctxt_beacon_changed(mvm, vif, link_conf);
 	if (ret)
 		goto out_unlock;
 
-	/* Add link and activate it */
-	ret = iwl_mvm_add_link(mvm, vif);
-	if (ret)
-		goto out_remove_mac;
-
 	ret = iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ALL,
 				   true);
 	if (ret)
-		goto out_remove_link;
+		goto out_unlock;
 
 	ret = iwl_mvm_mld_add_mcast_sta(mvm, vif);
 	if (ret)
-		goto out_remove_link;
+		goto out_unlock;
 
 	/* Send the bcast station. At this stage the TBTT and DTIM time
 	 * events are added and applied to the scheduler
@@ -314,12 +376,6 @@ static int iwl_mvm_mld_start_ap_ibss(struct ieee80211_hw *hw,
 	iwl_mvm_mld_rm_bcast_sta(mvm, vif);
 out_rm_mcast:
 	iwl_mvm_mld_rm_mcast_sta(mvm, vif);
-out_remove_link:
-	/* Link needs to be deactivated before removal */
-	iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE, false);
-	iwl_mvm_remove_link(mvm, vif);
-out_remove_mac:
-	iwl_mvm_mld_mac_ctxt_remove(mvm, vif);
 out_unlock:
 	mutex_unlock(&mvm->mutex);
 	return ret;
@@ -357,14 +413,7 @@ static void iwl_mvm_mld_stop_ap_ibss(struct ieee80211_hw *hw,
 	iwl_mvm_mld_rm_bcast_sta(mvm, vif);
 	iwl_mvm_mld_rm_mcast_sta(mvm, vif);
 
-	/* Link needs to be deactivated before removal */
-	iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE, false);
-	iwl_mvm_remove_link(mvm, vif);
-
 	iwl_mvm_power_update_mac(mvm);
-
-	iwl_mvm_mld_mac_ctxt_remove(mvm, vif);
-
 	mutex_unlock(&mvm->mutex);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index ae9c165197e8..af2059155794 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1718,11 +1718,8 @@ u8 iwl_mvm_get_ctrl_pos(struct cfg80211_chan_def *chandef);
 
 /* MAC (virtual interface) programming */
 
-bool iwl_mvm_mac_add_interface_common(struct iwl_mvm *mvm,
-				      struct ieee80211_hw *hw,
-				      struct ieee80211_vif *vif, int *ret);
-bool iwl_mvm_mac_remove_interface_common(struct ieee80211_hw *hw,
-					 struct ieee80211_vif *vif);
+void iwl_mvm_prepare_mac_removal(struct iwl_mvm *mvm,
+				 struct ieee80211_vif *vif);
 void iwl_mvm_set_fw_basic_rates(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 				__le32 *cck_rates, __le32 *ofdm_rates);
 void iwl_mvm_set_fw_protection_flags(struct iwl_mvm *mvm,
-- 
2.38.1

