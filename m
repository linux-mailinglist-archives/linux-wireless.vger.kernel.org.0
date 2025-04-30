Return-Path: <linux-wireless+bounces-22245-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D401BAA4B02
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 14:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC59C9A05ED
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 12:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8559B23C4F0;
	Wed, 30 Apr 2025 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YX6imx9W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5781525A2A6
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746015887; cv=none; b=MFB1u/MTa1pS69pl7IaROzr4761U6UQ2mLbiA3qufrjm9+OOp7U4QIGg3Zxpj0wTLu5Kj46wajufkORJ4LlBNt3YZbBEHhSAyR+6MS7LxGQfRZAqAZMsrcbzqmnDpjPWBofLVXsVN4fsQrcWrL/2pDS4tk+eZ4KJnx92hO922Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746015887; c=relaxed/simple;
	bh=gqbEwfaQHa2IM7xHRmm2JpHx5tyibAgDXfBX+DHr/rA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k1BXV4IwNmU312dtAj0lI/Zs7sX+rRJMAJ2DhQALyR6vE7OT5c7nwLhrbJOyfIVPj+izHzf6blBCX6MvoJCFIvBMxtlgHGLEZNy4X1WciV3OmBuggB664mwFrrDVlTpydoHUqIGH3vtvWYiCLRMav4s7Elk7kyNEJwkDmzcqGRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YX6imx9W; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746015885; x=1777551885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gqbEwfaQHa2IM7xHRmm2JpHx5tyibAgDXfBX+DHr/rA=;
  b=YX6imx9WddqRyIcg7aWX3L2LrHXHbLS8CQ7GwpY5GCqdpYuhvZtFJPPj
   Af+BVydAupMlC6EPpScEWxRpI7B3pMShwqf2PfcZEzIcISXjXXQjHX3pV
   tZT06xT+BV6ZpV9YXhPfMpGugH//NpsTt1RxV9L31AWAdMjrpJov4FTOd
   rbvEecBrOKr3UhTfJOyVCe2bpwPshdZM58hue/z8Ksk701j4BcbHQs/jf
   GwJIsg3KFORpYL9NjPL6vT+uM2KtemLNfGCDGx/pNUuDs0rKwieMsa6HL
   zaAQRLxxBz1lZqTciiWgP1CuETiXw5QZglfP3i4Du/Ef6NiSa6AETE839
   g==;
X-CSE-ConnectionGUID: D9BfPvmMQlePGqCSvfjkVg==
X-CSE-MsgGUID: RSqzga13RxiXueH3+Do18w==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47578260"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="47578260"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:24:45 -0700
X-CSE-ConnectionGUID: WuKf1z/0Q4OzL+Xo8u/urA==
X-CSE-MsgGUID: v82vs62vTUCrkanNVPpRyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="135087843"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:24:44 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 iwlwifi-next 02/14] wifi: iwlwifi: read WPFC also from UEFI
Date: Wed, 30 Apr 2025 15:23:08 +0300
Message-Id: <20250430151952.839a5e7dd89b.I491acbf68047874df97b3971f1ba692ebc998a52@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430122320.1061510-1-miriam.rachel.korenblit@intel.com>
References: <20250430122320.1061510-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

We are currently reading it only from ACPI, but we need to read it from
UEFI too (if exists, and if the UEFI variables are locked)

Add the reading from the UEFI and use IWL_BIOS_TABLE_LOADER to generate
the code that determines the source from which the table should be read
(ACPI/UEFI).

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/regulatory.c    |  3 +-
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  3 +-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  2 --
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 28 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  | 19 +++++++++++++
 5 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 6adcfa6e214a..1444b628214b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2023 Intel Corporation
+ * Copyright (C) 2023, 2025 Intel Corporation
  */
 #include <linux/dmi.h>
 #include "iwl-drv.h"
@@ -34,6 +34,7 @@ IWL_BIOS_TABLE_LOADER(wrds_table);
 IWL_BIOS_TABLE_LOADER(ewrd_table);
 IWL_BIOS_TABLE_LOADER(wgds_table);
 IWL_BIOS_TABLE_LOADER(ppag_table);
+IWL_BIOS_TABLE_LOADER(phy_filters);
 IWL_BIOS_TABLE_LOADER_DATA(tas_table, struct iwl_tas_data);
 IWL_BIOS_TABLE_LOADER_DATA(pwr_limit, u64);
 IWL_BIOS_TABLE_LOADER_DATA(mcc, char);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index 53693314d505..46d19101b741 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2023-2024 Intel Corporation
+ * Copyright (C) 2023-2025 Intel Corporation
  */
 
 #ifndef __fw_regulatory_h__
@@ -236,6 +236,7 @@ bool iwl_puncturing_is_allowed_in_bios(u32 puncturing, u16 mcc);
 #define IWL_DSBR_PERMANENT_URM_MASK	BIT(9)
 
 int iwl_bios_get_dsbr(struct iwl_fw_runtime *fwrt, u32 *value);
+int iwl_bios_get_phy_filters(struct iwl_fw_runtime *fwrt);
 
 static inline void iwl_bios_setup_step(struct iwl_trans *trans,
 				       struct iwl_fw_runtime *fwrt)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 5753d95986cd..a56b96003650 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -185,9 +185,7 @@ struct iwl_fw_runtime {
 	struct iwl_mcc_allowed_ap_type_cmd uats_table;
 	bool uats_valid;
 	u8 uefi_tables_lock_status;
-#ifdef CONFIG_ACPI
 	struct iwl_phy_specific_cfg phy_filters;
-#endif
 };
 
 void iwl_fw_runtime_init(struct iwl_fw_runtime *fwrt, struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 386aadbce2a2..b0f4c217b2a5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -810,3 +810,31 @@ int iwl_uefi_get_dsbr(struct iwl_fw_runtime *fwrt, u32 *value)
 	kfree(data);
 	return ret;
 }
+
+int iwl_uefi_get_phy_filters(struct iwl_fw_runtime *fwrt)
+{
+	struct uefi_cnv_wpfc_data *data __free(kfree);
+	struct iwl_phy_specific_cfg *filters = &fwrt->phy_filters;
+
+	data = iwl_uefi_get_verified_variable(fwrt->trans, IWL_UEFI_WPFC_NAME,
+					      "WPFC", sizeof(*data), NULL);
+	if (IS_ERR(data))
+		return -EINVAL;
+
+	if (data->revision != 0) {
+		IWL_DEBUG_RADIO(fwrt, "Unsupported UEFI WPFC revision:%d\n",
+			data->revision);
+		return -EINVAL;
+	}
+
+	BUILD_BUG_ON(ARRAY_SIZE(filters->filter_cfg_chains) !=
+		     ARRAY_SIZE(data->chains));
+
+	for (int i = 0; i < ARRAY_SIZE(filters->filter_cfg_chains); i++) {
+		filters->filter_cfg_chains[i] = cpu_to_le32(data->chains[i]);
+		IWL_DEBUG_RADIO(fwrt, "WPFC: chain %d: %u\n", i, data->chains[i]);
+	}
+
+	IWL_DEBUG_RADIO(fwrt, "Loaded WPFC config from UEFI\n");
+	return 0;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index eb3c05417da3..37d2ced03ce1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -24,6 +24,7 @@
 #define IWL_UEFI_WBEM_NAME		L"UefiCnvWlanWBEM"
 #define IWL_UEFI_PUNCTURING_NAME	L"UefiCnvWlanPuncturing"
 #define IWL_UEFI_DSBR_NAME		L"UefiCnvCommonDSBR"
+#define IWL_UEFI_WPFC_NAME		L"WPFC"
 
 
 #define IWL_SGOM_MAP_SIZE		339
@@ -230,6 +231,18 @@ struct uefi_cnv_wlan_dsbr_data {
 	u32 config;
 } __packed;
 
+/**
+ * struct uefi_cnv_wpfc_data - BIOS Wi-Fi PHY filter Configuration
+ * @revision: the revision of the table
+ * @chains: configuration of each of the chains (a-d)
+ *
+ * specific PHY filter configuration
+ */
+struct uefi_cnv_wpfc_data {
+	u8 revision;
+	u32 chains[4];
+} __packed;
+
 /*
  * This is known to be broken on v4.19 and to work on v5.4.  Until we
  * figure out why this is the case and how to make it work, simply
@@ -262,6 +275,7 @@ int iwl_uefi_get_uats_table(struct iwl_trans *trans,
 			    struct iwl_fw_runtime *fwrt);
 int iwl_uefi_get_puncturing(struct iwl_fw_runtime *fwrt);
 int iwl_uefi_get_dsbr(struct iwl_fw_runtime *fwrt, u32 *value);
+int iwl_uefi_get_phy_filters(struct iwl_fw_runtime *fwrt);
 #else /* CONFIG_EFI */
 static inline void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
 {
@@ -370,5 +384,10 @@ int iwl_uefi_get_dsbr(struct iwl_fw_runtime *fwrt, u32 *value)
 {
 	return -ENOENT;
 }
+
+static inline int iwl_uefi_get_phy_filters(struct iwl_fw_runtime *fwrt)
+{
+	return -ENOENT;
+}
 #endif /* CONFIG_EFI */
 #endif /* __iwl_fw_uefi__ */
-- 
2.34.1


