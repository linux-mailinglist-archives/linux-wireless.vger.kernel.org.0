Return-Path: <linux-wireless+bounces-25121-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872A9AFF2AD
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7535C15ED
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB3326562C;
	Wed,  9 Jul 2025 20:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yxe/RWgO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE56925B1DA
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091579; cv=none; b=oagXXVAcWi9SoZXBXWpOkhhfgWC/Ypa4FP8GdLV9g/AfOAK097tk7A03BtkCscawe/PMZPReqwdbrCpggaozo/thdSfAIBFwEesHB0R7dtwdl0sOPprAvWynsSrA6c52lfTP0lBc+iaTnlPs+Nem38rEhQk/AxHuu5wLuYJ6UTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091579; c=relaxed/simple;
	bh=+vBwBwofDolsAgRYXrUTOFzJAjVJ5VW2X4SaCsLwUV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RBrwkjCcgDX+8WvZmTm32c5QoXjwmLKxwYSVzsbIge1Y+fSXMlnF/aKyP9dsdn29GvEmgPa+LLQEuE5DDRS9o/dcOgQqh9PBZXXyudgbro7Ln6hcfUhAopRbBL7/OXRld/LCnXHosjGbsE/P3RVHGfbDNkIDIENngnvh1HyvqSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yxe/RWgO; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752091578; x=1783627578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+vBwBwofDolsAgRYXrUTOFzJAjVJ5VW2X4SaCsLwUV0=;
  b=Yxe/RWgOlhOh7TZ3NH0e/HJdPH34cEG9ULgxkGY6gAsK5QgbX2w/kRyq
   gJToTP3q3bdkLk6M/xIm/U4bFU59cnZ70nd11UhljzC9LKcSi9CF5gCnF
   gbNXSF8V41IZnkmzG8FnRHhoPhjvvtuSIA+0blz/w55GMM/iObrLKNb1/
   ZuOtLh1AjGlAGcksoO6SD/NOZXeAodmrY6bDqwDJ4epo+/ELSTHzgGxO+
   LUzLXOaNS4vGmXYg89gvjd5YaSPKMjERirIogqS6n14yF79Df9cMZjCrq
   UDWY7hj3imoh9IQ/nhIAV9t4rAYXew8B5XfMLiAVYYp+4XJWux+C478A0
   g==;
X-CSE-ConnectionGUID: jb1JKvBuRBiualQKGVTLRQ==
X-CSE-MsgGUID: xNZz/naURFKPtwHF7ynvgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54240323"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54240323"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:17 -0700
X-CSE-ConnectionGUID: 7BO88fLzTa2NkPuUQzLLpw==
X-CSE-MsgGUID: r5G0c1gXTmWfJSdsriQRzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="160126076"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:17 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: assign a FW API range for GF
Date: Wed,  9 Jul 2025 23:05:40 +0300
Message-Id: <20250709230308.3409de06db40.I2110ee6c0a2f5ff1e16156c5875f83d7a1723857@changeid>
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

GF device is frozen on API 100, so it is not allowed to use FW APIs
higher than that. Make sure of that by assigning a MIN and MAX API range
for GF.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    | 15 ---------
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  4 ---
 .../net/wireless/intel/iwlwifi/cfg/rf-gf.c    | 31 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  4 ---
 4 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index cf7d91894ab9..ddf3d313da5a 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -19,14 +19,6 @@
 #define IWL_AX210_SMEM_OFFSET		0x400000
 #define IWL_AX210_SMEM_LEN		0xD0000
 
-#define IWL_SO_A_GF_A_FW_PRE		"iwlwifi-so-a0-gf-a0"
-#define IWL_TY_A_GF_A_FW_PRE		"iwlwifi-ty-a0-gf-a0"
-#define IWL_SO_A_GF4_A_FW_PRE		"iwlwifi-so-a0-gf4-a0"
-#define IWL_MA_A_GF_A_FW_PRE		"iwlwifi-ma-a0-gf-a0"
-#define IWL_MA_A_GF4_A_FW_PRE		"iwlwifi-ma-a0-gf4-a0"
-#define IWL_MA_B_GF_A_FW_PRE		"iwlwifi-ma-b0-gf-a0"
-#define IWL_MA_B_GF4_A_FW_PRE		"iwlwifi-ma-b0-gf4-a0"
-
 static const struct iwl_family_base_params iwl_ax210_base = {
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
@@ -130,10 +122,3 @@ const struct iwl_mac_cfg iwl_ma_mac_cfg = {
 	.integrated = true,
 	.umac_prph_offset = 0x300000
 };
-
-IWL_FW_AND_PNVM(IWL_SO_A_GF_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
-IWL_FW_AND_PNVM(IWL_TY_A_GF_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
-IWL_FW_AND_PNVM(IWL_MA_A_GF_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
-IWL_FW_AND_PNVM(IWL_MA_A_GF4_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
-IWL_FW_AND_PNVM(IWL_MA_B_GF_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
-IWL_FW_AND_PNVM(IWL_MA_B_GF4_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 02d6df7fa7a8..9f543946b285 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -19,8 +19,6 @@
 #define IWL_BZ_SMEM_OFFSET		0x400000
 #define IWL_BZ_SMEM_LEN			0xD0000
 
-#define IWL_BZ_A_GF_A_FW_PRE		"iwlwifi-bz-a0-gf-a0"
-#define IWL_BZ_A_GF4_A_FW_PRE		"iwlwifi-bz-a0-gf4-a0"
 #define IWL_BZ_A_FM_B_FW_PRE		"iwlwifi-bz-a0-fm-b0"
 #define IWL_BZ_A_FM_C_FW_PRE		"iwlwifi-bz-a0-fm-c0"
 #define IWL_BZ_A_FM4_B_FW_PRE		"iwlwifi-bz-a0-fm4-b0"
@@ -103,8 +101,6 @@ const struct iwl_mac_cfg iwl_gl_mac_cfg = {
 	.low_latency_xtal = true,
 };
 
-IWL_FW_AND_PNVM(IWL_BZ_A_GF_A_FW_PRE, IWL_BZ_UCODE_API_MAX);
-IWL_FW_AND_PNVM(IWL_BZ_A_GF4_A_FW_PRE, IWL_BZ_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_BZ_A_FM_B_FW_PRE, IWL_BZ_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_BZ_A_FM_C_FW_PRE, IWL_BZ_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_BZ_A_FM4_B_FW_PRE, IWL_BZ_UCODE_API_MAX);
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c
index f55c286e83be..7ff5170faaa9 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c
@@ -5,6 +5,24 @@
  */
 #include "iwl-config.h"
 
+/* Highest firmware API version supported */
+#define IWL_GF_UCODE_API_MAX	100
+
+/* Lowest firmware API version supported */
+#define IWL_GF_UCODE_API_MIN	98
+
+#define IWL_SO_A_GF_A_FW_PRE		"iwlwifi-so-a0-gf-a0"
+#define IWL_TY_A_GF_A_FW_PRE		"iwlwifi-ty-a0-gf-a0"
+#define IWL_MA_A_GF_A_FW_PRE		"iwlwifi-ma-a0-gf-a0"
+#define IWL_MA_B_GF_A_FW_PRE		"iwlwifi-ma-b0-gf-a0"
+#define IWL_SO_A_GF4_A_FW_PRE		"iwlwifi-so-a0-gf4-a0"
+#define IWL_MA_A_GF4_A_FW_PRE		"iwlwifi-ma-a0-gf4-a0"
+#define IWL_MA_B_GF4_A_FW_PRE		"iwlwifi-ma-b0-gf4-a0"
+#define IWL_BZ_A_GF_A_FW_PRE		"iwlwifi-bz-a0-gf-a0"
+#define IWL_BZ_A_GF4_A_FW_PRE		"iwlwifi-bz-a0-gf4-a0"
+#define IWL_SC_A_GF_A_FW_PRE		"iwlwifi-sc-a0-gf-a0"
+#define IWL_SC_A_GF4_A_FW_PRE		"iwlwifi-sc-a0-gf4-a0"
+
 /* NVM versions */
 #define IWL_GF_NVM_VERSION		0x0a1d
 
@@ -22,6 +40,8 @@ const struct iwl_rf_cfg iwl_rf_gf = {
 	.nvm_ver = IWL_GF_NVM_VERSION,
 	.nvm_type = IWL_NVM_EXT,
 	.num_rbds = IWL_NUM_RBDS_HE,
+	.ucode_api_min = IWL_GF_UCODE_API_MIN,
+	.ucode_api_max = IWL_GF_UCODE_API_MAX,
 };
 
 const char iwl_ax210_killer_1675w_name[] =
@@ -40,3 +60,14 @@ const char iwl_ax411_killer_1690i_name[] =
 const char iwl_ax210_name[] = "Intel(R) Wi-Fi 6E AX210 160MHz";
 const char iwl_ax211_name[] = "Intel(R) Wi-Fi 6E AX211 160MHz";
 const char iwl_ax411_name[] = "Intel(R) Wi-Fi 6E AX411 160MHz";
+
+IWL_FW_AND_PNVM(IWL_SO_A_GF_A_FW_PRE, IWL_GF_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_TY_A_GF_A_FW_PRE, IWL_GF_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_MA_A_GF_A_FW_PRE, IWL_GF_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_MA_B_GF_A_FW_PRE, IWL_GF_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_MA_A_GF4_A_FW_PRE, IWL_GF_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_MA_B_GF4_A_FW_PRE, IWL_GF_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_BZ_A_GF_A_FW_PRE, IWL_GF_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_BZ_A_GF4_A_FW_PRE, IWL_GF_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_SC_A_GF_A_FW_PRE, IWL_GF_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_SC_A_GF4_A_FW_PRE, IWL_GF_UCODE_API_MAX);
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index ab44298d421e..7b70640abf53 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -24,8 +24,6 @@
 
 #define IWL_SC_A_FM_B_FW_PRE		"iwlwifi-sc-a0-fm-b0"
 #define IWL_SC_A_FM_C_FW_PRE		"iwlwifi-sc-a0-fm-c0"
-#define IWL_SC_A_GF_A_FW_PRE		"iwlwifi-sc-a0-gf-a0"
-#define IWL_SC_A_GF4_A_FW_PRE		"iwlwifi-sc-a0-gf4-a0"
 #define IWL_SC_A_WH_A_FW_PRE		"iwlwifi-sc-a0-wh-a0"
 #define IWL_SC2_A_FM_C_FW_PRE		"iwlwifi-sc2-a0-fm-c0"
 #define IWL_SC2_A_WH_A_FW_PRE		"iwlwifi-sc2-a0-wh-a0"
@@ -100,8 +98,6 @@ const struct iwl_mac_cfg iwl_sc_mac_cfg = {
 
 IWL_FW_AND_PNVM(IWL_SC_A_FM_B_FW_PRE, IWL_SC_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_SC_A_FM_C_FW_PRE, IWL_SC_UCODE_API_MAX);
-IWL_FW_AND_PNVM(IWL_SC_A_GF_A_FW_PRE, IWL_SC_UCODE_API_MAX);
-IWL_FW_AND_PNVM(IWL_SC_A_GF4_A_FW_PRE, IWL_SC_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_SC_A_WH_A_FW_PRE, IWL_SC_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_SC2_A_FM_C_FW_PRE, IWL_SC_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_SC2_A_WH_A_FW_PRE, IWL_SC_UCODE_API_MAX);
-- 
2.34.1


