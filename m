Return-Path: <linux-wireless+bounces-18536-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7F7A28B08
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 13:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0FB81625F0
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 12:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1277617BA6;
	Wed,  5 Feb 2025 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JCVyZxD7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C941DF5C
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760200; cv=none; b=J3VEXYuR+lOyg31JiFMTZWmZx54Gaaokfueo8Yq8bhVUzy3r5BLbutn0TuKCD30PszEuqQvMYPjHi/sa6HnbqH9EkCY/7Fdz9ARDRN2+KsAtUu0zzQgQ/fRRjPSv/+9oMnYnuBTI1Uw53lqu1sonUoSdGXxMHTvE8KsIEi4dg88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760200; c=relaxed/simple;
	bh=V4ma4tcNQXc2hDgS4Pvii7pybxgTBMReHoTd2dTvEFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m8Xsm6v51N2FsCMAHkMIgVKfyZ4Ah9yvjXJ54hxHiv2USsTGyiiLlxIRTeT9W1mMUsBeF4JqKZJPYl9cTmH+LU1aqWVfIkiBPB+Ns8eug78z2jEbjE7qPdLt0t+y0NCXjcaOm5GcXjhjZYVOjlsNSpyAnZwq5R8jJKIQed1YknQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JCVyZxD7; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738760198; x=1770296198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V4ma4tcNQXc2hDgS4Pvii7pybxgTBMReHoTd2dTvEFw=;
  b=JCVyZxD73sfr1udZ1jRUJwQWOOCxzdgxUEM0tCdbcJ0NNbs/e1Z/skB6
   beAx33JkVz1U6HTDPCpFC4AjvJb5jQIJny2dOCjYfpScm4TpUVmjPPWuB
   i5xoPT4vHhyyLJZet6KWwQFWv7Ns/Z87NirbiZPuQHqRc4GikMDaBUZ3D
   /zzG+LCpDEdT5380CRFXU/WnRSx6875cpNHxhOW4H0t+DxDWnn+rke+M0
   9u4NctIbhZf7LfcmPejjAdQ6RKggKoFtAA8EBxOV0dfQuYyty+Hwu43UB
   YOPQFC8ul10OQzvOUWc3HQtIvCC97Znm0VogdYpu5AXm4jKdSVOWhEPTm
   g==;
X-CSE-ConnectionGUID: PBD9YDmxTHij4oalbs2R3A==
X-CSE-MsgGUID: Ds+vTbO7TxKwfS0ZbzfC0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42159229"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="42159229"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:38 -0800
X-CSE-ConnectionGUID: NT6YS9TSSXG0xjDMQoDw6w==
X-CSE-MsgGUID: rVDuPYThSKiqFEaTKN4axQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110745507"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:37 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 19/19] wifi: iwlwifi: implement dump region split
Date: Wed,  5 Feb 2025 14:55:48 +0200
Message-Id: <20250205145347.9296e3113d42.Ifb32703fd06a644d08a86b7af1b990738e3c8134@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

Due to hardware design constraints, a reset handshake may be
necessary even when the firmware has already crashed, with
the dump descriptions indicating which parts should be done
before/after the handshake, if needed. Implement that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  9 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 99 ++++++++++++++-----
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  1 +
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  4 +-
 4 files changed, 85 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index 550de6db1834..4fab6c66994e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 #ifndef __iwl_fw_dbg_tlv_h__
 #define __iwl_fw_dbg_tlv_h__
@@ -527,6 +527,8 @@ enum iwl_fw_ini_time_point {
  * @IWL_FW_INI_APPLY_POLICY_OVERRIDE_DATA: override trigger data.
  *	Append otherwise
  * @IWL_FW_INI_APPLY_POLICY_DUMP_COMPLETE_CMD: send cmd once dump collected
+ * @IWL_FW_INI_APPLY_POLICY_RESET_HANDSHAKE: perform reset handshake and
+ *	split dump to before/after with region marking
  */
 enum iwl_fw_ini_trigger_apply_policy {
 	IWL_FW_INI_APPLY_POLICY_MATCH_TIME_POINT	= BIT(0),
@@ -535,6 +537,7 @@ enum iwl_fw_ini_trigger_apply_policy {
 	IWL_FW_INI_APPLY_POLICY_OVERRIDE_CFG		= BIT(9),
 	IWL_FW_INI_APPLY_POLICY_OVERRIDE_DATA		= BIT(10),
 	IWL_FW_INI_APPLY_POLICY_DUMP_COMPLETE_CMD	= BIT(16),
+	IWL_FW_INI_APPLY_POLICY_RESET_HANDSHAKE		= BIT(17),
 };
 
 /**
@@ -556,12 +559,14 @@ enum iwl_fw_ini_trigger_reset_fw_policy {
  * @IWL_FW_INI_DEBUG_DUMP_POLICY_NO_LIMIT: OS has no limit of dump size
  * @IWL_FW_INI_DEBUG_DUMP_POLICY_MAX_LIMIT_600KB: mini dump only 600KB region dump
  * @IWL_FW_IWL_DEBUG_DUMP_POLICY_MAX_LIMIT_5MB: mini dump 5MB size dump
+ * @IWL_FW_IWL_DEBUG_DUMP_POLICY_BEFORE_RESET: dump this region before reset
+ *	handshake (if requested by %IWL_FW_INI_APPLY_POLICY_RESET_HANDSHAKE)
  */
 enum iwl_fw_ini_dump_policy {
 	IWL_FW_INI_DEBUG_DUMP_POLICY_NO_LIMIT           = BIT(0),
 	IWL_FW_INI_DEBUG_DUMP_POLICY_MAX_LIMIT_600KB    = BIT(1),
 	IWL_FW_IWL_DEBUG_DUMP_POLICY_MAX_LIMIT_5MB      = BIT(2),
-
+	IWL_FW_IWL_DEBUG_DUMP_POLICY_BEFORE_RESET	= BIT(3),
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 6819c615fef6..634e2543ba6d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2588,29 +2588,28 @@ static const struct iwl_dump_ini_mem_ops iwl_dump_ini_region_ops[] = {
 	},
 };
 
-static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
-				struct iwl_fwrt_dump_data *dump_data,
-				struct list_head *list)
+enum iwl_dump_ini_region_selector {
+	IWL_INI_DUMP_ALL_REGIONS,
+	IWL_INI_DUMP_EARLY_REGIONS,
+	IWL_INI_DUMP_LATE_REGIONS,
+};
+
+static u32
+iwl_dump_ini_dump_regions(struct iwl_fw_runtime *fwrt,
+			  struct iwl_fwrt_dump_data *dump_data,
+			  struct list_head *list,
+			  enum iwl_fw_ini_time_point tp_id,
+			  u64 regions_mask,
+			  struct iwl_dump_ini_region_data *imr_reg_data,
+			  enum iwl_dump_ini_region_selector which)
 {
-	struct iwl_fw_ini_trigger_tlv *trigger = dump_data->trig;
-	enum iwl_fw_ini_time_point tp_id = le32_to_cpu(trigger->time_point);
-	struct iwl_dump_ini_region_data reg_data = {
-		.dump_data = dump_data,
-	};
-	struct iwl_dump_ini_region_data imr_reg_data = {
-		.dump_data = dump_data,
-	};
-	int i;
 	u32 size = 0;
-	u64 regions_mask = le64_to_cpu(trigger->regions_mask) &
-			   ~(fwrt->trans->dbg.unsupported_region_msk);
 
-	BUILD_BUG_ON(sizeof(trigger->regions_mask) != sizeof(regions_mask));
-	BUILD_BUG_ON((sizeof(trigger->regions_mask) * BITS_PER_BYTE) <
-		     ARRAY_SIZE(fwrt->trans->dbg.active_regions));
-
-	for (i = 0; i < ARRAY_SIZE(fwrt->trans->dbg.active_regions); i++) {
-		u32 reg_type;
+	for (int i = 0; i < ARRAY_SIZE(fwrt->trans->dbg.active_regions); i++) {
+		struct iwl_dump_ini_region_data reg_data = {
+			.dump_data = dump_data,
+		};
+		u32 reg_type, dp;
 		struct iwl_fw_ini_region_tlv *reg;
 
 		if (!(BIT_ULL(i) & regions_mask))
@@ -2628,6 +2627,8 @@ static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 		if (reg_type >= ARRAY_SIZE(iwl_dump_ini_region_ops))
 			continue;
 
+		dp = le32_get_bits(reg->id, IWL_FW_INI_REGION_DUMP_POLICY_MASK);
+
 		if ((reg_type == IWL_FW_INI_REGION_PERIPHERY_PHY ||
 		     reg_type == IWL_FW_INI_REGION_PERIPHERY_PHY_RANGE ||
 		     reg_type == IWL_FW_INI_REGION_PERIPHERY_SNPS_DPHYIP) &&
@@ -2637,6 +2638,20 @@ static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 				 tp_id);
 			continue;
 		}
+
+		switch (which) {
+		case IWL_INI_DUMP_ALL_REGIONS:
+			break;
+		case IWL_INI_DUMP_EARLY_REGIONS:
+			if (!(dp & IWL_FW_IWL_DEBUG_DUMP_POLICY_BEFORE_RESET))
+				continue;
+			break;
+		case IWL_INI_DUMP_LATE_REGIONS:
+			if (dp & IWL_FW_IWL_DEBUG_DUMP_POLICY_BEFORE_RESET)
+				continue;
+			break;
+		}
+
 		/*
 		 * DRAM_IMR can be collected only for FW/HW error timepoint
 		 * when fw is not alive. In addition, it must be collected
@@ -2646,7 +2661,8 @@ static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 		if (reg_type == IWL_FW_INI_REGION_DRAM_IMR) {
 			if (tp_id == IWL_FW_INI_TIME_POINT_FW_ASSERT ||
 			    tp_id == IWL_FW_INI_TIME_POINT_FW_HW_ERROR)
-				imr_reg_data.reg_tlv = fwrt->trans->dbg.active_regions[i];
+				imr_reg_data->reg_tlv =
+					fwrt->trans->dbg.active_regions[i];
 			else
 				IWL_INFO(fwrt,
 					 "WRT: trying to collect DRAM_IMR at time point: %d, skipping\n",
@@ -2659,6 +2675,41 @@ static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 		size += iwl_dump_ini_mem(fwrt, list, &reg_data,
 					 &iwl_dump_ini_region_ops[reg_type]);
 	}
+
+	return size;
+}
+
+static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
+				struct iwl_fwrt_dump_data *dump_data,
+				struct list_head *list)
+{
+	struct iwl_fw_ini_trigger_tlv *trigger = dump_data->trig;
+	enum iwl_fw_ini_time_point tp_id = le32_to_cpu(trigger->time_point);
+	struct iwl_dump_ini_region_data imr_reg_data = {
+		.dump_data = dump_data,
+	};
+	u32 size = 0;
+	u64 regions_mask = le64_to_cpu(trigger->regions_mask) &
+			   ~(fwrt->trans->dbg.unsupported_region_msk);
+
+	BUILD_BUG_ON(sizeof(trigger->regions_mask) != sizeof(regions_mask));
+	BUILD_BUG_ON((sizeof(trigger->regions_mask) * BITS_PER_BYTE) <
+		     ARRAY_SIZE(fwrt->trans->dbg.active_regions));
+
+	if (trigger->time_point &
+			cpu_to_le32(IWL_FW_INI_APPLY_POLICY_RESET_HANDSHAKE)) {
+		size += iwl_dump_ini_dump_regions(fwrt, dump_data, list, tp_id,
+						  regions_mask, &imr_reg_data,
+						  IWL_INI_DUMP_EARLY_REGIONS);
+		iwl_trans_pcie_fw_reset_handshake(fwrt->trans);
+		size += iwl_dump_ini_dump_regions(fwrt, dump_data, list, tp_id,
+						  regions_mask, &imr_reg_data,
+						  IWL_INI_DUMP_LATE_REGIONS);
+	} else {
+		size += iwl_dump_ini_dump_regions(fwrt, dump_data, list, tp_id,
+						  regions_mask, &imr_reg_data,
+						  IWL_INI_DUMP_ALL_REGIONS);
+	}
 	/* collect DRAM_IMR region in the last */
 	if (imr_reg_data.reg_tlv)
 		size += iwl_dump_ini_mem(fwrt, list, &imr_reg_data,
@@ -3071,6 +3122,7 @@ static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 	struct iwl_fw_dbg_params params = {0};
 	struct iwl_fwrt_dump_data *dump_data =
 		&fwrt->dump.wks[wk_idx].dump_data;
+
 	if (!test_bit(wk_idx, &fwrt->dump.active_wks))
 		return;
 
@@ -3095,9 +3147,9 @@ static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 
 	IWL_DEBUG_FW_INFO(fwrt, "WRT: Data collection start\n");
 	if (iwl_trans_dbg_ini_valid(fwrt->trans))
-		iwl_fw_error_ini_dump(fwrt, &fwrt->dump.wks[wk_idx].dump_data);
+		iwl_fw_error_ini_dump(fwrt, dump_data);
 	else
-		iwl_fw_error_dump(fwrt, &fwrt->dump.wks[wk_idx].dump_data);
+		iwl_fw_error_dump(fwrt, dump_data);
 	IWL_DEBUG_FW_INFO(fwrt, "WRT: Data collection done\n");
 
 	iwl_fw_dbg_stop_restart_recording(fwrt, &params, false);
@@ -3114,7 +3166,6 @@ static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 
 	if (fwrt->trans->dbg.last_tp_resetfw == IWL_FW_INI_RESET_FW_MODE_STOP_FW_ONLY)
 		iwl_force_nmi(fwrt->trans);
-
 out:
 	if (iwl_trans_dbg_ini_valid(fwrt->trans)) {
 		iwl_fw_error_dump_data_free(dump_data);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 3561ff8483f2..021691513a57 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1262,6 +1262,7 @@ enum iwl_reset_mode {
 };
 
 void iwl_trans_pcie_reset(struct iwl_trans *trans, enum iwl_reset_mode mode);
+void iwl_trans_pcie_fw_reset_handshake(struct iwl_trans *trans);
 
 int iwl_trans_pcie_send_hcmd(struct iwl_trans *trans,
 			     struct iwl_host_cmd *cmd);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 793514a1852a..3ece34e30d58 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 #include "iwl-trans.h"
 #include "iwl-prph.h"
@@ -95,7 +95,7 @@ static void iwl_pcie_gen2_apm_stop(struct iwl_trans *trans, bool op_mode_leave)
 			      CSR_GP_CNTRL_REG_FLAG_INIT_DONE);
 }
 
-static void iwl_trans_pcie_fw_reset_handshake(struct iwl_trans *trans)
+void iwl_trans_pcie_fw_reset_handshake(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int ret;
-- 
2.34.1


