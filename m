Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAFEFD5C35
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2019 09:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbfJNHUf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Oct 2019 03:20:35 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:49180 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729928AbfJNHUe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Oct 2019 03:20:34 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iJuec-0007ae-Je; Mon, 14 Oct 2019 10:20:31 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 14 Oct 2019 10:20:08 +0300
Message-Id: <20191014101813.94cd8cb92b9e.I81e1abe9607cfbf888c52f39eee2e575b6150390@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191014072019.1254-1-luca@coelho.fi>
References: <20191014072019.1254-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 05/16] iwlwifi: dbg_ini: add monitor dumping support
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Allow collecting monitor data in ini debug mode.
Implement both SMEM and DRAM monitor regions dumping.
For DRAM monitor, support DBGC1, DBGC2 and DBGC3 and support several
DRAM fragments per DBGC.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  55 ++++-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |  25 ++-
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  41 ++--
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 202 +++++++++++++++++-
 .../wireless/intel/iwlwifi/fw/error-dump.h    |   2 +
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  28 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |   7 +
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  15 ++
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |  78 +++++--
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  41 +++-
 10 files changed, 440 insertions(+), 54 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 5e355c4957df..435cb8013a23 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -54,6 +54,7 @@
 #include <linux/module.h>
 #include <linux/stringify.h>
 #include "iwl-config.h"
+#include "iwl-prph.h"
 
 /* Highest firmware API version supported */
 #define IWL_22000_UCODE_API_MAX	50
@@ -183,23 +184,49 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 	.min_umac_error_event_table = 0x400000,				\
 	.d3_debug_data_base_addr = 0x401000,				\
 	.d3_debug_data_length = 60 * 1024,				\
-	.fw_mon_smem_write_ptr_addr = 0xa0c16c,				\
-	.fw_mon_smem_write_ptr_msk = 0xfffff,				\
-	.fw_mon_smem_cycle_cnt_ptr_addr = 0xa0c174,			\
-	.fw_mon_smem_cycle_cnt_ptr_msk = 0xfffff
+	.mon_smem_regs = {						\
+		.write_ptr = {						\
+			.addr = LDBG_M2S_BUF_WPTR,			\
+			.mask = LDBG_M2S_BUF_WPTR_VAL_MSK,		\
+	},								\
+		.cycle_cnt = {						\
+			.addr = LDBG_M2S_BUF_WRAP_CNT,			\
+			.mask = LDBG_M2S_BUF_WRAP_CNT_VAL_MSK,		\
+		},							\
+	}
 
 #define IWL_DEVICE_22500						\
 	IWL_DEVICE_22000_COMMON,					\
 	.trans.device_family = IWL_DEVICE_FAMILY_22000,			\
 	.trans.base_params = &iwl_22000_base_params,			\
 	.trans.csr = &iwl_csr_v1,					\
-	.gp2_reg_addr = 0xa02c68
+	.gp2_reg_addr = 0xa02c68,					\
+	.mon_dram_regs = {						\
+		.write_ptr = {						\
+			.addr = MON_BUFF_WRPTR_VER2,			\
+			.mask = 0xffffffff,				\
+		},							\
+		.cycle_cnt = {						\
+			.addr = MON_BUFF_CYCLE_CNT_VER2,		\
+			.mask = 0xffffffff,				\
+		},							\
+	}
 
 #define IWL_DEVICE_22560						\
 	IWL_DEVICE_22000_COMMON,					\
 	.trans.device_family = IWL_DEVICE_FAMILY_22560,			\
 	.trans.base_params = &iwl_22560_base_params,			\
-	.trans.csr = &iwl_csr_v2
+	.trans.csr = &iwl_csr_v2,					\
+	.mon_dram_regs = {						\
+		.write_ptr = {						\
+			.addr = MON_BUFF_WRPTR_VER2,			\
+			.mask = 0xffffffff,				\
+		},							\
+		.cycle_cnt = {						\
+			.addr = MON_BUFF_CYCLE_CNT_VER2,		\
+			.mask = 0xffffffff,				\
+		},							\
+	}
 
 #define IWL_DEVICE_AX210						\
 	IWL_DEVICE_22000_COMMON,					\
@@ -209,7 +236,21 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 	.trans.csr = &iwl_csr_v1,					\
 	.min_txq_size = 128,						\
 	.gp2_reg_addr = 0xd02c68,					\
-	.min_256_ba_txq_size = 512
+	.min_256_ba_txq_size = 512,					\
+	.mon_dram_regs = {						\
+		.write_ptr = {						\
+			.addr = DBGC_CUR_DBGBUF_STATUS,			\
+			.mask = DBGC_CUR_DBGBUF_STATUS_OFFSET_MSK,	\
+		},							\
+		.cycle_cnt = {						\
+			.addr = DBGC_DBGBUF_WRAP_AROUND,		\
+			.mask = 0xffffffff,				\
+		},							\
+		.cur_frag = {						\
+			.addr = DBGC_CUR_DBGBUF_STATUS,			\
+			.mask = DBGC_CUR_DBGBUF_STATUS_IDX_MSK,		\
+		},							\
+	}
 
 const struct iwl_cfg iwl22000_2ac_cfg_hr = {
 	.name = "Intel(R) Dual Band Wireless AC 22000",
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index e8372b67df03..e9155b9b5ee4 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -55,6 +55,7 @@
 #include <linux/stringify.h>
 #include "iwl-config.h"
 #include "fw/file.h"
+#include "iwl-prph.h"
 
 /* Highest firmware API version supported */
 #define IWL9000_UCODE_API_MAX	46
@@ -149,10 +150,26 @@ static const struct iwl_tt_params iwl9000_tt_params = {
 	.ht_params = &iwl9000_ht_params,				\
 	.nvm_ver = IWL9000_NVM_VERSION,					\
 	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,		\
-	.fw_mon_smem_write_ptr_addr = 0xa0476c,				\
-	.fw_mon_smem_write_ptr_msk = 0xfffff,				\
-	.fw_mon_smem_cycle_cnt_ptr_addr = 0xa04774,			\
-	.fw_mon_smem_cycle_cnt_ptr_msk = 0xfffff
+	.mon_smem_regs = {						\
+		.write_ptr = {						\
+			.addr = LDBG_M2S_BUF_WPTR,			\
+			.mask = LDBG_M2S_BUF_WPTR_VAL_MSK,		\
+		},							\
+		.cycle_cnt = {						\
+			.addr = LDBG_M2S_BUF_WRAP_CNT,			\
+			.mask = LDBG_M2S_BUF_WRAP_CNT_VAL_MSK,		\
+		},							\
+	},								\
+	.mon_dram_regs = {						\
+		.write_ptr = {						\
+			.addr = MON_BUFF_WRPTR_VER2,			\
+			.mask = 0xffffffff,				\
+		},							\
+		.cycle_cnt = {						\
+			.addr = MON_BUFF_CYCLE_CNT_VER2,		\
+			.mask = 0xffffffff,				\
+		},							\
+	}
 
 
 const struct iwl_cfg iwl9160_2ac_cfg = {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index 073a729cd4db..2754060dc4c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -73,28 +73,6 @@ struct iwl_fw_ini_header {
 	u8 data[];
 } __packed; /* FW_DEBUG_TLV_HEADER_S */
 
-/**
- * struct iwl_fw_ini_allocation_tlv - (IWL_UCODE_TLV_TYPE_BUFFER_ALLOCATION)
- * buffer allocation TLV - for debug
- *
- * @iwl_fw_ini_header: header
- * @allocation_id: &enum iwl_fw_ini_allocation_id - to bind allocation and hcmd
- *	if needed (DBGC1/DBGC2/SDFX/...)
- * @buffer_location: type of iwl_fw_ini_buffer_location
- * @size: size in bytes
- * @max_fragments: the maximum allowed fragmentation in the desired memory
- *	allocation above
- * @min_frag_size: the minimum allowed fragmentation size in bytes
- */
-struct iwl_fw_ini_allocation_tlv {
-	struct iwl_fw_ini_header header;
-	__le32 allocation_id;
-	__le32 buffer_location;
-	__le32 size;
-	__le32 max_fragments;
-	__le32 min_frag_size;
-} __packed; /* FW_DEBUG_TLV_BUFFER_ALLOCATION_TLV_S_VER_1 */
-
 /**
  * enum iwl_fw_ini_dbg_domain - debug domains
  * allows to send host cmd or collect memory region if a given domain is enabled
@@ -350,6 +328,25 @@ struct iwl_fw_ini_trigger {
 	__le32 data[];
 } __packed; /* FW_TLV_DEBUG_TRIGGER_CONFIG_API_S_VER_1 */
 
+/**
+ * struct iwl_fw_ini_allocation_tlv - Allocates DRAM buffers
+ *
+ * @hdr: debug header
+ * @alloc_id: allocation id. One of &enum iwl_fw_ini_allocation_id
+ * @buf_location: buffer location. One of &enum iwl_fw_ini_buffer_location
+ * @req_size: requested buffer size
+ * @max_frags_num: maximum number of fragments
+ * @min_size: minimum buffer size
+ */
+struct iwl_fw_ini_allocation_tlv {
+	struct iwl_fw_ini_header hdr;
+	__le32 alloc_id;
+	__le32 buf_location;
+	__le32 req_size;
+	__le32 max_frags_num;
+	__le32 min_size;
+} __packed; /* FW_TLV_DEBUG_BUFFER_ALLOCATION_API_S_VER_1 */
+
 /**
  * struct iwl_fw_ini_trigger_tlv - trigger TLV
  *
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 0f9a3c221bd9..dbaaac2486c7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1165,6 +1165,42 @@ static int iwl_dump_ini_paging_iter(struct iwl_fw_runtime *fwrt,
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
 
+static int
+iwl_dump_ini_mon_dram_iter(struct iwl_fw_runtime *fwrt,
+			   struct iwl_dump_ini_region_data *reg_data,
+			   void *range_ptr, int idx)
+{
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+	struct iwl_fw_ini_error_dump_range *range = range_ptr;
+	struct iwl_dram_data *frag;
+	u32 alloc_id = le32_to_cpu(reg->dram_alloc_id);
+
+	frag = &fwrt->trans->dbg.fw_mon_ini[alloc_id].frags[idx];
+
+	range->dram_base_addr = cpu_to_le64(frag->physical);
+	range->range_data_size = cpu_to_le32(frag->size);
+
+	memcpy(range->data, frag->block, frag->size);
+
+	return sizeof(*range) + le32_to_cpu(range->range_data_size);
+}
+
+static int iwl_dump_ini_mon_smem_iter(struct iwl_fw_runtime *fwrt,
+				      struct iwl_dump_ini_region_data *reg_data,
+				      void *range_ptr, int idx)
+{
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+	struct iwl_fw_ini_error_dump_range *range = range_ptr;
+	u32 addr = le32_to_cpu(reg->internal_buffer.base_addr);
+
+	range->internal_base_addr = cpu_to_le32(addr);
+	range->range_data_size = reg->internal_buffer.size;
+	iwl_trans_read_mem_bytes(fwrt->trans, addr, range->data,
+				 le32_to_cpu(reg->internal_buffer.size));
+
+	return sizeof(*range) + le32_to_cpu(range->range_data_size);
+}
+
 static bool iwl_ini_txf_iter(struct iwl_fw_runtime *fwrt,
 			     struct iwl_dump_ini_region_data *reg_data, int idx)
 {
@@ -1406,6 +1442,88 @@ iwl_dump_ini_mem_fill_header(struct iwl_fw_runtime *fwrt,
 	return dump->ranges;
 }
 
+/**
+ * mask_apply_and_normalize - applies mask on val and normalize the result
+ *
+ * The normalization is based on the first set bit in the mask
+ *
+ * @val: value
+ * @mask: mask to apply and to normalize with
+ */
+static u32 mask_apply_and_normalize(u32 val, u32 mask)
+{
+	return (val & mask) >> (ffs(mask) - 1);
+}
+
+static __le32 iwl_get_mon_reg(struct iwl_fw_runtime *fwrt, u32 alloc_id,
+			      const struct iwl_fw_mon_reg *reg_info)
+{
+	u32 val, offs;
+
+	/* The header addresses of DBGCi is calculate as follows:
+	 * DBGC1 address + (0x100 * i)
+	 */
+	offs = (alloc_id - IWL_FW_INI_ALLOCATION_ID_DBGC1) * 0x100;
+
+	if (!reg_info || !reg_info->addr || !reg_info->mask)
+		return 0;
+
+	val = iwl_read_prph_no_grab(fwrt->trans, reg_info->addr + offs);
+
+	return cpu_to_le32(mask_apply_and_normalize(val, reg_info->mask));
+}
+
+static void *
+iwl_dump_ini_mon_fill_header(struct iwl_fw_runtime *fwrt,
+			     struct iwl_dump_ini_region_data *reg_data,
+			     struct iwl_fw_ini_monitor_dump *data,
+			     const struct iwl_fw_mon_regs *addrs)
+{
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+	u32 alloc_id = le32_to_cpu(reg->dram_alloc_id);
+	unsigned long flags;
+
+	if (!iwl_trans_grab_nic_access(fwrt->trans, &flags)) {
+		IWL_ERR(fwrt, "Failed to get monitor header\n");
+		return NULL;
+	}
+
+	data->write_ptr = iwl_get_mon_reg(fwrt, alloc_id,
+					  &addrs->write_ptr);
+	data->cycle_cnt = iwl_get_mon_reg(fwrt, alloc_id,
+					  &addrs->cycle_cnt);
+	data->cur_frag = iwl_get_mon_reg(fwrt, alloc_id,
+					 &addrs->cur_frag);
+
+	iwl_trans_release_nic_access(fwrt->trans, &flags);
+
+	data->header.version = cpu_to_le32(IWL_INI_DUMP_VER);
+
+	return data->ranges;
+}
+
+static void *
+iwl_dump_ini_mon_dram_fill_header(struct iwl_fw_runtime *fwrt,
+				  struct iwl_dump_ini_region_data *reg_data,
+				  void *data)
+{
+	struct iwl_fw_ini_monitor_dump *mon_dump = (void *)data;
+
+	return iwl_dump_ini_mon_fill_header(fwrt, reg_data, mon_dump,
+					    &fwrt->trans->cfg->mon_dram_regs);
+}
+
+static void *
+iwl_dump_ini_mon_smem_fill_header(struct iwl_fw_runtime *fwrt,
+				  struct iwl_dump_ini_region_data *reg_data,
+				  void *data)
+{
+	struct iwl_fw_ini_monitor_dump *mon_dump = (void *)data;
+
+	return iwl_dump_ini_mon_fill_header(fwrt, reg_data, mon_dump,
+					    &fwrt->trans->cfg->mon_smem_regs);
+}
+
 static u32 iwl_dump_ini_mem_ranges(struct iwl_fw_runtime *fwrt,
 				   struct iwl_dump_ini_region_data *reg_data)
 {
@@ -1423,6 +1541,27 @@ static u32 iwl_dump_ini_paging_ranges(struct iwl_fw_runtime *fwrt,
 	return fwrt->num_of_paging_blk;
 }
 
+static u32
+iwl_dump_ini_mon_dram_ranges(struct iwl_fw_runtime *fwrt,
+			     struct iwl_dump_ini_region_data *reg_data)
+{
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+	struct iwl_fw_mon *fw_mon;
+	u32 ranges = 0, alloc_id = le32_to_cpu(reg->dram_alloc_id);
+	int i;
+
+	fw_mon = &fwrt->trans->dbg.fw_mon_ini[alloc_id];
+
+	for (i = 0; i < fw_mon->num_frags; i++) {
+		if (!fw_mon->frags[i].size)
+			break;
+
+		ranges++;
+	}
+
+	return ranges;
+}
+
 static u32 iwl_dump_ini_txf_ranges(struct iwl_fw_runtime *fwrt,
 				   struct iwl_dump_ini_region_data *reg_data)
 {
@@ -1476,6 +1615,55 @@ iwl_dump_ini_paging_get_size(struct iwl_fw_runtime *fwrt,
 	return size;
 }
 
+static u32
+iwl_dump_ini_mon_dram_get_size(struct iwl_fw_runtime *fwrt,
+			       struct iwl_dump_ini_region_data *reg_data)
+{
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+	struct iwl_fw_mon *fw_mon;
+	u32 size = 0, alloc_id = le32_to_cpu(reg->dram_alloc_id);
+	int i;
+
+	fw_mon = &fwrt->trans->dbg.fw_mon_ini[alloc_id];
+
+	for (i = 0; i < fw_mon->num_frags; i++) {
+		struct iwl_dram_data *frag = &fw_mon->frags[i];
+
+		if (!frag->size)
+			break;
+
+		size += sizeof(struct iwl_fw_ini_error_dump_range) + frag->size;
+	}
+
+	if (size)
+		size += sizeof(struct iwl_fw_ini_monitor_dump);
+
+	return size;
+}
+
+static u32
+iwl_dump_ini_mon_smem_get_size(struct iwl_fw_runtime *fwrt,
+			       struct iwl_dump_ini_region_data *reg_data)
+{
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+	struct iwl_fw_ini_allocation_tlv *fw_mon_cfg;
+	u32 alloc_id = le32_to_cpu(reg->internal_buffer.alloc_id), size;
+
+	fw_mon_cfg = &fwrt->trans->dbg.fw_mon_cfg[alloc_id];
+	if (le32_to_cpu(fw_mon_cfg->buf_location) !=
+	    IWL_FW_INI_LOCATION_SRAM_PATH)
+		return 0;
+
+	size = le32_to_cpu(reg->internal_buffer.size);
+	if (!size)
+		return 0;
+
+	size += sizeof(struct iwl_fw_ini_monitor_dump) +
+		sizeof(struct iwl_fw_ini_error_dump_range);
+
+	return size;
+}
+
 static u32 iwl_dump_ini_txf_get_size(struct iwl_fw_runtime *fwrt,
 				     struct iwl_dump_ini_region_data *reg_data)
 {
@@ -1680,8 +1868,18 @@ static u32 iwl_dump_ini_info(struct iwl_fw_runtime *fwrt,
 
 static const struct iwl_dump_ini_mem_ops iwl_dump_ini_region_ops[] = {
 	[IWL_FW_INI_REGION_INVALID] = {},
-	[IWL_FW_INI_REGION_INTERNAL_BUFFER] = {},
-	[IWL_FW_INI_REGION_DRAM_BUFFER] = {},
+	[IWL_FW_INI_REGION_INTERNAL_BUFFER] = {
+		.get_num_of_ranges = iwl_dump_ini_single_range,
+		.get_size = iwl_dump_ini_mon_smem_get_size,
+		.fill_mem_hdr = iwl_dump_ini_mon_smem_fill_header,
+		.fill_range = iwl_dump_ini_mon_smem_iter,
+	},
+	[IWL_FW_INI_REGION_DRAM_BUFFER] = {
+		.get_num_of_ranges = iwl_dump_ini_mon_dram_ranges,
+		.get_size = iwl_dump_ini_mon_dram_get_size,
+		.fill_mem_hdr = iwl_dump_ini_mon_dram_fill_header,
+		.fill_range = iwl_dump_ini_mon_dram_iter,
+	},
 	[IWL_FW_INI_REGION_TXF] = {
 		.get_num_of_ranges = iwl_dump_ini_txf_ranges,
 		.get_size = iwl_dump_ini_txf_get_size,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
index 2ccf04dacd52..629af3f9c683 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -456,12 +456,14 @@ struct iwl_fw_error_dump_rb {
  * @header: header of the region
  * @write_ptr: write pointer position in the buffer
  * @cycle_cnt: cycles count
+ * @cur_frag: current fragment in use
  * @ranges: the memory ranges of this this region
  */
 struct iwl_fw_ini_monitor_dump {
 	struct iwl_fw_ini_error_dump_header header;
 	__le32 write_ptr;
 	__le32 cycle_cnt;
+	__le32 cur_frag;
 	struct iwl_fw_ini_error_dump_range ranges[];
 } __packed;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 214495a7165f..1b027a138b6b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -359,6 +359,28 @@ struct iwl_cfg_trans_params {
 	    bisr_workaround:1;
 };
 
+/**
+ * struct iwl_fw_mon_reg - FW monitor register info
+ * @addr: register address
+ * @mask: register mask
+ */
+struct iwl_fw_mon_reg {
+	u32 addr;
+	u32 mask;
+};
+
+/**
+ * struct iwl_fw_mon_regs - FW monitor registers
+ * @write_ptr: write pointer register
+ * @cycle_cnt: cycle count register
+ * @cur_frag: current fragment in use
+ */
+struct iwl_fw_mon_regs {
+	struct iwl_fw_mon_reg write_ptr;
+	struct iwl_fw_mon_reg cycle_cnt;
+	struct iwl_fw_mon_reg cur_frag;
+};
+
 /**
  * struct iwl_cfg
  * @trans: the trans-specific configuration part
@@ -471,12 +493,10 @@ struct iwl_cfg {
 	u32 d3_debug_data_base_addr;
 	u32 d3_debug_data_length;
 	u32 min_txq_size;
-	u32 fw_mon_smem_write_ptr_addr;
-	u32 fw_mon_smem_write_ptr_msk;
-	u32 fw_mon_smem_cycle_cnt_ptr_addr;
-	u32 fw_mon_smem_cycle_cnt_ptr_msk;
 	u32 gp2_reg_addr;
 	u32 min_256_ba_txq_size;
+	const struct iwl_fw_mon_regs mon_dram_regs;
+	const struct iwl_fw_mon_regs mon_smem_regs;
 };
 
 extern const struct iwl_csr_params iwl_csr_v1;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index f47e0f97acf8..de5ae35d84ca 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -374,6 +374,7 @@
 #define DBGC_CUR_DBGBUF_STATUS			(0xd03c1c)
 #define DBGC_DBGBUF_WRAP_AROUND			(0xd03c2c)
 #define DBGC_CUR_DBGBUF_STATUS_OFFSET_MSK	(0x00ffffff)
+#define DBGC_CUR_DBGBUF_STATUS_IDX_MSK		(0x0f000000)
 
 #define MON_DMARB_RD_CTL_ADDR		(0xa03c60)
 #define MON_DMARB_RD_DATA_ADDR		(0xa03c5c)
@@ -381,6 +382,12 @@
 #define DBGC_IN_SAMPLE			(0xa03c00)
 #define DBGC_OUT_CTRL			(0xa03c0c)
 
+/* M2S registers */
+#define LDBG_M2S_BUF_WPTR			(0xa0476c)
+#define LDBG_M2S_BUF_WRAP_CNT			(0xa04774)
+#define LDBG_M2S_BUF_WPTR_VAL_MSK		(0x000fffff)
+#define LDBG_M2S_BUF_WRAP_CNT_VAL_MSK		(0x000fffff)
+
 /* enable the ID buf for read */
 #define WFPM_PS_CTL_CLR			0xA0300C
 #define WFMP_MAC_ADDR_0			0xA03080
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 640530371194..b9ee6c83af87 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -678,6 +678,16 @@ struct iwl_dram_data {
 	int size;
 };
 
+/**
+ * struct iwl_fw_mon - fw monitor per allocation id
+ * @num_frags: number of fragments
+ * @frags: an array of DRAM buffer fragments
+ */
+struct iwl_fw_mon {
+	u32 num_frags;
+	struct iwl_dram_data *frags;
+};
+
 /**
  * struct iwl_self_init_dram - dram data used by self init process
  * @fw: lmac and umac dram data
@@ -706,6 +716,8 @@ struct iwl_self_init_dram {
  *	pointers was recevied via TLV. uses enum &iwl_error_event_table_status
  * @internal_ini_cfg: internal debug cfg state. Uses &enum iwl_ini_cfg_state
  * @external_ini_cfg: external debug cfg state. Uses &enum iwl_ini_cfg_state
+ * @fw_mon_cfg: debug buffer allocation configuration
+ * @fw_mon_ini: DRAM buffer fragments per allocation id
  * @fw_mon: DRAM buffer for firmware monitor
  * @hw_error: equals true if hw error interrupt was received from the FW
  * @ini_dest: debug monitor destination uses &enum iwl_fw_ini_buffer_location
@@ -726,6 +738,9 @@ struct iwl_trans_debug {
 	enum iwl_ini_cfg_state internal_ini_cfg;
 	enum iwl_ini_cfg_state external_ini_cfg;
 
+	struct iwl_fw_ini_allocation_tlv fw_mon_cfg[IWL_FW_INI_ALLOCATION_NUM];
+	struct iwl_fw_mon fw_mon_ini[IWL_FW_INI_ALLOCATION_NUM];
+
 	struct iwl_dram_data fw_mon;
 
 	bool hw_error;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index 2c8ce41718a2..d2274251921d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -55,6 +55,66 @@
 #include "internal.h"
 #include "iwl-prph.h"
 
+static void
+iwl_pcie_ctxt_info_dbg_enable(struct iwl_trans *trans,
+			      struct iwl_prph_scratch_hwm_cfg *dbg_cfg,
+			      u32 *control_flags)
+{
+	enum iwl_fw_ini_allocation_id alloc_id = IWL_FW_INI_ALLOCATION_ID_DBGC1;
+	struct iwl_fw_ini_allocation_tlv *fw_mon_cfg;
+	u32 dbg_flags = 0;
+
+	if (!iwl_trans_dbg_ini_valid(trans)) {
+		struct iwl_dram_data *fw_mon = &trans->dbg.fw_mon;
+
+		iwl_pcie_alloc_fw_monitor(trans, 0);
+
+		if (fw_mon->size) {
+			dbg_flags |= IWL_PRPH_SCRATCH_EDBG_DEST_DRAM;
+
+			IWL_DEBUG_FW(trans,
+				     "WRT: Applying DRAM buffer destination\n");
+
+			dbg_cfg->hwm_base_addr = cpu_to_le64(fw_mon->physical);
+			dbg_cfg->hwm_size = cpu_to_le32(fw_mon->size);
+		}
+
+		goto out;
+	}
+
+	fw_mon_cfg = &trans->dbg.fw_mon_cfg[alloc_id];
+
+	if (le32_to_cpu(fw_mon_cfg->buf_location) ==
+	    IWL_FW_INI_LOCATION_SRAM_PATH) {
+		dbg_flags |= IWL_PRPH_SCRATCH_EDBG_DEST_INTERNAL;
+
+		IWL_DEBUG_FW(trans,
+			     "WRT: Applying SMEM buffer destination\n");
+
+		goto out;
+	}
+
+	if (le32_to_cpu(fw_mon_cfg->buf_location) ==
+	    IWL_FW_INI_LOCATION_DRAM_PATH &&
+	    trans->dbg.fw_mon_ini[alloc_id].num_frags) {
+		struct iwl_dram_data *frag =
+			&trans->dbg.fw_mon_ini[alloc_id].frags[0];
+
+		dbg_flags |= IWL_PRPH_SCRATCH_EDBG_DEST_DRAM;
+
+		IWL_DEBUG_FW(trans,
+			     "WRT: Applying DRAM destination (alloc_id=%u)\n",
+			     alloc_id);
+
+		dbg_cfg->hwm_base_addr = cpu_to_le64(frag->physical);
+		dbg_cfg->hwm_size = cpu_to_le32(frag->size);
+	}
+
+out:
+	if (dbg_flags)
+		*control_flags |= IWL_PRPH_SCRATCH_EARLY_DEBUG_EN | dbg_flags;
+}
+
 int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 				 const struct fw_img *fw)
 {
@@ -86,25 +146,15 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 	control_flags = IWL_PRPH_SCRATCH_RB_SIZE_4K |
 			IWL_PRPH_SCRATCH_MTR_MODE |
 			(IWL_PRPH_MTR_FORMAT_256B &
-			 IWL_PRPH_SCRATCH_MTR_FORMAT) |
-			IWL_PRPH_SCRATCH_EARLY_DEBUG_EN |
-			IWL_PRPH_SCRATCH_EDBG_DEST_DRAM;
-	prph_sc_ctrl->control.control_flags = cpu_to_le32(control_flags);
+			 IWL_PRPH_SCRATCH_MTR_FORMAT);
 
 	/* initialize RX default queue */
 	prph_sc_ctrl->rbd_cfg.free_rbd_addr =
 		cpu_to_le64(trans_pcie->rxq->bd_dma);
 
-	/* Configure debug, for integration */
-	if (iwl_trans_dbg_ini_valid(trans)) {
-		iwl_pcie_alloc_fw_monitor(trans, 0);
-		if (trans->dbg.fw_mon.size) {
-			prph_sc_ctrl->hwm_cfg.hwm_base_addr =
-				cpu_to_le64(trans->dbg.fw_mon.physical);
-			prph_sc_ctrl->hwm_cfg.hwm_size =
-				cpu_to_le32(trans->dbg.fw_mon.size);
-		}
-	}
+	iwl_pcie_ctxt_info_dbg_enable(trans, &prph_sc_ctrl->hwm_cfg,
+				      &control_flags);
+	prph_sc_ctrl->control.control_flags = cpu_to_le32(control_flags);
 
 	/* allocate ucode sections in dram and set addresses */
 	ret = iwl_pcie_init_fw_sec(trans, fw, &prph_scratch->dram);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 464dc709c710..871b0b9244f9 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -890,14 +890,53 @@ static int iwl_pcie_load_cpu_sections(struct iwl_trans *trans,
 	return 0;
 }
 
+static void iwl_pcie_apply_destination_ini(struct iwl_trans *trans)
+{
+	enum iwl_fw_ini_allocation_id alloc_id = IWL_FW_INI_ALLOCATION_ID_DBGC1;
+	struct iwl_fw_ini_allocation_tlv *fw_mon_cfg =
+		&trans->dbg.fw_mon_cfg[alloc_id];
+	struct iwl_dram_data *frag;
+
+	if (!iwl_trans_dbg_ini_valid(trans))
+		return;
+
+	if (le32_to_cpu(fw_mon_cfg->buf_location) ==
+	    IWL_FW_INI_LOCATION_SRAM_PATH) {
+		IWL_DEBUG_FW(trans, "WRT: Applying SMEM buffer destination\n");
+		/* set sram monitor by enabling bit 7 */
+		iwl_set_bit(trans, CSR_HW_IF_CONFIG_REG,
+			    CSR_HW_IF_CONFIG_REG_BIT_MONITOR_SRAM);
+
+		return;
+	}
+
+	if (le32_to_cpu(fw_mon_cfg->buf_location) !=
+	    IWL_FW_INI_LOCATION_DRAM_PATH ||
+	    !trans->dbg.fw_mon_ini[alloc_id].num_frags)
+		return;
+
+	frag = &trans->dbg.fw_mon_ini[alloc_id].frags[0];
+
+	IWL_DEBUG_FW(trans, "WRT: Applying DRAM destination (alloc_id=%u)\n",
+		     alloc_id);
+
+	iwl_write_umac_prph(trans, MON_BUFF_BASE_ADDR_VER2,
+			    frag->physical >> MON_BUFF_SHIFT_VER2);
+	iwl_write_umac_prph(trans, MON_BUFF_END_ADDR_VER2,
+			    (frag->physical + frag->size - 256) >>
+			    MON_BUFF_SHIFT_VER2);
+}
+
 void iwl_pcie_apply_destination(struct iwl_trans *trans)
 {
 	const struct iwl_fw_dbg_dest_tlv_v1 *dest = trans->dbg.dest_tlv;
 	const struct iwl_dram_data *fw_mon = &trans->dbg.fw_mon;
 	int i;
 
-	if (iwl_trans_dbg_ini_valid(trans))
+	if (iwl_trans_dbg_ini_valid(trans)) {
+		iwl_pcie_apply_destination_ini(trans);
 		return;
+	}
 
 	IWL_INFO(trans, "Applying debug destination %s\n",
 		 get_fw_dbg_mode_string(dest->monitor_mode));
-- 
2.23.0

