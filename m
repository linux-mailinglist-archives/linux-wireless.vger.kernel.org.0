Return-Path: <linux-wireless+bounces-21993-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC47EA9ADB3
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 14:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1507F1940863
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 12:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3F227A91D;
	Thu, 24 Apr 2025 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k8v8IQwp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E202827BF6F
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498352; cv=none; b=F14Pz/6JHGuxwAnKxsJjmTVUfYP8GN1vBMw1+LvUDB+aOCGdooMtteO34k1pkfH9ThljtOEKUCJ9HYp7klhANsclEyFMit9Ch/cuXuGNYzkCWVCKXx0wKL+MZuUGlTFWq05MmGrJWe9/QACJmSsMFqKTewxcgvpNe/3f6ZmTxP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498352; c=relaxed/simple;
	bh=t84Gfum5Nl0/WaNofZaEgBJYQ3ccckl4yMEnsOYlehg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=stF9do/YFJaxTF39w3EWMcnIhydBB6YXTGLteG3uUh7n7z8lruFcnW8TugKl0nd+HZGBmAYq1Xvcaf5ZYB6lIYz8yh3TkuXPi75Sid8jaFPIfY4UXBk2clnvHLFD9omIjohmXoHBib31Z0Awjpb1Ei+h3VtfxzhX786rxCMEkR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k8v8IQwp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745498351; x=1777034351;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t84Gfum5Nl0/WaNofZaEgBJYQ3ccckl4yMEnsOYlehg=;
  b=k8v8IQwpZkJUt3kouZ/sXosKQ6dod9jLeAFIdWy1aDEuMCSpvkEiVCgQ
   HiSLjdO6SPaqXEN3Tv8erRITtN3lRWKb2twcFxLz6NvyC9MQv5hOjQ16c
   hU7G8OSK65zzIt2BeBBYoiYTgHknfqMA9rcVtgWC5T1m71Cb/Ie/ObYnQ
   e0kCZrQLKsb5JS3+5XLyEeJfkubPyNrWmDDDgs1hiEBNr2YT3luM604Cr
   /agBEuaER4zz2koiT0n4SxAIOrmjJpf0s5VvFoTuCY71o+eUueim4EcHC
   TjuoezXu0fgugoL66nZ0wccXJ2cUd6O0gYKYKpQsHBe9DALrAdk96z+Nc
   w==;
X-CSE-ConnectionGUID: 5ax4olV5T+SiPVmsjdjJPw==
X-CSE-MsgGUID: 11ayEwtXSg6T8Xsozoh7Kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47302458"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="47302458"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:39:10 -0700
X-CSE-ConnectionGUID: dQbI5POrQjed9ZBTqWpggg==
X-CSE-MsgGUID: 6oOh7n4iSbSRh/V8Hi8EIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="133137473"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:39:08 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next 14/14] wifi: iwlwifi: move phy_filters to fw_runtime
Date: Thu, 24 Apr 2025 15:38:31 +0300
Message-Id: <20250424153620.357baa65950a.I01d22328b4c381d4c0064ad9bd36750911157f90@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250424123831.3524359-1-miriam.rachel.korenblit@intel.com>
References: <20250424123831.3524359-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

phy_filters holds the values as read from WFPC BIOS table.
Since also iwlmld is going to need it, move it to fw_runtime.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h | 6 +++++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c     | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h    | 4 ----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index a9e6bba2419e..5753d95986cd 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 #ifndef __iwl_fw_runtime_h__
 #define __iwl_fw_runtime_h__
@@ -110,6 +110,7 @@ struct iwl_txf_iter_data {
  *	Only read the UEFI variables if locked.
  * @sar_profiles: sar profiles as read from WRDS/EWRD BIOS tables
  * @geo_profiles: geographic profiles as read from WGDS BIOS table
+ * @phy_filters: specific phy filters as read from WPFC BIOS table
  */
 struct iwl_fw_runtime {
 	struct iwl_trans *trans;
@@ -184,6 +185,9 @@ struct iwl_fw_runtime {
 	struct iwl_mcc_allowed_ap_type_cmd uats_table;
 	bool uats_valid;
 	u8 uefi_tables_lock_status;
+#ifdef CONFIG_ACPI
+	struct iwl_phy_specific_cfg phy_filters;
+#endif
 };
 
 void iwl_fw_runtime_init(struct iwl_fw_runtime *fwrt, struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index f67348acd5f0..94b08bb6fd4f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -473,7 +473,7 @@ static void iwl_mvm_phy_filter_init(struct iwl_mvm *mvm,
 				    struct iwl_phy_specific_cfg *phy_filters)
 {
 #ifdef CONFIG_ACPI
-	*phy_filters = mvm->phy_filters;
+	*phy_filters = mvm->fwrt.phy_filters;
 #endif /* CONFIG_ACPI */
 }
 
@@ -1265,7 +1265,7 @@ void iwl_mvm_get_bios_tables(struct iwl_mvm *mvm)
 		}
 	}
 
-	iwl_acpi_get_phy_filters(&mvm->fwrt, &mvm->phy_filters);
+	iwl_acpi_get_phy_filters(&mvm->fwrt, &mvm->fwrt.phy_filters);
 
 	if (iwl_bios_get_eckv(&mvm->fwrt, &mvm->ext_clock_valid))
 		IWL_DEBUG_RADIO(mvm, "ECKV table doesn't exist in BIOS\n");
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index f6391c7a3e29..1e3639fa6b27 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1348,10 +1348,6 @@ struct iwl_mvm {
 	__le16 cur_aid;
 	u8 cur_bssid[ETH_ALEN];
 
-#ifdef CONFIG_ACPI
-	struct iwl_phy_specific_cfg phy_filters;
-#endif
-
 	/* report rx timestamp in ptp clock time */
 	bool rx_ts_ptp;
 
-- 
2.34.1


