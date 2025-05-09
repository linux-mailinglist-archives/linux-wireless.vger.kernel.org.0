Return-Path: <linux-wireless+bounces-22775-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A666AB1103
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 12:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F711C25A4B
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 10:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFAB28F521;
	Fri,  9 May 2025 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ExWTMjcS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF87B28FAA8
	for <linux-wireless@vger.kernel.org>; Fri,  9 May 2025 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787519; cv=none; b=shQZV2JpUSqa5d1GE5EmSGKSij/mGj5CIb/Fn/MTB/jFwGMJ4y0oeWaEXH+v3jf0ry3Z343ZvkycVPiOgVDTgYEfz+Kc4MpBm6VEpFcPk4C2NHW9DDoM8qrJjbJ/r6Ch9VwHCeZ/rIAUCR3ynZ6UyZCHiy5a1ke3SGoVUGAnres=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787519; c=relaxed/simple;
	bh=x6+f0uPwlLdn6uENosKogKSQLSZEBEsE7OZ8ouK/rUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cu+vrUTrm6wKP1exSY4M9NEJ70Hic5ccfEpAkgU/0LOq3T7ElbpJtUR/8UAqSulC17FKACL89S/ZkrdYxFDErH4DHbgnTB6+b46lWmr/6DT6+yD5sWwgCR6DicDvd62gYli5V5aJurw9RloD2e3MltqsziD5WWsxXQZXSBJUhhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ExWTMjcS; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746787518; x=1778323518;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x6+f0uPwlLdn6uENosKogKSQLSZEBEsE7OZ8ouK/rUA=;
  b=ExWTMjcSm98SenfjLdtPcU4MT0Kc2nAP5qtQH/L9LqB1vqHyhGhDg7Z0
   2X35b2GuOmw/q4P2XEzwE02DjhonknEM3ZDk95Mxnwz+4AmfusKnaqJKN
   jjGEsQOhMiKeDQEUXn59aWm0Ec0/5OE/Zfp+veNzAhAjPkqdCck6j7uTu
   xwlLuY6Ca1qtG1Sjya3xzf+t/gjcPNWS5/vugBSnzndC5pZsoQk+MXGOn
   +NdG32w5OJdXIDhHWGjwRnKwJHJ6UO41nKgs52T9M98ip99cS/GjpeTqL
   LbMiYn4OLhFSxO32Pd0ZZ+mhmrrgvAYRhkJX4VXxOjKrMb8XWbbWDVp9W
   A==;
X-CSE-ConnectionGUID: zV4PA3JIR6Cx4emiMYwwkg==
X-CSE-MsgGUID: FgmgkiS3R8SbhaiFkMfNrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59239894"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="59239894"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:45:17 -0700
X-CSE-ConnectionGUID: ki+p+Y+GTNqq35NekO3foA==
X-CSE-MsgGUID: 29UerHY/SpmQxF7pOm24dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="136537034"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:45:17 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: cfg: clean up Sc/Dr/Br configs
Date: Fri,  9 May 2025 13:44:46 +0300
Message-Id: <20250509104454.2582160-8-miriam.rachel.korenblit@intel.com>
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

For now, the WH and PE radios require the same config as
FM, so just add a #define for those instead of copying
the data. Since this is true, Sc/Dr/Br all used the same
configs for all RF types, but that's confusing, so now
use the defined WH/PE names for the correct combinations.

We can also now enable the unit test that ensures we have
no duplicate RF configs.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250509134302.fde890c534f6.I9755fb5e905203bcec4a35e4c4453a3a67add3a3@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   | 22 ------------
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   | 24 -------------
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  8 ++---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 35 ++++++++++---------
 .../wireless/intel/iwlwifi/tests/devinfo.c    |  8 -----
 5 files changed, 22 insertions(+), 75 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index 91da09423158..ecf36a8a1135 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -14,9 +14,6 @@
 /* Lowest firmware API version supported */
 #define IWL_DR_UCODE_API_MIN	97
 
-/* NVM versions */
-#define IWL_DR_NVM_VERSION		0x0a1d
-
 /* Memory offsets and lengths */
 #define IWL_DR_SMEM_OFFSET		0x400000
 #define IWL_DR_SMEM_LEN			0xD0000
@@ -86,21 +83,6 @@ static const struct iwl_family_base_params iwl_dr_base = {
 	.ucode_api_min = IWL_DR_UCODE_API_MIN,
 };
 
-#define IWL_DEVICE_DR							\
-	.led_mode = IWL_LED_RF_STATE,					\
-	.non_shared_ant = ANT_B,					\
-	.vht_mu_mimo_supported = true,					\
-	.nvm_ver = IWL_DR_NVM_VERSION,					\
-	.nvm_type = IWL_NVM_EXT,					\
-	.uhb_supported = true,						\
-	.num_rbds = IWL_NUM_RBDS_EHT,				\
-	.ht_params = {							\
-		.stbc = true,						\
-		.ldpc = true,						\
-		.ht40_bands = BIT(NL80211_BAND_2GHZ) |			\
-			      BIT(NL80211_BAND_5GHZ),			\
-	}
-
 const struct iwl_mac_cfg iwl_dr_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_DR,
 	.base = &iwl_dr_base,
@@ -115,10 +97,6 @@ const struct iwl_mac_cfg iwl_dr_mac_cfg = {
 
 const char iwl_dr_name[] = "Intel(R) TBD Dr device";
 
-const struct iwl_cfg iwl_cfg_dr = {
-	IWL_DEVICE_DR,
-};
-
 const struct iwl_mac_cfg iwl_br_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_DR,
 	.base = &iwl_dr_base,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 6db25355df42..5ccb8fff01f4 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -93,21 +93,6 @@ static const struct iwl_family_base_params iwl_sc_base = {
 	.ucode_api_min = IWL_SC_UCODE_API_MIN,
 };
 
-#define IWL_DEVICE_SC							\
-	.led_mode = IWL_LED_RF_STATE,					\
-	.non_shared_ant = ANT_B,					\
-	.vht_mu_mimo_supported = true,					\
-	.nvm_ver = IWL_SC_NVM_VERSION,					\
-	.nvm_type = IWL_NVM_EXT,					\
-	.uhb_supported = true,						\
-	.num_rbds = IWL_NUM_RBDS_EHT,				\
-	.ht_params = {							\
-		.stbc = true,						\
-		.ldpc = true,						\
-		.ht40_bands = BIT(NL80211_BAND_2GHZ) |			\
-			      BIT(NL80211_BAND_5GHZ),			\
-	}
-
 const struct iwl_mac_cfg iwl_sc_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_SC,
 	.base = &iwl_sc_base,
@@ -123,15 +108,6 @@ const struct iwl_mac_cfg iwl_sc_mac_cfg = {
 const char iwl_sp_name[] = "Intel(R) Wi-Fi 7 BE213 160MHz";
 const char iwl_pe_name[] = "Intel(R) Wi-Fi 8 BN201";
 
-const struct iwl_cfg iwl_cfg_sc = {
-	IWL_DEVICE_SC,
-};
-
-const struct iwl_cfg iwl_cfg_sc_160mhz = {
-	IWL_DEVICE_SC,
-	.bw_limit = 160,
-};
-
 IWL_FW_AND_PNVM(IWL_SC_A_FM_B_FW_PRE, IWL_SC_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_SC_A_FM_C_FW_PRE, IWL_SC_UCODE_API_MAX);
 MODULE_FIRMWARE(IWL_SC_A_HR_A_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 541cd5427d6b..ecf9e7f8e00f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -696,10 +696,10 @@ extern const struct iwl_cfg iwl_rf_gf;
 #if IS_ENABLED(CONFIG_IWLMLD)
 extern const struct iwl_cfg iwl_rf_fm;
 extern const struct iwl_cfg iwl_rf_fm_160mhz;
-
-extern const struct iwl_cfg iwl_cfg_sc;
-extern const struct iwl_cfg iwl_cfg_sc_160mhz;
-extern const struct iwl_cfg iwl_cfg_dr;
+#define iwl_rf_wh iwl_rf_fm
+#define iwl_rf_wh_160mhz iwl_rf_fm_160mhz
+#define iwl_rf_pe iwl_rf_fm
+#define iwl_rf_pe_160mhz iwl_rf_fm_160mhz
 #endif /* CONFIG_IWLMLD */
 
 #endif /* __IWL_CONFIG_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 1aa3508ed2ef..0d26fd0168a5 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1474,33 +1474,34 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     BW_LIMITED, NO_CDB),
 
 /* Sc */
-	IWL_DEV_INFO(iwl_cfg_sc, iwl_ax211_name, MAC_TYPE(SC), RF_TYPE(GF)),
-	IWL_DEV_INFO(iwl_cfg_sc, iwl_fm_name, MAC_TYPE(SC), RF_TYPE(FM)),
-	IWL_DEV_INFO(iwl_cfg_sc, iwl_wh_name, MAC_TYPE(SC), RF_TYPE(WH),
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name, MAC_TYPE(SC), RF_TYPE(GF)),
+	IWL_DEV_INFO(iwl_rf_fm, iwl_fm_name, MAC_TYPE(SC), RF_TYPE(FM)),
+	IWL_DEV_INFO(iwl_rf_wh, iwl_wh_name, MAC_TYPE(SC), RF_TYPE(WH),
 		     BW_NOT_LIMITED),
-	IWL_DEV_INFO(iwl_cfg_sc_160mhz, iwl_sp_name, MAC_TYPE(SC), RF_TYPE(WH),
+	IWL_DEV_INFO(iwl_rf_wh_160mhz, iwl_sp_name, MAC_TYPE(SC), RF_TYPE(WH),
 		     BW_LIMITED),
-	IWL_DEV_INFO(iwl_cfg_sc, iwl_pe_name, MAC_TYPE(SC), RF_TYPE(PE)),
-	IWL_DEV_INFO(iwl_cfg_sc, iwl_ax211_name, MAC_TYPE(SC2), RF_TYPE(GF)),
-	IWL_DEV_INFO(iwl_cfg_sc, iwl_fm_name, MAC_TYPE(SC2), RF_TYPE(FM)),
-	IWL_DEV_INFO(iwl_cfg_sc, iwl_wh_name, MAC_TYPE(SC2), RF_TYPE(WH),
+	IWL_DEV_INFO(iwl_rf_pe, iwl_pe_name, MAC_TYPE(SC), RF_TYPE(PE)),
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name, MAC_TYPE(SC2), RF_TYPE(GF)),
+	IWL_DEV_INFO(iwl_rf_fm, iwl_fm_name, MAC_TYPE(SC2), RF_TYPE(FM)),
+	IWL_DEV_INFO(iwl_rf_wh, iwl_wh_name, MAC_TYPE(SC2), RF_TYPE(WH),
 		     BW_NOT_LIMITED),
-	IWL_DEV_INFO(iwl_cfg_sc_160mhz, iwl_sp_name, MAC_TYPE(SC2), RF_TYPE(WH),
+	IWL_DEV_INFO(iwl_rf_wh_160mhz, iwl_sp_name, MAC_TYPE(SC2), RF_TYPE(WH),
 		     BW_LIMITED),
-	IWL_DEV_INFO(iwl_cfg_sc, iwl_pe_name, MAC_TYPE(SC2), RF_TYPE(PE)),
-	IWL_DEV_INFO(iwl_cfg_sc, iwl_ax211_name, MAC_TYPE(SC2F), RF_TYPE(GF)),
-	IWL_DEV_INFO(iwl_cfg_sc, iwl_fm_name, MAC_TYPE(SC2F), RF_TYPE(FM)),
-	IWL_DEV_INFO(iwl_cfg_sc, iwl_wh_name, MAC_TYPE(SC2F), RF_TYPE(WH),
+	IWL_DEV_INFO(iwl_rf_pe, iwl_pe_name, MAC_TYPE(SC2), RF_TYPE(PE)),
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name, MAC_TYPE(SC2F), RF_TYPE(GF)),
+	IWL_DEV_INFO(iwl_rf_fm, iwl_fm_name, MAC_TYPE(SC2F), RF_TYPE(FM)),
+	IWL_DEV_INFO(iwl_rf_wh, iwl_wh_name, MAC_TYPE(SC2F), RF_TYPE(WH),
 		     BW_NOT_LIMITED),
-	IWL_DEV_INFO(iwl_cfg_sc_160mhz, iwl_sp_name, MAC_TYPE(SC2F), RF_TYPE(WH),
+	IWL_DEV_INFO(iwl_rf_wh_160mhz, iwl_sp_name, MAC_TYPE(SC2F), RF_TYPE(WH),
 		     BW_LIMITED),
-	IWL_DEV_INFO(iwl_cfg_sc, iwl_pe_name, MAC_TYPE(SC2F), RF_TYPE(PE)),
+	IWL_DEV_INFO(iwl_rf_pe, iwl_pe_name, MAC_TYPE(SC2F), RF_TYPE(PE)),
 
 /* Dr */
-	IWL_DEV_INFO(iwl_cfg_dr, iwl_dr_name, MAC_TYPE(DR)),
+	IWL_DEV_INFO(iwl_rf_pe, iwl_dr_name, MAC_TYPE(DR), RF_TYPE(PE)),
+	IWL_DEV_INFO(iwl_rf_wh, iwl_dr_name, MAC_TYPE(DR), RF_TYPE(WH)),
 
 /* Br */
-	IWL_DEV_INFO(iwl_cfg_dr, iwl_br_name, MAC_TYPE(BR)),
+	IWL_DEV_INFO(iwl_rf_pe, iwl_br_name, MAC_TYPE(BR), RF_TYPE(PE)),
 #endif /* CONFIG_IWLMLD */
 };
 EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_dev_info_table);
diff --git a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
index c86495abf29b..0e6a74abd5e2 100644
--- a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
+++ b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
@@ -69,14 +69,6 @@ static void devinfo_no_cfg_dups(struct kunit *test)
 			if (cfg_i == cfg_j)
 				continue;
 
-			/*
-			 * allow different MAC type to have the same config
-			 * for better maintenance / file split
-			 */
-			if (iwl_dev_info_table[i].mac_type !=
-			    iwl_dev_info_table[j].mac_type)
-				continue;
-
 			KUNIT_EXPECT_NE_MSG(test, memcmp(cfg_i, cfg_j,
 							 sizeof(*cfg_i)), 0,
 					    "identical configs: %ps and %ps\n",
-- 
2.34.1


