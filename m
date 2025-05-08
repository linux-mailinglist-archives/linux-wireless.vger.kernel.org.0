Return-Path: <linux-wireless+bounces-22749-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA8CAAF97C
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 14:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58D7C1C007D9
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 12:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD87A225417;
	Thu,  8 May 2025 12:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KhcFttT6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9246A227EAF
	for <linux-wireless@vger.kernel.org>; Thu,  8 May 2025 12:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706420; cv=none; b=gRUwyAvi1bC5lFIIkuBk7PP0g01/VKUtVq+K2z/q+O0emK5p+YuL8PHe32fWs+XvjUXxnH72LeIAE4t2aU0oNhf1TloEcQWClmbRrweDKodmfaVneSNt8cyrjaHUXVPIimh2huwd1tas5BPigC7/62ff9mgy/8G3LNDGUMrqNF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706420; c=relaxed/simple;
	bh=pI6a50c2NNYtsCTqb9Og3Lmk5McVaEeJwPueOEz7YOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vf3wUTYW9lW6i2q2iuauqU+UqGoI9QTLm226qt6XZOYpFBifDwrfNN+zFAiPh1Sf67G95pfc1fOwkncv5ETp9iNsys7s8bVq7VnfItO0VQUE7xjnuKPUMoy2cSpEHKp2L3PWgPZYO6oPXHDaAymkHYTBqwG6KWCDvS7rPOuCKr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KhcFttT6; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746706418; x=1778242418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pI6a50c2NNYtsCTqb9Og3Lmk5McVaEeJwPueOEz7YOc=;
  b=KhcFttT6hGVrtVd/j0/RZ0UT2nmVOhK6VC6/VZlAi5efZPCRsRY2Wh/+
   YOqA479MxVI4tN3XM8/5OyZfpGWlnuS9sKRplEECFZAJKeVp0EuK85+5g
   ptrDY8snqrstR1/0arO42fTBy1XqrERWiNQyLIqliGADFf01bKcxfD8WH
   i3zui34eLWe+C0cIfMfFv1PbMmc9z1L6oRQwXjY7JnM8zOkzLKrsDOJIW
   Wx3+3rDJxjktsgZWixexyJrgOHreGc0qpkiDaUfG3oBDtPld+Y8cCf3fj
   GbrRM43qgMdl5f8V9s97XSt23KfxMiJ9su7Z7e3vNwceYcVP8XRnWkA+3
   g==;
X-CSE-ConnectionGUID: hmrZHzVCTjegUz6FD/BCWg==
X-CSE-MsgGUID: XS7aTBq5RL6GYOqV2sMrWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="58688049"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="58688049"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:37 -0700
X-CSE-ConnectionGUID: xTosQTIsSAaKPLsHZTd/ow==
X-CSE-MsgGUID: CJcqGhjPRPOvf0mx44UbNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="167347870"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:36 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: rename struct iwl_base_params
Date: Thu,  8 May 2025 15:13:02 +0300
Message-Id: <20250508121306.1277801-12-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250508121306.1277801-1-miriam.rachel.korenblit@intel.com>
References: <20250508121306.1277801-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

These are (going to be) base MAC parameters that are identical
even for different platforms with the same MAC, so rename the
structure accordingly, calling it iwl_family_base_params.

Also rename the pointer to it so the dereferencing is a bit
shorter.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250508151045.3bfefd7362a4.I1108eb51a4935abec4206f0aac461a3833033e79@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/1000.c |  4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/2000.c | 12 ++---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 10 ++--
 drivers/net/wireless/intel/iwlwifi/cfg/5000.c |  6 +--
 drivers/net/wireless/intel/iwlwifi/cfg/6000.c | 18 ++++----
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c |  4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c |  4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c | 10 ++--
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    | 10 ++--
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  6 +--
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   |  6 +--
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  4 +-
 .../net/wireless/intel/iwlwifi/dvm/eeprom.c   |  8 ++--
 drivers/net/wireless/intel/iwlwifi/dvm/led.c  |  4 +-
 .../net/wireless/intel/iwlwifi/dvm/mac80211.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |  2 +-
 .../net/wireless/intel/iwlwifi/dvm/power.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c   |  4 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   | 12 +++--
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  4 +-
 drivers/net/wireless/intel/iwlwifi/mld/tx.c   |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 10 ++--
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  2 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    |  4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  4 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 12 ++---
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |  8 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 46 +++++++++----------
 31 files changed, 116 insertions(+), 112 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/1000.c b/drivers/net/wireless/intel/iwlwifi/cfg/1000.c
index 2cc2c2f8e653..f40fea33e69b 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/1000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/1000.c
@@ -29,7 +29,7 @@
 #define IWL100_MODULE_FIRMWARE(api) IWL100_FW_PRE "-" __stringify(api) ".ucode"
 
 
-static const struct iwl_base_params iwl1000_base_params = {
+static const struct iwl_family_base_params iwl1000_base = {
 	.num_of_queues = IWLAGN_NUM_QUEUES,
 	.max_tfd_queue_size = 256,
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_2K,
@@ -56,7 +56,7 @@ static const struct iwl_eeprom_params iwl1000_eeprom_params = {
 
 const struct iwl_mac_cfg iwl1000_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_1000,
-	.base_params = &iwl1000_base_params,
+	.base = &iwl1000_base,
 };
 
 #define IWL_DEVICE_1000						\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/2000.c b/drivers/net/wireless/intel/iwlwifi/cfg/2000.c
index 7e8e9c8eda75..33f04c9d05d6 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/2000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/2000.c
@@ -40,7 +40,7 @@
 #define IWL135_FW_PRE "iwlwifi-135"
 #define IWL135_MODULE_FIRMWARE(api) IWL135_FW_PRE "-" __stringify(api) ".ucode"
 
-static const struct iwl_base_params iwl2000_base_params = {
+static const struct iwl_family_base_params iwl2000_base = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_2K,
 	.num_of_queues = IWLAGN_NUM_QUEUES,
 	.max_tfd_queue_size = 256,
@@ -54,7 +54,7 @@ static const struct iwl_base_params iwl2000_base_params = {
 };
 
 
-static const struct iwl_base_params iwl2030_base_params = {
+static const struct iwl_family_base_params iwl2030_base = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_2K,
 	.num_of_queues = IWLAGN_NUM_QUEUES,
 	.max_tfd_queue_size = 256,
@@ -82,7 +82,7 @@ static const struct iwl_eeprom_params iwl20x0_eeprom_params = {
 
 const struct iwl_mac_cfg iwl2000_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_2000,
-	.base_params = &iwl2000_base_params,
+	.base = &iwl2000_base,
 };
 
 #define IWL_DEVICE_2000						\
@@ -111,7 +111,7 @@ const char iwl2000_2bgn_d_name[] = "Intel(R) Centrino(R) Wireless-N 2200D BGN";
 
 const struct iwl_mac_cfg iwl2030_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_2030,
-	.base_params = &iwl2030_base_params,
+	.base = &iwl2030_base,
 };
 
 #define IWL_DEVICE_2030						\
@@ -138,7 +138,7 @@ const char iwl2030_2bgn_name[] = "Intel(R) Centrino(R) Wireless-N 2230 BGN";
 
 const struct iwl_mac_cfg iwl105_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_105,
-	.base_params = &iwl2000_base_params,
+	.base = &iwl2000_base,
 };
 
 #define IWL_DEVICE_105						\
@@ -167,7 +167,7 @@ const char iwl105_bgn_d_name[] = "Intel(R) Centrino(R) Wireless-N 105D BGN";
 
 const struct iwl_mac_cfg iwl135_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_135,
-	.base_params = &iwl2030_base_params,
+	.base = &iwl2030_base,
 };
 
 #define IWL_DEVICE_135						\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index f95cf1c0ae03..09286509fe3e 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -49,7 +49,7 @@
 #define IWL_CC_A_MODULE_FIRMWARE(api)			\
 	IWL_CC_A_FW_PRE "-" __stringify(api) ".ucode"
 
-static const struct iwl_base_params iwl_22000_base_params = {
+static const struct iwl_family_base_params iwl_22000_base = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 256,
@@ -116,7 +116,7 @@ const struct iwl_mac_cfg iwl_qu_mac_cfg = {
 	.mq_rx_supported = true,
 	.gen2 = true,
 	.device_family = IWL_DEVICE_FAMILY_22000,
-	.base_params = &iwl_22000_base_params,
+	.base = &iwl_22000_base,
 	.integrated = true,
 	.xtal_latency = 500,
 	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_200US,
@@ -126,7 +126,7 @@ const struct iwl_mac_cfg iwl_qu_medium_latency_mac_cfg = {
 	.mq_rx_supported = true,
 	.gen2 = true,
 	.device_family = IWL_DEVICE_FAMILY_22000,
-	.base_params = &iwl_22000_base_params,
+	.base = &iwl_22000_base,
 	.integrated = true,
 	.xtal_latency = 1820,
 	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_1820US,
@@ -136,7 +136,7 @@ const struct iwl_mac_cfg iwl_qu_long_latency_mac_cfg = {
 	.mq_rx_supported = true,
 	.gen2 = true,
 	.device_family = IWL_DEVICE_FAMILY_22000,
-	.base_params = &iwl_22000_base_params,
+	.base = &iwl_22000_base,
 	.integrated = true,
 	.xtal_latency = 12000,
 	.low_latency_xtal = true,
@@ -171,7 +171,7 @@ const struct iwl_cfg iwl9560_qu_jf_cfg_80mhz = {
 
 const struct iwl_mac_cfg iwl_ax200_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_22000,
-	.base_params = &iwl_22000_base_params,
+	.base = &iwl_22000_base,
 	.mq_rx_supported = true,
 	.gen2 = true,
 	.bisr_workaround = 1,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/5000.c b/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
index 6f9697847b80..79ba0524086a 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
@@ -30,7 +30,7 @@
 #define IWL5150_FW_PRE "iwlwifi-5150"
 #define IWL5150_MODULE_FIRMWARE(api) IWL5150_FW_PRE "-" __stringify(api) ".ucode"
 
-static const struct iwl_base_params iwl5000_base_params = {
+static const struct iwl_family_base_params iwl5000_base = {
 	.eeprom_size = IWLAGN_EEPROM_IMG_SIZE,
 	.num_of_queues = IWLAGN_NUM_QUEUES,
 	.max_tfd_queue_size = 256,
@@ -55,7 +55,7 @@ static const struct iwl_eeprom_params iwl5000_eeprom_params = {
 
 const struct iwl_mac_cfg iwl5000_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_5000,
-	.base_params = &iwl5000_base_params,
+	.base = &iwl5000_base,
 };
 
 #define IWL_DEVICE_5000						\
@@ -124,7 +124,7 @@ const char iwl5350_agn_name[] = "Intel(R) WiMAX/WiFi Link 5350 AGN";
 
 const struct iwl_mac_cfg iwl5150_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_5150,
-	.base_params = &iwl5000_base_params,
+	.base = &iwl5000_base,
 };
 
 #define IWL_DEVICE_5150						\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/6000.c b/drivers/net/wireless/intel/iwlwifi/cfg/6000.c
index ea930bcf8791..94f042760359 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/6000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/6000.c
@@ -49,7 +49,7 @@
 #define IWL6030_FW_PRE "iwlwifi-6000g2b"
 #define IWL6030_MODULE_FIRMWARE(api) IWL6030_FW_PRE "-" __stringify(api) ".ucode"
 
-static const struct iwl_base_params iwl6000_base_params = {
+static const struct iwl_family_base_params iwl6000_base = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_2K,
 	.num_of_queues = IWLAGN_NUM_QUEUES,
 	.max_tfd_queue_size = 256,
@@ -62,7 +62,7 @@ static const struct iwl_base_params iwl6000_base_params = {
 	.scd_chain_ext_wa = true,
 };
 
-static const struct iwl_base_params iwl6050_base_params = {
+static const struct iwl_family_base_params iwl6050_base = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_2K,
 	.num_of_queues = IWLAGN_NUM_QUEUES,
 	.max_tfd_queue_size = 256,
@@ -75,7 +75,7 @@ static const struct iwl_base_params iwl6050_base_params = {
 	.scd_chain_ext_wa = true,
 };
 
-static const struct iwl_base_params iwl6000_g2_base_params = {
+static const struct iwl_family_base_params iwl6000_g2_base = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_2K,
 	.num_of_queues = IWLAGN_NUM_QUEUES,
 	.max_tfd_queue_size = 256,
@@ -103,7 +103,7 @@ static const struct iwl_eeprom_params iwl6000_eeprom_params = {
 
 const struct iwl_mac_cfg iwl6005_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_6005,
-	.base_params = &iwl6000_g2_base_params,
+	.base = &iwl6000_g2_base,
 };
 
 #define IWL_DEVICE_6005						\
@@ -141,7 +141,7 @@ const char iwl6005_2bg_name[] = "Intel(R) Centrino(R) Advanced-N 6205 BG";
 
 const struct iwl_mac_cfg iwl6030_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_6030,
-	.base_params = &iwl6000_g2_base_params,
+	.base = &iwl6000_g2_base,
 };
 
 #define IWL_DEVICE_6030						\
@@ -220,7 +220,7 @@ const char iwl130_bg_name[] = "Intel(R) Centrino(R) Wireless-N 130 BG";
 
 const struct iwl_mac_cfg iwl6000i_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_6000i,
-	.base_params = &iwl6000_base_params,
+	.base = &iwl6000_base,
 };
 
 /*
@@ -259,7 +259,7 @@ const char iwl6000i_2bg_name[] = "Intel(R) Centrino(R) Advanced-N 6200 BG";
 
 const struct iwl_mac_cfg iwl6050_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_6050,
-	.base_params = &iwl6050_base_params,
+	.base = &iwl6050_base,
 };
 
 #define IWL_DEVICE_6050						\
@@ -295,7 +295,7 @@ const char iwl6050_2abg_name[] = "Intel(R) Centrino(R) Advanced-N + WiMAX 6250 A
 
 const struct iwl_mac_cfg iwl6150_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_6150,
-	.base_params = &iwl6050_base_params,
+	.base = &iwl6050_base,
 };
 
 #define IWL_DEVICE_6150						\
@@ -329,7 +329,7 @@ const char iwl6150_bg_name[] = "Intel(R) Centrino(R) Wireless-N + WiMAX 6150 BG"
 
 const struct iwl_mac_cfg iwl6000_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_6000,
-	.base_params = &iwl6000_base_params,
+	.base = &iwl6000_base,
 };
 
 const struct iwl_cfg iwl6000_3agn_cfg = {
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
index f93453f159d8..6e4f6591000c 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
@@ -49,7 +49,7 @@
 #define IWL7265D_FW_PRE "iwlwifi-7265D"
 #define IWL7265D_MODULE_FIRMWARE(api) IWL7265D_FW_PRE "-" __stringify(api) ".ucode"
 
-static const struct iwl_base_params iwl7000_base_params = {
+static const struct iwl_family_base_params iwl7000_base = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_16K,
 	.num_of_queues = 31,
 	.max_tfd_queue_size = 256,
@@ -86,7 +86,7 @@ static const struct iwl_tt_params iwl7000_high_temp_tt_params = {
 
 const struct iwl_mac_cfg iwl7000_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_7000,
-	.base_params = &iwl7000_base_params,
+	.base = &iwl7000_base,
 };
 
 #define IWL_DEVICE_7000_COMMON					\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
index 337c35a36627..f8448b1541f1 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
@@ -35,7 +35,7 @@
 #define IWL8265_MODULE_FIRMWARE(api) \
 	IWL8265_FW_PRE "-" __stringify(api) ".ucode"
 
-static const struct iwl_base_params iwl8000_base_params = {
+static const struct iwl_family_base_params iwl8000_base = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
 	.num_of_queues = 31,
 	.max_tfd_queue_size = 256,
@@ -70,7 +70,7 @@ static const struct iwl_tt_params iwl8000_tt_params = {
 
 const struct iwl_mac_cfg iwl8000_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_8000,
-	.base_params = &iwl8000_base_params,
+	.base = &iwl8000_base,
 };
 
 #define IWL_DEVICE_8000_COMMON						\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index 7abe5f87ab34..15620d15a10e 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -33,7 +33,7 @@
 #define IWL9260_MODULE_FIRMWARE(api) \
 	IWL9260_FW_PRE "-" __stringify(api) ".ucode"
 
-static const struct iwl_base_params iwl9000_base_params = {
+static const struct iwl_family_base_params iwl9000_base = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
 	.num_of_queues = 31,
 	.max_tfd_queue_size = 256,
@@ -118,13 +118,13 @@ static const struct iwl_tt_params iwl9000_tt_params = {
 
 const struct iwl_mac_cfg iwl9000_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_9000,
-	.base_params = &iwl9000_base_params,
+	.base = &iwl9000_base,
 	.mq_rx_supported = true,
 };
 
 const struct iwl_mac_cfg iwl9560_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_9000,
-	.base_params = &iwl9000_base_params,
+	.base = &iwl9000_base,
 	.mq_rx_supported = true,
 	.integrated = true,
 	.xtal_latency = 650,
@@ -132,7 +132,7 @@ const struct iwl_mac_cfg iwl9560_mac_cfg = {
 
 const struct iwl_mac_cfg iwl9560_long_latency_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_9000,
-	.base_params = &iwl9000_base_params,
+	.base = &iwl9000_base,
 	.mq_rx_supported = true,
 	.integrated = true,
 	.xtal_latency = 2820,
@@ -140,7 +140,7 @@ const struct iwl_mac_cfg iwl9560_long_latency_mac_cfg = {
 
 const struct iwl_mac_cfg iwl9560_shared_clk_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_9000,
-	.base_params = &iwl9000_base_params,
+	.base = &iwl9000_base,
 	.mq_rx_supported = true,
 	.integrated = true,
 	.xtal_latency = 670,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 067252ef9c94..8c26cc90d0f0 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -47,7 +47,7 @@
 #define IWL_MA_B_HR_B_FW_MODULE_FIRMWARE(api)		\
 	IWL_MA_B_HR_B_FW_PRE "-" __stringify(api) ".ucode"
 
-static const struct iwl_base_params iwl_ax210_base_params = {
+static const struct iwl_family_base_params iwl_ax210_base = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
@@ -120,7 +120,7 @@ const struct iwl_mac_cfg iwl_so_mac_cfg = {
 	.mq_rx_supported = true,
 	.gen2 = true,
 	.device_family = IWL_DEVICE_FAMILY_AX210,
-	.base_params = &iwl_ax210_base_params,
+	.base = &iwl_ax210_base,
 	.umac_prph_offset = 0x300000,
 	.integrated = true,
 	/* TODO: the following values need to be checked */
@@ -132,7 +132,7 @@ const struct iwl_mac_cfg iwl_so_long_latency_mac_cfg = {
 	.mq_rx_supported = true,
 	.gen2 = true,
 	.device_family = IWL_DEVICE_FAMILY_AX210,
-	.base_params = &iwl_ax210_base_params,
+	.base = &iwl_ax210_base,
 	.umac_prph_offset = 0x300000,
 	.integrated = true,
 	.low_latency_xtal = true,
@@ -144,7 +144,7 @@ const struct iwl_mac_cfg iwl_so_long_latency_imr_mac_cfg = {
 	.mq_rx_supported = true,
 	.gen2 = true,
 	.device_family = IWL_DEVICE_FAMILY_AX210,
-	.base_params = &iwl_ax210_base_params,
+	.base = &iwl_ax210_base,
 	.umac_prph_offset = 0x300000,
 	.integrated = true,
 	.low_latency_xtal = true,
@@ -165,7 +165,7 @@ const struct iwl_mac_cfg iwl_so_long_latency_imr_mac_cfg = {
 
 const struct iwl_mac_cfg iwl_ma_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_AX210,
-	.base_params = &iwl_ax210_base_params,
+	.base = &iwl_ax210_base,
 	.mq_rx_supported = true,
 	.gen2 = true,
 	.integrated = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index a8fe9244a818..dd4952b11a33 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -43,7 +43,7 @@ const char iwl_ax211_name[] = "Intel(R) Wi-Fi 6E AX211 160MHz";
 const char iwl_ax201_name[] = "Intel(R) Wi-Fi 6 AX201 160MHz";
 #endif
 
-static const struct iwl_base_params iwl_bz_base_params = {
+static const struct iwl_family_base_params iwl_bz_base = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
@@ -125,7 +125,7 @@ static const struct iwl_base_params iwl_bz_base_params = {
 
 const struct iwl_mac_cfg iwl_bz_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_BZ,
-	.base_params = &iwl_bz_base_params,
+	.base = &iwl_bz_base,
 	.mq_rx_supported = true,
 	.gen2 = true,
 	.integrated = true,
@@ -137,7 +137,7 @@ const struct iwl_mac_cfg iwl_bz_mac_cfg = {
 
 const struct iwl_mac_cfg iwl_gl_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_BZ,
-	.base_params = &iwl_bz_base_params,
+	.base = &iwl_bz_base,
 	.mq_rx_supported = true,
 	.gen2 = true,
 	.umac_prph_offset = 0x300000,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index a258f49b8325..011b299045c4 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -36,7 +36,7 @@
 #define IWL_BR_A_PE_A_FW_MODULE_FIRMWARE(api) \
 	IWL_BR_A_PE_A_FW_PRE "-" __stringify(api) ".ucode"
 
-static const struct iwl_base_params iwl_dr_base_params = {
+static const struct iwl_family_base_params iwl_dr_base = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
@@ -121,7 +121,7 @@ static const struct iwl_base_params iwl_dr_base_params = {
 
 const struct iwl_mac_cfg iwl_dr_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_DR,
-	.base_params = &iwl_dr_base_params,
+	.base = &iwl_dr_base,
 	.mq_rx_supported = true,
 	.gen2 = true,
 	.integrated = true,
@@ -139,7 +139,7 @@ const struct iwl_cfg iwl_cfg_dr = {
 
 const struct iwl_mac_cfg iwl_br_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_DR,
-	.base_params = &iwl_dr_base_params,
+	.base = &iwl_dr_base,
 	.mq_rx_supported = true,
 	.gen2 = true,
 	.umac_prph_offset = 0x300000,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 4786a7714f6e..e5f780f4e73d 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -43,7 +43,7 @@
 #define IWL_SC_A_HR_B_FW_MODULE_FIRMWARE(api) \
 	IWL_SC_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
 
-static const struct iwl_base_params iwl_sc_base_params = {
+static const struct iwl_family_base_params iwl_sc_base = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
@@ -125,7 +125,7 @@ static const struct iwl_base_params iwl_sc_base_params = {
 
 const struct iwl_mac_cfg iwl_sc_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_SC,
-	.base_params = &iwl_sc_base_params,
+	.base = &iwl_sc_base,
 	.mq_rx_supported = true,
 	.gen2 = true,
 	.integrated = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c b/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
index 509b4d71e660..998f3053b3b0 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
@@ -781,7 +781,7 @@ static int iwl_init_otp_access(struct iwl_trans *trans)
 	 * CSR auto clock gate disable bit -
 	 * this is only applicable for HW with OTP shadow RAM
 	 */
-	if (trans->mac_cfg->base_params->shadow_ram_support)
+	if (trans->mac_cfg->base->shadow_ram_support)
 		iwl_set_bit(trans, CSR_DBG_LINK_PWR_MGMT_REG,
 			    CSR_RESET_LINK_PWR_MGMT_DISABLED);
 
@@ -902,7 +902,7 @@ static int iwl_find_otp_image(struct iwl_trans *trans,
 		}
 		/* more in the link list, continue */
 		usedblocks++;
-	} while (usedblocks <= trans->mac_cfg->base_params->max_ll_items);
+	} while (usedblocks <= trans->mac_cfg->base->max_ll_items);
 
 	/* OTP has no valid blocks */
 	IWL_DEBUG_EEPROM(trans->dev, "OTP has no valid blocks\n");
@@ -935,7 +935,7 @@ int iwl_read_eeprom(struct iwl_trans *trans, u8 **eeprom, size_t *eeprom_size)
 	if (nvm_is_otp < 0)
 		return nvm_is_otp;
 
-	sz = trans->mac_cfg->base_params->eeprom_size;
+	sz = trans->mac_cfg->base->eeprom_size;
 	IWL_DEBUG_EEPROM(trans->dev, "NVM size = %d\n", sz);
 
 	e = kmalloc(sz, GFP_KERNEL);
@@ -970,7 +970,7 @@ int iwl_read_eeprom(struct iwl_trans *trans, u8 **eeprom, size_t *eeprom_size)
 			    CSR_OTP_GP_REG_ECC_CORR_STATUS_MSK |
 			    CSR_OTP_GP_REG_ECC_UNCORR_STATUS_MSK);
 		/* traversing the linked list if no shadow ram supported */
-		if (!trans->mac_cfg->base_params->shadow_ram_support) {
+		if (!trans->mac_cfg->base->shadow_ram_support) {
 			ret = iwl_find_otp_image(trans, &validblockaddr);
 			if (ret)
 				goto err_unlock;
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/led.c b/drivers/net/wireless/intel/iwlwifi/dvm/led.c
index 2b02c717173e..cec2ebdfd651 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/led.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/led.c
@@ -116,9 +116,9 @@ static int iwl_led_cmd(struct iwl_priv *priv,
 	}
 
 	led_cmd.on = iwl_blink_compensation(priv, on,
-				priv->trans->mac_cfg->base_params->led_compensation);
+				priv->trans->mac_cfg->base->led_compensation);
 	led_cmd.off = iwl_blink_compensation(priv, off,
-				priv->trans->mac_cfg->base_params->led_compensation);
+				priv->trans->mac_cfg->base->led_compensation);
 
 	ret = iwl_send_led_cmd(priv, &led_cmd);
 	if (!ret) {
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
index 7e5c8df67850..0771a46bd552 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
@@ -1091,7 +1091,7 @@ static void iwlagn_mac_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		goto done;
 	}
 
-	scd_queues = BIT(priv->trans->mac_cfg->base_params->num_of_queues) - 1;
+	scd_queues = BIT(priv->trans->mac_cfg->base->num_of_queues) - 1;
 	scd_queues &= ~(BIT(IWL_IPAN_CMD_QUEUE_NUM) |
 			BIT(IWL_DEFAULT_CMD_QUEUE_NUM));
 
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index 44c6946f1c20..68656706ce34 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1339,7 +1339,7 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 					    driver_data[2]);
 
 	WARN_ON(sizeof(priv->transport_queue_stop) * BITS_PER_BYTE <
-		priv->trans->mac_cfg->base_params->num_of_queues);
+		priv->trans->mac_cfg->base->num_of_queues);
 
 	ucode_flags = fw->ucode_capa.flags;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/power.c b/drivers/net/wireless/intel/iwlwifi/dvm/power.c
index 8cd3931af2ec..6b42d6e5f30f 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/power.c
@@ -196,7 +196,7 @@ static void iwl_static_sleep_cmd(struct iwl_priv *priv,
 	else
 		cmd->flags &= ~IWL_POWER_SLEEP_OVER_DTIM_MSK;
 
-	if (priv->trans->mac_cfg->base_params->shadow_reg_enable)
+	if (priv->trans->mac_cfg->base->shadow_reg_enable)
 		cmd->flags |= IWL_POWER_SHADOW_REG_ENA;
 	else
 		cmd->flags &= ~IWL_POWER_SHADOW_REG_ENA;
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/tx.c b/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
index e6f6b22bf259..24fefa0e8148 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
@@ -463,7 +463,7 @@ static int iwlagn_alloc_agg_txq(struct iwl_priv *priv, int mq)
 	int q;
 
 	for (q = IWLAGN_FIRST_AMPDU_QUEUE;
-	     q < priv->trans->mac_cfg->base_params->num_of_queues; q++) {
+	     q < priv->trans->mac_cfg->base->num_of_queues; q++) {
 		if (!test_and_set_bit(q, priv->agg_q_alloc)) {
 			priv->queue_to_mac80211[q] = mq;
 			return q;
@@ -1277,7 +1277,7 @@ void iwlagn_rx_reply_compressed_ba(struct iwl_priv *priv,
 	 * (in Tx queue's circular buffer) of first TFD/frame in window */
 	u16 ba_resp_scd_ssn = le16_to_cpu(ba_resp->scd_ssn);
 
-	if (scd_flow >= priv->trans->mac_cfg->base_params->num_of_queues) {
+	if (scd_flow >= priv->trans->mac_cfg->base->num_of_queues) {
 		IWL_ERR(priv,
 			"BUG_ON scd_flow is bigger than number of queues\n");
 		return;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index dfbca1ac34a4..9e62df8a7e16 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -115,7 +115,7 @@ static inline u8 num_of_ant(u8 mask)
 }
 
 /**
- * struct iwl_base_params - params not likely to change within a device family
+ * struct iwl_family_base_params - base parameters for an entire family
  * @max_ll_items: max number of OTP blocks
  * @shadow_ram_support: shadow support for OTP memory
  * @led_compensation: compensate on the led on/off time per HW according
@@ -128,8 +128,12 @@ static inline u8 num_of_ant(u8 mask)
  *	is in flight. This is due to a HW bug in 7260, 3160 and 7265.
  * @scd_chain_ext_wa: should the chain extension feature in SCD be disabled.
  * @max_tfd_queue_size: max number of entries in tfd queue.
+ * @eeprom_size: EEPROM size
+ * @num_of_queues: number of HW TX queues supported
+ * @pcie_l1_allowed: PCIe L1 state is allowed
+ * @pll_cfg: PLL configuration needed
  */
-struct iwl_base_params {
+struct iwl_family_base_params {
 	unsigned int wd_timeout;
 
 	u16 eeprom_size;
@@ -253,7 +257,7 @@ enum iwl_mac_cfg_ltr_delay {
  * used, among other things, to boot the NIC so that the HW REV or
  * RFID can be read before deciding the remaining parameters to use.
  *
- * @base_params: pointer to basic parameters
+ * @base: pointer to basic parameters
  * @device_family: the device family
  * @umac_prph_offset: offset to add to UMAC periphery address
  * @xtal_latency: power up latency to get the xtal stabilized
@@ -267,7 +271,7 @@ enum iwl_mac_cfg_ltr_delay {
  * @imr_enabled: use the IMR if supported.
  */
 struct iwl_mac_cfg {
-	const struct iwl_base_params *base_params;
+	const struct iwl_family_base_params *base;
 	enum iwl_device_family device_family;
 	u32 umac_prph_offset;
 	u32 xtal_latency;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 186c0a2d4772..d300b7a12ed7 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1755,14 +1755,14 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
 		fw->init_evtlog_size = (pieces->init_evtlog_size - 16)/12;
 	else
 		fw->init_evtlog_size =
-			drv->trans->mac_cfg->base_params->max_event_log_size;
+			drv->trans->mac_cfg->base->max_event_log_size;
 	fw->init_errlog_ptr = pieces->init_errlog_ptr;
 	fw->inst_evtlog_ptr = pieces->inst_evtlog_ptr;
 	if (pieces->inst_evtlog_size)
 		fw->inst_evtlog_size = (pieces->inst_evtlog_size - 16)/12;
 	else
 		fw->inst_evtlog_size =
-			drv->trans->mac_cfg->base_params->max_event_log_size;
+			drv->trans->mac_cfg->base->max_event_log_size;
 	fw->inst_errlog_ptr = pieces->inst_errlog_ptr;
 
 	/*
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index 41b465ace6fa..b72fa6498c52 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -76,7 +76,7 @@ static int iwl_mld_allocate_txq(struct iwl_mld *mld, struct ieee80211_txq *txq)
 	 */
 	unsigned int watchdog_timeout = txq->vif->type == NL80211_IFTYPE_AP ?
 				IWL_WATCHDOG_DISABLED :
-				mld->trans->mac_cfg->base_params->wd_timeout;
+				mld->trans->mac_cfg->base->wd_timeout;
 	int queue, size;
 
 	lockdep_assert_wiphy(mld->wiphy);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index b810fd167046..e1010521c3ea 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -148,7 +148,7 @@ int iwl_mvm_mld_add_int_sta_with_queue(struct iwl_mvm *mvm,
 {
 	int ret, txq;
 	unsigned int wdg_timeout = _wdg_timeout ? *_wdg_timeout :
-		mvm->trans->mac_cfg->base_params->wd_timeout;
+		mvm->trans->mac_cfg->base->wd_timeout;
 
 	if (WARN_ON_ONCE(sta->sta_id == IWL_INVALID_STA))
 		return -ENOSPC;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 96eb29698a6b..434d34b21928 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2457,7 +2457,7 @@ void iwl_mvm_vif_set_low_latency(struct iwl_mvm_vif *mvmvif, bool set,
  */
 static inline u32 iwl_mvm_flushable_queues(struct iwl_mvm *mvm)
 {
-	return ((BIT(mvm->trans->mac_cfg->base_params->num_of_queues) - 1) &
+	return ((BIT(mvm->trans->mac_cfg->base->num_of_queues) - 1) &
 		~BIT(IWL_MVM_DQA_CMD_QUEUE));
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
index 9e4a70a21f47..74ee15f77baf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -191,7 +191,7 @@ static int iwl_nvm_read_section(struct iwl_mvm *mvm, u16 section,
 	while (ret == length) {
 		/* Check no memory assumptions fail and cause an overflow */
 		if ((size_read + offset + length) >
-		    mvm->trans->mac_cfg->base_params->eeprom_size) {
+		    mvm->trans->mac_cfg->base->eeprom_size) {
 			IWL_ERR(mvm, "EEPROM size is too small for NVM\n");
 			return -ENOBUFS;
 		}
@@ -316,7 +316,7 @@ int iwl_nvm_init(struct iwl_mvm *mvm)
 	/* Read From FW NVM */
 	IWL_DEBUG_EEPROM(mvm->trans->dev, "Read from NVM\n");
 
-	nvm_buffer = kmalloc(mvm->trans->mac_cfg->base_params->eeprom_size,
+	nvm_buffer = kmalloc(mvm->trans->mac_cfg->base->eeprom_size,
 			     GFP_KERNEL);
 	if (!nvm_buffer)
 		return -ENOMEM;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 5393e98d2a08..a5190e091bad 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -791,10 +791,10 @@ static int iwl_mvm_find_free_queue(struct iwl_mvm *mvm, u8 sta_id,
 
 	lockdep_assert_held(&mvm->mutex);
 
-	if (WARN(maxq >= mvm->trans->mac_cfg->base_params->num_of_queues,
+	if (WARN(maxq >= mvm->trans->mac_cfg->base->num_of_queues,
 		 "max queue %d >= num_of_queues (%d)", maxq,
-		 mvm->trans->mac_cfg->base_params->num_of_queues))
-		maxq = mvm->trans->mac_cfg->base_params->num_of_queues - 1;
+		 mvm->trans->mac_cfg->base->num_of_queues))
+		maxq = mvm->trans->mac_cfg->base->num_of_queues - 1;
 
 	/* This should not be hit with new TX path */
 	if (WARN_ON(iwl_mvm_has_new_tx_api(mvm)))
@@ -2189,7 +2189,7 @@ static void iwl_mvm_enable_aux_snif_queue(struct iwl_mvm *mvm, u16 queue,
 					  u8 sta_id, u8 fifo)
 {
 	unsigned int wdg_timeout =
-		mvm->trans->mac_cfg->base_params->wd_timeout;
+		mvm->trans->mac_cfg->base->wd_timeout;
 	struct iwl_trans_txq_scd_cfg cfg = {
 		.fifo = fifo,
 		.sta_id = sta_id,
@@ -2206,7 +2206,7 @@ static void iwl_mvm_enable_aux_snif_queue(struct iwl_mvm *mvm, u16 queue,
 static int iwl_mvm_enable_aux_snif_queue_tvqm(struct iwl_mvm *mvm, u8 sta_id)
 {
 	unsigned int wdg_timeout =
-		mvm->trans->mac_cfg->base_params->wd_timeout;
+		mvm->trans->mac_cfg->base->wd_timeout;
 
 	WARN_ON(!iwl_mvm_has_new_tx_api(mvm));
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 2deda1dbd64f..9e0db3a750aa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -742,7 +742,7 @@ unsigned int iwl_mvm_get_wd_timeout(struct iwl_mvm *mvm,
 				    struct ieee80211_vif *vif)
 {
 	unsigned int default_timeout =
-		mvm->trans->mac_cfg->base_params->wd_timeout;
+		mvm->trans->mac_cfg->base->wd_timeout;
 
 	/*
 	 * We can't know when the station is asleep or awake, so we
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 9eb80b014cee..56b4042edbc2 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -702,7 +702,7 @@ static inline void iwl_txq_stop(struct iwl_trans *trans, struct iwl_txq *txq)
 static inline int iwl_txq_inc_wrap(struct iwl_trans *trans, int index)
 {
 	return ++index &
-		(trans->mac_cfg->base_params->max_tfd_queue_size - 1);
+		(trans->mac_cfg->base->max_tfd_queue_size - 1);
 }
 
 /**
@@ -713,7 +713,7 @@ static inline int iwl_txq_inc_wrap(struct iwl_trans *trans, int index)
 static inline int iwl_txq_dec_wrap(struct iwl_trans *trans, int index)
 {
 	return --index &
-		(trans->mac_cfg->base_params->max_tfd_queue_size - 1);
+		(trans->mac_cfg->base->max_tfd_queue_size - 1);
 }
 
 void iwl_txq_log_scd_error(struct iwl_trans *trans, struct iwl_txq *txq);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 919e4c3b1880..0f408b94f145 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -176,7 +176,7 @@ static void iwl_pcie_rxq_inc_wr_ptr(struct iwl_trans *trans,
 	 * 1. shadow registers aren't enabled
 	 * 2. there is a chance that the NIC is asleep
 	 */
-	if (!trans->mac_cfg->base_params->shadow_reg_enable &&
+	if (!trans->mac_cfg->base->shadow_reg_enable &&
 	    test_bit(STATUS_TPOWER_PMI, &trans->status)) {
 		reg = iwl_read32(trans, CSR_UCODE_DRV_GP1);
 
@@ -1694,7 +1694,7 @@ static void iwl_pcie_irq_handle_error(struct iwl_trans *trans)
 		return;
 	}
 
-	for (i = 0; i < trans->mac_cfg->base_params->num_of_queues; i++) {
+	for (i = 0; i < trans->mac_cfg->base->num_of_queues; i++) {
 		if (!trans_pcie->txqs.txq[i])
 			continue;
 		timer_delete(&trans_pcie->txqs.txq[i]->stuck_timer);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 945cd2455be1..850952461b2b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -317,7 +317,7 @@ static int iwl_pcie_apm_init(struct iwl_trans *trans)
 	iwl_pcie_apm_config(trans);
 
 	/* Configure analog phase-lock-loop before activating to D0A */
-	if (trans->mac_cfg->base_params->pll_cfg)
+	if (trans->mac_cfg->base->pll_cfg)
 		iwl_set_bit(trans, CSR_ANA_PLL_CFG, CSR50_ANA_PLL_CFG_VAL);
 
 	ret = iwl_finish_nic_init(trans);
@@ -565,7 +565,7 @@ static int iwl_pcie_nic_init(struct iwl_trans *trans)
 		return -ENOMEM;
 	}
 
-	if (trans->mac_cfg->base_params->shadow_reg_enable) {
+	if (trans->mac_cfg->base->shadow_reg_enable) {
 		/* enable shadow regs in HW */
 		iwl_set_bit(trans, CSR_MAC_SHADOW_REG_CTRL, 0x800FFFFF);
 		IWL_DEBUG_INFO(trans, "Enabling shadow registers in device\n");
@@ -2672,7 +2672,7 @@ int iwl_trans_pcie_wait_txqs_empty(struct iwl_trans *trans, u32 txq_bm)
 
 	/* waiting for all the tx frames complete might take a while */
 	for (cnt = 0;
-	     cnt < trans->mac_cfg->base_params->num_of_queues;
+	     cnt < trans->mac_cfg->base->num_of_queues;
 	     cnt++) {
 
 		if (cnt == trans->conf.cmd_queue)
@@ -2816,7 +2816,7 @@ static void *iwl_dbgfs_tx_queue_seq_start(struct seq_file *seq, loff_t *pos)
 	struct iwl_dbgfs_tx_queue_priv *priv = seq->private;
 	struct iwl_dbgfs_tx_queue_state *state;
 
-	if (*pos >= priv->trans->mac_cfg->base_params->num_of_queues)
+	if (*pos >= priv->trans->mac_cfg->base->num_of_queues)
 		return NULL;
 
 	state = kmalloc(sizeof(*state), GFP_KERNEL);
@@ -2834,7 +2834,7 @@ static void *iwl_dbgfs_tx_queue_seq_next(struct seq_file *seq,
 
 	*pos = ++state->pos;
 
-	if (*pos >= priv->trans->mac_cfg->base_params->num_of_queues)
+	if (*pos >= priv->trans->mac_cfg->base->num_of_queues)
 		return NULL;
 
 	return state;
@@ -3892,7 +3892,7 @@ iwl_trans_pcie_alloc(struct pci_dev *pdev,
 
 	trans_pcie->debug_rfkill = -1;
 
-	if (!mac_cfg->base_params->pcie_l1_allowed) {
+	if (!mac_cfg->base->pcie_l1_allowed) {
 		/*
 		 * W/A - seems to solve weird behavior. We need to remove this
 		 * if we don't want to stay in L1 all the time. This wastes a
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 3fbb7dcee7c6..ceb730baa494 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -535,17 +535,17 @@ int iwl_txq_space(struct iwl_trans *trans, const struct iwl_txq *q)
 	 * If q->n_window is smaller than max_tfd_queue_size, there is no need
 	 * to reserve any queue entries for this purpose.
 	 */
-	if (q->n_window < trans->mac_cfg->base_params->max_tfd_queue_size)
+	if (q->n_window < trans->mac_cfg->base->max_tfd_queue_size)
 		max = q->n_window;
 	else
-		max = trans->mac_cfg->base_params->max_tfd_queue_size - 1;
+		max = trans->mac_cfg->base->max_tfd_queue_size - 1;
 
 	/*
 	 * max_tfd_queue_size is a power of 2, so the following is equivalent to
 	 * modulo by max_tfd_queue_size and is well defined.
 	 */
 	used = (q->write_ptr - q->read_ptr) &
-		(trans->mac_cfg->base_params->max_tfd_queue_size - 1);
+		(trans->mac_cfg->base->max_tfd_queue_size - 1);
 
 	if (WARN_ON(used > max))
 		return 0;
@@ -1002,7 +1002,7 @@ static int iwl_pcie_txq_alloc_response(struct iwl_trans *trans,
 
 	txq->id = qid;
 	trans_pcie->txqs.txq[qid] = txq;
-	wr_ptr &= (trans->mac_cfg->base_params->max_tfd_queue_size - 1);
+	wr_ptr &= (trans->mac_cfg->base->max_tfd_queue_size - 1);
 
 	/* Place first TFD at index corresponding to start sequence number */
 	txq->read_ptr = wr_ptr;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 3cc47e648492..b6d48fff9c0e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -89,7 +89,7 @@ static void iwl_pcie_txq_inc_wr_ptr(struct iwl_trans *trans,
 	 * 2. NIC is woken up for CMD regardless of shadow outside this function
 	 * 3. there is a chance that the NIC is asleep
 	 */
-	if (!trans->mac_cfg->base_params->shadow_reg_enable &&
+	if (!trans->mac_cfg->base->shadow_reg_enable &&
 	    txq_id != trans->conf.cmd_queue &&
 	    test_bit(STATUS_TPOWER_PMI, &trans->status)) {
 		/*
@@ -124,7 +124,7 @@ void iwl_pcie_txq_check_wrptrs(struct iwl_trans *trans)
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int i;
 
-	for (i = 0; i < trans->mac_cfg->base_params->num_of_queues; i++) {
+	for (i = 0; i < trans->mac_cfg->base->num_of_queues; i++) {
 		struct iwl_txq *txq = trans_pcie->txqs.txq[i];
 
 		if (!test_bit(i, trans_pcie->txqs.queue_used))
@@ -192,7 +192,7 @@ static void iwl_pcie_clear_cmd_in_flight(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
-	if (!trans->mac_cfg->base_params->apmg_wake_up_wa)
+	if (!trans->mac_cfg->base->apmg_wake_up_wa)
 		return;
 
 	spin_lock(&trans_pcie->reg_lock);
@@ -456,7 +456,7 @@ static void iwl_pcie_txq_free(struct iwl_trans *trans, int txq_id)
 	if (txq->tfds) {
 		dma_free_coherent(dev,
 				  trans_pcie->txqs.tfd.size *
-				  trans->mac_cfg->base_params->max_tfd_queue_size,
+				  trans->mac_cfg->base->max_tfd_queue_size,
 				  txq->tfds, txq->dma_addr);
 		txq->dma_addr = 0;
 		txq->tfds = NULL;
@@ -478,7 +478,7 @@ static void iwl_pcie_txq_free(struct iwl_trans *trans, int txq_id)
 void iwl_pcie_tx_start(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	int nq = trans->mac_cfg->base_params->num_of_queues;
+	int nq = trans->mac_cfg->base->num_of_queues;
 	int chan;
 	u32 reg_val;
 	int clear_dwords = (SCD_TRANS_TBL_OFFSET_QUEUE(nq) -
@@ -504,7 +504,7 @@ void iwl_pcie_tx_start(struct iwl_trans *trans)
 	/* The chain extension of the SCD doesn't work well. This feature is
 	 * enabled by default by the HW, so we need to disable it manually.
 	 */
-	if (trans->mac_cfg->base_params->scd_chain_ext_wa)
+	if (trans->mac_cfg->base->scd_chain_ext_wa)
 		iwl_write_prph(trans, SCD_CHAINEXT_EN, 0);
 
 	iwl_trans_ac_txq_enable(trans, trans->conf.cmd_queue,
@@ -543,7 +543,7 @@ void iwl_trans_pcie_tx_reset(struct iwl_trans *trans)
 	if (WARN_ON_ONCE(trans->mac_cfg->gen2))
 		return;
 
-	for (txq_id = 0; txq_id < trans->mac_cfg->base_params->num_of_queues;
+	for (txq_id = 0; txq_id < trans->mac_cfg->base->num_of_queues;
 	     txq_id++) {
 		struct iwl_txq *txq = trans_pcie->txqs.txq[txq_id];
 		if (trans->mac_cfg->gen2)
@@ -630,7 +630,7 @@ int iwl_pcie_tx_stop(struct iwl_trans *trans)
 		return 0;
 
 	/* Unmap DMA from host system and free skb's */
-	for (txq_id = 0; txq_id < trans->mac_cfg->base_params->num_of_queues;
+	for (txq_id = 0; txq_id < trans->mac_cfg->base->num_of_queues;
 	     txq_id++)
 		iwl_pcie_txq_unmap(trans, txq_id);
 
@@ -653,7 +653,7 @@ void iwl_pcie_tx_free(struct iwl_trans *trans)
 	/* Tx queues */
 	if (trans_pcie->txq_memory) {
 		for (txq_id = 0;
-		     txq_id < trans->mac_cfg->base_params->num_of_queues;
+		     txq_id < trans->mac_cfg->base->num_of_queues;
 		     txq_id++) {
 			iwl_pcie_txq_free(trans, txq_id);
 			trans_pcie->txqs.txq[txq_id] = NULL;
@@ -692,9 +692,9 @@ void iwl_txq_log_scd_error(struct iwl_trans *trans, struct iwl_txq *txq)
 		jiffies_to_msecs(txq->wd_timeout),
 		txq->read_ptr, txq->write_ptr,
 		iwl_read_prph(trans, SCD_QUEUE_RDPTR(txq_id)) &
-			(trans->mac_cfg->base_params->max_tfd_queue_size - 1),
+			(trans->mac_cfg->base->max_tfd_queue_size - 1),
 			iwl_read_prph(trans, SCD_QUEUE_WRPTR(txq_id)) &
-			(trans->mac_cfg->base_params->max_tfd_queue_size - 1),
+			(trans->mac_cfg->base->max_tfd_queue_size - 1),
 			iwl_read_direct32(trans, FH_TX_TRB_REG(fifo)));
 }
 
@@ -721,7 +721,7 @@ int iwl_pcie_txq_alloc(struct iwl_trans *trans, struct iwl_txq *txq,
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	size_t num_entries = trans->mac_cfg->gen2 ?
-		slots_num : trans->mac_cfg->base_params->max_tfd_queue_size;
+		slots_num : trans->mac_cfg->base->max_tfd_queue_size;
 	size_t tfd_sz;
 	size_t tb0_buf_sz;
 	int i;
@@ -805,7 +805,7 @@ static int iwl_pcie_tx_alloc(struct iwl_trans *trans)
 	int ret;
 	int txq_id, slots_num;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	u16 bc_tbls_size = trans->mac_cfg->base_params->num_of_queues;
+	u16 bc_tbls_size = trans->mac_cfg->base->num_of_queues;
 
 	if (WARN_ON(trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210))
 		return -EINVAL;
@@ -834,7 +834,7 @@ static int iwl_pcie_tx_alloc(struct iwl_trans *trans)
 	}
 
 	trans_pcie->txq_memory =
-		kcalloc(trans->mac_cfg->base_params->num_of_queues,
+		kcalloc(trans->mac_cfg->base->num_of_queues,
 			sizeof(struct iwl_txq), GFP_KERNEL);
 	if (!trans_pcie->txq_memory) {
 		IWL_ERR(trans, "Not enough memory for txq\n");
@@ -843,7 +843,7 @@ static int iwl_pcie_tx_alloc(struct iwl_trans *trans)
 	}
 
 	/* Alloc and init all Tx queues, including the command queue (#4/#9) */
-	for (txq_id = 0; txq_id < trans->mac_cfg->base_params->num_of_queues;
+	for (txq_id = 0; txq_id < trans->mac_cfg->base->num_of_queues;
 	     txq_id++) {
 		bool cmd_queue = (txq_id == trans->conf.cmd_queue);
 
@@ -902,7 +902,7 @@ int iwl_txq_init(struct iwl_trans *trans, struct iwl_txq *txq,
 		 int slots_num, bool cmd_queue)
 {
 	u32 tfd_queue_max_size =
-		trans->mac_cfg->base_params->max_tfd_queue_size;
+		trans->mac_cfg->base->max_tfd_queue_size;
 	int ret;
 
 	txq->need_update = false;
@@ -960,7 +960,7 @@ int iwl_pcie_tx_init(struct iwl_trans *trans)
 	spin_unlock_bh(&trans_pcie->irq_lock);
 
 	/* Alloc and init all Tx queues, including the command queue (#4/#9) */
-	for (txq_id = 0; txq_id < trans->mac_cfg->base_params->num_of_queues;
+	for (txq_id = 0; txq_id < trans->mac_cfg->base->num_of_queues;
 	     txq_id++) {
 		bool cmd_queue = (txq_id == trans->conf.cmd_queue);
 
@@ -988,7 +988,7 @@ int iwl_pcie_tx_init(struct iwl_trans *trans)
 	}
 
 	iwl_set_bits_prph(trans, SCD_GP_CTRL, SCD_GP_CTRL_AUTO_ACTIVE_MODE);
-	if (trans->mac_cfg->base_params->num_of_queues > 20)
+	if (trans->mac_cfg->base->num_of_queues > 20)
 		iwl_set_bits_prph(trans, SCD_GP_CTRL,
 				  SCD_GP_CTRL_ENABLE_31_QUEUES);
 
@@ -1009,7 +1009,7 @@ static int iwl_pcie_set_cmd_in_flight(struct iwl_trans *trans,
 	if (test_bit(STATUS_TRANS_DEAD, &trans->status))
 		return -ENODEV;
 
-	if (!trans->mac_cfg->base_params->apmg_wake_up_wa)
+	if (!trans->mac_cfg->base->apmg_wake_up_wa)
 		return 0;
 
 	/*
@@ -1087,12 +1087,12 @@ static void iwl_pcie_cmdq_reclaim(struct iwl_trans *trans, int txq_id, int idx)
 	idx = iwl_txq_get_cmd_index(txq, idx);
 	r = iwl_txq_get_cmd_index(txq, txq->read_ptr);
 
-	if (idx >= trans->mac_cfg->base_params->max_tfd_queue_size ||
+	if (idx >= trans->mac_cfg->base->max_tfd_queue_size ||
 	    (!iwl_txq_used(txq, idx, txq->read_ptr, txq->write_ptr))) {
 		WARN_ONCE(test_bit(txq_id, trans_pcie->txqs.queue_used),
 			  "%s: Read index for DMA queue txq id (%d), index %d is out of range [0-%d] %d %d.\n",
 			  __func__, txq_id, idx,
-			  trans->mac_cfg->base_params->max_tfd_queue_size,
+			  trans->mac_cfg->base->max_tfd_queue_size,
 			  txq->write_ptr, txq->read_ptr);
 		return;
 	}
@@ -1308,7 +1308,7 @@ static void iwl_trans_pcie_block_txq_ptrs(struct iwl_trans *trans, bool block)
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int i;
 
-	for (i = 0; i < trans->mac_cfg->base_params->num_of_queues; i++) {
+	for (i = 0; i < trans->mac_cfg->base->num_of_queues; i++) {
 		struct iwl_txq *txq = trans_pcie->txqs.txq[i];
 
 		if (i == trans->conf.cmd_queue)
@@ -2385,7 +2385,7 @@ void iwl_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 		IWL_ERR(trans,
 			"%s: Read index for txq id (%d), last_to_free %d is out of range [0-%d] %d %d.\n",
 			__func__, txq_id, last_to_free,
-			trans->mac_cfg->base_params->max_tfd_queue_size,
+			trans->mac_cfg->base->max_tfd_queue_size,
 			txq_write_ptr, txq_read_ptr);
 
 		iwl_op_mode_time_point(trans->op_mode,
-- 
2.34.1


