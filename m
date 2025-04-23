Return-Path: <linux-wireless+bounces-21871-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF97DA97E54
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 07:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF5A17E270
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 05:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEAE266B65;
	Wed, 23 Apr 2025 05:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hCUSkA1f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF61726738C
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 05:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387467; cv=none; b=bROL7htk6JK8kxD91WVxbd/zHDfKegfbgsPZG4sIppzMmnLKhNfm1NGV+r5sdpHjrLhJRFQwipirBoTIGYC1CbgxktdIRPpXYjdUA+5sLYDaCd3k3mIA+oX0WC1fzoQKOsUj1PhomsCsWCGCpADpzaD9D73Qxy1bkotxu+l/cUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387467; c=relaxed/simple;
	bh=Jb2gI2CJjiJ7TgB+k45bMdVKf+tM4Kb2T1lEsVAkj+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m2iYuy46o6ZEvGZxb2Rsas8e/YxDvuKwyFWk1Gj3js9JcqnddTFjlS+HsKX8a2hoFAGIkzwb+xXpckVx8Yv7n0qzikkmRnvFotRTp5OnU97ypMFkYrpSLzZ9adZd5ST/QUHtDUb99ehfofcb88sk4INkg8YneE5TssN3e2HiLiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hCUSkA1f; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745387466; x=1776923466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jb2gI2CJjiJ7TgB+k45bMdVKf+tM4Kb2T1lEsVAkj+A=;
  b=hCUSkA1fdcdzw0OkirqkkthlSgpimHxHOc954EB/mA81ogdkNL/sfj6m
   PnVWrZJmsALFM9wZtOIffAjVZmzbwa0QYNKF4/IhFghFv7VaJKQtrH9i7
   Qs9HZu7w8IeAqpYeUlAtJTP81z4uOR51h8aQgdKJ1ijEy22CBstSLvhWe
   /JLlA2AJYDv6JxcKrn2p0MB74P+uCXx2LfAFsWHl5P2D64uvr9bwrIo4X
   ZBZeGskwKFqdkbcpnNJKR0YUXleLAdS9zf81Fn5ASV8qjNF++VdAip67M
   RH9NBrRTMdbAUS9JX+mo5HAWn2dPZkjwLO8GP8Z4X9FF13MIL+y0dC/p/
   g==;
X-CSE-ConnectionGUID: ql4h5vGuTn+8vLkD3xDX1A==
X-CSE-MsgGUID: 388MlxFHSo2emS3Ky5ULnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46844637"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208,223";a="46844637"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:51:05 -0700
X-CSE-ConnectionGUID: qXL/pcDERmC+ob6nIlxxsA==
X-CSE-MsgGUID: oXUkSAsHQ0WNWBb9elsngw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208,223";a="133164347"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:51:04 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless 11/17] wifi: iwlwifi: mld: properly handle async notification in op mode start
Date: Wed, 23 Apr 2025 08:50:30 +0300
Message-Id: <20250423084826.a8f63d983466.Ifd77d9c1a29fdd278b0a7bfc2709dd5d5e5efdb1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423055036.2262960-1-miriam.rachel.korenblit@intel.com>
References: <20250423055036.2262960-1-miriam.rachel.korenblit@intel.com>
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


