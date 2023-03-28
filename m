Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFD06CB8F0
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 10:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjC1IAY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 04:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjC1IAS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 04:00:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07C84699
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 01:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990416; x=1711526416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rX7qEvAN6n2L5dDBdbukj3aJgDh8VZ+INkRoWgwGAwg=;
  b=jEPhTWGKADcCA7ghH1Mzh0WDuKRD3/44SKB1COCTKdaclJFrQGOzbM4k
   NGxbo5jU/z2o6Kg6gNujWP/G3rWUHJiXL1CTLYFPpb18GJGvc0cPH6LW/
   ns7vCj2iIecLgTREHdYclds9w59ZdqdSFDD8whCYsYv1GQDvHgo6o/mAg
   VVtVwk5Rb4s4yv9Ua5vO4seb1ypc0cfLgYP4WSX4Tu/ZeLmAUuI7ZhLjU
   ckNdGxVeR/iW4RpzJx6g9/wbdnfJUC+xqElHNiIjILYozU9oxmhSLT8MP
   MSCtx7sYbsTG2wSFtH9kowTIZxZHQGguo4IUIByPEkT/43/GhN3SjC4Fr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958156"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958156"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045161"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045161"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:54 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 15/31] wifi: iwlwifi: mvm: align to the LINK cmd update in the FW
Date:   Tue, 28 Mar 2023 10:58:55 +0300
Message-Id: <20230328104948.78ae716884fe.Icfeb2794d9652baaccf9b0cdddbd751d0db4f952@changeid>
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

The LINK cmd host api has been updated. Align the driver to the
new changes. Also, temporary use mac_id for link_id.
Using the phy_id as the link_id is wrong since we might have 2 macs
operating on the same phy - in this case we will have 2 different
links (one for each mac) with the same link_id. On the other hand,
since we don't have MLO implemented yet, we won't have 2 different
links of the same mac. Therefore, we can use the mac_id as the
link_id.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 17 ++++----
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 22 +++++-----
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 40 +++++++++----------
 3 files changed, 37 insertions(+), 42 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index 3c540aa9c0c8..b644274e4a31 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -383,11 +383,14 @@ enum iwl_link_ctx_protection_flags {
  * @LINK_FLG_RU_2MHZ_BLOCK: indicates that 26-tone RU OFDMA transmission are
  *      not allowed (as there are OBSS that might classify such transmissions as
  *      radar pulses).
+ * @LINK_FLG_NDP_FEEDBACK_ENABLED: mark support for NDP feedback and change
+ *	of threshold
  */
 enum iwl_link_ctx_flags {
 	LINK_FLG_BSS_COLOR_DIS		= BIT(0),
 	LINK_FLG_MU_EDCA_CW		= BIT(1),
 	LINK_FLG_RU_2MHZ_BLOCK		= BIT(2),
+	LINK_FLG_NDP_FEEDBACK_ENABLED	= BIT(3),
 }; /* LINK_CONTEXT_FLAG_E_VER_1 */
 
 /**
@@ -423,13 +426,9 @@ enum iwl_link_ctx_flags {
  * @rand_alloc_ecwmax: random CWmax = 2**ECWmax-1
  * @ndp_fdbk_buff_th_exp: set exponent for the NDP feedback buffered threshold
  * @trig_based_txf: MU EDCA Parameter set for the trigger based traffic queues
- * @dtim_time: DTIM arrival time in system time
- * @dtim_tsf: DTIM arrival time in TSF
- * @assoc_beacon_arrive_time: TSF of first beacon after association
  * @bi: beacon interval in TU, applicable only when associated
  * @dtim_interval: DTIM interval in TU.
  *	Relevant only for GO, otherwise this is offloaded.
- * @beacon_template: beacon template ID. For GO only
  * @puncture_mask: puncture mask for EHT
  * @frame_time_rts_th: HE duration RTS threshold, in units of 32us
  * @flags: a combination from &enum iwl_link_ctx_flags
@@ -440,6 +439,9 @@ enum iwl_link_ctx_flags {
  * @bssid_index: index of the associated VAP
  * @bss_color: 11ax AP ID that is used in the HE SIG-A to mark inter BSS frame
  * @reserved: alignment
+ * @ibss_bssid_addr: bssid for ibss
+ * @reserved_for_ibss_bssid_addr: reserved
+ * @reserved1: reserved for future use
  */
 struct iwl_link_config_cmd {
 	__le32 action;
@@ -464,12 +466,8 @@ struct iwl_link_config_cmd {
 	u8 rand_alloc_ecwmax;
 	u8 ndp_fdbk_buff_th_exp;
 	struct iwl_he_backoff_conf trig_based_txf[AC_NUM];
-	__le32 dtim_time;
-	__le64 dtim_tsf;
-	__le32 assoc_beacon_arrive_time;
 	__le32 bi;
 	__le32 dtim_interval;
-	__le32 beacon_template;
 	__le16 puncture_mask;
 	__le16 frame_time_rts_th;
 	__le32 flags;
@@ -480,6 +478,9 @@ struct iwl_link_config_cmd {
 	u8 bssid_index;
 	u8 bss_color;
 	u8 reserved[2];
+	u8 ibss_bssid_addr[6];
+	__le16 reserved_for_ibss_bssid_addr;
+	__le32 reserved1[8];
 } __packed; /* LINK_CONTEXT_CONFIG_CMD_API_S_VER_1 */
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 21e45f89c5f9..4905dac3a048 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -34,12 +34,15 @@ int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	if (iwl_mvm_sf_update(mvm, vif, false))
 		return -EINVAL;
 
-	cmd.link_id = cpu_to_le32(mvmvif->deflink.phy_ctxt->id);
+	cmd.link_id = cpu_to_le32(mvmvif->id);
 	cmd.mac_id = cpu_to_le32(mvmvif->id);
 	cmd.phy_id = cpu_to_le32(mvmvif->deflink.phy_ctxt->id);
 
 	memcpy(cmd.local_link_addr, vif->addr, ETH_ALEN);
 
+	if (vif->type == NL80211_IFTYPE_ADHOC && vif->bss_conf.bssid)
+		memcpy(cmd.ibss_bssid_addr, vif->bss_conf.bssid, ETH_ALEN);
+
 	return iwl_mvm_link_cmd_send(mvm, &cmd, FW_CTXT_ACTION_ADD);
 }
 
@@ -54,7 +57,7 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (!phyctxt)
 		return -EINVAL;
 
-	cmd.link_id = cpu_to_le32(phyctxt->id);
+	cmd.link_id = cpu_to_le32(mvmvif->id);
 
 	/* The phy_id, link address and listen_lmac can be modified only until
 	 * the link becomes active, otherwise they will be ignored.
@@ -66,6 +69,9 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	cmd.active = cpu_to_le32(active);
 
+	if (vif->type == NL80211_IFTYPE_ADHOC && vif->bss_conf.bssid)
+		memcpy(cmd.ibss_bssid_addr, vif->bss_conf.bssid, ETH_ALEN);
+
 	/* TODO: set a value to cmd.listen_lmac when system requiremens
 	 * will define it
 	 */
@@ -82,21 +88,11 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	iwl_mvm_set_fw_qos_params(mvm, vif, &cmd.ac[0], &cmd.qos_flags);
 
-	/* We need the dtim_period to set the MAC as associated */
-	if (vif->cfg.assoc && vif->bss_conf.dtim_period)
-		iwl_mvm_set_fw_dtim_tbtt(mvm, vif, &cmd.dtim_tsf,
-					 &cmd.dtim_time,
-					 &cmd.assoc_beacon_arrive_time);
-	else
-		changes &= ~LINK_CONTEXT_MODIFY_BEACON_TIMING;
 
 	cmd.bi = cpu_to_le32(vif->bss_conf.beacon_int);
 	cmd.dtim_interval = cpu_to_le32(vif->bss_conf.beacon_int *
 					vif->bss_conf.dtim_period);
 
-	/* TODO: Assumes that the beacon id == mac context id */
-	cmd.beacon_template = cpu_to_le32(mvmvif->id);
-
 	if (!vif->bss_conf.he_support || iwlwifi_mod_params.disable_11ax ||
 	    !vif->cfg.assoc) {
 		changes &= ~LINK_CONTEXT_MODIFY_HE_PARAMS;
@@ -164,7 +160,7 @@ int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	if (WARN_ON_ONCE(!mvmvif->deflink.phy_ctxt))
 		return -EINVAL;
 
-	cmd.link_id = cpu_to_le32(mvmvif->deflink.phy_ctxt->id);
+	cmd.link_id = cpu_to_le32(mvmvif->id);
 	ret = iwl_mvm_link_cmd_send(mvm, &cmd, FW_CTXT_ACTION_REMOVE);
 
 	if (!ret)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 41f6be7fe75e..1608ac371bb0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -22,7 +22,7 @@ static int iwl_mvm_mld_send_sta_cmd(struct iwl_mvm *mvm,
 static int iwl_mvm_mld_add_int_sta_to_fw(struct iwl_mvm *mvm,
 					 struct iwl_mvm_int_sta *sta,
 					 const u8 *addr,
-					 u16 phy_id)
+					 u16 mac_id)
 {
 	struct iwl_mvm_sta_cfg_cmd cmd;
 
@@ -31,7 +31,7 @@ static int iwl_mvm_mld_add_int_sta_to_fw(struct iwl_mvm *mvm,
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.sta_id = cpu_to_le32((u8)sta->sta_id);
 
-	cmd.link_id = cpu_to_le32(phy_id);
+	cmd.link_id = cpu_to_le32(mac_id);
 
 	cmd.station_type = cpu_to_le32(sta->type);
 
@@ -98,7 +98,7 @@ static int iwl_mvm_add_aux_sta_to_fw(struct iwl_mvm *mvm,
  */
 static int iwl_mvm_mld_add_int_sta_with_queue(struct iwl_mvm *mvm,
 					      struct iwl_mvm_int_sta *sta,
-					      const u8 *addr, int phy_id,
+					      const u8 *addr, int mac_id,
 					      u16 *queue, u8 tid,
 					      unsigned int *_wdg_timeout)
 {
@@ -110,9 +110,9 @@ static int iwl_mvm_mld_add_int_sta_with_queue(struct iwl_mvm *mvm,
 		return -ENOSPC;
 
 	if (sta->type == STATION_TYPE_AUX)
-		ret = iwl_mvm_add_aux_sta_to_fw(mvm, sta, phy_id);
+		ret = iwl_mvm_add_aux_sta_to_fw(mvm, sta, mac_id);
 	else
-		ret = iwl_mvm_mld_add_int_sta_to_fw(mvm, sta, addr, phy_id);
+		ret = iwl_mvm_mld_add_int_sta_to_fw(mvm, sta, addr, mac_id);
 	if (ret)
 		return ret;
 
@@ -139,7 +139,7 @@ static int iwl_mvm_mld_add_int_sta(struct iwl_mvm *mvm,
 				   struct iwl_mvm_int_sta *int_sta, u16 *queue,
 				   enum nl80211_iftype iftype,
 				   enum iwl_fw_sta_type sta_type,
-				   int phy_id, const u8 *addr, u8 tid,
+				   int mac_id, const u8 *addr, u8 tid,
 				   unsigned int *wdg_timeout)
 {
 	int ret;
@@ -152,7 +152,7 @@ static int iwl_mvm_mld_add_int_sta(struct iwl_mvm *mvm,
 	if (ret)
 		return ret;
 
-	ret = iwl_mvm_mld_add_int_sta_with_queue(mvm, int_sta, addr, phy_id,
+	ret = iwl_mvm_mld_add_int_sta_with_queue(mvm, int_sta, addr, mac_id,
 						 queue, tid, wdg_timeout);
 	if (ret) {
 		iwl_mvm_dealloc_int_sta(mvm, int_sta);
@@ -194,8 +194,8 @@ int iwl_mvm_mld_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	return iwl_mvm_mld_add_int_sta(mvm, bsta, queue,
 				       ieee80211_vif_type_p2p(vif),
 				       STATION_TYPE_BCAST_MGMT,
-				       mvmvif->deflink.phy_ctxt->id, baddr,
-				       IWL_MAX_TID_COUNT, &wdg_timeout);
+				       mvmvif->id, baddr, IWL_MAX_TID_COUNT,
+				       &wdg_timeout);
 }
 
 /* Allocate a new station entry for the broadcast station to the given vif,
@@ -226,8 +226,7 @@ int iwl_mvm_mld_add_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 
 	return iwl_mvm_mld_add_int_sta(mvm, msta, &mvmvif->deflink.cab_queue,
 				       vif->type, STATION_TYPE_MCAST,
-				       mvmvif->deflink.phy_ctxt->id, maddr, 0,
-				       &timeout);
+				       mvmvif->id, maddr, 0, &timeout);
 }
 
 /* Allocate a new station entry for the sniffer station to the given vif,
@@ -241,8 +240,8 @@ int iwl_mvm_mld_add_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 
 	return iwl_mvm_mld_add_int_sta(mvm, &mvm->snif_sta, &mvm->snif_queue,
 				       vif->type, STATION_TYPE_BCAST_MGMT,
-				       mvmvif->deflink.phy_ctxt->id, NULL,
-				       IWL_MAX_TID_COUNT, NULL);
+				       mvmvif->id, NULL, IWL_MAX_TID_COUNT,
+				       NULL);
 }
 
 int iwl_mvm_mld_add_aux_sta(struct iwl_mvm *mvm, u32 lmac_id)
@@ -250,7 +249,7 @@ int iwl_mvm_mld_add_aux_sta(struct iwl_mvm *mvm, u32 lmac_id)
 	lockdep_assert_held(&mvm->mutex);
 
 	/* In CDB NICs we need to specify which lmac to use for aux activity
-	 * using the phy_id argument place to send lmac_id to the function
+	 * using the mac_id argument place to send lmac_id to the function
 	 */
 	return iwl_mvm_mld_add_int_sta(mvm, &mvm->aux_sta, &mvm->aux_queue,
 				       NL80211_IFTYPE_UNSPECIFIED,
@@ -368,12 +367,13 @@ int iwl_mvm_mld_rm_aux_sta(struct iwl_mvm *mvm)
 
 /* send a cfg sta command to add/update a sta in firmware */
 static int iwl_mvm_mld_cfg_sta(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
-			       struct ieee80211_vif *vif, u16 phy_id)
+			       struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_sta_cfg_cmd cmd = {
 		.sta_id = cpu_to_le32(mvm_sta->deflink.sta_id),
-		.link_id = cpu_to_le32(phy_id),
+		.link_id = cpu_to_le32(mvmvif->id),
 		.station_type = cpu_to_le32(mvm_sta->sta_type),
 		.mfp = cpu_to_le32(sta->mfp),
 	};
@@ -472,7 +472,7 @@ int iwl_mvm_mld_add_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		 */
 		ret = iwl_mvm_mld_add_int_sta_to_fw(mvm, &tmp_sta,
 						    vif->bss_conf.bssid,
-						    mvmvif->deflink.phy_ctxt->id);
+						    mvmvif->id);
 		if (ret)
 			return ret;
 
@@ -482,7 +482,7 @@ int iwl_mvm_mld_add_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 				       STATION_TYPE_PEER);
 	}
 
-	ret = iwl_mvm_mld_cfg_sta(mvm, sta, vif, mvmvif->deflink.phy_ctxt->id);
+	ret = iwl_mvm_mld_cfg_sta(mvm, sta, vif);
 	if (ret)
 		return ret;
 
@@ -503,11 +503,9 @@ int iwl_mvm_mld_add_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 int iwl_mvm_mld_update_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta)
 {
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-
 	lockdep_assert_held(&mvm->mutex);
 
-	return iwl_mvm_mld_cfg_sta(mvm, sta, vif, mvmvif->deflink.phy_ctxt->id);
+	return iwl_mvm_mld_cfg_sta(mvm, sta, vif);
 }
 
 static void iwl_mvm_mld_disable_sta_queues(struct iwl_mvm *mvm,
-- 
2.38.1

