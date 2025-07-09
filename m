Return-Path: <linux-wireless+bounces-25111-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BC0AFF2A6
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06BB63B7C12
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE349238D42;
	Wed,  9 Jul 2025 20:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AGNKyH1+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CB02580DE
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091568; cv=none; b=cZ2MFS36UPt9iQc+Y1iVg4g5KMkZvnSGPBVCN+1ebKkH2iNsu5EaW2lJDs6ORimU0JFG74jjmw5qvRfXIFhKLOuc4dWmq5BrOolkoO3cumwleqcDEbpBkNeRse0OQa01jaSajbYP8bypCz7KR7jh1cDcMTA5rNpSt03Vr3EE/UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091568; c=relaxed/simple;
	bh=+gaerw9xfmS2MpJQRWg854AaHo768R7SaobV4TF9p6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XFoVAoKeoGhwRqGquK9t+0rMetcjTWAEY96ytd3kCwWlYEnC/v+cuHgnzhfI4tiNiDkKnxAU3qrEa7D1nRXhwg1e/OiU3d4AARevO8ZHlbZtMbidz+kXO9FKWdQAZVhiUdklTkYjoS0LNCpoVZl8mLOorLUyhy00mmdvqKcXMjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AGNKyH1+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752091567; x=1783627567;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+gaerw9xfmS2MpJQRWg854AaHo768R7SaobV4TF9p6Q=;
  b=AGNKyH1+jBYjOL6rLc7JwRUe4qFSZ/XDxsdCmuhB8bEdaVFGPXahY0BV
   KaJ4+zJB5torT4ONN8ztgyWMaTi0n/m5syMV6Sm9QYbmfgqWbuaDdDprM
   knL5pH/GYipMcyLxnGjbGgBsEP2FnoTdg+CXVmcaeG9wuXdnVBo4FvCC7
   6O0tFjz0aHMjESiBRtp3NtKZ332xTyoVii64WeNjv7k1RxUdlCg1TA03Q
   X14loXVDSAVyN+KpquWjx/TdIHVxZHHXFzC2QFz+p+tp2Hl2ReCEevJb6
   k9c77eZ1JoW+/RF1ZS7q++47NIuC/3L5QzYV4cMKrVhECSdfJOLNaLlFp
   g==;
X-CSE-ConnectionGUID: MdSfZDYqTHKxlPevh+SU1Q==
X-CSE-MsgGUID: DJ8NlYPbQPCz48ha+cGO5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54240299"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54240299"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:06 -0700
X-CSE-ConnectionGUID: oZs5smD5QumTCdhGsnNh7A==
X-CSE-MsgGUID: NKcXPGlGQM2kN0XIqwpnTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="160126014"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:05 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: assign a FW API range for JF
Date: Wed,  9 Jul 2025 23:05:30 +0300
Message-Id: <20250709200543.1628666-3-miriam.rachel.korenblit@intel.com>
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


