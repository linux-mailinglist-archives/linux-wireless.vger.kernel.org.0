Return-Path: <linux-wireless+bounces-27054-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AA7B479A2
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 10:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01831B21586
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 08:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BB021B9FD;
	Sun,  7 Sep 2025 08:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a5hJc0iE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058DB2192E4
	for <linux-wireless@vger.kernel.org>; Sun,  7 Sep 2025 08:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757233862; cv=none; b=MLYMbAl38KHfBN0Y9LzBXd92jFboRCs7dDBI9EroknkKuimeSQQaEhPUgbM59/iFDioHmA638aW4o4pvvn9KjMVt43objk9q5bCWU/FmyKmPgrtZ4EGZ+OYXunJCfrNG1UEnx3uOvub08b3IaAt5ZtXMuc/rhm4gdQ4Q+2WoFHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757233862; c=relaxed/simple;
	bh=i2gSSTJoCecaCKhQcFthV2Ban1NM05d8TyHL6KVRX9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lgEPHYxtZexj5CUz8FnWSM2GMAYmeFNARHCUgPU8b5aDjl57liW8FNT9cd0poKOr4qLcQJrjuuEpTCQ2PNeH2VJKVB9Fq8ZadEjRDYGRCqmtYpksT90k362wmP0elx2NQjOPIj+DkqweqBF9d9wc1gq8rkTa9qCX/etZcFNKzz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a5hJc0iE; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757233861; x=1788769861;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i2gSSTJoCecaCKhQcFthV2Ban1NM05d8TyHL6KVRX9g=;
  b=a5hJc0iE6m4DOh+/D+OO23OvGsRUr2haEmKPOwdlTwWhmC8r79tRt9KQ
   NU3FNX3/K0FB/Hmij5QFcZEC9e1S9o4nPL+AqfXF3S4i/KM6eHx5y1R1I
   Cmu8Vlvoik/7459y7l7BxBgzg8NDYCyNk+HNVg9P/ez3hflgG02saCz7t
   935pXaGEAo4MPOMuRKlWCNX33SCkYMcDu/JX6KlTejV9/soK2GFMik7VC
   SZ+qfV7taPCizjhLRrVF5Id+DefFaA1G3d8c7TXoiQqIPGm+nA5JpTW6R
   jdqJ163u093PNfr5VWa3MkCSQ3hMx3hop9FVaQ2BVPaftOxYrhLTY3jbJ
   w==;
X-CSE-ConnectionGUID: 1GI2cNi2RwK/OuQ6B1DMcg==
X-CSE-MsgGUID: HwtxSPEXQT2GNBxkMXLOzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="76973613"
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="76973613"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:31:01 -0700
X-CSE-ConnectionGUID: wkVAV+MGS32PZOzAjXs0pw==
X-CSE-MsgGUID: Zd4KQsBHQKOlhJxFL3q4CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="171790052"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:31:00 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: add kunit tests for nvm parse
Date: Sun,  7 Sep 2025 11:30:06 +0300
Message-Id: <20250907112757.a7a4713fbfee.Ia0caf8865e63b40826c9b66084bd20438554f15c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250907083014.1439961-1-miriam.rachel.korenblit@intel.com>
References: <20250907083014.1439961-1-miriam.rachel.korenblit@intel.com>
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


