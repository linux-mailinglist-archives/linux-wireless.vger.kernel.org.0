Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20776CB8F2
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 10:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjC1IA0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 04:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjC1IAU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 04:00:20 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E167423F
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 01:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990418; x=1711526418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QTuTpzPu3YlxAHevRmGlun0cSJndIks0EeaujUvlOiU=;
  b=PhwbX5lgm3ugtZLXzt99BHBGiL1ybrOUDwwvZSOO/me0lHyvARpydya2
   RLNt175IVjzYDj6osQM3Mw1RvZuuWdWQMcaKooO1IQr1PMA5GXpBPLBhx
   OlHC2SEyE0AVluZnDdAoNnO9fft33ey/p7swlCvl03dFdc0ZbrmtvFkUI
   fi8k2PuOkdfCH6fB5wu0xoQAImR63jcR5ZAfeC2UZG7sZ+gb7OCz65dhv
   2cTY578LN52n+X1MenVToTGeVk5+7zEtSO5wZv0NIGaVKj0HH3hjFn6ze
   PrWSULXuNQjNYJt2Cv3ftOOR6rs2KeYMkHKV7/1lEYrfMLSOb3K5NLphA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958229"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958229"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 01:00:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045272"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045272"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 01:00:06 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 21/31] wifi: iwlwifi: mvm: adjust SMPS for MLO
Date:   Tue, 28 Mar 2023 10:59:01 +0300
Message-Id: <20230328104949.da6a19db562c.Ic88b02338c8973f2934439ac3ee77c7451bc0054@changeid>
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

From: Gregory Greenman <gregory.greenman@intel.com>

Configure SMPS per-link. Add link_id parameter to
iwl_mvm_update_smps() and refactor iwl_mvm_intf_dual_chain_req()
since it has to handle all active links.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c |  4 +--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 19 +++++++-----
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  4 +--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 19 ++++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 23 +++++++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |  4 +--
 .../net/wireless/intel/iwlwifi/mvm/utils.c    | 29 +++++++++++++++----
 7 files changed, 73 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
index 21ba3c7dd9b4..daaa173aaed6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
@@ -291,7 +291,7 @@ static void iwl_mvm_bt_notif_iterator(void *_data, u8 *mac,
 		if (vif->type == NL80211_IFTYPE_STATION) {
 			/* ... relax constraints and disable rssi events */
 			iwl_mvm_update_smps(mvm, vif, IWL_MVM_SMPS_REQ_BT_COEX,
-					    smps_mode);
+					    smps_mode, 0);
 			iwl_mvm_bt_coex_reduced_txp(mvm,
 						    mvmvif->deflink.ap_sta_id,
 						    false);
@@ -325,7 +325,7 @@ static void iwl_mvm_bt_notif_iterator(void *_data, u8 *mac,
 
 	if (vif->type == NL80211_IFTYPE_STATION)
 		iwl_mvm_update_smps(mvm, vif, IWL_MVM_SMPS_REQ_BT_COEX,
-				    smps_mode);
+				    smps_mode, 0);
 
 	/* low latency is always primary */
 	if (iwl_mvm_vif_low_latency(mvmvif)) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 4dbc9a57746b..ef3eb57b806a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2481,17 +2481,19 @@ void iwl_mvm_bss_info_changed_station_assoc(struct iwl_mvm *mvm,
 	mvmvif->bf_data.ave_beacon_signal = 0;
 
 	iwl_mvm_bt_coex_vif_change(mvm);
-	iwl_mvm_update_smps(mvm, vif, IWL_MVM_SMPS_REQ_TT,
-			    IEEE80211_SMPS_AUTOMATIC);
+	iwl_mvm_update_smps_on_active_links(mvm, vif, IWL_MVM_SMPS_REQ_TT,
+					    IEEE80211_SMPS_AUTOMATIC);
 	if (fw_has_capa(&mvm->fw->ucode_capa,
 			IWL_UCODE_TLV_CAPA_UMAC_SCAN))
 		iwl_mvm_config_scan(mvm);
 }
 
 /* Execute the common part for MLD and non-MLD modes */
-void iwl_mvm_bss_info_changed_station_common(struct iwl_mvm *mvm,
-					     struct ieee80211_vif *vif,
-					     u64 changes)
+void
+iwl_mvm_bss_info_changed_station_common(struct iwl_mvm *mvm,
+					struct ieee80211_vif *vif,
+					struct ieee80211_bss_conf *link_conf,
+					u64 changes)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	int ret;
@@ -2529,7 +2531,7 @@ void iwl_mvm_bss_info_changed_station_common(struct iwl_mvm *mvm,
 	}
 
 	if (changes & BSS_CHANGED_BANDWIDTH)
-		iwl_mvm_apply_fw_smps_request(vif);
+		iwl_mvm_update_link_smps(vif, link_conf);
 }
 
 static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
@@ -2641,7 +2643,7 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 			if (vif->p2p) {
 				iwl_mvm_update_smps(mvm, vif,
 						    IWL_MVM_SMPS_REQ_PROT,
-						    IEEE80211_SMPS_DYNAMIC);
+						    IEEE80211_SMPS_DYNAMIC, 0);
 			}
 		} else if (mvmvif->deflink.ap_sta_id != IWL_MVM_INVALID_STA) {
 			iwl_mvm_mei_host_disassociated(mvm);
@@ -2697,7 +2699,8 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 		iwl_mvm_bss_info_changed_station_assoc(mvm, vif, changes);
 	}
 
-	iwl_mvm_bss_info_changed_station_common(mvm, vif, changes);
+	iwl_mvm_bss_info_changed_station_common(mvm, vif, &vif->bss_conf,
+						changes);
 }
 
 bool iwl_mvm_start_ap_ibss_common(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 15beed41b305..80f1a1ccf16d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -516,7 +516,7 @@ iwl_mvm_mld_bss_info_changed_station(struct iwl_mvm *mvm,
 			if (vif->p2p) {
 				iwl_mvm_update_smps(mvm, vif,
 						    IWL_MVM_SMPS_REQ_PROT,
-						    IEEE80211_SMPS_DYNAMIC);
+						    IEEE80211_SMPS_DYNAMIC, 0);
 			}
 		} else if (mvmvif->deflink.ap_sta_id != IWL_MVM_INVALID_STA) {
 			iwl_mvm_mei_host_disassociated(mvm);
@@ -557,7 +557,7 @@ iwl_mvm_mld_bss_info_changed_station(struct iwl_mvm *mvm,
 		iwl_mvm_bss_info_changed_station_assoc(mvm, vif, changes);
 	}
 
-	iwl_mvm_bss_info_changed_station_common(mvm, vif, changes);
+	iwl_mvm_bss_info_changed_station_common(mvm, vif, &vif->bss_conf, changes);
 }
 
 static void
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 9b04ae9c41ff..d62341269744 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1841,9 +1841,11 @@ iwl_mvm_bss_info_changed_common(struct ieee80211_hw *hw,
 				struct ieee80211_bss_conf *bss_conf,
 				struct iwl_mvm_bss_info_changed_ops *callbacks,
 				u64 changes);
-void iwl_mvm_bss_info_changed_station_common(struct iwl_mvm *mvm,
-					     struct ieee80211_vif *vif,
-					     u64 changes);
+void
+iwl_mvm_bss_info_changed_station_common(struct iwl_mvm *mvm,
+					struct ieee80211_vif *vif,
+					struct ieee80211_bss_conf *link_conf,
+					u64 changes);
 void iwl_mvm_bss_info_changed_station_assoc(struct iwl_mvm *mvm,
 					    struct ieee80211_vif *vif,
 					    u64 changes);
@@ -2057,10 +2059,17 @@ int iwl_mvm_disable_beacon_filter(struct iwl_mvm *mvm,
 /* SMPS */
 void iwl_mvm_update_smps(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 				enum iwl_mvm_smps_type_request req_type,
-				enum ieee80211_smps_mode smps_request);
+				enum ieee80211_smps_mode smps_request,
+				unsigned int link_id);
+void
+iwl_mvm_update_smps_on_active_links(struct iwl_mvm *mvm,
+				    struct ieee80211_vif *vif,
+				    enum iwl_mvm_smps_type_request req_type,
+				    enum ieee80211_smps_mode smps_request);
 bool iwl_mvm_rx_diversity_allowed(struct iwl_mvm *mvm,
 				  struct iwl_mvm_phy_ctxt *ctxt);
-void iwl_mvm_apply_fw_smps_request(struct ieee80211_vif *vif);
+void iwl_mvm_update_link_smps(struct ieee80211_vif *vif,
+			      struct ieee80211_bss_conf *link_conf);
 
 /* Low latency */
 int iwl_mvm_update_low_latency(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index b355b9ebad0a..4a679ac132c5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -209,24 +209,37 @@ static void iwl_mvm_rx_monitor_notif(struct iwl_mvm *mvm,
 	ieee80211_disconnect(vif, true);
 }
 
-void iwl_mvm_apply_fw_smps_request(struct ieee80211_vif *vif)
+void iwl_mvm_update_link_smps(struct ieee80211_vif *vif,
+			      struct ieee80211_bss_conf *link_conf)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm *mvm = mvmvif->mvm;
 	enum ieee80211_smps_mode mode = IEEE80211_SMPS_AUTOMATIC;
 
+	if (!link_conf)
+		return;
+
 	if (mvm->fw_static_smps_request &&
-	    vif->bss_conf.chandef.width == NL80211_CHAN_WIDTH_160 &&
-	    vif->bss_conf.he_support)
+	    link_conf->chandef.width == NL80211_CHAN_WIDTH_160 &&
+	    link_conf->he_support)
 		mode = IEEE80211_SMPS_STATIC;
 
-	iwl_mvm_update_smps(mvm, vif, IWL_MVM_SMPS_REQ_FW, mode);
+	iwl_mvm_update_smps(mvm, vif, IWL_MVM_SMPS_REQ_FW, mode,
+			    link_conf->link_id);
 }
 
 static void iwl_mvm_intf_dual_chain_req(void *data, u8 *mac,
 					struct ieee80211_vif *vif)
 {
-	iwl_mvm_apply_fw_smps_request(vif);
+	struct ieee80211_bss_conf *link_conf;
+	unsigned int link_id;
+
+	rcu_read_lock();
+
+	for_each_vif_active_link(vif, link_conf, link_id)
+		iwl_mvm_update_link_smps(vif, link_conf);
+
+	rcu_read_unlock();
 }
 
 static void iwl_mvm_rx_thermal_dual_chain_req(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index 232c200af38f..4d0e161a92e0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2019-2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2019-2022 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2016 Intel Deutschland GmbH
  */
@@ -334,7 +334,7 @@ static void iwl_mvm_tt_smps_iterator(void *_data, u8 *mac,
 	if (vif->type != NL80211_IFTYPE_STATION)
 		return;
 
-	iwl_mvm_update_smps(mvm, vif, IWL_MVM_SMPS_REQ_TT, smps_mode);
+	iwl_mvm_update_smps(mvm, vif, IWL_MVM_SMPS_REQ_TT, smps_mode, 0);
 }
 
 static void iwl_mvm_tt_tx_protection(struct iwl_mvm *mvm, bool enable)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 026856c8f5f2..cf72b9377411 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -272,13 +272,15 @@ int iwl_mvm_send_lq_cmd(struct iwl_mvm *mvm, struct iwl_lq_cmd *lq)
  * @vif: Pointer to the ieee80211_vif structure
  * @req_type: The part of the driver who call for a change.
  * @smps_request: The request to change the SMPS mode.
+ * @link_id: for MLO link_id, otherwise 0 (deflink)
  *
  * Get a requst to change the SMPS mode,
  * and change it according to all other requests in the driver.
  */
 void iwl_mvm_update_smps(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			 enum iwl_mvm_smps_type_request req_type,
-			 enum ieee80211_smps_mode smps_request)
+			 enum ieee80211_smps_mode smps_request,
+			 unsigned int link_id)
 {
 	struct iwl_mvm_vif *mvmvif;
 	enum ieee80211_smps_mode smps_mode = IEEE80211_SMPS_AUTOMATIC;
@@ -294,17 +296,34 @@ void iwl_mvm_update_smps(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		return;
 
 	mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	mvmvif->deflink.smps_requests[req_type] = smps_request;
+	mvmvif->link[link_id]->smps_requests[req_type] = smps_request;
 	for (i = 0; i < NUM_IWL_MVM_SMPS_REQ; i++) {
-		if (mvmvif->deflink.smps_requests[i] == IEEE80211_SMPS_STATIC) {
+		if (mvmvif->link[link_id]->smps_requests[i] ==
+		    IEEE80211_SMPS_STATIC) {
 			smps_mode = IEEE80211_SMPS_STATIC;
 			break;
 		}
-		if (mvmvif->deflink.smps_requests[i] == IEEE80211_SMPS_DYNAMIC)
+		if (mvmvif->link[link_id]->smps_requests[i] ==
+		    IEEE80211_SMPS_DYNAMIC)
 			smps_mode = IEEE80211_SMPS_DYNAMIC;
 	}
 
-	ieee80211_request_smps(vif, 0, smps_mode);
+	ieee80211_request_smps(vif, link_id, smps_mode);
+}
+
+void iwl_mvm_update_smps_on_active_links(struct iwl_mvm *mvm,
+					 struct ieee80211_vif *vif,
+					 enum iwl_mvm_smps_type_request req_type,
+					 enum ieee80211_smps_mode smps_request)
+{
+	struct ieee80211_bss_conf *link_conf;
+	unsigned int link_id;
+
+	rcu_read_lock();
+	for_each_vif_active_link(vif, link_conf, link_id)
+		iwl_mvm_update_smps(mvm, vif, req_type, smps_request,
+				    link_id);
+	rcu_read_unlock();
 }
 
 static bool iwl_wait_stats_complete(struct iwl_notif_wait_data *notif_wait,
-- 
2.38.1

