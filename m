Return-Path: <linux-wireless+bounces-14602-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E819B2F6A
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 12:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CAF31C21347
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 11:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA231DA617;
	Mon, 28 Oct 2024 11:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V9iIIRZF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2448D1DA0ED
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 11:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116539; cv=none; b=chfENPqsMYJP1Xuu7yd88kg7dFOoBnzAZZIiqrMCz3VSwxAqe7Gd935ycAgvQbHQj4++yUpT5Qqz//5w7K8nl7vmkwFsXtTgd3sb0Jw960SVhVsEgCMm6aBmji1GhgfbXRU97ir7w3Sp+0jxh8Sg7ecIwZlpNZ0lgvleQbtyYno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116539; c=relaxed/simple;
	bh=Ba91/jtCBvQX+Fc4ZiRAwuNGDoOMGK9lErByPolbxZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j2frg0//9VQO1YJusMXb4r4+/3Ti3eWwm3MpU+bxRt/nT3gXMvvfRFRH25PqYc+oWR0Rfl+TpoZFQznx009kBfjyAqG58eVOSAdZ88J+uwrWEjLnu/xc25cUrdzqKEMRVHyEkFpy95683Q77l81dTF7yC2dz83kMhQPMhXIq/BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V9iIIRZF; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730116536; x=1761652536;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ba91/jtCBvQX+Fc4ZiRAwuNGDoOMGK9lErByPolbxZM=;
  b=V9iIIRZFmYIOvdb6TPtlfxAc2UpGiFh8FD13ko5vPFy7wE/dSDTjme1W
   xZTBPU9iDphpAI6TtDHj9LQzyEsDsgC/0c96hMOMFcqfMhWQhNrpIZYmw
   NIIdAZivGlQKuLuM2IteEKKPjG5pmXHp/ryjdKUmnnJnxAfNLeAsPp5sV
   vYGRvjWlUsJj3iqcgd/FcjGL5jYDW1Xaa/clIk6qSLr865EGYXAY6ihCq
   Bwthm9MVLftcaOiaTODsIGVoTmHZk2UEasKpKSNr0X5yOH4i4+UhpPO8W
   X5U3oB0IBOJ1TQfPJCDczPWUBBOzDDhfjby6X1sE/CD9YsMD1cp3xHgHg
   A==;
X-CSE-ConnectionGUID: FSvZGj4FQcys3EJOY/5lVA==
X-CSE-MsgGUID: Wvf73GRJQ+KZ1Xdxc//4Lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29813921"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="29813921"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:35 -0700
X-CSE-ConnectionGUID: /wLCQHNNTtaOlzP8oQR7qQ==
X-CSE-MsgGUID: r7hDwZDcRIiJeVlnurISEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="112432624"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:33 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 13/15] wifi: iwlwifi: s/IWL_MVM_INVALID_STA/IWL_INVALID_STA
Date: Mon, 28 Oct 2024 13:54:58 +0200
Message-Id: <20241028135215.acb45e8c4a78.I58736fd85d82a1fe641e75037b77878854a91e50@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028115500.351123-1-miriam.rachel.korenblit@intel.com>
References: <20241028115500.351123-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This is not mvm specific

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/location.h  | 26 +++++-----
 .../net/wireless/intel/iwlwifi/fw/api/mac.h   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  4 +-
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  |  2 +-
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  6 +--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  8 +--
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  |  2 +-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  4 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 16 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 52 +++++++++----------
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c | 14 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  4 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  2 +-
 17 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
index 15aab3bbb7e9..b8dff139aa05 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
@@ -771,7 +771,7 @@ enum iwl_location_cipher {
  * @num_of_bursts: Recommended value to be sent to the AP. 2s Exponent of
  *	the number of measurement iterations (min 2^0 = 1, max 2^14)
  * @sta_id: the station id of the AP. Only relevant when associated to the AP,
- *	otherwise should be set to &IWL_MVM_INVALID_STA.
+ *	otherwise should be set to &IWL_INVALID_STA.
  * @cipher: pairwise cipher suite for secured measurement.
  *          &enum iwl_location_cipher.
  * @hltk: HLTK to be used for secured 11az measurement
@@ -818,7 +818,7 @@ struct iwl_tof_range_req_ap_entry_v6 {
  * @num_of_bursts: Recommended value to be sent to the AP. 2s Exponent of
  *	the number of measurement iterations (min 2^0 = 1, max 2^14)
  * @sta_id: the station id of the AP. Only relevant when associated to the AP,
- *	otherwise should be set to &IWL_MVM_INVALID_STA.
+ *	otherwise should be set to &IWL_INVALID_STA.
  * @cipher: pairwise cipher suite for secured measurement.
  *          &enum iwl_location_cipher.
  * @hltk: HLTK to be used for secured 11az measurement
@@ -831,10 +831,10 @@ struct iwl_tof_range_req_ap_entry_v6 {
  *	&IWL_INITIATOR_AP_FLAGS_TB is set.
  * @rx_pn: the next expected PN for protected management frames Rx. LE byte
  *	order. Only valid if &IWL_INITIATOR_AP_FLAGS_SECURED is set and sta_id
- *	is set to &IWL_MVM_INVALID_STA.
+ *	is set to &IWL_INVALID_STA.
  * @tx_pn: the next PN to use for protected management frames Tx. LE byte
  *	order. Only valid if &IWL_INITIATOR_AP_FLAGS_SECURED is set and sta_id
- *	is set to &IWL_MVM_INVALID_STA.
+ *	is set to &IWL_INVALID_STA.
  */
 struct iwl_tof_range_req_ap_entry_v7 {
 	__le32 initiator_ap_flags;
@@ -876,7 +876,7 @@ struct iwl_tof_range_req_ap_entry_v7 {
  * @num_of_bursts: Recommended value to be sent to the AP. 2s Exponent of
  *	the number of measurement iterations (min 2^0 = 1, max 2^14)
  * @sta_id: the station id of the AP. Only relevant when associated to the AP,
- *	otherwise should be set to &IWL_MVM_INVALID_STA.
+ *	otherwise should be set to &IWL_INVALID_STA.
  * @cipher: pairwise cipher suite for secured measurement.
  *          &enum iwl_location_cipher.
  * @hltk: HLTK to be used for secured 11az measurement
@@ -889,10 +889,10 @@ struct iwl_tof_range_req_ap_entry_v7 {
  *	&IWL_INITIATOR_AP_FLAGS_TB is set.
  * @rx_pn: the next expected PN for protected management frames Rx. LE byte
  *	order. Only valid if &IWL_INITIATOR_AP_FLAGS_SECURED is set and sta_id
- *	is set to &IWL_MVM_INVALID_STA.
+ *	is set to &IWL_INVALID_STA.
  * @tx_pn: the next PN to use for protected management frames Tx. LE byte
  *	order. Only valid if &IWL_INITIATOR_AP_FLAGS_SECURED is set and sta_id
- *	is set to &IWL_MVM_INVALID_STA.
+ *	is set to &IWL_INVALID_STA.
  * @r2i_ndp_params: parameters for R2I NDP ranging negotiation.
  *      bits 0 - 2: max LTF repetitions
  *      bits 3 - 5: max number of spatial streams
@@ -950,7 +950,7 @@ struct iwl_tof_range_req_ap_entry_v8 {
  * @num_of_bursts: Recommended value to be sent to the AP. 2s Exponent of
  *	the number of measurement iterations (min 2^0 = 1, max 2^14)
  * @sta_id: the station id of the AP. Only relevant when associated to the AP,
- *	otherwise should be set to &IWL_MVM_INVALID_STA.
+ *	otherwise should be set to &IWL_INVALID_STA.
  * @cipher: pairwise cipher suite for secured measurement.
  *          &enum iwl_location_cipher.
  * @hltk: HLTK to be used for secured 11az measurement
@@ -965,10 +965,10 @@ struct iwl_tof_range_req_ap_entry_v8 {
  *	&IWL_INITIATOR_AP_FLAGS_TB or &IWL_INITIATOR_AP_FLAGS_NON_TB is set.
  * @rx_pn: the next expected PN for protected management frames Rx. LE byte
  *	order. Only valid if &IWL_INITIATOR_AP_FLAGS_SECURED is set and sta_id
- *	is set to &IWL_MVM_INVALID_STA.
+ *	is set to &IWL_INVALID_STA.
  * @tx_pn: the next PN to use for protected management frames Tx. LE byte
  *	order. Only valid if &IWL_INITIATOR_AP_FLAGS_SECURED is set and sta_id
- *	is set to &IWL_MVM_INVALID_STA.
+ *	is set to &IWL_INVALID_STA.
  * @r2i_ndp_params: parameters for R2I NDP ranging negotiation.
  *      bits 0 - 2: max LTF repetitions
  *      bits 3 - 5: max number of spatial streams
@@ -1033,7 +1033,7 @@ struct iwl_tof_range_req_ap_entry_v9 {
  * @num_of_bursts: Recommended value to be sent to the AP. 2s Exponent of
  *	the number of measurement iterations (min 2^0 = 1, max 2^14)
  * @sta_id: the station id of the AP. Only relevant when associated to the AP,
- *	otherwise should be set to &IWL_MVM_INVALID_STA.
+ *	otherwise should be set to &IWL_INVALID_STA.
  * @cipher: pairwise cipher suite for secured measurement.
  *          &enum iwl_location_cipher.
  * @hltk: HLTK to be used for secured 11az measurement
@@ -1046,10 +1046,10 @@ struct iwl_tof_range_req_ap_entry_v9 {
  *	&IWL_INITIATOR_AP_FLAGS_TB is set.
  * @rx_pn: the next expected PN for protected management frames Rx. LE byte
  *	order. Only valid if &IWL_INITIATOR_AP_FLAGS_SECURED is set and sta_id
- *	is set to &IWL_MVM_INVALID_STA.
+ *	is set to &IWL_INVALID_STA.
  * @tx_pn: the next PN to use for protected management frames Tx. LE byte
  *	order. Only valid if &IWL_INITIATOR_AP_FLAGS_SECURED is set and sta_id
- *	is set to &IWL_MVM_INVALID_STA.
+ *	is set to &IWL_INVALID_STA.
  * @r2i_ndp_params: parameters for R2I NDP ranging negotiation.
  *      bits 0 - 2: max LTF repetitions
  *      bits 3 - 5: max number of spatial streams
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
index 977ca4ac166d..26301c0b06a1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
@@ -17,7 +17,7 @@
 #define NUM_MAC_INDEX_CDB	(NUM_MAC_INDEX_DRIVER + 2)
 
 #define IWL_STATION_COUNT_MAX	16
-#define IWL_MVM_INVALID_STA		0xFF
+#define IWL_INVALID_STA		0xFF
 
 enum iwl_ac {
 	AC_BK,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
index b607961970e9..36726ea4b822 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
@@ -689,7 +689,7 @@ void iwl_mvm_bt_rssi_event(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	 * Rssi update while not associated - can happen since the statistics
 	 * are handled asynchronously
 	 */
-	if (mvmvif->deflink.ap_sta_id == IWL_MVM_INVALID_STA)
+	if (mvmvif->deflink.ap_sta_id == IWL_INVALID_STA)
 		return;
 
 	/* No BT - reports should be disabled */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index a6082150deab..16a9738dcdc9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1306,7 +1306,7 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 		goto out_noreset;
 	}
 
-	if (mvm_link->ap_sta_id == IWL_MVM_INVALID_STA) {
+	if (mvm_link->ap_sta_id == IWL_INVALID_STA) {
 		/* if we're not associated, this must be netdetect */
 		if (!wowlan->nd_config) {
 			ret = 1;
@@ -3156,7 +3156,7 @@ iwl_mvm_choose_query_wakeup_reasons(struct iwl_mvm *mvm,
 	/* if FW uses status notification, status shouldn't be NULL here */
 	if (!d3_data->status) {
 		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-		u8 sta_id = mvm->net_detect ? IWL_MVM_INVALID_STA :
+		u8 sta_id = mvm->net_detect ? IWL_INVALID_STA :
 					      mvmvif->deflink.ap_sta_id;
 
 		/* bug - FW with MLO has status notification */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
index 261aca03682c..fbe4e4a50852 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
@@ -221,7 +221,7 @@ static ssize_t iwl_dbgfs_mac_params_read(struct file *file,
 				 mvmvif->deflink.queue_params[i].uapsd);
 
 	if (vif->type == NL80211_IFTYPE_STATION &&
-	    ap_sta_id != IWL_MVM_INVALID_STA) {
+	    ap_sta_id != IWL_INVALID_STA) {
 		struct iwl_mvm_sta *mvm_sta;
 
 		mvm_sta = iwl_mvm_sta_from_staid_protected(mvm, ap_sta_id);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 77cfad6707f8..b26141c30c61 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -559,12 +559,12 @@ static int iwl_mvm_ftm_set_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 		if (mvmvif->ftm_unprotected) {
-			*sta_id = IWL_MVM_INVALID_STA;
+			*sta_id = IWL_INVALID_STA;
 			*flags &= ~cpu_to_le32(IWL_INITIATOR_AP_FLAGS_PMF);
 		}
 #endif
 	} else {
-		*sta_id = IWL_MVM_INVALID_STA;
+		*sta_id = IWL_INVALID_STA;
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 1b62bb92ee93..3fb9e9ebcd17 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1487,7 +1487,7 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	for (i = 0; i < IWL_FW_MAX_LINK_ID + 1; i++)
 		RCU_INIT_POINTER(mvm->link_id_to_link_conf[i], NULL);
 
-	mvm->tdls_cs.peer.sta_id = IWL_MVM_INVALID_STA;
+	mvm->tdls_cs.peer.sta_id = IWL_INVALID_STA;
 
 	/* reset quota debouncing buffer - 0xff will yield invalid data */
 	memset(&mvm->last_quota_cmd, 0xff, sizeof(mvm->last_quota_cmd));
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 492e0da553ab..272da41567ef 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -1170,9 +1170,9 @@ void iwl_mvm_unblock_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 void iwl_mvm_init_link(struct iwl_mvm_vif_link_info *link)
 {
-	link->bcast_sta.sta_id = IWL_MVM_INVALID_STA;
-	link->mcast_sta.sta_id = IWL_MVM_INVALID_STA;
-	link->ap_sta_id = IWL_MVM_INVALID_STA;
+	link->bcast_sta.sta_id = IWL_INVALID_STA;
+	link->mcast_sta.sta_id = IWL_INVALID_STA;
+	link->ap_sta_id = IWL_INVALID_STA;
 
 	for (int r = 0; r < NUM_IWL_MVM_SMPS_REQ; r++)
 		link->smps_requests[r] =
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 23ccbe7b74c0..c4fc99ec97e6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1109,7 +1109,7 @@ static void iwl_mvm_cleanup_iterator(void *data, u8 *mac,
 	vif->driver_flags &= ~IEEE80211_VIF_EML_ACTIVE;
 
 	for_each_mvm_vif_valid_link(mvmvif, link_id) {
-		mvmvif->link[link_id]->ap_sta_id = IWL_MVM_INVALID_STA;
+		mvmvif->link[link_id]->ap_sta_id = IWL_INVALID_STA;
 		mvmvif->link[link_id]->fw_link_id = IWL_MVM_FW_LINK_ID_INVALID;
 		mvmvif->link[link_id]->phy_ctxt = NULL;
 		mvmvif->link[link_id]->active = 0;
@@ -2947,7 +2947,7 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 						    IWL_MVM_SMPS_REQ_PROT,
 						    IEEE80211_SMPS_DYNAMIC, 0);
 			}
-		} else if (mvmvif->deflink.ap_sta_id != IWL_MVM_INVALID_STA) {
+		} else if (mvmvif->deflink.ap_sta_id != IWL_INVALID_STA) {
 			iwl_mvm_mei_host_disassociated(mvm);
 			/*
 			 * If update fails - SF might be running in associated
@@ -2983,7 +2983,7 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 					IWL_ERR(mvm,
 						"failed to remove AP station\n");
 
-				mvmvif->deflink.ap_sta_id = IWL_MVM_INVALID_STA;
+				mvmvif->deflink.ap_sta_id = IWL_INVALID_STA;
 			}
 
 			/* remove quota for this interface */
@@ -3440,7 +3440,7 @@ static void __iwl_mvm_mac_sta_notify(struct ieee80211_hw *hw,
 		 */
 		break;
 	case STA_NOTIFY_AWAKE:
-		if (WARN_ON(mvmsta->deflink.sta_id == IWL_MVM_INVALID_STA))
+		if (WARN_ON(mvmsta->deflink.sta_id == IWL_INVALID_STA))
 			break;
 
 		if (txqs)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
index 455f5f417506..ef0be44207e1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -396,7 +396,7 @@ void iwl_mvm_sec_key_remove_ap(struct iwl_mvm *mvm,
 	u8 sec_key_ver = iwl_fw_lookup_cmd_ver(mvm->fw, sec_key_id, 0);
 
 	if (WARN_ON_ONCE(vif->type != NL80211_IFTYPE_STATION ||
-			 link->ap_sta_id == IWL_MVM_INVALID_STA))
+			 link->ap_sta_id == IWL_INVALID_STA))
 		return;
 
 	if (!sec_key_ver)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 4acfa6c3844f..75ca960857ed 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -816,7 +816,7 @@ static bool iwl_mvm_mld_vif_have_valid_ap_sta(struct iwl_mvm_vif *mvmvif)
 	int i;
 
 	for_each_mvm_vif_valid_link(mvmvif, i) {
-		if (mvmvif->link[i]->ap_sta_id != IWL_MVM_INVALID_STA)
+		if (mvmvif->link[i]->ap_sta_id != IWL_INVALID_STA)
 			return true;
 	}
 
@@ -843,7 +843,7 @@ static void iwl_mvm_mld_vif_delete_all_stas(struct iwl_mvm *mvm,
 		if (ret)
 			IWL_ERR(mvm, "failed to remove AP station\n");
 
-		link->ap_sta_id = IWL_MVM_INVALID_STA;
+		link->ap_sta_id = IWL_INVALID_STA;
 	}
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 1a096f1b1870..019839604011 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -146,7 +146,7 @@ int iwl_mvm_mld_add_int_sta_with_queue(struct iwl_mvm *mvm,
 	unsigned int wdg_timeout = _wdg_timeout ? *_wdg_timeout :
 		mvm->trans->trans_cfg->base_params->wd_timeout;
 
-	if (WARN_ON_ONCE(sta->sta_id == IWL_MVM_INVALID_STA))
+	if (WARN_ON_ONCE(sta->sta_id == IWL_INVALID_STA))
 		return -ENOSPC;
 
 	if (sta->type == STATION_TYPE_AUX)
@@ -346,7 +346,7 @@ static int iwl_mvm_mld_rm_int_sta(struct iwl_mvm *mvm,
 
 	lockdep_assert_held(&mvm->mutex);
 
-	if (WARN_ON_ONCE(int_sta->sta_id == IWL_MVM_INVALID_STA))
+	if (WARN_ON_ONCE(int_sta->sta_id == IWL_INVALID_STA))
 		return -EINVAL;
 
 	if (flush)
@@ -565,7 +565,7 @@ static int iwl_mvm_mld_alloc_sta_link(struct iwl_mvm *mvm,
 	lockdep_assert_wiphy(mvm->hw->wiphy);
 	lockdep_assert_held(&mvm->mutex);
 
-	if (sta_id == IWL_MVM_INVALID_STA)
+	if (sta_id == IWL_INVALID_STA)
 		return -ENOSPC;
 
 	if (rcu_access_pointer(sta->link[link_id]) == &sta->deflink) {
@@ -618,10 +618,10 @@ static void iwl_mvm_mld_set_ap_sta_id(struct ieee80211_sta *sta,
 				      struct iwl_mvm_link_sta *sta_link)
 {
 	if (!sta->tdls) {
-		WARN_ON(vif_link->ap_sta_id != IWL_MVM_INVALID_STA);
+		WARN_ON(vif_link->ap_sta_id != IWL_INVALID_STA);
 		vif_link->ap_sta_id = sta_link->sta_id;
 	} else {
-		WARN_ON(vif_link->ap_sta_id == IWL_MVM_INVALID_STA);
+		WARN_ON(vif_link->ap_sta_id == IWL_INVALID_STA);
 	}
 }
 
@@ -695,7 +695,7 @@ int iwl_mvm_mld_add_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 		spin_lock_init(&mvm_sta->lock);
 
-		ret = iwl_mvm_sta_init(mvm, vif, sta, IWL_MVM_INVALID_STA,
+		ret = iwl_mvm_sta_init(mvm, vif, sta, IWL_INVALID_STA,
 				       STATION_TYPE_PEER);
 	} else {
 		ret = iwl_mvm_alloc_sta_after_restart(mvm, vif, sta);
@@ -870,7 +870,7 @@ int iwl_mvm_mld_rm_sta_id(struct iwl_mvm *mvm, u8 sta_id)
 	lockdep_assert_wiphy(mvm->hw->wiphy);
 	lockdep_assert_held(&mvm->mutex);
 
-	if (WARN_ON(sta_id == IWL_MVM_INVALID_STA))
+	if (WARN_ON(sta_id == IWL_INVALID_STA))
 		return 0;
 
 	ret = iwl_mvm_mld_rm_sta_from_fw(mvm, sta_id);
@@ -1120,7 +1120,7 @@ int iwl_mvm_mld_update_sta_links(struct iwl_mvm *mvm,
 			goto err;
 
 		if (vif->type == NL80211_IFTYPE_STATION)
-			mvm_vif_link->ap_sta_id = IWL_MVM_INVALID_STA;
+			mvm_vif_link->ap_sta_id = IWL_INVALID_STA;
 
 		iwl_mvm_mld_free_sta_link(mvm, mvm_sta, mvm_sta_link, link_id,
 					  false);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 4dd4a9d5c71f..e25d7570ffab 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1505,8 +1505,8 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	mvm->scan_cmd_size = scan_size;
 
 	/* invalidate ids to prevent accidental removal of sta_id 0 */
-	mvm->aux_sta.sta_id = IWL_MVM_INVALID_STA;
-	mvm->snif_sta.sta_id = IWL_MVM_INVALID_STA;
+	mvm->aux_sta.sta_id = IWL_INVALID_STA;
+	mvm->snif_sta.sta_id = IWL_INVALID_STA;
 
 	/* Set EBS as successful as long as not stated otherwise by the FW. */
 	mvm->last_ebs_successful = true;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 9d05c344d967..cd74c181c260 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -47,7 +47,7 @@ int iwl_mvm_find_free_sta_id(struct iwl_mvm *mvm, enum nl80211_iftype iftype)
 					       lockdep_is_held(&mvm->mutex)))
 			return sta_id;
 	}
-	return IWL_MVM_INVALID_STA;
+	return IWL_INVALID_STA;
 }
 
 /* Calculate the ampdu density and max size */
@@ -1216,7 +1216,7 @@ static bool iwl_mvm_remove_inactive_tids(struct iwl_mvm *mvm,
  * can be unshared and finding one (and only one) that can be
  * reused.
  * This function is also invoked as a sort of clean-up task,
- * in which case @alloc_for_sta is IWL_MVM_INVALID_STA.
+ * in which case @alloc_for_sta is IWL_INVALID_STA.
  *
  * Returns the queue number, or -ENOSPC.
  */
@@ -1309,7 +1309,7 @@ static int iwl_mvm_inactivity_check(struct iwl_mvm *mvm, u8 alloc_for_sta)
 
 	rcu_read_unlock();
 
-	if (free_queue >= 0 && alloc_for_sta != IWL_MVM_INVALID_STA) {
+	if (free_queue >= 0 && alloc_for_sta != IWL_INVALID_STA) {
 		ret = iwl_mvm_free_inactive_queue(mvm, free_queue, queue_owner,
 						  alloc_for_sta);
 		if (ret)
@@ -1522,7 +1522,7 @@ void iwl_mvm_add_new_dqa_stream_wk(struct work_struct *wk)
 
 	mutex_lock(&mvm->mutex);
 
-	iwl_mvm_inactivity_check(mvm, IWL_MVM_INVALID_STA);
+	iwl_mvm_inactivity_check(mvm, IWL_INVALID_STA);
 
 	while (!list_empty(&mvm->add_stream_txqs)) {
 		struct iwl_mvm_txq *mvmtxq;
@@ -1580,7 +1580,7 @@ static int iwl_mvm_reserve_sta_stream(struct iwl_mvm *mvm,
 		return 0;
 
 	/* run the general cleanup/unsharing of queues */
-	iwl_mvm_inactivity_check(mvm, IWL_MVM_INVALID_STA);
+	iwl_mvm_inactivity_check(mvm, IWL_INVALID_STA);
 
 	/* Make sure we have free resources for this STA */
 	if (vif_type == NL80211_IFTYPE_STATION && !sta->tdls &&
@@ -1756,7 +1756,7 @@ int iwl_mvm_sta_init(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	 * this function
 	 */
 	if (!mvm->mld_api_is_used) {
-		if (WARN_ON(sta_id == IWL_MVM_INVALID_STA))
+		if (WARN_ON(sta_id == IWL_INVALID_STA))
 			return -EINVAL;
 
 		mvm_sta->deflink.sta_id = sta_id;
@@ -1865,7 +1865,7 @@ int iwl_mvm_add_sta(struct iwl_mvm *mvm,
 	else
 		sta_id = mvm_sta->deflink.sta_id;
 
-	if (sta_id == IWL_MVM_INVALID_STA)
+	if (sta_id == IWL_INVALID_STA)
 		return -ENOSPC;
 
 	spin_lock_init(&mvm_sta->lock);
@@ -1903,10 +1903,10 @@ int iwl_mvm_add_sta(struct iwl_mvm *mvm,
 
 	if (vif->type == NL80211_IFTYPE_STATION) {
 		if (!sta->tdls) {
-			WARN_ON(mvmvif->deflink.ap_sta_id != IWL_MVM_INVALID_STA);
+			WARN_ON(mvmvif->deflink.ap_sta_id != IWL_INVALID_STA);
 			mvmvif->deflink.ap_sta_id = sta_id;
 		} else {
-			WARN_ON(mvmvif->deflink.ap_sta_id == IWL_MVM_INVALID_STA);
+			WARN_ON(mvmvif->deflink.ap_sta_id == IWL_INVALID_STA);
 		}
 	}
 
@@ -2095,7 +2095,7 @@ bool iwl_mvm_sta_del(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		iwl_mvm_sec_key_remove_ap(mvm, vif, mvm_link, 0);
 
 		/* unassoc - go ahead - remove the AP STA now */
-		mvm_link->ap_sta_id = IWL_MVM_INVALID_STA;
+		mvm_link->ap_sta_id = IWL_INVALID_STA;
 	}
 
 	/*
@@ -2103,7 +2103,7 @@ bool iwl_mvm_sta_del(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	 * before the STA is removed.
 	 */
 	if (WARN_ON_ONCE(mvm->tdls_cs.peer.sta_id == sta_id)) {
-		mvm->tdls_cs.peer.sta_id = IWL_MVM_INVALID_STA;
+		mvm->tdls_cs.peer.sta_id = IWL_INVALID_STA;
 		cancel_delayed_work(&mvm->tdls_cs.dwork);
 	}
 
@@ -2170,9 +2170,9 @@ int iwl_mvm_allocate_int_sta(struct iwl_mvm *mvm,
 			     u8 type)
 {
 	if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status) ||
-	    sta->sta_id == IWL_MVM_INVALID_STA) {
+	    sta->sta_id == IWL_INVALID_STA) {
 		sta->sta_id = iwl_mvm_find_free_sta_id(mvm, iftype);
-		if (WARN_ON_ONCE(sta->sta_id == IWL_MVM_INVALID_STA))
+		if (WARN_ON_ONCE(sta->sta_id == IWL_INVALID_STA))
 			return -ENOSPC;
 	}
 
@@ -2188,7 +2188,7 @@ void iwl_mvm_dealloc_int_sta(struct iwl_mvm *mvm, struct iwl_mvm_int_sta *sta)
 {
 	RCU_INIT_POINTER(mvm->fw_id_to_mac_id[sta->sta_id], NULL);
 	memset(sta, 0, sizeof(struct iwl_mvm_int_sta));
-	sta->sta_id = IWL_MVM_INVALID_STA;
+	sta->sta_id = IWL_INVALID_STA;
 }
 
 static void iwl_mvm_enable_aux_snif_queue(struct iwl_mvm *mvm, u16 queue,
@@ -2306,7 +2306,7 @@ int iwl_mvm_rm_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 
 	lockdep_assert_held(&mvm->mutex);
 
-	if (WARN_ON_ONCE(mvm->snif_sta.sta_id == IWL_MVM_INVALID_STA))
+	if (WARN_ON_ONCE(mvm->snif_sta.sta_id == IWL_INVALID_STA))
 		return -EINVAL;
 
 	iwl_mvm_disable_txq(mvm, NULL, mvm->snif_sta.sta_id,
@@ -2324,7 +2324,7 @@ int iwl_mvm_rm_aux_sta(struct iwl_mvm *mvm)
 
 	lockdep_assert_held(&mvm->mutex);
 
-	if (WARN_ON_ONCE(mvm->aux_sta.sta_id == IWL_MVM_INVALID_STA))
+	if (WARN_ON_ONCE(mvm->aux_sta.sta_id == IWL_INVALID_STA))
 		return -EINVAL;
 
 	iwl_mvm_disable_txq(mvm, NULL, mvm->aux_sta.sta_id,
@@ -2389,7 +2389,7 @@ int iwl_mvm_send_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	if (vif->type == NL80211_IFTYPE_ADHOC)
 		baddr = vif->bss_conf.bssid;
 
-	if (WARN_ON_ONCE(bsta->sta_id == IWL_MVM_INVALID_STA))
+	if (WARN_ON_ONCE(bsta->sta_id == IWL_INVALID_STA))
 		return -ENOSPC;
 
 	ret = iwl_mvm_add_int_sta_common(mvm, bsta, baddr,
@@ -2644,7 +2644,7 @@ static int __iwl_mvm_remove_sta_key(struct iwl_mvm *mvm, u8 sta_id,
 	u32 status;
 
 	/* This is a valid situation for GTK removal */
-	if (sta_id == IWL_MVM_INVALID_STA)
+	if (sta_id == IWL_INVALID_STA)
 		return 0;
 
 	key_flags = cpu_to_le16((keyconf->keyidx << STA_KEY_FLG_KEYID_POS) &
@@ -3514,7 +3514,7 @@ static struct iwl_mvm_sta *iwl_mvm_get_key_sta(struct iwl_mvm *mvm,
 	 * station ID, then use AP's station ID.
 	 */
 	if (vif->type == NL80211_IFTYPE_STATION &&
-	    mvmvif->deflink.ap_sta_id != IWL_MVM_INVALID_STA) {
+	    mvmvif->deflink.ap_sta_id != IWL_INVALID_STA) {
 		u8 sta_id = mvmvif->deflink.ap_sta_id;
 
 		sta = rcu_dereference_check(mvm->fw_id_to_mac_id[sta_id],
@@ -3569,7 +3569,7 @@ static int iwl_mvm_send_sta_key(struct iwl_mvm *mvm,
 	int api_ver = iwl_fw_lookup_cmd_ver(mvm->fw, ADD_STA_KEY,
 					    new_api ? 2 : 1);
 
-	if (sta_id == IWL_MVM_INVALID_STA)
+	if (sta_id == IWL_INVALID_STA)
 		return -EINVAL;
 
 	keyidx = (key->keyidx << STA_KEY_FLG_KEYID_POS) &
@@ -3728,7 +3728,7 @@ static int iwl_mvm_send_sta_igtk(struct iwl_mvm *mvm,
 
 	if (remove_key) {
 		/* This is a valid situation for IGTK */
-		if (sta_id == IWL_MVM_INVALID_STA)
+		if (sta_id == IWL_INVALID_STA)
 			return 0;
 
 		igtk_cmd.ctrl_flags |= cpu_to_le32(STA_KEY_NOT_VALID);
@@ -3795,7 +3795,7 @@ static inline u8 *iwl_mvm_get_mac_addr(struct iwl_mvm *mvm,
 		return sta->addr;
 
 	if (vif->type == NL80211_IFTYPE_STATION &&
-	    mvmvif->deflink.ap_sta_id != IWL_MVM_INVALID_STA) {
+	    mvmvif->deflink.ap_sta_id != IWL_INVALID_STA) {
 		u8 sta_id = mvmvif->deflink.ap_sta_id;
 		sta = rcu_dereference_protected(mvm->fw_id_to_mac_id[sta_id],
 						lockdep_is_held(&mvm->mutex));
@@ -3865,7 +3865,7 @@ int iwl_mvm_set_sta_key(struct iwl_mvm *mvm,
 {
 	bool mcast = !(keyconf->flags & IEEE80211_KEY_FLAG_PAIRWISE);
 	struct iwl_mvm_sta *mvm_sta;
-	u8 sta_id = IWL_MVM_INVALID_STA;
+	u8 sta_id = IWL_INVALID_STA;
 	int ret;
 	static const u8 __maybe_unused zero_addr[ETH_ALEN] = {0};
 
@@ -3966,7 +3966,7 @@ int iwl_mvm_remove_sta_key(struct iwl_mvm *mvm,
 {
 	bool mcast = !(keyconf->flags & IEEE80211_KEY_FLAG_PAIRWISE);
 	struct iwl_mvm_sta *mvm_sta;
-	u8 sta_id = IWL_MVM_INVALID_STA;
+	u8 sta_id = IWL_INVALID_STA;
 	int ret, i;
 
 	lockdep_assert_held(&mvm->mutex);
@@ -4273,7 +4273,7 @@ void iwl_mvm_modify_all_sta_disable_tx(struct iwl_mvm *mvm,
 		return;
 
 	/* Need to block/unblock also multicast station */
-	if (mvmvif->deflink.mcast_sta.sta_id != IWL_MVM_INVALID_STA)
+	if (mvmvif->deflink.mcast_sta.sta_id != IWL_INVALID_STA)
 		iwl_mvm_int_sta_modify_disable_tx(mvm, mvmvif,
 						  &mvmvif->deflink.mcast_sta,
 						  disable);
@@ -4282,7 +4282,7 @@ void iwl_mvm_modify_all_sta_disable_tx(struct iwl_mvm *mvm,
 	 * Only unblock the broadcast station (FW blocks it for immediate
 	 * quiet, not the driver)
 	 */
-	if (!disable && mvmvif->deflink.bcast_sta.sta_id != IWL_MVM_INVALID_STA)
+	if (!disable && mvmvif->deflink.bcast_sta.sta_id != IWL_INVALID_STA)
 		iwl_mvm_int_sta_modify_disable_tx(mvm, mvmvif,
 						  &mvmvif->deflink.bcast_sta,
 						  disable);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
index 3d25ff5cd7e8..65927ebbabb7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
@@ -196,7 +196,7 @@ static void iwl_mvm_tdls_update_cs_state(struct iwl_mvm *mvm,
 		mvm->tdls_cs.peer.sent_timestamp = iwl_mvm_get_systime(mvm);
 
 	if (state == IWL_MVM_TDLS_SW_IDLE)
-		mvm->tdls_cs.cur_sta_id = IWL_MVM_INVALID_STA;
+		mvm->tdls_cs.cur_sta_id = IWL_INVALID_STA;
 }
 
 void iwl_mvm_rx_tdls_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
@@ -250,7 +250,7 @@ iwl_mvm_tdls_check_action(struct iwl_mvm *mvm,
 
 	/* get the existing peer if it's there */
 	if (mvm->tdls_cs.state != IWL_MVM_TDLS_SW_IDLE &&
-	    mvm->tdls_cs.cur_sta_id != IWL_MVM_INVALID_STA) {
+	    mvm->tdls_cs.cur_sta_id != IWL_INVALID_STA) {
 		struct ieee80211_sta *sta = rcu_dereference_protected(
 				mvm->fw_id_to_mac_id[mvm->tdls_cs.cur_sta_id],
 				lockdep_is_held(&mvm->mutex));
@@ -465,7 +465,7 @@ void iwl_mvm_tdls_ch_switch_work(struct work_struct *work)
 	iwl_mvm_tdls_update_cs_state(mvm, IWL_MVM_TDLS_SW_IDLE);
 
 	/* station might be gone, in that case do nothing */
-	if (mvm->tdls_cs.peer.sta_id == IWL_MVM_INVALID_STA)
+	if (mvm->tdls_cs.peer.sta_id == IWL_INVALID_STA)
 		return;
 
 	sta = rcu_dereference_protected(
@@ -512,7 +512,7 @@ iwl_mvm_tdls_channel_switch(struct ieee80211_hw *hw,
 		       sta->addr, chandef->chan->center_freq, chandef->width);
 
 	/* we only support a single peer for channel switching */
-	if (mvm->tdls_cs.peer.sta_id != IWL_MVM_INVALID_STA) {
+	if (mvm->tdls_cs.peer.sta_id != IWL_INVALID_STA) {
 		IWL_DEBUG_TDLS(mvm,
 			       "Existing peer. Can't start switch with %pM\n",
 			       sta->addr);
@@ -566,7 +566,7 @@ void iwl_mvm_tdls_cancel_channel_switch(struct ieee80211_hw *hw,
 	IWL_DEBUG_TDLS(mvm, "TDLS cancel channel switch with %pM\n", sta->addr);
 
 	/* we only support a single peer for channel switching */
-	if (mvm->tdls_cs.peer.sta_id == IWL_MVM_INVALID_STA) {
+	if (mvm->tdls_cs.peer.sta_id == IWL_INVALID_STA) {
 		IWL_DEBUG_TDLS(mvm, "No ch switch peer - %pM\n", sta->addr);
 		goto out;
 	}
@@ -587,7 +587,7 @@ void iwl_mvm_tdls_cancel_channel_switch(struct ieee80211_hw *hw,
 	    mvm->tdls_cs.state != IWL_MVM_TDLS_SW_IDLE)
 		wait_for_phy = true;
 
-	mvm->tdls_cs.peer.sta_id = IWL_MVM_INVALID_STA;
+	mvm->tdls_cs.peer.sta_id = IWL_INVALID_STA;
 	dev_kfree_skb(mvm->tdls_cs.peer.skb);
 	mvm->tdls_cs.peer.skb = NULL;
 
@@ -630,7 +630,7 @@ iwl_mvm_tdls_recv_channel_switch(struct ieee80211_hw *hw,
 	if (params->action_code == WLAN_TDLS_CHANNEL_SWITCH_RESPONSE &&
 	    params->status != 0 &&
 	    mvm->tdls_cs.state == IWL_MVM_TDLS_SW_REQ_SENT &&
-	    mvm->tdls_cs.cur_sta_id != IWL_MVM_INVALID_STA) {
+	    mvm->tdls_cs.cur_sta_id != IWL_INVALID_STA) {
 		struct ieee80211_sta *cur_sta;
 
 		/* make sure it's the same peer */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index ca026b5256ce..c9867d26361b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1213,7 +1213,7 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 	if (IWL_MVM_NON_TRANSMITTING_AP && ieee80211_is_probe_resp(fc))
 		return -1;
 
-	if (WARN_ON_ONCE(mvmsta->deflink.sta_id == IWL_MVM_INVALID_STA))
+	if (WARN_ON_ONCE(mvmsta->deflink.sta_id == IWL_INVALID_STA))
 		return -1;
 
 	if (unlikely(ieee80211_is_any_nullfunc(fc)) && sta->deflink.he_cap.has_he)
@@ -1357,7 +1357,7 @@ int iwl_mvm_tx_skb_sta(struct iwl_mvm *mvm, struct sk_buff *skb,
 
 	mvmsta = iwl_mvm_sta_from_mac80211(sta);
 
-	if (WARN_ON_ONCE(mvmsta->deflink.sta_id == IWL_MVM_INVALID_STA))
+	if (WARN_ON_ONCE(mvmsta->deflink.sta_id == IWL_INVALID_STA))
 		return -1;
 
 	memcpy(&info, skb->cb, sizeof(info));
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index dbbec81559fd..dd890dcd1505 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -261,7 +261,7 @@ int iwl_mvm_send_lq_cmd(struct iwl_mvm *mvm, struct iwl_lq_cmd *lq)
 		.data = { lq, },
 	};
 
-	if (WARN_ON(lq->sta_id == IWL_MVM_INVALID_STA ||
+	if (WARN_ON(lq->sta_id == IWL_INVALID_STA ||
 		    iwl_mvm_has_tlc_offload(mvm)))
 		return -EINVAL;
 
-- 
2.34.1


