Return-Path: <linux-wireless+bounces-37026-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDlZKJROF2r7AAgAu9opvQ
	(envelope-from <linux-wireless+bounces-37026-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 22:05:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 163C25E9E22
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 22:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8174A301B17B
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 20:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD03C3B4417;
	Wed, 27 May 2026 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YDi3ymlR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9D53B19D0
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779912331; cv=none; b=brJ9H03ippjQKDJfxl6y1/YLOUL/vcgWwqGQbkclYy6CD3mrNLFTjN7jUMPI0JqLtQEhKgisS9XTiWsDJNiZfLIVPSCPDQBX+BGTfhqaYlDOeaAoLwDmMazsuxb0645Dm/3amtTWqakPGp9ie9cby0PD+icdIVTaLFaiz+r0muE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779912331; c=relaxed/simple;
	bh=nBHVO2uEIfC/fRZ4iBxthqcYxIBWWZ28Mx/qLdThF44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oS6zS5gwagf8+XmzDu8Sh3FxofaIXqosd1E5ndOaRfvEsJKwVSZW4trtnyjRFEa2VTmfKbBJZKSKzN33IfmP5LUE2tQqhNX9YLFKAYfTqCU0HEfjsExCDsNzZmuoq3kncJ0siIIdEFsRt4XyqUG40dFbpXMP4002vK8ABWsfruM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YDi3ymlR; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779912330; x=1811448330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nBHVO2uEIfC/fRZ4iBxthqcYxIBWWZ28Mx/qLdThF44=;
  b=YDi3ymlRtBTclAUHYadXE9g3fbPiAH9GkHRZtHhVcRemcR4iQvaiaSQH
   Ats3ipc1WHTqV6PpEUeZkGz95ty4yZi6lduIJ3q5I0K9bm5Y03Qm/873o
   VCp3+PitkwFmxeSmUYtzPYsI3TZqjfjlad7bMUBTVACIliXwsBHlxduc8
   dh/H1k+56iyqZoM1V4s/jHJKN7OpyUVyn0y8/bhnpmkDAw/9X6VQk+obh
   XvS4EyhxYSp5RzhTt9gkHZ5OBUvUMzY7rD2CScKKF+paZRUlh/E6lUszU
   HHPgE+31oAdqnw5daSkYf1/UxDCLO8APBobPDalEr0LJeZKOSwNF09+oB
   g==;
X-CSE-ConnectionGUID: R2xkIuAHTnGWE84FUUdlOQ==
X-CSE-MsgGUID: Z/plD6c3SJiEi55bMyPxGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80940850"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="80940850"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:05:30 -0700
X-CSE-ConnectionGUID: sGKEdZspSBOIr00PHIMhVw==
X-CSE-MsgGUID: zFSATI7mS5Gf/VoSAOoZ+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="247286949"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:05:28 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: fw: cut down NIC wakeups during dump
Date: Wed, 27 May 2026 23:04:58 +0300
Message-Id: <20260527230313.bec886142cc8.I41f2eaf2403b38147504d5dab0a7414de2699adc@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527200512.506707-1-miriam.rachel.korenblit@intel.com>
References: <20260527200512.506707-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-37026-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 163C25E9E22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

Currently, the dump code attempts to dump any number of
memories and register banks, as defined by the firmware.
Especially when the device is failing, this can lead to
excessive time spent attempting to acquire NIC access
over and over again.

Improve the code to only attempt to acquire NIC access
once or twice, but using the new memory dump functions
that may drop the spinlock etc. Mark all dump regions
that require NIC access, and skip them if we couldn't
obtain that.

In order to avoid CPU latency due to the increased time
holding the spinlock (and possibly disabling softirqs),
drop locks and call cond_resched() after each section
(if holding NIC access) but don't release HW NIC access.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 90 +++++++++----------
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  5 ++
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 11 +++
 .../intel/iwlwifi/pcie/gen1_2/internal.h      |  1 +
 .../intel/iwlwifi/pcie/gen1_2/trans.c         |  2 +-
 5 files changed, 63 insertions(+), 46 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 069c3bad6f29..337e312c2f43 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -103,7 +103,7 @@ static int iwl_dump_ini_prph_mac_iter_common(struct iwl_fw_runtime *fwrt,
 	range->internal_base_addr = cpu_to_le32(addr);
 	range->range_data_size = size;
 	for (i = 0; i < le32_to_cpu(size); i += 4)
-		*val++ = cpu_to_le32(iwl_read_prph(fwrt->trans, addr + i));
+		*val++ = cpu_to_le32(iwl_trans_read_prph(fwrt->trans, addr + i));
 
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
@@ -158,9 +158,6 @@ static int iwl_dump_ini_prph_phy_iter_common(struct iwl_fw_runtime *fwrt,
 	indirect_wr_addr += le32_to_cpu(offset);
 	indirect_rd_addr += le32_to_cpu(offset);
 
-	if (!iwl_trans_grab_nic_access(fwrt->trans))
-		return -EBUSY;
-
 	dphy_addr = (offset) ? WFPM_LMAC2_PS_CTL_RW : WFPM_LMAC1_PS_CTL_RW;
 	dphy_state = iwl_read_umac_prph_no_grab(fwrt->trans, dphy_addr);
 
@@ -194,7 +191,6 @@ static int iwl_dump_ini_prph_phy_iter_common(struct iwl_fw_runtime *fwrt,
 		*val++ = cpu_to_le32(prph_val);
 	}
 
-	iwl_trans_release_nic_access(fwrt->trans);
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
 
@@ -283,8 +279,8 @@ static int iwl_dump_ini_dev_mem_iter(struct iwl_fw_runtime *fwrt,
 
 	range->internal_base_addr = cpu_to_le32(addr);
 	range->range_data_size = reg->dev_addr.size;
-	iwl_trans_read_mem_bytes(fwrt->trans, addr, range->data,
-				 le32_to_cpu(reg->dev_addr.size));
+	iwl_trans_read_mem_bytes_no_grab(fwrt->trans, addr, range->data,
+					 le32_to_cpu(reg->dev_addr.size));
 
 	if (reg->sub_type == IWL_FW_INI_REGION_DEVICE_MEMORY_SUBTYPE_HW_SMEM &&
 	    fwrt->sanitize_ops && fwrt->sanitize_ops->frob_txf)
@@ -368,8 +364,8 @@ static int iwl_dump_ini_mon_smem_iter(struct iwl_fw_runtime *fwrt,
 
 	range->internal_base_addr = cpu_to_le32(addr);
 	range->range_data_size = reg->internal_buffer.size;
-	iwl_trans_read_mem_bytes(fwrt->trans, addr, range->data,
-				 le32_to_cpu(reg->internal_buffer.size));
+	iwl_trans_read_mem_bytes_no_grab(fwrt->trans, addr, range->data,
+					 le32_to_cpu(reg->internal_buffer.size));
 
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
@@ -443,9 +439,6 @@ static int iwl_dump_ini_txf_iter(struct iwl_fw_runtime *fwrt,
 	if (!iwl_ini_txf_iter(fwrt, reg_data, idx))
 		return -EIO;
 
-	if (!iwl_trans_grab_nic_access(fwrt->trans))
-		return -EBUSY;
-
 	range->fifo_hdr.fifo_num = cpu_to_le32(iter->fifo);
 	range->fifo_hdr.num_of_registers = cpu_to_le32(registers_num);
 	range->range_data_size = cpu_to_le32(iter->fifo_size + registers_size);
@@ -489,8 +482,6 @@ static int iwl_dump_ini_txf_iter(struct iwl_fw_runtime *fwrt,
 					     reg_dump, iter->fifo_size);
 
 out:
-	iwl_trans_release_nic_access(fwrt->trans);
-
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
 
@@ -511,9 +502,6 @@ iwl_dump_ini_prph_snps_dphyip_iter(struct iwl_fw_runtime *fwrt,
 	range->internal_base_addr = cpu_to_le32(addr);
 	range->range_data_size = reg->dev_addr.size;
 
-	if (!iwl_trans_grab_nic_access(fwrt->trans))
-		return -EBUSY;
-
 	indirect_rd_wr_addr += le32_to_cpu(offset);
 
 	dphy_addr = offset ? WFPM_LMAC2_PS_CTL_RW : WFPM_LMAC1_PS_CTL_RW;
@@ -537,7 +525,6 @@ iwl_dump_ini_prph_snps_dphyip_iter(struct iwl_fw_runtime *fwrt,
 				     DPHYIP_INDIRECT_RD_SHIFT);
 	}
 
-	iwl_trans_release_nic_access(fwrt->trans);
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
 
@@ -626,9 +613,6 @@ static int iwl_dump_ini_rxf_iter(struct iwl_fw_runtime *fwrt,
 	if (!rxf_data.size)
 		return -EIO;
 
-	if (!iwl_trans_grab_nic_access(fwrt->trans))
-		return -EBUSY;
-
 	range->fifo_hdr.fifo_num = cpu_to_le32(rxf_data.fifo_num);
 	range->fifo_hdr.num_of_registers = cpu_to_le32(registers_num);
 	range->range_data_size = cpu_to_le32(rxf_data.size + registers_size);
@@ -668,8 +652,6 @@ static int iwl_dump_ini_rxf_iter(struct iwl_fw_runtime *fwrt,
 		*data++ = cpu_to_le32(iwl_trans_read_prph(fwrt->trans, addr));
 
 out:
-	iwl_trans_release_nic_access(fwrt->trans);
-
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
 
@@ -686,8 +668,8 @@ iwl_dump_ini_err_table_iter(struct iwl_fw_runtime *fwrt,
 
 	range->internal_base_addr = cpu_to_le32(addr);
 	range->range_data_size = err_table->size;
-	iwl_trans_read_mem_bytes(fwrt->trans, addr, range->data,
-				 le32_to_cpu(err_table->size));
+	iwl_trans_read_mem_bytes_no_grab(fwrt->trans, addr, range->data,
+					 le32_to_cpu(err_table->size));
 
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
@@ -707,8 +689,8 @@ iwl_dump_ini_special_mem_iter(struct iwl_fw_runtime *fwrt,
 
 	range->internal_base_addr = cpu_to_le32(addr);
 	range->range_data_size = special_mem->size;
-	iwl_trans_read_mem_bytes(fwrt->trans, addr, range->data,
-				 le32_to_cpu(special_mem->size));
+	iwl_trans_read_mem_bytes_no_grab(fwrt->trans, addr, range->data,
+					 le32_to_cpu(special_mem->size));
 
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
@@ -724,9 +706,6 @@ iwl_dump_ini_dbgi_sram_iter(struct iwl_fw_runtime *fwrt,
 	u32 prph_data;
 	int i;
 
-	if (!iwl_trans_grab_nic_access(fwrt->trans))
-		return -EBUSY;
-
 	range->range_data_size = reg->dev_addr.size;
 	for (i = 0; i < (le32_to_cpu(reg->dev_addr.size) / 4); i++) {
 		prph_data =
@@ -734,13 +713,11 @@ iwl_dump_ini_dbgi_sram_iter(struct iwl_fw_runtime *fwrt,
 					    (i % 2) ?
 						DBGI_SRAM_TARGET_ACCESS_RDATA_MSB :
 						DBGI_SRAM_TARGET_ACCESS_RDATA_LSB);
-		if (iwl_trans_is_hw_error_value(prph_data)) {
-			iwl_trans_release_nic_access(fwrt->trans);
+		if (iwl_trans_is_hw_error_value(prph_data))
 			return -EBUSY;
-		}
 		*val++ = cpu_to_le32(prph_data);
 	}
-	iwl_trans_release_nic_access(fwrt->trans);
+
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
 
@@ -787,8 +764,8 @@ static int iwl_dump_ini_imr_iter(struct iwl_fw_runtime *fwrt,
 	fwrt->trans->dbg.imr_data.imr_curr_addr = imr_curr_addr + size_to_dump;
 	fwrt->trans->dbg.imr_data.imr2sram_remainbyte -= size_to_dump;
 
-	iwl_trans_read_mem_bytes(fwrt->trans, sram_addr, range->data,
-				 size_to_dump);
+	iwl_trans_read_mem_bytes_no_grab(fwrt->trans, sram_addr, range->data,
+					 size_to_dump);
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
 
@@ -842,11 +819,6 @@ iwl_dump_ini_mon_fill_header(struct iwl_fw_runtime *fwrt, u32 alloc_id,
 			     struct iwl_fw_ini_monitor_dump *data,
 			     const struct iwl_fw_mon_regs *addrs)
 {
-	if (!iwl_trans_grab_nic_access(fwrt->trans)) {
-		IWL_ERR(fwrt, "Failed to get monitor header\n");
-		return NULL;
-	}
-
 	data->write_ptr = iwl_get_mon_reg(fwrt, alloc_id,
 					  &addrs->write_ptr);
 	if (fwrt->trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
@@ -859,8 +831,6 @@ iwl_dump_ini_mon_fill_header(struct iwl_fw_runtime *fwrt, u32 alloc_id,
 	data->cur_frag = iwl_get_mon_reg(fwrt, alloc_id,
 					 &addrs->cur_frag);
 
-	iwl_trans_release_nic_access(fwrt->trans);
-
 	data->header.version = cpu_to_le32(IWL_INI_DUMP_VER);
 
 	return data->data;
@@ -1266,6 +1236,7 @@ iwl_dump_ini_imr_get_size(struct iwl_fw_runtime *fwrt,
  *	the first range or NULL if failed to fill headers.
  * @fill_range: copies a given memory range into the dump.
  *	Returns the size of the range or negative error value otherwise.
+ * @requires_nic_access: indicates to dump only if NIC access was acquired
  */
 struct iwl_dump_ini_mem_ops {
 	u32 (*get_num_of_ranges)(struct iwl_fw_runtime *fwrt,
@@ -1278,6 +1249,7 @@ struct iwl_dump_ini_mem_ops {
 	int (*fill_range)(struct iwl_fw_runtime *fwrt,
 			  struct iwl_dump_ini_region_data *reg_data,
 			  void *range, int idx);
+	bool requires_nic_access;
 };
 
 struct iwl_fw_ini_dump_entry {
@@ -1374,7 +1346,8 @@ static void iwl_dump_ini_mem_prep(struct iwl_fw_runtime *fwrt,
 }
 
 static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt,
-			    struct iwl_fw_ini_dump_entry *entry)
+			    struct iwl_fw_ini_dump_entry *entry,
+			    bool have_nic_access)
 {
 	struct iwl_dump_ini_region_data *reg_data = &entry->reg_data;
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
@@ -1388,6 +1361,9 @@ static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt,
 	u32 free_size;
 	u64 header_size;
 
+	if (!have_nic_access && ops->requires_nic_access)
+		goto out_err;
+
 	tlv = (void *)entry->data;
 	header = (void *)tlv->data;
 
@@ -1541,36 +1517,42 @@ static const struct iwl_dump_ini_mem_ops iwl_dump_ini_region_ops[] = {
 		.get_size = iwl_dump_ini_mon_smem_get_size,
 		.fill_mem_hdr = iwl_dump_ini_mon_smem_fill_header,
 		.fill_range = iwl_dump_ini_mon_smem_iter,
+		.requires_nic_access = true,
 	},
 	[IWL_FW_INI_REGION_DRAM_BUFFER] = {
 		.get_num_of_ranges = iwl_dump_ini_mon_dram_ranges,
 		.get_size = iwl_dump_ini_mon_dram_get_size,
 		.fill_mem_hdr = iwl_dump_ini_mon_dram_fill_header,
 		.fill_range = iwl_dump_ini_mon_dram_iter,
+		.requires_nic_access = true,
 	},
 	[IWL_FW_INI_REGION_TXF] = {
 		.get_num_of_ranges = iwl_dump_ini_txf_ranges,
 		.get_size = iwl_dump_ini_txf_get_size,
 		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
 		.fill_range = iwl_dump_ini_txf_iter,
+		.requires_nic_access = true,
 	},
 	[IWL_FW_INI_REGION_RXF] = {
 		.get_num_of_ranges = iwl_dump_ini_single_range,
 		.get_size = iwl_dump_ini_rxf_get_size,
 		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
 		.fill_range = iwl_dump_ini_rxf_iter,
+		.requires_nic_access = true,
 	},
 	[IWL_FW_INI_REGION_LMAC_ERROR_TABLE] = {
 		.get_num_of_ranges = iwl_dump_ini_single_range,
 		.get_size = iwl_dump_ini_err_table_get_size,
 		.fill_mem_hdr = iwl_dump_ini_err_table_fill_header,
 		.fill_range = iwl_dump_ini_err_table_iter,
+		.requires_nic_access = true,
 	},
 	[IWL_FW_INI_REGION_UMAC_ERROR_TABLE] = {
 		.get_num_of_ranges = iwl_dump_ini_single_range,
 		.get_size = iwl_dump_ini_err_table_get_size,
 		.fill_mem_hdr = iwl_dump_ini_err_table_fill_header,
 		.fill_range = iwl_dump_ini_err_table_iter,
+		.requires_nic_access = true,
 	},
 	[IWL_FW_INI_REGION_RSP_OR_NOTIF] = {
 		.get_num_of_ranges = iwl_dump_ini_single_range,
@@ -1583,30 +1565,35 @@ static const struct iwl_dump_ini_mem_ops iwl_dump_ini_region_ops[] = {
 		.get_size = iwl_dump_ini_mem_get_size,
 		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
 		.fill_range = iwl_dump_ini_dev_mem_iter,
+		.requires_nic_access = true,
 	},
 	[IWL_FW_INI_REGION_PERIPHERY_MAC] = {
 		.get_num_of_ranges = iwl_dump_ini_mem_ranges,
 		.get_size = iwl_dump_ini_mem_get_size,
 		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
 		.fill_range = iwl_dump_ini_prph_mac_iter,
+		.requires_nic_access = true,
 	},
 	[IWL_FW_INI_REGION_PERIPHERY_PHY] = {
 		.get_num_of_ranges = iwl_dump_ini_mem_ranges,
 		.get_size = iwl_dump_ini_mem_get_size,
 		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
 		.fill_range = iwl_dump_ini_prph_phy_iter,
+		.requires_nic_access = true,
 	},
 	[IWL_FW_INI_REGION_PERIPHERY_MAC_RANGE] = {
 		.get_num_of_ranges = iwl_dump_ini_mem_block_ranges,
 		.get_size = iwl_dump_ini_mem_block_get_size,
 		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
 		.fill_range = iwl_dump_ini_prph_mac_block_iter,
+		.requires_nic_access = true,
 	},
 	[IWL_FW_INI_REGION_PERIPHERY_PHY_RANGE] = {
 		.get_num_of_ranges = iwl_dump_ini_mem_block_ranges,
 		.get_size = iwl_dump_ini_mem_block_get_size,
 		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
 		.fill_range = iwl_dump_ini_prph_phy_block_iter,
+		.requires_nic_access = true,
 	},
 	[IWL_FW_INI_REGION_PERIPHERY_AUX] = {},
 	[IWL_FW_INI_REGION_PAGING] = {
@@ -1626,6 +1613,7 @@ static const struct iwl_dump_ini_mem_ops iwl_dump_ini_region_ops[] = {
 		.get_size = iwl_dump_ini_imr_get_size,
 		.fill_mem_hdr = iwl_dump_ini_imr_fill_header,
 		.fill_range = iwl_dump_ini_imr_iter,
+		.requires_nic_access = true,
 	},
 	[IWL_FW_INI_REGION_PCI_IOSF_CONFIG] = {
 		.get_num_of_ranges = iwl_dump_ini_mem_ranges,
@@ -1638,18 +1626,21 @@ static const struct iwl_dump_ini_mem_ops iwl_dump_ini_region_ops[] = {
 		.get_size = iwl_dump_ini_special_mem_get_size,
 		.fill_mem_hdr = iwl_dump_ini_special_mem_fill_header,
 		.fill_range = iwl_dump_ini_special_mem_iter,
+		.requires_nic_access = true,
 	},
 	[IWL_FW_INI_REGION_DBGI_SRAM] = {
 		.get_num_of_ranges = iwl_dump_ini_mem_ranges,
 		.get_size = iwl_dump_ini_mon_dbgi_get_size,
 		.fill_mem_hdr = iwl_dump_ini_mon_dbgi_fill_header,
 		.fill_range = iwl_dump_ini_dbgi_sram_iter,
+		.requires_nic_access = true,
 	},
 	[IWL_FW_INI_REGION_PERIPHERY_SNPS_DPHYIP] = {
 		.get_num_of_ranges = iwl_dump_ini_mem_ranges,
 		.get_size = iwl_dump_ini_mem_get_size,
 		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
 		.fill_range = iwl_dump_ini_prph_snps_dphyip_iter,
+		.requires_nic_access = true,
 	},
 };
 
@@ -1733,8 +1724,11 @@ iwl_dump_ini_dump_entries(struct iwl_fw_runtime *fwrt,
 			  enum iwl_dump_ini_region_selector which)
 {
 	struct iwl_fw_ini_dump_entry *entry, *tmp;
+	bool have_nic_access;
 	u32 size = 0;
 
+	have_nic_access = iwl_trans_grab_nic_access(fwrt->trans);
+
 	list_for_each_entry_safe(entry, tmp, list, list) {
 		u32 dp = entry->region_dump_policy;
 
@@ -1751,9 +1745,15 @@ iwl_dump_ini_dump_entries(struct iwl_fw_runtime *fwrt,
 			break;
 		}
 
-		size += iwl_dump_ini_mem(fwrt, entry);
+		size += iwl_dump_ini_mem(fwrt, entry, have_nic_access);
+
+		if (have_nic_access)
+			iwl_trans_resched_with_nic_access(fwrt->trans);
 	}
 
+	if (have_nic_access)
+		iwl_trans_release_nic_access(fwrt->trans);
+
 	return size;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 0009488ca51b..73aae1125042 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -558,6 +558,11 @@ bool iwl_trans_grab_nic_access(struct iwl_trans *trans)
 }
 IWL_EXPORT_SYMBOL(iwl_trans_grab_nic_access);
 
+void iwl_trans_resched_with_nic_access(struct iwl_trans *trans)
+{
+	iwl_trans_pcie_resched_with_nic_access(trans);
+}
+
 void __releases(nic_access)
 iwl_trans_release_nic_access(struct iwl_trans *trans)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 3ae840e546e8..914864005704 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -981,6 +981,17 @@ void iwl_trans_set_bits_mask(struct iwl_trans *trans, u32 reg,
 
 bool iwl_trans_grab_nic_access(struct iwl_trans *trans);
 
+/**
+ * iwl_trans_resched_with_nic_access - reschedule while holding NIC access
+ * @trans: the transport pointer
+ *
+ * This can be called while holding NIC access, during periods where
+ * the lock itself isn't interesting, the NIC should remain active,
+ * but a lot of processing is happening and the CPU may need to be
+ * released. In practice, this is only during FW dump.
+ */
+void iwl_trans_resched_with_nic_access(struct iwl_trans *trans);
+
 void __releases(nic_access)
 iwl_trans_release_nic_access(struct iwl_trans *trans);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
index abc0c831d1ca..d84c7c1efee1 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
@@ -1203,6 +1203,7 @@ void iwl_trans_pcie_set_bits_mask(struct iwl_trans *trans, u32 reg,
 int iwl_trans_pcie_read_config32(struct iwl_trans *trans, u32 ofs,
 				 u32 *val);
 bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans);
+void iwl_trans_pcie_resched_with_nic_access(struct iwl_trans *trans);
 void __releases(nic_access_nobh)
 iwl_trans_pcie_release_nic_access(struct iwl_trans *trans);
 void iwl_pcie_alloc_fw_monitor(struct iwl_trans *trans, u8 max_power);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 1c4ee76d8387..40fd5f3fdeb7 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -2424,7 +2424,7 @@ bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
 	return false;
 }
 
-static void iwl_trans_pcie_resched_with_nic_access(struct iwl_trans *trans)
+void iwl_trans_pcie_resched_with_nic_access(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
-- 
2.34.1


