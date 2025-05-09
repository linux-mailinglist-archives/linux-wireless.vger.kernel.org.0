Return-Path: <linux-wireless+bounces-22772-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50386AB10FE
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 12:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D04587B127A
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 10:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3289628F92B;
	Fri,  9 May 2025 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="alnd6JrY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09E528F524
	for <linux-wireless@vger.kernel.org>; Fri,  9 May 2025 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787515; cv=none; b=gykSCrdaB6/4j/JKqFHnW7Cg1kkbD3InGR72qra8n9jPDYXGt75ev7gxjpNJOrqMPcuBWo8dV+lv55mHP06Ur9jUMSM6a8+gKaZXYVQp0ju2uQCYzJBzmQP3TVGu5qVjt9YKx5Rfwo1kyKVoQILxW7ysoNNqwI5XdEOu7kaWHZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787515; c=relaxed/simple;
	bh=Jo4kUjta6aKTszev1TPzHq7FXI+EyzYRHZhiIJi48Xo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=azXR7UwvQ/JO5EbGTaav2myPwp5GbaLNgzUBoImdeuAu55wu8zBjO6ABqcI9iuIIoY9KDSY7MuUVzjicgxu2/t/ETxJlNtsZMfC2LL791zECw3K9AjUC1P23X259i4Z1Ti34rFN6EakkafxKRDed6Zaalfg/zbIyno4hhd7Nz/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=alnd6JrY; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746787513; x=1778323513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jo4kUjta6aKTszev1TPzHq7FXI+EyzYRHZhiIJi48Xo=;
  b=alnd6JrYCQgil41qqPsAN3Ju2SrcUxKZ9LJ1gWARBYTmoKlMSz4uIEjo
   UGIVtemRawTG3LrCc/6Q4xqqS4n6FFUTSCk6ws/sYcW4ZdJkEJ3yuiUTR
   JiFotT3K7hmzH9St3O4OyhAbpffZP01b0PwRwe9yp5ESxn7MGQRufgJ1r
   RUtMaj/uDzEWJtfnxUCKa5fEx45l1xHTo+JOr7Zj6aqq2ssoBAzJ7BQQK
   BMmZalQiUdiv10t7RL/d2GTLv+fXEeRzPPq8B/VjhKkmVqbT2KNjVq4oM
   BkmECMRS9U25pYt1dO00oThpLkyi7YUMqxicgIh7gXO2tSCKiW8OAtZ/k
   Q==;
X-CSE-ConnectionGUID: FtEB2qa/RqqVoxnN9I2ZrQ==
X-CSE-MsgGUID: REISrAKtTaWENuc2Ci0yTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59239882"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="59239882"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:45:12 -0700
X-CSE-ConnectionGUID: 0dM/srdrSWCQNBK91ziQAQ==
X-CSE-MsgGUID: zQ2wwX8xS4qEW6j75p6P4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="136537020"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:45:11 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: cfg: unify JF configs
Date: Fri,  9 May 2025 13:44:42 +0300
Message-Id: <20250509104454.2582160-4-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509104454.2582160-1-miriam.rachel.korenblit@intel.com>
References: <20250509104454.2582160-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Unify the JF configs to just one JF RF config. This can be
done because the differing fields (thermal and DCCM offsets)
won't be used for Qu MACs (and up) due to firmware support.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250509134302.8c5631e498bb.I5fb8b2d2465f51a91dd2704805141f81918ca577@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/Makefile   |  11 +-
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  16 ---
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |  56 --------
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |  11 --
 .../net/wireless/intel/iwlwifi/cfg/rf-jf.c    |  68 +++++++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   8 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 132 +++++++++---------
 7 files changed, 145 insertions(+), 157 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/rf-jf.c

diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile b/drivers/net/wireless/intel/iwlwifi/Makefile
index 23b17e24b117..9d850d5a447b 100644
--- a/drivers/net/wireless/intel/iwlwifi/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/Makefile
@@ -13,10 +13,17 @@ iwlwifi-objs		+= pcie/trans-gen2.o pcie/tx-gen2.o
 
 CFLAGS_pcie/drv.o += -Wno-override-init
 
-iwlwifi-$(CONFIG_IWLDVM) += cfg/1000.o cfg/2000.o cfg/5000.o cfg/6000.o
-iwlwifi-$(CONFIG_IWLMVM) += cfg/7000.o cfg/8000.o cfg/9000.o cfg/22000.o
+# combined MAC/RF configurations
+iwlwifi-$(CONFIG_IWLDVM) += cfg/1000.o cfg/2000.o
+iwlwifi-$(CONFIG_IWLDVM) += cfg/5000.o cfg/6000.o
+iwlwifi-$(CONFIG_IWLMVM) += cfg/7000.o cfg/8000.o
+# MAC configurations
+iwlwifi-$(CONFIG_IWLMVM) += cfg/9000.o cfg/22000.o
 iwlwifi-$(CONFIG_IWLMVM) += cfg/ax210.o
 iwlwifi-$(CONFIG_IWLMLD) += cfg/bz.o cfg/sc.o cfg/dr.o
+# RF configurations
+iwlwifi-$(CONFIG_IWLMVM) += cfg/rf-jf.o
+
 iwlwifi-objs		+= iwl-dbg-tlv.o
 iwlwifi-objs		+= iwl-trans.o
 
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 0ae910828704..4d49d0ab1604 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -131,22 +131,6 @@ const struct iwl_mac_cfg iwl_qu_long_latency_mac_cfg = {
 	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
 };
 
-/*
- * All JF radio modules are part of the 9000 series, but the MAC part
- * looks more like 22000.  That's why this device is here, but called
- * 9560 nevertheless.
- */
-const struct iwl_cfg iwl9560_qu_jf_cfg = {
-	IWL_DEVICE_22500,
-	.num_rbds = IWL_NUM_RBDS_NON_HE,
-};
-
-const struct iwl_cfg iwl9560_qu_jf_cfg_80mhz = {
-	IWL_DEVICE_22500,
-	.num_rbds = IWL_NUM_RBDS_NON_HE,
-	.bw_limit = 80,
-};
-
 const struct iwl_mac_cfg iwl_ax200_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_22000,
 	.base = &iwl_22000_base,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index e4f99cef6d7a..7bfe497bebb7 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -15,14 +15,7 @@
 /* Lowest firmware API version supported */
 #define IWL9000_UCODE_API_MIN	30
 
-/* NVM versions */
-#define IWL9000_NVM_VERSION		0x0a1d
-
 /* Memory offsets and lengths */
-#define IWL9000_DCCM_OFFSET		0x800000
-#define IWL9000_DCCM_LEN		0x18000
-#define IWL9000_DCCM2_OFFSET		0x880000
-#define IWL9000_DCCM2_LEN		0x8000
 #define IWL9000_SMEM_OFFSET		0x400000
 #define IWL9000_SMEM_LEN		0x68000
 
@@ -76,46 +69,6 @@ static const struct iwl_family_base_params iwl9000_base = {
 	.ucode_api_min = IWL9000_UCODE_API_MIN,
 };
 
-static const struct iwl_tt_params iwl9000_tt_params = {
-	.ct_kill_entry = 115,
-	.ct_kill_exit = 93,
-	.ct_kill_duration = 5,
-	.dynamic_smps_entry = 111,
-	.dynamic_smps_exit = 107,
-	.tx_protection_entry = 112,
-	.tx_protection_exit = 105,
-	.tx_backoff = {
-		{.temperature = 110, .backoff = 200},
-		{.temperature = 111, .backoff = 600},
-		{.temperature = 112, .backoff = 1200},
-		{.temperature = 113, .backoff = 2000},
-		{.temperature = 114, .backoff = 4000},
-	},
-	.support_ct_kill = true,
-	.support_dynamic_smps = true,
-	.support_tx_protection = true,
-	.support_tx_backoff = true,
-};
-
-#define IWL_DEVICE_9000							\
-	.led_mode = IWL_LED_RF_STATE,					\
-	.non_shared_ant = ANT_B,					\
-	.dccm_offset = IWL9000_DCCM_OFFSET,				\
-	.dccm_len = IWL9000_DCCM_LEN,					\
-	.dccm2_offset = IWL9000_DCCM2_OFFSET,				\
-	.dccm2_len = IWL9000_DCCM2_LEN,					\
-	.thermal_params = &iwl9000_tt_params,				\
-	.num_rbds = IWL_NUM_RBDS_NON_HE,				\
-	.vht_mu_mimo_supported = true,					\
-	.nvm_type = IWL_NVM_EXT,					\
-	.ht_params = {							\
-		.stbc = true,						\
-		.ldpc = true,						\
-		.ht40_bands = BIT(NL80211_BAND_2GHZ) |			\
-			      BIT(NL80211_BAND_5GHZ),			\
-	},								\
-	.nvm_ver = IWL9000_NVM_VERSION
-
 const struct iwl_mac_cfg iwl9000_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_9000,
 	.base = &iwl9000_base,
@@ -172,14 +125,5 @@ const char iwl9560_killer_1550s_name[] =
 const char iwl9560_killer_1550s_160_name[] =
 	"Killer(R) Wireless-AC 1550s Wireless Network Adapter (9560D2W) 160MHz";
 
-const struct iwl_cfg iwl9000_2ac_cfg = {
-	IWL_DEVICE_9000,
-};
-
-const struct iwl_cfg iwl9000_2ac_cfg_80mhz = {
-	IWL_DEVICE_9000,
-	.bw_limit = 80,
-};
-
 MODULE_FIRMWARE(IWL9000_MODULE_FIRMWARE(IWL9000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL9260_MODULE_FIRMWARE(IWL9000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 6d3c1e032265..6c15bdff7c34 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -167,17 +167,6 @@ const char iwl_ax411_killer_1690s_name[] =
 const char iwl_ax411_killer_1690i_name[] =
 	"Killer(R) Wi-Fi 6E AX1690i 160MHz Wireless Network Adapter (411NGW)";
 
-const struct iwl_cfg iwlax210_2ax_cfg_so_jf_b0 = {
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_NON_HE,
-};
-
-const struct iwl_cfg iwlax210_2ax_cfg_so_jf_b0_80mhz = {
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_NON_HE,
-	.bw_limit = 80,
-};
-
 const char iwl_ax210_name[] = "Intel(R) Wi-Fi 6 AX210 160MHz";
 
 const struct iwl_cfg iwl_cfg_ma = {
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-jf.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-jf.c
new file mode 100644
index 000000000000..3f50f9df5145
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-jf.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2015-2017 Intel Deutschland GmbH
+ * Copyright (C) 2018-2021, 2023, 2025 Intel Corporation
+ */
+#include "iwl-config.h"
+
+/* NVM versions */
+#define IWL_JF_NVM_VERSION		0x0a1d
+
+/* Memory offsets and lengths */
+#define IWL9000_DCCM_OFFSET		0x800000
+#define IWL9000_DCCM_LEN		0x18000
+#define IWL9000_DCCM2_OFFSET		0x880000
+#define IWL9000_DCCM2_LEN		0x8000
+
+static const struct iwl_tt_params iwl_jf_tt_params = {
+	.ct_kill_entry = 115,
+	.ct_kill_exit = 93,
+	.ct_kill_duration = 5,
+	.dynamic_smps_entry = 111,
+	.dynamic_smps_exit = 107,
+	.tx_protection_entry = 112,
+	.tx_protection_exit = 105,
+	.tx_backoff = {
+		{.temperature = 110, .backoff = 200},
+		{.temperature = 111, .backoff = 600},
+		{.temperature = 112, .backoff = 1200},
+		{.temperature = 113, .backoff = 2000},
+		{.temperature = 114, .backoff = 4000},
+	},
+	.support_ct_kill = true,
+	.support_dynamic_smps = true,
+	.support_tx_protection = true,
+	.support_tx_backoff = true,
+};
+
+/* these values are ignored if not with Pu/Th MAC firmware, due to offload */
+#define IWL_DEVICE_JF_PU						\
+	.dccm_offset = IWL9000_DCCM_OFFSET,				\
+	.dccm_len = IWL9000_DCCM_LEN,					\
+	.dccm2_offset = IWL9000_DCCM2_OFFSET,				\
+	.dccm2_len = IWL9000_DCCM2_LEN,					\
+	.thermal_params = &iwl_jf_tt_params
+
+#define IWL_DEVICE_JF							\
+	IWL_DEVICE_JF_PU,						\
+	.led_mode = IWL_LED_RF_STATE,					\
+	.non_shared_ant = ANT_B,					\
+	.num_rbds = IWL_NUM_RBDS_NON_HE,				\
+	.vht_mu_mimo_supported = true,					\
+	.ht_params = {							\
+		.stbc = true,						\
+		.ldpc = true,						\
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) |			\
+			      BIT(NL80211_BAND_5GHZ),			\
+	},								\
+	.nvm_ver = IWL_JF_NVM_VERSION,					\
+	.nvm_type = IWL_NVM_EXT
+
+const struct iwl_cfg iwl_rf_jf = {
+	IWL_DEVICE_JF,
+};
+
+const struct iwl_cfg iwl_rf_jf_80mhz = {
+	IWL_DEVICE_JF,
+	.bw_limit = 80,
+};
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 3593914793a5..4051800c8d77 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -684,15 +684,11 @@ extern const struct iwl_cfg iwl7265_cfg;
 extern const struct iwl_cfg iwl7265d_cfg;
 extern const struct iwl_cfg iwl8260_cfg;
 extern const struct iwl_cfg iwl8265_cfg;
-extern const struct iwl_cfg iwl9000_2ac_cfg;
-extern const struct iwl_cfg iwl9000_2ac_cfg_80mhz;
-extern const struct iwl_cfg iwl9560_qu_jf_cfg;
-extern const struct iwl_cfg iwl9560_qu_jf_cfg_80mhz;
+extern const struct iwl_cfg iwl_rf_jf;
+extern const struct iwl_cfg iwl_rf_jf_80mhz;
 extern const struct iwl_cfg iwl_qu_hr1;
 extern const struct iwl_cfg iwl_qu_hr;
 extern const struct iwl_cfg iwl_qu_hr_80mhz;
-extern const struct iwl_cfg iwlax210_2ax_cfg_so_jf_b0;
-extern const struct iwl_cfg iwlax210_2ax_cfg_so_jf_b0_80mhz;
 
 extern const struct iwl_cfg iwl_cfg_ma;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 7db0ca1a59aa..7dbac8a1446d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -944,31 +944,31 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwl8265_cfg, iwl8275_2ac_name,
 		     DEVICE(0x24FD), SUBDEV(0x0012)),
 /* 9000 */
-	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9260_killer_1550_name,
+	IWL_DEV_INFO(iwl_rf_jf, iwl9260_killer_1550_name,
 		     DEVICE(0x2526), SUBDEV(0x1550)),
-	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550s_name,
+	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550s_name,
 		     DEVICE(0x2526), SUBDEV(0x1551)),
-	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550i_name,
+	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550i_name,
 		     DEVICE(0x2526), SUBDEV(0x1552)),
-	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550s_name,
+	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550s_name,
 		     DEVICE(0x30DC), SUBDEV(0x1551)),
-	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550i_name,
+	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550i_name,
 		     DEVICE(0x30DC), SUBDEV(0x1552)),
-	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550s_name,
+	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550s_name,
 		     DEVICE(0x31DC), SUBDEV(0x1551)),
-	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550i_name,
+	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550i_name,
 		     DEVICE(0x31DC), SUBDEV(0x1552)),
-	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550s_name,
+	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550s_name,
 		     DEVICE(0xA370), SUBDEV(0x1551)),
-	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550i_name,
+	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550i_name,
 		     DEVICE(0xA370), SUBDEV(0x1552)),
-	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550s_160_name,
+	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550s_160_name,
 		     DEVICE(0x54F0), SUBDEV(0x1551)),
-	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550i_name,
+	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550i_name,
 		     DEVICE(0x54F0), SUBDEV(0x1552)),
-	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550s_160_name,
+	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550s_160_name,
 		     DEVICE(0x51F0), SUBDEV(0x1552)),
-	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550i_160_name,
+	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550i_160_name,
 		     DEVICE(0x51F0), SUBDEV(0x1551)),
 	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_killer_1690s_name,
 		     DEVICE(0x51F0), SUBDEV(0x1691)),
@@ -989,7 +989,7 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_killer_1690i_name,
 		     DEVICE(0x7AF0), SUBDEV(0x1692)),
 
-	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9260_1_name,
+	IWL_DEV_INFO(iwl_rf_jf, iwl9260_1_name,
 		     DEVICE(0x271C), SUBDEV(0x0214)),
 	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_killer_1690s_name,
 		     DEVICE(0x7E40), SUBDEV(0x1691)),
@@ -1193,13 +1193,13 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x7AF0), SUBDEV(0x0A10)),
 
 	/* So with JF */
-	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550s_160_name,
+	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550s_160_name,
 		     DEVICE(0x7A70), SUBDEV(0x1551)),
-	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550i_160_name,
+	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550i_160_name,
 		     DEVICE(0x7A70), SUBDEV(0x1552)),
-	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550s_160_name,
+	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550s_160_name,
 		     DEVICE(0x7AF0), SUBDEV(0x1551)),
-	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550i_160_name,
+	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550i_160_name,
 		     DEVICE(0x7AF0), SUBDEV(0x1552)),
 
 	/* SO with GF2 */
@@ -1234,125 +1234,125 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_killer_1675i_name,
 		     DEVICE(0x7E40), SUBDEV(0x1672)),
 
-	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9461_160_name, MAC_TYPE(PU),
+	IWL_DEV_INFO(iwl_rf_jf, iwl9461_160_name, MAC_TYPE(PU),
 		     RF_TYPE(JF1), RF_ID(JF1),
 		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9000_2ac_cfg_80mhz, iwl9461_name, MAC_TYPE(PU),
+	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9461_name, MAC_TYPE(PU),
 		     RF_TYPE(JF1), RF_ID(JF1),
 		     BW_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9462_160_name, MAC_TYPE(PU),
+	IWL_DEV_INFO(iwl_rf_jf, iwl9462_160_name, MAC_TYPE(PU),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV),
 		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9000_2ac_cfg_80mhz, iwl9462_name, MAC_TYPE(PU),
+	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9462_name, MAC_TYPE(PU),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV),
 		     BW_LIMITED, CORES(BT), NO_CDB),
 
-	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_160_name, MAC_TYPE(PU),
+	IWL_DEV_INFO(iwl_rf_jf, iwl9560_160_name, MAC_TYPE(PU),
 		     RF_TYPE(JF2), RF_ID(JF),
 		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9000_2ac_cfg_80mhz, iwl9560_name, MAC_TYPE(PU),
+	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9560_name, MAC_TYPE(PU),
 		     RF_TYPE(JF2), RF_ID(JF),
 		     BW_LIMITED, CORES(BT), NO_CDB),
 
-	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9270_160_name, DEVICE(0x2526),
+	IWL_DEV_INFO(iwl_rf_jf, iwl9270_160_name, DEVICE(0x2526),
 		     MAC_TYPE(TH), RF_TYPE(JF2),
 		     BW_NOT_LIMITED, CORES(BT_GNSS), NO_CDB),
-	IWL_DEV_INFO(iwl9000_2ac_cfg_80mhz, iwl9270_name, DEVICE(0x2526),
+	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9270_name, DEVICE(0x2526),
 		     MAC_TYPE(TH), RF_TYPE(JF2),
 		     BW_LIMITED, CORES(BT_GNSS), NO_CDB),
 
-	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9162_160_name, DEVICE(0x271B),
+	IWL_DEV_INFO(iwl_rf_jf, iwl9162_160_name, DEVICE(0x271B),
 		     MAC_TYPE(TH), RF_TYPE(JF1),
 		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9000_2ac_cfg_80mhz, iwl9162_name, DEVICE(0x271B),
+	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9162_name, DEVICE(0x271B),
 		     MAC_TYPE(TH), RF_TYPE(JF1),
 		     BW_LIMITED, CORES(BT), NO_CDB),
 
-	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9260_160_name, DEVICE(0x2526),
+	IWL_DEV_INFO(iwl_rf_jf, iwl9260_160_name, DEVICE(0x2526),
 		     MAC_TYPE(TH), RF_TYPE(JF2),
 		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9000_2ac_cfg_80mhz, iwl9260_name, DEVICE(0x2526),
+	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9260_name, DEVICE(0x2526),
 		     MAC_TYPE(TH), RF_TYPE(JF2),
 		     BW_LIMITED, CORES(BT), NO_CDB),
 
 /* Qu with Jf */
 	/* Qu B step */
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9461_160_name,
+	IWL_DEV_INFO(iwl_rf_jf, iwl9461_160_name,
 		     MAC_TYPE(QU), MAC_STEP(B), RF_TYPE(JF1), RF_ID(JF1),
 		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9461_name,
+	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9461_name,
 		     MAC_TYPE(QU), MAC_STEP(B), RF_TYPE(JF1), RF_ID(JF1),
 		     BW_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9462_160_name,
+	IWL_DEV_INFO(iwl_rf_jf, iwl9462_160_name,
 		     MAC_TYPE(QU), MAC_STEP(B),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV),
 		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9462_name,
+	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9462_name,
 		     MAC_TYPE(QU), MAC_STEP(B),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV),
 		     BW_LIMITED, CORES(BT), NO_CDB),
 
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9560_160_name,
+	IWL_DEV_INFO(iwl_rf_jf, iwl9560_160_name,
 		     MAC_TYPE(QU), MAC_STEP(B),
 		     RF_TYPE(JF2), RF_ID(JF),
 		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9560_name,
+	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9560_name,
 		     MAC_TYPE(QU), MAC_STEP(B),
 		     RF_TYPE(JF2), RF_ID(JF),
 		     BW_LIMITED, CORES(BT), NO_CDB),
 
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9560_killer_1550s_name,
+	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9560_killer_1550s_name,
 		     SUBDEV(0x1551), MAC_TYPE(QU), MAC_STEP(B), RF_TYPE(JF2)),
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9560_killer_1550i_name,
+	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9560_killer_1550i_name,
 		     SUBDEV(0x1552), MAC_TYPE(QU), MAC_STEP(B), RF_TYPE(JF2)),
 
 	/* Qu C step */
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9461_160_name,
+	IWL_DEV_INFO(iwl_rf_jf, iwl9461_160_name,
 		     MAC_TYPE(QU), MAC_STEP(C),
 		     RF_TYPE(JF1), RF_ID(JF1),
 		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9461_name,
+	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9461_name,
 		     MAC_TYPE(QU), MAC_STEP(C),
 		     RF_TYPE(JF1), RF_ID(JF1),
 		     BW_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9462_160_name,
+	IWL_DEV_INFO(iwl_rf_jf, iwl9462_160_name,
 		     MAC_TYPE(QU), MAC_STEP(C),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV),
 		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9462_name,
+	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9462_name,
 		     MAC_TYPE(QU), MAC_STEP(C),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV),
 		     BW_LIMITED, CORES(BT), NO_CDB),
 
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9560_160_name, MAC_TYPE(QU),
+	IWL_DEV_INFO(iwl_rf_jf, iwl9560_160_name, MAC_TYPE(QU),
 		     MAC_STEP(C), RF_TYPE(JF2), RF_ID(JF), BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9560_name, MAC_TYPE(QU),
+	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9560_name, MAC_TYPE(QU),
 		     MAC_STEP(C), RF_TYPE(JF2), RF_ID(JF), BW_LIMITED, CORES(BT),
 		     NO_CDB),
 
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9560_killer_1550s_name,
+	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550s_name,
 		     SUBDEV(0x1551), MAC_TYPE(QU), MAC_STEP(C), RF_TYPE(JF2)),
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9560_killer_1550i_name,
+	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9560_killer_1550i_name,
 		     SUBDEV(0x1552), MAC_TYPE(QU), MAC_STEP(C), RF_TYPE(JF2)),
 
 	/* QuZ */
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9461_160_name, MAC_TYPE(QUZ),
+	IWL_DEV_INFO(iwl_rf_jf, iwl9461_160_name, MAC_TYPE(QUZ),
 		     RF_TYPE(JF1), RF_ID(JF1), BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9461_name, MAC_TYPE(QUZ),
+	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9461_name, MAC_TYPE(QUZ),
 		     RF_TYPE(JF1), RF_ID(JF1), BW_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9462_160_name, MAC_TYPE(QUZ),
+	IWL_DEV_INFO(iwl_rf_jf, iwl9462_160_name, MAC_TYPE(QUZ),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9462_name, MAC_TYPE(QUZ),
+	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9462_name, MAC_TYPE(QUZ),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_LIMITED, CORES(BT), NO_CDB),
 
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9560_160_name, MAC_TYPE(QUZ),
+	IWL_DEV_INFO(iwl_rf_jf, iwl9560_160_name, MAC_TYPE(QUZ),
 		     RF_TYPE(JF2), RF_ID(JF), BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9560_name, MAC_TYPE(QUZ),
+	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9560_name, MAC_TYPE(QUZ),
 		     RF_TYPE(JF2), RF_ID(JF), BW_LIMITED, CORES(BT), NO_CDB),
 
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9560_killer_1550s_name,
+	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550s_name,
 		     SUBDEV(0x1551), MAC_TYPE(QUZ), RF_TYPE(JF2)),
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9560_killer_1550i_name,
+	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9560_killer_1550i_name,
 		     SUBDEV(0x1552), MAC_TYPE(QUZ), RF_TYPE(JF2)),
 
 /* Qu with Hr */
@@ -1411,19 +1411,19 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     RF_TYPE(GF), BW_NOT_LIMITED, CDB),
 
 /* SoF with JF2 */
-	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0, iwl9560_160_name, MAC_TYPE(SOF),
+	IWL_DEV_INFO(iwl_rf_jf, iwl9560_160_name, MAC_TYPE(SOF),
 		     RF_TYPE(JF2), RF_ID(JF), BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0_80mhz, iwl9560_name, MAC_TYPE(SOF),
+	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9560_name, MAC_TYPE(SOF),
 		     RF_TYPE(JF2), RF_ID(JF), BW_LIMITED, CORES(BT), NO_CDB),
 
 /* SoF with JF */
-	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0, iwl9461_160_name, MAC_TYPE(SOF),
+	IWL_DEV_INFO(iwl_rf_jf, iwl9461_160_name, MAC_TYPE(SOF),
 		     RF_TYPE(JF1), RF_ID(JF1), BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0, iwl9462_160_name, MAC_TYPE(SOF),
+	IWL_DEV_INFO(iwl_rf_jf, iwl9462_160_name, MAC_TYPE(SOF),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0_80mhz, iwl9461_name, MAC_TYPE(SOF),
+	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9461_name, MAC_TYPE(SOF),
 		     RF_TYPE(JF1), RF_ID(JF1), BW_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0_80mhz, iwl9462_name, MAC_TYPE(SOF),
+	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9462_name, MAC_TYPE(SOF),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_LIMITED, CORES(BT), NO_CDB),
 
 /* So with GF */
@@ -1433,19 +1433,19 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     RF_TYPE(GF), BW_NOT_LIMITED, CDB),
 
 /* So with JF2 */
-	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0, iwl9560_160_name, MAC_TYPE(SO),
+	IWL_DEV_INFO(iwl_rf_jf, iwl9560_160_name, MAC_TYPE(SO),
 		     RF_TYPE(JF2), RF_ID(JF), BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0_80mhz, iwl9560_name, MAC_TYPE(SO),
+	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9560_name, MAC_TYPE(SO),
 		     RF_TYPE(JF2), RF_ID(JF), BW_LIMITED, CORES(BT), NO_CDB),
 
 /* So with JF */
-	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0, iwl9461_160_name, MAC_TYPE(SO),
+	IWL_DEV_INFO(iwl_rf_jf, iwl9461_160_name, MAC_TYPE(SO),
 		     RF_TYPE(JF1), RF_ID(JF1), BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0, iwl9462_160_name, MAC_TYPE(SO),
+	IWL_DEV_INFO(iwl_rf_jf, iwl9462_160_name, MAC_TYPE(SO),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0_80mhz, iwl9461_name, MAC_TYPE(SO),
+	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9461_name, MAC_TYPE(SO),
 		     RF_TYPE(JF1), RF_ID(JF1), BW_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0_80mhz, iwl9462_name, MAC_TYPE(SO),
+	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9462_name, MAC_TYPE(SO),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_LIMITED, CORES(BT), NO_CDB),
 
 #endif /* CONFIG_IWLMVM */
-- 
2.34.1


