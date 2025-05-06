Return-Path: <linux-wireless+bounces-22686-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A778AAACE3A
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 21:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139E34E69D9
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 19:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD64D20B80C;
	Tue,  6 May 2025 19:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j7VByu4o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37559218E96
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 19:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560493; cv=none; b=Xe6ymRLsDfldz6aKV5Lc5HQCQjidRMo7QQgKOth19SrFxpcfuX4J0poMQjlZPRh7Bf830nwJvmyDi7piOPqz630WaHwkLO1mWQXi5wrk9ieY6P3kiZN5pamIfYtQQggstt/3EXc836Eh+pcTSz380Ui/HqHP1+JjB4sM2SsJmQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560493; c=relaxed/simple;
	bh=sfqyLef7RbYQ4TegfOfHQ4mM1WiU2tsqfjz/7Rtj474=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ty1UroZC9DatwSLqAsEWQ8pxzswBQGPAD+89H7t3KtzVBW/wrigu96CkpNHDp1cPVWUXhheA2ItxSmbsb0/NiW9MB/mseIeH+pIaBO1ge26o9SAYeleiUMw24ry2eX3Qle0VQJu3hVgJkbpVnhnL1ZPOhYBKcokpSDCYfcbkNNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j7VByu4o; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746560493; x=1778096493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sfqyLef7RbYQ4TegfOfHQ4mM1WiU2tsqfjz/7Rtj474=;
  b=j7VByu4oPhHBog/nvBPRIm+FoWRcwGfpHZ5Mt107W0T9HjeFPqWNWeLf
   BKSnCUBAjGTeHMxbC26UaMDYTRJIAeQjgtkNFo9haEe6HjvLPOvHsCN0y
   dbypUP+Mwj6B6pPdgoX+V2S9mlSYVgpCc+27v0uhYCMjDxIk2feqc9KdR
   NilKVeirNb3RLcOHr+8OTWa/1QR8ep2Qx6tW2uJrL//invhCiKuEupblI
   LOMguwFm87j9YsR+1hwYFgP6PuuiIPj3IbuK9/AsjVIr94WhhGiSTarby
   O/28d6w0TufLWqb5mkkk/mGrqWcl1CXPcIGSVD5ztcmO4iKzTfTDYITMY
   g==;
X-CSE-ConnectionGUID: sXjutg4OSFi2YQnwPRurSA==
X-CSE-MsgGUID: 4F29KRXESdm43naED+2KGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="47961660"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="47961660"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:33 -0700
X-CSE-ConnectionGUID: FAE4KEeSSRytUJ32GGxjVw==
X-CSE-MsgGUID: ZRoc8STiRUiDdfI3Qohv6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="140465489"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:31 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: mld: call thermal exit without wiphy lock held
Date: Tue,  6 May 2025 22:40:58 +0300
Message-Id: <20250506194102.3407967-12-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250506194102.3407967-1-miriam.rachel.korenblit@intel.com>
References: <20250506194102.3407967-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The driver must not hold the wiphy mutex when unregistering the thermal
devices. Do not hold the lock for the call to iwl_mld_thermal_exit and
only do a lock/unlock to cancel the ct_kill_exit_wk work.

The problem is that iwl_mld_tzone_get_temp needs to take the wiphy lock
while the thermal code is holding its own locks already. When
unregistering the device, the reverse would happen as the driver was
calling thermal_cooling_device_unregister with the wiphy mutex already
held.

It is not likely to trigger this deadlock as it can only happen if the
thermal code is polling the temperature while the driver is being
unloaded. However, lockdep reported it so fix it.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250506223834.30afd080a8a4.I700d0bfef9ff014c19b3e93cb0656195c26b1544@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mld.c     | 3 ++-
 drivers/net/wireless/intel/iwlwifi/mld/thermal.c | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 2c15af7b8768..3e3af7d23b52 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -489,8 +489,9 @@ iwl_op_mode_mld_stop(struct iwl_op_mode *op_mode)
 	iwl_mld_ptp_remove(mld);
 	iwl_mld_leds_exit(mld);
 
-	wiphy_lock(mld->wiphy);
 	iwl_mld_thermal_exit(mld);
+
+	wiphy_lock(mld->wiphy);
 	iwl_mld_low_latency_stop(mld);
 	iwl_mld_deinit_time_sync(mld);
 	wiphy_unlock(mld->wiphy);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/thermal.c b/drivers/net/wireless/intel/iwlwifi/mld/thermal.c
index 3232b31f4b0e..f8a8c35066be 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/thermal.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/thermal.c
@@ -441,6 +441,8 @@ static u32 iwl_mld_ctdp_get_max_budget(struct iwl_mld *mld)
 
 void iwl_mld_thermal_initialize(struct iwl_mld *mld)
 {
+	lockdep_assert_not_held(&mld->wiphy->mtx);
+
 	wiphy_delayed_work_init(&mld->ct_kill_exit_wk, iwl_mld_exit_ctkill);
 
 	mld->power_budget_mw = iwl_mld_ctdp_get_max_budget(mld);
@@ -454,7 +456,9 @@ void iwl_mld_thermal_initialize(struct iwl_mld *mld)
 
 void iwl_mld_thermal_exit(struct iwl_mld *mld)
 {
+	wiphy_lock(mld->wiphy);
 	wiphy_delayed_work_cancel(mld->wiphy, &mld->ct_kill_exit_wk);
+	wiphy_unlock(mld->wiphy);
 
 #ifdef CONFIG_THERMAL
 	iwl_mld_cooling_device_unregister(mld);
-- 
2.34.1


