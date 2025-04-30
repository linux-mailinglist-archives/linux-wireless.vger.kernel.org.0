Return-Path: <linux-wireless+bounces-22252-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B0CAA4B0A
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 14:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AD839A0719
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 12:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4889025A327;
	Wed, 30 Apr 2025 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gEBPUYca"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B97E25A2CC
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746015899; cv=none; b=Z/8fLRayoPERb1w8ubtygH3SDoM1Bu/Uhq4X4PFK8kIX0lyGM6v6/5zChBYWpojEPHCdtCQhqudhyz3rl6U0NvP8wrWsHyVUo+/awAgRrYTmp81a45BV5dsFJY3C6XWpoaBxKWz5ZNzcJmOr6BJlKtmGnVE5NtTDKMsaNIx2LXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746015899; c=relaxed/simple;
	bh=WP2P8AFYBl7U4e2r/Sy8o6QiphutIp/cRLc/hOvtv2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OrUHWA7rzSf2NIH/v8wPD6wkabs6ZIp911KgrjVSrF3EeVF0a1GHQoAaUKWPo8xTodYVMdnVzk/3gRrRs5ajnIRgmUmijLNFJoXJ7vgcNWJw1yePLxiG/kZZJQW30vm78RNEx4kquo7S+4C12G6oKZbH2CwrV/GmLZjpXAdbc3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gEBPUYca; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746015897; x=1777551897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WP2P8AFYBl7U4e2r/Sy8o6QiphutIp/cRLc/hOvtv2o=;
  b=gEBPUYcaLo4SxxPsdmwTjTvizev30LlXQvEfSnq+hwvI5rtVJYNAUtBZ
   eJ/Yopih48dppEtry7lVv3cLyG2vTg5tR120Oxd8Nf0MTJaeiEEsfFlX9
   PP2cAmRkLB61wT1H/82hFOzHGQvG8wlShGGPfc89XCq6gnFLA8uDyLgEn
   aEBioVkQ/xeX5sllw3lVR2RLUQ7RHv7KC34dhuFEHEl9FTttw6D1goGTj
   X6sUExfGrd7KgwaCeEJs34kHeCkD6ny9+W1drADQr+g8Pkc6fDQyw8UW1
   5O/9YwmhoroNmEgDWBlDXHjEEIpAKGH2KPzpDu0yU97xV3Wr924ESE3fH
   w==;
X-CSE-ConnectionGUID: PPu4qPaMRBaPMA+ISfrwXA==
X-CSE-MsgGUID: Q7rY0GCQQMutiQEmx95C2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47578284"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="47578284"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:24:57 -0700
X-CSE-ConnectionGUID: DwJMFUkiQrmRw381dvPqUA==
X-CSE-MsgGUID: AShJqKtTTQm0AX8PKoSifA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="135087878"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:24:56 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Subject: [PATCH v2 iwlwifi-next 09/14] wifi: iwlwifi: mld: allow EMLSR with 2.4 GHz when BT is ON
Date: Wed, 30 Apr 2025 15:23:15 +0300
Message-Id: <20250430151952.d30212ec3901.I48e3d5bd6b0b8583f98057c38d2ee30fff5abd8a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430122320.1061510-1-miriam.rachel.korenblit@intel.com>
References: <20250430122320.1061510-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>

When BT is ON, EMLSR with one of the links operating on 2.4 GHz
is allowed only if it meets following conditions.
In this patch:
1. during link selection, when BT is ON, allow emlsr only if BT
   pentalty is < 7%.
2. exit EMLSR if BT is turned ON and one of the links is operating
   on 2.4 GHz with BT penalty > 7%

Signed-off-by: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/coex.c |  8 +--
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |  4 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  | 69 ++++++++++++++++---
 .../intel/iwlwifi/mld/tests/link-selection.c  |  6 ++
 4 files changed, 69 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/coex.c b/drivers/net/wireless/intel/iwlwifi/mld/coex.c
index 5f262bd43f21..32c727b3b391 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/coex.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/coex.c
@@ -24,17 +24,13 @@ int iwl_mld_send_bt_init_conf(struct iwl_mld *mld)
 void iwl_mld_handle_bt_coex_notif(struct iwl_mld *mld,
 				  struct iwl_rx_packet *pkt)
 {
-	const struct iwl_bt_coex_profile_notif *notif = (void *)pkt->data;
+	const struct iwl_bt_coex_profile_notif *notif = (const void *)pkt->data;
 	const struct iwl_bt_coex_profile_notif zero_notif = {};
 	/* zeroed structure means that BT is OFF */
 	bool bt_is_active = memcmp(notif, &zero_notif, sizeof(*notif));
 
-	if (bt_is_active == mld->bt_is_active)
-		return;
-
+	mld->last_bt_notif = *notif;
 	IWL_DEBUG_INFO(mld, "BT was turned %s\n", bt_is_active ? "ON" : "OFF");
 
-	mld->bt_is_active = bt_is_active;
-
 	iwl_mld_emlsr_check_bt(mld);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.h b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
index a4a16da6ebf3..7007a43bca4d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -126,7 +126,6 @@
  *	cleanup using iwl_mld_free_internal_sta
  * @netdetect: indicates the FW is in suspend mode with netdetect configured
  * @p2p_device_vif: points to the p2p device vif if exists
- * @bt_is_active: indicates that BT is active
  * @dev: pointer to device struct. For printing purposes
  * @trans: pointer to the transport layer
  * @cfg: pointer to the device configuration
@@ -184,6 +183,7 @@
  * @ptp_data: data of the PTP clock
  * @time_sync: time sync data.
  * @ftm_initiator: FTM initiator data
+ * @last_bt_notif: last received BT Coex notif
  */
 struct iwl_mld {
 	/* Add here fields that need clean up on restart */
@@ -207,7 +207,7 @@ struct iwl_mld {
 		bool netdetect;
 #endif /* CONFIG_PM_SLEEP */
 		struct ieee80211_vif *p2p_device_vif;
-		bool bt_is_active;
+		struct iwl_bt_coex_profile_notif last_bt_notif;
 	);
 	struct ieee80211_link_sta __rcu *fw_id_to_link_sta[IWL_STATION_COUNT_MAX];
 	/* And here fields that survive a fw restart */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index 91f3a48d0c4b..c84b39794c8f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -636,6 +636,40 @@ s8 iwl_mld_get_emlsr_rssi_thresh(struct iwl_mld *mld,
 #undef RSSI_THRESHOLD
 }
 
+#define IWL_MLD_BT_COEX_DISABLE_EMLSR_RSSI_THRESH	-69
+#define IWL_MLD_BT_COEX_ENABLE_EMLSR_RSSI_THRESH	-63
+#define IWL_MLD_BT_COEX_WIFI_LOSS_THRESH		7
+
+static bool
+iwl_mld_bt_allows_emlsr(struct iwl_mld *mld, struct ieee80211_bss_conf *link,
+			bool check_entry)
+{
+	int bt_penalty, rssi_thresh;
+	s32 link_rssi;
+
+	if (WARN_ON_ONCE(!link->bss))
+		return false;
+
+	link_rssi = MBM_TO_DBM(link->bss->signal);
+	rssi_thresh = check_entry ?
+		      IWL_MLD_BT_COEX_ENABLE_EMLSR_RSSI_THRESH :
+		      IWL_MLD_BT_COEX_DISABLE_EMLSR_RSSI_THRESH;
+	/* No valid RSSI - force to take low rssi */
+	if (!link_rssi)
+		link_rssi = rssi_thresh - 1;
+
+	if (link_rssi > rssi_thresh)
+		bt_penalty = max(mld->last_bt_notif.wifi_loss_mid_high_rssi[PHY_BAND_24][0],
+				 mld->last_bt_notif.wifi_loss_mid_high_rssi[PHY_BAND_24][1]);
+	else
+		bt_penalty = max(mld->last_bt_notif.wifi_loss_low_rssi[PHY_BAND_24][0],
+				 mld->last_bt_notif.wifi_loss_low_rssi[PHY_BAND_24][1]);
+
+	IWL_DEBUG_EHT(mld, "BT penalty for link-id %0X is %d\n",
+		      link->link_id, bt_penalty);
+	return bt_penalty < IWL_MLD_BT_COEX_WIFI_LOSS_THRESH;
+}
+
 static u32
 iwl_mld_emlsr_disallowed_with_link(struct iwl_mld *mld,
 				   struct ieee80211_vif *vif,
@@ -650,7 +684,8 @@ iwl_mld_emlsr_disallowed_with_link(struct iwl_mld *mld,
 	if (WARN_ON_ONCE(!conf))
 		return IWL_MLD_EMLSR_EXIT_INVALID;
 
-	if (link->chandef->chan->band == NL80211_BAND_2GHZ && mld->bt_is_active)
+	if (link->chandef->chan->band == NL80211_BAND_2GHZ &&
+	    !iwl_mld_bt_allows_emlsr(mld, conf, true))
 		ret |= IWL_MLD_EMLSR_EXIT_BT_COEX;
 
 	if (link->signal <
@@ -985,27 +1020,41 @@ static void iwl_mld_emlsr_check_bt_iter(void *_data, u8 *mac,
 					struct ieee80211_vif *vif)
 {
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	const struct iwl_bt_coex_profile_notif zero_notif = {};
 	struct iwl_mld *mld = mld_vif->mld;
 	struct ieee80211_bss_conf *link;
 	unsigned int link_id;
+	const struct iwl_bt_coex_profile_notif *notif = &mld->last_bt_notif;
 
-	if (!mld->bt_is_active) {
-		iwl_mld_retry_emlsr(mld, vif);
+	if (!iwl_mld_vif_has_emlsr_cap(vif))
 		return;
-	}
 
-	/* BT is turned ON but we are not in EMLSR, nothing to do */
-	if (!iwl_mld_emlsr_active(vif))
+	/* zeroed structure means that BT is OFF */
+	if (!memcmp(notif, &zero_notif, sizeof(*notif))) {
+		iwl_mld_retry_emlsr(mld, vif);
 		return;
-
-	/* In EMLSR and BT is turned ON */
+	}
 
 	for_each_vif_active_link(vif, link, link_id) {
+		bool emlsr_active, emlsr_allowed;
+
 		if (WARN_ON(!link->chanreq.oper.chan))
 			continue;
 
-		if (link->chanreq.oper.chan->band == NL80211_BAND_2GHZ) {
-			iwl_mld_exit_emlsr(mld, vif, IWL_MLD_EMLSR_EXIT_BT_COEX,
+		if (link->chanreq.oper.chan->band != NL80211_BAND_2GHZ)
+			continue;
+
+		emlsr_active = iwl_mld_emlsr_active(vif);
+		emlsr_allowed = iwl_mld_bt_allows_emlsr(mld, link,
+							!emlsr_active);
+		if (emlsr_allowed && !emlsr_active) {
+			iwl_mld_retry_emlsr(mld, vif);
+			return;
+		}
+
+		if (!emlsr_allowed && emlsr_active) {
+			iwl_mld_exit_emlsr(mld, vif,
+					   IWL_MLD_EMLSR_EXIT_BT_COEX,
 					   iwl_mld_get_primary_link(vif));
 			return;
 		}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c
index 766c24db3613..94a037bec1fa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c
@@ -287,6 +287,7 @@ static void test_iwl_mld_link_pair_allows_emlsr(struct kunit *test)
 	const struct link_pair_case *params = test->param_value;
 	struct iwl_mld *mld = test->priv;
 	struct ieee80211_vif *vif;
+	struct ieee80211_bss_conf *link;
 	/* link A is the primary and link B is the secondary */
 	struct iwl_mld_link_sel_data a = {
 		.chandef = params->chandef_a,
@@ -310,6 +311,11 @@ static void test_iwl_mld_link_pair_allows_emlsr(struct kunit *test)
 
 	wiphy_lock(mld->wiphy);
 
+	link = wiphy_dereference(mld->wiphy, vif->link_conf[a.link_id]);
+	KUNIT_ALLOC_AND_ASSERT(test, link->bss);
+	link = wiphy_dereference(mld->wiphy, vif->link_conf[b.link_id]);
+	KUNIT_ALLOC_AND_ASSERT(test, link->bss);
+
 	/* Simulate channel load */
 	if (params->primary_link_active) {
 		struct iwl_mld_phy *phy =
-- 
2.34.1


