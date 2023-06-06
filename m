Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF549723A67
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 09:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbjFFHtX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 03:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236384AbjFFHsZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 03:48:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9B3198A
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 00:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686037459; x=1717573459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zjPDp/gHoN2HMGgOMIDuL58oiF3aJ6w8D/nBZA5oB+0=;
  b=l4HROv/DyJalk3dVA4kpiDTOkDfRX4WGawjgt2yQgSUjI7VEOOpzRSGh
   0Ge+of11wJK3SkyS9whmEcOr7ylhgjw4aQDcdKxNzt088FPL65Nchvmuc
   7djpoIE5v4JCTubjj/pxNc4NaJFC6RIYfpBuFETSdIPmoca/1iJhRAphN
   s4CYvooI1y/sQLOYWer5T0jptC7Sdjcnce0vfC7hVikAjUdeNFeTB+tgC
   Hqo/czuIoI8bcWOv0szvzDKj41omU5ULFpjTFt+emItybUUfMmXI4mUtb
   dDc2NdZisBLnKBqk+Y28v+S3SQPsCV337OqM97R9JKNifm5GCPHuDBTwS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="422419065"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="422419065"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:43:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821516281"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="821516281"
Received: from oniamir-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.217.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:43:30 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alon Giladi <alon.giladi@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/13] wifi: iwlwifi: Allow trans_pcie track more than 1 pnvm DRAM region
Date:   Tue,  6 Jun 2023 10:43:01 +0300
Message-Id: <20230606103519.bb206d71bf45.I627640701757bb2f234f8e18a3afbd6af1206658@changeid>
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

Change the field pnvm_dram to an array that describes many regions
and add a counter to the number of pnvm regions that were allocated
in DRAM.

Signed-off-by: Alon Giladi <alon.giladi@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c        | 13 +++++++++----
 .../net/wireless/intel/iwlwifi/pcie/internal.h | 10 ++++++++--
 .../net/wireless/intel/iwlwifi/pcie/trans.c    | 18 ++++++++++++++----
 3 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index e9f3799d4593..f43246b45a85 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -287,7 +287,7 @@ int iwl_trans_pcie_ctx_info_gen3_load_pnvm(struct iwl_trans *trans,
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_prph_scratch_ctrl_cfg *prph_sc_ctrl =
 		&trans_pcie->prph_scratch->ctrl_cfg;
-	struct iwl_dram_data *dram = &trans_pcie->pnvm_dram;
+	struct iwl_dram_data *dram = &trans_pcie->pnvm_dram[0];
 	u32 len, len0, len1;
 
 	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
@@ -324,6 +324,7 @@ int iwl_trans_pcie_ctx_info_gen3_load_pnvm(struct iwl_trans *trans,
 	dram->size = len;
 	memcpy(dram->block, pnvm_payloads->chunks[0].data, len0);
 	memcpy((u8 *)dram->block + len0, pnvm_payloads->chunks[1].data, len1);
+	trans_pcie->n_pnvm_regions = 1;
 
 	trans->pnvm_loaded = true;
 	return 0;
@@ -337,11 +338,15 @@ void iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans)
 
 	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		return;
-
+	/* FIXME: currently we concatenate payloads and save them only in
+	 * pnvm_dram[0] - therefor only pnvm_dram[0] is delivered to the
+	 * prph_sc. Need to add a UCODE sensitivity and another case in which
+	 * we deliver to the prph_sc an array with all the DRAM addresses.
+	 */
 	prph_sc_ctrl->pnvm_cfg.pnvm_base_addr =
-		cpu_to_le64(trans_pcie->pnvm_dram.physical);
+		cpu_to_le64(trans_pcie->pnvm_dram[0].physical);
 	prph_sc_ctrl->pnvm_cfg.pnvm_size =
-		cpu_to_le32(trans_pcie->pnvm_dram.size);
+		cpu_to_le32(trans_pcie->pnvm_dram[0].size);
 
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 69b95ad5993b..ca2e7bb2def8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -23,6 +23,7 @@
 #include "iwl-op-mode.h"
 #include "iwl-drv.h"
 #include "queue/tx.h"
+#include "iwl-context-info.h"
 
 /*
  * RX related structures and functions
@@ -306,7 +307,8 @@ enum iwl_pcie_imr_status {
  * @trans: pointer to the generic transport area
  * @scd_base_addr: scheduler sram base address in SRAM
  * @kw: keep warm address
- * @pnvm_dram: DRAM area that contains the PNVM data
+ * @pnvm_dram: array of several DRAM areas that contains the PNVM data
+ * @n_pnvm_regions: number of DRAM regions that were allocated for the pnvm
  * @pci_dev: basic pci-network driver stuff
  * @hw_base: pci hardware address support
  * @ucode_write_complete: indicates that the ucode has been copied.
@@ -380,7 +382,9 @@ struct iwl_trans_pcie {
 	u32 scd_base_addr;
 	struct iwl_dma_ptr kw;
 
-	struct iwl_dram_data pnvm_dram;
+	/* pnvm data */
+	struct iwl_dram_data pnvm_dram[IPC_DRAM_MAP_ENTRY_NUM_MAX];
+	u8 n_pnvm_regions;
 	struct iwl_dram_data reduce_power_dram;
 
 	struct iwl_txq *txq_memory;
@@ -478,6 +482,8 @@ struct iwl_trans
 		      const struct pci_device_id *ent,
 		      const struct iwl_cfg_trans_params *cfg_trans);
 void iwl_trans_pcie_free(struct iwl_trans *trans);
+void iwl_trans_pcie_free_pnvm_dram(struct iwl_trans_pcie *trans_pcie,
+				   struct device *dev);
 
 bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans);
 #define _iwl_trans_pcie_grab_nic_access(trans)			\
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 6691d89d7226..cd177addd884 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1993,6 +1993,19 @@ static void iwl_trans_pcie_configure(struct iwl_trans *trans,
 	trans_pcie->fw_reset_handshake = trans_cfg->fw_reset_handshake;
 }
 
+void iwl_trans_pcie_free_pnvm_dram(struct iwl_trans_pcie *trans_pcie,
+				   struct device *dev)
+{
+	u8 i;
+
+	for (i = 0; i < trans_pcie->n_pnvm_regions; i++) {
+		dma_free_coherent(dev, trans_pcie->pnvm_dram[i].size,
+				  trans_pcie->pnvm_dram[i].block,
+				  trans_pcie->pnvm_dram[i].physical);
+	}
+	trans_pcie->n_pnvm_regions = 0;
+}
+
 void iwl_trans_pcie_free(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
@@ -2025,10 +2038,7 @@ void iwl_trans_pcie_free(struct iwl_trans *trans)
 
 	iwl_pcie_free_fw_monitor(trans);
 
-	if (trans_pcie->pnvm_dram.size)
-		dma_free_coherent(trans->dev, trans_pcie->pnvm_dram.size,
-				  trans_pcie->pnvm_dram.block,
-				  trans_pcie->pnvm_dram.physical);
+	iwl_trans_pcie_free_pnvm_dram(trans_pcie, trans->dev);
 
 	if (trans_pcie->reduce_power_dram.size)
 		dma_free_coherent(trans->dev,
-- 
2.38.1

