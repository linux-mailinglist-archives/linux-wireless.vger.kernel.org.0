Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F392876E9
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 17:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbgJHPOd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 11:14:33 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54650 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730650AbgJHPOd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 11:14:33 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kQXbJ-002QxQ-BQ; Thu, 08 Oct 2020 18:13:01 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  8 Oct 2020 18:12:48 +0300
Message-Id: <iwlwifi.20201008181047.85847cfb0972.I202d90e99779f722df14b2d4102d3e466343a6f6@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008151250.332346-1-luca@coelho.fi>
References: <20201008151250.332346-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 11/13] iwlwifi: pcie: implement set_pnvm op
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Implement the set_pnvm op to store the PNVM settings to the context
info and the corresponding code to free the DRAM block when the
context is freed.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../intel/iwlwifi/iwl-context-info-gen3.h     |  3 ++
 .../wireless/intel/iwlwifi/iwl-context-info.h |  7 ++--
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       | 33 +++++++++++++++++++
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   | 21 +++++++-----
 .../wireless/intel/iwlwifi/pcie/internal.h    |  3 ++
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  2 ++
 6 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
index 983e5b2859b3..5624fe42efd9 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
@@ -291,4 +291,7 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 				 const struct fw_img *fw);
 void iwl_pcie_ctxt_info_gen3_free(struct iwl_trans *trans);
 
+int iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans,
+					  const void *data, u32 len);
+
 #endif /* __iwl_context_info_file_gen3_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
index eeaa8cbdddce..76b7bbdf8393 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
@@ -6,7 +6,7 @@
  * GPL LICENSE SUMMARY
  *
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -20,7 +20,7 @@
  * BSD LICENSE
  *
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -225,5 +225,8 @@ void iwl_pcie_ctxt_info_free_paging(struct iwl_trans *trans);
 int iwl_pcie_init_fw_sec(struct iwl_trans *trans,
 			 const struct fw_img *fw,
 			 struct iwl_context_info_dram *ctxt_dram);
+int iwl_pcie_ctxt_info_alloc_dma(struct iwl_trans *trans,
+				 const void *data, u32 len,
+				 struct iwl_dram_data *dram);
 
 #endif /* __iwl_context_info_file_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index 1ab136600415..546a24408c63 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -300,4 +300,37 @@ void iwl_pcie_ctxt_info_gen3_free(struct iwl_trans *trans)
 			  trans_pcie->prph_info_dma_addr);
 	trans_pcie->prph_info_dma_addr = 0;
 	trans_pcie->prph_info = NULL;
+	dma_free_coherent(trans->dev, trans_pcie->pnvm_dram.size,
+			  trans_pcie->pnvm_dram.block,
+			  trans_pcie->pnvm_dram.physical);
+	trans_pcie->pnvm_dram.size = 0;
+	trans_pcie->pnvm_dram.block = NULL;
+	trans_pcie->pnvm_dram.physical = 0;
+}
+
+int iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans,
+					  const void *data, u32 len)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwl_prph_scratch_ctrl_cfg *prph_sc_ctrl =
+		&trans_pcie->prph_scratch->ctrl_cfg;
+	int ret;
+
+	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
+		return 0;
+
+	ret = iwl_pcie_ctxt_info_alloc_dma(trans, data, len,
+					   &trans_pcie->pnvm_dram);
+	if (ret < 0) {
+		IWL_DEBUG_FW(trans, "Failed to allocate PNVM DMA %d.\n",
+			     ret);
+		return ret;
+	}
+
+	prph_sc_ctrl->pnvm_cfg.pnvm_base_addr =
+		cpu_to_le64(trans_pcie->pnvm_dram.physical);
+	prph_sc_ctrl->pnvm_cfg.pnvm_size =
+		cpu_to_le32(trans_pcie->pnvm_dram.size);
+
+	return 0;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
index 2597faea79c4..13fe9c00d7e8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
@@ -93,17 +93,17 @@ static void *iwl_pcie_ctxt_info_dma_alloc_coherent(struct iwl_trans *trans,
 	return _iwl_pcie_ctxt_info_dma_alloc_coherent(trans, size, phys, 0);
 }
 
-static int iwl_pcie_ctxt_info_alloc_dma(struct iwl_trans *trans,
-					const struct fw_desc *sec,
-					struct iwl_dram_data *dram)
+int iwl_pcie_ctxt_info_alloc_dma(struct iwl_trans *trans,
+				 const void *data, u32 len,
+				 struct iwl_dram_data *dram)
 {
-	dram->block = iwl_pcie_ctxt_info_dma_alloc_coherent(trans, sec->len,
+	dram->block = iwl_pcie_ctxt_info_dma_alloc_coherent(trans, len,
 							    &dram->physical);
 	if (!dram->block)
 		return -ENOMEM;
 
-	dram->size = sec->len;
-	memcpy(dram->block, sec->data, sec->len);
+	dram->size = len;
+	memcpy(dram->block, data, len);
 
 	return 0;
 }
@@ -156,7 +156,8 @@ int iwl_pcie_init_fw_sec(struct iwl_trans *trans,
 
 	/* initialize lmac sections */
 	for (i = 0; i < lmac_cnt; i++) {
-		ret = iwl_pcie_ctxt_info_alloc_dma(trans, &fw->sec[i],
+		ret = iwl_pcie_ctxt_info_alloc_dma(trans, fw->sec[i].data,
+						   fw->sec[i].len,
 						   &dram->fw[dram->fw_cnt]);
 		if (ret)
 			return ret;
@@ -169,7 +170,8 @@ int iwl_pcie_init_fw_sec(struct iwl_trans *trans,
 	for (i = 0; i < umac_cnt; i++) {
 		/* access FW with +1 to make up for lmac separator */
 		ret = iwl_pcie_ctxt_info_alloc_dma(trans,
-						   &fw->sec[dram->fw_cnt + 1],
+						   fw->sec[dram->fw_cnt + 1].data,
+						   fw->sec[dram->fw_cnt + 1].len,
 						   &dram->fw[dram->fw_cnt]);
 		if (ret)
 			return ret;
@@ -192,7 +194,8 @@ int iwl_pcie_init_fw_sec(struct iwl_trans *trans,
 		/* access FW with +2 to make up for lmac & umac separators */
 		int fw_idx = dram->fw_cnt + i + 2;
 
-		ret = iwl_pcie_ctxt_info_alloc_dma(trans, &fw->sec[fw_idx],
+		ret = iwl_pcie_ctxt_info_alloc_dma(trans, fw->sec[fw_idx].data,
+						   fw->sec[fw_idx].len,
 						   &dram->paging[i]);
 		if (ret)
 			return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 033f845a89dc..ff542d2f0054 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -339,6 +339,7 @@ struct cont_rec {
  * @trans: pointer to the generic transport area
  * @scd_base_addr: scheduler sram base address in SRAM
  * @kw: keep warm address
+ * @pnvm_dram: DRAM area that contains the PNVM data
  * @pci_dev: basic pci-network driver stuff
  * @hw_base: pci hardware address support
  * @ucode_write_complete: indicates that the ucode has been copied.
@@ -410,6 +411,8 @@ struct iwl_trans_pcie {
 	u32 scd_base_addr;
 	struct iwl_dma_ptr kw;
 
+	struct iwl_dram_data pnvm_dram;
+
 	struct iwl_txq *txq_memory;
 
 	/* PCI bus related data */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 4ee8b5dd2512..d25a215d5a04 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -81,6 +81,7 @@
 #include "fw/api/tx.h"
 #include "internal.h"
 #include "iwl-fh.h"
+#include "iwl-context-info-gen3.h"
 
 /* extended range in FW SRAM */
 #define IWL_FW_MEM_EXTENDED_START	0x40000
@@ -3451,6 +3452,7 @@ static const struct iwl_trans_ops trans_ops_pcie_gen2 = {
 	.txq_free = iwl_txq_dyn_free,
 	.wait_txq_empty = iwl_trans_pcie_wait_txq_empty,
 	.rxq_dma_data = iwl_trans_pcie_rxq_dma_data,
+	.set_pnvm = iwl_trans_pcie_ctx_info_gen3_set_pnvm,
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	.debugfs_cleanup = iwl_trans_pcie_debugfs_cleanup,
 #endif
-- 
2.28.0

