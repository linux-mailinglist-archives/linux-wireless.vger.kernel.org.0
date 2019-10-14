Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A53C6D5C31
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2019 09:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbfJNHUb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Oct 2019 03:20:31 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:49158 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729928AbfJNHUb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Oct 2019 03:20:31 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iJueY-0007ae-PT; Mon, 14 Oct 2019 10:20:28 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 14 Oct 2019 10:20:05 +0300
Message-Id: <20191014101813.8c52a275339f.I5886959725de5603f03f5d22704b3e2491ad71a3@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191014072019.1254-1-luca@coelho.fi>
References: <20191014072019.1254-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 02/16] iwlwifi: dbg_ini: use new region TLV in dump flow
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Make dump flow use the new region TLV and update the region type enum.
Temporarily remove monitor dumping support. Support will be readded in a
future patch.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   | 142 ++++--
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 414 +++++++-----------
 2 files changed, 264 insertions(+), 292 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index ba586f148c14..dad0dea6725d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -219,18 +219,102 @@ struct iwl_fw_ini_region_cfg {
 } __packed; /* FW_DEBUG_TLV_REGION_CONFIG_API_S_VER_1 */
 
 /**
- * struct iwl_fw_ini_region_tlv - (IWL_UCODE_TLV_TYPE_REGIONS)
- * defines memory regions to dump
+ * struct iwl_fw_ini_region_dev_addr - Configuration to read device addresses
  *
- * @header: header
- * @num_regions: how many different region section and IDs are coming next
- * @region_config: list of dump configurations
+ * @size: size of each memory chunk
+ * @offset: offset to add to the base address of each chunk
+ */
+struct iwl_fw_ini_region_dev_addr {
+	__le32 size;
+	__le32 offset;
+} __packed; /* FW_TLV_DEBUG_DEVICE_ADDR_API_S_VER_1 */
+
+/**
+ * struct iwl_fw_ini_region_fifos - Configuration to read Tx/Rx fifos
+ *
+ * @fid: fifos ids array. Used to determine what fifos to collect
+ * @hdr_only: if non zero, collect only the registers
+ * @offset: offset to add to the registers addresses
+ */
+struct iwl_fw_ini_region_fifos {
+	__le32 fid[2];
+	__le32 hdr_only;
+	__le32 offset;
+} __packed; /* FW_TLV_DEBUG_REGION_FIFOS_API_S_VER_1 */
+
+/**
+ * struct iwl_fw_ini_region_err_table - error table region data
+ *
+ * Configuration to read Umac/Lmac error table
+ *
+ * @version: version of the error table
+ * @base_addr: base address of the error table
+ * @size: size of the error table
+ * @offset: offset to add to &base_addr
+ */
+struct iwl_fw_ini_region_err_table {
+	__le32 version;
+	__le32 base_addr;
+	__le32 size;
+	__le32 offset;
+} __packed; /* FW_TLV_DEBUG_REGION_ERROR_TABLE_API_S_VER_1 */
+
+/**
+ * struct iwl_fw_ini_region_internal_buffer - internal buffer region data
+ *
+ * Configuration to read internal monitor buffer
+ *
+ * @alloc_id: allocation id one of &enum iwl_fw_ini_allocation_id
+ * @base_addr: internal buffer base address
+ * @size: size internal buffer size
+ */
+struct iwl_fw_ini_region_internal_buffer {
+	__le32 alloc_id;
+	__le32 base_addr;
+	__le32 size;
+} __packed; /* FW_TLV_DEBUG_REGION_INTERNAL_BUFFER_API_S_VER_1 */
+
+/**
+ * struct iwl_fw_ini_region_tlv - region TLV
+ *
+ * Configures parameters for region data collection
+ *
+ * @hdr: debug header
+ * @id: region id. Max id is &IWL_FW_INI_MAX_REGION_ID
+ * @type: region type. One of &enum iwl_fw_ini_region_type
+ * @name: region name
+ * @dev_addr: device address configuration. Used by
+ *	&IWL_FW_INI_REGION_DEVICE_MEMORY, &IWL_FW_INI_REGION_PERIPHERY_MAC,
+ *	&IWL_FW_INI_REGION_PERIPHERY_PHY, &IWL_FW_INI_REGION_PERIPHERY_AUX,
+ *	&IWL_FW_INI_REGION_PAGING, &IWL_FW_INI_REGION_CSR,
+ *	&IWL_FW_INI_REGION_DRAM_IMR and &IWL_FW_INI_REGION_PCI_IOSF_CONFIG
+ * @fifos: fifos configuration. Used by &IWL_FW_INI_REGION_TXF and
+ *	&IWL_FW_INI_REGION_RXF
+ * @err_table: error table configuration. Used by
+ *	IWL_FW_INI_REGION_LMAC_ERROR_TABLE and
+ *	IWL_FW_INI_REGION_UMAC_ERROR_TABLE
+ * @internal_buffer: internal monitor buffer configuration. Used by
+ *	&IWL_FW_INI_REGION_INTERNAL_BUFFER
+ * @dram_alloc_id: dram allocation id. One of &enum iwl_fw_ini_allocation_id.
+ *	Used by &IWL_FW_INI_REGION_DRAM_BUFFER
+ * @tlv_mask: tlv collection mask. Used by &IWL_FW_INI_REGION_TLV
+ * @addrs: array of addresses attached to the end of the region tlv
  */
 struct iwl_fw_ini_region_tlv {
-	struct iwl_fw_ini_header header;
-	__le32 num_regions;
-	struct iwl_fw_ini_region_cfg region_config[];
-} __packed; /* FW_DEBUG_TLV_REGIONS_API_S_VER_1 */
+	struct iwl_fw_ini_header hdr;
+	__le32 id;
+	__le32 type;
+	u8 name[IWL_FW_INI_MAX_NAME];
+	union {
+		struct iwl_fw_ini_region_dev_addr dev_addr;
+		struct iwl_fw_ini_region_fifos fifos;
+		struct iwl_fw_ini_region_err_table err_table;
+		struct iwl_fw_ini_region_internal_buffer internal_buffer;
+		__le32 dram_alloc_id;
+		__le32 tlv_mask;
+	}; /* FW_TLV_DEBUG_REGION_CONF_PARAMS_API_U_VER_1 */
+	__le32 addrs[];
+} __packed; /* FW_TLV_DEBUG_REGION_API_S_VER_1 */
 
 /**
  * struct iwl_fw_ini_trigger
@@ -452,42 +536,44 @@ enum iwl_fw_ini_debug_flow {
  * enum iwl_fw_ini_region_type
  *
  * @IWL_FW_INI_REGION_INVALID: invalid
+ * @IWL_FW_INI_REGION_TLV: uCode and debug TLVs
+ * @IWL_FW_INI_REGION_INTERNAL_BUFFER: monitor SMEM buffer
+ * @IWL_FW_INI_REGION_DRAM_BUFFER: monitor DRAM buffer
+ * @IWL_FW_INI_REGION_TXF: TX fifos
+ * @IWL_FW_INI_REGION_RXF: RX fifo
+ * @IWL_FW_INI_REGION_LMAC_ERROR_TABLE: lmac error table
+ * @IWL_FW_INI_REGION_UMAC_ERROR_TABLE: umac error table
+ * @IWL_FW_INI_REGION_RSP_OR_NOTIF: FW response or notification data
  * @IWL_FW_INI_REGION_DEVICE_MEMORY: device internal memory
  * @IWL_FW_INI_REGION_PERIPHERY_MAC: periphery registers of MAC
  * @IWL_FW_INI_REGION_PERIPHERY_PHY: periphery registers of PHY
  * @IWL_FW_INI_REGION_PERIPHERY_AUX: periphery registers of AUX
- * @IWL_FW_INI_REGION_DRAM_BUFFER: DRAM buffer
- * @IWL_FW_INI_REGION_DRAM_IMR: IMR memory
- * @IWL_FW_INI_REGION_INTERNAL_BUFFER: undefined
- * @IWL_FW_INI_REGION_TXF: TX fifos
- * @IWL_FW_INI_REGION_RXF: RX fifo
  * @IWL_FW_INI_REGION_PAGING: paging memory
  * @IWL_FW_INI_REGION_CSR: CSR registers
- * @IWL_FW_INI_REGION_NOTIFICATION: FW notification data
- * @IWL_FW_INI_REGION_DHC: dhc response to dump
- * @IWL_FW_INI_REGION_LMAC_ERROR_TABLE: lmac error table
- * @IWL_FW_INI_REGION_UMAC_ERROR_TABLE: umac error table
+ * @IWL_FW_INI_REGION_DRAM_IMR: IMR memory
+ * @IWL_FW_INI_REGION_PCI_IOSF_CONFIG: PCI/IOSF config
  * @IWL_FW_INI_REGION_NUM: number of region types
  */
 enum iwl_fw_ini_region_type {
 	IWL_FW_INI_REGION_INVALID,
+	IWL_FW_INI_REGION_TLV,
+	IWL_FW_INI_REGION_INTERNAL_BUFFER,
+	IWL_FW_INI_REGION_DRAM_BUFFER,
+	IWL_FW_INI_REGION_TXF,
+	IWL_FW_INI_REGION_RXF,
+	IWL_FW_INI_REGION_LMAC_ERROR_TABLE,
+	IWL_FW_INI_REGION_UMAC_ERROR_TABLE,
+	IWL_FW_INI_REGION_RSP_OR_NOTIF,
 	IWL_FW_INI_REGION_DEVICE_MEMORY,
 	IWL_FW_INI_REGION_PERIPHERY_MAC,
 	IWL_FW_INI_REGION_PERIPHERY_PHY,
 	IWL_FW_INI_REGION_PERIPHERY_AUX,
-	IWL_FW_INI_REGION_DRAM_BUFFER,
-	IWL_FW_INI_REGION_DRAM_IMR,
-	IWL_FW_INI_REGION_INTERNAL_BUFFER,
-	IWL_FW_INI_REGION_TXF,
-	IWL_FW_INI_REGION_RXF,
 	IWL_FW_INI_REGION_PAGING,
 	IWL_FW_INI_REGION_CSR,
-	IWL_FW_INI_REGION_NOTIFICATION,
-	IWL_FW_INI_REGION_DHC,
-	IWL_FW_INI_REGION_LMAC_ERROR_TABLE,
-	IWL_FW_INI_REGION_UMAC_ERROR_TABLE,
+	IWL_FW_INI_REGION_DRAM_IMR,
+	IWL_FW_INI_REGION_PCI_IOSF_CONFIG,
 	IWL_FW_INI_REGION_NUM
-}; /* FW_DEBUG_TLV_REGION_TYPE_E_VER_1 */
+}; /* FW_TLV_DEBUG_REGION_TYPE_API_E */
 
 /**
  * enum iwl_fw_ini_time_point
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 5c8602de9168..d279d4e96c1b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1054,19 +1054,29 @@ iwl_fw_error_dump_file(struct iwl_fw_runtime *fwrt,
 	return dump_file;
 }
 
+/**
+ * struct iwl_dump_ini_region_data - region data
+ * @reg_tlv: region TLV
+ */
+struct iwl_dump_ini_region_data {
+	struct iwl_ucode_tlv *reg_tlv;
+};
+
 static int iwl_dump_ini_prph_iter(struct iwl_fw_runtime *fwrt,
-				  struct iwl_fw_ini_region_cfg *reg,
+				  struct iwl_dump_ini_region_data *reg_data,
 				  void *range_ptr, int idx)
 {
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
 	__le32 *val = range->data;
 	u32 prph_val;
-	u32 addr = le32_to_cpu(reg->start_addr[idx]) + le32_to_cpu(reg->offset);
+	u32 addr = le32_to_cpu(reg->addrs[idx]) +
+		   le32_to_cpu(reg->dev_addr.offset);
 	int i;
 
 	range->internal_base_addr = cpu_to_le32(addr);
-	range->range_data_size = reg->internal.range_data_size;
-	for (i = 0; i < le32_to_cpu(reg->internal.range_data_size); i += 4) {
+	range->range_data_size = reg->dev_addr.size;
+	for (i = 0; i < le32_to_cpu(reg->dev_addr.size); i += 4) {
 		prph_val = iwl_read_prph(fwrt->trans, addr + i);
 		if (prph_val == 0x5a5a5a5a)
 			return -EBUSY;
@@ -1077,39 +1087,42 @@ static int iwl_dump_ini_prph_iter(struct iwl_fw_runtime *fwrt,
 }
 
 static int iwl_dump_ini_csr_iter(struct iwl_fw_runtime *fwrt,
-				 struct iwl_fw_ini_region_cfg *reg,
+				 struct iwl_dump_ini_region_data *reg_data,
 				 void *range_ptr, int idx)
 {
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
 	__le32 *val = range->data;
-	u32 addr = le32_to_cpu(reg->start_addr[idx]) + le32_to_cpu(reg->offset);
+	u32 addr = le32_to_cpu(reg->addrs[idx]) +
+		   le32_to_cpu(reg->dev_addr.offset);
 	int i;
 
 	range->internal_base_addr = cpu_to_le32(addr);
-	range->range_data_size = reg->internal.range_data_size;
-	for (i = 0; i < le32_to_cpu(reg->internal.range_data_size); i += 4)
+	range->range_data_size = reg->dev_addr.size;
+	for (i = 0; i < le32_to_cpu(reg->dev_addr.size); i += 4)
 		*val++ = cpu_to_le32(iwl_trans_read32(fwrt->trans, addr + i));
 
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
 
 static int iwl_dump_ini_dev_mem_iter(struct iwl_fw_runtime *fwrt,
-				     struct iwl_fw_ini_region_cfg *reg,
+				     struct iwl_dump_ini_region_data *reg_data,
 				     void *range_ptr, int idx)
 {
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
-	u32 addr = le32_to_cpu(reg->start_addr[idx]) + le32_to_cpu(reg->offset);
+	u32 addr = le32_to_cpu(reg->addrs[idx]) +
+		   le32_to_cpu(reg->dev_addr.offset);
 
 	range->internal_base_addr = cpu_to_le32(addr);
-	range->range_data_size = reg->internal.range_data_size;
+	range->range_data_size = reg->dev_addr.size;
 	iwl_trans_read_mem_bytes(fwrt->trans, addr, range->data,
-				 le32_to_cpu(reg->internal.range_data_size));
+				 le32_to_cpu(reg->dev_addr.size));
 
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
 
 static int _iwl_dump_ini_paging_iter(struct iwl_fw_runtime *fwrt,
-				     struct iwl_fw_ini_region_cfg *reg,
 				     void *range_ptr, int idx)
 {
 	/* increase idx by 1 since the pages are from 1 to
@@ -1132,14 +1145,14 @@ static int _iwl_dump_ini_paging_iter(struct iwl_fw_runtime *fwrt,
 }
 
 static int iwl_dump_ini_paging_iter(struct iwl_fw_runtime *fwrt,
-				    struct iwl_fw_ini_region_cfg *reg,
+				    struct iwl_dump_ini_region_data *reg_data,
 				    void *range_ptr, int idx)
 {
 	struct iwl_fw_ini_error_dump_range *range;
 	u32 page_size;
 
 	if (!fwrt->trans->trans_cfg->gen2)
-		return _iwl_dump_ini_paging_iter(fwrt, reg, range_ptr, idx);
+		return _iwl_dump_ini_paging_iter(fwrt, range_ptr, idx);
 
 	range = range_ptr;
 	page_size = fwrt->trans->init_dram.paging[idx].size;
@@ -1152,47 +1165,27 @@ static int iwl_dump_ini_paging_iter(struct iwl_fw_runtime *fwrt,
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
 
-static int
-iwl_dump_ini_mon_dram_iter(struct iwl_fw_runtime *fwrt,
-			   struct iwl_fw_ini_region_cfg *reg, void *range_ptr,
-			   int idx)
-{
-	struct iwl_fw_ini_error_dump_range *range = range_ptr;
-	u32 start_addr = iwl_read_umac_prph(fwrt->trans,
-					    MON_BUFF_BASE_ADDR_VER2);
-
-	if (start_addr == 0x5a5a5a5a)
-		return -EBUSY;
-
-	range->dram_base_addr = cpu_to_le64(start_addr);
-	range->range_data_size = cpu_to_le32(fwrt->trans->dbg.fw_mon[idx].size);
-
-	memcpy(range->data, fwrt->trans->dbg.fw_mon[idx].block,
-	       fwrt->trans->dbg.fw_mon[idx].size);
-
-	return sizeof(*range) + le32_to_cpu(range->range_data_size);
-}
-
 static bool iwl_ini_txf_iter(struct iwl_fw_runtime *fwrt,
-			     struct iwl_fw_ini_region_cfg *reg, int idx)
+			     struct iwl_dump_ini_region_data *reg_data, int idx)
 {
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_txf_iter_data *iter = &fwrt->dump.txf_iter_data;
 	struct iwl_fwrt_shared_mem_cfg *cfg = &fwrt->smem_cfg;
 	int txf_num = cfg->num_txfifo_entries;
 	int int_txf_num = ARRAY_SIZE(cfg->internal_txfifo_size);
-	u32 lmac_bitmap = le32_to_cpu(reg->fifos.fid1);
+	u32 lmac_bitmap = le32_to_cpu(reg->fifos.fid[0]);
 
 	if (!idx) {
-		if (le32_to_cpu(reg->offset) &&
-		    WARN_ONCE(cfg->num_lmacs == 1,
-			      "Invalid lmac offset: 0x%x\n",
-			      le32_to_cpu(reg->offset)))
+		if (le32_to_cpu(reg->fifos.offset) && cfg->num_lmacs == 1) {
+			IWL_ERR(fwrt, "WRT: Invalid lmac offset 0x%x\n",
+				le32_to_cpu(reg->fifos.offset));
 			return false;
+		}
 
 		iter->internal_txf = 0;
 		iter->fifo_size = 0;
 		iter->fifo = -1;
-		if (le32_to_cpu(reg->offset))
+		if (le32_to_cpu(reg->fifos.offset))
 			iter->lmac = 1;
 		else
 			iter->lmac = 0;
@@ -1223,27 +1216,28 @@ static bool iwl_ini_txf_iter(struct iwl_fw_runtime *fwrt,
 }
 
 static int iwl_dump_ini_txf_iter(struct iwl_fw_runtime *fwrt,
-				 struct iwl_fw_ini_region_cfg *reg,
+				 struct iwl_dump_ini_region_data *reg_data,
 				 void *range_ptr, int idx)
 {
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
 	struct iwl_txf_iter_data *iter = &fwrt->dump.txf_iter_data;
 	struct iwl_fw_ini_error_dump_register *reg_dump = (void *)range->data;
-	u32 offs = le32_to_cpu(reg->offset), addr;
-	u32 registers_size =
-		le32_to_cpu(reg->fifos.num_of_registers) * sizeof(*reg_dump);
+	u32 offs = le32_to_cpu(reg->fifos.offset), addr;
+	u32 registers_num = iwl_tlv_array_len(reg_data->reg_tlv, reg, addrs);
+	u32 registers_size = registers_num * sizeof(*reg_dump);
 	__le32 *data;
 	unsigned long flags;
 	int i;
 
-	if (!iwl_ini_txf_iter(fwrt, reg, idx))
+	if (!iwl_ini_txf_iter(fwrt, reg_data, idx))
 		return -EIO;
 
 	if (!iwl_trans_grab_nic_access(fwrt->trans, &flags))
 		return -EBUSY;
 
 	range->fifo_hdr.fifo_num = cpu_to_le32(iter->fifo);
-	range->fifo_hdr.num_of_registers = reg->fifos.num_of_registers;
+	range->fifo_hdr.num_of_registers = cpu_to_le32(registers_num);
 	range->range_data_size = cpu_to_le32(iter->fifo_size + registers_size);
 
 	iwl_write_prph_no_grab(fwrt->trans, TXF_LARC_NUM + offs, iter->fifo);
@@ -1252,8 +1246,8 @@ static int iwl_dump_ini_txf_iter(struct iwl_fw_runtime *fwrt,
 	 * read txf registers. for each register, write to the dump the
 	 * register address and its value
 	 */
-	for (i = 0; i < le32_to_cpu(reg->fifos.num_of_registers); i++) {
-		addr = le32_to_cpu(reg->start_addr[i]) + offs;
+	for (i = 0; i < registers_num; i++) {
+		addr = le32_to_cpu(reg->addrs[i]) + offs;
 
 		reg_dump->addr = cpu_to_le32(addr);
 		reg_dump->data = cpu_to_le32(iwl_read_prph_no_grab(fwrt->trans,
@@ -1262,7 +1256,7 @@ static int iwl_dump_ini_txf_iter(struct iwl_fw_runtime *fwrt,
 		reg_dump++;
 	}
 
-	if (reg->fifos.header_only) {
+	if (reg->fifos.hdr_only) {
 		range->range_data_size = cpu_to_le32(registers_size);
 		goto out;
 	}
@@ -1293,11 +1287,12 @@ struct iwl_ini_rxf_data {
 };
 
 static void iwl_ini_get_rxf_data(struct iwl_fw_runtime *fwrt,
-				 struct iwl_fw_ini_region_cfg *reg,
+				 struct iwl_dump_ini_region_data *reg_data,
 				 struct iwl_ini_rxf_data *data)
 {
-	u32 fid1 = le32_to_cpu(reg->fifos.fid1);
-	u32 fid2 = le32_to_cpu(reg->fifos.fid2);
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+	u32 fid1 = le32_to_cpu(reg->fifos.fid[0]);
+	u32 fid2 = le32_to_cpu(reg->fifos.fid[1]);
 	u32 fifo_idx;
 
 	if (!data)
@@ -1329,20 +1324,21 @@ static void iwl_ini_get_rxf_data(struct iwl_fw_runtime *fwrt,
 }
 
 static int iwl_dump_ini_rxf_iter(struct iwl_fw_runtime *fwrt,
-				 struct iwl_fw_ini_region_cfg *reg,
+				 struct iwl_dump_ini_region_data *reg_data,
 				 void *range_ptr, int idx)
 {
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
 	struct iwl_ini_rxf_data rxf_data;
 	struct iwl_fw_ini_error_dump_register *reg_dump = (void *)range->data;
-	u32 offs = le32_to_cpu(reg->offset), addr;
-	u32 registers_size =
-		le32_to_cpu(reg->fifos.num_of_registers) * sizeof(*reg_dump);
+	u32 offs = le32_to_cpu(reg->fifos.offset), addr;
+	u32 registers_num = iwl_tlv_array_len(reg_data->reg_tlv, reg, addrs);
+	u32 registers_size = registers_num * sizeof(*reg_dump);
 	__le32 *data;
 	unsigned long flags;
 	int i;
 
-	iwl_ini_get_rxf_data(fwrt, reg, &rxf_data);
+	iwl_ini_get_rxf_data(fwrt, reg_data, &rxf_data);
 	if (!rxf_data.size)
 		return -EIO;
 
@@ -1350,15 +1346,15 @@ static int iwl_dump_ini_rxf_iter(struct iwl_fw_runtime *fwrt,
 		return -EBUSY;
 
 	range->fifo_hdr.fifo_num = cpu_to_le32(rxf_data.fifo_num);
-	range->fifo_hdr.num_of_registers = reg->fifos.num_of_registers;
+	range->fifo_hdr.num_of_registers = cpu_to_le32(registers_num);
 	range->range_data_size = cpu_to_le32(rxf_data.size + registers_size);
 
 	/*
 	 * read rxf registers. for each register, write to the dump the
 	 * register address and its value
 	 */
-	for (i = 0; i < le32_to_cpu(reg->fifos.num_of_registers); i++) {
-		addr = le32_to_cpu(reg->start_addr[i]) + offs;
+	for (i = 0; i < registers_num; i++) {
+		addr = le32_to_cpu(reg->addrs[i]) + offs;
 
 		reg_dump->addr = cpu_to_le32(addr);
 		reg_dump->data = cpu_to_le32(iwl_read_prph_no_grab(fwrt->trans,
@@ -1367,7 +1363,7 @@ static int iwl_dump_ini_rxf_iter(struct iwl_fw_runtime *fwrt,
 		reg_dump++;
 	}
 
-	if (reg->fifos.header_only) {
+	if (reg->fifos.hdr_only) {
 		range->range_data_size = cpu_to_le32(registers_size);
 		goto out;
 	}
@@ -1398,9 +1394,10 @@ static int iwl_dump_ini_rxf_iter(struct iwl_fw_runtime *fwrt,
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
 
-static void *iwl_dump_ini_mem_fill_header(struct iwl_fw_runtime *fwrt,
-					  struct iwl_fw_ini_region_cfg *reg,
-					  void *data)
+static void *
+iwl_dump_ini_mem_fill_header(struct iwl_fw_runtime *fwrt,
+			     struct iwl_dump_ini_region_data *reg_data,
+			     void *data)
 {
 	struct iwl_fw_ini_error_dump *dump = data;
 
@@ -1409,91 +1406,16 @@ static void *iwl_dump_ini_mem_fill_header(struct iwl_fw_runtime *fwrt,
 	return dump->ranges;
 }
 
-static void
-*iwl_dump_ini_mon_fill_header(struct iwl_fw_runtime *fwrt,
-			      struct iwl_fw_ini_region_cfg *reg,
-			      struct iwl_fw_ini_monitor_dump *data,
-			      u32 write_ptr_addr, u32 write_ptr_msk,
-			      u32 cycle_cnt_addr, u32 cycle_cnt_msk)
-{
-	u32 write_ptr, cycle_cnt;
-	unsigned long flags;
-
-	if (!iwl_trans_grab_nic_access(fwrt->trans, &flags)) {
-		IWL_ERR(fwrt, "Failed to get monitor header\n");
-		return NULL;
-	}
-
-	write_ptr = iwl_read_prph_no_grab(fwrt->trans, write_ptr_addr);
-	cycle_cnt = iwl_read_prph_no_grab(fwrt->trans, cycle_cnt_addr);
-
-	iwl_trans_release_nic_access(fwrt->trans, &flags);
-
-	data->header.version = cpu_to_le32(IWL_INI_DUMP_VER);
-	data->write_ptr = cpu_to_le32(write_ptr & write_ptr_msk);
-	data->cycle_cnt = cpu_to_le32(cycle_cnt & cycle_cnt_msk);
-
-	return data->ranges;
-}
-
-static void
-*iwl_dump_ini_mon_dram_fill_header(struct iwl_fw_runtime *fwrt,
-				   struct iwl_fw_ini_region_cfg *reg,
-				   void *data)
-{
-	struct iwl_fw_ini_monitor_dump *mon_dump = (void *)data;
-	u32 write_ptr_addr, write_ptr_msk, cycle_cnt_addr, cycle_cnt_msk;
-
-	switch (fwrt->trans->trans_cfg->device_family) {
-	case IWL_DEVICE_FAMILY_9000:
-	case IWL_DEVICE_FAMILY_22000:
-		write_ptr_addr = MON_BUFF_WRPTR_VER2;
-		write_ptr_msk = -1;
-		cycle_cnt_addr = MON_BUFF_CYCLE_CNT_VER2;
-		cycle_cnt_msk = -1;
-		break;
-	default:
-		IWL_ERR(fwrt, "Unsupported device family %d\n",
-			fwrt->trans->trans_cfg->device_family);
-		return NULL;
-	}
-
-	return iwl_dump_ini_mon_fill_header(fwrt, reg, mon_dump, write_ptr_addr,
-					    write_ptr_msk, cycle_cnt_addr,
-					    cycle_cnt_msk);
-}
-
-static void
-*iwl_dump_ini_mon_smem_fill_header(struct iwl_fw_runtime *fwrt,
-				   struct iwl_fw_ini_region_cfg *reg,
-				   void *data)
-{
-	struct iwl_fw_ini_monitor_dump *mon_dump = (void *)data;
-	const struct iwl_cfg *cfg = fwrt->trans->cfg;
-
-	if (fwrt->trans->trans_cfg->device_family != IWL_DEVICE_FAMILY_9000 &&
-	    fwrt->trans->trans_cfg->device_family != IWL_DEVICE_FAMILY_22000) {
-		IWL_ERR(fwrt, "Unsupported device family %d\n",
-			fwrt->trans->trans_cfg->device_family);
-		return NULL;
-	}
-
-	return iwl_dump_ini_mon_fill_header(fwrt, reg, mon_dump,
-					    cfg->fw_mon_smem_write_ptr_addr,
-					    cfg->fw_mon_smem_write_ptr_msk,
-					    cfg->fw_mon_smem_cycle_cnt_ptr_addr,
-					    cfg->fw_mon_smem_cycle_cnt_ptr_msk);
-
-}
-
 static u32 iwl_dump_ini_mem_ranges(struct iwl_fw_runtime *fwrt,
-				   struct iwl_fw_ini_region_cfg *reg)
+				   struct iwl_dump_ini_region_data *reg_data)
 {
-	return le32_to_cpu(reg->internal.num_of_ranges);
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+
+	return iwl_tlv_array_len(reg_data->reg_tlv, reg, addrs);
 }
 
 static u32 iwl_dump_ini_paging_ranges(struct iwl_fw_runtime *fwrt,
-				      struct iwl_fw_ini_region_cfg *reg)
+				      struct iwl_dump_ini_region_data *reg_data)
 {
 	if (fwrt->trans->trans_cfg->gen2)
 		return fwrt->trans->init_dram.paging_cnt;
@@ -1501,54 +1423,52 @@ static u32 iwl_dump_ini_paging_ranges(struct iwl_fw_runtime *fwrt,
 	return fwrt->num_of_paging_blk;
 }
 
-static u32 iwl_dump_ini_mon_dram_ranges(struct iwl_fw_runtime *fwrt,
-					struct iwl_fw_ini_region_cfg *reg)
-{
-	return 1;
-}
-
 static u32 iwl_dump_ini_txf_ranges(struct iwl_fw_runtime *fwrt,
-				   struct iwl_fw_ini_region_cfg *reg)
+				   struct iwl_dump_ini_region_data *reg_data)
 {
 	u32 num_of_fifos = 0;
 
-	while (iwl_ini_txf_iter(fwrt, reg, num_of_fifos))
+	while (iwl_ini_txf_iter(fwrt, reg_data, num_of_fifos))
 		num_of_fifos++;
 
 	return num_of_fifos;
 }
 
-static u32 iwl_dump_ini_rxf_ranges(struct iwl_fw_runtime *fwrt,
-				   struct iwl_fw_ini_region_cfg *reg)
+static u32 iwl_dump_ini_single_range(struct iwl_fw_runtime *fwrt,
+				     struct iwl_dump_ini_region_data *reg_data)
 {
-	/* Each Rx fifo needs a different offset and therefore, it's
-	 * region can contain only one fifo, i.e. 1 memory range.
-	 */
 	return 1;
 }
 
 static u32 iwl_dump_ini_mem_get_size(struct iwl_fw_runtime *fwrt,
-				     struct iwl_fw_ini_region_cfg *reg)
+				     struct iwl_dump_ini_region_data *reg_data)
 {
-	return sizeof(struct iwl_fw_ini_error_dump) +
-		iwl_dump_ini_mem_ranges(fwrt, reg) *
-		(sizeof(struct iwl_fw_ini_error_dump_range) +
-		 le32_to_cpu(reg->internal.range_data_size));
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+	u32 size = le32_to_cpu(reg->dev_addr.size);
+	u32 ranges = iwl_dump_ini_mem_ranges(fwrt, reg_data);
+
+	if (!size || !ranges)
+		return 0;
+
+	return sizeof(struct iwl_fw_ini_error_dump) + ranges *
+		(size + sizeof(struct iwl_fw_ini_error_dump_range));
 }
 
-static u32 iwl_dump_ini_paging_get_size(struct iwl_fw_runtime *fwrt,
-					struct iwl_fw_ini_region_cfg *reg)
+static u32
+iwl_dump_ini_paging_get_size(struct iwl_fw_runtime *fwrt,
+			     struct iwl_dump_ini_region_data *reg_data)
 {
 	int i;
 	u32 range_header_len = sizeof(struct iwl_fw_ini_error_dump_range);
 	u32 size = sizeof(struct iwl_fw_ini_error_dump);
 
 	if (fwrt->trans->trans_cfg->gen2) {
-		for (i = 0; i < iwl_dump_ini_paging_ranges(fwrt, reg); i++)
+		for (i = 0; i < iwl_dump_ini_paging_ranges(fwrt, reg_data); i++)
 			size += range_header_len +
 				fwrt->trans->init_dram.paging[i].size;
 	} else {
-		for (i = 1; i <= iwl_dump_ini_paging_ranges(fwrt, reg); i++)
+		for (i = 1; i <= iwl_dump_ini_paging_ranges(fwrt, reg_data);
+		     i++)
 			size += range_header_len +
 				fwrt->fw_paging_db[i].fw_paging_size;
 	}
@@ -1556,61 +1476,43 @@ static u32 iwl_dump_ini_paging_get_size(struct iwl_fw_runtime *fwrt,
 	return size;
 }
 
-static u32 iwl_dump_ini_mon_dram_get_size(struct iwl_fw_runtime *fwrt,
-					  struct iwl_fw_ini_region_cfg *reg)
-{
-	u32 size = sizeof(struct iwl_fw_ini_monitor_dump) +
-		sizeof(struct iwl_fw_ini_error_dump_range);
-
-	if (fwrt->trans->dbg.num_blocks)
-		size += fwrt->trans->dbg.fw_mon[0].size;
-
-	return size;
-}
-
-static u32 iwl_dump_ini_mon_smem_get_size(struct iwl_fw_runtime *fwrt,
-					  struct iwl_fw_ini_region_cfg *reg)
-{
-	return sizeof(struct iwl_fw_ini_monitor_dump) +
-		iwl_dump_ini_mem_ranges(fwrt, reg) *
-		(sizeof(struct iwl_fw_ini_error_dump_range) +
-		 le32_to_cpu(reg->internal.range_data_size));
-}
-
 static u32 iwl_dump_ini_txf_get_size(struct iwl_fw_runtime *fwrt,
-				     struct iwl_fw_ini_region_cfg *reg)
+				     struct iwl_dump_ini_region_data *reg_data)
 {
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_txf_iter_data *iter = &fwrt->dump.txf_iter_data;
+	u32 registers_num = iwl_tlv_array_len(reg_data->reg_tlv, reg, addrs);
 	u32 size = 0;
 	u32 fifo_hdr = sizeof(struct iwl_fw_ini_error_dump_range) +
-		le32_to_cpu(reg->fifos.num_of_registers) *
-		sizeof(struct iwl_fw_ini_error_dump_register);
+		       registers_num *
+		       sizeof(struct iwl_fw_ini_error_dump_register);
 
-	while (iwl_ini_txf_iter(fwrt, reg, size)) {
+	while (iwl_ini_txf_iter(fwrt, reg_data, size)) {
 		size += fifo_hdr;
-		if (!reg->fifos.header_only)
+		if (!reg->fifos.hdr_only)
 			size += iter->fifo_size;
 	}
 
-	if (size)
-		size += sizeof(struct iwl_fw_ini_error_dump);
+	if (!size)
+		return 0;
 
-	return size;
+	return size + sizeof(struct iwl_fw_ini_error_dump);
 }
 
 static u32 iwl_dump_ini_rxf_get_size(struct iwl_fw_runtime *fwrt,
-				     struct iwl_fw_ini_region_cfg *reg)
+				     struct iwl_dump_ini_region_data *reg_data)
 {
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_ini_rxf_data rx_data;
+	u32 registers_num = iwl_tlv_array_len(reg_data->reg_tlv, reg, addrs);
 	u32 size = sizeof(struct iwl_fw_ini_error_dump) +
 		sizeof(struct iwl_fw_ini_error_dump_range) +
-		le32_to_cpu(reg->fifos.num_of_registers) *
-		sizeof(struct iwl_fw_ini_error_dump_register);
+		registers_num * sizeof(struct iwl_fw_ini_error_dump_register);
 
-	if (reg->fifos.header_only)
+	if (reg->fifos.hdr_only)
 		return size;
 
-	iwl_ini_get_rxf_data(fwrt, reg, &rx_data);
+	iwl_ini_get_rxf_data(fwrt, reg_data, &rx_data);
 	size += rx_data.size;
 
 	return size;
@@ -1627,14 +1529,15 @@ static u32 iwl_dump_ini_rxf_get_size(struct iwl_fw_runtime *fwrt,
  */
 struct iwl_dump_ini_mem_ops {
 	u32 (*get_num_of_ranges)(struct iwl_fw_runtime *fwrt,
-				 struct iwl_fw_ini_region_cfg *reg);
+				 struct iwl_dump_ini_region_data *reg_data);
 	u32 (*get_size)(struct iwl_fw_runtime *fwrt,
-			struct iwl_fw_ini_region_cfg *reg);
+			struct iwl_dump_ini_region_data *reg_data);
 	void *(*fill_mem_hdr)(struct iwl_fw_runtime *fwrt,
-			      struct iwl_fw_ini_region_cfg *reg, void *data);
+			      struct iwl_dump_ini_region_data *reg_data,
+			      void *data);
 	int (*fill_range)(struct iwl_fw_runtime *fwrt,
-			  struct iwl_fw_ini_region_cfg *reg, void *range,
-			  int idx);
+			  struct iwl_dump_ini_region_data *reg_data,
+			  void *range, int idx);
 };
 
 /**
@@ -1649,20 +1552,22 @@ struct iwl_dump_ini_mem_ops {
  * @ops: memory dump operations
  */
 static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
-			    struct iwl_fw_ini_region_cfg *reg,
+			    struct iwl_dump_ini_region_data *reg_data,
 			    const struct iwl_dump_ini_mem_ops *ops)
 {
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_dump_entry *entry;
 	struct iwl_fw_error_dump_data *tlv;
 	struct iwl_fw_ini_error_dump_header *header;
-	u32 num_of_ranges, i, type = le32_to_cpu(reg->region_type), size;
+	u32 type = le32_to_cpu(reg->type), id = le32_to_cpu(reg->id);
+	u32 num_of_ranges, i, size;
 	void *range;
 
 	if (!ops->get_num_of_ranges || !ops->get_size || !ops->fill_mem_hdr ||
 	    !ops->fill_range)
 		return 0;
 
-	size = ops->get_size(fwrt, reg);
+	size = ops->get_size(fwrt, reg_data);
 	if (!size)
 		return 0;
 
@@ -1673,36 +1578,35 @@ static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
 	entry->size = sizeof(*tlv) + size;
 
 	tlv = (void *)entry->data;
-	tlv->type = cpu_to_le32(type);
+	tlv->type = reg->type;
 	tlv->len = cpu_to_le32(size);
 
-	IWL_DEBUG_FW(fwrt, "WRT: Collecting region: id=%d, type=%d\n",
-		     le32_to_cpu(reg->region_id), type);
+	IWL_DEBUG_FW(fwrt, "WRT: Collecting region: id=%d, type=%d\n", id,
+		     type);
 
-	num_of_ranges = ops->get_num_of_ranges(fwrt, reg);
+	num_of_ranges = ops->get_num_of_ranges(fwrt, reg_data);
 
 	header = (void *)tlv->data;
-	header->region_id = reg->region_id;
+	header->region_id = reg->id;
 	header->num_of_ranges = cpu_to_le32(num_of_ranges);
-	header->name_len = cpu_to_le32(min_t(int, IWL_FW_INI_MAX_NAME,
-					     le32_to_cpu(reg->name_len)));
-	memcpy(header->name, reg->name, le32_to_cpu(header->name_len));
+	header->name_len = cpu_to_le32(IWL_FW_INI_MAX_NAME);
+	memcpy(header->name, reg->name, IWL_FW_INI_MAX_NAME);
 
-	range = ops->fill_mem_hdr(fwrt, reg, header);
+	range = ops->fill_mem_hdr(fwrt, reg_data, header);
 	if (!range) {
 		IWL_ERR(fwrt,
 			"WRT: Failed to fill region header: id=%d, type=%d\n",
-			le32_to_cpu(reg->region_id), type);
+			id, type);
 		goto out_err;
 	}
 
 	for (i = 0; i < num_of_ranges; i++) {
-		int range_size = ops->fill_range(fwrt, reg, range, i);
+		int range_size = ops->fill_range(fwrt, reg_data, range, i);
 
 		if (range_size < 0) {
 			IWL_ERR(fwrt,
 				"WRT: Failed to dump region: id=%d, type=%d\n",
-				le32_to_cpu(reg->region_id), type);
+				id, type);
 			goto out_err;
 		}
 		range = range + range_size;
@@ -1793,6 +1697,23 @@ static u32 iwl_dump_ini_info(struct iwl_fw_runtime *fwrt,
 
 static const struct iwl_dump_ini_mem_ops iwl_dump_ini_region_ops[] = {
 	[IWL_FW_INI_REGION_INVALID] = {},
+	[IWL_FW_INI_REGION_INTERNAL_BUFFER] = {},
+	[IWL_FW_INI_REGION_DRAM_BUFFER] = {},
+	[IWL_FW_INI_REGION_TXF] = {
+		.get_num_of_ranges = iwl_dump_ini_txf_ranges,
+		.get_size = iwl_dump_ini_txf_get_size,
+		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
+		.fill_range = iwl_dump_ini_txf_iter,
+	},
+	[IWL_FW_INI_REGION_RXF] = {
+		.get_num_of_ranges = iwl_dump_ini_single_range,
+		.get_size = iwl_dump_ini_rxf_get_size,
+		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
+		.fill_range = iwl_dump_ini_rxf_iter,
+	},
+	[IWL_FW_INI_REGION_LMAC_ERROR_TABLE] = {},
+	[IWL_FW_INI_REGION_UMAC_ERROR_TABLE] = {},
+	[IWL_FW_INI_REGION_RSP_OR_NOTIF] = {},
 	[IWL_FW_INI_REGION_DEVICE_MEMORY] = {
 		.get_num_of_ranges = iwl_dump_ini_mem_ranges,
 		.get_size = iwl_dump_ini_mem_get_size,
@@ -1807,31 +1728,6 @@ static const struct iwl_dump_ini_mem_ops iwl_dump_ini_region_ops[] = {
 	},
 	[IWL_FW_INI_REGION_PERIPHERY_PHY] = {},
 	[IWL_FW_INI_REGION_PERIPHERY_AUX] = {},
-	[IWL_FW_INI_REGION_DRAM_BUFFER] = {
-		.get_num_of_ranges = iwl_dump_ini_mon_dram_ranges,
-		.get_size = iwl_dump_ini_mon_dram_get_size,
-		.fill_mem_hdr = iwl_dump_ini_mon_dram_fill_header,
-		.fill_range = iwl_dump_ini_mon_dram_iter,
-	},
-	[IWL_FW_INI_REGION_DRAM_IMR] = {},
-	[IWL_FW_INI_REGION_INTERNAL_BUFFER] = {
-		.get_num_of_ranges = iwl_dump_ini_mem_ranges,
-		.get_size = iwl_dump_ini_mon_smem_get_size,
-		.fill_mem_hdr = iwl_dump_ini_mon_smem_fill_header,
-		.fill_range = iwl_dump_ini_dev_mem_iter,
-	},
-	[IWL_FW_INI_REGION_TXF] = {
-		.get_num_of_ranges = iwl_dump_ini_txf_ranges,
-		.get_size = iwl_dump_ini_txf_get_size,
-		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
-		.fill_range = iwl_dump_ini_txf_iter,
-	},
-	[IWL_FW_INI_REGION_RXF] = {
-		.get_num_of_ranges = iwl_dump_ini_rxf_ranges,
-		.get_size = iwl_dump_ini_rxf_get_size,
-		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
-		.fill_range = iwl_dump_ini_rxf_iter,
-	},
 	[IWL_FW_INI_REGION_PAGING] = {
 		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
 		.get_num_of_ranges = iwl_dump_ini_paging_ranges,
@@ -1844,26 +1740,16 @@ static const struct iwl_dump_ini_mem_ops iwl_dump_ini_region_ops[] = {
 		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
 		.fill_range = iwl_dump_ini_csr_iter,
 	},
-	[IWL_FW_INI_REGION_NOTIFICATION] = {},
-	[IWL_FW_INI_REGION_DHC] = {},
-	[IWL_FW_INI_REGION_LMAC_ERROR_TABLE] = {
-		.get_num_of_ranges = iwl_dump_ini_mem_ranges,
-		.get_size = iwl_dump_ini_mem_get_size,
-		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
-		.fill_range = iwl_dump_ini_dev_mem_iter,
-	},
-	[IWL_FW_INI_REGION_UMAC_ERROR_TABLE] = {
-		.get_num_of_ranges = iwl_dump_ini_mem_ranges,
-		.get_size = iwl_dump_ini_mem_get_size,
-		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
-		.fill_range = iwl_dump_ini_dev_mem_iter,
-	},
+	[IWL_FW_INI_REGION_DRAM_IMR] = {},
+	[IWL_FW_INI_REGION_PCI_IOSF_CONFIG] = {},
 };
 
 static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 				struct iwl_fw_ini_trigger *trigger,
 				struct list_head *list)
 {
+	struct iwl_dump_ini_mem_ops empty_ops = {};
+	struct iwl_dump_ini_region_data reg_data = {};
 	int i;
 	u32 size = 0;
 
@@ -1890,8 +1776,8 @@ static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 		if (reg_type >= ARRAY_SIZE(iwl_dump_ini_region_ops))
 			continue;
 
-		size += iwl_dump_ini_mem(fwrt, list, reg,
-					 &iwl_dump_ini_region_ops[reg_type]);
+		size += iwl_dump_ini_mem(fwrt, list, &reg_data,
+					 &empty_ops);
 	}
 
 	if (size)
-- 
2.23.0

