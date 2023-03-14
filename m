Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A436B9D89
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 18:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjCNRwY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 13:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjCNRwV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 13:52:21 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB80B4F62
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 10:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678816307; x=1710352307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GlQmDDn2v+WbGQx79HjeBmSZKOMrklqu9YhAo3g9png=;
  b=BcJ40NpqjZVhaTwLXLllRjDzH/flWQK0loHWtSLMldNbHp3OvfHVJ5WE
   yOLGEIEetg7MeDsPnxUgXODAqs0J39nuqksqIAdcPI7xGCeO3viuOkLce
   g9PwTgc+lfIUgKD/VF+FZXrHYaGVCqwmMgMCsnaBfKZH3siEmWFoN/isF
   F6AEVMy41ELeFM5HUxLgamlZV+ZNmYbkbRaxhg7BXQIW2FufthCNIbfS7
   eeRoh2nfiKxAWYqoxc8H6eoxECFdZgUdvSdCEMJ8Wqe9atTE6GjItBylG
   x32l0XICUx9LM5GhAfMha+LVTnH0mw7gv+d2C7A4A9NNF3bWi8TfpAtei
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317149563"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="317149563"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768200528"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="768200528"
Received: from litalcoh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.192.4])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:10 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/22] wifi: iwlwifi: mvm: Add an add_interface() callback for mld mode
Date:   Tue, 14 Mar 2023 19:49:21 +0200
Message-Id: <20230314194113.6adc29bff39b.I97ed469028009be9392dcc6f7b5ffbe45f4b2c43@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230314174934.893149-1-gregory.greenman@intel.com>
References: <20230314174934.893149-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

As the MLD mode and its new APIs are introduced,
we've decided to add a new ieee80211_ops dedicated for
MLD callbacks. Add the MLD add_interface() callback
which uses the new MLD APIs added the previous patches.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/Makefile   |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  85 ++++++++-----
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 118 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   8 ++
 4 files changed, 184 insertions(+), 29 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/Makefile b/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
index 0e9b5381e265..b82f79ac5378 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
@@ -7,7 +7,7 @@ iwlmvm-y += power.o coex.o
 iwlmvm-y += tt.o offloading.o tdls.o
 iwlmvm-y += ftm-responder.o ftm-initiator.o
 iwlmvm-y += rfi.o
-iwlmvm-y += mld-key.o mld-mac.o link.o mld-sta.o
+iwlmvm-y += mld-key.o mld-mac.o link.o mld-sta.o mld-mac80211.o
 iwlmvm-$(CONFIG_IWLWIFI_DEBUGFS) += debugfs.o debugfs-vif.o
 iwlmvm-$(CONFIG_IWLWIFI_LEDS) += led.o
 iwlmvm-$(CONFIG_PM) += d3.o
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index cf08cb834cc4..73b164aad86d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1216,7 +1216,7 @@ static void iwl_mvm_mac_stop(struct ieee80211_hw *hw)
 	cancel_work_sync(&mvm->async_handlers_wk);
 }
 
-static struct iwl_mvm_phy_ctxt *iwl_mvm_get_free_phy_ctxt(struct iwl_mvm *mvm)
+struct iwl_mvm_phy_ctxt *iwl_mvm_get_free_phy_ctxt(struct iwl_mvm *mvm)
 {
 	u16 i;
 
@@ -1350,7 +1350,7 @@ static void iwl_mvm_abort_channel_switch(struct ieee80211_hw *hw,
 	iwl_mvm_post_channel_switch(hw, vif);
 }
 
-static void iwl_mvm_channel_switch_disconnect_wk(struct work_struct *wk)
+void iwl_mvm_channel_switch_disconnect_wk(struct work_struct *wk)
 {
 	struct iwl_mvm_vif *mvmvif;
 	struct ieee80211_vif *vif;
@@ -1384,12 +1384,17 @@ iwl_mvm_chandef_get_primary_80(struct cfg80211_chan_def *chandef)
 	return (control_start - data_start) / 80;
 }
 
-static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
-				     struct ieee80211_vif *vif)
+/*
+ * Returns true if addding the interface is done
+ * (either with success or failure)
+ */
+bool iwl_mvm_mac_add_interface_common(struct iwl_mvm *mvm,
+				      struct ieee80211_hw *hw,
+				      struct ieee80211_vif *vif, int *ret)
 {
-	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	int ret;
+
+	lockdep_assert_held(&mvm->mutex);
 
 	mvmvif->mvm = mvm;
 	RCU_INIT_POINTER(mvmvif->probe_resp_data, NULL);
@@ -1400,17 +1405,15 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 	 * don't really have to check the types.
 	 */
 
-	mutex_lock(&mvm->mutex);
-
 	/* make sure that beacon statistics don't go backwards with FW reset */
 	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
 		mvmvif->beacon_stats.accu_num_beacons +=
 			mvmvif->beacon_stats.num_beacons;
 
 	/* Allocate resources for the MAC context, and add it to the fw  */
-	ret = iwl_mvm_mac_ctxt_init(mvm, vif);
-	if (ret)
-		goto out_unlock;
+	*ret = iwl_mvm_mac_ctxt_init(mvm, vif);
+	if (*ret)
+		return true;
 
 	rcu_assign_pointer(mvm->vif_id_to_mac[mvmvif->id], vif);
 
@@ -1427,27 +1430,48 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 	 */
 	if (vif->type == NL80211_IFTYPE_AP ||
 	    vif->type == NL80211_IFTYPE_ADHOC) {
-		ret = iwl_mvm_alloc_bcast_sta(mvm, vif);
-		if (ret) {
-			IWL_ERR(mvm, "Failed to allocate bcast sta\n");
-			goto out_unlock;
-		}
-
-		/*
-		 * Only queue for this station is the mcast queue,
-		 * which shouldn't be in TFD mask anyway
-		 */
-		ret = iwl_mvm_allocate_int_sta(mvm, &mvmvif->mcast_sta,
-					       0, vif->type,
-					       IWL_STA_MULTICAST);
-		if (ret)
-			goto out_unlock;
-
 		iwl_mvm_vif_dbgfs_register(mvm, vif);
-		goto out_unlock;
+		return true;
 	}
 
 	mvmvif->features |= hw->netdev_features;
+	return false;
+}
+
+static int iwl_mvm_alloc_bcast_mcast_sta(struct iwl_mvm *mvm,
+					 struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	int ret;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	ret = iwl_mvm_alloc_bcast_sta(mvm, vif);
+	if (ret) {
+		IWL_ERR(mvm, "Failed to allocate bcast sta\n");
+		return ret;
+	}
+
+	/*
+	 * Only queue for this station is the mcast queue,
+	 * which shouldn't be in TFD mask anyway
+	 */
+	return iwl_mvm_allocate_int_sta(mvm, &mvmvif->mcast_sta, 0, vif->type,
+					IWL_STA_MULTICAST);
+}
+
+static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	int ret;
+
+	mutex_lock(&mvm->mutex);
+
+	/* Common for MLD and non-MLD API */
+	if (iwl_mvm_mac_add_interface_common(mvm, hw, vif, &ret))
+		goto out;
 
 	ret = iwl_mvm_mac_ctxt_add(mvm, vif);
 	if (ret)
@@ -1516,6 +1540,11 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 		mvm->csme_vif = vif;
 	}
 
+out:
+	if (!ret && (vif->type == NL80211_IFTYPE_AP ||
+		     vif->type == NL80211_IFTYPE_ADHOC))
+		ret = iwl_mvm_alloc_bcast_mcast_sta(mvm, vif);
+
 	goto out_unlock;
 
  out_unbind:
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
new file mode 100644
index 000000000000..b233bdd68b37
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2022 Intel Corporation
+ */
+#include "mvm.h"
+
+static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
+					 struct ieee80211_vif *vif)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	int ret;
+
+	mutex_lock(&mvm->mutex);
+
+	/* Common for MLD and non-MLD API */
+	if (iwl_mvm_mac_add_interface_common(mvm, hw, vif, &ret))
+		goto out_unlock;
+
+	ret = iwl_mvm_mld_mac_ctxt_add(mvm, vif);
+	if (ret)
+		goto out_unlock;
+
+	ret = iwl_mvm_power_update_mac(mvm);
+	if (ret)
+		goto out_remove_mac;
+
+	/* beacon filtering */
+	ret = iwl_mvm_disable_beacon_filter(mvm, vif, 0);
+	if (ret)
+		goto out_remove_mac;
+
+	if (!mvm->bf_allowed_vif &&
+	    vif->type == NL80211_IFTYPE_STATION && !vif->p2p) {
+		mvm->bf_allowed_vif = mvmvif;
+		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER |
+				     IEEE80211_VIF_SUPPORTS_CQM_RSSI;
+	}
+
+	/*
+	 * P2P_DEVICE interface does not have a channel context assigned to it,
+	 * so a dedicated PHY context is allocated to it and the corresponding
+	 * MAC context is bound to it at this stage.
+	 */
+	if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
+		mvmvif->phy_ctxt = iwl_mvm_get_free_phy_ctxt(mvm);
+		if (!mvmvif->phy_ctxt) {
+			ret = -ENOSPC;
+			goto out_free_bf;
+		}
+
+		iwl_mvm_phy_ctxt_ref(mvm, mvmvif->phy_ctxt);
+		ret = iwl_mvm_add_link(mvm, vif);
+		if (ret)
+			goto out_unref_phy;
+
+		ret = iwl_mvm_link_changed(mvm, vif,
+					   LINK_CONTEXT_MODIFY_ACTIVE |
+					   LINK_CONTEXT_MODIFY_RATES_INFO,
+					   true);
+		if (ret)
+			goto out_remove_link;
+
+		ret = iwl_mvm_mld_add_bcast_sta(mvm, vif);
+		if (ret)
+			goto out_remove_link;
+
+		/* Save a pointer to p2p device vif, so it can later be used to
+		 * update the p2p device MAC when a GO is started/stopped
+		 */
+		mvm->p2p_device_vif = vif;
+	}
+
+	iwl_mvm_tcm_add_vif(mvm, vif);
+	INIT_DELAYED_WORK(&mvmvif->csa_work,
+			  iwl_mvm_channel_switch_disconnect_wk);
+
+	if (vif->type == NL80211_IFTYPE_MONITOR) {
+		mvm->monitor_on = true;
+		ieee80211_hw_set(mvm->hw, RX_INCLUDES_FCS);
+	}
+
+	iwl_mvm_vif_dbgfs_register(mvm, vif);
+
+	if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status) &&
+	    vif->type == NL80211_IFTYPE_STATION && !vif->p2p &&
+	    !mvm->csme_vif && mvm->mei_registered) {
+		iwl_mei_set_nic_info(vif->addr, mvm->nvm_data->hw_addr);
+		iwl_mei_set_netdev(ieee80211_vif_to_wdev(vif)->netdev);
+		mvm->csme_vif = vif;
+	}
+
+	goto out_unlock;
+
+ out_remove_link:
+	/* Link needs to be deactivated before removal */
+	iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE, false);
+	iwl_mvm_remove_link(mvm, vif);
+ out_unref_phy:
+	iwl_mvm_phy_ctxt_unref(mvm, mvmvif->phy_ctxt);
+ out_free_bf:
+	if (mvm->bf_allowed_vif == mvmvif) {
+		mvm->bf_allowed_vif = NULL;
+		vif->driver_flags &= ~(IEEE80211_VIF_BEACON_FILTER |
+				       IEEE80211_VIF_SUPPORTS_CQM_RSSI);
+	}
+ out_remove_mac:
+	mvmvif->phy_ctxt = NULL;
+	iwl_mvm_mld_mac_ctxt_remove(mvm, vif);
+ out_unlock:
+	mutex_unlock(&mvm->mutex);
+
+	return ret;
+}
+
+const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
+	.add_interface = iwl_mvm_mld_mac_add_interface,
+};
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index fd32eea9459b..63b9cc1923c5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -72,6 +72,7 @@
 #define IWL_MVM_OFFCHANNEL_QUEUE 0
 
 extern const struct ieee80211_ops iwl_mvm_hw_ops;
+extern const struct ieee80211_ops iwl_mvm_mld_hw_ops;
 
 /**
  * struct iwl_mvm_mod_params - module parameters for iwlmvm
@@ -1624,6 +1625,7 @@ void iwl_mvm_rx_shared_mem_cfg_notif(struct iwl_mvm *mvm,
 				     struct iwl_rx_cmd_buffer *rxb);
 
 /* MVM PHY */
+struct iwl_mvm_phy_ctxt *iwl_mvm_get_free_phy_ctxt(struct iwl_mvm *mvm);
 int iwl_mvm_phy_ctxt_add(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
 			 struct cfg80211_chan_def *chandef,
 			 u8 chains_static, u8 chains_dynamic);
@@ -1640,6 +1642,9 @@ u8 iwl_mvm_get_ctrl_pos(struct cfg80211_chan_def *chandef);
 
 /* MAC (virtual interface) programming */
 
+bool iwl_mvm_mac_add_interface_common(struct iwl_mvm *mvm,
+				      struct ieee80211_hw *hw,
+				      struct ieee80211_vif *vif, int *ret);
 void iwl_mvm_set_fw_basic_rates(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 				__le32 *cck_rates, __le32 *ofdm_rates);
 void iwl_mvm_set_fw_protection_flags(struct iwl_mvm *mvm,
@@ -2158,6 +2163,9 @@ static inline u8 iwl_mvm_phy_band_from_nl80211(enum nl80211_band band)
 	}
 }
 
+/* Channel Switch */
+void iwl_mvm_channel_switch_disconnect_wk(struct work_struct *wk);
+
 /* Channel info utils */
 static inline bool iwl_mvm_has_ultra_hb_channel(struct iwl_mvm *mvm)
 {
-- 
2.38.1

