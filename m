Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBBA6A43D2
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2019 11:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfHaJxH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Aug 2019 05:53:07 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:39772 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726968AbfHaJxH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Aug 2019 05:53:07 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i400R-0002OQ-NW; Sat, 31 Aug 2019 12:49:16 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 31 Aug 2019 12:48:55 +0300
Message-Id: <20190831094859.6391-16-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190831094859.6391-1-luca@coelho.fi>
References: <20190831094859.6391-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 15/19] iwlwifi: dbg_ini: separate cfg and dump flows to different modules
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

separate configuration flows and dump collection flows.
make ini configuration flows be in iwl-dbg-tlv.c and dump related flows
in dbg.c to better reflect their logical difference.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 429 ------------------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |   3 -
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |   1 -
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 429 ++++++++++++++++++
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  |   4 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   8 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |   2 +-
 9 files changed, 440 insertions(+), 440 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 2a4c2e772d1b..3320acc8a52f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2438,435 +2438,6 @@ void iwl_fw_dbg_read_d3_debug_data(struct iwl_fw_runtime *fwrt)
 }
 IWL_EXPORT_SYMBOL(iwl_fw_dbg_read_d3_debug_data);
 
-static void iwl_fw_dbg_info_apply(struct iwl_fw_runtime *fwrt,
-				  struct iwl_fw_ini_debug_info_tlv *dbg_info,
-				  bool ext, enum iwl_fw_ini_apply_point pnt)
-{
-	u32 img_name_len = le32_to_cpu(dbg_info->img_name_len);
-	u32 dbg_cfg_name_len = le32_to_cpu(dbg_info->dbg_cfg_name_len);
-
-	if (img_name_len != IWL_FW_INI_MAX_IMG_NAME_LEN) {
-		IWL_WARN(fwrt,
-			 "WRT: ext=%d. Invalid image name length %d, expected %d\n",
-			 ext, img_name_len,
-			 IWL_FW_INI_MAX_IMG_NAME_LEN);
-		return;
-	}
-
-	if (dbg_cfg_name_len != IWL_FW_INI_MAX_DBG_CFG_NAME_LEN) {
-		IWL_WARN(fwrt,
-			 "WRT: ext=%d. Invalid debug cfg name length %d, expected %d\n",
-			 ext, dbg_cfg_name_len,
-			 IWL_FW_INI_MAX_DBG_CFG_NAME_LEN);
-		return;
-	}
-
-	if (ext) {
-		memcpy(fwrt->dump.external_dbg_cfg_name, dbg_info->dbg_cfg_name,
-		       sizeof(fwrt->dump.external_dbg_cfg_name));
-	} else {
-		memcpy(fwrt->dump.img_name, dbg_info->img_name,
-		       sizeof(fwrt->dump.img_name));
-		memcpy(fwrt->dump.internal_dbg_cfg_name, dbg_info->dbg_cfg_name,
-		       sizeof(fwrt->dump.internal_dbg_cfg_name));
-	}
-}
-
-static void
-iwl_fw_dbg_buffer_allocation(struct iwl_fw_runtime *fwrt, u32 size)
-{
-	struct iwl_trans *trans = fwrt->trans;
-	void *virtual_addr = NULL;
-	dma_addr_t phys_addr;
-
-	if (WARN_ON_ONCE(trans->dbg.num_blocks ==
-			 ARRAY_SIZE(trans->dbg.fw_mon)))
-		return;
-
-	virtual_addr =
-		dma_alloc_coherent(fwrt->trans->dev, size, &phys_addr,
-				   GFP_KERNEL | __GFP_NOWARN);
-
-	/* TODO: alloc fragments if needed */
-	if (!virtual_addr)
-		IWL_ERR(fwrt, "Failed to allocate debug memory\n");
-
-	IWL_DEBUG_FW(trans,
-		     "Allocated DRAM buffer[%d], size=0x%x\n",
-		     trans->dbg.num_blocks, size);
-
-	trans->dbg.fw_mon[trans->dbg.num_blocks].block = virtual_addr;
-	trans->dbg.fw_mon[trans->dbg.num_blocks].physical = phys_addr;
-	trans->dbg.fw_mon[trans->dbg.num_blocks].size = size;
-	trans->dbg.num_blocks++;
-}
-
-static void iwl_fw_dbg_buffer_apply(struct iwl_fw_runtime *fwrt,
-				    struct iwl_fw_ini_allocation_tlv *alloc,
-				    enum iwl_fw_ini_apply_point pnt)
-{
-	struct iwl_trans *trans = fwrt->trans;
-	struct iwl_ldbg_config_cmd ldbg_cmd = {
-		.type = cpu_to_le32(BUFFER_ALLOCATION),
-	};
-	struct iwl_buffer_allocation_cmd *cmd = &ldbg_cmd.buffer_allocation;
-	struct iwl_host_cmd hcmd = {
-		.id = LDBG_CONFIG_CMD,
-		.flags = CMD_ASYNC,
-		.data[0] = &ldbg_cmd,
-		.len[0] = sizeof(ldbg_cmd),
-	};
-	int block_idx = trans->dbg.num_blocks;
-	u32 buf_location = le32_to_cpu(alloc->buffer_location);
-	u32 alloc_id = le32_to_cpu(alloc->allocation_id);
-
-	if (alloc_id <= IWL_FW_INI_ALLOCATION_INVALID ||
-	    alloc_id >= IWL_FW_INI_ALLOCATION_NUM) {
-		IWL_ERR(fwrt, "WRT: Invalid allocation id %d\n", alloc_id);
-		return;
-	}
-
-	if (fwrt->trans->dbg.ini_dest == IWL_FW_INI_LOCATION_INVALID)
-		fwrt->trans->dbg.ini_dest = buf_location;
-
-	if (buf_location != fwrt->trans->dbg.ini_dest) {
-		WARN(fwrt,
-		     "WRT: attempt to override buffer location on apply point %d\n",
-		     pnt);
-
-		return;
-	}
-
-	if (buf_location == IWL_FW_INI_LOCATION_SRAM_PATH) {
-		IWL_DEBUG_FW(trans, "WRT: Applying SMEM buffer destination\n");
-		/* set sram monitor by enabling bit 7 */
-		iwl_set_bit(fwrt->trans, CSR_HW_IF_CONFIG_REG,
-			    CSR_HW_IF_CONFIG_REG_BIT_MONITOR_SRAM);
-
-		return;
-	}
-
-	if (buf_location != IWL_FW_INI_LOCATION_DRAM_PATH)
-		return;
-
-	if (!(BIT(alloc_id) & fwrt->trans->dbg.is_alloc)) {
-		iwl_fw_dbg_buffer_allocation(fwrt, le32_to_cpu(alloc->size));
-		if (block_idx == trans->dbg.num_blocks)
-			return;
-		fwrt->trans->dbg.is_alloc |= BIT(alloc_id);
-	}
-
-	/* First block is assigned via registers / context info */
-	if (trans->dbg.num_blocks == 1)
-		return;
-
-	IWL_DEBUG_FW(trans,
-		     "WRT: Applying DRAM buffer[%d] destination\n", block_idx);
-
-	cmd->num_frags = cpu_to_le32(1);
-	cmd->fragments[0].address =
-		cpu_to_le64(trans->dbg.fw_mon[block_idx].physical);
-	cmd->fragments[0].size = alloc->size;
-	cmd->allocation_id = alloc->allocation_id;
-	cmd->buffer_location = alloc->buffer_location;
-
-	iwl_trans_send_cmd(trans, &hcmd);
-}
-
-static void iwl_fw_dbg_send_hcmd(struct iwl_fw_runtime *fwrt,
-				 struct iwl_ucode_tlv *tlv)
-{
-	struct iwl_fw_ini_hcmd_tlv *hcmd_tlv = (void *)&tlv->data[0];
-	struct iwl_fw_ini_hcmd *data = &hcmd_tlv->hcmd;
-	u16 len = le32_to_cpu(tlv->length) - sizeof(*hcmd_tlv);
-
-	struct iwl_host_cmd hcmd = {
-		.id = WIDE_ID(data->group, data->id),
-		.len = { len, },
-		.data = { data->data, },
-	};
-
-	/* currently the driver supports always on domain only */
-	if (le32_to_cpu(hcmd_tlv->domain) != IWL_FW_INI_DBG_DOMAIN_ALWAYS_ON)
-		return;
-
-	IWL_DEBUG_FW(fwrt, "WRT: Sending host command id=0x%x, group=0x%x\n",
-		     data->id, data->group);
-
-	iwl_trans_send_cmd(fwrt->trans, &hcmd);
-}
-
-static void iwl_fw_dbg_update_regions(struct iwl_fw_runtime *fwrt,
-				      struct iwl_fw_ini_region_tlv *tlv,
-				      enum iwl_fw_ini_apply_point pnt)
-{
-	void *iter = (void *)tlv->region_config;
-	int i, size = le32_to_cpu(tlv->num_regions);
-	const char *err_st =
-		"WRT: Invalid region %s %d for apply point %d\n";
-
-	for (i = 0; i < size; i++) {
-		struct iwl_fw_ini_region_cfg *reg = iter, **active;
-		int id = le32_to_cpu(reg->region_id);
-		u32 type = le32_to_cpu(reg->region_type);
-
-		if (WARN(id >= ARRAY_SIZE(fwrt->dump.active_regs), err_st, "id",
-			 id, pnt))
-			break;
-
-		if (WARN(type == 0 || type >= IWL_FW_INI_REGION_NUM, err_st,
-			 "type", type, pnt))
-			break;
-
-		active = &fwrt->dump.active_regs[id];
-
-		if (*active)
-			IWL_WARN(fwrt->trans, "WRT: Region id %d override\n",
-				 id);
-
-		IWL_DEBUG_FW(fwrt, "WRT: Activating region id %d\n", id);
-
-		*active = reg;
-
-		if (type == IWL_FW_INI_REGION_TXF ||
-		    type == IWL_FW_INI_REGION_RXF)
-			iter += le32_to_cpu(reg->fifos.num_of_registers) *
-				sizeof(__le32);
-		else if (type == IWL_FW_INI_REGION_DEVICE_MEMORY ||
-			 type == IWL_FW_INI_REGION_PERIPHERY_MAC ||
-			 type == IWL_FW_INI_REGION_PERIPHERY_PHY ||
-			 type == IWL_FW_INI_REGION_PERIPHERY_AUX ||
-			 type == IWL_FW_INI_REGION_INTERNAL_BUFFER ||
-			 type == IWL_FW_INI_REGION_PAGING ||
-			 type == IWL_FW_INI_REGION_CSR ||
-			 type == IWL_FW_INI_REGION_LMAC_ERROR_TABLE ||
-			 type == IWL_FW_INI_REGION_UMAC_ERROR_TABLE)
-			iter += le32_to_cpu(reg->internal.num_of_ranges) *
-				sizeof(__le32);
-
-		iter += sizeof(*reg);
-	}
-}
-
-static int iwl_fw_dbg_trig_realloc(struct iwl_fw_runtime *fwrt,
-				   struct iwl_fw_ini_active_triggers *active,
-				   u32 id, int size)
-{
-	void *ptr;
-
-	if (size <= active->size)
-		return 0;
-
-	ptr = krealloc(active->trig, size, GFP_KERNEL);
-	if (!ptr) {
-		IWL_ERR(fwrt, "WRT: Failed to allocate memory for trigger %d\n",
-			id);
-		return -ENOMEM;
-	}
-	active->trig = ptr;
-	active->size = size;
-
-	return 0;
-}
-
-static void iwl_fw_dbg_update_triggers(struct iwl_fw_runtime *fwrt,
-				       struct iwl_fw_ini_trigger_tlv *tlv,
-				       enum iwl_fw_ini_apply_point apply_point)
-{
-	int i, size = le32_to_cpu(tlv->num_triggers);
-	void *iter = (void *)tlv->trigger_config;
-
-	for (i = 0; i < size; i++) {
-		struct iwl_fw_ini_trigger *trig = iter;
-		struct iwl_fw_ini_active_triggers *active;
-		int id = le32_to_cpu(trig->trigger_id);
-		u32 trig_regs_size = le32_to_cpu(trig->num_regions) *
-			sizeof(__le32);
-
-		if (WARN(id >= ARRAY_SIZE(fwrt->dump.active_trigs),
-			 "WRT: Invalid trigger id %d for apply point %d\n", id,
-			 apply_point))
-			break;
-
-		active = &fwrt->dump.active_trigs[id];
-
-		if (!active->active) {
-			size_t trig_size = sizeof(*trig) + trig_regs_size;
-
-			IWL_DEBUG_FW(fwrt, "WRT: Activating trigger %d\n", id);
-
-			if (iwl_fw_dbg_trig_realloc(fwrt, active, id,
-						    trig_size))
-				goto next;
-
-			memcpy(active->trig, trig, trig_size);
-
-		} else {
-			u32 conf_override =
-				!(le32_to_cpu(trig->override_trig) & 0xff);
-			u32 region_override =
-				!(le32_to_cpu(trig->override_trig) & 0xff00);
-			u32 offset = 0;
-			u32 active_regs =
-				le32_to_cpu(active->trig->num_regions);
-			u32 new_regs = le32_to_cpu(trig->num_regions);
-			int mem_to_add = trig_regs_size;
-
-			if (region_override) {
-				IWL_DEBUG_FW(fwrt,
-					     "WRT: Trigger %d regions override\n",
-					     id);
-
-				mem_to_add -= active_regs * sizeof(__le32);
-			} else {
-				IWL_DEBUG_FW(fwrt,
-					     "WRT: Trigger %d regions appending\n",
-					     id);
-
-				offset += active_regs;
-				new_regs += active_regs;
-			}
-
-			if (iwl_fw_dbg_trig_realloc(fwrt, active, id,
-						    active->size + mem_to_add))
-				goto next;
-
-			if (conf_override) {
-				IWL_DEBUG_FW(fwrt,
-					     "WRT: Trigger %d configuration override\n",
-					     id);
-
-				memcpy(active->trig, trig, sizeof(*trig));
-			}
-
-			memcpy(active->trig->data + offset, trig->data,
-			       trig_regs_size);
-			active->trig->num_regions = cpu_to_le32(new_regs);
-		}
-
-		/* Since zero means infinity - just set to -1 */
-		if (!le32_to_cpu(active->trig->occurrences))
-			active->trig->occurrences = cpu_to_le32(-1);
-
-		active->active = true;
-
-		if (id == IWL_FW_TRIGGER_ID_PERIODIC_TRIGGER) {
-			u32 collect_interval = le32_to_cpu(trig->trigger_data);
-
-			/* the minimum allowed interval is 50ms */
-			if (collect_interval < 50) {
-				collect_interval = 50;
-				trig->trigger_data =
-					cpu_to_le32(collect_interval);
-			}
-
-			mod_timer(&fwrt->dump.periodic_trig,
-				  jiffies + msecs_to_jiffies(collect_interval));
-		}
-next:
-		iter += sizeof(*trig) + trig_regs_size;
-
-	}
-}
-
-static void _iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
-				    struct iwl_apply_point_data *data,
-				    enum iwl_fw_ini_apply_point pnt,
-				    bool ext)
-{
-	struct iwl_apply_point_data *iter;
-
-	if (!data->list.next)
-		return;
-
-	list_for_each_entry(iter, &data->list, list) {
-		struct iwl_ucode_tlv *tlv = &iter->tlv;
-		void *ini_tlv = (void *)tlv->data;
-		u32 type = le32_to_cpu(tlv->type);
-
-		switch (type) {
-		case IWL_UCODE_TLV_TYPE_DEBUG_INFO:
-			iwl_fw_dbg_info_apply(fwrt, ini_tlv, ext, pnt);
-			break;
-		case IWL_UCODE_TLV_TYPE_BUFFER_ALLOCATION:
-			if (pnt != IWL_FW_INI_APPLY_EARLY) {
-				IWL_ERR(fwrt,
-					"WRT: ext=%d. Invalid apply point %d for buffer allocation\n",
-					ext, pnt);
-				break;
-			}
-			iwl_fw_dbg_buffer_apply(fwrt, ini_tlv, pnt);
-			break;
-		case IWL_UCODE_TLV_TYPE_HCMD:
-			if (pnt < IWL_FW_INI_APPLY_AFTER_ALIVE) {
-				IWL_ERR(fwrt,
-					"WRT: ext=%d. Invalid apply point %d for host command\n",
-					ext, pnt);
-				break;
-			}
-			iwl_fw_dbg_send_hcmd(fwrt, tlv);
-			break;
-		case IWL_UCODE_TLV_TYPE_REGIONS:
-			iwl_fw_dbg_update_regions(fwrt, ini_tlv, pnt);
-			break;
-		case IWL_UCODE_TLV_TYPE_TRIGGERS:
-			iwl_fw_dbg_update_triggers(fwrt, ini_tlv, pnt);
-			break;
-		default:
-			WARN_ONCE(1, "WRT: Invalid TLV 0x%x for apply point\n",
-				  type);
-			break;
-		}
-	}
-}
-
-static void iwl_fw_dbg_ini_reset_cfg(struct iwl_fw_runtime *fwrt)
-{
-	int i;
-
-	for (i = 0; i < IWL_FW_INI_MAX_REGION_ID; i++)
-		fwrt->dump.active_regs[i] = NULL;
-
-	/* disable the triggers, used in recovery flow */
-	for (i = 0; i < IWL_FW_TRIGGER_ID_NUM; i++)
-		fwrt->dump.active_trigs[i].active = false;
-
-	memset(fwrt->dump.img_name, 0,
-	       sizeof(fwrt->dump.img_name));
-	memset(fwrt->dump.internal_dbg_cfg_name, 0,
-	       sizeof(fwrt->dump.internal_dbg_cfg_name));
-	memset(fwrt->dump.external_dbg_cfg_name, 0,
-	       sizeof(fwrt->dump.external_dbg_cfg_name));
-
-	fwrt->trans->dbg.ini_dest = IWL_FW_INI_LOCATION_INVALID;
-}
-
-void iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
-			    enum iwl_fw_ini_apply_point apply_point)
-{
-	void *data;
-
-	if (apply_point == IWL_FW_INI_APPLY_EARLY)
-		iwl_fw_dbg_ini_reset_cfg(fwrt);
-
-	if (fwrt->trans->dbg.internal_ini_cfg != IWL_INI_CFG_STATE_NOT_LOADED) {
-		IWL_DEBUG_FW(fwrt,
-			     "WRT: Enabling internal configuration apply point %d\n",
-			     apply_point);
-		data = &fwrt->trans->dbg.apply_points[apply_point];
-		_iwl_fw_dbg_apply_point(fwrt, data, apply_point, false);
-	}
-
-	if (fwrt->trans->dbg.external_ini_cfg != IWL_INI_CFG_STATE_NOT_LOADED) {
-		IWL_DEBUG_FW(fwrt,
-			     "WRT: Enabling external configuration apply point %d\n",
-			     apply_point);
-		data = &fwrt->trans->dbg.apply_points_ext[apply_point];
-		_iwl_fw_dbg_apply_point(fwrt, data, apply_point, true);
-	}
-}
-IWL_EXPORT_SYMBOL(iwl_fw_dbg_apply_point);
-
 void iwl_fw_dbg_stop_sync(struct iwl_fw_runtime *fwrt)
 {
 	int i;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index 8faea2571788..deb84ba3dc7e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -368,9 +368,6 @@ static inline void iwl_fw_resume_timestamp(struct iwl_fw_runtime *fwrt) {}
 
 #endif /* CONFIG_IWLWIFI_DEBUGFS */
 
-void iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
-			    enum iwl_fw_ini_apply_point apply_point);
-
 void iwl_fw_dbg_stop_sync(struct iwl_fw_runtime *fwrt);
 
 static inline void iwl_fw_lmac1_set_alive_err_table(struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 406ef73992c1..0a4e13e4cc2c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -64,7 +64,6 @@
 #include "iwl-trans.h"
 #include "img.h"
 #include "fw/api/debug.h"
-#include "fw/api/dbg-tlv.h"
 #include "fw/api/paging.h"
 #include "iwl-eeprom-parse.h"
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 5b1644a70ace..b4fba73b5b23 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -60,8 +60,11 @@
  *****************************************************************************/
 
 #include <linux/firmware.h>
+#include "iwl-drv.h"
 #include "iwl-trans.h"
 #include "iwl-dbg-tlv.h"
+#include "fw/dbg.h"
+#include "fw/runtime.h"
 
 /**
  * enum iwl_dbg_tlv_type - debug TLV types
@@ -254,3 +257,429 @@ void iwl_dbg_tlv_load_bin(struct device *dev, struct iwl_trans *trans)
 
 	release_firmware(fw);
 }
+
+static void
+iwl_dbg_tlv_apply_debug_info(struct iwl_fw_runtime *fwrt,
+			     struct iwl_fw_ini_debug_info_tlv *dbg_info,
+			     bool ext, enum iwl_fw_ini_apply_point pnt)
+{
+	u32 img_name_len = le32_to_cpu(dbg_info->img_name_len);
+	u32 dbg_cfg_name_len = le32_to_cpu(dbg_info->dbg_cfg_name_len);
+	const char err_str[] =
+		"WRT: Invalid %s name length %d, expected %d\n";
+
+	if (img_name_len != IWL_FW_INI_MAX_IMG_NAME_LEN) {
+		IWL_WARN(fwrt, err_str, "image", img_name_len,
+			 IWL_FW_INI_MAX_IMG_NAME_LEN);
+		return;
+	}
+
+	if (dbg_cfg_name_len != IWL_FW_INI_MAX_DBG_CFG_NAME_LEN) {
+		IWL_WARN(fwrt, err_str, "debug cfg", dbg_cfg_name_len,
+			 IWL_FW_INI_MAX_DBG_CFG_NAME_LEN);
+		return;
+	}
+
+	if (ext) {
+		memcpy(fwrt->dump.external_dbg_cfg_name, dbg_info->dbg_cfg_name,
+		       sizeof(fwrt->dump.external_dbg_cfg_name));
+	} else {
+		memcpy(fwrt->dump.img_name, dbg_info->img_name,
+		       sizeof(fwrt->dump.img_name));
+		memcpy(fwrt->dump.internal_dbg_cfg_name, dbg_info->dbg_cfg_name,
+		       sizeof(fwrt->dump.internal_dbg_cfg_name));
+	}
+}
+
+static void iwl_dbg_tlv_alloc_buffer(struct iwl_fw_runtime *fwrt, u32 size)
+{
+	struct iwl_trans *trans = fwrt->trans;
+	void *virtual_addr = NULL;
+	dma_addr_t phys_addr;
+
+	if (WARN_ON_ONCE(trans->dbg.num_blocks ==
+			 ARRAY_SIZE(trans->dbg.fw_mon)))
+		return;
+
+	virtual_addr =
+		dma_alloc_coherent(fwrt->trans->dev, size, &phys_addr,
+				   GFP_KERNEL | __GFP_NOWARN);
+
+	/* TODO: alloc fragments if needed */
+	if (!virtual_addr)
+		IWL_ERR(fwrt, "Failed to allocate debug memory\n");
+
+	IWL_DEBUG_FW(trans,
+		     "Allocated DRAM buffer[%d], size=0x%x\n",
+		     trans->dbg.num_blocks, size);
+
+	trans->dbg.fw_mon[trans->dbg.num_blocks].block = virtual_addr;
+	trans->dbg.fw_mon[trans->dbg.num_blocks].physical = phys_addr;
+	trans->dbg.fw_mon[trans->dbg.num_blocks].size = size;
+	trans->dbg.num_blocks++;
+}
+
+static void iwl_dbg_tlv_apply_buffer(struct iwl_fw_runtime *fwrt,
+				     struct iwl_fw_ini_allocation_tlv *alloc,
+				     enum iwl_fw_ini_apply_point pnt)
+{
+	struct iwl_trans *trans = fwrt->trans;
+	struct iwl_ldbg_config_cmd ldbg_cmd = {
+		.type = cpu_to_le32(BUFFER_ALLOCATION),
+	};
+	struct iwl_buffer_allocation_cmd *cmd = &ldbg_cmd.buffer_allocation;
+	struct iwl_host_cmd hcmd = {
+		.id = LDBG_CONFIG_CMD,
+		.flags = CMD_ASYNC,
+		.data[0] = &ldbg_cmd,
+		.len[0] = sizeof(ldbg_cmd),
+	};
+	int block_idx = trans->dbg.num_blocks;
+	u32 buf_location = le32_to_cpu(alloc->buffer_location);
+	u32 alloc_id = le32_to_cpu(alloc->allocation_id);
+
+	if (alloc_id <= IWL_FW_INI_ALLOCATION_INVALID ||
+	    alloc_id >= IWL_FW_INI_ALLOCATION_NUM) {
+		IWL_ERR(fwrt, "WRT: Invalid allocation id %d\n", alloc_id);
+		return;
+	}
+
+	if (fwrt->trans->dbg.ini_dest == IWL_FW_INI_LOCATION_INVALID)
+		fwrt->trans->dbg.ini_dest = buf_location;
+
+	if (buf_location != fwrt->trans->dbg.ini_dest) {
+		WARN(fwrt,
+		     "WRT: attempt to override buffer location on apply point %d\n",
+		     pnt);
+
+		return;
+	}
+
+	if (buf_location == IWL_FW_INI_LOCATION_SRAM_PATH) {
+		IWL_DEBUG_FW(trans, "WRT: Applying SMEM buffer destination\n");
+		/* set sram monitor by enabling bit 7 */
+		iwl_set_bit(fwrt->trans, CSR_HW_IF_CONFIG_REG,
+			    CSR_HW_IF_CONFIG_REG_BIT_MONITOR_SRAM);
+
+		return;
+	}
+
+	if (buf_location != IWL_FW_INI_LOCATION_DRAM_PATH)
+		return;
+
+	if (!(BIT(alloc_id) & fwrt->trans->dbg.is_alloc)) {
+		iwl_dbg_tlv_alloc_buffer(fwrt, le32_to_cpu(alloc->size));
+		if (block_idx == trans->dbg.num_blocks)
+			return;
+		fwrt->trans->dbg.is_alloc |= BIT(alloc_id);
+	}
+
+	/* First block is assigned via registers / context info */
+	if (trans->dbg.num_blocks == 1)
+		return;
+
+	IWL_DEBUG_FW(trans,
+		     "WRT: Applying DRAM buffer[%d] destination\n", block_idx);
+
+	cmd->num_frags = cpu_to_le32(1);
+	cmd->fragments[0].address =
+		cpu_to_le64(trans->dbg.fw_mon[block_idx].physical);
+	cmd->fragments[0].size = alloc->size;
+	cmd->allocation_id = alloc->allocation_id;
+	cmd->buffer_location = alloc->buffer_location;
+
+	iwl_trans_send_cmd(trans, &hcmd);
+}
+
+static void iwl_dbg_tlv_apply_hcmd(struct iwl_fw_runtime *fwrt,
+				   struct iwl_ucode_tlv *tlv)
+{
+	struct iwl_fw_ini_hcmd_tlv *hcmd_tlv = (void *)&tlv->data[0];
+	struct iwl_fw_ini_hcmd *data = &hcmd_tlv->hcmd;
+	u16 len = le32_to_cpu(tlv->length) - sizeof(*hcmd_tlv);
+
+	struct iwl_host_cmd hcmd = {
+		.id = WIDE_ID(data->group, data->id),
+		.len = { len, },
+		.data = { data->data, },
+	};
+
+	/* currently the driver supports always on domain only */
+	if (le32_to_cpu(hcmd_tlv->domain) != IWL_FW_INI_DBG_DOMAIN_ALWAYS_ON)
+		return;
+
+	IWL_DEBUG_FW(fwrt, "WRT: Sending host command id=0x%x, group=0x%x\n",
+		     data->id, data->group);
+
+	iwl_trans_send_cmd(fwrt->trans, &hcmd);
+}
+
+static void iwl_dbg_tlv_apply_region(struct iwl_fw_runtime *fwrt,
+				     struct iwl_fw_ini_region_tlv *tlv,
+				     enum iwl_fw_ini_apply_point pnt)
+{
+	void *iter = (void *)tlv->region_config;
+	int i, size = le32_to_cpu(tlv->num_regions);
+	const char *err_st =
+		"WRT: Invalid region %s %d for apply point %d\n";
+
+	for (i = 0; i < size; i++) {
+		struct iwl_fw_ini_region_cfg *reg = iter, **active;
+		int id = le32_to_cpu(reg->region_id);
+		u32 type = le32_to_cpu(reg->region_type);
+
+		if (WARN(id >= ARRAY_SIZE(fwrt->dump.active_regs), err_st, "id",
+			 id, pnt))
+			break;
+
+		if (WARN(type == 0 || type >= IWL_FW_INI_REGION_NUM, err_st,
+			 "type", type, pnt))
+			break;
+
+		active = &fwrt->dump.active_regs[id];
+
+		if (*active)
+			IWL_WARN(fwrt->trans, "WRT: Region id %d override\n",
+				 id);
+
+		IWL_DEBUG_FW(fwrt, "WRT: Activating region id %d\n", id);
+
+		*active = reg;
+
+		if (type == IWL_FW_INI_REGION_TXF ||
+		    type == IWL_FW_INI_REGION_RXF)
+			iter += le32_to_cpu(reg->fifos.num_of_registers) *
+				sizeof(__le32);
+		else if (type == IWL_FW_INI_REGION_DEVICE_MEMORY ||
+			 type == IWL_FW_INI_REGION_PERIPHERY_MAC ||
+			 type == IWL_FW_INI_REGION_PERIPHERY_PHY ||
+			 type == IWL_FW_INI_REGION_PERIPHERY_AUX ||
+			 type == IWL_FW_INI_REGION_INTERNAL_BUFFER ||
+			 type == IWL_FW_INI_REGION_PAGING ||
+			 type == IWL_FW_INI_REGION_CSR ||
+			 type == IWL_FW_INI_REGION_LMAC_ERROR_TABLE ||
+			 type == IWL_FW_INI_REGION_UMAC_ERROR_TABLE)
+			iter += le32_to_cpu(reg->internal.num_of_ranges) *
+				sizeof(__le32);
+
+		iter += sizeof(*reg);
+	}
+}
+
+static int iwl_dbg_tlv_trig_realloc(struct iwl_fw_runtime *fwrt,
+				    struct iwl_fw_ini_active_triggers *active,
+				    u32 id, int size)
+{
+	void *ptr;
+
+	if (size <= active->size)
+		return 0;
+
+	ptr = krealloc(active->trig, size, GFP_KERNEL);
+	if (!ptr) {
+		IWL_ERR(fwrt, "WRT: Failed to allocate memory for trigger %d\n",
+			id);
+		return -ENOMEM;
+	}
+	active->trig = ptr;
+	active->size = size;
+
+	return 0;
+}
+
+static void iwl_dbg_tlv_apply_trigger(struct iwl_fw_runtime *fwrt,
+				      struct iwl_fw_ini_trigger_tlv *tlv,
+				      enum iwl_fw_ini_apply_point apply_point)
+{
+	int i, size = le32_to_cpu(tlv->num_triggers);
+	void *iter = (void *)tlv->trigger_config;
+
+	for (i = 0; i < size; i++) {
+		struct iwl_fw_ini_trigger *trig = iter;
+		struct iwl_fw_ini_active_triggers *active;
+		int id = le32_to_cpu(trig->trigger_id);
+		u32 trig_regs_size = le32_to_cpu(trig->num_regions) *
+			sizeof(__le32);
+
+		if (WARN(id >= ARRAY_SIZE(fwrt->dump.active_trigs),
+			 "WRT: Invalid trigger id %d for apply point %d\n", id,
+			 apply_point))
+			break;
+
+		active = &fwrt->dump.active_trigs[id];
+
+		if (!active->active) {
+			size_t trig_size = sizeof(*trig) + trig_regs_size;
+
+			IWL_DEBUG_FW(fwrt, "WRT: Activating trigger %d\n", id);
+
+			if (iwl_dbg_tlv_trig_realloc(fwrt, active, id,
+						     trig_size))
+				goto next;
+
+			memcpy(active->trig, trig, trig_size);
+
+		} else {
+			u32 conf_override =
+				!(le32_to_cpu(trig->override_trig) & 0xff);
+			u32 region_override =
+				!(le32_to_cpu(trig->override_trig) & 0xff00);
+			u32 offset = 0;
+			u32 active_regs =
+				le32_to_cpu(active->trig->num_regions);
+			u32 new_regs = le32_to_cpu(trig->num_regions);
+			int mem_to_add = trig_regs_size;
+
+			if (region_override) {
+				IWL_DEBUG_FW(fwrt,
+					     "WRT: Trigger %d regions override\n",
+					     id);
+
+				mem_to_add -= active_regs * sizeof(__le32);
+			} else {
+				IWL_DEBUG_FW(fwrt,
+					     "WRT: Trigger %d regions appending\n",
+					     id);
+
+				offset += active_regs;
+				new_regs += active_regs;
+			}
+
+			if (iwl_dbg_tlv_trig_realloc(fwrt, active, id,
+						     active->size + mem_to_add))
+				goto next;
+
+			if (conf_override) {
+				IWL_DEBUG_FW(fwrt,
+					     "WRT: Trigger %d configuration override\n",
+					     id);
+
+				memcpy(active->trig, trig, sizeof(*trig));
+			}
+
+			memcpy(active->trig->data + offset, trig->data,
+			       trig_regs_size);
+			active->trig->num_regions = cpu_to_le32(new_regs);
+		}
+
+		/* Since zero means infinity - just set to -1 */
+		if (!le32_to_cpu(active->trig->occurrences))
+			active->trig->occurrences = cpu_to_le32(-1);
+
+		active->active = true;
+
+		if (id == IWL_FW_TRIGGER_ID_PERIODIC_TRIGGER) {
+			u32 collect_interval = le32_to_cpu(trig->trigger_data);
+
+			/* the minimum allowed interval is 50ms */
+			if (collect_interval < 50) {
+				collect_interval = 50;
+				trig->trigger_data =
+					cpu_to_le32(collect_interval);
+			}
+
+			mod_timer(&fwrt->dump.periodic_trig,
+				  jiffies + msecs_to_jiffies(collect_interval));
+		}
+next:
+		iter += sizeof(*trig) + trig_regs_size;
+	}
+}
+
+static void _iwl_dbg_tlv_apply_point(struct iwl_fw_runtime *fwrt,
+				     struct iwl_apply_point_data *data,
+				     enum iwl_fw_ini_apply_point pnt,
+				     bool ext)
+{
+	struct iwl_apply_point_data *iter;
+
+	if (!data->list.next)
+		return;
+
+	list_for_each_entry(iter, &data->list, list) {
+		struct iwl_ucode_tlv *tlv = &iter->tlv;
+		void *ini_tlv = (void *)tlv->data;
+		u32 type = le32_to_cpu(tlv->type);
+		const char invalid_ap_str[] =
+			"WRT: Invalid apply point %d for %s\n";
+
+		switch (type) {
+		case IWL_UCODE_TLV_TYPE_DEBUG_INFO:
+			iwl_dbg_tlv_apply_debug_info(fwrt, ini_tlv, ext, pnt);
+			break;
+		case IWL_UCODE_TLV_TYPE_BUFFER_ALLOCATION:
+			if (pnt != IWL_FW_INI_APPLY_EARLY) {
+				IWL_ERR(fwrt, invalid_ap_str, pnt,
+					"buffer allocation");
+				break;
+			}
+			iwl_dbg_tlv_apply_buffer(fwrt, ini_tlv, pnt);
+			break;
+		case IWL_UCODE_TLV_TYPE_HCMD:
+			if (pnt < IWL_FW_INI_APPLY_AFTER_ALIVE) {
+				IWL_ERR(fwrt, invalid_ap_str, pnt,
+					"host command");
+				break;
+			}
+			iwl_dbg_tlv_apply_hcmd(fwrt, tlv);
+			break;
+		case IWL_UCODE_TLV_TYPE_REGIONS:
+			iwl_dbg_tlv_apply_region(fwrt, ini_tlv, pnt);
+			break;
+		case IWL_UCODE_TLV_TYPE_TRIGGERS:
+			iwl_dbg_tlv_apply_trigger(fwrt, ini_tlv, pnt);
+			break;
+		default:
+			WARN_ONCE(1, "WRT: Invalid TLV 0x%x for apply point\n",
+				  type);
+			break;
+		}
+	}
+}
+
+static void iwl_dbg_tlv_reset_cfg(struct iwl_fw_runtime *fwrt)
+{
+	int i;
+
+	for (i = 0; i < IWL_FW_INI_MAX_REGION_ID; i++)
+		fwrt->dump.active_regs[i] = NULL;
+
+	/* disable the triggers, used in recovery flow */
+	for (i = 0; i < IWL_FW_TRIGGER_ID_NUM; i++)
+		fwrt->dump.active_trigs[i].active = false;
+
+	memset(fwrt->dump.img_name, 0,
+	       sizeof(fwrt->dump.img_name));
+	memset(fwrt->dump.internal_dbg_cfg_name, 0,
+	       sizeof(fwrt->dump.internal_dbg_cfg_name));
+	memset(fwrt->dump.external_dbg_cfg_name, 0,
+	       sizeof(fwrt->dump.external_dbg_cfg_name));
+
+	fwrt->trans->dbg.ini_dest = IWL_FW_INI_LOCATION_INVALID;
+}
+
+void iwl_dbg_tlv_apply_point(struct iwl_fw_runtime *fwrt,
+			     enum iwl_fw_ini_apply_point apply_point)
+{
+	void *data;
+
+	if (apply_point == IWL_FW_INI_APPLY_EARLY)
+		iwl_dbg_tlv_reset_cfg(fwrt);
+
+	if (fwrt->trans->dbg.internal_ini_cfg != IWL_INI_CFG_STATE_NOT_LOADED) {
+		IWL_DEBUG_FW(fwrt,
+			     "WRT: Enabling internal configuration apply point %d\n",
+			     apply_point);
+		data = &fwrt->trans->dbg.apply_points[apply_point];
+		_iwl_dbg_tlv_apply_point(fwrt, data, apply_point, false);
+	}
+
+	if (fwrt->trans->dbg.external_ini_cfg != IWL_INI_CFG_STATE_NOT_LOADED) {
+		IWL_DEBUG_FW(fwrt,
+			     "WRT: Enabling external configuration apply point %d\n",
+			     apply_point);
+		data = &fwrt->trans->dbg.apply_points_ext[apply_point];
+		_iwl_dbg_tlv_apply_point(fwrt, data, apply_point, true);
+	}
+}
+IWL_EXPORT_SYMBOL(iwl_dbg_tlv_apply_point);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
index 3a60590d274d..93496945d313 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
@@ -75,9 +75,13 @@ struct iwl_apply_point_data {
 };
 
 struct iwl_trans;
+struct iwl_fw_runtime;
+
 void iwl_dbg_tlv_load_bin(struct device *dev, struct iwl_trans *trans);
 void iwl_dbg_tlv_free(struct iwl_trans *trans);
 void iwl_dbg_tlv_alloc(struct iwl_trans *trans, struct iwl_ucode_tlv *tlv,
 		       bool ext);
+void iwl_dbg_tlv_apply_point(struct iwl_fw_runtime *fwrt,
+			     enum iwl_fw_ini_apply_point apply_point);
 
 #endif /* __iwl_dbg_tlv_h__*/
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index a6e360194e00..f09f24089fe7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -430,7 +430,7 @@ static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm, bool read_nvm)
 				   iwl_wait_init_complete,
 				   NULL);
 
-	iwl_fw_dbg_apply_point(&mvm->fwrt, IWL_FW_INI_APPLY_EARLY);
+	iwl_dbg_tlv_apply_point(&mvm->fwrt, IWL_FW_INI_APPLY_EARLY);
 
 	/* Will also start the device */
 	ret = iwl_mvm_load_ucode_wait_alive(mvm, IWL_UCODE_REGULAR);
@@ -438,7 +438,7 @@ static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm, bool read_nvm)
 		IWL_ERR(mvm, "Failed to start RT ucode: %d\n", ret);
 		goto error;
 	}
-	iwl_fw_dbg_apply_point(&mvm->fwrt, IWL_FW_INI_APPLY_AFTER_ALIVE);
+	iwl_dbg_tlv_apply_point(&mvm->fwrt, IWL_FW_INI_APPLY_AFTER_ALIVE);
 
 	/* Send init config command to mark that we are sending NVM access
 	 * commands
@@ -1263,7 +1263,7 @@ static int iwl_mvm_load_rt_fw(struct iwl_mvm *mvm)
 	if (ret)
 		return ret;
 
-	iwl_fw_dbg_apply_point(&mvm->fwrt, IWL_FW_INI_APPLY_EARLY);
+	iwl_dbg_tlv_apply_point(&mvm->fwrt, IWL_FW_INI_APPLY_EARLY);
 
 	mvm->rfkill_safe_init_done = false;
 	ret = iwl_mvm_load_ucode_wait_alive(mvm, IWL_UCODE_REGULAR);
@@ -1272,7 +1272,7 @@ static int iwl_mvm_load_rt_fw(struct iwl_mvm *mvm)
 
 	mvm->rfkill_safe_init_done = true;
 
-	iwl_fw_dbg_apply_point(&mvm->fwrt, IWL_FW_INI_APPLY_AFTER_ALIVE);
+	iwl_dbg_tlv_apply_point(&mvm->fwrt, IWL_FW_INI_APPLY_AFTER_ALIVE);
 
 	return iwl_init_paging(&mvm->fwrt, mvm->fwrt.cur_fw_img);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 8c9777424316..5ea7f8571dd9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1420,7 +1420,7 @@ void iwl_mvm_rx_missed_beacons_notif(struct iwl_mvm *mvm,
 	    rx_missed_bcon >= stop_trig_missed_bcon)
 		iwl_fw_dbg_collect_trig(&mvm->fwrt, trigger, NULL);
 
-	iwl_fw_dbg_apply_point(&mvm->fwrt, IWL_FW_INI_APPLY_MISSED_BEACONS);
+	iwl_dbg_tlv_apply_point(&mvm->fwrt, IWL_FW_INI_APPLY_MISSED_BEACONS);
 
 out:
 	rcu_read_unlock();
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index e3699df89572..07763f97d5c5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1106,7 +1106,7 @@ int __iwl_mvm_mac_start(struct iwl_mvm *mvm)
 	}
 	ret = iwl_mvm_up(mvm);
 
-	iwl_fw_dbg_apply_point(&mvm->fwrt, IWL_FW_INI_APPLY_POST_INIT);
+	iwl_dbg_tlv_apply_point(&mvm->fwrt, IWL_FW_INI_APPLY_POST_INIT);
 
 	if (ret && test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
 		/* Something went wrong - we need to finish some cleanup
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index afa44345f37b..892db3dcdc27 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1940,7 +1940,7 @@ void iwl_mvm_rx_umac_scan_complete_notif(struct iwl_mvm *mvm,
 
 	mvm->scan_uid_status[uid] = 0;
 
-	iwl_fw_dbg_apply_point(&mvm->fwrt, IWL_FW_INI_APPLY_SCAN_COMPLETE);
+	iwl_dbg_tlv_apply_point(&mvm->fwrt, IWL_FW_INI_APPLY_SCAN_COMPLETE);
 }
 
 void iwl_mvm_rx_umac_scan_iter_complete_notif(struct iwl_mvm *mvm,
-- 
2.23.0.rc1

