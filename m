Return-Path: <linux-wireless+bounces-22773-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2CFAB1101
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 12:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6F6176B79
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 10:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E9C28F958;
	Fri,  9 May 2025 10:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oDTjZjZy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F6E28F52A
	for <linux-wireless@vger.kernel.org>; Fri,  9 May 2025 10:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787516; cv=none; b=Q9YF1Q/l+IJnKK9JADPrFGyvrdx8Z7Xs3SF0hmcMPgZCCZj8z3yMJ4GUmGN2v5R5D0NO3IWqkaTPjWWXpfg70Ka+KkK7wHjpDGp3sazAoG9MiOG+pNRGNAM/Ec2ctJZUFZwtVsrp5YQyTUKPoaVjR3oAcAu30Bl270/6iPDnpD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787516; c=relaxed/simple;
	bh=HGhN4TWCZw2GYET2LsrZwDdqlbsrgPvian0yNqF1UeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K2F+rDErgHsXA9+hTFneQ/KvTU05SpdnW4WooIGA9KKNExJKmsYOVpo60XIj2mPkOH+viVunyqhURG9jqKMKDHYlz+ttL9/LZmnjvPecF+pMWlM8rURGTbTKsn/Zm45+7HmjOBBwh9F64g/Y0f8chnVD/zM6iXKzzdgX61MqxLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oDTjZjZy; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746787514; x=1778323514;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HGhN4TWCZw2GYET2LsrZwDdqlbsrgPvian0yNqF1UeY=;
  b=oDTjZjZydUhAmnyPE1rUUc4YPizJ12iHgGeutaDVIwD55t7Zg0qSa5lk
   fucJLixOFilRXn/NqIdghVkAoAGpJst1tgTlE87/PKsb+vn6ZXNwytXMH
   YyDWVM9I8XfjDRvvNlyxlaKnP7N81JB7E/mYTSSGArCrV7vqc2uRkNSYd
   4fKzYRtdKwTCSLPFQnlVkRz4ZJRDCIpqLrJXTh1qTmR8BVUMhYjDunUR6
   SpcVWSf0yqyXa0ZVkb4AAjbUUqiQD/q68F227ZErMGMeaoi/ZD1Sa2Tbm
   SA4OSDaXj6kIfSKf49/VLoW0Xs79VTYgxGUpA34uPID+XSAfg5cZiYxtH
   g==;
X-CSE-ConnectionGUID: SlLFRm1YRWyBOGbopkxYRw==
X-CSE-MsgGUID: zdZwfdE7S6GlWeSv8wI2UA==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59239890"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="59239890"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:45:14 -0700
X-CSE-ConnectionGUID: yOkKnCY9SsasTYelEXFOOQ==
X-CSE-MsgGUID: 67XXKwLCSQKRz4/k5iCm9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="136537023"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:45:13 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: cfg: unify HR configs
Date: Fri,  9 May 2025 13:44:43 +0300
Message-Id: <20250509104454.2582160-5-miriam.rachel.korenblit@intel.com>
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

Unify the HR configs to just one HR RF config. All the fields
were the same already, so this doesn't do anything.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250509134302.2c5464350327.I284d04c35ad75dcf6d333c84032094c179fa49b3@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/Makefile   |   2 +-
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  33 ----
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |  11 --
 .../net/wireless/intel/iwlwifi/cfg/rf-hr.c    |  37 ++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   9 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 166 +++++++++---------
 6 files changed, 124 insertions(+), 134 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c

diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile b/drivers/net/wireless/intel/iwlwifi/Makefile
index 9d850d5a447b..e2f947230738 100644
--- a/drivers/net/wireless/intel/iwlwifi/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/Makefile
@@ -22,7 +22,7 @@ iwlwifi-$(CONFIG_IWLMVM) += cfg/9000.o cfg/22000.o
 iwlwifi-$(CONFIG_IWLMVM) += cfg/ax210.o
 iwlwifi-$(CONFIG_IWLMLD) += cfg/bz.o cfg/sc.o cfg/dr.o
 # RF configurations
-iwlwifi-$(CONFIG_IWLMVM) += cfg/rf-jf.o
+iwlwifi-$(CONFIG_IWLMVM) += cfg/rf-jf.o cfg/rf-hr.o
 
 iwlwifi-objs		+= iwl-dbg-tlv.o
 iwlwifi-objs		+= iwl-trans.o
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 4d49d0ab1604..5855cf430798 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -15,9 +15,6 @@
 /* Lowest firmware API version supported */
 #define IWL_22000_UCODE_API_MIN	77
 
-/* NVM versions */
-#define IWL_22000_NVM_VERSION		0x0a1d
-
 /* Memory offsets and lengths */
 #define IWL_22000_SMEM_OFFSET		0x400000
 #define IWL_22000_SMEM_LEN		0xD0000
@@ -87,19 +84,6 @@ static const struct iwl_family_base_params iwl_22000_base = {
 	.ucode_api_max = IWL_22000_UCODE_API_MAX,
 };
 
-#define IWL_DEVICE_22500						\
-	.led_mode = IWL_LED_RF_STATE,					\
-	.non_shared_ant = ANT_B,					\
-	.vht_mu_mimo_supported = true,					\
-	.ht_params = {							\
-		.stbc = true,						\
-		.ldpc = true,						\
-		.ht40_bands = BIT(NL80211_BAND_2GHZ) |			\
-			      BIT(NL80211_BAND_5GHZ),			\
-	},								\
-	.nvm_ver = IWL_22000_NVM_VERSION,				\
-	.nvm_type = IWL_NVM_EXT
-
 const struct iwl_mac_cfg iwl_qu_mac_cfg = {
 	.mq_rx_supported = true,
 	.gen2 = true,
@@ -153,23 +137,6 @@ const char iwl_ax201_killer_1650s_name[] =
 const char iwl_ax201_killer_1650i_name[] =
 	"Killer(R) Wi-Fi 6 AX1650i 160MHz Wireless Network Adapter (201NGW)";
 
-const struct iwl_cfg iwl_qu_hr1 = {
-	IWL_DEVICE_22500,
-	.tx_with_siso_diversity = true,
-	.num_rbds = IWL_NUM_RBDS_HE,
-};
-
-const struct iwl_cfg iwl_qu_hr = {
-	IWL_DEVICE_22500,
-	.num_rbds = IWL_NUM_RBDS_HE,
-};
-
-const struct iwl_cfg iwl_qu_hr_80mhz = {
-	IWL_DEVICE_22500,
-	.num_rbds = IWL_NUM_RBDS_HE,
-	.bw_limit = 80,
-};
-
 MODULE_FIRMWARE(IWL_QU_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QU_C_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QU_B_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 6c15bdff7c34..f9fe7dca9739 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -175,17 +175,6 @@ const struct iwl_cfg iwl_cfg_ma = {
 	.num_rbds = IWL_NUM_RBDS_HE,
 };
 
-const struct iwl_cfg iwl_cfg_so_a0_hr_a0 = {
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_HE,
-};
-
-const struct iwl_cfg iwl_cfg_so_a0_hr_a0_80mhz = {
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_HE,
-	.bw_limit = 80,
-};
-
 MODULE_FIRMWARE(IWL_SO_A_JF_B_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SO_A_HR_B_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 IWL_FW_AND_PNVM(IWL_SO_A_GF_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c
new file mode 100644
index 000000000000..d01f823ce272
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2015-2017 Intel Deutschland GmbH
+ * Copyright (C) 2018-2025 Intel Corporation
+ */
+#include "iwl-config.h"
+
+/* NVM versions */
+#define IWL_HR_NVM_VERSION		0x0a1d
+
+#define IWL_DEVICE_HR							\
+	.led_mode = IWL_LED_RF_STATE,					\
+	.non_shared_ant = ANT_B,					\
+	.vht_mu_mimo_supported = true,					\
+	.ht_params = {							\
+		.stbc = true,						\
+		.ldpc = true,						\
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) |			\
+			      BIT(NL80211_BAND_5GHZ),			\
+	},								\
+	.num_rbds = IWL_NUM_RBDS_HE,					\
+	.nvm_ver = IWL_HR_NVM_VERSION,					\
+	.nvm_type = IWL_NVM_EXT
+
+const struct iwl_cfg iwl_rf_hr1 = {
+	IWL_DEVICE_HR,
+	.tx_with_siso_diversity = true,
+};
+
+const struct iwl_cfg iwl_rf_hr = {
+	IWL_DEVICE_HR,
+};
+
+const struct iwl_cfg iwl_rf_hr_80mhz = {
+	IWL_DEVICE_HR,
+	.bw_limit = 80,
+};
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 4051800c8d77..8da9fedbaee5 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -686,14 +686,11 @@ extern const struct iwl_cfg iwl8260_cfg;
 extern const struct iwl_cfg iwl8265_cfg;
 extern const struct iwl_cfg iwl_rf_jf;
 extern const struct iwl_cfg iwl_rf_jf_80mhz;
-extern const struct iwl_cfg iwl_qu_hr1;
-extern const struct iwl_cfg iwl_qu_hr;
-extern const struct iwl_cfg iwl_qu_hr_80mhz;
+extern const struct iwl_cfg iwl_rf_hr1;
+extern const struct iwl_cfg iwl_rf_hr;
+extern const struct iwl_cfg iwl_rf_hr_80mhz;
 
 extern const struct iwl_cfg iwl_cfg_ma;
-
-extern const struct iwl_cfg iwl_cfg_so_a0_hr_a0;
-extern const struct iwl_cfg iwl_cfg_so_a0_hr_a0_80mhz;
 #endif /* CONFIG_IWLMVM */
 
 #if IS_ENABLED(CONFIG_IWLMLD)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 7dbac8a1446d..ef1ca077d899 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -997,145 +997,145 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x7E40), SUBDEV(0x1692)),
 
 /* AX200 */
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax200_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax200_name,
 		     DEVICE(0x2723)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax200_killer_1650w_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax200_killer_1650w_name,
 		     DEVICE(0x2723), SUBDEV(0x1653)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax200_killer_1650x_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax200_killer_1650x_name,
 		     DEVICE(0x2723), SUBDEV(0x1654)),
 
 	/* Qu with Hr */
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x43F0), SUBDEV(0x0070)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x43F0), SUBDEV(0x0074)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x43F0), SUBDEV(0x0078)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x43F0), SUBDEV(0x007C)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650s_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650s_name,
 		     DEVICE(0x43F0), SUBDEV(0x1651)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650i_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650i_name,
 		     DEVICE(0x43F0), SUBDEV(0x1652)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x43F0), SUBDEV(0x2074)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x43F0), SUBDEV(0x4070)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0xA0F0), SUBDEV(0x0070)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0xA0F0), SUBDEV(0x0074)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0xA0F0), SUBDEV(0x0078)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0xA0F0), SUBDEV(0x007C)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0xA0F0), SUBDEV(0x0A10)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650s_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650s_name,
 		     DEVICE(0xA0F0), SUBDEV(0x1651)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650i_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650i_name,
 		     DEVICE(0xA0F0), SUBDEV(0x1652)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0xA0F0), SUBDEV(0x2074)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0xA0F0), SUBDEV(0x4070)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0xA0F0), SUBDEV(0x6074)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x02F0), SUBDEV(0x0070)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x02F0), SUBDEV(0x0074)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x02F0), SUBDEV(0x6074)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x02F0), SUBDEV(0x0078)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x02F0), SUBDEV(0x007C)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x02F0), SUBDEV(0x0310)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650s_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650s_name,
 		     DEVICE(0x02F0), SUBDEV(0x1651)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650i_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650i_name,
 		     DEVICE(0x02F0), SUBDEV(0x1652)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x02F0), SUBDEV(0x2074)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x02F0), SUBDEV(0x4070)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x06F0), SUBDEV(0x0070)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x06F0), SUBDEV(0x0074)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x06F0), SUBDEV(0x0078)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x06F0), SUBDEV(0x007C)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x06F0), SUBDEV(0x0310)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650s_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650s_name,
 		     DEVICE(0x06F0), SUBDEV(0x1651)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650i_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650i_name,
 		     DEVICE(0x06F0), SUBDEV(0x1652)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x06F0), SUBDEV(0x2074)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x06F0), SUBDEV(0x4070)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x34F0), SUBDEV(0x0070)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x34F0), SUBDEV(0x0074)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x34F0), SUBDEV(0x0078)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x34F0), SUBDEV(0x007C)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x34F0), SUBDEV(0x0310)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650s_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650s_name,
 		     DEVICE(0x34F0), SUBDEV(0x1651)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650i_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650i_name,
 		     DEVICE(0x34F0), SUBDEV(0x1652)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x34F0), SUBDEV(0x2074)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x34F0), SUBDEV(0x4070)),
 
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x3DF0), SUBDEV(0x0070)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x3DF0), SUBDEV(0x0074)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x3DF0), SUBDEV(0x0078)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x3DF0), SUBDEV(0x007C)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x3DF0), SUBDEV(0x0310)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650s_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650s_name,
 		     DEVICE(0x3DF0), SUBDEV(0x1651)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650i_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650i_name,
 		     DEVICE(0x3DF0), SUBDEV(0x1652)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x3DF0), SUBDEV(0x2074)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x3DF0), SUBDEV(0x4070)),
 
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x4DF0), SUBDEV(0x0070)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x4DF0), SUBDEV(0x0074)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x4DF0), SUBDEV(0x0078)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x4DF0), SUBDEV(0x007C)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x4DF0), SUBDEV(0x0310)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650s_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650s_name,
 		     DEVICE(0x4DF0), SUBDEV(0x1651)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650i_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650i_name,
 		     DEVICE(0x4DF0), SUBDEV(0x1652)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x4DF0), SUBDEV(0x2074)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x4DF0), SUBDEV(0x4070)),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
 		     DEVICE(0x4DF0), SUBDEV(0x6074)),
 
 	/* So with HR */
@@ -1357,25 +1357,25 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 
 /* Qu with Hr */
 	/* Qu B step */
-	IWL_DEV_INFO(iwl_qu_hr1, iwl_ax101_name, MAC_TYPE(QU),
+	IWL_DEV_INFO(iwl_rf_hr1, iwl_ax101_name, MAC_TYPE(QU),
 		     MAC_STEP(B), RF_TYPE(HR1), NO_CDB),
-	IWL_DEV_INFO(iwl_qu_hr_80mhz, iwl_ax203_name, MAC_TYPE(QU), MAC_STEP(B),
+	IWL_DEV_INFO(iwl_rf_hr_80mhz, iwl_ax203_name, MAC_TYPE(QU), MAC_STEP(B),
 		     RF_TYPE(HR2), BW_LIMITED, NO_CDB),
 
 	/* Qu C step */
-	IWL_DEV_INFO(iwl_qu_hr1, iwl_ax101_name, MAC_TYPE(QU),
+	IWL_DEV_INFO(iwl_rf_hr1, iwl_ax101_name, MAC_TYPE(QU),
 		     MAC_STEP(C), RF_TYPE(HR1), NO_CDB),
-	IWL_DEV_INFO(iwl_qu_hr_80mhz, iwl_ax203_name, MAC_TYPE(QU), MAC_STEP(C),
+	IWL_DEV_INFO(iwl_rf_hr_80mhz, iwl_ax203_name, MAC_TYPE(QU), MAC_STEP(C),
 		     RF_TYPE(HR2), BW_LIMITED, NO_CDB),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name, MAC_TYPE(QU), MAC_STEP(C),
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name, MAC_TYPE(QU), MAC_STEP(C),
 		     RF_TYPE(HR2), BW_NOT_LIMITED, NO_CDB),
 
 	/* QuZ */
-	IWL_DEV_INFO(iwl_qu_hr1, iwl_ax101_name, MAC_TYPE(QUZ),
+	IWL_DEV_INFO(iwl_rf_hr1, iwl_ax101_name, MAC_TYPE(QUZ),
 		     RF_TYPE(HR1), NO_CDB),
-	IWL_DEV_INFO(iwl_qu_hr_80mhz, iwl_ax203_name, MAC_TYPE(QUZ),
+	IWL_DEV_INFO(iwl_rf_hr_80mhz, iwl_ax203_name, MAC_TYPE(QUZ),
 		     MAC_STEP(B), RF_TYPE(HR2), BW_LIMITED, NO_CDB),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name, MAC_TYPE(QUZ),
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name, MAC_TYPE(QUZ),
 		     MAC_STEP(B), RF_TYPE(HR2), BW_NOT_LIMITED, NO_CDB),
 
 /* Ma */
@@ -1386,22 +1386,22 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     NO_CDB),
 
 /* So with Hr */
-	IWL_DEV_INFO(iwl_cfg_so_a0_hr_a0_80mhz, iwl_ax203_name, MAC_TYPE(SO),
+	IWL_DEV_INFO(iwl_rf_hr_80mhz, iwl_ax203_name, MAC_TYPE(SO),
 		     RF_TYPE(HR2), BW_LIMITED, NO_CDB),
-	IWL_DEV_INFO(iwl_cfg_so_a0_hr_a0_80mhz, iwl_ax101_name, MAC_TYPE(SO),
+	IWL_DEV_INFO(iwl_rf_hr_80mhz, iwl_ax101_name, MAC_TYPE(SO),
 		     RF_TYPE(HR1), BW_LIMITED, NO_CDB),
-	IWL_DEV_INFO(iwl_cfg_so_a0_hr_a0, iwl_ax201_name, MAC_TYPE(SO),
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name, MAC_TYPE(SO),
 		     RF_TYPE(HR2), BW_NOT_LIMITED, NO_CDB),
-	IWL_DEV_INFO(iwl_cfg_so_a0_hr_a0, iwl_ax201_killer_1650i_name,
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_killer_1650i_name,
 		     DEVICE(0x51f0), SUBDEV(0x1652),
 		     MAC_TYPE(SO), RF_TYPE(HR2)),
 
 /* So-F with Hr */
-	IWL_DEV_INFO(iwl_cfg_so_a0_hr_a0_80mhz, iwl_ax203_name, MAC_TYPE(SOF),
+	IWL_DEV_INFO(iwl_rf_hr_80mhz, iwl_ax203_name, MAC_TYPE(SOF),
 		     RF_TYPE(HR2), BW_LIMITED, NO_CDB),
-	IWL_DEV_INFO(iwl_cfg_so_a0_hr_a0_80mhz, iwl_ax101_name, MAC_TYPE(SOF),
+	IWL_DEV_INFO(iwl_rf_hr_80mhz, iwl_ax101_name, MAC_TYPE(SOF),
 		     RF_TYPE(HR1), BW_LIMITED, NO_CDB),
-	IWL_DEV_INFO(iwl_cfg_so_a0_hr_a0, iwl_ax201_name, MAC_TYPE(SOF),
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name, MAC_TYPE(SOF),
 		     RF_TYPE(HR2), BW_NOT_LIMITED, NO_CDB),
 
 /* So-F with Gf */
-- 
2.34.1


