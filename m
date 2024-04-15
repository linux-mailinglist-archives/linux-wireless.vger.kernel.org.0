Return-Path: <linux-wireless+bounces-6317-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6301B8A4AF3
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 10:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE7391F2114C
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 08:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727A54DA19;
	Mon, 15 Apr 2024 08:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bDbZtFqn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D67B4DA05
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 08:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171314; cv=none; b=eoxaKiLoyUDngzz6l122QRMLg18mrB7jzUODjanP6Zch8u6JgkXknN9oSSIvdHidckQBXDIDnJmEZ6azE1mov1h92wx5bas7VZYh0N7YnhVn5GtH4bP4DXLmGY1n+ngP7PtNMgWn/ReBeRc/PkHNLqHr6fJLH5d8PNuYHPKmhGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171314; c=relaxed/simple;
	bh=HWgkcGbaFhsQsuI/xKg3sZTK4AY4HfyKeGDVYhVUFKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c/9ZNYBVxDb73x5hqWDCfF6F2DJ6jcJrwInrthhcubvTn+IiuawGeNXwUrsrFTQpTvxl4kCqG6DaHVLB5lr/17kU8obQIihb8N4YIFJX8YZfwl4nIVvmb+wp0vh+/fMNKWjkwakkcEPZYhvAYoHrcSvmsBrGHDKYsxAj4C2sckU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bDbZtFqn; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713171313; x=1744707313;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HWgkcGbaFhsQsuI/xKg3sZTK4AY4HfyKeGDVYhVUFKQ=;
  b=bDbZtFqn/chRs1T8bRqrjIX8iDOCaO1ag4B3wspgK1Cllb1Bbz7l0TS6
   Ko4nE2fKcn6xy7DRXLq2w9EQcOdyhkT9fB4dalOhk+PFZpopgkXb3WpAX
   ERD/gSJlDMgptoZg/r/6W3trfnfmldX+0nbpxd6beSUcB9VPZfe8qR+e4
   QMFmhg5N0jYrVhvjU9A7yO6mbEc+/mpfgNFy5Awu0x3wBTmpb7xKAXOWa
   0V/e9TUTVz5uJG88juUsgSZErBCZ2hRCa1QpT7z7L6+OqTSKBOB7cxwaP
   sV9LciSWTI1kzt0iPZriKybRzAKg1DlTgzYYN91p8NaHZ+DX+cshhTUzG
   A==;
X-CSE-ConnectionGUID: X9b4VJ4KTHGhv3inYKyEIg==
X-CSE-MsgGUID: Dl+YX13STSSHUFQGHQXEug==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="9100613"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="9100613"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:55:12 -0700
X-CSE-ConnectionGUID: XUeo/PCaQhiTF4Ox3Ep6VA==
X-CSE-MsgGUID: osONar7zTMyHGafJnvQgPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="21768069"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:55:11 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH 09/11] wifi: iwlwifi: Add support for LARI_CONFIG_CHANGE_CMD v10
Date: Mon, 15 Apr 2024 11:54:42 +0300
Message-Id: <20240415114847.7946c3befbe1.I453c33f7ea48156ea2a3961f50a9003103fca5a5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415085444.3840884-1-miriam.rachel.korenblit@intel.com>
References: <20240415085444.3840884-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Add support for enable/disable 320 MHz for Japan and South Korea
by reading WBEM (WiFi Bandwidth Enablement per MCC) variable from
UEFI or ACPI and sending it to the FW.

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 36 ++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  | 16 +++++++
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   | 44 ++++++++++++++++++-
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 18 ++++++--
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  3 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 23 ++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  | 24 +++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  4 +-
 8 files changed, 157 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 4caf2e25a297..fa339791223b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2019-2023 Intel Corporation
+ * Copyright (C) 2019-2024 Intel Corporation
  */
 #include <linux/uuid.h>
 #include "iwl-drv.h"
@@ -960,3 +960,37 @@ void iwl_acpi_get_guid_lock_status(struct iwl_fw_runtime *fwrt)
 	kfree(data);
 }
 IWL_EXPORT_SYMBOL(iwl_acpi_get_guid_lock_status);
+
+int iwl_acpi_get_wbem(struct iwl_fw_runtime *fwrt, u32 *value)
+{
+	union acpi_object *wifi_pkg, *data;
+	int ret = -ENOENT;
+	int tbl_rev;
+
+	data = iwl_acpi_get_object(fwrt->dev, ACPI_WBEM_METHOD);
+	if (IS_ERR(data))
+		return ret;
+
+	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
+					 ACPI_WBEM_WIFI_DATA_SIZE,
+					 &tbl_rev);
+	if (IS_ERR(wifi_pkg))
+		goto out_free;
+
+	if (tbl_rev != IWL_ACPI_WBEM_REVISION) {
+		IWL_DEBUG_RADIO(fwrt, "Unsupported ACPI WBEM revision:%d\n",
+				tbl_rev);
+		goto out_free;
+	}
+
+	if (wifi_pkg->package.elements[1].type != ACPI_TYPE_INTEGER)
+		goto out_free;
+
+	*value = wifi_pkg->package.elements[1].integer.value &
+		 IWL_ACPI_WBEM_REV0_MASK;
+	IWL_DEBUG_RADIO(fwrt, "Loaded WBEM config from ACPI\n");
+	ret = 0;
+out_free:
+	kfree(data);
+	return ret;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 1d32b82f73db..bb88398a6987 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -27,6 +27,7 @@
 #define ACPI_WTAS_METHOD	"WTAS"
 #define ACPI_WPFC_METHOD	"WPFC"
 #define ACPI_GLAI_METHOD	"GLAI"
+#define ACPI_WBEM_METHOD	"WBEM"
 
 #define ACPI_WIFI_DOMAIN	(0x07)
 
@@ -67,6 +68,12 @@
 #define ACPI_WRDD_WIFI_DATA_SIZE	2
 #define ACPI_SPLC_WIFI_DATA_SIZE	2
 #define ACPI_ECKV_WIFI_DATA_SIZE	2
+
+/*
+ * One element for domain type,
+ * and one for enablement of Wi-Fi 320MHz per MCC
+ */
+#define ACPI_WBEM_WIFI_DATA_SIZE	2
 /*
  * One element for domain type,
  * and one for the status
@@ -94,6 +101,9 @@
 
 #define ACPI_DSM_REV 0
 
+#define IWL_ACPI_WBEM_REV0_MASK (BIT(0) | BIT(1))
+#define IWL_ACPI_WBEM_REVISION 0
+
 #ifdef CONFIG_ACPI
 
 struct iwl_fw_runtime;
@@ -142,6 +152,7 @@ void iwl_acpi_get_guid_lock_status(struct iwl_fw_runtime *fwrt);
 int iwl_acpi_get_dsm(struct iwl_fw_runtime *fwrt,
 		     enum iwl_dsm_funcs func, u32 *value);
 
+int iwl_acpi_get_wbem(struct iwl_fw_runtime *fwrt, u32 *value);
 #else /* CONFIG_ACPI */
 
 static inline void *iwl_acpi_get_dsm_object(struct device *dev, int rev,
@@ -205,6 +216,11 @@ static inline int iwl_acpi_get_dsm(struct iwl_fw_runtime *fwrt,
 {
 	return -ENOENT;
 }
+
+static inline int iwl_acpi_get_wbem(struct iwl_fw_runtime *fwrt, u32 *value)
+{
+	return -ENOENT;
+}
 #endif /* CONFIG_ACPI */
 
 #endif /* __iwl_fw_acpi__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index 6f16d0d3d8e5..c9c0329f5778 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -22,8 +22,9 @@ enum iwl_regulatory_and_nvm_subcmd_ids {
 	 *	&struct iwl_lari_config_change_cmd_v3,
 	 *	&struct iwl_lari_config_change_cmd_v4,
 	 *	&struct iwl_lari_config_change_cmd_v5,
-	 *	&struct iwl_lari_config_change_cmd_v6 or
-	 *	&struct iwl_lari_config_change_cmd_v7
+	 *	&struct iwl_lari_config_change_cmd_v6,
+	 *	&struct iwl_lari_config_change_cmd_v7 or
+	 *	&struct iwl_lari_config_change_cmd
 	 */
 	LARI_CONFIG_CHANGE = 0x1,
 
@@ -646,6 +647,45 @@ struct iwl_lari_config_change_cmd_v7 {
 /* LARI_CHANGE_CONF_CMD_S_VER_8 */
 /* LARI_CHANGE_CONF_CMD_S_VER_9 */
 
+/**
+ * struct iwl_lari_config_change_cmd - change LARI configuration
+ * @config_bitmap: Bitmap of the config commands. Each bit will trigger a
+ *	different predefined FW config operation.
+ * @oem_uhb_allow_bitmap: Bitmap of UHB enabled MCC sets.
+ * @oem_11ax_allow_bitmap: Bitmap of 11ax allowed MCCs. There are two bits
+ *	per country, one to indicate whether to override and the other to
+ *	indicate the value to use.
+ * @oem_unii4_allow_bitmap: Bitmap of unii4 allowed MCCs.There are two bits
+ *	per country, one to indicate whether to override and the other to
+ *	indicate allow/disallow unii4 channels.
+ *	For LARI cmd version 10 - bits 0:5 are supported.
+ * @chan_state_active_bitmap: Bitmap to enable different bands per country
+ *	or region.
+ *	Each bit represents a country or region, and a band to activate
+ *	according to the BIOS definitions.
+ *	For LARI cmd version 10 - bits 0:4 are supported.
+ * @force_disable_channels_bitmap: Bitmap of disabled bands/channels.
+ *	Each bit represents a set of channels in a specific band that should be
+ *	disabled
+ * @edt_bitmap: Bitmap of energy detection threshold table.
+ *	Disable/enable the EDT optimization method for different band.
+ * @oem_320mhz_allow_bitmap: 320Mhz bandwidth enablement bitmap per MCC.
+ *	bit0: enable 320Mhz in Japan.
+ *	bit1: enable 320Mhz in South Korea.
+ *	bit 2 - 31: reserved.
+ */
+struct iwl_lari_config_change_cmd {
+	__le32 config_bitmap;
+	__le32 oem_uhb_allow_bitmap;
+	__le32 oem_11ax_allow_bitmap;
+	__le32 oem_unii4_allow_bitmap;
+	__le32 chan_state_active_bitmap;
+	__le32 force_disable_channels_bitmap;
+	__le32 edt_bitmap;
+	__le32 oem_320mhz_allow_bitmap;
+} __packed;
+/* LARI_CHANGE_CONF_CMD_S_VER_10 */
+
 /* Activate UNII-1 (5.2GHz) for World Wide */
 #define ACTIVATE_5G2_IN_WW_MASK	BIT(4)
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 6d4b9334702e..b9bb3636e88f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -38,6 +38,7 @@ IWL_BIOS_TABLE_LOADER_DATA(tas_table, struct iwl_tas_data);
 IWL_BIOS_TABLE_LOADER_DATA(pwr_limit, u64);
 IWL_BIOS_TABLE_LOADER_DATA(mcc, char);
 IWL_BIOS_TABLE_LOADER_DATA(eckv, u32);
+IWL_BIOS_TABLE_LOADER_DATA(wbem, u32);
 
 
 static const struct dmi_system_id dmi_ppag_approved_list[] = {
@@ -496,6 +497,9 @@ static size_t iwl_get_lari_config_cmd_size(u8 cmd_ver)
 	size_t cmd_size;
 
 	switch (cmd_ver) {
+	case 10:
+		cmd_size = sizeof(struct iwl_lari_config_change_cmd);
+		break;
 	case 9:
 	case 8:
 	case 7:
@@ -524,7 +528,7 @@ static size_t iwl_get_lari_config_cmd_size(u8 cmd_ver)
 }
 
 int iwl_fill_lari_config(struct iwl_fw_runtime *fwrt,
-			 struct iwl_lari_config_change_cmd_v7 *cmd,
+			 struct iwl_lari_config_change_cmd *cmd,
 			 size_t *cmd_size)
 {
 	int ret;
@@ -572,13 +576,18 @@ int iwl_fill_lari_config(struct iwl_fw_runtime *fwrt,
 	if (!ret)
 		cmd->edt_bitmap = cpu_to_le32(value);
 
+	ret = iwl_bios_get_wbem(fwrt, &value);
+	if (!ret)
+		cmd->oem_320mhz_allow_bitmap = cpu_to_le32(value);
+
 	if (cmd->config_bitmap ||
 	    cmd->oem_uhb_allow_bitmap ||
 	    cmd->oem_11ax_allow_bitmap ||
 	    cmd->oem_unii4_allow_bitmap ||
 	    cmd->chan_state_active_bitmap ||
 	    cmd->force_disable_channels_bitmap ||
-	    cmd->edt_bitmap) {
+	    cmd->edt_bitmap ||
+	    cmd->oem_320mhz_allow_bitmap) {
 		IWL_DEBUG_RADIO(fwrt,
 				"sending LARI_CONFIG_CHANGE, config_bitmap=0x%x, oem_11ax_allow_bitmap=0x%x\n",
 				le32_to_cpu(cmd->config_bitmap),
@@ -593,8 +602,9 @@ int iwl_fill_lari_config(struct iwl_fw_runtime *fwrt,
 				le32_to_cpu(cmd->oem_uhb_allow_bitmap),
 				le32_to_cpu(cmd->force_disable_channels_bitmap));
 		IWL_DEBUG_RADIO(fwrt,
-				"sending LARI_CONFIG_CHANGE, edt_bitmap=0x%x\n",
-				le32_to_cpu(cmd->edt_bitmap));
+				"sending LARI_CONFIG_CHANGE, edt_bitmap=0x%x, oem_320mhz_allow_bitmap=0x%x\n",
+				le32_to_cpu(cmd->edt_bitmap),
+				le32_to_cpu(cmd->oem_320mhz_allow_bitmap));
 	} else {
 		return 1;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index eea04d2934ab..633c9ad9af84 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -201,9 +201,10 @@ int iwl_bios_get_pwr_limit(struct iwl_fw_runtime *fwrt,
 
 int iwl_bios_get_mcc(struct iwl_fw_runtime *fwrt, char *mcc);
 int iwl_bios_get_eckv(struct iwl_fw_runtime *fwrt, u32 *ext_clk);
+int iwl_bios_get_wbem(struct iwl_fw_runtime *fwrt, u32 *value);
 
 int iwl_fill_lari_config(struct iwl_fw_runtime *fwrt,
-			 struct iwl_lari_config_change_cmd_v7 *cmd,
+			 struct iwl_lari_config_change_cmd *cmd,
 			 size_t *cmd_size);
 
 int iwl_bios_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index e81fc0129b9d..fb982d4fe851 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -674,6 +674,29 @@ int iwl_uefi_get_eckv(struct iwl_fw_runtime *fwrt, u32 *extl_clk)
 	return ret;
 }
 
+int iwl_uefi_get_wbem(struct iwl_fw_runtime *fwrt, u32 *value)
+{
+	struct uefi_cnv_wlan_wbem_data *data;
+	int ret = 0;
+
+	data = iwl_uefi_get_verified_variable(fwrt->trans, IWL_UEFI_WBEM_NAME,
+					      "WBEM", sizeof(*data), NULL);
+	if (IS_ERR(data))
+		return -EINVAL;
+
+	if (data->revision != IWL_UEFI_WBEM_REVISION) {
+		ret = -EINVAL;
+		IWL_DEBUG_RADIO(fwrt, "Unsupported UEFI WBEM revision:%d\n",
+				data->revision);
+		goto out;
+	}
+	*value = data->wbem_320mhz_per_mcc & IWL_UEFI_WBEM_REV0_MASK;
+	IWL_DEBUG_RADIO(fwrt, "Loaded WBEM config from UEFI\n");
+out:
+	kfree(data);
+	return ret;
+}
+
 int iwl_uefi_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
 		     u32 *value)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 303cc299d1bc..1f8884ca8997 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright(c) 2021-2023 Intel Corporation
+ * Copyright(c) 2021-2024 Intel Corporation
  */
 #ifndef __iwl_fw_uefi__
 #define __iwl_fw_uefi__
@@ -21,6 +21,7 @@
 #define IWL_UEFI_WRDD_NAME		L"UefiCnvWlanWRDD"
 #define IWL_UEFI_ECKV_NAME		L"UefiCnvWlanECKV"
 #define IWL_UEFI_DSM_NAME		L"UefiCnvWlanGeneralCfg"
+#define IWL_UEFI_WBEM_NAME		L"UefiCnvWlanWBEM"
 
 
 #define IWL_SGOM_MAP_SIZE		339
@@ -35,6 +36,7 @@
 #define IWL_UEFI_SPLC_REVISION		0
 #define IWL_UEFI_WRDD_REVISION		0
 #define IWL_UEFI_ECKV_REVISION		0
+#define IWL_UEFI_WBEM_REVISION		0
 #define IWL_UEFI_DSM_REVISION		4
 
 struct pnvm_sku_package {
@@ -178,6 +180,20 @@ struct uefi_cnv_var_general_cfg {
 	u32 functions[UEFI_MAX_DSM_FUNCS];
 } __packed;
 
+#define IWL_UEFI_WBEM_REV0_MASK (BIT(0) | BIT(1))
+/* struct uefi_cnv_wlan_wbem_data - Bandwidth enablement per MCC as defined
+ *	in UEFI
+ * @revision: the revision of the table
+ * @wbem_320mhz_per_mcc: enablement of 320MHz bandwidth per MCC
+ *	bit 0 - if set, 320MHz is enabled for Japan
+ *	bit 1 - if set, 320MHz is enabled for South Korea
+ *	bit 2- 31, Reserved
+ */
+struct uefi_cnv_wlan_wbem_data {
+	u8 revision;
+	u32 wbem_320mhz_per_mcc;
+} __packed;
+
 /*
  * This is known to be broken on v4.19 and to work on v5.4.  Until we
  * figure out why this is the case and how to make it work, simply
@@ -202,6 +218,7 @@ int iwl_uefi_get_pwr_limit(struct iwl_fw_runtime *fwrt,
 			   u64 *dflt_pwr_limit);
 int iwl_uefi_get_mcc(struct iwl_fw_runtime *fwrt, char *mcc);
 int iwl_uefi_get_eckv(struct iwl_fw_runtime *fwrt, u32 *extl_clk);
+int iwl_uefi_get_wbem(struct iwl_fw_runtime *fwrt, u32 *value);
 int iwl_uefi_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
 		     u32 *value);
 void iwl_uefi_get_sgom_table(struct iwl_trans *trans, struct iwl_fw_runtime *fwrt);
@@ -281,6 +298,11 @@ static inline int iwl_uefi_get_eckv(struct iwl_fw_runtime *fwrt, u32 *extl_clk)
 	return -ENOENT;
 }
 
+static inline int iwl_uefi_get_wbem(struct iwl_fw_runtime *fwrt, u32 *value)
+{
+	return -ENOENT;
+}
+
 static inline int iwl_uefi_get_dsm(struct iwl_fw_runtime *fwrt,
 				   enum iwl_dsm_funcs func, u32 *value)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 243eeccc7ef6..74b299139391 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1225,9 +1225,9 @@ static bool iwl_mvm_eval_dsm_rfi(struct iwl_mvm *mvm)
 
 static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 {
-	int ret;
+	struct iwl_lari_config_change_cmd cmd;
 	size_t cmd_size;
-	struct iwl_lari_config_change_cmd_v7 cmd;
+	int ret;
 
 	ret = iwl_fill_lari_config(&mvm->fwrt, &cmd, &cmd_size);
 	if (!ret) {
-- 
2.34.1


