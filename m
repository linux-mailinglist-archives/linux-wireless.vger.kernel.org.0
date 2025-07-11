Return-Path: <linux-wireless+bounces-25286-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6A3B0208C
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 17:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBDB9A602A9
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 15:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D4F2ED867;
	Fri, 11 Jul 2025 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A+W86Zit"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6E72ED879
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248105; cv=none; b=Rj3g4eEiuGIyyWBJK0UH6jgQrpDS40tQalJFSscI7FOxPX/V+vYx9/WU7uQ4y6RTr7l+acZoPYWk4a9PgykO6PYyrocPRj4VuJRnxbcte2fLN12hoWNyHTUBLR+7lMGNpekde81ozmk1mvUVDCvyiXgtul7FgYByGBs7d9fh1kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248105; c=relaxed/simple;
	bh=ylCtGMPOh6I6uP9cC/rzudCJbEnASFDeNLpSVdn0p8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d9JqmCkpD/XVUCs/Oww+qoGfoDJfU+rY6tI5lyiJQln8bfliBTdkdRrG7tD3qmVW7PTJ8CMnQ1o5IJL59gFCSzT/MlKuqjM4w+T2260aSBtNahdI+DfcycAEXV10lR8NaSez2WVFwfrv98ZMEwGUjPZdyudSWcu4BAhBr9UHS2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A+W86Zit; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752248104; x=1783784104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ylCtGMPOh6I6uP9cC/rzudCJbEnASFDeNLpSVdn0p8k=;
  b=A+W86Zitpln5YSi/34JXZ+/3g5tK4S+d1TJpzA9tWBzvd7RYjAlcVnW3
   PmTgu8Nq+gWr9yyzcG7tzda7KOSkD3l9Y13lHybOHrn4VSvNYtz8YcwV9
   Isiiqk6beHojrc+fuCDwgwNVI6iGHYVYIu3gdZGOCNE1a3+KEAWXVl0Bm
   wWN4BU2FUb/6D9g10jkX8z2seUBFsSRsd9rvoA4Fwr7z9AioHHYxOinXd
   kWljWPAUu91YTsMglXrL7aQFJromf2IYrZEZaRhTZCPVhCYtIMC9YulQF
   6vgUt9jY2ETZqRd+cxHR9wA7mQ1gqc4gkjZiyHAz0MDK1//EjAt3karFT
   Q==;
X-CSE-ConnectionGUID: v39Y+SUPSLaTwGQ4lG7QZg==
X-CSE-MsgGUID: DgHhbxraRe+R5BdDltvSdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54264169"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="54264169"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:35:04 -0700
X-CSE-ConnectionGUID: xZg6hJxcRQasN1qS1HpBvQ==
X-CSE-MsgGUID: 9lt+3BD6Ruqrequ9qy+YkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="156485163"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:35:02 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: mld: Revert "wifi: iwlwifi: mld: allow EMLSR with 2.4 GHz when BT is ON"
Date: Fri, 11 Jul 2025 18:34:25 +0300
Message-Id: <20250711183056.57755ac3f39d.I63ae0ee3e6cdc9b11175ad15927aaad3b8f8f47a@changeid>
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

Due to a hw bug, this feature won't be enabled. Revert its
implementation.
This reverts commit 37808a3788fd ("wifi: iwlwifi: mld: allow EMLSR with
2.4 GHz when BT is ON")

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/coex.c |  8 ++-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |  4 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  | 66 +++----------------
 .../intel/iwlwifi/mld/tests/link-selection.c  |  6 --
 4 files changed, 18 insertions(+), 66 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/coex.c b/drivers/net/wireless/intel/iwlwifi/mld/coex.c
index 32c727b3b391..5f262bd43f21 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/coex.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/coex.c
@@ -24,13 +24,17 @@ int iwl_mld_send_bt_init_conf(struct iwl_mld *mld)
 void iwl_mld_handle_bt_coex_notif(struct iwl_mld *mld,
 				  struct iwl_rx_packet *pkt)
 {
-	const struct iwl_bt_coex_profile_notif *notif = (const void *)pkt->data;
+	const struct iwl_bt_coex_profile_notif *notif = (void *)pkt->data;
 	const struct iwl_bt_coex_profile_notif zero_notif = {};
 	/* zeroed structure means that BT is OFF */
 	bool bt_is_active = memcmp(notif, &zero_notif, sizeof(*notif));
 
-	mld->last_bt_notif = *notif;
+	if (bt_is_active == mld->bt_is_active)
+		return;
+
 	IWL_DEBUG_INFO(mld, "BT was turned %s\n", bt_is_active ? "ON" : "OFF");
 
+	mld->bt_is_active = bt_is_active;
+
 	iwl_mld_emlsr_check_bt(mld);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.h b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
index a9e59378f142..8bc4749599ca 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -127,6 +127,7 @@
  *	cleanup using iwl_mld_free_internal_sta
  * @netdetect: indicates the FW is in suspend mode with netdetect configured
  * @p2p_device_vif: points to the p2p device vif if exists
+ * @bt_is_active: indicates that BT is active
  * @dev: pointer to device struct. For printing purposes
  * @trans: pointer to the transport layer
  * @cfg: pointer to the device configuration
@@ -189,7 +190,6 @@
  * @ptp_data: data of the PTP clock
  * @time_sync: time sync data.
  * @ftm_initiator: FTM initiator data
- * @last_bt_notif: last received BT Coex notif
  */
 struct iwl_mld {
 	/* Add here fields that need clean up on restart */
@@ -214,7 +214,7 @@ struct iwl_mld {
 		bool netdetect;
 #endif /* CONFIG_PM_SLEEP */
 		struct ieee80211_vif *p2p_device_vif;
-		struct iwl_bt_coex_profile_notif last_bt_notif;
+		bool bt_is_active;
 	);
 	struct ieee80211_link_sta __rcu *fw_id_to_link_sta[IWL_STATION_COUNT_MAX];
 	/* And here fields that survive a fw restart */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index d002d2772a1d..e57f5388fe77 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -689,40 +689,6 @@ s8 iwl_mld_get_emlsr_rssi_thresh(struct iwl_mld *mld,
 #undef RSSI_THRESHOLD
 }
 
-#define IWL_MLD_BT_COEX_DISABLE_EMLSR_RSSI_THRESH	-69
-#define IWL_MLD_BT_COEX_ENABLE_EMLSR_RSSI_THRESH	-63
-#define IWL_MLD_BT_COEX_WIFI_LOSS_THRESH		7
-
-static bool
-iwl_mld_bt_allows_emlsr(struct iwl_mld *mld, struct ieee80211_bss_conf *link,
-			bool check_entry)
-{
-	int bt_penalty, rssi_thresh;
-	s32 link_rssi;
-
-	if (WARN_ON_ONCE(!link->bss))
-		return false;
-
-	link_rssi = MBM_TO_DBM(link->bss->signal);
-	rssi_thresh = check_entry ?
-		      IWL_MLD_BT_COEX_ENABLE_EMLSR_RSSI_THRESH :
-		      IWL_MLD_BT_COEX_DISABLE_EMLSR_RSSI_THRESH;
-	/* No valid RSSI - force to take low rssi */
-	if (!link_rssi)
-		link_rssi = rssi_thresh - 1;
-
-	if (link_rssi > rssi_thresh)
-		bt_penalty = max(mld->last_bt_notif.wifi_loss_mid_high_rssi[PHY_BAND_24][0],
-				 mld->last_bt_notif.wifi_loss_mid_high_rssi[PHY_BAND_24][1]);
-	else
-		bt_penalty = max(mld->last_bt_notif.wifi_loss_low_rssi[PHY_BAND_24][0],
-				 mld->last_bt_notif.wifi_loss_low_rssi[PHY_BAND_24][1]);
-
-	IWL_DEBUG_EHT(mld, "BT penalty for link-id %0X is %d\n",
-		      link->link_id, bt_penalty);
-	return bt_penalty < IWL_MLD_BT_COEX_WIFI_LOSS_THRESH;
-}
-
 static u32
 iwl_mld_emlsr_disallowed_with_link(struct iwl_mld *mld,
 				   struct ieee80211_vif *vif,
@@ -737,8 +703,7 @@ iwl_mld_emlsr_disallowed_with_link(struct iwl_mld *mld,
 	if (WARN_ON_ONCE(!conf))
 		return IWL_MLD_EMLSR_EXIT_INVALID;
 
-	if (link->chandef->chan->band == NL80211_BAND_2GHZ &&
-	    !iwl_mld_bt_allows_emlsr(mld, conf, true))
+	if (link->chandef->chan->band == NL80211_BAND_2GHZ && mld->bt_is_active)
 		ret |= IWL_MLD_EMLSR_EXIT_BT_COEX;
 
 	if (link->signal <
@@ -1076,41 +1041,30 @@ static void iwl_mld_emlsr_check_bt_iter(void *_data, u8 *mac,
 					struct ieee80211_vif *vif)
 {
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
-	const struct iwl_bt_coex_profile_notif zero_notif = {};
 	struct iwl_mld *mld = mld_vif->mld;
 	struct ieee80211_bss_conf *link;
 	unsigned int link_id;
-	const struct iwl_bt_coex_profile_notif *notif = &mld->last_bt_notif;
 
 	if (!iwl_mld_vif_has_emlsr_cap(vif))
 		return;
 
-	/* zeroed structure means that BT is OFF */
-	if (!memcmp(notif, &zero_notif, sizeof(*notif))) {
+	if (!mld->bt_is_active) {
 		iwl_mld_retry_emlsr(mld, vif);
 		return;
 	}
 
-	for_each_vif_active_link(vif, link, link_id) {
-		bool emlsr_active, emlsr_allowed;
+	/* BT is turned ON but we are not in EMLSR, nothing to do */
+	if (!iwl_mld_emlsr_active(vif))
+		return;
 
-		if (WARN_ON(!link->chanreq.oper.chan))
-			continue;
+	/* In EMLSR and BT is turned ON */
 
-		if (link->chanreq.oper.chan->band != NL80211_BAND_2GHZ)
+	for_each_vif_active_link(vif, link, link_id) {
+		if (WARN_ON(!link->chanreq.oper.chan))
 			continue;
 
-		emlsr_active = iwl_mld_emlsr_active(vif);
-		emlsr_allowed = iwl_mld_bt_allows_emlsr(mld, link,
-							!emlsr_active);
-		if (emlsr_allowed && !emlsr_active) {
-			iwl_mld_retry_emlsr(mld, vif);
-			return;
-		}
-
-		if (!emlsr_allowed && emlsr_active) {
-			iwl_mld_exit_emlsr(mld, vif,
-					   IWL_MLD_EMLSR_EXIT_BT_COEX,
+		if (link->chanreq.oper.chan->band == NL80211_BAND_2GHZ) {
+			iwl_mld_exit_emlsr(mld, vif, IWL_MLD_EMLSR_EXIT_BT_COEX,
 					   iwl_mld_get_primary_link(vif));
 			return;
 		}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c
index 94a037bec1fa..766c24db3613 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c
@@ -287,7 +287,6 @@ static void test_iwl_mld_link_pair_allows_emlsr(struct kunit *test)
 	const struct link_pair_case *params = test->param_value;
 	struct iwl_mld *mld = test->priv;
 	struct ieee80211_vif *vif;
-	struct ieee80211_bss_conf *link;
 	/* link A is the primary and link B is the secondary */
 	struct iwl_mld_link_sel_data a = {
 		.chandef = params->chandef_a,
@@ -311,11 +310,6 @@ static void test_iwl_mld_link_pair_allows_emlsr(struct kunit *test)
 
 	wiphy_lock(mld->wiphy);
 
-	link = wiphy_dereference(mld->wiphy, vif->link_conf[a.link_id]);
-	KUNIT_ALLOC_AND_ASSERT(test, link->bss);
-	link = wiphy_dereference(mld->wiphy, vif->link_conf[b.link_id]);
-	KUNIT_ALLOC_AND_ASSERT(test, link->bss);
-
 	/* Simulate channel load */
 	if (params->primary_link_active) {
 		struct iwl_mld_phy *phy =
-- 
2.34.1


