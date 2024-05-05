Return-Path: <linux-wireless+bounces-7179-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 532F98BBF6D
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 08:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C29E01F21687
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 06:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218D51FC4;
	Sun,  5 May 2024 06:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YH5Zf/AU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA466747F
	for <linux-wireless@vger.kernel.org>; Sun,  5 May 2024 06:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714890014; cv=none; b=NBd4mpPxOJNwVMXET/xrIqG5oU7X1yhV4dZJqidTb7sbIn1wb09KsHKVx8flqRvTndUF/GRio5jWQsD2fpakuCKUwPi9AqZU7PEUfMaLKRa0dIdAnRB7dW5cNRrTIUHELhpjlrXU4nQpb+E53NzQKqud4rMO5wSdoGLmaOta9Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714890014; c=relaxed/simple;
	bh=uwCcrN6zbL/jXalDCKdM9SWofeusDRtzWCSZc5lbguo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uzgdBbv0aNHxrMzB0q351E/GuyIClg0IoKRkTM/lhhj2h1PdBqymR8NQaaigAqgR2FIMUKhZS4tOLPdUbGXZl6g/zGD6xCGDT5IDt2WKcaTg5BJsEwvG1EYNyXrw/es8KOWMMSaWh0zw0HMFdtPfLQM3AGU2Cj27KyBX33v3IN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YH5Zf/AU; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714890012; x=1746426012;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uwCcrN6zbL/jXalDCKdM9SWofeusDRtzWCSZc5lbguo=;
  b=YH5Zf/AUNRDD2dmixyMxcm/XnAW4fV0wz9PMJ9hqOXVgSNO0qsN2c05N
   Gc1YWpwVbwD0iR268gTC4e8mpIT7f66bHG6f+bsGXPACd4hRWDmJIFGjW
   tl+os3H7XsL2Wsp/7qK07MlobHAxCMajr3wC/UQY+fz0uBMYqgke5M6Wl
   WreU26CYr5gR0dajEFqFto3euUUQsEi2X4kDK7o7mvEFa7epvP/EMXrL/
   /Y6uxFPkxUumEFx44J7AcC6YTwxZ895//rA0gm2p0k+9QBAZqyuAvk84j
   tJR0CR8X0DJP1jf5iSQBzNXv6ALlYjsmZrdjaRdXfWdDq7os5kcvpbLOx
   w==;
X-CSE-ConnectionGUID: Ne3nlcF0QQyNfLJs2/y82w==
X-CSE-MsgGUID: KRn1yV45SuiWPueoXWPDxw==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="14461801"
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="14461801"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:11 -0700
X-CSE-ConnectionGUID: 0a08wwOiSIapMGxFrPAJmA==
X-CSE-MsgGUID: Zc1yxnPlTkalcw+N7HT9Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="27903572"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:11 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 01/15] wifi: iwlwifi: cleanup EMLSR when BT is active handling
Date: Sun,  5 May 2024 09:19:45 +0300
Message-Id: <20240505091420.a2e93b67c895.I183a0039ef076613144648cc46fbe9ab3d47c574@changeid>
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

BT Coex disables EMLSR only for a 2.4 GHz link, but doesn't block the
vif from using EMLSR with a different link pair. In addition, storing it
in mvmvif:disable_esr_reason requires extracting the BT Coex bit before
checking if EMLSR is blocked or not for a specific vif.

Therefore, change the BT Coex bit to be an exit reason and not a
blocker. On link selection, EMLSR mode will be re-calculated for the 2.4
GHz link instead of checking that bit.

While at it, move the relevant function declarations to the EMLSR
functions area in mvm.h

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c | 42 +++++++------------
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 13 +++---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 20 ---------
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 21 ++++++----
 .../wireless/intel/iwlwifi/mvm/tests/links.c  | 21 ++++++++--
 6 files changed, 53 insertions(+), 66 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
index c7987676335a..ad3e14a0d043 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
@@ -257,38 +257,28 @@ static void iwl_mvm_bt_coex_tcm_based_ci(struct iwl_mvm *mvm,
  * This function receives the LB link id and checks if eSR should be
  * enabled or disabled (due to BT coex)
  */
-static bool
+bool
 iwl_mvm_bt_coex_calculate_esr_mode(struct iwl_mvm *mvm,
 				   struct ieee80211_vif *vif,
-				   int link_id)
+				   s32 link_rssi,
+				   bool primary)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mvm_vif_link_info *link_info = mvmvif->link[link_id];
 	bool have_wifi_loss_rate =
 		iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
 					BT_PROFILE_NOTIFICATION, 0) > 4;
-	s8 link_rssi = 0;
 	u8 wifi_loss_rate;
 
-	lockdep_assert_held(&mvm->mutex);
-
 	if (mvm->last_bt_notif.wifi_loss_low_rssi == BT_OFF)
 		return true;
 
-	 /* If LB link is the primary one we should always disable eSR */
-	if (link_id == iwl_mvm_get_primary_link(vif))
+	if (primary)
 		return false;
 
 	/* The feature is not supported */
 	if (!have_wifi_loss_rate)
 		return true;
 
-	/*
-	 * We might not have a link_info when checking whether we can
-	 * (re)enable eSR - the LB link might not exist yet
-	 */
-	if (link_info)
-		link_rssi = (s8)link_info->beacon_stats.avg_signal;
 
 	/*
 	 * In case we don't know the RSSI - take the lower wifi loss,
@@ -298,7 +288,7 @@ iwl_mvm_bt_coex_calculate_esr_mode(struct iwl_mvm *mvm,
 	if (!link_rssi)
 		wifi_loss_rate = mvm->last_bt_notif.wifi_loss_mid_high_rssi;
 
-	else if (!(mvmvif->esr_disable_reason & IWL_MVM_ESR_BLOCKED_COEX))
+	else if (mvmvif->esr_active)
 		 /* RSSI needs to get really low to disable eSR... */
 		wifi_loss_rate =
 			link_rssi <= -IWL_MVM_BT_COEX_DISABLE_ESR_THRESH ?
@@ -318,20 +308,20 @@ void iwl_mvm_bt_coex_update_link_esr(struct iwl_mvm *mvm,
 				     struct ieee80211_vif *vif,
 				     int link_id)
 {
-	bool enable;
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_vif_link_info *link = mvmvif->link[link_id];
 
 	if (!ieee80211_vif_is_mld(vif) ||
-	    !iwl_mvm_vif_from_mac80211(vif)->authorized)
+	    !iwl_mvm_vif_from_mac80211(vif)->authorized ||
+	    WARN_ON(!link))
 		return;
 
-	enable = iwl_mvm_bt_coex_calculate_esr_mode(mvm, vif, link_id);
-
-	if (enable)
-		iwl_mvm_unblock_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_COEX);
-	else
+	if (!iwl_mvm_bt_coex_calculate_esr_mode(mvm, vif,
+						(s8)link->beacon_stats.avg_signal,
+						link_id == iwl_mvm_get_primary_link(vif)))
 		/* In case we decided to exit eSR - stay with the primary */
-		iwl_mvm_block_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_COEX,
-				  iwl_mvm_get_primary_link(vif));
+		iwl_mvm_exit_esr(mvm, vif, IWL_MVM_ESR_EXIT_COEX,
+				 iwl_mvm_get_primary_link(vif));
 }
 
 static void iwl_mvm_bt_notif_per_link(struct iwl_mvm *mvm,
@@ -515,10 +505,6 @@ static void iwl_mvm_bt_notif_iterator(void *_data, u8 *mac,
 		return;
 	}
 
-	/* When BT is off this will be 0 */
-	if (data->notif->wifi_loss_low_rssi == BT_OFF)
-		iwl_mvm_unblock_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_COEX);
-
 	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++)
 		iwl_mvm_bt_notif_per_link(mvm, vif, data, link_id);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 84b497b22d83..733e1f77c171 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -592,7 +592,8 @@ s8 iwl_mvm_get_esr_rssi_thresh(struct iwl_mvm *mvm,
 
 static u32
 iwl_mvm_esr_disallowed_with_link(struct ieee80211_vif *vif,
-				 const struct iwl_mvm_link_sel_data *link)
+				 const struct iwl_mvm_link_sel_data *link,
+				 bool primary)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm *mvm = mvmvif->mvm;
@@ -601,8 +602,10 @@ iwl_mvm_esr_disallowed_with_link(struct ieee80211_vif *vif,
 
 	/* BT Coex effects eSR mode only if one of the links is on LB */
 	if (link->chandef->chan->band == NL80211_BAND_2GHZ &&
-	    mvmvif->esr_disable_reason & IWL_MVM_ESR_BLOCKED_COEX)
-		ret |= IWL_MVM_ESR_BLOCKED_COEX;
+	    (!iwl_mvm_bt_coex_calculate_esr_mode(mvm, vif, link->signal,
+						 primary)))
+		ret |= IWL_MVM_ESR_EXIT_COEX;
+
 	thresh = iwl_mvm_get_esr_rssi_thresh(mvm, link->chandef,
 					     false);
 
@@ -622,8 +625,8 @@ bool iwl_mvm_mld_valid_link_pair(struct ieee80211_vif *vif,
 				 const struct iwl_mvm_link_sel_data *b)
 {
 	/* Per-link considerations */
-	if (iwl_mvm_esr_disallowed_with_link(vif, a) ||
-	    iwl_mvm_esr_disallowed_with_link(vif, b))
+	if (iwl_mvm_esr_disallowed_with_link(vif, a, true) ||
+	    iwl_mvm_esr_disallowed_with_link(vif, b, false))
 		return false;
 
 	/* Per-combination considerations */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index c631de70253d..eab40211404f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3877,23 +3877,6 @@ iwl_mvm_sta_state_auth_to_assoc(struct ieee80211_hw *hw,
 	return callbacks->update_sta(mvm, vif, sta);
 }
 
-static void iwl_mvm_bt_coex_update_vif_esr(struct iwl_mvm *mvm,
-					   struct ieee80211_vif *vif)
-{
-	unsigned long usable_links = ieee80211_vif_usable_links(vif);
-	u8 link_id;
-
-	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
-		struct ieee80211_bss_conf *link_conf =
-			link_conf_dereference_protected(vif, link_id);
-
-		if (WARN_ON_ONCE(!link_conf))
-			return;
-
-		if (link_conf->chanreq.oper.chan->band == NL80211_BAND_2GHZ)
-			iwl_mvm_bt_coex_update_link_esr(mvm, vif, link_id);
-	}
-}
 
 static int
 iwl_mvm_sta_state_assoc_to_authorized(struct iwl_mvm *mvm,
@@ -3928,9 +3911,6 @@ iwl_mvm_sta_state_assoc_to_authorized(struct iwl_mvm *mvm,
 		memset(&mvmvif->last_esr_exit, 0,
 		       sizeof(mvmvif->last_esr_exit));
 
-		/* Calculate eSR mode due to BT coex */
-		iwl_mvm_bt_coex_update_vif_esr(mvm, vif);
-
 		/* when client is authorized (AP station marked as such),
 		 * try to enable the best link(s).
 		 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 986176d94210..e16f1eee8473 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1180,7 +1180,7 @@ bool iwl_mvm_esr_allowed_on_vif(struct iwl_mvm *mvm,
 	    !(ext_capa->eml_capabilities & IEEE80211_EML_CAP_EMLSR_SUPP))
 		return false;
 
-	return !(mvmvif->esr_disable_reason & ~IWL_MVM_ESR_BLOCKED_COEX);
+	return !mvmvif->esr_disable_reason;
 }
 
 static bool iwl_mvm_mld_can_activate_links(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 421c927ec960..309711532042 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -353,20 +353,21 @@ struct iwl_mvm_vif_link_info {
  * For the blocking reasons - use iwl_mvm_(un)block_esr(), and for the exit
  * reasons - use iwl_mvm_exit_esr().
  *
- * @IWL_MVM_ESR_BLOCKED_COEX: COEX is preventing the enablement of EMLSR
  * @IWL_MVM_ESR_BLOCKED_PREVENTION: Prevent EMLSR to avoid entering and exiting
  *	in a loop.
  * @IWL_MVM_ESR_BLOCKED_WOWLAN: WOWLAN is preventing the enablement of EMLSR
  * @IWL_MVM_ESR_EXIT_MISSED_BEACON: exited EMLSR due to missed beacons
  * @IWL_MVM_ESR_EXIT_LOW_RSSI: link is deactivated/not allowed for EMLSR
  *	due to low RSSI.
+ * @IWL_MVM_ESR_EXIT_COEX: link is deactivated/not allowed for EMLSR
+ *	due to BT Coex.
  */
 enum iwl_mvm_esr_state {
-	IWL_MVM_ESR_BLOCKED_COEX	= 0x1,
-	IWL_MVM_ESR_BLOCKED_PREVENTION	= 0x2,
-	IWL_MVM_ESR_BLOCKED_WOWLAN	= 0x4,
+	IWL_MVM_ESR_BLOCKED_PREVENTION	= 0x1,
+	IWL_MVM_ESR_BLOCKED_WOWLAN	= 0x2,
 	IWL_MVM_ESR_EXIT_MISSED_BEACON	= 0x10000,
 	IWL_MVM_ESR_EXIT_LOW_RSSI	= 0x20000,
+	IWL_MVM_ESR_EXIT_COEX		= 0x40000,
 };
 
 #define IWL_MVM_BLOCK_ESR_REASONS 0xffff
@@ -2221,9 +2222,6 @@ bool iwl_mvm_bt_coex_is_tpc_allowed(struct iwl_mvm *mvm,
 u8 iwl_mvm_bt_coex_get_single_ant_msk(struct iwl_mvm *mvm, u8 enabled_ants);
 u8 iwl_mvm_bt_coex_tx_prio(struct iwl_mvm *mvm, struct ieee80211_hdr *hdr,
 			   struct ieee80211_tx_info *info, u8 ac);
-void iwl_mvm_bt_coex_update_link_esr(struct iwl_mvm *mvm,
-				     struct ieee80211_vif *vif,
-				     int link_id);
 
 /* beacon filtering */
 #ifdef CONFIG_IWLWIFI_DEBUGFS
@@ -2888,5 +2886,12 @@ void iwl_mvm_exit_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 s8 iwl_mvm_get_esr_rssi_thresh(struct iwl_mvm *mvm,
 			       const struct cfg80211_chan_def *chandef,
 			       bool low);
-
+void iwl_mvm_bt_coex_update_link_esr(struct iwl_mvm *mvm,
+				     struct ieee80211_vif *vif,
+				     int link_id);
+bool
+iwl_mvm_bt_coex_calculate_esr_mode(struct iwl_mvm *mvm,
+				   struct ieee80211_vif *vif,
+				   s32 link_rssi,
+				   bool primary);
 #endif /* __IWL_MVM_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c b/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
index 7446e0c168ee..217dbb823691 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
@@ -37,7 +37,20 @@ static struct cfg80211_bss bss = {};
 
 static struct ieee80211_bss_conf link_conf = {.bss = &bss};
 
-static struct iwl_mvm mvm = {};
+static const struct iwl_fw_cmd_version entry = {
+	.group = LEGACY_GROUP,
+	.cmd = BT_PROFILE_NOTIFICATION,
+	.notif_ver = 4
+};
+
+static struct iwl_fw fw = {
+	.ucode_capa = {
+		.n_cmd_versions = 1,
+		.cmd_versions = &entry,
+	},
+};
+
+static struct iwl_mvm mvm = {.fw = &fw};
 
 static const struct link_grading_case {
 	const char *desc;
@@ -217,7 +230,7 @@ kunit_test_suite(link_grading);
 
 static const struct valid_link_pair_case {
 	const char *desc;
-	u32 esr_disable_reason;
+	bool bt;
 	struct ieee80211_channel *chan_a;
 	struct ieee80211_channel *chan_b;
 	enum nl80211_chan_width cw_a;
@@ -240,7 +253,7 @@ static const struct valid_link_pair_case {
 	},
 	{
 		.desc = "LB + HB, with BT.",
-		.esr_disable_reason = 0x1,
+		.bt = true,
 		.chan_a = &chan_2ghz,
 		.chan_b = &chan_5ghz,
 		.valid = false,
@@ -370,7 +383,7 @@ static void test_valid_link_pair(struct kunit *test)
 #endif
 	mvm.trans = trans;
 
-	mvmvif->esr_disable_reason = params->esr_disable_reason;
+	mvm.last_bt_notif.wifi_loss_low_rssi = params->bt;
 	mvmvif->mvm = &mvm;
 
 	result = iwl_mvm_mld_valid_link_pair(vif, &link_a, &link_b);
-- 
2.34.1


