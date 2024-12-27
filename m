Return-Path: <linux-wireless+bounces-16829-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 956969FD1B8
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 09:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 455BE3A05FE
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 08:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDD514B95A;
	Fri, 27 Dec 2024 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FyO2xBoz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FE37083A
	for <linux-wireless@vger.kernel.org>; Fri, 27 Dec 2024 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286498; cv=none; b=qsPN0cXz92GtanIzsoTah4AhfodduZBMULwAYxgXzg9FIWl4J0HLmmKlr+qGLZW3M9NkY0AMK2Urfzr58HsFOrKF6F7WoQqfI00f4TOr57jV4fhPwZDF6qLnRLVngDpjmg3oyUnk0m/alyn93XSyvVjLG36VO6/sX5wbhhoCO3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286498; c=relaxed/simple;
	bh=gXhghrPHpzls464pMfH9gV9xkH88ZNue8tFYormTK/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HlP964cDM2AYp3wvrzDeT7rNvag/GSz4+HZQQkbHMhpyzC4Cb915PjAYrz5VnFJNzusIDtMU3D6mNl978kAx4sHYwh/83Sbtk1iErO4WVlpN35MiKPFZGqfkjacA6OrvcnSvwQZMkq8yQAWVQOtHG0e5OQdzx5dOX6rEN6jVNQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FyO2xBoz; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735286496; x=1766822496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gXhghrPHpzls464pMfH9gV9xkH88ZNue8tFYormTK/I=;
  b=FyO2xBozMXfqGTATcwmi/zxLrIRnWiQXfs7T2DFFmsfMYFE/CyMshqw/
   Ta5W1iw+3ux3duegjCGjnDGAC7bGOnGVIKqi3pRZqdJW630rXQphXRzHX
   2eJOAg1euZ9ryRdWEy6PR+7XWpu99Tg0wkFM8/byDnl3/UYdx4C9/KuAU
   0U3Lzo0gvPMKyIF0FsSDnr9ZC0uTtgGP4S92cjDMCtendTukEinCfgE5h
   8tlXSRO7QqV/G3wfeWfximml3vlQSrd4bSHCgmtg49qUDYmIuelj5oTy7
   u6Jj32h0lYAOLznqnDRVdls36QMXvEfM5SoHRDLz3rcb13KQkq7cYqbuA
   g==;
X-CSE-ConnectionGUID: uIDjvaaHSxSuQIzb2aTCFA==
X-CSE-MsgGUID: PqOTQafmQHO0HTzwAa2QCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="46690941"
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="46690941"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:36 -0800
X-CSE-ConnectionGUID: +a9IyBeOSzSd1i99EmpIkg==
X-CSE-MsgGUID: jzkwgTWoRjW7jdn+sfRXgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="99858287"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:34 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	"Somashekhar(Som)" <somashekhar.puttagangaiah@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH 07/17] wifi: iwlwifi: interpret STEP URM BIOS configuration
Date: Fri, 27 Dec 2024 10:01:02 +0200
Message-Id: <20241227095718.b30024905de3.If3c578af2c15f8005bbe71499bc4091348ed7bb0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241227080112.1098419-1-miriam.rachel.korenblit@intel.com>
References: <20241227080112.1098419-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: "Somashekhar(Som)" <somashekhar.puttagangaiah@intel.com>

For certain platforms, it may necessary to use the STEP in URM
(ultra reliable mode.) Read the necessary flags from the BIOS
(ACPI or UEFI) and indicate the chosen mode to the firmware in
the context info. Whether or not URM really was configured is
already read back later, to adjust capabilities accordingly.

Signed-off-by: Somashekhar(Som) <somashekhar.puttagangaiah@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 34 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  | 16 +++++++++
 .../wireless/intel/iwlwifi/fw/regulatory.c    |  1 +
 .../wireless/intel/iwlwifi/fw/regulatory.h    | 23 +++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 26 ++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  | 23 +++++++++++++
 .../intel/iwlwifi/iwl-context-info-gen3.h     | 15 ++++++--
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  5 +++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  1 +
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |  8 +++++
 10 files changed, 150 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 7d6e6c80b892..d3ab40fc8ab0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -1023,3 +1023,37 @@ int iwl_acpi_get_wbem(struct iwl_fw_runtime *fwrt, u32 *value)
 	kfree(data);
 	return ret;
 }
+
+int iwl_acpi_get_dsbr(struct iwl_fw_runtime *fwrt, u32 *value)
+{
+	union acpi_object *wifi_pkg, *data;
+	int ret = -ENOENT;
+	int tbl_rev;
+
+	data = iwl_acpi_get_object(fwrt->dev, ACPI_DSBR_METHOD);
+	if (IS_ERR(data))
+		return ret;
+
+	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
+					 ACPI_DSBR_WIFI_DATA_SIZE,
+					 &tbl_rev);
+	if (IS_ERR(wifi_pkg))
+		goto out_free;
+
+	if (tbl_rev != ACPI_DSBR_WIFI_DATA_REV) {
+		IWL_DEBUG_RADIO(fwrt, "Unsupported ACPI DSBR revision:%d\n",
+				tbl_rev);
+		goto out_free;
+	}
+
+	if (wifi_pkg->package.elements[1].type != ACPI_TYPE_INTEGER)
+		goto out_free;
+
+	*value = wifi_pkg->package.elements[1].integer.value;
+	IWL_DEBUG_RADIO(fwrt, "Loaded DSBR config from ACPI value: 0x%x\n",
+			*value);
+	ret = 0;
+out_free:
+	kfree(data);
+	return ret;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index bb88398a6987..e153c44d5c1d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -28,6 +28,7 @@
 #define ACPI_WPFC_METHOD	"WPFC"
 #define ACPI_GLAI_METHOD	"GLAI"
 #define ACPI_WBEM_METHOD	"WBEM"
+#define ACPI_DSBR_METHOD	"DSBR"
 
 #define ACPI_WIFI_DOMAIN	(0x07)
 
@@ -74,6 +75,13 @@
  * and one for enablement of Wi-Fi 320MHz per MCC
  */
 #define ACPI_WBEM_WIFI_DATA_SIZE	2
+/*
+ * One element for domain type,
+ * and one for DSBR response data
+ */
+#define ACPI_DSBR_WIFI_DATA_SIZE	2
+#define ACPI_DSBR_WIFI_DATA_REV		1
+
 /*
  * One element for domain type,
  * and one for the status
@@ -153,6 +161,9 @@ int iwl_acpi_get_dsm(struct iwl_fw_runtime *fwrt,
 		     enum iwl_dsm_funcs func, u32 *value);
 
 int iwl_acpi_get_wbem(struct iwl_fw_runtime *fwrt, u32 *value);
+
+int iwl_acpi_get_dsbr(struct iwl_fw_runtime *fwrt, u32 *value);
+
 #else /* CONFIG_ACPI */
 
 static inline void *iwl_acpi_get_dsm_object(struct device *dev, int rev,
@@ -221,6 +232,11 @@ static inline int iwl_acpi_get_wbem(struct iwl_fw_runtime *fwrt, u32 *value)
 {
 	return -ENOENT;
 }
+
+static inline int iwl_acpi_get_dsbr(struct iwl_fw_runtime *fwrt, u32 *value)
+{
+	return -ENOENT;
+}
 #endif /* CONFIG_ACPI */
 
 #endif /* __iwl_fw_acpi__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index c89ff380b86d..bc359a336fd6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -39,6 +39,7 @@ IWL_BIOS_TABLE_LOADER_DATA(pwr_limit, u64);
 IWL_BIOS_TABLE_LOADER_DATA(mcc, char);
 IWL_BIOS_TABLE_LOADER_DATA(eckv, u32);
 IWL_BIOS_TABLE_LOADER_DATA(wbem, u32);
+IWL_BIOS_TABLE_LOADER_DATA(dsbr, u32);
 
 
 static const struct dmi_system_id dmi_ppag_approved_list[] = {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index f247d31ebdd6..afdc0ec75ba5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -222,4 +222,27 @@ static inline u32 iwl_bios_get_ppag_flags(const u32 ppag_modes,
 }
 
 bool iwl_puncturing_is_allowed_in_bios(u32 puncturing, u16 mcc);
+
+#define IWL_DSBR_FW_MODIFIED_URM_MASK	BIT(8)
+#define IWL_DSBR_PERMANENT_URM_MASK	BIT(9)
+
+int iwl_bios_get_dsbr(struct iwl_fw_runtime *fwrt, u32 *value);
+
+static inline void iwl_bios_setup_step(struct iwl_trans *trans,
+				       struct iwl_fw_runtime *fwrt)
+{
+	u32 dsbr;
+
+	if (!trans->trans_cfg->integrated)
+		return;
+
+	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_BZ)
+		return;
+
+	if (iwl_bios_get_dsbr(fwrt, &dsbr))
+		dsbr = 0;
+
+	trans->dsbr_urm_fw_dependent = !!(dsbr & IWL_DSBR_FW_MODIFIED_URM_MASK);
+	trans->dsbr_urm_permanent = !!(dsbr & IWL_DSBR_PERMANENT_URM_MASK);
+}
 #endif /* __fw_regulatory_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 02df96c3aa51..cc7659d59cf0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -777,3 +777,29 @@ int iwl_uefi_get_puncturing(struct iwl_fw_runtime *fwrt)
 	return puncturing;
 }
 IWL_EXPORT_SYMBOL(iwl_uefi_get_puncturing);
+
+int iwl_uefi_get_dsbr(struct iwl_fw_runtime *fwrt, u32 *value)
+{
+	struct uefi_cnv_wlan_dsbr_data *data;
+	int ret = 0;
+
+	data = iwl_uefi_get_verified_variable_guid(fwrt->trans,
+						   &IWL_EFI_WIFI_BT_GUID,
+						   IWL_UEFI_DSBR_NAME, "DSBR",
+						   sizeof(*data), NULL);
+	if (IS_ERR(data))
+		return -EINVAL;
+
+	if (data->revision != IWL_UEFI_DSBR_REVISION) {
+		ret = -EINVAL;
+		IWL_DEBUG_RADIO(fwrt, "Unsupported UEFI DSBR revision:%d\n",
+				data->revision);
+		goto out;
+	}
+	*value = data->config;
+	IWL_DEBUG_RADIO(fwrt, "Loaded DSBR config from UEFI value: 0x%x\n",
+			*value);
+out:
+	kfree(data);
+	return ret;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 4e98f752b3d2..0c8943a8bd01 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -23,6 +23,7 @@
 #define IWL_UEFI_DSM_NAME		L"UefiCnvWlanGeneralCfg"
 #define IWL_UEFI_WBEM_NAME		L"UefiCnvWlanWBEM"
 #define IWL_UEFI_PUNCTURING_NAME	L"UefiCnvWlanPuncturing"
+#define IWL_UEFI_DSBR_NAME		L"UefiCnvCommonDSBR"
 
 
 #define IWL_SGOM_MAP_SIZE		339
@@ -41,6 +42,7 @@
 #define IWL_UEFI_WBEM_REVISION		0
 #define IWL_UEFI_DSM_REVISION		4
 #define IWL_UEFI_PUNCTURING_REVISION	0
+#define IWL_UEFI_DSBR_REVISION		1
 
 struct pnvm_sku_package {
 	u8 rev;
@@ -214,6 +216,20 @@ struct uefi_cnv_var_puncturing_data {
 	u32 puncturing;
 } __packed;
 
+/**
+ * struct uefi_cnv_wlan_dsbr_data - BIOS STEP configuration information
+ * @revision: the revision of the table
+ * @config: STEP configuration flags:
+ *	bit 8, switch to URM depending on FW setting
+ *	bit 9, switch to URM
+ *
+ * Platform information for STEP configuration/workarounds.
+ */
+struct uefi_cnv_wlan_dsbr_data {
+	u8 revision;
+	u32 config;
+} __packed;
+
 /*
  * This is known to be broken on v4.19 and to work on v5.4.  Until we
  * figure out why this is the case and how to make it work, simply
@@ -245,6 +261,7 @@ void iwl_uefi_get_sgom_table(struct iwl_trans *trans, struct iwl_fw_runtime *fwr
 int iwl_uefi_get_uats_table(struct iwl_trans *trans,
 			    struct iwl_fw_runtime *fwrt);
 int iwl_uefi_get_puncturing(struct iwl_fw_runtime *fwrt);
+int iwl_uefi_get_dsbr(struct iwl_fw_runtime *fwrt, u32 *value);
 #else /* CONFIG_EFI */
 static inline void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
 {
@@ -347,5 +364,11 @@ int iwl_uefi_get_puncturing(struct iwl_fw_runtime *fwrt)
 {
 	return 0;
 }
+
+static inline
+int iwl_uefi_get_dsbr(struct iwl_fw_runtime *fwrt, u32 *value)
+{
+	return -ENOENT;
+}
 #endif /* CONFIG_EFI */
 #endif /* __iwl_fw_uefi__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
index 5b62933134cf..6b246ec3ff03 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
@@ -76,6 +76,16 @@ enum iwl_prph_scratch_flags {
 	IWL_PRPH_SCRATCH_SCU_FORCE_ACTIVE	= BIT(29),
 };
 
+/**
+ * enum iwl_prph_scratch_ext_flags - PRPH scratch control ext flags
+ * @IWL_PRPH_SCRATCH_EXT_URM_FW: switch to URM mode based on fw setting
+ * @IWL_PRPH_SCRATCH_EXT_URM_PERM: switch to permanent URM mode
+ */
+enum iwl_prph_scratch_ext_flags {
+	IWL_PRPH_SCRATCH_EXT_URM_FW	= BIT(4),
+	IWL_PRPH_SCRATCH_EXT_URM_PERM	= BIT(5),
+};
+
 /*
  * struct iwl_prph_scratch_version - version structure
  * @mac_id: SKU and revision id
@@ -93,11 +103,12 @@ struct iwl_prph_scratch_version {
 /*
  * struct iwl_prph_scratch_control - control structure
  * @control_flags: context information flags see &enum iwl_prph_scratch_flags
- * @reserved: reserved
+ * @control_flags_ext: context information for extended flags,
+ *	see &enum iwl_prph_scratch_ext_flags
  */
 struct iwl_prph_scratch_control {
 	__le32 control_flags;
-	__le32 reserved;
+	__le32 control_flags_ext;
 } __packed; /* PERIPH_SCRATCH_CONTROL_S */
 
 /*
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 56b551fd2156..22c0864b5704 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -878,6 +878,8 @@ struct iwl_txq {
  * @no_160: device not supporting 160 MHz
  * @step_urm: STEP is in URM, no support for MCS>9 in 320 MHz
  * @trans_specific: data for the specific transport this is allocated for/with
+ * @dsbr_urm_fw_dependent: switch to URM based on fw settings
+ * @dsbr_urm_permanent: switch to URM permanently
  */
 struct iwl_trans {
 	bool csme_own;
@@ -902,6 +904,9 @@ struct iwl_trans {
 	bool reduced_cap_sku;
 	u8 no_160:1, step_urm:1;
 
+	u8 dsbr_urm_fw_dependent:1,
+	   dsbr_urm_permanent:1;
+
 	u8 rx_mpdu_cmd, rx_mpdu_cmd_hdr_size;
 
 	bool pm_support;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index e21199313278..06b05e076cd2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1331,6 +1331,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	iwl_mvm_get_bios_tables(mvm);
 	iwl_uefi_get_sgom_table(trans, &mvm->fwrt);
 	iwl_uefi_get_step_table(trans);
+	iwl_bios_setup_step(trans, &mvm->fwrt);
 
 	mvm->init_status = 0;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index ae93a72542b2..838c426db7f0 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -106,6 +106,7 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 	struct iwl_prph_scratch_ctrl_cfg *prph_sc_ctrl;
 	struct iwl_prph_info *prph_info;
 	u32 control_flags = 0;
+	u32 control_flags_ext = 0;
 	int ret;
 	int cmdq_size = max_t(u32, IWL_CMD_QUEUE_SIZE,
 			      trans->cfg->min_txq_size);
@@ -130,6 +131,12 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 		break;
 	}
 
+	if (trans->dsbr_urm_fw_dependent)
+		control_flags_ext |= IWL_PRPH_SCRATCH_EXT_URM_FW;
+
+	if (trans->dsbr_urm_permanent)
+		control_flags_ext |= IWL_PRPH_SCRATCH_EXT_URM_PERM;
+
 	/* Allocate prph scratch */
 	prph_scratch = dma_alloc_coherent(trans->dev, sizeof(*prph_scratch),
 					  &trans_pcie->prph_scratch_dma_addr,
@@ -165,6 +172,7 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 	iwl_pcie_ctxt_info_dbg_enable(trans, &prph_sc_ctrl->hwm_cfg,
 				      &control_flags);
 	prph_sc_ctrl->control.control_flags = cpu_to_le32(control_flags);
+	prph_sc_ctrl->control.control_flags_ext = cpu_to_le32(control_flags_ext);
 
 	/* initialize the Step equalizer data */
 	prph_sc_ctrl->step_cfg.mbx_addr_0 = cpu_to_le32(trans->mbx_addr_0_step);
-- 
2.34.1


