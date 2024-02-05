Return-Path: <linux-wireless+bounces-3167-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2162784A6D3
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 22:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541981C2678F
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 21:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A499B57896;
	Mon,  5 Feb 2024 19:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xi/bQ132"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011F65788D
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 19:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160905; cv=none; b=iDap41AwKn4jqk2yFws0Kk/nixV1VLEysY3Kqe1DbmRGEcnkZRd3MVf044cdKPAUwRrqDKrUAVFB4v5HIkt+G6Vt6v7fFIZw/9hSRoVioAeE5TfwUehCyEmBpodMEO9D89vsF7jIkXAbEYcc+oVAthpkuBl+Ee3i4cOLkkzw9IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160905; c=relaxed/simple;
	bh=p/qf8w62eiiZHijuwbPYUtkSrZmjTtPocST9jgJ5Yzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=leEF0cDDhBvv3x+o5NTPNMqcjTkeg+uDXu+KYBh2FPlLvM89fBj+vcTm51qypqvkNSE5bJmJwORAX/THZ00++RKXxKvnGONJLw20i9hBVlmKtRt2AYXntEY7mNtDNF01L9wTkPszMEKO7v4+NVOCn9+SC21IykPbR/FsTN/Rhr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xi/bQ132; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707160904; x=1738696904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p/qf8w62eiiZHijuwbPYUtkSrZmjTtPocST9jgJ5Yzk=;
  b=Xi/bQ132p1Cy1cO52oGb/5szbcUmpFH+qFKypeBsugHtjg9XsDxzvY/D
   9CT3kGU9n3JYi7fMVZAeFycEzlDBeDOBJ3XyvYJQIyScdMpAXJHaUbF9H
   qEpwvYGdKr0c0H6LMXyqHHt7l5GSMPW5dZeaz7U8fxDr+QiT4hl17DOQi
   EDJ9nLaOpjeBZ+OpeMV24ZNLsxzWhmtqvDg+zuPBxvovK6hH4hBNcTLFu
   3T6otIIBj/T8o8WPkyNf0YumNfgynZGPqVjVMFkFMIsMULLz38mw5E9lo
   5xZ4M15lw+YFYGaw9rtbt1TgoNKUGtur6kU3dP8gbCCYKADpBclrMbpX8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4381581"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="4381581"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:21:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5403090"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:21:42 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 04/15] wifi: iwlwifi: take SGOM and UATS code out of ACPI ifdef
Date: Mon,  5 Feb 2024 21:21:04 +0200
Message-Id: <20240205211151.dcaa3325773f.I649079c842369dcae3a362842322deca422a61d5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205192115.2320146-1-miriam.rachel.korenblit@intel.com>
References: <20240205192115.2320146-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The BIOS tables SGOM and UATS are read from UEFI, but require
additional tables (WGDS and DSM func 3, respectively) which used to be
read from ACPI only, so the code handling those tables had to be under
ifdef ACPI. But now the driver reads those tables (WGDS and DSM) from
both ACPI and UEFI, so SGOM and UATS code shouldn't be under ifdef ACPI
anymore.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h |  4 +---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c    |  4 +---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c     | 14 +-------------
 3 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index bd0c9b2224e1..b2bc4fd37abf 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 #ifndef __iwl_fw_runtime_h__
 #define __iwl_fw_runtime_h__
@@ -175,11 +175,9 @@ struct iwl_fw_runtime {
 	struct iwl_ppag_chain ppag_chains[IWL_NUM_CHAIN_LIMITS];
 	u32 ppag_flags;
 	u8 ppag_ver;
-#ifdef CONFIG_ACPI
 	struct iwl_sar_offset_mapping_cmd sgom_table;
 	bool sgom_enabled;
 	struct iwl_uats_table_cmd uats_table;
-#endif
 	u8 uefi_tables_lock_status;
 	bool uats_enabled;
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 39015a222f96..f3d54c82814b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright(c) 2021-2023 Intel Corporation
+ * Copyright(c) 2021-2024 Intel Corporation
  */
 
 #include "iwl-drv.h"
@@ -324,7 +324,6 @@ void iwl_uefi_get_step_table(struct iwl_trans *trans)
 }
 IWL_EXPORT_SYMBOL(iwl_uefi_get_step_table);
 
-#ifdef CONFIG_ACPI
 static int iwl_uefi_sgom_parse(struct uefi_cnv_wlan_sgom_data *sgom_data,
 			       struct iwl_fw_runtime *fwrt)
 {
@@ -412,7 +411,6 @@ int iwl_uefi_get_uats_table(struct iwl_trans *trans,
 	return 0;
 }
 IWL_EXPORT_SYMBOL(iwl_uefi_get_uats_table);
-#endif /* CONFIG_ACPI */
 
 static void iwl_uefi_set_sar_profile(struct iwl_fw_runtime *fwrt,
 				     struct uefi_sar_profile *uefi_sar_prof,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index b596a1a83750..5381afdd4021 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -488,7 +488,6 @@ static void iwl_mvm_phy_filter_init(struct iwl_mvm *mvm,
 #endif /* CONFIG_ACPI */
 }
 
-#if defined(CONFIG_ACPI) && defined(CONFIG_EFI)
 static void iwl_mvm_uats_init(struct iwl_mvm *mvm)
 {
 	u8 cmd_ver;
@@ -568,17 +567,6 @@ static int iwl_mvm_sgom_init(struct iwl_mvm *mvm)
 
 	return ret;
 }
-#else
-
-static int iwl_mvm_sgom_init(struct iwl_mvm *mvm)
-{
-	return 0;
-}
-
-static void iwl_mvm_uats_init(struct iwl_mvm *mvm)
-{
-}
-#endif
 
 static int iwl_send_phy_cfg_cmd(struct iwl_mvm *mvm)
 {
-- 
2.34.1


