Return-Path: <linux-wireless+bounces-23964-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 440DFAD496B
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 05:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067DF189C0AA
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 03:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54500220F33;
	Wed, 11 Jun 2025 03:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gnf6Xq+3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BBF21B9D3
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 03:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749612882; cv=none; b=BhX6//TffRj8UAyMI7bgMjBMexq6fZK/mhy5wBqBW+ndibXz7FuFSGvgJq4e/men+MSsIs0HHT+1eH6MrMuVnHUvvvzm/P72z8OPtfCfNz0OKYBk2QSEftgmEZH5WmsfdT0hGjPPtxLeC+tqAIQAAMYrkQe4ljPDQwpJRIoQDYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749612882; c=relaxed/simple;
	bh=6+kO3llmm8Rq06zV6t1YaBhgDCLy2sKzPrl499p0uKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HzJ6Uxnb3sXH3E6C/7tMV9uaGrxUPIjKp64ZXlzzcErbE8p29vs5/O4a1woXePTjDsgACfq9kciJIj6VQjxa/2O4IW8g0WLd7vmWaFKfJ9g6mw+4ALHD0hQgQC0LspLxlBy7xHdonadEZwdgjxIx7MWDS/J5902eUW+2MZIZkiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gnf6Xq+3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749612881; x=1781148881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6+kO3llmm8Rq06zV6t1YaBhgDCLy2sKzPrl499p0uKg=;
  b=Gnf6Xq+3uOBtEztY6t6kC8y9JpGK6byA12GJDXKWqSe/n0+hYuYX6tNH
   mSZ3YtU1aWzBCR2rfU0C6j32po6u9mAqX3R+ssnIHTiI8SYjchNX/4Bqo
   J0fDW5WvEstlI9GXar1GU/jR5kn2c06D+iXdovcp8Gq6LDs6JoUI0gJj3
   467Iq6ijdNmWs5kch3hHqRWEOm5C/TkQAmsm4Qh9ao5v72kUY/nV1erK0
   LLuJNlPaNnVDVuJcMdUvofN5lYj4PybJivEeKWaQjo254UylT1hcvwFvH
   nDZDVWlU1ptPZX0eU4lH8fJRa80elqPG5cSf/0jNwHRX7D5eK4YsIfRQ0
   A==;
X-CSE-ConnectionGUID: +evd9LU6TWyX3zl41g9HPQ==
X-CSE-MsgGUID: d52SMPtmTHyZozQfE5axLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="63094891"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="63094891"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 20:34:40 -0700
X-CSE-ConnectionGUID: N5mVt6srQ4KrmsjfXHx72w==
X-CSE-MsgGUID: mGvD2ku7RTO8afrURH3PtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="150880940"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 20:34:39 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: mld: remove special FW error resume handling
Date: Wed, 11 Jun 2025 06:34:07 +0300
Message-Id: <20250611063124.9e778f1bae0c.I96483b5236ab23141b45079464c73f93e0164e65@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611033415.1175681-1-miriam.rachel.korenblit@intel.com>
References: <20250611033415.1175681-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The (applicable) firmware versions will send an error interrupt as
part of the resume process, so there's no need now to check for it
explicitly. Simplify the code. This also fixes an issue where any
dump taken during the resume isn't able to do the reset handshake
as part of the dump (since interrupts are disabled) and then there
isn't all the correct data and we get more errors later.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c   | 72 +------------------
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  9 ++-
 2 files changed, 10 insertions(+), 71 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index d450d24689f6..b156cf56a30d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -204,66 +204,6 @@ void iwl_mld_ipv6_addr_change(struct ieee80211_hw *hw,
 }
 #endif
 
-enum rt_status {
-	FW_ALIVE,
-	FW_NEEDS_RESET,
-	FW_ERROR,
-};
-
-static enum rt_status iwl_mld_check_err_tables(struct iwl_mld *mld,
-					       struct ieee80211_vif *vif)
-{
-	u32 err_id;
-
-	/* check for lmac1 error */
-	if (iwl_fwrt_read_err_table(mld->trans,
-				    mld->trans->dbg.lmac_error_event_table[0],
-				    &err_id)) {
-		if (err_id == RF_KILL_INDICATOR_FOR_WOWLAN && vif) {
-			struct cfg80211_wowlan_wakeup wakeup = {
-				.rfkill_release = true,
-			};
-			ieee80211_report_wowlan_wakeup(vif, &wakeup,
-						       GFP_KERNEL);
-
-			return FW_NEEDS_RESET;
-		}
-		return FW_ERROR;
-	}
-
-	/* check if we have lmac2 set and check for error */
-	if (iwl_fwrt_read_err_table(mld->trans,
-				    mld->trans->dbg.lmac_error_event_table[1],
-				    NULL))
-		return FW_ERROR;
-
-	/* check for umac error */
-	if (iwl_fwrt_read_err_table(mld->trans,
-				    mld->trans->dbg.umac_error_event_table,
-				    NULL))
-		return FW_ERROR;
-
-	return FW_ALIVE;
-}
-
-static bool iwl_mld_fw_needs_restart(struct iwl_mld *mld,
-				     struct ieee80211_vif *vif)
-{
-	enum rt_status rt_status = iwl_mld_check_err_tables(mld, vif);
-
-	if (rt_status == FW_ALIVE)
-		return false;
-
-	if (rt_status == FW_ERROR) {
-		IWL_ERR(mld, "FW Error occurred during suspend\n");
-		iwl_fwrt_dump_error_logs(&mld->fwrt);
-		iwl_dbg_tlv_time_point(&mld->fwrt,
-				       IWL_FW_INI_TIME_POINT_FW_ASSERT, NULL);
-	}
-
-	return true;
-}
-
 static int
 iwl_mld_netdetect_config(struct iwl_mld *mld,
 			 struct ieee80211_vif *vif,
@@ -1383,10 +1323,7 @@ int iwl_mld_no_wowlan_resume(struct iwl_mld *mld)
 	mld->fw_status.in_d3 = false;
 	iwl_fw_dbg_read_d3_debug_data(&mld->fwrt);
 
-	if (iwl_mld_fw_needs_restart(mld, NULL))
-		ret = -ENODEV;
-	else
-		ret = iwl_mld_wait_d3_notif(mld, &resume_data, false);
+	ret = iwl_mld_wait_d3_notif(mld, &resume_data, false);
 
 	if (!ret && (resume_data.d3_end_flags & IWL_D0I3_RESET_REQUIRE))
 		return -ENODEV;
@@ -1935,15 +1872,10 @@ int iwl_mld_wowlan_resume(struct iwl_mld *mld)
 
 	iwl_fw_dbg_read_d3_debug_data(&mld->fwrt);
 
-	if (iwl_mld_fw_needs_restart(mld, bss_vif)) {
-		fw_err = true;
-		goto err;
-	}
-
 	resume_data.wowlan_status = kzalloc(sizeof(*resume_data.wowlan_status),
 					    GFP_KERNEL);
 	if (!resume_data.wowlan_status)
-		return -1;
+		return -ENOMEM;
 
 	if (mld->netdetect)
 		resume_data.notifs_expected |= IWL_D3_ND_MATCH_INFO;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 9b4bdbf40d4d..0f156e868504 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -508,8 +508,15 @@ int iwl_mld_mac80211_start(struct ieee80211_hw *hw)
 	if (in_d3) {
 		/* mac80211 already cleaned up the state, no need for cleanup */
 		ret = iwl_mld_no_wowlan_resume(mld);
-		if (ret)
+		if (ret) {
 			iwl_mld_stop_fw(mld);
+			/* We're not really restarting in the sense of
+			 * in_hw_restart even if we got an error during
+			 * this. We'll just start again below and have
+			 * nothing to recover, mac80211 will do anyway.
+			 */
+			mld->fw_status.in_hw_restart = false;
+		}
 	}
 #endif /* CONFIG_PM_SLEEP */
 
-- 
2.34.1


