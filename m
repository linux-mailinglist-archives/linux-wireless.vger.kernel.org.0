Return-Path: <linux-wireless+bounces-18522-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB2BA28AFB
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 13:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD5F3A0561
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 12:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E0125776;
	Wed,  5 Feb 2025 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Af5KDgge"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF13BA38
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760175; cv=none; b=GGaxAG9sKPu0o8GqcQUpuiUMkQDDVpAgMoI1snvqYsnczrQkJ6FCeG1POLZkM29MVRQ8mjbpcumt6QNLfHyT8z+zW89C0ndzgv47UX5iHwiFLnhpH1wT0K05/pCmuTVZq+KX0FtlHHJNhWfKF2uwUwlE1HTad3/w2A5XMia0Ruo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760175; c=relaxed/simple;
	bh=LeUDdSLZJ3atIByDBVKGnS0GjOE2KvpgksMwY0jD1wM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GNNNL91jeujbN/AaqxiJzETblsuHUEpqh2EyL4VHsemLpPn6O3YH8dQKWihwYLb1uVveSLOmfkOnR0MGnnjEDJL1JXlzqrD6WcN5LCUo+6RFSn1o43VHfiGUAzwkxcshlIQjbS92fD3kGKjmWZos3Rvxg2SuD+oG1uyzs0nXbJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Af5KDgge; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738760173; x=1770296173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LeUDdSLZJ3atIByDBVKGnS0GjOE2KvpgksMwY0jD1wM=;
  b=Af5KDggeelnf3jg4eMqI35IZxCZ3iIgnVbx83WRWAKenTJTiBUxrCL6L
   iPlBl4Z7KlE5DsMz0zNsnL3YzSMZeMytfiGRIYwjtdcrZutkxeJyq+I5S
   km3oxUFwrqzQ6P0bMh9ISfJiQOb3GPrDebK6GfE9gmVbt8YINM8tsX0G6
   ex8iPLvfpr26Vz8H4lF0FnU7mro48fugMSO22jHUd5yM+syX6J0HjEag+
   TbupOMmSl/rg0bKE+JThyp1It8LIODZS8M9xOcHcTupd0JaGXrzPTCpfq
   5RNRQuMQGaNkzDwDS7fyuzD9da+BmaffzVFVIkqEvVvjXkWW3DvStkm/U
   Q==;
X-CSE-ConnectionGUID: lRdMrVw1QMCS5/7B31Fx8A==
X-CSE-MsgGUID: +g4w2AfqRFq0GyPvjZmVoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42159176"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="42159176"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:13 -0800
X-CSE-ConnectionGUID: mIa1FutGQ0afarMo8x4aAQ==
X-CSE-MsgGUID: fba3Wf2DTh6LmQ8PsX6F0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110745457"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:12 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 05/19] wifi: iwlwifi: Unify TAS block list handling in regulatory.c
Date: Wed,  5 Feb 2025 14:55:34 +0200
Message-Id: <20250205145347.157d26fb7f02.I87e20e967835bc895be390daf1c6637e20b52aae@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
References: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Created a common function iwl_add_mcc_to_tas_block_list() to handle the
operations previously performed by iwl_mld_add_to_tas_block_list() and
iwl_mvm_add_to_tas_block_list(). moved this new function to regulatory.c
to better reflect its purpose and improve code organization.

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 18 +++++++++++++++++
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 20 ++-----------------
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 63320689e05d..11f54339acc6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -456,6 +456,24 @@ iwl_parse_tas_selection(const u32 tas_selection_in, const u8 tbl_rev)
 }
 IWL_EXPORT_SYMBOL(iwl_parse_tas_selection);
 
+bool iwl_add_mcc_to_tas_block_list(u16 *list, u8 *size, u16 mcc)
+{
+	for (int i = 0; i < *size; i++) {
+		if (list[i] == mcc)
+			return true;
+	}
+
+	/* Verify that there is room for another country
+	 * If *size == IWL_WTAS_BLACK_LIST_MAX, then the table is full.
+	 */
+	if (*size >= IWL_WTAS_BLACK_LIST_MAX)
+		return false;
+
+	list[*size++] = mcc;
+	return true;
+}
+IWL_EXPORT_SYMBOL(iwl_add_mcc_to_tas_block_list);
+
 static __le32 iwl_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
 {
 	int ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index ed61bc35ef5b..d978a4fadfae 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -192,6 +192,7 @@ int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
 bool iwl_is_ppag_approved(struct iwl_fw_runtime *fwrt);
 
 bool iwl_is_tas_approved(void);
+bool iwl_add_mcc_to_tas_block_list(u16 *list, u8 *size, u16 mcc);
 
 struct iwl_tas_selection_data
 iwl_parse_tas_selection(const u32 tas_selection, const u8 tbl_rev);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 5a9ce7dba714..822244b87df3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1094,22 +1094,6 @@ static int iwl_mvm_ppag_init(struct iwl_mvm *mvm)
 	return iwl_mvm_ppag_send_cmd(mvm);
 }
 
-static bool
-iwl_mvm_add_to_tas_block_list(u16 *list, u8 *size, u16 mcc)
-{
-	/* Verify that there is room for another country */
-	if (*size >= IWL_WTAS_BLACK_LIST_MAX)
-		return false;
-
-	for (u8 i = 0; i < *size; i++) {
-		if (list[i] == mcc)
-			return true;
-	}
-
-	list[*size++] = mcc;
-	return true;
-}
-
 static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 {
 	u32 cmd_id = WIDE_ID(REGULATORY_AND_NVM_GROUP, TAS_CONFIG);
@@ -1150,10 +1134,10 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 		IWL_DEBUG_RADIO(mvm,
 				"System vendor '%s' is not in the approved list, disabling TAS in US and Canada.\n",
 				dmi_get_system_info(DMI_SYS_VENDOR) ?: "<unknown>");
-		if ((!iwl_mvm_add_to_tas_block_list(data.block_list_array,
+		if ((!iwl_add_mcc_to_tas_block_list(data.block_list_array,
 						    &data.block_list_size,
 						    IWL_MCC_US)) ||
-		    (!iwl_mvm_add_to_tas_block_list(data.block_list_array,
+		    (!iwl_add_mcc_to_tas_block_list(data.block_list_array,
 						    &data.block_list_size,
 						    IWL_MCC_CANADA))) {
 			IWL_DEBUG_RADIO(mvm,
-- 
2.34.1


