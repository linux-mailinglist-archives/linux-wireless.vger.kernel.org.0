Return-Path: <linux-wireless+bounces-25120-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0E2AFF2AE
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D27F73BCCF4
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBF12512C3;
	Wed,  9 Jul 2025 20:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FQlpOHLK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EB7264A9F
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091578; cv=none; b=F8SKJ2HEYdEJg07Ig1j/qF9EFbzZAJ4MWHc8aHtpb1a4kKBjp3o6p1t5+zGjxW6eb7n3kkkGlCY0zXfHdx0iy09dcCpMpBKDDTCBZrvM7cIirw593+L5UxjbYtOmn5d0+UFTqA9HtwRh2hmRJLF+Mx9VxnD7lBPTY4U9M0iH1KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091578; c=relaxed/simple;
	bh=9tQQMNZRDrFeL1hT1TevQqSX/C6Ww6h4XtYymdubs1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AybOCxTGfajb+C8f77bnZW3oVr/qMu3OAtIxhvRU+6hd75HRVpq2BpmVRugNMCsdobBURlpjtd4uBn3cTF1E0etGxbowW9GLkkY0ut6HBel3+/UwYRNfIt8YzeF1oPX73W3xEObe25+WkH/pjSTrAFTUOyuQ8vpP2P/adgW+5pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FQlpOHLK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752091577; x=1783627577;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9tQQMNZRDrFeL1hT1TevQqSX/C6Ww6h4XtYymdubs1w=;
  b=FQlpOHLKMtfMjwJjoLZDoR/ArPBGSjEsoNBrcnBaSfLcmfQVMMvKYSlj
   cgrMfFy91vSIMi70lp9oGws+MzbdR4hy9ryCOe29oXPyu0zcyY3yxyzel
   jeoqClVl8c3pIZoz0b+UYSdf0kmcrwpj5d3Kh0dA9t5dJsArg9wG7DSLp
   uAvGueXFaDOdWMUZtoS2xT1qU6gBGL1p/F3leviVORRhbOpsH/CrRHmBv
   22KyzN7D8OPLu3v4z+oLUFZmuM6xG2nmLzOV4oiPSYr3XeqppuicJ5EqI
   FUEgBukGwyWJc+lpA1vrP83iopG07ht6UWQX5bzJ4+f7kU4UiPt1AZQdu
   w==;
X-CSE-ConnectionGUID: JAflXcKNQ6STQWWXPKbMJA==
X-CSE-MsgGUID: YDSxnd/vTOqlM/9f9hWKIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54240320"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54240320"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:16 -0700
X-CSE-ConnectionGUID: YbzDCEY7TXqWVLQ5y3bxHA==
X-CSE-MsgGUID: FiWOzzXRTaqsda9upJIRsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="160126072"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:15 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: assign a FW API range for HR
Date: Wed,  9 Jul 2025 23:05:39 +0300
Message-Id: <20250709230308.ea54c00de44d.I47340ecaefbf40bb0bd254485d242b7f39df85b1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709200543.1628666-1-miriam.rachel.korenblit@intel.com>
References: <20250709200543.1628666-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

HR device is frozen on API 100, so it is not allowed to use FW APIs
higher than that. Make sure of that by assigning a MIN and MAX API range
for HR.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 12 -----
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    | 13 -----
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  5 --
 .../net/wireless/intel/iwlwifi/cfg/rf-hr.c    | 49 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  9 ----
 5 files changed, 48 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 57af51a3ee0b..ca488931a33c 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -19,17 +19,8 @@
 #define IWL_22000_SMEM_OFFSET		0x400000
 #define IWL_22000_SMEM_LEN		0xD0000
 
-#define IWL_QU_B_HR_B_FW_PRE		"iwlwifi-Qu-b0-hr-b0"
-#define IWL_QU_C_HR_B_FW_PRE		"iwlwifi-Qu-c0-hr-b0"
-#define IWL_QUZ_A_HR_B_FW_PRE		"iwlwifi-QuZ-a0-hr-b0"
 #define IWL_CC_A_FW_PRE			"iwlwifi-cc-a0"
 
-#define IWL_QU_B_HR_B_MODULE_FIRMWARE(api) \
-	IWL_QU_B_HR_B_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_QUZ_A_HR_B_MODULE_FIRMWARE(api) \
-	IWL_QUZ_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_QU_C_HR_B_MODULE_FIRMWARE(api) \
-	IWL_QU_C_HR_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_CC_A_MODULE_FIRMWARE(api)			\
 	IWL_CC_A_FW_PRE "-" __stringify(api) ".ucode"
 
@@ -123,7 +114,4 @@ const char iwl_ax201_killer_1650s_name[] =
 const char iwl_ax201_killer_1650i_name[] =
 	"Killer(R) Wi-Fi 6 AX1650i 160MHz Wireless Network Adapter (201NGW)";
 
-MODULE_FIRMWARE(IWL_QU_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_QU_C_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_QUZ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_CC_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 467c45ed9af2..cf7d91894ab9 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -19,24 +19,14 @@
 #define IWL_AX210_SMEM_OFFSET		0x400000
 #define IWL_AX210_SMEM_LEN		0xD0000
 
-#define IWL_SO_A_HR_B_FW_PRE		"iwlwifi-so-a0-hr-b0"
 #define IWL_SO_A_GF_A_FW_PRE		"iwlwifi-so-a0-gf-a0"
 #define IWL_TY_A_GF_A_FW_PRE		"iwlwifi-ty-a0-gf-a0"
 #define IWL_SO_A_GF4_A_FW_PRE		"iwlwifi-so-a0-gf4-a0"
-#define IWL_MA_A_HR_B_FW_PRE		"iwlwifi-ma-a0-hr-b0"
 #define IWL_MA_A_GF_A_FW_PRE		"iwlwifi-ma-a0-gf-a0"
 #define IWL_MA_A_GF4_A_FW_PRE		"iwlwifi-ma-a0-gf4-a0"
-#define IWL_MA_B_HR_B_FW_PRE		"iwlwifi-ma-b0-hr-b0"
 #define IWL_MA_B_GF_A_FW_PRE		"iwlwifi-ma-b0-gf-a0"
 #define IWL_MA_B_GF4_A_FW_PRE		"iwlwifi-ma-b0-gf4-a0"
 
-#define IWL_SO_A_HR_B_MODULE_FIRMWARE(api) \
-	IWL_SO_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_MA_A_HR_B_FW_MODULE_FIRMWARE(api)		\
-	IWL_MA_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_MA_B_HR_B_FW_MODULE_FIRMWARE(api)		\
-	IWL_MA_B_HR_B_FW_PRE "-" __stringify(api) ".ucode"
-
 static const struct iwl_family_base_params iwl_ax210_base = {
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
@@ -141,12 +131,9 @@ const struct iwl_mac_cfg iwl_ma_mac_cfg = {
 	.umac_prph_offset = 0x300000
 };
 
-MODULE_FIRMWARE(IWL_SO_A_HR_B_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 IWL_FW_AND_PNVM(IWL_SO_A_GF_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_TY_A_GF_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
-MODULE_FIRMWARE(IWL_MA_A_HR_B_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 IWL_FW_AND_PNVM(IWL_MA_A_GF_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_MA_A_GF4_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
-MODULE_FIRMWARE(IWL_MA_B_HR_B_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 IWL_FW_AND_PNVM(IWL_MA_B_GF_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_MA_B_GF4_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 50d454514fe5..02d6df7fa7a8 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -19,7 +19,6 @@
 #define IWL_BZ_SMEM_OFFSET		0x400000
 #define IWL_BZ_SMEM_LEN			0xD0000
 
-#define IWL_BZ_A_HR_B_FW_PRE		"iwlwifi-bz-a0-hr-b0"
 #define IWL_BZ_A_GF_A_FW_PRE		"iwlwifi-bz-a0-gf-a0"
 #define IWL_BZ_A_GF4_A_FW_PRE		"iwlwifi-bz-a0-gf4-a0"
 #define IWL_BZ_A_FM_B_FW_PRE		"iwlwifi-bz-a0-fm-b0"
@@ -28,9 +27,6 @@
 #define IWL_GL_B_FM_B_FW_PRE		"iwlwifi-gl-b0-fm-b0"
 #define IWL_GL_C_FM_C_FW_PRE		"iwlwifi-gl-c0-fm-c0"
 
-#define IWL_BZ_A_HR_B_MODULE_FIRMWARE(api) \
-	IWL_BZ_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
-
 static const struct iwl_family_base_params iwl_bz_base = {
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
@@ -107,7 +103,6 @@ const struct iwl_mac_cfg iwl_gl_mac_cfg = {
 	.low_latency_xtal = true,
 };
 
-MODULE_FIRMWARE(IWL_BZ_A_HR_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 IWL_FW_AND_PNVM(IWL_BZ_A_GF_A_FW_PRE, IWL_BZ_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_BZ_A_GF4_A_FW_PRE, IWL_BZ_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_BZ_A_FM_B_FW_PRE, IWL_BZ_UCODE_API_MAX);
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c
index db02664e3917..9f408d276ce9 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c
@@ -5,6 +5,41 @@
  */
 #include "iwl-config.h"
 
+/* Highest firmware API version supported */
+#define IWL_HR_UCODE_API_MAX	100
+
+/* Lowest firmware API version supported */
+#define IWL_HR_UCODE_API_MIN	98
+
+#define IWL_QU_B_HR_B_FW_PRE		"iwlwifi-Qu-b0-hr-b0"
+#define IWL_QU_C_HR_B_FW_PRE		"iwlwifi-Qu-c0-hr-b0"
+#define IWL_QUZ_A_HR_B_FW_PRE		"iwlwifi-QuZ-a0-hr-b0"
+#define IWL_SO_A_HR_B_FW_PRE		"iwlwifi-so-a0-hr-b0"
+#define IWL_MA_A_HR_B_FW_PRE		"iwlwifi-ma-a0-hr-b0"
+#define IWL_MA_B_HR_B_FW_PRE		"iwlwifi-ma-b0-hr-b0"
+#define IWL_BZ_A_HR_B_FW_PRE		"iwlwifi-bz-a0-hr-b0"
+#define IWL_SC_A_HR_A_FW_PRE		"iwlwifi-sc-a0-hr-b0"
+#define IWL_SC_A_HR_B_FW_PRE		"iwlwifi-sc-a0-hr-b0"
+
+#define IWL_QU_B_HR_B_MODULE_FIRMWARE(api)	\
+	IWL_QU_B_HR_B_FW_PRE "-" __stringify(api) ".ucode"
+#define IWL_QUZ_A_HR_B_MODULE_FIRMWARE(api)	\
+	IWL_QUZ_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
+#define IWL_QU_C_HR_B_MODULE_FIRMWARE(api)	\
+	IWL_QU_C_HR_B_FW_PRE "-" __stringify(api) ".ucode"
+#define IWL_SO_A_HR_B_MODULE_FIRMWARE(api)	\
+	IWL_SO_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
+#define IWL_MA_A_HR_B_FW_MODULE_FIRMWARE(api)	\
+	IWL_MA_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
+#define IWL_MA_B_HR_B_FW_MODULE_FIRMWARE(api)	\
+	IWL_MA_B_HR_B_FW_PRE "-" __stringify(api) ".ucode"
+#define IWL_BZ_A_HR_B_MODULE_FIRMWARE(api)	\
+	IWL_BZ_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
+#define IWL_SC_A_HR_A_FW_MODULE_FIRMWARE(api)	\
+	IWL_SC_A_HR_A_FW_PRE "-" __stringify(api) ".ucode"
+#define IWL_SC_A_HR_B_FW_MODULE_FIRMWARE(api)	\
+	IWL_SC_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
+
 /* NVM versions */
 #define IWL_HR_NVM_VERSION		0x0a1d
 
@@ -20,7 +55,9 @@
 	},								\
 	.num_rbds = IWL_NUM_RBDS_HE,					\
 	.nvm_ver = IWL_HR_NVM_VERSION,					\
-	.nvm_type = IWL_NVM_EXT
+	.nvm_type = IWL_NVM_EXT,					\
+	.ucode_api_min = IWL_HR_UCODE_API_MIN,				\
+	.ucode_api_max = IWL_HR_UCODE_API_MAX
 
 const struct iwl_rf_cfg iwl_rf_hr1 = {
 	IWL_DEVICE_HR,
@@ -40,3 +77,13 @@ const char iwl_ax101_name[] = "Intel(R) Wi-Fi 6 AX101";
 const char iwl_ax200_name[] = "Intel(R) Wi-Fi 6 AX200 160MHz";
 const char iwl_ax201_name[] = "Intel(R) Wi-Fi 6 AX201 160MHz";
 const char iwl_ax203_name[] = "Intel(R) Wi-Fi 6 AX203";
+
+MODULE_FIRMWARE(IWL_QU_B_HR_B_MODULE_FIRMWARE(IWL_HR_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_QU_C_HR_B_MODULE_FIRMWARE(IWL_HR_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_QUZ_A_HR_B_MODULE_FIRMWARE(IWL_HR_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SO_A_HR_B_MODULE_FIRMWARE(IWL_HR_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_MA_A_HR_B_FW_MODULE_FIRMWARE(IWL_HR_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_MA_B_HR_B_FW_MODULE_FIRMWARE(IWL_HR_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BZ_A_HR_B_MODULE_FIRMWARE(IWL_HR_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SC_A_HR_A_FW_MODULE_FIRMWARE(IWL_HR_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SC_A_HR_B_FW_MODULE_FIRMWARE(IWL_HR_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 97e503a25eae..ab44298d421e 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -24,8 +24,6 @@
 
 #define IWL_SC_A_FM_B_FW_PRE		"iwlwifi-sc-a0-fm-b0"
 #define IWL_SC_A_FM_C_FW_PRE		"iwlwifi-sc-a0-fm-c0"
-#define IWL_SC_A_HR_A_FW_PRE		"iwlwifi-sc-a0-hr-b0"
-#define IWL_SC_A_HR_B_FW_PRE		"iwlwifi-sc-a0-hr-b0"
 #define IWL_SC_A_GF_A_FW_PRE		"iwlwifi-sc-a0-gf-a0"
 #define IWL_SC_A_GF4_A_FW_PRE		"iwlwifi-sc-a0-gf4-a0"
 #define IWL_SC_A_WH_A_FW_PRE		"iwlwifi-sc-a0-wh-a0"
@@ -34,11 +32,6 @@
 #define IWL_SC2F_A_FM_C_FW_PRE		"iwlwifi-sc2f-a0-fm-c0"
 #define IWL_SC2F_A_WH_A_FW_PRE		"iwlwifi-sc2f-a0-wh-a0"
 
-#define IWL_SC_A_HR_A_FW_MODULE_FIRMWARE(api) \
-	IWL_SC_A_HR_A_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_SC_A_HR_B_FW_MODULE_FIRMWARE(api) \
-	IWL_SC_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
-
 static const struct iwl_family_base_params iwl_sc_base = {
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
@@ -107,8 +100,6 @@ const struct iwl_mac_cfg iwl_sc_mac_cfg = {
 
 IWL_FW_AND_PNVM(IWL_SC_A_FM_B_FW_PRE, IWL_SC_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_SC_A_FM_C_FW_PRE, IWL_SC_UCODE_API_MAX);
-MODULE_FIRMWARE(IWL_SC_A_HR_A_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SC_A_HR_B_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
 IWL_FW_AND_PNVM(IWL_SC_A_GF_A_FW_PRE, IWL_SC_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_SC_A_GF4_A_FW_PRE, IWL_SC_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_SC_A_WH_A_FW_PRE, IWL_SC_UCODE_API_MAX);
-- 
2.34.1


