Return-Path: <linux-wireless+bounces-27126-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCD6B49FF7
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 05:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987271B24638
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 03:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B6C2797BD;
	Tue,  9 Sep 2025 03:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RJ179dyb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26999274FCE
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 03:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757388127; cv=none; b=CORVXTIYGgW/ttafNn1OwKhOjL9llXRbVj/317zov/DDGge8A/KIM7YTt8pNkQWp1GS6PRlMrlCjRzUuyO6FvgqQKJi0yK3lJ+WKZ2DFMawHYTwDYlXSpIvzxhqjkTP3cDUhJ2bP2M/M7k4F6JpQlp/wgSZgDpMqarR6D7n6DMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757388127; c=relaxed/simple;
	bh=i2gSSTJoCecaCKhQcFthV2Ban1NM05d8TyHL6KVRX9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j8gO0EhYF/v1Nnc8wz5He+OMdNT1/CFYN6bCvdt8WC/c7Nd5yyNxYp7xPSW7TzkCXsC5dU4SwmcflWVYUNTfJ9K6XpRGdvsyS6LtfCvoLBQqR2Z32EWTbfsK579r4xdXtrWb6XN7DJ3K01T7m+LTdqUJb1FFUBzBPEcPFBVbPnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RJ179dyb; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757388125; x=1788924125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i2gSSTJoCecaCKhQcFthV2Ban1NM05d8TyHL6KVRX9g=;
  b=RJ179dybCtlm1Hv57DBq66H4+g7ZTCURmF2gchrdmDu5E/jKcvZUIR5S
   ki+rk9k3tPSlL7n+6NGHH/I/9uhq7adBqO/3/AkCJR7nHBGELPC4/wV8y
   keMNcZ+E7BBxS8L12rX7fu9JAGjQyRjFRkBUWHeRQADEW96Ug3CJdqtud
   qiMTPMdMvvTUvIcuM2xifwWyl0puRVSTz5x4/M+Is9vIIW9IwwRj1/FbX
   kSpDoXKca6xiJF2MOM/RSiwovRHsybjJSfBHYtDUpnAgm722BqMhOkrFc
   8LIYOwOPVZz/rAeZzeZCMW5NUOSEOng17cqVjzjjqEahh1LBbV25EWChc
   A==;
X-CSE-ConnectionGUID: dUHzcdt6Q42DKG//JYl40Q==
X-CSE-MsgGUID: 2h7G2+3+R8CoKf+H8H9rZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="70281061"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="70281061"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:22:05 -0700
X-CSE-ConnectionGUID: ABnXwF7iQjaq8TNrLsHMWQ==
X-CSE-MsgGUID: 9+sFSU/LTbu15VaUGgGfgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="203950375"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:22:03 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH v2 iwlwifi-next 07/15] wifi: iwlwifi: add kunit tests for nvm parse
Date: Tue,  9 Sep 2025 06:21:20 +0300
Message-Id: <20250909061931.a7a4713fbfee.Ia0caf8865e63b40826c9b66084bd20438554f15c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909032128.3318193-1-miriam.rachel.korenblit@intel.com>
References: <20250909032128.3318193-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

nvm flags is part of nvm parse. Add test for VLP AP/CLIENT
enable/disable scenarios.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 76 ++-----------------
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    | 74 ++++++++++++++++++
 .../net/wireless/intel/iwlwifi/tests/Makefile |  2 +-
 .../wireless/intel/iwlwifi/tests/nvm_parse.c  | 72 ++++++++++++++++++
 4 files changed, 152 insertions(+), 72 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/tests/nvm_parse.c

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index c03f057ecddd..23465e4c4b39 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -139,50 +139,6 @@ static struct ieee80211_rate iwl_cfg80211_rates[] = {
 #define RATES_52_OFFS	4
 #define N_RATES_52	(N_RATES_24 - RATES_52_OFFS)
 
-/**
- * enum iwl_nvm_channel_flags - channel flags in NVM
- * @NVM_CHANNEL_VALID: channel is usable for this SKU/geo
- * @NVM_CHANNEL_IBSS: usable as an IBSS channel and deprecated
- *	when %IWL_NVM_SBANDS_FLAGS_LAR enabled.
- * @NVM_CHANNEL_ALLOW_20MHZ_ACTIVITY: active scanning allowed and
- *	AP allowed only in 20 MHz. Valid only
- *	when %IWL_NVM_SBANDS_FLAGS_LAR enabled.
- * @NVM_CHANNEL_ACTIVE: active scanning allowed and allows IBSS
- *	when %IWL_NVM_SBANDS_FLAGS_LAR enabled.
- * @NVM_CHANNEL_RADAR: radar detection required
- * @NVM_CHANNEL_INDOOR_ONLY: only indoor use is allowed
- * @NVM_CHANNEL_GO_CONCURRENT: GO operation is allowed when connected to BSS
- *	on same channel on 2.4 or same UNII band on 5.2
- * @NVM_CHANNEL_UNIFORM: uniform spreading required
- * @NVM_CHANNEL_20MHZ: 20 MHz channel okay
- * @NVM_CHANNEL_40MHZ: 40 MHz channel okay
- * @NVM_CHANNEL_80MHZ: 80 MHz channel okay
- * @NVM_CHANNEL_160MHZ: 160 MHz channel okay
- * @NVM_CHANNEL_DC_HIGH: DC HIGH required/allowed (?)
- * @NVM_CHANNEL_VLP: client support connection to UHB VLP AP
- * @NVM_CHANNEL_AFC: client support connection to UHB AFC AP
- * @NVM_CHANNEL_VLP_AP_NOT_ALLOWED: UHB VLP AP not allowed,
- *	Valid only when %NVM_CHANNEL_VLP is enabled.
- */
-enum iwl_nvm_channel_flags {
-	NVM_CHANNEL_VALID			= BIT(0),
-	NVM_CHANNEL_IBSS			= BIT(1),
-	NVM_CHANNEL_ALLOW_20MHZ_ACTIVITY	= BIT(2),
-	NVM_CHANNEL_ACTIVE			= BIT(3),
-	NVM_CHANNEL_RADAR			= BIT(4),
-	NVM_CHANNEL_INDOOR_ONLY			= BIT(5),
-	NVM_CHANNEL_GO_CONCURRENT		= BIT(6),
-	NVM_CHANNEL_UNIFORM			= BIT(7),
-	NVM_CHANNEL_20MHZ			= BIT(8),
-	NVM_CHANNEL_40MHZ			= BIT(9),
-	NVM_CHANNEL_80MHZ			= BIT(10),
-	NVM_CHANNEL_160MHZ			= BIT(11),
-	NVM_CHANNEL_DC_HIGH			= BIT(12),
-	NVM_CHANNEL_VLP				= BIT(13),
-	NVM_CHANNEL_AFC				= BIT(14),
-	NVM_CHANNEL_VLP_AP_NOT_ALLOWED		= BIT(15),
-};
-
 /**
  * enum iwl_reg_capa_flags_v1 - global flags applied for the whole regulatory
  * domain.
@@ -282,30 +238,6 @@ enum iwl_reg_capa_flags_v4 {
  */
 #define REG_CAPA_V4_RESP_VER	8
 
-/**
- * struct iwl_reg_capa - struct for global regulatory capabilities, Used for
- * handling the different APIs of reg_capa_flags.
- *
- * @allow_40mhz: 11n channel with a width of 40Mhz is allowed
- *	for this regulatory domain.
- * @allow_80mhz: 11ac channel with a width of 80Mhz is allowed
- *	for this regulatory domain (valid only in 5 and 6 Ghz).
- * @allow_160mhz: 11ac channel with a width of 160Mhz is allowed
- *	for this regulatory domain (valid only in 5 and 6 Ghz).
- * @allow_320mhz: 11be channel with a width of 320Mhz is allowed
- *	for this regulatory domain (valid only in 6 Ghz).
- * @disable_11ax: 11ax is forbidden for this regulatory domain.
- * @disable_11be: 11be is forbidden for this regulatory domain.
- */
-struct iwl_reg_capa {
-	bool allow_40mhz;
-	bool allow_80mhz;
-	bool allow_160mhz;
-	bool allow_320mhz;
-	bool disable_11ax;
-	bool disable_11be;
-};
-
 static inline void iwl_nvm_print_channel_flags(struct device *dev, u32 level,
 					       int chan, u32 flags)
 {
@@ -1596,9 +1528,10 @@ iwl_parse_nvm_data(struct iwl_trans *trans, const struct iwl_rf_cfg *cfg,
 }
 IWL_EXPORT_SYMBOL(iwl_parse_nvm_data);
 
-static u32 iwl_nvm_get_regdom_bw_flags(const u16 *nvm_chan,
-				       int ch_idx, u16 nvm_flags,
-				       struct iwl_reg_capa reg_capa)
+VISIBLE_IF_IWLWIFI_KUNIT
+u32 iwl_nvm_get_regdom_bw_flags(const u16 *nvm_chan,
+				int ch_idx, u16 nvm_flags,
+				struct iwl_reg_capa reg_capa)
 {
 	u32 flags = NL80211_RRF_NO_HT40;
 
@@ -1688,6 +1621,7 @@ static u32 iwl_nvm_get_regdom_bw_flags(const u16 *nvm_chan,
 
 	return flags;
 }
+EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_nvm_get_regdom_bw_flags);
 
 static struct iwl_reg_capa iwl_get_reg_capa(u32 flags, u8 resp_ver)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
index 9ce9fa4e78fd..cbc92abf9f87 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
@@ -21,6 +21,80 @@ enum iwl_nvm_sbands_flags {
 	IWL_NVM_SBANDS_FLAGS_NO_WIDE_IN_5GHZ	= BIT(1),
 };
 
+/**
+ * struct iwl_reg_capa - struct for global regulatory capabilities, Used for
+ * handling the different APIs of reg_capa_flags.
+ *
+ * @allow_40mhz: 11n channel with a width of 40Mhz is allowed
+ *	for this regulatory domain.
+ * @allow_80mhz: 11ac channel with a width of 80Mhz is allowed
+ *	for this regulatory domain (valid only in 5 and 6 Ghz).
+ * @allow_160mhz: 11ac channel with a width of 160Mhz is allowed
+ *	for this regulatory domain (valid only in 5 and 6 Ghz).
+ * @allow_320mhz: 11be channel with a width of 320Mhz is allowed
+ *	for this regulatory domain (valid only in 6 Ghz).
+ * @disable_11ax: 11ax is forbidden for this regulatory domain.
+ * @disable_11be: 11be is forbidden for this regulatory domain.
+ */
+struct iwl_reg_capa {
+	bool allow_40mhz;
+	bool allow_80mhz;
+	bool allow_160mhz;
+	bool allow_320mhz;
+	bool disable_11ax;
+	bool disable_11be;
+};
+
+/**
+ * enum iwl_nvm_channel_flags - channel flags in NVM
+ * @NVM_CHANNEL_VALID: channel is usable for this SKU/geo
+ * @NVM_CHANNEL_IBSS: usable as an IBSS channel and deprecated
+ *	when %IWL_NVM_SBANDS_FLAGS_LAR enabled.
+ * @NVM_CHANNEL_ALLOW_20MHZ_ACTIVITY: active scanning allowed and
+ *	AP allowed only in 20 MHz. Valid only
+ *	when %IWL_NVM_SBANDS_FLAGS_LAR enabled.
+ * @NVM_CHANNEL_ACTIVE: active scanning allowed and allows IBSS
+ *	when %IWL_NVM_SBANDS_FLAGS_LAR enabled.
+ * @NVM_CHANNEL_RADAR: radar detection required
+ * @NVM_CHANNEL_INDOOR_ONLY: only indoor use is allowed
+ * @NVM_CHANNEL_GO_CONCURRENT: GO operation is allowed when connected to BSS
+ *	on same channel on 2.4 or same UNII band on 5.2
+ * @NVM_CHANNEL_UNIFORM: uniform spreading required
+ * @NVM_CHANNEL_20MHZ: 20 MHz channel okay
+ * @NVM_CHANNEL_40MHZ: 40 MHz channel okay
+ * @NVM_CHANNEL_80MHZ: 80 MHz channel okay
+ * @NVM_CHANNEL_160MHZ: 160 MHz channel okay
+ * @NVM_CHANNEL_DC_HIGH: DC HIGH required/allowed (?)
+ * @NVM_CHANNEL_VLP: client support connection to UHB VLP AP
+ * @NVM_CHANNEL_AFC: client support connection to UHB AFC AP
+ * @NVM_CHANNEL_VLP_AP_NOT_ALLOWED: UHB VLP AP not allowed,
+ *	Valid only when %NVM_CHANNEL_VLP is enabled.
+ */
+enum iwl_nvm_channel_flags {
+	NVM_CHANNEL_VALID			= BIT(0),
+	NVM_CHANNEL_IBSS			= BIT(1),
+	NVM_CHANNEL_ALLOW_20MHZ_ACTIVITY	= BIT(2),
+	NVM_CHANNEL_ACTIVE			= BIT(3),
+	NVM_CHANNEL_RADAR			= BIT(4),
+	NVM_CHANNEL_INDOOR_ONLY			= BIT(5),
+	NVM_CHANNEL_GO_CONCURRENT		= BIT(6),
+	NVM_CHANNEL_UNIFORM			= BIT(7),
+	NVM_CHANNEL_20MHZ			= BIT(8),
+	NVM_CHANNEL_40MHZ			= BIT(9),
+	NVM_CHANNEL_80MHZ			= BIT(10),
+	NVM_CHANNEL_160MHZ			= BIT(11),
+	NVM_CHANNEL_DC_HIGH			= BIT(12),
+	NVM_CHANNEL_VLP				= BIT(13),
+	NVM_CHANNEL_AFC				= BIT(14),
+	NVM_CHANNEL_VLP_AP_NOT_ALLOWED		= BIT(15),
+};
+
+#if IS_ENABLED(CONFIG_IWLWIFI_KUNIT_TESTS)
+u32 iwl_nvm_get_regdom_bw_flags(const u16 *nvm_chan,
+				int ch_idx, u16 nvm_flags,
+				struct iwl_reg_capa reg_capa);
+#endif
+
 /*
  * iwl_parse_nvm_data - parse NVM data and return values
  *
diff --git a/drivers/net/wireless/intel/iwlwifi/tests/Makefile b/drivers/net/wireless/intel/iwlwifi/tests/Makefile
index 1b49241c578f..b996c45d43e7 100644
--- a/drivers/net/wireless/intel/iwlwifi/tests/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/tests/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 
-iwlwifi-tests-y += module.o devinfo.o utils.o
+iwlwifi-tests-y += module.o devinfo.o utils.o nvm_parse.o
 
 ccflags-y += -I$(src)/../
 
diff --git a/drivers/net/wireless/intel/iwlwifi/tests/nvm_parse.c b/drivers/net/wireless/intel/iwlwifi/tests/nvm_parse.c
new file mode 100644
index 000000000000..853911900bfd
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/tests/nvm_parse.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit tests for NVM parse
+ *
+ * Copyright (C) 2025 Intel Corporation
+ */
+#include <kunit/static_stub.h>
+#include <kunit/test.h>
+#include <iwl-nvm-parse.h>
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+static const struct nvm_flag_case {
+	const char *desc;
+	u16 nvm_flags;
+	u32 reg_rule_flags;
+	u32 set_reg_rule_flags;
+	u32 clear_reg_rule_flags;
+} nvm_flag_cases[] = {
+	{
+		.desc = "Restricting VLP client and AP access",
+		.nvm_flags = 0,
+		.set_reg_rule_flags = NL80211_RRF_NO_6GHZ_VLP_CLIENT,
+		.clear_reg_rule_flags = NL80211_RRF_ALLOW_6GHZ_VLP_AP,
+	},
+	{
+		.desc = "Allow VLP client and AP access",
+		.nvm_flags = NVM_CHANNEL_VLP,
+		.set_reg_rule_flags = NL80211_RRF_ALLOW_6GHZ_VLP_AP,
+		.clear_reg_rule_flags = NL80211_RRF_NO_6GHZ_VLP_CLIENT,
+	},
+	{
+		.desc = "Allow VLP client access, while restricting AP access",
+		.nvm_flags = NVM_CHANNEL_VLP | NVM_CHANNEL_VLP_AP_NOT_ALLOWED,
+		.set_reg_rule_flags = 0,
+		.clear_reg_rule_flags = NL80211_RRF_ALLOW_6GHZ_VLP_AP |
+					NL80211_RRF_NO_6GHZ_VLP_CLIENT,
+	},
+};
+
+KUNIT_ARRAY_PARAM_DESC(nvm_flag, nvm_flag_cases, desc)
+
+static void test_nvm_flags(struct kunit *test)
+{
+	const struct nvm_flag_case *params = test->param_value;
+	struct iwl_reg_capa reg_capa = {};
+	u32 flags = 0;
+
+	flags = iwl_nvm_get_regdom_bw_flags(NULL, 0, params->nvm_flags,
+					    reg_capa);
+
+	if ((params->set_reg_rule_flags & flags) != params->set_reg_rule_flags)
+		KUNIT_FAIL(test, "Expected set bits:0x%08x flags:0x%08x\n",
+			   params->set_reg_rule_flags, flags);
+
+	if (params->clear_reg_rule_flags & flags)
+		KUNIT_FAIL(test, "Expected clear bits:0x%08x flags:0x%08x\n",
+			   params->clear_reg_rule_flags, flags);
+}
+
+static struct kunit_case nvm_flags_test_cases[] = {
+	KUNIT_CASE_PARAM(test_nvm_flags,
+			 nvm_flag_gen_params),
+	{},
+};
+
+static struct kunit_suite nvm_flags_suite = {
+	.name = "iwlwifi-nvm_flags",
+	.test_cases = nvm_flags_test_cases,
+};
+
+kunit_test_suite(nvm_flags_suite);
-- 
2.34.1


