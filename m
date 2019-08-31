Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E051A43D0
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2019 11:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfHaJxC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Aug 2019 05:53:02 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:39760 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726968AbfHaJxC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Aug 2019 05:53:02 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i400T-0002OQ-4M; Sat, 31 Aug 2019 12:49:17 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 31 Aug 2019 12:48:56 +0300
Message-Id: <20190831094859.6391-17-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190831094859.6391-1-luca@coelho.fi>
References: <20190831094859.6391-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 16/19] iwlwifi: dbg_ini: use linked list for dump TLVs during dump creation
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Avoid iterating over dump TLVs twice for size calculation by using
linked list to store the dump TLVs.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 288 ++++++++----------
 .../wireless/intel/iwlwifi/fw/error-dump.h    |  22 ++
 2 files changed, 152 insertions(+), 158 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 3320acc8a52f..73af6e6a54c3 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1664,38 +1664,50 @@ struct iwl_dump_ini_mem_ops {
 };
 
 /**
- * iwl_dump_ini_mem - copy a memory region into the dump
- * @fwrt: fw runtime struct.
- * @data: dump memory data.
- * @reg: region to copy to the dump.
- * @ops: memory dump operations.
+ * iwl_dump_ini_mem
+ *
+ * Creates a dump tlv and copy a memory region into it.
+ * Returns the size of the current dump tlv or 0 if failed
+ *
+ * @fwrt: fw runtime struct
+ * @list: list to add the dump tlv to
+ * @reg: memory region
+ * @ops: memory dump operations
  */
-static void
-iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt,
-		 struct iwl_fw_error_dump_data **data,
-		 struct iwl_fw_ini_region_cfg *reg,
-		 struct iwl_dump_ini_mem_ops *ops)
+static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
+			    struct iwl_fw_ini_region_cfg *reg,
+			    struct iwl_dump_ini_mem_ops *ops)
 {
-	struct iwl_fw_ini_error_dump_header *header = (void *)(*data)->data;
+	struct iwl_fw_ini_dump_entry *entry;
+	struct iwl_fw_error_dump_data *tlv;
+	struct iwl_fw_ini_error_dump_header *header;
 	u32 num_of_ranges, i, type = le32_to_cpu(reg->region_type), size;
 	void *range;
 
 	if (WARN_ON(!ops || !ops->get_num_of_ranges || !ops->get_size ||
 		    !ops->fill_mem_hdr || !ops->fill_range))
-		return;
+		return 0;
 
 	size = ops->get_size(fwrt, reg);
 	if (!size)
-		return;
+		return 0;
+
+	entry = kmalloc(sizeof(*entry) + sizeof(*tlv) + size, GFP_KERNEL);
+	if (!entry)
+		return 0;
+
+	entry->size = sizeof(*tlv) + size;
+
+	tlv = (void *)entry->data;
+	tlv->type = cpu_to_le32(type);
+	tlv->len = cpu_to_le32(size);
 
 	IWL_DEBUG_FW(fwrt, "WRT: Collecting region: id=%d, type=%d\n",
 		     le32_to_cpu(reg->region_id), type);
 
 	num_of_ranges = ops->get_num_of_ranges(fwrt, reg);
 
-	(*data)->type = cpu_to_le32(type);
-	(*data)->len = cpu_to_le32(size);
-
+	header = (void *)tlv->data;
 	header->region_id = reg->region_id;
 	header->num_of_ranges = cpu_to_le32(num_of_ranges);
 	header->name_len = cpu_to_le32(min_t(int, IWL_FW_INI_MAX_NAME,
@@ -1707,8 +1719,7 @@ iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt,
 		IWL_ERR(fwrt,
 			"WRT: Failed to fill region header: id=%d, type=%d\n",
 			le32_to_cpu(reg->region_id), type);
-		memset(*data, 0, size);
-		return;
+		goto out_err;
 	}
 
 	for (i = 0; i < num_of_ranges; i++) {
@@ -1718,23 +1729,42 @@ iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt,
 			IWL_ERR(fwrt,
 				"WRT: Failed to dump region: id=%d, type=%d\n",
 				le32_to_cpu(reg->region_id), type);
-			memset(*data, 0, size);
-			return;
+			goto out_err;
 		}
 		range = range + range_size;
 	}
-	*data = iwl_fw_error_next_data(*data);
+
+	list_add_tail(&entry->list, list);
+
+	return entry->size;
+
+out_err:
+	kfree(entry);
+
+	return 0;
 }
 
-static void iwl_dump_ini_info(struct iwl_fw_runtime *fwrt,
-			      struct iwl_fw_ini_trigger *trigger,
-			      struct iwl_fw_error_dump_data **data)
+static u32 iwl_dump_ini_info(struct iwl_fw_runtime *fwrt,
+			     struct iwl_fw_ini_trigger *trigger,
+			     struct list_head *list)
 {
-	struct iwl_fw_ini_dump_info *dump = (void *)(*data)->data;
+	struct iwl_fw_ini_dump_entry *entry;
+	struct iwl_fw_error_dump_data *tlv;
+	struct iwl_fw_ini_dump_info *dump;
 	u32 reg_ids_size = le32_to_cpu(trigger->num_regions) * sizeof(__le32);
+	u32 size = sizeof(*tlv) + sizeof(*dump) + reg_ids_size;
+
+	entry = kmalloc(sizeof(*entry) + size, GFP_KERNEL);
+	if (!entry)
+		return 0;
 
-	(*data)->type = cpu_to_le32(IWL_INI_DUMP_INFO_TYPE);
-	(*data)->len = cpu_to_le32(sizeof(*dump) + reg_ids_size);
+	entry->size = size;
+
+	tlv = (void *)entry->data;
+	tlv->type = cpu_to_le32(IWL_INI_DUMP_INFO_TYPE);
+	tlv->len = cpu_to_le32(sizeof(*dump) + reg_ids_size);
+
+	dump = (void *)tlv->data;
 
 	dump->version = cpu_to_le32(IWL_INI_DUMP_VER);
 	dump->trigger_id = trigger->trigger_id;
@@ -1773,31 +1803,31 @@ static void iwl_dump_ini_info(struct iwl_fw_runtime *fwrt,
 	dump->external_dbg_cfg_name_len =
 		cpu_to_le32(sizeof(dump->external_dbg_cfg_name));
 
-	/* dump info size is allocated in iwl_fw_ini_get_trigger_len.
-	 * The driver allocates (sizeof(*dump) + reg_ids_size) so it is safe to
-	 * use reg_ids_size
-	 */
 	memcpy(dump->external_dbg_cfg_name, fwrt->dump.external_dbg_cfg_name,
 	       sizeof(dump->external_dbg_cfg_name));
 
 	dump->regions_num = trigger->num_regions;
 	memcpy(dump->region_ids, trigger->data, reg_ids_size);
 
-	*data = iwl_fw_error_next_data(*data);
+	/* add dump info TLV to the beginning of the list since it needs to be
+	 * the first TLV in the dump
+	 */
+	list_add(&entry->list, list);
+
+	return entry->size;
 }
 
-static int iwl_fw_ini_get_trigger_len(struct iwl_fw_runtime *fwrt,
-				      struct iwl_fw_ini_trigger *trigger)
+static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
+				struct iwl_fw_ini_trigger *trigger,
+				struct list_head *list)
 {
-	int i, ret_size = 0, hdr_len = sizeof(struct iwl_fw_error_dump_data);
-	u32 size;
-
-	if (!trigger || !trigger->num_regions)
-		return 0;
+	int i;
+	u32 size = 0;
 
 	for (i = 0; i < le32_to_cpu(trigger->num_regions); i++) {
 		u32 reg_id = le32_to_cpu(trigger->data[i]);
 		struct iwl_fw_ini_region_cfg *reg;
+		struct iwl_dump_ini_mem_ops ops;
 
 		if (WARN_ON(reg_id >= ARRAY_SIZE(fwrt->dump.active_regs)))
 			continue;
@@ -1810,89 +1840,6 @@ static int iwl_fw_ini_get_trigger_len(struct iwl_fw_runtime *fwrt,
 			continue;
 		}
 
-		/* currently the driver supports always on domain only */
-		if (le32_to_cpu(reg->domain) != IWL_FW_INI_DBG_DOMAIN_ALWAYS_ON)
-			continue;
-
-		switch (le32_to_cpu(reg->region_type)) {
-		case IWL_FW_INI_REGION_DEVICE_MEMORY:
-		case IWL_FW_INI_REGION_PERIPHERY_MAC:
-		case IWL_FW_INI_REGION_PERIPHERY_PHY:
-		case IWL_FW_INI_REGION_PERIPHERY_AUX:
-		case IWL_FW_INI_REGION_CSR:
-		case IWL_FW_INI_REGION_LMAC_ERROR_TABLE:
-		case IWL_FW_INI_REGION_UMAC_ERROR_TABLE:
-			size = iwl_dump_ini_mem_get_size(fwrt, reg);
-			if (size)
-				ret_size += hdr_len + size;
-			break;
-		case IWL_FW_INI_REGION_TXF:
-			size = iwl_dump_ini_txf_get_size(fwrt, reg);
-			if (size)
-				ret_size += hdr_len + size;
-			break;
-		case IWL_FW_INI_REGION_RXF:
-			size = iwl_dump_ini_rxf_get_size(fwrt, reg);
-			if (size)
-				ret_size += hdr_len + size;
-			break;
-		case IWL_FW_INI_REGION_PAGING:
-			if (iwl_fw_dbg_is_paging_enabled(fwrt))
-				size = iwl_dump_ini_paging_get_size(fwrt, reg);
-			else
-				size = iwl_dump_ini_paging_gen2_get_size(fwrt,
-									 reg);
-			if (size)
-				ret_size += hdr_len + size;
-			break;
-		case IWL_FW_INI_REGION_DRAM_BUFFER:
-			if (!fwrt->trans->dbg.num_blocks)
-				break;
-			size = iwl_dump_ini_mon_dram_get_size(fwrt, reg);
-			if (size)
-				ret_size += hdr_len + size;
-			break;
-		case IWL_FW_INI_REGION_INTERNAL_BUFFER:
-			size = iwl_dump_ini_mon_smem_get_size(fwrt, reg);
-			if (size)
-				ret_size += hdr_len + size;
-			break;
-		case IWL_FW_INI_REGION_DRAM_IMR:
-			/* Undefined yet */
-		default:
-			break;
-		}
-	}
-
-	/* add dump info size */
-	if (ret_size)
-		ret_size += hdr_len + sizeof(struct iwl_fw_ini_dump_info) +
-			(le32_to_cpu(trigger->num_regions) * sizeof(__le32));
-
-	return ret_size;
-}
-
-static void iwl_fw_ini_dump_trigger(struct iwl_fw_runtime *fwrt,
-				    struct iwl_fw_ini_trigger *trigger,
-				    struct iwl_fw_error_dump_data **data)
-{
-	int i, num = le32_to_cpu(trigger->num_regions);
-
-	iwl_dump_ini_info(fwrt, trigger, data);
-
-	for (i = 0; i < num; i++) {
-		u32 reg_id = le32_to_cpu(trigger->data[i]);
-		struct iwl_fw_ini_region_cfg *reg;
-		struct iwl_dump_ini_mem_ops ops;
-
-		if (reg_id >= ARRAY_SIZE(fwrt->dump.active_regs))
-			continue;
-
-		reg = fwrt->dump.active_regs[reg_id];
-		/* Don't warn, get_trigger_len already warned */
-		if (!reg)
-			continue;
-
 		/* currently the driver supports always on domain only */
 		if (le32_to_cpu(reg->domain) != IWL_FW_INI_DBG_DOMAIN_ALWAYS_ON)
 			continue;
@@ -1905,28 +1852,28 @@ static void iwl_fw_ini_dump_trigger(struct iwl_fw_runtime *fwrt,
 			ops.get_size = iwl_dump_ini_mem_get_size;
 			ops.fill_mem_hdr = iwl_dump_ini_mem_fill_header;
 			ops.fill_range = iwl_dump_ini_dev_mem_iter;
-			iwl_dump_ini_mem(fwrt, data, reg, &ops);
+			size += iwl_dump_ini_mem(fwrt, list, reg, &ops);
 			break;
 		case IWL_FW_INI_REGION_PERIPHERY_MAC:
 			ops.get_num_of_ranges =	iwl_dump_ini_mem_ranges;
 			ops.get_size = iwl_dump_ini_mem_get_size;
 			ops.fill_mem_hdr = iwl_dump_ini_mem_fill_header;
 			ops.fill_range = iwl_dump_ini_prph_iter;
-			iwl_dump_ini_mem(fwrt, data, reg, &ops);
+			size += iwl_dump_ini_mem(fwrt, list, reg, &ops);
 			break;
 		case IWL_FW_INI_REGION_DRAM_BUFFER:
 			ops.get_num_of_ranges = iwl_dump_ini_mon_dram_ranges;
 			ops.get_size = iwl_dump_ini_mon_dram_get_size;
 			ops.fill_mem_hdr = iwl_dump_ini_mon_dram_fill_header;
 			ops.fill_range = iwl_dump_ini_mon_dram_iter;
-			iwl_dump_ini_mem(fwrt, data, reg, &ops);
+			size += iwl_dump_ini_mem(fwrt, list, reg, &ops);
 			break;
 		case IWL_FW_INI_REGION_INTERNAL_BUFFER:
 			ops.get_num_of_ranges = iwl_dump_ini_mem_ranges;
 			ops.get_size = iwl_dump_ini_mon_smem_get_size;
 			ops.fill_mem_hdr = iwl_dump_ini_mon_smem_fill_header;
 			ops.fill_range = iwl_dump_ini_dev_mem_iter;
-			iwl_dump_ini_mem(fwrt, data, reg, &ops);
+			size += iwl_dump_ini_mem(fwrt, list, reg, &ops);
 			break;
 		case IWL_FW_INI_REGION_PAGING:
 			ops.fill_mem_hdr = iwl_dump_ini_mem_fill_header;
@@ -1942,8 +1889,7 @@ static void iwl_fw_ini_dump_trigger(struct iwl_fw_runtime *fwrt,
 					iwl_dump_ini_paging_gen2_get_size;
 				ops.fill_range = iwl_dump_ini_paging_gen2_iter;
 			}
-
-			iwl_dump_ini_mem(fwrt, data, reg, &ops);
+			size += iwl_dump_ini_mem(fwrt, list, reg, &ops);
 			break;
 		case IWL_FW_INI_REGION_TXF: {
 			struct iwl_ini_txf_iter_data iter = { .init = true };
@@ -1954,7 +1900,7 @@ static void iwl_fw_ini_dump_trigger(struct iwl_fw_runtime *fwrt,
 			ops.get_size = iwl_dump_ini_txf_get_size;
 			ops.fill_mem_hdr = iwl_dump_ini_mem_fill_header;
 			ops.fill_range = iwl_dump_ini_txf_iter;
-			iwl_dump_ini_mem(fwrt, data, reg, &ops);
+			size += iwl_dump_ini_mem(fwrt, list, reg, &ops);
 			fwrt->dump.fifo_iter = fifo_iter;
 			break;
 		}
@@ -1963,14 +1909,14 @@ static void iwl_fw_ini_dump_trigger(struct iwl_fw_runtime *fwrt,
 			ops.get_size = iwl_dump_ini_rxf_get_size;
 			ops.fill_mem_hdr = iwl_dump_ini_mem_fill_header;
 			ops.fill_range = iwl_dump_ini_rxf_iter;
-			iwl_dump_ini_mem(fwrt, data, reg, &ops);
+			size += iwl_dump_ini_mem(fwrt, list, reg, &ops);
 			break;
 		case IWL_FW_INI_REGION_CSR:
 			ops.get_num_of_ranges =	iwl_dump_ini_mem_ranges;
 			ops.get_size = iwl_dump_ini_mem_get_size;
 			ops.fill_mem_hdr = iwl_dump_ini_mem_fill_header;
 			ops.fill_range = iwl_dump_ini_csr_iter;
-			iwl_dump_ini_mem(fwrt, data, reg, &ops);
+			size += iwl_dump_ini_mem(fwrt, list, reg, &ops);
 			break;
 		case IWL_FW_INI_REGION_PERIPHERY_PHY:
 		case IWL_FW_INI_REGION_PERIPHERY_AUX:
@@ -1980,39 +1926,48 @@ static void iwl_fw_ini_dump_trigger(struct iwl_fw_runtime *fwrt,
 			break;
 		}
 	}
+
+	if (size)
+		size += iwl_dump_ini_info(fwrt, trigger, list);
+
+	return size;
 }
 
-static struct iwl_fw_error_dump_file *
-iwl_fw_error_ini_dump_file(struct iwl_fw_runtime *fwrt,
-			   enum iwl_fw_ini_trigger_id trig_id)
+static u32 iwl_dump_ini_file_gen(struct iwl_fw_runtime *fwrt,
+				 enum iwl_fw_ini_trigger_id trig_id,
+				 struct list_head *list)
 {
-	int size;
-	struct iwl_fw_error_dump_data *dump_data;
-	struct iwl_fw_error_dump_file *dump_file;
+	struct iwl_fw_ini_dump_entry *entry;
+	struct iwl_fw_ini_dump_file_hdr *hdr;
 	struct iwl_fw_ini_trigger *trigger;
+	u32 size;
 
 	if (!iwl_fw_ini_trigger_on(fwrt, trig_id))
-		return NULL;
+		return 0;
 
 	trigger = fwrt->dump.active_trigs[trig_id].trig;
+	if (!trigger || !le32_to_cpu(trigger->num_regions))
+		return 0;
 
-	size = iwl_fw_ini_get_trigger_len(fwrt, trigger);
-	if (!size)
-		return NULL;
+	entry = kmalloc(sizeof(*entry) + sizeof(*hdr), GFP_KERNEL);
+	if (!entry)
+		return 0;
 
-	size += sizeof(*dump_file);
+	entry->size = sizeof(*hdr);
 
-	dump_file = vzalloc(size);
-	if (!dump_file)
-		return NULL;
+	size = iwl_dump_ini_trigger(fwrt, trigger, list);
+	if (!size) {
+		kfree(entry);
+		return 0;
+	}
 
-	dump_file->barker = cpu_to_le32(IWL_FW_INI_ERROR_DUMP_BARKER);
-	dump_data = (void *)dump_file->data;
-	dump_file->file_len = cpu_to_le32(size);
+	hdr = (void *)entry->data;
+	hdr->barker = cpu_to_le32(IWL_FW_INI_ERROR_DUMP_BARKER);
+	hdr->file_len = cpu_to_le32(size + entry->size);
 
-	iwl_fw_ini_dump_trigger(fwrt, trigger, &dump_data);
+	list_add(&entry->list, list);
 
-	return dump_file;
+	return le32_to_cpu(hdr->file_len);
 }
 
 static void iwl_fw_error_dump(struct iwl_fw_runtime *fwrt)
@@ -2061,27 +2016,44 @@ static void iwl_fw_error_dump(struct iwl_fw_runtime *fwrt)
 	iwl_fw_free_dump_desc(fwrt);
 }
 
+static void iwl_dump_ini_list_free(struct list_head *list)
+{
+	while (!list_empty(list)) {
+		struct iwl_fw_ini_dump_entry *entry =
+			list_entry(list->next, typeof(*entry), list);
+
+		list_del(&entry->list);
+		kfree(entry);
+	}
+}
+
 static void iwl_fw_error_ini_dump(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 {
 	enum iwl_fw_ini_trigger_id trig_id = fwrt->dump.wks[wk_idx].ini_trig_id;
-	struct iwl_fw_error_dump_file *dump_file;
+	struct list_head dump_list = LIST_HEAD_INIT(dump_list);
 	struct scatterlist *sg_dump_data;
 	u32 file_len;
 
-	dump_file = iwl_fw_error_ini_dump_file(fwrt, trig_id);
-	if (!dump_file)
+	file_len = iwl_dump_ini_file_gen(fwrt, trig_id, &dump_list);
+	if (!file_len)
 		goto out;
 
-	file_len = le32_to_cpu(dump_file->file_len);
-
 	sg_dump_data = alloc_sgtable(file_len);
 	if (sg_dump_data) {
-		sg_pcopy_from_buffer(sg_dump_data, sg_nents(sg_dump_data),
-				     dump_file, file_len, 0);
+		struct iwl_fw_ini_dump_entry *entry;
+		int sg_entries = sg_nents(sg_dump_data);
+		u32 offs = 0;
+
+		list_for_each_entry(entry, &dump_list, list) {
+			sg_pcopy_from_buffer(sg_dump_data, sg_entries,
+					     entry->data, entry->size, offs);
+			offs += entry->size;
+		}
 		dev_coredumpsg(fwrt->trans->dev, sg_dump_data, file_len,
 			       GFP_KERNEL);
 	}
-	vfree(dump_file);
+	iwl_dump_ini_list_free(&dump_list);
+
 out:
 	fwrt->dump.wks[wk_idx].ini_trig_id = IWL_FW_TRIGGER_ID_INVALID;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
index 00a45ea85b69..9529e5925ad5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -287,6 +287,28 @@ struct iwl_fw_error_dump_mem {
 /* Use bit 31 as dump info type to avoid colliding with region types */
 #define IWL_INI_DUMP_INFO_TYPE BIT(31)
 
+/**
+ * struct iwl_fw_ini_dump_entry
+ * @list: list of dump entries
+ * @size: size of the data
+ * @data: entry data
+ */
+struct iwl_fw_ini_dump_entry {
+	struct list_head list;
+	u32 size;
+	u8 data[];
+} __packed;
+
+/**
+ * struct iwl_fw_error_dump_file - header of dump file
+ * @barker: must be %IWL_FW_INI_ERROR_DUMP_BARKER
+ * @file_len: the length of all the file including the header
+ */
+struct iwl_fw_ini_dump_file_hdr {
+	__le32 barker;
+	__le32 file_len;
+} __packed;
+
 /**
  * struct iwl_fw_ini_fifo_hdr - fifo range header
  * @fifo_num: the fifo number. In case of umac rx fifo, set BIT(31) to
-- 
2.23.0.rc1

