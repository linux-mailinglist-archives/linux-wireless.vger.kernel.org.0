Return-Path: <linux-wireless+bounces-22472-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A24AA9C19
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 20:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13F13BEEDE
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 18:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FB91C1F12;
	Mon,  5 May 2025 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gtB3XP4b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B2925D539
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 18:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471444; cv=none; b=occC6aahD5YybVdRyfkBX5wl8g6SGJV10UZx9CSA4tv94S6KPn/AUb7iH4Mu0eL6Xh4LUgMBXfkkbHmDSGMc3hXViKXUuW7JaBH3GuJtXTsTLr8qCnsDUo7vip0Q/Dkh3FTG3Ime3lxwm5CqC5w1D/aFKH2GmwgwauQYof3IV6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471444; c=relaxed/simple;
	bh=Ap1vM8BNe5/iVsIJX8pRxPbvcfm2pw3VH5+1jdtJ+DM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cu8OuHKbPCRklQHU+AeVuxCOyH8XAxGfCRjlRs3saff7YmxMsLNoLGvcKFLFhFg5ObG0T0H3944DDMLv4eGGFEGes05nhg4m3ooE2qfHQ989iJFBlhrmdtCfipFT6+/52Cl598Il7axL5qYTIyIj5Xdo/pq8NzSpuAKcSAdK3SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gtB3XP4b; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746471442; x=1778007442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ap1vM8BNe5/iVsIJX8pRxPbvcfm2pw3VH5+1jdtJ+DM=;
  b=gtB3XP4bACT574wYfeiPwvvs7rWLHD9Jebe4jLKBU710EQS9GyU9W3Do
   7ydigKE3rjaB/jLqh7BDEK1M4qayQ3clhcAWVoXw3DxDi71YN1Kob5Rse
   NXxr5MuRMfR8GFyLQO2hgtAb2xB7L23JrOBH2d+as1lavubOtoypALrBQ
   +LFRnatWkZ9HXbyFqiDPtK/8plBj9kLOrNtQLVS6WlLPKExd89I4THzuo
   kP2hYb74Uxui5FjpePTWxWQp1FzyHG0FBDodTzCmJVmC1PRp0MCj3UDVi
   L5nq5Co5kZtoKnWtKZ3tMjJAHe8HDOn+yorU6g9jiS1zopxQH48XT8ERl
   g==;
X-CSE-ConnectionGUID: vMrrJWgQQk+8GMaVskTttg==
X-CSE-MsgGUID: a5M46lxyT5uKvUH6eto3ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="47359452"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="47359452"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:22 -0700
X-CSE-ConnectionGUID: PYUj+VpoSUKR9c6Y7OSmJw==
X-CSE-MsgGUID: fkVFYC86SeCbXai+UpBXGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="135698006"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:21 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: debug: set CDB indication from CSR
Date: Mon,  5 May 2025 21:56:48 +0300
Message-Id: <20250505215513.ea542a6c189e.I3d8cf5103b3747dfdd89985b45b592e419f97b63@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250505185654.2068339-1-miriam.rachel.korenblit@intel.com>
References: <20250505185654.2068339-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

In order to set the CDB indication in the dump meta data, we read it from
a specific prph register.
There is a known issue with that register in Xnj setups - in that case it
will always indicate CDB.
Instead of detecting the jacket case and then hardcode whether the CDB
indication should or shouldn't be set (according the CRF),
we can retrieve the CDB bit from the hw_rf_id (CSR_HW_RF_ID).
There is also no reason to do it conditionally only for ax210 / BnJ.
Cleanup the code a bit.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 25 ++++++-------------
 .../wireless/intel/iwlwifi/fw/error-dump.h    |  7 ++----
 2 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index bc60ffe43279..4d49c82d5093 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2376,7 +2376,7 @@ static u32 iwl_dump_ini_info(struct iwl_fw_runtime *fwrt,
 	struct iwl_fw_ini_dump_cfg_name *cfg_name;
 	u32 size = sizeof(*tlv) + sizeof(*dump);
 	u32 num_of_cfg_names = 0;
-	u32 hw_type;
+	u32 hw_type, is_cdb, is_jacket;
 
 	list_for_each_entry(node, &fwrt->trans->dbg.debug_info_tlv_list, list) {
 		size += sizeof(*cfg_name);
@@ -2406,24 +2406,15 @@ static u32 iwl_dump_ini_info(struct iwl_fw_runtime *fwrt,
 
 	dump->hw_step = cpu_to_le32(fwrt->trans->info.hw_rev_step);
 
-	/*
-	 * Several HWs all have type == 0x42, so we'll override this value
-	 * according to the detected HW
-	 */
 	hw_type = CSR_HW_REV_TYPE(fwrt->trans->info.hw_rev);
-	if (hw_type == IWL_AX210_HW_TYPE) {
-		u32 prph_val = iwl_read_umac_prph(fwrt->trans, WFPM_OTP_CFG1_ADDR);
-		u32 is_jacket = !!(prph_val & WFPM_OTP_CFG1_IS_JACKET_BIT);
-		u32 is_cdb = !!(prph_val & WFPM_OTP_CFG1_IS_CDB_BIT);
-		u32 masked_bits = is_jacket | (is_cdb << 1);
 
-		/*
-		 * The HW type depends on certain bits in this case, so add
-		 * these bits to the HW type. We won't have collisions since we
-		 * add these bits after the highest possible bit in the mask.
-		 */
-		hw_type |= masked_bits << IWL_AX210_HW_TYPE_ADDITION_SHIFT;
-	}
+	is_cdb = CSR_HW_RFID_IS_CDB(fwrt->trans->info.hw_rf_id);
+	is_jacket = !!(iwl_read_umac_prph(fwrt->trans, WFPM_OTP_CFG1_ADDR) &
+				WFPM_OTP_CFG1_IS_JACKET_BIT);
+
+	/* Use bits 12 and 13 to indicate jacket/CDB, respectively */
+	hw_type |= (is_jacket | (is_cdb << 1)) << IWL_JACKET_CDB_SHIFT;
+
 	dump->hw_type = cpu_to_le32(hw_type);
 
 	dump->rf_id_flavor =
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
index 3af275133da0..cf41021d59ad 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2014, 2018-2025 Intel Corporation
  * Copyright (C) 2014-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -372,10 +372,7 @@ struct iwl_fw_ini_dump_cfg_name {
 	u8 cfg_name[IWL_FW_INI_MAX_CFG_NAME];
 } __packed;
 
-/* AX210's HW type */
-#define IWL_AX210_HW_TYPE 0x42
-/* How many bits to roll when adding to the HW type of AX210 HW */
-#define IWL_AX210_HW_TYPE_ADDITION_SHIFT 12
+#define IWL_JACKET_CDB_SHIFT 12
 
 /* struct iwl_fw_ini_dump_info - ini dump information
  * @version: dump version
-- 
2.34.1


