Return-Path: <linux-wireless+bounces-19946-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D8DA55950
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 23:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD4EA16702D
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 22:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A086F207DEB;
	Thu,  6 Mar 2025 22:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hvhFAbZk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03EB1E5B86
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 22:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298720; cv=none; b=gUmYKflQsUqLBMhITcFzM05b/Pfypo0p3SZjzRGQ5CKK+BGcvtORQtdj0d+s37HDlFzbiL8II0/4gCu2KGYprylEpOyOKRPk59k6ZVtC9SRv8dmscFnk/VGtMmcsSq+CI2qer6qmrWS4ROdtWH4WxZ7yJIANmG/0x7luKm7SLrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298720; c=relaxed/simple;
	bh=fJEr3aww8jhIlGGUZnSWrFYY4mHTE0hyHSsWOgAwZRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ntr2y8Wsdh206zaspk2ZjolzC3iV71m0iP30vdRBdSSGXWI1zVR67ALthrzFFteVXTAX8PPcQIEA+upjFc27tndNPYLP8e+UqKDWBvZ/NkrvYqjPuu+11BZ7bZi4ZX2v34OPDlldYvPVrtuBas18yqrv08iF5haAVK928ZXthAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hvhFAbZk; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741298719; x=1772834719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fJEr3aww8jhIlGGUZnSWrFYY4mHTE0hyHSsWOgAwZRg=;
  b=hvhFAbZkHsYGR2/AGeNd34FSnAWsCmrqe2FpJ0VXfM1p5GnfVQmD7HfX
   MJC4JLaWBafks5hdk1tZtC4LkkXBqWImekueGO9vT8ki0VETiyITVNdEi
   cZgCvWeu4a97WHHG5N96oLez2q2tBIdJj11xJvbRLNdv2KsTeN5oks1+U
   peZMwxTMT2hvvxQlBR9ZyNmqI8L8p9rL7YQUo0y4Wa9BNCyQxC/ibOnTs
   rq7/AbAVB1Vf5gPKIZFSPosymCiU9UT301O33O9s9B2jkS1dwRhPo8lJe
   7PXC4W1Wlc25/UmoeNorSc9LJpn3ZwW5omcDM5Lvh5zVJqWLsa6TlXj1T
   A==;
X-CSE-ConnectionGUID: G33E13ggQiefe4b9gol8Iw==
X-CSE-MsgGUID: a1wqT3UXTpe9rDXi0LewVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42474258"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42474258"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:05:18 -0800
X-CSE-ConnectionGUID: ls9/jshTSFGUKzmzBLSBkw==
X-CSE-MsgGUID: RLmKC5PRR66sp5LGGFK7bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120061876"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:05:09 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next 03/15] wifi: iwlwifi: fix the ECKV UEFI variable name
Date: Fri,  7 Mar 2025 00:04:42 +0200
Message-Id: <20250307000213.d819631a06b3.I2bc9d72c1dc2c4d7028f0265634a940c2fadbbb5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306220454.543262-1-miriam.rachel.korenblit@intel.com>
References: <20250306220454.543262-1-miriam.rachel.korenblit@intel.com>
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


