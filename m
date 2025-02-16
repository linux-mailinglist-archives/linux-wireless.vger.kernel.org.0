Return-Path: <linux-wireless+bounces-19005-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF23A37398
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B5E87A1C8D
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2641991CF;
	Sun, 16 Feb 2025 09:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eKIUdbl4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD61F199938
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699062; cv=none; b=pYi9cqJ6gvwCKIK9iYnrSaTcgOHzYCT7wxe0dGKYZ0Jbf2wVtZLOL9T8hd97ODbIDautquu+EHIhkaHG2o73T1TDjzZ5brz+2v+sIhg8NCiUuBh1q9LRAm3exBxyNYSttb0HJSnG0sL/LyB7Myo0hDz3DzdCwOm9ytET3eYzquY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699062; c=relaxed/simple;
	bh=DJp4KxFMl5MoQICx7fAQAhKKFInoe80PUJHhaa0kWOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KHlT+zVWNa3LZ88wu8UC7JZQh0/Xc36VUGk32+XtQtramzK/KtiWQsX5LwRAC4rZoaV8sLHVaOvDbTOxFlzGzlqZkSr6tz9ewBFVUEx0zVsfVxJ6tLlImQcfiPVdE3FtBTqnZb9RiljOwrdJk0K48zRi74TBJjPEFskttFdHHP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eKIUdbl4; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699061; x=1771235061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DJp4KxFMl5MoQICx7fAQAhKKFInoe80PUJHhaa0kWOw=;
  b=eKIUdbl4NNKhkA303c0QYx5W3fr6qxt1Wq4Tey9MVNW2IZGF9Usc7VT9
   LwV96BWenDVB8qjwz8Rhko5YRgpVzvaCdS1+iCbpq+8NPQevIF++/7m9o
   De52NJJkfjPKwa3ZAMS7d1zZ8Lqs620+8l/gSOspcjKQNuHsM4Mf06snG
   FkwvgPtywtfB5Kgp/AftiWFgfLsofs+INEpAPuLZHxOuZWZ5tUWuAxXud
   Mk6CJQhGl+wombfhMAtUFVwfQwD4s53RHD3jKrG1U6drRnTzFLfq2HGk1
   gc0ea1ACHIudR6UeySn1HfYVWjls7dAjUMv/dJvD/QsweoqsCLVYt+I4q
   Q==;
X-CSE-ConnectionGUID: 01XrDFIFQjuLME+j2vkgdQ==
X-CSE-MsgGUID: jvnTDtD2T5ibKYN2x9yrkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323428"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323428"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:20 -0800
X-CSE-ConnectionGUID: xr6lw059RYC+kcgIqgsjTw==
X-CSE-MsgGUID: elv5kNzNQ2qm43SmUGnhhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785289"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:19 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 35/42] wifi: iwlwifi: mld: add KUnit test file hcmd.c
Date: Sun, 16 Feb 2025 11:43:14 +0200
Message-Id: <20250216111649.6fd91c335a77.Icf3b01750df7108206109ef06ce391d10a247a23@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250216094321.537988-1-miriam.rachel.korenblit@intel.com>
References: <20250216094321.537988-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

this file implements hcmd KUnit test

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/mld/tests/hcmd.c   | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/hcmd.c

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/hcmd.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/hcmd.c
new file mode 100644
index 000000000000..4e189bf8b3fb
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/hcmd.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * KUnit tests for channel helper functions
+ *
+ * Copyright (C) 2024 Intel Corporation
+ */
+#include <kunit/test.h>
+
+#include <iwl-trans.h>
+#include "mld.h"
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+static void test_hcmd_names_sorted(struct kunit *test)
+{
+	int i;
+
+	for (i = 0; i < global_iwl_mld_goups_size; i++) {
+		const struct iwl_hcmd_arr *arr = &iwl_mld_groups[i];
+		int j;
+
+		if (!arr->arr)
+			continue;
+		for (j = 0; j < arr->size - 1; j++)
+			KUNIT_EXPECT_LE(test, arr->arr[j].cmd_id,
+					arr->arr[j + 1].cmd_id);
+	}
+}
+
+static void test_hcmd_names_for_rx(struct kunit *test)
+{
+	static struct iwl_trans t = {
+		.command_groups = iwl_mld_groups,
+	};
+
+	t.command_groups_size = global_iwl_mld_goups_size;
+
+	for (unsigned int i = 0; i < iwl_mld_rx_handlers_num; i++) {
+		const struct iwl_rx_handler *rxh;
+		const char *name;
+
+		rxh = &iwl_mld_rx_handlers[i];
+
+		name = iwl_get_cmd_string(&t, rxh->cmd_id);
+		KUNIT_EXPECT_NOT_NULL(test, name);
+		KUNIT_EXPECT_NE_MSG(test, strcmp(name, "UNKNOWN"), 0,
+				    "ID 0x%04x is UNKNOWN", rxh->cmd_id);
+	}
+}
+
+static struct kunit_case hcmd_names_cases[] = {
+	KUNIT_CASE(test_hcmd_names_sorted),
+	KUNIT_CASE(test_hcmd_names_for_rx),
+	{},
+};
+
+static struct kunit_suite hcmd_names = {
+	.name = "iwlmld-hcmd-names",
+	.test_cases = hcmd_names_cases,
+};
+
+kunit_test_suite(hcmd_names);
-- 
2.34.1


