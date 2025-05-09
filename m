Return-Path: <linux-wireless+bounces-22779-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD66AB1107
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 12:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D8597B35D0
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 10:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37F5227E92;
	Fri,  9 May 2025 10:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SjxoUn1e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26D828FAA8
	for <linux-wireless@vger.kernel.org>; Fri,  9 May 2025 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787523; cv=none; b=iDBGRfUFqzPGXRU9JFv2qE2fuOe/q3GfJ1MA1q2nbVh8QoBMnvHs5irDMFqUZXiCo30xY1FgwinPS4hYBzXNhkhZbS11FzD5gwKqG5UySwfHm+Th0MsRdyCibOEeYKTdOSsdCZveHlRDS8XE7tX506b+KhKQl32zJuDgI2FwWro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787523; c=relaxed/simple;
	bh=UMPz1st017Jk1ib3cdOPqLjjjVYV7EC0MryF+kqXQ7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DFK7iUvOlMTmYpNHiBopVJBT12CryxMdaF3+jA6tb2GGlaC629vOkbeKwgY9vNtXRb1YNdTPGrIM0VcyrYKS0NTBnbJYUkjE1fn5E7dsHBVHI4+Efzz+tMm6xugtKyoSqRhaRzz32IB6AEEEEwW68si04TllevTC4UomkiVChXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SjxoUn1e; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746787521; x=1778323521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UMPz1st017Jk1ib3cdOPqLjjjVYV7EC0MryF+kqXQ7k=;
  b=SjxoUn1e8eG1Arb3Y/4/JmcM4nuS5ajuQuDxSRAIvbX0vX3a5+zbsvLx
   uMo3SQ40Y3Sbon3htzHDoIXSgqtkzlRGri2mcas32I90Rtbyyo1Pjf9do
   OuFJPDu15mxtWfA7D6n+DCMsGUg14qNO6b9Rw7lSslm79pq5qq65xrb5f
   l7OT25ZuamSW/UKeiNdDbJEbfr1NLMtEj/OekKycJzC+JoG51GnHD6qJ0
   6h2hUFX84ccXT3h7twAK8STfP2lvUWkg3htdfZusNf5etjeWfT5GIxroC
   KazWWerxWmmDAcMAALDXaEOUIEKD6uj5/KCG15MvYgl5kXA19lMafSGpW
   A==;
X-CSE-ConnectionGUID: Xm8DwCPVRV+acxZ7oM4vgA==
X-CSE-MsgGUID: hqGCN87QRni7/RI5ctFb5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59239898"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="59239898"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:45:19 -0700
X-CSE-ConnectionGUID: YJsJTPLaTjyhK6YWvrcXVg==
X-CSE-MsgGUID: YEJi8N2ASICPvqdPJOTAoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="136537038"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:45:18 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: rename iwl_cfg to iwl_rf_cfg
Date: Fri,  9 May 2025 13:44:47 +0300
Message-Id: <20250509104454.2582160-9-miriam.rachel.korenblit@intel.com>
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

With all the cleanups now, we can rename the structure to
better indicate the functionality. For older devices this
isn't quite accurate, of course, but it's better to have a
name that reflects future use for maintenance.

Add some kernel-doc while at it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250509134302.f63a2e4a516e.Id23f637024f17a371d9c8194f6e1c9cbec805b4d@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/1000.c |   8 +-
 drivers/net/wireless/intel/iwlwifi/cfg/2000.c |   8 +-
 drivers/net/wireless/intel/iwlwifi/cfg/5000.c |  12 +-
 drivers/net/wireless/intel/iwlwifi/cfg/6000.c |  28 ++---
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c |  14 +--
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c |   4 +-
 .../net/wireless/intel/iwlwifi/cfg/rf-fm.c    |   4 +-
 .../net/wireless/intel/iwlwifi/cfg/rf-gf.c    |   2 +-
 .../net/wireless/intel/iwlwifi/cfg/rf-hr.c    |   6 +-
 .../net/wireless/intel/iwlwifi/cfg/rf-jf.c    |   4 +-
 drivers/net/wireless/intel/iwlwifi/dvm/agn.h  |   4 +-
 drivers/net/wireless/intel/iwlwifi/dvm/dev.h  |   3 +-
 .../net/wireless/intel/iwlwifi/dvm/eeprom.c   |   8 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |   2 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   | 104 +++++++++---------
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h  |   4 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  30 ++---
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    |   4 +-
 .../wireless/intel/iwlwifi/iwl-nvm-utils.c    |   2 +-
 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  |   4 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |   4 +-
 .../wireless/intel/iwlwifi/mld/tests/utils.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   2 +-
 .../wireless/intel/iwlwifi/tests/devinfo.c    |   4 +-
 28 files changed, 141 insertions(+), 138 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/1000.c b/drivers/net/wireless/intel/iwlwifi/cfg/1000.c
index f40fea33e69b..c029e595e7c2 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/1000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/1000.c
@@ -70,7 +70,7 @@ const struct iwl_mac_cfg iwl1000_mac_cfg = {
 	.eeprom_params = &iwl1000_eeprom_params,		\
 	.led_mode = IWL_LED_BLINK
 
-const struct iwl_cfg iwl1000_bgn_cfg = {
+const struct iwl_rf_cfg iwl1000_bgn_cfg = {
 	IWL_DEVICE_1000,
 	.ht_params = {
 		.ht_greenfield_support = true,
@@ -81,7 +81,7 @@ const struct iwl_cfg iwl1000_bgn_cfg = {
 
 const char iwl1000_bgn_name[] = "Intel(R) Centrino(R) Wireless-N 1000 BGN";
 
-const struct iwl_cfg iwl1000_bg_cfg = {
+const struct iwl_rf_cfg iwl1000_bg_cfg = {
 	IWL_DEVICE_1000,
 };
 
@@ -99,7 +99,7 @@ const char iwl1000_bg_name[] = "Intel(R) Centrino(R) Wireless-N 1000 BG";
 	.led_mode = IWL_LED_RF_STATE,				\
 	.rx_with_siso_diversity = true
 
-const struct iwl_cfg iwl100_bgn_cfg = {
+const struct iwl_rf_cfg iwl100_bgn_cfg = {
 	IWL_DEVICE_100,
 	.ht_params = {
 		.ht_greenfield_support = true,
@@ -110,7 +110,7 @@ const struct iwl_cfg iwl100_bgn_cfg = {
 
 const char iwl100_bgn_name[] = "Intel(R) Centrino(R) Wireless-N 100 BGN";
 
-const struct iwl_cfg iwl100_bg_cfg = {
+const struct iwl_rf_cfg iwl100_bg_cfg = {
 	IWL_DEVICE_100,
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/2000.c b/drivers/net/wireless/intel/iwlwifi/cfg/2000.c
index 33f04c9d05d6..47554a5f406e 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/2000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/2000.c
@@ -97,7 +97,7 @@ const struct iwl_mac_cfg iwl2000_mac_cfg = {
 	.led_mode = IWL_LED_RF_STATE
 
 
-const struct iwl_cfg iwl2000_2bgn_cfg = {
+const struct iwl_rf_cfg iwl2000_2bgn_cfg = {
 	IWL_DEVICE_2000,
 	.ht_params = {
 		.ht_greenfield_support = true,
@@ -125,7 +125,7 @@ const struct iwl_mac_cfg iwl2030_mac_cfg = {
 	.eeprom_params = &iwl20x0_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE
 
-const struct iwl_cfg iwl2030_2bgn_cfg = {
+const struct iwl_rf_cfg iwl2030_2bgn_cfg = {
 	IWL_DEVICE_2030,
 	.ht_params = {
 		.ht_greenfield_support = true,
@@ -153,7 +153,7 @@ const struct iwl_mac_cfg iwl105_mac_cfg = {
 	.led_mode = IWL_LED_RF_STATE,				\
 	.rx_with_siso_diversity = true
 
-const struct iwl_cfg iwl105_bgn_cfg = {
+const struct iwl_rf_cfg iwl105_bgn_cfg = {
 	IWL_DEVICE_105,
 	.ht_params = {
 		.ht_greenfield_support = true,
@@ -182,7 +182,7 @@ const struct iwl_mac_cfg iwl135_mac_cfg = {
 	.led_mode = IWL_LED_RF_STATE,				\
 	.rx_with_siso_diversity = true
 
-const struct iwl_cfg iwl135_bgn_cfg = {
+const struct iwl_rf_cfg iwl135_bgn_cfg = {
 	IWL_DEVICE_135,
 	.ht_params = {
 		.ht_greenfield_support = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/5000.c b/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
index 79ba0524086a..aaae3b1f5433 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
@@ -69,7 +69,7 @@ const struct iwl_mac_cfg iwl5000_mac_cfg = {
 	.eeprom_params = &iwl5000_eeprom_params,		\
 	.led_mode = IWL_LED_BLINK
 
-const struct iwl_cfg iwl5300_agn_cfg = {
+const struct iwl_rf_cfg iwl5300_agn_cfg = {
 	IWL_DEVICE_5000,
 	/* at least EEPROM 0x11A has wrong info */
 	.valid_tx_ant = ANT_ABC,	/* .cfg overwrite */
@@ -82,7 +82,7 @@ const struct iwl_cfg iwl5300_agn_cfg = {
 
 const char iwl5300_agn_name[] = "Intel(R) Ultimate N WiFi Link 5300 AGN";
 
-const struct iwl_cfg iwl5100_n_cfg = {
+const struct iwl_rf_cfg iwl5100_n_cfg = {
 	IWL_DEVICE_5000,
 	.valid_tx_ant = ANT_B,		/* .cfg overwrite */
 	.valid_rx_ant = ANT_AB,		/* .cfg overwrite */
@@ -94,7 +94,7 @@ const struct iwl_cfg iwl5100_n_cfg = {
 
 const char iwl5100_bgn_name[] = "Intel(R) WiFi Link 5100 BGN";
 
-const struct iwl_cfg iwl5100_abg_cfg = {
+const struct iwl_rf_cfg iwl5100_abg_cfg = {
 	IWL_DEVICE_5000,
 	.valid_tx_ant = ANT_B,		/* .cfg overwrite */
 	.valid_rx_ant = ANT_AB,		/* .cfg overwrite */
@@ -103,7 +103,7 @@ const struct iwl_cfg iwl5100_abg_cfg = {
 const char iwl5100_abg_name[] = "Intel(R) WiFi Link 5100 ABG";
 const char iwl5100_agn_name[] = "Intel(R) WiFi Link 5100 AGN";
 
-const struct iwl_cfg iwl5350_agn_cfg = {
+const struct iwl_rf_cfg iwl5350_agn_cfg = {
 	.fw_name_pre = IWL5000_FW_PRE,
 	.ucode_api_max = IWL5000_UCODE_API_MAX,
 	.ucode_api_min = IWL5000_UCODE_API_MIN,
@@ -139,7 +139,7 @@ const struct iwl_mac_cfg iwl5150_mac_cfg = {
 	.led_mode = IWL_LED_BLINK,				\
 	.internal_wimax_coex = true
 
-const struct iwl_cfg iwl5150_agn_cfg = {
+const struct iwl_rf_cfg iwl5150_agn_cfg = {
 	IWL_DEVICE_5150,
 	.ht_params = {
 		.ht_greenfield_support = true,
@@ -149,7 +149,7 @@ const struct iwl_cfg iwl5150_agn_cfg = {
 
 const char iwl5150_agn_name[] = "Intel(R) WiMAX/WiFi Link 5150 AGN";
 
-const struct iwl_cfg iwl5150_abg_cfg = {
+const struct iwl_rf_cfg iwl5150_abg_cfg = {
 	IWL_DEVICE_5150,
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/6000.c b/drivers/net/wireless/intel/iwlwifi/cfg/6000.c
index 94f042760359..ab13394896e0 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/6000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/6000.c
@@ -117,7 +117,7 @@ const struct iwl_mac_cfg iwl6005_mac_cfg = {
 	.eeprom_params = &iwl6000_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE
 
-const struct iwl_cfg iwl6005_n_cfg = {
+const struct iwl_rf_cfg iwl6005_n_cfg = {
 	IWL_DEVICE_6005,
 	.ht_params = {
 		.ht_greenfield_support = true,
@@ -132,7 +132,7 @@ const char iwl6005_2agn_d_name[] = "Intel(R) Centrino(R) Advanced-N 6205D AGN";
 const char iwl6005_2agn_mow1_name[] = "Intel(R) Centrino(R) Advanced-N 6206 AGN";
 const char iwl6005_2agn_mow2_name[] = "Intel(R) Centrino(R) Advanced-N 6207 AGN";
 
-const struct iwl_cfg iwl6005_non_n_cfg = {
+const struct iwl_rf_cfg iwl6005_non_n_cfg = {
 	IWL_DEVICE_6005,
 };
 
@@ -155,7 +155,7 @@ const struct iwl_mac_cfg iwl6030_mac_cfg = {
 	.eeprom_params = &iwl6000_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE
 
-const struct iwl_cfg iwl6030_n_cfg = {
+const struct iwl_rf_cfg iwl6030_n_cfg = {
 	IWL_DEVICE_6030,
 	.ht_params = {
 		.ht_greenfield_support = true,
@@ -169,7 +169,7 @@ const char iwl6030_2bgn_name[] = "Intel(R) Centrino(R) Advanced-N 6230 BGN";
 const char iwl1030_bgn_name[] = "Intel(R) Centrino(R) Wireless-N 1030 BGN";
 const char iwl1030_bg_name[] = "Intel(R) Centrino(R) Wireless-N 1030 BG";
 
-const struct iwl_cfg iwl6030_non_n_cfg = {
+const struct iwl_rf_cfg iwl6030_non_n_cfg = {
 	IWL_DEVICE_6030,
 };
 
@@ -187,7 +187,7 @@ const char iwl6030_2bg_name[] = "Intel(R) Centrino(R) Advanced-N 6230 BG";
 	.eeprom_params = &iwl6000_eeprom_params,		\
 	.led_mode = IWL_LED_RF_STATE
 
-const struct iwl_cfg iwl6035_2agn_cfg = {
+const struct iwl_rf_cfg iwl6035_2agn_cfg = {
 	IWL_DEVICE_6035,
 	.ht_params = {
 		.ht_greenfield_support = true,
@@ -199,7 +199,7 @@ const struct iwl_cfg iwl6035_2agn_cfg = {
 const char iwl6035_2agn_name[] = "Intel(R) Centrino(R) Advanced-N 6235 AGN";
 const char iwl6035_2agn_sff_name[] = "Intel(R) Centrino(R) Ultimate-N 6235 AGN";
 
-const struct iwl_cfg iwl130_bgn_cfg = {
+const struct iwl_rf_cfg iwl130_bgn_cfg = {
 	IWL_DEVICE_6030,
 	.ht_params = {
 		.ht_greenfield_support = true,
@@ -211,7 +211,7 @@ const struct iwl_cfg iwl130_bgn_cfg = {
 
 const char iwl130_bgn_name[] = "Intel(R) Centrino(R) Wireless-N 130 BGN";
 
-const struct iwl_cfg iwl130_bg_cfg = {
+const struct iwl_rf_cfg iwl130_bg_cfg = {
 	IWL_DEVICE_6030,
 	.rx_with_siso_diversity = true,
 };
@@ -239,7 +239,7 @@ const struct iwl_mac_cfg iwl6000i_mac_cfg = {
 	.eeprom_params = &iwl6000_eeprom_params,		\
 	.led_mode = IWL_LED_BLINK
 
-const struct iwl_cfg iwl6000i_2agn_cfg = {
+const struct iwl_rf_cfg iwl6000i_2agn_cfg = {
 	IWL_DEVICE_6000i,
 	.ht_params = {
 		.ht_greenfield_support = true,
@@ -250,7 +250,7 @@ const struct iwl_cfg iwl6000i_2agn_cfg = {
 
 const char iwl6000i_2agn_name[] = "Intel(R) Centrino(R) Advanced-N 6200 AGN";
 
-const struct iwl_cfg iwl6000i_non_n_cfg = {
+const struct iwl_rf_cfg iwl6000i_non_n_cfg = {
 	IWL_DEVICE_6000i,
 };
 
@@ -276,7 +276,7 @@ const struct iwl_mac_cfg iwl6050_mac_cfg = {
 	.led_mode = IWL_LED_BLINK,				\
 	.internal_wimax_coex = true
 
-const struct iwl_cfg iwl6050_2agn_cfg = {
+const struct iwl_rf_cfg iwl6050_2agn_cfg = {
 	IWL_DEVICE_6050,
 	.ht_params = {
 		.ht_greenfield_support = true,
@@ -287,7 +287,7 @@ const struct iwl_cfg iwl6050_2agn_cfg = {
 
 const char iwl6050_2agn_name[] = "Intel(R) Centrino(R) Advanced-N + WiMAX 6250 AGN";
 
-const struct iwl_cfg iwl6050_2abg_cfg = {
+const struct iwl_rf_cfg iwl6050_2abg_cfg = {
 	IWL_DEVICE_6050,
 };
 
@@ -310,7 +310,7 @@ const struct iwl_mac_cfg iwl6150_mac_cfg = {
 	.led_mode = IWL_LED_BLINK,				\
 	.internal_wimax_coex = true
 
-const struct iwl_cfg iwl6150_bgn_cfg = {
+const struct iwl_rf_cfg iwl6150_bgn_cfg = {
 	IWL_DEVICE_6150,
 	.ht_params = {
 		.ht_greenfield_support = true,
@@ -321,7 +321,7 @@ const struct iwl_cfg iwl6150_bgn_cfg = {
 
 const char iwl6150_bgn_name[] = "Intel(R) Centrino(R) Wireless-N + WiMAX 6150 BGN";
 
-const struct iwl_cfg iwl6150_bg_cfg = {
+const struct iwl_rf_cfg iwl6150_bg_cfg = {
 	IWL_DEVICE_6150,
 };
 
@@ -332,7 +332,7 @@ const struct iwl_mac_cfg iwl6000_mac_cfg = {
 	.base = &iwl6000_base,
 };
 
-const struct iwl_cfg iwl6000_3agn_cfg = {
+const struct iwl_rf_cfg iwl6000_3agn_cfg = {
 	.fw_name_pre = IWL6000_FW_PRE,
 	.ucode_api_max = IWL6000_UCODE_API_MAX,
 	.ucode_api_min = IWL6000_UCODE_API_MIN,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
index 4b50a02b1cc5..b6068dfcbd76 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
@@ -130,7 +130,7 @@ const char iwl7265d_2ac_name[] = "Intel(R) Dual Band Wireless AC 7265";
 const char iwl7265d_2n_name[] = "Intel(R) Dual Band Wireless N 7265";
 const char iwl7265d_n_name[] = "Intel(R) Wireless N 7265";
 
-const struct iwl_cfg iwl7260_cfg = {
+const struct iwl_rf_cfg iwl7260_cfg = {
 	.fw_name_pre = IWL7260_FW_PRE,
 	IWL_DEVICE_7000,
 	.ht_params = {
@@ -143,7 +143,7 @@ const struct iwl_cfg iwl7260_cfg = {
 	.dccm_len = IWL7260_DCCM_LEN,
 };
 
-const struct iwl_cfg iwl7260_high_temp_cfg = {
+const struct iwl_rf_cfg iwl7260_high_temp_cfg = {
 	.fw_name_pre = IWL7260_FW_PRE,
 	IWL_DEVICE_7000,
 	.ht_params = {
@@ -157,7 +157,7 @@ const struct iwl_cfg iwl7260_high_temp_cfg = {
 	.thermal_params = &iwl7000_high_temp_tt_params,
 };
 
-const struct iwl_cfg iwl3160_cfg = {
+const struct iwl_rf_cfg iwl3160_cfg = {
 	.fw_name_pre = IWL3160_FW_PRE,
 	IWL_DEVICE_7000,
 	.ht_params = {
@@ -180,7 +180,7 @@ static const struct iwl_pwr_tx_backoff iwl7265_pwr_tx_backoffs[] = {
 	{0},
 };
 
-const struct iwl_cfg iwl3165_2ac_cfg = {
+const struct iwl_rf_cfg iwl3165_2ac_cfg = {
 	.fw_name_pre = IWL7265D_FW_PRE,
 	IWL_DEVICE_7005D,
 	.ht_params = {
@@ -192,7 +192,7 @@ const struct iwl_cfg iwl3165_2ac_cfg = {
 	.dccm_len = IWL7265_DCCM_LEN,
 };
 
-const struct iwl_cfg iwl3168_2ac_cfg = {
+const struct iwl_rf_cfg iwl3168_2ac_cfg = {
 	.fw_name_pre = IWL3168_FW_PRE,
 	IWL_DEVICE_3008,
 	.ht_params = {
@@ -205,7 +205,7 @@ const struct iwl_cfg iwl3168_2ac_cfg = {
 	.nvm_type = IWL_NVM_SDP,
 };
 
-const struct iwl_cfg iwl7265_cfg = {
+const struct iwl_rf_cfg iwl7265_cfg = {
 	.fw_name_pre = IWL7265_FW_PRE,
 	IWL_DEVICE_7005,
 	.ht_params = {
@@ -218,7 +218,7 @@ const struct iwl_cfg iwl7265_cfg = {
 	.dccm_len = IWL7265_DCCM_LEN,
 };
 
-const struct iwl_cfg iwl7265d_cfg = {
+const struct iwl_rf_cfg iwl7265d_cfg = {
 	.fw_name_pre = IWL7265D_FW_PRE,
 	IWL_DEVICE_7005D,
 	.ht_params = {
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
index 03a09920f258..7e2be10ff3ae 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
@@ -105,7 +105,7 @@ const char iwl8265_2ac_name[] = "Intel(R) Dual Band Wireless AC 8265";
 const char iwl8275_2ac_name[] = "Intel(R) Dual Band Wireless AC 8275";
 const char iwl4165_2ac_name[] = "Intel(R) Dual Band Wireless AC 4165";
 
-const struct iwl_cfg iwl8260_cfg = {
+const struct iwl_rf_cfg iwl8260_cfg = {
 	.fw_name_pre = IWL8000_FW_PRE,
 	IWL_DEVICE_8260,
 	.ht_params = {
@@ -116,7 +116,7 @@ const struct iwl_cfg iwl8260_cfg = {
 	.nvm_ver = IWL8000_NVM_VERSION,
 };
 
-const struct iwl_cfg iwl8265_cfg = {
+const struct iwl_rf_cfg iwl8265_cfg = {
 	.fw_name_pre = IWL8265_FW_PRE,
 	IWL_DEVICE_8265,
 	.ht_params = {
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
index 670360af3d6e..dfd075bb0865 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
@@ -23,11 +23,11 @@
 	.nvm_ver = IWL_FM_NVM_VERSION,					\
 	.nvm_type = IWL_NVM_EXT
 
-const struct iwl_cfg iwl_rf_fm = {
+const struct iwl_rf_cfg iwl_rf_fm = {
 	IWL_DEVICE_FM,
 };
 
-const struct iwl_cfg iwl_rf_fm_160mhz = {
+const struct iwl_rf_cfg iwl_rf_fm_160mhz = {
 	IWL_DEVICE_FM,
 	.bw_limit = 160,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c
index 36bf7aee7120..a90dba322094 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c
@@ -8,7 +8,7 @@
 /* NVM versions */
 #define IWL_GF_NVM_VERSION		0x0a1d
 
-const struct iwl_cfg iwl_rf_gf = {
+const struct iwl_rf_cfg iwl_rf_gf = {
 	.uhb_supported = true,
 	.led_mode = IWL_LED_RF_STATE,
 	.non_shared_ant = ANT_B,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c
index d01f823ce272..7d444ee0a187 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c
@@ -22,16 +22,16 @@
 	.nvm_ver = IWL_HR_NVM_VERSION,					\
 	.nvm_type = IWL_NVM_EXT
 
-const struct iwl_cfg iwl_rf_hr1 = {
+const struct iwl_rf_cfg iwl_rf_hr1 = {
 	IWL_DEVICE_HR,
 	.tx_with_siso_diversity = true,
 };
 
-const struct iwl_cfg iwl_rf_hr = {
+const struct iwl_rf_cfg iwl_rf_hr = {
 	IWL_DEVICE_HR,
 };
 
-const struct iwl_cfg iwl_rf_hr_80mhz = {
+const struct iwl_rf_cfg iwl_rf_hr_80mhz = {
 	IWL_DEVICE_HR,
 	.bw_limit = 80,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-jf.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-jf.c
index 3f50f9df5145..60f5fcfb1f46 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-jf.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-jf.c
@@ -58,11 +58,11 @@ static const struct iwl_tt_params iwl_jf_tt_params = {
 	.nvm_ver = IWL_JF_NVM_VERSION,					\
 	.nvm_type = IWL_NVM_EXT
 
-const struct iwl_cfg iwl_rf_jf = {
+const struct iwl_rf_cfg iwl_rf_jf = {
 	IWL_DEVICE_JF,
 };
 
-const struct iwl_cfg iwl_rf_jf_80mhz = {
+const struct iwl_rf_cfg iwl_rf_jf_80mhz = {
 	IWL_DEVICE_JF,
 	.bw_limit = 80,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/agn.h b/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
index a13add556a7b..1ebc7effcc2a 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2021, 2024 Intel Corporation
+ * Copyright (C) 2005-2014, 2021, 2024-2025 Intel Corporation
  */
 #ifndef __iwl_agn_h__
 #define __iwl_agn_h__
@@ -399,7 +399,7 @@ static inline void iwl_dvm_set_pmi(struct iwl_priv *priv, bool state)
  * later with iwl_free_nvm_data().
  */
 struct iwl_nvm_data *
-iwl_parse_eeprom_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
+iwl_parse_eeprom_data(struct iwl_trans *trans, const struct iwl_rf_cfg *cfg,
 		      const u8 *eeprom, size_t eeprom_size);
 
 int iwl_read_eeprom(struct iwl_trans *trans, u8 **eeprom, size_t *eeprom_size);
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/dev.h b/drivers/net/wireless/intel/iwlwifi/dvm/dev.h
index 4ac8b862ad41..25b24820466d 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/dev.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/dev.h
@@ -2,6 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2003 - 2014, 2020, 2023 Intel Corporation. All rights reserved.
+ * Copyright (C) 2025 Intel Corporation
  *****************************************************************************/
 /*
  * Please use this file (dev.h) for driver implementation definitions.
@@ -627,7 +628,7 @@ struct iwl_priv {
 
 	struct iwl_trans *trans;
 	struct device *dev;		/* for debug prints only */
-	const struct iwl_cfg *cfg;
+	const struct iwl_rf_cfg *cfg;
 	const struct iwl_fw *fw;
 	const struct iwl_dvm_cfg *lib;
 	unsigned long status;
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c b/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
index 998f3053b3b0..2423125e5284 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
@@ -413,7 +413,7 @@ static void iwl_eeprom_enhanced_txpower(struct device *dev,
 	}
 }
 
-static void iwl_init_band_reference(const struct iwl_cfg *cfg,
+static void iwl_init_band_reference(const struct iwl_rf_cfg *cfg,
 				    const u8 *eeprom, size_t eeprom_size,
 				    int eeprom_band, int *eeprom_ch_count,
 				    const struct iwl_eeprom_channel **ch_info,
@@ -507,7 +507,7 @@ static void iwl_mod_ht40_chan_info(struct device *dev,
 #define CHECK_AND_PRINT_I(x)	\
 	((eeprom_ch_info[ch_idx].flags & EEPROM_CHANNEL_##x) ? # x " " : "")
 
-static int iwl_init_channel_map(struct device *dev, const struct iwl_cfg *cfg,
+static int iwl_init_channel_map(struct device *dev, const struct iwl_rf_cfg *cfg,
 				struct iwl_nvm_data *data,
 				const u8 *eeprom, size_t eeprom_size)
 {
@@ -1024,7 +1024,7 @@ int iwl_read_eeprom(struct iwl_trans *trans, u8 **eeprom, size_t *eeprom_size)
 	return ret;
 }
 
-static void iwl_init_sbands(struct iwl_trans *trans, const struct iwl_cfg *cfg,
+static void iwl_init_sbands(struct iwl_trans *trans, const struct iwl_rf_cfg *cfg,
 			    struct iwl_nvm_data *data,
 			    const u8 *eeprom, size_t eeprom_size)
 {
@@ -1059,7 +1059,7 @@ static void iwl_init_sbands(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 
 /* EEPROM data functions */
 struct iwl_nvm_data *
-iwl_parse_eeprom_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
+iwl_parse_eeprom_data(struct iwl_trans *trans, const struct iwl_rf_cfg *cfg,
 		      const u8 *eeprom, size_t eeprom_size)
 {
 	struct iwl_nvm_data *data;
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index 68656706ce34..1d619384c629 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1226,7 +1226,7 @@ static int iwl_nvm_check_version(struct iwl_nvm_data *data,
 }
 
 static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
-						 const struct iwl_cfg *cfg,
+						 const struct iwl_rf_cfg *cfg,
 						 const struct iwl_fw *fw,
 						 struct dentry *dbgfs_dir)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index ecf9e7f8e00f..031c68fbf8b1 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -353,7 +353,7 @@ struct iwl_mac_cfg {
 #define IWL_NUM_RBDS_EHT		(512 * 8)
 
 /**
- * struct iwl_cfg
+ * struct iwl_rf_cfg
  * @fw_name_pre: Firmware filename prefix. The api version and extension
  *	(.ucode) will be added to filename before loading from disk. The
  *	filename is constructed as <fw_name_pre>-<api>.ucode.
@@ -369,6 +369,9 @@ struct iwl_mac_cfg {
  * @nvm_calib_ver: NVM calibration version
  * @bw_limit: bandwidth limit for this device, if non-zero
  * @ht_params: point to ht parameters
+ * @eeprom_params: EEPROM parameters (old devices)
+ * @thermal_params: Thermal throttling parameters
+ * @lp_xtal_workaround: low-power crystal workaround needed
  * @led_mode: 0=blinking, 1=On(RF On)/Off(RF Off)
  * @rx_with_siso_diversity: 1x1 device with rx antenna diversity
  * @tx_with_siso_diversity: 1x1 device with tx antenna diversity
@@ -390,7 +393,7 @@ struct iwl_mac_cfg {
  * API differences in uCode shouldn't be handled here but through TLVs
  * and/or the uCode API version instead.
  */
-struct iwl_cfg {
+struct iwl_rf_cfg {
 	/* params specific to an individual device within a device family */
 	const char *fw_name_pre;
 	/* params likely to change within a device family */
@@ -487,7 +490,7 @@ struct iwl_dev_info {
 	u8 cores;
 	u8 cdb;
 	u8 jacket;
-	const struct iwl_cfg *cfg;
+	const struct iwl_rf_cfg *cfg;
 	const char *name;
 };
 
@@ -643,59 +646,58 @@ extern const char iwl_mtp_name[];
 extern const char iwl_dr_name[];
 extern const char iwl_br_name[];
 #if IS_ENABLED(CONFIG_IWLDVM)
-extern const struct iwl_cfg iwl5300_agn_cfg;
-extern const struct iwl_cfg iwl5350_agn_cfg;
-extern const struct iwl_cfg iwl5100_n_cfg;
-extern const struct iwl_cfg iwl5100_abg_cfg;
-extern const struct iwl_cfg iwl5150_agn_cfg;
-extern const struct iwl_cfg iwl5150_abg_cfg;
-extern const struct iwl_cfg iwl6005_non_n_cfg;
-extern const struct iwl_cfg iwl6005_n_cfg;
-extern const struct iwl_cfg iwl6030_n_cfg;
-extern const struct iwl_cfg iwl6030_non_n_cfg;
-extern const struct iwl_cfg iwl6000i_2agn_cfg;
-extern const struct iwl_cfg iwl6000i_non_n_cfg;
-extern const struct iwl_cfg iwl6000i_non_n_cfg;
-extern const struct iwl_cfg iwl6000_3agn_cfg;
-extern const struct iwl_cfg iwl6050_2agn_cfg;
-extern const struct iwl_cfg iwl6050_2abg_cfg;
-extern const struct iwl_cfg iwl6150_bgn_cfg;
-extern const struct iwl_cfg iwl6150_bg_cfg;
-extern const struct iwl_cfg iwl1000_bgn_cfg;
-extern const struct iwl_cfg iwl1000_bg_cfg;
-extern const struct iwl_cfg iwl100_bgn_cfg;
-extern const struct iwl_cfg iwl100_bg_cfg;
-extern const struct iwl_cfg iwl130_bgn_cfg;
-extern const struct iwl_cfg iwl130_bg_cfg;
-extern const struct iwl_cfg iwl2000_2bgn_cfg;
-extern const struct iwl_cfg iwl2030_2bgn_cfg;
-extern const struct iwl_cfg iwl6035_2agn_cfg;
-extern const struct iwl_cfg iwl105_bgn_cfg;
-extern const struct iwl_cfg iwl135_bgn_cfg;
+extern const struct iwl_rf_cfg iwl5300_agn_cfg;
+extern const struct iwl_rf_cfg iwl5350_agn_cfg;
+extern const struct iwl_rf_cfg iwl5100_n_cfg;
+extern const struct iwl_rf_cfg iwl5100_abg_cfg;
+extern const struct iwl_rf_cfg iwl5150_agn_cfg;
+extern const struct iwl_rf_cfg iwl5150_abg_cfg;
+extern const struct iwl_rf_cfg iwl6005_non_n_cfg;
+extern const struct iwl_rf_cfg iwl6005_n_cfg;
+extern const struct iwl_rf_cfg iwl6030_n_cfg;
+extern const struct iwl_rf_cfg iwl6030_non_n_cfg;
+extern const struct iwl_rf_cfg iwl6000i_2agn_cfg;
+extern const struct iwl_rf_cfg iwl6000i_non_n_cfg;
+extern const struct iwl_rf_cfg iwl6000i_non_n_cfg;
+extern const struct iwl_rf_cfg iwl6000_3agn_cfg;
+extern const struct iwl_rf_cfg iwl6050_2agn_cfg;
+extern const struct iwl_rf_cfg iwl6050_2abg_cfg;
+extern const struct iwl_rf_cfg iwl6150_bgn_cfg;
+extern const struct iwl_rf_cfg iwl6150_bg_cfg;
+extern const struct iwl_rf_cfg iwl1000_bgn_cfg;
+extern const struct iwl_rf_cfg iwl1000_bg_cfg;
+extern const struct iwl_rf_cfg iwl100_bgn_cfg;
+extern const struct iwl_rf_cfg iwl100_bg_cfg;
+extern const struct iwl_rf_cfg iwl130_bgn_cfg;
+extern const struct iwl_rf_cfg iwl130_bg_cfg;
+extern const struct iwl_rf_cfg iwl2000_2bgn_cfg;
+extern const struct iwl_rf_cfg iwl2030_2bgn_cfg;
+extern const struct iwl_rf_cfg iwl6035_2agn_cfg;
+extern const struct iwl_rf_cfg iwl105_bgn_cfg;
+extern const struct iwl_rf_cfg iwl135_bgn_cfg;
 #endif /* CONFIG_IWLDVM */
 #if IS_ENABLED(CONFIG_IWLMVM)
-
-extern const struct iwl_cfg iwl7260_cfg;
-extern const struct iwl_cfg iwl7260_high_temp_cfg;
-extern const struct iwl_cfg iwl3160_cfg;
-extern const struct iwl_cfg iwl3165_2ac_cfg;
-extern const struct iwl_cfg iwl3168_2ac_cfg;
-extern const struct iwl_cfg iwl7265_cfg;
-extern const struct iwl_cfg iwl7265d_cfg;
-extern const struct iwl_cfg iwl8260_cfg;
-extern const struct iwl_cfg iwl8265_cfg;
-extern const struct iwl_cfg iwl_rf_jf;
-extern const struct iwl_cfg iwl_rf_jf_80mhz;
-extern const struct iwl_cfg iwl_rf_hr1;
-extern const struct iwl_cfg iwl_rf_hr;
-extern const struct iwl_cfg iwl_rf_hr_80mhz;
-
-extern const struct iwl_cfg iwl_rf_gf;
+extern const struct iwl_rf_cfg iwl7260_cfg;
+extern const struct iwl_rf_cfg iwl7260_high_temp_cfg;
+extern const struct iwl_rf_cfg iwl3160_cfg;
+extern const struct iwl_rf_cfg iwl3165_2ac_cfg;
+extern const struct iwl_rf_cfg iwl3168_2ac_cfg;
+extern const struct iwl_rf_cfg iwl7265_cfg;
+extern const struct iwl_rf_cfg iwl7265d_cfg;
+extern const struct iwl_rf_cfg iwl8260_cfg;
+extern const struct iwl_rf_cfg iwl8265_cfg;
+extern const struct iwl_rf_cfg iwl_rf_jf;
+extern const struct iwl_rf_cfg iwl_rf_jf_80mhz;
+extern const struct iwl_rf_cfg iwl_rf_hr1;
+extern const struct iwl_rf_cfg iwl_rf_hr;
+extern const struct iwl_rf_cfg iwl_rf_hr_80mhz;
+
+extern const struct iwl_rf_cfg iwl_rf_gf;
 #endif /* CONFIG_IWLMVM */
 
 #if IS_ENABLED(CONFIG_IWLMLD)
-extern const struct iwl_cfg iwl_rf_fm;
-extern const struct iwl_cfg iwl_rf_fm_160mhz;
+extern const struct iwl_rf_cfg iwl_rf_fm;
+extern const struct iwl_rf_cfg iwl_rf_fm_160mhz;
 #define iwl_rf_wh iwl_rf_fm
 #define iwl_rf_wh_160mhz iwl_rf_fm_160mhz
 #define iwl_rf_pe iwl_rf_fm
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 8734c7913b2f..9504a0cb8b13 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -296,7 +296,7 @@ static void iwl_get_ucode_api_versions(struct iwl_trans *trans,
 				       unsigned int *api_max)
 {
 	const struct iwl_family_base_params *base = trans->mac_cfg->base;
-	const struct iwl_cfg *cfg = trans->cfg;
+	const struct iwl_rf_cfg *cfg = trans->cfg;
 
 	if (!base->ucode_api_max) {
 		*api_min = cfg->ucode_api_min;
@@ -1456,7 +1456,7 @@ static int iwl_alloc_ucode(struct iwl_drv *drv,
 
 static int validate_sec_sizes(struct iwl_drv *drv,
 			      struct iwl_firmware_pieces *pieces,
-			      const struct iwl_cfg *cfg)
+			      const struct iwl_rf_cfg *cfg)
 {
 	IWL_DEBUG_INFO(drv, "f/w package hdr runtime inst size = %zd\n",
 		get_sec_size(pieces, IWL_UCODE_REGULAR,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.h b/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
index 854957bdf79d..595300a14639 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2020-2021, 2023 Intel Corporation
+ * Copyright (C) 2005-2014, 2020-2021, 2023, 2025 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  */
 #ifndef __iwl_drv_h__
@@ -53,7 +53,7 @@
 
 struct iwl_drv;
 struct iwl_trans;
-struct iwl_cfg;
+struct iwl_rf_cfg;
 /**
  * iwl_drv_start - start the drv
  *
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index cf9e2e2ac9d1..0592f0f59d1c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -336,7 +336,7 @@ static inline void iwl_nvm_print_channel_flags(struct device *dev, u32 level,
 }
 
 static u32 iwl_get_channel_flags(u8 ch_num, int ch_idx, enum nl80211_band band,
-				 u32 nvm_flags, const struct iwl_cfg *cfg)
+				 u32 nvm_flags, const struct iwl_rf_cfg *cfg)
 {
 	u32 flags = IEEE80211_CHAN_NO_HT40;
 
@@ -403,7 +403,7 @@ static int iwl_init_channel_map(struct iwl_trans *trans,
 				const void * const nvm_ch_flags,
 				u32 sbands_flags, bool v4)
 {
-	const struct iwl_cfg *cfg = trans->cfg;
+	const struct iwl_rf_cfg *cfg = trans->cfg;
 	struct device *dev = trans->dev;
 	int ch_idx;
 	int n_channels = 0;
@@ -504,7 +504,7 @@ static void iwl_init_vht_hw_capab(struct iwl_trans *trans,
 				  struct ieee80211_sta_vht_cap *vht_cap,
 				  u8 tx_chains, u8 rx_chains)
 {
-	const struct iwl_cfg *cfg = trans->cfg;
+	const struct iwl_rf_cfg *cfg = trans->cfg;
 	int num_rx_ants = num_of_ant(rx_chains);
 	int num_tx_ants = num_of_ant(tx_chains);
 
@@ -1251,7 +1251,7 @@ static void iwl_init_sbands(struct iwl_trans *trans,
 			    n_used, n_channels);
 }
 
-static int iwl_get_sku(const struct iwl_cfg *cfg, const __le16 *nvm_sw,
+static int iwl_get_sku(const struct iwl_rf_cfg *cfg, const __le16 *nvm_sw,
 		       const __le16 *phy_sku)
 {
 	if (cfg->nvm_type != IWL_NVM_EXT)
@@ -1260,7 +1260,7 @@ static int iwl_get_sku(const struct iwl_cfg *cfg, const __le16 *nvm_sw,
 	return le32_to_cpup((const __le32 *)(phy_sku + SKU_FAMILY_8000));
 }
 
-static int iwl_get_nvm_version(const struct iwl_cfg *cfg, const __le16 *nvm_sw)
+static int iwl_get_nvm_version(const struct iwl_rf_cfg *cfg, const __le16 *nvm_sw)
 {
 	if (cfg->nvm_type != IWL_NVM_EXT)
 		return le16_to_cpup(nvm_sw + NVM_VERSION);
@@ -1269,7 +1269,7 @@ static int iwl_get_nvm_version(const struct iwl_cfg *cfg, const __le16 *nvm_sw)
 						     NVM_VERSION_EXT_NVM));
 }
 
-static int iwl_get_radio_cfg(const struct iwl_cfg *cfg, const __le16 *nvm_sw,
+static int iwl_get_radio_cfg(const struct iwl_rf_cfg *cfg, const __le16 *nvm_sw,
 			     const __le16 *phy_sku)
 {
 	if (cfg->nvm_type != IWL_NVM_EXT)
@@ -1279,7 +1279,7 @@ static int iwl_get_radio_cfg(const struct iwl_cfg *cfg, const __le16 *nvm_sw,
 
 }
 
-static int iwl_get_n_hw_addrs(const struct iwl_cfg *cfg, const __le16 *nvm_sw)
+static int iwl_get_n_hw_addrs(const struct iwl_rf_cfg *cfg, const __le16 *nvm_sw)
 {
 	int n_hw_addr;
 
@@ -1291,7 +1291,7 @@ static int iwl_get_n_hw_addrs(const struct iwl_cfg *cfg, const __le16 *nvm_sw)
 	return n_hw_addr & N_HW_ADDR_MASK;
 }
 
-static void iwl_set_radio_cfg(const struct iwl_cfg *cfg,
+static void iwl_set_radio_cfg(const struct iwl_rf_cfg *cfg,
 			      struct iwl_nvm_data *data,
 			      u32 radio_cfg)
 {
@@ -1350,7 +1350,7 @@ static void iwl_set_hw_address_from_csr(struct iwl_trans *trans,
 }
 
 static void iwl_set_hw_address_family_8000(struct iwl_trans *trans,
-					   const struct iwl_cfg *cfg,
+					   const struct iwl_rf_cfg *cfg,
 					   struct iwl_nvm_data *data,
 					   const __le16 *mac_override,
 					   const __be16 *nvm_hw)
@@ -1399,7 +1399,7 @@ static void iwl_set_hw_address_family_8000(struct iwl_trans *trans,
 }
 
 static int iwl_set_hw_address(struct iwl_trans *trans,
-			      const struct iwl_cfg *cfg,
+			      const struct iwl_rf_cfg *cfg,
 			      struct iwl_nvm_data *data, const __be16 *nvm_hw,
 			      const __le16 *mac_override)
 {
@@ -1434,7 +1434,7 @@ static int iwl_set_hw_address(struct iwl_trans *trans,
 }
 
 static bool
-iwl_nvm_no_wide_in_5ghz(struct iwl_trans *trans, const struct iwl_cfg *cfg,
+iwl_nvm_no_wide_in_5ghz(struct iwl_trans *trans, const struct iwl_rf_cfg *cfg,
 			const __be16 *nvm_hw)
 {
 	/*
@@ -1466,7 +1466,7 @@ iwl_nvm_no_wide_in_5ghz(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 }
 
 struct iwl_nvm_data *
-iwl_parse_mei_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
+iwl_parse_mei_nvm_data(struct iwl_trans *trans, const struct iwl_rf_cfg *cfg,
 		       const struct iwl_mei_nvm *mei_nvm,
 		       const struct iwl_fw *fw, u8 tx_ant, u8 rx_ant)
 {
@@ -1530,7 +1530,7 @@ iwl_parse_mei_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 IWL_EXPORT_SYMBOL(iwl_parse_mei_nvm_data);
 
 struct iwl_nvm_data *
-iwl_parse_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
+iwl_parse_nvm_data(struct iwl_trans *trans, const struct iwl_rf_cfg *cfg,
 		   const struct iwl_fw *fw,
 		   const __be16 *nvm_hw, const __le16 *nvm_sw,
 		   const __le16 *nvm_calib, const __le16 *regulatory,
@@ -1630,7 +1630,7 @@ IWL_EXPORT_SYMBOL(iwl_parse_nvm_data);
 static u32 iwl_nvm_get_regdom_bw_flags(const u16 *nvm_chan,
 				       int ch_idx, u16 nvm_flags,
 				       struct iwl_reg_capa reg_capa,
-				       const struct iwl_cfg *cfg)
+				       const struct iwl_rf_cfg *cfg)
 {
 	u32 flags = NL80211_RRF_NO_HT40;
 
@@ -1749,7 +1749,7 @@ iwl_parse_nvm_mcc_info(struct iwl_trans *trans,
 		       int num_of_ch, __le32 *channels, u16 fw_mcc,
 		       u16 geo_info, u32 cap, u8 resp_ver)
 {
-	const struct iwl_cfg *cfg = trans->cfg;
+	const struct iwl_rf_cfg *cfg = trans->cfg;
 	struct device *dev = trans->dev;
 	int ch_idx;
 	u16 ch_flags;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
index 17d22a68f074..9ce9fa4e78fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
@@ -30,7 +30,7 @@ enum iwl_nvm_sbands_flags {
  * later with iwl_free_nvm_data().
  */
 struct iwl_nvm_data *
-iwl_parse_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
+iwl_parse_nvm_data(struct iwl_trans *trans, const struct iwl_rf_cfg *cfg,
 		   const struct iwl_fw *fw,
 		   const __be16 *nvm_hw, const __le16 *nvm_sw,
 		   const __le16 *nvm_calib, const __le16 *regulatory,
@@ -95,7 +95,7 @@ struct iwl_nvm_data *iwl_get_nvm(struct iwl_trans *trans,
  * iwl_parse_mei_nvm_data - parse the mei_nvm_data and get an iwl_nvm_data
  */
 struct iwl_nvm_data *
-iwl_parse_mei_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
+iwl_parse_mei_nvm_data(struct iwl_trans *trans, const struct iwl_rf_cfg *cfg,
 		       const struct iwl_mei_nvm *mei_nvm,
 		       const struct iwl_fw *fw, u8 set_tx_ant, u8 set_rx_ant);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.c
index 4f8a63a4c296..ec312c90ff85 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.c
@@ -42,7 +42,7 @@ void iwl_init_ht_hw_capab(struct iwl_trans *trans,
 			  enum nl80211_band band,
 			  u8 tx_chains, u8 rx_chains)
 {
-	const struct iwl_cfg *cfg = trans->cfg;
+	const struct iwl_rf_cfg *cfg = trans->cfg;
 	int max_bit_rate = 0;
 
 	tx_chains = hweight8(tx_chains);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
index b5d39026fa2f..5dc299296d6d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
@@ -17,7 +17,7 @@ struct sk_buff;
 struct iwl_device_cmd;
 struct iwl_rx_cmd_buffer;
 struct iwl_fw;
-struct iwl_cfg;
+struct iwl_rf_cfg;
 
 /**
  * DOC: Operational mode - what is it ?
@@ -150,7 +150,7 @@ struct iwl_fw_error_dump_mode {
  */
 struct iwl_op_mode_ops {
 	struct iwl_op_mode *(*start)(struct iwl_trans *trans,
-				     const struct iwl_cfg *cfg,
+				     const struct iwl_rf_cfg *cfg,
 				     const struct iwl_fw *fw,
 				     struct dentry *dbgfs_dir);
 	void (*stop)(struct iwl_op_mode *op_mode);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 894436a65351..d76caf5bf4c9 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -892,7 +892,7 @@ struct iwl_trans {
 	bool csme_own;
 	struct iwl_op_mode *op_mode;
 	const struct iwl_mac_cfg *mac_cfg;
-	const struct iwl_cfg *cfg;
+	const struct iwl_rf_cfg *cfg;
 	struct iwl_drv *drv;
 	struct iwl_trans_config conf;
 	enum iwl_trans_state state;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 3e3af7d23b52..8cdd960c5245 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -62,7 +62,7 @@ static void iwl_mld_hw_set_regulatory(struct iwl_mld *mld)
 
 VISIBLE_IF_IWLWIFI_KUNIT
 void iwl_construct_mld(struct iwl_mld *mld, struct iwl_trans *trans,
-		       const struct iwl_cfg *cfg, const struct iwl_fw *fw,
+		       const struct iwl_rf_cfg *cfg, const struct iwl_fw *fw,
 		       struct ieee80211_hw *hw, struct dentry *dbgfs_dir)
 {
 	mld->dev = trans->dev;
@@ -370,7 +370,7 @@ iwl_mld_configure_trans(struct iwl_op_mode *op_mode)
 
 #define NUM_FW_LOAD_RETRIES	3
 static struct iwl_op_mode *
-iwl_op_mode_mld_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
+iwl_op_mode_mld_start(struct iwl_trans *trans, const struct iwl_rf_cfg *cfg,
 		      const struct iwl_fw *fw, struct dentry *dbgfs_dir)
 {
 	struct ieee80211_hw *hw;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.h b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
index 671f3a709322..3eab1774cb89 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -218,7 +218,7 @@ struct iwl_mld {
 	/* And here fields that survive a fw restart */
 	struct device *dev;
 	struct iwl_trans *trans;
-	const struct iwl_cfg *cfg;
+	const struct iwl_rf_cfg *cfg;
 	const struct iwl_fw *fw;
 	struct ieee80211_hw *hw;
 	struct wiphy *wiphy;
@@ -491,7 +491,7 @@ iwl_mld_is_dup(struct iwl_mld *mld, struct ieee80211_sta *sta,
 	       struct ieee80211_rx_status *rx_status, int queue);
 
 void iwl_construct_mld(struct iwl_mld *mld, struct iwl_trans *trans,
-		       const struct iwl_cfg *cfg, const struct iwl_fw *fw,
+		       const struct iwl_rf_cfg *cfg, const struct iwl_fw *fw,
 		       struct ieee80211_hw *hw, struct dentry *dbgfs_dir);
 #endif
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
index 0a9a5677fa85..26cf27be762d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
@@ -24,7 +24,7 @@ int iwlmld_kunit_test_init(struct kunit *test)
 {
 	struct iwl_mld *mld;
 	struct iwl_trans *trans;
-	const struct iwl_cfg *cfg;
+	const struct iwl_rf_cfg *cfg;
 	struct iwl_fw *fw;
 	struct ieee80211_hw *hw;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index b752bc4feb40..6df5158836db 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1003,7 +1003,7 @@ struct iwl_mvm {
 
 	struct iwl_trans *trans;
 	const struct iwl_fw *fw;
-	const struct iwl_cfg *cfg;
+	const struct iwl_rf_cfg *cfg;
 	struct iwl_phy_db *phy_db;
 	struct ieee80211_hw *hw;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 5b9c37fb0c0d..a2dc5c3b0596 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1278,7 +1278,7 @@ static void iwl_mvm_trig_link_selection(struct wiphy *wiphy,
 }
 
 static struct iwl_op_mode *
-iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
+iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_rf_cfg *cfg,
 		      const struct iwl_fw *fw, struct dentry *dbgfs_dir)
 {
 	struct ieee80211_hw *hw;
diff --git a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
index 0e6a74abd5e2..115642c75d10 100644
--- a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
+++ b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
@@ -61,10 +61,10 @@ static void devinfo_names(struct kunit *test)
 static void devinfo_no_cfg_dups(struct kunit *test)
 {
 	for (int i = 0; i < iwl_dev_info_table_size; i++) {
-		const struct iwl_cfg *cfg_i = iwl_dev_info_table[i].cfg;
+		const struct iwl_rf_cfg *cfg_i = iwl_dev_info_table[i].cfg;
 
 		for (int j = 0; j < i; j++) {
-			const struct iwl_cfg *cfg_j = iwl_dev_info_table[j].cfg;
+			const struct iwl_rf_cfg *cfg_j = iwl_dev_info_table[j].cfg;
 
 			if (cfg_i == cfg_j)
 				continue;
-- 
2.34.1


