Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409DC730FAB
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jun 2023 08:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244376AbjFOGtW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jun 2023 02:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244203AbjFOGtJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jun 2023 02:49:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36BC2D40
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 23:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686811658; x=1718347658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XIXyr4O9sjX9bd1bZ5WbJtvT7Ep7cBy16q5wJsUsTaw=;
  b=ZeGrNjQ0wumkofbRRknejOEvg0ePA3hrxKcW9VunEAJifwZOp6nSrUp3
   PlL5s3iV2JMPMApUI2z9l6uSc22bIr3DCDs3uh4jJ/p+fOKiFP8NoSDpx
   /7+GX05No5md8A38EBOyFBOYJheF9RKpX6IBALtfyzc/qw8TufXM+wdW/
   EY+Cj/J47nUy2I+duY+5BLcSQ6Jhi4pg0njxkMe1ksliadN9Wh1d2AXZ7
   2VHYswbprGZVQGyZqeMd9/vsiZ+CtGViLNbw3lKsUMD5pEAgfwaQAdLjf
   UP2tQAoMpyELzBiSn+lqFoWyWFYJR8fLRqmVSXYPtdOqz6IeeG1OlETs3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="362212233"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="362212233"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 23:47:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="782395943"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="782395943"
Received: from uabekas-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.220.240])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 23:47:36 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 2/5] wifi: iwlwifi: handle eSR transitions
Date:   Thu, 15 Jun 2023 09:47:17 +0300
Message-Id: <20230615094410.fb6409f44aca.I502460dec15e0b76035ad3cd809afa4ac16e9fe1@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230615064720.459645-1-gregory.greenman@intel.com>
References: <20230615064720.459645-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

There several transitions to handle in eSR mode:
* SMPS should be disabled when in eSR mode
* indicate to the fw whether the new added link should use the
  listen lmac or the main lmac
* RLC is offloaded when in eSR mode; adjust RLC command accordingly

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |   7 +-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 150 +++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  12 +-
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c |  13 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |   6 +-
 5 files changed, 155 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 69ebd844de2a..5fdebb911f7b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -89,6 +89,8 @@ int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (vif->type == NL80211_IFTYPE_ADHOC && link_conf->bssid)
 		memcpy(cmd.ibss_bssid_addr, link_conf->bssid, ETH_ALEN);
 
+	cmd.listen_lmac = cpu_to_le32(link_info->listen_lmac);
+
 	return iwl_mvm_link_cmd_send(mvm, &cmd, FW_CTXT_ACTION_ADD);
 }
 
@@ -149,10 +151,6 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (vif->type == NL80211_IFTYPE_ADHOC && link_conf->bssid)
 		memcpy(cmd.ibss_bssid_addr, link_conf->bssid, ETH_ALEN);
 
-	/* TODO: set a value to cmd.listen_lmac when system requiremens
-	 * will define it
-	 */
-
 	iwl_mvm_set_fw_basic_rates(mvm, vif, link_conf,
 				   &cmd.cck_rates, &cmd.ofdm_rates);
 
@@ -228,6 +226,7 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	cmd.flags = cpu_to_le32(flags);
 	cmd.flags_mask = cpu_to_le32(flags_mask);
 	cmd.spec_link_id = link_conf->link_id;
+	cmd.listen_lmac = cpu_to_le32(link_info->listen_lmac);
 
 	ret = iwl_mvm_link_cmd_send(mvm, &cmd, FW_CTXT_ACTION_MODIFY);
 	if (!ret && (changes & LINK_CONTEXT_MODIFY_ACTIVE))
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 37b5b7f1f153..636ad2b76428 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -215,6 +215,53 @@ static void iwl_mvm_mld_mac_remove_interface(struct ieee80211_hw *hw,
 	mutex_unlock(&mvm->mutex);
 }
 
+static unsigned int iwl_mvm_mld_count_active_links(struct ieee80211_vif *vif)
+{
+	unsigned int n_active = 0;
+	int i;
+
+	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
+		struct ieee80211_bss_conf *link_conf;
+
+		link_conf = link_conf_dereference_protected(vif, i);
+		if (link_conf &&
+		    rcu_access_pointer(link_conf->chanctx_conf))
+			n_active++;
+	}
+
+	return n_active;
+}
+
+static int iwl_mvm_esr_mode_active(struct iwl_mvm *mvm,
+				   struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	int link_id, ret = 0;
+
+	mvmvif->esr_active = true;
+
+	/* Disable SMPS overrideing by user */
+	vif->driver_flags |= IEEE80211_VIF_DISABLE_SMPS_OVERRIDE;
+
+	iwl_mvm_update_smps_on_active_links(mvm, vif, IWL_MVM_SMPS_REQ_FW,
+					    IEEE80211_SMPS_OFF);
+
+	for_each_mvm_vif_valid_link(mvmvif, link_id) {
+		struct iwl_mvm_vif_link_info *link = mvmvif->link[link_id];
+
+		if (!link->phy_ctxt)
+			continue;
+
+		ret = iwl_mvm_phy_send_rlc(mvm, link->phy_ctxt, 2, 2);
+		if (ret)
+			break;
+
+		link->phy_ctxt->rlc_disabled = true;
+	}
+
+	return ret;
+}
+
 static int
 __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 				 struct ieee80211_vif *vif,
@@ -224,10 +271,18 @@ __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 {
 	u16 *phy_ctxt_id = (u16 *)ctx->drv_priv;
 	struct iwl_mvm_phy_ctxt *phy_ctxt = &mvm->phy_ctxts[*phy_ctxt_id];
+	unsigned int n_active = iwl_mvm_mld_count_active_links(vif);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	unsigned int link_id = link_conf->link_id;
 	int ret;
 
+	/* if the assigned one was not counted yet, count it now */
+	if (!rcu_access_pointer(link_conf->chanctx_conf))
+		n_active++;
+
+	if (n_active > iwl_mvm_max_active_links(mvm, vif))
+		return -EOPNOTSUPP;
+
 	if (WARN_ON_ONCE(!mvmvif->link[link_id]))
 		return -EINVAL;
 
@@ -243,6 +298,15 @@ __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 		}
 	}
 
+	if (iwl_mvm_is_esr_supported(mvm->fwrt.trans) && n_active > 1) {
+		mvmvif->link[link_id]->listen_lmac = true;
+		ret = iwl_mvm_esr_mode_active(mvm, vif);
+		if (ret) {
+			IWL_ERR(mvm, "failed to activate ESR mode (%d)\n", ret);
+			return ret;
+		}
+	}
+
 	mvmvif->link[link_id]->phy_ctxt = phy_ctxt;
 
 	if (switching_chanctx) {
@@ -326,14 +390,62 @@ static int iwl_mvm_mld_assign_vif_chanctx(struct ieee80211_hw *hw,
 	return ret;
 }
 
+static int iwl_mvm_esr_mode_inactive(struct iwl_mvm *mvm,
+				     struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct ieee80211_bss_conf *link_conf;
+	int link_id, ret = 0;
+
+	mvmvif->esr_active = false;
+
+	vif->driver_flags &= ~IEEE80211_VIF_DISABLE_SMPS_OVERRIDE;
+
+	iwl_mvm_update_smps_on_active_links(mvm, vif, IWL_MVM_SMPS_REQ_FW,
+					    IEEE80211_SMPS_AUTOMATIC);
+
+	for_each_vif_active_link(vif, link_conf, link_id) {
+		struct ieee80211_chanctx_conf *chanctx_conf;
+		struct iwl_mvm_phy_ctxt *phy_ctxt;
+		u8 static_chains, dynamic_chains;
+
+		mvmvif->link[link_id]->listen_lmac = false;
+
+		rcu_read_lock();
+
+		chanctx_conf = rcu_dereference(link_conf->chanctx_conf);
+		phy_ctxt = mvmvif->link[link_id]->phy_ctxt;
+
+		if (!chanctx_conf || !phy_ctxt) {
+			rcu_read_unlock();
+			continue;
+		}
+
+		phy_ctxt->rlc_disabled = false;
+		static_chains = chanctx_conf->rx_chains_static;
+		dynamic_chains = chanctx_conf->rx_chains_dynamic;
+
+		rcu_read_unlock();
+
+		ret = iwl_mvm_phy_send_rlc(mvm, phy_ctxt, static_chains,
+					   dynamic_chains);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
 static void
 __iwl_mvm_mld_unassign_vif_chanctx(struct iwl_mvm *mvm,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_bss_conf *link_conf,
 				   struct ieee80211_chanctx_conf *ctx,
 				   bool switching_chanctx)
+
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	unsigned int n_active = iwl_mvm_mld_count_active_links(vif);
 	unsigned int link_id = link_conf->link_id;
 
 	/* shouldn't happen, but verify link_id is valid before accessing */
@@ -352,6 +464,14 @@ __iwl_mvm_mld_unassign_vif_chanctx(struct iwl_mvm *mvm,
 		mvmvif->ap_ibss_active = false;
 	}
 
+	if (iwl_mvm_is_esr_supported(mvm->fwrt.trans) && n_active > 1) {
+		int ret = iwl_mvm_esr_mode_inactive(mvm, vif);
+
+		if (ret)
+			IWL_ERR(mvm, "failed to deactivate ESR mode (%d)\n",
+				ret);
+	}
+
 	if (vif->type == NL80211_IFTYPE_MONITOR)
 		iwl_mvm_mld_rm_snif_sta(mvm, vif);
 
@@ -894,31 +1014,16 @@ iwl_mvm_mld_change_vif_links(struct ieee80211_hw *hw,
 			     struct ieee80211_bss_conf *old[IEEE80211_MLD_MAX_NUM_LINKS])
 {
 	struct iwl_mvm_vif_link_info *new_link[IEEE80211_MLD_MAX_NUM_LINKS] = {};
+	unsigned int n_active = iwl_mvm_mld_count_active_links(vif);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	u16 removed = old_links & ~new_links;
 	u16 added = new_links & ~old_links;
 	int err, i;
 
-	if (hweight16(new_links) > 1) {
-		unsigned int n_active = 0;
-
-		for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
-			struct ieee80211_bss_conf *link_conf;
-
-			link_conf = link_conf_dereference_protected(vif, i);
-			if (link_conf &&
-			    rcu_access_pointer(link_conf->chanctx_conf))
-				n_active++;
-		}
-
-		if (vif->type == NL80211_IFTYPE_AP) {
-			if (n_active > mvm->fw->ucode_capa.num_beacons)
-				return -EOPNOTSUPP;
-		} else if (n_active > iwl_mvm_max_active_links(mvm)) {
-			return -EOPNOTSUPP;
-		}
-	}
+	if (hweight16(new_links) > 1 &&
+	    n_active > iwl_mvm_max_active_links(mvm, vif))
+		return -EOPNOTSUPP;
 
 	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
 		int r;
@@ -962,9 +1067,7 @@ iwl_mvm_mld_change_vif_links(struct ieee80211_hw *hw,
 				goto out_err;
 			kfree(mvmvif->link[i]);
 			mvmvif->link[i] = NULL;
-		}
-
-		if (added & BIT(i)) {
+		} else if (added & BIT(i)) {
 			struct ieee80211_bss_conf *link_conf;
 
 			link_conf = link_conf_dereference_protected(vif, i);
@@ -981,6 +1084,9 @@ iwl_mvm_mld_change_vif_links(struct ieee80211_hw *hw,
 		}
 	}
 
+	if (err)
+		goto out_err;
+
 	err = 0;
 	if (new_links == 0) {
 		mvmvif->link[0] = &mvmvif->deflink;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 35cf0015b362..11de81b58515 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -104,6 +104,7 @@ struct iwl_mvm_phy_ctxt {
 
 	/* track for RLC config command */
 	u32 center_freq1;
+	bool rlc_disabled;
 };
 
 struct iwl_mvm_time_event_data {
@@ -301,6 +302,7 @@ struct iwl_probe_resp_data {
  * @queue_params: QoS params for this MAC
  * @mgmt_queue: queue number for unbufferable management frames
  * @igtk: the current IGTK programmed into the firmware
+ * @listen_lmac: indicates this link is allocated to the listen LMAC
  */
 struct iwl_mvm_vif_link_info {
 	u8 bssid[ETH_ALEN];
@@ -322,6 +324,7 @@ struct iwl_mvm_vif_link_info {
 
 	bool he_ru_2mhz_block;
 	bool active;
+	bool listen_lmac;
 
 	u16 cab_queue;
 	/* Assigned while mac80211 has the link in a channel context,
@@ -373,6 +376,7 @@ struct iwl_mvm_vif {
 	bool ap_ibss_active;
 	bool pm_enabled;
 	bool monitor_active;
+	bool esr_active;
 
 	u8 low_latency: 6;
 	u8 low_latency_actual: 1;
@@ -1554,10 +1558,14 @@ static inline bool iwl_mvm_is_esr_supported(struct iwl_trans *trans)
 	return false;
 }
 
-static inline int iwl_mvm_max_active_links(struct iwl_mvm *mvm)
+static inline int iwl_mvm_max_active_links(struct iwl_mvm *mvm,
+					   struct ieee80211_vif *vif)
 {
 	struct iwl_trans *trans = mvm->fwrt.trans;
 
+	if (vif->type == NL80211_IFTYPE_AP)
+		return mvm->fw->ucode_capa.num_beacons;
+
 	if (iwl_mvm_is_esr_supported(trans) ||
 	    (CSR_HW_RFID_TYPE(trans->hw_rf_id) == IWL_CFG_RF_TYPE_FM &&
 	     CSR_HW_RFID_IS_CDB(trans->hw_rf_id)))
@@ -1777,6 +1785,8 @@ void iwl_mvm_phy_ctxt_unref(struct iwl_mvm *mvm,
 int iwl_mvm_phy_ctx_count(struct iwl_mvm *mvm);
 u8 iwl_mvm_get_channel_width(struct cfg80211_chan_def *chandef);
 u8 iwl_mvm_get_ctrl_pos(struct cfg80211_chan_def *chandef);
+int iwl_mvm_phy_send_rlc(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
+			 u8 chains_static, u8 chains_dynamic);
 
 /* MAC (virtual interface) programming */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
index 55541e90770a..a5b432bc9e2f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2017 Intel Deutschland GmbH
  */
@@ -163,15 +163,18 @@ static void iwl_mvm_phy_ctxt_cmd_data(struct iwl_mvm *mvm,
 					     chains_static, chains_dynamic);
 }
 
-static int iwl_mvm_phy_send_rlc(struct iwl_mvm *mvm,
-				struct iwl_mvm_phy_ctxt *ctxt,
-				u8 chains_static, u8 chains_dynamic)
+int iwl_mvm_phy_send_rlc(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
+			 u8 chains_static, u8 chains_dynamic)
 {
 	struct iwl_rlc_config_cmd cmd = {
 		.phy_id = cpu_to_le32(ctxt->id),
 	};
 
-	if (iwl_fw_lookup_cmd_ver(mvm->fw, WIDE_ID(DATA_PATH_GROUP, RLC_CONFIG_CMD), 0) < 2)
+	if (ctxt->rlc_disabled)
+		return 0;
+
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, WIDE_ID(DATA_PATH_GROUP,
+						   RLC_CONFIG_CMD), 0) < 2)
 		return 0;
 
 	BUILD_BUG_ON(IWL_RLC_CHAIN_INFO_DRIVER_FORCE !=
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 2a10d851d2e4..48016b4343d2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -312,6 +312,10 @@ void iwl_mvm_update_smps(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			smps_mode = IEEE80211_SMPS_DYNAMIC;
 	}
 
+	/* SMPS is disabled in eSR */
+	if (mvmvif->esr_active)
+		smps_mode = IEEE80211_SMPS_OFF;
+
 	ieee80211_request_smps(vif, link_id, smps_mode);
 }
 
-- 
2.38.1

