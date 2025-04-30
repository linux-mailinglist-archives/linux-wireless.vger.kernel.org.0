Return-Path: <linux-wireless+bounces-22247-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FD0AA4B04
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 14:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16F7F1BC307A
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 12:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F21324729E;
	Wed, 30 Apr 2025 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZeMD8x+Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5259225A344
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746015891; cv=none; b=mhHqkNoxxbGgIpBiVTAlWaYRdNMV91d+c0p5PBqIRAWC5qBI0mEgOHaIZA68eP2OuvQZ8DWxQtCL5VYwJnCzn9ihEpijtdAhI9bXDmwgQEK704k5PqawFykKNCooeq60gLbkkIdW7FUBx/UMNEO5gTQ8viKnJpYWDVoZHdr1Nks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746015891; c=relaxed/simple;
	bh=228IVMn9M/BbkMyu+ZqpLiSkwA67qztJMOtcoqX2tns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SyDsgaDHn+l+FCXi4R3faOXquCJ17JKnGv7zjClqaybPxf7ruUK8u+ZnktLXhaYjJppVD51o9nUQcd8ww7UmIHHA3SSut7K4cD/OxizTDVtP7cD59wcTwBl2+EzUA6uzYtPGUodWXlm/bpoe9SkgULoQGV0+1Zk4ArME6+/kjkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZeMD8x+Q; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746015889; x=1777551889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=228IVMn9M/BbkMyu+ZqpLiSkwA67qztJMOtcoqX2tns=;
  b=ZeMD8x+QQtuxSaJovnKlHjLOXKn3bLB6yJ14/0E8HUDh9F0aHn6uMxCh
   Gv1E906EYT6gvlAw39zO1xsyFPzDDgfwrRjEskUfx05hOQwVs8j4v7IxE
   OqWjxC5xviPrrrUOJWJ/LNH7trMwVkIqjW8RqrkGDcFrdllKrj0Y/w7oC
   TPfJRj9h92ABqJEU7FyDSyyu5fiHyY9jAIXKVGwOf3WNH9A7eLPvoGE3v
   Y6G1T9mhtz4isBqNLRYEj2R1xoAa75+Ju8OSzbyorAnAFPEiKfCEwn6sg
   Bx+AkH8svW+u1vwqN6d25ydKJLGtf1i1uL/S2cYMEoHBPWSbI+ucSCVXi
   A==;
X-CSE-ConnectionGUID: af2ePUhZTaO2UrRw0FxJaw==
X-CSE-MsgGUID: N8yWit5ETfWJ/FrDJC6Qkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47578263"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="47578263"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:24:48 -0700
X-CSE-ConnectionGUID: NQpsyskESQOGs3SuUgciIg==
X-CSE-MsgGUID: W/jUOnOfQ6iUCw2sCAyhPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="135087852"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:24:47 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 04/14] wifi: iwlwifi: mld: refactor tests to use chandefs
Date: Wed, 30 Apr 2025 15:23:10 +0300
Message-Id: <20250430151952.6643fa8773f1.I644e9053d222a772e1d109799c4bfa0677add4d7@changeid>
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

Instead of building invalid chandefs on the fly, use only
chandefs throughout and ensure those are valid. Also add
more chandefs that will be needed for new tests.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../intel/iwlwifi/mld/tests/link-selection.c  | 60 ++++++-------
 .../wireless/intel/iwlwifi/mld/tests/link.c   |  4 +-
 .../wireless/intel/iwlwifi/mld/tests/utils.c  | 37 +++++++-
 .../wireless/intel/iwlwifi/mld/tests/utils.h  | 84 ++++++++++---------
 4 files changed, 110 insertions(+), 75 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c
index 295dcfd3f85d..b44d63f95ade 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c
@@ -32,7 +32,7 @@ static const struct link_grading_test_case {
 		.desc = "channel util of 128 (50%)",
 		.input.link = {
 			.link_id = 0,
-			.chandef = &chandef_2ghz,
+			.chandef = &chandef_2ghz_20mhz,
 			.active = false,
 			.has_chan_util_elem = true,
 			.chan_util = 128,
@@ -43,7 +43,7 @@ static const struct link_grading_test_case {
 		.desc = "channel util of 180 (70%)",
 		.input.link = {
 			.link_id = 0,
-			.chandef = &chandef_2ghz,
+			.chandef = &chandef_2ghz_20mhz,
 			.active = false,
 			.has_chan_util_elem = true,
 			.chan_util = 180,
@@ -54,7 +54,7 @@ static const struct link_grading_test_case {
 		.desc = "channel util of 180 (70%), channel load by us of 10%",
 		.input.link = {
 			.link_id = 0,
-			.chandef = &chandef_2ghz,
+			.chandef = &chandef_2ghz_20mhz,
 			.has_chan_util_elem = true,
 			.chan_util = 180,
 			.active = true,
@@ -66,7 +66,7 @@ static const struct link_grading_test_case {
 		.desc = "no channel util element",
 		.input.link = {
 			.link_id = 0,
-			.chandef = &chandef_2ghz,
+			.chandef = &chandef_2ghz_20mhz,
 			.active = true,
 		},
 		.expected_grade = 120,
@@ -132,7 +132,7 @@ static void test_link_grading(struct kunit *test)
 	bool active = test_param->input.link.active;
 	u16 valid_links;
 	struct iwl_mld_kunit_link assoc_link = {
-		.band = test_param->input.link.chandef->chan->band,
+		.chandef = test_param->input.link.chandef,
 	};
 
 	/* If the link is not active, use a different link as the assoc link */
@@ -174,10 +174,9 @@ kunit_test_suite(link_selection);
 
 static const struct channel_load_case {
 	const char *desc;
+	const struct cfg80211_chan_def *chandef_a, *chandef_b;
 	bool low_latency_vif;
 	u32 chan_load_not_by_us;
-	enum nl80211_chan_width bw_a;
-	enum nl80211_chan_width bw_b;
 	bool primary_link_active;
 	bool expected_result;
 } channel_load_cases[] = {
@@ -185,8 +184,8 @@ static const struct channel_load_case {
 		.desc = "Unequal bandwidth, primary link inactive, EMLSR not allowed",
 		.low_latency_vif = false,
 		.primary_link_active = false,
-		.bw_a = NL80211_CHAN_WIDTH_40,
-		.bw_b = NL80211_CHAN_WIDTH_20,
+		.chandef_a = &chandef_5ghz_40mhz,
+		.chandef_b = &chandef_6ghz_20mhz,
 		.expected_result = false,
 	},
 	{
@@ -194,8 +193,8 @@ static const struct channel_load_case {
 		.low_latency_vif = false,
 		.primary_link_active = true,
 		.chan_load_not_by_us = 11,
-		.bw_a = NL80211_CHAN_WIDTH_40,
-		.bw_b = NL80211_CHAN_WIDTH_40,
+		.chandef_a = &chandef_5ghz_40mhz,
+		.chandef_b = &chandef_6ghz_40mhz,
 		.expected_result = true,
 	},
 	{
@@ -203,8 +202,8 @@ static const struct channel_load_case {
 		.low_latency_vif = false,
 		.primary_link_active = true,
 		.chan_load_not_by_us = 6,
-		.bw_a = NL80211_CHAN_WIDTH_80,
-		.bw_b = NL80211_CHAN_WIDTH_80,
+		.chandef_a = &chandef_5ghz_80mhz,
+		.chandef_b = &chandef_6ghz_80mhz,
 		.expected_result = false,
 	},
 	{
@@ -212,8 +211,8 @@ static const struct channel_load_case {
 		.low_latency_vif = true,
 		.primary_link_active = true,
 		.chan_load_not_by_us = 6,
-		.bw_a = NL80211_CHAN_WIDTH_160,
-		.bw_b = NL80211_CHAN_WIDTH_160,
+		.chandef_a = &chandef_5ghz_160mhz,
+		.chandef_b = &chandef_6ghz_160mhz,
 		.expected_result = true,
 	},
 	{
@@ -221,8 +220,8 @@ static const struct channel_load_case {
 		.low_latency_vif = false,
 		.primary_link_active = true,
 		.chan_load_not_by_us = 30,
-		.bw_a = NL80211_CHAN_WIDTH_40,
-		.bw_b = NL80211_CHAN_WIDTH_20,
+		.chandef_a = &chandef_5ghz_40mhz,
+		.chandef_b = &chandef_6ghz_20mhz,
 		.expected_result = true,
 	},
 	{
@@ -230,8 +229,8 @@ static const struct channel_load_case {
 		.low_latency_vif = false,
 		.primary_link_active = true,
 		.chan_load_not_by_us = 45,
-		.bw_a = NL80211_CHAN_WIDTH_80,
-		.bw_b = NL80211_CHAN_WIDTH_20,
+		.chandef_a = &chandef_5ghz_80mhz,
+		.chandef_b = &chandef_6ghz_20mhz,
 		.expected_result = true,
 	},
 	{
@@ -239,8 +238,8 @@ static const struct channel_load_case {
 		.low_latency_vif = false,
 		.primary_link_active = true,
 		.chan_load_not_by_us = 45,
-		.bw_a = NL80211_CHAN_WIDTH_320,
-		.bw_b = NL80211_CHAN_WIDTH_20,
+		.chandef_a = &chandef_6ghz_320mhz,
+		.chandef_b = &chandef_5ghz_20mhz,
 		.expected_result = false,
 	},
 };
@@ -252,23 +251,24 @@ static void test_iwl_mld_channel_load_allows_emlsr(struct kunit *test)
 	const struct channel_load_case *params = test->param_value;
 	struct iwl_mld *mld = test->priv;
 	struct ieee80211_vif *vif;
-	struct cfg80211_chan_def chandef_a, chandef_b;
-	struct iwl_mld_link_sel_data a = {.chandef = &chandef_a,
-					  .link_id = 4};
-	struct iwl_mld_link_sel_data b = {.chandef = &chandef_b,
-					  .link_id = 5};
+	/* link A is the primary and link B is the secondary */
+	struct iwl_mld_link_sel_data a = {
+		.chandef = params->chandef_a,
+		.link_id = 4,
+	};
+	struct iwl_mld_link_sel_data b = {
+		.chandef = params->chandef_b,
+		.link_id = 5,
+	};
 	struct iwl_mld_kunit_link assoc_link = {
+		.chandef = params->primary_link_active ? a.chandef : b.chandef,
 		.id = params->primary_link_active ? a.link_id : b.link_id,
-		.bandwidth = params->primary_link_active ? params->bw_a : params->bw_b,
 	};
 	bool result;
 
 	vif = iwlmld_kunit_setup_mlo_assoc(BIT(a.link_id) | BIT(b.link_id),
 					   &assoc_link);
 
-	chandef_a.width = params->bw_a;
-	chandef_b.width = params->bw_b;
-
 	if (params->low_latency_vif)
 		iwl_mld_vif_from_mac80211(vif)->low_latency_causes = 1;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/link.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/link.c
index 4a4eaa134bd3..69a0d67858bf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/link.c
@@ -63,11 +63,11 @@ static void test_missed_beacon(struct kunit *test)
 	struct iwl_rx_packet *pkt;
 	struct iwl_mld_kunit_link link1 = {
 		.id = 0,
-		.band = NL80211_BAND_6GHZ,
+		.chandef = &chandef_6ghz_160mhz,
 	};
 	struct iwl_mld_kunit_link link2 = {
 		.id = 1,
-		.band = NL80211_BAND_5GHZ,
+		.chandef = &chandef_5ghz_80mhz,
 	};
 
 	kunit_activate_static_stub(test, ieee80211_connection_loss,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
index 9712ee696509..0a9a5677fa85 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
@@ -146,7 +146,7 @@ iwlmld_kunit_add_link(struct ieee80211_vif *vif, int link_id)
 }
 
 struct ieee80211_chanctx_conf *
-iwlmld_kunit_add_chanctx_from_def(struct cfg80211_chan_def *def)
+iwlmld_kunit_add_chanctx(const struct cfg80211_chan_def *def)
 {
 	struct kunit *test = kunit_get_current_test();
 	struct iwl_mld *mld = test->priv;
@@ -346,8 +346,7 @@ iwlmld_kunit_setup_assoc(bool mlo, struct iwl_mld_kunit_link *assoc_link)
 	else
 		link = &vif->bss_conf;
 
-	chan_ctx = iwlmld_kunit_add_chanctx(assoc_link->band,
-					    assoc_link->bandwidth);
+	chan_ctx = iwlmld_kunit_add_chanctx(assoc_link->chandef);
 
 	wiphy_lock(mld->wiphy);
 	iwlmld_kunit_assign_chanctx_to_link(vif, link, chan_ctx);
@@ -428,7 +427,7 @@ struct ieee80211_vif *iwlmld_kunit_assoc_emlsr(struct iwl_mld_kunit_link *link1,
 	link = wiphy_dereference(mld->wiphy, vif->link_conf[link2->id]);
 	KUNIT_EXPECT_NOT_NULL(test, link);
 
-	chan_ctx = iwlmld_kunit_add_chanctx(link2->band, link2->bandwidth);
+	chan_ctx = iwlmld_kunit_add_chanctx(link2->chandef);
 	iwlmld_kunit_assign_chanctx_to_link(vif, link, chan_ctx);
 
 	wiphy_unlock(mld->wiphy);
@@ -472,3 +471,33 @@ struct iwl_mld_phy *iwlmld_kunit_get_phy_of_link(struct ieee80211_vif *vif,
 
 	return iwl_mld_phy_from_mac80211(chanctx);
 }
+
+static const struct chandef_case {
+	const char *desc;
+	const struct cfg80211_chan_def *chandef;
+} chandef_cases[] = {
+#define CHANDEF(c, ...) { .desc = "chandef " #c " valid", .chandef = &c, },
+	CHANDEF_LIST
+#undef CHANDEF
+};
+
+KUNIT_ARRAY_PARAM_DESC(chandef, chandef_cases, desc);
+
+static void test_iwl_mld_chandef_valid(struct kunit *test)
+{
+	const struct chandef_case *params = test->param_value;
+
+	KUNIT_EXPECT_EQ(test, true, cfg80211_chandef_valid(params->chandef));
+}
+
+static struct kunit_case chandef_test_cases[] = {
+	KUNIT_CASE_PARAM(test_iwl_mld_chandef_valid, chandef_gen_params),
+	{}
+};
+
+static struct kunit_suite chandef_tests = {
+	.name = "iwlmld_valid_test_chandefs",
+	.test_cases = chandef_test_cases,
+};
+
+kunit_test_suite(chandef_tests);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.h b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.h
index d3723653cf1b..edf8eef4e81a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.h
@@ -14,9 +14,8 @@ struct iwl_mld;
 int iwlmld_kunit_test_init(struct kunit *test);
 
 struct iwl_mld_kunit_link {
+	const struct cfg80211_chan_def *chandef;
 	u8 id;
-	enum nl80211_band band;
-	enum nl80211_chan_width bandwidth;
 };
 
 enum nl80211_iftype;
@@ -42,50 +41,57 @@ static struct ieee80211_channel _name = {			\
 	.hw_value = (_freq),					\
 }
 
-#define CHANDEF(_name, _channel, _freq1, _width)		\
-__maybe_unused static struct cfg80211_chan_def _name = {	\
-	.chan = &(_channel),					\
-	.center_freq1 = (_freq1),				\
-	.width = (_width),					\
-}
-
 CHANNEL(chan_2ghz, NL80211_BAND_2GHZ, 2412);
+CHANNEL(chan_2ghz_11, NL80211_BAND_2GHZ, 2462);
 CHANNEL(chan_5ghz, NL80211_BAND_5GHZ, 5200);
+CHANNEL(chan_5ghz_120, NL80211_BAND_5GHZ, 5600);
 CHANNEL(chan_6ghz, NL80211_BAND_6GHZ, 6115);
+CHANNEL(chan_6ghz_221, NL80211_BAND_6GHZ, 7055);
 /* Feel free to add more */
+#undef CHANNEL
+
+#define CHANDEF_LIST \
+	CHANDEF(chandef_2ghz_20mhz, chan_2ghz, 2412,		\
+		NL80211_CHAN_WIDTH_20)				\
+	CHANDEF(chandef_2ghz_40mhz, chan_2ghz, 2422,		\
+		NL80211_CHAN_WIDTH_40)				\
+	CHANDEF(chandef_2ghz_11_20mhz, chan_2ghz_11, 2462,	\
+		NL80211_CHAN_WIDTH_20)				\
+	CHANDEF(chandef_5ghz_20mhz, chan_5ghz, 5200,		\
+		NL80211_CHAN_WIDTH_20)				\
+	CHANDEF(chandef_5ghz_40mhz, chan_5ghz, 5210,		\
+		NL80211_CHAN_WIDTH_40)				\
+	CHANDEF(chandef_5ghz_80mhz, chan_5ghz, 5210,		\
+		NL80211_CHAN_WIDTH_80)				\
+	CHANDEF(chandef_5ghz_160mhz, chan_5ghz, 5250,		\
+		NL80211_CHAN_WIDTH_160)				\
+	CHANDEF(chandef_5ghz_120_40mhz, chan_5ghz_120, 5610,	\
+		NL80211_CHAN_WIDTH_40)				\
+	CHANDEF(chandef_6ghz_20mhz, chan_6ghz, 6115,		\
+		NL80211_CHAN_WIDTH_20)				\
+	CHANDEF(chandef_6ghz_40mhz, chan_6ghz, 6125,		\
+		NL80211_CHAN_WIDTH_40)				\
+	CHANDEF(chandef_6ghz_80mhz, chan_6ghz, 6145,		\
+		NL80211_CHAN_WIDTH_80)				\
+	CHANDEF(chandef_6ghz_160mhz, chan_6ghz, 6185,		\
+		NL80211_CHAN_WIDTH_160)				\
+	CHANDEF(chandef_6ghz_320mhz, chan_6ghz, 6105,		\
+		NL80211_CHAN_WIDTH_320)				\
+	CHANDEF(chandef_6ghz_221_160mhz, chan_6ghz_221, 6985,	\
+		NL80211_CHAN_WIDTH_160)				\
+	/* Feel free to add more */
 
-CHANDEF(chandef_2ghz, chan_2ghz, 2412, NL80211_CHAN_WIDTH_20);
-CHANDEF(chandef_5ghz, chan_5ghz, 5200, NL80211_CHAN_WIDTH_40);
-CHANDEF(chandef_6ghz, chan_6ghz, 6115, NL80211_CHAN_WIDTH_160);
-/* Feel free to add more */
-
-//struct cfg80211_chan_def;
+#define CHANDEF(_name, _channel, _freq1, _width)		\
+__maybe_unused static const struct cfg80211_chan_def _name = {	\
+	.chan = &(_channel),					\
+	.center_freq1 = (_freq1),				\
+	.width = (_width),					\
+};
+CHANDEF_LIST
+#undef CHANDEF
 
 struct ieee80211_chanctx_conf *
-iwlmld_kunit_add_chanctx_from_def(struct cfg80211_chan_def *def);
-
-static inline struct ieee80211_chanctx_conf *
-iwlmld_kunit_add_chanctx(enum nl80211_band band, enum nl80211_chan_width width)
-{
-	struct cfg80211_chan_def chandef;
-
-	switch (band) {
-	case NL80211_BAND_2GHZ:
-		chandef = chandef_2ghz;
-		break;
-	case NL80211_BAND_5GHZ:
-		chandef = chandef_5ghz;
-		break;
-	default:
-	case NL80211_BAND_6GHZ:
-		chandef = chandef_6ghz;
-		break;
-	}
-
-	chandef.width = width;
-
-	return iwlmld_kunit_add_chanctx_from_def(&chandef);
-}
+iwlmld_kunit_add_chanctx(const struct cfg80211_chan_def *def);
 
 void iwlmld_kunit_assign_chanctx_to_link(struct ieee80211_vif *vif,
 					 struct ieee80211_bss_conf *link,
-- 
2.34.1


