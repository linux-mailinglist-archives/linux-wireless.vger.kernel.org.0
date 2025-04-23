Return-Path: <linux-wireless+bounces-21883-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C281FA97F01
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 08:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0291897498
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 06:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ADF266F13;
	Wed, 23 Apr 2025 06:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HFBPfeON"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F800266B55
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 06:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745389019; cv=none; b=FRlI0VHGets7YKrPKTXNfp9jXZmFPSYwSgeXp8+g7gzA7R8SBj4bZmtkpeLCVmFhGWfdMp2BABavP+JC8qHz/oDrbE0pGKp0BY71oKLHnPMCCSt8AdX7NCuj0MkDZx+S6t6Qn1VKxtWSk4WqJt9moE6pvHZYnJ56I2TAV3rC7rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745389019; c=relaxed/simple;
	bh=nZNwPewvg76PjjaVgFfRyzeodqBY47odI5aOUnfzcfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iu4kyVtUj3kXBgciSWlqLw0mNaT0GtrXt+SYuwXDqpgYvBvf0TaSKQjqbLHPK3rYYVdvOnXwnVQ2JBsLZMpcUvetQmH/wlDOYO1jtVL1WF62mWT5j+1hC0vHhm9vhYP3oRUvoyCbQkSjritDpxCxNLnjRhRjMTmyQ8eaabyCK8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HFBPfeON; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745389017; x=1776925017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nZNwPewvg76PjjaVgFfRyzeodqBY47odI5aOUnfzcfw=;
  b=HFBPfeONHyprY5BcuzYa5nNwRtbPczcsQeCgiOqr5iddtmMSkUpZVsx2
   HIST1J3TP2ijYBD19yLDZuyrjo0RISojlD7hsnJUnKr+OTrzbBCcp/zNc
   HGYOYAMIJ/f3R1zNXTfCEjsHzRyFkUp70sd1+L2kkijAWXPx1z4pn965m
   4DmCdiJxtfGYIcHaQFKlruZHvuw1yRDklW1jw5JYb21IJD0eJXojOpabR
   meQ4uySH1a4dc0cpsmKCopJBiQ/UkdWGVAZVYSCEAN0SnbjYMHPe3JTyT
   hFRhmqbRGliNwh2ElcciCx/qOAYCc3AW8hbcaOrBAHjNam1HadD1Tp8Vi
   A==;
X-CSE-ConnectionGUID: 246R/kAgTp2eLJLKj1GYjQ==
X-CSE-MsgGUID: hc+D6NvlT9+PF1f3hNaaEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46843617"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46843617"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:16:57 -0700
X-CSE-ConnectionGUID: PRVDQgnhQF6EQ95KxGf05w==
X-CSE-MsgGUID: EGMB5L90RJihE4FSMrKqxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="163269014"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:16:56 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 02/15] wifi: iwlwifi: fw: do reset handshake during assert if needed
Date: Wed, 23 Apr 2025 09:16:28 +0300
Message-Id: <20250423091408.10adafedb74b.Ie3911db1ebbd196ae4b0de1c53012aa1de193c0d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423061641.2302908-1-miriam.rachel.korenblit@intel.com>
References: <20250423061641.2302908-1-miriam.rachel.korenblit@intel.com>
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
index 03f639fbf9b6..e70eebf079be 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2624,6 +2624,12 @@ enum iwl_dump_ini_region_selector {
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
@@ -2689,8 +2695,7 @@ iwl_dump_ini_dump_regions(struct iwl_fw_runtime *fwrt,
 		 * debug data which also need to be collected.
 		 */
 		if (reg_type == IWL_FW_INI_REGION_DRAM_IMR) {
-			if (tp_id == IWL_FW_INI_TIME_POINT_FW_ASSERT ||
-			    tp_id == IWL_FW_INI_TIME_POINT_FW_HW_ERROR)
+			if (iwl_dump_due_to_error(tp_id))
 				imr_reg_data->reg_tlv =
 					fwrt->trans->dbg.active_regions[i];
 			else
@@ -2727,7 +2732,7 @@ static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 		     ARRAY_SIZE(fwrt->trans->dbg.active_regions));
 
 	if (trigger->time_point &
-			cpu_to_le32(IWL_FW_INI_APPLY_POLICY_RESET_HANDSHAKE)) {
+			cpu_to_le32(IWL_FW_INI_APPLY_POLICY_SPLIT_DUMP_RESET)) {
 		size += iwl_dump_ini_dump_regions(fwrt, dump_data, list, tp_id,
 						  regions_mask, &imr_reg_data,
 						  IWL_INI_DUMP_EARLY_REGIONS);
@@ -2736,6 +2741,10 @@ static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
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
index 9860903ecd3f..9155d64c4a58 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -504,6 +504,13 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_MONITOR_PASSIVE_CHANS	= (__force iwl_ucode_tlv_capa_t)122,
 	IWL_UCODE_TLV_CAPA_BIOS_OVERRIDE_5G9_FOR_CA	= (__force iwl_ucode_tlv_capa_t)123,
 	IWL_UCODE_TLV_CAPA_UHB_CANADA_TAS_SUPPORT	= (__force iwl_ucode_tlv_capa_t)124,
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


