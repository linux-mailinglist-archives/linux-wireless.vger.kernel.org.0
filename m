Return-Path: <linux-wireless+bounces-21892-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A96FA97F0A
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 08:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2694E3B2AEB
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 06:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79218267705;
	Wed, 23 Apr 2025 06:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WTgFgQOi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD58266EE0
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 06:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745389031; cv=none; b=dejqtvmtzy64IRf8Dgl5tvSH4Ic0twyMftfyf7OnP4AJSHX08bP6vcn/NjLEAAIHeJBdvEeI/iuzNPrWigJaju4mLIBXnD30CTO0/B75St4iUKEwkXSNx9VUqBapCQXEzaSed2eaQDikZWOZIVh3HyGHeqzLLhVrxwtnqtdoHxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745389031; c=relaxed/simple;
	bh=Jb2gI2CJjiJ7TgB+k45bMdVKf+tM4Kb2T1lEsVAkj+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KZW/w+qoOD1s92DIlJEeL4mnRDe+t7BxesWXCHQ1XgcKVO73HqrcV9JCYGULh6QArOj7UuF5wiaMf05eq0hpxDqCLiLfx95jL+il8qH80Pu+rHyk0tD+ppD7D/5uZg4rZQ3ORD7c9iVC5rDaHNvAxmLxnQeif+3VLV8SKG7obvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WTgFgQOi; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745389030; x=1776925030;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jb2gI2CJjiJ7TgB+k45bMdVKf+tM4Kb2T1lEsVAkj+A=;
  b=WTgFgQOiSQgKwjlVPPUMghq6bqxh3WncSB5v6Um5BFcMcvyUQhTiq8Ur
   sRPVDyyltTWFAoTub751x3dlw6DqZS9bA1P8NSkgMmvkWojCc0MeiYuyh
   sE2qPRYQzur1nU93zCbLHJ23OEwDn/w53v0j8MA22OJU2v2JusQabJzzr
   vH2ZOMZ4ywyv/ShEV1GzEZsd+mQVDn1b5N5+x+dNHdevoMH6SbgRNSxez
   fftECNfoN1iYUHhgrSdi/fwV4LrYe6Tq3B7UehlrPDliLgTtc7dM4BGjd
   FetC6emuYDzh8z+AfWrzn52oNJS3kC997jYAAjEhuWzexqy0GSzTzmXR/
   A==;
X-CSE-ConnectionGUID: S15fw4j4SH+9X+0kutcVkw==
X-CSE-MsgGUID: vMuUt09BQs+pF1doymIMzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46843648"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208,223";a="46843648"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:17:09 -0700
X-CSE-ConnectionGUID: wHLRISpCRc+RlKUH7iICCg==
X-CSE-MsgGUID: tCl5etpFSUee9aHL/H34Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208,223";a="163269081"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:17:08 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 11/15] wifi: iwlwifi: mld: properly handle async notification in op mode start
Date: Wed, 23 Apr 2025 09:16:37 +0300
Message-Id: <20250423091408.a8f63d983466.Ifd77d9c1a29fdd278b0a7bfc2709dd5d5e5efdb1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423061641.2302908-1-miriam.rachel.korenblit@intel.com>
References: <20250423061641.2302908-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From the moment that we have ALIVE, we can receive notification that
are handled asynchronously.

Some notifications (for example iwl_rfi_support_notif) requires an
operational FW. So we need to make sure that they were handled in
iwl_op_mode_mld_start before we stop the FW. Flush the async_handlers_wk
there to achieve that.

Also, if loading the FW in op mode start failed, we need to cancel
these notifications, as they are from a dead FW.

More than that, not doing so can cause us to access freed memory
if async_handlers_wk is executed after ieee80211_free_hw is called.

Fix this by canceling all async notifications if a failure occurred in
init (after ALIVE).

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c       | 2 ++
 drivers/net/wireless/intel/iwlwifi/mld/fw.c       | 5 +++++
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 5 -----
 drivers/net/wireless/intel/iwlwifi/mld/mld.c      | 5 +++++
 drivers/net/wireless/intel/iwlwifi/mld/mld.h      | 5 -----
 5 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index 5a7207accd86..7b21d5cf6568 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -1344,6 +1344,8 @@ int iwl_mld_no_wowlan_suspend(struct iwl_mld *mld)
 	if (ret) {
 		IWL_ERR(mld, "d3 suspend: trans_d3_suspend failed %d\n", ret);
 	} else {
+		/* Async notification might send hcmds, which is not allowed in suspend */
+		iwl_mld_cancel_async_notifications(mld);
 		mld->trans->system_pm_mode = IWL_PLAT_PM_MODE_D3;
 		mld->fw_status.in_d3 = true;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/fw.c b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
index 76bf83549407..14aacfbab5c8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
@@ -341,6 +341,11 @@ void iwl_mld_stop_fw(struct iwl_mld *mld)
 
 	iwl_trans_stop_device(mld->trans);
 
+	/* HW is stopped, no more coming RX. Cancel all notifications in
+	 * case they were sent just before stopping the HW.
+	 */
+	iwl_mld_cancel_async_notifications(mld);
+
 	mld->fw_status.running = false;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index e127f29839ea..1713d110e05c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -540,11 +540,6 @@ void iwl_mld_mac80211_stop(struct ieee80211_hw *hw, bool suspend)
 	if (!suspend || iwl_mld_no_wowlan_suspend(mld))
 		iwl_mld_stop_fw(mld);
 
-	/* HW is stopped, no more coming RX. Cancel all notifications in
-	 * case they were sent just before stopping the HW.
-	 */
-	iwl_mld_cancel_async_notifications(mld);
-
 	/* Clear in_hw_restart flag when stopping the hw, as mac80211 won't
 	 * execute the restart.
 	 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 2f5b6dc8bc62..562d320b2c3a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -428,6 +428,11 @@ iwl_op_mode_mld_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		goto free_hw;
 	}
 
+	/* We are about to stop the FW. Notifications may require an
+	 * operational FW, so handle them all here before we stop.
+	 */
+	wiphy_work_flush(mld->wiphy, &mld->async_handlers_wk);
+
 	iwl_mld_stop_fw(mld);
 
 	wiphy_unlock(mld->wiphy);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.h b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
index c436eb4a6a6f..a4a16da6ebf3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -298,11 +298,6 @@ iwl_cleanup_mld(struct iwl_mld *mld)
 #endif
 
 	iwl_mld_low_latency_restart_cleanup(mld);
-
-	/* Cancel the async notification handlers so we won't process
-	 * notifications from the dead fw after the reconfig flow.
-	 */
-	iwl_mld_cancel_async_notifications(mld);
 }
 
 enum iwl_power_scheme {
-- 
2.34.1


