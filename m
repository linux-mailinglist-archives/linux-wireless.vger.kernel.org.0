Return-Path: <linux-wireless+bounces-22209-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBB9AA1BA1
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 21:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352884A23D8
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 19:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA71D25FA3B;
	Tue, 29 Apr 2025 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b2UwKptR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28672550CC
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745956449; cv=none; b=Eh/oGdMXJtmD43qyLzdY5kKXdKPLIUrg79vAE0i/b8TUMs3t9gQqRYvDUOQpxJFhEtNKjGvqUW7PG8XfnY0HJB1EU1bLJBWlAE7jHCeg23g5gPrsrGH/JZiBmVUY4QHxlkIHNLDBCYi+UqXt9lH9EugPxyHjLw29ZMWaNQqUw2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745956449; c=relaxed/simple;
	bh=228IVMn9M/BbkMyu+ZqpLiSkwA67qztJMOtcoqX2tns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YlF10gBRb4ZP+njmjPT/zq8YYRR2Rn0Vfv+ez3kd2GqfYiWq6tyZvPGkk5QfVkEUbRx4SHCkGefeOm2LI9rte5y9ilOWpJfd9O+46Tl0KWTsNsV2qT3Gozl2QiQfndaGnn3QbLGHeGbl4/LcQ/7NnNeN7BsVSTNBtC+isqxMI5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b2UwKptR; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745956448; x=1777492448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=228IVMn9M/BbkMyu+ZqpLiSkwA67qztJMOtcoqX2tns=;
  b=b2UwKptRLZuDwcuFVDC/ktL6BkSdrWzziNAOQUnuxyXOTFlmgpZqRwZM
   R4o2sl3QTdZcDmOnakBUhPwJiOzWRbY11fjNC33GmGHLDVJesnrm8XCFh
   isOld6BAxA/FhJQNdqI4ElZDMYRO30m3A3oJxl70KVap0D5hOj3ss8c/f
   JxznWGYUq0X0iJudmFvlIkn4T2n4O44OTZBVTHPf8DbO1ZwWQq6miBdUu
   FT7vYo8+Y4WgvW1yhDo2nCZTFwCyos+xJKCC88INPxCAgxNpl0sXatT5v
   qVJqRt9gPS5GcSt+h73bl+HhFVw0uRA/PzTIfYzEHNZPdYsCYyhAlPKM5
   Q==;
X-CSE-ConnectionGUID: H4TWqDe5TOWdQhonT/XAaQ==
X-CSE-MsgGUID: XovUJrrQQcm8fNWMye8/Tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="46713538"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="46713538"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 12:54:08 -0700
X-CSE-ConnectionGUID: gTjt1K6UQbKjsLGB8Gfy1A==
X-CSE-MsgGUID: RTvEidp7QE63YqkVDk1r/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="171154992"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 12:54:06 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 04/14] wifi: iwlwifi: mld: refactor tests to use chandefs
Date: Tue, 29 Apr 2025 22:53:34 +0300
Message-Id: <20250429224932.6643fa8773f1.I644e9053d222a772e1d109799c4bfa0677add4d7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250429195344.254957-1-miriam.rachel.korenblit@intel.com>
References: <20250429195344.254957-1-miriam.rachel.korenblit@intel.com>
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


