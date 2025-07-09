Return-Path: <linux-wireless+bounces-25062-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F6EAFDF22
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 07:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E00585769
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DEF26A1B8;
	Wed,  9 Jul 2025 05:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J3etpDLu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81EC26AABE
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 05:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752038228; cv=none; b=Rvyv53RyV8Dc9luGMFiFbW3zX/UWa/jfnA0i7KC2oC5dyLtDkxvfoENlnTiNl1BE7gMLeImLaLk7VCDs+VDWN3H2hyY0v7CtJ6pA6toz4ecgk4U04mGvBcZAebGri2WrzqTikaBD3TSZyTne7km/Mi/xPq9vEi+HmXKwGrWu94E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752038228; c=relaxed/simple;
	bh=bd8AZMHiOKUx0QQa3RzgnKQ3hk/20Z+g4CH6o7zKxMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GxO4YIqzsUPreTBBrYizJyNQClGhdhSlxCbYgI4ybzeVYqsoGIOis7koxXTFRQ1oFy7giOKsjfQKkyhwdL/HDthXgbnJ/kBVmmJRcBti125xg55MrkDZP4uWqF0FxkmdJIQFGz87C4GzmVUcBKjJIS7AtGX+YL1PoA8xr6UFZtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J3etpDLu; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752038227; x=1783574227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bd8AZMHiOKUx0QQa3RzgnKQ3hk/20Z+g4CH6o7zKxMc=;
  b=J3etpDLuZayYW0jDUQubn2uLvIOa3nmz9aabtZzo90A2dLg3OMP/nCFu
   u+Ik2jJBnMq5EeiQrZsu7OFQIV4r/c47KlJxBcMQWK1HLe+IijIqV62S4
   yqskIinbUFisi3BdZ3RpXB5i13SFzFTL8qsC/y0HRmDHcgDv/tB0pifKN
   unPbOWSkfGiNf2EWaZQ6VaGNtlkd5IHrzDRA++nxlLFBOXwuC8hphh1Jj
   zQwtneDlGGDxAIl+ech9XO96mfPTO1eOvQASgJfiKwF5O7ioNj5Fqnk7g
   +uyWkqBvS4o+FhHovERK4LiVVHcZ+lJviaw2h8Ha5eC9E4etfCkCBnmXq
   A==;
X-CSE-ConnectionGUID: pnTUKBw+R7GNoohY7EC9ug==
X-CSE-MsgGUID: AWRszzLoTHam+l0LbfcJ/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="58091174"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="58091174"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:17:07 -0700
X-CSE-ConnectionGUID: 0mfJ0QLQRqSSMbnn2bY6Og==
X-CSE-MsgGUID: CWZ4SySrRway5VGcnOEKgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="161327876"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:17:05 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next v3 08/15] wifi: iwlwifi: mvm/mld: make PHC messages debug messages
Date: Wed,  9 Jul 2025 08:16:27 +0300
Message-Id: <20250709081300.bd2df0705d89.Ic6f042588ef17719653c077ff89a8b9149c22f92@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709051634.866992-1-miriam.rachel.korenblit@intel.com>
References: <20250709051634.866992-1-miriam.rachel.korenblit@intel.com>
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


