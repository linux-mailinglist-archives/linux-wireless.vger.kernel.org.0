Return-Path: <linux-wireless+bounces-2956-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 216A88459FC
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 15:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AF301F268E5
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 14:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E0C5CDF5;
	Thu,  1 Feb 2024 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MNvzgqXa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58755F47A
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797202; cv=none; b=EPbUQKbRZPLJs4dJdrO/QBjISzZso1SBUjk5TVJ601/GNQDrikdFJCCYNNq8s8F1I26sd2y1qs+jXNiuu0tPMkqzxhmOWfGwJsB3L1G12WcNTO5n8x9k4jPp/OzTg9q67jL2TX8dYiLp0in9wqEdNJqtNFmQcgXXDn6037nLNZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797202; c=relaxed/simple;
	bh=kgCKBcAGwKX6EvvAxh6TN7JpKR5r0GckmmVua3jY3EE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TcJEyECFuEa7z7nQfSbYnAk3II+vellRICYoXI8UNHXGBmMxYXrNikHLwBOiDOpkSeReau7Z65m1mnFTCGjd0qimU1k2LqzFwQ8jHGaV/sl6WydpD1VxRbQcxMbXRW+WwaMm48Z9w+40TX9awbIo9KNlOZKWWV7zycQKnhYZybk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MNvzgqXa; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706797201; x=1738333201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kgCKBcAGwKX6EvvAxh6TN7JpKR5r0GckmmVua3jY3EE=;
  b=MNvzgqXaE4x+pPZ/l+244k7dJx/ENRQvqD+kLcek2XwfnnSgvEFLNBEh
   sBhQ0KxCAAAiW4qAVkC0OhV7hZHe22kfUjgX6NET6HfZ1/B7GJw4CutQL
   a2ePV5AtoULomyFCKApJz13y0OWKJU2j0XBIZj5Zi6W/FJih/0QN259uk
   HxyMNhjsMLsAASw7lCWiJ9wd6dj4n19/gIog+2DtzXcBDc7F9rOQPM7ry
   iRQTKA8T1Hi20l4j8Edr42zx8LzRppaRM7VArhAOklkoGp6xxbb8ZrNHE
   QmfQ4xcIeJqJBpxfgKMLkV2zvnZK7bL/wGMmsvoIrTl7yc8jJxn24H9x0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="435062922"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="435062922"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:19:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="94178"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:19:57 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/17] wifi: iwlwifi: rfi: use a single DSM function for all RFI configurations
Date: Thu,  1 Feb 2024 16:17:33 +0200
Message-Id: <20240201155157.f4e62435310d.I4f9b6860dd8e3c7ae1f816be5ff8b5967eee266f@changeid>
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

RFI configuration moved from internal guid to the wifi guid, DSM
function 11. Update reading RFI configuration from BIOS.

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c |  5 ---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h | 14 +++----
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  | 43 ++++++++++++--------
 3 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 7b422ebe2241..6f9ead79978a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -14,11 +14,6 @@ const guid_t iwl_guid = GUID_INIT(0xF21202BF, 0x8F78, 0x4DC6,
 				  0x8E, 0x28, 0x5A, 0xDE);
 IWL_EXPORT_SYMBOL(iwl_guid);
 
-const guid_t iwl_rfi_guid = GUID_INIT(0x7266172C, 0x220B, 0x4B29,
-				      0x81, 0x4F, 0x75, 0xE4,
-				      0xDD, 0x26, 0xB5, 0xFD);
-IWL_EXPORT_SYMBOL(iwl_rfi_guid);
-
 static int iwl_acpi_get_handle(struct device *dev, acpi_string method,
 			       acpi_handle *ret_handle)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index ac6655c1f777..e6d68ab83ba9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -103,6 +103,7 @@ enum iwl_dsm_funcs_rev_0 {
 	DSM_FUNC_ACTIVATE_CHANNEL = 8,
 	DSM_FUNC_FORCE_DISABLE_CHANNELS = 9,
 	DSM_FUNC_ENERGY_DETECTION_THRESHOLD = 10,
+	DSM_FUNC_RFI_CONFIG = 11
 };
 
 enum iwl_dsm_values_srd {
@@ -119,16 +120,14 @@ enum iwl_dsm_values_indonesia {
 	DSM_VALUE_INDONESIA_MAX
 };
 
-/* DSM RFI uses a different GUID, so need separate definitions */
-
-#define DSM_RFI_FUNC_ENABLE 3
-
 enum iwl_dsm_values_rfi {
-	DSM_VALUE_RFI_ENABLE,
-	DSM_VALUE_RFI_DISABLE,
-	DSM_VALUE_RFI_MAX
+	DSM_VALUE_RFI_DLVR_DISABLE	= BIT(0),
+	DSM_VALUE_RFI_DDR_DISABLE	= BIT(1),
 };
 
+#define DSM_VALUE_RFI_DISABLE	(DSM_VALUE_RFI_DLVR_DISABLE |\
+				 DSM_VALUE_RFI_DDR_DISABLE)
+
 enum iwl_dsm_masks_reg {
 	DSM_MASK_CHINA_22_REG = BIT(2)
 };
@@ -138,7 +137,6 @@ enum iwl_dsm_masks_reg {
 struct iwl_fw_runtime;
 
 extern const guid_t iwl_guid;
-extern const guid_t iwl_rfi_guid;
 
 int iwl_acpi_get_dsm_u8(struct device *dev, int rev, int func,
 			const guid_t *guid, u8 *value);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index fea2e8a5102d..e9b5dc7ee8c7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1203,28 +1203,37 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 
 #ifdef CONFIG_ACPI
 
-static u8 iwl_mvm_eval_dsm_rfi(struct iwl_mvm *mvm)
+static bool iwl_mvm_eval_dsm_rfi(struct iwl_mvm *mvm)
 {
-	u8 value;
-	int ret = iwl_acpi_get_dsm_u8(mvm->fwrt.dev, 0, DSM_RFI_FUNC_ENABLE,
-				      &iwl_rfi_guid, &value);
+	u8 value = 0;
+	/* default behaviour is disabled */
+	bool bios_enable_rfi = false;
+	int ret  = iwl_acpi_get_dsm_u8(mvm->fwrt.dev, 0,
+				       DSM_FUNC_RFI_CONFIG, &iwl_guid,
+				       &value);
 
 	if (ret < 0) {
 		IWL_DEBUG_RADIO(mvm, "Failed to get DSM RFI, ret=%d\n", ret);
+		return bios_enable_rfi;
+	}
 
-	} else if (value >= DSM_VALUE_RFI_MAX) {
-		IWL_DEBUG_RADIO(mvm, "DSM RFI got invalid value, ret=%d\n",
-				value);
-
-	} else if (value == DSM_VALUE_RFI_ENABLE) {
+	value &= DSM_VALUE_RFI_DISABLE;
+	/* RFI BIOS CONFIG value can be 0 or 3 only.
+	 * i.e 0 means DDR and DLVR enabled. 3 means DDR and DLVR disabled.
+	 * 1 and 2 are invalid BIOS configurations, So, it's not possible to
+	 * disable ddr/dlvr separately.
+	 */
+	if (!value) {
 		IWL_DEBUG_RADIO(mvm, "DSM RFI is evaluated to enable\n");
-		return DSM_VALUE_RFI_ENABLE;
+		bios_enable_rfi = true;
+	} else if (value == DSM_VALUE_RFI_DISABLE) {
+		IWL_DEBUG_RADIO(mvm, "DSM RFI is evaluated to disable\n");
+	} else {
+		IWL_DEBUG_RADIO(mvm,
+				"DSM RFI got invalid value, value=%d\n", value);
 	}
 
-	IWL_DEBUG_RADIO(mvm, "DSM RFI is disabled\n");
-
-	/* default behaviour is disabled */
-	return DSM_VALUE_RFI_DISABLE;
+	return bios_enable_rfi;
 }
 
 static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
@@ -1347,9 +1356,9 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 {
 }
 
-static u8 iwl_mvm_eval_dsm_rfi(struct iwl_mvm *mvm)
+static bool iwl_mvm_eval_dsm_rfi(struct iwl_mvm *mvm)
 {
-	return DSM_VALUE_RFI_DISABLE;
+	return false;
 }
 
 #endif /* CONFIG_ACPI */
@@ -1727,7 +1736,7 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	iwl_mvm_uats_init(mvm);
 
 	if (iwl_rfi_supported(mvm)) {
-		if (iwl_mvm_eval_dsm_rfi(mvm) == DSM_VALUE_RFI_ENABLE)
+		if (iwl_mvm_eval_dsm_rfi(mvm))
 			iwl_rfi_send_config_cmd(mvm, NULL);
 	}
 
-- 
2.34.1


