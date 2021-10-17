Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E0B430786
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 11:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245168AbhJQJmg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 05:42:36 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53658 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245117AbhJQJmf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 05:42:35 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc2eW-000YUg-4u; Sun, 17 Oct 2021 12:40:24 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 12:40:11 +0300
Message-Id: <iwlwifi.20211017123741.360cc8fe55b1.Ie3bd3ece38043969f7e116e61a6ec1197a58d78b@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017094019.442271-1-luca@coelho.fi>
References: <20211017094019.442271-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 04/12] iwlwifi: fw dump: add infrastructure for dump scrubbing
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In firmware dumps, currently all kinds of key material may be
included, e.g. in host commands (if firmware crashes during the
processing of a key-related command) or in the TX FIFO(s) if
we have been using in-TX-command key material.

Additionally, some firmware versions will advertise sections
of their internal data to not dump, due to them containing some
sensitive data.

Add some infrastructure to allow scrubbing this data out, as
dependent on the opmode's idea of what will need to be done.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  1 +
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 44 +++++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |  2 +
 drivers/net/wireless/intel/iwlwifi/fw/init.c  |  6 ++-
 .../net/wireless/intel/iwlwifi/fw/paging.c    |  4 +-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  5 +++
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 25 +++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  2 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 12 +++--
 9 files changed, 89 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index d8b5870d6e9a..6ab5755beb53 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -7,6 +7,7 @@
 
 #include <linux/bitops.h>
 
+#define IWL_FW_INI_HW_SMEM_REGION_ID		15
 #define IWL_FW_INI_MAX_REGION_ID		64
 #define IWL_FW_INI_MAX_NAME			32
 #define IWL_FW_INI_MAX_CFG_NAME			64
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 6dcafd0a3d4b..6a03cdbee489 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -159,11 +159,15 @@ static void iwl_fwrt_dump_txf(struct iwl_fw_runtime *fwrt,
 	iwl_trans_read_prph(fwrt->trans, TXF_READ_MODIFY_DATA + offset);
 
 	/* Read FIFO */
-	fifo_len /= sizeof(u32); /* Size in DWORDS */
-	for (i = 0; i < fifo_len; i++)
+	for (i = 0; i < fifo_len / sizeof(u32); i++)
 		fifo_data[i] = iwl_trans_read_prph(fwrt->trans,
 						  TXF_READ_MODIFY_DATA +
 						  offset);
+
+	if (fwrt->sanitize_ops && fwrt->sanitize_ops->frob_txf)
+		fwrt->sanitize_ops->frob_txf(fwrt->sanitize_ctx,
+					     fifo_data, fifo_len);
+
 	*dump_data = iwl_fw_error_next_data(*dump_data);
 }
 
@@ -659,6 +663,10 @@ static void iwl_fw_dump_mem(struct iwl_fw_runtime *fwrt,
 	iwl_trans_read_mem_bytes(fwrt->trans, ofs, dump_mem->data, len);
 	*dump_data = iwl_fw_error_next_data(*dump_data);
 
+	if (fwrt->sanitize_ops && fwrt->sanitize_ops->frob_mem)
+		fwrt->sanitize_ops->frob_mem(fwrt->sanitize_ctx, ofs,
+					     dump_mem->data, len);
+
 	IWL_DEBUG_INFO(fwrt, "WRT memory dump. Type=%u\n", dump_mem->type);
 }
 
@@ -752,6 +760,12 @@ static void iwl_dump_paging(struct iwl_fw_runtime *fwrt,
 					   PAGING_BLOCK_SIZE,
 					   DMA_BIDIRECTIONAL);
 		(*data) = iwl_fw_error_next_data(*data);
+
+		if (fwrt->sanitize_ops && fwrt->sanitize_ops->frob_mem)
+			fwrt->sanitize_ops->frob_mem(fwrt->sanitize_ctx,
+						     fwrt->fw_paging_db[i].fw_offs,
+						     paging->data,
+						     PAGING_BLOCK_SIZE);
 	}
 }
 
@@ -980,6 +994,11 @@ iwl_fw_error_dump_file(struct iwl_fw_runtime *fwrt,
 					 dump_data->data + data_size,
 					 data_size);
 
+		if (fwrt->sanitize_ops && fwrt->sanitize_ops->frob_mem)
+			fwrt->sanitize_ops->frob_mem(fwrt->sanitize_ctx, addr,
+						     dump_data->data + data_size,
+						     data_size);
+
 		dump_data = iwl_fw_error_next_data(dump_data);
 	}
 
@@ -1146,6 +1165,13 @@ static int iwl_dump_ini_dev_mem_iter(struct iwl_fw_runtime *fwrt,
 	iwl_trans_read_mem_bytes(fwrt->trans, addr, range->data,
 				 le32_to_cpu(reg->dev_addr.size));
 
+	if ((le32_to_cpu(reg->id) & IWL_FW_INI_REGION_V2_MASK) ==
+		IWL_FW_INI_HW_SMEM_REGION_ID &&
+	    fwrt->sanitize_ops && fwrt->sanitize_ops->frob_txf)
+		fwrt->sanitize_ops->frob_txf(fwrt->sanitize_ctx,
+					     range->data,
+					     le32_to_cpu(reg->dev_addr.size));
+
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
 
@@ -1338,6 +1364,10 @@ static int iwl_dump_ini_txf_iter(struct iwl_fw_runtime *fwrt,
 	for (i = 0; i < iter->fifo_size; i += sizeof(*data))
 		*data++ = cpu_to_le32(iwl_read_prph_no_grab(fwrt->trans, addr));
 
+	if (fwrt->sanitize_ops && fwrt->sanitize_ops->frob_txf)
+		fwrt->sanitize_ops->frob_txf(fwrt->sanitize_ctx,
+					     reg_dump, iter->fifo_size);
+
 out:
 	iwl_trans_release_nic_access(fwrt->trans);
 
@@ -2360,7 +2390,9 @@ static void iwl_fw_error_dump(struct iwl_fw_runtime *fwrt,
 	if (dump_data->monitor_only)
 		dump_mask &= BIT(IWL_FW_ERROR_DUMP_FW_MONITOR);
 
-	fw_error_dump.trans_ptr = iwl_trans_dump_data(fwrt->trans, dump_mask);
+	fw_error_dump.trans_ptr = iwl_trans_dump_data(fwrt->trans, dump_mask,
+						      fwrt->sanitize_ops,
+						      fwrt->sanitize_ctx);
 	file_len = le32_to_cpu(dump_file->file_len);
 	fw_error_dump.fwrt_len = file_len;
 
@@ -2788,6 +2820,12 @@ void iwl_fw_dbg_read_d3_debug_data(struct iwl_fw_runtime *fwrt)
 	iwl_trans_read_mem_bytes(fwrt->trans, cfg->d3_debug_data_base_addr,
 				 fwrt->dump.d3_debug_data,
 				 cfg->d3_debug_data_length);
+
+	if (fwrt->sanitize_ops && fwrt->sanitize_ops->frob_mem)
+		fwrt->sanitize_ops->frob_mem(fwrt->sanitize_ctx,
+					     cfg->d3_debug_data_base_addr,
+					     fwrt->dump.d3_debug_data,
+					     cfg->d3_debug_data_length);
 }
 IWL_EXPORT_SYMBOL(iwl_fw_dbg_read_d3_debug_data);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.h b/drivers/net/wireless/intel/iwlwifi/fw/img.h
index 21a206631b2f..6099d1edaff2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.h
@@ -124,11 +124,13 @@ struct fw_img {
  * @fw_paging_phys: page phy pointer
  * @fw_paging_block: pointer to the allocated block
  * @fw_paging_size: page size
+ * @fw_offs: offset in the device
  */
 struct iwl_fw_paging {
 	dma_addr_t fw_paging_phys;
 	struct page *fw_paging_block;
 	u32 fw_paging_size;
+	u32 fw_offs;
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/init.c b/drivers/net/wireless/intel/iwlwifi/fw/init.c
index 2ecec00db9da..566957ac4539 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/init.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/init.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2019-2020 Intel Corporation
+ * Copyright (C) 2019-2021 Intel Corporation
  */
 #include "iwl-drv.h"
 #include "runtime.h"
@@ -16,6 +16,8 @@
 void iwl_fw_runtime_init(struct iwl_fw_runtime *fwrt, struct iwl_trans *trans,
 			const struct iwl_fw *fw,
 			const struct iwl_fw_runtime_ops *ops, void *ops_ctx,
+			const struct iwl_dump_sanitize_ops *sanitize_ops,
+			void *sanitize_ctx,
 			struct dentry *dbgfs_dir)
 {
 	int i;
@@ -26,6 +28,8 @@ void iwl_fw_runtime_init(struct iwl_fw_runtime *fwrt, struct iwl_trans *trans,
 	fwrt->dev = trans->dev;
 	fwrt->dump.conf = FW_DBG_INVALID;
 	fwrt->ops = ops;
+	fwrt->sanitize_ops = sanitize_ops;
+	fwrt->sanitize_ctx = sanitize_ctx;
 	fwrt->ops_ctx = ops_ctx;
 	for (i = 0; i < IWL_FW_RUNTIME_DUMP_WK_NUM; i++) {
 		fwrt->dump.wks[i].idx = i;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/paging.c b/drivers/net/wireless/intel/iwlwifi/fw/paging.c
index 4a8fe9641a32..58ca3849d1f3 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/paging.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/paging.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2019 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2019, 2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -152,6 +152,7 @@ static int iwl_fill_paging_mem(struct iwl_fw_runtime *fwrt,
 	memcpy(page_address(fwrt->fw_paging_db[0].fw_paging_block),
 	       image->sec[sec_idx].data,
 	       image->sec[sec_idx].len);
+	fwrt->fw_paging_db[0].fw_offs = image->sec[sec_idx].offset;
 	dma_sync_single_for_device(fwrt->trans->dev,
 				   fwrt->fw_paging_db[0].fw_paging_phys,
 				   fwrt->fw_paging_db[0].fw_paging_size,
@@ -197,6 +198,7 @@ static int iwl_fill_paging_mem(struct iwl_fw_runtime *fwrt,
 
 		memcpy(page_address(block->fw_paging_block),
 		       image->sec[sec_idx].data + offset, len);
+		block->fw_offs = image->sec[sec_idx].offset + offset;
 		dma_sync_single_for_device(fwrt->trans->dev,
 					   block->fw_paging_phys,
 					   block->fw_paging_size,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 35af85a5430b..a569ce3c5e96 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -105,6 +105,9 @@ struct iwl_fw_runtime {
 	const struct iwl_fw_runtime_ops *ops;
 	void *ops_ctx;
 
+	const struct iwl_dump_sanitize_ops *sanitize_ops;
+	void *sanitize_ctx;
+
 	/* Paging */
 	struct iwl_fw_paging fw_paging_db[NUM_OF_FW_PAGING_BLOCKS];
 	u16 num_of_paging_blk;
@@ -161,6 +164,8 @@ struct iwl_fw_runtime {
 void iwl_fw_runtime_init(struct iwl_fw_runtime *fwrt, struct iwl_trans *trans,
 			const struct iwl_fw *fw,
 			const struct iwl_fw_runtime_ops *ops, void *ops_ctx,
+			const struct iwl_dump_sanitize_ops *sanitize_ops,
+			void *sanitize_ctx,
 			struct dentry *dbgfs_dir);
 
 static inline void iwl_fw_runtime_free(struct iwl_fw_runtime *fwrt)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 8f0ff540f439..32d228d7e1fe 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -362,6 +362,20 @@ struct iwl_hcmd_arr {
 #define HCMD_ARR(x)	\
 	{ .arr = x, .size = ARRAY_SIZE(x) }
 
+/**
+ * struct iwl_dump_sanitize_ops - dump sanitization operations
+ * @frob_txf: Scrub the TX FIFO data
+ * @frob_hcmd: Scrub a host command, the %hcmd pointer is to the header
+ *	but that might be short or long (&struct iwl_cmd_header or
+ *	&struct iwl_cmd_header_wide)
+ * @frob_mem: Scrub memory data
+ */
+struct iwl_dump_sanitize_ops {
+	void (*frob_txf)(void *ctx, void *buf, size_t buflen);
+	void (*frob_hcmd)(void *ctx, void *hcmd, size_t buflen);
+	void (*frob_mem)(void *ctx, u32 mem_addr, void *mem, size_t buflen);
+};
+
 /**
  * struct iwl_trans_config - transport configuration
  *
@@ -586,7 +600,9 @@ struct iwl_trans_ops {
 			      u32 value);
 
 	struct iwl_trans_dump_data *(*dump_data)(struct iwl_trans *trans,
-						 u32 dump_mask);
+						 u32 dump_mask,
+						 const struct iwl_dump_sanitize_ops *sanitize_ops,
+						 void *sanitize_ctx);
 	void (*debugfs_cleanup)(struct iwl_trans *trans);
 	void (*sync_nmi)(struct iwl_trans *trans);
 	int (*set_pnvm)(struct iwl_trans *trans, const void *data, u32 len);
@@ -1086,11 +1102,14 @@ static inline int iwl_trans_d3_resume(struct iwl_trans *trans,
 }
 
 static inline struct iwl_trans_dump_data *
-iwl_trans_dump_data(struct iwl_trans *trans, u32 dump_mask)
+iwl_trans_dump_data(struct iwl_trans *trans, u32 dump_mask,
+		    const struct iwl_dump_sanitize_ops *sanitize_ops,
+		    void *sanitize_ctx)
 {
 	if (!trans->ops->dump_data)
 		return NULL;
-	return trans->ops->dump_data(trans, dump_mask);
+	return trans->ops->dump_data(trans, dump_mask,
+				     sanitize_ops, sanitize_ctx);
 }
 
 static inline struct iwl_device_tx_cmd *
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index c7ae284ae96d..b7f203fe7753 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -774,7 +774,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	mvm->hw = hw;
 
 	iwl_fw_runtime_init(&mvm->fwrt, trans, fw, &iwl_mvm_fwrt_ops, mvm,
-			    dbgfs_dir);
+			    NULL, NULL, dbgfs_dir);
 
 	iwl_mvm_get_acpi_tables(mvm);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index f252680f18e8..9e462633af55 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3203,9 +3203,11 @@ static int iwl_trans_get_fw_monitor_len(struct iwl_trans *trans, u32 *len)
 	return 0;
 }
 
-static struct iwl_trans_dump_data
-*iwl_trans_pcie_dump_data(struct iwl_trans *trans,
-			  u32 dump_mask)
+static struct iwl_trans_dump_data *
+iwl_trans_pcie_dump_data(struct iwl_trans *trans,
+			 u32 dump_mask,
+			 const struct iwl_dump_sanitize_ops *sanitize_ops,
+			 void *sanitize_ctx)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_fw_error_dump_data *data;
@@ -3305,6 +3307,10 @@ static struct iwl_trans_dump_data
 				txcmd->caplen = cpu_to_le32(caplen);
 				memcpy(txcmd->data, cmdq->entries[idx].cmd,
 				       caplen);
+				if (sanitize_ops && sanitize_ops->frob_hcmd)
+					sanitize_ops->frob_hcmd(sanitize_ctx,
+								txcmd->data,
+								caplen);
 				txcmd = (void *)((u8 *)txcmd->data + caplen);
 			}
 
-- 
2.33.0

