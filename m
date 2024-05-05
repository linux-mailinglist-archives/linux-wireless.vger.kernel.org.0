Return-Path: <linux-wireless+bounces-7191-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BB98BBF79
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 08:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BFDB281D8F
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 06:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F511869;
	Sun,  5 May 2024 06:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RWHl44hV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAFEF9C1
	for <linux-wireless@vger.kernel.org>; Sun,  5 May 2024 06:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714890039; cv=none; b=u9QxIsrwg7MkOh9plq5cDxCsdPSkso17telqV/gyWst82gAMmKN4qiz98eVFOn6/auuWN7bhAvAMQDiLjxg/zIcZfHMxAz3sufe48ILBM5LIYeh9qKZFNKdA1ujeG/tg+9d/Peb/vgO1D/foO7gkom62eYHc+6AQekotkDJa8yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714890039; c=relaxed/simple;
	bh=i05ucL3UByLUTnCfTUKBID5y5qboKlKBH859LTfdmhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nkq0P1ZxZabqwQnV2ySkrBzhOKEPNUjpaLwlYxVqnCUjz0gUeFmMx7y5NWr4NcoIiq9fp9sq4mVNgPruBw8LPwzUfimtW4hksMvCtul3EX/WLzz+gG4c5NwmEw/+LNoVN3UaBAzyfKrnW+kInkIPYSqFBZnwgwc27fQschB/EFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RWHl44hV; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714890038; x=1746426038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i05ucL3UByLUTnCfTUKBID5y5qboKlKBH859LTfdmhE=;
  b=RWHl44hVgDk6J4GhveRETwkFRkuEbxL14bxR9Qihaw+o9BCL/zTAB3p5
   KiluMO9aj0f881fHwKkE4u520SYKCbPvEuLaTropyn3tio1PWpPTo1Mu2
   Ux0pGAjaGQz3PPEhef6KP2uiuIq6FcY2G8op0n4/1+ajo+Mp1xwcGhhUa
   UhjeNeGb5QGPXbGZLPGlmbD6yIHwStiIPd3Ut4ufc3nVAQaJOdYy2LgY8
   UEY9NhPuwsb0s9Z/bTEbOvXOgNeujJ3YyLJ3IKlhBn9u/o9QhCAjt0vh2
   DPiSBiEcgls+AXsn/yLE97WI4puqZl998b6s4RR/aoD7TF1NEWGT+NPd1
   g==;
X-CSE-ConnectionGUID: MaudlskuQZOgCTjWPq5uHw==
X-CSE-MsgGUID: 6b74BQ9SSr2jXYch/onq7Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="14461833"
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="14461833"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:37 -0700
X-CSE-ConnectionGUID: 2uPdR9KCSN+ffN+bSFR+og==
X-CSE-MsgGUID: b4zVmWr6Rd22RuWKr8cI7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="27903632"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:37 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Subject: [PATCH 13/15] wifi: iwlwifi: mvm: Block EMLSR when a p2p/softAP vif is active
Date: Sun,  5 May 2024 09:19:57 +0300
Message-Id: <20240505091420.916193759f8a.Idf3a3caf5cdc3e69c81710b7ceb57e87f2de87e4@changeid>
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

From: Yedidya Benshimol <yedidya.ben.shimol@intel.com>

When there's an active link in a non-station vif, the station vif is
not allowed to enter EMLSR

Note that blocking EMLSR by calling iwl_mvm_block_esr() we will schedule
an exit from EMLSR worker, but the worker cannot run before the
activation of the non-BSS link, as ieee80211_remain_on_channel already
holds the wiphy mutex.

Handle that by explicitly calling ieee80211_set_active_links()
to leave EMLSR, and then doing iwl_mvm_block_esr() only for
consistency and to avoid re-entering it before ready.

Note that a call to ieee80211_set_active_links requires to release the
mvm mutex, but that's ok since we still hold the wiphy lock. The only
thing that might race here is the ESR_MODE_NOTIF, so this changes its
handler to run under the wiphy lock.

Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Co-developed-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 17 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 85 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  6 +-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 16 ++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  6 ++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  3 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   | 19 ++++-
 7 files changed, 133 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 778ea64f3f28..71e6b06481a9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1243,7 +1243,7 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 		.data[0] = &d3_cfg_cmd_data,
 		.len[0] = sizeof(d3_cfg_cmd_data),
 	};
-	int ret, primary_link;
+	int ret;
 	int len __maybe_unused;
 	bool unified_image = fw_has_capa(&mvm->fw->ucode_capa,
 					 IWL_UCODE_TLV_CAPA_CNSLDTD_D3_D0_IMG);
@@ -1261,18 +1261,11 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 	if (IS_ERR_OR_NULL(vif))
 		return 1;
 
-	primary_link = iwl_mvm_get_primary_link(vif);
-
-	/* leave ESR immediately, not only async with iwl_mvm_block_esr() */
-	if (ieee80211_vif_is_mld(vif)) {
-		ret = ieee80211_set_active_links(vif, BIT(primary_link));
-		if (ret)
-			return ret;
-	}
+	ret = iwl_mvm_block_esr_sync(mvm, vif, IWL_MVM_ESR_BLOCKED_WOWLAN);
+	if (ret)
+		return ret;
 
 	mutex_lock(&mvm->mutex);
-	/* only additionally block for consistency and to avoid concurrency */
-	iwl_mvm_block_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_WOWLAN, primary_link);
 
 	set_bit(IWL_MVM_STATUS_IN_D3, &mvm->status);
 
@@ -1280,7 +1273,7 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 
 	mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
-	mvm_link = mvmvif->link[primary_link];
+	mvm_link = mvmvif->link[iwl_mvm_get_primary_link(vif)];
 	if (WARN_ON_ONCE(!mvm_link)) {
 		ret = -EINVAL;
 		goto out_noreset;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 7db4a834569c..7c8cfa72b8bb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -108,6 +108,65 @@ int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	return iwl_mvm_link_cmd_send(mvm, &cmd, FW_CTXT_ACTION_ADD);
 }
 
+struct iwl_mvm_esr_iter_data {
+	struct ieee80211_vif *vif;
+	unsigned int link_id;
+	bool lift_block;
+};
+
+static void iwl_mvm_esr_vif_iterator(void *_data, u8 *mac,
+				     struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_esr_iter_data *data = _data;
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	int link_id;
+
+	if (ieee80211_vif_type_p2p(vif) == NL80211_IFTYPE_STATION)
+		return;
+
+	for_each_mvm_vif_valid_link(mvmvif, link_id) {
+		struct iwl_mvm_vif_link_info *link_info =
+			mvmvif->link[link_id];
+		if (vif == data->vif && link_id == data->link_id)
+			continue;
+		if (link_info->active)
+			data->lift_block = false;
+	}
+}
+
+int iwl_mvm_esr_non_bss_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			     unsigned int link_id, bool active)
+{
+	/* An active link of a non-station vif blocks EMLSR. Upon activation
+	 * block EMLSR on the bss vif. Upon deactivation, check if this link
+	 * was the last non-station link active, and if so unblock the bss vif
+	 */
+	struct ieee80211_vif *bss_vif = iwl_mvm_get_bss_vif(mvm);
+	struct iwl_mvm_esr_iter_data data = {
+		.vif = vif,
+		.link_id = link_id,
+		.lift_block = true,
+	};
+
+	if (IS_ERR_OR_NULL(bss_vif))
+		return 0;
+
+	if (active)
+		return iwl_mvm_block_esr_sync(mvm, bss_vif,
+					      IWL_MVM_ESR_BLOCKED_NON_BSS);
+
+	ieee80211_iterate_active_interfaces(mvm->hw,
+					    IEEE80211_IFACE_ITER_NORMAL,
+					    iwl_mvm_esr_vif_iterator, &data);
+	if (data.lift_block) {
+		mutex_lock(&mvm->mutex);
+		iwl_mvm_unblock_esr(mvm, bss_vif, IWL_MVM_ESR_BLOCKED_NON_BSS);
+		mutex_unlock(&mvm->mutex);
+	}
+
+	return 0;
+}
+
 int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			 struct ieee80211_bss_conf *link_conf,
 			 u32 changes, bool active)
@@ -924,6 +983,32 @@ void iwl_mvm_block_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	iwl_mvm_exit_esr(mvm, vif, reason, link_to_keep);
 }
 
+int iwl_mvm_block_esr_sync(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			   enum iwl_mvm_esr_state reason)
+{
+	int primary_link = iwl_mvm_get_primary_link(vif);
+	int ret;
+
+	if (!IWL_MVM_AUTO_EML_ENABLE || !ieee80211_vif_is_mld(vif))
+		return 0;
+
+	/* This should be called only with blocking reasons */
+	if (WARN_ON(!(reason & IWL_MVM_BLOCK_ESR_REASONS)))
+		return 0;
+
+	/* leave ESR immediately, not only async with iwl_mvm_block_esr() */
+	ret = ieee80211_set_active_links(vif, BIT(primary_link));
+	if (ret)
+		return ret;
+
+	mutex_lock(&mvm->mutex);
+	/* only additionally block for consistency and to avoid concurrency */
+	iwl_mvm_block_esr(mvm, vif, reason, primary_link);
+	mutex_unlock(&mvm->mutex);
+
+	return 0;
+}
+
 static void iwl_mvm_esr_unblocked(struct iwl_mvm *mvm,
 				  struct ieee80211_vif *vif)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index f28ffefd434e..dbfbbfb5b678 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4830,6 +4830,10 @@ int iwl_mvm_roc_common(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	 */
 	flush_work(&mvm->roc_done_wk);
 
+	ret = iwl_mvm_esr_non_bss_link(mvm, vif, 0, true);
+	if (ret)
+		return ret;
+
 	mutex_lock(&mvm->mutex);
 
 	switch (vif->type) {
@@ -4873,9 +4877,7 @@ int iwl_mvm_cancel_roc(struct ieee80211_hw *hw,
 
 	IWL_DEBUG_MAC80211(mvm, "enter\n");
 
-	mutex_lock(&mvm->mutex);
 	iwl_mvm_stop_roc(mvm, vif);
-	mutex_unlock(&mvm->mutex);
 
 	IWL_DEBUG_MAC80211(mvm, "leave\n");
 	return 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 748c72cbb2dc..bceafd551e8f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -391,6 +391,18 @@ static int iwl_mvm_mld_assign_vif_chanctx(struct ieee80211_hw *hw,
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	int ret;
 
+	/* update EMLSR mode */
+	if (ieee80211_vif_type_p2p(vif) != NL80211_IFTYPE_STATION) {
+		ret = iwl_mvm_esr_non_bss_link(mvm, vif, link_conf->link_id,
+					       true);
+		/*
+		 * Don't activate this link if failed to exit EMLSR in
+		 * the BSS interface
+		 */
+		if (ret)
+			return ret;
+	}
+
 	mutex_lock(&mvm->mutex);
 	ret = __iwl_mvm_mld_assign_vif_chanctx(mvm, vif, link_conf, ctx, false);
 	mutex_unlock(&mvm->mutex);
@@ -514,6 +526,10 @@ static void iwl_mvm_mld_unassign_vif_chanctx(struct ieee80211_hw *hw,
 		iwl_mvm_add_link(mvm, vif, link_conf);
 	}
 	mutex_unlock(&mvm->mutex);
+
+	/* update EMLSR mode */
+	if (ieee80211_vif_type_p2p(vif) != NL80211_IFTYPE_STATION)
+		iwl_mvm_esr_non_bss_link(mvm, vif, link_conf->link_id, false);
 }
 
 static void
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 96d29eae8903..115aa1ad970e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -358,6 +358,7 @@ struct iwl_mvm_vif_link_info {
  * @IWL_MVM_ESR_BLOCKED_WOWLAN: WOWLAN is preventing the enablement of EMLSR
  * @IWL_MVM_ESR_BLOCKED_TPT: block EMLSR when there is not enough traffic
  * @IWL_MVM_ESR_BLOCKED_FW: FW didn't recommended/forced exit from EMLSR
+ * @IWL_MVM_ESR_BLOCKED_NON_BSS: An active non-bssid link's preventing EMLSR
  * @IWL_MVM_ESR_EXIT_MISSED_BEACON: exited EMLSR due to missed beacons
  * @IWL_MVM_ESR_EXIT_LOW_RSSI: link is deactivated/not allowed for EMLSR
  *	due to low RSSI.
@@ -372,6 +373,7 @@ enum iwl_mvm_esr_state {
 	IWL_MVM_ESR_BLOCKED_WOWLAN	= 0x2,
 	IWL_MVM_ESR_BLOCKED_TPT		= 0x4,
 	IWL_MVM_ESR_BLOCKED_FW		= 0x8,
+	IWL_MVM_ESR_BLOCKED_NON_BSS	= 0x10,
 	IWL_MVM_ESR_EXIT_MISSED_BEACON	= 0x10000,
 	IWL_MVM_ESR_EXIT_LOW_RSSI	= 0x20000,
 	IWL_MVM_ESR_EXIT_COEX		= 0x40000,
@@ -2888,6 +2890,8 @@ bool iwl_mvm_vif_has_esr_cap(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 void iwl_mvm_block_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		       enum iwl_mvm_esr_state reason,
 		       u8 link_to_keep);
+int iwl_mvm_block_esr_sync(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			   enum iwl_mvm_esr_state reason);
 void iwl_mvm_unblock_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			 enum iwl_mvm_esr_state reason);
 void iwl_mvm_exit_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
@@ -2904,4 +2908,6 @@ iwl_mvm_bt_coex_calculate_esr_mode(struct iwl_mvm *mvm,
 				   struct ieee80211_vif *vif,
 				   s32 link_rssi,
 				   bool primary);
+int iwl_mvm_esr_non_bss_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			     unsigned int link_id, bool active);
 #endif /* __IWL_MVM_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 55ac5552b2f8..155a44e8ab07 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -445,7 +445,8 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 		       struct iwl_channel_switch_error_notif),
 
 	RX_HANDLER_GRP(DATA_PATH_GROUP, ESR_MODE_NOTIF,
-		       iwl_mvm_rx_esr_mode_notif, RX_HANDLER_ASYNC_LOCKED,
+		       iwl_mvm_rx_esr_mode_notif,
+		       RX_HANDLER_ASYNC_LOCKED_WIPHY,
 		       struct iwl_mvm_esr_mode_notif),
 
 	RX_HANDLER_GRP(DATA_PATH_GROUP, MONITOR_NOTIF,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index ad960faceb0d..8ee4498f4245 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -47,6 +47,10 @@ void iwl_mvm_te_clear_data(struct iwl_mvm *mvm,
 
 static void iwl_mvm_cleanup_roc(struct iwl_mvm *mvm)
 {
+	struct ieee80211_vif *vif = mvm->p2p_device_vif;
+
+	lockdep_assert_held(&mvm->mutex);
+
 	/*
 	 * Clear the ROC_RUNNING status bit.
 	 * This will cause the TX path to drop offchannel transmissions.
@@ -70,9 +74,7 @@ static void iwl_mvm_cleanup_roc(struct iwl_mvm *mvm)
 		 * not really racy.
 		 */
 
-		if (!WARN_ON(!mvm->p2p_device_vif)) {
-			struct ieee80211_vif *vif = mvm->p2p_device_vif;
-
+		if (!WARN_ON(!vif)) {
 			mvmvif = iwl_mvm_vif_from_mac80211(vif);
 			iwl_mvm_flush_sta(mvm, mvmvif->deflink.bcast_sta.sta_id,
 					  mvmvif->deflink.bcast_sta.tfd_queue_msk);
@@ -106,6 +108,7 @@ static void iwl_mvm_cleanup_roc(struct iwl_mvm *mvm)
 
 		if (mvm->mld_api_is_used) {
 			iwl_mvm_mld_rm_aux_sta(mvm);
+			mutex_unlock(&mvm->mutex);
 			return;
 		}
 
@@ -115,6 +118,10 @@ static void iwl_mvm_cleanup_roc(struct iwl_mvm *mvm)
 		if (iwl_mvm_has_new_station_api(mvm->fw))
 			iwl_mvm_rm_aux_sta(mvm);
 	}
+
+	mutex_unlock(&mvm->mutex);
+	if (vif)
+		iwl_mvm_esr_non_bss_link(mvm, vif, 0, false);
 }
 
 void iwl_mvm_roc_done_wk(struct work_struct *wk)
@@ -122,8 +129,8 @@ void iwl_mvm_roc_done_wk(struct work_struct *wk)
 	struct iwl_mvm *mvm = container_of(wk, struct iwl_mvm, roc_done_wk);
 
 	mutex_lock(&mvm->mutex);
+	/* Mutex is released inside */
 	iwl_mvm_cleanup_roc(mvm);
-	mutex_unlock(&mvm->mutex);
 }
 
 static void iwl_mvm_roc_finished(struct iwl_mvm *mvm)
@@ -1220,6 +1227,8 @@ void iwl_mvm_stop_roc(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	struct iwl_mvm_vif *mvmvif;
 	struct iwl_mvm_time_event_data *te_data;
 
+	mutex_lock(&mvm->mutex);
+
 	if (fw_has_capa(&mvm->fw->ucode_capa,
 			IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD)) {
 		mvmvif = iwl_mvm_vif_from_mac80211(vif);
@@ -1263,6 +1272,8 @@ void iwl_mvm_stop_roc(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	set_bit(vif->type == NL80211_IFTYPE_P2P_DEVICE ?
 		IWL_MVM_STATUS_ROC_RUNNING : IWL_MVM_STATUS_ROC_AUX_RUNNING,
 		&mvm->status);
+
+	/* Mutex is released inside this function */
 	iwl_mvm_cleanup_roc(mvm);
 }
 
-- 
2.34.1


