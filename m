Return-Path: <linux-wireless+bounces-2949-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3598459EA
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 15:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0911F23840
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 14:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F415F464;
	Thu,  1 Feb 2024 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dNsupIXi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D925337E
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797151; cv=none; b=mDOBEsbnVP8qnyToDgw4sP1FuwfACx/9shS2mhOZqmp5ij8DvoglVPrYoTalm0dEYh1o97zeMZ/ajwdntr3Bk+H2/4ulbV2nN7t5bgeaGT5ut9BwPt9NM+pw8iMVgGbWdLOlHLgJ+NMKm6tb22l4RiulzHReY6rrf+i+t87HrFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797151; c=relaxed/simple;
	bh=ej2S2M238FuCXtJun2cAA8vsk5z27ZtAsv5bq2VKX+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T9ucmpBrmD2S1PXhntxldiAZOIGzPhv9oJfok/gF3HXdQGKSmh/vtM1NtoXY4O5HJokdBXC8jTALsVRLXIfVUs/ObFUB348VApTra1/mj/xqkrHnoqzvny1EdMHGplFJj7SVSPBko+cFmoBWUiMWhcYrmfr9c1AQsknWfr0I0EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dNsupIXi; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706797149; x=1738333149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ej2S2M238FuCXtJun2cAA8vsk5z27ZtAsv5bq2VKX+4=;
  b=dNsupIXihAMaJfS50Zh5lMvO5l/BvVH5iAxOiqBkk7C4BjMMaFPnUulJ
   qS8JoaJIE3+P93qpWr2RLUFj2Kgwf3wZOBeM6QmRVIwwGd08Aql+jEvw6
   HLjvlrPQKMzNqhUDv+Ac3koD90tDswoMBmZ3SIV0re+GHwK4X0Ay10fF1
   bgVi5UcVrhccHsgq4WhyMeOaXj6sRpFczdf8MuzBwL7ENip48Vy0rWCjO
   dxrI42r++5QWaUD6aov+Wn4uHJDeBZmifmu/xFujwzlHe3v8ctY9045TO
   3DM4PfZQpgSg2AFobyL5wQszzpben24GPytLsgg+nV7T1iW5eS0YSiiK1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="435062456"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="435062456"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:19:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="94011"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:19:05 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/17] wifi: iwlwifi: read SPLC from UEFI
Date: Thu,  1 Feb 2024 16:17:26 +0200
Message-Id: <20240201155157.3d9d835b6edb.I7ea262df9431ced787b77c87149c6d7bddb7e7d6@changeid>
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

Try to read the SPLC table from UEFI first,
and if the WIFI UEFI tables are unlocked or the
table doesn't exist - try to read it from ACPI

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  1 -
 .../wireless/intel/iwlwifi/fw/regulatory.c    |  2 ++
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  2 ++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 23 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  | 21 +++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  2 +-
 6 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index d6e7de2543b2..e74745f939ae 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -385,7 +385,6 @@ int iwl_acpi_get_pwr_limit(struct iwl_fw_runtime *fwrt, u64 *dflt_pwr_limit)
 out:
 	return ret;
 }
-IWL_EXPORT_SYMBOL(iwl_acpi_get_pwr_limit);
 
 int iwl_acpi_get_eckv(struct device *dev, u32 *extl_clk)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 4cf22e280dfc..452c7cc49c27 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -35,6 +35,8 @@ IWL_BIOS_TABLE_LOADER(ewrd_table);
 IWL_BIOS_TABLE_LOADER(wgds_table);
 IWL_BIOS_TABLE_LOADER(ppag_table);
 IWL_BIOS_TABLE_LOADER_DATA(tas_table, struct iwl_tas_data);
+IWL_BIOS_TABLE_LOADER_DATA(pwr_limit, u64);
+
 
 static const struct dmi_system_id dmi_ppag_approved_list[] = {
 	{ .ident = "HP",
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index 7719ee764c55..b391c6fc3bcc 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -137,4 +137,6 @@ int iwl_bios_get_ppag_table(struct iwl_fw_runtime *fwrt);
 int iwl_bios_get_tas_table(struct iwl_fw_runtime *fwrt,
 			   struct iwl_tas_data *data);
 
+int iwl_bios_get_pwr_limit(struct iwl_fw_runtime *fwrt,
+			   u64 *dflt_pwr_limit);
 #endif /* __fw_regulatory_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index d6cbfe6c5a17..5ec82205be12 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -598,3 +598,26 @@ int iwl_uefi_get_tas_table(struct iwl_fw_runtime *fwrt,
 	kfree(uefi_tas);
 	return ret;
 }
+
+int iwl_uefi_get_pwr_limit(struct iwl_fw_runtime *fwrt,
+			   u64 *dflt_pwr_limit)
+{
+	struct uefi_cnv_var_splc *data;
+	int ret = 0;
+
+	data = iwl_uefi_get_verified_variable(fwrt->trans, IWL_UEFI_SPLC_NAME,
+					      "SPLC", sizeof(*data), NULL);
+	if (IS_ERR(data))
+		return -EINVAL;
+
+	if (data->revision != IWL_UEFI_SPLC_REVISION) {
+		ret = -EINVAL;
+		IWL_DEBUG_RADIO(fwrt, "Unsupported UEFI SPLC revision:%d\n",
+				data->revision);
+		goto out;
+	}
+	*dflt_pwr_limit = data->default_pwr_limit;
+out:
+	kfree(data);
+	return ret;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index f849a485d0a9..4cf3af576920 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -17,6 +17,8 @@
 #define IWL_UEFI_WGDS_NAME		L"UefiCnvWlanWGDS"
 #define IWL_UEFI_PPAG_NAME		L"UefiCnvWlanPPAG"
 #define IWL_UEFI_WTAS_NAME		L"UefiCnvWlanWTAS"
+#define IWL_UEFI_SPLC_NAME		L"UefiCnvWlanSPLC"
+
 
 #define IWL_SGOM_MAP_SIZE		339
 #define IWL_UATS_MAP_SIZE		339
@@ -27,6 +29,7 @@
 #define IWL_UEFI_MIN_PPAG_REV		1
 #define IWL_UEFI_MAX_PPAG_REV		3
 #define IWL_UEFI_WTAS_REVISION		1
+#define IWL_UEFI_SPLC_REVISION		0
 
 struct pnvm_sku_package {
 	u8 rev;
@@ -130,6 +133,15 @@ struct uefi_cnv_var_wtas {
 	u16 black_list[IWL_WTAS_BLACK_LIST_MAX];
 } __packed;
 
+/* struct uefi_cnv_var_splc - SPLC tabled as defined in UEFI
+ * @revision: the revision of the table
+ * @default_pwr_limit: The default maximum power per device
+ */
+struct uefi_cnv_var_splc {
+	u8 revision;
+	u32 default_pwr_limit;
+} __packed;
+
 /*
  * This is known to be broken on v4.19 and to work on v5.4.  Until we
  * figure out why this is the case and how to make it work, simply
@@ -150,6 +162,8 @@ int iwl_uefi_get_wgds_table(struct iwl_fw_runtime *fwrt);
 int iwl_uefi_get_ppag_table(struct iwl_fw_runtime *fwrt);
 int iwl_uefi_get_tas_table(struct iwl_fw_runtime *fwrt,
 			   struct iwl_tas_data *data);
+int iwl_uefi_get_pwr_limit(struct iwl_fw_runtime *fwrt,
+			   u64 *dflt_pwr_limit);
 #else /* CONFIG_EFI */
 static inline void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
 {
@@ -206,6 +220,13 @@ static inline int iwl_uefi_get_tas_table(struct iwl_fw_runtime *fwrt,
 {
 	return -ENOENT;
 }
+
+static inline int iwl_uefi_get_pwr_limit(struct iwl_fw_runtime *fwrt,
+					 u64 *dflt_pwr_limit)
+{
+	*dflt_pwr_limit = 0;
+	return 0;
+}
 #endif /* CONFIG_EFI */
 
 #if defined(CONFIG_EFI) && defined(CONFIG_ACPI)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 0e7b66a20b7c..747fc91ef8d0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -689,7 +689,7 @@ static u32 iwl_mvm_min_backoff(struct iwl_mvm *mvm)
 	if (!backoff)
 		return 0;
 
-	iwl_acpi_get_pwr_limit(&mvm->fwrt, &dflt_pwr_limit);
+	iwl_bios_get_pwr_limit(&mvm->fwrt, &dflt_pwr_limit);
 
 	while (backoff->pwr) {
 		if (dflt_pwr_limit >= backoff->pwr)
-- 
2.34.1


