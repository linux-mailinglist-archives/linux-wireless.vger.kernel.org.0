Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1556CB8E8
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 10:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjC1H7o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 03:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjC1H7n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 03:59:43 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A1C422C
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 00:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990382; x=1711526382;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CKAoWyodUXZJN//0CNnPjHcLpuhTccB9sr7EvxQ8Too=;
  b=CvNRJCXQ7A9r/kdbKH7TZeZZ0lOPUP2YAiOPn0lelBBYNVX3MPvoy9uM
   FZCceZCgjTNIugRybzScL0oIBo/ttowAkXh0zBG2UtYQVGvKvXMWTyN7n
   Yen6ByFHVtn5XPvyT9koukinMWpcCiYP/eZmfyi/8SpcJ50PD+ovqtqHb
   /glEkMOq27aASRa9ymZ8o37oKF+PIUvB6e8wbEMTuc+cm8yY+Y3ES7hfJ
   MrPnZ63ShVKXObUdRhjfFE4gcn/8+75y1dMgaafXw2s3ghxs1ZIm4mxu4
   5iY4ObGD/JdIM/SVp8OHo6LGkwAsGtZlKmby1eOs2qpZDOX88iCcG+y35
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958102"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958102"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045131"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045131"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:40 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/31] wifi: iwlwifi: mvm: unite sta_modify_disable_tx flows
Date:   Tue, 28 Mar 2023 10:58:48 +0300
Message-Id: <20230328104948.5692d8dea9be.Ib1882b2c2f0b0603abc4b7d4a0ecc45cd1fbf9a7@changeid>
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

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

These flows are the same in both MLD API and the current API,
except for the commands that are being sent during this flows.
Instead of checking each time before calling these floews
what API we use and then call the correct function, call always the old
one, which in turn will call the new one in case we're using the MLD
API.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  6 ++--
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  4 ---
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 36 +++++++++++--------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 18 +++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  6 ++++
 5 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index d36319bd9247..ce2f502bfff8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4762,6 +4762,9 @@ bool __iwl_mvm_unassign_vif_chanctx_common(struct iwl_mvm *mvm,
 
 		mvmvif->csa_countdown = false;
 
+		/* Set CS bit on all the stations */
+		iwl_mvm_modify_all_sta_disable_tx(mvm, mvmvif, true);
+
 		/* Save blocked iface, the timeout is set on the next beacon */
 		rcu_assign_pointer(mvm->csa_tx_blocked_vif, vif);
 
@@ -4787,9 +4790,6 @@ static void __iwl_mvm_unassign_vif_chanctx(struct iwl_mvm *mvm,
 	if (vif->type == NL80211_IFTYPE_MONITOR)
 		iwl_mvm_rm_snif_sta(mvm, vif);
 
-	if (vif->type == NL80211_IFTYPE_AP)
-		/* Set CS bit on all the stations */
-		iwl_mvm_modify_all_sta_disable_tx(mvm, mvmvif, true);
 
 	if (vif->type == NL80211_IFTYPE_STATION && switching_chanctx) {
 		disabled_vif = vif;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 871da586ebb4..92f174231f60 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -220,10 +220,6 @@ static void __iwl_mvm_mld_unassign_vif_chanctx(struct iwl_mvm *mvm,
 	if (vif->type == NL80211_IFTYPE_MONITOR)
 		iwl_mvm_mld_rm_snif_sta(mvm, vif);
 
-	if (vif->type == NL80211_IFTYPE_AP)
-		/* Set CS bit on all the stations */
-		iwl_mvm_mld_modify_all_sta_disable_tx(mvm, mvmvif, true);
-
 	/* Link needs to be deactivated before removal */
 	iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE, false);
 	iwl_mvm_remove_link(mvm, vif);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 643eb58317f0..a6eb18830cd9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -589,24 +589,14 @@ int iwl_mvm_mld_rm_sta_id(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	return ret;
 }
 
-static void iwl_mvm_mld_sta_modify_disable_tx(struct iwl_mvm *mvm,
-					      struct ieee80211_sta *sta,
-					      bool disable)
+void iwl_mvm_mld_sta_modify_disable_tx(struct iwl_mvm *mvm,
+				       struct iwl_mvm_sta *mvmsta,
+				       bool disable)
 {
-	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
 	struct iwl_mvm_sta_disable_tx_cmd cmd;
 	int ret;
 
-	spin_lock_bh(&mvm_sta->lock);
-
-	if (mvm_sta->disable_tx == disable) {
-		spin_unlock_bh(&mvm_sta->lock);
-		return;
-	}
-
-	mvm_sta->disable_tx = disable;
-
-	cmd.sta_id = cpu_to_le32(mvm_sta->deflink.sta_id);
+	cmd.sta_id = cpu_to_le32(mvmsta->deflink.sta_id);
 	cmd.disable = cpu_to_le32(disable);
 
 	ret = iwl_mvm_send_cmd_pdu(mvm,
@@ -616,6 +606,22 @@ static void iwl_mvm_mld_sta_modify_disable_tx(struct iwl_mvm *mvm,
 		IWL_ERR(mvm,
 			"Failed to send STA_DISABLE_TX_CMD command (%d)\n",
 			ret);
+}
+
+void iwl_mvm_mld_sta_modify_disable_tx_ap(struct iwl_mvm *mvm,
+					  struct ieee80211_sta *sta,
+					  bool disable)
+{
+	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
+
+	spin_lock_bh(&mvm_sta->lock);
+
+	if (mvm_sta->disable_tx == disable) {
+		spin_unlock_bh(&mvm_sta->lock);
+		return;
+	}
+
+	iwl_mvm_mld_sta_modify_disable_tx(mvm, mvm_sta, disable);
 
 	spin_unlock_bh(&mvm_sta->lock);
 }
@@ -641,7 +647,7 @@ void iwl_mvm_mld_modify_all_sta_disable_tx(struct iwl_mvm *mvm,
 		    FW_CMD_ID_AND_COLOR(mvmvif->id, mvmvif->color))
 			continue;
 
-		iwl_mvm_mld_sta_modify_disable_tx(mvm, sta, disable);
+		iwl_mvm_mld_sta_modify_disable_tx(mvm, mvm_sta, disable);
 	}
 
 	rcu_read_unlock();
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 0ff66ffc5bee..54ef749be488 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -4030,7 +4030,8 @@ void iwl_mvm_rx_eosp_notif(struct iwl_mvm *mvm,
 }
 
 void iwl_mvm_sta_modify_disable_tx(struct iwl_mvm *mvm,
-				   struct iwl_mvm_sta *mvmsta, bool disable)
+				   struct iwl_mvm_sta *mvmsta,
+				   bool disable)
 {
 	struct iwl_mvm_add_sta_cmd cmd = {
 		.add_modify = STA_MODE_MODIFY,
@@ -4041,6 +4042,11 @@ void iwl_mvm_sta_modify_disable_tx(struct iwl_mvm *mvm,
 	};
 	int ret;
 
+	if (mvm->mld_api_is_used) {
+		iwl_mvm_mld_sta_modify_disable_tx(mvm, mvmsta, disable);
+		return;
+	}
+
 	ret = iwl_mvm_send_cmd_pdu(mvm, ADD_STA, CMD_ASYNC,
 				   iwl_mvm_add_sta_cmd_size(mvm), &cmd);
 	if (ret)
@@ -4053,6 +4059,11 @@ void iwl_mvm_sta_modify_disable_tx_ap(struct iwl_mvm *mvm,
 {
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
 
+	if (mvm->mld_api_is_used) {
+		iwl_mvm_mld_sta_modify_disable_tx_ap(mvm, sta, disable);
+		return;
+	}
+
 	spin_lock_bh(&mvm_sta->lock);
 
 	if (mvm_sta->disable_tx == disable) {
@@ -4103,6 +4114,11 @@ void iwl_mvm_modify_all_sta_disable_tx(struct iwl_mvm *mvm,
 	struct iwl_mvm_sta *mvm_sta;
 	int i;
 
+	if (mvm->mld_api_is_used) {
+		iwl_mvm_mld_modify_all_sta_disable_tx(mvm, mvmvif, disable);
+		return;
+	}
+
 	rcu_read_lock();
 
 	/* Block/unblock all the stations of the given mvmvif */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 5436e52ca639..3a9002eeb5fb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -640,4 +640,10 @@ int iwl_mvm_mld_rm_sta_id(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 void iwl_mvm_mld_modify_all_sta_disable_tx(struct iwl_mvm *mvm,
 					   struct iwl_mvm_vif *mvmvif,
 					   bool disable);
+void iwl_mvm_mld_sta_modify_disable_tx(struct iwl_mvm *mvm,
+				       struct iwl_mvm_sta *mvm_sta,
+				       bool disable);
+void iwl_mvm_mld_sta_modify_disable_tx_ap(struct iwl_mvm *mvm,
+					  struct ieee80211_sta *sta,
+					  bool disable);
 #endif /* __sta_h__ */
-- 
2.38.1

