Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 787BC5974E
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 11:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfF1JUa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 05:20:30 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54746 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726667AbfF1JUa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 05:20:30 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hgn3S-0001ny-CP; Fri, 28 Jun 2019 12:20:26 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 14/20] iwlwifi: dbg: move trans debug fields to a separate struct
Date:   Fri, 28 Jun 2019 12:20:02 +0300
Message-Id: <20190628092008.11049-15-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628092008.11049-1-luca@coelho.fi>
References: <20190628092008.11049-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Unite iwl_trans debug related fields under iwl_trans_debug struct to
increase readability and keep iwl_trans clean.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  44 +++---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |  24 ++--
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  32 ++---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   8 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  73 ++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  10 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |   8 +-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |   8 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |   2 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 135 +++++++++---------
 13 files changed, 184 insertions(+), 168 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index a00323d72be1..8dc56f14a5cb 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1155,10 +1155,10 @@ iwl_dump_ini_mon_dram_iter(struct iwl_fw_runtime *fwrt,
 		return -EBUSY;
 
 	range->dram_base_addr = cpu_to_le64(start_addr);
-	range->range_data_size = cpu_to_le32(fwrt->trans->fw_mon[idx].size);
+	range->range_data_size = cpu_to_le32(fwrt->trans->dbg.fw_mon[idx].size);
 
-	memcpy(range->data, fwrt->trans->fw_mon[idx].block,
-	       fwrt->trans->fw_mon[idx].size);
+	memcpy(range->data, fwrt->trans->dbg.fw_mon[idx].block,
+	       fwrt->trans->dbg.fw_mon[idx].size);
 
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
@@ -1581,8 +1581,8 @@ static u32 iwl_dump_ini_mon_dram_get_size(struct iwl_fw_runtime *fwrt,
 	u32 size = sizeof(struct iwl_fw_ini_monitor_dump) +
 		sizeof(struct iwl_fw_ini_error_dump_range);
 
-	if (fwrt->trans->num_blocks)
-		size += fwrt->trans->fw_mon[0].size;
+	if (fwrt->trans->dbg.num_blocks)
+		size += fwrt->trans->dbg.fw_mon[0].size;
 
 	return size;
 }
@@ -1735,7 +1735,8 @@ static void iwl_dump_ini_info(struct iwl_fw_runtime *fwrt,
 
 	dump->version = cpu_to_le32(IWL_INI_DUMP_VER);
 	dump->trigger_id = trigger->trigger_id;
-	dump->is_external_cfg = cpu_to_le32(fwrt->trans->external_ini_loaded);
+	dump->is_external_cfg =
+		cpu_to_le32(fwrt->trans->dbg.external_ini_loaded);
 
 	dump->ver_type = cpu_to_le32(fwrt->dump.fw_ver.type);
 	dump->ver_subtype = cpu_to_le32(fwrt->dump.fw_ver.subtype);
@@ -1842,7 +1843,7 @@ static int iwl_fw_ini_get_trigger_len(struct iwl_fw_runtime *fwrt,
 				ret_size += hdr_len + size;
 			break;
 		case IWL_FW_INI_REGION_DRAM_BUFFER:
-			if (!fwrt->trans->num_blocks)
+			if (!fwrt->trans->dbg.num_blocks)
 				break;
 			size = iwl_dump_ini_mon_dram_get_size(fwrt, reg);
 			if (size)
@@ -2097,7 +2098,7 @@ int iwl_fw_dbg_collect_desc(struct iwl_fw_runtime *fwrt,
 	u32 trig_type = le32_to_cpu(desc->trig_desc.type);
 	int ret;
 
-	if (fwrt->trans->ini_valid) {
+	if (fwrt->trans->dbg.ini_valid) {
 		ret = iwl_fw_dbg_ini_collect(fwrt, trig_type);
 		if (!ret)
 			iwl_fw_free_dump_desc(fwrt);
@@ -2374,7 +2375,7 @@ static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 	iwl_fw_dbg_stop_recording(fwrt, &params);
 
 	IWL_DEBUG_FW_INFO(fwrt, "WRT: data collection start\n");
-	if (fwrt->trans->ini_valid)
+	if (fwrt->trans->dbg.ini_valid)
 		iwl_fw_error_ini_dump(fwrt, wk_idx);
 	else
 		iwl_fw_error_dump(fwrt);
@@ -2474,7 +2475,8 @@ iwl_fw_dbg_buffer_allocation(struct iwl_fw_runtime *fwrt, u32 size)
 	void *virtual_addr = NULL;
 	dma_addr_t phys_addr;
 
-	if (WARN_ON_ONCE(trans->num_blocks == ARRAY_SIZE(trans->fw_mon)))
+	if (WARN_ON_ONCE(trans->dbg.num_blocks ==
+			 ARRAY_SIZE(trans->dbg.fw_mon)))
 		return;
 
 	virtual_addr =
@@ -2488,12 +2490,12 @@ iwl_fw_dbg_buffer_allocation(struct iwl_fw_runtime *fwrt, u32 size)
 
 	IWL_DEBUG_FW(trans,
 		     "Allocated DRAM buffer[%d], size=0x%x\n",
-		     trans->num_blocks, size);
+		     trans->dbg.num_blocks, size);
 
-	trans->fw_mon[trans->num_blocks].block = virtual_addr;
-	trans->fw_mon[trans->num_blocks].physical = phys_addr;
-	trans->fw_mon[trans->num_blocks].size = size;
-	trans->num_blocks++;
+	trans->dbg.fw_mon[trans->dbg.num_blocks].block = virtual_addr;
+	trans->dbg.fw_mon[trans->dbg.num_blocks].physical = phys_addr;
+	trans->dbg.fw_mon[trans->dbg.num_blocks].size = size;
+	trans->dbg.num_blocks++;
 }
 
 static void iwl_fw_dbg_buffer_apply(struct iwl_fw_runtime *fwrt,
@@ -2511,7 +2513,7 @@ static void iwl_fw_dbg_buffer_apply(struct iwl_fw_runtime *fwrt,
 		.data[0] = &ldbg_cmd,
 		.len[0] = sizeof(ldbg_cmd),
 	};
-	int block_idx = trans->num_blocks;
+	int block_idx = trans->dbg.num_blocks;
 	u32 buf_location = le32_to_cpu(alloc->tlv.buffer_location);
 
 	if (buf_location == IWL_FW_INI_LOCATION_SRAM_PATH) {
@@ -2529,13 +2531,13 @@ static void iwl_fw_dbg_buffer_apply(struct iwl_fw_runtime *fwrt,
 	if (!alloc->is_alloc) {
 		iwl_fw_dbg_buffer_allocation(fwrt,
 					     le32_to_cpu(alloc->tlv.size));
-		if (block_idx == trans->num_blocks)
+		if (block_idx == trans->dbg.num_blocks)
 			return;
 		alloc->is_alloc = 1;
 	}
 
 	/* First block is assigned via registers / context info */
-	if (trans->num_blocks == 1)
+	if (trans->dbg.num_blocks == 1)
 		return;
 
 	IWL_DEBUG_FW(trans,
@@ -2543,7 +2545,7 @@ static void iwl_fw_dbg_buffer_apply(struct iwl_fw_runtime *fwrt,
 
 	cmd->num_frags = cpu_to_le32(1);
 	cmd->fragments[0].address =
-		cpu_to_le64(trans->fw_mon[block_idx].physical);
+		cpu_to_le64(trans->dbg.fw_mon[block_idx].physical);
 	cmd->fragments[0].size = alloc->tlv.size;
 	cmd->allocation_id = alloc->tlv.allocation_id;
 	cmd->buffer_location = alloc->tlv.buffer_location;
@@ -2835,7 +2837,7 @@ static void iwl_fw_dbg_ini_reset_cfg(struct iwl_fw_runtime *fwrt)
 void iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
 			    enum iwl_fw_ini_apply_point apply_point)
 {
-	void *data = &fwrt->trans->apply_points[apply_point];
+	void *data = &fwrt->trans->dbg.apply_points[apply_point];
 
 	IWL_DEBUG_FW(fwrt, "WRT: enabling apply point %d\n", apply_point);
 
@@ -2844,7 +2846,7 @@ void iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
 
 	_iwl_fw_dbg_apply_point(fwrt, data, apply_point, false);
 
-	data = &fwrt->trans->apply_points_ext[apply_point];
+	data = &fwrt->trans->dbg.apply_points_ext[apply_point];
 	_iwl_fw_dbg_apply_point(fwrt, data, apply_point, true);
 }
 IWL_EXPORT_SYMBOL(iwl_fw_dbg_apply_point);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index 54fc59639962..06cdf272e38d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -202,7 +202,7 @@ _iwl_fw_dbg_trigger_on(struct iwl_fw_runtime *fwrt,
 {
 	struct iwl_fw_dbg_trigger_tlv *trig;
 
-	if (fwrt->trans->ini_valid)
+	if (fwrt->trans->dbg.ini_valid)
 		return NULL;
 
 	if (!iwl_fw_dbg_trigger_enabled(fwrt->fw, id))
@@ -229,7 +229,7 @@ iwl_fw_ini_trigger_on(struct iwl_fw_runtime *fwrt,
 	struct iwl_fw_ini_trigger *trig;
 	u32 usec;
 
-	if (!fwrt->trans->ini_valid || id == IWL_FW_TRIGGER_ID_INVALID ||
+	if (!fwrt->trans->dbg.ini_valid || id == IWL_FW_TRIGGER_ID_INVALID ||
 	    id >= IWL_FW_TRIGGER_ID_NUM || !fwrt->dump.active_trigs[id].active)
 		return false;
 
@@ -301,7 +301,7 @@ _iwl_fw_dbg_stop_recording(struct iwl_trans *trans,
 	usleep_range(700, 1000);
 	iwl_write_umac_prph(trans, DBGC_OUT_CTRL, 0);
 #ifdef CONFIG_IWLWIFI_DEBUGFS
-	trans->dbg_rec_on = false;
+	trans->dbg.rec_on = false;
 #endif
 }
 
@@ -336,7 +336,7 @@ _iwl_fw_dbg_restart_recording(struct iwl_trans *trans,
 static inline void iwl_fw_set_dbg_rec_on(struct iwl_fw_runtime *fwrt)
 {
 	if (fwrt->fw->dbg.dest_tlv && fwrt->cur_fw_img == IWL_UCODE_REGULAR)
-		fwrt->trans->dbg_rec_on = true;
+		fwrt->trans->dbg.rec_on = true;
 }
 #endif
 
@@ -452,28 +452,28 @@ void iwl_fwrt_stop_device(struct iwl_fw_runtime *fwrt);
 static inline void iwl_fw_lmac1_set_alive_err_table(struct iwl_trans *trans,
 						    u32 lmac_error_event_table)
 {
-	if (!(trans->error_event_table_tlv_status &
+	if (!(trans->dbg.error_event_table_tlv_status &
 	      IWL_ERROR_EVENT_TABLE_LMAC1) ||
-	    WARN_ON(trans->lmac_error_event_table[0] !=
+	    WARN_ON(trans->dbg.lmac_error_event_table[0] !=
 		    lmac_error_event_table))
-		trans->lmac_error_event_table[0] = lmac_error_event_table;
+		trans->dbg.lmac_error_event_table[0] = lmac_error_event_table;
 }
 
 static inline void iwl_fw_umac_set_alive_err_table(struct iwl_trans *trans,
 						   u32 umac_error_event_table)
 {
-	if (!(trans->error_event_table_tlv_status &
+	if (!(trans->dbg.error_event_table_tlv_status &
 	      IWL_ERROR_EVENT_TABLE_UMAC) ||
-	    WARN_ON(trans->umac_error_event_table !=
+	    WARN_ON(trans->dbg.umac_error_event_table !=
 		    umac_error_event_table))
-		trans->umac_error_event_table = umac_error_event_table;
+		trans->dbg.umac_error_event_table = umac_error_event_table;
 }
 
 static inline void iwl_fw_error_collect(struct iwl_fw_runtime *fwrt)
 {
-	if (fwrt->trans->ini_valid && fwrt->trans->hw_error) {
+	if (fwrt->trans->dbg.ini_valid && fwrt->trans->dbg.hw_error) {
 		_iwl_fw_dbg_ini_collect(fwrt, IWL_FW_TRIGGER_ID_FW_HW_ERROR);
-		fwrt->trans->hw_error = false;
+		fwrt->trans->dbg.hw_error = false;
 	} else {
 		iwl_fw_dbg_collect_desc(fwrt, &iwl_dump_desc_assert, false, 0);
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index fcc1c5c1d013..fcaec410b3be 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -81,9 +81,9 @@ void iwl_fw_dbg_copy_tlv(struct iwl_trans *trans, struct iwl_ucode_tlv *tlv,
 		return;
 
 	if (ext)
-		data = &trans->apply_points_ext[apply_point];
+		data = &trans->dbg.apply_points_ext[apply_point];
 	else
-		data = &trans->apply_points[apply_point];
+		data = &trans->dbg.apply_points[apply_point];
 
 	/* add room for is_alloc field in &iwl_fw_ini_allocation_data struct */
 	if (le32_to_cpu(tlv->type) == IWL_UCODE_TLV_TYPE_BUFFER_ALLOCATION) {
@@ -172,14 +172,14 @@ void iwl_alloc_dbg_tlv(struct iwl_trans *trans, size_t len, const u8 *data,
 		}
 
 		if (ext) {
-			trans->apply_points_ext[i].data = mem;
-			trans->apply_points_ext[i].size = size[i];
+			trans->dbg.apply_points_ext[i].data = mem;
+			trans->dbg.apply_points_ext[i].size = size[i];
 		} else {
-			trans->apply_points[i].data = mem;
-			trans->apply_points[i].size = size[i];
+			trans->dbg.apply_points[i].data = mem;
+			trans->dbg.apply_points[i].size = size[i];
 		}
 
-		trans->ini_valid = true;
+		trans->dbg.ini_valid = true;
 	}
 }
 
@@ -187,14 +187,14 @@ void iwl_fw_dbg_free(struct iwl_trans *trans)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(trans->apply_points); i++) {
-		kfree(trans->apply_points[i].data);
-		trans->apply_points[i].size = 0;
-		trans->apply_points[i].offset = 0;
+	for (i = 0; i < ARRAY_SIZE(trans->dbg.apply_points); i++) {
+		kfree(trans->dbg.apply_points[i].data);
+		trans->dbg.apply_points[i].size = 0;
+		trans->dbg.apply_points[i].offset = 0;
 
-		kfree(trans->apply_points_ext[i].data);
-		trans->apply_points_ext[i].size = 0;
-		trans->apply_points_ext[i].offset = 0;
+		kfree(trans->dbg.apply_points_ext[i].data);
+		trans->dbg.apply_points_ext[i].size = 0;
+		trans->dbg.apply_points_ext[i].offset = 0;
 	}
 }
 
@@ -243,7 +243,7 @@ void iwl_load_fw_dbg_tlv(struct device *dev, struct iwl_trans *trans)
 	const struct firmware *fw;
 	int res;
 
-	if (trans->external_ini_loaded || !iwlwifi_mod_params.enable_ini)
+	if (trans->dbg.external_ini_loaded || !iwlwifi_mod_params.enable_ini)
 		return;
 
 	res = request_firmware(&fw, "iwl-dbg-tlv.ini", dev);
@@ -253,6 +253,6 @@ void iwl_load_fw_dbg_tlv(struct device *dev, struct iwl_trans *trans)
 	iwl_alloc_dbg_tlv(trans, fw->size, fw->data, true);
 	iwl_parse_fw_dbg_tlv(trans, fw->data, fw->size);
 
-	trans->external_ini_loaded = true;
+	trans->dbg.external_ini_loaded = true;
 	release_firmware(fw);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 2c7a3709a19f..63da2c781d12 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1114,10 +1114,10 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 			if (drv->trans->cfg->device_family <
 			    IWL_DEVICE_FAMILY_22000)
 				break;
-			drv->trans->umac_error_event_table =
+			drv->trans->dbg.umac_error_event_table =
 				le32_to_cpu(dbg_ptrs->error_info_addr) &
 				~FW_ADDR_CACHE_CONTROL;
-			drv->trans->error_event_table_tlv_status |=
+			drv->trans->dbg.error_event_table_tlv_status |=
 				IWL_ERROR_EVENT_TABLE_UMAC;
 			break;
 			}
@@ -1130,10 +1130,10 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 			if (drv->trans->cfg->device_family <
 			    IWL_DEVICE_FAMILY_22000)
 				break;
-			drv->trans->lmac_error_event_table[0] =
+			drv->trans->dbg.lmac_error_event_table[0] =
 				le32_to_cpu(dbg_ptrs->error_event_table_ptr) &
 				~FW_ADDR_CACHE_CONTROL;
-			drv->trans->error_event_table_tlv_status |=
+			drv->trans->dbg.error_event_table_tlv_status |=
 				IWL_ERROR_EVENT_TABLE_LMAC1;
 			break;
 			}
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 1e4c9ef548cc..90707c576ce4 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -721,6 +721,48 @@ struct iwl_self_init_dram {
 	int paging_cnt;
 };
 
+/**
+ * struct iwl_trans_debug - transport debug related data
+ *
+ * @n_dest_reg: num of reg_ops in %dbg_dest_tlv
+ * @rec_on: true iff there is a fw debug recording currently active
+ * @dest_tlv: points to the destination TLV for debug
+ * @conf_tlv: array of pointers to configuration TLVs for debug
+ * @trigger_tlv: array of pointers to triggers TLVs for debug
+ * @lmac_error_event_table: addrs of lmacs error tables
+ * @umac_error_event_table: addr of umac error table
+ * @error_event_table_tlv_status: bitmap that indicates what error table
+ *	pointers was recevied via TLV. uses enum &iwl_error_event_table_status
+ * @external_ini_loaded: indicates if an external ini cfg was given
+ * @ini_valid: indicates if debug ini mode is on
+ * @num_blocks: number of blocks in fw_mon
+ * @fw_mon: address of the buffers for firmware monitor
+ * @hw_error: equals true if hw error interrupt was received from the FW
+ */
+struct iwl_trans_debug {
+	u8 n_dest_reg;
+	bool rec_on;
+
+	const struct iwl_fw_dbg_dest_tlv_v1 *dest_tlv;
+	const struct iwl_fw_dbg_conf_tlv *conf_tlv[FW_DBG_CONF_MAX];
+	struct iwl_fw_dbg_trigger_tlv * const *trigger_tlv;
+
+	u32 lmac_error_event_table[2];
+	u32 umac_error_event_table;
+	unsigned int error_event_table_tlv_status;
+
+	bool external_ini_loaded;
+	bool ini_valid;
+
+	struct iwl_apply_point_data apply_points[IWL_FW_INI_APPLY_NUM];
+	struct iwl_apply_point_data apply_points_ext[IWL_FW_INI_APPLY_NUM];
+
+	int num_blocks;
+	struct iwl_dram_data fw_mon[IWL_FW_INI_APPLY_NUM];
+
+	bool hw_error;
+};
+
 /**
  * struct iwl_trans - transport common data
  *
@@ -750,24 +792,12 @@ struct iwl_self_init_dram {
  * @rx_mpdu_cmd_hdr_size: used for tracing, amount of data before the
  *	start of the 802.11 header in the @rx_mpdu_cmd
  * @dflt_pwr_limit: default power limit fetched from the platform (ACPI)
- * @dbg_dest_tlv: points to the destination TLV for debug
- * @dbg_conf_tlv: array of pointers to configuration TLVs for debug
- * @dbg_trigger_tlv: array of pointers to triggers TLVs for debug
- * @dbg_n_dest_reg: num of reg_ops in %dbg_dest_tlv
- * @num_blocks: number of blocks in fw_mon
- * @fw_mon: address of the buffers for firmware monitor
  * @system_pm_mode: the system-wide power management mode in use.
  *	This mode is set dynamically, depending on the WoWLAN values
  *	configured from the userspace at runtime.
  * @runtime_pm_mode: the runtime power management mode in use.  This
  *	mode is set during the initialization phase and is not
  *	supposed to change during runtime.
- * @dbg_rec_on: true iff there is a fw debug recording currently active
- * @lmac_error_event_table: addrs of lmacs error tables
- * @umac_error_event_table: addr of umac error table
- * @error_event_table_tlv_status: bitmap that indicates what error table
- *	pointers was recevied via TLV. use enum &iwl_error_event_table_status
- * @hw_error: equals true if hw error interrupt was received from the FW
  */
 struct iwl_trans {
 	const struct iwl_trans_ops *ops;
@@ -808,29 +838,12 @@ struct iwl_trans {
 	struct lockdep_map sync_cmd_lockdep_map;
 #endif
 
-	struct iwl_apply_point_data apply_points[IWL_FW_INI_APPLY_NUM];
-	struct iwl_apply_point_data apply_points_ext[IWL_FW_INI_APPLY_NUM];
-
-	bool external_ini_loaded;
-	bool ini_valid;
-
-	const struct iwl_fw_dbg_dest_tlv_v1 *dbg_dest_tlv;
-	const struct iwl_fw_dbg_conf_tlv *dbg_conf_tlv[FW_DBG_CONF_MAX];
-	struct iwl_fw_dbg_trigger_tlv * const *dbg_trigger_tlv;
-	u8 dbg_n_dest_reg;
-	int num_blocks;
-	struct iwl_dram_data fw_mon[IWL_FW_INI_APPLY_NUM];
+	struct iwl_trans_debug dbg;
 	struct iwl_self_init_dram init_dram;
 
 	enum iwl_plat_pm_mode system_pm_mode;
 	enum iwl_plat_pm_mode runtime_pm_mode;
 	bool suspending;
-	bool dbg_rec_on;
-
-	u32 lmac_error_event_table[2];
-	u32 umac_error_event_table;
-	unsigned int error_event_table_tlv_status;
-	bool hw_error;
 
 	/* pointer to trans specific struct */
 	/*Ensure that this pointer will always be aligned to sizeof pointer */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 363fd6127bb6..3a5710d32acf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2005,7 +2005,7 @@ static void iwl_mvm_d3_disconnect_iter(void *data, u8 *mac,
 static int iwl_mvm_check_rt_status(struct iwl_mvm *mvm,
 				   struct ieee80211_vif *vif)
 {
-	u32 base = mvm->trans->lmac_error_event_table[0];
+	u32 base = mvm->trans->dbg.lmac_error_event_table[0];
 	struct error_table_start {
 		/* cf. struct iwl_error_event_table */
 		u32 valid;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 41a98cf01d0e..5fc6793d9462 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -238,7 +238,7 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 	iwl_fw_lmac1_set_alive_err_table(mvm->trans, lmac_error_event_table);
 
 	if (lmac2)
-		mvm->trans->lmac_error_event_table[1] =
+		mvm->trans->dbg.lmac_error_event_table[1] =
 			le32_to_cpu(lmac2->dbg_ptrs.error_event_table_ptr);
 
 	umac_error_event_table = le32_to_cpu(umac->dbg_ptrs.error_info_addr);
@@ -1163,7 +1163,7 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	if (ret)
 		IWL_ERR(mvm, "Failed to initialize Smart Fifo\n");
 
-	if (!mvm->trans->ini_valid) {
+	if (!mvm->trans->dbg.ini_valid) {
 		mvm->fwrt.dump.conf = FW_DBG_INVALID;
 		/* if we have a destination, assume EARLY START */
 		if (mvm->fw->dbg.dest_tlv)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 6514e045c901..487fc552a3ce 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -799,11 +799,11 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	iwl_trans_configure(mvm->trans, &trans_cfg);
 
 	trans->rx_mpdu_cmd = REPLY_RX_MPDU_CMD;
-	trans->dbg_dest_tlv = mvm->fw->dbg.dest_tlv;
-	trans->dbg_n_dest_reg = mvm->fw->dbg.n_dest_reg;
-	memcpy(trans->dbg_conf_tlv, mvm->fw->dbg.conf_tlv,
-	       sizeof(trans->dbg_conf_tlv));
-	trans->dbg_trigger_tlv = mvm->fw->dbg.trigger_tlv;
+	trans->dbg.dest_tlv = mvm->fw->dbg.dest_tlv;
+	trans->dbg.n_dest_reg = mvm->fw->dbg.n_dest_reg;
+	memcpy(trans->dbg.conf_tlv, mvm->fw->dbg.conf_tlv,
+	       sizeof(trans->dbg.conf_tlv));
+	trans->dbg.trigger_tlv = mvm->fw->dbg.trigger_tlv;
 
 	trans->iml = mvm->fw->iml;
 	trans->iml_len = mvm->fw->iml_len;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index d2f06a95d75f..aacf1761158e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -469,10 +469,10 @@ static void iwl_mvm_dump_umac_error_log(struct iwl_mvm *mvm)
 {
 	struct iwl_trans *trans = mvm->trans;
 	struct iwl_umac_error_event_table table;
-	u32 base = mvm->trans->umac_error_event_table;
+	u32 base = mvm->trans->dbg.umac_error_event_table;
 
 	if (!mvm->support_umac_log &&
-	    !(mvm->trans->error_event_table_tlv_status &
+	    !(mvm->trans->dbg.error_event_table_tlv_status &
 	      IWL_ERROR_EVENT_TABLE_UMAC))
 		return;
 
@@ -508,7 +508,7 @@ static void iwl_mvm_dump_lmac_error_log(struct iwl_mvm *mvm, u8 lmac_num)
 {
 	struct iwl_trans *trans = mvm->trans;
 	struct iwl_error_event_table table;
-	u32 val, base = mvm->trans->lmac_error_event_table[lmac_num];
+	u32 val, base = mvm->trans->dbg.lmac_error_event_table[lmac_num];
 
 	if (mvm->fwrt.cur_fw_img == IWL_UCODE_INIT) {
 		if (!base)
@@ -604,7 +604,7 @@ void iwl_mvm_dump_nic_error_log(struct iwl_mvm *mvm)
 
 	iwl_mvm_dump_lmac_error_log(mvm, 0);
 
-	if (mvm->trans->lmac_error_event_table[1])
+	if (mvm->trans->dbg.lmac_error_event_table[1])
 		iwl_mvm_dump_lmac_error_log(mvm, 1);
 
 	iwl_mvm_dump_umac_error_log(mvm);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index f496d1bcb643..344c5af73975 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -96,13 +96,13 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 		cpu_to_le64(trans_pcie->rxq->bd_dma);
 
 	/* Configure debug, for integration */
-	if (!trans->ini_valid)
+	if (!trans->dbg.ini_valid)
 		iwl_pcie_alloc_fw_monitor(trans, 0);
-	if (trans->num_blocks) {
+	if (trans->dbg.num_blocks) {
 		prph_sc_ctrl->hwm_cfg.hwm_base_addr =
-			cpu_to_le64(trans->fw_mon[0].physical);
+			cpu_to_le64(trans->dbg.fw_mon[0].physical);
 		prph_sc_ctrl->hwm_cfg.hwm_size =
-			cpu_to_le32(trans->fw_mon[0].size);
+			cpu_to_le32(trans->dbg.fw_mon[0].size);
 	}
 
 	/* allocate ucode sections in dram and set addresses */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index b513037dc066..e66e12b9d9aa 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -1018,7 +1018,7 @@ static inline void __iwl_trans_pcie_set_bit(struct iwl_trans *trans,
 
 static inline bool iwl_pcie_dbg_on(struct iwl_trans *trans)
 {
-	return (trans->dbg_dest_tlv || trans->ini_valid);
+	return (trans->dbg.dest_tlv || trans->dbg.ini_valid);
 }
 
 void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 31b3591f71d1..7e370a92de0e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -2212,7 +2212,7 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 			"Hardware error detected. Restarting.\n");
 
 		isr_stats->hw++;
-		trans->hw_error = true;
+		trans->dbg.hw_error = true;
 		iwl_pcie_irq_handle_error(trans);
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index f6201a03ca35..13ebd948ccc0 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -194,14 +194,14 @@ static void iwl_pcie_free_fw_monitor(struct iwl_trans *trans)
 {
 	int i;
 
-	for (i = 0; i < trans->num_blocks; i++) {
-		dma_free_coherent(trans->dev, trans->fw_mon[i].size,
-				  trans->fw_mon[i].block,
-				  trans->fw_mon[i].physical);
-		trans->fw_mon[i].block = NULL;
-		trans->fw_mon[i].physical = 0;
-		trans->fw_mon[i].size = 0;
-		trans->num_blocks--;
+	for (i = 0; i < trans->dbg.num_blocks; i++) {
+		dma_free_coherent(trans->dev, trans->dbg.fw_mon[i].size,
+				  trans->dbg.fw_mon[i].block,
+				  trans->dbg.fw_mon[i].physical);
+		trans->dbg.fw_mon[i].block = NULL;
+		trans->dbg.fw_mon[i].physical = 0;
+		trans->dbg.fw_mon[i].size = 0;
+		trans->dbg.num_blocks--;
 	}
 }
 
@@ -236,10 +236,10 @@ static void iwl_pcie_alloc_fw_monitor_block(struct iwl_trans *trans,
 			(unsigned long)BIT(power - 10),
 			(unsigned long)BIT(max_power - 10));
 
-	trans->fw_mon[trans->num_blocks].block = cpu_addr;
-	trans->fw_mon[trans->num_blocks].physical = phys;
-	trans->fw_mon[trans->num_blocks].size = size;
-	trans->num_blocks++;
+	trans->dbg.fw_mon[trans->dbg.num_blocks].block = cpu_addr;
+	trans->dbg.fw_mon[trans->dbg.num_blocks].physical = phys;
+	trans->dbg.fw_mon[trans->dbg.num_blocks].size = size;
+	trans->dbg.num_blocks++;
 }
 
 void iwl_pcie_alloc_fw_monitor(struct iwl_trans *trans, u8 max_power)
@@ -260,7 +260,7 @@ void iwl_pcie_alloc_fw_monitor(struct iwl_trans *trans, u8 max_power)
 	 * This function allocats the default fw monitor.
 	 * The optional additional ones will be allocated in runtime
 	 */
-	if (trans->num_blocks)
+	if (trans->dbg.num_blocks)
 		return;
 
 	iwl_pcie_alloc_fw_monitor_block(trans, max_power, 11);
@@ -895,21 +895,21 @@ static int iwl_pcie_load_cpu_sections(struct iwl_trans *trans,
 
 void iwl_pcie_apply_destination(struct iwl_trans *trans)
 {
-	const struct iwl_fw_dbg_dest_tlv_v1 *dest = trans->dbg_dest_tlv;
+	const struct iwl_fw_dbg_dest_tlv_v1 *dest = trans->dbg.dest_tlv;
 	int i;
 
-	if (trans->ini_valid) {
-		if (!trans->num_blocks)
+	if (trans->dbg.ini_valid) {
+		if (!trans->dbg.num_blocks)
 			return;
 
 		IWL_DEBUG_FW(trans,
 			     "WRT: applying DRAM buffer[0] destination\n");
 		iwl_write_umac_prph(trans, MON_BUFF_BASE_ADDR_VER2,
-				    trans->fw_mon[0].physical >>
+				    trans->dbg.fw_mon[0].physical >>
 				    MON_BUFF_SHIFT_VER2);
 		iwl_write_umac_prph(trans, MON_BUFF_END_ADDR_VER2,
-				    (trans->fw_mon[0].physical +
-				     trans->fw_mon[0].size - 256) >>
+				    (trans->dbg.fw_mon[0].physical +
+				     trans->dbg.fw_mon[0].size - 256) >>
 				    MON_BUFF_SHIFT_VER2);
 		return;
 	}
@@ -922,7 +922,7 @@ void iwl_pcie_apply_destination(struct iwl_trans *trans)
 	else
 		IWL_WARN(trans, "PCI should have external buffer debug\n");
 
-	for (i = 0; i < trans->dbg_n_dest_reg; i++) {
+	for (i = 0; i < trans->dbg.n_dest_reg; i++) {
 		u32 addr = le32_to_cpu(dest->reg_ops[i].addr);
 		u32 val = le32_to_cpu(dest->reg_ops[i].val);
 
@@ -961,18 +961,19 @@ void iwl_pcie_apply_destination(struct iwl_trans *trans)
 	}
 
 monitor:
-	if (dest->monitor_mode == EXTERNAL_MODE && trans->fw_mon[0].size) {
+	if (dest->monitor_mode == EXTERNAL_MODE && trans->dbg.fw_mon[0].size) {
 		iwl_write_prph(trans, le32_to_cpu(dest->base_reg),
-			       trans->fw_mon[0].physical >> dest->base_shift);
+			       trans->dbg.fw_mon[0].physical >>
+			       dest->base_shift);
 		if (trans->cfg->device_family >= IWL_DEVICE_FAMILY_8000)
 			iwl_write_prph(trans, le32_to_cpu(dest->end_reg),
-				       (trans->fw_mon[0].physical +
-					trans->fw_mon[0].size - 256) >>
+				       (trans->dbg.fw_mon[0].physical +
+					trans->dbg.fw_mon[0].size - 256) >>
 						dest->end_shift);
 		else
 			iwl_write_prph(trans, le32_to_cpu(dest->end_reg),
-				       (trans->fw_mon[0].physical +
-					trans->fw_mon[0].size) >>
+				       (trans->dbg.fw_mon[0].physical +
+					trans->dbg.fw_mon[0].size) >>
 						dest->end_shift);
 	}
 }
@@ -1009,12 +1010,12 @@ static int iwl_pcie_load_given_ucode(struct iwl_trans *trans,
 	    trans->cfg->device_family == IWL_DEVICE_FAMILY_7000) {
 		iwl_pcie_alloc_fw_monitor(trans, 0);
 
-		if (trans->fw_mon[0].size) {
+		if (trans->dbg.fw_mon[0].size) {
 			iwl_write_prph(trans, MON_BUFF_BASE_ADDR,
-				       trans->fw_mon[0].physical >> 4);
+				       trans->dbg.fw_mon[0].physical >> 4);
 			iwl_write_prph(trans, MON_BUFF_END_ADDR,
-				       (trans->fw_mon[0].physical +
-					trans->fw_mon[0].size) >> 4);
+				       (trans->dbg.fw_mon[0].physical +
+					trans->dbg.fw_mon[0].size) >> 4);
 		}
 	} else if (iwl_pcie_dbg_on(trans)) {
 		iwl_pcie_apply_destination(trans);
@@ -2715,8 +2716,8 @@ static int iwl_dbgfs_monitor_data_open(struct inode *inode,
 	struct iwl_trans *trans = inode->i_private;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
-	if (!trans->dbg_dest_tlv ||
-	    trans->dbg_dest_tlv->monitor_mode != EXTERNAL_MODE) {
+	if (!trans->dbg.dest_tlv ||
+	    trans->dbg.dest_tlv->monitor_mode != EXTERNAL_MODE) {
 		IWL_ERR(trans, "Debug destination is not set to DRAM\n");
 		return -ENOENT;
 	}
@@ -2763,22 +2764,22 @@ static ssize_t iwl_dbgfs_monitor_data_read(struct file *file,
 {
 	struct iwl_trans *trans = file->private_data;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	void *cpu_addr = (void *)trans->fw_mon[0].block, *curr_buf;
+	void *cpu_addr = (void *)trans->dbg.fw_mon[0].block, *curr_buf;
 	struct cont_rec *data = &trans_pcie->fw_mon_data;
 	u32 write_ptr_addr, wrap_cnt_addr, write_ptr, wrap_cnt;
 	ssize_t size, bytes_copied = 0;
 	bool b_full;
 
-	if (trans->dbg_dest_tlv) {
+	if (trans->dbg.dest_tlv) {
 		write_ptr_addr =
-			le32_to_cpu(trans->dbg_dest_tlv->write_ptr_reg);
-		wrap_cnt_addr = le32_to_cpu(trans->dbg_dest_tlv->wrap_count);
+			le32_to_cpu(trans->dbg.dest_tlv->write_ptr_reg);
+		wrap_cnt_addr = le32_to_cpu(trans->dbg.dest_tlv->wrap_count);
 	} else {
 		write_ptr_addr = MON_BUFF_WRPTR;
 		wrap_cnt_addr = MON_BUFF_CYCLE_CNT;
 	}
 
-	if (unlikely(!trans->dbg_rec_on))
+	if (unlikely(!trans->dbg.rec_on))
 		return 0;
 
 	mutex_lock(&data->mutex);
@@ -2802,7 +2803,7 @@ static ssize_t iwl_dbgfs_monitor_data_read(struct file *file,
 
 	} else if (data->prev_wrap_cnt == wrap_cnt - 1 &&
 		   write_ptr < data->prev_wr_ptr) {
-		size = trans->fw_mon[0].size - data->prev_wr_ptr;
+		size = trans->dbg.fw_mon[0].size - data->prev_wr_ptr;
 		curr_buf = cpu_addr + data->prev_wr_ptr;
 		b_full = iwl_write_to_user_buf(user_buf, count,
 					       curr_buf, &size,
@@ -3021,10 +3022,10 @@ iwl_trans_pcie_dump_pointers(struct iwl_trans *trans,
 		base_high = DBGC_CUR_DBGBUF_BASE_ADDR_MSB;
 		write_ptr = DBGC_CUR_DBGBUF_STATUS;
 		wrap_cnt = DBGC_DBGBUF_WRAP_AROUND;
-	} else if (trans->dbg_dest_tlv) {
-		write_ptr = le32_to_cpu(trans->dbg_dest_tlv->write_ptr_reg);
-		wrap_cnt = le32_to_cpu(trans->dbg_dest_tlv->wrap_count);
-		base = le32_to_cpu(trans->dbg_dest_tlv->base_reg);
+	} else if (trans->dbg.dest_tlv) {
+		write_ptr = le32_to_cpu(trans->dbg.dest_tlv->write_ptr_reg);
+		wrap_cnt = le32_to_cpu(trans->dbg.dest_tlv->wrap_count);
+		base = le32_to_cpu(trans->dbg.dest_tlv->base_reg);
 	} else {
 		base = MON_BUFF_BASE_ADDR;
 		write_ptr = MON_BUFF_WRPTR;
@@ -3051,8 +3052,8 @@ iwl_trans_pcie_dump_monitor(struct iwl_trans *trans,
 {
 	u32 len = 0;
 
-	if (trans->dbg_dest_tlv ||
-	    (trans->num_blocks &&
+	if (trans->dbg.dest_tlv ||
+	    (trans->dbg.num_blocks &&
 	     (trans->cfg->device_family == IWL_DEVICE_FAMILY_7000 ||
 	      trans->cfg->device_family >= IWL_DEVICE_FAMILY_AX210))) {
 		struct iwl_fw_error_dump_fw_mon *fw_mon_data;
@@ -3063,32 +3064,32 @@ iwl_trans_pcie_dump_monitor(struct iwl_trans *trans,
 		iwl_trans_pcie_dump_pointers(trans, fw_mon_data);
 
 		len += sizeof(**data) + sizeof(*fw_mon_data);
-		if (trans->num_blocks) {
+		if (trans->dbg.num_blocks) {
 			memcpy(fw_mon_data->data,
-			       trans->fw_mon[0].block,
-			       trans->fw_mon[0].size);
+			       trans->dbg.fw_mon[0].block,
+			       trans->dbg.fw_mon[0].size);
 
-			monitor_len = trans->fw_mon[0].size;
-		} else if (trans->dbg_dest_tlv->monitor_mode == SMEM_MODE) {
+			monitor_len = trans->dbg.fw_mon[0].size;
+		} else if (trans->dbg.dest_tlv->monitor_mode == SMEM_MODE) {
 			u32 base = le32_to_cpu(fw_mon_data->fw_mon_base_ptr);
 			/*
 			 * Update pointers to reflect actual values after
 			 * shifting
 			 */
-			if (trans->dbg_dest_tlv->version) {
+			if (trans->dbg.dest_tlv->version) {
 				base = (iwl_read_prph(trans, base) &
 					IWL_LDBG_M2S_BUF_BA_MSK) <<
-				       trans->dbg_dest_tlv->base_shift;
+				       trans->dbg.dest_tlv->base_shift;
 				base *= IWL_M2S_UNIT_SIZE;
 				base += trans->cfg->smem_offset;
 			} else {
 				base = iwl_read_prph(trans, base) <<
-				       trans->dbg_dest_tlv->base_shift;
+				       trans->dbg.dest_tlv->base_shift;
 			}
 
 			iwl_trans_read_mem(trans, base, fw_mon_data->data,
 					   monitor_len / sizeof(u32));
-		} else if (trans->dbg_dest_tlv->monitor_mode == MARBH_MODE) {
+		} else if (trans->dbg.dest_tlv->monitor_mode == MARBH_MODE) {
 			monitor_len =
 				iwl_trans_pci_dump_marbh_monitor(trans,
 								 fw_mon_data,
@@ -3107,40 +3108,40 @@ iwl_trans_pcie_dump_monitor(struct iwl_trans *trans,
 
 static int iwl_trans_get_fw_monitor_len(struct iwl_trans *trans, u32 *len)
 {
-	if (trans->num_blocks) {
+	if (trans->dbg.num_blocks) {
 		*len += sizeof(struct iwl_fw_error_dump_data) +
 			sizeof(struct iwl_fw_error_dump_fw_mon) +
-			trans->fw_mon[0].size;
-		return trans->fw_mon[0].size;
-	} else if (trans->dbg_dest_tlv) {
+			trans->dbg.fw_mon[0].size;
+		return trans->dbg.fw_mon[0].size;
+	} else if (trans->dbg.dest_tlv) {
 		u32 base, end, cfg_reg, monitor_len;
 
-		if (trans->dbg_dest_tlv->version == 1) {
-			cfg_reg = le32_to_cpu(trans->dbg_dest_tlv->base_reg);
+		if (trans->dbg.dest_tlv->version == 1) {
+			cfg_reg = le32_to_cpu(trans->dbg.dest_tlv->base_reg);
 			cfg_reg = iwl_read_prph(trans, cfg_reg);
 			base = (cfg_reg & IWL_LDBG_M2S_BUF_BA_MSK) <<
-				trans->dbg_dest_tlv->base_shift;
+				trans->dbg.dest_tlv->base_shift;
 			base *= IWL_M2S_UNIT_SIZE;
 			base += trans->cfg->smem_offset;
 
 			monitor_len =
 				(cfg_reg & IWL_LDBG_M2S_BUF_SIZE_MSK) >>
-				trans->dbg_dest_tlv->end_shift;
+				trans->dbg.dest_tlv->end_shift;
 			monitor_len *= IWL_M2S_UNIT_SIZE;
 		} else {
-			base = le32_to_cpu(trans->dbg_dest_tlv->base_reg);
-			end = le32_to_cpu(trans->dbg_dest_tlv->end_reg);
+			base = le32_to_cpu(trans->dbg.dest_tlv->base_reg);
+			end = le32_to_cpu(trans->dbg.dest_tlv->end_reg);
 
 			base = iwl_read_prph(trans, base) <<
-			       trans->dbg_dest_tlv->base_shift;
+			       trans->dbg.dest_tlv->base_shift;
 			end = iwl_read_prph(trans, end) <<
-			      trans->dbg_dest_tlv->end_shift;
+			      trans->dbg.dest_tlv->end_shift;
 
 			/* Make "end" point to the actual end */
 			if (trans->cfg->device_family >=
 			    IWL_DEVICE_FAMILY_8000 ||
-			    trans->dbg_dest_tlv->monitor_mode == MARBH_MODE)
-				end += (1 << trans->dbg_dest_tlv->end_shift);
+			    trans->dbg.dest_tlv->monitor_mode == MARBH_MODE)
+				end += (1 << trans->dbg.dest_tlv->end_shift);
 			monitor_len = end - base;
 		}
 		*len += sizeof(struct iwl_fw_error_dump_data) +
-- 
2.20.1

