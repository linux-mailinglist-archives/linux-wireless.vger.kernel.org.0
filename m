Return-Path: <linux-wireless+bounces-22207-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AC3AA1B9B
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 21:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0673AAD9F
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 19:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D4D261577;
	Tue, 29 Apr 2025 19:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ad6jX6Bg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259D725FA29
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 19:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745956445; cv=none; b=p0WMaWCSDGuQlm+Ib9eot56PhQfXKDiji4diYyiO6ovatDgR8mEwufnrEVGPvxjCXH/Zn19T/VOeyZQvhFc5m5/D1xmj5aStK8bVPsr2rI8s7w00n+0dREaHAF30s92wPtUunqGKTiXA+bmY+QHHpF/AbbfiKyoFRARdZs7Y0Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745956445; c=relaxed/simple;
	bh=gqbEwfaQHa2IM7xHRmm2JpHx5tyibAgDXfBX+DHr/rA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B9nMp2hA6jkQlknC8z3sw1h6YQvsYd5PVwKgur5X1Ljf3n2rLCzpuIQsp3bguBOscK+3b6m+gOuOcYCnj3lddck65ifsxEjfn05iuYMD+2bsDEsDO8NqqRf5y8ujl0U3ZR6Bxq2rzWSnKBSLtr9PfofgucpKzJ+jC7X3G3p5ndc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ad6jX6Bg; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745956444; x=1777492444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gqbEwfaQHa2IM7xHRmm2JpHx5tyibAgDXfBX+DHr/rA=;
  b=ad6jX6BgL1N6m/9gV9M4iU9qtQ7ZEf16FE02g/Ey+otkaRxWk+pW0HhQ
   SKsKiqArBdAvqwe2Dj9xCFoxtHsT+3TEpp+Iw+4utFc/4Da7zFkbbhy3i
   qibY+6NBkskLyJPACLkfUB2ljRb6k7ufsMvie9KDGuBKC8f27nLpiz2/6
   AnlHIgxXl+2A33CTttQ8lzp7f/wKmzAG/akIldpH30Fvrz8apZCUoN2FT
   cRWa2NomnvlAst74NyrbdrTAUEORbpW2vjKf9/bS7CTFwQh/MZtbLnKWJ
   JgmV7MLyvjTcaGZZrCDof7mciAYquZjwRntHQN4wSOdG3ZifnHn3qIbKD
   w==;
X-CSE-ConnectionGUID: TOTYAPPIRA62DtLlz890uQ==
X-CSE-MsgGUID: 471ZG7QzSIeIETgD+UlNnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="46713485"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="46713485"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 12:54:04 -0700
X-CSE-ConnectionGUID: au/0P+ahQ/u3NIbbFWRysg==
X-CSE-MsgGUID: 5eK5f/ysThqWsPTVyn9c8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="171154978"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 12:54:03 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 02/14] wifi: iwlwifi: read WPFC also from UEFI
Date: Tue, 29 Apr 2025 22:53:32 +0300
Message-Id: <20250429224932.839a5e7dd89b.I491acbf68047874df97b3971f1ba692ebc998a52@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250429195344.254957-1-miriam.rachel.korenblit@intel.com>
References: <20250429195344.254957-1-miriam.rachel.korenblit@intel.com>
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


