Return-Path: <linux-wireless+bounces-16819-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCA09FCBAD
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 16:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5975B18832B2
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 15:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6F313665A;
	Thu, 26 Dec 2024 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AAtg6CH/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CF5136351
	for <linux-wireless@vger.kernel.org>; Thu, 26 Dec 2024 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735227934; cv=none; b=mxgCBGFZXxpaiJTEbLygd6ioHzTJN5yY0F24qWcGCZKKtqhBklq9dBOhQ9x+b0j57XeV7MMLw82FOXJUZwj/+NSJlO/jYdAOOr005HFJSQAz+cCtb1JPT+jrQ7ZtMcoiTU/BSjXJHrkwpxs7pfSYLje9/PH+h/j9HXP6cY+8INg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735227934; c=relaxed/simple;
	bh=z2rktBpXOHvOR8pbr2KNQckboYnWrf7LPwm1WqvKdB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TIo+esn++yGeyhG3ZNeHrC8MFC3uw7Ahrr+gKbea9hqXWU4gusiILJvrA+3Q+iu0qdSW+7PR1jiABpa4Hm54L3d8rQbyDu0gVG8Iwfj68FL+ogyKARyQrLGVU8HtzrvKhTXX9kI0aGDQCQNZKQfo3hhZTcPJGZOa8IIWWCDXb3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AAtg6CH/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735227933; x=1766763933;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z2rktBpXOHvOR8pbr2KNQckboYnWrf7LPwm1WqvKdB0=;
  b=AAtg6CH/SLCqVETIdgFsG2feRimFF1Gj2Dt1HW2tO7aYpFhyOjExj6OJ
   P9g8T9UNK4Z1zHFWmSQFW6qQ8gmlMRS1Rbu/fc/ULgWZm7FLESDw8MuEL
   6OVy0nGhGM+jNpXH8Hm6y/fIanH0MrmhIOeStsHNRWxNqkwDlLFTB9peA
   sxb4cG/ASJ6IbPp+seEj3oVi/0JE3hGCuHxwOBcTtAytuv50YeTVfBeVu
   GrN9GD86u6mEDapClF0pO1xoYNDeIN6vV8d5d4moV4/yx4/ASV5NGeR3I
   R9ZcPFEfZGpbjMVb5TqqOulPMP7MhEt/8rSGlwg5UiXTP1sF2W9KN8xgr
   Q==;
X-CSE-ConnectionGUID: km/643FjTcSc0NZquanNjA==
X-CSE-MsgGUID: R2acjCeLT86nMegxyzoI1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35878165"
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="35878165"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:32 -0800
X-CSE-ConnectionGUID: Z1cav9VSS+O9VQ5+WRPp8w==
X-CSE-MsgGUID: cdBzjmg+QRKjvEDnNTuiiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="99778014"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:31 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/15] wifi: iwlwifi: mvm: add UHB canada support in TAS_CONFIG cmd
Date: Thu, 26 Dec 2024 17:44:55 +0200
Message-Id: <20241226174257.0b1d92ad59b8.Ib80f8514a64fc2800a2a20131e730c2bd9c4c4af@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
References: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

extend TAS table support to revision 2 for getting UHB canada
enablement from BIOS and send to firmware via TAS_CONFIG cmd
based on firmware capability. While on it fixed kernel-doc for
struct iwl_tas_config_cmd_v4.

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c      |  6 +++---
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h   | 15 ++++++++++++---
 drivers/net/wireless/intel/iwlwifi/fw/file.h      |  2 ++
 .../net/wireless/intel/iwlwifi/fw/regulatory.c    |  7 ++++++-
 .../net/wireless/intel/iwlwifi/fw/regulatory.h    | 10 ++++++----
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c      |  7 +++++--
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h      |  3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c       |  4 ++++
 8 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 0bc32291815e..7d6e6c80b892 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -274,13 +274,13 @@ int iwl_acpi_get_tas_table(struct iwl_fw_runtime *fwrt,
 		goto out_free;
 	}
 
-	if (tbl_rev == 1 && wifi_pkg->package.elements[1].type ==
-		ACPI_TYPE_INTEGER) {
+	if ((tbl_rev == 2 || tbl_rev == 1) &&
+	    wifi_pkg->package.elements[1].type == ACPI_TYPE_INTEGER) {
 		u32 tas_selection =
 			(u32)wifi_pkg->package.elements[1].integer.value;
 
 		enabled = iwl_parse_tas_selection(fwrt, tas_data,
-						  tas_selection);
+						  tas_selection, tbl_rev);
 
 	} else if (tbl_rev == 0 &&
 		wifi_pkg->package.elements[1].type == ACPI_TYPE_INTEGER) {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index d424d0126367..1bf549775c7c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -463,19 +463,28 @@ struct iwl_tas_config_cmd_v3 {
 	__le16 enable_tas_iec;
 } __packed; /* TAS_CONFIG_CMD_API_S_VER_3 */
 
+/**
+ * enum iwl_tas_uhb_allowed_flags - per country TAS UHB allowed flags.
+ * @TAS_UHB_ALLOWED_CANADA: TAS UHB is allowed in Canada. This flag is valid
+ *	only when fw has %IWL_UCODE_TLV_CAPA_UHB_CANADA_TAS_SUPPORT capability.
+ */
+enum iwl_tas_uhb_allowed_flags {
+	TAS_UHB_ALLOWED_CANADA	= BIT(0),
+};
+
 /**
  * struct iwl_tas_config_cmd_v4 - configures the TAS
  * @override_tas_iec: indicates whether to override default value of IEC regulatory
  * @enable_tas_iec: in case override_tas_iec is set -
  *	indicates whether IEC regulatory is enabled or disabled
  * @usa_tas_uhb_allowed: if set, allow TAS UHB in the USA
- * @reserved: reserved
-*/
+ * @uhb_allowed_flags: see &enum iwl_tas_uhb_allowed_flags.
+ */
 struct iwl_tas_config_cmd_v4 {
 	u8 override_tas_iec;
 	u8 enable_tas_iec;
 	u8 usa_tas_uhb_allowed;
-	u8 reserved;
+	u8 uhb_allowed_flags;
 } __packed; /* TAS_CONFIG_CMD_API_S_VER_4 */
 
 struct iwl_tas_config_cmd {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index f5fbe7692f6c..dce61869a7e3 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -400,6 +400,7 @@ typedef unsigned int __bitwise iwl_ucode_tlv_capa_t;
  *	passive channels
  * @IWL_UCODE_TLV_CAPA_BIOS_OVERRIDE_5G9_FOR_CA: supports (de)activating 5G9
  *	for CA from BIOS.
+ * @IWL_UCODE_TLV_CAPA_UHB_CANADA_TAS_SUPPORT: supports %TAS_UHB_ALLOWED_CANADA
  *
  * @NUM_IWL_UCODE_TLV_CAPA: number of bits used
  */
@@ -501,6 +502,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_SECURE_LTF_SUPPORT		= (__force iwl_ucode_tlv_capa_t)121,
 	IWL_UCODE_TLV_CAPA_MONITOR_PASSIVE_CHANS	= (__force iwl_ucode_tlv_capa_t)122,
 	IWL_UCODE_TLV_CAPA_BIOS_OVERRIDE_5G9_FOR_CA	= (__force iwl_ucode_tlv_capa_t)123,
+	IWL_UCODE_TLV_CAPA_UHB_CANADA_TAS_SUPPORT	= (__force iwl_ucode_tlv_capa_t)124,
 	NUM_IWL_UCODE_TLV_CAPA
 /*
  * This construction make both sparse (which cannot increment the previous
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 4b5eeff4a140..c89ff380b86d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -426,10 +426,12 @@ IWL_EXPORT_SYMBOL(iwl_is_tas_approved);
 
 int iwl_parse_tas_selection(struct iwl_fw_runtime *fwrt,
 			    struct iwl_tas_data *tas_data,
-			    const u32 tas_selection)
+			    const u32 tas_selection, u8 tbl_rev)
 {
 	u8 override_iec = u32_get_bits(tas_selection,
 				       IWL_WTAS_OVERRIDE_IEC_MSK);
+	u8 canada_tas_uhb = u32_get_bits(tas_selection,
+					 IWL_WTAS_CANADA_UHB_MSK);
 	u8 enabled_iec = u32_get_bits(tas_selection, IWL_WTAS_ENABLE_IEC_MSK);
 	u8 usa_tas_uhb = u32_get_bits(tas_selection, IWL_WTAS_USA_UHB_MSK);
 	int enabled = tas_selection & IWL_WTAS_ENABLED_MSK;
@@ -441,6 +443,9 @@ int iwl_parse_tas_selection(struct iwl_fw_runtime *fwrt,
 	tas_data->override_tas_iec = override_iec;
 	tas_data->enable_tas_iec = enabled_iec;
 
+	if (tbl_rev > 1)
+		tas_data->canada_tas_uhb_allowed = canada_tas_uhb;
+
 	return enabled;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index 4ced1711d913..f247d31ebdd6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -43,6 +43,7 @@
 #define IWL_WTAS_ENABLED_MSK		0x1
 #define IWL_WTAS_OVERRIDE_IEC_MSK	0x2
 #define IWL_WTAS_ENABLE_IEC_MSK	0x4
+#define IWL_WTAS_CANADA_UHB_MSK		BIT(15)
 #define IWL_WTAS_USA_UHB_MSK		BIT(16)
 
 #define BIOS_MCC_CHINA 0x434e
@@ -99,9 +100,10 @@ struct iwl_ppag_chain {
 struct iwl_tas_data {
 	__le32 block_list_size;
 	__le32 block_list_array[IWL_WTAS_BLACK_LIST_MAX];
-	u8 override_tas_iec;
-	u8 enable_tas_iec;
-	u8 usa_tas_uhb_allowed;
+	u8 override_tas_iec:1,
+	   enable_tas_iec:1,
+	   usa_tas_uhb_allowed:1,
+	   canada_tas_uhb_allowed:1;
 };
 
 /* For DSM revision 0 and 4 */
@@ -185,7 +187,7 @@ bool iwl_is_tas_approved(void);
 
 int iwl_parse_tas_selection(struct iwl_fw_runtime *fwrt,
 			    struct iwl_tas_data *tas_data,
-			    const u32 tas_selection);
+			    const u32 tas_selection, u8 tbl_rev);
 
 int iwl_bios_get_wrds_table(struct iwl_fw_runtime *fwrt);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 091fb6fd7c78..dcbb3c387c10 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -561,7 +561,8 @@ int iwl_uefi_get_tas_table(struct iwl_fw_runtime *fwrt,
 	if (IS_ERR(uefi_tas))
 		return -EINVAL;
 
-	if (uefi_tas->revision != IWL_UEFI_WTAS_REVISION) {
+	if (uefi_tas->revision < IWL_UEFI_MIN_WTAS_REVISION ||
+	    uefi_tas->revision > IWL_UEFI_MAX_WTAS_REVISION) {
 		ret = -EINVAL;
 		IWL_DEBUG_RADIO(fwrt, "Unsupported UEFI WTAS revision:%d\n",
 				uefi_tas->revision);
@@ -569,7 +570,9 @@ int iwl_uefi_get_tas_table(struct iwl_fw_runtime *fwrt,
 	}
 
 	enabled = iwl_parse_tas_selection(fwrt, tas_data,
-					  uefi_tas->tas_selection);
+					  uefi_tas->tas_selection,
+					  uefi_tas->revision);
+
 	if (!enabled) {
 		IWL_DEBUG_RADIO(fwrt, "TAS not enabled\n");
 		ret = 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index e525d449e656..4e98f752b3d2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -33,7 +33,8 @@
 #define IWL_UEFI_WGDS_REVISION		3
 #define IWL_UEFI_MIN_PPAG_REV		1
 #define IWL_UEFI_MAX_PPAG_REV		3
-#define IWL_UEFI_WTAS_REVISION		1
+#define IWL_UEFI_MIN_WTAS_REVISION	1
+#define IWL_UEFI_MAX_WTAS_REVISION	2
 #define IWL_UEFI_SPLC_REVISION		0
 #define IWL_UEFI_WRDD_REVISION		0
 #define IWL_UEFI_ECKV_REVISION		0
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 5ea684802ad1..029347b79655 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1171,6 +1171,10 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 		cmd.v4.override_tas_iec = data.override_tas_iec;
 		cmd.v4.enable_tas_iec = data.enable_tas_iec;
 		cmd.v4.usa_tas_uhb_allowed = data.usa_tas_uhb_allowed;
+		if (fw_has_capa(&mvm->fw->ucode_capa,
+				IWL_UCODE_TLV_CAPA_UHB_CANADA_TAS_SUPPORT) &&
+		    data.canada_tas_uhb_allowed)
+			cmd.v4.uhb_allowed_flags = TAS_UHB_ALLOWED_CANADA;
 	} else {
 		cmd.v3.override_tas_iec = cpu_to_le16(data.override_tas_iec);
 		cmd.v3.enable_tas_iec = cpu_to_le16(data.enable_tas_iec);
-- 
2.34.1


