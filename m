Return-Path: <linux-wireless+bounces-3238-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A14784BA88
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 17:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C888529077C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 16:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDB1134CF6;
	Tue,  6 Feb 2024 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bklS2gaC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E791350C7
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235362; cv=none; b=K5Oxz0XcJNN/E2tKceCUgMid2wltqVTXxxjauA5bQ8YdAtiodFFC+JObbAQ5O/zFjzitVxENu72UWnfd4T3WdF3BPR/hN58D99mnhQ86lRMpK8XCpeqhe5+7g7valmMKDBS5/ildVgeKIQKg1IxIWRu9ZJpfPxEdsOwS7Y4tVa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235362; c=relaxed/simple;
	bh=klbA5qc/9ZDEhZdjryTJhbC6G6SX6gE+tHjCGjt/7Gw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hOf1Wa/p2Wxs9Dmcfto1pSQIbV44dKTwWpQNJG2KGHFOwEzJeELadFl/oSZmlIIB8ybdGOvAnV+4HfBEnBgql3HHH1aNIsdj0qA89uGco9IAn9IevSktmNKjN3tYEuQT/V62wPTb7rsKWZrCcTfUi4MZfiH7sUUqohYvnqSRrzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bklS2gaC; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707235361; x=1738771361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=klbA5qc/9ZDEhZdjryTJhbC6G6SX6gE+tHjCGjt/7Gw=;
  b=bklS2gaCT0cUDrZFC9DETdGvyp1iqfxXJB64BzCLznEgqYuxKqdM7xfD
   ODy0BVCsMBjTCuE2fSWOEM2C+eM19/MkwWMEiLBatW2bm0+HvRvZEPvWW
   xI+ZMfbgWC3a7SZfpeAw790viAvgakwhxa6bN79iOCxjfFBk5OlfpJ04g
   gNZ22nXYWvfM5ZOT0rjDy5LanRt6lmE30jZ27OZ+VykagB4kuxaxrGchv
   NUFhwbKqrr7458jWoAb05MgFGbC60l51ae+q9EmLBNS0UIVjLI5ubUs3I
   0bKOtB8gxXGbNFKOvVnPLB2lZfnLtrwkahGkwp7XwrAp4/LZN2LfDDk/X
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="23252379"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="23252379"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 08:02:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1349841"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 08:02:38 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 07/11] wifi: iwlwifi: mvm: remove flags for enable/disable beacon filter
Date: Tue,  6 Feb 2024 18:02:10 +0200
Message-Id: <20240206175739.2c739c1034a5.I8619949ad4ebd31593d10ece371ebdc6c48db98f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206160214.3260547-1-miriam.rachel.korenblit@intel.com>
References: <20240206160214.3260547-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The flags argument to enable/disable beacon filtering functions
is unused and always zero, so just remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  |  6 ++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 18 ++++++------
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  6 ++--
 .../net/wireless/intel/iwlwifi/mvm/power.c    | 29 ++++++++-----------
 5 files changed, 27 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
index 2b96cf9eac72..aa3c9c2cbd7f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -381,9 +381,9 @@ static ssize_t iwl_dbgfs_bf_params_write(struct ieee80211_vif *vif, char *buf,
 	mutex_lock(&mvm->mutex);
 	iwl_dbgfs_update_bf(vif, param, value);
 	if (param == MVM_DEBUGFS_BF_ENABLE_BEACON_FILTER && !value)
-		ret = iwl_mvm_disable_beacon_filter(mvm, vif, 0);
+		ret = iwl_mvm_disable_beacon_filter(mvm, vif);
 	else
-		ret = iwl_mvm_enable_beacon_filter(mvm, vif, 0);
+		ret = iwl_mvm_enable_beacon_filter(mvm, vif);
 	mutex_unlock(&mvm->mutex);
 
 	return ret ?: count;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 4fe50036bfde..a051e0c955d5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1448,7 +1448,7 @@ int iwl_mvm_post_channel_switch(struct ieee80211_hw *hw,
 
 		if (!fw_has_capa(&mvm->fw->ucode_capa,
 				 IWL_UCODE_TLV_CAPA_CHANNEL_SWITCH_CMD)) {
-			ret = iwl_mvm_enable_beacon_filter(mvm, vif, 0);
+			ret = iwl_mvm_enable_beacon_filter(mvm, vif);
 			if (ret)
 				goto out_unlock;
 
@@ -1632,7 +1632,7 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 		goto out_remove_mac;
 
 	/* beacon filtering */
-	ret = iwl_mvm_disable_beacon_filter(mvm, vif, 0);
+	ret = iwl_mvm_disable_beacon_filter(mvm, vif);
 	if (ret)
 		goto out_remove_mac;
 
@@ -2575,7 +2575,7 @@ iwl_mvm_bss_info_changed_station_common(struct iwl_mvm *mvm,
 		iwl_mvm_stop_session_protection(mvm, vif);
 
 		iwl_mvm_sf_update(mvm, vif, false);
-		WARN_ON(iwl_mvm_enable_beacon_filter(mvm, vif, 0));
+		WARN_ON(iwl_mvm_enable_beacon_filter(mvm, vif));
 	}
 
 	if (changes & (BSS_CHANGED_PS | BSS_CHANGED_P2P_PS | BSS_CHANGED_QOS |
@@ -2596,7 +2596,7 @@ iwl_mvm_bss_info_changed_station_common(struct iwl_mvm *mvm,
 			/* FIXME: need to update per link when FW API will
 			 * support it
 			 */
-			ret = iwl_mvm_enable_beacon_filter(mvm, vif, 0);
+			ret = iwl_mvm_enable_beacon_filter(mvm, vif);
 			if (ret)
 				IWL_ERR(mvm,
 					"failed to update CQM thresholds\n");
@@ -3800,7 +3800,7 @@ iwl_mvm_sta_state_assoc_to_authorized(struct iwl_mvm *mvm,
 					   NL80211_TDLS_ENABLE_LINK);
 	} else {
 		/* enable beacon filtering */
-		WARN_ON(iwl_mvm_enable_beacon_filter(mvm, vif, 0));
+		WARN_ON(iwl_mvm_enable_beacon_filter(mvm, vif));
 
 		mvmvif->authorized = 1;
 
@@ -3858,7 +3858,7 @@ iwl_mvm_sta_state_authorized_to_assoc(struct iwl_mvm *mvm,
 		mvmvif->authorized = 0;
 
 		/* disable beacon filtering */
-		iwl_mvm_disable_beacon_filter(mvm, vif, 0);
+		iwl_mvm_disable_beacon_filter(mvm, vif);
 	}
 
 	return 0;
@@ -5302,8 +5302,8 @@ static int __iwl_mvm_mac_testmode_cmd(struct iwl_mvm *mvm,
 			return -EINVAL;
 
 		if (nla_get_u32(tb[IWL_MVM_TM_ATTR_BEACON_FILTER_STATE]))
-			return iwl_mvm_enable_beacon_filter(mvm, vif, 0);
-		return iwl_mvm_disable_beacon_filter(mvm, vif, 0);
+			return iwl_mvm_enable_beacon_filter(mvm, vif);
+		return iwl_mvm_disable_beacon_filter(mvm, vif);
 	}
 
 	return -EOPNOTSUPP;
@@ -5387,7 +5387,7 @@ static int iwl_mvm_old_pre_chan_sw_sta(struct iwl_mvm *mvm,
 		iwl_mvm_csa_client_absent(mvm, vif);
 
 	if (mvmvif->bf_data.bf_enabled) {
-		int ret = iwl_mvm_disable_beacon_filter(mvm, vif, 0);
+		int ret = iwl_mvm_disable_beacon_filter(mvm, vif);
 
 		if (ret)
 			return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index ff7d9a7d607e..f818cf46b09c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -47,7 +47,7 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 		goto out_unlock;
 
 	/* beacon filtering */
-	ret = iwl_mvm_disable_beacon_filter(mvm, vif, 0);
+	ret = iwl_mvm_disable_beacon_filter(mvm, vif);
 	if (ret)
 		goto out_remove_mac;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 76f50b3bf893..2dd45f39b77f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2143,11 +2143,9 @@ iwl_mvm_beacon_filter_debugfs_parameters(struct ieee80211_vif *vif,
 {}
 #endif
 int iwl_mvm_enable_beacon_filter(struct iwl_mvm *mvm,
-				 struct ieee80211_vif *vif,
-				 u32 flags);
+				 struct ieee80211_vif *vif);
 int iwl_mvm_disable_beacon_filter(struct iwl_mvm *mvm,
-				  struct ieee80211_vif *vif,
-				  u32 flags);
+				  struct ieee80211_vif *vif);
 /* SMPS */
 void iwl_mvm_update_smps(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 				enum iwl_mvm_smps_type_request req_type,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/power.c b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
index 1b9b06e0443f..41e68aa6bec8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2019, 2021-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2019, 2021-2024 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -20,8 +20,7 @@
 
 static
 int iwl_mvm_beacon_filter_send_cmd(struct iwl_mvm *mvm,
-				   struct iwl_beacon_filter_cmd *cmd,
-				   u32 flags)
+				   struct iwl_beacon_filter_cmd *cmd)
 {
 	u16 len;
 
@@ -62,7 +61,7 @@ int iwl_mvm_beacon_filter_send_cmd(struct iwl_mvm *mvm,
 		len = offsetof(struct iwl_beacon_filter_cmd,
 			       bf_threshold_absolute_low);
 
-	return iwl_mvm_send_cmd_pdu(mvm, REPLY_BEACON_FILTERING_CMD, flags,
+	return iwl_mvm_send_cmd_pdu(mvm, REPLY_BEACON_FILTERING_CMD, 0,
 				    len, cmd);
 }
 
@@ -813,8 +812,7 @@ iwl_mvm_beacon_filter_debugfs_parameters(struct ieee80211_vif *vif,
 
 static int _iwl_mvm_enable_beacon_filter(struct iwl_mvm *mvm,
 					 struct ieee80211_vif *vif,
-					 struct iwl_beacon_filter_cmd *cmd,
-					 u32 cmd_flags)
+					 struct iwl_beacon_filter_cmd *cmd)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	int ret;
@@ -825,7 +823,7 @@ static int _iwl_mvm_enable_beacon_filter(struct iwl_mvm *mvm,
 
 	iwl_mvm_beacon_filter_set_cqm_params(mvm, vif, cmd);
 	iwl_mvm_beacon_filter_debugfs_parameters(vif, cmd);
-	ret = iwl_mvm_beacon_filter_send_cmd(mvm, cmd, cmd_flags);
+	ret = iwl_mvm_beacon_filter_send_cmd(mvm, cmd);
 
 	if (!ret)
 		mvmvif->bf_data.bf_enabled = true;
@@ -834,20 +832,18 @@ static int _iwl_mvm_enable_beacon_filter(struct iwl_mvm *mvm,
 }
 
 int iwl_mvm_enable_beacon_filter(struct iwl_mvm *mvm,
-				 struct ieee80211_vif *vif,
-				 u32 flags)
+				 struct ieee80211_vif *vif)
 {
 	struct iwl_beacon_filter_cmd cmd = {
 		IWL_BF_CMD_CONFIG_DEFAULTS,
 		.bf_enable_beacon_filter = cpu_to_le32(1),
 	};
 
-	return _iwl_mvm_enable_beacon_filter(mvm, vif, &cmd, flags);
+	return _iwl_mvm_enable_beacon_filter(mvm, vif, &cmd);
 }
 
 static int _iwl_mvm_disable_beacon_filter(struct iwl_mvm *mvm,
-					  struct ieee80211_vif *vif,
-					  u32 flags)
+					  struct ieee80211_vif *vif)
 {
 	struct iwl_beacon_filter_cmd cmd = {};
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
@@ -856,7 +852,7 @@ static int _iwl_mvm_disable_beacon_filter(struct iwl_mvm *mvm,
 	if (vif->type != NL80211_IFTYPE_STATION || vif->p2p)
 		return 0;
 
-	ret = iwl_mvm_beacon_filter_send_cmd(mvm, &cmd, flags);
+	ret = iwl_mvm_beacon_filter_send_cmd(mvm, &cmd);
 
 	if (!ret)
 		mvmvif->bf_data.bf_enabled = false;
@@ -865,10 +861,9 @@ static int _iwl_mvm_disable_beacon_filter(struct iwl_mvm *mvm,
 }
 
 int iwl_mvm_disable_beacon_filter(struct iwl_mvm *mvm,
-				  struct ieee80211_vif *vif,
-				  u32 flags)
+				  struct ieee80211_vif *vif)
 {
-	return _iwl_mvm_disable_beacon_filter(mvm, vif, flags);
+	return _iwl_mvm_disable_beacon_filter(mvm, vif);
 }
 
 static int iwl_mvm_power_set_ps(struct iwl_mvm *mvm)
@@ -919,7 +914,7 @@ static int iwl_mvm_power_set_ba(struct iwl_mvm *mvm,
 				       !vif->cfg.ps ||
 				       iwl_mvm_vif_low_latency(mvmvif));
 
-	return _iwl_mvm_enable_beacon_filter(mvm, vif, &cmd, 0);
+	return _iwl_mvm_enable_beacon_filter(mvm, vif, &cmd);
 }
 
 int iwl_mvm_power_update_ps(struct iwl_mvm *mvm)
-- 
2.34.1


