Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A064A97B24
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 15:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfHUNkR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 09:40:17 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:37878 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726484AbfHUNkR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 09:40:17 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i0Qoc-0000lZ-0c; Wed, 21 Aug 2019 16:38:18 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 21 Aug 2019 16:37:58 +0300
Message-Id: <20190821133800.23636-17-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190821133800.23636-1-luca@coelho.fi>
References: <20190821133800.23636-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 16/18] iwlwifi: dbg_ini: maintain buffer allocations from trans instead of TLVs buffer
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Maintain DRAM debug buffer status in trans instead of keeping it as
part of the TLVs buffer to avoid allocating extra space for it.
Needed for future changes.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  2 ++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 31 ++++++++++---------
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |  9 ------
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 18 -----------
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  4 ++-
 5 files changed, 21 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index aaf3974a9a20..e02e289d29b1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -439,6 +439,7 @@ enum iwl_fw_ini_apply_point {
  * @IWL_FW_INI_ALLOCATION_ID_SDFX: for SDFX module
  * @IWL_FW_INI_ALLOCATION_ID_FW_DUMP: used for crash and runtime dumps
  * @IWL_FW_INI_ALLOCATION_ID_USER_DEFINED: for future user scenarios
+ * @IWL_FW_INI_ALLOCATION_NUM: number of allocation ids
 */
 enum iwl_fw_ini_allocation_id {
 	IWL_FW_INI_ALLOCATION_INVALID,
@@ -448,6 +449,7 @@ enum iwl_fw_ini_allocation_id {
 	IWL_FW_INI_ALLOCATION_ID_SDFX,
 	IWL_FW_INI_ALLOCATION_ID_FW_DUMP,
 	IWL_FW_INI_ALLOCATION_ID_USER_DEFINED,
+	IWL_FW_INI_ALLOCATION_NUM,
 }; /* FW_DEBUG_TLV_ALLOCATION_ID_E_VER_1 */
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 40b867f984cf..6d69ed17e7f8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2503,7 +2503,7 @@ iwl_fw_dbg_buffer_allocation(struct iwl_fw_runtime *fwrt, u32 size)
 }
 
 static void iwl_fw_dbg_buffer_apply(struct iwl_fw_runtime *fwrt,
-				    struct iwl_fw_ini_allocation_data *alloc,
+				    struct iwl_fw_ini_allocation_tlv *alloc,
 				    enum iwl_fw_ini_apply_point pnt)
 {
 	struct iwl_trans *trans = fwrt->trans;
@@ -2518,7 +2518,14 @@ static void iwl_fw_dbg_buffer_apply(struct iwl_fw_runtime *fwrt,
 		.len[0] = sizeof(ldbg_cmd),
 	};
 	int block_idx = trans->dbg.num_blocks;
-	u32 buf_location = le32_to_cpu(alloc->tlv.buffer_location);
+	u32 buf_location = le32_to_cpu(alloc->buffer_location);
+	u32 alloc_id = le32_to_cpu(alloc->allocation_id);
+
+	if (alloc_id <= IWL_FW_INI_ALLOCATION_INVALID ||
+	    alloc_id >= IWL_FW_INI_ALLOCATION_NUM) {
+		IWL_ERR(fwrt, "WRT: Invalid allocation id %d\n", alloc_id);
+		return;
+	}
 
 	if (fwrt->trans->dbg.ini_dest == IWL_FW_INI_LOCATION_INVALID)
 		fwrt->trans->dbg.ini_dest = buf_location;
@@ -2543,12 +2550,11 @@ static void iwl_fw_dbg_buffer_apply(struct iwl_fw_runtime *fwrt,
 	if (buf_location != IWL_FW_INI_LOCATION_DRAM_PATH)
 		return;
 
-	if (!alloc->is_alloc) {
-		iwl_fw_dbg_buffer_allocation(fwrt,
-					     le32_to_cpu(alloc->tlv.size));
+	if (!(BIT(alloc_id) & fwrt->trans->dbg.is_alloc)) {
+		iwl_fw_dbg_buffer_allocation(fwrt, le32_to_cpu(alloc->size));
 		if (block_idx == trans->dbg.num_blocks)
 			return;
-		alloc->is_alloc = 1;
+		fwrt->trans->dbg.is_alloc |= BIT(alloc_id);
 	}
 
 	/* First block is assigned via registers / context info */
@@ -2561,9 +2567,9 @@ static void iwl_fw_dbg_buffer_apply(struct iwl_fw_runtime *fwrt,
 	cmd->num_frags = cpu_to_le32(1);
 	cmd->fragments[0].address =
 		cpu_to_le64(trans->dbg.fw_mon[block_idx].physical);
-	cmd->fragments[0].size = alloc->tlv.size;
-	cmd->allocation_id = alloc->tlv.allocation_id;
-	cmd->buffer_location = alloc->tlv.buffer_location;
+	cmd->fragments[0].size = alloc->size;
+	cmd->allocation_id = alloc->allocation_id;
+	cmd->buffer_location = alloc->buffer_location;
 
 	iwl_trans_send_cmd(trans, &hcmd);
 }
@@ -2788,20 +2794,15 @@ static void _iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
 		case IWL_UCODE_TLV_TYPE_DEBUG_INFO:
 			iwl_fw_dbg_info_apply(fwrt, ini_tlv, ext, pnt);
 			break;
-		case IWL_UCODE_TLV_TYPE_BUFFER_ALLOCATION: {
-			struct iwl_fw_ini_allocation_data *buf_alloc = ini_tlv;
-
+		case IWL_UCODE_TLV_TYPE_BUFFER_ALLOCATION:
 			if (pnt != IWL_FW_INI_APPLY_EARLY) {
 				IWL_ERR(fwrt,
 					"WRT: ext=%d. Invalid apply point %d for buffer allocation\n",
 					ext, pnt);
 				goto next;
 			}
-
 			iwl_fw_dbg_buffer_apply(fwrt, ini_tlv, pnt);
-			iter += sizeof(buf_alloc->is_alloc);
 			break;
-		}
 		case IWL_UCODE_TLV_TYPE_HCMD:
 			if (pnt < IWL_FW_INI_APPLY_AFTER_ALIVE) {
 				IWL_ERR(fwrt,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.h b/drivers/net/wireless/intel/iwlwifi/fw/img.h
index 18ca5f152be6..039576d71276 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.h
@@ -227,15 +227,6 @@ struct iwl_fw_dbg {
 	u32 dump_mask;
 };
 
-/**
- * @tlv: the buffer allocation tlv
- * @is_alloc: indicates if the buffer was already allocated
- */
-struct iwl_fw_ini_allocation_data {
-	struct iwl_fw_ini_allocation_tlv tlv;
-	u32 is_alloc;
-} __packed;
-
 /**
  * struct iwl_fw_ini_active_triggers
  * @active: is this trigger active
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 240e48b1d1c7..5948d769eed0 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -85,14 +85,6 @@ void iwl_dbg_tlv_copy(struct iwl_trans *trans, struct iwl_ucode_tlv *tlv,
 	else
 		data = &trans->dbg.apply_points[apply_point];
 
-	/* add room for is_alloc field in &iwl_fw_ini_allocation_data struct */
-	if (le32_to_cpu(tlv->type) == IWL_UCODE_TLV_TYPE_BUFFER_ALLOCATION) {
-		struct iwl_fw_ini_allocation_data *buf_alloc =
-			(void *)tlv->data;
-
-		offset_size += sizeof(buf_alloc->is_alloc);
-	}
-
 	/*
 	 * Make sure we still have room to copy this TLV. Offset points to the
 	 * location the last copy ended.
@@ -145,16 +137,6 @@ void iwl_dbg_tlv_alloc(struct iwl_trans *trans, size_t len, const u8 *data,
 		if (WARN_ON(apply >= IWL_FW_INI_APPLY_NUM))
 			continue;
 
-		/* add room for is_alloc field in &iwl_fw_ini_allocation_data
-		 * struct
-		 */
-		if (tlv_type == IWL_UCODE_TLV_TYPE_BUFFER_ALLOCATION) {
-			struct iwl_fw_ini_allocation_data *buf_alloc =
-				(void *)tlv->data;
-
-			size[apply] += sizeof(buf_alloc->is_alloc);
-		}
-
 		size[apply] += sizeof(*tlv) + tlv_len;
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index fce0112b3ad4..0fa4b100f109 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -695,6 +695,7 @@ struct iwl_self_init_dram {
  * @ini_valid: indicates if debug ini mode is on
  * @num_blocks: number of blocks in fw_mon
  * @fw_mon: address of the buffers for firmware monitor
+ * @is_alloc: bit i is set if buffer i was allocated
  * @hw_error: equals true if hw error interrupt was received from the FW
  * @ini_dest: debug monitor destination uses &enum iwl_fw_ini_buffer_location
  */
@@ -717,7 +718,8 @@ struct iwl_trans_debug {
 	struct iwl_apply_point_data apply_points_ext[IWL_FW_INI_APPLY_NUM];
 
 	int num_blocks;
-	struct iwl_dram_data fw_mon[IWL_FW_INI_APPLY_NUM];
+	struct iwl_dram_data fw_mon[IWL_FW_INI_ALLOCATION_NUM];
+	u32 is_alloc;
 
 	bool hw_error;
 	enum iwl_fw_ini_buffer_location ini_dest;
-- 
2.23.0.rc1

