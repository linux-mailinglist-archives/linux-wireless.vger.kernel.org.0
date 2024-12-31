Return-Path: <linux-wireless+bounces-16942-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CBB9FEF41
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 13:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8AC3A306A
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 12:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4636C19CC17;
	Tue, 31 Dec 2024 11:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/jYABG5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244B919CC33
	for <linux-wireless@vger.kernel.org>; Tue, 31 Dec 2024 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735646386; cv=none; b=N4v0rGlKRZ1SUb2dvADN1RgIsZDIweo8U5LwTC5SlrZxC647kvP7dOgebRQz6LXdHT7+tPCq4dUK0gZdaq3aSEZJAerQhz0vu6ju0OwFAVuSXfRTClGRHZsWu9FvFbZXLE7FdUGlNjsmbGPWsvLrin3pAP987zXjtQFowzgKv8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735646386; c=relaxed/simple;
	bh=9L468O1BCpBLYKW7uIfNuZr04z7DbUA3VkCQcKSzPR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EWnX3vw2nz3M6YkDPRt5awItyLX/FF6R6mnt4+WupDrwdXFrzmHAjwKWyWTjTM03kAVWjdAlDKnWczx1aLxHSSfSel+4eipC9PrIeDrEkOiFtMrdjsIDi2BCbtRuJtjwgzf1BLuqV/wRE5q4ESGOatbmjkug2WbrFzneWyzSiJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/jYABG5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735646384; x=1767182384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9L468O1BCpBLYKW7uIfNuZr04z7DbUA3VkCQcKSzPR8=;
  b=G/jYABG5BsP9KZBjjN2MxDFppiMNmAsGOB8r9DoF97VpjC7xdr/mY6KC
   EMRY+bBqVv5E06e6ThQLlkavQmW/V70XypnXXEB1LwI3VJLOTl5JAK8sg
   09W6vVkVLAL/mMVHtfsJutv7sXyZFLccGpmH+DaM//BFn9ZbbjiE00vDB
   CaADoDIHRz1yoHUCpifAN7v4U9fHffD1PCjKuaLqdNjGxHbZAN82CcpDX
   PaRGhXxgDRgRkZTUVTJEly/dm0umhEdwctCb0OxiXAaETfBzq7cY5sZBw
   n9YO5kNkdakFUBcQ5KkjkJx+QM+W9knBX4iSbE6mXAtTNvKjIDMBUhqGO
   Q==;
X-CSE-ConnectionGUID: 8u8R1l/mReGj7flMGMD06w==
X-CSE-MsgGUID: yW8pTgjtT+y0jxI2+IG+jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="53330187"
X-IronPort-AV: E=Sophos;i="6.12,279,1728975600"; 
   d="scan'208";a="53330187"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:44 -0800
X-CSE-ConnectionGUID: 6IlncFcGREGGVsSraBgrCA==
X-CSE-MsgGUID: f3Dusu6zST+13mER7Q4fvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="138380322"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:43 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH 10/15] wifi: iwlwifi: extend TAS_CONFIG cmd support for v5
Date: Tue, 31 Dec 2024 13:59:10 +0200
Message-Id: <20241231135726.f46d58e7cfd1.Ifd81e632fa3e7039b8d139ee0d1c24e09669dff5@changeid>
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

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Extend TAS_CONFIG to send exact data read from bios to firmware
without filtering/altering bios data. This enables driver becoming
purely a pipe for TAS features.

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 46 +++++-----
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   | 42 ++++++++-
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 35 ++++----
 .../wireless/intel/iwlwifi/fw/regulatory.h    | 29 +++---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 28 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 90 ++++++++++++-------
 6 files changed, 169 insertions(+), 101 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 747b18ebbd66..efa7b673ebc7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -262,13 +262,14 @@ int iwl_acpi_get_tas_table(struct iwl_fw_runtime *fwrt,
 			   struct iwl_tas_data *tas_data)
 {
 	union acpi_object *wifi_pkg, *data;
-	int ret, tbl_rev, i, block_list_size, enabled;
+	int ret, tbl_rev, block_list_size, enabled;
+	u32 tas_selection;
 
 	data = iwl_acpi_get_object(fwrt->dev, ACPI_WTAS_METHOD);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	/* try to read wtas table revision 1 or revision 0*/
+	/* try to read wtas table */
 	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
 					 ACPI_WTAS_WIFI_DATA_SIZE,
 					 &tbl_rev);
@@ -277,27 +278,23 @@ int iwl_acpi_get_tas_table(struct iwl_fw_runtime *fwrt,
 		goto out_free;
 	}
 
-	if ((tbl_rev == 2 || tbl_rev == 1) &&
-	    wifi_pkg->package.elements[1].type == ACPI_TYPE_INTEGER) {
-		u32 tas_selection =
-			(u32)wifi_pkg->package.elements[1].integer.value;
-
-		enabled = iwl_parse_tas_selection(fwrt, tas_data,
-						  tas_selection, tbl_rev);
-
-	} else if (tbl_rev == 0 &&
-		wifi_pkg->package.elements[1].type == ACPI_TYPE_INTEGER) {
-		enabled = !!wifi_pkg->package.elements[1].integer.value;
-	} else {
+	if (tbl_rev < 0 || tbl_rev > 2 ||
+	    wifi_pkg->package.elements[1].type != ACPI_TYPE_INTEGER) {
 		ret = -EINVAL;
 		goto out_free;
 	}
 
-	if (!enabled) {
-		IWL_DEBUG_RADIO(fwrt, "TAS not enabled\n");
-		ret = 0;
-		goto out_free;
-	}
+	tas_selection = (u32)wifi_pkg->package.elements[1].integer.value;
+	enabled = tas_selection & IWL_WTAS_ENABLED_MSK;
+
+	IWL_DEBUG_RADIO(fwrt, "TAS selection as read from BIOS: 0x%x\n",
+			tas_selection);
+	tas_data->table_source = BIOS_SOURCE_ACPI;
+	tas_data->table_revision = tbl_rev;
+	tas_data->tas_selection = tas_selection;
+
+	IWL_DEBUG_RADIO(fwrt, "TAS %s enabled\n",
+			enabled ? "is" : "not");
 
 	IWL_DEBUG_RADIO(fwrt, "Reading TAS table revision %d\n", tbl_rev);
 	if (wifi_pkg->package.elements[2].type != ACPI_TYPE_INTEGER ||
@@ -308,13 +305,14 @@ int iwl_acpi_get_tas_table(struct iwl_fw_runtime *fwrt,
 		ret = -EINVAL;
 		goto out_free;
 	}
+
 	block_list_size = wifi_pkg->package.elements[2].integer.value;
-	tas_data->block_list_size = cpu_to_le32(block_list_size);
+	tas_data->block_list_size = block_list_size;
 
 	IWL_DEBUG_RADIO(fwrt, "TAS array size %u\n", block_list_size);
 
-	for (i = 0; i < block_list_size; i++) {
-		u32 country;
+	for (int i = 0; i < block_list_size; i++) {
+		u16 country;
 
 		if (wifi_pkg->package.elements[3 + i].type !=
 		    ACPI_TYPE_INTEGER) {
@@ -325,11 +323,11 @@ int iwl_acpi_get_tas_table(struct iwl_fw_runtime *fwrt,
 		}
 
 		country = wifi_pkg->package.elements[3 + i].integer.value;
-		tas_data->block_list_array[i] = cpu_to_le32(country);
+		tas_data->block_list_array[i] = country;
 		IWL_DEBUG_RADIO(fwrt, "TAS block list country %d\n", country);
 	}
 
-	ret = 1;
+	ret = enabled;
 out_free:
 	kfree(data);
 	return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index 1bf549775c7c..5cdc09d465d4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -487,7 +487,7 @@ struct iwl_tas_config_cmd_v4 {
 	u8 uhb_allowed_flags;
 } __packed; /* TAS_CONFIG_CMD_API_S_VER_4 */
 
-struct iwl_tas_config_cmd {
+struct iwl_tas_config_cmd_v2_v4 {
 	struct iwl_tas_config_cmd_common common;
 	union {
 		struct iwl_tas_config_cmd_v3 v3;
@@ -495,6 +495,46 @@ struct iwl_tas_config_cmd {
 	};
 };
 
+/**
+ * enum bios_source - source of bios data
+ * @BIOS_SOURCE_NONE: BIOS source is not defined
+ * @BIOS_SOURCE_ACPI: BIOS source is ACPI
+ * @BIOS_SOURCE_UEFI: BIOS source is UEFI
+ */
+enum bios_source {
+	BIOS_SOURCE_NONE,
+	BIOS_SOURCE_ACPI,
+	BIOS_SOURCE_UEFI,
+};
+
+/**
+ * struct bios_value_u32 - BIOS configuration.
+ * @table_source: see &enum bios_source
+ * @table_revision: table revision.
+ * @reserved: reserved
+ * @value: value in bios.
+ */
+struct bios_value_u32 {
+	u8 table_source;
+	u8 table_revision;
+	u8 reserved[2];
+	__le32 value;
+} __packed; /* BIOS_TABLE_SOURCE_U32_S_VER_1 */
+
+/**
+ * struct iwl_tas_config_cmd - configures the TAS.
+ * @block_list_size: size of relevant field in block_list_array
+ * @block_list_array: list of countries where TAS must be disabled
+ * @reserved: reserved
+ * @tas_config_info: see @struct bios_value_u32
+ */
+struct iwl_tas_config_cmd {
+	__le16 block_list_size;
+	__le16 block_list_array[IWL_WTAS_BLACK_LIST_MAX];
+	u8 reserved[2];
+	struct bios_value_u32 tas_config_info;
+} __packed; /* TAS_CONFIG_CMD_API_S_VER_5 */
+
 /**
  * enum iwl_lari_config_masks - bit masks for the various LARI config operations
  * @LARI_CONFIG_DISABLE_11AC_UKRAINE_MSK: disable 11ac in ukraine
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 27423202a864..ea435ee94312 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -430,30 +430,31 @@ bool iwl_is_tas_approved(void)
 }
 IWL_EXPORT_SYMBOL(iwl_is_tas_approved);
 
-int iwl_parse_tas_selection(struct iwl_fw_runtime *fwrt,
-			    struct iwl_tas_data *tas_data,
-			    const u32 tas_selection, u8 tbl_rev)
+struct iwl_tas_selection_data
+iwl_parse_tas_selection(const u32 tas_selection_in, const u8 tbl_rev)
 {
-	u8 override_iec = u32_get_bits(tas_selection,
+	struct iwl_tas_selection_data tas_selection_out = {};
+	u8 override_iec = u32_get_bits(tas_selection_in,
 				       IWL_WTAS_OVERRIDE_IEC_MSK);
-	u8 canada_tas_uhb = u32_get_bits(tas_selection,
+	u8 canada_tas_uhb = u32_get_bits(tas_selection_in,
 					 IWL_WTAS_CANADA_UHB_MSK);
-	u8 enabled_iec = u32_get_bits(tas_selection, IWL_WTAS_ENABLE_IEC_MSK);
-	u8 usa_tas_uhb = u32_get_bits(tas_selection, IWL_WTAS_USA_UHB_MSK);
-	int enabled = tas_selection & IWL_WTAS_ENABLED_MSK;
-
-	IWL_DEBUG_RADIO(fwrt, "TAS selection as read from BIOS: 0x%x\n",
-			tas_selection);
-
-	tas_data->usa_tas_uhb_allowed = usa_tas_uhb;
-	tas_data->override_tas_iec = override_iec;
-	tas_data->enable_tas_iec = enabled_iec;
+	u8 enabled_iec = u32_get_bits(tas_selection_in,
+				      IWL_WTAS_ENABLE_IEC_MSK);
+	u8 usa_tas_uhb = u32_get_bits(tas_selection_in,
+				      IWL_WTAS_USA_UHB_MSK);
+
+	if (tbl_rev > 0) {
+		tas_selection_out.usa_tas_uhb_allowed = usa_tas_uhb;
+		tas_selection_out.override_tas_iec = override_iec;
+		tas_selection_out.enable_tas_iec = enabled_iec;
+	}
 
 	if (tbl_rev > 1)
-		tas_data->canada_tas_uhb_allowed = canada_tas_uhb;
+		tas_selection_out.canada_tas_uhb_allowed = canada_tas_uhb;
 
-	return enabled;
+	return tas_selection_out;
 }
+IWL_EXPORT_SYMBOL(iwl_parse_tas_selection);
 
 static __le32 iwl_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index afdc0ec75ba5..b355d7bef14c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -40,12 +40,19 @@
 #define IWL_PPAG_ETSI_CHINA_MASK	3
 #define IWL_PPAG_REV3_MASK		0x7FF
 
-#define IWL_WTAS_ENABLED_MSK		0x1
-#define IWL_WTAS_OVERRIDE_IEC_MSK	0x2
-#define IWL_WTAS_ENABLE_IEC_MSK	0x4
+#define IWL_WTAS_ENABLED_MSK		BIT(0)
+#define IWL_WTAS_OVERRIDE_IEC_MSK	BIT(1)
+#define IWL_WTAS_ENABLE_IEC_MSK		BIT(2)
 #define IWL_WTAS_CANADA_UHB_MSK		BIT(15)
 #define IWL_WTAS_USA_UHB_MSK		BIT(16)
 
+struct iwl_tas_selection_data {
+	u8 override_tas_iec:1,
+	   enable_tas_iec:1,
+	   usa_tas_uhb_allowed:1,
+	   canada_tas_uhb_allowed:1;
+};
+
 #define BIOS_MCC_CHINA 0x434e
 
 /*
@@ -98,12 +105,11 @@ struct iwl_ppag_chain {
 };
 
 struct iwl_tas_data {
-	__le32 block_list_size;
-	__le32 block_list_array[IWL_WTAS_BLACK_LIST_MAX];
-	u8 override_tas_iec:1,
-	   enable_tas_iec:1,
-	   usa_tas_uhb_allowed:1,
-	   canada_tas_uhb_allowed:1;
+	u8 block_list_size;
+	u16 block_list_array[IWL_WTAS_BLACK_LIST_MAX];
+	u8 table_source;
+	u8 table_revision;
+	u32 tas_selection;
 };
 
 /* For DSM revision 0 and 4 */
@@ -185,9 +191,8 @@ bool iwl_is_ppag_approved(struct iwl_fw_runtime *fwrt);
 
 bool iwl_is_tas_approved(void);
 
-int iwl_parse_tas_selection(struct iwl_fw_runtime *fwrt,
-			    struct iwl_tas_data *tas_data,
-			    const u32 tas_selection, u8 tbl_rev);
+struct iwl_tas_selection_data
+iwl_parse_tas_selection(const u32 tas_selection, const u8 tbl_rev);
 
 int iwl_bios_get_wrds_table(struct iwl_fw_runtime *fwrt);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index cc7659d59cf0..434eed4130b9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -570,7 +570,7 @@ int iwl_uefi_get_tas_table(struct iwl_fw_runtime *fwrt,
 			   struct iwl_tas_data *tas_data)
 {
 	struct uefi_cnv_var_wtas *uefi_tas;
-	int ret = 0, enabled, i;
+	int ret, enabled;
 
 	uefi_tas = iwl_uefi_get_verified_variable(fwrt->trans, IWL_UEFI_WTAS_NAME,
 						  "WTAS", sizeof(*uefi_tas), NULL);
@@ -585,15 +585,16 @@ int iwl_uefi_get_tas_table(struct iwl_fw_runtime *fwrt,
 		goto out;
 	}
 
-	enabled = iwl_parse_tas_selection(fwrt, tas_data,
-					  uefi_tas->tas_selection,
-					  uefi_tas->revision);
+	IWL_DEBUG_RADIO(fwrt, "TAS selection as read from BIOS: 0x%x\n",
+			uefi_tas->tas_selection);
 
-	if (!enabled) {
-		IWL_DEBUG_RADIO(fwrt, "TAS not enabled\n");
-		ret = 0;
-		goto out;
-	}
+	enabled = uefi_tas->tas_selection & IWL_WTAS_ENABLED_MSK;
+	tas_data->table_source = BIOS_SOURCE_UEFI;
+	tas_data->table_revision = uefi_tas->revision;
+	tas_data->tas_selection = uefi_tas->tas_selection;
+
+	IWL_DEBUG_RADIO(fwrt, "TAS %s enabled\n",
+			enabled ? "is" : "not");
 
 	IWL_DEBUG_RADIO(fwrt, "Reading TAS table revision %d\n",
 			uefi_tas->revision);
@@ -603,15 +604,16 @@ int iwl_uefi_get_tas_table(struct iwl_fw_runtime *fwrt,
 		ret = -EINVAL;
 		goto out;
 	}
-	tas_data->block_list_size = cpu_to_le32(uefi_tas->black_list_size);
+
+	tas_data->block_list_size = uefi_tas->black_list_size;
 	IWL_DEBUG_RADIO(fwrt, "TAS array size %u\n", uefi_tas->black_list_size);
 
-	for (i = 0; i < uefi_tas->black_list_size; i++) {
-		tas_data->block_list_array[i] =
-			cpu_to_le32(uefi_tas->black_list[i]);
+	for (u8 i = 0; i < uefi_tas->black_list_size; i++) {
+		tas_data->block_list_array[i] = uefi_tas->black_list[i];
 		IWL_DEBUG_RADIO(fwrt, "TAS block list country %d\n",
 				uefi_tas->black_list[i]);
 	}
+	ret = enabled;
 out:
 	kfree(uefi_tas);
 	return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 52056f489797..df49dd2e2026 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1094,36 +1094,40 @@ static int iwl_mvm_ppag_init(struct iwl_mvm *mvm)
 	return iwl_mvm_ppag_send_cmd(mvm);
 }
 
-static bool iwl_mvm_add_to_tas_block_list(__le32 *list, __le32 *le_size, unsigned int mcc)
+static bool
+iwl_mvm_add_to_tas_block_list(u16 *list, u8 *size, u16 mcc)
 {
-	int i;
-	u32 size = le32_to_cpu(*le_size);
-
 	/* Verify that there is room for another country */
-	if (size >= IWL_WTAS_BLACK_LIST_MAX)
+	if (*size >= IWL_WTAS_BLACK_LIST_MAX)
 		return false;
 
-	for (i = 0; i < size; i++) {
-		if (list[i] == cpu_to_le32(mcc))
+	for (u8 i = 0; i < *size; i++) {
+		if (list[i] == mcc)
 			return true;
 	}
 
-	list[size++] = cpu_to_le32(mcc);
-	*le_size = cpu_to_le32(size);
+	list[*size++] = mcc;
 	return true;
 }
 
 static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 {
 	u32 cmd_id = WIDE_ID(REGULATORY_AND_NVM_GROUP, TAS_CONFIG);
-	int ret;
+	int fw_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id,
+					   IWL_FW_CMD_VER_UNKNOWN);
+	struct iwl_tas_selection_data selection_data = {};
+	struct iwl_tas_config_cmd_v2_v4 cmd_v2_v4 = {};
+	struct iwl_tas_config_cmd cmd_v5 = {};
 	struct iwl_tas_data data = {};
-	struct iwl_tas_config_cmd cmd = {};
-	int cmd_size, fw_ver;
+	void *cmd_data = &cmd_v2_v4;
+	int cmd_size;
+	int ret;
 
 	BUILD_BUG_ON(ARRAY_SIZE(data.block_list_array) !=
 		     IWL_WTAS_BLACK_LIST_MAX);
-	BUILD_BUG_ON(ARRAY_SIZE(cmd.common.block_list_array) !=
+	BUILD_BUG_ON(ARRAY_SIZE(cmd_v2_v4.common.block_list_array) !=
+		     IWL_WTAS_BLACK_LIST_MAX);
+	BUILD_BUG_ON(ARRAY_SIZE(cmd_v5.block_list_array) !=
 		     IWL_WTAS_BLACK_LIST_MAX);
 
 	if (!fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_TAS_CFG)) {
@@ -1139,7 +1143,7 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 		return;
 	}
 
-	if (ret == 0)
+	if (ret == 0 && fw_ver < 5)
 		return;
 
 	if (!iwl_is_tas_approved()) {
@@ -1162,31 +1166,49 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 				dmi_get_system_info(DMI_SYS_VENDOR) ?: "<unknown>");
 	}
 
-	fw_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id,
-				       IWL_FW_CMD_VER_UNKNOWN);
-
-	memcpy(&cmd.common, &data, sizeof(struct iwl_tas_config_cmd_common));
-
-	/* Set v3 or v4 specific parts. will be trunctated for fw_ver < 3 */
-	if (fw_ver == 4) {
-		cmd.v4.override_tas_iec = data.override_tas_iec;
-		cmd.v4.enable_tas_iec = data.enable_tas_iec;
-		cmd.v4.usa_tas_uhb_allowed = data.usa_tas_uhb_allowed;
+	if (fw_ver < 5) {
+		selection_data = iwl_parse_tas_selection(data.tas_selection,
+							 data.table_revision);
+		cmd_v2_v4.common.block_list_size =
+			cpu_to_le32(data.block_list_size);
+		for (u8 i = 0; i < data.block_list_size; i++)
+			cmd_v2_v4.common.block_list_array[i] =
+				cpu_to_le32(data.block_list_array[i]);
+	}
+
+	if (fw_ver == 5) {
+		cmd_size = sizeof(cmd_v5);
+		cmd_data = &cmd_v5;
+		cmd_v5.block_list_size = cpu_to_le16(data.block_list_size);
+		for (u16 i = 0; i < data.block_list_size; i++)
+			cmd_v5.block_list_array[i] =
+				cpu_to_le16(data.block_list_array[i]);
+		cmd_v5.tas_config_info.table_source = data.table_source;
+		cmd_v5.tas_config_info.table_revision = data.table_revision;
+		cmd_v5.tas_config_info.value = cpu_to_le32(data.tas_selection);
+	} else if (fw_ver == 4) {
+		cmd_size = sizeof(cmd_v2_v4.common) + sizeof(cmd_v2_v4.v4);
+		cmd_v2_v4.v4.override_tas_iec = selection_data.override_tas_iec;
+		cmd_v2_v4.v4.enable_tas_iec = selection_data.enable_tas_iec;
+		cmd_v2_v4.v4.usa_tas_uhb_allowed =
+			selection_data.usa_tas_uhb_allowed;
 		if (fw_has_capa(&mvm->fw->ucode_capa,
 				IWL_UCODE_TLV_CAPA_UHB_CANADA_TAS_SUPPORT) &&
-		    data.canada_tas_uhb_allowed)
-			cmd.v4.uhb_allowed_flags = TAS_UHB_ALLOWED_CANADA;
+		    selection_data.canada_tas_uhb_allowed)
+			cmd_v2_v4.v4.uhb_allowed_flags = TAS_UHB_ALLOWED_CANADA;
+	} else if (fw_ver == 3) {
+		cmd_size = sizeof(cmd_v2_v4.common) + sizeof(cmd_v2_v4.v3);
+		cmd_v2_v4.v3.override_tas_iec =
+			cpu_to_le16(selection_data.override_tas_iec);
+		cmd_v2_v4.v3.enable_tas_iec =
+			cpu_to_le16(selection_data.enable_tas_iec);
+	} else if (fw_ver == 2) {
+		cmd_size = sizeof(cmd_v2_v4.common);
 	} else {
-		cmd.v3.override_tas_iec = cpu_to_le16(data.override_tas_iec);
-		cmd.v3.enable_tas_iec = cpu_to_le16(data.enable_tas_iec);
+		return;
 	}
 
-	cmd_size = sizeof(struct iwl_tas_config_cmd_common);
-	if (fw_ver >= 3)
-		/* v4 is the same size as v3 */
-		cmd_size += sizeof(struct iwl_tas_config_cmd_v3);
-
-	ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, cmd_size, &cmd);
+	ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, cmd_size, cmd_data);
 	if (ret < 0)
 		IWL_DEBUG_RADIO(mvm, "failed to send TAS_CONFIG (%d)\n", ret);
 }
-- 
2.34.1


