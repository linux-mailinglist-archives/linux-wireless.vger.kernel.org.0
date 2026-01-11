Return-Path: <linux-wireless+bounces-30659-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8365BD0F872
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 18:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E30BA307EA34
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 17:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E25349B17;
	Sun, 11 Jan 2026 17:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ad+aY7h8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CF334C13D
	for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768153190; cv=none; b=WtZfXEdqHxUqQjYkDKLP94DgNtf6cdlY0BtOTHCwqWOtrO+Xmnp5eGJXOW2ME+SKf3mgGu7yBMrPkaFVk2NgD/qU2vnkJNJbMveDOuTNWTgkvYH+zsTXvS6yOtptm+j2k9TbEu8PPzElPYjMHpHzHpBrDIrF8M3ZaqQ5IA1oBQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768153190; c=relaxed/simple;
	bh=p+p1IkstiTVE2P+Vs2nH/anAbhKw1fmGgdAx7i3z0Nw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JvlBTO/JzlwX82aBHZIgnFnuuMkihXA72qfscV/JdIUlhmYvmRUQKK2IoYFl/t2hSpA60IB5xztvCcVwEpT1DGJdPcqge+9jdXqHTc+IhkqZDdEDqaqfUEbCUgLiqLzsMTB5rTpvLFohTvlHKaj++kuJ1U6LCR4X2+qNHHliBxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ad+aY7h8; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768153186; x=1799689186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p+p1IkstiTVE2P+Vs2nH/anAbhKw1fmGgdAx7i3z0Nw=;
  b=ad+aY7h8xw1dVU020hbdmGTk9u0jG0OHrCg+pjQCxTGr2gfNPy9ExBRl
   FHhTL9ZL+VOlktJetwhRL97vfgYqTafoIPWxZgS1OWLI1gL9Kwfa99/Eo
   tKzec5QmLy5sBE/YDFNj5HdsZvme2IbF5cPySJMQDXKAwlat/+HeTFzVS
   2es10sAaHbEachUNlxRUFUJxIJtSfGlxTxDFqUSJHcj6wQGm2itpLSq/L
   eATWdwyX/zfvVeM/kyiCBRY5MJYLpm3WQGmVQVk+amdx8XY/PPpwtlFTY
   77ITx7I3jMQCs5ZH20HNGa8QFmZ1MdL4zVGtDaBo5osHMLtk4fsoo0s6J
   g==;
X-CSE-ConnectionGUID: xAA9XSiIRguCz+FYtTVIjA==
X-CSE-MsgGUID: WLQzUgiBQwKYv8WTj355UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69521091"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69521091"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:45 -0800
X-CSE-ConnectionGUID: O5UbmkbYQrWwOpsMcq7FnA==
X-CSE-MsgGUID: mGLCG32kRSa7l5Ho0ahe+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="208393799"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:44 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Nidhish A N <nidhish.a.n@intel.com>
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: mvm: Cleanup MLO code
Date: Sun, 11 Jan 2026 19:39:19 +0200
Message-Id: <20260111193638.214157366bc7.I324778c008058c5d894328aab8e473304f657b69@changeid>
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

iwlmld is now the op mode that is used  for EHT devices,
so iwlmvm code can never run in MLO.
Cleanup some of the MLO code.

Signed-off-by: Nidhish A N <nidhish.a.n@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  51 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  22 --
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  11 -
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  59 +-----
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  |   6 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac.c  |  29 ---
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 193 +-----------------
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |  28 +--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  57 ------
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |   8 -
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  51 +----
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |   4 -
 13 files changed, 39 insertions(+), 488 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 07f1a84c274e..2375fc76039f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -726,8 +726,7 @@ static int iwl_mvm_d3_reprogram(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	struct iwl_time_quota_data *quota;
 	u32 status;
 
-	if (WARN_ON_ONCE(iwl_mvm_is_cdb_supported(mvm) ||
-			 ieee80211_vif_is_mld(vif)))
+	if (WARN_ON_ONCE(iwl_mvm_is_cdb_supported(mvm)))
 		return -EINVAL;
 
 	/* add back the PHY */
@@ -1248,7 +1247,6 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 	struct ieee80211_vif *vif = NULL;
 	struct iwl_mvm_vif *mvmvif = NULL;
 	struct ieee80211_sta *ap_sta = NULL;
-	struct iwl_mvm_vif_link_info *mvm_link;
 	struct iwl_d3_manager_config d3_cfg_cmd = {
 		/*
 		 * Program the minimum sleep time to 10 seconds, as many
@@ -1280,13 +1278,7 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 
 	mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
-	mvm_link = mvmvif->link[iwl_mvm_get_primary_link(vif)];
-	if (WARN_ON_ONCE(!mvm_link)) {
-		ret = -EINVAL;
-		goto out_noreset;
-	}
-
-	if (mvm_link->ap_sta_id == IWL_INVALID_STA) {
+	if (mvmvif->deflink.ap_sta_id == IWL_INVALID_STA) {
 		/* if we're not associated, this must be netdetect */
 		if (!wowlan->nd_config) {
 			ret = 1;
@@ -1304,10 +1296,10 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 			.offloading_tid = 0,
 		};
 
-		wowlan_config_cmd.sta_id = mvm_link->ap_sta_id;
+		wowlan_config_cmd.sta_id = mvmvif->deflink.ap_sta_id;
 
 		ap_sta = rcu_dereference_protected(
-			mvm->fw_id_to_mac_id[mvm_link->ap_sta_id],
+			mvm->fw_id_to_mac_id[mvmvif->deflink.ap_sta_id],
 			lockdep_is_held(&mvm->mutex));
 		if (IS_ERR_OR_NULL(ap_sta)) {
 			ret = -EINVAL;
@@ -1324,7 +1316,8 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 		if (ret)
 			goto out_noreset;
 		ret = iwl_mvm_wowlan_config(mvm, wowlan, &wowlan_config_cmd,
-					    vif, mvmvif, mvm_link, ap_sta);
+					    vif, mvmvif, &mvmvif->deflink,
+					    ap_sta);
 		if (ret)
 			goto out;
 
@@ -1819,10 +1812,6 @@ static void iwl_mvm_d3_update_keys(struct ieee80211_hw *hw,
 	struct iwl_mvm_d3_gtk_iter_data *data = _data;
 	struct iwl_wowlan_status_data *status = data->status;
 	s8 keyidx;
-	int link_id = vif->active_links ? __ffs(vif->active_links) : -1;
-
-	if (link_id >= 0 && key->link_id >= 0 && link_id != key->link_id)
-		return;
 
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_WEP40:
@@ -1876,7 +1865,6 @@ static bool iwl_mvm_gtk_rekey(struct iwl_wowlan_status_data *status,
 {
 	int i, j;
 	struct ieee80211_key_conf *key;
-	int link_id = vif->active_links ? __ffs(vif->active_links) : -1;
 
 	for (i = 0; i < ARRAY_SIZE(status->gtk); i++) {
 		if (!status->gtk[i].len)
@@ -1888,8 +1876,7 @@ static bool iwl_mvm_gtk_rekey(struct iwl_wowlan_status_data *status,
 
 		key = ieee80211_gtk_rekey_add(vif, status->gtk[i].id,
 					      status->gtk[i].key,
-					      sizeof(status->gtk[i].key),
-					      link_id);
+					      sizeof(status->gtk[i].key), -1);
 		if (IS_ERR(key)) {
 			/* FW may send also the old keys */
 			if (PTR_ERR(key) == -EALREADY)
@@ -1918,14 +1905,13 @@ iwl_mvm_d3_igtk_bigtk_rekey_add(struct iwl_wowlan_status_data *status,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct ieee80211_key_conf *key_config;
 	struct ieee80211_key_seq seq;
-	int link_id = vif->active_links ? __ffs(vif->active_links) : -1;
 	s8 keyidx = key_data->id;
 
 	if (!key_data->len)
 		return true;
 
 	key_config = ieee80211_gtk_rekey_add(vif, keyidx, key_data->key,
-					     sizeof(key_data->key), link_id);
+					     sizeof(key_data->key), -1);
 	if (IS_ERR(key_config)) {
 		/* FW may send also the old keys */
 		return PTR_ERR(key_config) == -EALREADY;
@@ -1935,13 +1921,9 @@ iwl_mvm_d3_igtk_bigtk_rekey_add(struct iwl_wowlan_status_data *status,
 	ieee80211_set_key_rx_seq(key_config, 0, &seq);
 
 	if (keyidx == 4 || keyidx == 5) {
-		struct iwl_mvm_vif_link_info *mvm_link;
-
-		link_id = link_id < 0 ? 0 : link_id;
-		mvm_link = mvmvif->link[link_id];
-		if (mvm_link->igtk)
-			mvm_link->igtk->hw_key_idx = STA_KEY_IDX_INVALID;
-		mvm_link->igtk = key_config;
+		if (mvmvif->deflink.igtk)
+			mvmvif->deflink.igtk->hw_key_idx = STA_KEY_IDX_INVALID;
+		mvmvif->deflink.igtk = key_config;
 	}
 
 	if (vif->type == NL80211_IFTYPE_STATION && (keyidx == 6 || keyidx == 7))
@@ -2396,23 +2378,19 @@ static bool iwl_mvm_query_wakeup_reasons(struct iwl_mvm *mvm,
 	bool keep = false;
 	struct iwl_mvm_sta *mvm_ap_sta;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	int link_id = vif->active_links ? __ffs(vif->active_links) : 0;
-	struct iwl_mvm_vif_link_info *mvm_link = mvmvif->link[link_id];
 	int wowlan_info_ver = iwl_fw_lookup_notif_ver(mvm->fw,
 						      PROT_OFFLOAD_GROUP,
 						      WOWLAN_INFO_NOTIFICATION,
 						      IWL_FW_CMD_VER_UNKNOWN);
 
-	if (WARN_ON(!mvm_link))
-		goto out_unlock;
-
 	if (!status)
 		goto out_unlock;
 
 	IWL_DEBUG_WOWLAN(mvm, "wakeup reason 0x%x\n",
 			 status->wakeup_reasons);
 
-	mvm_ap_sta = iwl_mvm_sta_from_staid_protected(mvm, mvm_link->ap_sta_id);
+	mvm_ap_sta = iwl_mvm_sta_from_staid_protected(mvm,
+						      mvmvif->deflink.ap_sta_id);
 	if (!mvm_ap_sta)
 		goto out_unlock;
 
@@ -2756,9 +2734,6 @@ iwl_mvm_choose_query_wakeup_reasons(struct iwl_mvm *mvm,
 		u8 sta_id = mvm->net_detect ? IWL_INVALID_STA :
 					      mvmvif->deflink.ap_sta_id;
 
-		/* bug - FW with MLO has status notification */
-		WARN_ON(ieee80211_vif_is_mld(vif));
-
 		d3_data->status = iwl_mvm_send_wowlan_get_status(mvm, sta_id);
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 738facceb240..b5d252ece2d9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -285,28 +285,6 @@ int iwl_mvm_disable_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	return ret;
 }
 
-u8 iwl_mvm_get_primary_link(struct ieee80211_vif *vif)
-{
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-
-	/* relevant data is written with both locks held, so read with either */
-	lockdep_assert(lockdep_is_held(&mvmvif->mvm->mutex) ||
-		       lockdep_is_held(&mvmvif->mvm->hw->wiphy->mtx));
-
-	if (!ieee80211_vif_is_mld(vif))
-		return 0;
-
-	/* In AP mode, there is no primary link */
-	if (vif->type == NL80211_IFTYPE_AP)
-		return __ffs(vif->active_links);
-
-	if (mvmvif->esr_active &&
-	    !WARN_ON(!(BIT(mvmvif->primary_link) & vif->active_links)))
-		return mvmvif->primary_link;
-
-	return __ffs(vif->active_links);
-}
-
 void iwl_mvm_init_link(struct iwl_mvm_vif_link_info *link)
 {
 	link->bcast_sta.sta_id = IWL_INVALID_STA;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 49ffc4ecee85..0e5820c13523 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -873,7 +873,6 @@ u8 iwl_mvm_mac_ctxt_get_lowest_rate(struct iwl_mvm *mvm,
 				    struct ieee80211_tx_info *info,
 				    struct ieee80211_vif *vif)
 {
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct ieee80211_supported_band *sband;
 	unsigned long basic = vif->bss_conf.basic_rates;
 	u16 lowest_cck = IWL_RATE_COUNT, lowest_ofdm = IWL_RATE_COUNT;
@@ -883,16 +882,6 @@ u8 iwl_mvm_mac_ctxt_get_lowest_rate(struct iwl_mvm *mvm,
 	u8 rate;
 	u32 i;
 
-	if (link_id == IEEE80211_LINK_UNSPECIFIED && ieee80211_vif_is_mld(vif)) {
-		for (i = 0; i < ARRAY_SIZE(mvmvif->link); i++) {
-			if (!mvmvif->link[i])
-				continue;
-			/* shouldn't do this when >1 link is active */
-			WARN_ON_ONCE(link_id != IEEE80211_LINK_UNSPECIFIED);
-			link_id = i;
-		}
-	}
-
 	if (link_id < IEEE80211_LINK_UNSPECIFIED) {
 		struct ieee80211_bss_conf *link_conf;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 44029ceb8f77..a9022ae4504f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1109,7 +1109,6 @@ static void iwl_mvm_cleanup_iterator(void *data, u8 *mac,
 	mvmvif->ba_enabled = false;
 	mvmvif->ap_sta = NULL;
 
-	mvmvif->esr_active = false;
 	vif->driver_flags &= ~IEEE80211_VIF_EML_ACTIVE;
 
 	for_each_mvm_vif_valid_link(mvmvif, link_id) {
@@ -1129,39 +1128,6 @@ static void iwl_mvm_cleanup_iterator(void *data, u8 *mac,
 	RCU_INIT_POINTER(mvmvif->deflink.probe_resp_data, NULL);
 }
 
-static void iwl_mvm_cleanup_sta_iterator(void *data, struct ieee80211_sta *sta)
-{
-	struct iwl_mvm *mvm = data;
-	struct iwl_mvm_sta *mvm_sta;
-	struct ieee80211_vif *vif;
-	int link_id;
-
-	mvm_sta = iwl_mvm_sta_from_mac80211(sta);
-	vif = mvm_sta->vif;
-
-	if (!sta->valid_links)
-		return;
-
-	for (link_id = 0; link_id < ARRAY_SIZE((sta)->link); link_id++) {
-		struct iwl_mvm_link_sta *mvm_link_sta;
-
-		mvm_link_sta =
-			rcu_dereference_check(mvm_sta->link[link_id],
-					      lockdep_is_held(&mvm->mutex));
-		if (mvm_link_sta && !(vif->active_links & BIT(link_id))) {
-			/*
-			 * We have a link STA but the link is inactive in
-			 * mac80211. This will happen if we failed to
-			 * deactivate the link but mac80211 roll back the
-			 * deactivation of the link.
-			 * Delete the stale data to avoid issues later on.
-			 */
-			iwl_mvm_mld_free_sta_link(mvm, mvm_sta, mvm_link_sta,
-						  link_id);
-		}
-	}
-}
-
 static void iwl_mvm_restart_cleanup(struct iwl_mvm *mvm)
 {
 	iwl_mvm_stop_device(mvm);
@@ -1184,10 +1150,6 @@ static void iwl_mvm_restart_cleanup(struct iwl_mvm *mvm)
 	 */
 	ieee80211_iterate_interfaces(mvm->hw, 0, iwl_mvm_cleanup_iterator, mvm);
 
-	/* cleanup stations as links may be gone after restart */
-	ieee80211_iterate_stations_atomic(mvm->hw,
-					  iwl_mvm_cleanup_sta_iterator, mvm);
-
 	mvm->p2p_device_vif = NULL;
 
 	iwl_mvm_reset_phy_ctxts(mvm);
@@ -3921,12 +3883,6 @@ iwl_mvm_sta_state_assoc_to_authorized(struct iwl_mvm *mvm,
 
 		mvmvif->authorized = 1;
 
-		if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
-			mvmvif->link_selection_res = vif->active_links;
-			mvmvif->link_selection_primary =
-				vif->active_links ? __ffs(vif->active_links) : 0;
-		}
-
 		callbacks->mac_ctxt_changed(mvm, vif, false);
 		iwl_mvm_mei_host_associated(mvm, vif, mvm_sta);
 	}
@@ -3972,7 +3928,6 @@ iwl_mvm_sta_state_authorized_to_assoc(struct iwl_mvm *mvm,
 		 * time.
 		 */
 		mvmvif->authorized = 0;
-		mvmvif->link_selection_res = 0;
 
 		/* disable beacon filtering */
 		iwl_mvm_disable_beacon_filter(mvm, vif);
@@ -5568,8 +5523,7 @@ static int iwl_mvm_pre_channel_switch(struct iwl_mvm *mvm,
 		if (!vif->cfg.assoc || !vif->bss_conf.dtim_period)
 			return -EBUSY;
 
-		if (chsw->delay > IWL_MAX_CSA_BLOCK_TX &&
-		    hweight16(vif->valid_links) <= 1)
+		if (chsw->delay > IWL_MAX_CSA_BLOCK_TX)
 			schedule_delayed_work(&mvmvif->csa_work, 0);
 
 		if (chsw->block_tx) {
@@ -5733,15 +5687,8 @@ void iwl_mvm_mac_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		return;
 	}
 
-	if (!drop && hweight16(vif->active_links) <= 1) {
-		int link_id = vif->active_links ? __ffs(vif->active_links) : 0;
-		struct ieee80211_bss_conf *link_conf;
-
-		link_conf = wiphy_dereference(hw->wiphy,
-					      vif->link_conf[link_id]);
-		if (WARN_ON(!link_conf))
-			return;
-		if (link_conf->csa_active && mvmvif->csa_blocks_tx)
+	if (!drop) {
+		if (vif->bss_conf.csa_active && mvmvif->csa_blocks_tx)
 			drop = true;
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
index ef0be44207e1..9bb253dcf4a7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2022 - 2024 Intel Corporation
+ * Copyright (C) 2022 - 2025 Intel Corporation
  */
 #include <linux/kernel.h>
 #include <net/mac80211.h>
@@ -43,11 +43,11 @@ static u32 iwl_mvm_get_sec_sta_mask(struct iwl_mvm *mvm,
 	 * group keys have no sta pointer), so we don't have a STA now.
 	 * Since this happens for group keys only, just use the link_info as
 	 * the group keys are per link; make sure that is the case by checking
-	 * we do have a link_id or are not doing MLO.
+	 * we do have a link_id.
 	 * Of course the same can be done during add as well, but we must do
 	 * it during remove, since we don't have the mvmvif->ap_sta pointer.
 	 */
-	if (!sta && (keyconf->link_id >= 0 || !ieee80211_vif_is_mld(vif)))
+	if (!sta && keyconf->link_id >= 0)
 		return BIT(link_info->ap_sta_id);
 
 	/* STA should be non-NULL now, but iwl_mvm_sta_fw_id_mask() checks */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
index 2d116a41913c..bf54b90a7c51 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
@@ -56,23 +56,6 @@ static void iwl_mvm_mld_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
 	if (iwlwifi_mod_params.disable_11ax)
 		return;
 
-	/* If we have MLO enabled, then the firmware needs to enable
-	 * address translation for the station(s) we add. That depends
-	 * on having EHT enabled in firmware, which in turn depends on
-	 * mac80211 in the code below.
-	 * However, mac80211 doesn't enable HE/EHT until it has parsed
-	 * the association response successfully, so just skip all that
-	 * and enable both when we have MLO.
-	 */
-	if (ieee80211_vif_is_mld(vif)) {
-		iwl_mvm_mld_set_he_support(mvm, vif, cmd, cmd_ver);
-		if (cmd_ver == 2)
-			cmd->wifi_gen_v2.eht_support = cpu_to_le32(1);
-		else
-			cmd->wifi_gen.eht_support = 1;
-		return;
-	}
-
 	rcu_read_lock();
 	for (link_id = 0; link_id < ARRAY_SIZE((vif)->link_conf); link_id++) {
 		link_conf = rcu_dereference(vif->link_conf[link_id]);
@@ -116,7 +99,6 @@ static int iwl_mvm_mld_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
 					u32 action, bool force_assoc_off)
 {
 	struct iwl_mac_config_cmd cmd = {};
-	u16 esr_transition_timeout;
 
 	WARN_ON(vif->type != NL80211_IFTYPE_STATION);
 
@@ -154,17 +136,6 @@ static int iwl_mvm_mld_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
 	}
 
 	cmd.client.assoc_id = cpu_to_le16(vif->cfg.aid);
-	if (ieee80211_vif_is_mld(vif)) {
-		esr_transition_timeout =
-			u16_get_bits(vif->cfg.eml_cap,
-				     IEEE80211_EML_CAP_TRANSITION_TIMEOUT);
-
-		cmd.client.esr_transition_timeout =
-			min_t(u16, IEEE80211_EML_CAP_TRANSITION_TIMEOUT_128TU,
-			      esr_transition_timeout);
-		cmd.client.medium_sync_delay =
-			cpu_to_le16(vif->cfg.eml_med_sync_delay);
-	}
 
 	if (vif->probe_req_reg && vif->cfg.assoc && vif->p2p)
 		cmd.filter_flags |= cpu_to_le32(MAC_CFG_FILTER_ACCEPT_PROBE_REQ);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 380b6f8a53fd..5829a8b45a89 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -60,19 +60,12 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 				     IEEE80211_VIF_SUPPORTS_CQM_RSSI;
 	}
 
-	/* We want link[0] to point to the default link, unless we have MLO and
-	 * in this case this will be modified later by .change_vif_links()
-	 * If we are in the restart flow with an MLD connection, we will wait
-	 * to .change_vif_links() to setup the links.
-	 */
-	if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status) ||
-	    !ieee80211_vif_is_mld(vif)) {
-		mvmvif->link[0] = &mvmvif->deflink;
+	/* We want link[0] to point to the default link. */
+	mvmvif->link[0] = &mvmvif->deflink;
 
-		ret = iwl_mvm_add_link(mvm, vif, &vif->bss_conf);
-		if (ret)
-			goto out_free_bf;
-	}
+	ret = iwl_mvm_add_link(mvm, vif, &vif->bss_conf);
+	if (ret)
+		goto out_free_bf;
 
 	/* Save a pointer to p2p device vif, so it can later be used to
 	 * update the p2p device MAC when a GO is started/stopped
@@ -181,58 +174,6 @@ static void iwl_mvm_mld_mac_remove_interface(struct ieee80211_hw *hw,
 	}
 }
 
-static unsigned int iwl_mvm_mld_count_active_links(struct iwl_mvm_vif *mvmvif)
-{
-	unsigned int n_active = 0;
-	int i;
-
-	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
-		if (mvmvif->link[i] && mvmvif->link[i]->phy_ctxt)
-			n_active++;
-	}
-
-	return n_active;
-}
-
-static int iwl_mvm_esr_mode_active(struct iwl_mvm *mvm,
-				   struct ieee80211_vif *vif)
-{
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	int link_id, ret = 0;
-
-	mvmvif->esr_active = true;
-
-	/* Indicate to mac80211 that EML is enabled */
-	vif->driver_flags |= IEEE80211_VIF_EML_ACTIVE;
-
-	iwl_mvm_update_smps_on_active_links(mvm, vif, IWL_MVM_SMPS_REQ_FW,
-					    IEEE80211_SMPS_OFF);
-
-	for_each_mvm_vif_valid_link(mvmvif, link_id) {
-		struct iwl_mvm_vif_link_info *link = mvmvif->link[link_id];
-
-		if (!link->phy_ctxt)
-			continue;
-
-		ret = iwl_mvm_phy_send_rlc(mvm, link->phy_ctxt, 2, 2);
-		if (ret)
-			break;
-
-		link->phy_ctxt->rlc_disabled = true;
-	}
-
-	if (vif->active_links == mvmvif->link_selection_res &&
-	    !WARN_ON(!(vif->active_links & BIT(mvmvif->link_selection_primary))))
-		mvmvif->primary_link = mvmvif->link_selection_primary;
-	else
-		mvmvif->primary_link = __ffs(vif->active_links);
-
-	iwl_dbg_tlv_time_point(&mvm->fwrt, IWL_FW_INI_TIME_ESR_LINK_UP,
-			       NULL);
-
-	return ret;
-}
-
 static int
 __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 				 struct ieee80211_vif *vif,
@@ -243,17 +184,12 @@ __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 	u16 *phy_ctxt_id = (u16 *)ctx->drv_priv;
 	struct iwl_mvm_phy_ctxt *phy_ctxt = &mvm->phy_ctxts[*phy_ctxt_id];
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	unsigned int n_active = iwl_mvm_mld_count_active_links(mvmvif);
 	unsigned int link_id = link_conf->link_id;
 	int ret;
 
 	if (WARN_ON_ONCE(!mvmvif->link[link_id]))
 		return -EINVAL;
 
-	/* if the assigned one was not counted yet, count it now */
-	if (!mvmvif->link[link_id]->phy_ctxt)
-		n_active++;
-
 	/* mac parameters such as HE support can change at this stage
 	 * For sta, need first to configure correct state from drv_sta_state
 	 * and only after that update mac config.
@@ -268,15 +204,6 @@ __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 
 	mvmvif->link[link_id]->phy_ctxt = phy_ctxt;
 
-	if (iwl_mvm_is_esr_supported(mvm->fwrt.trans) && n_active > 1) {
-		mvmvif->link[link_id]->listen_lmac = true;
-		ret = iwl_mvm_esr_mode_active(mvm, vif);
-		if (ret) {
-			IWL_ERR(mvm, "failed to activate ESR mode (%d)\n", ret);
-			goto out;
-		}
-	}
-
 	if (switching_chanctx) {
 		/* reactivate if we turned this off during channel switch */
 		if (vif->type == NL80211_IFTYPE_AP)
@@ -341,55 +268,6 @@ static int iwl_mvm_mld_assign_vif_chanctx(struct ieee80211_hw *hw,
 	return __iwl_mvm_mld_assign_vif_chanctx(mvm, vif, link_conf, ctx, false);
 }
 
-static int iwl_mvm_esr_mode_inactive(struct iwl_mvm *mvm,
-				     struct ieee80211_vif *vif)
-{
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct ieee80211_bss_conf *link_conf;
-	int link_id, ret = 0;
-
-	mvmvif->esr_active = false;
-
-	vif->driver_flags &= ~IEEE80211_VIF_EML_ACTIVE;
-
-	iwl_mvm_update_smps_on_active_links(mvm, vif, IWL_MVM_SMPS_REQ_FW,
-					    IEEE80211_SMPS_AUTOMATIC);
-
-	for_each_vif_active_link(vif, link_conf, link_id) {
-		struct ieee80211_chanctx_conf *chanctx_conf;
-		struct iwl_mvm_phy_ctxt *phy_ctxt;
-		u8 static_chains, dynamic_chains;
-
-		mvmvif->link[link_id]->listen_lmac = false;
-
-		rcu_read_lock();
-
-		chanctx_conf = rcu_dereference(link_conf->chanctx_conf);
-		phy_ctxt = mvmvif->link[link_id]->phy_ctxt;
-
-		if (!chanctx_conf || !phy_ctxt) {
-			rcu_read_unlock();
-			continue;
-		}
-
-		phy_ctxt->rlc_disabled = false;
-		static_chains = chanctx_conf->rx_chains_static;
-		dynamic_chains = chanctx_conf->rx_chains_dynamic;
-
-		rcu_read_unlock();
-
-		ret = iwl_mvm_phy_send_rlc(mvm, phy_ctxt, static_chains,
-					   dynamic_chains);
-		if (ret)
-			break;
-	}
-
-	iwl_dbg_tlv_time_point(&mvm->fwrt, IWL_FW_INI_TIME_ESR_LINK_DOWN,
-			       NULL);
-
-	return ret;
-}
-
 static void
 __iwl_mvm_mld_unassign_vif_chanctx(struct iwl_mvm *mvm,
 				   struct ieee80211_vif *vif,
@@ -399,7 +277,6 @@ __iwl_mvm_mld_unassign_vif_chanctx(struct iwl_mvm *mvm,
 
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	unsigned int n_active = iwl_mvm_mld_count_active_links(mvmvif);
 	unsigned int link_id = link_conf->link_id;
 
 	/* shouldn't happen, but verify link_id is valid before accessing */
@@ -421,14 +298,6 @@ __iwl_mvm_mld_unassign_vif_chanctx(struct iwl_mvm *mvm,
 	iwl_mvm_link_changed(mvm, vif, link_conf,
 			     LINK_CONTEXT_MODIFY_ACTIVE, false);
 
-	if (iwl_mvm_is_esr_supported(mvm->fwrt.trans) && n_active > 1) {
-		int ret = iwl_mvm_esr_mode_inactive(mvm, vif);
-
-		if (ret)
-			IWL_ERR(mvm, "failed to deactivate ESR mode (%d)\n",
-				ret);
-	}
-
 	if (vif->type == NL80211_IFTYPE_MONITOR)
 		iwl_mvm_mld_rm_snif_sta(mvm, vif);
 
@@ -448,9 +317,8 @@ static void iwl_mvm_mld_unassign_vif_chanctx(struct ieee80211_hw *hw,
 
 	mutex_lock(&mvm->mutex);
 	__iwl_mvm_mld_unassign_vif_chanctx(mvm, vif, link_conf, ctx, false);
-	/* in the non-MLD case, remove/re-add the link to clean up FW state */
-	if (!ieee80211_vif_is_mld(vif) && !mvmvif->ap_sta &&
-	    !WARN_ON_ONCE(vif->cfg.assoc)) {
+	/* Remove/re-add the link to clean up FW state */
+	if (!mvmvif->ap_sta && !WARN_ON_ONCE(vif->cfg.assoc)) {
 		iwl_mvm_remove_link(mvm, vif, link_conf);
 		iwl_mvm_add_link(mvm, vif, link_conf);
 	}
@@ -785,12 +653,6 @@ static void iwl_mvm_mld_vif_cfg_changed_station(struct iwl_mvm *mvm,
 
 			if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status) &&
 			    protect) {
-				/* We are in assoc so only one link is active-
-				 * The association link
-				 */
-				unsigned int link_id =
-					ffs(vif->active_links) - 1;
-
 				/* If we're not restarting and still haven't
 				 * heard a beacon (dtim period unknown) then
 				 * make sure we still have enough minimum time
@@ -800,7 +662,7 @@ static void iwl_mvm_mld_vif_cfg_changed_station(struct iwl_mvm *mvm,
 				 * time could be small without us having heard
 				 * a beacon yet.
 				 */
-				iwl_mvm_protect_assoc(mvm, vif, 0, link_id);
+				iwl_mvm_protect_assoc(mvm, vif, 0, -1);
 			}
 
 			iwl_mvm_sf_update(mvm, vif, false);
@@ -1096,14 +958,6 @@ iwl_mvm_mld_change_vif_links(struct ieee80211_hw *hw,
 	if (new_links == 0) {
 		mvmvif->link[0] = &mvmvif->deflink;
 		err = iwl_mvm_add_link(mvm, vif, &vif->bss_conf);
-		if (err == 0)
-			mvmvif->primary_link = 0;
-	} else if (!(new_links & BIT(mvmvif->primary_link))) {
-		/*
-		 * Ensure we always have a valid primary_link, the real
-		 * decision happens later when PHY is activated.
-		 */
-		mvmvif->primary_link = __ffs(new_links);
 	}
 
 out_err:
@@ -1128,44 +982,17 @@ iwl_mvm_mld_change_sta_links(struct ieee80211_hw *hw,
 	return iwl_mvm_mld_update_sta_links(mvm, vif, sta, old_links, new_links);
 }
 
-bool iwl_mvm_vif_has_esr_cap(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
-{
-	const struct wiphy_iftype_ext_capab *ext_capa;
-
-	lockdep_assert_held(&mvm->mutex);
-
-	if (!ieee80211_vif_is_mld(vif) || !vif->cfg.assoc ||
-	    hweight16(ieee80211_vif_usable_links(vif)) == 1)
-		return false;
-
-	if (!(vif->cfg.eml_cap & IEEE80211_EML_CAP_EMLSR_SUPP))
-		return false;
-
-	ext_capa = cfg80211_get_iftype_ext_capa(mvm->hw->wiphy,
-						ieee80211_vif_type_p2p(vif));
-	return (ext_capa &&
-		(ext_capa->eml_capabilities & IEEE80211_EML_CAP_EMLSR_SUPP));
-}
-
 static bool iwl_mvm_mld_can_activate_links(struct ieee80211_hw *hw,
 					   struct ieee80211_vif *vif,
 					   u16 desired_links)
 {
-	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	int n_links = hweight16(desired_links);
 
 	if (n_links <= 1)
 		return true;
 
-	guard(mvm)(mvm);
-
-	/* Check if HW supports the wanted number of links */
-	if (n_links > iwl_mvm_max_active_links(mvm, vif))
-		return false;
-
-	/* If it is an eSR device, check that we can enter eSR */
-	return iwl_mvm_is_esr_supported(mvm->fwrt.trans) &&
-	       iwl_mvm_vif_has_esr_cap(mvm, vif);
+	WARN_ON(1);
+	return false;
 }
 
 static enum ieee80211_neg_ttlm_res
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index d9a2801636cf..1100d763ceb6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -9,40 +9,14 @@
 u32 iwl_mvm_sta_fw_id_mask(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 			   int filter_link_id)
 {
-	struct ieee80211_link_sta *link_sta;
 	struct iwl_mvm_sta *mvmsta;
-	struct ieee80211_vif *vif;
-	unsigned int link_id;
-	u32 result = 0;
 
 	if (!sta)
 		return 0;
 
 	mvmsta = iwl_mvm_sta_from_mac80211(sta);
-	vif = mvmsta->vif;
-
-	/* it's easy when the STA is not an MLD */
-	if (!sta->valid_links)
-		return BIT(mvmsta->deflink.sta_id);
-
-	/* but if it is an MLD, get the mask of all the FW STAs it has ... */
-	for_each_sta_active_link(vif, sta, link_sta, link_id) {
-		struct iwl_mvm_link_sta *mvm_link_sta;
-
-		/* unless we have a specific link in mind */
-		if (filter_link_id >= 0 && link_id != filter_link_id)
-			continue;
-
-		mvm_link_sta =
-			rcu_dereference_check(mvmsta->link[link_id],
-					      lockdep_is_held(&mvm->mutex));
-		if (!mvm_link_sta)
-			continue;
-
-		result |= BIT(mvm_link_sta->sta_id);
-	}
 
-	return result;
+	return BIT(mvmsta->deflink.sta_id);
 }
 
 static int iwl_mvm_mld_send_sta_cmd(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 301d590fe0bd..f3685292b834 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -380,14 +380,7 @@ struct iwl_mvm_vif_link_info {
  * @bcn_prot: beacon protection data (keys; FIXME: needs to be per link)
  * @deflink: default link data for use in non-MLO
  * @link: link data for each link in MLO
- * @esr_active: indicates eSR mode is active
  * @pm_enabled: indicates powersave is enabled
- * @link_selection_res: bitmap of active links as it was decided in the last
- *	link selection. Valid only for a MLO vif after assoc. 0 if there wasn't
- *	any link selection yet.
- * @link_selection_primary: primary link selected by link selection
- * @primary_link: primary link in eSR. Valid only for an associated MLD vif,
- *	and in eSR mode. Valid only for a STA.
  * @roc_activity: currently running ROC activity for this vif (or
  *	ROC_NUM_ACTIVITIES if no activity is running).
  * @session_prot_connection_loss: the connection was lost due to session
@@ -434,7 +427,6 @@ struct iwl_mvm_vif {
 	bool ap_ibss_active;
 	bool pm_enabled;
 	bool monitor_active;
-	bool esr_active;
 	bool session_prot_connection_loss;
 
 	u8 low_latency: 6;
@@ -515,10 +507,6 @@ struct iwl_mvm_vif {
 
 	u16 max_tx_op;
 
-	u16 link_selection_res;
-	u8 link_selection_primary;
-	u8 primary_link;
-
 	struct iwl_mvm_vif_link_info deflink;
 	struct iwl_mvm_vif_link_info *link[IEEE80211_MLD_MAX_NUM_LINKS];
 };
@@ -1619,40 +1607,6 @@ static inline bool iwl_mvm_is_ctdp_supported(struct iwl_mvm *mvm)
 			   IWL_UCODE_TLV_CAPA_CTDP_SUPPORT);
 }
 
-static inline bool iwl_mvm_is_esr_supported(struct iwl_trans *trans)
-{
-	if (CSR_HW_RFID_IS_CDB(trans->info.hw_rf_id))
-		return false;
-
-	switch (CSR_HW_RFID_TYPE(trans->info.hw_rf_id)) {
-	case IWL_CFG_RF_TYPE_FM:
-		/* Step A doesn't support eSR */
-		return CSR_HW_RFID_STEP(trans->info.hw_rf_id);
-	case IWL_CFG_RF_TYPE_WH:
-	case IWL_CFG_RF_TYPE_PE:
-		return true;
-	default:
-		return false;
-	}
-}
-
-static inline int iwl_mvm_max_active_links(struct iwl_mvm *mvm,
-					   struct ieee80211_vif *vif)
-{
-	struct iwl_trans *trans = mvm->fwrt.trans;
-
-	if (vif->type == NL80211_IFTYPE_AP)
-		return mvm->fw->ucode_capa.num_beacons;
-
-	/* Check if HW supports eSR or STR */
-	if (iwl_mvm_is_esr_supported(trans) ||
-	    (CSR_HW_RFID_TYPE(trans->info.hw_rf_id) == IWL_CFG_RF_TYPE_FM &&
-	     CSR_HW_RFID_IS_CDB(trans->info.hw_rf_id)))
-		return IWL_FW_MAX_ACTIVE_LINKS_NUM;
-
-	return 1;
-}
-
 extern const u8 iwl_mvm_ac_to_tx_fifo[];
 extern const u8 iwl_mvm_ac_to_gen2_tx_fifo[];
 extern const u8 iwl_mvm_ac_to_bz_tx_fifo[];
@@ -2008,15 +1962,6 @@ int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 int iwl_mvm_disable_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			 struct ieee80211_bss_conf *link_conf);
 
-u8 iwl_mvm_get_primary_link(struct ieee80211_vif *vif);
-
-struct iwl_mvm_link_sel_data {
-	u8 link_id;
-	const struct cfg80211_chan_def *chandef;
-	s32 signal;
-	u16 grade;
-};
-
 #if IS_ENABLED(CONFIG_IWLWIFI_KUNIT_TESTS)
 extern const struct iwl_hcmd_arr iwl_mvm_groups[];
 extern const unsigned int iwl_mvm_groups_size;
@@ -2884,8 +2829,6 @@ int iwl_mvm_roc_add_cmd(struct iwl_mvm *mvm,
 			struct ieee80211_vif *vif,
 			int duration, enum iwl_roc_activity activity);
 
-/* EMLSR */
-bool iwl_mvm_vif_has_esr_cap(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 void
 iwl_mvm_send_ap_tx_power_constraint_cmd(struct iwl_mvm *mvm,
 					struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index d35c63a673b6..7f0b4f5daa21 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -2254,17 +2254,9 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 					  IWL_RX_MPDU_STATUS_STA_ID);
 
 		if (!WARN_ON_ONCE(sta_id >= mvm->fw->ucode_capa.num_stations)) {
-			struct ieee80211_link_sta *link_sta;
-
 			sta = rcu_dereference(mvm->fw_id_to_mac_id[sta_id]);
 			if (IS_ERR(sta))
 				sta = NULL;
-			link_sta = rcu_dereference(mvm->fw_id_to_link_sta[sta_id]);
-
-			if (sta && sta->valid_links && link_sta) {
-				rx_status->link_valid = 1;
-				rx_status->link_id = link_sta->link_id;
-			}
 		}
 	} else if (!is_multicast_ether_addr(hdr->addr2)) {
 		/*
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 59331f1d144b..9c51953d255d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -3023,12 +3023,8 @@ static int _iwl_mvm_single_scan_start(struct iwl_mvm *mvm,
 		params.iter_notif = true;
 
 	params.tsf_report_link_id = req->tsf_report_link_id;
-	if (params.tsf_report_link_id < 0) {
-		if (vif->active_links)
-			params.tsf_report_link_id = __ffs(vif->active_links);
-		else
-			params.tsf_report_link_id = 0;
-	}
+	if (params.tsf_report_link_id < 0)
+		params.tsf_report_link_id = 0;
 
 	iwl_mvm_build_scan_probe(mvm, vif, ies, &params);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index bb97837baeda..bca13417e82c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -817,28 +817,15 @@ int iwl_mvm_tx_skb_non_sta(struct iwl_mvm *mvm, struct sk_buff *skb)
 			   NL80211_IFTYPE_P2P_DEVICE ||
 			   info.control.vif->type == NL80211_IFTYPE_AP ||
 			   info.control.vif->type == NL80211_IFTYPE_ADHOC) {
-			u32 link_id = u32_get_bits(info.control.flags,
-						   IEEE80211_TX_CTRL_MLO_LINK);
-			struct iwl_mvm_vif_link_info *link;
-
-			if (link_id == IEEE80211_LINK_UNSPECIFIED) {
-				if (info.control.vif->active_links)
-					link_id = ffs(info.control.vif->active_links) - 1;
-				else
-					link_id = 0;
-			}
-
-			link = mvmvif->link[link_id];
-			if (WARN_ON(!link))
-				return -1;
 
 			if (!ieee80211_is_data(hdr->frame_control))
-				sta_id = link->bcast_sta.sta_id;
+				sta_id = mvmvif->deflink.bcast_sta.sta_id;
 			else
-				sta_id = link->mcast_sta.sta_id;
+				sta_id = mvmvif->deflink.mcast_sta.sta_id;
 
-			queue = iwl_mvm_get_ctrl_vif_queue(mvm, link, &info,
-							   skb);
+			queue = iwl_mvm_get_ctrl_vif_queue(mvm,
+							   &mvmvif->deflink,
+							   &info, skb);
 		} else if (info.control.vif->type == NL80211_IFTYPE_MONITOR) {
 			queue = mvm->snif_queue;
 			sta_id = mvm->snif_sta.sta_id;
@@ -895,33 +882,9 @@ unsigned int iwl_mvm_max_amsdu_size(struct iwl_mvm *mvm,
 	 */
 	val = mvmsta->max_amsdu_len;
 
-	if (hweight16(sta->valid_links) <= 1) {
-		if (sta->valid_links) {
-			struct ieee80211_bss_conf *link_conf;
-			unsigned int link = ffs(sta->valid_links) - 1;
+	band = mvmsta->vif->bss_conf.chanreq.oper.chan->band;
 
-			rcu_read_lock();
-			link_conf = rcu_dereference(mvmsta->vif->link_conf[link]);
-			if (WARN_ON(!link_conf))
-				band = NL80211_BAND_2GHZ;
-			else
-				band = link_conf->chanreq.oper.chan->band;
-			rcu_read_unlock();
-		} else {
-			band = mvmsta->vif->bss_conf.chanreq.oper.chan->band;
-		}
-
-		lmac = iwl_mvm_get_lmac_id(mvm, band);
-	} else if (fw_has_capa(&mvm->fw->ucode_capa,
-			       IWL_UCODE_TLV_CAPA_CDB_SUPPORT)) {
-		/* for real MLO restrict to both LMACs if they exist */
-		lmac = IWL_LMAC_5G_INDEX;
-		val = min_t(unsigned int, val,
-			    mvm->fwrt.smem_cfg.lmac[lmac].txfifo_size[txf] - 256);
-		lmac = IWL_LMAC_24G_INDEX;
-	} else {
-		lmac = IWL_LMAC_24G_INDEX;
-	}
+	lmac = iwl_mvm_get_lmac_id(mvm, band);
 
 	return min_t(unsigned int, val,
 		     mvm->fwrt.smem_cfg.lmac[lmac].txfifo_size[txf] - 256);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 1a6c1f8706e1..4a33a032c2a7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -308,10 +308,6 @@ void iwl_mvm_update_smps(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			smps_mode = IEEE80211_SMPS_DYNAMIC;
 	}
 
-	/* SMPS is disabled in eSR */
-	if (mvmvif->esr_active)
-		smps_mode = IEEE80211_SMPS_OFF;
-
 	ieee80211_request_smps(vif, link_id, smps_mode);
 }
 
-- 
2.34.1


