Return-Path: <linux-wireless+bounces-19911-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F41A54A08
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 12:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8CEA188828E
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E85F20C48B;
	Thu,  6 Mar 2025 11:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YOTgwY4m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E5620CCF8
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 11:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261779; cv=none; b=b0AoUwuFJTU/Oav82xNlGO+6+QLFToSsTNtKv64Jc/C8wxMWfMO/FwDxzOK3Hy2HJC6HqAEmT8WIntdJ7KHXEWlXYJ3bkWFGpIUZOeVntADJoP3a74aO7myY1VXcDB0UAIQ+JzZOtomX1OP7BmzZQFaI1xgKCts1j+lnKQ+FfhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261779; c=relaxed/simple;
	bh=a8n+wcgwUCPOXqWmRX7S3Jlr+gBdORqLt/DhnXqN9wM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Si2NUsiLmcZP9PCFnGvEkDLlAlRIvN+R6W5pqy0Ylk6FyycVOE47xcm53B551z6WFcqk5tzgh3Q7RJHsaDeP6ZCxy53kLgyz/7C4Q4r74jouYsFOMGII3dVTbcq8uQp/T8xe3QPUXw/13/773JW/7A2R4BnMjfBM1lowIEV79vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YOTgwY4m; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741261778; x=1772797778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a8n+wcgwUCPOXqWmRX7S3Jlr+gBdORqLt/DhnXqN9wM=;
  b=YOTgwY4mLNQwxkdMo17iv7f8VY911tKmLokErLBLz4PJvj53sZ7gELTe
   Qz+kd6H+REoFgKylKgSbKx6RtAKGh/3RHyBLZEGig4qCObVuRCEmGUzl3
   nKRtT8HDIEKXevpO1DdlKauJYhuZUm/FncVNGztWoyW6aUhgb/z6/FbQv
   83u+5ae98fb0eUVeHnrinGaykcDarSDxWvBb7ERkP2yIKcqLJ1zOq6u1J
   tXM0DPkp7jvu1hvQCEN6/xlNyIklr0WtfJTtxZGwWrwsZTvsnD9FZ5Blx
   eUhXWLDT07Glg/1bUnjG2/1Q3X8zgmqa0ycsiEUUXAhKSF32O+nXmaMRh
   g==;
X-CSE-ConnectionGUID: HkKDOrRqQ1eCxH4g/WE7Iw==
X-CSE-MsgGUID: i65S4/tRRuezU64iueOt+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52474575"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="52474575"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:38 -0800
X-CSE-ConnectionGUID: 3+d4OR0eTba7ETxWVgE7wA==
X-CSE-MsgGUID: w+XrdBCjQzOMw5F+2MOwpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119915596"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:35 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 18/19] wifi: iwlwifi: fw: do reset handshake during assert if needed
Date: Thu,  6 Mar 2025 13:48:54 +0200
Message-Id: <20250306134559.0a5d15ebc9aa.Ie3911db1ebbd196ae4b0de1c53012aa1de193c0d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306114855.4170261-1-miriam.rachel.korenblit@intel.com>
References: <20250306114855.4170261-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Earlier, the firmware could only request the reset handshake is
done during the dump, if the dump was split. However, it's also
needed when the dump isn't split, in which case it must be done
before the dump. The firmware now advertises this requirement,
so do the handshake in the non-split case when asked for.

Rename apply policy ..._RESET_HANDSHAKE to ..._SPLIT_DUMP_RESET
to more clearly indicate that this specific dump needs to be
split, while the handshake requirement overall is now indicated
by the new capability flag.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  8 ++++----
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c       | 15 ++++++++++++---
 drivers/net/wireless/intel/iwlwifi/fw/file.h      |  7 +++++++
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index 4fab6c66994e..3173fa96cb48 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -527,8 +527,8 @@ enum iwl_fw_ini_time_point {
  * @IWL_FW_INI_APPLY_POLICY_OVERRIDE_DATA: override trigger data.
  *	Append otherwise
  * @IWL_FW_INI_APPLY_POLICY_DUMP_COMPLETE_CMD: send cmd once dump collected
- * @IWL_FW_INI_APPLY_POLICY_RESET_HANDSHAKE: perform reset handshake and
- *	split dump to before/after with region marking
+ * @IWL_FW_INI_APPLY_POLICY_SPLIT_DUMP_RESET: split this dump into regions
+ *	before and after the reset handshake
  */
 enum iwl_fw_ini_trigger_apply_policy {
 	IWL_FW_INI_APPLY_POLICY_MATCH_TIME_POINT	= BIT(0),
@@ -537,7 +537,7 @@ enum iwl_fw_ini_trigger_apply_policy {
 	IWL_FW_INI_APPLY_POLICY_OVERRIDE_CFG		= BIT(9),
 	IWL_FW_INI_APPLY_POLICY_OVERRIDE_DATA		= BIT(10),
 	IWL_FW_INI_APPLY_POLICY_DUMP_COMPLETE_CMD	= BIT(16),
-	IWL_FW_INI_APPLY_POLICY_RESET_HANDSHAKE		= BIT(17),
+	IWL_FW_INI_APPLY_POLICY_SPLIT_DUMP_RESET	= BIT(17),
 };
 
 /**
@@ -560,7 +560,7 @@ enum iwl_fw_ini_trigger_reset_fw_policy {
  * @IWL_FW_INI_DEBUG_DUMP_POLICY_MAX_LIMIT_600KB: mini dump only 600KB region dump
  * @IWL_FW_IWL_DEBUG_DUMP_POLICY_MAX_LIMIT_5MB: mini dump 5MB size dump
  * @IWL_FW_IWL_DEBUG_DUMP_POLICY_BEFORE_RESET: dump this region before reset
- *	handshake (if requested by %IWL_FW_INI_APPLY_POLICY_RESET_HANDSHAKE)
+ *	handshake (if requested by %IWL_FW_INI_APPLY_POLICY_SPLIT_DUMP_RESET)
  */
 enum iwl_fw_ini_dump_policy {
 	IWL_FW_INI_DEBUG_DUMP_POLICY_NO_LIMIT           = BIT(0),
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 634e2543ba6d..2ba00257b327 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2594,6 +2594,12 @@ enum iwl_dump_ini_region_selector {
 	IWL_INI_DUMP_LATE_REGIONS,
 };
 
+static bool iwl_dump_due_to_error(enum iwl_fw_ini_time_point tp_id)
+{
+	return tp_id == IWL_FW_INI_TIME_POINT_FW_ASSERT ||
+	       tp_id == IWL_FW_INI_TIME_POINT_FW_HW_ERROR;
+}
+
 static u32
 iwl_dump_ini_dump_regions(struct iwl_fw_runtime *fwrt,
 			  struct iwl_fwrt_dump_data *dump_data,
@@ -2659,8 +2665,7 @@ iwl_dump_ini_dump_regions(struct iwl_fw_runtime *fwrt,
 		 * debug data which also need to be collected.
 		 */
 		if (reg_type == IWL_FW_INI_REGION_DRAM_IMR) {
-			if (tp_id == IWL_FW_INI_TIME_POINT_FW_ASSERT ||
-			    tp_id == IWL_FW_INI_TIME_POINT_FW_HW_ERROR)
+			if (iwl_dump_due_to_error(tp_id))
 				imr_reg_data->reg_tlv =
 					fwrt->trans->dbg.active_regions[i];
 			else
@@ -2697,7 +2702,7 @@ static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 		     ARRAY_SIZE(fwrt->trans->dbg.active_regions));
 
 	if (trigger->time_point &
-			cpu_to_le32(IWL_FW_INI_APPLY_POLICY_RESET_HANDSHAKE)) {
+			cpu_to_le32(IWL_FW_INI_APPLY_POLICY_SPLIT_DUMP_RESET)) {
 		size += iwl_dump_ini_dump_regions(fwrt, dump_data, list, tp_id,
 						  regions_mask, &imr_reg_data,
 						  IWL_INI_DUMP_EARLY_REGIONS);
@@ -2706,6 +2711,10 @@ static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 						  regions_mask, &imr_reg_data,
 						  IWL_INI_DUMP_LATE_REGIONS);
 	} else {
+		if (fw_has_capa(&fwrt->fw->ucode_capa,
+				IWL_UCODE_TLV_CAPA_RESET_DURING_ASSERT) &&
+		    iwl_dump_due_to_error(tp_id))
+			iwl_trans_pcie_fw_reset_handshake(fwrt->trans);
 		size += iwl_dump_ini_dump_regions(fwrt, dump_data, list, tp_id,
 						  regions_mask, &imr_reg_data,
 						  IWL_INI_DUMP_ALL_REGIONS);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 770991d0c60b..b222dc081819 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -506,6 +506,13 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_BIOS_OVERRIDE_5G9_FOR_CA	= (__force iwl_ucode_tlv_capa_t)123,
 	IWL_UCODE_TLV_CAPA_UHB_CANADA_TAS_SUPPORT	= (__force iwl_ucode_tlv_capa_t)124,
 	IWL_UCODE_TLV_CAPA_RESTRICTED_TWT_SUPPORT	= (__force iwl_ucode_tlv_capa_t)126,
+
+	/* set 4 */
+	/**
+	 * @IWL_UCODE_TLV_CAPA_RESET_DURING_ASSERT: FW reset handshake is needed
+	 *	during assert handling even if the dump isn't split
+	 */
+	IWL_UCODE_TLV_CAPA_RESET_DURING_ASSERT		= (__force iwl_ucode_tlv_capa_t)(4 * 32 +  0),
 	NUM_IWL_UCODE_TLV_CAPA
 /*
  * This construction make both sparse (which cannot increment the previous
-- 
2.34.1


