Return-Path: <linux-wireless+bounces-6390-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B268A692B
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 12:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0222DB235A8
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 10:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2646D1BC;
	Tue, 16 Apr 2024 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nOFFZrlw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D91012838A
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264887; cv=none; b=JFnNBTTgQaDQ6OZcVuj5F0bTtvFb7vmV/XAKSy/d0geiOSeZIP8pxCx5RyHFzit0ePpPThR7RcukBWnOybhiI4VXW3WMA7zMeaIs4IKqnzj4P6SzSy9Q+TBsAMoEeRfzSDsuUqmYFH8g9T/B4iPkqy633qk31bIK0cYDJl/MFvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264887; c=relaxed/simple;
	bh=x/lcoARf5MEJ1oA41d6W+qXOAkz5KNqwXTugKUsV/hs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mSK3rBM8Fv/BaiOom8jglJLiq2o2yTvuUyZTRdRxLob6keOowVvNxW8TNrvzeaL9/MDrxSPgyUyPjVMHy+JvE0hbv+XOgCuLNUwfILpICXKNA1449tbsu+fo3ik+bvrx/9pMMY+kMf4XCy7b+M8EGpXwRQBOwWp4Y4r0No8onJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nOFFZrlw; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713264886; x=1744800886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x/lcoARf5MEJ1oA41d6W+qXOAkz5KNqwXTugKUsV/hs=;
  b=nOFFZrlwYERm+a6TmnReIZZU1dfqB9PoR9m03pRnBZl5B1PGFPQ7VjSD
   5RFXNatb+/8BJUFlmDDC+JcUwQhDecIPhlRarRzrXaz6JQY5havMIoJ6V
   61hTXB/zUs8DMwRiw4ad6w6r59gkBhxL+OFGhTdPQIner4PflhKXMezFh
   gdBhKSLdt7TGD0zNLEH+tGyo7w5JZfLs6CGhcaLP7YSj59x4WIYkEKZf6
   ocrhiiMYV/fFhao/gwS8barl8rHNcHCRGI3970IzJ5Zma1iEATBmH3LDk
   cyJHEapJNrucDri8nLf8WA0aFDjynIscndPkW+x+77Yzh8o+2zEm/N2Kl
   g==;
X-CSE-ConnectionGUID: rQZOl4/5SLG9/MpJs2R0rA==
X-CSE-MsgGUID: 5jd98TttRSSP+d9PbiGtqA==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8556066"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8556066"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:46 -0700
X-CSE-ConnectionGUID: oVNkfb4KSoqGbHhB8Ddb2Q==
X-CSE-MsgGUID: GgQApMIGTf6S687nJ3vU9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="26872576"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:45 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 13/16] wifi: iwlwifi: mvm: don't recompute EMLSR mode in can_activate_links
Date: Tue, 16 Apr 2024 13:54:08 +0300
Message-Id: <20240416134215.202cf5a9ef2c.I65e4698b730a8652ad8d1c01420aabb41a1d04fd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416105411.706221-1-miriam.rachel.korenblit@intel.com>
References: <20240416105411.706221-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

mac80211 invokes the driver callback drv_can_activate_links() from
ieee80211_set_active_links to verify it can activate the desired link
combination.
However, ieee80211_set_active_links is called with more than one link in
2 cases:
- After driver's link selection decided to enter EMLSR
- From debugfs, for testing purposes.
For both cases there is no need to recompute all the considerations
determining whether to activate EMLSR.
Instead, only check if the vif is not blocked for EMLSR.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  1 +
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 29 ++-----------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 11 ++-----
 3 files changed, 7 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 4bb71a14ac3b..9f343d015d81 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -518,6 +518,7 @@ unsigned int iwl_mvm_get_link_grade(struct ieee80211_bss_conf *link_conf)
 }
 EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mvm_get_link_grade);
 
+static
 u8 iwl_mvm_set_link_selection_data(struct ieee80211_vif *vif,
 				   struct iwl_mvm_link_sel_data *data,
 				   unsigned long usable_links,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 61f4c5dc3cec..4016aaf91e6e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1177,30 +1177,6 @@ bool iwl_mvm_esr_allowed_on_vif(struct iwl_mvm *mvm,
 	return !(mvmvif->esr_disable_reason & ~IWL_MVM_ESR_BLOCKED_COEX);
 }
 
-/*
- * This function receives a bitmap of usable links and check if we can enter
- * eSR on those links.
- */
-static bool iwl_mvm_can_enter_esr(struct iwl_mvm *mvm,
-				  struct ieee80211_vif *vif,
-				  unsigned long desired_links)
-{
-	struct iwl_mvm_link_sel_data data[IEEE80211_MLD_MAX_NUM_LINKS];
-	u8 best_link, n_data;
-
-	if (!iwl_mvm_esr_allowed_on_vif(mvm, vif))
-		return false;
-
-	n_data = iwl_mvm_set_link_selection_data(vif, data, desired_links,
-						 &best_link);
-
-	if (n_data != 2)
-		return false;
-
-
-	return iwl_mvm_mld_valid_link_pair(vif, &data[0], &data[1]);
-}
-
 static bool iwl_mvm_mld_can_activate_links(struct ieee80211_hw *hw,
 					   struct ieee80211_vif *vif,
 					   u16 desired_links)
@@ -1221,8 +1197,9 @@ static bool iwl_mvm_mld_can_activate_links(struct ieee80211_hw *hw,
 	}
 
 	/* If it is an eSR device, check that we can enter eSR */
-	if (iwl_mvm_is_esr_supported(mvm->fwrt.trans))
-		ret = iwl_mvm_can_enter_esr(mvm, vif, desired_links);
+	ret = iwl_mvm_is_esr_supported(mvm->fwrt.trans) &&
+	      iwl_mvm_esr_allowed_on_vif(mvm, vif);
+
 unlock:
 	mutex_unlock(&mvm->mutex);
 	return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 920fd0afbb59..0e0b8dae5284 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1992,23 +1992,18 @@ void iwl_mvm_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 u8 iwl_mvm_get_primary_link(struct ieee80211_vif *vif);
 u8 iwl_mvm_get_other_link(struct ieee80211_vif *vif, u8 link_id);
 
-#if IS_ENABLED(CONFIG_IWLWIFI_KUNIT_TESTS)
-unsigned int iwl_mvm_get_link_grade(struct ieee80211_bss_conf *link_conf);
-#endif
-
 struct iwl_mvm_link_sel_data {
 	u8 link_id;
 	enum nl80211_band band;
 	u16 grade;
 };
 
-u8 iwl_mvm_set_link_selection_data(struct ieee80211_vif *vif,
-				   struct iwl_mvm_link_sel_data *data,
-				   unsigned long usable_links,
-				   u8 *best_link_idx);
+#if IS_ENABLED(CONFIG_IWLWIFI_KUNIT_TESTS)
+unsigned int iwl_mvm_get_link_grade(struct ieee80211_bss_conf *link_conf);
 bool iwl_mvm_mld_valid_link_pair(struct ieee80211_vif *vif,
 				 const struct iwl_mvm_link_sel_data *a,
 				 const struct iwl_mvm_link_sel_data *b);
+#endif
 
 /* AP and IBSS */
 bool iwl_mvm_start_ap_ibss_common(struct ieee80211_hw *hw,
-- 
2.34.1


