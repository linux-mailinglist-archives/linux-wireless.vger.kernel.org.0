Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45987723A7E
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 09:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbjFFHvo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 03:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235767AbjFFHtj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 03:49:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E1D10EC
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 00:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686037494; x=1717573494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w6J84X0QQa8sXPtRC20lIBhZFALAmGqYfvnN66SejRI=;
  b=d+cP7rMymm4htmBGj3aFSVEeXYf++lsAFUBYBpqzD7uryOTgX+qUdOGm
   9/mxCthTakIxiT+tbwK1mclNJw1d/zdQVBBtGEPw2PCr0Nl4wzRek2YkL
   IuAoS+MQjubNXeJrG+knLO6tP+lfqk+RdF2R5NDa6gEwQnL53+ovZbJRV
   o4opq689bc0xq7dyHKXBiYtgf9vOOm+p2V63qI2LrlEo5967v/JeLsxWl
   wYdV+U+a3C+SfO5SGE4ri4IhWTP+E3BGnztgIUbHIQ0+BzPlS/GcyCKgc
   pQWkCAzWGUuL71ScOMNIjchZEbec5Z+LALIuWaXxXxtY9fe0ESFwmxNZA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="422419102"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="422419102"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:43:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821516369"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="821516369"
Received: from oniamir-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.217.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:43:40 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alon Giladi <alon.giladi@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/13] wifi: iwlwifi: Enable loading of reduce-power tables into several segments
Date:   Tue,  6 Jun 2023 10:43:06 +0300
Message-Id: <20230606103519.6fe66958f049.I85d80682229fc02fe354462cc9da40937558f30c@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230606074310.889520-1-gregory.greenman@intel.com>
References: <20230606074310.889520-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Alon Giladi <alon.giladi@intel.com>

Replace the field reduce_power_dram with a struct that holds data about
the reduced-power tables drams regions. Generalize load_payloads_segments()
to work for both pnvm tables and reduction power tables.
Make required adjustments in the data structures.

Signed-off-by: Alon Giladi <alon.giladi@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  |   4 +-
 .../intel/iwlwifi/iwl-context-info-gen3.h     |  17 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  30 +++-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       | 150 +++++++++++++-----
 .../wireless/intel/iwlwifi/pcie/internal.h    |  17 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  31 ++--
 6 files changed, 169 insertions(+), 80 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index 42d994240b31..b556abece896 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -330,7 +330,7 @@ int iwl_pnvm_load(struct iwl_trans *trans,
 			 */
 			trans->reduce_power_loaded = true;
 		} else {
-			ret = iwl_trans_load_reduce_power(trans, &pnvm_data);
+			ret = iwl_trans_load_reduce_power(trans, &pnvm_data, capa);
 			if (ret) {
 				IWL_DEBUG_FW(trans,
 					     "Failed to load reduce power table %d\n",
@@ -340,7 +340,7 @@ int iwl_pnvm_load(struct iwl_trans *trans,
 			kfree(data);
 		}
 	}
-	iwl_trans_set_reduce_power(trans);
+	iwl_trans_set_reduce_power(trans, capa);
 
 	iwl_init_notification_wait(notif_wait, &pnvm_wait,
 				   ntf_cmds, ARRAY_SIZE(ntf_cmds),
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
index 7e7d135e85b1..96bf353469b8 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
@@ -98,9 +98,9 @@ struct iwl_prph_scratch_control {
 } __packed; /* PERIPH_SCRATCH_CONTROL_S */
 
 /*
- * struct iwl_prph_scratch_pnvm_cfg - ror config
+ * struct iwl_prph_scratch_pnvm_cfg - PNVM scratch
  * @pnvm_base_addr: PNVM start address
- * @pnvm_size: PNVM size in DWs
+ * @pnvm_size: the size of the PNVM image in bytes
  * @reserved: reserved
  */
 struct iwl_prph_scratch_pnvm_cfg {
@@ -142,7 +142,7 @@ struct iwl_prph_scratch_rbd_cfg {
 /*
  * struct iwl_prph_scratch_uefi_cfg - prph scratch reduce power table
  * @base_addr: reduce power table address
- * @size: table size in dwords
+ * @size: the size of the entire power table image
  */
 struct iwl_prph_scratch_uefi_cfg {
 	__le64 base_addr;
@@ -292,10 +292,13 @@ int iwl_trans_pcie_ctx_info_gen3_load_pnvm(struct iwl_trans *trans,
 					   const struct iwl_ucode_capabilities *capa);
 void iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans,
 					   const struct iwl_ucode_capabilities *capa);
-int iwl_trans_pcie_ctx_info_gen3_load_reduce_power
-				(struct iwl_trans *trans,
-				 const struct iwl_pnvm_image *payloads);
-void iwl_trans_pcie_ctx_info_gen3_set_reduce_power(struct iwl_trans *trans);
+int
+iwl_trans_pcie_ctx_info_gen3_load_reduce_power(struct iwl_trans *trans,
+					       const struct iwl_pnvm_image *payloads,
+					       const struct iwl_ucode_capabilities *capa);
+void
+iwl_trans_pcie_ctx_info_gen3_set_reduce_power(struct iwl_trans *trans,
+					      const struct iwl_ucode_capabilities *capa);
 int iwl_trans_pcie_ctx_info_gen3_set_step(struct iwl_trans *trans,
 					  u32 mbx_addr_0_step, u32 mbx_addr_1_step);
 #endif /* __iwl_context_info_file_gen3_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 8e9585d3a0ee..61ee6c1f4a1e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -641,8 +641,10 @@ struct iwl_trans_ops {
 	void (*set_pnvm)(struct iwl_trans *trans,
 			 const struct iwl_ucode_capabilities *capa);
 	int (*load_reduce_power)(struct iwl_trans *trans,
-				 const struct iwl_pnvm_image *payloads);
-	void (*set_reduce_power)(struct iwl_trans *trans);
+				 const struct iwl_pnvm_image *payloads,
+				 const struct iwl_ucode_capabilities *capa);
+	void (*set_reduce_power)(struct iwl_trans *trans,
+				 const struct iwl_ucode_capabilities *capa);
 
 	void (*interrupts)(struct iwl_trans *trans, bool enable);
 	int (*imr_dma_data)(struct iwl_trans *trans,
@@ -731,6 +733,19 @@ struct iwl_dram_data {
 	int size;
 };
 
+/**
+ * @drams: array of several DRAM areas that contains the pnvm and power
+ *	reduction table payloads.
+ * @n_regions: number of DRAM regions that were allocated
+ * @prph_scratch_mem_desc: points to a structure allocated in dram,
+ *	designed to show FW where all the payloads are.
+ */
+struct iwl_dram_regions {
+	struct iwl_dram_data drams[IPC_DRAM_MAP_ENTRY_NUM_MAX];
+	struct iwl_dram_data prph_scratch_mem_desc;
+	u8 n_regions;
+};
+
 /**
  * struct iwl_fw_mon - fw monitor per allocation id
  * @num_frags: number of fragments
@@ -1560,15 +1575,18 @@ static inline void iwl_trans_set_pnvm(struct iwl_trans *trans,
 
 static inline int iwl_trans_load_reduce_power
 				(struct iwl_trans *trans,
-				 const struct iwl_pnvm_image *payloads)
+				 const struct iwl_pnvm_image *payloads,
+				 const struct iwl_ucode_capabilities *capa)
 {
-	return trans->ops->load_reduce_power(trans, payloads);
+	return trans->ops->load_reduce_power(trans, payloads, capa);
 }
 
-static inline void iwl_trans_set_reduce_power(struct iwl_trans *trans)
+static inline void
+iwl_trans_set_reduce_power(struct iwl_trans *trans,
+			   const struct iwl_ucode_capabilities *capa)
 {
 	if (trans->ops->set_reduce_power)
-		trans->ops->set_reduce_power(trans);
+		trans->ops->set_reduce_power(trans, capa);
 }
 
 static inline bool iwl_trans_dbg_ini_valid(struct iwl_trans *trans)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index 26d5ba777d24..fa4a14546860 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 #include "iwl-trans.h"
 #include "iwl-fh.h"
@@ -317,11 +317,11 @@ static int iwl_pcie_load_payloads_continuously(struct iwl_trans *trans,
 
 static int iwl_pcie_load_payloads_segments
 				(struct iwl_trans *trans,
+				 struct iwl_dram_regions *dram_regions,
 				 const struct iwl_pnvm_image *pnvm_data)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwl_dram_data *cur_pnvm_dram = &trans_pcie->pnvm_dram[0],
-			     *desc_dram = &trans_pcie->pnvm_regions_desc_array;
+	struct iwl_dram_data *cur_payload_dram = &dram_regions->drams[0];
+	struct iwl_dram_data *desc_dram = &dram_regions->prph_scratch_mem_desc;
 	struct iwl_prph_scrath_mem_desc_addr_array *addresses;
 	const void *data;
 	u32 len;
@@ -341,30 +341,31 @@ static int iwl_pcie_load_payloads_segments
 	memset(desc_dram->block, 0, len);
 
 	/* allocate DRAM region for each payload */
-	trans_pcie->n_pnvm_regions = 0;
+	dram_regions->n_regions = 0;
 	for (i = 0; i < pnvm_data->n_chunks; i++) {
 		len = pnvm_data->chunks[i].len;
 		data = pnvm_data->chunks[i].data;
 
-		if (iwl_pcie_ctxt_info_alloc_dma(trans, data, len,
-						 cur_pnvm_dram)) {
-			iwl_trans_pcie_free_pnvm_dram(trans_pcie, trans->dev);
+		if (iwl_pcie_ctxt_info_alloc_dma(trans,
+						 data,
+						 len,
+						 cur_payload_dram)) {
+			iwl_trans_pcie_free_pnvm_dram_regions(dram_regions,
+							      trans->dev);
 			return -ENOMEM;
 		}
 
-		trans_pcie->n_pnvm_regions++;
-		cur_pnvm_dram++;
+		dram_regions->n_regions++;
+		cur_payload_dram++;
 	}
 
 	/* fill desc with the DRAM payloads addresses */
 	addresses = desc_dram->block;
-
 	for (i = 0; i < pnvm_data->n_chunks; i++) {
 		addresses->mem_descs[i] =
-			cpu_to_le64(trans_pcie->pnvm_dram[i].physical);
+			cpu_to_le64(dram_regions->drams[i].physical);
 	}
 
-	trans->pnvm_loaded = true;
 	return 0;
 
 }
@@ -376,7 +377,7 @@ int iwl_trans_pcie_ctx_info_gen3_load_pnvm(struct iwl_trans *trans,
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_prph_scratch_ctrl_cfg *prph_sc_ctrl =
 		&trans_pcie->prph_scratch->ctrl_cfg;
-	struct iwl_dram_data *dram = &trans_pcie->pnvm_dram[0];
+	struct iwl_dram_regions *dram_regions = &trans_pcie->pnvm_data;
 	int ret = 0;
 
 	/* only allocate the DRAM if not allocated yet */
@@ -394,28 +395,51 @@ int iwl_trans_pcie_ctx_info_gen3_load_pnvm(struct iwl_trans *trans,
 		return -EINVAL;
 	}
 
-	/* allocate several DRAM sections */
-	if (fw_has_capa(capa, IWL_UCODE_TLV_CAPA_FRAGMENTED_PNVM_IMG))
-		return iwl_pcie_load_payloads_segments(trans, pnvm_payloads);
-
-	/* allocate one DRAM section */
-	ret = iwl_pcie_load_payloads_continuously(trans, pnvm_payloads, dram);
-	if (!ret) {
-		trans_pcie->n_pnvm_regions = 1;
-		trans->pnvm_loaded = true;
+	/* save payloads in several DRAM sections */
+	if (fw_has_capa(capa, IWL_UCODE_TLV_CAPA_FRAGMENTED_PNVM_IMG)) {
+		ret = iwl_pcie_load_payloads_segments(trans,
+						      dram_regions,
+						      pnvm_payloads);
+		if (!ret)
+			trans->pnvm_loaded = true;
+	} else {
+		/* save only in one DRAM section */
+		ret = iwl_pcie_load_payloads_continuously
+						(trans,
+						 pnvm_payloads,
+						 &dram_regions->drams[0]);
+		if (!ret) {
+			dram_regions->n_regions = 1;
+			trans->pnvm_loaded = true;
+		}
 	}
 
 	return ret;
 }
 
+static inline size_t
+iwl_dram_regions_size(const struct iwl_dram_regions *dram_regions)
+{
+	size_t total_size = 0;
+	int i;
+
+	for (i = 0; i < dram_regions->n_regions; i++)
+		total_size += dram_regions->drams[i].size;
+
+	return total_size;
+}
+
 static void iwl_pcie_set_pnvm_segments(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_prph_scratch_ctrl_cfg *prph_sc_ctrl =
 		&trans_pcie->prph_scratch->ctrl_cfg;
+	struct iwl_dram_regions *dram_regions = &trans_pcie->pnvm_data;
 
 	prph_sc_ctrl->pnvm_cfg.pnvm_base_addr =
-		cpu_to_le64(trans_pcie->pnvm_regions_desc_array.physical);
+		cpu_to_le64(dram_regions->prph_scratch_mem_desc.physical);
+	prph_sc_ctrl->pnvm_cfg.pnvm_size =
+		cpu_to_le32(iwl_dram_regions_size(dram_regions));
 }
 
 static void iwl_pcie_set_continuous_pnvm(struct iwl_trans *trans)
@@ -425,9 +449,9 @@ static void iwl_pcie_set_continuous_pnvm(struct iwl_trans *trans)
 		&trans_pcie->prph_scratch->ctrl_cfg;
 
 	prph_sc_ctrl->pnvm_cfg.pnvm_base_addr =
-		cpu_to_le64(trans_pcie->pnvm_dram[0].physical);
+		cpu_to_le64(trans_pcie->pnvm_data.drams[0].physical);
 	prph_sc_ctrl->pnvm_cfg.pnvm_size =
-		cpu_to_le32(trans_pcie->pnvm_dram[0].size);
+		cpu_to_le32(trans_pcie->pnvm_data.drams[0].size);
 }
 
 void iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans,
@@ -443,12 +467,18 @@ void iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans,
 }
 
 int iwl_trans_pcie_ctx_info_gen3_load_reduce_power(struct iwl_trans *trans,
-						   const struct iwl_pnvm_image *payloads)
+						   const struct iwl_pnvm_image *payloads,
+						   const struct iwl_ucode_capabilities *capa)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_prph_scratch_ctrl_cfg *prph_sc_ctrl =
 		&trans_pcie->prph_scratch->ctrl_cfg;
-	struct iwl_dram_data *dram = &trans_pcie->reduce_power_dram;
+	struct iwl_dram_regions *dram_regions = &trans_pcie->reduced_tables_data;
+	int ret = 0;
+
+	/* only allocate the DRAM if not allocated yet */
+	if (trans->reduce_power_loaded)
+		return 0;
 
 	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		return 0;
@@ -456,26 +486,68 @@ int iwl_trans_pcie_ctx_info_gen3_load_reduce_power(struct iwl_trans *trans,
 	if (WARN_ON(prph_sc_ctrl->reduce_power_cfg.size))
 		return -EBUSY;
 
-	/* only allocate the DRAM if not allocated yet */
-	if (!trans->reduce_power_loaded)
-		return iwl_pcie_load_payloads_continuously(trans,
-							   payloads,
-							   dram);
-	return 0;
+	if (!payloads->n_chunks) {
+		IWL_DEBUG_FW(trans, "no payloads\n");
+		return -EINVAL;
+	}
+
+	/* save payloads in several DRAM sections */
+	if (fw_has_capa(capa, IWL_UCODE_TLV_CAPA_FRAGMENTED_PNVM_IMG)) {
+		ret = iwl_pcie_load_payloads_segments(trans,
+						      dram_regions,
+						      payloads);
+		if (!ret)
+			trans->reduce_power_loaded = true;
+	} else {
+		/* save only in one DRAM section */
+		ret = iwl_pcie_load_payloads_continuously
+						(trans,
+						 payloads,
+						 &dram_regions->drams[0]);
+		if (!ret) {
+			dram_regions->n_regions = 1;
+			trans->reduce_power_loaded = true;
+		}
+	}
+
+	return ret;
 }
 
-void iwl_trans_pcie_ctx_info_gen3_set_reduce_power(struct iwl_trans *trans)
+static void iwl_pcie_set_reduce_power_segments(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_prph_scratch_ctrl_cfg *prph_sc_ctrl =
 		&trans_pcie->prph_scratch->ctrl_cfg;
+	struct iwl_dram_regions *dram_regions = &trans_pcie->reduced_tables_data;
 
-	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
-		return;
+	prph_sc_ctrl->reduce_power_cfg.base_addr =
+		cpu_to_le64(dram_regions->prph_scratch_mem_desc.physical);
+	prph_sc_ctrl->reduce_power_cfg.size =
+		cpu_to_le32(iwl_dram_regions_size(dram_regions));
+}
+
+static void iwl_pcie_set_continuous_reduce_power(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwl_prph_scratch_ctrl_cfg *prph_sc_ctrl =
+		&trans_pcie->prph_scratch->ctrl_cfg;
 
 	prph_sc_ctrl->reduce_power_cfg.base_addr =
-		cpu_to_le64(trans_pcie->reduce_power_dram.physical);
+		cpu_to_le64(trans_pcie->reduced_tables_data.drams[0].physical);
 	prph_sc_ctrl->reduce_power_cfg.size =
-		cpu_to_le32(trans_pcie->reduce_power_dram.size);
+		cpu_to_le32(trans_pcie->reduced_tables_data.drams[0].size);
+}
+
+void
+iwl_trans_pcie_ctx_info_gen3_set_reduce_power(struct iwl_trans *trans,
+					      const struct iwl_ucode_capabilities *capa)
+{
+	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
+		return;
+
+	if (fw_has_capa(capa, IWL_UCODE_TLV_CAPA_FRAGMENTED_PNVM_IMG))
+		iwl_pcie_set_reduce_power_segments(trans);
+	else
+		iwl_pcie_set_continuous_reduce_power(trans);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index d10f25da0eec..0adcf0e13e85 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -307,10 +307,9 @@ enum iwl_pcie_imr_status {
  * @trans: pointer to the generic transport area
  * @scd_base_addr: scheduler sram base address in SRAM
  * @kw: keep warm address
- * @pnvm_dram: array of several DRAM areas that contains the PNVM data
- * @n_pnvm_regions: number of DRAM regions that were allocated for the pnvm
- * @pnvm_regions_desc_array: array of PNVM payloads addresses.
- *	allocated in DRAM and sent to FW.
+ * @pnvm_data: holds info about pnvm payloads allocated in DRAM
+ * @reduced_tables_data: holds info about power reduced tablse
+ *	payloads allocated in DRAM
  * @pci_dev: basic pci-network driver stuff
  * @hw_base: pci hardware address support
  * @ucode_write_complete: indicates that the ucode has been copied.
@@ -385,10 +384,8 @@ struct iwl_trans_pcie {
 	struct iwl_dma_ptr kw;
 
 	/* pnvm data */
-	struct iwl_dram_data pnvm_dram[IPC_DRAM_MAP_ENTRY_NUM_MAX];
-	u8 n_pnvm_regions;
-	struct iwl_dram_data pnvm_regions_desc_array;
-	struct iwl_dram_data reduce_power_dram;
+	struct iwl_dram_regions pnvm_data;
+	struct iwl_dram_regions reduced_tables_data;
 
 	struct iwl_txq *txq_memory;
 
@@ -485,8 +482,8 @@ struct iwl_trans
 		      const struct pci_device_id *ent,
 		      const struct iwl_cfg_trans_params *cfg_trans);
 void iwl_trans_pcie_free(struct iwl_trans *trans);
-void iwl_trans_pcie_free_pnvm_dram(struct iwl_trans_pcie *trans_pcie,
-				   struct device *dev);
+void iwl_trans_pcie_free_pnvm_dram_regions(struct iwl_dram_regions *dram_regions,
+					   struct device *dev);
 
 bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans);
 #define _iwl_trans_pcie_grab_nic_access(trans)			\
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 55541c1be5d6..70e8c20fb9b9 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1993,25 +1993,27 @@ static void iwl_trans_pcie_configure(struct iwl_trans *trans,
 	trans_pcie->fw_reset_handshake = trans_cfg->fw_reset_handshake;
 }
 
-void iwl_trans_pcie_free_pnvm_dram(struct iwl_trans_pcie *trans_pcie,
-				   struct device *dev)
+void iwl_trans_pcie_free_pnvm_dram_regions(struct iwl_dram_regions *dram_regions,
+					   struct device *dev)
 {
 	u8 i;
-	struct iwl_dram_data *desc_dram = &trans_pcie->pnvm_regions_desc_array;
+	struct iwl_dram_data *desc_dram = &dram_regions->prph_scratch_mem_desc;
 
-	for (i = 0; i < trans_pcie->n_pnvm_regions; i++) {
-		dma_free_coherent(dev, trans_pcie->pnvm_dram[i].size,
-				  trans_pcie->pnvm_dram[i].block,
-				  trans_pcie->pnvm_dram[i].physical);
+	/* free DRAM payloads */
+	for (i = 0; i < dram_regions->n_regions; i++) {
+		dma_free_coherent(dev, dram_regions->drams[i].size,
+				  dram_regions->drams[i].block,
+				  dram_regions->drams[i].physical);
 	}
-	trans_pcie->n_pnvm_regions = 0;
+	dram_regions->n_regions = 0;
 
+	/* free DRAM addresses array */
 	if (desc_dram->block) {
 		dma_free_coherent(dev, desc_dram->size,
 				  desc_dram->block,
 				  desc_dram->physical);
 	}
-	desc_dram->block = NULL;
+	memset(desc_dram, 0, sizeof(*desc_dram));
 }
 
 void iwl_trans_pcie_free(struct iwl_trans *trans)
@@ -2046,13 +2048,10 @@ void iwl_trans_pcie_free(struct iwl_trans *trans)
 
 	iwl_pcie_free_fw_monitor(trans);
 
-	iwl_trans_pcie_free_pnvm_dram(trans_pcie, trans->dev);
-
-	if (trans_pcie->reduce_power_dram.size)
-		dma_free_coherent(trans->dev,
-				  trans_pcie->reduce_power_dram.size,
-				  trans_pcie->reduce_power_dram.block,
-				  trans_pcie->reduce_power_dram.physical);
+	iwl_trans_pcie_free_pnvm_dram_regions(&trans_pcie->pnvm_data,
+					      trans->dev);
+	iwl_trans_pcie_free_pnvm_dram_regions(&trans_pcie->reduced_tables_data,
+					      trans->dev);
 
 	mutex_destroy(&trans_pcie->mutex);
 	iwl_trans_free(trans);
-- 
2.38.1

