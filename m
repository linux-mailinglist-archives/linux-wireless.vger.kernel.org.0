Return-Path: <linux-wireless+bounces-2873-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7358438EB
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 09:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D3D1C2702A
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 08:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D237567745;
	Wed, 31 Jan 2024 08:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VW4QZjgF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4D1664A3
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 08:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689515; cv=none; b=MjAE+WZFa8M+J+v2OA8RLYtytTwwmT6uC0lMJc6XrseaT04AB521zk7TwPWOmrtvb9nPq0EKryAULdetkEw8ZH0abl09YWhyrvj2r6JOcziM9mlF4r26MvqzZ0ecBZPGjaegBmtdA+02KGgBVqIWv2c20LXrA8tgk1YbPRTh7ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689515; c=relaxed/simple;
	bh=K0b9nNCbTQKmpzxP5DFFShE7kT2sK4N48wI+XAfn8go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s0a47auwMphlr23+SZkjNljZAxkI7msAiqvmFoZMc4yyfnOnu8jwGOjhyRU0HkbE3cNSGhFpqyllB/EKmYY3fZf0aotRZg+P5ouLAJReDtyLACVVGdG7/WL+xExvgQ520DOyXBfhs8LNSUTzP1RdCxphobpDvmmBzV+ST42vMH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VW4QZjgF; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706689513; x=1738225513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K0b9nNCbTQKmpzxP5DFFShE7kT2sK4N48wI+XAfn8go=;
  b=VW4QZjgF3VWC0g5+FnK6+PrDMbxhi/YyH7Du7ni/U1A8PKA2T9mEKlIL
   7uQvP7jBaY1A8lgxAOn1gFgDkLswzS8UcMQRzP0LeHgsOR/o8stzylTTc
   a8dN0L/Iw+LtjJhda0E3dsWXJQOzYji2XW9LlQXu2AIAIsHqDiYpJazyv
   0oW0YBUBrObKEdBqphMKLKrbObo4bRpLwyXxlHq2fP2+7dsLUytziwh2V
   IpUp0w8U12IBXFcQK7lqIoCfjg1XPN5BKmoZggqfhldcVh3pzs+UhJHME
   p4A8g4IVXtRmuVdiQraI5bo82axOQzkc4+IZod+ae1/w5I9p5evnPa9Gp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="407249926"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="407249926"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:25:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3968895"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:25:11 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/14] wifi: iwlwifi: read SAR tables from UEFI
Date: Wed, 31 Jan 2024 10:24:39 +0200
Message-Id: <20240131091413.533b687e1efb.Icb316291e593c8d53f41fdea2d083367dc97e3c4@changeid>
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

All the regulatory tables will be read from UEFI, and
only if it doesn't exist - they will be read from ACPI.
Read SAR tables (WRDS, EWRD and WGDS) from UEFI.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |   5 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |   3 +
 .../wireless/intel/iwlwifi/fw/regulatory.c    |  17 +++
 .../wireless/intel/iwlwifi/fw/regulatory.h    |   6 +
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 108 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  |  77 ++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  97 +++++++---------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   2 +-
 10 files changed, 255 insertions(+), 66 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 401aca31704c..4e638287e9a4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -622,7 +622,6 @@ int iwl_acpi_get_wrds_table(struct iwl_fw_runtime *fwrt)
 	kfree(data);
 	return ret;
 }
-IWL_EXPORT_SYMBOL(iwl_acpi_get_wrds_table);
 
 int iwl_acpi_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 {
@@ -731,7 +730,6 @@ int iwl_acpi_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 	kfree(data);
 	return ret;
 }
-IWL_EXPORT_SYMBOL(iwl_acpi_get_ewrd_table);
 
 int iwl_acpi_get_wgds_table(struct iwl_fw_runtime *fwrt)
 {
@@ -748,7 +746,7 @@ int iwl_acpi_get_wgds_table(struct iwl_fw_runtime *fwrt)
 			.revisions = BIT(3),
 			.bands = ACPI_GEO_NUM_BANDS_REV2,
 			.profiles = ACPI_NUM_GEO_PROFILES_REV3,
-			.min_profiles = 3,
+			.min_profiles = BIOS_GEO_MIN_PROFILE_NUM,
 		},
 		{
 			.revisions = BIT(2),
@@ -886,7 +884,6 @@ int iwl_acpi_get_wgds_table(struct iwl_fw_runtime *fwrt)
 	kfree(data);
 	return ret;
 }
-IWL_EXPORT_SYMBOL(iwl_acpi_get_wgds_table);
 
 __le32 iwl_acpi_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index ba7626543b70..3498deec58a5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -105,6 +105,9 @@
 #define IWL_SAR_ENABLE_MSK		BIT(0)
 #define IWL_REDUCE_POWER_FLAGS_POS	1
 
+/* The Inidcator whether UEFI WIFI GUID tables are locked is read from ACPI */
+#define UEFI_WIFI_GUID_UNLOCKED		0
+
 /*
  * The profile for revision 2 is a superset of revision 1, which is in
  * turn a superset of revision 0.  So we can store all revisions
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 58290bf64f42..862d8b8b0fc9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -6,6 +6,23 @@
 #include "iwl-debug.h"
 #include "regulatory.h"
 #include "fw/runtime.h"
+#include "fw/uefi.h"
+
+#define IWL_BIOS_TABLE_LOADER(__name)					\
+int iwl_bios_get_ ## __name ## _table(struct iwl_fw_runtime *fwrt)	\
+{									\
+	int ret = -ENOENT;						\
+	if (fwrt->uefi_tables_lock_status > UEFI_WIFI_GUID_UNLOCKED)	\
+		ret = iwl_uefi_get_ ## __name ## _table(fwrt);		\
+	if (ret < 0)							\
+		ret = iwl_acpi_get_ ## __name ## _table(fwrt);		\
+	return ret;							\
+}									\
+IWL_EXPORT_SYMBOL(iwl_bios_get_ ## __name ## _table)
+
+IWL_BIOS_TABLE_LOADER(wrds);
+IWL_BIOS_TABLE_LOADER(ewrd);
+IWL_BIOS_TABLE_LOADER(wgds);
 
 bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index 650430f21510..73c6122e7626 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -87,4 +87,10 @@ int iwl_sar_fill_profile(struct iwl_fw_runtime *fwrt,
 			 __le16 *per_chain, u32 n_tables, u32 n_subbands,
 			 int prof_a, int prof_b);
 
+int iwl_bios_get_wrds_table(struct iwl_fw_runtime *fwrt);
+
+int iwl_bios_get_ewrd_table(struct iwl_fw_runtime *fwrt);
+
+int iwl_bios_get_wgds_table(struct iwl_fw_runtime *fwrt);
+
 #endif /* __fw_regulatory_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 08734f48443e..e55248b6b4c2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -164,21 +164,21 @@ struct iwl_fw_runtime {
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	bool tpc_enabled;
 #endif /* CONFIG_IWLWIFI_DEBUGFS */
-#ifdef CONFIG_ACPI
 	struct iwl_sar_profile sar_profiles[BIOS_SAR_MAX_PROFILE_NUM];
 	u8 sar_chain_a_profile;
 	u8 sar_chain_b_profile;
+	u8 reduced_power_flags;
 	struct iwl_geo_profile geo_profiles[BIOS_GEO_MAX_PROFILE_NUM];
 	u32 geo_rev;
 	u32 geo_num_profiles;
 	bool geo_enabled;
+#ifdef CONFIG_ACPI
 	struct iwl_ppag_chain ppag_chains[IWL_NUM_CHAIN_LIMITS];
 	u32 ppag_flags;
 	u32 ppag_ver;
 	bool ppag_table_valid;
 	struct iwl_sar_offset_mapping_cmd sgom_table;
 	bool sgom_enabled;
-	u8 reduced_power_flags;
 	struct iwl_uats_table_cmd uats_table;
 	u8 uefi_tables_lock_status;
 #endif
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 9c432d7b3674..a777cd4c70f7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -413,3 +413,111 @@ int iwl_uefi_get_uats_table(struct iwl_trans *trans,
 }
 IWL_EXPORT_SYMBOL(iwl_uefi_get_uats_table);
 #endif /* CONFIG_ACPI */
+
+static void iwl_uefi_set_sar_profile(struct iwl_fw_runtime *fwrt,
+				     struct uefi_sar_profile *uefi_sar_prof,
+				     u8 prof_index, bool enabled)
+{
+	memcpy(&fwrt->sar_profiles[prof_index].chains, uefi_sar_prof,
+	       sizeof(struct uefi_sar_profile));
+
+	fwrt->sar_profiles[prof_index].enabled = enabled & IWL_SAR_ENABLE_MSK;
+}
+
+int iwl_uefi_get_wrds_table(struct iwl_fw_runtime *fwrt)
+{
+	struct uefi_cnv_var_wrds *data;
+	int ret = 0;
+
+	data = iwl_uefi_get_verified_variable(fwrt->trans, IWL_UEFI_WRDS_NAME,
+					      "WRDS", sizeof(*data), NULL);
+	if (IS_ERR(data))
+		return -EINVAL;
+
+	if (data->revision != IWL_UEFI_WRDS_REVISION) {
+		ret = -EINVAL;
+		IWL_DEBUG_RADIO(fwrt, "Unsupported UEFI WRDS revision:%d\n",
+				data->revision);
+		goto out;
+	}
+
+	/* The profile from WRDS is officially profile 1, but goes
+	 * into sar_profiles[0] (because we don't have a profile 0).
+	 */
+	iwl_uefi_set_sar_profile(fwrt, &data->sar_profile, 0, data->mode);
+out:
+	kfree(data);
+	return ret;
+}
+
+int iwl_uefi_get_ewrd_table(struct iwl_fw_runtime *fwrt)
+{
+	struct uefi_cnv_var_ewrd *data;
+	int i, ret = 0;
+
+	data = iwl_uefi_get_verified_variable(fwrt->trans, IWL_UEFI_EWRD_NAME,
+					      "EWRD", sizeof(*data), NULL);
+	if (IS_ERR(data))
+		return -EINVAL;
+
+	if (data->revision != IWL_UEFI_EWRD_REVISION) {
+		ret = -EINVAL;
+		IWL_DEBUG_RADIO(fwrt, "Unsupported UEFI EWRD revision:%d\n",
+				data->revision);
+		goto out;
+	}
+
+	if (data->num_profiles >= BIOS_SAR_MAX_PROFILE_NUM) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	for (i = 0; i < data->num_profiles; i++)
+		/* The EWRD profiles officially go from 2 to 4, but we
+		 * save them in sar_profiles[1-3] (because we don't
+		 * have profile 0).  So in the array we start from 1.
+		 */
+		iwl_uefi_set_sar_profile(fwrt, &data->sar_profiles[i], i + 1,
+					 data->mode);
+
+out:
+	kfree(data);
+	return ret;
+}
+
+int iwl_uefi_get_wgds_table(struct iwl_fw_runtime *fwrt)
+{
+	struct uefi_cnv_var_wgds *data;
+	int i, ret = 0;
+
+	data = iwl_uefi_get_verified_variable(fwrt->trans, IWL_UEFI_WGDS_NAME,
+					      "WGDS", sizeof(*data), NULL);
+	if (IS_ERR(data))
+		return -EINVAL;
+
+	if (data->revision != IWL_UEFI_WGDS_REVISION) {
+		ret = -EINVAL;
+		IWL_DEBUG_RADIO(fwrt, "Unsupported UEFI WGDS revision:%d\n",
+				data->revision);
+		goto out;
+	}
+
+	if (data->num_profiles < BIOS_GEO_MIN_PROFILE_NUM ||
+	    data->num_profiles > BIOS_GEO_MAX_PROFILE_NUM) {
+		ret = -EINVAL;
+		IWL_DEBUG_RADIO(fwrt, "Invalid number of profiles in WGDS: %d\n",
+				data->num_profiles);
+		goto out;
+	}
+
+	fwrt->geo_rev = data->revision;
+	for (i = 0; i < data->num_profiles; i++)
+		memcpy(&fwrt->geo_profiles[i], &data->geo_profiles[i],
+		       sizeof(struct iwl_geo_profile));
+
+	fwrt->geo_num_profiles = data->num_profiles;
+	fwrt->geo_enabled = true;
+out:
+	kfree(data);
+	return ret;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index bf61a8df1225..3141fca047c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -5,15 +5,24 @@
 #ifndef __iwl_fw_uefi__
 #define __iwl_fw_uefi__
 
+#include "fw/regulatory.h"
+
 #define IWL_UEFI_OEM_PNVM_NAME		L"UefiCnvWlanOemSignedPnvm"
 #define IWL_UEFI_REDUCED_POWER_NAME	L"UefiCnvWlanReducedPower"
 #define IWL_UEFI_SGOM_NAME		L"UefiCnvWlanSarGeoOffsetMapping"
 #define IWL_UEFI_STEP_NAME		L"UefiCnvCommonSTEP"
 #define IWL_UEFI_UATS_NAME		L"CnvUefiWlanUATS"
+#define IWL_UEFI_WRDS_NAME		L"UefiCnvWlanWRDS"
+#define IWL_UEFI_EWRD_NAME		L"UefiCnvWlanEWRD"
+#define IWL_UEFI_WGDS_NAME		L"UefiCnvWlanWGDS"
 
 #define IWL_SGOM_MAP_SIZE		339
 #define IWL_UATS_MAP_SIZE		339
 
+#define IWL_UEFI_WRDS_REVISION		2
+#define IWL_UEFI_EWRD_REVISION		2
+#define IWL_UEFI_WGDS_REVISION		3
+
 struct pnvm_sku_package {
 	u8 rev;
 	u32 total_size;
@@ -41,6 +50,55 @@ struct uefi_cnv_common_step_data {
 	u8 radio2;
 } __packed;
 
+/*
+ * struct uefi_sar_profile - a SAR profile as defined in UEFI
+ *
+ * @chains: a per-chain table of SAR values
+ */
+struct uefi_sar_profile {
+	struct iwl_sar_profile_chain chains[BIOS_SAR_MAX_CHAINS_PER_PROFILE];
+} __packed;
+
+/*
+ * struct uefi_cnv_var_wrds - WRDS table as defined in UEFI
+ *
+ * @revision: the revision of the table
+ * @mode: is WRDS enbaled/disabled
+ * @sar_profile: sar profile #1
+ */
+struct uefi_cnv_var_wrds {
+	u8 revision;
+	u32 mode;
+	struct uefi_sar_profile sar_profile;
+} __packed;
+
+/*
+ * struct uefi_cnv_var_ewrd - EWRD table as defined in UEFI
+ * @revision: the revision of the table
+ * @mode: is WRDS enbaled/disabled
+ * @num_profiles: how many additional profiles we have in this table (0-3)
+ * @sar_profiles: the additional SAR profiles (#2-#4)
+ */
+struct uefi_cnv_var_ewrd {
+	u8 revision;
+	u32 mode;
+	u32 num_profiles;
+	struct uefi_sar_profile sar_profiles[BIOS_SAR_MAX_PROFILE_NUM - 1];
+} __packed;
+
+/*
+ * struct uefi_cnv_var_wgds - WGDS table as defined in UEFI
+ * @revision: the revision of the table
+ * @num_profiles: the number of geo profiles we have in the table.
+ *	The first 3 are mandatory, and can have up to 8.
+ * @geo_profiles: a per-profile table of the offsets to add to SAR values.
+ */
+struct uefi_cnv_var_wgds {
+	u8 revision;
+	u8 num_profiles;
+	struct iwl_geo_profile geo_profiles[BIOS_GEO_MAX_PROFILE_NUM];
+} __packed;
+
 /*
  * This is known to be broken on v4.19 and to work on v5.4.  Until we
  * figure out why this is the case and how to make it work, simply
@@ -55,6 +113,9 @@ int iwl_uefi_reduce_power_parse(struct iwl_trans *trans,
 void iwl_uefi_get_step_table(struct iwl_trans *trans);
 int iwl_uefi_handle_tlv_mem_desc(struct iwl_trans *trans, const u8 *data,
 				 u32 tlv_len, struct iwl_pnvm_image *pnvm_data);
+int iwl_uefi_get_wrds_table(struct iwl_fw_runtime *fwrt);
+int iwl_uefi_get_ewrd_table(struct iwl_fw_runtime *fwrt);
+int iwl_uefi_get_wgds_table(struct iwl_fw_runtime *fwrt);
 #else /* CONFIG_EFI */
 static inline void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
 {
@@ -85,6 +146,21 @@ iwl_uefi_handle_tlv_mem_desc(struct iwl_trans *trans, const u8 *data,
 {
 	return 0;
 }
+
+static inline int iwl_uefi_get_wrds_table(struct iwl_fw_runtime *fwrt)
+{
+	return -ENOENT;
+}
+
+static inline int iwl_uefi_get_ewrd_table(struct iwl_fw_runtime *fwrt)
+{
+	return -ENOENT;
+}
+
+static inline int iwl_uefi_get_wgds_table(struct iwl_fw_runtime *fwrt)
+{
+	return -ENOENT;
+}
 #endif /* CONFIG_EFI */
 
 #if defined(CONFIG_EFI) && defined(CONFIG_ACPI)
@@ -103,6 +179,5 @@ int iwl_uefi_get_uats_table(struct iwl_trans *trans,
 {
 	return 0;
 }
-
 #endif
 #endif /* __iwl_fw_uefi__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index f964452ba433..c2267e0bd08e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -16,6 +16,7 @@
 #include "fw/acpi.h"
 #include "fw/pnvm.h"
 #include "fw/uefi.h"
+#include "fw/regulatory.h"
 
 #include "mvm.h"
 #include "fw/dbg.h"
@@ -895,7 +896,6 @@ static int iwl_mvm_config_ltr(struct iwl_mvm *mvm)
 				    sizeof(cmd), &cmd);
 }
 
-#ifdef CONFIG_ACPI
 int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 {
 	u32 cmd_id = REDUCE_TX_POWER_CMD;
@@ -1078,6 +1078,8 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 	return iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, len, &cmd);
 }
 
+#ifdef CONFIG_ACPI
+
 int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
 {
 	union iwl_ppag_table_cmd cmd;
@@ -1385,7 +1387,39 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 		mvm->fwrt.uats_enabled = TRUE;
 }
 
-void iwl_mvm_get_acpi_tables(struct iwl_mvm *mvm)
+#else /* CONFIG_ACPI */
+
+int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
+{
+	return -ENOENT;
+}
+
+static int iwl_mvm_ppag_init(struct iwl_mvm *mvm)
+{
+	return 0;
+}
+
+static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
+{
+}
+
+static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
+{
+}
+
+bool iwl_mvm_is_vendor_in_approved_list(void)
+{
+	return false;
+}
+
+static u8 iwl_mvm_eval_dsm_rfi(struct iwl_mvm *mvm)
+{
+	return DSM_VALUE_RFI_DISABLE;
+}
+
+#endif /* CONFIG_ACPI */
+
+void iwl_mvm_get_bios_tables(struct iwl_mvm *mvm)
 {
 	int ret;
 
@@ -1400,7 +1434,7 @@ void iwl_mvm_get_acpi_tables(struct iwl_mvm *mvm)
 	}
 
 	/* read SAR tables */
-	ret = iwl_acpi_get_wrds_table(&mvm->fwrt);
+	ret = iwl_bios_get_wrds_table(&mvm->fwrt);
 	if (ret < 0) {
 		IWL_DEBUG_RADIO(mvm,
 				"WRDS SAR BIOS table invalid or unavailable. (%d)\n",
@@ -1409,7 +1443,7 @@ void iwl_mvm_get_acpi_tables(struct iwl_mvm *mvm)
 		 * If not available, don't fail and don't bother with EWRD and
 		 * WGDS */
 
-		if (!iwl_acpi_get_wgds_table(&mvm->fwrt)) {
+		if (!iwl_bios_get_wgds_table(&mvm->fwrt)) {
 			/*
 			 * If basic SAR is not available, we check for WGDS,
 			 * which should *not* be available either.  If it is
@@ -1420,7 +1454,7 @@ void iwl_mvm_get_acpi_tables(struct iwl_mvm *mvm)
 		}
 
 	} else {
-		ret = iwl_acpi_get_ewrd_table(&mvm->fwrt);
+		ret = iwl_bios_get_ewrd_table(&mvm->fwrt);
 		/* if EWRD is not available, we can still use
 		* WRDS, so don't fail */
 		if (ret < 0)
@@ -1430,7 +1464,7 @@ void iwl_mvm_get_acpi_tables(struct iwl_mvm *mvm)
 
 		/* read geo SAR table */
 		if (iwl_sar_geo_support(&mvm->fwrt)) {
-			ret = iwl_acpi_get_wgds_table(&mvm->fwrt);
+			ret = iwl_bios_get_wgds_table(&mvm->fwrt);
 			if (ret < 0)
 				IWL_DEBUG_RADIO(mvm,
 						"Geo SAR BIOS table invalid or unavailable. (%d)\n",
@@ -1441,57 +1475,6 @@ void iwl_mvm_get_acpi_tables(struct iwl_mvm *mvm)
 
 	iwl_acpi_get_phy_filters(&mvm->fwrt, &mvm->phy_filters);
 }
-#else /* CONFIG_ACPI */
-
-inline int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm,
-				      int prof_a, int prof_b)
-{
-	return 1;
-}
-
-inline int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
-{
-	return -ENOENT;
-}
-
-static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
-{
-	return 0;
-}
-
-int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
-{
-	return -ENOENT;
-}
-
-static int iwl_mvm_ppag_init(struct iwl_mvm *mvm)
-{
-	return 0;
-}
-
-static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
-{
-}
-
-static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
-{
-}
-
-bool iwl_mvm_is_vendor_in_approved_list(void)
-{
-	return false;
-}
-
-static u8 iwl_mvm_eval_dsm_rfi(struct iwl_mvm *mvm)
-{
-	return DSM_VALUE_RFI_DISABLE;
-}
-
-void iwl_mvm_get_acpi_tables(struct iwl_mvm *mvm)
-{
-}
-
-#endif /* CONFIG_ACPI */
 
 static void iwl_mvm_disconnect_iterator(void *data, u8 *mac,
 					struct ieee80211_vif *vif)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index d414007c4755..14f4cf8a67c7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2381,7 +2381,7 @@ u64 iwl_mvm_ptp_get_adj_time(struct iwl_mvm *mvm, u64 base_time);
 int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b);
 int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm);
 int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm);
-void iwl_mvm_get_acpi_tables(struct iwl_mvm *mvm);
+void iwl_mvm_get_bios_tables(struct iwl_mvm *mvm);
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 void iwl_mvm_link_sta_add_debugfs(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 20054a0c7892..1b41318e1e55 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1201,7 +1201,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	iwl_fw_runtime_init(&mvm->fwrt, trans, fw, &iwl_mvm_fwrt_ops, mvm,
 			    &iwl_mvm_sanitize_ops, mvm, dbgfs_dir);
 
-	iwl_mvm_get_acpi_tables(mvm);
+	iwl_mvm_get_bios_tables(mvm);
 	iwl_uefi_get_sgom_table(trans, &mvm->fwrt);
 	iwl_uefi_get_step_table(trans);
 
-- 
2.34.1


