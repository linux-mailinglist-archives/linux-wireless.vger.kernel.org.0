Return-Path: <linux-wireless+bounces-22353-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E21DAA72B8
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3571F1BC3432
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81B8255E4D;
	Fri,  2 May 2025 12:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WuzpWpov"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F3A253B7C
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746190625; cv=none; b=H6O69WtVhQUQE4tS4ViJiaL+/DzOhRh8TifP9mfbm0ECMzZQs3rcRFKp91PWc2FDMYlF7/9sygSqD3lLG5Oy9NVpuH4DxIH+HP3OMl78POm7RyYIjZzPNhi0lMfU9LNuEKVyIkQqDrC7h+9W+DIV5mAJas2d4UQ6bacTnQJX/yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746190625; c=relaxed/simple;
	bh=VqlCUXHe9TRDmo3wP7Ke4IPsgZM64Vvi+dOksN5QgB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=crFxi4RVSK7N9MSh/5zkGzoLAUB6wwdaF04UigvSDExLgTT0jsQnZh5aVd7e9km0L4gjL+iv/S36n5DnvBzcI1VCiDH0oBOHXK6sC12f/OtkpLn3V5tbj/H46dUi01g8Xe/yjXlBG3N6e1WOsvHXkgur9upOo146BhNPB4VuYgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WuzpWpov; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746190620; x=1777726620;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VqlCUXHe9TRDmo3wP7Ke4IPsgZM64Vvi+dOksN5QgB4=;
  b=WuzpWpovWHH35eoY3rRdp8+8K8/5yQK2qrpxU8Y0Ob3TUFqXkl+Xz0LG
   kzr0/AAhzhROnwyKQjxxjAMO/iKIp4u7/w3JZ3xhHPlfdFCx6yPtDqPdX
   FRDNynC1fYW+gfqxxr6737eNpVasndO6eXJ1j1stAtDdB/bwT1FRqcflm
   mrUdlB6Rfn7cD01vQdQKDCQcFtJ/yyGmlVBxr5CY3QA3GZE9lEUTuLn0a
   t8bRjqh0duRlqc5/tgtfZHAlS81TM5z4BbHo0MKgIKnoT2HHt8NADcHxr
   kDfF/h3QIsCWxOCbbGLtZ5nnD8YephrmYf8gMohuTlPtHqbqHysby4ycV
   A==;
X-CSE-ConnectionGUID: RRsV5YIyS9CPZe87oEUVCw==
X-CSE-MsgGUID: otWUt1pNRZ69e/R1rB0qYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="59255547"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="59255547"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:56:59 -0700
X-CSE-ConnectionGUID: F+Pfk4ShSBOx96RRqYMZNg==
X-CSE-MsgGUID: wNIMpD5mQhO1wzuUKC3W8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="165554733"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:56:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: cfg: finish config split
Date: Fri,  2 May 2025 15:56:24 +0300
Message-Id: <20250502155404.e03f65c0f693.I076a997f800db455b575008f9488b151738ad7ec@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250502125631.3184319-1-miriam.rachel.korenblit@intel.com>
References: <20250502125631.3184319-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

A long time ago, when transport vs. device configs were
introduced, we wanted to eventually have a list of PCI
IDs and a separate list of devices, but for simplicity
embedded the transport config in the whole config, and
it all got confusing.

Finish splitting that out. Doing so requires having more
IWL_DEV_INFO() entries, but the whole trans/cfg aliasing
goes away and the code becomes a lot simpler.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/1000.c |   23 +-
 drivers/net/wireless/intel/iwlwifi/cfg/2000.c |   48 +-
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |    5 -
 drivers/net/wireless/intel/iwlwifi/cfg/5000.c |   45 +-
 drivers/net/wireless/intel/iwlwifi/cfg/6000.c |  153 +-
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c |  123 +-
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c |   48 +-
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |   26 -
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |    6 -
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   |    6 -
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |    6 -
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  136 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 1634 ++++++++++++-----
 .../wireless/intel/iwlwifi/tests/devinfo.c    |    6 +-
 14 files changed, 1471 insertions(+), 794 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/1000.c b/drivers/net/wireless/intel/iwlwifi/cfg/1000.c
index f172ffd2a841..20daa503d643 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/1000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/1000.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
- * Copyright(c) 2018 - 2020, 2023 Intel Corporation
+ * Copyright(c) 2018 - 2020, 2023, 2025 Intel Corporation
  *****************************************************************************/
 
 #include <linux/module.h>
@@ -60,54 +60,59 @@ static const struct iwl_eeprom_params iwl1000_eeprom_params = {
 	}
 };
 
+const struct iwl_cfg_trans_params iwl1000_trans_cfg = {
+	.device_family = IWL_DEVICE_FAMILY_1000,
+	.base_params = &iwl1000_base_params,
+};
+
 #define IWL_DEVICE_1000						\
 	.fw_name_pre = IWL1000_FW_PRE,				\
 	.ucode_api_max = IWL1000_UCODE_API_MAX,			\
 	.ucode_api_min = IWL1000_UCODE_API_MIN,			\
-	.trans.device_family = IWL_DEVICE_FAMILY_1000,		\
 	.max_inst_size = IWLAGN_RTC_INST_SIZE,			\
 	.max_data_size = IWLAGN_RTC_DATA_SIZE,			\
 	.nvm_ver = EEPROM_1000_EEPROM_VERSION,		\
 	.nvm_calib_ver = EEPROM_1000_TX_POWER_VERSION,	\
-	.trans.base_params = &iwl1000_base_params,		\
 	.eeprom_params = &iwl1000_eeprom_params,		\
 	.led_mode = IWL_LED_BLINK
 
 const struct iwl_cfg iwl1000_bgn_cfg = {
-	.name = "Intel(R) Centrino(R) Wireless-N 1000 BGN",
 	IWL_DEVICE_1000,
 	.ht_params = &iwl1000_ht_params,
 };
 
+const char iwl1000_bgn_name[] = "Intel(R) Centrino(R) Wireless-N 1000 BGN";
+
 const struct iwl_cfg iwl1000_bg_cfg = {
-	.name = "Intel(R) Centrino(R) Wireless-N 1000 BG",
 	IWL_DEVICE_1000,
 };
 
+const char iwl1000_bg_name[] = "Intel(R) Centrino(R) Wireless-N 1000 BG";
+
 #define IWL_DEVICE_100						\
 	.fw_name_pre = IWL100_FW_PRE,				\
 	.ucode_api_max = IWL100_UCODE_API_MAX,			\
 	.ucode_api_min = IWL100_UCODE_API_MIN,			\
-	.trans.device_family = IWL_DEVICE_FAMILY_100,		\
 	.max_inst_size = IWLAGN_RTC_INST_SIZE,			\
 	.max_data_size = IWLAGN_RTC_DATA_SIZE,			\
 	.nvm_ver = EEPROM_1000_EEPROM_VERSION,		\
 	.nvm_calib_ver = EEPROM_1000_TX_POWER_VERSION,	\
-	.trans.base_params = &iwl1000_base_params,		\
 	.eeprom_params = &iwl1000_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE,				\
 	.rx_with_siso_diversity = true
 
 const struct iwl_cfg iwl100_bgn_cfg = {
-	.name = "Intel(R) Centrino(R) Wireless-N 100 BGN",
 	IWL_DEVICE_100,
 	.ht_params = &iwl1000_ht_params,
 };
 
+const char iwl100_bgn_name[] = "Intel(R) Centrino(R) Wireless-N 100 BGN";
+
 const struct iwl_cfg iwl100_bg_cfg = {
-	.name = "Intel(R) Centrino(R) Wireless-N 100 BG",
 	IWL_DEVICE_100,
 };
 
+const char iwl100_bg_name[] = "Intel(R) Centrino(R) Wireless-N 100 BG";
+
 MODULE_FIRMWARE(IWL1000_MODULE_FIRMWARE(IWL1000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL100_MODULE_FIRMWARE(IWL100_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/2000.c b/drivers/net/wireless/intel/iwlwifi/cfg/2000.c
index 6f3f26da0ad5..22656d6ca8ee 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/2000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/2000.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
- * Copyright(c) 2018 - 2020, 2023 Intel Corporation
+ * Copyright(c) 2018 - 2020, 2023, 2025 Intel Corporation
  *****************************************************************************/
 
 #include <linux/module.h>
@@ -86,97 +86,103 @@ static const struct iwl_eeprom_params iwl20x0_eeprom_params = {
 	.enhanced_txpower = true,
 };
 
+const struct iwl_cfg_trans_params iwl2000_trans_cfg = {
+	.device_family = IWL_DEVICE_FAMILY_2000,
+	.base_params = &iwl2000_base_params,
+};
+
 #define IWL_DEVICE_2000						\
 	.fw_name_pre = IWL2000_FW_PRE,				\
 	.ucode_api_max = IWL2000_UCODE_API_MAX,			\
 	.ucode_api_min = IWL2000_UCODE_API_MIN,			\
-	.trans.device_family = IWL_DEVICE_FAMILY_2000,		\
 	.max_inst_size = IWL60_RTC_INST_SIZE,			\
 	.max_data_size = IWL60_RTC_DATA_SIZE,			\
 	.nvm_ver = EEPROM_2000_EEPROM_VERSION,			\
 	.nvm_calib_ver = EEPROM_2000_TX_POWER_VERSION,		\
-	.trans.base_params = &iwl2000_base_params,		\
 	.eeprom_params = &iwl20x0_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE
 
 
 const struct iwl_cfg iwl2000_2bgn_cfg = {
-	.name = "Intel(R) Centrino(R) Wireless-N 2200 BGN",
 	IWL_DEVICE_2000,
 	.ht_params = &iwl2000_ht_params,
 };
 
-const struct iwl_cfg iwl2000_2bgn_d_cfg = {
-	.name = "Intel(R) Centrino(R) Wireless-N 2200D BGN",
-	IWL_DEVICE_2000,
-	.ht_params = &iwl2000_ht_params,
+const char iwl2000_2bgn_name[] = "Intel(R) Centrino(R) Wireless-N 2200 BGN";
+const char iwl2000_2bgn_d_name[] = "Intel(R) Centrino(R) Wireless-N 2200D BGN";
+
+const struct iwl_cfg_trans_params iwl2030_trans_cfg = {
+	.device_family = IWL_DEVICE_FAMILY_2030,
+	.base_params = &iwl2030_base_params,
 };
 
 #define IWL_DEVICE_2030						\
 	.fw_name_pre = IWL2030_FW_PRE,				\
 	.ucode_api_max = IWL2030_UCODE_API_MAX,			\
 	.ucode_api_min = IWL2030_UCODE_API_MIN,			\
-	.trans.device_family = IWL_DEVICE_FAMILY_2030,		\
 	.max_inst_size = IWL60_RTC_INST_SIZE,			\
 	.max_data_size = IWL60_RTC_DATA_SIZE,			\
 	.nvm_ver = EEPROM_2000_EEPROM_VERSION,		\
 	.nvm_calib_ver = EEPROM_2000_TX_POWER_VERSION,	\
-	.trans.base_params = &iwl2030_base_params,		\
 	.eeprom_params = &iwl20x0_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE
 
 const struct iwl_cfg iwl2030_2bgn_cfg = {
-	.name = "Intel(R) Centrino(R) Wireless-N 2230 BGN",
 	IWL_DEVICE_2030,
 	.ht_params = &iwl2000_ht_params,
 };
 
+const char iwl2030_2bgn_name[] = "Intel(R) Centrino(R) Wireless-N 2230 BGN";
+
+const struct iwl_cfg_trans_params iwl105_trans_cfg = {
+	.device_family = IWL_DEVICE_FAMILY_105,
+	.base_params = &iwl2000_base_params,
+};
+
 #define IWL_DEVICE_105						\
 	.fw_name_pre = IWL105_FW_PRE,				\
 	.ucode_api_max = IWL105_UCODE_API_MAX,			\
 	.ucode_api_min = IWL105_UCODE_API_MIN,			\
-	.trans.device_family = IWL_DEVICE_FAMILY_105,		\
 	.max_inst_size = IWL60_RTC_INST_SIZE,			\
 	.max_data_size = IWL60_RTC_DATA_SIZE,			\
 	.nvm_ver = EEPROM_2000_EEPROM_VERSION,		\
 	.nvm_calib_ver = EEPROM_2000_TX_POWER_VERSION,	\
-	.trans.base_params = &iwl2000_base_params,		\
 	.eeprom_params = &iwl20x0_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE,				\
 	.rx_with_siso_diversity = true
 
 const struct iwl_cfg iwl105_bgn_cfg = {
-	.name = "Intel(R) Centrino(R) Wireless-N 105 BGN",
 	IWL_DEVICE_105,
 	.ht_params = &iwl2000_ht_params,
 };
 
-const struct iwl_cfg iwl105_bgn_d_cfg = {
-	.name = "Intel(R) Centrino(R) Wireless-N 105D BGN",
-	IWL_DEVICE_105,
-	.ht_params = &iwl2000_ht_params,
+const char iwl105_bgn_name[] = "Intel(R) Centrino(R) Wireless-N 105 BGN";
+const char iwl105_bgn_d_name[] = "Intel(R) Centrino(R) Wireless-N 105D BGN";
+
+const struct iwl_cfg_trans_params iwl135_trans_cfg = {
+	.device_family = IWL_DEVICE_FAMILY_135,
+	.base_params = &iwl2030_base_params,
 };
 
 #define IWL_DEVICE_135						\
 	.fw_name_pre = IWL135_FW_PRE,				\
 	.ucode_api_max = IWL135_UCODE_API_MAX,			\
 	.ucode_api_min = IWL135_UCODE_API_MIN,			\
-	.trans.device_family = IWL_DEVICE_FAMILY_135,		\
 	.max_inst_size = IWL60_RTC_INST_SIZE,			\
 	.max_data_size = IWL60_RTC_DATA_SIZE,			\
 	.nvm_ver = EEPROM_2000_EEPROM_VERSION,		\
 	.nvm_calib_ver = EEPROM_2000_TX_POWER_VERSION,	\
-	.trans.base_params = &iwl2030_base_params,		\
 	.eeprom_params = &iwl20x0_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE,				\
 	.rx_with_siso_diversity = true
 
 const struct iwl_cfg iwl135_bgn_cfg = {
-	.name = "Intel(R) Centrino(R) Wireless-N 135 BGN",
 	IWL_DEVICE_135,
 	.ht_params = &iwl2000_ht_params,
 };
 
+const char iwl135_bgn_name[] = "Intel(R) Centrino(R) Wireless-N 135 BGN";
+
 MODULE_FIRMWARE(IWL2000_MODULE_FIRMWARE(IWL2000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL2030_MODULE_FIRMWARE(IWL2030_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL105_MODULE_FIRMWARE(IWL105_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 59d0fa2193f5..21d5a02933a6 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -81,13 +81,10 @@ const struct iwl_ht_params iwl_22000_ht_params = {
 	.smem_len = IWL_22000_SMEM_LEN,					\
 	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,		\
 	.apmg_not_supported = true,					\
-	.trans.mq_rx_supported = true,					\
 	.vht_mu_mimo_supported = true,					\
 	.mac_addr_from_csr = 0x380,					\
 	.ht_params = &iwl_22000_ht_params,				\
 	.nvm_ver = IWL_22000_NVM_VERSION,				\
-	.trans.rf_id = true,						\
-	.trans.gen2 = true,						\
 	.nvm_type = IWL_NVM_EXT,					\
 	.dbgc_supported = true,						\
 	.min_umac_error_event_table = 0x400000,				\
@@ -107,8 +104,6 @@ const struct iwl_ht_params iwl_22000_ht_params = {
 #define IWL_DEVICE_22500						\
 	IWL_DEVICE_22000_COMMON,					\
 	.ucode_api_max = IWL_22000_UCODE_API_MAX,			\
-	.trans.device_family = IWL_DEVICE_FAMILY_22000,			\
-	.trans.base_params = &iwl_22000_base_params,			\
 	.gp2_reg_addr = 0xa02c68,					\
 	.mon_dram_regs = {						\
 		.write_ptr = {						\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/5000.c b/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
index de7ede59a994..36909f6323db 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2014 Intel Corporation. All rights reserved.
- * Copyright(c) 2018 - 2020, 2023 Intel Corporation
+ * Copyright(c) 2018 - 2020, 2023, 2025 Intel Corporation
  *****************************************************************************/
 
 #include <linux/module.h>
@@ -58,21 +58,23 @@ static const struct iwl_eeprom_params iwl5000_eeprom_params = {
 	},
 };
 
+const struct iwl_cfg_trans_params iwl5000_trans_cfg = {
+	.device_family = IWL_DEVICE_FAMILY_5000,
+	.base_params = &iwl5000_base_params,
+};
+
 #define IWL_DEVICE_5000						\
 	.fw_name_pre = IWL5000_FW_PRE,				\
 	.ucode_api_max = IWL5000_UCODE_API_MAX,			\
 	.ucode_api_min = IWL5000_UCODE_API_MIN,			\
-	.trans.device_family = IWL_DEVICE_FAMILY_5000,		\
 	.max_inst_size = IWLAGN_RTC_INST_SIZE,			\
 	.max_data_size = IWLAGN_RTC_DATA_SIZE,			\
 	.nvm_ver = EEPROM_5000_EEPROM_VERSION,		\
 	.nvm_calib_ver = EEPROM_5000_TX_POWER_VERSION,	\
-	.trans.base_params = &iwl5000_base_params,		\
 	.eeprom_params = &iwl5000_eeprom_params,		\
 	.led_mode = IWL_LED_BLINK
 
 const struct iwl_cfg iwl5300_agn_cfg = {
-	.name = "Intel(R) Ultimate N WiFi Link 5300 AGN",
 	IWL_DEVICE_5000,
 	/* at least EEPROM 0x11A has wrong info */
 	.valid_tx_ant = ANT_ABC,	/* .cfg overwrite */
@@ -80,71 +82,72 @@ const struct iwl_cfg iwl5300_agn_cfg = {
 	.ht_params = &iwl5000_ht_params,
 };
 
-const struct iwl_cfg iwl5100_bgn_cfg = {
-	.name = "Intel(R) WiFi Link 5100 BGN",
+const char iwl5300_agn_name[] = "Intel(R) Ultimate N WiFi Link 5300 AGN";
+
+const struct iwl_cfg iwl5100_n_cfg = {
 	IWL_DEVICE_5000,
 	.valid_tx_ant = ANT_B,		/* .cfg overwrite */
 	.valid_rx_ant = ANT_AB,		/* .cfg overwrite */
 	.ht_params = &iwl5000_ht_params,
 };
 
+const char iwl5100_bgn_name[] = "Intel(R) WiFi Link 5100 BGN";
+
 const struct iwl_cfg iwl5100_abg_cfg = {
-	.name = "Intel(R) WiFi Link 5100 ABG",
 	IWL_DEVICE_5000,
 	.valid_tx_ant = ANT_B,		/* .cfg overwrite */
 	.valid_rx_ant = ANT_AB,		/* .cfg overwrite */
 };
 
-const struct iwl_cfg iwl5100_agn_cfg = {
-	.name = "Intel(R) WiFi Link 5100 AGN",
-	IWL_DEVICE_5000,
-	.valid_tx_ant = ANT_B,		/* .cfg overwrite */
-	.valid_rx_ant = ANT_AB,		/* .cfg overwrite */
-	.ht_params = &iwl5000_ht_params,
-};
+const char iwl5100_abg_name[] = "Intel(R) WiFi Link 5100 ABG";
+const char iwl5100_agn_name[] = "Intel(R) WiFi Link 5100 AGN";
 
 const struct iwl_cfg iwl5350_agn_cfg = {
-	.name = "Intel(R) WiMAX/WiFi Link 5350 AGN",
 	.fw_name_pre = IWL5000_FW_PRE,
 	.ucode_api_max = IWL5000_UCODE_API_MAX,
 	.ucode_api_min = IWL5000_UCODE_API_MIN,
-	.trans.device_family = IWL_DEVICE_FAMILY_5000,
 	.max_inst_size = IWLAGN_RTC_INST_SIZE,
 	.max_data_size = IWLAGN_RTC_DATA_SIZE,
 	.nvm_ver = EEPROM_5050_EEPROM_VERSION,
 	.nvm_calib_ver = EEPROM_5050_TX_POWER_VERSION,
-	.trans.base_params = &iwl5000_base_params,
 	.eeprom_params = &iwl5000_eeprom_params,
 	.ht_params = &iwl5000_ht_params,
 	.led_mode = IWL_LED_BLINK,
 	.internal_wimax_coex = true,
 };
 
+const char iwl5350_agn_name[] = "Intel(R) WiMAX/WiFi Link 5350 AGN";
+
+const struct iwl_cfg_trans_params iwl5150_trans_cfg = {
+	.device_family = IWL_DEVICE_FAMILY_5150,
+	.base_params = &iwl5000_base_params,
+};
+
 #define IWL_DEVICE_5150						\
 	.fw_name_pre = IWL5150_FW_PRE,				\
 	.ucode_api_max = IWL5150_UCODE_API_MAX,			\
 	.ucode_api_min = IWL5150_UCODE_API_MIN,			\
-	.trans.device_family = IWL_DEVICE_FAMILY_5150,		\
 	.max_inst_size = IWLAGN_RTC_INST_SIZE,			\
 	.max_data_size = IWLAGN_RTC_DATA_SIZE,			\
 	.nvm_ver = EEPROM_5050_EEPROM_VERSION,		\
 	.nvm_calib_ver = EEPROM_5050_TX_POWER_VERSION,	\
-	.trans.base_params = &iwl5000_base_params,		\
 	.eeprom_params = &iwl5000_eeprom_params,		\
 	.led_mode = IWL_LED_BLINK,				\
 	.internal_wimax_coex = true
 
 const struct iwl_cfg iwl5150_agn_cfg = {
-	.name = "Intel(R) WiMAX/WiFi Link 5150 AGN",
 	IWL_DEVICE_5150,
 	.ht_params = &iwl5000_ht_params,
 
 };
 
+const char iwl5150_agn_name[] = "Intel(R) WiMAX/WiFi Link 5150 AGN";
+
 const struct iwl_cfg iwl5150_abg_cfg = {
-	.name = "Intel(R) WiMAX/WiFi Link 5150 ABG",
 	IWL_DEVICE_5150,
 };
 
+const char iwl5150_abg_name[] = "Intel(R) WiMAX/WiFi Link 5150 ABG";
+
 MODULE_FIRMWARE(IWL5000_MODULE_FIRMWARE(IWL5000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL5150_MODULE_FIRMWARE(IWL5150_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/6000.c b/drivers/net/wireless/intel/iwlwifi/cfg/6000.c
index f013cf420569..09a68712114f 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/6000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/6000.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
- * Copyright(c) 2018 - 2020, 2023 Intel Corporation
+ * Copyright(c) 2018 - 2020, 2023, 2025 Intel Corporation
  *****************************************************************************/
 
 #include <linux/module.h>
@@ -107,143 +107,112 @@ static const struct iwl_eeprom_params iwl6000_eeprom_params = {
 	.enhanced_txpower = true,
 };
 
+const struct iwl_cfg_trans_params iwl6005_trans_cfg = {
+	.device_family = IWL_DEVICE_FAMILY_6005,
+	.base_params = &iwl6000_g2_base_params,
+};
+
 #define IWL_DEVICE_6005						\
 	.fw_name_pre = IWL6005_FW_PRE,				\
 	.ucode_api_max = IWL6000G2_UCODE_API_MAX,		\
 	.ucode_api_min = IWL6000G2_UCODE_API_MIN,		\
-	.trans.device_family = IWL_DEVICE_FAMILY_6005,		\
 	.max_inst_size = IWL60_RTC_INST_SIZE,			\
 	.max_data_size = IWL60_RTC_DATA_SIZE,			\
 	.nvm_ver = EEPROM_6005_EEPROM_VERSION,		\
 	.nvm_calib_ver = EEPROM_6005_TX_POWER_VERSION,	\
-	.trans.base_params = &iwl6000_g2_base_params,		\
 	.eeprom_params = &iwl6000_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE
 
-const struct iwl_cfg iwl6005_2agn_cfg = {
-	.name = "Intel(R) Centrino(R) Advanced-N 6205 AGN",
+const struct iwl_cfg iwl6005_n_cfg = {
 	IWL_DEVICE_6005,
 	.ht_params = &iwl6000_ht_params,
 };
 
-const struct iwl_cfg iwl6005_2abg_cfg = {
-	.name = "Intel(R) Centrino(R) Advanced-N 6205 ABG",
-	IWL_DEVICE_6005,
-};
-
-const struct iwl_cfg iwl6005_2bg_cfg = {
-	.name = "Intel(R) Centrino(R) Advanced-N 6205 BG",
-	IWL_DEVICE_6005,
-};
-
-const struct iwl_cfg iwl6005_2agn_sff_cfg = {
-	.name = "Intel(R) Centrino(R) Advanced-N 6205S AGN",
-	IWL_DEVICE_6005,
-	.ht_params = &iwl6000_ht_params,
-};
+const char iwl6005_2agn_name[] = "Intel(R) Centrino(R) Advanced-N 6205 AGN";
+const char iwl6005_2agn_sff_name[] = "Intel(R) Centrino(R) Advanced-N 6205S AGN";
+const char iwl6005_2agn_d_name[] = "Intel(R) Centrino(R) Advanced-N 6205D AGN";
+const char iwl6005_2agn_mow1_name[] = "Intel(R) Centrino(R) Advanced-N 6206 AGN";
+const char iwl6005_2agn_mow2_name[] = "Intel(R) Centrino(R) Advanced-N 6207 AGN";
 
-const struct iwl_cfg iwl6005_2agn_d_cfg = {
-	.name = "Intel(R) Centrino(R) Advanced-N 6205D AGN",
+const struct iwl_cfg iwl6005_non_n_cfg = {
 	IWL_DEVICE_6005,
-	.ht_params = &iwl6000_ht_params,
 };
 
-const struct iwl_cfg iwl6005_2agn_mow1_cfg = {
-	.name = "Intel(R) Centrino(R) Advanced-N 6206 AGN",
-	IWL_DEVICE_6005,
-	.ht_params = &iwl6000_ht_params,
-};
+const char iwl6005_2abg_name[] = "Intel(R) Centrino(R) Advanced-N 6205 ABG";
+const char iwl6005_2bg_name[] = "Intel(R) Centrino(R) Advanced-N 6205 BG";
 
-const struct iwl_cfg iwl6005_2agn_mow2_cfg = {
-	.name = "Intel(R) Centrino(R) Advanced-N 6207 AGN",
-	IWL_DEVICE_6005,
-	.ht_params = &iwl6000_ht_params,
+const struct iwl_cfg_trans_params iwl6030_trans_cfg = {
+	.device_family = IWL_DEVICE_FAMILY_6030,
+	.base_params = &iwl6000_g2_base_params,
 };
 
 #define IWL_DEVICE_6030						\
 	.fw_name_pre = IWL6030_FW_PRE,				\
 	.ucode_api_max = IWL6000G2_UCODE_API_MAX,		\
 	.ucode_api_min = IWL6000G2_UCODE_API_MIN,		\
-	.trans.device_family = IWL_DEVICE_FAMILY_6030,		\
 	.max_inst_size = IWL60_RTC_INST_SIZE,			\
 	.max_data_size = IWL60_RTC_DATA_SIZE,			\
 	.nvm_ver = EEPROM_6030_EEPROM_VERSION,		\
 	.nvm_calib_ver = EEPROM_6030_TX_POWER_VERSION,	\
-	.trans.base_params = &iwl6000_g2_base_params,		\
 	.eeprom_params = &iwl6000_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE
 
-const struct iwl_cfg iwl6030_2agn_cfg = {
-	.name = "Intel(R) Centrino(R) Advanced-N 6230 AGN",
+const struct iwl_cfg iwl6030_n_cfg = {
 	IWL_DEVICE_6030,
 	.ht_params = &iwl6000_ht_params,
 };
 
-const struct iwl_cfg iwl6030_2abg_cfg = {
-	.name = "Intel(R) Centrino(R) Advanced-N 6230 ABG",
-	IWL_DEVICE_6030,
-};
+const char iwl6030_2agn_name[] = "Intel(R) Centrino(R) Advanced-N 6230 AGN";
+const char iwl6030_2bgn_name[] = "Intel(R) Centrino(R) Advanced-N 6230 BGN";
+const char iwl1030_bgn_name[] = "Intel(R) Centrino(R) Wireless-N 1030 BGN";
+const char iwl1030_bg_name[] = "Intel(R) Centrino(R) Wireless-N 1030 BG";
 
-const struct iwl_cfg iwl6030_2bgn_cfg = {
-	.name = "Intel(R) Centrino(R) Advanced-N 6230 BGN",
+const struct iwl_cfg iwl6030_non_n_cfg = {
 	IWL_DEVICE_6030,
-	.ht_params = &iwl6000_ht_params,
 };
 
-const struct iwl_cfg iwl6030_2bg_cfg = {
-	.name = "Intel(R) Centrino(R) Advanced-N 6230 BG",
-	IWL_DEVICE_6030,
-};
+const char iwl6030_2abg_name[] = "Intel(R) Centrino(R) Advanced-N 6230 ABG";
+const char iwl6030_2bg_name[] = "Intel(R) Centrino(R) Advanced-N 6230 BG";
 
 #define IWL_DEVICE_6035						\
 	.fw_name_pre = IWL6030_FW_PRE,				\
 	.ucode_api_max = IWL6035_UCODE_API_MAX,			\
 	.ucode_api_min = IWL6035_UCODE_API_MIN,			\
-	.trans.device_family = IWL_DEVICE_FAMILY_6030,		\
 	.max_inst_size = IWL60_RTC_INST_SIZE,			\
 	.max_data_size = IWL60_RTC_DATA_SIZE,			\
 	.nvm_ver = EEPROM_6030_EEPROM_VERSION,		\
 	.nvm_calib_ver = EEPROM_6030_TX_POWER_VERSION,	\
-	.trans.base_params = &iwl6000_g2_base_params,		\
 	.eeprom_params = &iwl6000_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE
 
 const struct iwl_cfg iwl6035_2agn_cfg = {
-	.name = "Intel(R) Centrino(R) Advanced-N 6235 AGN",
-	IWL_DEVICE_6035,
-	.ht_params = &iwl6000_ht_params,
-};
-
-const struct iwl_cfg iwl6035_2agn_sff_cfg = {
-	.name = "Intel(R) Centrino(R) Ultimate-N 6235 AGN",
 	IWL_DEVICE_6035,
 	.ht_params = &iwl6000_ht_params,
 };
 
-const struct iwl_cfg iwl1030_bgn_cfg = {
-	.name = "Intel(R) Centrino(R) Wireless-N 1030 BGN",
-	IWL_DEVICE_6030,
-	.ht_params = &iwl6000_ht_params,
-};
-
-const struct iwl_cfg iwl1030_bg_cfg = {
-	.name = "Intel(R) Centrino(R) Wireless-N 1030 BG",
-	IWL_DEVICE_6030,
-};
+const char iwl6035_2agn_name[] = "Intel(R) Centrino(R) Advanced-N 6235 AGN";
+const char iwl6035_2agn_sff_name[] = "Intel(R) Centrino(R) Ultimate-N 6235 AGN";
 
 const struct iwl_cfg iwl130_bgn_cfg = {
-	.name = "Intel(R) Centrino(R) Wireless-N 130 BGN",
 	IWL_DEVICE_6030,
 	.ht_params = &iwl6000_ht_params,
 	.rx_with_siso_diversity = true,
 };
 
+const char iwl130_bgn_name[] = "Intel(R) Centrino(R) Wireless-N 130 BGN";
+
 const struct iwl_cfg iwl130_bg_cfg = {
-	.name = "Intel(R) Centrino(R) Wireless-N 130 BG",
 	IWL_DEVICE_6030,
 	.rx_with_siso_diversity = true,
 };
 
+const char iwl130_bg_name[] = "Intel(R) Centrino(R) Wireless-N 130 BG";
+
+const struct iwl_cfg_trans_params iwl6000i_trans_cfg = {
+	.device_family = IWL_DEVICE_FAMILY_6000i,
+	.base_params = &iwl6000_base_params,
+};
+
 /*
  * "i": Internal configuration, use internal Power Amplifier
  */
@@ -251,101 +220,111 @@ const struct iwl_cfg iwl130_bg_cfg = {
 	.fw_name_pre = IWL6000_FW_PRE,				\
 	.ucode_api_max = IWL6000_UCODE_API_MAX,			\
 	.ucode_api_min = IWL6000_UCODE_API_MIN,			\
-	.trans.device_family = IWL_DEVICE_FAMILY_6000i,		\
 	.max_inst_size = IWL60_RTC_INST_SIZE,			\
 	.max_data_size = IWL60_RTC_DATA_SIZE,			\
 	.valid_tx_ant = ANT_BC,		/* .cfg overwrite */	\
 	.valid_rx_ant = ANT_BC,		/* .cfg overwrite */	\
 	.nvm_ver = EEPROM_6000_EEPROM_VERSION,		\
 	.nvm_calib_ver = EEPROM_6000_TX_POWER_VERSION,	\
-	.trans.base_params = &iwl6000_base_params,		\
 	.eeprom_params = &iwl6000_eeprom_params,		\
 	.led_mode = IWL_LED_BLINK
 
 const struct iwl_cfg iwl6000i_2agn_cfg = {
-	.name = "Intel(R) Centrino(R) Advanced-N 6200 AGN",
 	IWL_DEVICE_6000i,
 	.ht_params = &iwl6000_ht_params,
 };
 
-const struct iwl_cfg iwl6000i_2abg_cfg = {
-	.name = "Intel(R) Centrino(R) Advanced-N 6200 ABG",
+const char iwl6000i_2agn_name[] = "Intel(R) Centrino(R) Advanced-N 6200 AGN";
+
+const struct iwl_cfg iwl6000i_non_n_cfg = {
 	IWL_DEVICE_6000i,
 };
 
-const struct iwl_cfg iwl6000i_2bg_cfg = {
-	.name = "Intel(R) Centrino(R) Advanced-N 6200 BG",
-	IWL_DEVICE_6000i,
+const char iwl6000i_2abg_name[] = "Intel(R) Centrino(R) Advanced-N 6200 ABG";
+const char iwl6000i_2bg_name[] = "Intel(R) Centrino(R) Advanced-N 6200 BG";
+
+const struct iwl_cfg_trans_params iwl6050_trans_cfg = {
+	.device_family = IWL_DEVICE_FAMILY_6050,
+	.base_params = &iwl6050_base_params,
 };
 
 #define IWL_DEVICE_6050						\
 	.fw_name_pre = IWL6050_FW_PRE,				\
 	.ucode_api_max = IWL6050_UCODE_API_MAX,			\
 	.ucode_api_min = IWL6050_UCODE_API_MIN,			\
-	.trans.device_family = IWL_DEVICE_FAMILY_6050,		\
 	.max_inst_size = IWL60_RTC_INST_SIZE,			\
 	.max_data_size = IWL60_RTC_DATA_SIZE,			\
 	.valid_tx_ant = ANT_AB,		/* .cfg overwrite */	\
 	.valid_rx_ant = ANT_AB,		/* .cfg overwrite */	\
 	.nvm_ver = EEPROM_6050_EEPROM_VERSION,		\
 	.nvm_calib_ver = EEPROM_6050_TX_POWER_VERSION,	\
-	.trans.base_params = &iwl6050_base_params,		\
 	.eeprom_params = &iwl6000_eeprom_params,		\
 	.led_mode = IWL_LED_BLINK,				\
 	.internal_wimax_coex = true
 
 const struct iwl_cfg iwl6050_2agn_cfg = {
-	.name = "Intel(R) Centrino(R) Advanced-N + WiMAX 6250 AGN",
 	IWL_DEVICE_6050,
 	.ht_params = &iwl6000_ht_params,
 };
 
+const char iwl6050_2agn_name[] = "Intel(R) Centrino(R) Advanced-N + WiMAX 6250 AGN";
+
 const struct iwl_cfg iwl6050_2abg_cfg = {
-	.name = "Intel(R) Centrino(R) Advanced-N + WiMAX 6250 ABG",
 	IWL_DEVICE_6050,
 };
 
+const char iwl6050_2abg_name[] = "Intel(R) Centrino(R) Advanced-N + WiMAX 6250 ABG";
+
+const struct iwl_cfg_trans_params iwl6150_trans_cfg = {
+	.device_family = IWL_DEVICE_FAMILY_6150,
+	.base_params = &iwl6050_base_params,
+};
+
 #define IWL_DEVICE_6150						\
 	.fw_name_pre = IWL6050_FW_PRE,				\
 	.ucode_api_max = IWL6050_UCODE_API_MAX,			\
 	.ucode_api_min = IWL6050_UCODE_API_MIN,			\
-	.trans.device_family = IWL_DEVICE_FAMILY_6150,		\
 	.max_inst_size = IWL60_RTC_INST_SIZE,			\
 	.max_data_size = IWL60_RTC_DATA_SIZE,			\
 	.nvm_ver = EEPROM_6150_EEPROM_VERSION,		\
 	.nvm_calib_ver = EEPROM_6150_TX_POWER_VERSION,	\
-	.trans.base_params = &iwl6050_base_params,		\
 	.eeprom_params = &iwl6000_eeprom_params,		\
 	.led_mode = IWL_LED_BLINK,				\
 	.internal_wimax_coex = true
 
 const struct iwl_cfg iwl6150_bgn_cfg = {
-	.name = "Intel(R) Centrino(R) Wireless-N + WiMAX 6150 BGN",
 	IWL_DEVICE_6150,
 	.ht_params = &iwl6000_ht_params,
 };
 
+const char iwl6150_bgn_name[] = "Intel(R) Centrino(R) Wireless-N + WiMAX 6150 BGN";
+
 const struct iwl_cfg iwl6150_bg_cfg = {
-	.name = "Intel(R) Centrino(R) Wireless-N + WiMAX 6150 BG",
 	IWL_DEVICE_6150,
 };
 
+const char iwl6150_bg_name[] = "Intel(R) Centrino(R) Wireless-N + WiMAX 6150 BG";
+
+const struct iwl_cfg_trans_params iwl6000_trans_cfg = {
+	.device_family = IWL_DEVICE_FAMILY_6000,
+	.base_params = &iwl6000_base_params,
+};
+
 const struct iwl_cfg iwl6000_3agn_cfg = {
-	.name = "Intel(R) Centrino(R) Ultimate-N 6300 AGN",
 	.fw_name_pre = IWL6000_FW_PRE,
 	.ucode_api_max = IWL6000_UCODE_API_MAX,
 	.ucode_api_min = IWL6000_UCODE_API_MIN,
-	.trans.device_family = IWL_DEVICE_FAMILY_6000,
 	.max_inst_size = IWL60_RTC_INST_SIZE,
 	.max_data_size = IWL60_RTC_DATA_SIZE,
 	.nvm_ver = EEPROM_6000_EEPROM_VERSION,
 	.nvm_calib_ver = EEPROM_6000_TX_POWER_VERSION,
-	.trans.base_params = &iwl6000_base_params,
 	.eeprom_params = &iwl6000_eeprom_params,
 	.ht_params = &iwl6000_ht_params,
 	.led_mode = IWL_LED_BLINK,
 };
 
+const char iwl6000_3agn_name[] = "Intel(R) Centrino(R) Ultimate-N 6300 AGN";
+
 MODULE_FIRMWARE(IWL6000_MODULE_FIRMWARE(IWL6000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL6050_MODULE_FIRMWARE(IWL6050_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL6005_MODULE_FIRMWARE(IWL6000G2_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
index 4e2afdedf4c6..f81036e241b5 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2020, 2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2020, 2023, 2025 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015 Intel Deutschland GmbH
  */
@@ -89,9 +89,12 @@ static const struct iwl_ht_params iwl7000_ht_params = {
 	.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
 };
 
+const struct iwl_cfg_trans_params iwl7000_trans_cfg = {
+	.device_family = IWL_DEVICE_FAMILY_7000,
+	.base_params = &iwl7000_base_params,
+};
+
 #define IWL_DEVICE_7000_COMMON					\
-	.trans.device_family = IWL_DEVICE_FAMILY_7000,		\
-	.trans.base_params = &iwl7000_base_params,		\
 	.led_mode = IWL_LED_RF_STATE,				\
 	.nvm_hw_section_num = 0,				\
 	.non_shared_ant = ANT_A,				\
@@ -117,8 +120,22 @@ static const struct iwl_ht_params iwl7000_ht_params = {
 	.ucode_api_max = IWL7265D_UCODE_API_MAX,		\
 	.ucode_api_min = IWL7265D_UCODE_API_MIN
 
-const struct iwl_cfg iwl7260_2ac_cfg = {
-	.name = "Intel(R) Dual Band Wireless AC 7260",
+const char iwl7260_2ac_name[] = "Intel(R) Dual Band Wireless AC 7260";
+const char iwl7260_2n_name[] = "Intel(R) Dual Band Wireless N 7260";
+const char iwl7260_n_name[] = "Intel(R) Wireless N 7260";
+const char iwl3160_2ac_name[] = "Intel(R) Dual Band Wireless AC 3160";
+const char iwl3160_2n_name[] = "Intel(R) Dual Band Wireless N 3160";
+const char iwl3160_n_name[] = "Intel(R) Wireless N 3160";
+const char iwl3165_2ac_name[] = "Intel(R) Dual Band Wireless AC 3165";
+const char iwl3168_2ac_name[] = "Intel(R) Dual Band Wireless AC 3168";
+const char iwl7265_2ac_name[] = "Intel(R) Dual Band Wireless AC 7265";
+const char iwl7265_2n_name[] = "Intel(R) Dual Band Wireless N 7265";
+const char iwl7265_n_name[] = "Intel(R) Wireless N 7265";
+const char iwl7265d_2ac_name[] = "Intel(R) Dual Band Wireless AC 7265";
+const char iwl7265d_2n_name[] = "Intel(R) Dual Band Wireless N 7265";
+const char iwl7265d_n_name[] = "Intel(R) Wireless N 7265";
+
+const struct iwl_cfg iwl7260_cfg = {
 	.fw_name_pre = IWL7260_FW_PRE,
 	IWL_DEVICE_7000,
 	.ht_params = &iwl7000_ht_params,
@@ -128,8 +145,7 @@ const struct iwl_cfg iwl7260_2ac_cfg = {
 	.dccm_len = IWL7260_DCCM_LEN,
 };
 
-const struct iwl_cfg iwl7260_2ac_cfg_high_temp = {
-	.name = "Intel(R) Dual Band Wireless AC 7260",
+const struct iwl_cfg iwl7260_high_temp_cfg = {
 	.fw_name_pre = IWL7260_FW_PRE,
 	IWL_DEVICE_7000,
 	.ht_params = &iwl7000_ht_params,
@@ -141,50 +157,7 @@ const struct iwl_cfg iwl7260_2ac_cfg_high_temp = {
 	.thermal_params = &iwl7000_high_temp_tt_params,
 };
 
-const struct iwl_cfg iwl7260_2n_cfg = {
-	.name = "Intel(R) Dual Band Wireless N 7260",
-	.fw_name_pre = IWL7260_FW_PRE,
-	IWL_DEVICE_7000,
-	.ht_params = &iwl7000_ht_params,
-	.nvm_ver = IWL7260_NVM_VERSION,
-	.host_interrupt_operation_mode = true,
-	.lp_xtal_workaround = true,
-	.dccm_len = IWL7260_DCCM_LEN,
-};
-
-const struct iwl_cfg iwl7260_n_cfg = {
-	.name = "Intel(R) Wireless N 7260",
-	.fw_name_pre = IWL7260_FW_PRE,
-	IWL_DEVICE_7000,
-	.ht_params = &iwl7000_ht_params,
-	.nvm_ver = IWL7260_NVM_VERSION,
-	.host_interrupt_operation_mode = true,
-	.lp_xtal_workaround = true,
-	.dccm_len = IWL7260_DCCM_LEN,
-};
-
-const struct iwl_cfg iwl3160_2ac_cfg = {
-	.name = "Intel(R) Dual Band Wireless AC 3160",
-	.fw_name_pre = IWL3160_FW_PRE,
-	IWL_DEVICE_7000,
-	.ht_params = &iwl7000_ht_params,
-	.nvm_ver = IWL3160_NVM_VERSION,
-	.host_interrupt_operation_mode = true,
-	.dccm_len = IWL3160_DCCM_LEN,
-};
-
-const struct iwl_cfg iwl3160_2n_cfg = {
-	.name = "Intel(R) Dual Band Wireless N 3160",
-	.fw_name_pre = IWL3160_FW_PRE,
-	IWL_DEVICE_7000,
-	.ht_params = &iwl7000_ht_params,
-	.nvm_ver = IWL3160_NVM_VERSION,
-	.host_interrupt_operation_mode = true,
-	.dccm_len = IWL3160_DCCM_LEN,
-};
-
-const struct iwl_cfg iwl3160_n_cfg = {
-	.name = "Intel(R) Wireless N 3160",
+const struct iwl_cfg iwl3160_cfg = {
 	.fw_name_pre = IWL3160_FW_PRE,
 	IWL_DEVICE_7000,
 	.ht_params = &iwl7000_ht_params,
@@ -211,7 +184,6 @@ static const struct iwl_ht_params iwl7265_ht_params = {
 };
 
 const struct iwl_cfg iwl3165_2ac_cfg = {
-	.name = "Intel(R) Dual Band Wireless AC 3165",
 	.fw_name_pre = IWL7265D_FW_PRE,
 	IWL_DEVICE_7005D,
 	.ht_params = &iwl7000_ht_params,
@@ -221,7 +193,6 @@ const struct iwl_cfg iwl3165_2ac_cfg = {
 };
 
 const struct iwl_cfg iwl3168_2ac_cfg = {
-	.name = "Intel(R) Dual Band Wireless AC 3168",
 	.fw_name_pre = IWL3168_FW_PRE,
 	IWL_DEVICE_3008,
 	.ht_params = &iwl7000_ht_params,
@@ -231,28 +202,7 @@ const struct iwl_cfg iwl3168_2ac_cfg = {
 	.nvm_type = IWL_NVM_SDP,
 };
 
-const struct iwl_cfg iwl7265_2ac_cfg = {
-	.name = "Intel(R) Dual Band Wireless AC 7265",
-	.fw_name_pre = IWL7265_FW_PRE,
-	IWL_DEVICE_7005,
-	.ht_params = &iwl7265_ht_params,
-	.nvm_ver = IWL7265_NVM_VERSION,
-	.pwr_tx_backoffs = iwl7265_pwr_tx_backoffs,
-	.dccm_len = IWL7265_DCCM_LEN,
-};
-
-const struct iwl_cfg iwl7265_2n_cfg = {
-	.name = "Intel(R) Dual Band Wireless N 7265",
-	.fw_name_pre = IWL7265_FW_PRE,
-	IWL_DEVICE_7005,
-	.ht_params = &iwl7265_ht_params,
-	.nvm_ver = IWL7265_NVM_VERSION,
-	.pwr_tx_backoffs = iwl7265_pwr_tx_backoffs,
-	.dccm_len = IWL7265_DCCM_LEN,
-};
-
-const struct iwl_cfg iwl7265_n_cfg = {
-	.name = "Intel(R) Wireless N 7265",
+const struct iwl_cfg iwl7265_cfg = {
 	.fw_name_pre = IWL7265_FW_PRE,
 	IWL_DEVICE_7005,
 	.ht_params = &iwl7265_ht_params,
@@ -261,28 +211,7 @@ const struct iwl_cfg iwl7265_n_cfg = {
 	.dccm_len = IWL7265_DCCM_LEN,
 };
 
-const struct iwl_cfg iwl7265d_2ac_cfg = {
-	.name = "Intel(R) Dual Band Wireless AC 7265",
-	.fw_name_pre = IWL7265D_FW_PRE,
-	IWL_DEVICE_7005D,
-	.ht_params = &iwl7265_ht_params,
-	.nvm_ver = IWL7265D_NVM_VERSION,
-	.pwr_tx_backoffs = iwl7265_pwr_tx_backoffs,
-	.dccm_len = IWL7265_DCCM_LEN,
-};
-
-const struct iwl_cfg iwl7265d_2n_cfg = {
-	.name = "Intel(R) Dual Band Wireless N 7265",
-	.fw_name_pre = IWL7265D_FW_PRE,
-	IWL_DEVICE_7005D,
-	.ht_params = &iwl7265_ht_params,
-	.nvm_ver = IWL7265D_NVM_VERSION,
-	.pwr_tx_backoffs = iwl7265_pwr_tx_backoffs,
-	.dccm_len = IWL7265_DCCM_LEN,
-};
-
-const struct iwl_cfg iwl7265d_n_cfg = {
-	.name = "Intel(R) Wireless N 7265",
+const struct iwl_cfg iwl7265d_cfg = {
 	.fw_name_pre = IWL7265D_FW_PRE,
 	IWL_DEVICE_7005D,
 	.ht_params = &iwl7265_ht_params,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
index d09cf8d7dc01..7f6f6a9ea615 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2014, 2018-2020, 2023 Intel Corporation
+ * Copyright (C) 2014, 2018-2020, 2023, 2025 Intel Corporation
  * Copyright (C) 2014-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016 Intel Deutschland GmbH
  */
@@ -76,9 +76,12 @@ static const struct iwl_tt_params iwl8000_tt_params = {
 	.support_tx_backoff = true,
 };
 
+const struct iwl_cfg_trans_params iwl8000_trans_cfg = {
+	.device_family = IWL_DEVICE_FAMILY_8000,
+	.base_params = &iwl8000_base_params,
+};
+
 #define IWL_DEVICE_8000_COMMON						\
-	.trans.device_family = IWL_DEVICE_FAMILY_8000,			\
-	.trans.base_params = &iwl8000_base_params,			\
 	.led_mode = IWL_LED_RF_STATE,					\
 	.nvm_hw_section_num = 10,					\
 	.features = NETIF_F_RXCSUM,					\
@@ -96,11 +99,6 @@ static const struct iwl_tt_params iwl8000_tt_params = {
 	.dbgc_supported = true,						\
 	.min_umac_error_event_table = 0x800000
 
-#define IWL_DEVICE_8000							\
-	IWL_DEVICE_8000_COMMON,						\
-	.ucode_api_max = IWL8000_UCODE_API_MAX,				\
-	.ucode_api_min = IWL8000_UCODE_API_MIN				\
-
 #define IWL_DEVICE_8260							\
 	IWL_DEVICE_8000_COMMON,						\
 	.ucode_api_max = IWL8000_UCODE_API_MAX,				\
@@ -111,23 +109,20 @@ static const struct iwl_tt_params iwl8000_tt_params = {
 	.ucode_api_max = IWL8265_UCODE_API_MAX,				\
 	.ucode_api_min = IWL8265_UCODE_API_MIN				\
 
-const struct iwl_cfg iwl8260_2n_cfg = {
-	.name = "Intel(R) Dual Band Wireless N 8260",
-	.fw_name_pre = IWL8000_FW_PRE,
-	IWL_DEVICE_8260,
-	.ht_params = &iwl8000_ht_params,
-	.nvm_ver = IWL8000_NVM_VERSION,
-};
+const char iwl8260_2n_name[] = "Intel(R) Dual Band Wireless N 8260";
+const char iwl8260_2ac_name[] = "Intel(R) Dual Band Wireless AC 8260";
+const char iwl8265_2ac_name[] = "Intel(R) Dual Band Wireless AC 8265";
+const char iwl8275_2ac_name[] = "Intel(R) Dual Band Wireless AC 8275";
+const char iwl4165_2ac_name[] = "Intel(R) Dual Band Wireless AC 4165";
 
-const struct iwl_cfg iwl8260_2ac_cfg = {
-	.name = "Intel(R) Dual Band Wireless AC 8260",
+const struct iwl_cfg iwl8260_cfg = {
 	.fw_name_pre = IWL8000_FW_PRE,
 	IWL_DEVICE_8260,
 	.ht_params = &iwl8000_ht_params,
 	.nvm_ver = IWL8000_NVM_VERSION,
 };
 
-const struct iwl_cfg iwl8265_2ac_cfg = {
+const struct iwl_cfg iwl8265_cfg = {
 	.name = "Intel(R) Dual Band Wireless AC 8265",
 	.fw_name_pre = IWL8265_FW_PRE,
 	IWL_DEVICE_8265,
@@ -136,22 +131,5 @@ const struct iwl_cfg iwl8265_2ac_cfg = {
 	.vht_mu_mimo_supported = true,
 };
 
-const struct iwl_cfg iwl8275_2ac_cfg = {
-	.name = "Intel(R) Dual Band Wireless AC 8275",
-	.fw_name_pre = IWL8265_FW_PRE,
-	IWL_DEVICE_8265,
-	.ht_params = &iwl8000_ht_params,
-	.nvm_ver = IWL8000_NVM_VERSION,
-	.vht_mu_mimo_supported = true,
-};
-
-const struct iwl_cfg iwl4165_2ac_cfg = {
-	.name = "Intel(R) Dual Band Wireless AC 4165",
-	.fw_name_pre = IWL8000_FW_PRE,
-	IWL_DEVICE_8000,
-	.ht_params = &iwl8000_ht_params,
-	.nvm_ver = IWL8000_NVM_VERSION,
-};
-
 MODULE_FIRMWARE(IWL8000_MODULE_FIRMWARE(IWL8000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL8265_MODULE_FIRMWARE(IWL8265_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 40244bdcad6f..610dbbaee26f 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -72,13 +72,10 @@ static const struct iwl_base_params iwl_ax210_base_params = {
 	.smem_len = IWL_AX210_SMEM_LEN,					\
 	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,		\
 	.apmg_not_supported = true,					\
-	.trans.mq_rx_supported = true,					\
 	.vht_mu_mimo_supported = true,					\
 	.mac_addr_from_csr = 0x380,					\
 	.ht_params = &iwl_22000_ht_params,				\
 	.nvm_ver = IWL_AX210_NVM_VERSION,				\
-	.trans.rf_id = true,						\
-	.trans.gen2 = true,						\
 	.nvm_type = IWL_NVM_EXT,					\
 	.dbgc_supported = true,						\
 	.min_umac_error_event_table = 0x400000,				\
@@ -98,9 +95,6 @@ static const struct iwl_base_params iwl_ax210_base_params = {
 #define IWL_DEVICE_AX210						\
 	IWL_DEVICE_AX210_COMMON,					\
 	.ucode_api_max = IWL_AX210_UCODE_API_MAX,			\
-	.trans.umac_prph_offset = 0x300000,				\
-	.trans.device_family = IWL_DEVICE_FAMILY_AX210,			\
-	.trans.base_params = &iwl_ax210_base_params,			\
 	.min_txq_size = 128,						\
 	.gp2_reg_addr = 0xd02c68,					\
 	.min_ba_txq_size = IWL_DEFAULT_QUEUE_SIZE_HE,		\
@@ -218,16 +212,6 @@ const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
-const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0_long = {
-	.name = iwl_ax211_name,
-	.fw_name_pre = IWL_SO_A_GF_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-	.trans.xtal_latency = 12000,
-	.trans.low_latency_xtal = true,
-};
-
 const struct iwl_cfg iwlax210_2ax_cfg_ty_gf_a0 = {
 	.name = "Intel(R) Wi-Fi 6 AX210 160MHz",
 	.fw_name_pre = IWL_TY_A_GF_A_FW_PRE,
@@ -244,16 +228,6 @@ const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
-const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0_long = {
-	.name = iwl_ax411_name,
-	.fw_name_pre = IWL_SO_A_GF4_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-	.trans.xtal_latency = 12000,
-	.trans.low_latency_xtal = true,
-};
-
 const struct iwl_cfg iwl_cfg_ma = {
 	.uhb_supported = true,
 	IWL_DEVICE_AX210,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index abd4bfd2a812..cc405a4b21a9 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -75,12 +75,9 @@ const struct iwl_ht_params iwl_bz_ht_params = {
 	.smem_offset = IWL_BZ_SMEM_OFFSET,				\
 	.smem_len = IWL_BZ_SMEM_LEN,					\
 	.apmg_not_supported = true,					\
-	.trans.mq_rx_supported = true,					\
 	.vht_mu_mimo_supported = true,					\
 	.mac_addr_from_csr = 0x30,					\
 	.nvm_ver = IWL_BZ_NVM_VERSION,				\
-	.trans.rf_id = true,						\
-	.trans.gen2 = true,						\
 	.nvm_type = IWL_NVM_EXT,					\
 	.dbgc_supported = true,						\
 	.min_umac_error_event_table = 0xD0000,				\
@@ -96,9 +93,6 @@ const struct iwl_ht_params iwl_bz_ht_params = {
 			.mask = LDBG_M2S_BUF_WRAP_CNT_VAL_MSK,		\
 		},							\
 	},								\
-	.trans.umac_prph_offset = 0x300000,				\
-	.trans.device_family = IWL_DEVICE_FAMILY_BZ,			\
-	.trans.base_params = &iwl_bz_base_params,			\
 	.min_txq_size = 128,						\
 	.gp2_reg_addr = 0xd02c68,					\
 	.min_ba_txq_size = IWL_DEFAULT_QUEUE_SIZE_EHT,			\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index 8bbeb2a1f691..7211c6376b99 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -61,12 +61,9 @@ static const struct iwl_base_params iwl_dr_base_params = {
 	.smem_offset = IWL_DR_SMEM_OFFSET,				\
 	.smem_len = IWL_DR_SMEM_LEN,					\
 	.apmg_not_supported = true,					\
-	.trans.mq_rx_supported = true,					\
 	.vht_mu_mimo_supported = true,					\
 	.mac_addr_from_csr = 0x30,					\
 	.nvm_ver = IWL_DR_NVM_VERSION,				\
-	.trans.rf_id = true,						\
-	.trans.gen2 = true,						\
 	.nvm_type = IWL_NVM_EXT,					\
 	.dbgc_supported = true,						\
 	.min_umac_error_event_table = 0xD0000,				\
@@ -82,9 +79,6 @@ static const struct iwl_base_params iwl_dr_base_params = {
 			.mask = LDBG_M2S_BUF_WRAP_CNT_VAL_MSK,		\
 		},							\
 	},								\
-	.trans.umac_prph_offset = 0x300000,				\
-	.trans.device_family = IWL_DEVICE_FAMILY_DR,			\
-	.trans.base_params = &iwl_dr_base_params,			\
 	.min_txq_size = 128,						\
 	.gp2_reg_addr = 0xd02c68,					\
 	.min_ba_txq_size = IWL_DEFAULT_QUEUE_SIZE_EHT,			\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 99955fc9331d..033cbf4d1a0d 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -68,12 +68,9 @@ static const struct iwl_base_params iwl_sc_base_params = {
 	.smem_offset = IWL_SC_SMEM_OFFSET,				\
 	.smem_len = IWL_SC_SMEM_LEN,					\
 	.apmg_not_supported = true,					\
-	.trans.mq_rx_supported = true,					\
 	.vht_mu_mimo_supported = true,					\
 	.mac_addr_from_csr = 0x30,					\
 	.nvm_ver = IWL_SC_NVM_VERSION,					\
-	.trans.rf_id = true,						\
-	.trans.gen2 = true,						\
 	.nvm_type = IWL_NVM_EXT,					\
 	.dbgc_supported = true,						\
 	.min_umac_error_event_table = 0xD0000,				\
@@ -89,9 +86,6 @@ static const struct iwl_base_params iwl_sc_base_params = {
 			.mask = LDBG_M2S_BUF_WRAP_CNT_VAL_MSK,		\
 		},							\
 	},								\
-	.trans.umac_prph_offset = 0x300000,				\
-	.trans.device_family = IWL_DEVICE_FAMILY_SC,			\
-	.trans.base_params = &iwl_sc_base_params,			\
 	.min_txq_size = 128,						\
 	.gp2_reg_addr = 0xd02c68,					\
 	.min_ba_txq_size = IWL_DEFAULT_QUEUE_SIZE_EHT,			\
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index f8044af3b0f2..e8fc51fae61d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -305,11 +305,8 @@ struct iwl_fw_mon_regs {
 	struct iwl_fw_mon_reg cur_frag;
 };
 
-#define TRANS_CFG_MARKER BIT(0)
-
 /**
  * struct iwl_cfg
- * @trans: the trans-specific configuration part
  * @name: Official name of the device
  * @fw_name_pre: Firmware filename prefix. The api version and extension
  *	(.ucode) will be added to filename before loading from disk. The
@@ -360,7 +357,6 @@ struct iwl_fw_mon_regs {
  * and/or the uCode API version instead.
  */
 struct iwl_cfg {
-	struct iwl_cfg_trans_params trans;
 	/* params specific to an individual device within a device family */
 	const char *name;
 	const char *fw_name_pre;
@@ -491,6 +487,21 @@ extern const struct pci_device_id iwl_hw_card_ids[];
 /*
  * This list declares the config structures for all devices.
  */
+extern const struct iwl_cfg_trans_params iwl1000_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl5000_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl2000_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl2030_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl105_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl135_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl5150_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl6005_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl6030_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl6000i_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl6050_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl6150_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl6000_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl7000_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl8000_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl9000_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl9560_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl9560_long_latency_trans_cfg;
@@ -508,6 +519,68 @@ extern const struct iwl_cfg_trans_params iwl_gl_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_sc_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_dr_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_br_trans_cfg;
+
+extern const char iwl1000_bgn_name[];
+extern const char iwl1000_bg_name[];
+extern const char iwl100_bgn_name[];
+extern const char iwl100_bg_name[];
+extern const char iwl2000_2bgn_name[];
+extern const char iwl2000_2bgn_d_name[];
+extern const char iwl2030_2bgn_name[];
+extern const char iwl105_bgn_name[];
+extern const char iwl105_bgn_d_name[];
+extern const char iwl135_bgn_name[];
+extern const char iwl5300_agn_name[];
+extern const char iwl5100_bgn_name[];
+extern const char iwl5100_abg_name[];
+extern const char iwl5100_agn_name[];
+extern const char iwl5350_agn_name[];
+extern const char iwl5150_agn_name[];
+extern const char iwl5150_abg_name[];
+extern const char iwl6005_2agn_name[];
+extern const char iwl6005_2abg_name[];
+extern const char iwl6005_2bg_name[];
+extern const char iwl6005_2agn_sff_name[];
+extern const char iwl6005_2agn_d_name[];
+extern const char iwl6005_2agn_mow1_name[];
+extern const char iwl6005_2agn_mow2_name[];
+extern const char iwl6030_2agn_name[];
+extern const char iwl6030_2abg_name[];
+extern const char iwl6030_2bgn_name[];
+extern const char iwl6030_2bg_name[];
+extern const char iwl6035_2agn_name[];
+extern const char iwl6035_2agn_sff_name[];
+extern const char iwl1030_bgn_name[];
+extern const char iwl1030_bg_name[];
+extern const char iwl130_bgn_name[];
+extern const char iwl130_bg_name[];
+extern const char iwl6000i_2agn_name[];
+extern const char iwl6000i_2abg_name[];
+extern const char iwl6000i_2bg_name[];
+extern const char iwl6050_2agn_name[];
+extern const char iwl6050_2abg_name[];
+extern const char iwl6150_bgn_name[];
+extern const char iwl6150_bg_name[];
+extern const char iwl6000_3agn_name[];
+extern const char iwl7260_2ac_name[];
+extern const char iwl7260_2n_name[];
+extern const char iwl7260_n_name[];
+extern const char iwl3160_2ac_name[];
+extern const char iwl3160_2n_name[];
+extern const char iwl3160_n_name[];
+extern const char iwl3165_2ac_name[];
+extern const char iwl3168_2ac_name[];
+extern const char iwl7265_2ac_name[];
+extern const char iwl7265_2n_name[];
+extern const char iwl7265_n_name[];
+extern const char iwl7265d_2ac_name[];
+extern const char iwl7265d_2n_name[];
+extern const char iwl7265d_n_name[];
+extern const char iwl8260_2n_name[];
+extern const char iwl8260_2ac_name[];
+extern const char iwl8265_2ac_name[];
+extern const char iwl8275_2ac_name[];
+extern const char iwl4165_2ac_name[];
 extern const char iwl9162_name[];
 extern const char iwl9260_name[];
 extern const char iwl9260_1_name[];
@@ -553,28 +626,18 @@ extern const char iwl_dr_name[];
 extern const char iwl_br_name[];
 #if IS_ENABLED(CONFIG_IWLDVM)
 extern const struct iwl_cfg iwl5300_agn_cfg;
-extern const struct iwl_cfg iwl5100_agn_cfg;
 extern const struct iwl_cfg iwl5350_agn_cfg;
-extern const struct iwl_cfg iwl5100_bgn_cfg;
+extern const struct iwl_cfg iwl5100_n_cfg;
 extern const struct iwl_cfg iwl5100_abg_cfg;
 extern const struct iwl_cfg iwl5150_agn_cfg;
 extern const struct iwl_cfg iwl5150_abg_cfg;
-extern const struct iwl_cfg iwl6005_2agn_cfg;
-extern const struct iwl_cfg iwl6005_2abg_cfg;
-extern const struct iwl_cfg iwl6005_2bg_cfg;
-extern const struct iwl_cfg iwl6005_2agn_sff_cfg;
-extern const struct iwl_cfg iwl6005_2agn_d_cfg;
-extern const struct iwl_cfg iwl6005_2agn_mow1_cfg;
-extern const struct iwl_cfg iwl6005_2agn_mow2_cfg;
-extern const struct iwl_cfg iwl1030_bgn_cfg;
-extern const struct iwl_cfg iwl1030_bg_cfg;
-extern const struct iwl_cfg iwl6030_2agn_cfg;
-extern const struct iwl_cfg iwl6030_2abg_cfg;
-extern const struct iwl_cfg iwl6030_2bgn_cfg;
-extern const struct iwl_cfg iwl6030_2bg_cfg;
+extern const struct iwl_cfg iwl6005_non_n_cfg;
+extern const struct iwl_cfg iwl6005_n_cfg;
+extern const struct iwl_cfg iwl6030_n_cfg;
+extern const struct iwl_cfg iwl6030_non_n_cfg;
 extern const struct iwl_cfg iwl6000i_2agn_cfg;
-extern const struct iwl_cfg iwl6000i_2abg_cfg;
-extern const struct iwl_cfg iwl6000i_2bg_cfg;
+extern const struct iwl_cfg iwl6000i_non_n_cfg;
+extern const struct iwl_cfg iwl6000i_non_n_cfg;
 extern const struct iwl_cfg iwl6000_3agn_cfg;
 extern const struct iwl_cfg iwl6050_2agn_cfg;
 extern const struct iwl_cfg iwl6050_2abg_cfg;
@@ -587,36 +650,23 @@ extern const struct iwl_cfg iwl100_bg_cfg;
 extern const struct iwl_cfg iwl130_bgn_cfg;
 extern const struct iwl_cfg iwl130_bg_cfg;
 extern const struct iwl_cfg iwl2000_2bgn_cfg;
-extern const struct iwl_cfg iwl2000_2bgn_d_cfg;
 extern const struct iwl_cfg iwl2030_2bgn_cfg;
 extern const struct iwl_cfg iwl6035_2agn_cfg;
-extern const struct iwl_cfg iwl6035_2agn_sff_cfg;
 extern const struct iwl_cfg iwl105_bgn_cfg;
-extern const struct iwl_cfg iwl105_bgn_d_cfg;
 extern const struct iwl_cfg iwl135_bgn_cfg;
 #endif /* CONFIG_IWLDVM */
 #if IS_ENABLED(CONFIG_IWLMVM)
 extern const struct iwl_ht_params iwl_22000_ht_params;
-extern const struct iwl_cfg iwl7260_2ac_cfg;
-extern const struct iwl_cfg iwl7260_2ac_cfg_high_temp;
-extern const struct iwl_cfg iwl7260_2n_cfg;
-extern const struct iwl_cfg iwl7260_n_cfg;
-extern const struct iwl_cfg iwl3160_2ac_cfg;
-extern const struct iwl_cfg iwl3160_2n_cfg;
-extern const struct iwl_cfg iwl3160_n_cfg;
+
+extern const struct iwl_cfg iwl7260_cfg;
+extern const struct iwl_cfg iwl7260_high_temp_cfg;
+extern const struct iwl_cfg iwl3160_cfg;
 extern const struct iwl_cfg iwl3165_2ac_cfg;
 extern const struct iwl_cfg iwl3168_2ac_cfg;
-extern const struct iwl_cfg iwl7265_2ac_cfg;
-extern const struct iwl_cfg iwl7265_2n_cfg;
-extern const struct iwl_cfg iwl7265_n_cfg;
-extern const struct iwl_cfg iwl7265d_2ac_cfg;
-extern const struct iwl_cfg iwl7265d_2n_cfg;
-extern const struct iwl_cfg iwl7265d_n_cfg;
-extern const struct iwl_cfg iwl8260_2n_cfg;
-extern const struct iwl_cfg iwl8260_2ac_cfg;
-extern const struct iwl_cfg iwl8265_2ac_cfg;
-extern const struct iwl_cfg iwl8275_2ac_cfg;
-extern const struct iwl_cfg iwl4165_2ac_cfg;
+extern const struct iwl_cfg iwl7265_cfg;
+extern const struct iwl_cfg iwl7265d_cfg;
+extern const struct iwl_cfg iwl8260_cfg;
+extern const struct iwl_cfg iwl8265_cfg;
 extern const struct iwl_cfg iwl9260_2ac_cfg;
 extern const struct iwl_cfg iwl9260_2ac_cfg_80mhz;
 extern const struct iwl_cfg iwl9560_qu_jf_cfg;
@@ -632,10 +682,8 @@ extern const struct iwl_cfg iwl_ax200_cfg_cc;
 extern const struct iwl_cfg iwlax210_2ax_cfg_so_jf_b0;
 extern const struct iwl_cfg iwlax210_2ax_cfg_so_jf_b0_80mhz;
 extern const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0;
-extern const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0_long;
 extern const struct iwl_cfg iwlax210_2ax_cfg_ty_gf_a0;
 extern const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0;
-extern const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0_long;
 
 extern const struct iwl_cfg iwl_cfg_ma;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 4c2786655f7d..55f07c68339c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -20,11 +20,10 @@
 #define _IS_A(cfg, _struct) __builtin_types_compatible_p(typeof(cfg),	\
 							 struct _struct)
 extern int _invalid_type;
-#define _TRANS_CFG_MARKER(cfg)						\
+#define _TRANS_CFG_CHECK(cfg)						\
 	(__builtin_choose_expr(_IS_A(cfg, iwl_cfg_trans_params),	\
-			       TRANS_CFG_MARKER,			\
-	 __builtin_choose_expr(_IS_A(cfg, iwl_cfg), 0, _invalid_type)))
-#define _ASSIGN_CFG(cfg) (_TRANS_CFG_MARKER(cfg) + (kernel_ulong_t)&(cfg))
+			       0, _invalid_type))
+#define _ASSIGN_CFG(cfg) (_TRANS_CFG_CHECK(cfg) + (kernel_ulong_t)&(cfg))
 
 #define IWL_PCI_DEVICE(dev, subdev, cfg) \
 	.vendor = PCI_VENDOR_ID_INTEL,  .device = (dev), \
@@ -34,434 +33,434 @@ extern int _invalid_type;
 /* Hardware specific file defines the PCI IDs table for that hardware module */
 VISIBLE_IF_IWLWIFI_KUNIT const struct pci_device_id iwl_hw_card_ids[] = {
 #if IS_ENABLED(CONFIG_IWLDVM)
-	{IWL_PCI_DEVICE(0x4232, 0x1201, iwl5100_agn_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4232, 0x1301, iwl5100_agn_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4232, 0x1204, iwl5100_agn_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4232, 0x1304, iwl5100_agn_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4232, 0x1205, iwl5100_bgn_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4232, 0x1305, iwl5100_bgn_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4232, 0x1206, iwl5100_abg_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4232, 0x1306, iwl5100_abg_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4232, 0x1221, iwl5100_agn_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4232, 0x1321, iwl5100_agn_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4232, 0x1224, iwl5100_agn_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4232, 0x1324, iwl5100_agn_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4232, 0x1225, iwl5100_bgn_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4232, 0x1325, iwl5100_bgn_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4232, 0x1226, iwl5100_abg_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4232, 0x1326, iwl5100_abg_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4237, 0x1211, iwl5100_agn_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4237, 0x1311, iwl5100_agn_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4237, 0x1214, iwl5100_agn_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4237, 0x1314, iwl5100_agn_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4237, 0x1215, iwl5100_bgn_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4237, 0x1315, iwl5100_bgn_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4237, 0x1216, iwl5100_abg_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4237, 0x1316, iwl5100_abg_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1201, iwl5000_trans_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1301, iwl5000_trans_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1204, iwl5000_trans_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1304, iwl5000_trans_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1205, iwl5000_trans_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1305, iwl5000_trans_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1206, iwl5000_trans_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1306, iwl5000_trans_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1221, iwl5000_trans_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1321, iwl5000_trans_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1224, iwl5000_trans_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1324, iwl5000_trans_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1225, iwl5000_trans_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1325, iwl5000_trans_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1226, iwl5000_trans_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4232, 0x1326, iwl5000_trans_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4237, 0x1211, iwl5000_trans_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4237, 0x1311, iwl5000_trans_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4237, 0x1214, iwl5000_trans_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4237, 0x1314, iwl5000_trans_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4237, 0x1215, iwl5000_trans_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4237, 0x1315, iwl5000_trans_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4237, 0x1216, iwl5000_trans_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4237, 0x1316, iwl5000_trans_cfg)}, /* Half Mini Card */
 
 /* 5300 Series WiFi */
-	{IWL_PCI_DEVICE(0x4235, 0x1021, iwl5300_agn_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4235, 0x1121, iwl5300_agn_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4235, 0x1024, iwl5300_agn_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4235, 0x1124, iwl5300_agn_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4235, 0x1001, iwl5300_agn_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4235, 0x1101, iwl5300_agn_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4235, 0x1004, iwl5300_agn_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4235, 0x1104, iwl5300_agn_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4236, 0x1011, iwl5300_agn_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4236, 0x1111, iwl5300_agn_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x4236, 0x1014, iwl5300_agn_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x4236, 0x1114, iwl5300_agn_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4235, 0x1021, iwl5000_trans_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4235, 0x1121, iwl5000_trans_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4235, 0x1024, iwl5000_trans_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4235, 0x1124, iwl5000_trans_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4235, 0x1001, iwl5000_trans_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4235, 0x1101, iwl5000_trans_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4235, 0x1004, iwl5000_trans_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4235, 0x1104, iwl5000_trans_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4236, 0x1011, iwl5000_trans_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4236, 0x1111, iwl5000_trans_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x4236, 0x1014, iwl5000_trans_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x4236, 0x1114, iwl5000_trans_cfg)}, /* Half Mini Card */
 
 /* 5350 Series WiFi/WiMax */
-	{IWL_PCI_DEVICE(0x423A, 0x1001, iwl5350_agn_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x423A, 0x1021, iwl5350_agn_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x423B, 0x1011, iwl5350_agn_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x423A, 0x1001, iwl5000_trans_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x423A, 0x1021, iwl5000_trans_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x423B, 0x1011, iwl5000_trans_cfg)}, /* Mini Card */
 
 /* 5150 Series Wifi/WiMax */
-	{IWL_PCI_DEVICE(0x423C, 0x1201, iwl5150_agn_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x423C, 0x1301, iwl5150_agn_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x423C, 0x1206, iwl5150_abg_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x423C, 0x1306, iwl5150_abg_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x423C, 0x1221, iwl5150_agn_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x423C, 0x1321, iwl5150_agn_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x423C, 0x1326, iwl5150_abg_cfg)}, /* Half Mini Card */
-
-	{IWL_PCI_DEVICE(0x423D, 0x1211, iwl5150_agn_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x423D, 0x1311, iwl5150_agn_cfg)}, /* Half Mini Card */
-	{IWL_PCI_DEVICE(0x423D, 0x1216, iwl5150_abg_cfg)}, /* Mini Card */
-	{IWL_PCI_DEVICE(0x423D, 0x1316, iwl5150_abg_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x423C, 0x1201, iwl5150_trans_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x423C, 0x1301, iwl5150_trans_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x423C, 0x1206, iwl5150_trans_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x423C, 0x1306, iwl5150_trans_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x423C, 0x1221, iwl5150_trans_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x423C, 0x1321, iwl5150_trans_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x423C, 0x1326, iwl5150_trans_cfg)}, /* Half Mini Card */
+
+	{IWL_PCI_DEVICE(0x423D, 0x1211, iwl5150_trans_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x423D, 0x1311, iwl5150_trans_cfg)}, /* Half Mini Card */
+	{IWL_PCI_DEVICE(0x423D, 0x1216, iwl5150_trans_cfg)}, /* Mini Card */
+	{IWL_PCI_DEVICE(0x423D, 0x1316, iwl5150_trans_cfg)}, /* Half Mini Card */
 
 /* 6x00 Series */
-	{IWL_PCI_DEVICE(0x422B, 0x1101, iwl6000_3agn_cfg)},
-	{IWL_PCI_DEVICE(0x422B, 0x1108, iwl6000_3agn_cfg)},
-	{IWL_PCI_DEVICE(0x422B, 0x1121, iwl6000_3agn_cfg)},
-	{IWL_PCI_DEVICE(0x422B, 0x1128, iwl6000_3agn_cfg)},
-	{IWL_PCI_DEVICE(0x422C, 0x1301, iwl6000i_2agn_cfg)},
-	{IWL_PCI_DEVICE(0x422C, 0x1306, iwl6000i_2abg_cfg)},
-	{IWL_PCI_DEVICE(0x422C, 0x1307, iwl6000i_2bg_cfg)},
-	{IWL_PCI_DEVICE(0x422C, 0x1321, iwl6000i_2agn_cfg)},
-	{IWL_PCI_DEVICE(0x422C, 0x1326, iwl6000i_2abg_cfg)},
-	{IWL_PCI_DEVICE(0x4238, 0x1111, iwl6000_3agn_cfg)},
-	{IWL_PCI_DEVICE(0x4238, 0x1118, iwl6000_3agn_cfg)},
-	{IWL_PCI_DEVICE(0x4239, 0x1311, iwl6000i_2agn_cfg)},
-	{IWL_PCI_DEVICE(0x4239, 0x1316, iwl6000i_2abg_cfg)},
+	{IWL_PCI_DEVICE(0x422B, 0x1101, iwl6000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x422B, 0x1108, iwl6000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x422B, 0x1121, iwl6000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x422B, 0x1128, iwl6000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x422C, 0x1301, iwl6000i_trans_cfg)},
+	{IWL_PCI_DEVICE(0x422C, 0x1306, iwl6000i_trans_cfg)},
+	{IWL_PCI_DEVICE(0x422C, 0x1307, iwl6000i_trans_cfg)},
+	{IWL_PCI_DEVICE(0x422C, 0x1321, iwl6000i_trans_cfg)},
+	{IWL_PCI_DEVICE(0x422C, 0x1326, iwl6000i_trans_cfg)},
+	{IWL_PCI_DEVICE(0x4238, 0x1111, iwl6000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x4238, 0x1118, iwl6000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x4239, 0x1311, iwl6000i_trans_cfg)},
+	{IWL_PCI_DEVICE(0x4239, 0x1316, iwl6000i_trans_cfg)},
 
 /* 6x05 Series */
-	{IWL_PCI_DEVICE(0x0082, 0x1301, iwl6005_2agn_cfg)},
-	{IWL_PCI_DEVICE(0x0082, 0x1306, iwl6005_2abg_cfg)},
-	{IWL_PCI_DEVICE(0x0082, 0x1307, iwl6005_2bg_cfg)},
-	{IWL_PCI_DEVICE(0x0082, 0x1308, iwl6005_2agn_cfg)},
-	{IWL_PCI_DEVICE(0x0082, 0x1321, iwl6005_2agn_cfg)},
-	{IWL_PCI_DEVICE(0x0082, 0x1326, iwl6005_2abg_cfg)},
-	{IWL_PCI_DEVICE(0x0082, 0x1328, iwl6005_2agn_cfg)},
-	{IWL_PCI_DEVICE(0x0085, 0x1311, iwl6005_2agn_cfg)},
-	{IWL_PCI_DEVICE(0x0085, 0x1318, iwl6005_2agn_cfg)},
-	{IWL_PCI_DEVICE(0x0085, 0x1316, iwl6005_2abg_cfg)},
-	{IWL_PCI_DEVICE(0x0082, 0xC020, iwl6005_2agn_sff_cfg)},
-	{IWL_PCI_DEVICE(0x0085, 0xC220, iwl6005_2agn_sff_cfg)},
-	{IWL_PCI_DEVICE(0x0085, 0xC228, iwl6005_2agn_sff_cfg)},
-	{IWL_PCI_DEVICE(0x0082, 0x4820, iwl6005_2agn_d_cfg)},
-	{IWL_PCI_DEVICE(0x0082, 0x1304, iwl6005_2agn_mow1_cfg)},/* low 5GHz active */
-	{IWL_PCI_DEVICE(0x0082, 0x1305, iwl6005_2agn_mow2_cfg)},/* high 5GHz active */
+	{IWL_PCI_DEVICE(0x0082, 0x1301, iwl6005_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0082, 0x1306, iwl6005_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0082, 0x1307, iwl6005_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0082, 0x1308, iwl6005_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0082, 0x1321, iwl6005_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0082, 0x1326, iwl6005_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0082, 0x1328, iwl6005_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0085, 0x1311, iwl6005_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0085, 0x1318, iwl6005_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0085, 0x1316, iwl6005_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0082, 0xC020, iwl6005_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0085, 0xC220, iwl6005_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0085, 0xC228, iwl6005_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0082, 0x4820, iwl6005_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0082, 0x1304, iwl6005_trans_cfg)},/* low 5GHz active */
+	{IWL_PCI_DEVICE(0x0082, 0x1305, iwl6005_trans_cfg)},/* high 5GHz active */
 
 /* 6x30 Series */
-	{IWL_PCI_DEVICE(0x008A, 0x5305, iwl1030_bgn_cfg)},
-	{IWL_PCI_DEVICE(0x008A, 0x5307, iwl1030_bg_cfg)},
-	{IWL_PCI_DEVICE(0x008A, 0x5325, iwl1030_bgn_cfg)},
-	{IWL_PCI_DEVICE(0x008A, 0x5327, iwl1030_bg_cfg)},
-	{IWL_PCI_DEVICE(0x008B, 0x5315, iwl1030_bgn_cfg)},
-	{IWL_PCI_DEVICE(0x008B, 0x5317, iwl1030_bg_cfg)},
-	{IWL_PCI_DEVICE(0x0090, 0x5211, iwl6030_2agn_cfg)},
-	{IWL_PCI_DEVICE(0x0090, 0x5215, iwl6030_2bgn_cfg)},
-	{IWL_PCI_DEVICE(0x0090, 0x5216, iwl6030_2abg_cfg)},
-	{IWL_PCI_DEVICE(0x0091, 0x5201, iwl6030_2agn_cfg)},
-	{IWL_PCI_DEVICE(0x0091, 0x5205, iwl6030_2bgn_cfg)},
-	{IWL_PCI_DEVICE(0x0091, 0x5206, iwl6030_2abg_cfg)},
-	{IWL_PCI_DEVICE(0x0091, 0x5207, iwl6030_2bg_cfg)},
-	{IWL_PCI_DEVICE(0x0091, 0x5221, iwl6030_2agn_cfg)},
-	{IWL_PCI_DEVICE(0x0091, 0x5225, iwl6030_2bgn_cfg)},
-	{IWL_PCI_DEVICE(0x0091, 0x5226, iwl6030_2abg_cfg)},
+	{IWL_PCI_DEVICE(0x008A, 0x5305, iwl1000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x008A, 0x5307, iwl1000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x008A, 0x5325, iwl1000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x008A, 0x5327, iwl1000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x008B, 0x5315, iwl1000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x008B, 0x5317, iwl1000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0090, 0x5211, iwl6030_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0090, 0x5215, iwl6030_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0090, 0x5216, iwl6030_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0091, 0x5201, iwl6030_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0091, 0x5205, iwl6030_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0091, 0x5206, iwl6030_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0091, 0x5207, iwl6030_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0091, 0x5221, iwl6030_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0091, 0x5225, iwl6030_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0091, 0x5226, iwl6030_trans_cfg)},
 
 /* 6x50 WiFi/WiMax Series */
-	{IWL_PCI_DEVICE(0x0087, 0x1301, iwl6050_2agn_cfg)},
-	{IWL_PCI_DEVICE(0x0087, 0x1306, iwl6050_2abg_cfg)},
-	{IWL_PCI_DEVICE(0x0087, 0x1321, iwl6050_2agn_cfg)},
-	{IWL_PCI_DEVICE(0x0087, 0x1326, iwl6050_2abg_cfg)},
-	{IWL_PCI_DEVICE(0x0089, 0x1311, iwl6050_2agn_cfg)},
-	{IWL_PCI_DEVICE(0x0089, 0x1316, iwl6050_2abg_cfg)},
+	{IWL_PCI_DEVICE(0x0087, 0x1301, iwl6050_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0087, 0x1306, iwl6050_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0087, 0x1321, iwl6050_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0087, 0x1326, iwl6050_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0089, 0x1311, iwl6050_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0089, 0x1316, iwl6050_trans_cfg)},
 
 /* 6150 WiFi/WiMax Series */
-	{IWL_PCI_DEVICE(0x0885, 0x1305, iwl6150_bgn_cfg)},
-	{IWL_PCI_DEVICE(0x0885, 0x1307, iwl6150_bg_cfg)},
-	{IWL_PCI_DEVICE(0x0885, 0x1325, iwl6150_bgn_cfg)},
-	{IWL_PCI_DEVICE(0x0885, 0x1327, iwl6150_bg_cfg)},
-	{IWL_PCI_DEVICE(0x0886, 0x1315, iwl6150_bgn_cfg)},
-	{IWL_PCI_DEVICE(0x0886, 0x1317, iwl6150_bg_cfg)},
+	{IWL_PCI_DEVICE(0x0885, 0x1305, iwl6150_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0885, 0x1307, iwl6150_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0885, 0x1325, iwl6150_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0885, 0x1327, iwl6150_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0886, 0x1315, iwl6150_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0886, 0x1317, iwl6150_trans_cfg)},
 
 /* 1000 Series WiFi */
-	{IWL_PCI_DEVICE(0x0083, 0x1205, iwl1000_bgn_cfg)},
-	{IWL_PCI_DEVICE(0x0083, 0x1305, iwl1000_bgn_cfg)},
-	{IWL_PCI_DEVICE(0x0083, 0x1225, iwl1000_bgn_cfg)},
-	{IWL_PCI_DEVICE(0x0083, 0x1325, iwl1000_bgn_cfg)},
-	{IWL_PCI_DEVICE(0x0084, 0x1215, iwl1000_bgn_cfg)},
-	{IWL_PCI_DEVICE(0x0084, 0x1315, iwl1000_bgn_cfg)},
-	{IWL_PCI_DEVICE(0x0083, 0x1206, iwl1000_bg_cfg)},
-	{IWL_PCI_DEVICE(0x0083, 0x1306, iwl1000_bg_cfg)},
-	{IWL_PCI_DEVICE(0x0083, 0x1226, iwl1000_bg_cfg)},
-	{IWL_PCI_DEVICE(0x0083, 0x1326, iwl1000_bg_cfg)},
-	{IWL_PCI_DEVICE(0x0084, 0x1216, iwl1000_bg_cfg)},
-	{IWL_PCI_DEVICE(0x0084, 0x1316, iwl1000_bg_cfg)},
+	{IWL_PCI_DEVICE(0x0083, 0x1205, iwl1000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0083, 0x1305, iwl1000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0083, 0x1225, iwl1000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0083, 0x1325, iwl1000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0084, 0x1215, iwl1000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0084, 0x1315, iwl1000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0083, 0x1206, iwl1000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0083, 0x1306, iwl1000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0083, 0x1226, iwl1000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0083, 0x1326, iwl1000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0084, 0x1216, iwl1000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0084, 0x1316, iwl1000_trans_cfg)},
 
 /* 100 Series WiFi */
-	{IWL_PCI_DEVICE(0x08AE, 0x1005, iwl100_bgn_cfg)},
-	{IWL_PCI_DEVICE(0x08AE, 0x1007, iwl100_bg_cfg)},
-	{IWL_PCI_DEVICE(0x08AF, 0x1015, iwl100_bgn_cfg)},
-	{IWL_PCI_DEVICE(0x08AF, 0x1017, iwl100_bg_cfg)},
-	{IWL_PCI_DEVICE(0x08AE, 0x1025, iwl100_bgn_cfg)},
-	{IWL_PCI_DEVICE(0x08AE, 0x1027, iwl100_bg_cfg)},
+	{IWL_PCI_DEVICE(0x08AE, 0x1005, iwl1000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08AE, 0x1007, iwl1000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08AF, 0x1015, iwl1000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08AF, 0x1017, iwl1000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08AE, 0x1025, iwl1000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08AE, 0x1027, iwl1000_trans_cfg)},
 
 /* 130 Series WiFi */
-	{IWL_PCI_DEVICE(0x0896, 0x5005, iwl130_bgn_cfg)},
-	{IWL_PCI_DEVICE(0x0896, 0x5007, iwl130_bg_cfg)},
-	{IWL_PCI_DEVICE(0x0897, 0x5015, iwl130_bgn_cfg)},
-	{IWL_PCI_DEVICE(0x0897, 0x5017, iwl130_bg_cfg)},
-	{IWL_PCI_DEVICE(0x0896, 0x5025, iwl130_bgn_cfg)},
-	{IWL_PCI_DEVICE(0x0896, 0x5027, iwl130_bg_cfg)},
+	{IWL_PCI_DEVICE(0x0896, 0x5005, iwl1000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0896, 0x5007, iwl1000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0897, 0x5015, iwl1000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0897, 0x5017, iwl1000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0896, 0x5025, iwl1000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0896, 0x5027, iwl1000_trans_cfg)},
 
 /* 2x00 Series */
-	{IWL_PCI_DEVICE(0x0890, 0x4022, iwl2000_2bgn_cfg)},
-	{IWL_PCI_DEVICE(0x0891, 0x4222, iwl2000_2bgn_cfg)},
-	{IWL_PCI_DEVICE(0x0890, 0x4422, iwl2000_2bgn_cfg)},
-	{IWL_PCI_DEVICE(0x0890, 0x4822, iwl2000_2bgn_d_cfg)},
+	{IWL_PCI_DEVICE(0x0890, 0x4022, iwl2000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0891, 0x4222, iwl2000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0890, 0x4422, iwl2000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0890, 0x4822, iwl2000_trans_cfg)},
 
 /* 2x30 Series */
-	{IWL_PCI_DEVICE(0x0887, 0x4062, iwl2030_2bgn_cfg)},
-	{IWL_PCI_DEVICE(0x0888, 0x4262, iwl2030_2bgn_cfg)},
-	{IWL_PCI_DEVICE(0x0887, 0x4462, iwl2030_2bgn_cfg)},
+	{IWL_PCI_DEVICE(0x0887, 0x4062, iwl2030_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0888, 0x4262, iwl2030_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0887, 0x4462, iwl2030_trans_cfg)},
 
 /* 6x35 Series */
-	{IWL_PCI_DEVICE(0x088E, 0x4060, iwl6035_2agn_cfg)},
-	{IWL_PCI_DEVICE(0x088E, 0x406A, iwl6035_2agn_sff_cfg)},
-	{IWL_PCI_DEVICE(0x088F, 0x4260, iwl6035_2agn_cfg)},
-	{IWL_PCI_DEVICE(0x088F, 0x426A, iwl6035_2agn_sff_cfg)},
-	{IWL_PCI_DEVICE(0x088E, 0x4460, iwl6035_2agn_cfg)},
-	{IWL_PCI_DEVICE(0x088E, 0x446A, iwl6035_2agn_sff_cfg)},
-	{IWL_PCI_DEVICE(0x088E, 0x4860, iwl6035_2agn_cfg)},
-	{IWL_PCI_DEVICE(0x088F, 0x5260, iwl6035_2agn_cfg)},
+	{IWL_PCI_DEVICE(0x088E, 0x4060, iwl6030_trans_cfg)},
+	{IWL_PCI_DEVICE(0x088E, 0x406A, iwl6030_trans_cfg)},
+	{IWL_PCI_DEVICE(0x088F, 0x4260, iwl6030_trans_cfg)},
+	{IWL_PCI_DEVICE(0x088F, 0x426A, iwl6030_trans_cfg)},
+	{IWL_PCI_DEVICE(0x088E, 0x4460, iwl6030_trans_cfg)},
+	{IWL_PCI_DEVICE(0x088E, 0x446A, iwl6030_trans_cfg)},
+	{IWL_PCI_DEVICE(0x088E, 0x4860, iwl6030_trans_cfg)},
+	{IWL_PCI_DEVICE(0x088F, 0x5260, iwl6030_trans_cfg)},
 
 /* 105 Series */
-	{IWL_PCI_DEVICE(0x0894, 0x0022, iwl105_bgn_cfg)},
-	{IWL_PCI_DEVICE(0x0895, 0x0222, iwl105_bgn_cfg)},
-	{IWL_PCI_DEVICE(0x0894, 0x0422, iwl105_bgn_cfg)},
-	{IWL_PCI_DEVICE(0x0894, 0x0822, iwl105_bgn_d_cfg)},
+	{IWL_PCI_DEVICE(0x0894, 0x0022, iwl105_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0895, 0x0222, iwl105_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0894, 0x0422, iwl105_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0894, 0x0822, iwl105_trans_cfg)},
 
 /* 135 Series */
-	{IWL_PCI_DEVICE(0x0892, 0x0062, iwl135_bgn_cfg)},
-	{IWL_PCI_DEVICE(0x0893, 0x0262, iwl135_bgn_cfg)},
-	{IWL_PCI_DEVICE(0x0892, 0x0462, iwl135_bgn_cfg)},
+	{IWL_PCI_DEVICE(0x0892, 0x0062, iwl135_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0893, 0x0262, iwl135_trans_cfg)},
+	{IWL_PCI_DEVICE(0x0892, 0x0462, iwl135_trans_cfg)},
 #endif /* CONFIG_IWLDVM */
 
 #if IS_ENABLED(CONFIG_IWLMVM)
 /* 7260 Series */
-	{IWL_PCI_DEVICE(0x08B1, 0x4070, iwl7260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4072, iwl7260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4170, iwl7260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4C60, iwl7260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4C70, iwl7260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4060, iwl7260_2n_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x406A, iwl7260_2n_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4160, iwl7260_2n_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4062, iwl7260_n_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4162, iwl7260_n_cfg)},
-	{IWL_PCI_DEVICE(0x08B2, 0x4270, iwl7260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B2, 0x4272, iwl7260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B2, 0x4260, iwl7260_2n_cfg)},
-	{IWL_PCI_DEVICE(0x08B2, 0x426A, iwl7260_2n_cfg)},
-	{IWL_PCI_DEVICE(0x08B2, 0x4262, iwl7260_n_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4470, iwl7260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4472, iwl7260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4460, iwl7260_2n_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x446A, iwl7260_2n_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4462, iwl7260_n_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4870, iwl7260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x486E, iwl7260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4A70, iwl7260_2ac_cfg_high_temp)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4A6E, iwl7260_2ac_cfg_high_temp)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4A6C, iwl7260_2ac_cfg_high_temp)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4570, iwl7260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4560, iwl7260_2n_cfg)},
-	{IWL_PCI_DEVICE(0x08B2, 0x4370, iwl7260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B2, 0x4360, iwl7260_2n_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x5070, iwl7260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x5072, iwl7260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x5170, iwl7260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x5770, iwl7260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4020, iwl7260_2n_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x402A, iwl7260_2n_cfg)},
-	{IWL_PCI_DEVICE(0x08B2, 0x4220, iwl7260_2n_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0x4420, iwl7260_2n_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC070, iwl7260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC072, iwl7260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC170, iwl7260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC060, iwl7260_2n_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC06A, iwl7260_2n_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC160, iwl7260_2n_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC062, iwl7260_n_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC162, iwl7260_n_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC770, iwl7260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC760, iwl7260_2n_cfg)},
-	{IWL_PCI_DEVICE(0x08B2, 0xC270, iwl7260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xCC70, iwl7260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xCC60, iwl7260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B2, 0xC272, iwl7260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B2, 0xC260, iwl7260_2n_cfg)},
-	{IWL_PCI_DEVICE(0x08B2, 0xC26A, iwl7260_n_cfg)},
-	{IWL_PCI_DEVICE(0x08B2, 0xC262, iwl7260_n_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC470, iwl7260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC472, iwl7260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC460, iwl7260_2n_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC462, iwl7260_n_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC570, iwl7260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC560, iwl7260_2n_cfg)},
-	{IWL_PCI_DEVICE(0x08B2, 0xC370, iwl7260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC360, iwl7260_2n_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC020, iwl7260_2n_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC02A, iwl7260_2n_cfg)},
-	{IWL_PCI_DEVICE(0x08B2, 0xC220, iwl7260_2n_cfg)},
-	{IWL_PCI_DEVICE(0x08B1, 0xC420, iwl7260_2n_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4070, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4072, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4170, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4C60, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4C70, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4060, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x406A, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4160, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4062, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4162, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B2, 0x4270, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B2, 0x4272, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B2, 0x4260, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B2, 0x426A, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B2, 0x4262, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4470, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4472, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4460, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x446A, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4462, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4870, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x486E, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4A70, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4A6E, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4A6C, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4570, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4560, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B2, 0x4370, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B2, 0x4360, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x5070, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x5072, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x5170, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x5770, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4020, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x402A, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B2, 0x4220, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0x4420, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC070, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC072, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC170, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC060, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC06A, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC160, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC062, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC162, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC770, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC760, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B2, 0xC270, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xCC70, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xCC60, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B2, 0xC272, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B2, 0xC260, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B2, 0xC26A, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B2, 0xC262, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC470, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC472, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC460, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC462, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC570, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC560, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B2, 0xC370, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC360, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC020, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC02A, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B2, 0xC220, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B1, 0xC420, iwl7000_trans_cfg)},
 
 /* 3160 Series */
-	{IWL_PCI_DEVICE(0x08B3, 0x0070, iwl3160_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x0072, iwl3160_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x0170, iwl3160_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x0172, iwl3160_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x0060, iwl3160_2n_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x0062, iwl3160_n_cfg)},
-	{IWL_PCI_DEVICE(0x08B4, 0x0270, iwl3160_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B4, 0x0272, iwl3160_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x0470, iwl3160_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x0472, iwl3160_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B4, 0x0370, iwl3160_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x8070, iwl3160_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x8072, iwl3160_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x8170, iwl3160_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x8172, iwl3160_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x8060, iwl3160_2n_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x8062, iwl3160_n_cfg)},
-	{IWL_PCI_DEVICE(0x08B4, 0x8270, iwl3160_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B4, 0x8370, iwl3160_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B4, 0x8272, iwl3160_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x8470, iwl3160_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x8570, iwl3160_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x1070, iwl3160_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x08B3, 0x1170, iwl3160_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x0070, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x0072, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x0170, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x0172, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x0060, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x0062, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B4, 0x0270, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B4, 0x0272, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x0470, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x0472, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B4, 0x0370, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x8070, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x8072, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x8170, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x8172, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x8060, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x8062, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B4, 0x8270, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B4, 0x8370, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B4, 0x8272, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x8470, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x8570, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x1070, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x08B3, 0x1170, iwl7000_trans_cfg)},
 
 /* 3165 Series */
-	{IWL_PCI_DEVICE(0x3165, 0x4010, iwl3165_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x3165, 0x4012, iwl3165_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x3166, 0x4212, iwl3165_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x3165, 0x4410, iwl3165_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x3165, 0x4510, iwl3165_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x3165, 0x4110, iwl3165_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x3166, 0x4310, iwl3165_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x3166, 0x4210, iwl3165_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x3165, 0x8010, iwl3165_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x3165, 0x8110, iwl3165_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x3165, 0x4010, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x3165, 0x4012, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x3166, 0x4212, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x3165, 0x4410, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x3165, 0x4510, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x3165, 0x4110, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x3166, 0x4310, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x3166, 0x4210, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x3165, 0x8010, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x3165, 0x8110, iwl7000_trans_cfg)},
 
 /* 3168 Series */
-	{IWL_PCI_DEVICE(0x24FB, 0x2010, iwl3168_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FB, 0x2110, iwl3168_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FB, 0x2050, iwl3168_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FB, 0x2150, iwl3168_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FB, 0x0000, iwl3168_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x24FB, 0x2010, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FB, 0x2110, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FB, 0x2050, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FB, 0x2150, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FB, 0x0000, iwl7000_trans_cfg)},
 
 /* 7265 Series */
-	{IWL_PCI_DEVICE(0x095A, 0x5010, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5110, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5100, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095B, 0x5310, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095B, 0x5302, iwl7265_n_cfg)},
-	{IWL_PCI_DEVICE(0x095B, 0x5210, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5C10, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5012, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5412, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5410, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5510, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5400, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x1010, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5000, iwl7265_2n_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x500A, iwl7265_2n_cfg)},
-	{IWL_PCI_DEVICE(0x095B, 0x5200, iwl7265_2n_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5002, iwl7265_n_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5102, iwl7265_n_cfg)},
-	{IWL_PCI_DEVICE(0x095B, 0x5202, iwl7265_n_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x9010, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x9012, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x900A, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x9110, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x9112, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095B, 0x9210, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095B, 0x9200, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x9510, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095B, 0x9310, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x9410, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5020, iwl7265_2n_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x502A, iwl7265_2n_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5420, iwl7265_2n_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5090, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5190, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5590, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095B, 0x5290, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5490, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x5F10, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095B, 0x5212, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095B, 0x520A, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x9000, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x9400, iwl7265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x095A, 0x9E10, iwl7265_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5010, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5110, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5100, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095B, 0x5310, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095B, 0x5302, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095B, 0x5210, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5C10, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5012, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5412, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5410, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5510, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5400, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x1010, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5000, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x500A, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095B, 0x5200, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5002, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5102, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095B, 0x5202, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x9010, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x9012, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x900A, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x9110, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x9112, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095B, 0x9210, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095B, 0x9200, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x9510, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095B, 0x9310, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x9410, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5020, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x502A, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5420, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5090, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5190, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5590, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095B, 0x5290, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5490, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x5F10, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095B, 0x5212, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095B, 0x520A, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x9000, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x9400, iwl7000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x095A, 0x9E10, iwl7000_trans_cfg)},
 
 /* 8000 Series */
-	{IWL_PCI_DEVICE(0x24F3, 0x0010, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x1010, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x10B0, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x0130, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x1130, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x0132, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x1132, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x0110, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x01F0, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x0012, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x1012, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x1110, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x0050, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x0250, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x1050, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x0150, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x1150, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F4, 0x0030, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F4, 0x1030, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0xC010, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0xC110, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0xD010, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0xC050, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0xD050, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0xD0B0, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0xB0B0, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x8010, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x8110, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x9010, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x9110, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F4, 0x8030, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F4, 0x9030, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F4, 0xC030, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F4, 0xD030, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x8130, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x9130, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x8132, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x9132, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x8050, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x8150, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x9050, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x9150, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x0004, iwl8260_2n_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x0044, iwl8260_2n_cfg)},
-	{IWL_PCI_DEVICE(0x24F5, 0x0010, iwl4165_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F6, 0x0030, iwl4165_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x0810, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x0910, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x0850, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x0950, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x0930, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x0000, iwl8265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24F3, 0x4010, iwl8260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x0010, iwl8265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x0110, iwl8265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x1110, iwl8265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x1130, iwl8265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x0130, iwl8265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x1010, iwl8265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x10D0, iwl8265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x0050, iwl8265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x0150, iwl8265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x9010, iwl8265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x8110, iwl8265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x8050, iwl8265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x8010, iwl8265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x0810, iwl8265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x9110, iwl8265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x8130, iwl8265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x0910, iwl8265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x0930, iwl8265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x0950, iwl8265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x0850, iwl8265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x1014, iwl8265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x3E02, iwl8275_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x3E01, iwl8275_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x1012, iwl8275_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x0012, iwl8275_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x0014, iwl8265_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x24FD, 0x9074, iwl8265_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0010, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x1010, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x10B0, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0130, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x1130, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0132, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x1132, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0110, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x01F0, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0012, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x1012, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x1110, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0050, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0250, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x1050, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0150, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x1150, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F4, 0x0030, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F4, 0x1030, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0xC010, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0xC110, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0xD010, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0xC050, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0xD050, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0xD0B0, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0xB0B0, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x8010, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x8110, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x9010, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x9110, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F4, 0x8030, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F4, 0x9030, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F4, 0xC030, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F4, 0xD030, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x8130, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x9130, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x8132, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x9132, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x8050, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x8150, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x9050, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x9150, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0004, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0044, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F5, 0x0010, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F6, 0x0030, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0810, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0910, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0850, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0950, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0930, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x0000, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0x4010, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x0010, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x0110, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x1110, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x1130, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x0130, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x1010, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x10D0, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x0050, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x0150, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x9010, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x8110, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x8050, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x8010, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x0810, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x9110, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x8130, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x0910, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x0930, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x0950, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x0850, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x1014, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x3E02, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x3E01, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x1012, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x0012, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x0014, iwl8000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x9074, iwl8000_trans_cfg)},
 
 /* 9000 Series */
 	{IWL_PCI_DEVICE(0x2526, PCI_ANY_ID, iwl9000_trans_cfg)},
@@ -583,7 +582,816 @@ EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_hw_card_ids);
 #define BW_LIMITED	.bw_limit = 1
 
 VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
+#if IS_ENABLED(CONFIG_IWLDVM)
+	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_agn_name,
+		     DEVICE(0x4232), SUBDEV(0x1201)), /* Mini Card */
+	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_agn_name,
+		     DEVICE(0x4232), SUBDEV(0x1301)), /* Half Mini Card */
+	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_agn_name,
+		     DEVICE(0x4232), SUBDEV(0x1204)), /* Mini Card */
+	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_agn_name,
+		     DEVICE(0x4232), SUBDEV(0x1304)), /* Half Mini Card */
+	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_bgn_name,
+		     DEVICE(0x4232), SUBDEV(0x1205)), /* Mini Card */
+	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_bgn_name,
+		     DEVICE(0x4232), SUBDEV(0x1305)), /* Half Mini Card */
+	IWL_DEV_INFO(iwl5100_abg_cfg, iwl5100_abg_name,
+		     DEVICE(0x4232), SUBDEV(0x1206)), /* Mini Card */
+	IWL_DEV_INFO(iwl5100_abg_cfg, iwl5100_abg_name,
+		     DEVICE(0x4232), SUBDEV(0x1306)), /* Half Mini Card */
+	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_agn_name,
+		     DEVICE(0x4232), SUBDEV(0x1221)), /* Mini Card */
+	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_agn_name,
+		     DEVICE(0x4232), SUBDEV(0x1321)), /* Half Mini Card */
+	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_agn_name,
+		     DEVICE(0x4232), SUBDEV(0x1224)), /* Mini Card */
+	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_agn_name,
+		     DEVICE(0x4232), SUBDEV(0x1324)), /* Half Mini Card */
+	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_bgn_name,
+		     DEVICE(0x4232), SUBDEV(0x1225)), /* Mini Card */
+	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_bgn_name,
+		     DEVICE(0x4232), SUBDEV(0x1325)), /* Half Mini Card */
+	IWL_DEV_INFO(iwl5100_abg_cfg, iwl5100_abg_name,
+		     DEVICE(0x4232), SUBDEV(0x1226)), /* Mini Card */
+	IWL_DEV_INFO(iwl5100_abg_cfg, iwl5100_abg_name,
+		     DEVICE(0x4232), SUBDEV(0x1326)), /* Half Mini Card */
+	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_agn_name,
+		     DEVICE(0x4237), SUBDEV(0x1211)), /* Mini Card */
+	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_agn_name,
+		     DEVICE(0x4237), SUBDEV(0x1311)), /* Half Mini Card */
+	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_agn_name,
+		     DEVICE(0x4237), SUBDEV(0x1214)), /* Mini Card */
+	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_agn_name,
+		     DEVICE(0x4237), SUBDEV(0x1314)), /* Half Mini Card */
+	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_bgn_name,
+		     DEVICE(0x4237), SUBDEV(0x1215)), /* Mini Card */
+	IWL_DEV_INFO(iwl5100_n_cfg, iwl5100_bgn_name,
+		     DEVICE(0x4237), SUBDEV(0x1315)), /* Half Mini Card */
+	IWL_DEV_INFO(iwl5100_abg_cfg, iwl5100_abg_name,
+		     DEVICE(0x4237), SUBDEV(0x1216)), /* Mini Card */
+	IWL_DEV_INFO(iwl5100_abg_cfg, iwl5100_abg_name,
+		     DEVICE(0x4237), SUBDEV(0x1316)), /* Half Mini Card */
+
+/* 5300 Series WiFi */
+	IWL_DEV_INFO(iwl5300_agn_cfg, iwl5300_agn_name,
+		     DEVICE(0x4235), SUBDEV(0x1021)), /* Mini Card */
+	IWL_DEV_INFO(iwl5300_agn_cfg, iwl5300_agn_name,
+		     DEVICE(0x4235), SUBDEV(0x1121)), /* Half Mini Card */
+	IWL_DEV_INFO(iwl5300_agn_cfg, iwl5300_agn_name,
+		     DEVICE(0x4235), SUBDEV(0x1024)), /* Mini Card */
+	IWL_DEV_INFO(iwl5300_agn_cfg, iwl5300_agn_name,
+		     DEVICE(0x4235), SUBDEV(0x1124)), /* Half Mini Card */
+	IWL_DEV_INFO(iwl5300_agn_cfg, iwl5300_agn_name,
+		     DEVICE(0x4235), SUBDEV(0x1001)), /* Mini Card */
+	IWL_DEV_INFO(iwl5300_agn_cfg, iwl5300_agn_name,
+		     DEVICE(0x4235), SUBDEV(0x1101)), /* Half Mini Card */
+	IWL_DEV_INFO(iwl5300_agn_cfg, iwl5300_agn_name,
+		     DEVICE(0x4235), SUBDEV(0x1004)), /* Mini Card */
+	IWL_DEV_INFO(iwl5300_agn_cfg, iwl5300_agn_name,
+		     DEVICE(0x4235), SUBDEV(0x1104)), /* Half Mini Card */
+	IWL_DEV_INFO(iwl5300_agn_cfg, iwl5300_agn_name,
+		     DEVICE(0x4236), SUBDEV(0x1011)), /* Mini Card */
+	IWL_DEV_INFO(iwl5300_agn_cfg, iwl5300_agn_name,
+		     DEVICE(0x4236), SUBDEV(0x1111)), /* Half Mini Card */
+	IWL_DEV_INFO(iwl5300_agn_cfg, iwl5300_agn_name,
+		     DEVICE(0x4236), SUBDEV(0x1014)), /* Mini Card */
+	IWL_DEV_INFO(iwl5300_agn_cfg, iwl5300_agn_name,
+		     DEVICE(0x4236), SUBDEV(0x1114)), /* Half Mini Card */
+
+/* 5350 Series WiFi/WiMax */
+	IWL_DEV_INFO(iwl5350_agn_cfg, iwl5350_agn_name,
+		     DEVICE(0x423A), SUBDEV(0x1001)), /* Mini Card */
+	IWL_DEV_INFO(iwl5350_agn_cfg, iwl5350_agn_name,
+		     DEVICE(0x423A), SUBDEV(0x1021)), /* Mini Card */
+	IWL_DEV_INFO(iwl5350_agn_cfg, iwl5350_agn_name,
+		     DEVICE(0x423B), SUBDEV(0x1011)), /* Mini Card */
+
+/* 5150 Series Wifi/WiMax */
+	IWL_DEV_INFO(iwl5150_agn_cfg, iwl5150_agn_name,
+		     DEVICE(0x423C), SUBDEV(0x1201)), /* Mini Card */
+	IWL_DEV_INFO(iwl5150_agn_cfg, iwl5150_agn_name,
+		     DEVICE(0x423C), SUBDEV(0x1301)), /* Half Mini Card */
+	IWL_DEV_INFO(iwl5150_abg_cfg, iwl5150_abg_name,
+		     DEVICE(0x423C), SUBDEV(0x1206)), /* Mini Card */
+	IWL_DEV_INFO(iwl5150_abg_cfg, iwl5150_abg_name,
+		     DEVICE(0x423C), SUBDEV(0x1306)), /* Half Mini Card */
+	IWL_DEV_INFO(iwl5150_agn_cfg, iwl5150_agn_name,
+		     DEVICE(0x423C), SUBDEV(0x1221)), /* Mini Card */
+	IWL_DEV_INFO(iwl5150_agn_cfg, iwl5150_agn_name,
+		     DEVICE(0x423C), SUBDEV(0x1321)), /* Half Mini Card */
+	IWL_DEV_INFO(iwl5150_abg_cfg, iwl5150_abg_name,
+		     DEVICE(0x423C), SUBDEV(0x1326)), /* Half Mini Card */
+
+	IWL_DEV_INFO(iwl5150_agn_cfg, iwl5150_agn_name,
+		     DEVICE(0x423D), SUBDEV(0x1211)), /* Mini Card */
+	IWL_DEV_INFO(iwl5150_agn_cfg, iwl5150_agn_name,
+		     DEVICE(0x423D), SUBDEV(0x1311)), /* Half Mini Card */
+	IWL_DEV_INFO(iwl5150_abg_cfg, iwl5150_abg_name,
+		     DEVICE(0x423D), SUBDEV(0x1216)), /* Mini Card */
+	IWL_DEV_INFO(iwl5150_abg_cfg, iwl5150_abg_name,
+		     DEVICE(0x423D), SUBDEV(0x1316)), /* Half Mini Card */
+
+/* 6x00 Series */
+	IWL_DEV_INFO(iwl6000_3agn_cfg, iwl6000_3agn_name,
+		     DEVICE(0x422B), SUBDEV(0x1101)),
+	IWL_DEV_INFO(iwl6000_3agn_cfg, iwl6000_3agn_name,
+		     DEVICE(0x422B), SUBDEV(0x1108)),
+	IWL_DEV_INFO(iwl6000_3agn_cfg, iwl6000_3agn_name,
+		     DEVICE(0x422B), SUBDEV(0x1121)),
+	IWL_DEV_INFO(iwl6000_3agn_cfg, iwl6000_3agn_name,
+		     DEVICE(0x422B), SUBDEV(0x1128)),
+	IWL_DEV_INFO(iwl6000i_2agn_cfg, iwl6000i_2agn_name,
+		     DEVICE(0x422C), SUBDEV(0x1301)),
+	IWL_DEV_INFO(iwl6000i_non_n_cfg, iwl6000i_2abg_name,
+		     DEVICE(0x422C), SUBDEV(0x1306)),
+	IWL_DEV_INFO(iwl6000i_non_n_cfg, iwl6000i_2bg_name,
+		     DEVICE(0x422C), SUBDEV(0x1307)),
+	IWL_DEV_INFO(iwl6000i_2agn_cfg, iwl6000i_2agn_name,
+		     DEVICE(0x422C), SUBDEV(0x1321)),
+	IWL_DEV_INFO(iwl6000i_non_n_cfg, iwl6000i_2abg_name,
+		     DEVICE(0x422C), SUBDEV(0x1326)),
+	IWL_DEV_INFO(iwl6000_3agn_cfg, iwl6000_3agn_name,
+		     DEVICE(0x4238), SUBDEV(0x1111)),
+	IWL_DEV_INFO(iwl6000_3agn_cfg, iwl6000_3agn_name,
+		     DEVICE(0x4238), SUBDEV(0x1118)),
+	IWL_DEV_INFO(iwl6000i_2agn_cfg, iwl6000i_2agn_name,
+		     DEVICE(0x4239), SUBDEV(0x1311)),
+	IWL_DEV_INFO(iwl6000i_non_n_cfg, iwl6000i_2abg_name,
+		     DEVICE(0x4239), SUBDEV(0x1316)),
+
+/* 6x05 Series */
+	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_name,
+		     DEVICE(0x0082), SUBDEV(0x1301)),
+	IWL_DEV_INFO(iwl6005_non_n_cfg, iwl6005_2abg_name,
+		     DEVICE(0x0082), SUBDEV(0x1306)),
+	IWL_DEV_INFO(iwl6005_non_n_cfg, iwl6005_2bg_name,
+		     DEVICE(0x0082), SUBDEV(0x1307)),
+	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_name,
+		     DEVICE(0x0082), SUBDEV(0x1308)),
+	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_name,
+		     DEVICE(0x0082), SUBDEV(0x1321)),
+	IWL_DEV_INFO(iwl6005_non_n_cfg, iwl6005_2abg_name,
+		     DEVICE(0x0082), SUBDEV(0x1326)),
+	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_name,
+		     DEVICE(0x0082), SUBDEV(0x1328)),
+	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_name,
+		     DEVICE(0x0085), SUBDEV(0x1311)),
+	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_name,
+		     DEVICE(0x0085), SUBDEV(0x1318)),
+	IWL_DEV_INFO(iwl6005_non_n_cfg, iwl6005_2abg_name,
+		     DEVICE(0x0085), SUBDEV(0x1316)),
+	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_sff_name,
+		     DEVICE(0x0082), SUBDEV(0xC020)),
+	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_sff_name,
+		     DEVICE(0x0085), SUBDEV(0xC220)),
+	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_sff_name,
+		     DEVICE(0x0085), SUBDEV(0xC228)),
+	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_d_name,
+		     DEVICE(0x0082), SUBDEV(0x4820)),
+	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_mow1_name,
+		     DEVICE(0x0082), SUBDEV(0x1304)),/* low 5GHz active */
+	IWL_DEV_INFO(iwl6005_n_cfg, iwl6005_2agn_mow2_name,
+		     DEVICE(0x0082), SUBDEV(0x1305)),/* high 5GHz active */
+
+/* 6x30 Series */
+	IWL_DEV_INFO(iwl6030_n_cfg, iwl1030_bgn_name,
+		     DEVICE(0x008A), SUBDEV(0x5305)),
+	IWL_DEV_INFO(iwl6030_non_n_cfg, iwl1030_bg_name,
+		     DEVICE(0x008A), SUBDEV(0x5307)),
+	IWL_DEV_INFO(iwl6030_n_cfg, iwl1030_bgn_name,
+		     DEVICE(0x008A), SUBDEV(0x5325)),
+	IWL_DEV_INFO(iwl6030_non_n_cfg, iwl1030_bg_name,
+		     DEVICE(0x008A), SUBDEV(0x5327)),
+	IWL_DEV_INFO(iwl6030_n_cfg, iwl1030_bgn_name,
+		     DEVICE(0x008B), SUBDEV(0x5315)),
+	IWL_DEV_INFO(iwl6030_non_n_cfg, iwl1030_bg_name,
+		     DEVICE(0x008B), SUBDEV(0x5317)),
+	IWL_DEV_INFO(iwl6030_n_cfg, iwl6030_2agn_name,
+		     DEVICE(0x0090), SUBDEV(0x5211)),
+	IWL_DEV_INFO(iwl6030_n_cfg, iwl6030_2bgn_name,
+		     DEVICE(0x0090), SUBDEV(0x5215)),
+	IWL_DEV_INFO(iwl6030_non_n_cfg, iwl6030_2abg_name,
+		     DEVICE(0x0090), SUBDEV(0x5216)),
+	IWL_DEV_INFO(iwl6030_n_cfg, iwl6030_2agn_name,
+		     DEVICE(0x0091), SUBDEV(0x5201)),
+	IWL_DEV_INFO(iwl6030_n_cfg, iwl6030_2bgn_name,
+		     DEVICE(0x0091), SUBDEV(0x5205)),
+	IWL_DEV_INFO(iwl6030_non_n_cfg, iwl6030_2abg_name,
+		     DEVICE(0x0091), SUBDEV(0x5206)),
+	IWL_DEV_INFO(iwl6030_non_n_cfg, iwl6030_2bg_name,
+		     DEVICE(0x0091), SUBDEV(0x5207)),
+	IWL_DEV_INFO(iwl6030_n_cfg, iwl6030_2agn_name,
+		     DEVICE(0x0091), SUBDEV(0x5221)),
+	IWL_DEV_INFO(iwl6030_n_cfg, iwl6030_2bgn_name,
+		     DEVICE(0x0091), SUBDEV(0x5225)),
+	IWL_DEV_INFO(iwl6030_non_n_cfg, iwl6030_2abg_name,
+		     DEVICE(0x0091), SUBDEV(0x5226)),
+
+/* 6x50 WiFi/WiMax Series */
+	IWL_DEV_INFO(iwl6050_2agn_cfg, iwl6050_2agn_name,
+		     DEVICE(0x0087), SUBDEV(0x1301)),
+	IWL_DEV_INFO(iwl6050_2abg_cfg, iwl6050_2abg_name,
+		     DEVICE(0x0087), SUBDEV(0x1306)),
+	IWL_DEV_INFO(iwl6050_2agn_cfg, iwl6050_2agn_name,
+		     DEVICE(0x0087), SUBDEV(0x1321)),
+	IWL_DEV_INFO(iwl6050_2abg_cfg, iwl6050_2abg_name,
+		     DEVICE(0x0087), SUBDEV(0x1326)),
+	IWL_DEV_INFO(iwl6050_2agn_cfg, iwl6050_2agn_name,
+		     DEVICE(0x0089), SUBDEV(0x1311)),
+	IWL_DEV_INFO(iwl6050_2abg_cfg, iwl6050_2abg_name,
+		     DEVICE(0x0089), SUBDEV(0x1316)),
+
+/* 6150 WiFi/WiMax Series */
+	IWL_DEV_INFO(iwl6150_bgn_cfg, iwl6150_bgn_name,
+		     DEVICE(0x0885), SUBDEV(0x1305)),
+	IWL_DEV_INFO(iwl6150_bg_cfg, iwl6150_bg_name,
+		     DEVICE(0x0885), SUBDEV(0x1307)),
+	IWL_DEV_INFO(iwl6150_bgn_cfg, iwl6150_bgn_name,
+		     DEVICE(0x0885), SUBDEV(0x1325)),
+	IWL_DEV_INFO(iwl6150_bg_cfg, iwl6150_bg_name,
+		     DEVICE(0x0885), SUBDEV(0x1327)),
+	IWL_DEV_INFO(iwl6150_bgn_cfg, iwl6150_bgn_name,
+		     DEVICE(0x0886), SUBDEV(0x1315)),
+	IWL_DEV_INFO(iwl6150_bg_cfg, iwl6150_bg_name,
+		     DEVICE(0x0886), SUBDEV(0x1317)),
+
+/* 1000 Series WiFi */
+	IWL_DEV_INFO(iwl1000_bgn_cfg, iwl1000_bgn_name,
+		     DEVICE(0x0083), SUBDEV(0x1205)),
+	IWL_DEV_INFO(iwl1000_bgn_cfg, iwl1000_bgn_name,
+		     DEVICE(0x0083), SUBDEV(0x1305)),
+	IWL_DEV_INFO(iwl1000_bgn_cfg, iwl1000_bgn_name,
+		     DEVICE(0x0083), SUBDEV(0x1225)),
+	IWL_DEV_INFO(iwl1000_bgn_cfg, iwl1000_bgn_name,
+		     DEVICE(0x0083), SUBDEV(0x1325)),
+	IWL_DEV_INFO(iwl1000_bgn_cfg, iwl1000_bgn_name,
+		     DEVICE(0x0084), SUBDEV(0x1215)),
+	IWL_DEV_INFO(iwl1000_bgn_cfg, iwl1000_bgn_name,
+		     DEVICE(0x0084), SUBDEV(0x1315)),
+	IWL_DEV_INFO(iwl1000_bg_cfg, iwl1000_bg_name,
+		     DEVICE(0x0083), SUBDEV(0x1206)),
+	IWL_DEV_INFO(iwl1000_bg_cfg, iwl1000_bg_name,
+		     DEVICE(0x0083), SUBDEV(0x1306)),
+	IWL_DEV_INFO(iwl1000_bg_cfg, iwl1000_bg_name,
+		     DEVICE(0x0083), SUBDEV(0x1226)),
+	IWL_DEV_INFO(iwl1000_bg_cfg, iwl1000_bg_name,
+		     DEVICE(0x0083), SUBDEV(0x1326)),
+	IWL_DEV_INFO(iwl1000_bg_cfg, iwl1000_bg_name,
+		     DEVICE(0x0084), SUBDEV(0x1216)),
+	IWL_DEV_INFO(iwl1000_bg_cfg, iwl1000_bg_name,
+		     DEVICE(0x0084), SUBDEV(0x1316)),
+
+/* 100 Series WiFi */
+	IWL_DEV_INFO(iwl100_bgn_cfg, iwl100_bgn_name,
+		     DEVICE(0x08AE), SUBDEV(0x1005)),
+	IWL_DEV_INFO(iwl100_bg_cfg, iwl100_bg_name,
+		     DEVICE(0x08AE), SUBDEV(0x1007)),
+	IWL_DEV_INFO(iwl100_bgn_cfg, iwl100_bgn_name,
+		     DEVICE(0x08AF), SUBDEV(0x1015)),
+	IWL_DEV_INFO(iwl100_bg_cfg, iwl100_bg_name,
+		     DEVICE(0x08AF), SUBDEV(0x1017)),
+	IWL_DEV_INFO(iwl100_bgn_cfg, iwl100_bgn_name,
+		     DEVICE(0x08AE), SUBDEV(0x1025)),
+	IWL_DEV_INFO(iwl100_bg_cfg, iwl100_bg_name,
+		     DEVICE(0x08AE), SUBDEV(0x1027)),
+
+/* 130 Series WiFi */
+	IWL_DEV_INFO(iwl130_bgn_cfg, iwl130_bgn_name,
+		     DEVICE(0x0896), SUBDEV(0x5005)),
+	IWL_DEV_INFO(iwl130_bg_cfg, iwl130_bg_name,
+		     DEVICE(0x0896), SUBDEV(0x5007)),
+	IWL_DEV_INFO(iwl130_bgn_cfg, iwl130_bgn_name,
+		     DEVICE(0x0897), SUBDEV(0x5015)),
+	IWL_DEV_INFO(iwl130_bg_cfg, iwl130_bg_name,
+		     DEVICE(0x0897), SUBDEV(0x5017)),
+	IWL_DEV_INFO(iwl130_bgn_cfg, iwl130_bgn_name,
+		     DEVICE(0x0896), SUBDEV(0x5025)),
+	IWL_DEV_INFO(iwl130_bg_cfg, iwl130_bg_name,
+		     DEVICE(0x0896), SUBDEV(0x5027)),
+
+/* 2x00 Series */
+	IWL_DEV_INFO(iwl2000_2bgn_cfg, iwl2000_2bgn_name,
+		     DEVICE(0x0890), SUBDEV(0x4022)),
+	IWL_DEV_INFO(iwl2000_2bgn_cfg, iwl2000_2bgn_name,
+		     DEVICE(0x0891), SUBDEV(0x4222)),
+	IWL_DEV_INFO(iwl2000_2bgn_cfg, iwl2000_2bgn_name,
+		     DEVICE(0x0890), SUBDEV(0x4422)),
+	IWL_DEV_INFO(iwl2000_2bgn_cfg, iwl2000_2bgn_d_name,
+		     DEVICE(0x0890), SUBDEV(0x4822)),
+
+/* 2x30 Series */
+	IWL_DEV_INFO(iwl2030_2bgn_cfg, iwl2030_2bgn_name,
+		     DEVICE(0x0887), SUBDEV(0x4062)),
+	IWL_DEV_INFO(iwl2030_2bgn_cfg, iwl2030_2bgn_name,
+		     DEVICE(0x0888), SUBDEV(0x4262)),
+	IWL_DEV_INFO(iwl2030_2bgn_cfg, iwl2030_2bgn_name,
+		     DEVICE(0x0887), SUBDEV(0x4462)),
+
+/* 6x35 Series */
+	IWL_DEV_INFO(iwl6035_2agn_cfg, iwl6035_2agn_name,
+		     DEVICE(0x088E), SUBDEV(0x4060)),
+	IWL_DEV_INFO(iwl6035_2agn_cfg, iwl6035_2agn_sff_name,
+		     DEVICE(0x088E), SUBDEV(0x406A)),
+	IWL_DEV_INFO(iwl6035_2agn_cfg, iwl6035_2agn_name,
+		     DEVICE(0x088F), SUBDEV(0x4260)),
+	IWL_DEV_INFO(iwl6035_2agn_cfg, iwl6035_2agn_sff_name,
+		     DEVICE(0x088F), SUBDEV(0x426A)),
+	IWL_DEV_INFO(iwl6035_2agn_cfg, iwl6035_2agn_name,
+		     DEVICE(0x088E), SUBDEV(0x4460)),
+	IWL_DEV_INFO(iwl6035_2agn_cfg, iwl6035_2agn_sff_name,
+		     DEVICE(0x088E), SUBDEV(0x446A)),
+	IWL_DEV_INFO(iwl6035_2agn_cfg, iwl6035_2agn_name,
+		     DEVICE(0x088E), SUBDEV(0x4860)),
+	IWL_DEV_INFO(iwl6035_2agn_cfg, iwl6035_2agn_name,
+		     DEVICE(0x088F), SUBDEV(0x5260)),
+
+/* 105 Series */
+	IWL_DEV_INFO(iwl105_bgn_cfg, iwl105_bgn_name,
+		     DEVICE(0x0894), SUBDEV(0x0022)),
+	IWL_DEV_INFO(iwl105_bgn_cfg, iwl105_bgn_name,
+		     DEVICE(0x0895), SUBDEV(0x0222)),
+	IWL_DEV_INFO(iwl105_bgn_cfg, iwl105_bgn_name,
+		     DEVICE(0x0894), SUBDEV(0x0422)),
+	IWL_DEV_INFO(iwl105_bgn_cfg, iwl105_bgn_name,
+		     DEVICE(0x0894), SUBDEV(0x0822)),
+
+/* 135 Series */
+	IWL_DEV_INFO(iwl135_bgn_cfg, iwl135_bgn_name,
+		     DEVICE(0x0892), SUBDEV(0x0062)),
+	IWL_DEV_INFO(iwl135_bgn_cfg, iwl135_bgn_name,
+		     DEVICE(0x0893), SUBDEV(0x0262)),
+	IWL_DEV_INFO(iwl135_bgn_cfg, iwl135_bgn_name,
+		     DEVICE(0x0892), SUBDEV(0x0462)),
+#endif /* CONFIG_IWLDVM */
+
 #if IS_ENABLED(CONFIG_IWLMVM)
+/* 7260 Series */
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B1), SUBDEV(0x4070)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B1), SUBDEV(0x4072)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B1), SUBDEV(0x4170)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B1), SUBDEV(0x4C60)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B1), SUBDEV(0x4C70)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B1), SUBDEV(0x4060)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B1), SUBDEV(0x406A)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B1), SUBDEV(0x4160)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_n_name,
+		     DEVICE(0x08B1), SUBDEV(0x4062)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_n_name,
+		     DEVICE(0x08B1), SUBDEV(0x4162)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B2), SUBDEV(0x4270)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B2), SUBDEV(0x4272)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B2), SUBDEV(0x4260)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B2), SUBDEV(0x426A)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_n_name,
+		     DEVICE(0x08B2), SUBDEV(0x4262)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B1), SUBDEV(0x4470)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B1), SUBDEV(0x4472)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B1), SUBDEV(0x4460)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B1), SUBDEV(0x446A)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_n_name,
+		     DEVICE(0x08B1), SUBDEV(0x4462)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B1), SUBDEV(0x4870)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B1), SUBDEV(0x486E)),
+	IWL_DEV_INFO(iwl7260_high_temp_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B1), SUBDEV(0x4A70)),
+	IWL_DEV_INFO(iwl7260_high_temp_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B1), SUBDEV(0x4A6E)),
+	IWL_DEV_INFO(iwl7260_high_temp_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B1), SUBDEV(0x4A6C)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B1), SUBDEV(0x4570)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B1), SUBDEV(0x4560)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B2), SUBDEV(0x4370)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B2), SUBDEV(0x4360)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B1), SUBDEV(0x5070)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B1), SUBDEV(0x5072)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B1), SUBDEV(0x5170)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B1), SUBDEV(0x5770)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B1), SUBDEV(0x4020)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B1), SUBDEV(0x402A)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B2), SUBDEV(0x4220)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B1), SUBDEV(0x4420)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B1), SUBDEV(0xC070)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B1), SUBDEV(0xC072)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B1), SUBDEV(0xC170)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B1), SUBDEV(0xC060)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B1), SUBDEV(0xC06A)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B1), SUBDEV(0xC160)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_n_name,
+		     DEVICE(0x08B1), SUBDEV(0xC062)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_n_name,
+		     DEVICE(0x08B1), SUBDEV(0xC162)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B1), SUBDEV(0xC770)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B1), SUBDEV(0xC760)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B2), SUBDEV(0xC270)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B1), SUBDEV(0xCC70)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B1), SUBDEV(0xCC60)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B2), SUBDEV(0xC272)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B2), SUBDEV(0xC260)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_n_name,
+		     DEVICE(0x08B2), SUBDEV(0xC26A)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_n_name,
+		     DEVICE(0x08B2), SUBDEV(0xC262)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B1), SUBDEV(0xC470)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B1), SUBDEV(0xC472)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B1), SUBDEV(0xC460)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_n_name,
+		     DEVICE(0x08B1), SUBDEV(0xC462)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B1), SUBDEV(0xC570)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B1), SUBDEV(0xC560)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2ac_name,
+		     DEVICE(0x08B2), SUBDEV(0xC370)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B1), SUBDEV(0xC360)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B1), SUBDEV(0xC020)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B1), SUBDEV(0xC02A)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B2), SUBDEV(0xC220)),
+	IWL_DEV_INFO(iwl7260_cfg, iwl7260_2n_name,
+		     DEVICE(0x08B1), SUBDEV(0xC420)),
+
+/* 3160 Series */
+	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
+		     DEVICE(0x08B3), SUBDEV(0x0070)),
+	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
+		     DEVICE(0x08B3), SUBDEV(0x0072)),
+	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
+		     DEVICE(0x08B3), SUBDEV(0x0170)),
+	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
+		     DEVICE(0x08B3), SUBDEV(0x0172)),
+	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2n_name,
+		     DEVICE(0x08B3), SUBDEV(0x0060)),
+	IWL_DEV_INFO(iwl3160_cfg, iwl3160_n_name,
+		     DEVICE(0x08B3), SUBDEV(0x0062)),
+	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
+		     DEVICE(0x08B4), SUBDEV(0x0270)),
+	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
+		     DEVICE(0x08B4), SUBDEV(0x0272)),
+	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
+		     DEVICE(0x08B3), SUBDEV(0x0470)),
+	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
+		     DEVICE(0x08B3), SUBDEV(0x0472)),
+	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
+		     DEVICE(0x08B4), SUBDEV(0x0370)),
+	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
+		     DEVICE(0x08B3), SUBDEV(0x8070)),
+	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
+		     DEVICE(0x08B3), SUBDEV(0x8072)),
+	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
+		     DEVICE(0x08B3), SUBDEV(0x8170)),
+	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
+		     DEVICE(0x08B3), SUBDEV(0x8172)),
+	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2n_name,
+		     DEVICE(0x08B3), SUBDEV(0x8060)),
+	IWL_DEV_INFO(iwl3160_cfg, iwl3160_n_name,
+		     DEVICE(0x08B3), SUBDEV(0x8062)),
+	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
+		     DEVICE(0x08B4), SUBDEV(0x8270)),
+	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
+		     DEVICE(0x08B4), SUBDEV(0x8370)),
+	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
+		     DEVICE(0x08B4), SUBDEV(0x8272)),
+	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
+		     DEVICE(0x08B3), SUBDEV(0x8470)),
+	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
+		     DEVICE(0x08B3), SUBDEV(0x8570)),
+	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
+		     DEVICE(0x08B3), SUBDEV(0x1070)),
+	IWL_DEV_INFO(iwl3160_cfg, iwl3160_2ac_name,
+		     DEVICE(0x08B3), SUBDEV(0x1170)),
+
+/* 3165 Series */
+	IWL_DEV_INFO(iwl3165_2ac_cfg, iwl3165_2ac_name,
+		     DEVICE(0x3165), SUBDEV(0x4010)),
+	IWL_DEV_INFO(iwl3165_2ac_cfg, iwl3165_2ac_name,
+		     DEVICE(0x3165), SUBDEV(0x4012)),
+	IWL_DEV_INFO(iwl3165_2ac_cfg, iwl3165_2ac_name,
+		     DEVICE(0x3166), SUBDEV(0x4212)),
+	IWL_DEV_INFO(iwl3165_2ac_cfg, iwl3165_2ac_name,
+		     DEVICE(0x3165), SUBDEV(0x4410)),
+	IWL_DEV_INFO(iwl3165_2ac_cfg, iwl3165_2ac_name,
+		     DEVICE(0x3165), SUBDEV(0x4510)),
+	IWL_DEV_INFO(iwl3165_2ac_cfg, iwl3165_2ac_name,
+		     DEVICE(0x3165), SUBDEV(0x4110)),
+	IWL_DEV_INFO(iwl3165_2ac_cfg, iwl3165_2ac_name,
+		     DEVICE(0x3166), SUBDEV(0x4310)),
+	IWL_DEV_INFO(iwl3165_2ac_cfg, iwl3165_2ac_name,
+		     DEVICE(0x3166), SUBDEV(0x4210)),
+	IWL_DEV_INFO(iwl3165_2ac_cfg, iwl3165_2ac_name,
+		     DEVICE(0x3165), SUBDEV(0x8010)),
+	IWL_DEV_INFO(iwl3165_2ac_cfg, iwl3165_2ac_name,
+		     DEVICE(0x3165), SUBDEV(0x8110)),
+
+/* 3168 Series */
+	IWL_DEV_INFO(iwl3168_2ac_cfg, iwl3168_2ac_name,
+		     DEVICE(0x24FB), SUBDEV(0x2010)),
+	IWL_DEV_INFO(iwl3168_2ac_cfg, iwl3168_2ac_name,
+		     DEVICE(0x24FB), SUBDEV(0x2110)),
+	IWL_DEV_INFO(iwl3168_2ac_cfg, iwl3168_2ac_name,
+		     DEVICE(0x24FB), SUBDEV(0x2050)),
+	IWL_DEV_INFO(iwl3168_2ac_cfg, iwl3168_2ac_name,
+		     DEVICE(0x24FB), SUBDEV(0x2150)),
+	IWL_DEV_INFO(iwl3168_2ac_cfg, iwl3168_2ac_name,
+		     DEVICE(0x24FB), SUBDEV(0x0000)),
+
+/* 7265 Series */
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095A), SUBDEV(0x5010)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095A), SUBDEV(0x5110)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095A), SUBDEV(0x5100)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095B), SUBDEV(0x5310)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_n_name,
+		     DEVICE(0x095B), SUBDEV(0x5302)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095B), SUBDEV(0x5210)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095A), SUBDEV(0x5C10)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095A), SUBDEV(0x5012)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095A), SUBDEV(0x5412)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095A), SUBDEV(0x5410)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095A), SUBDEV(0x5510)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095A), SUBDEV(0x5400)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095A), SUBDEV(0x1010)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2n_name,
+		     DEVICE(0x095A), SUBDEV(0x5000)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2n_name,
+		     DEVICE(0x095A), SUBDEV(0x500A)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2n_name,
+		     DEVICE(0x095B), SUBDEV(0x5200)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_n_name,
+		     DEVICE(0x095A), SUBDEV(0x5002)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_n_name,
+		     DEVICE(0x095A), SUBDEV(0x5102)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_n_name,
+		     DEVICE(0x095B), SUBDEV(0x5202)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095A), SUBDEV(0x9010)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095A), SUBDEV(0x9012)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095A), SUBDEV(0x900A)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095A), SUBDEV(0x9110)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095A), SUBDEV(0x9112)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095B), SUBDEV(0x9210)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095B), SUBDEV(0x9200)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095A), SUBDEV(0x9510)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095B), SUBDEV(0x9310)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095A), SUBDEV(0x9410)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2n_name,
+		     DEVICE(0x095A), SUBDEV(0x5020)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2n_name,
+		     DEVICE(0x095A), SUBDEV(0x502A)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2n_name,
+		     DEVICE(0x095A), SUBDEV(0x5420)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095A), SUBDEV(0x5090)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095A), SUBDEV(0x5190)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095A), SUBDEV(0x5590)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095B), SUBDEV(0x5290)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095A), SUBDEV(0x5490)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095A), SUBDEV(0x5F10)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095B), SUBDEV(0x5212)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095B), SUBDEV(0x520A)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095A), SUBDEV(0x9000)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095A), SUBDEV(0x9400)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
+		     DEVICE(0x095A), SUBDEV(0x9E10)),
+
+/* 8000 Series */
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x0010)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x1010)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x10B0)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x0130)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x1130)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x0132)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x1132)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x0110)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x01F0)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x0012)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x1012)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x1110)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x0050)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x0250)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x1050)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x0150)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x1150)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F4), SUBDEV(0x0030)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F4), SUBDEV(0x1030)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0xC010)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0xC110)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0xD010)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0xC050)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0xD050)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0xD0B0)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0xB0B0)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x8010)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x8110)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x9010)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x9110)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F4), SUBDEV(0x8030)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F4), SUBDEV(0x9030)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F4), SUBDEV(0xC030)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F4), SUBDEV(0xD030)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x8130)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x9130)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x8132)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x9132)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x8050)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x8150)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x9050)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x9150)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2n_name,
+		     DEVICE(0x24F3), SUBDEV(0x0004)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2n_name,
+		     DEVICE(0x24F3), SUBDEV(0x0044)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl4165_2ac_name,
+		     DEVICE(0x24F5), SUBDEV(0x0010)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl4165_2ac_name,
+		     DEVICE(0x24F6), SUBDEV(0x0030)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x0810)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x0910)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x0850)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x0950)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x0930)),
+	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x0000)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
+		     DEVICE(0x24F3), SUBDEV(0x4010)),
+	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
+		     DEVICE(0x24FD), SUBDEV(0x0010)),
+	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
+		     DEVICE(0x24FD), SUBDEV(0x0110)),
+	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
+		     DEVICE(0x24FD), SUBDEV(0x1110)),
+	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
+		     DEVICE(0x24FD), SUBDEV(0x1130)),
+	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
+		     DEVICE(0x24FD), SUBDEV(0x0130)),
+	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
+		     DEVICE(0x24FD), SUBDEV(0x1010)),
+	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
+		     DEVICE(0x24FD), SUBDEV(0x10D0)),
+	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
+		     DEVICE(0x24FD), SUBDEV(0x0050)),
+	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
+		     DEVICE(0x24FD), SUBDEV(0x0150)),
+	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
+		     DEVICE(0x24FD), SUBDEV(0x9010)),
+	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
+		     DEVICE(0x24FD), SUBDEV(0x8110)),
+	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
+		     DEVICE(0x24FD), SUBDEV(0x8050)),
+	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
+		     DEVICE(0x24FD), SUBDEV(0x8010)),
+	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
+		     DEVICE(0x24FD), SUBDEV(0x0810)),
+	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
+		     DEVICE(0x24FD), SUBDEV(0x9110)),
+	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
+		     DEVICE(0x24FD), SUBDEV(0x8130)),
+	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
+		     DEVICE(0x24FD), SUBDEV(0x0910)),
+	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
+		     DEVICE(0x24FD), SUBDEV(0x0930)),
+	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
+		     DEVICE(0x24FD), SUBDEV(0x0950)),
+	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
+		     DEVICE(0x24FD), SUBDEV(0x0850)),
+	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
+		     DEVICE(0x24FD), SUBDEV(0x1014)),
+	IWL_DEV_INFO(iwl8265_cfg, iwl8275_2ac_name,
+		     DEVICE(0x24FD), SUBDEV(0x3E02)),
+	IWL_DEV_INFO(iwl8265_cfg, iwl8275_2ac_name,
+		     DEVICE(0x24FD), SUBDEV(0x3E01)),
+	IWL_DEV_INFO(iwl8265_cfg, iwl8275_2ac_name,
+		     DEVICE(0x24FD), SUBDEV(0x1012)),
+	IWL_DEV_INFO(iwl8265_cfg, iwl8275_2ac_name,
+		     DEVICE(0x24FD), SUBDEV(0x0012)),
+	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
+		     DEVICE(0x24FD), SUBDEV(0x0014)),
+	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
+		     DEVICE(0x24FD), SUBDEV(0x9074)),
 /* 9000 */
 	IWL_DEV_INFO(iwl9260_2ac_cfg, iwl9260_killer_1550_name,
 		     DEVICE(0x2526), SUBDEV(0x1550)),
@@ -808,17 +1616,17 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x2725), SUBDEV(0x1673)),
 	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, iwl_ax210_killer_1675x_name,
 		     DEVICE(0x2725), SUBDEV(0x1674)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0_long, NULL,
+	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, NULL,
 		     DEVICE(0x7A70), SUBDEV(0x0090)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0_long, NULL,
+	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, NULL,
 		     DEVICE(0x7A70), SUBDEV(0x0098)),
-	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0_long, NULL,
+	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, NULL,
 		     DEVICE(0x7A70), SUBDEV(0x00B0)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0_long, NULL,
+	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, NULL,
 		     DEVICE(0x7A70), SUBDEV(0x0310)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0_long, NULL,
+	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, NULL,
 		     DEVICE(0x7A70), SUBDEV(0x0510)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0_long, NULL,
+	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, NULL,
 		     DEVICE(0x7A70), SUBDEV(0x0A10)),
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, NULL,
 		     DEVICE(0x7AF0), SUBDEV(0x0090)),
@@ -1402,25 +2210,12 @@ static void iwl_pcie_check_me_status(struct iwl_trans *trans)
 static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	const struct iwl_cfg_trans_params *trans;
-	const struct iwl_cfg *cfg_7265d __maybe_unused = NULL;
 	const struct iwl_dev_info *dev_info;
 	struct iwl_trans *iwl_trans;
 	struct iwl_trans_pcie *trans_pcie;
 	int ret;
-	const struct iwl_cfg *cfg;
-
-	trans = (void *)(ent->driver_data & ~TRANS_CFG_MARKER);
-
-	/*
-	 * This is needed for backwards compatibility with the old
-	 * tables, so we don't need to change all the config structs
-	 * at the same time.  The cfg is used to compare with the old
-	 * full cfg structs.
-	 */
-	cfg = (void *)(ent->driver_data & ~TRANS_CFG_MARKER);
 
-	/* make sure trans is the first element in iwl_cfg */
-	BUILD_BUG_ON(offsetof(struct iwl_cfg, trans));
+	trans = (void *)ent->driver_data;
 
 	iwl_trans = iwl_trans_pcie_alloc(pdev, trans);
 	if (IS_ERR(iwl_trans))
@@ -1494,29 +2289,16 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * all the parameters that the transport uses must, until that is
 	 * changed, be identical to the ones in the 7265D configuration.
 	 */
-	if (cfg == &iwl7265_2ac_cfg)
-		cfg_7265d = &iwl7265d_2ac_cfg;
-	else if (cfg == &iwl7265_2n_cfg)
-		cfg_7265d = &iwl7265d_2n_cfg;
-	else if (cfg == &iwl7265_n_cfg)
-		cfg_7265d = &iwl7265d_n_cfg;
-	if (cfg_7265d &&
+	if (iwl_trans->cfg == &iwl7265_cfg &&
 	    (iwl_trans->hw_rev & CSR_HW_REV_TYPE_MSK) == CSR_HW_REV_TYPE_7265D)
-		iwl_trans->cfg = cfg_7265d;
+		iwl_trans->cfg = &iwl7265d_cfg;
 #endif
-	/*
-	 * If we didn't set the cfg yet, the PCI ID table entry should have
-	 * been a full config - if yes, use it, otherwise fail.
-	 */
 	if (!iwl_trans->cfg) {
-		if (ent->driver_data & TRANS_CFG_MARKER) {
-			pr_err("No config found for PCI dev %04x/%04x, rev=0x%x, rfid=0x%x\n",
-			       pdev->device, pdev->subsystem_device,
-			       iwl_trans->hw_rev, iwl_trans->hw_rf_id);
-			ret = -EINVAL;
-			goto out_free_trans;
-		}
-		iwl_trans->cfg = cfg;
+		pr_err("No config found for PCI dev %04x/%04x, rev=0x%x, rfid=0x%x\n",
+		       pdev->device, pdev->subsystem_device,
+		       iwl_trans->hw_rev, iwl_trans->hw_rf_id);
+		ret = -EINVAL;
+		goto out_free_trans;
 	}
 
 	/* if we don't have a name yet, copy name from the old cfg */
diff --git a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
index 0da5e255b063..15bf1aba83c0 100644
--- a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
+++ b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
@@ -175,11 +175,7 @@ static void devinfo_no_trans_cfg_dups(struct kunit *test)
 		struct iwl_cfg_trans_params *cfg;
 		bool found = false;
 
-		if (!(iwl_hw_card_ids[i].driver_data & TRANS_CFG_MARKER))
-			continue;
-
-		cfg = (void *)(iwl_hw_card_ids[i].driver_data &
-			       ~TRANS_CFG_MARKER);
+		cfg = (void *)iwl_hw_card_ids[i].driver_data;
 
 		for (int j = 0; j < p; j++) {
 			if (cfgs[j] == cfg) {
-- 
2.34.1


