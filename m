Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 657CD52875
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 11:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfFYJpI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 05:45:08 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54608 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727729AbfFYJpC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 05:45:02 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hfi0Z-0007Nv-5I; Tue, 25 Jun 2019 12:44:59 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 03/12] iwlwifi: dbg_ini: dump headers cleanup
Date:   Tue, 25 Jun 2019 12:44:43 +0300
Message-Id: <20190625094452.19034-4-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625094452.19034-1-luca@coelho.fi>
References: <20190625094452.19034-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Unite dump memory ranges under a single struct and add a specific header
for each type of memory.
Also, maintain a single version to all dump structures.

This cleanup is also needed for the future addition of FW notification
regions and others.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 57 ++++++++----------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |  3 -
 .../wireless/intel/iwlwifi/fw/error-dump.h    | 59 +++++++++----------
 3 files changed, 52 insertions(+), 67 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 5650b57a64e9..ca4dea1dceba 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1059,7 +1059,7 @@ static int iwl_dump_ini_prph_iter(struct iwl_fw_runtime *fwrt,
 	u32 addr = le32_to_cpu(reg->start_addr[idx]) + le32_to_cpu(reg->offset);
 	int i;
 
-	range->start_addr = cpu_to_le64(addr);
+	range->internal_base_addr = cpu_to_le32(addr);
 	range->range_data_size = reg->internal.range_data_size;
 	for (i = 0; i < le32_to_cpu(reg->internal.range_data_size); i += 4) {
 		prph_val = iwl_read_prph(fwrt->trans, addr + i);
@@ -1080,7 +1080,7 @@ static int iwl_dump_ini_csr_iter(struct iwl_fw_runtime *fwrt,
 	u32 addr = le32_to_cpu(reg->start_addr[idx]) + le32_to_cpu(reg->offset);
 	int i;
 
-	range->start_addr = cpu_to_le64(addr);
+	range->internal_base_addr = cpu_to_le32(addr);
 	range->range_data_size = reg->internal.range_data_size;
 	for (i = 0; i < le32_to_cpu(reg->internal.range_data_size); i += 4)
 		*val++ = cpu_to_le32(iwl_trans_read32(fwrt->trans, addr + i));
@@ -1095,7 +1095,7 @@ static int iwl_dump_ini_dev_mem_iter(struct iwl_fw_runtime *fwrt,
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
 	u32 addr = le32_to_cpu(reg->start_addr[idx]) + le32_to_cpu(reg->offset);
 
-	range->start_addr = cpu_to_le64(addr);
+	range->internal_base_addr = cpu_to_le32(addr);
 	range->range_data_size = reg->internal.range_data_size;
 	iwl_trans_read_mem_bytes(fwrt->trans, addr, range->data,
 				 le32_to_cpu(reg->internal.range_data_size));
@@ -1111,7 +1111,7 @@ iwl_dump_ini_paging_gen2_iter(struct iwl_fw_runtime *fwrt,
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
 	u32 page_size = fwrt->trans->init_dram.paging[idx].size;
 
-	range->start_addr = cpu_to_le64(idx);
+	range->page_num = cpu_to_le32(idx);
 	range->range_data_size = cpu_to_le32(page_size);
 	memcpy(range->data, fwrt->trans->init_dram.paging[idx].block,
 	       page_size);
@@ -1131,7 +1131,7 @@ static int iwl_dump_ini_paging_iter(struct iwl_fw_runtime *fwrt,
 	dma_addr_t addr = fwrt->fw_paging_db[idx].fw_paging_phys;
 	u32 page_size = fwrt->fw_paging_db[idx].fw_paging_size;
 
-	range->start_addr = cpu_to_le64(idx);
+	range->page_num = cpu_to_le32(idx);
 	range->range_data_size = cpu_to_le32(page_size);
 	dma_sync_single_for_cpu(fwrt->trans->dev, addr,	page_size,
 				DMA_BIDIRECTIONAL);
@@ -1154,7 +1154,7 @@ iwl_dump_ini_mon_dram_iter(struct iwl_fw_runtime *fwrt,
 	if (start_addr == 0x5a5a5a5a)
 		return -EBUSY;
 
-	range->start_addr = cpu_to_le64(start_addr);
+	range->dram_base_addr = cpu_to_le64(start_addr);
 	range->range_data_size = cpu_to_le32(fwrt->trans->fw_mon[idx].size);
 
 	memcpy(range->data, fwrt->trans->fw_mon[idx].block,
@@ -1228,7 +1228,7 @@ static int iwl_dump_ini_txf_iter(struct iwl_fw_runtime *fwrt,
 				 struct iwl_fw_ini_region_cfg *reg,
 				 void *range_ptr, int idx)
 {
-	struct iwl_fw_ini_fifo_error_dump_range *range = range_ptr;
+	struct iwl_fw_ini_error_dump_range *range = range_ptr;
 	struct iwl_ini_txf_iter_data *iter;
 	struct iwl_fw_ini_error_dump_register *reg_dump = (void *)range->data;
 	u32 offs = le32_to_cpu(reg->offset), addr;
@@ -1246,8 +1246,8 @@ static int iwl_dump_ini_txf_iter(struct iwl_fw_runtime *fwrt,
 
 	iter = fwrt->dump.fifo_iter;
 
-	range->fifo_num = cpu_to_le32(iter->fifo);
-	range->num_of_registers = reg->fifos.num_of_registers;
+	range->fifo_hdr.fifo_num = cpu_to_le32(iter->fifo);
+	range->fifo_hdr.num_of_registers = reg->fifos.num_of_registers;
 	range->range_data_size = cpu_to_le32(iter->fifo_size + registers_size);
 
 	iwl_write_prph_no_grab(fwrt->trans, TXF_LARC_NUM + offs, iter->fifo);
@@ -1336,7 +1336,7 @@ static int iwl_dump_ini_rxf_iter(struct iwl_fw_runtime *fwrt,
 				 struct iwl_fw_ini_region_cfg *reg,
 				 void *range_ptr, int idx)
 {
-	struct iwl_fw_ini_fifo_error_dump_range *range = range_ptr;
+	struct iwl_fw_ini_error_dump_range *range = range_ptr;
 	struct iwl_ini_rxf_data rxf_data;
 	struct iwl_fw_ini_error_dump_register *reg_dump = (void *)range->data;
 	u32 offs = le32_to_cpu(reg->offset), addr;
@@ -1353,8 +1353,8 @@ static int iwl_dump_ini_rxf_iter(struct iwl_fw_runtime *fwrt,
 	if (!iwl_trans_grab_nic_access(fwrt->trans, &flags))
 		return -EBUSY;
 
-	range->fifo_num = cpu_to_le32(rxf_data.fifo_num);
-	range->num_of_registers = reg->fifos.num_of_registers;
+	range->fifo_hdr.fifo_num = cpu_to_le32(rxf_data.fifo_num);
+	range->fifo_hdr.num_of_registers = reg->fifos.num_of_registers;
 	range->range_data_size = cpu_to_le32(rxf_data.size + registers_size);
 
 	/*
@@ -1408,7 +1408,7 @@ static void *iwl_dump_ini_mem_fill_header(struct iwl_fw_runtime *fwrt,
 {
 	struct iwl_fw_ini_error_dump *dump = data;
 
-	dump->header.version = cpu_to_le32(IWL_INI_DUMP_MEM_VER);
+	dump->header.version = cpu_to_le32(IWL_INI_DUMP_VER);
 
 	return dump->ranges;
 }
@@ -1433,7 +1433,7 @@ static void
 
 	iwl_trans_release_nic_access(fwrt->trans, &flags);
 
-	data->header.version = cpu_to_le32(IWL_INI_DUMP_MONITOR_VER);
+	data->header.version = cpu_to_le32(IWL_INI_DUMP_VER);
 	data->write_ptr = cpu_to_le32(write_ptr & write_ptr_msk);
 	data->cycle_cnt = cpu_to_le32(cycle_cnt & cycle_cnt_msk);
 
@@ -1490,17 +1490,6 @@ static void
 
 }
 
-static void *iwl_dump_ini_fifo_fill_header(struct iwl_fw_runtime *fwrt,
-					   struct iwl_fw_ini_region_cfg *reg,
-					   void *data)
-{
-	struct iwl_fw_ini_fifo_error_dump *dump = data;
-
-	dump->header.version = cpu_to_le32(IWL_INI_DUMP_FIFO_VER);
-
-	return dump->ranges;
-}
-
 static u32 iwl_dump_ini_mem_ranges(struct iwl_fw_runtime *fwrt,
 				   struct iwl_fw_ini_region_cfg *reg)
 {
@@ -1613,8 +1602,9 @@ static u32 iwl_dump_ini_txf_get_size(struct iwl_fw_runtime *fwrt,
 	struct iwl_ini_txf_iter_data iter = { .init = true };
 	void *fifo_iter = fwrt->dump.fifo_iter;
 	u32 size = 0;
-	u32 fifo_hdr = sizeof(struct iwl_fw_ini_fifo_error_dump_range) +
-		le32_to_cpu(reg->fifos.num_of_registers) * sizeof(__le32) * 2;
+	u32 fifo_hdr = sizeof(struct iwl_fw_ini_error_dump_range) +
+		le32_to_cpu(reg->fifos.num_of_registers) *
+		sizeof(struct iwl_fw_ini_error_dump_register);
 
 	fwrt->dump.fifo_iter = &iter;
 	while (iwl_ini_txf_iter(fwrt, reg)) {
@@ -1624,7 +1614,7 @@ static u32 iwl_dump_ini_txf_get_size(struct iwl_fw_runtime *fwrt,
 	}
 
 	if (size)
-		size += sizeof(struct iwl_fw_ini_fifo_error_dump);
+		size += sizeof(struct iwl_fw_ini_error_dump);
 
 	fwrt->dump.fifo_iter = fifo_iter;
 
@@ -1635,9 +1625,10 @@ static u32 iwl_dump_ini_rxf_get_size(struct iwl_fw_runtime *fwrt,
 				     struct iwl_fw_ini_region_cfg *reg)
 {
 	struct iwl_ini_rxf_data rx_data;
-	u32 size = sizeof(struct iwl_fw_ini_fifo_error_dump) +
-		sizeof(struct iwl_fw_ini_fifo_error_dump_range) +
-		le32_to_cpu(reg->fifos.num_of_registers) * sizeof(__le32) * 2;
+	u32 size = sizeof(struct iwl_fw_ini_error_dump) +
+		sizeof(struct iwl_fw_ini_error_dump_range) +
+		le32_to_cpu(reg->fifos.num_of_registers) *
+		sizeof(struct iwl_fw_ini_error_dump_register);
 
 	if (reg->fifos.header_only)
 		return size;
@@ -1879,7 +1870,7 @@ static void iwl_fw_ini_dump_trigger(struct iwl_fw_runtime *fwrt,
 			fwrt->dump.fifo_iter = &iter;
 			ops.get_num_of_ranges = iwl_dump_ini_txf_ranges;
 			ops.get_size = iwl_dump_ini_txf_get_size;
-			ops.fill_mem_hdr = iwl_dump_ini_fifo_fill_header;
+			ops.fill_mem_hdr = iwl_dump_ini_mem_fill_header;
 			ops.fill_range = iwl_dump_ini_txf_iter;
 			iwl_dump_ini_mem(fwrt, data, reg, &ops);
 			fwrt->dump.fifo_iter = fifo_iter;
@@ -1888,7 +1879,7 @@ static void iwl_fw_ini_dump_trigger(struct iwl_fw_runtime *fwrt,
 		case IWL_FW_INI_REGION_RXF:
 			ops.get_num_of_ranges = iwl_dump_ini_rxf_ranges;
 			ops.get_size = iwl_dump_ini_rxf_get_size;
-			ops.fill_mem_hdr = iwl_dump_ini_fifo_fill_header;
+			ops.fill_mem_hdr = iwl_dump_ini_mem_fill_header;
 			ops.fill_range = iwl_dump_ini_rxf_iter;
 			iwl_dump_ini_mem(fwrt, data, reg, &ops);
 			break;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index 2a9e560a906b..4a66d6f48d60 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -457,9 +457,6 @@ static inline void iwl_fw_umac_set_alive_err_table(struct iwl_trans *trans,
 		trans->umac_error_event_table = umac_error_event_table;
 }
 
-/* This bit is used to differentiate the legacy dump from the ini dump */
-#define INI_DUMP_BIT BIT(31)
-
 static inline void iwl_fw_error_collect(struct iwl_fw_runtime *fwrt)
 {
 	if (fwrt->trans->ini_valid && fwrt->trans->hw_error) {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
index 0feff4c33e39..4ee9418c949b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -278,19 +278,42 @@ struct iwl_fw_error_dump_mem {
 	u8 data[];
 };
 
-#define IWL_INI_DUMP_MEM_VER 1
-#define IWL_INI_DUMP_MONITOR_VER 1
-#define IWL_INI_DUMP_FIFO_VER 1
+/* Dump version, used by the dump parser to differentiate between
+ * different dump formats
+ */
+#define IWL_INI_DUMP_VER 1
+
+/* This bit is used to differentiate the legacy dump from the ini dump */
+#define INI_DUMP_BIT BIT(31)
+
+/**
+ * struct iwl_fw_ini_fifo_hdr - fifo range header
+ * @fifo_num: the fifo number. In case of umac rx fifo, set BIT(31) to
+ *	distinguish between lmac and umac rx fifos
+ * @num_of_registers: num of registers to dump, dword size each
+ */
+struct iwl_fw_ini_fifo_hdr {
+	__le32 fifo_num;
+	__le32 num_of_registers;
+} __packed;
 
 /**
  * struct iwl_fw_ini_error_dump_range - range of memory
  * @range_data_size: the size of this range, in bytes
- * @start_addr: the start address of this range
+ * @internal_base_addr - base address of internal memory range
+ * @dram_base_addr - base address of dram monitor range
+ * @page_num - page number of memory range
+ * @fifo_hdr - fifo header of memory range
  * @data: the actual memory
  */
 struct iwl_fw_ini_error_dump_range {
 	__le32 range_data_size;
-	__le64 start_addr;
+	union {
+		__le32 internal_base_addr;
+		__le64 dram_base_addr;
+		__le32 page_num;
+		struct iwl_fw_ini_fifo_hdr fifo_hdr;
+	};
 	__le32 data[];
 } __packed;
 
@@ -333,32 +356,6 @@ struct iwl_fw_ini_error_dump_register {
 	__le32 data;
 } __packed;
 
-/**
- * struct iwl_fw_ini_fifo_error_dump_range - ini fifo range dump
- * @fifo_num: the fifo num. In case of rxf and umac rxf, set BIT(31) to
- *	distinguish between lmac and umac
- * @num_of_registers: num of registers to dump, dword size each
- * @range_data_size: the size of the data
- * @data: consist of
- *	num_of_registers * (register address + register value) + fifo data
- */
-struct iwl_fw_ini_fifo_error_dump_range {
-	__le32 fifo_num;
-	__le32 num_of_registers;
-	__le32 range_data_size;
-	__le32 data[];
-} __packed;
-
-/**
- * struct iwl_fw_ini_fifo_error_dump - ini fifo region dump
- * @header: the header of this region
- * @ranges: the memory ranges of this region
- */
-struct iwl_fw_ini_fifo_error_dump {
-	struct iwl_fw_ini_error_dump_header header;
-	struct iwl_fw_ini_fifo_error_dump_range ranges[];
-} __packed;
-
 /**
  * struct iwl_fw_error_dump_rb - content of an Receive Buffer
  * @index: the index of the Receive Buffer in the Rx queue
-- 
2.20.1

