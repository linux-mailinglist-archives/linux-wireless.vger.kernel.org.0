Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E56C27938C
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Sep 2020 23:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgIYVbB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Sep 2020 17:31:01 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52296 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726744AbgIYVbA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Sep 2020 17:31:00 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kLvIw-002J1P-A2; Sat, 26 Sep 2020 00:30:58 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 26 Sep 2020 00:30:40 +0300
Message-Id: <iwlwifi.20200926002540.88c431fad7da.I282944cbad5aa367735a9f9a5c47cfbd107a5fc0@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925213053.454459-1-luca@coelho.fi>
References: <20200925213053.454459-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 02/15] iwlwifi: dbg: add dumping special device memory
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

With the new region we can handle in user space understanding
the struct type and version and driver doesn't need to be involved
at all.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   | 22 ++++++++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 56 +++++++++++++++++++
 .../wireless/intel/iwlwifi/fw/error-dump.h    | 14 +++++
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  7 +++
 4 files changed, 99 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index 8e34b509e6cc..cefd833d1968 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -134,6 +134,25 @@ struct iwl_fw_ini_region_err_table {
 	__le32 offset;
 } __packed; /* FW_TLV_DEBUG_REGION_ERROR_TABLE_API_S_VER_1 */
 
+/**
+ * struct iwl_fw_ini_region_special_device_memory - special device memory
+ *
+ * Configuration to read a special memory
+ *
+ * @type: type of the special memory
+ * @version: version of the special memory
+ * @base_addr: base address of the error table
+ * @size: size of the error table
+ * @offset: offset to add to &base_addr
+ */
+struct iwl_fw_ini_region_special_device_memory {
+	__le16 type;
+	__le16 version;
+	__le32 base_addr;
+	__le32 size;
+	__le32 offset;
+} __packed; /* FW_TLV_DEBUG_REGION_SPECIAL_DEVICE_ADDR_API_S_VER_1 */
+
 /**
  * struct iwl_fw_ini_region_internal_buffer - internal buffer region data
  *
@@ -185,6 +204,7 @@ struct iwl_fw_ini_region_tlv {
 		struct iwl_fw_ini_region_fifos fifos;
 		struct iwl_fw_ini_region_err_table err_table;
 		struct iwl_fw_ini_region_internal_buffer internal_buffer;
+		struct iwl_fw_ini_region_special_device_memory special_mem;
 		__le32 dram_alloc_id;
 		__le32 tlv_mask;
 	}; /* FW_TLV_DEBUG_REGION_CONF_PARAMS_API_U_VER_1 */
@@ -327,6 +347,7 @@ enum iwl_fw_ini_buffer_location {
  * @IWL_FW_INI_REGION_CSR: CSR registers
  * @IWL_FW_INI_REGION_DRAM_IMR: IMR memory
  * @IWL_FW_INI_REGION_PCI_IOSF_CONFIG: PCI/IOSF config
+ * @IWL_FW_INI_REGION_SPECIAL_DEVICE_MEMORY: special device memroy
  * @IWL_FW_INI_REGION_NUM: number of region types
  */
 enum iwl_fw_ini_region_type {
@@ -347,6 +368,7 @@ enum iwl_fw_ini_region_type {
 	IWL_FW_INI_REGION_CSR,
 	IWL_FW_INI_REGION_DRAM_IMR,
 	IWL_FW_INI_REGION_PCI_IOSF_CONFIG,
+	IWL_FW_INI_REGION_SPECIAL_DEVICE_MEMORY,
 	IWL_FW_INI_REGION_NUM
 }; /* FW_TLV_DEBUG_REGION_TYPE_API_E */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 7ea55cfdd8a8..ab4a8b942c81 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1507,6 +1507,27 @@ iwl_dump_ini_err_table_iter(struct iwl_fw_runtime *fwrt,
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
 
+static int
+iwl_dump_ini_special_mem_iter(struct iwl_fw_runtime *fwrt,
+			      struct iwl_dump_ini_region_data *reg_data,
+			      void *range_ptr, int idx)
+{
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+	struct iwl_fw_ini_region_special_device_memory *special_mem =
+		&reg->special_mem;
+
+	struct iwl_fw_ini_error_dump_range *range = range_ptr;
+	u32 addr = le32_to_cpu(special_mem->base_addr) +
+		   le32_to_cpu(special_mem->offset);
+
+	range->internal_base_addr = cpu_to_le32(addr);
+	range->range_data_size = special_mem->size;
+	iwl_trans_read_mem_bytes(fwrt->trans, addr, range->data,
+				 le32_to_cpu(special_mem->size));
+
+	return sizeof(*range) + le32_to_cpu(range->range_data_size);
+}
+
 static int iwl_dump_ini_fw_pkt_iter(struct iwl_fw_runtime *fwrt,
 				    struct iwl_dump_ini_region_data *reg_data,
 				    void *range_ptr, int idx)
@@ -1636,6 +1657,21 @@ iwl_dump_ini_err_table_fill_header(struct iwl_fw_runtime *fwrt,
 	return dump->ranges;
 }
 
+static void *
+iwl_dump_ini_special_mem_fill_header(struct iwl_fw_runtime *fwrt,
+				     struct iwl_dump_ini_region_data *reg_data,
+				     void *data)
+{
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+	struct iwl_fw_ini_special_device_memory *dump = data;
+
+	dump->header.version = cpu_to_le32(IWL_INI_DUMP_VER);
+	dump->type = reg->special_mem.type;
+	dump->version = reg->special_mem.version;
+
+	return dump->ranges;
+}
+
 static u32 iwl_dump_ini_mem_ranges(struct iwl_fw_runtime *fwrt,
 				   struct iwl_dump_ini_region_data *reg_data)
 {
@@ -1826,6 +1862,20 @@ iwl_dump_ini_err_table_get_size(struct iwl_fw_runtime *fwrt,
 	return size;
 }
 
+static u32
+iwl_dump_ini_special_mem_get_size(struct iwl_fw_runtime *fwrt,
+				  struct iwl_dump_ini_region_data *reg_data)
+{
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+	u32 size = le32_to_cpu(reg->special_mem.size);
+
+	if (size)
+		size += sizeof(struct iwl_fw_ini_special_device_memory) +
+			sizeof(struct iwl_fw_ini_error_dump_range);
+
+	return size;
+}
+
 static u32
 iwl_dump_ini_fw_pkt_get_size(struct iwl_fw_runtime *fwrt,
 			     struct iwl_dump_ini_region_data *reg_data)
@@ -2125,6 +2175,12 @@ static const struct iwl_dump_ini_mem_ops iwl_dump_ini_region_ops[] = {
 		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
 		.fill_range = iwl_dump_ini_config_iter,
 	},
+	[IWL_FW_INI_REGION_SPECIAL_DEVICE_MEMORY] = {
+		.get_num_of_ranges = iwl_dump_ini_single_range,
+		.get_size = iwl_dump_ini_special_mem_get_size,
+		.fill_mem_hdr = iwl_dump_ini_special_mem_fill_header,
+		.fill_range = iwl_dump_ini_special_mem_iter,
+	},
 };
 
 static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
index 72bfc64580ab..cb40f509ab61 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -494,6 +494,20 @@ struct iwl_fw_ini_monitor_dump {
 	struct iwl_fw_ini_error_dump_range ranges[];
 } __packed;
 
+/**
+ * struct iwl_fw_ini_special_device_memory - special device memory
+ * @header: header of the region
+ * @type: type of special memory
+ * @version: struct special memory version
+ * @ranges: the memory ranges of this this region
+ */
+struct iwl_fw_ini_special_device_memory {
+	struct iwl_fw_ini_error_dump_header header;
+	__le16 type;
+	__le16 version;
+	struct iwl_fw_ini_error_dump_range ranges[];
+} __packed;
+
 /**
  * struct iwl_fw_error_dump_paging - content of the UMAC's image page
  *	block on DRAM
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 9ce7207d9ec5..c44e61aa2aca 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -233,6 +233,13 @@ static int iwl_dbg_tlv_alloc_region(struct iwl_trans *trans,
 	if (le32_to_cpu(tlv->length) < sizeof(*reg))
 		return -EINVAL;
 
+	/* For safe using a string from FW make sure we have a
+	 * null terminator
+	 */
+	reg->name[IWL_FW_INI_MAX_NAME - 1] = 0;
+
+	IWL_DEBUG_FW(trans, "WRT: parsing region: %s\n", reg->name);
+
 	if (id >= IWL_FW_INI_MAX_REGION_ID) {
 		IWL_ERR(trans, "WRT: Invalid region id %u\n", id);
 		return -EINVAL;
-- 
2.28.0

