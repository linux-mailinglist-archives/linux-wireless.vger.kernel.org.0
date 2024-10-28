Return-Path: <linux-wireless+bounces-14589-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1E39B2F5C
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 12:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603DF1C20BAA
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 11:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BB71D5CE0;
	Mon, 28 Oct 2024 11:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l0xkJJPK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD801D5CC5
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 11:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116522; cv=none; b=slAlZ24cvd7JmZL6lyUR7S2YoGVrjVt9ejy6V4pwi+jxNF6ODukGv9sQcbJKhd2DAgp13HznmGGJDhngJQ2rs+RszFirtZnwcBnFXb3EZf/DSWFfVm2mE7B6WOWZrS+hDQutzeklf/oIF3KWjtJdRUo7HXMQHbhpy6VAnvrK+oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116522; c=relaxed/simple;
	bh=nuA2GhGMhX8enCfOse7WkrGSD2WpoiXSjQ5Jkwz46LY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OBSQLlW8oMKheebTwDYKaAr4FQ16/yjk//FuBNEN/EQUpa3mn7KItFrVimAMiJY0rLOeQLdhMNWSYnoHW7hXKqb70iXsbKW7kVDZzFkbkQSILNRH3enZf8YcMWIE8QhopTMR0t2RvfLm76awKfHXyJ1NJ33iHCuvBmpuwIQpo58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l0xkJJPK; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730116520; x=1761652520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nuA2GhGMhX8enCfOse7WkrGSD2WpoiXSjQ5Jkwz46LY=;
  b=l0xkJJPKXl/R3SvT6MCnBXmq5lhoP0D+nCmAHisGtjoJFd9BC3ZS3ReL
   FL6PvdqHcn93BBXHqmkBr6/wruyuAqCw/W893HhiP4CDk3sA2aEqNicbY
   sYJmnCjlCwUD3u3Fr9D6bpWtwEivqS1C8T51phgLmlK2Xah0h24w0tmFD
   II0rcXclJRiu2K1eti5OlmGI35et/L0ZWRwh04C1zl5CkSP+uJcsq8UqZ
   fSX1I5pUUPc8hlJ9ux5gyuO9bDzhDO1r3OXUFNYhPUVQBwMy5wRxLIQN7
   ca14ebRahwLIzoWAvAFLMb3oN7uk9f5a05GmV6MPlZvvvdhWtpx2Bjp4T
   A==;
X-CSE-ConnectionGUID: 81+Xv4ZqSWmXxIWURvNQ4g==
X-CSE-MsgGUID: Grx2WJTNQfaMJS4mXsmKZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29813873"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="29813873"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:20 -0700
X-CSE-ConnectionGUID: +hEoB9kET/us+whAzWsUwg==
X-CSE-MsgGUID: f6ZoxahwSkKrq6iDp4XfwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="112432568"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:18 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 02/15] wifi: iwlwifi: mvm: unify link info initialization
Date: Mon, 28 Oct 2024 13:54:47 +0200
Message-Id: <20241028135215.ab963cc90e56.Ice5cf66dec8351f8e94ca4c5b3a27e9311d0c20a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028115500.351123-1-miriam.rachel.korenblit@intel.com>
References: <20241028115500.351123-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Move the link info initialization to a common function so
that it can be modified more easily later.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c         | 11 +++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c     |  9 ++-------
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 10 +---------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h          |  1 +
 4 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 628baf67b208..492e0da553ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -1167,3 +1167,14 @@ void iwl_mvm_unblock_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (!mvmvif->esr_disable_reason)
 		iwl_mvm_esr_unblocked(mvm, vif);
 }
+
+void iwl_mvm_init_link(struct iwl_mvm_vif_link_info *link)
+{
+	link->bcast_sta.sta_id = IWL_MVM_INVALID_STA;
+	link->mcast_sta.sta_id = IWL_MVM_INVALID_STA;
+	link->ap_sta_id = IWL_MVM_INVALID_STA;
+
+	for (int r = 0; r < NUM_IWL_MVM_SMPS_REQ; r++)
+		link->smps_requests[r] =
+			IEEE80211_SMPS_AUTOMATIC;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 9a43df49493f..c8bc26380b4a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -216,7 +216,7 @@ int iwl_mvm_mac_ctxt_init(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 		.preferred_tsf = NUM_TSF_IDS,
 		.found_vif = false,
 	};
-	int ret, i;
+	int ret;
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -298,9 +298,7 @@ int iwl_mvm_mac_ctxt_init(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	mvmvif->time_event_data.id = TE_MAX;
 	mvmvif->roc_activity = ROC_NUM_ACTIVITIES;
 
-	mvmvif->deflink.bcast_sta.sta_id = IWL_MVM_INVALID_STA;
-	mvmvif->deflink.mcast_sta.sta_id = IWL_MVM_INVALID_STA;
-	mvmvif->deflink.ap_sta_id = IWL_MVM_INVALID_STA;
+	iwl_mvm_init_link(&mvmvif->deflink);
 
 	/* No need to allocate data queues to P2P Device MAC and NAN.*/
 	if (vif->type == NL80211_IFTYPE_P2P_DEVICE)
@@ -316,9 +314,6 @@ int iwl_mvm_mac_ctxt_init(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 		mvmvif->deflink.cab_queue = IWL_MVM_DQA_GCAST_QUEUE;
 	}
 
-	for (i = 0; i < NUM_IWL_MVM_SMPS_REQ; i++)
-		mvmvif->deflink.smps_requests[i] = IEEE80211_SMPS_AUTOMATIC;
-
 	return 0;
 
 exit_fail:
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index a5c38f389c69..4acfa6c3844f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1161,8 +1161,6 @@ iwl_mvm_mld_change_vif_links(struct ieee80211_hw *hw,
 	int err, i;
 
 	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
-		int r;
-
 		if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
 			break;
 
@@ -1174,14 +1172,8 @@ iwl_mvm_mld_change_vif_links(struct ieee80211_hw *hw,
 			goto free;
 		}
 
-		new_link[i]->bcast_sta.sta_id = IWL_MVM_INVALID_STA;
-		new_link[i]->mcast_sta.sta_id = IWL_MVM_INVALID_STA;
-		new_link[i]->ap_sta_id = IWL_MVM_INVALID_STA;
 		new_link[i]->fw_link_id = IWL_MVM_FW_LINK_ID_INVALID;
-
-		for (r = 0; r < NUM_IWL_MVM_SMPS_REQ; r++)
-			new_link[i]->smps_requests[r] =
-				IEEE80211_SMPS_AUTOMATIC;
+		iwl_mvm_init_link(new_link[i]);
 	}
 
 	mutex_lock(&mvm->mutex);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 5d85661e01f5..9d3072ac8c58 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2105,6 +2105,7 @@ int iwl_mvm_binding_remove_vif(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 u32 iwl_mvm_get_lmac_id(struct iwl_mvm *mvm, enum nl80211_band band);
 
 /* Links */
+void iwl_mvm_init_link(struct iwl_mvm_vif_link_info *link);
 int iwl_mvm_set_link_mapping(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			     struct ieee80211_bss_conf *link_conf);
 int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-- 
2.34.1


