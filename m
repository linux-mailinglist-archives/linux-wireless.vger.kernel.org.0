Return-Path: <linux-wireless+bounces-25285-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 654B7B0208A
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 17:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF161896C91
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 15:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5E42ED165;
	Fri, 11 Jul 2025 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kPcFV/Wg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8514E2ED867
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248104; cv=none; b=Fqu2YeCSW7cwJyq6F2Fb4bHZ0KcLm9YjTmbnU6yXJWmVFPrwFiBhAqL41ZfUpkX5xHDVCywzX2/Xx+5aU+U3+a+LTqjKM32NwbHoFDq9hAnuGPFdbOUpsWfiFr73/8SgOwbKKNS/kU3hymLGjGvOXyXZ1hzCN8gPJcnHUTuwLug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248104; c=relaxed/simple;
	bh=YKkguPDgtk0LiE1+StyuGijjYfjW/YoVJPRuHWJB/Ww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TLlv1iZkRXv2jsLjRIv3Q8ybCj0P3Da0LyXLQhpuVdNHt92XKyVGo8FIVX4jQnSVB3IND0g/6MGDjUyXO+/lwDyfHGXLsE1xl86h1e6FLqk9lK/pxAD4wmh/UBXX0BN3Q+BkbOfuaNnGdFvKBSJHgwHjTKNZ+QGUDLTlxVLFA5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kPcFV/Wg; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752248103; x=1783784103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YKkguPDgtk0LiE1+StyuGijjYfjW/YoVJPRuHWJB/Ww=;
  b=kPcFV/WgEGKIhByHPG1qRJiGzNBZR+xY5pdM3RDiF7gkkPrcV4ZPaNIR
   00pQGjsUKPgaWnFVld8uK7pzVdETtAtxzs4rLMvmTp2ADjNw+ZVgfLuG0
   dU0LKxqx5GD5o9G+rLnmlOO1nbkZ5RqeDg7a5UAgk0B9QsFmd+KdDu+/0
   ojk8pRgn2eJsbIDmVVER7FBANWFWiK2RvEkTEQa1XCrt0+PEtYzZe/yA6
   LITOjmy+vdDRybvmLGvJQGxaTR2Z+AoNqt355qa/JC3iWd/aVGncxbSWr
   DnGkT2p8eXoV+b830DZCVz3Tn0B+NfRwHCkQyeJhJmLkK7UECQUUz9IfK
   g==;
X-CSE-ConnectionGUID: xKi0a1dGQYGItDmDJkkg2Q==
X-CSE-MsgGUID: wwNSGzLsSGaTiEzH1Ff3xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54264167"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="54264167"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:35:03 -0700
X-CSE-ConnectionGUID: 2oZJg5BGRMiUzr01SzadPA==
X-CSE-MsgGUID: CHMsaVzUQDK9QBGikUJ+SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="156485146"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:35:01 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: mld: Revert "wifi: iwlwifi: mld: add kunit test for emlsr with bt on"
Date: Fri, 11 Jul 2025 18:34:24 +0300
Message-Id: <20250711183056.5fdf77497ad2.I1160f1dcff734cb42baa8fbf8aac121a1a24a4c5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711153429.3417098-1-miriam.rachel.korenblit@intel.com>
References: <20250711153429.3417098-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Due to a hw bug, this feature won't be enabled. Revert its tests.
This reverts commit f7cc80b871ee ("wifi: iwlwifi: mld: add kunit test
for emlsr with bt on")

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h  |   4 -
 .../wireless/intel/iwlwifi/mld/tests/Makefile |   2 +-
 .../intel/iwlwifi/mld/tests/emlsr_with_bt.c   | 140 ------------------
 4 files changed, 2 insertions(+), 148 deletions(-)
 delete mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/emlsr_with_bt.c

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index be66a71a0fd7..d002d2772a1d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -693,8 +693,7 @@ s8 iwl_mld_get_emlsr_rssi_thresh(struct iwl_mld *mld,
 #define IWL_MLD_BT_COEX_ENABLE_EMLSR_RSSI_THRESH	-63
 #define IWL_MLD_BT_COEX_WIFI_LOSS_THRESH		7
 
-VISIBLE_IF_IWLWIFI_KUNIT
-bool
+static bool
 iwl_mld_bt_allows_emlsr(struct iwl_mld *mld, struct ieee80211_bss_conf *link,
 			bool check_entry)
 {
@@ -723,7 +722,6 @@ iwl_mld_bt_allows_emlsr(struct iwl_mld *mld, struct ieee80211_bss_conf *link,
 		      link->link_id, bt_penalty);
 	return bt_penalty < IWL_MLD_BT_COEX_WIFI_LOSS_THRESH;
 }
-EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mld_bt_allows_emlsr);
 
 static u32
 iwl_mld_emlsr_disallowed_with_link(struct iwl_mld *mld,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.h b/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
index 704f64134798..d936589fe39d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
@@ -163,10 +163,6 @@ void iwl_mld_emlsr_block_tmp_non_bss(struct iwl_mld *mld);
 u32 iwl_mld_emlsr_pair_state(struct ieee80211_vif *vif,
 			     struct iwl_mld_link_sel_data *a,
 			     struct iwl_mld_link_sel_data *b);
-
-bool iwl_mld_bt_allows_emlsr(struct iwl_mld *mld,
-			     struct ieee80211_bss_conf *link,
-			     bool entry_criteria);
 #endif
 
 void iwl_mld_start_ignoring_tpt_updates(struct iwl_mld *mld);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/Makefile b/drivers/net/wireless/intel/iwlwifi/mld/tests/Makefile
index 3e2ae6020613..36317feb923b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
-iwlmld-tests-y += module.o hcmd.o utils.o link.o rx.o agg.o link-selection.o emlsr_with_bt.o
+iwlmld-tests-y += module.o hcmd.o utils.o link.o rx.o agg.o link-selection.o
 
 ccflags-y += -I$(src)/../
 obj-$(CONFIG_IWLWIFI_KUNIT_TESTS) += iwlmld-tests.o
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/emlsr_with_bt.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/emlsr_with_bt.c
deleted file mode 100644
index 91556ee5c142..000000000000
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/emlsr_with_bt.c
+++ /dev/null
@@ -1,140 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
-/*
- * KUnit tests for link selection functions
- *
- * Copyright (C) 2025 Intel Corporation
- */
-#include <kunit/static_stub.h>
-
-#include "utils.h"
-#include "mld.h"
-#include "mlo.h"
-
-static const struct emlsr_with_bt_test_case {
-	const char *desc;
-	struct {
-		struct iwl_bt_coex_profile_notif notif;
-		s32 signal;
-		bool check_entry;
-	} input;
-	bool emlsr_allowed;
-} emlsr_with_bt_cases[] = {
-	{
-		.desc = "BT penalty(exit) with low rssi 4.5: emlsr allowed",
-		.input = {
-			.notif.wifi_loss_low_rssi[1] = {4, 5},
-			.notif.wifi_loss_mid_high_rssi[1] = {7, 9},
-			.signal = -69,
-			.check_entry = false,
-		},
-		.emlsr_allowed = true,
-	},
-	{
-		.desc = "BT penalty(exit) from high rssi 5: emlsr allowed",
-		.input = {
-			.notif.wifi_loss_low_rssi[1] = {7, 9},
-			.notif.wifi_loss_mid_high_rssi[1] = {5, 5},
-			.signal = -68,
-			.check_entry = false,
-		},
-		.emlsr_allowed = true,
-	},
-	{
-		.desc = "BT penalty(exit) with low rssi 8: emlsr not allowed",
-		.input = {
-			.notif.wifi_loss_low_rssi[1] = {7, 9},
-			.notif.wifi_loss_mid_high_rssi[1] = {4, 5},
-			.signal = -69,
-			.check_entry = false,
-		},
-		.emlsr_allowed = false,
-	},
-	{
-		.desc = "BT penalty(exit) from high rssi 9: emlsr not allowed",
-		.input = {
-			.notif.wifi_loss_low_rssi[1] = {4, 5},
-			.notif.wifi_loss_mid_high_rssi[1] = {9, 9},
-			.signal = -68,
-			.check_entry = false,
-		},
-		.emlsr_allowed = false,
-	},
-	{
-		.desc = "BT penalty(entry) with low rssi 4.5: emlsr allowed",
-		.input = {
-			.notif.wifi_loss_low_rssi[1] = {4, 5},
-			.notif.wifi_loss_mid_high_rssi[1] = {7, 9},
-			.signal = -63,
-			.check_entry = true,
-		},
-		.emlsr_allowed = true,
-	},
-	{
-		.desc = "BT penalty(entry) from high rssi 5: emlsr allowed",
-		.input = {
-			.notif.wifi_loss_low_rssi[1] = {7, 9},
-			.notif.wifi_loss_mid_high_rssi[1] = {5, 5},
-			.signal = -62,
-			.check_entry = false,
-		},
-		.emlsr_allowed = true,
-	},
-	{
-		.desc = "BT penalty(entry) with low rssi 8: emlsr not allowed",
-		.input = {
-			.notif.wifi_loss_low_rssi[1] = {7, 9},
-			.notif.wifi_loss_mid_high_rssi[1] = {4, 5},
-			.signal = -63,
-			.check_entry = false,
-		},
-		.emlsr_allowed = true,
-	},
-	{
-		.desc = "BT penalty(entry) from high rssi 9: emlsr not allowed",
-		.input = {
-			.notif.wifi_loss_low_rssi[1] = {4, 5},
-			.notif.wifi_loss_mid_high_rssi[1] = {9, 9},
-			.signal = -62,
-			.check_entry = true,
-		},
-		.emlsr_allowed = false,
-	},
-};
-
-KUNIT_ARRAY_PARAM_DESC(emlsr_with_bt, emlsr_with_bt_cases, desc);
-
-static void test_emlsr_with_bt(struct kunit *test)
-{
-	struct iwl_mld *mld = test->priv;
-	const struct emlsr_with_bt_test_case *test_param =
-		(const void *)(test->param_value);
-	struct ieee80211_vif *vif =
-		iwlmld_kunit_add_vif(true, NL80211_IFTYPE_STATION);
-	struct ieee80211_bss_conf *link = iwlmld_kunit_add_link(vif, 1);
-	bool actual_value = false;
-
-	KUNIT_ALLOC_AND_ASSERT(test, link->bss);
-
-	/* Extract test case parameters */
-	link->bss->signal = DBM_TO_MBM(test_param->input.signal);
-	memcpy(&mld->last_bt_notif, &test_param->input.notif,
-	       sizeof(struct iwl_bt_coex_profile_notif));
-
-	actual_value = iwl_mld_bt_allows_emlsr(mld, link,
-					       test_param->input.check_entry);
-	/* Assert that the returned value matches the expected emlsr_allowed */
-	KUNIT_EXPECT_EQ(test, actual_value, test_param->emlsr_allowed);
-}
-
-static struct kunit_case emlsr_with_bt_test_cases[] = {
-	KUNIT_CASE_PARAM(test_emlsr_with_bt, emlsr_with_bt_gen_params),
-	{},
-};
-
-static struct kunit_suite emlsr_with_bt = {
-	.name = "iwlmld-emlsr-with-bt-tests",
-	.test_cases = emlsr_with_bt_test_cases,
-	.init = iwlmld_kunit_test_init,
-};
-
-kunit_test_suite(emlsr_with_bt);
-- 
2.34.1


