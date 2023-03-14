Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB93A6B9D8C
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 18:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjCNRw4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 13:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjCNRwz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 13:52:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FCEB3E3A
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 10:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678816333; x=1710352333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A4INPiHgER9RJU7bmO0SWiC8u1F834mkvKS5mCZmgSU=;
  b=LTlSuihd+74L0neDaoeXe8xUTwu9oA65MPywD0SLj3Yx+oeyK5LfEk+1
   GoFRgwxc9dtmphHnN/tHJtm3zZgtK3T6YXHOl8QoeIjtsfwDP4660JvxZ
   cvYvjmOf78IEBod9WIWTdEpvnaK5EXZyD/uEM9XlNupAhRXfrEaom2Wm9
   4tBrJsNCM3lMY2aZqi5lamVC4WomGhH6UU9c2ESdjfcZLsLkSu6WwFugm
   4DvcWIwQN4z3MLgPyuWYGNn3lC2SaHmIcKCN2GEXeLO1qnNDDgf2Zkzvw
   PIsl/DXeA+yPRZwVntEyVXbwGwWCSeJbp1PiFGl8yvyJ59L0x4AKPR8Ge
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317149589"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="317149589"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768200532"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="768200532"
Received: from litalcoh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.192.4])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:13 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/22] wifi: iwlwifi: mvm: Add a remove_interface() callback for mld mode
Date:   Tue, 14 Mar 2023 19:49:22 +0200
Message-Id: <20230314194113.b87c5c0a4b6b.I631173a73d6ffd7232aa539ea8b356a222fac398@changeid>
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
MLD callbacks. Add the MLD remove_interface() callback
which uses the new MLD APIs.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 32 +++++++++++++----
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 34 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  4 +--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  2 ++
 5 files changed, 66 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 73b164aad86d..bdec5ae5e83a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1579,7 +1579,11 @@ static void iwl_mvm_prepare_mac_removal(struct iwl_mvm *mvm,
 	}
 }
 
-static void iwl_mvm_mac_remove_interface(struct ieee80211_hw *hw,
+/* This function is doing the common part of removing the interface for
+ * both - MLD and non-MLD modes. Returns true if removing the interface
+ * is done
+ */
+bool iwl_mvm_mac_remove_interface_common(struct ieee80211_hw *hw,
 					 struct ieee80211_vif *vif)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
@@ -1628,11 +1632,22 @@ static void iwl_mvm_mac_remove_interface(struct ieee80211_hw *hw,
 			mvm->noa_duration = 0;
 		}
 #endif
-		iwl_mvm_dealloc_int_sta(mvm, &mvmvif->mcast_sta);
-		iwl_mvm_dealloc_bcast_sta(mvm, vif);
-		goto out_release;
+		return true;
 	}
 
+	iwl_mvm_power_update_mac(mvm);
+	return false;
+}
+
+static void iwl_mvm_mac_remove_interface(struct ieee80211_hw *hw,
+					 struct ieee80211_vif *vif)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
+	if (iwl_mvm_mac_remove_interface_common(hw, vif))
+		goto out;
+
 	if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
 		mvm->p2p_device_vif = NULL;
 		iwl_mvm_rm_p2p_bcast_sta(mvm, vif);
@@ -1641,7 +1656,6 @@ static void iwl_mvm_mac_remove_interface(struct ieee80211_hw *hw,
 		mvmvif->phy_ctxt = NULL;
 	}
 
-	iwl_mvm_power_update_mac(mvm);
 	iwl_mvm_mac_ctxt_remove(mvm, vif);
 
 	RCU_INIT_POINTER(mvm->vif_id_to_mac[mvmvif->id], NULL);
@@ -1649,7 +1663,13 @@ static void iwl_mvm_mac_remove_interface(struct ieee80211_hw *hw,
 	if (vif->type == NL80211_IFTYPE_MONITOR)
 		mvm->monitor_on = false;
 
-out_release:
+out:
+	if (vif->type == NL80211_IFTYPE_AP ||
+	    vif->type == NL80211_IFTYPE_ADHOC) {
+		iwl_mvm_dealloc_int_sta(mvm, &mvmvif->mcast_sta);
+		iwl_mvm_dealloc_bcast_sta(mvm, vif);
+	}
+
 	mutex_unlock(&mvm->mutex);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index b233bdd68b37..8dca72ec55cb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -113,6 +113,40 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 	return ret;
 }
 
+static void iwl_mvm_mld_mac_remove_interface(struct ieee80211_hw *hw,
+					     struct ieee80211_vif *vif)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
+	if (iwl_mvm_mac_remove_interface_common(hw, vif))
+		goto out;
+
+	if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
+		mvm->p2p_device_vif = NULL;
+		iwl_mvm_mld_rm_bcast_sta(mvm, vif);
+		/* Link needs to be deactivated before removal */
+		iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE,
+				     false);
+		iwl_mvm_remove_link(mvm, vif);
+		iwl_mvm_phy_ctxt_unref(mvm, mvmvif->phy_ctxt);
+		mvmvif->phy_ctxt = NULL;
+	}
+
+	iwl_mvm_mld_mac_ctxt_remove(mvm, vif);
+
+	RCU_INIT_POINTER(mvm->vif_id_to_mac[mvmvif->id], NULL);
+
+	if (vif->type == NL80211_IFTYPE_MONITOR) {
+		mvm->monitor_on = false;
+		__clear_bit(IEEE80211_HW_RX_INCLUDES_FCS, mvm->hw->flags);
+	}
+
+out:
+	mutex_unlock(&mvm->mutex);
+}
+
 const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.add_interface = iwl_mvm_mld_mac_add_interface,
+	.remove_interface = iwl_mvm_mld_mac_remove_interface,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 63b9cc1923c5..70c5e5d052d8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1645,6 +1645,8 @@ u8 iwl_mvm_get_ctrl_pos(struct cfg80211_chan_def *chandef);
 bool iwl_mvm_mac_add_interface_common(struct iwl_mvm *mvm,
 				      struct ieee80211_hw *hw,
 				      struct ieee80211_vif *vif, int *ret);
+bool iwl_mvm_mac_remove_interface_common(struct ieee80211_hw *hw,
+					 struct ieee80211_vif *vif);
 void iwl_mvm_set_fw_basic_rates(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 				__le32 *cck_rates, __le32 *ofdm_rates);
 void iwl_mvm_set_fw_protection_flags(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 313c5416ae5e..bbcc7459f3a0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2256,8 +2256,8 @@ int iwl_mvm_send_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	return 0;
 }
 
-static void iwl_mvm_free_bcast_sta_queues(struct iwl_mvm *mvm,
-					  struct ieee80211_vif *vif)
+void iwl_mvm_free_bcast_sta_queues(struct iwl_mvm *mvm,
+				   struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	u16 *queueptr, queue;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index d11851b47684..cad6e879c999 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -510,6 +510,8 @@ int iwl_mvm_add_aux_sta(struct iwl_mvm *mvm, u32 lmac_id);
 int iwl_mvm_rm_aux_sta(struct iwl_mvm *mvm);
 
 int iwl_mvm_alloc_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+void iwl_mvm_free_bcast_sta_queues(struct iwl_mvm *mvm,
+				   struct ieee80211_vif *vif);
 int iwl_mvm_send_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 int iwl_mvm_add_p2p_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 int iwl_mvm_send_rm_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
-- 
2.38.1

