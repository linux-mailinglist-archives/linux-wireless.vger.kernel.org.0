Return-Path: <linux-wireless+bounces-2878-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A91948438F1
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 09:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F19728BE16
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 08:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2F35813B;
	Wed, 31 Jan 2024 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q0//Z4b4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589C65FB90
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 08:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689538; cv=none; b=oGoEBRR/U6t1ZkiRFAnZdBPBhncorIdCcMr3w9OPw4EOgEQH+bu3+oR84MPsbGglACMJYxp58yV7eCB50zkrO0+1CXHbDER+b50S5hV/VPiPoG3LOTDoUAnRCmSZc7hvO916oKxEyINrVlDDlQUIxqLv+pSu2d70ScA7kDaU//M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689538; c=relaxed/simple;
	bh=lD0C2khT7kJWUSVm+6nKwvkQpN6OTAKsZENhCA5xinA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M9bJp2LAMwGISC3KSmHyTiyR0oc55sOAWejZIWIZLNIX6EzxRGd5B7rJRf/ubznrETMOy15yCZMvIqzHq5QM2pV5clXDxSfVJu/oWUu/Nv7DQfLtz2jUBQwbkuKF5t3zSpxjR1Vu4Zd+q2+7DBpNbyaTyHBW7rBFi0zYEML6yBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q0//Z4b4; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706689529; x=1738225529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lD0C2khT7kJWUSVm+6nKwvkQpN6OTAKsZENhCA5xinA=;
  b=Q0//Z4b4gA/y17pDIESmPOAkdYKRAaW5AtBdHLLKHOHmriiyjLWygY0f
   WNZzMnk9n8viWH5YuHWMCfImAQp3UGUC47P1DP43HNh5Aza+UbVWB+72B
   2CvKOaYK0guAJ2pawlcrAWPC1nO0jh0wguF7JWVbKeci6h3sRmSIt6WGA
   f+vte0wbsjPlLSSIM6yR28xS59oOjFX0i+640suIGwksPqY2xl3Zngaem
   pegJDeS5/QfooMTVgTE/SdD7WMni66mNYDXgV029I0H6CADd8v8lo8t9b
   0afbbhtZT+eU6I9H1T9j34PaAysnA8827NbKjNmSfv+xODRkPr6gaIgSJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="407249966"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="407249966"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:25:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3968963"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:25:26 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/14] wifi: iwlwifi: prepare for reading TAS table from UEFI
Date: Wed, 31 Jan 2024 10:24:45 +0200
Message-Id: <20240131091413.0c2197cf1feb.Ib0e83d5bd3f4d5cfa9c3d2925317ba49377d257f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131082447.1372353-1-miriam.rachel.korenblit@intel.com>
References: <20240131082447.1372353-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

We are going to support reading BIOS tables from UEFI
too, Refactor the TAS table flow:

1. Rename and move the common code to the regulatory.h/c files.
2. Remove the IWL_TAS_BLOCK_LIST_MAX, as we can use IWL_WTAS_BLACK_LIST_MAX
   instead.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 19 +---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  | 11 +--
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  8 +-
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 91 +++++++++++++++++++
 .../wireless/intel/iwlwifi/fw/regulatory.h    | 15 ++-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 70 +-------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  1 -
 8 files changed, 118 insertions(+), 101 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index d88a9df20abe..4fd9c6f768e6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -273,22 +273,9 @@ int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
 		ACPI_TYPE_INTEGER) {
 		u32 tas_selection =
 			(u32)wifi_pkg->package.elements[1].integer.value;
-		u16 override_iec =
-			(tas_selection & ACPI_WTAS_OVERRIDE_IEC_MSK) >> ACPI_WTAS_OVERRIDE_IEC_POS;
-		u16 enabled_iec = (tas_selection & ACPI_WTAS_ENABLE_IEC_MSK) >>
-			ACPI_WTAS_ENABLE_IEC_POS;
-		u8 usa_tas_uhb = (tas_selection & ACPI_WTAS_USA_UHB_MSK) >> ACPI_WTAS_USA_UHB_POS;
 
-
-		enabled = tas_selection & ACPI_WTAS_ENABLED_MSK;
-		if (fw_ver <= 3) {
-			cmd->v3.override_tas_iec = cpu_to_le16(override_iec);
-			cmd->v3.enable_tas_iec = cpu_to_le16(enabled_iec);
-		} else {
-			cmd->v4.usa_tas_uhb_allowed = usa_tas_uhb;
-			cmd->v4.override_tas_iec = (u8)override_iec;
-			cmd->v4.enable_tas_iec = (u8)enabled_iec;
-		}
+		enabled = iwl_parse_tas_selection(fwrt, cmd, fw_ver,
+						  tas_selection);
 
 	} else if (tbl_rev == 0 &&
 		wifi_pkg->package.elements[1].type == ACPI_TYPE_INTEGER) {
@@ -307,7 +294,7 @@ int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
 	IWL_DEBUG_RADIO(fwrt, "Reading TAS table revision %d\n", tbl_rev);
 	if (wifi_pkg->package.elements[2].type != ACPI_TYPE_INTEGER ||
 	    wifi_pkg->package.elements[2].integer.value >
-	    APCI_WTAS_BLACK_LIST_MAX) {
+	    IWL_WTAS_BLACK_LIST_MAX) {
 		IWL_DEBUG_RADIO(fwrt, "TAS invalid array size %llu\n",
 				wifi_pkg->package.elements[2].integer.value);
 		ret = -EINVAL;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index ca3587e9f856..319158ab36c4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -78,16 +78,7 @@
  *	     1 element for block list size,
  *	     16 elements for block list array
  */
-#define APCI_WTAS_BLACK_LIST_MAX	16
-#define ACPI_WTAS_WIFI_DATA_SIZE	(3 + APCI_WTAS_BLACK_LIST_MAX)
-#define ACPI_WTAS_ENABLED_MSK		0x1
-#define ACPI_WTAS_OVERRIDE_IEC_MSK	0x2
-#define ACPI_WTAS_ENABLE_IEC_MSK	0x4
-#define ACPI_WTAS_OVERRIDE_IEC_POS	0x1
-#define ACPI_WTAS_ENABLE_IEC_POS	0x2
-#define ACPI_WTAS_USA_UHB_MSK		BIT(16)
-#define ACPI_WTAS_USA_UHB_POS		16
-
+#define ACPI_WTAS_WIFI_DATA_SIZE	(3 + IWL_WTAS_BLACK_LIST_MAX)
 
 #define ACPI_PPAG_WIFI_DATA_SIZE_V1	((IWL_NUM_CHAIN_LIMITS * \
 					  IWL_NUM_SUB_BANDS_V1) + 2)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index 7ec959244ffc..c93a0665b040 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -7,6 +7,7 @@
 #ifndef __iwl_fw_api_nvm_reg_h__
 #define __iwl_fw_api_nvm_reg_h__
 
+#include "fw/regulatory.h"
 /**
  * enum iwl_regulatory_and_nvm_subcmd_ids - regulatory/NVM commands
  */
@@ -438,7 +439,6 @@ enum iwl_mcc_source {
 	MCC_SOURCE_GETTING_MCC_TEST_MODE = 0x11,
 };
 
-#define IWL_TAS_BLOCK_LIST_MAX 16
 /**
  * struct iwl_tas_config_cmd_v2 - configures the TAS
  * @block_list_size: size of relevant field in block_list_array
@@ -446,7 +446,7 @@ enum iwl_mcc_source {
  */
 struct iwl_tas_config_cmd_v2 {
 	__le32 block_list_size;
-	__le32 block_list_array[IWL_TAS_BLOCK_LIST_MAX];
+	__le32 block_list_array[IWL_WTAS_BLACK_LIST_MAX];
 } __packed; /* TAS_CONFIG_CMD_API_S_VER_2 */
 
 /**
@@ -459,7 +459,7 @@ struct iwl_tas_config_cmd_v2 {
  */
 struct iwl_tas_config_cmd_v3 {
 	__le32 block_list_size;
-	__le32 block_list_array[IWL_TAS_BLOCK_LIST_MAX];
+	__le32 block_list_array[IWL_WTAS_BLACK_LIST_MAX];
 	__le16 override_tas_iec;
 	__le16 enable_tas_iec;
 } __packed; /* TAS_CONFIG_CMD_API_S_VER_3 */
@@ -476,7 +476,7 @@ struct iwl_tas_config_cmd_v3 {
 */
 struct iwl_tas_config_cmd_v4 {
 	__le32 block_list_size;
-	__le32 block_list_array[IWL_TAS_BLOCK_LIST_MAX];
+	__le32 block_list_array[IWL_WTAS_BLACK_LIST_MAX];
 	u8 override_tas_iec;
 	u8 enable_tas_iec;
 	u8 usa_tas_uhb_allowed;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index fb4df1ff061d..570d8e74f839 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2023 Intel Corporation
  */
 #include <linux/dmi.h>
+#include "fw/api/nvm-reg.h"
 #include "iwl-drv.h"
 #include "iwl-debug.h"
 #include "regulatory.h"
@@ -83,6 +84,62 @@ static const struct dmi_system_id dmi_ppag_approved_list[] = {
 	{}
 };
 
+static const struct dmi_system_id dmi_tas_approved_list[] = {
+	{ .ident = "HP",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+		},
+	},
+	{ .ident = "SAMSUNG",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD"),
+		},
+	},
+		{ .ident = "LENOVO",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		},
+	},
+	{ .ident = "DELL",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		},
+	},
+	{ .ident = "MSFT",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+		},
+	},
+	{ .ident = "Acer",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+		},
+	},
+	{ .ident = "ASUS",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+		},
+	},
+	{ .ident = "GOOGLE-HP",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+		},
+	},
+	{ .ident = "MSI",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star International Co., Ltd."),
+		},
+	},
+	{ .ident = "Honor",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
+		},
+	},
+	/* keep last */
+	{}
+};
+
 bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt)
 {
 	/*
@@ -335,3 +392,37 @@ bool iwl_is_ppag_approved(struct iwl_fw_runtime *fwrt)
 	return true;
 }
 IWL_EXPORT_SYMBOL(iwl_is_ppag_approved);
+
+bool iwl_is_tas_approved(void)
+{
+	return dmi_check_system(dmi_tas_approved_list);
+}
+IWL_EXPORT_SYMBOL(iwl_is_tas_approved);
+
+int iwl_parse_tas_selection(struct iwl_fw_runtime *fwrt,
+			    union iwl_tas_config_cmd *cmd, int fw_ver,
+			    const u32 tas_selection)
+{
+	u8 override_iec = u32_get_bits(tas_selection,
+					IWL_WTAS_OVERRIDE_IEC_MSK);
+	u8 enabled_iec = u32_get_bits(tas_selection, IWL_WTAS_ENABLE_IEC_MSK);
+	u8 usa_tas_uhb = u32_get_bits(tas_selection, IWL_WTAS_USA_UHB_MSK);
+	int enabled = tas_selection & IWL_WTAS_ENABLED_MSK;
+
+	IWL_DEBUG_RADIO(fwrt, "TAS selection as read from BIOS: 0x%x\n",
+			tas_selection);
+
+	if (fw_ver < 3)
+		return enabled;
+
+	if (fw_ver == 3) {
+		cmd->v3.override_tas_iec = cpu_to_le16(override_iec);
+		cmd->v3.enable_tas_iec = cpu_to_le16(enabled_iec);
+	} else {
+		cmd->v4.usa_tas_uhb_allowed = usa_tas_uhb;
+		cmd->v4.override_tas_iec = override_iec;
+		cmd->v4.enable_tas_iec = enabled_iec;
+	}
+
+	return enabled;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index 954ba83d0277..a2d9d7807833 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -10,7 +10,6 @@
 #include "fw/api/commands.h"
 #include "fw/api/power.h"
 #include "fw/api/phy.h"
-#include "fw/api/nvm-reg.h"
 #include "fw/api/config.h"
 #include "fw/img.h"
 #include "iwl-trans.h"
@@ -40,6 +39,12 @@
 #define IWL_PPAG_ETSI_CHINA_MASK	3
 #define IWL_PPAG_ETSI_MASK		BIT(0)
 
+#define IWL_WTAS_BLACK_LIST_MAX	16
+#define IWL_WTAS_ENABLED_MSK		0x1
+#define IWL_WTAS_OVERRIDE_IEC_MSK	0x2
+#define IWL_WTAS_ENABLE_IEC_MSK	0x4
+#define IWL_WTAS_USA_UHB_MSK		BIT(16)
+
 /*
  * The profile for revision 2 is a superset of revision 1, which is in
  * turn a superset of revision 0.  So we can store all revisions
@@ -91,6 +96,8 @@ struct iwl_ppag_chain {
 
 struct iwl_fw_runtime;
 
+union iwl_tas_config_cmd;
+
 bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt);
 
 int iwl_sar_geo_fill_table(struct iwl_fw_runtime *fwrt,
@@ -107,6 +114,12 @@ int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
 
 bool iwl_is_ppag_approved(struct iwl_fw_runtime *fwrt);
 
+bool iwl_is_tas_approved(void);
+
+int iwl_parse_tas_selection(struct iwl_fw_runtime *fwrt,
+			    union iwl_tas_config_cmd *cmd, int fw_ver,
+			    const u32 tas_selection);
+
 int iwl_bios_get_wrds_table(struct iwl_fw_runtime *fwrt);
 
 int iwl_bios_get_ewrd_table(struct iwl_fw_runtime *fwrt);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index edc8204f7c0e..d67986e157a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -877,14 +877,14 @@ static ssize_t iwl_dbgfs_tas_get_status_read(struct file *file,
 			 le16_to_cpu(rsp->curr_mcc));
 
 	pos += scnprintf(pos, endpos - pos, "Block list entries:");
-	for (i = 0; i < APCI_WTAS_BLACK_LIST_MAX; i++)
+	for (i = 0; i < IWL_WTAS_BLACK_LIST_MAX; i++)
 		pos += scnprintf(pos, endpos - pos, " 0x%x",
 				 le16_to_cpu(rsp->block_list[i]));
 
 	pos += scnprintf(pos, endpos - pos, "\nOEM name: %s\n",
 			 dmi_get_system_info(DMI_SYS_VENDOR));
 	pos += scnprintf(pos, endpos - pos, "\tVendor In Approved List: %s\n",
-			 iwl_mvm_is_vendor_in_approved_list() ? "YES" : "NO");
+			 iwl_is_tas_approved() ? "YES" : "NO");
 	pos += scnprintf(pos, endpos - pos,
 			 "\tDo TAS Support Dual Radio?: %s\n",
 			 rsp->in_dual_radio ? "TRUE" : "FALSE");
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 0a820dbeef23..e848b041e995 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1110,66 +1110,7 @@ static int iwl_mvm_ppag_init(struct iwl_mvm *mvm)
 
 #ifdef CONFIG_ACPI
 
-static const struct dmi_system_id dmi_tas_approved_list[] = {
-	{ .ident = "HP",
-	  .matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
-		},
-	},
-	{ .ident = "SAMSUNG",
-	  .matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD"),
-		},
-	},
-		{ .ident = "LENOVO",
-	  .matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		},
-	},
-	{ .ident = "DELL",
-	  .matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		},
-	},
-	{ .ident = "MSFT",
-	  .matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
-		},
-	},
-	{ .ident = "Acer",
-	  .matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-		},
-	},
-	{ .ident = "ASUS",
-	  .matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-		},
-	},
-	{ .ident = "GOOGLE-HP",
-	  .matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
-			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
-		},
-	},
-	{ .ident = "MSI",
-	  .matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star International Co., Ltd."),
-		},
-	},
-	{ .ident = "Honor",
-	  .matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
-		},
-	},
-	/* keep last */
-	{}
-};
 
-bool iwl_mvm_is_vendor_in_approved_list(void)
-{
-	return dmi_check_system(dmi_tas_approved_list);
-}
 
 static bool iwl_mvm_add_to_tas_block_list(__le32 *list, __le32 *le_size, unsigned int mcc)
 {
@@ -1177,7 +1118,7 @@ static bool iwl_mvm_add_to_tas_block_list(__le32 *list, __le32 *le_size, unsigne
 	u32 size = le32_to_cpu(*le_size);
 
 	/* Verify that there is room for another country */
-	if (size >= IWL_TAS_BLOCK_LIST_MAX)
+	if (size >= IWL_WTAS_BLACK_LIST_MAX)
 		return false;
 
 	for (i = 0; i < size; i++) {
@@ -1198,7 +1139,7 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 	int cmd_size, fw_ver;
 
 	BUILD_BUG_ON(ARRAY_SIZE(cmd.v3.block_list_array) <
-		     APCI_WTAS_BLACK_LIST_MAX);
+		     IWL_WTAS_BLACK_LIST_MAX);
 
 	if (!fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_TAS_CFG)) {
 		IWL_DEBUG_RADIO(mvm, "TAS not enabled in FW\n");
@@ -1219,7 +1160,7 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 	if (ret == 0)
 		return;
 
-	if (!iwl_mvm_is_vendor_in_approved_list()) {
+	if (!iwl_is_tas_approved()) {
 		IWL_DEBUG_RADIO(mvm,
 				"System vendor '%s' is not in the approved list, disabling TAS in US and Canada.\n",
 				dmi_get_system_info(DMI_SYS_VENDOR));
@@ -1397,11 +1338,6 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 {
 }
 
-bool iwl_mvm_is_vendor_in_approved_list(void)
-{
-	return false;
-}
-
 static u8 iwl_mvm_eval_dsm_rfi(struct iwl_mvm *mvm)
 {
 	return DSM_VALUE_RFI_DISABLE;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 14f4cf8a67c7..c76ce6b1fa72 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2620,7 +2620,6 @@ static inline bool iwl_mvm_mei_filter_scan(struct iwl_mvm *mvm,
 void iwl_mvm_send_roaming_forbidden_event(struct iwl_mvm *mvm,
 					  struct ieee80211_vif *vif,
 					  bool forbidden);
-bool iwl_mvm_is_vendor_in_approved_list(void);
 
 /* Callbacks for ieee80211_ops */
 void iwl_mvm_mac_tx(struct ieee80211_hw *hw,
-- 
2.34.1


