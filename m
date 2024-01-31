Return-Path: <linux-wireless+bounces-2881-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C2D8438F7
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 09:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6761D1C27703
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 08:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7614F5C5E3;
	Wed, 31 Jan 2024 08:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ah7eVRoh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7B559140
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689541; cv=none; b=Q5KpSSkfNRld8fA7nOr3XNt87zyz2MX6gbuoUY536COdg/XnZ0KmePlR0uVtPpGUfviVeBiOpjzbDBAw6Z1npbmuJJpkEWEAsTQxjAWhprPeuwKQR4XpeMZEauoxtF8biqoCJ22t93MBSbqG1TMaz08YQwPIcUDFVm5rhSF5mfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689541; c=relaxed/simple;
	bh=Ndz2nx2aoEpALW/ezVjnbo0l494+hjTLjsSU16OBWdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QUg34gpKka6WH56aB21HQ+G3yovoUlNwIpv9efR69QO4hOFWKoSNEYRdfaZsO5+owxkITdIJQxfxAXGMqDlXVsW10UKCAfVpwJyfGzFqX1m7l/DB4qmJ/WJw0o5eToEjKqFpOfQB3TJ+l8YW2fMXY3Lcgsk3VTinu7JP/ht1bnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ah7eVRoh; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706689538; x=1738225538;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ndz2nx2aoEpALW/ezVjnbo0l494+hjTLjsSU16OBWdY=;
  b=ah7eVRohlC3XWVxIMwg9r5+B2w4GSqVFHyGKadHAReQPQalTWLrj8zd/
   /bx68iX66boQZ0BbfmNmld5A5VKMJakHd1rbNNRQSNGNJb4dzKE4Dqs4O
   bkdi2cBUc/4LZG+oCvKG3IgDwGJUbeZQbGJOHXCwuz+qWmkWGsCjOapOk
   PryMz8QD/Ogejgt4E/HC5TiqM7dVlyhWZaWUYmT4AUc4vOsaKzIwh5gGR
   CLtThLdWthKj804OnCmNfUYYdU1qAvn1MxMCYtuVUDyh6OGWuCopytzej
   bcNtTpiEj8lexPzTt8PAIPXQn0FqYFZ4z8Fddl1wo/MnDe64iH/WGWdlq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="407249975"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="407249975"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:25:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3968978"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:25:30 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/14] wifi: iwlwifi: read WTAS table from UEFI
Date: Wed, 31 Jan 2024 10:24:47 +0200
Message-Id: <20240131091413.45e6ff7b5063.Id3aec70887e14533b10d564f32c0cf5f2a14b792@changeid>
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

Try to read the WTAS table from UEFI first,
and if the WIFI UEFI tables are unlocked or the
table doesn't exist - try to read it from ACPI.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  6 +--
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  8 ++--
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 32 ++++++++-----
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  4 ++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 48 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  | 23 +++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 12 ++---
 7 files changed, 105 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 0abb954f3056..170c840c321a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -249,9 +249,8 @@ iwl_acpi_get_wifi_pkg(struct device *dev,
 					   tbl_rev);
 }
 
-
-int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
-		     struct iwl_tas_data *tas_data)
+int iwl_acpi_get_tas_table(struct iwl_fw_runtime *fwrt,
+			   struct iwl_tas_data *tas_data)
 {
 	union acpi_object *wifi_pkg, *data;
 	int ret, tbl_rev, i, block_list_size, enabled;
@@ -326,7 +325,6 @@ int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
 	kfree(data);
 	return ret;
 }
-IWL_EXPORT_SYMBOL(iwl_acpi_get_tas);
 
 int iwl_acpi_get_mcc(struct device *dev, char *mcc)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 0ce9a33bbb77..61bfdaa467d4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -175,8 +175,8 @@ int iwl_acpi_get_ewrd_table(struct iwl_fw_runtime *fwrt);
 
 int iwl_acpi_get_wgds_table(struct iwl_fw_runtime *fwrt);
 
-int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
-		     struct iwl_tas_data *data);
+int iwl_acpi_get_tas_table(struct iwl_fw_runtime *fwrt,
+			   struct iwl_tas_data *data);
 
 __le32 iwl_acpi_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt);
 
@@ -237,8 +237,8 @@ static inline int iwl_acpi_get_wgds_table(struct iwl_fw_runtime *fwrt)
 	return 1;
 }
 
-static inline int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
-				   struct iwl_tas_data *data)
+static inline int iwl_acpi_get_tas_table(struct iwl_fw_runtime *fwrt,
+					 struct iwl_tas_data *data)
 {
 	return -ENOENT;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 20154b0fb7e6..4cf22e280dfc 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -9,22 +9,32 @@
 #include "fw/runtime.h"
 #include "fw/uefi.h"
 
-#define IWL_BIOS_TABLE_LOADER(__name)					\
-int iwl_bios_get_ ## __name ## _table(struct iwl_fw_runtime *fwrt)	\
-{									\
+#define GET_BIOS_TABLE(__name, ...)					\
+do {									\
 	int ret = -ENOENT;						\
 	if (fwrt->uefi_tables_lock_status > UEFI_WIFI_GUID_UNLOCKED)	\
-		ret = iwl_uefi_get_ ## __name ## _table(fwrt);		\
+		ret = iwl_uefi_get_ ## __name(__VA_ARGS__);		\
 	if (ret < 0)							\
-		ret = iwl_acpi_get_ ## __name ## _table(fwrt);		\
+		ret = iwl_acpi_get_ ## __name(__VA_ARGS__);		\
 	return ret;							\
-}									\
-IWL_EXPORT_SYMBOL(iwl_bios_get_ ## __name ## _table)
+} while (0)
 
-IWL_BIOS_TABLE_LOADER(wrds);
-IWL_BIOS_TABLE_LOADER(ewrd);
-IWL_BIOS_TABLE_LOADER(wgds);
-IWL_BIOS_TABLE_LOADER(ppag);
+#define IWL_BIOS_TABLE_LOADER(__name)					\
+int iwl_bios_get_ ## __name(struct iwl_fw_runtime *fwrt)		\
+{GET_BIOS_TABLE(__name, fwrt); }					\
+IWL_EXPORT_SYMBOL(iwl_bios_get_ ## __name)
+
+#define IWL_BIOS_TABLE_LOADER_DATA(__name, data_type)			\
+int iwl_bios_get_ ## __name(struct iwl_fw_runtime *fwrt,		\
+			    data_type * data)				\
+{GET_BIOS_TABLE(__name, fwrt, data); }					\
+IWL_EXPORT_SYMBOL(iwl_bios_get_ ## __name)
+
+IWL_BIOS_TABLE_LOADER(wrds_table);
+IWL_BIOS_TABLE_LOADER(ewrd_table);
+IWL_BIOS_TABLE_LOADER(wgds_table);
+IWL_BIOS_TABLE_LOADER(ppag_table);
+IWL_BIOS_TABLE_LOADER_DATA(tas_table, struct iwl_tas_data);
 
 static const struct dmi_system_id dmi_ppag_approved_list[] = {
 	{ .ident = "HP",
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index 53bd82417cc3..7719ee764c55 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -133,4 +133,8 @@ int iwl_bios_get_ewrd_table(struct iwl_fw_runtime *fwrt);
 int iwl_bios_get_wgds_table(struct iwl_fw_runtime *fwrt);
 
 int iwl_bios_get_ppag_table(struct iwl_fw_runtime *fwrt);
+
+int iwl_bios_get_tas_table(struct iwl_fw_runtime *fwrt,
+			   struct iwl_tas_data *data);
+
 #endif /* __fw_regulatory_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index f8092622d988..d6cbfe6c5a17 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -550,3 +550,51 @@ int iwl_uefi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 	kfree(data);
 	return ret;
 }
+
+int iwl_uefi_get_tas_table(struct iwl_fw_runtime *fwrt,
+			   struct iwl_tas_data *tas_data)
+{
+	struct uefi_cnv_var_wtas *uefi_tas;
+	int ret = 0, enabled, i;
+
+	uefi_tas = iwl_uefi_get_verified_variable(fwrt->trans, IWL_UEFI_WTAS_NAME,
+						  "WTAS", sizeof(*uefi_tas), NULL);
+	if (IS_ERR(uefi_tas))
+		return -EINVAL;
+
+	if (uefi_tas->revision != IWL_UEFI_WTAS_REVISION) {
+		ret = -EINVAL;
+		IWL_DEBUG_RADIO(fwrt, "Unsupported UEFI WTAS revision:%d\n",
+				uefi_tas->revision);
+		goto out;
+	}
+
+	enabled = iwl_parse_tas_selection(fwrt, tas_data,
+					  uefi_tas->tas_selection);
+	if (!enabled) {
+		IWL_DEBUG_RADIO(fwrt, "TAS not enabled\n");
+		ret = 0;
+		goto out;
+	}
+
+	IWL_DEBUG_RADIO(fwrt, "Reading TAS table revision %d\n",
+			uefi_tas->revision);
+	if (uefi_tas->black_list_size > IWL_WTAS_BLACK_LIST_MAX) {
+		IWL_DEBUG_RADIO(fwrt, "TAS invalid array size %d\n",
+				uefi_tas->black_list_size);
+		ret = -EINVAL;
+		goto out;
+	}
+	tas_data->block_list_size = cpu_to_le32(uefi_tas->black_list_size);
+	IWL_DEBUG_RADIO(fwrt, "TAS array size %u\n", uefi_tas->black_list_size);
+
+	for (i = 0; i < uefi_tas->black_list_size; i++) {
+		tas_data->block_list_array[i] =
+			cpu_to_le32(uefi_tas->black_list[i]);
+		IWL_DEBUG_RADIO(fwrt, "TAS block list country %d\n",
+				uefi_tas->black_list[i]);
+	}
+out:
+	kfree(uefi_tas);
+	return ret;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index a2e6eb21de82..f849a485d0a9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -16,6 +16,7 @@
 #define IWL_UEFI_EWRD_NAME		L"UefiCnvWlanEWRD"
 #define IWL_UEFI_WGDS_NAME		L"UefiCnvWlanWGDS"
 #define IWL_UEFI_PPAG_NAME		L"UefiCnvWlanPPAG"
+#define IWL_UEFI_WTAS_NAME		L"UefiCnvWlanWTAS"
 
 #define IWL_SGOM_MAP_SIZE		339
 #define IWL_UATS_MAP_SIZE		339
@@ -25,6 +26,7 @@
 #define IWL_UEFI_WGDS_REVISION		3
 #define IWL_UEFI_MIN_PPAG_REV		1
 #define IWL_UEFI_MAX_PPAG_REV		3
+#define IWL_UEFI_WTAS_REVISION		1
 
 struct pnvm_sku_package {
 	u8 rev;
@@ -115,6 +117,19 @@ struct uefi_cnv_var_ppag {
 	struct iwl_ppag_chain ppag_chains[IWL_NUM_CHAIN_LIMITS];
 } __packed;
 
+/* struct uefi_cnv_var_wtas - WTAS tabled as defined in UEFI
+ * @revision: the revision of the table
+ * @tas_selection: different options of TAS enablement.
+ * @black_list_size: the number of defined entried in the black list
+ * @black_list: a list of countries that are not allowed to use the TAS feature
+ */
+struct uefi_cnv_var_wtas {
+	u8 revision;
+	u32 tas_selection;
+	u8 black_list_size;
+	u16 black_list[IWL_WTAS_BLACK_LIST_MAX];
+} __packed;
+
 /*
  * This is known to be broken on v4.19 and to work on v5.4.  Until we
  * figure out why this is the case and how to make it work, simply
@@ -133,6 +148,8 @@ int iwl_uefi_get_wrds_table(struct iwl_fw_runtime *fwrt);
 int iwl_uefi_get_ewrd_table(struct iwl_fw_runtime *fwrt);
 int iwl_uefi_get_wgds_table(struct iwl_fw_runtime *fwrt);
 int iwl_uefi_get_ppag_table(struct iwl_fw_runtime *fwrt);
+int iwl_uefi_get_tas_table(struct iwl_fw_runtime *fwrt,
+			   struct iwl_tas_data *data);
 #else /* CONFIG_EFI */
 static inline void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
 {
@@ -183,6 +200,12 @@ static inline int iwl_uefi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 {
 	return -ENOENT;
 }
+
+static inline int iwl_uefi_get_tas_table(struct iwl_fw_runtime *fwrt,
+					 struct iwl_tas_data *data)
+{
+	return -ENOENT;
+}
 #endif /* CONFIG_EFI */
 
 #if defined(CONFIG_EFI) && defined(CONFIG_ACPI)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 0f36eddb3143..72f8a6cf20c7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1108,10 +1108,6 @@ static int iwl_mvm_ppag_init(struct iwl_mvm *mvm)
 	return iwl_mvm_ppag_send_cmd(mvm);
 }
 
-#ifdef CONFIG_ACPI
-
-
-
 static bool iwl_mvm_add_to_tas_block_list(__le32 *list, __le32 *le_size, unsigned int mcc)
 {
 	int i;
@@ -1149,7 +1145,7 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 		return;
 	}
 
-	ret = iwl_acpi_get_tas(&mvm->fwrt, &data);
+	ret = iwl_bios_get_tas_table(&mvm->fwrt, &data);
 	if (ret < 0) {
 		IWL_DEBUG_RADIO(mvm,
 				"TAS table invalid or unavailable. (%d)\n",
@@ -1205,6 +1201,8 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 		IWL_DEBUG_RADIO(mvm, "failed to send TAS_CONFIG (%d)\n", ret);
 }
 
+#ifdef CONFIG_ACPI
+
 static u8 iwl_mvm_eval_dsm_rfi(struct iwl_mvm *mvm)
 {
 	u8 value;
@@ -1345,10 +1343,6 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 
 #else /* CONFIG_ACPI */
 
-static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
-{
-}
-
 static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 {
 }
-- 
2.34.1


