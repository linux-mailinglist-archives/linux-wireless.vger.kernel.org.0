Return-Path: <linux-wireless+bounces-2961-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEC6845A00
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 15:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0632228E246
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 14:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C9D5F474;
	Thu,  1 Feb 2024 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bb9INu5r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568985337E
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797219; cv=none; b=j2sOLPaZaafNgBgtjPi8Fjs3rDLrU29gEPKc72qQaIk7z8ZF/IQj6bSwG0X0RnLbPNW3zqx4m/57nD72IitNcyMRfSs1jFYiP/ehpJiqenfwCU16pWRx+/y0wsRBNJnfBMyFdZ13zW6fsD3qRVPbwDRWJlJzaNHTephCdMZFY+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797219; c=relaxed/simple;
	bh=lPpYux3Bc7SHA9Yv0VzShwU4smyjOpNhDUqpyafWDX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rjtFCo86WO8joEOrGLmo9T4eDlCv5i6vqv0rJDZsxoAL82uLUyZOrywO3An1dftCnmtVbFn1vG0YkkJYdVO0/tNJPkGmwpob2KitOjKhBdLM+tBZhgDnzsn5poJ67pxaCH3yAYPl2xQWyNyV8j0EdSm6XsEwXl2R0GbAE821gm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bb9INu5r; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706797217; x=1738333217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lPpYux3Bc7SHA9Yv0VzShwU4smyjOpNhDUqpyafWDX8=;
  b=bb9INu5rCPfizbQPpE7/oXpqGuvhClafBM/whAxtPlHx/3AKjQ/ouZF/
   BuInlLYTuRdFu2sOhoUxN+PAYl58eG6tL9E5hKPb1VKTBPERxXylk825Q
   HOvzKsUZDnz3KOgzKmxN02N4Xmf0g+xpvB95zXEGY9kUv2uCEQgkXsDYH
   JLOU9XjsYeXXgv5mkrZ2QVhQxkjupul0j7z+uXqhagIQ47BMFsUxaN1p2
   1bb0U7MleO9UEZQvuzhi8Vu7glNwCgFRUO+rim3IXhQtUSLTbF4uZ3yv9
   QXkV4NOpcPdWpK5ZJ2auDdSM+UyEfKpYMNYFYqc+5oWcL6WG7Z3lWLnFk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="435062960"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="435062960"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:20:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="94399"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:20:10 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/17] wifi: iwlwifi: read DSM functions from UEFI
Date: Thu,  1 Feb 2024 16:17:37 +0200
Message-Id: <20240201155157.27dd626ce2bd.Ib90bab74a9d56deb2362edb712294360e4ddae5b@changeid>
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

For each DSM function, try to first read it from the UEFI.
If the UEFI WIFI GUID is unclocked, or the DSM function in
UEFI is invalid/unavailable - read it from ACPI.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  1 -
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 13 ++++++--
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  3 ++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 33 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  | 21 ++++++++++++
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 14 ++++----
 7 files changed, 75 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 357047223686..9afb1b1d6aea 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -187,7 +187,6 @@ int iwl_acpi_get_dsm(struct iwl_fw_runtime *fwrt,
 
 	return 0;
 }
-IWL_EXPORT_SYMBOL(iwl_acpi_get_dsm);
 
 static union acpi_object *
 iwl_acpi_get_wifi_pkg_range(struct device *dev,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 3260f21fd2e0..a42775141952 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -443,7 +443,7 @@ __le32 iwl_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
 	case IWL_CFG_RF_TYPE_HR2:
 	case IWL_CFG_RF_TYPE_JF1:
 	case IWL_CFG_RF_TYPE_JF2:
-		ret = iwl_acpi_get_dsm(fwrt, DSM_FUNC_ENABLE_INDONESIA_5G2,
+		ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ENABLE_INDONESIA_5G2,
 				       &val);
 
 		if (!ret && val == DSM_VALUE_INDONESIA_ENABLE)
@@ -454,7 +454,7 @@ __le32 iwl_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
 		break;
 	}
 
-	ret = iwl_acpi_get_dsm(fwrt, DSM_FUNC_DISABLE_SRD, &val);
+	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_DISABLE_SRD, &val);
 	if (!ret) {
 		if (val == DSM_VALUE_SRD_PASSIVE)
 			config_bitmap |=
@@ -466,7 +466,7 @@ __le32 iwl_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
 
 	if (fw_has_capa(&fwrt->fw->ucode_capa,
 			IWL_UCODE_TLV_CAPA_CHINA_22_REG_SUPPORT)) {
-		ret = iwl_acpi_get_dsm(fwrt, DSM_FUNC_REGULATORY_CONFIG,
+		ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_REGULATORY_CONFIG,
 				       &val);
 		/*
 		 * China 2022 enable if the BIOS object does not exist or
@@ -480,3 +480,10 @@ __le32 iwl_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
 	return config_bitmap;
 }
 IWL_EXPORT_SYMBOL(iwl_get_lari_config_bitmap);
+
+int iwl_bios_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
+		     u32 *value)
+{
+	GET_BIOS_TABLE(dsm, fwrt, func, value);
+}
+IWL_EXPORT_SYMBOL(iwl_bios_get_dsm);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index da49ed7325d6..52389f82cbb9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -186,4 +186,7 @@ int iwl_bios_get_mcc(struct iwl_fw_runtime *fwrt, char *mcc);
 int iwl_bios_get_eckv(struct iwl_fw_runtime *fwrt, u32 *ext_clk);
 
 __le32 iwl_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt);
+
+int iwl_bios_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
+		     u32 *value);
 #endif /* __fw_regulatory_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 4454fae84d1f..fe6d0141cd5b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -674,3 +674,36 @@ int iwl_uefi_get_eckv(struct iwl_fw_runtime *fwrt, u32 *extl_clk)
 	kfree(data);
 	return ret;
 }
+
+int iwl_uefi_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
+		     u32 *value)
+{
+	struct uefi_cnv_var_general_cfg *data;
+	int ret = EINVAL;
+
+	/* Not supported function index */
+	if (func >= DSM_FUNC_NUM_FUNCS || func == 5)
+		return -EOPNOTSUPP;
+
+	data = iwl_uefi_get_verified_variable(fwrt->trans, IWL_UEFI_DSM_NAME,
+					      "DSM", sizeof(*data), NULL);
+	if (IS_ERR(data))
+		return -EINVAL;
+
+	if (data->revision != IWL_UEFI_DSM_REVISION) {
+		IWL_DEBUG_RADIO(fwrt, "Unsupported UEFI DSM revision:%d\n",
+				data->revision);
+		goto out;
+	}
+
+	if (ARRAY_SIZE(data->functions) != UEFI_MAX_DSM_FUNCS) {
+		IWL_DEBUG_RADIO(fwrt, "Invalid size of DSM functions array\n");
+		goto out;
+	}
+
+	*value = data->functions[func];
+	ret = 0;
+out:
+	kfree(data);
+	return ret;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 723933b0b2f1..1f7c3f4c2901 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -20,6 +20,7 @@
 #define IWL_UEFI_SPLC_NAME		L"UefiCnvWlanSPLC"
 #define IWL_UEFI_WRDD_NAME		L"UefiCnvWlanWRDD"
 #define IWL_UEFI_ECKV_NAME		L"UefiCnvWlanECKV"
+#define IWL_UEFI_DSM_NAME		L"UefiCnvWlanGeneralCfg"
 
 
 #define IWL_SGOM_MAP_SIZE		339
@@ -34,6 +35,7 @@
 #define IWL_UEFI_SPLC_REVISION		0
 #define IWL_UEFI_WRDD_REVISION		0
 #define IWL_UEFI_ECKV_REVISION		0
+#define IWL_UEFI_DSM_REVISION		4
 
 struct pnvm_sku_package {
 	u8 rev;
@@ -166,6 +168,17 @@ struct uefi_cnv_var_eckv {
 	u32 ext_clock_valid;
 } __packed;
 
+#define UEFI_MAX_DSM_FUNCS 32
+
+/* struct uefi_cnv_var_general_cfg - DSM-like table as defined in UEFI
+ * @revision: the revision of the table
+ * @functions: payload of the different DSM functions
+ */
+struct uefi_cnv_var_general_cfg {
+	u8 revision;
+	u32 functions[UEFI_MAX_DSM_FUNCS];
+} __packed;
+
 /*
  * This is known to be broken on v4.19 and to work on v5.4.  Until we
  * figure out why this is the case and how to make it work, simply
@@ -190,6 +203,8 @@ int iwl_uefi_get_pwr_limit(struct iwl_fw_runtime *fwrt,
 			   u64 *dflt_pwr_limit);
 int iwl_uefi_get_mcc(struct iwl_fw_runtime *fwrt, char *mcc);
 int iwl_uefi_get_eckv(struct iwl_fw_runtime *fwrt, u32 *extl_clk);
+int iwl_uefi_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
+		     u32 *value);
 #else /* CONFIG_EFI */
 static inline void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
 {
@@ -263,6 +278,12 @@ static inline int iwl_uefi_get_eckv(struct iwl_fw_runtime *fwrt, u32 *extl_clk)
 {
 	return -ENOENT;
 }
+
+static inline int iwl_uefi_get_dsm(struct iwl_fw_runtime *fwrt,
+				   enum iwl_dsm_funcs func, u32 *value)
+{
+	return -ENOENT;
+}
 #endif /* CONFIG_EFI */
 
 #if defined(CONFIG_EFI) && defined(CONFIG_ACPI)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 6f33f791648e..1ba3a559c1d6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -391,7 +391,7 @@ static ssize_t iwl_dbgfs_wifi_6e_enable_read(struct file *file,
 	char buf[12];
 	u32 value;
 
-	err = iwl_acpi_get_dsm(&mvm->fwrt, DSM_FUNC_ENABLE_6E, &value);
+	err = iwl_bios_get_dsm(&mvm->fwrt, DSM_FUNC_ENABLE_6E, &value);
 	if (err)
 		return err;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index a05a5f403ae5..738e90a4fe2f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1206,7 +1206,7 @@ static bool iwl_mvm_eval_dsm_rfi(struct iwl_mvm *mvm)
 	u32 value = 0;
 	/* default behaviour is disabled */
 	bool bios_enable_rfi = false;
-	int ret = iwl_acpi_get_dsm(&mvm->fwrt, DSM_FUNC_RFI_CONFIG, &value);
+	int ret = iwl_bios_get_dsm(&mvm->fwrt, DSM_FUNC_RFI_CONFIG, &value);
 
 
 	if (ret < 0) {
@@ -1244,31 +1244,31 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 
 	cmd.config_bitmap = iwl_get_lari_config_bitmap(&mvm->fwrt);
 
-	ret = iwl_acpi_get_dsm(&mvm->fwrt, DSM_FUNC_11AX_ENABLEMENT, &value);
+	ret = iwl_bios_get_dsm(&mvm->fwrt, DSM_FUNC_11AX_ENABLEMENT, &value);
 	if (!ret)
 		cmd.oem_11ax_allow_bitmap = cpu_to_le32(value);
 
-	ret = iwl_acpi_get_dsm(&mvm->fwrt, DSM_FUNC_ENABLE_UNII4_CHAN, &value);
+	ret = iwl_bios_get_dsm(&mvm->fwrt, DSM_FUNC_ENABLE_UNII4_CHAN, &value);
 	if (!ret)
 		cmd.oem_unii4_allow_bitmap = cpu_to_le32(value);
 
-	ret = iwl_acpi_get_dsm(&mvm->fwrt, DSM_FUNC_ACTIVATE_CHANNEL, &value);
+	ret = iwl_bios_get_dsm(&mvm->fwrt, DSM_FUNC_ACTIVATE_CHANNEL, &value);
 	if (!ret) {
 		if (cmd_ver < 8)
 			value &= ~ACTIVATE_5G2_IN_WW_MASK;
 		cmd.chan_state_active_bitmap = cpu_to_le32(value);
 	}
 
-	ret = iwl_acpi_get_dsm(&mvm->fwrt, DSM_FUNC_ENABLE_6E, &value);
+	ret = iwl_bios_get_dsm(&mvm->fwrt, DSM_FUNC_ENABLE_6E, &value);
 	if (!ret)
 		cmd.oem_uhb_allow_bitmap = cpu_to_le32(value);
 
-	ret = iwl_acpi_get_dsm(&mvm->fwrt, DSM_FUNC_FORCE_DISABLE_CHANNELS,
+	ret = iwl_bios_get_dsm(&mvm->fwrt, DSM_FUNC_FORCE_DISABLE_CHANNELS,
 			       &value);
 	if (!ret)
 		cmd.force_disable_channels_bitmap = cpu_to_le32(value);
 
-	ret = iwl_acpi_get_dsm(&mvm->fwrt, DSM_FUNC_ENERGY_DETECTION_THRESHOLD,
+	ret = iwl_bios_get_dsm(&mvm->fwrt, DSM_FUNC_ENERGY_DETECTION_THRESHOLD,
 			       &value);
 	if (!ret)
 		cmd.edt_bitmap = cpu_to_le32(value);
-- 
2.34.1


