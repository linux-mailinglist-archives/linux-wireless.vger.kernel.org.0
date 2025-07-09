Return-Path: <linux-wireless+bounces-25040-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 638CEAFDEF4
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 07:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281011C26A53
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC8813957E;
	Wed,  9 Jul 2025 05:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tv322IXQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F4D1E008B
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 05:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752037345; cv=none; b=YoSpOQ0+2zBSzO5025G2142TGiZ2eTe2plJQzWNysnTZrqBLxfo0ycwe8l+j3Foq666eyy0ykY+719nRfVrgj7AnXY7dCP8Vcul3laAQcUIMBz4rMawA0lPBVZthRnT6ntBjs2VWLCktsLjTIkvTfhakaemM9NAM4LatJhZkAlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752037345; c=relaxed/simple;
	bh=+gaerw9xfmS2MpJQRWg854AaHo768R7SaobV4TF9p6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ImsNg4MI04c+2cW+QqFgRkvY/UiChThA6F7ZYDKQeTG4BQRZCRaBXonStjg7+dMLFu/1zSzdvKi27QDI2/TTeV+Vf6b7+BDkVkSJdi3VdiZqBluFEUm0xPLxcSMCnGAt7eC0mSyKHmmqPAj+1eF89U55iZEurbrCHG2eDcyxxxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tv322IXQ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752037344; x=1783573344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+gaerw9xfmS2MpJQRWg854AaHo768R7SaobV4TF9p6Q=;
  b=Tv322IXQ1aEFojebX56UnWc7J6zvzwzNh5ePfOaFnvmAYx6nOfgsWUiw
   FmibWmZ8zTith2LYa+lPp13hG/GLMfBLGypwhQqtduNHj9DWtaQTFpL9X
   b7b3Ps76nLL5w9cCilhw6S2jp6e9O7HP7GbRTTBWFmey9E+kBX0nmyMCD
   YVGIQkUeFOOIGTudBOD+oBcpPJD68MReoClZvwwIwsbitNRgPRieXN1mF
   oqouvIniAcbGjJcR6uTqkSaaI8e/VdusOEJEp5S4y4O5dhq1ujFSKJVkp
   LAobDBTNgPbAqlKF7JzBqPkajcJXwdkv0/ZvW3w3iF+m4gUor/gNXvJqL
   A==;
X-CSE-ConnectionGUID: 6c+F49tXTMSRiuEGh9bPmg==
X-CSE-MsgGUID: 9pr6J9dLT3K/brNI4cqOTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53501452"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="53501452"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:02:23 -0700
X-CSE-ConnectionGUID: Uu2VRw84SIekM3c6OywrwA==
X-CSE-MsgGUID: KrXcPbVNShiXKkDmL5TBTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="192859220"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:02:23 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: assign a FW API range for JF
Date: Wed,  9 Jul 2025 08:01:46 +0300
Message-Id: <20250709050159.854432-3-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709050159.854432-1-miriam.rachel.korenblit@intel.com>
References: <20250709050159.854432-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

JF device is frozen on API 77. This prevented us from bumping the
minimum FW API of SO (and get rid of older FWs). This is because SO can
be combined with JF and then FW API 77 should be used.
Now as we have separate FW API ranges for the mac and the crf, we can
define for JF its own FW API range. This will allow bumping the minimum
FW API of SO Independently.
Do that now.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 12 --------
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |  4 ---
 .../net/wireless/intel/iwlwifi/cfg/rf-jf.c    | 29 ++++++++++++++++++-
 3 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 52e0beebf9ce..57af51a3ee0b 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -21,24 +21,15 @@
 
 #define IWL_QU_B_HR_B_FW_PRE		"iwlwifi-Qu-b0-hr-b0"
 #define IWL_QU_C_HR_B_FW_PRE		"iwlwifi-Qu-c0-hr-b0"
-#define IWL_QU_B_JF_B_FW_PRE		"iwlwifi-Qu-b0-jf-b0"
-#define IWL_QU_C_JF_B_FW_PRE		"iwlwifi-Qu-c0-jf-b0"
 #define IWL_QUZ_A_HR_B_FW_PRE		"iwlwifi-QuZ-a0-hr-b0"
-#define IWL_QUZ_A_JF_B_FW_PRE		"iwlwifi-QuZ-a0-jf-b0"
 #define IWL_CC_A_FW_PRE			"iwlwifi-cc-a0"
 
 #define IWL_QU_B_HR_B_MODULE_FIRMWARE(api) \
 	IWL_QU_B_HR_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_QUZ_A_HR_B_MODULE_FIRMWARE(api) \
 	IWL_QUZ_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_QUZ_A_JF_B_MODULE_FIRMWARE(api) \
-	IWL_QUZ_A_JF_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_QU_C_HR_B_MODULE_FIRMWARE(api) \
 	IWL_QU_C_HR_B_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_QU_B_JF_B_MODULE_FIRMWARE(api) \
-	IWL_QU_B_JF_B_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_QU_C_JF_B_MODULE_FIRMWARE(api) \
-	IWL_QU_C_JF_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_CC_A_MODULE_FIRMWARE(api)			\
 	IWL_CC_A_FW_PRE "-" __stringify(api) ".ucode"
 
@@ -134,8 +125,5 @@ const char iwl_ax201_killer_1650i_name[] =
 
 MODULE_FIRMWARE(IWL_QU_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QU_C_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_QU_B_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_QU_C_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QUZ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_QUZ_A_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_CC_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 3bf9fdbe01c6..5158ccbd1fc4 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -19,7 +19,6 @@
 #define IWL_AX210_SMEM_OFFSET		0x400000
 #define IWL_AX210_SMEM_LEN		0xD0000
 
-#define IWL_SO_A_JF_B_FW_PRE		"iwlwifi-so-a0-jf-b0"
 #define IWL_SO_A_HR_B_FW_PRE		"iwlwifi-so-a0-hr-b0"
 #define IWL_SO_A_GF_A_FW_PRE		"iwlwifi-so-a0-gf-a0"
 #define IWL_TY_A_GF_A_FW_PRE		"iwlwifi-ty-a0-gf-a0"
@@ -31,8 +30,6 @@
 #define IWL_MA_B_GF_A_FW_PRE		"iwlwifi-ma-b0-gf-a0"
 #define IWL_MA_B_GF4_A_FW_PRE		"iwlwifi-ma-b0-gf4-a0"
 
-#define IWL_SO_A_JF_B_MODULE_FIRMWARE(api) \
-	IWL_SO_A_JF_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_SO_A_HR_B_MODULE_FIRMWARE(api) \
 	IWL_SO_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_MA_A_HR_B_FW_MODULE_FIRMWARE(api)		\
@@ -144,7 +141,6 @@ const struct iwl_mac_cfg iwl_ma_mac_cfg = {
 	.umac_prph_offset = 0x300000
 };
 
-MODULE_FIRMWARE(IWL_SO_A_JF_B_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SO_A_HR_B_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 IWL_FW_AND_PNVM(IWL_SO_A_GF_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_TY_A_GF_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-jf.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-jf.c
index 467eaeae6deb..0a074e0a3bc6 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-jf.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-jf.c
@@ -5,6 +5,26 @@
  */
 #include "iwl-config.h"
 
+/* Highest firmware API version supported */
+#define IWL_JF_UCODE_API_MAX	77
+
+/* Lowest firmware API version supported */
+#define IWL_JF_UCODE_API_MIN	77
+
+#define IWL_QU_B_JF_B_FW_PRE		"iwlwifi-Qu-b0-jf-b0"
+#define IWL_QU_C_JF_B_FW_PRE		"iwlwifi-Qu-c0-jf-b0"
+#define IWL_QUZ_A_JF_B_FW_PRE		"iwlwifi-QuZ-a0-jf-b0"
+#define IWL_SO_A_JF_B_FW_PRE		"iwlwifi-so-a0-jf-b0"
+
+#define IWL_QUZ_A_JF_B_MODULE_FIRMWARE(api) \
+	IWL_QUZ_A_JF_B_FW_PRE "-" __stringify(api) ".ucode"
+#define IWL_QU_B_JF_B_MODULE_FIRMWARE(api) \
+	IWL_QU_B_JF_B_FW_PRE "-" __stringify(api) ".ucode"
+#define IWL_QU_C_JF_B_MODULE_FIRMWARE(api) \
+	IWL_QU_C_JF_B_FW_PRE "-" __stringify(api) ".ucode"
+#define IWL_SO_A_JF_B_MODULE_FIRMWARE(api) \
+	IWL_SO_A_JF_B_FW_PRE "-" __stringify(api) ".ucode"
+
 /* NVM versions */
 #define IWL_JF_NVM_VERSION		0x0a1d
 
@@ -56,7 +76,9 @@ static const struct iwl_tt_params iwl_jf_tt_params = {
 			      BIT(NL80211_BAND_5GHZ),			\
 	},								\
 	.nvm_ver = IWL_JF_NVM_VERSION,					\
-	.nvm_type = IWL_NVM_EXT
+	.nvm_type = IWL_NVM_EXT,					\
+	.ucode_api_min = IWL_JF_UCODE_API_MIN,				\
+	.ucode_api_max = IWL_JF_UCODE_API_MAX
 
 const struct iwl_rf_cfg iwl_rf_jf = {
 	IWL_DEVICE_JF,
@@ -82,3 +104,8 @@ const char iwl9560_killer_1550i_name[] =
 	"Killer(R) Wireless-AC 1550i Wireless Network Adapter (9560NGW) 160MHz";
 const char iwl9560_killer_1550s_name[] =
 	"Killer(R) Wireless-AC 1550s Wireless Network Adapter (9560D2W) 160MHz";
+
+MODULE_FIRMWARE(IWL_QU_B_JF_B_MODULE_FIRMWARE(IWL_JF_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_QU_C_JF_B_MODULE_FIRMWARE(IWL_JF_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_QUZ_A_JF_B_MODULE_FIRMWARE(IWL_JF_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SO_A_JF_B_MODULE_FIRMWARE(IWL_JF_UCODE_API_MAX));
-- 
2.34.1


