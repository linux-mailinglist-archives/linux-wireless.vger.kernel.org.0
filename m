Return-Path: <linux-wireless+bounces-24985-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86043AFD79D
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 21:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E02B3A6C05
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 19:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ABB23C8CE;
	Tue,  8 Jul 2025 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JC/7tpYp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0264323D2BA
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752004286; cv=none; b=hyddiLOV9aM+HYfbRNbelyn8yfrRMrRFnE3vFjH8jZCY0cFgHkr7Olil5aXOwolGPIXf62biUNwFTApD8ISBDwY9/V8SkPaDJYnWNs3DrR8XzupJw0AIHVQski5o60QYIAZ+l3FgBnHLZAHgE8gPOxJ8mGPW01w9GEYDes0ktB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752004286; c=relaxed/simple;
	bh=bd8AZMHiOKUx0QQa3RzgnKQ3hk/20Z+g4CH6o7zKxMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n9RmZv3hpLU+gYEpFv8Nsb7YQDrmJSVws3Xg3UF81lxrA1P9gO/D2gjh1iQUauzSoym1a5SpSXMEwS4gUyG3sX9Lr7mtWWTFLAznJl9f5weoXMV85e1NqHfnULym5AxXOMrXYCpFWd2u+qpwPtATrOetK0hWz4fK7OmE+0o/4CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JC/7tpYp; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752004285; x=1783540285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bd8AZMHiOKUx0QQa3RzgnKQ3hk/20Z+g4CH6o7zKxMc=;
  b=JC/7tpYpfDHemm473Prh0oSvcuOOMrhT6F4tndAOB4VYcPmepincX5Js
   Taj8UMMK7XSa974r6YeA5qfZszZ0DLodFKrmb+IkFiwQYtYdgN+LG3HyG
   FbyKDdCKAsL5wT4jk8ji2uxr176lWIK6lt/O30hMkr8NAFEz2Fkv81Lww
   k67+uX1jK/d4bZ8j7Xw+KVHH7AB8ty047rBxgJtYz62mIB4/QGoIynOMO
   wRhekkmZ5aanfR+cflwFKWTeoXKmG/6YUcxuEyF9I7hi5oQZEwwyL9Loe
   CxkDwfme2kmVk9QlgIPA8a8eeIKsHvDNoSiUmTQCvAYih6oGHvPjl1LdY
   Q==;
X-CSE-ConnectionGUID: 8VfIFmNaRteiiW49tWMbWg==
X-CSE-MsgGUID: KbmkaDWbQpOZJsZLJdM2NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54229720"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54229720"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 12:51:24 -0700
X-CSE-ConnectionGUID: U+NMFwxTSGupV+ATlPDFAQ==
X-CSE-MsgGUID: UWvxjbRYRuyJQ0BbC8jwIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155668966"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 12:51:23 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: mvm/mld: make PHC messages debug messages
Date: Tue,  8 Jul 2025 22:50:46 +0300
Message-Id: <20250708224652.e52f143577ba.Ic6f042588ef17719653c077ff89a8b9149c22f92@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708195053.451143-1-miriam.rachel.korenblit@intel.com>
References: <20250708195053.451143-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

These have no real value for normal users, print them as
debug messages instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c | 12 ++++++------
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c | 14 +++++++-------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ptp.c b/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
index 5ee38fc168c1..ffeb37a7f830 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
@@ -299,18 +299,18 @@ void iwl_mld_ptp_init(struct iwl_mld *mld)
 			PTR_ERR(mld->ptp_data.ptp_clock));
 		mld->ptp_data.ptp_clock = NULL;
 	} else {
-		IWL_INFO(mld, "Registered PHC clock: %s, with index: %d\n",
-			 mld->ptp_data.ptp_clock_info.name,
-			 ptp_clock_index(mld->ptp_data.ptp_clock));
+		IWL_DEBUG_INFO(mld, "Registered PHC clock: %s, with index: %d\n",
+			       mld->ptp_data.ptp_clock_info.name,
+			       ptp_clock_index(mld->ptp_data.ptp_clock));
 	}
 }
 
 void iwl_mld_ptp_remove(struct iwl_mld *mld)
 {
 	if (mld->ptp_data.ptp_clock) {
-		IWL_INFO(mld, "Unregistering PHC clock: %s, with index: %d\n",
-			 mld->ptp_data.ptp_clock_info.name,
-			 ptp_clock_index(mld->ptp_data.ptp_clock));
+		IWL_DEBUG_INFO(mld, "Unregistering PHC clock: %s, with index: %d\n",
+			       mld->ptp_data.ptp_clock_info.name,
+			       ptp_clock_index(mld->ptp_data.ptp_clock));
 
 		ptp_clock_unregister(mld->ptp_data.ptp_clock);
 		mld->ptp_data.ptp_clock = NULL;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c b/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
index e89259de6f4c..06a4c9f74797 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2021 - 2023 Intel Corporation
+ * Copyright (C) 2021 - 2023, 2025 Intel Corporation
  */
 
 #include "mvm.h"
@@ -298,9 +298,9 @@ void iwl_mvm_ptp_init(struct iwl_mvm *mvm)
 			PTR_ERR(mvm->ptp_data.ptp_clock));
 		mvm->ptp_data.ptp_clock = NULL;
 	} else if (mvm->ptp_data.ptp_clock) {
-		IWL_INFO(mvm, "Registered PHC clock: %s, with index: %d\n",
-			 mvm->ptp_data.ptp_clock_info.name,
-			 ptp_clock_index(mvm->ptp_data.ptp_clock));
+		IWL_DEBUG_INFO(mvm, "Registered PHC clock: %s, with index: %d\n",
+			       mvm->ptp_data.ptp_clock_info.name,
+			       ptp_clock_index(mvm->ptp_data.ptp_clock));
 	}
 }
 
@@ -312,9 +312,9 @@ void iwl_mvm_ptp_init(struct iwl_mvm *mvm)
 void iwl_mvm_ptp_remove(struct iwl_mvm *mvm)
 {
 	if (mvm->ptp_data.ptp_clock) {
-		IWL_INFO(mvm, "Unregistering PHC clock: %s, with index: %d\n",
-			 mvm->ptp_data.ptp_clock_info.name,
-			 ptp_clock_index(mvm->ptp_data.ptp_clock));
+		IWL_DEBUG_INFO(mvm, "Unregistering PHC clock: %s, with index: %d\n",
+			       mvm->ptp_data.ptp_clock_info.name,
+			       ptp_clock_index(mvm->ptp_data.ptp_clock));
 
 		ptp_clock_unregister(mvm->ptp_data.ptp_clock);
 		mvm->ptp_data.ptp_clock = NULL;
-- 
2.34.1


