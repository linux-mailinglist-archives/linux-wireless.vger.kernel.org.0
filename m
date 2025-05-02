Return-Path: <linux-wireless+bounces-22356-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF99AA72BC
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1FAD1BC327B
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECCF254B1F;
	Fri,  2 May 2025 12:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zd0fdSs8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2ED255F2B
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746190629; cv=none; b=HQp0VA/gk+SN+FGpQujLads8ddwj1pVHE0PyLHXipDgPgBm2+wuZC0XGfjbK/J1JYGxz+otxZD/7e0RP+ZFrvh/R5NFa1M6daxiXZOAp1uOY8LeMsVYVYDq9HCWYMaYYIvv6QReGCMJaEEdg/AomK4vTX4f+5/1ze/Xl75m/HOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746190629; c=relaxed/simple;
	bh=/1mtdEyCDgIseSLWUpoxMMrTz65UwT+dAy2ZgMyzNfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X8rRN4qzhbej6GOB6DRY2Tj7QDAoW9inZLYBVv5l6gvkkXFNkLUJhGPB53G98i2ZG/qlyDaihyDMf0Znih1lI37P2vpcF2KhUIjreTId/W0HsXcv5oDF2c2d/zNPgGOWa5NS7/t3iUY7AGtZGqBPs3Ci5LGopIwnS9XOpCiFGxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zd0fdSs8; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746190629; x=1777726629;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/1mtdEyCDgIseSLWUpoxMMrTz65UwT+dAy2ZgMyzNfU=;
  b=Zd0fdSs8DAXU1yIrnbzCg4L+4+hXRlwQd3yz0bwxijYBFHzhmZZSFBem
   RvsP6Wi+jhtX4prxT6ZE5Zv8amoWKsO0Qv42ZEZs+cPnn6OcJMxm0KcSf
   0d57TPSvDV2CtUxxA8Kc+ALIk2THAMOjvWBs/aBLRL52IW/lBXpB2FEGF
   gqofpk4vCSWiTY4RrDnDwHamOIhOJIl5a5M6+iKdOh81+ZgVH6qek/HiC
   jVwr4EHHjfwQlAaqg8GCSA0cB3j5WujgFG+XzBC87MxVHEMUtwQmZJIOj
   NIV74TiTZQL121Q+Zzw1vzvP6QConG5z2j/KbCx0HP0MnQ1zQW/IUK1IP
   g==;
X-CSE-ConnectionGUID: 9+vteyXpRsW6Aka8SuuU3Q==
X-CSE-MsgGUID: 6gzfqD9lRgmMfNNYCE7oNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="59255569"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="59255569"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:57:09 -0700
X-CSE-ConnectionGUID: geIeNJNZQceqTVyuSIb1xw==
X-CSE-MsgGUID: MnuWWlFcQnieV43cYKdqDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="165554770"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:57:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: mvm: add command order checks to kunit
Date: Fri,  2 May 2025 15:56:30 +0300
Message-Id: <20250502155404.581b60b0833f.I624fb3efc3fa0b155a5da69d7efc39207f133331@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250502125631.3184319-1-miriam.rachel.korenblit@intel.com>
References: <20250502125631.3184319-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We can test this with kunit instead of having the runtime
checks, add a test here to remove the runtime check next.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  4 ++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  8 +++-
 .../wireless/intel/iwlwifi/mvm/tests/Makefile |  2 +-
 .../wireless/intel/iwlwifi/mvm/tests/hcmd.c   | 42 +++++++++++++++++++
 4 files changed, 54 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/tests/hcmd.c

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index e3b54a0f5aed..a5275f2cd418 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2129,6 +2129,10 @@ bool iwl_mvm_mld_valid_link_pair(struct ieee80211_vif *vif,
 				 const struct iwl_mvm_link_sel_data *b);
 
 s8 iwl_mvm_average_dbm_values(const struct iwl_umac_scan_channel_survey_notif *notif);
+
+
+extern const struct iwl_hcmd_arr iwl_mvm_groups[];
+extern const unsigned int iwl_mvm_groups_size;
 #endif
 
 /* AP and IBSS */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 14932700c6f9..5c7c1d53a28d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -777,7 +777,8 @@ static const struct iwl_hcmd_names iwl_mvm_bt_coex_names[] = {
 	HCMD_NAME(PROFILE_NOTIF),
 };
 
-static const struct iwl_hcmd_arr iwl_mvm_groups[] = {
+VISIBLE_IF_IWLWIFI_KUNIT
+const struct iwl_hcmd_arr iwl_mvm_groups[] = {
 	[LEGACY_GROUP] = HCMD_ARR(iwl_mvm_legacy_names),
 	[LONG_GROUP] = HCMD_ARR(iwl_mvm_legacy_names),
 	[SYSTEM_GROUP] = HCMD_ARR(iwl_mvm_system_names),
@@ -793,6 +794,11 @@ static const struct iwl_hcmd_arr iwl_mvm_groups[] = {
 	[DEBUG_GROUP] = HCMD_ARR(iwl_mvm_debug_names),
 	[STATISTICS_GROUP] = HCMD_ARR(iwl_mvm_statistics_names),
 };
+EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mvm_groups);
+#if IS_ENABLED(CONFIG_IWLWIFI_KUNIT_TESTS)
+const unsigned int iwl_mvm_groups_size = ARRAY_SIZE(iwl_mvm_groups);
+EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mvm_groups_size);
+#endif
 
 /* this forward declaration can avoid to export the function */
 static void iwl_mvm_async_handlers_wk(struct work_struct *wk);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile b/drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile
index 6bd56a28cffd..895d53f223e9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile
@@ -1,3 +1,3 @@
-iwlmvm-tests-y += module.o links.o scan.o
+iwlmvm-tests-y += module.o links.o scan.o hcmd.o
 
 obj-$(CONFIG_IWLWIFI_KUNIT_TESTS) += iwlmvm-tests.o
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tests/hcmd.c b/drivers/net/wireless/intel/iwlwifi/mvm/tests/hcmd.c
new file mode 100644
index 000000000000..85da621e211d
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tests/hcmd.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * KUnit tests for channel helper functions
+ *
+ * Copyright (C) 2025 Intel Corporation
+ */
+#include <kunit/test.h>
+
+#include <iwl-trans.h>
+#include "../mvm.h"
+
+#if LINUX_VERSION_IS_LESS(6,13,0)
+MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
+#else
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+#endif
+
+static void test_hcmd_names_sorted(struct kunit *test)
+{
+	for (int i = 0; i < iwl_mvm_groups_size; i++) {
+		const struct iwl_hcmd_arr *arr = &iwl_mvm_groups[i];
+
+		if (!arr->arr)
+			continue;
+
+		for (int j = 0; j < arr->size - 1; j++)
+			KUNIT_EXPECT_LE(test, arr->arr[j].cmd_id,
+					arr->arr[j + 1].cmd_id);
+	}
+}
+
+static struct kunit_case hcmd_names_cases[] = {
+	KUNIT_CASE(test_hcmd_names_sorted),
+	{},
+};
+
+static struct kunit_suite hcmd_names = {
+	.name = "iwlmvm-hcmd-names",
+	.test_cases = hcmd_names_cases,
+};
+
+kunit_test_suite(hcmd_names);
-- 
2.34.1


