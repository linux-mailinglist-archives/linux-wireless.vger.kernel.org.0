Return-Path: <linux-wireless+bounces-24007-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E10AD5F0B
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 21:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5EB3A9100
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 19:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C08E2BDC24;
	Wed, 11 Jun 2025 19:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g+LtqAEp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75442BDC2D
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749670021; cv=none; b=M9yAoKrm4B7kFMkFSIDFbPN6vP57w/3VnCjNGCKfM7Wq89++Asq0YF9sKM4ytYfh0lb4CCOznGpsUiXxqfN2zaKkpArgacAJFP2YQg4y7C5073JXzuRsg+go28lF4uV4aQpfbVd2b3v1huUSnHCnaxWaA/HuT5I94nExkFes508=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749670021; c=relaxed/simple;
	bh=6+kO3llmm8Rq06zV6t1YaBhgDCLy2sKzPrl499p0uKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YHYPYRNoxO4PC5vSw4RPEhZbQA9jJZR0RaGx3wIYsYBAmOEsBI76rOOgMcm+cAVA+V7ris0keHfZVrasEo2adNeCjA0jKWs6BhytWlLyeVnza1v5qcjewVeuj1wQcvW5DyT9FkSmDXMRTjK7szFhJO9IEr/Mjx8lCzhgbhdCWcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g+LtqAEp; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749670020; x=1781206020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6+kO3llmm8Rq06zV6t1YaBhgDCLy2sKzPrl499p0uKg=;
  b=g+LtqAEpBpSFztJY6/RdAnjGEwSCl8Z1EYesUNXQabb93pP/+tpDdLRk
   OuxuO4WnUDRlJrzhHjbuX/g2RQL6mpv5FG3Tt9M9fO4Ct+tzJr1H/tRQT
   A+lfXklZiyRPSprz32c75vXMQyexfnC4lbS/5abedOgftte4154811nHf
   eYI3hwbtgW6xCLHqcNZkzwgfcF6HG51aOFfpjz5udZOzpy/PsU5S3aKU3
   Aiur+coSGOeNzqyE8LT+EvJQn7TxsJ4mILStfMugVPgQXG0BCyAcDdTHG
   RRq4eYq0rved0zjajCx5x7t0+qTqeNxT8B2VbFhEp7pqq5SI0wTE9Ij4P
   Q==;
X-CSE-ConnectionGUID: CZi1EZupQEWjPuE7PovNDA==
X-CSE-MsgGUID: qHOM0YMwSOOOz7XNzAG84w==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="74360888"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="74360888"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:27:00 -0700
X-CSE-ConnectionGUID: p6y21+I4SVqefW6Y7nVtow==
X-CSE-MsgGUID: 2kXL53hfQPqOvtxa8QFYRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="147165850"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:26:58 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next v2 07/15] wifi: iwlwifi: mld: remove special FW error resume handling
Date: Wed, 11 Jun 2025 22:26:26 +0300
Message-Id: <20250611222325.9e778f1bae0c.I96483b5236ab23141b45079464c73f93e0164e65@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611192634.2416885-1-miriam.rachel.korenblit@intel.com>
References: <20250611192634.2416885-1-miriam.rachel.korenblit@intel.com>
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


