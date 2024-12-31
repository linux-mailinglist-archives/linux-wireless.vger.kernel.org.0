Return-Path: <linux-wireless+bounces-16941-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B035B9FEF40
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 13:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E5D1882F75
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 12:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4267319CC3C;
	Tue, 31 Dec 2024 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ltqJHtXo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CC619CC17
	for <linux-wireless@vger.kernel.org>; Tue, 31 Dec 2024 11:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735646384; cv=none; b=Lqzw4+UGVzu8w+RVTPlOgh3LuH/nM2+GegkpsTXOQkrrBc+vh66mZ7hjim8LS/UOmfXqi4NUnd3ICT91C9jUWcziiG4ruiDECgSHU2+OmOcN+LKAYjYtVPFSUx3ytOgdREY7UL6CfDO/DC9l0iFVDjDrToPablg+PeRJXDhBBYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735646384; c=relaxed/simple;
	bh=lOa+brQwrjHiQFeZfH2Xo8qMKqQ6o06EQWI1Fyi/TMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q97w6fdPFlRRwVKBZXgdzimbRPzCdEQfJWNX0UJl5ZMs6VrPARF5FsI4G+AwPWnUZiGde07urYU+RqCIoSSGlSmHK0sHOEy9tC1xip7JeJgmRRXTFB91lXHdicf0b14ahnjt1Jv7MBwaQNP9jTxzCoBxuuEm/E7JbUFfhC4Btsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ltqJHtXo; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735646383; x=1767182383;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lOa+brQwrjHiQFeZfH2Xo8qMKqQ6o06EQWI1Fyi/TMQ=;
  b=ltqJHtXoNoN3Zns0V35wSlJ1Inyqf7P82j3gGTS8OJxHrAvq+2MNyKcf
   Lkh3XTHDxoh4D4P85xysFPUJtU/+yaWAiqMu8OivAIp4t+/VvV4VKQMn3
   g80cJ5GGDXNBkQnuO3MtEOhnQdDvGDgf/roCMHhCoFYBuoZxeTn4I3/pT
   eP50xo5qw8jc4TSHmoMn2aqZnbn9Pz59gMkVobC3X+FMR0ierTUZlfYlh
   i7675WonHS1/t5GXcRPpxyStHWAuIWQdv5dxtPF4X5nxdSfmkhHkZ1uwD
   dUdJV2N9O1JODzpTGKFqn18GMLztmZalif7BBoxcyNr+yWLbEJr1mxZt+
   Q==;
X-CSE-ConnectionGUID: 72O3sBtQQmG+fmUoZPzeCQ==
X-CSE-MsgGUID: 7D+52viqRyC/N2EsLTV0VA==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="53330184"
X-IronPort-AV: E=Sophos;i="6.12,279,1728975600"; 
   d="scan'208";a="53330184"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:42 -0800
X-CSE-ConnectionGUID: dNHwv93mT6Oc29Omq/6VfA==
X-CSE-MsgGUID: +gyERCSWRqmZzLRI9i9eUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="138380312"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:42 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 09/15] wifi: iwlwifi: remove Mr/Ms radio
Date: Tue, 31 Dec 2024 13:59:09 +0200
Message-Id: <20241231135726.9f984db3efa0.I5a39ec951430e765bdea49ff150dd41af5e911f3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241231115915.1082656-1-miriam.rachel.korenblit@intel.com>
References: <20241231115915.1082656-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This radio never shipped, so we don't need to have it in the code.
Remove the configurations and a few lines of code for it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c       | 12 ------------
 drivers/net/wireless/intel/iwlwifi/iwl-config.h      |  1 -
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h         |  1 -
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c |  3 ---
 4 files changed, 17 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 4a76cffda488..dcba1a5d793b 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -31,15 +31,12 @@
 #define IWL_SO_A_GF_A_FW_PRE		"iwlwifi-so-a0-gf-a0"
 #define IWL_TY_A_GF_A_FW_PRE		"iwlwifi-ty-a0-gf-a0"
 #define IWL_SO_A_GF4_A_FW_PRE		"iwlwifi-so-a0-gf4-a0"
-#define IWL_SO_A_MR_A_FW_PRE		"iwlwifi-so-a0-mr-a0"
 #define IWL_MA_A_HR_B_FW_PRE		"iwlwifi-ma-a0-hr-b0"
 #define IWL_MA_A_GF_A_FW_PRE		"iwlwifi-ma-a0-gf-a0"
 #define IWL_MA_A_GF4_A_FW_PRE		"iwlwifi-ma-a0-gf4-a0"
-#define IWL_MA_A_MR_A_FW_PRE		"iwlwifi-ma-a0-mr-a0"
 #define IWL_MA_B_HR_B_FW_PRE		"iwlwifi-ma-b0-hr-b0"
 #define IWL_MA_B_GF_A_FW_PRE		"iwlwifi-ma-b0-gf-a0"
 #define IWL_MA_B_GF4_A_FW_PRE		"iwlwifi-ma-b0-gf4-a0"
-#define IWL_MA_B_MR_A_FW_PRE		"iwlwifi-ma-b0-mr-a0"
 
 #define IWL_SO_A_JF_B_MODULE_FIRMWARE(api) \
 	IWL_SO_A_JF_B_FW_PRE "-" __stringify(api) ".ucode"
@@ -251,13 +248,6 @@ const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0_long = {
 	.trans.low_latency_xtal = true,
 };
 
-const struct iwl_cfg iwl_cfg_so_a0_ms_a0 = {
-	.fw_name_pre = IWL_SO_A_MR_A_FW_PRE,
-	.uhb_supported = false,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
 const struct iwl_cfg iwl_cfg_ma = {
 	.fw_name_mac = "ma",
 	.uhb_supported = true,
@@ -278,8 +268,6 @@ IWL_FW_AND_PNVM(IWL_TY_A_GF_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
 MODULE_FIRMWARE(IWL_MA_A_HR_B_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 IWL_FW_AND_PNVM(IWL_MA_A_GF_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_MA_A_GF4_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
-IWL_FW_AND_PNVM(IWL_MA_A_MR_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
 MODULE_FIRMWARE(IWL_MA_B_HR_B_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 IWL_FW_AND_PNVM(IWL_MA_B_GF_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_MA_B_GF4_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
-IWL_FW_AND_PNVM(IWL_MA_B_MR_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index fa4f3ece58b2..95894c214dd8 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -660,7 +660,6 @@ extern const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0_long;
 extern const struct iwl_cfg iwl_cfg_ma;
 
 extern const struct iwl_cfg iwl_cfg_so_a0_hr_a0;
-extern const struct iwl_cfg iwl_cfg_so_a0_ms_a0;
 extern const struct iwl_cfg iwl_cfg_quz_a0_hr_b0;
 
 extern const struct iwl_cfg iwl_cfg_bz;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index b4462bc1cf22..be9e464c9b7b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -353,7 +353,6 @@ enum {
 #define CSR_HW_RF_ID_TYPE_HRCDB		(0x00109F00)
 #define CSR_HW_RF_ID_TYPE_GF		(0x0010D000)
 #define CSR_HW_RF_ID_TYPE_GF4		(0x0010E000)
-#define CSR_HW_RF_ID_TYPE_MS		(0x00111000)
 #define CSR_HW_RF_ID_TYPE_FM		(0x00112000)
 #define CSR_HW_RF_ID_TYPE_WP		(0x00113000)
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 3677e0154888..9bcdca2b19eb 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -294,9 +294,6 @@ static void iwl_pcie_get_rf_name(struct iwl_trans *trans)
 	case CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_HRCDB):
 		pos = scnprintf(buf, buflen, "HRCDB");
 		break;
-	case CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_MS):
-		pos = scnprintf(buf, buflen, "MS");
-		break;
 	case CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_FM):
 		pos = scnprintf(buf, buflen, "FM");
 		break;
-- 
2.34.1


