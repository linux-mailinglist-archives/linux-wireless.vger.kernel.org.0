Return-Path: <linux-wireless+bounces-7180-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7058BBF6E
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 08:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B862B1F217AA
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 06:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE461C3E;
	Sun,  5 May 2024 06:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rf5o3zpJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1948E3FD4
	for <linux-wireless@vger.kernel.org>; Sun,  5 May 2024 06:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714890020; cv=none; b=YEU+Esln5EPSzeipbQffLgVocaKOiyHwOxWAwasZdAXHjVHqJ7VQJGnjcrY37dR1lI2RzxwaQb1+97rivPpiprpwAyLhBCvt3B4JycB0WD1FpDYROOf8oYa9RH7b7be/Z63eJz7EXZb6wjXxwH/uaNoXEaVnxXfTr89OWd699QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714890020; c=relaxed/simple;
	bh=dTMG+ige7glXHhJSBxP4GBZNgh7d6KxbXt6y2SlTs4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kpz/YGcOV9OACOduoprSytlfcon6V06JPRpW00qGc7l5FpIcRe9i5Vmut/Y7iuVEer8i5XrKCZjnyVmsXSwA4xFykQLaFO3cccsHDFfFnPqTSYwLH6Vb8o7iVMtn35pWlWkKbV/jGp7+jnrBRWTIjx9hGcG5yQRXzdIQSC9cM3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rf5o3zpJ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714890018; x=1746426018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dTMG+ige7glXHhJSBxP4GBZNgh7d6KxbXt6y2SlTs4Q=;
  b=Rf5o3zpJoO8KYLXze6py9AKZHNqH02acmHSXLReU//4WWrz/weqbNUPF
   7rLbKdsKQ79DnTz2IRchUk74iF3ZQJ4X9zYP8XwBHt/ToGp4FbfeXVV0b
   vIrZ9DY/9B/gdQ/6Z7MnT58TEJZUSHtYYT4350t9GQvTgVy+U5ERhsguI
   ttpld4b4NLkeBiqGzs+KWjaOX6Nn764XmDEiVn/5UMelt790PTs/0YRPd
   1ogPmj36ahhXmqYnhLO7TxchCI4E6CYvmQOp+oKzCvkcrbz+cSokEaV5x
   LaGCgFf+5W9OPKtqPnE90BGFDJ/umP+DOXy2TmouLNsYrM+GQjzxIziTQ
   A==;
X-CSE-ConnectionGUID: NeWpUjYNSbO6pySMhGk6TA==
X-CSE-MsgGUID: Eg+jgjdYRHmYCgz+PAAKMg==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="14461803"
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="14461803"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:14 -0700
X-CSE-ConnectionGUID: OfJU4f5xTBGbR3hzNBo9Rw==
X-CSE-MsgGUID: UtiFhHNDSR6E7kQEcGqOpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="27903575"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:13 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 02/15] wifi: iwlwifi: mvm: trigger link selection after exiting EMLSR
Date: Sun,  5 May 2024 09:19:46 +0300
Message-Id: <20240505091420.6a808c4ae8f5.Ia79605838eb6deee9358bec633ef537f2653db92@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240505061959.825245-1-miriam.rachel.korenblit@intel.com>
References: <20240505061959.825245-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

If the reason for exiting EMLSR was a blocking reason, wait for the
corresponding unblocking event:
- if there is an ongoing scan - do nothing. Link selection will be
  triggered at the end of it.
- If more than 30 seconds passed since the exit, trigger MLO scan, which
  will trigger link selection
- If less then 30 seconds passed since exit, reuse the latest link
  selection result

If the reason for exiting EMLSR was an exit reason (IWL_MVM_EXIT_*),
schedule MLO scan in 30 seconds.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/constants.h    |   1 +
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  |  26 +----
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 102 ++++++++++++++----
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  26 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |  49 ++++++++-
 6 files changed, 158 insertions(+), 52 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index d80b21ffbc0a..965fbad05531 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -14,6 +14,7 @@
 #define IWL_MVM_BT_COEX_DISABLE_ESR_THRESH	69
 #define IWL_MVM_BT_COEX_ENABLE_ESR_THRESH	63
 #define IWL_MVM_BT_COEX_WIFI_LOSS_THRESH	0
+#define IWL_MVM_TRIGGER_LINK_SEL_TIME_SEC	30
 
 #define IWL_MVM_DEFAULT_PS_TX_DATA_TIMEOUT	(100 * USEC_PER_MSEC)
 #define IWL_MVM_DEFAULT_PS_RX_DATA_TIMEOUT	(100 * USEC_PER_MSEC)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
index af56a55063a7..aad736b7354b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
@@ -712,31 +712,7 @@ static ssize_t iwl_dbgfs_int_mlo_scan_write(struct ieee80211_vif *vif,
 	if (!action) {
 		ret = iwl_mvm_scan_stop(mvm, IWL_MVM_SCAN_INT_MLO, false);
 	} else if (action == 1) {
-		struct ieee80211_channel *channels[IEEE80211_MLD_MAX_NUM_LINKS];
-		unsigned long usable_links = ieee80211_vif_usable_links(vif);
-		size_t n_channels = 0;
-		u8 link_id;
-
-		rcu_read_lock();
-
-		for_each_set_bit(link_id, &usable_links,
-				 IEEE80211_MLD_MAX_NUM_LINKS) {
-			struct ieee80211_bss_conf *link_conf =
-				rcu_dereference(vif->link_conf[link_id]);
-
-			if (WARN_ON_ONCE(!link_conf))
-				continue;
-
-			channels[n_channels++] = link_conf->chanreq.oper.chan;
-		}
-
-		rcu_read_unlock();
-
-		if (n_channels)
-			ret = iwl_mvm_int_mlo_scan_start(mvm, vif, channels,
-							 n_channels);
-		else
-			ret = -EINVAL;
+		ret = iwl_mvm_int_mlo_scan(mvm, vif);
 	} else {
 		ret = -EINVAL;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 733e1f77c171..32ae606a0aa7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -787,37 +787,42 @@ u8 iwl_mvm_get_other_link(struct ieee80211_vif *vif, u8 link_id)
 #define IWL_MVM_ESR_PREVENT_SHORT	(HZ * 300)
 #define IWL_MVM_ESR_PREVENT_LONG	(HZ * 600)
 
-static void iwl_mvm_recalc_esr_prevention(struct iwl_mvm *mvm,
-					  struct iwl_mvm_vif *mvmvif,
-					  enum iwl_mvm_esr_state reason)
+static bool iwl_mvm_check_esr_prevention(struct iwl_mvm *mvm,
+					 struct iwl_mvm_vif *mvmvif,
+					 enum iwl_mvm_esr_state reason)
 {
-	unsigned long now = jiffies;
+	bool timeout_expired = time_after(jiffies,
+					  mvmvif->last_esr_exit.ts +
+					  IWL_MVM_PREVENT_ESR_TIMEOUT);
 	unsigned long delay;
-	bool timeout_expired =
-		time_after(now, mvmvif->last_esr_exit.ts +
-				IWL_MVM_PREVENT_ESR_TIMEOUT);
-
-	if (WARN_ON(!(IWL_MVM_ESR_PREVENT_REASONS & reason)))
-		return;
 
 	lockdep_assert_held(&mvm->mutex);
 
-	mvmvif->last_esr_exit.ts = now;
+	/* Only handle reasons that can cause prevention */
+	if (!(reason & IWL_MVM_ESR_PREVENT_REASONS))
+		return false;
 
-	if (timeout_expired ||
-	    mvmvif->last_esr_exit.reason != reason) {
-		mvmvif->last_esr_exit.reason = reason;
+	/*
+	 * Reset the counter if more than 400 seconds have passed between one
+	 * exit and the other, or if we exited due to a different reason.
+	 * Will also reset the counter after the long prevention is done.
+	 */
+	if (timeout_expired || mvmvif->last_esr_exit.reason != reason) {
 		mvmvif->exit_same_reason_count = 1;
-		return;
+		return false;
 	}
 
 	mvmvif->exit_same_reason_count++;
 	if (WARN_ON(mvmvif->exit_same_reason_count < 2 ||
 		    mvmvif->exit_same_reason_count > 3))
-		return;
+		return false;
 
 	mvmvif->esr_disable_reason |= IWL_MVM_ESR_BLOCKED_PREVENTION;
 
+	/*
+	 * For the second exit, use a short prevention, and for the third one,
+	 * use a long prevention.
+	 */
 	delay = mvmvif->exit_same_reason_count == 2 ?
 		IWL_MVM_ESR_PREVENT_SHORT :
 		IWL_MVM_ESR_PREVENT_LONG;
@@ -828,8 +833,11 @@ static void iwl_mvm_recalc_esr_prevention(struct iwl_mvm *mvm,
 
 	wiphy_delayed_work_queue(mvm->hw->wiphy,
 				 &mvmvif->prevent_esr_done_wk, delay);
+	return true;
 }
 
+#define IWL_MVM_TRIGGER_LINK_SEL_TIME (IWL_MVM_TRIGGER_LINK_SEL_TIME_SEC * HZ)
+
 /* API to exit eSR mode */
 void iwl_mvm_exit_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		      enum iwl_mvm_esr_state reason,
@@ -837,6 +845,7 @@ void iwl_mvm_exit_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	u16 new_active_links;
+	bool prevented;
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -857,8 +866,25 @@ void iwl_mvm_exit_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	ieee80211_set_active_links_async(vif, new_active_links);
 
-	if (IWL_MVM_ESR_PREVENT_REASONS & reason)
-		iwl_mvm_recalc_esr_prevention(mvm, mvmvif, reason);
+	/* Prevent EMLSR if needed */
+	prevented = iwl_mvm_check_esr_prevention(mvm, mvmvif, reason);
+
+	/* Remember why and when we exited EMLSR */
+	mvmvif->last_esr_exit.ts = jiffies;
+	mvmvif->last_esr_exit.reason = reason;
+
+	/*
+	 * If EMLSR is prevented now - don't try to get back to EMLSR.
+	 * If we exited due to a blocking event, we will try to get back to
+	 * EMLSR when the corresponding unblocking event will happen.
+	 */
+	if (prevented || reason & IWL_MVM_BLOCK_ESR_REASONS)
+		return;
+
+	/* If EMLSR is not blocked - try enabling it again in 30 seconds */
+	wiphy_delayed_work_queue(mvm->hw->wiphy,
+				 &mvmvif->mlo_int_scan_wk,
+				 round_jiffies_relative(IWL_MVM_TRIGGER_LINK_SEL_TIME));
 }
 
 void iwl_mvm_block_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
@@ -882,6 +908,43 @@ void iwl_mvm_block_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	iwl_mvm_exit_esr(mvm, vif, reason, link_to_keep);
 }
 
+static void iwl_mvm_esr_unblocked(struct iwl_mvm *mvm,
+				  struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	bool need_new_sel = time_after(jiffies, mvmvif->last_esr_exit.ts +
+						IWL_MVM_TRIGGER_LINK_SEL_TIME);
+
+	lockdep_assert_held(&mvm->mutex);
+
+	if (!ieee80211_vif_is_mld(vif) || !mvmvif->authorized ||
+	    mvmvif->esr_active)
+		return;
+
+	IWL_DEBUG_INFO(mvm, "EMLSR is unblocked\n");
+
+	/*
+	 * If EMLSR was blocked for more than 30 seconds, or the last link
+	 * selection decided to not enter EMLSR, trigger a new scan.
+	 */
+	if (need_new_sel || hweight16(mvmvif->link_selection_res) < 2) {
+		IWL_DEBUG_INFO(mvm, "Trigger MLO scan\n");
+		wiphy_delayed_work_queue(mvm->hw->wiphy,
+					 &mvmvif->mlo_int_scan_wk, 0);
+	/*
+	 * If EMLSR was blocked for less than 30 seconds, and the last link
+	 * selection decided to use EMLSR, activate EMLSR using the previous
+	 * link selection result.
+	 */
+	} else {
+		IWL_DEBUG_INFO(mvm,
+			       "Use the latest link selection result: 0x%x\n",
+			       mvmvif->link_selection_res);
+		ieee80211_set_active_links_async(vif,
+						 mvmvif->link_selection_res);
+	}
+}
+
 void iwl_mvm_unblock_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			 enum iwl_mvm_esr_state reason)
 {
@@ -898,4 +961,7 @@ void iwl_mvm_unblock_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			       reason);
 
 	mvmvif->esr_disable_reason &= ~reason;
+
+	if (!mvmvif->esr_disable_reason)
+		iwl_mvm_esr_unblocked(mvm, vif);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index eab40211404f..c8477afe3fc6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1625,6 +1625,20 @@ static void iwl_mvm_prevent_esr_done_wk(struct wiphy *wiphy,
 	mutex_unlock(&mvm->mutex);
 }
 
+static void iwl_mvm_mlo_int_scan_wk(struct wiphy *wiphy, struct wiphy_work *wk)
+{
+	struct iwl_mvm_vif *mvmvif = container_of(wk, struct iwl_mvm_vif,
+						  mlo_int_scan_wk.work);
+	struct ieee80211_vif *vif =
+		container_of((void *)mvmvif, struct ieee80211_vif, drv_priv);
+
+	mutex_lock(&mvmvif->mvm->mutex);
+
+	iwl_mvm_int_mlo_scan(mvmvif->mvm, vif);
+
+	mutex_unlock(&mvmvif->mvm->mutex);
+}
+
 void iwl_mvm_mac_init_mvmvif(struct iwl_mvm *mvm, struct iwl_mvm_vif *mvmvif)
 {
 	lockdep_assert_held(&mvm->mutex);
@@ -1637,6 +1651,9 @@ void iwl_mvm_mac_init_mvmvif(struct iwl_mvm *mvm, struct iwl_mvm_vif *mvmvif)
 
 	wiphy_delayed_work_init(&mvmvif->prevent_esr_done_wk,
 				iwl_mvm_prevent_esr_done_wk);
+
+	wiphy_delayed_work_init(&mvmvif->mlo_int_scan_wk,
+				iwl_mvm_mlo_int_scan_wk);
 }
 
 static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
@@ -1783,6 +1800,9 @@ void iwl_mvm_prepare_mac_removal(struct iwl_mvm *mvm,
 	wiphy_delayed_work_cancel(mvm->hw->wiphy,
 				  &mvmvif->prevent_esr_done_wk);
 
+	wiphy_delayed_work_cancel(mvm->hw->wiphy,
+				  &mvmvif->mlo_int_scan_wk);
+
 	cancel_delayed_work_sync(&mvmvif->csa_work);
 }
 
@@ -3877,7 +3897,6 @@ iwl_mvm_sta_state_auth_to_assoc(struct ieee80211_hw *hw,
 	return callbacks->update_sta(mvm, vif, sta);
 }
 
-
 static int
 iwl_mvm_sta_state_assoc_to_authorized(struct iwl_mvm *mvm,
 				      struct ieee80211_vif *vif,
@@ -3901,7 +3920,7 @@ iwl_mvm_sta_state_assoc_to_authorized(struct iwl_mvm *mvm,
 		WARN_ON(iwl_mvm_enable_beacon_filter(mvm, vif));
 
 		mvmvif->authorized = 1;
-		mvmvif->link_selection_res = 0;
+		mvmvif->link_selection_res = vif->active_links;
 		mvmvif->link_selection_primary =
 			vif->active_links ? __ffs(vif->active_links) : 0;
 
@@ -3968,6 +3987,9 @@ iwl_mvm_sta_state_authorized_to_assoc(struct iwl_mvm *mvm,
 		wiphy_delayed_work_cancel(mvm->hw->wiphy,
 					  &mvmvif->prevent_esr_done_wk);
 
+		wiphy_delayed_work_cancel(mvm->hw->wiphy,
+					  &mvmvif->mlo_int_scan_wk);
+
 		/* No need for the periodic statistics anymore */
 		if (ieee80211_vif_is_mld(vif) && mvmvif->esr_active)
 			iwl_mvm_request_periodic_system_statistics(mvm, false);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 309711532042..fc167ed4578c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -429,6 +429,7 @@ struct iwl_mvm_esr_exit {
  *	@last_esr_exit::reason, only counting exits due to
  *	&IWL_MVM_ESR_PREVENT_REASONS.
  * @prevent_esr_done_wk: work that should be done when esr prevention ends.
+ * @mlo_int_scan_wk: work for the internal MLO scan.
  */
 struct iwl_mvm_vif {
 	struct iwl_mvm *mvm;
@@ -525,6 +526,7 @@ struct iwl_mvm_vif {
 	struct iwl_mvm_esr_exit last_esr_exit;
 	u8 exit_same_reason_count;
 	struct wiphy_delayed_work prevent_esr_done_wk;
+	struct wiphy_delayed_work mlo_int_scan_wk;
 
 	struct iwl_mvm_vif_link_info deflink;
 	struct iwl_mvm_vif_link_info *link[IEEE80211_MLD_MAX_NUM_LINKS];
@@ -2089,13 +2091,11 @@ int iwl_mvm_reg_scan_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			   struct ieee80211_scan_ies *ies);
 size_t iwl_mvm_scan_size(struct iwl_mvm *mvm);
 int iwl_mvm_scan_stop(struct iwl_mvm *mvm, int type, bool notify);
-int iwl_mvm_int_mlo_scan_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			       struct ieee80211_channel **channels,
-			       size_t n_channels);
 
 int iwl_mvm_max_scan_ie_len(struct iwl_mvm *mvm);
 void iwl_mvm_report_scan_aborted(struct iwl_mvm *mvm);
 void iwl_mvm_scan_timeout_wk(struct work_struct *work);
+int iwl_mvm_int_mlo_scan(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 
 /* Scheduled scan */
 void iwl_mvm_rx_lmac_scan_complete_notif(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index fd1c5808c72b..433280b3c03e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -3202,6 +3202,7 @@ void iwl_mvm_rx_umac_scan_complete_notif(struct iwl_mvm *mvm,
 	struct iwl_umac_scan_complete *notif = (void *)pkt->data;
 	u32 uid = __le32_to_cpu(notif->uid);
 	bool aborted = (notif->status == IWL_SCAN_OFFLOAD_ABORTED);
+	bool select_links = false;
 
 	mvm->mei_scan_filter.is_mei_limited_scan = false;
 
@@ -3235,6 +3236,11 @@ void iwl_mvm_rx_umac_scan_complete_notif(struct iwl_mvm *mvm,
 		mvm->sched_scan_pass_all = SCHED_SCAN_PASS_ALL_DISABLED;
 	} else if (mvm->scan_uid_status[uid] == IWL_MVM_SCAN_INT_MLO) {
 		IWL_DEBUG_SCAN(mvm, "Internal MLO scan completed\n");
+		/*
+		 * Other scan types won't necessarily scan for the MLD links channels.
+		 * Therefore, only select links after successful internal scan.
+		 */
+		select_links = notif->status == IWL_SCAN_OFFLOAD_COMPLETED;
 	}
 
 	mvm->scan_status &= ~mvm->scan_uid_status[uid];
@@ -3255,7 +3261,7 @@ void iwl_mvm_rx_umac_scan_complete_notif(struct iwl_mvm *mvm,
 
 	mvm->scan_uid_status[uid] = 0;
 
-	if (notif->status == IWL_SCAN_OFFLOAD_COMPLETED)
+	if (select_links)
 		iwl_mvm_post_scan_link_selection(mvm);
 }
 
@@ -3517,9 +3523,10 @@ int iwl_mvm_scan_stop(struct iwl_mvm *mvm, int type, bool notify)
 	return ret;
 }
 
-int iwl_mvm_int_mlo_scan_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			       struct ieee80211_channel **channels,
-			       size_t n_channels)
+static int iwl_mvm_int_mlo_scan_start(struct iwl_mvm *mvm,
+				      struct ieee80211_vif *vif,
+				      struct ieee80211_channel **channels,
+				      size_t n_channels)
 {
 	struct cfg80211_scan_request *req = NULL;
 	struct ieee80211_scan_ies ies = {};
@@ -3563,3 +3570,37 @@ int iwl_mvm_int_mlo_scan_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	IWL_DEBUG_SCAN(mvm, "Internal MLO scan: ret=%d\n", ret);
 	return ret;
 }
+
+int iwl_mvm_int_mlo_scan(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
+{
+	struct ieee80211_channel *channels[IEEE80211_MLD_MAX_NUM_LINKS];
+	unsigned long usable_links = ieee80211_vif_usable_links(vif);
+	size_t n_channels = 0;
+	u8 link_id;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	if (mvm->scan_status & IWL_MVM_SCAN_INT_MLO) {
+		IWL_DEBUG_SCAN(mvm, "Internal MLO scan is already running\n");
+		return -EBUSY;
+	}
+
+	rcu_read_lock();
+
+	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_bss_conf *link_conf =
+			rcu_dereference(vif->link_conf[link_id]);
+
+		if (WARN_ON_ONCE(!link_conf))
+			continue;
+
+		channels[n_channels++] = link_conf->chanreq.oper.chan;
+	}
+
+	rcu_read_unlock();
+
+	if (!n_channels)
+		return -EINVAL;
+
+	return iwl_mvm_int_mlo_scan_start(mvm, vif, channels, n_channels);
+}
-- 
2.34.1


