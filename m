Return-Path: <linux-wireless+bounces-22244-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B1AAA4B01
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 14:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0314B4A7624
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 12:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FCE25A2B0;
	Wed, 30 Apr 2025 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BbyFv06R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AEC214223
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746015886; cv=none; b=RXGoQMpfA+/MoFddzBu6rQ6fBhZMPc9zdsSSit8obPztlWVN18BNACw3BQpGYdiQxKlcsB+1Y4P+s+TLQp+NKzMvp7/wGz0d0tC5ZrY2JBfr4r2u9LMZpPH+OSg0zLBoDP9iHZJa2RlLhqQ0h7EsLOP/yVY6hdnHwQz+hxykgU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746015886; c=relaxed/simple;
	bh=zhLNHZhHdfRfrfIXAdbmf1Xc0ndWkdQHZjgzj6zFBac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jaHclkwWCD4dKYIkHZ0ZgXMd+WzNwCG7zKLRr2WkHz3/6WWROy0qS8NzbwCejthfLIubnhHe8LLbPyfdSJhibQwF7uArRrgeXd06fISF1QZ8p/ojAa+qKqioKLgXXelAdg/Z3WqsZo0892PoH0mwF4AJcnRVv0MVLnSCTV+a6g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BbyFv06R; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746015884; x=1777551884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zhLNHZhHdfRfrfIXAdbmf1Xc0ndWkdQHZjgzj6zFBac=;
  b=BbyFv06RhvrTKsLCO2+DWdijG86eKRF7RLQmpZHiJV0/FqSa1+rWTo4f
   jcJwbvhx1ECitxDld2SSgG4bf+RqDl5GgmzhVbCc2jDXyAD66hNe8oerm
   Sd/HWMZLEttRZ0DQI2SRQ1hMSAUs632AZLUR1+BBDqKhGfp5O5M8vNxgT
   b2FBw+2TlNtBxOwTITZ9HGqpW9y+LJNOdGXtNGbu1aZMKwHFbKb9eWANM
   wqo91Nizp0lVaPYr8IwmL3lJRw0WUK115lhTSXH71eKh3qdUxqtVaQz04
   CJg2ED8PFwDl79W2pyhD2igBrhuLnwICy66RKxxQCLfbEEHNH6BysO75M
   A==;
X-CSE-ConnectionGUID: ErfRfuBSS7OGUdH69f4s0Q==
X-CSE-MsgGUID: 9hOIhV4nSyOY/DT/mbkTGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47578258"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="47578258"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:24:43 -0700
X-CSE-ConnectionGUID: j8uFsiBIRv2wMMQ5ukmCxg==
X-CSE-MsgGUID: fftpLHg6TeauKQlbXBTdEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="135087840"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:24:43 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH v2 iwlwifi-next 01/14] wifi: iwlwifi: prepare for reading WPFC from UEFI
Date: Wed, 30 Apr 2025 15:23:07 +0300
Message-Id: <20250430151952.8046a2db775b.Ifbcf4168183d3cd635e3e800ec7ecd903e57d361@changeid>
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


