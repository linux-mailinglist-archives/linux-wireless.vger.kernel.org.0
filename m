Return-Path: <linux-wireless+bounces-36342-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIReJFmBA2pX6gEAu9opvQ
	(envelope-from <linux-wireless+bounces-36342-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 21:36:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF37528B6D
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 21:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95748305EA23
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 19:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BF72E542C;
	Tue, 12 May 2026 19:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YEmBgw5j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61EC368D7C
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 19:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614516; cv=none; b=GOGj4O7gQfHcax5ABDlhVDLwavXTP1OklHzX7RIsnvocjC+V5laD6RBPWPyq08q3iuu4UqetkE0wi99Yn6Vmc1yPmThOZtEDumZ0RQmO3D6gz/Iq3eJ/GZl188Z6HwG5Wp0ArUZa7YxcFipt4cYbQ9uG8Y+4QwQ6wWmh0ot89Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614516; c=relaxed/simple;
	bh=ITzr6lQLcg82ef5sioWXOvKJ9AlkjpAlJxXvjnJ/tZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sf66V0YkV7Vz5r2Y5sxF77qHOcHsAZ8u4AzEf9JBHG5Cfr9NMEVeV/sM/jyJJyDQmcr1ceRypfJ725eQs1/+4KkYPoPBlei1n41sq74//DlK7qb+BL87hwn6ouF+TiB3J1SHZPdyTprndOzj1hFkKd2TbGCxb0OLN9A2IagKG8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YEmBgw5j; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778614513; x=1810150513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ITzr6lQLcg82ef5sioWXOvKJ9AlkjpAlJxXvjnJ/tZ8=;
  b=YEmBgw5jJuMAZcJBLNhvN0NPECJyF4gE5jsj1/7pYUpFp+WVZ3+GblxE
   uqrTRwB4t/xyEhhWx0l/J3yAWWAtHU8TmfV5Qz1quKd/ZE1peiSP0MFSV
   tkYyweA00O9QGCCK9MKBDyGt/GJtgSXsYpoqqkW4bsu+FisIcw8wNf/mM
   8r0bdRt6Dm0mDfWF47t96IchLEIjnVKHr6fIlIouZd8xa5hFlYdqmGddJ
   9IEPOQTWJanDDDB7DN0/YdPPDtHkflYIZDn7pBED4a9/90EklGsseW6JA
   zyq0DI1vaNI5W2pkBm4aTn8Lq73jh9f3rT+gIhpZXac+exkZmfLd5ctsP
   g==;
X-CSE-ConnectionGUID: J6C/ZMQsQBapExHy8b/uUQ==
X-CSE-MsgGUID: 56mclS/+Qd+02X7z3/IZrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83148807"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="83148807"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:35:13 -0700
X-CSE-ConnectionGUID: Twvfvd1yT+OOmoQETcQL3g==
X-CSE-MsgGUID: 5EsMGlcwTHCfrungmfNIMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="231471854"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:35:11 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avinash Bhatt <avinash.bhatt@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: mld: Add KUnit tests for channel-load thresholds
Date: Tue, 12 May 2026 22:34:41 +0300
Message-Id: <20260512222731.4dd3ccaffc46.I9c1f210e5ef25248097a226f4b3a2af5fbcf3c87@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512193441.2352467-1-miriam.rachel.korenblit@intel.com>
References: <20260512193441.2352467-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2AF37528B6D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36342-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Avinash Bhatt <avinash.bhatt@intel.com>

Add a KUnit test suite for iwl_mld_chan_load_requires_scan,
covering level-up, level-down, and no-change transitions.
The test directly sets channel-load values, validating
scan-trigger decisions and updated load levels

Signed-off-by: Avinash Bhatt <avinash.bhatt@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.c |   1 +
 .../wireless/intel/iwlwifi/mld/tests/Makefile |   1 +
 .../iwlwifi/mld/tests/chan_load_thresh.c      | 139 ++++++++++++++++++
 3 files changed, 141 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/chan_load_thresh.c

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index c07a0d6b0bd4..805f2e2eac38 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -852,6 +852,7 @@ bool iwl_mld_chan_load_requires_scan(struct iwl_mld *mld,
 
 	return scan_trig;
 }
+EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mld_chan_load_requires_scan);
 
 static unsigned int
 iwl_mld_get_default_chan_load(struct ieee80211_bss_conf *link_conf)
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/Makefile b/drivers/net/wireless/intel/iwlwifi/mld/tests/Makefile
index 36317feb923b..efa61638b8ee 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 iwlmld-tests-y += module.o hcmd.o utils.o link.o rx.o agg.o link-selection.o
+iwlmld-tests-y += chan_load_thresh.o
 
 ccflags-y += -I$(src)/../
 obj-$(CONFIG_IWLWIFI_KUNIT_TESTS) += iwlmld-tests.o
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/chan_load_thresh.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/chan_load_thresh.c
new file mode 100644
index 000000000000..87e29e09949b
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/chan_load_thresh.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * KUnit tests for channel helper functions
+ *
+ * Copyright (C) 2026 Intel Corporation
+ */
+#include <kunit/static_stub.h>
+#include "mld.h"
+#include "link.h"
+#include "iface.h"
+#include "utils.h"
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+struct test_chan_load_case {
+	const char *desc;
+	u32 load;
+	enum iwl_mld_link_chan_load_level old_lvl;
+	enum iwl_mld_link_chan_load_level expected_lvl;
+	bool expected_scan_trig;
+};
+
+static const struct test_chan_load_case test_chan_load_thresh_cases[] = {
+	/* Level-up transitions */
+	{
+		.desc = "Transition NONE->NONE",
+		.load = 20,
+		.old_lvl = LINK_CHAN_LOAD_LVL_NONE,
+		.expected_lvl = LINK_CHAN_LOAD_LVL_NONE,
+		.expected_scan_trig = false,
+	},
+	{
+		.desc = "Transition NONE->LVL1",
+		.load = 50,
+		.old_lvl = LINK_CHAN_LOAD_LVL_NONE,
+		.expected_lvl = LINK_CHAN_LOAD_LVL1,
+		.expected_scan_trig = true,
+	},
+	{
+		.desc = "Transition LVL1->LVL2",
+		.load = 75,
+		.old_lvl = LINK_CHAN_LOAD_LVL1,
+		.expected_lvl = LINK_CHAN_LOAD_LVL2,
+		.expected_scan_trig = true,
+	},
+	{
+		.desc = "Transition LVL2->LVL3",
+		.load = 90,
+		.old_lvl = LINK_CHAN_LOAD_LVL2,
+		.expected_lvl = LINK_CHAN_LOAD_LVL3,
+		.expected_scan_trig = true,
+	},
+
+	/* Level-down transitions */
+	{
+		.desc = "Transition LVL1->NONE",
+		.load = 30,
+		.old_lvl = LINK_CHAN_LOAD_LVL1,
+		.expected_lvl = LINK_CHAN_LOAD_LVL_NONE,
+		.expected_scan_trig = false,
+	},
+	{
+		.desc = "Transition LVL2->LVL1",
+		.load = 60,
+		.old_lvl = LINK_CHAN_LOAD_LVL2,
+		.expected_lvl = LINK_CHAN_LOAD_LVL1,
+		.expected_scan_trig = false,
+	},
+	{
+		.desc = "Transition LVL3->LVL2",
+		.load = 70,
+		.old_lvl = LINK_CHAN_LOAD_LVL3,
+		.expected_lvl = LINK_CHAN_LOAD_LVL2,
+		.expected_scan_trig = false,
+	},
+
+	/* No change */
+	{
+		.desc = "Transition LVL2->LVL2",
+		.load = 72,
+		.old_lvl = LINK_CHAN_LOAD_LVL2,
+		.expected_lvl = LINK_CHAN_LOAD_LVL2,
+		.expected_scan_trig = false,
+	},
+};
+
+KUNIT_ARRAY_PARAM_DESC(test_chan_load_thresh_cases,
+		       test_chan_load_thresh_cases, desc);
+
+static void test_chan_load_thresholds(struct kunit *test)
+{
+	const struct test_chan_load_case *tc = test->param_value;
+	struct iwl_mld *mld = test->priv;
+	struct ieee80211_vif *vif;
+	struct iwl_mld_vif *mld_vif;
+	struct ieee80211_bss_conf *link_conf;
+	struct iwl_mld_link *mld_link;
+	struct iwl_mld_kunit_link assoc_link = {
+		.id = 0,
+		.chandef = &chandef_6ghz_160mhz,
+	};
+	bool scan_trig;
+	u32 chan_load;
+
+	/* Setup associated non-MLO station */
+	vif = iwlmld_kunit_setup_non_mlo_assoc(&assoc_link);
+	mld_vif = iwl_mld_vif_from_mac80211(vif);
+
+	link_conf = &vif->bss_conf;
+	mld_link = &mld_vif->deflink;
+
+	chan_load = tc->load;
+	mld_link->chan_load_lvl = tc->old_lvl;
+
+	/* Execute function under test */
+	wiphy_lock(mld->wiphy);
+	scan_trig = iwl_mld_chan_load_requires_scan(mld, link_conf, chan_load);
+	wiphy_unlock(mld->wiphy);
+
+	/* Check return value */
+	KUNIT_EXPECT_EQ(test, tc->expected_scan_trig, scan_trig);
+
+	/* Check updated channel-load level */
+	KUNIT_EXPECT_EQ(test, tc->expected_lvl, mld_link->chan_load_lvl);
+}
+
+static struct kunit_case chan_load_thresh_test_cases[] = {
+	KUNIT_CASE_PARAM(test_chan_load_thresholds,
+			 test_chan_load_thresh_cases_gen_params),
+	{}
+};
+
+static struct kunit_suite chan_load_thresh_test_suite = {
+	.name = "iwl_mld_chan_load_threshold_tests",
+	.init = iwlmld_kunit_test_init,
+	.test_cases = chan_load_thresh_test_cases,
+};
+
+kunit_test_suite(chan_load_thresh_test_suite);
-- 
2.34.1


