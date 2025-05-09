Return-Path: <linux-wireless+bounces-22774-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43333AB1102
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 12:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF0B4C34A7
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 10:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C85128F52A;
	Fri,  9 May 2025 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WLusnAof"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3AD28F930
	for <linux-wireless@vger.kernel.org>; Fri,  9 May 2025 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787517; cv=none; b=VMgPcLy+tXEKIE+O8gGw5m9YvyS7b4ouj/Xwlm6shWdyjOo6ehpeWCsUemLhXnYuJe2ubgTCaMLpuyLtXlt2GMlW/IF4pCTYooJGJFXgN3P3VaLrNV9gU9iqk96eyyQYZo1X2LMOTLzLARGUdk0QxG32e3clpExRHvwCEmM8HqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787517; c=relaxed/simple;
	bh=TGeDk5UFKM4K7SWAIUHtNNt02DW8SEPLConpxvqtd4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JZ/qSNx9LOai2NnkK3WNxMulxpj9ifp4DutSuImErPCVh5TKHe4sRid0lvR5dAPY06oeM5tcOCrOoG9Q+n2MB+GX+/0MkwilgOJBCplEjuPb3ytS682pIe1eO+d1XN6wQ0Grv1mxvESJSxdoLNUW9bxMhEc9pG9j+S/kmE4LAiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WLusnAof; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746787515; x=1778323515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TGeDk5UFKM4K7SWAIUHtNNt02DW8SEPLConpxvqtd4Q=;
  b=WLusnAofzZqiZvvbX01HZqR/rHTUcxiz/3cgb2uG3z6b3u8ZMlQ4W5Wr
   kfKGSuOM4Semp5/JLT6ZWwzmYSygRHE5OHYzJv5l3BbMOivbEwQpFZw5D
   APkpSBAT5Z9VRaUUMWrzJdawPUIFD4+p76o9npSyi0rXejn5c8pEp0QR4
   MAgDE7czIXagAFg67L+CifpH6VXypLHEKPtRTq134dVMc2FpDPQPh9pPW
   uDlUMUKyvoHUkNuUiHzMA1MkIj1YyuX9AHRpaVIkovxAbedpZr4B8xCs9
   6hXW7BhUKqd+cG2KCB7wMb3ATSICMFVgn+e0GAzcwrElXYMffM+SW0tUj
   g==;
X-CSE-ConnectionGUID: 57GuYNEDSyiZU/6C/jS+BQ==
X-CSE-MsgGUID: MnwoG+DGTGCXqnrgH0bpgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59239892"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="59239892"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:45:15 -0700
X-CSE-ConnectionGUID: ppNsLQDEQEekzxFlzkjqjQ==
X-CSE-MsgGUID: jOdsO/ZuSP25haiBXtsJhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="136537027"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:45:14 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: cfg: add GF RF config
Date: Fri,  9 May 2025 13:44:44 +0300
Message-Id: <20250509104454.2582160-6-miriam.rachel.korenblit@intel.com>
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

This is equivalent to just the previous iwl_cfg_ma, but
really should also be used for Bz/Gf and Sc/Gf, instead
of those using EHT sizes.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250509134302.5b2ea8fee5a4.If7f8fc859a33ae88bb8d8b1008adc667f64f2353@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/Makefile   |   2 +-
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |  22 ----
 .../net/wireless/intel/iwlwifi/cfg/rf-gf.c    |  25 ++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 116 +++++++++---------
 5 files changed, 85 insertions(+), 82 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c

diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile b/drivers/net/wireless/intel/iwlwifi/Makefile
index e2f947230738..2d4815053821 100644
--- a/drivers/net/wireless/intel/iwlwifi/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/Makefile
@@ -22,7 +22,7 @@ iwlwifi-$(CONFIG_IWLMVM) += cfg/9000.o cfg/22000.o
 iwlwifi-$(CONFIG_IWLMVM) += cfg/ax210.o
 iwlwifi-$(CONFIG_IWLMLD) += cfg/bz.o cfg/sc.o cfg/dr.o
 # RF configurations
-iwlwifi-$(CONFIG_IWLMVM) += cfg/rf-jf.o cfg/rf-hr.o
+iwlwifi-$(CONFIG_IWLMVM) += cfg/rf-jf.o cfg/rf-hr.o cfg/rf-gf.o
 
 iwlwifi-objs		+= iwl-dbg-tlv.o
 iwlwifi-objs		+= iwl-trans.o
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index f9fe7dca9739..2002b14bb82d 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -15,9 +15,6 @@
 /* Lowest firmware API version supported */
 #define IWL_AX210_UCODE_API_MIN	77
 
-/* NVM versions */
-#define IWL_AX210_NVM_VERSION		0x0a1d
-
 /* Memory offsets and lengths */
 #define IWL_AX210_SMEM_OFFSET		0x400000
 #define IWL_AX210_SMEM_LEN		0xD0000
@@ -91,19 +88,6 @@ static const struct iwl_family_base_params iwl_ax210_base = {
 	.ucode_api_max = IWL_AX210_UCODE_API_MAX,
 };
 
-#define IWL_DEVICE_AX210						\
-	.led_mode = IWL_LED_RF_STATE,					\
-	.non_shared_ant = ANT_B,					\
-	.vht_mu_mimo_supported = true,					\
-	.ht_params = {							\
-		.stbc = true,						\
-		.ldpc = true,						\
-		.ht40_bands = BIT(NL80211_BAND_2GHZ) |			\
-			      BIT(NL80211_BAND_5GHZ),			\
-	},								\
-	.nvm_ver = IWL_AX210_NVM_VERSION,				\
-	.nvm_type = IWL_NVM_EXT
-
 const struct iwl_mac_cfg iwl_so_mac_cfg = {
 	.mq_rx_supported = true,
 	.gen2 = true,
@@ -169,12 +153,6 @@ const char iwl_ax411_killer_1690i_name[] =
 
 const char iwl_ax210_name[] = "Intel(R) Wi-Fi 6 AX210 160MHz";
 
-const struct iwl_cfg iwl_cfg_ma = {
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_HE,
-};
-
 MODULE_FIRMWARE(IWL_SO_A_JF_B_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SO_A_HR_B_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 IWL_FW_AND_PNVM(IWL_SO_A_GF_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c
new file mode 100644
index 000000000000..36bf7aee7120
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2015-2017 Intel Deutschland GmbH
+ * Copyright (C) 2018-2025 Intel Corporation
+ */
+#include "iwl-config.h"
+
+/* NVM versions */
+#define IWL_GF_NVM_VERSION		0x0a1d
+
+const struct iwl_cfg iwl_rf_gf = {
+	.uhb_supported = true,
+	.led_mode = IWL_LED_RF_STATE,
+	.non_shared_ant = ANT_B,
+	.vht_mu_mimo_supported = true,
+	.ht_params = {
+		.stbc = true,
+		.ldpc = true,
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) |
+			      BIT(NL80211_BAND_5GHZ),
+	},
+	.nvm_ver = IWL_GF_NVM_VERSION,
+	.nvm_type = IWL_NVM_EXT,
+	.num_rbds = IWL_NUM_RBDS_HE,
+};
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 8da9fedbaee5..fa12e5259bf9 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -690,7 +690,7 @@ extern const struct iwl_cfg iwl_rf_hr1;
 extern const struct iwl_cfg iwl_rf_hr;
 extern const struct iwl_cfg iwl_rf_hr_80mhz;
 
-extern const struct iwl_cfg iwl_cfg_ma;
+extern const struct iwl_cfg iwl_rf_gf;
 #endif /* CONFIG_IWLMVM */
 
 #if IS_ENABLED(CONFIG_IWLMLD)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index ef1ca077d899..bf2d8db8cfc4 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -970,30 +970,30 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x51F0), SUBDEV(0x1552)),
 	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550i_160_name,
 		     DEVICE(0x51F0), SUBDEV(0x1551)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_killer_1690s_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_killer_1690s_name,
 		     DEVICE(0x51F0), SUBDEV(0x1691)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_killer_1690i_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_killer_1690i_name,
 		     DEVICE(0x51F0), SUBDEV(0x1692)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_killer_1690i_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_killer_1690i_name,
 		     DEVICE(0x51F1), SUBDEV(0x1692)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_killer_1690s_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_killer_1690s_name,
 		     DEVICE(0x54F0), SUBDEV(0x1691)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_killer_1690i_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_killer_1690i_name,
 		     DEVICE(0x54F0), SUBDEV(0x1692)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_killer_1690s_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_killer_1690s_name,
 		     DEVICE(0x7A70), SUBDEV(0x1691)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_killer_1690i_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_killer_1690i_name,
 		     DEVICE(0x7A70), SUBDEV(0x1692)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_killer_1690s_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_killer_1690s_name,
 		     DEVICE(0x7AF0), SUBDEV(0x1691)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_killer_1690i_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_killer_1690i_name,
 		     DEVICE(0x7AF0), SUBDEV(0x1692)),
 
 	IWL_DEV_INFO(iwl_rf_jf, iwl9260_1_name,
 		     DEVICE(0x271C), SUBDEV(0x0214)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_killer_1690s_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_killer_1690s_name,
 		     DEVICE(0x7E40), SUBDEV(0x1691)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_killer_1690i_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_killer_1690i_name,
 		     DEVICE(0x7E40), SUBDEV(0x1692)),
 
 /* AX200 */
@@ -1139,57 +1139,57 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x4DF0), SUBDEV(0x6074)),
 
 	/* So with HR */
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name,
 		     DEVICE(0x2725), SUBDEV(0x0090)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax210_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0x0020)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax210_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0x2020)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax210_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0x0024)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax210_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0x0310)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax210_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0x0510)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax210_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0x0A10)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax210_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0xE020)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax210_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0xE024)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax210_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0x4020)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax210_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0x6020)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax210_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0x6024)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax210_killer_1675w_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_killer_1675w_name,
 		     DEVICE(0x2725), SUBDEV(0x1673)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax210_killer_1675x_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_killer_1675x_name,
 		     DEVICE(0x2725), SUBDEV(0x1674)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name,
 		     DEVICE(0x7A70), SUBDEV(0x0090)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name,
 		     DEVICE(0x7A70), SUBDEV(0x0098)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_name,
 		     DEVICE(0x7A70), SUBDEV(0x00B0)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name,
 		     DEVICE(0x7A70), SUBDEV(0x0310)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name,
 		     DEVICE(0x7A70), SUBDEV(0x0510)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name,
 		     DEVICE(0x7A70), SUBDEV(0x0A10)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name,
 		     DEVICE(0x7AF0), SUBDEV(0x0090)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name,
 		     DEVICE(0x7AF0), SUBDEV(0x0098)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_name,
 		     DEVICE(0x7AF0), SUBDEV(0x00B0)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name,
 		     DEVICE(0x7AF0), SUBDEV(0x0310)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name,
 		     DEVICE(0x7AF0), SUBDEV(0x0510)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name,
 		     DEVICE(0x7AF0), SUBDEV(0x0A10)),
 
 	/* So with JF */
@@ -1203,35 +1203,35 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x7AF0), SUBDEV(0x1552)),
 
 	/* SO with GF2 */
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_killer_1675s_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675s_name,
 		     DEVICE(0x51F0), SUBDEV(0x1671)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_killer_1675i_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675i_name,
 		     DEVICE(0x51F0), SUBDEV(0x1672)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_killer_1675s_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675s_name,
 		     DEVICE(0x51F1), SUBDEV(0x1671)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_killer_1675i_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675i_name,
 		     DEVICE(0x51F1), SUBDEV(0x1672)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_killer_1675s_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675s_name,
 		     DEVICE(0x54F0), SUBDEV(0x1671)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_killer_1675i_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675i_name,
 		     DEVICE(0x54F0), SUBDEV(0x1672)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_killer_1675s_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675s_name,
 		     DEVICE(0x7A70), SUBDEV(0x1671)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_killer_1675i_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675i_name,
 		     DEVICE(0x7A70), SUBDEV(0x1672)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_killer_1675s_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675s_name,
 		     DEVICE(0x7AF0), SUBDEV(0x1671)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_killer_1675i_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675i_name,
 		     DEVICE(0x7AF0), SUBDEV(0x1672)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_killer_1675s_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675s_name,
 		     DEVICE(0x7F70), SUBDEV(0x1671)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_killer_1675i_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675i_name,
 		     DEVICE(0x7F70), SUBDEV(0x1672)),
 
 	/* MA with GF2 */
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_killer_1675s_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675s_name,
 		     DEVICE(0x7E40), SUBDEV(0x1671)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_killer_1675i_name,
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_killer_1675i_name,
 		     DEVICE(0x7E40), SUBDEV(0x1672)),
 
 	IWL_DEV_INFO(iwl_rf_jf, iwl9461_160_name, MAC_TYPE(PU),
@@ -1379,10 +1379,10 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     MAC_STEP(B), RF_TYPE(HR2), BW_NOT_LIMITED, NO_CDB),
 
 /* Ma */
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax201_name, MAC_TYPE(MA), RF_TYPE(HR2),
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax201_name, MAC_TYPE(MA), RF_TYPE(HR2),
 		     NO_CDB),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_name, MAC_TYPE(MA), RF_TYPE(GF)),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax231_name, MAC_TYPE(MA), RF_TYPE(FM),
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name, MAC_TYPE(MA), RF_TYPE(GF)),
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax231_name, MAC_TYPE(MA), RF_TYPE(FM),
 		     NO_CDB),
 
 /* So with Hr */
@@ -1405,9 +1405,9 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     RF_TYPE(HR2), BW_NOT_LIMITED, NO_CDB),
 
 /* So-F with Gf */
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_name, MAC_TYPE(SOF),
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name, MAC_TYPE(SOF),
 		     RF_TYPE(GF), BW_NOT_LIMITED, NO_CDB),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_name, MAC_TYPE(SOF),
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_name, MAC_TYPE(SOF),
 		     RF_TYPE(GF), BW_NOT_LIMITED, CDB),
 
 /* SoF with JF2 */
@@ -1427,9 +1427,9 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_LIMITED, CORES(BT), NO_CDB),
 
 /* So with GF */
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_name, MAC_TYPE(SO),
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name, MAC_TYPE(SO),
 		     RF_TYPE(GF), BW_NOT_LIMITED, NO_CDB),
-	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_name, MAC_TYPE(SO),
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_name, MAC_TYPE(SO),
 		     RF_TYPE(GF), BW_NOT_LIMITED, CDB),
 
 /* So with JF2 */
-- 
2.34.1


