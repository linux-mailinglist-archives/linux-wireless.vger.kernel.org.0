Return-Path: <linux-wireless+bounces-3105-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA578490F9
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 23:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE271F22B18
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 22:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD63633CCD;
	Sun,  4 Feb 2024 22:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W2JM7WBU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823A033CC8
	for <linux-wireless@vger.kernel.org>; Sun,  4 Feb 2024 22:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707084401; cv=none; b=e85jbNoBX5o11cOkCjXlrtMoabmW1VGfPtP0HbYn9Z2O2Vz9DEscfxJIAiZI1sOsZbuoSMhK79X7/pWNPGRVKR4N/VpVM9yWPgUU0L5vE3rCizT74Jht3B93K31js0LgkskK0nlHmAJ+GRf4BaRKOTvXRrk4Jao7U64sc3Ara0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707084401; c=relaxed/simple;
	bh=6mcMRw3EaU3ivCx+ToFTyzeEVXLwSTlVTO0/h+MjxHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hrCJISEbD+IoXCFfUld2TKNeCg1rxYVNN2DNIT+uSRiS0NHTjfj7wg2ShKoiyulm1xriyrhq/BvUYyfbxOQNIEpXK8OsO+Mcn1Ia2raoDq+9UKtI7MahqIkq2qNuQSkpYx0DaSSPKMEX/MmhA0jyDw1wH7pXtcHw/gHFdWXxGZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W2JM7WBU; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707084400; x=1738620400;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6mcMRw3EaU3ivCx+ToFTyzeEVXLwSTlVTO0/h+MjxHc=;
  b=W2JM7WBUWNgEPtrDoUHWMyeodIgaJ8yA1APmo1xvCFChZO5molrm85Od
   7tl3unMi38EG6yXn6lUZ63YrQvVQ5HYLWlphyKGeItp2Lkr7CwINZ6xOy
   u0Mv49RZm5+lW5E4Uit4igR+7po/wN+dKi9lwt8KiUoBMAI+8KSkFXQVG
   JPeBOeLXDg16EucfdxtcKICJsY1nuIfLVd6bfFhXhEQbEh/aW2UVCn4KY
   ZELy3qD+3OhOCF/ZscyGOCi/3CqaxEwvDCllX4Gc7xuzZHVPUXhmsyPbp
   KusdcieUrXmEfr8G3bBTrj4uM5L5uuM50uKgErMOxlyKm8TZmTjW7a6YS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="25869370"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="25869370"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 14:06:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="23815863"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 14:06:38 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH 04/15] wifi: iwlwifi: Add support for PPAG cmd v5 and PPAG revision 3
Date: Mon,  5 Feb 2024 00:06:06 +0200
Message-Id: <20240204235836.d17425824b11.If2c1b29e3c579f4135383681af2d625cfe2cffcd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204220617.1456895-1-miriam.rachel.korenblit@intel.com>
References: <20240204220617.1456895-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Add support for
- PPAG revision 3 in BIOS to enable PPAG in UHB
- PPAG command version 5, this command allows OEM to control
  enablement of PPAG for LPI for UHB mode in USA and ETSI countries.

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  9 +++--
 .../net/wireless/intel/iwlwifi/fw/api/power.h | 40 +++++++++++++++++--
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 20 ++++++----
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  9 ++++-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  |  3 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  |  3 +-
 7 files changed, 66 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 9afb1b1d6aea..82ecea00f2b3 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -817,15 +817,15 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	/* try to read ppag table rev 2 or 1 (both have the same data size) */
+	/* try to read ppag table rev 3, 2 or 1 (all have the same data size) */
 	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
 				ACPI_PPAG_WIFI_DATA_SIZE_V2, &tbl_rev);
 
 	if (!IS_ERR(wifi_pkg)) {
-		if (tbl_rev == 1 || tbl_rev == 2) {
+		if (tbl_rev >= 1 && tbl_rev <= 3) {
 			num_sub_bands = IWL_NUM_SUB_BANDS_V2;
 			IWL_DEBUG_RADIO(fwrt,
-					"Reading PPAG table v2 (tbl_rev=%d)\n",
+					"Reading PPAG table (tbl_rev=%d)\n",
 					tbl_rev);
 			goto read_table;
 		} else {
@@ -857,7 +857,8 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 		goto out_free;
 	}
 
-	fwrt->ppag_flags = flags->integer.value & IWL_PPAG_ETSI_CHINA_MASK;
+	fwrt->ppag_flags = iwl_bios_get_ppag_flags(flags->integer.value,
+						   fwrt->ppag_ver);
 
 	/*
 	 * read, verify gain values and save them into the PPAG table.
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 040d83fa5424..0bf38243f88a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -505,14 +505,41 @@ struct iwl_geo_tx_power_profiles_resp {
 	__le32 profile_idx;
 } __packed; /* PER_CHAIN_LIMIT_OFFSET_RSP */
 
+/**
+ * enum iwl_ppag_flags - PPAG enable masks
+ * @IWL_PPAG_ETSI_MASK: enable PPAG in ETSI
+ * @IWL_PPAG_CHINA_MASK: enable PPAG in China
+ * @IWL_PPAG_ETSI_LPI_UHB_MASK: enable LPI in ETSI for UHB
+ * @IWL_PPAG_ETSI_VLP_UHB_MASK: enable VLP in ETSI for UHB
+ * @IWL_PPAG_ETSI_SP_UHB_MASK: enable SP in ETSI for UHB
+ * @IWL_PPAG_USA_LPI_UHB_MASK: enable LPI in USA for UHB
+ * @IWL_PPAG_USA_VLP_UHB_MASK: enable VLP in USA for UHB
+ * @IWL_PPAG_USA_SP_UHB_MASK: enable SP in USA for UHB
+ * @IWL_PPAG_CANADA_LPI_UHB_MASK: enable LPI in CANADA for UHB
+ * @IWL_PPAG_CANADA_VLP_UHB_MASK: enable VLP in CANADA for UHB
+ * @IWL_PPAG_CANADA_SP_UHB_MASK: enable SP in CANADA for UHB
+ */
+enum iwl_ppag_flags {
+	IWL_PPAG_ETSI_MASK = BIT(0),
+	IWL_PPAG_CHINA_MASK = BIT(1),
+	IWL_PPAG_ETSI_LPI_UHB_MASK = BIT(2),
+	IWL_PPAG_ETSI_VLP_UHB_MASK = BIT(3),
+	IWL_PPAG_ETSI_SP_UHB_MASK = BIT(4),
+	IWL_PPAG_USA_LPI_UHB_MASK = BIT(5),
+	IWL_PPAG_USA_VLP_UHB_MASK = BIT(6),
+	IWL_PPAG_USA_SP_UHB_MASK = BIT(7),
+	IWL_PPAG_CANADA_LPI_UHB_MASK = BIT(8),
+	IWL_PPAG_CANADA_VLP_UHB_MASK = BIT(9),
+	IWL_PPAG_CANADA_SP_UHB_MASK = BIT(10),
+};
+
 /**
  * union iwl_ppag_table_cmd - union for all versions of PPAG command
  * @v1: version 1
  * @v2: version 2
- *
- * @flags: bit 0 - indicates enablement of PPAG for ETSI
- *         bit 1 - indicates enablement of PPAG for CHINA BIOS
- *         bit 1 can be used only in v3 (identical to v2)
+ * version 3, 4 and 5 are the same structure as v2,
+ *	but has a different format of the flags bitmap
+ * @flags: values from &enum iwl_ppag_flags
  * @gain: table of antenna gain values per chain and sub-band
  * @reserved: reserved
  */
@@ -529,6 +556,11 @@ union iwl_ppag_table_cmd {
 	} v2;
 } __packed;
 
+#define IWL_PPAG_CMD_V4_MASK (IWL_PPAG_ETSI_MASK | IWL_PPAG_CHINA_MASK)
+#define IWL_PPAG_CMD_V5_MASK (IWL_PPAG_CMD_V4_MASK | \
+			      IWL_PPAG_ETSI_LPI_UHB_MASK | \
+			      IWL_PPAG_USA_LPI_UHB_MASK)
+
 #define MCC_TO_SAR_OFFSET_TABLE_ROW_SIZE	26
 #define MCC_TO_SAR_OFFSET_TABLE_COL_SIZE	13
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 597735a660a2..36d506463e0e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -320,7 +320,7 @@ int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
 					WIDE_ID(PHY_OPS_GROUP,
 						PER_PLATFORM_ANT_GAIN_CMD), 1);
 	/*
-	 * Starting from ver 4, driver needs to send the PPAG CMD regradless
+	 * Starting from ver 4, driver needs to send the PPAG CMD regardless
 	 * if PPAG is enabled/disabled or valid/invalid.
 	 */
 	send_ppag_always = cmd_ver > 3;
@@ -341,18 +341,18 @@ int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
 		num_sub_bands = IWL_NUM_SUB_BANDS_V1;
 		gain = cmd->v1.gain[0];
 		*cmd_size = sizeof(cmd->v1);
-		if (fwrt->ppag_ver == 1 || fwrt->ppag_ver == 2) {
+		if (fwrt->ppag_ver >= 1) {
 			/* in this case FW supports revision 0 */
 			IWL_DEBUG_RADIO(fwrt,
 					"PPAG table rev is %d, send truncated table\n",
 					fwrt->ppag_ver);
 		}
-	} else if (cmd_ver >= 2 && cmd_ver <= 4) {
+	} else if (cmd_ver >= 2 && cmd_ver <= 5) {
 		num_sub_bands = IWL_NUM_SUB_BANDS_V2;
 		gain = cmd->v2.gain[0];
 		*cmd_size = sizeof(cmd->v2);
 		if (fwrt->ppag_ver == 0) {
-			/* in this case FW supports revisions 1 or 2 */
+			/* in this case FW supports revisions 1,2 or 3 */
 			IWL_DEBUG_RADIO(fwrt,
 					"PPAG table rev is 0, send padded table\n");
 		}
@@ -364,11 +364,17 @@ int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
 	/* ppag mode */
 	IWL_DEBUG_RADIO(fwrt,
 			"PPAG MODE bits were read from bios: %d\n",
-			cmd->v1.flags);
+			le32_to_cpu(cmd->v1.flags));
+
+	if (cmd_ver == 5)
+		cmd->v1.flags &= cpu_to_le32(IWL_PPAG_CMD_V5_MASK);
+	else if (cmd_ver < 5)
+		cmd->v1.flags &= cpu_to_le32(IWL_PPAG_CMD_V4_MASK);
+
 	if ((cmd_ver == 1 &&
 	     !fw_has_capa(&fwrt->fw->ucode_capa,
 			  IWL_UCODE_TLV_CAPA_PPAG_CHINA_BIOS_SUPPORT)) ||
-	    (cmd_ver == 2 && fwrt->ppag_ver == 2)) {
+	    (cmd_ver == 2 && fwrt->ppag_ver >= 2)) {
 		cmd->v1.flags &= cpu_to_le32(IWL_PPAG_ETSI_MASK);
 		IWL_DEBUG_RADIO(fwrt, "masking ppag China bit\n");
 	} else {
@@ -377,7 +383,7 @@ int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
 
 	IWL_DEBUG_RADIO(fwrt,
 			"PPAG MODE bits going to be sent: %d\n",
-			cmd->v1.flags);
+			le32_to_cpu(cmd->v1.flags));
 
 	for (i = 0; i < IWL_NUM_CHAIN_LIMITS; i++) {
 		for (j = 0; j < num_sub_bands; j++) {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index 52389f82cbb9..28e774766847 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -37,7 +37,7 @@
 #define IWL_PPAG_MAX_HB 40
 
 #define IWL_PPAG_ETSI_CHINA_MASK	3
-#define IWL_PPAG_ETSI_MASK		BIT(0)
+#define IWL_PPAG_REV3_MASK		0x7FF
 
 #define IWL_WTAS_BLACK_LIST_MAX	16
 #define IWL_WTAS_ENABLED_MSK		0x1
@@ -189,4 +189,11 @@ __le32 iwl_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt);
 
 int iwl_bios_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
 		     u32 *value);
+
+static inline u32 iwl_bios_get_ppag_flags(const u32 ppag_modes,
+					  const u8 ppag_ver)
+{
+	return ppag_modes & (ppag_ver < 3 ? IWL_PPAG_ETSI_CHINA_MASK :
+					    IWL_PPAG_REV3_MASK);
+}
 #endif /* __fw_regulatory_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 16d9ea6dd386..bd0c9b2224e1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -174,7 +174,7 @@ struct iwl_fw_runtime {
 	bool geo_enabled;
 	struct iwl_ppag_chain ppag_chains[IWL_NUM_CHAIN_LIMITS];
 	u32 ppag_flags;
-	u32 ppag_ver;
+	u8 ppag_ver;
 #ifdef CONFIG_ACPI
 	struct iwl_sar_offset_mapping_cmd sgom_table;
 	bool sgom_enabled;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index fe6d0141cd5b..39015a222f96 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -541,7 +541,8 @@ int iwl_uefi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 	}
 
 	fwrt->ppag_ver = data->revision;
-	fwrt->ppag_flags = data->ppag_modes & IWL_PPAG_ETSI_CHINA_MASK;
+	fwrt->ppag_flags = iwl_bios_get_ppag_flags(data->ppag_modes,
+						   fwrt->ppag_ver);
 
 	BUILD_BUG_ON(sizeof(fwrt->ppag_chains) != sizeof(data->ppag_chains));
 	memcpy(&fwrt->ppag_chains, &data->ppag_chains,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 1f7c3f4c2901..39053290bd59 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -116,8 +116,7 @@ struct uefi_cnv_var_wgds {
 /*
  * struct uefi_cnv_var_ppag - PPAG table as defined in UEFI
  * @revision: the revision of the table
- * @ppag_modes: bit 0 - PPAG is enabled/disabled in ETSI,
- *	bit 1 - PPAG is enabled/disabled in China
+ * @ppag_modes: values from &enum iwl_ppag_flags
  * @ppag_chains: the PPAG values per chain and band
  */
 struct uefi_cnv_var_ppag {
-- 
2.34.1


