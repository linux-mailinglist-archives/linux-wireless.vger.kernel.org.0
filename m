Return-Path: <linux-wireless+bounces-19007-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FC5A3739A
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68BEC16D0F8
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A408518F2D8;
	Sun, 16 Feb 2025 09:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Klr/Fj02"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B4B199FC1
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699064; cv=none; b=f2K0oQ5tgZERBhPVB1uChG0SeISTHjPu41dFNmyv+8d9xgG6TYJ7iGAGBY0x8eBy4bF6nqeDgLSS1y1FNHjstHcRj+OOBpoavKWMvgqO9+0UKudfcRjIU39sAIfAUELzEgaoadtm77hBTMomaHXBa3sCIJcm7GIxgsp61aDZGT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699064; c=relaxed/simple;
	bh=pprMAFkkUrFdF6qI6e4ENsYf/loA1saeQNFKwSfXywc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lXY1KwR8wngWNebtYu3Yy+lKK6IiTYli2TjPTHhUlHtQNE5M+O5NXT3Nu4Z/ou4/Uj0QfEdieo2NQzCaGF4mbsu7qi5h+0zSKSwiYoMaunA7JiNNvPaBKFSc3K9sq6C/JhIG9XH88VYnzPk5E7P2uJhCwU6n5l1ITEHkd/Tcx8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Klr/Fj02; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699063; x=1771235063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pprMAFkkUrFdF6qI6e4ENsYf/loA1saeQNFKwSfXywc=;
  b=Klr/Fj02U2e0fZFsFg36B78dsu6XaymBlRBKCIB9JgImSdMwPijVsKYc
   X2NJNrL5Au8nHGKn5zNsv2Ie8kCIhx7sRSb3xqi+jDwnjtdJHOzmfpVS7
   4xdzF6RTp7HIQW4fOWiy0D4n9U5eNuD5VPf9/VtJhoRHVI80DzoIaO0KX
   ffq8spcojftYmKT3JgKqfIedxI8lHKUx5GhEmGRtMWA82y6nNvw6js6P3
   lsJ9/HJPu2VSV3ywPDxSLru6OI5S71L5qbTjXn/WwGC9H1cuR89k/XN+7
   jiKRJFor2cJtjs0M5Hg0GI964RHGL42XIdSfNCSUVtVC66Po+QNvmqDhL
   g==;
X-CSE-ConnectionGUID: wqaMXTaCTXK49uv6dsaI1w==
X-CSE-MsgGUID: lz+NMsflQle0/AKeG1+QiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323432"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323432"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:23 -0800
X-CSE-ConnectionGUID: xzO54z50QZubkKp9xqz6uQ==
X-CSE-MsgGUID: ghElsOUSQEegJflOYiX71Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785299"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:22 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 37/42] wifi: iwlwifi: mld: add KUnit test file link-selection.c
Date: Sun, 16 Feb 2025 11:43:16 +0200
Message-Id: <20250216111649.4b4b26f941f0.I62ef1ce661ccaf1f8d5f7c17b02e294ed9e3f41b@changeid>
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

this file implements link selection KUnit tests

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../intel/iwlwifi/mld/tests/link-selection.c  | 171 ++++++++++++++++++
 1 file changed, 171 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c
new file mode 100644
index 000000000000..d835550c1a6b
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c
@@ -0,0 +1,171 @@
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
+#include "link.h"
+#include "iface.h"
+#include "phy.h"
+
+static const struct link_grading_test_case {
+	const char *desc;
+	struct {
+		struct {
+			u8 link_id;
+			const struct cfg80211_chan_def *chandef;
+			bool active;
+			s32 signal;
+			bool has_chan_util_elem;
+			u8 chan_util; /* 0-255 , used only if has_chan_util_elem is true */
+			u8 chan_load_by_us; /* 0-100, used only if active is true */;
+		} link;
+	} input;
+	unsigned int expected_grade;
+} link_grading_cases[] = {
+	{
+		.desc = "channel util of 128 (50%)",
+		.input.link = {
+			.link_id = 0,
+			.chandef = &chandef_2ghz,
+			.active = false,
+			.has_chan_util_elem = true,
+			.chan_util = 128,
+		},
+		.expected_grade = 86,
+	},
+	{
+		.desc = "channel util of 180 (70%)",
+		.input.link = {
+			.link_id = 0,
+			.chandef = &chandef_2ghz,
+			.active = false,
+			.has_chan_util_elem = true,
+			.chan_util = 180,
+		},
+		.expected_grade = 51,
+	},
+	{
+		.desc = "channel util of 180 (70%), channel load by us of 10%",
+		.input.link = {
+			.link_id = 0,
+			.chandef = &chandef_2ghz,
+			.has_chan_util_elem = true,
+			.chan_util = 180,
+			.active = true,
+			.chan_load_by_us = 10,
+		},
+		.expected_grade = 67,
+	},
+		{
+		.desc = "no channel util element",
+		.input.link = {
+			.link_id = 0,
+			.chandef = &chandef_2ghz,
+			.active = true,
+		},
+		.expected_grade = 120,
+	},
+};
+
+KUNIT_ARRAY_PARAM_DESC(link_grading, link_grading_cases, desc);
+
+static void setup_link(struct ieee80211_bss_conf *link)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct iwl_mld *mld = test->priv;
+	const struct link_grading_test_case *test_param =
+		(const void *)(test->param_value);
+
+	KUNIT_ALLOC_AND_ASSERT(test, link->bss);
+
+	link->bss->signal = DBM_TO_MBM(test_param->input.link.signal);
+
+	link->chanreq.oper = *test_param->input.link.chandef;
+
+	if (test_param->input.link.has_chan_util_elem) {
+		struct cfg80211_bss_ies *ies;
+		struct ieee80211_bss_load_elem bss_load = {
+			.channel_util = test_param->input.link.chan_util,
+		};
+		struct element *elem =
+			iwlmld_kunit_gen_element(WLAN_EID_QBSS_LOAD,
+						 &bss_load,
+						 sizeof(bss_load));
+		unsigned int elem_len = sizeof(*elem) + sizeof(bss_load);
+
+		KUNIT_ALLOC_AND_ASSERT_SIZE(test, ies, sizeof(*ies) + elem_len);
+		memcpy(ies->data, elem, elem_len);
+		ies->len = elem_len;
+		rcu_assign_pointer(link->bss->beacon_ies, ies);
+		rcu_assign_pointer(link->bss->ies, ies);
+	}
+
+	if (test_param->input.link.active) {
+		struct ieee80211_chanctx_conf *chan_ctx =
+			wiphy_dereference(mld->wiphy, link->chanctx_conf);
+		struct iwl_mld_phy *phy;
+
+		KUNIT_ASSERT_NOT_NULL(test, chan_ctx);
+
+		phy = iwl_mld_phy_from_mac80211(chan_ctx);
+
+		phy->channel_load_by_us = test_param->input.link.chan_load_by_us;
+	}
+}
+
+static void test_link_grading(struct kunit *test)
+{
+	struct iwl_mld *mld = test->priv;
+	const struct link_grading_test_case *test_param =
+		(const void *)(test->param_value);
+	struct ieee80211_vif *vif;
+	struct ieee80211_bss_conf *link;
+	unsigned int actual_grade;
+	u8 assoc_link_id;
+	/* Extract test case parameters */
+	u8 link_id = test_param->input.link.link_id;
+	enum nl80211_band band = test_param->input.link.chandef->chan->band;
+	bool active = test_param->input.link.active;
+	u16 valid_links;
+
+	/* If the link is not active, use a different link as the assoc link */
+	if (active) {
+		assoc_link_id = link_id;
+		valid_links = BIT(link_id);
+	} else {
+		assoc_link_id = BIT(ffz(BIT(link_id)));
+		valid_links = BIT(assoc_link_id) | BIT(link_id);
+	}
+
+	vif = iwlmld_kunit_setup_mlo_assoc(valid_links, assoc_link_id, band);
+
+	wiphy_lock(mld->wiphy);
+	link = wiphy_dereference(mld->wiphy, vif->link_conf[link_id]);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+
+	setup_link(link);
+
+	actual_grade = iwl_mld_get_link_grade(mld, link);
+	wiphy_unlock(mld->wiphy);
+
+	/* Assert that the returned grade matches the expected grade */
+	KUNIT_EXPECT_EQ(test, actual_grade, test_param->expected_grade);
+}
+
+static struct kunit_case link_selection_cases[] = {
+	KUNIT_CASE_PARAM(test_link_grading, link_grading_gen_params),
+	{},
+};
+
+static struct kunit_suite link_selection = {
+	.name = "iwlmld-link-selection-tests",
+	.test_cases = link_selection_cases,
+	.init = iwlmld_kunit_test_init,
+};
+
+kunit_test_suite(link_selection);
-- 
2.34.1


