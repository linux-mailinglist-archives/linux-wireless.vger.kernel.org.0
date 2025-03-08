Return-Path: <linux-wireless+bounces-20046-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A86F8A57E79
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 301E418926D8
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 21:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEC52BB13;
	Sat,  8 Mar 2025 21:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UrpFVtJA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147E61F5848
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 21:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741468782; cv=none; b=aT4D2C1yoF0E33a7xHeEWFhotE0HyzIX3GqfvdmFm26r/piyEihJhWwg7m1QP3xCMELW0yBgZ4XsUTTGKoY23NMMAyvc4Gutonwpnmksfmo3yPQRXpdN8h55F9PXGxMCLG7ueR58N2ZmhrYHmGiRcIeo05ZWY4gP1JgYwpKI/f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741468782; c=relaxed/simple;
	bh=fJEr3aww8jhIlGGUZnSWrFYY4mHTE0hyHSsWOgAwZRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hcPKufGK2iqLSXz2Y0o4cW0FHKye8X0Us9kD2CSiyVJXuPtWKKYJKVrJ2A9FNYC5QyyZ5brm1qxtIFaa+HT8GCljd42bJfIcjpyoRaLp8Csy6Q/JMhYEaOb0g/mK+8MkIIvIuzwt9n5U4p+19LfvPA9jZ4Xh+kbz9q4YCZQaigo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UrpFVtJA; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741468781; x=1773004781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fJEr3aww8jhIlGGUZnSWrFYY4mHTE0hyHSsWOgAwZRg=;
  b=UrpFVtJA116v33BNpGiyGV1+1zXoLT7g/u6ItXf7u7HBM45iy4T/T4DO
   h8MHf7lOJ3wl4UFlL55fKa5i3OkbKzOZgh7StBHnKFHEybOByatxUarBG
   x3v3Eeyi7VBuL+q0cGCPg4lVoqQejhRX/kr8H0vpI84j4gm6Mixt/Sk/U
   o1pZPaFGBbBG/5C1LicC1CvTRtHVXDgVIQaHS6rv7caYBmvfDkE5+bcfG
   JMMuqt/vc7Y6oidT9z1OLnhRspg2ZHe7a6K6feVzndhOBT/b8MBMl4OId
   hftOtSSa6UuRs8Fq2nzop13YaaMQykFQmEonJ5BqtebqgGL0w1AmU9Ozt
   g==;
X-CSE-ConnectionGUID: WbH3sFvXSxid00q0JYhPVQ==
X-CSE-MsgGUID: QNY2ovRjQlGKkThXxsWt4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="60052365"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="60052365"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:19:41 -0800
X-CSE-ConnectionGUID: igHzfLpZSiylB/3HUWi+KA==
X-CSE-MsgGUID: Xl/py0qUSPu+mzopzfpbuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="142859897"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:19:40 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v3 wireless-next 02/14] wifi: iwlwifi: fix the ECKV UEFI variable name
Date: Sat,  8 Mar 2025 23:19:13 +0200
Message-Id: <20250308231426.78c998d0fa71.I2bc9d72c1dc2c4d7028f0265634a940c2fadbbb5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308211925.2332313-1-miriam.rachel.korenblit@intel.com>
References: <20250308211925.2332313-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This UEFI variable name was badly named. Fix its name and also use the
right GUID to find it: we need to use the BT_WIFI (a.k.a. Common) GUID.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c | 8 +++++---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h | 4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 78bd0eb7aa92..b4438b1f8dad 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright(c) 2021-2024 Intel Corporation
+ * Copyright(c) 2021-2025 Intel Corporation
  */
 
 #include "iwl-drv.h"
@@ -681,8 +681,10 @@ int iwl_uefi_get_eckv(struct iwl_fw_runtime *fwrt, u32 *extl_clk)
 	struct uefi_cnv_var_eckv *data;
 	int ret = 0;
 
-	data = iwl_uefi_get_verified_variable(fwrt->trans, IWL_UEFI_ECKV_NAME,
-					      "ECKV", sizeof(*data), NULL);
+	data = iwl_uefi_get_verified_variable_guid(fwrt->trans,
+						   &IWL_EFI_WIFI_BT_GUID,
+						   IWL_UEFI_ECKV_NAME,
+						   "ECKV", sizeof(*data), NULL);
 	if (IS_ERR(data))
 		return -EINVAL;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 0c8943a8bd01..eb3c05417da3 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright(c) 2021-2024 Intel Corporation
+ * Copyright(c) 2021-2025 Intel Corporation
  */
 #ifndef __iwl_fw_uefi__
 #define __iwl_fw_uefi__
@@ -19,7 +19,7 @@
 #define IWL_UEFI_WTAS_NAME		L"UefiCnvWlanWTAS"
 #define IWL_UEFI_SPLC_NAME		L"UefiCnvWlanSPLC"
 #define IWL_UEFI_WRDD_NAME		L"UefiCnvWlanWRDD"
-#define IWL_UEFI_ECKV_NAME		L"UefiCnvWlanECKV"
+#define IWL_UEFI_ECKV_NAME		L"UefiCnvCommonECKV"
 #define IWL_UEFI_DSM_NAME		L"UefiCnvWlanGeneralCfg"
 #define IWL_UEFI_WBEM_NAME		L"UefiCnvWlanWBEM"
 #define IWL_UEFI_PUNCTURING_NAME	L"UefiCnvWlanPuncturing"
-- 
2.34.1


