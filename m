Return-Path: <linux-wireless+bounces-21891-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7F1A97F09
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 08:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 995763B476D
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 06:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141CC266B70;
	Wed, 23 Apr 2025 06:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ELdnyiim"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66388267705
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 06:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745389030; cv=none; b=RQdDZ8FQb/tpme82TiqzYE5vpnvEyUSwsB8vXZ76pVOIX9n1iv27JX/NW0tgzjTNpPrp2gqq/gLsC8eDqv6pTtnQDym9pKE6P5UuV5BChbnc/r/rn1D2/c3NT/3TZ6r6k+oWVU2VMtb6YzBBuEwKb0Hzso6q6vVZtcZr4RrYJPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745389030; c=relaxed/simple;
	bh=my1n6X125pRxeSgwvG3O82GWFlZ1PI6UkcptXzh6dOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=krPHplz6aHv2vfcc1Z6NhhqthQl3qCztZ+xg16alNCKNIuifytyM08nIFIf3MFucBezL9XtuKk4jkoByUknzDIqOgC0Fc0obMg8ip1jXflN+S8dhtlaCVu8cDCDVTcWWUFtkFEAFdqkuFz4KgOSGEwd/g8X83UA/DF1/alZYDkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ELdnyiim; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745389028; x=1776925028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=my1n6X125pRxeSgwvG3O82GWFlZ1PI6UkcptXzh6dOY=;
  b=ELdnyiimE7FW2cg/zMp4ZmOgzXSUi9xXtOUOq+2sxNy1qSdh2UdiDoJ0
   WikqzZOGdAWtFM/qu0qAAMAEMlnG1P/MTnKE1a0S582n2oCEI+dD35sr0
   0mm/NDv7TL21a37fb4xJ0IC7i7TW+KD/H3KNDmGh6Qvy2vvAHnu+Mysey
   rLaUfCgmmOXI2yYIyE1DzTN/tS7wYWdV6mQsof3K40OOmXu8PwGyWy1lZ
   1X3tVhgm128+zM7qIbWcS9gBlO7Oh4xlaEIunL9H+Q/hx+8ZJpWAOnGnn
   is8m/lWbXBKw2RC07T7LRP3huNouD5c3kruaanhUEhttk3+6oxOgRnrvo
   Q==;
X-CSE-ConnectionGUID: hkKYH+i2SO2N/TVWjtyAEA==
X-CSE-MsgGUID: yUQWffFQRJWuz4Ng9e6ESg==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46843642"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46843642"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:17:08 -0700
X-CSE-ConnectionGUID: FtzemmxVQsK2c7bKKmQafA==
X-CSE-MsgGUID: vU+RGhIUSsSLx7Rmvgl1nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="163269060"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:17:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 10/15] wifi: iwlwifi: mld: refactor purging async notifications
Date: Wed, 23 Apr 2025 09:16:36 +0300
Message-Id: <20250423091408.e98aed77e836.Id9f858d9d553d406a24165b09db830df111befce@changeid>
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


