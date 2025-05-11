Return-Path: <linux-wireless+bounces-22854-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 634F4AB29D1
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 18:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFDA918978F9
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 16:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4116B25C82E;
	Sun, 11 May 2025 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CItjucsY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFEC25DB01
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746982436; cv=none; b=QrVdwakay9Ki3XczefthqDjfQfxfLMDcCJmGfIW2HfTCI+isTx4f23BMdVZLT7WYZemWzJrh0GWljN77MZV8Vx+ZjC4OWJ7WXmbIPN3sLNl1se83cqVhkI3fkQX49BiLua/EOuH+L3wzWSzx+ac4Y8BoSEYYG6WXln7VOB0tLm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746982436; c=relaxed/simple;
	bh=rOJ/GxytdYnRx8Rf4f0UYqTZF3LgYSbn3WIcB0a/bBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pD1PNRHE2JBat+rf0aFxHCllxl+jhmzrGRG2sc99IBLNZm8/rc6Qprm7VPKT3c8w3tN1TXun3fNU4wWFfRTr7NfmZYlUcl8risTuVnvb+y00fEWCPiti60Ks/Gaee+z5HtYwzv/dlhRILqpQIwVh042Yg4gzSFc+ZuoBYQ1ZwAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CItjucsY; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746982435; x=1778518435;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rOJ/GxytdYnRx8Rf4f0UYqTZF3LgYSbn3WIcB0a/bBY=;
  b=CItjucsYSFt1q7m2VblPZXTARBCSgzklUL/25od2RPQYQRMBK69sWOsJ
   LIp2iSstvjN5l1rPUEaEJTBEbE1vQN/0RGlTShPXONtnzOzgh6ulXRQsa
   Ayfk4JTwzdFWgR/BPySCBuMsS1kdWoAQKFTtY8YST/gdxAKJb3tjAQraM
   P8NG1igsle7RworPiP0/PufUK9kuNgJQVS59IwDThRqYBjwzj/GEvuS5t
   ST9cjPjK7Zogz9PE8I3UKgJfDsKOUhTSl9YzGqCUday03ui4oAlH3XKny
   tDlfwjccbpUczh8ZR+jGBtSlkIyyH9S1+UCYjlnNG5bQQJC6q3oXpYhnc
   A==;
X-CSE-ConnectionGUID: pSmHTYkLTPGVNjSzlrnb4g==
X-CSE-MsgGUID: Intj+eqKTsCriQXXZ0q2UQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="52582709"
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="52582709"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:55 -0700
X-CSE-ConnectionGUID: /OawDVMzSbKdGmfbrBQVMg==
X-CSE-MsgGUID: WqNIlKX1SbW7LkhyK+m7Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="137655120"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:54 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: mld: allow 2 ROCs on the same vif
Date: Sun, 11 May 2025 19:53:21 +0300
Message-Id: <20250511195137.1f8c55198578.I17cb191596ed4e97a4854108f8ca5ca197662a62@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250511165321.590808-1-miriam.rachel.korenblit@intel.com>
References: <20250511165321.590808-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

In the current code, if an ROC is started on a vif that already has an
active ROC we reject it and warn.

But really there is no such limitation. The actual limitation is to not
have 2 ROCs of the same type simultaneously.

Add a helper function to find a vif that has an active ROC of a given
type, and only if one exist - reject the ROC.

This allows also to remove bss_roc_vif.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mld.h |  2 -
 drivers/net/wireless/intel/iwlwifi/mld/roc.c | 59 +++++++++++++++-----
 2 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.h b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
index 74fcaad85a32..1a2c44f44eff 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -127,7 +127,6 @@
  *	cleanup using iwl_mld_free_internal_sta
  * @netdetect: indicates the FW is in suspend mode with netdetect configured
  * @p2p_device_vif: points to the p2p device vif if exists
- * @bss_roc_vif: points to the BSS vif that has an active ROC.
  * @dev: pointer to device struct. For printing purposes
  * @trans: pointer to the transport layer
  * @cfg: pointer to the device configuration
@@ -213,7 +212,6 @@ struct iwl_mld {
 		bool netdetect;
 #endif /* CONFIG_PM_SLEEP */
 		struct ieee80211_vif *p2p_device_vif;
-		struct ieee80211_vif *bss_roc_vif;
 		struct iwl_bt_coex_profile_notif last_bt_notif;
 	);
 	struct ieee80211_link_sta __rcu *fw_id_to_link_sta[IWL_STATION_COUNT_MAX];
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/roc.c b/drivers/net/wireless/intel/iwlwifi/mld/roc.c
index 944d70901de5..e85f45bce79a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/roc.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/roc.c
@@ -31,6 +31,47 @@ iwl_mld_vif_iter_emlsr_block_roc(void *data, u8 *mac, struct ieee80211_vif *vif)
 		*result = ret;
 }
 
+struct iwl_mld_roc_iter_data {
+	enum iwl_roc_activity activity;
+	struct ieee80211_vif *vif;
+	bool found;
+};
+
+static void iwl_mld_find_roc_vif_iter(void *data, u8 *mac,
+				      struct ieee80211_vif *vif)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct iwl_mld_roc_iter_data *roc_data = data;
+
+	if (mld_vif->roc_activity != roc_data->activity)
+		return;
+
+	/* The FW supports one ROC of each type simultaneously */
+	if (WARN_ON(roc_data->found)) {
+		roc_data->vif = NULL;
+		return;
+	}
+
+	roc_data->found = true;
+	roc_data->vif = vif;
+}
+
+static struct ieee80211_vif *
+iwl_mld_find_roc_vif(struct iwl_mld *mld, enum iwl_roc_activity activity)
+{
+	struct iwl_mld_roc_iter_data roc_data = {
+		.activity = activity,
+		.found = false,
+	};
+
+	ieee80211_iterate_active_interfaces_mtx(mld->hw,
+						IEEE80211_IFACE_ITER_NORMAL,
+						iwl_mld_find_roc_vif_iter,
+						&roc_data);
+
+	return roc_data.vif;
+}
+
 int iwl_mld_start_roc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		      struct ieee80211_channel *channel, int duration,
 		      enum ieee80211_roc_type type)
@@ -73,10 +114,8 @@ int iwl_mld_start_roc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		activity = ROC_ACTIVITY_HOTSPOT;
 	}
 
-	if (WARN_ON(mld_vif->roc_activity != ROC_NUM_ACTIVITIES))
-		return -EBUSY;
-
-	if (vif->type == NL80211_IFTYPE_STATION && mld->bss_roc_vif)
+	/* The FW supports one ROC of each type simultaneously */
+	if (WARN_ON(iwl_mld_find_roc_vif(mld, activity)))
 		return -EBUSY;
 
 	ieee80211_iterate_active_interfaces_mtx(mld->hw,
@@ -109,9 +148,6 @@ int iwl_mld_start_roc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	mld_vif->roc_activity = activity;
 
-	if (vif->type == NL80211_IFTYPE_STATION)
-		mld->bss_roc_vif = vif;
-
 	return 0;
 }
 
@@ -130,9 +166,6 @@ static void iwl_mld_destroy_roc(struct iwl_mld *mld,
 {
 	mld_vif->roc_activity = ROC_NUM_ACTIVITIES;
 
-	if (vif->type == NL80211_IFTYPE_STATION)
-		mld->bss_roc_vif = NULL;
-
 	ieee80211_iterate_active_interfaces_mtx(mld->hw,
 						IEEE80211_IFACE_ITER_NORMAL,
 						iwl_mld_vif_iter_emlsr_unblock_roc,
@@ -203,11 +236,7 @@ void iwl_mld_handle_roc_notif(struct iwl_mld *mld,
 	struct iwl_mld_vif *mld_vif;
 	struct ieee80211_vif *vif;
 
-	if (activity == ROC_ACTIVITY_HOTSPOT)
-		vif = mld->bss_roc_vif;
-	else
-		vif = mld->p2p_device_vif;
-
+	vif = iwl_mld_find_roc_vif(mld, activity);
 	if (WARN_ON(!vif))
 		return;
 
-- 
2.34.1


