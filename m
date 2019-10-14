Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6E5AD5C33
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2019 09:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbfJNHUd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Oct 2019 03:20:33 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:49172 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730298AbfJNHUc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Oct 2019 03:20:32 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iJueb-0007ae-Jz; Mon, 14 Oct 2019 10:20:30 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 14 Oct 2019 10:20:07 +0300
Message-Id: <20191014101813.844bd08fc675.I1ba9e6b034e188ce762651a088be5b7cab53aa12@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191014072019.1254-1-luca@coelho.fi>
References: <20191014072019.1254-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 04/16] iwlwifi: dbg: remove multi buffers infra
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Legacy DRAM monitor does not support multi buffers.
Remove this infra.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   6 +-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |  13 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 112 ++++++++----------
 3 files changed, 56 insertions(+), 75 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index b1fb17515398..640530371194 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -706,8 +706,7 @@ struct iwl_self_init_dram {
  *	pointers was recevied via TLV. uses enum &iwl_error_event_table_status
  * @internal_ini_cfg: internal debug cfg state. Uses &enum iwl_ini_cfg_state
  * @external_ini_cfg: external debug cfg state. Uses &enum iwl_ini_cfg_state
- * @num_blocks: number of blocks in fw_mon
- * @fw_mon: address of the buffers for firmware monitor
+ * @fw_mon: DRAM buffer for firmware monitor
  * @hw_error: equals true if hw error interrupt was received from the FW
  * @ini_dest: debug monitor destination uses &enum iwl_fw_ini_buffer_location
  * @active_regions: active regions
@@ -727,8 +726,7 @@ struct iwl_trans_debug {
 	enum iwl_ini_cfg_state internal_ini_cfg;
 	enum iwl_ini_cfg_state external_ini_cfg;
 
-	int num_blocks;
-	struct iwl_dram_data fw_mon[IWL_FW_INI_ALLOCATION_NUM];
+	struct iwl_dram_data fw_mon;
 
 	bool hw_error;
 	enum iwl_fw_ini_buffer_location ini_dest;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index 75fa8a6aafee..2c8ce41718a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -96,13 +96,14 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 		cpu_to_le64(trans_pcie->rxq->bd_dma);
 
 	/* Configure debug, for integration */
-	if (!iwl_trans_dbg_ini_valid(trans))
+	if (iwl_trans_dbg_ini_valid(trans)) {
 		iwl_pcie_alloc_fw_monitor(trans, 0);
-	if (trans->dbg.num_blocks) {
-		prph_sc_ctrl->hwm_cfg.hwm_base_addr =
-			cpu_to_le64(trans->dbg.fw_mon[0].physical);
-		prph_sc_ctrl->hwm_cfg.hwm_size =
-			cpu_to_le32(trans->dbg.fw_mon[0].size);
+		if (trans->dbg.fw_mon.size) {
+			prph_sc_ctrl->hwm_cfg.hwm_base_addr =
+				cpu_to_le64(trans->dbg.fw_mon.physical);
+			prph_sc_ctrl->hwm_cfg.hwm_size =
+				cpu_to_le32(trans->dbg.fw_mon.size);
+		}
 	}
 
 	/* allocate ucode sections in dram and set addresses */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index f8a1f985a1d8..464dc709c710 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -190,32 +190,36 @@ static void iwl_trans_pcie_sw_reset(struct iwl_trans *trans)
 
 static void iwl_pcie_free_fw_monitor(struct iwl_trans *trans)
 {
-	int i;
+	struct iwl_dram_data *fw_mon = &trans->dbg.fw_mon;
 
-	for (i = 0; i < trans->dbg.num_blocks; i++) {
-		dma_free_coherent(trans->dev, trans->dbg.fw_mon[i].size,
-				  trans->dbg.fw_mon[i].block,
-				  trans->dbg.fw_mon[i].physical);
-		trans->dbg.fw_mon[i].block = NULL;
-		trans->dbg.fw_mon[i].physical = 0;
-		trans->dbg.fw_mon[i].size = 0;
-		trans->dbg.num_blocks--;
-	}
+	if (!fw_mon->size)
+		return;
+
+	dma_free_coherent(trans->dev, fw_mon->size, fw_mon->block,
+			  fw_mon->physical);
+
+	fw_mon->block = NULL;
+	fw_mon->physical = 0;
+	fw_mon->size = 0;
 }
 
 static void iwl_pcie_alloc_fw_monitor_block(struct iwl_trans *trans,
 					    u8 max_power, u8 min_power)
 {
-	void *cpu_addr = NULL;
-	dma_addr_t phys = 0;
+	struct iwl_dram_data *fw_mon = &trans->dbg.fw_mon;
+	void *block = NULL;
+	dma_addr_t physical = 0;
 	u32 size = 0;
 	u8 power;
 
+	if (fw_mon->size)
+		return;
+
 	for (power = max_power; power >= min_power; power--) {
 		size = BIT(power);
-		cpu_addr = dma_alloc_coherent(trans->dev, size, &phys,
-					      GFP_KERNEL | __GFP_NOWARN);
-		if (!cpu_addr)
+		block = dma_alloc_coherent(trans->dev, size, &physical,
+					   GFP_KERNEL | __GFP_NOWARN);
+		if (!block)
 			continue;
 
 		IWL_INFO(trans,
@@ -224,7 +228,7 @@ static void iwl_pcie_alloc_fw_monitor_block(struct iwl_trans *trans,
 		break;
 	}
 
-	if (WARN_ON_ONCE(!cpu_addr))
+	if (WARN_ON_ONCE(!block))
 		return;
 
 	if (power != max_power)
@@ -233,10 +237,9 @@ static void iwl_pcie_alloc_fw_monitor_block(struct iwl_trans *trans,
 			(unsigned long)BIT(power - 10),
 			(unsigned long)BIT(max_power - 10));
 
-	trans->dbg.fw_mon[trans->dbg.num_blocks].block = cpu_addr;
-	trans->dbg.fw_mon[trans->dbg.num_blocks].physical = phys;
-	trans->dbg.fw_mon[trans->dbg.num_blocks].size = size;
-	trans->dbg.num_blocks++;
+	fw_mon->block = block;
+	fw_mon->physical = physical;
+	fw_mon->size = size;
 }
 
 void iwl_pcie_alloc_fw_monitor(struct iwl_trans *trans, u8 max_power)
@@ -253,11 +256,7 @@ void iwl_pcie_alloc_fw_monitor(struct iwl_trans *trans, u8 max_power)
 		 max_power))
 		return;
 
-	/*
-	 * This function allocats the default fw monitor.
-	 * The optional additional ones will be allocated in runtime
-	 */
-	if (trans->dbg.num_blocks)
+	if (trans->dbg.fw_mon.size)
 		return;
 
 	iwl_pcie_alloc_fw_monitor_block(trans, max_power, 11);
@@ -894,23 +893,11 @@ static int iwl_pcie_load_cpu_sections(struct iwl_trans *trans,
 void iwl_pcie_apply_destination(struct iwl_trans *trans)
 {
 	const struct iwl_fw_dbg_dest_tlv_v1 *dest = trans->dbg.dest_tlv;
+	const struct iwl_dram_data *fw_mon = &trans->dbg.fw_mon;
 	int i;
 
-	if (iwl_trans_dbg_ini_valid(trans)) {
-		if (!trans->dbg.num_blocks)
-			return;
-
-		IWL_DEBUG_FW(trans,
-			     "WRT: Applying DRAM buffer[0] destination\n");
-		iwl_write_umac_prph(trans, MON_BUFF_BASE_ADDR_VER2,
-				    trans->dbg.fw_mon[0].physical >>
-				    MON_BUFF_SHIFT_VER2);
-		iwl_write_umac_prph(trans, MON_BUFF_END_ADDR_VER2,
-				    (trans->dbg.fw_mon[0].physical +
-				     trans->dbg.fw_mon[0].size - 256) >>
-				    MON_BUFF_SHIFT_VER2);
+	if (iwl_trans_dbg_ini_valid(trans))
 		return;
-	}
 
 	IWL_INFO(trans, "Applying debug destination %s\n",
 		 get_fw_dbg_mode_string(dest->monitor_mode));
@@ -959,20 +946,17 @@ void iwl_pcie_apply_destination(struct iwl_trans *trans)
 	}
 
 monitor:
-	if (dest->monitor_mode == EXTERNAL_MODE && trans->dbg.fw_mon[0].size) {
+	if (dest->monitor_mode == EXTERNAL_MODE && fw_mon->size) {
 		iwl_write_prph(trans, le32_to_cpu(dest->base_reg),
-			       trans->dbg.fw_mon[0].physical >>
-			       dest->base_shift);
+			       fw_mon->physical >> dest->base_shift);
 		if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_8000)
 			iwl_write_prph(trans, le32_to_cpu(dest->end_reg),
-				       (trans->dbg.fw_mon[0].physical +
-					trans->dbg.fw_mon[0].size - 256) >>
-						dest->end_shift);
+				       (fw_mon->physical + fw_mon->size -
+					256) >> dest->end_shift);
 		else
 			iwl_write_prph(trans, le32_to_cpu(dest->end_reg),
-				       (trans->dbg.fw_mon[0].physical +
-					trans->dbg.fw_mon[0].size) >>
-						dest->end_shift);
+				       (fw_mon->physical + fw_mon->size) >>
+				       dest->end_shift);
 	}
 }
 
@@ -1006,14 +990,14 @@ static int iwl_pcie_load_given_ucode(struct iwl_trans *trans,
 	/* supported for 7000 only for the moment */
 	if (iwlwifi_mod_params.fw_monitor &&
 	    trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_7000) {
-		iwl_pcie_alloc_fw_monitor(trans, 0);
+		struct iwl_dram_data *fw_mon = &trans->dbg.fw_mon;
 
-		if (trans->dbg.fw_mon[0].size) {
+		iwl_pcie_alloc_fw_monitor(trans, 0);
+		if (fw_mon->size) {
 			iwl_write_prph(trans, MON_BUFF_BASE_ADDR,
-				       trans->dbg.fw_mon[0].physical >> 4);
+				       fw_mon->physical >> 4);
 			iwl_write_prph(trans, MON_BUFF_END_ADDR,
-				       (trans->dbg.fw_mon[0].physical +
-					trans->dbg.fw_mon[0].size) >> 4);
+				       (fw_mon->physical + fw_mon->size) >> 4);
 		}
 	} else if (iwl_pcie_dbg_on(trans)) {
 		iwl_pcie_apply_destination(trans);
@@ -2801,7 +2785,7 @@ static ssize_t iwl_dbgfs_monitor_data_read(struct file *file,
 {
 	struct iwl_trans *trans = file->private_data;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	void *cpu_addr = (void *)trans->dbg.fw_mon[0].block, *curr_buf;
+	void *cpu_addr = (void *)trans->dbg.fw_mon.block, *curr_buf;
 	struct cont_rec *data = &trans_pcie->fw_mon_data;
 	u32 write_ptr_addr, wrap_cnt_addr, write_ptr, wrap_cnt;
 	ssize_t size, bytes_copied = 0;
@@ -2840,7 +2824,7 @@ static ssize_t iwl_dbgfs_monitor_data_read(struct file *file,
 
 	} else if (data->prev_wrap_cnt == wrap_cnt - 1 &&
 		   write_ptr < data->prev_wr_ptr) {
-		size = trans->dbg.fw_mon[0].size - data->prev_wr_ptr;
+		size = trans->dbg.fw_mon.size - data->prev_wr_ptr;
 		curr_buf = cpu_addr + data->prev_wr_ptr;
 		b_full = iwl_write_to_user_buf(user_buf, count,
 					       curr_buf, &size,
@@ -3087,10 +3071,11 @@ iwl_trans_pcie_dump_monitor(struct iwl_trans *trans,
 			    struct iwl_fw_error_dump_data **data,
 			    u32 monitor_len)
 {
+	struct iwl_dram_data *fw_mon = &trans->dbg.fw_mon;
 	u32 len = 0;
 
 	if (trans->dbg.dest_tlv ||
-	    (trans->dbg.num_blocks &&
+	    (fw_mon->size &&
 	     (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_7000 ||
 	      trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210))) {
 		struct iwl_fw_error_dump_fw_mon *fw_mon_data;
@@ -3101,12 +3086,9 @@ iwl_trans_pcie_dump_monitor(struct iwl_trans *trans,
 		iwl_trans_pcie_dump_pointers(trans, fw_mon_data);
 
 		len += sizeof(**data) + sizeof(*fw_mon_data);
-		if (trans->dbg.num_blocks) {
-			memcpy(fw_mon_data->data,
-			       trans->dbg.fw_mon[0].block,
-			       trans->dbg.fw_mon[0].size);
-
-			monitor_len = trans->dbg.fw_mon[0].size;
+		if (fw_mon->size) {
+			memcpy(fw_mon_data->data, fw_mon->block, fw_mon->size);
+			monitor_len = fw_mon->size;
 		} else if (trans->dbg.dest_tlv->monitor_mode == SMEM_MODE) {
 			u32 base = le32_to_cpu(fw_mon_data->fw_mon_base_ptr);
 			/*
@@ -3145,11 +3127,11 @@ iwl_trans_pcie_dump_monitor(struct iwl_trans *trans,
 
 static int iwl_trans_get_fw_monitor_len(struct iwl_trans *trans, u32 *len)
 {
-	if (trans->dbg.num_blocks) {
+	if (trans->dbg.fw_mon.size) {
 		*len += sizeof(struct iwl_fw_error_dump_data) +
 			sizeof(struct iwl_fw_error_dump_fw_mon) +
-			trans->dbg.fw_mon[0].size;
-		return trans->dbg.fw_mon[0].size;
+			trans->dbg.fw_mon.size;
+		return trans->dbg.fw_mon.size;
 	} else if (trans->dbg.dest_tlv) {
 		u32 base, end, cfg_reg, monitor_len;
 
-- 
2.23.0

