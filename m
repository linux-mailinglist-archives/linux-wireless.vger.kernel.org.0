Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89F7BA62B9
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 09:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfICHiE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 03:38:04 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:40346 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725888AbfICHiD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 03:38:03 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i53Ni-0004Cd-3c; Tue, 03 Sep 2019 10:37:39 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue,  3 Sep 2019 10:37:10 +0300
Message-Id: <20190903073714.32278-18-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190903073714.32278-1-luca@coelho.fi>
References: <20190903073714.32278-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 17/21] iwlwifi: dbg_ini: remove apply point, switch to time point API
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Remove the "apply points" mechanism as preparation for the changed
debug API where this is now a "time point" instead. Use a new API
across the code at the trigger points ("time points"), but don't
yet implement it since that requires some more preparation.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  89 +++-
 .../net/wireless/intel/iwlwifi/fw/api/debug.h |  45 --
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 489 +-----------------
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  |  13 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   5 -
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  10 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |   5 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |   2 -
 10 files changed, 101 insertions(+), 568 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index 798e61d4d683..ba586f148c14 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -397,27 +397,6 @@ enum iwl_fw_ini_trigger_id {
 	IWL_FW_TRIGGER_ID_NUM,
 }; /* FW_DEBUG_TLV_TRIGGER_ID_E_VER_1 */
 
-/**
- * enum iwl_fw_ini_apply_point
- *
- * @IWL_FW_INI_APPLY_INVALID: invalid
- * @IWL_FW_INI_APPLY_EARLY: pre loading FW
- * @IWL_FW_INI_APPLY_AFTER_ALIVE: first cmd from host after alive
- * @IWL_FW_INI_APPLY_POST_INIT: last cmd in initialization sequence
- * @IWL_FW_INI_APPLY_MISSED_BEACONS: missed beacons notification
- * @IWL_FW_INI_APPLY_SCAN_COMPLETE: scan completed
- * @IWL_FW_INI_APPLY_NUM: number of apply points
-*/
-enum iwl_fw_ini_apply_point {
-	IWL_FW_INI_APPLY_INVALID,
-	IWL_FW_INI_APPLY_EARLY,
-	IWL_FW_INI_APPLY_AFTER_ALIVE,
-	IWL_FW_INI_APPLY_POST_INIT,
-	IWL_FW_INI_APPLY_MISSED_BEACONS,
-	IWL_FW_INI_APPLY_SCAN_COMPLETE,
-	IWL_FW_INI_APPLY_NUM,
-}; /* FW_DEBUG_TLV_APPLY_POINT_E_VER_1 */
-
 /**
  * enum iwl_fw_ini_allocation_id
  *
@@ -510,4 +489,72 @@ enum iwl_fw_ini_region_type {
 	IWL_FW_INI_REGION_NUM
 }; /* FW_DEBUG_TLV_REGION_TYPE_E_VER_1 */
 
+/**
+ * enum iwl_fw_ini_time_point
+ *
+ * Hard coded time points in which the driver can send hcmd or perform dump
+ * collection
+ *
+ * @IWL_FW_INI_TIME_POINT_EARLY: pre loading the FW
+ * @IWL_FW_INI_TIME_POINT_AFTER_ALIVE: first cmd from host after alive notif
+ * @IWL_FW_INI_TIME_POINT_POST_INIT: last cmd in series of init sequence
+ * @IWL_FW_INI_TIME_POINT_FW_ASSERT: FW assert
+ * @IWL_FW_INI_TIME_POINT_FW_HW_ERROR: FW HW error
+ * @IWL_FW_INI_TIME_POINT_FW_TFD_Q_HANG: TFD queue hang
+ * @IWL_FW_INI_TIME_POINT_FW_DHC_NOTIFOCATION: DHC cmd response and notif
+ * @IWL_FW_INI_TIME_POINT_FW_RSP_OR_NOTIF: FW response or notification.
+ *	data field holds id and group
+ * @IWL_FW_INI_TIME_POINT_USER_TRIGGER: user trigger time point
+ * @IWL_FW_INI_TIME_POINT_PERIODIC: periodic timepoint that fires in constant
+ *	intervals. data field holds the interval time in msec
+ * @IWL_FW_INI_TIME_POINT_WDG_TIMEOUT: watchdog timeout
+ * @IWL_FW_INI_TIME_POINT_HOST_ASSERT: Unused
+ * @IWL_FW_INI_TIME_POINT_HOST_ALIVE_TIMEOUT: alive timeout
+ * @IWL_FW_INI_TIME_POINT_HOST_DEVICE_ENABLE: device enable
+ * @IWL_FW_INI_TIME_POINT_HOST_DEVICE_DISABLE: device disable
+ * @IWL_FW_INI_TIME_POINT_HOST_D3_START: D3 start
+ * @IWL_FW_INI_TIME_POINT_HOST_D3_END: D3 end
+ * @IWL_FW_INI_TIME_POINT_MISSED_BEACONS: missed beacons
+ * @IWL_FW_INI_TIME_POINT_ASSOC_FAILED: association failure
+ * @IWL_FW_INI_TIME_POINT_TX_FAILED: Tx frame failed
+ * @IWL_FW_INI_TIME_POINT_TX_WFD_ACTION_FRAME_FAILED: wifi direct action
+ *	frame failed
+ * @IWL_FW_INI_TIME_POINT_TX_LATENCY_THRESHOLD: Tx latency threshold
+ * @IWL_FW_INI_TIME_POINT_HANG_OCCURRED: hang occurred
+ * @IWL_FW_INI_TIME_POINT_EAPOL_FAILED: EAPOL failed
+ * @IWL_FW_INI_TIME_POINT_FAKE_TX: fake Tx
+ * @IWL_FW_INI_TIME_POINT_DEASSOC: de association
+ * @IWL_FW_INI_TIME_POINT_NUM: number of time points
+ */
+enum iwl_fw_ini_time_point {
+	IWL_FW_INI_TIME_POINT_INVALID,
+	IWL_FW_INI_TIME_POINT_EARLY,
+	IWL_FW_INI_TIME_POINT_AFTER_ALIVE,
+	IWL_FW_INI_TIME_POINT_POST_INIT,
+	IWL_FW_INI_TIME_POINT_FW_ASSERT,
+	IWL_FW_INI_TIME_POINT_FW_HW_ERROR,
+	IWL_FW_INI_TIME_POINT_FW_TFD_Q_HANG,
+	IWL_FW_INI_TIME_POINT_FW_DHC_NOTIFOCATION,
+	IWL_FW_INI_TIME_POINT_FW_RSP_OR_NOTIF,
+	IWL_FW_INI_TIME_POINT_USER_TRIGGER,
+	IWL_FW_INI_TIME_POINT_PERIODIC,
+	IWL_FW_INI_TIME_POINT_WDG_TIMEOUT,
+	IWL_FW_INI_TIME_POINT_HOST_ASSERT,
+	IWL_FW_INI_TIME_POINT_HOST_ALIVE_TIMEOUT,
+	IWL_FW_INI_TIME_POINT_HOST_DEVICE_ENABLE,
+	IWL_FW_INI_TIME_POINT_HOST_DEVICE_DISABLE,
+	IWL_FW_INI_TIME_POINT_HOST_D3_START,
+	IWL_FW_INI_TIME_POINT_HOST_D3_END,
+	IWL_FW_INI_TIME_POINT_MISSED_BEACONS,
+	IWL_FW_INI_TIME_POINT_ASSOC_FAILED,
+	IWL_FW_INI_TIME_POINT_TX_FAILED,
+	IWL_FW_INI_TIME_POINT_TX_WFD_ACTION_FRAME_FAILED,
+	IWL_FW_INI_TIME_POINT_TX_LATENCY_THRESHOLD,
+	IWL_FW_INI_TIME_POINT_HANG_OCCURRED,
+	IWL_FW_INI_TIME_POINT_EAPOL_FAILED,
+	IWL_FW_INI_TIME_POINT_FAKE_TX,
+	IWL_FW_INI_TIME_POINT_DEASSOC,
+	IWL_FW_INI_TIME_POINT_NUM,
+}; /* FW_TLV_DEBUG_TIME_POINT_API_E */
+
 #endif
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
index b627c31d06ed..c67a6ab6491c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
@@ -352,51 +352,6 @@ struct iwl_dbg_mem_access_rsp {
 	__le32 data[];
 } __packed; /* DEBUG_(U|L)MAC_RD_WR_RSP_API_S_VER_1 */
 
-#define LDBG_CFG_COMMAND_SIZE	80
-#define BUFFER_ALLOCATION	0x27
-#define START_DEBUG_RECORDING	0x29
-#define STOP_DEBUG_RECORDING	0x2A
-
-/* maximum fragments to be allocated per target of allocationId */
-#define IWL_BUFFER_LOCATION_MAX_FRAGS	2
-
-/**
- * struct iwl_fragment_data single fragment structure
- * @address: 64bit start address
- * @size: size in bytes
- */
-struct iwl_fragment_data {
-	__le64 address;
-	__le32 size;
-} __packed; /* FRAGMENT_STRUCTURE_API_S_VER_1 */
-
-/**
- * struct iwl_buffer_allocation_cmd - buffer allocation command structure
- * @allocation_id: id of the allocation
- * @buffer_location: location of the buffer
- * @num_frags: number of fragments
- * @fragments: memory fragments
- */
-struct iwl_buffer_allocation_cmd {
-	__le32 allocation_id;
-	__le32 buffer_location;
-	__le32 num_frags;
-	struct iwl_fragment_data fragments[IWL_BUFFER_LOCATION_MAX_FRAGS];
-} __packed; /* BUFFER_ALLOCATION_CMD_API_S_VER_1 */
-
-/**
- * struct iwl_ldbg_config_cmd - LDBG config command
- * @type: configuration type
- * @pad: reserved space for type-dependent data
- */
-struct iwl_ldbg_config_cmd {
-	__le32 type;
-	union {
-		u8 pad[LDBG_CFG_COMMAND_SIZE - sizeof(__le32)];
-		struct iwl_buffer_allocation_cmd buffer_allocation;
-	}; /* LDBG_CFG_BODY_API_U_VER_2 (partially) */
-} __packed; /* LDBG_CFG_CMD_API_S_VER_2 */
-
 /**
  * struct iwl_dbg_suspend_resume_cmd - dbgc suspend resume command
  * @operation: suspend or resume operation, uses
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index b4fba73b5b23..db76b28eac40 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -104,26 +104,6 @@ dbg_ver_table[IWL_DBG_TLV_TYPE_NUM] = {
 	[IWL_DBG_TLV_TYPE_TRIGGER]	= {.min_ver = 1, .max_ver = 1,},
 };
 
-static int iwl_dbg_tlv_copy(struct iwl_ucode_tlv *tlv, struct list_head *list)
-{
-	struct iwl_apply_point_data *tlv_copy;
-	u32 len = le32_to_cpu(tlv->length);
-
-	tlv_copy = kzalloc(sizeof(*tlv_copy) + len, GFP_KERNEL);
-	if (!tlv_copy)
-		return -ENOMEM;
-
-	INIT_LIST_HEAD(&tlv_copy->list);
-	memcpy(&tlv_copy->tlv, tlv, sizeof(*tlv) + len);
-
-	if (!list->next)
-		INIT_LIST_HEAD(list);
-
-	list_add_tail(&tlv_copy->list, list);
-
-	return 0;
-}
-
 static bool iwl_dbg_tlv_ver_support(struct iwl_ucode_tlv *tlv)
 {
 	struct iwl_fw_ini_header *hdr = (void *)&tlv->data[0];
@@ -147,9 +127,6 @@ void iwl_dbg_tlv_alloc(struct iwl_trans *trans, struct iwl_ucode_tlv *tlv,
 	u32 tlv_idx = type - IWL_UCODE_TLV_DEBUG_BASE;
 	enum iwl_ini_cfg_state *cfg_state = ext ?
 		&trans->dbg.external_ini_cfg : &trans->dbg.internal_ini_cfg;
-	struct list_head *dbg_cfg_list = ext ?
-		&trans->dbg.apply_points_ext[pnt].list :
-		&trans->dbg.apply_points[pnt].list;
 
 	IWL_DEBUG_FW(trans, "WRT: read TLV 0x%x, apply point %d\n",
 		     type, pnt);
@@ -159,24 +136,12 @@ void iwl_dbg_tlv_alloc(struct iwl_trans *trans, struct iwl_ucode_tlv *tlv,
 		goto out_err;
 	}
 
-	if (pnt >= IWL_FW_INI_APPLY_NUM) {
-		IWL_ERR(trans, "WRT: Invalid apply point %d\n", pnt);
-		goto out_err;
-	}
-
 	if (!iwl_dbg_tlv_ver_support(tlv)) {
 		IWL_ERR(trans, "WRT: Unsupported TLV 0x%x version %u\n", type,
 			le32_to_cpu(hdr->tlv_version));
 		goto out_err;
 	}
 
-	if (iwl_dbg_tlv_copy(tlv, dbg_cfg_list)) {
-		IWL_ERR(trans,
-			"WRT: Failed to allocate TLV 0x%x, apply point %d\n",
-			type, pnt);
-		goto out_err;
-	}
-
 	if (*cfg_state == IWL_INI_CFG_STATE_NOT_LOADED)
 		*cfg_state = IWL_INI_CFG_STATE_LOADED;
 
@@ -186,33 +151,9 @@ void iwl_dbg_tlv_alloc(struct iwl_trans *trans, struct iwl_ucode_tlv *tlv,
 	*cfg_state = IWL_INI_CFG_STATE_CORRUPTED;
 }
 
-static void iwl_dbg_tlv_free_list(struct list_head *list)
-{
-	if (!list || !list->next)
-		return;
-
-	while (!list_empty(list)) {
-		struct iwl_apply_point_data *node =
-			list_entry(list->next, typeof(*node), list);
-
-		list_del(&node->list);
-		kfree(node);
-	}
-}
-
 void iwl_dbg_tlv_free(struct iwl_trans *trans)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(trans->dbg.apply_points); i++) {
-		struct iwl_apply_point_data *data;
-
-		data = &trans->dbg.apply_points[i];
-		iwl_dbg_tlv_free_list(&data->list);
-
-		data = &trans->dbg.apply_points_ext[i];
-		iwl_dbg_tlv_free_list(&data->list);
-	}
+	/* will be used again later */
 }
 
 static int iwl_dbg_tlv_parse_bin(struct iwl_trans *trans, const u8 *data,
@@ -258,428 +199,10 @@ void iwl_dbg_tlv_load_bin(struct device *dev, struct iwl_trans *trans)
 	release_firmware(fw);
 }
 
-static void
-iwl_dbg_tlv_apply_debug_info(struct iwl_fw_runtime *fwrt,
-			     struct iwl_fw_ini_debug_info_tlv *dbg_info,
-			     bool ext, enum iwl_fw_ini_apply_point pnt)
-{
-	u32 img_name_len = le32_to_cpu(dbg_info->img_name_len);
-	u32 dbg_cfg_name_len = le32_to_cpu(dbg_info->dbg_cfg_name_len);
-	const char err_str[] =
-		"WRT: Invalid %s name length %d, expected %d\n";
-
-	if (img_name_len != IWL_FW_INI_MAX_IMG_NAME_LEN) {
-		IWL_WARN(fwrt, err_str, "image", img_name_len,
-			 IWL_FW_INI_MAX_IMG_NAME_LEN);
-		return;
-	}
-
-	if (dbg_cfg_name_len != IWL_FW_INI_MAX_DBG_CFG_NAME_LEN) {
-		IWL_WARN(fwrt, err_str, "debug cfg", dbg_cfg_name_len,
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
-static void iwl_dbg_tlv_alloc_buffer(struct iwl_fw_runtime *fwrt, u32 size)
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
-static void iwl_dbg_tlv_apply_buffer(struct iwl_fw_runtime *fwrt,
-				     struct iwl_fw_ini_allocation_tlv *alloc,
-				     enum iwl_fw_ini_apply_point pnt)
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
-		iwl_dbg_tlv_alloc_buffer(fwrt, le32_to_cpu(alloc->size));
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
-static void iwl_dbg_tlv_apply_hcmd(struct iwl_fw_runtime *fwrt,
-				   struct iwl_ucode_tlv *tlv)
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
-static void iwl_dbg_tlv_apply_region(struct iwl_fw_runtime *fwrt,
-				     struct iwl_fw_ini_region_tlv *tlv,
-				     enum iwl_fw_ini_apply_point pnt)
+void iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
+			    enum iwl_fw_ini_time_point tp_id,
+			    union iwl_dbg_tlv_tp_data *tp_data)
 {
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
-static int iwl_dbg_tlv_trig_realloc(struct iwl_fw_runtime *fwrt,
-				    struct iwl_fw_ini_active_triggers *active,
-				    u32 id, int size)
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
-static void iwl_dbg_tlv_apply_trigger(struct iwl_fw_runtime *fwrt,
-				      struct iwl_fw_ini_trigger_tlv *tlv,
-				      enum iwl_fw_ini_apply_point apply_point)
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
-			if (iwl_dbg_tlv_trig_realloc(fwrt, active, id,
-						     trig_size))
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
-			if (iwl_dbg_tlv_trig_realloc(fwrt, active, id,
-						     active->size + mem_to_add))
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
-	}
-}
-
-static void _iwl_dbg_tlv_apply_point(struct iwl_fw_runtime *fwrt,
-				     struct iwl_apply_point_data *data,
-				     enum iwl_fw_ini_apply_point pnt,
-				     bool ext)
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
-		const char invalid_ap_str[] =
-			"WRT: Invalid apply point %d for %s\n";
-
-		switch (type) {
-		case IWL_UCODE_TLV_TYPE_DEBUG_INFO:
-			iwl_dbg_tlv_apply_debug_info(fwrt, ini_tlv, ext, pnt);
-			break;
-		case IWL_UCODE_TLV_TYPE_BUFFER_ALLOCATION:
-			if (pnt != IWL_FW_INI_APPLY_EARLY) {
-				IWL_ERR(fwrt, invalid_ap_str, pnt,
-					"buffer allocation");
-				break;
-			}
-			iwl_dbg_tlv_apply_buffer(fwrt, ini_tlv, pnt);
-			break;
-		case IWL_UCODE_TLV_TYPE_HCMD:
-			if (pnt < IWL_FW_INI_APPLY_AFTER_ALIVE) {
-				IWL_ERR(fwrt, invalid_ap_str, pnt,
-					"host command");
-				break;
-			}
-			iwl_dbg_tlv_apply_hcmd(fwrt, tlv);
-			break;
-		case IWL_UCODE_TLV_TYPE_REGIONS:
-			iwl_dbg_tlv_apply_region(fwrt, ini_tlv, pnt);
-			break;
-		case IWL_UCODE_TLV_TYPE_TRIGGERS:
-			iwl_dbg_tlv_apply_trigger(fwrt, ini_tlv, pnt);
-			break;
-		default:
-			WARN_ONCE(1, "WRT: Invalid TLV 0x%x for apply point\n",
-				  type);
-			break;
-		}
-	}
-}
-
-static void iwl_dbg_tlv_reset_cfg(struct iwl_fw_runtime *fwrt)
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
-void iwl_dbg_tlv_apply_point(struct iwl_fw_runtime *fwrt,
-			     enum iwl_fw_ini_apply_point apply_point)
-{
-	void *data;
-
-	if (apply_point == IWL_FW_INI_APPLY_EARLY)
-		iwl_dbg_tlv_reset_cfg(fwrt);
-
-	if (fwrt->trans->dbg.internal_ini_cfg != IWL_INI_CFG_STATE_NOT_LOADED) {
-		IWL_DEBUG_FW(fwrt,
-			     "WRT: Enabling internal configuration apply point %d\n",
-			     apply_point);
-		data = &fwrt->trans->dbg.apply_points[apply_point];
-		_iwl_dbg_tlv_apply_point(fwrt, data, apply_point, false);
-	}
-
-	if (fwrt->trans->dbg.external_ini_cfg != IWL_INI_CFG_STATE_NOT_LOADED) {
-		IWL_DEBUG_FW(fwrt,
-			     "WRT: Enabling external configuration apply point %d\n",
-			     apply_point);
-		data = &fwrt->trans->dbg.apply_points_ext[apply_point];
-		_iwl_dbg_tlv_apply_point(fwrt, data, apply_point, true);
-	}
+	/* will be used later */
 }
-IWL_EXPORT_SYMBOL(iwl_dbg_tlv_apply_point);
+IWL_EXPORT_SYMBOL(iwl_dbg_tlv_time_point);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
index 93496945d313..c7988b6a209a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
@@ -74,6 +74,14 @@ struct iwl_apply_point_data {
 	struct iwl_ucode_tlv tlv;
 };
 
+/**
+ * union iwl_dbg_tlv_tp_data - data that is given in a time point
+ * @fw_pkt: a packet received from the FW
+ */
+union iwl_dbg_tlv_tp_data {
+	struct iwl_rx_packet *fw_pkt;
+};
+
 struct iwl_trans;
 struct iwl_fw_runtime;
 
@@ -81,7 +89,8 @@ void iwl_dbg_tlv_load_bin(struct device *dev, struct iwl_trans *trans);
 void iwl_dbg_tlv_free(struct iwl_trans *trans);
 void iwl_dbg_tlv_alloc(struct iwl_trans *trans, struct iwl_ucode_tlv *tlv,
 		       bool ext);
-void iwl_dbg_tlv_apply_point(struct iwl_fw_runtime *fwrt,
-			     enum iwl_fw_ini_apply_point apply_point);
+void iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
+			    enum iwl_fw_ini_time_point tp_id,
+			    union iwl_dbg_tlv_tp_data *tp_data);
 
 #endif /* __iwl_dbg_tlv_h__*/
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index b6c79f45d1ec..a31408188ed0 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -708,7 +708,6 @@ struct iwl_self_init_dram {
  * @external_ini_cfg: external debug cfg state. Uses &enum iwl_ini_cfg_state
  * @num_blocks: number of blocks in fw_mon
  * @fw_mon: address of the buffers for firmware monitor
- * @is_alloc: bit i is set if buffer i was allocated
  * @hw_error: equals true if hw error interrupt was received from the FW
  * @ini_dest: debug monitor destination uses &enum iwl_fw_ini_buffer_location
  */
@@ -727,12 +726,8 @@ struct iwl_trans_debug {
 	enum iwl_ini_cfg_state internal_ini_cfg;
 	enum iwl_ini_cfg_state external_ini_cfg;
 
-	struct iwl_apply_point_data apply_points[IWL_FW_INI_APPLY_NUM];
-	struct iwl_apply_point_data apply_points_ext[IWL_FW_INI_APPLY_NUM];
-
 	int num_blocks;
 	struct iwl_dram_data fw_mon[IWL_FW_INI_ALLOCATION_NUM];
-	u32 is_alloc;
 
 	bool hw_error;
 	enum iwl_fw_ini_buffer_location ini_dest;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index f93d50ceca68..014eca6596e2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -431,7 +431,7 @@ static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm, bool read_nvm)
 				   iwl_wait_init_complete,
 				   NULL);
 
-	iwl_dbg_tlv_apply_point(&mvm->fwrt, IWL_FW_INI_APPLY_EARLY);
+	iwl_dbg_tlv_time_point(&mvm->fwrt, IWL_FW_INI_TIME_POINT_EARLY, NULL);
 
 	/* Will also start the device */
 	ret = iwl_mvm_load_ucode_wait_alive(mvm, IWL_UCODE_REGULAR);
@@ -439,7 +439,8 @@ static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm, bool read_nvm)
 		IWL_ERR(mvm, "Failed to start RT ucode: %d\n", ret);
 		goto error;
 	}
-	iwl_dbg_tlv_apply_point(&mvm->fwrt, IWL_FW_INI_APPLY_AFTER_ALIVE);
+	iwl_dbg_tlv_time_point(&mvm->fwrt, IWL_FW_INI_TIME_POINT_AFTER_ALIVE,
+			       NULL);
 
 	/* Send init config command to mark that we are sending NVM access
 	 * commands
@@ -1264,7 +1265,7 @@ static int iwl_mvm_load_rt_fw(struct iwl_mvm *mvm)
 	if (ret)
 		return ret;
 
-	iwl_dbg_tlv_apply_point(&mvm->fwrt, IWL_FW_INI_APPLY_EARLY);
+	iwl_dbg_tlv_time_point(&mvm->fwrt, IWL_FW_INI_TIME_POINT_EARLY, NULL);
 
 	mvm->rfkill_safe_init_done = false;
 	ret = iwl_mvm_load_ucode_wait_alive(mvm, IWL_UCODE_REGULAR);
@@ -1273,7 +1274,8 @@ static int iwl_mvm_load_rt_fw(struct iwl_mvm *mvm)
 
 	mvm->rfkill_safe_init_done = true;
 
-	iwl_dbg_tlv_apply_point(&mvm->fwrt, IWL_FW_INI_APPLY_AFTER_ALIVE);
+	iwl_dbg_tlv_time_point(&mvm->fwrt, IWL_FW_INI_TIME_POINT_AFTER_ALIVE,
+			       NULL);
 
 	return iwl_init_paging(&mvm->fwrt, mvm->fwrt.cur_fw_img);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 5ea7f8571dd9..c371945ddf4a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1404,6 +1404,9 @@ void iwl_mvm_rx_missed_beacons_notif(struct iwl_mvm *mvm,
 	else if (rx_missed_bcon_since_rx > IWL_MVM_MISSED_BEACONS_THRESHOLD)
 		ieee80211_beacon_loss(vif);
 
+	iwl_dbg_tlv_time_point(&mvm->fwrt,
+			       IWL_FW_INI_TIME_POINT_MISSED_BEACONS, NULL);
+
 	trigger = iwl_fw_dbg_trigger_on(&mvm->fwrt, ieee80211_vif_to_wdev(vif),
 					FW_DBG_TRIGGER_MISSED_BEACONS);
 	if (!trigger)
@@ -1420,8 +1423,6 @@ void iwl_mvm_rx_missed_beacons_notif(struct iwl_mvm *mvm,
 	    rx_missed_bcon >= stop_trig_missed_bcon)
 		iwl_fw_dbg_collect_trig(&mvm->fwrt, trigger, NULL);
 
-	iwl_dbg_tlv_apply_point(&mvm->fwrt, IWL_FW_INI_APPLY_MISSED_BEACONS);
-
 out:
 	rcu_read_unlock();
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 003a02bf79e0..11b24d143cb6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1106,7 +1106,10 @@ int __iwl_mvm_mac_start(struct iwl_mvm *mvm)
 	}
 	ret = iwl_mvm_up(mvm);
 
-	iwl_dbg_tlv_apply_point(&mvm->fwrt, IWL_FW_INI_APPLY_POST_INIT);
+	iwl_dbg_tlv_time_point(&mvm->fwrt, IWL_FW_INI_TIME_POINT_POST_INIT,
+			       NULL);
+	iwl_dbg_tlv_time_point(&mvm->fwrt, IWL_FW_INI_TIME_POINT_PERIODIC,
+			       NULL);
 
 	if (ret && test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
 		/* Something went wrong - we need to finish some cleanup
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 961c7ab7950b..28e836a55119 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -753,9 +753,6 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		trans_cfg.rx_buf_size = rb_size_default;
 	}
 
-	BUILD_BUG_ON(sizeof(struct iwl_ldbg_config_cmd) !=
-		     LDBG_CFG_COMMAND_SIZE);
-
 	trans->wide_cmd_header = true;
 	trans_cfg.bc_table_dword =
 		mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_22560;
@@ -990,7 +987,10 @@ static void iwl_mvm_rx_common(struct iwl_mvm *mvm,
 			      struct iwl_rx_packet *pkt)
 {
 	int i;
+	union iwl_dbg_tlv_tp_data tp_data = { .fw_pkt = pkt };
 
+	iwl_dbg_tlv_time_point(&mvm->fwrt,
+			       IWL_FW_INI_TIME_POINT_FW_RSP_OR_NOTIF, &tp_data);
 	iwl_mvm_rx_check_trigger(mvm, pkt);
 
 	/*
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 892db3dcdc27..f6b3045badbd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1939,8 +1939,6 @@ void iwl_mvm_rx_umac_scan_complete_notif(struct iwl_mvm *mvm,
 		mvm->last_ebs_successful = false;
 
 	mvm->scan_uid_status[uid] = 0;
-
-	iwl_dbg_tlv_apply_point(&mvm->fwrt, IWL_FW_INI_APPLY_SCAN_COMPLETE);
 }
 
 void iwl_mvm_rx_umac_scan_iter_complete_notif(struct iwl_mvm *mvm,
-- 
2.23.0.rc1

