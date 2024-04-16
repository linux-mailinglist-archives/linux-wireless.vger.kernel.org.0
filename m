Return-Path: <linux-wireless+bounces-6385-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D94588A6926
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 12:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5141C20F01
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 10:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE24127E3D;
	Tue, 16 Apr 2024 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PX1vabYg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B24128814
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264882; cv=none; b=nkHYlMPaHoxbHwbEyjkTzFrlXg+CrgJt/4n6HRQ6XJldDyr/4nIbvG74hSAM9JvyRbrdssV0vkyqTiGd9bXFnKE5HJkT+3zrKSEbWoMkbF2XxIIkbXQ1ViVDkuYFZbT6p6+jHHxU+NPV+tPVnIXJjdoLf3uewE6Dgt6WZLpGSV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264882; c=relaxed/simple;
	bh=VrJzXROkX14H2hY3bYdiMMRhdya+sqsonzuWvZ6VrXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V2ijxHXPmnYeJm/h/N4MlfJjgVnoY83PCT8xEpVfpz7/J1baYUGLEtD744ib2GWZCgG0p7LIYogxRcUXoBxscUb74BjAdZ1WbX/Zw1SM8u1Z6nuJ0+moBBBxFtqtEoFWmNv+YFLvtZttvdR19sqZgOStVjW5iYqupDOBUdUvLOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PX1vabYg; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713264881; x=1744800881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VrJzXROkX14H2hY3bYdiMMRhdya+sqsonzuWvZ6VrXg=;
  b=PX1vabYgYaYfomlK4+fgTxbLQxzZ45tmO3tTWk6yTvKptPLC37Ckx7sN
   ZEQn3aHap0cD7k4QjVbnQB5PO0bv0u2w2AvvQLNByRYKSdaUJ929AAd/Y
   TNabvj62eQaY8/qiG2JhtGtGIUXJtGdEXoKD1lPIrx1r2pSZ+Psxr8R4G
   q105uZlJ2W6NB5/2VAa50DIyc8iXsYBcB0v0/ifUHSprgUME+NksAlJOR
   h5nharzEe/A1/c4fxUUFWo+RkFZb25vWeUA0yYjRTSOC4HkJAqLHqGh3R
   wI4OgI+Qx0951spmMvO/v2N94tf3/vFMRhjMUxlRnv1//RerEMYhswfWH
   Q==;
X-CSE-ConnectionGUID: Yb7Qc7bdT0y/U0wyi/+0tQ==
X-CSE-MsgGUID: 6wIBjIwISFWIpfgf3QF9fA==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8556054"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8556054"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:41 -0700
X-CSE-ConnectionGUID: lbcehOVASYK+leVvcFMoXw==
X-CSE-MsgGUID: eIJ4cnJgQKKpwb9YptWVjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="26872524"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:37 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 09/16] wifi: iwlwifi: mvm: Add helper functions to update EMLSR status
Date: Tue, 16 Apr 2024 13:54:04 +0300
Message-Id: <20240416134215.d54142a75876.I552926065521f5f848c37b0bd845494bd7865fb7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416105411.706221-1-miriam.rachel.korenblit@intel.com>
References: <20240416105411.706221-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

There are reasons for which we need to exit EMLSR, but not to block it
completely, and there are reasons for which we need to block EMLSR.

For both reason types we have the enum iwl_mvm_esr_state, when the
blocking reasons are stored in the `mvmvif::esr_disable_reason` bitmap.

This change introduces the APIs to use in the different cases:
- iwl_mvm_exit_esr - will exit from EMLSR mode.
- iwl_mvm_block_esr - will update the bitmap and exit EMLSR, to
  be used for the blocking reasons only.
- iwl_mvm_unblock_esr - will update the bitmap. To be used for the
  blocking reasons only.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c | 33 +++------
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 71 ++++++++++++++++++-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 24 +------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 25 +++++--
 4 files changed, 98 insertions(+), 55 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
index 54f086d9457f..c7987676335a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
@@ -253,28 +253,6 @@ static void iwl_mvm_bt_coex_tcm_based_ci(struct iwl_mvm *mvm,
 	swap(data->primary, data->secondary);
 }
 
-static void iwl_mvm_bt_coex_enable_esr(struct iwl_mvm *mvm,
-				       struct ieee80211_vif *vif, bool enable)
-{
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-
-	lockdep_assert_held(&mvm->mutex);
-
-	if (!vif->cfg.assoc || !ieee80211_vif_is_mld(vif))
-		return;
-
-	/* Done already */
-	if ((mvmvif->esr_disable_reason & IWL_MVM_ESR_DISABLE_COEX) == !enable)
-		return;
-
-	if (enable)
-		mvmvif->esr_disable_reason &= ~IWL_MVM_ESR_DISABLE_COEX;
-	else
-		mvmvif->esr_disable_reason |= IWL_MVM_ESR_DISABLE_COEX;
-
-	iwl_mvm_recalc_esr(mvm, vif);
-}
-
 /*
  * This function receives the LB link id and checks if eSR should be
  * enabled or disabled (due to BT coex)
@@ -320,7 +298,7 @@ iwl_mvm_bt_coex_calculate_esr_mode(struct iwl_mvm *mvm,
 	if (!link_rssi)
 		wifi_loss_rate = mvm->last_bt_notif.wifi_loss_mid_high_rssi;
 
-	else if (!(mvmvif->esr_disable_reason & IWL_MVM_ESR_DISABLE_COEX))
+	else if (!(mvmvif->esr_disable_reason & IWL_MVM_ESR_BLOCKED_COEX))
 		 /* RSSI needs to get really low to disable eSR... */
 		wifi_loss_rate =
 			link_rssi <= -IWL_MVM_BT_COEX_DISABLE_ESR_THRESH ?
@@ -348,7 +326,12 @@ void iwl_mvm_bt_coex_update_link_esr(struct iwl_mvm *mvm,
 
 	enable = iwl_mvm_bt_coex_calculate_esr_mode(mvm, vif, link_id);
 
-	iwl_mvm_bt_coex_enable_esr(mvm, vif, enable);
+	if (enable)
+		iwl_mvm_unblock_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_COEX);
+	else
+		/* In case we decided to exit eSR - stay with the primary */
+		iwl_mvm_block_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_COEX,
+				  iwl_mvm_get_primary_link(vif));
 }
 
 static void iwl_mvm_bt_notif_per_link(struct iwl_mvm *mvm,
@@ -534,7 +517,7 @@ static void iwl_mvm_bt_notif_iterator(void *_data, u8 *mac,
 
 	/* When BT is off this will be 0 */
 	if (data->notif->wifi_loss_low_rssi == BT_OFF)
-		iwl_mvm_bt_coex_enable_esr(mvm, vif, true);
+		iwl_mvm_unblock_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_COEX);
 
 	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++)
 		iwl_mvm_bt_notif_per_link(mvm, vif, data, link_id);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 710c8802a3c6..8a4b1b89791c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -560,7 +560,7 @@ bool iwl_mvm_mld_valid_link_pair(struct ieee80211_vif *vif,
 
 	/* BT Coex effects eSR mode only if one of the link is on LB */
 	if (a->band == NL80211_BAND_2GHZ || b->band == NL80211_BAND_2GHZ)
-		return !(mvmvif->esr_disable_reason & IWL_MVM_ESR_DISABLE_COEX);
+		return !(mvmvif->esr_disable_reason & IWL_MVM_ESR_BLOCKED_COEX);
 
 	return true;
 }
@@ -691,3 +691,72 @@ u8 iwl_mvm_get_primary_link(struct ieee80211_vif *vif)
 
 	return __ffs(vif->active_links);
 }
+
+/* API to exit eSR mode */
+void iwl_mvm_exit_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+		      enum iwl_mvm_esr_state reason,
+		      u8 link_to_keep)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	u16 new_active_links;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	/* Nothing to do */
+	if (!mvmvif->esr_active)
+		return;
+
+	if (WARN_ON(!ieee80211_vif_is_mld(vif) || !mvmvif->authorized))
+		return;
+
+	if (WARN_ON(!(vif->active_links & BIT(link_to_keep))))
+		link_to_keep = __ffs(vif->active_links);
+
+	new_active_links = BIT(link_to_keep);
+	IWL_DEBUG_INFO(mvm,
+		       "Exiting EMLSR. Reason = 0x%x. Current active links=0x%x, new active links = 0x%x\n",
+		       reason, vif->active_links, new_active_links);
+
+	ieee80211_set_active_links_async(vif, new_active_links);
+}
+
+#define IWL_MVM_BLOCK_ESR_REASONS IWL_MVM_ESR_BLOCKED_COEX
+
+void iwl_mvm_block_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+		       enum iwl_mvm_esr_state reason,
+		       u8 link_to_keep)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
+	lockdep_assert_held(&mvm->mutex);
+
+	/* This should be called only with disable reasons */
+	if (WARN_ON(!(reason & IWL_MVM_BLOCK_ESR_REASONS)))
+		return;
+
+	if (!(mvmvif->esr_disable_reason & reason))
+		IWL_DEBUG_INFO(mvm, "Blocking EMSLR mode. reason = 0x%x\n",
+			       reason);
+
+	mvmvif->esr_disable_reason |= reason;
+
+	iwl_mvm_exit_esr(mvm, vif, reason, link_to_keep);
+}
+
+void iwl_mvm_unblock_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			 enum iwl_mvm_esr_state reason)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
+	lockdep_assert_held(&mvm->mutex);
+
+	/* This should be called only with disable reasons */
+	if (WARN_ON(!(reason & IWL_MVM_BLOCK_ESR_REASONS)))
+		return;
+
+	if (mvmvif->esr_disable_reason & reason)
+		IWL_DEBUG_INFO(mvm, "Unblocking EMSLR mode. reason = 0x%x\n",
+			       reason);
+
+	mvmvif->esr_disable_reason &= ~reason;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 105ac43e4cd7..2a7d7d4e0649 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1151,28 +1151,6 @@ iwl_mvm_mld_change_sta_links(struct ieee80211_hw *hw,
 	return ret;
 }
 
-void iwl_mvm_recalc_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
-{
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	bool enable = !mvmvif->esr_disable_reason;
-	u16 new_active_links;
-
-	/* Nothing to do */
-	if (mvmvif->esr_active == enable)
-		return;
-
-	/* The next link selection will enter eSR if possible */
-	if (enable)
-		return;
-
-	/*
-	 * Find the primary link, as we want to switch to it and drop the
-	 * secondary one.
-	 */
-	new_active_links = BIT(iwl_mvm_get_primary_link(vif));
-	ieee80211_set_active_links_async(vif, new_active_links);
-}
-
 bool iwl_mvm_esr_allowed_on_vif(struct iwl_mvm *mvm,
 				struct ieee80211_vif *vif)
 {
@@ -1194,7 +1172,7 @@ bool iwl_mvm_esr_allowed_on_vif(struct iwl_mvm *mvm,
 	    !(ext_capa->eml_capabilities & IEEE80211_EML_CAP_EMLSR_SUPP))
 		return false;
 
-	return !(mvmvif->esr_disable_reason & ~IWL_MVM_ESR_DISABLE_COEX);
+	return !(mvmvif->esr_disable_reason & ~IWL_MVM_ESR_BLOCKED_COEX);
 }
 
 /*
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 4755747822b6..3b726c8b9261 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -346,11 +346,17 @@ struct iwl_mvm_vif_link_info {
 };
 
 /**
- * enum iwl_mvm_esr_disable_reason - reasons for which we can't enable EMLSR
- * @IWL_MVM_ESR_DISABLE_COEX: COEX is preventing the enablement of EMLSR
+ * enum iwl_mvm_esr_state - defines reasons for which the EMLSR is exited or
+ * blocked.
+ * The low 16 bits are used for blocking reasons, and the 16 higher bits
+ * are used for exit reasons.
+ * For the blocking reasons - use iwl_mvm_(un)block_esr(), and for the exit
+ * reasons - use iwl_mvm_exit_esr().
+ *
+ * @IWL_MVM_ESR_BLOCKED_COEX: COEX is preventing the enablement of EMLSR
  */
-enum iwl_mvm_esr_disable_reason {
-	IWL_MVM_ESR_DISABLE_COEX	= BIT(0),
+enum iwl_mvm_esr_state {
+	IWL_MVM_ESR_BLOCKED_COEX	= 0x1,
 };
 
 /**
@@ -386,7 +392,7 @@ enum iwl_mvm_esr_disable_reason {
  * @deflink: default link data for use in non-MLO
  * @link: link data for each link in MLO
  * @esr_active: indicates eSR mode is active
- * @esr_disable_reason: a bitmap of enum iwl_mvm_esr_disable_reason
+ * @esr_disable_reason: a bitmap of &enum iwl_mvm_esr_state
  * @pm_enabled: indicates powersave is enabled
  * @link_selection_res: bitmap of active links as it was decided in the last
  *	link selection. Valid only for a MLO vif after assoc. 0 if there wasn't
@@ -2836,8 +2842,15 @@ int iwl_mvm_roc_add_cmd(struct iwl_mvm *mvm,
 			int duration, u32 activity);
 
 /* EMLSR */
-void iwl_mvm_recalc_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 bool iwl_mvm_esr_allowed_on_vif(struct iwl_mvm *mvm,
 				struct ieee80211_vif *vif);
+void iwl_mvm_block_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+		       enum iwl_mvm_esr_state reason,
+		       u8 link_to_keep);
+void iwl_mvm_unblock_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			 enum iwl_mvm_esr_state reason);
+void iwl_mvm_exit_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+		      enum iwl_mvm_esr_state reason,
+		      u8 link_to_keep);
 
 #endif /* __IWL_MVM_H__ */
-- 
2.34.1


