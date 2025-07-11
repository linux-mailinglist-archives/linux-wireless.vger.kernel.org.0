Return-Path: <linux-wireless+bounces-25277-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A247AB02084
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 17:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E70364A81B7
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 15:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DDD2E2EE7;
	Fri, 11 Jul 2025 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jzjGPdhB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445EA1DBB3A
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248096; cv=none; b=UnHRnF222NJvUR9C3x6VHC9iMGA5skjRuhGZg5WwRBVqxblgttTXCqBMQlS3Xl/K9/GtffeQWS/QtgEnZHJj2HSMo21RIHCuSvJlj87l7dFatty88LzB55PVsCbLsP/aVRlRX3BPEzRZDbSvqSBqmP+3ZQPMSC9uAUon9DibAFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248096; c=relaxed/simple;
	bh=UNauO6mwOi5r9UQPFiK8a54D9Vtuh0nfbr4wUByieww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=agJMlEvE4nq7DpIq++jR+7S+nnknBjfieIdfZAkppf+qUp2soFFVEZNOwQaIR20ZI4mGxhxUgMyTPGpm+iTes76/TG195aNCAbd2b5mqHOUpvCW7WtwHHrBRbKdO6RInKTtNSnb2a6t/dO90G0UCYTHQnQJGJXdwX1dquD56RwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jzjGPdhB; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752248095; x=1783784095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UNauO6mwOi5r9UQPFiK8a54D9Vtuh0nfbr4wUByieww=;
  b=jzjGPdhBFaEUHo+fQX2qbpz7O9N0eJsyIVJS0u0OHkXW+uv43kIPmPO7
   Q77A1waBhYjVPZ2/MwOoKcTHzq2cVc7YY+flHPPInWb9OA82cTLNvFES5
   IMOrZJsMVsi/ekLnFnwOoaglGunHO5u2FF8aSpdlDVm9Jy/m5FnonWs64
   fBSqcEPcJo/WEDYSZLEWLWMBPPjNayTN9zxMB/6hkNE22Fqi2yCsicJc6
   Yoblk6Ruw1Q1VOp+nCLlNPfpquNmfuxt6ZGHmlgOTAlocSYm02xPPMg6z
   rwfIJ2AO/sVzkVliW2Zb6EzaGrjv7qQvRRZHxtb1s6PpLekQZlkmWbYJL
   Q==;
X-CSE-ConnectionGUID: JdLafiVNTCykSH9yheXnAQ==
X-CSE-MsgGUID: Zh8ktYVsT8Wo+8qWOwGehA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54264153"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="54264153"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:34:54 -0700
X-CSE-ConnectionGUID: H+AbBvGiR/+ovX5hbE1+zQ==
X-CSE-MsgGUID: WQsEUjTXQCOMuVpY2dSV+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="156485088"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:34:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: mvm: remove extra link ID
Date: Fri, 11 Jul 2025 18:34:16 +0300
Message-Id: <20250711183056.005aa5fe34fe.Ib0c1187453f46ce49dc0f9f58907ee21f5b52634@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711153429.3417098-1-miriam.rachel.korenblit@intel.com>
References: <20250711153429.3417098-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Since the iwlmvm driver now only supports pre-MLO devices,
we no longer need to maintain an extra explicit link ID;
valid MAC IDs and link IDs are both in the range 0-3 and
the driver always has a 1:1 MAC/link correspondence. Thus,
simply use the MAC ID as the link ID as well.

This simplifies some further work because on RX the ID is
given but there is some confusion about which versions of
the firmware report MAC and which report link ID.

While at it, clarify iwl_mvm_handle_missed_beacons_notif()
code a bit so it doesn't look like an invalid vif pointer
is being used.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  3 -
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 59 ++-----------------
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 34 ++++-------
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 22 +------
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   | 24 ++++----
 .../wireless/intel/iwlwifi/mvm/time-event.c   | 25 +-------
 7 files changed, 34 insertions(+), 138 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index ab3d78c1e20c..4c2d0a4098cc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1462,9 +1462,6 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 		RCU_INIT_POINTER(mvm->fw_id_to_link_sta[i], NULL);
 	}
 
-	for (i = 0; i < IWL_FW_MAX_LINK_ID + 1; i++)
-		RCU_INIT_POINTER(mvm->link_id_to_link_conf[i], NULL);
-
 	mvm->tdls_cs.peer.sta_id = IWL_INVALID_STA;
 
 	/* reset quota debouncing buffer - 0xff will yield invalid data */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 9e46ac3e573a..2269acc55c0e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -49,20 +49,6 @@ static void iwl_mvm_print_esr_state(struct iwl_mvm *mvm, u32 mask)
 #undef NAME_PR
 }
 
-static u32 iwl_mvm_get_free_fw_link_id(struct iwl_mvm *mvm,
-				       struct iwl_mvm_vif *mvm_vif)
-{
-	u32 i;
-
-	lockdep_assert_held(&mvm->mutex);
-
-	for (i = 0; i < ARRAY_SIZE(mvm->link_id_to_link_conf); i++)
-		if (!rcu_access_pointer(mvm->link_id_to_link_conf[i]))
-			return i;
-
-	return IWL_MVM_FW_LINK_ID_INVALID;
-}
-
 static int iwl_mvm_link_cmd_send(struct iwl_mvm *mvm,
 				 struct iwl_link_config_cmd *cmd,
 				 enum iwl_ctxt_action action)
@@ -79,25 +65,15 @@ static int iwl_mvm_link_cmd_send(struct iwl_mvm *mvm,
 	return ret;
 }
 
-int iwl_mvm_set_link_mapping(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			     struct ieee80211_bss_conf *link_conf)
+void iwl_mvm_set_link_fw_id(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			    struct ieee80211_bss_conf *link_conf)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_vif_link_info *link_info =
 		mvmvif->link[link_conf->link_id];
 
-	if (link_info->fw_link_id == IWL_MVM_FW_LINK_ID_INVALID) {
-		link_info->fw_link_id = iwl_mvm_get_free_fw_link_id(mvm,
-								    mvmvif);
-		if (link_info->fw_link_id >=
-		    ARRAY_SIZE(mvm->link_id_to_link_conf))
-			return -EINVAL;
-
-		rcu_assign_pointer(mvm->link_id_to_link_conf[link_info->fw_link_id],
-				   link_conf);
-	}
-
-	return 0;
+	if (link_info->fw_link_id == IWL_MVM_FW_LINK_ID_INVALID)
+		link_info->fw_link_id = mvmvif->id;
 }
 
 int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
@@ -109,14 +85,11 @@ int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	struct iwl_link_config_cmd cmd = {};
 	unsigned int cmd_id = WIDE_ID(MAC_CONF_GROUP, LINK_CONFIG_CMD);
 	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id, 1);
-	int ret;
 
 	if (WARN_ON_ONCE(!link_info))
 		return -EINVAL;
 
-	ret = iwl_mvm_set_link_mapping(mvm, vif, link_conf);
-	if (ret)
-		return ret;
+	iwl_mvm_set_link_fw_id(mvm, vif, link_conf);
 
 	/* Update SF - Disable if needed. if this fails, SF might still be on
 	 * while many macs are bound, which is forbidden - so fail the binding.
@@ -373,24 +346,6 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	return ret;
 }
 
-int iwl_mvm_unset_link_mapping(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			       struct ieee80211_bss_conf *link_conf)
-{
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mvm_vif_link_info *link_info =
-		mvmvif->link[link_conf->link_id];
-
-	/* mac80211 thought we have the link, but it was never configured */
-	if (WARN_ON(!link_info ||
-		    link_info->fw_link_id >=
-		    ARRAY_SIZE(mvm->link_id_to_link_conf)))
-		return -EINVAL;
-
-	RCU_INIT_POINTER(mvm->link_id_to_link_conf[link_info->fw_link_id],
-			 NULL);
-	return 0;
-}
-
 int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			struct ieee80211_bss_conf *link_conf)
 {
@@ -400,10 +355,6 @@ int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	struct iwl_link_config_cmd cmd = {};
 	int ret;
 
-	ret = iwl_mvm_unset_link_mapping(mvm, vif, link_conf);
-	if (ret)
-		return 0;
-
 	cmd.link_id = cpu_to_le32(link_info->fw_link_id);
 	link_info->fw_link_id = IWL_MVM_FW_LINK_ID_INVALID;
 	cmd.spec_link_id = link_conf->link_id;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 9098a36530cc..d9d61e25807a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1586,7 +1586,7 @@ iwl_mvm_handle_missed_beacons_notif(struct iwl_mvm *mvm,
 	u32 id = le32_to_cpu(mb->link_id);
 	union iwl_dbg_tlv_tp_data tp_data = { .fw_pkt = pkt };
 	u32 mac_type;
-	int link_id = -1;
+	int link_id;
 	u8 notif_ver = iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
 					       MISSED_BEACONS_NOTIFICATION,
 					       0);
@@ -1602,20 +1602,6 @@ iwl_mvm_handle_missed_beacons_notif(struct iwl_mvm *mvm,
 	if (new_notif_ver)
 		notif_ver = new_notif_ver;
 
-	/* before version four the ID in the notification refers to mac ID */
-	if (notif_ver < 4) {
-		vif = iwl_mvm_rcu_dereference_vif_id(mvm, id, false);
-		bss_conf = &vif->bss_conf;
-	} else {
-		bss_conf = iwl_mvm_rcu_fw_link_id_to_link_conf(mvm, id, false);
-
-		if (!bss_conf)
-			return;
-
-		vif = bss_conf->vif;
-		link_id = bss_conf->link_id;
-	}
-
 	IWL_DEBUG_INFO(mvm,
 		       "missed bcn %s_id=%u, consecutive=%u (%u)\n",
 		       notif_ver < 4 ? "mac" : "link",
@@ -1623,9 +1609,16 @@ iwl_mvm_handle_missed_beacons_notif(struct iwl_mvm *mvm,
 		       le32_to_cpu(mb->consec_missed_beacons),
 		       le32_to_cpu(mb->consec_missed_beacons_since_last_rx));
 
+	/*
+	 * starting from version 4 the ID is link ID, but driver
+	 * uses link ID == MAC ID, so always treat as MAC ID
+	 */
+	vif = iwl_mvm_rcu_dereference_vif_id(mvm, id, false);
 	if (!vif)
 		return;
 
+	bss_conf = &vif->bss_conf;
+	link_id = bss_conf->link_id;
 	mac_type = iwl_mvm_get_mac_type(vif);
 
 	IWL_DEBUG_INFO(mvm, "missed beacon mac_type=%u,\n", mac_type);
@@ -1875,16 +1868,15 @@ void iwl_mvm_channel_switch_start_notif(struct iwl_mvm *mvm,
 	} else {
 		struct iwl_channel_switch_start_notif *notif = (void *)pkt->data;
 		u32 link_id = le32_to_cpu(notif->link_id);
-		struct ieee80211_bss_conf *bss_conf =
-			iwl_mvm_rcu_fw_link_id_to_link_conf(mvm, link_id, true);
 
-		if (!bss_conf)
+		/* we use link ID == MAC ID */
+		vif = iwl_mvm_rcu_dereference_vif_id(mvm, link_id, true);
+		if (!vif)
 			goto out_unlock;
 
 		id = link_id;
-		mac_link_id = bss_conf->link_id;
-		vif = bss_conf->vif;
-		csa_active = bss_conf->csa_active;
+		mac_link_id = vif->bss_conf.link_id;
+		csa_active = vif->bss_conf.csa_active;
 	}
 
 	mvmvif = iwl_mvm_vif_from_mac80211(vif);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 28a4630964d6..448492d94926 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1806,9 +1806,7 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 
 	vif->driver_flags = IEEE80211_VIF_REMOVE_AP_AFTER_DISASSOC;
 
-	ret = iwl_mvm_set_link_mapping(mvm, vif, &vif->bss_conf);
-	if (ret)
-		goto out;
+	iwl_mvm_set_link_fw_id(mvm, vif, &vif->bss_conf);
 
 	/*
 	 * Not much to do here. The stack will not allow interface
@@ -2009,7 +2007,6 @@ static void iwl_mvm_mac_remove_interface(struct ieee80211_hw *hw,
 		mvm->monitor_on = false;
 
 out:
-	iwl_mvm_unset_link_mapping(mvm, vif, &vif->bss_conf);
 	if (vif->type == NL80211_IFTYPE_AP ||
 	    vif->type == NL80211_IFTYPE_ADHOC) {
 		iwl_mvm_dealloc_int_sta(mvm, &mvmvif->deflink.mcast_sta);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 5754e83c6fcd..6c024a681508 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1177,8 +1177,6 @@ struct iwl_mvm {
 
 	struct ieee80211_vif __rcu *vif_id_to_mac[NUM_MAC_INDEX_DRIVER];
 
-	struct ieee80211_bss_conf __rcu *link_id_to_link_conf[IWL_FW_MAX_LINK_ID + 1];
-
 	u8 *error_recovery_buf;
 
 #ifdef CONFIG_IWLWIFI_LEDS
@@ -1485,20 +1483,6 @@ iwl_mvm_rcu_dereference_vif_id(struct iwl_mvm *mvm, u8 vif_id, bool rcu)
 					 lockdep_is_held(&mvm->mutex));
 }
 
-static inline struct ieee80211_bss_conf *
-iwl_mvm_rcu_fw_link_id_to_link_conf(struct iwl_mvm *mvm, u8 link_id, bool rcu)
-{
-	if (IWL_FW_CHECK(mvm, link_id >= ARRAY_SIZE(mvm->link_id_to_link_conf),
-			 "erroneous FW link ID: %d\n", link_id))
-		return NULL;
-
-	if (rcu)
-		return rcu_dereference(mvm->link_id_to_link_conf[link_id]);
-
-	return rcu_dereference_protected(mvm->link_id_to_link_conf[link_id],
-					 lockdep_is_held(&mvm->mutex));
-}
-
 static inline bool iwl_mvm_is_adaptive_dwell_supported(struct iwl_mvm *mvm)
 {
 	return fw_has_api(&mvm->fw->ucode_capa,
@@ -2097,15 +2081,13 @@ u32 iwl_mvm_get_lmac_id(struct iwl_mvm *mvm, enum nl80211_band band);
 
 /* Links */
 void iwl_mvm_init_link(struct iwl_mvm_vif_link_info *link);
-int iwl_mvm_set_link_mapping(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			     struct ieee80211_bss_conf *link_conf);
+void iwl_mvm_set_link_fw_id(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			    struct ieee80211_bss_conf *link_conf);
 int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		     struct ieee80211_bss_conf *link_conf);
 int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			 struct ieee80211_bss_conf *link_conf,
 			 u32 changes, bool active);
-int iwl_mvm_unset_link_mapping(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			       struct ieee80211_bss_conf *link_conf);
 int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			struct ieee80211_bss_conf *link_conf);
 int iwl_mvm_disable_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 8eb0aa448c85..8fae0d41b119 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -877,28 +877,28 @@ iwl_mvm_stat_iterator_all_links(struct iwl_mvm *mvm,
 	u32 rx_bytes[MAC_INDEX_AUX] = {};
 	int fw_link_id;
 
-	for (fw_link_id = 0; fw_link_id < ARRAY_SIZE(mvm->link_id_to_link_conf);
+	/* driver uses link ID == MAC ID */
+	for (fw_link_id = 0; fw_link_id < ARRAY_SIZE(mvm->vif_id_to_mac);
 	     fw_link_id++) {
 		struct iwl_stats_ntfy_per_link *link_stats;
-		struct ieee80211_bss_conf *bss_conf;
-		struct iwl_mvm_vif *mvmvif;
 		struct iwl_mvm_vif_link_info *link_info;
+		struct iwl_mvm_vif *mvmvif;
+		struct ieee80211_vif *vif;
 		int link_id;
 		int sig;
 
-		bss_conf = iwl_mvm_rcu_fw_link_id_to_link_conf(mvm, fw_link_id,
-							       false);
-		if (!bss_conf)
+		vif = iwl_mvm_rcu_dereference_vif_id(mvm, fw_link_id, false);
+		if (!vif)
 			continue;
 
-		if (bss_conf->vif->type != NL80211_IFTYPE_STATION)
+		if (vif->type != NL80211_IFTYPE_STATION)
 			continue;
 
-		link_id = bss_conf->link_id;
+		link_id = vif->bss_conf.link_id;
 		if (link_id >= ARRAY_SIZE(mvmvif->link))
 			continue;
 
-		mvmvif = iwl_mvm_vif_from_mac80211(bss_conf->vif);
+		mvmvif = iwl_mvm_vif_from_mac80211(vif);
 		link_info = mvmvif->link[link_id];
 		if (!link_info)
 			continue;
@@ -916,8 +916,7 @@ iwl_mvm_stat_iterator_all_links(struct iwl_mvm *mvm,
 
 		if (link_info->phy_ctxt &&
 		    link_info->phy_ctxt->channel->band == NL80211_BAND_2GHZ)
-			iwl_mvm_bt_coex_update_link_esr(mvm, bss_conf->vif,
-							link_id);
+			iwl_mvm_bt_coex_update_link_esr(mvm, vif, link_id);
 
 		/* make sure that beacon statistics don't go backwards with TCM
 		 * request to clear statistics
@@ -927,8 +926,7 @@ iwl_mvm_stat_iterator_all_links(struct iwl_mvm *mvm,
 				mvmvif->link[link_id]->beacon_stats.num_beacons;
 
 		sig = -le32_to_cpu(link_stats->beacon_filter_average_energy);
-		iwl_mvm_update_link_sig(bss_conf->vif, sig, link_info,
-					bss_conf);
+		iwl_mvm_update_link_sig(vif, sig, link_info, &vif->bss_conf);
 
 		if (WARN_ONCE(mvmvif->id >= MAC_INDEX_AUX,
 			      "invalid mvmvif id: %d", mvmvif->id))
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 478408f802d9..aa653782d6d7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -958,40 +958,19 @@ void iwl_mvm_rx_session_protect_notif(struct iwl_mvm *mvm,
 {
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	struct iwl_session_prot_notif *notif = (void *)pkt->data;
-	unsigned int ver =
-		iwl_fw_lookup_notif_ver(mvm->fw, MAC_CONF_GROUP,
-					SESSION_PROTECTION_NOTIF, 2);
 	int id = le32_to_cpu(notif->mac_link_id);
 	struct ieee80211_vif *vif;
 	struct iwl_mvm_vif *mvmvif;
-	unsigned int notif_link_id;
 
 	rcu_read_lock();
 
-	if (ver <= 2) {
-		vif = iwl_mvm_rcu_dereference_vif_id(mvm, id, true);
-	} else {
-		struct ieee80211_bss_conf *link_conf =
-			iwl_mvm_rcu_fw_link_id_to_link_conf(mvm, id, true);
-
-		if (!link_conf)
-			goto out_unlock;
-
-		notif_link_id = link_conf->link_id;
-		vif = link_conf->vif;
-	}
-
+	/* note we use link ID == MAC ID */
+	vif = iwl_mvm_rcu_dereference_vif_id(mvm, id, true);
 	if (!vif)
 		goto out_unlock;
 
 	mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
-	if (WARN(ver > 2 && mvmvif->time_event_data.link_id >= 0 &&
-		 mvmvif->time_event_data.link_id != notif_link_id,
-		 "SESSION_PROTECTION_NOTIF was received for link %u, while the current time event is on link %u\n",
-		 notif_link_id, mvmvif->time_event_data.link_id))
-		goto out_unlock;
-
 	/* The vif is not a P2P_DEVICE, maintain its time_event_data */
 	if (vif->type != NL80211_IFTYPE_P2P_DEVICE) {
 		struct iwl_mvm_time_event_data *te_data =
-- 
2.34.1


