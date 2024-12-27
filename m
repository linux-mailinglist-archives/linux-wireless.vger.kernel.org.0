Return-Path: <linux-wireless+bounces-16828-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FDB9FD1B7
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 09:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72CB63A06A7
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 08:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126645D8F0;
	Fri, 27 Dec 2024 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DWmPsG2B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F86E15382E
	for <linux-wireless@vger.kernel.org>; Fri, 27 Dec 2024 08:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286496; cv=none; b=fAyLm5m6ZKhO4osY4D/IshFbniJI3NTahmqAPSW+6AJSfgBmLHFOU+IW/omXEhOsQD35bAVWgPed+g+Dz9pgy93MW0KvGhO+kra/qIvNhx8A0/RHiW11d5Ju1JCFoD77UojM2EjzvKFs8Zu+iB56eiG4B11MeBncx8hTVHL4sKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286496; c=relaxed/simple;
	bh=kRJeSXbhmr+YWLFcm8QnV0f05WYwVNrtA8FXxqAPkDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cXSIMkd5ueYDysnkmgJEzCeW+1AucWz67+bWplXel4go2p3wjFbU1uQAWF15hM5eQwcxpFe9+9cZ4E4LtIW/CXsNj+zxt1lBgotrljetOIRQ5uHJlr8Mq8q3ULYQQ2hyIispuDGOQmo6IhlCa7X5l9GlgpjEaD2UMJKBG38uNl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DWmPsG2B; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735286494; x=1766822494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kRJeSXbhmr+YWLFcm8QnV0f05WYwVNrtA8FXxqAPkDI=;
  b=DWmPsG2BR2APUzuTlVahE2qUhzw77bRWd1fHyWMXQVey29ZYBFjJmWfw
   V54szove+qtD1Fj5pLNBFaBI6J/cVrU+D7vdj4ZdygO75r9Rpy3wEoqG4
   RxxsqGkit2wOmwHsLAqqBDoILyQXepMdv9MJvheUtEbKeqkywkun1t6UE
   K8dvgZXTt+OEQbk8jQbUBl8H1JQ+OXK8VNoeZcinM1kLcK+zQBd2ONNhP
   YugjyDWOrhSf6+ZyV+Spcawhdosvay24sJr5vN8kqYnxW79ejx0+J3py6
   1rslm0yBMI3eoz/Zv8PT8ZvpbDO9sXPxuiC176qJxWjDjr7O7PYWcS5Hi
   w==;
X-CSE-ConnectionGUID: GvLTOBP0RYCO+4E9w8qkJQ==
X-CSE-MsgGUID: aV4Z7sIlTcS1v6DYywlEhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="46690934"
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="46690934"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:34 -0800
X-CSE-ConnectionGUID: xAg8iKXKQN+6/BsOWUPzow==
X-CSE-MsgGUID: q7Oszw2yRX2Rts7mhaftcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="99858254"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:32 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH 06/17] wifi: iwlwifi: fw: read STEP table from correct UEFI var
Date: Fri, 27 Dec 2024 10:01:01 +0200
Message-Id: <20241227095718.89a5ad921b6d.Idae95a70ff69d2ba1b610e8eced826961ce7de98@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241227080112.1098419-1-miriam.rachel.korenblit@intel.com>
References: <20241227080112.1098419-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This variable exists for the "common" (WiFi/BT) GUID, not the
WiFi-only GUID. Fix that by passing the GUID to the function.
A short-cut for the wifi-only version remains so not all code
must be updated.

However, rename the GUID defines to be clearer.

Fixes: 09b4c35d73a5 ("wifi: iwlwifi: mvm: Support STEP equalizer settings from BIOS.")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c | 44 +++++++++++++-------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index dcbb3c387c10..02df96c3aa51 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -13,9 +13,12 @@
 #include <linux/efi.h>
 #include "fw/runtime.h"
 
-#define IWL_EFI_VAR_GUID EFI_GUID(0x92daaf2f, 0xc02b, 0x455b,	\
-				  0xb2, 0xec, 0xf5, 0xa3,	\
-				  0x59, 0x4f, 0x4a, 0xea)
+#define IWL_EFI_WIFI_GUID	EFI_GUID(0x92daaf2f, 0xc02b, 0x455b,	\
+					 0xb2, 0xec, 0xf5, 0xa3,	\
+					 0x59, 0x4f, 0x4a, 0xea)
+#define IWL_EFI_WIFI_BT_GUID	EFI_GUID(0xe65d8884, 0xd4af, 0x4b20,	\
+					 0x8d, 0x03, 0x77, 0x2e,	\
+					 0xcc, 0x3d, 0xa5, 0x31)
 
 struct iwl_uefi_pnvm_mem_desc {
 	__le32 addr;
@@ -61,7 +64,7 @@ void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
 
 	*len = 0;
 
-	data = iwl_uefi_get_variable(IWL_UEFI_OEM_PNVM_NAME, &IWL_EFI_VAR_GUID,
+	data = iwl_uefi_get_variable(IWL_UEFI_OEM_PNVM_NAME, &IWL_EFI_WIFI_GUID,
 				     &package_size);
 	if (IS_ERR(data)) {
 		IWL_DEBUG_FW(trans,
@@ -76,18 +79,18 @@ void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
 	return data;
 }
 
-static
-void *iwl_uefi_get_verified_variable(struct iwl_trans *trans,
-				     efi_char16_t *uefi_var_name,
-				     char *var_name,
-				     unsigned int expected_size,
-				     unsigned long *size)
+static void *
+iwl_uefi_get_verified_variable_guid(struct iwl_trans *trans,
+				    efi_guid_t *guid,
+				    efi_char16_t *uefi_var_name,
+				    char *var_name,
+				    unsigned int expected_size,
+				    unsigned long *size)
 {
 	void *var;
 	unsigned long var_size;
 
-	var = iwl_uefi_get_variable(uefi_var_name, &IWL_EFI_VAR_GUID,
-				    &var_size);
+	var = iwl_uefi_get_variable(uefi_var_name, guid, &var_size);
 
 	if (IS_ERR(var)) {
 		IWL_DEBUG_RADIO(trans,
@@ -112,6 +115,18 @@ void *iwl_uefi_get_verified_variable(struct iwl_trans *trans,
 	return var;
 }
 
+static void *
+iwl_uefi_get_verified_variable(struct iwl_trans *trans,
+			       efi_char16_t *uefi_var_name,
+			       char *var_name,
+			       unsigned int expected_size,
+			       unsigned long *size)
+{
+	return iwl_uefi_get_verified_variable_guid(trans, &IWL_EFI_WIFI_GUID,
+						   uefi_var_name, var_name,
+						   expected_size, size);
+}
+
 int iwl_uefi_handle_tlv_mem_desc(struct iwl_trans *trans, const u8 *data,
 				 u32 tlv_len, struct iwl_pnvm_image *pnvm_data)
 {
@@ -311,8 +326,9 @@ void iwl_uefi_get_step_table(struct iwl_trans *trans)
 	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		return;
 
-	data = iwl_uefi_get_verified_variable(trans, IWL_UEFI_STEP_NAME,
-					      "STEP", sizeof(*data), NULL);
+	data = iwl_uefi_get_verified_variable_guid(trans, &IWL_EFI_WIFI_BT_GUID,
+						   IWL_UEFI_STEP_NAME,
+						   "STEP", sizeof(*data), NULL);
 	if (IS_ERR(data))
 		return;
 
-- 
2.34.1


