Return-Path: <linux-wireless+bounces-26646-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 809A5B36F39
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 18:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1440B1BC0890
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 15:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1834C34A32E;
	Tue, 26 Aug 2025 15:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E+umM57U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004152FF175
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223752; cv=none; b=WZZyC2awJZt66PIWqArNVN25QD5ZGdYt+TApeye2fjrp6R9Nh4PM1RyOsAWphyOIVd8O+zSpNZTNvzJne8NFlT/3StJ5Xcb+ORwlcCV1mzAaF71QTHTzNFHNhPQ2ok0WLon6McnphT/OTqFqzHy8noRd9jMyKs56bgrlAaUTHpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223752; c=relaxed/simple;
	bh=l7sBgB7ZAXD3f+grTrMUvYhTaBvJbKn1C2ZlcyMaYZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eFauYJCsav1Zachrwc5V7fmKLgTBT1dSv5cKojJ28qh2vj8ff/d48FqCpZg9zjlVGSZORlo3A8G4EE0ulCEp29wOctuCivwt9dY3vwgmGubzzk+cIkTUi6dR5zfE2SUQTH4eZftEynISqZp8s2dH7RSdwBWPXtTVvWjNFI6FP2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E+umM57U; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756223750; x=1787759750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l7sBgB7ZAXD3f+grTrMUvYhTaBvJbKn1C2ZlcyMaYZw=;
  b=E+umM57UeXj6el20wEHJ5wRFKToqjDRAp/h2n7VYZUY4juYcRdvsXsot
   lpn8ES2HrzMDWEMUmGlezCV2ic56zfnFYUbGPNgh2YSZQsyk8ADNk9Q1U
   FfwO0MkayOl5b+fW7HZBoL2EkJOrfq3d8v7nUuB4FDgaItCJU0Tggi2DX
   wqnSlSQTrDjGwkmFhvcENUHOu1aAtgksFmZhzUMEdAZkL76C8o0kQY23n
   gkJESN3uNblGdDnKl7Texpc//RpRT/FAAjuNjii9k9WL3Q/AxtnhLO5Kb
   MWbiXnKQ4778O5FhjhOHkrPbA0IwnxnKqX4RgQ4gKZ7mvtzYC/imIFRBv
   g==;
X-CSE-ConnectionGUID: EVfCMbnDQNmF1inlvAq7yQ==
X-CSE-MsgGUID: N/Ne3LwlQ+e5Oa9xFUmFxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62108427"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62108427"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:42 -0700
X-CSE-ConnectionGUID: kybWpDGfQza/lcKVxu0TgA==
X-CSE-MsgGUID: 2VuGHreEQ7mr/milMRl5wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169218295"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:41 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: remove dump file name extension support
Date: Tue, 26 Aug 2025 18:54:58 +0300
Message-Id: <20250826184046.d97f93fd1147.I7d0b056b6f9c38cafc53a0f29e0cf1236e2d2e8c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826155504.2982930-1-miriam.rachel.korenblit@intel.com>
References: <20250826155504.2982930-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The options to configure a dump file name extension was added for 2
cases:
1. if we dump because of a missed beacon, we added the mac id and type
   to the filename.
2. to add the error id of the LMAC/UMAC/TCM/RCM error id to the file
   name.

For 1, there is a bug: in cases in which missed beacon will not trigger
a dump (for example in the default preset), and a missed beacon occurred,
and eventually there is a dump for a different reason,
the dump file name will contain the mac type and id even thought the
dump has nothing to do with a missed beacon.

Anyway, both cases are no longer required. Remove the code.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 31 -----------
 drivers/net/wireless/intel/iwlwifi/fw/dump.c  | 52 -------------------
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  2 -
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  4 --
 drivers/net/wireless/intel/iwlwifi/mld/link.c |  5 --
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  4 --
 6 files changed, 98 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 2879be4b8fcb..09e8c93293e5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2478,36 +2478,6 @@ static u32 iwl_dump_ini_info(struct iwl_fw_runtime *fwrt,
 	return entry->size;
 }
 
-static u32 iwl_dump_ini_file_name_info(struct iwl_fw_runtime *fwrt,
-				       struct list_head *list)
-{
-	struct iwl_fw_ini_dump_entry *entry;
-	struct iwl_dump_file_name_info *tlv;
-	u32 len = strnlen(fwrt->trans->dbg.dump_file_name_ext,
-			  IWL_FW_INI_MAX_NAME);
-
-	if (!fwrt->trans->dbg.dump_file_name_ext_valid)
-		return 0;
-
-	entry = vzalloc(sizeof(*entry) + sizeof(*tlv) + len);
-	if (!entry)
-		return 0;
-
-	entry->size = sizeof(*tlv) + len;
-
-	tlv = (void *)entry->data;
-	tlv->type = cpu_to_le32(IWL_INI_DUMP_NAME_TYPE);
-	tlv->len = cpu_to_le32(len);
-	memcpy(tlv->data, fwrt->trans->dbg.dump_file_name_ext, len);
-
-	/* add the dump file name extension tlv to the list */
-	list_add_tail(&entry->list, list);
-
-	fwrt->trans->dbg.dump_file_name_ext_valid = false;
-
-	return entry->size;
-}
-
 static const struct iwl_dump_ini_mem_ops iwl_dump_ini_region_ops[] = {
 	[IWL_FW_INI_REGION_INVALID] = {},
 	[IWL_FW_INI_REGION_INTERNAL_BUFFER] = {
@@ -2764,7 +2734,6 @@ static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 					 &iwl_dump_ini_region_ops[IWL_FW_INI_REGION_DRAM_IMR]);
 
 	if (size) {
-		size += iwl_dump_ini_file_name_info(fwrt, list);
 		size += iwl_dump_ini_info(fwrt, trigger, list);
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dump.c b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
index f633124979ab..a39c038db08e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dump.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
@@ -14,13 +14,6 @@
 #include "iwl-csr.h"
 #include "pnvm.h"
 
-#define FW_ASSERT_LMAC_FATAL			0x70
-#define FW_ASSERT_LMAC2_FATAL			0x72
-#define FW_ASSERT_UMAC_FATAL			0x71
-#define UMAC_RT_NMI_LMAC2_FATAL			0x72
-#define RT_NMI_INTERRUPT_OTHER_LMAC_FATAL	0x73
-#define FW_ASSERT_NMI_UNKNOWN			0x84
-
 /*
  * Note: This structure is read from the device with IO accesses,
  * and the reading already does the endian conversion. As it is
@@ -103,17 +96,6 @@ struct iwl_umac_error_event_table {
 #define ERROR_START_OFFSET  (1 * sizeof(u32))
 #define ERROR_ELEM_SIZE     (7 * sizeof(u32))
 
-static bool iwl_fwrt_if_errorid_other_cpu(u32 err_id)
-{
-	err_id &= 0xFF;
-
-	if ((err_id >= FW_ASSERT_LMAC_FATAL &&
-	     err_id <= RT_NMI_INTERRUPT_OTHER_LMAC_FATAL) ||
-	    err_id == FW_ASSERT_NMI_UNKNOWN)
-		return  true;
-	return false;
-}
-
 static void iwl_fwrt_dump_umac_error_log(struct iwl_fw_runtime *fwrt)
 {
 	struct iwl_trans *trans = fwrt->trans;
@@ -131,13 +113,6 @@ static void iwl_fwrt_dump_umac_error_log(struct iwl_fw_runtime *fwrt)
 	if (table.valid)
 		fwrt->dump.umac_err_id = table.error_id;
 
-	if (!iwl_fwrt_if_errorid_other_cpu(fwrt->dump.umac_err_id) &&
-	    !fwrt->trans->dbg.dump_file_name_ext_valid) {
-		fwrt->trans->dbg.dump_file_name_ext_valid = true;
-		snprintf(fwrt->trans->dbg.dump_file_name_ext, IWL_FW_INI_MAX_NAME,
-			 "0x%x", fwrt->dump.umac_err_id);
-	}
-
 	if (ERROR_START_OFFSET <= table.valid * ERROR_ELEM_SIZE) {
 		IWL_ERR(trans, "Start IWL Error Log Dump:\n");
 		IWL_ERR(trans, "Transport status: 0x%08lX, valid: %d\n",
@@ -213,13 +188,6 @@ static void iwl_fwrt_dump_lmac_error_log(struct iwl_fw_runtime *fwrt, u8 lmac_nu
 	if (table.valid)
 		fwrt->dump.lmac_err_id[lmac_num] = table.error_id;
 
-	if (!iwl_fwrt_if_errorid_other_cpu(fwrt->dump.lmac_err_id[lmac_num]) &&
-	    !fwrt->trans->dbg.dump_file_name_ext_valid) {
-		fwrt->trans->dbg.dump_file_name_ext_valid = true;
-		snprintf(fwrt->trans->dbg.dump_file_name_ext, IWL_FW_INI_MAX_NAME,
-			 "0x%x", fwrt->dump.lmac_err_id[lmac_num]);
-	}
-
 	if (ERROR_START_OFFSET <= table.valid * ERROR_ELEM_SIZE) {
 		IWL_ERR(trans, "Start IWL Error Log Dump:\n");
 		IWL_ERR(trans, "Transport status: 0x%08lX, valid: %d\n",
@@ -305,16 +273,6 @@ static void iwl_fwrt_dump_tcm_error_log(struct iwl_fw_runtime *fwrt, int idx)
 
 	iwl_trans_read_mem_bytes(trans, base, &table, sizeof(table));
 
-	if (table.valid)
-		fwrt->dump.tcm_err_id[idx] = table.error_id;
-
-	if (!iwl_fwrt_if_errorid_other_cpu(fwrt->dump.tcm_err_id[idx]) &&
-	    !fwrt->trans->dbg.dump_file_name_ext_valid) {
-		fwrt->trans->dbg.dump_file_name_ext_valid = true;
-		snprintf(fwrt->trans->dbg.dump_file_name_ext, IWL_FW_INI_MAX_NAME,
-			 "0x%x", fwrt->dump.tcm_err_id[idx]);
-	}
-
 	IWL_ERR(fwrt, "TCM%d status:\n", idx + 1);
 	IWL_ERR(fwrt, "0x%08X | error ID\n", table.error_id);
 	IWL_ERR(fwrt, "0x%08X | tcm branchlink2\n", table.blink2);
@@ -378,16 +336,6 @@ static void iwl_fwrt_dump_rcm_error_log(struct iwl_fw_runtime *fwrt, int idx)
 
 	iwl_trans_read_mem_bytes(trans, base, &table, sizeof(table));
 
-	if (table.valid)
-		fwrt->dump.rcm_err_id[idx] = table.error_id;
-
-	if (!iwl_fwrt_if_errorid_other_cpu(fwrt->dump.rcm_err_id[idx]) &&
-	    !fwrt->trans->dbg.dump_file_name_ext_valid) {
-		fwrt->trans->dbg.dump_file_name_ext_valid = true;
-		snprintf(fwrt->trans->dbg.dump_file_name_ext, IWL_FW_INI_MAX_NAME,
-			 "0x%x", fwrt->dump.rcm_err_id[idx]);
-	}
-
 	IWL_ERR(fwrt, "RCM%d status:\n", idx + 1);
 	IWL_ERR(fwrt, "0x%08X | error ID\n", table.error_id);
 	IWL_ERR(fwrt, "0x%08X | rcm branchlink2\n", table.blink2);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 0444a736c2b2..9b116fa1d5d1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -146,8 +146,6 @@ struct iwl_fw_runtime {
 		unsigned long non_collect_ts_start[IWL_FW_INI_TIME_POINT_NUM];
 		u32 *d3_debug_data;
 		u32 lmac_err_id[MAX_NUM_LMAC];
-		u32 tcm_err_id[MAX_NUM_TCM];
-		u32 rcm_err_id[MAX_NUM_RCM];
 		u32 umac_err_id;
 
 		struct iwl_txf_iter_data txf_iter_data;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index d0e658801c2e..52f4a09c740f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -658,8 +658,6 @@ struct iwl_pc_data {
  * @restart_required: indicates debug restart is required
  * @last_tp_resetfw: last handling of reset during debug timepoint
  * @imr_data: IMR debug data allocation
- * @dump_file_name_ext: dump file name extension
- * @dump_file_name_ext_valid: dump file name extension if valid or not
  * @num_pc: number of program counter for cpu
  * @pc_data: details of the program counter
  * @yoyo_bin_loaded: tells if a yoyo debug file has been loaded
@@ -698,8 +696,6 @@ struct iwl_trans_debug {
 	bool restart_required;
 	u32 last_tp_resetfw;
 	struct iwl_imr_data imr_data;
-	u8 dump_file_name_ext[IWL_FW_INI_MAX_NAME];
-	bool dump_file_name_ext_valid;
 	u32 num_pc;
 	struct iwl_pc_data *pc_data;
 	bool yoyo_bin_loaded;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index 6135da34a9c1..738f80fe0c50 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -551,11 +551,6 @@ void iwl_mld_handle_missed_beacon_notif(struct iwl_mld *mld,
 	if (WARN_ON(!vif))
 		return;
 
-	mld->trans->dbg.dump_file_name_ext_valid = true;
-	snprintf(mld->trans->dbg.dump_file_name_ext, IWL_FW_INI_MAX_NAME,
-		 "LinkId_%d_MacType_%d", fw_link_id,
-		 iwl_mld_mac80211_iftype_to_fw(vif));
-
 	iwl_dbg_tlv_time_point(&mld->fwrt,
 			       IWL_FW_INI_TIME_POINT_MISSED_BEACONS, &tp_data);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 7d84ac26949c..9c9e0e1c6e1d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1619,10 +1619,6 @@ iwl_mvm_handle_missed_beacons_notif(struct iwl_mvm *mvm,
 
 	IWL_DEBUG_INFO(mvm, "missed beacon mac_type=%u,\n", mac_type);
 
-	mvm->trans->dbg.dump_file_name_ext_valid = true;
-	snprintf(mvm->trans->dbg.dump_file_name_ext, IWL_FW_INI_MAX_NAME,
-		 "MacId_%d_MacType_%d", id, mac_type);
-
 	rx_missed_bcon = le32_to_cpu(mb->consec_missed_beacons);
 	rx_missed_bcon_since_rx =
 		le32_to_cpu(mb->consec_missed_beacons_since_last_rx);
-- 
2.34.1


