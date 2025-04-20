Return-Path: <linux-wireless+bounces-21758-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E69A946DE
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Apr 2025 09:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866271897076
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Apr 2025 07:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A38D18C33B;
	Sun, 20 Apr 2025 07:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lo2HsJey"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F121D1C3F02
	for <linux-wireless@vger.kernel.org>; Sun, 20 Apr 2025 07:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745132424; cv=none; b=P3DkqhAncI4wUympnAAhizL9O8vLwvmSyzT+ao5IfZ02tecd1NThzdPowRwieRWJbq0pczvsrZ70cCzdFSpXRaqPbd0iGbwV/zRt9zhE2YWwTJ3cZwOskR3+06avx+vH2okffMg5bCmyDYyaybEyZgv3zQKDkd1kcK9iwPPppwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745132424; c=relaxed/simple;
	bh=dOhx4MEXmT6CUoQwt2TGQsWGQ8Xv88m/9ZrpOetM2/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LBzSp1+Wt1XF+D819qihNlJGMzKriv9AaS7VnVSvQHF9WxLz0GZUNRXa0hZr61IUg5urNB9zj8WMOSafioWSzRL0Yx8z2NhDdVbmQFDnGmAdO4bFA+8YnUdlhEhdHud1i3uNJuL73KB9xbMiKeS5Y0f4bmvISBmlvPWlAeBIb+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lo2HsJey; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745132419; x=1776668419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dOhx4MEXmT6CUoQwt2TGQsWGQ8Xv88m/9ZrpOetM2/4=;
  b=lo2HsJeykVQf6SVscs/AKnPyvrG6Yc9c6benKqNsPyaBRGxKr/3kXJbQ
   xiCNa+aeA37oIs0Bl3ph5Ocs6BJMQqm4ntlVweMJkMql0j5ZOo38/PEwe
   hKXDDlH5q0CaNhc0nVwnVCdp3VPO0Ki+F8uMsoHe4BQE7+g7XffaDVo0O
   e3mUPSIIO+hFqchjtf1lbmOxVary5to/gm0a+WxWSknx8MlSW8/CNQ8t6
   RllnwesWquWZnmSkILqsOAdVhvTpfIezp5GHkxKMryoEFwXWeGOb8xYB0
   Qnf6AlKlKhYnF9iJkqy4wn0224+PrQLuAfHa75zWETM3lrPZ16/FriXKd
   g==;
X-CSE-ConnectionGUID: zmbzn47mRN+nAgWIhSMyUQ==
X-CSE-MsgGUID: NNoLD1oeSNy1L1PvXNERGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11408"; a="46827881"
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208,223";a="46827881"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 00:00:16 -0700
X-CSE-ConnectionGUID: bt7eSfLCQW2O+Gkla17T7g==
X-CSE-MsgGUID: fVcFieUHQmqJcotMLgO1FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208,223";a="154615705"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 00:00:15 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless 1/7] wifi: iwlwifi: mld: properly handle async notification in op mode start
Date: Sun, 20 Apr 2025 09:59:55 +0300
Message-Id: <20250420095642.1a8579662437.Ifd77d9c1a29fdd278b0a7bfc2709dd5d5e5efdb1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250420070001.3406977-1-miriam.rachel.korenblit@intel.com>
References: <20250420070001.3406977-1-miriam.rachel.korenblit@intel.com>
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

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/fw.c  | 13 ++++++++++---
 drivers/net/wireless/intel/iwlwifi/mld/mld.c |  5 +++++
 drivers/net/wireless/intel/iwlwifi/mld/mld.h |  5 -----
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/fw.c b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
index 62da137e1024..4b083d447ee2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
@@ -333,19 +333,22 @@ int iwl_mld_load_fw(struct iwl_mld *mld)
 
 	ret = iwl_trans_start_hw(mld->trans);
 	if (ret)
-		return ret;
+		goto err;
 
 	ret = iwl_mld_run_fw_init_sequence(mld);
 	if (ret)
-		return ret;
+		goto err;
 
 	ret = iwl_mld_init_mcc(mld);
 	if (ret)
-		return ret;
+		goto err;
 
 	mld->fw_status.running = true;
 
 	return 0;
+err:
+	iwl_mld_stop_fw(mld);
+	return ret;
 }
 
 void iwl_mld_stop_fw(struct iwl_mld *mld)
@@ -358,6 +361,10 @@ void iwl_mld_stop_fw(struct iwl_mld *mld)
 
 	iwl_trans_stop_device(mld->trans);
 
+	wiphy_work_cancel(mld->wiphy, &mld->async_handlers_wk);
+
+	iwl_mld_purge_async_handlers_list(mld);
+
 	mld->fw_status.running = false;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index d4a99ae64074..cfdf52b43c68 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -417,6 +417,11 @@ iwl_op_mode_mld_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
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
index 5eceaaf7696d..a4a16da6ebf3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -298,11 +298,6 @@ iwl_cleanup_mld(struct iwl_mld *mld)
 #endif
 
 	iwl_mld_low_latency_restart_cleanup(mld);
-
-	/* Empty the list of async notification handlers so we won't process
-	 * notifications from the dead fw after the reconfig flow.
-	 */
-	iwl_mld_purge_async_handlers_list(mld);
 }
 
 enum iwl_power_scheme {
-- 
2.34.1


