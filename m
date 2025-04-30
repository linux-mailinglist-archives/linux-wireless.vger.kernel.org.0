Return-Path: <linux-wireless+bounces-22276-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDC4AA4C65
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 15:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A8B9C783C
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 12:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4238125C6EF;
	Wed, 30 Apr 2025 12:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R53Z8DkW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528452609FA
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017887; cv=none; b=azraeTbKpZc+gtq76PWdwUhtv4+hSq983+gBXweDO1rnwMCJqGt5XkhcFWtSIuaSvLHPqUp4nhqatZr/on+G4/OeLofxJACuznPsW/UOQYjae35OwtbVUkGbgc9C5Mw4VhkHF1VuDIbif0/HSlB65GiZbH4kzKyVWN+wMNNDbWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017887; c=relaxed/simple;
	bh=D7pQMZziqYpqBttxYUdl2VRMLu7Xi9Js1IUo0dlLzh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CG5h3cleuaDaszmIpj0ZYHS7cCowFTfwBthv01gYs+lJlblomR1vG8be80v1UUfbTLONeBjJbsuLJbl9ZsgMpVHQk19v0M6eOvpd+REAUqlf7uFbMYT2b3b5xVDAnUIlKmWLgZxLJxjJvjvTWoz7X2no8uVavL1EzUkVLF/4HCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R53Z8DkW; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746017885; x=1777553885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D7pQMZziqYpqBttxYUdl2VRMLu7Xi9Js1IUo0dlLzh0=;
  b=R53Z8DkWAgqvzcCmQPXF6sbAggADdFwt43YoOrsZIybrd8bN2A8QsHPK
   RoAwRV62px5PX1NSPOu7ueN857Sv4rJ35R36H9qSX7Emd0tNRQfW3/cx7
   ccwVBxXUsNl4a5X1NdhGVGXcLo/fxJbMLnQCpEpZ1xCdd7KxU5VTKr9vl
   dMMAuomAVMo5MjI506Qp+HlZCuik7FCAjj6d2T6UkTb2tBG6zrQe6vP4V
   6uWIq4Np7IZofwdztibOAc7MsbAcPW/nghzPHsh/FkMFO3v69615TKb8A
   oSHopj/v+Xm0czgkq06sFNus+8P4PFNt8fN6lq+ralWVa2Pinihr2u4wE
   g==;
X-CSE-ConnectionGUID: BJmc8r4zRMa3hg3Q+i917A==
X-CSE-MsgGUID: 3x0fNui6QqGr29cbymgZAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="58332355"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="58332355"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:58:05 -0700
X-CSE-ConnectionGUID: +sn663eTSx6EVcFCblqbMQ==
X-CSE-MsgGUID: as85DXyDQNW2BMIrHbWUcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="134632150"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:58:03 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: mvm: remove nl80211 testmode
Date: Wed, 30 Apr 2025 15:57:29 +0300
Message-Id: <20250430155443.751018e0ed8e.I21557a9a3d57234187f1b0b2182a1714ecc66b9a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
References: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This was used in the past for NoA and/or beacon filter
testing, but these days everything is tested via debugfs
or special FW commands, so remove the testmode.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 75 +------------------
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 15 ----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  5 --
 .../net/wireless/intel/iwlwifi/mvm/quota.c    | 43 +----------
 4 files changed, 2 insertions(+), 136 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 70b2cdace86d..d62c797775f2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1988,15 +1988,8 @@ static void iwl_mvm_mac_remove_interface(struct ieee80211_hw *hw,
 	 * interface is be handled as part of the stop_ap flow.
 	 */
 	if (vif->type == NL80211_IFTYPE_AP ||
-	    vif->type == NL80211_IFTYPE_ADHOC) {
-#ifdef CONFIG_NL80211_TESTMODE
-		if (vif == mvm->noa_vif) {
-			mvm->noa_vif = NULL;
-			mvm->noa_duration = 0;
-		}
-#endif
+	    vif->type == NL80211_IFTYPE_ADHOC)
 		goto out;
-	}
 
 	iwl_mvm_power_update_mac(mvm);
 
@@ -5526,70 +5519,6 @@ static int iwl_mvm_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 					       &mvm_sta->vif->bss_conf);
 }
 
-#ifdef CONFIG_NL80211_TESTMODE
-static const struct nla_policy iwl_mvm_tm_policy[IWL_MVM_TM_ATTR_MAX + 1] = {
-	[IWL_MVM_TM_ATTR_CMD] = { .type = NLA_U32 },
-	[IWL_MVM_TM_ATTR_NOA_DURATION] = { .type = NLA_U32 },
-	[IWL_MVM_TM_ATTR_BEACON_FILTER_STATE] = { .type = NLA_U32 },
-};
-
-static int __iwl_mvm_mac_testmode_cmd(struct iwl_mvm *mvm,
-				      struct ieee80211_vif *vif,
-				      void *data, int len)
-{
-	struct nlattr *tb[IWL_MVM_TM_ATTR_MAX + 1];
-	int err;
-	u32 noa_duration;
-
-	err = nla_parse_deprecated(tb, IWL_MVM_TM_ATTR_MAX, data, len,
-				   iwl_mvm_tm_policy, NULL);
-	if (err)
-		return err;
-
-	if (!tb[IWL_MVM_TM_ATTR_CMD])
-		return -EINVAL;
-
-	switch (nla_get_u32(tb[IWL_MVM_TM_ATTR_CMD])) {
-	case IWL_MVM_TM_CMD_SET_NOA:
-		if (!vif || vif->type != NL80211_IFTYPE_AP || !vif->p2p ||
-		    !vif->bss_conf.enable_beacon ||
-		    !tb[IWL_MVM_TM_ATTR_NOA_DURATION])
-			return -EINVAL;
-
-		noa_duration = nla_get_u32(tb[IWL_MVM_TM_ATTR_NOA_DURATION]);
-		if (noa_duration >= vif->bss_conf.beacon_int)
-			return -EINVAL;
-
-		mvm->noa_duration = noa_duration;
-		mvm->noa_vif = vif;
-
-		return iwl_mvm_update_quotas(mvm, true, NULL);
-	case IWL_MVM_TM_CMD_SET_BEACON_FILTER:
-		/* must be associated client vif - ignore authorized */
-		if (!vif || vif->type != NL80211_IFTYPE_STATION ||
-		    !vif->cfg.assoc || !vif->bss_conf.dtim_period ||
-		    !tb[IWL_MVM_TM_ATTR_BEACON_FILTER_STATE])
-			return -EINVAL;
-
-		if (nla_get_u32(tb[IWL_MVM_TM_ATTR_BEACON_FILTER_STATE]))
-			return iwl_mvm_enable_beacon_filter(mvm, vif);
-		return iwl_mvm_disable_beacon_filter(mvm, vif);
-	}
-
-	return -EOPNOTSUPP;
-}
-
-int iwl_mvm_mac_testmode_cmd(struct ieee80211_hw *hw,
-			     struct ieee80211_vif *vif,
-			     void *data, int len)
-{
-	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-
-	guard(mvm)(mvm);
-	return __iwl_mvm_mac_testmode_cmd(mvm, vif, data, len);
-}
-#endif
-
 void iwl_mvm_channel_switch(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			    struct ieee80211_channel_switch *chsw)
 {
@@ -6649,8 +6578,6 @@ const struct ieee80211_ops iwl_mvm_hw_ops = {
 
 	.sync_rx_queues = iwl_mvm_sync_rx_queues,
 
-	CFG80211_TESTMODE_CMD(iwl_mvm_mac_testmode_cmd)
-
 #ifdef CONFIG_PM_SLEEP
 	/* look at d3.c */
 	.suspend = iwl_mvm_suspend,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 78d7153a0cfc..bf24f8cb673e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -150,19 +150,6 @@ static void iwl_mvm_mld_mac_remove_interface(struct ieee80211_hw *hw,
 
 	iwl_mvm_vif_dbgfs_rm_link(mvm, vif);
 
-	/* For AP/GO interface, the tear down of the resources allocated to the
-	 * interface is be handled as part of the stop_ap flow.
-	 */
-	if (vif->type == NL80211_IFTYPE_AP ||
-	    vif->type == NL80211_IFTYPE_ADHOC) {
-#ifdef CONFIG_NL80211_TESTMODE
-		if (vif == mvm->noa_vif) {
-			mvm->noa_vif = NULL;
-			mvm->noa_duration = 0;
-		}
-#endif
-	}
-
 	iwl_mvm_power_update_mac(mvm);
 
 	/* Before the interface removal, mac80211 would cancel the ROC, and the
@@ -1403,8 +1390,6 @@ const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 
 	.sync_rx_queues = iwl_mvm_sync_rx_queues,
 
-	CFG80211_TESTMODE_CMD(iwl_mvm_mac_testmode_cmd)
-
 #ifdef CONFIG_PM_SLEEP
 	/* look at d3.c */
 	.suspend = iwl_mvm_suspend,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 1e3639fa6b27..e3b54a0f5aed 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1246,11 +1246,6 @@ struct iwl_mvm {
 
 	struct iwl_time_quota_cmd last_quota_cmd;
 
-#ifdef CONFIG_NL80211_TESTMODE
-	u32 noa_duration;
-	struct ieee80211_vif *noa_vif;
-#endif
-
 	/* Tx queues */
 	u16 aux_queue;
 	u16 snif_queue;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/quota.c b/drivers/net/wireless/intel/iwlwifi/mvm/quota.c
index aad2614af9ad..798a7e4bea83 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/quota.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/quota.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018, 2021-2022 Intel Corporation
+ * Copyright (C) 2012-2014, 2018, 2021-2022, 2025 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -86,45 +86,6 @@ static void iwl_mvm_quota_iterator(void *_data, u8 *mac,
 	}
 }
 
-static void iwl_mvm_adjust_quota_for_noa(struct iwl_mvm *mvm,
-					 struct iwl_time_quota_cmd *cmd)
-{
-#ifdef CONFIG_NL80211_TESTMODE
-	struct iwl_mvm_vif *mvmvif;
-	int i, phy_id = -1, beacon_int = 0;
-
-	if (!mvm->noa_duration || !mvm->noa_vif)
-		return;
-
-	mvmvif = iwl_mvm_vif_from_mac80211(mvm->noa_vif);
-	if (!mvmvif->ap_ibss_active)
-		return;
-
-	phy_id = mvmvif->deflink.phy_ctxt->id;
-	beacon_int = mvm->noa_vif->bss_conf.beacon_int;
-
-	for (i = 0; i < MAX_BINDINGS; i++) {
-		struct iwl_time_quota_data *data =
-					iwl_mvm_quota_cmd_get_quota(mvm, cmd,
-								    i);
-		u32 id_n_c = le32_to_cpu(data->id_and_color);
-		u32 id = (id_n_c & FW_CTXT_ID_MSK) >> FW_CTXT_ID_POS;
-		u32 quota = le32_to_cpu(data->quota);
-
-		if (id != phy_id)
-			continue;
-
-		quota *= (beacon_int - mvm->noa_duration);
-		quota /= beacon_int;
-
-		IWL_DEBUG_QUOTA(mvm, "quota: adjust for NoA from %d to %d\n",
-				le32_to_cpu(data->quota), quota);
-
-		data->quota = cpu_to_le32(quota);
-	}
-#endif
-}
-
 int iwl_mvm_update_quotas(struct iwl_mvm *mvm,
 			  bool force_update,
 			  struct ieee80211_vif *disabled_vif)
@@ -260,8 +221,6 @@ int iwl_mvm_update_quotas(struct iwl_mvm *mvm,
 		}
 	}
 
-	iwl_mvm_adjust_quota_for_noa(mvm, &cmd);
-
 	/* check that we have non-zero quota for all valid bindings */
 	for (i = 0; i < MAX_BINDINGS; i++) {
 		qdata = iwl_mvm_quota_cmd_get_quota(mvm, &cmd, i);
-- 
2.34.1


