Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03311723A69
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 09:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbjFFHtk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 03:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236853AbjFFHsg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 03:48:36 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9625C19A0
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 00:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686037466; x=1717573466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nb5y6TEnmhMl2RlyUAIhLImAAxjxvC5uNBSuWKppOlM=;
  b=WcuuuYKzU2mGLcEcF1EKRx9FqsFYjrxBnOzE3JPfateReUF0KIvd+3lq
   4EOOZzIWZtQ6fgKSKQiL2FPGMf69grj6vG1diU1mjFMUPvh0S6cezstNw
   Th3HTnuuzSAqHM0jADSmSZoQKXUvdaa13inXt7WGxRQkK3+xGsno34cOz
   yDsSoiqC1PU03xSJsJQijQBn8kvFBcicrztvNtFQ3ZM7zMX7HjJK1WG5+
   QKZAG2CJDxION6TAzRd5mU0PcM7z69qRRze3Sm9VGaWlcf3z8i9GXZOOm
   1RkMENiPaIKqDUv1BiNvf6PN+9P16xb5nRpYSZD3l8Ti+ZWH6I9mESSgx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="422419079"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="422419079"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:43:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821516311"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="821516311"
Received: from oniamir-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.217.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:43:34 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alon Giladi <alon.giladi@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/13] wifi: iwlwifi: Implement loading and setting of fragmented pnvm image
Date:   Tue,  6 Jun 2023 10:43:03 +0300
Message-Id: <20230606103519.dbdad8995ce1.I986213527982637042532de3851a1bd8a11be87a@changeid>
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

Save the pnvm payloads in several DRAM segments (not only in one as
used to). In addition, allocate a FW structure in DRAM that holds the
segments' addresses and forward its address to the FW. It's done when
FW has the capability to handle pnvm images this way (helps to process
large pnvm images).

Signed-off-by: Alon Giladi <alon.giladi@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../intel/iwlwifi/iwl-context-info-gen3.h     |  8 ++
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       | 73 +++++++++++++++++--
 .../wireless/intel/iwlwifi/pcie/internal.h    |  3 +
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  8 ++
 4 files changed, 86 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
index 23208be831f3..bbf4b18cd9de 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
@@ -109,6 +109,14 @@ struct iwl_prph_scratch_pnvm_cfg {
 	__le32 reserved;
 } __packed; /* PERIPH_SCRATCH_PNVM_CFG_S */
 
+/**
+ * struct iwl_prph_scrath_mem_desc_addr_array
+ * @mem_descs: array of dram addresses.
+ * Each address is the beggining of a pnvm payload.
+ */
+struct iwl_prph_scrath_mem_desc_addr_array {
+	__le64 mem_descs[IPC_DRAM_MAP_ENTRY_NUM_MAX];
+} __packed; /* PERIPH_SCRATCH_MEM_DESC_ADDR_ARRAY_S_VER_1 */
 /*
  * struct iwl_prph_scratch_hwm_cfg - hwm config
  * @hwm_base_addr: hwm start address
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index fc450c0d1145..e0477ca4ccc3 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -315,11 +315,58 @@ static int iwl_pcie_load_payloads_continuously(struct iwl_trans *trans,
 	return 0;
 }
 
-/* FIXME: An implementation will be added with the next several commits. */
-static int iwl_pcie_load_payloads_segments(struct iwl_trans *trans,
-					   const struct iwl_pnvm_image *pnvm_payloads)
+static int iwl_pcie_load_payloads_segments
+				(struct iwl_trans *trans,
+				 const struct iwl_pnvm_image *pnvm_data)
 {
-	return -ENOMEM;
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwl_dram_data *cur_pnvm_dram = &trans_pcie->pnvm_dram[0],
+			     *desc_dram = &trans_pcie->pnvm_regions_desc_array;
+	struct iwl_prph_scrath_mem_desc_addr_array *addresses;
+	const void *data;
+	u32 len;
+	int i;
+
+	/* allocate and init DRAM descriptors array */
+	len = sizeof(struct iwl_prph_scrath_mem_desc_addr_array);
+	desc_dram->block = iwl_pcie_ctxt_info_dma_alloc_coherent
+						(trans,
+						 len,
+						 &desc_dram->physical);
+	if (!desc_dram->block) {
+		IWL_DEBUG_FW(trans, "Failed to allocate PNVM DMA.\n");
+		return -ENOMEM;
+	}
+	desc_dram->size = len;
+	memset(desc_dram->block, 0, len);
+
+	/* allocate DRAM region for each payload */
+	trans_pcie->n_pnvm_regions = 0;
+	for (i = 0; i < pnvm_data->n_chunks; i++) {
+		len = pnvm_data->chunks[i].len;
+		data = pnvm_data->chunks[i].data;
+
+		if (iwl_pcie_ctxt_info_alloc_dma(trans, data, len,
+						 cur_pnvm_dram)) {
+			iwl_trans_pcie_free_pnvm_dram(trans_pcie, trans->dev);
+			return -ENOMEM;
+		}
+
+		trans_pcie->n_pnvm_regions++;
+		cur_pnvm_dram++;
+	}
+
+	/* fill desc with the DRAM payloads addresses */
+	addresses = desc_dram->block;
+
+	for (i = 0; i < pnvm_data->n_chunks; i++) {
+		addresses->mem_descs[i] =
+			cpu_to_le64(trans_pcie->pnvm_dram[i].physical);
+	}
+
+	trans->pnvm_loaded = true;
+	return 0;
+
 }
 
 int iwl_trans_pcie_ctx_info_gen3_load_pnvm(struct iwl_trans *trans,
@@ -342,9 +389,16 @@ int iwl_trans_pcie_ctx_info_gen3_load_pnvm(struct iwl_trans *trans,
 	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		return 0;
 
+	if (!pnvm_payloads->n_chunks) {
+		IWL_DEBUG_FW(trans, "no payloads\n");
+		return -EINVAL;
+	}
+
+	/* allocate several DRAM sections */
 	if (fw_has_capa(capa, IWL_UCODE_TLV_CAPA_FRAGMENTED_PNVM_IMG))
 		return iwl_pcie_load_payloads_segments(trans, pnvm_payloads);
 
+	/* allocate one DRAM section */
 	ret = iwl_pcie_load_payloads_continuously(trans, pnvm_payloads, dram);
 	if (!ret) {
 		trans_pcie->n_pnvm_regions = 1;
@@ -354,8 +408,15 @@ int iwl_trans_pcie_ctx_info_gen3_load_pnvm(struct iwl_trans *trans,
 	return ret;
 }
 
-/* FIXME: An implementation will be added with the next several commits. */
-static void iwl_pcie_set_pnvm_segments(struct iwl_trans *trans) {}
+static void iwl_pcie_set_pnvm_segments(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwl_prph_scratch_ctrl_cfg *prph_sc_ctrl =
+		&trans_pcie->prph_scratch->ctrl_cfg;
+
+	prph_sc_ctrl->pnvm_cfg.pnvm_base_addr =
+		cpu_to_le64(trans_pcie->pnvm_regions_desc_array.physical);
+}
 
 static void iwl_pcie_set_continuous_pnvm(struct iwl_trans *trans)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index ca2e7bb2def8..d10f25da0eec 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -309,6 +309,8 @@ enum iwl_pcie_imr_status {
  * @kw: keep warm address
  * @pnvm_dram: array of several DRAM areas that contains the PNVM data
  * @n_pnvm_regions: number of DRAM regions that were allocated for the pnvm
+ * @pnvm_regions_desc_array: array of PNVM payloads addresses.
+ *	allocated in DRAM and sent to FW.
  * @pci_dev: basic pci-network driver stuff
  * @hw_base: pci hardware address support
  * @ucode_write_complete: indicates that the ucode has been copied.
@@ -385,6 +387,7 @@ struct iwl_trans_pcie {
 	/* pnvm data */
 	struct iwl_dram_data pnvm_dram[IPC_DRAM_MAP_ENTRY_NUM_MAX];
 	u8 n_pnvm_regions;
+	struct iwl_dram_data pnvm_regions_desc_array;
 	struct iwl_dram_data reduce_power_dram;
 
 	struct iwl_txq *txq_memory;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index cd177addd884..5235a7517c53 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1997,6 +1997,7 @@ void iwl_trans_pcie_free_pnvm_dram(struct iwl_trans_pcie *trans_pcie,
 				   struct device *dev)
 {
 	u8 i;
+	struct iwl_dram_data *desc_dram = &trans_pcie->pnvm_regions_desc_array;
 
 	for (i = 0; i < trans_pcie->n_pnvm_regions; i++) {
 		dma_free_coherent(dev, trans_pcie->pnvm_dram[i].size,
@@ -2004,6 +2005,13 @@ void iwl_trans_pcie_free_pnvm_dram(struct iwl_trans_pcie *trans_pcie,
 				  trans_pcie->pnvm_dram[i].physical);
 	}
 	trans_pcie->n_pnvm_regions = 0;
+
+	if (desc_dram->block) {
+		dma_free_coherent(dev, desc_dram->size,
+				  desc_dram->block,
+				  desc_dram->physical);
+	}
+	desc_dram->block = NULL;
 }
 
 void iwl_trans_pcie_free(struct iwl_trans *trans)
-- 
2.38.1

