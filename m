Return-Path: <linux-wireless+bounces-2877-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A318438F0
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 09:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19BB31C2731E
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 08:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4104C59B59;
	Wed, 31 Jan 2024 08:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kwi95vna"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B491E5DF14
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 08:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689530; cv=none; b=Skq8quRVUAgjcpyAOv1I7kXhIIJoOQprWsQBTpUVt8DuhBFbJyurlP6ae/IT5VFAPrpuW4dxeEVzAJw75lVHT/eTl1LSinI7cEj/2oq5vYVV86BKai90y/tnY7czKft/c8qcTYzRTHcEWv0lOAJ+sRMhrdrsj00rAmKOiEfyqRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689530; c=relaxed/simple;
	bh=w/MxYNn+gie6v9hK2VxEpNas4IL7hgA8hV4CNrMrnV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=In6sMrcv6/UwVounNosgX6RRdScnrn5Q2TNCqPPJLMka2rZSIp/11I4sN+QKWgy78Gjemop3SyVyKrM9WMlZ7kd7slL2/uWRc4jluzfTYMdDQGQ30+Woxd4Ci/FZJ/qsJCI79sm2gP423gImXNh62dMvGqExoBV9AKiTb+TRSuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kwi95vna; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706689523; x=1738225523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w/MxYNn+gie6v9hK2VxEpNas4IL7hgA8hV4CNrMrnV0=;
  b=kwi95vna8drCKyKYMoodAZGmzwkNIq+MSPYi/9Y97A+2h+03jJQgeFWA
   qSTuYMLCOrflm2X+QCuAJnDBjaBuEmhBPkYnbGSaUje3BPefnFjp+Br9P
   Ne8tA0KX1YqTSgIgMIOsb4GdoMTZWZhDS+GWnyatSmFgtMdZMZwp5qHIN
   +2Job8z8J9LA1OB5XGcXXUQ7l5LAAqFRcZwiMwssj+6za8qH+zOsETiou
   N1MwB8GkJav5NUMj5xyqkB/ktGdPvtWjEMCOPNL9FuPpjw5aTisic+ZFk
   hNkc7idt1ZIxaVW1le6dDtoPsQD8f4XARysaXOlJNkJrUn4JlZH4GA5I9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="407249960"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="407249960"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:25:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3968935"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:25:22 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/14] wifi: iwlwifi: read PPAG table from UEFI
Date: Wed, 31 Jan 2024 10:24:43 +0200
Message-Id: <20240131091413.6516da09aec1.I0dcaf0b6d8857417ba1318467a28da5d0d7d7f27@changeid>
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

Try to read the PPAG table from UEFI first,
and if the WIFI UEFI tables are unlocked or the
table doesn't exist - try to read it from ACPI

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  1 -
 .../wireless/intel/iwlwifi/fw/regulatory.c    |  1 +
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  1 +
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 29 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  | 22 ++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 16 ++--------
 7 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index b029e88501a1..c150a66eed07 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -968,7 +968,6 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 	kfree(data);
 	return ret;
 }
-IWL_EXPORT_SYMBOL(iwl_acpi_get_ppag_table);
 
 void iwl_acpi_get_phy_filters(struct iwl_fw_runtime *fwrt,
 			      struct iwl_phy_specific_cfg *filters)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 3d42ea1ec5fd..fb4df1ff061d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -24,6 +24,7 @@ IWL_EXPORT_SYMBOL(iwl_bios_get_ ## __name ## _table)
 IWL_BIOS_TABLE_LOADER(wrds);
 IWL_BIOS_TABLE_LOADER(ewrd);
 IWL_BIOS_TABLE_LOADER(wgds);
+IWL_BIOS_TABLE_LOADER(ppag);
 
 static const struct dmi_system_id dmi_ppag_approved_list[] = {
 	{ .ident = "HP",
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index 63f650cb6517..954ba83d0277 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -113,4 +113,5 @@ int iwl_bios_get_ewrd_table(struct iwl_fw_runtime *fwrt);
 
 int iwl_bios_get_wgds_table(struct iwl_fw_runtime *fwrt);
 
+int iwl_bios_get_ppag_table(struct iwl_fw_runtime *fwrt);
 #endif /* __fw_regulatory_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index d129782f2be4..9bcf04987d8b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -172,10 +172,10 @@ struct iwl_fw_runtime {
 	u32 geo_rev;
 	u32 geo_num_profiles;
 	bool geo_enabled;
-#ifdef CONFIG_ACPI
 	struct iwl_ppag_chain ppag_chains[IWL_NUM_CHAIN_LIMITS];
 	u32 ppag_flags;
 	u32 ppag_ver;
+#ifdef CONFIG_ACPI
 	struct iwl_sar_offset_mapping_cmd sgom_table;
 	bool sgom_enabled;
 	struct iwl_uats_table_cmd uats_table;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index a777cd4c70f7..f8092622d988 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -521,3 +521,32 @@ int iwl_uefi_get_wgds_table(struct iwl_fw_runtime *fwrt)
 	kfree(data);
 	return ret;
 }
+
+int iwl_uefi_get_ppag_table(struct iwl_fw_runtime *fwrt)
+{
+	struct uefi_cnv_var_ppag *data;
+	int ret = 0;
+
+	data = iwl_uefi_get_verified_variable(fwrt->trans, IWL_UEFI_PPAG_NAME,
+					      "PPAG", sizeof(*data), NULL);
+	if (IS_ERR(data))
+		return -EINVAL;
+
+	if (data->revision < IWL_UEFI_MIN_PPAG_REV ||
+	    data->revision > IWL_UEFI_MAX_PPAG_REV) {
+		ret = -EINVAL;
+		IWL_DEBUG_RADIO(fwrt, "Unsupported UEFI PPAG revision:%d\n",
+				data->revision);
+		goto out;
+	}
+
+	fwrt->ppag_ver = data->revision;
+	fwrt->ppag_flags = data->ppag_modes & IWL_PPAG_ETSI_CHINA_MASK;
+
+	BUILD_BUG_ON(sizeof(fwrt->ppag_chains) != sizeof(data->ppag_chains));
+	memcpy(&fwrt->ppag_chains, &data->ppag_chains,
+	       sizeof(data->ppag_chains));
+out:
+	kfree(data);
+	return ret;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 3141fca047c6..a2e6eb21de82 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -15,6 +15,7 @@
 #define IWL_UEFI_WRDS_NAME		L"UefiCnvWlanWRDS"
 #define IWL_UEFI_EWRD_NAME		L"UefiCnvWlanEWRD"
 #define IWL_UEFI_WGDS_NAME		L"UefiCnvWlanWGDS"
+#define IWL_UEFI_PPAG_NAME		L"UefiCnvWlanPPAG"
 
 #define IWL_SGOM_MAP_SIZE		339
 #define IWL_UATS_MAP_SIZE		339
@@ -22,6 +23,8 @@
 #define IWL_UEFI_WRDS_REVISION		2
 #define IWL_UEFI_EWRD_REVISION		2
 #define IWL_UEFI_WGDS_REVISION		3
+#define IWL_UEFI_MIN_PPAG_REV		1
+#define IWL_UEFI_MAX_PPAG_REV		3
 
 struct pnvm_sku_package {
 	u8 rev;
@@ -99,6 +102,19 @@ struct uefi_cnv_var_wgds {
 	struct iwl_geo_profile geo_profiles[BIOS_GEO_MAX_PROFILE_NUM];
 } __packed;
 
+/*
+ * struct uefi_cnv_var_ppag - PPAG table as defined in UEFI
+ * @revision: the revision of the table
+ * @ppag_modes: bit 0 - PPAG is enabled/disabled in ETSI,
+ *	bit 1 - PPAG is enabled/disabled in China
+ * @ppag_chains: the PPAG values per chain and band
+ */
+struct uefi_cnv_var_ppag {
+	u8 revision;
+	u32 ppag_modes;
+	struct iwl_ppag_chain ppag_chains[IWL_NUM_CHAIN_LIMITS];
+} __packed;
+
 /*
  * This is known to be broken on v4.19 and to work on v5.4.  Until we
  * figure out why this is the case and how to make it work, simply
@@ -116,6 +132,7 @@ int iwl_uefi_handle_tlv_mem_desc(struct iwl_trans *trans, const u8 *data,
 int iwl_uefi_get_wrds_table(struct iwl_fw_runtime *fwrt);
 int iwl_uefi_get_ewrd_table(struct iwl_fw_runtime *fwrt);
 int iwl_uefi_get_wgds_table(struct iwl_fw_runtime *fwrt);
+int iwl_uefi_get_ppag_table(struct iwl_fw_runtime *fwrt);
 #else /* CONFIG_EFI */
 static inline void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
 {
@@ -161,6 +178,11 @@ static inline int iwl_uefi_get_wgds_table(struct iwl_fw_runtime *fwrt)
 {
 	return -ENOENT;
 }
+
+static inline int iwl_uefi_get_ppag_table(struct iwl_fw_runtime *fwrt)
+{
+	return -ENOENT;
+}
 #endif /* CONFIG_EFI */
 
 #if defined(CONFIG_EFI) && defined(CONFIG_ACPI)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 1d759fe7d12d..0a820dbeef23 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1078,8 +1078,6 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 	return iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, len, &cmd);
 }
 
-#ifdef CONFIG_ACPI
-
 int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
 {
 	union iwl_ppag_table_cmd cmd;
@@ -1110,6 +1108,8 @@ static int iwl_mvm_ppag_init(struct iwl_mvm *mvm)
 	return iwl_mvm_ppag_send_cmd(mvm);
 }
 
+#ifdef CONFIG_ACPI
+
 static const struct dmi_system_id dmi_tas_approved_list[] = {
 	{ .ident = "HP",
 	  .matches = {
@@ -1389,16 +1389,6 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 
 #else /* CONFIG_ACPI */
 
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
 static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 {
 }
@@ -1426,7 +1416,7 @@ void iwl_mvm_get_bios_tables(struct iwl_mvm *mvm)
 	iwl_acpi_get_guid_lock_status(&mvm->fwrt);
 
 	/* read PPAG table */
-	ret = iwl_acpi_get_ppag_table(&mvm->fwrt);
+	ret = iwl_bios_get_ppag_table(&mvm->fwrt);
 	if (ret < 0) {
 		IWL_DEBUG_RADIO(mvm,
 				"PPAG BIOS table invalid or unavailable. (%d)\n",
-- 
2.34.1


