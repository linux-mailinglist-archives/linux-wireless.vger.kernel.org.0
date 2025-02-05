Return-Path: <linux-wireless+bounces-18523-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFF7A28AFA
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 13:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07661620E6
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 12:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB8ABA38;
	Wed,  5 Feb 2025 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IRr3HaOt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B55A19BBA
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 12:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760176; cv=none; b=qvPqSGuawSeYWtZnc0ojYhG4JCtBp5B7Vc2yUnBgnp8O0n7fhVbequYqF4xNE+NHX6Jnfrv4mGw/7784tuvoppJxn2IyLeM1anBMYBgN7hUwAggCqvY8e4Sxr9Ce+qOF7qOq/Z06VJm3XnJ0Dgx8UcogsR9lu5km8q6rEMxJz2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760176; c=relaxed/simple;
	bh=YgAqTqJY/4xxjL0+zNgcB965K4H4nF9o/VhJKdXp0pc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IdhWSYkl4TGyCwKlThS+0rCMf2fOKGS3VgvOOmDk4YIP3GOdM6e+RO9mlXLag0yqqirkOXbTCwt9KDhbxhkscYqNd1rcOPQlHfPfvHa3BAyLOLXk+PDKY1Mzmm2022M2KuLJJS5sEVycFY5wnThbkdsKHb3BBMDOrDvpxmLF4Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IRr3HaOt; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738760171; x=1770296171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YgAqTqJY/4xxjL0+zNgcB965K4H4nF9o/VhJKdXp0pc=;
  b=IRr3HaOtJSXraHd1WTurCIXieNGrGjulKWuBmFW1lxCAuo76/m6noXLb
   rSn0Nhc8YuiN6DMbiEHkUOqi/MZQX3Os1POP9KCYOUJcqwjfx8xFKkioK
   /z9z8PEjomey2FguqVjvLbSjnVZWUIJMRaMmCCir+v2jMz4vGRiYZHkft
   95L/6+ZzlZZ4doKV++AvLkbr96GdPbzbfV6UynB/lR+/4UfcR8Ebd/k9W
   /ttMHecKt49cQxBTBtk2SdyVSVloBkRP2g2dml/cSrQDaVHJwdHW62MEc
   2pZSfFySpBqZ5nVrpIYCLsddSMoXe6r4h6x3SZa3jUpZjJnaUgviFf88K
   A==;
X-CSE-ConnectionGUID: LJUzj4ydQLKXN3GKpYsbVg==
X-CSE-MsgGUID: /Y4C6kQuRy+JVIWB679T0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42159172"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="42159172"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:11 -0800
X-CSE-ConnectionGUID: SkPaNuU+QPyUwMRMQPAfJw==
X-CSE-MsgGUID: DnO9CAsfRu6nzwtmyuCIfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110745454"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:10 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 04/19] wifi: iwlwifi: mvm: rename and move iwl_mvm_eval_dsm_rfi() to iwl_rfi_is_enabled_in_bios()
Date: Wed,  5 Feb 2025 14:55:33 +0200
Message-Id: <20250205145347.b7ac9d05234e.Ieb623d7e8dca6bb6a5733682b31e4ff1e39373f0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
References: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Renamed iwl_mvm_eval_dsm_rfi() to iwl_rfi_is_enabled_in_bios() to better
reflect the function's operation. Additionally, moved the function to the
regulatory.c file for better organization. optimize local variable
usage in it.

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 31 +++++++++++++++++
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 34 +------------------
 3 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index ea435ee94312..63320689e05d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -674,3 +674,34 @@ bool iwl_puncturing_is_allowed_in_bios(u32 puncturing, u16 mcc)
 	}
 }
 IWL_EXPORT_SYMBOL(iwl_puncturing_is_allowed_in_bios);
+
+bool iwl_rfi_is_enabled_in_bios(struct iwl_fw_runtime *fwrt)
+{
+	/* default behaviour is disabled */
+	u32 value = 0;
+	int ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_RFI_CONFIG, &value);
+
+	if (ret < 0) {
+		IWL_DEBUG_RADIO(fwrt, "Failed to get DSM RFI, ret=%d\n", ret);
+		return false;
+	}
+
+	value &= DSM_VALUE_RFI_DISABLE;
+	/* RFI BIOS CONFIG value can be 0 or 3 only.
+	 * i.e 0 means DDR and DLVR enabled. 3 means DDR and DLVR disabled.
+	 * 1 and 2 are invalid BIOS configurations, So, it's not possible to
+	 * disable ddr/dlvr separately.
+	 */
+	if (!value) {
+		IWL_DEBUG_RADIO(fwrt, "DSM RFI is evaluated to enable\n");
+		return true;
+	} else if (value == DSM_VALUE_RFI_DISABLE) {
+		IWL_DEBUG_RADIO(fwrt, "DSM RFI is evaluated to disable\n");
+	} else {
+		IWL_DEBUG_RADIO(fwrt,
+				"DSM RFI got invalid value, value=%d\n", value);
+	}
+
+	return false;
+}
+IWL_EXPORT_SYMBOL(iwl_rfi_is_enabled_in_bios);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index b355d7bef14c..ed61bc35ef5b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -167,6 +167,8 @@ enum iwl_dsm_values_rfi {
 #define DSM_VALUE_RFI_DISABLE	(DSM_VALUE_RFI_DLVR_DISABLE |\
 				 DSM_VALUE_RFI_DDR_DISABLE)
 
+bool iwl_rfi_is_enabled_in_bios(struct iwl_fw_runtime *fwrt);
+
 enum iwl_dsm_masks_reg {
 	DSM_MASK_CHINA_22_REG = BIT(2)
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index df49dd2e2026..5a9ce7dba714 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1213,38 +1213,6 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 		IWL_DEBUG_RADIO(mvm, "failed to send TAS_CONFIG (%d)\n", ret);
 }
 
-static bool iwl_mvm_eval_dsm_rfi(struct iwl_mvm *mvm)
-{
-	u32 value = 0;
-	/* default behaviour is disabled */
-	bool bios_enable_rfi = false;
-	int ret = iwl_bios_get_dsm(&mvm->fwrt, DSM_FUNC_RFI_CONFIG, &value);
-
-
-	if (ret < 0) {
-		IWL_DEBUG_RADIO(mvm, "Failed to get DSM RFI, ret=%d\n", ret);
-		return bios_enable_rfi;
-	}
-
-	value &= DSM_VALUE_RFI_DISABLE;
-	/* RFI BIOS CONFIG value can be 0 or 3 only.
-	 * i.e 0 means DDR and DLVR enabled. 3 means DDR and DLVR disabled.
-	 * 1 and 2 are invalid BIOS configurations, So, it's not possible to
-	 * disable ddr/dlvr separately.
-	 */
-	if (!value) {
-		IWL_DEBUG_RADIO(mvm, "DSM RFI is evaluated to enable\n");
-		bios_enable_rfi = true;
-	} else if (value == DSM_VALUE_RFI_DISABLE) {
-		IWL_DEBUG_RADIO(mvm, "DSM RFI is evaluated to disable\n");
-	} else {
-		IWL_DEBUG_RADIO(mvm,
-				"DSM RFI got invalid value, value=%d\n", value);
-	}
-
-	return bios_enable_rfi;
-}
-
 static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 {
 	struct iwl_lari_config_change_cmd cmd;
@@ -1631,7 +1599,7 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	iwl_mvm_uats_init(mvm);
 
 	if (iwl_rfi_supported(mvm)) {
-		if (iwl_mvm_eval_dsm_rfi(mvm))
+		if (iwl_rfi_is_enabled_in_bios(&mvm->fwrt))
 			iwl_rfi_send_config_cmd(mvm, NULL);
 	}
 
-- 
2.34.1


