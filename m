Return-Path: <linux-wireless+bounces-2899-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2302844941
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 21:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D464B1C2193B
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 20:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DC838DD2;
	Wed, 31 Jan 2024 20:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G6Hcy16a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BDB383BC
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 20:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706734620; cv=none; b=jMIvqL++SufWcQYbr1vZy594Bk00UQQrJWZFgNKz4kX4UZ2H05GoITQ506Xub4w542ia0/hHasGm0oOhyme91f98UHVmcDn/Z8ZqKcYEEd9xnPhWhfPlpjealsQtE6OCBvyQdiRORq6O5RIAacU+18bJb77akyfsosOG1moTB8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706734620; c=relaxed/simple;
	bh=htQoCp+G8DGoIBVQIv3ZyBlLFS4j4buIK56GvZ055EU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i612H54Fv23Od6MazOSOakpT5fo8zedQ6JWE0ndUftnuHJE58n9PXJBqfnpj96LTlFSsA+t9Yqr17Qf9NCjXVg8GbHNKDjn/Y+4bs3jDXAS9rfaOWOWGO6u4lLEb45czp1711zFbl+BPFeZHYcq6/54Zia/EyGRyxK/83XhEBhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G6Hcy16a; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706734619; x=1738270619;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=htQoCp+G8DGoIBVQIv3ZyBlLFS4j4buIK56GvZ055EU=;
  b=G6Hcy16aroJltNNx64KbI7p2BMkIj6o+lOxug80yoMkeMNfWUUXbmqDa
   Wms4zR3R2iRjFrzbSDkol8t9M574g5Bb6MrktNmo54hZ9tTzj3/+QDLh5
   XOWq1//D0vj11OE1D3TCHPRsbAYRVpLs/Y77e/C7T9sSOWBMcycEAk7s0
   LgPXDSj91j5RcKUf2b1S98LE0789A+nCh40XxQLPiexK7fVjOYBJILkit
   VFI9kUiKUvN2IgCNc0Dqusow2W9SHw6gVTGMyuEsknmiExEv3ME2HXlC1
   oOQzJltL3e2ZcGgssQD9fm4bpaDkUK14ggFhTvo3LdwNVJrm7K7I7GiYp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="17107608"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="17107608"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 12:56:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="788712105"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="788712105"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 12:56:44 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2] wifi: iwlwifi: disable eSR when BT is active
Date: Wed, 31 Jan 2024 22:56:32 +0200
Message-Id: <20240131225342.b922b6485af8.I7d808ce535a7372aca9cb85c045755e6788a4904@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

eSR should be disabled when BT Coex is active and:
- LB link is the primary link.
- LB link is the secondary link and the predicted BT penalty
  (the wifi loss rate caused by BT interference) is higher
  than a given threshold.
If one of the conditions above is no longer true then re-enable eSR.

In order to implement this, add support for version 5 of
BT_PROFILE_NOTIFICATION, in which the bt penalty is provided
by FW.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
---
v2: squashed a bugfix that was later found in this patch.

 .../net/wireless/intel/iwlwifi/fw/api/coex.h  |  14 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c | 124 ++++++++++++++++++
 .../wireless/intel/iwlwifi/mvm/constants.h    |   3 +
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 107 ++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  21 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  13 +-
 7 files changed, 275 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h b/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
index 3e81e9369224..bc27e15488f5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
+ * Copyright (C) 2023 Intel Corporation
  * Copyright (C) 2013-2014, 2018-2019 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2017 Intel Deutschland GmbH
@@ -170,7 +171,11 @@ enum iwl_bt_ci_compliance {
  * @bt_activity_grading: the activity of BT &enum iwl_bt_activity_grading
  * @ttc_status: is TTC enabled - one bit per PHY
  * @rrc_status: is RRC enabled - one bit per PHY
- * @reserved: reserved
+ * The following fields are only for version 5, and are reserved in version 4:
+ * @wifi_loss_low_rssi: The predicted lost WiFi rate (% of air time that BT is
+ *	utilizing) when the RSSI is low (<= -65 dBm)
+ * @wifi_loss_mid_high_rssi: The predicted lost WiFi rate (% of air time that
+ *	BT is utilizing) when the RSSI is mid/high (>= -65 dBm)
  */
 struct iwl_bt_coex_profile_notif {
 	__le32 mbox_msg[4];
@@ -182,7 +187,10 @@ struct iwl_bt_coex_profile_notif {
 	__le32 bt_activity_grading;
 	u8 ttc_status;
 	u8 rrc_status;
-	__le16 reserved;
-} __packed; /* BT_COEX_PROFILE_NTFY_API_S_VER_4 */
+	u8 wifi_loss_low_rssi;
+	u8 wifi_loss_mid_high_rssi;
+} __packed; /* BT_COEX_PROFILE_NTFY_API_S_VER_4
+	     * BT_COEX_PROFILE_NTFY_API_S_VER_5
+	     */
 
 #endif /* __iwl_fw_api_coex_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
index 9fe1761691ec..d26075e3e6ad 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
@@ -252,6 +252,124 @@ static void iwl_mvm_bt_coex_tcm_based_ci(struct iwl_mvm *mvm,
 	swap(data->primary, data->secondary);
 }
 
+static void iwl_mvm_bt_coex_enable_esr(struct iwl_mvm *mvm,
+				       struct ieee80211_vif *vif, bool enable)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	int link_id;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	if (!vif->cfg.assoc || !ieee80211_vif_is_mld(vif))
+		return;
+
+	/* Done already */
+	if (mvmvif->bt_coex_esr_disabled == !enable)
+		return;
+
+	mvmvif->bt_coex_esr_disabled = !enable;
+
+	/* Nothing to do */
+	if (mvmvif->esr_active == enable)
+		return;
+
+	if (enable) {
+		/* Try to re-enable eSR*/
+		iwl_mvm_mld_select_links(mvm, vif, false);
+		return;
+	}
+
+	/*
+	 * Find the primary link, as we want to switch to it and drop the
+	 * secondary one.
+	 */
+	link_id = iwl_mvm_mld_get_primary_link(mvm, vif, vif->active_links);
+	WARN_ON(link_id < 0);
+
+	ieee80211_set_active_links_async(vif,
+					 vif->active_links & BIT(link_id));
+}
+
+/*
+ * This function receives the LB link id and checks if eSR should be
+ * enabled or disabled (due to BT coex)
+ */
+bool
+iwl_mvm_bt_coex_calculate_esr_mode(struct iwl_mvm *mvm,
+				   struct ieee80211_vif *vif,
+				   int link_id, int primary_link)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_vif_link_info *link_info = mvmvif->link[link_id];
+	bool have_wifi_loss_rate =
+		iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
+					BT_PROFILE_NOTIFICATION, 0) > 4;
+	s8 link_rssi = 0;
+	u8 wifi_loss_rate;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	if (mvm->last_bt_notif.wifi_loss_low_rssi == BT_OFF)
+		return true;
+
+	 /* If LB link is the primary one we should always disable eSR */
+	if (link_id == primary_link)
+		return false;
+
+	/* The feature is not supported */
+	if (!have_wifi_loss_rate)
+		return true;
+
+	/*
+	 * We might not have a link_info when checking whether we can
+	 * (re)enable eSR - the LB link might not exist yet
+	 */
+	if (link_info)
+		link_rssi = (s8)link_info->beacon_stats.avg_signal;
+
+	/*
+	 * In case we don't know the RSSI - take the lower wifi loss,
+	 * so we will more likely enter eSR, and if RSSI is low -
+	 * we will get an update on this and exit eSR.
+	 */
+	if (!link_rssi)
+		wifi_loss_rate = mvm->last_bt_notif.wifi_loss_mid_high_rssi;
+
+	else if (!mvmvif->bt_coex_esr_disabled)
+		 /* RSSI needs to get really low to disable eSR... */
+		wifi_loss_rate =
+			link_rssi <= -IWL_MVM_BT_COEX_DISABLE_ESR_THRESH ?
+				mvm->last_bt_notif.wifi_loss_low_rssi :
+				mvm->last_bt_notif.wifi_loss_mid_high_rssi;
+	else
+		/* ...And really high before we enable it back */
+		wifi_loss_rate =
+			link_rssi <= -IWL_MVM_BT_COEX_ENABLE_ESR_THRESH ?
+				mvm->last_bt_notif.wifi_loss_low_rssi :
+				mvm->last_bt_notif.wifi_loss_mid_high_rssi;
+
+	return wifi_loss_rate <= IWL_MVM_BT_COEX_WIFI_LOSS_THRESH;
+}
+
+void iwl_mvm_bt_coex_update_vif_esr(struct iwl_mvm *mvm,
+				    struct ieee80211_vif *vif,
+				    int link_id)
+{
+	unsigned long usable_links = ieee80211_vif_usable_links(vif);
+	int primary_link = iwl_mvm_mld_get_primary_link(mvm, vif,
+							usable_links);
+	bool enable;
+
+	/* Not assoc, not MLD vif or only one usable link */
+	if (primary_link < 0)
+		return;
+
+	enable = iwl_mvm_bt_coex_calculate_esr_mode(mvm, vif, link_id,
+						    primary_link);
+
+	iwl_mvm_bt_coex_enable_esr(mvm, vif, enable);
+}
+
 static void iwl_mvm_bt_notif_per_link(struct iwl_mvm *mvm,
 				      struct ieee80211_vif *vif,
 				      struct iwl_bt_iterator_data *data,
@@ -297,6 +415,8 @@ static void iwl_mvm_bt_notif_per_link(struct iwl_mvm *mvm,
 		return;
 	}
 
+	iwl_mvm_bt_coex_update_vif_esr(mvm, vif, link_id);
+
 	if (fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_COEX_SCHEMA_2))
 		min_ag_for_static_smps = BT_VERY_HIGH_TRAFFIC;
 	else
@@ -432,6 +552,10 @@ static void iwl_mvm_bt_notif_iterator(void *_data, u8 *mac,
 		return;
 	}
 
+	/* When BT is off this will be 0 */
+	if (data->notif->wifi_loss_low_rssi == BT_OFF)
+		iwl_mvm_bt_coex_enable_esr(mvm, vif, true);
+
 	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++)
 		iwl_mvm_bt_notif_per_link(mvm, vif, data, link_id);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index c832068b5718..f5122c4678a1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -11,6 +11,9 @@
 #include "fw-api.h"
 
 #define IWL_MVM_UAPSD_NOAGG_BSSIDS_NUM		20
+#define IWL_MVM_BT_COEX_DISABLE_ESR_THRESH	69
+#define IWL_MVM_BT_COEX_ENABLE_ESR_THRESH	63
+#define IWL_MVM_BT_COEX_WIFI_LOSS_THRESH	0
 
 #define IWL_MVM_DEFAULT_PS_TX_DATA_TIMEOUT	(100 * USEC_PER_MSEC)
 #define IWL_MVM_DEFAULT_PS_RX_DATA_TIMEOUT	(100 * USEC_PER_MSEC)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index b1caf5163121..770e4c4e909a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -604,6 +604,7 @@ static int iwl_mvm_mld_mac_sta_state(struct ieee80211_hw *hw,
 struct iwl_mvm_link_sel_data {
 	u8 link_id;
 	enum nl80211_band band;
+	enum nl80211_chan_width width;
 	bool active;
 };
 
@@ -656,6 +657,7 @@ void iwl_mvm_mld_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 		data[n_data].link_id = link_id;
 		data[n_data].band = link_conf->chandef.chan->band;
+		data[n_data].width = link_conf->chandef.width;
 		data[n_data].active = vif->active_links & BIT(link_id);
 		n_data++;
 	}
@@ -1216,13 +1218,116 @@ iwl_mvm_mld_change_sta_links(struct ieee80211_hw *hw,
 	return ret;
 }
 
+/*
+ * This function receives a subset of the usable links bitmap and
+ * returns the primary link id, and -1 if such link doesn't exist
+ * (e.g. non-MLO connection) or wasn't found.
+ */
+int iwl_mvm_mld_get_primary_link(struct iwl_mvm *mvm,
+				 struct ieee80211_vif *vif,
+				 unsigned long usable_links)
+{
+	struct iwl_mvm_link_sel_data data[IEEE80211_MLD_MAX_NUM_LINKS];
+	u8 link_id, n_data = 0;
+
+	if (!ieee80211_vif_is_mld(vif) || !vif->cfg.assoc)
+		return -1;
+
+	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_bss_conf *link_conf =
+			link_conf_dereference_protected(vif, link_id);
+
+		if (WARN_ON_ONCE(!link_conf))
+			continue;
+
+		data[n_data].link_id = link_id;
+		data[n_data].band = link_conf->chandef.chan->band;
+		data[n_data].width = link_conf->chandef.width;
+		data[n_data].active = true;
+		n_data++;
+	}
+
+	if (n_data <= 1)
+		return -1;
+
+	/* The logic should be modified to handle more than 2 links */
+	WARN_ON_ONCE(n_data > 2);
+
+	/* Primary link is the link with the wider bandwidth or higher band */
+	if (data[0].width > data[1].width)
+		return data[0].link_id;
+	if (data[0].width < data[1].width)
+		return data[1].link_id;
+	if (data[0].band >= data[1].band)
+		return data[0].link_id;
+
+	return data[1].link_id;
+}
+
+/*
+ * This function receives a bitmap of usable links and check if we can enter
+ * eSR on those links.
+ */
+static bool iwl_mvm_can_enter_esr(struct iwl_mvm *mvm,
+				  struct ieee80211_vif *vif,
+				  unsigned long desired_links)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	int primary_link = iwl_mvm_mld_get_primary_link(mvm, vif,
+							desired_links);
+	bool ret = true;
+	int link_id;
+
+	if (primary_link < 0)
+		return false;
+
+	for_each_set_bit(link_id, &desired_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_bss_conf *link_conf =
+			link_conf_dereference_protected(vif, link_id);
+
+		if (WARN_ON_ONCE(!link_conf))
+			continue;
+
+		/* BT Coex effects eSR mode only if one of the link is on LB */
+		if (link_conf->chandef.chan->band != NL80211_BAND_2GHZ)
+			continue;
+
+		ret = iwl_mvm_bt_coex_calculate_esr_mode(mvm, vif, link_id,
+							 primary_link);
+		// Mark eSR as disabled for the next time
+		if (!ret)
+			mvmvif->bt_coex_esr_disabled = true;
+		break;
+	}
+
+	return ret;
+}
+
 static bool iwl_mvm_mld_can_activate_links(struct ieee80211_hw *hw,
 					   struct ieee80211_vif *vif,
 					   u16 desired_links)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+	int n_links = hweight16(desired_links);
+	bool ret = true;
+
+	if (n_links <= 1)
+		return true;
 
-	return hweight16(desired_links) <= iwl_mvm_max_active_links(mvm, vif);
+	mutex_lock(&mvm->mutex);
+
+	/* Check if HW supports the wanted number of links */
+	if (n_links > iwl_mvm_max_active_links(mvm, vif)) {
+		ret = false;
+		goto unlock;
+	}
+
+	/* If it is an eSR device, check that we can enter eSR */
+	if (iwl_mvm_is_esr_supported(mvm->fwrt.trans))
+		ret = iwl_mvm_can_enter_esr(mvm, vif, desired_links);
+unlock:
+	mutex_unlock(&mvm->mutex);
+	return ret;
 }
 
 const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index af5c8b4bb5a6..9a89b91519db 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -359,6 +359,7 @@ struct iwl_mvm_vif_link_info {
  * @pm_enabled - indicate if MAC power management is allowed
  * @monitor_active: indicates that monitor context is configured, and that the
  *	interface should get quota etc.
+ * @bt_coex_esr_disabled: indicates if esr is disabled due to bt coex
  * @low_latency: bit flags for low latency
  *	see enum &iwl_mvm_low_latency_cause for causes.
  * @low_latency_actual: boolean, indicates low latency is set,
@@ -389,6 +390,7 @@ struct iwl_mvm_vif {
 	bool pm_enabled;
 	bool monitor_active;
 	bool esr_active;
+	bool bt_coex_esr_disabled;
 
 	u8 low_latency: 6;
 	u8 low_latency_actual: 1;
@@ -1570,13 +1572,17 @@ static inline int iwl_mvm_max_active_links(struct iwl_mvm *mvm,
 					   struct ieee80211_vif *vif)
 {
 	struct iwl_trans *trans = mvm->fwrt.trans;
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
+	lockdep_assert_held(&mvm->mutex);
 
 	if (vif->type == NL80211_IFTYPE_AP)
 		return mvm->fw->ucode_capa.num_beacons;
 
-	if (iwl_mvm_is_esr_supported(trans) ||
-	    (CSR_HW_RFID_TYPE(trans->hw_rf_id) == IWL_CFG_RF_TYPE_FM &&
-	     CSR_HW_RFID_IS_CDB(trans->hw_rf_id)))
+	if ((iwl_mvm_is_esr_supported(trans) &&
+	     !mvmvif->bt_coex_esr_disabled) ||
+	    ((CSR_HW_RFID_TYPE(trans->hw_rf_id) == IWL_CFG_RF_TYPE_FM &&
+	     CSR_HW_RFID_IS_CDB(trans->hw_rf_id))))
 		return IWL_MVM_FW_MAX_ACTIVE_LINKS_NUM;
 
 	return 1;
@@ -2119,6 +2125,12 @@ bool iwl_mvm_bt_coex_is_tpc_allowed(struct iwl_mvm *mvm,
 u8 iwl_mvm_bt_coex_get_single_ant_msk(struct iwl_mvm *mvm, u8 enabled_ants);
 u8 iwl_mvm_bt_coex_tx_prio(struct iwl_mvm *mvm, struct ieee80211_hdr *hdr,
 			   struct ieee80211_tx_info *info, u8 ac);
+bool iwl_mvm_bt_coex_calculate_esr_mode(struct iwl_mvm *mvm,
+					struct ieee80211_vif *vif,
+					int link_id, int primary_link);
+void iwl_mvm_bt_coex_update_vif_esr(struct iwl_mvm *mvm,
+				    struct ieee80211_vif *vif,
+				    int link_id);
 
 /* beacon filtering */
 #ifdef CONFIG_IWLWIFI_DEBUGFS
@@ -2733,4 +2745,7 @@ bool iwl_mvm_enable_fils(struct iwl_mvm *mvm,
 			 struct ieee80211_chanctx_conf *ctx);
 void iwl_mvm_mld_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			      bool valid_links_changed);
+int iwl_mvm_mld_get_primary_link(struct iwl_mvm *mvm,
+				 struct ieee80211_vif *vif,
+				 unsigned long usable_links);
 #endif /* __IWL_MVM_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 38a84a54ff78..871274eea26f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -320,7 +320,8 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 		       struct iwl_tlc_update_notif),
 
 	RX_HANDLER(BT_PROFILE_NOTIFICATION, iwl_mvm_rx_bt_coex_notif,
-		   RX_HANDLER_ASYNC_LOCKED, struct iwl_bt_coex_profile_notif),
+		   RX_HANDLER_ASYNC_LOCKED_WIPHY,
+		   struct iwl_bt_coex_profile_notif),
 	RX_HANDLER_NO_SIZE(BEACON_NOTIFICATION, iwl_mvm_rx_beacon_notif,
 			   RX_HANDLER_ASYNC_LOCKED),
 	RX_HANDLER_NO_SIZE(STATISTICS_NOTIFICATION, iwl_mvm_rx_statistics,
@@ -328,7 +329,7 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 
 	RX_HANDLER_GRP(STATISTICS_GROUP, STATISTICS_OPER_NOTIF,
 		       iwl_mvm_handle_rx_system_oper_stats,
-		       RX_HANDLER_ASYNC_LOCKED,
+		       RX_HANDLER_ASYNC_LOCKED_WIPHY,
 		       struct iwl_system_statistics_notif_oper),
 	RX_HANDLER_GRP(STATISTICS_GROUP, STATISTICS_OPER_PART1_NOTIF,
 		       iwl_mvm_handle_rx_system_oper_part1_stats,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 8caa971770c6..72df41996464 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -841,6 +841,7 @@ iwl_mvm_stat_iterator_all_links(struct iwl_mvm *mvm,
 		struct iwl_stats_ntfy_per_link *link_stats;
 		struct ieee80211_bss_conf *bss_conf;
 		struct iwl_mvm_vif *mvmvif;
+		struct iwl_mvm_vif_link_info *link_info;
 		int link_id;
 		int sig;
 
@@ -857,20 +858,26 @@ iwl_mvm_stat_iterator_all_links(struct iwl_mvm *mvm,
 			continue;
 
 		mvmvif = iwl_mvm_vif_from_mac80211(bss_conf->vif);
-		if (!mvmvif || !mvmvif->link[link_id])
+		link_info = mvmvif->link[link_id];
+		if (!link_info)
 			continue;
 
 		link_stats = &per_link[fw_link_id];
 
-		mvmvif->link[link_id]->beacon_stats.num_beacons =
+		link_info->beacon_stats.num_beacons =
 			le32_to_cpu(link_stats->beacon_counter);
 
 		/* we basically just use the u8 to store 8 bits and then treat
 		 * it as a s8 whenever we take it out to a different type.
 		 */
-		mvmvif->link[link_id]->beacon_stats.avg_signal =
+		link_info->beacon_stats.avg_signal =
 			-le32_to_cpu(link_stats->beacon_average_energy);
 
+		if (link_info->phy_ctxt &&
+		    link_info->phy_ctxt->channel->band == NL80211_BAND_2GHZ)
+			iwl_mvm_bt_coex_update_vif_esr(mvm, bss_conf->vif,
+						       link_id);
+
 		/* make sure that beacon statistics don't go backwards with TCM
 		 * request to clear statistics
 		 */
-- 
2.34.1


