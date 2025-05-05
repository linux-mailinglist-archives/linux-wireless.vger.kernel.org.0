Return-Path: <linux-wireless+bounces-22562-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9611AAADF7
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 04:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF00F16EB37
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7250736DD59;
	Mon,  5 May 2025 22:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V26JGwWC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA493579F2;
	Mon,  5 May 2025 22:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485072; cv=none; b=sYKfgGH6nSlvhLPWqJZTKaXP0eaCktLqavQRbWFmQfr2zKarlGlq9xrZyVcfF2FsYS3FpkrZvFlxf+zbBCpZCd+Ed4uKmxQn7GaHBiNKL8aY2+7ULUvCRvqbwzu/E2BrJlPrpX+B27GwuU4zLDpg0k9Qp5sQiljc/GaelDuKIEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485072; c=relaxed/simple;
	bh=s8nuyD/LC8gZe7btAmMt72atSEIBM7IMwQfwJ8vRoFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PXMVhX+3KamqORcChegLG3xREIckVOqfAygQkEVdKd/h4yzmGSH2YNLvYT4hoq3/mRYlDLdYlkYkNIvE6m+xokUIaYOUip0wk2TRibsej39tX/3YmiNI/VpaYOPeZa/fN0LWoHc/puJ+qxs0951Rx4Ffqg9ME3MMW0su/xs5gQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V26JGwWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F43C4CEE4;
	Mon,  5 May 2025 22:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485071;
	bh=s8nuyD/LC8gZe7btAmMt72atSEIBM7IMwQfwJ8vRoFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V26JGwWC2eMqkZw4v97LZw2SYrZ+P4sazUJ3Pzkr6Jsiel3NXwiteu0sR+BIz7Kpc
	 xxwgcxPArzFIq/X2fwhSzEvEbd9i188CGciwGXPuYk3U3L2OHsQaurCHIwBfpgNv/4
	 ebFjJ504wvWcEjx5Dej3z+NpgUYm2Mw6oOB+P2IoxnTm/w5OQavB/jH/dPt+mFFICX
	 CTTLhtx3Fci+F78NaYO57PCTURoEEJmjlsD0QKvaz9ZNV/XWiOJ+O+crmsoZwlXZCc
	 Y6fEiJffNpkPTd9Vhofwvulg3Z2F7w2W9R5P00c3F12W1YX6Qx21JWC5+fQUJrWNEg
	 AAZkbVqqPeeOQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	pagadala.yesu.anjaneyulu@intel.com,
	daniel.gabay@intel.com,
	somashekhar.puttagangaiah@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 151/486] wifi: iwlwifi: fix the ECKV UEFI variable name
Date: Mon,  5 May 2025 18:33:47 -0400
Message-Id: <20250505223922.2682012-151-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit 3ea2970b0578011ab8402ad0cff39712255f63df ]

This UEFI variable name was badly named. Fix its name and also use the
right GUID to find it: we need to use the BT_WIFI (a.k.a. Common) GUID.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250308231426.78c998d0fa71.I2bc9d72c1dc2c4d7028f0265634a940c2fadbbb5@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c | 8 +++++---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h | 4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 834f7c9bb9e92..86d6286a15378 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright(c) 2021-2024 Intel Corporation
+ * Copyright(c) 2021-2025 Intel Corporation
  */
 
 #include "iwl-drv.h"
@@ -673,8 +673,10 @@ int iwl_uefi_get_eckv(struct iwl_fw_runtime *fwrt, u32 *extl_clk)
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
index e525d449e656e..c931f5cedb0b9 100644
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
2.39.5


