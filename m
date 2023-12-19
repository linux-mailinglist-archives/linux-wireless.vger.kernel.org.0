Return-Path: <linux-wireless+bounces-1035-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB87A819124
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 21:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC331C21BCB
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 20:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7E53987A;
	Tue, 19 Dec 2023 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j6k/YFaU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FB43B18A
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 19:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703015985; x=1734551985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3eSIhcxyLRHWCxAVA1+qCUeK+mAONhYHrFVfl1L2DGg=;
  b=j6k/YFaU8WFbhRuiUIriRzlkEHMJ9X7ELtkPd0jrGfQFizfidAHicXfP
   UzBiq8H5LnwCOoL2XsV+gStVZ2/0gNe3U6xWmfBD75aS5FaSWW/HoTPrk
   gv9dhOcztdN2U7EN8SnkPbFGt9xTDmUKzKjfVbIpYFWMf1ikpCW3ZbuDV
   Fj1pxCix6LXZyymPK7B16iR5dBQnGb8t6B194xfEl23V59piDCPFkpsQK
   hhQmfQCNAUhcHb25Zgcx59gcmUkvF3QDX26//K+zmtEBnWF62XoQi+nW7
   IvkFVRwlNHIvw2EwLcjlI6uGSFylPPwXXeMhOvsQ5CS6oJ1lc/kZSHsum
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="380694965"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="380694965"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:59:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="779589122"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="779589122"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:59:44 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/14] wifi: iwlwifi: cleanup BT Shared Single Antenna code
Date: Tue, 19 Dec 2023 21:58:57 +0200
Message-Id: <20231219215605.6e6961ac0ac5.I923024eac20efd24a5b42332d8e73ae756e0469a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219195902.3336105-1-miriam.rachel.korenblit@intel.com>
References: <20231219195902.3336105-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

We don't support such device.

Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>

e
---
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  1 -
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c | 22 ++++---------------
 2 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 02ded22295c1..ae6f1cd4d660 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -377,7 +377,6 @@ struct iwl_cfg {
 	u16 nvm_calib_ver;
 	u32 rx_with_siso_diversity:1,
 	    tx_with_siso_diversity:1,
-	    bt_shared_single_ant:1,
 	    internal_wimax_coex:1,
 	    host_interrupt_operation_mode:1,
 	    high_temp:1,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
index 5a5b1128e75c..9fe1761691ec 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2013-2014, 2018-2020, 2022 Intel Corporation
+ * Copyright (C) 2013-2014, 2018-2020, 2022-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  */
 #include <linux/ieee80211.h>
@@ -116,11 +116,6 @@ iwl_get_coex_type(struct iwl_mvm *mvm, const struct ieee80211_vif *vif)
 
 	ret = BT_COEX_TX_DIS_LUT;
 
-	if (mvm->cfg->bt_shared_single_ant) {
-		rcu_read_unlock();
-		return ret;
-	}
-
 	phy_ctx_id = *((u16 *)chanctx_conf->drv_priv);
 	primary_ch_phy_id = le32_to_cpu(mvm->last_bt_ci_cmd.primary_ch_phy_id);
 	secondary_ch_phy_id =
@@ -383,13 +378,12 @@ static void iwl_mvm_bt_notif_per_link(struct iwl_mvm *mvm,
 	/*
 	 * don't reduce the Tx power if one of these is true:
 	 *  we are in LOOSE
-	 *  single share antenna product
 	 *  BT is inactive
 	 *  we are not associated
 	 */
 	if (iwl_get_coex_type(mvm, vif) == BT_COEX_LOOSE_LUT ||
-	    mvm->cfg->bt_shared_single_ant || !vif->cfg.assoc ||
-	    le32_to_cpu(mvm->last_bt_notif.bt_activity_grading) == BT_OFF) {
+	    le32_to_cpu(mvm->last_bt_notif.bt_activity_grading) == BT_OFF ||
+	    !vif->cfg.assoc) {
 		iwl_mvm_bt_coex_reduced_txp(mvm, link_info->ap_sta_id, false);
 		/* FIXME: should this be per link? */
 		iwl_mvm_bt_coex_enable_rssi_event(mvm, vif, false, 0);
@@ -570,7 +564,7 @@ void iwl_mvm_bt_rssi_event(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	 * Check if rssi is good enough for reduced Tx power, but not in loose
 	 * scheme.
 	 */
-	if (rssi_event == RSSI_EVENT_LOW || mvm->cfg->bt_shared_single_ant ||
+	if (rssi_event == RSSI_EVENT_LOW ||
 	    iwl_get_coex_type(mvm, vif) == BT_COEX_LOOSE_LUT)
 		ret = iwl_mvm_bt_coex_reduced_txp(mvm,
 						  mvmvif->deflink.ap_sta_id,
@@ -639,10 +633,6 @@ bool iwl_mvm_bt_coex_is_mimo_allowed(struct iwl_mvm *mvm,
 
 bool iwl_mvm_bt_coex_is_ant_avail(struct iwl_mvm *mvm, u8 ant)
 {
-	/* there is no other antenna, shared antenna is always available */
-	if (mvm->cfg->bt_shared_single_ant)
-		return true;
-
 	if (ant & mvm->cfg->non_shared_ant)
 		return true;
 
@@ -652,10 +642,6 @@ bool iwl_mvm_bt_coex_is_ant_avail(struct iwl_mvm *mvm, u8 ant)
 
 bool iwl_mvm_bt_coex_is_shared_ant_avail(struct iwl_mvm *mvm)
 {
-	/* there is no other antenna, shared antenna is always available */
-	if (mvm->cfg->bt_shared_single_ant)
-		return true;
-
 	return le32_to_cpu(mvm->last_bt_notif.bt_activity_grading) < BT_HIGH_TRAFFIC;
 }
 
-- 
2.34.1


