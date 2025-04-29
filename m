Return-Path: <linux-wireless+bounces-22206-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40300AA1B9A
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 21:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9EF31898276
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 19:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD17718F2FC;
	Tue, 29 Apr 2025 19:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kDEZ6Zc6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3042025FA07
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 19:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745956444; cv=none; b=e4hwEKdheO/SfHFiwRgsqONdONZAZEA04AinLgoR8sEPB5NTDE7UyI3Y1JaO6ZecSkgolaXnN5vOFfldfCTBmVqa2jkuuFJyAFtots6+OVmtD+l7aFZ2i2OtDpnFRk4eZ6w86KysRpttYkz+mLzHGdMNhwMsY33jKiyBx8w0M7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745956444; c=relaxed/simple;
	bh=zhLNHZhHdfRfrfIXAdbmf1Xc0ndWkdQHZjgzj6zFBac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kGE65u/xzm2nK3iCK7rOIkvJPJ2hYMlvoL+2UY+tCIKFK3vzW0D8etPZtdv16978txgeBna4a0zO9RXbuQzWVfhxpqtUOeCx9XOiXbFOtyxisUeGXG7PzTqHc6GMhZvksc7L7R/ulob3Cii5Qn52L8lQEYjHEi5VM4v71OhJYPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kDEZ6Zc6; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745956443; x=1777492443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zhLNHZhHdfRfrfIXAdbmf1Xc0ndWkdQHZjgzj6zFBac=;
  b=kDEZ6Zc6b58lTsdVaNnbeEEsV+fAFajxmOHsgBoSKSfwj2XjXieh/6y1
   LCzr7c87/iuitQS8aLeiAr2f8FbbDXTm99Cq+IzqZcbF4QAeTT5sXiwGT
   B2XK8GJF2BsFCs3wc+JweBUfydQ9UpdBNmMlrLF0EPZwjLgbFh22Ad7Ut
   hPeLmkOTbPk4EBh6f5G/P0EZEfrLADoXHEtvvnskaCXyW5wM2dG6MG0qs
   iqvsfTpkQTQaXMaBfzLiUnu4+gtfOiNADqYkRbpUf2adRK5Cy6vl9E9EY
   anBLXZKZucb43S9IFwS6tdC8EuDc/JQa0Q3xOZxEXnKdNHDUcDYOrGhuG
   w==;
X-CSE-ConnectionGUID: SGlMo1ZMT1uv+q7Rlu1DPA==
X-CSE-MsgGUID: aE9PLg1iSG2jzffC6k66zA==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="46713466"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="46713466"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 12:54:02 -0700
X-CSE-ConnectionGUID: OQPPtnuOR1u+vFN+aM7INA==
X-CSE-MsgGUID: TdbGQiuVRmq4sBvwDckLpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="171154969"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 12:54:01 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH iwlwifi-next 01/14] wifi: iwlwifi: prepare for reading WPFC from UEFI
Date: Tue, 29 Apr 2025 22:53:31 +0300
Message-Id: <20250429224932.8046a2db775b.Ifbcf4168183d3cd635e3e800ec7ecd903e57d361@changeid>
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

IWL_BIOS_TABLE_LOADER generates the code that determines from what source
to read a BIOS table (ACPI or UEFI).
As we want to read WPFC from UEFI to, iwl_acpi_get_phy_filters needs to
have the prototype that is required by this macro:
receive fwrt and return a int on success/failure.
Do that.

This allowes us to make to version of iwl_acpi_get_phy_filters for non
ACPI builds back to an iniline function.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 19 +++++++++----------
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h | 11 ++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  |  2 +-
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index efa7b673ebc7..dfd5365995b6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2019-2024 Intel Corporation
+ * Copyright (C) 2019-2025 Intel Corporation
  */
 #include <linux/uuid.h>
 #include "iwl-drv.h"
@@ -919,40 +919,39 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 	return ret;
 }
 
-void iwl_acpi_get_phy_filters(struct iwl_fw_runtime *fwrt,
-			      struct iwl_phy_specific_cfg *filters)
+int iwl_acpi_get_phy_filters(struct iwl_fw_runtime *fwrt)
 {
+	struct iwl_phy_specific_cfg *filters = &fwrt->phy_filters;
 	struct iwl_phy_specific_cfg tmp = {};
-	union acpi_object *wifi_pkg, *data;
+	union acpi_object *wifi_pkg, *data __free(kfree);
 	int tbl_rev, i;
 
 	data = iwl_acpi_get_object(fwrt->dev, ACPI_WPFC_METHOD);
 	if (IS_ERR(data))
-		return;
+		return PTR_ERR(data);
 
 	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
 					 ACPI_WPFC_WIFI_DATA_SIZE,
 					 &tbl_rev);
 	if (IS_ERR(wifi_pkg))
-		goto out_free;
+		return PTR_ERR(wifi_pkg);
 
 	if (tbl_rev != 0)
-		goto out_free;
+		return -EINVAL;
 
 	BUILD_BUG_ON(ARRAY_SIZE(filters->filter_cfg_chains) !=
 		     ACPI_WPFC_WIFI_DATA_SIZE - 1);
 
 	for (i = 0; i < ARRAY_SIZE(filters->filter_cfg_chains); i++) {
 		if (wifi_pkg->package.elements[i + 1].type != ACPI_TYPE_INTEGER)
-			goto out_free;
+			return -EINVAL;
 		tmp.filter_cfg_chains[i] =
 			cpu_to_le32(wifi_pkg->package.elements[i + 1].integer.value);
 	}
 
 	IWL_DEBUG_RADIO(fwrt, "Loaded WPFC filter config from ACPI\n");
 	*filters = tmp;
-out_free:
-	kfree(data);
+	return 0;
 }
 IWL_EXPORT_SYMBOL(iwl_acpi_get_phy_filters);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index e50b93472dd2..68d8fb5f6357 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2023, 2025 Intel Corporation
  */
 #ifndef __iwl_fw_acpi__
 #define __iwl_fw_acpi__
@@ -180,8 +180,7 @@ int iwl_acpi_get_tas_table(struct iwl_fw_runtime *fwrt,
 
 int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt);
 
-void iwl_acpi_get_phy_filters(struct iwl_fw_runtime *fwrt,
-			      struct iwl_phy_specific_cfg *filters);
+int iwl_acpi_get_phy_filters(struct iwl_fw_runtime *fwrt);
 
 void iwl_acpi_get_guid_lock_status(struct iwl_fw_runtime *fwrt);
 
@@ -244,8 +243,10 @@ static inline int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 	return -ENOENT;
 }
 
-/* macro since the second argument doesn't always exist */
-#define iwl_acpi_get_phy_filters(fwrt, filters) do { } while (0)
+static inline int iwl_acpi_get_phy_filters(struct iwl_fw_runtime *fwrt)
+{
+	return -ENOENT;
+}
 
 static inline void iwl_acpi_get_guid_lock_status(struct iwl_fw_runtime *fwrt)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 94b08bb6fd4f..5bdd35b433e8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1265,7 +1265,7 @@ void iwl_mvm_get_bios_tables(struct iwl_mvm *mvm)
 		}
 	}
 
-	iwl_acpi_get_phy_filters(&mvm->fwrt, &mvm->fwrt.phy_filters);
+	iwl_acpi_get_phy_filters(&mvm->fwrt);
 
 	if (iwl_bios_get_eckv(&mvm->fwrt, &mvm->ext_clock_valid))
 		IWL_DEBUG_RADIO(mvm, "ECKV table doesn't exist in BIOS\n");
-- 
2.34.1


