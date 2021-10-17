Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440B643078E
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 11:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245179AbhJQJmv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 05:42:51 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53706 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245201AbhJQJmr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 05:42:47 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc2ef-000YUg-Ua; Sun, 17 Oct 2021 12:40:34 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 12:40:19 +0300
Message-Id: <iwlwifi.20211017123741.cacf0babc521.If3704b5fda09b344e3e438252360898a3f2e90fa@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017094019.442271-1-luca@coelho.fi>
References: <20211017094019.442271-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 12/12] iwlwifi: yoyo: fw debug config from context info and preset
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Add new TLV for debug config set to read preset
based on TLV is set in context info.
This is needed to set the preset based on ucode in early
trigger point.
Add DRAM frag allocation info in first fragment of
DBGC1 with all details.
New capability from FW for DBGC frag debug support is
added and BUFFER_ALLOCATION_CMD is disabled in capability
is supported.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  56 +++++++
 .../net/wireless/intel/iwlwifi/fw/api/debug.h |  18 ++
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   2 +
 .../intel/iwlwifi/iwl-context-info-gen3.h     |   4 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 158 +++++++++++++++++-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  |   2 +
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   1 +
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   5 +-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |   4 +
 9 files changed, 245 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index 6ab5755beb53..3988f5fea33a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -243,6 +243,62 @@ struct iwl_fw_ini_hcmd_tlv {
 	struct iwl_fw_ini_hcmd hcmd;
 } __packed; /* FW_TLV_DEBUG_HCMD_API_S_VER_1 */
 
+/**
+* struct iwl_fw_ini_conf_tlv - preset configuration TLV
+*
+* @address: the base address
+* @value: value to set at address
+
+*/
+struct iwl_fw_ini_addr_val {
+	__le32 address;
+	__le32 value;
+} __packed; /* FW_TLV_DEBUG_ADDR_VALUE_VER_1 */
+
+/**
+ * struct iwl_fw_ini_conf_tlv - configuration TLV to set register/memory.
+ *
+ * @hdr: debug header
+ * @time_point: time point to apply config. One of &enum iwl_fw_ini_time_point
+ * @set_type: write access type preset token for time point.
+ *  one of &enum iwl_fw_ini_config_set_type
+ * @addr_offset: the offset to add to any item in address[0] field
+ * @addr_val: address value pair
+ */
+struct iwl_fw_ini_conf_set_tlv {
+	struct iwl_fw_ini_header hdr;
+	__le32 time_point;
+	__le32 set_type;
+	__le32 addr_offset;
+	struct iwl_fw_ini_addr_val addr_val[0];
+} __packed; /* FW_TLV_DEBUG_CONFIG_SET_API_S_VER_1 */
+
+/**
+ * enum iwl_fw_ini_config_set_type
+ *
+ * @IWL_FW_INI_CONFIG_SET_TYPE_INVALID: invalid config set
+ * @IWL_FW_INI_CONFIG_SET_TYPE_DEVICE_PERIPHERY_MAC: for PERIPHERY MAC configuration
+ * @IWL_FW_INI_CONFIG_SET_TYPE_DEVICE_PERIPHERY_PHY: for PERIPHERY PHY configuration
+ * @IWL_FW_INI_CONFIG_SET_TYPE_DEVICE_PERIPHERY_AUX: for PERIPHERY AUX configuration
+ * @IWL_FW_INI_CONFIG_SET_TYPE_DEVICE_MEMORY: for DEVICE MEMORY configuration
+ * @IWL_FW_INI_CONFIG_SET_TYPE_CSR: for CSR configuration
+ * @IWL_FW_INI_CONFIG_SET_TYPE_DBGC_DRAM_ADDR: for DBGC_DRAM_ADDR configuration
+ * @IWL_FW_INI_CONFIG_SET_TYPE_PERIPH_SCRATCH_HWM: for PERIPH SCRATCH HWM configuration
+ * @IWL_FW_INI_ALLOCATION_NUM: max number of configuration supported
+*/
+
+enum iwl_fw_ini_config_set_type {
+	IWL_FW_INI_CONFIG_SET_TYPE_INVALID = 0,
+	IWL_FW_INI_CONFIG_SET_TYPE_DEVICE_PERIPHERY_MAC,
+	IWL_FW_INI_CONFIG_SET_TYPE_DEVICE_PERIPHERY_PHY,
+	IWL_FW_INI_CONFIG_SET_TYPE_DEVICE_PERIPHERY_AUX,
+	IWL_FW_INI_CONFIG_SET_TYPE_DEVICE_MEMORY,
+	IWL_FW_INI_CONFIG_SET_TYPE_CSR,
+	IWL_FW_INI_CONFIG_SET_TYPE_DBGC_DRAM_ADDR,
+	IWL_FW_INI_CONFIG_SET_TYPE_PERIPH_SCRATCH_HWM,
+	IWL_FW_INI_CONFIG_SET_TYPE_MAX_NUM,
+} __packed;
+
 /**
  * enum iwl_fw_ini_allocation_id
  *
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
index 8adccd5da095..0abed12df2cb 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
@@ -361,6 +361,24 @@ struct iwl_buf_alloc_cmd {
 	struct iwl_buf_alloc_frag frags[BUF_ALLOC_MAX_NUM_FRAGS];
 } __packed; /* BUFFER_ALLOCATION_CMD_API_S_VER_2 */
 
+#define DRAM_INFO_FIRST_MAGIC_WORD 0x76543210
+#define DRAM_INFO_SECOND_MAGIC_WORD 0x89ABCDEF
+
+/**
+ * struct iwL_dram_info - DRAM fragments allocation struct
+ *
+ * Driver will fill in the first 1K(+) of the pointed DRAM fragment
+ *
+ * @first_word: magic word value
+ * @second_word: magic word value
+ * @framfrags: DRAM fragmentaion detail
+*/
+struct iwl_dram_info {
+	__le32 first_word;
+	__le32 second_word;
+	struct iwl_buf_alloc_cmd dram_frags[IWL_FW_INI_ALLOCATION_NUM - 1];
+} __packed; /* INIT_DRAM_FRAGS_ALLOCATIONS_S_VER_1 */
+
 /**
  * struct iwl_dbg_host_event_cfg_cmd
  * @enabled_severities: enabled severities
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 3a031070d367..c65196daf55b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -110,6 +110,7 @@ enum iwl_ucode_tlv_type {
 	IWL_UCODE_TLV_TYPE_HCMD			= IWL_UCODE_TLV_DEBUG_BASE + 2,
 	IWL_UCODE_TLV_TYPE_REGIONS		= IWL_UCODE_TLV_DEBUG_BASE + 3,
 	IWL_UCODE_TLV_TYPE_TRIGGERS		= IWL_UCODE_TLV_DEBUG_BASE + 4,
+	IWL_UCODE_TLV_TYPE_CONF_SET		= IWL_UCODE_TLV_DEBUG_BASE + 5,
 	IWL_UCODE_TLV_DEBUG_MAX = IWL_UCODE_TLV_TYPE_TRIGGERS,
 
 	/* TLVs 0x1000-0x2000 are for internal driver usage */
@@ -453,6 +454,7 @@ enum iwl_ucode_tlv_capa {
 
 	IWL_UCODE_TLV_CAPA_BIGTK_SUPPORT		= (__force iwl_ucode_tlv_capa_t)100,
 	IWL_UCODE_TLV_CAPA_RFIM_SUPPORT			= (__force iwl_ucode_tlv_capa_t)102,
+	IWL_UCODE_TLV_CAPA_DRAM_FRAG_SUPPORT		= (__force iwl_ucode_tlv_capa_t)104,
 
 #ifdef __CHECKER__
 	/* sparse says it cannot increment the previous enum member */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
index e1fec23ac07f..5adf485db38e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
@@ -109,12 +109,12 @@ struct iwl_prph_scratch_pnvm_cfg {
  * struct iwl_prph_scratch_hwm_cfg - hwm config
  * @hwm_base_addr: hwm start address
  * @hwm_size: hwm size in DWs
- * @reserved: reserved
+ * @debug_token_config: debug preset
  */
 struct iwl_prph_scratch_hwm_cfg {
 	__le64 hwm_base_addr;
 	__le32 hwm_size;
-	__le32 reserved;
+	__le32 debug_token_config;
 } __packed; /* PERIPH_SCRATCH_HWM_CFG_S */
 
 /*
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 125479b5c0d6..869270020763 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -16,6 +16,7 @@
  * @IWL_DBG_TLV_TYPE_HCMD: host command TLV
  * @IWL_DBG_TLV_TYPE_REGION: region TLV
  * @IWL_DBG_TLV_TYPE_TRIGGER: trigger TLV
+ * @IWL_DBG_TLV_TYPE_CONF_SET: conf set TLV
  * @IWL_DBG_TLV_TYPE_NUM: number of debug TLVs
  */
 enum iwl_dbg_tlv_type {
@@ -25,6 +26,7 @@ enum iwl_dbg_tlv_type {
 	IWL_DBG_TLV_TYPE_HCMD,
 	IWL_DBG_TLV_TYPE_REGION,
 	IWL_DBG_TLV_TYPE_TRIGGER,
+	IWL_DBG_TLV_TYPE_CONF_SET,
 	IWL_DBG_TLV_TYPE_NUM,
 };
 
@@ -59,6 +61,7 @@ dbg_ver_table[IWL_DBG_TLV_TYPE_NUM] = {
 	[IWL_DBG_TLV_TYPE_HCMD]		= {.min_ver = 1, .max_ver = 1,},
 	[IWL_DBG_TLV_TYPE_REGION]	= {.min_ver = 1, .max_ver = 2,},
 	[IWL_DBG_TLV_TYPE_TRIGGER]	= {.min_ver = 1, .max_ver = 1,},
+	[IWL_DBG_TLV_TYPE_CONF_SET]	= {.min_ver = 1, .max_ver = 1,},
 };
 
 static int iwl_dbg_tlv_add(const struct iwl_ucode_tlv *tlv,
@@ -260,6 +263,37 @@ static int iwl_dbg_tlv_alloc_trigger(struct iwl_trans *trans,
 	return ret;
 }
 
+static int iwl_dbg_tlv_config_set(struct iwl_trans *trans,
+				  const struct iwl_ucode_tlv *tlv)
+{
+	struct iwl_fw_ini_conf_set_tlv *conf_set = (void *)tlv->data;
+	u32 tp = le32_to_cpu(conf_set->time_point);
+	u32 type = le32_to_cpu(conf_set->set_type);
+
+	if (tp <= IWL_FW_INI_TIME_POINT_INVALID ||
+	    tp >= IWL_FW_INI_TIME_POINT_NUM) {
+		IWL_DEBUG_FW(trans,
+			     "WRT: Invalid time point %u for config set TLV\n", tp);
+		return -EINVAL;
+	}
+
+	if (type <= IWL_FW_INI_CONFIG_SET_TYPE_INVALID ||
+	    type >= IWL_FW_INI_CONFIG_SET_TYPE_MAX_NUM) {
+		IWL_DEBUG_FW(trans,
+			     "WRT: Invalid config set type %u for config set TLV\n", type);
+		return -EINVAL;
+	}
+
+	if (type != IWL_FW_INI_CONFIG_SET_TYPE_PERIPH_SCRATCH_HWM ||
+	    trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210) {
+		IWL_DEBUG_FW(trans,
+			     "WRT: Config set type %u is not supported\n", type);
+		return -EINVAL;
+	}
+
+	return iwl_dbg_tlv_add(tlv, &trans->dbg.time_point[tp].config_list);
+}
+
 static int (*dbg_tlv_alloc[])(struct iwl_trans *trans,
 			      const struct iwl_ucode_tlv *tlv) = {
 	[IWL_DBG_TLV_TYPE_DEBUG_INFO]	= iwl_dbg_tlv_alloc_debug_info,
@@ -267,6 +301,7 @@ static int (*dbg_tlv_alloc[])(struct iwl_trans *trans,
 	[IWL_DBG_TLV_TYPE_HCMD]		= iwl_dbg_tlv_alloc_hcmd,
 	[IWL_DBG_TLV_TYPE_REGION]	= iwl_dbg_tlv_alloc_region,
 	[IWL_DBG_TLV_TYPE_TRIGGER]	= iwl_dbg_tlv_alloc_trigger,
+	[IWL_DBG_TLV_TYPE_CONF_SET]	= iwl_dbg_tlv_config_set,
 };
 
 void iwl_dbg_tlv_alloc(struct iwl_trans *trans, const struct iwl_ucode_tlv *tlv,
@@ -399,6 +434,13 @@ void iwl_dbg_tlv_free(struct iwl_trans *trans)
 			list_del(&tlv_node->list);
 			kfree(tlv_node);
 		}
+
+		list_for_each_entry_safe(tlv_node, tlv_node_tmp,
+					 &tp->config_list, list) {
+			list_del(&tlv_node->list);
+			kfree(tlv_node);
+		}
+
 	}
 
 	for (i = 0; i < ARRAY_SIZE(trans->dbg.fw_mon_ini); i++)
@@ -466,6 +508,7 @@ void iwl_dbg_tlv_init(struct iwl_trans *trans)
 		INIT_LIST_HEAD(&tp->trig_list);
 		INIT_LIST_HEAD(&tp->hcmd_list);
 		INIT_LIST_HEAD(&tp->active_trig_list);
+		INIT_LIST_HEAD(&tp->config_list);
 	}
 }
 
@@ -649,6 +692,10 @@ static void iwl_dbg_tlv_apply_buffers(struct iwl_fw_runtime *fwrt)
 {
 	int ret, i;
 
+	if (fw_has_capa(&fwrt->fw->ucode_capa,
+			IWL_UCODE_TLV_CAPA_DRAM_FRAG_SUPPORT))
+		return;
+
 	for (i = 0; i < IWL_FW_INI_ALLOCATION_NUM; i++) {
 		ret = iwl_dbg_tlv_apply_buffer(fwrt, i);
 		if (ret)
@@ -658,6 +705,87 @@ static void iwl_dbg_tlv_apply_buffers(struct iwl_fw_runtime *fwrt)
 	}
 }
 
+static int iwl_dbg_tlv_update_dram(struct iwl_fw_runtime *fwrt,
+				   enum iwl_fw_ini_allocation_id alloc_id,
+				   struct iwl_dram_info *dram_info)
+{
+	struct iwl_fw_mon *fw_mon;
+	u32 remain_frags, num_frags;
+	int j, fw_mon_idx = 0;
+	struct iwl_buf_alloc_cmd *data;
+
+	if (le32_to_cpu(fwrt->trans->dbg.fw_mon_cfg[alloc_id].buf_location) !=
+			IWL_FW_INI_LOCATION_DRAM_PATH) {
+		IWL_DEBUG_FW(fwrt, "DRAM_PATH is not supported alloc_id %u\n", alloc_id);
+		return -1;
+	}
+
+	fw_mon = &fwrt->trans->dbg.fw_mon_ini[alloc_id];
+
+	/* the first fragment of DBGC1 is given to the FW via register
+	 * or context info
+	 */
+	if (alloc_id == IWL_FW_INI_ALLOCATION_ID_DBGC1)
+		fw_mon_idx++;
+
+	remain_frags = fw_mon->num_frags - fw_mon_idx;
+	if (!remain_frags)
+		return -1;
+
+	num_frags = min_t(u32, remain_frags, BUF_ALLOC_MAX_NUM_FRAGS);
+	data = &dram_info->dram_frags[alloc_id - 1];
+	data->alloc_id = cpu_to_le32(alloc_id);
+	data->num_frags = cpu_to_le32(num_frags);
+	data->buf_location = cpu_to_le32(IWL_FW_INI_LOCATION_DRAM_PATH);
+
+	IWL_DEBUG_FW(fwrt, "WRT: DRAM buffer details alloc_id=%u, num_frags=%u\n",
+		     cpu_to_le32(alloc_id), cpu_to_le32(num_frags));
+
+	for (j = 0; j < num_frags; j++) {
+		struct iwl_buf_alloc_frag *frag = &data->frags[j];
+		struct iwl_dram_data *fw_mon_frag = &fw_mon->frags[fw_mon_idx++];
+
+		frag->addr = cpu_to_le64(fw_mon_frag->physical);
+		frag->size = cpu_to_le32(fw_mon_frag->size);
+		IWL_DEBUG_FW(fwrt, "WRT: DRAM fragment details\n");
+		IWL_DEBUG_FW(fwrt, "frag=%u, addr=0x%016llx, size=0x%x)\n",
+			     j, cpu_to_le64(fw_mon_frag->physical),
+			     cpu_to_le32(fw_mon_frag->size));
+	}
+	return 0;
+}
+
+static void iwl_dbg_tlv_update_drams(struct iwl_fw_runtime *fwrt)
+{
+	int ret, i, dram_alloc = 0;
+	struct iwl_dram_info dram_info;
+	struct iwl_dram_data *frags =
+		&fwrt->trans->dbg.fw_mon_ini[IWL_FW_INI_ALLOCATION_ID_DBGC1].frags[0];
+
+	if (!fw_has_capa(&fwrt->fw->ucode_capa,
+			 IWL_UCODE_TLV_CAPA_DRAM_FRAG_SUPPORT))
+		return;
+
+	dram_info.first_word = cpu_to_le32(DRAM_INFO_FIRST_MAGIC_WORD);
+	dram_info.second_word = cpu_to_le32(DRAM_INFO_SECOND_MAGIC_WORD);
+
+	for (i = IWL_FW_INI_ALLOCATION_ID_DBGC1;
+	     i <= IWL_FW_INI_ALLOCATION_ID_DBGC3; i++) {
+		ret = iwl_dbg_tlv_update_dram(fwrt, i, &dram_info);
+		if (!ret)
+			dram_alloc++;
+		else
+			IWL_WARN(fwrt,
+				 "WRT: Failed to set DRAM buffer for alloc id %d, ret=%d\n",
+				 i, ret);
+	}
+	if (dram_alloc) {
+		memcpy(frags->block, &dram_info, sizeof(dram_info));
+		IWL_DEBUG_FW(fwrt, "block data after  %016x\n",
+			     *((int *)fwrt->trans->dbg.fw_mon_ini[1].frags[0].block));
+	}
+}
+
 static void iwl_dbg_tlv_send_hcmds(struct iwl_fw_runtime *fwrt,
 				   struct list_head *hcmd_list)
 {
@@ -677,6 +805,31 @@ static void iwl_dbg_tlv_send_hcmds(struct iwl_fw_runtime *fwrt,
 	}
 }
 
+static void iwl_dbg_tlv_apply_config(struct iwl_fw_runtime *fwrt,
+				     struct list_head *config_list)
+{
+	struct iwl_dbg_tlv_node *node;
+
+	list_for_each_entry(node, config_list, list) {
+		struct iwl_fw_ini_conf_set_tlv *config_list = (void *)node->tlv.data;
+		u32 type = le32_to_cpu(config_list->set_type);
+
+		switch (type) {
+			case IWL_FW_INI_CONFIG_SET_TYPE_PERIPH_SCRATCH_HWM: {
+				u32 debug_token_config =
+					le32_to_cpu(config_list->addr_val[0].value);
+
+				IWL_DEBUG_FW(fwrt, "WRT: Setting HWM debug token config: %u\n",
+					     debug_token_config);
+				fwrt->trans->dbg.ucode_preset = debug_token_config;
+				break;
+			}
+		default:
+			break;
+		}
+	}
+}
+
 static void iwl_dbg_tlv_periodic_trig_handler(struct timer_list *t)
 {
 	struct iwl_dbg_tlv_timer_node *timer_node =
@@ -1051,7 +1204,7 @@ void _iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
 			     union iwl_dbg_tlv_tp_data *tp_data,
 			     bool sync)
 {
-	struct list_head *hcmd_list, *trig_list;
+	struct list_head *hcmd_list, *trig_list, *conf_list;
 
 	if (!iwl_trans_dbg_ini_valid(fwrt->trans) ||
 	    tp_id == IWL_FW_INI_TIME_POINT_INVALID ||
@@ -1060,10 +1213,13 @@ void _iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
 
 	hcmd_list = &fwrt->trans->dbg.time_point[tp_id].hcmd_list;
 	trig_list = &fwrt->trans->dbg.time_point[tp_id].active_trig_list;
+	conf_list = &fwrt->trans->dbg.time_point[tp_id].config_list;
 
 	switch (tp_id) {
 	case IWL_FW_INI_TIME_POINT_EARLY:
 		iwl_dbg_tlv_init_cfg(fwrt);
+		iwl_dbg_tlv_apply_config(fwrt, conf_list);
+		iwl_dbg_tlv_update_drams(fwrt);
 		iwl_dbg_tlv_tp_trigger(fwrt, sync, trig_list, tp_data, NULL);
 		break;
 	case IWL_FW_INI_TIME_POINT_AFTER_ALIVE:
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
index c12b1fd3f479..79287708bd6e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
@@ -33,11 +33,13 @@ union iwl_dbg_tlv_tp_data {
  * @trig_list: list of triggers
  * @active_trig_list: list of active triggers
  * @hcmd_list: list of host commands
+ * @config_list: list of configuration
  */
 struct iwl_dbg_tlv_time_point_data {
 	struct list_head trig_list;
 	struct list_head active_trig_list;
 	struct list_head hcmd_list;
+	struct list_head config_list;
 };
 
 struct iwl_trans;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 8296b71aa76f..36196e07b1a0 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1169,6 +1169,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 		case IWL_UCODE_TLV_TYPE_HCMD:
 		case IWL_UCODE_TLV_TYPE_REGIONS:
 		case IWL_UCODE_TLV_TYPE_TRIGGERS:
+		case IWL_UCODE_TLV_TYPE_CONF_SET:
 			if (iwlwifi_mod_params.enable_ini)
 				iwl_dbg_tlv_alloc(drv->trans, tlv, false);
 			break;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 32d228d7e1fe..4ebb1871bd1f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -739,8 +739,8 @@ struct iwl_self_init_dram {
  * @debug_info_tlv_list: list of debug info TLVs
  * @time_point: array of debug time points
  * @periodic_trig_list: periodic triggers list
- * @domains_bitmap: bitmap of active domains other than
- *	&IWL_FW_INI_DOMAIN_ALWAYS_ON
+ * @domains_bitmap: bitmap of active domains other than &IWL_FW_INI_DOMAIN_ALWAYS_ON
+ * @ucode_preset: preset based on ucode
  */
 struct iwl_trans_debug {
 	u8 n_dest_reg;
@@ -774,6 +774,7 @@ struct iwl_trans_debug {
 	struct list_head periodic_trig_list;
 
 	u32 domains_bitmap;
+	u32 ucode_preset;
 };
 
 struct iwl_dma_ptr {
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index 239a722cd79d..85a6da70ca78 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -57,6 +57,10 @@ iwl_pcie_ctxt_info_dbg_enable(struct iwl_trans *trans,
 			dbg_flags |= IWL_PRPH_SCRATCH_EDBG_DEST_DRAM;
 			dbg_cfg->hwm_base_addr = cpu_to_le64(frag->physical);
 			dbg_cfg->hwm_size = cpu_to_le32(frag->size);
+			dbg_cfg->debug_token_config = cpu_to_le32(trans->dbg.ucode_preset);
+			IWL_DEBUG_FW(trans,
+				     "WRT: Applying DRAM destination (debug_token_config=%u)\n",
+				     dbg_cfg->debug_token_config);
 			IWL_DEBUG_FW(trans,
 				     "WRT: Applying DRAM destination (alloc_id=%u, num_frags=%u)\n",
 				     alloc_id,
-- 
2.33.0

