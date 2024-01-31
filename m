Return-Path: <linux-wireless+bounces-2879-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F29A18438F2
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 09:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A7F1F215CE
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 08:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D845B1E4;
	Wed, 31 Jan 2024 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dose/FkU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F72659149
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 08:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689538; cv=none; b=HgJJxmQ9weBhRLfxMGqzpv6DYhVXiUco8DLeLVJjrGdcOi80AQ0J16+jdJumMZcKdh749YjcVsR8wSXe8p8onB7LlCYFqSjhGZFSSdnOKyqXmYlnr6i+YOMBLfCwHlhIexDObau6BxEDiE30AtNMRfQDMdVzHwBKKXPaiLMh9fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689538; c=relaxed/simple;
	bh=UDNJOi5Bcpcx+LKicPnvwcMpz+JZDycY53DcWU0OCxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BRe+Gh0oblz7gN5E+rTJZlroJHV+wXmxNjACof1I2Kd822MX6lB5QwA/UEMOk+EmaAVCS57mxtSbRkiQhULEOgFQ1SYWHpHPeyQW8+D4KjrJIHCs2GEE6VRLOvCqMOGNuS+WG4xzx8doJrUYGzAccPeE7rhYIREswNnc8Yso4os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dose/FkU; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706689531; x=1738225531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UDNJOi5Bcpcx+LKicPnvwcMpz+JZDycY53DcWU0OCxo=;
  b=Dose/FkUph/haMmPUkTIwO7cLgKx4vCDl2BugjKCgcLjr0FFcWi3HAV7
   JV5PEgouuVqP3+UNFftpt9sa5YqTpzWGeJfNd+XwUaI5HTKIkGdU9Vf1J
   iEgOKdeUJ84JuyR2JWzcowyhpstqbHTxIn3peWQ95xOJzAgsh6aCi1WF+
   38Wy3iOpTZ1sDFg1NHaEt8SWNT0H1IuZxoHJykV3yhbkPH5juSfdGs8Nc
   9ZH8iDBPI2cR+Eo59LkWhx88xJKNfcdU2nbFtBER73UqOt3E8/ZryiGJf
   /wfQj+Aj5raKCINXiCbbqV/d4/dnhweSgvSc6bbsWGw6Jf+vLSJUHek+M
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="407249970"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="407249970"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:25:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3968971"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:25:28 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/14] wifi: iwlwifi: separate TAS 'read-from-BIOS' and 'send-to-FW' flows
Date: Wed, 31 Jan 2024 10:24:46 +0200
Message-Id: <20240131091413.24df27772a71.I57b702af4feb3f38dc21d52593c25de4b1999e4b@changeid>
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

Currently the TAS 'read-from-BIOS' flow receives the command struct
and the version of it as read from FW TLVs, and fills the command
accordingly.
This seems wrong, we should have the 'read-from-BIOS' flow
(iwl_acpi_get_tas in iwlwifi) reading/parsing/validating the table from
BIOS, and the 'send-to-FW' flow (iwl_mvm_tas_init) doing
all the FW versioning checks and cmd filling.
Move the cmd filling to the 'send-to-fw' flow. 

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  8 ++--
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  5 +-
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   | 24 ++++------
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 19 ++------
 .../wireless/intel/iwlwifi/fw/regulatory.h    | 12 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 47 ++++++++++++-------
 6 files changed, 62 insertions(+), 53 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 4fd9c6f768e6..0abb954f3056 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -251,7 +251,7 @@ iwl_acpi_get_wifi_pkg(struct device *dev,
 
 
 int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
-		     union iwl_tas_config_cmd *cmd, int fw_ver)
+		     struct iwl_tas_data *tas_data)
 {
 	union acpi_object *wifi_pkg, *data;
 	int ret, tbl_rev, i, block_list_size, enabled;
@@ -274,7 +274,7 @@ int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
 		u32 tas_selection =
 			(u32)wifi_pkg->package.elements[1].integer.value;
 
-		enabled = iwl_parse_tas_selection(fwrt, cmd, fw_ver,
+		enabled = iwl_parse_tas_selection(fwrt, tas_data,
 						  tas_selection);
 
 	} else if (tbl_rev == 0 &&
@@ -301,7 +301,7 @@ int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
 		goto out_free;
 	}
 	block_list_size = wifi_pkg->package.elements[2].integer.value;
-	cmd->v4.block_list_size = cpu_to_le32(block_list_size);
+	tas_data->block_list_size = cpu_to_le32(block_list_size);
 
 	IWL_DEBUG_RADIO(fwrt, "TAS array size %u\n", block_list_size);
 
@@ -317,7 +317,7 @@ int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
 		}
 
 		country = wifi_pkg->package.elements[3 + i].integer.value;
-		cmd->v4.block_list_array[i] = cpu_to_le32(country);
+		tas_data->block_list_array[i] = cpu_to_le32(country);
 		IWL_DEBUG_RADIO(fwrt, "TAS block list country %d\n", country);
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 319158ab36c4..0ce9a33bbb77 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -7,6 +7,7 @@
 #define __iwl_fw_acpi__
 
 #include <linux/acpi.h>
+#include "fw/regulatory.h"
 #include "fw/api/commands.h"
 #include "fw/api/power.h"
 #include "fw/api/phy.h"
@@ -175,7 +176,7 @@ int iwl_acpi_get_ewrd_table(struct iwl_fw_runtime *fwrt);
 int iwl_acpi_get_wgds_table(struct iwl_fw_runtime *fwrt);
 
 int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
-		     union iwl_tas_config_cmd *cmd, int fw_ver);
+		     struct iwl_tas_data *data);
 
 __le32 iwl_acpi_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt);
 
@@ -237,7 +238,7 @@ static inline int iwl_acpi_get_wgds_table(struct iwl_fw_runtime *fwrt)
 }
 
 static inline int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
-				   union iwl_tas_config_cmd *cmd, int fw_ver)
+				   struct iwl_tas_data *data)
 {
 	return -ENOENT;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index c93a0665b040..8c886569f01e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -440,34 +440,29 @@ enum iwl_mcc_source {
 };
 
 /**
- * struct iwl_tas_config_cmd_v2 - configures the TAS
+ * struct iwl_tas_config_cmd_common - configures the TAS.
+ * This is also the v2 structure.
  * @block_list_size: size of relevant field in block_list_array
  * @block_list_array: list of countries where TAS must be disabled
  */
-struct iwl_tas_config_cmd_v2 {
+struct iwl_tas_config_cmd_common {
 	__le32 block_list_size;
 	__le32 block_list_array[IWL_WTAS_BLACK_LIST_MAX];
 } __packed; /* TAS_CONFIG_CMD_API_S_VER_2 */
 
 /**
  * struct iwl_tas_config_cmd_v3 - configures the TAS
- * @block_list_size: size of relevant field in block_list_array
- * @block_list_array: list of countries where TAS must be disabled
  * @override_tas_iec: indicates whether to override default value of IEC regulatory
  * @enable_tas_iec: in case override_tas_iec is set -
  *	indicates whether IEC regulatory is enabled or disabled
  */
 struct iwl_tas_config_cmd_v3 {
-	__le32 block_list_size;
-	__le32 block_list_array[IWL_WTAS_BLACK_LIST_MAX];
 	__le16 override_tas_iec;
 	__le16 enable_tas_iec;
 } __packed; /* TAS_CONFIG_CMD_API_S_VER_3 */
 
 /**
  * struct iwl_tas_config_cmd_v3 - configures the TAS
- * @block_list_size: size of relevant field in block_list_array
- * @block_list_array: list of countries where TAS must be disabled
  * @override_tas_iec: indicates whether to override default value of IEC regulatory
  * @enable_tas_iec: in case override_tas_iec is set -
  *	indicates whether IEC regulatory is enabled or disabled
@@ -475,19 +470,20 @@ struct iwl_tas_config_cmd_v3 {
  * @reserved: reserved
 */
 struct iwl_tas_config_cmd_v4 {
-	__le32 block_list_size;
-	__le32 block_list_array[IWL_WTAS_BLACK_LIST_MAX];
 	u8 override_tas_iec;
 	u8 enable_tas_iec;
 	u8 usa_tas_uhb_allowed;
 	u8 reserved;
 } __packed; /* TAS_CONFIG_CMD_API_S_VER_4 */
 
-union iwl_tas_config_cmd {
-	struct iwl_tas_config_cmd_v2 v2;
-	struct iwl_tas_config_cmd_v3 v3;
-	struct iwl_tas_config_cmd_v4 v4;
+struct iwl_tas_config_cmd {
+	struct iwl_tas_config_cmd_common common;
+	union {
+		struct iwl_tas_config_cmd_v3 v3;
+		struct iwl_tas_config_cmd_v4 v4;
+	};
 };
+
 /**
  * enum iwl_lari_config_masks - bit masks for the various LARI config operations
  * @LARI_CONFIG_DISABLE_11AC_UKRAINE_MSK: disable 11ac in ukraine
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 570d8e74f839..20154b0fb7e6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2023 Intel Corporation
  */
 #include <linux/dmi.h>
-#include "fw/api/nvm-reg.h"
 #include "iwl-drv.h"
 #include "iwl-debug.h"
 #include "regulatory.h"
@@ -400,11 +399,11 @@ bool iwl_is_tas_approved(void)
 IWL_EXPORT_SYMBOL(iwl_is_tas_approved);
 
 int iwl_parse_tas_selection(struct iwl_fw_runtime *fwrt,
-			    union iwl_tas_config_cmd *cmd, int fw_ver,
+			    struct iwl_tas_data *tas_data,
 			    const u32 tas_selection)
 {
 	u8 override_iec = u32_get_bits(tas_selection,
-					IWL_WTAS_OVERRIDE_IEC_MSK);
+				       IWL_WTAS_OVERRIDE_IEC_MSK);
 	u8 enabled_iec = u32_get_bits(tas_selection, IWL_WTAS_ENABLE_IEC_MSK);
 	u8 usa_tas_uhb = u32_get_bits(tas_selection, IWL_WTAS_USA_UHB_MSK);
 	int enabled = tas_selection & IWL_WTAS_ENABLED_MSK;
@@ -412,17 +411,9 @@ int iwl_parse_tas_selection(struct iwl_fw_runtime *fwrt,
 	IWL_DEBUG_RADIO(fwrt, "TAS selection as read from BIOS: 0x%x\n",
 			tas_selection);
 
-	if (fw_ver < 3)
-		return enabled;
-
-	if (fw_ver == 3) {
-		cmd->v3.override_tas_iec = cpu_to_le16(override_iec);
-		cmd->v3.enable_tas_iec = cpu_to_le16(enabled_iec);
-	} else {
-		cmd->v4.usa_tas_uhb_allowed = usa_tas_uhb;
-		cmd->v4.override_tas_iec = override_iec;
-		cmd->v4.enable_tas_iec = enabled_iec;
-	}
+	tas_data->usa_tas_uhb_allowed = usa_tas_uhb;
+	tas_data->override_tas_iec = override_iec;
+	tas_data->enable_tas_iec = enabled_iec;
 
 	return enabled;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index a2d9d7807833..53bd82417cc3 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -94,9 +94,15 @@ struct iwl_ppag_chain {
 	s8 subbands[BIOS_SAR_MAX_SUB_BANDS_NUM];
 };
 
-struct iwl_fw_runtime;
+struct iwl_tas_data {
+	__le32 block_list_size;
+	__le32 block_list_array[IWL_WTAS_BLACK_LIST_MAX];
+	u8 override_tas_iec;
+	u8 enable_tas_iec;
+	u8 usa_tas_uhb_allowed;
+};
 
-union iwl_tas_config_cmd;
+struct iwl_fw_runtime;
 
 bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt);
 
@@ -117,7 +123,7 @@ bool iwl_is_ppag_approved(struct iwl_fw_runtime *fwrt);
 bool iwl_is_tas_approved(void);
 
 int iwl_parse_tas_selection(struct iwl_fw_runtime *fwrt,
-			    union iwl_tas_config_cmd *cmd, int fw_ver,
+			    struct iwl_tas_data *tas_data,
 			    const u32 tas_selection);
 
 int iwl_bios_get_wrds_table(struct iwl_fw_runtime *fwrt);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index e848b041e995..0f36eddb3143 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1135,10 +1135,13 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 {
 	u32 cmd_id = WIDE_ID(REGULATORY_AND_NVM_GROUP, TAS_CONFIG);
 	int ret;
-	union iwl_tas_config_cmd cmd = {};
+	struct iwl_tas_data data = {};
+	struct iwl_tas_config_cmd cmd = {};
 	int cmd_size, fw_ver;
 
-	BUILD_BUG_ON(ARRAY_SIZE(cmd.v3.block_list_array) <
+	BUILD_BUG_ON(ARRAY_SIZE(data.block_list_array) !=
+		     IWL_WTAS_BLACK_LIST_MAX);
+	BUILD_BUG_ON(ARRAY_SIZE(cmd.common.block_list_array) !=
 		     IWL_WTAS_BLACK_LIST_MAX);
 
 	if (!fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_TAS_CFG)) {
@@ -1146,10 +1149,7 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 		return;
 	}
 
-	fw_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id,
-				       IWL_FW_CMD_VER_UNKNOWN);
-
-	ret = iwl_acpi_get_tas(&mvm->fwrt, &cmd, fw_ver);
+	ret = iwl_acpi_get_tas(&mvm->fwrt, &data);
 	if (ret < 0) {
 		IWL_DEBUG_RADIO(mvm,
 				"TAS table invalid or unavailable. (%d)\n",
@@ -1164,12 +1164,12 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 		IWL_DEBUG_RADIO(mvm,
 				"System vendor '%s' is not in the approved list, disabling TAS in US and Canada.\n",
 				dmi_get_system_info(DMI_SYS_VENDOR));
-		if ((!iwl_mvm_add_to_tas_block_list(cmd.v4.block_list_array,
-						    &cmd.v4.block_list_size,
-							IWL_MCC_US)) ||
-		    (!iwl_mvm_add_to_tas_block_list(cmd.v4.block_list_array,
-						    &cmd.v4.block_list_size,
-							IWL_MCC_CANADA))) {
+		if ((!iwl_mvm_add_to_tas_block_list(data.block_list_array,
+						    &data.block_list_size,
+						    IWL_MCC_US)) ||
+		    (!iwl_mvm_add_to_tas_block_list(data.block_list_array,
+						    &data.block_list_size,
+						    IWL_MCC_CANADA))) {
 			IWL_DEBUG_RADIO(mvm,
 					"Unable to add US/Canada to TAS block list, disabling TAS\n");
 			return;
@@ -1180,10 +1180,25 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 				dmi_get_system_info(DMI_SYS_VENDOR));
 	}
 
-	/* v4 is the same size as v3, so no need to differentiate here */
-	cmd_size = fw_ver < 3 ?
-		sizeof(struct iwl_tas_config_cmd_v2) :
-		sizeof(struct iwl_tas_config_cmd_v3);
+	fw_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id,
+				       IWL_FW_CMD_VER_UNKNOWN);
+
+	memcpy(&cmd.common, &data, sizeof(struct iwl_tas_config_cmd_common));
+
+	/* Set v3 or v4 specific parts. will be trunctated for fw_ver < 3 */
+	if (fw_ver == 4) {
+		cmd.v4.override_tas_iec = data.override_tas_iec;
+		cmd.v4.enable_tas_iec = data.enable_tas_iec;
+		cmd.v4.usa_tas_uhb_allowed = data.usa_tas_uhb_allowed;
+	} else {
+		cmd.v3.override_tas_iec = cpu_to_le16(data.override_tas_iec);
+		cmd.v3.enable_tas_iec = cpu_to_le16(data.enable_tas_iec);
+	}
+
+	cmd_size = sizeof(struct iwl_tas_config_cmd_common);
+	if (fw_ver >= 3)
+		/* v4 is the same size as v3 */
+		cmd_size += sizeof(struct iwl_tas_config_cmd_v3);
 
 	ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, cmd_size, &cmd);
 	if (ret < 0)
-- 
2.34.1


