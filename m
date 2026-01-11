Return-Path: <linux-wireless+bounces-30656-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFC3D0F86B
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 18:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43D6A3056546
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 17:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205BA21ABBB;
	Sun, 11 Jan 2026 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RgfDdjda"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D8A34CFB4
	for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768153188; cv=none; b=BE8WyiDfXA4vg3fqAJoMelHkC6EDGPbI527GtP4yu/YW4rd1r7FtXkqTZhFNHCHWeHxd3P9owUhD8Ta1BCoWyeatUaJTn2NjPRzZcLh6ZZnWOJ2zjyaoJSxeS4jo048itorqVggBvVTKG6fkELYeGfD9jm63cQi96Oht3xNLBDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768153188; c=relaxed/simple;
	bh=IuZZch0rVqMYE4m6fENsrLaEbROvQGxYMy/KoSEKJN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rBXhfaGe040ge+n8VH1wC580BdOgRD4i9EBG8qNnqICRwIGf5dpo+9U9akNx+a9tKq1RR+Ovslu//o68ZqDVc8irGNnSuJyG8uWY9jUThQWe9vv/FNrEsxUP3ONj6qae0tTaWZIxffgy2sJI2R5FOK4zuLhBVIMxG8MtHMuotQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RgfDdjda; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768153186; x=1799689186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IuZZch0rVqMYE4m6fENsrLaEbROvQGxYMy/KoSEKJN8=;
  b=RgfDdjdaMgw7ZZYOYhCo3t0rvKqn/YYEdU4Aiayqqbry/4oUQQP2pxS4
   /9PxDUnn3UxZV4ib+y3jaBdRMq01hTC5YKa6CYHF8v63EFFCLCZtUdEnO
   y8anrk1bmyewZVeweF/BkWip3xPObe8p/EVsG+Qvtndz4T/gPG+ztkU6P
   7vS7dfNfrx52G21NdZvCw1DiC7s6X/fS9t27niyUZ9ZOXmwgTVtFKqBRd
   kS1rHD4AD8PqN4NWuTUio+KBVKfKPqMet31mdWzRfVI7gNUY/EjOwj8T/
   gOrxhd9lTPmC46IpkVVmVtm2jIc74XgN4jyNwse//xeaqA7FF4+YGqins
   A==;
X-CSE-ConnectionGUID: CVp6Cw1mRVeXLv9JBojocA==
X-CSE-MsgGUID: 6h4rSXWPT3OVCn5nPUaflw==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69521090"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69521090"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:44 -0800
X-CSE-ConnectionGUID: UQTjnYvNS32jxfilFpeasQ==
X-CSE-MsgGUID: 33kC628pSYutyUWGfXobMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="208393796"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:43 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: move iwl_get_lari_config_bitmap to the op_mode
Date: Sun, 11 Jan 2026 19:39:18 +0200
Message-Id: <20260111193638.099e733b1ece.Icac5b8eb5d8260e35df89622443d68a6beacedbb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260111173926.2216629-1-miriam.rachel.korenblit@intel.com>
References: <20260111173926.2216629-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This is used solely there.
The implementation can differe between different op_modes that support
different firmware versions

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 49 ------------------
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  2 -
 .../wireless/intel/iwlwifi/mld/regulatory.c   | 18 ++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 50 ++++++++++++++++++-
 4 files changed, 66 insertions(+), 53 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 7e7af2b81181..00f1c20a5a37 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -488,55 +488,6 @@ bool iwl_add_mcc_to_tas_block_list(u16 *list, u8 *size, u16 mcc)
 }
 IWL_EXPORT_SYMBOL(iwl_add_mcc_to_tas_block_list);
 
-__le32 iwl_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
-{
-	int ret;
-	u32 val;
-	__le32 config_bitmap = 0;
-
-	switch (CSR_HW_RFID_TYPE(fwrt->trans->info.hw_rf_id)) {
-	case IWL_CFG_RF_TYPE_HR1:
-	case IWL_CFG_RF_TYPE_HR2:
-	case IWL_CFG_RF_TYPE_JF1:
-	case IWL_CFG_RF_TYPE_JF2:
-		ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ENABLE_INDONESIA_5G2,
-				       &val);
-
-		if (!ret && val == DSM_VALUE_INDONESIA_ENABLE)
-			config_bitmap |=
-			    cpu_to_le32(LARI_CONFIG_ENABLE_5G2_IN_INDONESIA_MSK);
-		break;
-	default:
-		break;
-	}
-
-	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_DISABLE_SRD, &val);
-	if (!ret) {
-		if (val == DSM_VALUE_SRD_PASSIVE)
-			config_bitmap |=
-				cpu_to_le32(LARI_CONFIG_CHANGE_ETSI_TO_PASSIVE_MSK);
-		else if (val == DSM_VALUE_SRD_DISABLE)
-			config_bitmap |=
-				cpu_to_le32(LARI_CONFIG_CHANGE_ETSI_TO_DISABLED_MSK);
-	}
-
-	if (fw_has_capa(&fwrt->fw->ucode_capa,
-			IWL_UCODE_TLV_CAPA_CHINA_22_REG_SUPPORT)) {
-		ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_REGULATORY_CONFIG,
-				       &val);
-		/*
-		 * China 2022 enable if the BIOS object does not exist or
-		 * if it is enabled in BIOS.
-		 */
-		if (ret < 0 || val & DSM_MASK_CHINA_22_REG)
-			config_bitmap |=
-				cpu_to_le32(LARI_CONFIG_ENABLE_CHINA_22_REG_SUPPORT_MSK);
-	}
-
-	return config_bitmap;
-}
-IWL_EXPORT_SYMBOL(iwl_get_lari_config_bitmap);
-
 int iwl_bios_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
 		     u32 *value)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index 859cb303f813..26c1d3fad4df 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -218,8 +218,6 @@ int iwl_bios_get_mcc(struct iwl_fw_runtime *fwrt, char *mcc);
 int iwl_bios_get_eckv(struct iwl_fw_runtime *fwrt, u32 *ext_clk);
 int iwl_bios_get_wbem(struct iwl_fw_runtime *fwrt, u32 *value);
 
-__le32 iwl_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt);
-
 int iwl_bios_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
 		     u32 *value);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
index 40571125b3ab..92e6c0535501 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
@@ -206,11 +206,27 @@ int iwl_mld_init_ppag(struct iwl_mld *mld)
 	return iwl_mld_ppag_send_cmd(mld);
 }
 
+static __le32 iwl_mld_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
+{
+	int ret;
+	u32 val;
+
+	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_DISABLE_SRD, &val);
+	if (!ret) {
+		if (val == DSM_VALUE_SRD_PASSIVE)
+			return cpu_to_le32(LARI_CONFIG_CHANGE_ETSI_TO_PASSIVE_MSK);
+		else if (val == DSM_VALUE_SRD_DISABLE)
+			return cpu_to_le32(LARI_CONFIG_CHANGE_ETSI_TO_DISABLED_MSK);
+	}
+
+	return 0;
+}
+
 void iwl_mld_configure_lari(struct iwl_mld *mld)
 {
 	struct iwl_fw_runtime *fwrt = &mld->fwrt;
 	struct iwl_lari_config_change_cmd cmd = {
-		.config_bitmap = iwl_get_lari_config_bitmap(fwrt),
+		.config_bitmap = iwl_mld_get_lari_config_bitmap(fwrt),
 	};
 	bool has_raw_dsm_capa = fw_has_capa(&fwrt->fw->ucode_capa,
 					    IWL_UCODE_TLV_CAPA_FW_ACCEPTS_RAW_DSM_TABLE);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index d04f5d408ec3..018f3396e955 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1165,6 +1165,54 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 		IWL_DEBUG_RADIO(mvm, "failed to send TAS_CONFIG (%d)\n", ret);
 }
 
+static __le32 iwl_mvm_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
+{
+	int ret;
+	u32 val;
+	__le32 config_bitmap = 0;
+
+	switch (CSR_HW_RFID_TYPE(fwrt->trans->info.hw_rf_id)) {
+	case IWL_CFG_RF_TYPE_HR1:
+	case IWL_CFG_RF_TYPE_HR2:
+	case IWL_CFG_RF_TYPE_JF1:
+	case IWL_CFG_RF_TYPE_JF2:
+		ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ENABLE_INDONESIA_5G2,
+				       &val);
+
+		if (!ret && val == DSM_VALUE_INDONESIA_ENABLE)
+			config_bitmap |=
+			    cpu_to_le32(LARI_CONFIG_ENABLE_5G2_IN_INDONESIA_MSK);
+		break;
+	default:
+		break;
+	}
+
+	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_DISABLE_SRD, &val);
+	if (!ret) {
+		if (val == DSM_VALUE_SRD_PASSIVE)
+			config_bitmap |=
+				cpu_to_le32(LARI_CONFIG_CHANGE_ETSI_TO_PASSIVE_MSK);
+		else if (val == DSM_VALUE_SRD_DISABLE)
+			config_bitmap |=
+				cpu_to_le32(LARI_CONFIG_CHANGE_ETSI_TO_DISABLED_MSK);
+	}
+
+	if (fw_has_capa(&fwrt->fw->ucode_capa,
+			IWL_UCODE_TLV_CAPA_CHINA_22_REG_SUPPORT)) {
+		ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_REGULATORY_CONFIG,
+				       &val);
+		/*
+		 * China 2022 enable if the BIOS object does not exist or
+		 * if it is enabled in BIOS.
+		 */
+		if (ret < 0 || val & DSM_MASK_CHINA_22_REG)
+			config_bitmap |=
+				cpu_to_le32(LARI_CONFIG_ENABLE_CHINA_22_REG_SUPPORT_MSK);
+	}
+
+	return config_bitmap;
+}
+
 static size_t iwl_mvm_get_lari_config_cmd_size(u8 cmd_ver)
 {
 	size_t cmd_size;
@@ -1201,7 +1249,7 @@ static int iwl_mvm_fill_lari_config(struct iwl_fw_runtime *fwrt,
 	memset(cmd, 0, sizeof(*cmd));
 	*cmd_size = iwl_mvm_get_lari_config_cmd_size(cmd_ver);
 
-	cmd->config_bitmap = iwl_get_lari_config_bitmap(fwrt);
+	cmd->config_bitmap = iwl_mvm_get_lari_config_bitmap(fwrt);
 
 	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_11AX_ENABLEMENT, &value);
 	if (!ret) {
-- 
2.34.1


