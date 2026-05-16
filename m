Return-Path: <linux-wireless+bounces-36529-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PePIKPPCGp+6QMAu9opvQ
	(envelope-from <linux-wireless+bounces-36529-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 22:12:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E4C55DA0A
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 22:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DC133019119
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 20:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367883612E7;
	Sat, 16 May 2026 20:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iPAmeLUi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA1535FF58
	for <linux-wireless@vger.kernel.org>; Sat, 16 May 2026 20:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778962330; cv=none; b=cfierujG26vZRcycONNCkmgBnDQbmjYNpuDxDd4ht3upZV1iMsQ7mI63JMD6lJ+5E1nWzOo8zu7vB1WZ7cVD+t1F64BXbmuhxBaoJg0wzOABkbFQtrZgwJKtbnhLnkzfDVB5Nrl77B6ZRRxVROkfxs2ai1dqsN3LHMy00m/aCeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778962330; c=relaxed/simple;
	bh=SG1wrzMvn8gcftkfYC4Je8GIptT29B7xHWqSc2Tamqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nmz6DGz9odpBCaVFg1lGdtG9/7gn8qeJfw/6Msvm0QbX5eBbkCYzDR2WvAOGjY7q3gdVJmwEI0IjN6housveJH+WF9eb5nebtg3VYpv1QNob1mq5asHQ8nOgJ48yPr2ulN6DtPFhSLKhwSs+B2ytEbG2n/T+v0LFmkhIgQUrWvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iPAmeLUi; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778962329; x=1810498329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SG1wrzMvn8gcftkfYC4Je8GIptT29B7xHWqSc2Tamqc=;
  b=iPAmeLUiiFedj4itot/fVbLM2H26tTFQwPW5uzZOqsYgPcpnxnPvWU7T
   vfPx6xOkrnsxoCGT9sfwM2Ca7UkBenAvbVKmOVcb1x008qaInxmX9zT8q
   Qx+9/U730hUM0P/8nfqI0rLC/dIRCWe0jh0MtR8OeXMTQ4JO2kvlGBe+h
   PazNCJw6GaZ+JIibZRWQpHg+VZJESESPueMb5Cai/2QQUNkMg+tKullRP
   6NmeNOGy9Gh9/0BBYGWS1/yyBooPe6et0Z4vKFUV/5hxsDfaq8YSkY5W9
   +op2RBAtD/kq4WqnP4+qs1y3xSfyK1lcOXCPV1CIThLmZn7V0pDLG4gJW
   g==;
X-CSE-ConnectionGUID: orcZf/D4ToyHLOvtHCjyuA==
X-CSE-MsgGUID: eLYlnDuKSGWMnoEH2cFYcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="79845732"
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="79845732"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 13:12:08 -0700
X-CSE-ConnectionGUID: 0CDsZp1VSmmiV0YksRQeoQ==
X-CSE-MsgGUID: r78Ksif0Qu2gs8znG+2bcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="239130922"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 13:12:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-fixes 11/15] wifi: iwlwifi: fw: separate ini dump allocation
Date: Sat, 16 May 2026 23:11:33 +0300
Message-Id: <20260516230843.01a65fd9e6de.If9b648a5565671801c15be898f2b89afdb878256@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260516201137.2395464-1-miriam.rachel.korenblit@intel.com>
References: <20260516201137.2395464-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 29E4C55DA0A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36529-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

Separate out the ini dump allocation to happen before the
actual dumping in preparation for better device MAC access.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 176 +++++++++++---------
 1 file changed, 96 insertions(+), 80 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 4c41f042d6a0..886c8e6ef48e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2239,33 +2239,19 @@ struct iwl_dump_ini_mem_ops {
 			  void *range, u32 range_len, int idx);
 };
 
-/**
- * struct iwl_fw_ini_dump_entry - dump entry descriptor
- * @list: list of dump entries
- * @size: size of the data
- * @data: entry data
- */
 struct iwl_fw_ini_dump_entry {
+	const struct iwl_dump_ini_mem_ops *ops;
+	struct iwl_dump_ini_region_data reg_data;
 	struct list_head list;
+	u32 region_dump_policy;
 	u32 size;
 	u8 data[];
 } __packed;
 
-/**
- * iwl_dump_ini_mem - dump memory region
- *
- * @fwrt: fw runtime struct
- * @list: list to add the dump tlv to
- * @reg_data: memory region
- * @ops: memory dump operations
- *
- * Creates a dump tlv and copy a memory region into it.
- *
- * Returns: the size of the current dump tlv or 0 if failed
- */
-static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
-			    struct iwl_dump_ini_region_data *reg_data,
-			    const struct iwl_dump_ini_mem_ops *ops)
+static void iwl_dump_ini_mem_prep(struct iwl_fw_runtime *fwrt,
+				  struct list_head *list,
+				  struct iwl_dump_ini_region_data *reg_data,
+				  const struct iwl_dump_ini_mem_ops *ops)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_dump_entry *entry;
@@ -2273,58 +2259,59 @@ static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
 	struct iwl_fw_ini_error_dump_header *header;
 	u32 type = reg->type;
 	u32 id = le32_get_bits(reg->id, IWL_FW_INI_REGION_ID_MASK);
-	u32 num_of_ranges, i, size;
-	u8 *range;
-	u32 free_size;
-	u64 header_size;
+	u32 num_of_ranges, size;
 	u32 dump_policy = IWL_FW_INI_DUMP_VERBOSE;
+	u32 dp;
 
 	IWL_DEBUG_FW(fwrt, "WRT: Collecting region: dump type=%d, id=%d, type=%d\n",
 		     dump_policy, id, type);
 
 	if (le32_to_cpu(reg->hdr.version) >= 2) {
-		u32 dp = le32_get_bits(reg->id,
-				       IWL_FW_INI_REGION_DUMP_POLICY_MASK);
+		dp = le32_get_bits(reg->id, IWL_FW_INI_REGION_DUMP_POLICY_MASK);
 
 		if (dump_policy == IWL_FW_INI_DUMP_VERBOSE &&
 		    !(dp & IWL_FW_INI_DEBUG_DUMP_POLICY_NO_LIMIT)) {
 			IWL_DEBUG_FW(fwrt,
 				     "WRT: no dump - type %d and policy mismatch=%d\n",
 				     dump_policy, dp);
-			return 0;
+			return;
 		} else if (dump_policy == IWL_FW_INI_DUMP_MEDIUM &&
 			   !(dp & IWL_FW_IWL_DEBUG_DUMP_POLICY_MAX_LIMIT_5MB)) {
 			IWL_DEBUG_FW(fwrt,
 				     "WRT: no dump - type %d and policy mismatch=%d\n",
 				     dump_policy, dp);
-			return 0;
+			return;
 		} else if (dump_policy == IWL_FW_INI_DUMP_BRIEF &&
 			   !(dp & IWL_FW_INI_DEBUG_DUMP_POLICY_MAX_LIMIT_600KB)) {
 			IWL_DEBUG_FW(fwrt,
 				     "WRT: no dump - type %d and policy mismatch=%d\n",
 				     dump_policy, dp);
-			return 0;
+			return;
 		}
+	} else {
+		dp = 0;
 	}
 
 	if (!ops->get_num_of_ranges || !ops->get_size || !ops->fill_mem_hdr ||
 	    !ops->fill_range) {
 		IWL_DEBUG_FW(fwrt, "WRT: no ops for collecting data\n");
-		return 0;
+		return;
 	}
 
 	size = ops->get_size(fwrt, reg_data);
 
 	if (size < sizeof(*header)) {
 		IWL_DEBUG_FW(fwrt, "WRT: size didn't include space for header\n");
-		return 0;
+		return;
 	}
 
 	entry = vzalloc(sizeof(*entry) + sizeof(*tlv) + size);
 	if (!entry)
-		return 0;
+		return;
 
 	entry->size = sizeof(*tlv) + size;
+	entry->reg_data = *reg_data;
+	entry->region_dump_policy = dp;
 
 	tlv = (void *)entry->data;
 	tlv->type = reg->type;
@@ -2341,7 +2328,29 @@ static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
 	header->name_len = cpu_to_le32(IWL_FW_INI_MAX_NAME);
 	memcpy(header->name, reg->name, IWL_FW_INI_MAX_NAME);
 
-	free_size = size;
+	entry->ops = ops;
+	list_add_tail(&entry->list, list);
+}
+
+static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt,
+			    struct iwl_fw_ini_dump_entry *entry)
+{
+	struct iwl_dump_ini_region_data *reg_data = &entry->reg_data;
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+	const struct iwl_dump_ini_mem_ops *ops = entry->ops;
+	struct iwl_fw_ini_error_dump_data *tlv;
+	struct iwl_fw_ini_error_dump_header *header;
+	u32 type = reg->type;
+	u32 id = le32_get_bits(reg->id, IWL_FW_INI_REGION_ID_MASK);
+	u32 i;
+	u8 *range;
+	u32 free_size;
+	u64 header_size;
+
+	tlv = (void *)entry->data;
+	header = (void *)tlv->data;
+
+	free_size = entry->size - sizeof(*tlv);
 	range = ops->fill_mem_hdr(fwrt, reg_data, header, free_size);
 	if (!range) {
 		IWL_ERR(fwrt,
@@ -2362,7 +2371,7 @@ static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
 
 	free_size -= header_size;
 
-	for (i = 0; i < num_of_ranges; i++) {
+	for (i = 0; i < le32_to_cpu(header->num_of_ranges); i++) {
 		int range_size = ops->fill_range(fwrt, reg_data, range,
 						 free_size, i);
 
@@ -2384,11 +2393,10 @@ static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
 		range = range + range_size;
 	}
 
-	list_add_tail(&entry->list, list);
-
 	return entry->size;
 
 out_err:
+	list_del(&entry->list);
 	vfree(entry);
 
 	return 0;
@@ -2617,22 +2625,19 @@ static bool iwl_dump_due_to_error(enum iwl_fw_ini_time_point tp_id)
 	       tp_id == IWL_FW_INI_TIME_POINT_FW_HW_ERROR;
 }
 
-static u32
-iwl_dump_ini_dump_regions(struct iwl_fw_runtime *fwrt,
-			  struct iwl_fwrt_dump_data *dump_data,
-			  struct list_head *list,
-			  enum iwl_fw_ini_time_point tp_id,
-			  u64 regions_mask,
-			  struct iwl_dump_ini_region_data *imr_reg_data,
-			  enum iwl_dump_ini_region_selector which)
+static void
+iwl_dump_ini_dump_regions_prep(struct iwl_fw_runtime *fwrt,
+			       struct iwl_fwrt_dump_data *dump_data,
+			       struct list_head *list,
+			       enum iwl_fw_ini_time_point tp_id,
+			       u64 regions_mask,
+			       struct iwl_ucode_tlv **imr_tlv)
 {
-	u32 size = 0;
-
 	for (int i = 0; i < ARRAY_SIZE(fwrt->trans->dbg.active_regions); i++) {
 		struct iwl_dump_ini_region_data reg_data = {
 			.dump_data = dump_data,
 		};
-		u32 reg_type, dp;
+		u32 reg_type;
 		struct iwl_fw_ini_region_tlv *reg;
 
 		if (!(BIT_ULL(i) & regions_mask))
@@ -2650,8 +2655,6 @@ iwl_dump_ini_dump_regions(struct iwl_fw_runtime *fwrt,
 		if (reg_type >= ARRAY_SIZE(iwl_dump_ini_region_ops))
 			continue;
 
-		dp = le32_get_bits(reg->id, IWL_FW_INI_REGION_DUMP_POLICY_MASK);
-
 		if ((reg_type == IWL_FW_INI_REGION_PERIPHERY_PHY ||
 		     reg_type == IWL_FW_INI_REGION_PERIPHERY_PHY_RANGE ||
 		     reg_type == IWL_FW_INI_REGION_PERIPHERY_SNPS_DPHYIP) &&
@@ -2662,19 +2665,6 @@ iwl_dump_ini_dump_regions(struct iwl_fw_runtime *fwrt,
 			continue;
 		}
 
-		switch (which) {
-		case IWL_INI_DUMP_ALL_REGIONS:
-			break;
-		case IWL_INI_DUMP_EARLY_REGIONS:
-			if (!(dp & IWL_FW_IWL_DEBUG_DUMP_POLICY_BEFORE_RESET))
-				continue;
-			break;
-		case IWL_INI_DUMP_LATE_REGIONS:
-			if (dp & IWL_FW_IWL_DEBUG_DUMP_POLICY_BEFORE_RESET)
-				continue;
-			break;
-		}
-
 		/*
 		 * DRAM_IMR can be collected only for FW/HW error timepoint
 		 * when fw is not alive. In addition, it must be collected
@@ -2683,19 +2673,45 @@ iwl_dump_ini_dump_regions(struct iwl_fw_runtime *fwrt,
 		 */
 		if (reg_type == IWL_FW_INI_REGION_DRAM_IMR) {
 			if (iwl_dump_due_to_error(tp_id))
-				imr_reg_data->reg_tlv =
-					fwrt->trans->dbg.active_regions[i];
+				*imr_tlv = fwrt->trans->dbg.active_regions[i];
 			else
 				IWL_INFO(fwrt,
 					 "WRT: trying to collect DRAM_IMR at time point: %d, skipping\n",
 					 tp_id);
-		/* continue to next region */
+			/* continue to next region */
 			continue;
 		}
 
+		iwl_dump_ini_mem_prep(fwrt, list, &reg_data,
+				      &iwl_dump_ini_region_ops[reg_type]);
+	}
+}
+
+static u32
+iwl_dump_ini_dump_entries(struct iwl_fw_runtime *fwrt,
+			  struct list_head *list,
+			  enum iwl_dump_ini_region_selector which)
+{
+	struct iwl_fw_ini_dump_entry *entry, *tmp;
+	u32 size = 0;
+
+	list_for_each_entry_safe(entry, tmp, list, list) {
+		u32 dp = entry->region_dump_policy;
 
-		size += iwl_dump_ini_mem(fwrt, list, &reg_data,
-					 &iwl_dump_ini_region_ops[reg_type]);
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
+		size += iwl_dump_ini_mem(fwrt, entry);
 	}
 
 	return size;
@@ -2718,32 +2734,32 @@ static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 	BUILD_BUG_ON((sizeof(trigger->regions_mask) * BITS_PER_BYTE) <
 		     ARRAY_SIZE(fwrt->trans->dbg.active_regions));
 
+	iwl_dump_ini_dump_regions_prep(fwrt, dump_data, list, tp_id,
+				       regions_mask, &imr_reg_data.reg_tlv);
+
+	/* append DRAM_IMR region to be collected last */
+	if (imr_reg_data.reg_tlv)
+		iwl_dump_ini_mem_prep(fwrt, list, &imr_reg_data,
+				      &iwl_dump_ini_region_ops[IWL_FW_INI_REGION_DRAM_IMR]);
+
 	if (trigger->apply_policy &
 			cpu_to_le32(IWL_FW_INI_APPLY_POLICY_SPLIT_DUMP_RESET)) {
-		size += iwl_dump_ini_dump_regions(fwrt, dump_data, list, tp_id,
-						  regions_mask, &imr_reg_data,
+		size += iwl_dump_ini_dump_entries(fwrt, list,
 						  IWL_INI_DUMP_EARLY_REGIONS);
 		iwl_trans_pcie_fw_reset_handshake(fwrt->trans);
-		size += iwl_dump_ini_dump_regions(fwrt, dump_data, list, tp_id,
-						  regions_mask, &imr_reg_data,
+		size += iwl_dump_ini_dump_entries(fwrt, list,
 						  IWL_INI_DUMP_LATE_REGIONS);
 	} else {
 		if (fw_has_capa(&fwrt->fw->ucode_capa,
 				IWL_UCODE_TLV_CAPA_RESET_DURING_ASSERT) &&
 		    iwl_dump_due_to_error(tp_id))
 			iwl_trans_pcie_fw_reset_handshake(fwrt->trans);
-		size += iwl_dump_ini_dump_regions(fwrt, dump_data, list, tp_id,
-						  regions_mask, &imr_reg_data,
+		size += iwl_dump_ini_dump_entries(fwrt, list,
 						  IWL_INI_DUMP_ALL_REGIONS);
 	}
-	/* collect DRAM_IMR region in the last */
-	if (imr_reg_data.reg_tlv)
-		size += iwl_dump_ini_mem(fwrt, list, &imr_reg_data,
-					 &iwl_dump_ini_region_ops[IWL_FW_INI_REGION_DRAM_IMR]);
 
-	if (size) {
+	if (size)
 		size += iwl_dump_ini_info(fwrt, trigger, list);
-	}
 
 	return size;
 }
-- 
2.34.1


