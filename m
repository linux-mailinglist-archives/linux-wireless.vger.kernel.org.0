Return-Path: <linux-wireless+bounces-26733-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7E9B396DB
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 10:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6A57980F7D
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 08:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA342E1EE6;
	Thu, 28 Aug 2025 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JBt06HgX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973B32D97A6
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369606; cv=none; b=r8I7svST+te3DHj9pWEMskSDAgeY3OUE0kg0CNKKlkUILqZwEdqp6XIzflTUycTW1n4xyurwz7YUBI1hcZ0TF1z0JXQCerLkkbHScv+d3WfTLr7+COtdv+nFJXc1AFUO4c3dw8+8tSOqBdTe6kSmJvTDJIbOnTRdNcFMysbO/vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369606; c=relaxed/simple;
	bh=pcx9c6duy07iq2LCFE3Jk2IfRzDuZsfphcFb1R2Feg8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rtO198Qj2uOlxBEXSqyk0ADQLncS82l0/UpU+4W7OaQx31sYzAi4RxxZ43m7c3QwaXIorAhSACY8Ob8OaQgRMao3WEo/kKCDy+80rJolip52WwbHfk25PoRglznSwhHeOSwEK2Q6UGgd7mP2lmiQC4M7StjTJ1a7hIVQiTI4eYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JBt06HgX; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756369604; x=1787905604;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=pcx9c6duy07iq2LCFE3Jk2IfRzDuZsfphcFb1R2Feg8=;
  b=JBt06HgXlYxxPTQqJl5apzyQ4xE/NKc856KKWtA44vOAPwaSN4lQaS9v
   J8dI491lMhu58HNgloFL07t8gIlRkx3M8TFeEqGMHWbFWkKf3QUtAqQWw
   dqA3WkG741TKvaAuq2OwaGDcRkUT9xfSjQgJAljC4gCchIoRLydk6gV26
   bpUu/HsCZZrNELwG/IZmQmoLoac6FqZgnX1yUYIivKEiMbpRuCm2n2eQl
   x12Feg4en320JnQ6RjOsSlk/d3MbZd07Mg/YwYI9ufZUBViD8EGhvDS0F
   pMoMxag4GA2xaNTOmSTNcKb7TYANlhKdCNAUcfZjPtiPfa7bfw88SV5tM
   g==;
X-CSE-ConnectionGUID: C5cyFwcUTquNxf3iRj/Tmg==
X-CSE-MsgGUID: rgbKDXL+RW6OU527PLIrlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="70003336"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="70003336"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:41 -0700
X-CSE-ConnectionGUID: gWVMFQ+fTn+SQGMyUeKGxQ==
X-CSE-MsgGUID: 5uiVzCa1SbWF2tfu2g5GZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170224496"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:39 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: remove unneeded jacket indication
Date: Thu, 28 Aug 2025 11:25:52 +0300
Message-Id: <20250828111032.13a01468449c.Iab8255539567a82f0b9e0d1b269fababa2e72e61@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828082601.537908-1-miriam.rachel.korenblit@intel.com>
References: <20250828082601.537908-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This is only needed for internal builds. Don't read it.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c      |  8 ++------
 .../net/wireless/intel/iwlwifi/fw/error-dump.h   |  3 ++-
 .../wireless/intel/iwlwifi/pcie/gen1_2/trans.c   | 16 +++-------------
 3 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 09e8c93293e5..10d016308d77 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2393,7 +2393,7 @@ static u32 iwl_dump_ini_info(struct iwl_fw_runtime *fwrt,
 	struct iwl_fw_ini_dump_cfg_name *cfg_name;
 	u32 size = sizeof(*tlv) + sizeof(*dump);
 	u32 num_of_cfg_names = 0;
-	u32 hw_type, is_cdb, is_jacket;
+	u32 hw_type, is_cdb;
 
 	list_for_each_entry(node, &fwrt->trans->dbg.debug_info_tlv_list, list) {
 		size += sizeof(*cfg_name);
@@ -2426,11 +2426,7 @@ static u32 iwl_dump_ini_info(struct iwl_fw_runtime *fwrt,
 	hw_type = CSR_HW_REV_TYPE(fwrt->trans->info.hw_rev);
 
 	is_cdb = CSR_HW_RFID_IS_CDB(fwrt->trans->info.hw_rf_id);
-	is_jacket = !!(iwl_read_umac_prph(fwrt->trans, WFPM_OTP_CFG1_ADDR) &
-				WFPM_OTP_CFG1_IS_JACKET_BIT);
-
-	/* Use bits 12 and 13 to indicate jacket/CDB, respectively */
-	hw_type |= (is_jacket | (is_cdb << 1)) << IWL_JACKET_CDB_SHIFT;
+	hw_type |= IWL_CDB_MASK(is_cdb);
 
 	dump->hw_type = cpu_to_le32(hw_type);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
index cf41021d59ad..c2a73cc85eff 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -372,7 +372,8 @@ struct iwl_fw_ini_dump_cfg_name {
 	u8 cfg_name[IWL_FW_INI_MAX_CFG_NAME];
 } __packed;
 
-#define IWL_JACKET_CDB_SHIFT 12
+#define IWL_CDB_MASK(val) val << 13
+
 
 /* struct iwl_fw_ini_dump_info - ini dump information
  * @version: dump version
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 7aa9683624f0..5643aac4032b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -4035,6 +4035,7 @@ static void get_crf_id(struct iwl_trans *iwl_trans,
 
 	/* Read cdb info (also contains the jacket info if needed in the future */
 	hw_wfpm_id = iwl_read_umac_prph_no_grab(iwl_trans, WFPM_OTP_CFG1_ADDR);
+
 	IWL_INFO(iwl_trans, "Detected crf-id 0x%x, cnv-id 0x%x wfpm id 0x%x\n",
 		 info->hw_crf_id, info->hw_cnv_id, hw_wfpm_id);
 }
@@ -4050,10 +4051,8 @@ static int map_crf_id(struct iwl_trans *iwl_trans,
 	u32 val = info->hw_crf_id;
 	u32 step_id = REG_CRF_ID_STEP(val);
 	u32 slave_id = REG_CRF_ID_SLAVE(val);
-	u32 jacket_id_cnv = REG_CRF_ID_SLAVE(info->hw_cnv_id);
 	u32 hw_wfpm_id = iwl_read_umac_prph_no_grab(iwl_trans,
 						    WFPM_OTP_CFG1_ADDR);
-	u32 jacket_id_wfpm = WFPM_OTP_CFG1_IS_JACKET(hw_wfpm_id);
 	u32 cdb_id_wfpm = WFPM_OTP_CFG1_IS_CDB(hw_wfpm_id);
 
 	/* Map between crf id to rf id */
@@ -4102,21 +4101,12 @@ static int map_crf_id(struct iwl_trans *iwl_trans,
 		IWL_INFO(iwl_trans, "Adding cdb to rf id\n");
 	}
 
-	/* Set Jacket capabilities */
-	if (jacket_id_wfpm || jacket_id_cnv) {
-		info->hw_rf_id += BIT(29);
-		IWL_INFO(iwl_trans, "Adding jacket to rf id\n");
-	}
-
 	IWL_INFO(iwl_trans,
 		 "Detected rf-type 0x%x step-id 0x%x slave-id 0x%x from crf id 0x%x\n",
 		 REG_CRF_ID_TYPE(val), step_id, slave_id, info->hw_rf_id);
 	IWL_INFO(iwl_trans,
-		 "Detected cdb-id 0x%x jacket-id 0x%x from wfpm id 0x%x\n",
-		 cdb_id_wfpm, jacket_id_wfpm, hw_wfpm_id);
-	IWL_INFO(iwl_trans, "Detected jacket-id 0x%x from cnvi id 0x%x\n",
-		 jacket_id_cnv, info->hw_cnv_id);
-
+		 "Detected cdb-id 0x%x from wfpm id 0x%x\n",
+		 cdb_id_wfpm, hw_wfpm_id);
 out:
 	return ret;
 }
-- 
2.34.1


