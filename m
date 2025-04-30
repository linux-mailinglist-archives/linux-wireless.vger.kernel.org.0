Return-Path: <linux-wireless+bounces-22256-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D82AA4B12
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 14:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ABB21BC3462
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 12:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1178E25B68F;
	Wed, 30 Apr 2025 12:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FG2fhDf5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2A725A33D
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746015905; cv=none; b=ScyM5sulBMmVyWsvTGxXH0yqGcGuWC0Oaz1y76Q2EtQlP6fof4BnmaFbNYPl+puJfCGrr5EZw9pmv6ypoAodtK/OkSollU4wzlQD5eg6BZiHs6q/SqyEFOCYr5e/3nuK0fJji8xtuw64Og4AVtuEyZDo2AapHBrXCF04F5iOzp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746015905; c=relaxed/simple;
	bh=fHvmKbD+3qW8W9mSM2sAi6M98o4JUE5JKVWgUNiVjN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vC16VVpupVxxmC0F34QNl7TyOFPgNX7eDgZL43f0ja9xz/vL4mBMRA4pfoT5R5XY5BoO8zhCt2ngmTsGX3vJS908atjxx1hJQWFlKtZEy54As3jctg9LM6XUYPmLjbaCVVpYUz1OfE6A7RLpXQRiKUa0udNINA7kzC6PBkMG7Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FG2fhDf5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746015904; x=1777551904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fHvmKbD+3qW8W9mSM2sAi6M98o4JUE5JKVWgUNiVjN4=;
  b=FG2fhDf5kra1s0aaLfCpNkPwLnbMGfhWqo2kUkpqGZuYDDpU6yEWc9F7
   9Y7bKnQiIcNCjw5XZFEswbHgaXVrslgLCfU0W1ZWPizSkNfoRJaJrfV/P
   9Bl663WnMQvofXjrMaJ5aFk3cbxbBcWxx8757sx781j5f819q2gzPUwp4
   UPt7nDuHVTMtJDiS3o41MXeFtvlNoa/dOYyWftB6a6vc+hg1xNCFDKyNX
   dtFpEGdgjJ3v5CQOhv2Bcanc/QN6KumXy6FQZtSy0pN50WI09hyzhmNrM
   5qCBiJt4jPxAMGenX9pxtKvgzG7jEZrcA72g3gIabqVGsr51rwRShlGAR
   w==;
X-CSE-ConnectionGUID: PAI7jnWDSEW966v0iPgm3g==
X-CSE-MsgGUID: iU6Mb3t6QM6XXiwQ7DEcxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47578293"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="47578293"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:25:04 -0700
X-CSE-ConnectionGUID: mXaFVcwbRXqHs0joikl/hA==
X-CSE-MsgGUID: 43GOLKcoRWiZ/XjPMJ9y4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="135087902"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:25:03 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH v2 iwlwifi-next 13/14] wifi: iwlwifi: fw: support reading PPAG BIOS table revision 4
Date: Wed, 30 Apr 2025 15:23:19 +0300
Message-Id: <20250430151952.f1cb31f9f6ab.I56d6887866f76fd02b2cd298e3de1189c6d3890e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430122320.1061510-1-miriam.rachel.korenblit@intel.com>
References: <20250430122320.1061510-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

PPAG revision 4 data has more supported bits than supported in
version 6 of PPAG command. So, adjust by masking accordingly to
firmware acceptance.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       | 4 ++--
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  | 9 +++++++++
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c | 4 +++-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h | 4 ++++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h       | 2 +-
 5 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 68b461297174..a1c949d15d94 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -847,12 +847,12 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	/* try to read ppag table rev 3, 2 or 1 (all have the same data size) */
+	/* try to read ppag table rev 1 to 4 (all have the same data size) */
 	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
 				ACPI_PPAG_WIFI_DATA_SIZE_V2, &tbl_rev);
 
 	if (!IS_ERR(wifi_pkg)) {
-		if (tbl_rev >= 1 && tbl_rev <= 3) {
+		if (tbl_rev >= 1 && tbl_rev <= 4) {
 			num_sub_bands = IWL_NUM_SUB_BANDS_V2;
 			IWL_DEBUG_RADIO(fwrt,
 					"Reading PPAG table (tbl_rev=%d)\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 1238c23ac48b..1c09c30055b1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -658,6 +658,15 @@ union iwl_ppag_table_cmd {
 			      IWL_PPAG_ETSI_LPI_UHB_MASK | \
 			      IWL_PPAG_USA_LPI_UHB_MASK)
 
+#define IWL_PPAG_CMD_V6_MASK (IWL_PPAG_CMD_V5_MASK |		\
+			      IWL_PPAG_ETSI_VLP_UHB_MASK |	\
+			      IWL_PPAG_ETSI_SP_UHB_MASK |	\
+			      IWL_PPAG_USA_VLP_UHB_MASK |	\
+			      IWL_PPAG_USA_SP_UHB_MASK |	\
+			      IWL_PPAG_CANADA_LPI_UHB_MASK |	\
+			      IWL_PPAG_CANADA_VLP_UHB_MASK |	\
+			      IWL_PPAG_CANADA_SP_UHB_MASK)
+
 #define MCC_TO_SAR_OFFSET_TABLE_ROW_SIZE	26
 #define MCC_TO_SAR_OFFSET_TABLE_COL_SIZE	13
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index bb8ddfad8621..4508de2508d7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -374,7 +374,9 @@ int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
 			"PPAG MODE bits were read from bios: %d\n",
 			le32_to_cpu(cmd->v1.flags));
 
-	if (cmd_ver == 5)
+	if (cmd_ver == 6)
+		cmd->v1.flags &= cpu_to_le32(IWL_PPAG_CMD_V6_MASK);
+	else if (cmd_ver == 5)
 		cmd->v1.flags &= cpu_to_le32(IWL_PPAG_CMD_V5_MASK);
 	else if (cmd_ver < 5)
 		cmd->v1.flags &= cpu_to_le32(IWL_PPAG_CMD_V4_MASK);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index 641b4463e898..bd5c0a27718c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -226,6 +226,10 @@ int iwl_bios_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
 static inline u32 iwl_bios_get_ppag_flags(const u32 ppag_modes,
 					  const u8 ppag_bios_rev)
 {
+	/* For revision 4 and above driver is pipe */
+	if (ppag_bios_rev >= 4)
+		return ppag_modes;
+
 	return ppag_modes & (ppag_bios_rev < 3 ? IWL_PPAG_ETSI_CHINA_MASK :
 						 IWL_PPAG_REV3_MASK);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 37d2ced03ce1..ace36cb081e6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -34,7 +34,7 @@
 #define IWL_UEFI_EWRD_REVISION		2
 #define IWL_UEFI_WGDS_REVISION		3
 #define IWL_UEFI_MIN_PPAG_REV		1
-#define IWL_UEFI_MAX_PPAG_REV		3
+#define IWL_UEFI_MAX_PPAG_REV		4
 #define IWL_UEFI_MIN_WTAS_REVISION	1
 #define IWL_UEFI_MAX_WTAS_REVISION	2
 #define IWL_UEFI_SPLC_REVISION		0
-- 
2.34.1


