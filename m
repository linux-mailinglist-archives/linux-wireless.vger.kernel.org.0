Return-Path: <linux-wireless+bounces-19006-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DE8A37399
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52D518898A4
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5293419A288;
	Sun, 16 Feb 2025 09:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z/d/q1Ev"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB73D199EB0
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699063; cv=none; b=NDgjKCCgcAMar9tdbZ6RanLlflfqQEVqP2syuk8t1D8S6DOx3q800t76kDxvHW5WkmQtjgwpR+5RN4uOPjymzLIUrUn0pjh7sU3PSs4I9C9gMEDjipp4TqTpNKjlGGldDI9xaiEXFS5JPlSwhz/RblLGD+KLzFwTbB9avYtVTY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699063; c=relaxed/simple;
	bh=+jri2vicLLWPzmMQV4N5jItHNo36Pgzlhlvvb7TcJTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IEV26057w4bIJhbfJB+pnsUFL7rErT89Sm8oUsPdvyUfvAIwcTHSIuA2MCvN36P1XFQBwo+3gWMkrM2nRN93rF8zZWroew2sjUdaz+aWi6Bdy4Uamd3kIeSEZV8/98qyhdYGjcHfdgycv9SFBZsNKk1MHKRMesqSV+jG3UV0x+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z/d/q1Ev; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699062; x=1771235062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+jri2vicLLWPzmMQV4N5jItHNo36Pgzlhlvvb7TcJTo=;
  b=Z/d/q1EvLUWCi185D3VZdJYQkPMQx77bRSXHhR9x131svr2cz9s7mmVq
   8vApx/4Hxl0Xf10ByLinSQYE3WBOTcBcUkOJPLkUPkB1CL4YtEjBCnJxX
   RMmZnxrpYo8WGQWHrQ2/0sAe6IvQAMM6u1oewlzXodfF0fGNrQvIN/kZN
   uwXH9ksRIg7Ak9gqCDyz5G+stVECrDj/WeB9Nm9ZS3/OSio/mxqVAJ75F
   Ek7x2eyfLfsIqx8to0IfFron+A9O/bkk1kj28uikuM+1i2sGpS/ZdxWRu
   6f+aAj33kk7Y2KZqVaFDloK31wcDEbIwsBOrxWYe6+7pSJ3mwLlTxuITf
   g==;
X-CSE-ConnectionGUID: BX414LxMQgCAkFsuyKVW1Q==
X-CSE-MsgGUID: BskaHzIjSo+pwwnOKyT/gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323430"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323430"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:22 -0800
X-CSE-ConnectionGUID: 9tDX8jq8R0+L+ceemzgBVw==
X-CSE-MsgGUID: QausXeM1Req4xMdJ4qkWKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785295"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:20 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 36/42] wifi: iwlwifi: mld: add KUnit test file link.c
Date: Sun, 16 Feb 2025 11:43:15 +0200
Message-Id: <20250216111649.ec0153e38515.I9f7eb14c0c17282667fb4b569423b2a192a2fd77@changeid>
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

this file implements link KUnit tests

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/mld/tests/link.c   | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/link.c

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/link.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/link.c
new file mode 100644
index 000000000000..6e251dbc1dfe
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/link.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * KUnit tests for channel helper functions
+ *
+ * Copyright (C) 2024 Intel Corporation
+ */
+#include <kunit/static_stub.h>
+
+#include "utils.h"
+#include "mld.h"
+#include "link.h"
+#include "iface.h"
+#include "fw/api/mac-cfg.h"
+
+static const struct missed_beacon_test_case {
+	const char *desc;
+	struct {
+		struct iwl_missed_beacons_notif notif;
+		bool emlsr;
+	} input;
+	struct {
+		bool disconnected;
+		bool emlsr;
+	} output;
+} missed_beacon_cases[] = {
+	{
+		.desc = "no EMLSR, no disconnect",
+		.input.notif = {
+			.consec_missed_beacons = cpu_to_le32(4),
+		},
+	},
+	{
+		.desc = "no EMLSR, no beacon loss since Rx, no disconnect",
+		.input.notif = {
+			.consec_missed_beacons = cpu_to_le32(20),
+		},
+	},
+	{
+		.desc = "no EMLSR, beacon loss since Rx, disconnect",
+		.input.notif = {
+			.consec_missed_beacons = cpu_to_le32(20),
+			.consec_missed_beacons_since_last_rx =
+				cpu_to_le32(10),
+		},
+		.output.disconnected = true,
+	},
+};
+
+KUNIT_ARRAY_PARAM_DESC(test_missed_beacon, missed_beacon_cases, desc);
+
+static void fake_ieee80211_connection_loss(struct ieee80211_vif *vif)
+{
+	vif->cfg.assoc = false;
+}
+
+static void test_missed_beacon(struct kunit *test)
+{
+	struct iwl_mld *mld = test->priv;
+	struct iwl_missed_beacons_notif *notif;
+	const struct missed_beacon_test_case *test_param =
+		(const void *)(test->param_value);
+	struct ieee80211_vif *vif;
+	struct iwl_rx_packet *pkt;
+
+	kunit_activate_static_stub(test, ieee80211_connection_loss,
+				   fake_ieee80211_connection_loss);
+	pkt = iwl_mld_kunit_create_pkt(test_param->input.notif);
+	notif = (void *)pkt->data;
+
+	if (test_param->input.emlsr) {
+		vif = iwlmld_kunit_assoc_emlsr(0x3, NL80211_BAND_5GHZ,
+					       NL80211_BAND_6GHZ);
+	} else {
+		struct iwl_mld_vif *mld_vif;
+
+		vif = iwlmld_kunit_setup_non_mlo_assoc(NL80211_BAND_6GHZ);
+		mld_vif = iwl_mld_vif_from_mac80211(vif);
+		notif->link_id = cpu_to_le32(mld_vif->deflink.fw_id);
+	}
+
+	wiphy_lock(mld->wiphy);
+
+	iwl_mld_handle_missed_beacon_notif(mld, pkt);
+
+	wiphy_unlock(mld->wiphy);
+
+	KUNIT_ASSERT_NE(test, vif->cfg.assoc, test_param->output.disconnected);
+
+	/* TODO: add test cases for esr and check */
+}
+
+static struct kunit_case link_cases[] = {
+	KUNIT_CASE_PARAM(test_missed_beacon, test_missed_beacon_gen_params),
+	{},
+};
+
+static struct kunit_suite link = {
+	.name = "iwlmld-link",
+	.test_cases = link_cases,
+	.init = iwlmld_kunit_test_init,
+};
+
+kunit_test_suite(link);
-- 
2.34.1


