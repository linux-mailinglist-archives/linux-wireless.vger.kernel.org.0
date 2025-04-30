Return-Path: <linux-wireless+bounces-22248-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDED5AA4B06
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 14:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E051BC313F
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 12:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F032025A2AB;
	Wed, 30 Apr 2025 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QpGwZ2G4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1773922173C
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746015892; cv=none; b=rNTpZLzvRLyvBDgOJlZ+rUU2c28wBOYiBAaDwCmrqeWTxhKOTpN2wq8/fPUyQfQ0Ejfnx5acYynEws41SZxzHVBpL9MiabVr4FH2DNnrhXglFSQ7/8uWr9O0aKFFrUB9/XL2a4HnvEhjptETC0qFLNBWEmG05Pp3sqX32nXqvrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746015892; c=relaxed/simple;
	bh=WMVuOoSCauhxMMKcDvx1ufJlBwNeDp3TSys4XmbJz2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mCg3wLOXTgare9S9q2VRNVpcBmx4B6igZjWVpQyCuMWXamXqWErYsOTftF3utnH1dK8XZ8pOf1CadJIz7nirsXTtEiJpt7nz7qI1rn3a7Apm/QSk6jhQ6D2LdnaYWW/pAcGiK6xOp3WLhQlFxNVt4mYmhQjTSul9Itri9nTaOTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QpGwZ2G4; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746015891; x=1777551891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WMVuOoSCauhxMMKcDvx1ufJlBwNeDp3TSys4XmbJz2Q=;
  b=QpGwZ2G4h5R7E/T5WCEdiBeoH3npIJis7PNGQ47EavGXFmr31yITdCTR
   pqoG/TErrH2Bfl14hcQT/O6Lk8RTOZyBOKYlbdMC47+gKZKeYTl1FqhIw
   GC516UQ9GWATg31AvRKnYdbcgF7K0IyHx3voP9jAuYzqFc/EcOT3PIKpo
   yrX/URfF2vhdgL7eJoCvJiBE4CkwDD2FISWBLYALm1SjOZNs+w2zQSKfj
   7XtH5k3+QSjXNB5jCMQYfW+N+yuWBeTQ5HFC5/dbfQC0VLg1R6CnaA6Ez
   LCj1W/s1vI2giPd23PgKPI23R9FLb+44aOnPRKIFgEAmNRnzAgi4yE6g9
   Q==;
X-CSE-ConnectionGUID: CKPujPKFT4yy1UAHmH0Eqw==
X-CSE-MsgGUID: naBMk9ReRKmx7mpgIVjGTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47578268"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="47578268"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:24:50 -0700
X-CSE-ConnectionGUID: YodvBOHYTQevI7Vcl/uJoA==
X-CSE-MsgGUID: vu+WD2MRQCu1AcKoVe+23Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="135087856"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:24:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 05/14] wifi: iwlwifi: mld: tests: extend link pair tests
Date: Wed, 30 Apr 2025 15:23:11 +0300
Message-Id: <20250430151952.1f7c4ac75c6d.I69d68359e02d99632e95daba3d126115dce167b3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430122320.1061510-1-miriam.rachel.korenblit@intel.com>
References: <20250430122320.1061510-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Generalize and extend the link pair tests to not just do
channel load checks, but generally check link pairs. To
enable more accurate checking, return the reasons bitmap
from iwl_mld_valid_emlsr_pair() and therefore rename it
to iwl_mld_emlsr_pair_state.

It's also necessary now to add more chandefs, and while
doing so fix the existing ones to be valid and add a
test to check they really are valid.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  | 23 +++---
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h  |  7 +-
 .../intel/iwlwifi/mld/tests/link-selection.c  | 78 ++++++++++++++-----
 3 files changed, 73 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index da16fff1ce86..91f3a48d0c4b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -732,7 +732,7 @@ iwl_mld_get_min_chan_load_thresh(struct ieee80211_chanctx_conf *chanctx)
 	return 10;
 }
 
-VISIBLE_IF_IWLWIFI_KUNIT bool
+static bool
 iwl_mld_channel_load_allows_emlsr(struct iwl_mld *mld,
 				  struct ieee80211_vif *vif,
 				  const struct iwl_mld_link_sel_data *a,
@@ -789,10 +789,9 @@ iwl_mld_channel_load_allows_emlsr(struct iwl_mld *mld,
 
 	return false;
 }
-EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mld_channel_load_allows_emlsr);
 
-static bool
-iwl_mld_valid_emlsr_pair(struct ieee80211_vif *vif,
+VISIBLE_IF_KUNIT u32
+iwl_mld_emlsr_pair_state(struct ieee80211_vif *vif,
 			 struct iwl_mld_link_sel_data *a,
 			 struct iwl_mld_link_sel_data *b)
 {
@@ -801,9 +800,13 @@ iwl_mld_valid_emlsr_pair(struct ieee80211_vif *vif,
 	u32 reason_mask = 0;
 
 	/* Per-link considerations */
-	if (iwl_mld_emlsr_disallowed_with_link(mld, vif, a, true) ||
-	    iwl_mld_emlsr_disallowed_with_link(mld, vif, b, false))
-		return false;
+	reason_mask = iwl_mld_emlsr_disallowed_with_link(mld, vif, a, true);
+	if (reason_mask)
+		return reason_mask;
+
+	reason_mask = iwl_mld_emlsr_disallowed_with_link(mld, vif, b, false);
+	if (reason_mask)
+		return reason_mask;
 
 	if (a->chandef->chan->band == b->chandef->chan->band) {
 		const struct cfg80211_chan_def *c_low = a->chandef;
@@ -839,11 +842,11 @@ iwl_mld_valid_emlsr_pair(struct ieee80211_vif *vif,
 			       nl80211_chan_width_to_mhz(a->chandef->width),
 			       nl80211_chan_width_to_mhz(b->chandef->width));
 		iwl_mld_print_emlsr_exit(mld, reason_mask);
-		return false;
 	}
 
-	return true;
+	return reason_mask;
 }
+EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mld_emlsr_pair_state);
 
 /* Calculation is done with fixed-point with a scaling factor of 1/256 */
 #define SCALE_FACTOR 256
@@ -871,7 +874,7 @@ unsigned int iwl_mld_get_emlsr_grade(struct iwl_mld *mld,
 
 	*primary_id = a->link_id;
 
-	if (!iwl_mld_valid_emlsr_pair(vif, a, b))
+	if (iwl_mld_emlsr_pair_state(vif, a, b))
 		return 0;
 
 	primary_conf = wiphy_dereference(wiphy, vif->link_conf[*primary_id]);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.h b/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
index 4fb1fdbe3df9..c2bf04b799fb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
@@ -158,10 +158,9 @@ struct iwl_mld_link_sel_data {
 };
 
 #if IS_ENABLED(CONFIG_IWLWIFI_KUNIT_TESTS)
-bool iwl_mld_channel_load_allows_emlsr(struct iwl_mld *mld,
-				       struct ieee80211_vif *vif,
-				       const struct iwl_mld_link_sel_data *a,
-				       const struct iwl_mld_link_sel_data *b);
+u32 iwl_mld_emlsr_pair_state(struct ieee80211_vif *vif,
+			     struct iwl_mld_link_sel_data *a,
+			     struct iwl_mld_link_sel_data *b);
 #endif
 
 #endif /* __iwl_mld_mlo_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c
index b44d63f95ade..766c24db3613 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c
@@ -172,21 +172,21 @@ static struct kunit_suite link_selection = {
 
 kunit_test_suite(link_selection);
 
-static const struct channel_load_case {
+static const struct link_pair_case {
 	const char *desc;
 	const struct cfg80211_chan_def *chandef_a, *chandef_b;
 	bool low_latency_vif;
 	u32 chan_load_not_by_us;
 	bool primary_link_active;
-	bool expected_result;
-} channel_load_cases[] = {
+	u32 expected_result;
+} link_pair_cases[] = {
 	{
 		.desc = "Unequal bandwidth, primary link inactive, EMLSR not allowed",
 		.low_latency_vif = false,
 		.primary_link_active = false,
 		.chandef_a = &chandef_5ghz_40mhz,
 		.chandef_b = &chandef_6ghz_20mhz,
-		.expected_result = false,
+		.expected_result = IWL_MLD_EMLSR_EXIT_CHAN_LOAD,
 	},
 	{
 		.desc = "Equal bandwidths, sufficient channel load, EMLSR allowed",
@@ -195,7 +195,7 @@ static const struct channel_load_case {
 		.chan_load_not_by_us = 11,
 		.chandef_a = &chandef_5ghz_40mhz,
 		.chandef_b = &chandef_6ghz_40mhz,
-		.expected_result = true,
+		.expected_result = 0,
 	},
 	{
 		.desc = "Equal bandwidths, insufficient channel load, EMLSR not allowed",
@@ -204,7 +204,7 @@ static const struct channel_load_case {
 		.chan_load_not_by_us = 6,
 		.chandef_a = &chandef_5ghz_80mhz,
 		.chandef_b = &chandef_6ghz_80mhz,
-		.expected_result = false,
+		.expected_result = IWL_MLD_EMLSR_EXIT_CHAN_LOAD,
 	},
 	{
 		.desc = "Low latency VIF, sufficient channel load, EMLSR allowed",
@@ -213,7 +213,7 @@ static const struct channel_load_case {
 		.chan_load_not_by_us = 6,
 		.chandef_a = &chandef_5ghz_160mhz,
 		.chandef_b = &chandef_6ghz_160mhz,
-		.expected_result = true,
+		.expected_result = 0,
 	},
 	{
 		.desc = "Different bandwidths (2x ratio), primary link load permits EMLSR",
@@ -222,7 +222,7 @@ static const struct channel_load_case {
 		.chan_load_not_by_us = 30,
 		.chandef_a = &chandef_5ghz_40mhz,
 		.chandef_b = &chandef_6ghz_20mhz,
-		.expected_result = true,
+		.expected_result = 0,
 	},
 	{
 		.desc = "Different bandwidths (4x ratio), primary link load permits EMLSR",
@@ -231,7 +231,7 @@ static const struct channel_load_case {
 		.chan_load_not_by_us = 45,
 		.chandef_a = &chandef_5ghz_80mhz,
 		.chandef_b = &chandef_6ghz_20mhz,
-		.expected_result = true,
+		.expected_result = 0,
 	},
 	{
 		.desc = "Different bandwidths (16x ratio), primary link load insufficient",
@@ -240,15 +240,51 @@ static const struct channel_load_case {
 		.chan_load_not_by_us = 45,
 		.chandef_a = &chandef_6ghz_320mhz,
 		.chandef_b = &chandef_5ghz_20mhz,
-		.expected_result = false,
+		.expected_result = IWL_MLD_EMLSR_EXIT_CHAN_LOAD,
+	},
+	{
+		.desc = "Same band not allowed (2.4 GHz)",
+		.low_latency_vif = false,
+		.primary_link_active = true,
+		.chan_load_not_by_us = 30,
+		.chandef_a = &chandef_2ghz_20mhz,
+		.chandef_b = &chandef_2ghz_11_20mhz,
+		.expected_result = IWL_MLD_EMLSR_EXIT_EQUAL_BAND,
+	},
+	{
+		.desc = "Same band not allowed (5 GHz)",
+		.low_latency_vif = false,
+		.primary_link_active = true,
+		.chan_load_not_by_us = 30,
+		.chandef_a = &chandef_5ghz_40mhz,
+		.chandef_b = &chandef_5ghz_40mhz,
+		.expected_result = IWL_MLD_EMLSR_EXIT_EQUAL_BAND,
+	},
+	{
+		.desc = "Same band allowed (5 GHz separated)",
+		.low_latency_vif = false,
+		.primary_link_active = true,
+		.chan_load_not_by_us = 30,
+		.chandef_a = &chandef_5ghz_40mhz,
+		.chandef_b = &chandef_5ghz_120_40mhz,
+		.expected_result = 0,
+	},
+	{
+		.desc = "Same band not allowed (6 GHz)",
+		.low_latency_vif = false,
+		.primary_link_active = true,
+		.chan_load_not_by_us = 30,
+		.chandef_a = &chandef_6ghz_160mhz,
+		.chandef_b = &chandef_6ghz_221_160mhz,
+		.expected_result = IWL_MLD_EMLSR_EXIT_EQUAL_BAND,
 	},
 };
 
-KUNIT_ARRAY_PARAM_DESC(channel_load, channel_load_cases, desc);
+KUNIT_ARRAY_PARAM_DESC(link_pair, link_pair_cases, desc);
 
-static void test_iwl_mld_channel_load_allows_emlsr(struct kunit *test)
+static void test_iwl_mld_link_pair_allows_emlsr(struct kunit *test)
 {
-	const struct channel_load_case *params = test->param_value;
+	const struct link_pair_case *params = test->param_value;
 	struct iwl_mld *mld = test->priv;
 	struct ieee80211_vif *vif;
 	/* link A is the primary and link B is the secondary */
@@ -264,7 +300,7 @@ static void test_iwl_mld_channel_load_allows_emlsr(struct kunit *test)
 		.chandef = params->primary_link_active ? a.chandef : b.chandef,
 		.id = params->primary_link_active ? a.link_id : b.link_id,
 	};
-	bool result;
+	u32 result;
 
 	vif = iwlmld_kunit_setup_mlo_assoc(BIT(a.link_id) | BIT(b.link_id),
 					   &assoc_link);
@@ -282,22 +318,22 @@ static void test_iwl_mld_channel_load_allows_emlsr(struct kunit *test)
 		phy->avg_channel_load_not_by_us = params->chan_load_not_by_us;
 	}
 
-	result = iwl_mld_channel_load_allows_emlsr(mld, vif, &a, &b);
+	result = iwl_mld_emlsr_pair_state(vif, &a, &b);
 
 	wiphy_unlock(mld->wiphy);
 
 	KUNIT_EXPECT_EQ(test, result, params->expected_result);
 }
 
-static struct kunit_case channel_load_criteria_test_cases[] = {
-	KUNIT_CASE_PARAM(test_iwl_mld_channel_load_allows_emlsr, channel_load_gen_params),
+static struct kunit_case link_pair_criteria_test_cases[] = {
+	KUNIT_CASE_PARAM(test_iwl_mld_link_pair_allows_emlsr, link_pair_gen_params),
 	{}
 };
 
-static struct kunit_suite channel_load_criteria_tests = {
-	.name = "iwlmld_channel_load_allows_emlsr",
-	.test_cases = channel_load_criteria_test_cases,
+static struct kunit_suite link_pair_criteria_tests = {
+	.name = "iwlmld_link_pair_allows_emlsr",
+	.test_cases = link_pair_criteria_test_cases,
 	.init = iwlmld_kunit_test_init,
 };
 
-kunit_test_suite(channel_load_criteria_tests);
+kunit_test_suite(link_pair_criteria_tests);
-- 
2.34.1


