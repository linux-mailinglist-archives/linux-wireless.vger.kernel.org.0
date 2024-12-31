Return-Path: <linux-wireless+bounces-16938-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 135F09FEF3D
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 12:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A913D162423
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 11:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DFE17ADE8;
	Tue, 31 Dec 2024 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gGHIdtZe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5996519D086
	for <linux-wireless@vger.kernel.org>; Tue, 31 Dec 2024 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735646380; cv=none; b=WXDnww//RZA7UvKw52ZGamFJzGsnhybk22et8gzUmiRinAjFShcz84rYeUPOCHAbbrPs1Y9xboN3zb6fK9pxkJYb3/3EuZtMYhKFG9I9mMAyMUNaw1NaTxrvw9XFLqMXD8DmjNL292cDnprQJvAlwxtkX67cOKvAA3cejM32k/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735646380; c=relaxed/simple;
	bh=sHWDktJyWFVnZNQ96x4pa9QMFQAxFWMiqUNkr+MgoYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kpb1HtG0UoG22Z7tBpVNhA8Il60LDAXrvGShDaHN9O9rfjQd7si8YYlkCo56cqCrnFHZmx2+luXpwttwjgJWekEL7f5wxYUh26I/X1WBsN8wuDsVCsx4pfFfdYhYxDImpGfkGaToTMYDs1ry4tMXVfkDGbz6TwBF/D0R30SUQGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gGHIdtZe; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735646378; x=1767182378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sHWDktJyWFVnZNQ96x4pa9QMFQAxFWMiqUNkr+MgoYY=;
  b=gGHIdtZeIFNvngacZeB2iztlUrIQrIyC0IfmicR/cPT415xTEe3fGiIT
   hlBf2mxEZgf867ShJshA0F6iTDZEPAmN3coQGSqTH44HKQkICZ45vDjlV
   rKsQsb+5aTuSczCPLv2vzAn9Qxeov/MN13tEK02SH/hNDbT29bxNBaZhz
   KOb8eNeqT6jcFQDQm9ni0lV8n06MBx4kjIJJ+XIeOPEVkTW5eIiBL8Dhn
   gXK2A01CXG0/4e7DXOjfq38B0LbDiIs5JROTjq7Hk8DWNHh2zfwE/6nG+
   gyokT/FlWVfOmOuFAxLLvDzs2r/6y6xcIt4l5ENk07lmFwD4P313LUmsn
   A==;
X-CSE-ConnectionGUID: JSlCYaU4SsCbv0lzi+Skyg==
X-CSE-MsgGUID: mTyP2wJyS4K7Q4hoSNqm1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="53330173"
X-IronPort-AV: E=Sophos;i="6.12,279,1728975600"; 
   d="scan'208";a="53330173"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:38 -0800
X-CSE-ConnectionGUID: ClRUeoASRAq6q18PJFsrIQ==
X-CSE-MsgGUID: FWnDUi87RbKWEh5faqS+3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="138380295"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:37 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 06/15] wifi: iwlwifi: config: unify fw/pnvm MODULE_FIRMWARE
Date: Tue, 31 Dec 2024 13:59:06 +0200
Message-Id: <20241231135726.302e521e08e9.I782513432d3dcbf801e8262522ded95302548e1c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241231115915.1082656-1-miriam.rachel.korenblit@intel.com>
References: <20241231115915.1082656-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

All newer devices now require PNVM files, so don't list them
separately but simply generate the relevant MODULE_FIRMWARE()
declarations together. This simplifies the code and adds a
large number of missing PVNM declarations.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    | 38 ++++---------------
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   | 31 ++++-----------
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   | 36 +++++-------------
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  4 ++
 4 files changed, 28 insertions(+), 81 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 975e8aed1526..4a76cffda488 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -45,26 +45,10 @@
 	IWL_SO_A_JF_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_SO_A_HR_B_MODULE_FIRMWARE(api) \
 	IWL_SO_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_SO_A_GF_A_MODULE_FIRMWARE(api) \
-	IWL_SO_A_GF_A_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_TY_A_GF_A_MODULE_FIRMWARE(api) \
-	IWL_TY_A_GF_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_MA_A_HR_B_FW_MODULE_FIRMWARE(api)		\
 	IWL_MA_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_MA_A_GF_A_FW_MODULE_FIRMWARE(api)		\
-	IWL_MA_A_GF_A_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_MA_A_GF4_A_FW_MODULE_FIRMWARE(api)		\
-	IWL_MA_A_GF4_A_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_MA_A_MR_A_FW_MODULE_FIRMWARE(api) \
-	IWL_MA_A_MR_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_MA_B_HR_B_FW_MODULE_FIRMWARE(api)		\
 	IWL_MA_B_HR_B_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_MA_B_GF_A_FW_MODULE_FIRMWARE(api)		\
-	IWL_MA_B_GF_A_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_MA_B_GF4_A_FW_MODULE_FIRMWARE(api)		\
-	IWL_MA_B_GF4_A_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_MA_B_MR_A_FW_MODULE_FIRMWARE(api) \
-	IWL_MA_B_MR_A_FW_PRE "-" __stringify(api) ".ucode"
 
 static const struct iwl_base_params iwl_ax210_base_params = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
@@ -289,19 +273,13 @@ const struct iwl_cfg iwl_cfg_so_a0_hr_a0 = {
 
 MODULE_FIRMWARE(IWL_SO_A_JF_B_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SO_A_HR_B_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SO_A_GF_A_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_TY_A_GF_A_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
+IWL_FW_AND_PNVM(IWL_SO_A_GF_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_TY_A_GF_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
 MODULE_FIRMWARE(IWL_MA_A_HR_B_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_MA_A_GF_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_MA_A_GF4_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_MA_A_MR_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
+IWL_FW_AND_PNVM(IWL_MA_A_GF_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_MA_A_GF4_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_MA_A_MR_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
 MODULE_FIRMWARE(IWL_MA_B_HR_B_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_MA_B_GF_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_MA_B_GF4_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_MA_B_MR_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
-
-MODULE_FIRMWARE("iwlwifi-so-a0-gf-a0.pnvm");
-MODULE_FIRMWARE("iwlwifi-so-a0-gf4-a0.pnvm");
-MODULE_FIRMWARE("iwlwifi-ty-a0-gf-a0.pnvm");
-MODULE_FIRMWARE("iwlwifi-ma-b0-gf-a0.pnvm");
-MODULE_FIRMWARE("iwlwifi-ma-b0-gf4-a0.pnvm");
+IWL_FW_AND_PNVM(IWL_MA_B_GF_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_MA_B_GF4_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_MA_B_MR_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 33f5e110acb0..a9088b85290a 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -37,20 +37,6 @@
 
 #define IWL_BZ_A_HR_B_MODULE_FIRMWARE(api) \
 	IWL_BZ_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_BZ_A_GF_A_MODULE_FIRMWARE(api) \
-	IWL_BZ_A_GF_A_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_BZ_A_GF4_A_MODULE_FIRMWARE(api) \
-	IWL_BZ_A_GF4_A_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_BZ_A_FM_B_MODULE_FIRMWARE(api) \
-	IWL_BZ_A_FM_B_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_BZ_A_FM_C_MODULE_FIRMWARE(api) \
-	IWL_BZ_A_FM_C_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_BZ_A_FM4_B_MODULE_FIRMWARE(api) \
-	IWL_BZ_A_FM4_B_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_GL_B_FM_B_MODULE_FIRMWARE(api) \
-	IWL_GL_B_FM_B_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_GL_C_FM_C_MODULE_FIRMWARE(api) \
-	IWL_GL_C_FM_C_FW_PRE "-" __stringify(api) ".ucode"
 
 static const struct iwl_base_params iwl_bz_base_params = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
@@ -180,14 +166,11 @@ const struct iwl_cfg iwl_cfg_gl = {
 	.num_rbds = IWL_NUM_RBDS_BZ_EHT,
 };
 
-
 MODULE_FIRMWARE(IWL_BZ_A_HR_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BZ_A_GF_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BZ_A_GF4_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BZ_A_FM_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BZ_A_FM_C_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BZ_A_FM4_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_GL_B_FM_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_GL_C_FM_C_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-
-MODULE_FIRMWARE("iwlwifi-gl-c0-fm-c0.pnvm");
+IWL_FW_AND_PNVM(IWL_BZ_A_GF_A_FW_PRE, IWL_BZ_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_BZ_A_GF4_A_FW_PRE, IWL_BZ_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_BZ_A_FM_B_FW_PRE, IWL_BZ_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_BZ_A_FM_C_FW_PRE, IWL_BZ_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_BZ_A_FM4_B_FW_PRE, IWL_BZ_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_GL_B_FM_B_FW_PRE, IWL_BZ_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_GL_C_FM_C_FW_PRE, IWL_BZ_UCODE_API_MAX);
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 0422d7771b28..c9eeb3f6704e 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -38,28 +38,10 @@
 #define IWL_SC2F_A_FM_C_FW_PRE		"iwlwifi-sc2f-a0-fm-c0"
 #define IWL_SC2F_A_WH_A_FW_PRE		"iwlwifi-sc2f-a0-wh-a0"
 
-#define IWL_SC_A_FM_B_FW_MODULE_FIRMWARE(api) \
-	IWL_SC_A_FM_B_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_SC_A_FM_C_FW_MODULE_FIRMWARE(api) \
-	IWL_SC_A_FM_C_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_SC_A_HR_A_FW_MODULE_FIRMWARE(api) \
 	IWL_SC_A_HR_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_SC_A_HR_B_FW_MODULE_FIRMWARE(api) \
 	IWL_SC_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_SC_A_GF_A_FW_MODULE_FIRMWARE(api) \
-	IWL_SC_A_GF_A_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_SC_A_GF4_A_FW_MODULE_FIRMWARE(api) \
-	IWL_SC_A_GF4_A_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_SC_A_WH_A_FW_MODULE_FIRMWARE(api) \
-	IWL_SC_A_WH_A_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_SC2_A_FM_C_FW_MODULE_FIRMWARE(api) \
-	IWL_SC2_A_FM_C_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_SC2_A_WH_A_FW_MODULE_FIRMWARE(api) \
-	IWL_SC2_A_WH_A_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_SC2F_A_FM_C_FW_MODULE_FIRMWARE(api) \
-	IWL_SC2F_A_FM_C_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_SC2F_A_WH_A_FW_MODULE_FIRMWARE(api) \
-	IWL_SC2F_A_WH_A_FW_PRE "-" __stringify(api) ".ucode"
 
 static const struct iwl_base_params iwl_sc_base_params = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
@@ -181,14 +163,14 @@ const struct iwl_cfg iwl_cfg_sc2f = {
 	IWL_DEVICE_SC,
 };
 
-MODULE_FIRMWARE(IWL_SC_A_FM_B_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SC_A_FM_C_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
+IWL_FW_AND_PNVM(IWL_SC_A_FM_B_FW_PRE, IWL_SC_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_SC_A_FM_C_FW_PRE, IWL_SC_UCODE_API_MAX);
 MODULE_FIRMWARE(IWL_SC_A_HR_A_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SC_A_HR_B_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SC_A_GF_A_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SC_A_GF4_A_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SC_A_WH_A_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SC2_A_FM_C_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SC2_A_WH_A_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SC2F_A_FM_C_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SC2F_A_WH_A_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
+IWL_FW_AND_PNVM(IWL_SC_A_GF_A_FW_PRE, IWL_SC_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_SC_A_GF4_A_FW_PRE, IWL_SC_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_SC_A_WH_A_FW_PRE, IWL_SC_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_SC2_A_FM_C_FW_PRE, IWL_SC_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_SC2_A_WH_A_FW_PRE, IWL_SC_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_SC2F_A_FM_C_FW_PRE, IWL_SC_UCODE_API_MAX);
+IWL_FW_AND_PNVM(IWL_SC2F_A_WH_A_FW_PRE, IWL_SC_UCODE_API_MAX);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 88444d6c10e5..fa4f3ece58b2 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -103,6 +103,10 @@ enum iwl_nvm_type {
 #define ANT_ABC		(ANT_A | ANT_B | ANT_C)
 
 
+#define IWL_FW_AND_PNVM(pfx, api)				\
+	MODULE_FIRMWARE(pfx "-" __stringify(api) ".ucode");	\
+	MODULE_FIRMWARE(pfx ".pnvm")
+
 static inline u8 num_of_ant(u8 mask)
 {
 	return  !!((mask) & ANT_A) +
-- 
2.34.1


