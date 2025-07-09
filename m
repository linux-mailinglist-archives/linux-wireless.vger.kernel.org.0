Return-Path: <linux-wireless+bounces-25051-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29891AFDEFF
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 07:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 393264E21B3
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF1826B2DB;
	Wed,  9 Jul 2025 05:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dkUzOi3y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0571D26A0E0
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 05:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752037362; cv=none; b=BvjEgq1pA2DIATYLzJqX/FoG4+1fG/ahC8fhGX711oQa4VmCmFBEAOh8zlDfYH8kMxayu+NOcfYfUQjC4t67TEvWH0vmtd5Hc5OlJltQCAP4HMyXh0oWxAOxHAAO2h9gCx2V5lPMQGcipAVMsVqqx7D9xm4Xd/BNt1LshinnKkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752037362; c=relaxed/simple;
	bh=+vBwBwofDolsAgRYXrUTOFzJAjVJ5VW2X4SaCsLwUV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fRx4NQQqfOD61tzlYLlP5UC+GoIrxS+78vq904S8NUvOAB0665Zvxux0jXvHQJCO5YZPKDtFSz+KPNTA6sp0UNyNWB3kbogK36j81wGvwWsybli+EI5XAJCztRGeGxkuY2OX1p1tgu8tYPiaRvRHIfDGCpkZxIMkpa6kMBzVtOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dkUzOi3y; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752037361; x=1783573361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+vBwBwofDolsAgRYXrUTOFzJAjVJ5VW2X4SaCsLwUV0=;
  b=dkUzOi3yvnmc/XWxcw2FlJDGIxe+uS/HSbfdvWmEaPq4NKRojHZSJ2Nv
   20Gsp4iX/lPLPFNgroJ9uSQxadBWQpvFPzk3axDeLtaCPWoFsJge0w+mV
   L72abC7V2CxRZ7V3UuvahfhLVn5D1X+V3wctwlieyPpIZXIhlZ4knd7kR
   R19iiYV2Gd52bC/Nd60gEjkl1mfqfdDDNQ9Tq7x4NzCEcBYtIx3PUWysM
   MZtEYHe5C4k6XnFnKI5mSECitludQVBgbRi75ZMhZ1/uIon/HKhDWaT7i
   zTibd0Tg1xyr0rjY+hNdIvIRuWlV5YaJTW+sR+hqPknaYPUNBHXk2rZf1
   g==;
X-CSE-ConnectionGUID: jZy4+HJ2RPqKMQVLAnJ6Vw==
X-CSE-MsgGUID: eaQcYdJ1Qcq75PNjj3bWTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53501480"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="53501480"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:02:38 -0700
X-CSE-ConnectionGUID: pZYpGT+vQL23VCfmlWr1GQ==
X-CSE-MsgGUID: BAv2EcnpT5uf3BEkNEdKmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="192859272"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:02:37 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: assign a FW API range for GF
Date: Wed,  9 Jul 2025 08:01:56 +0300
Message-Id: <20250709075928.6066c01891f9.I2110ee6c0a2f5ff1e16156c5875f83d7a1723857@changeid>
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


