Return-Path: <linux-wireless+bounces-20275-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA0BA5E747
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 23:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA081189D83F
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 22:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC531F03EF;
	Wed, 12 Mar 2025 22:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WeOBZV2H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521A91F03C5
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 22:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818187; cv=none; b=lQoTKSwsm/co/L53HD0uBA33y3UrdxqpD+0B1/X1zlng4uSdVyCyd3lyR/VRNd7FApl29BzCiaFM2vcagUVgsu7xxo1I5VWKdVQION2td3og5DvH3nZ4zhLllL2uLJLWapJq/IYU2B8YNF8a3SiSN5Es3N1+6rT5pTr7+dDd6+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818187; c=relaxed/simple;
	bh=1WBbeik5wi3drDYu/MVkynfo9xgawanZNjF0eIfzg0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O9kcNux8gsdy+K6ge9F1hA+0/zlvqVkEp8mX7dSFSv46cyxs8Z16PuIWF7Ysv8Kl6zPFyfB2hvMzLMlygqTT4RgcZBjOzJinufd8+RJQsXeXJkIkoIeJJNZEGrKEK2C8zcDU9cQeNXzGaZRBUQvwmOPz4WyfPbTbVv9Vr8FoC1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WeOBZV2H; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741818187; x=1773354187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1WBbeik5wi3drDYu/MVkynfo9xgawanZNjF0eIfzg0I=;
  b=WeOBZV2HOjo8vosKzUaE/ZM9hUxaUtTtuKqVsDA8EyPwwwC1wf1BaCEd
   BKh1Tl77qpSKBp5EIjHMo+2QgVgXJ2QKhjp5T+35ZKozS7ms8qigUUH23
   HWG7CfBLTjD3LQtKTMMPUi82M/7o+q4rbmGhvPJcOF8bMkc+U0BFGmXjW
   o6C/+UZpNwUL4bwoElCbqVXnCdavnEP4JSxZYDW3tQdyfXNXzfpoEkKaQ
   ommWk8oGi82KW2ZlZSB+QMTXFXeF3RRYfjMk0mczobj/OPhfNaJNsOeQy
   uLM7rJmxFNX8CGBNMPMysUyC82L4cWwxbHpDRYO9BXjD2sO0JhSSXIb+u
   Q==;
X-CSE-ConnectionGUID: uNqKldcLSjyZAE6C6Yj6+g==
X-CSE-MsgGUID: ZZky04kXRaCiqaTEv/kUjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42826756"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42826756"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:23:07 -0700
X-CSE-ConnectionGUID: ddohUVDFQ8q2f2AXcN/JnA==
X-CSE-MsgGUID: He8AHmrGSLuW+Knjq78Kmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="121267394"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:23:05 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 10/15] wifi: iwlwifi: mld: KUnit: test iwl_mld_channel_load_allows_emlsr
Date: Thu, 13 Mar 2025 00:22:33 +0200
Message-Id: <20250313002008.06fdf416c62f.If6e8f0e017287e79364eac9366f93c9ab964a673@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
References: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Add tests to check that iwl_mld_channel_load_allows_emlsr decides
correctly whether EMLSR is allowed or not.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  |   9 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h  |  14 ++
 .../intel/iwlwifi/mld/tests/link-selection.c  | 131 ++++++++++++++++++
 3 files changed, 147 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index 9342f03c0908..dac72644ec78 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -602,12 +602,6 @@ void iwl_mld_emlsr_unblock_tpt_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 /*
  * Link selection
  */
-struct iwl_mld_link_sel_data {
-	u8 link_id;
-	const struct cfg80211_chan_def *chandef;
-	s32 signal;
-	u16 grade;
-};
 
 s8 iwl_mld_get_emlsr_rssi_thresh(struct iwl_mld *mld,
 				 const struct cfg80211_chan_def *chandef,
@@ -737,7 +731,7 @@ iwl_mld_get_min_chan_load_thresh(struct ieee80211_chanctx_conf *chanctx)
 	return 10;
 }
 
-static bool
+VISIBLE_IF_KUNIT bool
 iwl_mld_channel_load_allows_emlsr(struct iwl_mld *mld,
 				  struct ieee80211_vif *vif,
 				  const struct iwl_mld_link_sel_data *a,
@@ -794,6 +788,7 @@ iwl_mld_channel_load_allows_emlsr(struct iwl_mld *mld,
 
 	return false;
 }
+EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mld_channel_load_allows_emlsr);
 
 static bool
 iwl_mld_valid_emlsr_pair(struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.h b/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
index 6c652c17069f..4fb1fdbe3df9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
@@ -150,4 +150,18 @@ void iwl_mld_emlsr_check_chan_load(struct ieee80211_hw *hw,
  */
 void iwl_mld_retry_emlsr(struct iwl_mld *mld, struct ieee80211_vif *vif);
 
+struct iwl_mld_link_sel_data {
+	u8 link_id;
+	const struct cfg80211_chan_def *chandef;
+	s32 signal;
+	u16 grade;
+};
+
+#if IS_ENABLED(CONFIG_IWLWIFI_KUNIT_TESTS)
+bool iwl_mld_channel_load_allows_emlsr(struct iwl_mld *mld,
+				       struct ieee80211_vif *vif,
+				       const struct iwl_mld_link_sel_data *a,
+				       const struct iwl_mld_link_sel_data *b);
+#endif
+
 #endif /* __iwl_mld_mlo_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c
index 34782569d67e..295dcfd3f85d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c
@@ -11,6 +11,7 @@
 #include "link.h"
 #include "iface.h"
 #include "phy.h"
+#include "mlo.h"
 
 static const struct link_grading_test_case {
 	const char *desc;
@@ -170,3 +171,133 @@ static struct kunit_suite link_selection = {
 };
 
 kunit_test_suite(link_selection);
+
+static const struct channel_load_case {
+	const char *desc;
+	bool low_latency_vif;
+	u32 chan_load_not_by_us;
+	enum nl80211_chan_width bw_a;
+	enum nl80211_chan_width bw_b;
+	bool primary_link_active;
+	bool expected_result;
+} channel_load_cases[] = {
+	{
+		.desc = "Unequal bandwidth, primary link inactive, EMLSR not allowed",
+		.low_latency_vif = false,
+		.primary_link_active = false,
+		.bw_a = NL80211_CHAN_WIDTH_40,
+		.bw_b = NL80211_CHAN_WIDTH_20,
+		.expected_result = false,
+	},
+	{
+		.desc = "Equal bandwidths, sufficient channel load, EMLSR allowed",
+		.low_latency_vif = false,
+		.primary_link_active = true,
+		.chan_load_not_by_us = 11,
+		.bw_a = NL80211_CHAN_WIDTH_40,
+		.bw_b = NL80211_CHAN_WIDTH_40,
+		.expected_result = true,
+	},
+	{
+		.desc = "Equal bandwidths, insufficient channel load, EMLSR not allowed",
+		.low_latency_vif = false,
+		.primary_link_active = true,
+		.chan_load_not_by_us = 6,
+		.bw_a = NL80211_CHAN_WIDTH_80,
+		.bw_b = NL80211_CHAN_WIDTH_80,
+		.expected_result = false,
+	},
+	{
+		.desc = "Low latency VIF, sufficient channel load, EMLSR allowed",
+		.low_latency_vif = true,
+		.primary_link_active = true,
+		.chan_load_not_by_us = 6,
+		.bw_a = NL80211_CHAN_WIDTH_160,
+		.bw_b = NL80211_CHAN_WIDTH_160,
+		.expected_result = true,
+	},
+	{
+		.desc = "Different bandwidths (2x ratio), primary link load permits EMLSR",
+		.low_latency_vif = false,
+		.primary_link_active = true,
+		.chan_load_not_by_us = 30,
+		.bw_a = NL80211_CHAN_WIDTH_40,
+		.bw_b = NL80211_CHAN_WIDTH_20,
+		.expected_result = true,
+	},
+	{
+		.desc = "Different bandwidths (4x ratio), primary link load permits EMLSR",
+		.low_latency_vif = false,
+		.primary_link_active = true,
+		.chan_load_not_by_us = 45,
+		.bw_a = NL80211_CHAN_WIDTH_80,
+		.bw_b = NL80211_CHAN_WIDTH_20,
+		.expected_result = true,
+	},
+	{
+		.desc = "Different bandwidths (16x ratio), primary link load insufficient",
+		.low_latency_vif = false,
+		.primary_link_active = true,
+		.chan_load_not_by_us = 45,
+		.bw_a = NL80211_CHAN_WIDTH_320,
+		.bw_b = NL80211_CHAN_WIDTH_20,
+		.expected_result = false,
+	},
+};
+
+KUNIT_ARRAY_PARAM_DESC(channel_load, channel_load_cases, desc);
+
+static void test_iwl_mld_channel_load_allows_emlsr(struct kunit *test)
+{
+	const struct channel_load_case *params = test->param_value;
+	struct iwl_mld *mld = test->priv;
+	struct ieee80211_vif *vif;
+	struct cfg80211_chan_def chandef_a, chandef_b;
+	struct iwl_mld_link_sel_data a = {.chandef = &chandef_a,
+					  .link_id = 4};
+	struct iwl_mld_link_sel_data b = {.chandef = &chandef_b,
+					  .link_id = 5};
+	struct iwl_mld_kunit_link assoc_link = {
+		.id = params->primary_link_active ? a.link_id : b.link_id,
+		.bandwidth = params->primary_link_active ? params->bw_a : params->bw_b,
+	};
+	bool result;
+
+	vif = iwlmld_kunit_setup_mlo_assoc(BIT(a.link_id) | BIT(b.link_id),
+					   &assoc_link);
+
+	chandef_a.width = params->bw_a;
+	chandef_b.width = params->bw_b;
+
+	if (params->low_latency_vif)
+		iwl_mld_vif_from_mac80211(vif)->low_latency_causes = 1;
+
+	wiphy_lock(mld->wiphy);
+
+	/* Simulate channel load */
+	if (params->primary_link_active) {
+		struct iwl_mld_phy *phy =
+			iwlmld_kunit_get_phy_of_link(vif, a.link_id);
+
+		phy->avg_channel_load_not_by_us = params->chan_load_not_by_us;
+	}
+
+	result = iwl_mld_channel_load_allows_emlsr(mld, vif, &a, &b);
+
+	wiphy_unlock(mld->wiphy);
+
+	KUNIT_EXPECT_EQ(test, result, params->expected_result);
+}
+
+static struct kunit_case channel_load_criteria_test_cases[] = {
+	KUNIT_CASE_PARAM(test_iwl_mld_channel_load_allows_emlsr, channel_load_gen_params),
+	{}
+};
+
+static struct kunit_suite channel_load_criteria_tests = {
+	.name = "iwlmld_channel_load_allows_emlsr",
+	.test_cases = channel_load_criteria_test_cases,
+	.init = iwlmld_kunit_test_init,
+};
+
+kunit_test_suite(channel_load_criteria_tests);
-- 
2.34.1


