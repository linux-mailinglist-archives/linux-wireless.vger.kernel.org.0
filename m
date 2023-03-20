Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEAF6C0EFF
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 11:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjCTKfk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 06:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjCTKfM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 06:35:12 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974DE1ADC9
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 03:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679308472; x=1710844472;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VAanaBj88aQHhAzlxAwoHMh1ai3modwFcZAjeGyr7mU=;
  b=gtcNucI4kUyl5C09JAOuc3PZ3c/+kaj9DpSPU6mlhxJBVocpixW1bUta
   kTISPlFk2zFIC4drfPwvkS1uQaQ34WqQfONlmKO096OYCRKQh0zh2CVGI
   AAa6qbXuWHg9VBanYQYyKpHZrLAxR9vwIW5KrmjTxOVbUMm0Pg5rGYEc6
   omq0vr9WLWtLFkjGyeur1r4V6Xhd7op4Ig082ktHw68YQA/oweWnOx0FX
   MmEwjCp4dL/UuzrWu0JjWb89LQSbZaMIz4xmgIvDapS7l1jLXv7R1/9B6
   6fVQBcczvNZAWoE7fqacQdule7sea+TH8pEYHkP2dCRkqmo34yOqzVzfY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="326997914"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="326997914"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:33:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="713523675"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="713523675"
Received: from ranikhou-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.179.26])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:33:52 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/18] wifi: iwlwifi: mvm: add stop_ap() and leave_ibss() callbacks for MLD mode
Date:   Mon, 20 Mar 2023 12:33:10 +0200
Message-Id: <20230320122330.42b0d4726b8d.I0755baace47c0ab1d9d70137448125d3140ef3af@changeid>
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
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 22 ++++++++++----
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 30 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 ++
 3 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 165358a4a97e..c6eb4cb44a09 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2826,16 +2826,15 @@ static int iwl_mvm_start_ibss(struct ieee80211_hw *hw,
 	return iwl_mvm_start_ap_ibss(hw, vif, &vif->bss_conf);
 }
 
-static void iwl_mvm_stop_ap_ibss(struct ieee80211_hw *hw,
-				 struct ieee80211_vif *vif,
-				 struct ieee80211_bss_conf *link_conf)
+/* Common part for MLD and non-MLD ops */
+void iwl_mvm_stop_ap_ibss_common(struct iwl_mvm *mvm,
+				 struct ieee80211_vif *vif)
 {
-	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
-	iwl_mvm_prepare_mac_removal(mvm, vif);
+	lockdep_assert_held(&mvm->mutex);
 
-	mutex_lock(&mvm->mutex);
+	iwl_mvm_prepare_mac_removal(mvm, vif);
 
 	/* Handle AP stop while in CSA */
 	if (rcu_access_pointer(mvm->csa_vif) == vif) {
@@ -2860,6 +2859,17 @@ static void iwl_mvm_stop_ap_ibss(struct ieee80211_hw *hw,
 	}
 
 	iwl_mvm_bt_coex_vif_change(mvm);
+}
+
+static void iwl_mvm_stop_ap_ibss(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_bss_conf *link_conf)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+
+	mutex_lock(&mvm->mutex);
+
+	iwl_mvm_stop_ap_ibss_common(mvm, vif);
 
 	/* Need to update the P2P Device MAC (only GO, IBSS is single vif) */
 	if (vif->p2p && mvm->p2p_device_vif)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 866415dc40bc..f800bf0b6d90 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -322,10 +322,40 @@ static int iwl_mvm_mld_start_ap_ibss(struct ieee80211_hw *hw,
 	return ret;
 }
 
+static void iwl_mvm_mld_stop_ap_ibss(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+
+	mutex_lock(&mvm->mutex);
+
+	iwl_mvm_stop_ap_ibss_common(mvm, vif);
+
+	/* Need to update the P2P Device MAC (only GO, IBSS is single vif) */
+	if (vif->p2p && mvm->p2p_device_vif)
+		iwl_mvm_mld_mac_ctxt_changed(mvm, mvm->p2p_device_vif, false);
+
+	iwl_mvm_ftm_responder_clear(mvm, vif);
+
+	iwl_mvm_mld_rm_bcast_sta(mvm, vif);
+	iwl_mvm_mld_rm_mcast_sta(mvm, vif);
+
+	/* Link needs to be deactivated before removal */
+	iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE, false);
+	iwl_mvm_remove_link(mvm, vif);
+
+	iwl_mvm_power_update_mac(mvm);
+
+	iwl_mvm_mld_mac_ctxt_remove(mvm, vif);
+
+	mutex_unlock(&mvm->mutex);
+}
+
 const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.add_interface = iwl_mvm_mld_mac_add_interface,
 	.remove_interface = iwl_mvm_mld_mac_remove_interface,
 	.assign_vif_chanctx = iwl_mvm_mld_assign_vif_chanctx,
 	.unassign_vif_chanctx = iwl_mvm_mld_unassign_vif_chanctx,
 	.join_ibss = iwl_mvm_mld_start_ap_ibss,
+	.leave_ibss = iwl_mvm_mld_stop_ap_ibss,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index a21ccbfd017c..a03c2e5bbc25 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1769,6 +1769,8 @@ int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 /* AP and IBSS */
 bool iwl_mvm_start_ap_ibss_common(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif, int *ret);
+void iwl_mvm_stop_ap_ibss_common(struct iwl_mvm *mvm,
+				 struct ieee80211_vif *vif);
 
 /* Quota management */
 static inline size_t iwl_mvm_quota_cmd_size(struct iwl_mvm *mvm)
-- 
2.38.1

