Return-Path: <linux-wireless+bounces-22214-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F02AA1BA5
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 21:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DDCE4E1FD3
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 19:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633C0262FDF;
	Tue, 29 Apr 2025 19:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eKXPmd5o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832B7261372
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 19:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745956459; cv=none; b=duAfThfKL23Db+8Qy/ZvsxUgdO2W+PJK9d5lNCJauY0thUEq2WZh8vHQCjjtiWMAiVUd6oON1As0wEan/3L26FmfuE59VC88JqoXY9K+mmyhXtwbNasyw/QpDQ89dqheXP0BH0ZXXWVHFR8T06+YyLEMV905+dYaVOCPqcPOfSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745956459; c=relaxed/simple;
	bh=wZPzTTNX3m8ryUSFvlNXkZ0jxxqgt9SoNq5mAEq9Y4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ulSbbMA2wK7yVYOLiGFJKgyY46IscVBuSqwj7K2kHKBqq054dkroxLNNDCSb+MR2s6TZnTQSs9yC3oCq3mQEpre07QNe2/Avsr3+oaM6qioRINuz6uVsjYyLFIsg+v2nmoJ37/I4RrJNurAgLcx1GxzQmOT9/rP+8aC+V2dmOR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eKXPmd5o; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745956458; x=1777492458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wZPzTTNX3m8ryUSFvlNXkZ0jxxqgt9SoNq5mAEq9Y4E=;
  b=eKXPmd5ocX3nuBU4XgVuFr2o/mX9cKKFlXYj9nFCnjQt1LEdhCVxPq5X
   eT2dI5f7YwpnUrMQV00miCtHfAK9JX4m4QaQsQqMQR7GRIQALveX44ctq
   M+uK+/oTQbORADLxFtaTBtMUFQB4w1sDPQe62Qkv/8y7nV2VJuky+TaoU
   atmBpu+izXaRxk4bnG/Y93061EgyWyF3tSZAgdjSQ4v/IJWjUClZGPmXx
   /Yu6QmqLZMrwsA5mTtviaax6+Uf3OycqiV8JNwr0leHHQhq2WttvOBiDL
   qyQ+eVq+XEnU0bwg+Itla7a6pzaBCmgMNXJWYa2vv9blOrUPlKtdxyM4u
   g==;
X-CSE-ConnectionGUID: VjNxISFCTOOAE1LwyPwwNA==
X-CSE-MsgGUID: XrIVSYETT/GaVeLKR/FHBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="46713588"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="46713588"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 12:54:17 -0700
X-CSE-ConnectionGUID: P6WzfwvxR+ONFuxGf/h1cw==
X-CSE-MsgGUID: DaxvG5OoRzapsE4/BTHPgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="171155018"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 12:54:15 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Subject: [PATCH iwlwifi-next 09/14] wifi: iwlwifi: mld: allow EMLSR with 2.4 GHz when BT is ON
Date: Tue, 29 Apr 2025 22:53:39 +0300
Message-Id: <20250429224932.a6d662721aec.I48e3d5bd6b0b8583f98057c38d2ee30fff5abd8a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250429195344.254957-1-miriam.rachel.korenblit@intel.com>
References: <20250429195344.254957-1-miriam.rachel.korenblit@intel.com>
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
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  | 62 ++++++++++++++++---
 .../intel/iwlwifi/mld/tests/link-selection.c  |  6 ++
 4 files changed, 62 insertions(+), 18 deletions(-)

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
index 91f3a48d0c4b..041375e1a492 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -636,6 +636,36 @@ s8 iwl_mld_get_emlsr_rssi_thresh(struct iwl_mld *mld,
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
+	int bt_penalty;
+	s32 link_rssi = MBM_TO_DBM(link->bss->signal);
+	int rssi_thresh = check_entry ?
+			  IWL_MLD_BT_COEX_ENABLE_EMLSR_RSSI_THRESH :
+			  IWL_MLD_BT_COEX_DISABLE_EMLSR_RSSI_THRESH;
+
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
@@ -650,7 +680,8 @@ iwl_mld_emlsr_disallowed_with_link(struct iwl_mld *mld,
 	if (WARN_ON_ONCE(!conf))
 		return IWL_MLD_EMLSR_EXIT_INVALID;
 
-	if (link->chandef->chan->band == NL80211_BAND_2GHZ && mld->bt_is_active)
+	if (link->chandef->chan->band == NL80211_BAND_2GHZ &&
+	    !iwl_mld_bt_allows_emlsr(mld, conf, true))
 		ret |= IWL_MLD_EMLSR_EXIT_BT_COEX;
 
 	if (link->signal <
@@ -985,27 +1016,38 @@ static void iwl_mld_emlsr_check_bt_iter(void *_data, u8 *mac,
 					struct ieee80211_vif *vif)
 {
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	const struct iwl_bt_coex_profile_notif zero_notif = {};
 	struct iwl_mld *mld = mld_vif->mld;
 	struct ieee80211_bss_conf *link;
 	unsigned int link_id;
+	const struct iwl_bt_coex_profile_notif *notif = &mld->last_bt_notif;
 
-	if (!mld->bt_is_active) {
+	/* zeroed structure means that BT is OFF */
+	if (!memcmp(notif, &zero_notif, sizeof(*notif))) {
 		iwl_mld_retry_emlsr(mld, vif);
 		return;
 	}
 
-	/* BT is turned ON but we are not in EMLSR, nothing to do */
-	if (!iwl_mld_emlsr_active(vif))
-		return;
-
-	/* In EMLSR and BT is turned ON */
-
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


