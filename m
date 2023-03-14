Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D27B6B9D90
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 18:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjCNRxx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 13:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCNRxw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 13:53:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1C7E057
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 10:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678816384; x=1710352384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+I5pAoRthSEnzBNsGI37EOr5LE6pzOK/xvDh06sNbQw=;
  b=hdT5kQKwrGWzPMUip0e2seNGVwLmLRIEfRpLdyr8yjfXJHl7g2bgWT+b
   jkx8XrQqYacJaw6HjSYe+yzxj2WS1fIK/KBtu0uD7X6fBeOs6KniMBv9w
   fp6njRMx//CBkCZKqWXAL/1+IAByC48IXBZMfmxoYQ4YocGsAy3KZ0TZz
   50ibG/+in8mhHGDIA0aAfNdjsD5SeGeS5Yae3ewTwQVO0PTYFhH4TqVm3
   4FoA4TgLSi+whW2DqHrjPS/pwqc4lSGrCFWfH/LD+siskCPCdTvveFaxT
   ESng6w63xpNb9pO+cxs1XoKtGzOJN9y1NHuA0tpFGwOsGrQAdTZK79MhC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317149656"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="317149656"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768200558"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="768200558"
Received: from litalcoh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.192.4])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:21 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/22] wifi: iwlwifi: mvm: add an unassign_vif_chanctx() callback for MLD mode
Date:   Tue, 14 Mar 2023 19:49:26 +0200
Message-Id: <20230314194113.5d4bcd384425.I263eef3aad8efe23a597843fe7c56924038c8fdc@changeid>
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

This is another patch in the series adding all the ops
for the new MLD ieee80211_ops.
The callback added here uses the new MLD FW API

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  6 +-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 41 +++++++++++++
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 58 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 +
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  7 +++
 5 files changed, 112 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index c006d68a785e..93ca92e8eb98 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4551,9 +4551,9 @@ static int iwl_mvm_assign_vif_chanctx(struct ieee80211_hw *hw,
  * Returns if chanctx unassign chanctx is done
  * (either on failure or success)
  */
-static bool __iwl_mvm_unassign_vif_chanctx_common(struct iwl_mvm *mvm,
-						  struct ieee80211_vif *vif,
-						  bool switching_chanctx)
+bool __iwl_mvm_unassign_vif_chanctx_common(struct iwl_mvm *mvm,
+					   struct ieee80211_vif *vif,
+					   bool switching_chanctx)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 81f88d1b0feb..f402e235525c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -205,8 +205,49 @@ static int iwl_mvm_mld_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 	return ret;
 }
+
+static void __iwl_mvm_mld_unassign_vif_chanctx(struct iwl_mvm *mvm,
+					       struct ieee80211_vif *vif,
+					       struct ieee80211_chanctx_conf *ctx,
+					       bool switching_chanctx)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
+	if (__iwl_mvm_unassign_vif_chanctx_common(mvm, vif, switching_chanctx))
+		goto out;
+
+	if (vif->type == NL80211_IFTYPE_MONITOR)
+		iwl_mvm_mld_rm_snif_sta(mvm, vif);
+
+	if (vif->type == NL80211_IFTYPE_AP)
+		/* Set CS bit on all the stations */
+		iwl_mvm_mld_modify_all_sta_disable_tx(mvm, mvmvif, true);
+
+	/* Link needs to be deactivated before removal */
+	iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE, false);
+	iwl_mvm_remove_link(mvm, vif);
+
+out:
+	if (switching_chanctx)
+		return;
+	mvmvif->phy_ctxt = NULL;
+	iwl_mvm_power_update_mac(mvm);
+}
+
+static void iwl_mvm_mld_unassign_vif_chanctx(struct ieee80211_hw *hw,
+					     struct ieee80211_vif *vif,
+					     struct ieee80211_bss_conf *link_conf,
+					     struct ieee80211_chanctx_conf *ctx)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+
+	mutex_lock(&mvm->mutex);
+	__iwl_mvm_mld_unassign_vif_chanctx(mvm, vif, ctx, false);
+	mutex_unlock(&mvm->mutex);
+}
 const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.add_interface = iwl_mvm_mld_mac_add_interface,
 	.remove_interface = iwl_mvm_mld_mac_remove_interface,
 	.assign_vif_chanctx = iwl_mvm_mld_assign_vif_chanctx,
+	.unassign_vif_chanctx = iwl_mvm_mld_unassign_vif_chanctx,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index cef4fc441afe..4ee6f9b250d3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -279,3 +279,61 @@ int iwl_mvm_mld_rm_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	return iwl_mvm_mld_rm_int_sta(mvm, &mvm->snif_sta, false,
 				      IWL_MAX_TID_COUNT, &mvm->snif_queue);
 }
+
+static void iwl_mvm_mld_sta_modify_disable_tx(struct iwl_mvm *mvm,
+					      struct ieee80211_sta *sta,
+					      bool disable)
+{
+	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
+	struct iwl_mvm_sta_disable_tx_cmd cmd;
+	int ret;
+
+	spin_lock_bh(&mvm_sta->lock);
+
+	if (mvm_sta->disable_tx == disable) {
+		spin_unlock_bh(&mvm_sta->lock);
+		return;
+	}
+
+	mvm_sta->disable_tx = disable;
+
+	cmd.sta_id = cpu_to_le32(mvm_sta->sta_id);
+	cmd.disable = cpu_to_le32(disable);
+
+	ret = iwl_mvm_send_cmd_pdu(mvm,
+				   WIDE_ID(MAC_CONF_GROUP, STA_DISABLE_TX_CMD),
+				   CMD_ASYNC, sizeof(cmd), &cmd);
+	if (ret)
+		IWL_ERR(mvm,
+			"Failed to send STA_DISABLE_TX_CMD command (%d)\n",
+			ret);
+
+	spin_unlock_bh(&mvm_sta->lock);
+}
+
+void iwl_mvm_mld_modify_all_sta_disable_tx(struct iwl_mvm *mvm,
+					   struct iwl_mvm_vif *mvmvif,
+					   bool disable)
+{
+	struct ieee80211_sta *sta;
+	struct iwl_mvm_sta *mvm_sta;
+	int i;
+
+	rcu_read_lock();
+
+	/* Block/unblock all the stations of the given mvmvif */
+	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++) {
+		sta = rcu_dereference(mvm->fw_id_to_mac_id[i]);
+		if (IS_ERR_OR_NULL(sta))
+			continue;
+
+		mvm_sta = iwl_mvm_sta_from_mac80211(sta);
+		if (mvm_sta->mac_id_n_color !=
+		    FW_CMD_ID_AND_COLOR(mvmvif->id, mvmvif->color))
+			continue;
+
+		iwl_mvm_mld_sta_modify_disable_tx(mvm, sta, disable);
+	}
+
+	rcu_read_unlock();
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 3da4b31da8d7..3a828fddd72c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2173,6 +2173,9 @@ bool __iwl_mvm_assign_vif_chanctx_common(struct iwl_mvm *mvm,
 					 struct ieee80211_vif *vif,
 					 struct ieee80211_chanctx_conf *ctx,
 					 bool switching_chanctx, int *ret);
+bool __iwl_mvm_unassign_vif_chanctx_common(struct iwl_mvm *mvm,
+					   struct ieee80211_vif *vif,
+					   bool switching_chanctx);
 
 /* Channel info utils */
 static inline bool iwl_mvm_has_ultra_hb_channel(struct iwl_mvm *mvm)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index cad6e879c999..f0d22e9a117b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -545,6 +545,7 @@ void iwl_mvm_sta_modify_disable_tx_ap(struct iwl_mvm *mvm,
 void iwl_mvm_modify_all_sta_disable_tx(struct iwl_mvm *mvm,
 				       struct iwl_mvm_vif *mvmvif,
 				       bool disable);
+
 void iwl_mvm_csa_client_absent(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 void iwl_mvm_add_new_dqa_stream_wk(struct work_struct *wk);
 int iwl_mvm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
@@ -559,8 +560,14 @@ int iwl_mvm_tvqm_enable_txq(struct iwl_mvm *mvm,
 			    u8 sta_id, u8 tid, unsigned int timeout);
 
 /* New MLD STA related APIs */
+/* STA */
 int iwl_mvm_mld_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 int iwl_mvm_mld_add_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 int iwl_mvm_mld_rm_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 int iwl_mvm_mld_rm_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+
+/* Queues */
+void iwl_mvm_mld_modify_all_sta_disable_tx(struct iwl_mvm *mvm,
+					   struct iwl_mvm_vif *mvmvif,
+					   bool disable);
 #endif /* __sta_h__ */
-- 
2.38.1

