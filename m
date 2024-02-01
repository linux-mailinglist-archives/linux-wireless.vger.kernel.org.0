Return-Path: <linux-wireless+bounces-2958-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E05508459FE
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 15:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9813F28E131
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 14:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7748E5D481;
	Thu,  1 Feb 2024 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CXQEAVGQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE625D48A
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797217; cv=none; b=iZDvmZW73OVcgqByZ65W373SrRaRnqPySb4kpa6mkXoE5MlliP6NisLQ7hNu0Bz5qAhsBU/OwICJRNlOzqG7UHZNkrc6sdO4usN9v24GYz8r/wLX59paiduI+rOxnv9xu7uh1k1UFrTu4gVPqsRq3JxKhF7Qy7JH0Z5eZ3K7Wrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797217; c=relaxed/simple;
	bh=Do+hOuu6rmkauhOGJU22XQ0ovD5Wz1aIW2qTzl4PrRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LpKipSdHFC6M2SSidvWiOr6Dij1nob9buMsfGyIfeaa/ecKh3mdzwWhg2gMpw1DZPjtSSLIZiAyTXxLIZFl9W+hNHP8vlqn91q2Qe5efaGAKS5WkJ3J+xZAUwObgjpGZM0CmUxxIrSTINVI8kj4fj15hDosRSM082HHmGOtsHBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CXQEAVGQ; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706797215; x=1738333215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Do+hOuu6rmkauhOGJU22XQ0ovD5Wz1aIW2qTzl4PrRI=;
  b=CXQEAVGQq4MeZ2g8hESTG3kHRt7iF/iSfWnqZiIcbX+NHkUra5CrxXLp
   GGNqGjcRFIWBFumqn0/xYMHxiDm4mv0IH0+l1DRkUhGvnr3KBD6treb5c
   /XicHqsYkZpzhkaQFBs8qEcbpdCKJYHqUQ3trprG08UqjIOSeaqOwWtwv
   5JEIEah2fkLEm3Zpz15Z3jI0S4X6yDAmmUsG44hNWHN2hk3I8cCIaxlsG
   bn+EIsP6nsIHjSKRZIoZPoWga8BrpM4EcnozR6qIFLjZbDVEEFNOWinzl
   5Ckr5vfrEoKkeYHGfkrVBKQG3+cqSjzNN5tJ/+r5xCtzK9XmC3Z8TCpft
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="435062945"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="435062945"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:20:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="94312"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:20:06 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/17] wifi: iwlwifi: prepare for reading DSM from UEFI
Date: Thu,  1 Feb 2024 16:17:36 +0200
Message-Id: <20240201155157.eae9bcbc0023.If1175f3143d6369076669ddd5d6ad4df0ee00659@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201141741.2569180-1-miriam.rachel.korenblit@intel.com>
References: <20240201141741.2569180-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Move all the common items (functions, enumerations and mcaros)
to regulatory.h/c files, and rename it to a common name.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 60 +------------------
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  | 48 +--------------
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 49 +++++++++++++++
 .../wireless/intel/iwlwifi/fw/regulatory.h    | 44 ++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  2 +-
 5 files changed, 97 insertions(+), 106 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 22b21bbc294f..357047223686 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -157,7 +157,7 @@ static int iwl_acpi_get_dsm_integer(struct device *dev, int rev, int func,
  * In case the expected size is smaller than 32-bit, padding will be added.
  */
 int iwl_acpi_get_dsm(struct iwl_fw_runtime *fwrt,
-		     enum iwl_dsm_funcs_rev_0 func, u32 *value)
+		     enum iwl_dsm_funcs func, u32 *value)
 {
 	size_t expected_size;
 	u64 tmp;
@@ -808,64 +808,6 @@ int iwl_acpi_get_wgds_table(struct iwl_fw_runtime *fwrt)
 	return ret;
 }
 
-__le32 iwl_acpi_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
-{
-	int ret;
-	u32 val;
-	__le32 config_bitmap = 0;
-
-	/*
-	 * Evaluate func 'DSM_FUNC_ENABLE_INDONESIA_5G2'.
-	 * Setting config_bitmap Indonesia bit is valid only for HR/JF.
-	 */
-	switch (CSR_HW_RFID_TYPE(fwrt->trans->hw_rf_id)) {
-	case IWL_CFG_RF_TYPE_HR1:
-	case IWL_CFG_RF_TYPE_HR2:
-	case IWL_CFG_RF_TYPE_JF1:
-	case IWL_CFG_RF_TYPE_JF2:
-		ret = iwl_acpi_get_dsm(fwrt, DSM_FUNC_ENABLE_INDONESIA_5G2,
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
-	/*
-	 ** Evaluate func 'DSM_FUNC_DISABLE_SRD'
-	 */
-	ret = iwl_acpi_get_dsm(fwrt, DSM_FUNC_DISABLE_SRD, &val);
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
-		/*
-		 ** Evaluate func 'DSM_FUNC_REGULATORY_CONFIG'
-		 */
-		ret = iwl_acpi_get_dsm(fwrt, DSM_FUNC_REGULATORY_CONFIG, &val);
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
-IWL_EXPORT_SYMBOL(iwl_acpi_get_lari_config_bitmap);
-
 int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 {
 	union acpi_object *wifi_pkg, *data, *flags;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index d84952f90444..9cb101776884 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -94,47 +94,6 @@
 
 #define ACPI_DSM_REV 0
 
-enum iwl_dsm_funcs_rev_0 {
-	DSM_FUNC_QUERY = 0,
-	DSM_FUNC_DISABLE_SRD = 1,
-	DSM_FUNC_ENABLE_INDONESIA_5G2 = 2,
-	DSM_FUNC_ENABLE_6E = 3,
-	DSM_FUNC_REGULATORY_CONFIG = 4,
-	DSM_FUNC_11AX_ENABLEMENT = 6,
-	DSM_FUNC_ENABLE_UNII4_CHAN = 7,
-	DSM_FUNC_ACTIVATE_CHANNEL = 8,
-	DSM_FUNC_FORCE_DISABLE_CHANNELS = 9,
-	DSM_FUNC_ENERGY_DETECTION_THRESHOLD = 10,
-	DSM_FUNC_RFI_CONFIG = 11,
-	DSM_FUNC_NUM_FUNCS = 12,
-};
-
-enum iwl_dsm_values_srd {
-	DSM_VALUE_SRD_ACTIVE,
-	DSM_VALUE_SRD_PASSIVE,
-	DSM_VALUE_SRD_DISABLE,
-	DSM_VALUE_SRD_MAX
-};
-
-enum iwl_dsm_values_indonesia {
-	DSM_VALUE_INDONESIA_DISABLE,
-	DSM_VALUE_INDONESIA_ENABLE,
-	DSM_VALUE_INDONESIA_RESERVED,
-	DSM_VALUE_INDONESIA_MAX
-};
-
-enum iwl_dsm_values_rfi {
-	DSM_VALUE_RFI_DLVR_DISABLE	= BIT(0),
-	DSM_VALUE_RFI_DDR_DISABLE	= BIT(1),
-};
-
-#define DSM_VALUE_RFI_DISABLE	(DSM_VALUE_RFI_DLVR_DISABLE |\
-				 DSM_VALUE_RFI_DDR_DISABLE)
-
-enum iwl_dsm_masks_reg {
-	DSM_MASK_CHINA_22_REG = BIT(2)
-};
-
 #ifdef CONFIG_ACPI
 
 struct iwl_fw_runtime;
@@ -173,8 +132,6 @@ int iwl_acpi_get_wgds_table(struct iwl_fw_runtime *fwrt);
 int iwl_acpi_get_tas_table(struct iwl_fw_runtime *fwrt,
 			   struct iwl_tas_data *data);
 
-__le32 iwl_acpi_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt);
-
 int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt);
 
 void iwl_acpi_get_phy_filters(struct iwl_fw_runtime *fwrt,
@@ -183,7 +140,7 @@ void iwl_acpi_get_phy_filters(struct iwl_fw_runtime *fwrt,
 void iwl_acpi_get_guid_lock_status(struct iwl_fw_runtime *fwrt);
 
 int iwl_acpi_get_dsm(struct iwl_fw_runtime *fwrt,
-		     enum iwl_dsm_funcs_rev_0 func, u32 *value);
+		     enum iwl_dsm_funcs func, u32 *value);
 
 #else /* CONFIG_ACPI */
 
@@ -246,8 +203,7 @@ static inline void iwl_acpi_get_guid_lock_status(struct iwl_fw_runtime *fwrt)
 }
 
 static inline int iwl_acpi_get_dsm(struct iwl_fw_runtime *fwrt,
-				   enum iwl_dsm_funcs_rev_0 func,
-				   u32 *value)
+				   enum iwl_dsm_funcs func, u32 *value)
 {
 	return -ENOENT;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index bb07fbfd81eb..3260f21fd2e0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -431,3 +431,52 @@ int iwl_parse_tas_selection(struct iwl_fw_runtime *fwrt,
 
 	return enabled;
 }
+
+__le32 iwl_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
+{
+	int ret;
+	u32 val;
+	__le32 config_bitmap = 0;
+
+	switch (CSR_HW_RFID_TYPE(fwrt->trans->hw_rf_id)) {
+	case IWL_CFG_RF_TYPE_HR1:
+	case IWL_CFG_RF_TYPE_HR2:
+	case IWL_CFG_RF_TYPE_JF1:
+	case IWL_CFG_RF_TYPE_JF2:
+		ret = iwl_acpi_get_dsm(fwrt, DSM_FUNC_ENABLE_INDONESIA_5G2,
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
+	ret = iwl_acpi_get_dsm(fwrt, DSM_FUNC_DISABLE_SRD, &val);
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
+		ret = iwl_acpi_get_dsm(fwrt, DSM_FUNC_REGULATORY_CONFIG,
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
+IWL_EXPORT_SYMBOL(iwl_get_lari_config_bitmap);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index ec408c06235d..da49ed7325d6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -102,6 +102,48 @@ struct iwl_tas_data {
 	u8 usa_tas_uhb_allowed;
 };
 
+/* For DSM revision 0 and 4 */
+enum iwl_dsm_funcs {
+	DSM_FUNC_QUERY = 0,
+	DSM_FUNC_DISABLE_SRD = 1,
+	DSM_FUNC_ENABLE_INDONESIA_5G2 = 2,
+	DSM_FUNC_ENABLE_6E = 3,
+	DSM_FUNC_REGULATORY_CONFIG = 4,
+	DSM_FUNC_11AX_ENABLEMENT = 6,
+	DSM_FUNC_ENABLE_UNII4_CHAN = 7,
+	DSM_FUNC_ACTIVATE_CHANNEL = 8,
+	DSM_FUNC_FORCE_DISABLE_CHANNELS = 9,
+	DSM_FUNC_ENERGY_DETECTION_THRESHOLD = 10,
+	DSM_FUNC_RFI_CONFIG = 11,
+	DSM_FUNC_NUM_FUNCS = 12,
+};
+
+enum iwl_dsm_values_srd {
+	DSM_VALUE_SRD_ACTIVE,
+	DSM_VALUE_SRD_PASSIVE,
+	DSM_VALUE_SRD_DISABLE,
+	DSM_VALUE_SRD_MAX
+};
+
+enum iwl_dsm_values_indonesia {
+	DSM_VALUE_INDONESIA_DISABLE,
+	DSM_VALUE_INDONESIA_ENABLE,
+	DSM_VALUE_INDONESIA_RESERVED,
+	DSM_VALUE_INDONESIA_MAX
+};
+
+enum iwl_dsm_values_rfi {
+	DSM_VALUE_RFI_DLVR_DISABLE	= BIT(0),
+	DSM_VALUE_RFI_DDR_DISABLE	= BIT(1),
+};
+
+#define DSM_VALUE_RFI_DISABLE	(DSM_VALUE_RFI_DLVR_DISABLE |\
+				 DSM_VALUE_RFI_DDR_DISABLE)
+
+enum iwl_dsm_masks_reg {
+	DSM_MASK_CHINA_22_REG = BIT(2)
+};
+
 struct iwl_fw_runtime;
 
 bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt);
@@ -142,4 +184,6 @@ int iwl_bios_get_pwr_limit(struct iwl_fw_runtime *fwrt,
 
 int iwl_bios_get_mcc(struct iwl_fw_runtime *fwrt, char *mcc);
 int iwl_bios_get_eckv(struct iwl_fw_runtime *fwrt, u32 *ext_clk);
+
+__le32 iwl_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt);
 #endif /* __fw_regulatory_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index f8d7f23741bf..a05a5f403ae5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1242,7 +1242,7 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 					   WIDE_ID(REGULATORY_AND_NVM_GROUP,
 						   LARI_CONFIG_CHANGE), 1);
 
-	cmd.config_bitmap = iwl_acpi_get_lari_config_bitmap(&mvm->fwrt);
+	cmd.config_bitmap = iwl_get_lari_config_bitmap(&mvm->fwrt);
 
 	ret = iwl_acpi_get_dsm(&mvm->fwrt, DSM_FUNC_11AX_ENABLEMENT, &value);
 	if (!ret)
-- 
2.34.1


