Return-Path: <linux-wireless+bounces-22688-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDB6AACE3F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 21:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14111C2750A
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 19:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAAF20C48A;
	Tue,  6 May 2025 19:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D6Tgm8RR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5690D21A445
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 19:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560497; cv=none; b=QWs4BH11Phqmh9Wf0XK4oJgDohbDqmvHw//Da/0hkDjVyekRMO2atwz+bNrFT8gB73ZuSUwnLGWm0M4qLq7maJYOU3F7mzMTxhToyZ2RoG/s5tvUzpqsqYmHAuPfR0eSDPR+VXMFsV0fs67P7E2sr6mI/QC9xiw+IFIl+NX8snU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560497; c=relaxed/simple;
	bh=se05B2rFz0tisKZ/llJuYSKEA+RrcBkcyH3f5U69bSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h75qEQtQ5SAUHEJP/UjmqKFV2G41ffhUAqQgwaIU7zzxPliB4IyOA9ZHl3uGrbXZ0Nig9ZxhFR5l+88VQVXynGteYjvTacY4nYt5twg1mfoUDU9rHL75DUOhVOxFOb75TfV1HHINcoWrCgdeDVuaA7tqJBancrLc3B08RXlPflc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D6Tgm8RR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746560496; x=1778096496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=se05B2rFz0tisKZ/llJuYSKEA+RrcBkcyH3f5U69bSA=;
  b=D6Tgm8RRSGDFhCWBK4PWHfZwKmg1ioxB2FY2n727AiIC0DTsaijbqzg3
   6fVu+3hZU7XDwdszY+4gXxYX8ty4v6DquT1EuuoqwtOSVr6HVcGyK6KKB
   gIqs1z8wCR0PH+Pdvig2Yh3Bpmdc68SOoDGp9BUBdo0RdFh9xrjWmfdnB
   5wFNfgEIyOVhL/a8hF89DC6Q3o9PZJW6JNqw6ipeXJ1fIsnHWB9eoDIJ8
   WvLf3H9VS14mqnia44W0suAPqYdEuHs2mRuDEZ9emEp7lWuUAR6UuFGvL
   vXP5Q9Atk2mArMIYM9y6tCcn5x7PK6IH94aqc4+yswk3t7Btu/clorc0h
   w==;
X-CSE-ConnectionGUID: ejKMCSKtRLiAweK6il/67Q==
X-CSE-MsgGUID: IhMkYFZlQhufTLKsg5U1IQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="47961670"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="47961670"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:36 -0700
X-CSE-ConnectionGUID: W29N4rBCQB+pqfDxuEkWqg==
X-CSE-MsgGUID: on9LzDTyQ4yMdeGf8nSQ1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="140465513"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:34 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: cfg: inline HT params
Date: Tue,  6 May 2025 22:41:00 +0300
Message-Id: <20250506194102.3407967-14-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250506194102.3407967-1-miriam.rachel.korenblit@intel.com>
References: <20250506194102.3407967-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

With just a handful of values in two bytes, the params are
smaller than the pointer to them. Inline them and save some
space.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250506223834.ee5724239f69.I01452b94f83ca323c311e8b5ec5919cad44735d0@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/1000.c | 18 ++++---
 drivers/net/wireless/intel/iwlwifi/cfg/2000.c | 30 +++++++----
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 13 +++--
 drivers/net/wireless/intel/iwlwifi/cfg/5000.c | 26 +++++----
 drivers/net/wireless/intel/iwlwifi/cfg/6000.c | 54 ++++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c | 48 ++++++++++-------
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c | 18 ++++---
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c | 13 +++--
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |  7 ++-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   | 13 +++--
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   |  7 ++-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  7 ++-
 .../net/wireless/intel/iwlwifi/dvm/debugfs.c  |  8 +--
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |  8 +--
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  5 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  8 +--
 .../wireless/intel/iwlwifi/iwl-nvm-utils.c    | 13 ++---
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c  |  4 +-
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |  8 +--
 20 files changed, 192 insertions(+), 120 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/1000.c b/drivers/net/wireless/intel/iwlwifi/cfg/1000.c
index 20daa503d643..0581dc84d59b 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/1000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/1000.c
@@ -42,12 +42,6 @@ static const struct iwl_base_params iwl1000_base_params = {
 	.scd_chain_ext_wa = true,
 };
 
-static const struct iwl_ht_params iwl1000_ht_params = {
-	.ht_greenfield_support = true,
-	.use_rts_for_aggregation = true, /* use rts/cts protection */
-	.ht40_bands = BIT(NL80211_BAND_2GHZ),
-};
-
 static const struct iwl_eeprom_params iwl1000_eeprom_params = {
 	.regulatory_bands = {
 		EEPROM_REG_BAND_1_CHANNELS,
@@ -78,7 +72,11 @@ const struct iwl_cfg_trans_params iwl1000_trans_cfg = {
 
 const struct iwl_cfg iwl1000_bgn_cfg = {
 	IWL_DEVICE_1000,
-	.ht_params = &iwl1000_ht_params,
+	.ht_params = {
+		.ht_greenfield_support = true,
+		.use_rts_for_aggregation = true, /* use rts/cts protection */
+		.ht40_bands = BIT(NL80211_BAND_2GHZ),
+	},
 };
 
 const char iwl1000_bgn_name[] = "Intel(R) Centrino(R) Wireless-N 1000 BGN";
@@ -103,7 +101,11 @@ const char iwl1000_bg_name[] = "Intel(R) Centrino(R) Wireless-N 1000 BG";
 
 const struct iwl_cfg iwl100_bgn_cfg = {
 	IWL_DEVICE_100,
-	.ht_params = &iwl1000_ht_params,
+	.ht_params = {
+		.ht_greenfield_support = true,
+		.use_rts_for_aggregation = true, /* use rts/cts protection */
+		.ht40_bands = BIT(NL80211_BAND_2GHZ),
+	},
 };
 
 const char iwl100_bgn_name[] = "Intel(R) Centrino(R) Wireless-N 100 BGN";
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/2000.c b/drivers/net/wireless/intel/iwlwifi/cfg/2000.c
index 22656d6ca8ee..c2d4c8691372 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/2000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/2000.c
@@ -67,12 +67,6 @@ static const struct iwl_base_params iwl2030_base_params = {
 	.scd_chain_ext_wa = true,
 };
 
-static const struct iwl_ht_params iwl2000_ht_params = {
-	.ht_greenfield_support = true,
-	.use_rts_for_aggregation = true, /* use rts/cts protection */
-	.ht40_bands = BIT(NL80211_BAND_2GHZ),
-};
-
 static const struct iwl_eeprom_params iwl20x0_eeprom_params = {
 	.regulatory_bands = {
 		EEPROM_REG_BAND_1_CHANNELS,
@@ -105,7 +99,11 @@ const struct iwl_cfg_trans_params iwl2000_trans_cfg = {
 
 const struct iwl_cfg iwl2000_2bgn_cfg = {
 	IWL_DEVICE_2000,
-	.ht_params = &iwl2000_ht_params,
+	.ht_params = {
+		.ht_greenfield_support = true,
+		.use_rts_for_aggregation = true, /* use rts/cts protection */
+		.ht40_bands = BIT(NL80211_BAND_2GHZ),
+	},
 };
 
 const char iwl2000_2bgn_name[] = "Intel(R) Centrino(R) Wireless-N 2200 BGN";
@@ -129,7 +127,11 @@ const struct iwl_cfg_trans_params iwl2030_trans_cfg = {
 
 const struct iwl_cfg iwl2030_2bgn_cfg = {
 	IWL_DEVICE_2030,
-	.ht_params = &iwl2000_ht_params,
+	.ht_params = {
+		.ht_greenfield_support = true,
+		.use_rts_for_aggregation = true, /* use rts/cts protection */
+		.ht40_bands = BIT(NL80211_BAND_2GHZ),
+	},
 };
 
 const char iwl2030_2bgn_name[] = "Intel(R) Centrino(R) Wireless-N 2230 BGN";
@@ -153,7 +155,11 @@ const struct iwl_cfg_trans_params iwl105_trans_cfg = {
 
 const struct iwl_cfg iwl105_bgn_cfg = {
 	IWL_DEVICE_105,
-	.ht_params = &iwl2000_ht_params,
+	.ht_params = {
+		.ht_greenfield_support = true,
+		.use_rts_for_aggregation = true, /* use rts/cts protection */
+		.ht40_bands = BIT(NL80211_BAND_2GHZ),
+	},
 };
 
 const char iwl105_bgn_name[] = "Intel(R) Centrino(R) Wireless-N 105 BGN";
@@ -178,7 +184,11 @@ const struct iwl_cfg_trans_params iwl135_trans_cfg = {
 
 const struct iwl_cfg iwl135_bgn_cfg = {
 	IWL_DEVICE_135,
-	.ht_params = &iwl2000_ht_params,
+	.ht_params = {
+		.ht_greenfield_support = true,
+		.use_rts_for_aggregation = true, /* use rts/cts protection */
+		.ht40_bands = BIT(NL80211_BAND_2GHZ),
+	},
 };
 
 const char iwl135_bgn_name[] = "Intel(R) Centrino(R) Wireless-N 135 BGN";
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index b62c3d1e9b3c..633fb2bffa2f 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -61,12 +61,6 @@ static const struct iwl_base_params iwl_22000_base_params = {
 	.pcie_l1_allowed = true,
 };
 
-const struct iwl_ht_params iwl_22000_ht_params = {
-	.stbc = true,
-	.ldpc = true,
-	.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
-};
-
 #define IWL_DEVICE_22000_COMMON						\
 	.ucode_api_min = IWL_22000_UCODE_API_MIN,			\
 	.led_mode = IWL_LED_RF_STATE,					\
@@ -82,7 +76,12 @@ const struct iwl_ht_params iwl_22000_ht_params = {
 	.apmg_not_supported = true,					\
 	.vht_mu_mimo_supported = true,					\
 	.mac_addr_from_csr = 0x380,					\
-	.ht_params = &iwl_22000_ht_params,				\
+	.ht_params = {							\
+		.stbc = true,						\
+		.ldpc = true,						\
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) |			\
+			      BIT(NL80211_BAND_5GHZ),			\
+	},								\
 	.nvm_ver = IWL_22000_NVM_VERSION,				\
 	.nvm_type = IWL_NVM_EXT,					\
 	.dbgc_supported = true,						\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/5000.c b/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
index 36909f6323db..85c1adfefa93 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
@@ -41,11 +41,6 @@ static const struct iwl_base_params iwl5000_base_params = {
 	.scd_chain_ext_wa = true,
 };
 
-static const struct iwl_ht_params iwl5000_ht_params = {
-	.ht_greenfield_support = true,
-	.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
-};
-
 static const struct iwl_eeprom_params iwl5000_eeprom_params = {
 	.regulatory_bands = {
 		EEPROM_REG_BAND_1_CHANNELS,
@@ -79,7 +74,10 @@ const struct iwl_cfg iwl5300_agn_cfg = {
 	/* at least EEPROM 0x11A has wrong info */
 	.valid_tx_ant = ANT_ABC,	/* .cfg overwrite */
 	.valid_rx_ant = ANT_ABC,	/* .cfg overwrite */
-	.ht_params = &iwl5000_ht_params,
+	.ht_params = {
+		.ht_greenfield_support = true,
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
+	},
 };
 
 const char iwl5300_agn_name[] = "Intel(R) Ultimate N WiFi Link 5300 AGN";
@@ -88,7 +86,10 @@ const struct iwl_cfg iwl5100_n_cfg = {
 	IWL_DEVICE_5000,
 	.valid_tx_ant = ANT_B,		/* .cfg overwrite */
 	.valid_rx_ant = ANT_AB,		/* .cfg overwrite */
-	.ht_params = &iwl5000_ht_params,
+	.ht_params = {
+		.ht_greenfield_support = true,
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
+	},
 };
 
 const char iwl5100_bgn_name[] = "Intel(R) WiFi Link 5100 BGN";
@@ -111,7 +112,10 @@ const struct iwl_cfg iwl5350_agn_cfg = {
 	.nvm_ver = EEPROM_5050_EEPROM_VERSION,
 	.nvm_calib_ver = EEPROM_5050_TX_POWER_VERSION,
 	.eeprom_params = &iwl5000_eeprom_params,
-	.ht_params = &iwl5000_ht_params,
+	.ht_params = {
+		.ht_greenfield_support = true,
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
+	},
 	.led_mode = IWL_LED_BLINK,
 	.internal_wimax_coex = true,
 };
@@ -137,8 +141,10 @@ const struct iwl_cfg_trans_params iwl5150_trans_cfg = {
 
 const struct iwl_cfg iwl5150_agn_cfg = {
 	IWL_DEVICE_5150,
-	.ht_params = &iwl5000_ht_params,
-
+	.ht_params = {
+		.ht_greenfield_support = true,
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
+	},
 };
 
 const char iwl5150_agn_name[] = "Intel(R) WiMAX/WiFi Link 5150 AGN";
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/6000.c b/drivers/net/wireless/intel/iwlwifi/cfg/6000.c
index 09a68712114f..cb137b3fefc3 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/6000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/6000.c
@@ -88,12 +88,6 @@ static const struct iwl_base_params iwl6000_g2_base_params = {
 	.scd_chain_ext_wa = true,
 };
 
-static const struct iwl_ht_params iwl6000_ht_params = {
-	.ht_greenfield_support = true,
-	.use_rts_for_aggregation = true, /* use rts/cts protection */
-	.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
-};
-
 static const struct iwl_eeprom_params iwl6000_eeprom_params = {
 	.regulatory_bands = {
 		EEPROM_REG_BAND_1_CHANNELS,
@@ -125,7 +119,11 @@ const struct iwl_cfg_trans_params iwl6005_trans_cfg = {
 
 const struct iwl_cfg iwl6005_n_cfg = {
 	IWL_DEVICE_6005,
-	.ht_params = &iwl6000_ht_params,
+	.ht_params = {
+		.ht_greenfield_support = true,
+		.use_rts_for_aggregation = true, /* use rts/cts protection */
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
+	},
 };
 
 const char iwl6005_2agn_name[] = "Intel(R) Centrino(R) Advanced-N 6205 AGN";
@@ -159,7 +157,11 @@ const struct iwl_cfg_trans_params iwl6030_trans_cfg = {
 
 const struct iwl_cfg iwl6030_n_cfg = {
 	IWL_DEVICE_6030,
-	.ht_params = &iwl6000_ht_params,
+	.ht_params = {
+		.ht_greenfield_support = true,
+		.use_rts_for_aggregation = true, /* use rts/cts protection */
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
+	},
 };
 
 const char iwl6030_2agn_name[] = "Intel(R) Centrino(R) Advanced-N 6230 AGN";
@@ -187,7 +189,11 @@ const char iwl6030_2bg_name[] = "Intel(R) Centrino(R) Advanced-N 6230 BG";
 
 const struct iwl_cfg iwl6035_2agn_cfg = {
 	IWL_DEVICE_6035,
-	.ht_params = &iwl6000_ht_params,
+	.ht_params = {
+		.ht_greenfield_support = true,
+		.use_rts_for_aggregation = true, /* use rts/cts protection */
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
+	},
 };
 
 const char iwl6035_2agn_name[] = "Intel(R) Centrino(R) Advanced-N 6235 AGN";
@@ -195,7 +201,11 @@ const char iwl6035_2agn_sff_name[] = "Intel(R) Centrino(R) Ultimate-N 6235 AGN";
 
 const struct iwl_cfg iwl130_bgn_cfg = {
 	IWL_DEVICE_6030,
-	.ht_params = &iwl6000_ht_params,
+	.ht_params = {
+		.ht_greenfield_support = true,
+		.use_rts_for_aggregation = true, /* use rts/cts protection */
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
+	},
 	.rx_with_siso_diversity = true,
 };
 
@@ -231,7 +241,11 @@ const struct iwl_cfg_trans_params iwl6000i_trans_cfg = {
 
 const struct iwl_cfg iwl6000i_2agn_cfg = {
 	IWL_DEVICE_6000i,
-	.ht_params = &iwl6000_ht_params,
+	.ht_params = {
+		.ht_greenfield_support = true,
+		.use_rts_for_aggregation = true, /* use rts/cts protection */
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
+	},
 };
 
 const char iwl6000i_2agn_name[] = "Intel(R) Centrino(R) Advanced-N 6200 AGN";
@@ -264,7 +278,11 @@ const struct iwl_cfg_trans_params iwl6050_trans_cfg = {
 
 const struct iwl_cfg iwl6050_2agn_cfg = {
 	IWL_DEVICE_6050,
-	.ht_params = &iwl6000_ht_params,
+	.ht_params = {
+		.ht_greenfield_support = true,
+		.use_rts_for_aggregation = true, /* use rts/cts protection */
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
+	},
 };
 
 const char iwl6050_2agn_name[] = "Intel(R) Centrino(R) Advanced-N + WiMAX 6250 AGN";
@@ -294,7 +312,11 @@ const struct iwl_cfg_trans_params iwl6150_trans_cfg = {
 
 const struct iwl_cfg iwl6150_bgn_cfg = {
 	IWL_DEVICE_6150,
-	.ht_params = &iwl6000_ht_params,
+	.ht_params = {
+		.ht_greenfield_support = true,
+		.use_rts_for_aggregation = true, /* use rts/cts protection */
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
+	},
 };
 
 const char iwl6150_bgn_name[] = "Intel(R) Centrino(R) Wireless-N + WiMAX 6150 BGN";
@@ -319,7 +341,11 @@ const struct iwl_cfg iwl6000_3agn_cfg = {
 	.nvm_ver = EEPROM_6000_EEPROM_VERSION,
 	.nvm_calib_ver = EEPROM_6000_TX_POWER_VERSION,
 	.eeprom_params = &iwl6000_eeprom_params,
-	.ht_params = &iwl6000_ht_params,
+	.ht_params = {
+		.ht_greenfield_support = true,
+		.use_rts_for_aggregation = true, /* use rts/cts protection */
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
+	},
 	.led_mode = IWL_LED_BLINK,
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
index f81036e241b5..ab7933487675 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
@@ -84,11 +84,6 @@ static const struct iwl_tt_params iwl7000_high_temp_tt_params = {
 	.support_tx_backoff = true,
 };
 
-static const struct iwl_ht_params iwl7000_ht_params = {
-	.stbc = true,
-	.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
-};
-
 const struct iwl_cfg_trans_params iwl7000_trans_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_7000,
 	.base_params = &iwl7000_base_params,
@@ -138,7 +133,10 @@ const char iwl7265d_n_name[] = "Intel(R) Wireless N 7265";
 const struct iwl_cfg iwl7260_cfg = {
 	.fw_name_pre = IWL7260_FW_PRE,
 	IWL_DEVICE_7000,
-	.ht_params = &iwl7000_ht_params,
+	.ht_params = {
+		.stbc = true,
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
+	},
 	.nvm_ver = IWL7260_NVM_VERSION,
 	.host_interrupt_operation_mode = true,
 	.lp_xtal_workaround = true,
@@ -148,7 +146,10 @@ const struct iwl_cfg iwl7260_cfg = {
 const struct iwl_cfg iwl7260_high_temp_cfg = {
 	.fw_name_pre = IWL7260_FW_PRE,
 	IWL_DEVICE_7000,
-	.ht_params = &iwl7000_ht_params,
+	.ht_params = {
+		.stbc = true,
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
+	},
 	.nvm_ver = IWL7260_NVM_VERSION,
 	.high_temp = true,
 	.host_interrupt_operation_mode = true,
@@ -160,7 +161,10 @@ const struct iwl_cfg iwl7260_high_temp_cfg = {
 const struct iwl_cfg iwl3160_cfg = {
 	.fw_name_pre = IWL3160_FW_PRE,
 	IWL_DEVICE_7000,
-	.ht_params = &iwl7000_ht_params,
+	.ht_params = {
+		.stbc = true,
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
+	},
 	.nvm_ver = IWL3160_NVM_VERSION,
 	.host_interrupt_operation_mode = true,
 	.dccm_len = IWL3160_DCCM_LEN,
@@ -177,16 +181,13 @@ static const struct iwl_pwr_tx_backoff iwl7265_pwr_tx_backoffs[] = {
 	{0},
 };
 
-static const struct iwl_ht_params iwl7265_ht_params = {
-	.stbc = true,
-	.ldpc = true,
-	.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
-};
-
 const struct iwl_cfg iwl3165_2ac_cfg = {
 	.fw_name_pre = IWL7265D_FW_PRE,
 	IWL_DEVICE_7005D,
-	.ht_params = &iwl7000_ht_params,
+	.ht_params = {
+		.stbc = true,
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
+	},
 	.nvm_ver = IWL3165_NVM_VERSION,
 	.pwr_tx_backoffs = iwl7265_pwr_tx_backoffs,
 	.dccm_len = IWL7265_DCCM_LEN,
@@ -195,7 +196,10 @@ const struct iwl_cfg iwl3165_2ac_cfg = {
 const struct iwl_cfg iwl3168_2ac_cfg = {
 	.fw_name_pre = IWL3168_FW_PRE,
 	IWL_DEVICE_3008,
-	.ht_params = &iwl7000_ht_params,
+	.ht_params = {
+		.stbc = true,
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
+	},
 	.nvm_ver = IWL3168_NVM_VERSION,
 	.pwr_tx_backoffs = iwl7265_pwr_tx_backoffs,
 	.dccm_len = IWL7265_DCCM_LEN,
@@ -205,7 +209,11 @@ const struct iwl_cfg iwl3168_2ac_cfg = {
 const struct iwl_cfg iwl7265_cfg = {
 	.fw_name_pre = IWL7265_FW_PRE,
 	IWL_DEVICE_7005,
-	.ht_params = &iwl7265_ht_params,
+	.ht_params = {
+		.stbc = true,
+		.ldpc = true,
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
+	},
 	.nvm_ver = IWL7265_NVM_VERSION,
 	.pwr_tx_backoffs = iwl7265_pwr_tx_backoffs,
 	.dccm_len = IWL7265_DCCM_LEN,
@@ -214,7 +222,11 @@ const struct iwl_cfg iwl7265_cfg = {
 const struct iwl_cfg iwl7265d_cfg = {
 	.fw_name_pre = IWL7265D_FW_PRE,
 	IWL_DEVICE_7005D,
-	.ht_params = &iwl7265_ht_params,
+	.ht_params = {
+		.stbc = true,
+		.ldpc = true,
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
+	},
 	.nvm_ver = IWL7265D_NVM_VERSION,
 	.pwr_tx_backoffs = iwl7265_pwr_tx_backoffs,
 	.dccm_len = IWL7265_DCCM_LEN,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
index 6f0e62a4c8fc..02093a6e857a 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
@@ -47,12 +47,6 @@ static const struct iwl_base_params iwl8000_base_params = {
 	.pcie_l1_allowed = true,
 };
 
-static const struct iwl_ht_params iwl8000_ht_params = {
-	.stbc = true,
-	.ldpc = true,
-	.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
-};
-
 static const struct iwl_tt_params iwl8000_tt_params = {
 	.ct_kill_entry = 115,
 	.ct_kill_exit = 93,
@@ -115,14 +109,22 @@ const char iwl4165_2ac_name[] = "Intel(R) Dual Band Wireless AC 4165";
 const struct iwl_cfg iwl8260_cfg = {
 	.fw_name_pre = IWL8000_FW_PRE,
 	IWL_DEVICE_8260,
-	.ht_params = &iwl8000_ht_params,
+	.ht_params = {
+		.stbc = true,
+		.ldpc = true,
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
+	},
 	.nvm_ver = IWL8000_NVM_VERSION,
 };
 
 const struct iwl_cfg iwl8265_cfg = {
 	.fw_name_pre = IWL8265_FW_PRE,
 	IWL_DEVICE_8265,
-	.ht_params = &iwl8000_ht_params,
+	.ht_params = {
+		.stbc = true,
+		.ldpc = true,
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
+	},
 	.nvm_ver = IWL8000_NVM_VERSION,
 	.vht_mu_mimo_supported = true,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index 16bf25051dbf..af21cfdadc8f 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -45,12 +45,6 @@ static const struct iwl_base_params iwl9000_base_params = {
 	.pcie_l1_allowed = true,
 };
 
-static const struct iwl_ht_params iwl9000_ht_params = {
-	.stbc = true,
-	.ldpc = true,
-	.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
-};
-
 static const struct iwl_tt_params iwl9000_tt_params = {
 	.ct_kill_entry = 115,
 	.ct_kill_exit = 93,
@@ -95,7 +89,12 @@ static const struct iwl_tt_params iwl9000_tt_params = {
 	.min_umac_error_event_table = 0x800000,				\
 	.d3_debug_data_base_addr = 0x401000,				\
 	.d3_debug_data_length = 92 * 1024,				\
-	.ht_params = &iwl9000_ht_params,				\
+	.ht_params = {							\
+		.stbc = true,						\
+		.ldpc = true,						\
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) |			\
+			      BIT(NL80211_BAND_5GHZ),			\
+	},								\
 	.nvm_ver = IWL9000_NVM_VERSION,					\
 	.mon_smem_regs = {						\
 		.write_ptr = {						\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 6f081aaa5c57..e7bba29fe755 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -74,7 +74,12 @@ static const struct iwl_base_params iwl_ax210_base_params = {
 	.apmg_not_supported = true,					\
 	.vht_mu_mimo_supported = true,					\
 	.mac_addr_from_csr = 0x380,					\
-	.ht_params = &iwl_22000_ht_params,				\
+	.ht_params = {							\
+		.stbc = true,						\
+		.ldpc = true,						\
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) |			\
+			      BIT(NL80211_BAND_5GHZ),			\
+	},								\
 	.nvm_ver = IWL_AX210_NVM_VERSION,				\
 	.nvm_type = IWL_NVM_EXT,					\
 	.dbgc_supported = true,						\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 4840bb25448b..ea2d35cbc6f3 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -55,12 +55,6 @@ static const struct iwl_base_params iwl_bz_base_params = {
 	.pcie_l1_allowed = true,
 };
 
-const struct iwl_ht_params iwl_bz_ht_params = {
-	.stbc = true,
-	.ldpc = true,
-	.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
-};
-
 #define IWL_DEVICE_BZ_COMMON						\
 	.ucode_api_max = IWL_BZ_UCODE_API_MAX,			\
 	.ucode_api_min = IWL_BZ_UCODE_API_MIN,			\
@@ -118,7 +112,12 @@ const struct iwl_ht_params iwl_bz_ht_params = {
 
 #define IWL_DEVICE_BZ							\
 	IWL_DEVICE_BZ_COMMON,						\
-	.ht_params = &iwl_bz_ht_params
+	.ht_params = {							\
+		.stbc = true,						\
+		.ldpc = true,						\
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) |			\
+			      BIT(NL80211_BAND_5GHZ),			\
+	}
 
 /*
  * This size was picked according to 8 MSDUs inside 512 A-MSDUs in an
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index c041b9c11810..cbac8f12e2d8 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -108,7 +108,12 @@ static const struct iwl_base_params iwl_dr_base_params = {
 	.uhb_supported = true,						\
 	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,		\
 	.num_rbds = IWL_NUM_RBDS_DR_EHT,				\
-	.ht_params = &iwl_bz_ht_params
+	.ht_params = {							\
+		.stbc = true,						\
+		.ldpc = true,						\
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) |			\
+			      BIT(NL80211_BAND_5GHZ),			\
+	}
 
 /*
  * This size was picked according to 8 MSDUs inside 512 A-MSDUs in an
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 40e671e69fef..673e29f02b00 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -112,7 +112,12 @@ static const struct iwl_base_params iwl_sc_base_params = {
 	.uhb_supported = true,						\
 	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,		\
 	.num_rbds = IWL_NUM_RBDS_SC_EHT,				\
-	.ht_params = &iwl_bz_ht_params
+	.ht_params = {							\
+		.stbc = true,						\
+		.ldpc = true,						\
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) |			\
+			      BIT(NL80211_BAND_5GHZ),			\
+	}
 
 /*
  * This size was picked according to 8 MSDUs inside 512 A-MSDUs in an
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
index 2ed4b6e798ab..ec94c43ba28c 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
- * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2018, 2025 Intel Corporation
  *****************************************************************************/
 
 #include <linux/slab.h>
@@ -2097,7 +2097,8 @@ static ssize_t iwl_dbgfs_protection_mode_read(struct file *file,
 	char buf[40];
 	const size_t bufsz = sizeof(buf);
 
-	if (priv->cfg->ht_params)
+	/* HT devices also have at least one HT40 band */
+	if (priv->cfg->ht_params.ht40_bands)
 		pos += scnprintf(buf + pos, bufsz - pos,
 			 "use %s for aggregation\n",
 			 (priv->hw_params.use_rts_for_aggregation) ?
@@ -2117,7 +2118,8 @@ static ssize_t iwl_dbgfs_protection_mode_write(struct file *file,
 	int buf_size;
 	int rts;
 
-	if (!priv->cfg->ht_params)
+	/* HT devices also have at least one HT40 band */
+	if (!priv->cfg->ht_params.ht40_bands)
 		return -EINVAL;
 
 	memset(buf, 0, sizeof(buf));
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index 38e66e694d52..c62761867023 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1137,9 +1137,10 @@ static void iwl_uninit_drv(struct iwl_priv *priv)
 
 static void iwl_set_hw_params(struct iwl_priv *priv)
 {
-	if (priv->cfg->ht_params)
+	/* there are no devices with HT but without HT40 on all bands */
+	if (priv->cfg->ht_params.ht40_bands)
 		priv->hw_params.use_rts_for_aggregation =
-			priv->cfg->ht_params->use_rts_for_aggregation;
+			priv->cfg->ht_params.use_rts_for_aggregation;
 
 	/* Device-specific setup */
 	priv->lib->set_hw_params(priv);
@@ -1173,8 +1174,9 @@ static int iwl_eeprom_init_hw_params(struct iwl_priv *priv)
 {
 	struct iwl_nvm_data *data = priv->nvm_data;
 
+	/* all HT devices also have HT40 on at least one band */
 	if (data->sku_cap_11n_enable &&
-	    !priv->cfg->ht_params) {
+	    !priv->cfg->ht_params.ht40_bands) {
 		IWL_ERR(priv, "Invalid 11n configuration\n");
 		return -EINVAL;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index e2ce1c7d8c90..30725ed5e3bc 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -359,7 +359,7 @@ struct iwl_cfg {
 	/* params specific to an individual device within a device family */
 	const char *fw_name_pre;
 	/* params likely to change within a device family */
-	const struct iwl_ht_params *ht_params;
+	const struct iwl_ht_params ht_params;
 	const struct iwl_eeprom_params *eeprom_params;
 	const struct iwl_pwr_tx_backoff *pwr_tx_backoffs;
 	const struct iwl_tt_params *thermal_params;
@@ -655,7 +655,6 @@ extern const struct iwl_cfg iwl105_bgn_cfg;
 extern const struct iwl_cfg iwl135_bgn_cfg;
 #endif /* CONFIG_IWLDVM */
 #if IS_ENABLED(CONFIG_IWLMVM)
-extern const struct iwl_ht_params iwl_22000_ht_params;
 
 extern const struct iwl_cfg iwl7260_cfg;
 extern const struct iwl_cfg iwl7260_high_temp_cfg;
@@ -691,8 +690,6 @@ extern const struct iwl_cfg iwl_cfg_so_a0_hr_a0_80mhz;
 #endif /* CONFIG_IWLMVM */
 
 #if IS_ENABLED(CONFIG_IWLMLD)
-extern const struct iwl_ht_params iwl_bz_ht_params;
-
 extern const struct iwl_cfg iwl_cfg_bz;
 extern const struct iwl_cfg iwl_cfg_bz_160mhz;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 9972929234a7..87f927ed2c6e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -517,7 +517,7 @@ static void iwl_init_vht_hw_capab(struct iwl_trans *trans,
 		       IEEE80211_VHT_MAX_AMPDU_1024K <<
 		       IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT;
 
-	if (!trans->cfg->ht_params->stbc)
+	if (!trans->cfg->ht_params.stbc)
 		vht_cap->cap &= ~IEEE80211_VHT_CAP_RXSTBC_MASK;
 
 	if (data->vht160_supported)
@@ -527,7 +527,7 @@ static void iwl_init_vht_hw_capab(struct iwl_trans *trans,
 	if (cfg->vht_mu_mimo_supported)
 		vht_cap->cap |= IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE;
 
-	if (cfg->ht_params->ldpc)
+	if (cfg->ht_params.ldpc)
 		vht_cap->cap |= IEEE80211_VHT_CAP_RXLDPC;
 
 	if (data->sku_cap_mimo_disabled) {
@@ -535,7 +535,7 @@ static void iwl_init_vht_hw_capab(struct iwl_trans *trans,
 		num_tx_ants = 1;
 	}
 
-	if (trans->cfg->ht_params->stbc && num_tx_ants > 1)
+	if (trans->cfg->ht_params.stbc && num_tx_ants > 1)
 		vht_cap->cap |= IEEE80211_VHT_CAP_TXSTBC;
 	else
 		vht_cap->cap |= IEEE80211_VHT_CAP_TX_ANTENNA_PATTERN;
@@ -1087,7 +1087,7 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 		iftype_data->vendor_elems.len = ARRAY_SIZE(iwl_vendor_caps);
 	}
 
-	if (!trans->cfg->ht_params->stbc) {
+	if (!trans->cfg->ht_params.stbc) {
 		iftype_data->he_cap.he_cap_elem.phy_cap_info[2] &=
 			~IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ;
 		iftype_data->he_cap.he_cap_elem.phy_cap_info[7] &=
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.c
index b3c25acd3691..cb8149874fcb 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014, 2018-2021, 2023 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2021, 2023, 2025 Intel Corporation
  * Copyright (C) 2015 Intel Mobile Communications GmbH
  */
 #include <linux/types.h>
@@ -53,7 +53,8 @@ void iwl_init_ht_hw_capab(struct iwl_trans *trans,
 
 	if (!(data->sku_cap_11n_enable) ||
 	    (iwlwifi_mod_params.disable_11n & IWL_DISABLE_HT_ALL) ||
-	    !cfg->ht_params) {
+	    /* there are no devices with HT but without HT40 entirely */
+	    !cfg->ht_params.ht40_bands) {
 		ht_info->ht_supported = false;
 		return;
 	}
@@ -64,14 +65,14 @@ void iwl_init_ht_hw_capab(struct iwl_trans *trans,
 	ht_info->ht_supported = true;
 	ht_info->cap = IEEE80211_HT_CAP_DSSSCCK40;
 
-	if (cfg->ht_params->stbc) {
+	if (cfg->ht_params.stbc) {
 		ht_info->cap |= (1 << IEEE80211_HT_CAP_RX_STBC_SHIFT);
 
 		if (tx_chains > 1)
 			ht_info->cap |= IEEE80211_HT_CAP_TX_STBC;
 	}
 
-	if (cfg->ht_params->ldpc)
+	if (cfg->ht_params.ldpc)
 		ht_info->cap |= IEEE80211_HT_CAP_LDPC_CODING;
 
 	if (trans->trans_cfg->mq_rx_supported ||
@@ -90,13 +91,13 @@ void iwl_init_ht_hw_capab(struct iwl_trans *trans,
 	if (rx_chains >= 3)
 		ht_info->mcs.rx_mask[2] = 0xFF;
 
-	if (cfg->ht_params->ht_greenfield_support)
+	if (cfg->ht_params.ht_greenfield_support)
 		ht_info->cap |= IEEE80211_HT_CAP_GRN_FLD;
 	ht_info->cap |= IEEE80211_HT_CAP_SGI_20;
 
 	max_bit_rate = MAX_BIT_RATE_20_MHZ;
 
-	if (cfg->ht_params->ht40_bands & BIT(band)) {
+	if (cfg->ht_params.ht40_bands & BIT(band)) {
 		ht_info->cap |= IEEE80211_HT_CAP_SUP_WIDTH_20_40;
 		ht_info->cap |= IEEE80211_HT_CAP_SGI_40;
 		max_bit_rate = MAX_BIT_RATE_40_MHZ;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tlc.c b/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
index a4679627a027..a9ca92c0455e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
@@ -44,7 +44,7 @@ iwl_mld_get_tlc_cmd_flags(struct iwl_mld *mld,
 	u16 flags = 0;
 
 	/* STBC flags */
-	if (mld->cfg->ht_params->stbc &&
+	if (mld->cfg->ht_params.stbc &&
 	    (hweight8(iwl_mld_get_valid_tx_ant(mld)) > 1)) {
 		if (he_cap->has_he && he_cap->he_cap_elem.phy_cap_info[2] &
 				      IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ)
@@ -56,7 +56,7 @@ iwl_mld_get_tlc_cmd_flags(struct iwl_mld *mld,
 	}
 
 	/* LDPC */
-	if (mld->cfg->ht_params->ldpc &&
+	if (mld->cfg->ht_params.ldpc &&
 	    ((ht_cap->cap & IEEE80211_HT_CAP_LDPC_CODING) ||
 	     (has_vht && (vht_cap->cap & IEEE80211_VHT_CAP_RXLDPC))))
 		flags |= IWL_TLC_MNG_CFG_FLAGS_LDPC_MSK;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 0360509b0827..89ac4c6b3e54 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -72,7 +72,7 @@ static u16 rs_fw_get_config_flags(struct iwl_mvm *mvm,
 	u16 flags = 0;
 
 	/* get STBC flags */
-	if (mvm->cfg->ht_params->stbc &&
+	if (mvm->cfg->ht_params.stbc &&
 	    (num_of_ant(iwl_mvm_get_valid_tx_ant(mvm)) > 1)) {
 		if (he_cap->has_he && he_cap->he_cap_elem.phy_cap_info[2] &
 				      IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ)
@@ -83,7 +83,7 @@ static u16 rs_fw_get_config_flags(struct iwl_mvm *mvm,
 			flags |= IWL_TLC_MNG_CFG_FLAGS_STBC_MSK;
 	}
 
-	if (mvm->cfg->ht_params->ldpc &&
+	if (mvm->cfg->ht_params.ldpc &&
 	    ((ht_cap->cap & IEEE80211_HT_CAP_LDPC_CODING) ||
 	     (vht_ena && (vht_cap->cap & IEEE80211_VHT_CAP_RXLDPC))))
 		flags |= IWL_TLC_MNG_CFG_FLAGS_LDPC_MSK;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index 5543d0568f4f..a9ff3e592a0c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -2820,11 +2820,11 @@ static void rs_ht_init(struct iwl_mvm *mvm,
 	lq_sta->active_mimo2_rate &= ~((u16)0x2);
 	lq_sta->active_mimo2_rate <<= IWL_FIRST_OFDM_RATE;
 
-	if (mvm->cfg->ht_params->ldpc &&
+	if (mvm->cfg->ht_params.ldpc &&
 	    (ht_cap->cap & IEEE80211_HT_CAP_LDPC_CODING))
 		lq_sta->ldpc = true;
 
-	if (mvm->cfg->ht_params->stbc &&
+	if (mvm->cfg->ht_params.stbc &&
 	    (num_of_ant(iwl_mvm_get_valid_tx_ant(mvm)) > 1) &&
 	    (ht_cap->cap & IEEE80211_HT_CAP_RX_STBC))
 		lq_sta->stbc_capable = true;
@@ -2839,11 +2839,11 @@ static void rs_vht_init(struct iwl_mvm *mvm,
 {
 	rs_vht_set_enabled_rates(sta, vht_cap, lq_sta);
 
-	if (mvm->cfg->ht_params->ldpc &&
+	if (mvm->cfg->ht_params.ldpc &&
 	    (vht_cap->cap & IEEE80211_VHT_CAP_RXLDPC))
 		lq_sta->ldpc = true;
 
-	if (mvm->cfg->ht_params->stbc &&
+	if (mvm->cfg->ht_params.stbc &&
 	    (num_of_ant(iwl_mvm_get_valid_tx_ant(mvm)) > 1) &&
 	    (vht_cap->cap & IEEE80211_VHT_CAP_RXSTBC_MASK))
 		lq_sta->stbc_capable = true;
-- 
2.34.1


