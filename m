Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8837B7C52
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 11:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242070AbjJDJhU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 05:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242053AbjJDJhS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 05:37:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9046C6
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 02:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696412233; x=1727948233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=45OW4ZjN+357RSrJCbO5l4ZRsBiJ06xsOa+ZT1K2tfo=;
  b=Oy03dTgqcd1PVEAF205wC7pbzKONhEKGMF5mCgX/TI97CM7OEN/Nijfn
   vefEVJEWYvc9CVrvs7gS2me8RVsZUpAdVPf9Osi8JwKg9EhHjRgJbKn7l
   kW/KdrwVHpO/6rcx2FdF7LP2Isag2/rL1Lp3DsTlB5SkPJGtK8qUKhfYl
   Ekq8UM0qEHoS1NxWIDJsPsUgTv9+W/fU0SNznRqYxnVq0/DGnBihFDFd2
   mgenPuOomQeGVb1v/gI1EtpKD9ol5y4Im3tqPmaTJ/xIEYSCwnG9FxEDx
   XJXJXSQmAMnlJXdt6bqlSqK8k6+ImK4lmKCeCBns8rdyuEXnpb8+Kx5ig
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="449611864"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="449611864"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:37:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082415193"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="1082415193"
Received: from oferweis-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.222.21])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:37:09 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/15] wifi: iwlwifi: mvm: Don't always bind/link the P2P Device interface
Date:   Wed,  4 Oct 2023 12:36:30 +0300
Message-Id: <20231004123422.c5b83b4bf9de.Ia80daf3ba0b5fec7d0919247fcbdbdb58bddf02b@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231004093634.131303-1-gregory.greenman@intel.com>
References: <20231004093634.131303-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

It is not necessary to keep the P2P Device bound/linked to a PHY
context when there is no active ROC.

Modify the P2P Device flows so the binding/linking would be done
only while ROC is active. With this change the switch_phy_ctxt()
is no longer needed so remove it.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |   9 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |   8 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 152 ++++++------------
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 100 ++++--------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   7 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  24 ++-
 6 files changed, 111 insertions(+), 189 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index ace82e2c5bd9..e76f57d78125 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -53,7 +53,6 @@ int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	unsigned int link_id = link_conf->link_id;
 	struct iwl_mvm_vif_link_info *link_info = mvmvif->link[link_id];
 	struct iwl_link_config_cmd cmd = {};
-	struct iwl_mvm_phy_ctxt *phyctxt;
 
 	if (WARN_ON_ONCE(!link_info))
 		return -EINVAL;
@@ -77,12 +76,8 @@ int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	cmd.link_id = cpu_to_le32(link_info->fw_link_id);
 	cmd.mac_id = cpu_to_le32(mvmvif->id);
 	cmd.spec_link_id = link_conf->link_id;
-	/* P2P-Device already has a valid PHY context during add */
-	phyctxt = link_info->phy_ctxt;
-	if (phyctxt)
-		cmd.phy_id = cpu_to_le32(phyctxt->id);
-	else
-		cmd.phy_id = cpu_to_le32(FW_CTXT_INVALID);
+	WARN_ON_ONCE(link_info->phy_ctxt);
+	cmd.phy_id = cpu_to_le32(FW_CTXT_INVALID);
 
 	memcpy(cmd.local_link_addr, link_conf->addr, ETH_ALEN);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 06bbd6212df0..c4f96125cf33 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -286,6 +286,10 @@ int iwl_mvm_mac_ctxt_init(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	INIT_LIST_HEAD(&mvmvif->time_event_data.list);
 	mvmvif->time_event_data.id = TE_MAX;
 
+	mvmvif->deflink.bcast_sta.sta_id = IWL_MVM_INVALID_STA;
+	mvmvif->deflink.mcast_sta.sta_id = IWL_MVM_INVALID_STA;
+	mvmvif->deflink.ap_sta_id = IWL_MVM_INVALID_STA;
+
 	/* No need to allocate data queues to P2P Device MAC and NAN.*/
 	if (vif->type == NL80211_IFTYPE_P2P_DEVICE)
 		return 0;
@@ -300,10 +304,6 @@ int iwl_mvm_mac_ctxt_init(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 		mvmvif->deflink.cab_queue = IWL_MVM_DQA_GCAST_QUEUE;
 	}
 
-	mvmvif->deflink.bcast_sta.sta_id = IWL_MVM_INVALID_STA;
-	mvmvif->deflink.mcast_sta.sta_id = IWL_MVM_INVALID_STA;
-	mvmvif->deflink.ap_sta_id = IWL_MVM_INVALID_STA;
-
 	for (i = 0; i < NUM_IWL_MVM_SMPS_REQ; i++)
 		mvmvif->deflink.smps_requests[i] = IEEE80211_SMPS_AUTOMATIC;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 79ecfbb89c45..56945047e4f6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1607,32 +1607,8 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 				     IEEE80211_VIF_SUPPORTS_CQM_RSSI;
 	}
 
-	/*
-	 * P2P_DEVICE interface does not have a channel context assigned to it,
-	 * so a dedicated PHY context is allocated to it and the corresponding
-	 * MAC context is bound to it at this stage.
-	 */
-	if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
-
-		mvmvif->deflink.phy_ctxt = iwl_mvm_get_free_phy_ctxt(mvm);
-		if (!mvmvif->deflink.phy_ctxt) {
-			ret = -ENOSPC;
-			goto out_free_bf;
-		}
-
-		iwl_mvm_phy_ctxt_ref(mvm, mvmvif->deflink.phy_ctxt);
-		ret = iwl_mvm_binding_add_vif(mvm, vif);
-		if (ret)
-			goto out_unref_phy;
-
-		ret = iwl_mvm_add_p2p_bcast_sta(mvm, vif);
-		if (ret)
-			goto out_unbind;
-
-		/* Save a pointer to p2p device vif, so it can later be used to
-		 * update the p2p device MAC when a GO is started/stopped */
+	if (vif->type == NL80211_IFTYPE_P2P_DEVICE)
 		mvm->p2p_device_vif = vif;
-	}
 
 	iwl_mvm_tcm_add_vif(mvm, vif);
 	INIT_DELAYED_WORK(&mvmvif->csa_work,
@@ -1661,11 +1637,6 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 
 	goto out_unlock;
 
- out_unbind:
-	iwl_mvm_binding_remove_vif(mvm, vif);
- out_unref_phy:
-	iwl_mvm_phy_ctxt_unref(mvm, mvmvif->deflink.phy_ctxt);
- out_free_bf:
 	if (mvm->bf_allowed_vif == mvmvif) {
 		mvm->bf_allowed_vif = NULL;
 		vif->driver_flags &= ~(IEEE80211_VIF_BEACON_FILTER |
@@ -1762,12 +1733,17 @@ static void iwl_mvm_mac_remove_interface(struct ieee80211_hw *hw,
 	if (iwl_mvm_mac_remove_interface_common(hw, vif))
 		goto out;
 
+	/* Before the interface removal, mac80211 would cancel the ROC, and the
+	 * ROC worker would be scheduled if needed. The worker would be flushed
+	 * in iwl_mvm_prepare_mac_removal() and thus at this point there is no
+	 * binding etc. so nothing needs to be done here.
+	 */
 	if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
+		if (mvmvif->deflink.phy_ctxt) {
+			iwl_mvm_phy_ctxt_unref(mvm, mvmvif->deflink.phy_ctxt);
+			mvmvif->deflink.phy_ctxt = NULL;
+		}
 		mvm->p2p_device_vif = NULL;
-		iwl_mvm_rm_p2p_bcast_sta(mvm, vif);
-		iwl_mvm_binding_remove_vif(mvm, vif);
-		iwl_mvm_phy_ctxt_unref(mvm, mvmvif->deflink.phy_ctxt);
-		mvmvif->deflink.phy_ctxt = NULL;
 	}
 
 	iwl_mvm_mac_ctxt_remove(mvm, vif);
@@ -4576,30 +4552,20 @@ static int iwl_mvm_add_aux_sta_for_hs20(struct iwl_mvm *mvm, u32 lmac_id)
 	return ret;
 }
 
-static int iwl_mvm_roc_switch_binding(struct iwl_mvm *mvm,
-				      struct ieee80211_vif *vif,
-				      struct iwl_mvm_phy_ctxt *new_phy_ctxt)
+static int iwl_mvm_roc_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	int ret = 0;
+	int ret;
 
 	lockdep_assert_held(&mvm->mutex);
 
-	/* Unbind the P2P_DEVICE from the current PHY context,
-	 * and if the PHY context is not used remove it.
-	 */
-	ret = iwl_mvm_binding_remove_vif(mvm, vif);
-	if (WARN(ret, "Failed unbinding P2P_DEVICE\n"))
+	ret = iwl_mvm_binding_add_vif(mvm, vif);
+	if (WARN(ret, "Failed binding P2P_DEVICE\n"))
 		return ret;
 
-	iwl_mvm_phy_ctxt_unref(mvm, mvmvif->deflink.phy_ctxt);
-
-	/* Bind the P2P_DEVICE to the current PHY Context */
-	mvmvif->deflink.phy_ctxt = new_phy_ctxt;
-
-	ret = iwl_mvm_binding_add_vif(mvm, vif);
-	WARN(ret, "Failed binding P2P_DEVICE\n");
-	return ret;
+	/* The station and queue allocation must be done only after the binding
+	 * is done, as otherwise the FW might incorrectly configure its state.
+	 */
+	return iwl_mvm_add_p2p_bcast_sta(mvm, vif);
 }
 
 static int iwl_mvm_roc(struct ieee80211_hw *hw,
@@ -4610,7 +4576,7 @@ static int iwl_mvm_roc(struct ieee80211_hw *hw,
 {
 	static const struct iwl_mvm_roc_ops ops = {
 		.add_aux_sta_for_hs20 = iwl_mvm_add_aux_sta_for_hs20,
-		.switch_phy_ctxt = iwl_mvm_roc_switch_binding,
+		.link = iwl_mvm_roc_link,
 	};
 
 	return iwl_mvm_roc_common(hw, vif, channel, duration, type, &ops);
@@ -4626,7 +4592,6 @@ int iwl_mvm_roc_common(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct cfg80211_chan_def chandef;
 	struct iwl_mvm_phy_ctxt *phy_ctxt;
-	bool band_change_removal;
 	int ret, i;
 	u32 lmac_id;
 
@@ -4655,82 +4620,61 @@ int iwl_mvm_roc_common(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		/* handle below */
 		break;
 	default:
-		IWL_ERR(mvm, "vif isn't P2P_DEVICE: %d\n", vif->type);
+		IWL_ERR(mvm, "ROC: Invalid vif type=%u\n", vif->type);
 		ret = -EINVAL;
 		goto out_unlock;
 	}
 
+	/* Try using a PHY context that is already in use */
 	for (i = 0; i < NUM_PHY_CTX; i++) {
 		phy_ctxt = &mvm->phy_ctxts[i];
-		if (phy_ctxt->ref == 0 || mvmvif->deflink.phy_ctxt == phy_ctxt)
+		if (!phy_ctxt->ref || mvmvif->deflink.phy_ctxt == phy_ctxt)
 			continue;
 
-		if (phy_ctxt->ref && channel == phy_ctxt->channel) {
-			ret = ops->switch_phy_ctxt(mvm, vif, phy_ctxt);
-			if (ret)
-				goto out_unlock;
+		if (channel == phy_ctxt->channel) {
+			if (mvmvif->deflink.phy_ctxt)
+				iwl_mvm_phy_ctxt_unref(mvm,
+						       mvmvif->deflink.phy_ctxt);
 
+			mvmvif->deflink.phy_ctxt = phy_ctxt;
 			iwl_mvm_phy_ctxt_ref(mvm, mvmvif->deflink.phy_ctxt);
-			goto schedule_time_event;
+			goto link_and_start_p2p_roc;
 		}
 	}
 
-	/* Need to update the PHY context only if the ROC channel changed */
-	if (channel == mvmvif->deflink.phy_ctxt->channel)
-		goto schedule_time_event;
-
-	cfg80211_chandef_create(&chandef, channel, NL80211_CHAN_NO_HT);
-
-	/*
-	 * Check if the remain-on-channel is on a different band and that
-	 * requires context removal, see iwl_mvm_phy_ctxt_changed(). If
-	 * so, we'll need to release and then re-configure here, since we
-	 * must not remove a PHY context that's part of a binding.
+	/* If the currently used PHY context is configured with a matching
+	 * channel use it
 	 */
-	band_change_removal =
-		fw_has_capa(&mvm->fw->ucode_capa,
-			    IWL_UCODE_TLV_CAPA_BINDING_CDB_SUPPORT) &&
-		mvmvif->deflink.phy_ctxt->channel->band != chandef.chan->band;
-
-	if (mvmvif->deflink.phy_ctxt->ref == 1 && !band_change_removal) {
-		/*
-		 * Change the PHY context configuration as it is currently
-		 * referenced only by the P2P Device MAC (and we can modify it)
-		 */
-		ret = iwl_mvm_phy_ctxt_changed(mvm, mvmvif->deflink.phy_ctxt,
-					       &chandef, 1, 1);
-		if (ret)
-			goto out_unlock;
+	if (mvmvif->deflink.phy_ctxt) {
+		if (channel == mvmvif->deflink.phy_ctxt->channel)
+			goto link_and_start_p2p_roc;
 	} else {
-		/*
-		 * The PHY context is shared with other MACs (or we're trying to
-		 * switch bands), so remove the P2P Device from the binding,
-		 * allocate an new PHY context and create a new binding.
-		 */
 		phy_ctxt = iwl_mvm_get_free_phy_ctxt(mvm);
 		if (!phy_ctxt) {
 			ret = -ENOSPC;
 			goto out_unlock;
 		}
 
-		ret = iwl_mvm_phy_ctxt_changed(mvm, phy_ctxt, &chandef,
-					       1, 1);
-		if (ret) {
-			IWL_ERR(mvm, "Failed to change PHY context\n");
-			goto out_unlock;
-		}
+		mvmvif->deflink.phy_ctxt = phy_ctxt;
+		iwl_mvm_phy_ctxt_ref(mvm, mvmvif->deflink.phy_ctxt);
+	}
 
-		ret = ops->switch_phy_ctxt(mvm, vif, phy_ctxt);
-		if (ret)
-			goto out_unlock;
+	/* Configure the PHY context */
+	cfg80211_chandef_create(&chandef, channel, NL80211_CHAN_NO_HT);
 
-		iwl_mvm_phy_ctxt_ref(mvm, mvmvif->deflink.phy_ctxt);
+	ret = iwl_mvm_phy_ctxt_changed(mvm, phy_ctxt, &chandef,
+				       1, 1);
+	if (ret) {
+		IWL_ERR(mvm, "Failed to change PHY context\n");
+		goto out_unlock;
 	}
 
-schedule_time_event:
-	/* Schedule the time events */
-	ret = iwl_mvm_start_p2p_roc(mvm, vif, duration, type);
+link_and_start_p2p_roc:
+	ret = ops->link(mvm, vif);
+	if (ret)
+		goto out_unlock;
 
+	ret = iwl_mvm_start_p2p_roc(mvm, vif, duration, type);
 out_unlock:
 	mutex_unlock(&mvm->mutex);
 	IWL_DEBUG_MAC80211(mvm, "leave\n");
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 4d1b6abfeb67..1e311eec9d5f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -56,43 +56,15 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 				     IEEE80211_VIF_SUPPORTS_CQM_RSSI;
 	}
 
-	/*
-	 * P2P_DEVICE interface does not have a channel context assigned to it,
-	 * so a dedicated PHY context is allocated to it and the corresponding
-	 * MAC context is bound to it at this stage.
-	 */
-	if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
-		mvmvif->deflink.phy_ctxt = iwl_mvm_get_free_phy_ctxt(mvm);
-		if (!mvmvif->deflink.phy_ctxt) {
-			ret = -ENOSPC;
-			goto out_free_bf;
-		}
-
-		iwl_mvm_phy_ctxt_ref(mvm, mvmvif->deflink.phy_ctxt);
-		ret = iwl_mvm_add_link(mvm, vif, &vif->bss_conf);
-		if (ret)
-			goto out_unref_phy;
-
-		ret = iwl_mvm_link_changed(mvm, vif, &vif->bss_conf,
-					   LINK_CONTEXT_MODIFY_ACTIVE |
-					   LINK_CONTEXT_MODIFY_RATES_INFO,
-					   true);
-		if (ret)
-			goto out_remove_link;
-
-		ret = iwl_mvm_mld_add_bcast_sta(mvm, vif, &vif->bss_conf);
-		if (ret)
-			goto out_remove_link;
+	ret = iwl_mvm_add_link(mvm, vif, &vif->bss_conf);
+	if (ret)
+		goto out_free_bf;
 
-		/* Save a pointer to p2p device vif, so it can later be used to
-		 * update the p2p device MAC when a GO is started/stopped
-		 */
+	/* Save a pointer to p2p device vif, so it can later be used to
+	 * update the p2p device MAC when a GO is started/stopped
+	 */
+	if (vif->type == NL80211_IFTYPE_P2P_DEVICE)
 		mvm->p2p_device_vif = vif;
-	} else {
-		ret = iwl_mvm_add_link(mvm, vif, &vif->bss_conf);
-		if (ret)
-			goto out_free_bf;
-	}
 
 	ret = iwl_mvm_power_update_mac(mvm);
 	if (ret)
@@ -119,10 +91,6 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 
 	goto out_unlock;
 
- out_remove_link:
-	iwl_mvm_disable_link(mvm, vif, &vif->bss_conf);
- out_unref_phy:
-	iwl_mvm_phy_ctxt_unref(mvm, mvmvif->deflink.phy_ctxt);
  out_free_bf:
 	if (mvm->bf_allowed_vif == mvmvif) {
 		mvm->bf_allowed_vif = NULL;
@@ -130,7 +98,6 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 				       IEEE80211_VIF_SUPPORTS_CQM_RSSI);
 	}
  out_remove_mac:
-	mvmvif->deflink.phy_ctxt = NULL;
 	mvmvif->link[0] = NULL;
 	iwl_mvm_mld_mac_ctxt_remove(mvm, vif);
  out_unlock:
@@ -185,14 +152,18 @@ static void iwl_mvm_mld_mac_remove_interface(struct ieee80211_hw *hw,
 
 	iwl_mvm_power_update_mac(mvm);
 
+	/* Before the interface removal, mac80211 would cancel the ROC, and the
+	 * ROC worker would be scheduled if needed. The worker would be flushed
+	 * in iwl_mvm_prepare_mac_removal() and thus at this point the link is
+	 * not active. So need only to remove the link.
+	 */
 	if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
+		if (mvmvif->deflink.phy_ctxt) {
+			iwl_mvm_phy_ctxt_unref(mvm, mvmvif->deflink.phy_ctxt);
+			mvmvif->deflink.phy_ctxt = NULL;
+		}
 		mvm->p2p_device_vif = NULL;
-
-		/* P2P device uses only one link */
-		iwl_mvm_mld_rm_bcast_sta(mvm, vif, &vif->bss_conf);
-		iwl_mvm_disable_link(mvm, vif, &vif->bss_conf);
-		iwl_mvm_phy_ctxt_unref(mvm, mvmvif->deflink.phy_ctxt);
-		mvmvif->deflink.phy_ctxt = NULL;
+		iwl_mvm_remove_link(mvm, vif, &vif->bss_conf);
 	} else {
 		iwl_mvm_disable_link(mvm, vif, &vif->bss_conf);
 	}
@@ -1086,36 +1057,29 @@ iwl_mvm_mld_mac_conf_tx(struct ieee80211_hw *hw,
 	return 0;
 }
 
-static int iwl_mvm_link_switch_phy_ctx(struct iwl_mvm *mvm,
-				       struct ieee80211_vif *vif,
-				       struct iwl_mvm_phy_ctxt *new_phy_ctxt)
+static int iwl_mvm_mld_roc_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	int ret = 0;
+	int ret;
 
 	lockdep_assert_held(&mvm->mutex);
 
-	/* Inorder to change the phy_ctx of a link, the link needs to be
-	 * inactive. Therefore, first deactivate the link, then change its
-	 * phy_ctx, and then activate it again.
-	 */
-	ret = iwl_mvm_link_changed(mvm, vif, &vif->bss_conf,
-				   LINK_CONTEXT_MODIFY_ACTIVE, false);
-	if (WARN(ret, "Failed to deactivate link\n"))
+	/* The PHY context ID might have changed so need to set it */
+	ret = iwl_mvm_link_changed(mvm, vif, &vif->bss_conf, 0, false);
+	if (WARN(ret, "Failed to set PHY context ID\n"))
 		return ret;
 
-	iwl_mvm_phy_ctxt_unref(mvm, mvmvif->deflink.phy_ctxt);
-
-	mvmvif->deflink.phy_ctxt = new_phy_ctxt;
+	ret = iwl_mvm_link_changed(mvm, vif, &vif->bss_conf,
+				   LINK_CONTEXT_MODIFY_ACTIVE |
+				   LINK_CONTEXT_MODIFY_RATES_INFO,
+				   true);
 
-	ret = iwl_mvm_link_changed(mvm, vif, &vif->bss_conf, 0, false);
-	if (WARN(ret, "Failed to deactivate link\n"))
+	if (WARN(ret, "Failed linking P2P_DEVICE\n"))
 		return ret;
 
-	ret = iwl_mvm_link_changed(mvm, vif, &vif->bss_conf,
-				   LINK_CONTEXT_MODIFY_ACTIVE, true);
-	WARN(ret, "Failed binding P2P_DEVICE\n");
-	return ret;
+	/* The station and queue allocation must be done only after the linking
+	 * is done, as otherwise the FW might incorrectly configure its state.
+	 */
+	return iwl_mvm_mld_add_bcast_sta(mvm, vif, &vif->bss_conf);
 }
 
 static int iwl_mvm_mld_roc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
@@ -1124,7 +1088,7 @@ static int iwl_mvm_mld_roc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 {
 	static const struct iwl_mvm_roc_ops ops = {
 		.add_aux_sta_for_hs20 = iwl_mvm_mld_add_aux_sta,
-		.switch_phy_ctxt = iwl_mvm_link_switch_phy_ctx,
+		.link = iwl_mvm_mld_roc_link,
 	};
 
 	return iwl_mvm_roc_common(hw, vif, channel, duration, type, &ops);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index df88c027475c..866753218ec8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1971,13 +1971,12 @@ void iwl_mvm_bss_info_changed_station_assoc(struct iwl_mvm *mvm,
  *
  * @add_aux_sta_for_hs20: pointer to the function that adds an aux sta
  *	for Hot Spot 2.0
- * @switch_phy_ctxt: pointer to the function that switches a vif from one
- *	phy_ctx to another
+ * @link: For a P2P Device interface, pointer to a function that links the
+ *      MAC/Link to the PHY context
  */
 struct iwl_mvm_roc_ops {
 	int (*add_aux_sta_for_hs20)(struct iwl_mvm *mvm, u32 lmac_id);
-	int (*switch_phy_ctxt)(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			       struct iwl_mvm_phy_ctxt *new_phy_ctxt);
+	int (*link)(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 };
 
 int iwl_mvm_roc_common(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index e1f6cea649c3..82b7560c0ad9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -78,9 +78,29 @@ void iwl_mvm_roc_done_wk(struct work_struct *wk)
 		 */
 
 		if (!WARN_ON(!mvm->p2p_device_vif)) {
-			mvmvif = iwl_mvm_vif_from_mac80211(mvm->p2p_device_vif);
+			struct ieee80211_vif *vif = mvm->p2p_device_vif;
+
+			mvmvif = iwl_mvm_vif_from_mac80211(vif);
 			iwl_mvm_flush_sta(mvm, &mvmvif->deflink.bcast_sta,
 					  true);
+
+			if (mvm->mld_api_is_used) {
+				iwl_mvm_mld_rm_bcast_sta(mvm, vif,
+							 &vif->bss_conf);
+
+				iwl_mvm_link_changed(mvm, vif, &vif->bss_conf,
+						     LINK_CONTEXT_MODIFY_ACTIVE,
+						     false);
+			} else {
+				iwl_mvm_rm_p2p_bcast_sta(mvm, vif);
+				iwl_mvm_binding_remove_vif(mvm, vif);
+			}
+
+			/* Do not remove the PHY context as removing and adding
+			 * a PHY context has timing overheads. Leaving it
+			 * configured in FW would be useful in case the next ROC
+			 * is with the same channel.
+			 */
 		}
 	}
 
@@ -880,8 +900,8 @@ void iwl_mvm_rx_session_protect_notif(struct iwl_mvm *mvm,
 	if (!le32_to_cpu(notif->status) || !le32_to_cpu(notif->start)) {
 		/* End TE, notify mac80211 */
 		mvmvif->time_event_data.id = SESSION_PROTECT_CONF_MAX_ID;
-		ieee80211_remain_on_channel_expired(mvm->hw);
 		iwl_mvm_p2p_roc_finished(mvm);
+		ieee80211_remain_on_channel_expired(mvm->hw);
 	} else if (le32_to_cpu(notif->start)) {
 		if (WARN_ON(mvmvif->time_event_data.id !=
 				le32_to_cpu(notif->conf_id)))
-- 
2.38.1

