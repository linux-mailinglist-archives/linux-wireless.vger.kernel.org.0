Return-Path: <linux-wireless+bounces-26529-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBDBB30160
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 19:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F7B1BA6C7F
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 17:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FD82E5432;
	Thu, 21 Aug 2025 17:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K6RSoAmH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561E03376AE
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798478; cv=none; b=pBVsgVbQ9/nG8DW0rXnunm/y2v3W3mfog+eQTsQxAw7ZF6E+cafpyNLNc43yXAj0I6Vy63SO9CylR1+SUqYt4Uvd3IYxv3XK5C71RLclFdYPpuTkXPsKLq9AhqDo7p9+h6z/SOx2eSqhLdFbp/7zRhJjiY5wutfPN3VBifhvE/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798478; c=relaxed/simple;
	bh=UuLzDCjuaQHQ3Ovz+2r5NhKWzdbtJ12ZLzwsYhWetRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uxPH9zpdVM+VyjFSvNafE3Nwi2QIz9nkHqb0WJtXyRhvYrn7V5cREkJrch3tcGZlKVH4NhHoLNBerAK6vy1GKX178uipJWuP368GvfaAJ8R8EMGTnnhnGZltxFbj2JdQ2NJu276TCQIb3ly7gmKmWmSz/tC66XiW7ny/kjP9uVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K6RSoAmH; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755798474; x=1787334474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UuLzDCjuaQHQ3Ovz+2r5NhKWzdbtJ12ZLzwsYhWetRw=;
  b=K6RSoAmHrHfTLbZ0o+olPYGK2FBblyI+7Lrj4ZB7+a/Gv8ueC4uqUU7M
   roR4WzNPAikoBJrAeWdI4LFrrgtOlRB4U694aSR2NIf5WKOYma1tKpyNG
   bQQH3D9U9zNQqzIZfMLjmDHraKWH9nbuYShZ9J2FFjHXELOL4qPGJpBHx
   WACSyaaMKZZ8UNnqW8X9Ow3PzjBYlIbefU+nAaHOkMHPv0zfCJcjRUgHF
   zIdn2lqaFzHBMTA6PM6VvC+eZ7nQCCh+018G881VCtGQmLYZeoeaGV8/u
   NDMwE3zzxrAtftMdHcymOIKxEtE1eoX8SQUttxNZb7Bjqxzb6MDzAtsBY
   A==;
X-CSE-ConnectionGUID: j4WJPekqTKuoThz91ZZTNA==
X-CSE-MsgGUID: tBXsGij/QNyHDpbYd/KgXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68806058"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="68806058"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 10:47:54 -0700
X-CSE-ConnectionGUID: I7sq6dwTTVyzj6aADMtzOg==
X-CSE-MsgGUID: 0SY2EJQ/QNKI12z7GpfTjQ==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 10:47:52 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH v2 iwlwifi-next 01/15] wifi: iwlwifi: mvm: remove MLO code
Date: Thu, 21 Aug 2025 20:47:12 +0300
Message-Id: <20250821204455.933bb1a12e42.I3d017c30ffc2a29bc12ff0270562bcfb234c0785@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821174726.2425334-1-miriam.rachel.korenblit@intel.com>
References: <20250821174726.2425334-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Now as we have iwlmld, which is the op-mode that will be loaded for
EHT capable devices, there is no need for EHT features in iwlmvm.
This change removes:
- The logic of entering and exiting EMLSR
- Link selection
- MLO scan
- relevant Kunit tests
- related debugfs entries

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c | 131 ---
 .../wireless/intel/iwlwifi/mvm/constants.h    |  20 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |   6 -
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  |  94 --
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 809 ------------------
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  34 -
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 124 +--
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 138 +--
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |   2 -
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 130 +--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  53 --
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   | 133 ---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  14 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 101 ---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  89 --
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  24 -
 .../wireless/intel/iwlwifi/mvm/tests/Makefile |   2 +-
 .../wireless/intel/iwlwifi/mvm/tests/links.c  | 433 ----------
 .../wireless/intel/iwlwifi/mvm/time-event.c   |   3 -
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   8 +-
 20 files changed, 18 insertions(+), 2330 deletions(-)
 delete mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
index 13cdc077d8d3..ca63f780140f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
@@ -253,93 +253,6 @@ static void iwl_mvm_bt_coex_tcm_based_ci(struct iwl_mvm *mvm,
 	swap(data->primary, data->secondary);
 }
 
-/*
- * This function receives the LB link id and checks if eSR should be
- * enabled or disabled (due to BT coex)
- */
-bool
-iwl_mvm_bt_coex_calculate_esr_mode(struct iwl_mvm *mvm,
-				   struct ieee80211_vif *vif,
-				   s32 link_rssi,
-				   bool primary)
-{
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	bool have_wifi_loss_rate =
-		iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
-					BT_PROFILE_NOTIFICATION, 0) > 4 ||
-		iwl_fw_lookup_notif_ver(mvm->fw, BT_COEX_GROUP,
-					PROFILE_NOTIF, 0) >= 1;
-	u8 wifi_loss_mid_high_rssi;
-	u8 wifi_loss_low_rssi;
-	u8 wifi_loss_rate;
-
-	if (iwl_fw_lookup_notif_ver(mvm->fw, BT_COEX_GROUP,
-				    PROFILE_NOTIF, 0) >= 1) {
-		/* For now, we consider 2.4 GHz band / ANT_A only */
-		wifi_loss_mid_high_rssi =
-			mvm->last_bt_wifi_loss.wifi_loss_mid_high_rssi[PHY_BAND_24][0];
-		wifi_loss_low_rssi =
-			mvm->last_bt_wifi_loss.wifi_loss_low_rssi[PHY_BAND_24][0];
-	} else {
-		wifi_loss_mid_high_rssi = mvm->last_bt_notif.wifi_loss_mid_high_rssi;
-		wifi_loss_low_rssi = mvm->last_bt_notif.wifi_loss_low_rssi;
-	}
-
-	if (wifi_loss_low_rssi == BT_OFF)
-		return true;
-
-	if (primary)
-		return false;
-
-	/* The feature is not supported */
-	if (!have_wifi_loss_rate)
-		return true;
-
-
-	/*
-	 * In case we don't know the RSSI - take the lower wifi loss,
-	 * so we will more likely enter eSR, and if RSSI is low -
-	 * we will get an update on this and exit eSR.
-	 */
-	if (!link_rssi)
-		wifi_loss_rate = wifi_loss_mid_high_rssi;
-
-	else if (mvmvif->esr_active)
-		 /* RSSI needs to get really low to disable eSR... */
-		wifi_loss_rate =
-			link_rssi <= -IWL_MVM_BT_COEX_DISABLE_ESR_THRESH ?
-				wifi_loss_low_rssi :
-				wifi_loss_mid_high_rssi;
-	else
-		/* ...And really high before we enable it back */
-		wifi_loss_rate =
-			link_rssi <= -IWL_MVM_BT_COEX_ENABLE_ESR_THRESH ?
-				wifi_loss_low_rssi :
-				wifi_loss_mid_high_rssi;
-
-	return wifi_loss_rate <= IWL_MVM_BT_COEX_WIFI_LOSS_THRESH;
-}
-
-void iwl_mvm_bt_coex_update_link_esr(struct iwl_mvm *mvm,
-				     struct ieee80211_vif *vif,
-				     int link_id)
-{
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mvm_vif_link_info *link = mvmvif->link[link_id];
-
-	if (!ieee80211_vif_is_mld(vif) ||
-	    !iwl_mvm_vif_from_mac80211(vif)->authorized ||
-	    WARN_ON(!link))
-		return;
-
-	if (!iwl_mvm_bt_coex_calculate_esr_mode(mvm, vif,
-						(s8)link->beacon_stats.avg_signal,
-						link_id == iwl_mvm_get_primary_link(vif)))
-		/* In case we decided to exit eSR - stay with the primary */
-		iwl_mvm_exit_esr(mvm, vif, IWL_MVM_ESR_EXIT_COEX,
-				 iwl_mvm_get_primary_link(vif));
-}
-
 static void iwl_mvm_bt_notif_per_link(struct iwl_mvm *mvm,
 				      struct ieee80211_vif *vif,
 				      struct iwl_bt_iterator_data *data,
@@ -385,8 +298,6 @@ static void iwl_mvm_bt_notif_per_link(struct iwl_mvm *mvm,
 		return;
 	}
 
-	iwl_mvm_bt_coex_update_link_esr(mvm, vif, link_id);
-
 	if (fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_COEX_SCHEMA_2))
 		min_ag_for_static_smps = BT_VERY_HIGH_TRAFFIC;
 	else
@@ -525,32 +436,6 @@ static void iwl_mvm_bt_notif_iterator(void *_data, u8 *mac,
 		iwl_mvm_bt_notif_per_link(mvm, vif, data, link_id);
 }
 
-/* must be called under rcu_read_lock */
-static void iwl_mvm_bt_coex_notif_iterator(void *_data, u8 *mac,
-					   struct ieee80211_vif *vif)
-{
-	struct iwl_mvm *mvm = _data;
-	struct ieee80211_bss_conf *link_conf;
-	unsigned int link_id;
-
-	lockdep_assert_held(&mvm->mutex);
-
-	if (vif->type != NL80211_IFTYPE_STATION)
-		return;
-
-	for_each_vif_active_link(vif, link_conf, link_id) {
-		struct ieee80211_chanctx_conf *chanctx_conf =
-			rcu_dereference_check(link_conf->chanctx_conf,
-					      lockdep_is_held(&mvm->mutex));
-
-		if ((!chanctx_conf ||
-		     chanctx_conf->def.chan->band != NL80211_BAND_2GHZ))
-			continue;
-
-		iwl_mvm_bt_coex_update_link_esr(mvm, vif, link_id);
-	}
-}
-
 static void iwl_mvm_bt_coex_notif_handle(struct iwl_mvm *mvm)
 {
 	struct iwl_bt_iterator_data data = {
@@ -654,22 +539,6 @@ void iwl_mvm_rx_bt_coex_old_notif(struct iwl_mvm *mvm,
 	iwl_mvm_bt_coex_notif_handle(mvm);
 }
 
-void iwl_mvm_rx_bt_coex_notif(struct iwl_mvm *mvm,
-			      struct iwl_rx_cmd_buffer *rxb)
-{
-	const struct iwl_rx_packet *pkt = rxb_addr(rxb);
-	const struct iwl_bt_coex_profile_notif *notif = (const void *)pkt->data;
-
-	lockdep_assert_held(&mvm->mutex);
-
-	mvm->last_bt_wifi_loss = *notif;
-
-	ieee80211_iterate_active_interfaces(mvm->hw,
-					    IEEE80211_IFACE_ITER_NORMAL,
-					    iwl_mvm_bt_coex_notif_iterator,
-					    mvm);
-}
-
 void iwl_mvm_bt_rssi_event(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			   enum ieee80211_rssi_event_data rssi_event)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index 776600ddaea6..17f94663c941 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
- * Copyright (C) 2013-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2013-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2015 Intel Deutschland GmbH
  */
 #ifndef __MVM_CONSTANTS_H
@@ -11,15 +11,7 @@
 #include "fw-api.h"
 
 #define IWL_MVM_UAPSD_NOAGG_BSSIDS_NUM		20
-#define IWL_MVM_BT_COEX_DISABLE_ESR_THRESH	69
-#define IWL_MVM_BT_COEX_ENABLE_ESR_THRESH	63
-#define IWL_MVM_BT_COEX_WIFI_LOSS_THRESH	0
 #define IWL_MVM_TRIGGER_LINK_SEL_TIME_SEC	30
-#define IWL_MVM_TPT_COUNT_WINDOW_SEC		5
-#define IWL_MVM_BCN_LOSS_EXIT_ESR_THRESH_2_LINKS	5
-#define IWL_MVM_BCN_LOSS_EXIT_ESR_THRESH	15
-#define IWL_MVM_BCN_LOSS_EXIT_ESR_THRESH_BSS_PARAM_CHANGED	11
-#define IWL_MVM_LOW_RSSI_MLO_SCAN_THRESH	-72
 
 #define IWL_MVM_DEFAULT_PS_TX_DATA_TIMEOUT	(100 * USEC_PER_MSEC)
 #define IWL_MVM_DEFAULT_PS_RX_DATA_TIMEOUT	(100 * USEC_PER_MSEC)
@@ -129,14 +121,4 @@
 #define IWL_MVM_MIN_BEACON_INTERVAL_TU		16
 #define IWL_MVM_AUTO_EML_ENABLE                 true
 
-#define IWL_MVM_HIGH_RSSI_THRESH_20MHZ		-67
-#define IWL_MVM_LOW_RSSI_THRESH_20MHZ		-71
-#define IWL_MVM_HIGH_RSSI_THRESH_40MHZ		-64
-#define IWL_MVM_LOW_RSSI_THRESH_40MHZ		-67
-#define IWL_MVM_HIGH_RSSI_THRESH_80MHZ		-61
-#define IWL_MVM_LOW_RSSI_THRESH_80MHZ		-74
-#define IWL_MVM_HIGH_RSSI_THRESH_160MHZ		-58
-#define IWL_MVM_LOW_RSSI_THRESH_160MHZ		-61
-
-#define IWL_MVM_ENTER_ESR_TPT_THRESH		400
 #endif /* __MVM_CONSTANTS_H */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 029c846a236f..a4090db00d0b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1278,10 +1278,6 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 	if (IS_ERR_OR_NULL(vif))
 		return 1;
 
-	ret = iwl_mvm_block_esr_sync(mvm, vif, IWL_MVM_ESR_BLOCKED_WOWLAN);
-	if (ret)
-		return ret;
-
 	mutex_lock(&mvm->mutex);
 
 	set_bit(IWL_MVM_STATUS_IN_D3, &mvm->status);
@@ -3303,8 +3299,6 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 			goto err;
 	}
 
-	iwl_mvm_unblock_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_WOWLAN);
-
 	/* when reset is required we can't send these following commands */
 	if (d3_data.d3_end_flags & IWL_D0I3_RESET_REQUIRE)
 		goto query_wakeup_reasons;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
index fbe4e4a50852..a56c352a459a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
@@ -762,96 +762,6 @@ static ssize_t iwl_dbgfs_max_tx_op_read(struct file *file,
 	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
 }
 
-static ssize_t iwl_dbgfs_int_mlo_scan_write(struct ieee80211_vif *vif,
-					    char *buf, size_t count,
-					    loff_t *ppos)
-{
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mvm *mvm = mvmvif->mvm;
-	u32 action;
-	int ret;
-
-	if (!vif->cfg.assoc || !ieee80211_vif_is_mld(vif))
-		return -EINVAL;
-
-	if (kstrtou32(buf, 0, &action))
-		return -EINVAL;
-
-	mutex_lock(&mvm->mutex);
-
-	if (!action) {
-		ret = iwl_mvm_scan_stop(mvm, IWL_MVM_SCAN_INT_MLO, false);
-	} else if (action == 1) {
-		ret = iwl_mvm_int_mlo_scan(mvm, vif);
-	} else {
-		ret = -EINVAL;
-	}
-
-	mutex_unlock(&mvm->mutex);
-
-	return ret ?: count;
-}
-
-static ssize_t iwl_dbgfs_esr_disable_reason_read(struct file *file,
-						 char __user *user_buf,
-						 size_t count, loff_t *ppos)
-{
-	struct ieee80211_vif *vif = file->private_data;
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mvm *mvm = mvmvif->mvm;
-	unsigned long esr_mask;
-	char *buf;
-	int bufsz, pos, i;
-	ssize_t rv;
-
-	mutex_lock(&mvm->mutex);
-	esr_mask = mvmvif->esr_disable_reason;
-	mutex_unlock(&mvm->mutex);
-
-	bufsz = hweight32(esr_mask) * 32 + 40;
-	buf = kmalloc(bufsz, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	pos = scnprintf(buf, bufsz, "EMLSR state: '0x%lx'\nreasons:\n",
-			esr_mask);
-	for_each_set_bit(i, &esr_mask, BITS_PER_LONG)
-		pos += scnprintf(buf + pos, bufsz - pos, " - %s\n",
-				 iwl_get_esr_state_string(BIT(i)));
-
-	rv = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
-	kfree(buf);
-	return rv;
-}
-
-static ssize_t iwl_dbgfs_esr_disable_reason_write(struct ieee80211_vif *vif,
-						  char *buf, size_t count,
-						  loff_t *ppos)
-{
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mvm *mvm = mvmvif->mvm;
-	u32 reason;
-	u8 block;
-	int ret;
-
-	ret = sscanf(buf, "%u %hhu", &reason, &block);
-	if (ret < 0)
-		return ret;
-
-	if (hweight16(reason) != 1 || !(reason & IWL_MVM_BLOCK_ESR_REASONS))
-		return -EINVAL;
-
-	mutex_lock(&mvm->mutex);
-	if (block)
-		iwl_mvm_block_esr(mvm, vif, reason,
-				  iwl_mvm_get_primary_link(vif));
-	else
-		iwl_mvm_unblock_esr(mvm, vif, reason);
-	mutex_unlock(&mvm->mutex);
-
-	return count;
-}
-
 #define MVM_DEBUGFS_WRITE_FILE_OPS(name, bufsz) \
 	_MVM_DEBUGFS_WRITE_FILE_OPS(name, bufsz, struct ieee80211_vif)
 #define MVM_DEBUGFS_READ_WRITE_FILE_OPS(name, bufsz) \
@@ -884,8 +794,6 @@ MVM_DEBUGFS_READ_WRITE_FILE_OPS(rx_phyinfo, 10);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(quota_min, 32);
 MVM_DEBUGFS_READ_FILE_OPS(os_device_timediff);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(max_tx_op, 10);
-MVM_DEBUGFS_WRITE_FILE_OPS(int_mlo_scan, 32);
-MVM_DEBUGFS_READ_WRITE_FILE_OPS(esr_disable_reason, 32);
 
 void iwl_mvm_vif_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 {
@@ -916,8 +824,6 @@ void iwl_mvm_vif_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	MVM_DEBUGFS_ADD_FILE_VIF(max_tx_op, mvmvif->dbgfs_dir, 0600);
 	debugfs_create_bool("ftm_unprotected", 0200, mvmvif->dbgfs_dir,
 			    &mvmvif->ftm_unprotected);
-	MVM_DEBUGFS_ADD_FILE_VIF(int_mlo_scan, mvmvif->dbgfs_dir, 0200);
-	MVM_DEBUGFS_ADD_FILE_VIF(esr_disable_reason, mvmvif->dbgfs_dir, 0600);
 
 	if (vif->type == NL80211_IFTYPE_STATION && !vif->p2p &&
 	    mvmvif == mvm->bf_allowed_vif)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 2269acc55c0e..738facceb240 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -5,50 +5,6 @@
 #include "mvm.h"
 #include "time-event.h"
 
-#define HANDLE_ESR_REASONS(HOW)		\
-	HOW(BLOCKED_PREVENTION)		\
-	HOW(BLOCKED_WOWLAN)		\
-	HOW(BLOCKED_TPT)		\
-	HOW(BLOCKED_FW)			\
-	HOW(BLOCKED_NON_BSS)		\
-	HOW(BLOCKED_ROC)		\
-	HOW(BLOCKED_TMP_NON_BSS)	\
-	HOW(EXIT_MISSED_BEACON)		\
-	HOW(EXIT_LOW_RSSI)		\
-	HOW(EXIT_COEX)			\
-	HOW(EXIT_BANDWIDTH)		\
-	HOW(EXIT_CSA)			\
-	HOW(EXIT_LINK_USAGE)
-
-static const char *const iwl_mvm_esr_states_names[] = {
-#define NAME_ENTRY(x) [ilog2(IWL_MVM_ESR_##x)] = #x,
-	HANDLE_ESR_REASONS(NAME_ENTRY)
-};
-
-const char *iwl_get_esr_state_string(enum iwl_mvm_esr_state state)
-{
-	int offs = ilog2(state);
-
-	if (offs >= ARRAY_SIZE(iwl_mvm_esr_states_names) ||
-	    !iwl_mvm_esr_states_names[offs])
-		return "UNKNOWN";
-
-	return iwl_mvm_esr_states_names[offs];
-}
-
-static void iwl_mvm_print_esr_state(struct iwl_mvm *mvm, u32 mask)
-{
-#define NAME_FMT(x) "%s"
-#define NAME_PR(x) (mask & IWL_MVM_ESR_##x) ? "[" #x "]" : "",
-	IWL_DEBUG_INFO(mvm,
-		       "EMLSR state = " HANDLE_ESR_REASONS(NAME_FMT)
-		       " (0x%x)\n",
-		       HANDLE_ESR_REASONS(NAME_PR)
-		       mask);
-#undef NAME_FMT
-#undef NAME_PR
-}
-
 static int iwl_mvm_link_cmd_send(struct iwl_mvm *mvm,
 				 struct iwl_link_config_cmd *cmd,
 				 enum iwl_ctxt_action action)
@@ -114,65 +70,6 @@ int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	return iwl_mvm_link_cmd_send(mvm, &cmd, FW_CTXT_ACTION_ADD);
 }
 
-struct iwl_mvm_esr_iter_data {
-	struct ieee80211_vif *vif;
-	unsigned int link_id;
-	bool lift_block;
-};
-
-static void iwl_mvm_esr_vif_iterator(void *_data, u8 *mac,
-				     struct ieee80211_vif *vif)
-{
-	struct iwl_mvm_esr_iter_data *data = _data;
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	int link_id;
-
-	if (ieee80211_vif_type_p2p(vif) == NL80211_IFTYPE_STATION)
-		return;
-
-	for_each_mvm_vif_valid_link(mvmvif, link_id) {
-		struct iwl_mvm_vif_link_info *link_info =
-			mvmvif->link[link_id];
-		if (vif == data->vif && link_id == data->link_id)
-			continue;
-		if (link_info->active)
-			data->lift_block = false;
-	}
-}
-
-int iwl_mvm_esr_non_bss_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			     unsigned int link_id, bool active)
-{
-	/* An active link of a non-station vif blocks EMLSR. Upon activation
-	 * block EMLSR on the bss vif. Upon deactivation, check if this link
-	 * was the last non-station link active, and if so unblock the bss vif
-	 */
-	struct ieee80211_vif *bss_vif = iwl_mvm_get_bss_vif(mvm);
-	struct iwl_mvm_esr_iter_data data = {
-		.vif = vif,
-		.link_id = link_id,
-		.lift_block = true,
-	};
-
-	if (IS_ERR_OR_NULL(bss_vif))
-		return 0;
-
-	if (active)
-		return iwl_mvm_block_esr_sync(mvm, bss_vif,
-					      IWL_MVM_ESR_BLOCKED_NON_BSS);
-
-	ieee80211_iterate_active_interfaces(mvm->hw,
-					    IEEE80211_IFACE_ITER_NORMAL,
-					    iwl_mvm_esr_vif_iterator, &data);
-	if (data.lift_block) {
-		mutex_lock(&mvm->mutex);
-		iwl_mvm_unblock_esr(mvm, bss_vif, IWL_MVM_ESR_BLOCKED_NON_BSS);
-		mutex_unlock(&mvm->mutex);
-	}
-
-	return 0;
-}
-
 int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			 struct ieee80211_bss_conf *link_conf,
 			 u32 changes, bool active)
@@ -388,452 +285,6 @@ int iwl_mvm_disable_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	return ret;
 }
 
-struct iwl_mvm_rssi_to_grade {
-	s8 rssi[2];
-	u16 grade;
-};
-
-#define RSSI_TO_GRADE_LINE(_lb, _hb_uhb, _grade) \
-	{ \
-		.rssi = {_lb, _hb_uhb}, \
-		.grade = _grade \
-	}
-
-/*
- * This array must be sorted by increasing RSSI for proper functionality.
- * The grades are actually estimated throughput, represented as fixed-point
- * with a scale factor of 1/10.
- */
-static const struct iwl_mvm_rssi_to_grade rssi_to_grade_map[] = {
-	RSSI_TO_GRADE_LINE(-85, -89, 177),
-	RSSI_TO_GRADE_LINE(-83, -86, 344),
-	RSSI_TO_GRADE_LINE(-82, -85, 516),
-	RSSI_TO_GRADE_LINE(-80, -83, 688),
-	RSSI_TO_GRADE_LINE(-77, -79, 1032),
-	RSSI_TO_GRADE_LINE(-73, -76, 1376),
-	RSSI_TO_GRADE_LINE(-70, -74, 1548),
-	RSSI_TO_GRADE_LINE(-69, -72, 1750),
-	RSSI_TO_GRADE_LINE(-65, -68, 2064),
-	RSSI_TO_GRADE_LINE(-61, -66, 2294),
-	RSSI_TO_GRADE_LINE(-58, -61, 2580),
-	RSSI_TO_GRADE_LINE(-55, -58, 2868),
-	RSSI_TO_GRADE_LINE(-46, -55, 3098),
-	RSSI_TO_GRADE_LINE(-43, -54, 3442)
-};
-
-#define MAX_GRADE (rssi_to_grade_map[ARRAY_SIZE(rssi_to_grade_map) - 1].grade)
-
-#define DEFAULT_CHAN_LOAD_LB	30
-#define DEFAULT_CHAN_LOAD_HB	15
-#define DEFAULT_CHAN_LOAD_UHB	0
-
-/* Factors calculation is done with fixed-point with a scaling factor of 1/256 */
-#define SCALE_FACTOR 256
-
-/* Convert a percentage from [0,100] to [0,255] */
-#define NORMALIZE_PERCENT_TO_255(percentage) ((percentage) * SCALE_FACTOR / 100)
-
-static unsigned int
-iwl_mvm_get_puncturing_factor(const struct ieee80211_bss_conf *link_conf)
-{
-	enum nl80211_chan_width chan_width =
-		link_conf->chanreq.oper.width;
-	int mhz = nl80211_chan_width_to_mhz(chan_width);
-	unsigned int n_subchannels, n_punctured, puncturing_penalty;
-
-	if (WARN_ONCE(mhz < 20 || mhz > 320,
-		      "Invalid channel width : (%d)\n", mhz))
-		return SCALE_FACTOR;
-
-	/* No puncturing, no penalty */
-	if (mhz < 80)
-		return SCALE_FACTOR;
-
-	/* total number of subchannels */
-	n_subchannels = mhz / 20;
-	/* how many of these are punctured */
-	n_punctured = hweight16(link_conf->chanreq.oper.punctured);
-
-	puncturing_penalty = n_punctured * SCALE_FACTOR / n_subchannels;
-	return SCALE_FACTOR - puncturing_penalty;
-}
-
-static unsigned int
-iwl_mvm_get_chan_load(struct ieee80211_bss_conf *link_conf)
-{
-	struct ieee80211_vif *vif = link_conf->vif;
-	struct iwl_mvm_vif_link_info *mvm_link =
-		iwl_mvm_vif_from_mac80211(link_conf->vif)->link[link_conf->link_id];
-	const struct element *bss_load_elem;
-	const struct ieee80211_bss_load_elem *bss_load;
-	enum nl80211_band band = link_conf->chanreq.oper.chan->band;
-	const struct cfg80211_bss_ies *ies;
-	unsigned int chan_load;
-	u32 chan_load_by_us;
-
-	rcu_read_lock();
-	if (ieee80211_vif_link_active(vif, link_conf->link_id))
-		ies = rcu_dereference(link_conf->bss->beacon_ies);
-	else
-		ies = rcu_dereference(link_conf->bss->ies);
-
-	if (ies)
-		bss_load_elem = cfg80211_find_elem(WLAN_EID_QBSS_LOAD,
-						   ies->data, ies->len);
-	else
-		bss_load_elem = NULL;
-
-	/* If there isn't BSS Load element, take the defaults */
-	if (!bss_load_elem ||
-	    bss_load_elem->datalen != sizeof(*bss_load)) {
-		rcu_read_unlock();
-		switch (band) {
-		case NL80211_BAND_2GHZ:
-			chan_load = DEFAULT_CHAN_LOAD_LB;
-			break;
-		case NL80211_BAND_5GHZ:
-			chan_load = DEFAULT_CHAN_LOAD_HB;
-			break;
-		case NL80211_BAND_6GHZ:
-			chan_load = DEFAULT_CHAN_LOAD_UHB;
-			break;
-		default:
-			chan_load = 0;
-			break;
-		}
-		/* The defaults are given in percentage */
-		return NORMALIZE_PERCENT_TO_255(chan_load);
-	}
-
-	bss_load = (const void *)bss_load_elem->data;
-	/* Channel util is in range 0-255 */
-	chan_load = bss_load->channel_util;
-	rcu_read_unlock();
-
-	if (!mvm_link || !mvm_link->active)
-		return chan_load;
-
-	if (WARN_ONCE(!mvm_link->phy_ctxt,
-		      "Active link (%u) without phy ctxt assigned!\n",
-		      link_conf->link_id))
-		return chan_load;
-
-	/* channel load by us is given in percentage */
-	chan_load_by_us =
-		NORMALIZE_PERCENT_TO_255(mvm_link->phy_ctxt->channel_load_by_us);
-
-	/* Use only values that firmware sends that can possibly be valid */
-	if (chan_load_by_us <= chan_load)
-		chan_load -= chan_load_by_us;
-
-	return chan_load;
-}
-
-static unsigned int
-iwl_mvm_get_chan_load_factor(struct ieee80211_bss_conf *link_conf)
-{
-	return SCALE_FACTOR - iwl_mvm_get_chan_load(link_conf);
-}
-
-/* This function calculates the grade of a link. Returns 0 in error case */
-VISIBLE_IF_IWLWIFI_KUNIT
-unsigned int iwl_mvm_get_link_grade(struct ieee80211_bss_conf *link_conf)
-{
-	enum nl80211_band band;
-	int i, rssi_idx;
-	s32 link_rssi;
-	unsigned int grade = MAX_GRADE;
-
-	if (WARN_ON_ONCE(!link_conf))
-		return 0;
-
-	band = link_conf->chanreq.oper.chan->band;
-	if (WARN_ONCE(band != NL80211_BAND_2GHZ &&
-		      band != NL80211_BAND_5GHZ &&
-		      band != NL80211_BAND_6GHZ,
-		      "Invalid band (%u)\n", band))
-		return 0;
-
-	link_rssi = MBM_TO_DBM(link_conf->bss->signal);
-	/*
-	 * For 6 GHz the RSSI of the beacons is lower than
-	 * the RSSI of the data.
-	 */
-	if (band == NL80211_BAND_6GHZ)
-		link_rssi += 4;
-
-	rssi_idx = band == NL80211_BAND_2GHZ ? 0 : 1;
-
-	/* No valid RSSI - take the lowest grade */
-	if (!link_rssi)
-		link_rssi = rssi_to_grade_map[0].rssi[rssi_idx];
-
-	/* Get grade based on RSSI */
-	for (i = 0; i < ARRAY_SIZE(rssi_to_grade_map); i++) {
-		const struct iwl_mvm_rssi_to_grade *line =
-			&rssi_to_grade_map[i];
-
-		if (link_rssi > line->rssi[rssi_idx])
-			continue;
-		grade = line->grade;
-		break;
-	}
-
-	/* apply the channel load and puncturing factors */
-	grade = grade * iwl_mvm_get_chan_load_factor(link_conf) / SCALE_FACTOR;
-	grade = grade * iwl_mvm_get_puncturing_factor(link_conf) / SCALE_FACTOR;
-	return grade;
-}
-EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mvm_get_link_grade);
-
-static
-u8 iwl_mvm_set_link_selection_data(struct ieee80211_vif *vif,
-				   struct iwl_mvm_link_sel_data *data,
-				   unsigned long usable_links,
-				   u8 *best_link_idx)
-{
-	u8 n_data = 0;
-	u16 max_grade = 0;
-	unsigned long link_id;
-
-	/* TODO: don't select links that weren't discovered in the last scan */
-	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
-		struct ieee80211_bss_conf *link_conf =
-			link_conf_dereference_protected(vif, link_id);
-
-		if (WARN_ON_ONCE(!link_conf))
-			continue;
-
-		data[n_data].link_id = link_id;
-		data[n_data].chandef = &link_conf->chanreq.oper;
-		data[n_data].signal = link_conf->bss->signal / 100;
-		data[n_data].grade = iwl_mvm_get_link_grade(link_conf);
-
-		if (data[n_data].grade > max_grade) {
-			max_grade = data[n_data].grade;
-			*best_link_idx = n_data;
-		}
-		n_data++;
-	}
-
-	return n_data;
-}
-
-struct iwl_mvm_bw_to_rssi_threshs {
-	s8 low;
-	s8 high;
-};
-
-#define BW_TO_RSSI_THRESHOLDS(_bw)				\
-	[IWL_PHY_CHANNEL_MODE ## _bw] = {			\
-		.low = IWL_MVM_LOW_RSSI_THRESH_##_bw##MHZ,	\
-		.high = IWL_MVM_HIGH_RSSI_THRESH_##_bw##MHZ	\
-	}
-
-s8 iwl_mvm_get_esr_rssi_thresh(struct iwl_mvm *mvm,
-			       const struct cfg80211_chan_def *chandef,
-			       bool low)
-{
-	const struct iwl_mvm_bw_to_rssi_threshs bw_to_rssi_threshs_map[] = {
-		BW_TO_RSSI_THRESHOLDS(20),
-		BW_TO_RSSI_THRESHOLDS(40),
-		BW_TO_RSSI_THRESHOLDS(80),
-		BW_TO_RSSI_THRESHOLDS(160)
-		/* 320 MHz has the same thresholds as 20 MHz */
-	};
-	const struct iwl_mvm_bw_to_rssi_threshs *threshs;
-	u8 chan_width = iwl_mvm_get_channel_width(chandef);
-
-	if (WARN_ON(chandef->chan->band != NL80211_BAND_2GHZ &&
-		    chandef->chan->band != NL80211_BAND_5GHZ &&
-		    chandef->chan->band != NL80211_BAND_6GHZ))
-		return S8_MAX;
-
-	/* 6 GHz will always use 20 MHz thresholds, regardless of the BW */
-	if (chan_width == IWL_PHY_CHANNEL_MODE320)
-		chan_width = IWL_PHY_CHANNEL_MODE20;
-
-	threshs = &bw_to_rssi_threshs_map[chan_width];
-
-	return low ? threshs->low : threshs->high;
-}
-
-static u32
-iwl_mvm_esr_disallowed_with_link(struct iwl_mvm *mvm,
-				 struct ieee80211_vif *vif,
-				 const struct iwl_mvm_link_sel_data *link,
-				 bool primary)
-{
-	struct wiphy *wiphy = mvm->hw->wiphy;
-	struct ieee80211_bss_conf *conf;
-	enum iwl_mvm_esr_state ret = 0;
-	s8 thresh;
-
-	conf = wiphy_dereference(wiphy, vif->link_conf[link->link_id]);
-	if (WARN_ON_ONCE(!conf))
-		return false;
-
-	/* BT Coex effects eSR mode only if one of the links is on LB */
-	if (link->chandef->chan->band == NL80211_BAND_2GHZ &&
-	    (!iwl_mvm_bt_coex_calculate_esr_mode(mvm, vif, link->signal,
-						 primary)))
-		ret |= IWL_MVM_ESR_EXIT_COEX;
-
-	thresh = iwl_mvm_get_esr_rssi_thresh(mvm, link->chandef,
-					     false);
-
-	if (link->signal < thresh)
-		ret |= IWL_MVM_ESR_EXIT_LOW_RSSI;
-
-	if (conf->csa_active)
-		ret |= IWL_MVM_ESR_EXIT_CSA;
-
-	if (ret) {
-		IWL_DEBUG_INFO(mvm,
-			       "Link %d is not allowed for esr\n",
-			       link->link_id);
-		iwl_mvm_print_esr_state(mvm, ret);
-	}
-	return ret;
-}
-
-VISIBLE_IF_IWLWIFI_KUNIT
-bool iwl_mvm_mld_valid_link_pair(struct ieee80211_vif *vif,
-				 const struct iwl_mvm_link_sel_data *a,
-				 const struct iwl_mvm_link_sel_data *b)
-{
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mvm *mvm = mvmvif->mvm;
-	enum iwl_mvm_esr_state ret = 0;
-
-	/* Per-link considerations */
-	if (iwl_mvm_esr_disallowed_with_link(mvm, vif, a, true) ||
-	    iwl_mvm_esr_disallowed_with_link(mvm, vif, b, false))
-		return false;
-
-	if (a->chandef->chan->band == b->chandef->chan->band ||
-	    a->chandef->width != b->chandef->width)
-		ret |= IWL_MVM_ESR_EXIT_BANDWIDTH;
-
-	if (ret) {
-		IWL_DEBUG_INFO(mvm,
-			       "Links %d and %d are not a valid pair for EMLSR\n",
-			       a->link_id, b->link_id);
-		iwl_mvm_print_esr_state(mvm, ret);
-		return false;
-	}
-
-	return true;
-
-}
-EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mvm_mld_valid_link_pair);
-
-/*
- * Returns the combined eSR grade of two given links.
- * Returns 0 if eSR is not allowed with these 2 links.
- */
-static
-unsigned int iwl_mvm_get_esr_grade(struct ieee80211_vif *vif,
-				   const struct iwl_mvm_link_sel_data *a,
-				   const struct iwl_mvm_link_sel_data *b,
-				   u8 *primary_id)
-{
-	struct ieee80211_bss_conf *primary_conf;
-	struct wiphy *wiphy = ieee80211_vif_to_wdev(vif)->wiphy;
-	unsigned int primary_load;
-
-	lockdep_assert_wiphy(wiphy);
-
-	/* a is always primary, b is always secondary */
-	if (b->grade > a->grade)
-		swap(a, b);
-
-	*primary_id = a->link_id;
-
-	if (!iwl_mvm_mld_valid_link_pair(vif, a, b))
-		return 0;
-
-	primary_conf = wiphy_dereference(wiphy, vif->link_conf[*primary_id]);
-
-	if (WARN_ON_ONCE(!primary_conf))
-		return 0;
-
-	primary_load = iwl_mvm_get_chan_load(primary_conf);
-
-	return a->grade +
-		((b->grade * primary_load) / SCALE_FACTOR);
-}
-
-void iwl_mvm_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
-{
-	struct iwl_mvm_link_sel_data data[IEEE80211_MLD_MAX_NUM_LINKS];
-	struct iwl_mvm_link_sel_data *best_link;
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	u32 max_active_links = iwl_mvm_max_active_links(mvm, vif);
-	u16 usable_links = ieee80211_vif_usable_links(vif);
-	u8 best, primary_link, best_in_pair, n_data;
-	u16 max_esr_grade = 0, new_active_links;
-
-	lockdep_assert_wiphy(mvm->hw->wiphy);
-
-	if (!mvmvif->authorized || !ieee80211_vif_is_mld(vif))
-		return;
-
-	if (!IWL_MVM_AUTO_EML_ENABLE)
-		return;
-
-	/* The logic below is a simple version that doesn't suit more than 2
-	 * links
-	 */
-	WARN_ON_ONCE(max_active_links > 2);
-
-	n_data = iwl_mvm_set_link_selection_data(vif, data, usable_links,
-						 &best);
-
-	if (WARN(!n_data, "Couldn't find a valid grade for any link!\n"))
-		return;
-
-	best_link = &data[best];
-	primary_link = best_link->link_id;
-	new_active_links = BIT(best_link->link_id);
-
-	/* eSR is not supported/blocked, or only one usable link */
-	if (max_active_links == 1 || !iwl_mvm_vif_has_esr_cap(mvm, vif) ||
-	    mvmvif->esr_disable_reason || n_data == 1)
-		goto set_active;
-
-	for (u8 a = 0; a < n_data; a++)
-		for (u8 b = a + 1; b < n_data; b++) {
-			u16 esr_grade = iwl_mvm_get_esr_grade(vif, &data[a],
-							      &data[b],
-							      &best_in_pair);
-
-			if (esr_grade <= max_esr_grade)
-				continue;
-
-			max_esr_grade = esr_grade;
-			primary_link = best_in_pair;
-			new_active_links = BIT(data[a].link_id) |
-					   BIT(data[b].link_id);
-		}
-
-	/* No valid pair was found, go with the best link */
-	if (hweight16(new_active_links) <= 1)
-		goto set_active;
-
-	/* For equal grade - prefer EMLSR */
-	if (best_link->grade > max_esr_grade) {
-		primary_link = best_link->link_id;
-		new_active_links = BIT(best_link->link_id);
-	}
-set_active:
-	IWL_DEBUG_INFO(mvm, "Link selection result: 0x%x. Primary = %d\n",
-		       new_active_links, primary_link);
-	ieee80211_set_active_links_async(vif, new_active_links);
-	mvmvif->link_selection_res = new_active_links;
-	mvmvif->link_selection_primary = primary_link;
-}
-
 u8 iwl_mvm_get_primary_link(struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
@@ -856,266 +307,6 @@ u8 iwl_mvm_get_primary_link(struct ieee80211_vif *vif)
 	return __ffs(vif->active_links);
 }
 
-/*
- * For non-MLO/single link, this will return the deflink/single active link,
- * respectively
- */
-u8 iwl_mvm_get_other_link(struct ieee80211_vif *vif, u8 link_id)
-{
-	switch (hweight16(vif->active_links)) {
-	case 0:
-		return 0;
-	default:
-		WARN_ON(1);
-		fallthrough;
-	case 1:
-		return __ffs(vif->active_links);
-	case 2:
-		return __ffs(vif->active_links & ~BIT(link_id));
-	}
-}
-
-/* Reasons that can cause esr prevention */
-#define IWL_MVM_ESR_PREVENT_REASONS	IWL_MVM_ESR_EXIT_MISSED_BEACON
-#define IWL_MVM_PREVENT_ESR_TIMEOUT	(HZ * 400)
-#define IWL_MVM_ESR_PREVENT_SHORT	(HZ * 300)
-#define IWL_MVM_ESR_PREVENT_LONG	(HZ * 600)
-
-static bool iwl_mvm_check_esr_prevention(struct iwl_mvm *mvm,
-					 struct iwl_mvm_vif *mvmvif,
-					 enum iwl_mvm_esr_state reason)
-{
-	bool timeout_expired = time_after(jiffies,
-					  mvmvif->last_esr_exit.ts +
-					  IWL_MVM_PREVENT_ESR_TIMEOUT);
-	unsigned long delay;
-
-	lockdep_assert_held(&mvm->mutex);
-
-	/* Only handle reasons that can cause prevention */
-	if (!(reason & IWL_MVM_ESR_PREVENT_REASONS))
-		return false;
-
-	/*
-	 * Reset the counter if more than 400 seconds have passed between one
-	 * exit and the other, or if we exited due to a different reason.
-	 * Will also reset the counter after the long prevention is done.
-	 */
-	if (timeout_expired || mvmvif->last_esr_exit.reason != reason) {
-		mvmvif->exit_same_reason_count = 1;
-		return false;
-	}
-
-	mvmvif->exit_same_reason_count++;
-	if (WARN_ON(mvmvif->exit_same_reason_count < 2 ||
-		    mvmvif->exit_same_reason_count > 3))
-		return false;
-
-	mvmvif->esr_disable_reason |= IWL_MVM_ESR_BLOCKED_PREVENTION;
-
-	/*
-	 * For the second exit, use a short prevention, and for the third one,
-	 * use a long prevention.
-	 */
-	delay = mvmvif->exit_same_reason_count == 2 ?
-		IWL_MVM_ESR_PREVENT_SHORT :
-		IWL_MVM_ESR_PREVENT_LONG;
-
-	IWL_DEBUG_INFO(mvm,
-		       "Preventing EMLSR for %ld seconds due to %u exits with the reason = %s (0x%x)\n",
-		       delay / HZ, mvmvif->exit_same_reason_count,
-		       iwl_get_esr_state_string(reason), reason);
-
-	wiphy_delayed_work_queue(mvm->hw->wiphy,
-				 &mvmvif->prevent_esr_done_wk, delay);
-	return true;
-}
-
-#define IWL_MVM_TRIGGER_LINK_SEL_TIME (IWL_MVM_TRIGGER_LINK_SEL_TIME_SEC * HZ)
-
-/* API to exit eSR mode */
-void iwl_mvm_exit_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-		      enum iwl_mvm_esr_state reason,
-		      u8 link_to_keep)
-{
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	u16 new_active_links;
-	bool prevented;
-
-	lockdep_assert_held(&mvm->mutex);
-
-	if (!IWL_MVM_AUTO_EML_ENABLE)
-		return;
-
-	/* Nothing to do */
-	if (!mvmvif->esr_active)
-		return;
-
-	if (WARN_ON(!ieee80211_vif_is_mld(vif) || !mvmvif->authorized))
-		return;
-
-	if (WARN_ON(!(vif->active_links & BIT(link_to_keep))))
-		link_to_keep = __ffs(vif->active_links);
-
-	new_active_links = BIT(link_to_keep);
-	IWL_DEBUG_INFO(mvm,
-		       "Exiting EMLSR. reason = %s (0x%x). Current active links=0x%x, new active links = 0x%x\n",
-		       iwl_get_esr_state_string(reason), reason,
-		       vif->active_links, new_active_links);
-
-	ieee80211_set_active_links_async(vif, new_active_links);
-
-	/* Prevent EMLSR if needed */
-	prevented = iwl_mvm_check_esr_prevention(mvm, mvmvif, reason);
-
-	/* Remember why and when we exited EMLSR */
-	mvmvif->last_esr_exit.ts = jiffies;
-	mvmvif->last_esr_exit.reason = reason;
-
-	/*
-	 * If EMLSR is prevented now - don't try to get back to EMLSR.
-	 * If we exited due to a blocking event, we will try to get back to
-	 * EMLSR when the corresponding unblocking event will happen.
-	 */
-	if (prevented || reason & IWL_MVM_BLOCK_ESR_REASONS)
-		return;
-
-	/* If EMLSR is not blocked - try enabling it again in 30 seconds */
-	wiphy_delayed_work_queue(mvm->hw->wiphy,
-				 &mvmvif->mlo_int_scan_wk,
-				 round_jiffies_relative(IWL_MVM_TRIGGER_LINK_SEL_TIME));
-}
-
-void iwl_mvm_block_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-		       enum iwl_mvm_esr_state reason,
-		       u8 link_to_keep)
-{
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-
-	lockdep_assert_held(&mvm->mutex);
-
-	if (!IWL_MVM_AUTO_EML_ENABLE)
-		return;
-
-	/* This should be called only with disable reasons */
-	if (WARN_ON(!(reason & IWL_MVM_BLOCK_ESR_REASONS)))
-		return;
-
-	if (mvmvif->esr_disable_reason & reason)
-		return;
-
-	IWL_DEBUG_INFO(mvm,
-		       "Blocking EMLSR mode. reason = %s (0x%x)\n",
-		       iwl_get_esr_state_string(reason), reason);
-
-	mvmvif->esr_disable_reason |= reason;
-
-	iwl_mvm_print_esr_state(mvm, mvmvif->esr_disable_reason);
-
-	iwl_mvm_exit_esr(mvm, vif, reason, link_to_keep);
-}
-
-int iwl_mvm_block_esr_sync(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			   enum iwl_mvm_esr_state reason)
-{
-	int primary_link = iwl_mvm_get_primary_link(vif);
-	int ret;
-
-	if (!IWL_MVM_AUTO_EML_ENABLE || !ieee80211_vif_is_mld(vif))
-		return 0;
-
-	/* This should be called only with blocking reasons */
-	if (WARN_ON(!(reason & IWL_MVM_BLOCK_ESR_REASONS)))
-		return 0;
-
-	/* leave ESR immediately, not only async with iwl_mvm_block_esr() */
-	ret = ieee80211_set_active_links(vif, BIT(primary_link));
-	if (ret)
-		return ret;
-
-	mutex_lock(&mvm->mutex);
-	/* only additionally block for consistency and to avoid concurrency */
-	iwl_mvm_block_esr(mvm, vif, reason, primary_link);
-	mutex_unlock(&mvm->mutex);
-
-	return 0;
-}
-
-static void iwl_mvm_esr_unblocked(struct iwl_mvm *mvm,
-				  struct ieee80211_vif *vif)
-{
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	bool need_new_sel = time_after(jiffies, mvmvif->last_esr_exit.ts +
-						IWL_MVM_TRIGGER_LINK_SEL_TIME);
-
-	lockdep_assert_held(&mvm->mutex);
-
-	if (!ieee80211_vif_is_mld(vif) || !mvmvif->authorized ||
-	    mvmvif->esr_active)
-		return;
-
-	IWL_DEBUG_INFO(mvm, "EMLSR is unblocked\n");
-
-	/* If we exited due to an EXIT reason, and the exit was in less than
-	 * 30 seconds, then a MLO scan was scheduled already.
-	 */
-	if (!need_new_sel &&
-	    !(mvmvif->last_esr_exit.reason & IWL_MVM_BLOCK_ESR_REASONS)) {
-		IWL_DEBUG_INFO(mvm, "Wait for MLO scan\n");
-		return;
-	}
-
-	/*
-	 * If EMLSR was blocked for more than 30 seconds, or the last link
-	 * selection decided to not enter EMLSR, trigger a new scan.
-	 */
-	if (need_new_sel || hweight16(mvmvif->link_selection_res) < 2) {
-		IWL_DEBUG_INFO(mvm, "Trigger MLO scan\n");
-		wiphy_delayed_work_queue(mvm->hw->wiphy,
-					 &mvmvif->mlo_int_scan_wk, 0);
-	/*
-	 * If EMLSR was blocked for less than 30 seconds, and the last link
-	 * selection decided to use EMLSR, activate EMLSR using the previous
-	 * link selection result.
-	 */
-	} else {
-		IWL_DEBUG_INFO(mvm,
-			       "Use the latest link selection result: 0x%x\n",
-			       mvmvif->link_selection_res);
-		ieee80211_set_active_links_async(vif,
-						 mvmvif->link_selection_res);
-	}
-}
-
-void iwl_mvm_unblock_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			 enum iwl_mvm_esr_state reason)
-{
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-
-	lockdep_assert_held(&mvm->mutex);
-
-	if (!IWL_MVM_AUTO_EML_ENABLE)
-		return;
-
-	/* This should be called only with disable reasons */
-	if (WARN_ON(!(reason & IWL_MVM_BLOCK_ESR_REASONS)))
-		return;
-
-	/* No Change */
-	if (!(mvmvif->esr_disable_reason & reason))
-		return;
-
-	mvmvif->esr_disable_reason &= ~reason;
-
-	IWL_DEBUG_INFO(mvm,
-		       "Unblocking EMLSR mode. reason = %s (0x%x)\n",
-		       iwl_get_esr_state_string(reason), reason);
-	iwl_mvm_print_esr_state(mvm, mvmvif->esr_disable_reason);
-
-	if (!mvmvif->esr_disable_reason)
-		iwl_mvm_esr_unblocked(mvm, vif);
-}
-
 void iwl_mvm_init_link(struct iwl_mvm_vif_link_info *link)
 {
 	link->bcast_sta.sta_id = IWL_INVALID_STA;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 8805ab344895..7d84ac26949c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1586,13 +1586,11 @@ iwl_mvm_handle_missed_beacons_notif(struct iwl_mvm *mvm,
 	u32 id = le32_to_cpu(mb->link_id);
 	union iwl_dbg_tlv_tp_data tp_data = { .fw_pkt = pkt };
 	u32 mac_type;
-	int link_id;
 	u8 notif_ver = iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
 					       MISSED_BEACONS_NOTIFICATION,
 					       0);
 	u8 new_notif_ver = iwl_fw_lookup_notif_ver(mvm->fw, MAC_CONF_GROUP,
 						   MISSED_BEACONS_NOTIF, 0);
-	struct ieee80211_bss_conf *bss_conf;
 
 	/* If the firmware uses the new notification (from MAC_CONF_GROUP),
 	 * refer to that notification's version.
@@ -1617,8 +1615,6 @@ iwl_mvm_handle_missed_beacons_notif(struct iwl_mvm *mvm,
 	if (!vif)
 		return;
 
-	bss_conf = &vif->bss_conf;
-	link_id = bss_conf->link_id;
 	mac_type = iwl_mvm_get_mac_type(vif);
 
 	IWL_DEBUG_INFO(mvm, "missed beacon mac_type=%u,\n", mac_type);
@@ -1644,41 +1640,11 @@ iwl_mvm_handle_missed_beacons_notif(struct iwl_mvm *mvm,
 				 "missed_beacons:%d, missed_beacons_since_rx:%d\n",
 				 rx_missed_bcon, rx_missed_bcon_since_rx);
 		}
-	} else if (link_id >= 0 && hweight16(vif->active_links) > 1) {
-		u32 bss_param_ch_cnt_link_id =
-			bss_conf->bss_param_ch_cnt_link_id;
-		u32 scnd_lnk_bcn_lost = 0;
-
-		if (notif_ver >= 5 &&
-		    !IWL_FW_CHECK(mvm,
-				  le32_to_cpu(mb->other_link_id) == IWL_MVM_FW_LINK_ID_INVALID,
-				  "No data for other link id but we are in EMLSR active_links: 0x%x\n",
-				  vif->active_links))
-			scnd_lnk_bcn_lost =
-				le32_to_cpu(mb->consec_missed_beacons_other_link);
-
-		/* Exit EMLSR if we lost more than
-		 * IWL_MVM_MISSED_BEACONS_EXIT_ESR_THRESH beacons on boths links
-		 * OR more than IWL_MVM_BCN_LOSS_EXIT_ESR_THRESH on any link.
-		 * OR more than IWL_MVM_BCN_LOSS_EXIT_ESR_THRESH_BSS_PARAM_CHANGED
-		 * and the link's bss_param_ch_count has changed.
-		 */
-		if ((rx_missed_bcon >= IWL_MVM_BCN_LOSS_EXIT_ESR_THRESH_2_LINKS &&
-		     scnd_lnk_bcn_lost >= IWL_MVM_BCN_LOSS_EXIT_ESR_THRESH_2_LINKS) ||
-		    rx_missed_bcon >= IWL_MVM_BCN_LOSS_EXIT_ESR_THRESH ||
-		    (bss_param_ch_cnt_link_id != link_id &&
-		     rx_missed_bcon >= IWL_MVM_BCN_LOSS_EXIT_ESR_THRESH_BSS_PARAM_CHANGED))
-			iwl_mvm_exit_esr(mvm, vif,
-					 IWL_MVM_ESR_EXIT_MISSED_BEACON,
-					 iwl_mvm_get_primary_link(vif));
 	} else if (rx_missed_bcon_since_rx > IWL_MVM_MISSED_BEACONS_THRESHOLD) {
 		if (!iwl_mvm_has_new_tx_api(mvm))
 			ieee80211_beacon_loss(vif);
 		else
 			ieee80211_cqm_beacon_loss_notify(vif, GFP_ATOMIC);
-
-		/* try to switch links, no-op if we don't have MLO */
-		iwl_mvm_int_mlo_scan(mvm, vif);
 	}
 
 	iwl_dbg_tlv_time_point(&mvm->fwrt,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 4ad3d32683d8..44029ceb8f77 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1425,12 +1425,6 @@ void iwl_mvm_mac_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
-	/* Stop internal MLO scan, if running */
-	mutex_lock(&mvm->mutex);
-	iwl_mvm_scan_stop(mvm, IWL_MVM_SCAN_INT_MLO, false);
-	mutex_unlock(&mvm->mutex);
-
-	wiphy_work_cancel(mvm->hw->wiphy, &mvm->trig_link_selection_wk);
 	wiphy_work_flush(mvm->hw->wiphy, &mvm->async_handlers_wiphy_wk);
 	flush_work(&mvm->async_handlers_wk);
 	flush_work(&mvm->add_stream_wk);
@@ -1715,57 +1709,6 @@ static int iwl_mvm_alloc_bcast_mcast_sta(struct iwl_mvm *mvm,
 					IWL_STA_MULTICAST);
 }
 
-static void iwl_mvm_prevent_esr_done_wk(struct wiphy *wiphy,
-					struct wiphy_work *wk)
-{
-	struct iwl_mvm_vif *mvmvif =
-		container_of(wk, struct iwl_mvm_vif, prevent_esr_done_wk.work);
-	struct iwl_mvm *mvm = mvmvif->mvm;
-	struct ieee80211_vif *vif =
-		container_of((void *)mvmvif, struct ieee80211_vif, drv_priv);
-
-	guard(mvm)(mvm);
-	iwl_mvm_unblock_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_PREVENTION);
-}
-
-static void iwl_mvm_mlo_int_scan_wk(struct wiphy *wiphy, struct wiphy_work *wk)
-{
-	struct iwl_mvm_vif *mvmvif = container_of(wk, struct iwl_mvm_vif,
-						  mlo_int_scan_wk.work);
-	struct ieee80211_vif *vif =
-		container_of((void *)mvmvif, struct ieee80211_vif, drv_priv);
-
-	guard(mvm)(mvmvif->mvm);
-	iwl_mvm_int_mlo_scan(mvmvif->mvm, vif);
-}
-
-static void iwl_mvm_unblock_esr_tpt(struct wiphy *wiphy, struct wiphy_work *wk)
-{
-	struct iwl_mvm_vif *mvmvif =
-		container_of(wk, struct iwl_mvm_vif, unblock_esr_tpt_wk);
-	struct iwl_mvm *mvm = mvmvif->mvm;
-	struct ieee80211_vif *vif =
-		container_of((void *)mvmvif, struct ieee80211_vif, drv_priv);
-
-	guard(mvm)(mvm);
-	iwl_mvm_unblock_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_TPT);
-}
-
-static void iwl_mvm_unblock_esr_tmp_non_bss(struct wiphy *wiphy,
-					    struct wiphy_work *wk)
-{
-	struct iwl_mvm_vif *mvmvif =
-		container_of(wk, struct iwl_mvm_vif,
-			     unblock_esr_tmp_non_bss_wk.work);
-	struct iwl_mvm *mvm = mvmvif->mvm;
-	struct ieee80211_vif *vif =
-		container_of((void *)mvmvif, struct ieee80211_vif, drv_priv);
-
-	mutex_lock(&mvm->mutex);
-	iwl_mvm_unblock_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_TMP_NON_BSS);
-	mutex_unlock(&mvm->mutex);
-}
-
 void iwl_mvm_mac_init_mvmvif(struct iwl_mvm *mvm, struct iwl_mvm_vif *mvmvif)
 {
 	lockdep_assert_held(&mvm->mutex);
@@ -1777,18 +1720,6 @@ void iwl_mvm_mac_init_mvmvif(struct iwl_mvm *mvm, struct iwl_mvm_vif *mvmvif)
 
 	INIT_DELAYED_WORK(&mvmvif->csa_work,
 			  iwl_mvm_channel_switch_disconnect_wk);
-
-	wiphy_delayed_work_init(&mvmvif->prevent_esr_done_wk,
-				iwl_mvm_prevent_esr_done_wk);
-
-	wiphy_delayed_work_init(&mvmvif->mlo_int_scan_wk,
-				iwl_mvm_mlo_int_scan_wk);
-
-	wiphy_work_init(&mvmvif->unblock_esr_tpt_wk,
-			iwl_mvm_unblock_esr_tpt);
-
-	wiphy_delayed_work_init(&mvmvif->unblock_esr_tmp_non_bss_wk,
-				iwl_mvm_unblock_esr_tmp_non_bss);
 }
 
 static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
@@ -1926,16 +1857,6 @@ void iwl_mvm_prepare_mac_removal(struct iwl_mvm *mvm,
 		flush_work(&mvm->roc_done_wk);
 	}
 
-	wiphy_delayed_work_cancel(mvm->hw->wiphy,
-				  &mvmvif->prevent_esr_done_wk);
-
-	wiphy_delayed_work_cancel(mvm->hw->wiphy,
-				  &mvmvif->mlo_int_scan_wk);
-
-	wiphy_work_cancel(mvm->hw->wiphy, &mvmvif->unblock_esr_tpt_wk);
-	wiphy_delayed_work_cancel(mvm->hw->wiphy,
-				  &mvmvif->unblock_esr_tmp_non_bss_wk);
-
 	cancel_delayed_work_sync(&mvmvif->csa_work);
 }
 
@@ -4008,21 +3929,6 @@ iwl_mvm_sta_state_assoc_to_authorized(struct iwl_mvm *mvm,
 
 		callbacks->mac_ctxt_changed(mvm, vif, false);
 		iwl_mvm_mei_host_associated(mvm, vif, mvm_sta);
-
-		memset(&mvmvif->last_esr_exit, 0,
-		       sizeof(mvmvif->last_esr_exit));
-
-		iwl_mvm_block_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_TPT, 0);
-
-		/* Block until FW notif will arrive */
-		iwl_mvm_block_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_FW, 0);
-
-		/* when client is authorized (AP station marked as such),
-		 * try to enable the best link(s).
-		 */
-		if (vif->type == NL80211_IFTYPE_STATION &&
-		    !test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
-			iwl_mvm_select_links(mvm, vif);
 	}
 
 	mvm_sta->authorized = true;
@@ -4070,16 +3976,6 @@ iwl_mvm_sta_state_authorized_to_assoc(struct iwl_mvm *mvm,
 
 		/* disable beacon filtering */
 		iwl_mvm_disable_beacon_filter(mvm, vif);
-
-		wiphy_delayed_work_cancel(mvm->hw->wiphy,
-					  &mvmvif->prevent_esr_done_wk);
-
-		wiphy_delayed_work_cancel(mvm->hw->wiphy,
-					  &mvmvif->mlo_int_scan_wk);
-
-		wiphy_work_cancel(mvm->hw->wiphy, &mvmvif->unblock_esr_tpt_wk);
-		wiphy_delayed_work_cancel(mvm->hw->wiphy,
-					  &mvmvif->unblock_esr_tmp_non_bss_wk);
 	}
 
 	return 0;
@@ -4920,7 +4816,6 @@ int iwl_mvm_roc_common(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		       const struct iwl_mvm_roc_ops *ops)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-	struct ieee80211_vif *bss_vif = iwl_mvm_get_bss_vif(mvm);
 	u32 lmac_id;
 	int ret;
 
@@ -4933,13 +4828,6 @@ int iwl_mvm_roc_common(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	 */
 	flush_work(&mvm->roc_done_wk);
 
-	if (!IS_ERR_OR_NULL(bss_vif)) {
-		ret = iwl_mvm_block_esr_sync(mvm, bss_vif,
-					     IWL_MVM_ESR_BLOCKED_ROC);
-		if (ret)
-			return ret;
-	}
-
 	guard(mvm)(mvm);
 
 	switch (vif->type) {
@@ -5604,9 +5492,9 @@ static void iwl_mvm_csa_block_txqs(void *data, struct ieee80211_sta *sta)
 }
 
 #define IWL_MAX_CSA_BLOCK_TX 1500
-int iwl_mvm_pre_channel_switch(struct iwl_mvm *mvm,
-			       struct ieee80211_vif *vif,
-			       struct ieee80211_channel_switch *chsw)
+static int iwl_mvm_pre_channel_switch(struct iwl_mvm *mvm,
+				      struct ieee80211_vif *vif,
+				      struct ieee80211_channel_switch *chsw)
 {
 	struct ieee80211_vif *csa_vif;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
@@ -5724,9 +5612,9 @@ int iwl_mvm_pre_channel_switch(struct iwl_mvm *mvm,
 	return ret;
 }
 
-static int iwl_mvm_mac_pre_channel_switch(struct ieee80211_hw *hw,
-					  struct ieee80211_vif *vif,
-					  struct ieee80211_channel_switch *chsw)
+int iwl_mvm_mac_pre_channel_switch(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_channel_switch *chsw)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index bf24f8cb673e..b1dca76b7141 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -340,20 +340,6 @@ static int iwl_mvm_mld_assign_vif_chanctx(struct ieee80211_hw *hw,
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
-	/* update EMLSR mode */
-	if (ieee80211_vif_type_p2p(vif) != NL80211_IFTYPE_STATION) {
-		int ret;
-
-		ret = iwl_mvm_esr_non_bss_link(mvm, vif, link_conf->link_id,
-					       true);
-		/*
-		 * Don't activate this link if failed to exit EMLSR in
-		 * the BSS interface
-		 */
-		if (ret)
-			return ret;
-	}
-
 	guard(mvm)(mvm);
 	return __iwl_mvm_mld_assign_vif_chanctx(mvm, vif, link_conf, ctx, false);
 }
@@ -472,10 +458,6 @@ static void iwl_mvm_mld_unassign_vif_chanctx(struct ieee80211_hw *hw,
 		iwl_mvm_add_link(mvm, vif, link_conf);
 	}
 	mutex_unlock(&mvm->mutex);
-
-	/* update EMLSR mode */
-	if (ieee80211_vif_type_p2p(vif) != NL80211_IFTYPE_STATION)
-		iwl_mvm_esr_non_bss_link(mvm, vif, link_conf->link_id, false);
 }
 
 static void
@@ -684,25 +666,6 @@ static int iwl_mvm_mld_mac_sta_state(struct ieee80211_hw *hw,
 					    &callbacks);
 }
 
-static bool iwl_mvm_esr_bw_criteria(struct iwl_mvm *mvm,
-				    struct ieee80211_vif *vif,
-				    struct ieee80211_bss_conf *link_conf)
-{
-	struct ieee80211_bss_conf *other_link;
-	int link_id;
-
-	/* Exit EMLSR if links don't have equal bandwidths */
-	for_each_vif_active_link(vif, other_link, link_id) {
-		if (link_id == link_conf->link_id)
-			continue;
-		if (link_conf->chanreq.oper.width ==
-		    other_link->chanreq.oper.width)
-			return true;
-	}
-
-	return false;
-}
-
 static void
 iwl_mvm_mld_link_info_changed_station(struct iwl_mvm *mvm,
 				      struct ieee80211_vif *vif,
@@ -737,14 +700,6 @@ iwl_mvm_mld_link_info_changed_station(struct iwl_mvm *mvm,
 		link_changes |= LINK_CONTEXT_MODIFY_HE_PARAMS;
 	}
 
-	if ((changes & BSS_CHANGED_BANDWIDTH) &&
-	    ieee80211_vif_link_active(vif, link_conf->link_id) &&
-	    mvmvif->esr_active &&
-	    !iwl_mvm_esr_bw_criteria(mvm, vif, link_conf))
-		iwl_mvm_exit_esr(mvm, vif,
-				 IWL_MVM_ESR_EXIT_BANDWIDTH,
-				 iwl_mvm_get_primary_link(vif));
-
 	/* if associated, maybe puncturing changed - we'll check later */
 	if (vif->cfg.assoc)
 		link_changes |= LINK_CONTEXT_MODIFY_EHT_PARAMS;
@@ -879,11 +834,6 @@ static void iwl_mvm_mld_vif_cfg_changed_station(struct iwl_mvm *mvm,
 		if (ret)
 			IWL_ERR(mvm, "failed to update power mode\n");
 	}
-
-	if (changes & (BSS_CHANGED_MLD_VALID_LINKS | BSS_CHANGED_MLD_TTLM) &&
-	    ieee80211_vif_is_mld(vif) && mvmvif->authorized)
-		wiphy_delayed_work_queue(mvm->hw->wiphy,
-					 &mvmvif->mlo_int_scan_wk, 0);
 }
 
 static void
@@ -1239,91 +1189,6 @@ iwl_mvm_mld_can_neg_ttlm(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return NEG_TTLM_RES_ACCEPT;
 }
 
-static int
-iwl_mvm_mld_mac_pre_channel_switch(struct ieee80211_hw *hw,
-				   struct ieee80211_vif *vif,
-				   struct ieee80211_channel_switch *chsw)
-{
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-	int ret;
-
-	mutex_lock(&mvm->mutex);
-	if (mvmvif->esr_active) {
-		u8 primary = iwl_mvm_get_primary_link(vif);
-		int selected;
-
-		/* prefer primary unless quiet CSA on it */
-		if (chsw->link_id == primary && chsw->block_tx)
-			selected = iwl_mvm_get_other_link(vif, primary);
-		else
-			selected = primary;
-
-		/*
-		 * remembers to tell the firmware that this link can't tx
-		 * Note that this logic seems to be unrelated to esr, but it
-		 * really is needed only when esr is active. When we have a
-		 * single link, the firmware will handle all this on its own.
-		 * In multi-link scenarios, we can learn about the CSA from
-		 * another link and this logic is too complex for the firmware
-		 * to track.
-		 * Since we want to de-activate the link that got a CSA, we
-		 * need to tell the firmware not to send any frame on that link
-		 * as the firmware may not be aware that link is under a CSA
-		 * with mode=1 (no Tx allowed).
-		 */
-		if (chsw->block_tx && mvmvif->link[chsw->link_id])
-			mvmvif->link[chsw->link_id]->csa_block_tx = true;
-
-		iwl_mvm_exit_esr(mvm, vif, IWL_MVM_ESR_EXIT_CSA, selected);
-		mutex_unlock(&mvm->mutex);
-
-		/*
-		 * If we've not kept the link active that's doing the CSA
-		 * then we don't need to do anything else, just return.
-		 */
-		if (selected != chsw->link_id)
-			return 0;
-
-		mutex_lock(&mvm->mutex);
-	}
-
-	ret = iwl_mvm_pre_channel_switch(mvm, vif, chsw);
-	mutex_unlock(&mvm->mutex);
-
-	return ret;
-}
-
-#define IWL_MVM_MLD_UNBLOCK_ESR_NON_BSS_TIMEOUT (5 * HZ)
-
-static void iwl_mvm_mld_prep_add_interface(struct ieee80211_hw *hw,
-					   enum nl80211_iftype type)
-{
-	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-	struct ieee80211_vif *bss_vif = iwl_mvm_get_bss_vif(mvm);
-	struct iwl_mvm_vif *mvmvif;
-	int ret;
-
-	IWL_DEBUG_MAC80211(mvm, "prep_add_interface: type=%u\n",
-			   type);
-
-	if (IS_ERR_OR_NULL(bss_vif) ||
-	    !(type == NL80211_IFTYPE_AP ||
-	      type == NL80211_IFTYPE_P2P_GO ||
-	      type == NL80211_IFTYPE_P2P_CLIENT))
-		return;
-
-	mvmvif = iwl_mvm_vif_from_mac80211(bss_vif);
-	ret = iwl_mvm_block_esr_sync(mvm, bss_vif,
-				     IWL_MVM_ESR_BLOCKED_TMP_NON_BSS);
-	if (ret)
-		return;
-
-	wiphy_delayed_work_queue(mvmvif->mvm->hw->wiphy,
-				 &mvmvif->unblock_esr_tmp_non_bss_wk,
-				 IWL_MVM_MLD_UNBLOCK_ESR_NON_BSS_TIMEOUT);
-}
-
 const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.tx = iwl_mvm_mac_tx,
 	.wake_tx_queue = iwl_mvm_mac_wake_tx_queue,
@@ -1377,7 +1242,7 @@ const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.tx_last_beacon = iwl_mvm_tx_last_beacon,
 
 	.channel_switch = iwl_mvm_channel_switch,
-	.pre_channel_switch = iwl_mvm_mld_mac_pre_channel_switch,
+	.pre_channel_switch = iwl_mvm_mac_pre_channel_switch,
 	.post_channel_switch = iwl_mvm_post_channel_switch,
 	.abort_channel_switch = iwl_mvm_abort_channel_switch,
 	.channel_switch_rx_beacon = iwl_mvm_channel_switch_rx_beacon,
@@ -1418,5 +1283,4 @@ const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.change_sta_links = iwl_mvm_mld_change_sta_links,
 	.can_activate_links = iwl_mvm_mld_can_activate_links,
 	.can_neg_ttlm = iwl_mvm_mld_can_neg_ttlm,
-	.prep_add_interface = iwl_mvm_mld_prep_add_interface,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index e1010521c3ea..d9a2801636cf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -852,8 +852,6 @@ int iwl_mvm_mld_rm_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 		iwl_mvm_mld_free_sta_link(mvm, mvm_sta, mvm_link_sta, link_id);
 	}
-	kfree(mvm_sta->mpdu_counters);
-	mvm_sta->mpdu_counters = NULL;
 
 	return ret;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index fdaeefa305e1..4aeb27ee9149 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -347,68 +347,6 @@ struct iwl_mvm_vif_link_info {
 	u32 average_beacon_energy;
 };
 
-/**
- * enum iwl_mvm_esr_state - defines reasons for which the EMLSR is exited or
- * blocked.
- * The low 16 bits are used for blocking reasons, and the 16 higher bits
- * are used for exit reasons.
- * For the blocking reasons - use iwl_mvm_(un)block_esr(), and for the exit
- * reasons - use iwl_mvm_exit_esr().
- *
- * Note: new reasons shall be added to HANDLE_ESR_REASONS as well (for logs)
- *
- * @IWL_MVM_ESR_BLOCKED_PREVENTION: Prevent EMLSR to avoid entering and exiting
- *	in a loop.
- * @IWL_MVM_ESR_BLOCKED_WOWLAN: WOWLAN is preventing the enablement of EMLSR
- * @IWL_MVM_ESR_BLOCKED_TPT: block EMLSR when there is not enough traffic
- * @IWL_MVM_ESR_BLOCKED_FW: FW didn't recommended/forced exit from EMLSR
- * @IWL_MVM_ESR_BLOCKED_NON_BSS: An active non-BSS interface's link is
- *	preventing EMLSR
- * @IWL_MVM_ESR_BLOCKED_ROC: remain-on-channel is preventing EMLSR
- * @IWL_MVM_ESR_BLOCKED_TMP_NON_BSS: An expected active non-BSS interface's link
- *      is preventing EMLSR. This is a temporary blocking that is set when there
- *      is an indication that a non-BSS interface is to be added.
- * @IWL_MVM_ESR_EXIT_MISSED_BEACON: exited EMLSR due to missed beacons
- * @IWL_MVM_ESR_EXIT_LOW_RSSI: link is deactivated/not allowed for EMLSR
- *	due to low RSSI.
- * @IWL_MVM_ESR_EXIT_COEX: link is deactivated/not allowed for EMLSR
- *	due to BT Coex.
- * @IWL_MVM_ESR_EXIT_BANDWIDTH: Bandwidths of primary and secondry links
- *	preventing the enablement of EMLSR
- * @IWL_MVM_ESR_EXIT_CSA: CSA happened, so exit EMLSR
- * @IWL_MVM_ESR_EXIT_LINK_USAGE: Exit EMLSR due to low tpt on secondary link
- */
-enum iwl_mvm_esr_state {
-	IWL_MVM_ESR_BLOCKED_PREVENTION	= 0x1,
-	IWL_MVM_ESR_BLOCKED_WOWLAN	= 0x2,
-	IWL_MVM_ESR_BLOCKED_TPT		= 0x4,
-	IWL_MVM_ESR_BLOCKED_FW		= 0x8,
-	IWL_MVM_ESR_BLOCKED_NON_BSS	= 0x10,
-	IWL_MVM_ESR_BLOCKED_ROC		= 0x20,
-	IWL_MVM_ESR_BLOCKED_TMP_NON_BSS	= 0x40,
-	IWL_MVM_ESR_EXIT_MISSED_BEACON	= 0x10000,
-	IWL_MVM_ESR_EXIT_LOW_RSSI	= 0x20000,
-	IWL_MVM_ESR_EXIT_COEX		= 0x40000,
-	IWL_MVM_ESR_EXIT_BANDWIDTH	= 0x80000,
-	IWL_MVM_ESR_EXIT_CSA		= 0x100000,
-	IWL_MVM_ESR_EXIT_LINK_USAGE	= 0x200000,
-};
-
-#define IWL_MVM_BLOCK_ESR_REASONS 0xffff
-
-const char *iwl_get_esr_state_string(enum iwl_mvm_esr_state state);
-
-/**
- * struct iwl_mvm_esr_exit - details of the last exit from EMLSR mode.
- * @reason: The reason for the last exit from EMLSR.
- *	&iwl_mvm_prevent_esr_reasons. Will be 0 before exiting EMLSR.
- * @ts: the time stamp of the last time we existed EMLSR.
- */
-struct iwl_mvm_esr_exit {
-	unsigned long ts;
-	enum iwl_mvm_esr_state reason;
-};
-
 /**
  * struct iwl_mvm_vif - data per Virtual Interface, it is a MAC context
  * @mvm: pointer back to the mvm struct
@@ -443,7 +381,6 @@ struct iwl_mvm_esr_exit {
  * @deflink: default link data for use in non-MLO
  * @link: link data for each link in MLO
  * @esr_active: indicates eSR mode is active
- * @esr_disable_reason: a bitmap of &enum iwl_mvm_esr_state
  * @pm_enabled: indicates powersave is enabled
  * @link_selection_res: bitmap of active links as it was decided in the last
  *	link selection. Valid only for a MLO vif after assoc. 0 if there wasn't
@@ -451,15 +388,6 @@ struct iwl_mvm_esr_exit {
  * @link_selection_primary: primary link selected by link selection
  * @primary_link: primary link in eSR. Valid only for an associated MLD vif,
  *	and in eSR mode. Valid only for a STA.
- * @last_esr_exit: Details of the last exit from EMLSR.
- * @exit_same_reason_count: The number of times we exited due to the specified
- *	@last_esr_exit::reason, only counting exits due to
- *	&IWL_MVM_ESR_PREVENT_REASONS.
- * @prevent_esr_done_wk: work that should be done when esr prevention ends.
- * @mlo_int_scan_wk: work for the internal MLO scan.
- * @unblock_esr_tpt_wk: work for unblocking EMLSR when tpt is high enough.
- * @unblock_esr_tmp_non_bss_wk: work for removing the
- *      IWL_MVM_ESR_BLOCKED_TMP_NON_BSS blocking for EMLSR.
  * @roc_activity: currently running ROC activity for this vif (or
  *	ROC_NUM_ACTIVITIES if no activity is running).
  * @session_prot_connection_loss: the connection was lost due to session
@@ -515,7 +443,6 @@ struct iwl_mvm_vif {
 	u8 authorized:1;
 	bool ps_disabled;
 
-	u32 esr_disable_reason;
 	u32 ap_beacon_time;
 	bool bf_enabled;
 	bool ba_enabled;
@@ -591,12 +518,6 @@ struct iwl_mvm_vif {
 	u16 link_selection_res;
 	u8 link_selection_primary;
 	u8 primary_link;
-	struct iwl_mvm_esr_exit last_esr_exit;
-	u8 exit_same_reason_count;
-	struct wiphy_delayed_work prevent_esr_done_wk;
-	struct wiphy_delayed_work mlo_int_scan_wk;
-	struct wiphy_work unblock_esr_tpt_wk;
-	struct wiphy_delayed_work unblock_esr_tmp_non_bss_wk;
 
 	struct iwl_mvm_vif_link_info deflink;
 	struct iwl_mvm_vif_link_info *link[IEEE80211_MLD_MAX_NUM_LINKS];
@@ -622,7 +543,6 @@ enum iwl_scan_status {
 	IWL_MVM_SCAN_REGULAR		= BIT(0),
 	IWL_MVM_SCAN_SCHED		= BIT(1),
 	IWL_MVM_SCAN_NETDETECT		= BIT(2),
-	IWL_MVM_SCAN_INT_MLO		= BIT(3),
 
 	IWL_MVM_SCAN_STOPPING_REGULAR	= BIT(8),
 	IWL_MVM_SCAN_STOPPING_SCHED	= BIT(9),
@@ -635,8 +555,6 @@ enum iwl_scan_status {
 					  IWL_MVM_SCAN_STOPPING_SCHED,
 	IWL_MVM_SCAN_NETDETECT_MASK	= IWL_MVM_SCAN_NETDETECT |
 					  IWL_MVM_SCAN_STOPPING_NETDETECT,
-	IWL_MVM_SCAN_INT_MLO_MASK       = IWL_MVM_SCAN_INT_MLO |
-					  IWL_MVM_SCAN_STOPPING_INT_MLO,
 
 	IWL_MVM_SCAN_STOPPING_MASK	= 0xff << IWL_MVM_SCAN_STOPPING_SHIFT,
 	IWL_MVM_SCAN_MASK		= 0xff,
@@ -1017,8 +935,6 @@ struct iwl_mvm {
 	/* For async rx handlers that require the wiphy lock */
 	struct wiphy_work async_handlers_wiphy_wk;
 
-	struct wiphy_work trig_link_selection_wk;
-
 	struct work_struct roc_done_wk;
 
 	unsigned long init_status;
@@ -1212,11 +1128,7 @@ struct iwl_mvm {
 
 	wait_queue_head_t rx_sync_waitq;
 
-	/* BT-Coex - only one of those will be used */
-	union {
-		struct iwl_bt_coex_prof_old_notif last_bt_notif;
-		struct iwl_bt_coex_profile_notif last_bt_wifi_loss;
-	};
+	struct iwl_bt_coex_prof_old_notif last_bt_notif;
 	struct iwl_bt_coex_ci_cmd last_bt_ci_cmd;
 
 	u8 bt_tx_prio;
@@ -2099,9 +2011,7 @@ int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 int iwl_mvm_disable_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			 struct ieee80211_bss_conf *link_conf);
 
-void iwl_mvm_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 u8 iwl_mvm_get_primary_link(struct ieee80211_vif *vif);
-u8 iwl_mvm_get_other_link(struct ieee80211_vif *vif, u8 link_id);
 
 struct iwl_mvm_link_sel_data {
 	u8 link_id;
@@ -2111,10 +2021,6 @@ struct iwl_mvm_link_sel_data {
 };
 
 #if IS_ENABLED(CONFIG_IWLWIFI_KUNIT_TESTS)
-unsigned int iwl_mvm_get_link_grade(struct ieee80211_bss_conf *link_conf);
-bool iwl_mvm_mld_valid_link_pair(struct ieee80211_vif *vif,
-				 const struct iwl_mvm_link_sel_data *a,
-				 const struct iwl_mvm_link_sel_data *b);
 
 s8 iwl_mvm_average_dbm_values(const struct iwl_umac_scan_channel_survey_notif *notif);
 
@@ -2201,7 +2107,6 @@ int iwl_mvm_scan_stop(struct iwl_mvm *mvm, int type, bool notify);
 int iwl_mvm_max_scan_ie_len(struct iwl_mvm *mvm);
 void iwl_mvm_report_scan_aborted(struct iwl_mvm *mvm);
 void iwl_mvm_scan_timeout_wk(struct work_struct *work);
-int iwl_mvm_int_mlo_scan(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 void iwl_mvm_rx_channel_survey_notif(struct iwl_mvm *mvm,
 				     struct iwl_rx_cmd_buffer *rxb);
 
@@ -2327,8 +2232,6 @@ int iwl_mvm_send_proto_offload(struct iwl_mvm *mvm,
 int iwl_mvm_send_bt_init_conf(struct iwl_mvm *mvm);
 void iwl_mvm_rx_bt_coex_old_notif(struct iwl_mvm *mvm,
 				  struct iwl_rx_cmd_buffer *rxb);
-void iwl_mvm_rx_bt_coex_notif(struct iwl_mvm *mvm,
-			      struct iwl_rx_cmd_buffer *rxb);
 void iwl_mvm_bt_rssi_event(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			   enum ieee80211_rssi_event_data);
 void iwl_mvm_bt_coex_vif_change(struct iwl_mvm *mvm);
@@ -2929,9 +2832,10 @@ void iwl_mvm_change_chanctx(struct ieee80211_hw *hw,
 int iwl_mvm_tx_last_beacon(struct ieee80211_hw *hw);
 void iwl_mvm_channel_switch(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			    struct ieee80211_channel_switch *chsw);
-int iwl_mvm_pre_channel_switch(struct iwl_mvm *mvm,
-			       struct ieee80211_vif *vif,
-			       struct ieee80211_channel_switch *chsw);
+int iwl_mvm_mac_pre_channel_switch(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_channel_switch *chsw);
+
 void iwl_mvm_abort_channel_switch(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_bss_conf *link_conf);
@@ -2988,30 +2892,6 @@ int iwl_mvm_roc_add_cmd(struct iwl_mvm *mvm,
 
 /* EMLSR */
 bool iwl_mvm_vif_has_esr_cap(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
-void iwl_mvm_block_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-		       enum iwl_mvm_esr_state reason,
-		       u8 link_to_keep);
-int iwl_mvm_block_esr_sync(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			   enum iwl_mvm_esr_state reason);
-void iwl_mvm_unblock_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			 enum iwl_mvm_esr_state reason);
-void iwl_mvm_exit_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-		      enum iwl_mvm_esr_state reason,
-		      u8 link_to_keep);
-s8 iwl_mvm_get_esr_rssi_thresh(struct iwl_mvm *mvm,
-			       const struct cfg80211_chan_def *chandef,
-			       bool low);
-void iwl_mvm_bt_coex_update_link_esr(struct iwl_mvm *mvm,
-				     struct ieee80211_vif *vif,
-				     int link_id);
-bool
-iwl_mvm_bt_coex_calculate_esr_mode(struct iwl_mvm *mvm,
-				   struct ieee80211_vif *vif,
-				   s32 link_rssi,
-				   bool primary);
-int iwl_mvm_esr_non_bss_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			     unsigned int link_id, bool active);
-
 void
 iwl_mvm_send_ap_tx_power_constraint_cmd(struct iwl_mvm *mvm,
 					struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index c7f08cde1f72..5ebd046371f5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -143,24 +143,6 @@ static void iwl_mvm_nic_config(struct iwl_op_mode *op_mode)
 				       ~APMG_PS_CTRL_EARLY_PWR_OFF_RESET_DIS);
 }
 
-static void iwl_mvm_rx_esr_mode_notif(struct iwl_mvm *mvm,
-				      struct iwl_rx_cmd_buffer *rxb)
-{
-	struct iwl_rx_packet *pkt = rxb_addr(rxb);
-	struct iwl_esr_mode_notif *notif = (void *)pkt->data;
-	struct ieee80211_vif *vif = iwl_mvm_get_bss_vif(mvm);
-
-	/* FW recommendations is only for entering EMLSR */
-	if (IS_ERR_OR_NULL(vif) || iwl_mvm_vif_from_mac80211(vif)->esr_active)
-		return;
-
-	if (le32_to_cpu(notif->action) == ESR_RECOMMEND_ENTER)
-		iwl_mvm_unblock_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_FW);
-	else
-		iwl_mvm_block_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_FW,
-				  iwl_mvm_get_primary_link(vif));
-}
-
 static void iwl_mvm_rx_monitor_notif(struct iwl_mvm *mvm,
 				     struct iwl_rx_cmd_buffer *rxb)
 {
@@ -345,9 +327,6 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 	RX_HANDLER(BT_PROFILE_NOTIFICATION, iwl_mvm_rx_bt_coex_old_notif,
 		   RX_HANDLER_ASYNC_LOCKED_WIPHY,
 		   struct iwl_bt_coex_prof_old_notif),
-	RX_HANDLER_GRP(BT_COEX_GROUP, PROFILE_NOTIF, iwl_mvm_rx_bt_coex_notif,
-		       RX_HANDLER_ASYNC_LOCKED_WIPHY,
-		       struct iwl_bt_coex_profile_notif),
 	RX_HANDLER_NO_SIZE(BEACON_NOTIFICATION, iwl_mvm_rx_beacon_notif,
 			   RX_HANDLER_ASYNC_LOCKED),
 	RX_HANDLER_NO_SIZE(STATISTICS_NOTIFICATION, iwl_mvm_rx_statistics,
@@ -457,11 +436,6 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 		       RX_HANDLER_ASYNC_UNLOCKED,
 		       struct iwl_channel_switch_error_notif),
 
-	RX_HANDLER_GRP(DATA_PATH_GROUP, ESR_MODE_NOTIF,
-		       iwl_mvm_rx_esr_mode_notif,
-		       RX_HANDLER_ASYNC_LOCKED_WIPHY,
-		       struct iwl_esr_mode_notif),
-
 	RX_HANDLER_GRP(DATA_PATH_GROUP, MONITOR_NOTIF,
 		       iwl_mvm_rx_monitor_notif, RX_HANDLER_ASYNC_LOCKED,
 		       struct iwl_datapath_monitor_notif),
@@ -661,7 +635,6 @@ static const struct iwl_hcmd_names iwl_mvm_data_path_names[] = {
 	HCMD_NAME(CHEST_COLLECTOR_FILTER_CONFIG_CMD),
 	HCMD_NAME(SCD_QUEUE_CONFIG_CMD),
 	HCMD_NAME(SEC_KEY_CMD),
-	HCMD_NAME(ESR_MODE_NOTIF),
 	HCMD_NAME(MONITOR_NOTIF),
 	HCMD_NAME(THERMAL_DUAL_CHAIN_REQUEST),
 	HCMD_NAME(BEACON_FILTER_IN_NOTIF),
@@ -1220,29 +1193,6 @@ static const struct iwl_mei_ops mei_ops = {
 	.nic_stolen = iwl_mvm_mei_nic_stolen,
 };
 
-static void iwl_mvm_find_link_selection_vif(void *_data, u8 *mac,
-					    struct ieee80211_vif *vif)
-{
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-
-	if (ieee80211_vif_is_mld(vif) && mvmvif->authorized)
-		iwl_mvm_select_links(mvmvif->mvm, vif);
-}
-
-static void iwl_mvm_trig_link_selection(struct wiphy *wiphy,
-					struct wiphy_work *wk)
-{
-	struct iwl_mvm *mvm =
-		container_of(wk, struct iwl_mvm, trig_link_selection_wk);
-
-	mutex_lock(&mvm->mutex);
-	ieee80211_iterate_active_interfaces(mvm->hw,
-					    IEEE80211_IFACE_ITER_NORMAL,
-					    iwl_mvm_find_link_selection_vif,
-					    NULL);
-	mutex_unlock(&mvm->mutex);
-}
-
 static struct iwl_op_mode *
 iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_rf_cfg *cfg,
 		      const struct iwl_fw *fw, struct dentry *dbgfs_dir)
@@ -1411,9 +1361,6 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_rf_cfg *cfg,
 	wiphy_work_init(&mvm->async_handlers_wiphy_wk,
 			iwl_mvm_async_handlers_wiphy_wk);
 
-	wiphy_work_init(&mvm->trig_link_selection_wk,
-			iwl_mvm_trig_link_selection);
-
 	init_waitqueue_head(&mvm->rx_sync_waitq);
 
 	mvm->queue_sync_state = 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 8fae0d41b119..8c1bb3a7ffca 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -563,7 +563,6 @@ static void iwl_mvm_update_link_sig(struct ieee80211_vif *vif, int sig,
 	int thold = bss_conf->cqm_rssi_thold;
 	int hyst = bss_conf->cqm_rssi_hyst;
 	int last_event;
-	s8 exit_esr_thresh;
 
 	if (sig == 0) {
 		IWL_DEBUG_RX(mvm, "RSSI is 0 - skip signal based decision\n");
@@ -619,27 +618,6 @@ static void iwl_mvm_update_link_sig(struct ieee80211_vif *vif, int sig,
 			sig,
 			GFP_KERNEL);
 	}
-
-	/* ESR recalculation */
-	if (!vif->cfg.assoc || !ieee80211_vif_is_mld(vif))
-		return;
-
-	/* We're not in EMLSR and our signal is bad, try to switch link maybe */
-	if (sig < IWL_MVM_LOW_RSSI_MLO_SCAN_THRESH && !mvmvif->esr_active) {
-		iwl_mvm_int_mlo_scan(mvm, vif);
-		return;
-	}
-
-	/* We are in EMLSR, check if we need to exit */
-	exit_esr_thresh =
-		iwl_mvm_get_esr_rssi_thresh(mvm,
-					    &bss_conf->chanreq.oper,
-					    true);
-
-	if (sig < exit_esr_thresh)
-		iwl_mvm_exit_esr(mvm, vif, IWL_MVM_ESR_EXIT_LOW_RSSI,
-				 iwl_mvm_get_other_link(vif,
-							bss_conf->link_id));
 }
 
 static void iwl_mvm_stat_iterator(void *_data, u8 *mac,
@@ -914,10 +892,6 @@ iwl_mvm_stat_iterator_all_links(struct iwl_mvm *mvm,
 		link_info->beacon_stats.avg_signal =
 			-le32_to_cpu(link_stats->beacon_average_energy);
 
-		if (link_info->phy_ctxt &&
-		    link_info->phy_ctxt->channel->band == NL80211_BAND_2GHZ)
-			iwl_mvm_bt_coex_update_link_esr(mvm, vif, link_id);
-
 		/* make sure that beacon statistics don't go backwards with TCM
 		 * request to clear statistics
 		 */
@@ -956,111 +930,6 @@ iwl_mvm_stat_iterator_all_links(struct iwl_mvm *mvm,
 	}
 }
 
-#define SEC_LINK_MIN_PERC 10
-#define SEC_LINK_MIN_TX 3000
-#define SEC_LINK_MIN_RX 400
-
-/* Accept a ~20% short window to avoid issues due to jitter */
-#define IWL_MVM_TPT_MIN_COUNT_WINDOW (IWL_MVM_TPT_COUNT_WINDOW_SEC * HZ * 4 / 5)
-
-static void iwl_mvm_update_esr_mode_tpt(struct iwl_mvm *mvm)
-{
-	struct ieee80211_vif *bss_vif = iwl_mvm_get_bss_vif(mvm);
-	struct iwl_mvm_vif *mvmvif;
-	struct iwl_mvm_sta *mvmsta;
-	unsigned long total_tx = 0, total_rx = 0;
-	unsigned long sec_link_tx = 0, sec_link_rx = 0;
-	u8 sec_link_tx_perc, sec_link_rx_perc;
-	u8 sec_link;
-	bool skip = false;
-
-	lockdep_assert_held(&mvm->mutex);
-
-	if (IS_ERR_OR_NULL(bss_vif))
-		return;
-
-	mvmvif = iwl_mvm_vif_from_mac80211(bss_vif);
-
-	if (!mvmvif->esr_active || !mvmvif->ap_sta)
-		return;
-
-	mvmsta = iwl_mvm_sta_from_mac80211(mvmvif->ap_sta);
-	/* We only count for the AP sta in a MLO connection */
-	if (!mvmsta->mpdu_counters)
-		return;
-
-	/* Get the FW ID of the secondary link */
-	sec_link = iwl_mvm_get_other_link(bss_vif,
-					  iwl_mvm_get_primary_link(bss_vif));
-	if (WARN_ON(!mvmvif->link[sec_link]))
-		return;
-	sec_link = mvmvif->link[sec_link]->fw_link_id;
-
-	/* Sum up RX and TX MPDUs from the different queues/links */
-	for (int q = 0; q < mvm->trans->info.num_rxqs; q++) {
-		spin_lock_bh(&mvmsta->mpdu_counters[q].lock);
-
-		/* The link IDs that doesn't exist will contain 0 */
-		for (int link = 0; link < IWL_FW_MAX_LINK_ID; link++) {
-			total_tx += mvmsta->mpdu_counters[q].per_link[link].tx;
-			total_rx += mvmsta->mpdu_counters[q].per_link[link].rx;
-		}
-
-		sec_link_tx += mvmsta->mpdu_counters[q].per_link[sec_link].tx;
-		sec_link_rx += mvmsta->mpdu_counters[q].per_link[sec_link].rx;
-
-		/*
-		 * In EMLSR we have statistics every 5 seconds, so we can reset
-		 * the counters upon every statistics notification.
-		 * The FW sends the notification regularly, but it will be
-		 * misaligned at the start. Skipping the measurement if it is
-		 * short will synchronize us.
-		 */
-		if (jiffies - mvmsta->mpdu_counters[q].window_start <
-		    IWL_MVM_TPT_MIN_COUNT_WINDOW)
-			skip = true;
-		mvmsta->mpdu_counters[q].window_start = jiffies;
-		memset(mvmsta->mpdu_counters[q].per_link, 0,
-		       sizeof(mvmsta->mpdu_counters[q].per_link));
-
-		spin_unlock_bh(&mvmsta->mpdu_counters[q].lock);
-	}
-
-	if (skip) {
-		IWL_DEBUG_INFO(mvm, "MPDU statistics window was short\n");
-		return;
-	}
-
-	IWL_DEBUG_INFO(mvm, "total Tx MPDUs: %ld. total Rx MPDUs: %ld\n",
-		       total_tx, total_rx);
-
-	/* If we don't have enough MPDUs - exit EMLSR */
-	if (total_tx < IWL_MVM_ENTER_ESR_TPT_THRESH &&
-	    total_rx < IWL_MVM_ENTER_ESR_TPT_THRESH) {
-		iwl_mvm_block_esr(mvm, bss_vif, IWL_MVM_ESR_BLOCKED_TPT,
-				  iwl_mvm_get_primary_link(bss_vif));
-		return;
-	}
-
-	IWL_DEBUG_INFO(mvm, "Secondary Link %d: Tx MPDUs: %ld. Rx MPDUs: %ld\n",
-		       sec_link, sec_link_tx, sec_link_rx);
-
-	/* Calculate the percentage of the secondary link TX/RX */
-	sec_link_tx_perc = total_tx ? sec_link_tx * 100 / total_tx : 0;
-	sec_link_rx_perc = total_rx ? sec_link_rx * 100 / total_rx : 0;
-
-	/*
-	 * The TX/RX percentage is checked only if it exceeds the required
-	 * minimum. In addition, RX is checked only if the TX check failed.
-	 */
-	if ((total_tx > SEC_LINK_MIN_TX &&
-	     sec_link_tx_perc < SEC_LINK_MIN_PERC) ||
-	    (total_rx > SEC_LINK_MIN_RX &&
-	     sec_link_rx_perc < SEC_LINK_MIN_PERC))
-		iwl_mvm_exit_esr(mvm, bss_vif, IWL_MVM_ESR_EXIT_LINK_USAGE,
-				 iwl_mvm_get_primary_link(bss_vif));
-}
-
 void iwl_mvm_handle_rx_system_oper_stats(struct iwl_mvm *mvm,
 					 struct iwl_rx_cmd_buffer *rxb)
 {
@@ -1088,8 +957,6 @@ void iwl_mvm_handle_rx_system_oper_stats(struct iwl_mvm *mvm,
 	ieee80211_iterate_stations_atomic(mvm->hw, iwl_mvm_stats_energy_iter,
 					  average_energy);
 	iwl_mvm_handle_per_phy_stats(mvm, stats->per_phy);
-
-	iwl_mvm_update_esr_mode_tpt(mvm);
 }
 
 void iwl_mvm_handle_rx_system_oper_part1_stats(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 62e76a79f621..d8be2f6124c1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -2099,7 +2099,6 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	struct ieee80211_sta *sta = NULL;
 	struct sk_buff *skb;
 	u8 crypt_len = 0;
-	u8 sta_id = le32_get_bits(desc->status, IWL_RX_MPDU_STATUS_STA_ID);
 	size_t desc_size;
 	struct iwl_mvm_rx_phy_data phy_data = {};
 	u32 format;
@@ -2246,6 +2245,9 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	rcu_read_lock();
 
 	if (desc->status & cpu_to_le32(IWL_RX_MPDU_STATUS_SRC_STA_FOUND)) {
+		u8 sta_id = le32_get_bits(desc->status,
+					  IWL_RX_MPDU_STATUS_STA_ID);
+
 		if (!WARN_ON_ONCE(sta_id >= mvm->fw->ucode_capa.num_stations)) {
 			struct ieee80211_link_sta *link_sta;
 
@@ -2373,16 +2375,6 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 
 			iwl_mvm_agg_rx_received(mvm, reorder_data, baid);
 		}
-
-		if (ieee80211_is_data(hdr->frame_control)) {
-			u8 sub_frame_idx = desc->amsdu_info &
-				IWL_RX_MPDU_AMSDU_SUBFRAME_IDX_MASK;
-
-			/* 0 means not an A-MSDU, and 1 means a new A-MSDU */
-			if (!sub_frame_idx || sub_frame_idx == 1)
-				iwl_mvm_count_mpdu(mvmsta, sta_id, 1, false,
-						   queue);
-		}
 	}
 
 	/* management stuff on default queue */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 9ce1ce0dab34..b588f1dcf20d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1392,8 +1392,6 @@ static u32 iwl_mvm_scan_umac_ooc_priority(int type)
 {
 	if (type == IWL_MVM_SCAN_REGULAR)
 		return IWL_SCAN_PRIORITY_EXT_6;
-	if (type == IWL_MVM_SCAN_INT_MLO)
-		return IWL_SCAN_PRIORITY_EXT_4;
 
 	return IWL_SCAN_PRIORITY_EXT_2;
 }
@@ -3220,7 +3218,6 @@ void iwl_mvm_rx_umac_scan_complete_notif(struct iwl_mvm *mvm,
 	struct iwl_umac_scan_complete *notif = (void *)pkt->data;
 	u32 uid = __le32_to_cpu(notif->uid);
 	bool aborted = (notif->status == IWL_SCAN_OFFLOAD_ABORTED);
-	bool select_links = false;
 
 	mvm->mei_scan_filter.is_mei_limited_scan = false;
 
@@ -3267,13 +3264,6 @@ void iwl_mvm_rx_umac_scan_complete_notif(struct iwl_mvm *mvm,
 	} else if (mvm->scan_uid_status[uid] == IWL_MVM_SCAN_SCHED) {
 		ieee80211_sched_scan_stopped(mvm->hw);
 		mvm->sched_scan_pass_all = SCHED_SCAN_PASS_ALL_DISABLED;
-	} else if (mvm->scan_uid_status[uid] == IWL_MVM_SCAN_INT_MLO) {
-		IWL_DEBUG_SCAN(mvm, "Internal MLO scan completed\n");
-		/*
-		 * Other scan types won't necessarily scan for the MLD links channels.
-		 * Therefore, only select links after successful internal scan.
-		 */
-		select_links = notif->status == IWL_SCAN_OFFLOAD_COMPLETED;
 	}
 
 	mvm->scan_status &= ~mvm->scan_uid_status[uid];
@@ -3286,9 +3276,6 @@ void iwl_mvm_rx_umac_scan_complete_notif(struct iwl_mvm *mvm,
 		mvm->last_ebs_successful = false;
 
 	mvm->scan_uid_status[uid] = 0;
-
-	if (select_links)
-		wiphy_work_queue(mvm->hw->wiphy, &mvm->trig_link_selection_wk);
 }
 
 void iwl_mvm_rx_umac_scan_iter_complete_notif(struct iwl_mvm *mvm,
@@ -3483,11 +3470,6 @@ void iwl_mvm_report_scan_aborted(struct iwl_mvm *mvm)
 			mvm->sched_scan_pass_all = SCHED_SCAN_PASS_ALL_DISABLED;
 			mvm->scan_uid_status[uid] = 0;
 		}
-		uid = iwl_mvm_scan_uid_by_status(mvm, IWL_MVM_SCAN_INT_MLO);
-		if (uid >= 0) {
-			IWL_DEBUG_SCAN(mvm, "Internal MLO scan aborted\n");
-			mvm->scan_uid_status[uid] = 0;
-		}
 
 		uid = iwl_mvm_scan_uid_by_status(mvm,
 						 IWL_MVM_SCAN_STOPPING_REGULAR);
@@ -3583,89 +3565,6 @@ int iwl_mvm_scan_stop(struct iwl_mvm *mvm, int type, bool notify)
 	return ret;
 }
 
-static int iwl_mvm_int_mlo_scan_start(struct iwl_mvm *mvm,
-				      struct ieee80211_vif *vif,
-				      struct ieee80211_channel **channels,
-				      size_t n_channels)
-{
-	struct cfg80211_scan_request *req = NULL;
-	struct ieee80211_scan_ies ies = {};
-	size_t size, i;
-	int ret;
-
-	lockdep_assert_held(&mvm->mutex);
-
-	IWL_DEBUG_SCAN(mvm, "Starting Internal MLO scan: n_channels=%zu\n",
-		       n_channels);
-
-	if (!vif->cfg.assoc || !ieee80211_vif_is_mld(vif) ||
-	    hweight16(vif->valid_links) == 1)
-		return -EINVAL;
-
-	size = struct_size(req, channels, n_channels);
-	req = kzalloc(size, GFP_KERNEL);
-	if (!req)
-		return -ENOMEM;
-
-	/* set the requested channels */
-	for (i = 0; i < n_channels; i++)
-		req->channels[i] = channels[i];
-
-	req->n_channels = n_channels;
-
-	/* set the rates */
-	for (i = 0; i < NUM_NL80211_BANDS; i++)
-		if (mvm->hw->wiphy->bands[i])
-			req->rates[i] =
-				(1 << mvm->hw->wiphy->bands[i]->n_bitrates) - 1;
-
-	req->wdev = ieee80211_vif_to_wdev(vif);
-	req->wiphy = mvm->hw->wiphy;
-	req->scan_start = jiffies;
-	req->tsf_report_link_id = -1;
-
-	ret = _iwl_mvm_single_scan_start(mvm, vif, req, &ies,
-					 IWL_MVM_SCAN_INT_MLO);
-	kfree(req);
-
-	IWL_DEBUG_SCAN(mvm, "Internal MLO scan: ret=%d\n", ret);
-	return ret;
-}
-
-int iwl_mvm_int_mlo_scan(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
-{
-	struct ieee80211_channel *channels[IEEE80211_MLD_MAX_NUM_LINKS];
-	unsigned long usable_links = ieee80211_vif_usable_links(vif);
-	size_t n_channels = 0;
-	u8 link_id;
-
-	lockdep_assert_held(&mvm->mutex);
-
-	if (mvm->scan_status & IWL_MVM_SCAN_INT_MLO) {
-		IWL_DEBUG_SCAN(mvm, "Internal MLO scan is already running\n");
-		return -EBUSY;
-	}
-
-	rcu_read_lock();
-
-	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
-		struct ieee80211_bss_conf *link_conf =
-			rcu_dereference(vif->link_conf[link_id]);
-
-		if (WARN_ON_ONCE(!link_conf))
-			continue;
-
-		channels[n_channels++] = link_conf->chanreq.oper.chan;
-	}
-
-	rcu_read_unlock();
-
-	if (!n_channels)
-		return -EINVAL;
-
-	return iwl_mvm_int_mlo_scan_start(mvm, vif, channels, n_channels);
-}
-
 static int iwl_mvm_chanidx_from_phy(struct iwl_mvm *mvm,
 				    enum nl80211_band band,
 				    u16 phy_chan_num)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 11c6b86db4ec..363232bb74fa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1835,18 +1835,6 @@ int iwl_mvm_sta_init(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	iwl_mvm_toggle_tx_ant(mvm, &mvm_sta->tx_ant);
 
-	/* MPDUs are counted only when EMLSR is possible */
-	if (vif->type == NL80211_IFTYPE_STATION && !vif->p2p &&
-	    !sta->tdls && ieee80211_vif_is_mld(vif)) {
-		mvm_sta->mpdu_counters =
-			kcalloc(mvm->trans->info.num_rxqs,
-				sizeof(*mvm_sta->mpdu_counters),
-				GFP_KERNEL);
-		if (mvm_sta->mpdu_counters)
-			for (int q = 0; q < mvm->trans->info.num_rxqs; q++)
-				spin_lock_init(&mvm_sta->mpdu_counters[q].lock);
-	}
-
 	return 0;
 }
 
@@ -4328,80 +4316,3 @@ void iwl_mvm_cancel_channel_switch(struct iwl_mvm *mvm,
 	if (ret)
 		IWL_ERR(mvm, "Failed to cancel the channel switch\n");
 }
-
-static int iwl_mvm_fw_sta_id_to_fw_link_id(struct iwl_mvm_vif *mvmvif,
-					   u8 fw_sta_id)
-{
-	struct ieee80211_link_sta *link_sta =
-		rcu_dereference(mvmvif->mvm->fw_id_to_link_sta[fw_sta_id]);
-	struct iwl_mvm_vif_link_info *link;
-
-	if (WARN_ON_ONCE(!link_sta))
-		return -EINVAL;
-
-	link = mvmvif->link[link_sta->link_id];
-
-	if (WARN_ON_ONCE(!link))
-		return -EINVAL;
-
-	return link->fw_link_id;
-}
-
-#define IWL_MVM_TPT_COUNT_WINDOW (IWL_MVM_TPT_COUNT_WINDOW_SEC * HZ)
-
-void iwl_mvm_count_mpdu(struct iwl_mvm_sta *mvm_sta, u8 fw_sta_id, u32 count,
-			bool tx, int queue)
-{
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(mvm_sta->vif);
-	struct iwl_mvm *mvm = mvmvif->mvm;
-	struct iwl_mvm_tpt_counter *queue_counter;
-	struct iwl_mvm_mpdu_counter *link_counter;
-	u32 total_mpdus = 0;
-	int fw_link_id;
-
-	/* Count only for a BSS sta, and only when EMLSR is possible */
-	if (!mvm_sta->mpdu_counters)
-		return;
-
-	/* Map sta id to link id */
-	fw_link_id = iwl_mvm_fw_sta_id_to_fw_link_id(mvmvif, fw_sta_id);
-	if (fw_link_id < 0)
-		return;
-
-	queue_counter = &mvm_sta->mpdu_counters[queue];
-	link_counter = &queue_counter->per_link[fw_link_id];
-
-	spin_lock_bh(&queue_counter->lock);
-
-	if (tx)
-		link_counter->tx += count;
-	else
-		link_counter->rx += count;
-
-	/*
-	 * When not in EMLSR, the window and the decision to enter EMLSR are
-	 * handled during counting, when in EMLSR - in the statistics flow
-	 */
-	if (mvmvif->esr_active)
-		goto out;
-
-	if (time_is_before_jiffies(queue_counter->window_start +
-					IWL_MVM_TPT_COUNT_WINDOW)) {
-		memset(queue_counter->per_link, 0,
-		       sizeof(queue_counter->per_link));
-		queue_counter->window_start = jiffies;
-
-		IWL_DEBUG_INFO(mvm, "MPDU counters are cleared\n");
-	}
-
-	for (int i = 0; i < IWL_FW_MAX_LINK_ID; i++)
-		total_mpdus += tx ? queue_counter->per_link[i].tx :
-				    queue_counter->per_link[i].rx;
-
-	if (total_mpdus > IWL_MVM_ENTER_ESR_TPT_THRESH)
-		wiphy_work_queue(mvmvif->mvm->hw->wiphy,
-				 &mvmvif->unblock_esr_tpt_wk);
-
-out:
-	spin_unlock_bh(&queue_counter->lock);
-}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index f6906061510b..c25edc7c1813 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -344,24 +344,6 @@ struct iwl_mvm_link_sta {
 	u8 avg_energy;
 };
 
-struct iwl_mvm_mpdu_counter {
-	u32 tx;
-	u32 rx;
-};
-
-/**
- * struct iwl_mvm_tpt_counter - per-queue MPDU counter
- *
- * @lock: Needed to protect the counters when modified from statistics.
- * @per_link: per-link counters.
- * @window_start: timestamp of the counting-window start
- */
-struct iwl_mvm_tpt_counter {
-	spinlock_t lock;
-	struct iwl_mvm_mpdu_counter per_link[IWL_FW_MAX_LINK_ID];
-	unsigned long window_start;
-} ____cacheline_aligned_in_smp;
-
 /**
  * struct iwl_mvm_sta - representation of a station in the driver
  * @vif: the interface the station belongs to
@@ -409,7 +391,6 @@ struct iwl_mvm_tpt_counter {
  * @link: per link sta entries. For non-MLO only link[0] holds data. For MLO,
  *	link[0] points to deflink and link[link_id] is allocated when new link
  *	sta is added.
- * @mpdu_counters: RX/TX MPDUs counters for each queue.
  *
  * When mac80211 creates a station it reserves some space (hw->sta_data_size)
  * in the structure for use by driver. This structure is placed in that
@@ -449,8 +430,6 @@ struct iwl_mvm_sta {
 
 	struct iwl_mvm_link_sta deflink;
 	struct iwl_mvm_link_sta __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
-
-	struct iwl_mvm_tpt_counter *mpdu_counters;
 };
 
 u16 iwl_mvm_tid_queued(struct iwl_mvm *mvm, struct iwl_mvm_tid_data *tid_data);
@@ -533,9 +512,6 @@ void iwl_mvm_update_tkip_key(struct iwl_mvm *mvm,
 void iwl_mvm_rx_eosp_notif(struct iwl_mvm *mvm,
 			   struct iwl_rx_cmd_buffer *rxb);
 
-void iwl_mvm_count_mpdu(struct iwl_mvm_sta *mvm_sta, u8 fw_sta_id, u32 count,
-			bool tx, int queue);
-
 /* AMPDU */
 int iwl_mvm_sta_rx_agg(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		       int tid, u16 ssn, bool start, u16 buf_size, u16 timeout);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile b/drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile
index bb33f4a06f1c..2267be4cfb44 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile
@@ -1,3 +1,3 @@
-iwlmvm-tests-y += module.o links.o hcmd.o
+iwlmvm-tests-y += module.o hcmd.o
 
 obj-$(CONFIG_IWLWIFI_KUNIT_TESTS) += iwlmvm-tests.o
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c b/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
deleted file mode 100644
index d692f1813d44..000000000000
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
+++ /dev/null
@@ -1,433 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * KUnit tests for channel helper functions
- *
- * Copyright (C) 2024 Intel Corporation
- */
-#include <net/mac80211.h>
-#include "../mvm.h"
-#include <kunit/test.h>
-
-MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
-
-static struct wiphy wiphy = {
-	.mtx = __MUTEX_INITIALIZER(wiphy.mtx),
-};
-
-static struct ieee80211_hw hw = {
-	.wiphy = &wiphy,
-};
-
-static struct ieee80211_channel chan_5ghz = {
-	.band = NL80211_BAND_5GHZ,
-};
-
-static struct ieee80211_channel chan_6ghz = {
-	.band = NL80211_BAND_6GHZ,
-};
-
-static struct ieee80211_channel chan_2ghz = {
-	.band = NL80211_BAND_2GHZ,
-};
-
-static struct cfg80211_chan_def chandef_a = {};
-
-static struct cfg80211_chan_def chandef_b = {};
-
-static struct iwl_mvm_phy_ctxt ctx = {};
-
-static struct iwl_mvm_vif_link_info mvm_link = {
-	.phy_ctxt = &ctx,
-	.active = true
-};
-
-static struct cfg80211_bss bss = {};
-
-static struct ieee80211_bss_conf link_conf = {.bss = &bss};
-
-static const struct iwl_fw_cmd_version entry = {
-	.group = LEGACY_GROUP,
-	.cmd = BT_PROFILE_NOTIFICATION,
-	.notif_ver = 4
-};
-
-static struct iwl_fw fw = {
-	.ucode_capa = {
-		.n_cmd_versions = 1,
-		.cmd_versions = &entry,
-	},
-};
-
-static struct iwl_mvm mvm = {
-	.hw = &hw,
-	.fw = &fw,
-};
-
-static const struct link_grading_case {
-	const char *desc;
-	const struct cfg80211_chan_def chandef;
-	s32 signal;
-	s16 channel_util;
-	int chan_load_by_us;
-	unsigned int grade;
-} link_grading_cases[] = {
-	{
-		.desc = "UHB, RSSI below range, no factors",
-		.chandef = {
-			.chan = &chan_6ghz,
-			.width = NL80211_CHAN_WIDTH_20,
-		},
-		.signal = -100,
-		.grade = 177,
-	},
-	{
-		.desc = "LB, RSSI in range, no factors",
-		.chandef = {
-			.chan = &chan_2ghz,
-			.width = NL80211_CHAN_WIDTH_20,
-		},
-		.signal = -84,
-		.grade = 344,
-	},
-	{
-		.desc = "HB, RSSI above range, no factors",
-		.chandef = {
-			.chan = &chan_5ghz,
-			.width = NL80211_CHAN_WIDTH_20,
-		},
-		.signal = -50,
-		.grade = 3442,
-	},
-	{
-		.desc = "HB, BSS Load IE (20 percent), inactive link, no puncturing factor",
-		.chandef = {
-			.chan = &chan_5ghz,
-			.width = NL80211_CHAN_WIDTH_20,
-		},
-		.signal = -66,
-		.channel_util = 51,
-		.grade = 1836,
-	},
-	{
-		.desc = "LB, BSS Load IE (20 percent), active link, chan_load_by_us=10 percent. No puncturing factor",
-		.chandef = {
-			.chan = &chan_2ghz,
-			.width = NL80211_CHAN_WIDTH_20,
-		},
-		.signal = -61,
-		.channel_util = 51,
-		.chan_load_by_us = 10,
-		.grade = 2061,
-	},
-	{
-		.desc = "UHB, BSS Load IE (40 percent), active link, chan_load_by_us=50 (invalid) percent. No puncturing factor",
-		.chandef = {
-			.chan = &chan_6ghz,
-			.width = NL80211_CHAN_WIDTH_20,
-		},
-		.signal = -66,
-		.channel_util = 102,
-		.chan_load_by_us = 50,
-		.grade = 1552,
-	},
-	{	.desc = "HB, 80 MHz, no channel load factor, punctured percentage 0",
-		.chandef = {
-			.chan = &chan_5ghz,
-			.width = NL80211_CHAN_WIDTH_80,
-			.punctured = 0x0000
-		},
-		.signal = -72,
-		.grade = 1750,
-	},
-	{	.desc = "HB, 160 MHz, no channel load factor, punctured percentage 25",
-		.chandef = {
-			.chan = &chan_5ghz,
-			.width = NL80211_CHAN_WIDTH_160,
-			.punctured = 0x3
-		},
-		.signal = -72,
-		.grade = 1312,
-	},
-	{	.desc = "UHB, 320 MHz, no channel load factor, punctured percentage 12.5 (2/16)",
-		.chandef = {
-			.chan = &chan_6ghz,
-			.width = NL80211_CHAN_WIDTH_320,
-			.punctured = 0x3
-		},
-		.signal = -72,
-		.grade = 1806,
-	},
-	{	.desc = "HB, 160 MHz, channel load 20, channel load by us 10, punctured percentage 25",
-		.chandef = {
-			.chan = &chan_5ghz,
-			.width = NL80211_CHAN_WIDTH_160,
-			.punctured = 0x3
-		},
-		.channel_util = 51,
-		.chan_load_by_us = 10,
-		.signal = -72,
-		.grade = 1179,
-	},
-};
-
-KUNIT_ARRAY_PARAM_DESC(link_grading, link_grading_cases, desc)
-
-static void setup_link_conf(struct kunit *test)
-{
-	const struct link_grading_case *params = test->param_value;
-	size_t vif_size = sizeof(struct ieee80211_vif) +
-		sizeof(struct iwl_mvm_vif);
-	struct ieee80211_vif *vif = kunit_kzalloc(test, vif_size, GFP_KERNEL);
-	struct ieee80211_bss_load_elem *bss_load;
-	struct element *element;
-	size_t ies_size = sizeof(struct cfg80211_bss_ies) + sizeof(*bss_load) + sizeof(element);
-	struct cfg80211_bss_ies *ies;
-	struct iwl_mvm_vif *mvmvif;
-
-	KUNIT_ASSERT_NOT_NULL(test, vif);
-
-	mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	if (params->chan_load_by_us > 0) {
-		ctx.channel_load_by_us = params->chan_load_by_us;
-		mvmvif->link[0] = &mvm_link;
-	}
-
-	link_conf.vif = vif;
-	link_conf.chanreq.oper = params->chandef;
-	bss.signal = DBM_TO_MBM(params->signal);
-
-	ies = kunit_kzalloc(test, ies_size, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, ies);
-	ies->len = sizeof(*bss_load) + sizeof(struct element);
-
-	element = (void *)ies->data;
-	element->datalen = sizeof(*bss_load);
-	element->id = 11;
-
-	bss_load = (void *)element->data;
-	bss_load->channel_util = params->channel_util;
-
-	rcu_assign_pointer(bss.ies, ies);
-	rcu_assign_pointer(bss.beacon_ies, ies);
-}
-
-static void test_link_grading(struct kunit *test)
-{
-	const struct link_grading_case *params = test->param_value;
-	unsigned int ret;
-
-	setup_link_conf(test);
-
-	rcu_read_lock();
-	ret = iwl_mvm_get_link_grade(&link_conf);
-	rcu_read_unlock();
-
-	KUNIT_EXPECT_EQ(test, ret, params->grade);
-
-	kunit_kfree(test, link_conf.vif);
-	RCU_INIT_POINTER(bss.ies, NULL);
-}
-
-static struct kunit_case link_grading_test_cases[] = {
-	KUNIT_CASE_PARAM(test_link_grading, link_grading_gen_params),
-	{}
-};
-
-static struct kunit_suite link_grading = {
-	.name = "iwlmvm-link-grading",
-	.test_cases = link_grading_test_cases,
-};
-
-kunit_test_suite(link_grading);
-
-static const struct valid_link_pair_case {
-	const char *desc;
-	bool bt;
-	struct ieee80211_channel *chan_a;
-	struct ieee80211_channel *chan_b;
-	enum nl80211_chan_width cw_a;
-	enum nl80211_chan_width cw_b;
-	s32 sig_a;
-	s32 sig_b;
-	bool csa_a;
-	bool valid;
-} valid_link_pair_cases[] = {
-	{
-		.desc = "HB + UHB, valid.",
-		.chan_a = &chan_6ghz,
-		.chan_b = &chan_5ghz,
-		.valid = true,
-	},
-	{
-		.desc = "LB + HB, no BT.",
-		.chan_a = &chan_2ghz,
-		.chan_b = &chan_5ghz,
-		.valid = true,
-	},
-	{
-		.desc = "LB + HB, with BT.",
-		.bt = true,
-		.chan_a = &chan_2ghz,
-		.chan_b = &chan_5ghz,
-		.valid = false,
-	},
-	{
-		.desc = "Same band",
-		.chan_a = &chan_2ghz,
-		.chan_b = &chan_2ghz,
-		.valid = false,
-	},
-	{
-		.desc = "RSSI: LB, 20 MHz, low",
-		.chan_a = &chan_2ghz,
-		.cw_a = NL80211_CHAN_WIDTH_20,
-		.sig_a = -68,
-		.chan_b = &chan_5ghz,
-		.valid = false,
-	},
-	{
-		.desc = "RSSI: UHB, 20 MHz, high",
-		.chan_a = &chan_6ghz,
-		.cw_a = NL80211_CHAN_WIDTH_20,
-		.sig_a = -66,
-		.chan_b = &chan_5ghz,
-		.cw_b = NL80211_CHAN_WIDTH_20,
-		.valid = true,
-	},
-	{
-		.desc = "RSSI: UHB, 40 MHz, low",
-		.chan_a = &chan_6ghz,
-		.cw_a = NL80211_CHAN_WIDTH_40,
-		.sig_a = -65,
-		.chan_b = &chan_5ghz,
-		.cw_b = NL80211_CHAN_WIDTH_40,
-		.valid = false,
-	},
-	{
-		.desc = "RSSI: UHB, 40 MHz, high",
-		.chan_a = &chan_6ghz,
-		.cw_a = NL80211_CHAN_WIDTH_40,
-		.sig_a = -63,
-		.chan_b = &chan_5ghz,
-		.cw_b = NL80211_CHAN_WIDTH_40,
-		.valid = true,
-	},
-	{
-		.desc = "RSSI: UHB, 80 MHz, low",
-		.chan_a = &chan_6ghz,
-		.cw_a = NL80211_CHAN_WIDTH_80,
-		.sig_a = -62,
-		.chan_b = &chan_5ghz,
-		.cw_b = NL80211_CHAN_WIDTH_80,
-		.valid = false,
-	},
-	{
-		.desc = "RSSI: UHB, 80 MHz, high",
-		.chan_a = &chan_6ghz,
-		.cw_a = NL80211_CHAN_WIDTH_80,
-		.sig_a = -60,
-		.chan_b = &chan_5ghz,
-		.cw_b = NL80211_CHAN_WIDTH_80,
-		.valid = true,
-	},
-	{
-		.desc = "RSSI: UHB, 160 MHz, low",
-		.chan_a = &chan_6ghz,
-		.cw_a = NL80211_CHAN_WIDTH_160,
-		.sig_a = -59,
-		.chan_b = &chan_5ghz,
-		.cw_b = NL80211_CHAN_WIDTH_160,
-		.valid = false,
-	},
-	{
-		.desc = "RSSI: HB, 160 MHz, high",
-		.chan_a = &chan_6ghz,
-		.cw_a = NL80211_CHAN_WIDTH_160,
-		.sig_a = -5,
-		.chan_b = &chan_5ghz,
-		.cw_b = NL80211_CHAN_WIDTH_160,
-		.valid = true,
-	},
-	{
-		.desc = "CSA active",
-		.chan_a = &chan_6ghz,
-		.cw_a = NL80211_CHAN_WIDTH_160,
-		.sig_a = -5,
-		.chan_b = &chan_5ghz,
-		.cw_b = NL80211_CHAN_WIDTH_160,
-		.valid = false,
-		/* same as previous entry with valid=true except for CSA */
-		.csa_a = true,
-	},
-};
-
-KUNIT_ARRAY_PARAM_DESC(valid_link_pair, valid_link_pair_cases, desc)
-
-static void test_valid_link_pair(struct kunit *test)
-{
-	const struct valid_link_pair_case *params = test->param_value;
-	size_t vif_size = sizeof(struct ieee80211_vif) +
-		sizeof(struct iwl_mvm_vif);
-	struct ieee80211_vif *vif = kunit_kzalloc(test, vif_size, GFP_KERNEL);
-	struct iwl_trans *trans = kunit_kzalloc(test, sizeof(struct iwl_trans),
-						GFP_KERNEL);
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mvm_link_sel_data link_a = {
-		.chandef = &chandef_a,
-		.link_id = 1,
-		.signal = params->sig_a,
-	};
-	struct iwl_mvm_link_sel_data link_b = {
-		.chandef = &chandef_b,
-		.link_id = 5,
-		.signal = params->sig_b,
-	};
-	struct ieee80211_bss_conf *conf;
-	bool result;
-
-	KUNIT_ASSERT_NOT_NULL(test, vif);
-	KUNIT_ASSERT_NOT_NULL(test, trans);
-
-	chandef_a.chan = params->chan_a;
-	chandef_b.chan = params->chan_b;
-
-	chandef_a.width = params->cw_a ?: NL80211_CHAN_WIDTH_20;
-	chandef_b.width = params->cw_b ?: NL80211_CHAN_WIDTH_20;
-
-	mvm.trans = trans;
-
-	mvm.last_bt_notif.wifi_loss_low_rssi = params->bt;
-	mvmvif->mvm = &mvm;
-
-	conf = kunit_kzalloc(test, sizeof(*vif->link_conf[0]), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, conf);
-	conf->chanreq.oper = chandef_a;
-	conf->csa_active = params->csa_a;
-	vif->link_conf[link_a.link_id] = (void __rcu *)conf;
-
-	conf = kunit_kzalloc(test, sizeof(*vif->link_conf[0]), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, conf);
-	conf->chanreq.oper = chandef_b;
-	vif->link_conf[link_b.link_id] = (void __rcu *)conf;
-
-	wiphy_lock(&wiphy);
-	result = iwl_mvm_mld_valid_link_pair(vif, &link_a, &link_b);
-	wiphy_unlock(&wiphy);
-
-	KUNIT_EXPECT_EQ(test, result, params->valid);
-
-	kunit_kfree(test, vif);
-	kunit_kfree(test, trans);
-}
-
-static struct kunit_case valid_link_pair_test_cases[] = {
-	KUNIT_CASE_PARAM(test_valid_link_pair, valid_link_pair_gen_params),
-	{},
-};
-
-static struct kunit_suite valid_link_pair = {
-	.name = "iwlmvm-valid-link-pair",
-	.test_cases = valid_link_pair_test_cases,
-};
-
-kunit_test_suite(valid_link_pair);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index aa653782d6d7..0c9c2492d8a7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -47,7 +47,6 @@ void iwl_mvm_te_clear_data(struct iwl_mvm *mvm,
 
 static void iwl_mvm_cleanup_roc(struct iwl_mvm *mvm)
 {
-	struct ieee80211_vif *bss_vif = iwl_mvm_get_bss_vif(mvm);
 	struct ieee80211_vif *vif = mvm->p2p_device_vif;
 
 	lockdep_assert_held(&mvm->mutex);
@@ -125,8 +124,6 @@ static void iwl_mvm_cleanup_roc(struct iwl_mvm *mvm)
 			iwl_mvm_rm_aux_sta(mvm);
 	}
 
-	if (!IS_ERR_OR_NULL(bss_vif))
-		iwl_mvm_unblock_esr(mvm, bss_vif, IWL_MVM_ESR_BLOCKED_ROC);
 	mutex_unlock(&mvm->mutex);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 25d1a882a6a0..bb97837baeda 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1769,9 +1769,6 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 				IWL_DEBUG_TX_REPLY(mvm,
 						   "Next reclaimed packet:%d\n",
 						   next_reclaimed);
-				if (tid < IWL_MAX_TID_COUNT)
-					iwl_mvm_count_mpdu(mvmsta, sta_id, 1,
-							   true, 0);
 			} else {
 				IWL_DEBUG_TX_REPLY(mvm,
 						   "NDP - don't update next_reclaimed\n");
@@ -2150,13 +2147,10 @@ void iwl_mvm_rx_ba_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 					   ba_res->tx_rate, false);
 		}
 
-		if (mvmsta) {
+		if (mvmsta)
 			iwl_mvm_tx_airtime(mvm, mvmsta,
 					   le32_to_cpu(ba_res->wireless_time));
 
-			iwl_mvm_count_mpdu(mvmsta, sta_id,
-					   le16_to_cpu(ba_res->txed), true, 0);
-		}
 		rcu_read_unlock();
 		return;
 	}
-- 
2.34.1


