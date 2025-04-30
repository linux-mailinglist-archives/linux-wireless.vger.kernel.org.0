Return-Path: <linux-wireless+bounces-22262-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E44B5AA4C66
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 15:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51AE6188DC6C
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 12:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015E525F7B9;
	Wed, 30 Apr 2025 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VPDvA6al"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6873A259C9D
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017867; cv=none; b=VzsMt+19pYW2zbyP+j73FTJc3xTjqpfu4LNQqOwHHbzXwZTQmsGbnPI6+AT8NsWoMD/Kaac8wMLHgDrkboH2UFXQgdv9ho9a/DhbOz5t9Qn5l6g8dbTYh8Rlx3IjCM9nS9PC40au2WlP1ltMgDtnWk/lZOFE670/y80hayh9Bhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017867; c=relaxed/simple;
	bh=yFzd5jmOd/wTwdqoklYmnhrg7AYbPo+aXanPYEdOB7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZpgXRAofcs3jRYqRTIxvMZnpxJhPIa9B74zkXo2Axhn3KwsVhDJmskOZTL+5TE4Fj6/NX8Uhb4jJFU5BhErPLab1Pt16n2qZkIZXlZwVuUOgiad101XwdHAOT/e/OwusbQE/q8IlTvg4GmuhfI86cDCEKnmWnWnVeZEWdio83Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VPDvA6al; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746017865; x=1777553865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yFzd5jmOd/wTwdqoklYmnhrg7AYbPo+aXanPYEdOB7k=;
  b=VPDvA6alT0ug+KAaMYSaIcuA4T7XvVy3FHOOf/AbEAbM0SpKX9xiDusJ
   +mCtj0dG8jYIMNMy4PBLjMBFqhbCRlpn/vXD6G4ERDpmA2piKp2t2ybZE
   FEyUw2R4AksLluPWFzFcLPtukouJKxDWWMBoLDwuhB/iTo0FgRHH5Mi8t
   Krih1Dn1eguKZ1cBgKThnk6M15EeilOLz8OvKLyDJraBciFtAxFu1bMEY
   VLZd2qOlqM+UFEBpTnTz7krTaYMmlXFjpmJVSNvN1BlzQ/MyTZAc8srFY
   hseHBjBl4xxkbw5CvnwOPiIMGb/eks6f7ZDhjBMuuxOFDPUzKy+Z9W5ZD
   A==;
X-CSE-ConnectionGUID: K8X9WD69Qm+3Vgmbc87h3A==
X-CSE-MsgGUID: jJ6g0yG7TZGK4p5v62FUVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="58332323"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="58332323"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:57:44 -0700
X-CSE-ConnectionGUID: d5lTQti+T4m2ztR45qXK3g==
X-CSE-MsgGUID: O5t/U+d/SFOULFZORF+hAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="134632081"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:57:43 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: mld: add kunit test for emlsr with bt on
Date: Wed, 30 Apr 2025 15:57:15 +0300
Message-Id: <20250430155443.6621494fa412.If89b4b2dab308d825ca02284dd8e0030675d7af5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
References: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>

add kunit test to validate entering and exiting
emlsr scenarios when the bt is on with certain
penalty on wifi.

Signed-off-by: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h  |   4 +
 .../wireless/intel/iwlwifi/mld/tests/Makefile |   2 +-
 .../intel/iwlwifi/mld/tests/emlsr_with_bt.c   | 140 ++++++++++++++++++
 4 files changed, 148 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/emlsr_with_bt.c

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index c84b39794c8f..824a328da28e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -640,7 +640,8 @@ s8 iwl_mld_get_emlsr_rssi_thresh(struct iwl_mld *mld,
 #define IWL_MLD_BT_COEX_ENABLE_EMLSR_RSSI_THRESH	-63
 #define IWL_MLD_BT_COEX_WIFI_LOSS_THRESH		7
 
-static bool
+VISIBLE_IF_IWLWIFI_KUNIT
+bool
 iwl_mld_bt_allows_emlsr(struct iwl_mld *mld, struct ieee80211_bss_conf *link,
 			bool check_entry)
 {
@@ -669,6 +670,7 @@ iwl_mld_bt_allows_emlsr(struct iwl_mld *mld, struct ieee80211_bss_conf *link,
 		      link->link_id, bt_penalty);
 	return bt_penalty < IWL_MLD_BT_COEX_WIFI_LOSS_THRESH;
 }
+EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mld_bt_allows_emlsr);
 
 static u32
 iwl_mld_emlsr_disallowed_with_link(struct iwl_mld *mld,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.h b/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
index c2bf04b799fb..2122a7c3e945 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
@@ -161,6 +161,10 @@ struct iwl_mld_link_sel_data {
 u32 iwl_mld_emlsr_pair_state(struct ieee80211_vif *vif,
 			     struct iwl_mld_link_sel_data *a,
 			     struct iwl_mld_link_sel_data *b);
+
+bool iwl_mld_bt_allows_emlsr(struct iwl_mld *mld,
+			     struct ieee80211_bss_conf *link,
+			     bool entry_criteria);
 #endif
 
 #endif /* __iwl_mld_mlo_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/Makefile b/drivers/net/wireless/intel/iwlwifi/mld/tests/Makefile
index 36317feb923b..3e2ae6020613 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
-iwlmld-tests-y += module.o hcmd.o utils.o link.o rx.o agg.o link-selection.o
+iwlmld-tests-y += module.o hcmd.o utils.o link.o rx.o agg.o link-selection.o emlsr_with_bt.o
 
 ccflags-y += -I$(src)/../
 obj-$(CONFIG_IWLWIFI_KUNIT_TESTS) += iwlmld-tests.o
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/emlsr_with_bt.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/emlsr_with_bt.c
new file mode 100644
index 000000000000..91556ee5c142
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/emlsr_with_bt.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * KUnit tests for link selection functions
+ *
+ * Copyright (C) 2025 Intel Corporation
+ */
+#include <kunit/static_stub.h>
+
+#include "utils.h"
+#include "mld.h"
+#include "mlo.h"
+
+static const struct emlsr_with_bt_test_case {
+	const char *desc;
+	struct {
+		struct iwl_bt_coex_profile_notif notif;
+		s32 signal;
+		bool check_entry;
+	} input;
+	bool emlsr_allowed;
+} emlsr_with_bt_cases[] = {
+	{
+		.desc = "BT penalty(exit) with low rssi 4.5: emlsr allowed",
+		.input = {
+			.notif.wifi_loss_low_rssi[1] = {4, 5},
+			.notif.wifi_loss_mid_high_rssi[1] = {7, 9},
+			.signal = -69,
+			.check_entry = false,
+		},
+		.emlsr_allowed = true,
+	},
+	{
+		.desc = "BT penalty(exit) from high rssi 5: emlsr allowed",
+		.input = {
+			.notif.wifi_loss_low_rssi[1] = {7, 9},
+			.notif.wifi_loss_mid_high_rssi[1] = {5, 5},
+			.signal = -68,
+			.check_entry = false,
+		},
+		.emlsr_allowed = true,
+	},
+	{
+		.desc = "BT penalty(exit) with low rssi 8: emlsr not allowed",
+		.input = {
+			.notif.wifi_loss_low_rssi[1] = {7, 9},
+			.notif.wifi_loss_mid_high_rssi[1] = {4, 5},
+			.signal = -69,
+			.check_entry = false,
+		},
+		.emlsr_allowed = false,
+	},
+	{
+		.desc = "BT penalty(exit) from high rssi 9: emlsr not allowed",
+		.input = {
+			.notif.wifi_loss_low_rssi[1] = {4, 5},
+			.notif.wifi_loss_mid_high_rssi[1] = {9, 9},
+			.signal = -68,
+			.check_entry = false,
+		},
+		.emlsr_allowed = false,
+	},
+	{
+		.desc = "BT penalty(entry) with low rssi 4.5: emlsr allowed",
+		.input = {
+			.notif.wifi_loss_low_rssi[1] = {4, 5},
+			.notif.wifi_loss_mid_high_rssi[1] = {7, 9},
+			.signal = -63,
+			.check_entry = true,
+		},
+		.emlsr_allowed = true,
+	},
+	{
+		.desc = "BT penalty(entry) from high rssi 5: emlsr allowed",
+		.input = {
+			.notif.wifi_loss_low_rssi[1] = {7, 9},
+			.notif.wifi_loss_mid_high_rssi[1] = {5, 5},
+			.signal = -62,
+			.check_entry = false,
+		},
+		.emlsr_allowed = true,
+	},
+	{
+		.desc = "BT penalty(entry) with low rssi 8: emlsr not allowed",
+		.input = {
+			.notif.wifi_loss_low_rssi[1] = {7, 9},
+			.notif.wifi_loss_mid_high_rssi[1] = {4, 5},
+			.signal = -63,
+			.check_entry = false,
+		},
+		.emlsr_allowed = true,
+	},
+	{
+		.desc = "BT penalty(entry) from high rssi 9: emlsr not allowed",
+		.input = {
+			.notif.wifi_loss_low_rssi[1] = {4, 5},
+			.notif.wifi_loss_mid_high_rssi[1] = {9, 9},
+			.signal = -62,
+			.check_entry = true,
+		},
+		.emlsr_allowed = false,
+	},
+};
+
+KUNIT_ARRAY_PARAM_DESC(emlsr_with_bt, emlsr_with_bt_cases, desc);
+
+static void test_emlsr_with_bt(struct kunit *test)
+{
+	struct iwl_mld *mld = test->priv;
+	const struct emlsr_with_bt_test_case *test_param =
+		(const void *)(test->param_value);
+	struct ieee80211_vif *vif =
+		iwlmld_kunit_add_vif(true, NL80211_IFTYPE_STATION);
+	struct ieee80211_bss_conf *link = iwlmld_kunit_add_link(vif, 1);
+	bool actual_value = false;
+
+	KUNIT_ALLOC_AND_ASSERT(test, link->bss);
+
+	/* Extract test case parameters */
+	link->bss->signal = DBM_TO_MBM(test_param->input.signal);
+	memcpy(&mld->last_bt_notif, &test_param->input.notif,
+	       sizeof(struct iwl_bt_coex_profile_notif));
+
+	actual_value = iwl_mld_bt_allows_emlsr(mld, link,
+					       test_param->input.check_entry);
+	/* Assert that the returned value matches the expected emlsr_allowed */
+	KUNIT_EXPECT_EQ(test, actual_value, test_param->emlsr_allowed);
+}
+
+static struct kunit_case emlsr_with_bt_test_cases[] = {
+	KUNIT_CASE_PARAM(test_emlsr_with_bt, emlsr_with_bt_gen_params),
+	{},
+};
+
+static struct kunit_suite emlsr_with_bt = {
+	.name = "iwlmld-emlsr-with-bt-tests",
+	.test_cases = emlsr_with_bt_test_cases,
+	.init = iwlmld_kunit_test_init,
+};
+
+kunit_test_suite(emlsr_with_bt);
-- 
2.34.1


