Return-Path: <linux-wireless+bounces-21870-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77398A97E53
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 07:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A80C4168E19
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 05:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722B1266B4C;
	Wed, 23 Apr 2025 05:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SZ2zGEYl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CECB26462C
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 05:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387467; cv=none; b=uhkH1LtRstUZ9fWkzHxHBz1C7Z9fblSjEUr8pdxcM5W3TdVlfiNzEwm7nsEJTQkP1+It2acqWI8wUYgM08tg2VdNW3jhdhrOrOGGAzslg+cMCN3t8bDCwGx3g/NKaHc0hQxWQawJ8gf8ghU7I9pfuG0Cy+DRkOFOOG2l85YyFeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387467; c=relaxed/simple;
	bh=my1n6X125pRxeSgwvG3O82GWFlZ1PI6UkcptXzh6dOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A7ueWhLO1VDrXyCGc1rwI9EaItdeqkP7wKrm6XPun7FgK+PjQGyZB/L5Ju2AkEoW18CjHS+SmwFgthzOlncgTyoUoTaW3WOIPuhMxCZb4X1ITEo08l0sqgQGWQ2J2d4AtLUEq902aGK1TxEfmlm7RuQbz0R1TvgTGH+GcaRzhtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SZ2zGEYl; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745387464; x=1776923464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=my1n6X125pRxeSgwvG3O82GWFlZ1PI6UkcptXzh6dOY=;
  b=SZ2zGEYlQ4km0HqIqFH82RH0cpogD4yMCK/x1X0qqH4062kaWg2ianHU
   cO32dnTmBy/a4GuG20EXe3S51w8sI168ZZ2bO6SZGO53pmKTUxaTn7fmc
   qmWpHc3doRzl6zI8sVbVAlnQUwI3pumeJepvXG5QcSwwA1BGefhO1+psf
   mBDrGn7Z3kuWklAMWb3yoN9lIBtjMMq9nmzTdxyRsBlrjuezPrA2rzHyl
   dvlcb6KpPzq/oC4LntGayut2H25rAIqI37qM/nD3ezNO1c2JmPCvrItvO
   3r5IYsmAYLSIGwnbVkrrWr0Ohl8q89t99dlYBfn7O4sMsZagxc83GWLXo
   A==;
X-CSE-ConnectionGUID: PpjvlIfWSSKI5weS+5+s+A==
X-CSE-MsgGUID: 7FR7zcpQTWG+vzJcnJTkMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46844635"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46844635"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:51:04 -0700
X-CSE-ConnectionGUID: Ao129LI9SDSWfPrJWTS15Q==
X-CSE-MsgGUID: mF9FLk/FQ7mzwVyeiXcocw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="133164343"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:51:03 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless 10/17] wifi: iwlwifi: mld: refactor purging async notifications
Date: Wed, 23 Apr 2025 08:50:29 +0300
Message-Id: <20250423084826.e98aed77e836.Id9f858d9d553d406a24165b09db830df111befce@changeid>
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

To cancel all async notifications, we need to:
- cancel async_handlers_wk
- empty async_handlers_list

Instead of having the callers to do both, do it in
iwl_mld_purge_async_handlers_list and rename it accordingly.

Note that the caller iwl_cleanup_mld didn't cancel the work, but it is
harmless.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 10 +++-------
 drivers/net/wireless/intel/iwlwifi/mld/mld.h      |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mld/notif.c    |  6 +++++-
 drivers/net/wireless/intel/iwlwifi/mld/notif.h    |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 6851064b82da..e127f29839ea 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -540,14 +540,10 @@ void iwl_mld_mac80211_stop(struct ieee80211_hw *hw, bool suspend)
 	if (!suspend || iwl_mld_no_wowlan_suspend(mld))
 		iwl_mld_stop_fw(mld);
 
-	/* HW is stopped, no more coming RX. OTOH, the worker can't run as the
-	 * wiphy lock is held. Cancel it in case it was scheduled just before
-	 * we stopped the HW.
+	/* HW is stopped, no more coming RX. Cancel all notifications in
+	 * case they were sent just before stopping the HW.
 	 */
-	wiphy_work_cancel(mld->wiphy, &mld->async_handlers_wk);
-
-	/* Empty out the list, as the worker won't do that */
-	iwl_mld_purge_async_handlers_list(mld);
+	iwl_mld_cancel_async_notifications(mld);
 
 	/* Clear in_hw_restart flag when stopping the hw, as mac80211 won't
 	 * execute the restart.
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.h b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
index 5eceaaf7696d..c436eb4a6a6f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -299,10 +299,10 @@ iwl_cleanup_mld(struct iwl_mld *mld)
 
 	iwl_mld_low_latency_restart_cleanup(mld);
 
-	/* Empty the list of async notification handlers so we won't process
+	/* Cancel the async notification handlers so we won't process
 	 * notifications from the dead fw after the reconfig flow.
 	 */
-	iwl_mld_purge_async_handlers_list(mld);
+	iwl_mld_cancel_async_notifications(mld);
 }
 
 enum iwl_power_scheme {
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.c b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
index b8a3204c7847..10f1bee89205 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
@@ -662,10 +662,14 @@ void iwl_mld_async_handlers_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 	}
 }
 
-void iwl_mld_purge_async_handlers_list(struct iwl_mld *mld)
+void iwl_mld_cancel_async_notifications(struct iwl_mld *mld)
 {
 	struct iwl_async_handler_entry *entry, *tmp;
 
+	lockdep_assert_wiphy(mld->wiphy);
+
+	wiphy_work_cancel(mld->wiphy, &mld->async_handlers_wk);
+
 	spin_lock_bh(&mld->async_handlers_lock);
 	list_for_each_entry_safe(entry, tmp, &mld->async_handlers_list, list) {
 		iwl_mld_log_async_handler_op(mld, "Purged", &entry->rxb);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.h b/drivers/net/wireless/intel/iwlwifi/mld/notif.h
index 2eaa1d4e138e..adcdd9dec192 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.h
@@ -15,7 +15,7 @@ void iwl_mld_rx_rss(struct iwl_op_mode *op_mode, struct napi_struct *napi,
 
 void iwl_mld_async_handlers_wk(struct wiphy *wiphy, struct wiphy_work *wk);
 
-void iwl_mld_purge_async_handlers_list(struct iwl_mld *mld);
+void iwl_mld_cancel_async_notifications(struct iwl_mld *mld);
 
 enum iwl_mld_object_type {
 	IWL_MLD_OBJECT_TYPE_NONE,
-- 
2.34.1


