Return-Path: <linux-wireless+bounces-30663-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3683D0F883
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 18:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F90C30ABEDC
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 17:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC0529AAF8;
	Sun, 11 Jan 2026 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MmONwUUK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECA234CFDB
	for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768153198; cv=none; b=NYA1ghuaeEizkjK45Zog+xh+D5x8oTPFX/rAOlxoWO5hy4NR+aWBvaaRRNnvBP8Ku720sBeP5i8FtxNKgaXeg6kcEn4EGd1J8I3eq0O0IcT0PmXLC4dMDumnoH7X4OgK2XptxjlqypShGXT2jwCt09eqaqCQpQZ8E7tc/SWL5Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768153198; c=relaxed/simple;
	bh=YTXRv7UWsEAyLSmysnjf/fdBgcKj8NnlFKyMj/cjSw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GEb35+4L2ONGeGjtRNGpGakvcMKE8YCXA9JYFI3IdTmPEFY/yy1C9Bd9q3x06aNRtzCBYe7kWMAL/WhSpgqDkaveMw2W0w1njUfLBGyFxj+pW6dAs4yAlcIgUeuOP2du8L02vIVIuLZhBttpsZywlY7tbVmLs+P/W44EYBHjyk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MmONwUUK; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768153194; x=1799689194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YTXRv7UWsEAyLSmysnjf/fdBgcKj8NnlFKyMj/cjSw8=;
  b=MmONwUUKlYzzIST8ETsI5Qcu1x2e06MHR5ucjAChBi+BTMsh1VGEfQs4
   QlJ9LaVFvJ9x8W4GVKZ77wrzDmycb5ZHfOzMZL2LZtLy0AGVzY+RlBMFm
   akiUf+M7VVcAS2XPuyz9KeTiITyiOLdimdi9DFixxEx7F1tzZZWu1aAST
   HmIBAF+p9O88015a+M5/E1B1rDcA+sjllPpDdfNe8KmnynFnJ23/hbnkF
   jX0nJKOad7NQw8a3kZRmjwF+ACnJ3LwR0QA45RA4DHNRyFxVC/aLtzGlM
   ckmPwRn5xAf1ZUQf0MH6vIjSK6rsmC9vW88SIJHm5annIvEgxgH1NchMR
   g==;
X-CSE-ConnectionGUID: vCIm9PQpSOO8X4fF4+z3GQ==
X-CSE-MsgGUID: sAH2TepdS+mWiXfnHTl5Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69521099"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69521099"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:53 -0800
X-CSE-ConnectionGUID: +ajKkOkuT46rHM625YaeaQ==
X-CSE-MsgGUID: O7YbkVanTzqFB6yl+4Vg+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="208393818"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:52 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Nidhish A N <nidhish.a.n@intel.com>,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: mvm: Remove link_id from time_events
Date: Sun, 11 Jan 2026 19:39:25 +0200
Message-Id: <20260111193638.9475bb832db6.I5829b0a2a9a5b56fe885eb0f1e1ad8cd70bc69ff@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260111173926.2216629-1-miriam.rachel.korenblit@intel.com>
References: <20260111173926.2216629-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Nidhish A N <nidhish.a.n@intel.com>

As part of removal of EMLSR support from mvm, remove
link_id parameter from time_events. Additionally,
remove link_id parameter from iwl_mvm_protect_assoc
as we can now directly use deflink.

Signed-off-by: Nidhish A N <nidhish.a.n@intel.com>
Reviewed-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  9 ++---
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c |  4 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   | 39 ++++++-------------
 .../wireless/intel/iwlwifi/mvm/time-event.h   |  4 +-
 6 files changed, 21 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index a9022ae4504f..169c87588938 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2601,7 +2601,7 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 }
 
 void iwl_mvm_protect_assoc(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			   u32 duration_override, unsigned int link_id)
+			   u32 duration_override)
 {
 	u32 duration = IWL_MVM_TE_SESSION_PROTECTION_MAX_TIME_MS;
 	u32 min_duration = IWL_MVM_TE_SESSION_PROTECTION_MIN_TIME_MS;
@@ -2621,8 +2621,7 @@ void iwl_mvm_protect_assoc(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (fw_has_capa(&mvm->fw->ucode_capa,
 			IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD))
 		iwl_mvm_schedule_session_protection(mvm, vif, 900,
-						    min_duration, false,
-						    link_id);
+						    min_duration, false);
 	else
 		iwl_mvm_protect_session(mvm, vif, duration,
 					min_duration, 500, false);
@@ -2822,7 +2821,7 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 				 * time could be small without us having heard
 				 * a beacon yet.
 				 */
-				iwl_mvm_protect_assoc(mvm, vif, 0, 0);
+				iwl_mvm_protect_assoc(mvm, vif, 0);
 			}
 
 			iwl_mvm_sf_update(mvm, vif, false);
@@ -4152,7 +4151,7 @@ void iwl_mvm_mac_mgd_prepare_tx(struct ieee80211_hw *hw,
 		return;
 
 	guard(mvm)(mvm);
-	iwl_mvm_protect_assoc(mvm, vif, info->duration, info->link_id);
+	iwl_mvm_protect_assoc(mvm, vif, info->duration);
 }
 
 void iwl_mvm_mac_mgd_complete_tx(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 5829a8b45a89..075ff09e93cc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -662,7 +662,7 @@ static void iwl_mvm_mld_vif_cfg_changed_station(struct iwl_mvm *mvm,
 				 * time could be small without us having heard
 				 * a beacon yet.
 				 */
-				iwl_mvm_protect_assoc(mvm, vif, 0, -1);
+				iwl_mvm_protect_assoc(mvm, vif, 0);
 			}
 
 			iwl_mvm_sf_update(mvm, vif, false);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index f3685292b834..db5f9804b529 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -120,7 +120,6 @@ struct iwl_mvm_time_event_data {
 	 * if the te is in the time event list or not (when id == TE_MAX)
 	 */
 	u32 id;
-	s8 link_id;
 };
 
  /* Power management */
@@ -2009,7 +2008,7 @@ int iwl_mvm_cancel_roc(struct ieee80211_hw *hw,
 		       struct ieee80211_vif *vif);
 /*Session Protection */
 void iwl_mvm_protect_assoc(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			   u32 duration_override, unsigned int link_id);
+			   u32 duration_override);
 
 /* Quota management */
 static inline size_t iwl_mvm_quota_cmd_size(struct iwl_mvm *mvm)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
index 36379b738de1..4945ebf19f6b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2014 Intel Mobile Communications GmbH
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2020, 2022-2024 Intel Corporation
+ * Copyright (C) 2018-2020, 2022-2025 Intel Corporation
  */
 #include <linux/etherdevice.h>
 #include "mvm.h"
@@ -155,7 +155,7 @@ void iwl_mvm_mac_mgd_protect_tdls_discover(struct ieee80211_hw *hw,
 	if (fw_has_capa(&mvm->fw->ucode_capa,
 			IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD))
 		iwl_mvm_schedule_session_protection(mvm, vif, duration,
-						    duration, true, link_id);
+						    duration, true);
 	else
 		iwl_mvm_protect_session(mvm, vif, duration,
 					duration, 100, true);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 0b12ee8ad618..2b52a4f3bff9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -42,7 +42,6 @@ void iwl_mvm_te_clear_data(struct iwl_mvm *mvm,
 	te_data->uid = 0;
 	te_data->id = TE_MAX;
 	te_data->vif = NULL;
-	te_data->link_id = -1;
 }
 
 static void iwl_mvm_cleanup_roc(struct iwl_mvm *mvm)
@@ -721,8 +720,7 @@ void iwl_mvm_protect_session(struct iwl_mvm *mvm,
 
 /* Determine whether mac or link id should be used, and validate the link id */
 static int iwl_mvm_get_session_prot_id(struct iwl_mvm *mvm,
-				       struct ieee80211_vif *vif,
-				       s8 link_id)
+				       struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	int ver = iwl_fw_lookup_cmd_ver(mvm->fw,
@@ -732,22 +730,18 @@ static int iwl_mvm_get_session_prot_id(struct iwl_mvm *mvm,
 	if (ver < 2)
 		return mvmvif->id;
 
-	if (WARN(link_id < 0 || !mvmvif->link[link_id],
-		 "Invalid link ID for session protection: %u\n", link_id))
-		return -EINVAL;
-
-	if (WARN(!mvmvif->link[link_id]->active,
-		 "Session Protection on an inactive link: %u\n", link_id))
+	if (WARN(!mvmvif->deflink.active,
+		 "Session Protection on an inactive link\n"))
 		return -EINVAL;
 
-	return mvmvif->link[link_id]->fw_link_id;
+	return mvmvif->deflink.fw_link_id;
 }
 
 static void iwl_mvm_cancel_session_protection(struct iwl_mvm *mvm,
 					      struct ieee80211_vif *vif,
-					      u32 id, s8 link_id)
+					      u32 id)
 {
-	int mac_link_id = iwl_mvm_get_session_prot_id(mvm, vif, link_id);
+	int mac_link_id = iwl_mvm_get_session_prot_id(mvm, vif);
 	struct iwl_session_prot_cmd cmd = {
 		.id_and_color = cpu_to_le32(mac_link_id),
 		.action = cpu_to_le32(FW_CTXT_ACTION_REMOVE),
@@ -791,7 +785,6 @@ static bool __iwl_mvm_remove_time_event(struct iwl_mvm *mvm,
 	struct ieee80211_vif *vif = te_data->vif;
 	struct iwl_mvm_vif *mvmvif;
 	enum nl80211_iftype iftype;
-	s8 link_id;
 	bool p2p_aux = iwl_mvm_has_p2p_over_aux(mvm);
 	u8 roc_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
 					   WIDE_ID(MAC_CONF_GROUP, ROC_CMD), 0);
@@ -811,7 +804,6 @@ static bool __iwl_mvm_remove_time_event(struct iwl_mvm *mvm,
 	/* Save time event uid before clearing its data */
 	*uid = te_data->uid;
 	id = te_data->id;
-	link_id = te_data->link_id;
 
 	/*
 	 * The clear_data function handles time events that were already removed
@@ -837,8 +829,7 @@ static bool __iwl_mvm_remove_time_event(struct iwl_mvm *mvm,
 		 */
 		if (mvmvif && id < SESSION_PROTECT_CONF_MAX_ID) {
 			/* Session protection is still ongoing. Cancel it */
-			iwl_mvm_cancel_session_protection(mvm, vif, id,
-							  link_id);
+			iwl_mvm_cancel_session_protection(mvm, vif, id);
 			if (iftype == NL80211_IFTYPE_P2P_DEVICE) {
 				iwl_mvm_roc_finished(mvm);
 			}
@@ -1007,7 +998,6 @@ void iwl_mvm_rx_session_protect_notif(struct iwl_mvm *mvm,
 	if (!le32_to_cpu(notif->status) || !le32_to_cpu(notif->start)) {
 		/* End TE, notify mac80211 */
 		mvmvif->time_event_data.id = SESSION_PROTECT_CONF_MAX_ID;
-		mvmvif->time_event_data.link_id = -1;
 		/* set the bit so the ROC cleanup will actually clean up */
 		set_bit(IWL_MVM_STATUS_ROC_P2P_RUNNING, &mvm->status);
 		iwl_mvm_roc_finished(mvm);
@@ -1132,7 +1122,7 @@ iwl_mvm_start_p2p_roc_session_protection(struct iwl_mvm *mvm,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_session_prot_cmd cmd = {
 		.id_and_color =
-			cpu_to_le32(iwl_mvm_get_session_prot_id(mvm, vif, 0)),
+			cpu_to_le32(iwl_mvm_get_session_prot_id(mvm, vif)),
 		.action = cpu_to_le32(FW_CTXT_ACTION_ADD),
 		.duration_tu = cpu_to_le32(MSEC_TO_TU(duration)),
 	};
@@ -1143,8 +1133,6 @@ iwl_mvm_start_p2p_roc_session_protection(struct iwl_mvm *mvm,
 	 * protection's configuration.
 	 */
 
-	mvmvif->time_event_data.link_id = 0;
-
 	switch (type) {
 	case IEEE80211_ROC_TYPE_NORMAL:
 		mvmvif->time_event_data.id =
@@ -1290,8 +1278,7 @@ void iwl_mvm_stop_roc(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 				return;
 			}
 			iwl_mvm_cancel_session_protection(mvm, vif,
-							  te_data->id,
-							  te_data->link_id);
+							  te_data->id);
 		} else {
 			iwl_mvm_remove_aux_roc_te(mvm, mvmvif,
 						  &mvmvif->hs_time_event_data);
@@ -1423,14 +1410,13 @@ static bool iwl_mvm_session_prot_notif(struct iwl_notif_wait_data *notif_wait,
 void iwl_mvm_schedule_session_protection(struct iwl_mvm *mvm,
 					 struct ieee80211_vif *vif,
 					 u32 duration, u32 min_duration,
-					 bool wait_for_notif,
-					 unsigned int link_id)
+					 bool wait_for_notif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_time_event_data *te_data = &mvmvif->time_event_data;
 	const u16 notif[] = { WIDE_ID(MAC_CONF_GROUP, SESSION_PROTECTION_NOTIF) };
 	struct iwl_notification_wait wait_notif;
-	int mac_link_id = iwl_mvm_get_session_prot_id(mvm, vif, (s8)link_id);
+	int mac_link_id = iwl_mvm_get_session_prot_id(mvm, vif);
 	struct iwl_session_prot_cmd cmd = {
 		.id_and_color = cpu_to_le32(mac_link_id),
 		.action = cpu_to_le32(FW_CTXT_ACTION_ADD),
@@ -1444,7 +1430,7 @@ void iwl_mvm_schedule_session_protection(struct iwl_mvm *mvm,
 	lockdep_assert_held(&mvm->mutex);
 
 	spin_lock_bh(&mvm->time_event_lock);
-	if (te_data->running && te_data->link_id == link_id &&
+	if (te_data->running &&
 	    time_after(te_data->end_jiffies, TU_TO_EXP_TIME(min_duration))) {
 		IWL_DEBUG_TE(mvm, "We have enough time in the current TE: %u\n",
 			     jiffies_to_msecs(te_data->end_jiffies - jiffies));
@@ -1461,7 +1447,6 @@ void iwl_mvm_schedule_session_protection(struct iwl_mvm *mvm,
 	te_data->id = le32_to_cpu(cmd.conf_id);
 	te_data->duration = le32_to_cpu(cmd.duration_tu);
 	te_data->vif = vif;
-	te_data->link_id = link_id;
 	spin_unlock_bh(&mvm->time_event_lock);
 
 	IWL_DEBUG_TE(mvm, "Add new session protection, duration %d TU\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h
index 1ef8768756db..3f8628cbd480 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h
@@ -210,13 +210,11 @@ iwl_mvm_te_scheduled(struct iwl_mvm_time_event_data *te_data)
  * @duration: the requested duration of the protection
  * @min_duration: the minimum duration of the protection
  * @wait_for_notif: if true, will block until the start of the protection
- * @link_id: The link to schedule a session protection for
  */
 void iwl_mvm_schedule_session_protection(struct iwl_mvm *mvm,
 					 struct ieee80211_vif *vif,
 					 u32 duration, u32 min_duration,
-					 bool wait_for_notif,
-					 unsigned int link_id);
+					 bool wait_for_notif);
 
 /**
  * iwl_mvm_rx_session_protect_notif - handles %SESSION_PROTECTION_NOTIF
-- 
2.34.1


