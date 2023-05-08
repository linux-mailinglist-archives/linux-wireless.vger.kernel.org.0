Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3646FA22B
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 10:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjEHIZh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 04:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbjEHIZS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 04:25:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA721C0C4
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 01:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683534311; x=1715070311;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XXdOgtbXCh1UoerYxEFtuJ9BxqSqNoo2U9v098KV7KA=;
  b=HbaDYvjzP/3SVipLP5OVZGAAwM/eMff6xKDfNFwndUKDG18qXJGsD82Q
   ews9QuJuPkqecdeNeq6WWtXBZ8H6202mn5DwXlOm2LREL7FsUB2GR2K0x
   aOBkP7a6vGKb/gYcgnI0pIk6lqySa0gmw9stnAPn+2jLGQzs3Sdzs8UVJ
   JX0uI/pmH3XIQ+i+esEBZ50ICDzhkpPiZIjxJcBNKOEyKdTtpkvp/k6AD
   P2R5HR2xOK6GQISP2QCXlhvoFYUOZpA307ZaYIhcjs17n7EiBh0U/vmwe
   GazRU+VtI3y+UKD2RN0KMHtfvOO+c9fNooaXjqOERVOpGpQPCNJH09mE+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="329949906"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="329949906"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:25:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="767982671"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="767982671"
Received: from shemert-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.224.248])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:25:05 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/14] wifi: iwlwifi: mvm: update the FW apis for LINK and MAC commands
Date:   Mon,  8 May 2023 11:24:30 +0300
Message-Id: <20230508082433.1349733-12-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230508082433.1349733-1-gregory.greenman@intel.com>
References: <20230508082433.1349733-1-gregory.greenman@intel.com>
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

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The firmware added new fields to be able to pass the link_id as the AP
knows it and the esr_transition_timeout.
For now, pass only the link_id since we don't have access to the
esr_transition_timeout yet.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 29 ++++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  1 +
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 14 ++++-----
 .../net/wireless/intel/iwlwifi/mvm/mld-mac.c  | 10 +++----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  4 +--
 5 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index 74f2efbad34e..edf9ac52a681 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -211,17 +211,30 @@ struct iwl_mac_low_latency_cmd {
  * struct iwl_mac_client_data - configuration data for client MAC context
  *
  * @is_assoc: 1 for associated state, 0 otherwise
+ * @esr_transition_timeout: the timeout required by the AP for the
+ *	eSR transition.
+ *	Available only from version 2 of the command.
+ *	This values comes from the EMLSR transition delay in the EML
+ *	Capabilities subfield.
+ * @reserved: alignment
  * @assoc_id: unique ID assigned by the AP during association
+ * @reserved1: alignment
  * @data_policy: see &enum iwl_mac_data_policy
+ * @reserved2: alignment
  * @ctwin: client traffic window in TU (period after TBTT when GO is present).
  *	0 indicates that there is no CT window.
  */
 struct iwl_mac_client_data {
-	__le32 is_assoc;
-	__le32 assoc_id;
-	__le32 data_policy;
+	u8 is_assoc;
+	u8 esr_transition_timeout;
+	__le16 reserved;
+
+	__le16 assoc_id;
+	__le16 reserved1;
+	__le16 data_policy;
+	__le16 reserved2;
 	__le32 ctwin;
-} __packed; /* MAC_CONTEXT_CONFIG_CLIENT_DATA_API_S_VER_1 */
+} __packed; /* MAC_CONTEXT_CONFIG_CLIENT_DATA_API_S_VER_2 */
 
 /**
  * struct iwl_mac_p2p_dev_data  - configuration data for P2P device MAC context
@@ -292,12 +305,12 @@ struct iwl_mac_config_cmd {
 	__le16 he_ap_support;
 	__le32 eht_support;
 	__le32 nic_not_ack_enabled;
-	/* MAC_CONTEXT_CONFIG_SPECIFIC_DATA_API_U_VER_1 */
+	/* MAC_CONTEXT_CONFIG_SPECIFIC_DATA_API_U_VER_2 */
 	union {
 		struct iwl_mac_client_data client;
 		struct iwl_mac_p2p_dev_data p2p_dev;
 	};
-} __packed; /* MAC_CONTEXT_CONFIG_CMD_API_S_VER_1 */
+} __packed; /* MAC_CONTEXT_CONFIG_CMD_API_S_VER_2 */
 
 /**
  * enum iwl_link_ctx_modify_flags - indicate to the fw what fields are being
@@ -430,6 +443,7 @@ enum iwl_link_ctx_flags {
  * @reserved_for_ref_bssid_addr: reserved
  * @bssid_index: index of the associated VAP
  * @bss_color: 11ax AP ID that is used in the HE SIG-A to mark inter BSS frame
+ * @spec_link_id: link_id as the AP knows it
  * @reserved: alignment
  * @ibss_bssid_addr: bssid for ibss
  * @reserved_for_ibss_bssid_addr: reserved
@@ -469,7 +483,8 @@ struct iwl_link_config_cmd {
 	__le16 reserved_for_ref_bssid_addr;
 	u8 bssid_index;
 	u8 bss_color;
-	u8 reserved[2];
+	u8 spec_link_id;
+	u8 reserved;
 	u8 ibss_bssid_addr[6];
 	__le16 reserved_for_ibss_bssid_addr;
 	__le32 reserved1[8];
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index c94aca398789..a1d31c6eab2c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -76,6 +76,7 @@ int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	cmd.link_id = cpu_to_le32(link_info->fw_link_id);
 	cmd.mac_id = cpu_to_le32(mvmvif->id);
+	cmd.spec_link_id = link_conf->link_id;
 	/* P2P-Device already has a valid PHY context during add */
 	phyctxt = link_info->phy_ctxt;
 	if (phyctxt)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 0ecf4159e139..f049ef6a8707 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -629,17 +629,17 @@ __le32 iwl_mvm_mac_ctxt_cmd_p2p_sta_get_oppps_ctwin(struct iwl_mvm *mvm,
 			IEEE80211_P2P_OPPPS_CTWINDOW_MASK);
 }
 
-__le32 iwl_mvm_mac_ctxt_cmd_sta_get_twt_policy(struct iwl_mvm *mvm,
-					       struct ieee80211_vif *vif)
+u32 iwl_mvm_mac_ctxt_cmd_sta_get_twt_policy(struct iwl_mvm *mvm,
+					    struct ieee80211_vif *vif)
 {
-	__le32 twt_policy = cpu_to_le32(0);
+	u32 twt_policy = 0;
 
 	if (vif->bss_conf.twt_requester && IWL_MVM_USE_TWT)
-		twt_policy |= cpu_to_le32(TWT_SUPPORTED);
+		twt_policy |= TWT_SUPPORTED;
 	if (vif->bss_conf.twt_protected)
-		twt_policy |= cpu_to_le32(PROTECTED_TWT_SUPPORTED);
+		twt_policy |= PROTECTED_TWT_SUPPORTED;
 	if (vif->bss_conf.twt_broadcast)
-		twt_policy |= cpu_to_le32(BROADCAST_TWT_SUPPORTED);
+		twt_policy |= BROADCAST_TWT_SUPPORTED;
 
 	return twt_policy;
 }
@@ -711,7 +711,7 @@ static int iwl_mvm_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
 	if (vif->bss_conf.he_support && !iwlwifi_mod_params.disable_11ax) {
 		cmd.filter_flags |= cpu_to_le32(MAC_FILTER_IN_11AX);
 		ctxt_sta->data_policy |=
-			iwl_mvm_mac_ctxt_cmd_sta_get_twt_policy(mvm, vif);
+			cpu_to_le32(iwl_mvm_mac_ctxt_cmd_sta_get_twt_policy(mvm, vif));
 	}
 
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
index 1717fb52dc12..99bf71a2b690 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
@@ -115,16 +115,16 @@ static int iwl_mvm_mld_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
 	if (vif->cfg.assoc && !force_assoc_off) {
 		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
-		cmd.client.is_assoc = cpu_to_le32(1);
+		cmd.client.is_assoc = 1;
 
 		if (!mvmvif->authorized &&
 		    fw_has_capa(&mvm->fw->ucode_capa,
 				IWL_UCODE_TLV_CAPA_COEX_HIGH_PRIO))
 			cmd.client.data_policy |=
-				cpu_to_le32(COEX_HIGH_PRIORITY_ENABLE);
+				cpu_to_le16(COEX_HIGH_PRIORITY_ENABLE);
 
 	} else {
-		cmd.client.is_assoc = cpu_to_le32(0);
+		cmd.client.is_assoc = 0;
 
 		/* Allow beacons to pass through as long as we are not
 		 * associated, or we do not have dtim period information.
@@ -132,14 +132,14 @@ static int iwl_mvm_mld_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
 		cmd.filter_flags |= cpu_to_le32(MAC_CFG_FILTER_ACCEPT_BEACON);
 	}
 
-	cmd.client.assoc_id = cpu_to_le32(vif->cfg.aid);
+	cmd.client.assoc_id = cpu_to_le16(vif->cfg.aid);
 
 	if (vif->probe_req_reg && vif->cfg.assoc && vif->p2p)
 		cmd.filter_flags |= cpu_to_le32(MAC_CFG_FILTER_ACCEPT_PROBE_REQ);
 
 	if (vif->bss_conf.he_support && !iwlwifi_mod_params.disable_11ax)
 		cmd.client.data_policy |=
-			iwl_mvm_mac_ctxt_cmd_sta_get_twt_policy(mvm, vif);
+			cpu_to_le16(iwl_mvm_mac_ctxt_cmd_sta_get_twt_policy(mvm, vif));
 
 	return iwl_mvm_mld_mac_ctxt_send_cmd(mvm, &cmd);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 5f7469cfd092..bba3acd64131 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1789,8 +1789,8 @@ void iwl_mvm_mac_ctxt_cmd_ap_set_filter_flags(struct iwl_mvm *mvm,
 int iwl_mvm_get_mac_type(struct ieee80211_vif *vif);
 __le32 iwl_mvm_mac_ctxt_cmd_p2p_sta_get_oppps_ctwin(struct iwl_mvm *mvm,
 						    struct ieee80211_vif *vif);
-__le32 iwl_mvm_mac_ctxt_cmd_sta_get_twt_policy(struct iwl_mvm *mvm,
-					       struct ieee80211_vif *vif);
+u32 iwl_mvm_mac_ctxt_cmd_sta_get_twt_policy(struct iwl_mvm *mvm,
+					    struct ieee80211_vif *vif);
 int iwl_mvm_mld_mac_ctxt_add(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 int iwl_mvm_mld_mac_ctxt_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 				 bool force_assoc_off);
-- 
2.38.1

